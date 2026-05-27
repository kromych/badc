//! Shared `sizeof` operand-parsing logic.
//!
//! Both the runtime `sizeof` primary (`compiler/mod.rs`) and the
//! constant-expression `sizeof` (`compiler/const_expr.rs`) need
//! to disambiguate the same three operand shapes:
//!
//!   1. `sizeof(<type-name>)` -- a type, optionally with `*`s.
//!   2. `sizeof(<id>)` / `sizeof <id>` -- a bare identifier
//!      (array or scalar). Looked up directly so an array uses
//!      its total byte count rather than the decayed pointer's
//!      `sizeof(T*) = 8`.
//!   3. `sizeof <expr>` -- everything else (`sizeof(p->field)`,
//!      `sizeof(arr[i])`, `sizeof(*p)`, ...). Falls back to the
//!      regular expression parser, drops the emitted code (the
//!      operand is unevaluated per C99 6.5.3.4), and picks up
//!      the type plus any multi-dim row-size hint from the
//!      side-channel set by the array-decay paths.
//!
//! Returns the byte count; the caller emits the immediate /
//! updates `self.ty` as it sees fit. `self.ty` is saved across
//! the helper so both call sites see the same pre-sizeof state
//! on return.

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;

impl Compiler {
    /// Parse the operand of a `sizeof` and return its byte
    /// count. The `sizeof` keyword has already been consumed.
    pub(super) fn sizeof_operand_bytes(&mut self) -> Result<i64, C5Error> {
        // Snapshot the lex state before any speculative paren
        // consumption so the operand-shape dispatch below can
        // restore when `sizeof (expr)->m` turns out to wrap the
        // outer parens around a unary-expression rather than a
        // type-name. C99 6.5.3.4 admits two operand shapes:
        // `sizeof unary-expression` and `sizeof ( type-name )`;
        // an eagerly-consumed `(` for the latter has to be put
        // back when it really belongs to the former so any
        // trailing postfix (`->`, `.`, `[`) stays attached to
        // the unary-expression instead of dangling against the
        // surrounding `int` result.
        let pre_paren_snap = self.lex.snapshot();
        let leading_paren = self.lex.tk == '(';
        if leading_paren {
            self.next()?;
        }
        let saved_ty = self.ty;
        // `had_paren` is the "sizeof actually owns this paren and
        // will consume the matching `)` at the end" tracker. It
        // starts equal to `leading_paren` and is cleared in the
        // general-expression branch when the inner content turns
        // out to be a unary-expression rather than a type-name --
        // in that case the paren belongs to the operand and is
        // matched by the regular parser's `(` -> `)` rule.
        let mut had_paren = leading_paren;
        let total: i64 = if had_paren && self.lex_is_type_start() {
            // sizeof(<type>): parse a type name with optional
            // pointer decoration and return its size. C99 6.5.3.4
            // paragraph 4: the result on an array type is the total
            // number of bytes, so an array typedef (jmp_buf etc.)
            // must report `dim * sizeof(element)`. The array
            // dimension rides through on `typedef_base_array_size`
            // (set by `parse_decl_base_type` when the typedef
            // resolves to an array); pointer decoration collapses
            // the type to a scalar pointer and drops the dim.
            self.ty = self.parse_decl_base_type()?;
            let typedef_dim = core::mem::take(&mut self.pending.typedef_base_array_size);
            let mut decayed_to_ptr = false;
            while self.lex.tk == Token::MulOp {
                self.next()?;
                self.ty += Ty::Ptr as i64;
                decayed_to_ptr = true;
                while self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
            }
            let elem_size = self.size_of_type(self.ty) as i64;
            if typedef_dim > 0 && !decayed_to_ptr {
                typedef_dim * elem_size
            } else {
                elem_size
            }
        } else if self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].class != 0
            && !self.lex.peek_after_whitespace(b'-')
            && !self.lex.peek_after_whitespace(b'.')
            && !self.lex.peek_after_whitespace(b'[')
            && (!had_paren || self.lex.peek_after_whitespace(b')'))
        {
            // Bare identifier: short-circuit symbol lookup so an
            // array variable uses its `array_size * sizeof(elem)`
            // total rather than the decayed pointer. Scalars fall
            // through to `size_of_type(var_ty)`. Postfix shapes
            // (`name->field`, `name.field`, `name[i]`) fail the
            // peek and route through the expression path. C99
            // 6.5.1p2: an identifier used as a primary expression
            // must be declared; gating on `class != 0` keeps the
            // fast path for declared symbols and routes an
            // undeclared name to the general-expression branch,
            // whose existing primary-Id arm surfaces the
            // "undefined variable" diagnostic.
            let idx = self.lex.curr_id_idx;
            let var_ty = self.symbols[idx].type_;
            let arr = self.symbols[idx].array_size;
            self.next()?;
            if arr > 0 {
                arr * self.size_of_type(var_ty) as i64
            } else {
                self.size_of_type(var_ty) as i64
            }
        } else {
            // General expression: run the regular parser to learn
            // the type, then discard everything the parse pushed
            // (the operand is unevaluated per C99 6.5.3.4). The
            // `last_array_decay_*` side-channel surfaces shape
            // info the array-decay paths set so a decayed array
            // recovers its real size instead of the pointer's 8.
            //
            // Anything the parser appended to `self` that points
            // into `text` by PC has to be rewound in lockstep --
            // otherwise the stale entry references a dead PC and
            // later passes corrupt unrelated code when they fire.
            // `source_functions` is parallel to `text` and feeds
            // DWARF subprogram DIEs; `code_reloc_sym_idx` is the
            // parser-symbol shadow that
            // [`Compiler::resolve_code_relocs`] zips against
            // `code_relocs` post-parse, so dropping the trailing
            // entry keeps the two arrays the same length.
            let saved_text_len = self.next_ent_pc;
            let saved_code_reloc_sym_idx = self.code_reloc_sym_idx.len();
            // If sizeof consumed a leading `(` but the inner
            // content is not a type-name, the paren belongs to a
            // surrounding unary-expression. Restore the snapshot
            // so the regular parser sees the original `(...)` and
            // its postfix loop can chain through `->` / `.` / `[`
            // after the matching `)`. Clear `had_paren` so the
            // trailing `)` consumer at the end of this function
            // does not consume a paren that was never sizeof's
            // to begin with.
            if had_paren {
                self.lex.restore(pre_paren_snap);
                had_paren = false;
            }
            let lev = Token::Inc as i64;
            self.pending.last_array_decay_size = 0;
            self.pending.last_array_decay_bytes = 0;
            self.expr(lev)?;
            let array_count = self.pending.last_array_decay_size;
            let array_bytes = self.pending.last_array_decay_bytes;
            let expr_ty = self.ty;
            // Drop any PC reservation the operand's parse
            // recorded; sizeof emits nothing live so the saved
            // counter must be restored verbatim.
            self.next_ent_pc = saved_text_len;
            self.clear_recent_emits();
            self.code_reloc_sym_idx.truncate(saved_code_reloc_sym_idx);
            self.pending.last_array_decay_size = 0;
            self.pending.last_array_decay_bytes = 0;
            if array_bytes > 0 {
                // Multi-dim pointer-to-array subscript or `*p`
                // row deref: the row's byte size is known
                // directly. The row's shape can be itself multi-
                // dim, which c5's flat type encoding can't
                // represent as `count * sizeof(elem_ty)`, so
                // trust the byte count.
                array_bytes
            } else if array_count > 0 {
                // Decayed 1D array: `expr_ty` is `T*` but we
                // want `N * sizeof(T)`.
                let elem_ty = expr_ty - Ty::Ptr as i64;
                array_count * self.size_of_type(elem_ty) as i64
            } else {
                self.size_of_type(expr_ty) as i64
            }
        };
        if had_paren {
            if self.lex.tk == ')' {
                self.next()?;
            } else {
                return Err(self.compile_err("close paren expected in sizeof"));
            }
        }
        self.ty = saved_ty;
        Ok(total)
    }
}

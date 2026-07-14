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
    /// Lookahead for the `sizeof ( id )` fast path: true only when the
    /// identifier is immediately followed by `)` and no postfix
    /// operator (`[`, `.`, `->`) trails the close paren. Otherwise the
    /// parens wrap a postfix unary-expression (`sizeof(a)[i]` parses as
    /// `sizeof((a)[i])` per C99 6.5.3.4), which must route through the
    /// general expression parse. Snapshots and restores the lexer so
    /// token position is unchanged.
    fn sizeof_bare_id_paren_ok(&mut self) -> Result<bool, C5Error> {
        let snap = self.lex.snapshot();
        self.next()?; // past the identifier
        let mut ok = false;
        if self.lex.tk == ')' {
            self.next()?; // past the close paren
            ok = self.lex.tk != Token::Brak
                && self.lex.tk != Token::Dot
                && self.lex.tk != Token::Arrow;
        }
        self.lex.restore(snap);
        Ok(ok)
    }

    pub(super) fn sizeof_operand_bytes(&mut self) -> Result<i64, C5Error> {
        // Cleared each call; set only when the operand is a VLA whose
        // size the `sizeof` site must read at runtime (C99 6.5.3.4p2).
        self.pending.sizeof_vla_size_slot = None;
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
            // Abstract function-pointer / pointer-to-array declarator:
            // `sizeof(int (*)(int))`, `sizeof(void (*)(void))`,
            // `sizeof(int (*)[N])` (C99 6.7.6 / 6.5.3.4). c5's flat
            // type tag records base + pointer level, so the declarator
            // collapses to the pointer levels its inner `*`s name; the
            // result is then the size of a pointer.
            if self.lex.tk == '(' {
                let nested_ptrs = self.parse_abstract_ptr_declarator_levels()?;
                if nested_ptrs > 0 {
                    self.ty += nested_ptrs * (Ty::Ptr as i64);
                    decayed_to_ptr = true;
                }
            }
            // Abstract array declarator: `sizeof(T [N])` /
            // `sizeof(T [N][M])` (C99 6.7.6 / 6.5.3.4). Each
            // dimension multiplies the element count; the result is
            // the total byte size of the array type.
            let mut array_count: i64 = 1;
            while self.lex.tk == Token::Brak {
                self.next()?;
                let n = self.parse_constant_int()?;
                if n <= 0 {
                    return Err(self.compile_err("array dimension in sizeof must be positive"));
                }
                if self.lex.tk != ']' {
                    return Err(self.compile_err("close bracket expected in sizeof array type"));
                }
                self.next()?;
                array_count *= n;
            }
            let elem_size = self.size_of_type(self.ty) as i64;
            let base = if typedef_dim > 0 && !decayed_to_ptr {
                typedef_dim * elem_size
            } else {
                elem_size
            };
            base * array_count
        } else if self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].class != 0
            && !self.lex.peek_after_whitespace(b'-')
            && !self.lex.peek_after_whitespace(b'.')
            && !self.lex.peek_after_whitespace(b'[')
            && (!had_paren || self.sizeof_bare_id_paren_ok()?)
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
            // C99 6.5.3.4p2: `sizeof` of a VLA is the runtime byte
            // count. Signal the caller to load it from the VLA's
            // size slot; the returned constant is unused in that case.
            if self.symbols[idx].is_vla {
                self.pending.sizeof_vla_size_slot = Some(self.symbols[idx].vla_size_slot);
            }
            self.next()?;
            if self.symbols[idx].is_zero_len_array {
                // `T x[] = {}`: zero elements, so the whole object is
                // 0 bytes (the `array_size == 0` scalar encoding would
                // otherwise report `sizeof(T)`).
                0
            } else if arr > 0 {
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
            } else if array_count < 0 {
                // Decayed zero-length array (`T x[] = {}`): the `-1`
                // sentinel marks a genuine zero element count, so the
                // whole object is 0 bytes.
                0
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

    /// GCC `__builtin_object_size(ptr, type)`, `type` in 0..=3: a
    /// `size_t` constant. The pointer operand is unevaluated, like a
    /// `sizeof` operand. When it names a complete declared array the
    /// object's byte count folds (exact for every `type`); otherwise
    /// the result is the documented "unknown" value -- `(size_t)-1`
    /// for types 0 and 1 (maximum forms), 0 for types 2 and 3
    /// (minimum forms).
    pub(super) fn parse_object_size_builtin(&mut self) -> Result<(), C5Error> {
        // The call dispatch consumed `__builtin_object_size (`.
        let saved_ty = self.ty;
        let saved_text_len = self.next_ent_pc;
        let saved_reloc = self.code_reloc_sym_idx.len();
        let saved_acc = self.ast_acc.take();
        let vstack_depth = self.ast_vstack.len();
        self.pending.last_array_decay_size = 0;
        self.pending.last_array_decay_bytes = 0;
        self.expr(Token::Assign as i64)?;
        let array_count = self.pending.last_array_decay_size;
        let array_bytes = self.pending.last_array_decay_bytes;
        let expr_ty = self.ty;
        self.next_ent_pc = saved_text_len;
        self.clear_recent_emits();
        self.code_reloc_sym_idx.truncate(saved_reloc);
        self.ast_vstack.truncate(vstack_depth);
        self.ast_acc = saved_acc;
        self.pending.last_array_decay_size = 0;
        self.pending.last_array_decay_bytes = 0;
        self.ty = saved_ty;
        if self.lex.tk != ',' {
            return Err(self.compile_err("`,` expected in `__builtin_object_size`"));
        }
        self.next()?;
        let kind = self.parse_constant_int()?;
        if !(0..=3).contains(&kind) {
            return Err(self.compile_err("`__builtin_object_size` type must be 0..=3"));
        }
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected to close `__builtin_object_size`"));
        }
        self.next()?;
        let known: Option<i64> = if array_bytes > 0 {
            Some(array_bytes)
        } else if array_count > 0 {
            let elem_ty = expr_ty - Ty::Ptr as i64;
            Some(array_count * self.size_of_type(elem_ty) as i64)
        } else if array_count < 0 {
            // Zero-length array: a known object of 0 bytes.
            Some(0)
        } else {
            None
        };
        let v = match known {
            Some(n) => n,
            None if kind <= 1 => -1,
            None => 0,
        };
        self.emit_imm(v);
        self.ty = self.size_t_ty();
        self.ast_emit_int_lit(v, self.ty);
        Ok(())
    }

    /// GCC `__builtin_choose_expr(const, e1, e2)`: the chosen operand
    /// IS the expression -- its exact type carries through (no `?:`
    /// arithmetic conversions) and the other operand is parsed but not
    /// evaluated. The condition must fold to an integer constant.
    pub(super) fn parse_choose_expr_builtin(&mut self) -> Result<(), C5Error> {
        // The call dispatch consumed `__builtin_choose_expr (`.
        let cond = self.parse_constant_int()?;
        if self.lex.tk != ',' {
            return Err(self.compile_err("`,` expected in `__builtin_choose_expr`"));
        }
        self.next()?;
        let parse_arm = |me: &mut Self, live: bool| -> Result<(), C5Error> {
            if live {
                return me.expr(Token::Assign as i64);
            }
            // Discarded operand: parse for syntax, drop every emission
            // (same rollback set as the unevaluated `sizeof` operand).
            let saved_ty = me.ty;
            let saved_text_len = me.next_ent_pc;
            let saved_reloc = me.code_reloc_sym_idx.len();
            let saved_acc = me.ast_acc.take();
            let vstack_depth = me.ast_vstack.len();
            me.expr(Token::Assign as i64)?;
            me.next_ent_pc = saved_text_len;
            me.clear_recent_emits();
            me.code_reloc_sym_idx.truncate(saved_reloc);
            me.ast_vstack.truncate(vstack_depth);
            me.ast_acc = saved_acc;
            me.ty = saved_ty;
            Ok(())
        };
        parse_arm(self, cond != 0)?;
        if self.lex.tk != ',' {
            return Err(self.compile_err("`,` expected in `__builtin_choose_expr`"));
        }
        self.next()?;
        parse_arm(self, cond == 0)?;
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected to close `__builtin_choose_expr`"));
        }
        self.next()?;
        Ok(())
    }

    /// GCC `__builtin_constant_p(x)`: an `int`, 1 when the unevaluated
    /// operand folds to a constant expression, else 0. The operand is
    /// not evaluated (no emission), so this yields a plain integer
    /// constant like the `__builtin_types_compatible_p` result.
    pub(super) fn parse_constant_p_builtin(&mut self) -> Result<(), C5Error> {
        // The call dispatch consumed `__builtin_constant_p (`.
        let v = self.eval_constant_p_operand()?;
        self.emit_imm(v);
        self.ty = Ty::Int as i64;
        self.ast_emit_int_lit(v, self.ty);
        Ok(())
    }

    /// C11 6.5.3.4: `_Alignof ( type-name )`. The operand is always a
    /// parenthesized type name (an expression operand is a constraint
    /// violation), so the dual operand-shape dispatch `sizeof` needs is
    /// not required here. The alignment of an array type is the
    /// alignment of its element type (C11 6.2.8), and pointer / abstract
    /// declarators collapse to a pointer's alignment, so the abstract
    /// declarator suffixes are consumed but do not change the result
    /// beyond the pointer decoration.
    pub(super) fn alignof_operand_bytes(&mut self) -> Result<i64, C5Error> {
        if self.lex.tk != '(' {
            return Err(self.compile_err("`(` expected after `_Alignof`"));
        }
        self.next()?;
        // C11 6.5.3.4 takes a type-name; GCC's `__alignof__` also accepts a
        // parenthesized expression, whose alignment is that of its type. The
        // operand is unevaluated, so parse it, read the type, and discard
        // everything the parse pushed (mirroring `sizeof`'s expression path).
        if !self.lex_is_type_start() {
            let saved_ty = self.ty;
            let saved_text_len = self.next_ent_pc;
            let saved_reloc = self.code_reloc_sym_idx.len();
            self.expr(Token::Assign as i64)?;
            let expr_ty = self.ty;
            self.next_ent_pc = saved_text_len;
            self.clear_recent_emits();
            self.code_reloc_sym_idx.truncate(saved_reloc);
            self.ty = saved_ty;
            if self.lex.tk != ')' {
                return Err(self.compile_err("`)` expected to close `_Alignof`"));
            }
            self.next()?;
            return Ok(self.align_of_type(expr_ty) as i64);
        }
        let saved_ty = self.ty;
        self.ty = self.parse_decl_base_type()?;
        let _ = core::mem::take(&mut self.pending.typedef_base_array_size);
        while self.lex.tk == Token::MulOp {
            self.next()?;
            self.ty += Ty::Ptr as i64;
            while self.lex.tk == Token::TypeQual {
                self.next()?;
            }
        }
        if self.lex.tk == '(' {
            let nested_ptrs = self.parse_abstract_ptr_declarator_levels()?;
            if nested_ptrs > 0 {
                self.ty += nested_ptrs * (Ty::Ptr as i64);
            }
        }
        while self.lex.tk == Token::Brak {
            self.next()?;
            let _ = self.parse_constant_int()?;
            if self.lex.tk != ']' {
                return Err(self.compile_err("close bracket expected in `_Alignof` array type"));
            }
            self.next()?;
        }
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected to close `_Alignof`"));
        }
        self.next()?;
        let align = self.align_of_type(self.ty) as i64;
        self.ty = saved_ty;
        Ok(align)
    }
}

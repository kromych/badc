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
        let had_paren = self.lex.tk == '(' as i64;
        if had_paren {
            self.next()?;
        }
        let saved_ty = self.ty;
        let total: i64 = if had_paren && self.lex_is_type_start() {
            // sizeof(<type>): parse a type name with optional
            // pointer decoration and return its size.
            self.ty = self.parse_decl_base_type()?;
            while self.lex.tk == Token::MulOp as i64 {
                self.next()?;
                self.ty += Ty::Ptr as i64;
                while self.lex.tk == Token::TypeQual as i64 {
                    self.next()?;
                }
            }
            self.size_of_type(self.ty) as i64
        } else if self.lex.tk == Token::Id as i64
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
            // peek and route through the expression path.
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
            // the type, then discard the emitted bytecode (the
            // operand is unevaluated per C99 6.5.3.4). The
            // `last_array_decay_*` side-channel surfaces shape
            // info the array-decay paths set so a decayed array
            // recovers its real size instead of the pointer's 8.
            let saved_text_len = self.text.len();
            let saved_data_imm_positions = self.data_imm_positions.len();
            let lev = if had_paren {
                Token::Assign as i64
            } else {
                Token::Inc as i64
            };
            self.last_array_decay_size = 0;
            self.last_array_decay_bytes = 0;
            self.expr(lev)?;
            let array_count = self.last_array_decay_size;
            let array_bytes = self.last_array_decay_bytes;
            let expr_ty = self.ty;
            // Drop the operand's emitted code. Keep the parallel
            // debug tables (source_lines / source_functions /
            // source_file_indices) in lockstep with `text` -- if
            // any grows past `text`, every subsequent `emit_op`
            // attributes its bytecode PC to the wrong source row,
            // and DWARF subprogram DIEs land on the previous
            // function's name.
            self.text.truncate(saved_text_len);
            self.source_lines.truncate(saved_text_len);
            self.source_functions.truncate(saved_text_len);
            self.source_file_indices.truncate(saved_text_len);
            self.data_imm_positions.truncate(saved_data_imm_positions);
            self.last_array_decay_size = 0;
            self.last_array_decay_bytes = 0;
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
            if self.lex.tk == ')' as i64 {
                self.next()?;
            } else {
                return Err(self.compile_err("close paren expected in sizeof"));
            }
        }
        self.ty = saved_ty;
        Ok(total)
    }
}

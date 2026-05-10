//! Constant-expression evaluator.
//!
//! Used during declarator parsing where the value has to be known
//! before any bytecode emission: array dimensions (`int xs[N]`),
//! bitfield widths (`int x: N`), and `enum E { K = N }` initialisers.
//! Supports the C99 constant-expression grammar -- literals,
//! identifiers bound to integer constants (enum values and `#define`d
//! numeric macros the preprocessor expanded), parenthesised sub-
//! expressions, casts, `sizeof`, and the GCC-style `offsetof`
//! expansion -- with the standard operator hierarchy via recursive
//! descent.
//!
//! Lives next to `compiler/mod.rs` rather than inside it because
//! the constant-expression grammar is self-contained and was the
//! single biggest run of related methods in the parser. Splitting
//! it makes the parser body easier to read; nothing else changes.

use alloc::format;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{is_struct_ty, struct_id_of, struct_ptr_depth};

impl Compiler {
    /// Parse a constant integer expression at parse time. Used
    /// during declarator parsing where the value has to be known
    /// before any bytecode emission (array dimensions, bitfield
    /// widths, enum initialisers). Supports the c99 constant-
    /// expression grammar: literals, identifiers bound to
    /// integer constants (enum values, `#define`d numeric macros
    /// the preprocessor expanded), parenthesised sub-expressions,
    /// and the standard operator hierarchy.
    pub(super) fn parse_constant_int(&mut self) -> Result<i64, C5Error> {
        self.parse_const_expr_cond()
    }

    /// C99 6.5.15 conditional operator at the top of the constant-
    /// expression chain. Both arms are evaluated (the parser still
    /// has to consume their tokens) but only the selected one
    /// contributes to the resulting value, matching clang/gcc.
    /// The `:` arm recurses back into `parse_const_expr_cond` so
    /// `a ? b : c ? d : e` parses right-associatively.
    pub(super) fn parse_const_expr_cond(&mut self) -> Result<i64, C5Error> {
        let cond = self.parse_const_expr_or()?;
        if self.lex.tk == Token::Cond as i64 {
            self.next()?;
            let then_val = self.parse_const_expr_or()?;
            if self.lex.tk != ':' as i64 {
                return Err(self.compile_err("`:` expected in conditional constant expression"));
            }
            self.next()?;
            let else_val = self.parse_const_expr_cond()?;
            Ok(if cond != 0 { then_val } else { else_val })
        } else {
            Ok(cond)
        }
    }

    pub(super) fn parse_const_expr_or(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_and()?;
        while self.lex.tk == Token::Lor as i64 {
            self.next()?;
            let right = self.parse_const_expr_and()?;
            left = if (left != 0) || (right != 0) { 1 } else { 0 };
        }
        Ok(left)
    }

    fn parse_const_expr_and(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_bitor()?;
        while self.lex.tk == Token::Lan as i64 {
            self.next()?;
            let right = self.parse_const_expr_bitor()?;
            left = if (left != 0) && (right != 0) { 1 } else { 0 };
        }
        Ok(left)
    }

    fn parse_const_expr_bitor(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_xor()?;
        while self.lex.tk == Token::OrOp as i64 {
            self.next()?;
            let right = self.parse_const_expr_xor()?;
            left |= right;
        }
        Ok(left)
    }

    fn parse_const_expr_xor(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_bitand()?;
        while self.lex.tk == Token::XorOp as i64 {
            self.next()?;
            let right = self.parse_const_expr_bitand()?;
            left ^= right;
        }
        Ok(left)
    }

    fn parse_const_expr_bitand(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_eq()?;
        while self.lex.tk == Token::AndOp as i64 {
            self.next()?;
            let right = self.parse_const_expr_eq()?;
            left &= right;
        }
        Ok(left)
    }

    fn parse_const_expr_eq(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_rel()?;
        loop {
            if self.lex.tk == Token::EqOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_rel()?;
                left = (left == r) as i64;
            } else if self.lex.tk == Token::NeOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_rel()?;
                left = (left != r) as i64;
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_const_expr_rel(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_shift()?;
        loop {
            if self.lex.tk == Token::LtOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_shift()?;
                left = (left < r) as i64;
            } else if self.lex.tk == Token::LeOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_shift()?;
                left = (left <= r) as i64;
            } else if self.lex.tk == Token::GtOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_shift()?;
                left = (left > r) as i64;
            } else if self.lex.tk == Token::GeOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_shift()?;
                left = (left >= r) as i64;
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_const_expr_shift(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_add()?;
        loop {
            if self.lex.tk == Token::ShlOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_add()?;
                left <<= r;
            } else if self.lex.tk == Token::ShrOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_add()?;
                left >>= r;
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_const_expr_add(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_mul()?;
        loop {
            if self.lex.tk == Token::AddOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_mul()?;
                left = left.wrapping_add(r);
            } else if self.lex.tk == Token::SubOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_mul()?;
                left = left.wrapping_sub(r);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_const_expr_mul(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_unary()?;
        loop {
            if self.lex.tk == Token::MulOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_unary()?;
                left = left.wrapping_mul(r);
            } else if self.lex.tk == Token::DivOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_unary()?;
                left = if r == 0 { 0 } else { left / r };
            } else if self.lex.tk == Token::ModOp as i64 {
                self.next()?;
                let r = self.parse_const_expr_unary()?;
                left = if r == 0 { 0 } else { left % r };
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_const_expr_unary(&mut self) -> Result<i64, C5Error> {
        if self.lex.tk == Token::SubOp as i64 {
            self.next()?;
            return Ok(-self.parse_const_expr_unary()?);
        }
        if self.lex.tk == Token::AddOp as i64 {
            self.next()?;
            return self.parse_const_expr_unary();
        }
        if self.lex.tk == '!' as i64 {
            self.next()?;
            let v = self.parse_const_expr_unary()?;
            return Ok(if v == 0 { 1 } else { 0 });
        }
        if self.lex.tk == '~' as i64 {
            self.next()?;
            return Ok(!self.parse_const_expr_unary()?);
        }
        if self.lex.tk == Token::AndOp as i64 {
            return self.parse_const_offsetof();
        }
        if self.lex.tk == Token::Sizeof as i64 {
            // sizeof in a constant expression. Three shapes:
            //   * sizeof(<type>)        -- size of the type.
            //   * sizeof(<array-var>)   -- total array bytes.
            //   * sizeof(<scalar-var>)  -- size of the variable's
            //                              declared type (ignoring
            //                              the array-decay rule
            //                              that applies when the
            //                              name is read as an
            //                              expression).
            self.next()?;
            let had_paren = self.lex.tk == '(' as i64;
            if had_paren {
                self.next()?;
            }
            let total = if self.lex_is_type_start() {
                let mut t = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp as i64 {
                    self.next()?;
                    t += Ty::Ptr as i64;
                }
                self.size_of_type(t) as i64
            } else if self.lex.tk == Token::Id as i64
                && !self.lex.peek_after_whitespace(b'-')
                && !self.lex.peek_after_whitespace(b'.')
                && !self.lex.peek_after_whitespace(b'[')
            {
                // Bare identifier: `sizeof(name)`. Direct lookup so
                // arrays use their array_size; postfix shapes
                // (`name->field`, `name.field`, `name[i]`) drop
                // through to the expr-based path below where the
                // computed type drives sizeof.
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
                // sizeof(<expr>) -- compile-time. Run the regular
                // expression parser to learn the type, then drop
                // the emitted bytecode (sizeof never evaluates its
                // operand). Used for `sizeof(p->field)`, `sizeof(arr[i])`,
                // and other postfix shapes where the type isn't a
                // simple base + pointer level. Also drop any
                // `data_imm_positions` entries the expr produced --
                // otherwise the saved positions alias the next
                // Imm we emit (the size constant) and the native
                // lowering treats it as a data offset, producing
                // `adrp+add` instead of a plain mov-imm.
                let saved_text_len = self.text.len();
                let saved_ty = self.ty;
                let saved_data_imm_positions = self.data_imm_positions.len();
                self.last_array_decay_size = 0;
                self.expr(Token::Assign as i64)?;
                let expr_ty = self.ty;
                let array_count = self.last_array_decay_size;
                self.text.truncate(saved_text_len);
                // Keep parallel debug arrays in sync with `text`;
                // see compiler/mod.rs's matching comment on the
                // sister truncate (gh #48 root cause).
                self.source_lines.truncate(saved_text_len);
                self.source_functions.truncate(saved_text_len);
                self.source_file_indices.truncate(saved_text_len);
                self.data_imm_positions.truncate(saved_data_imm_positions);
                self.ty = saved_ty;
                self.last_array_decay_size = 0;
                if array_count > 0 {
                    // Recover the array's real size: the expr
                    // ended in an array-decay-to-pointer (bare
                    // array variable or `s.field` for a
                    // `T field[N]`), so `expr_ty` is `T*` but
                    // `sizeof(<expr>)` should be `N * sizeof(T)`.
                    let elem_ty = expr_ty - Ty::Ptr as i64;
                    array_count * self.size_of_type(elem_ty) as i64
                } else {
                    self.size_of_type(expr_ty) as i64
                }
            };
            if had_paren && self.lex.tk == ')' as i64 {
                self.next()?;
            }
            return Ok(total);
        }
        self.parse_const_expr_primary()
    }

    /// Recognise the GCC-style `offsetof` expansion in a constant
    /// expression -- `&((T*)<base>)->field[.field]*[[N]]`. The
    /// macro typically expands to
    ///   `((size_t)((char*)&((T*)0)->m - (char*)0))`
    /// and shows up in C99 source for sized scratch buffers.
    /// Evaluates to `<base> + offset_of(T, field...)`. The chain
    /// supports nested `.field` for nested struct values and a
    /// trailing `[N]` index for an array field.
    fn parse_const_offsetof(&mut self) -> Result<i64, C5Error> {
        let line = self.lex.line;
        // Consume `&`.
        self.next()?;
        if self.lex.tk != '(' as i64 {
            return Err(self.compile_err_at(
                line,
                format!(
                    "`&` in a constant expression must open the offsetof shape \
                 `&((T*)expr)->field` (got tk={})",
                    self.lex.tk
                ),
            ));
        }
        self.next()?;
        if self.lex.tk != '(' as i64 {
            return Err(self.compile_err_at(
                line,
                format!(
                    "expected `((T*)...` in offsetof shape (got tk={})",
                    self.lex.tk
                ),
            ));
        }
        self.next()?;
        if !self.lex_is_type_start() {
            return Err(self.compile_err_at(
                line,
                format!(
                    "expected struct type in offsetof cast (got tk={})",
                    self.lex.tk
                ),
            ));
        }
        let mut t = self.parse_decl_base_type()?;
        while self.lex.tk == Token::MulOp as i64 {
            self.next()?;
            t += Ty::Ptr as i64;
            while self.lex.tk == Token::TypeQual as i64 {
                self.next()?;
            }
        }
        if self.lex.tk != ')' as i64 {
            return Err(
                self.compile_err_at(line, "close paren expected after type in offsetof cast")
            );
        }
        self.next()?;
        // Base address (typically `0`).
        let base = self.parse_const_expr_unary()?;
        if self.lex.tk != ')' as i64 {
            return Err(
                self.compile_err_at(line, "close paren expected after base in offsetof shape")
            );
        }
        self.next()?;
        // Two postfix shapes follow the `&((T*)base)`:
        //   * `->field[.field]*` -- the standard offsetof shape;
        //     element type is the struct field, byte offset is
        //     accumulated through the chain.
        //   * `[const_expr]` -- pointer indexing into a typed
        //     base, used for constant-time pointer arithmetic
        //     like `&((char*)0)[7]` in static initializers.
        if self.lex.tk == Token::Brak as i64 {
            self.next()?;
            let n = self.parse_const_expr_cond()?;
            if self.lex.tk != ']' as i64 {
                return Err(self.compile_err_at(line, "close bracket expected in offsetof index"));
            }
            self.next()?;
            // (T*)base -- the pointee type is `t - Ty::Ptr`. Scale
            // the index by the pointee's byte size.
            let pointee_ty = t - Ty::Ptr as i64;
            return Ok(base + n * self.size_of_type(pointee_ty) as i64);
        }
        if self.lex.tk != Token::Arrow as i64 {
            return Err(self.compile_err_at(
                line,
                format!("`->` expected in offsetof shape (got tk={})", self.lex.tk),
            ));
        }
        self.next()?;
        if !is_struct_ty(t) || struct_ptr_depth(t) == 0 {
            return Err(self.compile_err_at(line, "offsetof requires `(T*)` for some struct T"));
        }
        // Drop one level of pointer to reach the struct value type.
        let mut current_ty = t - Ty::Ptr as i64;
        let mut total: i64 = base;
        loop {
            if !is_struct_ty(current_ty) || struct_ptr_depth(current_ty) != 0 {
                return Err(
                    self.compile_err_at(line, "offsetof field chain reaches a non-struct value")
                );
            }
            if self.lex.tk != Token::Id as i64 {
                return Err(self.compile_err_at(line, "field name expected in offsetof chain"));
            }
            let sid = struct_id_of(current_ty);
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            let pos = self.structs[sid]
                .fields
                .iter()
                .position(|f| f.name == name)
                .ok_or_else(|| {
                    self.compile_err_at(
                        line,
                        format!("struct {} has no field {}", self.structs[sid].name, name),
                    )
                })?;
            total += self.structs[sid].fields[pos].offset as i64;
            current_ty = self.structs[sid].fields[pos].ty;
            let field_array_size = self.structs[sid].fields[pos].array_size;
            self.next()?;
            // Optional `[N]` -- subscript inside the offsetof field
            // chain. Multiplies the constant index by the element
            // size of the field's array type.
            if self.lex.tk == Token::Brak as i64 {
                self.next()?;
                let n = self.parse_const_expr_cond()?;
                if self.lex.tk != ']' as i64 {
                    return Err(
                        self.compile_err_at(line, "close bracket expected in offsetof index")
                    );
                }
                self.next()?;
                let _ = field_array_size;
                total += n * self.size_of_type(current_ty) as i64;
            }
            if self.lex.tk == Token::Dot as i64 {
                self.next()?;
                continue;
            }
            break;
        }
        Ok(total)
    }

    fn parse_const_expr_primary(&mut self) -> Result<i64, C5Error> {
        if self.lex.tk == '(' as i64 {
            self.next()?;
            // C-style cast in a constant expression --
            // `(size_t)expr`, `(char*)0`, etc. c5's i64-shaped
            // representation makes integer / pointer casts
            // no-ops; consume the type and recurse.
            if self.lex_is_type_start() {
                let _ = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp as i64 || self.lex.tk == Token::TypeQual as i64 {
                    self.next()?;
                }
                if self.lex.tk != ')' as i64 {
                    return Err(self.compile_err("close paren expected after cast"));
                }
                self.next()?;
                return self.parse_const_expr_unary();
            }
            let v = self.parse_const_expr_cond()?;
            if self.lex.tk != ')' as i64 {
                return Err(self.compile_err("close paren expected in constant expression"));
            }
            self.next()?;
            return Ok(v);
        }
        if self.lex.tk == Token::Num as i64 {
            let v = self.lex.ival;
            self.next()?;
            return Ok(v);
        }
        if self.lex.tk == Token::Id as i64
            && self.symbols[self.lex.curr_id_idx].class == Token::Num as i64
        {
            let v = self.symbols[self.lex.curr_id_idx].val;
            self.next()?;
            return Ok(v);
        }
        Err(self.compile_err(format!(
            "constant integer expected (got tk={}, id={:?})",
            self.lex.tk,
            if self.lex.tk == Token::Id as i64 {
                Some(self.symbols[self.lex.curr_id_idx].name.clone())
            } else {
                None
            }
        )))
    }
}

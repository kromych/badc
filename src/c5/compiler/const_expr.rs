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

    /// Parse a C11 6.7.10 `_Static_assert(<const-int-expr>,
    /// "<string-literal>");` (or its C23 `static_assert` alias).
    /// On entry the current token is `Token::StaticAssert`. The
    /// constant expression must fold to non-zero; if it folds
    /// to zero, the string-literal message is surfaced through
    /// the standard compile-error path. The construct itself
    /// emits no code -- the assertion is fully parse-time.
    pub(super) fn parse_static_assert(&mut self) -> Result<(), C5Error> {
        let line = self.lex.line;
        self.next()?; // consume `static_assert` / `_Static_assert`
        if self.lex.tk != '(' {
            return Err(self.compile_err_at(
                line,
                "`static_assert` requires `(<const-expr>, \"<message>\")`",
            ));
        }
        self.next()?;
        let value = self.parse_const_expr_cond()?;
        // The message argument is optional in C23 but required in
        // C11. Accept both shapes: a trailing `, "msg"` is the
        // canonical form; a bare `(expr)` falls back to a generic
        // message constructed from the source token.
        let mut message: alloc::string::String = alloc::string::String::new();
        if self.lex.tk == ',' {
            self.next()?;
            if self.lex.tk != '"' {
                return Err(
                    self.compile_err_at(line, "string-literal message expected in `static_assert`")
                );
            }
            // The lexer stores the staged string's data-segment
            // offset in `lex.ival`. Read the bytes back so we can
            // surface the message inline; adjacent literals are
            // already glued by the lexer's `"a" "b"` rule.
            let addr = self.lex.ival as usize;
            self.next()?;
            while self.lex.tk == '"' {
                self.next()?;
            }
            // Walk the staged bytes up to the first NUL.
            let mut p = addr;
            while p < self.data.len() && self.data[p] != 0 {
                message.push(self.data[p] as char);
                p += 1;
            }
        }
        if self.lex.tk != ')' {
            return Err(self.compile_err_at(line, "`)` expected after `static_assert(...)`"));
        }
        self.next()?;
        // The trailing `;` is mandatory at file / block scope in
        // C11; we accept it and step past.
        if self.lex.tk == ';' {
            self.next()?;
        }
        if value == 0 {
            let body = if message.is_empty() {
                "static_assert failed".into()
            } else {
                format!("static_assert: {message}")
            };
            return Err(self.compile_err_at(line, &body));
        }
        Ok(())
    }

    /// C99 6.5.15 conditional operator at the top of the constant-
    /// expression chain. Both arms are evaluated (the parser still
    /// has to consume their tokens) but only the selected one
    /// contributes to the resulting value, matching clang/gcc.
    /// The `:` arm recurses back into `parse_const_expr_cond` so
    /// `a ? b : c ? d : e` parses right-associatively.
    pub(super) fn parse_const_expr_cond(&mut self) -> Result<i64, C5Error> {
        let cond = self.parse_const_expr_or()?;
        if self.lex.tk == Token::Cond {
            self.next()?;
            let then_val = self.parse_const_expr_or()?;
            if self.lex.tk != ':' {
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
        while self.lex.tk == Token::Lor {
            self.next()?;
            let right = self.parse_const_expr_and()?;
            left = if (left != 0) || (right != 0) { 1 } else { 0 };
        }
        Ok(left)
    }

    fn parse_const_expr_and(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_bitor()?;
        while self.lex.tk == Token::Lan {
            self.next()?;
            let right = self.parse_const_expr_bitor()?;
            left = if (left != 0) && (right != 0) { 1 } else { 0 };
        }
        Ok(left)
    }

    fn parse_const_expr_bitor(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_xor()?;
        while self.lex.tk == Token::OrOp {
            self.next()?;
            let right = self.parse_const_expr_xor()?;
            left |= right;
        }
        Ok(left)
    }

    fn parse_const_expr_xor(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_bitand()?;
        while self.lex.tk == Token::XorOp {
            self.next()?;
            let right = self.parse_const_expr_bitand()?;
            left ^= right;
        }
        Ok(left)
    }

    fn parse_const_expr_bitand(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_eq()?;
        while self.lex.tk == Token::AndOp {
            self.next()?;
            let right = self.parse_const_expr_eq()?;
            left &= right;
        }
        Ok(left)
    }

    fn parse_const_expr_eq(&mut self) -> Result<i64, C5Error> {
        let mut left = self.parse_const_expr_rel()?;
        loop {
            if self.lex.tk == Token::EqOp {
                self.next()?;
                let r = self.parse_const_expr_rel()?;
                left = (left == r) as i64;
            } else if self.lex.tk == Token::NeOp {
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
            if self.lex.tk == Token::LtOp {
                self.next()?;
                let r = self.parse_const_expr_shift()?;
                left = (left < r) as i64;
            } else if self.lex.tk == Token::LeOp {
                self.next()?;
                let r = self.parse_const_expr_shift()?;
                left = (left <= r) as i64;
            } else if self.lex.tk == Token::GtOp {
                self.next()?;
                let r = self.parse_const_expr_shift()?;
                left = (left > r) as i64;
            } else if self.lex.tk == Token::GeOp {
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
            if self.lex.tk == Token::ShlOp {
                self.next()?;
                let r = self.parse_const_expr_add()?;
                left <<= r;
            } else if self.lex.tk == Token::ShrOp {
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
            if self.lex.tk == Token::AddOp {
                self.next()?;
                let r = self.parse_const_expr_mul()?;
                left = left.wrapping_add(r);
            } else if self.lex.tk == Token::SubOp {
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
            if self.lex.tk == Token::MulOp {
                self.next()?;
                let r = self.parse_const_expr_unary()?;
                left = left.wrapping_mul(r);
            } else if self.lex.tk == Token::DivOp {
                self.next()?;
                let r = self.parse_const_expr_unary()?;
                left = if r == 0 { 0 } else { left / r };
            } else if self.lex.tk == Token::ModOp {
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
        if self.lex.tk == Token::SubOp {
            self.next()?;
            return Ok(-self.parse_const_expr_unary()?);
        }
        if self.lex.tk == Token::AddOp {
            self.next()?;
            return self.parse_const_expr_unary();
        }
        if self.lex.tk == '!' {
            self.next()?;
            let v = self.parse_const_expr_unary()?;
            return Ok(if v == 0 { 1 } else { 0 });
        }
        if self.lex.tk == '~' {
            self.next()?;
            return Ok(!self.parse_const_expr_unary()?);
        }
        if self.lex.tk == Token::AndOp {
            return self.parse_const_offsetof();
        }
        if self.lex.tk == Token::Sizeof {
            // Shared sizeof operand parser handles all three
            // shapes (type-name, bare identifier, general
            // expression). Constant-expression context just
            // returns the byte count directly.
            self.next()?;
            return self.sizeof_operand_bytes();
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
        if self.lex.tk != '(' {
            return Err(self.compile_err_at(
                line,
                format!(
                    "`&` in a constant expression must open the offsetof shape \
                 `&((T*)expr)->field` (got {})",
                    super::super::token::describe(self.lex.tk)
                ),
            ));
        }
        self.next()?;
        if self.lex.tk != '(' {
            return Err(self.compile_err_at(
                line,
                format!(
                    "expected `((T*)...` in offsetof shape (got {})",
                    super::super::token::describe(self.lex.tk)
                ),
            ));
        }
        self.next()?;
        if !self.lex_is_type_start() {
            return Err(self.compile_err_at(
                line,
                format!(
                    "expected struct type in offsetof cast (got {})",
                    super::super::token::describe(self.lex.tk)
                ),
            ));
        }
        let mut t = self.parse_decl_base_type()?;
        while self.lex.tk == Token::MulOp {
            self.next()?;
            t += Ty::Ptr as i64;
            while self.lex.tk == Token::TypeQual {
                self.next()?;
            }
        }
        if self.lex.tk != ')' {
            return Err(
                self.compile_err_at(line, "close paren expected after type in offsetof cast")
            );
        }
        self.next()?;
        // Base address (typically `0`).
        let base = self.parse_const_expr_unary()?;
        if self.lex.tk != ')' {
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
        if self.lex.tk == Token::Brak {
            self.next()?;
            let n = self.parse_const_expr_cond()?;
            if self.lex.tk != ']' {
                return Err(self.compile_err_at(line, "close bracket expected in offsetof index"));
            }
            self.next()?;
            // (T*)base -- the pointee type is `t - Ty::Ptr`. Scale
            // the index by the pointee's byte size.
            let pointee_ty = t - Ty::Ptr as i64;
            return Ok(base + n * self.size_of_type(pointee_ty) as i64);
        }
        if self.lex.tk != Token::Arrow {
            return Err(self.compile_err_at(
                line,
                format!(
                    "`->` expected in offsetof shape (got {})",
                    super::super::token::describe(self.lex.tk)
                ),
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
            if self.lex.tk != Token::Id {
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
            if self.lex.tk == Token::Brak {
                self.next()?;
                let n = self.parse_const_expr_cond()?;
                if self.lex.tk != ']' {
                    return Err(
                        self.compile_err_at(line, "close bracket expected in offsetof index")
                    );
                }
                self.next()?;
                let _ = field_array_size;
                total += n * self.size_of_type(current_ty) as i64;
            }
            if self.lex.tk == Token::Dot {
                self.next()?;
                continue;
            }
            break;
        }
        Ok(total)
    }

    fn parse_const_expr_primary(&mut self) -> Result<i64, C5Error> {
        if self.lex.tk == '(' {
            self.next()?;
            // C-style cast in a constant expression --
            // `(size_t)expr`, `(char*)0`, etc. c5's i64-shaped
            // representation makes integer / pointer casts
            // no-ops; consume the type and recurse.
            if self.lex_is_type_start() {
                let _ = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp || self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
                if self.lex.tk != ')' {
                    return Err(self.compile_err("close paren expected after cast"));
                }
                self.next()?;
                return self.parse_const_expr_unary();
            }
            let v = self.parse_const_expr_cond()?;
            if self.lex.tk != ')' {
                return Err(self.compile_err("close paren expected in constant expression"));
            }
            self.next()?;
            return Ok(v);
        }
        if self.lex.tk == Token::Num {
            let v = self.lex.ival;
            self.next()?;
            return Ok(v);
        }
        if self.lex.tk == Token::Id && self.symbols[self.lex.curr_id_idx].class == Token::Num as i64
        {
            let v = self.symbols[self.lex.curr_id_idx].val;
            self.next()?;
            return Ok(v);
        }
        let id_suffix = if self.lex.tk == Token::Id {
            format!(" `{}`", self.symbols[self.lex.curr_id_idx].name)
        } else {
            alloc::string::String::new()
        };
        Err(self.compile_err(format!(
            "constant integer expected (got {}{id_suffix})",
            super::super::token::describe(self.lex.tk),
        )))
    }
}

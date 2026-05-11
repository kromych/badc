//! Constant-expression evaluator.
//!
//! Used during declarator parsing where the value has to be known
//! before any bytecode emission: array dimensions (`int xs[N]`),
//! bitfield widths (`int x: N`), `enum E { K = N }` initialisers,
//! `_Static_assert` operands, and the rvalues of static / global
//! integer initializers. Supports the C99 constant-expression
//! grammar -- literals (integer + floating), identifiers bound to
//! integer constants (enum values and `#define`d numeric macros
//! the preprocessor expanded), parenthesised sub-expressions,
//! casts, `sizeof`, and the GCC-style `offsetof` expansion -- with
//! the standard operator hierarchy via recursive descent.
//!
//! Internally each recursive-descent rule returns a [`ConstVal`]
//! so a floating literal can flow through the chain (e.g.
//! `int xs[(int)(1.5 * 2.0)];` per C99 6.6 with the gcc/clang
//! "any value of arithmetic type at parse time" extension). The
//! three public entry points coerce the result back to `i64` so
//! every existing caller -- which always wants an integer --
//! sees the same shape it did before.
//!
//! Lives next to `compiler/mod.rs` rather than inside it because
//! the constant-expression grammar is self-contained and was the
//! single biggest run of related methods in the parser. Splitting
//! it makes the parser body easier to read.

use alloc::format;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{is_floating_ty, is_struct_ty, struct_id_of, struct_ptr_depth};

/// Compile-time arithmetic value of a constant expression. Integer
/// literals, identifier-bound integer constants, sizeof, and the
/// offsetof shape produce [`ConstVal::Int`]; floating literals and
/// casts to floating types produce [`ConstVal::Float`]. Mixed-type
/// arithmetic promotes to float per C99 6.3.1.8 ("usual arithmetic
/// conversions"). The integer-typed callers (array sizes, enums,
/// bitfield widths, integer global inits) truncate via
/// [`ConstVal::as_int`] at the boundary.
#[derive(Copy, Clone, Debug)]
pub(super) enum ConstVal {
    Int(i64),
    Float(f64),
}

impl ConstVal {
    /// Coerce to an `i64`. Float values truncate toward zero, matching
    /// C's "cast to integer" semantics for the destination integer
    /// constant expression.
    pub(super) fn as_int(self) -> i64 {
        match self {
            ConstVal::Int(v) => v,
            ConstVal::Float(v) => v as i64,
        }
    }

    /// Coerce to an `f64`. Integer values widen exactly for any value
    /// within `f64`'s 53-bit mantissa range (which is every integer
    /// constant c5 currently lexes).
    fn as_float(self) -> f64 {
        match self {
            ConstVal::Int(v) => v as f64,
            ConstVal::Float(v) => v,
        }
    }

    fn is_float(self) -> bool {
        matches!(self, ConstVal::Float(_))
    }

    /// True if the value is non-zero. Used by `&&`, `||`, `?:`, `!`.
    fn is_truthy(self) -> bool {
        match self {
            ConstVal::Int(v) => v != 0,
            ConstVal::Float(v) => v != 0.0,
        }
    }
}

impl Compiler {
    /// Parse a constant integer expression at parse time. Used
    /// during declarator parsing where the value has to be known
    /// before any bytecode emission (array dimensions, bitfield
    /// widths, enum initialisers). Supports the C99 constant-
    /// expression grammar: integer + floating literals, identifiers
    /// bound to integer constants (enum values, `#define`d numeric
    /// macros the preprocessor expanded), parenthesised sub-
    /// expressions, and the standard operator hierarchy. A floating
    /// result is truncated to an `i64` at this boundary -- the C99
    /// constraint that an "integer constant expression" only have
    /// integer operands is widened the way gcc/clang do, to "any
    /// constant arithmetic expression," then narrowed to int here.
    pub(super) fn parse_constant_int(&mut self) -> Result<i64, C5Error> {
        Ok(self.parse_const_expr_cond_val()?.as_int())
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
        let value = self.parse_const_expr_cond_val()?.as_int();
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

    /// Public entry point at the logical-OR level. Used by
    /// `parse_global_initializer` for the rvalue of a scalar global
    /// integer init. The float path lives in `initializer.rs`
    /// (`parse_const_float_expr`) and is selected upstream; this
    /// helper truncates any float that sneaks through (e.g.
    /// `int g = (int)1.5;`) per the same widened-then-narrowed rule
    /// `parse_constant_int` uses.
    pub(super) fn parse_const_expr_or(&mut self) -> Result<i64, C5Error> {
        Ok(self.parse_const_expr_or_val()?.as_int())
    }

    /// C99 6.5.15 conditional operator at the top of the constant-
    /// expression chain. Both arms are evaluated (the parser still
    /// has to consume their tokens) but only the selected one
    /// contributes to the resulting value, matching clang/gcc.
    /// The `:` arm recurses back into `parse_const_expr_cond_val` so
    /// `a ? b : c ? d : e` parses right-associatively.
    fn parse_const_expr_cond_val(&mut self) -> Result<ConstVal, C5Error> {
        let cond = self.parse_const_expr_or_val()?;
        if self.lex.tk == Token::Cond {
            self.next()?;
            let then_val = self.parse_const_expr_or_val()?;
            if self.lex.tk != ':' {
                return Err(self.compile_err("`:` expected in conditional constant expression"));
            }
            self.next()?;
            let else_val = self.parse_const_expr_cond_val()?;
            Ok(if cond.is_truthy() { then_val } else { else_val })
        } else {
            Ok(cond)
        }
    }

    fn parse_const_expr_or_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_and_val()?;
        while self.lex.tk == Token::Lor {
            self.next()?;
            let right = self.parse_const_expr_and_val()?;
            // Short-circuit semantics aren't observable at parse
            // time -- the right operand was already consumed by
            // the recursive call -- but the result still has C99's
            // `int 0 | 1` shape.
            let r = if left.is_truthy() || right.is_truthy() {
                1
            } else {
                0
            };
            left = ConstVal::Int(r);
        }
        Ok(left)
    }

    fn parse_const_expr_and_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_bitor_val()?;
        while self.lex.tk == Token::Lan {
            self.next()?;
            let right = self.parse_const_expr_bitor_val()?;
            let r = if left.is_truthy() && right.is_truthy() {
                1
            } else {
                0
            };
            left = ConstVal::Int(r);
        }
        Ok(left)
    }

    fn parse_const_expr_bitor_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_xor_val()?;
        while self.lex.tk == Token::OrOp {
            self.next()?;
            let right = self.parse_const_expr_xor_val()?;
            left = ConstVal::Int(left.as_int() | right.as_int());
        }
        Ok(left)
    }

    fn parse_const_expr_xor_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_bitand_val()?;
        while self.lex.tk == Token::XorOp {
            self.next()?;
            let right = self.parse_const_expr_bitand_val()?;
            left = ConstVal::Int(left.as_int() ^ right.as_int());
        }
        Ok(left)
    }

    fn parse_const_expr_bitand_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_eq_val()?;
        while self.lex.tk == Token::AndOp {
            self.next()?;
            let right = self.parse_const_expr_eq_val()?;
            left = ConstVal::Int(left.as_int() & right.as_int());
        }
        Ok(left)
    }

    fn parse_const_expr_eq_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_rel_val()?;
        loop {
            if self.lex.tk == Token::EqOp {
                self.next()?;
                let r = self.parse_const_expr_rel_val()?;
                let eq = if left.is_float() || r.is_float() {
                    left.as_float() == r.as_float()
                } else {
                    left.as_int() == r.as_int()
                };
                left = ConstVal::Int(eq as i64);
            } else if self.lex.tk == Token::NeOp {
                self.next()?;
                let r = self.parse_const_expr_rel_val()?;
                let ne = if left.is_float() || r.is_float() {
                    left.as_float() != r.as_float()
                } else {
                    left.as_int() != r.as_int()
                };
                left = ConstVal::Int(ne as i64);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_const_expr_rel_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_shift_val()?;
        loop {
            let op = if self.lex.tk == Token::LtOp {
                Some('<')
            } else if self.lex.tk == Token::LeOp {
                Some('l')
            } else if self.lex.tk == Token::GtOp {
                Some('>')
            } else if self.lex.tk == Token::GeOp {
                Some('g')
            } else {
                None
            };
            let Some(op) = op else { break };
            self.next()?;
            let r = self.parse_const_expr_shift_val()?;
            let b = if left.is_float() || r.is_float() {
                let lf = left.as_float();
                let rf = r.as_float();
                match op {
                    '<' => lf < rf,
                    'l' => lf <= rf,
                    '>' => lf > rf,
                    _ => lf >= rf,
                }
            } else {
                let li = left.as_int();
                let ri = r.as_int();
                match op {
                    '<' => li < ri,
                    'l' => li <= ri,
                    '>' => li > ri,
                    _ => li >= ri,
                }
            };
            left = ConstVal::Int(b as i64);
        }
        Ok(left)
    }

    fn parse_const_expr_shift_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_add_val()?;
        loop {
            if self.lex.tk == Token::ShlOp {
                self.next()?;
                let r = self.parse_const_expr_add_val()?;
                left = ConstVal::Int(left.as_int() << r.as_int());
            } else if self.lex.tk == Token::ShrOp {
                self.next()?;
                let r = self.parse_const_expr_add_val()?;
                left = ConstVal::Int(left.as_int() >> r.as_int());
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_const_expr_add_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_mul_val()?;
        loop {
            if self.lex.tk == Token::AddOp {
                self.next()?;
                let r = self.parse_const_expr_mul_val()?;
                left = if left.is_float() || r.is_float() {
                    ConstVal::Float(left.as_float() + r.as_float())
                } else {
                    ConstVal::Int(left.as_int().wrapping_add(r.as_int()))
                };
            } else if self.lex.tk == Token::SubOp {
                self.next()?;
                let r = self.parse_const_expr_mul_val()?;
                left = if left.is_float() || r.is_float() {
                    ConstVal::Float(left.as_float() - r.as_float())
                } else {
                    ConstVal::Int(left.as_int().wrapping_sub(r.as_int()))
                };
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_const_expr_mul_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_unary_val()?;
        loop {
            if self.lex.tk == Token::MulOp {
                self.next()?;
                let r = self.parse_const_expr_unary_val()?;
                left = if left.is_float() || r.is_float() {
                    ConstVal::Float(left.as_float() * r.as_float())
                } else {
                    ConstVal::Int(left.as_int().wrapping_mul(r.as_int()))
                };
            } else if self.lex.tk == Token::DivOp {
                self.next()?;
                let r = self.parse_const_expr_unary_val()?;
                left = if left.is_float() || r.is_float() {
                    let rf = r.as_float();
                    let v = if rf == 0.0 { 0.0 } else { left.as_float() / rf };
                    ConstVal::Float(v)
                } else {
                    let ri = r.as_int();
                    let v = if ri == 0 { 0 } else { left.as_int() / ri };
                    ConstVal::Int(v)
                };
            } else if self.lex.tk == Token::ModOp {
                // C99 6.5.5: `%` requires integer operands. Coerce
                // both sides through `as_int` and operate on i64.
                self.next()?;
                let r = self.parse_const_expr_unary_val()?;
                let ri = r.as_int();
                let v = if ri == 0 { 0 } else { left.as_int() % ri };
                left = ConstVal::Int(v);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_const_expr_unary_val(&mut self) -> Result<ConstVal, C5Error> {
        if self.lex.tk == Token::SubOp {
            self.next()?;
            return Ok(match self.parse_const_expr_unary_val()? {
                ConstVal::Int(v) => ConstVal::Int(v.wrapping_neg()),
                ConstVal::Float(v) => ConstVal::Float(-v),
            });
        }
        if self.lex.tk == Token::AddOp {
            self.next()?;
            return self.parse_const_expr_unary_val();
        }
        if self.lex.tk == '!' {
            self.next()?;
            let v = self.parse_const_expr_unary_val()?;
            return Ok(ConstVal::Int(if v.is_truthy() { 0 } else { 1 }));
        }
        if self.lex.tk == '~' {
            self.next()?;
            let v = self.parse_const_expr_unary_val()?.as_int();
            return Ok(ConstVal::Int(!v));
        }
        if self.lex.tk == Token::AndOp {
            return Ok(ConstVal::Int(self.parse_const_offsetof()?));
        }
        if self.lex.tk == Token::Sizeof {
            // Shared sizeof operand parser handles all three
            // shapes (type-name, bare identifier, general
            // expression). Constant-expression context just
            // returns the byte count directly.
            self.next()?;
            return Ok(ConstVal::Int(self.sizeof_operand_bytes()?));
        }
        self.parse_const_expr_primary_val()
    }

    /// Recognise the GCC-style `offsetof` expansion in a constant
    /// expression -- `&((T*)<base>)->field[.field]*[[N]]`. The
    /// macro typically expands to
    ///   `((size_t)((char*)&((T*)0)->m - (char*)0))`
    /// and shows up in C99 source for sized scratch buffers.
    /// Evaluates to `<base> + offset_of(T, field...)`. The chain
    /// supports nested `.field` for nested struct values and a
    /// trailing `[N]` index for an array field. Result is always
    /// an integer byte offset.
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
        let base = self.parse_const_expr_unary_val()?.as_int();
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
            let n = self.parse_const_expr_cond_val()?.as_int();
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
                let n = self.parse_const_expr_cond_val()?.as_int();
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

    fn parse_const_expr_primary_val(&mut self) -> Result<ConstVal, C5Error> {
        if self.lex.tk == '(' {
            self.next()?;
            // C-style cast in a constant expression -- `(size_t)expr`,
            // `(char*)0`, `(int)1.5`, `(double)42`. The target type
            // determines the coercion applied to the recursive
            // operand:
            //   * integer / pointer family -> coerce to ConstVal::Int
            //     (floats truncate via `as_int`)
            //   * float / double           -> coerce to ConstVal::Float
            //     (integers widen via `as_float`)
            // This is the hook that lets `(int)(1.5 * 2.0)` evaluate
            // to `3` at parse time -- the inner `*` produces a float,
            // the cast clamps it back to integer per C99 6.3.1.4.
            if self.lex_is_type_start() {
                let mut target_ty = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp {
                    self.next()?;
                    target_ty += Ty::Ptr as i64;
                    while self.lex.tk == Token::TypeQual {
                        self.next()?;
                    }
                }
                while self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
                if self.lex.tk != ')' {
                    return Err(self.compile_err("close paren expected after cast"));
                }
                self.next()?;
                let v = self.parse_const_expr_unary_val()?;
                return Ok(if is_floating_ty(target_ty) {
                    ConstVal::Float(v.as_float())
                } else {
                    ConstVal::Int(v.as_int())
                });
            }
            let v = self.parse_const_expr_cond_val()?;
            if self.lex.tk != ')' {
                return Err(self.compile_err("close paren expected in constant expression"));
            }
            self.next()?;
            return Ok(v);
        }
        if self.lex.tk == Token::Num {
            let v = self.lex.ival;
            self.next()?;
            return Ok(ConstVal::Int(v));
        }
        if self.lex.tk == Token::FloatNum {
            // Floating literal -- the lexer staged the f64 bit
            // pattern in `ival`. C99 6.6 lets a floating constant
            // appear as the immediate operand of a cast in an
            // integer constant expression; clang/gcc widen this to
            // accept floats anywhere in a constant arithmetic
            // expression and truncate at the integer boundary. We
            // match the lenient interpretation: surface the f64 and
            // let the chain decide whether it survives.
            let v = f64::from_bits(self.lex.ival as u64);
            self.next()?;
            return Ok(ConstVal::Float(v));
        }
        if self.lex.tk == Token::Id && self.symbols[self.lex.curr_id_idx].class == Token::Num as i64
        {
            let v = self.symbols[self.lex.curr_id_idx].val;
            self.next()?;
            return Ok(ConstVal::Int(v));
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

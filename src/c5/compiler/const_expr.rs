//! Constant-expression evaluator.
//!
//! Used during declarator parsing where the value has to be known
//! before any IR-building emit: array dimensions (`int xs[N]`),
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
//! `int xs[(int)(1.5 * 2.0)];`). C99 6.6 strictly admits a
//! floating constant only as the *immediate* operand of a cast
//! in an integer constant expression; gcc / clang accept the
//! wider "any arithmetic constant expression" shape as an
//! extension (gcc warns under `-Wpedantic`). The three public
//! entry points coerce the result back to `i64` so every
//! existing caller -- which always wants an integer -- sees
//! the same shape it did before.
//!
//! Lives next to `compiler/mod.rs` rather than inside it because
//! the constant-expression grammar is self-contained and was the
//! single biggest run of related methods in the parser. Splitting
//! it makes the parser body easier to read.

use alloc::format;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{
    UNSIGNED_BIT, integer_promote, is_floating_ty, is_pointer_ty, is_struct_ty, is_unsigned_ty,
    narrow_const_int, strip_unsigned, struct_id_of, struct_ptr_depth, usual_arith_common_ty,
};

/// Compile-time arithmetic value of a constant expression. Integer
/// literals, identifier-bound integer constants, sizeof, and the
/// offsetof shape produce [`ConstVal::Int`]; floating literals and
/// casts to floating types produce [`ConstVal::Float`]. Mixed-type
/// arithmetic promotes to float per C99 6.3.1.8 ("usual arithmetic
/// conversions"). The integer-typed callers (array sizes, enums,
/// bitfield widths, integer global inits) truncate via
/// [`ConstVal::as_int`] at the boundary.
///
/// An integer value carries its C type tag so every operator can
/// apply the 6.3.1.8 conversions at the right width and signedness
/// (`0xFFFFFFFFFFFFFFFFULL / 3` divides unsigned; `-1 < 1u`
/// compares at `unsigned int`). Invariant: `val` holds the value
/// in `ty`'s representation -- sign-extended for a signed type,
/// zero-extended for an unsigned type narrower than 8 bytes, raw
/// bits for an unsigned 8-byte type.
#[derive(Copy, Clone, Debug)]
pub(super) enum ConstVal {
    Int { val: i64, ty: i64 },
    Float(f64),
}

/// Operator selector for [`Compiler::const_int_binop`], the single
/// integer fold shared by every binary operator in the
/// constant-expression grammar.
#[derive(Copy, Clone, PartialEq)]
enum ConstBinOp {
    Or,
    Xor,
    And,
    Add,
    Sub,
    Mul,
    Div,
    Rem,
    Shl,
    Shr,
    Lt,
    Le,
    Gt,
    Ge,
    Eq,
    Ne,
}

impl ConstVal {
    /// An `int`-typed value: comparison and logical results, and
    /// the other places C99 mandates `int`.
    fn int(v: i64) -> ConstVal {
        ConstVal::Int {
            val: v,
            ty: Ty::Int as i64,
        }
    }

    /// Coerce to an `i64`. Float values truncate toward zero, matching
    /// C's "cast to integer" semantics for the destination integer
    /// constant expression.
    pub(super) fn as_int(self) -> i64 {
        match self {
            ConstVal::Int { val, .. } => val,
            ConstVal::Float(v) => v as i64,
        }
    }

    /// The C type tag of an integer value (`int` for a float a
    /// caller coerces through [`Self::as_int`]).
    fn int_ty(self) -> i64 {
        match self {
            ConstVal::Int { ty, .. } => ty,
            ConstVal::Float(_) => Ty::Int as i64,
        }
    }

    /// Coerce to an `f64`. Integer values widen exactly for any value
    /// within `f64`'s 53-bit mantissa range (which is every integer
    /// constant c5 currently lexes).
    pub(super) fn as_float(self) -> f64 {
        match self {
            ConstVal::Int { val, .. } => val as f64,
            ConstVal::Float(v) => v,
        }
    }

    fn is_float(self) -> bool {
        matches!(self, ConstVal::Float(_))
    }

    /// True if the value is non-zero. Used by `&&`, `||`, `?:`, `!`.
    fn is_truthy(self) -> bool {
        match self {
            ConstVal::Int { val, .. } => val != 0,
            ConstVal::Float(v) => v != 0.0,
        }
    }
}

impl Compiler {
    /// Fold one integer binary operator per C99 6.3.1.8: both
    /// operands convert to their common type and the operation runs
    /// in that type's signedness, renormalized to its width. Shifts
    /// take the promoted left-operand type instead (6.5.7p3).
    /// Pointer-typed operands (string addresses, offsetof chains)
    /// fold at full 64-bit width with no conversion. A zero divisor
    /// in an evaluated operand is a compile error (6.6p4); signed
    /// overflow wraps, matching the runtime lowering.
    fn const_int_binop(
        &self,
        op: ConstBinOp,
        l: ConstVal,
        r: ConstVal,
    ) -> Result<ConstVal, C5Error> {
        use ConstBinOp as B;
        let (a_ty, b_ty) = (l.int_ty(), r.int_ty());
        let ptr = is_pointer_ty(a_ty) || is_pointer_ty(b_ty);
        if matches!(op, B::Shl | B::Shr) {
            let pty = if ptr {
                Ty::LongLong as i64
            } else {
                integer_promote(a_ty)
            };
            let bytes = self.size_of_type(pty);
            let uns = is_unsigned_ty(pty);
            let lv = narrow_const_int(bytes, uns, false, l.as_int());
            let sh = (r.as_int() & 63) as u32;
            let v = if op == B::Shl {
                (lv as u64).wrapping_shl(sh) as i64
            } else if uns {
                ((lv as u64) >> sh) as i64
            } else {
                lv.wrapping_shr(sh)
            };
            return Ok(ConstVal::Int {
                val: narrow_const_int(bytes, uns, false, v),
                ty: pty,
            });
        }
        let common = if ptr {
            Ty::LongLong as i64
        } else {
            usual_arith_common_ty(a_ty, b_ty, self.target)
        };
        let bytes = self.size_of_type(common);
        let uns = is_unsigned_ty(common);
        let lv = narrow_const_int(bytes, uns, false, l.as_int());
        let rv = narrow_const_int(bytes, uns, false, r.as_int());
        let val = match op {
            B::Or => lv | rv,
            B::Xor => lv ^ rv,
            B::And => lv & rv,
            B::Add => lv.wrapping_add(rv),
            B::Sub => lv.wrapping_sub(rv),
            B::Mul => lv.wrapping_mul(rv),
            B::Div | B::Rem => {
                if rv == 0 {
                    if self.const_unevaluated == 0 {
                        return Err(self.compile_err("division by zero in a constant expression"));
                    }
                    0
                } else if uns {
                    let (a, b) = (lv as u64, rv as u64);
                    (if op == B::Rem { a % b } else { a / b }) as i64
                } else if op == B::Rem {
                    lv.wrapping_rem(rv)
                } else {
                    lv.wrapping_div(rv)
                }
            }
            B::Lt | B::Le | B::Gt | B::Ge | B::Eq | B::Ne => {
                let hold = if uns {
                    let (a, b) = (lv as u64, rv as u64);
                    match op {
                        B::Lt => a < b,
                        B::Le => a <= b,
                        B::Gt => a > b,
                        B::Ge => a >= b,
                        B::Eq => a == b,
                        _ => a != b,
                    }
                } else {
                    match op {
                        B::Lt => lv < rv,
                        B::Le => lv <= rv,
                        B::Gt => lv > rv,
                        B::Ge => lv >= rv,
                        B::Eq => lv == rv,
                        _ => lv != rv,
                    }
                };
                return Ok(ConstVal::int(hold as i64));
            }
            B::Shl | B::Shr => unreachable!(),
        };
        Ok(ConstVal::Int {
            val: narrow_const_int(bytes, uns, false, val),
            ty: common,
        })
    }

    /// Parse a constant integer expression at parse time. Used
    /// during declarator parsing where the value has to be known
    /// before any IR-building emit (array dimensions, bitfield
    /// widths, enum initialisers). Accepts integer literals plus
    /// floating literals as primary terms; full arithmetic over
    /// either type flows through and a floating result is
    /// truncated to an `i64` at this boundary. Strict C99 6.6
    /// only allows floats as the immediate operand of a cast in
    /// an integer constant expression, so c5 is more lenient
    /// here -- it accepts the wider "any constant arithmetic
    /// expression" grammar that gcc / clang permit (gcc warns
    /// under `-Wpedantic`).
    pub(super) fn parse_constant_int(&mut self) -> Result<i64, C5Error> {
        Ok(self.parse_const_expr_cond_val()?.as_int())
    }

    /// Try to fold an array-declarator dimension to an integer
    /// constant. Returns `Some(value)` for a constant dimension, or
    /// `None` when the dimension is a non-constant expression (a C99
    /// 6.7.6.2 variable-length array) -- in which case the lexer is
    /// restored so the caller can re-parse the dimension as a runtime
    /// expression.
    pub(super) fn try_parse_constant_dim(&mut self) -> Result<Option<i64>, C5Error> {
        let snap = self.lex.snapshot();
        self.pending.const_expr_nonconst = false;
        match self.parse_const_expr_cond_val() {
            // Folded to a constant; the caller validates the trailing `]`.
            Ok(v) => Ok(Some(v.as_int())),
            // Non-constant operand -> a VLA dimension: rewind for the
            // caller's runtime-expression parse.
            Err(_) if self.pending.const_expr_nonconst => {
                self.lex.restore(snap);
                Ok(None)
            }
            // A genuine constant-expression error (division by zero, an
            // overflowing shift, ...) is diagnosed, not treated as a VLA.
            Err(e) => Err(e),
        }
    }

    /// Consume an array-declarator dimension up to (not including) the
    /// matching `]`. Used for a variable-length array parameter, whose
    /// size is discarded when the array is adjusted to a pointer (C99
    /// 6.7.6.3p7); also absorbs the `[*]` unspecified-size form.
    pub(super) fn skip_array_dimension_expr(&mut self) -> Result<(), C5Error> {
        let mut depth: i64 = 0;
        loop {
            if self.lex.tk == Token::Brak {
                depth += 1;
            } else if self.lex.tk == ']' {
                if depth == 0 {
                    return Ok(());
                }
                depth -= 1;
            } else if self.lex.tk == 0 {
                return Err(self.compile_err("close bracket expected in array declarator"));
            }
            self.next()?;
        }
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
            let addr = self.take_concat_string_literal()?;
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
        self.accept(';')?;
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
    pub(super) fn parse_const_expr_cond_val(&mut self) -> Result<ConstVal, C5Error> {
        let cond = self.parse_const_expr_or_val()?;
        if self.lex.tk == Token::Cond {
            self.next()?;
            // Both arms are parsed (their tokens must be consumed)
            // but the not-taken arm is unevaluated per C99 6.5.15,
            // so a zero divisor there must not diagnose.
            let taken = cond.is_truthy();
            let then_val = self.parse_const_unevaluated(!taken, Self::parse_const_expr_or_val)?;
            if self.lex.tk != ':' {
                return Err(self.compile_err("`:` expected in conditional constant expression"));
            }
            self.next()?;
            let else_val = self.parse_const_unevaluated(taken, Self::parse_const_expr_cond_val)?;
            Ok(if taken { then_val } else { else_val })
        } else {
            Ok(cond)
        }
    }

    /// Run `rule` with the unevaluated-operand depth raised when
    /// `unevaluated` holds, so C99 6.6p4 zero-divisor diagnostics
    /// stay scoped to evaluated operands.
    fn parse_const_unevaluated(
        &mut self,
        unevaluated: bool,
        rule: fn(&mut Self) -> Result<ConstVal, C5Error>,
    ) -> Result<ConstVal, C5Error> {
        if unevaluated {
            self.const_unevaluated += 1;
        }
        let r = rule(self);
        if unevaluated {
            self.const_unevaluated -= 1;
        }
        r
    }

    pub(super) fn parse_const_expr_or_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_and_val()?;
        while self.lex.tk == Token::Lor {
            self.next()?;
            // The right operand's tokens are always consumed, but a
            // short-circuited operand is unevaluated (C99 6.5.14).
            let right =
                self.parse_const_unevaluated(left.is_truthy(), Self::parse_const_expr_and_val)?;
            let r = if left.is_truthy() || right.is_truthy() {
                1
            } else {
                0
            };
            left = ConstVal::int(r);
        }
        Ok(left)
    }

    fn parse_const_expr_and_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_bitor_val()?;
        while self.lex.tk == Token::Lan {
            self.next()?;
            let right =
                self.parse_const_unevaluated(!left.is_truthy(), Self::parse_const_expr_bitor_val)?;
            let r = if left.is_truthy() && right.is_truthy() {
                1
            } else {
                0
            };
            left = ConstVal::int(r);
        }
        Ok(left)
    }

    fn parse_const_expr_bitor_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_xor_val()?;
        while self.lex.tk == Token::OrOp {
            self.next()?;
            let right = self.parse_const_expr_xor_val()?;
            left = self.const_int_binop(ConstBinOp::Or, left, right)?;
        }
        Ok(left)
    }

    fn parse_const_expr_xor_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_bitand_val()?;
        while self.lex.tk == Token::XorOp {
            self.next()?;
            let right = self.parse_const_expr_bitand_val()?;
            left = self.const_int_binop(ConstBinOp::Xor, left, right)?;
        }
        Ok(left)
    }

    fn parse_const_expr_bitand_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_eq_val()?;
        while self.lex.tk == Token::AndOp {
            self.next()?;
            let right = self.parse_const_expr_eq_val()?;
            left = self.const_int_binop(ConstBinOp::And, left, right)?;
        }
        Ok(left)
    }

    fn parse_const_expr_eq_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_rel_val()?;
        loop {
            let op = if self.lex.tk == Token::EqOp {
                ConstBinOp::Eq
            } else if self.lex.tk == Token::NeOp {
                ConstBinOp::Ne
            } else {
                break;
            };
            self.next()?;
            let r = self.parse_const_expr_rel_val()?;
            left = if left.is_float() || r.is_float() {
                let eq = left.as_float() == r.as_float();
                ConstVal::int((if op == ConstBinOp::Eq { eq } else { !eq }) as i64)
            } else {
                self.const_int_binop(op, left, r)?
            };
        }
        Ok(left)
    }

    fn parse_const_expr_rel_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_shift_val()?;
        loop {
            let op = if self.lex.tk == Token::LtOp {
                ConstBinOp::Lt
            } else if self.lex.tk == Token::LeOp {
                ConstBinOp::Le
            } else if self.lex.tk == Token::GtOp {
                ConstBinOp::Gt
            } else if self.lex.tk == Token::GeOp {
                ConstBinOp::Ge
            } else {
                break;
            };
            self.next()?;
            let r = self.parse_const_expr_shift_val()?;
            left = if left.is_float() || r.is_float() {
                let lf = left.as_float();
                let rf = r.as_float();
                let b = match op {
                    ConstBinOp::Lt => lf < rf,
                    ConstBinOp::Le => lf <= rf,
                    ConstBinOp::Gt => lf > rf,
                    _ => lf >= rf,
                };
                ConstVal::int(b as i64)
            } else {
                self.const_int_binop(op, left, r)?
            };
        }
        Ok(left)
    }

    fn parse_const_expr_shift_val(&mut self) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_add_val()?;
        loop {
            let op = if self.lex.tk == Token::ShlOp {
                ConstBinOp::Shl
            } else if self.lex.tk == Token::ShrOp {
                ConstBinOp::Shr
            } else {
                break;
            };
            self.next()?;
            let r = self.parse_const_expr_add_val()?;
            left = self.const_int_binop(op, left, r)?;
        }
        Ok(left)
    }

    pub(super) fn parse_const_expr_add_val(&mut self) -> Result<ConstVal, C5Error> {
        let seed = self.parse_const_expr_unary_val()?;
        self.parse_const_expr_add_from(seed)
    }

    /// Continue an additive constant-expression chain from an already
    /// parsed left operand. Shared by `parse_const_expr_add_val` and the
    /// static-initializer constant folder, which consumes the leading
    /// literal before it can tell the expression is floating.
    pub(super) fn parse_const_expr_add_from(
        &mut self,
        seed: ConstVal,
    ) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_mul_from(seed)?;
        loop {
            if self.lex.tk == Token::AddOp {
                self.next()?;
                let r = self.parse_const_expr_mul_val()?;
                left = if left.is_float() || r.is_float() {
                    ConstVal::Float(left.as_float() + r.as_float())
                } else {
                    self.const_int_binop(ConstBinOp::Add, left, r)?
                };
            } else if self.lex.tk == Token::SubOp {
                self.next()?;
                let r = self.parse_const_expr_mul_val()?;
                left = if left.is_float() || r.is_float() {
                    ConstVal::Float(left.as_float() - r.as_float())
                } else {
                    self.const_int_binop(ConstBinOp::Sub, left, r)?
                };
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_const_expr_mul_val(&mut self) -> Result<ConstVal, C5Error> {
        let seed = self.parse_const_expr_unary_val()?;
        self.parse_const_expr_mul_from(seed)
    }

    fn parse_const_expr_mul_from(&mut self, mut left: ConstVal) -> Result<ConstVal, C5Error> {
        loop {
            if self.lex.tk == Token::MulOp {
                self.next()?;
                let r = self.parse_const_expr_unary_val()?;
                left = if left.is_float() || r.is_float() {
                    ConstVal::Float(left.as_float() * r.as_float())
                } else {
                    self.const_int_binop(ConstBinOp::Mul, left, r)?
                };
            } else if self.lex.tk == Token::DivOp {
                self.next()?;
                let r = self.parse_const_expr_unary_val()?;
                left = if left.is_float() || r.is_float() {
                    // C99 Annex F / IEEE 754: floating division by zero
                    // yields +/-infinity for a non-zero numerator and NaN
                    // for 0.0/0.0, not a fold to zero.
                    ConstVal::Float(left.as_float() / r.as_float())
                } else {
                    self.const_int_binop(ConstBinOp::Div, left, r)?
                };
            } else if self.lex.tk == Token::ModOp {
                // C99 6.5.5: `%` requires integer operands. Coerce
                // both sides through `as_int` and fold as integers.
                self.next()?;
                let r = self.parse_const_expr_unary_val()?;
                left = self.const_int_binop(ConstBinOp::Rem, left, r)?;
            } else {
                break;
            }
        }
        Ok(left)
    }

    /// Renormalize a unary integer result to the operand's promoted
    /// type (C99 6.5.3.3: `-` and `~` apply the integer promotions
    /// and yield the promoted type). Pointer-typed operands keep
    /// their full-width value.
    fn const_unary_promoted(&self, v: i64, operand_ty: i64) -> ConstVal {
        if is_pointer_ty(operand_ty) {
            return ConstVal::Int {
                val: v,
                ty: operand_ty,
            };
        }
        let pty = integer_promote(operand_ty);
        ConstVal::Int {
            val: narrow_const_int(self.size_of_type(pty), is_unsigned_ty(pty), false, v),
            ty: pty,
        }
    }

    pub(super) fn parse_const_expr_unary_val(&mut self) -> Result<ConstVal, C5Error> {
        // Every recursive cycle in the constant-expression grammar
        // (parentheses, ternary arms, unary chains) passes through
        // here, so this one guard bounds the whole cascade.
        self.with_nesting("expression", |c| c.parse_const_expr_unary_val_inner())
    }

    fn parse_const_expr_unary_val_inner(&mut self) -> Result<ConstVal, C5Error> {
        if self.lex.tk == Token::SubOp {
            self.next()?;
            return Ok(match self.parse_const_expr_unary_val()? {
                ConstVal::Int { val, ty } => self.const_unary_promoted(val.wrapping_neg(), ty),
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
            return Ok(ConstVal::int(if v.is_truthy() { 0 } else { 1 }));
        }
        if self.lex.tk == '~' {
            self.next()?;
            let v = self.parse_const_expr_unary_val()?;
            return Ok(self.const_unary_promoted(!v.as_int(), v.int_ty()));
        }
        if self.lex.tk == Token::AndOp {
            // Address constant: full-width, no arithmetic conversion.
            let v = self.parse_const_offsetof()?;
            return Ok(ConstVal::Int {
                val: v,
                ty: Ty::Ptr as i64,
            });
        }
        if self.lex.tk == Token::Sizeof {
            // Shared sizeof operand parser handles all three
            // shapes (type-name, bare identifier, general
            // expression). Constant-expression context just
            // returns the byte count, typed `size_t` (C99 6.5.3.4p4).
            self.next()?;
            let v = self.sizeof_operand_bytes()?;
            return Ok(ConstVal::Int {
                val: v,
                ty: self.size_t_ty(),
            });
        }
        if self.lex.tk == Token::Alignof {
            // C11 6.5.3.4: `_Alignof ( type-name )` is a constant
            // expression; the result is `size_t`.
            self.next()?;
            let v = self.alignof_operand_bytes()?;
            return Ok(ConstVal::Int {
                val: v,
                ty: self.size_t_ty(),
            });
        }
        self.parse_const_expr_primary_val()
    }

    /// The `size_t` type tag: `unsigned long` on LP64,
    /// `unsigned long long` on LLP64.
    fn size_t_ty(&self) -> i64 {
        if self.target.is_windows() {
            Ty::LongLong as i64 | UNSIGNED_BIT
        } else {
            Ty::Long as i64 | UNSIGNED_BIT
        }
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
                // The type is consumed as a cast, not bound through a
                // declarator; drop the declarator side channels it may set.
                self.pending.base_is_function_type = false;
                self.pending.bare_function_type_declarator = false;
                self.pending.fn_ptr_indirection = None;
                self.pending.typedef_fn_proto = None;
                self.pending.fn_ptr_param_types = None;
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
                // Parenthesized abstract declarator: `(*)(args)` (function
                // pointer) or `(*)[N]` (pointer to array). The shared helper
                // absorbs the suffixes and returns the pointer level (C99 6.7.7).
                if self.lex.tk == '(' {
                    target_ty += self.parse_abstract_ptr_declarator_levels()? * Ty::Ptr as i64;
                    while self.lex.tk == Token::TypeQual {
                        self.next()?;
                    }
                }
                if self.lex.tk != ')' {
                    return Err(self.compile_err("close paren expected after cast"));
                }
                self.next()?;
                let v = self.parse_const_expr_unary_val()?;
                return Ok(if is_floating_ty(target_ty) {
                    ConstVal::Float(v.as_float())
                } else {
                    // C99 6.3.1.3: a cast to an integer type narrows
                    // the operand to the target width and re-interprets
                    // it by the target's signedness, so `(int)UINT_MAX`
                    // folds to -1 rather than 0xFFFFFFFF. Pointer
                    // targets are 8 bytes and keep the full value.
                    let bytes = self.size_of_type(target_ty);
                    let is_bool = strip_unsigned(target_ty) == Ty::Bool as i64;
                    ConstVal::Int {
                        val: narrow_const_int(
                            bytes,
                            is_unsigned_ty(target_ty),
                            is_bool,
                            v.as_int(),
                        ),
                        ty: target_ty,
                    }
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
            // Type the literal per C99 6.4.4.1p5 (suffix + magnitude)
            // before `next()` resets the lexer's suffix fields.
            let v = self.lex.ival;
            let ty = self.literal_auto_promoted_type(v);
            self.next()?;
            return Ok(ConstVal::Int { val: v, ty });
        }
        if self.lex.tk == '"' {
            // String literal in a constant expression -- evaluates
            // to the address of the literal's first byte in the
            // data segment. Adjacent literals concatenate per
            // C99 6.4.5p5. Used by static initializers that
            // subtract pointer offsets like
            // `(char *)"..." - (char *)0`.
            let addr = self.lex.ival;
            self.next()?;
            while self.lex.tk == '"' {
                self.next()?;
            }
            self.data.push(0);
            return Ok(ConstVal::Int {
                val: addr,
                ty: Ty::Ptr as i64,
            });
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
            // Enumeration constants have type `int` (C99 6.7.2.2p3);
            // a value past `int`'s range (accepted as an extension)
            // keeps 64-bit rank so arithmetic doesn't truncate it.
            let v = self.symbols[self.lex.curr_id_idx].val;
            self.next()?;
            let ty = if v as i32 as i64 == v {
                Ty::Int as i64
            } else {
                Ty::LongLong as i64
            };
            return Ok(ConstVal::Int { val: v, ty });
        }
        let id_suffix = if self.lex.tk == Token::Id {
            format!(" `{}`", self.symbols[self.lex.curr_id_idx].name)
        } else {
            alloc::string::String::new()
        };
        // Reached a non-constant operand rather than a malformed
        // constant: the array-declarator reads this to tell a C99
        // 6.7.6.2 VLA dimension apart from a constant-expression error.
        self.pending.const_expr_nonconst = true;
        Err(self.compile_err(format!(
            "constant integer expected (got {}{id_suffix})",
            super::super::token::describe(self.lex.tk),
        )))
    }
}

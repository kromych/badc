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
//! casts, `sizeof`, and the address of a constant object designator
//! (`&((T*)0)->m`) -- with the standard operator hierarchy via
//! recursive descent.
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
    UNSIGNED_BIT, integer_promote, is_floating_ty, is_pointer_ty, is_struct_ty, is_struct_value_ty,
    is_unsigned_ty, narrow_const_int, strip_unsigned, struct_id_of, struct_ptr_depth,
};

/// Compile-time arithmetic value of a constant expression. Integer
/// literals, identifier-bound integer constants, sizeof, and a
/// constant address-of expression produce [`ConstVal::Int`]; floating literals and
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
/// zero-extended for an unsigned type narrower than 16 bytes, raw
/// bits for an unsigned 16-byte type.
#[derive(Copy, Clone, Debug)]
pub(super) enum ConstVal {
    Int {
        val: i128,
        ty: i64,
    },
    Float(f64),
    /// A symbol-relative address constant (C99 6.6p9): a function or
    /// object designator that has not been reduced to an integer. It
    /// participates in pointer equality / relational folding and in the
    /// truthiness a `?:` condition needs; a static initializer that
    /// consumes it emits the relocation `sym` names. It is not an integer
    /// constant expression, so the pure-ICE entry points reject it.
    Addr(ConstAddr),
}

/// A constant object designation, produced while folding the operand of a
/// unary `&` in a constant expression. It is either an object lvalue
/// (`is_lvalue`, and `value` is the object's byte address) or a pointer
/// rvalue (`value` is the pointer's integer value). `ty` is the object
/// type or the pointer type. Designators (`->`, `.`, `[]`) fold constant
/// offsets onto `value`; parentheses recurse, so any nesting works. C99
/// 6.6p9 permits such address constants in a constant expression.
///
/// When the designation is rooted at a named object -- `&global`, `&func`,
/// or a designator chain on one -- `root` names it and `value` is the byte
/// displacement from it; the address then needs a relocation, not a plain
/// integer.
#[derive(Copy, Clone)]
struct ConstDesig {
    value: i64,
    ty: i64,
    is_lvalue: bool,
    root: ConstRoot,
}

/// What the byte displacement in [`ConstDesig`] / [`ConstAddr`] is measured
/// from, and hence which relocation a static initializer consuming the
/// address emits.
#[derive(Copy, Clone, Debug, PartialEq, Eq)]
pub(super) enum ConstRoot {
    /// No symbol: a purely integer-foldable address (the
    /// `&((T*)0)->field` offsetof form). Needs no relocation.
    None,
    /// Data symbol index.
    Data(usize),
    /// Code symbol index: a function or libc-bound stub.
    Code(usize),
    /// A `&&label` block address (GCC labels as values) in the function
    /// being parsed. Its code location is fixed only once block layout
    /// is final, so the initializer emits a relocation against it.
    Label(super::super::ast::LabelId),
}

impl ConstRoot {
    fn code_or_data(idx: usize, code: bool) -> Self {
        if code {
            ConstRoot::Code(idx)
        } else {
            ConstRoot::Data(idx)
        }
    }

    /// True when the address relocates against something rather than
    /// folding to a plain integer.
    pub(super) fn is_symbolic(self) -> bool {
        !matches!(self, ConstRoot::None)
    }

    fn is_label(self) -> bool {
        matches!(self, ConstRoot::Label(_))
    }

    /// The symbol index, for the roots that name one.
    pub(super) fn sym(self) -> Option<usize> {
        match self {
            ConstRoot::Data(i) | ConstRoot::Code(i) => Some(i),
            _ => None,
        }
    }
}

/// The folded value of a constant `&` operand: a byte displacement plus, when
/// the address is symbol-relative, the symbol to relocate against.
/// `elem_size` is the referenced type's size, driving C99 6.5.6 pointer
/// arithmetic (`+ n` strides by it, a same-symbol difference divides by
/// it); a cast to an integer type resets it to 1 (byte arithmetic).
#[derive(Copy, Clone, Debug)]
pub(super) struct ConstAddr {
    pub value: i64,
    pub root: ConstRoot,
    pub elem_size: i64,
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
            val: v as i128,
            ty: Ty::Int as i64,
        }
    }

    /// Coerce to an `i64`. Float values truncate toward zero, matching
    /// C's "cast to integer" semantics for the destination integer
    /// constant expression.
    pub(super) fn as_int(self) -> i64 {
        self.as_i128() as i64
    }

    /// The full 128-bit value. The 16-byte integer initializer path needs
    /// both halves; every other caller truncates via [`Self::as_int`].
    pub(super) fn as_i128(self) -> i128 {
        match self {
            ConstVal::Int { val, .. } => val,
            ConstVal::Float(v) => v as i128,
            ConstVal::Addr(a) => a.value as i128,
        }
    }

    /// The C type tag of an integer value (`int` for a float a
    /// caller coerces through [`Self::as_int`]).
    fn int_ty(self) -> i64 {
        match self {
            ConstVal::Int { ty, .. } => ty,
            ConstVal::Float(_) => Ty::Int as i64,
            ConstVal::Addr(_) => Ty::Ptr as i64,
        }
    }

    /// Coerce to an `f64`. Integer values widen exactly for any value
    /// within `f64`'s 53-bit mantissa range (which is every integer
    /// constant c5 currently lexes).
    pub(super) fn as_float(self) -> f64 {
        match self {
            ConstVal::Int { val, .. } => val as f64,
            ConstVal::Float(v) => v,
            ConstVal::Addr(a) => a.value as f64,
        }
    }

    fn is_float(self) -> bool {
        matches!(self, ConstVal::Float(_))
    }

    /// True for a symbol-relative address constant (never null) or a
    /// non-zero sym-less address. Lets a comparison against a null
    /// pointer constant fold to a known boolean.
    fn addr(self) -> Option<ConstAddr> {
        match self {
            ConstVal::Addr(a) => Some(a),
            _ => None,
        }
    }

    /// True if the value is non-zero. Used by `&&`, `||`, `?:`, `!`.
    fn is_truthy(self) -> bool {
        match self {
            ConstVal::Int { val, .. } => val != 0,
            ConstVal::Float(v) => v != 0.0,
            // A symbol's address is never null; a sym-less address is
            // truthy iff its byte value is non-zero.
            ConstVal::Addr(a) => a.root.is_symbolic() || a.value != 0,
        }
    }
}

impl Compiler {
    /// Fold one integer binary operator per C99 6.3.1.8: both
    /// operands convert to their common type and the operation runs
    /// in that type's signedness, renormalized to its width. Shifts
    /// take the promoted left-operand type instead (6.5.7p3).
    /// Pointer-typed operands (string addresses, constant address-of
    /// designations) fold at full 64-bit width with no conversion. A zero divisor
    /// in an evaluated operand is a compile error (6.6p4); signed
    /// overflow wraps, matching the runtime lowering.
    fn const_int_binop(
        &self,
        op: ConstBinOp,
        l: ConstVal,
        r: ConstVal,
    ) -> Result<ConstVal, C5Error> {
        use ConstBinOp as B;
        // Symbol-relative address operands fold structurally: pointer
        // equality / relational (C99 6.5.9) and pointer arithmetic
        // (6.5.6). A symbol's address is never null and two designations
        // are equal only when they name the same symbol at the same offset.
        if (l.addr().is_some() || r.addr().is_some())
            && let Some(v) = self.const_addr_binop(op, l, r)
        {
            return Ok(v);
        }
        // The integer fold below reads an address operand's byte
        // displacement. That is a meaningful value for a data or function
        // symbol, whose relocation the consumer still carries, but a label
        // address has no integer value at all -- only `goto *` gives it
        // meaning (GCC leaves anything else undefined). Reject rather than
        // fold it to its displacement.
        if [l, r]
            .iter()
            .filter_map(|v| v.addr())
            .any(|a| a.root.is_label())
        {
            return Err(self.compile_err(
                "a label address is not an operand of a constant arithmetic expression",
            ));
        }
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
            let lv = narrow_const_int(bytes, uns, false, l.as_i128());
            // C99 6.5.7p3 leaves an out-of-range count undefined; mask to
            // the promoted type's width, as the emitted shifts do.
            let sh = (r.as_i128() as u32) & (bytes as u32 * 8 - 1);
            let v = if op == B::Shl {
                (lv as u128).wrapping_shl(sh) as i128
            } else if uns {
                ((lv as u128) >> sh) as i128
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
            self.arith_common_ty(a_ty, b_ty)
        };
        let bytes = self.size_of_type(common);
        let uns = is_unsigned_ty(common);
        let lv = narrow_const_int(bytes, uns, false, l.as_i128());
        let rv = narrow_const_int(bytes, uns, false, r.as_i128());
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
                    let (a, b) = (lv as u128, rv as u128);
                    (if op == B::Rem { a % b } else { a / b }) as i128
                } else if op == B::Rem {
                    lv.wrapping_rem(rv)
                } else {
                    lv.wrapping_div(rv)
                }
            }
            B::Lt | B::Le | B::Gt | B::Ge | B::Eq | B::Ne => {
                // Addresses order by unsigned magnitude, as the emitted
                // relational compares do; the operands are re-narrowed
                // unsigned so the high half is not sign-extended.
                let uns = uns || ptr;
                let (lv, rv) = if ptr {
                    (
                        narrow_const_int(bytes, true, false, l.as_i128()),
                        narrow_const_int(bytes, true, false, r.as_i128()),
                    )
                } else {
                    (lv, rv)
                };
                let hold = if uns {
                    let (a, b) = (lv as u128, rv as u128);
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

    /// Fold a binary operator with at least one symbol-relative address
    /// operand, or return `None` when the operator does not have a
    /// constant address result (the integer path then applies). Two
    /// designations compare equal only when they name the same symbol at
    /// the same offset; a symbol's address never equals an integer,
    /// including the null pointer constant.
    fn const_addr_binop(&self, op: ConstBinOp, l: ConstVal, r: ConstVal) -> Option<ConstVal> {
        use ConstBinOp as B;
        let same_sym = |a: &ConstAddr, b: &ConstAddr| a.root == b.root;
        // A sym-less address is a plain pointer value; a symbol address is
        // never equal to a compile-time integer.
        let addr_eq_int = |a: ConstAddr, n: i128| !a.root.is_symbolic() && a.value as i128 == n;
        match op {
            B::Eq | B::Ne => {
                let eq = match (l.addr(), r.addr()) {
                    (Some(a), Some(b)) => same_sym(&a, &b) && a.value == b.value,
                    (Some(a), None) => addr_eq_int(a, r.as_i128()),
                    (None, Some(b)) => addr_eq_int(b, l.as_i128()),
                    (None, None) => return None,
                };
                Some(ConstVal::int((if op == B::Eq { eq } else { !eq }) as i64))
            }
            B::Lt | B::Le | B::Gt | B::Ge => {
                let (a, b) = (l.addr()?, r.addr()?);
                if !same_sym(&a, &b) {
                    return None;
                }
                let hold = match op {
                    B::Lt => a.value < b.value,
                    B::Le => a.value <= b.value,
                    B::Gt => a.value > b.value,
                    _ => a.value >= b.value,
                };
                Some(ConstVal::int(hold as i64))
            }
            // C99 6.5.6: `p +- n` strides by the referenced type's size;
            // `p - q` over one object yields the element-subscript
            // difference (byte difference / element size). A label
            // address designates no object, so there is no stride to
            // apply and `&&L +- n` stays non-constant.
            B::Add => match (l.addr(), r.addr()) {
                (Some(a), None) if !a.root.is_label() => Some(ConstVal::Addr(ConstAddr {
                    value: a
                        .value
                        .wrapping_add((r.as_i128() as i64).wrapping_mul(a.elem_size.max(1))),
                    ..a
                })),
                (None, Some(b)) if !b.root.is_label() => Some(ConstVal::Addr(ConstAddr {
                    value: b
                        .value
                        .wrapping_add((l.as_i128() as i64).wrapping_mul(b.elem_size.max(1))),
                    ..b
                })),
                _ => None,
            },
            B::Sub => match (l.addr(), r.addr()) {
                (Some(a), Some(b)) if same_sym(&a, &b) => Some(ConstVal::Int {
                    val: ((a.value - b.value) / a.elem_size.max(1)) as i128,
                    ty: Ty::LongLong as i64,
                }),
                (Some(a), None) if !a.root.is_label() => Some(ConstVal::Addr(ConstAddr {
                    value: a
                        .value
                        .wrapping_sub((r.as_i128() as i64).wrapping_mul(a.elem_size.max(1))),
                    ..a
                })),
                _ => None,
            },
            _ => None,
        }
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
        let v = self.parse_const_expr_cond_val()?;
        Ok(self.require_integer_const(v)?.as_int())
    }

    /// As [`Self::parse_constant_int`], with references to block-scope
    /// `const` scalar objects folding to their recorded initializer
    /// values. Entry point for the value contexts GCC folds them in:
    /// case labels (including GNU ranges), `static_assert`, and
    /// initializer designator indices.
    pub(super) fn parse_constant_int_folding_const_objects(&mut self) -> Result<i64, C5Error> {
        self.const_object_fold += 1;
        let r = self.parse_constant_int();
        self.const_object_fold -= 1;
        r
    }

    /// Run `rule` with the const-object fold masked: a type dimension
    /// (array declarator, compound-literal or type-name `[N]`) never
    /// folds a block-scope `const` object even inside a folding value
    /// context, so `int a[h]` stays variably sized (gcc parity).
    pub(super) fn with_const_object_fold_masked<T>(
        &mut self,
        rule: impl FnOnce(&mut Self) -> T,
    ) -> T {
        let saved = core::mem::take(&mut self.const_object_fold);
        let r = rule(self);
        self.const_object_fold = saved;
        r
    }

    /// As [`Self::parse_constant_int`], keeping all 128 bits. Used by the
    /// initializer paths, whose destination may be the 16-byte integer.
    pub(super) fn parse_constant_i128(&mut self) -> Result<i128, C5Error> {
        let v = self.parse_const_expr_cond_val()?;
        Ok(self.require_integer_const(v)?.as_i128())
    }

    /// Reject a symbol-relative address where an integer constant
    /// expression is required (array dimensions, enum values, bitfield
    /// widths, a static-initializer integer slot): C99 6.6p6 admits only
    /// arithmetic operands. Pointer comparisons and the offsetof form have
    /// already folded to an integer, so only a bare address reaches here.
    pub(super) fn require_integer_const(&self, v: ConstVal) -> Result<ConstVal, C5Error> {
        if let ConstVal::Addr(a) = v
            && a.root.is_symbolic()
        {
            return Err(self.compile_err(
                "address of an object or function is not an integer constant expression",
            ));
        }
        Ok(v)
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
            // A bare symbol address is a genuine error, not a VLA.
            Ok(v) => Ok(Some(self.require_integer_const(v)?.as_int())),
            // Non-constant operand -> a VLA dimension: rewind for the
            // caller's runtime-expression parse.
            Err(_) if self.pending.const_expr_nonconst => {
                self.restore_lex(snap);
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

    /// Skip a balanced token run up to (not consuming) the next `,` at
    /// paren/bracket depth 0. The unchosen `__builtin_choose_expr`
    /// operand in a constant expression is skipped this way -- it need
    /// not itself be constant.
    pub(super) fn skip_balanced_to_comma(&mut self) -> Result<(), C5Error> {
        let mut depth: i64 = 0;
        loop {
            if (self.lex.tk == ',' || self.lex.tk == ')') && depth == 0 {
                return Ok(());
            }
            if self.lex.tk == '(' || self.lex.tk == Token::Brak {
                depth += 1;
            } else if self.lex.tk == ')' || self.lex.tk == ']' {
                depth -= 1;
            } else if self.lex.tk == 0 {
                return Err(self.compile_err("unterminated `__builtin_choose_expr` operand"));
            }
            self.next()?;
        }
    }

    /// Skip a balanced token run through the closing `)` at depth 0
    /// (the `)` is consumed).
    pub(super) fn skip_balanced_to_close_paren(&mut self) -> Result<(), C5Error> {
        let mut depth: i64 = 0;
        loop {
            if self.lex.tk == '(' || self.lex.tk == Token::Brak {
                depth += 1;
            } else if self.lex.tk == ')' {
                if depth == 0 {
                    self.next()?;
                    return Ok(());
                }
                depth -= 1;
            } else if self.lex.tk == ']' {
                depth -= 1;
            } else if self.lex.tk == 0 {
                return Err(self.compile_err("unterminated `__builtin_choose_expr` operand"));
            }
            self.next()?;
        }
    }

    /// Consume a non-constant primary and its postfix chain (`(...)`,
    /// `[...]`, `.id`, `->id`) without evaluating it. Used when a
    /// non-constant operand appears in a subexpression that is not
    /// evaluated -- a not-taken `?:` arm or a short-circuited `||` / `&&`
    /// operand -- where C99 6.6p3 does not require it to be a constant
    /// expression; the value is discarded by the enclosing operator.
    fn skip_unevaluated_operand(&mut self) -> Result<(), C5Error> {
        self.next()?; // the non-constant primary token
        loop {
            if self.lex.tk == '(' || self.lex.tk == Token::Brak {
                self.skip_balanced_group()?;
            } else if self.lex.tk == Token::Dot || self.lex.tk == Token::Arrow {
                self.next()?;
                if self.lex.tk == Token::Id {
                    self.next()?;
                }
            } else {
                return Ok(());
            }
        }
    }

    /// Consume one balanced `( ... )` or `[ ... ]` group; on entry the
    /// current token is the opening bracket, on return it is past the
    /// matching close.
    fn skip_balanced_group(&mut self) -> Result<(), C5Error> {
        let mut depth: i64 = 0;
        loop {
            if self.lex.tk == '(' || self.lex.tk == Token::Brak {
                depth += 1;
            } else if self.lex.tk == ')' || self.lex.tk == ']' {
                depth -= 1;
                if depth == 0 {
                    self.next()?;
                    return Ok(());
                }
            } else if self.lex.tk == 0 {
                return Err(self.compile_err("unterminated operand in constant expression"));
            }
            self.next()?;
        }
    }

    /// Evaluate a `__builtin_constant_p(x)` operand: 1 when `x` folds to
    /// a constant expression, else 0. On entry the opening `(` is
    /// consumed and the current token is the operand's first; on return
    /// the closing `)` is consumed. The operand is unevaluated (GCC does
    /// not emit it), so the fold attempt is discarded and the lexer is
    /// repositioned past the operand regardless of the outcome; a
    /// non-constant operand -- including one that would error as a
    /// constant expression -- reports 0 rather than propagating.
    pub(super) fn eval_constant_p_operand(&mut self) -> Result<i64, C5Error> {
        let snap = self.lex.snapshot();
        let saved_nonconst = self.pending.const_expr_nonconst;
        self.pending.const_expr_nonconst = false;
        let is_const = self.parse_const_expr_cond_val().is_ok();
        self.pending.const_expr_nonconst = saved_nonconst;
        self.restore_lex(snap);
        self.skip_balanced_to_comma()?;
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected to close `__builtin_constant_p`"));
        }
        self.next()?;
        Ok(if is_const { 1 } else { 0 })
    }

    /// Fold a bit / byte builtin with a constant argument. Covers the
    /// integer bit-count family (`clz` / `ctz` / `popcount` / `clrsb` /
    /// `parity` / `ffs` and their width variants; the `l` forms alias one per
    /// the target's `long` width) and the byte-reversal `bswap16` / `bswap32`
    /// / `bswap64`. Returns `None` without consuming input for anything else;
    /// a non-constant argument propagates as a non-constant expression, so an
    /// array declarator treats the dimension as a VLA. The result matches the
    /// walker's runtime lowering and GCC: the argument is truncated to the
    /// operand width, `clz` / `ctz` at zero yield the bit width, `ffs(0)` is
    /// 0, and `bswap` reverses the bytes and carries the fixed-width unsigned
    /// result type (`uint16_t` / `uint32_t` / `uint64_t`).
    fn try_fold_bit_builtin(&mut self) -> Result<Option<ConstVal>, C5Error> {
        use crate::c5::op::Intrinsic;
        if self.lex.tk != Token::Id {
            return Ok(None);
        }
        let idx = self.lex.curr_id_idx;
        let not_real_fn = self.symbols[idx].class != Token::Fun as i64
            && self.symbols[idx].class != Token::Sys as i64;
        let kind = match self.pp_intrinsics.get(&self.symbols[idx].name).copied() {
            Some(intr) if not_real_fn => match Intrinsic::from_i64(intr) {
                Some(k) if k.is_int_bit_unary() || k.is_bswap() => k,
                _ => return Ok(None),
            },
            _ => return Ok(None),
        };
        self.next()?; // builtin name
        if self.lex.tk != '(' {
            return Err(self.compile_err("`(` expected after bit builtin"));
        }
        self.next()?;
        let arg = self.parse_const_expr_cond_val()?.as_i128();
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected to close bit builtin"));
        }
        self.next()?;
        let out = match kind {
            Intrinsic::Clz => ConstVal::int((arg as u32).leading_zeros() as i64),
            Intrinsic::Clzll => ConstVal::int((arg as u64).leading_zeros() as i64),
            Intrinsic::Ctz => ConstVal::int((arg as u32).trailing_zeros() as i64),
            Intrinsic::Ctzll => ConstVal::int((arg as u64).trailing_zeros() as i64),
            Intrinsic::Popcount => ConstVal::int((arg as u32).count_ones() as i64),
            Intrinsic::Popcountll => ConstVal::int((arg as u64).count_ones() as i64),
            Intrinsic::Parity => ConstVal::int(((arg as u32).count_ones() & 1) as i64),
            Intrinsic::Parityll => ConstVal::int(((arg as u64).count_ones() & 1) as i64),
            // clrsb counts the sign bits below the top one over a sign-extended
            // operand: `clz(x ^ (x >>s w-1)) - 1`, matching `lower_clrsb`.
            Intrinsic::Clrsb => {
                let x = arg as i32;
                ConstVal::int(((x ^ (x >> 31)) as u32).leading_zeros() as i64 - 1)
            }
            Intrinsic::Clrsbll => {
                let x = arg as i64;
                ConstVal::int(((x ^ (x >> 63)) as u64).leading_zeros() as i64 - 1)
            }
            Intrinsic::Ffs => {
                let a = arg as u32;
                ConstVal::int(if a == 0 {
                    0
                } else {
                    a.trailing_zeros() as i64 + 1
                })
            }
            Intrinsic::Ffsll => {
                let a = arg as u64;
                ConstVal::int(if a == 0 {
                    0
                } else {
                    a.trailing_zeros() as i64 + 1
                })
            }
            Intrinsic::Bswap16 => ConstVal::Int {
                val: (arg as u16).swap_bytes() as i128,
                ty: Ty::Short as i64 | UNSIGNED_BIT,
            },
            Intrinsic::Bswap32 => ConstVal::Int {
                val: (arg as u32).swap_bytes() as i128,
                ty: Ty::Int as i64 | UNSIGNED_BIT,
            },
            Intrinsic::Bswap64 => ConstVal::Int {
                val: (arg as u64).swap_bytes() as i128,
                ty: Ty::LongLong as i64 | UNSIGNED_BIT,
            },
            _ => unreachable!("filtered to is_int_bit_unary / is_bswap above"),
        };
        Ok(Some(out))
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
        // GCC (GNU mode, at -O) folds block-scope `const` scalar objects
        // in the controlling expression.
        self.const_object_fold += 1;
        let value = self.parse_const_expr_cond_val();
        self.const_object_fold -= 1;
        let value = value?.as_int();
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
    /// expression chain. Both arms are parsed (their tokens must be
    /// consumed) but only the selected one is evaluated, so a non-constant
    /// operand or a zero divisor in the not-taken arm does not diagnose
    /// (C99 6.6p3), matching clang/gcc. The middle operand is a full
    /// expression and the `:` arm a conditional-expression, so nested
    /// `?:` (`a ? b ? c : d : e`, `a ? b : c ? d : e`) parses correctly.
    pub(super) fn parse_const_expr_cond_val(&mut self) -> Result<ConstVal, C5Error> {
        let seed = self.parse_const_expr_unary_val()?;
        self.parse_const_expr_cond_from(seed)
    }

    /// Continue the whole constant-expression operator chain from an
    /// already parsed unary-level operand. Each level's `_from` variant
    /// first lets the tighter levels absorb the seed, so a caller that
    /// consumed a primary itself (the static-initializer folder after a
    /// parenthesized conditional) can absorb any trailing operators.
    pub(super) fn parse_const_expr_cond_from(
        &mut self,
        seed: ConstVal,
    ) -> Result<ConstVal, C5Error> {
        let cond = self.parse_const_expr_or_from(seed)?;
        if self.lex.tk == Token::Cond {
            self.next()?;
            let taken = cond.is_truthy();
            // GNU `a ?: b`: the middle operand may be omitted, and the
            // condition's own value is the result when truthy.
            let then_val = if self.lex.tk == ':' {
                cond
            } else {
                self.parse_const_unevaluated(!taken, Self::parse_const_expr_cond_val)?
            };
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
        let seed = self.parse_const_expr_unary_val()?;
        self.parse_const_expr_or_from(seed)
    }

    fn parse_const_expr_or_from(&mut self, seed: ConstVal) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_and_from(seed)?;
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
        let seed = self.parse_const_expr_unary_val()?;
        self.parse_const_expr_and_from(seed)
    }

    fn parse_const_expr_and_from(&mut self, seed: ConstVal) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_bitor_from(seed)?;
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
        let seed = self.parse_const_expr_unary_val()?;
        self.parse_const_expr_bitor_from(seed)
    }

    fn parse_const_expr_bitor_from(&mut self, seed: ConstVal) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_xor_from(seed)?;
        while self.lex.tk == Token::OrOp {
            self.next()?;
            let right = self.parse_const_expr_xor_val()?;
            left = self.const_int_binop(ConstBinOp::Or, left, right)?;
        }
        Ok(left)
    }

    fn parse_const_expr_xor_val(&mut self) -> Result<ConstVal, C5Error> {
        let seed = self.parse_const_expr_unary_val()?;
        self.parse_const_expr_xor_from(seed)
    }

    fn parse_const_expr_xor_from(&mut self, seed: ConstVal) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_bitand_from(seed)?;
        while self.lex.tk == Token::XorOp {
            self.next()?;
            let right = self.parse_const_expr_bitand_val()?;
            left = self.const_int_binop(ConstBinOp::Xor, left, right)?;
        }
        Ok(left)
    }

    fn parse_const_expr_bitand_val(&mut self) -> Result<ConstVal, C5Error> {
        let seed = self.parse_const_expr_unary_val()?;
        self.parse_const_expr_bitand_from(seed)
    }

    fn parse_const_expr_bitand_from(&mut self, seed: ConstVal) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_eq_from(seed)?;
        while self.lex.tk == Token::AndOp {
            self.next()?;
            let right = self.parse_const_expr_eq_val()?;
            left = self.const_int_binop(ConstBinOp::And, left, right)?;
        }
        Ok(left)
    }

    fn parse_const_expr_eq_val(&mut self) -> Result<ConstVal, C5Error> {
        let seed = self.parse_const_expr_unary_val()?;
        self.parse_const_expr_eq_from(seed)
    }

    fn parse_const_expr_eq_from(&mut self, seed: ConstVal) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_rel_from(seed)?;
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
        let seed = self.parse_const_expr_unary_val()?;
        self.parse_const_expr_rel_from(seed)
    }

    fn parse_const_expr_rel_from(&mut self, seed: ConstVal) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_shift_from(seed)?;
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
        let seed = self.parse_const_expr_unary_val()?;
        self.parse_const_expr_shift_from(seed)
    }

    fn parse_const_expr_shift_from(&mut self, seed: ConstVal) -> Result<ConstVal, C5Error> {
        let mut left = self.parse_const_expr_add_from(seed)?;
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
    fn const_unary_promoted(&self, v: i128, operand_ty: i64) -> ConstVal {
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
                ConstVal::Float(v) => ConstVal::Float(-v),
                v => self.const_unary_promoted(v.as_i128().wrapping_neg(), v.int_ty()),
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
            return Ok(self.const_unary_promoted(!v.as_i128(), v.int_ty()));
        }
        if self.lex.tk == Token::Lan && self.in_function_body() {
            // GCC labels as values: `&&label` is the address of a code
            // location in the function being parsed -- a link-time
            // constant, the same shape as `&func`, so a static
            // initializer consuming it emits a relocation rather than
            // stores. Outside a function body there is no label scope,
            // so the token stays the logical-AND operator.
            let label = self.parse_label_addr_operand()?;
            return Ok(ConstVal::Addr(ConstAddr {
                value: 0,
                root: ConstRoot::Label(label),
                elem_size: 1,
            }));
        }
        if self.lex.tk == Token::AndOp {
            // Address constant: full-width, no arithmetic conversion. A
            // symbol-relative address (`&global` / `&func`) yields a
            // `ConstVal::Addr` -- foldable in pointer comparisons and, in a
            // static initializer, a relocation; the pure-ICE entry points
            // reject it. The `&((T *)0)->field` offsetof form has no symbol
            // and is a plain integer.
            let a = self.parse_const_address_of()?;
            if a.root.is_symbolic() {
                return Ok(ConstVal::Addr(a));
            }
            return Ok(ConstVal::Int {
                val: a.value as i128,
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
                val: v as i128,
                ty: self.size_t_ty(),
            });
        }
        if self.lex.tk == Token::Alignof {
            // C11 6.5.3.4: `_Alignof ( type-name )` is a constant
            // expression; the result is `size_t`.
            self.next()?;
            let v = self.alignof_operand_bytes()?;
            return Ok(ConstVal::Int {
                val: v as i128,
                ty: self.size_t_ty(),
            });
        }
        if self.lex.tk == Token::Generic {
            // C11 6.5.1.1: a generic selection is a constant expression
            // when its selected association is one. Select, then fold the
            // winning expression as a constant.
            let after = self.generic_select_to_winner()?;
            let v = self.parse_const_expr_cond_val()?;
            self.restore_lex(after);
            return Ok(v);
        }
        if self.lex.tk == Token::BuiltinTypesCompatible {
            // GCC `__builtin_types_compatible_p(T1, T2)` is an integer
            // constant expression (0 or 1).
            self.next()?;
            let v = self.parse_types_compatible_p()?;
            return Ok(ConstVal::int(v));
        }
        if self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].name == "__builtin_choose_expr"
        {
            // GCC `__builtin_choose_expr(const, e1, e2)`: a constant
            // expression when the chosen operand is one; the unchosen
            // operand is skipped and need not be constant.
            self.next()?;
            if self.lex.tk != '(' {
                return Err(self.compile_err("`(` expected after `__builtin_choose_expr`"));
            }
            self.next()?;
            let c = self.parse_const_expr_cond_val()?.as_int();
            if self.lex.tk != ',' {
                return Err(self.compile_err("`,` expected in `__builtin_choose_expr`"));
            }
            self.next()?;
            let v;
            if c != 0 {
                v = self.parse_const_expr_cond_val()?;
                if self.lex.tk != ',' {
                    return Err(self.compile_err("`,` expected in `__builtin_choose_expr`"));
                }
                self.next()?;
                self.skip_balanced_to_close_paren()?;
            } else {
                self.skip_balanced_to_comma()?;
                self.next()?; // `,`
                v = self.parse_const_expr_cond_val()?;
                if self.lex.tk != ')' {
                    return Err(self.compile_err("`)` expected to close `__builtin_choose_expr`"));
                }
                self.next()?;
            }
            return Ok(v);
        }
        if self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].name == "__builtin_constant_p"
        {
            // GCC `__builtin_constant_p(x)` is an integer constant
            // expression (0 or 1): 1 when the unevaluated operand folds
            // to a constant. Usable here so a compile-time min/max idiom
            // -- `__builtin_choose_expr(__builtin_constant_p(a) &&
            // __builtin_constant_p(b), ...)` -- selects its constant arm.
            self.next()?;
            if self.lex.tk != '(' {
                return Err(self.compile_err("`(` expected after `__builtin_constant_p`"));
            }
            self.next()?;
            let v = self.eval_constant_p_operand()?;
            return Ok(ConstVal::int(v));
        }
        if self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].name == "__builtin_has_attribute"
        {
            // GCC `__builtin_has_attribute(operand, attribute)` is an
            // integer constant expression. badc does not model the queried
            // attributes on objects or types, so under its own semantics no
            // operand carries one -- the answer is 0. Both operands are
            // consumed unevaluated.
            self.next()?;
            if self.lex.tk != '(' {
                return Err(self.compile_err("`(` expected after `__builtin_has_attribute`"));
            }
            self.next()?;
            self.skip_balanced_to_comma()?;
            if self.lex.tk != ',' {
                return Err(self.compile_err("`,` expected in `__builtin_has_attribute`"));
            }
            self.next()?;
            self.skip_balanced_to_close_paren()?;
            return Ok(ConstVal::int(0));
        }
        if self.lex.tk == Token::Id
            && matches!(
                self.symbols[self.lex.curr_id_idx].name.as_str(),
                "__builtin_abs" | "__builtin_labs" | "__builtin_llabs"
            )
        {
            // GCC integer absolute-value builtins fold with a constant
            // argument. The operand narrows to the parameter type first,
            // and the most negative value wraps, matching the runtime
            // behavior of the corresponding library functions.
            let ty = match self.symbols[self.lex.curr_id_idx].name.as_str() {
                "__builtin_abs" => Ty::Int as i64,
                "__builtin_labs" => Ty::Long as i64,
                _ => Ty::LongLong as i64,
            };
            self.next()?;
            if self.lex.tk != '(' {
                return Err(self.compile_err("`(` expected after absolute-value builtin"));
            }
            self.next()?;
            let arg = self.parse_const_expr_cond_val()?.as_i128();
            if self.lex.tk != ')' {
                return Err(self.compile_err("`)` expected to close absolute-value builtin"));
            }
            self.next()?;
            let val = if self.size_of_type(ty) == 4 {
                (arg as i32).wrapping_abs() as i128
            } else {
                (arg as i64).wrapping_abs() as i128
            };
            return Ok(ConstVal::Int { val, ty });
        }
        // GCC bit / byte builtins (`__builtin_clz` / `ctz` / `popcount` /
        // `clrsb` / `parity` / `ffs` and their `l` / `ll` forms, plus
        // `bswap16` / `bswap32` / `bswap64`) fold when the argument is a
        // constant expression, so an `ilog2`-style array bound, a
        // `_Static_assert`, or a `case htons(...)` label resolves at parse
        // time instead of being taken for a VLA or rejected.
        if let Some(v) = self.try_fold_bit_builtin()? {
            return Ok(v);
        }
        if let Some(v) = self.try_fold_strlen_builtin()? {
            return Ok(v);
        }
        if let Some(v) = self.try_fold_string_compare_builtin()? {
            return Ok(ConstVal::Int {
                val: v as i128,
                ty: Ty::Int as i64,
            });
        }
        if self.lex.tk == Token::BuiltinOffsetof {
            // GCC `__builtin_offsetof(T, member)` is an integer constant
            // expression (the member's byte offset).
            self.next()?;
            // A constant context: a runtime array subscript is rejected
            // (allow_runtime = false), so the result is always `Some`.
            let v = self
                .parse_builtin_offsetof(false)?
                .expect("offsetof without a runtime subscript folds to a constant");
            return Ok(ConstVal::Int {
                val: v as i128,
                ty: self.size_t_ty(),
            });
        }
        self.parse_const_expr_primary_val()
    }

    /// Fold `strlen` / `__builtin_strlen` of a string literal, which gcc
    /// and clang admit in an integer constant expression. The count stops
    /// at the first NUL, as the library function does, so a literal with an
    /// embedded NUL is distinguishable from `sizeof` minus one -- which is
    /// what the construct is normally used to assert.
    ///
    /// Only that exact shape folds. Any other argument leaves the token
    /// stream untouched and declines, so a call on a runtime string stays
    /// whatever it already was in this context -- a VLA bound, or the
    /// error the context raises for a non-constant operand.
    pub(super) fn try_fold_strlen_builtin(&mut self) -> Result<Option<ConstVal>, C5Error> {
        if self.lex.tk != Token::Id
            || !matches!(
                self.symbols[self.lex.curr_id_idx].name.as_str(),
                "strlen" | "__builtin_strlen"
            )
        {
            return Ok(None);
        }
        // A local, a global object, or an enum constant of this name is
        // not the library function.
        let class = self.symbols[self.lex.curr_id_idx].class;
        if class != 0 && class != Token::Fun as i64 && class != Token::Sys as i64 {
            return Ok(None);
        }
        let snap = self.lex.snapshot();
        let data_len = self.data.len();
        self.next()?;
        if self.lex.tk != '(' {
            self.restore_lex(snap);
            return Ok(None);
        }
        self.next()?;
        if self.lex.tk != '"' {
            self.restore_lex(snap);
            return Ok(None);
        }
        // The lexer stages the literal (adjacent ones already glued) into
        // the data segment and leaves its offset in `lex.ival`. It was
        // staged only to be counted here, so the storage is reclaimed.
        let addr = self.take_concat_string_literal()?;
        if self.lex.tk != ')' {
            self.truncate_data(data_len);
            self.restore_lex(snap);
            return Ok(None);
        }
        self.next()?;
        let mut n = 0i128;
        let mut p = addr;
        while p < self.data.len() && self.data[p] != 0 {
            n += 1;
            p += 1;
        }
        self.truncate_data(data_len);
        Ok(Some(ConstVal::Int {
            val: n,
            ty: self.size_t_ty(),
        }))
    }

    /// Fold `strcmp` / `strncmp` / `memcmp` of two string literals, which
    /// gcc folds at every optimization level and admits in an integer
    /// constant expression. Any other argument shape, a wide literal, or a
    /// name bound to something other than a function declines with the
    /// token stream untouched.
    pub(super) fn try_fold_string_compare_builtin(&mut self) -> Result<Option<i64>, C5Error> {
        if self.lex.tk != Token::Id {
            return Ok(None);
        }
        let name = self.symbols[self.lex.curr_id_idx].name.as_str();
        let counted = match name {
            "strcmp" | "__builtin_strcmp" => false,
            "strncmp" | "memcmp" | "__builtin_strncmp" | "__builtin_memcmp" => true,
            _ => return Ok(None),
        };
        let stop_at_nul = !name.ends_with("memcmp");
        // A local, a global object, or an enum constant of this name is
        // not the library function.
        let class = self.symbols[self.lex.curr_id_idx].class;
        if class != 0 && class != Token::Fun as i64 && class != Token::Sys as i64 {
            return Ok(None);
        }
        let snap = self.lex.snapshot();
        let data_len = self.data.len();
        let nonconst = self.pending.const_expr_nonconst;
        match self.try_take_string_compare_args(counted)? {
            Some((a, alen, b, blen, n)) => {
                let r = compare_literal_bytes(&self.data, (a, alen), (b, blen), n, stop_at_nul);
                // The literals were staged only to be read here.
                self.truncate_data(data_len);
                if r.is_none() {
                    self.pending.const_expr_nonconst = nonconst;
                    self.restore_lex(snap);
                }
                Ok(r)
            }
            None => {
                self.truncate_data(data_len);
                self.pending.const_expr_nonconst = nonconst;
                self.restore_lex(snap);
                Ok(None)
            }
        }
    }

    /// Consume `("literal", "literal"[, count])`, returning each literal's
    /// data offset and byte length (the trailing NUL is not staged) plus
    /// the count. `None` leaves the lexer at the mismatch for the caller
    /// to restore.
    #[allow(clippy::type_complexity)]
    fn try_take_string_compare_args(
        &mut self,
        counted: bool,
    ) -> Result<Option<(usize, usize, usize, usize, Option<usize>)>, C5Error> {
        self.next()?;
        if self.lex.tk != '(' {
            return Ok(None);
        }
        self.next()?;
        let Some((a, alen)) = self.try_take_narrow_string_literal()? else {
            return Ok(None);
        };
        if self.lex.tk != ',' {
            return Ok(None);
        }
        self.next()?;
        let Some((b, blen)) = self.try_take_narrow_string_literal()? else {
            return Ok(None);
        };
        let mut n = None;
        if counted {
            if self.lex.tk != ',' {
                return Ok(None);
            }
            self.next()?;
            // A non-constant count is not an error here, just a call
            // that does not fold; the caller re-parses it as one.
            let count = match self.parse_const_expr_cond_val() {
                Ok(ConstVal::Int { val, .. }) if val >= 0 => val as usize,
                _ => return Ok(None),
            };
            n = Some(count);
        }
        if self.lex.tk != ')' {
            return Ok(None);
        }
        self.next()?;
        Ok(Some((a, alen, b, blen, n)))
    }

    /// Stage a narrow string literal (adjacent parts already glued) and
    /// return its data offset and byte length. A wide literal declines:
    /// its elements are not bytes.
    fn try_take_narrow_string_literal(&mut self) -> Result<Option<(usize, usize)>, C5Error> {
        if self.lex.tk != '"' || self.lex.str_is_wide {
            return Ok(None);
        }
        let start = self.take_concat_string_literal()?;
        Ok(Some((start, self.data.len() - start)))
    }

    /// The `size_t` type tag: `unsigned long` on LP64,
    /// `unsigned long long` on LLP64.
    pub(super) fn size_t_ty(&self) -> i64 {
        if self.target.is_windows() {
            Ty::LongLong as i64 | UNSIGNED_BIT
        } else {
            Ty::Long as i64 | UNSIGNED_BIT
        }
    }

    /// Evaluate the operand of a unary `&` in a constant expression to the
    /// byte address of the designated object (C99 6.6p9). The operand is a
    /// constant lvalue: a pointer value such as `(T*)0` dereferenced by a
    /// chain of `->`/`.`/`[]` designators, at any level of parenthesization.
    /// No expression shape is special-cased -- `((T*)0)->m`, `(((T*)0)->m)`,
    /// nested `.field` chains, and `((char*)0)[N]` all fold through the same
    /// recursive designation grammar.
    /// Fold the operand of a leading `&` (current token) to a constant
    /// address. The result carries the symbol to relocate against, if the
    /// designation is rooted at a named object; `sym == None` is the pure
    /// integer offsetof form. Parentheses and casts around the operand are
    /// transparent because the designation grammar recurses through them, so
    /// `&foo`, `&(foo)`, and `&((T*)0)->m` all fold here.
    pub(super) fn parse_const_address_of(&mut self) -> Result<ConstAddr, C5Error> {
        let line = self.lex.line;
        self.next()?; // consume `&`
        let d = self.parse_const_designation()?;
        if !d.is_lvalue {
            return Err(self.compile_err_at(
                line,
                "`&` in a constant expression requires an object designator \
                 such as `((T*)0)->field`",
            ));
        }
        Ok(ConstAddr {
            value: d.value,
            root: d.root,
            elem_size: (self.size_of_type(d.ty) as i64).max(1),
        })
    }

    /// Parse and fold a constant designation (see [`ConstDesig`]). Every
    /// parenthesis and designator recursion passes through here, so this
    /// bounds the cascade the way the value grammar is bounded.
    fn parse_const_designation(&mut self) -> Result<ConstDesig, C5Error> {
        self.with_nesting("expression", |c| c.parse_const_designation_inner())
    }

    fn parse_const_designation_inner(&mut self) -> Result<ConstDesig, C5Error> {
        let line = self.lex.line;
        let mut d = self.parse_const_designation_primary()?;
        // Postfix designator chain. Each folds a constant offset onto the
        // running address: `->` dereferences a pointer, `.` selects a
        // sub-member, `[]` indexes a pointer or array element.
        loop {
            if self.lex.tk == Token::Arrow {
                self.next()?;
                if d.is_lvalue {
                    return Err(self.compile_err_at(
                        line,
                        "`->` in a constant expression requires a pointer value",
                    ));
                }
                let struct_ty = d.ty - Ty::Ptr as i64;
                let (off, fty) = self.const_struct_field(struct_ty, line)?;
                d = ConstDesig {
                    value: d.value + off,
                    ty: fty,
                    is_lvalue: true,
                    root: d.root,
                };
            } else if self.lex.tk == Token::Dot {
                self.next()?;
                if !d.is_lvalue {
                    return Err(self.compile_err_at(
                        line,
                        "`.` in a constant expression requires an object of struct type",
                    ));
                }
                let (off, fty) = self.const_struct_field(d.ty, line)?;
                d = ConstDesig {
                    value: d.value + off,
                    ty: fty,
                    is_lvalue: true,
                    root: d.root,
                };
            } else if self.lex.tk == Token::Brak {
                self.next()?;
                let n = self.parse_const_expr_cond_val()?.as_int();
                if self.lex.tk != ']' {
                    return Err(
                        self.compile_err_at(line, "close bracket expected in constant subscript")
                    );
                }
                self.next()?;
                if d.is_lvalue {
                    // Array element `a[N]` at `&a + N*sizeof(elem)`. A field's
                    // `ty` is its element type, so scale by that.
                    d = ConstDesig {
                        value: d.value + n * self.size_of_type(d.ty) as i64,
                        ty: d.ty,
                        is_lvalue: true,
                        root: d.root,
                    };
                } else {
                    // Pointer index `p[N]` == `*(p+N)`: an lvalue at
                    // `p + N*sizeof(pointee)`.
                    let pointee = d.ty - Ty::Ptr as i64;
                    d = ConstDesig {
                        value: d.value + n * self.size_of_type(pointee) as i64,
                        ty: pointee,
                        is_lvalue: true,
                        root: d.root,
                    };
                }
            } else {
                break;
            }
        }
        Ok(d)
    }

    fn parse_const_designation_primary(&mut self) -> Result<ConstDesig, C5Error> {
        let line = self.lex.line;
        if self.lex.tk == Token::AndOp {
            // `&lvalue` -- a pointer rvalue whose value is the lvalue address.
            self.next()?;
            let inner = self.parse_const_designation()?;
            if !inner.is_lvalue {
                return Err(
                    self.compile_err_at(line, "`&` requires an lvalue in a constant expression")
                );
            }
            return Ok(ConstDesig {
                value: inner.value,
                ty: inner.ty + Ty::Ptr as i64,
                is_lvalue: false,
                root: inner.root,
            });
        }
        if self.lex.tk == Token::MulOp {
            // `*p` -- dereference a constant pointer value to the lvalue at
            // the pointer's address, so `&*p` folds back to `p`
            // (C99 6.5.3.2p3). The operand is a pointer value, matching the
            // `->` requirement below.
            self.next()?;
            let inner = self.parse_const_designation()?;
            if inner.is_lvalue {
                return Err(self.compile_err_at(
                    line,
                    "`*` in a constant expression requires a pointer value",
                ));
            }
            return Ok(ConstDesig {
                value: inner.value,
                ty: inner.ty - Ty::Ptr as i64,
                is_lvalue: true,
                root: inner.root,
            });
        }
        if self.lex.tk == '(' {
            self.next()?;
            if self.lex_is_type_start() {
                // Cast `(T ...*) operand` -- a (usually pointer) rvalue.
                let mut ty = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp {
                    self.next()?;
                    ty += Ty::Ptr as i64;
                    while self.lex.tk == Token::TypeQual {
                        self.next()?;
                    }
                }
                // C99 6.5.2.5 array-typed compound literal `(T[]){ ... }`: an
                // anonymous static array. Its name decays to the address of
                // the first element, so the object is an lvalue of element
                // type `ty` that a following `[i].member` chain designates.
                if self.lex.tk == Token::Brak {
                    let (off, sym) = self.emit_array_compound_literal_body(ty)?;
                    return Ok(ConstDesig {
                        value: off,
                        ty,
                        is_lvalue: true,
                        root: ConstRoot::Data(sym),
                    });
                }
                while self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
                if self.lex.tk != ')' {
                    return Err(self.compile_err_at(
                        line,
                        "close paren expected after cast type in constant expression",
                    ));
                }
                self.next()?;
                // C99 6.5.2.5 struct-typed compound literal `(T){ ... }`: an
                // anonymous static object, an lvalue whose address is the
                // constant. A non-brace operand is an ordinary cast.
                if self.lex.tk == '{' && is_struct_value_ty(ty) {
                    let (off, sym) = self.emit_compound_literal_body(ty)?;
                    return Ok(ConstDesig {
                        value: off,
                        ty,
                        is_lvalue: true,
                        root: ConstRoot::Data(sym),
                    });
                }
                let operand = self.parse_const_expr_unary_val()?;
                return Ok(ConstDesig {
                    value: operand.as_int(),
                    ty,
                    is_lvalue: false,
                    root: ConstRoot::None,
                });
            }
            // Parenthesized designation: parentheses are transparent.
            let inner = self.parse_const_designation()?;
            if self.lex.tk != ')' {
                return Err(
                    self.compile_err_at(line, "close paren expected in constant expression")
                );
            }
            self.next()?;
            return Ok(inner);
        }
        // A string literal is an unnamed array lvalue of static storage
        // duration (C99 6.4.5p6), so `&"..."` and `"..."[i]` are address
        // constants. The lexer appended the bytes to the data segment
        // (`ival` is their start; adjacent literals concatenate, no
        // terminator yet), so add the single trailing NUL and intern a
        // synthetic internal symbol at the data so the address folds through
        // the same relocation machinery a named array uses. `ty` is the
        // element type (`char`), so an `[i]` suffix strides by one byte.
        if self.lex.tk == '"' {
            let off = self.lex.ival;
            self.next()?;
            while self.lex.tk == '"' {
                self.next()?;
            }
            self.push_literal_nul();
            let len = self.data.len() as i64 - off;
            let sym = self.intern_compound_literal_symbol(off, Ty::Char as i64, len);
            return Ok(ConstDesig {
                value: off,
                ty: Ty::Char as i64,
                is_lvalue: true,
                root: ConstRoot::Data(sym),
            });
        }
        // A named object -- a global, a function, or a libc-bound stub -- is an
        // lvalue whose address is a relocation against that symbol, not an
        // integer (C99 6.3.2.1p4: a function designator decays to its address).
        // Record the symbol; `value` seeds the displacement and any following
        // `.field`/`[N]` designators fold onto it.
        if self.lex.tk == Token::Id {
            let mut idx = self.lex.curr_id_idx;
            let class = self.symbols[idx].class;
            if class == Token::Glo as i64
                || class == Token::Fun as i64
                || class == Token::Sys as i64
            {
                let is_code = class != Token::Glo as i64;
                let ty = self.symbols[idx].type_;
                // A libc-bound name has no code address of its own; its
                // relocation target is the synthesised trampoline.
                if class == Token::Sys as i64 {
                    idx = self.ensure_sys_trampoline_sym(idx);
                }
                let value = self.symbols[idx].val;
                self.symbols[idx].was_referenced = true;
                self.next()?;
                return Ok(ConstDesig {
                    value,
                    ty,
                    is_lvalue: true,
                    root: ConstRoot::code_or_data(idx, is_code),
                });
            }
        }
        // Any other primary is a plain constant value -- the integer such as
        // the `0` in `(T*)0` -- an rvalue that is neither pointer nor lvalue.
        let v = self.parse_const_expr_unary_val()?;
        Ok(ConstDesig {
            value: v.as_int(),
            ty: v.int_ty(),
            is_lvalue: false,
            root: ConstRoot::None,
        })
    }

    /// Read one staged element of an array compound literal back as a
    /// constant. Rejects an element whose bytes carry a relocation (its
    /// value is an address known only at link time).
    fn read_staged_const_element(
        &mut self,
        elem_ty: i64,
        off: i64,
        index: i64,
    ) -> Result<ConstVal, C5Error> {
        let size = self.size_of_type(elem_ty);
        let at = off + index * size as i64;
        if at < 0 || at as usize + size > self.data.len() {
            return Err(self.compile_err("compound-literal subscript out of range"));
        }
        let (lo, hi) = (at as u64, (at as usize + size) as u64);
        let hit = |o: u64| o >= lo && o < hi;
        if self.data_relocs.iter().any(|r| hit(r.data_offset))
            || self.code_relocs.iter().any(|r| hit(r.data_offset))
            || self.extern_data_relocs.iter().any(|r| hit(r.data_offset))
        {
            return Err(self.compile_err(
                "relocated compound-literal element is not an integer constant expression",
            ));
        }
        let mut v: i64 = 0;
        for k in 0..size.min(8) {
            v |= (self.data[at as usize + k] as i64) << (k * 8);
        }
        if !is_unsigned_ty(elem_ty) && size < 8 {
            let sign = 1i64 << (size * 8 - 1);
            v = (v ^ sign).wrapping_sub(sign);
        }
        Ok(ConstVal::Int {
            val: v as i128,
            ty: elem_ty,
        })
    }

    /// Resolve the current identifier as a field of `struct_ty` and return
    /// `(byte offset, field type)`, advancing past the field name.
    fn const_struct_field(&mut self, struct_ty: i64, line: usize) -> Result<(i64, i64), C5Error> {
        if !is_struct_ty(struct_ty) || struct_ptr_depth(struct_ty) != 0 {
            return Err(self.compile_err_at(
                line,
                "member access in a constant expression requires a struct value",
            ));
        }
        if self.lex.tk != Token::Id {
            return Err(self.compile_err_at(line, "field name expected in constant member access"));
        }
        let sid = struct_id_of(struct_ty);
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
        let off = self.structs[sid].fields[pos].offset as i64;
        let fty = self.structs[sid].fields[pos].ty;
        self.next()?;
        Ok((off, fty))
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
                self.pending.fn_ptr_ret_indirection = 0;
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
                // C99 6.5.2.5 array-typed compound literal `(T[]){...}` in a
                // value context: the literal decays to the address of its
                // anonymous static object; a `[i]` subscript reads the staged
                // element back as the constant value.
                if self.lex.tk == Token::Brak {
                    let (off, sym) = self.emit_array_compound_literal_body(target_ty)?;
                    if self.lex.tk == Token::Brak {
                        self.next()?;
                        let n = self.parse_const_expr_cond_val()?.as_int();
                        if self.lex.tk != ']' {
                            return Err(
                                self.compile_err("close bracket expected in constant subscript")
                            );
                        }
                        self.next()?;
                        return self.read_staged_const_element(target_ty, off, n);
                    }
                    return Ok(ConstVal::Addr(ConstAddr {
                        value: off,
                        root: ConstRoot::Data(sym),
                        elem_size: (self.size_of_type(target_ty) as i64).max(1),
                    }));
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
                // C99 6.5.2.5 scalar-typed compound literal `(T){ v }`: the
                // brace holds a single value; the result is that value
                // converted to `T` through the cast fold below.
                let braced_scalar = self.lex.tk == '{' && !is_struct_value_ty(target_ty);
                if braced_scalar {
                    self.next()?;
                }
                let v = if braced_scalar {
                    let inner = self.parse_const_expr_cond_val()?;
                    self.accept(',')?;
                    if self.lex.tk != '}' {
                        return Err(
                            self.compile_err("scalar compound literal holds a single value")
                        );
                    }
                    self.next()?;
                    inner
                } else {
                    self.parse_const_expr_unary_val()?
                };
                // A cast of a symbol-relative address to an integer or
                // pointer type keeps the relocation (common practice:
                // `(unsigned long)&sym` is a link-time constant); only the
                // type changes, so the folded value stays a `ConstVal::Addr`.
                // The cast retypes the address's arithmetic: a pointer
                // target strides by its pointee, an integer target by bytes.
                if let ConstVal::Addr(mut a) = v
                    && a.root.is_symbolic()
                    && !is_floating_ty(target_ty)
                {
                    let ptr_target = is_pointer_ty(target_ty)
                        || (is_struct_ty(target_ty) && struct_ptr_depth(target_ty) > 0);
                    a.elem_size = if ptr_target {
                        (self.size_of_type(target_ty - Ty::Ptr as i64) as i64).max(1)
                    } else {
                        1
                    };
                    return Ok(ConstVal::Addr(a));
                }
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
                            v.as_i128(),
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
            // `((T[]){...})[i]`: a subscript on a parenthesized array
            // compound literal folds by reading the staged element back.
            if self.lex.tk == Token::Brak
                && let ConstVal::Addr(a) = v
                && let Some(idx) = a.root.sym()
                && self.symbols[idx].is_compound_literal
            {
                self.next()?;
                let n = self.parse_const_expr_cond_val()?.as_int();
                if self.lex.tk != ']' {
                    return Err(self.compile_err("close bracket expected in constant subscript"));
                }
                self.next()?;
                let elem_ty = self.symbols[idx].type_;
                return self.read_staged_const_element(elem_ty, a.value, n);
            }
            return Ok(v);
        }
        if self.lex.tk == Token::Num {
            // Type the literal per C99 6.4.4.1p5 (suffix + magnitude)
            // before `next()` resets the lexer's suffix fields.
            let v = self.lex.ival;
            let ty = self.literal_auto_promoted_type(v);
            self.next()?;
            return Ok(ConstVal::Int { val: v as i128, ty });
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
            self.push_literal_nul();
            return Ok(ConstVal::Int {
                val: addr as i128,
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
            // Enumeration constants carry the type stamped at their
            // registration: `int` (C99 6.7.2.2p3) normally, unsigned /
            // wider for values past `int`'s range (GCC extension). The
            // type drives the fold's signedness, e.g. shifts and
            // divides.
            let v = self.symbols[self.lex.curr_id_idx].val;
            let ty = self.symbols[self.lex.curr_id_idx].type_;
            self.next()?;
            return Ok(ConstVal::Int { val: v as i128, ty });
        }
        // A block-scope `const` scalar arithmetic object with a recorded
        // constant initializer folds to that value in the contexts GCC
        // folds it (case labels, `static_assert`; see `const_object_fold`).
        if self.const_object_fold > 0 && self.lex.tk == Token::Id {
            let idx = self.lex.curr_id_idx;
            let sym = &self.symbols[idx];
            if sym.class == Token::Loc as i64
                && let Some(v) = sym.const_object_value
            {
                let ty = sym.type_;
                // A folded reference reads the object's value: keep the
                // unused-binding report quiet even though no load emits.
                self.symbols[idx].was_referenced = true;
                self.symbols[idx].was_read = true;
                self.next()?;
                return Ok(match v {
                    crate::c5::symbol::ConstObjectValue::Int(i) => {
                        ConstVal::Int { val: i as i128, ty }
                    }
                    crate::c5::symbol::ConstObjectValue::FloatBits(b) => {
                        ConstVal::Float(f64::from_bits(b))
                    }
                });
            }
        }
        // C99 6.6 leaves it implementation-defined, but GCC and common
        // practice fold a `const`-qualified integer object with static
        // storage: its initializer has already written the value into the
        // object's `.data` slot, so read it back and treat it as a
        // constant (`static const int N = 8; char buf[N * 2 + 1];`).
        if self.lex.tk == Token::Id {
            let idx = self.lex.curr_id_idx;
            let sym = &self.symbols[idx];
            if sym.is_const_qualified && sym.class == Token::Glo as i64 && !sym.is_extern_decl {
                let ty = sym.type_;
                let off = sym.val as usize;
                let size = self.size_of_type(ty);
                if (1..=8).contains(&size) && off + size <= self.data.len() {
                    let mut v: i64 = 0;
                    for k in 0..size {
                        v |= (self.data[off + k] as i64) << (k * 8);
                    }
                    // Sign-extend a signed type narrower than 8 bytes.
                    if !is_unsigned_ty(ty) && size < 8 {
                        let sign = 1i64 << (size * 8 - 1);
                        v = (v ^ sign).wrapping_sub(sign);
                    }
                    self.symbols[idx].was_referenced = true;
                    self.next()?;
                    return Ok(ConstVal::Int { val: v as i128, ty });
                }
            }
        }
        // A function designator or an array object decays to its address
        // (C99 6.3.2.1p3/p4): a non-null symbol-relative address constant.
        // A bare scalar global is a load, not a constant, so it falls
        // through. The address folds in a pointer comparison and, in a
        // static initializer, a relocation; the pure-ICE entry points
        // reject it. Only in an evaluated context (a not-taken `?:` arm may
        // hold a non-constant call the skip below consumes) and only for a
        // bare name: a trailing postfix (`(`/`[`/`.`/`->`) is a call or an
        // element access, which the enclosing grammar handles.
        if self.lex.tk == Token::Id && self.const_unevaluated == 0 {
            let idx = self.lex.curr_id_idx;
            let class = self.symbols[idx].class;
            let is_fn = class == Token::Fun as i64 || class == Token::Sys as i64;
            let is_array = class == Token::Glo as i64 && self.symbols[idx].array_size != 0;
            if is_fn || is_array {
                let snap = self.lex.snapshot();
                self.next()?;
                let postfix = self.lex.tk == '('
                    || self.lex.tk == Token::Brak
                    || self.lex.tk == Token::Dot
                    || self.lex.tk == Token::Arrow;
                if postfix {
                    self.restore_lex(snap);
                } else {
                    // A libc-bound name has no code address of its own; its
                    // relocation target is the synthesised trampoline.
                    let idx = if class == Token::Sys as i64 {
                        self.ensure_sys_trampoline_sym(idx)
                    } else {
                        idx
                    };
                    self.symbols[idx].was_referenced = true;
                    let elem_size = if is_fn {
                        1
                    } else {
                        (self.size_of_type(self.symbols[idx].type_) as i64).max(1)
                    };
                    return Ok(ConstVal::Addr(ConstAddr {
                        value: self.symbols[idx].val,
                        root: ConstRoot::code_or_data(idx, is_fn),
                        elem_size,
                    }));
                }
            }
        }
        // A non-constant operand. In a not-evaluated subexpression (C99
        // 6.6p3) -- a not-taken `?:` arm or a short-circuited `||` / `&&`
        // operand -- it need not be a constant expression, so consume it and
        // yield a placeholder the enclosing operator discards; name lookup
        // still applies (6.5.1), so require a declared identifier. Otherwise
        // it makes the expression non-constant, which an array declarator
        // reads through `const_expr_nonconst` to tell a C99 6.7.6.2 VLA
        // dimension from a constant-expression error.
        if self.const_unevaluated > 0
            && self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].class != 0
        {
            self.skip_unevaluated_operand()?;
            return Ok(ConstVal::int(0));
        }
        let id_suffix = if self.lex.tk == Token::Id {
            format!(" `{}`", self.symbols[self.lex.curr_id_idx].name)
        } else {
            alloc::string::String::new()
        };
        self.pending.const_expr_nonconst = true;
        Err(self.compile_err(format!(
            "constant integer expected (got {}{id_suffix})",
            super::super::token::describe(self.lex.tk),
        )))
    }
}

/// Compare two staged literals, each `(offset, length)` into `data` with
/// an unstaged NUL at `offset + length`. `n` bounds the comparison (`None`
/// for `strcmp`) and `stop_at_nul` ends it at a shared NUL, which `memcmp`
/// does not do. The result is the sign of the first differing byte pair
/// compared as `unsigned char`; C99 7.21.4 fixes only the sign, and gcc
/// likewise normalizes to -1 / 0 / 1. `None` declines a count that reads
/// past either literal's object.
fn compare_literal_bytes(
    data: &[u8],
    a: (usize, usize),
    b: (usize, usize),
    n: Option<usize>,
    stop_at_nul: bool,
) -> Option<i64> {
    let byte = |(off, len): (usize, usize), i: usize| -> Option<u8> {
        match i.cmp(&len) {
            core::cmp::Ordering::Less => Some(data[off + i]),
            core::cmp::Ordering::Equal => Some(0),
            core::cmp::Ordering::Greater => None,
        }
    };
    let limit = n.unwrap_or(usize::MAX);
    for i in 0..limit {
        let (ca, cb) = (byte(a, i)?, byte(b, i)?);
        if ca != cb {
            return Some(if ca < cb { -1 } else { 1 });
        }
        if stop_at_nul && ca == 0 {
            break;
        }
    }
    Some(0)
}

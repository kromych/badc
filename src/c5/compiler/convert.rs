//! Width / signedness normalisation helpers for the arithmetic and
//! comparison codegen.
//!
//! C99 6.3.1.8 ("usual arithmetic conversions") picks a *common
//! type* for mixed-width operands; on a 64-bit accumulator the
//! op-level encoding then has to mask the result back down to that
//! type's storage width so the next consumer sees the right bits.
//! These helpers consolidate the three places that need to think
//! about it:
//!
//!   * `maybe_mask_operands_to_unsigned_common` -- pre-divide /
//!     pre-modulo masking when the common type is unsigned and one
//!     operand carries sign-extension bits.
//!   * `maybe_mask_to_unsigned_width` -- post-add / sub / mul
//!     narrowing of the accumulator to the common type's width.
//!   * `emit_eq_with_common_width` -- `==` / `!=` with a fold-then-
//!     mask-then-compare-zero strategy when one side is sign-
//!     extended and the other is zero-extended at a narrow width.
//!
//! All three are called from inside the precedence-climbing loop in
//! `expr()`; centralising them here keeps the per-operator branches
//! readable.

use super::super::op::Op;
use super::Compiler;
use super::types::{is_floating_scalar, is_pointer_ty, is_unsigned_ty, usual_arith_common_ty};

impl Compiler {
    /// Pre-divide / pre-modulo C99 6.3.1.3 conversion to the unsigned
    /// common type. When one operand is signed and the common type is
    /// unsigned narrower than 8 bytes, the signed operand carries
    /// sign-extended high bits in the 64-bit accumulator
    /// (`(int)-1` is `0xFFFFFFFFFFFFFFFF`); the unsigned-divide op
    /// would treat that as a huge positive instead of the 32-bit
    /// `0xFFFFFFFF` C99 prescribes. Mask both operands to the common
    /// width before the divide.
    ///
    /// Layout going in: stack-top = LHS, accumulator = RHS.
    /// Layout going out: same shape, but each masked to `common`.
    pub(super) fn maybe_mask_operands_to_unsigned_common(&mut self, lhs_ty: i64, rhs_ty: i64) {
        let common = usual_arith_common_ty(lhs_ty, rhs_ty, self.target);
        if !is_unsigned_ty(common) {
            return;
        }
        let mask: i64 = match self.size_of_type(common) {
            1 => 0xff,
            2 => 0xffff,
            4 => 0xffff_ffff,
            _ => return,
        };
        // Stash RHS to a scratch local so we can pop the LHS off the
        // c5 stack into the accumulator, mask it, push it back, and
        // reload RHS for the divide.
        self.loc_offs += 1;
        if self.loc_offs > self.max_loc_offs {
            self.max_loc_offs = self.loc_offs;
        }
        let temp = -self.loc_offs;
        self.emit_op(Op::StLocI);
        self.emit_val(temp);
        // Pop LHS off the c5 stack into accumulator: `Imm 0; Or` pops
        // stack-top into acc by virtue of `Op::Or` ORing acc with the
        // popped stack-top (acc was set to 0 a moment ago).
        self.emit_imm(0);
        self.emit_op(Op::Or);
        self.emit_binop_with_imm(Op::And, mask);
        self.emit_op(Op::Psh);
        self.emit_lea(temp);
        self.emit_op(Op::Li);
        self.emit_binop_with_imm(Op::And, mask);
    }

    /// After an Add / Sub / Mul, normalize the 64-bit accumulator
    /// to the C99 6.3.1.8 common type's storage width.
    ///
    /// Unsigned common type: mask with `(1 << N) - 1`. C99 mandates
    /// wrap-modulo-2^N; without this `(uint)0xFFFFFFFF + 1u` leaves
    /// 0x100000000 in the 64-bit register, and any consumer that
    /// widens the result before it reaches a typed slot
    /// (a long-typed slot, a variadic FP boundary, an
    /// immediately-following cast) reads the wider value.
    ///
    /// Signed common type: signed-int overflow is undefined behavior
    /// per C99 6.5p5, but clang and gcc both consistently truncate
    /// the result to the type's width and sign-extend back. c5
    /// matches that convention via `Shl K; Shr K` where `K = 64 -
    /// width_bits`. So `(int)50000 * (int)50000` becomes
    /// 0x9502F900 sign-extended = -1794967296.
    pub(super) fn maybe_mask_to_unsigned_width(&mut self, lhs_ty: i64, rhs_ty: i64) {
        if is_pointer_ty(lhs_ty) || is_pointer_ty(rhs_ty) {
            return;
        }
        if is_floating_scalar(lhs_ty) || is_floating_scalar(rhs_ty) {
            return;
        }
        let common = usual_arith_common_ty(lhs_ty, rhs_ty, self.target);
        let common_size = self.size_of_type(common);
        if is_unsigned_ty(common) {
            let mask: i64 = match common_size {
                1 => 0xff,
                2 => 0xffff,
                4 => 0xffff_ffff,
                _ => return,
            };
            self.emit_binop_with_imm(Op::And, mask);
        } else {
            // Signed: integer promotion already widens char / short
            // to int, so the only narrow signed common type that
            // reaches here is `int` (size 4), or `long` on LLP64
            // (also size 4). Width-8 signed types fill the
            // accumulator and need no normalization.
            let shift_bits: i64 = match common_size {
                1 => 56,
                2 => 48,
                4 => 32,
                _ => return,
            };
            self.emit_binop_with_imm(Op::Shl, shift_bits);
            self.emit_binop_with_imm(Op::Shr, shift_bits);
        }
    }

    /// Emit `==` (or `!=` if `invert`) accounting for C99 6.3.1.8
    /// usual-arithmetic-conversions when the LHS / RHS have
    /// different signedness or widths.
    ///
    /// Plain `Op::Eq` is bit-equality at 64 bits, which goes wrong
    /// when (a) the common type is narrower than 8 bytes and
    /// (b) one operand is sign-extended into the high half while
    /// the other isn't. e.g. `(int)-1 == (uint)0xFFFFFFFF` should be
    /// true at the common `unsigned int` width, but the LHS lives
    /// in the register as 0xFFFFFFFFFFFFFFFF (sign-extended via
    /// `Op::Lw`) and the RHS as 0x00000000FFFFFFFF (zero-extended
    /// via `Op::Lwu`), so straight `Eq` returns false.
    ///
    /// Strategy: if the common type is narrower than 8 bytes, fold
    /// the LHS-on-stack and RHS-in-acc through XOR (which pops the
    /// stack), AND with the common-width mask, then compare against
    /// 0. Equal iff the masked-XOR is 0. The `Op::Xor` -> `Op::And`
    /// -> `Op::Eq`/`Op::Ne` sequence is 5 ops; the wide-common
    /// path uses 1, so the cost only lands on mixed-width sites.
    pub(super) fn emit_eq_with_common_width(&mut self, lhs_ty: i64, invert: bool) {
        let plain_op = if invert { Op::Ne } else { Op::Eq };
        // Pointers are 8 bytes regardless of pointee type and are
        // always compared as full-width values; the common-width
        // mask is only correct for actual integers. `p == 0`
        // would otherwise mask the pointer to 32 bits and accept
        // any pointer with low-half-zero as NULL.
        if is_pointer_ty(lhs_ty) || is_pointer_ty(self.ty) {
            self.emit_op(plain_op);
            return;
        }
        // The XOR-mask trick only matters when one operand is
        // signed and the other unsigned at a width narrower than
        // 8 bytes -- that's when the sign-extension into the
        // 64-bit register can make `(int)-1 == (uint)0xFFFFFFFF`
        // come out false. When both operands have the same
        // signedness, both loads produce matching 64-bit
        // representations and plain `Op::Eq` already does the
        // right thing. Skipping the trick for the same-
        // signedness case keeps the per-eq cost at 1 op for the
        // overwhelmingly common path.
        let lhs_unsigned = is_unsigned_ty(lhs_ty);
        let rhs_unsigned = is_unsigned_ty(self.ty);
        if lhs_unsigned == rhs_unsigned {
            self.emit_op(plain_op);
            return;
        }
        let common = usual_arith_common_ty(lhs_ty, self.ty, self.target);
        let common_size = self.size_of_type(common);
        if common_size >= 8 {
            self.emit_op(plain_op);
            return;
        }
        // Narrow common type, mixed signedness: emit
        // XOR-then-mask-then-compare-zero so the comparison sees
        // only the low common-width bytes.
        let mask: i64 = match common_size {
            1 => 0xff,
            2 => 0xffff,
            4 => 0xffff_ffff,
            _ => -1,
        };
        if mask == -1 {
            self.emit_op(plain_op);
            return;
        }
        // Acc holds RHS; stack-top holds LHS. `Op::Xor` does
        // `acc = acc XOR top, sp += 8` -- after this, acc holds
        // `LHS XOR RHS` (XOR is commutative) and the stack is
        // restored to its pre-comparison state.
        self.emit_op(Op::Xor);
        // Mask the XOR to the common-type width: the comparison
        // only cares about the low N bytes.
        self.emit_binop_with_imm(Op::And, mask);
        // Compare against 0.
        self.emit_binop_with_imm(plain_op, 0);
    }
}

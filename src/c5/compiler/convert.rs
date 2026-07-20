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

use super::Compiler;
use super::types::{
    is_bool_ty, is_float_ty, is_floating_scalar, is_pointer_ty, is_struct_ty, is_unsigned_ty,
};

impl Compiler {
    /// Apply the C99 6.5.16.1p2 assignment conversion: when the
    /// destination is a floating type and `a` holds an integer-
    /// typed value, lift through the int-to-float cast; when
    /// the destination is an integer / pointer and `a` holds a
    /// float / double, drop through the float-to-int cast. When both
    /// sides are floating but at different precision (C99 6.3.1.5),
    /// wrap in the float<->double cast so the walker narrows / widens.
    /// Same-precision floating assignments leave the bit pattern alone.
    /// Called from every scalar store path so an `unsigned char`
    /// initializer of a `float` local / global / struct field
    /// round-trips through the IEEE-754 representation rather than the
    /// raw integer bit pattern.
    pub(super) fn convert_assign_rhs(&mut self, dest_ty: i64) {
        // C99 6.3.1.2: storing any scalar into a `_Bool` lvalue
        // normalises it to 0 / 1. Wrap the accumulator in an
        // `Expr::Cast` to `_Bool` so the walker emits the `!= 0`
        // test; a source already typed `_Bool` is already 0 / 1
        // and needs no re-normalisation.
        if is_bool_ty(dest_ty) && !is_bool_ty(self.ty) {
            self.ast_apply_assign_conv(dest_ty);
            self.ty = dest_ty;
            return;
        }
        let dest_is_fp = is_floating_scalar(dest_ty);
        let src_is_fp = is_floating_scalar(self.ty);
        // The GCC 128-bit integer against any other scalar in either
        // direction is a value conversion (C99 6.3.1.3 / 6.3.1.4), not
        // an aggregate copy: the walker's cast arm widens or narrows
        // the scalar, or converts the 128-bit value, including to and
        // from a floating type. A plain struct on the other side stays
        // a type mismatch and is diagnosed by the caller.
        if self.is_int128_ty(dest_ty) != self.is_int128_ty(self.ty)
            && !(is_struct_ty(dest_ty) && is_struct_ty(self.ty))
        {
            self.ast_apply_assign_conv(dest_ty);
            self.ty = dest_ty;
            return;
        }
        if dest_is_fp && !src_is_fp && !is_pointer_ty(self.ty) {
            self.ast_fpcast();
            // Dual-emit: wrap the accumulator in an
            // `Expr::Cast` so the walker emits the matching
            // `Inst::FpCast(IntToFp)`. The walker keys on the
            // cast's `to_ty` vs the child's source type to pick
            // the conversion kind.
            self.ast_apply_assign_conv(dest_ty);
            self.ty = dest_ty;
        } else if !dest_is_fp && src_is_fp && !is_pointer_ty(dest_ty) {
            self.ast_fpcast();
            self.ast_apply_assign_conv(dest_ty);
            self.ty = dest_ty;
        } else if dest_is_fp && src_is_fp && is_float_ty(dest_ty) != is_float_ty(self.ty) {
            // `double` -> `float` (narrow) or `float` -> `double`
            // (widen). The walker's `Expr::Cast` arm emits the matching
            // `Inst::FpCast(F64ToF32 / F32ToF64)` per C99 6.3.1.5.
            self.ast_apply_assign_conv(dest_ty);
            self.ty = dest_ty;
        }
    }

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
        let common = self.arith_common_ty(lhs_ty, rhs_ty);
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
        let temp = self.reserve_slots(1);
        self.mark_emit_other();
        // Pop LHS off the c5 stack into accumulator: `Imm 0; Or`
        // pops stack-top into acc by virtue of `BinOp::Or` ORing
        // acc with the popped stack-top (acc was set to 0 a
        // moment ago).
        self.emit_imm(0);
        self.ast_binop(crate::c5::ir::BinOp::Or);
        self.emit_binop_with_imm(crate::c5::ir::BinOp::And, mask);
        self.ast_psh();
        self.emit_lea(temp);
        self.mark_emit_other();
        self.emit_binop_with_imm(crate::c5::ir::BinOp::And, mask);
    }

    /// After an Add / Sub / Mul, renormalize the 64-bit accumulator to
    /// the C99 6.3.1.8 common type's storage width. Without it
    /// `(uint)0xFFFFFFFF + 1u` leaves 0x100000000 in the register and any
    /// consumer that widens the result before a typed slot (a long-typed
    /// slot, a variadic FP boundary, an immediately-following cast) reads
    /// the wider value; `(int)50000 * (int)50000` reads as a positive
    /// 0x9502F900 instead of -1794967296.
    pub(super) fn maybe_mask_to_unsigned_width(&mut self, lhs_ty: i64, rhs_ty: i64) {
        if is_pointer_ty(lhs_ty) || is_pointer_ty(rhs_ty) {
            return;
        }
        if is_floating_scalar(lhs_ty) || is_floating_scalar(rhs_ty) {
            return;
        }
        let common = self.arith_common_ty(lhs_ty, rhs_ty);
        self.renormalize_to_width(common);
    }

    /// Renormalize the 64-bit accumulator to the storage width of an
    /// integer type `ty` after an operation that can overflow that width.
    ///
    /// Unsigned: mask with `(1 << N) - 1` (C99 6.2.5p9 wrap-modulo-2^N).
    /// Signed: `Shl K; Shr K` with `K = 64 - width_bits`, truncating to
    /// the width and sign-extending back (matches clang/gcc for the
    /// overflow that 6.5p5 leaves undefined). Width 8 fills the
    /// accumulator and needs nothing. Integer promotion already widens
    /// char/short to int, so a narrow type reaching the signed path is
    /// `int` (or LLP64 `long`), size 4. The shift pair folds to a single
    /// `sxtw`/`movslq` at emit time.
    pub(super) fn renormalize_to_width(&mut self, ty: i64) {
        let size = self.size_of_type(ty);
        if !matches!(size, 1 | 2 | 4) {
            return;
        }
        if is_unsigned_ty(ty) {
            let mask: i64 = match size {
                1 => 0xff,
                2 => 0xffff,
                _ => 0xffff_ffff,
            };
            self.emit_binop_with_imm(crate::c5::ir::BinOp::And, mask);
        } else {
            let shift_bits = 64 - size as i64 * 8;
            self.emit_binop_with_imm(crate::c5::ir::BinOp::Shl, shift_bits);
            self.emit_binop_with_imm(crate::c5::ir::BinOp::Shr, shift_bits);
        }
    }

    /// Emit `==` (or `!=` if `invert`) accounting for C99 6.3.1.8
    /// usual-arithmetic-conversions when the LHS / RHS have
    /// different signedness or widths.
    ///
    /// Plain `BinOp::Eq` is bit-equality at 64 bits, which goes wrong
    /// when (a) the common type is narrower than 8 bytes and
    /// (b) one operand is sign-extended into the high half while
    /// the other isn't. e.g. `(int)-1 == (uint)0xFFFFFFFF` should be
    /// true at the common `unsigned int` width, but the LHS lives
    /// in the register as 0xFFFFFFFFFFFFFFFF (sign-extended via
    /// `LoadKind::I32`) and the RHS as 0x00000000FFFFFFFF (zero-extended
    /// via `LoadKind::U32`), so straight `Eq` returns false.
    ///
    /// Strategy: if the common type is narrower than 8 bytes, fold
    /// the LHS-on-stack and RHS-in-acc through XOR (which pops the
    /// stack), AND with the common-width mask, then compare against
    /// 0. Equal iff the masked-XOR is 0. The
    /// `BinOp::Xor` -> `BinOp::And` -> `BinOp::Eq`/`BinOp::Ne`
    /// sequence is 5 ops; the wide-common path uses 1, so the
    /// cost only lands on mixed-width sites.
    pub(super) fn emit_eq_with_common_width(&mut self, lhs_ty: i64, invert: bool) {
        use super::super::ir::BinOp as B;
        let plain_op = if invert { B::Ne } else { B::Eq };
        // Pointers are 8 bytes regardless of pointee type and are
        // always compared as full-width values; the common-width
        // mask is only correct for actual integers. `p == 0`
        // would otherwise mask the pointer to 32 bits and accept
        // any pointer with low-half-zero as NULL.
        if is_pointer_ty(lhs_ty) || is_pointer_ty(self.ty) {
            self.ast_binop(plain_op);
            return;
        }
        // The XOR-mask sequence is only needed when one operand
        // is signed and the other unsigned at a width narrower
        // than 8 bytes -- that's when the sign-extension into the
        // 64-bit register can make `(int)-1 == (uint)0xFFFFFFFF`
        // come out false. Matching signedness produces matching
        // 64-bit representations and plain `B::Eq` is correct on
        // its own. Skipping the mask for the same-signedness case
        // keeps the per-eq cost at 1 op.
        let lhs_unsigned = is_unsigned_ty(lhs_ty);
        let rhs_unsigned = is_unsigned_ty(self.ty);
        if lhs_unsigned == rhs_unsigned {
            self.ast_binop(plain_op);
            return;
        }
        let common = self.arith_common_ty(lhs_ty, self.ty);
        let common_size = self.size_of_type(common);
        if common_size >= 8 {
            self.ast_binop(plain_op);
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
            self.ast_binop(plain_op);
            return;
        }
        // Acc holds RHS; stack-top holds LHS. `BinOp::Xor` does
        // `acc = acc XOR top, sp += 8` -- after this, acc holds
        // `LHS XOR RHS` (XOR is commutative) and the stack is
        // restored to its pre-comparison state.
        self.ast_binop(crate::c5::ir::BinOp::Xor);
        // Mask the XOR to the common-type width: the comparison
        // only cares about the low N bytes.
        self.emit_binop_with_imm(crate::c5::ir::BinOp::And, mask);
        // Compare against 0.
        self.emit_binop_with_imm(plain_op, 0);
    }
}

//! C99 6.7.2.1 bitfield access: reading a slice out of its storage unit
//! and merging a value back into it.

use super::access::{load_kind_for_width, load_place, store_kind_for_width, store_place};
use super::types::{expr_ty, is_bool_scalar, is_floating_scalar};
use super::*;

impl<'a> Walker<'a> {
    /// [`Self::access_seg`] for a bitfield's storage unit. A 16-byte
    /// unit is accessed as two 64-bit halves through the generic-space
    /// 128-bit helpers, which carry no segment; reject that combination.
    pub(super) fn bitfield_access_seg(
        &self,
        id: ExprId,
        ty: i64,
        bf: BitfieldDesc,
    ) -> Result<AsmSeg, WalkError> {
        let seg = self.access_seg(id, ty)?;
        if seg != AsmSeg::None && bf.unit_size == 16 {
            return Err(WalkError::UnsupportedExpr {
                id,
                kind: "16-byte bitfield unit in a named address space",
            });
        }
        Ok(seg)
    }

    /// Read the bitfield at `addr` as a value of its declared type (C99
    /// 6.7.2.1p10: a signed field sign-extends from its width). A
    /// 16-byte unit yields the address of a fresh 128-bit temporary,
    /// the form a 128-bit value takes everywhere else.
    pub(super) fn load_from_bitfield(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        bf: BitfieldDesc,
        seg: AsmSeg,
        vol: bool,
        align: u8,
    ) -> ValueId {
        let w = bf.bit_width as i64;
        if bf.unit_size == 16 {
            let v = self.bitfield_extract_128(b, addr, bf, vol);
            return self.bitfield_value_form(b, bf, v);
        }
        let mut v = load_place(b, addr, bitfield_load_kind(bf), seg, vol, align);
        if bf.bit_offset > 0 {
            v = b.binop_imm(BinOp::Shr, v, bf.bit_offset as i64);
        }
        v = b.binop_imm(BinOp::And, v, bitfield_mask_halves(bf.bit_width, 0).0);
        if bf.signed && w < 64 {
            v = b.binop_imm(BinOp::Shl, v, 64 - w);
            v = b.binop_imm(BinOp::Shr, v, 64 - w);
        }
        v
    }

    /// Store `value`'s low `bf.bit_width` bits into the bitfield at
    /// `addr` (C99 6.7.2.1): load the storage unit, clear the field's
    /// slice, shift + mask the value into place, OR, and store back.
    /// Returns the assignment's value per C99 6.5.16p3 -- the stored
    /// field converted to its declared type, not the storage word. A
    /// 16-byte unit takes and returns a 128-bit object's address.
    #[allow(clippy::too_many_arguments)]
    pub(super) fn store_into_bitfield(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        bf: BitfieldDesc,
        value: ValueId,
        seg: AsmSeg,
        vol: bool,
        align: u8,
    ) -> ValueId {
        let w = bf.bit_width as i64;
        let (mask_lo, mask_hi) = bitfield_mask_halves(bf.bit_width, 0);
        if bf.unit_size == 16 {
            let src = if bf.is_wide_value() {
                self.int128_load_vol(b, value, false)
            } else {
                (value, b.imm(0))
            };
            let masked = Self::int128_and_imm(b, src, (mask_lo, mask_hi));
            self.bitfield_insert_128(b, addr, bf, masked, vol);
            let out = self.bitfield_sign_extend_128(b, bf, masked);
            return self.bitfield_value_form(b, bf, out);
        }
        let masked = merge_into_bitfield(b, addr, bf, value, seg, vol, align);
        if bf.signed && w < 64 {
            let up = b.binop_imm(BinOp::Shl, masked, 64 - w);
            b.binop_imm(BinOp::Shr, up, 64 - w)
        } else {
            masked
        }
    }

    /// Walk the value written to a bitfield into the form
    /// [`Self::store_into_bitfield`] expects: the address of a 128-bit
    /// object when the access is 128-bit (widening a narrower source per
    /// C99 6.3.1.3), a scalar otherwise.
    pub(super) fn bitfield_store_value(
        &mut self,
        b: &mut SsaBuilder,
        bf: BitfieldDesc,
        rhs: ExprId,
    ) -> Result<ValueId, WalkError> {
        if bf.is_wide_value() {
            let pair = self.int128_operand(b, rhs)?;
            return Ok(self.int128_materialize(b, pair));
        }
        let is128 = self.expr_is_int128_value(rhs);
        let v = self.walk_copy_operand(b, rhs)?;
        // C99 6.3.1.3: a 128-bit source narrows to the field's type,
        // which is its low half -- not the address the value is carried as.
        let v = if is128 { b.load(v, LoadKind::I64) } else { v };
        // C99 6.5.16.1p2: the value is converted to the type of the left
        // operand. A floating source needs the 6.3.1.4 conversion here --
        // the store's mask is an integer operation and cannot express it.
        let src_ty = expr_ty(self.ast.expr(rhs)).unwrap_or(bf.ty);
        Ok(if is_floating_scalar(src_ty) {
            self.convert_scalar_value(b, v, src_ty, bf.ty)
        } else {
            v
        })
    }

    /// The field's bits, right-aligned in a 128-bit storage unit and
    /// converted to its declared type (C99 6.7.2.1p10 sign extension).
    pub(super) fn bitfield_extract_128(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        bf: BitfieldDesc,
        vol: bool,
    ) -> Halves {
        let unit = self.int128_load_vol(b, addr, vol);
        let v = Self::int128_shift_const(b, BinOp::Shru, unit, bf.bit_offset as i64);
        let v = Self::int128_and_imm(b, v, bitfield_mask_halves(bf.bit_width, 0));
        self.bitfield_sign_extend_128(b, bf, v)
    }

    /// Merge a right-aligned, already width-masked value into the
    /// field's slice of its 128-bit storage unit.
    pub(super) fn bitfield_insert_128(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        bf: BitfieldDesc,
        masked: Halves,
        vol: bool,
    ) {
        let placed = Self::int128_shift_const(b, BinOp::Shl, masked, bf.bit_offset as i64);
        let (keep_lo, keep_hi) = bitfield_mask_halves(bf.bit_width, bf.bit_offset);
        let old = self.int128_load_vol(b, addr, vol);
        let cleared = Self::int128_and_imm(b, old, (!keep_lo, !keep_hi));
        let merged = (
            b.binop(BinOp::Or, cleared.0, placed.0),
            b.binop(BinOp::Or, cleared.1, placed.1),
        );
        self.int128_store_vol(b, addr, merged, vol);
    }

    /// Sign-extend a right-aligned signed field's value through all 128
    /// bits (C99 6.7.2.1p10); an unsigned field is already zero-filled.
    pub(super) fn bitfield_sign_extend_128(
        &mut self,
        b: &mut SsaBuilder,
        bf: BitfieldDesc,
        v: Halves,
    ) -> Halves {
        let w = bf.bit_width as i64;
        if !bf.signed || w >= 128 {
            return v;
        }
        let up = Self::int128_shift_const(b, BinOp::Shl, v, 128 - w);
        Self::int128_shift_const(b, BinOp::Shr, up, 128 - w)
    }

    /// A 128-bit unit's extracted value in the form the access yields:
    /// a fresh 128-bit object's address for a 128-bit access, the low
    /// half for one the integer promotions narrow.
    pub(super) fn bitfield_value_form(
        &mut self,
        b: &mut SsaBuilder,
        bf: BitfieldDesc,
        v: Halves,
    ) -> ValueId {
        if bf.is_wide_value() {
            self.int128_materialize(b, v)
        } else {
            v.0
        }
    }

    /// True when `lvalue` names a bitfield stored in a 16-byte unit.
    /// Its read-modify-write operators go through the 128-bit path even
    /// when the integer promotions narrow the value.
    pub(super) fn is_wide_unit_bitfield(&self, lvalue: ExprId) -> bool {
        matches!(
            self.ast.expr(lvalue),
            Expr::Member {
                bitfield: Some(bf),
                ..
            } if bf.unit_size == 16
        )
    }

    /// Mask both halves of a 128-bit value with a constant pair.
    pub(super) fn int128_and_imm(b: &mut SsaBuilder, v: Halves, (lo, hi): (i64, i64)) -> Halves {
        (
            b.binop_imm(BinOp::And, v.0, lo),
            b.binop_imm(BinOp::And, v.1, hi),
        )
    }

    /// The storage-unit address and descriptor when `lvalue` names a
    /// bitfield in a 16-byte unit, evaluating the object once (C99
    /// 6.5.16.2p3). Only the 128-bit read-modify-write path calls it; a
    /// narrower unit stays on the scalar `RmwPlace` path.
    pub(super) fn wide_bitfield_place(
        &mut self,
        b: &mut SsaBuilder,
        lvalue: ExprId,
    ) -> Result<Option<(ValueId, BitfieldDesc)>, WalkError> {
        let Expr::Member {
            obj,
            field_off,
            bitfield: Some(bf),
            ..
        } = self.ast.expr(lvalue)
        else {
            return Ok(None);
        };
        let (bf, obj, field_off) = (*bf, *obj, *field_off);
        if bf.unit_size != 16 {
            return Ok(None);
        }
        let base = self.walk_expr_rvalue(b, obj)?;
        let addr = if field_off != 0 {
            b.binop_imm(BinOp::Add, base, field_off)
        } else {
            base
        };
        Ok(Some((addr, bf)))
    }
}

/// Merge `value` into the bitfield at `addr` (C99 6.7.2.1): load the
/// storage unit, clear the field's slice, shift the value into place,
/// OR, and store back. Returns the value the width mask kept,
/// right-aligned -- the assignment expression's value per C99 6.5.16p3.
/// Every narrow bitfield store reaches this.
pub(super) fn merge_into_bitfield(
    b: &mut SsaBuilder,
    addr: ValueId,
    bf: BitfieldDesc,
    value: ValueId,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) -> ValueId {
    let (load_kind, store_kind) = (bitfield_load_kind(bf), bitfield_store_kind(bf));
    // C99 6.5.16.1p2 converts the value to the field's declared type.
    // The width mask below is that conversion for every integer type;
    // `_Bool` is not, since 6.3.1.2 maps every nonzero value to 1.
    let value = if is_bool_scalar(bf.ty) {
        b.binop_imm(BinOp::Ne, value, 0)
    } else {
        value
    };
    let masked = b.binop_imm(BinOp::And, value, bitfield_mask_halves(bf.bit_width, 0).0);
    let old = load_place(b, addr, load_kind, seg, vol, align);
    let cleared = b.binop_imm(
        BinOp::And,
        old,
        !bitfield_mask_halves(bf.bit_width, bf.bit_offset).0,
    );
    let shifted = if bf.bit_offset > 0 {
        b.binop_imm(BinOp::Shl, masked, bf.bit_offset as i64)
    } else {
        masked
    };
    let combined = b.binop(BinOp::Or, cleared, shifted);
    store_place(b, addr, combined, store_kind, seg, vol, align);
    masked
}

/// A bitfield's slice mask as the low and high halves of a 128-bit
/// storage unit. A unit of 8 bytes or less uses the low half alone.
pub(super) fn bitfield_mask_halves(width: u8, offset: u8) -> (i64, i64) {
    let m = bitfield_slice_mask(width as u32, offset as u32);
    (m as u64 as i64, (m >> 64) as u64 as i64)
}

/// Load kind for a bitfield's addressable storage unit (C99 6.7.2.1p11).
/// The unsigned kinds keep the unit's bits at their storage positions so
/// the extraction's shift and mask see no sign extension from above.
pub(super) fn bitfield_load_kind(bf: BitfieldDesc) -> LoadKind {
    load_kind_for_width(bf.unit_size as u32)
}

/// Store kind for a bitfield's addressable storage unit.
fn bitfield_store_kind(bf: BitfieldDesc) -> StoreKind {
    store_kind_for_width(bf.unit_size as u32)
}

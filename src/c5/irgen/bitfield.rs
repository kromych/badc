//! C99 6.7.2.1 bitfield access: reading a slice out of its storage unit
//! and merging a value back into it.

use super::access::{
    access_align, load_kind_for_width, load_place, store_kind_for_width, store_place,
};
use super::types::{is_bool_scalar, is_floating_scalar};
use super::*;
use crate::c5::ast::{bitfield_keeps_declared_ty, expr_ty};

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
        if seg != AsmSeg::None && bf.is_wide_unit() {
            return Err(WalkError::UnsupportedExpr {
                id,
                kind: "16-byte bitfield unit in a named address space",
            });
        }
        Ok(seg)
    }

    /// True when the bitfield's value is a 128-bit integer: an `__int128`
    /// field the integer promotions leave at its declared type (C99
    /// 6.3.1.1p2), in a storage unit of any width.
    pub(super) fn bitfield_is_int128(&self, bf: BitfieldDesc) -> bool {
        bitfield_keeps_declared_ty(bf.bit_width as u32) && self.is_int128_value_ty(bf.ty)
    }

    /// Read the bitfield at `addr` as a value of its declared type (C99
    /// 6.7.2.1p10: a signed field sign-extends from its width). A 128-bit
    /// value yields the address of a fresh 128-bit temporary, the form a
    /// 128-bit value takes everywhere else.
    pub(super) fn load_from_bitfield(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        bf: BitfieldDesc,
        seg: AsmSeg,
        vol: bool,
        align: u8,
    ) -> ValueId {
        if self.bitfield_is_int128(bf) {
            let v = extract_halves(b, addr, bf, seg, vol, align);
            return self.int128_materialize(b, v);
        }
        extract_bitfield(b, addr, bf, seg, vol, align)
    }

    /// Store `value`'s low `bf.bit_width` bits into the bitfield at
    /// `addr` (C99 6.7.2.1): load the storage unit, clear the field's
    /// slice, shift + mask the value into place, OR, and store back.
    /// Returns the assignment's value per C99 6.5.16p3 -- the stored
    /// field converted to its declared type, not the storage word. A
    /// 128-bit value is taken and returned as a 128-bit object's address.
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
        if self.bitfield_is_int128(bf) {
            let src = self.int128_load_vol(b, value, false);
            let masked = Self::int128_and_imm(b, src, bitfield_mask_halves(bf.bit_width, 0));
            insert_halves(b, addr, bf, masked, seg, vol, align);
            let out = sign_extend_halves(b, bf, masked);
            return self.int128_materialize(b, out);
        }
        let w = bf.bit_width as i64;
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
        if self.bitfield_is_int128(bf) {
            let pair = self.int128_operand(b, rhs)?;
            return Ok(self.int128_materialize(b, pair));
        }
        let is128 = self.expr_is_int128_value(rhs);
        let v = self.walk_copy_operand(b, rhs)?;
        // C99 6.3.1.3: a 128-bit source narrows to the field's type,
        // which is its low half -- not the address the value is carried
        // as. A `_Bool` field tests the whole value (6.3.1.2).
        let v = if is128 && is_bool_scalar(bf.ty) {
            let pair = self.int128_load(b, v);
            Self::int128_to_bool(b, pair)
        } else if is128 {
            b.load(v, LoadKind::I64)
        } else {
            v
        };
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

    /// Mask both halves of a 128-bit value with a constant pair.
    pub(super) fn int128_and_imm(b: &mut SsaBuilder, v: Halves, (lo, hi): (i64, i64)) -> Halves {
        (
            b.binop_imm(BinOp::And, v.0, lo),
            b.binop_imm(BinOp::And, v.1, hi),
        )
    }

    /// The storage-unit address, descriptor and alignment bound when
    /// `lvalue` names a bitfield, evaluating the object once (C99
    /// 6.5.16.2p3). The read-modify-write of a 128-bit value calls it.
    pub(super) fn bitfield_place(
        &mut self,
        b: &mut SsaBuilder,
        lvalue: ExprId,
    ) -> Result<Option<(ValueId, BitfieldDesc, u8)>, WalkError> {
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
        let base = self.walk_expr_rvalue(b, obj)?;
        let addr = if field_off != 0 {
            b.binop_imm(BinOp::Add, base, field_off)
        } else {
            base
        };
        let align = self.member_align(obj, field_off, bf.unit_size as u32);
        Ok(Some((addr, bf, align)))
    }
}

/// Merge `value` into the bitfield at `addr` (C99 6.7.2.1): load the
/// storage unit, clear the field's slice, shift the value into place,
/// OR, and store back. Returns the value the width mask kept,
/// right-aligned -- the assignment expression's value per C99 6.5.16p3.
/// Every bitfield store of a value of at most 64 bits reaches this.
pub(super) fn merge_into_bitfield(
    b: &mut SsaBuilder,
    addr: ValueId,
    bf: BitfieldDesc,
    value: ValueId,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) -> ValueId {
    // C99 6.5.16.1p2 converts the value to the field's declared type.
    // The width mask below is that conversion for every integer type;
    // `_Bool` is not, since 6.3.1.2 maps every nonzero value to 1.
    let value = if is_bool_scalar(bf.ty) {
        b.binop_imm(BinOp::Ne, value, 0)
    } else {
        value
    };
    let masked = b.binop_imm(BinOp::And, value, bitfield_mask_halves(bf.bit_width, 0).0);
    if bf.is_wide_unit() {
        let high = b.imm(0);
        insert_halves(b, addr, bf, (masked, high), seg, vol, align);
        return masked;
    }
    let old = load_unit(b, addr, bf, seg, vol, align);
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
    store_unit(b, addr, combined, bf, seg, vol, align);
    masked
}

/// Read the bitfield at `addr` as a value of at most 64 bits: shift its
/// slice to bit 0, mask, and sign-extend a signed field (C99 6.7.2.1p10).
pub(super) fn extract_bitfield(
    b: &mut SsaBuilder,
    addr: ValueId,
    bf: BitfieldDesc,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) -> ValueId {
    if bf.is_wide_unit() {
        return extract_halves(b, addr, bf, seg, vol, align).0;
    }
    let w = bf.bit_width as i64;
    let mut v = load_unit(b, addr, bf, seg, vol, align);
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

/// The bitfield at `addr` as 128 bits, right-aligned and sign-extended
/// through both halves (C99 6.7.2.1p10), from a unit of any width.
pub(super) fn extract_halves(
    b: &mut SsaBuilder,
    addr: ValueId,
    bf: BitfieldDesc,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) -> Halves {
    if !bf.is_wide_unit() {
        let low = extract_bitfield(b, addr, bf, seg, vol, align);
        let high = if bf.signed {
            b.binop_imm(BinOp::Shr, low, 63)
        } else {
            b.imm(0)
        };
        return (low, high);
    }
    let unit = load_wide_unit(b, addr, bf, seg, vol, align);
    let v = Walker::int128_shift_const(b, BinOp::Shru, unit, bf.bit_offset as i64);
    let v = Walker::int128_and_imm(b, v, bitfield_mask_halves(bf.bit_width, 0));
    sign_extend_halves(b, bf, v)
}

/// Merge a right-aligned, width-masked 128-bit value into the bitfield at
/// `addr`, in a unit of any width; a unit of at most 8 bytes holds the
/// whole field in the low half.
pub(super) fn insert_halves(
    b: &mut SsaBuilder,
    addr: ValueId,
    bf: BitfieldDesc,
    masked: Halves,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) {
    if !bf.is_wide_unit() {
        merge_into_bitfield(b, addr, bf, masked.0, seg, vol, align);
        return;
    }
    let placed = Walker::int128_shift_const(b, BinOp::Shl, masked, bf.bit_offset as i64);
    let (keep_lo, keep_hi) = bitfield_mask_halves(bf.bit_width, bf.bit_offset);
    let old = load_wide_unit(b, addr, bf, seg, vol, align);
    let cleared = Walker::int128_and_imm(b, old, (!keep_lo, !keep_hi));
    let low = b.binop(BinOp::Or, cleared.0, placed.0);
    let high = b.binop(BinOp::Or, cleared.1, placed.1);
    store_bytes(b, addr, 0, low, 8, seg, vol, align);
    store_bytes(b, addr, 8, high, bf.unit_size - 8, seg, vol, align);
}

/// Sign-extend a right-aligned signed field's value through all 128
/// bits (C99 6.7.2.1p10); an unsigned field is already zero-filled.
pub(super) fn sign_extend_halves(b: &mut SsaBuilder, bf: BitfieldDesc, v: Halves) -> Halves {
    let w = bf.bit_width as i64;
    if !bf.signed || w >= 128 {
        return v;
    }
    let up = Walker::int128_shift_const(b, BinOp::Shl, v, 128 - w);
    Walker::int128_shift_const(b, BinOp::Shr, up, 128 - w)
}

/// A storage unit wider than 8 bytes as its low 8 bytes and the 1 to 8
/// above them, each read in its [`unit_pieces`], so no access reaches
/// past the unit (C99 6.7.2.1p11).
fn load_wide_unit(
    b: &mut SsaBuilder,
    addr: ValueId,
    bf: BitfieldDesc,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) -> Halves {
    (
        load_bytes(b, addr, 0, 8, seg, vol, align),
        load_bytes(b, addr, 8, bf.unit_size - 8, seg, vol, align),
    )
}

/// A bitfield's slice mask as the low and high halves of a 128-bit
/// storage unit. A unit of 8 bytes or less uses the low half alone.
pub(super) fn bitfield_mask_halves(width: u8, offset: u8) -> (i64, i64) {
    let m = bitfield_slice_mask(width as u32, offset as u32);
    (m as u64 as i64, (m >> 64) as u64 as i64)
}

/// `(offset, width)` of each access a `size`-byte storage unit takes: the
/// unit itself at 1, 2, 4 and 8 bytes, else its power-of-two pieces, widest
/// first, none of which reaches past the unit (C99 6.7.2.1p11).
fn unit_pieces(size: u8) -> impl Iterator<Item = (i64, u32)> {
    let mut at = 0i64;
    [8u32, 4, 2, 1]
        .into_iter()
        .filter(move |&w| u32::from(size) & w != 0)
        .map(move |w| {
            let off = at;
            at += i64::from(w);
            (off, w)
        })
}

/// The address and alignment bound of the piece at `off` of a unit at
/// `addr` bounded by `align`; a split unit whose own bound is 0 is aligned
/// to its width rounded up, which aligns every piece.
fn unit_piece(b: &mut SsaBuilder, addr: ValueId, align: u8, off: i64, width: u32) -> (ValueId, u8) {
    let at = if off == 0 {
        addr
    } else {
        b.binop_imm(BinOp::Add, addr, off)
    };
    let bound = if align == 0 {
        0
    } else {
        access_align(offset_align(u32::from(align), off), width)
    };
    (at, bound)
}

/// The bitfield's storage unit of at most 8 bytes at `addr`, zero-extended.
/// The unsigned load kinds keep the unit's bits at their storage positions,
/// so the extraction's shift and mask see no sign extension from above.
fn load_unit(
    b: &mut SsaBuilder,
    addr: ValueId,
    bf: BitfieldDesc,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) -> ValueId {
    load_bytes(b, addr, 0, bf.unit_size, seg, vol, align)
}

/// Store the low `bf.unit_size` bytes of `unit` at `addr`, in the pieces
/// [`load_unit`] reads.
fn store_unit(
    b: &mut SsaBuilder,
    addr: ValueId,
    unit: ValueId,
    bf: BitfieldDesc,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) {
    store_bytes(b, addr, 0, unit, bf.unit_size, seg, vol, align);
}

/// The `size` bytes (1 to 8) at `addr + at`, zero-extended, read in their
/// [`unit_pieces`]; `align` bounds the access at `addr`.
fn load_bytes(
    b: &mut SsaBuilder,
    addr: ValueId,
    at: i64,
    size: u8,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) -> ValueId {
    let mut bytes = None;
    for (off, width) in unit_pieces(size) {
        let (place, bound) = unit_piece(b, addr, align, at + off, width);
        let mut piece = load_place(b, place, load_kind_for_width(width), seg, vol, bound);
        if off > 0 {
            piece = b.binop_imm(BinOp::Shl, piece, 8 * off);
        }
        bytes = Some(match bytes {
            Some(low) => b.binop(BinOp::Or, low, piece),
            None => piece,
        });
    }
    bytes.expect("a storage unit has a piece")
}

/// Store the low `size` bytes of `value` at `addr + at`, in the pieces
/// [`load_bytes`] reads.
#[allow(clippy::too_many_arguments)]
fn store_bytes(
    b: &mut SsaBuilder,
    addr: ValueId,
    at: i64,
    value: ValueId,
    size: u8,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) {
    for (off, width) in unit_pieces(size) {
        let (place, bound) = unit_piece(b, addr, align, at + off, width);
        let piece = if off > 0 {
            b.binop_imm(BinOp::Shru, value, 8 * off)
        } else {
            value
        };
        store_place(
            b,
            place,
            piece,
            store_kind_for_width(width),
            seg,
            vol,
            bound,
        );
    }
}

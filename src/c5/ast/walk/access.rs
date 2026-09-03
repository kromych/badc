//! Object access: the load / store kind an access takes, its alignment,
//! its address space, and the aggregate copies.

use super::atomic::RmwPlace;
use super::types::expr_ty;
use super::*;

impl<'a> Walker<'a> {
    /// Alignment the address of the member at `field_off` in the
    /// aggregate `obj` names is proven to satisfy, as [`Inst::Load`]
    /// records it: zero when it already covers `width`. C99 6.3.2.3p7
    /// lets the aggregate's own alignment stand for the base address,
    /// and an unresolved layout keeps the natural assumption.
    pub(super) fn member_align(&self, obj: ExprId, field_off: i64, width: u32) -> u8 {
        let Some(base) = expr_ty(self.ast.expr(obj)).and_then(|t| self.struct_align_opt(t)) else {
            return 0;
        };
        access_align(offset_align(base, field_off), width)
    }

    /// [`Self::member_align`] for an lvalue expression: only a member
    /// access lowers the bound.
    pub(super) fn lvalue_align(&self, id: ExprId, width: u32) -> u8 {
        match self.ast.expr(id) {
            Expr::Member { obj, field_off, .. } => self.member_align(*obj, *field_off, width),
            _ => 0,
        }
    }

    /// True when the expression's type tag carries the volatile
    /// qualifier (C99 6.7.3); `false` for node shapes without a type.
    /// A member access inherits the qualifiers of the object it is
    /// reached through (C99 6.5.2.3p3-4), and qualifying an array type
    /// qualifies its elements (C99 6.7.3p8), so descend through the
    /// member / subscript chain to the base whose tag carries the
    /// qualifier.
    pub(super) fn expr_is_volatile(&self, id: ExprId) -> bool {
        let e = self.ast.expr(id);
        if expr_ty(e).is_some_and(is_volatile_ty) {
            return true;
        }
        match e {
            Expr::Member { obj: base, .. } | Expr::Index { array: base, .. } => {
                self.expr_is_volatile(*base)
            }
            _ => false,
        }
    }

    /// Segment override for an access to an lvalue of type `ty`.
    /// `AsmSeg::None` for the generic space. Only the x86 encoder emits
    /// segment prefixes; elsewhere a qualified access is an error rather
    /// than a silently generic one.
    pub(super) fn access_seg(&self, id: ExprId, ty: i64) -> Result<AsmSeg, WalkError> {
        match segment_of_object_ty(ty) {
            None => Ok(AsmSeg::None),
            Some(_) if !self.target.is_x86_64() => Err(WalkError::UnsupportedExpr {
                id,
                kind: "__seg_gs/__seg_fs access (x86 only)",
            }),
            Some(seg) => Ok(asm_seg_of(seg)),
        }
    }

    /// The type of `id` when it is an aggregate rvalue whose bytes sit
    /// in a named address space. The address-as-value production is
    /// segment-neutral; the copy consumers (assignment, initialization,
    /// argument and return passing, 128-bit half loads) read the bytes
    /// and are not.
    pub(super) fn seg_aggregate_ty(&self, id: ExprId) -> Option<i64> {
        expr_ty(self.ast.expr(id))
            .filter(|t| is_struct_value_ty(*t) && segment_of_object_ty(*t).is_some())
    }

    /// Copy `size` bytes from `src` to `dst` in the widest chunks the
    /// endpoint alignment allows, each endpoint riding its own segment
    /// override. `Inst::Mcpy` carries no segment, so a copy with a
    /// qualified endpoint takes this cover instead; both may be
    /// qualified, and independently.
    /// TODO: the cover is one chunk per unit at any size; gcc switches
    /// to an indexed loop for a large aggregate.
    #[allow(clippy::too_many_arguments)]
    pub(super) fn seg_copy_bytes(
        &self,
        b: &mut SsaBuilder,
        dst: ValueId,
        dst_seg: AsmSeg,
        src: ValueId,
        src_seg: AsmSeg,
        size: i64,
        align: u32,
        vol: bool,
    ) {
        for (off, width) in mem_transfer_chunks(size, align) {
            let at = |b: &mut SsaBuilder, base: ValueId| {
                if off == 0 {
                    base
                } else {
                    b.binop_imm(BinOp::Add, base, off)
                }
            };
            let chunk_align = offset_align(align, off).min(u32::from(u8::MAX)) as u8;
            let sp = at(b, src);
            let v = load_place(b, sp, load_kind_for_width(width), src_seg, vol, chunk_align);
            let dp = at(b, dst);
            store_place(
                b,
                dp,
                v,
                store_kind_for_width(width),
                dst_seg,
                vol,
                chunk_align,
            );
        }
    }

    /// Walk `id` as an rvalue a copy consumer will read the bytes of.
    /// An aggregate in a named address space is copied into a frame slot
    /// through that segment first and the slot's address stands in;
    /// every other expression walks unchanged.
    pub(super) fn walk_copy_operand(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
    ) -> Result<ValueId, WalkError> {
        let v = self.walk_expr_rvalue(b, id)?;
        self.flatten_copy_operand(b, id, v)
    }

    /// [`Self::walk_copy_operand`] for a site that has already walked
    /// the operand and holds its address.
    pub(super) fn flatten_copy_operand(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
        v: ValueId,
    ) -> Result<ValueId, WalkError> {
        let Some(ty) = self.seg_aggregate_ty(id) else {
            return Ok(v);
        };
        let seg = self.access_seg(id, ty)?;
        let size = self.struct_size(ty);
        let align = self.struct_align(ty);
        let slot = b.alloc_synthetic_struct(size);
        let dst = b.local_addr(slot);
        let vol = is_volatile_ty(ty) || self.expr_is_volatile(id);
        self.seg_copy_bytes(b, dst, AsmSeg::None, v, seg, size, align, vol);
        Ok(dst)
    }

    /// Volatility of a read-modify-write access. A slot is the object's
    /// own storage, so its top-level qualifier governs (C99 6.7.5.1p1);
    /// a place reached through an address keeps the whole-tag reading,
    /// which over-approximates the level the qualifier sits at.
    pub(super) fn rmw_is_volatile(&self, place: &RmwPlace, ty: i64, lvalue: ExprId) -> bool {
        match place {
            RmwPlace::Slot(_) => is_volatile_object_ty(ty),
            _ => is_volatile_ty(ty) || self.expr_is_volatile(lvalue),
        }
    }
}

/// Alignment `at` as [`Inst::Load`] records it for a `width`-byte
/// access: zero once it already covers the width.
pub(super) fn access_align(at: u32, width: u32) -> u8 {
    if at >= width { 0 } else { at as u8 }
}

/// Byte width of a scalar load kind.
pub(super) fn load_kind_width(kind: LoadKind) -> u32 {
    match kind {
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I64 | LoadKind::F64 => 8,
        LoadKind::F80 | LoadKind::F128 => 16,
    }
}

/// Byte width of a scalar store kind.
pub(super) fn store_kind_width(kind: StoreKind) -> u32 {
    match kind {
        StoreKind::I8 => 1,
        StoreKind::I16 => 2,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::I64 | StoreKind::F64 => 8,
        StoreKind::F80 | StoreKind::F128 => 16,
    }
}

/// Integer load kind for a `width`-byte access. Unsigned below eight
/// bytes: a bit transfer must not sign-extend from the unit's top bit.
pub(super) fn load_kind_for_width(width: u32) -> LoadKind {
    match width {
        1 => LoadKind::U8,
        2 => LoadKind::U16,
        4 => LoadKind::U32,
        _ => LoadKind::I64,
    }
}

/// Integer store kind for a `width`-byte access.
pub(super) fn store_kind_for_width(width: u32) -> StoreKind {
    match width {
        1 => StoreKind::I8,
        2 => StoreKind::I16,
        4 => StoreKind::I32,
        _ => StoreKind::I64,
    }
}

/// Map a c5 type tag to the matching `LoadKind`. Mirrors
/// `compiler::types::load_op_for`.
pub(super) fn load_kind_for(ty: i64, target: Target) -> LoadKind {
    // A wide-format `long double` object narrows to the f64 the
    // compute path carries as it loads.
    if is_long_double_scalar(ty) {
        match target.long_double() {
            LongDoubleKind::X87 => return LoadKind::F80,
            LongDoubleKind::Binary128 => return LoadKind::F128,
            LongDoubleKind::F64 => {}
        }
    }
    // The SSA backend loads a `double` into an FP register.
    load_kind(ty, target, LoadKind::F64)
}

/// Map the type-system segment qualifier onto the IR's segment tag.
fn asm_seg_of(seg: Segment) -> AsmSeg {
    match seg {
        Segment::Gs => AsmSeg::Gs,
        Segment::Fs => AsmSeg::Fs,
    }
}

/// Scalar load from `addr`, riding `seg`'s override when the lvalue's
/// type named an address space. Every scalar lvalue read routes here.
pub(super) fn load_place(
    b: &mut SsaBuilder,
    addr: ValueId,
    kind: LoadKind,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) -> ValueId {
    match seg {
        AsmSeg::None => b.load_at(addr, kind, vol, align),
        // A named address space names per-CPU / per-thread storage the
        // ABI keeps naturally aligned, and only x86 targets have one.
        seg => b.seg_load(addr, kind, seg, vol),
    }
}

/// Store companion to [`load_place`].
pub(super) fn store_place(
    b: &mut SsaBuilder,
    addr: ValueId,
    value: ValueId,
    kind: StoreKind,
    seg: AsmSeg,
    vol: bool,
    align: u8,
) {
    match seg {
        AsmSeg::None => {
            b.store_at(addr, value, kind, vol, align);
        }
        seg => {
            b.seg_store(addr, value, kind, seg, vol);
        }
    }
}

/// `byte` repeated across `width` bytes, as the immediate a store of
/// that width takes.
pub(super) fn repeat_byte(byte: u8, width: u32) -> i64 {
    let mut v: u64 = 0;
    for _ in 0..width {
        v = (v << 8) | u64::from(byte);
    }
    v as i64
}

/// Mirror of [`load_kind_for`] for stores.
pub(super) fn store_kind_for(ty: i64, target: Target) -> StoreKind {
    // A wide-format `long double` store widens the f64 exactly into
    // the storage format.
    if is_long_double_scalar(ty) {
        match target.long_double() {
            LongDoubleKind::X87 => return StoreKind::F80,
            LongDoubleKind::Binary128 => return StoreKind::F128,
            LongDoubleKind::F64 => {}
        }
    }
    // A store width carries no signedness, so the bare band type is enough;
    // `strip_unsigned` also clears the segment bits so a `__seg_gs` /
    // `__seg_fs`-qualified type classifies by its underlying width.
    let stripped = strip_unsigned(ty);
    if is_pointer_ty(ty) {
        return StoreKind::I64;
    }
    if stripped == Ty::Bool as i64 || stripped == Ty::Char as i64 {
        StoreKind::I8
    } else if stripped == Ty::Short as i64 {
        StoreKind::I16
    } else if stripped == Ty::Int as i64 {
        StoreKind::I32
    } else if stripped == Ty::Float as i64 {
        StoreKind::F32
    } else if stripped == Ty::Double as i64 {
        StoreKind::F64
    } else if stripped == Ty::Long as i64 && target.is_windows() {
        StoreKind::I32
    } else {
        StoreKind::I64
    }
}

//! C11 7.17 atomic operations and the read-modify-write place a
//! `++` / `--` / `op=` lvalue resolves to.

use super::access::{load_kind_for, load_place, store_kind_for, store_kind_width, store_place};
use super::bitfield::{bitfield_load_kind, bitfield_mask_halves, merge_into_bitfield};
use super::types::{is_float_ty, is_floating_scalar, type_size_bytes};
use super::*;

impl<'a> Walker<'a> {
    /// Lower a C11 7.17 atomic operation. A naturally-aligned scalar
    /// load and store is already atomic on the supported targets, so
    /// `atomic_load` / `atomic_store` lower to a plain load / store.
    /// The read-modify-write and compare-exchange forms lower to the
    /// dedicated `Inst::AtomicRmw` / `Inst::AtomicCas`, which the
    /// per-arch emit turns into a genuine atomic sequence (C11
    /// 7.17.7); `width` is the access size of the atomic object's
    /// element type in bytes.
    pub(super) fn walk_atomic(
        &mut self,
        b: &mut SsaBuilder,
        kind: AtomicKind,
        args: &[ExprId],
        elem_ty: i64,
    ) -> Result<ValueId, WalkError> {
        let load_kind = load_kind_for(elem_ty, self.target);
        let store_kind = store_kind_for(elem_ty, self.target);
        let width = type_size_bytes(elem_ty, self.target) as u8;
        // Every atomic form here acts on a 1/2/4/8-byte scalar object,
        // the widths `__GCC_HAVE_SYNC_COMPARE_AND_SWAP_*` and
        // `__atomic_is_lock_free` report. A 16-byte object needs the
        // paired compare-exchange (x86-64 `cmpxchg16b`, aarch64
        // `casp` / `ldxp`-`stxp`), which the emit does not have; two
        // 8-byte accesses would tear, so this is rejected rather than
        // lowered. A wider or aggregate object has no atomic form at all.
        // TODO: 16-byte objects via the paired compare-exchange.
        if !matches!(width, 1 | 2 | 4 | 8) {
            return Err(WalkError::UnsupportedExpr {
                id: args[0],
                kind: if self.is_int128_value_ty(elem_ty) {
                    "16-byte atomic object needs a paired compare-exchange, \
                     which this target's emit does not provide"
                } else {
                    "atomic operation requires a 1/2/4/8-byte scalar object"
                },
            });
        }
        // The atomic instructions carry no segment operand; an atomic
        // object in a named address space is rejected rather than
        // accessed through the generic space.
        if segment_of_object_ty(elem_ty).is_some() {
            return Err(WalkError::UnsupportedExpr {
                id: args[0],
                kind: "atomic access in a named address space",
            });
        }
        let addr = self.walk_expr_rvalue(b, args[0])?;
        match kind {
            AtomicKind::Load => Ok(b.load(addr, load_kind)),
            AtomicKind::Store => {
                let value = self.walk_expr_rvalue(b, args[1])?;
                b.store(addr, value, store_kind);
                // Used in statement position; the value is discarded.
                Ok(b.imm(0))
            }
            // Generic `__atomic_load(p, ret, mo)`: load `*p`, write it
            // through `ret`. `__atomic_store(p, val, mo)`: load `*val`,
            // write it to `*p`. Both move the value through a pointer.
            AtomicKind::LoadInto => {
                let value = b.load(addr, load_kind);
                let ret = self.walk_expr_rvalue(b, args[1])?;
                b.store(ret, value, store_kind);
                Ok(b.imm(0))
            }
            AtomicKind::StoreFrom => {
                let val_addr = self.walk_expr_rvalue(b, args[1])?;
                let value = b.load(val_addr, load_kind);
                b.store(addr, value, store_kind);
                Ok(b.imm(0))
            }
            AtomicKind::Exchange
            | AtomicKind::FetchAdd
            | AtomicKind::FetchSub
            | AtomicKind::FetchAnd
            | AtomicKind::FetchOr
            | AtomicKind::FetchXor => {
                let value = self.walk_expr_rvalue(b, args[1])?;
                let op = match kind {
                    AtomicKind::Exchange => AtomicRmwOp::Xchg,
                    AtomicKind::FetchAdd => AtomicRmwOp::Add,
                    AtomicKind::FetchSub => AtomicRmwOp::Sub,
                    AtomicKind::FetchAnd => AtomicRmwOp::And,
                    AtomicKind::FetchOr => AtomicRmwOp::Or,
                    AtomicKind::FetchXor => AtomicRmwOp::Xor,
                    _ => unreachable!(),
                };
                // C11 7.17.7p2: the prior value of the object. The atomic
                // instruction sets only the low `width` bytes; normalize
                // to the element type's representation (C99 6.3.1.3), the
                // same sign / zero extension a load of `elem_ty` performs.
                let old = b.atomic_rmw(op, addr, value, width);
                Ok(self.extend_atomic_result(b, old, elem_ty))
            }
            AtomicKind::CompareExchangeStrong => {
                // C11 7.17.7.4: yield 1 on a match (after storing
                // `desired`), else store the current contents into
                // `*expected` and yield 0.
                let exp_addr = self.walk_expr_rvalue(b, args[1])?;
                let desired = self.walk_expr_rvalue(b, args[2])?;
                Ok(b.atomic_cas(addr, exp_addr, desired, width))
            }
            AtomicKind::AddFetch
            | AtomicKind::SubFetch
            | AtomicKind::AndFetch
            | AtomicKind::OrFetch
            | AtomicKind::XorFetch => {
                // GCC `__sync_*_and_fetch`: the read-modify-write yields the
                // prior value; recompute the post-operation value in plain
                // IR so a value with side effects is evaluated once.
                let value = self.walk_expr_rvalue(b, args[1])?;
                let (rmw, bin) = match kind {
                    AtomicKind::AddFetch => (AtomicRmwOp::Add, BinOp::Add),
                    AtomicKind::SubFetch => (AtomicRmwOp::Sub, BinOp::Sub),
                    AtomicKind::AndFetch => (AtomicRmwOp::And, BinOp::And),
                    AtomicKind::OrFetch => (AtomicRmwOp::Or, BinOp::Or),
                    AtomicKind::XorFetch => (AtomicRmwOp::Xor, BinOp::Xor),
                    _ => unreachable!(),
                };
                let old = b.atomic_rmw(rmw, addr, value, width);
                let old = self.extend_atomic_result(b, old, elem_ty);
                let new = b.binop(bin, old, value);
                Ok(self.extend_atomic_result(b, new, elem_ty))
            }
            AtomicKind::SyncCasVal | AtomicKind::SyncCasBool => {
                // GCC `__sync_val/bool_compare_and_swap(p, old, new)`. The
                // existing CAS expects the comparand by address and writes
                // the current `*p` back through it on failure, so after the
                // CAS the scratch slot holds the prior `*p` in both cases.
                let old_val = self.walk_expr_rvalue(b, args[1])?;
                let new_val = self.walk_expr_rvalue(b, args[2])?;
                let slot = b.alloc_synthetic_local();
                let exp_addr = b.local_addr(slot);
                b.store(exp_addr, old_val, store_kind);
                let swapped = b.atomic_cas(addr, exp_addr, new_val, width);
                if matches!(kind, AtomicKind::SyncCasBool) {
                    Ok(swapped)
                } else {
                    Ok(b.load(exp_addr, load_kind))
                }
            }
        }
    }

    /// Narrow an integer value of type `src_ty` to `to_ty`'s storage
    /// width per C99 6.3.1.3. An unsigned target masks to width; a
    /// signed narrowing (or a same-width signed view of an unsigned
    /// source) sign-extends the truncated value via the shift pair.
    /// A wider-or-equal signed conversion, a non-integer target, or a
    /// target of 8 bytes or more needs no op. Shared by the cast path
    /// and by assignment / compound-assignment / increment expressions,
    /// whose value has the converted type of the left operand
    /// (6.5.16p3 / 6.5.16.2 / 6.5.2.4 / 6.5.3.1) and so must carry the
    /// narrowed value when a wider enclosing expression reads it.
    pub(super) fn narrow_int_to_ty(
        &self,
        b: &mut SsaBuilder,
        v: ValueId,
        src_ty: i64,
        to_ty: i64,
    ) -> ValueId {
        if is_floating_scalar(to_ty) || is_struct_ty(to_ty) {
            return v;
        }
        let target_size = type_size_bytes(to_ty, self.target);
        let source_size = type_size_bytes(src_ty, self.target);
        if target_size == 0 || target_size >= 8 {
            return v;
        }
        let source_unsigned = (src_ty & UNSIGNED_BIT) != 0;
        let target_unsigned = (to_ty & UNSIGNED_BIT) != 0;
        if target_unsigned {
            let mask: i64 = match target_size {
                1 => 0xff,
                2 => 0xffff,
                4 => 0xffff_ffff,
                _ => return v,
            };
            b.binop_imm(BinOp::And, v, mask)
        } else {
            let needs_extend =
                target_size < source_size || (target_size == source_size && source_unsigned);
            if needs_extend {
                let bits = 64i64 - (target_size as i64) * 8;
                let shifted = b.binop_imm(BinOp::Shl, v, bits);
                b.binop_imm(BinOp::Shr, shifted, bits)
            } else {
                v
            }
        }
    }

    /// Normalize a sub-`int` atomic read-modify-write result to its
    /// element type's representation (C99 6.3.1.3): zero-extend an
    /// unsigned narrow type, sign-extend a signed one. A 4- or 8-byte
    /// type and a pointer ride the register at full width unchanged.
    pub(super) fn extend_atomic_result(
        &self,
        b: &mut SsaBuilder,
        v: ValueId,
        elem_ty: i64,
    ) -> ValueId {
        if is_pointer_ty(elem_ty) {
            return v;
        }
        let rs = type_size_bytes(elem_ty, self.target);
        if rs >= 8 {
            return v;
        }
        // The atomic instruction defines only the low `rs` bytes of the
        // prior value; canonicalize the rest per C99 6.3.1.3. `int` and
        // `long` are 4 bytes on LLP64, so every sub-8-byte width needs this.
        if (elem_ty & UNSIGNED_BIT) != 0 {
            let mask: i64 = (1i64 << (rs as i64 * 8)) - 1;
            b.binop_imm(BinOp::And, v, mask)
        } else {
            let bits = 64i64 - (rs as i64) * 8;
            let shifted = b.binop_imm(BinOp::Shl, v, bits);
            b.binop_imm(BinOp::Shr, shifted, bits)
        }
    }

    /// Add `by` (+1 / -1) to a loaded scalar for `++` / `--`. Integer
    /// lvalues take the immediate-form add; a real floating lvalue (C99
    /// 6.5.3.1 / 6.5.2.4) adds `1.0` of its own precision through the FP
    /// path, since `BinOp::Add` would operate on the bit pattern.
    pub(super) fn increment_value(
        &mut self,
        b: &mut SsaBuilder,
        old: ValueId,
        by: i64,
        ty: i64,
    ) -> ValueId {
        if !is_floating_scalar(ty) {
            return b.binop_imm(BinOp::Add, old, by);
        }
        // Run in double and narrow back for a `float`, matching the
        // compound-assign path (C99 6.3.1.5). A direct single-precision
        // `fadd` is correct on the native targets but the SSA interpreter
        // does not lower it, so route both precisions through the f64 add.
        let one = b.imm((by as f64).to_bits() as i64);
        if is_float_ty(ty) {
            let wide = b.fp_widen_to_f64(old);
            let res = b.binop(BinOp::Fadd, wide, one);
            b.fp_narrow_to_f32(res)
        } else {
            b.binop(BinOp::Fadd, old, one)
        }
    }

    /// Resolve a read-modify-write target and read its current value.
    /// The lvalue is evaluated once (C99 6.5.2.4p2 / 6.5.16.2p3).
    pub(super) fn rmw_open(
        &mut self,
        b: &mut SsaBuilder,
        lvalue: ExprId,
        ty: i64,
    ) -> Result<RmwOpen, WalkError> {
        let load_kind = load_kind_for(ty, self.target);
        let store_kind = store_kind_for(ty, self.target);
        let place = self.rmw_place(b, lvalue, ty)?;
        let vol = self.rmw_is_volatile(&place, ty, lvalue);
        let old = place.load(b, load_kind, vol);
        Ok(RmwOpen {
            place,
            load_kind,
            store_kind,
            vol,
            old,
        })
    }

    /// Resolve where a read-modify-write operator targets its lvalue. A
    /// non-thread-local `Token::Loc` Ident keeps its frame slot so
    /// mem2reg can promote it; every non-local lvalue materializes an
    /// address through `walk_expr_lvalue`. Mirrors the `Expr::Assign`
    /// local-target shortcut so `i++` / `i += k` keep the counter
    /// register-resident, not just `i = i + k`.
    pub(super) fn rmw_place(
        &mut self,
        b: &mut SsaBuilder,
        lvalue: ExprId,
        ty: i64,
    ) -> Result<RmwPlace, WalkError> {
        // A bitfield member: compute the storage unit's address once so
        // the read and the write target the same unit (the object is
        // evaluated a single time per C99 6.5.2.4 / 6.5.16.2).
        if let Expr::Member {
            obj,
            field_off,
            bitfield: Some(bf),
            ty: member_ty,
            ..
        } = self.ast.expr(lvalue)
        {
            let bf = *bf;
            let seg = self.bitfield_access_seg(lvalue, *member_ty, bf)?;
            let obj = *obj;
            let field_off = *field_off;
            let base = self.walk_expr_rvalue(b, obj)?;
            let addr = if field_off != 0 {
                b.binop_imm(BinOp::Add, base, field_off)
            } else {
                base
            };
            let align = self.member_align(obj, field_off, bf.unit_size as u32);
            return Ok(RmwPlace::Bitfield {
                addr,
                bf,
                seg,
                align,
            });
        }
        let seg = self.access_seg(lvalue, ty)?;
        if let Expr::Ident {
            class,
            val,
            is_thread_local: false,
            ..
        } = self.ast.expr(lvalue)
            && *class == Token::Loc as i64
        {
            // A frame slot has no named address space; the parser
            // rejects such declarations.
            if seg != AsmSeg::None {
                return Err(WalkError::InvalidExpr {
                    id: lvalue,
                    kind: "named address space on automatic storage",
                });
            }
            return Ok(RmwPlace::Slot(*val));
        }
        let addr = self.walk_expr_lvalue(b, lvalue)?;
        let align = self.lvalue_align(lvalue, store_kind_width(store_kind_for(ty, self.target)));
        Ok(RmwPlace::Addr { addr, seg, align })
    }
}

/// A read-modify-write target with its access kinds and the value read
/// from it.
pub(super) struct RmwOpen {
    pub(super) place: RmwPlace,
    pub(super) load_kind: LoadKind,
    pub(super) store_kind: StoreKind,
    pub(super) vol: bool,
    pub(super) old: ValueId,
}

/// Where a read-modify-write operator (`++` / `--` / `op=`) reads and
/// writes its lvalue. A plain non-thread-local local of integer-class
/// storage width uses its frame slot directly (`LoadLocal` /
/// `StoreLocal`); every other lvalue -- a dereference, an array element,
/// a struct field, or a float-stored local -- routes through a
/// materialized address. The slot path takes no `LocalAddr`, so the slot
/// stays promotable; the address path pins it to memory from the point
/// the address is taken.
pub(super) enum RmwPlace {
    Slot(i64),
    /// A materialized address, with the segment override every access
    /// to the lvalue rides (`AsmSeg::None` for the generic space).
    Addr {
        addr: ValueId,
        seg: AsmSeg,
        align: u8,
    },
    /// A bitfield read-modify-write target: the storage unit's address
    /// and the field descriptor. `load` extracts the field value;
    /// `store` merges the new value back into the unit, preserving the
    /// other bits. The passed `LoadKind` / `StoreKind` are ignored; the
    /// unit width comes from the descriptor.
    Bitfield {
        addr: ValueId,
        bf: BitfieldDesc,
        seg: AsmSeg,
        align: u8,
    },
}

impl RmwPlace {
    pub(super) fn load(&self, b: &mut SsaBuilder, kind: LoadKind, vol: bool) -> ValueId {
        match *self {
            RmwPlace::Slot(off) => b.load_local_vol(off, kind, vol),
            RmwPlace::Addr { addr, seg, align } => load_place(b, addr, kind, seg, vol, align),
            RmwPlace::Bitfield {
                addr,
                bf,
                seg,
                align,
            } => {
                // C99 6.7.2.1: load the unit, shift the slice to bit 0,
                // mask, and sign-extend when the field type is signed.
                // A 128-bit field never reaches here: its operators route
                // through the walker's 128-bit read-modify-write.
                debug_assert!(bf.unit_size <= 8);
                let mut v = load_place(b, addr, bitfield_load_kind(bf), seg, vol, align);
                if bf.bit_offset > 0 {
                    v = b.binop_imm(BinOp::Shr, v, bf.bit_offset as i64);
                }
                v = b.binop_imm(BinOp::And, v, bitfield_mask_halves(bf.bit_width, 0).0);
                if bf.signed && bf.bit_width < 64 {
                    let shift = 64i64 - (bf.bit_width as i64);
                    v = b.binop_imm(BinOp::Shl, v, shift);
                    v = b.binop_imm(BinOp::Shr, v, shift);
                }
                v
            }
        }
    }

    pub(super) fn store(&self, b: &mut SsaBuilder, value: ValueId, kind: StoreKind, vol: bool) {
        match *self {
            RmwPlace::Slot(off) => {
                b.store_local_vol(off, value, kind, vol);
            }
            RmwPlace::Addr { addr, seg, align } => {
                store_place(b, addr, value, kind, seg, vol, align);
            }
            RmwPlace::Bitfield {
                addr,
                bf,
                seg,
                align,
            } => {
                debug_assert!(bf.unit_size <= 8);
                merge_into_bitfield(b, addr, bf, value, seg, vol, align);
            }
        }
    }
}

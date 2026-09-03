//! Block-scope declarations (C99 6.7) and the initializers they carry.

use super::access::{access_align, repeat_byte, store_kind_for, store_kind_for_width};
use super::types::{expr_ty, is_floating_scalar};
use super::*;

impl<'a> Walker<'a> {
    /// Walk a local declaration. Lowers based on the
    /// initializer's shape:
    /// * `LocalInit::None` -- no instruction (C99 6.7.8p10).
    /// * `LocalInit::Scalar(expr)` -- evaluate, `store_local`.
    /// * `LocalInit::Aggregate { src_data_off, size_bytes }` --
    ///   emit `Inst::Mcpy { dst = local_addr, src = imm_data,
    ///   size }` for a brace-list whose every element folded to
    ///   a compile-time constant.
    pub(super) fn walk_decl(&mut self, b: &mut SsaBuilder, id: DeclId) -> Result<(), WalkError> {
        match self.ast.decl(id) {
            Decl::Local {
                sym: _,
                ty,
                slot_off,
                init,
            } => {
                let slot = *slot_off;
                let ty = *ty;
                let init_clone = init.clone();
                self.emit_local_init(b, slot, ty, &init_clone)
            }
            Decl::Vla {
                elem_size,
                ptr_slot,
                size_slot,
                dim,
                fill,
                ..
            } => {
                // C99 6.7.6.2: allocate `count * sizeof(elem)` bytes
                // from the stack via the alloca intrinsic, store the
                // base pointer for decay and the byte count for `sizeof`.
                let elem_size = *elem_size;
                let ptr_slot = *ptr_slot;
                let size_slot = *size_slot;
                let dim = *dim;
                let fill = *fill;
                let n = self.walk_expr_rvalue(b, dim)?;
                let bytes = if elem_size == 1 {
                    n
                } else {
                    b.binop_imm(BinOp::Mul, n, elem_size)
                };
                b.store_local(size_slot, bytes, StoreKind::I64);
                let ptr = b.intrinsic(Intrinsic::Alloca as i64, alloc::vec![bytes]);
                b.store_local(ptr_slot, ptr, StoreKind::I64);
                if let Some(byte) = fill {
                    self.fill_loop(b, ptr, bytes, byte);
                }
                Ok(())
            }
            Decl::StaticLocal { .. } => {
                // C99 6.2.4p3 + 6.7.8p4: storage + initializer
                // live in the data segment; nothing to emit in
                // the function body. The matching symbol-table
                // entry survives through `self.symbols`, so any
                // ident reference still resolves through the Glo
                // path in `load_ident_rvalue` /
                // `ident_address`.
                Ok(())
            }
        }
    }

    /// Emit the initialization of a frame slot from a [`LocalInit`].
    /// Shared by local-variable declarations (`Decl::Local`) and
    /// block-scope compound literals (`Expr::CompoundLiteral`), both
    /// of which lower the same C99 6.7.8 / 6.5.2.5 initializer
    /// shapes into the same slot.
    /// Store a scalar `v` of type `src_ty` into the 16-byte `__int128`
    /// object at `dst_addr`: the source, converted to 64 bits, fills the
    /// low half and its sign fills the high half (C99 6.3.1.3/6.3.1.8
    /// widening). Shared by the cast, initializer, and assignment paths,
    /// which otherwise treat the scalar as a struct-rvalue address and
    /// copy 16 bytes from it. A floating source converts through
    /// [`Self::fp_to_int128`], which fills both halves.
    pub(super) fn store_scalar_as_int128(
        &mut self,
        b: &mut SsaBuilder,
        dst_addr: ValueId,
        v: ValueId,
        src_ty: i64,
        dst_ty: i64,
    ) {
        if is_floating_scalar(src_ty) {
            let pair = self.fp_to_int128(b, v, (dst_ty & UNSIGNED_BIT) == 0);
            self.int128_store(b, dst_addr, pair);
            return;
        }
        let low_ty = Ty::LongLong as i64 | (src_ty & UNSIGNED_BIT);
        let low = self.convert_scalar_value(b, v, src_ty, low_ty);
        let store_kind = store_kind_for(low_ty, self.target);
        b.store(dst_addr, low, store_kind);
        let zero_extend = (src_ty & UNSIGNED_BIT) != 0 || is_pointer_ty(src_ty);
        let high = if zero_extend {
            b.imm(0)
        } else {
            b.binop_imm(BinOp::Shr, low, 63)
        };
        let hi_addr = b.binop_imm(BinOp::Add, dst_addr, 8);
        b.store(hi_addr, high, store_kind);
    }

    /// Copy the `size` bytes staged at `src_data_off` into the local at
    /// `slot`.
    fn init_from_template(&mut self, b: &mut SsaBuilder, slot: i64, src_data_off: i64, size: i64) {
        let dst = b.local_addr(slot);
        let src = b.imm_data(src_data_off);
        b.mcpy(dst, src, size, offset_align(SLOT_ALIGN, src_data_off));
    }

    /// Store `byte` over the first `size` bytes of the local at `slot`,
    /// in place of copying a staged template. A frame slot is
    /// `SLOT_ALIGN`-aligned, so the fill runs in whole units down to the
    /// tail; past the inline bound it runs as a loop.
    fn init_fill(&mut self, b: &mut SsaBuilder, slot: i64, size: i64, byte: u8) {
        if size <= 0 {
            return;
        }
        let dst = b.local_addr(slot);
        if mem_transfer_accesses(size, SLOT_ALIGN) > MAX_MEM_FILL_ACCESSES {
            let bytes = b.imm(size);
            self.fill_loop(b, dst, bytes, byte);
            return;
        }
        for (off, width) in mem_transfer_chunks(size, SLOT_ALIGN) {
            let p = if off == 0 {
                dst
            } else {
                b.binop_imm(BinOp::Add, dst, off)
            };
            let v = b.imm(repeat_byte(byte, width));
            b.store(p, v, store_kind_for_width(width));
        }
    }

    /// Store `byte` over `bytes` bytes at `dst` with a loop of 8-byte
    /// stores. The count is rounded up to a multiple of 8: a frame slot
    /// and an `alloca` allocation are both sized in units of at least
    /// that and start 8-aligned, so the rounded run stays inside the
    /// object's own storage. The cursor lives in a synthetic slot the
    /// `-O` promotion lifts into a register.
    fn fill_loop(&mut self, b: &mut SsaBuilder, dst: ValueId, bytes: ValueId, byte: u8) {
        let cursor = b.alloc_synthetic_local();
        let rounded = b.binop_imm(BinOp::Add, bytes, 7);
        let rounded = b.binop_imm(BinOp::And, rounded, -8);
        let end = b.binop(BinOp::Add, dst, rounded);
        b.store_local(cursor, dst, StoreKind::I64);
        let header = b.new_block();
        let body = b.new_block();
        let after = b.new_block();
        b.jmp(header);
        b.switch_to(header);
        let p = b.load_local(cursor, LoadKind::I64);
        let more = b.binop(BinOp::Ult, p, end);
        b.branch_zero(more, after, body);
        b.switch_to(body);
        let v = b.imm(repeat_byte(byte, 8));
        b.store(p, v, StoreKind::I64);
        let next = b.binop_imm(BinOp::Add, p, 8);
        b.store_local(cursor, next, StoreKind::I64);
        b.jmp(header);
        b.switch_to(after);
    }

    pub(super) fn emit_local_init(
        &mut self,
        b: &mut SsaBuilder,
        slot: i64,
        ty: i64,
        init: &LocalInit,
    ) -> Result<(), WalkError> {
        match init {
            LocalInit::None => Ok(()),
            LocalInit::Scalar(init_id) => {
                let v = self.walk_copy_operand(b, *init_id)?;
                // C99 6.7.8p13 struct-value initializer: copy the source's
                // bytes into the slot via Mcpy. `v` is the source address
                // (the walker's address-as-value routing for struct
                // rvalues). A scalar source of a 128-bit `__int128` slot is
                // widened into it instead -- `v` is then a value, not an
                // address, so an Mcpy from it would fault.
                if is_struct_value_ty(ty) {
                    let dst = b.local_addr(slot);
                    let src_ty = expr_ty(self.ast.expr(*init_id)).unwrap_or(ty);
                    if self.is_int128_value_ty(ty) && !is_struct_ty(src_ty) {
                        self.store_scalar_as_int128(b, dst, v, src_ty, ty);
                        return Ok(());
                    }
                    let size = self.struct_size(ty);
                    b.mcpy(dst, v, size, self.struct_align(ty));
                    return Ok(());
                }
                let kind = store_kind_for(ty, self.target);
                // A direct `StoreLocal` keeps the slot mem2reg-promotable.
                // The `F32` s-view store is narrowed by the per-arch emit
                // when the value is still double.
                b.store_local_vol(slot, v, kind, is_volatile_object_ty(ty));
                Ok(())
            }
            LocalInit::Aggregate {
                src_data_off,
                size_bytes,
            } => {
                self.init_from_template(b, slot, *src_data_off, *size_bytes);
                Ok(())
            }
            LocalInit::Fill { byte, size_bytes } => {
                self.init_fill(b, slot, *size_bytes, *byte);
                Ok(())
            }
            LocalInit::Runtime {
                zero_init,
                elements,
            } => {
                // C99 6.7.8p19 zero prelude (if the parser emitted one),
                // ahead of the per-element stores.
                match zero_init {
                    Some(LocalInitPrelude::Template {
                        src_data_off,
                        size_bytes,
                    }) => self.init_from_template(b, slot, *src_data_off, *size_bytes),
                    Some(LocalInitPrelude::Fill { byte, size_bytes }) => {
                        self.init_fill(b, slot, *size_bytes, *byte)
                    }
                    None => {}
                }
                for elem in elements {
                    let value = match elem.value {
                        // A range-designator copy element: transfer the bytes
                        // of the range's first, already-stored span. A bit
                        // copy, not a value conversion, so scalar widths use
                        // integer load/store kinds (an f32 sNaN round-trip
                        // through a float register would quieten it).
                        RuntimeInitValue::Copy { src_off, bytes } => {
                            debug_assert!(elem.bitfield.is_none());
                            let base = b.local_addr(slot);
                            let dst = if elem.offset == 0 {
                                base
                            } else {
                                b.binop_imm(BinOp::Add, base, elem.offset)
                            };
                            let src = if src_off == 0 {
                                base
                            } else {
                                b.binop_imm(BinOp::Add, base, src_off)
                            };
                            let scalar = !(is_struct_value_ty(elem.ty));
                            let kinds = match bytes {
                                1 => Some((LoadKind::U8, StoreKind::I8)),
                                2 => Some((LoadKind::U16, StoreKind::I16)),
                                4 => Some((LoadKind::U32, StoreKind::I32)),
                                8 => Some((LoadKind::I64, StoreKind::I64)),
                                _ => None,
                            };
                            match kinds {
                                Some((lk, sk)) if scalar => {
                                    let vol = is_volatile_ty(elem.ty);
                                    let v = b.load_vol(src, lk, vol);
                                    b.store_vol(dst, v, sk, vol);
                                }
                                // Both ends are offsets into the same
                                // 8-aligned frame slot.
                                _ => b.mcpy(
                                    dst,
                                    src,
                                    bytes,
                                    offset_align(SLOT_ALIGN, elem.offset)
                                        .min(offset_align(SLOT_ALIGN, src_off)),
                                ),
                            }
                            continue;
                        }
                        RuntimeInitValue::Expr(value) => value,
                    };
                    let v = match elem.bitfield {
                        Some(bf) => self.bitfield_store_value(b, bf, value)?,
                        None => self.walk_copy_operand(b, value)?,
                    };
                    let base = b.local_addr(slot);
                    let addr = if elem.offset == 0 {
                        base
                    } else {
                        b.binop_imm(BinOp::Add, base, elem.offset)
                    };
                    // A bitfield member: read-modify-write the storage unit
                    // rather than a full-width store, so adjacent bitfields
                    // in the same unit are preserved (the slot was
                    // zero-seeded, so the field's own bits start clear).
                    if let Some(bf) = elem.bitfield {
                        // Frame storage is always in the generic space.
                        self.store_into_bitfield(
                            b,
                            addr,
                            bf,
                            v,
                            AsmSeg::None,
                            is_volatile_ty(elem.ty),
                            access_align(
                                offset_align(SLOT_ALIGN, elem.offset),
                                bf.unit_size as u32,
                            ),
                        );
                        continue;
                    }
                    // C99 6.7.8p13: a struct/union member initialized by a
                    // single expression of compatible type copies the
                    // source's bytes. `v` is the source address (the
                    // walker's address-as-value routing for struct rvalues),
                    // so this needs an Mcpy, not a scalar store.
                    if is_struct_value_ty(elem.ty) {
                        let size = self.struct_size(elem.ty);
                        b.mcpy(addr, v, size, self.struct_align(elem.ty));
                        continue;
                    }
                    let kind = store_kind_for(elem.ty, self.target);
                    b.store_vol(addr, v, kind, is_volatile_ty(elem.ty));
                }
                Ok(())
            }
        }
    }
}

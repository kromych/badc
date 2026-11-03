//! Accesses to an `_Atomic` object, each seq_cst (C11 6.2.6.1p9, 6.5.2.4p2,
//! 6.5.16.2p3), through the access its layout ([`atomic_layout`]) gives.

use super::access::{load_kind_for, store_kind_for};
use super::atomic::{int_load_kind, int_store_kind};
use super::types::{is_bool_scalar, is_floating_scalar, type_size_bytes};
use super::*;
use crate::c5::ast::expr_ty;
use crate::c5::compiler::types::{
    ATOMIC_LIBCALLS, AtomicAccess, AtomicLayout, atomic_layout, is_atomic_object_ty, non_atomic_ty,
};

const SEQ_CST: MemOrder = MemOrder::SeqCst;

/// A compound assignment's right operand, evaluated ahead of the retries.
pub(super) enum RmwOperand {
    Scalar { value: ValueId, ty: i64 },
    Pair(Halves),
}

impl<'a> Walker<'a> {
    fn value_size_align(&self, ty: i64) -> (usize, usize) {
        if is_struct_value_ty(ty) {
            (
                self.struct_size(ty) as usize,
                self.struct_align(ty) as usize,
            )
        } else if is_long_double_scalar(ty) {
            let ld = self.target.long_double();
            (ld.size(), ld.align())
        } else {
            let n = type_size_bytes(ty, self.target);
            (n, n)
        }
    }

    pub(super) fn atomic_object_layout(&self, ty: i64) -> AtomicLayout {
        let (size, align) = self.value_size_align(non_atomic_ty(ty));
        atomic_layout(size, align, self.target, self.freestanding)
    }

    /// The type of `id` when it reads an `_Atomic` object; an array decays.
    pub(super) fn atomic_lvalue_ty(&self, id: ExprId) -> Option<i64> {
        let ty = match self.ast.expr(id) {
            Expr::Ident {
                ty,
                class,
                array_size: 0,
                ..
            } if *class == Token::Loc as i64 || *class == Token::Glo as i64 => *ty,
            Expr::Unary {
                op: UnOp::Deref,
                ty,
                ..
            }
            | Expr::Index { ty, .. } => *ty,
            Expr::Member {
                bitfield: None,
                array_size: 0,
                ty,
                ..
            } => *ty,
            _ => return None,
        };
        is_atomic_object_ty(ty).then_some(ty)
    }

    /// The atomic instructions carry no segment operand.
    pub(super) fn atomic_lvalue_addr(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        if segment_of_object_ty(ty).is_some() {
            return Err(WalkError::UnsupportedExpr {
                id,
                kind: "atomic access in a named address space",
            });
        }
        self.walk_expr_lvalue(b, id)
    }

    /// An automatic object's lock word starts clear, as a static one's does.
    pub(super) fn release_atomic_lock_word(&self, b: &mut SsaBuilder, slot: i64, ty: i64) {
        if self.lock_word_of(ty).is_some() {
            let at = b.local_addr(slot);
            self.clear_lock_word(b, at, ty);
        }
    }

    fn lock_word_of(&self, ty: i64) -> Option<usize> {
        if !is_atomic_object_ty(ty) {
            return None;
        }
        match self.atomic_object_layout(ty).access {
            AtomicAccess::LockWord(lock_off) => Some(lock_off),
            _ => None,
        }
    }

    fn clear_lock_word(&self, b: &mut SsaBuilder, at: ValueId, ty: i64) {
        if let Some(lock_off) = self.lock_word_of(ty) {
            let lock = b.binop_imm(BinOp::Add, at, lock_off as i64);
            let zero = b.imm(0);
            b.store(lock, zero, StoreKind::I32);
        }
    }

    /// C17 7.17.2.2 `atomic_init`: the object's non-atomic initialization,
    /// which stores the value and clears a lock word without taking it.
    pub(super) fn walk_atomic_init(
        &mut self,
        b: &mut SsaBuilder,
        args: &[ExprId],
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        let value_ty = non_atomic_ty(ty);
        let addr = self.walk_expr_rvalue(b, args[0])?;
        let mut value = self.walk_expr_rvalue(b, args[1])?;
        if is_struct_value_ty(value_ty) {
            let (size, align) = self.value_size_align(value_ty);
            b.mcpy(addr, value, size as i64, align as u32);
        } else {
            let kind = store_kind_for(value_ty, self.target);
            if matches!(kind, StoreKind::F32) {
                value = b.fp_narrow_to_f32(value);
            }
            b.store(addr, value, kind);
        }
        self.clear_lock_word(b, addr, ty);
        Ok(b.imm(0))
    }

    /// A parameter of an `_Atomic` type with a lock word: the caller passed
    /// the non-atomic value (C17 6.5.2.2p7), which leaves the lock unset.
    pub(super) fn release_param_lock_words(&self, b: &mut SsaBuilder) {
        let fun = self.fun;
        for (&ty, &slot) in fun.param_tys.iter().zip(&fun.param_local_slots) {
            if slot < 0 {
                self.release_atomic_lock_word(b, slot, ty);
            }
        }
    }

    fn atomic_temp(&self, b: &mut SsaBuilder, size: usize, align: usize) -> ValueId {
        let slot = b.alloc_synthetic_struct(size.max(1) as i64, align.max(1) as i64);
        b.local_addr(slot)
    }

    fn atomic_libcall(
        &self,
        b: &mut SsaBuilder,
        name: &str,
        args: alloc::vec::Vec<ValueId>,
    ) -> Result<ValueId, WalkError> {
        let slot_name = (ATOMIC_LIBCALLS.iter().find(|e| e.0 == name)).map(|e| e.1);
        let found = slot_name.and_then(|s| self.symbols.iter().position(|sym| sym.name == s));
        let Some(sym) = found else {
            return Err(WalkError::Unsupported(
                "a generic atomic function no declaration of the `_Atomic` type introduced",
            ));
        };
        let sym = sym as u32;
        let target_pc = live_fun_val(self.symbols, sym, 0);
        let n = args.len();
        let conv = crate::c5::codegen::CallConv::Target;
        let mask = crate::c5::ir::FpMask::EMPTY;
        Ok(if target_pc == 0 {
            b.call_extern(sym, args, n, false, mask, conv)
        } else {
            b.call(target_pc as usize, args, n, false, mask, conv)
        })
    }

    /// Exchange 1 in until the prior value is 0.
    fn lock_word_acquire(&self, b: &mut SsaBuilder, lock: ValueId) {
        let (spin, held) = (b.new_block(), b.new_block());
        b.jmp(spin);
        b.switch_to(spin);
        let one = b.imm(1);
        let prior = b.atomic_rmw(AtomicRmwOp::Xchg, lock, one, 4, MemOrder::Acquire);
        b.branch_zero(prior, held, spin);
        b.switch_to(held);
    }

    fn lock_word_release(&self, b: &mut SsaBuilder, lock: ValueId) {
        let zero = b.imm(0);
        b.atomic_store(lock, zero, 4, MemOrder::Release);
    }

    /// A structure's or a 128-bit integer's value is its address.
    fn value_at(&self, b: &mut SsaBuilder, at: ValueId, ty: i64) -> ValueId {
        if is_struct_value_ty(ty) {
            at
        } else {
            b.load(at, load_kind_for(ty, self.target))
        }
    }

    fn value_in_memory(&self, b: &mut SsaBuilder, value: ValueId, ty: i64, size: usize) -> ValueId {
        if is_struct_value_ty(ty) {
            return value;
        }
        let at = self.atomic_temp(b, size, size);
        b.store(at, value, store_kind_for(ty, self.target));
        at
    }

    /// C11 6.3.2.1p2.
    pub(super) fn atomic_object_load(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        let value_ty = non_atomic_ty(ty);
        let (size, align) = self.value_size_align(value_ty);
        let layout = self.atomic_object_layout(ty);
        match layout.access {
            // The exchange of zero for zero writes the contents into prior.
            AtomicAccess::Inline(16) => {
                let zero = (b.imm(0), b.imm(0));
                let prior = self.int128_materialize(b, zero);
                let zero = (b.imm(0), b.imm(0));
                let desired = self.int128_materialize(b, zero);
                b.atomic_cas16(addr, prior, desired, SEQ_CST);
                Ok(self.value_at(b, prior, value_ty))
            }
            AtomicAccess::Inline(width) => {
                let bits = b.atomic_load(addr, width, SEQ_CST);
                if !is_struct_value_ty(value_ty) {
                    return Ok(self.atomic_value_from_bits(b, bits, value_ty));
                }
                let at = self.atomic_temp(b, layout.size, layout.align);
                b.store(at, bits, int_store_kind(width));
                Ok(at)
            }
            AtomicAccess::LockWord(lock_off) => {
                let at = self.atomic_temp(b, size, align);
                let lock = b.binop_imm(BinOp::Add, addr, lock_off as i64);
                self.lock_word_acquire(b, lock);
                b.mcpy(at, addr, size as i64, align as u32);
                self.lock_word_release(b, lock);
                Ok(self.value_at(b, at, value_ty))
            }
            AtomicAccess::Library => {
                let at = self.atomic_temp(b, size, align);
                let args = alloc::vec![b.imm(size as i64), addr, at, b.imm(5)];
                self.atomic_libcall(b, "__atomic_load", args)?;
                Ok(self.value_at(b, at, value_ty))
            }
        }
    }

    pub(super) fn atomic_object_store(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        ty: i64,
        value: ValueId,
    ) -> Result<(), WalkError> {
        let value_ty = non_atomic_ty(ty);
        let (size, align) = self.value_size_align(value_ty);
        let layout = self.atomic_object_layout(ty);
        match layout.access {
            AtomicAccess::Inline(16) => {
                let src = self.value_in_memory(b, value, value_ty, 16);
                self.cas16_retry(b, addr, SEQ_CST, |this, b, _| this.int128_load(b, src));
            }
            AtomicAccess::Inline(width) => {
                let bits = if !is_struct_value_ty(value_ty) {
                    self.atomic_bits_of(b, value, value_ty)
                } else if size == width as usize {
                    b.load(value, int_load_kind(width))
                } else {
                    let at = self.atomic_temp(b, width as usize, width as usize);
                    let zero = b.imm(0);
                    b.store(at, zero, int_store_kind(width));
                    b.mcpy(at, value, size as i64, align as u32);
                    b.load(at, int_load_kind(width))
                };
                b.atomic_store(addr, bits, width, SEQ_CST);
            }
            AtomicAccess::LockWord(lock_off) => {
                let src = self.value_in_memory(b, value, value_ty, size);
                let lock = b.binop_imm(BinOp::Add, addr, lock_off as i64);
                self.lock_word_acquire(b, lock);
                b.mcpy(addr, src, size as i64, align as u32);
                self.lock_word_release(b, lock);
            }
            AtomicAccess::Library => {
                let src = self.value_in_memory(b, value, value_ty, size);
                let args = alloc::vec![b.imm(size as i64), addr, src, b.imm(5)];
                self.atomic_libcall(b, "__atomic_store", args)?;
            }
        }
        Ok(())
    }

    /// Replace the object's value `v` by `next(v)` in one read-modify-write;
    /// `fetch`, the instruction that does the whole update, if one does.
    pub(super) fn atomic_object_rmw(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        ty: i64,
        fetch: Option<(AtomicRmwOp, ValueId)>,
        next: &mut dyn FnMut(&mut Self, &mut SsaBuilder, ValueId) -> Result<ValueId, WalkError>,
    ) -> Result<(ValueId, ValueId), WalkError> {
        let value_ty = non_atomic_ty(ty);
        let (size, align) = self.value_size_align(value_ty);
        match self.atomic_object_layout(ty).access {
            AtomicAccess::Inline(16) => {
                // The new value goes over a copy of the comparand, so the
                // padding a value leaves undefined compares equal.
                let first = self.int128_load(b, addr);
                let prior = self.int128_materialize(b, first);
                let desired = self.atomic_temp(b, 16, 16);
                let (retry, done) = (b.new_block(), b.new_block());
                b.jmp(retry);
                b.switch_to(retry);
                let old = self.value_at(b, prior, value_ty);
                let new = next(self, b, old)?;
                b.mcpy(desired, prior, 16, 16);
                if is_struct_value_ty(value_ty) {
                    b.mcpy(desired, new, 16, 16);
                } else {
                    b.store(desired, new, store_kind_for(value_ty, self.target));
                }
                let ok = b.atomic_cas16(addr, prior, desired, SEQ_CST);
                b.branch_zero(ok, retry, done);
                b.switch_to(done);
                Ok((old, new))
            }
            AtomicAccess::Inline(width) => {
                if let Some((op, operand)) = fetch {
                    let bits = b.atomic_rmw(op, addr, operand, width, SEQ_CST);
                    let old = self.extend_atomic_result(b, bits, value_ty);
                    let new = next(self, b, old)?;
                    return Ok((old, new));
                }
                let slot = b.alloc_synthetic_local();
                let first = b.atomic_load(addr, width, SEQ_CST);
                b.store_local(slot, first, StoreKind::I64);
                let (retry, done) = (b.new_block(), b.new_block());
                b.jmp(retry);
                b.switch_to(retry);
                let expected = b.load_local(slot, LoadKind::I64);
                let old = self.atomic_value_from_bits(b, expected, value_ty);
                let new = next(self, b, old)?;
                let desired = self.atomic_bits_of(b, new, value_ty);
                let prior = b.atomic_cas(addr, expected, desired, width, SEQ_CST);
                b.store_local(slot, prior, StoreKind::I64);
                let ok = self.cas_matched(b, prior, expected, width);
                b.branch_zero(ok, retry, done);
                b.switch_to(done);
                Ok((old, new))
            }
            AtomicAccess::LockWord(lock_off) => {
                let lock = b.binop_imm(BinOp::Add, addr, lock_off as i64);
                self.lock_word_acquire(b, lock);
                let at = self.atomic_temp(b, size, align);
                b.mcpy(at, addr, size as i64, align as u32);
                let old = self.value_at(b, at, value_ty);
                let new = next(self, b, old)?;
                let src = self.value_in_memory(b, new, value_ty, size);
                b.mcpy(addr, src, size as i64, align as u32);
                self.lock_word_release(b, lock);
                Ok((old, new))
            }
            AtomicAccess::Library => Err(WalkError::Unsupported(
                "a read-modify-write of an `_Atomic` object the generic functions access",
            )),
        }
    }

    /// A structure, and a layout no single instruction covers.
    pub(super) fn atomic_builtin_takes_object_path(&self, ty: i64) -> bool {
        let value_ty = non_atomic_ty(ty);
        match self.atomic_object_layout(ty).access {
            AtomicAccess::Inline(16) => !self.is_int128_value_ty(value_ty),
            AtomicAccess::Inline(_) => is_struct_value_ty(value_ty),
            AtomicAccess::LockWord(_) | AtomicAccess::Library => true,
        }
    }

    /// C11 7.17.7 on the objects [`Self::atomic_builtin_takes_object_path`] names.
    pub(super) fn walk_atomic_object_builtin(
        &mut self,
        b: &mut SsaBuilder,
        kind: AtomicKind,
        args: &[ExprId],
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        let value_ty = non_atomic_ty(ty);
        let (size, align) = self.value_size_align(value_ty);
        let addr = self.walk_expr_rvalue(b, args[0])?;
        match kind {
            AtomicKind::Load => self.atomic_object_load(b, addr, ty),
            AtomicKind::LoadInto => {
                let value = self.atomic_object_load(b, addr, ty)?;
                let ret = self.walk_expr_rvalue(b, args[1])?;
                if is_struct_value_ty(value_ty) {
                    b.mcpy(ret, value, size as i64, align as u32);
                } else {
                    b.store(ret, value, store_kind_for(value_ty, self.target));
                }
                Ok(b.imm(0))
            }
            AtomicKind::Store | AtomicKind::StoreFrom => {
                let mut value = self.walk_expr_rvalue(b, args[1])?;
                if matches!(kind, AtomicKind::StoreFrom) {
                    value = self.value_at(b, value, value_ty);
                }
                self.atomic_object_store(b, addr, ty, value)?;
                Ok(b.imm(0))
            }
            AtomicKind::Exchange => {
                let value = self.walk_expr_rvalue(b, args[1])?;
                self.atomic_object_exchange(b, addr, ty, value)
            }
            AtomicKind::CompareExchangeStrong => {
                let expected = self.walk_expr_rvalue(b, args[1])?;
                let desired = self.walk_expr_rvalue(b, args[2])?;
                self.atomic_object_compare_exchange(b, addr, ty, expected, desired)
            }
            AtomicKind::FetchAdd
            | AtomicKind::FetchSub
            | AtomicKind::FetchAnd
            | AtomicKind::FetchOr
            | AtomicKind::FetchXor
            | AtomicKind::AddFetch
            | AtomicKind::SubFetch
            | AtomicKind::AndFetch
            | AtomicKind::OrFetch
            | AtomicKind::XorFetch
                if self.is_int128_value_ty(value_ty) =>
            {
                let op = match kind {
                    AtomicKind::FetchAdd | AtomicKind::AddFetch => BinOp::Add,
                    AtomicKind::FetchSub | AtomicKind::SubFetch => BinOp::Sub,
                    AtomicKind::FetchAnd | AtomicKind::AndFetch => BinOp::And,
                    AtomicKind::FetchOr | AtomicKind::OrFetch => BinOp::Or,
                    _ => BinOp::Xor,
                };
                let operand = RmwOperand::Pair(self.int128_operand(b, args[1])?);
                let (old, new) =
                    self.atomic_object_rmw(b, addr, ty, None, &mut |this, b, old| {
                        let a = this.int128_load(b, old);
                        let pair = this.int128_apply(b, op, a, &operand, value_ty, false)?;
                        Ok(this.int128_materialize(b, pair))
                    })?;
                let post = matches!(
                    kind,
                    AtomicKind::AddFetch
                        | AtomicKind::SubFetch
                        | AtomicKind::AndFetch
                        | AtomicKind::OrFetch
                        | AtomicKind::XorFetch
                );
                Ok(if post { new } else { old })
            }
            _ => Err(WalkError::UnsupportedExpr {
                id: args[0],
                kind: "this atomic operation on an `_Atomic` structure or on an object \
                       with a lock",
            }),
        }
    }

    /// C11 7.17.7.3: the prior value.
    fn atomic_object_exchange(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        ty: i64,
        value: ValueId,
    ) -> Result<ValueId, WalkError> {
        let value_ty = non_atomic_ty(ty);
        let (size, align) = self.value_size_align(value_ty);
        let layout = self.atomic_object_layout(ty);
        match layout.access {
            AtomicAccess::Inline(16) => {
                let src = self.value_in_memory(b, value, value_ty, 16);
                let (prior, _) =
                    self.cas16_retry(b, addr, SEQ_CST, |this, b, _| this.int128_load(b, src));
                Ok(self.value_at(b, prior, value_ty))
            }
            AtomicAccess::Inline(width) => {
                let src = self.value_in_memory(b, value, value_ty, size);
                let bits = self.widened_bits(b, src, size, align, width);
                let old = b.atomic_rmw(AtomicRmwOp::Xchg, addr, bits, width, SEQ_CST);
                let at = self.atomic_temp(b, layout.size, layout.align);
                b.store(at, old, int_store_kind(width));
                Ok(self.value_at(b, at, value_ty))
            }
            AtomicAccess::LockWord(lock_off) => {
                let src = self.value_in_memory(b, value, value_ty, size);
                let at = self.atomic_temp(b, size, align);
                let lock = b.binop_imm(BinOp::Add, addr, lock_off as i64);
                self.lock_word_acquire(b, lock);
                b.mcpy(at, addr, size as i64, align as u32);
                b.mcpy(addr, src, size as i64, align as u32);
                self.lock_word_release(b, lock);
                Ok(self.value_at(b, at, value_ty))
            }
            AtomicAccess::Library => {
                let src = self.value_in_memory(b, value, value_ty, size);
                let at = self.atomic_temp(b, size, align);
                let args = alloc::vec![b.imm(size as i64), addr, src, at, b.imm(5)];
                self.atomic_libcall(b, "__atomic_exchange", args)?;
                Ok(self.value_at(b, at, value_ty))
            }
        }
    }

    /// C11 7.17.7.4: 1 when `*expected` matched, else 0 with the value in it.
    fn atomic_object_compare_exchange(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        ty: i64,
        expected: ValueId,
        desired: ValueId,
    ) -> Result<ValueId, WalkError> {
        let value_ty = non_atomic_ty(ty);
        let (size, align) = self.value_size_align(value_ty);
        let layout = self.atomic_object_layout(ty);
        let desired = self.value_in_memory(b, desired, value_ty, size.max(16));
        match layout.access {
            AtomicAccess::Inline(16) => Ok(b.atomic_cas16(addr, expected, desired, SEQ_CST)),
            AtomicAccess::Inline(width) => {
                let want = self.widened_bits(b, expected, size, align, width);
                let new = self.widened_bits(b, desired, size, align, width);
                let prior = b.atomic_cas(addr, want, new, width, SEQ_CST);
                let ok = self.cas_matched(b, prior, want, width);
                let (write_back, done) = (b.new_block(), b.new_block());
                b.branch_zero(ok, write_back, done);
                b.switch_to(write_back);
                let at = self.atomic_temp(b, layout.size, layout.align);
                b.store(at, prior, int_store_kind(width));
                b.mcpy(expected, at, size as i64, align as u32);
                b.jmp(done);
                b.switch_to(done);
                Ok(ok)
            }
            AtomicAccess::LockWord(lock_off) => {
                let lock = b.binop_imm(BinOp::Add, addr, lock_off as i64);
                self.lock_word_acquire(b, lock);
                let differ = self.bytes_differ(b, addr, expected, size);
                let (matched, mismatched, done) = (b.new_block(), b.new_block(), b.new_block());
                b.branch_zero(differ, matched, mismatched);
                b.switch_to(matched);
                b.mcpy(addr, desired, size as i64, align as u32);
                b.jmp(done);
                b.switch_to(mismatched);
                b.mcpy(expected, addr, size as i64, align as u32);
                b.jmp(done);
                b.switch_to(done);
                self.lock_word_release(b, lock);
                Ok(b.binop_imm(BinOp::Eq, differ, 0))
            }
            AtomicAccess::Library => {
                let order = b.imm(5);
                let args = alloc::vec![b.imm(size as i64), addr, expected, desired, order, order];
                let ok = self.atomic_libcall(b, "__atomic_compare_exchange", args)?;
                Ok(b.binop_imm(BinOp::And, ok, 0xff))
            }
        }
    }

    /// The `width` bytes for the `size`-byte value at `src`, zero-padded.
    fn widened_bits(
        &self,
        b: &mut SsaBuilder,
        src: ValueId,
        size: usize,
        align: usize,
        width: u8,
    ) -> ValueId {
        if size == width as usize {
            return b.load(src, int_load_kind(width));
        }
        let at = self.atomic_temp(b, width as usize, width as usize);
        let zero = b.imm(0);
        b.store(at, zero, int_store_kind(width));
        b.mcpy(at, src, size as i64, align as u32);
        b.load(at, int_load_kind(width))
    }

    fn bytes_differ(
        &self,
        b: &mut SsaBuilder,
        a: ValueId,
        b_addr: ValueId,
        size: usize,
    ) -> ValueId {
        let mut acc = b.imm(0);
        let mut off = 0usize;
        while off < size {
            let width = match size - off {
                8.. => 8u8,
                4..=7 => 4,
                2..=3 => 2,
                _ => 1,
            };
            let at = |b: &mut SsaBuilder, base: ValueId| {
                let p = b.binop_imm(BinOp::Add, base, off as i64);
                b.load(p, int_load_kind(width))
            };
            let x = at(b, a);
            let y = at(b, b_addr);
            let d = b.binop(BinOp::Xor, x, y);
            acc = b.binop(BinOp::Or, acc, d);
            off += width as usize;
        }
        acc
    }

    /// C11 6.5.16.1p2: the stored value is the expression's.
    pub(super) fn walk_atomic_assign(
        &mut self,
        b: &mut SsaBuilder,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        let value_ty = non_atomic_ty(ty);
        let addr = self.atomic_lvalue_addr(b, lhs, ty)?;
        let mut value = self.walk_expr_rvalue(b, rhs)?;
        if is_struct_value_ty(value_ty) {
            self.atomic_object_store(b, addr, ty, value)?;
            return Ok(value);
        }
        if matches!(store_kind_for(value_ty, self.target), StoreKind::F32) {
            value = b.fp_narrow_to_f32(value);
        }
        self.atomic_object_store(b, addr, ty, value)?;
        let rhs_ty = expr_ty(self.ast.expr(rhs)).unwrap_or(value_ty);
        Ok(self.narrow_int_to_ty(b, value, rhs_ty, value_ty))
    }

    /// C11 6.5.16.2p3: one read-modify-write.
    pub(super) fn walk_atomic_compound_assign(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
        op_ty: i64,
    ) -> Result<ValueId, WalkError> {
        let value_ty = non_atomic_ty(ty);
        let addr = self.atomic_lvalue_addr(b, lhs, ty)?;
        if self.is_int128_value_ty(value_ty) {
            let operand = self.int128_rmw_operand(b, op, rhs, op_ty)?;
            let signed = (value_ty & UNSIGNED_BIT) == 0;
            let (_, new) = self.atomic_object_rmw(b, addr, ty, None, &mut |this, b, old| {
                let a = this.int128_load(b, old);
                let pair = this.int128_apply(b, op, a, &operand, op_ty, signed)?;
                Ok(this.int128_materialize(b, pair))
            })?;
            return Ok(new);
        }
        let rhs_ty = expr_ty(self.ast.expr(rhs)).unwrap_or(op_ty);
        let width = self.divmod_operand_width(op, value_ty, lhs, rhs);
        let mask = self.operand_mask(op, value_ty, lhs, rhs);
        let rv = self.walk_expr_rvalue(b, rhs)?;
        let fetch = self.fetch_op(op, value_ty, op_ty).map(|f| (f, rv));
        let (_, new) = self.atomic_object_rmw(b, addr, ty, fetch, &mut |this, b, old| {
            if is_floating_scalar(op_ty) {
                let lv = this.convert_scalar_value(b, old, value_ty, op_ty);
                let rv = this.convert_scalar_value(b, rv, rhs_ty, op_ty);
                let res = this.walk_fp_binop(b, op, lv, rv);
                return Ok(this.convert_scalar_value(b, res, op_ty, value_ty));
            }
            let res = Self::int_binop_values(b, op, old, rv, width, mask);
            Ok(this.atomic_narrow(b, res, value_ty))
        })?;
        Ok(new)
    }

    /// C11 6.5.2.4p2 / 6.5.3.1: one read-modify-write adding `by`.
    pub(super) fn walk_atomic_inc(
        &mut self,
        b: &mut SsaBuilder,
        lvalue: ExprId,
        by: i64,
        ty: i64,
        post: bool,
    ) -> Result<ValueId, WalkError> {
        let value_ty = non_atomic_ty(ty);
        let addr = self.atomic_lvalue_addr(b, lvalue, ty)?;
        let (old, new) = if self.is_int128_value_ty(value_ty) {
            self.atomic_object_rmw(b, addr, ty, None, &mut |this, b, old| {
                let a = this.int128_load(b, old);
                let step = (b.imm(by), b.imm(by >> 63));
                let sum = Self::int128_add(b, a, step);
                Ok(this.int128_materialize(b, sum))
            })?
        } else {
            let fetch = self.fetch_op(BinOp::Add, value_ty, value_ty);
            let fetch = fetch.map(|f| (f, b.imm(by)));
            self.atomic_object_rmw(b, addr, ty, fetch, &mut |this, b, old| {
                let stepped = this.increment_value(b, old, by, value_ty);
                Ok(if is_floating_scalar(value_ty) {
                    stepped
                } else {
                    this.atomic_narrow(b, stepped, value_ty)
                })
            })?
        };
        Ok(if post { old } else { new })
    }

    /// The instruction that performs `op` in place: its truncation is the
    /// conversion back to `ty`, which a `_Bool` or a floating `op_ty` is not.
    fn fetch_op(&self, op: BinOp, ty: i64, op_ty: i64) -> Option<AtomicRmwOp> {
        if is_floating_scalar(ty) || is_floating_scalar(op_ty) || is_bool_scalar(ty) {
            return None;
        }
        match op {
            BinOp::Add => Some(AtomicRmwOp::Add),
            BinOp::Sub => Some(AtomicRmwOp::Sub),
            BinOp::And => Some(AtomicRmwOp::And),
            BinOp::Or => Some(AtomicRmwOp::Or),
            BinOp::Xor => Some(AtomicRmwOp::Xor),
            _ => None,
        }
    }

    /// C11 6.3.1.2, 6.3.1.3.
    fn atomic_narrow(&mut self, b: &mut SsaBuilder, v: ValueId, ty: i64) -> ValueId {
        if is_bool_scalar(ty) {
            return b.binop_imm(BinOp::Ne, v, 0);
        }
        self.narrow_int_to_ty(b, v, Ty::LongLong as i64, ty)
    }

    fn int128_rmw_operand(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        rhs: ExprId,
        op_ty: i64,
    ) -> Result<RmwOperand, WalkError> {
        if is_floating_scalar(op_ty) || matches!(op, BinOp::Shl | BinOp::Shr | BinOp::Shru) {
            let value = self.walk_copy_operand(b, rhs)?;
            let ty = expr_ty(self.ast.expr(rhs)).unwrap_or(op_ty);
            let value = if self.is_int128_value_ty(ty) {
                b.load(value, LoadKind::I64)
            } else {
                value
            };
            return Ok(RmwOperand::Scalar { value, ty });
        }
        Ok(RmwOperand::Pair(self.int128_operand(b, rhs)?))
    }

    /// A floating `op_ty` converts `a` to it and back (C11 6.3.1.4).
    fn int128_apply(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        a: Halves,
        operand: &RmwOperand,
        op_ty: i64,
        signed: bool,
    ) -> Result<Halves, WalkError> {
        let pair = match operand {
            RmwOperand::Scalar { value, ty } if is_floating_scalar(op_ty) => {
                let lv = self.int128_to_fp(b, a, signed, super::types::is_float_ty(op_ty));
                let rv = self.convert_scalar_value(b, *value, *ty, op_ty);
                let res = self.walk_fp_binop(b, op, lv, rv);
                return Ok(self.fp_to_int128(b, res, signed));
            }
            RmwOperand::Scalar { value, .. } => {
                return Ok(match b.peek_imm(*value) {
                    Some(k) => Self::int128_shift_const(b, op, a, k),
                    None => Self::int128_shift(b, op, a, *value),
                });
            }
            RmwOperand::Pair(c) => *c,
        };
        Ok(match op {
            BinOp::Add => Self::int128_add(b, a, pair),
            BinOp::Sub => Self::int128_sub(b, a, pair),
            BinOp::And | BinOp::Or | BinOp::Xor => {
                (b.binop(op, a.0, pair.0), b.binop(op, a.1, pair.1))
            }
            BinOp::Mul => Self::int128_mul(b, a, pair),
            BinOp::Div | BinOp::Mod => {
                let (q, r) = self.int128_sdivmod(b, a, pair);
                if op == BinOp::Div { q } else { r }
            }
            BinOp::Divu | BinOp::Modu => {
                let (q, r) = self.int128_udivmod(b, a, pair);
                if op == BinOp::Divu { q } else { r }
            }
            _ => return Err(WalkError::Unsupported("128-bit compound operator")),
        })
    }
}

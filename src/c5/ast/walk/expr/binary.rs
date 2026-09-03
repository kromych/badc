//! Binary, assignment and compound-assignment expressions
//! (C99 6.5.5 - 6.5.16).

use super::super::access::{store_kind_for, store_kind_width, store_place};
use super::super::atomic::RmwOpen;
use super::super::types::{
    fold_int_binop, is_floating_scalar, is_fp_arith_op, type_size_bytes, unsigned_narrow_mask,
};
use super::super::*;
use super::postfix::MemberRef;
use crate::c5::ast::expr_ty;
use crate::c5::ir::{imm_safe_binop, is_comparison_op, is_fp_comparison_op, is_imm_arith_op};
impl<'a> Walker<'a> {
    /// Lower `&&` / `||` (C99 6.5.13 / 6.5.14): evaluate lhs, skip rhs
    /// when it decides the result, and merge through a synthetic local
    /// slot standing in for the phi. `normalize` reduces the stored
    /// value to 0/1, which value position requires and a branch
    /// condition does not.
    pub(super) fn walk_short_circuit(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
        normalize: bool,
    ) -> Result<ValueId, WalkError> {
        let (op, lhs, rhs) = match self.ast.expr(id) {
            Expr::ShortCircuit { op, lhs, rhs, .. } => (*op, *lhs, *rhs),
            _ => unreachable!("walk_short_circuit on non-ShortCircuit"),
        };
        let slot = b.alloc_synthetic_local();
        let kind_l = LoadKind::I64;
        let kind_s = StoreKind::I64;
        let lhs_val = self.walk_expr_rvalue(b, lhs)?;
        let lhs_t = self.cond_truthy(b, lhs_val, lhs);
        let short_val = if normalize {
            match op {
                ShortCircuitOp::Lor => b.imm(1),
                ShortCircuitOp::Lan => b.imm(0),
            }
        } else {
            lhs_t
        };
        b.store_local(slot, short_val, kind_s);
        let rhs_blk = b.new_block();
        let after_blk = b.new_block();
        match op {
            // `a && b`: skip rhs when lhs == 0.
            ShortCircuitOp::Lan => b.branch_zero(lhs_t, after_blk, rhs_blk),
            // `a || b`: skip rhs when lhs != 0.
            ShortCircuitOp::Lor => b.branch_nonzero(lhs_t, after_blk, rhs_blk),
        }
        b.switch_to(rhs_blk);
        let rhs_val = self.walk_expr_rvalue(b, rhs)?;
        let rhs_t = self.cond_truthy(b, rhs_val, rhs);
        let stored = if normalize {
            b.binop_imm(BinOp::Ne, rhs_t, 0)
        } else {
            rhs_t
        };
        b.store_local(slot, stored, kind_s);
        b.jmp(after_blk);
        b.switch_to(after_blk);
        Ok(b.load_local(slot, kind_l))
    }

    /// Operand width in bits for the constant-divisor lowering of `op`:
    /// the widest of the common type and the two operand types. `None`
    /// for a non-divide op or a type wider than a register, which keep
    /// the divide.
    pub(super) fn divmod_operand_width(
        &self,
        op: BinOp,
        ty: i64,
        lhs: ExprId,
        rhs: ExprId,
    ) -> Option<u32> {
        if !matches!(op, BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu) {
            return None;
        }
        let sz =
            |id: ExprId| expr_ty(self.ast.expr(id)).map_or(8, |t| type_size_bytes(t, self.target));
        match type_size_bytes(ty, self.target).max(sz(lhs)).max(sz(rhs)) {
            0..=4 => Some(32),
            5..=8 => Some(64),
            _ => None,
        }
    }

    /// Re-derive `op` from the operand types when either is
    /// floating-point: the parser's op tag can name the integer
    /// comparison for an operand that lowers to an FP register, which
    /// the integer paths cannot compare. A comparison operand counts as
    /// integer -- its result is `int` (C99 6.5.8) whatever type its node
    /// carries.
    fn fp_comparison_for_operands(&self, op: BinOp, lhs: ExprId, rhs: ExprId) -> BinOp {
        let operand_is_fp = |id: ExprId| -> bool {
            let e = self.ast.expr(id);
            if let Expr::Binary { op, .. } = e
                && is_comparison_op(*op)
            {
                return false;
            }
            expr_ty(e).is_some_and(is_floating_scalar)
        };
        if !operand_is_fp(lhs) && !operand_is_fp(rhs) {
            return op;
        }
        match op {
            BinOp::Eq => BinOp::Feq,
            BinOp::Ne => BinOp::Fne,
            BinOp::Lt => BinOp::Flt,
            BinOp::Gt => BinOp::Fgt,
            BinOp::Le => BinOp::Fle,
            BinOp::Ge => BinOp::Fge,
            other => other,
        }
    }

    /// Mask both operands of an unsigned relational compare need, or 0.
    /// C99 6.3.1.8 converts a signed operand to the unsigned common
    /// type, discarding the sign-extended high bits it carries in the
    /// 64-bit register; left in place they make the compare read a huge
    /// value. An unsigned operand, a non-negative literal and an 8-byte
    /// operand need no mask.
    fn unsigned_cmp_mask(&self, op: BinOp, lhs: ExprId, rhs: ExprId) -> i64 {
        if !matches!(op, BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge) {
            return 0;
        }
        let needs = |id: ExprId| -> (bool, usize) {
            let e = self.ast.expr(id);
            let ty = expr_ty(e);
            let sz = ty.map_or(8, |t| type_size_bytes(t, self.target));
            let signed = ty.is_some_and(|t| t & UNSIGNED_BIT == 0);
            let nonneg_lit = matches!(e, Expr::IntLit { val, .. } if *val >= 0);
            (signed && !nonneg_lit, sz)
        };
        let (l_needs, lsz) = needs(lhs);
        let (r_needs, rsz) = needs(rhs);
        if lsz <= 4 && rsz <= 4 && (l_needs || r_needs) {
            0xffff_ffffi64
        } else {
            0
        }
    }

    /// Lower a floating-point binop over walked operands. C99 6.3.1.8
    /// keeps the op single precision only when both operands are f32;
    /// any f64 operand promotes the op and widens the other (6.3.1.5).
    /// The builder's f32 markers decide, not the operands' C types,
    /// which an intervening widening can leave behind.
    fn walk_fp_binop(&self, b: &mut SsaBuilder, op: BinOp, lv: ValueId, rv: ValueId) -> ValueId {
        if b.is_f32(lv) && b.is_f32(rv) {
            let res = b.binop(op, lv, rv);
            // A comparison produces an `int`, so only arithmetic is
            // tagged single precision.
            if is_fp_arith_op(op) {
                return b.mark_f32(res);
            }
            return res;
        }
        let lv = b.fp_widen_to_f64(lv);
        let rv = b.fp_widen_to_f64(rv);
        b.binop(op, lv, rv)
    }

    /// Route a binop through the per-arch `BinopI` form when a walked
    /// operand turned out to be an immediate, so the literal never
    /// spills to a register. An lhs immediate needs the operands
    /// swapped, which holds for a commutative operator and for an
    /// ordered comparison once the direction is flipped (`K < x` becomes
    /// `x > K`).
    fn binop_imm_form(b: &mut SsaBuilder, op: BinOp, lv: ValueId, rv: ValueId) -> Option<ValueId> {
        if let Some(rk) = b.peek_imm(rv) {
            return Some(b.binop_imm(op, lv, rk));
        }
        let swapped = match op {
            BinOp::Add
            | BinOp::Mul
            | BinOp::And
            | BinOp::Or
            | BinOp::Xor
            | BinOp::Eq
            | BinOp::Ne => op,
            BinOp::Lt => BinOp::Gt,
            BinOp::Gt => BinOp::Lt,
            BinOp::Le => BinOp::Ge,
            BinOp::Ge => BinOp::Le,
            BinOp::Ult => BinOp::Ugt,
            BinOp::Ugt => BinOp::Ult,
            BinOp::Ule => BinOp::Uge,
            BinOp::Uge => BinOp::Ule,
            _ => return None,
        };
        let lk = b.peek_imm(lv)?;
        Some(b.binop_imm(swapped, rv, lk))
    }

    /// C99 6.5.5 - 6.5.14: a binary operator over two operands.
    pub(super) fn walk_binary(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        // A vector-typed node is element-wise (GCC vector extension),
        // and a 128-bit operand makes the node 128-bit whatever type it
        // carries: a comparison's result is `int`, and the parser spells
        // the unary operators as a binop against a literal.
        if is_vector_ty(self.structs, ty) {
            return self.walk_vector_binop(b, op, lhs, rhs, ty);
        }
        if self.is_int128_binary(lhs, rhs) {
            return self.walk_int128_binary(b, op, lhs, rhs);
        }
        let op = self.fp_comparison_for_operands(op, lhs, rhs);
        // C99 6.3.1.3 + 6.3.1.8: unsigned divide / modulo at a common
        // type narrower than the register masks each operand first, or
        // `udiv` / `umod` see the sign-extended high half a promoted
        // signed operand carries.
        let divmod_mask = if matches!(op, BinOp::Divu | BinOp::Modu) {
            unsigned_narrow_mask(ty)
        } else {
            0
        };
        let cmp_mask = self.unsigned_cmp_mask(op, lhs, rhs);
        // An operand needing a mask takes the register path, since the
        // immediate fast paths skip the masking below.
        let imm_safe_op = imm_safe_binop(op) && cmp_mask == 0;
        debug_assert!(
            !(imm_safe_op && divmod_mask != 0),
            "imm_safe_binop should exclude Divu/Modu"
        );
        // C99 6.6: a constant expression evaluates at translation time.
        // The parser leaves the synthesised pointer-arithmetic scaling
        // unfolded (`arr[K]` lowers to `arr + (K * sizeof(*arr))`).
        if imm_safe_op
            && let Expr::IntLit { val: lv_imm, .. } = *self.ast.expr(lhs)
            && let Expr::IntLit { val: rv_imm, .. } = *self.ast.expr(rhs)
        {
            return Ok(b.imm(fold_int_binop(op, lv_imm, rv_imm)));
        }
        let mut lv = self.walk_expr_rvalue(b, lhs)?;
        if imm_safe_op && let Expr::IntLit { val, .. } = self.ast.expr(rhs) {
            return Ok(b.binop_imm(op, lv, *val));
        }
        let mut rv = self.walk_expr_rvalue(b, rhs)?;
        if is_fp_arith_op(op) || is_fp_comparison_op(op) {
            return Ok(self.walk_fp_binop(b, op, lv, rv));
        }
        if imm_safe_op && let Some(v) = Self::binop_imm_form(b, op, lv, rv) {
            return Ok(v);
        }
        if divmod_mask != 0 || cmp_mask != 0 {
            let m = if divmod_mask != 0 {
                divmod_mask
            } else {
                cmp_mask
            };
            lv = b.binop_imm(BinOp::And, lv, m);
            rv = b.binop_imm(BinOp::And, rv, m);
        }
        // The only constant-divisor fast path: `imm_safe_binop` excludes
        // Div / Mod because the per-arch `BinopI` emit does not lower
        // them.
        if let Some(w) = self.divmod_operand_width(op, ty, lhs, rhs)
            && let Some(reduced) = b.divmod_const(op, lv, rv, w)
        {
            return Ok(reduced);
        }
        // The parser already pushes the narrowing (a mask, or a signed
        // `Shl K; Shr K` pair) as further `Expr::Binary` nodes, so
        // repeating it here would apply it twice.
        Ok(b.binop(op, lv, rv))
    }

    /// C99 6.5.16.1 assignment to a bitfield member.
    pub(super) fn walk_bitfield_assign(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
        m: MemberRef,
        bitfield: BitfieldDesc,
        rhs: ExprId,
    ) -> Result<ValueId, WalkError> {
        let MemberRef { obj, field_off, ty } = m;
        let vol = is_volatile_ty(ty) || self.expr_is_volatile(obj);
        let bf = bitfield;
        let seg = self.bitfield_access_seg(id, ty, bf)?;
        let base = self.walk_expr_rvalue(b, obj)?;
        let addr = if field_off != 0 {
            b.binop_imm(BinOp::Add, base, field_off)
        } else {
            base
        };
        // The RHS is evaluated before the storage unit is loaded: a
        // chained assignment writing the same unit (`a.x = a.y = v`)
        // must be observed by this read-modify-write, not clobbered.
        let rhs_v = self.bitfield_store_value(b, bf, rhs)?;
        let align = self.member_align(obj, field_off, bf.unit_size as u32);
        Ok(self.store_into_bitfield(b, addr, bf, rhs_v, seg, vol, align))
    }

    /// C99 6.5.16.1 simple assignment.
    pub(super) fn walk_assign(
        &mut self,
        b: &mut SsaBuilder,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        // C99 6.5.16.1p1: a struct-typed assignment copies the bytes.
        // Both sides are address producers, and the expression's value
        // is the destination address.
        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
            let dst_seg = self.access_seg(lhs, ty)?;
            let src_seg = match self.seg_aggregate_ty(rhs) {
                Some(t) => self.access_seg(rhs, t)?,
                None => AsmSeg::None,
            };
            let dst = self.walk_expr_lvalue(b, lhs)?;
            let src = self.walk_expr_rvalue(b, rhs)?;
            let size = self.struct_size(ty);
            let align = self.struct_align(ty);
            if dst_seg == AsmSeg::None && src_seg == AsmSeg::None {
                b.mcpy(dst, src, size, align);
            } else {
                let vol =
                    is_volatile_ty(ty) || self.expr_is_volatile(lhs) || self.expr_is_volatile(rhs);
                self.seg_copy_bytes(b, dst, dst_seg, src, src_seg, size, align, vol);
            }
            return Ok(dst);
        }
        // A `Token::Loc` Ident target stores through a single
        // `StoreLocal` rather than `LocalAddr` + `Store`, which keeps
        // the slot mem2reg-promotable.
        let kind = store_kind_for(ty, self.target);
        let vol = is_volatile_ty(ty) || self.expr_is_volatile(lhs);
        if let Expr::Ident {
            class,
            val,
            is_thread_local: false,
            ..
        } = self.ast.expr(lhs)
            && *class == Token::Loc as i64
        {
            // A frame slot has no named address space; the parser
            // rejects such a declaration, so a tag here is an error.
            if segment_of_object_ty(ty).is_some() {
                return Err(WalkError::InvalidExpr {
                    id: lhs,
                    kind: "named address space on automatic storage",
                });
            }
            let slot = *val;
            // The destination is the object's own storage, so its
            // top-level qualifier governs, not a pointee's.
            let vol = is_volatile_object_ty(ty);
            let mut value = self.walk_expr_rvalue(b, rhs)?;
            // C99 6.3.1.5: a `double` assigned to a `float` object is
            // narrowed, and the expression's value is the narrowed one.
            if matches!(kind, StoreKind::F32) {
                value = b.fp_narrow_to_f32(value);
            }
            b.store_local_vol(slot, value, kind, vol);
            // C99 6.5.16p3: the expression's value has the left
            // operand's converted type, so it narrows as the store did.
            let rhs_ty = expr_ty(self.ast.expr(rhs)).unwrap_or(ty);
            return Ok(self.narrow_int_to_ty(b, value, rhs_ty, ty));
        }
        let seg = self.access_seg(lhs, ty)?;
        let addr = self.walk_expr_lvalue(b, lhs)?;
        let mut value = self.walk_expr_rvalue(b, rhs)?;
        // C99 6.3.1.5: a `double` assigned to a `float` object is
        // narrowed here -- the parser inserts no cast between the two,
        // being the same type class.
        if matches!(kind, StoreKind::F32) {
            value = b.fp_narrow_to_f32(value);
        }
        let align = self.lvalue_align(lhs, store_kind_width(kind));
        store_place(b, addr, value, kind, seg, vol, align);
        // C99 6.5.16p3: the expression's value has the left operand's
        // converted type, so it narrows as the store did.
        let rhs_ty = expr_ty(self.ast.expr(rhs)).unwrap_or(ty);
        Ok(self.narrow_int_to_ty(b, value, rhs_ty, ty))
    }

    /// C99 6.5.16.2 compound assignment.
    pub(super) fn walk_compound_assign(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        // C99 6.5.16.2p3: `E1 op= E2` is `E1 = E1 op E2` with E1
        // evaluated once, and its value is the post-op value.
        if self.is_int128_value_ty(ty) || self.is_wide_unit_bitfield(lhs) {
            return self.walk_int128_compound_assign(b, op, lhs, rhs);
        }
        let RmwOpen {
            place,
            load_kind,
            store_kind,
            vol,
            old,
        } = self.rmw_open(b, lhs, ty)?;
        let imm_safe = is_imm_arith_op(op);
        let new_val = if is_fp_arith_op(op) && !is_floating_scalar(ty) {
            // C99 6.5.16.2: an integer lvalue with a floating operand
            // computes in the floating common type and converts back to
            // the lvalue's type before the store.
            let lv = b.fp_cast(FpCastKind::IntToFp, old);
            let mut rv = self.walk_expr_rvalue(b, rhs)?;
            if b.is_f32(rv) {
                rv = b.fp_widen_to_f64(rv);
            }
            let res = b.binop(op, lv, rv);
            b.fp_cast(FpCastKind::FpToInt, res)
        } else if is_fp_arith_op(op) {
            // C99 6.5.16.2 computes in the operands' common type, then
            // converts to E1's type: the same precision rules a plain
            // binop follows, plus a narrowing to the store width.
            let mut lv = old;
            let mut rv = self.walk_expr_rvalue(b, rhs)?;
            let op_is_f32 = b.is_f32(lv) && b.is_f32(rv);
            if op_is_f32 {
                let res = b.binop(op, lv, rv);
                b.mark_f32(res)
            } else {
                lv = b.fp_widen_to_f64(lv);
                rv = b.fp_widen_to_f64(rv);
                let res = b.binop(op, lv, rv);
                // C99 6.3.1.5: narrow back to the lvalue's precision.
                if matches!(store_kind, StoreKind::F32) {
                    b.fp_narrow_to_f32(res)
                } else {
                    res
                }
            }
        } else if imm_safe && let Expr::IntLit { val, .. } = self.ast.expr(rhs) {
            b.binop_imm(op, old, *val)
        } else {
            let mut rhs_val = self.walk_expr_rvalue(b, rhs)?;
            // The walked rhs can be an `Imm` even where the AST shape is
            // not an `IntLit`.
            if imm_safe && let Some(rk) = b.peek_imm(rhs_val) {
                b.binop_imm(op, old, rk)
            } else {
                let mut lv = old;
                // C99 6.3.1.3 + 6.3.1.8: unsigned divide / modulo at a
                // narrower-than-register common type masks each operand
                // first. Both operand types at most 4 bytes makes the
                // common type 4 bytes, integer promotion flooring at
                // `int`.
                if matches!(op, BinOp::Divu | BinOp::Modu) {
                    let rhs_sz =
                        expr_ty(self.ast.expr(rhs)).map_or(8, |t| type_size_bytes(t, self.target));
                    if type_size_bytes(ty, self.target) <= 4 && rhs_sz <= 4 {
                        lv = b.binop_imm(BinOp::And, lv, 0xffff_ffff);
                        rhs_val = b.binop_imm(BinOp::And, rhs_val, 0xffff_ffff);
                    }
                }
                b.binop(op, lv, rhs_val)
            }
        };
        place.store(b, new_val, store_kind, vol);
        // C99 6.5.16.2p3: the value is the post-update value in E1's
        // type, so a sub-64-bit lvalue reloads through `load_kind`
        // rather than returning the unnarrowed 64-bit binop result. A
        // volatile lvalue is read once and written once (C99 6.7.3p6),
        // so it narrows in a register instead of re-reading.
        Ok(if matches!(load_kind, LoadKind::I64) {
            new_val
        } else if vol {
            if is_floating_scalar(ty) {
                new_val
            } else {
                self.narrow_int_to_ty(b, new_val, Ty::LongLong as i64, ty)
            }
        } else {
            place.load(b, load_kind, false)
        })
    }
}

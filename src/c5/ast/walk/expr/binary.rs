//! Binary, assignment and compound-assignment expressions
//! (C99 6.5.5 - 6.5.16).

use super::super::access::{store_kind_for, store_kind_width, store_place};
use super::super::atomic::RmwOpen;
use super::super::types::{
    expr_ty, fold_int_binop, imm_safe_binop, is_comparison_op, is_floating_scalar, is_fp_arith_op,
    is_fp_comparison_op, is_imm_arith_op, type_size_bytes, unsigned_narrow_mask,
};
use super::super::*;
use super::postfix::MemberRef;
impl<'a> Walker<'a> {
    /// Lower a `&&` / `||` expression (C99 6.5.13 / 6.5.14). Evaluate
    /// lhs; if it decides the result, skip rhs and jump to the merge
    /// block, otherwise evaluate rhs. A synthetic local slot stands in
    /// for the phi -- both arms store into it and the merge block loads
    /// it.
    ///
    /// `normalize` controls whether the stored value is reduced to 0/1.
    /// In value position the result is observed as an integer, so it
    /// must be `int` 0 or 1: store the constant the deciding lhs yields
    /// (`||` -> 1, `&&` -> 0) and `rhs != 0` on the evaluated path. In a
    /// branch condition only the truthiness is observed, so the raw
    /// operands are stored and the `!= 0` and the constant are skipped.
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
        // The deciding value is the lhs truthiness; a floating operand
        // compares against 0.0 so `-0.0` is false rather than a non-zero
        // bit pattern.
        let lhs_t = self.cond_truthy(b, lhs_val, lhs);
        // On the short-circuit path the lhs truthiness is the result, so
        // in branch context that value suffices.
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

    /// Operand width in bits for the constant-divisor lowering of
    /// `op`: the widest of the common type and the two operand types,
    /// so a sequence specialised to 32 bits is only chosen when no
    /// operand can carry a wider value. `None` for a non-divide op or
    /// a type wider than a register, both of which keep the divide.
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
    /// floating-point. The parser tags the op from the operand types;
    /// when that tracking is clouded by the surrounding expression it
    /// can emit the integer comparison against an operand that lowers
    /// to an FP register, which the integer paths cannot compare. A
    /// comparison operand counts as integer: its result is `int` (C99
    /// 6.5.8) even when its node carries the operand type.
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

    /// Mask both operands of an unsigned relational compare need before
    /// the compare, or 0 when they need none. C99 6.3.1.8 converts a
    /// signed operand to the unsigned common type, discarding the
    /// sign-extended high bits it carries in the 64-bit register; left
    /// in place they make the unsigned compare read a huge value. An
    /// unsigned operand is already zero-extended, a non-negative
    /// literal has no high bits set, and an 8-byte operand fills the
    /// register, so those need nothing.
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

    /// Lower a floating-point binop over already-walked operands. C99
    /// 6.3.1.8 keeps the op single precision only when both operands
    /// are f32; any f64 operand promotes the op and widens the other
    /// operand (6.3.1.5). The f32 markers the builder carries are the
    /// bit-accurate signal, since an operand's C type can diverge from
    /// its representation after an intervening widening.
    fn walk_fp_binop(&self, b: &mut SsaBuilder, op: BinOp, lv: ValueId, rv: ValueId) -> ValueId {
        if b.is_f32(lv) && b.is_f32(rv) {
            let res = b.binop(op, lv, rv);
            // Arithmetic produces a `float`; a comparison produces an
            // `int` and stays untagged.
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
    /// operand turned out to be an immediate, so the immediate-form
    /// peepholes fire and the literal never spills to a register. The
    /// producing `Imm` inst becomes dead and DCE drops it. An lhs
    /// immediate needs the operands swapped, which holds for a
    /// commutative operator and for an ordered comparison once the
    /// direction is flipped (`K < x` becomes `x > K`).
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
        // GCC vector extension: the parser tags a Binary node with a
        // vector type for the element-wise operators, including a
        // vector / scalar pair the scalar broadcasts across.
        if is_vector_ty(self.structs, ty) {
            return self.walk_vector_binop(b, op, lhs, rhs, ty);
        }
        // A 128-bit operand makes the node a 128-bit operation,
        // whatever the node's own type: a comparison's result is
        // `int`, and the parser spells the unary operators as a
        // binop against a literal.
        if self.is_int128_binary(lhs, rhs) {
            return self.walk_int128_binary(b, op, lhs, rhs);
        }
        let op = self.fp_comparison_for_operands(op, lhs, rhs);
        // C99 6.3.1.3 + 6.3.1.8: unsigned divide / modulo at a common
        // type narrower than the register masks each operand to that
        // width first. A signed operand promoted to the unsigned
        // common type carries its sign-extended high half, and without
        // the mask `udiv` / `umod` operate on the wider pattern.
        let divmod_mask = if matches!(op, BinOp::Divu | BinOp::Modu) {
            unsigned_narrow_mask(ty)
        } else {
            0
        };
        let cmp_mask = self.unsigned_cmp_mask(op, lhs, rhs);
        // Operands that need masking take the register path so the
        // mask below applies; the immediate fast paths skip it.
        let imm_safe_op = imm_safe_binop(op) && cmp_mask == 0;
        debug_assert!(
            !(imm_safe_op && divmod_mask != 0),
            "imm_safe_binop should exclude Divu/Modu"
        );
        // C99 6.6: a constant expression evaluates at translation
        // time. The parser does not fold the synthesised
        // pointer-arithmetic scaling (`arr[K]` lowers to `arr + (K *
        // sizeof(*arr))` with K and the size both literals).
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
        // The only constant-divisor fast path: the per-arch `BinopI`
        // emit does not lower Div / Mod, so `imm_safe_binop` excludes
        // them and they otherwise divide through the register path.
        if let Some(w) = self.divmod_operand_width(op, ty, lhs, rhs)
            && let Some(reduced) = b.divmod_const(op, lv, rv, w)
        {
            return Ok(reduced);
        }
        // The parser's `maybe_mask_to_unsigned_width` already pushes
        // the explicit narrow mask (or the signed `Shl K; Shr K` pair)
        // as additional `Expr::Binary` nodes, so narrowing the result
        // here would double-shift it.
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
        // C99 6.7.2.1: bitfield write -- load the storage
        // unit, clear the destination slice, mask + shift
        // the new value into place, OR the cleared old
        // value with the shifted new, store back. The
        // assignment's own value (for an enclosing expression)
        // is the masked field value, not the storage word.
        let bf = bitfield;
        let seg = self.bitfield_access_seg(id, ty, bf)?;
        let base = self.walk_expr_rvalue(b, obj)?;
        let addr = if field_off != 0 {
            b.binop_imm(BinOp::Add, base, field_off)
        } else {
            base
        };
        // Evaluate the RHS before loading the storage unit: a
        // chained assignment whose RHS writes the same unit
        // (adjacent bitfields, `a.x = a.y = v`) must be observed by
        // this read-modify-write, else its store is clobbered.
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
        // C99 6.5.16.1p1 + the c5 address-as-value rule:
        // a struct-typed assignment copies the bytes from
        // the source struct into the destination. The
        // walker walks both sides as lvalue / rvalue
        // address producers (struct rvalues land their
        // address on `ast_acc`, not a load) and emits
        // `Inst::Mcpy { dst, src, size }`. Returns the
        // dst address as the expression's value
        // (mirroring libc `memcpy`).
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
        // Local-target shortcut: a Token::Loc-class Ident
        // lvalue lowers to a single `StoreLocal` instead of
        // `LocalAddr` + `Store`, keeping the slot mem2reg-
        // promotable. The `F32` s-view is narrowed below before
        // the store so the assignment yields the f32 value.
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
            // rejects such declarations, so a tag reaching here is
            // an error, not a generic-space store.
            if segment_of_object_ty(ty).is_some() {
                return Err(WalkError::InvalidExpr {
                    id: lhs,
                    kind: "named address space on automatic storage",
                });
            }
            let slot = *val;
            // The destination is the object's own storage, so its
            // top-level qualifier governs, not one that sits on a
            // pointee below it.
            let vol = is_volatile_object_ty(ty);
            let mut value = self.walk_expr_rvalue(b, rhs)?;
            // C99 6.5.16.1 + 6.3.1.5: a `double` value assigned
            // to a `float` object is narrowed to single precision;
            // the assignment expression's value is the converted
            // (f32) value.
            if matches!(kind, StoreKind::F32) {
                value = b.fp_narrow_to_f32(value);
            }
            b.store_local_vol(slot, value, kind, vol);
            // C99 6.5.16p3: the assignment expression's value has
            // the converted type of the left operand. The store
            // truncated the stored bytes; the value carried
            // forward to an enclosing expression must also be
            // narrowed (the F32 case did so above).
            let rhs_ty = expr_ty(self.ast.expr(rhs)).unwrap_or(ty);
            return Ok(self.narrow_int_to_ty(b, value, rhs_ty, ty));
        }
        let seg = self.access_seg(lhs, ty)?;
        let addr = self.walk_expr_lvalue(b, lhs)?;
        let mut value = self.walk_expr_rvalue(b, rhs)?;
        // C99 6.5.16.1 + 6.3.1.5: a `double` value assigned to a
        // `float` object is narrowed to single precision. The
        // parser inserts no float<->double cast (same type
        // class), so the walker narrows here when the stored
        // value is still double. The assignment expression's
        // value is the converted (f32) value.
        if matches!(kind, StoreKind::F32) {
            value = b.fp_narrow_to_f32(value);
        }
        let align = self.lvalue_align(lhs, store_kind_width(kind));
        store_place(b, addr, value, kind, seg, vol, align);
        // C99 6.5.16p3: the assignment expression's value has the
        // converted type of the left operand. The store truncated
        // the stored bytes; the value carried forward to an
        // enclosing expression must also be narrowed (the F32 case
        // did so above). A dead value drops out in DCE.
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
        // C99 6.5.16.2p3: `E1 op= E2` is `E1 = E1 op E2`
        // with E1 evaluated once. Spill the lhs address,
        // load through it, apply the binop with rhs,
        // store back. The expression's value is the new
        // (post-op) value per the same clause.
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
        // Constant-rhs short-circuit (mirror of the
        // `Expr::Binary` path): an integer-literal rhs
        // routes through `binop_imm` so the per-arch
        // immediate-form peepholes fire and the literal
        // doesn't get materialised into a scratch first.
        // FP / Div / Divu / Mod / Modu stay on the
        // register-rhs path because the per-arch BinopI
        // lowering bails on them.
        let imm_safe = is_imm_arith_op(op);
        let new_val = if is_fp_arith_op(op) && !is_floating_scalar(ty) {
            // C99 6.5.16.2: an integer lvalue with a floating
            // operand. The operation runs in the floating common
            // type; convert the loaded integer up, apply the op,
            // then convert the result back to the lvalue's
            // integer type before the store.
            let lv = b.fp_cast(FpCastKind::IntToFp, old);
            let mut rv = self.walk_expr_rvalue(b, rhs)?;
            if b.is_f32(rv) {
                rv = b.fp_widen_to_f64(rv);
            }
            let res = b.binop(op, lv, rv);
            b.fp_cast(FpCastKind::FpToInt, res)
        } else if is_fp_arith_op(op) {
            // C99 6.5.16.2: `E1 op= E2` computes `E1 op E2` in
            // the operands' common type, then converts to E1's
            // type. `old` (the lvalue) is `float` when the store
            // is F32; the rhs may be `float` or `double`. Match
            // the `Expr::Binary` precision rules, then narrow the
            // result to the store width.
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
                // Narrow the double result back to the lvalue's
                // single precision (C99 6.3.1.5) before the store.
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
            // The walked rhs may have constant-folded to
            // an `Imm` even when the AST shape isn't an
            // `IntLit`; route through `binop_imm` in that
            // case for the same reason as the
            // `Expr::Binary` arm.
            if imm_safe && let Some(rk) = b.peek_imm(rhs_val) {
                b.binop_imm(op, old, rk)
            } else {
                let mut lv = old;
                // C99 6.3.1.3 + 6.3.1.8: unsigned divide /
                // modulo at a narrower-than-register common
                // type masks each operand first, mirroring
                // the `Expr::Binary` lowering. Both operand
                // types <= 4 bytes means the common type is
                // 4 bytes (integer promotion floors at int).
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
        // C99 6.5.16.2p3: the value of `E1 op= E2` is the
        // post-update value of E1 in E1's type. For a
        // sub-64-bit lvalue the 64-bit binop result is not
        // narrowed; reload through `load_kind` so the
        // returned ValueId reflects what was actually
        // stored (with the kind's sign / zero extension).
        // A volatile lvalue is accessed exactly once per read
        // and once per write (C99 6.7.3p6); its result is the
        // stored value narrowed in a register, never a re-read.
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

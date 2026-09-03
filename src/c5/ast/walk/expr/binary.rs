//! Binary, assignment and compound-assignment expressions
//! (C99 6.5.5 - 6.5.16).

use super::super::access::{load_kind_for, store_kind_for, store_kind_width, store_place};
use super::super::types::{
    expr_ty, fold_int_binop, imm_safe_binop, is_comparison_op, is_floating_scalar, type_size_bytes,
    unsigned_narrow_mask,
};
use super::super::*;
use super::postfix::MemberRef;
impl<'a> Walker<'a> {
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
        // A comparison whose operand is a floating-point value must
        // use the FP comparison. The parser tags the op from the
        // operand types; when that tracking is clouded by the
        // surrounding expression it can emit the integer variant
        // against an operand that lowers to an FP register, which
        // the integer paths cannot compare. Re-derive the op from
        // the operand types so the FP path below handles it.
        let op_remapped = {
            // An operand's value is floating-point when its node
            // carries a floating type tag -- except a comparison,
            // whose result is `int` even though its node may carry
            // the operand type. Treat a comparison operand as int.
            let operand_is_fp = |id: ExprId| -> bool {
                let e = self.ast.expr(id);
                if let Expr::Binary { op, .. } = e
                    && is_comparison_op(*op)
                {
                    return false;
                }
                expr_ty(e).is_some_and(is_floating_scalar)
            };
            let lhs_fp = operand_is_fp(lhs);
            let rhs_fp = operand_is_fp(rhs);
            if lhs_fp || rhs_fp {
                match op {
                    BinOp::Eq => BinOp::Feq,
                    BinOp::Ne => BinOp::Fne,
                    BinOp::Lt => BinOp::Flt,
                    BinOp::Gt => BinOp::Fgt,
                    BinOp::Le => BinOp::Fle,
                    BinOp::Ge => BinOp::Fge,
                    other => other,
                }
            } else {
                op
            }
        };
        let op = op_remapped;
        let mask = unsigned_narrow_mask(ty);
        let needs_divmod_mask = mask != 0 && matches!(op, BinOp::Divu | BinOp::Modu);
        // An unsigned relational compare at a common type narrower
        // than the register where one operand is signed: the signed
        // operand carries its sign-extended high bits in the 64-bit
        // register, but C99 6.3.1.8 converts it to the unsigned
        // common type (zero-extended), so those bits must be cleared
        // or the unsigned compare reads a huge value. The common
        // type is unsigned (the front end picked the U-op) and
        // 4-byte unless an operand is 8 bytes, in which case the
        // value already fills the register. Two unsigned operands
        // are already zero-extended and need no mask. Mask both
        // operands to the common width.
        let cmp_mask = if matches!(op, BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge) {
            // An operand carries sign-extended high bits only when it
            // is signed and not a non-negative literal: an unsigned
            // operand is zero-extended, and a non-negative constant
            // has no high bits set. The latter keeps the common
            // `unsigned < positive-literal` loop test on the
            // immediate path.
            let needs = |id: ExprId, this: &Self| -> (bool, usize) {
                let e = this.ast.expr(id);
                let ty = expr_ty(e);
                let sz = ty.map_or(8, |t| type_size_bytes(t, this.target));
                let signed = ty.is_some_and(|t| t & UNSIGNED_BIT == 0);
                let nonneg_lit = matches!(e, Expr::IntLit { val, .. } if *val >= 0);
                (signed && !nonneg_lit, sz)
            };
            let (l_needs, lsz) = needs(lhs, self);
            let (r_needs, rsz) = needs(rhs, self);
            if lsz <= 4 && rsz <= 4 && (l_needs || r_needs) {
                0xffff_ffffi64
            } else {
                0
            }
        } else {
            0
        };
        // Constant-rhs short-circuit: when the AST rhs is
        // an integer literal and the per-arch BinopI
        // lowering covers `op`, route through
        // `binop_imm`. The per-arch emit picks the
        // existing immediate-form peepholes
        // (`add r, imm`, `shl r, imm8`, sxtw/sxth/sxtb,
        // and so on) instead of materialising the literal
        // into a register first. Ops whose BinopI path
        // bails (Mod / Modu / Div / Divu / every FP op)
        // stay on the register-rhs path so the SSA emit
        // doesn't fall back to the pool path.
        let imm_safe_op = imm_safe_binop(op);
        // Operands that need masking take the register path so the
        // mask below applies; the immediate fast paths skip it.
        let imm_safe_op = imm_safe_op && cmp_mask == 0;
        // C99 6.6: a constant expression evaluates at
        // translation time. The parser doesn't fold the
        // synthesised pointer-arithmetic scaling
        // (`arr[K]` lowers to `arr + (K * sizeof(*arr))`
        // with K and the size both literals), so do the
        // fold here. Skip ops the per-arch BinopI lowering
        // doesn't cover.
        if imm_safe_op
            && let Expr::IntLit { val: lv_imm, .. } = *self.ast.expr(lhs)
            && let Expr::IntLit { val: rv_imm, .. } = *self.ast.expr(rhs)
        {
            return Ok(b.imm(fold_int_binop(op, lv_imm, rv_imm)));
        }
        let mut lv = self.walk_expr_rvalue(b, lhs)?;
        if imm_safe_op && let Expr::IntLit { val, .. } = self.ast.expr(rhs) {
            // C99 6.3.1.3 + 6.3.1.8: unsigned divide /
            // modulo at a narrower-than-register common
            // type needs each operand masked first. The
            // `imm_safe_op` set excludes Divu / Modu so
            // this branch never carries the divmod mask
            // path; the literal flows through unchanged.
            debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
            return Ok(b.binop_imm(op, lv, *val));
        }
        let mut rv = self.walk_expr_rvalue(b, rhs)?;
        // Floating-point binops (C99 6.3.1.8). `float op float`
        // is single precision; any `double` operand promotes the
        // op (and the other operand) to double. The parser
        // already chose Fadd/.../Feq and set `ty` to the result
        // type; the walker decides the operand / result width.
        if matches!(
            op,
            BinOp::Fadd
                | BinOp::Fsub
                | BinOp::Fmul
                | BinOp::Fdiv
                | BinOp::Feq
                | BinOp::Fne
                | BinOp::Flt
                | BinOp::Fgt
                | BinOp::Fle
                | BinOp::Fge
        ) {
            // C99 6.3.1.8: the op is single precision only when
            // both operands are already f32; any f64 operand
            // promotes the op (and the f32 operand) to double.
            // The walker tags each `float`-typed value f32 as it
            // is produced, so the operands' f32 markers are the
            // bit-accurate signal -- the operand AST's C type can
            // diverge from the value's representation after an
            // intervening widening.
            let op_is_f32 = b.is_f32(lv) && b.is_f32(rv);
            if op_is_f32 {
                let res = b.binop(op, lv, rv);
                // Arithmetic produces a `float`; tag it. A
                // comparison produces an `int` and is left
                // untagged.
                if matches!(op, BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv) {
                    return Ok(b.mark_f32(res));
                }
                return Ok(res);
            }
            // Double-precision op: any f32 operand widens to
            // double first (6.3.1.5).
            lv = b.fp_widen_to_f64(lv);
            rv = b.fp_widen_to_f64(rv);
            return Ok(b.binop(op, lv, rv));
        }
        // The rhs AST shape isn't an `IntLit`, but walking
        // it may have constant-folded down to one (e.g.
        // `K * sizeof(*arr)` with both K and the size as
        // literals). Inspect the SSA value the walker
        // returned and route through `binop_imm` when it
        // names an `Imm`. The producing inst becomes dead
        // (use_counts drops to 0) and DCE skips it.
        if imm_safe_op && let Some(rk) = b.peek_imm(rv) {
            debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
            return Ok(b.binop_imm(op, lv, rk));
        }
        // For commutative ops where the constant landed on
        // lhs (C99 source order `4 * i`), swap operands and
        // emit BinopI so the literal never spills to a
        // register. Bit ops Eq / Ne are commutative; ordered
        // comparisons Lt / Gt / Le / Ge / Ult / Ugt / Ule /
        // Uge are not, but swapping operands flips the
        // comparison direction, so `K < x` rewrites to
        // `x > K` (and so on), still routing through
        // BinopI.
        let commutative = matches!(
            op,
            BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor | BinOp::Eq | BinOp::Ne
        );
        let reversed_cmp = match op {
            BinOp::Lt => Some(BinOp::Gt),
            BinOp::Gt => Some(BinOp::Lt),
            BinOp::Le => Some(BinOp::Ge),
            BinOp::Ge => Some(BinOp::Le),
            BinOp::Ult => Some(BinOp::Ugt),
            BinOp::Ugt => Some(BinOp::Ult),
            BinOp::Ule => Some(BinOp::Uge),
            BinOp::Uge => Some(BinOp::Ule),
            _ => None,
        };
        if imm_safe_op
            && commutative
            && let Some(lk) = b.peek_imm(lv)
        {
            debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
            return Ok(b.binop_imm(op, rv, lk));
        }
        if imm_safe_op
            && let Some(swapped_op) = reversed_cmp
            && let Some(lk) = b.peek_imm(lv)
        {
            debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
            return Ok(b.binop_imm(swapped_op, rv, lk));
        }
        // C99 6.3.1.3 + 6.3.1.8: unsigned divide / modulo
        // at a narrower-than-register common type needs
        // each operand masked to that width *before* the
        // op. A signed operand promoted to the unsigned
        // common type carries its sign-extended high
        // half in the 64-bit register; without the mask,
        // `udiv` / `umod` operate on the wider pattern
        // and produce the wrong order of magnitude.
        if needs_divmod_mask || cmp_mask != 0 {
            let m = if needs_divmod_mask { mask } else { cmp_mask };
            lv = b.binop_imm(BinOp::And, lv, m);
            rv = b.binop_imm(BinOp::And, rv, m);
        }
        // Strength-reduce divide / modulo by a constant divisor
        // to shifts, masks and reciprocal multiplies. This is
        // the only constant-divisor fast path: the per-arch
        // `BinopI` emit does not lower Div / Mod, so they are
        // otherwise excluded from `imm_safe_op` and divide
        // through the register path.
        if let Some(w) = self.divmod_operand_width(op, ty, lhs, rhs)
            && let Some(reduced) = b.divmod_const(op, lv, rv, w)
        {
            return Ok(reduced);
        }
        // The parser's `maybe_mask_to_unsigned_width`
        // already pushes the explicit narrow mask /
        // signed `Shl K; Shr K` pair as additional
        // `Expr::Binary` nodes through the dual-emit
        // binop tracker. Re-applying the narrowing here
        // would double-shift (or double-mask) the
        // result; walker just emits the raw `Binop` and
        // lets those wrapping Binary nodes do the rest.
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
        let load_kind = load_kind_for(ty, self.target);
        let store_kind = store_kind_for(ty, self.target);
        let place = self.rmw_place(b, lhs, ty)?;
        let vol = self.rmw_is_volatile(&place, ty, lhs);
        let old = place.load(b, load_kind, vol);
        // Constant-rhs short-circuit (mirror of the
        // `Expr::Binary` path): an integer-literal rhs
        // routes through `binop_imm` so the per-arch
        // immediate-form peepholes fire and the literal
        // doesn't get materialised into a scratch first.
        // FP / Div / Divu / Mod / Modu stay on the
        // register-rhs path because the per-arch BinopI
        // lowering bails on them.
        let imm_safe = matches!(
            op,
            BinOp::Add
                | BinOp::Sub
                | BinOp::Mul
                | BinOp::And
                | BinOp::Or
                | BinOp::Xor
                | BinOp::Shl
                | BinOp::Shr
                | BinOp::Shru
        );
        let new_val = if matches!(op, BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv)
            && !is_floating_scalar(ty)
        {
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
        } else if matches!(op, BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv) {
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

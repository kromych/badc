//! Conditional expressions and the controlling-expression values
//! the statements share (C99 6.5.15).

use super::super::access::{load_kind_for, store_kind_for};
use super::super::types::{expr_ty, is_comparison_op, is_floating_scalar};
use super::super::*;
impl<'a> Walker<'a> {
    /// Walk a `Expr::Unary` rvalue. AddrOf hands off to the
    /// lvalue walk; Deref loads from the rvalue-shaped address;
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
    /// True when `cond` is observed for truthiness as a floating value,
    /// i.e. the C99 controlling-expression comparison is `!= 0.0`. A
    /// comparison's result is `int`, so it is excluded even though its
    /// node may carry the operand type.
    fn cond_is_float(&self, cond: ExprId) -> bool {
        let e = self.ast.expr(cond);
        if let Expr::Binary { op, .. } = e
            && is_comparison_op(*op)
        {
            return false;
        }
        expr_ty(e).is_some_and(is_floating_scalar)
    }

    /// Value to test against zero for `cond`'s truthiness. A floating
    /// operand is reduced to `cond != 0.0` (0 or 1) so `-0.0` reads as
    /// false; an integer operand passes through and is tested directly.
    pub(super) fn cond_truthy(
        &mut self,
        b: &mut SsaBuilder,
        val: ValueId,
        cond: ExprId,
    ) -> ValueId {
        if self.cond_is_float(cond) {
            let d = b.fp_widen_to_f64(val);
            let zero = b.imm(0);
            return b.binop(BinOp::Fne, d, zero);
        }
        // A 128-bit operand is carried as its object's address; testing
        // that address would read every value as true. Test the value:
        // it is non-zero when either half is.
        if self.expr_is_int128_value(cond) {
            let (lo, hi) = self.int128_load(b, val);
            return b.binop(BinOp::Or, lo, hi);
        }
        val
    }

    /// Walk an expression used as a branch condition, returning a value
    /// to test against zero. A top-level `&&` / `||` is lowered without
    /// normalizing its result, since only its truthiness is observed;
    /// any other expression is walked normally.
    pub(in super::super) fn walk_cond_value(
        &mut self,
        b: &mut SsaBuilder,
        cond: ExprId,
    ) -> Result<ValueId, WalkError> {
        if matches!(self.ast.expr(cond), Expr::ShortCircuit { .. }) {
            return self.walk_short_circuit(b, cond, false);
        }
        // C99 6.8.4.1 / 6.8.5: a controlling expression is compared
        // against 0. A floating operand uses the FP comparison
        // `v != 0.0`; testing the register bits directly would read
        // `-0.0` (sign bit set) as true.
        let v = self.walk_expr_rvalue(b, cond)?;
        Ok(self.cond_truthy(b, v, cond))
    }

    /// C99 6.5.15 conditional operator, and the GNU `a ?: b` form.
    pub(super) fn walk_ternary(
        &mut self,
        b: &mut SsaBuilder,
        cond: ExprId,
        then_e: ExprId,
        else_e: ExprId,
        ty: i64,
        elvis: bool,
    ) -> Result<ValueId, WalkError> {
        // A constant controlling expression selects one arm at
        // translation time (C99 6.5.15); evaluate only that arm
        // so the dead arm's side effects and undefined-symbol
        // references are never emitted. Ternary arms are
        // expressions, so no label/goto concern applies. The
        // GNU `a ?: b` form keeps its runtime path. Matches
        // gcc's front-end fold at -O0.
        if !elvis && let Some(c) = self.const_fold_int(cond) {
            let live = if c != 0 { then_e } else { else_e };
            let v = self.walk_expr_rvalue(b, live)?;
            let arm_ty = expr_ty(self.ast.expr(live)).unwrap_or(ty);
            return Ok(self.convert_scalar_value(b, v, arm_ty, ty));
        }
        // C99 6.5.15: evaluate cond; depending on the
        // value, evaluate exactly one of then_e / else_e
        // and the conditional expression's value is that
        // arm's value. Same synthetic-local-slot phi
        // substitute the `ShortCircuit` arm uses -- both
        // arms store the arm result and the merge block
        // loads it. Width is taken from the result type:
        // an FP-typed ternary uses `StoreLocal { kind: F32 }` /
        // `LoadLocal { kind: F32 }` so the codegen routes
        // through the FP register class; everything else
        // stays on the I64 `StoreLocal` / `LoadLocal` fast
        // path the emit lowers in a single `stur` / `ldur`.
        //
        // The GNU `a ?: b` form evaluates the condition once and
        // reuses its value as the then-arm (converted to the result
        // type). The plain form evaluates the condition for its
        // truthiness only and evaluates a separate then-arm.
        let (cond_v, elvis_val) = if elvis {
            let v = self.walk_expr_rvalue(b, cond)?;
            (self.cond_truthy(b, v, cond), Some(v))
        } else {
            (self.walk_cond_value(b, cond)?, None)
        };
        let then_blk = b.new_block();
        let else_blk = b.new_block();
        let after_blk = b.new_block();
        b.branch_zero(cond_v, else_blk, then_blk);
        let slot = b.alloc_synthetic_local();
        let load_kind = load_kind_for(ty, self.target);
        let store_kind = store_kind_for(ty, self.target);
        // An FP-typed result rides the FP register class through
        // the fused `StoreLocal` / `LoadLocal` path: the emit
        // lowers `F32` (`movss` / `str s`, narrowing an f64 arm
        // per C99 6.3.1.5) and `F64` (`movsd` / `ldr d`) each in
        // a single instruction. The fused ops keep the synthetic
        // merge slot mem2reg-promotable, unlike `LocalAddr` +
        // `Store`. Everything else stays on the I64 fast path.
        let is_fp = matches!(load_kind, LoadKind::F32 | LoadKind::F64);
        let arm_store = |b: &mut SsaBuilder, v| {
            let kind = if is_fp { store_kind } else { StoreKind::I64 };
            b.store_local(slot, v, kind);
        };
        b.switch_to(then_blk);
        let then_v = if let Some(v) = elvis_val {
            // Reuse the condition's value, converted from its own
            // type to the conditional's result type.
            let cond_ty = expr_ty(self.ast.expr(cond)).unwrap_or(ty);
            self.convert_scalar_value(b, v, cond_ty, ty)
        } else {
            self.walk_expr_rvalue(b, then_e)?
        };
        arm_store(b, then_v);
        b.jmp(after_blk);
        b.switch_to(else_blk);
        let else_v = self.walk_expr_rvalue(b, else_e)?;
        arm_store(b, else_v);
        b.jmp(after_blk);
        b.switch_to(after_blk);
        let read_kind = if is_fp { load_kind } else { LoadKind::I64 };
        Ok(b.load_local(slot, read_kind))
    }
}

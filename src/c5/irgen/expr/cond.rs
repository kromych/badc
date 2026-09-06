//! Conditional expressions and the controlling-expression values
//! the statements share (C99 6.5.15).

use super::super::access::{load_kind_for, store_kind_for};
use super::super::types::is_floating_scalar;
use super::super::*;
use crate::c5::ast::expr_ty;
use crate::c5::ir::is_comparison_op;
impl<'a> Walker<'a> {
    /// True when `cond`'s truthiness is decided as a floating value,
    /// i.e. the C99 controlling-expression comparison is `!= 0.0`. A
    /// comparison is excluded: its result is `int` whatever type its
    /// node carries.
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
        // translation time (C99 6.5.15), so the dead arm's side effects
        // and undefined-symbol references are never emitted. The GNU
        // `a ?: b` form keeps its runtime path.
        if !elvis && let Some(c) = self.const_fold_int(cond) {
            let live = if c != 0 { then_e } else { else_e };
            let v = self.walk_expr_rvalue(b, live)?;
            let arm_ty = expr_ty(self.ast.expr(live)).unwrap_or(ty);
            return Ok(self.convert_scalar_value(b, v, arm_ty, ty));
        }
        // The GNU `a ?: b` form evaluates the condition once and reuses
        // its value as the then-arm, converted to the result type; the
        // plain form evaluates a separate then-arm.
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
        // C99 6.5.15: exactly one arm is evaluated, and a synthetic
        // local slot stands in for the phi. An FP-typed result carries
        // the store and load kinds so the value stays in the FP register
        // class; everything else uses I64.
        let is_fp = matches!(load_kind, LoadKind::F32 | LoadKind::F64);
        let arm_store = |b: &mut SsaBuilder, v| {
            let kind = if is_fp { store_kind } else { StoreKind::I64 };
            b.store_local(slot, v, kind);
        };
        b.switch_to(then_blk);
        let then_v = if let Some(v) = elvis_val {
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

//! Conditional expressions and the controlling-expression values
//! the statements share (C99 6.5.15).

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
}

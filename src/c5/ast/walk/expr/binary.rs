//! Binary, assignment and compound-assignment expressions
//! (C99 6.5.5 - 6.5.16).

use super::super::types::{expr_ty, type_size_bytes};
use super::super::*;

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
}

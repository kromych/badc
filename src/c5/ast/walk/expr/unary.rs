//! Unary operators and casts (C99 6.5.3, 6.5.4).

use super::super::access::{load_kind_for, load_place};
use super::super::types::{is_float_ty, is_floating_scalar};
use super::super::*;

impl<'a> Walker<'a> {
    /// Neg / BitNot / LogNot lower to a binop against an
    /// immediate.
    pub(super) fn walk_unary(
        &mut self,
        b: &mut SsaBuilder,
        op: UnOp,
        child: ExprId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        // GCC vector extension: `-v` / `~v` are element-wise.
        if matches!(op, UnOp::Neg | UnOp::BitNot) && is_vector_ty(self.structs, ty) {
            return self.walk_vector_unary(b, op, child, ty);
        }
        match op {
            UnOp::Neg => {
                let v = self.walk_expr_rvalue(b, child)?;
                if is_floating_scalar(ty) {
                    // C99 6.3.1.8 / 6.5.3.3: `-x` keeps the operand's
                    // type. A `float` negation is single precision; tag
                    // the result so the codegen emits `fneg s`.
                    let neg = b.fneg(v);
                    if is_float_ty(ty) {
                        return Ok(b.mark_f32(neg));
                    }
                    Ok(neg)
                } else {
                    let zero = b.imm(0);
                    Ok(b.binop(BinOp::Sub, zero, v))
                }
            }
            UnOp::BitNot => {
                let v = self.walk_expr_rvalue(b, child)?;
                Ok(b.binop_imm(BinOp::Xor, v, -1))
            }
            UnOp::LogNot => {
                let v = self.walk_expr_rvalue(b, child)?;
                Ok(b.binop_imm(BinOp::Eq, v, 0))
            }
            UnOp::AddrOf => self.walk_expr_lvalue(b, child),
            UnOp::Deref => {
                let addr = self.walk_expr_rvalue(b, child)?;
                // C99 6.5.3.2p4 + the c5 address-as-value rule:
                // dereferencing a pointer to a struct value
                // produces an rvalue whose representation is the
                // struct's address. Skip the trailing load --
                // the enclosing site (struct Assign / Mcpy /
                // Member chain) consumes the address.
                if is_struct_value_ty(ty) {
                    return Ok(addr);
                }
                let kind = load_kind_for(ty, self.target);
                let seg = self.access_seg(child, ty)?;
                Ok(load_place(b, addr, kind, seg, is_volatile_ty(ty), 0))
            }
        }
    }
}

//! Unary operators and casts (C99 6.5.3, 6.5.4).

use super::super::access::{load_kind_for, load_place};
use super::super::types::{is_float_ty, is_floating_scalar};
use super::super::*;
use crate::c5::ast::expr_ty;
impl<'a> Walker<'a> {
    /// Walk an `Expr::Unary` rvalue. AddrOf hands off to the lvalue
    /// walk and Deref loads through the address; Neg, BitNot and LogNot
    /// lower to a binop against an immediate.
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
                    // C99 6.5.3.3: `-x` keeps the operand's type, so a
                    // `float` negation stays single precision.
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
                // C99 6.5.3.2p4 with the address-as-value rule for
                // struct rvalues: the dereference yields the struct's
                // address, which the enclosing site consumes, so there
                // is no load.
                if is_struct_value_ty(ty) {
                    return Ok(addr);
                }
                let kind = load_kind_for(ty, self.target);
                let seg = self.access_seg(child, ty)?;
                Ok(load_place(b, addr, kind, seg, is_volatile_ty(ty), 0))
            }
        }
    }

    /// C99 6.5.4 cast operator.
    pub(super) fn walk_cast(
        &mut self,
        b: &mut SsaBuilder,
        child: ExprId,
        to_ty: i64,
    ) -> Result<ValueId, WalkError> {
        let v = self.walk_expr_rvalue(b, child)?;
        // An asm statement yields no value, and is never a cast
        // operand.
        let src_ty = expr_ty(self.ast.expr(child)).unwrap_or(Ty::Int as i64);
        // A 128-bit rvalue is carried as its address, so a cast to an
        // integer or pointer loads the low 8 bytes -- the value mod
        // 2^64 -- and the convert narrows that to `to_ty`. A floating
        // target converts the whole 128-bit value (C99 6.3.1.4).
        if self.is_int128_value_ty(src_ty) && !is_struct_ty(to_ty) {
            let v = self.flatten_copy_operand(b, child, v)?;
            if is_floating_scalar(to_ty) {
                let pair = self.int128_load(b, v);
                let signed = (src_ty & UNSIGNED_BIT) == 0;
                return Ok(self.int128_to_fp(b, pair, signed, is_float_ty(to_ty)));
            }
            let low_ty = Ty::LongLong as i64 | UNSIGNED_BIT;
            let low = b.load(v, load_kind_for(low_ty, self.target));
            return Ok(self.convert_scalar_value(b, low, low_ty, to_ty));
        }
        // The reverse: a scalar cast to a 128-bit type materialises a
        // 16-byte object, whose address is the value.
        if !is_struct_ty(src_ty) && self.is_int128_value_ty(to_ty) {
            let slot = b.alloc_synthetic_struct(16);
            let addr = b.local_addr(slot);
            self.store_scalar_as_int128(b, addr, v, src_ty, to_ty);
            return Ok(addr);
        }
        Ok(self.convert_scalar_value(b, v, src_ty, to_ty))
    }
}

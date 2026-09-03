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

    /// C99 6.5.4 cast operator.
    pub(super) fn walk_cast(
        &mut self,
        b: &mut SsaBuilder,
        child: ExprId,
        to_ty: i64,
    ) -> Result<ValueId, WalkError> {
        let v = self.walk_expr_rvalue(b, child)?;
        // C99 6.5.4: a cast performs a value-changing
        // conversion when the source/destination differ
        // in fp-ness. Same-class casts (int<->ptr,
        // float<->double) are bit-pattern-compatible and
        // need no op. Width-narrowing on integers is a
        // truncation the SSA emitter already handles
        // through the Store / Load kinds at the
        // surrounding sites.
        let src_ty = match self.ast.expr(child) {
            Expr::IntLit { ty, .. }
            | Expr::FloatLit { ty, .. }
            | Expr::Ident { ty, .. }
            | Expr::Unary { ty, .. }
            | Expr::Binary { ty, .. }
            | Expr::Ternary { ty, .. }
            | Expr::Call { ty, .. }
            | Expr::Member { ty, .. }
            | Expr::Index { ty, .. }
            | Expr::Assign { ty, .. }
            | Expr::BitfieldAssign { ty, .. }
            | Expr::CompoundAssign { ty, .. }
            | Expr::PreInc { ty, .. }
            | Expr::PostInc { ty, .. }
            | Expr::Comma { ty, .. }
            | Expr::ShortCircuit { ty, .. } => *ty,
            Expr::Cast { to_ty: t, .. } => *t,
            Expr::Sizeof(s) => s.result_ty,
            Expr::CompoundLiteral { ty, .. } => *ty,
            Expr::StrLit { ty, .. } => *ty,
            Expr::Intrinsic { ty, .. } => *ty,
            Expr::Atomic { ty, .. } => *ty,
            Expr::VlaBase { ty, .. } => *ty,
            Expr::VlaSizeof { .. } => Ty::Int as i64,
            Expr::StmtExpr { ty, .. } => *ty,
            Expr::CheckedArith { ty, .. } => *ty,
            Expr::X86Simd { ty, .. } => *ty,
            Expr::MemTransfer { ty, .. } => *ty,
            // `&&label` is a `void *` (char-pointer encoding).
            Expr::LabelAddr(_) => {
                crate::c5::token::Ty::Char as i64 + crate::c5::token::Ty::Ptr as i64
            }
            // An asm statement yields no value; it is never a
            // cast operand.
            Expr::InlineAsm(_) => Ty::Int as i64,
        };
        // A 128-bit `__int128` rvalue is carried as its address
        // (the struct-rvalue address-as-value rule). A cast to an
        // integer or pointer loads the object's low 8 bytes (its
        // value mod 2^64); the convert then narrows to `to_ty`.
        // Without the load the address is used as the value. A
        // floating target instead converts the whole 128-bit
        // value (C99 6.3.1.4) through `int128_to_fp`.
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
        // The reverse: a scalar cast to a 128-bit `__int128`
        // materialises a 16-byte object and yields its address per
        // the same address-as-value rule. Without this the scalar
        // value stands where an address is expected.
        if !is_struct_ty(src_ty) && self.is_int128_value_ty(to_ty) {
            let slot = b.alloc_synthetic_struct(16);
            let addr = b.local_addr(slot);
            self.store_scalar_as_int128(b, addr, v, src_ty, to_ty);
            return Ok(addr);
        }
        Ok(self.convert_scalar_value(b, v, src_ty, to_ty))
    }
}

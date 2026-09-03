//! GCC vector extension: element-wise operations and the x86 SIMD
//! builtins.

use super::access::{load_kind_for, store_kind_for};
use super::types::{expr_ty, is_float_ty, is_floating_scalar};
use super::*;

impl<'a> Walker<'a> {
    /// Element type and lane count of the GCC vector type `ty`.
    fn vector_lanes(&self, ty: i64) -> (i64, i64) {
        let f = &self.structs[struct_id_of(ty)].fields[0];
        (f.ty, f.array_size.max(1))
    }

    /// True when the node's own type is a GCC vector type; the broadcast
    /// scalar of a mixed operand pair is the one for which this is false.
    fn expr_is_vector(&self, id: ExprId) -> bool {
        expr_ty(self.ast.expr(id)).is_some_and(|t| is_vector_ty(self.structs, t))
    }

    /// Convert a broadcast scalar to the lane type (C99 6.3.1.4 / 6.3.1.5),
    /// once rather than per lane, so `/ % >>` see the converted value and
    /// not the operand's own width.
    fn vector_broadcast_operand(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
        elem_ty: i64,
    ) -> Result<ValueId, WalkError> {
        let v = self.walk_expr_rvalue(b, id)?;
        let src_ty = expr_ty(self.ast.expr(id)).unwrap_or(Ty::Int as i64);
        if is_floating_scalar(elem_ty) {
            let to_f32 = is_float_ty(elem_ty);
            let conv = if is_floating_scalar(src_ty) {
                v
            } else {
                let kind = if is_unsigned_ty(src_ty) {
                    FpCastKind::UIntToFp
                } else {
                    FpCastKind::IntToFp
                };
                if to_f32 {
                    b.fp_cast_to_f32(kind, v)
                } else {
                    b.fp_cast(kind, v)
                }
            };
            return Ok(if to_f32 {
                b.fp_narrow_to_f32(conv)
            } else {
                b.fp_widen_to_f64(conv)
            });
        }
        Ok(match load_kind_for(elem_ty, self.target) {
            LoadKind::U8 => b.binop_imm(BinOp::And, v, 0xff),
            LoadKind::U16 => b.binop_imm(BinOp::And, v, 0xffff),
            LoadKind::U32 => b.binop_imm(BinOp::And, v, 0xffff_ffff),
            k @ (LoadKind::I8 | LoadKind::I16 | LoadKind::I32) => b.extend(v, k),
            _ => v,
        })
    }

    /// GCC vector extension: element-wise `op` over two vectors, or over a
    /// vector and a scalar broadcast to every lane. The result is a fresh
    /// synthetic aggregate whose address is returned, matching how a struct
    /// rvalue is produced.
    ///
    /// One scalar operation per lane at the element width: the SSA value
    /// model has no vector class, so each lane emits the load / binop / store
    /// the equivalent scalar C expression emits for the element type.
    /// `^`/`&`/`|` on two vectors carry no value between lanes and take the
    /// wider chunk cover instead.
    pub(super) fn walk_vector_binop(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        let lhs_vec = self.expr_is_vector(lhs);
        let rhs_vec = self.expr_is_vector(rhs);
        if lhs_vec && rhs_vec && matches!(op, BinOp::And | BinOp::Or | BinOp::Xor) {
            return self.walk_vector_chunked(b, op, lhs, rhs, ty);
        }
        let (elem_ty, lanes) = self.vector_lanes(ty);
        let size = self.struct_size(ty);
        let elem_size = size / lanes;
        // A comparison loads at the operand element type (float or
        // unsigned included) and stores 0 / -1 at the result's signed
        // element; the parser fixed the opcode flavour from the operands.
        let is_cmp = is_vector_compare_op(op);
        let src_elem_ty = if is_cmp {
            let vec = if lhs_vec { lhs } else { rhs };
            let vty = expr_ty(self.ast.expr(vec)).unwrap_or(ty);
            self.vector_lanes(vty).0
        } else {
            elem_ty
        };
        let lane_op = if is_cmp {
            op
        } else {
            vector_lane_binop(op, elem_ty)
        };
        let lk = load_kind_for(src_elem_ty, self.target);
        let sk = store_kind_for(elem_ty, self.target);
        let lv = if lhs_vec {
            self.walk_copy_operand(b, lhs)?
        } else {
            self.vector_broadcast_operand(b, lhs, src_elem_ty)?
        };
        let rv = if rhs_vec {
            self.walk_copy_operand(b, rhs)?
        } else {
            self.vector_broadcast_operand(b, rhs, src_elem_ty)?
        };
        let slot = b.alloc_synthetic_struct(size);
        let dst = b.local_addr(slot);
        for i in 0..lanes {
            let off = i * elem_size;
            let a = if lhs_vec {
                let addr = lane_addr(b, lv, off);
                b.load(addr, lk)
            } else {
                lv
            };
            let c = if rhs_vec {
                let addr = lane_addr(b, rv, off);
                b.load(addr, lk)
            } else {
                rv
            };
            let mut r = b.binop(lane_op, a, c);
            if is_cmp {
                // The scalar compare yields 0 / 1; the lane holds 0 / -1.
                let z = b.imm(0);
                r = b.binop(BinOp::Sub, z, r);
            } else if b.is_f32(a) && b.is_f32(c) {
                r = b.mark_f32(r);
            }
            let da = lane_addr(b, dst, off);
            b.store(da, r, sk);
        }
        Ok(dst)
    }

    /// GCC vector extension: element-wise unary `-` / `~` over a vector,
    /// lowered per lane like [`Self::walk_vector_binop`].
    pub(super) fn walk_vector_unary(
        &mut self,
        b: &mut SsaBuilder,
        op: UnOp,
        child: ExprId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        let (elem_ty, lanes) = self.vector_lanes(ty);
        let size = self.struct_size(ty);
        let elem_size = size / lanes;
        let lk = load_kind_for(elem_ty, self.target);
        let sk = store_kind_for(elem_ty, self.target);
        let src = self.walk_copy_operand(b, child)?;
        let slot = b.alloc_synthetic_struct(size);
        let dst = b.local_addr(slot);
        for i in 0..lanes {
            let off = i * elem_size;
            let sa = lane_addr(b, src, off);
            let v = b.load(sa, lk);
            let r = if matches!(op, UnOp::BitNot) {
                b.binop_imm(BinOp::Xor, v, -1)
            } else if is_floating_scalar(elem_ty) {
                // A sign-bit flip, not `0 - x`: the latter turns -0.0 into 0.0.
                let n = b.fneg(v);
                if b.is_f32(v) { b.mark_f32(n) } else { n }
            } else {
                let zero = b.imm(0);
                b.binop(BinOp::Sub, zero, v)
            };
            let da = lane_addr(b, dst, off);
            b.store(da, r, sk);
        }
        Ok(dst)
    }

    /// Lower an x86 SIMD builtin to its instruction. A 128-bit operand is
    /// passed by address; the result lands in a synthetic slot whose
    /// address the expression yields, which is the protocol every other
    /// vector-valued expression uses.
    pub(super) fn walk_x86_simd(
        &mut self,
        b: &mut SsaBuilder,
        op: u32,
        args: &[ExprId],
        imm: Option<u8>,
    ) -> Result<ValueId, WalkError> {
        use crate::c5::x86_simd::{self, Form};
        let form = x86_simd::get(op).form;
        let mut ops: alloc::vec::Vec<ValueId> = alloc::vec::Vec::with_capacity(args.len() + 1);
        for &a in args {
            let v = if self.expr_is_vector(a) {
                self.walk_copy_operand(b, a)?
            } else {
                self.walk_expr_rvalue(b, a)?
            };
            ops.push(v);
        }
        if form == Form::Store {
            b.x86_simd(op, imm, ops);
            return Ok(b.imm(0));
        }
        let result_bytes = if form.returns_vector() { 16 } else { 8 };
        let slot = b.alloc_synthetic_struct(result_bytes);
        let dst = b.local_addr(slot);
        ops.insert(0, dst);
        b.x86_simd(op, imm, ops);
        if form.returns_vector() {
            Ok(dst)
        } else {
            Ok(b.load(dst, LoadKind::I32))
        }
    }

    /// Lower a bitwise operator (`^`/`&`/`|`) on two same-width GCC vector
    /// values into a result temporary. Bitwise ops carry no value between
    /// lanes, so the byte block is combined in the widest chunks that fit
    /// (8/4/2/1) regardless of the element width. Both operands are aggregate
    /// rvalues (their address lands on the accumulator); the result is a fresh
    /// synthetic aggregate whose address is returned, matching how a struct
    /// rvalue is produced.
    fn walk_vector_chunked(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        let lhs_addr = self.walk_copy_operand(b, lhs)?;
        let rhs_addr = self.walk_copy_operand(b, rhs)?;
        let size = self.struct_size(ty);
        let slot = b.alloc_synthetic_struct(size);
        let dst = b.local_addr(slot);
        // Widest-chunk cover: (width, load kind, store kind).
        const CHUNKS: [(i64, LoadKind, StoreKind); 4] = [
            (8, LoadKind::I64, StoreKind::I64),
            (4, LoadKind::U32, StoreKind::I32),
            (2, LoadKind::U16, StoreKind::I16),
            (1, LoadKind::U8, StoreKind::I8),
        ];
        let mut off = 0;
        while off < size {
            let remaining = size - off;
            let (w, lk, sk) = CHUNKS
                .iter()
                .find(|(w, ..)| *w <= remaining)
                .copied()
                .unwrap();
            let la = if off == 0 {
                lhs_addr
            } else {
                b.binop_imm(BinOp::Add, lhs_addr, off)
            };
            let ra = if off == 0 {
                rhs_addr
            } else {
                b.binop_imm(BinOp::Add, rhs_addr, off)
            };
            let da = if off == 0 {
                dst
            } else {
                b.binop_imm(BinOp::Add, dst, off)
            };
            let a = b.load(la, lk);
            let c = b.load(ra, lk);
            let r = b.binop(op, a, c);
            b.store(da, r, sk);
            off += w;
        }
        Ok(dst)
    }
}

/// Address of lane byte `off` within the vector object at `base`.
fn lane_addr(b: &mut SsaBuilder, base: ValueId, off: i64) -> ValueId {
    if off == 0 {
        base
    } else {
        b.binop_imm(BinOp::Add, base, off)
    }
}

/// Concrete lane opcode for a GCC vector operator. The parser tags the node
/// with the nominal opcode; the element type picks the floating flavour and
/// the signedness of divide / modulo / right shift.
fn vector_lane_binop(op: BinOp, elem_ty: i64) -> BinOp {
    use BinOp as B;
    if is_floating_scalar(elem_ty) {
        return match op {
            B::Add | B::Fadd => B::Fadd,
            B::Sub | B::Fsub => B::Fsub,
            B::Mul | B::Fmul => B::Fmul,
            B::Div | B::Divu | B::Fdiv => B::Fdiv,
            other => other,
        };
    }
    if elem_ty & UNSIGNED_BIT != 0 {
        match op {
            B::Div => B::Divu,
            B::Mod => B::Modu,
            B::Shr => B::Shru,
            other => other,
        }
    } else {
        match op {
            B::Divu => B::Div,
            B::Modu => B::Mod,
            B::Shru => B::Shr,
            other => other,
        }
    }
}

/// The comparison opcodes the GCC vector extension lowers element-wise.
fn is_vector_compare_op(op: BinOp) -> bool {
    use BinOp as B;
    matches!(
        op,
        B::Eq
            | B::Ne
            | B::Lt
            | B::Gt
            | B::Le
            | B::Ge
            | B::Ult
            | B::Ugt
            | B::Ule
            | B::Uge
            | B::Feq
            | B::Fne
            | B::Flt
            | B::Fgt
            | B::Fle
            | B::Fge
    )
}

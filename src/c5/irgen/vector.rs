//! GNU C vector extension: element-wise operations and the x86 SIMD
//! builtins.

use super::access::{load_kind_for, store_kind_for};
use super::types::{is_float_ty, is_floating_scalar};
use super::*;
use crate::c5::ast::expr_ty;

impl<'a> Walker<'a> {
    /// Element type and lane count of the vector type `ty`.
    fn vector_lanes(&self, ty: i64) -> (i64, i64) {
        let f = &self.structs[struct_id_of(ty)].fields[0];
        (f.ty, f.array_size.max(1))
    }

    /// True when the node's own type is a vector type; the broadcast
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

    /// The lane of an 8- to 64-byte vector operation the target does in one
    /// instruction on whole vectors (`Inst::VecBinop`), and the width of the
    /// parts ([`widest_part`]) it takes: two vector operands, no comparison,
    /// an element of 1, 2, 4 or 8 bytes or a `float` or `double`.
    fn whole_vector_lane(
        &self,
        op: BinOp,
        lane_op: BinOp,
        elem_ty: i64,
        size: i64,
        both_vectors: bool,
    ) -> Option<(crate::c5::ir::VecLane, i64)> {
        use crate::c5::ir::VecLane;
        if !matches!(size, 8 | 16 | 32 | 64)
            || !both_vectors
            || is_vector_compare_op(op)
            || self.no_fp_regs
        {
            return None;
        }
        let lane = if is_floating_scalar(elem_ty) {
            match load_kind_for(elem_ty, self.target) {
                LoadKind::F32 => VecLane::F32,
                LoadKind::F64 => VecLane::F64,
                _ => return None,
            }
        } else {
            match load_kind_for(elem_ty, self.target) {
                LoadKind::I8 | LoadKind::U8 => VecLane::I8,
                LoadKind::I16 | LoadKind::U16 => VecLane::I16,
                LoadKind::I32 | LoadKind::U32 => VecLane::I32,
                LoadKind::I64 => VecLane::I64,
                _ => return None,
            }
        };
        let x86 = self.target.is_x86_64().then_some(self.x86);
        widest_part(size, |n| {
            lane.binop_in_one_instruction(lane_op, x86, n as u8)
                .then_some(lane)
        })
    }

    /// `lane_op` over the vectors at `lhs` and `rhs`, `width` bytes at a
    /// time, into a fresh `size`-byte slot whose address it yields; an
    /// operand paired with `false` is one part read for every part.
    fn vec_binop_parts(
        &mut self,
        b: &mut SsaBuilder,
        (lane_op, lane, width): (BinOp, crate::c5::ir::VecLane, i64),
        ops: [(ValueId, bool); 2],
        size: i64,
        align: i64,
    ) -> ValueId {
        let lk = vector_access(width).0;
        let parts = (0..size)
            .step_by(width as usize)
            .map(|off| {
                let [a, c] = ops.map(|(v, whole)| {
                    let at = if whole { lane_addr(b, v, off) } else { v };
                    b.load(at, lk)
                });
                b.vec_binop((lane_op, lane, width as u8), a, c)
            })
            .collect();
        store_parts(b, parts, width, align)
    }

    /// Element-wise `op` over two vectors, or over a vector and a scalar
    /// broadcast to every lane. The result is a fresh synthetic aggregate
    /// whose address is returned, matching how a struct rvalue is produced.
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
        {
            let (elem_ty, _) = self.vector_lanes(ty);
            let size = self.struct_size(ty);
            // A product the scalar code may contract into a fused multiply-add
            // is an ordinary one on whole vectors.
            let lane_op = match vector_lane_binop(op, elem_ty) {
                BinOp::FmulContractible => BinOp::Fmul,
                o => o,
            };
            if let Some((lane, width)) =
                self.whole_vector_lane(op, lane_op, elem_ty, size, lhs_vec && rhs_vec)
            {
                let lv = self.walk_copy_operand(b, lhs)?;
                let rv = self.walk_copy_operand(b, rhs)?;
                let align = self.vector_temp_align(ty);
                let ops = [(lv, true), (rv, true)];
                return Ok(self.vec_binop_parts(b, (lane_op, lane, width), ops, size, align));
            }
        }
        if let Some(r) = self.walk_vector_row(b, op, lhs, rhs, ty)? {
            return Ok(r);
        }
        if lhs_vec && rhs_vec && matches!(op, BinOp::And | BinOp::Or | BinOp::Xor) {
            return self.walk_vector_chunked(b, op, lhs, rhs, ty);
        }
        let (elem_ty, lanes) = self.vector_lanes(ty);
        let size = self.struct_size(ty);
        let elem_size = size / lanes;
        // A comparison loads at the operand element type (float or
        // unsigned included) and stores 0 / -1 at the result's signed
        // element; the parser fixed the opcode flavor from the operands.
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
        let slot = b.alloc_synthetic_struct(size, self.vector_temp_align(ty));
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

    /// `op` over an integer vector as the SIMD row of the target that
    /// computes it ([`crate::c5::simd::find`]), once per part of the width
    /// the row takes ([`widest_part`]): a comparison of two vectors,
    /// `<` and `<=` and their unsigned forms as the swapped `>` and `>=`,
    /// or a shift by a constant count less than the lane width. `None`
    /// leaves `op` to the lane-wise lowering.
    fn walk_vector_row(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    ) -> Result<Option<ValueId>, WalkError> {
        use crate::c5::simd::{Form, Sem};
        use BinOp as B;
        let size = self.struct_size(ty);
        if !matches!(size, 8 | 16 | 32 | 64) || self.no_fp_regs || !self.expr_is_vector(lhs) {
            return Ok(None);
        }
        let operand_ty = expr_ty(self.ast.expr(lhs)).unwrap_or(ty);
        let (elem_ty, _) = self.vector_lanes(operand_ty);
        if is_floating_scalar(elem_ty) {
            return Ok(None);
        }
        let Some(w) = load_kind_for(elem_ty, self.target).int_bytes() else {
            return Ok(None);
        };
        let pair = self.expr_is_vector(rhs);
        let count = match self.ast.expr(rhs) {
            Expr::IntLit { val, .. } if (1..i64::from(8 * w)).contains(val) => Some(*val as u8),
            _ => None,
        };
        let (sem, form, swap) = match (vector_lane_binop(op, elem_ty), pair, count) {
            (B::Eq, true, _) => (Sem::CmpEq(w), Form::Vv, false),
            (B::Gt, true, _) => (Sem::CmpGt(w), Form::Vv, false),
            (B::Lt, true, _) => (Sem::CmpGt(w), Form::Vv, true),
            (B::Ge, true, _) => (Sem::CmpGe(w), Form::Vv, false),
            (B::Le, true, _) => (Sem::CmpGe(w), Form::Vv, true),
            (B::Ugt, true, _) => (Sem::CmpHi(w), Form::Vv, false),
            (B::Ult, true, _) => (Sem::CmpHi(w), Form::Vv, true),
            (B::Uge, true, _) => (Sem::CmpHs(w), Form::Vv, false),
            (B::Ule, true, _) => (Sem::CmpHs(w), Form::Vv, true),
            (B::Shl, false, Some(_)) => (Sem::Shl(w), Form::Shift, false),
            (B::Shr, false, Some(_)) => (Sem::Sar(w), Form::Shift, false),
            (B::Shru, false, Some(_)) => (Sem::Shr(w), Form::Shift, false),
            _ => return Ok(None),
        };
        let find = |n: i64| crate::c5::simd::find(self.target, self.x86, sem, form, n as u8);
        let Some((row, width)) = widest_part(size, find) else {
            return Ok(None);
        };
        let mut ops = alloc::vec![self.walk_copy_operand(b, lhs)?];
        if pair {
            ops.push(self.walk_copy_operand(b, rhs)?);
        }
        if swap {
            ops.reverse();
        }
        let imm = if form == Form::Shift { count } else { None };
        Ok(Some(self.emit_simd_parts(b, row, imm, ops, size, width)))
    }

    /// Element-wise unary `-` / `~` over a vector: the target's SIMD row
    /// for it where it has one, else lowered per lane like
    /// [`Self::walk_vector_binop`].
    pub(super) fn walk_vector_unary(
        &mut self,
        b: &mut SsaBuilder,
        op: UnOp,
        child: ExprId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        let (elem_ty, lanes) = self.vector_lanes(ty);
        let size = self.struct_size(ty);
        if matches!(size, 8 | 16 | 32 | 64) && !self.no_fp_regs && !is_floating_scalar(elem_ty) {
            use crate::c5::simd::{Form, Sem};
            let sem = match (op, load_kind_for(elem_ty, self.target).int_bytes()) {
                (UnOp::BitNot, _) => Some(Sem::Not),
                (UnOp::Neg, Some(w)) => Some(Sem::Neg(w)),
                _ => None,
            };
            let row = sem.and_then(|s| {
                widest_part(size, |n| {
                    crate::c5::simd::find(self.target, self.x86, s, Form::V, n as u8)
                })
            });
            if let Some((row, width)) = row {
                let src = self.walk_copy_operand(b, child)?;
                let ops = alloc::vec![src];
                return Ok(self.emit_simd_parts(b, row, None, ops, size, width));
            }
            // Without one instruction for it, `-v` is `0 - v` and `~v` is
            // `v ^ ~0` on the whole vector.
            let (lane_op, fill) = match op {
                UnOp::Neg => (BinOp::Sub, 0),
                _ => (BinOp::Xor, -1),
            };
            if let Some((lane, width)) =
                self.whole_vector_lane(lane_op, lane_op, elem_ty, size, true)
            {
                let src = self.walk_copy_operand(b, child)?;
                let align = self.vector_temp_align(ty);
                let fill_slot = b.alloc_synthetic_struct(width, align);
                let fill_addr = b.local_addr(fill_slot);
                if fill == 0 {
                    b.mzero(fill_addr, width, align as u32);
                } else {
                    for off in (0..width).step_by(8) {
                        let at = lane_addr(b, fill_addr, off);
                        let word = b.imm(fill);
                        b.store(at, word, StoreKind::I64);
                    }
                }
                let (k, v) = ((fill_addr, false), (src, true));
                let ops = if fill == 0 { [k, v] } else { [v, k] };
                return Ok(self.vec_binop_parts(b, (lane_op, lane, width), ops, size, align));
            }
        }
        let size = self.struct_size(ty);
        let elem_size = size / lanes;
        let lk = load_kind_for(elem_ty, self.target);
        let sk = store_kind_for(elem_ty, self.target);
        let src = self.walk_copy_operand(b, child)?;
        let slot = b.alloc_synthetic_struct(size, self.vector_temp_align(ty));
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

    /// The alignment a vector temporary of `ty` is placed at: its type's,
    /// up to the 16 bytes of the widest access badc makes to one, which
    /// `-mstrict-align` bounds by the type's alignment.
    fn vector_temp_align(&self, ty: i64) -> i64 {
        i64::from(self.struct_align(ty).min(16))
    }

    /// Lower a SIMD builtin to its instruction. A 128-bit operand is
    /// passed by address; the result lands in a synthetic slot whose
    /// address the expression yields, which is the protocol every other
    /// vector-valued expression uses.
    pub(super) fn walk_simd(
        &mut self,
        b: &mut SsaBuilder,
        op: u32,
        args: &[ExprId],
        imm: Option<u8>,
    ) -> Result<ValueId, WalkError> {
        use crate::c5::simd;
        use crate::c5::simd::{Form, Ret};
        let row = simd::get(op);
        let form = row.form;
        let mut ops: alloc::vec::Vec<ValueId> = alloc::vec::Vec::with_capacity(args.len() + 1);
        for &a in args {
            let v = if self.expr_is_vector(a) {
                self.walk_copy_operand(b, a)?
            } else {
                self.walk_expr_rvalue(b, a)?
            };
            ops.push(v);
        }
        if matches!(form, Form::Store | Form::MaskStore) {
            b.simd(op, imm, ops);
            return Ok(b.imm(0));
        }
        let dst = self.emit_simd_row(b, op, imm, ops);
        if form.returns_vector() {
            Ok(dst)
        } else if simd::get(op).ret == Ret::Int64 {
            Ok(b.load(dst, LoadKind::I64))
        } else {
            Ok(b.load(dst, LoadKind::I32))
        }
    }

    /// The row `op` over the operands `ops` (a vector's address, an
    /// integer's value), its result in a fresh synthetic slot whose address
    /// it yields: a vector result's bytes, or 8 for an integer one.
    fn emit_simd_row(
        &mut self,
        b: &mut SsaBuilder,
        op: u32,
        imm: Option<u8>,
        mut ops: alloc::vec::Vec<ValueId>,
    ) -> ValueId {
        let row = crate::c5::simd::get(op);
        let result_bytes = if row.form.returns_vector() {
            i64::from(row.ret_bytes())
        } else {
            8
        };
        let slot = b.alloc_synthetic_struct(result_bytes, result_bytes);
        let dst = b.local_addr(slot);
        ops.insert(0, dst);
        b.simd(op, imm, ops);
        dst
    }

    /// [`Self::emit_simd_row`] over each `width`-byte part of the
    /// `size`-byte vectors at `ops`, into the same part of the result.
    fn emit_simd_parts(
        &mut self,
        b: &mut SsaBuilder,
        op: u32,
        imm: Option<u8>,
        ops: alloc::vec::Vec<ValueId>,
        size: i64,
        width: i64,
    ) -> ValueId {
        if width == size {
            return self.emit_simd_row(b, op, imm, ops);
        }
        // Each part in a slot of its own, read once all are computed, so
        // the stores of the result follow every read of the operands.
        let slots: alloc::vec::Vec<ValueId> = (0..size)
            .step_by(width as usize)
            .map(|off| {
                let args = ops.iter().map(|&a| lane_addr(b, a, off)).collect();
                self.emit_simd_row(b, op, imm, args)
            })
            .collect();
        let parts = slots
            .into_iter()
            .map(|p| b.load(p, vector_access(width).0))
            .collect();
        store_parts(b, parts, width, width)
    }

    /// Lower a bitwise operator (`^` / `&` / `|`) on two same-width
    /// vector values into a result temporary. Bitwise ops carry nothing
    /// between lanes, so the byte block combines in the widest chunks
    /// that fit whatever the element width. The result is a fresh
    /// synthetic aggregate whose address is returned, as a struct rvalue
    /// is produced.
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
        let slot = b.alloc_synthetic_struct(size, self.vector_temp_align(ty));
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

/// What `f` gives for the widest part of a `size`-byte vector it takes,
/// and that part's width: the whole vector, else 32 or 16 bytes, which
/// the operation then takes one part at a time.
fn widest_part<T>(size: i64, f: impl Fn(i64) -> Option<T>) -> Option<(T, i64)> {
    core::iter::once(size)
        .chain([32, 16].into_iter().filter(|&n| n < size))
        .find_map(|n| f(n).map(|t| (t, n)))
}

/// The load and store kinds of a whole vector of `bytes` bytes.
fn vector_access(bytes: i64) -> (LoadKind, StoreKind) {
    match bytes {
        64 => (LoadKind::V512, StoreKind::V512),
        32 => (LoadKind::V256, StoreKind::V256),
        16 => (LoadKind::V128, StoreKind::V128),
        _ => (LoadKind::F64, StoreKind::F64),
    }
}

/// A fresh slot holding the `width`-byte vectors `parts` in order; its
/// address.
fn store_parts(
    b: &mut SsaBuilder,
    parts: alloc::vec::Vec<ValueId>,
    width: i64,
    align: i64,
) -> ValueId {
    let slot = b.alloc_synthetic_struct(width * parts.len() as i64, align);
    let dst = b.local_addr(slot);
    for (k, r) in parts.into_iter().enumerate() {
        let at = lane_addr(b, dst, k as i64 * width);
        b.store(at, r, vector_access(width).1);
    }
    dst
}

/// Address of lane byte `off` within the vector object at `base`.
fn lane_addr(b: &mut SsaBuilder, base: ValueId, off: i64) -> ValueId {
    if off == 0 {
        base
    } else {
        b.binop_imm(BinOp::Add, base, off)
    }
}

/// Concrete lane opcode for a vector operator. The parser tags the node
/// with the nominal opcode; the element type picks the floating flavor and
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

/// The comparison opcodes the vector extension lowers element-wise.
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

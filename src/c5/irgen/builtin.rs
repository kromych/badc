//! GCC builtins that are not intrinsic instructions: the checked
//! arithmetic, the constant-size memory transfers, and the portable
//! bit-count lowerings.

use super::access::{load_kind_for_width, store_kind_for, store_kind_for_width, store_place};
use super::types::type_size_bytes;
use super::*;
use crate::c5::ast::expr_ty;

impl<'a> Walker<'a> {
    /// Expand a GCC `__builtin_memcpy` / `__builtin_memmove` /
    /// `__builtin_memset` whose byte count is a constant. The copy rides
    /// `Inst::Mcpy`, which transfers forward in units and so carries the
    /// non-overlap requirement of C99 7.21.2.1. The move loads every unit
    /// before storing any, which is defined for overlapping objects
    /// (7.21.2.2). The fill splats its byte across a register and stores
    /// it. The value is the destination address.
    pub(super) fn walk_mem_transfer(
        &mut self,
        b: &mut SsaBuilder,
        op: MemTransferOp,
        dst_expr: ExprId,
        src_expr: ExprId,
        size: i64,
        align: u32,
    ) -> Result<ValueId, WalkError> {
        let dst = self.walk_expr_rvalue(b, dst_expr)?;
        let src = self.walk_expr_rvalue(b, src_expr)?;
        if op == MemTransferOp::Copy {
            b.mcpy(dst, src, size, align);
            return Ok(dst);
        }
        let chunks: alloc::vec::Vec<(i64, LoadKind, StoreKind)> = mem_transfer_chunks(size, align)
            .into_iter()
            .map(|(off, w)| (off, load_kind_for_width(w), store_kind_for_width(w)))
            .collect();
        if op == MemTransferOp::Fill {
            // C99 7.21.6.1p2 converts the fill value to `unsigned char`;
            // the splat repeats that byte across the store width.
            let byte = b.binop_imm(BinOp::And, src, 0xff);
            let mut splat = [(1u32, byte); 4].map(|(w, v)| (w, v));
            for i in 1..4 {
                let (w, prev) = splat[i - 1];
                let shifted = b.binop_imm(BinOp::Shl, prev, i64::from(w) * 8);
                splat[i] = (w * 2, b.binop(BinOp::Or, prev, shifted));
            }
            for (off, _, sk) in chunks {
                let v = match sk {
                    StoreKind::I64 => splat[3].1,
                    StoreKind::I32 => splat[2].1,
                    StoreKind::I16 => splat[1].1,
                    _ => byte,
                };
                let p = b.binop_imm(BinOp::Add, dst, off);
                b.store(p, v, sk);
            }
            return Ok(dst);
        }
        let loaded: alloc::vec::Vec<(i64, StoreKind, ValueId)> = chunks
            .into_iter()
            .map(|(off, lk, sk)| {
                let p = b.binop_imm(BinOp::Add, src, off);
                (off, sk, b.load(p, lk))
            })
            .collect();
        for (off, sk, v) in loaded {
            let p = b.binop_imm(BinOp::Add, dst, off);
            b.store(p, v, sk);
        }
        Ok(dst)
    }

    /// Lower a GCC `__builtin_{add,sub,mul}_overflow(a, b, dst)`: store
    /// the wrapped `a op b` through `dst` and yield the overflow flag.
    /// Under 8 bytes the operands are already extended in the register,
    /// so `a op b` is exact and overflow is exactly where truncation
    /// changes it; at 8 bytes the carry and sign-overflow formulas
    /// decide, with a guarded division for the multiply.
    pub(super) fn walk_checked_arith(
        &mut self,
        b: &mut SsaBuilder,
        op: i64,
        a_expr: ExprId,
        b_expr: ExprId,
        dst_expr: ExprId,
        elem_ty: i64,
    ) -> Result<ValueId, WalkError> {
        let store_kind = store_kind_for(elem_ty, self.target);
        let w = type_size_bytes(elem_ty, self.target);
        if self.is_int128_value_ty(elem_ty)
            || self.expr_is_int128_value(a_expr)
            || self.expr_is_int128_value(b_expr)
        {
            return self.walk_checked_arith_128(b, op, a_expr, b_expr, dst_expr, elem_ty);
        }
        // The wrapped-value and overflow-flag formulas below operate on a
        // 1/2/4/8-byte scalar in a 64-bit register; a wider or aggregate
        // operand has no such form and would yield a wrong flag / value.
        if !matches!(w, 1 | 2 | 4 | 8) {
            return Err(WalkError::UnsupportedExpr {
                id: dst_expr,
                kind: "__builtin_*_overflow requires a 1/2/4/8-byte scalar type",
            });
        }
        let unsigned = (elem_ty & UNSIGNED_BIT) != 0;
        let bin = match op {
            0 => BinOp::Add,
            1 => BinOp::Sub,
            _ => BinOp::Mul,
        };
        let seg = self.access_seg(dst_expr, elem_ty)?;
        let va = self.walk_expr_rvalue(b, a_expr)?;
        let vb = self.walk_expr_rvalue(b, b_expr)?;
        let addr = self.walk_expr_rvalue(b, dst_expr)?;

        if w < 8 {
            let raw = b.binop(bin, va, vb);
            let wrapped = self.extend_atomic_result(b, raw, elem_ty);
            store_place(b, addr, wrapped, store_kind, seg, false, 0);
            return Ok(b.binop(BinOp::Ne, raw, wrapped));
        }

        let wrapped = b.binop(bin, va, vb);
        store_place(b, addr, wrapped, store_kind, seg, false, 0);
        let flag = match (op, unsigned) {
            // Unsigned add carries out iff the sum is below an addend.
            (0, true) => b.binop(BinOp::Ult, wrapped, va),
            // Signed add overflows iff both addends share a sign that the
            // sum does not: `(a ^ s) & (b ^ s)` has its sign bit set.
            (0, false) => {
                let ax = b.binop(BinOp::Xor, va, wrapped);
                let bx = b.binop(BinOp::Xor, vb, wrapped);
                let m = b.binop(BinOp::And, ax, bx);
                let zero = b.imm(0);
                b.binop(BinOp::Lt, m, zero)
            }
            // Unsigned subtract borrows iff the minuend is the smaller.
            (1, true) => b.binop(BinOp::Ult, va, vb),
            // Signed subtract overflows iff the operands differ in sign
            // and the result's sign differs from the minuend's.
            (1, false) => {
                let ab = b.binop(BinOp::Xor, va, vb);
                let aw = b.binop(BinOp::Xor, va, wrapped);
                let m = b.binop(BinOp::And, ab, aw);
                let zero = b.imm(0);
                b.binop(BinOp::Lt, m, zero)
            }
            // Unsigned multiply overflows iff `a != 0 && product/a != b`.
            // The divisor is forced non-zero so the unused `a == 0` lane
            // does not divide by zero.
            (_, true) => {
                let zero = b.imm(0);
                let iszero = b.binop(BinOp::Eq, va, zero);
                let safe = b.binop(BinOp::Or, va, iszero);
                let q = b.binop(BinOp::Divu, wrapped, safe);
                let a_nz = b.binop(BinOp::Ne, va, zero);
                let mism = b.binop(BinOp::Ne, q, vb);
                b.binop(BinOp::And, a_nz, mism)
            }
            // Signed multiply: same division test, but the divisor is
            // forced to 1 for `a == 0` and `a == -1` so the `INT_MIN / -1`
            // trap is avoided; the `a == -1` overflow is `product == INT_MIN`.
            (_, false) => {
                let zero = b.imm(0);
                let neg1 = b.imm(-1);
                let one = b.imm(1);
                let iszero = b.binop(BinOp::Eq, va, zero);
                let isneg1 = b.binop(BinOp::Eq, va, neg1);
                let special = b.binop(BinOp::Or, iszero, isneg1);
                let not_special = b.binop(BinOp::Xor, special, one);
                let scaled = b.binop(BinOp::Mul, va, not_special);
                let safe = b.binop(BinOp::Add, scaled, special);
                let q = b.binop(BinOp::Div, wrapped, safe);
                let mism = b.binop(BinOp::Ne, q, vb);
                let normal = b.binop(BinOp::And, not_special, mism);
                let intmin = b.imm(i64::MIN);
                let is_intmin = b.binop(BinOp::Eq, wrapped, intmin);
                let neg1_ovf = b.binop(BinOp::And, isneg1, is_intmin);
                b.binop(BinOp::Or, normal, neg1_ovf)
            }
        };
        Ok(flag)
    }

    /// 128-bit multiply, returning the product mod 2^128 and whether the
    /// exact product needs more than 128 bits. The exact product is
    /// `a0*c0 + (a1*c0 + a0*c1) << 64 + a1*c1 << 128`, so it exceeds 128
    /// bits iff both high halves are non-zero, a cross product exceeds 64
    /// bits, or its sum with the low product's high half carries out.
    fn int128_mul_ovf_u(b: &mut SsaBuilder, a: Halves, c: Halves) -> (Halves, ValueId) {
        let lo = b.binop(BinOp::Mul, a.0, c.0);
        let base = Self::int128_mulhi_u(b, a.0, c.0);
        let cross0 = b.binop(BinOp::Mul, a.0, c.1);
        let cross1 = b.binop(BinOp::Mul, a.1, c.0);
        let mid = b.binop(BinOp::Add, base, cross0);
        let carry0 = b.binop(BinOp::Ult, mid, base);
        let hi = b.binop(BinOp::Add, mid, cross1);
        let carry1 = b.binop(BinOp::Ult, hi, mid);
        let zero = b.imm(0);
        let a_hi_nz = b.binop(BinOp::Ne, a.1, zero);
        let c_hi_nz = b.binop(BinOp::Ne, c.1, zero);
        let both_hi = b.binop(BinOp::And, a_hi_nz, c_hi_nz);
        let cross0_hi = Self::int128_mulhi_u(b, a.0, c.1);
        let cross1_hi = Self::int128_mulhi_u(b, a.1, c.0);
        let cross0_wide = b.binop(BinOp::Ne, cross0_hi, zero);
        let cross1_wide = b.binop(BinOp::Ne, cross1_hi, zero);
        let ovf = b.binop(BinOp::Or, both_hi, cross0_wide);
        let ovf = b.binop(BinOp::Or, ovf, cross1_wide);
        let ovf = b.binop(BinOp::Or, ovf, carry0);
        let ovf = b.binop(BinOp::Or, ovf, carry1);
        ((lo, hi), ovf)
    }

    /// The 64-bit word above bit 127 of an operand's exact value: the
    /// high half's sign extension for a signed type, zero otherwise. It
    /// makes the 128-bit halves an exact 192-bit two's-complement value,
    /// so operands of different signedness combine without a conversion.
    fn int128_ext_word(b: &mut SsaBuilder, hi: ValueId, signed: bool) -> ValueId {
        if signed {
            b.binop_imm(BinOp::Shr, hi, 63)
        } else {
            b.imm(0)
        }
    }

    /// Whether an operand of `__builtin_*_overflow` can hold a negative
    /// value, i.e. its type is a signed integer.
    fn checked_operand_is_signed(&self, id: ExprId) -> bool {
        let ty = expr_ty(self.ast.expr(id)).unwrap_or(Ty::Int as i64);
        (ty & UNSIGNED_BIT) == 0 && !is_pointer_ty(ty)
    }

    /// 128-bit `__builtin_{add,sub,mul}_overflow`. GCC evaluates in
    /// infinite precision and reports whether the result is
    /// representable in the destination type. The operation runs mod
    /// 2^128 with the discarded magnitude tracked exactly: as the
    /// extension word above bit 127 for add and sub, and in
    /// sign-and-magnitude form for multiply, whose exact product needs
    /// 256 bits. A destination narrower than 128 bits stores the
    /// truncation and reports a result that does not survive the round
    /// trip through it.
    fn walk_checked_arith_128(
        &mut self,
        b: &mut SsaBuilder,
        op: i64,
        a_expr: ExprId,
        b_expr: ExprId,
        dst_expr: ExprId,
        elem_ty: i64,
    ) -> Result<ValueId, WalkError> {
        let dst128 = self.is_int128_value_ty(elem_ty);
        let w = type_size_bytes(elem_ty, self.target);
        if !dst128 && !matches!(w, 1 | 2 | 4 | 8) {
            return Err(WalkError::UnsupportedExpr {
                id: dst_expr,
                kind: "__builtin_*_overflow requires a 1/2/4/8-byte scalar type",
            });
        }
        // The 128-bit result store runs through generic-space half
        // stores, which carry no segment.
        if segment_of_object_ty(elem_ty).is_some() {
            return Err(WalkError::UnsupportedExpr {
                id: dst_expr,
                kind: "128-bit access in a named address space",
            });
        }
        let unsigned = (elem_ty & UNSIGNED_BIT) != 0;
        let a_signed = self.checked_operand_is_signed(a_expr);
        let c_signed = self.checked_operand_is_signed(b_expr);
        let a = self.int128_operand(b, a_expr)?;
        let c = self.int128_operand(b, b_expr)?;
        let addr = self.walk_expr_rvalue(b, dst_expr)?;
        let ea = Self::int128_ext_word(b, a.1, a_signed);
        let ec = Self::int128_ext_word(b, c.1, c_signed);
        let (sum, ovf) = match op {
            // The exact sum is `s + ext * 2^128` with `ext` the operand
            // extension words plus the carry out of bit 127; subtraction
            // takes the borrow out. The result is representable iff that
            // word is what the destination type would sign-extend to.
            0 | 1 => {
                let (s, adj) = if op == 0 {
                    let s = Self::int128_add(b, a, c);
                    let carry = Self::int128_cmp(b, BinOp::Ult, s, a);
                    let e = b.binop(BinOp::Add, ea, ec);
                    (s, b.binop(BinOp::Add, e, carry))
                } else {
                    let s = Self::int128_sub(b, a, c);
                    let borrow = Self::int128_cmp(b, BinOp::Ult, a, c);
                    let e = b.binop(BinOp::Sub, ea, ec);
                    (s, b.binop(BinOp::Sub, e, borrow))
                };
                let f = if unsigned {
                    b.binop_imm(BinOp::Ne, adj, 0)
                } else {
                    let want = b.binop_imm(BinOp::Shr, s.1, 63);
                    b.binop(BinOp::Ne, adj, want)
                };
                (s, f)
            }
            // Multiply by magnitude: the exact product is the unsigned
            // product of the magnitudes with the operand signs combined.
            // It is representable unsigned iff it is non-negative and
            // under 2^128, and signed iff its magnitude is under 2^127,
            // or exactly 2^127 with a negative result.
            _ => {
                let ua = Self::int128_xor_sub(b, a, ea);
                let uc = Self::int128_xor_sub(b, c, ec);
                let (mag, wide) = Self::int128_mul_ovf_u(b, ua, uc);
                let sign = b.binop(BinOp::Xor, ea, ec);
                let s = Self::int128_xor_sub(b, mag, sign);
                let zero = b.imm(0);
                let f = if unsigned {
                    let neg = b.binop_imm(BinOp::And, sign, 1);
                    let nz = Self::int128_cmp(b, BinOp::Ne, mag, (zero, zero));
                    b.binop(BinOp::And, neg, nz)
                } else {
                    let limit = (zero, b.imm(i64::MIN));
                    let over = Self::int128_cmp(b, BinOp::Ugt, mag, limit);
                    let at = Self::int128_cmp(b, BinOp::Eq, mag, limit);
                    let pos = b.binop_imm(BinOp::Add, sign, 1);
                    let at_pos = b.binop(BinOp::And, at, pos);
                    b.binop(BinOp::Or, over, at_pos)
                };
                (s, b.binop(BinOp::Or, wide, f))
            }
        };
        if dst128 {
            self.int128_store(b, addr, sum);
            return Ok(ovf);
        }
        let wrapped = self.extend_atomic_result(b, sum.0, elem_ty);
        b.store(addr, wrapped, store_kind_for(elem_ty, self.target));
        let hi = if unsigned || is_pointer_ty(elem_ty) {
            b.imm(0)
        } else {
            b.binop_imm(BinOp::Shr, wrapped, 63)
        };
        let lo_eq = b.binop(BinOp::Eq, wrapped, sum.0);
        let hi_eq = b.binop(BinOp::Eq, hi, sum.1);
        let fits = b.binop(BinOp::And, lo_eq, hi_eq);
        let lost = b.binop_imm(BinOp::Xor, fits, 1);
        Ok(b.binop(BinOp::Or, ovf, lost))
    }

    /// A compiler builtin call in value position.
    pub(super) fn walk_intrinsic(
        &mut self,
        b: &mut SsaBuilder,
        kind: i64,
        args: &'a [ExprId],
    ) -> Result<ValueId, WalkError> {
        // Deferred `__builtin_constant_p`: under `-O` lower the
        // side-effect-free operand for the SSA folds; otherwise
        // the answer is 0 and the operand stays unevaluated.
        if kind == Intrinsic::ConstantP as i64 {
            if !self.optimize {
                return Ok(b.imm(0));
            }
            let v = self.walk_expr_rvalue(b, args[0])?;
            return Ok(b.intrinsic(kind, alloc::vec![v]));
        }
        // The va_* intrinsics receive the address of the va_list
        // storage. Where `ap` is a va_list reached through a pointer,
        // the System V spelling of `__va_list_self(ap)` is a bare deref
        // whose rvalue would load the list's first eightbyte, so the
        // deref's lvalue -- the pointer itself -- is what is wanted.
        use crate::c5::op::Intrinsic as VaI;
        let va_addr_operand = |i: usize| match VaI::from_i64(kind) {
            Some(VaI::VaStart) | Some(VaI::VaArg) | Some(VaI::VaEnd) => i == 0,
            Some(VaI::VaCopy) => i == 0 || i == 1,
            _ => false,
        };
        let mut arg_vals: alloc::vec::Vec<ValueId> = alloc::vec::Vec::with_capacity(args.len());
        for (i, &a) in args.iter().enumerate() {
            let v = if va_addr_operand(i)
                && matches!(
                    self.ast.expr(a),
                    Expr::Unary {
                        op: UnOp::Deref,
                        ..
                    }
                ) {
                self.walk_expr_lvalue(b, a)?
            } else {
                self.walk_expr_rvalue(b, a)?
            };
            arg_vals.push(v);
        }
        // fma / fmaf (C99 7.12.13.1) lower to the fused node so
        // the three operands round once. The parser has already
        // coerced the arguments to the matching FP width.
        let fma_kind = Intrinsic::Fma as i64;
        let fmaf_kind = Intrinsic::Fmaf as i64;
        if kind == fma_kind || kind == fmaf_kind {
            let v = b.fma(arg_vals[0], arg_vals[1], arg_vals[2], false, false);
            if kind == fmaf_kind {
                return Ok(b.mark_f32(v));
            }
            return Ok(v);
        }
        // clz / ctz at zero are undefined in GCC; this lowering returns
        // the bit width.
        if let Some(i) = Intrinsic::from_i64(kind)
            && i.is_int_bit_unary()
        {
            use crate::c5::op::Intrinsic as I;
            let x = arg_vals[0];
            let w64 = i.is_bit_unary_64();
            return Ok(match i {
                I::Clz | I::Clzll => lower_clz(b, x, w64),
                I::Ctz | I::Ctzll => lower_ctz(b, x, w64),
                I::Clrsb | I::Clrsbll => lower_clrsb(b, x, w64),
                I::Ffs | I::Ffsll => lower_ffs(b, x, w64),
                I::Parity | I::Parityll => {
                    let pc = lower_popcount(b, x, w64);
                    b.binop_imm(BinOp::And, pc, 1)
                }
                _ => lower_popcount(b, x, w64),
            });
        }
        // Byte reversal is a single instruction on every
        // supported target, so it lowers to a dedicated inst
        // rather than a portable shift / mask sequence.
        if let Some(i) = Intrinsic::from_i64(kind)
            && i.is_bswap()
        {
            use crate::c5::op::Intrinsic as I;
            let width = match i {
                I::Bswap16 => 2,
                I::Bswap64 => 8,
                _ => 4,
            };
            return Ok(b.bswap(arg_vals[0], width));
        }
        // The unary FP math intrinsics produce an FP value; tag the
        // single-precision forms so the codegen picks the f32
        // instruction and width.
        let single = Intrinsic::from_i64(kind).is_some_and(|i| i.is_single_precision());
        let v = b.intrinsic(kind, arg_vals);
        if single {
            return Ok(b.mark_f32(v));
        }
        Ok(v)
    }

    /// GCC extended inline asm in value position.
    pub(super) fn walk_inline_asm(
        &mut self,
        b: &mut SsaBuilder,
        idx: u32,
    ) -> Result<ValueId, WalkError> {
        // GCC extended asm: each operand is an output destination
        // address, the parser having applied `&`, or an input value.
        let asm = self.ast.asm_blocks[idx as usize].clone();
        let mut args: alloc::vec::Vec<ValueId> =
            alloc::vec::Vec::with_capacity(asm.operand_exprs.len());
        for &e in &asm.operand_exprs {
            args.push(self.walk_expr_rvalue(b, e)?);
        }
        Ok(b.inline_asm(alloc::boxed::Box::new(asm.block), args))
    }
}

// Portable lowering of the GCC bit-count builtins. Each expands to a
// branchless shift / mask sequence over the SSA builder, so the result
// matches across the interpreter and every target with no dedicated
// instruction. `w64` selects the 64-bit forms; the rest operate on the
// low 32 bits, the operand arriving zero-extended.

type Bld = SsaBuilder;

type Val = ValueId;

/// Count set bits via the standard SWAR reduction. Right shifts are
/// logical (`BinOp::Shru`) so the masks see clean bits regardless of
/// the operand's sign. The result is at most the bit width, so the
/// final `& 0x7f` extracts it.
pub(super) fn lower_popcount(b: &mut Bld, x: Val, w64: bool) -> Val {
    let su = BinOp::Shru;
    let and = BinOp::And;
    if w64 {
        let t = b.binop_imm(su, x, 1);
        let t = b.binop_imm(and, t, 0x5555_5555_5555_5555u64 as i64);
        let a = b.binop(BinOp::Sub, x, t);
        let lo = b.binop_imm(and, a, 0x3333_3333_3333_3333u64 as i64);
        let hi = b.binop_imm(su, a, 2);
        let hi = b.binop_imm(and, hi, 0x3333_3333_3333_3333u64 as i64);
        let a = b.binop(BinOp::Add, lo, hi);
        let s = b.binop_imm(su, a, 4);
        let a = b.binop(BinOp::Add, a, s);
        let a = b.binop_imm(and, a, 0x0f0f_0f0f_0f0f_0f0fu64 as i64);
        let s = b.binop_imm(su, a, 8);
        let a = b.binop(BinOp::Add, a, s);
        let s = b.binop_imm(su, a, 16);
        let a = b.binop(BinOp::Add, a, s);
        let s = b.binop_imm(su, a, 32);
        let a = b.binop(BinOp::Add, a, s);
        b.binop_imm(and, a, 0x7f)
    } else {
        let x = b.binop_imm(and, x, 0xffff_ffff);
        let t = b.binop_imm(su, x, 1);
        let t = b.binop_imm(and, t, 0x5555_5555);
        let a = b.binop(BinOp::Sub, x, t);
        let lo = b.binop_imm(and, a, 0x3333_3333);
        let hi = b.binop_imm(su, a, 2);
        let hi = b.binop_imm(and, hi, 0x3333_3333);
        let a = b.binop(BinOp::Add, lo, hi);
        let s = b.binop_imm(su, a, 4);
        let a = b.binop(BinOp::Add, a, s);
        let a = b.binop_imm(and, a, 0x0f0f_0f0f);
        let s = b.binop_imm(su, a, 8);
        let a = b.binop(BinOp::Add, a, s);
        let s = b.binop_imm(su, a, 16);
        let a = b.binop(BinOp::Add, a, s);
        b.binop_imm(and, a, 0x7f)
    }
}

/// Count leading redundant sign bits: `clz(x ^ (x >> (w-1))) - 1`, with
/// an arithmetic shift forming the all-sign mask. XORing it clears the
/// leading run of sign bits to zeros (and always the sign bit itself),
/// so `clz` of the result is that run length plus one. `x` is sign-
/// extended into the register, so its high half mirrors the sign in the
/// 32-bit case and the XOR leaves the upper bits zero.
pub(super) fn lower_clrsb(b: &mut Bld, x: Val, w64: bool) -> Val {
    let sign = b.binop_imm(BinOp::Shr, x, if w64 { 63 } else { 31 });
    let folded = b.binop(BinOp::Xor, x, sign);
    let clz = lower_clz(b, folded, w64);
    b.binop_imm(BinOp::Sub, clz, 1)
}

/// Count leading zeros: smear the highest set bit down to fill the low
/// bits, then `width - popcount`. At zero the smear stays zero and the
/// result is the bit width.
pub(super) fn lower_clz(b: &mut Bld, x: Val, w64: bool) -> Val {
    let su = BinOp::Shru;
    let or = BinOp::Or;
    let t = b.binop_imm(su, x, 1);
    let mut s = b.binop(or, x, t);
    for sh in [2, 4, 8, 16] {
        let t = b.binop_imm(su, s, sh);
        s = b.binop(or, s, t);
    }
    if w64 {
        let t = b.binop_imm(su, s, 32);
        s = b.binop(or, s, t);
    }
    let pc = lower_popcount(b, s, w64);
    let width = b.imm(if w64 { 64 } else { 32 });
    b.binop(BinOp::Sub, width, pc)
}

/// Count trailing zeros as `popcount((x - 1) & ~x)`: `x - 1` turns the
/// trailing zeros into ones and clears the lowest set bit, and `~x`
/// keeps only those positions. At zero the mask is all-ones and the
/// result is the bit width.
pub(super) fn lower_ctz(b: &mut Bld, x: Val, w64: bool) -> Val {
    let xm1 = b.binop_imm(BinOp::Sub, x, 1);
    let notx = b.binop_imm(BinOp::Xor, x, -1);
    let m = b.binop(BinOp::And, xm1, notx);
    lower_popcount(b, m, w64)
}

/// POSIX / GCC `ffs`: one plus the index of the least-significant set
/// bit, 0 for a zero input. `lower_ctz` returns the bit width at zero,
/// so the `(x != 0)` factor forces that case to 0.
pub(super) fn lower_ffs(b: &mut Bld, x: Val, w64: bool) -> Val {
    let ctz = lower_ctz(b, x, w64);
    let cp1 = b.binop_imm(BinOp::Add, ctz, 1);
    let nz = b.binop_imm(BinOp::Ne, x, 0);
    b.binop(BinOp::Mul, cp1, nz)
}

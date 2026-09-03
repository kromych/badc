//! 128-bit integer lowering. Each value is a low / high 64-bit pair;
//! the arithmetic, the shifts, the division and the conversions are
//! built from 64-bit operations.

use super::bitfield::bitfield_mask_halves;
use super::types::{expr_ty, is_int_comparison_op};
use super::*;

impl<'a> Walker<'a> {
    /// Load the two 64-bit halves of the 128-bit object at `addr`
    /// (little-endian: low half first).
    pub(super) fn int128_load(&mut self, b: &mut SsaBuilder, addr: ValueId) -> Halves {
        self.int128_load_vol(b, addr, false)
    }

    /// Store a lo/hi half pair into the 128-bit object at `addr`.
    pub(super) fn int128_store(&mut self, b: &mut SsaBuilder, addr: ValueId, pair: Halves) {
        self.int128_store_vol(b, addr, pair, false);
    }

    /// [`Self::int128_load`] with the C99 6.7.3p6 volatile access rule
    /// applied to both halves.
    pub(super) fn int128_load_vol(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        vol: bool,
    ) -> Halves {
        let lo = b.load_vol(addr, LoadKind::I64, vol);
        let hi_addr = b.binop_imm(BinOp::Add, addr, 8);
        let hi = b.load_vol(hi_addr, LoadKind::I64, vol);
        (lo, hi)
    }

    /// [`Self::int128_store`] with the C99 6.7.3p6 volatile access rule
    /// applied to both halves.
    pub(super) fn int128_store_vol(
        &mut self,
        b: &mut SsaBuilder,
        addr: ValueId,
        (lo, hi): Halves,
        vol: bool,
    ) {
        b.store_vol(addr, lo, StoreKind::I64, vol);
        let hi_addr = b.binop_imm(BinOp::Add, addr, 8);
        b.store_vol(hi_addr, hi, StoreKind::I64, vol);
    }

    /// Materialise a half pair as a fresh 16-byte object and return its
    /// address (the struct-rvalue address-as-value rule).
    pub(super) fn int128_materialize(&mut self, b: &mut SsaBuilder, pair: Halves) -> ValueId {
        let slot = b.alloc_synthetic_struct(16);
        let addr = b.local_addr(slot);
        self.int128_store(b, addr, pair);
        addr
    }

    /// Walk one operand of a 128-bit operation into a half pair. An
    /// int128-typed operand is an address to load through; a scalar
    /// converts per C99 6.3.1.3 (widen to 64 bits, then sign- or
    /// zero-fill the high half, mirroring `store_scalar_as_int128`).
    pub(super) fn int128_operand(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
    ) -> Result<Halves, WalkError> {
        let ty = expr_ty(self.ast.expr(id)).unwrap_or(Ty::Int as i64);
        let is128 = self.expr_is_int128_value(id);
        let v = self.walk_copy_operand(b, id)?;
        if is128 {
            return Ok(self.int128_load(b, v));
        }
        let ty = if self.is_int128_value_ty(ty) {
            Ty::Int as i64
        } else {
            ty
        };
        let low_ty = Ty::LongLong as i64 | (ty & UNSIGNED_BIT);
        let lo = self.convert_scalar_value(b, v, ty, low_ty);
        let hi = if (ty & UNSIGNED_BIT) != 0 || is_pointer_ty(ty) {
            b.imm(0)
        } else {
            b.binop_imm(BinOp::Shr, lo, 63)
        };
        Ok((lo, hi))
    }

    /// 128-bit addition: 64-bit halves with the carry recovered from
    /// the unsigned low-half compare (`lo < a.lo` iff the add wrapped).
    pub(super) fn int128_add(b: &mut SsaBuilder, a: Halves, c: Halves) -> Halves {
        let lo = b.binop(BinOp::Add, a.0, c.0);
        let carry = b.binop(BinOp::Ult, lo, a.0);
        let hi = b.binop(BinOp::Add, a.1, c.1);
        let hi = b.binop(BinOp::Add, hi, carry);
        (lo, hi)
    }

    /// 128-bit subtraction with the borrow from the unsigned low-half
    /// compare.
    pub(super) fn int128_sub(b: &mut SsaBuilder, a: Halves, c: Halves) -> Halves {
        let borrow = b.binop(BinOp::Ult, a.0, c.0);
        let lo = b.binop(BinOp::Sub, a.0, c.0);
        let hi = b.binop(BinOp::Sub, a.1, c.1);
        let hi = b.binop(BinOp::Sub, hi, borrow);
        (lo, hi)
    }

    /// 128-bit two's-complement negation (`0 - a`).
    fn int128_neg(b: &mut SsaBuilder, a: Halves) -> Halves {
        let zero = b.imm(0);
        Self::int128_sub(b, (zero, zero), a)
    }

    /// `(a ^ m) - m` where `m` is 0 or all-ones in both halves: the
    /// branchless conditional negation used by the signed divide.
    pub(super) fn int128_xor_sub(b: &mut SsaBuilder, a: Halves, m: ValueId) -> Halves {
        let lo = b.binop(BinOp::Xor, a.0, m);
        let hi = b.binop(BinOp::Xor, a.1, m);
        Self::int128_sub(b, (lo, hi), (m, m))
    }

    /// 128-bit shift by a runtime count, `op` being `Shl`, `Shru` or
    /// arithmetic `Shr`. The count reduces mod 128, matching the
    /// per-arch shifter's mod-64 rule one level up, and both count
    /// ranges are computed branchlessly and selected by mask.
    /// Sub-shifts stay in [0,63] so every 64-bit shift is defined on
    /// all backends: `x >> (64-t)` is written `(x >> (63-t)) >> 1`,
    /// which is 0 at `t = 0` as required.
    fn int128_shift(b: &mut SsaBuilder, op: BinOp, a: Halves, count: ValueId) -> Halves {
        let s = b.binop_imm(BinOp::And, count, 127);
        let t = b.binop_imm(BinOp::And, s, 63);
        let inv = {
            let k = b.imm(63);
            b.binop(BinOp::Sub, k, t)
        };
        // big = 1 when the count is in [64,127]; mask = all-ones then.
        let big = b.binop_imm(BinOp::Shru, s, 6);
        let mask = {
            let zero = b.imm(0);
            b.binop(BinOp::Sub, zero, big)
        };
        let nmask = b.binop_imm(BinOp::Xor, mask, -1);
        let sel = |b: &mut SsaBuilder, small: ValueId, large: ValueId| {
            let x = b.binop(BinOp::And, small, nmask);
            let y = b.binop(BinOp::And, large, mask);
            b.binop(BinOp::Or, x, y)
        };
        match op {
            BinOp::Shl => {
                let l1 = b.binop(BinOp::Shl, a.0, t);
                let c = b.binop(BinOp::Shru, a.0, inv);
                let c = b.binop_imm(BinOp::Shru, c, 1);
                let h = b.binop(BinOp::Shl, a.1, t);
                let h1 = b.binop(BinOp::Or, h, c);
                let zero = b.imm(0);
                (sel(b, l1, zero), sel(b, h1, l1))
            }
            BinOp::Shru => {
                let h1 = b.binop(BinOp::Shru, a.1, t);
                let c = b.binop(BinOp::Shl, a.1, inv);
                let c = b.binop_imm(BinOp::Shl, c, 1);
                let l = b.binop(BinOp::Shru, a.0, t);
                let l1 = b.binop(BinOp::Or, l, c);
                let zero = b.imm(0);
                (sel(b, l1, h1), sel(b, h1, zero))
            }
            _ => {
                // Arithmetic: the emptied high half fills with the sign.
                let h1 = b.binop(BinOp::Shr, a.1, t);
                let c = b.binop(BinOp::Shl, a.1, inv);
                let c = b.binop_imm(BinOp::Shl, c, 1);
                let l = b.binop(BinOp::Shru, a.0, t);
                let l1 = b.binop(BinOp::Or, l, c);
                let sign = b.binop_imm(BinOp::Shr, a.1, 63);
                (sel(b, l1, h1), sel(b, h1, sign))
            }
        }
    }

    /// 128-bit shift by a constant count (folded form of
    /// [`Self::int128_shift`]).
    pub(super) fn int128_shift_const(
        b: &mut SsaBuilder,
        op: BinOp,
        a: Halves,
        count: i64,
    ) -> Halves {
        let k = count & 127;
        if k == 0 {
            return a;
        }
        match op {
            BinOp::Shl => {
                if k < 64 {
                    let lo = b.binop_imm(BinOp::Shl, a.0, k);
                    let h = b.binop_imm(BinOp::Shl, a.1, k);
                    let c = b.binop_imm(BinOp::Shru, a.0, 64 - k);
                    (lo, b.binop(BinOp::Or, h, c))
                } else {
                    let zero = b.imm(0);
                    (zero, b.binop_imm(BinOp::Shl, a.0, k - 64))
                }
            }
            BinOp::Shru => {
                if k < 64 {
                    let hi = b.binop_imm(BinOp::Shru, a.1, k);
                    let l = b.binop_imm(BinOp::Shru, a.0, k);
                    let c = b.binop_imm(BinOp::Shl, a.1, 64 - k);
                    (b.binop(BinOp::Or, l, c), hi)
                } else {
                    let lo = b.binop_imm(BinOp::Shru, a.1, k - 64);
                    (lo, b.imm(0))
                }
            }
            _ => {
                if k < 64 {
                    let hi = b.binop_imm(BinOp::Shr, a.1, k);
                    let l = b.binop_imm(BinOp::Shru, a.0, k);
                    let c = b.binop_imm(BinOp::Shl, a.1, 64 - k);
                    (b.binop(BinOp::Or, l, c), hi)
                } else {
                    let lo = b.binop_imm(BinOp::Shr, a.1, k - 64);
                    (lo, b.binop_imm(BinOp::Shr, a.1, 63))
                }
            }
        }
    }

    /// High 64 bits of the unsigned 64x64 product, from the four
    /// 32-bit partial products. Built from ops every backend has, so
    /// all four agree by construction.
    // TODO: a widening-multiply opcode would fold this to one
    // instruction (x86_64 `mul`, aarch64 `umulh`).
    pub(super) fn int128_mulhi_u(b: &mut SsaBuilder, x: ValueId, y: ValueId) -> ValueId {
        const LOW32: i64 = 0xffff_ffff;
        let x0 = b.binop_imm(BinOp::And, x, LOW32);
        let x1 = b.binop_imm(BinOp::Shru, x, 32);
        let y0 = b.binop_imm(BinOp::And, y, LOW32);
        let y1 = b.binop_imm(BinOp::Shru, y, 32);
        let carry = {
            let p = b.binop(BinOp::Mul, x0, y0);
            b.binop_imm(BinOp::Shru, p, 32)
        };
        let mid = {
            let p = b.binop(BinOp::Mul, x1, y0);
            b.binop(BinOp::Add, p, carry)
        };
        let mid_lo = b.binop_imm(BinOp::And, mid, LOW32);
        let mid_hi = b.binop_imm(BinOp::Shru, mid, 32);
        let mid2_hi = {
            let p = b.binop(BinOp::Mul, x0, y1);
            let s = b.binop(BinOp::Add, p, mid_lo);
            b.binop_imm(BinOp::Shru, s, 32)
        };
        let hi = b.binop(BinOp::Mul, x1, y1);
        let hi = b.binop(BinOp::Add, hi, mid_hi);
        b.binop(BinOp::Add, hi, mid2_hi)
    }

    /// 128-bit multiply. The low half is the 64-bit product of the low
    /// halves; the high half adds that product's carry-out to the two
    /// cross terms. The `a.hi * c.hi` term only reaches bit 128 and up,
    /// so it is dropped (C99 6.2.5p9: the result wraps mod 2^128).
    fn int128_mul(b: &mut SsaBuilder, a: Halves, c: Halves) -> Halves {
        let lo = b.binop(BinOp::Mul, a.0, c.0);
        let hi = Self::int128_mulhi_u(b, a.0, c.0);
        let cross0 = b.binop(BinOp::Mul, a.0, c.1);
        let cross1 = b.binop(BinOp::Mul, a.1, c.0);
        let hi = b.binop(BinOp::Add, hi, cross0);
        let hi = b.binop(BinOp::Add, hi, cross1);
        (lo, hi)
    }

    /// Unsigned 128-bit divide, returning `(quotient, remainder)`.
    /// Operands that both fit in 64 bits take the hardware divide.
    /// Otherwise a restoring shift-subtract runs over the 128 bits: the
    /// dividend shifts left out of `n` into the running remainder while
    /// the quotient bits shift into `n` from below, so both results
    /// share one register pair, and the body is branchless -- the
    /// compare feeds a 0/-1 mask -- leaving one loop-carried branch.
    /// Lowering it inline rather than calling a runtime helper serves
    /// the VM, the JIT and both native targets from one implementation
    /// and leaves nothing to link into a freestanding image. A zero
    /// divisor is undefined (C99 6.5.5p5): the hardware path traps and
    /// the loop yields all-ones.
    fn int128_udivmod(&mut self, b: &mut SsaBuilder, a: Halves, c: Halves) -> (Halves, Halves) {
        let q_lo = b.alloc_synthetic_local();
        let q_hi = b.alloc_synthetic_local();
        let r_lo = b.alloc_synthetic_local();
        let r_hi = b.alloc_synthetic_local();
        let sk = StoreKind::I64;
        let lk = LoadKind::I64;

        let wide = b.binop(BinOp::Or, a.1, c.1);
        let narrow_blk = b.new_block();
        let wide_blk = b.new_block();
        let done_blk = b.new_block();
        b.branch_zero(wide, narrow_blk, wide_blk);

        b.switch_to(narrow_blk);
        let q = b.binop(BinOp::Divu, a.0, c.0);
        let r = b.binop(BinOp::Modu, a.0, c.0);
        let zero = b.imm(0);
        b.store_local(q_lo, q, sk);
        b.store_local(q_hi, zero, sk);
        b.store_local(r_lo, r, sk);
        b.store_local(r_hi, zero, sk);
        b.jmp(done_blk);

        b.switch_to(wide_blk);
        let zero = b.imm(0);
        b.store_local(q_lo, a.0, sk);
        b.store_local(q_hi, a.1, sk);
        b.store_local(r_lo, zero, sk);
        b.store_local(r_hi, zero, sk);
        let counter = b.alloc_synthetic_local();
        let n = b.imm(128);
        b.store_local(counter, n, sk);
        let head_blk = b.new_block();
        let body_blk = b.new_block();
        b.jmp(head_blk);

        b.switch_to(head_blk);
        let i = b.load_local(counter, lk);
        b.branch_zero(i, done_blk, body_blk);

        b.switch_to(body_blk);
        let nl = b.load_local(q_lo, lk);
        let nh = b.load_local(q_hi, lk);
        let rl = b.load_local(r_lo, lk);
        let rh = b.load_local(r_hi, lk);
        let top = b.binop_imm(BinOp::Shru, nh, 63);
        let rem = Self::int128_shift_const(b, BinOp::Shl, (rl, rh), 1);
        let rem = (b.binop(BinOp::Or, rem.0, top), rem.1);
        let num = Self::int128_shift_const(b, BinOp::Shl, (nl, nh), 1);
        let fits = Self::int128_cmp(b, BinOp::Uge, rem, c);
        let mask = {
            let zero = b.imm(0);
            b.binop(BinOp::Sub, zero, fits)
        };
        let sub = (
            b.binop(BinOp::And, c.0, mask),
            b.binop(BinOp::And, c.1, mask),
        );
        let rem = Self::int128_sub(b, rem, sub);
        let num_lo = b.binop(BinOp::Or, num.0, fits);
        b.store_local(q_lo, num_lo, sk);
        b.store_local(q_hi, num.1, sk);
        b.store_local(r_lo, rem.0, sk);
        b.store_local(r_hi, rem.1, sk);
        let next = b.binop_imm(BinOp::Sub, i, 1);
        b.store_local(counter, next, sk);
        b.jmp(head_blk);

        b.switch_to(done_blk);
        let q = (b.load_local(q_lo, lk), b.load_local(q_hi, lk));
        let r = (b.load_local(r_lo, lk), b.load_local(r_hi, lk));
        (q, r)
    }

    /// Signed 128-bit divide, returning `(quotient, remainder)`.
    /// Divides the magnitudes and restores the signs: the quotient is
    /// negative when the operand signs differ and the remainder takes
    /// the dividend's sign (C99 6.5.5p6, truncation toward zero).
    fn int128_sdivmod(&mut self, b: &mut SsaBuilder, a: Halves, c: Halves) -> (Halves, Halves) {
        let sa = b.binop_imm(BinOp::Shr, a.1, 63);
        let sc = b.binop_imm(BinOp::Shr, c.1, 63);
        let ua = Self::int128_xor_sub(b, a, sa);
        let uc = Self::int128_xor_sub(b, c, sc);
        let (q, r) = self.int128_udivmod(b, ua, uc);
        let qs = b.binop(BinOp::Xor, sa, sc);
        let q = Self::int128_xor_sub(b, q, qs);
        let r = Self::int128_xor_sub(b, r, sa);
        (q, r)
    }

    /// 128-bit comparison, yielding 0/1. Equality folds the XOR of
    /// both halves; orderings decide on the high half and fall back to
    /// the unsigned low half on a tie (C99 6.5.8). The high-half
    /// compare is signed or unsigned per `op`.
    pub(super) fn int128_cmp(b: &mut SsaBuilder, op: BinOp, a: Halves, c: Halves) -> ValueId {
        match op {
            BinOp::Eq | BinOp::Ne => {
                let xl = b.binop(BinOp::Xor, a.0, c.0);
                let xh = b.binop(BinOp::Xor, a.1, c.1);
                let x = b.binop(BinOp::Or, xl, xh);
                b.binop_imm(op, x, 0)
            }
            _ => {
                // Reduce to `<`: swap operands for Gt/Ugt, invert the
                // result for Ge/Le (a <= b iff !(b < a)).
                let (x, y, invert, hi_op) = match op {
                    BinOp::Lt => (a, c, false, BinOp::Lt),
                    BinOp::Gt => (c, a, false, BinOp::Lt),
                    BinOp::Ge => (a, c, true, BinOp::Lt),
                    BinOp::Le => (c, a, true, BinOp::Lt),
                    BinOp::Ult => (a, c, false, BinOp::Ult),
                    BinOp::Ugt => (c, a, false, BinOp::Ult),
                    BinOp::Uge => (a, c, true, BinOp::Ult),
                    _ => (c, a, true, BinOp::Ult), // Ule
                };
                let hi_lt = b.binop(hi_op, x.1, y.1);
                let hi_eq = b.binop(BinOp::Eq, x.1, y.1);
                let lo_lt = b.binop(BinOp::Ult, x.0, y.0);
                let tie = b.binop(BinOp::And, hi_eq, lo_lt);
                let lt = b.binop(BinOp::Or, hi_lt, tie);
                if invert {
                    b.binop_imm(BinOp::Xor, lt, 1)
                } else {
                    lt
                }
            }
        }
    }

    /// Reinterpret a value's bits across the integer and FP register
    /// banks through an 8-byte stack slot. The `F64` kinds are single
    /// moves with no widen or narrow, so the round trip is bit-exact on
    /// every backend. The 128-bit floating conversions use it to
    /// assemble and dissect an IEEE-754 double with integer
    /// arithmetic.
    fn fp_bitcast(
        &mut self,
        b: &mut SsaBuilder,
        v: ValueId,
        store: StoreKind,
        load: LoadKind,
    ) -> ValueId {
        let slot = b.alloc_synthetic_struct(8);
        let addr = b.local_addr(slot);
        b.store(addr, v, store);
        b.load(addr, load)
    }

    /// One-based index of the most significant set bit of `x`, and 1
    /// for `x == 0`. A branchless binary search, the IR having no
    /// count-leading-zeros opcode; every step shifts by a value in
    /// [0,63], so the per-arch mod-64 rule never applies.
    fn bit_length_64(b: &mut SsaBuilder, x: ValueId) -> ValueId {
        let mut len = b.imm(1);
        let mut cur = x;
        for k in [32, 16, 8, 4, 2, 1] {
            let y = b.binop_imm(BinOp::Shru, cur, k);
            let c = b.binop_imm(BinOp::Ne, y, 0);
            let s = b.binop_imm(BinOp::Mul, c, k);
            len = b.binop(BinOp::Add, len, s);
            cur = b.binop(BinOp::Shru, cur, s);
        }
        len
    }

    /// Convert the 128-bit integer `a` to `double`, or to `float` when
    /// `to_float`, with the single round-to-nearest-even of C99 6.3.1.4.
    ///
    /// The magnitude is pre-reduced to its top 64 significant bits with
    /// the discarded bits collapsed into a sticky bit at position 0,
    /// converted once by the hardware unsigned converter, and scaled by
    /// the exact power of two shifted out. Position 0 sits below the
    /// converter's rounding position and the sticky bit preserves
    /// whether anything below the round bit was set, so the
    /// pre-reduction cannot change which way the rounding goes; scaling
    /// by a power of two is exact, so there is no second rounding.
    pub(super) fn int128_to_fp(
        &mut self,
        b: &mut SsaBuilder,
        a: Halves,
        signed: bool,
        to_float: bool,
    ) -> ValueId {
        // A signed operand converts its magnitude and carries the sign
        // into the scale factor; round-to-nearest-even is symmetric
        // about zero, so the result matches converting the operand.
        let (mag, sign_bit) = if signed {
            let sgn = b.binop_imm(BinOp::Shr, a.1, 63);
            let m = Self::int128_xor_sub(b, a, sgn);
            let s = b.binop_imm(BinOp::And, sgn, i64::MIN);
            (m, s)
        } else {
            (a, b.imm(0))
        };
        // Shift count that leaves exactly 64 significant bits, and 0
        // when the magnitude already fits in 64 (the high half is then
        // zero and no bits are discarded).
        let hnz = b.binop_imm(BinOp::Ne, mag.1, 0);
        let bl = Self::bit_length_64(b, mag.1);
        let sh = b.binop(BinOp::Mul, bl, hnz);
        // Sticky bit over the `sh` discarded low bits. The mask shifts
        // right rather than being `(1 << sh) - 1`, keeping the count in
        // [0,63], and is forced to zero at `sh == 0`.
        let inv = {
            let k = b.imm(64);
            let d = b.binop(BinOp::Sub, k, sh);
            b.binop_imm(BinOp::And, d, 63)
        };
        let mask = {
            let ones = b.imm(-1);
            let m = b.binop(BinOp::Shru, ones, inv);
            let nz = b.binop_imm(BinOp::Ne, sh, 0);
            b.binop(BinOp::Mul, m, nz)
        };
        let sticky = {
            let dropped = b.binop(BinOp::And, mag.0, mask);
            b.binop_imm(BinOp::Ne, dropped, 0)
        };
        let top = Self::int128_shift(b, BinOp::Shru, mag, sh).0;
        let t = b.binop(BinOp::Or, top, sticky);
        // The single rounding. A `float` result rounds to single
        // precision here; the scaling below is exact, so narrowing the
        // scaled product back to `float` does not round again.
        let d = if to_float {
            let f = b.fp_cast_to_f32(FpCastKind::UIntToFp, t);
            b.fp_widen_to_f64(f)
        } else {
            b.fp_cast(FpCastKind::UIntToFp, t)
        };
        // Scale by +/- 2^sh, assembled as an IEEE-754 double: `sh` is
        // at most 64, so the biased exponent stays in range.
        let scale = {
            let e = b.binop_imm(BinOp::Add, sh, 1023);
            let bits = b.binop_imm(BinOp::Shl, e, 52);
            let signed_bits = b.binop(BinOp::Or, bits, sign_bit);
            self.fp_bitcast(b, signed_bits, StoreKind::I64, LoadKind::F64)
        };
        let r = b.binop(BinOp::Fmul, d, scale);
        if to_float { b.fp_narrow_to_f32(r) } else { r }
    }

    /// Convert the floating value `v` to a 128-bit integer, truncating
    /// toward zero (C99 6.3.1.4). The operand is dissected into its
    /// IEEE-754 exponent and significand, and shifting the significand
    /// into place discards the fraction exactly.
    ///
    /// C99 leaves an out-of-range truncated value undefined --
    /// infinities, NaNs and any negative operand converted to the
    /// unsigned type included -- and gcc and clang differ there from
    /// each other and between targets. This lowering saturates: a
    /// negative operand converted to the unsigned type yields 0, and
    /// anything else out of range yields the target type's minimum or
    /// maximum by the operand's sign. That is total, deterministic and
    /// identical on every backend, and matches the runtime routines
    /// both compilers call when they do not expand the conversion
    /// inline.
    pub(super) fn fp_to_int128(&mut self, b: &mut SsaBuilder, v: ValueId, signed: bool) -> Halves {
        // A `float` operand widens to double exactly, so one dissection
        // serves both source types.
        let d = b.fp_widen_to_f64(v);
        let bits = self.fp_bitcast(b, d, StoreKind::F64, LoadKind::I64);
        let sign = b.binop_imm(BinOp::Shr, bits, 63);
        let abs = b.binop_imm(BinOp::And, bits, i64::MAX);
        let exp = {
            let e = b.binop_imm(BinOp::Shru, abs, 52);
            b.binop_imm(BinOp::Sub, e, 1023)
        };
        let sig = {
            let frac = b.binop_imm(BinOp::And, abs, (1i64 << 52) - 1);
            b.binop_imm(BinOp::Or, frac, 1i64 << 52)
        };
        // The significand carries a factor of 2^52, so the value is
        // `sig << (exp - 52)`; a negative count shifts right, which
        // drops the fraction bits and truncates toward zero.
        let k = b.binop_imm(BinOp::Sub, exp, 52);
        let kneg = b.binop_imm(BinOp::Shr, k, 63);
        let kabs = {
            let x = b.binop(BinOp::Xor, k, kneg);
            b.binop(BinOp::Sub, x, kneg)
        };
        let zero = b.imm(0);
        let left = Self::int128_shift(b, BinOp::Shl, (sig, zero), kabs);
        let right = Self::int128_shift(b, BinOp::Shru, (sig, zero), kabs);
        let sel = |b: &mut SsaBuilder, small: ValueId, large: ValueId, m: ValueId| {
            let nm = b.binop_imm(BinOp::Xor, m, -1);
            let x = b.binop(BinOp::And, small, nm);
            let y = b.binop(BinOp::And, large, m);
            b.binop(BinOp::Or, x, y)
        };
        let mag = (sel(b, left.0, right.0, kneg), sel(b, left.1, right.1, kneg));
        // `|v| < 1` truncates to zero. This also covers zero, the
        // subnormals, and the out-of-range shift counts the dissection
        // produces for them.
        let keep = {
            let neg_exp = b.binop_imm(BinOp::Shr, exp, 63);
            b.binop_imm(BinOp::Xor, neg_exp, -1)
        };
        let mag = (
            b.binop(BinOp::And, mag.0, keep),
            b.binop(BinOp::And, mag.1, keep),
        );
        // Out of range once the magnitude reaches 2^128, where an
        // infinity and a NaN also land, their exponent being the
        // maximum. The signed conversion uses the same limit, so a
        // magnitude in [2^127, 2^128) wraps negative rather than
        // saturating: that keeps -2^127 exact and matches gcc and
        // clang, which agree here across targets.
        let over = {
            let o = b.binop_imm(BinOp::Ge, exp, 128);
            let z = b.imm(0);
            b.binop(BinOp::Sub, z, o)
        };
        if signed {
            let mag = Self::int128_xor_sub(b, mag, sign);
            let sat_lo = {
                let ones = b.imm(-1);
                b.binop(BinOp::Xor, ones, sign)
            };
            let sat_hi = {
                let max = b.imm(i64::MAX);
                b.binop(BinOp::Xor, max, sign)
            };
            (sel(b, mag.0, sat_lo, over), sel(b, mag.1, sat_hi, over))
        } else {
            let ones = b.imm(-1);
            let r = (sel(b, mag.0, ones, over), sel(b, mag.1, ones, over));
            // A negative operand yields 0 rather than the wrapped
            // magnitude.
            let keep_pos = b.binop_imm(BinOp::Xor, sign, -1);
            (
                b.binop(BinOp::And, r.0, keep_pos),
                b.binop(BinOp::And, r.1, keep_pos),
            )
        }
    }

    /// True when the expression's *value* is a 128-bit integer.
    pub(super) fn expr_is_int128_value(&self, id: ExprId) -> bool {
        expr_ty(self.ast.expr(id)).is_some_and(|t| self.is_int128_value_ty(t))
    }

    /// True when either operand of a binary node is a 128-bit value, so
    /// the node lowers through [`Self::walk_int128_binary`].
    pub(super) fn is_int128_binary(&self, lhs: ExprId, rhs: ExprId) -> bool {
        self.expr_is_int128_value(lhs) || self.expr_is_int128_value(rhs)
    }

    /// Lower `Expr::Binary` with a 128-bit operand. A comparison
    /// yields a scalar 0/1 and every other operator the address of a
    /// fresh 16-byte object, as a struct rvalue is produced. The shift
    /// count stays scalar -- C99 6.5.7 promotes each operand separately
    /// rather than converting across them -- and an int128-typed count
    /// contributes its low half.
    pub(super) fn walk_int128_binary(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
    ) -> Result<ValueId, WalkError> {
        match op {
            _ if is_int_comparison_op(op) => {
                let a = self.int128_operand(b, lhs)?;
                let c = self.int128_operand(b, rhs)?;
                Ok(Self::int128_cmp(b, op, a, c))
            }
            _ => {
                let a = self.int128_operand(b, lhs)?;
                let pair = self.int128_binary_pair(b, op, a, lhs, rhs)?;
                Ok(self.int128_materialize(b, pair))
            }
        }
    }

    /// Apply a value-producing 128-bit operator to an already-loaded
    /// left operand, shared by `Expr::Binary` and the compound
    /// assignment. `lhs` is carried for diagnostics only.
    fn int128_binary_pair(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        a: Halves,
        lhs: ExprId,
        rhs: ExprId,
    ) -> Result<Halves, WalkError> {
        match op {
            BinOp::Shl | BinOp::Shr | BinOp::Shru => {
                let cnt = self.int128_shift_count(b, rhs)?;
                Ok(match b.peek_imm(cnt) {
                    Some(k) => Self::int128_shift_const(b, op, a, k),
                    None => Self::int128_shift(b, op, a, cnt),
                })
            }
            BinOp::Add | BinOp::Sub => {
                let c = self.int128_operand(b, rhs)?;
                Ok(if matches!(op, BinOp::Add) {
                    Self::int128_add(b, a, c)
                } else {
                    Self::int128_sub(b, a, c)
                })
            }
            BinOp::And | BinOp::Or | BinOp::Xor => {
                let c = self.int128_operand(b, rhs)?;
                let lo = b.binop(op, a.0, c.0);
                let hi = b.binop(op, a.1, c.1);
                Ok((lo, hi))
            }
            BinOp::Mul => {
                // The parser spells unary minus as `x * -1`; negation
                // is three ops where the full product is seventeen.
                if let Expr::IntLit { val: -1, .. } = self.ast.expr(rhs) {
                    return Ok(Self::int128_neg(b, a));
                }
                let c = self.int128_operand(b, rhs)?;
                Ok(Self::int128_mul(b, a, c))
            }
            BinOp::Div | BinOp::Divu | BinOp::Mod | BinOp::Modu => {
                let c = self.int128_operand(b, rhs)?;
                let (q, r) = if matches!(op, BinOp::Div | BinOp::Mod) {
                    self.int128_sdivmod(b, a, c)
                } else {
                    self.int128_udivmod(b, a, c)
                };
                Ok(if matches!(op, BinOp::Div | BinOp::Divu) {
                    q
                } else {
                    r
                })
            }
            _ => Err(WalkError::InvalidExpr {
                id: lhs,
                kind: "128-bit operator",
            }),
        }
    }

    /// Read-modify-write a 128-bit object in place, evaluating the
    /// lvalue once (C99 6.5.2.4p2 / 6.5.16.2p3). `update` derives the
    /// new value from the old one. With `keep_old` the prior value is
    /// copied out before the update and is the result, as the postfix
    /// operators require; otherwise the result is the stored value --
    /// the object's address for a whole object, and the field's value
    /// form for a bitfield.
    fn int128_rmw(
        &mut self,
        b: &mut SsaBuilder,
        lvalue: ExprId,
        keep_old: bool,
        update: impl FnOnce(&mut Self, &mut SsaBuilder, Halves) -> Result<Halves, WalkError>,
    ) -> Result<ValueId, WalkError> {
        // The 128-bit halves are accessed through the generic space,
        // which carries no segment.
        if expr_ty(self.ast.expr(lvalue)).is_some_and(|t| segment_of_object_ty(t).is_some()) {
            return Err(WalkError::UnsupportedExpr {
                id: lvalue,
                kind: "128-bit access in a named address space",
            });
        }
        // A bitfield target reads and writes its slice of the storage
        // unit rather than the whole 16 bytes.
        if let Some((unit, bf)) = self.wide_bitfield_place(b, lvalue)? {
            let vol = self.expr_is_volatile(lvalue);
            let old = self.bitfield_extract_128(b, unit, bf, vol);
            let saved = keep_old.then(|| self.bitfield_value_form(b, bf, old));
            let new = update(self, b, old)?;
            let masked = Self::int128_and_imm(b, new, bitfield_mask_halves(bf.bit_width, 0));
            self.bitfield_insert_128(b, unit, bf, masked, vol);
            let stored = self.bitfield_sign_extend_128(b, bf, masked);
            let stored = self.bitfield_value_form(b, bf, stored);
            return Ok(saved.unwrap_or(stored));
        }
        let addr = self.walk_expr_lvalue(b, lvalue)?;
        let old = self.int128_load(b, addr);
        let saved = keep_old.then(|| self.int128_materialize(b, old));
        let new = update(self, b, old)?;
        self.int128_store(b, addr, new);
        Ok(saved.unwrap_or(addr))
    }

    /// Lower `++E` / `--E` (and their postfix forms) on a 128-bit
    /// object. `by` carries the direction's sign, so both spellings are
    /// one 128-bit add.
    pub(super) fn walk_int128_inc(
        &mut self,
        b: &mut SsaBuilder,
        lvalue: ExprId,
        by: i64,
        postfix: bool,
    ) -> Result<ValueId, WalkError> {
        self.int128_rmw(b, lvalue, postfix, |_, b, old| {
            let lo = b.imm(by);
            let step = (lo, b.imm(by >> 63));
            Ok(Self::int128_add(b, old, step))
        })
    }

    /// Lower `E1 op= E2` where `E1` is a 128-bit object.
    pub(super) fn walk_int128_compound_assign(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
    ) -> Result<ValueId, WalkError> {
        self.int128_rmw(b, lhs, false, |this, b, a| {
            this.int128_binary_pair(b, op, a, lhs, rhs)
        })
    }

    /// Shift count for a 128-bit shift: a scalar rvalue, or the low
    /// half of an int128-typed count.
    fn int128_shift_count(&mut self, b: &mut SsaBuilder, id: ExprId) -> Result<ValueId, WalkError> {
        let is128 = self.expr_is_int128_value(id);
        let v = self.walk_copy_operand(b, id)?;
        if is128 {
            return Ok(b.load(v, LoadKind::I64));
        }
        Ok(v)
    }
}

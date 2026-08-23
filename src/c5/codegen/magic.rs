//! Reciprocal-multiply constants for division by a compile-time
//! constant (Granlund & Montgomery, "Division by Invariant Integers
//! using Multiplication", PLDI 1994; Warren, "Hacker's Delight" ch. 10).
//!
//! A divide by a constant `d` becomes `floor(n * m / 2^p)` for a magic
//! multiplier `m = ceil(2^p / d)` and a shift `p` chosen so the
//! approximation is exact over the whole numerator range. The
//! derivation below picks the smallest such `p`, which bounds the
//! multiplier at `w + 1` bits unsigned and `w` bits signed.
//!
//! Both derivations run in 128-bit arithmetic, so `w = 64` needs no
//! special casing.

use super::super::ir::BinOp;

/// Numerator range and multiplier bound for one derivation.
struct Bound {
    /// Largest `n` in range that is congruent to `-1` mod `d`; the
    /// worst case for the approximation error.
    nc: u128,
    /// `2^p` must exceed `e * nc` for the quotient to be exact.
    strict: bool,
}

/// Largest `n <= nmax` with `n % d == d - 1`.
fn worst_case(nmax: u128, d: u128) -> u128 {
    nmax - (nmax + 1) % d
}

/// Smallest `p >= w` such that `m = ceil(2^p / d)` divides exactly over
/// every bound. Returns `(p, m)`.
///
/// With `m * d = 2^p + e` and `n = q*d + r`, the quotient
/// `floor(n*m / 2^p)` equals `q` exactly when `e * n < (d - r) * 2^p`.
/// The binding residue is `r = d - 1`, so testing the largest in-range
/// `n` congruent to `-1` mod `d` covers every smaller residue: for
/// `r <= d - 2` the right-hand side doubles while `n` grows by less
/// than `d`, and the `r = d - 1` bound already forces `e * (d-1) < 2^p`.
///
/// `p < 2*w` always, given every caller's `d <= 2^(w-1)`: at
/// `p = 2*w - 1` the error `e <= d - 1` and each `nc <= 2^w - 1`, so
/// `e * nc <= (2^(w-1) - 1) * (2^w - 1) < 2^(2w-1)`.
fn search(d: u128, w: u32, bounds: &[Bound]) -> (u32, u128) {
    debug_assert!(d <= (1u128 << (w - 1)));
    for p in w..(2 * w) {
        let pow = 1u128 << p;
        let m = pow.div_ceil(d);
        let e = m * d - pow;
        let ok = bounds.iter().all(|b| {
            let lhs = e * b.nc;
            if b.strict { lhs < pow } else { lhs <= pow }
        });
        if ok {
            return (p, m);
        }
    }
    unreachable!("magic search exceeded 2^(2w)")
}

/// Lowering shape for an unsigned constant divide.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct UnsignedMagic {
    /// Multiplier, always below `2^w`. In the `add` form this is the
    /// true multiplier minus `2^w`.
    pub(crate) m: u64,
    /// True when the true multiplier needs `w + 1` bits, so the
    /// sequence takes the add-back fixup.
    pub(crate) add: bool,
    /// Post-multiply right shift. Plain form: `mulhu(n, m) >>u shift`.
    /// Add-back form: `t = mulhu(n, m); (((n - t) >>u 1) + t) >>u shift`.
    pub(crate) shift: u32,
}

/// Multiplier and shift for `n / d` over `n` in `[0, 2^num_bits)`.
///
/// `num_bits` is the numerator's known width, which is `w` unless a
/// pre-shift narrowed it. `d` must be at least 3 and below `2^(w-1)`;
/// divisors 1 and 2 (and every other power of two) lower to a shift,
/// and a divisor above `2^(w-1)` admits only quotients 0 and 1, which
/// lower to a compare.
pub(crate) fn magic_unsigned(d: u64, w: u32, num_bits: u32) -> UnsignedMagic {
    debug_assert!(d >= 3 && !d.is_power_of_two());
    debug_assert!(d < (1u64 << (w - 1)));
    debug_assert!(w == 32 || w == 64);
    debug_assert!(num_bits > 0 && num_bits <= w);
    let nmax = (1u128 << num_bits) - 1;
    let d = d as u128;
    debug_assert!(d <= nmax);
    let (p, m) = search(
        d,
        w,
        &[Bound {
            nc: worst_case(nmax, d),
            strict: true,
        }],
    );
    if m < (1u128 << w) {
        UnsignedMagic {
            m: m as u64,
            add: false,
            shift: p - w,
        }
    } else {
        // The add-back form recovers `floor(n*m / 2^w)` from the
        // truncated multiplier: with `t = mulhu(n, m - 2^w) = T - n`,
        // `((n - t) >>u 1) + t == floor(T / 2)`, so one fewer shift
        // step reaches `floor(n*m / 2^p)`. `p > w` whenever the
        // multiplier overflows, so the shift stays non-negative.
        debug_assert!(m < (1u128 << (w + 1)) && p > w);
        UnsignedMagic {
            m: (m - (1u128 << w)) as u64,
            add: true,
            shift: p - w - 1,
        }
    }
}

/// Lowering shape for a signed constant divide by a positive divisor.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct SignedMagic {
    /// Multiplier, always below `2^w`. When it reaches `2^(w-1)` the
    /// `w`-bit high-multiply reads it as a negative value, so that
    /// form takes an add-back fixup; a `2*w`-bit multiply does not.
    pub(crate) m: u64,
    /// Post-multiply arithmetic right shift applied to
    /// `floor(n * m / 2^w)`.
    pub(crate) shift: u32,
}

/// Multiplier and shift for `n / d` over the full signed `w`-bit range,
/// with `d` positive. A negative divisor uses `|d|` and negates the
/// quotient. `d` must be at least 3 and not a power of two.
///
/// The sequence is `q = floor(n * m / 2^p)` followed by adding one when
/// `q` is negative, which turns the floor into C99 6.5.5p6 truncation.
pub(crate) fn magic_signed(d: u64, w: u32) -> SignedMagic {
    debug_assert!(d >= 3 && !d.is_power_of_two());
    debug_assert!(w == 32 || w == 64);
    let d = d as u128;
    debug_assert!(d < (1u128 << (w - 1)));
    // Positive numerators need `e * nc < 2^p`, as unsigned. Negative
    // numerators need `e * |n| <= (d - r) * 2^p`, non-strict because
    // the floor is allowed to land exactly on the quotient below; the
    // magnitude range there reaches `2^(w-1)` rather than `2^(w-1) - 1`.
    let (p, m) = search(
        d,
        w,
        &[
            Bound {
                nc: worst_case((1u128 << (w - 1)) - 1, d),
                strict: true,
            },
            Bound {
                nc: worst_case(1u128 << (w - 1), d),
                strict: false,
            },
        ],
    );
    debug_assert!(m < (1u128 << w));
    SignedMagic {
        m: m as u64,
        shift: p - w,
    }
}

/// Receiver for the constant-divide lowering. The SSA builder emits the
/// sequence; the derivation tests evaluate it through the VM's binop
/// semantics. Both drive [`lower_divmod`], so the emitted code and the
/// tested code are the same code.
pub(crate) trait DivSink {
    type Val: Copy;
    fn imm(&mut self, k: i64) -> Self::Val;
    fn binop(&mut self, op: BinOp, lhs: Self::Val, rhs: Self::Val) -> Self::Val;
    fn binop_imm(&mut self, op: BinOp, lhs: Self::Val, rhs: i64) -> Self::Val;
}

/// `log2(x)` when `x` is a power of two.
fn pow2_log(x: u64) -> Option<u32> {
    x.is_power_of_two().then(|| x.trailing_zeros())
}

/// `floor(n * m / 2^w)` for unsigned operands. At `w == 64` this is the
/// high-multiply opcode; at `w == 32` the whole product fits in the
/// register, so it is a multiply and a shift -- and when the caller
/// follows with another right shift, `extra` folds the two into one.
fn mulhu<S: DivSink>(s: &mut S, n: S::Val, m: u64, w: u32, extra: u32) -> S::Val {
    if w == 64 {
        let mv = s.imm(m as i64);
        let hi = s.binop(BinOp::Mulhu, n, mv);
        s.binop_imm(BinOp::Shru, hi, extra as i64)
    } else {
        let prod = s.binop_imm(BinOp::Mul, n, m as i64);
        s.binop_imm(BinOp::Shru, prod, (32 + extra) as i64)
    }
}

/// Unsigned `n / d` for a non-power-of-two `d` below `2^w`.
fn udiv_magic<S: DivSink>(s: &mut S, n: S::Val, d: u64, w: u32) -> S::Val {
    // An even divisor can pre-shift the numerator: `n / d ==
    // (n >>u tz) / (d >>u tz)`. The narrower numerator often admits a
    // `w`-bit multiplier where the full range needed `w + 1`, trading
    // the four-instruction add-back fixup for one shift.
    let tz = d.trailing_zeros();
    if tz > 0 {
        let odd = magic_unsigned(d >> tz, w, w - tz);
        if !odd.add {
            let pre = s.binop_imm(BinOp::Shru, n, tz as i64);
            return mulhu(s, pre, odd.m, w, odd.shift);
        }
    }
    let mag = magic_unsigned(d, w, w);
    if !mag.add {
        return mulhu(s, n, mag.m, w, mag.shift);
    }
    // Add-back: the true multiplier needs `w + 1` bits, so the
    // high-multiply sees it short by `2^w` and returns `t = T - n` for
    // the wanted `T = floor(n*M / 2^w)`. `((n - t) >>u 1) + t` is
    // `floor(T / 2)`, absorbing one step of the remaining shift. Every
    // intermediate stays below `2^w`, so the register-width subtract
    // does not wrap.
    let t = mulhu(s, n, mag.m, w, 0);
    let diff = s.binop(BinOp::Sub, n, t);
    let half = s.binop_imm(BinOp::Shru, diff, 1);
    let sum = s.binop(BinOp::Add, half, t);
    s.binop_imm(BinOp::Shru, sum, mag.shift as i64)
}

/// Signed `n / d` for a positive non-power-of-two `d` below `2^(w-1)`.
fn sdiv_magic<S: DivSink>(s: &mut S, n: S::Val, d: u64, w: u32) -> S::Val {
    let mag = magic_signed(d, w);
    let q0 = if w == 64 {
        // A `w`-bit high-multiply reads a multiplier at or above
        // `2^(w-1)` as negative, returning `floor(n*m / 2^w) - n`;
        // adding `n` back recovers the wanted value.
        let mv = s.imm(mag.m as i64);
        let hi = s.binop(BinOp::Mulh, n, mv);
        let hi = if mag.m >> (w - 1) != 0 {
            s.binop(BinOp::Add, hi, n)
        } else {
            hi
        };
        s.binop_imm(BinOp::Shr, hi, mag.shift as i64)
    } else {
        // The 32-bit product fits in the register, so the multiplier
        // is used at its true positive value and needs no fixup.
        let prod = s.binop_imm(BinOp::Mul, n, mag.m as i64);
        s.binop_imm(BinOp::Shr, prod, (32 + mag.shift) as i64)
    };
    // The shift floors; C99 6.5.5p6 truncates toward zero. The two
    // agree on non-negative quotients and differ by one below zero.
    let sign = s.binop_imm(BinOp::Shru, q0, 63);
    s.binop(BinOp::Add, q0, sign)
}

/// Bias a numerator by `2^k - 1` when it is negative, so the following
/// arithmetic shift by `k` truncates toward zero instead of flooring.
/// Returns the biased numerator and the bias; the modulo sequence
/// subtracts the bias back out.
fn sdiv_pow2_bias<S: DivSink>(s: &mut S, n: S::Val, k: u32) -> (S::Val, S::Val) {
    let sign = s.binop_imm(BinOp::Shr, n, 63);
    let bias = s.binop_imm(BinOp::Shru, sign, (64 - k) as i64);
    (s.binop(BinOp::Add, n, bias), bias)
}

fn negate<S: DivSink>(s: &mut S, v: S::Val) -> S::Val {
    let zero = s.imm(0);
    s.binop(BinOp::Sub, zero, v)
}

/// Lower `n op d` for a compile-time divisor to multiplies and shifts.
/// `w` is the operand width in bits (32 or 64); a narrower operand is
/// already sign- / zero-extended into the 64-bit SSA value, so the
/// sequence evaluates at the exact mathematical value either way.
///
/// Returns `None` for a zero divisor (C99 6.5.5p5 leaves it undefined,
/// and the hardware divide is the honest lowering) and for non-divide
/// opcodes.
pub(crate) fn lower_divmod<S: DivSink>(
    s: &mut S,
    op: BinOp,
    n: S::Val,
    d: i64,
    w: u32,
) -> Option<S::Val> {
    debug_assert!(w == 32 || w == 64);
    match op {
        BinOp::Divu | BinOp::Modu => {
            // A narrow unsigned operand is masked to its width before
            // the divide, so the divisor reads back at that width too.
            let du = if w == 64 {
                d as u64
            } else {
                (d as u64) & 0xffff_ffff
            };
            if du == 0 {
                return None;
            }
            let want_rem = matches!(op, BinOp::Modu);
            if let Some(k) = pow2_log(du) {
                return Some(if want_rem {
                    s.binop_imm(BinOp::And, n, du.wrapping_sub(1) as i64)
                } else {
                    s.binop_imm(BinOp::Shru, n, k as i64)
                });
            }
            // Above 2^(w-1) the only quotients are 0 and 1, so the
            // reciprocal is a compare.
            let q = if du > (1u64 << (w - 1)) {
                s.binop_imm(BinOp::Uge, n, du as i64)
            } else {
                udiv_magic(s, n, du, w)
            };
            if !want_rem {
                return Some(q);
            }
            let qd = s.binop_imm(BinOp::Mul, q, du as i64);
            Some(s.binop(BinOp::Sub, n, qd))
        }
        BinOp::Div | BinOp::Mod => {
            if d == 0 {
                return None;
            }
            let want_rem = matches!(op, BinOp::Mod);
            // `|d|` as an unsigned value so `w`-bit INT_MIN, whose
            // magnitude is not representable signed, stays a power of
            // two rather than wrapping back to itself.
            let ad = d.unsigned_abs();
            if ad == 1 {
                // Divisor +-1: exact, no remainder. `n / -1` overflows
                // at INT_MIN (6.5.5p6 undefined); the negate wraps,
                // matching aarch64 `sdiv`.
                if want_rem {
                    return Some(s.imm(0));
                }
                return Some(if d < 0 { negate(s, n) } else { n });
            }
            if let Some(k) = pow2_log(ad) {
                let (adj, bias) = sdiv_pow2_bias(s, n, k);
                if !want_rem {
                    let q = s.binop_imm(BinOp::Shr, adj, k as i64);
                    return Some(if d < 0 { negate(s, q) } else { q });
                }
                // `n % d == n % -d`, so the remainder ignores the
                // divisor's sign: undo the bias after masking.
                let masked = s.binop_imm(BinOp::And, adj, ad.wrapping_sub(1) as i64);
                return Some(s.binop(BinOp::Sub, masked, bias));
            }
            let q = sdiv_magic(s, n, ad, w);
            let q = if d < 0 { negate(s, q) } else { q };
            if !want_rem {
                return Some(q);
            }
            let qd = s.binop_imm(BinOp::Mul, q, d);
            Some(s.binop(BinOp::Sub, n, qd))
        }
        _ => None,
    }
}

#[cfg(test)]
mod tests;

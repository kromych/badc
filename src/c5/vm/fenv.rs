//! IEC 60559 arithmetic for the interpreter (C99 Annex F): each floating
//! operation rounds in the program's rounding direction and raises the
//! exceptions the target's floating-point unit raises, which the
//! `<fenv.h>` functions read and set.
//!
//! Values are `f64` bit patterns, a `float` the `f64` of its value. Each
//! operation forms its exact result -- integer significand, exponent and a
//! sticky bit for any part below -- and [`FpEnv::round`] rounds it once.

use crate::c5::codegen::Target;

pub(super) const INVALID: u8 = 1;
pub(super) const DIVBYZERO: u8 = 2;
pub(super) const OVERFLOW: u8 = 4;
pub(super) const UNDERFLOW: u8 = 8;
pub(super) const INEXACT: u8 = 16;

const SIGN: u64 = 1 << 63;
const QUIET: u64 = 1 << 51;
const EXP_MASK: u64 = 0x7ff0_0000_0000_0000;

/// A rounding direction (IEC 60559 4.3).
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum Round {
    Nearest,
    Up,
    Down,
    Zero,
}

/// A binary format's precision and normal exponent range.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) struct Format {
    p: u32,
    emin: i32,
    emax: i32,
}

pub(super) const BINARY64: Format = Format {
    p: 53,
    emin: -1022,
    emax: 1023,
};
pub(super) const BINARY32: Format = Format {
    p: 24,
    emin: -126,
    emax: 127,
};

/// An integer conversion's result for a NaN or an out-of-range value:
/// x86-64's integer indefinite (the minimum), AArch64's nearest bound (0
/// for a NaN), or the UCRT `lrint` family's zero.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum OutOfRange {
    Minimum,
    Saturate,
    Zero,
}

/// The floating-point environment of an interpreted program, and the
/// choices IEC 60559 leaves to the target.
#[derive(Clone, Debug)]
pub(super) struct FpEnv {
    pub(super) round: Round,
    pub(super) flags: u8,
    target: Target,
    /// AArch64 detects tininess before rounding, x86-64 after (7.5).
    tiny_before_rounding: bool,
    /// The NaN an invalid operation delivers.
    default_nan: u64,
    convert_out_of_range: OutOfRange,
    lrint_out_of_range: OutOfRange,
}

/// A finite nonzero operand or exact result: sign, significand and the
/// exponent of its least significant bit.
type Term = (bool, u128, i32);

enum Class {
    Zero,
    Finite(u64, i32),
    Inf,
    Nan,
}

fn class(bits: u64) -> Class {
    let e = ((bits >> 52) & 0x7ff) as i32;
    let m = bits & ((1 << 52) - 1);
    match (e, m) {
        (0, 0) => Class::Zero,
        (0, m) => Class::Finite(m, -1074),
        (0x7ff, 0) => Class::Inf,
        (0x7ff, _) => Class::Nan,
        (e, m) => Class::Finite(m | 1 << 52, e - 1075),
    }
}

fn negative(bits: u64) -> bool {
    bits & SIGN != 0
}

pub(super) fn is_nan(bits: u64) -> bool {
    bits & EXP_MASK == EXP_MASK && bits & !(SIGN | EXP_MASK) != 0
}

fn is_snan(bits: u64) -> bool {
    is_nan(bits) && bits & QUIET == 0
}

fn signed(neg: bool, magnitude: u64) -> u64 {
    if neg { magnitude | SIGN } else { magnitude }
}

fn top_bit(t: &Term) -> i32 {
    t.2 + 127 - t.1.leading_zeros() as i32
}

/// `sig` without its low `sh` bits: the kept part, the bit just below it
/// and whether anything nonzero (or `sticky`) lies further below.
fn shift_round(sig: u128, sh: i32, sticky: bool) -> (u128, bool, bool) {
    if sh <= 0 {
        return (sig << -sh, false, sticky);
    }
    if sh >= 128 {
        let half = sh == 128 && sig >> 127 != 0;
        let rest = if sh == 128 { sig << 1 != 0 } else { sig != 0 };
        return (0, half, rest || sticky);
    }
    let half = (sig >> (sh - 1)) & 1 != 0;
    let rest = sh > 1 && sig & ((1 << (sh - 1)) - 1) != 0;
    (sig >> sh, half, rest || sticky)
}

/// The `f64` bit pattern of `+/-kept * 2^q`, already rounded to fit.
fn pack(neg: bool, kept: u128, q: i32) -> u64 {
    if kept == 0 {
        return signed(neg, 0);
    }
    let lead = 127 - kept.leading_zeros() as i32;
    let e = q + lead;
    let bits = if e >= -1022 {
        let m = (kept << (52 - lead)) as u64 & ((1 << 52) - 1);
        ((e + 1023) as u64) << 52 | m
    } else {
        (kept << (q + 1074)) as u64
    };
    signed(neg, bits)
}

/// The significand and exponent of a finite nonzero value.
fn finite(bits: u64) -> (u128, i32) {
    match class(bits) {
        Class::Finite(s, e) => (u128::from(s), e),
        _ => (0, 0),
    }
}

/// Whether `m * 2^e` equals `n * 2^d`.
fn equal_scaled(m: u128, e: i32, (n, d): (u128, i32)) -> bool {
    let (scaled, other, sh) = if e >= d { (m, n, e - d) } else { (n, m, d - e) };
    sh < 128 && scaled.leading_zeros() as i32 >= sh && scaled << sh == other
}

fn normalized(s: u64, e: i32) -> (u64, i32) {
    let sh = s.leading_zeros() as i32 - 11;
    (s << sh, e - sh)
}

/// `floor(sqrt(n))` and whether the root is inexact.
fn isqrt(n: u128) -> (u128, bool) {
    let mut r = (libm::sqrt(n as f64) as u128).max(1);
    r = (r + n / r) / 2;
    while r * r > n {
        r -= 1;
    }
    while (r + 1) * (r + 1) <= n {
        r += 1;
    }
    (r, r * r != n)
}

impl FpEnv {
    pub(super) fn new(target: Target) -> Self {
        let aarch64 = target.is_aarch64();
        let lrint_out_of_range = match target {
            Target::WindowsX64 | Target::WindowsAarch64 => OutOfRange::Zero,
            _ if aarch64 => OutOfRange::Saturate,
            _ => OutOfRange::Minimum,
        };
        Self {
            round: Round::Nearest,
            flags: 0,
            target,
            tiny_before_rounding: aarch64,
            default_nan: if aarch64 {
                0x7ff8_0000_0000_0000
            } else {
                0xfff8_0000_0000_0000
            },
            convert_out_of_range: if aarch64 {
                OutOfRange::Saturate
            } else {
                OutOfRange::Minimum
            },
            lrint_out_of_range,
        }
    }

    fn round_up(&self, neg: bool, kept: u128, half: bool, rest: bool) -> bool {
        match self.round {
            Round::Nearest => half && (rest || kept & 1 != 0),
            Round::Up => !neg && (half || rest),
            Round::Down => neg && (half || rest),
            Round::Zero => false,
        }
    }

    /// Round `+/-sig * 2^exp`, plus a nonzero amount below `2^exp` when
    /// `sticky`, to `f`; `sig` is nonzero.
    pub(super) fn round(&mut self, neg: bool, sig: u128, exp: i32, sticky: bool, f: Format) -> u64 {
        let top = top_bit(&(neg, sig, exp));
        let p = f.p as i32;
        let mut q = (top - (p - 1)).max(f.emin - (p - 1));
        let (mut kept, half, rest) = shift_round(sig, q - exp, sticky);
        if self.round_up(neg, kept, half, rest) {
            kept += 1;
            if kept >> p != 0 {
                kept >>= 1;
                q += 1;
            }
        }
        if half || rest {
            self.flags |= INEXACT;
            if self.tiny(neg, sig, exp, sticky, top, f) {
                self.flags |= UNDERFLOW;
            }
        }
        if kept != 0 && q + 127 - kept.leading_zeros() as i32 > f.emax {
            self.flags |= OVERFLOW | INEXACT;
            return self.overflowed(neg, f);
        }
        pack(neg, kept, q)
    }

    /// Whether an exact value with top bit `top` is below the smallest
    /// normal, before rounding or after it with an unbounded exponent.
    fn tiny(&self, neg: bool, sig: u128, exp: i32, sticky: bool, top: i32, f: Format) -> bool {
        if top >= f.emin {
            return false;
        }
        if self.tiny_before_rounding || top < f.emin - 1 {
            return true;
        }
        let (kept, half, rest) = shift_round(sig, top - (f.p as i32 - 1) - exp, sticky);
        (kept + self.round_up(neg, kept, half, rest) as u128) >> f.p == 0
    }

    fn overflowed(&self, neg: bool, f: Format) -> u64 {
        let max = if f == BINARY64 {
            0x7fef_ffff_ffff_ffff
        } else {
            (f32::MAX as f64).to_bits()
        };
        let infinite = match self.round {
            Round::Nearest => true,
            Round::Zero => false,
            Round::Up => !neg,
            Round::Down => neg,
        };
        signed(neg, if infinite { EXP_MASK } else { max })
    }

    fn invalid(&mut self) -> u64 {
        self.flags |= INVALID;
        self.default_nan
    }

    /// The first NaN operand quieted; a signaling one raises invalid.
    fn propagate(&mut self, a: u64, b: u64, f: Format) -> u64 {
        if is_snan(a) || is_snan(b) {
            self.flags |= INVALID;
        }
        let n = if is_nan(a) { a } else { b } | QUIET;
        if f == BINARY32 {
            (f64::from_bits(n) as f32 as f64).to_bits()
        } else {
            n
        }
    }

    /// An exact zero sum of opposite-signed operands (IEC 60559 6.3).
    fn zero_sum(&self) -> u64 {
        signed(self.round == Round::Down, 0)
    }

    /// To nearest, a binary64 result `r` above the smallest normal and
    /// finite is the host's, inexact as `exact` says; `None` otherwise.
    fn nearest(&mut self, f: Format, r: f64, exact: impl Fn() -> bool) -> Option<u64> {
        let fast = self.round == Round::Nearest
            && f == BINARY64
            && r.abs() > f64::MIN_POSITIVE
            && r.abs() <= f64::MAX;
        if fast && !exact() {
            self.flags |= INEXACT;
        }
        fast.then(|| r.to_bits())
    }

    pub(super) fn add(&mut self, a: u64, b: u64, f: Format) -> u64 {
        let (x, y) = (f64::from_bits(a), f64::from_bits(b));
        let s = x + y;
        // The error of a rounded sum is representable (Knuth's TwoSum).
        let exact = || {
            let t = s - x;
            (x - (s - t)) + (y - t) == 0.0
        };
        if let Some(r) = self.nearest(f, s, exact) {
            return r;
        }
        match (class(a), class(b)) {
            (Class::Nan, _) | (_, Class::Nan) => self.propagate(a, b, f),
            (Class::Inf, Class::Inf) if negative(a) != negative(b) => self.invalid(),
            (Class::Inf, _) => a,
            (_, Class::Inf) => b,
            (Class::Zero, Class::Zero) if negative(a) != negative(b) => self.zero_sum(),
            (Class::Zero, _) => b,
            (_, Class::Zero) => a,
            (Class::Finite(sa, ea), Class::Finite(sb, eb)) => {
                let ta = (negative(a), u128::from(sa), ea);
                self.sum(ta, (negative(b), u128::from(sb), eb), f)
            }
        }
    }

    pub(super) fn sub(&mut self, a: u64, b: u64, f: Format) -> u64 {
        self.add(a, if is_nan(b) { b } else { b ^ SIGN }, f)
    }

    /// The rounded sum of two finite nonzero terms, the larger's top bit
    /// placed at bit 125: only the smaller loses bits, far below the cut.
    fn sum(&mut self, a: Term, b: Term, f: Format) -> u64 {
        let base = top_bit(&a).max(top_bit(&b)) - 125;
        let align = |(neg, s, e): Term| -> (bool, u128, bool) {
            let sh = e - base;
            if sh >= 0 {
                (neg, s << sh, false)
            } else if sh <= -128 {
                (neg, 0, true)
            } else {
                (neg, s >> -sh, s & ((1 << -sh) - 1) != 0)
            }
        };
        let ((na, va, la), (nb, vb, lb)) = (align(a), align(b));
        if na == nb {
            return self.round(na, va + vb, base, la || lb, f);
        }
        let (neg, big, small, lost) = if va > vb {
            (na, va, vb, lb)
        } else {
            (nb, vb, va, la)
        };
        if big == small {
            return self.zero_sum();
        }
        let diff = big - small - u128::from(lost);
        self.round(neg, diff, base, lost, f)
    }

    pub(super) fn mul(&mut self, a: u64, b: u64, f: Format) -> u64 {
        let p = f64::from_bits(a) * f64::from_bits(b);
        let exact = || {
            let ((sa, _), (sb, _)) = (finite(a), finite(b));
            let prod = sa * sb;
            let below = (128 - prod.leading_zeros()).saturating_sub(53);
            prod & ((1 << below) - 1) == 0
        };
        if let Some(r) = self.nearest(f, p, exact) {
            return r;
        }
        let neg = negative(a) != negative(b);
        match (class(a), class(b)) {
            (Class::Nan, _) | (_, Class::Nan) => self.propagate(a, b, f),
            (Class::Inf, Class::Zero) | (Class::Zero, Class::Inf) => self.invalid(),
            (Class::Inf, _) | (_, Class::Inf) => signed(neg, EXP_MASK),
            (Class::Zero, _) | (_, Class::Zero) => signed(neg, 0),
            (Class::Finite(sa, ea), Class::Finite(sb, eb)) => {
                self.round(neg, u128::from(sa) * u128::from(sb), ea + eb, false, f)
            }
        }
    }

    pub(super) fn div(&mut self, a: u64, b: u64, f: Format) -> u64 {
        let q = f64::from_bits(a) / f64::from_bits(b);
        // Exact when the quotient times the divisor gives the dividend back.
        let exact = || {
            let ((sq, eq), (sb, eb)) = (finite(q.to_bits()), finite(b));
            equal_scaled(sq * sb, eq + eb, finite(a))
        };
        if let Some(r) = self.nearest(f, q, exact) {
            return r;
        }
        let neg = negative(a) != negative(b);
        match (class(a), class(b)) {
            (Class::Nan, _) | (_, Class::Nan) => self.propagate(a, b, f),
            (Class::Inf, Class::Inf) | (Class::Zero, Class::Zero) => self.invalid(),
            (Class::Inf, _) => signed(neg, EXP_MASK),
            (_, Class::Inf) | (Class::Zero, _) => signed(neg, 0),
            (_, Class::Zero) => {
                self.flags |= DIVBYZERO;
                signed(neg, EXP_MASK)
            }
            (Class::Finite(sa, ea), Class::Finite(sb, eb)) => {
                let ((sa, ea), (sb, eb)) = (normalized(sa, ea), normalized(sb, eb));
                let num = u128::from(sa) << 74;
                let rem = num % u128::from(sb) != 0;
                self.round(neg, num / u128::from(sb), ea - 74 - eb, rem, f)
            }
        }
    }

    pub(super) fn sqrt(&mut self, a: u64, f: Format) -> u64 {
        let r = libm::sqrt(f64::from_bits(a));
        let exact = || {
            let (sr, er) = finite(r.to_bits());
            equal_scaled(sr * sr, 2 * er, finite(a))
        };
        if let Some(r) = self.nearest(f, r, exact) {
            return r;
        }
        match class(a) {
            Class::Nan => self.propagate(a, a, f),
            Class::Zero => a,
            _ if negative(a) => self.invalid(),
            Class::Inf => a,
            Class::Finite(s, e) => {
                let (s, e) = normalized(s, e);
                let (n, e) = if e & 1 != 0 {
                    (u128::from(s) << 73, e - 73)
                } else {
                    (u128::from(s) << 72, e - 72)
                };
                let (r, inexact) = isqrt(n);
                self.round(false, r, e / 2, inexact, f)
            }
        }
    }

    /// `a * b + c` rounded once (C99 7.12.13.1).
    pub(super) fn fma(&mut self, a: u64, b: u64, c: u64, f: Format) -> u64 {
        let np = negative(a) != negative(b);
        match (class(a), class(b), class(c)) {
            (Class::Nan, ..) | (_, Class::Nan, _) => self.propagate(a, b, f),
            (.., Class::Nan) => self.propagate(c, c, f),
            (Class::Inf, Class::Zero, _) | (Class::Zero, Class::Inf, _) => self.invalid(),
            (Class::Inf, ..) | (_, Class::Inf, _) => {
                if matches!(class(c), Class::Inf) && negative(c) != np {
                    self.invalid()
                } else {
                    signed(np, EXP_MASK)
                }
            }
            (.., Class::Inf) => c,
            (Class::Zero, ..) | (_, Class::Zero, _) => self.add(signed(np, 0), c, f),
            (Class::Finite(sa, ea), Class::Finite(sb, eb), cc) => {
                let product = (np, u128::from(sa) * u128::from(sb), ea + eb);
                match cc {
                    Class::Finite(sc, ec) => {
                        self.sum(product, (negative(c), u128::from(sc), ec), f)
                    }
                    _ => self.round(product.0, product.1, product.2, false, f),
                }
            }
        }
    }

    /// A `double` converted to `float` (C99 6.3.1.5).
    pub(super) fn narrow(&mut self, a: u64) -> u64 {
        match class(a) {
            Class::Nan => self.propagate(a, a, BINARY32),
            Class::Zero | Class::Inf => a,
            Class::Finite(s, e) => self.round(negative(a), u128::from(s), e, false, BINARY32),
        }
    }

    /// An integer converted to a floating type (C99 6.3.1.4p2).
    pub(super) fn int_to_float(&mut self, n: i128, f: Format) -> u64 {
        if n == 0 {
            return 0;
        }
        self.round(n < 0, n.unsigned_abs(), 0, false, f)
    }

    /// A value truncated to a 64-bit integer type (C99 6.3.1.4p1): inexact
    /// for a dropped fraction, invalid when the integral part does not fit.
    pub(super) fn float_to_int(&mut self, a: u64, is_signed: bool) -> i64 {
        let truncated = match class(a) {
            Class::Zero => Some(0i128),
            Class::Finite(s, e) if e >= 0 => (e < 64).then(|| i128::from(s) << e),
            Class::Finite(s, e) => {
                let (kept, half, rest) = shift_round(u128::from(s), -e, false);
                if half || rest {
                    self.flags |= INEXACT;
                }
                Some(kept as i128)
            }
            Class::Inf | Class::Nan => None,
        }
        .map(|v| if negative(a) { -v } else { v });
        let (lo, hi) = if is_signed {
            (i128::from(i64::MIN), i128::from(i64::MAX))
        } else {
            (0, i128::from(u64::MAX))
        };
        self.fit(a, truncated, lo, hi, self.convert_out_of_range)
    }

    /// Integral `v` (`None` for an infinity or NaN `a`) within `lo..=hi`.
    fn fit(&mut self, a: u64, v: Option<i128>, lo: i128, hi: i128, oor: OutOfRange) -> i64 {
        match v {
            Some(v) if (lo..=hi).contains(&v) => v as i64,
            _ => {
                self.flags |= INVALID;
                match oor {
                    OutOfRange::Minimum => lo.min(i128::from(i64::MIN)) as i64,
                    OutOfRange::Zero => 0,
                    OutOfRange::Saturate if is_nan(a) => 0,
                    OutOfRange::Saturate if negative(a) => lo as i64,
                    OutOfRange::Saturate => hi as i64,
                }
            }
        }
    }

    /// `rint`, which raises inexact, and `nearbyint`, which does not
    /// (C99 7.12.9.3-4).
    pub(super) fn round_integral(&mut self, a: u64, raise_inexact: bool) -> u64 {
        match class(a) {
            Class::Nan => self.propagate(a, a, BINARY64),
            Class::Finite(s, e) if e < 0 => {
                let neg = negative(a);
                let (kept, half, rest) = shift_round(u128::from(s), -e, false);
                let kept = kept + self.round_up(neg, kept, half, rest) as u128;
                if raise_inexact && (half || rest) {
                    self.flags |= INEXACT;
                }
                pack(neg, kept, 0)
            }
            _ => a,
        }
    }

    /// `lrint` / `llrint` into a `bits`-wide integer (C99 7.12.9.5).
    pub(super) fn lrint(&mut self, a: u64, bits: u32) -> i64 {
        let r = self.round_integral(a, true);
        let v = match class(r) {
            Class::Zero => Some(0),
            Class::Finite(s, e) if e < 64 => {
                let v = i128::from(if e < 0 { s >> -e } else { s }) << e.max(0);
                Some(if negative(r) { -v } else { v })
            }
            _ => None,
        };
        let hi = (1i128 << (bits - 1)) - 1;
        self.fit(a, v, -hi - 1, hi, self.lrint_out_of_range)
    }

    /// A quiet comparison: only a signaling NaN raises invalid (5.11).
    pub(super) fn compare_operands(&mut self, a: u64, b: u64) {
        if is_snan(a) || is_snan(b) {
            self.flags |= INVALID;
        }
    }
}

/// The bundled `<fenv.h>` macros and the C library's `fenv_t` layouts.
impl FpEnv {
    /// `FE_TONEAREST`, `FE_UPWARD`, `FE_DOWNWARD`, `FE_TOWARDZERO`.
    fn round_macros(&self) -> [i32; 4] {
        match self.target {
            Target::LinuxX64 => [0, 0x800, 0x400, 0xc00],
            Target::WindowsX64 | Target::WindowsAarch64 => [0, 0x200, 0x100, 0x300],
            Target::LinuxAarch64 | Target::MacOSAarch64 => [0, 0x40_0000, 0x80_0000, 0xc0_0000],
        }
    }

    /// `FE_INVALID`, `FE_DIVBYZERO`, `FE_OVERFLOW`, `FE_UNDERFLOW`, `FE_INEXACT`.
    fn flag_macros(&self) -> [i32; 5] {
        match self.target {
            Target::LinuxX64 => [0x01, 0x04, 0x08, 0x10, 0x20],
            Target::WindowsX64 | Target::WindowsAarch64 => [0x10, 0x08, 0x04, 0x02, 0x01],
            Target::LinuxAarch64 | Target::MacOSAarch64 => [0x01, 0x02, 0x04, 0x08, 0x10],
        }
    }

    /// The flags `excepts` names, in the `FE_*` encoding.
    pub(super) fn test(&self, excepts: i32) -> i32 {
        let m = self.flag_macros();
        (0..5)
            .filter(|&i| self.flags & (1 << i) != 0)
            .map(|i| m[i])
            .fold(0, |acc, v| acc | v)
            & excepts
    }

    /// The internal flag bits `excepts` names.
    pub(super) fn flags_of(&self, excepts: i32) -> u8 {
        let m = self.flag_macros();
        (0..5)
            .filter(|&i| excepts & m[i] != 0)
            .fold(0, |acc, i| acc | 1 << i)
    }

    pub(super) fn clear(&mut self, excepts: i32) {
        self.flags &= !self.flags_of(excepts);
    }

    /// `feraiseexcept`: AArch64's C libraries and the UCRT raise overflow
    /// and underflow by an operation that also raises inexact.
    pub(super) fn raise(&mut self, excepts: i32) {
        let mut f = self.flags_of(excepts);
        if f & (OVERFLOW | UNDERFLOW) != 0 && self.target != Target::LinuxX64 {
            f |= INEXACT;
        }
        self.flags |= f;
    }

    pub(super) fn get_round(&self) -> i32 {
        let m = self.round_macros();
        m[self.round as usize]
    }

    /// `fesetround`; false for a value that names no direction.
    pub(super) fn set_round(&mut self, value: i32) -> bool {
        let dirs = [Round::Nearest, Round::Up, Round::Down, Round::Zero];
        match self.round_macros().iter().position(|&m| m == value) {
            Some(i) => {
                self.round = dirs[i];
                true
            }
            None => false,
        }
    }

    pub(super) fn except_size(&self) -> usize {
        match self.target {
            Target::LinuxX64 | Target::MacOSAarch64 => 2,
            _ => 4,
        }
    }

    /// The `fenv_t` image of the environment.
    pub(super) fn env_image(&self) -> alloc::vec::Vec<u8> {
        let (round, flags) = (self.get_round() as u32, self.test(!0) as u32);
        let mut img = alloc::vec::Vec::new();
        match self.target {
            Target::LinuxX64 => {
                img.resize(32, 0);
                img[0..2].copy_from_slice(&(0x037f | round as u16).to_le_bytes());
                img[4..6].copy_from_slice(&(flags as u16).to_le_bytes());
                img[8..10].copy_from_slice(&0xffffu16.to_le_bytes());
                img[28..32].copy_from_slice(&(0x1f80 | round << 3 | flags).to_le_bytes());
            }
            Target::LinuxAarch64 => {
                img.extend(round.to_le_bytes());
                img.extend(flags.to_le_bytes());
            }
            Target::MacOSAarch64 => {
                img.extend(u64::from(flags).to_le_bytes());
                img.extend(u64::from(round).to_le_bytes());
            }
            Target::WindowsX64 | Target::WindowsAarch64 => {
                let masks = if self.target == Target::WindowsX64 {
                    0x3f00_003f
                } else {
                    0x3f
                };
                img.extend((masks | round).to_le_bytes());
                img.extend(flags.to_le_bytes());
            }
        }
        img
    }

    pub(super) fn env_size(&self) -> usize {
        self.env_image().len()
    }

    /// Install the environment an `fenv_t` image holds.
    pub(super) fn set_env_image(&mut self, img: &[u8]) {
        let word = |at: usize, n: usize| -> i32 {
            let mut b = [0u8; 4];
            b[..n].copy_from_slice(&img[at..at + n]);
            i32::from_le_bytes(b)
        };
        let (round, flags) = match self.target {
            Target::LinuxX64 => (word(0, 2) & 0xc00, word(4, 2) | word(28, 4)),
            Target::LinuxAarch64 => (word(0, 4), word(4, 4)),
            Target::MacOSAarch64 => (word(8, 4), word(0, 4)),
            Target::WindowsX64 | Target::WindowsAarch64 => (word(0, 4), word(4, 4)),
        };
        let dirs = self.round_macros();
        let pick = dirs.iter().position(|&m| m == round & dirs[3]).unwrap_or(0);
        self.set_round(dirs[pick]);
        self.flags = self.flags_of(flags);
    }

    /// The default environment `FE_DFL_ENV` names.
    pub(super) fn set_default_env(&mut self) {
        self.round = Round::Nearest;
        self.flags = 0;
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const DIRECTIONS: [Round; 4] = [Round::Nearest, Round::Up, Round::Down, Round::Zero];

    fn env(target: Target, round: Round) -> FpEnv {
        let mut e = FpEnv::new(target);
        e.round = round;
        e
    }

    /// `op` in direction `r`: the result and the flags it raised.
    fn run(r: Round, op: impl Fn(&mut FpEnv) -> u64) -> (f64, u8) {
        let mut e = env(Target::LinuxX64, r);
        (f64::from_bits(op(&mut e)), e.flags)
    }

    fn bits(x: f64) -> u64 {
        x.to_bits()
    }

    /// A deterministic spread of finite values over the whole exponent
    /// range, subnormals included.
    fn samples() -> alloc::vec::Vec<f64> {
        let mut s = 0x2545_f491_4f6c_dd1du64;
        (0..4000)
            .map(|_| {
                s ^= s << 13;
                s ^= s >> 7;
                s ^= s << 17;
                f64::from_bits(s & !EXP_MASK | (s % 0x7ff) << 52)
            })
            .chain([0.0, -0.0, 1.0, 3.0, f64::MIN_POSITIVE, 5e-324, f64::MAX])
            .collect()
    }

    /// Equal bits, or both NaN: a NaN's sign and payload are the host's.
    fn same(got: u64, want: f64) -> bool {
        got == bits(want) || (is_nan(got) && want.is_nan())
    }

    #[test]
    fn to_nearest_matches_the_host() {
        let v = samples();
        let mut e = env(Target::LinuxX64, Round::Nearest);
        for w in v.windows(3) {
            let (a, b, c) = (w[0], w[1], w[2]);
            assert!(
                same(e.add(bits(a), bits(b), BINARY64), a + b),
                "{a:e} + {b:e}"
            );
            assert!(
                same(e.mul(bits(a), bits(b), BINARY64), a * b),
                "{a:e} * {b:e}"
            );
            assert!(
                same(e.div(bits(a), bits(b), BINARY64), a / b),
                "{a:e} / {b:e}"
            );
            let r = libm::fma(a, b, c);
            assert!(same(e.fma(bits(a), bits(b), bits(c), BINARY64), r), "fma");
            assert!(same(e.sqrt(bits(a.abs()), BINARY64), libm::sqrt(a.abs())));
            let (fa, fb) = (a as f32, b as f32);
            let wide = |x: f32| bits(f64::from(x));
            let same32 = |got: u64, want: f32| same(got, f64::from(want));
            assert!(
                same32(e.add(wide(fa), wide(fb), BINARY32), fa + fb),
                "{fa:e} + {fb:e}"
            );
            assert!(same32(e.mul(wide(fa), wide(fb), BINARY32), fa * fb));
            assert!(same32(e.div(wide(fa), wide(fb), BINARY32), fa / fb));
            assert!(same32(e.narrow(bits(a)), a as f32), "narrow {a:e}");
        }
    }

    /// Down and up agree on an exact result and are adjacent otherwise;
    /// toward zero is the one of smaller magnitude.
    #[test]
    fn the_directed_results_bracket_the_exact_one() {
        let v = samples();
        for w in v.windows(2) {
            let (a, b) = (bits(w[0]), bits(w[1]));
            let ops: [&dyn Fn(&mut FpEnv) -> u64; 4] = [
                &|e| e.add(a, b, BINARY64),
                &|e| e.mul(a, b, BINARY64),
                &|e| e.div(a, b, BINARY64),
                &|e| e.sqrt(a & !SIGN, BINARY64),
            ];
            for op in ops {
                let (near, nf) = run(Round::Nearest, op);
                let (up, _) = run(Round::Up, op);
                let (down, _) = run(Round::Down, op);
                let (zero, _) = run(Round::Zero, op);
                if near.is_nan() {
                    continue;
                }
                assert!(down <= near && near <= up, "{down:e} {near:e} {up:e}");
                if nf & INEXACT == 0 {
                    assert!(down == up && up == near);
                } else if down.is_finite() && up.is_finite() {
                    assert_eq!(libm::nextafter(down, f64::INFINITY), up);
                }
                assert_eq!(zero, if near.is_sign_negative() { up } else { down });
            }
        }
    }

    #[test]
    fn tininess_follows_the_target() {
        // (1 + 2^-52)(1 - 2^-52) 2^-1022 rounds to DBL_MIN: tiny before only.
        let (a, b) = (0x2000_0000_0000_0001, 0x1fff_ffff_ffff_fffe);
        let mut x86 = env(Target::LinuxX64, Round::Nearest);
        let mut arm = env(Target::LinuxAarch64, Round::Nearest);
        assert_eq!(x86.mul(a, b, BINARY64), bits(f64::MIN_POSITIVE));
        assert_eq!(arm.mul(a, b, BINARY64), bits(f64::MIN_POSITIVE));
        assert_eq!((x86.flags, arm.flags), (INEXACT, INEXACT | UNDERFLOW));
        // DBL_MIN (1 - 2^-53) rounds to DBL_MIN and is tiny either way.
        let mut x86 = env(Target::LinuxX64, Round::Nearest);
        let c = bits(f64::from_bits(0x3fef_ffff_ffff_ffff));
        assert_eq!(
            x86.mul(bits(f64::MIN_POSITIVE), c, BINARY64),
            bits(f64::MIN_POSITIVE)
        );
        assert_eq!(x86.flags, INEXACT | UNDERFLOW);
        // Upward, after-rounding tininess uses the upward rounding.
        let mut up = env(Target::LinuxX64, Round::Up);
        assert_eq!(up.mul(a, b, BINARY64), bits(f64::MIN_POSITIVE));
        assert_eq!(up.flags, INEXACT);
    }

    #[test]
    fn subnormal_products_and_quotients_round_once() {
        // 2^-1075 (1 + 2^-51): above the halfway point between 0 and the
        // least subnormal, which a product's rounded error term would miss.
        let a = bits(f64::from_bits(0x3cb0_0000_0000_0001)); // 2^-52 (1 + 2^-52)
        let b = bits(f64::from_bits(0x0000_0000_0000_0001) * 2f64.powi(52) * 0.5);
        for (r, want) in DIRECTIONS.into_iter().zip([1u64, 1, 0, 0]) {
            let (got, flags) = run(r, |e| e.mul(a, b, BINARY64));
            assert_eq!((bits(got), flags), (want, INEXACT | UNDERFLOW), "{r:?}");
        }
        let thirds = [
            0x5_5555_5555_5555,
            0x5_5555_5555_5556,
            0x5_5555_5555_5555,
            0x5_5555_5555_5555,
        ];
        for (r, want) in DIRECTIONS.into_iter().zip(thirds) {
            let (got, flags) = run(r, |e| e.div(bits(f64::MIN_POSITIVE), bits(3.0), BINARY64));
            assert_eq!((bits(got), flags), (want, INEXACT | UNDERFLOW), "{r:?}");
        }
        let (got, flags) = run(Round::Up, |e| {
            e.div(bits(f64::MIN_POSITIVE), bits(2.0), BINARY64)
        });
        assert_eq!((bits(got), flags), (0x0008_0000_0000_0000, 0));
    }

    #[test]
    fn overflow_follows_the_direction() {
        let max = bits(f64::MAX);
        let cases = [
            (Round::Nearest, f64::INFINITY, f64::NEG_INFINITY),
            (Round::Up, f64::INFINITY, -f64::MAX),
            (Round::Down, f64::MAX, f64::NEG_INFINITY),
            (Round::Zero, f64::MAX, -f64::MAX),
        ];
        for (r, pos, neg) in cases {
            let (p, pf) = run(r, |e| e.mul(max, bits(2.0), BINARY64));
            let (n, nf) = run(r, |e| e.mul(max, bits(-2.0), BINARY64));
            assert_eq!(
                (p, n, pf, nf),
                (pos, neg, OVERFLOW | INEXACT, OVERFLOW | INEXACT)
            );
        }
        // DBL_MAX + 2^970 - 2^917 overflows only upward.
        let addend = bits(f64::MAX * 2f64.powi(-54));
        for (r, want) in [(Round::Nearest, f64::MAX), (Round::Up, f64::INFINITY)] {
            let (got, flags) = run(r, |e| e.add(max, addend, BINARY64));
            let ovf = if want.is_infinite() { OVERFLOW } else { 0 };
            assert_eq!((got, flags), (want, ovf | INEXACT));
        }
        let (got, flags) = run(Round::Zero, |e| {
            e.mul(bits(f64::from(f32::MAX)), bits(3.0), BINARY32)
        });
        assert_eq!((got, flags), (f64::from(f32::MAX), OVERFLOW | INEXACT));
    }

    #[test]
    fn an_exact_zero_sum_is_negative_only_downward() {
        for r in DIRECTIONS {
            let neg = r == Round::Down;
            let (a, _) = run(r, |e| e.sub(bits(1.0), bits(1.0), BINARY64));
            let (b, _) = run(r, |e| e.add(bits(0.0), bits(-0.0), BINARY64));
            let (c, _) = run(r, |e| e.add(bits(-0.0), bits(-0.0), BINARY64));
            let (d, _) = run(r, |e| e.fma(bits(0.0), bits(5.0), bits(-0.0), BINARY64));
            assert_eq!([a, b, d].map(f64::is_sign_negative), [neg; 3], "{r:?}");
            assert!(c.is_sign_negative());
        }
    }

    #[test]
    fn conversions_round_in_the_direction() {
        // 2^53 + 1 lies halfway between 2^53 and 2^53 + 2.
        let n = (1i128 << 53) + 1;
        let (lo, hi) = ((1u64 << 53) as f64, ((1u64 << 53) + 2) as f64);
        let pos = [lo, hi, lo, lo];
        let neg = [-lo, -lo, -hi, -lo];
        for ((r, p), q) in DIRECTIONS.into_iter().zip(pos).zip(neg) {
            assert_eq!(
                run(r, |e| e.int_to_float(n, BINARY64)),
                (p, INEXACT),
                "{r:?}"
            );
            assert_eq!(
                run(r, |e| e.int_to_float(-n, BINARY64)),
                (q, INEXACT),
                "{r:?}"
            );
        }
        let mut e = env(Target::LinuxX64, Round::Up);
        assert_eq!(e.float_to_int(bits(-2.5), true), -2);
        assert_eq!(e.flags, INEXACT);
        let mut x86 = env(Target::LinuxX64, Round::Nearest);
        let mut arm = env(Target::LinuxAarch64, Round::Nearest);
        assert_eq!(x86.float_to_int(bits(1e300), true), i64::MIN);
        assert_eq!(arm.float_to_int(bits(1e300), true), i64::MAX);
        assert_eq!((x86.flags, arm.flags), (INVALID, INVALID));
        let (got, flags) = run(Round::Down, |e| e.narrow(bits(0.1)));
        assert_eq!(
            (got, flags),
            (f64::from(f32::from_bits(0x3dcc_cccc)), INEXACT)
        );
    }

    #[test]
    fn rint_and_lrint_round_in_the_direction() {
        let want = [2.0, 3.0, 2.0, 2.0];
        for (r, w) in DIRECTIONS.into_iter().zip(want) {
            let (got, flags) = run(r, |e| e.round_integral(bits(2.5), true));
            assert_eq!((got, flags), (w, INEXACT));
            let (got, flags) = run(r, |e| e.round_integral(bits(2.5), false));
            assert_eq!((got, flags), (w, 0));
        }
        let (got, _) = run(Round::Up, |e| e.round_integral(bits(-0.5), true));
        assert!(got == 0.0 && got.is_sign_negative());
        let mut win = env(Target::WindowsX64, Round::Nearest);
        assert_eq!((win.lrint(bits(3e9), 32), win.flags), (0, INVALID));
        let mut x86 = env(Target::LinuxX64, Round::Nearest);
        assert_eq!((x86.lrint(bits(1e19), 64), x86.flags), (i64::MIN, INVALID));
    }

    #[test]
    fn the_environment_round_trips_through_its_image() {
        for t in [
            Target::LinuxX64,
            Target::LinuxAarch64,
            Target::MacOSAarch64,
            Target::WindowsX64,
            Target::WindowsAarch64,
        ] {
            let mut e = env(t, Round::Down);
            e.flags = OVERFLOW | INEXACT;
            let img = e.env_image();
            let mut f = FpEnv::new(t);
            f.set_env_image(&img);
            assert_eq!(
                (f.round, f.flags),
                (Round::Down, OVERFLOW | INEXACT),
                "{t:?}"
            );
            assert!(f.set_round(f.get_round()));
            assert!(!f.set_round(-1));
        }
    }
}

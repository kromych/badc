//! The numeric conversion functions of C99 7.20.1 and 7.20.6.1, and the
//! integer and floating subject sequences the scanners share with them.

use alloc::format;
use alloc::vec::Vec;

use crate::c5::codegen::LongDoubleKind;
use crate::c5::error::C5Error;

use super::super::fenv::{
    BINARY32, BINARY64, BINARY128, Format, FpEnv, OVERFLOW, Rounded, UNDERFLOW, X87,
};
use super::{AccessKind, Libc, Memory, StoreKind, store_to_memory};

pub(super) const EINVAL: i32 = 22;
pub(super) const ERANGE: i32 = 34;

pub(super) const NAMES: &[&str] = &[
    "atoi",
    "atol",
    "atoll",
    "_atoi64",
    "atof",
    "strtol",
    "strtoul",
    "strtoll",
    "strtoull",
    "_strtoi64",
    "_strtoui64",
    "strtoimax",
    "strtoumax",
    "strtod",
    "strtof",
    "strtold",
    "abs",
    "labs",
    "llabs",
    "imaxabs",
];

/// The "C" locale's white-space characters (C99 7.4.1.10).
pub(super) fn is_space(c: u8) -> bool {
    matches!(c, b' ' | b'\t' | b'\n' | 0x0b | 0x0c | b'\r')
}

fn digit_value(c: u8) -> u32 {
    match c {
        b'0'..=b'9' => u32::from(c - b'0'),
        b'a'..=b'z' => u32::from(c - b'a') + 10,
        b'A'..=b'Z' => u32::from(c - b'A') + 10,
        _ => 99,
    }
}

/// An integer subject sequence (C99 7.20.1.4p3): its sign, its magnitude
/// (`None` past `u64`) and the bytes up to its end, white space included.
pub(super) struct IntSubject {
    pub(super) neg: bool,
    pub(super) mag: Option<u64>,
    pub(super) len: usize,
}

/// The subject sequence of `s` in `base` (0, or 2 through 36), or `None`
/// when `s` holds none. A `0x` that no hexadecimal digit follows leaves the
/// subject `0`.
pub(super) fn parse_int(s: &[u8], base: u32) -> Option<IntSubject> {
    let mut i = s.iter().take_while(|&&c| is_space(c)).count();
    let neg = s.get(i) == Some(&b'-');
    if matches!(s.get(i), Some(b'+' | b'-')) {
        i += 1;
    }
    let mut base = base;
    let hex_prefix = s.get(i) == Some(&b'0')
        && matches!(s.get(i + 1), Some(b'x' | b'X'))
        && s.get(i + 2).is_some_and(|&c| digit_value(c) < 16);
    if (base == 0 || base == 16) && hex_prefix {
        base = 16;
        i += 2;
    } else if base == 0 {
        base = if s.get(i) == Some(&b'0') { 8 } else { 10 };
    }
    let start = i;
    let mut mag = Some(0u64);
    while let Some(d) = s.get(i).map(|&c| digit_value(c)).filter(|&d| d < base) {
        mag = mag.and_then(|m| m.checked_mul(u64::from(base))?.checked_add(u64::from(d)));
        i += 1;
    }
    (i > start).then_some(IntSubject { neg, mag, len: i })
}

/// The value a conversion to a `bits`-wide integer type returns for `sub`,
/// and whether it is out of range (C99 7.20.1.4p8): a signed type clamps
/// to its bounds, an unsigned one to its maximum, negating in the type.
pub(super) fn int_value(sub: &IntSubject, bits: u32, signed: bool) -> (i64, bool) {
    let umax = u64::MAX >> (64 - bits);
    let mag = sub.mag;
    if signed {
        let max = umax >> 1;
        let limit = if sub.neg { max + 1 } else { max };
        match mag.filter(|&m| m <= limit) {
            Some(m) if sub.neg => ((m as i64).wrapping_neg(), false),
            Some(m) => (m as i64, false),
            None if sub.neg => ((max as i64).wrapping_neg().wrapping_sub(1), true),
            None => (max as i64, true),
        }
    } else {
        match mag.filter(|&m| m <= umax) {
            Some(m) if sub.neg => ((m.wrapping_neg() & umax) as i64, false),
            Some(m) => (m as i64, false),
            None => (umax as i64, true),
        }
    }
}

/// A floating subject sequence (C99 7.20.1.3p3), its value not yet rounded.
pub(super) enum FloatSubject {
    /// `digits * 10^exp`, the significant digits past the first `MAX_DIGITS`
    /// folded into `sticky`.
    Decimal {
        neg: bool,
        digits: Vec<u8>,
        exp: i64,
        sticky: bool,
    },
    /// `sig * 2^exp`, the bits past the first 120 folded into `sticky`.
    Hex {
        neg: bool,
        sig: u128,
        exp: i64,
        sticky: bool,
    },
    Inf(bool),
    Nan(bool),
}

/// The significant decimal digits a conversion keeps: more than any
/// halfway point between two values of the widest format has.
const MAX_DIGITS: usize = 12_000;

fn eq_ignore_case(s: &[u8], at: usize, word: &[u8]) -> bool {
    s.get(at..at + word.len())
        .is_some_and(|w| w.eq_ignore_ascii_case(word))
}

/// A decimal exponent part at `s[at..]` (`e` and a signed digit sequence):
/// its value, saturated, and its length; `(0, 0)` when there is none.
fn exponent_part(s: &[u8], at: usize, marker: u8) -> (i64, usize) {
    if !s.get(at).is_some_and(|c| c.eq_ignore_ascii_case(&marker)) {
        return (0, 0);
    }
    let mut i = at + 1;
    let neg = s.get(i) == Some(&b'-');
    if matches!(s.get(i), Some(b'+' | b'-')) {
        i += 1;
    }
    let start = i;
    let mut e: i64 = 0;
    while let Some(c) = s.get(i).filter(|c| c.is_ascii_digit()) {
        e = (e * 10 + i64::from(c - b'0')).min(1 << 40);
        i += 1;
    }
    if i == start {
        return (0, 0);
    }
    (if neg { -e } else { e }, i - at)
}

/// The subject sequence of `s` with decimal-point character `point`, and
/// the bytes up to its end, white space included; `None` when `s` holds
/// none.
pub(super) fn parse_float(s: &[u8], point: u8) -> Option<(FloatSubject, usize)> {
    let mut i = s.iter().take_while(|&&c| is_space(c)).count();
    let neg = s.get(i) == Some(&b'-');
    if matches!(s.get(i), Some(b'+' | b'-')) {
        i += 1;
    }
    if eq_ignore_case(s, i, b"inf") {
        let len = if eq_ignore_case(s, i, b"infinity") {
            8
        } else {
            3
        };
        return Some((FloatSubject::Inf(neg), i + len));
    }
    if eq_ignore_case(s, i, b"nan") {
        i += 3;
        if s.get(i) == Some(&b'(') {
            let body = s[i + 1..]
                .iter()
                .take_while(|c| c.is_ascii_alphanumeric() || **c == b'_')
                .count();
            if s.get(i + 1 + body) == Some(&b')') {
                i += body + 2;
            }
        }
        return Some((FloatSubject::Nan(neg), i));
    }
    let hex = s.get(i) == Some(&b'0') && matches!(s.get(i + 1), Some(b'x' | b'X'));
    if hex && let Some(r) = parse_hex(s, i + 2, neg, point) {
        return Some(r);
    }
    let (mut digits, mut exp, mut sticky, mut seen) = (Vec::new(), 0i64, false, false);
    let mut frac = false;
    loop {
        match s.get(i) {
            Some(&c) if c.is_ascii_digit() => {
                seen = true;
                if digits.len() < MAX_DIGITS && (c != b'0' || !digits.is_empty()) {
                    digits.push(c - b'0');
                    exp -= i64::from(frac);
                } else if !digits.is_empty() {
                    sticky |= c != b'0';
                    exp += i64::from(!frac);
                } else {
                    exp -= i64::from(frac);
                }
            }
            Some(&c) if c == point && !frac => frac = true,
            _ => break,
        }
        i += 1;
    }
    if !seen {
        return None;
    }
    let (e, n) = exponent_part(s, i, b'e');
    while digits.last() == Some(&0) {
        digits.pop();
        exp += 1;
    }
    let sub = FloatSubject::Decimal {
        neg,
        digits,
        exp: exp.saturating_add(e),
        sticky,
    };
    Some((sub, i + n))
}

/// The hexadecimal form after its `0x`, starting at `s[at..]`; `None` when
/// no hexadecimal digit follows.
fn parse_hex(s: &[u8], at: usize, neg: bool, point: u8) -> Option<(FloatSubject, usize)> {
    let (mut i, mut sig, mut exp, mut sticky, mut seen, mut frac) =
        (at, 0u128, 0i64, false, false, false);
    loop {
        match s.get(i) {
            Some(&c) if digit_value(c) < 16 => {
                seen = true;
                if sig >> 116 == 0 {
                    sig = sig << 4 | u128::from(digit_value(c));
                    exp -= 4 * i64::from(frac);
                } else {
                    sticky |= c != b'0';
                    exp += 4 * i64::from(!frac);
                }
            }
            Some(&c) if c == point && !frac => frac = true,
            _ => break,
        }
        i += 1;
    }
    if !seen {
        return None;
    }
    let (e, n) = exponent_part(s, i, b'p');
    let sub = FloatSubject::Hex {
        neg,
        sig,
        exp: exp.saturating_add(e),
        sticky,
    };
    Some((sub, i + n))
}

/// A nonnegative integer as little-endian 32-bit limbs.
struct Big(Vec<u32>);

impl Big {
    fn from_digits(digits: &[u8]) -> Self {
        let mut b = Big(Vec::new());
        for chunk in digits.chunks(9) {
            let scale = 10u32.pow(chunk.len() as u32);
            let v = chunk.iter().fold(0u32, |a, &d| a * 10 + u32::from(d));
            b.mul_add(scale, v);
        }
        b
    }

    fn mul_add(&mut self, m: u32, mut carry: u32) {
        for limb in &mut self.0 {
            let t = u64::from(*limb) * u64::from(m) + u64::from(carry);
            *limb = t as u32;
            carry = (t >> 32) as u32;
        }
        if carry != 0 {
            self.0.push(carry);
        }
    }

    fn mul_pow5(&mut self, mut e: u64) {
        while e > 0 {
            let k = e.min(13) as u32;
            self.mul_add(5u32.pow(k), 0);
            e -= u64::from(k);
        }
    }

    fn bits(&self) -> u64 {
        match self.0.iter().rposition(|&l| l != 0) {
            Some(i) => i as u64 * 32 + u64::from(32 - self.0[i].leading_zeros()),
            None => 0,
        }
    }

    fn shl(&mut self, n: u64) {
        let (limbs, bits) = ((n / 32) as usize, (n % 32) as u32);
        if bits > 0 {
            let mut carry = 0;
            for limb in &mut self.0 {
                let t = *limb;
                *limb = t << bits | carry;
                carry = t >> (32 - bits);
            }
            if carry != 0 {
                self.0.push(carry);
            }
        }
        self.0.splice(0..0, core::iter::repeat_n(0, limbs));
    }

    fn shr1(&mut self) {
        let mut carry = 0;
        for limb in self.0.iter_mut().rev() {
            let t = *limb;
            *limb = t >> 1 | carry << 31;
            carry = t & 1;
        }
    }

    fn ge(&self, o: &Big) -> bool {
        let n = self.0.len().max(o.0.len());
        for i in (0..n).rev() {
            let (a, b) = (
                self.0.get(i).copied().unwrap_or(0),
                o.0.get(i).copied().unwrap_or(0),
            );
            if a != b {
                return a > b;
            }
        }
        true
    }

    fn sub(&mut self, o: &Big) {
        let mut borrow = 0i64;
        for (i, limb) in self.0.iter_mut().enumerate() {
            let t = i64::from(*limb) - i64::from(o.0.get(i).copied().unwrap_or(0)) - borrow;
            *limb = t as u32;
            borrow = i64::from(t < 0);
        }
    }

    /// `self / d` when the quotient is below 2^128, and whether a
    /// remainder is left.
    fn div(mut self, d: &Big) -> (u128, bool) {
        let k = self.bits().saturating_sub(d.bits());
        let mut shifted = Big(d.0.clone());
        shifted.shl(k);
        let mut q = 0u128;
        for _ in 0..=k {
            q <<= 1;
            if self.ge(&shifted) {
                self.sub(&shifted);
                q |= 1;
            }
            shifted.shr1();
        }
        (q, self.bits() != 0)
    }
}

/// `+/-digits * 10^exp` rounded to `f` in the current direction.
fn round_decimal(
    fp: &mut FpEnv,
    neg: bool,
    digits: &[u8],
    exp: i64,
    sticky: bool,
    f: Format,
) -> Rounded {
    let magnitude = exp + digits.len() as i64;
    // Past either end every format overflows or rounds as a value far
    // below its smallest subnormal does.
    if magnitude > 5000 {
        return fp.round_to(neg, 1, 20_000, false, f);
    }
    if magnitude < -5000 {
        return fp.round_to(neg, 1, -30_000, false, f);
    }
    let (mut num, mut den) = (Big::from_digits(digits), Big(alloc::vec![1]));
    if exp >= 0 {
        num.mul_pow5(exp as u64);
    } else {
        den.mul_pow5(exp.unsigned_abs());
    }
    // A quotient of 117 or 118 bits: the widest significand and the
    // rounding bits below it.
    let shift = 117 - (num.bits() as i64 - den.bits() as i64);
    if shift > 0 {
        num.shl(shift as u64);
    } else {
        den.shl(shift.unsigned_abs());
    }
    let (q, rem) = num.div(&den);
    fp.round_to(neg, q, (exp - shift) as i32, sticky || rem, f)
}

/// `sub` converted to `f` (C99 7.20.1.3p5-10), its encoding and whether
/// the value overflowed or underflowed, for `errno`'s `ERANGE`.
pub(super) fn float_value(fp: &mut FpEnv, sub: &FloatSubject, f: Format) -> (u128, bool) {
    let saved = core::mem::take(&mut fp.flags);
    let (neg, r) = match *sub {
        FloatSubject::Inf(neg) => (neg, Rounded::Overflow { infinite: true }),
        FloatSubject::Nan(neg) => {
            fp.flags = saved;
            return (f.quiet_nan(neg), false);
        }
        FloatSubject::Decimal {
            neg, ref digits, ..
        } if digits.is_empty() => (neg, Rounded::Finite(0, 0)),
        FloatSubject::Decimal {
            neg,
            ref digits,
            exp,
            sticky,
        } => (neg, round_decimal(fp, neg, digits, exp, sticky, f)),
        FloatSubject::Hex { neg, sig: 0, .. } => (neg, Rounded::Finite(0, 0)),
        FloatSubject::Hex {
            neg,
            sig,
            exp,
            sticky,
        } => {
            let exp = exp.clamp(-40_000, 40_000) as i32;
            (neg, fp.round_to(neg, sig, exp, sticky, f))
        }
    };
    let range = fp.flags & (OVERFLOW | UNDERFLOW) != 0;
    fp.flags |= saved;
    (f.encode(neg, r), range)
}

/// The format a `long double` has on the target.
pub(super) fn long_double_format(kind: LongDoubleKind) -> Format {
    match kind {
        LongDoubleKind::F64 => BINARY64,
        LongDoubleKind::X87 => X87,
        LongDoubleKind::Binary128 => BINARY128,
    }
}

/// A `long double` result: its binary64 bits where `long double` is
/// `double`, else the address of the object holding it, which the caller
/// copies, as from a function returning it in memory.
pub(super) fn long_double_return(
    mem: &mut Memory,
    kind: LongDoubleKind,
    bits: u128,
) -> Result<i64, C5Error> {
    if kind == LongDoubleKind::F64 {
        return Ok(bits as u64 as i64);
    }
    let at = mem.stdio() + super::STDIO_RETURN;
    mem.write_bytes(at, &bits.to_le_bytes())?;
    Ok(at as i64)
}

/// The bytes of a `long double` encoding its object holds: 10 for the x87
/// format, whose padding a store leaves, 16 for binary128, 8 otherwise.
pub(super) fn long_double_bytes(kind: LongDoubleKind, bits: u128) -> Vec<u8> {
    let n = match kind {
        LongDoubleKind::F64 => 8,
        LongDoubleKind::X87 => 10,
        LongDoubleKind::Binary128 => 16,
    };
    bits.to_le_bytes()[..n].to_vec()
}

fn arg(name: &str, args: &[i64], i: usize) -> Result<i64, C5Error> {
    (args.get(i).copied())
        .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {name}: missing argument")))
}

/// Store `s + used` through `endptr` when it is not null.
fn store_end(mem: &mut Memory, endptr: i64, s: i64, used: usize) -> Result<(), C5Error> {
    if endptr == 0 {
        return Ok(());
    }
    mem.check_data_access(endptr as usize, 8, AccessKind::Write)?;
    store_to_memory(mem, endptr as usize, s + used as i64, StoreKind::I64)
}

/// `strtol` and its siblings in a `bits`-wide type: the value, `errno`
/// set to `ERANGE` out of range and to `EINVAL` for a base outside 0 and
/// 2 through 36. glibc returns from a bad base before storing `*endptr`;
/// Apple's libc also sets `EINVAL` when there is no subject sequence.
fn strto_int(
    mem: &mut Memory,
    args: &[i64],
    base: Option<i64>,
    bits: u32,
    signed: bool,
) -> Result<i64, C5Error> {
    let libc = Libc::of(mem.target);
    let s = super::cstring_arg("strtol", args, 0, mem)?;
    let endptr = args.get(1).copied().unwrap_or(0);
    let base = base.unwrap_or_else(|| args.get(2).copied().unwrap_or(10));
    if base == 1 || !(0..=36).contains(&base) {
        mem.set_errno(EINVAL);
        if libc != Libc::Glibc {
            store_end(mem, endptr, args[0], 0)?;
        }
        return Ok(0);
    }
    let Some(sub) = parse_int(&s, base as u32) else {
        if libc == Libc::Apple {
            mem.set_errno(EINVAL);
        }
        store_end(mem, endptr, args[0], 0)?;
        return Ok(0);
    };
    store_end(mem, endptr, args[0], sub.len)?;
    let (v, range) = int_value(&sub, bits, signed);
    if range {
        mem.set_errno(ERANGE);
    }
    Ok(v)
}

/// `strtod`, `strtof` and `strtold`: the value in `f` and its encoding.
fn strto_float(mem: &mut Memory, args: &[i64], f: Format) -> Result<u128, C5Error> {
    let s = super::cstring_arg("strtod", args, 0, mem)?;
    let endptr = args.get(1).copied().unwrap_or(0);
    let Some((sub, used)) = parse_float(&s, b'.') else {
        store_end(mem, endptr, args[0], 0)?;
        return Ok(f.encode(false, Rounded::Finite(0, 0)));
    };
    store_end(mem, endptr, args[0], used)?;
    let (bits, range) = float_value(&mut mem.fp, &sub, f);
    if range {
        mem.set_errno(ERANGE);
    }
    Ok(bits)
}

/// The conversion functions by name; `None` for any other name.
pub(super) fn call(name: &str, args: &[i64], mem: &mut Memory) -> Option<Result<i64, C5Error>> {
    if !NAMES.contains(&name) {
        return None;
    }
    let long_bits = mem.target.long_width_bytes() as u32 * 8;
    let windows = mem.target.is_windows();
    Some((|| match name {
        // msvcrt's atoi clamps to `int` and sets ERANGE; glibc's and
        // Apple's are `(int)strtol(s, NULL, 10)`.
        "atoi" if windows => strto_int(mem, &[arg(name, args, 0)?, 0], Some(10), 32, true),
        "atoi" => {
            Ok(strto_int(mem, &[arg(name, args, 0)?, 0], Some(10), long_bits, true)? as i32 as i64)
        }
        "atol" => strto_int(mem, &[arg(name, args, 0)?, 0], Some(10), long_bits, true),
        "atoll" | "_atoi64" => strto_int(mem, &[arg(name, args, 0)?, 0], Some(10), 64, true),
        "strtol" => strto_int(mem, args, None, long_bits, true),
        "strtoul" => strto_int(mem, args, None, long_bits, false),
        "strtoll" | "_strtoi64" | "strtoimax" => strto_int(mem, args, None, 64, true),
        "strtoull" | "_strtoui64" | "strtoumax" => strto_int(mem, args, None, 64, false),
        "atof" => Ok(strto_float(mem, &[arg(name, args, 0)?, 0], BINARY64)? as i64),
        "strtod" => Ok(strto_float(mem, args, BINARY64)? as i64),
        "strtof" => {
            let bits = strto_float(mem, args, BINARY32)?;
            Ok(f64::from(f32::from_bits(bits as u32)).to_bits() as i64)
        }
        "strtold" => {
            let kind = mem.target.long_double();
            let bits = strto_float(mem, args, long_double_format(kind))?;
            long_double_return(mem, kind, bits)
        }
        "abs" => Ok(i64::from((arg(name, args, 0)? as i32).wrapping_abs())),
        "labs" if long_bits == 32 => Ok(i64::from((arg(name, args, 0)? as i32).wrapping_abs())),
        _ => Ok(arg(name, args, 0)?.wrapping_abs()),
    })())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::codegen::Target;

    fn conv(s: &str, f: Format) -> (u128, bool) {
        let mut fp = FpEnv::new(Target::LinuxX64);
        let (sub, _) = parse_float(s.as_bytes(), b'.').expect("subject");
        float_value(&mut fp, &sub, f)
    }

    #[test]
    fn decimal_input_rounds_correctly_to_each_format() {
        for s in [
            "0.1",
            "1e23",
            "2.2250738585072011e-308",
            "4.9406564584124654e-324",
            "1.7976931348623157e308",
            "123456789012345678901234567890",
            "9007199254740993",
            "3.14159265358979323846264338327950288",
        ] {
            let want: f64 = s.parse().unwrap();
            assert_eq!(conv(s, BINARY64).0 as u64, want.to_bits(), "{s}");
            let want32: f32 = s.parse().unwrap();
            assert_eq!(conv(s, BINARY32).0 as u32, want32.to_bits(), "{s}");
        }
        let mut x = 0x2545_f491_4f6c_dd1du64;
        for _ in 0..3000 {
            x ^= x << 13;
            x ^= x >> 7;
            x ^= x << 17;
            let digits = format!("{}", x % 10u64.pow(1 + (x >> 59) as u32 % 19));
            let s = format!("{digits}.{}e{}", x >> 40, (x >> 20) as i64 % 330);
            let want: f64 = s.parse().unwrap();
            assert_eq!(conv(&s, BINARY64).0 as u64, want.to_bits(), "{s}");
            let want32: f32 = s.parse().unwrap();
            assert_eq!(conv(&s, BINARY32).0 as u32, want32.to_bits(), "{s}");
        }
        // 0.1 to the 64-bit and 113-bit significands, rounded to nearest.
        let x87 = conv("0.1", X87).0;
        assert_eq!(
            (x87 as u64, (x87 >> 64) as u16),
            (0xcccc_cccc_cccc_cccd, 0x3ffb)
        );
        assert_eq!(
            conv("0.1", BINARY128).0,
            0x3ffb_9999_9999_9999_9999_9999_9999_999a
        );
        assert_eq!(conv("1e5000", X87), (0x7fff_8000_0000_0000_0000, true));
        assert_eq!(conv("1e-5000", BINARY128), (0, true));
    }

    #[test]
    fn hexadecimal_infinite_and_nan_subjects() {
        assert_eq!(conv("0x1.8p1", BINARY64).0 as u64, 3.0f64.to_bits());
        assert_eq!(
            conv("-0x1p-1074", BINARY64).0 as u64,
            (-5e-324f64).to_bits()
        );
        assert_eq!(conv("0x1p-1075", BINARY64), (0, true));
        assert_eq!(
            conv("-Infinity", BINARY64).0 as u64,
            f64::NEG_INFINITY.to_bits()
        );
        assert_eq!(conv("nan(12)", X87).0, 0x7fff_c000_0000_0000_0000);
        let used = |s: &str| parse_float(s.as_bytes(), b'.').map(|(_, n)| n);
        assert_eq!(used("  0x"), Some(3));
        assert_eq!(used("1e+"), Some(1));
        assert_eq!(used("infinit"), Some(3));
        assert_eq!(used("nan(ab"), Some(3));
        assert_eq!(used(".e1"), None);
    }

    #[test]
    fn integer_subjects_clamp_in_the_type() {
        let v = |s: &str, base, bits, signed| {
            int_value(&parse_int(s.as_bytes(), base).unwrap(), bits, signed)
        };
        assert_eq!(v("0x7fffffff", 0, 32, true), (i32::MAX as i64, false));
        assert_eq!(v("-2147483649", 10, 32, true), (i32::MIN as i64, true));
        assert_eq!(v("-1", 10, 32, false), (u32::MAX as i64, false));
        assert_eq!(v("-99999999999999999999", 10, 64, false), (-1, true));
        assert_eq!(v("z", 36, 64, true), (35, false));
        assert_eq!(parse_int(b" 0x", 16).map(|s| s.len), Some(2));
        assert!(parse_int(b"+", 0).is_none());
    }
}

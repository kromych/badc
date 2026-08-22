//! Correctness proof for the constant-divide lowering.
//!
//! The lowering is recorded once per divisor through [`DivSink`] -- the
//! same entry point the SSA builder drives -- and replayed per numerator
//! through the VM's [`apply_binop`], so the tested semantics are the
//! emitted semantics. Every result is compared against the hardware
//! divide the lowering replaces, which is `apply_binop` on the same
//! opcode.

use alloc::vec::Vec;

use super::*;
use crate::c5::vm::eval::apply_binop;

/// One recorded step. Slot 0 holds the numerator; step `i` defines
/// slot `i + 1`.
#[derive(Clone, Copy)]
enum Step {
    Imm(i64),
    Binop(BinOp, usize, usize),
    BinopImm(BinOp, usize, i64),
}

#[derive(Default)]
struct Recorder {
    steps: Vec<Step>,
}

impl DivSink for Recorder {
    type Val = usize;

    fn imm(&mut self, k: i64) -> usize {
        self.steps.push(Step::Imm(k));
        self.steps.len()
    }

    fn binop(&mut self, op: BinOp, lhs: usize, rhs: usize) -> usize {
        self.steps.push(Step::Binop(op, lhs, rhs));
        self.steps.len()
    }

    fn binop_imm(&mut self, op: BinOp, lhs: usize, rhs: i64) -> usize {
        self.steps.push(Step::BinopImm(op, lhs, rhs));
        self.steps.len()
    }
}

/// A recorded sequence plus the slot holding its result.
struct Recorded {
    steps: Vec<Step>,
    out: usize,
}

impl Recorded {
    fn record(op: BinOp, d: i64, w: u32) -> Option<Self> {
        let mut r = Recorder::default();
        let out = lower_divmod(&mut r, op, 0, d, w)?;
        Some(Recorded {
            steps: r.steps,
            out,
        })
    }

    fn eval(&self, n: i64) -> i64 {
        let mut vals = Vec::with_capacity(self.steps.len() + 1);
        vals.push(n);
        for step in &self.steps {
            let v = match *step {
                Step::Imm(k) => k,
                Step::Binop(op, a, b) => apply_binop(op, vals[a], vals[b]).unwrap(),
                Step::BinopImm(op, a, k) => apply_binop(op, vals[a], k).unwrap(),
            };
            vals.push(v);
        }
        vals[self.out]
    }

    fn len(&self) -> usize {
        self.steps.len()
    }
}

/// SplitMix64. Fixed seeds keep every sampled vector reproducible.
struct Rng(u64);

impl Rng {
    fn next(&mut self) -> u64 {
        self.0 = self.0.wrapping_add(0x9E37_79B9_7F4A_7C15);
        let mut z = self.0;
        z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
        z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
        z ^ (z >> 31)
    }
}

/// Truncate a register value to the operand width the way the walker
/// leaves it: sign-extended for a signed type, zero-extended (masked)
/// for an unsigned one.
fn narrow(v: i64, w: u32, signed: bool) -> i64 {
    if w == 64 {
        v
    } else if signed {
        v as i32 as i64
    } else {
        v as u32 as i64
    }
}

/// Divisors: every small value, every power of two and its immediate
/// neighbours, the powers of ten, the width's extremes, and a sampled
/// vector. Signed sets carry both signs.
fn divisors(w: u32, signed: bool) -> Vec<i64> {
    let mut v: Vec<i64> = Vec::new();
    let top = if signed { w - 1 } else { w };
    for d in 1..=1024i64 {
        v.push(d);
    }
    for k in 1..top {
        let p = 1i64 << k;
        for off in [-3i64, -1, 0, 1, 3] {
            v.push(p.wrapping_add(off));
        }
    }
    let mut ten = 10i64;
    while (ten as u64) < (1u64 << (top - 1)) {
        v.push(ten);
        let Some(next) = ten.checked_mul(10) else {
            break;
        };
        ten = next;
    }
    if signed {
        // INT_MIN, INT_MAX and their neighbours at this width.
        let min = (1i64 << (w - 1)).wrapping_neg();
        let max = (1i64 << (w - 1)).wrapping_sub(1);
        v.extend([min, min + 1, min + 2, max, max - 1, max - 2]);
        let neg: Vec<i64> = v
            .iter()
            .filter(|d| **d > 0)
            .map(|d| d.wrapping_neg())
            .collect();
        v.extend(neg);
    } else if w == 64 {
        v.extend([-1, -2, -3, i64::MIN, i64::MIN + 1, i64::MAX]);
    } else {
        v.extend([0xffff_ffff, 0xffff_fffe, 0x8000_0001, 0x8000_0000]);
    }
    let mut rng = Rng(0x5EED_0001);
    for _ in 0..768 {
        let r = rng.next();
        let d = if signed {
            let m = narrow(r as i64, w, true);
            if m == 0 { 1 } else { m }
        } else {
            let m = narrow(r as i64, w, false);
            if m == 0 { 1 } else { m }
        };
        v.push(d);
    }
    v.retain(|d| *d != 0 && narrow(*d, w, signed) == *d);
    v.sort_unstable();
    v.dedup();
    v
}

/// Numerators: the boundaries the task names, every power of two and
/// its neighbours, the multiples of `d` that bracket the range ends
/// (the worst case for the reciprocal's error term), and a sampled
/// vector.
fn numerators(d: i64, w: u32, signed: bool, rng: &mut Rng) -> Vec<i64> {
    let mut v: Vec<i64> = alloc::vec![0, 1, -1, 2, -2, 3, -3];
    for k in 0..w {
        let p = 1i64 << k;
        for off in [-1i64, 0, 1] {
            v.push(p.wrapping_add(off));
            v.push(p.wrapping_neg().wrapping_add(off));
        }
    }
    if signed {
        let min = (1i64 << (w - 1)).wrapping_neg();
        let max = (1i64 << (w - 1)).wrapping_sub(1);
        v.extend([min, min + 1, min + 2, max, max - 1, max - 2]);
    } else {
        let umax = if w == 64 { u64::MAX } else { u32::MAX as u64 };
        v.extend([umax as i64, (umax - 1) as i64, (umax / 2) as i64]);
    }
    // Neighbourhoods of +-d and of the largest in-range multiples of d:
    // the residues d-1 and 0 at the range extremes drive the derivation.
    let ad = (d as i128).unsigned_abs();
    let ends: [i128; 2] = if signed {
        [(1i128 << (w - 1)) - 1, -(1i128 << (w - 1))]
    } else {
        [
            if w == 64 {
                u64::MAX as i128
            } else {
                u32::MAX as i128
            },
            0,
        ]
    };
    for end in ends {
        let mult = (end.unsigned_abs() / ad * ad) as i128;
        let base = if end < 0 { -mult } else { mult };
        for off in -2i128..=2 {
            v.push((base + off) as i64);
        }
    }
    for m in [1i128, 2, 3] {
        let s = (ad as i128) * m;
        for off in -2i128..=2 {
            v.push((s + off) as i64);
            v.push((-s + off) as i64);
        }
    }
    for _ in 0..48 {
        v.push(rng.next() as i64);
    }
    for n in v.iter_mut() {
        *n = narrow(*n, w, signed);
    }
    v.sort_unstable();
    v.dedup();
    v
}

/// Cross every divisor with every boundary and sampled numerator and
/// compare the lowering against the divide it replaces. Returns the
/// number of (divisor, numerator) pairs checked.
fn check(op: BinOp, w: u32, signed: bool) -> u64 {
    let mut rng = Rng(0x5EED_0002);
    let mut pairs = 0u64;
    for d in divisors(w, signed) {
        let seq = Recorded::record(op, d, w).expect("constant divisor must lower");
        for n in numerators(d, w, signed, &mut rng) {
            let want = apply_binop(op, n, d).unwrap();
            let got = seq.eval(n);
            assert_eq!(
                got, want,
                "{op:?} w={w} n={n} ({n:#x}) d={d} ({d:#x}): got {got}, want {want}"
            );
            pairs += 1;
        }
    }
    pairs
}

#[test]
fn unsigned_divide_32_matches_hardware() {
    let n = check(BinOp::Divu, 32, false);
    assert!(n > 400_000, "coverage shrank: pairs={n}");
}

#[test]
fn unsigned_modulo_32_matches_hardware() {
    let n = check(BinOp::Modu, 32, false);
    assert!(n > 400_000, "coverage shrank: pairs={n}");
}

#[test]
fn unsigned_divide_64_matches_hardware() {
    let n = check(BinOp::Divu, 64, false);
    assert!(n > 400_000, "coverage shrank: pairs={n}");
}

#[test]
fn unsigned_modulo_64_matches_hardware() {
    let n = check(BinOp::Modu, 64, false);
    assert!(n > 400_000, "coverage shrank: pairs={n}");
}

#[test]
fn signed_divide_32_matches_hardware() {
    let n = check(BinOp::Div, 32, true);
    assert!(n > 400_000, "coverage shrank: pairs={n}");
}

#[test]
fn signed_modulo_32_matches_hardware() {
    let n = check(BinOp::Mod, 32, true);
    assert!(n > 400_000, "coverage shrank: pairs={n}");
}

#[test]
fn signed_divide_64_matches_hardware() {
    let n = check(BinOp::Div, 64, true);
    assert!(n > 400_000, "coverage shrank: pairs={n}");
}

#[test]
fn signed_modulo_64_matches_hardware() {
    let n = check(BinOp::Mod, 64, true);
    assert!(n > 400_000, "coverage shrank: pairs={n}");
}

/// Narrower-than-int operands promote to `int` (C99 6.3.1.1p2), so
/// they reach the 32-bit signed lowering carrying only values
/// representable in their own type -- an unsigned char divide is a
/// signed `int` divide. `signed char` and `unsigned char` are checked
/// over the complete divisor x numerator cross product; the 16-bit
/// types sample the divisor and keep every numerator.
#[test]
fn promoted_narrow_operands_match_hardware() {
    let mut rng = Rng(0x5EED_0005);
    for (bits, signed) in [(8u32, true), (8, false), (16, true), (16, false)] {
        let lo: i64 = if signed { -(1 << (bits - 1)) } else { 0 };
        let hi: i64 = if signed {
            (1 << (bits - 1)) - 1
        } else {
            (1 << bits) - 1
        };
        let ds: Vec<i64> = if bits == 8 {
            (lo..=hi).collect()
        } else {
            let mut v: Vec<i64> = (lo..=lo + 64).chain(hi - 64..=hi).collect();
            v.extend(-64..=64);
            v.extend((0..192).map(|_| lo + (rng.next() % (hi - lo + 1) as u64) as i64));
            v
        };
        for op in [BinOp::Div, BinOp::Mod] {
            for d in ds.iter().copied() {
                if d == 0 {
                    continue;
                }
                let seq = Recorded::record(op, d, 32).unwrap();
                for n in lo..=hi {
                    assert_eq!(
                        seq.eval(n),
                        apply_binop(op, n, d).unwrap(),
                        "{op:?} {n}/{d}"
                    );
                }
            }
        }
    }
}

/// A zero divisor is undefined (C99 6.5.5p5); the lowering declines it
/// so the hardware divide's trap survives.
#[test]
fn zero_divisor_declines() {
    for op in [BinOp::Div, BinOp::Mod, BinOp::Divu, BinOp::Modu] {
        for w in [32, 64] {
            assert!(Recorded::record(op, 0, w).is_none());
        }
    }
    assert!(Recorded::record(BinOp::Add, 7, 64).is_none());
}

/// Hacker's Delight fig. 10-1 `magic`, transcribed. The doubling
/// recurrences reach the same answer by a different route than the
/// closed-form search in `magic_signed`, so agreement over a wide
/// divisor set cross-checks the search's bound.
fn hd_magic_signed(d: u128, w: u32) -> (u128, u32) {
    let half = 1u128 << (w - 1);
    let anc = half - 1 - half % d;
    let (mut p, mut q1, mut r1) = (w - 1, half / anc, half % anc);
    let (mut q2, mut r2) = ((half - 1) / d, (half - 1) % d);
    loop {
        p += 1;
        if r1 >= anc - r1 {
            q1 = 2 * q1 + 1;
            r1 = 2 * r1 - anc;
        } else {
            q1 *= 2;
            r1 *= 2;
        }
        if r2 + 1 >= d - r2 {
            q2 = 2 * q2 + 1;
            r2 = 2 * r2 + 1 - d;
        } else {
            q2 *= 2;
            r2 = 2 * r2 + 1;
        }
        let delta = d - 1 - r2;
        if !(q1 < delta || (q1 == delta && r1 == 0)) {
            return (q2 + 1, p - w);
        }
    }
}

/// Hacker's Delight fig. 10-2 `magicu`, transcribed. `a` is the
/// add-back indicator; its shift is HD's `s`, one more than the
/// [`UnsignedMagic::shift`] the add-back sequence applies.
fn hd_magic_unsigned(d: u128, w: u32) -> (u128, bool, u32) {
    let full = (1u128 << w) - 1;
    let half = 1u128 << (w - 1);
    let nc = full - (full + 1) % d;
    let mut a = false;
    let (mut p, mut q1, mut r1) = (w - 1, half / nc, half % nc);
    let (mut q2, mut r2) = ((half - 1) / d, (half - 1) % d);
    loop {
        p += 1;
        if r1 >= nc - r1 {
            q1 = 2 * q1 + 1;
            r1 = 2 * r1 - nc;
        } else {
            q1 *= 2;
            r1 *= 2;
        }
        if r2 + 1 >= d - r2 {
            a |= q2 >= half - 1;
            q2 = 2 * q2 + 1;
            r2 = 2 * r2 + 1 - d;
        } else {
            a |= q2 >= half;
            q2 *= 2;
            r2 = 2 * r2 + 1;
        }
        let delta = d - 1 - r2;
        if !(p < 2 * w && (q1 < delta || (q1 == delta && r1 == 0))) {
            return ((q2 + 1) & full, a, p - w);
        }
    }
}

#[test]
fn derivation_matches_hackers_delight_reference() {
    let mut rng = Rng(0x5EED_0004);
    for w in [32u32, 64] {
        let mut ds: Vec<u64> = (3..=8192).collect();
        for k in 2..w {
            ds.extend([(1u64 << k) - 3, (1 << k) - 1, (1 << k) + 1, (1 << k) + 3]);
        }
        for _ in 0..8192 {
            ds.push(rng.next() >> (64 - w));
        }
        for d in ds {
            if d < 3 || d.is_power_of_two() || d >= (1u64 << (w - 1)) {
                continue;
            }
            let got = magic_unsigned(d, w, w);
            let (m, a, s) = hd_magic_unsigned(d as u128, w);
            let want_shift = if a { s - 1 } else { s };
            assert_eq!(
                (got.m as u128, got.add, got.shift),
                (m, a, want_shift),
                "magicu w={w} d={d}"
            );
            if d < (1u64 << (w - 1)) {
                let got = magic_signed(d, w);
                let (m, s) = hd_magic_signed(d as u128, w);
                assert_eq!((got.m as u128, got.shift), (m, s), "magic w={w} d={d}");
            }
        }
    }
}

/// The most-cited constants, spelled out so a change to both the
/// derivation and its reference at once is still caught.
#[test]
fn derived_constants_match_published_values() {
    for (d, m, s) in [
        (3u64, 0x5555_5556u64, 0u32),
        (5, 0x6666_6667, 1),
        (7, 0x9249_2493, 2),
        (10, 0x6666_6667, 2),
        (100, 0x51EB_851F, 5),
        (1000, 0x1062_4DD3, 6),
        (0x7fff_ffff, 0x4000_0001, 29),
    ] {
        let got = magic_signed(d, 32);
        assert_eq!((got.m, got.shift), (m, s), "signed 32 d={d}");
    }
    for (d, m, s) in [
        (3u64, 0x5555_5555_5555_5556u64, 0u32),
        (7, 0x4924_9249_2492_4925, 1),
        (10, 0x6666_6666_6666_6667, 2),
        (100, 0xA3D7_0A3D_70A3_D70B, 6),
        (1000, 0x20C4_9BA5_E353_F7CF, 7),
    ] {
        let got = magic_signed(d, 64);
        assert_eq!((got.m, got.shift), (m, s), "signed 64 d={d}");
    }
    for (d, m, add, s) in [
        (3u64, 0xAAAA_AAABu64, false, 1u32),
        (5, 0xCCCC_CCCD, false, 2),
        (7, 0x2492_4925, true, 2),
        (10, 0xCCCC_CCCD, false, 3),
        (100, 0x51EB_851F, false, 5),
        (1000, 0x1062_4DD3, false, 6),
    ] {
        let got = magic_unsigned(d, 32, 32);
        assert_eq!(
            (got.m, got.add, got.shift),
            (m, add, s),
            "unsigned 32 d={d}"
        );
    }
    for (d, m, add, s) in [
        (3u64, 0xAAAA_AAAA_AAAA_AAABu64, false, 1u32),
        (7, 0x2492_4924_9249_2493, true, 2),
        (10, 0xCCCC_CCCC_CCCC_CCCD, false, 3),
        (100, 0x47AE_147A_E147_AE15, true, 6),
    ] {
        let got = magic_unsigned(d, 64, 64);
        assert_eq!(
            (got.m, got.add, got.shift),
            (m, add, s),
            "unsigned 64 d={d}"
        );
    }
}

/// The multiplier bounds the lowering relies on: unsigned fits in
/// `w + 1` bits (the extra bit is the add-back), signed fits in `w`.
/// Both post-multiply shifts stay a valid 64-bit shift count.
#[test]
fn derived_multipliers_stay_in_range() {
    let mut rng = Rng(0x5EED_0003);
    for w in [32u32, 64] {
        let mut ds: Vec<u64> = (3..=4096).collect();
        for _ in 0..4096 {
            ds.push(rng.next() >> (64 - w));
        }
        for d in ds {
            if d < 3 || d.is_power_of_two() || d >= (1u64 << (w - 1)) {
                continue;
            }
            let u = magic_unsigned(d, w, w);
            assert!(u.shift < w, "unsigned shift w={w} d={d}");
            if u.add {
                // The plain form's shift folds a `w`-bit multiply and
                // the post-shift into one; that count must stay valid.
                assert!(32 + u.shift < 64 || w == 64);
            } else if w == 32 {
                assert!(32 + u.shift < 64, "folded shift w=32 d={d}");
            }
            if d < (1u64 << (w - 1)) {
                let s = magic_signed(d, w);
                assert!(s.m < (1u64 << (w - 1)) || w == 64 || s.m < (1u64 << 32));
                assert!(s.shift < w - 1, "signed shift w={w} d={d}");
                if w == 32 {
                    assert!(32 + s.shift < 64, "folded signed shift d={d}");
                }
            }
        }
    }
}

/// Divisors whose reciprocal needs the add-back exist at both widths,
/// and an even divisor takes the pre-shift instead of the add-back.
#[test]
fn add_back_and_pre_shift_forms_are_reached() {
    assert!(magic_unsigned(7, 32, 32).add);
    assert!(magic_unsigned(7, 64, 64).add);
    // 14 = 2 * 7: the full-range magic needs the add-back, the
    // pre-shifted one does not, so the lowering takes the pre-shift.
    assert!(magic_unsigned(14, 32, 32).add);
    assert!(!magic_unsigned(7, 32, 31).add);
    let plain = Recorded::record(BinOp::Divu, 7, 32).unwrap();
    let pre = Recorded::record(BinOp::Divu, 14, 32).unwrap();
    assert!(
        pre.len() < plain.len(),
        "pre-shift must be the shorter form"
    );
}

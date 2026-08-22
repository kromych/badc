//! Conversions between binary64 and the wider `long double` storage
//! formats (x87 80-bit extended, IEEE binary128). The compute path
//! carries every `long double` value as binary64; these routines widen
//! a value into the target ABI's object format on store (exact) and
//! narrow an object back on load (round to nearest, ties to even).
//! Shared by the constant-image builder, the SSA VM, and the tests
//! that pin the aarch64 inline lowering to the same algorithm.

/// Round a finite, non-zero magnitude to binary64. `exp` is the
/// unbiased exponent of `frac` read as a 1.63 fixed-point value with
/// its integer bit at bit 63 (the value is `frac * 2^(exp - 63)`);
/// `sticky` carries any discarded low-order bits. Handles overflow to
/// infinity and the gradual-underflow range.
fn round_to_f64(sign: u64, exp: i64, frac: u64, sticky: bool) -> u64 {
    debug_assert!(frac >> 63 == 1, "caller normalizes");
    let sign = sign << 63;
    let e64 = exp + 1023;
    if e64 >= 0x7ff {
        return sign | 0x7ff << 52;
    }
    // Bits dropped from the 64-bit fraction: 11 for a normal result,
    // one more per binade the result sits under the normal range.
    let dropped = 11 + if e64 <= 0 { 1 - e64 } else { 0 };
    if dropped > 64 {
        // The magnitude is below half the smallest subnormal.
        return sign;
    }
    let dropped = dropped as u32;
    let sig = if dropped == 64 { 0 } else { frac >> dropped };
    let guard = frac >> (dropped - 1) & 1 != 0;
    let below = frac & ((1u64 << (dropped - 1)) - 1) != 0;
    let e_field = if e64 <= 0 { 0 } else { (e64 - 1) as u64 };
    let round_up = guard && (below || sticky || sig & 1 != 0);
    // `sig` keeps the implicit bit at bit 52 for a normal result, so
    // the add renormalizes: a carry out of the significand bumps the
    // exponent field, and reaching 0x7ff yields infinity.
    sign + ((e_field << 52) + sig + u64::from(round_up))
}

/// Widen a binary64 bit pattern to the x87 80-bit extended format:
/// `(fraction, sign_exponent)` where `fraction` holds the explicit
/// integer bit at bit 63. Exact for every input.
pub(crate) fn f64_to_f80(bits: u64) -> (u64, u16) {
    let sign = ((bits >> 63) as u16) << 15;
    let e = (bits >> 52) & 0x7ff;
    let m = bits & ((1u64 << 52) - 1);
    if e == 0x7ff {
        // Infinity keeps a zero fraction; a NaN keeps its payload and
        // is quieted, as the hardware widening conversion does.
        let quiet = if m != 0 { 1 << 62 } else { 0 };
        return ((1 << 63) | quiet | (m << 11), sign | 0x7fff);
    }
    if e == 0 {
        if m == 0 {
            return (0, sign);
        }
        // Subnormal: normalize so the integer bit is explicit.
        let sh = m.leading_zeros() as u64;
        return (m << sh, sign | (15372 - sh) as u16);
    }
    ((1 << 63) | (m << 11), sign | (e + 16383 - 1023) as u16)
}

/// Narrow an x87 80-bit extended value to binary64, rounding to
/// nearest with ties to even. An encoding with a clear integer bit
/// and a non-zero exponent (unnormal, pseudo-infinity, pseudo-NaN)
/// converts to the indefinite QNaN, as FSTP m64 does.
pub(crate) fn f80_to_f64(frac: u64, sign_exp: u16) -> u64 {
    let sign = (sign_exp >> 15) as u64;
    let e = (sign_exp & 0x7fff) as i64;
    if e != 0 && frac >> 63 == 0 {
        return 0xfff8_0000_0000_0000;
    }
    if e == 0x7fff {
        if frac & !(1 << 63) == 0 {
            return sign << 63 | 0x7ff << 52;
        }
        let m = (frac >> 11) & ((1u64 << 52) - 1);
        // A payload that truncates to zero still has to stay a NaN.
        return sign << 63 | 0x7ff << 52 | (1 << 51) | m;
    }
    if frac == 0 {
        return sign << 63;
    }
    // A denormal (and a pseudo-denormal) reads as if the exponent
    // field were 1.
    let eff = if e == 0 { 1 } else { e };
    let sh = frac.leading_zeros() as i64;
    round_to_f64(sign, eff - 16383 - sh, frac << sh, false)
}

/// Widen a binary64 bit pattern to IEEE binary128 as `(low, high)`
/// 64-bit halves. Exact for every input.
pub(crate) fn f64_to_f128(bits: u64) -> (u64, u64) {
    let sign = (bits >> 63) << 63;
    let e = (bits >> 52) & 0x7ff;
    let m = bits & ((1u64 << 52) - 1);
    if e == 0x7ff {
        // A NaN keeps its payload and is quieted (bit 111), as the
        // widening conversion does.
        let quiet = if m != 0 { 1 << 47 } else { 0 };
        return (m << 60, sign | 0x7fff << 48 | quiet | m >> 4);
    }
    if e == 0 {
        if m == 0 {
            return (0, sign);
        }
        // Subnormal: normalize; the leading bit becomes implicit.
        let sh = m.leading_zeros() as u64 - 11;
        let m = (m << sh) & ((1u64 << 52) - 1);
        let e128 = 16383 - 1022 - sh;
        return (m << 60, sign | e128 << 48 | m >> 4);
    }
    (m << 60, sign | (e + 16383 - 1023) << 48 | m >> 4)
}

/// Narrow an IEEE binary128 value to binary64, rounding to nearest
/// with ties to even.
pub(crate) fn f128_to_f64(lo: u64, hi: u64) -> u64 {
    let sign = hi >> 63;
    let e = ((hi >> 48) & 0x7fff) as i64;
    let mh = hi & ((1u64 << 48) - 1);
    if e == 0x7fff {
        if mh == 0 && lo == 0 {
            return sign << 63 | 0x7ff << 52;
        }
        let m = (mh << 4 | lo >> 60) & ((1u64 << 52) - 1);
        return sign << 63 | 0x7ff << 52 | (1 << 51) | m;
    }
    if e == 0 && mh == 0 && lo == 0 {
        return sign << 63;
    }
    // Top 64 significand bits as 1.63 fixed point; the rest is sticky.
    let implicit = u64::from(e != 0);
    let eff = if e == 0 { 1 } else { e };
    let frac = implicit << 63 | mh << 15 | lo >> 49;
    let sticky = lo & ((1u64 << 49) - 1) != 0;
    if frac == 0 {
        // Subnormal so small every kept bit is zero: underflows to
        // zero (the sticky remainder is below half an ulp of the
        // smallest subnormal).
        return sign << 63;
    }
    let sh = frac.leading_zeros() as i64;
    let shifted = frac << sh;
    // Bits shifted out the top never exist; bits revealed at the
    // bottom are zero, so the sticky classification is unchanged.
    round_to_f64(sign, eff - 16383 - sh, shifted, sticky)
}

/// 16-byte object image of a binary64 value in `kind`'s storage
/// format, little-endian, padding zeroed. For `F64` the low 8 bytes
/// carry the value and the high 8 are zero (callers size the copy).
pub(crate) fn long_double_image(bits: u64, kind: crate::c5::codegen::LongDoubleKind) -> [u8; 16] {
    let mut img = [0u8; 16];
    match kind {
        crate::c5::codegen::LongDoubleKind::F64 => {
            img[..8].copy_from_slice(&bits.to_le_bytes());
        }
        crate::c5::codegen::LongDoubleKind::X87 => {
            let (frac, se) = f64_to_f80(bits);
            img[..8].copy_from_slice(&frac.to_le_bytes());
            img[8..10].copy_from_slice(&se.to_le_bytes());
        }
        crate::c5::codegen::LongDoubleKind::Binary128 => {
            let (lo, hi) = f64_to_f128(bits);
            img[..8].copy_from_slice(&lo.to_le_bytes());
            img[8..].copy_from_slice(&hi.to_le_bytes());
        }
    }
    img
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Round-trip identity over the widened image: widening is exact,
    /// so narrowing must restore every starting pattern (NaN payloads
    /// included, modulo the quiet bit both formats preserve here).
    #[test]
    fn widen_then_narrow_is_identity() {
        let cases: &[u64] = &[
            0.0f64.to_bits(),
            (-0.0f64).to_bits(),
            1.0f64.to_bits(),
            1.5f64.to_bits(),
            (-2.7182818284590459f64).to_bits(),
            f64::MAX.to_bits(),
            f64::MIN_POSITIVE.to_bits(),
            5e-324f64.to_bits(), // smallest subnormal
            8.5e-320f64.to_bits(),
            f64::INFINITY.to_bits(),
            f64::NEG_INFINITY.to_bits(),
            f64::NAN.to_bits(),
            0x7ff8_dead_beef_cafe, // NaN with payload
            0x0008_0000_0000_0001, // subnormal near the normal edge
            0x0000_0000_0000_ffff,
            0x4340_0000_0000_0001, // 2^53 + 2
        ];
        for &b in cases {
            let (f, se) = f64_to_f80(b);
            assert_eq!(f80_to_f64(f, se), b, "f80 round trip of {b:#x}");
            let (lo, hi) = f64_to_f128(b);
            assert_eq!(f128_to_f64(lo, hi), b, "f128 round trip of {b:#x}");
        }
    }

    /// Deterministic pseudo-random patterns round-trip through both
    /// wide formats.
    #[test]
    fn widen_then_narrow_is_identity_fuzz() {
        let mut x = 0x9e3779b97f4a7c15u64;
        for _ in 0..20000 {
            x ^= x << 13;
            x ^= x >> 7;
            x ^= x << 17;
            let b = x;
            // Narrowing a signaling NaN sets the quiet bit, as the
            // hardware conversion does; everything else is identity.
            let want = if f64::from_bits(b).is_nan() {
                b | 1 << 51
            } else {
                b
            };
            let (f, se) = f64_to_f80(b);
            assert_eq!(f80_to_f64(f, se), want, "f80 round trip of {b:#x}");
            let (lo, hi) = f64_to_f128(b);
            assert_eq!(f128_to_f64(lo, hi), want, "f128 round trip of {b:#x}");
        }
    }

    /// Known widened encodings: 1.0 in each format.
    #[test]
    fn one_has_the_reference_encoding() {
        let (f, se) = f64_to_f80(1.0f64.to_bits());
        assert_eq!((f, se), (0x8000_0000_0000_0000, 0x3fff));
        let (lo, hi) = f64_to_f128(1.0f64.to_bits());
        assert_eq!((lo, hi), (0, 0x3fff_0000_0000_0000));
        let (lo, hi) = f64_to_f128((-1.0f64).to_bits());
        assert_eq!((lo, hi), (0, 0xbfff_0000_0000_0000));
    }

    /// Values only the wide formats represent narrow with round to
    /// nearest, ties to even.
    #[test]
    fn narrowing_rounds_to_nearest_even() {
        // 2^53 + 1 is representable in both wide formats and ties to
        // the even neighbor 2^53.
        let exact = (1u64 << 53) as f64; // 2^53
        let (mut f, se) = f64_to_f80(exact.to_bits());
        f |= 1 << 10; // + 1 ulp of the 53-bit significand's tail
        assert_eq!(f80_to_f64(f, se), exact.to_bits());
        // 2^53 + 1.5 rounds up to 2^53 + 2.
        let f_up = f | 1 << 9;
        assert_eq!(f80_to_f64(f_up, se), (((1u64 << 53) + 2) as f64).to_bits());
        let (lo, hi) = f64_to_f128(exact.to_bits());
        let lo_tie = lo | 1 << 59;
        assert_eq!(f128_to_f64(lo_tie, hi), exact.to_bits());
        let lo_up = lo_tie | 1;
        assert_eq!(
            f128_to_f64(lo_up, hi),
            (((1u64 << 53) + 2) as f64).to_bits()
        );
    }

    /// Magnitudes past binary64's range overflow to infinity, and
    /// magnitudes below its subnormal floor underflow to zero.
    #[test]
    fn narrowing_saturates_range() {
        // x87 max finite ~ 1.19e4932.
        assert_eq!(
            f80_to_f64(u64::MAX, 0x7ffe),
            f64::INFINITY.to_bits(),
            "f80 max overflows"
        );
        assert_eq!(
            f80_to_f64(u64::MAX, 0xfffe),
            f64::NEG_INFINITY.to_bits(),
            "negative f80 max overflows"
        );
        // Smallest x87 denormal underflows to +0.
        assert_eq!(f80_to_f64(1, 0), 0);
        // binary128 max finite overflows.
        assert_eq!(
            f128_to_f64(u64::MAX, 0x7ffe_ffff_ffff_ffff),
            f64::INFINITY.to_bits()
        );
        // Smallest binary128 subnormal underflows to +0.
        assert_eq!(f128_to_f64(1, 0), 0);
        // A value just above half the smallest binary64 subnormal
        // rounds up to it: 2^-1075 alone ties to zero, but any sticky
        // bit pushes it up.
        let (lo, hi) = f64_to_f128(5e-324f64.to_bits());
        // Halve it: exponent field decrements by one.
        let hi_half = hi - (1u64 << 48);
        assert_eq!(f128_to_f64(lo, hi_half), 0, "exact tie goes to even");
        assert_eq!(
            f128_to_f64(lo | 1, hi_half),
            5e-324f64.to_bits(),
            "sticky above the tie rounds up"
        );
    }

    /// Infinities and NaNs cross both directions; a NaN stays a NaN
    /// after its payload truncates.
    #[test]
    fn specials_survive() {
        for kind in [
            crate::c5::codegen::LongDoubleKind::X87,
            crate::c5::codegen::LongDoubleKind::Binary128,
        ] {
            let back = |img: &[u8; 16]| -> u64 {
                let w = |a: usize| u64::from_le_bytes(img[a..a + 8].try_into().unwrap());
                match kind {
                    crate::c5::codegen::LongDoubleKind::X87 => f80_to_f64(
                        w(0),
                        u16::from_le_bytes(img[8..10].try_into().unwrap()),
                    ),
                    _ => f128_to_f64(w(0), w(8)),
                }
            };
            for v in [f64::INFINITY, f64::NEG_INFINITY] {
                let img = long_double_image(v.to_bits(), kind);
                assert_eq!(back(&img), v.to_bits(), "{kind:?}");
            }
            let img = long_double_image(f64::NAN.to_bits(), kind);
            assert!(f64::from_bits(back(&img)).is_nan());
        }
        // A binary128 NaN whose payload lives only in the discarded
        // low bits still narrows to a NaN.
        assert!(f64::from_bits(f128_to_f64(1, 0x7fff_0000_0000_0000)).is_nan());
        assert!(f64::from_bits(f80_to_f64((1 << 63) | 1, 0x7fff)).is_nan());
    }

    /// The x87 explicit integer bit: an encoding with the bit clear
    /// and a non-zero exponent converts to the indefinite QNaN, as
    /// FSTP m64 does; a pseudo-denormal (bit set, exponent zero)
    /// reads at the denormal scale.
    #[test]
    fn f80_noncanonical_encodings_match_the_hardware() {
        assert_eq!(f80_to_f64(1 << 62, 0x4000), 0xfff8_0000_0000_0000);
        assert_eq!(f80_to_f64(0, 0x4000), 0xfff8_0000_0000_0000);
        assert_eq!(f80_to_f64(1 << 63, 0x7fff), f64::INFINITY.to_bits());
        assert_eq!(
            f80_to_f64(1 << 63, 0x0000),
            f64::from_bits(round_to_f64(0, 1 - 16383, 1 << 63, false)).to_bits()
        );
    }

    /// Image layout: x87 pads bytes 10..16 with zero; binary128 fills
    /// all 16.
    #[test]
    fn image_layout_matches_the_abi() {
        let img = long_double_image(1.0f64.to_bits(), crate::c5::codegen::LongDoubleKind::X87);
        assert_eq!(&img[..10], &[0, 0, 0, 0, 0, 0, 0, 0x80, 0xff, 0x3f]);
        assert_eq!(&img[10..], &[0; 6]);
        let img = long_double_image(
            1.0f64.to_bits(),
            crate::c5::codegen::LongDoubleKind::Binary128,
        );
        assert_eq!(img[15], 0x3f);
        assert_eq!(img[14], 0xff);
        assert_eq!(&img[..14], &[0; 14]);
    }
}

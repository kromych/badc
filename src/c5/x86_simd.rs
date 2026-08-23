//! The x86 SIMD intrinsic surface: one table row per `__builtin_ia32_*`
//! builtin the bundled x86 intrinsic headers call. A row names the
//! instruction to emit, the operand shape the parser checks and the walker
//! lowers, and the value semantics the interpreter evaluates, so the four
//! consumers cannot drift apart. The vector operands are the GCC
//! `vector_size(16)` types, which live in memory: the lowering loads each
//! into an xmm scratch, runs the instruction, and stores the result back.

/// Operand and result shape. `Shift` takes an immediate count when the
/// operand is a constant expression and the low quad of a register
/// otherwise; the byte-granular shift has the immediate form only.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum Form {
    /// `v128 = op(v128, v128)`.
    Vv,
    /// `v128 = op(v128, v128, imm8)`.
    VvI,
    /// `v128 = op(v128, imm8)`.
    VI,
    /// `v128 = op(v128)`.
    V,
    /// `v128 = op(v128, int)`.
    Shift,
    /// `v128 = *p`, unaligned.
    Load,
    /// `*p = v128`, unaligned.
    Store,
    /// `int = lane imm8 of v128`.
    Extract,
    /// `v128 = v128 with lane imm8 replaced by an int operand`.
    Insert,
    /// `int = carry`, the random value stored through the pointer operand.
    RdRand,
}

/// Value semantics, evaluated by the interpreter. Lane widths are in bytes.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum Sem {
    Add(u8),
    Sub(u8),
    And,
    Or,
    Xor,
    CmpEq(u8),
    Shl(u8),
    Shr(u8),
    /// Left shift of the whole register by a byte count.
    ShlBytes,
    /// Doubleword shuffle by an immediate selector.
    ShufD,
    /// Word shuffle of the high / low quad, the other quad copied.
    ShufHi,
    ShufLo,
    /// Byte shuffle by a vector index, a set index bit 7 zeroing the byte.
    ShufB,
    /// Double-precision element select from two sources.
    ShufPd,
    /// Interleave the low quads.
    UnpackLoQ,
    /// Carry-less multiply of the selected quads.
    ClMul,
    AesEnc,
    AesEncLast,
    AesDec,
    AesDecLast,
    AesImc,
    AesKeygen,
    /// Data movement: the form carries the direction.
    Move,
    /// Hardware random number generator.
    Rand,
}

pub(crate) struct SimdOp {
    pub name: &'static str,
    /// Instruction mnemonic, resolved through the x86 assembler's tables.
    pub mnem: &'static str,
    pub form: Form,
    pub sem: Sem,
    /// Width in bytes of the integer operand or result of the forms that
    /// have one (`Extract`, `Insert`, `Shift`, `RdRand`); 0 otherwise.
    pub int_width: u8,
}

const fn op(name: &'static str, mnem: &'static str, form: Form, sem: Sem, int_width: u8) -> SimdOp {
    SimdOp {
        name,
        mnem,
        form,
        sem,
        int_width,
    }
}

/// Every x86 SIMD builtin badc provides.
#[rustfmt::skip]
pub(crate) const OPS: &[SimdOp] = &[
    // SSE2 packed integer arithmetic and logic.
    op("__builtin_ia32_paddd128", "paddd", Form::Vv, Sem::Add(4), 0),
    op("__builtin_ia32_paddq128", "paddq", Form::Vv, Sem::Add(8), 0),
    op("__builtin_ia32_psubq128", "psubq", Form::Vv, Sem::Sub(8), 0),
    op("__builtin_ia32_pand128", "pand", Form::Vv, Sem::And, 0),
    op("__builtin_ia32_por128", "por", Form::Vv, Sem::Or, 0),
    op("__builtin_ia32_pxor128", "pxor", Form::Vv, Sem::Xor, 0),
    op("__builtin_ia32_punpcklqdq128", "punpcklqdq", Form::Vv, Sem::UnpackLoQ, 0),
    // SSE2 shifts. The `i` forms take a count in bits; `pslldqi128` counts
    // bits too and the header divides by 8, as gcc's does.
    op("__builtin_ia32_psllwi128", "psllw", Form::Shift, Sem::Shl(2), 4),
    op("__builtin_ia32_pslldi128", "pslld", Form::Shift, Sem::Shl(4), 4),
    op("__builtin_ia32_psllqi128", "psllq", Form::Shift, Sem::Shl(8), 4),
    op("__builtin_ia32_psrlwi128", "psrlw", Form::Shift, Sem::Shr(2), 4),
    op("__builtin_ia32_psrldi128", "psrld", Form::Shift, Sem::Shr(4), 4),
    op("__builtin_ia32_psrlqi128", "psrlq", Form::Shift, Sem::Shr(8), 4),
    op("__builtin_ia32_pslldqi128", "pslldq", Form::Shift, Sem::ShlBytes, 4),
    // SSE2 shuffles and element access.
    op("__builtin_ia32_pshufd", "pshufd", Form::VI, Sem::ShufD, 0),
    op("__builtin_ia32_pshufhw", "pshufhw", Form::VI, Sem::ShufHi, 0),
    op("__builtin_ia32_pshuflw", "pshuflw", Form::VI, Sem::ShufLo, 0),
    op("__builtin_ia32_shufpd", "shufpd", Form::VvI, Sem::ShufPd, 0),
    op("__builtin_ia32_vec_ext_v8hi", "pextrw", Form::Extract, Sem::Move, 2),
    // SSE2 unaligned 128-bit transfers.
    op("__builtin_ia32_loaddqu", "movdqu", Form::Load, Sem::Move, 0),
    op("__builtin_ia32_storedqu", "movdqu", Form::Store, Sem::Move, 0),
    // SSSE3.
    op("__builtin_ia32_pshufb128", "pshufb", Form::Vv, Sem::ShufB, 0),
    // SSE4.1.
    op("__builtin_ia32_pcmpeqq", "pcmpeqq", Form::Vv, Sem::CmpEq(8), 0),
    op("__builtin_ia32_vec_ext_v4si", "pextrd", Form::Extract, Sem::Move, 4),
    op("__builtin_ia32_vec_set_v4si", "pinsrd", Form::Insert, Sem::Move, 4),
    // AES-NI.
    op("__builtin_ia32_aesenc128", "aesenc", Form::Vv, Sem::AesEnc, 0),
    op("__builtin_ia32_aesenclast128", "aesenclast", Form::Vv, Sem::AesEncLast, 0),
    op("__builtin_ia32_aesdec128", "aesdec", Form::Vv, Sem::AesDec, 0),
    op("__builtin_ia32_aesdeclast128", "aesdeclast", Form::Vv, Sem::AesDecLast, 0),
    op("__builtin_ia32_aesimc128", "aesimc", Form::V, Sem::AesImc, 0),
    op("__builtin_ia32_aeskeygenassist128", "aeskeygenassist", Form::VI, Sem::AesKeygen, 0),
    // PCLMUL.
    op("__builtin_ia32_pclmulqdq128", "pclmulqdq", Form::VvI, Sem::ClMul, 0),
    // RDRAND.
    op("__builtin_ia32_rdrand16_step", "rdrand", Form::RdRand, Sem::Rand, 2),
    op("__builtin_ia32_rdrand32_step", "rdrand", Form::RdRand, Sem::Rand, 4),
    op("__builtin_ia32_rdrand64_step", "rdrand", Form::RdRand, Sem::Rand, 8),
];

/// The table index of `name`, or `None` when it is not a SIMD builtin.
pub(crate) fn lookup(name: &str) -> Option<u32> {
    OPS.iter().position(|o| o.name == name).map(|i| i as u32)
}

pub(crate) fn get(index: u32) -> &'static SimdOp {
    &OPS[index as usize]
}

impl Form {
    /// Number of source operands the builtin call takes.
    pub(crate) fn arity(self) -> usize {
        match self {
            Form::V | Form::Load | Form::RdRand => 1,
            Form::Vv | Form::VI | Form::Shift | Form::Store | Form::Extract => 2,
            Form::VvI | Form::Insert => 3,
        }
    }

    /// Whether the last operand must be an integer constant expression that
    /// the instruction encodes as `imm8`.
    pub(crate) fn takes_imm(self) -> bool {
        matches!(self, Form::VvI | Form::VI | Form::Extract | Form::Insert)
    }

    /// Whether the result is a 128-bit vector rather than an `int`.
    pub(crate) fn returns_vector(self) -> bool {
        matches!(
            self,
            Form::Vv | Form::VvI | Form::VI | Form::V | Form::Shift | Form::Load | Form::Insert
        )
    }
}

// Value semantics over the 16-byte little-endian operand images.

fn lane(v: &[u8; 16], width: u8, i: usize) -> u64 {
    let off = i * width as usize;
    let mut x = 0u64;
    for k in 0..width as usize {
        x |= (v[off + k] as u64) << (8 * k);
    }
    x
}

fn set_lane(v: &mut [u8; 16], width: u8, i: usize, x: u64) {
    let off = i * width as usize;
    for k in 0..width as usize {
        v[off + k] = (x >> (8 * k)) as u8;
    }
}

fn mask(width: u8) -> u64 {
    if width >= 8 {
        u64::MAX
    } else {
        (1u64 << (8 * width as u32)) - 1
    }
}

/// AES S-box (FIPS-197 figure 7).
#[rustfmt::skip]
const SBOX: [u8; 256] = [
    0x63,0x7c,0x77,0x7b,0xf2,0x6b,0x6f,0xc5,0x30,0x01,0x67,0x2b,0xfe,0xd7,0xab,0x76,
    0xca,0x82,0xc9,0x7d,0xfa,0x59,0x47,0xf0,0xad,0xd4,0xa2,0xaf,0x9c,0xa4,0x72,0xc0,
    0xb7,0xfd,0x93,0x26,0x36,0x3f,0xf7,0xcc,0x34,0xa5,0xe5,0xf1,0x71,0xd8,0x31,0x15,
    0x04,0xc7,0x23,0xc3,0x18,0x96,0x05,0x9a,0x07,0x12,0x80,0xe2,0xeb,0x27,0xb2,0x75,
    0x09,0x83,0x2c,0x1a,0x1b,0x6e,0x5a,0xa0,0x52,0x3b,0xd6,0xb3,0x29,0xe3,0x2f,0x84,
    0x53,0xd1,0x00,0xed,0x20,0xfc,0xb1,0x5b,0x6a,0xcb,0xbe,0x39,0x4a,0x4c,0x58,0xcf,
    0xd0,0xef,0xaa,0xfb,0x43,0x4d,0x33,0x85,0x45,0xf9,0x02,0x7f,0x50,0x3c,0x9f,0xa8,
    0x51,0xa3,0x40,0x8f,0x92,0x9d,0x38,0xf5,0xbc,0xb6,0xda,0x21,0x10,0xff,0xf3,0xd2,
    0xcd,0x0c,0x13,0xec,0x5f,0x97,0x44,0x17,0xc4,0xa7,0x7e,0x3d,0x64,0x5d,0x19,0x73,
    0x60,0x81,0x4f,0xdc,0x22,0x2a,0x90,0x88,0x46,0xee,0xb8,0x14,0xde,0x5e,0x0b,0xdb,
    0xe0,0x32,0x3a,0x0a,0x49,0x06,0x24,0x5c,0xc2,0xd3,0xac,0x62,0x91,0x95,0xe4,0x79,
    0xe7,0xc8,0x37,0x6d,0x8d,0xd5,0x4e,0xa9,0x6c,0x56,0xf4,0xea,0x65,0x7a,0xae,0x08,
    0xba,0x78,0x25,0x2e,0x1c,0xa6,0xb4,0xc6,0xe8,0xdd,0x74,0x1f,0x4b,0xbd,0x8b,0x8a,
    0x70,0x3e,0xb5,0x66,0x48,0x03,0xf6,0x0e,0x61,0x35,0x57,0xb9,0x86,0xc1,0x1d,0x9e,
    0xe1,0xf8,0x98,0x11,0x69,0xd9,0x8e,0x94,0x9b,0x1e,0x87,0xe9,0xce,0x55,0x28,0xdf,
    0x8c,0xa1,0x89,0x0d,0xbf,0xe6,0x42,0x68,0x41,0x99,0x2d,0x0f,0xb0,0x54,0xbb,0x16,
];

const fn inverse_sbox() -> [u8; 256] {
    let mut t = [0u8; 256];
    let mut i = 0;
    while i < 256 {
        t[SBOX[i] as usize] = i as u8;
        i += 1;
    }
    t
}

const INV_SBOX: [u8; 256] = inverse_sbox();

/// Multiply in GF(2^8) modulo the AES polynomial x^8 + x^4 + x^3 + x + 1.
fn gmul(mut a: u8, mut b: u8) -> u8 {
    let mut r = 0u8;
    while b != 0 {
        if b & 1 != 0 {
            r ^= a;
        }
        let hi = a & 0x80;
        a <<= 1;
        if hi != 0 {
            a ^= 0x1b;
        }
        b >>= 1;
    }
    r
}

/// The AES state is column-major: byte `4*c + r` is row `r` of column `c`.
fn shift_rows(s: &[u8; 16]) -> [u8; 16] {
    let mut o = [0u8; 16];
    for c in 0..4 {
        for r in 0..4 {
            o[4 * c + r] = s[4 * ((c + r) % 4) + r];
        }
    }
    o
}

fn inv_shift_rows(s: &[u8; 16]) -> [u8; 16] {
    let mut o = [0u8; 16];
    for c in 0..4 {
        for r in 0..4 {
            o[4 * ((c + r) % 4) + r] = s[4 * c + r];
        }
    }
    o
}

fn sub_bytes(s: &[u8; 16]) -> [u8; 16] {
    let mut o = [0u8; 16];
    for i in 0..16 {
        o[i] = SBOX[s[i] as usize];
    }
    o
}

fn inv_sub_bytes(s: &[u8; 16]) -> [u8; 16] {
    let mut o = [0u8; 16];
    for i in 0..16 {
        o[i] = INV_SBOX[s[i] as usize];
    }
    o
}

fn mix_columns(s: &[u8; 16], m: [[u8; 4]; 4]) -> [u8; 16] {
    let mut o = [0u8; 16];
    for c in 0..4 {
        for r in 0..4 {
            let mut acc = 0u8;
            for k in 0..4 {
                acc ^= gmul(m[r][k], s[4 * c + k]);
            }
            o[4 * c + r] = acc;
        }
    }
    o
}

const MIX: [[u8; 4]; 4] = [[2, 3, 1, 1], [1, 2, 3, 1], [1, 1, 2, 3], [3, 1, 1, 2]];

const INV_MIX: [[u8; 4]; 4] = [
    [14, 11, 13, 9],
    [9, 14, 11, 13],
    [13, 9, 14, 11],
    [11, 13, 9, 14],
];

fn xor16(a: &[u8; 16], b: &[u8; 16]) -> [u8; 16] {
    let mut o = [0u8; 16];
    for i in 0..16 {
        o[i] = a[i] ^ b[i];
    }
    o
}

fn rot_word(x: u32) -> u32 {
    x.rotate_right(8)
}

fn sub_word(x: u32) -> u32 {
    let b = x.to_le_bytes();
    u32::from_le_bytes([
        SBOX[b[0] as usize],
        SBOX[b[1] as usize],
        SBOX[b[2] as usize],
        SBOX[b[3] as usize],
    ])
}

/// Carry-less multiply of two 64-bit operands into 128 bits.
fn clmul(a: u64, b: u64) -> (u64, u64) {
    let mut lo = 0u64;
    let mut hi = 0u64;
    for i in 0..64 {
        if (b >> i) & 1 != 0 {
            lo ^= a << i;
            if i > 0 {
                hi ^= a >> (64 - i);
            }
        }
    }
    (lo, hi)
}

/// Evaluate one 128-bit-result builtin. `imm` is the encoded immediate (0
/// for the forms that take none) and `count` the shift count in the units
/// the instruction takes: bits for the lane shifts, bytes for `pslldq`.
pub(crate) fn eval(sem: Sem, a: &[u8; 16], b: &[u8; 16], imm: u8, count: u64) -> [u8; 16] {
    let mut o = [0u8; 16];
    match sem {
        Sem::Add(w) => {
            for i in 0..16 / w as usize {
                let x = lane(a, w, i).wrapping_add(lane(b, w, i)) & mask(w);
                set_lane(&mut o, w, i, x);
            }
        }
        Sem::Sub(w) => {
            for i in 0..16 / w as usize {
                let x = lane(a, w, i).wrapping_sub(lane(b, w, i)) & mask(w);
                set_lane(&mut o, w, i, x);
            }
        }
        Sem::And => {
            for i in 0..16 {
                o[i] = a[i] & b[i];
            }
        }
        Sem::Or => {
            for i in 0..16 {
                o[i] = a[i] | b[i];
            }
        }
        Sem::Xor => o = xor16(a, b),
        Sem::CmpEq(w) => {
            for i in 0..16 / w as usize {
                let eq = lane(a, w, i) == lane(b, w, i);
                set_lane(&mut o, w, i, if eq { mask(w) } else { 0 });
            }
        }
        Sem::Shl(w) => {
            for i in 0..16 / w as usize {
                let x = if count >= 8 * w as u64 {
                    0
                } else {
                    (lane(a, w, i) << count) & mask(w)
                };
                set_lane(&mut o, w, i, x);
            }
        }
        Sem::Shr(w) => {
            for i in 0..16 / w as usize {
                let x = if count >= 8 * w as u64 {
                    0
                } else {
                    lane(a, w, i) >> count
                };
                set_lane(&mut o, w, i, x);
            }
        }
        Sem::ShlBytes => {
            let n = (count as usize).min(16);
            o[n..].copy_from_slice(&a[..16 - n]);
        }
        Sem::ShufD => {
            for i in 0..4 {
                let sel = ((imm >> (2 * i)) & 3) as usize;
                set_lane(&mut o, 4, i, lane(a, 4, sel));
            }
        }
        Sem::ShufHi => {
            for i in 0..4 {
                set_lane(&mut o, 2, i, lane(a, 2, i));
            }
            for i in 0..4 {
                let sel = ((imm >> (2 * i)) & 3) as usize;
                set_lane(&mut o, 2, 4 + i, lane(a, 2, 4 + sel));
            }
        }
        Sem::ShufLo => {
            for i in 0..4 {
                let sel = ((imm >> (2 * i)) & 3) as usize;
                set_lane(&mut o, 2, i, lane(a, 2, sel));
            }
            for i in 4..8 {
                set_lane(&mut o, 2, i, lane(a, 2, i));
            }
        }
        Sem::ShufB => {
            for i in 0..16 {
                o[i] = if b[i] & 0x80 != 0 {
                    0
                } else {
                    a[(b[i] & 0x0f) as usize]
                };
            }
        }
        Sem::ShufPd => {
            set_lane(&mut o, 8, 0, lane(a, 8, (imm & 1) as usize));
            set_lane(&mut o, 8, 1, lane(b, 8, ((imm >> 1) & 1) as usize));
        }
        Sem::UnpackLoQ => {
            set_lane(&mut o, 8, 0, lane(a, 8, 0));
            set_lane(&mut o, 8, 1, lane(b, 8, 0));
        }
        Sem::ClMul => {
            let x = lane(a, 8, ((imm & 1) != 0) as usize);
            let y = lane(b, 8, ((imm & 0x10) != 0) as usize);
            let (lo, hi) = clmul(x, y);
            set_lane(&mut o, 8, 0, lo);
            set_lane(&mut o, 8, 1, hi);
        }
        Sem::AesEnc => {
            let s = mix_columns(&sub_bytes(&shift_rows(a)), MIX);
            o = xor16(&s, b);
        }
        Sem::AesEncLast => {
            let s = sub_bytes(&shift_rows(a));
            o = xor16(&s, b);
        }
        Sem::AesDec => {
            let s = mix_columns(&inv_sub_bytes(&inv_shift_rows(a)), INV_MIX);
            o = xor16(&s, b);
        }
        Sem::AesDecLast => {
            let s = inv_sub_bytes(&inv_shift_rows(a));
            o = xor16(&s, b);
        }
        Sem::AesImc => o = mix_columns(a, INV_MIX),
        Sem::AesKeygen => {
            let x1 = lane(a, 4, 1) as u32;
            let x3 = lane(a, 4, 3) as u32;
            set_lane(&mut o, 4, 0, sub_word(x1) as u64);
            set_lane(&mut o, 4, 1, (rot_word(sub_word(x1)) ^ imm as u32) as u64);
            set_lane(&mut o, 4, 2, sub_word(x3) as u64);
            set_lane(&mut o, 4, 3, (rot_word(sub_word(x3)) ^ imm as u32) as u64);
        }
        Sem::Move | Sem::Rand => o = *a,
    }
    o
}

/// `Form::Extract`: the selected lane, zero-extended.
pub(crate) fn eval_extract(a: &[u8; 16], width: u8, imm: u8) -> u64 {
    let lanes = 16 / width as usize;
    lane(a, width, imm as usize % lanes)
}

/// `Form::Insert`: `a` with the selected lane replaced.
pub(crate) fn eval_insert(a: &[u8; 16], width: u8, imm: u8, value: u64) -> [u8; 16] {
    let lanes = 16 / width as usize;
    let mut o = *a;
    set_lane(&mut o, width, imm as usize % lanes, value & mask(width));
    o
}

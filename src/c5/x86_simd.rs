//! The x86 SIMD intrinsic surface: one table row per `__builtin_ia32_*`
//! builtin the bundled x86 intrinsic headers call. A row names the
//! instruction to emit, the operand shape the parser checks and the walker
//! lowers, the result type the parser gives the call, and the value
//! semantics the interpreter evaluates, so the four consumers cannot drift
//! apart. The vector operands are the
//! `vector_size(16)` types, which live in memory: the lowering loads each
//! into an xmm scratch, runs the instruction, and stores the result back.

use super::token::Ty;

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
    /// `int = the sign bits of the byte lanes of v128`.
    MoveMask,
    /// `int = carry`, the random value stored through the pointer operand.
    RdRand,
    /// `int` or `long long` = the low lane of v128 converted.
    ToInt,
}

/// Result type, as the builtin's prototype declares it: one of the headers'
/// `vector_size(16)` typedefs, `int`, or `void` for the store.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum Ret {
    V16qi,
    V8hi,
    V4si,
    V2di,
    V2df,
    V4sf,
    /// The 8-byte vectors of the MMX forms.
    V8qi,
    V4hi,
    V2si,
    V1di,
    Int,
    Int64,
    Void,
}

impl Ret {
    /// Lane type of a vector result; `None` for a scalar or void one.
    pub(crate) fn lane_ty(self) -> Option<Ty> {
        match self {
            Ret::V16qi => Some(Ty::Char),
            Ret::V8hi => Some(Ty::Short),
            Ret::V4si => Some(Ty::Int),
            Ret::V2di => Some(Ty::LongLong),
            Ret::V2df => Some(Ty::Double),
            Ret::V4sf => Some(Ty::Float),
            Ret::V8qi => Some(Ty::Char),
            Ret::V4hi => Some(Ty::Short),
            Ret::V2si => Some(Ty::Int),
            Ret::V1di => Some(Ty::LongLong),
            Ret::Int | Ret::Int64 | Ret::Void => None,
        }
    }
}

/// Value semantics, evaluated by the interpreter. Lane widths are in bytes.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum Sem {
    Add(u8),
    Sub(u8),
    /// Low half of the lane-wise product.
    MulLo(u8),
    /// High half of the lane-wise product, signed (`true`) or unsigned.
    MulHi(u8, bool),
    /// Unsigned lane average, rounded up.
    Avg(u8),
    /// Lane-wise minimum and maximum, signed (`true`) or unsigned.
    Min(u8, bool),
    Max(u8, bool),
    /// Signed products of adjacent word pairs, summed into doublewords.
    MulAddWords,
    /// Products of the first operand's unsigned bytes and the second's
    /// signed bytes, adjacent pairs summed into words with signed saturation.
    MulAddBytes,
    /// Lane-wise sum and difference, saturated to the signed (`true`) or
    /// unsigned range of the lane.
    AddSat(u8, bool),
    SubSat(u8, bool),
    /// Sum of the absolute byte differences of each quad, in its low word.
    SadBytes,
    And,
    AndNot,
    Or,
    Xor,
    CmpEq(u8),
    /// Signed lane comparison.
    CmpGt(u8),
    Shl(u8),
    Shr(u8),
    /// Arithmetic (sign-propagating) right shift.
    Sar(u8),
    /// Left shift of the whole register by a byte count.
    ShlBytes,
    /// Right shift of the whole register by a byte count.
    ShrBytes,
    /// Saturating pack of signed lanes into signed lanes of half the width,
    /// the first operand's lanes first.
    PackSigned(u8),
    /// Saturating pack of signed lanes into unsigned lanes of half the width.
    PackUnsigned(u8),
    /// Interleave the lanes of the low half of each operand.
    UnpackLo(u8),
    /// Interleave the lanes of the high half of each operand.
    UnpackHi(u8),
    /// Doubleword shuffle by an immediate selector.
    ShufD,
    /// Word shuffle of the high / low quad, the other quad copied.
    ShufHi,
    ShufLo,
    /// Byte shuffle by a vector index, a set index bit 7 zeroing the byte.
    ShufB,
    /// Lane magnitude, the most negative value its own.
    Abs(u8),
    /// The first operand's lane negated, kept or zeroed by the second's sign.
    Sign(u8),
    /// Adjacent-lane sums or differences, the first operand's low; `true` saturates.
    HAdd(u8, bool),
    HSub(u8, bool),
    /// Signed word products, bits 30:15 rounded at bit 14.
    MulHrs,
    /// The operands concatenated, the first high, shifted right by imm8 bytes.
    AlignR,
    /// Double-precision element select from two sources.
    ShufPd,
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
    /// Products of each quadword's low doubleword, signed when `true`.
    MulEven(bool),
    /// The low lanes widened from the first width to the second, signed when `true`.
    Extend(u8, u8, bool),
    /// Lane `i` of the second operand where immediate bit `i` is set.
    Blend(u8),
    /// Floating-point arithmetic on lanes of the width; the scalar form
    /// computes lane 0 alone, the others from the first operand.
    Float(FOp, u8, bool),
    /// A floating-point comparison by the imm8 predicate (0 eq, 1 lt, 2 le,
    /// 3 unord, 4 neq, 5 nlt, 6 nle, 7 ord): a lane of ones where it holds.
    FloatCmp(u8, bool),
    /// A conversion between integer and floating lanes.
    Convert(Cvt),
    /// The low lane of the width converted to an integer of the row's
    /// `int_width`, by the rounding direction or truncating.
    ToInt(u8, bool),
}

impl Sem {
    /// Whether the integer operation gives the same result with its two
    /// operands swapped, so a lowering may name either first.
    pub(crate) fn commutes(self) -> bool {
        matches!(
            self,
            Sem::Add(_)
                | Sem::MulLo(_)
                | Sem::MulHi(..)
                | Sem::Avg(_)
                | Sem::Min(..)
                | Sem::Max(..)
                | Sem::MulAddWords
                | Sem::AddSat(..)
                | Sem::SadBytes
                | Sem::And
                | Sem::Or
                | Sem::Xor
                | Sem::CmpEq(_)
        )
    }
}

/// A floating-point lane operation. MIN and MAX give the second operand
/// unless the first is strictly less (greater), a NaN or two zeros included.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum FOp {
    Add,
    Sub,
    Mul,
    Div,
    Min,
    Max,
    Sqrt,
}

/// A conversion, from the low lanes of the source to the low lanes of the
/// result, the rest zero. An int32 result is 0x80000000 for a NaN or a value
/// out of range.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum Cvt {
    IntToSingle,
    SingleToInt { truncate: bool },
    UIntToSingle,
    SingleToUInt { truncate: bool },
    IntToDouble,
    DoubleToInt { truncate: bool },
    SingleToDouble,
    DoubleToSingle,
}

/// The floating-point environment a row's lanes compute in, which rounds in
/// its direction and raises its exceptions. A lane is a `double` bit
/// pattern, a `float` one widened.
pub(crate) trait FloatEnv {
    fn arith(&mut self, op: FOp, a: u64, b: u64, single: bool) -> u64;
    /// `None` when unordered. A signaling comparison raises invalid for
    /// any NaN, a quiet one for a signaling NaN.
    fn compare(&mut self, a: u64, b: u64, signaling: bool) -> Option<core::cmp::Ordering>;
    /// A `bits`-wide integer, at most 32 bits when unsigned; the integer
    /// indefinite, the signed minimum or the unsigned maximum, for a NaN or
    /// a value out of range.
    fn to_int(&mut self, a: u64, truncate: bool, bits: u32, signed: bool) -> i64;
    fn integer_to_float(&mut self, n: i64, single: bool) -> u64;
    fn to_single(&mut self, a: u64) -> u64;
    /// A `float` lane as a `double` result: a signaling NaN quieted, with
    /// invalid.
    fn widen(&mut self, a: u64) -> u64;
}

pub(crate) struct SimdOp {
    pub name: &'static str,
    /// Instruction mnemonic, resolved through the x86 assembler's tables.
    pub mnem: &'static str,
    pub form: Form,
    pub ret: Ret,
    pub sem: Sem,
    /// Width in bytes of the integer operand or result of the forms that
    /// have one (`Extract`, `Insert`, `Shift`, `RdRand`); 0 otherwise.
    pub int_width: u8,
    /// Width in bytes of the vector operands and result: 16, or 8 for an
    /// MMX form, which runs as the SSE instruction on the low half of the
    /// xmm registers, every lane of its result within that half.
    pub bytes: u8,
}

const fn op(
    name: &'static str,
    mnem: &'static str,
    form: Form,
    ret: Ret,
    sem: Sem,
    int_width: u8,
) -> SimdOp {
    SimdOp {
        name,
        mnem,
        form,
        ret,
        sem,
        int_width,
        bytes: 16,
    }
}

/// An MMX form of a two-operand row: gcc's builtin over 8-byte vectors.
const fn op64(name: &'static str, mnem: &'static str, ret: Ret, sem: Sem) -> SimdOp {
    SimdOp {
        name,
        mnem,
        form: Form::Vv,
        ret,
        sem,
        int_width: 0,
        bytes: 8,
    }
}

/// Every x86 SIMD builtin badc provides.
#[rustfmt::skip]
pub(crate) const OPS: &[SimdOp] = &[
    // SSE2 packed integer arithmetic and logic.
    op("__builtin_ia32_paddb128", "paddb", Form::Vv, Ret::V16qi, Sem::Add(1), 0),
    op("__builtin_ia32_paddw128", "paddw", Form::Vv, Ret::V8hi, Sem::Add(2), 0),
    op("__builtin_ia32_paddd128", "paddd", Form::Vv, Ret::V4si, Sem::Add(4), 0),
    op("__builtin_ia32_paddq128", "paddq", Form::Vv, Ret::V2di, Sem::Add(8), 0),
    op("__builtin_ia32_psubb128", "psubb", Form::Vv, Ret::V16qi, Sem::Sub(1), 0),
    op("__builtin_ia32_psubw128", "psubw", Form::Vv, Ret::V8hi, Sem::Sub(2), 0),
    op("__builtin_ia32_psubd128", "psubd", Form::Vv, Ret::V4si, Sem::Sub(4), 0),
    op("__builtin_ia32_psubq128", "psubq", Form::Vv, Ret::V2di, Sem::Sub(8), 0),
    op("__builtin_ia32_pmullw128", "pmullw", Form::Vv, Ret::V8hi, Sem::MulLo(2), 0),
    op("__builtin_ia32_pmulhw128", "pmulhw", Form::Vv, Ret::V8hi, Sem::MulHi(2, true), 0),
    op("__builtin_ia32_pmulhuw128", "pmulhuw", Form::Vv, Ret::V8hi, Sem::MulHi(2, false), 0),
    op("__builtin_ia32_pmaddwd128", "pmaddwd", Form::Vv, Ret::V4si, Sem::MulAddWords, 0),
    op("__builtin_ia32_pand128", "pand", Form::Vv, Ret::V2di, Sem::And, 0),
    op("__builtin_ia32_pandn128", "pandn", Form::Vv, Ret::V2di, Sem::AndNot, 0),
    op("__builtin_ia32_por128", "por", Form::Vv, Ret::V2di, Sem::Or, 0),
    op("__builtin_ia32_pxor128", "pxor", Form::Vv, Ret::V2di, Sem::Xor, 0),
    op("__builtin_ia32_pcmpeqb128", "pcmpeqb", Form::Vv, Ret::V16qi, Sem::CmpEq(1), 0),
    op("__builtin_ia32_pcmpeqw128", "pcmpeqw", Form::Vv, Ret::V8hi, Sem::CmpEq(2), 0),
    op("__builtin_ia32_pcmpeqd128", "pcmpeqd", Form::Vv, Ret::V4si, Sem::CmpEq(4), 0),
    op("__builtin_ia32_pcmpgtb128", "pcmpgtb", Form::Vv, Ret::V16qi, Sem::CmpGt(1), 0),
    op("__builtin_ia32_pcmpgtw128", "pcmpgtw", Form::Vv, Ret::V8hi, Sem::CmpGt(2), 0),
    op("__builtin_ia32_pcmpgtd128", "pcmpgtd", Form::Vv, Ret::V4si, Sem::CmpGt(4), 0),
    // SSE2 saturating arithmetic and the sum of absolute differences.
    op("__builtin_ia32_paddsb128", "paddsb", Form::Vv, Ret::V16qi, Sem::AddSat(1, true), 0),
    op("__builtin_ia32_paddsw128", "paddsw", Form::Vv, Ret::V8hi, Sem::AddSat(2, true), 0),
    op("__builtin_ia32_paddusb128", "paddusb", Form::Vv, Ret::V16qi, Sem::AddSat(1, false), 0),
    op("__builtin_ia32_paddusw128", "paddusw", Form::Vv, Ret::V8hi, Sem::AddSat(2, false), 0),
    op("__builtin_ia32_psubsb128", "psubsb", Form::Vv, Ret::V16qi, Sem::SubSat(1, true), 0),
    op("__builtin_ia32_psubsw128", "psubsw", Form::Vv, Ret::V8hi, Sem::SubSat(2, true), 0),
    op("__builtin_ia32_psubusb128", "psubusb", Form::Vv, Ret::V16qi, Sem::SubSat(1, false), 0),
    op("__builtin_ia32_psubusw128", "psubusw", Form::Vv, Ret::V8hi, Sem::SubSat(2, false), 0),
    op("__builtin_ia32_psadbw128", "psadbw", Form::Vv, Ret::V2di, Sem::SadBytes, 0),
    // SSE2 averages, minimums and maximums.
    op("__builtin_ia32_pavgb128", "pavgb", Form::Vv, Ret::V16qi, Sem::Avg(1), 0),
    op("__builtin_ia32_pavgw128", "pavgw", Form::Vv, Ret::V8hi, Sem::Avg(2), 0),
    op("__builtin_ia32_pminsw128", "pminsw", Form::Vv, Ret::V8hi, Sem::Min(2, true), 0),
    op("__builtin_ia32_pmaxsw128", "pmaxsw", Form::Vv, Ret::V8hi, Sem::Max(2, true), 0),
    op("__builtin_ia32_pminub128", "pminub", Form::Vv, Ret::V16qi, Sem::Min(1, false), 0),
    op("__builtin_ia32_pmaxub128", "pmaxub", Form::Vv, Ret::V16qi, Sem::Max(1, false), 0),
    // SSE logic on single-precision lanes.
    op("__builtin_ia32_andps", "andps", Form::Vv, Ret::V4sf, Sem::And, 0),
    op("__builtin_ia32_andnps", "andnps", Form::Vv, Ret::V4sf, Sem::AndNot, 0),
    op("__builtin_ia32_orps", "orps", Form::Vv, Ret::V4sf, Sem::Or, 0),
    op("__builtin_ia32_xorps", "xorps", Form::Vv, Ret::V4sf, Sem::Xor, 0),
    // SSE2 pack and interleave.
    op("__builtin_ia32_packsswb128", "packsswb", Form::Vv, Ret::V16qi, Sem::PackSigned(2), 0),
    op("__builtin_ia32_packssdw128", "packssdw", Form::Vv, Ret::V8hi, Sem::PackSigned(4), 0),
    op("__builtin_ia32_packuswb128", "packuswb", Form::Vv, Ret::V16qi, Sem::PackUnsigned(2), 0),
    op("__builtin_ia32_punpcklbw128", "punpcklbw", Form::Vv, Ret::V16qi, Sem::UnpackLo(1), 0),
    op("__builtin_ia32_punpcklwd128", "punpcklwd", Form::Vv, Ret::V8hi, Sem::UnpackLo(2), 0),
    op("__builtin_ia32_punpckldq128", "punpckldq", Form::Vv, Ret::V4si, Sem::UnpackLo(4), 0),
    op("__builtin_ia32_punpcklqdq128", "punpcklqdq", Form::Vv, Ret::V2di, Sem::UnpackLo(8), 0),
    op("__builtin_ia32_punpckhbw128", "punpckhbw", Form::Vv, Ret::V16qi, Sem::UnpackHi(1), 0),
    op("__builtin_ia32_punpckhwd128", "punpckhwd", Form::Vv, Ret::V8hi, Sem::UnpackHi(2), 0),
    op("__builtin_ia32_punpckhdq128", "punpckhdq", Form::Vv, Ret::V4si, Sem::UnpackHi(4), 0),
    op("__builtin_ia32_punpckhqdq128", "punpckhqdq", Form::Vv, Ret::V2di, Sem::UnpackHi(8), 0),
    // SSE2 shifts. The `i` forms take a count in bits; the byte-granular
    // pair counts bits too and the header divides by 8, as gcc's does.
    op("__builtin_ia32_psllwi128", "psllw", Form::Shift, Ret::V8hi, Sem::Shl(2), 4),
    op("__builtin_ia32_pslldi128", "pslld", Form::Shift, Ret::V4si, Sem::Shl(4), 4),
    op("__builtin_ia32_psllqi128", "psllq", Form::Shift, Ret::V2di, Sem::Shl(8), 4),
    op("__builtin_ia32_psrlwi128", "psrlw", Form::Shift, Ret::V8hi, Sem::Shr(2), 4),
    op("__builtin_ia32_psrldi128", "psrld", Form::Shift, Ret::V4si, Sem::Shr(4), 4),
    op("__builtin_ia32_psrlqi128", "psrlq", Form::Shift, Ret::V2di, Sem::Shr(8), 4),
    op("__builtin_ia32_psrawi128", "psraw", Form::Shift, Ret::V8hi, Sem::Sar(2), 4),
    op("__builtin_ia32_psradi128", "psrad", Form::Shift, Ret::V4si, Sem::Sar(4), 4),
    op("__builtin_ia32_pslldqi128", "pslldq", Form::Shift, Ret::V2di, Sem::ShlBytes, 4),
    op("__builtin_ia32_psrldqi128", "psrldq", Form::Shift, Ret::V2di, Sem::ShrBytes, 4),
    // SSE2 shuffles and element access.
    op("__builtin_ia32_pshufd", "pshufd", Form::VI, Ret::V4si, Sem::ShufD, 0),
    op("__builtin_ia32_pshufhw", "pshufhw", Form::VI, Ret::V8hi, Sem::ShufHi, 0),
    op("__builtin_ia32_pshuflw", "pshuflw", Form::VI, Ret::V8hi, Sem::ShufLo, 0),
    op("__builtin_ia32_shufpd", "shufpd", Form::VvI, Ret::V2df, Sem::ShufPd, 0),
    op("__builtin_ia32_vec_ext_v8hi", "pextrw", Form::Extract, Ret::Int, Sem::Move, 2),
    op("__builtin_ia32_vec_set_v8hi", "pinsrw", Form::Insert, Ret::V8hi, Sem::Move, 2),
    op("__builtin_ia32_pmovmskb128", "pmovmskb", Form::MoveMask, Ret::Int, Sem::Move, 4),
    // SSE2 unaligned 128-bit transfers.
    op("__builtin_ia32_loaddqu", "movdqu", Form::Load, Ret::V16qi, Sem::Move, 0),
    op("__builtin_ia32_storedqu", "movdqu", Form::Store, Ret::Void, Sem::Move, 0),
    // SSSE3.
    op("__builtin_ia32_pshufb128", "pshufb", Form::Vv, Ret::V16qi, Sem::ShufB, 0),
    op("__builtin_ia32_pmaddubsw128", "pmaddubsw", Form::Vv, Ret::V8hi, Sem::MulAddBytes, 0),
    op("__builtin_ia32_pabsb128", "pabsb", Form::V, Ret::V16qi, Sem::Abs(1), 0),
    op("__builtin_ia32_pabsw128", "pabsw", Form::V, Ret::V8hi, Sem::Abs(2), 0),
    op("__builtin_ia32_pabsd128", "pabsd", Form::V, Ret::V4si, Sem::Abs(4), 0),
    op("__builtin_ia32_psignb128", "psignb", Form::Vv, Ret::V16qi, Sem::Sign(1), 0),
    op("__builtin_ia32_psignw128", "psignw", Form::Vv, Ret::V8hi, Sem::Sign(2), 0),
    op("__builtin_ia32_psignd128", "psignd", Form::Vv, Ret::V4si, Sem::Sign(4), 0),
    op("__builtin_ia32_phaddw128", "phaddw", Form::Vv, Ret::V8hi, Sem::HAdd(2, false), 0),
    op("__builtin_ia32_phaddd128", "phaddd", Form::Vv, Ret::V4si, Sem::HAdd(4, false), 0),
    op("__builtin_ia32_phaddsw128", "phaddsw", Form::Vv, Ret::V8hi, Sem::HAdd(2, true), 0),
    op("__builtin_ia32_phsubw128", "phsubw", Form::Vv, Ret::V8hi, Sem::HSub(2, false), 0),
    op("__builtin_ia32_phsubd128", "phsubd", Form::Vv, Ret::V4si, Sem::HSub(4, false), 0),
    op("__builtin_ia32_phsubsw128", "phsubsw", Form::Vv, Ret::V8hi, Sem::HSub(2, true), 0),
    op("__builtin_ia32_pmulhrsw128", "pmulhrsw", Form::Vv, Ret::V8hi, Sem::MulHrs, 0),
    // PALIGNR's builtin counts bits, as gcc's does.
    op("__builtin_ia32_palignr128", "palignr", Form::VvI, Ret::V2di, Sem::AlignR, 0),
    // SSE4.1, and SSE4.2's PCMPGTQ.
    op("__builtin_ia32_pcmpeqq", "pcmpeqq", Form::Vv, Ret::V2di, Sem::CmpEq(8), 0),
    op("__builtin_ia32_pcmpgtq", "pcmpgtq", Form::Vv, Ret::V2di, Sem::CmpGt(8), 0),
    op("__builtin_ia32_vec_ext_v16qi", "pextrb", Form::Extract, Ret::Int, Sem::Move, 1),
    op("__builtin_ia32_vec_set_v16qi", "pinsrb", Form::Insert, Ret::V16qi, Sem::Move, 1),
    op("__builtin_ia32_vec_ext_v4si", "pextrd", Form::Extract, Ret::Int, Sem::Move, 4),
    op("__builtin_ia32_vec_set_v4si", "pinsrd", Form::Insert, Ret::V4si, Sem::Move, 4),
    op("__builtin_ia32_vec_ext_v2di", "pextrq", Form::Extract, Ret::Int64, Sem::Move, 8),
    op("__builtin_ia32_vec_set_v2di", "pinsrq", Form::Insert, Ret::V2di, Sem::Move, 8),
    op("__builtin_ia32_pminsb128", "pminsb", Form::Vv, Ret::V16qi, Sem::Min(1, true), 0),
    op("__builtin_ia32_pmaxsb128", "pmaxsb", Form::Vv, Ret::V16qi, Sem::Max(1, true), 0),
    op("__builtin_ia32_pminuw128", "pminuw", Form::Vv, Ret::V8hi, Sem::Min(2, false), 0),
    op("__builtin_ia32_pmaxuw128", "pmaxuw", Form::Vv, Ret::V8hi, Sem::Max(2, false), 0),
    op("__builtin_ia32_pminsd128", "pminsd", Form::Vv, Ret::V4si, Sem::Min(4, true), 0),
    op("__builtin_ia32_pmaxsd128", "pmaxsd", Form::Vv, Ret::V4si, Sem::Max(4, true), 0),
    op("__builtin_ia32_pminud128", "pminud", Form::Vv, Ret::V4si, Sem::Min(4, false), 0),
    op("__builtin_ia32_pmaxud128", "pmaxud", Form::Vv, Ret::V4si, Sem::Max(4, false), 0),
    op("__builtin_ia32_pmulld128", "pmulld", Form::Vv, Ret::V4si, Sem::MulLo(4), 0),
    op("__builtin_ia32_pmuldq128", "pmuldq", Form::Vv, Ret::V2di, Sem::MulEven(true), 0),
    op("__builtin_ia32_packusdw128", "packusdw", Form::Vv, Ret::V8hi, Sem::PackUnsigned(4), 0),
    op("__builtin_ia32_pmovsxbw128", "pmovsxbw", Form::V, Ret::V8hi, Sem::Extend(1, 2, true), 0),
    op("__builtin_ia32_pmovsxbd128", "pmovsxbd", Form::V, Ret::V4si, Sem::Extend(1, 4, true), 0),
    op("__builtin_ia32_pmovsxbq128", "pmovsxbq", Form::V, Ret::V2di, Sem::Extend(1, 8, true), 0),
    op("__builtin_ia32_pmovsxwd128", "pmovsxwd", Form::V, Ret::V4si, Sem::Extend(2, 4, true), 0),
    op("__builtin_ia32_pmovsxwq128", "pmovsxwq", Form::V, Ret::V2di, Sem::Extend(2, 8, true), 0),
    op("__builtin_ia32_pmovsxdq128", "pmovsxdq", Form::V, Ret::V2di, Sem::Extend(4, 8, true), 0),
    op("__builtin_ia32_pmovzxbw128", "pmovzxbw", Form::V, Ret::V8hi, Sem::Extend(1, 2, false), 0),
    op("__builtin_ia32_pmovzxbd128", "pmovzxbd", Form::V, Ret::V4si, Sem::Extend(1, 4, false), 0),
    op("__builtin_ia32_pmovzxbq128", "pmovzxbq", Form::V, Ret::V2di, Sem::Extend(1, 8, false), 0),
    op("__builtin_ia32_pmovzxwd128", "pmovzxwd", Form::V, Ret::V4si, Sem::Extend(2, 4, false), 0),
    op("__builtin_ia32_pmovzxwq128", "pmovzxwq", Form::V, Ret::V2di, Sem::Extend(2, 8, false), 0),
    op("__builtin_ia32_pmovzxdq128", "pmovzxdq", Form::V, Ret::V2di, Sem::Extend(4, 8, false), 0),
    op("__builtin_ia32_pblendw128", "pblendw", Form::VvI, Ret::V8hi, Sem::Blend(2), 0),
    op("__builtin_ia32_blendps", "blendps", Form::VvI, Ret::V4sf, Sem::Blend(4), 0),
    op("__builtin_ia32_blendpd", "blendpd", Form::VvI, Ret::V2df, Sem::Blend(8), 0),
    // AES-NI.
    op("__builtin_ia32_aesenc128", "aesenc", Form::Vv, Ret::V2di, Sem::AesEnc, 0),
    op("__builtin_ia32_aesenclast128", "aesenclast", Form::Vv, Ret::V2di, Sem::AesEncLast, 0),
    op("__builtin_ia32_aesdec128", "aesdec", Form::Vv, Ret::V2di, Sem::AesDec, 0),
    op("__builtin_ia32_aesdeclast128", "aesdeclast", Form::Vv, Ret::V2di, Sem::AesDecLast, 0),
    op("__builtin_ia32_aesimc128", "aesimc", Form::V, Ret::V2di, Sem::AesImc, 0),
    op("__builtin_ia32_aeskeygenassist128", "aeskeygenassist", Form::VI, Ret::V2di, Sem::AesKeygen, 0),
    // PCLMUL.
    op("__builtin_ia32_pclmulqdq128", "pclmulqdq", Form::VvI, Ret::V2di, Sem::ClMul, 0),
    // SSE and SSE2 floating-point arithmetic, compares and conversions.
    op("__builtin_ia32_addps", "addps", Form::Vv, Ret::V4sf, Sem::Float(FOp::Add, 4, false), 0),
    op("__builtin_ia32_subps", "subps", Form::Vv, Ret::V4sf, Sem::Float(FOp::Sub, 4, false), 0),
    op("__builtin_ia32_mulps", "mulps", Form::Vv, Ret::V4sf, Sem::Float(FOp::Mul, 4, false), 0),
    op("__builtin_ia32_divps", "divps", Form::Vv, Ret::V4sf, Sem::Float(FOp::Div, 4, false), 0),
    op("__builtin_ia32_minps", "minps", Form::Vv, Ret::V4sf, Sem::Float(FOp::Min, 4, false), 0),
    op("__builtin_ia32_maxps", "maxps", Form::Vv, Ret::V4sf, Sem::Float(FOp::Max, 4, false), 0),
    op("__builtin_ia32_sqrtps", "sqrtps", Form::V, Ret::V4sf, Sem::Float(FOp::Sqrt, 4, false), 0),
    op("__builtin_ia32_addss", "addss", Form::Vv, Ret::V4sf, Sem::Float(FOp::Add, 4, true), 0),
    op("__builtin_ia32_subss", "subss", Form::Vv, Ret::V4sf, Sem::Float(FOp::Sub, 4, true), 0),
    op("__builtin_ia32_mulss", "mulss", Form::Vv, Ret::V4sf, Sem::Float(FOp::Mul, 4, true), 0),
    op("__builtin_ia32_divss", "divss", Form::Vv, Ret::V4sf, Sem::Float(FOp::Div, 4, true), 0),
    op("__builtin_ia32_minss", "minss", Form::Vv, Ret::V4sf, Sem::Float(FOp::Min, 4, true), 0),
    op("__builtin_ia32_maxss", "maxss", Form::Vv, Ret::V4sf, Sem::Float(FOp::Max, 4, true), 0),
    op("__builtin_ia32_sqrtss", "sqrtss", Form::V, Ret::V4sf, Sem::Float(FOp::Sqrt, 4, true), 0),
    op("__builtin_ia32_addpd", "addpd", Form::Vv, Ret::V2df, Sem::Float(FOp::Add, 8, false), 0),
    op("__builtin_ia32_subpd", "subpd", Form::Vv, Ret::V2df, Sem::Float(FOp::Sub, 8, false), 0),
    op("__builtin_ia32_mulpd", "mulpd", Form::Vv, Ret::V2df, Sem::Float(FOp::Mul, 8, false), 0),
    op("__builtin_ia32_divpd", "divpd", Form::Vv, Ret::V2df, Sem::Float(FOp::Div, 8, false), 0),
    op("__builtin_ia32_minpd", "minpd", Form::Vv, Ret::V2df, Sem::Float(FOp::Min, 8, false), 0),
    op("__builtin_ia32_maxpd", "maxpd", Form::Vv, Ret::V2df, Sem::Float(FOp::Max, 8, false), 0),
    op("__builtin_ia32_sqrtpd", "sqrtpd", Form::V, Ret::V2df, Sem::Float(FOp::Sqrt, 8, false), 0),
    op("__builtin_ia32_addsd", "addsd", Form::Vv, Ret::V2df, Sem::Float(FOp::Add, 8, true), 0),
    op("__builtin_ia32_subsd", "subsd", Form::Vv, Ret::V2df, Sem::Float(FOp::Sub, 8, true), 0),
    op("__builtin_ia32_mulsd", "mulsd", Form::Vv, Ret::V2df, Sem::Float(FOp::Mul, 8, true), 0),
    op("__builtin_ia32_divsd", "divsd", Form::Vv, Ret::V2df, Sem::Float(FOp::Div, 8, true), 0),
    op("__builtin_ia32_minsd", "minsd", Form::Vv, Ret::V2df, Sem::Float(FOp::Min, 8, true), 0),
    op("__builtin_ia32_maxsd", "maxsd", Form::Vv, Ret::V2df, Sem::Float(FOp::Max, 8, true), 0),
    op("__builtin_ia32_sqrtsd", "sqrtsd", Form::V, Ret::V2df, Sem::Float(FOp::Sqrt, 8, true), 0),
    op("__builtin_ia32_cmpps", "cmpps", Form::VvI, Ret::V4sf, Sem::FloatCmp(4, false), 0),
    op("__builtin_ia32_cmpss", "cmpss", Form::VvI, Ret::V4sf, Sem::FloatCmp(4, true), 0),
    op("__builtin_ia32_cmppd", "cmppd", Form::VvI, Ret::V2df, Sem::FloatCmp(8, false), 0),
    op("__builtin_ia32_cmpsd", "cmpsd", Form::VvI, Ret::V2df, Sem::FloatCmp(8, true), 0),
    op("__builtin_ia32_cvtdq2ps", "cvtdq2ps", Form::V, Ret::V4sf, Sem::Convert(Cvt::IntToSingle), 0),
    op("__builtin_ia32_cvtps2dq", "cvtps2dq", Form::V, Ret::V4si, Sem::Convert(Cvt::SingleToInt { truncate: false }), 0),
    op("__builtin_ia32_cvttps2dq", "cvttps2dq", Form::V, Ret::V4si, Sem::Convert(Cvt::SingleToInt { truncate: true }), 0),
    // AVX-512F with VL: the unsigned doubleword conversions.
    op("__builtin_ia32_cvtudq2ps128", "vcvtudq2ps", Form::V, Ret::V4sf, Sem::Convert(Cvt::UIntToSingle), 0),
    op("__builtin_ia32_cvtps2udq128", "vcvtps2udq", Form::V, Ret::V4si, Sem::Convert(Cvt::SingleToUInt { truncate: false }), 0),
    op("__builtin_ia32_cvttps2udq128", "vcvttps2udq", Form::V, Ret::V4si, Sem::Convert(Cvt::SingleToUInt { truncate: true }), 0),
    op("__builtin_ia32_cvtdq2pd", "cvtdq2pd", Form::V, Ret::V2df, Sem::Convert(Cvt::IntToDouble), 0),
    op("__builtin_ia32_cvtpd2dq", "cvtpd2dq", Form::V, Ret::V4si, Sem::Convert(Cvt::DoubleToInt { truncate: false }), 0),
    op("__builtin_ia32_cvttpd2dq", "cvttpd2dq", Form::V, Ret::V4si, Sem::Convert(Cvt::DoubleToInt { truncate: true }), 0),
    op("__builtin_ia32_cvtps2pd", "cvtps2pd", Form::V, Ret::V2df, Sem::Convert(Cvt::SingleToDouble), 0),
    op("__builtin_ia32_cvtpd2ps", "cvtpd2ps", Form::V, Ret::V4sf, Sem::Convert(Cvt::DoubleToSingle), 0),
    op("__builtin_ia32_pmuludq128", "pmuludq", Form::Vv, Ret::V2di, Sem::MulEven(false), 0),
    op("__builtin_ia32_cvtss2si", "cvtss2si", Form::ToInt, Ret::Int, Sem::ToInt(4, false), 4),
    op("__builtin_ia32_cvttss2si", "cvttss2si", Form::ToInt, Ret::Int, Sem::ToInt(4, true), 4),
    op("__builtin_ia32_cvtsd2si", "cvtsd2si", Form::ToInt, Ret::Int, Sem::ToInt(8, false), 4),
    op("__builtin_ia32_cvttsd2si", "cvttsd2si", Form::ToInt, Ret::Int, Sem::ToInt(8, true), 4),
    op("__builtin_ia32_cvtss2si64", "cvtss2si", Form::ToInt, Ret::Int64, Sem::ToInt(4, false), 8),
    op("__builtin_ia32_cvttss2si64", "cvttss2si", Form::ToInt, Ret::Int64, Sem::ToInt(4, true), 8),
    op("__builtin_ia32_cvtsd2si64", "cvtsd2si", Form::ToInt, Ret::Int64, Sem::ToInt(8, false), 8),
    op("__builtin_ia32_cvttsd2si64", "cvttsd2si", Form::ToInt, Ret::Int64, Sem::ToInt(8, true), 8),
    // RDRAND and RDSEED.
    op("__builtin_ia32_rdrand16_step", "rdrand", Form::RdRand, Ret::Int, Sem::Rand, 2),
    op("__builtin_ia32_rdrand32_step", "rdrand", Form::RdRand, Ret::Int, Sem::Rand, 4),
    op("__builtin_ia32_rdrand64_step", "rdrand", Form::RdRand, Ret::Int, Sem::Rand, 8),
    op("__builtin_ia32_rdseed16_step", "rdseed", Form::RdRand, Ret::Int, Sem::Rand, 2),
    op("__builtin_ia32_rdseed32_step", "rdseed", Form::RdRand, Ret::Int, Sem::Rand, 4),
    op("__builtin_ia32_rdseed64_step", "rdseed", Form::RdRand, Ret::Int, Sem::Rand, 8),
    // The MMX forms over 8-byte vectors, as gcc names their builtins.
    op64("__builtin_ia32_paddsb", "paddsb", Ret::V8qi, Sem::AddSat(1, true)),
    op64("__builtin_ia32_paddsw", "paddsw", Ret::V4hi, Sem::AddSat(2, true)),
    op64("__builtin_ia32_paddusb", "paddusb", Ret::V8qi, Sem::AddSat(1, false)),
    op64("__builtin_ia32_paddusw", "paddusw", Ret::V4hi, Sem::AddSat(2, false)),
    op64("__builtin_ia32_psubsb", "psubsb", Ret::V8qi, Sem::SubSat(1, true)),
    op64("__builtin_ia32_psubsw", "psubsw", Ret::V4hi, Sem::SubSat(2, true)),
    op64("__builtin_ia32_psubusb", "psubusb", Ret::V8qi, Sem::SubSat(1, false)),
    op64("__builtin_ia32_psubusw", "psubusw", Ret::V4hi, Sem::SubSat(2, false)),
    op64("__builtin_ia32_pmullw", "pmullw", Ret::V4hi, Sem::MulLo(2)),
    op64("__builtin_ia32_pmulhw", "pmulhw", Ret::V4hi, Sem::MulHi(2, true)),
    op64("__builtin_ia32_pmulhuw", "pmulhuw", Ret::V4hi, Sem::MulHi(2, false)),
    op64("__builtin_ia32_pmaddwd", "pmaddwd", Ret::V2si, Sem::MulAddWords),
    op64("__builtin_ia32_pmuludq", "pmuludq", Ret::V1di, Sem::MulEven(false)),
    op64("__builtin_ia32_pcmpeqb", "pcmpeqb", Ret::V8qi, Sem::CmpEq(1)),
    op64("__builtin_ia32_pcmpeqw", "pcmpeqw", Ret::V4hi, Sem::CmpEq(2)),
    op64("__builtin_ia32_pcmpeqd", "pcmpeqd", Ret::V2si, Sem::CmpEq(4)),
    op64("__builtin_ia32_pcmpgtb", "pcmpgtb", Ret::V8qi, Sem::CmpGt(1)),
    op64("__builtin_ia32_pcmpgtw", "pcmpgtw", Ret::V4hi, Sem::CmpGt(2)),
    op64("__builtin_ia32_pcmpgtd", "pcmpgtd", Ret::V2si, Sem::CmpGt(4)),
    op64("__builtin_ia32_psadbw", "psadbw", Ret::V1di, Sem::SadBytes),
    op64("__builtin_ia32_pavgb", "pavgb", Ret::V8qi, Sem::Avg(1)),
    op64("__builtin_ia32_pavgw", "pavgw", Ret::V4hi, Sem::Avg(2)),
    op64("__builtin_ia32_pminsw", "pminsw", Ret::V4hi, Sem::Min(2, true)),
    op64("__builtin_ia32_pmaxsw", "pmaxsw", Ret::V4hi, Sem::Max(2, true)),
    op64("__builtin_ia32_pminub", "pminub", Ret::V8qi, Sem::Min(1, false)),
    op64("__builtin_ia32_pmaxub", "pmaxub", Ret::V8qi, Sem::Max(1, false)),
];

/// The table index of `name`, or `None` when it is not a SIMD builtin.
pub(crate) fn lookup(name: &str) -> Option<u32> {
    OPS.iter().position(|o| o.name == name).map(|i| i as u32)
}

pub(crate) fn get(index: u32) -> &'static SimdOp {
    &OPS[index as usize]
}

impl SimdOp {
    /// The stores the instruction performs, as `(operand index, bytes)`:
    /// the result through the destination address -- 16 bytes for a
    /// vector, 4 for an `int`, 8 for a `long long` -- and for `RdRand` the
    /// random value through
    /// the pointer operand as well. The store form has no destination of
    /// its own; its 16 bytes go through the pointer operand, its first.
    pub(crate) fn stores(&self) -> impl Iterator<Item = (usize, u8)> {
        let width = if self.form.returns_vector() || self.form == Form::Store {
            self.bytes
        } else if self.form == Form::ToInt || (self.form == Form::Extract && self.int_width == 8) {
            self.int_width
        } else {
            4
        };
        let pointer = (self.form == Form::RdRand).then_some((1, self.int_width));
        core::iter::once((0, width)).chain(pointer)
    }
}

impl Form {
    /// Number of source operands the builtin call takes.
    pub(crate) fn arity(self) -> usize {
        match self {
            Form::V | Form::Load | Form::MoveMask | Form::RdRand | Form::ToInt => 1,
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

/// Lane `i`, sign-extended from its width.
fn slane(v: &[u8; 16], width: u8, i: usize) -> i64 {
    let bits = 8 * width as u32;
    let x = lane(v, width, i);
    if bits >= 64 {
        x as i64
    } else {
        (x << (64 - bits)) as i64 >> (64 - bits)
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
/// the instruction takes: bits for the lane shifts, bytes for the
/// whole-register pair.
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
        Sem::MulLo(w) => {
            for i in 0..16 / w as usize {
                let x = lane(a, w, i).wrapping_mul(lane(b, w, i)) & mask(w);
                set_lane(&mut o, w, i, x);
            }
        }
        Sem::MulHi(w, signed) => {
            for i in 0..16 / w as usize {
                let x = if signed {
                    (slane(a, w, i) * slane(b, w, i)) as u64
                } else {
                    lane(a, w, i) * lane(b, w, i)
                };
                set_lane(&mut o, w, i, (x >> (8 * w as u32)) & mask(w));
            }
        }
        Sem::Avg(w) => {
            for i in 0..16 / w as usize {
                set_lane(&mut o, w, i, (lane(a, w, i) + lane(b, w, i) + 1) >> 1);
            }
        }
        Sem::Min(w, signed) | Sem::Max(w, signed) => {
            for i in 0..16 / w as usize {
                let less = if signed {
                    slane(a, w, i) < slane(b, w, i)
                } else {
                    lane(a, w, i) < lane(b, w, i)
                };
                let first = less == matches!(sem, Sem::Min(..));
                set_lane(&mut o, w, i, lane(if first { a } else { b }, w, i));
            }
        }
        Sem::MulAddWords => {
            for i in 0..4 {
                let lo = slane(a, 2, 2 * i) * slane(b, 2, 2 * i);
                let hi = slane(a, 2, 2 * i + 1) * slane(b, 2, 2 * i + 1);
                set_lane(&mut o, 4, i, (lo + hi) as u64 & mask(4));
            }
        }
        Sem::MulAddBytes => {
            for i in 0..8 {
                let p = |k: usize| a[k] as i64 * b[k] as i8 as i64;
                let s = (p(2 * i) + p(2 * i + 1)).clamp(-0x8000, 0x7fff);
                set_lane(&mut o, 2, i, s as u64 & mask(2));
            }
        }
        Sem::AddSat(w, signed) | Sem::SubSat(w, signed) => {
            let bits = 8 * w as u32;
            let (lo, hi) = if signed {
                (-(1i64 << (bits - 1)), (1i64 << (bits - 1)) - 1)
            } else {
                (0, (1i64 << bits) - 1)
            };
            for i in 0..16 / w as usize {
                let (x, y) = if signed {
                    (slane(a, w, i), slane(b, w, i))
                } else {
                    (lane(a, w, i) as i64, lane(b, w, i) as i64)
                };
                let r = if matches!(sem, Sem::AddSat(..)) {
                    x + y
                } else {
                    x - y
                };
                set_lane(&mut o, w, i, r.clamp(lo, hi) as u64 & mask(w));
            }
        }
        Sem::SadBytes => {
            for q in 0..2 {
                let s: u64 = (0..8)
                    .map(|k| a[8 * q + k].abs_diff(b[8 * q + k]) as u64)
                    .sum();
                set_lane(&mut o, 8, q, s);
            }
        }
        Sem::And => {
            for i in 0..16 {
                o[i] = a[i] & b[i];
            }
        }
        Sem::AndNot => {
            for i in 0..16 {
                o[i] = !a[i] & b[i];
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
        Sem::CmpGt(w) => {
            for i in 0..16 / w as usize {
                let gt = slane(a, w, i) > slane(b, w, i);
                set_lane(&mut o, w, i, if gt { mask(w) } else { 0 });
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
        Sem::Sar(w) => {
            let n = count.min(8 * w as u64 - 1) as u32;
            for i in 0..16 / w as usize {
                let x = (slane(a, w, i) >> n) as u64 & mask(w);
                set_lane(&mut o, w, i, x);
            }
        }
        Sem::ShlBytes => {
            let n = (count as usize).min(16);
            o[n..].copy_from_slice(&a[..16 - n]);
        }
        Sem::ShrBytes => {
            let n = (count as usize).min(16);
            o[..16 - n].copy_from_slice(&a[n..]);
        }
        Sem::PackSigned(w) | Sem::PackUnsigned(w) => {
            let half = w / 2;
            let bits = 8 * half as u32;
            let (lo, hi) = if matches!(sem, Sem::PackSigned(_)) {
                (-(1i64 << (bits - 1)), (1i64 << (bits - 1)) - 1)
            } else {
                (0, (1i64 << bits) - 1)
            };
            let lanes = 16 / w as usize;
            for i in 0..lanes {
                let x = slane(a, w, i).clamp(lo, hi);
                set_lane(&mut o, half, i, x as u64 & mask(half));
                let y = slane(b, w, i).clamp(lo, hi);
                set_lane(&mut o, half, lanes + i, y as u64 & mask(half));
            }
        }
        Sem::UnpackLo(w) | Sem::UnpackHi(w) => {
            let lanes = 16 / w as usize;
            let base = if matches!(sem, Sem::UnpackHi(_)) {
                lanes / 2
            } else {
                0
            };
            for i in 0..lanes / 2 {
                set_lane(&mut o, w, 2 * i, lane(a, w, base + i));
                set_lane(&mut o, w, 2 * i + 1, lane(b, w, base + i));
            }
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
        Sem::Abs(w) => {
            for i in 0..16 / w as usize {
                set_lane(&mut o, w, i, slane(a, w, i).unsigned_abs() & mask(w));
            }
        }
        Sem::Sign(w) => {
            for i in 0..16 / w as usize {
                let x = match slane(b, w, i).signum() {
                    -1 => slane(a, w, i).wrapping_neg(),
                    0 => 0,
                    _ => slane(a, w, i),
                };
                set_lane(&mut o, w, i, x as u64 & mask(w));
            }
        }
        Sem::HAdd(w, sat) | Sem::HSub(w, sat) => {
            let bits = 8 * w as u32;
            let pairs = 8 / w as usize;
            for i in 0..2 * pairs {
                let src = if i < pairs { a } else { b };
                let k = 2 * (i % pairs);
                let (x, y) = (slane(src, w, k), slane(src, w, k + 1));
                let mut r = if matches!(sem, Sem::HAdd(..)) {
                    x + y
                } else {
                    x - y
                };
                if sat {
                    r = r.clamp(-(1i64 << (bits - 1)), (1i64 << (bits - 1)) - 1);
                }
                set_lane(&mut o, w, i, r as u64 & mask(w));
            }
        }
        Sem::MulHrs => {
            for i in 0..8 {
                let p = slane(a, 2, i) * slane(b, 2, i);
                set_lane(&mut o, 2, i, (((p >> 14) + 1) >> 1) as u64 & mask(2));
            }
        }
        Sem::AlignR => {
            let n = imm as usize;
            for (i, byte) in o.iter_mut().enumerate() {
                *byte = match i + n {
                    k if k < 16 => b[k],
                    k if k < 32 => a[k - 16],
                    _ => 0,
                };
            }
        }
        Sem::ShufPd => {
            set_lane(&mut o, 8, 0, lane(a, 8, (imm & 1) as usize));
            set_lane(&mut o, 8, 1, lane(b, 8, ((imm >> 1) & 1) as usize));
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
        Sem::MulEven(signed) => {
            for i in 0..2 {
                let x = if signed {
                    (slane(a, 4, 2 * i) * slane(b, 4, 2 * i)) as u64
                } else {
                    lane(a, 4, 2 * i) * lane(b, 4, 2 * i)
                };
                set_lane(&mut o, 8, i, x);
            }
        }
        Sem::Extend(from, to, signed) => {
            for i in 0..16 / to as usize {
                let x = if signed {
                    slane(a, from, i) as u64
                } else {
                    lane(a, from, i)
                };
                set_lane(&mut o, to, i, x & mask(to));
            }
        }
        Sem::Blend(w) => {
            for i in 0..16 / w as usize {
                let src = if imm >> i & 1 != 0 { b } else { a };
                set_lane(&mut o, w, i, lane(src, w, i));
            }
        }
        Sem::Move | Sem::Rand => o = *a,
        // `eval_float` computes these in a floating-point environment.
        Sem::Float(..) | Sem::FloatCmp(..) | Sem::Convert(_) | Sem::ToInt(..) => {}
    }
    o
}

/// Lane `i` of width 4 or 8 as a `double` bit pattern; a NaN keeps its
/// payload and whether it signals.
fn flane(v: &[u8; 16], width: u8, i: usize) -> u64 {
    let x = lane(v, width, i);
    match width {
        4 if x & 0x7F80_0000 == 0x7F80_0000 && x & 0x7F_FFFF != 0 => {
            (x & 0x8000_0000) << 32 | 0x7FF0_0000_0000_0000 | (x & 0x7F_FFFF) << 29
        }
        4 => f64::from(f32::from_bits(x as u32)).to_bits(),
        _ => x,
    }
}

fn set_flane(v: &mut [u8; 16], width: u8, i: usize, x: u64) {
    match width {
        4 => set_lane(v, 4, i, u64::from((f64::from_bits(x) as f32).to_bits())),
        _ => set_lane(v, 8, i, x),
    }
}

/// `Form::ToInt`: the low lane converted, in `env`; `None` for another
/// semantics.
pub(crate) fn eval_to_int(
    env: &mut impl FloatEnv,
    sem: Sem,
    a: &[u8; 16],
    bits: u32,
) -> Option<i64> {
    match sem {
        Sem::ToInt(w, truncate) => Some(env.to_int(flane(a, w, 0), truncate, bits, true)),
        _ => None,
    }
}

/// The floating-point rows, in `env`; `None` for another semantics.
pub(crate) fn eval_float(
    env: &mut impl FloatEnv,
    sem: Sem,
    a: &[u8; 16],
    b: &[u8; 16],
    imm: u8,
) -> Option<[u8; 16]> {
    use core::cmp::Ordering::{Equal, Greater, Less};
    let mut o = *a;
    match sem {
        Sem::Float(op, w, scalar) => {
            for i in 0..if scalar { 1 } else { 16 / w as usize } {
                let (x, y) = (flane(a, w, i), flane(b, w, i));
                match op {
                    FOp::Min | FOp::Max => {
                        let c = env.compare(x, y, true);
                        let first = c == Some(if op == FOp::Min { Less } else { Greater });
                        set_lane(&mut o, w, i, lane(if first { a } else { b }, w, i));
                    }
                    FOp::Sqrt => set_flane(&mut o, w, i, env.arith(op, x, 0, w == 4)),
                    _ => set_flane(&mut o, w, i, env.arith(op, x, y, w == 4)),
                }
            }
        }
        Sem::FloatCmp(w, scalar) => {
            for i in 0..if scalar { 1 } else { 16 / w as usize } {
                let p = imm & 7;
                let c = env.compare(flane(a, w, i), flane(b, w, i), matches!(p, 1 | 2 | 5 | 6));
                let holds = match p {
                    0 => c == Some(Equal),
                    1 => c == Some(Less),
                    2 => matches!(c, Some(Less | Equal)),
                    3 => c.is_none(),
                    4 => c != Some(Equal),
                    5 => c != Some(Less),
                    6 => !matches!(c, Some(Less | Equal)),
                    _ => c.is_some(),
                };
                set_lane(&mut o, w, i, if holds { mask(w) } else { 0 });
            }
        }
        Sem::Convert(cvt) => {
            o = [0; 16];
            match cvt {
                Cvt::IntToSingle | Cvt::UIntToSingle => (0..4).for_each(|i| {
                    let n = match cvt {
                        Cvt::IntToSingle => slane(a, 4, i) as i32 as i64,
                        _ => slane(a, 4, i) as u32 as i64,
                    };
                    set_flane(&mut o, 4, i, env.integer_to_float(n, true));
                }),
                Cvt::SingleToInt { truncate } | Cvt::SingleToUInt { truncate } => {
                    let signed = matches!(cvt, Cvt::SingleToInt { .. });
                    (0..4).for_each(|i| {
                        let x = env.to_int(flane(a, 4, i), truncate, 32, signed);
                        set_lane(&mut o, 4, i, x as u64 & 0xFFFF_FFFF);
                    })
                }
                Cvt::IntToDouble => (0..2).for_each(|i| {
                    let x = env.integer_to_float(slane(a, 4, i) as i32 as i64, false);
                    set_flane(&mut o, 8, i, x);
                }),
                Cvt::DoubleToInt { truncate } => (0..2).for_each(|i| {
                    let x = env.to_int(flane(a, 8, i), truncate, 32, true);
                    set_lane(&mut o, 4, i, x as u64 & 0xFFFF_FFFF);
                }),
                Cvt::SingleToDouble => (0..2).for_each(|i| {
                    let x = env.widen(flane(a, 4, i));
                    set_flane(&mut o, 8, i, x);
                }),
                Cvt::DoubleToSingle => (0..2).for_each(|i| {
                    let x = env.to_single(flane(a, 8, i));
                    set_flane(&mut o, 4, i, x);
                }),
            }
        }
        _ => return None,
    }
    Some(o)
}

/// `Form::Extract`: the selected lane, zero-extended.
pub(crate) fn eval_extract(a: &[u8; 16], width: u8, imm: u8) -> u64 {
    let lanes = 16 / width as usize;
    lane(a, width, imm as usize % lanes)
}

/// `Form::MoveMask`: the sign bit of each byte lane, lane `i` at bit `i`.
pub(crate) fn eval_movemask(a: &[u8; 16]) -> u64 {
    let mut m = 0u64;
    for (i, &byte) in a.iter().enumerate() {
        m |= ((byte >> 7) as u64) << i;
    }
    m
}

/// `Form::Insert`: `a` with the selected lane replaced.
pub(crate) fn eval_insert(a: &[u8; 16], width: u8, imm: u8, value: u64) -> [u8; 16] {
    let lanes = 16 / width as usize;
    let mut o = *a;
    set_lane(&mut o, width, imm as usize % lanes, value & mask(width));
    o
}

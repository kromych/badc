//! The SIMD operation vocabulary the target intrinsic tables share: a
//! row's operand shape ([`Form`]), result type ([`Ret`]), and value
//! semantics ([`Sem`]), which the interpreter and constant folding
//! evaluate here, so a table names only the builtin and the instruction.
//! A row of any target computes the [`Sem`] it names, whatever the
//! instruction, so a consumer that wants an operation can ask a target
//! for a row by its semantics.

use super::token::Ty;

/// The first op id of the AArch64 rows; the x86 rows number from 0, so one
/// id names a row of either table.
pub(crate) const A64_BASE: u32 = 1 << 16;

/// The row an op id names.
pub(crate) fn get(op: u32) -> &'static SimdOp {
    match op.checked_sub(A64_BASE) {
        Some(i) => super::aarch64_simd::get(i as usize),
        None => &super::x86_simd::OPS[op as usize],
    }
}

/// The op id of the SIMD builtin `name` of any target, or `None`.
pub(crate) fn lookup(name: &str) -> Option<u32> {
    super::x86_simd::lookup(name)
        .or_else(|| super::aarch64_simd::lookup(name).map(|i| i + A64_BASE))
}

/// The architecture whose instruction an op id's row names.
pub(crate) fn arch(op: u32) -> &'static str {
    if op >= A64_BASE { "AArch64" } else { "x86" }
}

/// The op id of a row of `target` that computes `sem` in `form` over
/// `bytes`-byte vectors, among the rows the unit's x86 extensions `x86`
/// enable: x86-64 code assumes AVX2, and a 64-byte row needs AVX-512F, or
/// AVX-512BW for byte and word lanes. `None` when the target has no such
/// row; a consumer then computes the operation another way.
pub(crate) fn find(
    target: crate::c5::Target,
    x86: crate::c5::X86Features,
    sem: Sem,
    form: Form,
    bytes: u8,
) -> Option<u32> {
    let fits = |o: &SimdOp| o.sem == sem && o.form == form && o.bytes == bytes;
    if target.is_aarch64() {
        let i = super::aarch64_simd::rows().position(fits)?;
        return Some(i as u32 + A64_BASE);
    }
    if !target.is_x86_64() {
        return None;
    }
    let zmm = |o: &SimdOp| x86.avx512f() && (o.ret.lane_bytes() >= 4 || x86.avx512bw());
    let i = super::x86_simd::OPS
        .iter()
        .position(|o| fits(o) && (o.bytes < 64 || zmm(o)))?;
    Some(i as u32)
}

/// Whether `target` runs the instruction an op id's row names.
pub(crate) fn on_target(op: u32, target: crate::c5::Target) -> bool {
    if op >= A64_BASE {
        target.is_aarch64()
    } else {
        target.is_x86_64()
    }
}

/// Operand and result shape. `Shift` takes an immediate count when the
/// operand is a constant expression and the low quad of a register
/// otherwise; the byte-granular shift has the immediate form only.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum Form {
    /// `v128 = op(v128, v128)`.
    Vv,
    /// `v128 = op(v128, v128, imm8)`.
    VvI,
    /// `v = op(acc, a, b)`: the accumulator is the first source and the
    /// destination (`vpdpbusd`).
    Vvv,
    /// [`Form::Vvv`] with an imm8 (`vpternlogd`).
    VvvI,
    /// `mask = op(a, b, imm8)`: a bit per lane of the row's `int_width`
    /// where the imm8 predicate holds (`vpcmpub` into an opmask).
    CmpMask,
    /// `v = op(src, mask, a)`: lane `i` of `a` where mask bit `i` is set,
    /// of `src` elsewhere (`vpblendmb`).
    MaskBlend,
    /// `v = op(mask, p)`: the lanes the mask selects read from `p`, the
    /// others zero and not read (`vmovdqu8 {k}{z}`).
    MaskLoad,
    /// `op(p, mask, v)`: the lanes the mask selects written to `p`, the
    /// others not touched (`vmovdqu8 {k}`).
    MaskStore,
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
    /// `part = op(v, imm8)`: part imm8 of `v`, `int_width` bytes each
    /// (`vextracti128`); part 0 is the low bytes of the register.
    Narrow,
    /// `v = op(v, part, imm8)`: `v` with part imm8 replaced (`vinserti128`).
    Widen,
    /// `v = op(part)`: the part zero-extended (`vmovdqa` of the xmm form).
    Zext,
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
    /// The 8-byte vectors of the MMX forms, and AArch64's 64-bit
    /// floating vectors.
    V2sf,
    V1df,
    V8qi,
    V4hi,
    V2si,
    V1di,
    /// The 32-byte vectors of the AVX2 forms.
    V32qi,
    V16hi,
    V8si,
    V4di,
    V8sf,
    V4df,
    /// The 64-byte vectors of the AVX-512 forms.
    V64qi,
    V32hi,
    V16si,
    V8di,
    Int,
    Int64,
    Void,
}

impl Ret {
    /// Width in bytes of a vector result; 0 for a scalar or void one.
    pub(crate) fn bytes(self) -> u8 {
        match self {
            Ret::V8qi | Ret::V4hi | Ret::V2si | Ret::V1di | Ret::V2sf | Ret::V1df => 8,
            Ret::V32qi | Ret::V16hi | Ret::V8si | Ret::V4di | Ret::V8sf | Ret::V4df => 32,
            Ret::V64qi | Ret::V32hi | Ret::V16si | Ret::V8di => 64,
            Ret::Int | Ret::Int64 | Ret::Void => 0,
            _ => 16,
        }
    }

    /// Width in bytes of a vector result's lanes; 0 for a scalar or void one.
    pub(crate) fn lane_bytes(self) -> u8 {
        match self.lane_ty() {
            Some(Ty::Char) => 1,
            Some(Ty::Short) => 2,
            Some(Ty::Int | Ty::Float) => 4,
            Some(_) => 8,
            None => 0,
        }
    }

    /// Lane type of a vector result; `None` for a scalar or void one.
    pub(crate) fn lane_ty(self) -> Option<Ty> {
        match self {
            Ret::V16qi => Some(Ty::Char),
            Ret::V8hi => Some(Ty::Short),
            Ret::V4si => Some(Ty::Int),
            Ret::V2di => Some(Ty::LongLong),
            Ret::V2df => Some(Ty::Double),
            Ret::V4sf => Some(Ty::Float),
            Ret::V2sf => Some(Ty::Float),
            Ret::V1df => Some(Ty::Double),
            Ret::V8qi => Some(Ty::Char),
            Ret::V4hi => Some(Ty::Short),
            Ret::V2si => Some(Ty::Int),
            Ret::V1di => Some(Ty::LongLong),
            Ret::V32qi => Some(Ty::Char),
            Ret::V16hi => Some(Ty::Short),
            Ret::V8si => Some(Ty::Int),
            Ret::V4di => Some(Ty::LongLong),
            Ret::V8sf => Some(Ty::Float),
            Ret::V4df => Some(Ty::Double),
            Ret::V64qi => Some(Ty::Char),
            Ret::V32hi => Some(Ty::Short),
            Ret::V16si => Some(Ty::Int),
            Ret::V8di => Some(Ty::LongLong),
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
    /// Low half of the lane-wise carry-less (polynomial) product.
    PolyMul(u8),
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
    /// AArch64's `aese` (`false`) and `aesd`: the state xor the round key,
    /// then ShiftRows and SubBytes or their inverses.
    AesRound(bool),
    /// AArch64's `aesmc`: MixColumns.
    AesMix,
    /// FEAT_SHA3: the three-way xor (`eor3`), the first operand xor the
    /// second with the third's bits cleared (`bcax`), the first xor the
    /// second rotated left by one in each 64-bit lane (`rax1`), and the xor
    /// of the two rotated right by the immediate in each 64-bit lane (`xar`).
    Eor3,
    Bcax,
    Rax1,
    Xar,
    /// FEAT_SHA256: four rounds of the hash on the state halves, the
    /// accumulator `abcd` with `efgh` (`sha256h`, `true`) or `efgh` with
    /// `abcd` (`sha256h2`), and the two message schedule updates.
    Sha256Hash(bool),
    Sha256Su0,
    Sha256Su1,
    /// FEAT_SHA1: four rounds of the hash on the state `abcd` and `e` in the
    /// second operand's low word, with the round function `sha1c`
    /// (choose), `sha1p` (parity) or `sha1m` (majority) names, and the two
    /// message schedule updates.
    Sha1Hash(Sha1F),
    Sha1Su0,
    Sha1Su1,
    /// Data movement: the form carries the direction.
    Move,
    /// Hardware random number generator.
    Rand,
    /// Products of each quadword's low doubleword, signed when `true`.
    MulEven(bool),
    /// The low lanes widened from the first width to the second, signed when
    /// the first flag is set; the high half's lanes when the second is.
    Extend(u8, u8, bool, bool),
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
    /// The forms that cross the 128-bit lanes: quadword `i` of each 256-bit
    /// half is that half's quadword `imm[2i+1:2i]` (`vpermq`).
    Perm4x64,
    /// Doubleword `i` is the first operand's doubleword the second operand's
    /// doubleword `i` selects, modulo the count (`vpermd`).
    PermVar32,
    /// 128-bit lane `i` is lane `imm[2i+1:2i]` of the first operand for the
    /// low half of the lanes and of the second for the high (`vshufi64x2`).
    ShufLanes128,
    /// Each doubleword of the accumulator plus its four products of an
    /// unsigned byte of the first source and a signed byte of the second,
    /// saturating when `true` (`vpdpbusd`, `vpdpbusds`).
    DotBytes(bool),
    /// The same of two signed word products (`vpdpwssd`, `vpdpwssds`).
    DotWords(bool),
    /// Each bit is `imm` bit `(acc << 2) | (a << 1) | b` of the three
    /// operands' bits (`vpternlogd`).
    TernLog,
    /// The imm8 predicate of `vpcmp` / `vpcmpu` over lanes of the width,
    /// signed when `true`: 0 eq, 1 lt, 2 le, 3 false, 4 ne, 5 nlt, 6 nle,
    /// 7 true.
    CmpPred(u8, bool),
    /// Each 128-bit half is the half of either source, or zero, that the
    /// immediate's nibble selects (`vperm2i128`).
    Perm2x128,
    /// Lane-wise `(a + b) >> 1` of the signed (`true`) or unsigned lanes,
    /// rounded up when the second flag is set (`shadd`, `urhadd`).
    HalvingAdd(u8, bool, bool),
    /// Lane-wise `(a - b) >> 1`, signed when `true` (`shsub`, `uhsub`).
    HalvingSub(u8, bool),
    /// Lane-wise `|a - b|`, signed when `true` (`sabd`, `uabd`).
    AbsDiff(u8, bool),
    /// `a & !b` (`bic`).
    BitClear,
    /// `a | !b` (`orn`).
    OrNot,
    /// A lane of ones where signed `a >= b` holds (`cmge`).
    CmpGe(u8),
    /// A lane of ones where unsigned `a > b` holds (`cmhi`).
    CmpHi(u8),
    /// A lane of ones where unsigned `a >= b` holds (`cmhs`).
    CmpHs(u8),
    /// A lane of ones where `a & b` is nonzero (`cmtst`).
    CmpTst(u8),
    /// The larger or the smaller lane of each adjacent pair, signed when
    /// `true`, the first operand's pairs low (`smaxp`, `uminp`).
    PairMax(u8, bool),
    PairMin(u8, bool),
    /// Lane-wise negation, wrapping (`neg`) or saturating (`sqneg`).
    Neg(u8),
    NegSat(u8),
    /// Lane magnitude saturated, the most negative lane the largest (`sqabs`).
    AbsSat(u8),
    /// Lane-wise count of leading zero bits (`clz`) and of the leading bits
    /// below the sign that equal it (`cls`).
    Clz(u8),
    Cls(u8),
    /// The number of set bits of each byte (`cnt`).
    PopCnt,
    /// The complement of each bit (`mvn`).
    Not,
    /// The accumulator plus or minus the lane-wise product of the other two
    /// operands, wrapping (`mla`, `mls`).
    MulAcc(u8),
    MulSub(u8),
    /// The accumulator plus `|a - b|` of the other two operands, signed when
    /// `true` (`saba`, `uaba`).
    AbsDiffAcc(u8, bool),
    /// Each bit of the accumulator selects the first operand's bit where
    /// set and the second's where clear (`bsl`).
    BitSelect,
    /// The floating lanes' magnitude and negation, the sign bit cleared or
    /// flipped, a NaN's included (`fabs`, `fneg`).
    FAbs(u8),
    FNeg(u8),
    /// A floating comparison by a fixed predicate, numbered as
    /// [`Sem::FloatCmp`]'s immediate (`fcmeq` 0, `fcmge` 13, `fcmgt` 14).
    FloatRel(u8, u8),
    /// The accumulator plus, or minus when `true`, the product of the other
    /// two operands, rounded once (`fmla`, `fmls`).
    FloatFma(u8, bool),
    /// Lanes of the source width, signed when the first flag is set, taken
    /// from the low half of their 16 bytes or from the high half when the
    /// second is: `op` of each pair into a lane twice as wide (`saddl`,
    /// `umull2`).
    Long(LongOp, u8, bool, bool),
    /// The first operand's lanes, twice the source width, with `op` of the
    /// second's narrow lanes (`saddw`, `usubw2`).
    Wide(LongOp, u8, bool, bool),
    /// The accumulator's wide lanes plus `op` of the narrow lanes of the
    /// other two operands (`smlal`, `uabal2`); `op` is `Mul`, `MulSub` or
    /// `AbsDiff`.
    LongAcc(LongOp, u8, bool, bool),
    /// Each lane of the source width into a lane half as wide, in the low 8
    /// bytes of the result (`xtn`, `sqxtn`, `uqxtn`, `sqxtun`).
    Narrow(u8, NarrowKind),
    /// Each lane, signed when the first flag is set, shifted by the signed
    /// low byte of the second operand's lane: left when positive, right
    /// when negative, rounding a right shift when the second flag is set
    /// and saturating a left one when the third is (`sshl`, `urshl`,
    /// `sqshl`).
    ShlReg(u8, bool, bool, bool),
    /// The sum, largest or smallest of the source's lanes of the width,
    /// signed when `true`, over its first `bytes`, into lane 0, the rest
    /// zero; a long sum is as wide as twice the lanes (`addv`, `smaxv`,
    /// `uaddlv`).
    Across(AcrossOp, u8, bool, u8),
    /// The sums of adjacent lane pairs into lanes twice as wide, signed
    /// when `true` (`saddlp`, `uaddlp`).
    PairAddLong(u8, bool),
    /// The lanes of the width reversed within each group of the second
    /// width (`rev16`, `rev32`, `rev64`).
    Rev(u8, u8),
    /// A permutation of two vectors' lanes of the width, the second form
    /// when `true`, over vectors of the last width (`zip1`, `uzp2`, ...).
    Perm(PermOp, u8, bool, u8),
    /// The bytes of two vectors of the width, the first low, from the
    /// immediate's byte on (`ext`).
    Ext(u8),
    /// The source's lane of the width the immediate names, in every lane
    /// of the result (`dup` from an element).
    DupLane(u8),
    /// A right shift by the immediate, rounding, signed when `true`
    /// (`srshr`, `urshr`).
    ShrRound(u8, bool),
    /// A left shift by the immediate saturating to the lane, signed when
    /// `true` (`sqshl`, `uqshl` by an immediate).
    ShlSat(u8, bool),
    /// A right shift by the immediate of lanes of the width into lanes half
    /// as wide, rounding when `true` (`shrn`, `rshrn`).
    ShrNarrow(u8, bool),
    /// The bytes of a 16-byte table the second operand's bytes index, zero
    /// for an index past it, over results of the width (`tbl`).
    Tbl(u8),
    /// [`Sem::Tbl`] keeping the accumulator's byte for an index past the
    /// table (`tbx`).
    Tbx(u8),
    /// The first operand plus each lane of the second shifted right by the
    /// immediate, signed when the first flag is set and rounding when the
    /// second is (`ssra`, `ursra`).
    ShrAcc(u8, bool, bool),
    /// Each lane of the second operand shifted by the immediate, left when
    /// `true`, into the first's, which keeps the bits the shift vacates
    /// (`sli`, `sri`).
    ShiftInsert(u8, bool),
}

/// The permutation of a [`Sem::Perm`] form.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum PermOp {
    /// The lanes of one half of each vector, interleaved: the low half,
    /// or the high in the second form.
    Zip,
    /// The even lanes of the two vectors' concatenation, or the odd ones.
    Uzp,
    /// The even lanes of each vector, alternated, or the odd ones.
    Trn,
}

/// The reduction of an across-lanes form.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum AcrossOp {
    Add,
    AddLong,
    Max,
    Min,
}

/// The operation of a widening form: on the narrow lanes, its result as
/// wide as their double.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum LongOp {
    Add,
    Sub,
    Mul,
    /// The product subtracted from the accumulator (`smlsl`).
    MulSub,
    AbsDiff,
    /// The carry-less (polynomial) product (`pmull`).
    PolyMul,
}

/// How a narrowing form fits a lane into half its width: the low bits, or
/// saturated to the signed or the unsigned range, from a signed or (`Uns`)
/// unsigned lane.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum NarrowKind {
    Trunc,
    SatSigned,
    SatUns,
    SatSignedToUns,
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
                | Sem::HalvingAdd(..)
                | Sem::AbsDiff(..)
                | Sem::CmpTst(_)
        )
    }
}

/// A floating-point lane operation. MIN and MAX give the second operand
/// unless the first is strictly less (greater), a NaN or two zeros included.
/// MAXNAN and MINNAN propagate a NaN operand as arithmetic does and order
/// -0 below +0 (`fmax`, `fmin`).
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum FOp {
    Add,
    Sub,
    Mul,
    Div,
    Min,
    Max,
    Sqrt,
    MaxNan,
    MinNan,
}

/// The round function of a SHA-1 hash update.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum Sha1F {
    Choose,
    Parity,
    Majority,
}

/// A conversion, from the low lanes of the source to the low lanes of the
/// result, the rest zero. An int32 result is 0x80000000 for a NaN or a value
/// out of range.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum Cvt {
    IntToSingle,
    SingleToInt {
        truncate: bool,
    },
    UIntToSingle,
    SingleToUInt {
        truncate: bool,
    },
    IntToDouble,
    DoubleToInt {
        truncate: bool,
    },
    SingleToDouble,
    /// The upper two singles.
    SingleToDoubleHigh,
    DoubleToSingle,
    /// Every 8-byte integer lane to a `double`, signed when set.
    Int64ToDouble {
        signed: bool,
    },
    /// Every float lane of the width to an integer of that width, toward
    /// zero, saturating, a NaN to zero: AArch64's `fcvtzs` / `fcvtzu`.
    ToIntSat {
        w: u8,
        signed: bool,
    },
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
    /// `a * b + c` rounded once.
    fn fma(&mut self, a: u64, b: u64, c: u64, single: bool) -> u64;
}

pub(crate) struct SimdOp {
    pub name: &'static str,
    /// Instruction mnemonic, resolved through the x86 assembler's tables.
    pub mnem: &'static str,
    pub form: Form,
    pub ret: Ret,
    pub sem: Sem,
    /// Width in bytes of the integer operand or result of the forms that
    /// have one (`Extract`, `Insert`, `Shift`, `RdRand`), of the lane of a
    /// masked form, and of the vector part of `Narrow`, `Widen` and `Zext`;
    /// 0 otherwise.
    pub int_width: u8,
    /// Width in bytes of the vector operands and result: 16, or 8 for an
    /// MMX form, which runs as the SSE instruction on the low half of the
    /// xmm registers, every lane of its result within that half.
    pub bytes: u8,
}

impl SimdOp {
    /// The stores the instruction performs, as `(operand index, bytes)`:
    /// the result through the destination address -- 16 bytes for a
    /// vector, 4 for an `int`, 8 for a `long long` -- and for `RdRand` the
    /// random value through
    /// the pointer operand as well. The store form has no destination of
    /// its own; its 16 bytes go through the pointer operand, its first.
    pub(crate) fn stores(&self) -> impl Iterator<Item = (usize, u8)> {
        // A result's own width: a narrowing or extracting row writes fewer
        // bytes than its operands hold.
        let width = if self.form.returns_vector() {
            self.ret_bytes()
        } else if matches!(self.form, Form::Store | Form::MaskStore) {
            self.bytes
        } else if self.form == Form::ToInt || self.int_width == 8 {
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
            Form::V | Form::Load | Form::MoveMask | Form::RdRand | Form::ToInt | Form::Zext => 1,
            Form::Vv | Form::VI | Form::Shift | Form::Store | Form::Extract | Form::Narrow => 2,
            Form::VvI
            | Form::Insert
            | Form::Vvv
            | Form::CmpMask
            | Form::MaskBlend
            | Form::Widen => 3,
            Form::MaskStore => 3,
            Form::MaskLoad => 2,
            Form::VvvI => 4,
        }
    }

    /// Whether the form takes an opmask, which only EVEX encodes at every
    /// vector length.
    pub(crate) fn is_opmask(self) -> bool {
        matches!(
            self,
            Form::CmpMask | Form::MaskBlend | Form::MaskLoad | Form::MaskStore
        )
    }

    /// Whether the last operand must be an integer constant expression that
    /// the instruction encodes as `imm8`.
    pub(crate) fn takes_imm(self) -> bool {
        matches!(
            self,
            Form::VvI
                | Form::VI
                | Form::Extract
                | Form::Insert
                | Form::VvvI
                | Form::CmpMask
                | Form::Narrow
                | Form::Widen
        )
    }

    /// Whether the result is a vector rather than an `int`.
    pub(crate) fn returns_vector(self) -> bool {
        matches!(
            self,
            Form::Vv
                | Form::VvI
                | Form::Vvv
                | Form::VvvI
                | Form::MaskBlend
                | Form::MaskLoad
                | Form::VI
                | Form::V
                | Form::Shift
                | Form::Load
                | Form::Insert
                | Form::Narrow
                | Form::Widen
                | Form::Zext
        )
    }
}

impl SimdOp {
    /// Width in bytes of vector source `i`, counted from 0 without the
    /// destination: `bytes`, `int_width` for a part, or the wide first
    /// operand of a form that adds narrow lanes to it or accumulates
    /// into it.
    pub(crate) fn arg_bytes(&self, i: usize) -> u8 {
        match (self.form, self.sem) {
            (Form::Widen, _) if i == 1 => self.int_width,
            (Form::Zext, _) => self.int_width,
            (_, Sem::Wide(..) | Sem::LongAcc(..)) if i == 0 => 16,
            // The table is a full register whatever the index width.
            (_, Sem::Tbl(_)) if i == 0 => 16,
            (_, Sem::Tbx(_)) if i == 1 => 16,
            _ => self.bytes,
        }
    }

    /// Width in bytes of a vector result.
    pub(crate) fn ret_bytes(&self) -> u8 {
        match self.ret.bytes() {
            0 if self.form == Form::Narrow => self.int_width,
            0 => self.bytes,
            n => n,
        }
    }

    /// The lane width and the register width, in bytes, of operand `i`,
    /// the destination 0 and the sources from 1, as an instruction names
    /// its arrangements.
    pub(crate) fn arrangement(&self, i: usize) -> (u8, u8) {
        let lane = self.ret.lane_bytes();
        // A reduction writes the scalar view of its lane width.
        if i == 0
            && let Sem::Across(op, w, ..) = self.sem
        {
            let rw = if op == AcrossOp::AddLong { 2 * w } else { w };
            return (rw, rw);
        }
        if i == 0 {
            return (lane, self.ret_bytes());
        }
        let src = match self.sem {
            Sem::Long(_, w, ..) | Sem::Across(_, w, ..) | Sem::PairAddLong(w, _) => w,
            Sem::Wide(_, w, ..) | Sem::LongAcc(_, w, ..) if i > 1 => w,
            Sem::Narrow(w, _) | Sem::ShrNarrow(w, _) => w,
            Sem::Extend(from, ..) => from,
            Sem::Convert(Cvt::SingleToDouble | Cvt::SingleToDoubleHigh) => 4,
            Sem::Convert(Cvt::DoubleToSingle) => 8,
            _ => lane,
        };
        (src, self.arg_bytes(i - 1))
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

/// Every lane of the width holding `x`.
fn splat(width: u8, x: i64) -> [u8; 16] {
    let mut o = [0u8; 16];
    for i in 0..16 / width as usize {
        set_lane(&mut o, width, i, x as u64 & mask(width));
    }
    o
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
/// Lane `i` of `a` and of `b`, signed or unsigned, widened so a sum or a
/// difference of two 64-bit lanes is exact.
fn wide_lanes(a: &[u8; 16], b: &[u8; 16], w: u8, i: usize, signed: bool) -> (i128, i128) {
    if signed {
        (i128::from(slane(a, w, i)), i128::from(slane(b, w, i)))
    } else {
        (i128::from(lane(a, w, i)), i128::from(lane(b, w, i)))
    }
}

/// [`eval`] over 8-byte operands, the low halves of `a` and `b`. A pairwise
/// form reads the two operands as one: its result is the 16-byte form's
/// over `a` and `b` side by side.
pub(crate) fn eval64(sem: Sem, a: &[u8; 16], b: &[u8; 16], imm: u8, count: u64) -> [u8; 16] {
    let pairwise = matches!(
        sem,
        Sem::HAdd(..) | Sem::HSub(..) | Sem::PairMax(..) | Sem::PairMin(..)
    );
    let mut o = if pairwise {
        let mut ab = *a;
        ab[8..].copy_from_slice(&b[..8]);
        eval(sem, &ab, &[0u8; 16], imm, count)
    } else {
        eval(sem, a, b, imm, count)
    };
    o[8..].fill(0);
    o
}

/// A form that accumulates into its first operand: `acc` combined with
/// the lane-wise result of `a` and `b` ([`Sem::MulAcc`], [`Sem::MulSub`],
/// [`Sem::AbsDiffAcc`], [`Sem::BitSelect`], [`Sem::LongAcc`]); `None` for
/// another semantics.
pub(crate) fn eval_acc(sem: Sem, acc: &[u8; 16], a: &[u8; 16], b: &[u8; 16]) -> Option<[u8; 16]> {
    let (w, part) = match sem {
        Sem::MulAcc(w) | Sem::MulSub(w) => (w, eval(Sem::MulLo(w), a, b, 0, 0)),
        Sem::AbsDiffAcc(w, signed) => (w, eval(Sem::AbsDiff(w, signed), a, b, 0, 0)),
        Sem::LongAcc(op, w, signed, high) => {
            let part_op = if op == LongOp::MulSub {
                LongOp::Mul
            } else {
                op
            };
            let part = eval(Sem::Long(part_op, w, signed, high), a, b, 0, 0);
            let combine = if op == LongOp::MulSub {
                Sem::Sub(2 * w)
            } else {
                Sem::Add(2 * w)
            };
            return Some(eval(combine, acc, &part, 0, 0));
        }
        Sem::BitSelect => {
            let mut o = [0u8; 16];
            for i in 0..16 {
                o[i] = (acc[i] & a[i]) | (!acc[i] & b[i]);
            }
            return Some(o);
        }
        Sem::Sha1Hash(f) => return Some(sha1_hash(acc, lane(a, 4, 0) as u32, b, f)),
        Sem::Sha1Su0 => {
            let w = |v: &[u8; 16], i: usize| lane(v, 4, i) as u32;
            let mut o = [0u8; 16];
            for e in 0..4 {
                let t = if e < 2 { w(acc, e + 2) } else { w(a, e - 2) };
                set_lane(&mut o, 4, e, u64::from(t ^ w(acc, e) ^ w(b, e)));
            }
            return Some(o);
        }
        Sem::Sha256Hash(part1) => {
            return Some(match part1 {
                true => sha256_hash(acc, a, b, true),
                false => sha256_hash(a, acc, b, false),
            });
        }
        Sem::Sha256Su1 => {
            let w = |v: &[u8; 16], i: usize| lane(v, 4, i) as u32;
            let sigma1 = |x: u32| x.rotate_right(17) ^ x.rotate_right(19) ^ x >> 10;
            let t0 = |e: usize| if e < 3 { w(a, e + 1) } else { w(b, 0) };
            let mut r = [0u32; 4];
            for e in 0..4 {
                let t1 = if e < 2 { w(b, e + 2) } else { r[e - 2] };
                r[e] = sigma1(t1).wrapping_add(w(acc, e)).wrapping_add(t0(e));
            }
            let mut o = [0u8; 16];
            r.iter()
                .enumerate()
                .for_each(|(e, &x)| set_lane(&mut o, 4, e, u64::from(x)));
            return Some(o);
        }
        Sem::Eor3 | Sem::Bcax => {
            let mut o = [0u8; 16];
            for i in 0..16 {
                o[i] = match sem {
                    Sem::Eor3 => acc[i] ^ a[i] ^ b[i],
                    _ => acc[i] ^ (a[i] & !b[i]),
                };
            }
            return Some(o);
        }
        Sem::Tbx(bytes) => {
            let mut o = [0u8; 16];
            for i in 0..usize::from(bytes) {
                o[i] = a.get(usize::from(b[i])).copied().unwrap_or(acc[i]);
            }
            return Some(o);
        }
        _ => return None,
    };
    let combine = if matches!(sem, Sem::MulSub(_)) {
        Sem::Sub(w)
    } else {
        Sem::Add(w)
    };
    Some(eval(combine, acc, &part, 0, 0))
}

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
        Sem::PolyMul(w) => {
            for i in 0..16 / w as usize {
                let (x, y) = (lane(a, w, i), lane(b, w, i));
                let p = (0..8 * w)
                    .filter(|k| y >> k & 1 != 0)
                    .fold(0, |p, k| p ^ x << k);
                set_lane(&mut o, w, i, p & mask(w));
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
                let sum = u128::from(lane(a, w, i)) + u128::from(lane(b, w, i)) + 1;
                set_lane(&mut o, w, i, (sum >> 1) as u64);
            }
        }
        Sem::HalvingAdd(w, signed, round) => {
            for i in 0..16 / w as usize {
                let (x, y) = wide_lanes(a, b, w, i, signed);
                set_lane(
                    &mut o,
                    w,
                    i,
                    ((x + y + i128::from(round)) >> 1) as u64 & mask(w),
                );
            }
        }
        Sem::HalvingSub(w, signed) => {
            for i in 0..16 / w as usize {
                let (x, y) = wide_lanes(a, b, w, i, signed);
                set_lane(&mut o, w, i, ((x - y) >> 1) as u64 & mask(w));
            }
        }
        Sem::AbsDiff(w, signed) => {
            for i in 0..16 / w as usize {
                let (x, y) = wide_lanes(a, b, w, i, signed);
                set_lane(&mut o, w, i, (x - y).unsigned_abs() as u64 & mask(w));
            }
        }
        Sem::BitClear => {
            for i in 0..16 {
                o[i] = a[i] & !b[i];
            }
        }
        Sem::OrNot => {
            for i in 0..16 {
                o[i] = a[i] | !b[i];
            }
        }
        Sem::CmpGe(w) | Sem::CmpHi(w) | Sem::CmpHs(w) | Sem::CmpTst(w) => {
            for i in 0..16 / w as usize {
                let (x, y) = (lane(a, w, i), lane(b, w, i));
                let holds = match sem {
                    Sem::CmpGe(_) => slane(a, w, i) >= slane(b, w, i),
                    Sem::CmpHi(_) => x > y,
                    Sem::CmpHs(_) => x >= y,
                    _ => x & y != 0,
                };
                set_lane(&mut o, w, i, if holds { mask(w) } else { 0 });
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
                (-(1i128 << (bits - 1)), (1i128 << (bits - 1)) - 1)
            } else {
                (0, (1i128 << bits) - 1)
            };
            for i in 0..16 / w as usize {
                let (x, y) = wide_lanes(a, b, w, i, signed);
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
        Sem::PairMax(w, signed) | Sem::PairMin(w, signed) => {
            let pairs = 8 / w as usize;
            for i in 0..2 * pairs {
                let src = if i < pairs { a } else { b };
                let k = 2 * (i % pairs);
                let less = if signed {
                    slane(src, w, k) < slane(src, w, k + 1)
                } else {
                    lane(src, w, k) < lane(src, w, k + 1)
                };
                let first = less == matches!(sem, Sem::PairMin(..));
                set_lane(&mut o, w, i, lane(src, w, if first { k } else { k + 1 }));
            }
        }
        Sem::Neg(w) | Sem::NegSat(w) | Sem::AbsSat(w) => {
            let bits = 8 * w as u32;
            let (lo, hi) = (-(1i128 << (bits - 1)), (1i128 << (bits - 1)) - 1);
            for i in 0..16 / w as usize {
                let x = i128::from(slane(a, w, i));
                let r = match sem {
                    Sem::Neg(_) => -x,
                    Sem::NegSat(_) => (-x).clamp(lo, hi),
                    _ => x.abs().clamp(lo, hi),
                };
                set_lane(&mut o, w, i, r as u64 & mask(w));
            }
        }
        Sem::Clz(w) | Sem::Cls(w) => {
            let bits = 8 * u32::from(w);
            for i in 0..16 / w as usize {
                let x = lane(a, w, i) << (64 - bits);
                let n = match sem {
                    Sem::Clz(_) => x.leading_zeros().min(bits),
                    // The bits after the sign that equal it: bit `k` of
                    // `x ^ x << 1` compares bits `k` and `k - 1`, and the
                    // set bit past the lane stops the count at its end.
                    _ => ((x ^ (x << 1)) | (1u64 << (64 - bits))).leading_zeros(),
                };
                set_lane(&mut o, w, i, u64::from(n));
            }
        }
        Sem::PopCnt => {
            for i in 0..16 {
                o[i] = a[i].count_ones() as u8;
            }
        }
        // A 64-bit polynomial product fills the 128-bit result.
        Sem::Long(LongOp::PolyMul, 8, _, high) => {
            let (lo, hi) = clmul(lane(a, 8, high as usize), lane(b, 8, high as usize));
            set_lane(&mut o, 8, 0, lo);
            set_lane(&mut o, 8, 1, hi);
        }
        Sem::Long(op, w, signed, high) | Sem::Wide(op, w, signed, high) => {
            let base = if high { 8 / w as usize } else { 0 };
            let get = |v: &[u8; 16], i: usize| match signed {
                true => i128::from(slane(v, w, i)),
                false => i128::from(lane(v, w, i)),
            };
            for i in 0..8 / w as usize {
                let x = match sem {
                    Sem::Wide(..) if signed => i128::from(slane(a, 2 * w, i)),
                    Sem::Wide(..) => i128::from(lane(a, 2 * w, i)),
                    _ => get(a, base + i),
                };
                let y = get(b, base + i);
                let r = match op {
                    LongOp::Add => x + y,
                    LongOp::Sub => x - y,
                    LongOp::Mul | LongOp::MulSub => x * y,
                    LongOp::AbsDiff => (x - y).abs(),
                    LongOp::PolyMul => i128::from(clmul(x as u64, y as u64).0),
                };
                set_lane(&mut o, 2 * w, i, r as u64 & mask(2 * w));
            }
        }
        Sem::ShlReg(w, signed, round, sat) => {
            let bits = 8 * i32::from(w);
            let (lo, hi) = match signed {
                true => (-(1i128 << (bits - 1)), (1i128 << (bits - 1)) - 1),
                false => (0, (1i128 << bits) - 1),
            };
            for i in 0..16 / w as usize {
                let x = match signed {
                    true => i128::from(slane(a, w, i)),
                    false => i128::from(lane(a, w, i)),
                };
                let s = i32::from(lane(b, w, i) as u8 as i8);
                // A left shift at or past the width keeps no bit of `x`, and
                // the saturating form saturates a nonzero one.
                let r = match s {
                    0.. if s >= bits && sat && x != 0 => {
                        if x < 0 {
                            lo - 1
                        } else {
                            hi + 1
                        }
                    }
                    0.. if s >= bits => 0,
                    0.. => x << s,
                    _ => {
                        let n = (-s).min(127);
                        let bias = if round { 1i128 << (n - 1) } else { 0 };
                        (x + bias) >> n
                    }
                };
                let r = if sat { r.clamp(lo, hi) } else { r };
                set_lane(&mut o, w, i, r as u64 & mask(w));
            }
        }
        Sem::Across(op, w, signed, bytes) => {
            let get = |i: usize| match signed {
                true => i128::from(slane(a, w, i)),
                false => i128::from(lane(a, w, i)),
            };
            let lanes = (0..usize::from(bytes / w)).map(get);
            let r = match op {
                AcrossOp::Add | AcrossOp::AddLong => lanes.sum(),
                AcrossOp::Max => lanes.max().unwrap_or(0),
                AcrossOp::Min => lanes.min().unwrap_or(0),
            };
            let rw = if op == AcrossOp::AddLong { 2 * w } else { w };
            set_lane(&mut o, rw, 0, r as u64 & mask(rw));
        }
        Sem::PairAddLong(w, signed) => {
            for i in 0..8 / w as usize {
                let (x, y) = match signed {
                    true => (slane(a, w, 2 * i) as i128, slane(a, w, 2 * i + 1) as i128),
                    false => (lane(a, w, 2 * i) as i128, lane(a, w, 2 * i + 1) as i128),
                };
                set_lane(&mut o, 2 * w, i, (x + y) as u64 & mask(2 * w));
            }
        }
        // The shift forms carry their count in `count`.
        Sem::ShrRound(w, signed) => {
            let n = count.min(64) as i64;
            o = eval(Sem::ShlReg(w, signed, true, false), a, &splat(w, -n), 0, 0);
        }
        Sem::ShlSat(w, signed) => {
            let n = count.min(64) as i64;
            o = eval(Sem::ShlReg(w, signed, false, true), a, &splat(w, n), 0, 0);
        }
        Sem::ShrNarrow(w, round) => {
            let n = count.min(64) as i64;
            let wide = eval(Sem::ShlReg(w, false, round, false), a, &splat(w, -n), 0, 0);
            for i in 0..16 / w as usize {
                set_lane(&mut o, w / 2, i, lane(&wide, w, i) & mask(w / 2));
            }
        }
        Sem::Tbl(bytes) => {
            for i in 0..usize::from(bytes) {
                o[i] = a.get(usize::from(b[i])).copied().unwrap_or(0);
            }
        }
        Sem::ShrAcc(w, signed, round) => {
            let n = i64::from(imm);
            let part = eval(Sem::ShlReg(w, signed, round, false), b, &splat(w, -n), 0, 0);
            o = eval(Sem::Add(w), a, &part, 0, 0);
        }
        Sem::ShiftInsert(w, left) => {
            let n = u32::from(imm);
            let shift = |x: u64| match left {
                true => x.checked_shl(n).unwrap_or(0),
                false => x.checked_shr(n).unwrap_or(0),
            };
            let kept = !shift(mask(w)) & mask(w);
            for i in 0..16 / w as usize {
                let x = shift(lane(b, w, i)) & mask(w) | lane(a, w, i) & kept;
                set_lane(&mut o, w, i, x);
            }
        }
        Sem::DupLane(w) => {
            let x = lane(a, w, usize::from(imm));
            for i in 0..16 / w as usize {
                set_lane(&mut o, w, i, x);
            }
        }
        Sem::Ext(bytes) => {
            let (n, at) = (usize::from(bytes), usize::from(imm));
            for (i, byte) in o.iter_mut().take(n).enumerate() {
                *byte = match i + at {
                    k if k < n => a[k],
                    k if k < 2 * n => b[k - n],
                    _ => 0,
                };
            }
        }
        Sem::Perm(op, w, second, bytes) => {
            let (n, h) = (usize::from(bytes / w), usize::from(second));
            for i in 0..n {
                let (src, k) = match op {
                    PermOp::Zip => (if i % 2 == 0 { a } else { b }, i / 2 + h * n / 2),
                    PermOp::Uzp => match 2 * i + h {
                        j if j < n => (a, j),
                        j => (b, j - n),
                    },
                    PermOp::Trn => (if i % 2 == 0 { a } else { b }, (i & !1) + h),
                };
                set_lane(&mut o, w, i, lane(src, w, k));
            }
        }
        Sem::Rev(w, group) => {
            let per = usize::from(group / w);
            for i in 0..16 / w as usize {
                let base = i - i % per;
                set_lane(&mut o, w, i, lane(a, w, base + per - 1 - i % per));
            }
        }
        Sem::Narrow(w, kind) => {
            let h = w / 2;
            let bits = 8 * u32::from(h);
            for i in 0..16 / w as usize {
                let (s, u) = (i128::from(slane(a, w, i)), i128::from(lane(a, w, i)));
                let (smin, smax, umax) = (
                    -(1i128 << (bits - 1)),
                    (1i128 << (bits - 1)) - 1,
                    (1i128 << bits) - 1,
                );
                let r = match kind {
                    NarrowKind::Trunc => u,
                    NarrowKind::SatSigned => s.clamp(smin, smax),
                    NarrowKind::SatUns => u.min(umax),
                    NarrowKind::SatSignedToUns => s.clamp(0, umax),
                };
                set_lane(&mut o, h, i, r as u64 & mask(h));
            }
        }
        Sem::FAbs(w) | Sem::FNeg(w) => {
            let sign = 1u64 << (8 * u32::from(w) - 1);
            for i in 0..16 / w as usize {
                let x = lane(a, w, i);
                let r = if matches!(sem, Sem::FAbs(_)) {
                    x & !sign
                } else {
                    x ^ sign
                };
                set_lane(&mut o, w, i, r);
            }
        }
        Sem::Not => {
            for i in 0..16 {
                o[i] = !a[i];
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
        Sem::AesRound(decrypt) => {
            let x = xor16(a, b);
            o = match decrypt {
                false => sub_bytes(&shift_rows(&x)),
                true => inv_sub_bytes(&inv_shift_rows(&x)),
            };
        }
        Sem::AesMix => o = mix_columns(a, MIX),
        Sem::Sha1Su1 => {
            let w = |v: &[u8; 16], i: usize| lane(v, 4, i) as u32;
            let t: [u32; 4] =
                core::array::from_fn(|i| w(a, i) ^ if i < 3 { w(b, i + 1) } else { 0 });
            for e in 0..4 {
                let mut x = t[e].rotate_left(1);
                if e == 3 {
                    x ^= t[0].rotate_left(2);
                }
                set_lane(&mut o, 4, e, u64::from(x));
            }
        }
        Sem::Sha256Su0 => {
            let w = |v: &[u8; 16], i: usize| lane(v, 4, i) as u32;
            for e in 0..4 {
                let t = if e < 3 { w(a, e + 1) } else { w(b, 0) };
                let x = t.rotate_right(7) ^ t.rotate_right(18) ^ t >> 3;
                set_lane(&mut o, 4, e, u64::from(x.wrapping_add(w(a, e))));
            }
        }
        Sem::Rax1 | Sem::Xar => {
            for i in 0..2 {
                let x = match sem {
                    Sem::Rax1 => lane(a, 8, i) ^ lane(b, 8, i).rotate_left(1),
                    _ => (lane(a, 8, i) ^ lane(b, 8, i)).rotate_right(u32::from(imm) & 63),
                };
                set_lane(&mut o, 8, i, x);
            }
        }
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
        Sem::Extend(from, to, signed, high) => {
            let base = if high { 8 / from as usize } else { 0 };
            for i in 0..16 / to as usize {
                let x = if signed {
                    slane(a, from, base + i) as u64
                } else {
                    lane(a, from, base + i)
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
        // `eval_float` computes these in a floating-point environment,
        // `eval_acc` the accumulating forms, and `eval_wide` the
        // permutations across a 32-byte vector.
        Sem::Float(..) | Sem::FloatCmp(..) | Sem::Convert(_) | Sem::ToInt(..) => {}
        Sem::MulAcc(_) | Sem::MulSub(_) | Sem::AbsDiffAcc(..) | Sem::BitSelect | Sem::Tbx(_) => {}
        Sem::Eor3 | Sem::Bcax | Sem::Sha256Hash(_) | Sem::Sha256Su1 => {}
        Sem::Sha1Hash(_) | Sem::Sha1Su0 => {}
        Sem::FloatRel(..) | Sem::FloatFma(..) | Sem::LongAcc(..) => {}
        Sem::Perm4x64
        | Sem::PermVar32
        | Sem::Perm2x128
        | Sem::ShufLanes128
        | Sem::DotBytes(_)
        | Sem::DotWords(_)
        | Sem::TernLog
        | Sem::CmpPred(..) => {}
    }
    o
}

/// `Form::CmpMask`: bit `i` set where lane `i` of width `w` satisfies the
/// predicate between `a` and `b`, over the first `n` bytes.
pub(crate) fn eval_cmp_mask(sem: Sem, a: &[u8; 64], b: &[u8; 64], imm: u8, n: usize) -> u64 {
    let Sem::CmpPred(w, signed) = sem else {
        return 0;
    };
    let wd = usize::from(w);
    let mut m = 0u64;
    for i in 0..n / wd {
        let get = |v: &[u8; 64]| {
            let mut x = [0u8; 8];
            x[..wd].copy_from_slice(&v[i * wd..i * wd + wd]);
            let u = u64::from_le_bytes(x);
            if signed {
                let sh = 64 - 8 * u32::from(w);
                i128::from((u << sh) as i64 >> sh)
            } else {
                i128::from(u)
            }
        };
        let (x, y) = (get(a), get(b));
        let holds = match imm & 7 {
            0 => x == y,
            1 => x < y,
            2 => x <= y,
            3 => false,
            4 => x != y,
            5 => x >= y,
            6 => x > y,
            _ => true,
        };
        m |= u64::from(holds) << i;
    }
    m
}

/// A 32- or 64-byte form over the first `n` bytes: a permutation across the
/// 128-bit lanes or an operation of three sources over the whole vectors,
/// any other operation on each 16 bytes. `a` and `b` are the first two
/// operands (the data and indices of `vpermd`), `c` the third.
pub(crate) fn eval_wide(
    sem: Sem,
    (a, b, c): (&[u8; 64], &[u8; 64], &[u8; 64]),
    imm: u8,
    count: u64,
    n: usize,
) -> [u8; 64] {
    let mut o = [0u8; 64];
    let part = |v: &[u8; 64], k: usize| -> [u8; 16] { v[k..k + 16].try_into().unwrap() };
    let dword =
        |v: &[u8; 64], i: usize| i32::from_le_bytes(v[4 * i..4 * i + 4].try_into().unwrap());
    match sem {
        Sem::Perm4x64 => {
            for h in (0..n).step_by(32) {
                for i in 0..4 {
                    let s = h + 8 * usize::from(imm >> (2 * i) & 3);
                    o[h + 8 * i..h + 8 * i + 8].copy_from_slice(&a[s..s + 8]);
                }
            }
        }
        Sem::PermVar32 => {
            for i in 0..n / 4 {
                let s = (b[4 * i] as usize) % (n / 4);
                o[4 * i..4 * i + 4].copy_from_slice(&a[4 * s..4 * s + 4]);
            }
        }
        Sem::Perm2x128 => {
            for h in 0..2 {
                let sel = imm >> (4 * h) & 0xF;
                if sel & 8 == 0 {
                    let src = if sel & 2 == 0 { a } else { b };
                    let k = 16 * usize::from(sel & 1);
                    o[16 * h..16 * h + 16].copy_from_slice(&src[k..k + 16]);
                }
            }
        }
        Sem::ShufLanes128 => {
            let lanes = n / 16;
            for i in 0..lanes {
                let src = if i < lanes / 2 { a } else { b };
                let k = 16 * (usize::from(imm >> (2 * i) & 3) % lanes);
                o[16 * i..16 * i + 16].copy_from_slice(&src[k..k + 16]);
            }
        }
        Sem::DotBytes(sat) | Sem::DotWords(sat) => {
            for i in 0..n / 4 {
                let mut sum = i64::from(dword(a, i));
                for j in 0..4 {
                    let k = 4 * i + j;
                    sum += match sem {
                        Sem::DotBytes(_) => i64::from(b[k]) * i64::from(c[k] as i8),
                        _ if j % 2 == 0 => {
                            let w = |v: &[u8; 64]| i64::from(i16::from_le_bytes([v[k], v[k + 1]]));
                            w(b) * w(c)
                        }
                        _ => 0,
                    };
                }
                let r = if sat {
                    sum.clamp(i64::from(i32::MIN), i64::from(i32::MAX)) as i32
                } else {
                    sum as i32
                };
                o[4 * i..4 * i + 4].copy_from_slice(&r.to_le_bytes());
            }
        }
        Sem::TernLog => {
            for k in 0..n {
                for bit in 0..8 {
                    let idx = (a[k] >> bit & 1) << 2 | (b[k] >> bit & 1) << 1 | (c[k] >> bit & 1);
                    o[k] |= (imm >> idx & 1) << bit;
                }
            }
        }
        _ => {
            for k in (0..n).step_by(16) {
                o[k..k + 16].copy_from_slice(&eval(sem, &part(a, k), &part(b, k), imm, count));
            }
        }
    }
    o
}

/// Four SHA-1 rounds over the state `x` (`abcd`) and `y` (`e`) with the
/// schedule words of `w` and round function `f`, as the Arm ARM's
/// `SHA1C` / `SHA1P` / `SHA1M`: the state after them.
fn sha1_hash(x: &[u8; 16], mut y: u32, w: &[u8; 16], f: Sha1F) -> [u8; 16] {
    let word = |v: &[u8; 16], i: usize| lane(v, 4, i) as u32;
    let mut x: [u32; 4] = core::array::from_fn(|i| word(x, i));
    for e in 0..4 {
        let (b, c, d) = (x[1], x[2], x[3]);
        let t = match f {
            Sha1F::Choose => ((c ^ d) & b) ^ d,
            Sha1F::Parity => b ^ c ^ d,
            Sha1F::Majority => (b & c) | ((b | c) & d),
        };
        y = y
            .wrapping_add(x[0].rotate_left(5))
            .wrapping_add(t)
            .wrapping_add(word(w, e));
        x[1] = x[1].rotate_left(30);
        // The 160-bit y:x rotated left by one word.
        (x, y) = ([y, x[0], x[1], x[2]], x[3]);
    }
    let mut o = [0u8; 16];
    x.iter()
        .enumerate()
        .for_each(|(e, &v)| set_lane(&mut o, 4, e, u64::from(v)));
    o
}

/// Four SHA-256 rounds over state halves `x` (`abcd`) and `y` (`efgh`) with
/// the schedule words of `w`, as the Arm ARM's `SHA256hash`: `x` after
/// them when `part1`, else `y`.
fn sha256_hash(x: &[u8; 16], y: &[u8; 16], w: &[u8; 16], part1: bool) -> [u8; 16] {
    let word = |v: &[u8; 16], i: usize| lane(v, 4, i) as u32;
    let mut x: [u32; 4] = core::array::from_fn(|i| word(x, i));
    let mut y: [u32; 4] = core::array::from_fn(|i| word(y, i));
    for e in 0..4 {
        let chs = ((y[1] ^ y[2]) & y[0]) ^ y[2];
        let maj = (x[0] & x[1]) | ((x[0] | x[1]) & x[2]);
        let s1 = y[0].rotate_right(6) ^ y[0].rotate_right(11) ^ y[0].rotate_right(25);
        let s0 = x[0].rotate_right(2) ^ x[0].rotate_right(13) ^ x[0].rotate_right(22);
        let t = y[3]
            .wrapping_add(s1)
            .wrapping_add(chs)
            .wrapping_add(word(w, e));
        x[3] = t.wrapping_add(x[3]);
        y[3] = t.wrapping_add(s0).wrapping_add(maj);
        // The 256-bit y:x rotated left by one word.
        (x, y) = ([y[3], x[0], x[1], x[2]], [x[3], y[0], y[1], y[2]]);
    }
    let mut o = [0u8; 16];
    let r = if part1 { x } else { y };
    r.iter()
        .enumerate()
        .for_each(|(e, &v)| set_lane(&mut o, 4, e, u64::from(v)));
    o
}

/// An 8-byte integer lane as a `double` in `env`, rounded once: an
/// unsigned value from 2^63 up halves with its low bit kept sticky and
/// doubles back.
fn int64_to_double(env: &mut impl FloatEnv, n: u64, signed: bool) -> u64 {
    if signed || n >> 63 == 0 {
        return env.integer_to_float(n as i64, false);
    }
    let half = env.integer_to_float((n >> 1 | n & 1) as i64, false);
    env.arith(FOp::Add, half, half, false)
}

/// A `double` bit pattern to a `bits`-wide integer toward zero in `env`,
/// saturating to the range and a NaN to zero, as AArch64 converts; the
/// environment raises invalid for both.
fn saturate_to_int(env: &mut impl FloatEnv, a: u64, bits: u32, signed: bool) -> u64 {
    let x = f64::from_bits(a);
    let half = (1u64 << (bits - 1)) as f64;
    let (low, high) = match signed {
        true => (-half, half),
        false => (0.0, 2.0 * half),
    };
    // Truncation keeps what lies above `low - 1`; a NaN fails every bound.
    if !(x < high && (x > low - 1.0 || x == low)) {
        env.to_int(a, true, 32, true);
        return match () {
            _ if x.is_nan() => 0,
            _ if x > 0.0 && signed => (1 << (bits - 1)) - 1,
            _ if x > 0.0 => u64::MAX,
            _ if signed => 1 << (bits - 1),
            _ => 0,
        };
    }
    if !signed && bits == 64 && x >= half {
        let d = env.arith(FOp::Sub, a, half.to_bits(), false);
        return env.to_int(d, true, 64, true) as u64 | 1 << 63;
    }
    env.to_int(a, true, if signed { bits } else { 64 }, true) as u64
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
    eval_float_in(env, sem, a, b, imm, 16)
}

/// Whether a lane's `double` bit pattern is a NaN.
fn is_nan(x: u64) -> bool {
    x & 0x7FF0_0000_0000_0000 == 0x7FF0_0000_0000_0000 && x & 0x000F_FFFF_FFFF_FFFF != 0
}

/// [`eval_float`] over the low `bytes` of the operands, the lanes of an
/// 8-byte form; the others keep the first operand's.
pub(crate) fn eval_float_in(
    env: &mut impl FloatEnv,
    sem: Sem,
    a: &[u8; 16],
    b: &[u8; 16],
    imm: u8,
    bytes: usize,
) -> Option<[u8; 16]> {
    use core::cmp::Ordering::{Equal, Greater, Less};
    let mut o = *a;
    let lanes = |w: u8, scalar: bool| if scalar { 1 } else { bytes / w as usize };
    let (imm, cmp) = match sem {
        Sem::FloatCmp(w, scalar) => (imm, Some((w, scalar))),
        Sem::FloatRel(w, p) => (p, Some((w, false))),
        _ => (imm, None),
    };
    match sem {
        Sem::Float(op, w, scalar) => {
            for i in 0..lanes(w, scalar) {
                let (x, y) = (flane(a, w, i), flane(b, w, i));
                match op {
                    FOp::Min | FOp::Max => {
                        let c = env.compare(x, y, true);
                        let first = c == Some(if op == FOp::Min { Less } else { Greater });
                        set_lane(&mut o, w, i, lane(if first { a } else { b }, w, i));
                    }
                    // A NaN operand propagates as an addition's would.
                    FOp::MaxNan | FOp::MinNan if is_nan(x) || is_nan(y) => {
                        set_flane(&mut o, w, i, env.arith(FOp::Add, x, y, w == 4));
                    }
                    FOp::MaxNan | FOp::MinNan => {
                        let max = op == FOp::MaxNan;
                        let first = match env.compare(x, y, false) {
                            Some(Equal) => (x >> 63 == 0) == max,
                            c => (c == Some(Greater)) == max,
                        };
                        set_lane(&mut o, w, i, lane(if first { a } else { b }, w, i));
                    }
                    FOp::Sqrt => set_flane(&mut o, w, i, env.arith(op, x, 0, w == 4)),
                    _ => set_flane(&mut o, w, i, env.arith(op, x, y, w == 4)),
                }
            }
        }
        // The 32 predicates of the VEX form, 0 to 7 those of the SSE one:
        // the relation in bits 3:0, bit 4 flipping whether a quiet NaN
        // signals invalid.
        Sem::FloatCmp(..) | Sem::FloatRel(..) => {
            let (w, scalar) = cmp.unwrap_or((8, false));
            for i in 0..lanes(w, scalar) {
                let p = imm & 31;
                let signals = matches!(p & 3, 1 | 2) ^ (p & 16 != 0);
                let c = env.compare(flane(a, w, i), flane(b, w, i), signals);
                let holds = match p & 15 {
                    0 => c == Some(Equal),
                    1 => c == Some(Less),
                    2 => matches!(c, Some(Less | Equal)),
                    3 => c.is_none(),
                    4 => c != Some(Equal),
                    5 => c != Some(Less),
                    6 => !matches!(c, Some(Less | Equal)),
                    7 => c.is_some(),
                    8 => matches!(c, Some(Equal) | None),
                    9 => matches!(c, Some(Less) | None),
                    10 => c != Some(Greater),
                    11 => false,
                    12 => matches!(c, Some(Less | Greater)),
                    13 => matches!(c, Some(Greater | Equal)),
                    14 => c == Some(Greater),
                    _ => true,
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
                Cvt::SingleToDouble | Cvt::SingleToDoubleHigh => (0..2).for_each(|i| {
                    let from = if cvt == Cvt::SingleToDoubleHigh { 2 } else { 0 };
                    let x = env.widen(flane(a, 4, from + i));
                    set_flane(&mut o, 8, i, x);
                }),
                Cvt::DoubleToSingle => (0..2).for_each(|i| {
                    let x = env.to_single(flane(a, 8, i));
                    set_flane(&mut o, 4, i, x);
                }),
                Cvt::Int64ToDouble { signed } => (0..2).for_each(|i| {
                    let x = int64_to_double(env, lane(a, 8, i), signed);
                    set_flane(&mut o, 8, i, x);
                }),
                Cvt::ToIntSat { w, signed } => (0..16 / w as usize).for_each(|i| {
                    let x = saturate_to_int(env, flane(a, w, i), 8 * u32::from(w), signed);
                    set_lane(&mut o, w, i, x & mask(w));
                }),
            }
        }
        _ => return None,
    }
    Some(o)
}

/// A form that accumulates into its first operand in `env`, over the low
/// `bytes` of the operands ([`Sem::FloatFma`]); `None` for another
/// semantics.
pub(crate) fn eval_float_acc(
    env: &mut impl FloatEnv,
    sem: Sem,
    (acc, a, b): (&[u8; 16], &[u8; 16], &[u8; 16]),
    bytes: usize,
) -> Option<[u8; 16]> {
    let Sem::FloatFma(w, negate) = sem else {
        return None;
    };
    let mut o = *acc;
    for i in 0..bytes / w as usize {
        let x = flane(a, w, i) ^ if negate { 1 << 63 } else { 0 };
        set_flane(
            &mut o,
            w,
            i,
            env.fma(x, flane(b, w, i), flane(acc, w, i), w == 4),
        );
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

//! Host-ABI classification of aggregate (struct / union / vector)
//! values for the platform calling conventions (System V AMD64, Win64,
//! AAPCS64). Given an aggregate's size and the byte ranges + leaf
//! kinds of its fields, decide whether it is passed / returned
//! in registers (and which class each register slot is), by an
//! implicit reference, on the stack, or via a hidden return pointer.
//!
//! The classifier is pure and target-driven through [`Abi`]; the
//! register-bank-exhaustion decision (an aggregate that wants
//! registers but finds too few left) is made later in
//! `plan_call_args`, which is the only place that tracks remaining
//! registers. This module only encodes the size / field-class rules.

use super::{Abi, Arch};

/// Leaf kind, after flattening nested structs / arrays / bitfields.
/// Width is carried separately in [`FlatField`].
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum ScalarKind {
    Int,
    F32,
    F64,
    /// x87 80-bit `long double` in a 16-byte field (System V x86-64).
    F80,
    /// IEEE binary128 `long double` (AAPCS64 ELF).
    F128,
    /// A GCC `vector_size` value. Both ABIs classify a vector by its
    /// whole width rather than by its lanes, so the flattening stops at
    /// the vector and the leaf's size is the vector's own.
    Vector,
}

impl ScalarKind {
    /// Whether the leaf is a floating-point scalar. A vector leaf is
    /// not, so the per-member floating-point gates skip it.
    pub(crate) fn is_fp_scalar(self) -> bool {
        matches!(
            self,
            ScalarKind::F32 | ScalarKind::F64 | ScalarKind::F80 | ScalarKind::F128
        )
    }
}

/// One flattened leaf field of an aggregate: its byte offset from
/// the aggregate's start, its byte width, and its scalar kind.
/// Produced by `Compiler::flatten_fields`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct FlatField {
    pub offset: u32,
    pub size: u32,
    pub kind: ScalarKind,
}

/// The register class a single eightbyte / member slot occupies.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum RegClass {
    /// An integer / general-purpose register.
    Integer,
    /// The low eight bytes of a floating-point (SSE / NEON) register.
    Sse,
    /// A whole 16-byte vector register: the System V SSE + SSEUP
    /// eightbyte pair (psABI 3.2.3) and the AAPCS64 Stage C.1 128-bit
    /// Short Vector (6.4.2) both occupy one register across their full
    /// width, so the slot is 16 bytes wide rather than 8.
    Vector,
}

impl RegClass {
    /// Bytes the slot transfers.
    pub(crate) fn width(self) -> u32 {
        match self {
            RegClass::Vector => 16,
            _ => 8,
        }
    }
}

/// How an aggregate is passed as an argument or produced as a
/// return value on the host ABI.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AggClass {
    /// Passed / returned in these register slots, in order. The
    /// k-th slot holds bytes `[8*k, 8*k+8)` (an HFA's slots hold
    /// the consecutive members). All-or-nothing for arguments: if
    /// too few registers remain, `plan_call_args` downgrades this
    /// to `ByStack`.
    Regs(alloc::vec::Vec<RegClass>),
    /// Argument passed by an implicit reference: the caller copies
    /// the aggregate to a temporary and passes its address in the
    /// next integer slot (AAPCS64 / Win64 over the by-value size).
    ByRef,
    /// Argument passed wholly on the outgoing-args stack
    /// (System V MEMORY class).
    ByStack,
    /// Return value produced through a hidden pointer the caller
    /// supplies (System V > 16 bytes, AAPCS64 via x8, Win64 over
    /// the by-value size).
    ReturnIndirect,
}

/// Width of the aggregate when it is one vector value and nothing
/// else -- a `vector_size` object, or a composite whose only leaf is
/// one. `None` otherwise, which sends the aggregate to the composite
/// rules.
fn sole_vector_width(size: u32, fields: &[FlatField]) -> Option<u32> {
    match fields {
        [f] if f.kind == ScalarKind::Vector && f.offset == 0 && f.size == size => Some(size),
        _ => None,
    }
}

/// Register class of a vector argument of `width` bytes, or `None` when
/// the width is not one the vector rules name. System V AMD64 psABI
/// 3.2.3 gives a 16-byte vector the SSE + SSEUP pair -- one whole vector
/// register -- and an 8-byte one (`__m64`) a single SSE eightbyte;
/// AAPCS64 6.4.2 Stage C.1 allocates a 64- or 128-bit Short Vector to
/// `v[NSRN]`. Both stop there: a narrower width is not a vector to
/// either, and a wider one exceeds the register, so both fall back to
/// the composite rules the size selects.
fn vector_reg_class(width: u32) -> Option<RegClass> {
    match width {
        16 => Some(RegClass::Vector),
        8 => Some(RegClass::Sse),
        _ => None,
    }
}

/// Whether the calling conventions have a vector rule at `width`. The
/// flattening keeps a vector of such a width whole; at any other width
/// neither ABI names a vector, so its lanes stand as the members they
/// are and the composite rules decide.
pub(crate) fn is_abi_vector_width(width: u32) -> bool {
    vector_reg_class(width).is_some()
}

/// Classify an aggregate of `size` bytes (with the given flattened
/// leaf `fields`) for `abi`. `is_return` picks the return-value
/// rules (indirect via hidden pointer) over the argument rules
/// (by-reference / by-stack).
pub(crate) fn classify_aggregate(
    size: u32,
    _align: u32,
    fields: &[FlatField],
    abi: Abi,
    is_return: bool,
) -> AggClass {
    if abi.arch == Arch::X86_64 {
        if abi.position_indexed_args {
            classify_win64(size, is_return)
        } else {
            classify_sysv(size, fields, is_return)
        }
    } else {
        // AAPCS64: Linux / macOS aarch64 and Windows aarch64, which
        // follows AAPCS64 aggregate rules.
        classify_aapcs64(size, fields, is_return)
    }
}

/// Win64 (x64): an aggregate whose size is exactly 1, 2, 4, or 8
/// bytes is passed / returned by value in a single GPR; every
/// other size goes by implicit reference (argument) or hidden
/// pointer (return).
fn classify_win64(size: u32, is_return: bool) -> AggClass {
    if matches!(size, 1 | 2 | 4 | 8) {
        AggClass::Regs(alloc::vec![RegClass::Integer])
    } else if is_return {
        AggClass::ReturnIndirect
    } else {
        AggClass::ByRef
    }
}

/// System V AMD64 (3.2.3): aggregates larger than 16 bytes (or with
/// an unaligned/straddling field, not represented here) are MEMORY
/// class. Otherwise the aggregate is split into one or two
/// eightbytes; an eightbyte is SSE iff every field overlapping it is
/// floating-point, else INTEGER.
fn classify_sysv(size: u32, fields: &[FlatField], is_return: bool) -> AggClass {
    if size == 0 {
        return AggClass::Regs(alloc::vec::Vec::new());
    }
    if let Some(c) = sole_vector_width(size, fields).and_then(vector_reg_class) {
        return AggClass::Regs(alloc::vec![c]);
    }
    // An eightbyte covering an x87 field is X87/X87UP, which sends the
    // whole aggregate to memory as an argument (3.2.3 rule 5). As a
    // return value gcc leaves a sole `long double` member in st(0).
    // TODO: extended-precision long double -- st(0) struct returns.
    if fields.iter().any(|f| f.kind == ScalarKind::F80) {
        return if is_return {
            AggClass::ReturnIndirect
        } else {
            AggClass::ByStack
        };
    }
    if size > 16 {
        return if is_return {
            AggClass::ReturnIndirect
        } else {
            AggClass::ByStack
        };
    }
    let n = size.div_ceil(8) as usize; // 1 or 2 eightbytes
    let mut classes = alloc::vec::Vec::with_capacity(n);
    for eb in 0..n {
        let lo = (eb as u32) * 8;
        let hi = lo + 8;
        let mut any = false;
        let mut all_fp = true;
        for f in fields {
            let f_lo = f.offset;
            let f_hi = f.offset + f.size;
            if f_lo < hi && f_hi > lo {
                any = true;
                if f.kind == ScalarKind::Int {
                    all_fp = false;
                }
            }
        }
        // A pure-padding eightbyte is conservatively INTEGER; in
        // practice every eightbyte of a real aggregate of this size
        // has at least one field.
        classes.push(if any && all_fp {
            RegClass::Sse
        } else {
            RegClass::Integer
        });
    }
    AggClass::Regs(classes)
}

/// AAPCS64 (6.4.2): a homogeneous floating-point aggregate (1..4
/// members all the same FP type, after flattening nested
/// aggregates / arrays) is passed / returned in consecutive FP
/// registers. Otherwise a composite of 16 bytes or less occupies
/// one or two GPRs; a larger one is passed by reference (argument)
/// or via the x8 indirect-result register (return).
fn classify_aapcs64(size: u32, fields: &[FlatField], is_return: bool) -> AggClass {
    if let Some(n) = hfa_member_count(fields) {
        return AggClass::Regs(alloc::vec![RegClass::Sse; n]);
    }
    if size == 0 {
        return AggClass::Regs(alloc::vec::Vec::new());
    }
    if let Some(c) = sole_vector_width(size, fields).and_then(vector_reg_class) {
        return AggClass::Regs(alloc::vec![c]);
    }
    if size <= 16 {
        let n = size.div_ceil(8) as usize; // 1 or 2 GPRs
        AggClass::Regs(alloc::vec![RegClass::Integer; n])
    } else if is_return {
        AggClass::ReturnIndirect
    } else {
        AggClass::ByRef
    }
}

/// Return `Some(n)` (1..=4) when the flattened fields form a
/// homogeneous floating-point aggregate: every leaf is the same FP
/// type (all `F32` or all `F64`) and there are between one and four
/// of them. `None` otherwise (any integer field, mixed precision,
/// empty, or more than four members).
fn hfa_member_count(fields: &[FlatField]) -> Option<usize> {
    if fields.is_empty() || fields.len() > 4 {
        return None;
    }
    let first = fields[0].kind;
    // TODO: extended-precision long double -- binary128 members form
    // HFAs (AAPCS64 6.4.2) once a 16-byte FP register slot exists.
    if !matches!(first, ScalarKind::F32 | ScalarKind::F64) {
        return None;
    }
    if fields.iter().all(|f| f.kind == first) {
        Some(fields.len())
    } else {
        None
    }
}

/// When `fields` form a homogeneous floating-point aggregate, return each
/// member's `(byte_offset, byte_size)` in declaration order; `None`
/// otherwise. The aarch64 emit places member `k` in `v[k]` for an HFA
/// argument or return (AAPCS64 6.4.2 / 6.8.2), so the layout drives the
/// per-member FP load / store.
pub(crate) fn hfa_member_layout(fields: &[FlatField]) -> Option<alloc::vec::Vec<(u32, u32)>> {
    hfa_member_count(fields)?;
    Some(fields.iter().map(|f| (f.offset, f.size)).collect())
}

/// `(byte_offset, byte_size)` of each SIMD register slot the aggregate
/// occupies, in register order: an HFA's members (AAPCS64 6.4.2) or the
/// single slot a Short Vector fills. `None` when the aggregate takes no
/// SIMD register. The aarch64 emit drives its per-slot load / store
/// width from this, so a 16-byte vector moves as one `q` access instead
/// of the HFA member's `d` or `s`.
pub(crate) fn fp_member_layout(
    size: u32,
    fields: &[FlatField],
) -> Option<alloc::vec::Vec<(u32, u32)>> {
    if let Some(layout) = hfa_member_layout(fields) {
        return Some(layout);
    }
    let width = sole_vector_width(size, fields)?;
    vector_reg_class(width)?;
    Some(alloc::vec![(0, width)])
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::codegen::Target;

    fn ff(offset: u32, size: u32, kind: ScalarKind) -> FlatField {
        FlatField { offset, size, kind }
    }

    fn sysv() -> Abi {
        Target::LinuxX64.abi()
    }
    fn aapcs() -> Abi {
        Target::LinuxAarch64.abi()
    }
    fn win64() -> Abi {
        Target::WindowsX64.abi()
    }

    // ---- System V ----

    #[test]
    fn sysv_two_ints_one_int_eightbyte() {
        // struct { int a, b; } -> 8 bytes, one INTEGER eightbyte.
        let f = [ff(0, 4, ScalarKind::Int), ff(4, 4, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(8, 4, &f, sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer])
        );
    }

    #[test]
    fn sysv_two_doubles_two_sse() {
        // struct { double x, y; } -> 16 bytes, two SSE eightbytes.
        let f = [ff(0, 8, ScalarKind::F64), ff(8, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(16, 8, &f, sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse, RegClass::Sse])
        );
    }

    #[test]
    fn sysv_mixed_double_then_int() {
        // struct { double d; int i; } -> 16 bytes: SSE, INTEGER.
        let f = [ff(0, 8, ScalarKind::F64), ff(8, 4, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(16, 8, &f, sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse, RegClass::Integer])
        );
    }

    #[test]
    fn sysv_int_and_float_in_first_eightbyte_is_integer() {
        // struct { int i; float f; } -> 8 bytes, one eightbyte
        // holding both an int and a float -> INTEGER.
        let f = [ff(0, 4, ScalarKind::Int), ff(4, 4, ScalarKind::F32)];
        assert_eq!(
            classify_aggregate(8, 4, &f, sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer])
        );
    }

    #[test]
    fn sysv_two_floats_one_sse_eightbyte() {
        // struct { float a, b; } -> 8 bytes, one SSE eightbyte.
        let f = [ff(0, 4, ScalarKind::F32), ff(4, 4, ScalarKind::F32)];
        assert_eq!(
            classify_aggregate(8, 4, &f, sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse])
        );
    }

    #[test]
    fn sysv_over_16_arg_is_stack_return_is_indirect() {
        let f = [
            ff(0, 8, ScalarKind::Int),
            ff(8, 8, ScalarKind::Int),
            ff(16, 8, ScalarKind::Int),
        ];
        assert_eq!(
            classify_aggregate(24, 8, &f, sysv(), false),
            AggClass::ByStack
        );
        assert_eq!(
            classify_aggregate(24, 8, &f, sysv(), true),
            AggClass::ReturnIndirect
        );
    }

    // ---- AAPCS64 ----

    #[test]
    fn aapcs_hfa_four_floats() {
        let f = [
            ff(0, 4, ScalarKind::F32),
            ff(4, 4, ScalarKind::F32),
            ff(8, 4, ScalarKind::F32),
            ff(12, 4, ScalarKind::F32),
        ];
        assert_eq!(
            classify_aggregate(16, 4, &f, aapcs(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse; 4])
        );
    }

    #[test]
    fn aapcs_hfa_two_doubles() {
        let f = [ff(0, 8, ScalarKind::F64), ff(8, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(16, 8, &f, aapcs(), true),
            AggClass::Regs(alloc::vec![RegClass::Sse, RegClass::Sse])
        );
    }

    #[test]
    fn aapcs_mixed_fp_not_hfa_uses_gprs() {
        // struct { float f; double d; } -> not homogeneous -> 16B
        // composite in two GPRs.
        let f = [ff(0, 4, ScalarKind::F32), ff(8, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(16, 8, &f, aapcs(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer, RegClass::Integer])
        );
    }

    #[test]
    fn aapcs_small_int_struct_one_gpr() {
        let f = [ff(0, 4, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(4, 4, &f, aapcs(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer])
        );
    }

    #[test]
    fn aapcs_over_16_arg_byref_return_indirect() {
        let f = [
            ff(0, 8, ScalarKind::Int),
            ff(8, 8, ScalarKind::Int),
            ff(16, 8, ScalarKind::Int),
        ];
        assert_eq!(
            classify_aggregate(24, 8, &f, aapcs(), false),
            AggClass::ByRef
        );
        assert_eq!(
            classify_aggregate(24, 8, &f, aapcs(), true),
            AggClass::ReturnIndirect
        );
    }

    #[test]
    fn aapcs_five_floats_not_hfa() {
        // 5 members exceeds the HFA limit of 4 -> 20B -> by ref / indirect.
        let f: alloc::vec::Vec<FlatField> = (0..5).map(|i| ff(i * 4, 4, ScalarKind::F32)).collect();
        assert_eq!(
            classify_aggregate(20, 4, &f, aapcs(), false),
            AggClass::ByRef
        );
    }

    // ---- vectors ----

    fn vec(size: u32) -> [FlatField; 1] {
        [ff(0, size, ScalarKind::Vector)]
    }

    #[test]
    fn sysv_vector16_is_one_whole_vector_register() {
        // psABI 3.2.3: SSE + SSEUP, one xmm across its full width.
        assert_eq!(
            classify_aggregate(16, 16, &vec(16), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Vector])
        );
        assert_eq!(
            classify_aggregate(16, 16, &vec(16), sysv(), true),
            AggClass::Regs(alloc::vec![RegClass::Vector])
        );
    }

    #[test]
    fn aapcs_vector16_is_one_whole_vector_register() {
        // AAPCS64 6.4.2 C.1: a 128-bit Short Vector in v[NSRN].
        assert_eq!(
            classify_aggregate(16, 16, &vec(16), aapcs(), false),
            AggClass::Regs(alloc::vec![RegClass::Vector])
        );
        assert_eq!(
            classify_aggregate(16, 16, &vec(16), aapcs(), true),
            AggClass::Regs(alloc::vec![RegClass::Vector])
        );
    }

    #[test]
    fn vector8_is_a_single_sse_eightbyte() {
        // The 64-bit form fits the low half of a vector register, which
        // is the plain SSE slot on both ABIs.
        for abi in [sysv(), aapcs()] {
            assert_eq!(
                classify_aggregate(8, 8, &vec(8), abi, false),
                AggClass::Regs(alloc::vec![RegClass::Sse])
            );
        }
    }

    #[test]
    fn only_named_widths_flatten_to_a_vector_leaf() {
        // The flattening keeps a vector whole exactly where a calling
        // convention has a rule for it. Below 64 bits neither does, so a
        // 4-byte vector reaches the classifier as its lanes and takes a
        // general-purpose register, where gcc places it; above 128 bits
        // neither does either, and the size rules send it to memory.
        assert!(is_abi_vector_width(16));
        assert!(is_abi_vector_width(8));
        assert!(!is_abi_vector_width(4));
        assert!(!is_abi_vector_width(32));
        let lanes: alloc::vec::Vec<FlatField> = (0..4).map(|i| ff(i, 1, ScalarKind::Int)).collect();
        for abi in [sysv(), aapcs()] {
            assert_eq!(
                classify_aggregate(4, 4, &lanes, abi, false),
                AggClass::Regs(alloc::vec![RegClass::Integer])
            );
        }
    }

    #[test]
    fn vector_wider_than_a_register_goes_to_memory() {
        // 32 bytes exceeds the register on both, so the lanes reach the
        // size rules: System V sends the value to memory (the psABI's ymm
        // form needs AVX), AAPCS64 passes the composite by reference.
        let lanes: alloc::vec::Vec<FlatField> =
            (0..32).map(|i| ff(i, 1, ScalarKind::Int)).collect();
        assert_eq!(
            classify_aggregate(32, 32, &lanes, sysv(), false),
            AggClass::ByStack
        );
        assert_eq!(
            classify_aggregate(32, 32, &lanes, aapcs(), false),
            AggClass::ByRef
        );
        for abi in [sysv(), aapcs()] {
            assert_eq!(
                classify_aggregate(32, 32, &lanes, abi, true),
                AggClass::ReturnIndirect
            );
        }
    }

    #[test]
    fn a_vector_member_makes_its_eightbyte_sse() {
        // System V classes the eightbyte a 64-bit vector occupies SSE and
        // the one holding the trailing `int` INTEGER, in either order --
        // gcc delivers `struct { u8x8 v; int i; }` in xmm0 and rdi.
        let f = [ff(0, 8, ScalarKind::Vector), ff(8, 4, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(16, 8, &f, sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse, RegClass::Integer])
        );
        let g = [ff(0, 4, ScalarKind::Int), ff(8, 8, ScalarKind::Vector)];
        assert_eq!(
            classify_aggregate(16, 8, &g, sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer, RegClass::Sse])
        );
        // Two of them are two SSE eightbytes.
        let h = [ff(0, 8, ScalarKind::Vector), ff(8, 8, ScalarKind::Vector)];
        assert_eq!(
            classify_aggregate(16, 8, &h, sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse, RegClass::Sse])
        );
        // AAPCS64 has no homogeneous vector aggregate yet: the composite
        // rules give the same layout two general-purpose registers.
        // TODO: homogeneous vector aggregates.
        assert_eq!(
            classify_aggregate(16, 8, &h, aapcs(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer, RegClass::Integer])
        );
    }

    #[test]
    fn vector_with_another_member_is_a_plain_composite() {
        // `struct { u8x16 v; int i; }` is 32 bytes and not one vector, so
        // the composite rules apply.
        let f = [ff(0, 16, ScalarKind::Vector), ff(16, 4, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(32, 16, &f, sysv(), false),
            AggClass::ByStack
        );
        assert_eq!(
            classify_aggregate(32, 16, &f, aapcs(), false),
            AggClass::ByRef
        );
    }

    #[test]
    fn vector16_by_reference_on_win64() {
        // Win64 passes a 16-byte value by an implicit reference whatever
        // its type; only 1, 2, 4 and 8 bytes ride a register.
        assert_eq!(
            classify_aggregate(16, 16, &vec(16), win64(), false),
            AggClass::ByRef
        );
        assert_eq!(
            classify_aggregate(16, 16, &vec(16), win64(), true),
            AggClass::ReturnIndirect
        );
        assert_eq!(
            classify_aggregate(8, 8, &vec(8), win64(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer])
        );
    }

    #[test]
    fn vector_is_not_an_hfa() {
        // A vector leaf is not a floating-point member, so it cannot form
        // a homogeneous floating-point aggregate.
        assert_eq!(hfa_member_layout(&vec(16)), None);
        // The SIMD-slot layout covers it instead, as one whole slot.
        assert_eq!(fp_member_layout(16, &vec(16)), Some(alloc::vec![(0, 16)]));
        assert_eq!(fp_member_layout(8, &vec(8)), Some(alloc::vec![(0, 8)]));
        assert_eq!(fp_member_layout(4, &vec(4)), None);
        // An HFA still reports its members.
        let f = [ff(0, 8, ScalarKind::F64), ff(8, 8, ScalarKind::F64)];
        assert_eq!(fp_member_layout(16, &f), Some(alloc::vec![(0, 8), (8, 8)]));
    }

    #[test]
    fn vector_slot_is_sixteen_bytes_wide() {
        assert_eq!(RegClass::Vector.width(), 16);
        assert_eq!(RegClass::Sse.width(), 8);
        assert_eq!(RegClass::Integer.width(), 8);
    }

    // ---- Win64 ----

    #[test]
    fn win64_size8_in_one_gpr() {
        let f = [ff(0, 4, ScalarKind::Int), ff(4, 4, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(8, 4, &f, win64(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer])
        );
    }

    #[test]
    fn win64_double_pair_still_one_gpr_or_indirect() {
        // Win64 has no HFA: a 16-byte struct goes by reference
        // (argument) / hidden pointer (return) even if all-FP.
        let f = [ff(0, 8, ScalarKind::F64), ff(8, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(16, 8, &f, win64(), false),
            AggClass::ByRef
        );
        assert_eq!(
            classify_aggregate(16, 8, &f, win64(), true),
            AggClass::ReturnIndirect
        );
    }

    #[test]
    fn win64_size3_by_ref() {
        let f = [ff(0, 1, ScalarKind::Int), ff(1, 2, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(3, 1, &f, win64(), false),
            AggClass::ByRef
        );
    }
}

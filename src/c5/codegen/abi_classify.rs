//! Host-ABI classification of aggregate (struct / union) values for
//! the platform calling conventions (System V AMD64, Win64,
//! AAPCS64). Given an aggregate's size and the byte ranges + scalar
//! kinds of its leaf fields, decide whether it is passed / returned
//! in registers (and which class each register slot is), by an
//! implicit reference, on the stack, or via a hidden return pointer.
//!
//! The classifier is pure and target-driven through [`Abi`]; the
//! register-bank-exhaustion decision (an aggregate that wants
//! registers but finds too few left) is made later in
//! `plan_call_args`, which is the only place that tracks remaining
//! registers. This module only encodes the size / field-class rules.

use super::{Abi, Arch};

/// Leaf scalar kind, after flattening nested structs / arrays /
/// bitfields. Width is carried separately in [`FlatField`].
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum ScalarKind {
    Int,
    F32,
    F64,
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
    /// A floating-point (SSE / NEON) register.
    Sse,
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
    if first == ScalarKind::Int {
        return None;
    }
    if fields.iter().all(|f| f.kind == first) {
        Some(fields.len())
    } else {
        None
    }
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

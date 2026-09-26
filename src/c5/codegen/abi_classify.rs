//! Host-ABI classification of aggregate (struct / union / vector)
//! values for the platform calling conventions (System V AMD64, Win64,
//! AAPCS64). Given an aggregate's [`AggDesc`] -- its size, the byte
//! ranges + leaf kinds of its fields and its AAPCS64 homogeneous
//! aggregate -- decide whether it is passed / returned
//! in registers (and which class each register slot is), by an
//! implicit reference, on the stack, or via a hidden return pointer.
//!
//! The classifier is pure and target-driven through [`Abi`]; the
//! register-bank-exhaustion decision (an aggregate that wants
//! registers but finds too few left) is made later in
//! `plan_call_args`, which is the only place that tracks remaining
//! registers. This module only encodes the size / field-class rules.

use super::{Abi, Arch};
use crate::c5::ir::AggDesc;

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

/// A homogeneous floating-point aggregate (AAPCS64 5.9.5): one to four
/// elements of one floating-point type, element `k` at `k * width`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct Hfa {
    kind: ScalarKind,
    count: u8,
}

impl Hfa {
    /// Element width of an HFA base type, `None` for any other kind.
    pub(crate) fn base_width(kind: ScalarKind) -> Option<u32> {
        match kind {
            ScalarKind::F32 => Some(4),
            ScalarKind::F64 => Some(8),
            ScalarKind::F128 => Some(16),
            _ => None,
        }
    }

    pub(crate) fn new(kind: ScalarKind, count: u32) -> Option<Self> {
        Self::base_width(kind)?;
        let count = u8::try_from(count).ok().filter(|n| (1..=4).contains(n))?;
        Some(Self { kind, count })
    }

    pub(crate) fn count(self) -> usize {
        usize::from(self.count)
    }

    /// `(byte_offset, byte_size)` of each element, in register order.
    pub(crate) fn members(self) -> alloc::vec::Vec<(u32, u32)> {
        let width = Self::base_width(self.kind).expect("`new` admits only a base type");
        (0..u32::from(self.count))
            .map(|k| (k * width, width))
            .collect()
    }

    fn reg_class(self) -> RegClass {
        if self.kind == ScalarKind::F128 {
            RegClass::Vector
        } else {
            RegClass::Sse
        }
    }
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
    /// The top of the x87 register stack, `st(0)`: System V AMD64 3.2.3
    /// returns an X87 + X87UP pair there, a sole `long double`. No argument
    /// takes it.
    X87,
    /// A System V eightbyte no field overlaps (3.2.3 NO_CLASS): it takes no
    /// register, and the slots after it keep their offsets.
    NoClass,
}

impl RegClass {
    /// Bytes the slot transfers.
    pub(crate) fn width(self) -> u32 {
        match self {
            RegClass::Vector | RegClass::X87 => 16,
            _ => 8,
        }
    }
}

/// The System V slots of `classes` that take a register, in register order,
/// each with the offset of the bytes it carries: the slots tile the
/// aggregate from offset 0, `width()` bytes apiece.
pub(crate) fn register_slots(classes: &[RegClass]) -> impl Iterator<Item = (RegClass, u32)> + '_ {
    classes
        .iter()
        .scan(0u32, |off, &class| {
            let at = *off;
            *off += class.width();
            Some((class, at))
        })
        .filter(|&(class, _)| class != RegClass::NoClass)
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

pub(crate) fn arg_align(align: u32, member_align: u32, abi: Abi) -> u32 {
    if abi.natural_composite_align {
        member_align
    } else {
        align
    }
}

/// Classify the aggregate `desc` lays out for `abi`. `is_return` picks
/// the return-value rules (indirect via hidden pointer) over the
/// argument rules (by-reference / by-stack).
pub(crate) fn classify_aggregate(desc: &AggDesc, abi: Abi, is_return: bool) -> AggClass {
    if abi.arch == Arch::X86_64 {
        if abi.position_indexed_args {
            classify_win64(desc.size, is_return)
        } else {
            classify_sysv(desc.size, &desc.fields, is_return)
        }
    } else {
        // AAPCS64: Linux / macOS aarch64 and Windows aarch64, which
        // follows AAPCS64 aggregate rules.
        classify_aapcs64(desc, is_return)
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

/// System V AMD64 (3.2.3): aggregates larger than 16 bytes are MEMORY
/// class. Otherwise each of the one or two eightbytes starts NO_CLASS and
/// merges the classes of the fields overlapping it, the high half of a
/// 16-byte vector being SSEUP. SSE followed by SSEUP is one vector
/// register, and an eightbyte left NO_CLASS takes none.
/// TODO: an aggregate with a misaligned field is MEMORY class (rule 1).
fn classify_sysv(size: u32, fields: &[FlatField], is_return: bool) -> AggClass {
    if size == 0 {
        return AggClass::Regs(alloc::vec::Vec::new());
    }
    // An eightbyte covering an x87 field is X87/X87UP, which sends the
    // whole aggregate to memory as an argument (3.2.3 rule 5). A return
    // value that is one X87 + X87UP pair comes back in st(0); an x87 field
    // sharing an eightbyte merges to MEMORY.
    if fields.iter().any(|f| f.kind == ScalarKind::F80) {
        return match fields {
            [f] if is_return && f.offset == 0 && size == 16 => {
                AggClass::Regs(alloc::vec![RegClass::X87])
            }
            _ if is_return => AggClass::ReturnIndirect,
            _ => AggClass::ByStack,
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
    let mut eightbytes = [Eightbyte::NoClass; 2];
    for f in fields {
        for (k, eb) in eightbytes.iter_mut().enumerate().take(n) {
            let lo = 8 * k as u32;
            if f.offset >= lo + 8 || f.offset + f.size <= lo {
                continue;
            }
            let class = match f.kind {
                ScalarKind::Int => Eightbyte::Integer,
                // The high half of a 16-byte vector.
                ScalarKind::Vector | ScalarKind::F128 if lo > f.offset => Eightbyte::SseUp,
                _ => Eightbyte::Sse,
            };
            *eb = eb.merge(class);
        }
    }
    let mut classes = alloc::vec::Vec::with_capacity(n);
    let mut k = 0;
    while k < n {
        classes.push(match eightbytes[k] {
            Eightbyte::Integer => RegClass::Integer,
            Eightbyte::NoClass => RegClass::NoClass,
            Eightbyte::Sse if eightbytes.get(k + 1) == Some(&Eightbyte::SseUp) => {
                k += 1;
                RegClass::Vector
            }
            // Rule 5: SSEUP after anything but SSE is SSE.
            Eightbyte::Sse | Eightbyte::SseUp => RegClass::Sse,
        });
        k += 1;
    }
    while classes.last() == Some(&RegClass::NoClass) {
        classes.pop();
    }
    AggClass::Regs(classes)
}

/// A System V eightbyte's class while the fields overlapping it merge.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Eightbyte {
    NoClass,
    Integer,
    Sse,
    SseUp,
}

impl Eightbyte {
    /// 3.2.3 rule 4: equal classes stay, NO_CLASS yields to the other,
    /// INTEGER takes precedence, and any other pair is SSE.
    fn merge(self, other: Self) -> Self {
        match (self, other) {
            (a, b) if a == b => a,
            (Eightbyte::NoClass, c) | (c, Eightbyte::NoClass) => c,
            (Eightbyte::Integer, _) | (_, Eightbyte::Integer) => Eightbyte::Integer,
            _ => Eightbyte::Sse,
        }
    }
}

/// AAPCS64 (6.8.2): a homogeneous floating-point aggregate is passed /
/// returned in consecutive SIMD registers, one per element. Otherwise
/// a composite of 16 bytes or less occupies one or two GPRs; a larger
/// one is passed by reference (argument) or via the x8 indirect-result
/// register (return).
fn classify_aapcs64(desc: &AggDesc, is_return: bool) -> AggClass {
    if let Some(hfa) = desc.hfa {
        return AggClass::Regs(alloc::vec![hfa.reg_class(); hfa.count()]);
    }
    let size = desc.size;
    if size == 0 {
        return AggClass::Regs(alloc::vec::Vec::new());
    }
    if let Some(c) = sole_vector_width(size, &desc.fields).and_then(vector_reg_class) {
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

/// `(byte_offset, byte_size)` of each SIMD register slot the aggregate
/// occupies, in register order: an HFA's elements (AAPCS64 6.8.2) or
/// the single slot a Short Vector fills. `None` when the aggregate takes
/// no SIMD register. The aarch64 emit drives its per-slot load / store
/// width from this, so a 16-byte vector moves as one `q` access instead
/// of the HFA element's `d` or `s`.
pub(crate) fn fp_member_layout(desc: &AggDesc) -> Option<alloc::vec::Vec<(u32, u32)>> {
    if let Some(hfa) = desc.hfa {
        return Some(hfa.members());
    }
    let width = sole_vector_width(desc.size, &desc.fields)?;
    vector_reg_class(width)?;
    Some(alloc::vec![(0, width)])
}

/// One register of an aggregate passed or returned in registers: its
/// class, the bytes of the aggregate it carries, and the flattened
/// fields lying wholly inside them.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct RegPart {
    pub class: RegClass,
    pub offset: u32,
    pub width: u32,
    pub fields: alloc::vec::Vec<FlatField>,
}

/// The register parts of the aggregate `desc` lays out, passed
/// (`is_return` false) or returned in registers under `abi`, in register
/// order: an HFA's elements, else the eightbytes with their classes.
/// `None` when it takes no register, and for a vector register, whose
/// lanes no scalar access names.
pub(crate) fn register_parts(
    desc: &AggDesc,
    abi: Abi,
    is_return: bool,
) -> Option<alloc::vec::Vec<RegPart>> {
    let AggClass::Regs(classes) = classify_aggregate(desc, abi, is_return) else {
        return None;
    };
    if classes.is_empty() || classes.contains(&RegClass::Vector) || classes.contains(&RegClass::X87)
    {
        return None;
    }
    let (size, fields) = (desc.size, &desc.fields);
    let layout: alloc::vec::Vec<(u32, u32, RegClass)> = match desc.hfa {
        Some(hfa) if abi.arch != Arch::X86_64 => hfa
            .members()
            .into_iter()
            .map(|(off, msize)| (off, msize, RegClass::Sse))
            .collect(),
        _ => register_slots(&classes)
            .map(|(class, off)| (off, (size - off).min(8), class))
            .collect(),
    };
    Some(
        layout
            .into_iter()
            .map(|(offset, width, class)| RegPart {
                class,
                offset,
                width,
                fields: fields
                    .iter()
                    .filter(|f| f.offset >= offset && f.offset + f.size <= offset + width)
                    .copied()
                    .collect(),
            })
            .collect(),
    )
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::codegen::Target;

    fn ff(offset: u32, size: u32, kind: ScalarKind) -> FlatField {
        FlatField { offset, size, kind }
    }

    /// An aggregate of `size` bytes with `fields` that is no HFA.
    fn desc(size: u32, fields: &[FlatField]) -> AggDesc {
        AggDesc {
            size,
            align: 8,
            member_align: 8,
            fields: fields.to_vec(),
            hfa: None,
        }
    }

    /// [`desc`] for an HFA of `count` elements of `kind`.
    fn hfa(size: u32, fields: &[FlatField], kind: ScalarKind, count: u32) -> AggDesc {
        AggDesc {
            hfa: Some(Hfa::new(kind, count).expect("an HFA")),
            ..desc(size, fields)
        }
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
            classify_aggregate(&desc(8, &f), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer])
        );
    }

    #[test]
    fn sysv_two_doubles_two_sse() {
        // struct { double x, y; } -> 16 bytes, two SSE eightbytes.
        let f = [ff(0, 8, ScalarKind::F64), ff(8, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(&desc(16, &f), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse, RegClass::Sse])
        );
    }

    #[test]
    fn sysv_mixed_double_then_int() {
        // struct { double d; int i; } -> 16 bytes: SSE, INTEGER.
        let f = [ff(0, 8, ScalarKind::F64), ff(8, 4, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(&desc(16, &f), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse, RegClass::Integer])
        );
    }

    #[test]
    fn sysv_int_and_float_in_first_eightbyte_is_integer() {
        // struct { int i; float f; } -> 8 bytes, one eightbyte
        // holding both an int and a float -> INTEGER.
        let f = [ff(0, 4, ScalarKind::Int), ff(4, 4, ScalarKind::F32)];
        assert_eq!(
            classify_aggregate(&desc(8, &f), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer])
        );
    }

    #[test]
    fn sysv_two_floats_one_sse_eightbyte() {
        // struct { float a, b; } -> 8 bytes, one SSE eightbyte.
        let f = [ff(0, 4, ScalarKind::F32), ff(4, 4, ScalarKind::F32)];
        assert_eq!(
            classify_aggregate(&desc(8, &f), sysv(), false),
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
            classify_aggregate(&desc(24, &f), sysv(), false),
            AggClass::ByStack
        );
        assert_eq!(
            classify_aggregate(&desc(24, &f), sysv(), true),
            AggClass::ReturnIndirect
        );
    }

    /// An eightbyte no field overlaps is NO_CLASS and takes no register:
    /// `struct __attribute__((aligned(16))) { double d; }` is one SSE
    /// register, and a NO_CLASS eightbyte ahead of a field keeps the field's
    /// offset.
    #[test]
    fn sysv_padding_eightbyte_takes_no_register() {
        for (kind, class) in [
            (ScalarKind::F64, RegClass::Sse),
            (ScalarKind::Int, RegClass::Integer),
        ] {
            for is_return in [false, true] {
                assert_eq!(
                    classify_aggregate(&desc(16, &[ff(0, 8, kind)]), sysv(), is_return),
                    AggClass::Regs(alloc::vec![class])
                );
            }
        }
        let high = [ff(8, 8, ScalarKind::F64)];
        let AggClass::Regs(classes) = classify_aggregate(&desc(16, &high), sysv(), false) else {
            panic!("in registers")
        };
        assert_eq!(classes, [RegClass::NoClass, RegClass::Sse]);
        assert_eq!(
            register_slots(&classes).collect::<alloc::vec::Vec<_>>(),
            [(RegClass::Sse, 8)]
        );
        let parts = register_parts(&desc(16, &high), sysv(), true).expect("one register");
        assert_eq!(
            parts
                .iter()
                .map(|p| (p.class, p.offset, p.fields.len()))
                .collect::<alloc::vec::Vec<_>>(),
            [(RegClass::Sse, 8, 1)]
        );
    }

    /// The overlapping members of a union merge per eightbyte: two doubles
    /// are one SSE eightbyte, a 16-byte vector beside a double one whole
    /// vector register (SSE + SSEUP), four floats beside the vector two SSE
    /// eightbytes, and an integer member makes its eightbyte INTEGER.
    #[test]
    fn sysv_union_members_merge_per_eightbyte() {
        let two_doubles = [ff(0, 8, ScalarKind::F64), ff(0, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(&desc(8, &two_doubles), sysv(), true),
            AggClass::Regs(alloc::vec![RegClass::Sse])
        );
        let vector_double = [ff(0, 16, ScalarKind::Vector), ff(0, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(&desc(16, &vector_double), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Vector])
        );
        let mut floats_vector: alloc::vec::Vec<FlatField> =
            (0..4).map(|i| ff(4 * i, 4, ScalarKind::F32)).collect();
        floats_vector.push(ff(0, 16, ScalarKind::Vector));
        assert_eq!(
            classify_aggregate(&desc(16, &floats_vector), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse, RegClass::Sse])
        );
        let double_long = [ff(0, 8, ScalarKind::F64), ff(0, 8, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(&desc(8, &double_long), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer])
        );
    }

    #[test]
    fn sysv_long_double_is_memory_as_argument_and_st0_as_return() {
        // `long double`, bare or as a struct's only member: X87 + X87UP.
        let f = [ff(0, 16, ScalarKind::F80)];
        assert_eq!(
            classify_aggregate(&desc(16, &f), sysv(), false),
            AggClass::ByStack
        );
        assert_eq!(
            classify_aggregate(&desc(16, &f), sysv(), true),
            AggClass::Regs(alloc::vec![RegClass::X87])
        );
        // A union with a `double`: the eightbyte merges X87 and SSE to
        // MEMORY, returned through the hidden pointer.
        let u = [ff(0, 16, ScalarKind::F80), ff(0, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(&desc(16, &u), sysv(), true),
            AggClass::ReturnIndirect
        );
        // Two members exceed two eightbytes with no SSE first: MEMORY.
        let two = [ff(0, 16, ScalarKind::F80), ff(16, 16, ScalarKind::F80)];
        assert_eq!(
            classify_aggregate(&desc(32, &two), sysv(), true),
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
            classify_aggregate(&hfa(16, &f, ScalarKind::F32, 4), aapcs(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse; 4])
        );
    }

    #[test]
    fn aapcs_hfa_two_doubles() {
        let f = [ff(0, 8, ScalarKind::F64), ff(8, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(&hfa(16, &f, ScalarKind::F64, 2), aapcs(), true),
            AggClass::Regs(alloc::vec![RegClass::Sse, RegClass::Sse])
        );
    }

    /// The registers follow the HFA's elements, not its leaves: the two
    /// members of `union { double a, b; }` overlap in one element.
    #[test]
    fn aapcs_union_hfa_takes_a_register_per_element() {
        let f = [ff(0, 8, ScalarKind::F64), ff(0, 8, ScalarKind::F64)];
        let u = hfa(8, &f, ScalarKind::F64, 1);
        for is_return in [false, true] {
            assert_eq!(
                classify_aggregate(&u, aapcs(), is_return),
                AggClass::Regs(alloc::vec![RegClass::Sse])
            );
        }
        assert_eq!(fp_member_layout(&u), Some(alloc::vec![(0, 8)]));
        let parts = register_parts(&u, aapcs(), true).expect("one register");
        assert_eq!(
            parts
                .iter()
                .map(|p| (p.class, p.offset, p.width, p.fields.len()))
                .collect::<alloc::vec::Vec<_>>(),
            [(RegClass::Sse, 0, 8, 2)]
        );
    }

    #[test]
    fn aapcs_long_double_hfa_takes_whole_vector_registers() {
        // `long double`, bare or as a struct's only member: one quad.
        let one = [ff(0, 16, ScalarKind::F128)];
        assert_eq!(
            classify_aggregate(&hfa(16, &one, ScalarKind::F128, 1), aapcs(), false),
            AggClass::Regs(alloc::vec![RegClass::Vector])
        );
        let four = [
            ff(0, 16, ScalarKind::F128),
            ff(16, 16, ScalarKind::F128),
            ff(32, 16, ScalarKind::F128),
            ff(48, 16, ScalarKind::F128),
        ];
        assert_eq!(
            classify_aggregate(&hfa(64, &four, ScalarKind::F128, 4), aapcs(), true),
            AggClass::Regs(alloc::vec![RegClass::Vector; 4])
        );
        // Beside a `double` it is no HFA: the 32-byte composite goes by
        // reference.
        let mixed = [ff(0, 16, ScalarKind::F128), ff(16, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(&desc(32, &mixed), aapcs(), false),
            AggClass::ByRef
        );
    }

    #[test]
    fn aapcs_mixed_fp_not_hfa_uses_gprs() {
        // struct { float f; double d; } -> not homogeneous -> 16B
        // composite in two GPRs.
        let f = [ff(0, 4, ScalarKind::F32), ff(8, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(&desc(16, &f), aapcs(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer, RegClass::Integer])
        );
    }

    #[test]
    fn aapcs_small_int_struct_one_gpr() {
        let f = [ff(0, 4, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(&desc(4, &f), aapcs(), false),
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
            classify_aggregate(&desc(24, &f), aapcs(), false),
            AggClass::ByRef
        );
        assert_eq!(
            classify_aggregate(&desc(24, &f), aapcs(), true),
            AggClass::ReturnIndirect
        );
    }

    #[test]
    fn aapcs_five_floats_not_hfa() {
        // 5 members exceeds the HFA limit of 4 -> 20B -> by ref / indirect.
        assert_eq!(Hfa::new(ScalarKind::F32, 5), None);
        assert_eq!(Hfa::new(ScalarKind::F64, 0), None);
        let f: alloc::vec::Vec<FlatField> = (0..5).map(|i| ff(i * 4, 4, ScalarKind::F32)).collect();
        assert_eq!(
            classify_aggregate(&desc(20, &f), aapcs(), false),
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
            classify_aggregate(&desc(16, &vec(16)), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Vector])
        );
        assert_eq!(
            classify_aggregate(&desc(16, &vec(16)), sysv(), true),
            AggClass::Regs(alloc::vec![RegClass::Vector])
        );
    }

    #[test]
    fn aapcs_vector16_is_one_whole_vector_register() {
        // AAPCS64 6.4.2 C.1: a 128-bit Short Vector in v[NSRN].
        assert_eq!(
            classify_aggregate(&desc(16, &vec(16)), aapcs(), false),
            AggClass::Regs(alloc::vec![RegClass::Vector])
        );
        assert_eq!(
            classify_aggregate(&desc(16, &vec(16)), aapcs(), true),
            AggClass::Regs(alloc::vec![RegClass::Vector])
        );
    }

    #[test]
    fn vector8_is_a_single_sse_eightbyte() {
        // The 64-bit form fits the low half of a vector register, which
        // is the plain SSE slot on both ABIs.
        for abi in [sysv(), aapcs()] {
            assert_eq!(
                classify_aggregate(&desc(8, &vec(8)), abi, false),
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
                classify_aggregate(&desc(4, &lanes), abi, false),
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
            classify_aggregate(&desc(32, &lanes), sysv(), false),
            AggClass::ByStack
        );
        assert_eq!(
            classify_aggregate(&desc(32, &lanes), aapcs(), false),
            AggClass::ByRef
        );
        for abi in [sysv(), aapcs()] {
            assert_eq!(
                classify_aggregate(&desc(32, &lanes), abi, true),
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
            classify_aggregate(&desc(16, &f), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse, RegClass::Integer])
        );
        let g = [ff(0, 4, ScalarKind::Int), ff(8, 8, ScalarKind::Vector)];
        assert_eq!(
            classify_aggregate(&desc(16, &g), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer, RegClass::Sse])
        );
        // Two of them are two SSE eightbytes.
        let h = [ff(0, 8, ScalarKind::Vector), ff(8, 8, ScalarKind::Vector)];
        assert_eq!(
            classify_aggregate(&desc(16, &h), sysv(), false),
            AggClass::Regs(alloc::vec![RegClass::Sse, RegClass::Sse])
        );
        // AAPCS64 has no homogeneous vector aggregate yet: the composite
        // rules give the same layout two general-purpose registers.
        // TODO: homogeneous vector aggregates.
        assert_eq!(
            classify_aggregate(&desc(16, &h), aapcs(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer, RegClass::Integer])
        );
    }

    #[test]
    fn vector_with_another_member_is_a_plain_composite() {
        // `struct { u8x16 v; int i; }` is 32 bytes and not one vector, so
        // the composite rules apply.
        let f = [ff(0, 16, ScalarKind::Vector), ff(16, 4, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(&desc(32, &f), sysv(), false),
            AggClass::ByStack
        );
        assert_eq!(
            classify_aggregate(&desc(32, &f), aapcs(), false),
            AggClass::ByRef
        );
    }

    #[test]
    fn vector16_by_reference_on_win64() {
        // Win64 passes a 16-byte value by an implicit reference whatever
        // its type; only 1, 2, 4 and 8 bytes ride a register.
        assert_eq!(
            classify_aggregate(&desc(16, &vec(16)), win64(), false),
            AggClass::ByRef
        );
        assert_eq!(
            classify_aggregate(&desc(16, &vec(16)), win64(), true),
            AggClass::ReturnIndirect
        );
        assert_eq!(
            classify_aggregate(&desc(8, &vec(8)), win64(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer])
        );
    }

    #[test]
    fn vector_is_not_an_hfa() {
        // A vector leaf is not a floating-point member, so it cannot form
        // a homogeneous floating-point aggregate.
        assert_eq!(Hfa::new(ScalarKind::Vector, 1), None);
        // The SIMD-slot layout covers it instead, as one whole slot.
        assert_eq!(
            fp_member_layout(&desc(16, &vec(16))),
            Some(alloc::vec![(0, 16)])
        );
        assert_eq!(
            fp_member_layout(&desc(8, &vec(8))),
            Some(alloc::vec![(0, 8)])
        );
        assert_eq!(fp_member_layout(&desc(4, &vec(4))), None);
        // An HFA still reports its members.
        let f = [ff(0, 8, ScalarKind::F64), ff(8, 8, ScalarKind::F64)];
        assert_eq!(
            fp_member_layout(&hfa(16, &f, ScalarKind::F64, 2)),
            Some(alloc::vec![(0, 8), (8, 8)])
        );
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
            classify_aggregate(&desc(8, &f), win64(), false),
            AggClass::Regs(alloc::vec![RegClass::Integer])
        );
    }

    #[test]
    fn win64_double_pair_still_one_gpr_or_indirect() {
        // Win64 has no HFA: a 16-byte struct goes by reference
        // (argument) / hidden pointer (return) even if all-FP.
        let f = [ff(0, 8, ScalarKind::F64), ff(8, 8, ScalarKind::F64)];
        assert_eq!(
            classify_aggregate(&desc(16, &f), win64(), false),
            AggClass::ByRef
        );
        assert_eq!(
            classify_aggregate(&desc(16, &f), win64(), true),
            AggClass::ReturnIndirect
        );
    }

    #[test]
    fn win64_size3_by_ref() {
        let f = [ff(0, 1, ScalarKind::Int), ff(1, 2, ScalarKind::Int)];
        assert_eq!(
            classify_aggregate(&desc(3, &f), win64(), false),
            AggClass::ByRef
        );
    }

    /// The parts of a `struct { long a, b; }` on either ABI are its two
    /// eightbytes, an HFA's its members on AAPCS64 and its SSE eightbytes
    /// on System V, a 12-byte aggregate's tail is a 4-byte part, a
    /// one-eightbyte aggregate holds both of its `int`s in one part, and a
    /// vector or a memory-class aggregate has none.
    #[test]
    fn register_parts_follow_the_class_layout() {
        let two_longs = [ff(0, 8, ScalarKind::Int), ff(8, 8, ScalarKind::Int)];
        for abi in [sysv(), aapcs()] {
            let parts = register_parts(&desc(16, &two_longs), abi, false).expect("in registers");
            assert_eq!(
                parts
                    .iter()
                    .map(|p| (p.class, p.offset, p.width, p.fields.len()))
                    .collect::<alloc::vec::Vec<_>>(),
                [(RegClass::Integer, 0, 8, 1), (RegClass::Integer, 8, 8, 1)]
            );
        }
        let two_doubles = [ff(0, 8, ScalarKind::F64), ff(8, 8, ScalarKind::F64)];
        for (d, abi) in [
            (desc(16, &two_doubles), sysv()),
            (hfa(16, &two_doubles, ScalarKind::F64, 2), aapcs()),
        ] {
            let parts = register_parts(&d, abi, true).expect("in registers");
            assert!(
                parts
                    .iter()
                    .all(|p| p.class == RegClass::Sse && p.fields.len() == 1)
            );
        }
        let three_floats = [
            ff(0, 4, ScalarKind::F32),
            ff(4, 4, ScalarKind::F32),
            ff(8, 4, ScalarKind::F32),
        ];
        let parts = register_parts(&hfa(12, &three_floats, ScalarKind::F32, 3), aapcs(), false)
            .expect("an HFA");
        assert_eq!(
            parts
                .iter()
                .map(|p| (p.offset, p.width))
                .collect::<alloc::vec::Vec<_>>(),
            [(0, 4), (4, 4), (8, 4)]
        );
        let sse =
            register_parts(&desc(12, &three_floats), sysv(), false).expect("two SSE eightbytes");
        assert_eq!(
            sse.iter()
                .map(|p| (p.class, p.offset, p.width, p.fields.len()))
                .collect::<alloc::vec::Vec<_>>(),
            [(RegClass::Sse, 0, 8, 2), (RegClass::Sse, 8, 4, 1)]
        );
        let long_int = [ff(0, 8, ScalarKind::Int), ff(8, 4, ScalarKind::Int)];
        let parts = register_parts(&desc(12, &long_int), sysv(), false).expect("in registers");
        assert_eq!(
            (parts[1].offset, parts[1].width, parts[1].fields.len()),
            (8, 4, 1)
        );
        let two_ints = [ff(0, 4, ScalarKind::Int), ff(4, 4, ScalarKind::Int)];
        for abi in [sysv(), aapcs(), win64()] {
            let parts = register_parts(&desc(8, &two_ints), abi, false).expect("one register");
            assert_eq!((parts.len(), parts[0].fields.len()), (1, 2));
        }
        assert!(
            register_parts(&desc(16, &[ff(0, 16, ScalarKind::Vector)]), sysv(), false).is_none()
        );
        let big = [
            ff(0, 8, ScalarKind::Int),
            ff(8, 8, ScalarKind::Int),
            ff(16, 8, ScalarKind::Int),
        ];
        assert!(register_parts(&desc(24, &big), sysv(), false).is_none());
        assert!(register_parts(&desc(24, &big), aapcs(), true).is_none());
        assert!(register_parts(&desc(12, &long_int), win64(), false).is_none());
    }
}

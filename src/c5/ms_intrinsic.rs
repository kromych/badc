//! The intrinsics lowered at the call site, whatever declares them: the MSVC
//! ones on the PE targets, as MSVC and clang for a windows-msvc triple do,
//! and gcc's and clang's x86 system-instruction builtins on every x86-64
//! target. Each is a name's signature, which the parser converts to, and the
//! operation it performs.

use alloc::vec::Vec;

use crate::c5::ast::AtomicKind;
use crate::c5::codegen::Target;
use crate::c5::ir::MemOrder;

/// A scalar at its LLP64 width: `__int8` is `char`, `__int64` `long long`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Scalar {
    Char,
    UChar,
    Short,
    UShort,
    Int,
    UInt,
    Long,
    ULong,
    LLong,
    ULLong,
    VoidPtr,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Param {
    Value(Scalar),
    /// A pointer to the scalar, the pointee qualified as given.
    Ptr {
        to: Scalar,
        konst: bool,
        volatile: bool,
    },
    /// An integer constant expression from 0 to the bound.
    Constant(i64),
}

/// The bit a bit-test intrinsic leaves after reading it.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum BitModify {
    Keep,
    Set,
    Reset,
    Complement,
}

/// What a call does. Widths are in bytes.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Op {
    /// `__assume(e)`: `e` is unevaluated, and a constant 0 is
    /// `__builtin_unreachable()`.
    Assume,
    /// `__noop(...)`: the arguments are unevaluated and the value is 0.
    Noop,
    /// `__va_start(&ap, ...)`: `__builtin_va_start` on the `va_list` the
    /// first argument addresses; the rest are unevaluated.
    VaStart,
    /// No instruction; no memory access moves across it.
    CompilerBarrier,
    /// `_exception_code()`: the code of the exception a filter or an
    /// `__except` body handles.
    ExceptionCode,
    /// `_exception_info()`: the `EXCEPTION_POINTERS` a filter receives.
    ExceptionInfo,
    /// `_abnormal_termination()`: whether a `__finally` body runs because an
    /// exception or a jump left its `__try` body.
    AbnormalTermination,
    ReturnAddress,
    /// The return address's slot, one pointer above the saved frame pointer.
    AddressOfReturnAddress,
    /// An atomic operation on the first argument's pointee, `one` being an
    /// increment's operand; a compare-exchange takes `(p, exchange, comparand)`.
    Atomic {
        kind: AtomicKind,
        order: MemOrder,
        one: bool,
    },
    /// `(p, high, low, comparand)`, the prior contents left in `*comparand`.
    CompareExchange128 {
        order: MemOrder,
    },
    /// The lowest or highest set bit's index, stored when the mask is not 0.
    BitScan {
        reverse: bool,
        width: u8,
    },
    Popcount {
        width: u8,
    },
    /// The bit width for 0, as `lzcnt` and `clz` count.
    LeadingZeros {
        width: u8,
    },
    TrailingZeros {
        width: u8,
    },
    LeadingOnes {
        width: u8,
    },
    /// The copies of the sign bit below it, as `cls` counts.
    LeadingSigns {
        width: u8,
    },
    /// The count is taken modulo the bit width.
    Rotate {
        left: bool,
        width: u8,
    },
    /// Bit `b` of the bit string at `a`, then modified, atomically if ordered.
    BitTest {
        modify: BitModify,
        atomic: Option<MemOrder>,
    },
    MulHigh {
        signed: bool,
    },
    /// The product's low half, the high half stored through the third operand.
    Mul128 {
        signed: bool,
    },
    /// `(low, high)` shifted by the count modulo 64: the high or low half.
    Shift128 {
        left: bool,
    },
    VolatileLoad,
    VolatileStore,
    /// An access at the offset from the `gs` segment base.
    GsLoad,
    GsStore,
    /// An access at the offset from x18.
    X18Load,
    X18Store,
    /// General register `n`, 31 being sp.
    GetReg,
    /// The system register `ARM64_SYSREG(op0, op1, crn, crm, op2)` encodes.
    ReadStatusReg,
    WriteStatusReg,
    Crc32 {
        width: u8,
        castagnoli: bool,
    },
    /// The breakpoint the debuggers recognize: `int3`, `brk #0xf000`.
    DebugBreak,
    /// `int $0x29` with the code in ecx, `brk #0xf003` with it in x0.
    FastFail,
    /// One instruction with no operand.
    Insn(&'static str),
    /// The spin-wait hint: `pause`, `yield`.
    Pause,
    Cpuid {
        sub: bool,
    },
    Rdtsc,
    /// `rdtscp`: the counter, and IA32_TSC_AUX stored through the pointer.
    Rdtscp,
    /// The edx:eax `rdmsr`, `rdpmc` or `xgetbv` leaves for the register in ecx.
    ReadPair(&'static str),
    /// `wrmsr` or `xsetbv`: the second argument as edx:eax to the register in ecx.
    WritePair(&'static str),
    /// A template taking the arguments as `%0` on, 64-bit registers.
    Asm(&'static str),
    /// A template leaving its value in `%0`, the arguments `%1` on, all of
    /// the width.
    AsmValue {
        template: &'static str,
        width: u8,
    },
    /// Debug register `n`, the constant first argument, read or written.
    ReadDr,
    WriteDr,
    /// `invpcid` of the type and the descriptor's address.
    Invpcid,
    /// A VMX instruction, its arguments `%2` on: 0 on success, 1 when it
    /// fails with a VM-instruction error (ZF), 2 when it fails without (CF).
    VmxStatus(&'static str),
    /// An SVM instruction of the address in rax.
    RaxInsn(&'static str),
    /// `in` or `out` of the width at the port in dx.
    PortIn {
        width: u8,
    },
    PortOut {
        width: u8,
    },
    /// `rep ins` or `rep outs` of `(port, buffer, count)` elements.
    PortString {
        width: u8,
        out: bool,
    },
    /// RFLAGS, through `pushfq` and `popq`.
    ReadEflags,
    /// RFLAGS from the operand, through `pushq` and `popfq`.
    WriteEflags,
    /// `dmb`, `dsb` or `isb` with the constant option.
    Barrier(&'static str),
    /// `rep stos` of `(destination, value, count)` elements of the width.
    RepStos {
        width: u8,
    },
    /// `rep movs` of `(destination, source, count)` elements of the width.
    RepMovs {
        width: u8,
    },
}

impl Op {
    pub(crate) fn is_noreturn(self) -> bool {
        self == Op::FastFail
    }
}

pub(crate) struct Intrinsic {
    pub(crate) op: Op,
    pub(crate) ret: Option<Scalar>,
    pub(crate) params: Vec<Param>,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Arch {
    Both,
    X64,
    Arm64,
}

use Arch::{Arm64, Both, X64};
use Param::{Constant as K, Value as V};
use Scalar::*;

const fn p(to: Scalar) -> Param {
    Param::Ptr {
        to,
        konst: false,
        volatile: false,
    }
}

const fn pv(to: Scalar) -> Param {
    Param::Ptr {
        to,
        konst: false,
        volatile: true,
    }
}

const fn pcv(to: Scalar) -> Param {
    Param::Ptr {
        to,
        konst: true,
        volatile: true,
    }
}

const fn pc(to: Scalar) -> Param {
    Param::Ptr {
        to,
        konst: true,
        volatile: false,
    }
}

const fn bits(op: Op, width: u8) -> Op {
    match op {
        Op::Popcount { .. } => Op::Popcount { width },
        Op::LeadingZeros { .. } => Op::LeadingZeros { width },
        Op::TrailingZeros { .. } => Op::TrailingZeros { width },
        Op::LeadingOnes { .. } => Op::LeadingOnes { width },
        Op::LeadingSigns { .. } => Op::LeadingSigns { width },
        op => op,
    }
}

const POP: Op = Op::Popcount { width: 0 };
const LZ: Op = Op::LeadingZeros { width: 0 };
const TZ: Op = Op::TrailingZeros { width: 0 };
const LO: Op = Op::LeadingOnes { width: 0 };
const LS: Op = Op::LeadingSigns { width: 0 };

const fn rot(left: bool, width: u8) -> Op {
    Op::Rotate { left, width }
}

const fn scan(reverse: bool, width: u8) -> Op {
    Op::BitScan { reverse, width }
}

const fn cr(template: &'static str) -> Op {
    Op::AsmValue { template, width: 8 }
}

const fn ports(width: u8, out: bool) -> Op {
    Op::PortString { width, out }
}

const fn crc(width: u8, castagnoli: bool) -> Op {
    Op::Crc32 { width, castagnoli }
}

/// `ldar` and `stlr` are AArch64's seq_cst load and store; an acquire
/// load may be the weaker `ldapr`.
const fn seq_cst(kind: AtomicKind) -> Op {
    Op::Atomic {
        kind,
        order: MemOrder::SeqCst,
        one: false,
    }
}

type Row = (&'static str, Arch, Op, Option<Scalar>, &'static [Param]);

/// The intrinsics of one signature each, as MSVC 14.50's <intrin.h> has them.
#[rustfmt::skip]
const FIXED: &[Row] = &[
    ("__assume", Both, Op::Assume, None, &[]),
    ("__noop", Both, Op::Noop, Some(Int), &[]),
    ("__va_start", Both, Op::VaStart, None, &[]),
    ("_ReadWriteBarrier", Both, Op::CompilerBarrier, None, &[]),
    ("_ReadBarrier", Both, Op::CompilerBarrier, None, &[]),
    ("_WriteBarrier", Both, Op::CompilerBarrier, None, &[]),
    ("_exception_code", Both, Op::ExceptionCode, Some(ULong), &[]),
    ("__exception_code", Both, Op::ExceptionCode, Some(ULong), &[]),
    ("_exception_info", Both, Op::ExceptionInfo, Some(VoidPtr), &[]),
    ("__exception_info", Both, Op::ExceptionInfo, Some(VoidPtr), &[]),
    ("_abnormal_termination", Both, Op::AbnormalTermination, Some(Int), &[]),
    ("__abnormal_termination", Both, Op::AbnormalTermination, Some(Int), &[]),
    ("_ReturnAddress", Both, Op::ReturnAddress, Some(VoidPtr), &[]),
    ("_AddressOfReturnAddress", Both, Op::AddressOfReturnAddress, Some(VoidPtr), &[]),
    ("__debugbreak", Both, Op::DebugBreak, None, &[]),
    ("__fastfail", Both, Op::FastFail, None, &[V(UInt)]),
    ("__nop", Both, Op::Insn("nop"), None, &[]),
    ("_BitScanForward", Both, scan(false, 4), Some(UChar), &[p(ULong), V(ULong)]),
    ("_BitScanReverse", Both, scan(true, 4), Some(UChar), &[p(ULong), V(ULong)]),
    ("_BitScanForward64", Both, scan(false, 8), Some(UChar), &[p(ULong), V(ULLong)]),
    ("_BitScanReverse64", Both, scan(true, 8), Some(UChar), &[p(ULong), V(ULLong)]),
    ("_rotl8", Both, rot(true, 1), Some(UChar), &[V(UChar), V(UChar)]),
    ("_rotl16", Both, rot(true, 2), Some(UShort), &[V(UShort), V(UChar)]),
    ("_rotl", Both, rot(true, 4), Some(UInt), &[V(UInt), V(Int)]),
    ("_lrotl", Both, rot(true, 4), Some(ULong), &[V(ULong), V(Int)]),
    ("_rotl64", Both, rot(true, 8), Some(ULLong), &[V(ULLong), V(Int)]),
    ("_rotr8", Both, rot(false, 1), Some(UChar), &[V(UChar), V(UChar)]),
    ("_rotr16", Both, rot(false, 2), Some(UShort), &[V(UShort), V(UChar)]),
    ("_rotr", Both, rot(false, 4), Some(UInt), &[V(UInt), V(Int)]),
    ("_lrotr", Both, rot(false, 4), Some(ULong), &[V(ULong), V(Int)]),
    ("_rotr64", Both, rot(false, 8), Some(ULLong), &[V(ULLong), V(Int)]),
    ("__popcnt16", Both, bits(POP, 2), Some(UShort), &[V(UShort)]),
    ("__popcnt", Both, bits(POP, 4), Some(UInt), &[V(UInt)]),
    ("__popcnt64", Both, bits(POP, 8), Some(ULLong), &[V(ULLong)]),
    ("__umulh", Both, Op::MulHigh { signed: false }, Some(ULLong), &[V(ULLong), V(ULLong)]),
    ("__mulh", Both, Op::MulHigh { signed: true }, Some(LLong), &[V(LLong), V(LLong)]),
    ("__iso_volatile_load8", Both, Op::VolatileLoad, Some(Char), &[pcv(Char)]),
    ("__iso_volatile_load16", Both, Op::VolatileLoad, Some(Short), &[pcv(Short)]),
    ("__iso_volatile_load32", Both, Op::VolatileLoad, Some(Int), &[pcv(Int)]),
    ("__iso_volatile_load64", Both, Op::VolatileLoad, Some(LLong), &[pcv(LLong)]),
    ("__iso_volatile_store8", Both, Op::VolatileStore, None, &[pv(Char), V(Char)]),
    ("__iso_volatile_store16", Both, Op::VolatileStore, None, &[pv(Short), V(Short)]),
    ("__iso_volatile_store32", Both, Op::VolatileStore, None, &[pv(Int), V(Int)]),
    ("__iso_volatile_store64", Both, Op::VolatileStore, None, &[pv(LLong), V(LLong)]),
    ("__cpuid", X64, Op::Cpuid { sub: false }, None, &[p(Int), V(Int)]),
    ("__cpuidex", X64, Op::Cpuid { sub: true }, None, &[p(Int), V(Int), V(Int)]),
    ("__rdtsc", X64, Op::Rdtsc, Some(ULLong), &[]),
    ("__rdtscp", X64, Op::Rdtscp, Some(ULLong), &[p(UInt)]),
    ("__readeflags", X64, Op::ReadEflags, Some(ULLong), &[]),
    ("__writeeflags", X64, Op::WriteEflags, None, &[V(ULLong)]),
    ("_xgetbv", X64, Op::ReadPair("xgetbv"), Some(ULLong), &[V(UInt)]),
    ("_xsetbv", X64, Op::WritePair("xsetbv"), None, &[V(UInt), V(ULLong)]),
    ("__readmsr", X64, Op::ReadPair("rdmsr"), Some(ULLong), &[V(ULong)]),
    ("__writemsr", X64, Op::WritePair("wrmsr"), None, &[V(ULong), V(ULLong)]),
    ("__readpmc", X64, Op::ReadPair("rdpmc"), Some(ULLong), &[V(ULong)]),
    ("__readcr0", X64, cr("movq %%cr0, %0"), Some(ULLong), &[]),
    ("__readcr2", X64, cr("movq %%cr2, %0"), Some(ULLong), &[]),
    ("__readcr3", X64, cr("movq %%cr3, %0"), Some(ULLong), &[]),
    ("__readcr4", X64, cr("movq %%cr4, %0"), Some(ULLong), &[]),
    ("__readcr8", X64, cr("movq %%cr8, %0"), Some(ULLong), &[]),
    ("__writecr0", X64, Op::Asm("movq %0, %%cr0"), None, &[V(ULLong)]),
    ("__writecr3", X64, Op::Asm("movq %0, %%cr3"), None, &[V(ULLong)]),
    ("__writecr4", X64, Op::Asm("movq %0, %%cr4"), None, &[V(ULLong)]),
    ("__writecr8", X64, Op::Asm("movq %0, %%cr8"), None, &[V(ULLong)]),
    ("__readdr", X64, Op::ReadDr, Some(ULLong), &[K(7)]),
    ("__writedr", X64, Op::WriteDr, None, &[K(7), V(ULLong)]),
    ("__lidt", X64, Op::Asm("lidt (%0)"), None, &[V(VoidPtr)]),
    ("__sidt", X64, Op::Asm("sidt (%0)"), None, &[V(VoidPtr)]),
    ("_lgdt", X64, Op::Asm("lgdt (%0)"), None, &[V(VoidPtr)]),
    ("_sgdt", X64, Op::Asm("sgdt (%0)"), None, &[V(VoidPtr)]),
    ("__invlpg", X64, Op::Asm("invlpg (%0)"), None, &[V(VoidPtr)]),
    ("_invpcid", X64, Op::Invpcid, None, &[V(UInt), V(VoidPtr)]),
    ("__segmentlimit", X64, Op::AsmValue { template: "lsll %1, %0", width: 4 }, Some(ULong), &[V(ULong)]),
    ("__wbinvd", X64, Op::Insn("wbinvd"), None, &[]),
    ("_disable", X64, Op::Insn("cli"), None, &[]),
    ("_enable", X64, Op::Insn("sti"), None, &[]),
    ("__vmx_on", X64, Op::VmxStatus("vmxon (%2)"), Some(UChar), &[p(ULLong)]),
    ("__vmx_off", X64, Op::Insn("vmxoff"), None, &[]),
    ("__vmx_vmclear", X64, Op::VmxStatus("vmclear (%2)"), Some(UChar), &[p(ULLong)]),
    ("__vmx_vmptrld", X64, Op::VmxStatus("vmptrld (%2)"), Some(UChar), &[p(ULLong)]),
    ("__vmx_vmptrst", X64, Op::Asm("vmptrst (%0)"), None, &[p(ULLong)]),
    ("__vmx_vmlaunch", X64, Op::VmxStatus("vmlaunch"), Some(UChar), &[]),
    ("__vmx_vmresume", X64, Op::VmxStatus("vmresume"), Some(UChar), &[]),
    ("__vmx_vmread", X64, Op::VmxStatus("vmread %2, (%3)"), Some(UChar), &[V(ULLong), p(ULLong)]),
    ("__vmx_vmwrite", X64, Op::VmxStatus("vmwrite %3, %2"), Some(UChar), &[V(ULLong), V(ULLong)]),
    ("__svm_clgi", X64, Op::Insn("clgi"), None, &[]),
    ("__svm_stgi", X64, Op::Insn("stgi"), None, &[]),
    ("__svm_vmload", X64, Op::RaxInsn("vmload %%rax"), None, &[V(ULLong)]),
    ("__svm_vmsave", X64, Op::RaxInsn("vmsave %%rax"), None, &[V(ULLong)]),
    ("__svm_vmrun", X64, Op::RaxInsn("vmrun %%rax"), None, &[V(ULLong)]),
    ("__inbyte", X64, Op::PortIn { width: 1 }, Some(UChar), &[V(UShort)]),
    ("__inword", X64, Op::PortIn { width: 2 }, Some(UShort), &[V(UShort)]),
    ("__indword", X64, Op::PortIn { width: 4 }, Some(ULong), &[V(UShort)]),
    ("__outbyte", X64, Op::PortOut { width: 1 }, None, &[V(UShort), V(UChar)]),
    ("__outword", X64, Op::PortOut { width: 2 }, None, &[V(UShort), V(UShort)]),
    ("__outdword", X64, Op::PortOut { width: 4 }, None, &[V(UShort), V(ULong)]),
    ("__inbytestring", X64, ports(1, false), None, &[V(UShort), p(UChar), V(ULong)]),
    ("__inwordstring", X64, ports(2, false), None, &[V(UShort), p(UShort), V(ULong)]),
    ("__indwordstring", X64, ports(4, false), None, &[V(UShort), p(ULong), V(ULong)]),
    ("__outbytestring", X64, ports(1, true), None, &[V(UShort), p(UChar), V(ULong)]),
    ("__outwordstring", X64, ports(2, true), None, &[V(UShort), p(UShort), V(ULong)]),
    ("__outdwordstring", X64, ports(4, true), None, &[V(UShort), p(ULong), V(ULong)]),
    ("__halt", X64, Op::Insn("hlt"), None, &[]),
    ("_mm_pause", X64, Op::Pause, None, &[]),
    ("_mm_lfence", X64, Op::Insn("lfence"), None, &[]),
    ("_mm_mfence", X64, Op::Insn("mfence"), None, &[]),
    ("_mm_sfence", X64, Op::Insn("sfence"), None, &[]),
    // A full barrier, the `lock or` cl emits for it.
    ("__faststorefence", X64, Op::Insn("lock orl $0, (%rsp)"), None, &[]),
    ("__lzcnt16", X64, bits(LZ, 2), Some(UShort), &[V(UShort)]),
    ("__lzcnt", X64, bits(LZ, 4), Some(UInt), &[V(UInt)]),
    ("__lzcnt64", X64, bits(LZ, 8), Some(ULLong), &[V(ULLong)]),
    ("__readgsbyte", X64, Op::GsLoad, Some(UChar), &[V(ULong)]),
    ("__readgsword", X64, Op::GsLoad, Some(UShort), &[V(ULong)]),
    ("__readgsdword", X64, Op::GsLoad, Some(ULong), &[V(ULong)]),
    ("__readgsqword", X64, Op::GsLoad, Some(ULLong), &[V(ULong)]),
    ("__writegsbyte", X64, Op::GsStore, None, &[V(ULong), V(UChar)]),
    ("__writegsword", X64, Op::GsStore, None, &[V(ULong), V(UShort)]),
    ("__writegsdword", X64, Op::GsStore, None, &[V(ULong), V(ULong)]),
    ("__writegsqword", X64, Op::GsStore, None, &[V(ULong), V(ULLong)]),
    ("_umul128", X64, Op::Mul128 { signed: false }, Some(ULLong), &[V(ULLong), V(ULLong), p(ULLong)]),
    ("_mul128", X64, Op::Mul128 { signed: true }, Some(LLong), &[V(LLong), V(LLong), p(LLong)]),
    ("__shiftleft128", X64, Op::Shift128 { left: true }, Some(ULLong), &[V(ULLong), V(ULLong), V(UChar)]),
    ("__shiftright128", X64, Op::Shift128 { left: false }, Some(ULLong), &[V(ULLong), V(ULLong), V(UChar)]),
    ("__stosb", X64, Op::RepStos { width: 1 }, None, &[p(UChar), V(UChar), V(ULLong)]),
    ("__stosw", X64, Op::RepStos { width: 2 }, None, &[p(UShort), V(UShort), V(ULLong)]),
    ("__stosd", X64, Op::RepStos { width: 4 }, None, &[p(ULong), V(ULong), V(ULLong)]),
    ("__stosq", X64, Op::RepStos { width: 8 }, None, &[p(ULLong), V(ULLong), V(ULLong)]),
    ("__movsb", X64, Op::RepMovs { width: 1 }, None, &[p(UChar), pc(UChar), V(ULLong)]),
    ("__movsw", X64, Op::RepMovs { width: 2 }, None, &[p(UShort), pc(UShort), V(ULLong)]),
    ("__movsd", X64, Op::RepMovs { width: 4 }, None, &[p(ULong), pc(ULong), V(ULLong)]),
    ("__movsq", X64, Op::RepMovs { width: 8 }, None, &[p(ULLong), pc(ULLong), V(ULLong)]),
    ("__yield", Arm64, Op::Pause, None, &[]),
    ("__wfe", Arm64, Op::Insn("wfe"), None, &[]),
    ("__wfi", Arm64, Op::Insn("wfi"), None, &[]),
    ("__sev", Arm64, Op::Insn("sev"), None, &[]),
    ("__sevl", Arm64, Op::Insn("sevl"), None, &[]),
    ("__dmb", Arm64, Op::Barrier("dmb"), None, &[K(15)]),
    ("__dsb", Arm64, Op::Barrier("dsb"), None, &[K(15)]),
    ("__isb", Arm64, Op::Barrier("isb"), None, &[K(15)]),
    ("_CountLeadingZeros", Arm64, bits(LZ, 4), Some(UInt), &[V(ULong)]),
    ("_CountLeadingZeros64", Arm64, bits(LZ, 8), Some(UInt), &[V(ULLong)]),
    ("_CountTrailingZeros", Arm64, bits(TZ, 4), Some(UInt), &[V(ULong)]),
    ("_CountTrailingZeros64", Arm64, bits(TZ, 8), Some(UInt), &[V(ULLong)]),
    ("_CountLeadingOnes", Arm64, bits(LO, 4), Some(UInt), &[V(ULong)]),
    ("_CountLeadingOnes64", Arm64, bits(LO, 8), Some(UInt), &[V(ULLong)]),
    ("_CountLeadingSigns", Arm64, bits(LS, 4), Some(UInt), &[V(Long)]),
    ("_CountLeadingSigns64", Arm64, bits(LS, 8), Some(UInt), &[V(LLong)]),
    ("_CountOneBits", Arm64, bits(POP, 4), Some(UInt), &[V(ULong)]),
    ("_CountOneBits64", Arm64, bits(POP, 8), Some(UInt), &[V(ULLong)]),
    ("__ldar8", Arm64, seq_cst(AtomicKind::Load), Some(UChar), &[pcv(UChar)]),
    ("__ldar16", Arm64, seq_cst(AtomicKind::Load), Some(UShort), &[pcv(UShort)]),
    ("__ldar32", Arm64, seq_cst(AtomicKind::Load), Some(UInt), &[pcv(UInt)]),
    ("__ldar64", Arm64, seq_cst(AtomicKind::Load), Some(ULLong), &[pcv(ULLong)]),
    ("__stlr8", Arm64, seq_cst(AtomicKind::Store), None, &[pv(UChar), V(UChar)]),
    ("__stlr16", Arm64, seq_cst(AtomicKind::Store), None, &[pv(UShort), V(UShort)]),
    ("__stlr32", Arm64, seq_cst(AtomicKind::Store), None, &[pv(UInt), V(UInt)]),
    ("__stlr64", Arm64, seq_cst(AtomicKind::Store), None, &[pv(ULLong), V(ULLong)]),
    ("__readx18byte", Arm64, Op::X18Load, Some(UChar), &[V(ULong)]),
    ("__readx18word", Arm64, Op::X18Load, Some(UShort), &[V(ULong)]),
    ("__readx18dword", Arm64, Op::X18Load, Some(ULong), &[V(ULong)]),
    ("__readx18qword", Arm64, Op::X18Load, Some(ULLong), &[V(ULong)]),
    ("__writex18byte", Arm64, Op::X18Store, None, &[V(ULong), V(UChar)]),
    ("__writex18word", Arm64, Op::X18Store, None, &[V(ULong), V(UShort)]),
    ("__writex18dword", Arm64, Op::X18Store, None, &[V(ULong), V(ULong)]),
    ("__writex18qword", Arm64, Op::X18Store, None, &[V(ULong), V(ULLong)]),
    ("__getReg", Arm64, Op::GetReg, Some(ULLong), &[K(31)]),
    ("_ReadStatusReg", Arm64, Op::ReadStatusReg, Some(LLong), &[K(0x7fff)]),
    ("_WriteStatusReg", Arm64, Op::WriteStatusReg, None, &[K(0x7fff), V(LLong)]),
    ("__crc32b", Arm64, crc(1, false), Some(UInt), &[V(UInt), V(UInt)]),
    ("__crc32h", Arm64, crc(2, false), Some(UInt), &[V(UInt), V(UInt)]),
    ("__crc32w", Arm64, crc(4, false), Some(UInt), &[V(UInt), V(UInt)]),
    ("__crc32d", Arm64, crc(8, false), Some(UInt), &[V(UInt), V(ULLong)]),
    ("__crc32cb", Arm64, crc(1, true), Some(UInt), &[V(UInt), V(UInt)]),
    ("__crc32ch", Arm64, crc(2, true), Some(UInt), &[V(UInt), V(UInt)]),
    ("__crc32cw", Arm64, crc(4, true), Some(UInt), &[V(UInt), V(UInt)]),
    ("__crc32cd", Arm64, crc(8, true), Some(UInt), &[V(UInt), V(ULLong)]),
];

/// gcc's and clang's builtins of these names, with gcc's prototypes.
#[rustfmt::skip]
const GNU_X64: &[(&str, Op, Option<Scalar>, &[Param])] = &[
    ("__builtin_ia32_sfence", Op::Insn("sfence"), None, &[]),
    ("__builtin_ia32_lfence", Op::Insn("lfence"), None, &[]),
    ("__builtin_ia32_mfence", Op::Insn("mfence"), None, &[]),
    ("__builtin_ia32_pause", Op::Pause, None, &[]),
    ("__builtin_ia32_rdtsc", Op::Rdtsc, Some(ULLong), &[]),
    ("__builtin_ia32_rdtscp", Op::Rdtscp, Some(ULLong), &[p(UInt)]),
    ("__builtin_ia32_xgetbv", Op::ReadPair("xgetbv"), Some(ULLong), &[V(UInt)]),
    ("__builtin_ia32_readeflags_u64", Op::ReadEflags, Some(ULLong), &[]),
    ("__builtin_ia32_writeeflags_u64", Op::WriteEflags, None, &[V(ULLong)]),
];

/// The intrinsic `name` is on `target`, or `None`.
pub(crate) fn lookup(name: &str, target: Target) -> Option<Intrinsic> {
    if target.is_x86_64()
        && let Some(&(_, op, ret, params)) = GNU_X64.iter().find(|r| r.0 == name)
    {
        return Some(Intrinsic {
            op,
            ret,
            params: params.to_vec(),
        });
    }
    if !target.ms_extensions() || !name.starts_with('_') {
        return None;
    }
    let arm64 = target.is_aarch64();
    if let Some(&(_, arch, op, ret, params)) = FIXED.iter().find(|r| r.0 == name) {
        let on = match arch {
            Both => true,
            X64 => !arm64,
            Arm64 => arm64,
        };
        return on.then(|| Intrinsic {
            op,
            ret,
            params: params.to_vec(),
        });
    }
    interlocked(name, arm64).or_else(|| bit_test(name, arm64))
}

/// The memory order a family member's suffix names: arm64's `_acq`, `_rel`
/// and `_nf` and x64's `_np`, where `np` lists the bases taking it.
fn order_suffix(rest: &str, arm64: bool, np: bool) -> Option<MemOrder> {
    match rest {
        "" => Some(MemOrder::SeqCst),
        "_acq" if arm64 => Some(MemOrder::Acquire),
        "_rel" if arm64 => Some(MemOrder::Release),
        "_nf" if arm64 => Some(MemOrder::Relaxed),
        "_np" if !arm64 && np => Some(MemOrder::SeqCst),
        _ => None,
    }
}

/// `_Interlocked<op><width><order>`: the operation, `8`, `16` or `64`
/// for `char`, `short` or `__int64` in place of `long`, and an order.
fn interlocked(name: &str, arm64: bool) -> Option<Intrinsic> {
    use AtomicKind::*;
    // `_interlockedadd[64]`: the sum, as `_InterlockedAdd` yields it, on
    // both targets (measured with cl on x64).
    if let Some(width) = name.strip_prefix("_interlockedadd") {
        let ty = match width {
            "" => Long,
            "64" => LLong,
            _ => return None,
        };
        return Some(Intrinsic {
            op: Op::Atomic {
                kind: AddFetch,
                order: MemOrder::SeqCst,
                one: false,
            },
            ret: Some(ty),
            params: alloc::vec![pv(ty), V(ty)],
        });
    }
    let rest = name.strip_prefix("_Interlocked")?;
    if let Some(order) = rest.strip_prefix("CompareExchange128") {
        let order = order_suffix(order, arm64, true)?;
        let params = alloc::vec![pv(LLong), V(LLong), V(LLong), p(LLong)];
        return Some(Intrinsic {
            op: Op::CompareExchange128 { order },
            ret: Some(UChar),
            params,
        });
    }
    // Longest first: each base is a prefix of none listed before it. The
    // unsigned bases take the unsigned type of each width.
    const BASES: &[(&str, AtomicKind, bool, bool)] = &[
        ("CompareExchangePointer", SyncCasVal, true, false),
        ("CompareExchange", SyncCasVal, false, false),
        ("ExchangePointer", Exchange, true, false),
        ("ExchangeAdd", FetchAdd, false, false),
        ("Exchange", Exchange, false, false),
        ("Increment", AddFetch, false, false),
        ("Decrement", SubFetch, false, false),
        ("Nand", FetchNand, false, false),
        ("UMax", FetchMax, false, true),
        ("UMin", FetchMin, false, true),
        ("Max", FetchMax, false, false),
        ("Min", FetchMin, false, false),
        ("And", FetchAnd, false, false),
        ("Xor", FetchXor, false, false),
        ("Add", AddFetch, false, false),
        ("Or", FetchOr, false, false),
    ];
    let &(base, kind, pointer, unsigned) = BASES.iter().find(|b| rest.starts_with(b.0))?;
    let rest = &rest[base.len()..];
    let (ty, rest) = if pointer {
        (VoidPtr, rest)
    } else if let Some(r) = rest.strip_prefix("64") {
        (if unsigned { ULLong } else { LLong }, r)
    } else if let Some(r) = rest.strip_prefix("16") {
        (if unsigned { UShort } else { Short }, r)
    } else if let Some(r) = rest.strip_prefix('8') {
        (if unsigned { UChar } else { Char }, r)
    } else {
        (if unsigned { ULong } else { Long }, rest)
    };
    let one = matches!(base, "Increment" | "Decrement");
    let widths_ok = match base {
        "Increment" | "Decrement" => ty != Char,
        "Add" => arm64 && matches!(ty, Long | LLong),
        _ => true,
    };
    let np = matches!(base, "And" | "Or" | "Xor" | "CompareExchangePointer")
        || (base == "CompareExchange" && ty != Char);
    let order = order_suffix(rest, arm64, np).filter(|_| widths_ok)?;
    let mut params = alloc::vec![pv(ty)];
    if !one {
        params.push(V(ty));
    }
    if kind == SyncCasVal {
        params.push(V(ty));
    }
    Some(Intrinsic {
        op: Op::Atomic { kind, order, one },
        ret: Some(ty),
        params,
    })
}

/// `_bittest<op>[64]` and `_interlockedbittest<op>[64]<order>`.
fn bit_test(name: &str, arm64: bool) -> Option<Intrinsic> {
    let (rest, interlocked) = match name.strip_prefix("_interlockedbittestand") {
        Some(r) => (r, true),
        None => (name.strip_prefix("_bittest")?, false),
    };
    let (modify, rest) = if interlocked {
        match rest {
            r if r.starts_with("set") => (BitModify::Set, &r[3..]),
            r if r.starts_with("reset") => (BitModify::Reset, &r[5..]),
            _ => return None,
        }
    } else if let Some(r) = rest.strip_prefix("andcomplement") {
        (BitModify::Complement, r)
    } else if let Some(r) = rest.strip_prefix("andreset") {
        (BitModify::Reset, r)
    } else if let Some(r) = rest.strip_prefix("andset") {
        (BitModify::Set, r)
    } else {
        (BitModify::Keep, rest)
    };
    let (ty, rest) = match rest.strip_prefix("64") {
        Some(r) => (LLong, r),
        None => (Long, rest),
    };
    let atomic = if interlocked {
        Some(order_suffix(rest, arm64, false)?)
    } else if rest.is_empty() {
        None
    } else {
        return None;
    };
    let base = match (interlocked, modify) {
        (true, _) => pv(ty),
        (false, BitModify::Keep) => Param::Ptr {
            to: ty,
            konst: true,
            volatile: false,
        },
        (false, _) => p(ty),
    };
    Some(Intrinsic {
        op: Op::BitTest { modify, atomic },
        ret: Some(UChar),
        params: alloc::vec![base, V(ty)],
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn each_family_member_takes_the_width_and_order_its_name_spells() {
        let x64 = Target::WindowsX64;
        let a64 = Target::WindowsAarch64;
        let atomic = |n: &str, t| lookup(n, t).map(|i| (i.op, i.ret, i.params.len()));
        assert_eq!(
            atomic("_InterlockedIncrement16", x64),
            Some((
                Op::Atomic {
                    kind: AtomicKind::AddFetch,
                    order: MemOrder::SeqCst,
                    one: true
                },
                Some(Short),
                1
            ))
        );
        assert_eq!(
            atomic("_InterlockedCompareExchange64_acq", a64),
            Some((
                Op::Atomic {
                    kind: AtomicKind::SyncCasVal,
                    order: MemOrder::Acquire,
                    one: false
                },
                Some(LLong),
                3
            ))
        );
        for absent in [
            "_InterlockedIncrement8",
            "_InterlockedAdd",
            "_InterlockedExchange_acq",
            "_InterlockedExchange_np",
            "_InterlockedCompareExchange8_np",
            "_InterlockedOr32",
            "_bittestandset32",
            "__dmb",
            "__cpuidx",
        ] {
            assert!(lookup(absent, x64).is_none(), "{absent}");
        }
        assert!(lookup("_InterlockedAdd64_nf", a64).is_some());
        assert!(lookup("_InterlockedOr_np", x64).is_some());
        assert!(lookup("_interlockedbittestandreset64_rel", a64).is_some());
        assert!(lookup("__cpuid", a64).is_none());
        assert!(lookup("_BitScanForward", Target::LinuxX64).is_none());
    }
}

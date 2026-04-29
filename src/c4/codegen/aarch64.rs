//! AArch64 instruction encoder + bytecode -> AArch64 lowering.
//!
//! All AArch64 instructions are 32 bits wide and little-endian on every
//! supported OS, which makes the encoder a flat catalogue of
//! `fn enc_xxx(...) -> u32`. The lowering walks a [`Program`]'s bytecode
//! once and emits a stream of those.
//!
//! ## Register convention
//!
//! Phase 1 keeps it simple, with the goal of "obviously correct" over
//! "fast":
//!
//! * `x19` -- VM accumulator (`a` in the bytecode model). Callee-saved,
//!   so we don't have to spill it across `bl` calls.
//! * `sp`  -- VM stack pointer. We use the real native stack for VM
//!   pushes (`Op::Psh` becomes `str x19, [sp, #-16]!`).
//! * `x29` -- frame pointer (AAPCS64-mandated for unwinding).
//! * `x30` -- link register (saved/restored on entry/exit).
//! * `x0..x7` -- argument-passing registers, used at call sites.
//!
//! Anything more sophisticated (real allocation, dead-store elimination)
//! happens in the optimizer pass before we get here.
//!
//! ## Always-on peepholes
//!
//! Two rewrites the lowering applies regardless of any flag,
//! since both are strict wins.
//!
//! [`emit_mov_reg`] drops `mov xd, xd` instead of emitting it.
//! Today's lowering doesn't actually produce a self-mov, but the
//! check costs nothing and protects future refactors -- if a
//! regalloc tweak ever lets source and destination coincide, it
//! collapses to zero bytes automatically.
//!
//! The bigger one is compare-and-branch fusion. When a compare op
//! (`Lt`, `Eq`, ..., or one of the immediate forms `EqI`, `NeI`,
//! ...) feeds directly into `Op::Bz` / `Op::Bnz`, the compare emits
//! just `cmp` and the branch emits `b.cond` instead of `cbz` /
//! `cbnz`. The eliminated `cset` plus the eliminated comparison
//! against zero buy us 4 bytes and one uop per pattern. The rewrite
//! is gated by [`fusion_candidate`], which refuses to fuse if any
//! other branch lands on the `Bz`/`Bnz` PC -- that path would
//! arrive without our `cmp` having set the flags -- or if either
//! the taken-target op or the fall-through op reads `x19` before
//! writing it. The whitelist matters because the elided `cset`
//! leaves `x19` holding the rhs of the compare instead of the
//! 0/1 boolean, and c4's `a && b` short-circuit pattern is exactly
//! a sequence where one `Bz` lands on another `Bz` that wants to
//! read that boolean. Without the gate the compiler quietly
//! miscompiles short-circuits; with it we caught the bug while
//! bringing up the c4 self-host.

// Encoder catalogue: a few entries are still ahead of where the
// lowering pass uses them (full op coverage lands in M1.6). Anything
// referenced from `lower` doesn't trip the allow.
#![allow(dead_code)]

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use super::super::CODE_BASE;
use super::super::error::C4Error;
use super::super::op::Op;
use super::super::program::Program;
use super::regalloc::{self, PoolBank, PushKind, RegStackPlan};
use super::{Build, DataFixup, FuncFixup, GotFixup, NativeOptions, Target, TargetOptions};

/// Per-function lowering state for the register-pool optimization.
/// [`NativeOptions::optimize`] populates `plan` with a
/// [`regalloc::analyze`] result and the lowering consults it on
/// every Psh / pop. With the flag off, `plan` is `None` and the
/// lowering follows the existing real-stack path verbatim.
struct RegState<'a> {
    /// Whether the user requested the register-pool pass
    /// ([`NativeOptions::optimize`]). When `false`, every Pseudo
    /// `Op::Psh` lands on the real stack regardless of its
    /// classification. The cmp+branch fusion peephole is *not*
    /// gated on this flag -- it's a strict, safety-checked
    /// improvement and runs unconditionally, like self-mov elision.
    optimize: bool,
    /// Analyzer output. `None` when [`Self::optimize`] is off.
    plan: Option<&'a RegStackPlan>,
    /// True iff we're currently inside a function whose plan opted
    /// in to the pool. Updated on each `Op::Ent`.
    use_pool: bool,
    /// How many *callee-saved* pool slots the current function uses,
    /// per its plan. The prologue saves this many `xN` registers;
    /// the epilogue must restore the same number. Caller-saved
    /// slots don't enter into this count (they're not saved).
    current_callee_depth: u8,
    /// Runtime mirror of the c4 push-stack: each Psh appends an
    /// entry, each pop op pops one. `Some((slot, bank))` means the
    /// value is live in the bank/slot pool register; `None` means
    /// it's on the real stack the existing lowering uses.
    pseudo_stack: Vec<Option<(u8, PoolBank)>>,
    /// cmp+branch fusion peephole: when a compare op (`Lt`/`Eq`/...
    /// or `LtI`/`EqI`/...) is followed immediately by `Op::Bz` or
    /// `Op::Bnz` and the `Bz`/`Bnz` PC is not a branch target, the
    /// compare op skips emitting `cset` (since the boolean result
    /// would only be consumed by the matching branch) and stashes
    /// its condition here. The matching `Op::Bz`/`Op::Bnz` then
    /// emits a single `b.cond` reading the flags directly. Always
    /// `None` outside the compare-then-branch window. Independent
    /// of [`Self::optimize`] -- the fusion is a strict win.
    pending_cmp_cond: Option<Cond>,
}

impl<'a> RegState<'a> {
    fn new(optimize: bool, plan: Option<&'a RegStackPlan>) -> Self {
        Self {
            optimize,
            plan,
            use_pool: false,
            current_callee_depth: 0,
            pseudo_stack: Vec::new(),
            pending_cmp_cond: None,
        }
    }
}

/// Libc symbol metadata. macOS prefixes everything with `_` (the classic
/// Mach-O calling convention); Linux uses the bare C name. The codegen
/// records GOT slot indices into [`IMPORTS`]; per-target writers read
/// whichever name field they need.
pub(crate) struct Import {
    pub macos_symbol: &'static str,
    pub linux_symbol: &'static str,
    pub op: Op,
}

/// Libc symbols badc binaries import. **Order matters** -- the index
/// in this slice is the GOT slot index in `__DATA` (Mach-O) or `.got`
/// (ELF), and the codegen embeds those indices in the GOT-fixup
/// records. Adding a row never breaks existing binaries; reordering
/// silently miscompiles every previously-emitted call site.
pub(crate) const IMPORTS: &[Import] = &[
    Import {
        macos_symbol: "_open",
        linux_symbol: "open",
        op: Op::Open,
    },
    Import {
        macos_symbol: "_read",
        linux_symbol: "read",
        op: Op::Read,
    },
    Import {
        macos_symbol: "_close",
        linux_symbol: "close",
        op: Op::Clos,
    },
    Import {
        macos_symbol: "_printf",
        linux_symbol: "printf",
        op: Op::Prtf,
    },
    Import {
        macos_symbol: "_malloc",
        linux_symbol: "malloc",
        op: Op::Malc,
    },
    Import {
        macos_symbol: "_free",
        linux_symbol: "free",
        op: Op::Free,
    },
    Import {
        macos_symbol: "_memset",
        linux_symbol: "memset",
        op: Op::Mset,
    },
    Import {
        macos_symbol: "_memcmp",
        linux_symbol: "memcmp",
        op: Op::Mcmp,
    },
    Import {
        macos_symbol: "_memcpy",
        linux_symbol: "memcpy",
        op: Op::Mcpy,
    },
    Import {
        macos_symbol: "_exit",
        linux_symbol: "exit",
        op: Op::Exit,
    },
    Import {
        macos_symbol: "_write",
        linux_symbol: "write",
        op: Op::Write,
    },
    Import {
        macos_symbol: "_getenv",
        linux_symbol: "getenv",
        op: Op::Genv,
    },
    Import {
        macos_symbol: "_setenv",
        linux_symbol: "setenv",
        op: Op::Senv,
    },
    // POSIX libdl. On Linux these live in libdl.so.2 (still shipped
    // as a stub on glibc 2.34+ which folded the bodies back into
    // libc); on macOS they live in libSystem alongside the rest.
    // The codegen treats them like any other libc call -- adrp+ldr+blr
    // through `.got`.
    Import {
        macos_symbol: "_dlopen",
        linux_symbol: "dlopen",
        op: Op::Dlop,
    },
    Import {
        macos_symbol: "_dlsym",
        linux_symbol: "dlsym",
        op: Op::Dlsm,
    },
    Import {
        macos_symbol: "_dlclose",
        linux_symbol: "dlclose",
        op: Op::Dlcl,
    },
    Import {
        macos_symbol: "_dlerror",
        linux_symbol: "dlerror",
        op: Op::Dler,
    },
];

fn import_index_for_op(op: Op) -> Option<usize> {
    IMPORTS.iter().position(|imp| imp.op == op)
}

/// AArch64 register name. Wraps the 5-bit register field that nearly
/// every instruction needs in some position; using a newtype prevents
/// the "I passed `1` for a register and `1` for an immediate to the
/// same encoder" bug class.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) struct Reg(pub u8);

#[allow(dead_code)] // Several land starting M1.5.
impl Reg {
    pub const X0: Reg = Reg(0);
    pub const X1: Reg = Reg(1);
    pub const X2: Reg = Reg(2);
    pub const X8: Reg = Reg(8); // Linux/aarch64 intrinsic number register
    pub const X16: Reg = Reg(16); // IP0 -- temp scratch
    pub const X17: Reg = Reg(17); // IP1 -- second temp
    pub const X19: Reg = Reg(19); // VM accumulator (callee-saved)
    /// Base of the callee-saved pseudo-stack pool used by the
    /// native optimizer. Slot N (in [`PoolBank::Callee`]) maps to
    /// `Reg(CALLEE_POOL_BASE.0 + N)` -- x20..x27. All eight regs
    /// are AAPCS64 callee-saved, so the prologue only has to save
    /// the prefix the function actually uses
    /// (per [`regalloc::FunctionPlan::callee_depth`]).
    pub const CALLEE_POOL_BASE: Reg = Reg(20);
    /// Base of the caller-saved pseudo-stack pool. Slot N (in
    /// [`PoolBank::Caller`]) maps to `Reg(CALLER_POOL_BASE.0 + N)`
    /// -- x9..x15. AAPCS64 marks these caller-saved, so a `bl` /
    /// `blr` would clobber them; the regalloc analyzer guarantees a
    /// caller-bank slot is *never* live across a call op, so no
    /// spill is needed. The prologue / epilogue likewise saves none
    /// of these.
    pub const CALLER_POOL_BASE: Reg = Reg(9);
    pub const X29: Reg = Reg(29); // frame pointer (fp)
    pub const X30: Reg = Reg(30); // link register (lr)
    /// AArch64 conflates SP and the zero register at field-31 depending
    /// on instruction context. The ARM ARM disambiguates per-encoding;
    /// every instruction we use here treats field-31 as SP.
    pub const SP: Reg = Reg(31);
}

/// Pool sizes on aarch64. x20..x27 = 8 callee-saved; x9..x15 = 7
/// caller-saved (x16/x17 stay reserved for scratch in the lowering).
pub(super) const POOL_SIZES: regalloc::PoolSizes = regalloc::PoolSizes {
    callee: 8,
    caller: 7,
};

/// Map a regalloc pool slot to its physical register.
fn pool_reg(slot: u8, bank: regalloc::PoolBank) -> Reg {
    match bank {
        regalloc::PoolBank::Callee => Reg(Reg::CALLEE_POOL_BASE.0 + slot),
        regalloc::PoolBank::Caller => Reg(Reg::CALLER_POOL_BASE.0 + slot),
    }
}

// ---------------------------------------------------------------
// Encoders. Each `enc_*` returns the 32-bit instruction word; the
// caller funnels it through `emit` to land in the code buffer in
// the right byte order. They're unit-tested standalone here; the
// lowering pass that consumes them lands in M1.4.
// ---------------------------------------------------------------

/// `MOVZ <Xd>, #imm16, LSL #(hw*16)` -- load a zero-extended 16-bit
/// immediate into the given lane of `Xd`, clearing the others.
///
/// `hw` selects which 16-bit lane: 0 = bits[15:0], 1 = bits[31:16],
/// 2 = bits[47:32], 3 = bits[63:48].
pub(super) fn enc_movz(rd: Reg, imm16: u16, hw: u8) -> u32 {
    debug_assert!(hw < 4, "movz: hw must be 0..=3");
    0xD280_0000 | ((hw as u32) << 21) | ((imm16 as u32) << 5) | (rd.0 as u32)
}

/// `MOVK <Xd>, #imm16, LSL #(hw*16)` -- overwrite one 16-bit lane of
/// `Xd` with `imm16`, leaving the other lanes intact. Combined with
/// `movz` it builds an arbitrary 64-bit constant in 1-4 instructions
/// (see [`load_imm64`]).
pub(super) fn enc_movk(rd: Reg, imm16: u16, hw: u8) -> u32 {
    debug_assert!(hw < 4, "movk: hw must be 0..=3");
    0xF280_0000 | ((hw as u32) << 21) | ((imm16 as u32) << 5) | (rd.0 as u32)
}

/// `RET <Xn>` -- branch to the address in `Xn` (default `x30`/`lr`).
/// AAPCS64 puts the return address in `x30` on entry, so the bare form
/// `ret` (= `ret x30`) is the usual one.
pub(super) fn enc_ret(rn: Reg) -> u32 {
    0xD65F_0000 | ((rn.0 as u32) << 5)
}

/// `BL <label>` -- branch with link to a PC-relative label.
///
/// `imm26` is the signed offset measured in **instructions** (i.e.
/// bytes/4); ARM ARM allows the range +/-128 MiB. We sign-mask down
/// to 26 bits so a negative offset (calling backwards) emits the
/// right two's-complement bits.
pub(super) fn enc_bl(imm26: i32) -> u32 {
    debug_assert!(
        (-(1 << 25)..(1 << 25)).contains(&imm26),
        "bl: offset {imm26} out of range (must fit in signed 26 bits)"
    );
    0x9400_0000 | ((imm26 as u32) & 0x03FF_FFFF)
}

/// `STP <Xt1>, <Xt2>, [<Xn|SP>, #imm]!` -- store-pair, pre-indexed.
/// `imm` is the byte offset; it must be a multiple of 8 (the stp encoding
/// scales the on-disk imm7 by 8) and fit in `[-512, 504]` after scaling.
///
/// Used in function prologues: `stp x29, x30, [sp, #-16]!` saves the
/// caller's frame pointer + link register and bumps sp in one go.
pub(super) fn enc_stp_pre(rt: Reg, rt2: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!(imm % 8 == 0, "stp: imm must be 8-byte aligned, got {imm}");
    let imm7 = imm / 8;
    debug_assert!(
        (-64..64).contains(&imm7),
        "stp: offset {imm} (scaled {imm7}) out of range"
    );
    0xA980_0000
        | (((imm7 as u32) & 0x7F) << 15)
        | ((rt2.0 as u32) << 10)
        | ((rn.0 as u32) << 5)
        | (rt.0 as u32)
}

/// `LDP <Xt1>, <Xt2>, [<Xn|SP>], #imm` -- load-pair, post-indexed.
/// Mirror of [`enc_stp_pre`] for function epilogues:
/// `ldp x29, x30, [sp], #16` restores fp/lr and bumps sp back.
pub(super) fn enc_ldp_post(rt: Reg, rt2: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!(imm % 8 == 0, "ldp: imm must be 8-byte aligned, got {imm}");
    let imm7 = imm / 8;
    debug_assert!(
        (-64..64).contains(&imm7),
        "ldp: offset {imm} (scaled {imm7}) out of range"
    );
    0xA8C0_0000
        | (((imm7 as u32) & 0x7F) << 15)
        | ((rt2.0 as u32) << 10)
        | ((rn.0 as u32) << 5)
        | (rt.0 as u32)
}

/// `MOV <Xd>, <Xn>` -- alias for `ORR <Xd>, XZR, <Xn>`. Note that ARM
/// uses two distinct mov forms: this one (register-to-register, where
/// `Rn` field 31 means XZR) and `add xd, sp, #0` (which is what you
/// need when the source is SP itself, because in `add` field 31 means
/// SP). Use [`enc_add_imm`] with `imm=0` for the `mov xd, sp` case.
pub(super) fn enc_mov_reg(rd: Reg, rn: Reg) -> u32 {
    0xAA00_0000 | ((rn.0 as u32) << 16) | ((Reg::SP.0 as u32) << 5) | (rd.0 as u32)
}

/// `ADD <Xd>, <Xn|SP>, #imm12` -- 12-bit unsigned immediate, no shift.
/// Larger immediates need either the `lsl #12` shift form or the
/// load-into-register-and-add long form; we don't need either yet.
pub(super) fn enc_add_imm(rd: Reg, rn: Reg, imm12: u32) -> u32 {
    debug_assert!(imm12 < 4096, "add imm: {imm12} > 12-bit max");
    0x9100_0000 | (imm12 << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SUB <Xd>, <Xn|SP>, #imm12` -- 12-bit unsigned immediate, no shift.
/// Used to allocate stack space in function prologues.
pub(super) fn enc_sub_imm(rd: Reg, rn: Reg, imm12: u32) -> u32 {
    debug_assert!(imm12 < 4096, "sub imm: {imm12} > 12-bit max");
    0xD100_0000 | (imm12 << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

// ---- 3-register arithmetic / bitwise (shifted-register form, no shift). ----
// Each follows the same template: a base opcode | Rm<<16 | Rn<<5 | Rd.
// Verified against `clang -c -arch arm64` on Apple Silicon.

/// `ADD <Xd>, <Xn>, <Xm>` -- 64-bit register add, no shift.
pub(super) fn enc_add_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0x8B00_0000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SUB <Xd>, <Xn>, <Xm>` -- 64-bit register subtract.
pub(super) fn enc_sub_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0xCB00_0000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `AND <Xd>, <Xn>, <Xm>` -- bitwise and.
pub(super) fn enc_and_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0x8A00_0000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `ORR <Xd>, <Xn>, <Xm>` -- bitwise or.
pub(super) fn enc_orr_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0xAA00_0000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `EOR <Xd>, <Xn>, <Xm>` -- bitwise xor.
pub(super) fn enc_eor_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0xCA00_0000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `MUL <Xd>, <Xn>, <Xm>` -- alias for `MADD Xd, Xn, Xm, XZR`.
/// We bake in `Ra = XZR (31)` so this stays a 3-register helper.
pub(super) fn enc_mul(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0x9B00_7C00 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SDIV <Xd>, <Xn>, <Xm>` -- signed integer division. Pairs with
/// [`enc_msub`] when computing modulo.
pub(super) fn enc_sdiv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0x9AC0_0C00 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `MSUB <Xd>, <Xn>, <Xm>, <Xa>` -- `Xd = Xa - (Xn * Xm)`. The
/// AArch64 idiom for `mod` is `sdiv q, a, b ; msub r, q, b, a`,
/// which yields `r = a - (a/b)*b`.
pub(super) fn enc_msub(rd: Reg, rn: Reg, rm: Reg, ra: Reg) -> u32 {
    0x9B00_8000
        | ((rm.0 as u32) << 16)
        | ((ra.0 as u32) << 10)
        | ((rn.0 as u32) << 5)
        | (rd.0 as u32)
}

/// `LSLV <Xd>, <Xn>, <Xm>` -- variable left shift, masking the shift
/// amount to 6 bits (i.e., shifting by `Xm % 64`).
pub(super) fn enc_lslv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0x9AC0_2000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `LSRV <Xd>, <Xn>, <Xm>` -- variable logical right shift.
pub(super) fn enc_lsrv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0x9AC0_2400 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `ASRV <Xd>, <Xn>, <Xm>` -- variable arithmetic right shift. The
/// signed counterpart to `LSRV`; we use it for the c4 `>>` operator
/// since c4 ints are signed.
pub(super) fn enc_asrv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0x9AC0_2800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

// ---- Comparisons + condition-set. ----

/// `CMP <Xn>, <Xm>` = `SUBS XZR, <Xn>, <Xm>` -- compare two registers,
/// updating the NZCV flags but discarding the result.
pub(super) fn enc_cmp_reg(rn: Reg, rm: Reg) -> u32 {
    0xEB00_0000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (Reg::SP.0 as u32)
}

/// AArch64 condition codes -- the 4-bit field that follows comparisons
/// and conditional moves. Names match the ARM ARM.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum Cond {
    Eq = 0,
    Ne = 1,
    Lt = 0xB,
    Gt = 0xC,
    Le = 0xD,
    Ge = 0xA,
}

impl Cond {
    /// CSET emits `CSINC Xd, XZR, XZR, INVERT(cond)`. The ARM
    /// invariant is that bit 0 of the condition field flips meaning
    /// (EQ <-> NE, LT <-> GE, GT <-> LE), so we just XOR with 1.
    fn invert(self) -> u32 {
        (self as u32) ^ 1
    }

    /// Logical complement of the condition as another [`Cond`]
    /// variant. Used by the cmp+branch fusion peephole: when a
    /// compare op `Op::Lt` is followed by `Op::Bz target`, we want
    /// to "branch when (lhs < rhs) is false" which is "branch when
    /// lhs >= rhs" -- i.e., `Cond::Lt.flip() == Cond::Ge`.
    fn flip(self) -> Cond {
        match self {
            Cond::Eq => Cond::Ne,
            Cond::Ne => Cond::Eq,
            Cond::Lt => Cond::Ge,
            Cond::Ge => Cond::Lt,
            Cond::Gt => Cond::Le,
            Cond::Le => Cond::Gt,
        }
    }
}

/// `CSET <Xd>, <cond>` = `CSINC Xd, XZR, XZR, invert(cond)`.
/// Sets `Xd` to 1 if `cond` holds, 0 otherwise. The c4 comparison
/// ops compile to `cmp + cset`.
pub(super) fn enc_cset(rd: Reg, cond: Cond) -> u32 {
    0x9A80_0400
        | ((Reg::SP.0 as u32) << 16) // Rm = XZR
        | (cond.invert() << 12)
        | ((Reg::SP.0 as u32) << 5)  // Rn = XZR
        | (rd.0 as u32)
}

// ---- Branches. ----

/// `B <label>` -- unconditional branch, PC-relative offset measured
/// in instructions. Same encoding family as `BL` minus the link bit.
pub(super) fn enc_b(imm26: i32) -> u32 {
    debug_assert!(
        (-(1 << 25)..(1 << 25)).contains(&imm26),
        "b: offset {imm26} out of range"
    );
    0x1400_0000 | ((imm26 as u32) & 0x03FF_FFFF)
}

/// `CBZ <Xt>, <label>` -- compare `Xt` with zero and branch if equal.
/// `imm19` is signed, in instructions. +/-1 MiB range.
pub(super) fn enc_cbz(rt: Reg, imm19: i32) -> u32 {
    debug_assert!(
        (-(1 << 18)..(1 << 18)).contains(&imm19),
        "cbz: offset {imm19} out of range (must fit in signed 19 bits)"
    );
    0xB400_0000 | (((imm19 as u32) & 0x7_FFFF) << 5) | (rt.0 as u32)
}

/// `CBNZ <Xt>, <label>` -- branch if `Xt` is not zero.
pub(super) fn enc_cbnz(rt: Reg, imm19: i32) -> u32 {
    debug_assert!(
        (-(1 << 18)..(1 << 18)).contains(&imm19),
        "cbnz: offset {imm19} out of range"
    );
    0xB500_0000 | (((imm19 as u32) & 0x7_FFFF) << 5) | (rt.0 as u32)
}

/// `B.<cond> <label>` -- branch if the NZCV flags satisfy `cond`.
/// `imm19` is signed, in instructions; same +/-1 MiB range as
/// `CBZ`/`CBNZ`. The encoder builds the canonical form
/// `0101_0100 imm19 0 cond`.
pub(super) fn enc_b_cond(cond: Cond, imm19: i32) -> u32 {
    debug_assert!(
        (-(1 << 18)..(1 << 18)).contains(&imm19),
        "b.cond: offset {imm19} out of range (must fit in signed 19 bits)"
    );
    0x5400_0000 | (((imm19 as u32) & 0x7_FFFF) << 5) | (cond as u32)
}

/// `BLR <Xn>` -- branch with link to the address in `Xn`. Used for
/// indirect calls (function pointer through GOT).
pub(super) fn enc_blr(rn: Reg) -> u32 {
    0xD63F_0000 | ((rn.0 as u32) << 5)
}

/// `SVC #imm16` -- supervisor call (system call). On Linux/aarch64
/// the kernel reads the intrinsic number from `x8` and the arguments
/// from `x0..x5`; the immediate is conventionally zero.
pub(super) fn enc_svc(imm16: u16) -> u32 {
    0xD400_0001 | ((imm16 as u32) << 5)
}

// ---- Loads / stores (scaled 12-bit unsigned offset). ----

/// `LDR <Xt>, [<Xn|SP>, #imm]` -- 64-bit load, immediate offset
/// scaled by 8. `imm` is the byte offset; range `[0, 32760]`.
pub(super) fn enc_ldr_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm.is_multiple_of(8), "ldr imm: {imm} not 8-byte aligned");
    let scaled = imm / 8;
    debug_assert!(scaled < 4096, "ldr imm: {imm} > 32760");
    0xF940_0000 | (scaled << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STR <Xt>, [<Xn|SP>, #imm]` -- 64-bit store. Same scaling as `LDR`.
pub(super) fn enc_str_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm.is_multiple_of(8), "str imm: {imm} not 8-byte aligned");
    let scaled = imm / 8;
    debug_assert!(scaled < 4096, "str imm: {imm} > 32760");
    0xF900_0000 | (scaled << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDRB <Wt>, [<Xn|SP>, #imm]` -- byte load, zero-extended into a
/// 32-bit register (which on AArch64 means the high 32 bits of the
/// 64-bit register are also cleared). c4 promotes char to int on
/// load; this matches.
pub(super) fn enc_ldrb_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm < 4096, "ldrb imm: {imm} > 4095");
    0x3940_0000 | (imm << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STRB <Wt>, [<Xn|SP>, #imm]` -- byte store. Stores the low 8 bits
/// of `Wt` and ignores the rest, which is what c4's `Sc` opcode
/// expects.
pub(super) fn enc_strb_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm < 4096, "strb imm: {imm} > 4095");
    0x3900_0000 | (imm << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

// ---- Loads / stores (unscaled 9-bit signed offset). Used for negative
//      stack-frame offsets (locals at fp - N*8).

/// `LDUR <Xt>, [<Xn|SP>, #imm]` -- unscaled 9-bit signed offset.
/// Range `[-256, 255]`. Locals sit at `fp - 8`, `fp - 16`, ... so we
/// reach for this whenever `LDR`'s unsigned scaled form can't fit
/// the negative offset.
pub(super) fn enc_ldur(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!((-256..256).contains(&imm), "ldur imm: {imm} out of range");
    let imm9 = (imm as u32) & 0x1FF;
    0xF840_0000 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STUR <Xt>, [<Xn|SP>, #imm]` -- unscaled 9-bit signed offset.
/// Mirror of [`enc_ldur`].
pub(super) fn enc_stur(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!((-256..256).contains(&imm), "stur imm: {imm} out of range");
    let imm9 = (imm as u32) & 0x1FF;
    0xF800_0000 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

// ---- Pre-/post-indexed loads & stores. The c4 VM stack push/pop
//      compiles to these because they update sp in the same instruction.

/// `STR <Xt>, [<Xn|SP>, #imm]!` -- pre-indexed store with writeback.
/// Use with `imm = -16` for `Op::Psh`: store accumulator and bump sp
/// down by 16 bytes (we keep sp 16-byte aligned even for 8-byte
/// pushes so calls into libc satisfy AAPCS64).
pub(super) fn enc_str_pre(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!(
        (-256..256).contains(&imm),
        "str-pre imm: {imm} out of range"
    );
    let imm9 = (imm as u32) & 0x1FF;
    0xF800_0C00 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDR <Xt>, [<Xn|SP>], #imm` -- post-indexed load with writeback.
/// Mirror for VM pop.
pub(super) fn enc_ldr_post(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!(
        (-256..256).contains(&imm),
        "ldr-post imm: {imm} out of range"
    );
    let imm9 = (imm as u32) & 0x1FF;
    0xF840_0400 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

// ---- Page-relative address load. Pairs with `add xd, xd, #pageoff`
//      to materialize an address relative to the program's load
//      address. Used both for libc-call thunks (the GOT slot lookup)
//      and for data / function-pointer immediates patched by the
//      Mach-O writer.

/// `ADRP <Xd>, <label>` -- load the page-aligned base address of a
/// PC-relative label. `imm21` is signed, in *pages* (4096 bytes).
/// Pair with [`enc_add_imm`] using the in-page offset to get the
/// final address.
pub(super) fn enc_adrp(rd: Reg, imm21: i32) -> u32 {
    debug_assert!(
        (-(1 << 20)..(1 << 20)).contains(&imm21),
        "adrp: page offset {imm21} out of signed 21-bit range"
    );
    let v = (imm21 as u32) & 0x1F_FFFF;
    let immlo = v & 0x3;
    let immhi = (v >> 2) & 0x7_FFFF;
    0x9000_0000 | (immlo << 29) | (immhi << 5) | (rd.0 as u32)
}

/// Build an arbitrary 64-bit immediate into `rd` using a `movz` plus
/// up to three `movk`s. Picks the shortest sequence by skipping
/// 16-bit lanes that are zero.
pub(super) fn load_imm64(code: &mut Vec<u8>, rd: Reg, value: u64) {
    let lanes = [
        (value & 0xFFFF) as u16,
        ((value >> 16) & 0xFFFF) as u16,
        ((value >> 32) & 0xFFFF) as u16,
        ((value >> 48) & 0xFFFF) as u16,
    ];
    let mut emitted = false;
    for (hw, &lane) in lanes.iter().enumerate() {
        if lane == 0 && emitted {
            continue;
        }
        if lane == 0 && !emitted && hw < 3 {
            // Don't burn a movz on a leading zero lane unless every
            // higher lane is also zero -- a later non-zero lane will
            // come along and the movz needs to clear the rest, but
            // if it's all zero we still need at least one movz to
            // zero the register.
            let any_higher = lanes[hw + 1..].iter().any(|&v| v != 0);
            if any_higher {
                continue;
            }
        }
        let word = if !emitted {
            enc_movz(rd, lane, hw as u8)
        } else {
            enc_movk(rd, lane, hw as u8)
        };
        emit(code, word);
        emitted = true;
    }
    // Edge case: value == 0 falls through with `emitted` still false.
    if !emitted {
        emit(code, enc_movz(rd, 0, 0));
    }
}

/// Append a 32-bit instruction to a code buffer in little-endian
/// byte order. Every encoder in this module funnels through here so
/// the byte order can't get accidentally inverted.
pub(super) fn emit(code: &mut Vec<u8>, word: u32) {
    code.extend_from_slice(&word.to_le_bytes());
}

/// Emit `mov <rd>, <rn>` -- but skip the encoding entirely when
/// `rd == rn`, since the move would be a no-op. The lowering pass
/// goes through this helper rather than calling
/// `emit(code, enc_mov_reg(rd, rn))` directly so any case where the
/// destination and source happen to coincide (e.g. a future change
/// that lets the regalloc pool overlap with the accumulator) collapses
/// to zero bytes instead of a wasted instruction.
pub(super) fn emit_mov_reg(code: &mut Vec<u8>, rd: Reg, rn: Reg) {
    if rd == rn {
        return;
    }
    emit(code, enc_mov_reg(rd, rn));
}

// ---- Branch fixups. Bytecode branches target absolute bytecode PCs;
//      the native PC of those targets isn't known until after the
//      whole function body is laid out. Two-pass approach: emit a
//      placeholder branch instruction, record (its native offset, the
//      target bytecode PC, the kind), then patch the placeholder
//      after lowering completes.

#[derive(Debug, Clone, Copy)]
enum BranchKind {
    /// Unconditional `B` (PC-relative, 26-bit signed offset).
    B,
    /// Conditional `CBZ <Xt>` (compare-and-branch on zero).
    Cbz(Reg),
    /// Conditional `CBNZ <Xt>`.
    Cbnz(Reg),
    /// `B.<cond>` -- conditional branch reading the NZCV flags.
    /// Emitted by the cmp+branch fusion peephole.
    Bcc(Cond),
    /// `BL` for direct subroutine calls. Same encoding family as `B`,
    /// distinguished only by the link bit.
    Bl,
}

#[derive(Debug, Clone, Copy)]
struct Fixup {
    /// Byte offset within `code` where the placeholder branch lives.
    native_offset: usize,
    /// Bytecode PC the branch is supposed to land on.
    target_bytecode_pc: usize,
    kind: BranchKind,
}

/// Mark every bytecode PC that is the target of some `Jmp` / `Bz` /
/// `Bnz` (or, defensively, `Jsr` -- those land on `Op::Ent` so they
/// can't collide with the cmp+branch peephole, but the scan is
/// cheap and the bit map is shared). Returned `Vec<bool>` is
/// indexed by bytecode PC; the cmp+branch fusion peephole consults
/// it to skip fusion when the matching `Bz`/`Bnz` PC is reachable
/// from elsewhere (a branch into the `Bz` would land on a
/// flags-reading `b.cond` whose flags came from unrelated code,
/// which would silently miscompile).
fn collect_branch_targets(text: &[i64]) -> Vec<bool> {
    let mut targets = vec![false; text.len() + 1];
    let mut pc = 0usize;
    while pc < text.len() {
        let Some(op) = Op::from_i64(text[pc]) else {
            break;
        };
        match op {
            Op::Jmp | Op::Bz | Op::Bnz | Op::Jsr if pc + 1 < text.len() => {
                let target = text[pc + 1] as usize;
                if target < targets.len() {
                    targets[target] = true;
                }
            }
            _ => {}
        }
        // Same op_width logic as the regalloc analyzer.
        pc += match op {
            Op::Lea
            | Op::Imm
            | Op::Jmp
            | Op::Jsr
            | Op::Bz
            | Op::Bnz
            | Op::Ent
            | Op::Adj
            | Op::AddI
            | Op::SubI
            | Op::MulI
            | Op::AndI
            | Op::OrI
            | Op::XorI
            | Op::ShlI
            | Op::ShrI
            | Op::EqI
            | Op::NeI
            | Op::LtI
            | Op::GtI
            | Op::LeI
            | Op::GeI
            | Op::LdLocI
            | Op::LdLocC => 2,
            _ => 1,
        };
    }
    targets
}

/// Decide whether a compare op at `next_pc - <its_width>` can fuse
/// with the immediately following op. Returns the c4-`Bz` /
/// c4-`Bnz` opcode if all of:
///
/// * the next op is `Bz`/`Bnz`,
/// * landing on the `Bz`/`Bnz` from elsewhere is impossible (so a
///   `b.cond` reading flags from this compare can't be reached
///   from a branch that bypassed the compare),
/// * the `Bz`/`Bnz` taken-target op writes `x19` before reading,
///   AND the fall-through op does the same.
///
/// The last gate exists because eliding the `cset` leaves `x19`
/// holding the rhs of the compare instead of the 0/1 boolean. c4
/// short-circuit patterns (`a && b`, `a || b`) make the matching
/// `Bz`/`Bnz` jump to a *second* `Bz`/`Bnz` that reads `x19` as
/// the boolean -- that downstream op would silently miscompile if
/// we elided the `cset`. Same hazard if the fall-through path
/// returns the boolean directly via `Lev`. The target/fall-through
/// whitelist is conservative: only ops whose lowering writes `x19`
/// before any read pass.
///
/// `next_pc` is the bytecode PC of the candidate `Bz`/`Bnz`, i.e.
/// `*pc` after the compare op consumed itself.
fn fusion_candidate(text: &[i64], next_pc: usize, branch_targets: &[bool]) -> Option<Op> {
    let raw = *text.get(next_pc)?;
    let next_op = Op::from_i64(raw)?;
    if !matches!(next_op, Op::Bz | Op::Bnz) {
        return None;
    }
    if branch_targets.get(next_pc).copied().unwrap_or(false) {
        // Some other branch lands on this Bz/Bnz; we can't elide
        // the cset since that path would arrive with stale flags.
        return None;
    }
    // Bz/Bnz are 2-word ops (opcode + target operand).
    let target_pc = (*text.get(next_pc + 1)?) as usize;
    let target_op = Op::from_i64(*text.get(target_pc)?)?;
    let fallthrough_op = Op::from_i64(*text.get(next_pc + 2)?)?;
    if !writes_x19_first(target_op) || !writes_x19_first(fallthrough_op) {
        return None;
    }
    Some(next_op)
}

/// Set of c4 ops whose aarch64 lowering writes `x19` before reading
/// any prior value. Used as the safety gate for the cmp+branch
/// fusion peephole: the fused compare op leaves `x19` holding the
/// rhs of the compare (no `cset` runs), so the matching branch's
/// taken-target and fall-through paths must each kick off with an
/// op that overwrites `x19`. Anything else (Bz/Bnz/Lev/Si/binops/
/// etc.) reads the stale value first and miscompiles.
fn writes_x19_first(op: Op) -> bool {
    use Op::*;
    matches!(
        op,
        // Materialise a value into x19.
        Imm | Lea
        // Fused local load: writes x19 unconditionally.
        | LdLocI | LdLocC
        // Direct call: `bl <target>; mov x19, x0`. The bl reads no
        // x19-derived state, and the trailing mov overwrites x19.
        | Jsr
        // libc thunks: load args from stack offsets (x19-independent),
        // call libc, then `mov x19, x0`. x19 is overwritten before
        // any subsequent c4 op observes it.
        | Open | Read | Clos | Prtf | Malc | Free
        | Mset | Mcmp | Mcpy | Exit | Write
        | Genv | Senv | Dlop | Dlsm | Dlcl | Dler
    )
}

/// Lower a bytecode [`Program`] to AArch64 machine code. Walks the
/// bytecode once, emitting native code for each op; control-flow ops
/// emit a placeholder branch and record a fixup to be patched after
/// the whole layout is known.
///
/// Calling convention (Phase 1):
/// * VM accumulator `a` lives in `x19` (callee-saved across calls).
/// * The VM stack rides on the native stack: `Op::Psh` is `str x19,
///   [sp, #-16]!`, every binary op pops with `ldr <tmp>, [sp], #16`.
///   Push slots are 16 bytes (not 8) so SP stays aligned for libc calls.
/// * `x16`/`x17` (IP0/IP1) are the AAPCS64-blessed temporaries we use
///   for popped operands and large-immediate scratch.
/// * Each function's prologue is the standard AAPCS64 sequence;
///   epilogue moves `x19` into `x0` (the return register).
/// * `main`'s prologue additionally pushes `x0` and `x1` (argc/argv,
///   passed by libdyld) so the c4-style `Lea 2` / `Lea 3` lookups
///   land on them.
///
/// Syscall ops (`Open`...`Senv`) lower to `adrp + ldr + blr` through
/// a __got slot the writer fills in at link time.
pub(super) fn lower(
    program: &Program,
    target: Target,
    native: NativeOptions,
) -> Result<Build, C4Error> {
    let options = target.options();

    // Run the regalloc analyzer once if `--optimize` is on. The
    // plan is consulted at each Op::Ent / Op::Psh / pop op so we
    // keep it in scope for the entire walk.
    let plan_storage: Option<RegStackPlan> = if native.optimize {
        Some(regalloc::analyze(&program.text, POOL_SIZES)?)
    } else {
        None
    };
    let plan: Option<&RegStackPlan> = plan_storage.as_ref();
    let mut reg_state = RegState::new(native.optimize, plan);

    // Pre-scan for branch targets so the cmp+branch fusion peephole
    // can refuse to fuse when the matching Bz/Bnz is reachable from
    // anywhere else. Cheap: one linear walk of `text`.
    let branch_targets = collect_branch_targets(&program.text);

    let mut code = Vec::new();
    let mut bytecode_to_native: Vec<usize> = vec![usize::MAX; program.text.len() + 1];
    let mut fixups: Vec<Fixup> = Vec::new();
    let mut got_fixups: Vec<GotFixup> = Vec::new();
    let mut data_fixups: Vec<DataFixup> = Vec::new();
    // Function-pointer Imms get their target resolved post-walk against
    // `bytecode_to_native`, so we record (adrp_offset, target_bytecode_pc)
    // here and rewrite into `Build::func_fixups` once the map is final.
    let mut pending_func_fixups: Vec<(usize, usize)> = Vec::new();

    // Compiler's data-Imm side channel as a sorted slice (binary search
    // is fine -- this list grows linearly with the number of distinct
    // string-literal / global references in the program).
    let data_imm_positions: &[usize] = &program.data_imm_positions;

    // Track which function we're currently inside so the prologue
    // and epilogue agree on whether to push/pop the argc/argv pair.
    // c4 doesn't mark function boundaries explicitly -- we assume
    // every Ent starts a new function and we're "in" that function
    // until the next Ent.
    let mut in_main = false;

    let mut pc = 0usize;
    while pc < program.text.len() {
        let op_pc = pc;
        bytecode_to_native[op_pc] = code.len();
        let raw = program.text[pc];
        let op = Op::from_i64(raw).ok_or_else(|| {
            C4Error::Compile(format!("native codegen: bad opcode at PC {pc}: {raw}"))
        })?;
        pc += 1;
        if matches!(op, Op::Ent) {
            in_main = op_pc == program.entry_pc;
            // Clear any cmp+branch fusion state; pending_cmp_cond
            // is only legal for the immediate gap between a compare
            // op and its matching Bz/Bnz, never across a function
            // boundary.
            reg_state.pending_cmp_cond = None;
            // Refresh per-function regalloc state. With no plan,
            // both stay at their default (use_pool=false, depth=0).
            if let Some(p) = reg_state.plan {
                if let Some(f) = p.function_at(op_pc) {
                    reg_state.use_pool = f.use_pool;
                    reg_state.current_callee_depth = if f.use_pool { f.callee_depth } else { 0 };
                } else {
                    // Should be unreachable -- analyzer records every Ent --
                    // but stay correct rather than panicking.
                    reg_state.use_pool = false;
                    reg_state.current_callee_depth = 0;
                }
                debug_assert!(
                    reg_state.pseudo_stack.is_empty(),
                    "pseudo stack non-empty at fn entry"
                );
            }
        }
        lower_op(
            op,
            &program.text,
            &mut pc,
            &mut code,
            &mut fixups,
            &mut got_fixups,
            &mut data_fixups,
            &mut pending_func_fixups,
            data_imm_positions,
            in_main,
            options,
            &mut reg_state,
            op_pc,
            &branch_targets,
        )?;
    }
    bytecode_to_native[program.text.len()] = code.len();

    apply_fixups(&mut code, &fixups, &bytecode_to_native, program.text.len())?;

    // Resolve pending function-pointer fixups now that the bytecode-to-
    // native map is complete.
    let mut func_fixups: Vec<FuncFixup> = Vec::with_capacity(pending_func_fixups.len());
    for (adrp_offset, target_bc_pc) in pending_func_fixups {
        if target_bc_pc > program.text.len() {
            return Err(C4Error::Compile(format!(
                "native codegen: function pointer target {target_bc_pc} past end of bytecode"
            )));
        }
        let target = bytecode_to_native[target_bc_pc];
        if target == usize::MAX {
            return Err(C4Error::Compile(format!(
                "native codegen: function pointer target {target_bc_pc} did not land on an instruction"
            )));
        }
        func_fixups.push(FuncFixup {
            adrp_offset,
            target_native_offset: target,
        });
    }

    let entry_offset = bytecode_to_native
        .get(program.entry_pc)
        .copied()
        .ok_or_else(|| {
            C4Error::Compile(format!(
                "native codegen: entry_pc {} is out of bytecode range",
                program.entry_pc
            ))
        })?;
    if entry_offset == usize::MAX {
        return Err(C4Error::Compile(format!(
            "native codegen: entry_pc {} did not align with any instruction start",
            program.entry_pc
        )));
    }

    Ok(Build {
        text: code,
        data: program.data.clone(),
        entry_offset,
        got_fixups,
        data_fixups,
        func_fixups,
        bytecode_to_native,
    })
}

/// Read the i64 operand following an opcode, advancing `pc` past it.
fn read_operand(text: &[i64], pc: &mut usize, op_name: &str) -> Result<i64, C4Error> {
    if *pc >= text.len() {
        return Err(C4Error::Compile(format!(
            "native codegen: {op_name} missing operand at end of bytecode"
        )));
    }
    let v = text[*pc];
    *pc += 1;
    Ok(v)
}

/// Walk through the patch list, computing the actual native offset
/// of each branch's target and writing the encoded instruction back
/// into `code` over the placeholder we left.
fn apply_fixups(
    code: &mut [u8],
    fixups: &[Fixup],
    bc_to_native: &[usize],
    bc_len: usize,
) -> Result<(), C4Error> {
    for f in fixups {
        if f.target_bytecode_pc > bc_len {
            return Err(C4Error::Compile(format!(
                "native codegen: branch target {} past end of bytecode",
                f.target_bytecode_pc
            )));
        }
        let target = bc_to_native[f.target_bytecode_pc];
        if target == usize::MAX {
            return Err(C4Error::Compile(format!(
                "native codegen: branch target {} did not land on an instruction",
                f.target_bytecode_pc
            )));
        }
        let pc_after = f.native_offset as isize;
        let delta_bytes = target as isize - pc_after;
        // All AArch64 branches measure the offset in instructions
        // (4 bytes each).
        if delta_bytes & 3 != 0 {
            return Err(C4Error::Compile(format!(
                "native codegen: branch delta {delta_bytes} not 4-byte aligned"
            )));
        }
        let delta_insns = (delta_bytes / 4) as i32;
        let word = match f.kind {
            BranchKind::B => enc_b(delta_insns),
            BranchKind::Cbz(rt) => enc_cbz(rt, delta_insns),
            BranchKind::Cbnz(rt) => enc_cbnz(rt, delta_insns),
            BranchKind::Bcc(cond) => enc_b_cond(cond, delta_insns),
            BranchKind::Bl => enc_bl(delta_insns),
        };
        code[f.native_offset..f.native_offset + 4].copy_from_slice(&word.to_le_bytes());
    }
    Ok(())
}

/// Lower one bytecode op. Hot-path helpers for common patterns
/// (`pop into x16`, `binop pop+combine`, etc.) live below.
#[allow(clippy::too_many_arguments)]
fn lower_op(
    op: Op,
    text: &[i64],
    pc: &mut usize,
    code: &mut Vec<u8>,
    fixups: &mut Vec<Fixup>,
    got_fixups: &mut Vec<GotFixup>,
    data_fixups: &mut Vec<DataFixup>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    data_imm_positions: &[usize],
    in_main: bool,
    options: TargetOptions,
    reg_state: &mut RegState<'_>,
    op_pc: usize,
    branch_targets: &[bool],
) -> Result<(), C4Error> {
    match op {
        // ---- Function frame ----
        Op::Ent => {
            let locals = read_operand(text, pc, "Ent")?;
            emit_prologue(code, locals, in_main, reg_state.current_callee_depth);
        }
        Op::Lev => emit_epilogue(code, in_main, reg_state.current_callee_depth),
        Op::Adj => {
            // Adj N drops N pushed slots (each slot is 16 bytes on
            // our native stack -- see Op::Psh below for why). With
            // the regalloc plan in play, the analyzer guarantees
            // every slot popped here was a Real (real-stack) push;
            // we still update the runtime tracker so the per-op
            // "what's on top of the pseudo-stack" picture stays
            // consistent.
            let n = read_operand(text, pc, "Adj")?;
            if n != 0 {
                let bytes = (n as u32) * 16;
                emit(code, enc_add_imm(Reg::SP, Reg::SP, bytes));
            }
            for _ in 0..(n as usize) {
                let popped = reg_state.pseudo_stack.pop();
                debug_assert!(
                    matches!(popped, None | Some(None)),
                    "Adj popped a Pseudo slot -- analyzer mis-classified"
                );
            }
        }

        // ---- Constants and addresses ----
        Op::Imm => {
            // The operand sits at `*pc` *before* read_operand bumps it;
            // the side channel uses that index, so capture it first.
            let operand_pc = *pc;
            let v = read_operand(text, pc, "Imm")?;
            if data_imm_positions.binary_search(&operand_pc).is_ok() {
                // Address of a string literal or global. Emit ADRP+ADD
                // placeholders against `__data + v`; the writer fills
                // in the page-relative immediates.
                let adrp_offset = code.len();
                data_fixups.push(DataFixup {
                    adrp_offset,
                    data_offset: v as u64,
                });
                emit_adrp_add_placeholder(code);
            } else if (v as usize) >= CODE_BASE && ((v as usize) - CODE_BASE) < text.len() {
                // Function-pointer literal. Resolve after the walk so
                // we can map the bytecode PC to a native offset.
                let target_bc_pc = (v as usize) - CODE_BASE;
                let adrp_offset = code.len();
                pending_func_fixups.push((adrp_offset, target_bc_pc));
                emit_adrp_add_placeholder(code);
            } else {
                load_imm64(code, Reg::X19, v as u64);
            }
        }
        Op::Lea => {
            // c4 emits `Lea` offsets in 8-byte units (its VM uses one
            // 8-byte slot per push and per local). Our native stack
            // pushes 16 bytes per arg slot for AAPCS64 alignment, so
            // for the args region (val >= 2) we use 16-byte spacing
            // instead. Locals (val < 0) stay 8-byte. See `lea_offset`.
            let offset = read_operand(text, pc, "Lea")?;
            let signed_bytes = lea_offset_bytes(offset);
            let abs = signed_bytes.unsigned_abs();
            if abs < 4096 {
                let imm = abs as u32;
                let word = if signed_bytes >= 0 {
                    enc_add_imm(Reg::X19, Reg::X29, imm)
                } else {
                    enc_sub_imm(Reg::X19, Reg::X29, imm)
                };
                emit(code, word);
            } else {
                load_imm64(code, Reg::X16, abs);
                let word = if signed_bytes >= 0 {
                    enc_add_reg(Reg::X19, Reg::X29, Reg::X16)
                } else {
                    enc_sub_reg(Reg::X19, Reg::X29, Reg::X16)
                };
                emit(code, word);
            }
        }

        // ---- Memory loads / stores ----
        Op::Li => emit(code, enc_ldr_imm(Reg::X19, Reg::X19, 0)),
        Op::Lc => emit(code, enc_ldrb_imm(Reg::X19, Reg::X19, 0)),
        Op::Si => {
            // pop addr; *addr = x19. With pool: addr is in xN
            // (skip the ldr). Without pool: pop from real stack.
            let lhs = pop_lhs_reg(code, reg_state);
            emit(code, enc_str_imm(Reg::X19, lhs, 0));
        }
        Op::Sc => {
            let lhs = pop_lhs_reg(code, reg_state);
            emit(code, enc_strb_imm(Reg::X19, lhs, 0));
        }
        Op::Psh => {
            // With the native optimizer on AND a Pseudo classification
            // for this PC, materialise the push as `mov xN, x19`
            // into the assigned pool slot. The bank decides which
            // physical register: callee-saved (x20+) for slots that
            // outlive a call, caller-saved (x9+) for slots that
            // don't (no spill needed since they're allocated only
            // when never live across a call).
            let slot_and_bank = reg_state
                .use_pool
                .then(|| {
                    reg_state
                        .plan
                        .and_then(|p| p.push_kind(op_pc))
                        .and_then(|k| match k {
                            PushKind::Pseudo { slot, bank } => Some((slot, bank)),
                            PushKind::Real => None,
                        })
                })
                .flatten();
            match slot_and_bank {
                Some((s, bank)) => {
                    emit_mov_reg(code, pool_reg(s, bank), Reg::X19);
                    reg_state.pseudo_stack.push(Some((s, bank)));
                }
                None => {
                    // 16 bytes per push so that SP stays 16-byte
                    // aligned -- any libc call we make later
                    // (`Op::Prtf` etc.) needs that, and re-aligning
                    // on every call would be a wash.
                    emit(code, enc_str_pre(Reg::X19, Reg::SP, -16));
                    reg_state.pseudo_stack.push(None);
                }
            }
        }

        // ---- Bitwise ----
        Op::Or => binop_with_pop(code, reg_state, enc_orr_reg),
        Op::Xor => binop_with_pop(code, reg_state, enc_eor_reg),
        Op::And => binop_with_pop(code, reg_state, enc_and_reg),

        // ---- Comparisons. The c4 VM does `popped <cmp> a`, which
        //      maps to `cmp lhs, x19; cset x19, <cond>`. With the
        //      cmp+branch fusion peephole, when the next op is
        //      `Bz`/`Bnz` (and not a branch target), we skip the
        //      `cset` and stash the condition for the branch op
        //      to consume as a `b.cond`.
        Op::Eq => lower_cmp(code, text, *pc, reg_state, branch_targets, Cond::Eq),
        Op::Ne => lower_cmp(code, text, *pc, reg_state, branch_targets, Cond::Ne),
        Op::Lt => lower_cmp(code, text, *pc, reg_state, branch_targets, Cond::Lt),
        Op::Gt => lower_cmp(code, text, *pc, reg_state, branch_targets, Cond::Gt),
        Op::Le => lower_cmp(code, text, *pc, reg_state, branch_targets, Cond::Le),
        Op::Ge => lower_cmp(code, text, *pc, reg_state, branch_targets, Cond::Ge),

        // ---- Shifts (signed >> matches c4 `int` semantics). ----
        Op::Shl => binop_with_pop(code, reg_state, enc_lslv),
        Op::Shr => binop_with_pop(code, reg_state, enc_asrv),

        // ---- Arithmetic. Sub, Div, Mod are not commutative, so the
        //      pop goes on the LHS of the operation.
        Op::Add => binop_with_pop(code, reg_state, enc_add_reg),
        Op::Sub => binop_with_pop(code, reg_state, enc_sub_reg),
        Op::Mul => binop_with_pop(code, reg_state, enc_mul),
        Op::Div => binop_with_pop(code, reg_state, enc_sdiv),
        Op::Mod => {
            // pop lhs; x17 = lhs / x19; x19 = lhs - x17 * x19.
            let lhs = pop_lhs_reg(code, reg_state);
            emit(code, enc_sdiv(Reg::X17, lhs, Reg::X19));
            emit(code, enc_msub(Reg::X19, Reg::X17, Reg::X19, lhs));
        }

        // ---- Control flow ----
        Op::Jmp => {
            let target = read_operand(text, pc, "Jmp")? as usize;
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind: BranchKind::B,
            });
            emit(code, 0); // placeholder, patched in apply_fixups
        }
        Op::Bz => {
            let target = read_operand(text, pc, "Bz")? as usize;
            // Fusion: if the previous compare op stashed a
            // condition, emit `b.<flip(cond)>` instead of
            // `cbz x19`. Bz tests for "boolean was 0" which is
            // "the compare condition did NOT hold".
            let kind = match reg_state.pending_cmp_cond.take() {
                Some(cond) => BranchKind::Bcc(cond.flip()),
                None => BranchKind::Cbz(Reg::X19),
            };
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind,
            });
            emit(code, 0);
        }
        Op::Bnz => {
            let target = read_operand(text, pc, "Bnz")? as usize;
            // Fusion: Bnz tests for "boolean was 1" which is "the
            // compare condition held" -- same condition as the
            // compare itself.
            let kind = match reg_state.pending_cmp_cond.take() {
                Some(cond) => BranchKind::Bcc(cond),
                None => BranchKind::Cbnz(Reg::X19),
            };
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind,
            });
            emit(code, 0);
        }
        Op::Jsr => {
            let target = read_operand(text, pc, "Jsr")? as usize;
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind: BranchKind::Bl,
            });
            emit(code, 0);
            // The called function's epilogue moved its return value
            // into x0. Copy it back into x19 so the caller continues
            // with `a` set to the return value, matching VM semantics.
            emit_mov_reg(code, Reg::X19, Reg::X0);
        }
        Op::Jsri => {
            // Indirect call: target address in x19, args already
            // pushed onto the VM stack in 16-byte slots by preceding
            // Op::Psh's. The callee may be a c4 function (reads args
            // from `bp + offset` via Op::Lea) or a native libc
            // function obtained via dlsym (reads args from x0..x7).
            // To work for both, peek at the next instruction for the
            // arg count (c4 emits an Op::Adj after every non-zero-arg
            // call) and load args into x0..x7 *in addition to* leaving
            // them on the stack. c4 callees ignore the registers; libc
            // callees ignore the stack.
            let nargs = match Op::from_i64(text.get(*pc).copied().unwrap_or(0)) {
                Some(Op::Adj) => text[*pc + 1] as usize,
                _ => 0,
            };
            if nargs > 8 {
                return Err(C4Error::Compile(format!(
                    "native codegen: Jsri arg count {nargs} exceeds 8 (x0..x7)"
                )));
            }
            for i in 0..nargs {
                let off = ((nargs - 1 - i) as u32) * 16;
                emit(code, enc_ldr_imm(Reg(i as u8), Reg::SP, off));
            }
            // Move the function pointer into x16 so the callee's
            // prologue/epilogue can't trample our accumulator slot.
            emit_mov_reg(code, Reg::X16, Reg::X19);
            emit(code, enc_blr(Reg::X16));
            emit_mov_reg(code, Reg::X19, Reg::X0);
        }

        // ---- Immediate-form arithmetic / comparison (optimizer-emitted).
        //      All of them resolve to "load operand into x16 then run
        //      the register-form encoder against x19". Comparisons
        //      additionally do cmp+cset.
        Op::AddI => imm_arith(code, text, pc, "AddI", enc_add_reg)?,
        Op::SubI => imm_arith(code, text, pc, "SubI", enc_sub_reg)?,
        Op::MulI => imm_arith(code, text, pc, "MulI", enc_mul)?,
        Op::AndI => imm_arith(code, text, pc, "AndI", enc_and_reg)?,
        Op::OrI => imm_arith(code, text, pc, "OrI", enc_orr_reg)?,
        Op::XorI => imm_arith(code, text, pc, "XorI", enc_eor_reg)?,
        Op::ShlI => imm_arith(code, text, pc, "ShlI", enc_lslv)?,
        Op::ShrI => imm_arith(code, text, pc, "ShrI", enc_asrv)?,
        Op::EqI => imm_cmp(code, text, pc, "EqI", Cond::Eq, reg_state, branch_targets)?,
        Op::NeI => imm_cmp(code, text, pc, "NeI", Cond::Ne, reg_state, branch_targets)?,
        Op::LtI => imm_cmp(code, text, pc, "LtI", Cond::Lt, reg_state, branch_targets)?,
        Op::GtI => imm_cmp(code, text, pc, "GtI", Cond::Gt, reg_state, branch_targets)?,
        Op::LeI => imm_cmp(code, text, pc, "LeI", Cond::Le, reg_state, branch_targets)?,
        Op::GeI => imm_cmp(code, text, pc, "GeI", Cond::Ge, reg_state, branch_targets)?,
        Op::LdLocI => {
            // `Lea N + Li` fused. a = *(bp + N*8)
            let offset = read_operand(text, pc, "LdLocI")?;
            emit_local_load(code, offset, /*byte=*/ false);
        }
        Op::LdLocC => {
            let offset = read_operand(text, pc, "LdLocC")?;
            emit_local_load(code, offset, /*byte=*/ true);
        }

        // ---- Syscalls -- lower to a libc call through __got. ----
        Op::Open
        | Op::Read
        | Op::Clos
        | Op::Prtf
        | Op::Malc
        | Op::Free
        | Op::Mset
        | Op::Mcmp
        | Op::Mcpy
        | Op::Exit
        | Op::Write
        | Op::Genv
        | Op::Senv
        | Op::Dlop
        | Op::Dlsm
        | Op::Dlcl
        | Op::Dler => emit_libc_call(op, text, *pc, code, got_fixups, options)?,
    }
    Ok(())
}

/// Lower a intrinsic op to a libc call. Args were already pushed onto
/// our 16-byte VM stack slots by the c4 emitter; we *peek* (not pop)
/// to load them into x0..x7. The c4 emitter follows every call with
/// `Op::Adj N` which the next loop iteration will lower into the SP
/// adjustment that drops them.
///
/// Variadic functions (`printf`) need extra setup: AAPCS64 on macOS
/// puts variadic args entirely on the native stack at SP, 8-byte
/// spaced -- not on the 16-byte slots we used for VM pushes. So
/// `printf("%d %d", a, b)` looks like:
///   * x0 = format
///   * sub sp, sp, #16        (room for 2 8-byte slots, padded to 16)
///   * str a, [sp, #0]
///   * str b, [sp, #8]
///   * call printf
///   * add sp, sp, #16        (free that scratch)
fn emit_libc_call(
    op: Op,
    text: &[i64],
    pc_after_op: usize,
    code: &mut Vec<u8>,
    got_fixups: &mut Vec<GotFixup>,
    options: TargetOptions,
) -> Result<(), C4Error> {
    let import_index = import_index_for_op(op)
        .ok_or_else(|| C4Error::Compile(format!("native codegen: no import index for {op:?}")))?;

    // Peek at the next instruction; if it's Adj N, that gives us the
    // arg count. The c4 compiler omits the Adj when the call has zero
    // args, and also for `Op::Exit` (1 arg, never returns), so both
    // need their own dispatch here.
    let arg_count = match Op::from_i64(text.get(pc_after_op).copied().unwrap_or(0)) {
        Some(Op::Adj) => text[pc_after_op + 1] as usize,
        _ if matches!(op, Op::Exit) => 1,
        _ if matches!(op, Op::Dler) => 0,
        _ => {
            return Err(C4Error::Compile(format!(
                "native codegen: {op:?} not followed by Adj"
            )));
        }
    };
    if arg_count > 8 {
        return Err(C4Error::Compile(format!(
            "native codegen: {op:?} arg count {arg_count} out of supported range (0..=8)"
        )));
    }

    // macOS arm64 has a non-standard variadic ABI that puts the
    // variadic args on the stack rather than in x0..x7. Standard
    // AAPCS64 (Linux) treats variadic args identically to fixed ones,
    // so the register-loading path handles both.
    let is_variadic = matches!(op, Op::Prtf) && options.variadic_on_stack;

    if is_variadic {
        // Format string is the first c4 arg = deepest on the stack.
        // c4 pushes left-to-right, so the deepest slot is at
        // sp + (arg_count-1)*16.
        let format_off = ((arg_count - 1) as u32) * 16;
        emit(code, enc_ldr_imm(Reg::X0, Reg::SP, format_off));

        let n_var = arg_count - 1;
        if n_var > 0 {
            // Pack the variadic args into a fresh stack region. macOS
            // arm64 wants 8-byte spacing for variadic args; we still
            // need to keep SP 16-byte aligned overall.
            let scratch_bytes = ((n_var * 8 + 15) & !15) as u32;
            emit(code, enc_sub_imm(Reg::SP, Reg::SP, scratch_bytes));
            for i in 0..n_var {
                // arg index from the c4 viewpoint: 1, 2, ..., n_var.
                // Stack offset of c4-arg-K (post sub): scratch_bytes
                // + (arg_count - 1 - K) * 16.
                let c4_arg_index = i + 1;
                let src = scratch_bytes + ((arg_count - 1 - c4_arg_index) as u32) * 16;
                emit(code, enc_ldr_imm(Reg::X16, Reg::SP, src));
                // Variadic packed slot: i*8 from new SP.
                emit(code, enc_str_imm(Reg::X16, Reg::SP, (i * 8) as u32));
            }
            emit_got_call(code, got_fixups, import_index);
            emit(code, enc_add_imm(Reg::SP, Reg::SP, scratch_bytes));
        } else {
            emit_got_call(code, got_fixups, import_index);
        }
    } else {
        // Non-variadic: each c4 arg goes into the matching xN.
        // c4-arg-K is at sp + (arg_count - 1 - K) * 16.
        for i in 0..arg_count {
            let off = ((arg_count - 1 - i) as u32) * 16;
            emit(code, enc_ldr_imm(Reg(i as u8), Reg::SP, off));
        }
        emit_got_call(code, got_fixups, import_index);
    }

    if matches!(op, Op::Exit) {
        // exit() doesn't return; the call above will tear down the
        // process. But the c4 compiler emits no Adj after Op::Exit,
        // so we must pop the arg ourselves to keep SP balanced for
        // any stale code after.
        emit(code, enc_add_imm(Reg::SP, Reg::SP, 16));
    } else {
        // Move the libc return value into x19 so the caller sees it
        // as the new accumulator.
        emit_mov_reg(code, Reg::X19, Reg::X0);
    }
    Ok(())
}

/// Emit a placeholder `adrp x19, 0; add x19, x19, #0` pair that
/// materializes a PC-relative absolute address into the VM accumulator.
/// The writer patches both immediates once the target's vmaddr is
/// known. We still emit valid skeleton bytes (rd = x19 in both halves)
/// so an unpatched binary disassembles cleanly for debugging.
fn emit_adrp_add_placeholder(code: &mut Vec<u8>) {
    emit(code, enc_adrp(Reg::X19, 0));
    emit(code, enc_add_imm(Reg::X19, Reg::X19, 0));
}

/// Emit `adrp x16, GOT_PAGE; ldr x16, [x16, #GOT_OFF]; blr x16` --
/// the standard macOS PC-relative GOT call sequence. Both the adrp
/// and the ldr are placeholders; the writer patches them once the
/// data segment vmaddr is known.
fn emit_got_call(code: &mut Vec<u8>, got_fixups: &mut Vec<GotFixup>, import_index: usize) {
    let adrp_offset = code.len();
    got_fixups.push(GotFixup {
        adrp_offset,
        import_index,
    });
    // adrp + ldr placeholder -- patched later. We still emit valid
    // skeleton bytes (with rd = x16) so an unpatched binary at least
    // reads as adrp+ldr in disassembly.
    emit(code, enc_adrp(Reg::X16, 0));
    emit(code, enc_ldr_imm(Reg::X16, Reg::X16, 0));
    emit(code, enc_blr(Reg::X16));
}

/// Pop the top of the VM push-stack -- either a pool register `xN`
/// or `x16` after a `ldr` from the real stack -- and return whatever
/// register now holds the LHS value. Updates `reg_state.pseudo_stack`.
///
/// The choice between the two paths is per-Psh, recorded by the
/// analyzer in `reg_state.pseudo_stack`. With the native optimizer
/// off, every push went to the real stack and this function is
/// exactly the old `ldr x16, [sp], 16` sequence.
fn pop_lhs_reg(code: &mut Vec<u8>, reg_state: &mut RegState<'_>) -> Reg {
    match reg_state.pseudo_stack.pop() {
        Some(Some((slot, bank))) => {
            // Value lives in a pool register; nothing to emit.
            // The slot itself stays valid for re-use on the next
            // push (slot allocation is a depth counter, not a
            // free-list).
            pool_reg(slot, bank)
        }
        // Real stack push -- the existing path.
        Some(None) | None => {
            emit(code, enc_ldr_post(Reg::X16, Reg::SP, 16));
            Reg::X16
        }
    }
}

/// Pop the LHS, then run a register-form encoder against (x19, lhs,
/// x19) to produce `x19 = lhs OP x19`. The c4 VM has the popped
/// value as the LHS for sub / div / shifts; for the commutative ops
/// the operand order doesn't matter.
fn binop_with_pop<F: Fn(Reg, Reg, Reg) -> u32>(
    code: &mut Vec<u8>,
    reg_state: &mut RegState<'_>,
    enc: F,
) {
    let lhs = pop_lhs_reg(code, reg_state);
    emit(code, enc(Reg::X19, lhs, Reg::X19));
}

/// Pop the LHS, compare against x19, condition-set into x19.
fn cmp_with_pop(code: &mut Vec<u8>, reg_state: &mut RegState<'_>, cond: Cond) {
    let lhs = pop_lhs_reg(code, reg_state);
    emit(code, enc_cmp_reg(lhs, Reg::X19));
    emit(code, enc_cset(Reg::X19, cond));
}

/// Lower a register-register compare op (`Lt`/`Eq`/...). When the
/// next bytecode op is `Bz`/`Bnz` and the peephole gate
/// ([`fusion_candidate`]) clears it, emit `cmp` only and stash the
/// condition in `reg_state.pending_cmp_cond` for the matching
/// branch op to consume as a `b.cond`. Otherwise fall back to
/// `cmp + cset`.
///
/// `next_pc` is the bytecode PC of the next op (i.e. `*pc` after
/// the compare op consumed itself; the compare ops are 1-word, so
/// the caller has already advanced `*pc` to point past).
fn lower_cmp(
    code: &mut Vec<u8>,
    text: &[i64],
    next_pc: usize,
    reg_state: &mut RegState<'_>,
    branch_targets: &[bool],
    cond: Cond,
) {
    let lhs = pop_lhs_reg(code, reg_state);
    emit(code, enc_cmp_reg(lhs, Reg::X19));
    if fusion_candidate(text, next_pc, branch_targets).is_some() {
        // Skip cset; the matching Bz/Bnz will read flags via b.cond.
        reg_state.pending_cmp_cond = Some(cond);
    } else {
        emit(code, enc_cset(Reg::X19, cond));
    }
}

/// Optimizer-emitted `<op>I N` lowering: load `N` into x16, then run
/// the register-form encoder. A future enhancement could fold small
/// `N` into the immediate form of add/sub directly; for now we keep
/// the 1-instruction-per-immediate-op count predictable.
fn imm_arith<F: Fn(Reg, Reg, Reg) -> u32>(
    code: &mut Vec<u8>,
    text: &[i64],
    pc: &mut usize,
    name: &str,
    enc: F,
) -> Result<(), C4Error> {
    let v = read_operand(text, pc, name)?;
    load_imm64(code, Reg::X16, v as u64);
    emit(code, enc(Reg::X19, Reg::X19, Reg::X16));
    Ok(())
}

/// Same shape as [`imm_arith`] but for comparison-immediate ops.
/// Participates in the cmp+branch fusion peephole the same way
/// [`lower_cmp`] does -- if the next op is `Bz`/`Bnz` and
/// fusion-eligible, the `cset` is skipped and the condition stashed.
fn imm_cmp(
    code: &mut Vec<u8>,
    text: &[i64],
    pc: &mut usize,
    name: &str,
    cond: Cond,
    reg_state: &mut RegState<'_>,
    branch_targets: &[bool],
) -> Result<(), C4Error> {
    let v = read_operand(text, pc, name)?;
    load_imm64(code, Reg::X16, v as u64);
    emit(code, enc_cmp_reg(Reg::X19, Reg::X16));
    if fusion_candidate(text, *pc, branch_targets).is_some() {
        reg_state.pending_cmp_cond = Some(cond);
    } else {
        emit(code, enc_cset(Reg::X19, cond));
    }
    Ok(())
}

/// Translate a c4 `Lea` offset (in 8-byte VM-slot units) into the
/// matching native byte offset from x29 (the frame pointer).
///
/// Locals (val < 0) keep the c4 `* 8` mapping because the prologue
/// reserves them as 8-byte slots. Args (val >= 2) get `* 16` because
/// `Op::Psh` writes 16-byte slots on the native stack -- AAPCS64
/// requires SP 16-byte aligned at libc-call sites and re-aligning
/// per call would dwarf the wasted half-slot. The two outliers --
/// val == 0 and val == 1 -- aren't emitted by the c4 compiler, but
/// fall through to `* 8` so a stray reference still lands inside
/// the saved x29/x30 region rather than past the args.
fn lea_offset_bytes(offset: i64) -> i64 {
    if offset >= 2 {
        (offset - 1) * 16
    } else {
        offset * 8
    }
}

/// Fused `Lea N; Li/Lc` -- load the local at the matching native
/// byte offset (see [`lea_offset_bytes`]) into x19. Picks `ldur` for
/// offsets that fit in the 9-bit signed range (covers locals up to
/// fp - 256), otherwise computes the address explicitly via
/// `Lea`-style add/sub then loads.
fn emit_local_load(code: &mut Vec<u8>, offset: i64, byte: bool) {
    let bytes = lea_offset_bytes(offset);
    if (-256..256).contains(&bytes) {
        if byte {
            // No `ldurb` in our encoder; do the compute-address path.
            // Locals stored as char are rare enough that the extra
            // instruction won't matter.
        } else {
            emit(code, enc_ldur(Reg::X19, Reg::X29, bytes as i32));
            return;
        }
    }
    // Fallback: address compute, then load.
    let abs = bytes.unsigned_abs();
    if abs < 4096 {
        let imm = abs as u32;
        let word = if bytes >= 0 {
            enc_add_imm(Reg::X19, Reg::X29, imm)
        } else {
            enc_sub_imm(Reg::X19, Reg::X29, imm)
        };
        emit(code, word);
    } else {
        load_imm64(code, Reg::X16, abs);
        let word = if bytes >= 0 {
            enc_add_reg(Reg::X19, Reg::X29, Reg::X16)
        } else {
            enc_sub_reg(Reg::X19, Reg::X29, Reg::X16)
        };
        emit(code, word);
    }
    if byte {
        emit(code, enc_ldrb_imm(Reg::X19, Reg::X19, 0));
    } else {
        emit(code, enc_ldr_imm(Reg::X19, Reg::X19, 0));
    }
}

/// Standard AAPCS64 prologue: save fp/lr in one paired store, set the
/// new frame pointer, and (if the function declares locals) allocate
/// the slot space. Locals are 8 bytes each; we round up to 16 to keep
/// SP 16-byte aligned, which the AAPCS requires at every call site.
///
/// For the program's entry function (`is_main = true`) we additionally
/// push x0 (argc) then x1 (argv) into their own 16-byte slots, the same
/// shape user-function args use. After the prologue's stp(x29,x30) the
/// layout is:
///   bp + 16: argv  (top arg, c4 val=2)
///   bp + 32: argc  (deeper arg, c4 val=3)
/// matching [`lea_offset_bytes`].
fn emit_prologue(code: &mut Vec<u8>, locals: i64, is_main: bool, callee_pool_depth: u8) {
    if is_main {
        // Push argc first (deeper), then argv (shallower). 16-byte
        // slots so the layout matches the c4 calling convention as
        // [`Op::Psh`] uses it for user-function args.
        emit(code, enc_str_pre(Reg::X0, Reg::SP, -16));
        emit(code, enc_str_pre(Reg::X1, Reg::SP, -16));
    }
    // Save fp/lr; set up the new frame; reserve local storage; save
    // x19 below the locals; save the callee-saved pool registers
    // below that.
    //
    // x19 is callee-saved per AAPCS64. Self-hosted c4-to-c4 calls
    // don't actually rely on the saved value (the caller refills
    // its accumulator from the return value), but JIT entry from
    // Rust and any other external caller does -- without this
    // save, the host's x19 gets silently clobbered and downstream
    // Rust crashes once it tries to use a value it had stashed
    // there. Stashing x19 *below* the locals keeps the c4 `Lea`
    // mapping (bp - 8*N for local N) intact.
    //
    // The callee-saved pool (x20..x20+callee_pool_depth-1) is
    // AAPCS64 callee-saved. The regalloc analyzer told us how many
    // of those slots this function actually uses; we save exactly
    // that many. The caller-saved pool (x9..x15) is NOT saved here
    // -- the analyzer routes pushes there only when their value is
    // never live across a call, so a `bl` clobbering them can't
    // hurt anyone.
    emit(code, enc_stp_pre(Reg::X29, Reg::X30, Reg::SP, -16));
    emit(code, enc_add_imm(Reg::X29, Reg::SP, 0));
    if locals > 0 {
        let bytes = (locals as u32) * 8;
        let aligned = (bytes + 15) & !15;
        emit(code, enc_sub_imm(Reg::SP, Reg::SP, aligned));
    }
    emit(code, enc_str_pre(Reg::X19, Reg::SP, -16));
    emit_save_pool(code, callee_pool_depth);
}

/// Mirror of [`emit_prologue`]. Move the VM accumulator into `x0`
/// (the return register), restore the pool registers, restore the
/// saved x19, tear down the frame, return. For main we also drop
/// the two 16-byte argc/argv slots so the stack pointer is back to
/// what the kernel / Rust caller handed us.
fn emit_epilogue(code: &mut Vec<u8>, is_main: bool, callee_pool_depth: u8) {
    emit_mov_reg(code, Reg::X0, Reg::X19);
    // Stack layout below this point (top-down):
    //   callee pool regs (`callee_pool_depth` of them, 16 bytes per slot)
    //   saved x19
    //   locals
    //   saved fp/lr
    // Pop in reverse order. The caller-saved pool is not on the
    // stack -- it was never saved.
    emit_restore_pool(code, callee_pool_depth);
    emit(code, enc_ldr_post(Reg::X19, Reg::SP, 16));
    emit(code, enc_add_imm(Reg::SP, Reg::X29, 0));
    emit(code, enc_ldp_post(Reg::X29, Reg::X30, Reg::SP, 16));
    if is_main {
        emit(code, enc_add_imm(Reg::SP, Reg::SP, 32));
    }
    emit(code, enc_ret(Reg::X30));
}

/// Save the callee-saved pool x20..x20+depth-1 to the stack as a
/// contiguous run of 16-byte slots. Pairs (`stp`) when possible --
/// 2 regs per 16 bytes -- with a single `str` for an odd trailing
/// register. The caller-saved bank (x9..) is never saved.
fn emit_save_pool(code: &mut Vec<u8>, depth: u8) {
    let mut i = 0u8;
    while i + 1 < depth {
        emit(
            code,
            enc_stp_pre(
                Reg(Reg::CALLEE_POOL_BASE.0 + i),
                Reg(Reg::CALLEE_POOL_BASE.0 + i + 1),
                Reg::SP,
                -16,
            ),
        );
        i += 2;
    }
    if i < depth {
        emit(
            code,
            enc_str_pre(Reg(Reg::CALLEE_POOL_BASE.0 + i), Reg::SP, -16),
        );
    }
}

/// Reverse of [`emit_save_pool`]. Pop in opposite order so a
/// solo top-of-stack register (odd `depth`) gets restored before
/// the paired ones.
fn emit_restore_pool(code: &mut Vec<u8>, depth: u8) {
    if depth == 0 {
        return;
    }
    let mut i = depth;
    if depth.is_multiple_of(2) {
        // pair-only restore
    } else {
        i -= 1;
        emit(
            code,
            enc_ldr_post(Reg(Reg::CALLEE_POOL_BASE.0 + i), Reg::SP, 16),
        );
    }
    while i >= 2 {
        i -= 2;
        emit(
            code,
            enc_ldp_post(
                Reg(Reg::CALLEE_POOL_BASE.0 + i),
                Reg(Reg::CALLEE_POOL_BASE.0 + i + 1),
                Reg::SP,
                16,
            ),
        );
    }
}

#[cfg(test)]
mod tests {
    //! Encoder tests. Expected byte sequences were cross-checked against
    //! `clang -c -arch arm64` + `otool -d` on Apple Silicon -- if you
    //! change a constant here, run the same trip and confirm.
    //!
    //! Bytes are read in the order they appear in `otool -d`, which is
    //! the in-memory order (little-endian word).

    use super::*;
    use alloc::vec;

    fn one(word: u32) -> [u8; 4] {
        word.to_le_bytes()
    }

    #[test]
    fn movz_x0_42() {
        // movz x0, #42  ->  0xD2800540
        assert_eq!(enc_movz(Reg::X0, 42, 0), 0xD280_0540);
    }

    #[test]
    fn movz_x0_abcd_lsl16() {
        // movz x0, #0xABCD, lsl #16  ->  0xD2B579A0
        assert_eq!(enc_movz(Reg::X0, 0xABCD, 1), 0xD2B5_79A0);
    }

    #[test]
    fn movk_x0_1234_lsl32() {
        // movk x0, #0x1234, lsl #32  ->  0xF2C24680
        assert_eq!(enc_movk(Reg::X0, 0x1234, 2), 0xF2C2_4680);
    }

    #[test]
    fn ret_x30() {
        // ret  ->  0xD65F03C0
        assert_eq!(enc_ret(Reg::X30), 0xD65F_03C0);
    }

    #[test]
    fn bl_backwards_one_insn() {
        // bl . - 4 (-1 instruction)  ->  0x97FFFFFF
        // (covers the "two's-complement masking is right" case)
        assert_eq!(enc_bl(-1), 0x97FF_FFFF);
    }

    #[test]
    fn bl_backwards_four_insns() {
        // bl . - 16 (-4 instructions)  ->  0x97FFFFFC
        assert_eq!(enc_bl(-4), 0x97FF_FFFC);
    }

    #[test]
    fn bl_forwards() {
        // bl . + 8 (+2 instructions)  ->  0x94000002
        assert_eq!(enc_bl(2), 0x9400_0002);
    }

    #[test]
    fn stp_pre_fp_lr_minus_16() {
        // stp x29, x30, [sp, #-16]!  ->  0xA9BF7BFD
        assert_eq!(enc_stp_pre(Reg::X29, Reg::X30, Reg::SP, -16), 0xA9BF_7BFD);
    }

    #[test]
    fn ldp_post_fp_lr_plus_16() {
        // ldp x29, x30, [sp], #16  ->  0xA8C17BFD
        assert_eq!(enc_ldp_post(Reg::X29, Reg::X30, Reg::SP, 16), 0xA8C1_7BFD);
    }

    #[test]
    fn mov_x0_x19() {
        // mov x0, x19  =  orr x0, xzr, x19  ->  0xAA1303E0
        assert_eq!(enc_mov_reg(Reg::X0, Reg::X19), 0xAA13_03E0);
    }

    #[test]
    fn emit_mov_reg_elides_self_move() {
        // mov x19, x19 -- the lowering wrapper drops the encoding,
        // since the target == source. Distinct registers still emit
        // the full 4-byte word.
        let mut code = Vec::new();
        emit_mov_reg(&mut code, Reg::X19, Reg::X19);
        assert!(code.is_empty(), "self-mov should be elided");

        emit_mov_reg(&mut code, Reg::X0, Reg::X19);
        assert_eq!(code.len(), 4, "distinct-reg mov still emits");
        assert_eq!(&code[..], &one(enc_mov_reg(Reg::X0, Reg::X19)));
    }

    #[test]
    fn add_x29_sp_zero() {
        // add x29, sp, #0  ->  0x910003FD  (frame-pointer setup)
        assert_eq!(enc_add_imm(Reg::X29, Reg::SP, 0), 0x9100_03FD);
    }

    #[test]
    fn sub_sp_sp_16() {
        // sub sp, sp, #16  ->  0xD10043FF  (one local slot, padded)
        assert_eq!(enc_sub_imm(Reg::SP, Reg::SP, 16), 0xD100_43FF);
    }

    #[test]
    fn sub_sp_sp_32() {
        // sub sp, sp, #32  ->  0xD10083FF  (covers the 12-bit shift)
        assert_eq!(enc_sub_imm(Reg::SP, Reg::SP, 32), 0xD100_83FF);
    }

    // ---- M1.5 encoders. Each `clang -c -arch arm64` byte string was
    //      pasted from `otool -t -X` on the assembler's output; if you
    //      change one, run the same trip and update.

    fn r(n: u8) -> Reg {
        Reg(n)
    }

    #[test]
    fn arith_register_forms() {
        assert_eq!(enc_add_reg(r(0), r(1), r(2)), 0x8B02_0020);
        assert_eq!(enc_sub_reg(r(0), r(1), r(2)), 0xCB02_0020);
        assert_eq!(enc_and_reg(r(0), r(1), r(2)), 0x8A02_0020);
        assert_eq!(enc_orr_reg(r(0), r(1), r(2)), 0xAA02_0020);
        assert_eq!(enc_eor_reg(r(0), r(1), r(2)), 0xCA02_0020);
        assert_eq!(enc_mul(r(0), r(1), r(2)), 0x9B02_7C20);
        assert_eq!(enc_sdiv(r(0), r(1), r(2)), 0x9AC2_0C20);
        assert_eq!(enc_msub(r(0), r(1), r(2), r(3)), 0x9B02_8C20);
        assert_eq!(enc_lslv(r(0), r(1), r(2)), 0x9AC2_2020);
        assert_eq!(enc_asrv(r(0), r(1), r(2)), 0x9AC2_2820);
        assert_eq!(enc_lsrv(r(0), r(1), r(2)), 0x9AC2_2420);
    }

    #[test]
    fn cmp_and_cset() {
        // cmp x0, x1
        assert_eq!(enc_cmp_reg(r(0), r(1)), 0xEB01_001F);
        // cset x0, eq / ne / lt / gt / le / ge
        assert_eq!(enc_cset(r(0), Cond::Eq), 0x9A9F_17E0);
        assert_eq!(enc_cset(r(0), Cond::Ne), 0x9A9F_07E0);
        assert_eq!(enc_cset(r(0), Cond::Lt), 0x9A9F_A7E0);
        assert_eq!(enc_cset(r(0), Cond::Gt), 0x9A9F_D7E0);
        assert_eq!(enc_cset(r(0), Cond::Le), 0x9A9F_C7E0);
        assert_eq!(enc_cset(r(0), Cond::Ge), 0x9A9F_B7E0);
    }

    #[test]
    fn branches() {
        // b . - 44 bytes (-11 instructions)  ->  0x17FFFFF5
        assert_eq!(enc_b(-11), 0x17FF_FFF5);
        // cbz x19, . - 48 (-12 instructions)
        assert_eq!(enc_cbz(Reg::X19, -12), 0xB4FF_FE93);
        // cbnz x19, . - 52 (-13 instructions)
        assert_eq!(enc_cbnz(Reg::X19, -13), 0xB5FF_FE73);
        // blr x16
        assert_eq!(enc_blr(r(16)), 0xD63F_0200);
    }

    #[test]
    fn b_cond_encodings() {
        // b.eq .+0  ->  0x54000000
        assert_eq!(enc_b_cond(Cond::Eq, 0), 0x5400_0000);
        // b.ne .+0  ->  0x54000001
        assert_eq!(enc_b_cond(Cond::Ne, 0), 0x5400_0001);
        // b.lt .+0  ->  0x5400000B
        assert_eq!(enc_b_cond(Cond::Lt, 0), 0x5400_000B);
        // b.ge .+0  ->  0x5400000A
        assert_eq!(enc_b_cond(Cond::Ge, 0), 0x5400_000A);
        // b.gt .+0  ->  0x5400000C
        assert_eq!(enc_b_cond(Cond::Gt, 0), 0x5400_000C);
        // b.le .+0  ->  0x5400000D
        assert_eq!(enc_b_cond(Cond::Le, 0), 0x5400_000D);
        // b.ge . - 8 (-2 instructions)  ->  0x54FFFFCA
        assert_eq!(enc_b_cond(Cond::Ge, -2), 0x54FF_FFCA);
    }

    #[test]
    fn cond_flip_round_trips() {
        for c in [Cond::Eq, Cond::Ne, Cond::Lt, Cond::Ge, Cond::Gt, Cond::Le] {
            assert_eq!(c.flip().flip(), c, "double flip should be identity");
        }
        // Spot checks of the inversion semantics.
        assert_eq!(Cond::Eq.flip(), Cond::Ne);
        assert_eq!(Cond::Lt.flip(), Cond::Ge);
        assert_eq!(Cond::Gt.flip(), Cond::Le);
    }

    #[test]
    fn loads_stores_scaled() {
        assert_eq!(enc_ldr_imm(r(0), r(1), 16), 0xF940_0820);
        assert_eq!(enc_str_imm(r(0), r(1), 24), 0xF900_0C20);
        assert_eq!(enc_ldrb_imm(r(0), r(1), 1), 0x3940_0420);
        assert_eq!(enc_strb_imm(r(0), r(1), 2), 0x3900_0820);
    }

    #[test]
    fn loads_stores_unscaled_negative() {
        // ldur x0, [x29, #-8]  ->  0xF85F83A0
        assert_eq!(enc_ldur(r(0), Reg::X29, -8), 0xF85F_83A0);
        // stur x0, [x29, #-16] ->  0xF81F03A0
        assert_eq!(enc_stur(r(0), Reg::X29, -16), 0xF81F_03A0);
    }

    #[test]
    fn pre_post_indexed_for_vm_stack() {
        // str x19, [sp, #-16]!  ->  0xF81F0FF3
        assert_eq!(enc_str_pre(Reg::X19, Reg::SP, -16), 0xF81F_0FF3);
        // ldr x19, [sp], #16    ->  0xF84107F3
        assert_eq!(enc_ldr_post(Reg::X19, Reg::SP, 16), 0xF841_07F3);
    }

    #[test]
    fn adrp_zero_offset() {
        // adrp x0, .  ->  0x90000000
        assert_eq!(enc_adrp(r(0), 0), 0x9000_0000);
    }

    #[test]
    fn emit_writes_little_endian() {
        let mut code = Vec::new();
        emit(&mut code, 0xDEAD_BEEF);
        assert_eq!(code, vec![0xEF, 0xBE, 0xAD, 0xDE]);
    }

    #[test]
    fn load_imm64_zero_uses_one_movz() {
        let mut code = Vec::new();
        load_imm64(&mut code, Reg::X0, 0);
        assert_eq!(code.len(), 4);
        assert_eq!(&code[..], &one(enc_movz(Reg::X0, 0, 0)));
    }

    #[test]
    fn load_imm64_small_uses_one_movz() {
        let mut code = Vec::new();
        load_imm64(&mut code, Reg::X0, 42);
        assert_eq!(code.len(), 4);
        assert_eq!(&code[..], &one(enc_movz(Reg::X0, 42, 0)));
    }

    #[test]
    fn load_imm64_high_lane_starts_at_movz() {
        // value 0x1234_0000 -- only one non-zero lane (lane 1). The
        // sequence should be a single `movz xN, #0x1234, lsl #16`,
        // not `movz #0; movk #0x1234, lsl #16`.
        let mut code = Vec::new();
        load_imm64(&mut code, Reg::X0, 0x1234_0000);
        assert_eq!(code.len(), 4);
        assert_eq!(&code[..], &one(enc_movz(Reg::X0, 0x1234, 1)));
    }

    #[test]
    fn load_imm64_full_64bit_uses_movz_plus_three_movk() {
        // value with all four lanes non-zero -- 4 instructions.
        let v: u64 = 0xAAAA_BBBB_CCCC_DDDD;
        let mut code = Vec::new();
        load_imm64(&mut code, Reg::X1, v);
        assert_eq!(code.len(), 16);
        let want = [
            enc_movz(Reg::X1, 0xDDDD, 0),
            enc_movk(Reg::X1, 0xCCCC, 1),
            enc_movk(Reg::X1, 0xBBBB, 2),
            enc_movk(Reg::X1, 0xAAAA, 3),
        ];
        for (i, w) in want.iter().enumerate() {
            let off = i * 4;
            assert_eq!(&code[off..off + 4], &one(*w));
        }
    }

    #[test]
    fn load_imm64_skips_middle_zero_lane() {
        // 0x1111_0000_2222 -- lane 0 = 0x2222, lane 1 = 0, lane 2 = 0x1111.
        // The middle zero lane would clobber the bottom if we emitted a
        // `movk #0, lsl #16`, so it MUST be skipped.
        let mut code = Vec::new();
        load_imm64(&mut code, Reg::X0, 0x1111_0000_2222);
        assert_eq!(code.len(), 8);
        let want = [enc_movz(Reg::X0, 0x2222, 0), enc_movk(Reg::X0, 0x1111, 2)];
        for (i, w) in want.iter().enumerate() {
            let off = i * 4;
            assert_eq!(&code[off..off + 4], &one(*w));
        }
    }
}

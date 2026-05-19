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

// Encoder catalogue: a few entries (e.g. unused arithmetic forms,
// MSR/MRS variants we'd reach for if we ever grow scheduling) sit
// here for completeness and aren't called by the lowering pass.
// Suppress the dead-code lint for the whole module so adding the
// next encoder doesn't need a per-item attribute.
#![allow(dead_code)]

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use super::super::CODE_BASE;
use super::super::error::C5Error;
use super::super::op::Op;
use super::super::program::Program;
use super::regalloc::{self, PoolBank, PushKind, RegStackPlan};
use super::{Abi, Build, DataFixup, FuncFixup, GotFixup, NativeOptions, Target};

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
    /// Local-byte reservation for the current function, captured on
    /// `Op::Ent` and read on `Op::Lev`. The epilogue reverses the
    /// prologue's `sub sp, sp, locals` and adjacent saved-x19 +
    /// pool slot pushes off of FP; without the saved value
    /// `Op::Intrinsic(Alloca)`'s `sub sp, sp, n` would leave SP
    /// below the pool and the epilogue's pop sequence would read
    /// alloca scratch as register state.
    current_locals_bytes: u32,
    /// FP-slot byte offset of the alloca-top pointer for the
    /// current function, or 0 if the function doesn't use
    /// alloca. Set by `Op::AllocaInit` and read by the
    /// `Op::Intrinsic(Alloca)` handler.
    current_alloca_top_offset: u32,
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
            current_locals_bytes: 0,
            current_alloca_top_offset: 0,
            pseudo_stack: Vec::new(),
            pending_cmp_cond: None,
        }
    }
}

/// AArch64 register name. Wraps the 5-bit register field that nearly
/// every instruction needs in some position; using a newtype prevents
/// the "I passed `1` for a register and `1` for an immediate to the
/// same encoder" bug class.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) struct Reg(pub u8);

// Some Reg constants here aren't reached by every lowering path
// but are kept for completeness so the assembler-style API stays
// uniform.
#[allow(dead_code)]
impl Reg {
    pub const X0: Reg = Reg(0);
    pub const X1: Reg = Reg(1);
    pub const X2: Reg = Reg(2);
    pub const X8: Reg = Reg(8); // Linux/aarch64 intrinsic number register
    pub const X16: Reg = Reg(16); // IP0 -- temp scratch
    pub const X17: Reg = Reg(17); // IP1 -- second temp
    /// AAPCS64 reserves x18 as the "platform register". On
    /// Windows/aarch64 it always holds the TEB pointer; the
    /// PE TLS lowering pulls `TEB->ThreadLocalStoragePointer`
    /// out of `[x18 + 0x58]`. Linux and macOS leave x18 free
    /// and we don't otherwise touch it.
    pub const X18: Reg = Reg(18);
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
// the right byte order. They're unit-tested standalone; `lower`
// composes them into the per-op sequences.
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

/// `SUBS <Xd>, <Xn|SP>, #imm12` -- like `SUB` but sets NZCV.
/// Used by the stack-probe loop's counter decrement so the
/// trailing `b.ne` can read the flags. Top 8 bits flip from
/// `1101_0001` (SUB) to `1111_0001` (SUBS).
pub(super) fn enc_subs_imm(rd: Reg, rn: Reg, imm12: u32) -> u32 {
    debug_assert!(imm12 < 4096, "subs imm: {imm12} > 12-bit max");
    0xF100_0000 | (imm12 << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SUB <Xd>, <Xn|SP>, #imm12, LSL #12`. The shifted-12 form
/// extends the reach of the immediate to multiples of 4096 up
/// to ~16 MiB, used together with the unshifted form to cover
/// any 24-bit byte count in two instructions.
pub(super) fn enc_sub_imm_lsl12(rd: Reg, rn: Reg, imm12: u32) -> u32 {
    debug_assert!(imm12 < 4096, "sub imm lsl12: {imm12} > 12-bit max");
    0xD140_0000 | (imm12 << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `ADD <Xd>, <Xn|SP>, #imm12, LSL #12`. Mirror of
/// [`enc_sub_imm_lsl12`] -- used to fold large
/// stack-restoration adjustments into two instructions.
pub(super) fn enc_add_imm_lsl12(rd: Reg, rn: Reg, imm12: u32) -> u32 {
    debug_assert!(imm12 < 4096, "add imm lsl12: {imm12} > 12-bit max");
    0x9140_0000 | (imm12 << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// Subtract `bytes` from SP. AArch64's `SUB (immediate)` carries
/// a 12-bit value optionally left-shifted by 12, so a single
/// instruction can cover `bytes < 4096` directly or any
/// multiple of 4096 up to ~16 MiB. For values that don't fit
/// either single-instruction form we emit two: one for the
/// shifted-12 portion (high bits, multiples of 4096) and one
/// for the remainder. Anything beyond 24 bits would need a
/// register-form `SUB` -- not seen in practice, so we panic
/// with a clear message rather than silently truncating.
pub(super) fn emit_sub_sp_imm(code: &mut Vec<u8>, bytes: u32) {
    if bytes == 0 {
        return;
    }
    assert!(
        bytes < (1 << 24),
        "stack frame too large for 24-bit SUB immediate: {bytes} bytes"
    );
    let high = bytes & !0xfff;
    let low = bytes & 0xfff;
    if high != 0 {
        emit(code, enc_sub_imm_lsl12(Reg::SP, Reg::SP, high >> 12));
    }
    if low != 0 {
        emit(code, enc_sub_imm(Reg::SP, Reg::SP, low));
    }
}

/// Add `bytes` to SP using the same 24-bit reach as
/// [`emit_sub_sp_imm`]. Used by `Op::Adj` for argument-cleanup
/// after a call, and by anything else that needs to grow the
/// stack pointer back by more than 4 KiB in one go.
pub(super) fn emit_add_sp_imm(code: &mut Vec<u8>, bytes: u32) {
    if bytes == 0 {
        return;
    }
    assert!(
        bytes < (1 << 24),
        "stack adjustment too large for 24-bit ADD immediate: {bytes} bytes"
    );
    let high = bytes & !0xfff;
    let low = bytes & 0xfff;
    if high != 0 {
        emit(code, enc_add_imm_lsl12(Reg::SP, Reg::SP, high >> 12));
    }
    if low != 0 {
        emit(code, enc_add_imm(Reg::SP, Reg::SP, low));
    }
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

/// `AND <Xd>, <Xn>, #~15` -- mask off the low four bits so the
/// result is a multiple of 16. Used by the alloca lowering to
/// round the requested size up to the platform's stack-alignment
/// before bumping the per-frame arena top. AArch64 logical-
/// immediate encoding for the 64-bit mask `0xFFFFFFFFFFFFFFF0`:
/// `sf=1`, `N=1`, `immr=0`, `imms=59` (sixty ones, no rotation).
pub(super) fn enc_and_imm_neg16(rd: Reg, rn: Reg) -> u32 {
    0x9240_EC00 | ((rn.0 as u32) << 5) | (rd.0 as u32)
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

/// `UDIV <Xd>, <Xn>, <Xm>` -- unsigned integer division. Differs from
/// SDIV only in the opcode2 field (bit 10 cleared). Pairs with
/// [`enc_msub`] when computing unsigned modulo.
pub(super) fn enc_udiv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0x9AC0_0800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
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

// ---- Floating-point (double-precision). ----
//
// All FP arithmetic happens in d-regs; the c5 stack passes the raw
// `f64::to_bits()` payload through GPR slots, and the lowering moves
// it into d-regs only for the math itself. d0..d3 are AAPCS64
// caller-saved scratch -- no callee-saved bookkeeping required.
//
// FP `dXX` register field is the same 5-bit slot as the integer side;
// they share encoding space because each instruction word names the
// register file via its opcode bits.

/// `FMOV <Dd>, <Xn>` -- copy the 64 low bits of `Xn` into `Dd`. Used
/// to stage a c5-stack slot (raw `f64::to_bits()`) into an FP register
/// before arithmetic.
pub(super) fn enc_fmov_x_to_d(dd: u8, xn: Reg) -> u32 {
    debug_assert!(dd < 32);
    0x9E67_0000 | ((xn.0 as u32) << 5) | (dd as u32)
}

/// `FMOV <Xd>, <Dn>` -- copy the 64 low bits of `Dn` back into `Xd`.
pub(super) fn enc_fmov_d_to_x(rd: Reg, dn: u8) -> u32 {
    debug_assert!(dn < 32);
    0x9E66_0000 | ((dn as u32) << 5) | (rd.0 as u32)
}

/// `FADD <Dd>, <Dn>, <Dm>` -- double-precision add. `Dd = Dn + Dm`.
pub(super) fn enc_fadd_d(dd: u8, dn: u8, dm: u8) -> u32 {
    debug_assert!(dd < 32 && dn < 32 && dm < 32);
    0x1E60_2800 | ((dm as u32) << 16) | ((dn as u32) << 5) | (dd as u32)
}

/// `FSUB <Dd>, <Dn>, <Dm>`. `Dd = Dn - Dm`.
pub(super) fn enc_fsub_d(dd: u8, dn: u8, dm: u8) -> u32 {
    debug_assert!(dd < 32 && dn < 32 && dm < 32);
    0x1E60_3800 | ((dm as u32) << 16) | ((dn as u32) << 5) | (dd as u32)
}

/// `FMUL <Dd>, <Dn>, <Dm>`. `Dd = Dn * Dm`.
pub(super) fn enc_fmul_d(dd: u8, dn: u8, dm: u8) -> u32 {
    debug_assert!(dd < 32 && dn < 32 && dm < 32);
    0x1E60_0800 | ((dm as u32) << 16) | ((dn as u32) << 5) | (dd as u32)
}

/// `FDIV <Dd>, <Dn>, <Dm>`. `Dd = Dn / Dm`.
pub(super) fn enc_fdiv_d(dd: u8, dn: u8, dm: u8) -> u32 {
    debug_assert!(dd < 32 && dn < 32 && dm < 32);
    0x1E60_1800 | ((dm as u32) << 16) | ((dn as u32) << 5) | (dd as u32)
}

/// `FNEG <Dd>, <Dn>`. `Dd = -Dn`.
pub(super) fn enc_fneg_d(dd: u8, dn: u8) -> u32 {
    debug_assert!(dd < 32 && dn < 32);
    0x1E61_4000 | ((dn as u32) << 5) | (dd as u32)
}

/// `FCMP <Dn>, <Dm>` -- set NZCV per the IEEE comparison of `Dn`
/// and `Dm`. Used in the comparison lowering before `CSET`. Note:
/// for unordered (NaN) operands the result is the IEEE "unordered"
/// state; the C-level comparisons we lower (`<`, `>=`, etc.) match
/// the ordered cases and accept NaN-edge divergence (NaN compares
/// equal under EQ here, where C says `NaN == NaN` is false).
pub(super) fn enc_fcmp_d(dn: u8, dm: u8) -> u32 {
    debug_assert!(dn < 32 && dm < 32);
    0x1E60_2000 | ((dm as u32) << 16) | ((dn as u32) << 5)
}

/// `FCVTZS <Xd>, <Dn>` -- truncating signed FP-to-int. Matches the
/// C `(int)f` semantics: discard the fractional part; out-of-range
/// values saturate.
pub(super) fn enc_fcvtzs_x_d(rd: Reg, dn: u8) -> u32 {
    debug_assert!(dn < 32);
    0x9E78_0000 | ((dn as u32) << 5) | (rd.0 as u32)
}

/// `SCVTF <Dd>, <Xn>` -- signed int-to-FP. Emits the round-to-
/// nearest-ties-to-even mantissa.
pub(super) fn enc_scvtf_d_x(dd: u8, xn: Reg) -> u32 {
    debug_assert!(dd < 32);
    0x9E62_0000 | ((xn.0 as u32) << 5) | (dd as u32)
}

/// `MRS <Xt>, TPIDR_EL0` -- read the per-thread pointer system
/// register. Linux glibc populates `TPIDR_EL0` at thread setup
/// with the address of `struct pthread`, and the TLS image (our
/// `.tdata` / `.tbss`) follows immediately after the TCB header.
/// `var_addr = TPIDR_EL0 + TLS_TCB_HEAD (16) + offset_in_block`.
pub(super) fn enc_mrs_tpidr_el0(rt: Reg) -> u32 {
    // 1101_0101_0011_0011_1101_0000_0100_0000 + Rt
    // (op0=11, op1=011, CRn=1101, CRm=0000, op2=010)
    0xD53B_D040 | (rt.0 as u32)
}

/// `LDR <Dt>, [<Xn|SP>, #imm]` -- 64-bit unsigned-offset FP/SIMD
/// load. The offset is byte-addressed but encoded as `imm/8`; the
/// caller passes raw bytes (must be multiple of 8 in 0..32760).
/// Used by the variadic-FP packer to pull a c5-stack slot
/// straight into a `dN` register before a libc call.
pub(super) fn enc_ldr_d_imm(dt: u8, rn: Reg, imm: u32) -> u32 {
    debug_assert!(dt < 32);
    debug_assert!(imm.is_multiple_of(8) && imm < 32760);
    0xFD40_0000 | ((imm / 8) << 10) | ((rn.0 as u32) << 5) | (dt as u32)
}

/// `LDR <St>, [<Xn|SP>, #imm]` -- 32-bit unsigned-offset FP/SIMD
/// load. The offset is byte-addressed but encoded as `imm/4`;
/// caller passes raw bytes (must be multiple of 4 in 0..16380).
/// Used by [`Op::Lf`] to load a `float`-typed lvalue's storage
/// directly into the `sN` half of `dN` before the widening fcvt.
pub(super) fn enc_ldr_s_imm(st: u8, rn: Reg, imm: u32) -> u32 {
    debug_assert!(st < 32);
    debug_assert!(imm.is_multiple_of(4) && imm < 16380);
    0xBD40_0000 | ((imm / 4) << 10) | ((rn.0 as u32) << 5) | (st as u32)
}

/// `STR <St>, [<Xn|SP>, #imm]` -- 32-bit unsigned-offset FP/SIMD
/// store. Same encoding family as [`enc_ldr_s_imm`]; companion to
/// [`Op::Sf`].
pub(super) fn enc_str_s_imm(st: u8, rn: Reg, imm: u32) -> u32 {
    debug_assert!(st < 32);
    debug_assert!(imm.is_multiple_of(4) && imm < 16380);
    0xBD00_0000 | ((imm / 4) << 10) | ((rn.0 as u32) << 5) | (st as u32)
}

/// `STR <Dt>, [<Xn|SP>, #imm]` -- 64-bit unsigned-offset FP/SIMD
/// store, the partner of [`enc_ldr_d_imm`]. Used by the AArch64
/// setjmp intrinsic to spill d8-d15 into the user's `jmp_buf`.
pub(super) fn enc_str_d_imm(dt: u8, rn: Reg, imm: u32) -> u32 {
    debug_assert!(dt < 32);
    debug_assert!(imm.is_multiple_of(8) && imm < 32760);
    0xFD00_0000 | ((imm / 8) << 10) | ((rn.0 as u32) << 5) | (dt as u32)
}

/// `ADR <Xd>, label` -- compute a PC-relative byte address (signed
/// 21-bit offset) into `Xd`. Used by the AArch64 setjmp intrinsic
/// to capture the resume address that a later longjmp branches to.
/// Offset is in bytes from the ADR's own PC.
pub(super) fn enc_adr(rd: Reg, off_bytes: i32) -> u32 {
    debug_assert!((-(1 << 20)..(1 << 20)).contains(&off_bytes), "adr off");
    let off = (off_bytes as u32) & 0x001F_FFFF;
    let immlo = off & 0x3;
    let immhi = (off >> 2) & 0x0007_FFFF;
    0x1000_0000 | (immlo << 29) | (immhi << 5) | (rd.0 as u32)
}

/// `CINC <Xd>, <Xn>, <cond>` -- conditional increment. Alias for
/// `CSINC Xd, Xn, Xn, invert(cond)`: if `cond` is true, write
/// `Xn + 1`; otherwise write `Xn`. Used by the longjmp intrinsic to
/// turn a 0 value into 1 per C99 7.13.2.1 ("if the function returns
/// 0 it is as if longjmp had been called with the value 1").
pub(super) fn enc_cinc(rd: Reg, rn: Reg, cond: Cond) -> u32 {
    let inv = (cond as u32) ^ 1;
    0x9A80_0400 | ((rn.0 as u32) << 16) | (inv << 12) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `FCVT <Dd>, <Sn>` -- widen single-precision to double-precision
/// (bit-exact for any finite single value, matching the IEEE
/// short-to-long conversion). Used by [`Op::Lf`] after the
/// single-precision load.
pub(super) fn enc_fcvt_d_s(dd: u8, sn: u8) -> u32 {
    debug_assert!(dd < 32 && sn < 32);
    0x1E22_C000 | ((sn as u32) << 5) | (dd as u32)
}

/// `FCVT <Sd>, <Dn>` -- narrow double-precision to single-precision
/// with round-to-nearest-ties-to-even (matching IEEE 754 and the
/// VM's `f64 as f32` semantics). Used by [`Op::Sf`] before the
/// single-precision store.
pub(super) fn enc_fcvt_s_d(sd: u8, dn: u8) -> u32 {
    debug_assert!(sd < 32 && dn < 32);
    0x1E62_4000 | ((dn as u32) << 5) | (sd as u32)
}

// ---- Comparisons + condition-set. ----

/// `CMP <Xn>, <Xm>` = `SUBS XZR, <Xn>, <Xm>` -- compare two registers,
/// updating the NZCV flags but discarding the result.
pub(super) fn enc_cmp_reg(rn: Reg, rm: Reg) -> u32 {
    0xEB00_0000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (Reg::SP.0 as u32)
}

/// AArch64 condition codes -- the 4-bit field that follows comparisons
/// and conditional moves. Names match the ARM ARM. The Mi/Ls
/// variants are the FP-comparison flavour: after `FCMP`, the
/// `<`/`<=` results live under the unsigned/sign-bit codes
/// (mi/ls) rather than the signed-arithmetic lt/le, because
/// FCMP's flag layout differs from SUBS's.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum Cond {
    Eq = 0,
    Ne = 1,
    /// Unsigned `>=` (HS = CS). After SUBS, set when no borrow occurred.
    Hs = 0x2,
    /// Unsigned `<` (LO = CC). After SUBS, set when borrow occurred.
    Lo = 0x3,
    /// FP "less than" -- N==1, set by FCMP when Dn < Dm (ordered).
    Mi = 0x4,
    /// Unsigned `>`. After SUBS, set when C==1 && Z==0.
    Hi = 0x8,
    /// FP "less than or equal" / unsigned `<=` -- C==0 || Z==1.
    /// Same flag-test for both because CMP and FCMP agree on the
    /// boundary case here.
    Ls = 0x9,
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
            Cond::Lo => Cond::Hs,
            Cond::Hs => Cond::Lo,
            Cond::Hi => Cond::Ls,
            Cond::Ls => Cond::Hi,
            // Mi <-> Pl -- FP comparisons go through the cset-only
            // path so the cmp+branch fusion peephole shouldn't
            // reach here, but map to the closest integer flip in
            // case it does.
            Cond::Mi => Cond::Ge,
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

/// `BR <Xn>` -- branch (no link) to the address in `Xn`. Used by
/// the `Op::TailExt` lowering to forward control to the IAT/GOT-
/// resolved libc address without saving a return point: the libc
/// fn's `RET` lands back at the c5 caller's post-Jsri continuation
/// instead of bouncing back through the trampoline.
pub(super) fn enc_br(rn: Reg) -> u32 {
    0xD61F_0000 | ((rn.0 as u32) << 5)
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

/// `LDR <Wt>, [<Xn|SP>, #imm]` -- 32-bit load (zero-extended into
/// `Xt`), immediate offset scaled by 4. Used by the Win64 TLS
/// lowering to read the 4-byte `_tls_index` slot.
pub(super) fn enc_ldr32_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm.is_multiple_of(4), "ldr32 imm: {imm} not 4-byte aligned");
    let scaled = imm / 4;
    debug_assert!(scaled < 4096, "ldr32 imm: {imm} > 16380");
    0xB940_0000 | (scaled << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDRSW <Xt>, [<Xn|SP>, #imm]` -- 32-bit load sign-extended into
/// the full 64-bit `Xt`, immediate offset scaled by 4. Used by
/// [`Op::Lw`] for signed `int` lvalue reads -- the C signed-int
/// model requires the high bit of the 4-byte slot to propagate.
pub(super) fn enc_ldrsw_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm.is_multiple_of(4), "ldrsw imm: {imm} not 4-byte aligned");
    let scaled = imm / 4;
    debug_assert!(scaled < 4096, "ldrsw imm: {imm} > 16380");
    0xB980_0000 | (scaled << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STR <Wt>, [<Xn|SP>, #imm]` -- 32-bit store (low half of `Xt`),
/// immediate offset scaled by 4. Companion to [`enc_ldrsw_imm`] /
/// [`enc_ldr32_imm`] for [`Op::Sw`].
pub(super) fn enc_str32_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm.is_multiple_of(4), "str32 imm: {imm} not 4-byte aligned");
    let scaled = imm / 4;
    debug_assert!(scaled < 4096, "str32 imm: {imm} > 16380");
    0xB900_0000 | (scaled << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDR <Xt>, [<Xn|SP>, <Xm>, LSL #3]` -- 64-bit load, base-plus-
/// register-shifted-by-3. Used by the Win64 TLS lowering to fetch
/// `tls_array[_tls_index]` (each entry is 8 bytes, hence LSL #3).
/// Encoded via the "load/store register, register" form with
/// option = 011 (LSL/UXTX) and S = 1 (scale by access size).
pub(super) fn enc_ldr_reg_lsl3(rt: Reg, rn: Reg, rm: Reg) -> u32 {
    // Base opcode: 11_111_000_011 Rm 011 S 10 Rn Rt
    // option=011 (LSL/UXTX) for 64-bit Xm; S=1 means shift by
    // log2(access_size)=3 (since access_size=8). Verified against
    // clang's encoding of `ldr x16, [x16, x17, lsl #3]` (0xF8717A10):
    // 0xF8607800 is the fixed-bits mask, and OR-in of Rm=17, Rn=16,
    // Rt=16 produces the canonical hex.
    0xF860_7800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDRSH <Xt>, [<Xn|SP>, #imm]` -- 16-bit load sign-extended into
/// the full 64-bit `Xt`, immediate offset scaled by 2. Used by
/// [`Op::Lh`] for `short` lvalue reads. Encoding: opc=10
/// (sign-extend to 64-bit), size=01 (halfword).
pub(super) fn enc_ldrsh_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm.is_multiple_of(2), "ldrsh imm: {imm} not 2-byte aligned");
    let scaled = imm / 2;
    debug_assert!(scaled < 4096, "ldrsh imm: {imm} > 8190");
    0x7980_0000 | (scaled << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDRH <Wt>, [<Xn|SP>, #imm]` -- 16-bit load zero-extended into
/// `Wt` (which clears the high 32 bits of `Xt`), immediate offset
/// scaled by 2. Used by [`Op::Lhu`] for `unsigned short` lvalue
/// reads. Encoding: opc=01 (load), size=01.
pub(super) fn enc_ldrh_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm.is_multiple_of(2), "ldrh imm: {imm} not 2-byte aligned");
    let scaled = imm / 2;
    debug_assert!(scaled < 4096, "ldrh imm: {imm} > 8190");
    0x7940_0000 | (scaled << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STRH <Wt>, [<Xn|SP>, #imm]` -- 16-bit store (low half of `Wt`),
/// immediate offset scaled by 2. Companion to [`enc_ldrsh_imm`] /
/// [`enc_ldrh_imm`] for [`Op::Sh`].
pub(super) fn enc_strh_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm.is_multiple_of(2), "strh imm: {imm} not 2-byte aligned");
    let scaled = imm / 2;
    debug_assert!(scaled < 4096, "strh imm: {imm} > 8190");
    0x7900_0000 | (scaled << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDRB <Wt>, [<Xn|SP>, #imm]` -- byte load, zero-extended into a
/// 32-bit register (which on AArch64 means the high 32 bits of the
/// 64-bit register are also cleared). c4 promotes char to int on
/// load; this matches.
pub(super) fn enc_ldrb_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm < 4096, "ldrb imm: {imm} > 4095");
    0x3940_0000 | (imm << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDRSB <Xt>, [<Xn|SP>, #imm]` -- byte load sign-extended into
/// the full 64-bit `Xt`. Used by [`Op::Lcs`] for `signed char`
/// lvalue reads. Encoding: opc=10 (sign-extend to 64-bit),
/// size=00 (byte). Imm is unscaled (byte stride).
pub(super) fn enc_ldrsb_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    debug_assert!(imm < 4096, "ldrsb imm: {imm} > 4095");
    0x3980_0000 | (imm << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
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

// ---- Pre-/post-indexed loads & stores. The c5 VM stack push/pop
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
pub(super) enum BranchKind {
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
pub(super) struct Fixup {
    /// Byte offset within `code` where the placeholder branch lives.
    pub(super) native_offset: usize,
    /// Bytecode PC the branch is supposed to land on.
    pub(super) target_bytecode_pc: usize,
    pub(super) kind: BranchKind,
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
        pc += op.word_size();
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
        // External library call: load args from stack offsets
        // (x19-independent), call libc, then `mov x19, x0`. x19
        // is overwritten before any subsequent c4 op observes it.
        | JsrExt
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
    imports: &super::ResolvedImports,
) -> Result<Build, C5Error> {
    let abi = target.abi();

    // Run the regalloc analyzer once if `--optimize` is on. The
    // plan is consulted at each Op::Ent / Op::Psh / pop op so we
    // keep it in scope for the entire walk.
    // Pool sizing follows the user-picked allocator mode. The pool
    // sizes still matter under Ssa: a per-function SSA-emit bail
    // falls back to the pool walk for that function, which reads
    // these sizes.
    //   * Ssa:  callee + caller bank (default). The pool path is
    //           the per-function fallback.
    //   * Pool: callee + caller bank, the full classifier.
    //   * O0:   callee bank only -- caller-saved disabled, every
    //           pseudo push lands in callee-saved. Drops the perf
    //           win on short-lived nested arith but cuts the
    //           allocator's bookkeeping surface in half.
    let pool_sizes = match native.regalloc {
        super::RegallocMode::Pool | super::RegallocMode::Ssa => POOL_SIZES,
        super::RegallocMode::O0 => regalloc::PoolSizes {
            callee: POOL_SIZES.callee,
            caller: 0,
        },
    };
    let plan_storage: Option<RegStackPlan> = if native.optimize {
        Some(regalloc::analyze(&program.text, pool_sizes)?)
    } else {
        None
    };
    let plan: Option<&RegStackPlan> = plan_storage.as_ref();
    let mut reg_state = RegState::new(native.optimize, plan);

    // SSA emit gate. Active when `--regalloc=ssa` is in effect
    // (the default; `--regalloc=pool` opts out). The lift + the
    // allocator run on every function and the result feeds
    // `emit_function` at each `Op::Ent`; on success the SSA bytes
    // replace the pool walk for that function's PC range. Setting
    // `BADC_DUMP_SSA` prints each function's IR + allocation;
    // `BADC_STRICT_SSA_EMIT` flips a failing emit from
    // pool-fallback to a hard error.
    let ssa_funcs: alloc::vec::Vec<super::ssa::FunctionSsa>;
    let ssa_allocs: alloc::vec::Vec<super::ssa_alloc::Allocation>;
    let mut ssa_lookup: alloc::collections::BTreeMap<usize, usize> =
        alloc::collections::BTreeMap::new();
    let use_ssa_emit = matches!(native.regalloc, super::RegallocMode::Ssa);
    if matches!(native.regalloc, super::RegallocMode::Ssa) {
        ssa_funcs = super::ssa::lift_program(program)?;
        ssa_allocs = ssa_funcs
            .iter()
            .map(|f| super::ssa_alloc::allocate(f, target))
            .collect();
        #[cfg(feature = "std")]
        if super::ssa_dump::enabled() {
            for (f, a) in ssa_funcs.iter().zip(ssa_allocs.iter()) {
                eprint!("{}", super::ssa_dump::dump_function(f, a));
            }
        }
        for (i, f) in ssa_funcs.iter().enumerate() {
            ssa_lookup.insert(f.ent_pc, i);
        }
    } else {
        ssa_funcs = alloc::vec::Vec::new();
        ssa_allocs = alloc::vec::Vec::new();
    }

    // Pre-scan for branch targets so the cmp+branch fusion peephole
    // can refuse to fuse when the matching Bz/Bnz is reachable from
    // anywhere else. Cheap: one linear walk of `text`.
    let branch_targets = collect_branch_targets(&program.text);

    let mut code = Vec::new();
    let mut bytecode_to_native: Vec<usize> = vec![usize::MAX; program.text.len() + 1];
    let mut fixups: Vec<Fixup> = Vec::new();
    let mut got_fixups: Vec<GotFixup> = Vec::new();
    // Each `JsrExt` / `TailExt` site emits a placeholder
    // BL/B; the displacement gets backfilled once trampolines are
    // laid out at the tail of `code`.
    let mut plt_call_fixups: Vec<PltCallFixup> = Vec::new();
    let mut data_fixups: Vec<DataFixup> = Vec::new();
    // Function-pointer Imms get their target resolved post-walk against
    // `bytecode_to_native`, so we record (adrp_offset, target_bytecode_pc)
    // here and rewrite into `Build::func_fixups` once the map is final.
    let mut pending_func_fixups: Vec<(usize, usize)> = Vec::new();
    // Win64 TLS-index fixups -- one entry per `Op::TlsLea` site
    // when targeting Windows. The PE writer reserves the
    // `_tls_index` DWORD slot and patches each fixup with the
    // displacement to it.
    let mut tls_index_fixups: Vec<super::TlsIndexFixup> = Vec::new();
    // macOS arm64 TLV: each unique TLS variable's offset gets a
    // descriptor index; the writer emits a 24-byte
    // `__thread_vars` descriptor per index. Each `Op::TlsLea`
    // site records an `adrp + add` pair via `macho_tlv_fixups`.
    let mut macho_tlv_fixups: Vec<super::MachoTlvFixup> = Vec::new();
    let mut macho_tlv_descriptors: Vec<super::MachoTlvDescriptor> = Vec::new();

    // Compiler's data-Imm side channel as a sorted slice (binary search
    // is fine -- this list grows linearly with the number of distinct
    // string-literal / global references in the program).
    let data_imm_positions: &[usize] = &program.data_imm_positions;
    let code_imm_positions: &[usize] = &program.code_imm_positions;

    // Per-function metadata: declared parameter count and variadic
    // flag, keyed by each function's `Op::Ent` PC. Built once;
    // consumed by `Op::Ent` (prologue host-arg-reg spill), `Op::Lev`
    // (epilogue undo), and `Op::Jsr` (caller's host-ABI arg
    // marshalling for non-variadic targets).
    let funcs = super::scan_func_meta(program);
    let mut current_func: super::FuncMeta = super::FuncMeta::default();

    let mut pc = 0usize;
    while pc < program.text.len() {
        let op_pc = pc;
        bytecode_to_native[op_pc] = code.len();
        let raw = program.text[pc];
        let op = Op::from_i64(raw).ok_or_else(|| {
            C5Error::Compile(crate::c5::error::fmt_ice_bytecode(
                "aarch64 codegen: bad opcode -- the bytecode scanner \
                 drifted off the op/operand boundary or the op enum \
                 changed without updating from_i64",
                program,
                pc,
            ))
        })?;
        pc += 1;
        if matches!(op, Op::Ent) {
            current_func = funcs.get(&op_pc).copied().unwrap_or_default();
            // SSA emit replacement: when --regalloc=ssa is on
            // (the default), replace the pool path's bytecode
            // walk for this function with the SSA emit's output.
            // A failing function falls back to the pool walk for
            // this `Op::Ent`; `BADC_STRICT_SSA_EMIT` flips the
            // policy to a hard error.
            if use_ssa_emit {
                let ssa_idx = ssa_lookup.get(&op_pc).copied().ok_or_else(|| {
                    C5Error::Compile(crate::c5::error::fmt_internal_err(
                        "ssa emit: bytecode Op::Ent has no corresponding FunctionSsa",
                    ))
                })?;
                let func_ssa = &ssa_funcs[ssa_idx];
                let alloc_for = &ssa_allocs[ssa_idx];
                bytecode_to_native[op_pc] = code.len();
                let ok = super::ssa_emit_aarch64::emit_function(
                    func_ssa,
                    alloc_for,
                    target,
                    &mut code,
                    &mut fixups,
                    &mut plt_call_fixups,
                    &mut data_fixups,
                    &mut pending_func_fixups,
                    imports,
                    &program.variadic_functions,
                    &mut tls_index_fixups,
                    &mut macho_tlv_fixups,
                    &mut macho_tlv_descriptors,
                    &mut bytecode_to_native,
                );
                if !ok {
                    // The SSA emit truncated `code` back to the
                    // pre-attempt snapshot on failure, so no bytes
                    // leaked. Fall through to the pool path for
                    // this function. `BADC_STRICT_SSA_EMIT` flips
                    // the policy back to abort -- useful when
                    // driving the SSA emit toward parity.
                    #[cfg(feature = "std")]
                    if std::env::var("BADC_DUMP_SSA").is_ok()
                        || std::env::var("BADC_STRICT_SSA_EMIT").is_ok()
                    {
                        eprint!("{}", super::ssa_dump::dump_function(func_ssa, alloc_for),);
                    }
                    #[cfg(feature = "std")]
                    if std::env::var("BADC_STRICT_SSA_EMIT").is_ok() {
                        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                            &alloc::format!(
                                "ssa emit: function at ent_pc {op_pc} contains an op outside the implemented subset",
                            ),
                        )));
                    }
                } else {
                    // SSA emit succeeded for this function: skip
                    // the pool path's per-PC walk for the rest of
                    // the function. The SSA emit recorded
                    // `bytecode_to_native` for every block start
                    // it produced, so any in-range pcs (including
                    // absorbed sys trampolines) have their native
                    // offsets registered for downstream relocations.
                    let next_ent_pc = ssa_funcs
                        .get(ssa_idx + 1)
                        .map(|f| f.ent_pc)
                        .unwrap_or(program.text.len());
                    pc = next_ent_pc;
                    continue;
                }
            }
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
            &mut plt_call_fixups,
            &mut data_fixups,
            &mut pending_func_fixups,
            &mut tls_index_fixups,
            &mut macho_tlv_fixups,
            &mut macho_tlv_descriptors,
            data_imm_positions,
            code_imm_positions,
            current_func,
            &funcs,
            abi,
            &mut reg_state,
            op_pc,
            &branch_targets,
            imports,
            target,
            &program.call_fp_arg_masks,
        )?;
    }
    bytecode_to_native[program.text.len()] = code.len();

    apply_fixups(&mut code, &fixups, &bytecode_to_native, program.text.len())?;

    // Append one PLT trampoline per import. Every BL/B
    // placeholder recorded in `plt_call_fixups` now gets its imm26
    // backfilled to the matching trampoline's byte offset. The
    // trampoline body's adrp+ldr pair is patched by the per-format
    // writer through the same `GotFixup` shape the inline call
    // sequence used before PLT trampolines existed.
    let plt_trampoline_offsets =
        emit_plt_trampolines(&mut code, &mut got_fixups, imports.imports.len());
    apply_plt_call_fixups(&mut code, &plt_call_fixups, &plt_trampoline_offsets)?;

    // Function-pointer fixups resolve to each callee's body offset
    // directly: every function's prologue already spills the host
    // arg registers into the c5 cdecl slots that the body reads
    // via `Op::Lea`, so a host caller (`pthread_create`, `qsort`,
    // a static dispatch table, ...) can land on the body itself.
    // Variadic c5 functions keep the c5-stack-based ABI and reach
    // only via `Op::Jsri` callers that lay args onto the c5 stack
    // first; their fn-pointer fixups also land on the body, which
    // keeps that contract intact.
    let mut func_fixups: Vec<FuncFixup> = Vec::with_capacity(pending_func_fixups.len());
    for (adrp_offset, target_bc_pc) in pending_func_fixups {
        if target_bc_pc > program.text.len() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen: function pointer target {target_bc_pc} past end of bytecode"
                ),
            )));
        }
        let target = bytecode_to_native[target_bc_pc];
        if target == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen: function pointer target {target_bc_pc} did not land on an instruction"
                ),
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
            C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                "native codegen: entry_pc {} is out of bytecode range",
                program.entry_pc
            )))
        })?;
    if entry_offset == usize::MAX {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!(
                "native codegen: entry_pc {} did not align with any instruction start",
                program.entry_pc
            ),
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
        // `imports` is set by `lower_for` after this returns; the
        // resolver runs once up there and the value is shared with
        // both the lowering and the writer. Default-empty here keeps
        // the per-arch lowering oblivious to the resolver.
        imports: super::ResolvedImports::default(),
        abi: super::Abi::default(),
        tls_data: program.tls_data.clone(),
        tls_init_size: program.tls_init_size,
        tls_index_fixups,
        data_relocs: Vec::new(),
        code_relocs: Vec::new(),
        exports: Vec::new(),
        output_kind: super::OutputKind::Executable,
        dllmain_pc: None,
        macho_tlv_fixups,
        macho_tlv_descriptors,
        // Overwritten by `lower_for` from `NativeOptions::debug_info`.
        debug_info: true,
        plt_trampoline_offsets,
    })
}

/// Read the i64 operand following an opcode, advancing `pc` past it.
fn read_operand(text: &[i64], pc: &mut usize, op_name: &str) -> Result<i64, C5Error> {
    if *pc >= text.len() {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("native codegen: {op_name} missing operand at end of bytecode"),
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
) -> Result<(), C5Error> {
    for f in fixups {
        if f.target_bytecode_pc > bc_len {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen: branch target {} past end of bytecode",
                    f.target_bytecode_pc
                ),
            )));
        }
        let target = bc_to_native[f.target_bytecode_pc];
        if target == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen: branch target {} did not land on an instruction",
                    f.target_bytecode_pc
                ),
            )));
        }
        let pc_after = f.native_offset as isize;
        let delta_bytes = target as isize - pc_after;
        // All AArch64 branches measure the offset in instructions
        // (4 bytes each).
        if delta_bytes & 3 != 0 {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("native codegen: branch delta {delta_bytes} not 4-byte aligned"),
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
    plt_call_fixups: &mut Vec<PltCallFixup>,
    data_fixups: &mut Vec<DataFixup>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    macho_tlv_fixups: &mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &mut Vec<super::MachoTlvDescriptor>,
    data_imm_positions: &[usize],
    code_imm_positions: &[usize],
    current_func: super::FuncMeta,
    funcs: &alloc::collections::BTreeMap<usize, super::FuncMeta>,
    abi: Abi,
    reg_state: &mut RegState<'_>,
    op_pc: usize,
    branch_targets: &[bool],
    imports: &super::ResolvedImports,
    target: super::Target,
    fp_arg_masks: &[(usize, u32)],
) -> Result<(), C5Error> {
    match op {
        // ---- Function frame ----
        Op::Ent => {
            let locals = read_operand(text, pc, "Ent")?;
            let aligned_locals = (((locals as u32) * 8) + 15) & !15;
            reg_state.current_locals_bytes = aligned_locals;
            // Reset alloca state -- AllocaInit (emitted by the
            // compiler right after Ent) sets it back if this
            // function uses alloca.
            reg_state.current_alloca_top_offset = 0;
            // Non-variadic c5 functions receive their arguments in
            // host-ABI registers; the prologue spills them into the
            // c5 cdecl slots the body reads via `Op::Lea`. Variadic
            // c5 functions keep the c5-stack-based ABI: callers reach
            // them via the bare-bl shape with args already on the
            // c5 stack, so no spill happens here.
            let entry_n_params = (!current_func.is_variadic).then_some(current_func.n_params);
            emit_prologue(
                code,
                locals,
                entry_n_params,
                reg_state.current_callee_depth,
                target,
                abi,
            );
        }
        Op::Lev => {
            let entry_n_params = (!current_func.is_variadic).then_some(current_func.n_params);
            emit_epilogue(
                code,
                entry_n_params,
                reg_state.current_callee_depth,
                reg_state.current_locals_bytes,
                abi,
            );
        }
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
                emit_add_sp_imm(code, bytes);
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
            } else if code_imm_positions.binary_search(&operand_pc).is_ok() {
                // Function-pointer literal. The compiler tagged this
                // operand_pc explicitly so we don't have to infer
                // from the value's range -- a user constant in
                // [CODE_BASE, CODE_BASE + text.len()) would otherwise
                // be misclassified as a func ptr (e.g. 0x20000000
                // == CODE_BASE).
                let target_bc_pc = (v as usize) - CODE_BASE;
                let adrp_offset = code.len();
                pending_func_fixups.push((adrp_offset, target_bc_pc));
                emit_adrp_add_placeholder(code);
            } else if code_imm_positions.is_empty()
                && (v as usize) >= CODE_BASE
                && ((v as usize) - CODE_BASE) < text.len()
            {
                // Fallback heuristic for the optimized (-O) path,
                // which doesn't carry per-Imm provenance through
                // its peephole passes. This is the original c5
                // disambiguation rule and is correct for any
                // program whose constants stay below CODE_BASE
                // (= 0x20000000).
                let target_bc_pc = (v as usize) - CODE_BASE;
                let adrp_offset = code.len();
                pending_func_fixups.push((adrp_offset, target_bc_pc));
                emit_adrp_add_placeholder(code);
            } else {
                load_imm64(code, Reg::X19, v as u64);
            }
        }
        Op::Lea => {
            // c5 emits `Lea` offsets in 8-byte units (its VM uses one
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
        Op::Lcs => emit(code, enc_ldrsb_imm(Reg::X19, Reg::X19, 0)),
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
        Op::Lw => emit(code, enc_ldrsw_imm(Reg::X19, Reg::X19, 0)),
        Op::Lwu => emit(code, enc_ldr32_imm(Reg::X19, Reg::X19, 0)),
        Op::Sw => {
            let lhs = pop_lhs_reg(code, reg_state);
            // STR Wt encodes the same Rt as LDRSW Xt -- the W/X
            // distinction lives in the opcode bits, not the
            // register name. Pass X19; the encoder produces the
            // 32-bit store form regardless.
            emit(code, enc_str32_imm(Reg::X19, lhs, 0));
        }
        Op::Lh => emit(code, enc_ldrsh_imm(Reg::X19, Reg::X19, 0)),
        Op::Lhu => emit(code, enc_ldrh_imm(Reg::X19, Reg::X19, 0)),
        Op::Sh => {
            let lhs = pop_lhs_reg(code, reg_state);
            emit(code, enc_strh_imm(Reg::X19, lhs, 0));
        }
        Op::Lf => {
            // Single-precision load + widen-to-double:
            //   ldr  s0, [x19]   ; load 4 bytes through `s0`'s half of `d0`
            //   fcvt d0, s0      ; widen to double
            //   fmov x19, d0     ; deliver `f64::to_bits()` to the accumulator
            // The IEEE 754 single -> double widening is bit-exact
            // for every finite source value.
            emit(code, enc_ldr_s_imm(0, Reg::X19, 0));
            emit(code, enc_fcvt_d_s(0, 0));
            emit(code, enc_fmov_d_to_x(Reg::X19, 0));
        }
        Op::Sf => {
            // Narrow f64 -> f32 and store 4 bytes:
            //   fmov d0, x19     ; stage the accumulator as a double
            //   fcvt s0, d0      ; narrow with round-to-nearest-ties-to-even
            //   ldr  lhs, [sp]   ; (via pop_lhs_reg) destination address
            //   str  s0, [lhs]   ; write 4 bytes
            emit(code, enc_fmov_x_to_d(0, Reg::X19));
            emit(code, enc_fcvt_s_d(0, 0));
            let lhs = pop_lhs_reg(code, reg_state);
            emit(code, enc_str_s_imm(0, lhs, 0));
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

        // ---- Comparisons. The c5 VM does `popped <cmp> a`, which
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
        Op::Ult => lower_cmp(code, text, *pc, reg_state, branch_targets, Cond::Lo),
        Op::Ugt => lower_cmp(code, text, *pc, reg_state, branch_targets, Cond::Hi),
        Op::Ule => lower_cmp(code, text, *pc, reg_state, branch_targets, Cond::Ls),
        Op::Uge => lower_cmp(code, text, *pc, reg_state, branch_targets, Cond::Hs),

        // ---- Shifts. Shr is arithmetic (signed); Shru is logical
        //      (unsigned), emitted when the LHS has an unsigned type.
        Op::Shl => binop_with_pop(code, reg_state, enc_lslv),
        Op::Shr => binop_with_pop(code, reg_state, enc_asrv),
        Op::Shru => binop_with_pop(code, reg_state, enc_lsrv),

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
        Op::Divu => binop_with_pop(code, reg_state, enc_udiv),
        Op::Modu => {
            // Same shape as Op::Mod but with UDIV instead of SDIV.
            // The MSUB stays as-is: subtraction is sign-agnostic at the
            // 64-bit register level since both operands fit in u64
            // (the divisor and dividend are both <= 2^63 here, and
            // wrap-around modulo 2^64 yields the same low bits).
            let lhs = pop_lhs_reg(code, reg_state);
            emit(code, enc_udiv(Reg::X17, lhs, Reg::X19));
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
            let target_pc = read_operand(text, pc, "Jsr")? as usize;
            let callee_is_variadic = funcs
                .get(&target_pc)
                .map(|m| m.is_variadic)
                .unwrap_or(false);
            // Variadic c5 callees keep the c5-stack-based ABI: the
            // body reads its args via `Op::Lea` from the slots the
            // caller's preceding `Op::Psh`es laid down, and
            // `va_start` walks the same slots. Emit a bare `bl`
            // and let the c5 stack carry the args through.
            if callee_is_variadic {
                fixups.push(Fixup {
                    native_offset: code.len(),
                    target_bytecode_pc: target_pc,
                    kind: BranchKind::Bl,
                });
                emit(code, 0);
                emit_mov_reg(code, Reg::X19, Reg::X0);
            } else {
                // Non-variadic target: marshal the preceding `Op::Psh`
                // args from their c5-stack slots into host arg
                // registers (and overflow onto the host stack past
                // x7), matching `Op::Jsri`'s shape. The callee's
                // prologue spills the same registers back into its
                // own c5 slots, where the body's `Op::Lea` reads
                // them. The caller's c5-stack slots stay where they
                // are; the trailing `Op::Adj N` drops them.
                let nargs = match Op::from_i64(text.get(*pc).copied().unwrap_or(0)) {
                    Some(Op::Adj) => text[*pc + 1] as usize,
                    _ => 0,
                };
                let n_reg = nargs.min(abi.int_arg_regs.len());
                let n_stack = nargs - n_reg;
                let scratch = ((n_stack as u32) * 8 + 15) & !15;
                if scratch > 0 {
                    emit(code, enc_sub_imm(Reg::SP, Reg::SP, scratch));
                }
                for i in 0..n_reg {
                    let off = scratch + (i as u32) * 16;
                    emit(code, enc_ldr_imm(Reg(abi.int_arg_regs[i]), Reg::SP, off));
                }
                for i in 0..n_stack {
                    let src = scratch + ((n_reg + i) as u32) * 16;
                    let dst = (i as u32) * 8;
                    emit(code, enc_ldr_imm(Reg::X16, Reg::SP, src));
                    emit(code, enc_str_imm(Reg::X16, Reg::SP, dst));
                }
                fixups.push(Fixup {
                    native_offset: code.len(),
                    target_bytecode_pc: target_pc,
                    kind: BranchKind::Bl,
                });
                emit(code, 0);
                if scratch > 0 {
                    emit(code, enc_add_imm(Reg::SP, Reg::SP, scratch));
                }
                emit_mov_reg(code, Reg::X19, Reg::X0);
            }
        }
        Op::Jsri => {
            // Indirect call: target address in x19, args already
            // pushed onto the VM stack in 16-byte slots by preceding
            // Op::Psh's. The callee may be a libc target (reads from
            // x0..x7 + the host stack past x7) or a c5 target (reads
            // from `bp + offset` after the per-function arg-shuffle
            // thunk re-spills the regs). Either way: load the first
            // 8 c5-stack args into x0..x7, copy the rest contiguously
            // onto the host stack (AAPCS64 puts args 9+ at sp+0,
            // sp+8, ... at the call site), call, clean up.
            let nargs = match Op::from_i64(text.get(*pc).copied().unwrap_or(0)) {
                Some(Op::Adj) => text[*pc + 1] as usize,
                _ => 0,
            };
            let n_reg = nargs.min(8);
            let n_stack = nargs - n_reg;
            let scratch = ((n_stack as u32) * 8 + 15) & !15;
            if scratch > 0 {
                emit(code, enc_sub_imm(Reg::SP, Reg::SP, scratch));
            }
            // Reg args. With cdecl push order, c5-arg-i sits at
            // [sp + scratch + i*16] (first declared on top).
            for i in 0..n_reg {
                let off = scratch + (i as u32) * 16;
                emit(code, enc_ldr_imm(Reg(i as u8), Reg::SP, off));
            }
            // Stack args -- copy from the c5 stack down to the
            // host's outgoing-args region. x16 is AAPCS64 scratch.
            for i in 0..n_stack {
                let src = scratch + ((n_reg + i) as u32) * 16;
                let dst = (i as u32) * 8;
                emit(code, enc_ldr_imm(Reg::X16, Reg::SP, src));
                emit(code, enc_str_imm(Reg::X16, Reg::SP, dst));
            }
            // Move the function pointer into x16 so the callee's
            // prologue/epilogue can't trample our accumulator slot.
            // (Doing this AFTER the stack-arg copy is OK because the
            // copy clobbered x16 last; we now reload it.)
            emit_mov_reg(code, Reg::X16, Reg::X19);
            emit(code, enc_blr(Reg::X16));
            if scratch > 0 {
                emit(code, enc_add_imm(Reg::SP, Reg::SP, scratch));
            }
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
        Op::ShruI => imm_arith(code, text, pc, "ShruI", enc_lsrv)?,
        Op::EqI => imm_cmp(code, text, pc, "EqI", Cond::Eq, reg_state, branch_targets)?,
        Op::NeI => imm_cmp(code, text, pc, "NeI", Cond::Ne, reg_state, branch_targets)?,
        Op::LtI => imm_cmp(code, text, pc, "LtI", Cond::Lt, reg_state, branch_targets)?,
        Op::GtI => imm_cmp(code, text, pc, "GtI", Cond::Gt, reg_state, branch_targets)?,
        Op::LeI => imm_cmp(code, text, pc, "LeI", Cond::Le, reg_state, branch_targets)?,
        Op::GeI => imm_cmp(code, text, pc, "GeI", Cond::Ge, reg_state, branch_targets)?,
        Op::UltI => imm_cmp(code, text, pc, "UltI", Cond::Lo, reg_state, branch_targets)?,
        Op::UgtI => imm_cmp(code, text, pc, "UgtI", Cond::Hi, reg_state, branch_targets)?,
        Op::UleI => imm_cmp(code, text, pc, "UleI", Cond::Ls, reg_state, branch_targets)?,
        Op::UgeI => imm_cmp(code, text, pc, "UgeI", Cond::Hs, reg_state, branch_targets)?,
        Op::LdLocI => {
            // `Lea N + Li` fused. a = *(bp + N*8)
            let offset = read_operand(text, pc, "LdLocI")?;
            emit_local_load(code, offset, /*byte=*/ false);
        }
        Op::LdLocC => {
            let offset = read_operand(text, pc, "LdLocC")?;
            emit_local_load(code, offset, /*byte=*/ true);
        }
        Op::StLocI => {
            // `*(bp + N*8) = a` -- store accumulator to a local
            // frame slot. Mirrors `emit_local_load` with a store.
            let offset = read_operand(text, pc, "StLocI")?;
            let bytes = lea_offset_bytes(offset);
            if (-256..256).contains(&bytes) {
                emit(code, enc_stur(Reg::X19, Reg::X29, bytes as i32));
            } else {
                let abs = bytes.unsigned_abs();
                if abs < 4096 {
                    let imm = abs as u32;
                    let word = if bytes >= 0 {
                        enc_add_imm(Reg::X16, Reg::X29, imm)
                    } else {
                        enc_sub_imm(Reg::X16, Reg::X29, imm)
                    };
                    emit(code, word);
                } else {
                    load_imm64(code, Reg::X17, abs);
                    let word = if bytes >= 0 {
                        enc_add_reg(Reg::X16, Reg::X29, Reg::X17)
                    } else {
                        enc_sub_reg(Reg::X16, Reg::X29, Reg::X17)
                    };
                    emit(code, word);
                }
                emit(code, enc_str_imm(Reg::X19, Reg::X16, 0));
            }
        }

        // ---- External library call -- lower to a libc call
        //      through __got. ----
        Op::JsrExt => {
            let jsrext_pc = *pc - 1;
            let binding_idx = read_operand(text, pc, "JsrExt")?;
            let fp_mask = fp_arg_mask_at(jsrext_pc, fp_arg_masks);
            emit_libc_call(
                binding_idx,
                text,
                *pc,
                code,
                plt_call_fixups,
                abi,
                imports,
                fp_mask,
                target,
            )?;
        }
        Op::TailExt => {
            // Tail-jump trampoline body. See the matching x86_64
            // arm + the `Op::TailExt` doc in op.rs for the
            // calling-convention bookkeeping; on aarch64 the
            // sequence is `adrp x16, GOT; ldr x16, [x16, off];
            // br x16`, which the writer patches the same way as
            // the regular GOT-call shape.
            let binding_idx = read_operand(text, pc, "TailExt")?;
            let import_index = imports.index_of_binding(binding_idx).ok_or_else(|| {
                C5Error::Compile(crate::c5::error::fmt_internal_err(&alloc::format!(
                    "native codegen (aarch64): no import slot for binding {binding_idx} -- \
                     the resolver should have placed it"
                )))
            })?;
            emit_got_tail_jump(code, plt_call_fixups, import_index);
        }
        Op::Intrinsic => {
            let id = read_operand(text, pc, "Intrinsic")?;
            let intrinsic = crate::c5::op::Intrinsic::from_i64(id).ok_or_else(|| {
                C5Error::Compile(crate::c5::error::fmt_internal_err(&alloc::format!(
                    "native codegen (aarch64): unknown intrinsic id {id}"
                )))
            })?;
            match intrinsic {
                crate::c5::op::Intrinsic::Alloca => {
                    // alloca(n): bump the per-frame arena's top
                    // pointer down by n (rounded up to 16), store
                    // the new top back into the bookkeeping slot,
                    // and return the new top in x19. The arena
                    // lives at a fixed FP-relative offset
                    // reserved by `Op::Ent` and pointed at by
                    // `current_alloca_top_offset`, which an
                    // earlier `Op::AllocaInit` filled in. SP is
                    // untouched, so outstanding `Op::Psh` values
                    // stay where they are and matching pops still
                    // resolve correctly -- the design trade-off
                    // is a fixed per-function arena size rather
                    // than the unlimited runtime SP bump that a
                    // native alloca would do.
                    let top_offset = reg_state.current_alloca_top_offset;
                    if top_offset == 0 {
                        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                            "native codegen (aarch64): Op::Intrinsic(Alloca) emitted \
                             without a preceding AllocaInit; the compiler should have \
                             patched both at function-end",
                        )));
                    }
                    // x19 holds the requested size. Round up to a
                    // 16-byte multiple so each returned pointer is
                    // aligned for any scalar type.
                    emit(code, enc_add_imm(Reg::X19, Reg::X19, 15));
                    // and x19, x19, #~15 -- bit pattern is the
                    // logical-imm encoding for the 64-bit mask
                    // 0xFFFF_FFFF_FFFF_FFF0 (4 zero low bits).
                    emit(code, enc_and_imm_neg16(Reg::X19, Reg::X19));
                    // Load current alloca-top from `[fp, -top_offset]`.
                    // Compute the slot's address in x16 to sidestep
                    // ldr/str's signed-9-bit and unsigned-12-bit
                    // immediate ranges for deep frames.
                    if top_offset < 4096 {
                        emit(code, enc_sub_imm(Reg::X16, Reg::X29, top_offset));
                    } else {
                        let high = top_offset & !0xfff;
                        let low = top_offset & 0xfff;
                        emit(code, enc_sub_imm_lsl12(Reg::X16, Reg::X29, high >> 12));
                        if low != 0 {
                            emit(code, enc_sub_imm(Reg::X16, Reg::X16, low));
                        }
                    }
                    emit(code, enc_ldr_imm(Reg::X17, Reg::X16, 0));
                    emit(code, enc_sub_reg(Reg::X17, Reg::X17, Reg::X19));
                    emit(code, enc_str_imm(Reg::X17, Reg::X16, 0));
                    // Result (the new alloca-top) goes back into
                    // x19, the c5 accumulator.
                    emit_mov_reg(code, Reg::X19, Reg::X17);
                }
                crate::c5::op::Intrinsic::SetjmpAArch64 => {
                    emit_setjmp_aarch64(code);
                }
                crate::c5::op::Intrinsic::LongjmpAArch64 => {
                    emit_longjmp_aarch64(code, reg_state);
                }
                crate::c5::op::Intrinsic::VaStart => {
                    // `__builtin_va_start(&ap, &last)`. &ap was the
                    // last argument pushed; x19 holds &last. The
                    // analyzer may have left &ap either on the real
                    // c5 stack (Op::Psh -> str x19, [sp,-16]!) or
                    // promoted to a pool register (mov x9, x19) --
                    // pop_lhs_reg handles both cases. Move the popped
                    // value into x16 so the rest of the sequence has
                    // a stable address base.
                    let ap_src = pop_lhs_reg(code, reg_state);
                    emit_mov_reg(code, Reg::X16, ap_src);
                    // x17 = &last + 16 (next c5 slot).
                    emit(code, enc_add_imm(Reg::X17, Reg::X19, 16));
                    // *ap = x17.
                    emit(code, enc_str_imm(Reg::X17, Reg::X16, 0));
                }
                crate::c5::op::Intrinsic::VaArg => {
                    // `__builtin_va_arg(&ap)` returns the
                    // pointer to the just-vacated 8-byte slot
                    // and advances `*ap` by one c5 slot. The
                    // <stdarg.h> macro casts the pointer to T
                    // and dereferences. x19 holds &ap on entry.
                    // x16 = *ap (cursor).
                    emit(code, enc_ldr_imm(Reg::X16, Reg::X19, 0));
                    // Result: x19 = cursor (pointer to slot
                    // about to be vacated).
                    emit_mov_reg(code, Reg::X17, Reg::X16);
                    // Advance: x16 += 16.
                    emit(code, enc_add_imm(Reg::X16, Reg::X16, 16));
                    // Store: *ap = x16.
                    emit(code, enc_str_imm(Reg::X16, Reg::X19, 0));
                    // Move pointer-result into the accumulator.
                    emit_mov_reg(code, Reg::X19, Reg::X17);
                }
                crate::c5::op::Intrinsic::VaEnd => {
                    // `__builtin_va_end(&ap)` -- no-op. The
                    // arg sits in x19; nothing to do.
                }
                crate::c5::op::Intrinsic::VaCopy => {
                    // `__builtin_va_copy(&dst, &src)`. &dst was the
                    // last argument pushed; x19 holds &src. On the
                    // c5-cursor model va_list is one pointer, so the
                    // copy is `*dst = *src`. pop_lhs_reg unifies the
                    // pseudo / real push paths.
                    let dst_src = pop_lhs_reg(code, reg_state);
                    emit_mov_reg(code, Reg::X16, dst_src);
                    emit(code, enc_ldr_imm(Reg::X17, Reg::X19, 0));
                    emit(code, enc_str_imm(Reg::X17, Reg::X16, 0));
                }
            }
        }
        Op::AllocaInit => {
            // operand = FP-slot index of the alloca-top pointer
            // (positive, in 8-byte units). Zero means the
            // function doesn't use alloca -- emit nothing.
            let slot_idx = read_operand(text, pc, "AllocaInit")?;
            if slot_idx > 0 {
                let top_offset = (slot_idx as u32) * 8;
                reg_state.current_alloca_top_offset = top_offset;
                // Initial alloca-top points at the bookkeeping
                // slot itself, i.e. the address one byte past the
                // top of the arena. The first alloca(n) subtracts
                // n from this and lands inside the arena
                // (slot_idx + 1 .. slot_idx + ARENA_SLOTS).
                if top_offset < 4096 {
                    emit(code, enc_sub_imm(Reg::X16, Reg::X29, top_offset));
                } else {
                    let high = top_offset & !0xfff;
                    let low = top_offset & 0xfff;
                    emit(code, enc_sub_imm_lsl12(Reg::X16, Reg::X29, high >> 12));
                    if low != 0 {
                        emit(code, enc_sub_imm(Reg::X16, Reg::X16, low));
                    }
                }
                emit(code, enc_str_imm(Reg::X16, Reg::X16, 0));
            }
        }

        // ---- Floating-point arithmetic ----
        //
        // Pop top into a GPR, stage both operands into d0/d1, run
        // the FP op into d0, copy back to x19. The arithmetic
        // ordering matches the c5 stack convention: `top <op> acc`.
        // d0/d1/d2 are AAPCS64 caller-saved scratch -- safe to
        // clobber between c5-level ops.
        Op::Fadd => emit_fp_binop(code, reg_state, enc_fadd_d),
        Op::Fsub => emit_fp_binop(code, reg_state, enc_fsub_d),
        Op::Fmul => emit_fp_binop(code, reg_state, enc_fmul_d),
        Op::Fdiv => emit_fp_binop(code, reg_state, enc_fdiv_d),
        Op::Fneg => {
            // Unary -- no pop. Stage acc into d0, negate, copy back.
            emit(code, enc_fmov_x_to_d(0, Reg::X19));
            emit(code, enc_fneg_d(0, 0));
            emit(code, enc_fmov_d_to_x(Reg::X19, 0));
        }
        Op::Feq => emit_fp_cmp(code, reg_state, Cond::Eq),
        Op::Fne => emit_fp_cmp(code, reg_state, Cond::Ne),
        Op::Flt => emit_fp_cmp(code, reg_state, Cond::Mi),
        Op::Fgt => emit_fp_cmp(code, reg_state, Cond::Gt),
        Op::Fle => emit_fp_cmp(code, reg_state, Cond::Ls),
        Op::Fge => emit_fp_cmp(code, reg_state, Cond::Ge),
        Op::Fcvtfi => {
            // x19 <- (i64)(d0 = f64::from_bits(x19))
            emit(code, enc_fmov_x_to_d(0, Reg::X19));
            emit(code, enc_fcvtzs_x_d(Reg::X19, 0));
        }
        Op::Fcvtif => {
            // x19 <- (d0 = (f64)x19).to_bits()
            emit(code, enc_scvtf_d_x(0, Reg::X19));
            emit(code, enc_fmov_d_to_x(Reg::X19, 0));
        }
        Op::TlsLea => {
            // `_Thread_local` global access. Two lowerings live
            // here:
            //
            // * Linux/aarch64 -- variant-1 layout:
            //   `var_addr = TPIDR_EL0 + 16 + offset` where 16 is
            //   the TLS_TCB_SIZE constant glibc reserves ahead of
            //   the TLS image. Encoding stays inside `add
            //   (immediate)`'s 12-bit field for variables under
            //   4080 bytes from the start of `.tdata`.
            //
            // * Windows/aarch64 -- TLS directory + `_tls_index`:
            //   the loader fills in `_tls_index` (a DWORD) with
            //   the slot it picked, and stores per-thread TLS
            //   pointers in `TEB->ThreadLocalStoragePointer` at
            //   `[x18 + 0x58]`. Per access:
            //       ldr  x16, [x18, #0x58]           ; tls_array
            //       adrp x17, _tls_index_page        ; (writer-patched)
            //       ldr  w17, [x17, #_tls_index_off] ; (writer-patched)
            //       ldr  x16, [x16, x17, lsl #3]     ; tls_array[index]
            //       add  x19, x16, #offset           ; final address
            //   Same `add (immediate)` 12-bit limit on the
            //   per-variable offset.
            let offset = read_operand(text, pc, "TlsLea")?;
            match target {
                Target::LinuxAarch64 => {
                    let imm = (offset + 16) as u32;
                    if imm >= 4096 {
                        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                            &format!(
                                "_Thread_local offset {imm} doesn't fit in \
                             `add` imm12; extend the lowering to emit \
                             movz/movk if you need larger TLS blocks"
                            ),
                        )));
                    }
                    emit(code, enc_mrs_tpidr_el0(Reg::X19));
                    emit(code, enc_add_imm(Reg::X19, Reg::X19, imm));
                }
                Target::WindowsAarch64 => {
                    if offset >= 4096 {
                        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                            &format!(
                                "_Thread_local offset {offset} doesn't fit in \
                             `add` imm12; extend the lowering to emit \
                             movz/movk if you need larger TLS blocks"
                            ),
                        )));
                    }
                    // ldr x16, [x18, #0x58]
                    emit(code, enc_ldr_imm(Reg::X16, Reg::X18, 0x58));
                    // adrp x17, _tls_index ; ldr w17, [x17, #_tls_index_off]
                    // The pair is patched by the PE writer once the
                    // _tls_index slot's RVA is known.
                    let pair_off = code.len();
                    tls_index_fixups.push(super::TlsIndexFixup {
                        instr_offset: pair_off,
                    });
                    emit(code, enc_adrp(Reg::X17, 0));
                    emit(code, enc_ldr32_imm(Reg::X17, Reg::X17, 0));
                    // ldr x16, [x16, x17, lsl #3]
                    emit(code, enc_ldr_reg_lsl3(Reg::X16, Reg::X16, Reg::X17));
                    // add x19, x16, #offset
                    emit(code, enc_add_imm(Reg::X19, Reg::X16, offset as u32));
                }
                Target::MacOSAarch64 => {
                    // Apple TLV (Thread-Local Variables): each
                    // `_Thread_local` global gets a 24-byte
                    // `__thread_vars` descriptor in `__DATA`.
                    // Slot 0 of the descriptor is a function
                    // pointer to a getter routine -- bound to
                    // `__tlv_bootstrap` from libSystem at load
                    // time, replaced with a fast getter on first
                    // access. The getter takes the descriptor
                    // address in x0 and returns the variable's
                    // per-thread address in x0.
                    //
                    // Sequence:
                    //     adrp x0, descriptor_page    (writer-patched)
                    //     add  x0, x0, #descriptor_off (writer-patched)
                    //     ldr  x16, [x0]              ; thunk getter
                    //     blr  x16                    ; x0 = &var
                    //     mov  x19, x0                ; copy to acc
                    let descriptor_index = match macho_tlv_descriptors
                        .iter()
                        .position(|d| d.offset_in_block == offset as u64)
                    {
                        Some(i) => i,
                        None => {
                            macho_tlv_descriptors.push(super::MachoTlvDescriptor {
                                offset_in_block: offset as u64,
                            });
                            macho_tlv_descriptors.len() - 1
                        }
                    };
                    let adrp_off = code.len();
                    macho_tlv_fixups.push(super::MachoTlvFixup {
                        adrp_offset: adrp_off,
                        descriptor_index,
                    });
                    // adrp x0, _ ; add x0, x0, #_ -- placeholder.
                    emit(code, enc_adrp(Reg::X0, 0));
                    emit(code, enc_add_imm(Reg::X0, Reg::X0, 0));
                    // ldr x16, [x0]
                    emit(code, enc_ldr_imm(Reg::X16, Reg::X0, 0));
                    // blr x16
                    emit(code, enc_blr(Reg::X16));
                    // mov x19, x0
                    emit_mov_reg(code, Reg::X19, Reg::X0);
                }
                _ => {
                    return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                        &format!(
                            "{:?}: `_Thread_local` codegen is only implemented for \
                         Linux/aarch64, Windows/aarch64, and macOS/aarch64",
                            target
                        ),
                    )));
                }
            }
        }
        Op::Mcpy => {
            // src = x19, dst = pop. Copy `size` bytes (size is a
            // compile-time constant), then x19 = dst (memcpy
            // returns dst). Compile-time unrolled into 8-byte
            // word copies + a tail of byte copies for any sub-8
            // remainder. Struct fields land on 8-byte alignment so
            // the byte tail is nominal, but lowering it inline
            // means the IR doesn't need a separate "small-mcpy"
            // op. Note: `pop_lhs_reg` may hand back x16 from the
            // real-stack path, so the per-iteration temp uses x17
            // (the other AAPCS64-reserved scratch) to avoid
            // overwriting `dst`.
            let size = read_operand(text, pc, "Mcpy")?;
            let dst = pop_lhs_reg(code, reg_state);
            // Copy whole 8-byte words via the scaled 12-bit
            // unsigned-offset `LDR/STR` form (byte offsets
            // 0..32760, multiples of 8). The earlier shape used
            // `ldur/stur`, whose 9-bit signed offset silently
            // wrapped for any byte offset >= 256, mis-copying
            // every word past the 32nd; struct-copy of types
            // > 256 bytes (sqlite's internal handles, stb_vorbis's
            // ~1.9 KB stb_vorbis struct, ...) produced zeroed
            // or shifted regions and downstream "the field I
            // just wrote reads back as 0" mysteries.
            let words = size / 8;
            for w in 0..words {
                let off = (w * 8) as u32;
                emit(code, enc_ldr_imm(Reg::X17, Reg::X19, off));
                emit(code, enc_str_imm(Reg::X17, dst, off));
            }
            // Byte tail. `ldrb`/`strb` (immediate, unscaled) take
            // a 12-bit unsigned offset (range 0..4095), so any
            // sub-word tail fits without the wrap-around risk.
            let tail_start = words * 8;
            for i in 0..(size - tail_start) {
                let off = (tail_start + i) as u32;
                emit(code, enc_ldrb_imm(Reg::X17, Reg::X19, off));
                emit(code, enc_strb_imm(Reg::X17, dst, off));
            }
            emit_mov_reg(code, Reg::X19, dst);
        }
    }
    Ok(())
}

/// Two-operand FP arithmetic lowering: pop top into a GPR, stage
/// both operands into d0/d1, run `enc_op(0, 0, 1)` (so the result
/// is `top <op> acc`), and copy d0 back to x19.
fn emit_fp_binop(
    code: &mut Vec<u8>,
    reg_state: &mut RegState<'_>,
    enc_op: impl Fn(u8, u8, u8) -> u32,
) {
    let lhs = pop_lhs_reg(code, reg_state);
    emit(code, enc_fmov_x_to_d(0, lhs)); // d0 = top
    emit(code, enc_fmov_x_to_d(1, Reg::X19)); // d1 = acc
    emit(code, enc_op(0, 0, 1)); // d0 = d0 <op> d1
    emit(code, enc_fmov_d_to_x(Reg::X19, 0));
}

/// jmp_buf field offsets for the AArch64 setjmp / longjmp
/// intrinsics. Lays out 10 callee-saved x-regs, FP (x29), the
/// resume PC, SP, and 8 callee-saved d-regs. Total 168 bytes;
/// the `<setjmp.h>` typedef reserves 256 to leave slack for
/// future additions.
const JB_X19_OFF: u32 = 0;
const JB_X21_OFF: u32 = 16;
const JB_X23_OFF: u32 = 32;
const JB_X25_OFF: u32 = 48;
const JB_X27_OFF: u32 = 64;
const JB_X29_OFF: u32 = 80;
const JB_PC_OFF: u32 = 88;
const JB_SP_OFF: u32 = 96;
const JB_D8_OFF: u32 = 104;
const JB_D10_OFF: u32 = 120;
const JB_D12_OFF: u32 = 136;
const JB_D14_OFF: u32 = 152;
/// Total instruction count emitted by `emit_setjmp_aarch64` --
/// every entry is one 4-byte AArch64 word. Used to compute the
/// PC-relative offset the ADR captures so a matching longjmp
/// branches to exactly the byte after the inline expansion.
/// Layout: 1 mov + 10 str(x19-x28) + 1 str(x29) + 1 adr + 1
/// str(pc) + 1 add(sp) + 1 str(sp) + 8 str(d8-d15) + 1 movz =
/// 25 instructions; ADR sits at zero-based index 12.
const SETJMP_AARCH64_INSN_COUNT: i32 = 25;
const SETJMP_AARCH64_ADR_INSN_INDEX: i32 = 12;

/// AArch64 setjmp inlined at the call site. The `env` pointer
/// arrives in `x19` (c5's accumulator). On the initial call this
/// writes the resume context into `[env]` and sets `x19 = 0`; on
/// a matching longjmp control jumps to the address right after
/// the inline expansion with `x19` carrying the longjmp value.
///
/// This is CRT-independent so it works on Windows AArch64, whose
/// msvcrt `longjmp` routes through SEH and refuses an SEH-free
/// `jmp_buf`. The Linux / macOS bindings continue to use the
/// host libc setjmp -- that's already CRT-independent.
fn emit_setjmp_aarch64(code: &mut Vec<u8>) {
    let start = code.len();
    // Move env from x19 into x16 (the existing IP0 scratch the
    // surrounding code already treats as a compiler temp) so the
    // upcoming saves can write x19 itself before x19 is clobbered
    // with the return value 0.
    emit(code, enc_mov_reg(Reg::X16, Reg::X19));
    // Save x19-x28 one by one. STR / LDR keeps the code simple
    // (no STP encoder family beyond pre-indexed) and the linear
    // sequence costs ~10 extra instructions per pair, irrelevant
    // for a routine called once per pcall.
    for (i, off) in (JB_X19_OFF..JB_X29_OFF).step_by(8).enumerate() {
        emit(code, enc_str_imm(Reg(19 + i as u8), Reg::X16, off));
    }
    emit(code, enc_str_imm(Reg::X29, Reg::X16, JB_X29_OFF));
    // ADR's PC-relative offset is from this instruction's PC to
    // the byte after the inline expansion. The expansion is
    // SETJMP_AARCH64_INSN_COUNT instructions long, and the ADR
    // sits at index SETJMP_AARCH64_ADR_INSN_INDEX.
    let adr_off_bytes = (SETJMP_AARCH64_INSN_COUNT - SETJMP_AARCH64_ADR_INSN_INDEX) * 4;
    debug_assert_eq!(
        code.len() - start,
        (SETJMP_AARCH64_ADR_INSN_INDEX as usize) * 4,
        "setjmp ADR offset out of sync with instruction count"
    );
    emit(code, enc_adr(Reg::X17, adr_off_bytes));
    emit(code, enc_str_imm(Reg::X17, Reg::X16, JB_PC_OFF));
    // mov x17, sp -- ADD form because the source is SP.
    emit(code, enc_add_imm(Reg::X17, Reg::SP, 0));
    emit(code, enc_str_imm(Reg::X17, Reg::X16, JB_SP_OFF));
    for (i, off) in (JB_D8_OFF..JB_D8_OFF + 64).step_by(8).enumerate() {
        emit(code, enc_str_d_imm(8 + i as u8, Reg::X16, off));
    }
    // First-call return value: 0.
    emit(code, enc_movz(Reg::X19, 0, 0));
    debug_assert_eq!(
        code.len() - start,
        (SETJMP_AARCH64_INSN_COUNT as usize) * 4,
        "setjmp instruction count drift"
    );
    // Fall through. A future longjmp lands here too with x19=val.
}

/// AArch64 longjmp inlined at the call site. The c5 emitter
/// pushed `env` onto the 16-byte VM stack slot before evaluating
/// `val`, so on entry `env` is at `[sp]` and `val` is in `x19`.
/// Does not return to its own caller -- branches back to the
/// PC saved by the matching setjmp with the C99-required value
/// in `x19` (1 if `val` was 0, otherwise `val`).
fn emit_longjmp_aarch64(code: &mut Vec<u8>, reg_state: &mut RegState<'_>) {
    // env was pushed before val was evaluated. pop_lhs_reg
    // handles both the real-stack push (`ldr x16, [sp], #16`)
    // and the pseudo-promotion case (the value lives in a pool
    // register the analyzer assigned). Move env into x16
    // unconditionally so the rest of this routine has a single
    // base reg to address.
    let env_src = pop_lhs_reg(code, reg_state);
    emit_mov_reg(code, Reg::X16, env_src);
    // Stash val in a scratch before the upcoming restores
    // clobber x19. x17 (IP1) is already a compiler scratch in
    // this module.
    emit(code, enc_mov_reg(Reg::X17, Reg::X19));
    for (i, off) in (JB_X19_OFF..JB_X29_OFF).step_by(8).enumerate() {
        emit(code, enc_ldr_imm(Reg(19 + i as u8), Reg::X16, off));
    }
    emit(code, enc_ldr_imm(Reg::X29, Reg::X16, JB_X29_OFF));
    // Hoist the resume PC out of the env into x10 (a caller-
    // saved AAPCS64 temp; setjmp's caller has no expectation
    // that x10 survives). x18 is reserved on Windows AArch64
    // for the TEB pointer, so anything that loads through it
    // (TLS, msvcrt internals) must see TEB unmodified.
    emit(code, enc_ldr_imm(Reg(10), Reg::X16, JB_PC_OFF));
    emit(code, enc_ldr_imm(Reg(9), Reg::X16, JB_SP_OFF));
    // mov sp, x9 -- ADD form because the destination is SP.
    emit(code, enc_add_imm(Reg::SP, Reg(9), 0));
    for (i, off) in (JB_D8_OFF..JB_D8_OFF + 64).step_by(8).enumerate() {
        emit(code, enc_ldr_d_imm(8 + i as u8, Reg::X16, off));
    }
    // cmp val, #0 ; cinc x19, val, eq -- 0 becomes 1, anything
    // else passes through. `subs xzr, x17, 0` is `cmp x17, #0`.
    emit(code, enc_subs_imm(Reg(31), Reg::X17, 0));
    emit(code, enc_cinc(Reg::X19, Reg::X17, Cond::Eq));
    // Branch to the saved resume PC (loaded into x10 above).
    emit(code, enc_br(Reg(10)));
}

/// FP comparison: `x19 = (top <cond> acc) ? 1 : 0`. d0/d1 hold
/// `top` and `acc` respectively; FCMP sets NZCV; CSET reads the
/// requested condition into x19.
fn emit_fp_cmp(code: &mut Vec<u8>, reg_state: &mut RegState<'_>, cond: Cond) {
    let lhs = pop_lhs_reg(code, reg_state);
    emit(code, enc_fmov_x_to_d(0, lhs));
    emit(code, enc_fmov_x_to_d(1, Reg::X19));
    emit(code, enc_fcmp_d(0, 1));
    emit(code, enc_cset(Reg::X19, cond));
}

/// Lower a intrinsic op to a libc call. Args were already pushed onto
/// our 16-byte VM stack slots by the c5 emitter; we *peek* (not pop)
/// to load them into x0..x7. The c5 emitter follows every call with
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
#[allow(clippy::too_many_arguments)]
fn emit_libc_call(
    binding_idx: i64,
    text: &[i64],
    pc_after_op: usize,
    code: &mut Vec<u8>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    abi: Abi,
    imports: &super::ResolvedImports,
    fp_arg_mask: u32,
    target: super::Target,
) -> Result<(), C5Error> {
    let import_index = imports.index_of_binding(binding_idx).ok_or_else(|| {
        C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
            "native codegen: no import slot for binding {binding_idx} -- the resolver should have placed it"
        )))
    })?;
    let local_name: &str = imports.imports[import_index].local_name.as_str();

    // Peek at the next instruction; if it's `Adj N`, that gives us
    // the arg count. The c5 compiler omits the `Adj` for 0-arg
    // calls (like `dlerror()`), so a missing `Adj` collapses to
    // `arg_count = 0`.
    let arg_count = match Op::from_i64(text.get(pc_after_op).copied().unwrap_or(0)) {
        Some(Op::Adj) => text[pc_after_op + 1] as usize,
        _ => 0,
    };

    // macOS arm64 has a non-standard variadic ABI that puts the
    // variadic args on the stack rather than in x0..x7. Standard
    // AAPCS64 (Linux) treats variadic args identically to fixed
    // ones, so the register-loading path handles both. Whether
    // the binding is variadic comes from its prototype's
    // `, ...)` -- the parser folds that flag onto the binding
    // when it parses `int printf(char *, ...);` in `<stdio.h>`,
    // so any header-declared variadic function (printf, sscanf,
    // sprintf, fprintf, ...) gets the macOS dance, not just
    // `printf`.
    let _ = local_name;
    let imp = &imports.imports[import_index];
    let fixed_args = if imp.is_variadic {
        imp.fixed_args.min(arg_count)
    } else {
        arg_count
    };
    let plan = super::plan_call_args(arg_count, fixed_args, fp_arg_mask, abi);
    if plan.scratch_bytes > 0 {
        emit(code, enc_sub_imm(Reg::SP, Reg::SP, plan.scratch_bytes));
    }
    // c5-arg-i sits at `[sp + scratch + i*16]` (cdecl push order,
    // first declared on top). Load each into the host position
    // the planner chose. x16 is AAPCS64 scratch -- safe courier
    // for stack args.
    for (i, &placement) in plan.placements.iter().enumerate() {
        let src = plan.scratch_bytes + (i as u32) * 16;
        match placement {
            super::ArgPlacement::IntReg(r) => {
                emit(code, enc_ldr_imm(Reg(r), Reg::SP, src));
            }
            super::ArgPlacement::FpReg(d) => {
                emit(code, enc_ldr_d_imm(d, Reg::SP, src));
            }
            super::ArgPlacement::Stack(off) => {
                emit(code, enc_ldr_imm(Reg::X16, Reg::SP, src));
                emit(code, enc_str_imm(Reg::X16, Reg::SP, off));
            }
        }
    }
    emit_got_call(code, plt_call_fixups, import_index);
    if plan.scratch_bytes > 0 {
        emit(code, enc_add_imm(Reg::SP, Reg::SP, plan.scratch_bytes));
    }

    {
        use crate::c5::compiler::types as ty_helpers;
        let return_type_tag = imports.imports[import_index].return_type_tag;
        let bare = ty_helpers::strip_unsigned(return_type_tag);
        let returns_long_double = imports.imports[import_index].returns_long_double;
        // AAPCS64 returns `long double` as IEEE binary128 in v0
        // (full 128-bit Q register). c5 stores `long double` in
        // an 8-byte FP64 slot, so any libc function whose
        // prototype is `long double f(...)` needs a truncation
        // pass before the value becomes the c5 accumulator. Emit
        // a `bl __trunctfdf2` here -- the libgcc helper takes
        // binary128 in v0 (already there from the libc call) and
        // returns FP64 in d0. The fmov below then copies d0 to
        // x19 as usual. Only fires on `Target::LinuxAarch64`; the
        // macOS / Windows AArch64 ABIs alias `long double` to
        // `double`, so v0 is already FP64 on the way out.
        if returns_long_double && target == super::Target::LinuxAarch64 {
            let trunc_idx = imports
                .imports
                .iter()
                .position(|i| i.local_name == "__trunctfdf2")
                .ok_or_else(|| {
                    C5Error::Compile(crate::c5::error::fmt_internal_err(
                        "native codegen: `returns_long_double` libc call on \
                         LinuxAarch64 but `__trunctfdf2` was not force-included",
                    ))
                })?;
            emit_got_call(code, plt_call_fixups, trunc_idx);
        }
        // FP-returning libc fns hand the result back in d0 on
        // AAPCS64. The integer path below routes x0 -> x19 and
        // would leave the c5 accumulator holding whatever junk
        // x0 had. `fmov x19, d0` copies the f64 bit pattern into
        // c5's accumulator, ready for downstream `Op::Sf` /
        // `Op::Fmul` / etc.
        if ty_helpers::is_float_ty(bare) || ty_helpers::is_double_ty(bare) {
            emit(code, enc_fmov_d_to_x(Reg::X19, 0));
        } else {
            // Sign- or zero-extend a sub-word return into the full
            // 64-bit accumulator before downstream consumers read
            // it. AAPCS64 doesn't promise the upper bits of X0
            // for an `int` return, so a downstream `x19 != -17`
            // comparison would see junk above EAX otherwise.
            // Emitted on every aarch64 target -- the extension is
            // a no-op when the prototype is already 64-bit
            // (pointer, `long long`, LP64 `long`).
            let ext = super::return_extension(return_type_tag, target);
            emit_extend_x19_for_return(code, ext);
            if matches!(ext, super::ReturnExt::None) {
                // Move the libc return value into x19 so the caller
                // sees it as the new accumulator. (For functions
                // that don't return -- e.g. `exit` -- the call
                // doesn't reach this point at runtime, so the mov
                // is harmless dead code.) The extension emitter
                // above already wrote x19 for non-None cases.
                emit_mov_reg(code, Reg::X19, Reg::X0);
            }
        }
    }
    Ok(())
}

/// Extend a libc return value sitting in X0 into the c5
/// accumulator (X19), per `ext`. AAPCS64 leaves the upper bits of
/// X0 unspecified for sub-word returns, so this is the bridge
/// between the host return-register convention and c5's 64-bit
/// accumulator. Sequences mirror the x86_64 helper -- per AAPCS64
/// the unsigned-half encodings (`uxtw`, etc.) implicitly clear the
/// upper bits, and the signed half uses the matching `sxtw` /
/// `sxth` / `sxtb`.
fn emit_extend_x19_for_return(code: &mut Vec<u8>, ext: super::ReturnExt) {
    use super::ReturnExt;
    // Encodings (X19 = reg 19, X0 / W0 = reg 0):
    //   sxtb x19, w0   -- 0x93401C13
    //   sxth x19, w0   -- 0x93403C13
    //   sxtw x19, w0   -- 0x93407C13
    //   uxtb w19, w0   -- 0x53001C13  (upper 32 bits zeroed by 32-bit form)
    //   uxth w19, w0   -- 0x53003C13
    //   mov  w19, w0   -- 0x2A0003F3  (32-bit ORR; zero-extends)
    let word: u32 = match ext {
        ReturnExt::None => return,
        ReturnExt::Sign8 => 0x93401C13,
        ReturnExt::Sign16 => 0x93403C13,
        ReturnExt::Sign32 => 0x93407C13,
        ReturnExt::Zero8 => 0x53001C13,
        ReturnExt::Zero16 => 0x53003C13,
        ReturnExt::Zero32 => 0x2A0003F3,
    };
    emit(code, word);
}

/// Lookup the per-call FP-arg bitmap by JsrExt PC. Linear scan;
/// the table only carries entries for calls with at least one FP
/// arg, which in practice is rare.
fn fp_arg_mask_at(call_pc: usize, masks: &[(usize, u32)]) -> u32 {
    masks
        .iter()
        .find_map(|(pc, m)| if *pc == call_pc { Some(*m) } else { None })
        .unwrap_or(0)
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

/// A single 4-byte `BL <plt_trampoline>` placeholder at
/// every libc call site, plus a per-import trampoline appended at
/// the tail of `Build::text`. The trampoline holds the
/// `adrp + ldr + br` sequence (with `BR x16` -- libc's RET returns
/// directly to the call's BL site).
///
/// Why this shape:
/// * `b malloc` in gdb / lldb resolves against a real local
///   STT_FUNC symbol on the trampoline, not against macro-expansion
///   sites in the dynamic linker.
/// * `objdump -d ./bin` annotates each call site with `malloc@plt`
///   (when the per-format writer wires the symbol).
/// * The branch predictor catches the trampoline tail-jump after
///   the first call, so the extra hop is free in practice.
///
/// Resolved by `lower()` once trampoline byte offsets are known --
/// the call instruction's `imm26` is rewritten in place.
#[derive(Debug, Clone, Copy)]
pub(super) struct PltCallFixup {
    /// Byte offset within the lower-pass `code` of the BL/B
    /// instruction whose `imm26` we need to backfill.
    pub(super) instr_offset: usize,
    /// Import slot the call should reach via its trampoline.
    pub(super) import_index: usize,
    /// `true` -> emit `B <tramp>` (tail jump); `false` -> emit
    /// `BL <tramp>` (call). Both share the same imm26 encoding;
    /// only the link bit at 0x80000000 differs.
    pub(super) is_tail: bool,
}

/// Emit a 4-byte `BL <plt_trampoline>` placeholder + record a
/// `PltCallFixup` for the post-pass to patch. Replaces the pre-#61
/// inline `adrp + ldr + blr` sequence.
fn emit_got_call(code: &mut Vec<u8>, plt_call_fixups: &mut Vec<PltCallFixup>, import_index: usize) {
    plt_call_fixups.push(PltCallFixup {
        instr_offset: code.len(),
        import_index,
        is_tail: false,
    });
    // Placeholder displacement; rewritten in `apply_plt_call_fixups`
    // once trampolines have been laid out.
    emit(code, enc_bl(0));
}

/// Tail-jump variant of [`emit_got_call`]: emits a 4-byte
/// `B <plt_trampoline>` placeholder. libc's `RET` returns
/// directly to the c5 caller of the trampoline, skipping
/// both this `B` and the trampoline entirely on the way back.
/// Used by `Op::TailExt`.
pub(super) fn emit_got_tail_jump(
    code: &mut Vec<u8>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    import_index: usize,
) {
    plt_call_fixups.push(PltCallFixup {
        instr_offset: code.len(),
        import_index,
        is_tail: true,
    });
    emit(code, enc_b(0));
}

/// Emit one PLT trampoline per import at the tail of `code`,
/// returning the byte-offset map. Each trampoline is a 12-byte
/// `adrp + ldr + br` sequence; the writer patches its adrp/ldr
/// pair via the `GotFixup` we record here, identical to the
/// pre-#61 inline pattern.
fn emit_plt_trampolines(
    code: &mut Vec<u8>,
    got_fixups: &mut Vec<GotFixup>,
    n_imports: usize,
) -> Vec<usize> {
    let mut offsets = Vec::with_capacity(n_imports);
    for import_index in 0..n_imports {
        let tramp_off = code.len();
        offsets.push(tramp_off);
        got_fixups.push(GotFixup {
            adrp_offset: tramp_off,
            import_index,
        });
        emit(code, enc_adrp(Reg::X16, 0));
        emit(code, enc_ldr_imm(Reg::X16, Reg::X16, 0));
        // BR (not BLR): libc's RET unwinds to the original BL
        // caller in user code rather than bouncing back here.
        emit(code, enc_br(Reg::X16));
    }
    offsets
}

/// Resolve every `PltCallFixup` against the trampoline byte
/// offsets. Each call's `imm26` is rewritten in place; out-of-
/// range deltas surface as a debug_assert in `enc_bl` / `enc_b`.
fn apply_plt_call_fixups(
    code: &mut [u8],
    fixups: &[PltCallFixup],
    trampoline_offsets: &[usize],
) -> Result<(), C5Error> {
    for fx in fixups {
        let tramp_off = *trampoline_offsets.get(fx.import_index).ok_or_else(|| {
            C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                "PLT call fixup at offset {} references import {} but only \
                 {} trampolines were emitted",
                fx.instr_offset,
                fx.import_index,
                trampoline_offsets.len()
            )))
        })?;
        let delta_bytes = tramp_off as i64 - fx.instr_offset as i64;
        if delta_bytes % 4 != 0 {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("PLT call fixup: trampoline byte delta {delta_bytes} not 4-byte aligned"),
            )));
        }
        let delta_insns = (delta_bytes / 4) as i32;
        let word = if fx.is_tail {
            enc_b(delta_insns)
        } else {
            enc_bl(delta_insns)
        };
        let bytes = word.to_le_bytes();
        code[fx.instr_offset..fx.instr_offset + 4].copy_from_slice(&bytes);
    }
    Ok(())
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
/// x19) to produce `x19 = lhs OP x19`. The c5 VM has the popped
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
) -> Result<(), C5Error> {
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
) -> Result<(), C5Error> {
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
/// push x1 (argv) then x0 (argc) into their own 16-byte slots, the same
/// shape user-function args use. After the prologue's stp(x29,x30) the
/// layout is:
///   bp + 16: argc  (top arg, c5 val=2 -- first declared)
///   bp + 24: argv  (next slot, c5 val=3 -- second declared)
/// matching [`lea_offset_bytes`] under c5's cdecl push order.
fn emit_prologue(
    code: &mut Vec<u8>,
    locals: i64,
    entry_n_params: Option<usize>,
    callee_pool_depth: u8,
    target: Target,
    abi: super::Abi,
) {
    if let Some(n_params) = entry_n_params {
        // Spill the host-passed arguments into c5's cdecl
        // 16-byte-stride slots. AAPCS64 hands us the first
        // `int_arg_regs.len()` int params in x0..x7 and any
        // overflow on the host stack at `[caller_sp + i*8]`
        // (= `[entry_sp + i*8]` since `bl` doesn't disturb sp).
        // The body reads param `i` at `[fp + 16*(i+1)]`, so the
        // prologue must restripe the 8-byte host overflow run
        // onto the 16-byte c5 stride. Reverse order so arg 0
        // ends up on top of stack.
        //
        // Layout walk after the loop completes, for a function
        // with `n_params = 11`:
        //   sp + 0  : arg 0  (x0)
        //   sp + 16 : arg 1  (x1)
        //   ...
        //   sp + 112: arg 7  (x7)
        //   sp + 128: arg 8  (from [entry_sp + 0])
        //   sp + 144: arg 9  (from [entry_sp + 8])
        //   sp + 160: arg 10 (from [entry_sp + 16])
        let n_reg = n_params.min(abi.int_arg_regs.len());
        let n_stack = n_params - n_reg;
        // Stack overflow args first: read them out of the host
        // stack BEFORE we move sp, using `[sp + (i-n_reg)*8]`.
        // x16 is AAPCS64 scratch and not part of the int-arg
        // bank, so loading through it leaves x0..x7 untouched.
        // Walk in reverse so the highest-numbered param ends up
        // at the bottom of the stripe, matching the reg-arg
        // direction below.
        if n_stack > 0 {
            // Reserve the 16-byte slots for the overflow tail
            // up front (one combined sub keeps the stride
            // contiguous and lets the body see them at
            // `[fp + 16*(n_reg + i + 1)]`).
            let overflow_bytes = (n_stack as u32) * 16;
            emit_sub_sp_imm(code, overflow_bytes);
            for i in 0..n_stack {
                let host_off = (i as u32) * 8 + overflow_bytes;
                let c5_off = (i as u32) * 16;
                emit(code, enc_ldr_imm(Reg::X16, Reg::SP, host_off));
                emit(code, enc_str_imm(Reg::X16, Reg::SP, c5_off));
            }
        }
        for i in (0..n_reg).rev() {
            emit(code, enc_str_pre(Reg(abi.int_arg_regs[i]), Reg::SP, -16));
        }
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
        // For frames that cross a stack guard page, walk SP down
        // page-by-page touching each page so the OS's guard
        // mechanism fires on overflow instead of silently
        // mapping unrelated memory. Threshold is the target's
        // page size (16 KB on Apple Silicon, 4 KB elsewhere).
        // Below the threshold the single SUB is fine -- the
        // first real local access touches the (sole) crossed
        // page before any later access wanders further.
        let page_size = stack_probe_page_size(target);
        if aligned > page_size {
            emit_stack_probe(code, aligned, page_size);
        } else {
            // SUB (immediate) only takes 12 bits unshifted, so
            // for frames > ~4 KB we need the two-instruction
            // shifted-12 split. Without it the immediate silently
            // overflows into the shift bits and the prologue
            // traps with SIGILL on first call.
            emit_sub_sp_imm(code, aligned);
        }
    }
    emit(code, enc_str_pre(Reg::X19, Reg::SP, -16));
    emit_save_pool(code, callee_pool_depth);
}

/// Stack-guard page size used by the prologue's probe decision.
/// The host kernel's page size is what really matters; we
/// hard-code the value the target's OS uses by default rather
/// than querying at runtime. Apple Silicon defaults to 16 KB;
/// every other lane (Linux x86_64, Linux aarch64, Windows on
/// either ISA) uses 4 KB. Over-probing on a system configured
/// with larger pages is harmless; under-probing risks jumping
/// past the guard without touching it.
fn stack_probe_page_size(target: Target) -> u32 {
    match target {
        Target::MacOSAarch64 => 16384,
        _ => 4096,
    }
}

/// Walk SP down `frame_bytes` in `page_size` steps, touching
/// each page before sliding past it so the OS's stack-guard
/// page fires on overflow. Used by `emit_prologue` when the
/// frame would otherwise skip a guard page in a single SUB.
/// `frame_bytes` is the 16-byte-aligned local reservation
/// (caller's responsibility); the loop emits exactly
/// `frame_bytes / page_size` iterations and a single trailing
/// `sub sp, sp, #remainder` for the leftover bytes.
fn emit_stack_probe(code: &mut Vec<u8>, frame_bytes: u32, page_size: u32) {
    let pages = frame_bytes / page_size;
    let remainder = frame_bytes - pages * page_size;
    // x16 = page counter. The probe scratches x16 only -- AAPCS64
    // marks x16/x17 as IP0/IP1, intra-procedure-call scratch, so
    // clobbering them in the prologue is safe.
    load_imm64(code, Reg::X16, pages as u64);
    let loop_start = code.len();
    // sub sp, sp, #page_size  -- single instruction since
    // page_size is 4096 (immediate) or 16384 (LSL12 form).
    if page_size == 4096 {
        emit(code, enc_sub_imm_lsl12(Reg::SP, Reg::SP, 1));
    } else if page_size == 16384 {
        emit(code, enc_sub_imm_lsl12(Reg::SP, Reg::SP, 4));
    } else {
        emit_sub_sp_imm(code, page_size);
    }
    // str xzr, [sp]  -- touch the page so the guard maps it (or
    // faults on overflow). Reg(31) is XZR in store-rt position
    // (the same encoding doubles as SP in base-rn position).
    emit(code, enc_str_imm(Reg(31), Reg::SP, 0));
    // subs x16, x16, #1; b.ne loop_start.
    emit(code, enc_subs_imm(Reg::X16, Reg::X16, 1));
    let loop_pc = code.len() as i64;
    let target_pc = loop_start as i64;
    let imm19 = ((target_pc - loop_pc) / 4) as i32;
    emit(code, enc_b_cond(Cond::Ne, imm19));
    // Finally drop the partial-page remainder.
    if remainder != 0 {
        emit_sub_sp_imm(code, remainder);
    }
}

/// Mirror of [`emit_prologue`]. Moves the VM accumulator into
/// `x0`, restores the pool and the saved x19, tears down the
/// frame, and returns. For the entry function it also drops the
/// 16-byte slots the prologue inserted (one per int-arg-register
/// parameter) so sp returns to the value the caller handed in.
fn emit_epilogue(
    code: &mut Vec<u8>,
    entry_n_params: Option<usize>,
    callee_pool_depth: u8,
    locals_bytes: u32,
    _abi: super::Abi,
) {
    emit_mov_reg(code, Reg::X0, Reg::X19);
    let _ = locals_bytes; // see commentary below
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
    if let Some(n_params) = entry_n_params {
        // Drop the c5 cdecl slots the prologue laid down: all
        // declared params at 16 bytes apiece (both the register
        // spill and the restriped host-stack overflow). SP returns
        // to the value the host caller handed in.
        emit_add_sp_imm(code, (16 * n_params) as u32);
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

    /// `LDR Xt, [Xn, Xm, LSL #3]` -- Win64 TLS lookup uses this to
    /// fetch `tls_array[_tls_index]`. Verified against clang.
    #[test]
    fn ldr_x16_x16_x17_lsl3() {
        // ldr x16, [x16, x17, lsl #3]  ->  0xF8717A10
        assert_eq!(enc_ldr_reg_lsl3(Reg::X16, Reg::X16, Reg::X17), 0xF871_7A10);
    }

    /// `LDR Wt, [Xn, #imm]` -- 32-bit unsigned-offset load. The
    /// Win64 TLS lookup uses this to read the 4-byte `_tls_index`
    /// slot. Verified against clang.
    #[test]
    fn ldr_w17_x17_4() {
        // ldr w17, [x17, #4]  ->  0xB9400631
        assert_eq!(enc_ldr32_imm(Reg::X17, Reg::X17, 4), 0xB940_0631);
    }

    /// `LDR Xt, [X18, #0x58]` -- the Win64 TLS lookup pulls
    /// `TEB->ThreadLocalStoragePointer` out of `[x18 + 0x58]`,
    /// and the encoder needs to handle x18 as a base. Verified
    /// against clang.
    #[test]
    fn ldr_x16_x18_0x58() {
        // ldr x16, [x18, #0x58]  ->  0xF9402E50
        assert_eq!(enc_ldr_imm(Reg::X16, Reg::X18, 0x58), 0xF940_2E50);
    }

    /// `MRS Xt, TPIDR_EL0` -- Linux/aarch64 TLS lookup reads the
    /// per-thread pointer system register here. Verified against
    /// clang.
    #[test]
    fn mrs_x19_tpidr_el0() {
        // mrs x19, tpidr_el0  ->  0xD53BD053
        assert_eq!(enc_mrs_tpidr_el0(Reg::X19), 0xD53B_D053);
    }

    // Encoder spot checks. Each expected byte string was pasted from
    // `otool -t -X` on `clang -c -arch arm64` output; if you change
    // an encoder, run the same trip and update.

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

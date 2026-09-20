//! AArch64 instruction encoder + per-function lowering shell.
//!
//! All AArch64 instructions are 32 bits wide and little-endian on every
//! supported OS, which makes the encoder a flat catalogue of
//! `fn enc_xxx(...) -> u32`. Per-function code generation routes
//! through [`super::ssa::shadow::produce_ssa_funcs`] +
//! [`super::ssa::reg_alloc::allocate`] + `super::emit`; this
//! module's `lower()` is the shell that drives the SSA pipeline and
//! the post-pass fixups (PLT trampolines, branch fixups,
//! data-relocation patching).
//!
//! ## Always-on peepholes
//!
//! [`emit_mov_reg`] drops `mov xd, xd` instead of emitting it. Used
//! by both the SSA emit and the start-stub for the few reg-to-reg
//! moves the lowering produces with potentially-coinciding source
//! and destination.
//!
//! ## What lives here
//!
//! * The `enc_*` instruction encoders (used by the SSA emit, the
//!   start stub, and the PLT trampoline emit).
//! * [`emit_setjmp_aarch64`] -- a CRT-free setjmp inlined at the call
//!   site so Windows AArch64 (where msvcrt's longjmp routes through
//!   SEH) can be supported uniformly with macOS / Linux.
//! * The lowering shell `lower()` -- frame layout, post-pass fixup
//!   walks, and the per-arch sticking points the SSA emit can't see
//!   (PLT trampoline placement, x19 reservation, branch placeholder
//!   patching).

// Encoder catalogue: a few entries (e.g. unused arithmetic forms,
// MSR/MRS variants we'd reach for if we ever grow scheduling) sit
// here for completeness and aren't called by the lowering pass.
// Suppress the dead-code lint for the whole module so adding the
// next encoder doesn't need a per-item attribute.
#![allow(dead_code)]

use alloc::format;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::ir::IndexExt;
use super::super::program::Program;
use super::{AddrPart, Build, GotFixup, NativeOptions, Target};

/// AArch64 register name. Wraps the 5-bit register field that nearly
/// every instruction needs in some position; using a newtype prevents
/// the "I passed `1` for a register and `1` for an immediate to the
/// same encoder" bug class.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct Reg(pub u8);

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
    /// Base of the SSA allocator's callee-saved register bank
    /// (x20..x27). All eight regs are AAPCS64 callee-saved, so
    /// the prologue only has to save the prefix the function
    /// actually uses.
    pub const CALLEE_POOL_BASE: Reg = Reg(20);
    /// Base of the SSA allocator's caller-saved register bank
    /// (x9..x15). AAPCS64 marks these caller-saved, so a `bl` /
    /// `blr` would clobber them; the allocator guarantees a
    /// caller-bank value is never live across a call, so no
    /// spill is needed. The prologue / epilogue likewise saves
    /// none of these.
    pub const CALLER_POOL_BASE: Reg = Reg(9);
    pub const X29: Reg = Reg(29); // frame pointer (fp)
    pub const X30: Reg = Reg(30); // link register (lr)
    /// AArch64 conflates SP and the zero register at field-31 depending
    /// on instruction context. The ARM ARM disambiguates per-encoding;
    /// every instruction we use here treats field-31 as SP.
    pub const SP: Reg = Reg(31);
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
pub(crate) fn enc_movz(rd: Reg, imm16: u16, hw: u8) -> u32 {
    debug_assert!(hw < 4, "movz: hw must be 0..=3");
    0xD280_0000 | ((hw as u32) << 21) | ((imm16 as u32) << 5) | (rd.0 as u32)
}

/// `MOVK <Xd>, #imm16, LSL #(hw*16)` -- overwrite one 16-bit lane of
/// `Xd` with `imm16`, leaving the other lanes intact. Combined with
/// `movz` it builds an arbitrary 64-bit constant in 1-4 instructions
/// (see [`load_imm64`]).
pub(crate) fn enc_movk(rd: Reg, imm16: u16, hw: u8) -> u32 {
    debug_assert!(hw < 4, "movk: hw must be 0..=3");
    0xF280_0000 | ((hw as u32) << 21) | ((imm16 as u32) << 5) | (rd.0 as u32)
}

/// `MOVN <Xd>, #imm16, LSL #(hw*16)` -- load the complement of `imm16` in
/// lane `hw`, which sets every other lane.
pub(crate) fn enc_movn(rd: Reg, imm16: u16, hw: u8) -> u32 {
    debug_assert!(hw < 4, "movn: hw must be 0..=3");
    0x9280_0000 | ((hw as u32) << 21) | ((imm16 as u32) << 5) | (rd.0 as u32)
}

/// `RET <Xn>` -- branch to the address in `Xn` (default `x30`/`lr`).
/// AAPCS64 puts the return address in `x30` on entry, so the bare form
/// `ret` (= `ret x30`) is the usual one.
pub(crate) fn enc_ret(rn: Reg) -> u32 {
    0xD65F_0000 | ((rn.0 as u32) << 5)
}

/// `BL <label>` -- branch with link to a PC-relative label.
///
/// `imm26` is the signed offset measured in **instructions** (i.e.
/// bytes/4); ARM ARM allows the range +/-128 MiB. We sign-mask down
/// to 26 bits so a negative offset (calling backwards) emits the
/// right two's-complement bits.
pub(crate) fn enc_bl(imm26: i32) -> u32 {
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
pub(crate) fn enc_stp_pre(rt: Reg, rt2: Reg, rn: Reg, imm: i32) -> u32 {
    assert!(imm % 8 == 0, "stp: imm must be 8-byte aligned, got {imm}");
    let imm7 = imm / 8;
    assert!(
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
pub(crate) fn enc_ldp_post(rt: Reg, rt2: Reg, rn: Reg, imm: i32) -> u32 {
    assert!(imm % 8 == 0, "ldp: imm must be 8-byte aligned, got {imm}");
    let imm7 = imm / 8;
    assert!(
        (-64..64).contains(&imm7),
        "ldp: offset {imm} (scaled {imm7}) out of range"
    );
    0xA8C0_0000
        | (((imm7 as u32) & 0x7F) << 15)
        | ((rt2.0 as u32) << 10)
        | ((rn.0 as u32) << 5)
        | (rt.0 as u32)
}

/// `STP <Xt1>, <Xt2>, [<Xn|SP>], #imm` -- store-pair, post-indexed; scaled as [`enc_stp_pre`].
pub(crate) fn enc_stp_post(rt: Reg, rt2: Reg, rn: Reg, imm: i32) -> u32 {
    assert!(imm % 8 == 0, "stp: imm must be 8-byte aligned, got {imm}");
    let imm7 = imm / 8;
    assert!(
        (-64..64).contains(&imm7),
        "stp: offset {imm} (scaled {imm7}) out of range"
    );
    0xA880_0000
        | (((imm7 as u32) & 0x7F) << 15)
        | ((rt2.0 as u32) << 10)
        | ((rn.0 as u32) << 5)
        | (rt.0 as u32)
}

/// `STP <Xt1>, <Xt2>, [<Xn|SP>, #imm]` -- store-pair, signed offset
/// (no writeback). Same scaling / range as [`enc_stp_pre`].
pub(crate) fn enc_stp_off(rt: Reg, rt2: Reg, rn: Reg, imm: i32) -> u32 {
    assert!(imm % 8 == 0, "stp: imm must be 8-byte aligned, got {imm}");
    let imm7 = imm / 8;
    assert!(
        (-64..64).contains(&imm7),
        "stp: offset {imm} (scaled {imm7}) out of range"
    );
    0xA900_0000
        | (((imm7 as u32) & 0x7F) << 15)
        | ((rt2.0 as u32) << 10)
        | ((rn.0 as u32) << 5)
        | (rt.0 as u32)
}

/// `LDP <Xt1>, <Xt2>, [<Xn|SP>, #imm]` -- load-pair, signed offset
/// (no writeback). Mirror of [`enc_stp_off`].
pub(crate) fn enc_ldp_off(rt: Reg, rt2: Reg, rn: Reg, imm: i32) -> u32 {
    assert!(imm % 8 == 0, "ldp: imm must be 8-byte aligned, got {imm}");
    let imm7 = imm / 8;
    assert!(
        (-64..64).contains(&imm7),
        "ldp: offset {imm} (scaled {imm7}) out of range"
    );
    0xA940_0000
        | (((imm7 as u32) & 0x7F) << 15)
        | ((rt2.0 as u32) << 10)
        | ((rn.0 as u32) << 5)
        | (rt.0 as u32)
}

/// Shared field packer for the LDP / STP (SIMD&FP, 64-bit) forms below.
/// `imm` scales by 8 into the imm7 field, same as the X-register forms.
fn enc_ldst_pair_d(base: u32, dt: u8, dt2: u8, rn: Reg, imm: i32) -> u32 {
    debug_assert!(dt < 32 && dt2 < 32);
    assert!(imm % 8 == 0, "ldp/stp d: imm must be 8-byte aligned");
    let imm7 = imm / 8;
    assert!(
        (-64..64).contains(&imm7),
        "ldp/stp d: offset {imm} (scaled {imm7}) out of range"
    );
    base | (((imm7 as u32) & 0x7F) << 15)
        | ((dt2 as u32) << 10)
        | ((rn.0 as u32) << 5)
        | (dt as u32)
}

/// `STP <Dt1>, <Dt2>, [<Xn|SP>, #imm]` -- store-pair, signed offset.
pub(crate) fn enc_stp_d_off(dt: u8, dt2: u8, rn: Reg, imm: i32) -> u32 {
    enc_ldst_pair_d(0x6D00_0000, dt, dt2, rn, imm)
}

/// `LDP <Dt1>, <Dt2>, [<Xn|SP>, #imm]` -- load-pair, signed offset.
pub(crate) fn enc_ldp_d_off(dt: u8, dt2: u8, rn: Reg, imm: i32) -> u32 {
    enc_ldst_pair_d(0x6D40_0000, dt, dt2, rn, imm)
}

/// `STP <Dt1>, <Dt2>, [<Xn|SP>, #imm]!` -- store-pair, pre-indexed.
pub(crate) fn enc_stp_d_pre(dt: u8, dt2: u8, rn: Reg, imm: i32) -> u32 {
    enc_ldst_pair_d(0x6D80_0000, dt, dt2, rn, imm)
}

/// `LDP <Dt1>, <Dt2>, [<Xn|SP>], #imm` -- load-pair, post-indexed.
pub(crate) fn enc_ldp_d_post(dt: u8, dt2: u8, rn: Reg, imm: i32) -> u32 {
    enc_ldst_pair_d(0x6CC0_0000, dt, dt2, rn, imm)
}

/// `STR <Dt>, [<Xn|SP>, #imm]!` -- pre-indexed store with writeback
/// (unscaled imm9). D-register mirror of [`enc_str_pre`].
pub(crate) fn enc_str_d_pre(dt: u8, rn: Reg, imm: i32) -> u32 {
    debug_assert!(dt < 32);
    assert!(
        (-256..256).contains(&imm),
        "str-d-pre imm: {imm} out of range"
    );
    let imm9 = (imm as u32) & 0x1FF;
    0xFC00_0C00 | (imm9 << 12) | ((rn.0 as u32) << 5) | (dt as u32)
}

/// `LDR <Dt>, [<Xn|SP>], #imm` -- post-indexed load with writeback
/// (unscaled imm9). D-register mirror of [`enc_ldr_post`].
pub(crate) fn enc_ldr_d_post(dt: u8, rn: Reg, imm: i32) -> u32 {
    debug_assert!(dt < 32);
    assert!(
        (-256..256).contains(&imm),
        "ldr-d-post imm: {imm} out of range"
    );
    let imm9 = (imm as u32) & 0x1FF;
    0xFC40_0400 | (imm9 << 12) | ((rn.0 as u32) << 5) | (dt as u32)
}

/// `MOV <Xd>, <Xn>` -- alias for `ORR <Xd>, XZR, <Xn>`. Note that ARM
/// uses two distinct mov forms: this one (register-to-register, where
/// `Rn` field 31 means XZR) and `add xd, sp, #0` (which is what you
/// need when the source is SP itself, because in `add` field 31 means
/// SP). Use [`enc_add_imm`] with `imm=0` for the `mov xd, sp` case.
pub(crate) fn enc_mov_reg(rd: Reg, rn: Reg) -> u32 {
    0xAA00_0000 | ((rn.0 as u32) << 16) | ((Reg::SP.0 as u32) << 5) | (rd.0 as u32)
}

/// `ADD <Xd>, <Xn|SP>, #imm12` -- 12-bit unsigned immediate, no shift.
/// Larger immediates need either the `lsl #12` shift form or the
/// load-into-register-and-add long form; we don't need either yet.
pub(crate) fn enc_add_imm(rd: Reg, rn: Reg, imm12: u32) -> u32 {
    debug_assert!(imm12 < 4096, "add imm: {imm12} > 12-bit max");
    0x9100_0000 | (imm12 << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SUB <Xd>, <Xn|SP>, #imm12` -- 12-bit unsigned immediate, no shift.
/// Used to allocate stack space in function prologues.
pub(crate) fn enc_sub_imm(rd: Reg, rn: Reg, imm12: u32) -> u32 {
    debug_assert!(imm12 < 4096, "sub imm: {imm12} > 12-bit max");
    0xD100_0000 | (imm12 << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SUBS <Xd>, <Xn|SP>, #imm12` -- like `SUB` but sets NZCV.
/// Used by the stack-probe loop's counter decrement so the
/// trailing `b.ne` can read the flags. Top 8 bits flip from
/// `1101_0001` (SUB) to `1111_0001` (SUBS).
pub(crate) fn enc_subs_imm(rd: Reg, rn: Reg, imm12: u32) -> u32 {
    debug_assert!(imm12 < 4096, "subs imm: {imm12} > 12-bit max");
    0xF100_0000 | (imm12 << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SUB <Xd>, <Xn|SP>, #imm12, LSL #12`. The shifted-12 form
/// extends the reach of the immediate to multiples of 4096 up
/// to ~16 MiB, used together with the unshifted form to cover
/// any 24-bit byte count in two instructions.
pub(crate) fn enc_sub_imm_lsl12(rd: Reg, rn: Reg, imm12: u32) -> u32 {
    debug_assert!(imm12 < 4096, "sub imm lsl12: {imm12} > 12-bit max");
    0xD140_0000 | (imm12 << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `ADD <Xd>, <Xn|SP>, #imm12, LSL #12`. Mirror of
/// [`enc_sub_imm_lsl12`] -- used to fold large
/// stack-restoration adjustments into two instructions.
pub(crate) fn enc_add_imm_lsl12(rd: Reg, rn: Reg, imm12: u32) -> u32 {
    debug_assert!(imm12 < 4096, "add imm lsl12: {imm12} > 12-bit max");
    0x9140_0000 | (imm12 << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `ADD <Xd|SP>, <Xn|SP>, <Xm>, UXTX #0` -- the extended-register
/// form, the only register add whose Rn / Rd may be SP (the
/// shifted-register form reads register 31 as XZR).
pub(crate) fn enc_add_ext_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0x8B20_6000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// The address `base + index * 2^shift` of an indexed access:
/// `ADD Xd, Xn, Xm, LSL #shift` for a full-width index, else
/// `ADD Xd, Xn, Wm, <ext> #shift` with `shift` at most 4.
pub(crate) fn enc_add_index(rd: Reg, rn: Reg, rm: Reg, ext: IndexExt, shift: u32) -> u32 {
    if ext == IndexExt::None {
        return enc_add_reg_lsl(rd, rn, rm, shift);
    }
    debug_assert!(shift <= 4, "add (extended register): shift {shift} > 4");
    0x8B20_0000
        | ((rm.0 as u32) << 16)
        | (index_option(ext) << 13)
        | (shift << 10)
        | ((rn.0 as u32) << 5)
        | (rd.0 as u32)
}

/// `SUB <Xd|SP>, <Xn|SP>, <Xm>, UXTX #0`. Mirror of
/// [`enc_add_ext_reg`].
pub(crate) fn enc_sub_ext_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    0xCB20_6000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// True when `bytes` fits the two-instruction split of `ADD` / `SUB`
/// (immediate): a 12-bit value plus a 12-bit value left-shifted by 12.
/// Past it an offset must be materialised into a register.
pub(crate) fn add_sub_imm24_in_range(bytes: u32) -> bool {
    bytes < (1 << 24)
}

/// Subtract `bytes` from SP in one instruction. AArch64's `SUB
/// (immediate)` carries a 12-bit value optionally left-shifted by 12, so
/// `bytes < 4096` encodes directly and a multiple of 4096 encodes
/// shifted; the two-instruction split the wider forms would need is not
/// available here, because moving SP by more than
/// [`MAX_UNPROBED_STACK_STEP`] without a probe can step over a guard
/// region. Callers route larger amounts through the backend's
/// `emit_stack_alloc`, which descends in probed steps.
pub(crate) fn emit_sub_sp_imm(code: &mut Vec<u8>, bytes: u32) {
    if bytes == 0 {
        return;
    }
    assert!(
        bytes <= super::super::ssa::emit_common::STACK_PROBE_PAGE,
        "guard-unsafe single SP decrement: {bytes} bytes"
    );
    if bytes == super::super::ssa::emit_common::STACK_PROBE_PAGE {
        emit(code, enc_sub_imm_lsl12(Reg::SP, Reg::SP, 1));
    } else {
        emit(code, enc_sub_imm(Reg::SP, Reg::SP, bytes));
    }
}

/// Add `bytes` to SP using the same 24-bit reach as
/// [`emit_sub_sp_imm`]. Used for stack-arg cleanup after a call
/// and by anything else that needs to grow the stack pointer
/// back by more than 4 KiB in one go.
pub(crate) fn emit_add_sp_imm(code: &mut Vec<u8>, bytes: u32) {
    if bytes == 0 {
        return;
    }
    assert!(
        add_sub_imm24_in_range(bytes),
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

/// Add any 32-bit `bytes` to SP. Past the 24-bit immediate reach the
/// count is materialised into `scratch` and applied with the
/// extended-register form, so the frame size is bounded by the
/// frame-offset width rather than by the immediate encoding. Growing sp
/// needs no probe: it moves back over bytes the frame already reached.
/// `scratch` must be dead across the adjustment.
pub(crate) fn emit_add_sp_imm_scratch(code: &mut Vec<u8>, bytes: u32, scratch: Reg) {
    if add_sub_imm24_in_range(bytes) {
        emit_add_sp_imm(code, bytes);
        return;
    }
    load_imm64(code, scratch, bytes as u64);
    emit(code, enc_add_ext_reg(Reg::SP, Reg::SP, scratch));
}

// ---- 3-register arithmetic / bitwise (shifted-register form, no shift). ----
// Each follows the same template: a base opcode | Rm<<16 | Rn<<5 | Rd.
// Verified against `clang -c -arch arm64` on Apple Silicon.

/// 3-register data-processing word: `base | Rm<<16 | Rn<<5 | Rd`. Any baked
/// field (e.g. MUL's `Ra = XZR`) is part of `base`.
fn enc_rrr(base: u32, rd: Reg, rn: Reg, rm: Reg) -> u32 {
    base | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `ADD <Xd>, <Xn>, <Xm>` -- 64-bit register add, no shift.
pub(crate) fn enc_add_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x8B00_0000, rd, rn, rm)
}

/// `ADD <Xd>, <Xn>, <Xm>, LSL #<shift>` -- 64-bit add of a left-shifted
/// register. `shift` is a 6-bit amount.
pub(crate) fn enc_add_reg_lsl(rd: Reg, rn: Reg, rm: Reg, shift: u32) -> u32 {
    0x8B00_0000
        | ((rm.0 as u32) << 16)
        | ((shift & 0x3f) << 10)
        | ((rn.0 as u32) << 5)
        | (rd.0 as u32)
}

/// `SUB <Xd>, <Xn>, <Xm>` -- 64-bit register subtract.
pub(crate) fn enc_sub_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0xCB00_0000, rd, rn, rm)
}

/// `NEG <Xd>, <Xm>` (`SUB Xd, XZR, Xm`) -- two's-complement negate.
/// `Rn` is baked to XZR (31); the shifted-register SUB reads 31 as the
/// zero register, not SP.
pub(crate) fn enc_neg(rd: Reg, rm: Reg) -> u32 {
    enc_rrr(0xCB00_0000, rd, Reg::SP, rm)
}

/// `AND <Xd>, <Xn>, <Xm>` -- bitwise and.
pub(crate) fn enc_and_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x8A00_0000, rd, rn, rm)
}

/// `BIC <Xd>, <Xn>, <Xm>` -- bit clear: `Xn & ~Xm`. The logical
/// shifted-register `AND` form with `N=1` (bit 21) complements `Xm`.
pub(crate) fn enc_bic_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x8A20_0000, rd, rn, rm)
}

/// The logical-immediate field `N<<12 | immr<<6 | imms` (bits [22:10]) of
/// `value`: a rotated run of ones, shorter than its element of 2, 4, 8, 16, 32
/// or 64 bits, replicated across the register; `None` otherwise. The 32-bit
/// form reads the low word under a high word of all zeros or all ones.
pub(crate) fn encode_logical_imm(value: u64, is64: bool) -> Option<u32> {
    let size: u32 = if is64 { 64 } else { 32 };
    if !is64 && !matches!(value >> 32, 0 | 0xFFFF_FFFF) {
        return None;
    }
    let value = if is64 { value } else { value & 0xFFFF_FFFF };
    let size_mask = if size == 64 {
        u64::MAX
    } else {
        (1u64 << size) - 1
    };
    if value == 0 || value == size_mask {
        return None;
    }
    // Element size: halve while both halves are equal.
    let mut esize = size;
    while esize > 2 {
        let h = esize >> 1;
        let m = (1u64 << h) - 1;
        if (value & m) != ((value >> h) & m) {
            break;
        }
        esize = h;
    }
    let emask = if esize == 64 {
        u64::MAX
    } else {
        (1u64 << esize) - 1
    };
    let elem = value & emask;

    let ctz = |x: u64| x.trailing_zeros();
    let cto = |x: u64| x.trailing_ones();
    let is_shifted_mask = |x: u64| -> bool {
        if x == 0 {
            return false;
        }
        let y = x >> ctz(x);
        (y & y.wrapping_add(1)) == 0
    };

    let (i, run): (u32, u32);
    if is_shifted_mask(elem) {
        i = ctz(elem);
        run = cto(elem >> i);
    } else {
        // The ones-run wraps the element boundary: the complement, widened to
        // 64 bits with ones above the element, must be a single run.
        let widened = elem | (!emask);
        if !is_shifted_mask(!widened) {
            return None;
        }
        let lead = widened.leading_ones();
        i = 64 - lead;
        run = lead + cto(widened) - (64 - esize);
    }
    let immr = (esize.wrapping_sub(i)) & (esize - 1);
    let nimms = ((!(esize - 1) << 1) | (run - 1)) & 0x7F;
    let n = ((nimms >> 6) & 1) ^ 1;
    Some((n << 12) | (immr << 6) | (nimms & 0x3F))
}

/// The `opc` field of the logical-immediate forms.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum LogicalOp {
    And = 0,
    Orr = 1,
    Eor = 2,
}

/// `<op> Rd, Rn, #value` in the 64-bit form, or in the 32-bit form over the
/// low word, when `value` is a bitmask immediate. Rd = 31 is SP.
pub(crate) fn enc_logical_imm(
    op: LogicalOp,
    is64: bool,
    rd: Reg,
    rn: Reg,
    value: u64,
) -> Option<u32> {
    let field = encode_logical_imm(value, is64)?;
    Some(
        ((is64 as u32) << 31)
            | ((op as u32) << 29)
            | 0x1200_0000
            | (field << 10)
            | ((rn.0 as u32) << 5)
            | (rd.0 as u32),
    )
}

/// `AND <Xd|SP>, <Xn>, #-(1 << log2_align)`: round a GPR down to a power of two.
pub(crate) fn enc_and_align_down(rd: Reg, rn: Reg, log2_align: u32) -> u32 {
    enc_logical_imm(LogicalOp::And, true, rd, rn, u64::MAX << log2_align)
        .expect("a run of high ones is a bitmask immediate")
}

/// `ORR <Xd>, <Xn>, <Xm>` -- bitwise or.
pub(crate) fn enc_orr_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0xAA00_0000, rd, rn, rm)
}

/// `MOV <Wd>, <Wn>` (`ORR Wd, WZR, Wn`) -- 32-bit register move. A write
/// to a W register clears the upper 32 bits of the X register, so this is
/// also the one-instruction zero-extension of the low word (`x & 0xffffffff`).
pub(crate) fn enc_mov_w_w(rd: Reg, rn: Reg) -> u32 {
    0x2A00_03E0 | ((rn.0 as u32) << 16) | (rd.0 as u32)
}

/// `EOR <Xd>, <Xn>, <Xm>` -- bitwise xor.
pub(crate) fn enc_eor_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0xCA00_0000, rd, rn, rm)
}

/// `MVN <Xd>, <Xm>` (`ORN Xd, XZR, Xm`) -- bitwise NOT. `Rn` is baked
/// to XZR (31); ORN is ORR with the N bit set.
pub(crate) fn enc_mvn(rd: Reg, rm: Reg) -> u32 {
    0xAA20_03E0 | ((rm.0 as u32) << 16) | (rd.0 as u32)
}

/// `MUL <Xd>, <Xn>, <Xm>` -- alias for `MADD Xd, Xn, Xm, XZR`.
/// We bake in `Ra = XZR (31)` so this stays a 3-register helper.
pub(crate) fn enc_mul(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9B00_7C00, rd, rn, rm)
}

/// `SMULH <Xd>, <Xn>, <Xm>` -- high 64 bits of the signed 64x64
/// product.
pub(crate) fn enc_smulh(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9B40_7C00, rd, rn, rm)
}

/// `UMULH <Xd>, <Xn>, <Xm>` -- high 64 bits of the unsigned 64x64
/// product.
pub(crate) fn enc_umulh(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9BC0_7C00, rd, rn, rm)
}

/// `SDIV <Xd>, <Xn>, <Xm>` -- signed integer division. Pairs with
/// [`enc_msub`] when computing modulo.
pub(crate) fn enc_sdiv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9AC0_0C00, rd, rn, rm)
}

/// `UDIV <Xd>, <Xn>, <Xm>` -- unsigned integer division. Differs from
/// SDIV only in the opcode2 field (bit 10 cleared). Pairs with
/// [`enc_msub`] when computing unsigned modulo.
pub(crate) fn enc_udiv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9AC0_0800, rd, rn, rm)
}

/// Four-register multiply-accumulate encoding shared by MADD / MSUB.
fn enc_mul_acc(base: u32, rd: Reg, rn: Reg, rm: Reg, ra: Reg) -> u32 {
    base | ((rm.0 as u32) << 16) | ((ra.0 as u32) << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `MSUB <Xd>, <Xn>, <Xm>, <Xa>` -- `Xd = Xa - (Xn * Xm)`. The
/// AArch64 idiom for `mod` is `sdiv q, a, b ; msub r, q, b, a`,
/// which yields `r = a - (a/b)*b`.
pub(crate) fn enc_msub(rd: Reg, rn: Reg, rm: Reg, ra: Reg) -> u32 {
    enc_mul_acc(0x9B00_8000, rd, rn, rm, ra)
}

/// `MADD <Xd>, <Xn>, <Xm>, <Xa>` -- `Xd = Xa + (Xn * Xm)`.
pub(crate) fn enc_madd(rd: Reg, rn: Reg, rm: Reg, ra: Reg) -> u32 {
    enc_mul_acc(0x9B00_0000, rd, rn, rm, ra)
}

/// `LSLV <Xd>, <Xn>, <Xm>` -- variable left shift, masking the shift
/// amount to 6 bits (i.e., shifting by `Xm % 64`).
pub(crate) fn enc_lslv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9AC0_2000, rd, rn, rm)
}

/// `LSRV <Xd>, <Xn>, <Xm>` -- variable logical right shift.
pub(crate) fn enc_lsrv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9AC0_2400, rd, rn, rm)
}

/// `ASRV <Xd>, <Xn>, <Xm>` -- variable arithmetic right shift. The
/// signed counterpart to `LSRV`
pub(crate) fn enc_asrv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9AC0_2800, rd, rn, rm)
}

/// `RORV <Xd>, <Xn>, <Xm>` -- variable rotate right.
pub(crate) fn enc_rorv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9AC0_2C00, rd, rn, rm)
}

/// `CLZ <Xd>, <Xn>` -- count leading zero bits; 64 for a zero source.
pub(crate) fn enc_clz(rd: Reg, rn: Reg) -> u32 {
    0xDAC0_1000 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `CLZ <Wd>, <Wn>` -- count leading zero bits of the low word; 32 for a
/// zero source. The 32-bit write zero-extends into `Xd`.
pub(crate) fn enc_clz32(rd: Reg, rn: Reg) -> u32 {
    0x5AC0_1000 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `RBIT <Xd>, <Xn>` -- reverse the bit order.
pub(crate) fn enc_rbit64(rd: Reg, rn: Reg) -> u32 {
    0xDAC0_0000 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `RBIT <Wd>, <Wn>` -- reverse the bit order of the low word; the 32-bit
/// write zero-extends into `Xd`.
pub(crate) fn enc_rbit32(rd: Reg, rn: Reg) -> u32 {
    0x5AC0_0000 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `CNT <Vd>.8B, <Vn>.8B` -- the set bits of each of the low eight bytes.
pub(crate) fn enc_cnt_8b(vd: u8, vn: u8) -> u32 {
    debug_assert!(vd < 32 && vn < 32);
    0x0E20_5800 | ((vn as u32) << 5) | (vd as u32)
}

/// `ADDV <Bd>, <Vn>.8B` -- the sum of the low eight bytes, written to byte 0
/// with the rest of `Vd` cleared.
pub(crate) fn enc_addv_8b(vd: u8, vn: u8) -> u32 {
    debug_assert!(vd < 32 && vn < 32);
    0x0E31_B800 | ((vn as u32) << 5) | (vd as u32)
}

/// `ADD` / `SUB <Xd>, <Xn>, <Xm>, LSR #<shift>`, or the `W` forms when
/// `!is64`.
pub(crate) fn enc_addsub_lsr(sub: bool, rd: Reg, rn: Reg, rm: Reg, shift: u32, is64: bool) -> u32 {
    ((is64 as u32) << 31)
        | ((sub as u32) << 30)
        | 0x0B40_0000
        | ((rm.0 as u32) << 16)
        | ((shift & 0x3f) << 10)
        | ((rn.0 as u32) << 5)
        | (rd.0 as u32)
}

/// `MUL <Wd>, <Wn>, <Wm>` -- `MADD Wd, Wn, Wm, WZR`.
pub(crate) fn enc_mul32(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x1B00_7C00, rd, rn, rm)
}

/// `ROR <Xd>, <Xs>, #<shift>` -- bit-rotate-right by constant. Encoded
/// as the EXTR alias `EXTR Xd, Xs, Xs, #shift`.
pub(crate) fn enc_ror_imm(rd: Reg, rn: Reg, shift: u8) -> u32 {
    0x93C0_0000
        | ((rn.0 as u32) << 16)
        | (((shift as u32) & 63) << 10)
        | ((rn.0 as u32) << 5)
        | (rd.0 as u32)
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
pub(crate) fn enc_fmov_x_to_d(dd: u8, xn: Reg) -> u32 {
    debug_assert!(dd < 32);
    0x9E67_0000 | ((xn.0 as u32) << 5) | (dd as u32)
}

/// `FMOV <Xd>, <Dn>` -- copy the 64 low bits of `Dn` back into `Xd`.
pub(crate) fn enc_fmov_d_to_x(rd: Reg, dn: u8) -> u32 {
    debug_assert!(dn < 32);
    0x9E66_0000 | ((dn as u32) << 5) | (rd.0 as u32)
}

/// `FMOV <Dd>, <Dn>` -- copy a double-precision register. Used to
/// move a `double` value into the allocator's chosen d-register
/// when the producer wrote a different one.
pub(crate) fn enc_fmov_d_d(dd: u8, dn: u8) -> u32 {
    enc_fp1(0x1E60_4000, dd, dn)
}

/// VFPExpandImm: the pattern `FMOV <Dd>|<Sd>, #imm8` writes, zero-extended.
pub(crate) fn vfp_expand_imm(imm8: u8, single: bool) -> u64 {
    let (e, f) = if single { (8u32, 23u32) } else { (11, 52) };
    let b = u64::from((imm8 >> 6) & 1);
    let exp = ((b ^ 1) << (e - 1)) | ((b * ((1 << (e - 3)) - 1)) << 2) | u64::from((imm8 >> 4) & 3);
    (u64::from(imm8 >> 7) << (e + f)) | (exp << f) | (u64::from(imm8 & 0xF) << (f - 4))
}

/// The `imm8` for which [`vfp_expand_imm`] gives `bits`; zero has none.
pub(crate) fn fp_imm8(bits: u64, single: bool) -> Option<u8> {
    (0..=u8::MAX).find(|&imm8| vfp_expand_imm(imm8, single) == bits)
}

/// `FMOV <Dd>, #imm` / `FMOV <Sd>, #imm` -- the pattern [`vfp_expand_imm`] names.
pub(crate) fn enc_fmov_imm(dd: u8, imm8: u8, single: bool) -> u32 {
    debug_assert!(dd < 32);
    let base = if single { 0x1E20_1000 } else { 0x1E60_1000 };
    base | ((imm8 as u32) << 13) | (dd as u32)
}

/// `MOVI <Dd>, #0` -- zero the whole vector register, +0.0 in either view.
pub(crate) fn enc_movi_d_zero(dd: u8) -> u32 {
    debug_assert!(dd < 32);
    0x2F00_E400 | (dd as u32)
}

/// Write the pattern `bits` (`single`: a float's) to `dd`: `movi` for +0.0,
/// `fmov #imm8` where it has one, else the build in `stage` and `fmov`.
pub(crate) fn load_fp_imm(code: &mut Vec<u8>, dd: u8, bits: u64, single: bool, stage: Reg) {
    let bits = if single { bits & 0xFFFF_FFFF } else { bits };
    if bits == 0 {
        emit(code, enc_movi_d_zero(dd));
    } else if let Some(imm8) = fp_imm8(bits, single) {
        emit(code, enc_fmov_imm(dd, imm8, single));
    } else {
        load_imm64(code, stage, bits);
        emit(
            code,
            if single {
                enc_fmov_w_to_s(dd, stage)
            } else {
                enc_fmov_x_to_d(dd, stage)
            },
        );
    }
}

/// FP data-processing (2 source) word: `base | Rm<<16 | Rn<<5 | Rd`, V-register
/// operands. The ptype/opcode bits are part of `base`.
fn enc_fp2(base: u32, dd: u8, dn: u8, dm: u8) -> u32 {
    debug_assert!(dd < 32 && dn < 32 && dm < 32);
    base | ((dm as u32) << 16) | ((dn as u32) << 5) | (dd as u32)
}

/// FP data-processing (1 source) word: `base | Rn<<5 | Rd`, V-register operands.
fn enc_fp1(base: u32, d: u8, n: u8) -> u32 {
    debug_assert!(d < 32 && n < 32);
    base | ((n as u32) << 5) | (d as u32)
}

/// `FADD <Dd>, <Dn>, <Dm>` -- double-precision add. `Dd = Dn + Dm`.
pub(crate) fn enc_fadd_d(dd: u8, dn: u8, dm: u8) -> u32 {
    enc_fp2(0x1E60_2800, dd, dn, dm)
}

/// `FSUB <Dd>, <Dn>, <Dm>`. `Dd = Dn - Dm`.
pub(crate) fn enc_fsub_d(dd: u8, dn: u8, dm: u8) -> u32 {
    enc_fp2(0x1E60_3800, dd, dn, dm)
}

/// `FMUL <Dd>, <Dn>, <Dm>`. `Dd = Dn * Dm`.
pub(crate) fn enc_fmul_d(dd: u8, dn: u8, dm: u8) -> u32 {
    enc_fp2(0x1E60_0800, dd, dn, dm)
}

/// `FDIV <Dd>, <Dn>, <Dm>`. `Dd = Dn / Dm`.
pub(crate) fn enc_fdiv_d(dd: u8, dn: u8, dm: u8) -> u32 {
    enc_fp2(0x1E60_1800, dd, dn, dm)
}

/// `FNEG <Dd>, <Dn>`. `Dd = -Dn`.
pub(crate) fn enc_fneg_d(dd: u8, dn: u8) -> u32 {
    enc_fp1(0x1E61_4000, dd, dn)
}

/// `FSQRT <Dd>, <Dn>` -- scalar double square root. FP data-processing
/// (1 source), ptype=01, opcode=000011.
pub(crate) fn enc_fsqrt_d(dd: u8, dn: u8) -> u32 {
    enc_fp1(0x1E61_C000, dd, dn)
}

/// `FSQRT <Sd>, <Sn>` -- scalar single square root. ptype=00.
pub(crate) fn enc_fsqrt_s(sd: u8, sn: u8) -> u32 {
    enc_fp1(0x1E21_C000, sd, sn)
}

/// `FABS <Dd>, <Dn>` -- scalar double absolute value. opcode=000001.
pub(crate) fn enc_fabs_d(dd: u8, dn: u8) -> u32 {
    enc_fp1(0x1E60_C000, dd, dn)
}

/// `FABS <Sd>, <Sn>` -- scalar single absolute value.
pub(crate) fn enc_fabs_s(sd: u8, sn: u8) -> u32 {
    enc_fp1(0x1E20_C000, sd, sn)
}

/// `FRINTM <Dd>, <Dn>` -- round to integral toward -inf (floor).
/// FP-1-source opcode 001010.
pub(crate) fn enc_frintm_d(dd: u8, dn: u8) -> u32 {
    enc_fp1(0x1E65_4000, dd, dn)
}
/// `FRINTM <Sd>, <Sn>`.
pub(crate) fn enc_frintm_s(sd: u8, sn: u8) -> u32 {
    enc_fp1(0x1E25_4000, sd, sn)
}
/// `FRINTP <Dd>, <Dn>` -- round to integral toward +inf (ceil).
/// FP-1-source opcode 001001.
pub(crate) fn enc_frintp_d(dd: u8, dn: u8) -> u32 {
    enc_fp1(0x1E64_C000, dd, dn)
}
/// `FRINTP <Sd>, <Sn>`.
pub(crate) fn enc_frintp_s(sd: u8, sn: u8) -> u32 {
    enc_fp1(0x1E24_C000, sd, sn)
}
/// `FRINTZ <Dd>, <Dn>` -- round to integral toward zero (trunc).
/// FP-1-source opcode 001011.
pub(crate) fn enc_frintz_d(dd: u8, dn: u8) -> u32 {
    enc_fp1(0x1E65_C000, dd, dn)
}
/// `FRINTZ <Sd>, <Sn>`.
pub(crate) fn enc_frintz_s(sd: u8, sn: u8) -> u32 {
    enc_fp1(0x1E25_C000, sd, sn)
}

/// `FCMP <Dn>, <Dm>` -- set NZCV per the IEEE comparison of `Dn`
/// and `Dm`. Used in the comparison lowering before `CSET`. An
/// unordered (NaN) operand sets N=0, Z=0, C=1, V=1; the condition
/// codes `fp_compare_cond` selects yield the C99 result for that
/// state (`==` false, `!=` true, every relational form false).
pub(crate) fn enc_fcmp_d(dn: u8, dm: u8) -> u32 {
    debug_assert!(dn < 32 && dm < 32);
    0x1E60_2000 | ((dm as u32) << 16) | ((dn as u32) << 5)
}

/// `FMOV <Sd>, <Wn>` -- copy the low 32 bits of `Wn` into the
/// single-precision view `Sd`. Used to stage an f32 constant (one the
/// allocator parks in a GPR as the int-encoded f32 bit pattern)
/// into an FP register before single-precision arithmetic.
pub(crate) fn enc_fmov_w_to_s(sd: u8, wn: Reg) -> u32 {
    debug_assert!(sd < 32);
    0x1E27_0000 | ((wn.0 as u32) << 5) | (sd as u32)
}

/// `FMOV <Wd>, <Sn>` -- copy the low 32 bits of `Sn` into `Wd`; the 32-bit
/// write zero-extends into `Xd`.
pub(crate) fn enc_fmov_s_to_w(rd: Reg, sn: u8) -> u32 {
    debug_assert!(sn < 32);
    0x1E26_0000 | ((sn as u32) << 5) | (rd.0 as u32)
}

/// `INS <Vd>.<T>[index], <Wn>` -- insert the low `esize` bytes of a
/// general register into one element of a vector register, leaving the
/// other elements alone. `esize` is 1, 2, 4 or 8. Composes a vector
/// value from narrower loads when the source address does not satisfy
/// the full width.
pub(crate) fn enc_ins_gen(vd: u8, esize: u32, index: u32, wn: Reg) -> u32 {
    debug_assert!(vd < 32);
    debug_assert!(esize.is_power_of_two() && esize <= 8);
    debug_assert!(index * esize < 16);
    let imm5 = (index << (esize.trailing_zeros() + 1)) | esize;
    0x4E00_1C00 | (imm5 << 16) | ((wn.0 as u32) << 5) | (vd as u32)
}

/// `UMOV <Wd|Xd>, <Vn>.<T>[index]` -- zero-extend one element of a
/// vector register into a general register. The inverse of
/// [`enc_ins_gen`]; decomposes a vector value into narrower stores when
/// the destination address does not satisfy the full width.
pub(crate) fn enc_umov_gen(rd: Reg, vn: u8, esize: u32, index: u32) -> u32 {
    debug_assert!(vn < 32);
    debug_assert!(esize.is_power_of_two() && esize <= 8);
    debug_assert!(index * esize < 16);
    let imm5 = (index << (esize.trailing_zeros() + 1)) | esize;
    let q = u32::from(esize == 8) << 30;
    0x0E00_3C00 | q | (imm5 << 16) | ((vn as u32) << 5) | (rd.0 as u32)
}

/// `FMOV <Sd>, <Sn>` -- copy a single-precision register. Used to
/// move an `float` value into the allocator's chosen register when
/// the producer wrote a different one.
pub(crate) fn enc_fmov_s_s(sd: u8, sn: u8) -> u32 {
    enc_fp1(0x1E20_4000, sd, sn)
}

/// `FADD <Sd>, <Sn>, <Sm>` -- single-precision add. `Sd = Sn + Sm`
/// (C99 6.3.1.8: `float op float` has type `float`).
pub(crate) fn enc_fadd_s(sd: u8, sn: u8, sm: u8) -> u32 {
    enc_fp2(0x1E20_2800, sd, sn, sm)
}

/// `FSUB <Sd>, <Sn>, <Sm>`. `Sd = Sn - Sm`.
pub(crate) fn enc_fsub_s(sd: u8, sn: u8, sm: u8) -> u32 {
    enc_fp2(0x1E20_3800, sd, sn, sm)
}

/// `FMUL <Sd>, <Sn>, <Sm>`. `Sd = Sn * Sm`.
pub(crate) fn enc_fmul_s(sd: u8, sn: u8, sm: u8) -> u32 {
    enc_fp2(0x1E20_0800, sd, sn, sm)
}

/// `FDIV <Sd>, <Sn>, <Sm>`. `Sd = Sn / Sm`.
pub(crate) fn enc_fdiv_s(sd: u8, sn: u8, sm: u8) -> u32 {
    enc_fp2(0x1E20_1800, sd, sn, sm)
}

/// `FNEG <Sd>, <Sn>`. `Sd = -Sn`.
pub(crate) fn enc_fneg_s(sd: u8, sn: u8) -> u32 {
    enc_fp1(0x1E21_4000, sd, sn)
}

/// Floating-point fused multiply-add (3 source). `Dd = (neg_product ?
/// -(Dn*Dm) : Dn*Dm) + (neg_addend ? -Da : Da)`, computed with a single
/// rounding. `is_f32` selects the single-precision form (Sd/Sn/Sm/Sa).
/// The four sign combinations select FMADD / FNMSUB / FMSUB / FNMADD:
/// the o0 bit (15) and the negate-product bit (21) encode the variant
/// per the ARM "Floating-point data-processing (3 source)" group.
pub(crate) fn enc_fma(
    dd: u8,
    dn: u8,
    dm: u8,
    da: u8,
    is_f32: bool,
    neg_product: bool,
    neg_addend: bool,
) -> u32 {
    debug_assert!(dd < 32 && dn < 32 && dm < 32 && da < 32);
    let base: u32 = if is_f32 { 0x1F00_0000 } else { 0x1F40_0000 };
    // (neg_product, neg_addend) -> (o0 bit15, neg bit21):
    //   (F,F) FMADD : Da + Dn*Dm
    //   (F,T) FNMSUB: -Da + Dn*Dm = Dn*Dm - Da
    //   (T,F) FMSUB : Da - Dn*Dm
    //   (T,T) FNMADD: -Da - Dn*Dm
    let (o0, neg): (u32, u32) = match (neg_product, neg_addend) {
        (false, false) => (0, 0),
        (false, true) => (1, 1),
        (true, false) => (1, 0),
        (true, true) => (0, 1),
    };
    base | (neg << 21)
        | ((dm as u32) << 16)
        | (o0 << 15)
        | ((da as u32) << 10)
        | ((dn as u32) << 5)
        | (dd as u32)
}

/// `FCMP <Sn>, <Sm>` -- single-precision compare, setting NZCV.
/// Same NaN caveat as [`enc_fcmp_d`].
pub(crate) fn enc_fcmp_s(sn: u8, sm: u8) -> u32 {
    debug_assert!(sn < 32 && sm < 32);
    0x1E20_2000 | ((sm as u32) << 16) | ((sn as u32) << 5)
}

/// `FCVTZS <Xd>, <Dn>` -- truncating signed FP-to-int. Matches the
/// C `(int)f` semantics: discard the fractional part; out-of-range
/// values saturate.
pub(crate) fn enc_fcvtzs_x_d(rd: Reg, dn: u8) -> u32 {
    debug_assert!(dn < 32);
    0x9E78_0000 | ((dn as u32) << 5) | (rd.0 as u32)
}

/// `FCVTZU <Xd>, <Dn>` -- truncating unsigned FP-to-int. The
/// `FCVTZS` encoding with the opcode low bit set, so a double in
/// [2^63, 2^64) converts to the correct u64 rather than saturating.
pub(crate) fn enc_fcvtzu_x_d(rd: Reg, dn: u8) -> u32 {
    debug_assert!(dn < 32);
    0x9E79_0000 | ((dn as u32) << 5) | (rd.0 as u32)
}

/// `SCVTF <Dd>, <Xn>` -- signed int-to-FP. Emits the round-to-
/// nearest-ties-to-even mantissa.
pub(crate) fn enc_scvtf_d_x(dd: u8, xn: Reg) -> u32 {
    debug_assert!(dd < 32);
    0x9E62_0000 | ((xn.0 as u32) << 5) | (dd as u32)
}

/// `UCVTF <Dd>, <Xn>` -- unsigned int-to-FP. The `SCVTF` encoding
/// with the opcode low bit set, so a u64 with bit 63 set converts
/// to a positive double rather than a negative one.
pub(crate) fn enc_ucvtf_d_x(dd: u8, xn: Reg) -> u32 {
    debug_assert!(dd < 32);
    0x9E63_0000 | ((xn.0 as u32) << 5) | (dd as u32)
}

/// `SCVTF <Sd>, <Xn>` -- signed int-to-single. The `enc_scvtf_d_x`
/// encoding with the ptype field cleared to `00` (single). Converts
/// a 64-bit integer to `float` in one rounding (C99 6.3.1.4), the
/// direct form for `(float)n` that avoids the double-then-narrow pair.
pub(crate) fn enc_scvtf_s_x(sd: u8, xn: Reg) -> u32 {
    debug_assert!(sd < 32);
    0x9E22_0000 | ((xn.0 as u32) << 5) | (sd as u32)
}

/// `UCVTF <Sd>, <Xn>` -- unsigned int-to-single. `enc_ucvtf_d_x`
/// with ptype `00`.
pub(crate) fn enc_ucvtf_s_x(sd: u8, xn: Reg) -> u32 {
    debug_assert!(sd < 32);
    0x9E23_0000 | ((xn.0 as u32) << 5) | (sd as u32)
}

/// `FCVTZS <Xd>, <Sn>` -- truncating signed single-to-int.
/// `enc_fcvtzs_x_d` with the ptype field cleared to `00` (single
/// source). The direct form for `(int)f` that avoids widening the
/// `float` to double first.
pub(crate) fn enc_fcvtzs_x_s(rd: Reg, sn: u8) -> u32 {
    debug_assert!(sn < 32);
    0x9E38_0000 | ((sn as u32) << 5) | (rd.0 as u32)
}

/// `FCVTZU <Xd>, <Sn>` -- truncating unsigned single-to-int.
/// `enc_fcvtzu_x_d` with ptype `00`.
pub(crate) fn enc_fcvtzu_x_s(rd: Reg, sn: u8) -> u32 {
    debug_assert!(sn < 32);
    0x9E39_0000 | ((sn as u32) << 5) | (rd.0 as u32)
}

/// `MRS <Xt>, TPIDR_EL0` -- read the per-thread pointer system
/// register. Linux glibc populates `TPIDR_EL0` at thread setup
/// with the address of `struct pthread`, and the TLS image (our
/// `.tdata` / `.tbss`) follows immediately after the TCB header.
/// `var_addr = TPIDR_EL0 + TLS_TCB_HEAD (16) + offset_in_block`.
pub(crate) fn enc_mrs_tpidr_el0(rt: Reg) -> u32 {
    // 1101_0101_0011_0011_1101_0000_0100_0000 + Rt
    // (op0=11, op1=011, CRn=1101, CRm=0000, op2=010)
    0xD53B_D040 | (rt.0 as u32)
}

/// `MRS <Xt>, <systemreg>`, where `field` is the register's `mrs`/`msr`
/// selector packed as `op0<<14 | op1<<11 | CRn<<7 | CRm<<3 | op2` (the
/// form [`crate::c5::codegen::stack_guard_sysreg`] returns). The
/// instruction carries the low 15 bits of the field at bits 19..5.
pub(crate) fn enc_mrs(rt: Reg, field: u16) -> u32 {
    0xD530_0000 | ((u32::from(field) & 0x7FFF) << 5) | (rt.0 as u32)
}

/// `LDR <Dt>, [<Xn|SP>, #imm]` -- 64-bit unsigned-offset FP/SIMD
/// load. The offset is byte-addressed but encoded as `imm/8`; the
/// caller passes raw bytes (a multiple of 8, up to 32760).
pub(crate) fn enc_ldr_d_imm(dt: u8, rn: Reg, imm: u32) -> u32 {
    enc_mem(LDR_D, dt, rn, LDR_D.scaled(imm))
}

/// `LDR <St>, [<Xn|SP>, #imm]` -- 32-bit unsigned-offset FP/SIMD
/// load. The offset is byte-addressed but encoded as `imm/4`; the
/// caller passes raw bytes (a multiple of 4, up to 16380).
pub(crate) fn enc_ldr_s_imm(st: u8, rn: Reg, imm: u32) -> u32 {
    enc_mem(LDR_S, st, rn, LDR_S.scaled(imm))
}

/// `STR <St>, [<Xn|SP>, #imm]` -- 32-bit unsigned-offset FP/SIMD
/// store. Same encoding family as [`enc_ldr_s_imm`]; companion
/// to the `StoreKind::F32` lowering.
pub(crate) fn enc_str_s_imm(st: u8, rn: Reg, imm: u32) -> u32 {
    enc_mem(STR_S, st, rn, STR_S.scaled(imm))
}

/// `STR <Dt>, [<Xn|SP>, #imm]` -- 64-bit unsigned-offset FP/SIMD
/// store, the partner of [`enc_ldr_d_imm`].
pub(crate) fn enc_str_d_imm(dt: u8, rn: Reg, imm: u32) -> u32 {
    enc_mem(STR_D, dt, rn, STR_D.scaled(imm))
}

/// `LDR <Qt>, [<Xn|SP>, #imm]` -- 128-bit unsigned-offset FP/SIMD
/// load. The offset is byte-addressed but encoded as `imm/16`.
pub(crate) fn enc_ldr_q_imm(qt: u8, rn: Reg, imm: u32) -> u32 {
    enc_mem(LDR_Q, qt, rn, LDR_Q.scaled(imm))
}

/// `STR <Qt>, [<Xn|SP>, #imm]` -- 128-bit unsigned-offset FP/SIMD
/// store, the partner of [`enc_ldr_q_imm`].
pub(crate) fn enc_str_q_imm(qt: u8, rn: Reg, imm: u32) -> u32 {
    enc_mem(STR_Q, qt, rn, STR_Q.scaled(imm))
}

/// `MOV <Vd>.16B, <Vn>.16B` (`ORR Vd.16B, Vn.16B, Vn.16B`).
pub(crate) fn enc_mov_v16b(vd: u8, vn: u8) -> u32 {
    debug_assert!(vd < 32 && vn < 32);
    0x4EA0_1C00 | ((vn as u32) << 16) | ((vn as u32) << 5) | vd as u32
}

/// `ADR <Xd>, label` -- compute a PC-relative byte address (signed
/// 21-bit offset) into `Xd`. Used by the AArch64 setjmp intrinsic
/// to capture the resume address that a later longjmp branches to.
/// Offset is in bytes from the ADR's own PC.
pub(crate) fn enc_adr(rd: Reg, off_bytes: i32) -> u32 {
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
pub(crate) fn enc_cinc(rd: Reg, rn: Reg, cond: Cond) -> u32 {
    let inv = (cond as u32) ^ 1;
    0x9A80_0400 | ((rn.0 as u32) << 16) | (inv << 12) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `FCVT <Dd>, <Sn>` -- widen single-precision to double-precision
/// (bit-exact for any finite single value, matching the IEEE
/// short-to-long conversion). Used by [`LoadKind::F32`] after the
/// single-precision load.
pub(crate) fn enc_fcvt_d_s(dd: u8, sn: u8) -> u32 {
    debug_assert!(dd < 32 && sn < 32);
    0x1E22_C000 | ((sn as u32) << 5) | (dd as u32)
}

/// `FCVT <Sd>, <Dn>` -- narrow double-precision to single-precision
/// with round-to-nearest-ties-to-even (matching IEEE 754 and the
/// VM's `f64 as f32` semantics). Used by the `StoreKind::F32`
/// lowering before the single-precision store.
pub(crate) fn enc_fcvt_s_d(sd: u8, dn: u8) -> u32 {
    debug_assert!(sd < 32 && dn < 32);
    0x1E62_4000 | ((dn as u32) << 5) | (sd as u32)
}

// ---- Comparisons + condition-set. ----

/// `CMP <Xn>, <Xm>` = `SUBS XZR, <Xn>, <Xm>` -- compare two registers,
/// updating the NZCV flags but discarding the result.
pub(crate) fn enc_cmp_reg(rn: Reg, rm: Reg) -> u32 {
    0xEB00_0000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (Reg::SP.0 as u32)
}

/// `CMP <Wn>, <Wm>` -- the 32-bit form of [`enc_cmp_reg`]. The operands
/// are read as W registers, so bits 32..63 do not reach the flags.
pub(crate) fn enc_cmp_reg_w(rn: Reg, rm: Reg) -> u32 {
    0x6B00_0000 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (Reg::SP.0 as u32)
}

/// `SUBS <Wd>, <Wn|WSP>, #imm12` -- the 32-bit form of [`enc_subs_imm`].
pub(crate) fn enc_subs_imm_w(rd: Reg, rn: Reg, imm12: u32) -> u32 {
    debug_assert!(imm12 < 4096, "subs imm: {imm12} > 12-bit max");
    0x7100_0000 | (imm12 << 10) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// AArch64 condition codes -- the 4-bit field that follows comparisons
/// and conditional moves. Names match the ARM ARM. The Mi/Ls
/// variants are the FP-comparison flavour: after `FCMP`, the
/// `<`/`<=` results live under the unsigned/sign-bit codes
/// (mi/ls) rather than the signed-arithmetic lt/le, because
/// FCMP's flag layout differs from SUBS's.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Cond {
    Eq = 0,
    Ne = 1,
    /// Unsigned `>=` (HS = CS). After SUBS, set when no borrow occurred.
    Hs = 0x2,
    /// Unsigned `<` (LO = CC). After SUBS, set when borrow occurred.
    Lo = 0x3,
    /// FP "less than" -- N==1, set by FCMP when Dn < Dm (ordered).
    Mi = 0x4,
    /// N==0, the exact complement of `Mi`; taken by a `Bz`-fused FP
    /// `<` branch, including the unordered case FCMP leaves N clear.
    Pl = 0x5,
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
    /// `BinOp::Lt` is followed by a `Terminator::Bz`, the
    /// branch fires on "(lhs < rhs) is false", i.e. "lhs >= rhs"
    /// -- so `Cond::Lt.flip() == Cond::Ge`. The complement is exact
    /// over the NZCV states, so it also inverts an FCMP condition
    /// correctly for the unordered (NaN) state.
    pub(crate) fn flip(self) -> Cond {
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
            Cond::Mi => Cond::Pl,
            Cond::Pl => Cond::Mi,
        }
    }
}

/// `CSET <Xd>, <cond>` = `CSINC Xd, XZR, XZR, invert(cond)`.
/// Sets `Xd` to 1 if `cond` holds, 0 otherwise.
pub(crate) fn enc_cset(rd: Reg, cond: Cond) -> u32 {
    0x9A80_0400
        | ((Reg::SP.0 as u32) << 16) // Rm = XZR
        | (cond.invert() << 12)
        | ((Reg::SP.0 as u32) << 5)  // Rn = XZR
        | (rd.0 as u32)
}

// ---- Branches. ----

/// `B <label>` -- unconditional branch, PC-relative offset measured
/// in instructions. Same encoding family as `BL` minus the link bit.
pub(crate) fn enc_b(imm26: i32) -> u32 {
    debug_assert!(
        (-(1 << 25)..(1 << 25)).contains(&imm26),
        "b: offset {imm26} out of range"
    );
    0x1400_0000 | ((imm26 as u32) & 0x03FF_FFFF)
}

/// `CBZ <Xt>, <label>` -- compare `Xt` with zero and branch if equal.
/// `imm19` is signed, in instructions. +/-1 MiB range.
pub(crate) fn enc_cbz(rt: Reg, imm19: i32) -> u32 {
    debug_assert!(
        (-(1 << 18)..(1 << 18)).contains(&imm19),
        "cbz: offset {imm19} out of range (must fit in signed 19 bits)"
    );
    0xB400_0000 | (((imm19 as u32) & 0x7_FFFF) << 5) | (rt.0 as u32)
}

/// `CBNZ <Xt>, <label>` -- branch if `Xt` is not zero.
pub(crate) fn enc_cbnz(rt: Reg, imm19: i32) -> u32 {
    debug_assert!(
        (-(1 << 18)..(1 << 18)).contains(&imm19),
        "cbnz: offset {imm19} out of range"
    );
    0xB500_0000 | (((imm19 as u32) & 0x7_FFFF) << 5) | (rt.0 as u32)
}

/// `CBZ Wt, label`: the 32-bit form of [`enc_cbz`].
pub(crate) fn enc_cbz_w(rt: Reg, imm19: i32) -> u32 {
    enc_cbz(rt, imm19) & !0x8000_0000
}

/// `CBNZ Wt, label`: the 32-bit form of [`enc_cbnz`].
pub(crate) fn enc_cbnz_w(rt: Reg, imm19: i32) -> u32 {
    enc_cbnz(rt, imm19) & !0x8000_0000
}

/// `TBZ Rt, #bit, label` -- branch if bit `bit` of `Xt` is zero; `imm14`
/// is signed, in instructions (+/-32 KiB).
pub(crate) fn enc_tbz(rt: Reg, bit: u8, imm14: i32) -> u32 {
    debug_assert!(bit < 64, "tbz: bit {bit}");
    debug_assert!(
        (-(1 << 13)..(1 << 13)).contains(&imm14),
        "tbz: offset {imm14} out of range"
    );
    let b = bit as u32;
    0x3600_0000
        | ((b >> 5) << 31)
        | ((b & 31) << 19)
        | (((imm14 as u32) & 0x3FFF) << 5)
        | rt.0 as u32
}

/// `TBNZ Rt, #bit, label` -- branch if bit `bit` of `Xt` is one.
pub(crate) fn enc_tbnz(rt: Reg, bit: u8, imm14: i32) -> u32 {
    enc_tbz(rt, bit, imm14) | 0x0100_0000
}

/// `B.<cond> <label>` -- branch if the NZCV flags satisfy `cond`.
/// `imm19` is signed, in instructions; same +/-1 MiB range as
/// `CBZ`/`CBNZ`. The encoder builds the canonical form
/// `0101_0100 imm19 0 cond`.
pub(crate) fn enc_b_cond(cond: Cond, imm19: i32) -> u32 {
    debug_assert!(
        (-(1 << 18)..(1 << 18)).contains(&imm19),
        "b.cond: offset {imm19} out of range (must fit in signed 19 bits)"
    );
    0x5400_0000 | (((imm19 as u32) & 0x7_FFFF) << 5) | (cond as u32)
}

/// `BLR <Xn>` -- branch with link to the address in `Xn`. Used for
/// indirect calls (function pointer through GOT).
pub(crate) fn enc_blr(rn: Reg) -> u32 {
    0xD63F_0000 | ((rn.0 as u32) << 5)
}

/// `BTI C` -- branch-target landing pad accepting an indirect call
/// (`BLR`, PSTATE.BTYPE 0b10) and a `BR` through x16/x17 (0b01).
/// `HINT #34`, so it decodes as a NOP where FEAT_BTI is absent.
pub(crate) const BTI_C: u32 = 0xD503_245F;

/// `BTI J` -- landing pad accepting a `BR` through any register
/// (PSTATE.BTYPE 0b11) as well as 0b01. `HINT #36`.
pub(crate) const BTI_J: u32 = 0xD503_249F;

/// `PACIASP` -- sign x30 with key A, modifier sp. `HINT #25`, so it
/// decodes as a NOP where FEAT_PAuth is absent. Also a landing pad
/// for PSTATE.BTYPE 0b01 / 0b10, which is every way a function entry
/// is reached indirectly (Arm ARM D24.2.2).
pub(crate) const PACIASP: u32 = 0xD503_233F;

/// `AUTIASP` -- authenticate x30 with key A, modifier sp. `HINT #29`.
/// The modifier must match the one `PACIASP` signed with, so sp has to
/// be back at its function-entry value.
pub(crate) const AUTIASP: u32 = 0xD503_23BF;

/// `XPACLRI` -- strip the authentication code from x30. `HINT #7`, so it
/// decodes as a NOP where FEAT_PAuth is absent and leaves an unsigned
/// pointer unchanged. x30 is the only register the hint form reaches;
/// stripping any other needs `XPACI <Xd>`, which requires FEAT_PAuth.
pub(crate) const XPACLRI: u32 = 0xD503_20FF;

/// `NOP` (`HINT #0`).
pub(crate) const NOP: u32 = 0xD503_201F;

/// `BR <Xn>` -- branch (no link) to the address in `Xn`. Used by
/// the `Terminator::TailExt` lowering to forward control to the
/// IAT/GOT-resolved libc address without saving a return point:
/// the libc fn's `RET` lands back at the c5 caller's post-call
/// continuation instead of bouncing back through the trampoline.
pub(crate) fn enc_br(rn: Reg) -> u32 {
    0xD61F_0000 | ((rn.0 as u32) << 5)
}

/// `SVC #imm16` -- supervisor call (system call). On Linux/aarch64
/// the kernel reads the intrinsic number from `x8` and the arguments
/// from `x0..x5`; the immediate is conventionally zero.
pub(crate) fn enc_svc(imm16: u16) -> u32 {
    0xD400_0001 | ((imm16 as u32) << 5)
}

// ---- Loads / stores of one register at an immediate offset (ARM ARM
//      C4.1.94): bit 24 selects the scaled imm12 over the signed imm9.

/// One register kind and width of `LDR` / `STR`: the unscaled-offset
/// word with Rt, Rn and the offset clear, and log2 of the access size.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) struct MemOp {
    word: u32,
    scale: u32,
}

/// An offset field a load or store of one access size holds.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) struct MemOff {
    scale: u32,
    field: u32,
}

impl MemOp {
    const fn new(word: u32, scale: u32) -> Self {
        Self { word, scale }
    }

    /// The access size in bytes.
    pub(crate) fn size(self) -> u32 {
        1 << self.scale
    }

    fn scaled_field(self, imm: i64) -> Option<MemOff> {
        let fits = imm >= 0 && imm % (1 << self.scale) == 0 && (imm >> self.scale) < 4096;
        fits.then(|| MemOff {
            scale: self.scale,
            field: (1 << 24) | (((imm >> self.scale) as u32) << 10),
        })
    }

    fn unscaled_field(self, imm: i64) -> Option<MemOff> {
        (-256..256).contains(&imm).then_some(MemOff {
            scale: self.scale,
            field: ((imm as u32) & 0x1FF) << 12,
        })
    }

    /// The field for byte displacement `disp`: scaled when aligned and in
    /// its 12-bit reach, else unscaled in [-256, 255]; `None` past both.
    pub(crate) fn offset(self, disp: i64) -> Option<MemOff> {
        self.scaled_field(disp)
            .or_else(|| self.unscaled_field(disp))
    }

    /// The scaled form at byte offset `imm`, refused in every build past it.
    pub(crate) fn scaled(self, imm: u32) -> MemOff {
        match self.scaled_field(imm.into()) {
            Some(off) => off,
            None => panic!("{self:?}: offset {imm} outside the scaled 12-bit form"),
        }
    }

    /// The unscaled form at byte offset `imm`, refused past [-256, 255].
    pub(crate) fn unscaled(self, imm: i32) -> MemOff {
        match self.unscaled_field(imm.into()) {
            Some(off) => off,
            None => panic!("{self:?}: offset {imm} outside the unscaled 9-bit form"),
        }
    }
}

pub(crate) const LDR_X: MemOp = MemOp::new(0xF840_0000, 3);
pub(crate) const STR_X: MemOp = MemOp::new(0xF800_0000, 3);
pub(crate) const LDR_W: MemOp = MemOp::new(0xB840_0000, 2);
pub(crate) const LDRSW: MemOp = MemOp::new(0xB880_0000, 2);
pub(crate) const STR_W: MemOp = MemOp::new(0xB800_0000, 2);
pub(crate) const LDRH: MemOp = MemOp::new(0x7840_0000, 1);
pub(crate) const LDRSH: MemOp = MemOp::new(0x7880_0000, 1);
pub(crate) const STRH: MemOp = MemOp::new(0x7800_0000, 1);
pub(crate) const LDRB: MemOp = MemOp::new(0x3840_0000, 0);
pub(crate) const LDRSB: MemOp = MemOp::new(0x3880_0000, 0);
pub(crate) const STRB: MemOp = MemOp::new(0x3800_0000, 0);
pub(crate) const LDR_S: MemOp = MemOp::new(0xBC40_0000, 2);
pub(crate) const STR_S: MemOp = MemOp::new(0xBC00_0000, 2);
pub(crate) const LDR_D: MemOp = MemOp::new(0xFC40_0000, 3);
pub(crate) const STR_D: MemOp = MemOp::new(0xFC00_0000, 3);
pub(crate) const LDR_Q: MemOp = MemOp::new(0x3CC0_0000, 4);
pub(crate) const STR_Q: MemOp = MemOp::new(0x3C80_0000, 4);

/// `op` between `rt` (a GPR or SIMD register, by `op`) and `[rn + off]`.
pub(crate) fn enc_mem(op: MemOp, rt: u8, rn: Reg, off: MemOff) -> u32 {
    assert_eq!(
        off.scale, op.scale,
        "{op:?}: offset built for another access size"
    );
    debug_assert!(rt < 32);
    op.word | off.field | ((rn.0 as u32) << 5) | (rt as u32)
}

/// `LDR <Xt>, [<Xn|SP>, #imm]` -- 64-bit load, immediate offset
/// scaled by 8. `imm` is the byte offset; range `[0, 32760]`.
pub(crate) fn enc_ldr_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_mem(LDR_X, rt.0, rn, LDR_X.scaled(imm))
}

/// `STR <Xt>, [<Xn|SP>, #imm]` -- 64-bit store. Same scaling as `LDR`.
pub(crate) fn enc_str_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_mem(STR_X, rt.0, rn, STR_X.scaled(imm))
}

/// `LDR <Wt>, [<Xn|SP>, #imm]` -- 32-bit load (zero-extended into
/// `Xt`), immediate offset scaled by 4. Used by the Win64 TLS
/// lowering to read the 4-byte `_tls_index` slot.
pub(crate) fn enc_ldr32_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_mem(LDR_W, rt.0, rn, LDR_W.scaled(imm))
}

/// `LDRSW <Xt>, [<Xn|SP>, #imm]` -- 32-bit load sign-extended into
/// the full 64-bit `Xt`, immediate offset scaled by 4. Used by
/// [`LoadKind::I32`] for signed `int` lvalue reads -- the C signed-int
/// model requires the high bit of the 4-byte slot to propagate.
pub(crate) fn enc_ldrsw_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_mem(LDRSW, rt.0, rn, LDRSW.scaled(imm))
}

/// `STR <Wt>, [<Xn|SP>, #imm]` -- 32-bit store (low half of `Xt`),
/// immediate offset scaled by 4. Companion to [`enc_ldrsw_imm`] /
/// [`enc_ldr32_imm`] for the `StoreKind::I32` lowering.
pub(crate) fn enc_str32_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_mem(STR_W, rt.0, rn, STR_W.scaled(imm))
}

/// `option` of a register-offset access or an extended-register add:
/// `lsl` / `uxtx` over Xm, or Wm zero- or sign-extended.
fn index_option(ext: IndexExt) -> u32 {
    match ext {
        IndexExt::None => 0b011,
        IndexExt::Uxtw => 0b010,
        IndexExt::Sxtw => 0b110,
    }
}

/// A load or store `[Xn|SP, Rm, <ext> #s]`. `form` holds size, opc and
/// `S`: set, the index shifts by log2 of the access size.
fn enc_reg_offset(form: u32, rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    form | ((rm.0 as u32) << 16) | (index_option(ext) << 13) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDR Xt, [Xn|SP, Rm, <ext> #3]`. The Win64 TLS lowering fetches
/// `tls_array[_tls_index]` with it.
pub(crate) fn enc_ldr_reg_lsl3(rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    enc_reg_offset(0xF860_1800, rt, rn, rm, ext)
}

/// `LDRSW Xt, [Xn|SP, Rm, <ext> #2]`.
pub(crate) fn enc_ldrsw_reg_lsl2(rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    enc_reg_offset(0xB8A0_1800, rt, rn, rm, ext)
}

/// `LDR Wt, [Xn|SP, Rm, <ext> #2]`.
pub(crate) fn enc_ldr32_reg_lsl2(rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    enc_reg_offset(0xB860_1800, rt, rn, rm, ext)
}

/// `LDRSH Xt, [Xn|SP, Rm, <ext> #1]`.
pub(crate) fn enc_ldrsh_reg_lsl1(rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    enc_reg_offset(0x78A0_1800, rt, rn, rm, ext)
}

/// `LDRH Wt, [Xn|SP, Rm, <ext> #1]`.
pub(crate) fn enc_ldrh_reg_lsl1(rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    enc_reg_offset(0x7860_1800, rt, rn, rm, ext)
}

/// `LDRSB Xt, [Xn|SP, Rm, <ext>]`.
pub(crate) fn enc_ldrsb_reg(rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    enc_reg_offset(0x38A0_0800, rt, rn, rm, ext)
}

/// `LDRB Wt, [Xn|SP, Rm, <ext>]`.
pub(crate) fn enc_ldrb_reg(rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    enc_reg_offset(0x3860_0800, rt, rn, rm, ext)
}

/// `STR Xt, [Xn|SP, Rm, <ext> #3]`.
pub(crate) fn enc_str_reg_lsl3(rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    enc_reg_offset(0xF820_1800, rt, rn, rm, ext)
}

/// `STR Wt, [Xn|SP, Rm, <ext> #2]`.
pub(crate) fn enc_str32_reg_lsl2(rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    enc_reg_offset(0xB820_1800, rt, rn, rm, ext)
}

/// `STRH Wt, [Xn|SP, Rm, <ext> #1]`.
pub(crate) fn enc_strh_reg_lsl1(rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    enc_reg_offset(0x7820_1800, rt, rn, rm, ext)
}

/// `STRB Wt, [Xn|SP, Rm, <ext>]`.
pub(crate) fn enc_strb_reg(rt: Reg, rn: Reg, rm: Reg, ext: IndexExt) -> u32 {
    enc_reg_offset(0x3820_0800, rt, rn, rm, ext)
}

/// `LDRSH <Xt>, [<Xn|SP>, #imm]` -- 16-bit load sign-extended into
/// the full 64-bit `Xt`, immediate offset scaled by 2. Used by
/// [`LoadKind::I16`] for `short` lvalue reads. Encoding: opc=10
/// (sign-extend to 64-bit), size=01 (halfword).
pub(crate) fn enc_ldrsh_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_mem(LDRSH, rt.0, rn, LDRSH.scaled(imm))
}

/// `LDRH <Wt>, [<Xn|SP>, #imm]` -- 16-bit load zero-extended into
/// `Wt` (which clears the high 32 bits of `Xt`), immediate offset
/// scaled by 2. Used by [`LoadKind::U16`] for `unsigned short` lvalue
/// reads. Encoding: opc=01 (load), size=01.
pub(crate) fn enc_ldrh_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_mem(LDRH, rt.0, rn, LDRH.scaled(imm))
}

/// `STRH <Wt>, [<Xn|SP>, #imm]` -- 16-bit store (low half of `Wt`),
/// immediate offset scaled by 2. Companion to [`enc_ldrsh_imm`] /
/// [`enc_ldrh_imm`] for the `StoreKind::I16` lowering.
pub(crate) fn enc_strh_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_mem(STRH, rt.0, rn, STRH.scaled(imm))
}

/// `LDRB <Wt>, [<Xn|SP>, #imm]` -- byte load, zero-extended into a
/// 32-bit register (which on AArch64 means the high 32 bits of the
/// 64-bit register are also cleared).
pub(crate) fn enc_ldrb_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_mem(LDRB, rt.0, rn, LDRB.scaled(imm))
}

/// `LDRSB <Xt>, [<Xn|SP>, #imm]` -- byte load sign-extended into
/// the full 64-bit `Xt`. Used by [`LoadKind::I8`] for `signed char`
/// lvalue reads. Encoding: opc=10 (sign-extend to 64-bit),
/// size=00 (byte). Imm is unscaled (byte stride).
pub(crate) fn enc_ldrsb_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_mem(LDRSB, rt.0, rn, LDRSB.scaled(imm))
}

/// `STRB <Wt>, [<Xn|SP>, #imm]` -- byte store. Stores the low 8 bits
/// of `Wt` and ignores the rest.
pub(crate) fn enc_strb_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_mem(STRB, rt.0, rn, STRB.scaled(imm))
}

// ---- Exclusive-monitor load / store (ARM ARM C6.2). Used by the
//      atomic read-modify-write and compare-exchange lowering: a
//      LDAXR / STLXR retry loop needs no feature detection, unlike the
//      LSE atomics. `width` selects the access size variant
//      (B / H / W / X). The acquire (LDAXR) / release (STLXR) ordering
//      gives the sequentially-consistent semantics C11 7.17.3 requires
//      for the default memory order.

/// Size field (bits[31:30]) for an exclusive load / store of `width`
/// bytes: 00 byte, 01 halfword, 10 word, 11 doubleword.
fn excl_size(width: u8) -> u32 {
    match width {
        1 => 0b00,
        2 => 0b01,
        4 => 0b10,
        _ => 0b11,
    }
}

/// `LDAXR{B,H} <Wt>, [<Xn|SP>]` / `LDAXR <Wt|Xt>, [<Xn|SP>]` --
/// load-acquire exclusive register of `width` bytes. No offset.
pub(crate) fn enc_ldaxr(rt: Reg, rn: Reg, width: u8) -> u32 {
    0x085F_FC00 | (excl_size(width) << 30) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STLXR{B,H} <Ws>, <Wt>, [<Xn|SP>]` / `STLXR <Ws>, <Wt|Xt>,
/// [<Xn|SP>]` -- store-release exclusive register of `width` bytes.
/// `rs` receives 0 on success and 1 when the monitor was lost.
pub(crate) fn enc_stlxr(rs: Reg, rt: Reg, rn: Reg, width: u8) -> u32 {
    0x0800_FC00
        | (excl_size(width) << 30)
        | ((rs.0 as u32) << 16)
        | ((rn.0 as u32) << 5)
        | (rt.0 as u32)
}

/// `LDAR{B,H} <Wt>, [<Xn|SP>]` / `LDAR <Wt|Xt>, [<Xn|SP>]` --
/// load-acquire register of `width` bytes, zero-extended. No offset.
pub(crate) fn enc_ldar(rt: Reg, rn: Reg, width: u8) -> u32 {
    0x08DF_FC00 | (excl_size(width) << 30) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STLR{B,H} <Wt>, [<Xn|SP>]` / `STLR <Wt|Xt>, [<Xn|SP>]` --
/// store-release register of `width` bytes. No offset.
pub(crate) fn enc_stlr(rt: Reg, rn: Reg, width: u8) -> u32 {
    0x089F_FC00 | (excl_size(width) << 30) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDAXP <Xt1>, <Xt2>, [<Xn|SP>]` -- load-acquire exclusive pair of
/// 64-bit registers, the load half of a 128-bit exclusive access.
pub(crate) fn enc_ldaxp(rt: Reg, rt2: Reg, rn: Reg) -> u32 {
    0xC87F_8000 | ((rt2.0 as u32) << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STLXP <Ws>, <Xt1>, <Xt2>, [<Xn|SP>]` -- store-release exclusive
/// pair of 64-bit registers. `rs` receives 0 on success and 1 when the
/// monitor was lost.
pub(crate) fn enc_stlxp(rs: Reg, rt: Reg, rt2: Reg, rn: Reg) -> u32 {
    0xC820_8000
        | ((rs.0 as u32) << 16)
        | ((rt2.0 as u32) << 10)
        | ((rn.0 as u32) << 5)
        | (rt.0 as u32)
}

/// `LDXP <Xt1>, <Xt2>, [<Xn|SP>]` -- load exclusive pair, the non-acquire
/// counterpart of [`enc_ldaxp`] (the acquire `o0` bit 15 cleared).
pub(crate) fn enc_ldxp(rt: Reg, rt2: Reg, rn: Reg) -> u32 {
    0xC87F_0000 | ((rt2.0 as u32) << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STXP <Ws>, <Xt1>, <Xt2>, [<Xn|SP>]` -- store exclusive pair, the
/// non-release counterpart of [`enc_stlxp`] (the release `o0` bit 15
/// cleared). `rs` receives 0 on success and 1 when the monitor was lost.
pub(crate) fn enc_stxp(rs: Reg, rt: Reg, rt2: Reg, rn: Reg) -> u32 {
    0xC820_0000
        | ((rs.0 as u32) << 16)
        | ((rt2.0 as u32) << 10)
        | ((rn.0 as u32) << 5)
        | (rt.0 as u32)
}

/// `CCMP <Xn>, <Xm>, #<nzcv>, <cond>` -- conditional compare (register),
/// 64-bit. When `cond` holds, compare `Xn` with `Xm`; otherwise set the
/// flags directly from `nzcv`. Used to fuse a two-word equality test.
pub(crate) fn enc_ccmp(rn: Reg, rm: Reg, nzcv: u8, cond: Cond) -> u32 {
    0xFA40_0000
        | ((rm.0 as u32) << 16)
        | ((cond as u32) << 12)
        | ((rn.0 as u32) << 5)
        | (nzcv as u32 & 0xF)
}

// ---- Loads / stores (unscaled 9-bit signed offset). Used for negative
//      stack-frame offsets (locals at fp - N*8).

/// `LDUR <Xt>, [<Xn|SP>, #imm]` -- unscaled 9-bit signed offset.
/// Range `[-256, 255]`. Locals sit at `fp - 8`, `fp - 16`, ... so we
/// reach for this whenever `LDR`'s unsigned scaled form can't fit
/// the negative offset.
pub(crate) fn enc_ldur(rt: Reg, rn: Reg, imm: i32) -> u32 {
    enc_mem(LDR_X, rt.0, rn, LDR_X.unscaled(imm))
}

/// `STUR <Xt>, [<Xn|SP>, #imm]` -- unscaled 9-bit signed offset.
/// Mirror of [`enc_ldur`].
pub(crate) fn enc_stur(rt: Reg, rn: Reg, imm: i32) -> u32 {
    enc_mem(STR_X, rt.0, rn, STR_X.unscaled(imm))
}

/// `LDURSW <Xt>, [<Xn|SP>, #imm]` -- load 4 bytes, sign-extend to
/// 64. Unscaled 9-bit signed offset.
pub(crate) fn enc_ldursw(rt: Reg, rn: Reg, imm: i32) -> u32 {
    enc_mem(LDRSW, rt.0, rn, LDRSW.unscaled(imm))
}

/// `LDUR <Wt>, [<Xn|SP>, #imm]` -- load 4 bytes into a 32-bit
/// register, zero-extending to the full 64-bit Xt.
pub(crate) fn enc_ldur32(rt: Reg, rn: Reg, imm: i32) -> u32 {
    enc_mem(LDR_W, rt.0, rn, LDR_W.unscaled(imm))
}

/// `LDURSH <Xt>, [<Xn|SP>, #imm]` -- load 2 bytes, sign-extend to
/// 64. Unscaled 9-bit signed offset.
pub(crate) fn enc_ldursh(rt: Reg, rn: Reg, imm: i32) -> u32 {
    enc_mem(LDRSH, rt.0, rn, LDRSH.unscaled(imm))
}

/// `LDURH <Wt>, [<Xn|SP>, #imm]` -- load 2 bytes, zero-extend
/// (to 32 bits, implicitly to 64). Unscaled 9-bit signed offset.
pub(crate) fn enc_ldurh(rt: Reg, rn: Reg, imm: i32) -> u32 {
    enc_mem(LDRH, rt.0, rn, LDRH.unscaled(imm))
}

/// `LDURSB <Xt>, [<Xn|SP>, #imm]` -- load 1 byte, sign-extend to
/// 64. Unscaled 9-bit signed offset.
pub(crate) fn enc_ldursb(rt: Reg, rn: Reg, imm: i32) -> u32 {
    enc_mem(LDRSB, rt.0, rn, LDRSB.unscaled(imm))
}

/// `LDURB <Wt>, [<Xn|SP>, #imm]` -- load 1 byte, zero-extend
/// (to 32 bits, implicitly to 64). Unscaled 9-bit signed offset.
pub(crate) fn enc_ldurb(rt: Reg, rn: Reg, imm: i32) -> u32 {
    enc_mem(LDRB, rt.0, rn, LDRB.unscaled(imm))
}

/// `STUR <Wt>, [<Xn|SP>, #imm]` -- store low 32 bits of Xt.
pub(crate) fn enc_stur32(rt: Reg, rn: Reg, imm: i32) -> u32 {
    enc_mem(STR_W, rt.0, rn, STR_W.unscaled(imm))
}

/// `STURH <Wt>, [<Xn|SP>, #imm]` -- store low 16 bits of Xt.
pub(crate) fn enc_sturh(rt: Reg, rn: Reg, imm: i32) -> u32 {
    enc_mem(STRH, rt.0, rn, STRH.unscaled(imm))
}

/// `STURB <Wt>, [<Xn|SP>, #imm]` -- store low 8 bits of Xt.
pub(crate) fn enc_sturb(rt: Reg, rn: Reg, imm: i32) -> u32 {
    enc_mem(STRB, rt.0, rn, STRB.unscaled(imm))
}

/// `LSL <Xd>, <Xn>, #shift` -- logical shift left by immediate.
/// Encoded as `UBFM Xd, Xn, #(-shift mod 64), #(63-shift)`.
pub(crate) fn enc_lsl_imm(rd: Reg, rn: Reg, shift: u8) -> u32 {
    debug_assert!(shift < 64, "lsl imm: {shift} >= 64");
    let immr = ((64 - shift as u32) & 63) << 16;
    let imms = ((63 - shift as u32) & 63) << 10;
    0xD340_0000 | immr | imms | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `LSR <Xd>, <Xn>, #shift` -- logical shift right by immediate.
/// Encoded as `UBFM Xd, Xn, #shift, #63`.
pub(crate) fn enc_lsr_imm(rd: Reg, rn: Reg, shift: u8) -> u32 {
    debug_assert!(shift < 64, "lsr imm: {shift} >= 64");
    let immr = ((shift as u32) & 63) << 16;
    0xD340_FC00 | immr | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `ASR <Xd>, <Xn>, #shift` -- arithmetic shift right by immediate.
/// Encoded as `SBFM Xd, Xn, #shift, #63`.
pub(crate) fn enc_asr_imm(rd: Reg, rn: Reg, shift: u8) -> u32 {
    debug_assert!(shift < 64, "asr imm: {shift} >= 64");
    let immr = ((shift as u32) & 63) << 16;
    0x9340_FC00 | immr | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `REV <Xd>, <Xn>` -- reverse the 8 bytes.
pub(crate) fn enc_rev64(rd: Reg, rn: Reg) -> u32 {
    0xDAC0_0C00 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `REV <Wd>, <Wn>` -- reverse the low 4 bytes; the 32-bit write
/// zero-extends into `Xd`.
pub(crate) fn enc_rev32(rd: Reg, rn: Reg) -> u32 {
    0x5AC0_0800 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `LSR <Wd>, <Wn>, #shift` -- 32-bit logical shift right by
/// immediate. Encoded as `UBFM Wd, Wn, #shift, #31`; the 32-bit
/// write zero-extends into `Xd`.
pub(crate) fn enc_lsr32_imm(rd: Reg, rn: Reg, shift: u8) -> u32 {
    debug_assert!(shift < 32, "lsr32 imm: {shift} >= 32");
    let immr = ((shift as u32) & 31) << 16;
    0x5300_7C00 | immr | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SXTW <Xd>, <Wn>` -- sign-extend low 32 bits of `Wn` into `Xd`.
/// Alias of `SBFM Xd, Xn, #0, #31`. Used by the sxtw peephole that
/// folds c5's `Shl 32; Shr 32` sign-narrow shape into one inst.
pub(crate) fn enc_sxtw(rd: Reg, rn: Reg) -> u32 {
    // sf=1, opc=00 (SBFM), immr=0, imms=31, Rn, Rd.
    0x9340_7C00 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SXTH <Xd>, <Wn>` -- sign-extend low 16 bits of `Wn` into `Xd`.
/// Alias of `SBFM Xd, Xn, #0, #15`. Companion to `enc_sxtw` for the
/// short-narrow shape (`Shl 48; Shr 48`).
pub(crate) fn enc_sxth(rd: Reg, rn: Reg) -> u32 {
    0x9340_3C00 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SXTB <Xd>, <Wn>` -- sign-extend low 8 bits of `Wn` into `Xd`.
/// Alias of `SBFM Xd, Xn, #0, #7`. Companion to `enc_sxtw` for the
/// char-narrow shape (`Shl 56; Shr 56`).
pub(crate) fn enc_sxtb(rd: Reg, rn: Reg) -> u32 {
    0x9340_1C00 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

// ---- Pre-/post-indexed loads & stores. The c5 VM stack push/pop
//      compiles to these because they update sp in the same instruction.

/// `STR <Xt>, [<Xn|SP>, #imm]!` -- pre-indexed store with writeback.
/// Use with `imm = -16` for the accumulator push: store
/// accumulator and bump sp down by 16 bytes (the VM stack stays
/// 16-byte aligned even for 8-byte pushes so calls into libc
/// satisfy AAPCS64).
pub(crate) fn enc_str_pre(rt: Reg, rn: Reg, imm: i32) -> u32 {
    assert!(
        (-256..256).contains(&imm),
        "str-pre imm: {imm} out of range"
    );
    let imm9 = (imm as u32) & 0x1FF;
    0xF800_0C00 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDR <Xt>, [<Xn|SP>], #imm` -- post-indexed load with writeback.
/// Mirror for VM pop.
pub(crate) fn enc_ldr_post(rt: Reg, rn: Reg, imm: i32) -> u32 {
    assert!(
        (-256..256).contains(&imm),
        "ldr-post imm: {imm} out of range"
    );
    let imm9 = (imm as u32) & 0x1FF;
    0xF840_0400 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STR <Wt>, [<Xn|SP>], #imm` / `STRH` / `STRB` -- post-indexed store of `width` 4, 2 or 1.
pub(crate) fn enc_str_w_post(width: u8, rt: Reg, rn: Reg, imm: i32) -> u32 {
    assert!(
        (-256..256).contains(&imm),
        "str-post imm: {imm} out of range"
    );
    let size = match width {
        4 => 0b10,
        2 => 0b01,
        _ => 0b00,
    };
    let imm9 = (imm as u32) & 0x1FF;
    0x3800_0400 | (size << 30) | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
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
pub(crate) fn enc_adrp(rd: Reg, imm21: i32) -> u32 {
    debug_assert!(
        (-(1 << 20)..(1 << 20)).contains(&imm21),
        "adrp: page offset {imm21} out of signed 21-bit range"
    );
    let v = (imm21 as u32) & 0x1F_FFFF;
    let immlo = v & 0x3;
    let immhi = (v >> 2) & 0x7_FFFF;
    0x9000_0000 | (immlo << 29) | (immhi << 5) | (rd.0 as u32)
}

/// Lanes of `value` that are not zero, at least one.
fn nonzero_lanes(value: u64) -> u32 {
    (0..4)
        .filter(|i| (value >> (i * 16)) & 0xFFFF != 0)
        .count()
        .max(1) as u32
}

/// [`load_imm64`]'s form for `value` and its instruction count: `None` for one
/// `orr` from the zero register, else lanes opened by `movz` or (`true`) `movn`.
fn imm64_plan(value: u64) -> (Option<bool>, u32) {
    let (zeros, ones) = (nonzero_lanes(value), nonzero_lanes(!value));
    if zeros.min(ones) > 1 && encode_logical_imm(value, true).is_some() {
        return (None, 1);
    }
    (Some(ones < zeros), zeros.min(ones))
}

/// Instruction count [`load_imm64`] issues for `value`.
pub(crate) fn imm64_insts(value: u64) -> u32 {
    imm64_plan(value).1
}

/// Build an arbitrary 64-bit immediate into `rd` in the fewest instructions
/// of the `movz` / `movn` + `movk` sequences and the `orr` bitmask form.
pub(crate) fn load_imm64(code: &mut Vec<u8>, rd: Reg, value: u64) {
    let (Some(invert), _) = imm64_plan(value) else {
        let word = enc_logical_imm(LogicalOp::Orr, true, rd, Reg(31), value);
        emit(code, word.expect("a bitmask immediate"));
        return;
    };
    let (fill, all_fill) = if invert {
        (0xFFFF, value == u64::MAX)
    } else {
        (0, value == 0)
    };
    let mut first = true;
    for hw in 0..4u8 {
        let lane = (value >> (16 * hw as u32)) as u16;
        if lane == fill && !(all_fill && hw == 0) {
            continue;
        }
        emit(
            code,
            match (first, invert) {
                (false, _) => enc_movk(rd, lane, hw),
                (true, false) => enc_movz(rd, lane, hw),
                (true, true) => enc_movn(rd, !lane, hw),
            },
        );
        first = false;
    }
}

/// Append a 32-bit instruction to a code buffer in little-endian
/// byte order. Every encoder in this module funnels through here so
/// the byte order can't get accidentally inverted.
pub(crate) fn emit(code: &mut Vec<u8>, word: u32) {
    code.extend_from_slice(&word.to_le_bytes());
}

/// Emit `mov <rd>, <rn>` -- but skip the encoding entirely when
/// `rd == rn`, since the move would be a no-op. The lowering pass
/// goes through this helper rather than calling
/// `emit(code, enc_mov_reg(rd, rn))` directly so any case where the
/// destination and source happen to coincide (e.g. a future change
/// that lets the regalloc pool overlap with the accumulator) collapses
/// to zero bytes instead of a wasted instruction.
pub(crate) fn emit_mov_reg(code: &mut Vec<u8>, rd: Reg, rn: Reg) {
    if rd == rn {
        return;
    }
    emit(code, enc_mov_reg(rd, rn));
}

// ---- Branch fixups. Bytecode branches target absolute ent_pcs;
//      the native PC of those targets isn't known until after the
//      whole function body is laid out. Two-pass approach: emit a
//      placeholder branch instruction, record (its native offset, the
//      target ent_pc, the kind), then patch the placeholder
//      after lowering completes.

#[derive(Debug, Clone, Copy)]
pub(crate) enum BranchKind {
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
pub(crate) struct Fixup {
    /// Byte offset within `code` where the placeholder branch lives.
    pub(crate) native_offset: usize,
    /// Bytecode PC the branch is supposed to land on.
    pub(crate) target_ent_pc: usize,
    pub(crate) kind: BranchKind,
}

/// The AArch64 half of the lowering shell: the tables this target derives
/// from the unit, the output only it produces, and the encodings behind
/// [`super::ssa::emit_common::LowerTarget`].
struct Aarch64Lower {
    fixups: Vec<Fixup>,
    macho_tlv_fixups: Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: Vec<super::MachoTlvDescriptor>,
    /// Internal-linkage data object name -> unified data offset, so a
    /// function-body inline-asm symbol operand naming a static resolves to
    /// its storage; an external-linkage name stays symbolic and keeps its
    /// own symbol's binding. First record wins, matching the writer's
    /// local-symbol dedup for a block-scope static sharing a file-scope
    /// name.
    data_sym_offsets: alloc::collections::BTreeMap<alloc::string::String, i64>,
    /// The mapping state spans the section: a body ending in data leaves the
    /// padding to the next function's first instruction, as under GNU as.
    text_map_state: Option<super::map_syms::MapClass>,
}

impl Aarch64Lower {
    fn new(program: &Program) -> Self {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
        let mut data_sym_offsets = alloc::collections::BTreeMap::new();
        for s in program.symbols.iter().filter(|s| {
            s.class == Token::Glo as i64
                && s.defined_here
                && !s.is_thread_local
                && !s.is_alias
                && !s.name.is_empty()
                && s.linkage == Linkage::Internal
        }) {
            data_sym_offsets
                .entry(alloc::string::String::from(s.link_name()))
                .or_insert(s.val);
        }
        Self {
            fixups: Vec::new(),
            macho_tlv_fixups: Vec::new(),
            macho_tlv_descriptors: Vec::new(),
            data_sym_offsets,
            text_map_state: None,
        }
    }
}

impl super::ssa::emit_common::LowerTarget for Aarch64Lower {
    type Fixup = Fixup;

    const ARCH: &'static str = "aarch64";
    const ERR_TAG: &'static str = "";
    const WALK_PASS: &'static str = "ssa_emit_aarch64 (block walk)";
    // `.align` takes a power-of-two exponent on aarch64.
    const FILE_ASM_ALIGN_POW2: bool = true;
    const FILE_ASM_COMMENTS: crate::c5::asm::AsmComments = crate::c5::asm::AsmComments::A64;

    /// Take a word index's widening into its access, then contract an
    /// integer multiply into the add / sub that reads it (madd / msub).
    /// After the index fold and the store forwarding, whose address
    /// matching reads the `base + index * scale` shape a fused node would
    /// hide, and after the divide pairing, which is what leaves `n - q*d`
    /// behind.
    fn late_opt_passes(&mut self, funcs: &mut Vec<crate::c5::ir::FunctionSsa>) {
        super::ssa::emit_common::time_pass_arch("passes::index_ext::run", Self::ARCH, || {
            crate::c5::codegen::passes::index_ext::run(funcs);
        });
        super::ssa::emit_common::time_pass_arch("passes::mul_add::run", Self::ARCH, || {
            crate::c5::codegen::passes::mul_add::run(funcs);
        });
    }

    fn note_callees(&mut self, _funcs: &[crate::c5::ir::FunctionSsa]) {}

    fn note_extern_callee(&mut self, _sym: &crate::c5::symbol::Symbol) {}

    #[cfg(feature = "std")]
    fn dump_unit(
        &self,
        program: &Program,
        funcs: &[crate::c5::ir::FunctionSsa],
        allocs: &[super::ssa::reg_alloc::Allocation],
        out: &mut alloc::string::String,
    ) {
        use core::fmt::Write;
        let name_by_ent: alloc::collections::BTreeMap<usize, &str> = program
            .finished_functions
            .iter()
            .map(|ff| (ff.ent_pc, ff.name.as_str()))
            .collect();
        for (f, a) in funcs.iter().zip(allocs.iter()) {
            if let Some(name) = name_by_ent.get(&f.ent_pc) {
                let _ = writeln!(out, "; name={name}");
            }
            let _ = write!(out, "{}", super::ssa::dump::dump_function(f, a));
        }
    }

    fn align_entry(&mut self, st: &mut super::ssa::emit_common::LowerState, fn_align: usize) {
        // A preceding body's inline-asm data may leave the stream off
        // instruction alignment; the function's first byte pays it.
        super::emit::a64_align_asm_stream(
            &mut st.code,
            &mut st.text_data_ranges,
            &mut self.text_map_state,
        );
        super::pad_to_alignment(&mut st.code, fn_align, &NOP.to_le_bytes());
    }

    fn entry_nops(&mut self, code: &mut Vec<u8>, n: u32) {
        for _ in 0..n {
            code.extend_from_slice(&NOP.to_le_bytes());
        }
    }

    fn emit_function(
        &mut self,
        fe: super::ssa::emit_common::FunctionEmit<'_>,
        inputs: &super::ssa::emit_common::FunctionInputs<'_>,
        func: &crate::c5::ir::FunctionSsa,
        alloc_for: &super::ssa::reg_alloc::Allocation,
        target: Target,
        native: &NativeOptions,
        imports: &super::ResolvedImports,
        entry: super::FunctionEntry,
    ) -> super::ssa::emit_common::Emit {
        let mut cx = fe.cx;
        super::emit::emit_function(
            func,
            alloc_for,
            target,
            &mut cx,
            &mut self.fixups,
            inputs.extern_data_names,
            inputs.extern_tls_names,
            crate::c5::layout::tls_image_align(inputs.program.tls_align),
            imports,
            inputs.variadic_targets,
            &mut self.macho_tlv_fixups,
            &mut self.macho_tlv_descriptors,
            inputs.name2entpc,
            &self.data_sym_offsets,
            fe.asm_text_labels,
            fe.asm_section_text_refs,
            &mut self.text_map_state,
            native.no_fp_regs,
            native.strict_align,
            fe.rodata,
            native.output_kind == super::OutputKind::Relocatable && !native.pic,
            native.hardening,
            native.stack_protect.resolved_for(target),
            entry,
            native.fixed_regs,
            native.optimize,
        )
    }

    fn after_functions(
        &mut self,
        _st: &mut super::ssa::emit_common::LowerState,
        _native: &NativeOptions,
    ) {
    }

    fn take_fixups(&mut self) -> Vec<Fixup> {
        core::mem::take(&mut self.fixups)
    }

    fn fixup_native_offset(f: &Fixup) -> usize {
        f.native_offset
    }

    fn fixup_target_ent_pc(f: &Fixup) -> usize {
        f.target_ent_pc
    }

    fn fixup_is_tail(f: &Fixup) -> bool {
        matches!(f.kind, BranchKind::B)
    }

    fn apply_fixups(
        code: &mut [u8],
        fixups: &[Fixup],
        pc_to_native: &[usize],
        pc_extent: usize,
    ) -> Result<(), C5Error> {
        apply_fixups(code, fixups, pc_to_native, pc_extent)
    }

    fn emit_plt_trampolines(
        code: &mut Vec<u8>,
        got_fixups: &mut Vec<GotFixup>,
        n_imports: usize,
    ) -> Vec<usize> {
        emit_plt_trampolines(code, got_fixups, n_imports)
    }

    fn apply_plt_call_fixups(
        code: &mut [u8],
        fixups: &[PltCallFixup],
        trampoline_offsets: &[usize],
    ) -> Result<(), C5Error> {
        apply_plt_call_fixups(code, fixups, trampoline_offsets)
    }

    fn entry_native_offset(pc_to_native: &[usize], entry_pc: usize) -> Result<usize, C5Error> {
        pc_to_native.get(entry_pc).copied().ok_or_else(|| {
            C5Error::internal(format!(
                "native codegen: entry_pc {entry_pc} is out of PC range"
            ))
        })
    }

    fn cfi_target(_native: &NativeOptions) -> super::ssa::cfi::CfiTarget {
        super::ssa::cfi::CfiTarget {
            arch: super::ssa::cfi::CfiArch::Aarch64,
            addr_bytes: 8,
        }
    }

    fn install(&mut self, build: &mut Build) {
        build.macho_tlv_fixups = core::mem::take(&mut self.macho_tlv_fixups);
        build.macho_tlv_descriptors = core::mem::take(&mut self.macho_tlv_descriptors);
    }
}

/// Lower a [`Program`]'s SSA functions to AArch64 machine code.
/// Walks every Inst once, emitting native code; control-flow
/// terminators emit a placeholder branch and record a fixup to be
/// patched after the whole layout is known.
pub(crate) fn lower(
    program: &Program,
    target: Target,
    native: NativeOptions,
    imports: &super::ResolvedImports,
    prebuilt: Option<super::ssa::shadow::PrebuiltSsa>,
    mode: super::LowerMode,
) -> Result<Build, C5Error> {
    let mut backend = Aarch64Lower::new(program);
    super::ssa::emit_common::lower_unit(
        &mut backend,
        program,
        target,
        native,
        imports,
        prebuilt,
        mode,
    )
}

/// Walk through the patch list, computing the actual native offset
/// of each branch's target and writing the encoded instruction back
/// into `code` over the placeholder we left.
fn apply_fixups(
    code: &mut [u8],
    fixups: &[Fixup],
    pc_to_native: &[usize],
    pc_extent: usize,
) -> Result<(), C5Error> {
    for f in fixups {
        if f.target_ent_pc > pc_extent {
            return Err(C5Error::internal(format!(
                "native codegen: branch target {} past end of PC space",
                f.target_ent_pc
            )));
        }
        let target = pc_to_native[f.target_ent_pc];
        if target == usize::MAX {
            return Err(C5Error::internal(format!(
                "native codegen: branch target {} did not land on an instruction",
                f.target_ent_pc
            )));
        }
        let pc_after = f.native_offset as isize;
        let delta_bytes = target as isize - pc_after;
        // All AArch64 branches measure the offset in instructions
        // (4 bytes each).
        if delta_bytes & 3 != 0 {
            return Err(C5Error::internal(format!(
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
pub(crate) use super::PltCallFixup;

/// Tail-jump variant of [`emit_got_call`]: emits a 4-byte
/// `B <plt_trampoline>` placeholder. libc's `RET` returns
/// directly to the c5 caller of the trampoline, skipping
/// both this `B` and the trampoline entirely on the way back.
/// Used by the `Terminator::TailExt` lowering.
pub(crate) fn emit_got_tail_jump(
    code: &mut Vec<u8>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    import_index: usize,
) {
    plt_call_fixups.push(PltCallFixup {
        instr_offset: code.len(),
        import_index,
        is_tail: true,
        is_addr: false,
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
            instr_offset: tramp_off,
            part: AddrPart::Whole,
            import_index,
            is_data_load: false,
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
        if fx.is_addr {
            // Address-of sites (`adrp + add` taking the import's
            // address) resolve through a `FuncFixup` to the
            // trampoline offset in the local-image path; the writer's
            // func-fixup pass patches the page-relative pair.
            continue;
        }
        let tramp_off = *trampoline_offsets.get(fx.import_index).ok_or_else(|| {
            C5Error::internal(format!(
                "PLT call fixup at offset {} references import {} but only \
                 {} trampolines were emitted",
                fx.instr_offset,
                fx.import_index,
                trampoline_offsets.len()
            ))
        })?;
        let delta_bytes = tramp_off as i64 - fx.instr_offset as i64;
        if delta_bytes % 4 != 0 {
            return Err(C5Error::internal(format!(
                "PLT call fixup: trampoline byte delta {delta_bytes} not 4-byte aligned"
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

/// jmp_buf field offsets for the AArch64 setjmp / longjmp
/// intrinsics. Lays out 10 callee-saved x-regs, FP (x29), the
/// resume PC, SP, and 8 callee-saved d-regs. Total 168 bytes;
/// the `<setjmp.h>` typedef reserves 256 to leave slack for
/// future additions.
pub(crate) const JB_X19_OFF: u32 = 0;
pub(crate) const JB_X29_OFF: u32 = 80;
pub(crate) const JB_PC_OFF: u32 = 88;
pub(crate) const JB_SP_OFF: u32 = 96;
pub(crate) const JB_D8_OFF: u32 = 104;
/// Total instruction count emitted by `emit_setjmp_aarch64` --
/// every entry is one 4-byte AArch64 word. Used to compute the
/// PC-relative offset the ADR captures so a matching longjmp
/// branches to exactly the byte after the inline expansion.
/// Layout: 1 mov + 10 str(x19-x28) + 1 str(x29) + 1 adr + 1
/// str(pc) + 1 add(sp) + 1 str(sp) + 8 str(d8-d15) + 1 movz =
/// 25 instructions; ADR sits at zero-based index 12.
pub(crate) const SETJMP_AARCH64_INSN_COUNT: i32 = 25;
pub(crate) const SETJMP_AARCH64_ADR_INSN_INDEX: i32 = 12;

/// AArch64 setjmp inlined at the call site. The `env` pointer
/// arrives in `x19`. On the initial call this
/// writes the resume context into `[env]` and sets `x19 = 0`; on
/// a matching longjmp control jumps to the address right after
/// the inline expansion with `x19` carrying the longjmp value.
///
/// CRT-independent so it works on Windows AArch64, whose msvcrt
/// `longjmp` routes through SEH and refuses an SEH-free
/// `jmp_buf`. The Linux / macOS bindings continue to use the
/// host libc setjmp -- that's already CRT-independent.
pub(crate) fn emit_setjmp_aarch64(code: &mut Vec<u8>) {
    let start = code.len();
    emit(code, enc_mov_reg(Reg::X16, Reg::X19));
    for (i, off) in (JB_X19_OFF..JB_X29_OFF).step_by(8).enumerate() {
        emit(code, enc_str_imm(Reg(19 + i as u8), Reg::X16, off));
    }
    emit(code, enc_str_imm(Reg::X29, Reg::X16, JB_X29_OFF));
    let adr_off_bytes = (SETJMP_AARCH64_INSN_COUNT - SETJMP_AARCH64_ADR_INSN_INDEX) * 4;
    debug_assert_eq!(
        code.len() - start,
        (SETJMP_AARCH64_ADR_INSN_INDEX as usize) * 4,
        "setjmp ADR offset out of sync with instruction count"
    );
    emit(code, enc_adr(Reg::X17, adr_off_bytes));
    emit(code, enc_str_imm(Reg::X17, Reg::X16, JB_PC_OFF));
    emit(code, enc_add_imm(Reg::X17, Reg::SP, 0));
    emit(code, enc_str_imm(Reg::X17, Reg::X16, JB_SP_OFF));
    for (i, off) in (JB_D8_OFF..JB_D8_OFF + 64).step_by(8).enumerate() {
        emit(code, enc_str_d_imm(8 + i as u8, Reg::X16, off));
    }
    emit(code, enc_movz(Reg::X19, 0, 0));
    debug_assert_eq!(
        code.len() - start,
        (SETJMP_AARCH64_INSN_COUNT as usize) * 4,
        "setjmp instruction count drift"
    );
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
    fn tbz_and_tbnz_forms() {
        // tbz w4, #0, .+8; tbnz w4, #0, .+8; tbz x3, #40, .-4;
        // tbnz x0, #63, .+32764; tbz w30, #31, .-32768
        assert_eq!(enc_tbz(Reg(4), 0, 2), 0x3600_0044);
        assert_eq!(enc_tbnz(Reg(4), 0, 2), 0x3700_0044);
        assert_eq!(enc_tbz(Reg(3), 40, -1), 0xB647_FFE3);
        assert_eq!(enc_tbnz(Reg::X0, 63, 8191), 0xB7FB_FFE0);
        assert_eq!(enc_tbz(Reg(30), 31, -8192), 0x36FC_001E);
    }

    #[test]
    fn movz_x0_42() {
        // movz x0, #42  ->  0xD2800540
        assert_eq!(enc_movz(Reg::X0, 42, 0), 0xD280_0540);
    }

    #[test]
    fn fp_immediate_forms() {
        // fmov d0, #1.0; fmov s0, #1.0; fmov d17, #-2.5; movi d3, #0
        assert_eq!(enc_fmov_imm(0, 0x70, false), 0x1E6E_1000);
        assert_eq!(enc_fmov_imm(0, 0x70, true), 0x1E2E_1000);
        assert_eq!(enc_fmov_imm(17, 0x84, false), 0x1E70_9011);
        assert_eq!(enc_movi_d_zero(3), 0x2F00_E403);
    }

    /// The immediate is found by pattern, so a float's pattern read as a
    /// double's, or the reverse, has none; neither zero has one.
    #[test]
    fn fp_imm8_matches_the_pattern_of_its_own_precision() {
        assert_eq!(fp_imm8(1.0f64.to_bits(), false), Some(0x70));
        assert_eq!(fp_imm8(u64::from(1.0f32.to_bits()), true), Some(0x70));
        assert_eq!(fp_imm8(u64::from(1.0f32.to_bits()), false), None);
        assert_eq!(fp_imm8(1.0f64.to_bits() & 0xFFFF_FFFF, true), None);
        assert_eq!(fp_imm8((-2.5f64).to_bits(), false), Some(0x84));
        for single in [false, true] {
            assert_eq!(fp_imm8(0, single), None);
            let neg_zero = if single { 1 << 31 } else { 1 << 63 };
            assert_eq!(fp_imm8(neg_zero, single), None);
        }
        assert_eq!(fp_imm8(0.001f64.to_bits(), false), None);
        assert_eq!(fp_imm8(u64::from(0.1f32.to_bits()), true), None);
        for imm8 in 0..=u8::MAX {
            let d = f64::from_bits(vfp_expand_imm(imm8, false));
            let s = f32::from_bits(vfp_expand_imm(imm8, true) as u32);
            assert_eq!(d, f64::from(s), "imm8 {imm8:#x}");
        }
    }

    #[test]
    fn rev_and_lsr32_forms() {
        // rev x0, x1 -> 0xDAC00C20; rev w2, w3 -> 0x5AC00862;
        // lsr w0, w0, #16 -> 0x53107C00
        assert_eq!(enc_rev64(Reg::X0, Reg(1)), 0xDAC0_0C20);
        assert_eq!(enc_rev32(Reg(2), Reg(3)), 0x5AC0_0862);
        assert_eq!(enc_lsr32_imm(Reg::X0, Reg::X0, 16), 0x5310_7C00);
    }

    #[test]
    fn bit_count_forms() {
        // The words `clang --target=aarch64-linux-gnu` assembles.
        assert_eq!(enc_clz32(Reg(1), Reg(2)), 0x5AC0_1041);
        assert_eq!(enc_clz(Reg(1), Reg(2)), 0xDAC0_1041);
        assert_eq!(enc_rbit32(Reg(1), Reg(2)), 0x5AC0_0041);
        assert_eq!(enc_rbit64(Reg(1), Reg(2)), 0xDAC0_0041);
        assert_eq!(enc_cnt_8b(16, 17), 0x0E20_5A30);
        assert_eq!(enc_addv_8b(16, 17), 0x0E31_BA30);
        assert_eq!(enc_fmov_s_to_w(Reg(1), 16), 0x1E26_0201);
        assert_eq!(enc_fmov_w_to_s(16, Reg(1)), 0x1E27_0030);
        let (r1, r2, r3) = (Reg(1), Reg(2), Reg(3));
        assert_eq!(enc_addsub_lsr(false, r1, r2, r3, 4, true), 0x8B43_1041);
        assert_eq!(enc_addsub_lsr(false, r1, r2, r3, 4, false), 0x0B43_1041);
        assert_eq!(enc_addsub_lsr(true, r1, r2, r3, 1, true), 0xCB43_0441);
        assert_eq!(enc_addsub_lsr(true, r1, r2, r3, 1, false), 0x4B43_0441);
        assert_eq!(enc_mul32(r1, r2, r3), 0x1B03_7C41);
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
    fn ins_vector_element_from_gpr() {
        // ins v0.b[0], w17 / v0.b[1], w17 / v3.b[7], w16
        assert_eq!(enc_ins_gen(0, 1, 0, Reg(17)), 0x4E01_1E20);
        assert_eq!(enc_ins_gen(0, 1, 1, Reg(17)), 0x4E03_1E20);
        assert_eq!(enc_ins_gen(3, 1, 7, Reg(16)), 0x4E0F_1E03);
        // ins v1.h[1], w17 / v2.s[1], w17 / v5.d[1], x9
        assert_eq!(enc_ins_gen(1, 2, 1, Reg(17)), 0x4E06_1E21);
        assert_eq!(enc_ins_gen(2, 4, 1, Reg(17)), 0x4E0C_1E22);
        assert_eq!(enc_ins_gen(5, 8, 1, Reg(9)), 0x4E18_1D25);
    }

    #[test]
    fn umov_gpr_from_vector_element() {
        // umov w1, v0.b[15] / w5, v7.h[3] / w3, v2.s[2] / x0, v1.d[1]
        assert_eq!(enc_umov_gen(Reg(1), 0, 1, 15), 0x0E1F_3C01);
        assert_eq!(enc_umov_gen(Reg(5), 7, 2, 3), 0x0E0E_3CE5);
        assert_eq!(enc_umov_gen(Reg(3), 2, 4, 2), 0x0E14_3C43);
        assert_eq!(enc_umov_gen(Reg(0), 1, 8, 1), 0x4E18_3C20);
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
        assert_eq!(
            enc_ldr_reg_lsl3(Reg::X16, Reg::X16, Reg::X17, IndexExt::None),
            0xF871_7A10
        );
    }

    /// The unscaled register-offset byte forms (`S = 0`) of the scale-1
    /// indexed accesses. Verified against clang.
    #[test]
    fn byte_register_offset_forms() {
        let lsl = IndexExt::None;
        assert_eq!(enc_ldrb_reg(r(0), r(1), r(2), lsl), 0x3862_6820);
        assert_eq!(enc_ldrsb_reg(r(0), r(1), r(2), lsl), 0x38A2_6820);
        assert_eq!(enc_strb_reg(r(0), r(1), r(2), lsl), 0x3822_6820);
        assert_eq!(enc_ldrb_reg(r(30), r(29), r(17), lsl), 0x3871_6BBE);
        assert_eq!(enc_ldrsb_reg(r(9), r(16), r(28), lsl), 0x38BC_6A09);
        assert_eq!(enc_strb_reg(r(21), r(3), r(15), lsl), 0x382F_6875);
    }

    /// The register-offset forms over a word index, every access size with
    /// and without the scaling shift, and the extended-register add of the
    /// spilled-operand store. Verified against clang.
    #[test]
    fn word_index_forms() {
        use IndexExt::{Sxtw, Uxtw};
        assert_eq!(enc_ldr_reg_lsl3(r(0), r(1), r(2), Sxtw), 0xF862_D820);
        assert_eq!(enc_ldr_reg_lsl3(r(0), r(1), r(2), Uxtw), 0xF862_5820);
        assert_eq!(enc_ldrsw_reg_lsl2(r(3), r(4), r(5), Sxtw), 0xB8A5_D883);
        assert_eq!(enc_ldr32_reg_lsl2(r(3), r(4), r(5), Uxtw), 0xB865_5883);
        assert_eq!(enc_ldrsh_reg_lsl1(r(6), r(7), r(8), Sxtw), 0x78A8_D8E6);
        assert_eq!(enc_ldrh_reg_lsl1(r(6), r(7), r(8), Uxtw), 0x7868_58E6);
        assert_eq!(enc_ldrsb_reg(r(9), r(10), r(11), Sxtw), 0x38AB_C949);
        assert_eq!(enc_ldrb_reg(r(9), r(10), r(11), Uxtw), 0x386B_4949);
        assert_eq!(enc_str_reg_lsl3(r(12), r(13), r(14), Sxtw), 0xF82E_D9AC);
        assert_eq!(enc_str32_reg_lsl2(r(15), r(16), r(17), Uxtw), 0xB831_5A0F);
        assert_eq!(enc_strh_reg_lsl1(r(18), r(19), r(20), Sxtw), 0x7834_DA72);
        assert_eq!(enc_strb_reg(r(21), r(22), r(23), Uxtw), 0x3837_4AD5);
        assert_eq!(enc_strb_reg(r(21), r(22), r(23), Sxtw), 0x3837_CAD5);
        assert_eq!(enc_add_index(r(16), r(16), r(17), Sxtw, 3), 0x8B31_CE10);
        assert_eq!(enc_add_index(r(16), r(1), r(2), Uxtw, 2), 0x8B22_4830);
        assert_eq!(enc_add_index(r(16), r(16), r(17), Sxtw, 0), 0x8B31_C210);
        assert_eq!(enc_add_index(r(0), r(29), r(30), Uxtw, 1), 0x8B3E_47A0);
        // A full-width index keeps the shifted-register add.
        assert_eq!(
            enc_add_index(r(16), r(16), r(17), IndexExt::None, 3),
            enc_add_reg_lsl(r(16), r(16), r(17), 3)
        );
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
        assert_eq!(enc_smulh(r(0), r(1), r(2)), 0x9B42_7C20);
        assert_eq!(enc_umulh(r(0), r(1), r(2)), 0x9BC2_7C20);
        assert_eq!(enc_msub(r(0), r(1), r(2), r(3)), 0x9B02_8C20);
        assert_eq!(enc_madd(r(0), r(1), r(2), r(3)), 0x9B02_0C20);
        assert_eq!(enc_lslv(r(0), r(1), r(2)), 0x9AC2_2020);
        assert_eq!(enc_asrv(r(0), r(1), r(2)), 0x9AC2_2820);
        assert_eq!(enc_lsrv(r(0), r(1), r(2)), 0x9AC2_2420);
    }

    #[test]
    fn extended_register_forms_accept_sp() {
        // sub sp, sp, x16 / add sp, sp, x16 / add x0, sp, x0
        assert_eq!(enc_sub_ext_reg(Reg::SP, Reg::SP, r(16)), 0xCB30_63FF);
        assert_eq!(enc_add_ext_reg(Reg::SP, Reg::SP, r(16)), 0x8B30_63FF);
        assert_eq!(enc_add_ext_reg(r(0), Reg::SP, r(0)), 0x8B20_63E0);
    }

    #[test]
    fn sp_restore_past_immediate_reach_uses_register_form() {
        // Tearing down a frame beyond the 24-bit immediate reach materialises
        // the byte count and applies it with the extended-register form rather
        // than truncating or refusing.
        let bytes = 20_000_016u32;
        assert!(!add_sub_imm24_in_range(bytes));
        let mut add = Vec::new();
        emit_add_sp_imm_scratch(&mut add, bytes, Reg(16));
        let mut want = Vec::new();
        load_imm64(&mut want, Reg(16), bytes as u64);
        emit(&mut want, enc_add_ext_reg(Reg::SP, Reg::SP, Reg(16)));
        assert_eq!(add, want);

        // In-reach counts keep the two-instruction immediate form.
        let mut small = Vec::new();
        emit_add_sp_imm_scratch(&mut small, 0x11180, Reg(16));
        let mut want_small = Vec::new();
        emit_add_sp_imm(&mut want_small, 0x11180);
        assert_eq!(small, want_small);
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
        for c in [
            Cond::Eq,
            Cond::Ne,
            Cond::Lt,
            Cond::Ge,
            Cond::Gt,
            Cond::Le,
            Cond::Mi,
            Cond::Pl,
        ] {
            assert_eq!(c.flip().flip(), c, "double flip should be identity");
            // The architectural inversion flips bit 0 of the encoding.
            assert_eq!(c.flip() as u32, (c as u32) ^ 1);
        }
        // Spot checks of the inversion semantics.
        assert_eq!(Cond::Eq.flip(), Cond::Ne);
        assert_eq!(Cond::Lt.flip(), Cond::Ge);
        assert_eq!(Cond::Gt.flip(), Cond::Le);
        assert_eq!(Cond::Mi.flip(), Cond::Pl);
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
    fn loads_stores_unscaled_simd() {
        // size 111100 opc 0 imm9 00 Rn Rt: D size 11 and S 10 with opc 01 / 00,
        // Q size 00 with opc 11 / 10.
        let ldur = |op: MemOp, rt: u8, rn: Reg, imm: i32| enc_mem(op, rt, rn, op.unscaled(imm));
        assert_eq!(ldur(LDR_D, 0, Reg::X29, -16), 0xFC5F_03A0);
        assert_eq!(ldur(STR_D, 0, Reg::X29, -16), 0xFC1F_03A0);
        assert_eq!(ldur(LDR_D, 17, r(2), 255), 0xFC4F_F051);
        assert_eq!(ldur(STR_D, 31, Reg::SP, -256), 0xFC10_03FF);
        assert_eq!(ldur(LDR_S, 0, Reg::X29, -4), 0xBC5F_C3A0);
        assert_eq!(ldur(STR_S, 0, Reg::X29, -4), 0xBC1F_C3A0);
        assert_eq!(ldur(LDR_S, 3, r(4), -256), 0xBC50_0083);
        assert_eq!(ldur(STR_S, 5, Reg::SP, 1), 0xBC00_13E5);
        assert_eq!(ldur(LDR_Q, 0, Reg::X29, -16), 0x3CDF_03A0);
        assert_eq!(ldur(STR_Q, 0, Reg::X29, -16), 0x3C9F_03A0);
        assert_eq!(ldur(LDR_Q, 6, Reg::X16, -1), 0x3CDF_F206);
        assert_eq!(ldur(STR_Q, 7, Reg::X17, 255), 0x3C8F_F227);
    }

    #[test]
    fn load_store_offset_takes_the_form_that_holds_it() {
        let at =
            |op: MemOp, rt: u8, rn: Reg, disp: i64| op.offset(disp).map(|o| enc_mem(op, rt, rn, o));
        assert_eq!(at(LDR_D, 2, r(3), 32760), Some(0xFD7F_FC62));
        assert_eq!(at(STR_S, 4, r(5), 16380), Some(0xBD3F_FCA4));
        assert_eq!(at(LDR_Q, 1, r(2), 16), Some(0x3DC0_0441));
        assert_eq!(at(STR_Q, 3, r(4), 65520), Some(0x3DBF_FC83));
        assert_eq!(at(LDRB, 1, r(0), 3), Some(0x3940_0C01));
        assert_eq!(at(LDR_X, 1, r(0), 3), Some(0xF840_3001));
        assert_eq!(at(LDR_X, 0, Reg::X29, -8), Some(0xF85F_83A0));
        assert_eq!(at(LDRB, 0, r(0), 8192), None);
        assert_eq!(at(LDRH, 0, r(0), 40000), None);
        assert_eq!(at(LDR_W, 0, r(0), 40004), None);
        assert_eq!(at(LDR_X, 0, r(0), 32768), None);
        assert_eq!(at(LDR_X, 0, r(0), 257), None);
        assert_eq!(at(STR_D, 0, Reg::X29, -257), None);
    }

    #[test]
    #[should_panic(expected = "outside the scaled 12-bit form")]
    fn scaled_form_refuses_an_offset_past_its_reach() {
        enc_ldrb_imm(r(0), r(0), 8192);
    }

    #[test]
    #[should_panic(expected = "outside the unscaled 9-bit form")]
    fn unscaled_form_refuses_an_offset_past_its_reach() {
        enc_stur(r(0), Reg::X29, -257);
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

    /// The value a load sequence leaves in `rd`; `None` for another word or register.
    fn run_loads(code: &[u8], rd: Reg) -> Option<u64> {
        let mut x = 0u64;
        for w in code
            .chunks(4)
            .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        {
            let (hw, imm) = (((w >> 21) & 3) * 16, u64::from((w >> 5) & 0xFFFF));
            if w & 0x1F != rd.0 as u32 {
                return None;
            }
            x = match w & 0xFF80_0000 {
                0xD280_0000 => imm << hw,
                0x9280_0000 => !(imm << hw),
                0xF280_0000 => (x & !(0xFFFF << hw)) | (imm << hw),
                _ if w & 0xFF80_03E0 == 0xB200_03E0 => {
                    decode_logical_imm((w >> 10) & 0x1FFF, true)?
                }
                _ => return None,
            };
        }
        Some(x)
    }

    #[test]
    fn load_imm64_takes_the_shortest_form() {
        let fills = [0u64, 0xFFFF, 0x1234, 0x8000];
        let mut values: Vec<u64> = (0..256u32)
            .map(|i| {
                (0..4).fold(0, |v, hw| {
                    v | fills[((i >> (2 * hw)) & 3) as usize] << (16 * hw)
                })
            })
            .collect();
        values.extend([
            0xF0F0_F0F0_F0F0_F0F0,
            0xFFFF_FFFF_FFFF_FFF0,
            0x7FFF_FFFF_FFFF_FFFF,
        ]);
        values.extend([
            0x0000_FFFF_FFFF_0000,
            0x5555_5555_5555_5555,
            0x0FF0_0000_0000_0000,
        ]);
        let mut seed = 0x9E37_79B9_7F4A_7C15u64;
        values.extend((0..512).map(|_| {
            seed = seed
                .wrapping_mul(6364136223846793005)
                .wrapping_add(1442695040888963407);
            seed
        }));
        for value in values {
            let mut code = Vec::new();
            load_imm64(&mut code, Reg(9), value);
            assert_eq!(run_loads(&code, Reg(9)), Some(value), "{value:#x}");
            let n = (code.len() / 4) as u32;
            assert_eq!(n, imm64_insts(value), "{value:#x}");
            let lanes = |v: u64| {
                (0..4)
                    .filter(|i| (v >> (i * 16)) & 0xFFFF != 0)
                    .count()
                    .max(1)
            };
            let bound = if encode_logical_imm(value, true).is_some() {
                1
            } else {
                4
            };
            assert_eq!(
                n as usize,
                lanes(value).min(lanes(!value)).min(bound),
                "{value:#x}"
            );
        }
        // One instruction prefers `movz`, then `movn`, then `orr`.
        let first = |value| {
            let mut code = Vec::new();
            load_imm64(&mut code, Reg(9), value);
            u32::from_le_bytes(code[..4].try_into().unwrap())
        };
        assert_eq!(first(0xFF00), enc_movz(Reg(9), 0xFF00, 0));
        assert_eq!(first(!0xF), enc_movn(Reg(9), 0xF, 0));
        assert_eq!(first(0xFF00_FF00_FF00_FF00) & 0xFF80_03FF, 0xB200_03E9);
        assert_eq!(first(u64::MAX), enc_movn(Reg(9), 0, 0));
    }

    #[test]
    fn fma_three_source_encodings() {
        // fmadd d0, d0, d1, d2  (a*b + c)
        assert_eq!(enc_fma(0, 0, 1, 2, false, false, false), 0x1F41_0800);
        // fnmsub d0, d0, d1, d2  (a*b - c)
        assert_eq!(enc_fma(0, 0, 1, 2, false, false, true), 0x1F61_8800);
        // fmsub d0, d0, d1, d2  (c - a*b)
        assert_eq!(enc_fma(0, 0, 1, 2, false, true, false), 0x1F41_8800);
        // fnmadd d0, d0, d1, d2  (-a*b - c)
        assert_eq!(enc_fma(0, 0, 1, 2, false, true, true), 0x1F61_0800);
        // Single-precision clears the type bit: fmadd s0, s0, s1, s2
        assert_eq!(enc_fma(0, 0, 1, 2, true, false, false), 0x1F01_0800);
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

    // The exclusive-monitor encodings below were cross-checked against
    // `clang -target aarch64-linux-gnu` + `objdump -d`:
    //   ldaxr x1,[x2]=c85ffc41  ldaxr w1,[x2]=885ffc41
    //   ldaxrh w1,[x2]=485ffc41 ldaxrb w1,[x2]=085ffc41
    //   stlxr w0,x1,[x2]=c800fc41  stlxr w0,w1,[x2]=8800fc41
    //   stlxrh w0,w1,[x2]=4800fc41 stlxrb w0,w1,[x2]=0800fc41

    #[test]
    fn ldaxr_all_widths() {
        assert_eq!(enc_ldaxr(Reg(1), Reg(2), 8), 0xC85F_FC41);
        assert_eq!(enc_ldaxr(Reg(1), Reg(2), 4), 0x885F_FC41);
        assert_eq!(enc_ldaxr(Reg(1), Reg(2), 2), 0x485F_FC41);
        assert_eq!(enc_ldaxr(Reg(1), Reg(2), 1), 0x085F_FC41);
    }

    #[test]
    fn stlxr_all_widths() {
        assert_eq!(enc_stlxr(Reg(0), Reg(1), Reg(2), 8), 0xC800_FC41);
        assert_eq!(enc_stlxr(Reg(0), Reg(1), Reg(2), 4), 0x8800_FC41);
        assert_eq!(enc_stlxr(Reg(0), Reg(1), Reg(2), 2), 0x4800_FC41);
        assert_eq!(enc_stlxr(Reg(0), Reg(1), Reg(2), 1), 0x0800_FC41);
    }

    // Cross-checked against `clang -c` + `otool -t` (aarch64):
    //   ldaxp x1,x2,[x3]=c87f8861  ldaxp x5,x6,[x7]=c87f98e5
    //   stlxp w0,x1,x2,[x3]=c8208861  stlxp w4,x5,x6,[x7]=c82498e5
    //   ccmp x11,x13,#0,eq=fa4d0160
    #[test]
    fn ldaxp_stlxp_ccmp() {
        assert_eq!(enc_ldaxp(Reg(1), Reg(2), Reg(3)), 0xC87F_8861);
        assert_eq!(enc_ldaxp(Reg(5), Reg(6), Reg(7)), 0xC87F_98E5);
        assert_eq!(enc_stlxp(Reg(0), Reg(1), Reg(2), Reg(3)), 0xC820_8861);
        assert_eq!(enc_stlxp(Reg(4), Reg(5), Reg(6), Reg(7)), 0xC824_98E5);
        assert_eq!(enc_ccmp(Reg(11), Reg(13), 0, Cond::Eq), 0xFA4D_0160);
    }

    // Cross-checked against `clang -c` + `otool -t` (aarch64). The plain
    // LDP / STP forms are the same fixed encodings [`enc_ldp_off`] /
    // [`enc_stp_off`] produce at a zero offset:
    //   ldxp x1,x2,[x3]=c87f0861  stxp w0,x1,x2,[x3]=c8200861
    //   ldp x1,x2,[x3]=a9400861   stp x1,x2,[x3]=a9000861
    #[test]
    fn ldxp_stxp_ldp_stp() {
        assert_eq!(enc_ldxp(Reg(1), Reg(2), Reg(3)), 0xC87F_0861);
        assert_eq!(enc_stxp(Reg(0), Reg(1), Reg(2), Reg(3)), 0xC820_0861);
        assert_eq!(enc_ldp_off(Reg(1), Reg(2), Reg(3), 0), 0xA940_0861);
        assert_eq!(enc_stp_off(Reg(1), Reg(2), Reg(3), 0), 0xA900_0861);
    }

    /// DecodeBitMasks over a logical-immediate field; `None` when reserved.
    fn decode_logical_imm(field: u32, is64: bool) -> Option<u64> {
        let (n, immr, imms) = (field >> 12, (field >> 6) & 0x3F, field & 0x3F);
        let top = (n << 6) | (!imms & 0x3F);
        if (!is64 && n != 0) || top < 2 {
            return None;
        }
        let len = 31 - top.leading_zeros();
        let levels = (1 << len) - 1;
        let (s, r, esize) = (imms & levels, immr & levels, 1u32 << len);
        if s == levels {
            return None;
        }
        let ones = (1u64 << (s + 1)) - 1;
        let elem = ((ones >> r) | (ones << ((esize - r) % esize))) & (u64::MAX >> (64 - esize));
        let width = if is64 { 64 } else { 32 };
        Some((0..width / esize).fold(0, |v, k| v | (elem << (k * esize))))
    }

    #[test]
    fn logical_immediates_round_trip() {
        // Every run, rotation and element size: 5334 64-bit and 1302 32-bit values.
        for (is64, width, count) in [(true, 64u32, 5334), (false, 32, 1302)] {
            let mut all = alloc::collections::BTreeSet::new();
            for esize in [2u32, 4, 8, 16, 32, 64].into_iter().filter(|&e| e <= width) {
                let emask = u64::MAX >> (64 - esize);
                for run in 1..esize {
                    let ones = (1u64 << run) - 1;
                    for rot in 0..esize {
                        let elem = ((ones << rot) | (ones >> ((esize - rot) % esize))) & emask;
                        let value = (0..width / esize).fold(0, |v, k| v | (elem << (k * esize)));
                        let field = encode_logical_imm(value, is64);
                        let back = field.and_then(|f| decode_logical_imm(f, is64));
                        assert_eq!(back, Some(value), "{value:#x}");
                        all.insert(value);
                    }
                }
            }
            assert_eq!(all.len(), count);
            // A replicated 16-bit element, zero and all ones included, encodes iff a run.
            for e in 0..=u64::from(u16::MAX) {
                let value = (0..width / 16).fold(0, |v, k| v | (e << (k * 16)));
                let taken = encode_logical_imm(value, is64).is_some();
                assert_eq!(taken, all.contains(&value), "{value:#x}");
            }
            for value in [
                0x1234_5678,
                0x8000_0002,
                0x0F0F_0F0E,
                0xFFFF_0000_FFFE,
                0x5555_5555_5555_5554,
                0x8000_0000_0000_0002,
            ] {
                assert_eq!(encode_logical_imm(value, is64), None, "{value:#x}");
            }
        }
        // The 32-bit form reads the low word under a zero or all-ones high word.
        let low = encode_logical_imm(0xFFFF_FFF0, false);
        assert!(low.is_some());
        assert_eq!(encode_logical_imm(0xFFFF_FFFF_FFFF_FFF0, false), low);
        assert_eq!(encode_logical_imm(0x1_0000_000F, false), None);
    }

    #[test]
    fn logical_immediate_words() {
        use super::super::table::{Opnd, encode};
        // and x0, x1, #0xff; orr w5, w6, #0x1; eor x2, x3, #1 << 63; and sp, x16, #-16.
        let and = enc_logical_imm(LogicalOp::And, true, Reg(0), Reg(1), 0xFF);
        assert_eq!(and, Some(0x9240_1C20));
        let orr = enc_logical_imm(LogicalOp::Orr, false, Reg(5), Reg(6), 1);
        assert_eq!(orr, Some(0x3200_00C5));
        let eor = enc_logical_imm(LogicalOp::Eor, true, Reg(2), Reg(3), 1 << 63);
        assert_eq!(eor, Some(0xD241_0062));
        assert_eq!(enc_and_align_down(Reg::SP, Reg(16), 4), 0x927C_EE1F);
        assert_eq!(
            enc_logical_imm(LogicalOp::And, true, Reg(0), Reg(1), 0x1234),
            None
        );
        // Each form packs the word the assembler catalogue does.
        let reg = |num, is64| Opnd::Reg {
            num,
            is64,
            sp: false,
        };
        let ops = [
            (LogicalOp::And, "and"),
            (LogicalOp::Orr, "orr"),
            (LogicalOp::Eor, "eor"),
        ];
        for (op, mnemonic) in ops {
            for (is64, value) in [
                (true, 0xFFu64),
                (true, 0xF0F0_F0F0_F0F0_F0F0),
                (false, 0x0F0F_0F0F),
                (false, 0x8000_0001),
            ] {
                let args = [reg(9, is64), reg(20, is64), Opnd::Imm(value as i64)];
                let want = encode(mnemonic, &args).ok();
                let got = enc_logical_imm(op, is64, Reg(9), Reg(20), value);
                assert_eq!(got, want, "{mnemonic} {value:#x}");
            }
        }
    }
}

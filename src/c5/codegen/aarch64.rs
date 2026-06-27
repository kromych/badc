//! AArch64 instruction encoder + per-function lowering shell.
//!
//! All AArch64 instructions are 32 bits wide and little-endian on every
//! supported OS, which makes the encoder a flat catalogue of
//! `fn enc_xxx(...) -> u32`. Per-function code generation routes
//! through [`super::ssa_shadow::produce_ssa_funcs`] +
//! [`super::ssa_alloc::allocate`] + `super::ssa_emit_aarch64`; this
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
use alloc::vec;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::program::Program;
use super::{Build, DataFixup, FuncFixup, GotFixup, NativeOptions, Target};

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

/// `STP <Xt1>, <Xt2>, [<Xn|SP>, #imm]` -- store-pair, signed offset
/// (no writeback). Same scaling / range as [`enc_stp_pre`].
pub(super) fn enc_stp_off(rt: Reg, rt2: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!(imm % 8 == 0, "stp: imm must be 8-byte aligned, got {imm}");
    let imm7 = imm / 8;
    debug_assert!(
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
pub(super) fn enc_ldp_off(rt: Reg, rt2: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!(imm % 8 == 0, "ldp: imm must be 8-byte aligned, got {imm}");
    let imm7 = imm / 8;
    debug_assert!(
        (-64..64).contains(&imm7),
        "ldp: offset {imm} (scaled {imm7}) out of range"
    );
    0xA940_0000
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
/// [`emit_sub_sp_imm`]. Used for stack-arg cleanup after a call
/// and by anything else that needs to grow the stack pointer
/// back by more than 4 KiB in one go.
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

/// 3-register data-processing word: `base | Rm<<16 | Rn<<5 | Rd`. Any baked
/// field (e.g. MUL's `Ra = XZR`) is part of `base`.
fn enc_rrr(base: u32, rd: Reg, rn: Reg, rm: Reg) -> u32 {
    base | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `ADD <Xd>, <Xn>, <Xm>` -- 64-bit register add, no shift.
pub(super) fn enc_add_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x8B00_0000, rd, rn, rm)
}

/// `ADD <Xd>, <Xn>, <Xm>, LSL #<shift>` -- 64-bit add of a left-shifted
/// register. `shift` is a 6-bit amount.
pub(super) fn enc_add_reg_lsl(rd: Reg, rn: Reg, rm: Reg, shift: u32) -> u32 {
    0x8B00_0000
        | ((rm.0 as u32) << 16)
        | ((shift & 0x3f) << 10)
        | ((rn.0 as u32) << 5)
        | (rd.0 as u32)
}

/// `SUB <Xd>, <Xn>, <Xm>` -- 64-bit register subtract.
pub(super) fn enc_sub_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0xCB00_0000, rd, rn, rm)
}

/// `AND <Xd>, <Xn>, <Xm>` -- bitwise and.
pub(super) fn enc_and_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x8A00_0000, rd, rn, rm)
}

/// `AND <Xd>, <Xn>, #~15` -- mask off the low four bits so the
/// result is a multiple of 16. Used by the alloca lowering to
/// round the requested size up to the platform's stack-alignment
/// before bumping the per-frame arena top. AArch64 logical-
/// immediate encoding for the 64-bit mask `0xFFFFFFFFFFFFFFF0`
/// (sixty ones over four low zeros): `sf=1`, `N=1`, `imms=59`
/// (sixty-bit run), `immr=60` -- the run is rotated right by 60 so
/// the four zero bits land at the bottom. `immr=0` encodes
/// `0x0FFFFFFFFFFFFFFF` instead (the zeros at the top), which fails
/// to clear the low bits and leaves the arena pointer unaligned.
pub(super) fn enc_and_imm_neg16(rd: Reg, rn: Reg) -> u32 {
    0x927C_EC00 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `ORR <Xd>, <Xn>, <Xm>` -- bitwise or.
pub(super) fn enc_orr_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0xAA00_0000, rd, rn, rm)
}

/// `MOV <Wd>, <Wn>` (`ORR Wd, WZR, Wn`) -- 32-bit register move. A write
/// to a W register clears the upper 32 bits of the X register, so this is
/// also the one-instruction zero-extension of the low word (`x & 0xffffffff`).
pub(super) fn enc_mov_w_w(rd: Reg, rn: Reg) -> u32 {
    0x2A00_03E0 | ((rn.0 as u32) << 16) | (rd.0 as u32)
}

/// `EOR <Xd>, <Xn>, <Xm>` -- bitwise xor.
pub(super) fn enc_eor_reg(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0xCA00_0000, rd, rn, rm)
}

/// `MVN <Xd>, <Xm>` (`ORN Xd, XZR, Xm`) -- bitwise NOT. `Rn` is baked
/// to XZR (31); ORN is ORR with the N bit set.
pub(super) fn enc_mvn(rd: Reg, rm: Reg) -> u32 {
    0xAA20_03E0 | ((rm.0 as u32) << 16) | (rd.0 as u32)
}

/// `MUL <Xd>, <Xn>, <Xm>` -- alias for `MADD Xd, Xn, Xm, XZR`.
/// We bake in `Ra = XZR (31)` so this stays a 3-register helper.
pub(super) fn enc_mul(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9B00_7C00, rd, rn, rm)
}

/// `SDIV <Xd>, <Xn>, <Xm>` -- signed integer division. Pairs with
/// [`enc_msub`] when computing modulo.
pub(super) fn enc_sdiv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9AC0_0C00, rd, rn, rm)
}

/// `UDIV <Xd>, <Xn>, <Xm>` -- unsigned integer division. Differs from
/// SDIV only in the opcode2 field (bit 10 cleared). Pairs with
/// [`enc_msub`] when computing unsigned modulo.
pub(super) fn enc_udiv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9AC0_0800, rd, rn, rm)
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
    enc_rrr(0x9AC0_2000, rd, rn, rm)
}

/// `LSRV <Xd>, <Xn>, <Xm>` -- variable logical right shift.
pub(super) fn enc_lsrv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9AC0_2400, rd, rn, rm)
}

/// `ASRV <Xd>, <Xn>, <Xm>` -- variable arithmetic right shift. The
/// signed counterpart to `LSRV`
pub(super) fn enc_asrv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9AC0_2800, rd, rn, rm)
}

/// `RORV <Xd>, <Xn>, <Xm>` -- variable rotate right.
pub(super) fn enc_rorv(rd: Reg, rn: Reg, rm: Reg) -> u32 {
    enc_rrr(0x9AC0_2C00, rd, rn, rm)
}

/// `ROR <Xd>, <Xs>, #<shift>` -- bit-rotate-right by constant. Encoded
/// as the EXTR alias `EXTR Xd, Xs, Xs, #shift`.
pub(super) fn enc_ror_imm(rd: Reg, rn: Reg, shift: u8) -> u32 {
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
pub(super) fn enc_fmov_x_to_d(dd: u8, xn: Reg) -> u32 {
    debug_assert!(dd < 32);
    0x9E67_0000 | ((xn.0 as u32) << 5) | (dd as u32)
}

/// `FMOV <Xd>, <Dn>` -- copy the 64 low bits of `Dn` back into `Xd`.
pub(super) fn enc_fmov_d_to_x(rd: Reg, dn: u8) -> u32 {
    debug_assert!(dn < 32);
    0x9E66_0000 | ((dn as u32) << 5) | (rd.0 as u32)
}

/// `FMOV <Dd>, <Dn>` -- copy a double-precision register. Used to
/// move a `double` value into the allocator's chosen d-register
/// when the producer wrote a different one.
pub(super) fn enc_fmov_d_d(dd: u8, dn: u8) -> u32 {
    debug_assert!(dd < 32 && dn < 32);
    0x1E60_4000 | ((dn as u32) << 5) | (dd as u32)
}

/// FP data-processing (2 source) word: `base | Rm<<16 | Rn<<5 | Rd`, V-register
/// operands. The ptype/opcode bits are part of `base`.
fn enc_fp2(base: u32, dd: u8, dn: u8, dm: u8) -> u32 {
    debug_assert!(dd < 32 && dn < 32 && dm < 32);
    base | ((dm as u32) << 16) | ((dn as u32) << 5) | (dd as u32)
}

/// `FADD <Dd>, <Dn>, <Dm>` -- double-precision add. `Dd = Dn + Dm`.
pub(super) fn enc_fadd_d(dd: u8, dn: u8, dm: u8) -> u32 {
    enc_fp2(0x1E60_2800, dd, dn, dm)
}

/// `FSUB <Dd>, <Dn>, <Dm>`. `Dd = Dn - Dm`.
pub(super) fn enc_fsub_d(dd: u8, dn: u8, dm: u8) -> u32 {
    enc_fp2(0x1E60_3800, dd, dn, dm)
}

/// `FMUL <Dd>, <Dn>, <Dm>`. `Dd = Dn * Dm`.
pub(super) fn enc_fmul_d(dd: u8, dn: u8, dm: u8) -> u32 {
    enc_fp2(0x1E60_0800, dd, dn, dm)
}

/// `FDIV <Dd>, <Dn>, <Dm>`. `Dd = Dn / Dm`.
pub(super) fn enc_fdiv_d(dd: u8, dn: u8, dm: u8) -> u32 {
    enc_fp2(0x1E60_1800, dd, dn, dm)
}

/// `FNEG <Dd>, <Dn>`. `Dd = -Dn`.
pub(super) fn enc_fneg_d(dd: u8, dn: u8) -> u32 {
    debug_assert!(dd < 32 && dn < 32);
    0x1E61_4000 | ((dn as u32) << 5) | (dd as u32)
}

/// `FSQRT <Dd>, <Dn>` -- scalar double square root. FP data-processing
/// (1 source), ptype=01, opcode=000011.
pub(super) fn enc_fsqrt_d(dd: u8, dn: u8) -> u32 {
    debug_assert!(dd < 32 && dn < 32);
    0x1E61_C000 | ((dn as u32) << 5) | (dd as u32)
}

/// `FSQRT <Sd>, <Sn>` -- scalar single square root. ptype=00.
pub(super) fn enc_fsqrt_s(sd: u8, sn: u8) -> u32 {
    debug_assert!(sd < 32 && sn < 32);
    0x1E21_C000 | ((sn as u32) << 5) | (sd as u32)
}

/// `FABS <Dd>, <Dn>` -- scalar double absolute value. opcode=000001.
pub(super) fn enc_fabs_d(dd: u8, dn: u8) -> u32 {
    debug_assert!(dd < 32 && dn < 32);
    0x1E60_C000 | ((dn as u32) << 5) | (dd as u32)
}

/// `FABS <Sd>, <Sn>` -- scalar single absolute value.
pub(super) fn enc_fabs_s(sd: u8, sn: u8) -> u32 {
    debug_assert!(sd < 32 && sn < 32);
    0x1E20_C000 | ((sn as u32) << 5) | (sd as u32)
}

/// `FRINTM <Dd>, <Dn>` -- round to integral toward -inf (floor).
/// FP-1-source opcode 001010.
pub(super) fn enc_frintm_d(dd: u8, dn: u8) -> u32 {
    0x1E65_4000 | ((dn as u32) << 5) | (dd as u32)
}
/// `FRINTM <Sd>, <Sn>`.
pub(super) fn enc_frintm_s(sd: u8, sn: u8) -> u32 {
    0x1E25_4000 | ((sn as u32) << 5) | (sd as u32)
}
/// `FRINTP <Dd>, <Dn>` -- round to integral toward +inf (ceil).
/// FP-1-source opcode 001001.
pub(super) fn enc_frintp_d(dd: u8, dn: u8) -> u32 {
    0x1E64_C000 | ((dn as u32) << 5) | (dd as u32)
}
/// `FRINTP <Sd>, <Sn>`.
pub(super) fn enc_frintp_s(sd: u8, sn: u8) -> u32 {
    0x1E24_C000 | ((sn as u32) << 5) | (sd as u32)
}
/// `FRINTZ <Dd>, <Dn>` -- round to integral toward zero (trunc).
/// FP-1-source opcode 001011.
pub(super) fn enc_frintz_d(dd: u8, dn: u8) -> u32 {
    0x1E65_C000 | ((dn as u32) << 5) | (dd as u32)
}
/// `FRINTZ <Sd>, <Sn>`.
pub(super) fn enc_frintz_s(sd: u8, sn: u8) -> u32 {
    0x1E25_C000 | ((sn as u32) << 5) | (sd as u32)
}

/// `FCMP <Dn>, <Dm>` -- set NZCV per the IEEE comparison of `Dn`
/// and `Dm`. Used in the comparison lowering before `CSET`. An
/// unordered (NaN) operand sets N=0, Z=0, C=1, V=1; the condition
/// codes `fp_compare_cond` selects yield the C99 result for that
/// state (`==` false, `!=` true, every relational form false).
pub(super) fn enc_fcmp_d(dn: u8, dm: u8) -> u32 {
    debug_assert!(dn < 32 && dm < 32);
    0x1E60_2000 | ((dm as u32) << 16) | ((dn as u32) << 5)
}

/// `FMOV <Sd>, <Wn>` -- copy the low 32 bits of `Wn` into the
/// single-precision view `Sd`. Used to stage an f32 constant (the
/// allocator parks it in a GPR as the int-encoded f32 bit pattern)
/// into an FP register before single-precision arithmetic.
pub(super) fn enc_fmov_w_to_s(sd: u8, wn: Reg) -> u32 {
    debug_assert!(sd < 32);
    0x1E27_0000 | ((wn.0 as u32) << 5) | (sd as u32)
}

/// `FMOV <Sd>, <Sn>` -- copy a single-precision register. Used to
/// move an `float` value into the allocator's chosen register when
/// the producer wrote a different one.
pub(super) fn enc_fmov_s_s(sd: u8, sn: u8) -> u32 {
    debug_assert!(sd < 32 && sn < 32);
    0x1E20_4000 | ((sn as u32) << 5) | (sd as u32)
}

/// `FADD <Sd>, <Sn>, <Sm>` -- single-precision add. `Sd = Sn + Sm`
/// (C99 6.3.1.8: `float op float` has type `float`).
pub(super) fn enc_fadd_s(sd: u8, sn: u8, sm: u8) -> u32 {
    enc_fp2(0x1E20_2800, sd, sn, sm)
}

/// `FSUB <Sd>, <Sn>, <Sm>`. `Sd = Sn - Sm`.
pub(super) fn enc_fsub_s(sd: u8, sn: u8, sm: u8) -> u32 {
    enc_fp2(0x1E20_3800, sd, sn, sm)
}

/// `FMUL <Sd>, <Sn>, <Sm>`. `Sd = Sn * Sm`.
pub(super) fn enc_fmul_s(sd: u8, sn: u8, sm: u8) -> u32 {
    enc_fp2(0x1E20_0800, sd, sn, sm)
}

/// `FDIV <Sd>, <Sn>, <Sm>`. `Sd = Sn / Sm`.
pub(super) fn enc_fdiv_s(sd: u8, sn: u8, sm: u8) -> u32 {
    enc_fp2(0x1E20_1800, sd, sn, sm)
}

/// `FNEG <Sd>, <Sn>`. `Sd = -Sn`.
pub(super) fn enc_fneg_s(sd: u8, sn: u8) -> u32 {
    debug_assert!(sd < 32 && sn < 32);
    0x1E21_4000 | ((sn as u32) << 5) | (sd as u32)
}

/// Floating-point fused multiply-add (3 source). `Dd = (neg_product ?
/// -(Dn*Dm) : Dn*Dm) + (neg_addend ? -Da : Da)`, computed with a single
/// rounding. `is_f32` selects the single-precision form (Sd/Sn/Sm/Sa).
/// The four sign combinations select FMADD / FNMSUB / FMSUB / FNMADD:
/// the o0 bit (15) and the negate-product bit (21) encode the variant
/// per the ARM "Floating-point data-processing (3 source)" group.
pub(super) fn enc_fma(
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
pub(super) fn enc_fcmp_s(sn: u8, sm: u8) -> u32 {
    debug_assert!(sn < 32 && sm < 32);
    0x1E20_2000 | ((sm as u32) << 16) | ((sn as u32) << 5)
}

/// `FCVTZS <Xd>, <Dn>` -- truncating signed FP-to-int. Matches the
/// C `(int)f` semantics: discard the fractional part; out-of-range
/// values saturate.
pub(super) fn enc_fcvtzs_x_d(rd: Reg, dn: u8) -> u32 {
    debug_assert!(dn < 32);
    0x9E78_0000 | ((dn as u32) << 5) | (rd.0 as u32)
}

/// `FCVTZU <Xd>, <Dn>` -- truncating unsigned FP-to-int. The
/// `FCVTZS` encoding with the opcode low bit set, so a double in
/// [2^63, 2^64) converts to the correct u64 rather than saturating.
pub(super) fn enc_fcvtzu_x_d(rd: Reg, dn: u8) -> u32 {
    debug_assert!(dn < 32);
    0x9E79_0000 | ((dn as u32) << 5) | (rd.0 as u32)
}

/// `SCVTF <Dd>, <Xn>` -- signed int-to-FP. Emits the round-to-
/// nearest-ties-to-even mantissa.
pub(super) fn enc_scvtf_d_x(dd: u8, xn: Reg) -> u32 {
    debug_assert!(dd < 32);
    0x9E62_0000 | ((xn.0 as u32) << 5) | (dd as u32)
}

/// `UCVTF <Dd>, <Xn>` -- unsigned int-to-FP. The `SCVTF` encoding
/// with the opcode low bit set, so a u64 with bit 63 set converts
/// to a positive double rather than a negative one.
pub(super) fn enc_ucvtf_d_x(dd: u8, xn: Reg) -> u32 {
    debug_assert!(dd < 32);
    0x9E63_0000 | ((xn.0 as u32) << 5) | (dd as u32)
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
/// Used by [`LoadKind::F32`] to load a `float`-typed lvalue's storage
/// directly into the `sN` half of `dN` before the widening fcvt.
pub(super) fn enc_ldr_s_imm(st: u8, rn: Reg, imm: u32) -> u32 {
    debug_assert!(st < 32);
    debug_assert!(imm.is_multiple_of(4) && imm < 16380);
    0xBD40_0000 | ((imm / 4) << 10) | ((rn.0 as u32) << 5) | (st as u32)
}

/// `STR <St>, [<Xn|SP>, #imm]` -- 32-bit unsigned-offset FP/SIMD
/// store. Same encoding family as [`enc_ldr_s_imm`]; companion
/// to the `StoreKind::F32` lowering.
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
/// short-to-long conversion). Used by [`LoadKind::F32`] after the
/// single-precision load.
pub(super) fn enc_fcvt_d_s(dd: u8, sn: u8) -> u32 {
    debug_assert!(dd < 32 && sn < 32);
    0x1E22_C000 | ((sn as u32) << 5) | (dd as u32)
}

/// `FCVT <Sd>, <Dn>` -- narrow double-precision to single-precision
/// with round-to-nearest-ties-to-even (matching IEEE 754 and the
/// VM's `f64 as f32` semantics). Used by the `StoreKind::F32`
/// lowering before the single-precision store.
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
    /// `BinOp::Lt` is followed by a `Terminator::Bz`, the
    /// branch fires on "(lhs < rhs) is false", i.e. "lhs >= rhs"
    /// -- so `Cond::Lt.flip() == Cond::Ge`.
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
/// Sets `Xd` to 1 if `cond` holds, 0 otherwise.
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
/// the `Terminator::TailExt` lowering to forward control to the
/// IAT/GOT-resolved libc address without saving a return point:
/// the libc fn's `RET` lands back at the c5 caller's post-call
/// continuation instead of bouncing back through the trampoline.
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

/// Load/store with a scaled 12-bit unsigned immediate offset:
/// `base | (imm >> scale_log2) << 10 | Rn<<5 | Rt`. `scale_log2` is the
/// access-size shift (0 byte, 1 half, 2 word, 3 doubleword); `imm` is the byte
/// offset and must be a multiple of the access size within the scaled range.
fn enc_ldst_scaled(base: u32, scale_log2: u32, rt: Reg, rn: Reg, imm: u32) -> u32 {
    let stride = 1u32 << scale_log2;
    debug_assert!(
        imm & (stride - 1) == 0,
        "ldst imm {imm} not aligned to {stride}"
    );
    let scaled = imm >> scale_log2;
    debug_assert!(
        scaled < 4096,
        "ldst imm {imm} out of range for stride {stride}"
    );
    base | (scaled << 10) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDR <Xt>, [<Xn|SP>, #imm]` -- 64-bit load, immediate offset
/// scaled by 8. `imm` is the byte offset; range `[0, 32760]`.
pub(super) fn enc_ldr_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_ldst_scaled(0xF940_0000, 3, rt, rn, imm)
}

/// `STR <Xt>, [<Xn|SP>, #imm]` -- 64-bit store. Same scaling as `LDR`.
pub(super) fn enc_str_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_ldst_scaled(0xF900_0000, 3, rt, rn, imm)
}

/// `LDR <Wt>, [<Xn|SP>, #imm]` -- 32-bit load (zero-extended into
/// `Xt`), immediate offset scaled by 4. Used by the Win64 TLS
/// lowering to read the 4-byte `_tls_index` slot.
pub(super) fn enc_ldr32_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_ldst_scaled(0xB940_0000, 2, rt, rn, imm)
}

/// `LDRSW <Xt>, [<Xn|SP>, #imm]` -- 32-bit load sign-extended into
/// the full 64-bit `Xt`, immediate offset scaled by 4. Used by
/// [`LoadKind::I32`] for signed `int` lvalue reads -- the C signed-int
/// model requires the high bit of the 4-byte slot to propagate.
pub(super) fn enc_ldrsw_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_ldst_scaled(0xB980_0000, 2, rt, rn, imm)
}

/// `STR <Wt>, [<Xn|SP>, #imm]` -- 32-bit store (low half of `Xt`),
/// immediate offset scaled by 4. Companion to [`enc_ldrsw_imm`] /
/// [`enc_ldr32_imm`] for the `StoreKind::I32` lowering.
pub(super) fn enc_str32_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_ldst_scaled(0xB900_0000, 2, rt, rn, imm)
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

/// `LDRSW Xt, [Xn, Xm, LSL #2]` -- sign-extending 32-bit load with
/// scaled register index. The c5 indexed-load fold uses this for
/// `int arr[]; arr[i]` reads.
pub(super) fn enc_ldrsw_reg_lsl2(rt: Reg, rn: Reg, rm: Reg) -> u32 {
    // size=10 (word), opc=10 (LDRS, sign-extend to 64-bit),
    // option=011 (LSL/UXTX), S=1 (scale by access_size=4).
    0xB8A0_7800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDR Wt, [Xn, Xm, LSL #2]` -- 32-bit zero-extending load with
/// scaled register index. Used by the indexed-load fold for
/// `unsigned int arr[]; arr[i]`.
pub(super) fn enc_ldr32_reg_lsl2(rt: Reg, rn: Reg, rm: Reg) -> u32 {
    // size=10, opc=01 (LDR), option=011, S=1.
    0xB860_7800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDRSH Xt, [Xn, Xm, LSL #1]` -- 16-bit sign-extending load.
pub(super) fn enc_ldrsh_reg_lsl1(rt: Reg, rn: Reg, rm: Reg) -> u32 {
    // size=01, opc=10, option=011, S=1.
    0x78A0_7800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDRH Wt, [Xn, Xm, LSL #1]` -- 16-bit zero-extending load.
pub(super) fn enc_ldrh_reg_lsl1(rt: Reg, rn: Reg, rm: Reg) -> u32 {
    // size=01, opc=01, option=011, S=1.
    0x7860_7800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDRSB Xt, [Xn, Xm]` -- 8-bit sign-extending load. No scale.
pub(super) fn enc_ldrsb_reg(rt: Reg, rn: Reg, rm: Reg) -> u32 {
    // size=00, opc=10, option=011, S=0 (byte access has no shift).
    0x38A0_6800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDRB Wt, [Xn, Xm]` -- 8-bit zero-extending load. No scale.
pub(super) fn enc_ldrb_reg(rt: Reg, rn: Reg, rm: Reg) -> u32 {
    // size=00, opc=01, option=011, S=0.
    0x3860_6800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STR Xt, [Xn, Xm, LSL #3]` -- 8-byte store with scaled index.
pub(super) fn enc_str_reg_lsl3(rt: Reg, rn: Reg, rm: Reg) -> u32 {
    // size=11, opc=00 (STR), option=011, S=1.
    0xF820_7800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STR Wt, [Xn, Xm, LSL #2]` -- 4-byte store with scaled index.
pub(super) fn enc_str32_reg_lsl2(rt: Reg, rn: Reg, rm: Reg) -> u32 {
    // size=10, opc=00, option=011, S=1.
    0xB820_7800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STRH Wt, [Xn, Xm, LSL #1]` -- 2-byte store with scaled index.
pub(super) fn enc_strh_reg_lsl1(rt: Reg, rn: Reg, rm: Reg) -> u32 {
    // size=01, opc=00, option=011, S=1.
    0x7820_7800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STRB Wt, [Xn, Xm]` -- 1-byte store, no scale.
pub(super) fn enc_strb_reg(rt: Reg, rn: Reg, rm: Reg) -> u32 {
    // size=00, opc=00, option=011, S=0.
    0x3820_6800 | ((rm.0 as u32) << 16) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDRSH <Xt>, [<Xn|SP>, #imm]` -- 16-bit load sign-extended into
/// the full 64-bit `Xt`, immediate offset scaled by 2. Used by
/// [`LoadKind::I16`] for `short` lvalue reads. Encoding: opc=10
/// (sign-extend to 64-bit), size=01 (halfword).
pub(super) fn enc_ldrsh_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_ldst_scaled(0x7980_0000, 1, rt, rn, imm)
}

/// `LDRH <Wt>, [<Xn|SP>, #imm]` -- 16-bit load zero-extended into
/// `Wt` (which clears the high 32 bits of `Xt`), immediate offset
/// scaled by 2. Used by [`LoadKind::U16`] for `unsigned short` lvalue
/// reads. Encoding: opc=01 (load), size=01.
pub(super) fn enc_ldrh_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_ldst_scaled(0x7940_0000, 1, rt, rn, imm)
}

/// `STRH <Wt>, [<Xn|SP>, #imm]` -- 16-bit store (low half of `Wt`),
/// immediate offset scaled by 2. Companion to [`enc_ldrsh_imm`] /
/// [`enc_ldrh_imm`] for the `StoreKind::I16` lowering.
pub(super) fn enc_strh_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_ldst_scaled(0x7900_0000, 1, rt, rn, imm)
}

/// `LDRB <Wt>, [<Xn|SP>, #imm]` -- byte load, zero-extended into a
/// 32-bit register (which on AArch64 means the high 32 bits of the
/// 64-bit register are also cleared).
pub(super) fn enc_ldrb_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_ldst_scaled(0x3940_0000, 0, rt, rn, imm)
}

/// `LDRSB <Xt>, [<Xn|SP>, #imm]` -- byte load sign-extended into
/// the full 64-bit `Xt`. Used by [`LoadKind::I8`] for `signed char`
/// lvalue reads. Encoding: opc=10 (sign-extend to 64-bit),
/// size=00 (byte). Imm is unscaled (byte stride).
pub(super) fn enc_ldrsb_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_ldst_scaled(0x3980_0000, 0, rt, rn, imm)
}

/// `STRB <Wt>, [<Xn|SP>, #imm]` -- byte store. Stores the low 8 bits
/// of `Wt` and ignores the rest.
pub(super) fn enc_strb_imm(rt: Reg, rn: Reg, imm: u32) -> u32 {
    enc_ldst_scaled(0x3900_0000, 0, rt, rn, imm)
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
pub(super) fn enc_ldaxr(rt: Reg, rn: Reg, width: u8) -> u32 {
    0x085F_FC00 | (excl_size(width) << 30) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STLXR{B,H} <Ws>, <Wt>, [<Xn|SP>]` / `STLXR <Ws>, <Wt|Xt>,
/// [<Xn|SP>]` -- store-release exclusive register of `width` bytes.
/// `rs` receives 0 on success and 1 when the monitor was lost.
pub(super) fn enc_stlxr(rs: Reg, rt: Reg, rn: Reg, width: u8) -> u32 {
    0x0800_FC00
        | (excl_size(width) << 30)
        | ((rs.0 as u32) << 16)
        | ((rn.0 as u32) << 5)
        | (rt.0 as u32)
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

/// `LDURSW <Xt>, [<Xn|SP>, #imm]` -- load 4 bytes, sign-extend to
/// 64. Unscaled 9-bit signed offset.
pub(super) fn enc_ldursw(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!((-256..256).contains(&imm), "ldursw imm: {imm} out of range");
    let imm9 = (imm as u32) & 0x1FF;
    0xB880_0000 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDUR <Wt>, [<Xn|SP>, #imm]` -- load 4 bytes into a 32-bit
/// register, zero-extending to the full 64-bit Xt.
pub(super) fn enc_ldur32(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!((-256..256).contains(&imm), "ldur32 imm: {imm} out of range");
    let imm9 = (imm as u32) & 0x1FF;
    0xB840_0000 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDURSH <Xt>, [<Xn|SP>, #imm]` -- load 2 bytes, sign-extend to
/// 64. Unscaled 9-bit signed offset.
pub(super) fn enc_ldursh(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!((-256..256).contains(&imm), "ldursh imm: {imm} out of range");
    let imm9 = (imm as u32) & 0x1FF;
    0x7880_0000 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDURH <Wt>, [<Xn|SP>, #imm]` -- load 2 bytes, zero-extend
/// (to 32 bits, implicitly to 64). Unscaled 9-bit signed offset.
pub(super) fn enc_ldurh(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!((-256..256).contains(&imm), "ldurh imm: {imm} out of range");
    let imm9 = (imm as u32) & 0x1FF;
    0x7840_0000 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDURSB <Xt>, [<Xn|SP>, #imm]` -- load 1 byte, sign-extend to
/// 64. Unscaled 9-bit signed offset.
pub(super) fn enc_ldursb(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!((-256..256).contains(&imm), "ldursb imm: {imm} out of range");
    let imm9 = (imm as u32) & 0x1FF;
    0x3880_0000 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LDURB <Wt>, [<Xn|SP>, #imm]` -- load 1 byte, zero-extend
/// (to 32 bits, implicitly to 64). Unscaled 9-bit signed offset.
pub(super) fn enc_ldurb(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!((-256..256).contains(&imm), "ldurb imm: {imm} out of range");
    let imm9 = (imm as u32) & 0x1FF;
    0x3840_0000 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STUR <Wt>, [<Xn|SP>, #imm]` -- store low 32 bits of Xt.
pub(super) fn enc_stur32(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!((-256..256).contains(&imm), "stur32 imm: {imm} out of range");
    let imm9 = (imm as u32) & 0x1FF;
    0xB800_0000 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STURH <Wt>, [<Xn|SP>, #imm]` -- store low 16 bits of Xt.
pub(super) fn enc_sturh(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!((-256..256).contains(&imm), "sturh imm: {imm} out of range");
    let imm9 = (imm as u32) & 0x1FF;
    0x7800_0000 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `STURB <Wt>, [<Xn|SP>, #imm]` -- store low 8 bits of Xt.
pub(super) fn enc_sturb(rt: Reg, rn: Reg, imm: i32) -> u32 {
    debug_assert!((-256..256).contains(&imm), "sturb imm: {imm} out of range");
    let imm9 = (imm as u32) & 0x1FF;
    0x3800_0000 | (imm9 << 12) | ((rn.0 as u32) << 5) | (rt.0 as u32)
}

/// `LSL <Xd>, <Xn>, #shift` -- logical shift left by immediate.
/// Encoded as `UBFM Xd, Xn, #(-shift mod 64), #(63-shift)`.
pub(super) fn enc_lsl_imm(rd: Reg, rn: Reg, shift: u8) -> u32 {
    debug_assert!(shift < 64, "lsl imm: {shift} >= 64");
    let immr = ((64 - shift as u32) & 63) << 16;
    let imms = ((63 - shift as u32) & 63) << 10;
    0xD340_0000 | immr | imms | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `LSR <Xd>, <Xn>, #shift` -- logical shift right by immediate.
/// Encoded as `UBFM Xd, Xn, #shift, #63`.
pub(super) fn enc_lsr_imm(rd: Reg, rn: Reg, shift: u8) -> u32 {
    debug_assert!(shift < 64, "lsr imm: {shift} >= 64");
    let immr = ((shift as u32) & 63) << 16;
    0xD340_FC00 | immr | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `ASR <Xd>, <Xn>, #shift` -- arithmetic shift right by immediate.
/// Encoded as `SBFM Xd, Xn, #shift, #63`.
pub(super) fn enc_asr_imm(rd: Reg, rn: Reg, shift: u8) -> u32 {
    debug_assert!(shift < 64, "asr imm: {shift} >= 64");
    let immr = ((shift as u32) & 63) << 16;
    0x9340_FC00 | immr | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SXTW <Xd>, <Wn>` -- sign-extend low 32 bits of `Wn` into `Xd`.
/// Alias of `SBFM Xd, Xn, #0, #31`. Used by the sxtw peephole that
/// folds c5's `Shl 32; Shr 32` sign-narrow shape into one inst.
pub(super) fn enc_sxtw(rd: Reg, rn: Reg) -> u32 {
    // sf=1, opc=00 (SBFM), immr=0, imms=31, Rn, Rd.
    0x9340_7C00 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SXTH <Xd>, <Wn>` -- sign-extend low 16 bits of `Wn` into `Xd`.
/// Alias of `SBFM Xd, Xn, #0, #15`. Companion to `enc_sxtw` for the
/// short-narrow shape (`Shl 48; Shr 48`).
pub(super) fn enc_sxth(rd: Reg, rn: Reg) -> u32 {
    0x9340_3C00 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

/// `SXTB <Xd>, <Wn>` -- sign-extend low 8 bits of `Wn` into `Xd`.
/// Alias of `SBFM Xd, Xn, #0, #7`. Companion to `enc_sxtw` for the
/// char-narrow shape (`Shl 56; Shr 56`).
pub(super) fn enc_sxtb(rd: Reg, rn: Reg) -> u32 {
    0x9340_1C00 | ((rn.0 as u32) << 5) | (rd.0 as u32)
}

// ---- Pre-/post-indexed loads & stores. The c5 VM stack push/pop
//      compiles to these because they update sp in the same instruction.

/// `STR <Xt>, [<Xn|SP>, #imm]!` -- pre-indexed store with writeback.
/// Use with `imm = -16` for the accumulator push: store
/// accumulator and bump sp down by 16 bytes (the VM stack stays
/// 16-byte aligned even for 8-byte pushes so calls into libc
/// satisfy AAPCS64).
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

// ---- Branch fixups. Bytecode branches target absolute ent_pcs;
//      the native PC of those targets isn't known until after the
//      whole function body is laid out. Two-pass approach: emit a
//      placeholder branch instruction, record (its native offset, the
//      target ent_pc, the kind), then patch the placeholder
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
    pub(super) target_ent_pc: usize,
    pub(super) kind: BranchKind,
}

/// Lower a [`Program`]'s SSA functions to AArch64 machine code.
/// Walks every Inst once, emitting native code; control-flow
/// terminators emit a placeholder branch and record a fixup to be
/// patched after the whole layout is known.
///
/// Calling convention:
/// * VM accumulator `a` lives in `x19` (callee-saved across calls).
/// * The VM stack rides on the native stack: an accumulator
///   push lowers to `str x19, [sp, #-16]!`, every binary op
///   pops with `ldr <tmp>, [sp], #16`. Push slots are 16 bytes
///   (not 8) so SP stays aligned for libc calls.
/// * `x16`/`x17` (IP0/IP1) are the AAPCS64-blessed temporaries we use
///   for popped operands and large-immediate scratch.
/// * Each function's prologue is the standard AAPCS64 sequence;
///   epilogue moves `x19` into `x0` (the return register).
///
/// Syscall ops (`Open`...`Senv`) lower to `adrp + ldr + blr` through
/// a __got slot the writer fills in at link time.
pub(super) fn lower(
    program: &Program,
    target: Target,
    #[cfg_attr(not(feature = "std"), allow(unused_variables))] native: NativeOptions,
    imports: &super::ResolvedImports,
) -> Result<Build, C5Error> {
    let mut code = Vec::new();
    let mut func_ent_pcs: Vec<usize> = Vec::new();
    let mut func_names: Vec<alloc::string::String> = Vec::new();
    let mut func_prologue_native: alloc::collections::BTreeMap<usize, usize> =
        alloc::collections::BTreeMap::new();
    let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();
    let mut fixups: Vec<Fixup> = Vec::new();
    let mut got_fixups: Vec<GotFixup> = Vec::new();
    // Each `JsrExt` / `TailExt` site emits a placeholder
    // BL/B; the displacement gets backfilled once trampolines are
    // laid out at the tail of `code`.
    let mut plt_call_fixups: Vec<PltCallFixup> = Vec::new();
    let mut data_fixups: Vec<DataFixup> = Vec::new();
    let mut user_extern_data_refs: Vec<super::UserExternDataRef> = Vec::new();
    // Function-pointer Imms get their target resolved post-walk against
    // `pc_to_native`, so we record (adrp_offset, target_ent_pc)
    // here and rewrite into `Build::func_fixups` once the map is final.
    let mut pending_func_fixups: Vec<(usize, usize)> = Vec::new();
    // Win64 TLS-index fixups -- one entry per `Inst::TlsAddr`
    // lowering site when targeting Windows. The PE writer reserves
    // the `_tls_index` DWORD slot and patches each fixup with the
    // displacement to it.
    let mut tls_index_fixups: Vec<super::TlsIndexFixup> = Vec::new();
    // Linux/aarch64 TLS access fixups: each `Inst::TlsAddr` records its
    // add-immediate site so the linker resolves the variant-1 TPOFF
    // against the merged TLS layout (extern symbols and multi-unit
    // local accesses).
    let mut elf_tpoff_fixups: Vec<super::ElfTpoffFixup> = Vec::new();
    // macOS arm64 TLV: each unique TLS variable's offset gets a
    // descriptor index; the writer emits a 24-byte
    // `__thread_vars` descriptor per index. Each `Inst::TlsAddr`
    // site records an `adrp + add` pair via `macho_tlv_fixups`.
    let mut macho_tlv_fixups: Vec<super::MachoTlvFixup> = Vec::new();
    let mut macho_tlv_descriptors: Vec<super::MachoTlvDescriptor> = Vec::new();

    // Lift the program into SSA once and run the linear-scan
    // allocator per function. Each function lowers through
    // `ssa_emit_aarch64::emit_function`; a per-function emit bail
    // is a hard error so any IR + emit coverage gap surfaces
    // immediately. `--dump-ssa` prints the IR + allocation for
    // each function.
    let mut ssa_funcs: alloc::vec::Vec<super::super::ir::FunctionSsa> =
        super::ssa_emit_common::time_pass("ssa::produce_ssa_funcs (aarch64)", || {
            super::ssa_shadow::produce_ssa_funcs(program, target)
        })?;
    // Frame slots mem2reg promoted to registers (-O) or that slot
    // coalescing moved onto shared storage: the debug-info emitter drops
    // their stale frame location. Slots coalescing moved to a new exclusive
    // offset are recorded separately so the emitter rewrites the location.
    let mut promoted_local_slots: alloc::collections::BTreeMap<usize, alloc::vec::Vec<i64>> =
        alloc::collections::BTreeMap::new();
    let mut coalesced_slot_remap: alloc::collections::BTreeMap<
        usize,
        alloc::collections::BTreeMap<i64, i64>,
    > = alloc::collections::BTreeMap::new();
    // Reuse non-overlapping synthetic stack slots. At -O, mem2reg promotes
    // these address-free slots to SSA values; this is the default-level
    // analog, shrinking frames built from many control-flow merges whose
    // phi-substitute slots never overlap. The pass runs regardless of debug
    // info so the emitted code is identical with and without -g.
    if !native.optimize {
        let coalesce_dwarf =
            super::ssa_emit_common::time_pass("ssa_slot_coalesce::run (aarch64)", || {
                super::ssa_slot_coalesce::run(&mut ssa_funcs)
            });
        for (ent_pc, map) in coalesce_dwarf {
            for (orig, new) in map {
                match new {
                    Some(new) => {
                        coalesced_slot_remap
                            .entry(ent_pc)
                            .or_default()
                            .insert(orig, new);
                    }
                    None => promoted_local_slots.entry(ent_pc).or_default().push(orig),
                }
            }
        }
    }
    // -O: promote address-free local slots to SSA values before
    // register allocation, dropping their frame load / store traffic.
    // Record the promoted slots per function so the debug-info emitter
    // can drop their now-stale frame location.
    if native.optimize {
        super::ssa_emit_common::time_pass("ssa_mem2reg::run (aarch64)", || {
            for f in &mut ssa_funcs {
                let promoted = super::ssa_mem2reg::run(f);
                if !promoted.is_empty() {
                    promoted_local_slots.insert(f.ent_pc, promoted);
                }
            }
        });
        // Inline after mem2reg; see x86_64.rs's matching block for
        // the ordering rationale.
        super::ssa_emit_common::time_pass("ssa_inline::run (aarch64)", || {
            super::ssa_inline::run(&mut ssa_funcs, native.inline_cap, target.abi());
        });
        // Forward an inlined one-word struct return out of its frame slot;
        // see x86_64.rs's matching block for the rationale.
        super::ssa_emit_common::time_pass("ssa_struct_return_reg::run (aarch64)", || {
            super::ssa_struct_return_reg::run(&mut ssa_funcs);
        });
        super::ssa_emit_common::time_pass("ssa_rotate::run (aarch64)", || {
            super::ssa_rotate::run(&mut ssa_funcs);
        });
        // Fused multiply-add contraction (C99 6.5p8 / FP_CONTRACT ON at
        // -O). Runs after the inliner so products exposed by parameter
        // substitution into an add/sub become contractible.
        super::ssa_emit_common::time_pass("ssa_fma::run (aarch64)", || {
            super::ssa_fma::run(&mut ssa_funcs);
        });
        super::ssa_emit_common::time_pass("ssa_constfold_branch::run (aarch64)", || {
            super::ssa_constfold_branch::run(&mut ssa_funcs);
        });
        super::ssa_emit_common::time_pass("ssa_split_crit_edges::run (aarch64)", || {
            super::ssa_split_crit_edges::run(&mut ssa_funcs);
        });
        super::ssa_emit_common::time_pass("ssa_dedup_imm::run (aarch64)", || {
            super::ssa_dedup_imm::run(&mut ssa_funcs);
        });
        super::ssa_emit_common::time_pass("ssa_drop_redundant_extend::run (aarch64)", || {
            super::ssa_drop_redundant_extend::run(&mut ssa_funcs);
        });
        // Scaled-index addressing: fold `base + index*scale` into the
        // load / store. Runs last so it sees the final address shape;
        // the optimizer passes never traverse `LoadIndexed` /
        // `StoreIndexed`, so the per-arch emit is the only later consumer.
        super::ssa_emit_common::time_pass("ssa_index_fold::run (aarch64)", || {
            super::ssa_index_fold::run(&mut ssa_funcs);
        });
        // Store-to-load and load-to-load forwarding within a block. Runs
        // after the index fold so a struct field's store and load address
        // are both normalised to the same `(base, disp)`. Bounded by
        // live-range extension so it does not pin scattered re-reads in a
        // register-starved unrolled loop.
        super::ssa_emit_common::time_pass("ssa_store_forward::run (aarch64)", || {
            super::ssa_store_forward::run(&mut ssa_funcs);
        });
    }
    // Upper bound on ent_pcs the lowering will reference. The
    // walker stamps `ent_pc` / `end_pc` against the ent_pc
    // space, and the dense `pc_to_native` table holds
    // every reachable PC.
    let pc_extent = super::pc_extent_for_lowering(program, &ssa_funcs);
    let mut pc_to_native: Vec<usize> = vec![usize::MAX; pc_extent + 1];
    // Per-callee variadic flag, derived from FunctionSsa::is_variadic
    // for locally-defined callees and from `Symbol::is_variadic`
    // for cross-TU extern-declared callees. Each call site reads
    // it to pick the host-ABI vs c5-stack arg passing shape for
    // the callee. Without the extern entries here, a cross-TU
    // call to a variadic function emits a non-variadic register
    // sequence and the callee reads junk from the c5 stack.
    let mut variadic_targets: alloc::collections::BTreeSet<usize> = ssa_funcs
        .iter()
        .filter(|f| f.is_variadic)
        .map(|f| f.ent_pc)
        .collect();
    {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
        let extern_pcs: alloc::collections::BTreeSet<usize> = program
            .extern_function_imports
            .iter()
            .map(|(pc, _)| *pc)
            .collect();
        for sym in &program.symbols {
            if sym.class == Token::Fun as i64
                && !sym.defined_here
                && sym.linkage == Linkage::External
                && sym.is_variadic
                && extern_pcs.contains(&(sym.val as usize))
            {
                variadic_targets.insert(sym.val as usize);
            }
        }
    }
    let ssa_allocs: alloc::vec::Vec<super::ssa_alloc::Allocation> =
        super::ssa_emit_common::time_pass("ssa_alloc::allocate (aarch64)", || {
            ssa_funcs
                .iter()
                .map(|f| super::ssa_alloc::allocate(f, target))
                .collect()
        });
    #[cfg(feature = "std")]
    if super::ssa_dump::enabled(native) {
        let name_by_ent: alloc::collections::BTreeMap<usize, &str> = program
            .finished_functions
            .iter()
            .map(|ff| (ff.ent_pc, ff.name.as_str()))
            .collect();
        for (f, a) in ssa_funcs.iter().zip(ssa_allocs.iter()) {
            if let Some(name) = name_by_ent.get(&f.ent_pc) {
                eprintln!("; name={name}");
            }
            eprint!("{}", super::ssa_dump::dump_function(f, a));
        }
    }
    #[cfg(feature = "std")]
    let _ssa_emit_pass_start = std::time::Instant::now();
    for (func_ssa, alloc_for) in ssa_funcs.iter().zip(ssa_allocs.iter()) {
        let ent_pc = func_ssa.ent_pc;
        pc_to_native[ent_pc] = code.len();
        func_ent_pcs.push(ent_pc);
        func_names.push(func_ssa.name.clone());
        // Pre-resolve every `imm_data_extern` value-id to the
        // symbol name once per function so `emit_function` can
        // tag the matching `DataFixup` with the cross-TU name.
        let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> = func_ssa
            .extern_imm_data_refs
            .iter()
            .map(|(v, sym_idx)| (*v, program.symbols[*sym_idx as usize].name.clone()))
            .collect();
        // Same pre-resolution for `tls_addr_extern` value-ids so the
        // Mach-O TLV descriptor is keyed by the cross-unit symbol name.
        let extern_tls_names: alloc::collections::BTreeMap<u32, alloc::string::String> = func_ssa
            .extern_tls_refs
            .iter()
            .map(|(v, sym_idx)| (*v, program.symbols[*sym_idx as usize].name.clone()))
            .collect();
        let ok = super::ssa_emit_aarch64::emit_function(
            func_ssa,
            alloc_for,
            target,
            &mut code,
            &mut fixups,
            &mut plt_call_fixups,
            &mut data_fixups,
            &mut user_extern_data_refs,
            &extern_data_names,
            &extern_tls_names,
            &mut pending_func_fixups,
            imports,
            &variadic_targets,
            &mut tls_index_fixups,
            &mut macho_tlv_fixups,
            &mut macho_tlv_descriptors,
            &mut elf_tpoff_fixups,
            &mut pc_to_native,
            &mut func_prologue_native,
            &mut ssa_line_rows,
        );
        if !ok {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &alloc::format!(
                    "ssa emit (aarch64): function `{}` (ent_pc {ent_pc}) contains an op outside the implemented subset",
                    func_ssa.name,
                ),
            )));
        }
    }
    #[cfg(feature = "std")]
    if super::ssa_emit_common::time_passes_enabled() {
        let us = _ssa_emit_pass_start.elapsed().as_micros();
        eprintln!("pass: ssa_emit_aarch64 (block walk) -- {us}us");
    }
    pc_to_native[pc_extent] = code.len();

    // Cross-TU user-function imports surfaced by the parser as
    // placeholder ent_pcs past `text.len()`. Each `Inst::Call`
    // emits a `Fixup::Bl` with `target_ent_pc` equal to the
    // placeholder; we partition those out before
    // `apply_fixups` and re-emit them as
    // `Build::user_extern_call_sites` entries that the writer
    // surfaces as `R_AARCH64_CALL26` relocs against the
    // callee's symbol. Empty for builds without
    // `CompileOptions::no_entry_point`.
    let extern_pc_lookup: alloc::collections::BTreeMap<usize, &str> = program
        .extern_function_imports
        .iter()
        .map(|(pc, name)| (*pc, name.as_str()))
        .collect();
    let mut user_extern_call_sites: Vec<super::UserExternCallSite> = Vec::new();
    let resolved_fixups: Vec<Fixup> = if extern_pc_lookup.is_empty() {
        fixups
    } else {
        let mut out = Vec::with_capacity(fixups.len());
        for f in fixups {
            if let Some(name) = extern_pc_lookup.get(&f.target_ent_pc) {
                let is_tail = matches!(f.kind, BranchKind::B);
                user_extern_call_sites.push(super::UserExternCallSite {
                    instr_offset: f.native_offset,
                    symbol_name: (*name).into(),
                    is_tail,
                });
            } else {
                out.push(f);
            }
        }
        out
    };
    apply_fixups(&mut code, &resolved_fixups, &pc_to_native, pc_extent)?;

    // Append one PLT trampoline per import. Every BL/B
    // placeholder recorded in `plt_call_fixups` now gets its imm26
    // backfilled to the matching trampoline's byte offset. The
    // trampoline body's adrp+ldr pair is patched by the per-format
    // writer through the same `GotFixup` shape the inline call
    // sequence used before PLT trampolines existed.
    // Capture call sites before the PLT-fixup pass rewrites the
    // BL imm26 fields. The `OutputKind::Relocatable` writer reads
    // these to emit `R_AARCH64_CALL26` relocations against each
    // import's external symbol; final-image writers ignore the
    // list and rely on the PLT trampolines below.
    let reloc_call_sites: Vec<super::RelocCallSite> = plt_call_fixups
        .iter()
        .map(|f| super::RelocCallSite {
            instr_offset: f.instr_offset,
            import_index: f.import_index,
            is_tail: f.is_tail,
            is_addr: f.is_addr,
        })
        .collect();
    // Final-image output emits one PLT trampoline per import at
    // the tail of `.text` and rewrites every BL/B placeholder to
    // reach the matching trampoline. Relocatable output leaves
    // the placeholders raw (imm26 = 0) so the linker materialises
    // the PLT pool when it produces the final image -- the
    // matching `R_AARCH64_CALL26` reloc in `.rela.text` carries
    // the call site's import symbol.
    let plt_trampoline_offsets: Vec<usize> = if native.output_kind != super::OutputKind::Relocatable
    {
        let offsets = emit_plt_trampolines(&mut code, &mut got_fixups, imports.imports.len());
        apply_plt_call_fixups(&mut code, &plt_call_fixups, &offsets)?;
        offsets
    } else {
        Vec::new()
    };

    // Function-pointer fixups resolve to each callee's body offset
    // directly: every function's prologue already spills the host
    // arg registers into the c5 cdecl slots that the body reads
    // through the address-of-local path, so a host caller
    // (`pthread_create`, `qsort`, a static dispatch table, ...)
    // can land on the body itself. Variadic c5 functions keep the
    // c5-stack-based ABI and reach only via indirect c5 callers
    // that lay args onto the c5 stack first; their fn-pointer
    // fixups also land on the body, which keeps that contract
    // intact.
    let mut func_fixups: Vec<FuncFixup> = Vec::with_capacity(pending_func_fixups.len());
    for (adrp_offset, target_ent_pc) in pending_func_fixups {
        // Cross-TU target: the placeholder ent_pc has no entry
        // in `pc_to_native`. Route to the same named-
        // symbol channel that data extern refs use; the linker
        // resolves the ADRP+ADD pair to `text_vaddr + target`
        // via the data_abs_relocs Text-section path.
        if let Some(&name) = extern_pc_lookup.get(&target_ent_pc) {
            user_extern_data_refs.push(super::UserExternDataRef {
                instr_offset: adrp_offset,
                symbol_name: (*name).into(),
            });
            continue;
        }
        if target_ent_pc > pc_extent {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen: function pointer target {target_ent_pc} past end of PC space"
                ),
            )));
        }
        let target = pc_to_native[target_ent_pc];
        if target == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen: function pointer target {target_ent_pc} did not land on an instruction"
                ),
            )));
        }
        func_fixups.push(FuncFixup {
            adrp_offset,
            target_native_offset: target,
        });
    }

    // Address-of-import sites (`&strcmp`, `Inst::ImmExtCode`) in the
    // local-image path resolve to the import's PLT trampoline, the
    // same stub a call to the import reaches. A `FuncFixup` routes
    // the `adrp + add` pair through the writer's func-fixup pass
    // exactly like a function-pointer literal. Relocatable output
    // (empty `plt_trampoline_offsets`) emits the reloc via
    // `reloc_call_sites` instead.
    if native.output_kind != super::OutputKind::Relocatable {
        for fx in &plt_call_fixups {
            if fx.is_addr {
                func_fixups.push(FuncFixup {
                    adrp_offset: fx.instr_offset,
                    target_native_offset: plt_trampoline_offsets[fx.import_index],
                });
            }
        }
    }

    let entry_offset = if native.output_kind == super::OutputKind::Relocatable {
        // Relocatable objects carry no entry point; the linker picks
        // it once every TU is merged. `entry_pc` may legitimately be
        // 0 here (`--no-entry-point` / `-c` on a TU without `main`)
        // and need not land on a real instruction.
        pc_to_native
            .get(program.entry_pc)
            .copied()
            .filter(|&n| n != usize::MAX)
            .unwrap_or(0)
    } else {
        let off = pc_to_native.get(program.entry_pc).copied().ok_or_else(|| {
            C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                "native codegen: entry_pc {} is out of PC range",
                program.entry_pc
            )))
        })?;
        if off == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen: entry_pc {} did not align with any instruction start",
                    program.entry_pc
                ),
            )));
        }
        off
    };

    Ok(Build {
        copy_relocs: Vec::new(),
        text: code,
        data: program.data.clone(),
        bss_size: 0,
        entry_offset,
        got_fixups,
        data_fixups,
        func_fixups,
        pc_to_native,
        func_ent_pcs,
        func_names,
        func_prologue_native,
        promoted_local_slots,
        coalesced_slot_remap,
        // x86_64-only Win64 unwind; the aarch64 PE writer uses packed
        // RUNTIME_FUNCTIONs and consults no per-function descriptor.
        fn_unwind: Vec::new(),
        reloc_call_sites,
        user_extern_call_sites,
        user_extern_data_refs,
        ssa_line_rows,
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
        extern_data_relocs: Vec::new(),
        code_relocs: Vec::new(),
        exports: Vec::new(),
        dynamic_exports: Vec::new(),
        output_kind: super::OutputKind::Executable,
        shared_lib_name: None,
        dllmain_pc: None,
        macho_tlv_fixups,
        macho_tlv_descriptors,
        // macOS resolves TLS through Mach-O TLV descriptors; Linux/aarch64
        // records add-immediate sites here for the linker to resolve.
        elf_tpoff_fixups,
        // Overwritten by `lower_for` from `NativeOptions::debug_info`.
        debug_info: true,
        merged_dwarf: None,
        plt_trampoline_offsets,
    })
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
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen: branch target {} past end of PC space",
                    f.target_ent_pc
                ),
            )));
        }
        let target = pc_to_native[f.target_ent_pc];
        if target == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen: branch target {} did not land on an instruction",
                    f.target_ent_pc
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
    /// instruction whose `imm26` the fixup pass backfills.
    pub(super) instr_offset: usize,
    /// Import slot the call should reach via its trampoline.
    pub(super) import_index: usize,
    /// `true` -> emit `B <tramp>` (tail jump); `false` -> emit
    /// `BL <tramp>` (call). Both share the same imm26 encoding;
    /// only the link bit at 0x80000000 differs.
    pub(super) is_tail: bool,
    /// `true` -> the site is an `adrp + add` pair that takes the
    /// import's address (`Inst::ImmExtCode`, `&strcmp`) rather than
    /// a BL/B. The pair resolves to the import's shared stub via the
    /// page-relative reloc rather than the imm26 branch; `is_tail`
    /// is irrelevant.
    pub(super) is_addr: bool,
}

/// Tail-jump variant of [`emit_got_call`]: emits a 4-byte
/// `B <plt_trampoline>` placeholder. libc's `RET` returns
/// directly to the c5 caller of the trampoline, skipping
/// both this `B` and the trampoline entirely on the way back.
/// Used by the `Terminator::TailExt` lowering.
pub(super) fn emit_got_tail_jump(
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
            adrp_offset: tramp_off,
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

/// jmp_buf field offsets for the AArch64 setjmp / longjmp
/// intrinsics. Lays out 10 callee-saved x-regs, FP (x29), the
/// resume PC, SP, and 8 callee-saved d-regs. Total 168 bytes;
/// the `<setjmp.h>` typedef reserves 256 to leave slack for
/// future additions.
pub(super) const JB_X19_OFF: u32 = 0;
pub(super) const JB_X29_OFF: u32 = 80;
pub(super) const JB_PC_OFF: u32 = 88;
pub(super) const JB_SP_OFF: u32 = 96;
pub(super) const JB_D8_OFF: u32 = 104;
/// Total instruction count emitted by `emit_setjmp_aarch64` --
/// every entry is one 4-byte AArch64 word. Used to compute the
/// PC-relative offset the ADR captures so a matching longjmp
/// branches to exactly the byte after the inline expansion.
/// Layout: 1 mov + 10 str(x19-x28) + 1 str(x29) + 1 adr + 1
/// str(pc) + 1 add(sp) + 1 str(sp) + 8 str(d8-d15) + 1 movz =
/// 25 instructions; ADR sits at zero-based index 12.
pub(super) const SETJMP_AARCH64_INSN_COUNT: i32 = 25;
pub(super) const SETJMP_AARCH64_ADR_INSN_INDEX: i32 = 12;

/// AArch64 setjmp inlined at the call site. The `env` pointer
/// arrives in `x19` (c5's accumulator). On the initial call this
/// writes the resume context into `[env]` and sets `x19 = 0`; on
/// a matching longjmp control jumps to the address right after
/// the inline expansion with `x19` carrying the longjmp value.
///
/// CRT-independent so it works on Windows AArch64, whose msvcrt
/// `longjmp` routes through SEH and refuses an SEH-free
/// `jmp_buf`. The Linux / macOS bindings continue to use the
/// host libc setjmp -- that's already CRT-independent.
pub(super) fn emit_setjmp_aarch64(code: &mut Vec<u8>) {
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
}

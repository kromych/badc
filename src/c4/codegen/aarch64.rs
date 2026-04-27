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
use super::{Build, DataFixup, FuncFixup, GotFixup};

/// Libc symbols badc binaries import. The bind opcode stream and the
/// __got layout walk this list in order; codegen picks slots out of
/// it via [`import_index_for_op`]. **Order matters** -- the index in
/// this slice is the GOT slot index in __DATA.
pub(crate) const IMPORTS: &[(&str, Op)] = &[
    ("_open", Op::Open),
    ("_read", Op::Read),
    ("_close", Op::Clos),
    ("_printf", Op::Prtf),
    ("_malloc", Op::Malc),
    ("_free", Op::Free),
    ("_memset", Op::Mset),
    ("_memcmp", Op::Mcmp),
    ("_memcpy", Op::Mcpy),
    ("_mprotect", Op::Mpro),
    ("_exit", Op::Exit),
    ("_write", Op::Write),
    ("_getenv", Op::Genv),
    ("_setenv", Op::Senv),
];

fn import_index_for_op(op: Op) -> Option<usize> {
    IMPORTS.iter().position(|(_, o)| *o == op)
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
    pub const X16: Reg = Reg(16); // IP0 -- temp scratch
    pub const X17: Reg = Reg(17); // IP1 -- second temp
    pub const X19: Reg = Reg(19); // VM accumulator (callee-saved)
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

/// `BLR <Xn>` -- branch with link to the address in `Xn`. Used for
/// indirect calls (function pointer through GOT).
pub(super) fn enc_blr(rn: Reg) -> u32 {
    0xD63F_0000 | ((rn.0 as u32) << 5)
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
pub(super) fn lower(program: &Program) -> Result<Build, C4Error> {
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
) -> Result<(), C4Error> {
    match op {
        // ---- Function frame ----
        Op::Ent => {
            let locals = read_operand(text, pc, "Ent")?;
            emit_prologue(code, locals, in_main);
        }
        Op::Lev => emit_epilogue(code, in_main),
        Op::Adj => {
            // Adj N drops N pushed slots (each slot is 16 bytes
            // on our native stack -- see Op::Psh below for why).
            let n = read_operand(text, pc, "Adj")?;
            if n != 0 {
                let bytes = (n as u32) * 16;
                emit(code, enc_add_imm(Reg::SP, Reg::SP, bytes));
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
            // pop addr -> x16; *x16 = x19
            emit(code, enc_ldr_post(Reg::X16, Reg::SP, 16));
            emit(code, enc_str_imm(Reg::X19, Reg::X16, 0));
        }
        Op::Sc => {
            emit(code, enc_ldr_post(Reg::X16, Reg::SP, 16));
            emit(code, enc_strb_imm(Reg::X19, Reg::X16, 0));
        }
        Op::Psh => {
            // Push the accumulator onto the VM stack. We claim 16
            // bytes per push so that SP stays 16-byte aligned --
            // any libc call we make later (`Op::Prtf` etc.) needs
            // that, and re-aligning on every call would be a wash.
            emit(code, enc_str_pre(Reg::X19, Reg::SP, -16));
        }

        // ---- Bitwise ----
        Op::Or => binop_with_pop(code, enc_orr_reg, /*reverse=*/ false),
        Op::Xor => binop_with_pop(code, enc_eor_reg, false),
        Op::And => binop_with_pop(code, enc_and_reg, false),

        // ---- Comparisons. The c4 VM does `popped <cmp> a`, which
        //      maps to `cmp x16, x19; cset x19, <cond>`.
        Op::Eq => cmp_with_pop(code, Cond::Eq),
        Op::Ne => cmp_with_pop(code, Cond::Ne),
        Op::Lt => cmp_with_pop(code, Cond::Lt),
        Op::Gt => cmp_with_pop(code, Cond::Gt),
        Op::Le => cmp_with_pop(code, Cond::Le),
        Op::Ge => cmp_with_pop(code, Cond::Ge),

        // ---- Shifts (signed >> matches c4 `int` semantics). ----
        Op::Shl => binop_with_pop(code, enc_lslv, false),
        Op::Shr => binop_with_pop(code, enc_asrv, false),

        // ---- Arithmetic. Sub, Div, Mod are not commutative, so the
        //      pop goes on the LHS of the operation.
        Op::Add => binop_with_pop(code, enc_add_reg, false),
        Op::Sub => binop_with_pop(code, enc_sub_reg, true),
        Op::Mul => binop_with_pop(code, enc_mul, false),
        Op::Div => binop_with_pop(code, enc_sdiv, true),
        Op::Mod => {
            // pop -> x16; x17 = x16 / x19; x19 = x16 - x17 * x19.
            emit(code, enc_ldr_post(Reg::X16, Reg::SP, 16));
            emit(code, enc_sdiv(Reg::X17, Reg::X16, Reg::X19));
            emit(code, enc_msub(Reg::X19, Reg::X17, Reg::X19, Reg::X16));
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
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind: BranchKind::Cbz(Reg::X19),
            });
            emit(code, 0);
        }
        Op::Bnz => {
            let target = read_operand(text, pc, "Bnz")? as usize;
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind: BranchKind::Cbnz(Reg::X19),
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
            emit(code, enc_mov_reg(Reg::X19, Reg::X0));
        }
        Op::Jsri => {
            // Indirect call: target address in x19. Move it to x16
            // before the call so the callee's prologue/epilogue
            // doesn't trample our accumulator slot. After the call,
            // copy x0 back into x19 (same dance as Op::Jsr).
            emit(code, enc_mov_reg(Reg::X16, Reg::X19));
            emit(code, enc_blr(Reg::X16));
            emit(code, enc_mov_reg(Reg::X19, Reg::X0));
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
        Op::EqI => imm_cmp(code, text, pc, "EqI", Cond::Eq)?,
        Op::NeI => imm_cmp(code, text, pc, "NeI", Cond::Ne)?,
        Op::LtI => imm_cmp(code, text, pc, "LtI", Cond::Lt)?,
        Op::GtI => imm_cmp(code, text, pc, "GtI", Cond::Gt)?,
        Op::LeI => imm_cmp(code, text, pc, "LeI", Cond::Le)?,
        Op::GeI => imm_cmp(code, text, pc, "GeI", Cond::Ge)?,
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
        | Op::Mpro
        | Op::Exit
        | Op::Write
        | Op::Genv
        | Op::Senv => emit_libc_call(op, text, *pc, code, got_fixups)?,
    }
    Ok(())
}

/// Lower a syscall op to a libc call. Args were already pushed onto
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
) -> Result<(), C4Error> {
    let import_index = import_index_for_op(op)
        .ok_or_else(|| C4Error::Compile(format!("native codegen: no import index for {op:?}")))?;

    // Peek at the next instruction; if it's Adj N, that gives us the
    // arg count. Op::Exit is the c4-emitted form of `exit(N)` which
    // doesn't have a trailing Adj because exit doesn't return -- treat
    // it as a 1-arg call that we pop manually.
    let arg_count = match Op::from_i64(text.get(pc_after_op).copied().unwrap_or(0)) {
        Some(Op::Adj) => text[pc_after_op + 1] as usize,
        _ if matches!(op, Op::Exit) => 1,
        _ => {
            return Err(C4Error::Compile(format!(
                "native codegen: {op:?} not followed by Adj"
            )));
        }
    };
    if arg_count == 0 || arg_count > 8 {
        return Err(C4Error::Compile(format!(
            "native codegen: {op:?} arg count {arg_count} out of supported range (1..=8)"
        )));
    }

    let is_variadic = matches!(op, Op::Prtf);

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
        emit(code, enc_mov_reg(Reg::X19, Reg::X0));
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

/// Pop the top of the VM stack into `x16`, then combine with `x19`.
/// `reverse = false` -> `x19 = x16 OP x19` (popped is LHS, matches
/// commutative + the c4 VM semantics for sub/div/shifts).
/// `reverse = true` is identical here because every encoder we pass
/// already takes (rd, rn, rm) in (dest, lhs, rhs) order; the flag
/// stays as a structural reminder of which operand is the popped one.
fn binop_with_pop<F: Fn(Reg, Reg, Reg) -> u32>(code: &mut Vec<u8>, enc: F, _reverse: bool) {
    emit(code, enc_ldr_post(Reg::X16, Reg::SP, 16));
    emit(code, enc(Reg::X19, Reg::X16, Reg::X19));
}

/// Pop, compare, and condition-set into `x19`.
fn cmp_with_pop(code: &mut Vec<u8>, cond: Cond) {
    emit(code, enc_ldr_post(Reg::X16, Reg::SP, 16));
    emit(code, enc_cmp_reg(Reg::X16, Reg::X19));
    emit(code, enc_cset(Reg::X19, cond));
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
fn imm_cmp(
    code: &mut Vec<u8>,
    text: &[i64],
    pc: &mut usize,
    name: &str,
    cond: Cond,
) -> Result<(), C4Error> {
    let v = read_operand(text, pc, name)?;
    load_imm64(code, Reg::X16, v as u64);
    emit(code, enc_cmp_reg(Reg::X19, Reg::X16));
    emit(code, enc_cset(Reg::X19, cond));
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
fn emit_prologue(code: &mut Vec<u8>, locals: i64, is_main: bool) {
    if is_main {
        // Push argc first (deeper), then argv (shallower). 16-byte
        // slots so the layout matches the c4 calling convention as
        // [`Op::Psh`] uses it for user-function args.
        emit(code, enc_str_pre(Reg::X0, Reg::SP, -16));
        emit(code, enc_str_pre(Reg::X1, Reg::SP, -16));
    }
    emit(code, enc_stp_pre(Reg::X29, Reg::X30, Reg::SP, -16));
    emit(code, enc_add_imm(Reg::X29, Reg::SP, 0));
    if locals > 0 {
        let bytes = (locals as u32) * 8;
        let aligned = (bytes + 15) & !15;
        emit(code, enc_sub_imm(Reg::SP, Reg::SP, aligned));
    }
}

/// Mirror of [`emit_prologue`]. Move the VM accumulator into `x0`
/// (the return register), tear down the frame, return. For main we
/// also drop the two 16-byte argc/argv slots so the stack pointer is
/// back to what libdyld handed us.
fn emit_epilogue(code: &mut Vec<u8>, is_main: bool) {
    emit(code, enc_mov_reg(Reg::X0, Reg::X19));
    emit(code, enc_add_imm(Reg::SP, Reg::X29, 0));
    emit(code, enc_ldp_post(Reg::X29, Reg::X30, Reg::SP, 16));
    if is_main {
        emit(code, enc_add_imm(Reg::SP, Reg::SP, 32));
    }
    emit(code, enc_ret(Reg::X30));
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

//! x86_64 instruction encoder + bytecode -> x86_64 lowering.
//!
//! M3.2 covers every non-syscall Op (arithmetic, control flow,
//! comparisons, loads/stores, locals, function calls direct and
//! indirect). Syscall ops still error out with a "M3.4 will land
//! libc binding" message; data-segment + function-pointer fixups
//! are M3.3.
//!
//! ## Register convention
//!
//! Mirrors the AArch64 backend's choices, retargeted to x86_64:
//!
//! * `r13` -- VM accumulator (`a` in the bytecode model). Callee-saved
//!   in the System V ABI, so libc calls can't trample it.
//! * `rsp` -- VM stack pointer; we ride on the native stack.
//! * `rbp` -- frame pointer (and the c4 bp).
//! * `rdi/rsi/rdx/rcx/r8/r9` -- argument-passing registers, used at
//!   libc call sites (System V ABI).
//! * `r10/r11` -- caller-saved scratch.

#![allow(dead_code)] // Encoders ahead of lowering coverage.

use alloc::format;
use alloc::vec::Vec;

use super::super::CODE_BASE;
use super::super::error::C4Error;
use super::super::op::Op;
use super::super::program::Program;
use super::{Build, DataFixup, FuncFixup, GotFixup, NativeOptions, Target, TargetOptions, aarch64};

// ------------------------------------------------------------------
// Register encoding.
//
// x86_64 has 16 integer registers numbered 0..16. The low 3 bits go
// into ModR/M.reg / ModR/M.rm / SIB.index / SIB.base; the high bit
// goes into REX.R / REX.B / REX.X. The newtype lets the encoders
// pull both halves uniformly.
// ------------------------------------------------------------------

/// One of the 16 x86_64 GPRs. The byte holds the architectural
/// register number 0..15.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) struct Reg(pub u8);

impl Reg {
    pub const RAX: Reg = Reg(0);
    pub const RCX: Reg = Reg(1);
    pub const RDX: Reg = Reg(2);
    pub const RBX: Reg = Reg(3);
    pub const RSP: Reg = Reg(4);
    pub const RBP: Reg = Reg(5);
    pub const RSI: Reg = Reg(6);
    pub const RDI: Reg = Reg(7);
    pub const R8: Reg = Reg(8);
    pub const R9: Reg = Reg(9);
    pub const R10: Reg = Reg(10);
    pub const R11: Reg = Reg(11);
    pub const R12: Reg = Reg(12);
    /// VM accumulator (callee-saved across libc calls).
    pub const R13: Reg = Reg(13);
    pub const R14: Reg = Reg(14);
    pub const R15: Reg = Reg(15);

    /// Low 3 bits -- the field encoded in ModR/M / SIB.
    pub fn lo(self) -> u8 {
        self.0 & 7
    }

    /// True if the register is one of R8..R15. The high bit is
    /// encoded in REX.R / REX.B / REX.X.
    pub fn high(self) -> bool {
        self.0 >= 8
    }
}

// ------------------------------------------------------------------
// Encoder primitives.
//
// `rex` builds the optional REX prefix; encoders only emit it when
// needed (W=1 for 64-bit operations, R/B/X for R8..R15 register
// access). `modrm` and `sib` are bit-packing helpers; the comments
// give the field layout per the Intel SDM.
// ------------------------------------------------------------------

/// REX prefix byte (`0100WRXB`).
///
/// * `w`: 1 = 64-bit operand size. Required for almost every
///   instruction we use because c4's word size is 64 bits.
/// * `r`: extends `ModR/M.reg` by 1 bit (so registers R8..R15 fit in
///   the 3-bit reg field).
/// * `x`: extends `SIB.index` by 1 bit.
/// * `b`: extends `ModR/M.rm` or `SIB.base` (or the embedded register
///   in opcodes like `MOV r64, imm64` whose `r/m` is implied).
fn rex(w: bool, r: bool, x: bool, b: bool) -> u8 {
    let mut v = 0x40;
    if w {
        v |= 0x08;
    }
    if r {
        v |= 0x04;
    }
    if x {
        v |= 0x02;
    }
    if b {
        v |= 0x01;
    }
    v
}

/// ModR/M byte: `mod` (2 bits) | `reg` (3 bits) | `r/m` (3 bits).
///
/// `mod` selects the addressing form:
///   * `00` -- indirect, no displacement (special: `r/m=101` -> RIP-
///     relative; `r/m=100` -> SIB byte)
///   * `01` -- indirect with 8-bit signed displacement
///   * `10` -- indirect with 32-bit signed displacement
///   * `11` -- register-direct (no memory)
fn modrm(mod_: u8, reg: u8, rm: u8) -> u8 {
    debug_assert!(mod_ < 4, "modrm: mod {mod_} > 3");
    (mod_ << 6) | ((reg & 7) << 3) | (rm & 7)
}

/// SIB byte: `scale` (2 bits) | `index` (3 bits) | `base` (3 bits).
///
/// Used when `ModR/M.r/m == 100` to fold a scaled index, base, and
/// displacement into one effective address.
fn sib(scale: u8, index: u8, base: u8) -> u8 {
    debug_assert!(scale < 4, "sib: scale {scale} > 3");
    (scale << 6) | ((index & 7) << 3) | (base & 7)
}

/// Append a single byte to the code buffer. Wrapper exists for
/// symmetry with [`emit_bytes`]; both funnel through `Vec::push`.
fn emit_byte(code: &mut Vec<u8>, b: u8) {
    code.push(b);
}

/// Append a slice of bytes to the code buffer.
fn emit_bytes(code: &mut Vec<u8>, bs: &[u8]) {
    code.extend_from_slice(bs);
}

/// Append a little-endian u32.
fn emit_u32(code: &mut Vec<u8>, v: u32) {
    code.extend_from_slice(&v.to_le_bytes());
}

/// Append a little-endian i32.
fn emit_i32(code: &mut Vec<u8>, v: i32) {
    code.extend_from_slice(&v.to_le_bytes());
}

/// Append a little-endian i64.
fn emit_i64(code: &mut Vec<u8>, v: i64) {
    code.extend_from_slice(&v.to_le_bytes());
}

// ------------------------------------------------------------------
// Instruction encoders.
//
// Each `emit_*` writes the instruction's bytes into `code`. Names
// match Intel mnemonics. Cross-checked against `clang -c` +
// `objdump -d` on x86_64 -- if you change a constant, run that trip
// and confirm.
// ------------------------------------------------------------------

/// `MOV r64, r64` -- register-to-register move.
/// Encoding: `REX.W + 89 /r` with ModR/M.reg = src, r/m = dst.
pub(super) fn emit_mov_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, rex(true, src.high(), false, dst.high()));
    emit_byte(code, 0x89);
    emit_byte(code, modrm(0b11, src.lo(), dst.lo()));
}

/// `MOV r64, imm64` -- 10-byte absolute load.
/// Encoding: `REX.W + B8+rd io` -- the register goes into the low 3
/// bits of the opcode byte (REX.B carries the high bit).
pub(super) fn emit_mov_r_imm64(code: &mut Vec<u8>, dst: Reg, imm: i64) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xB8 | dst.lo());
    emit_i64(code, imm);
}

/// `PUSH r64`. Encoding: `50+rd`, plus REX.B if `dst` is R8..R15.
pub(super) fn emit_push_r(code: &mut Vec<u8>, r: Reg) {
    if r.high() {
        emit_byte(code, rex(false, false, false, true));
    }
    emit_byte(code, 0x50 | r.lo());
}

/// `POP r64`. Encoding: `58+rd`, plus REX.B if `dst` is R8..R15.
pub(super) fn emit_pop_r(code: &mut Vec<u8>, r: Reg) {
    if r.high() {
        emit_byte(code, rex(false, false, false, true));
    }
    emit_byte(code, 0x58 | r.lo());
}

/// `RET`. The near-return form, no operand.
pub(super) fn emit_ret(code: &mut Vec<u8>) {
    emit_byte(code, 0xC3);
}

/// `SYSCALL`. Linux x86_64 syscall entry; nr in `rax`, args in
/// `rdi/rsi/rdx/r10/r8/r9`, return in `rax`.
pub(super) fn emit_syscall(code: &mut Vec<u8>) {
    emit_bytes(code, &[0x0F, 0x05]);
}

/// `MOV r64, [base + disp]` -- 64-bit memory load.
/// Encoding: `REX.W + 8B /r` with the addressing form chosen by
/// `disp`'s magnitude. Handles `[rsp + disp]` (which always needs a
/// SIB byte) and `[rbp + disp]` (which always needs `mod >= 01`).
pub(super) fn emit_mov_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, 0x8B);
    emit_modrm_mem(code, dst, base, disp);
}

/// `MOV [base + disp], r64` -- 64-bit memory store.
/// Encoding: `REX.W + 89 /r`.
pub(super) fn emit_mov_mem_r(code: &mut Vec<u8>, base: Reg, disp: i32, src: Reg) {
    emit_byte(code, rex(true, src.high(), false, base.high()));
    emit_byte(code, 0x89);
    emit_modrm_mem(code, src, base, disp);
}

/// `LEA r64, [base + disp]` -- compute effective address.
/// Encoding: `REX.W + 8D /r`.
pub(super) fn emit_lea_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, 0x8D);
    emit_modrm_mem(code, dst, base, disp);
}

/// `LEA r64, [rip + disp32]` -- the RIP-relative addressing form
/// (mod=00, r/m=101). 7 bytes total. The writer patches `disp32`
/// after layout to point at a data-segment address or another
/// function inside the code blob.
pub(super) fn emit_lea_r_rip32(code: &mut Vec<u8>, dst: Reg, disp32: i32) {
    emit_byte(code, rex(true, dst.high(), false, false));
    emit_byte(code, 0x8D);
    // mod=00, reg=dst.lo(), r/m=101 -- the magic "RIP-relative"
    // r/m encoding under mod=00.
    emit_byte(code, modrm(0b00, dst.lo(), 0b101));
    emit_i32(code, disp32);
}

/// Byte length of [`emit_lea_r_rip32`]. The writer needs this to
/// compute the RIP that the disp32 is measured from (i.e. the byte
/// just after the lea, which is `instr_offset + LEA_RIP32_LEN`).
pub(super) const LEA_RIP32_LEN: usize = 7;

/// `CALL rel32`. The 5-byte direct-call form. `rel32` is a signed
/// 32-bit displacement from the byte *after* the instruction.
pub(super) fn emit_call_rel32(code: &mut Vec<u8>, rel32: i32) {
    emit_byte(code, 0xE8);
    emit_i32(code, rel32);
}

/// `SUB rsp, imm32`. Used by the function prologue to reserve local
/// stack space. Encoding: `REX.W + 81 /5 id`.
pub(super) fn emit_sub_rsp_imm32(code: &mut Vec<u8>, imm: u32) {
    emit_byte(code, rex(true, false, false, false));
    emit_byte(code, 0x81);
    // `/5` means ModR/M.reg = 5 (the opcode-extension digit for
    // `SUB`). r/m = rsp(4) and mod = 11 (register-direct).
    emit_byte(code, modrm(0b11, 5, Reg::RSP.lo()));
    emit_u32(code, imm);
}

/// `ADD rsp, imm32`. Used by epilogue / Adj. Encoding: `REX.W + 81
/// /0 id`.
pub(super) fn emit_add_rsp_imm32(code: &mut Vec<u8>, imm: u32) {
    emit_byte(code, rex(true, false, false, false));
    emit_byte(code, 0x81);
    emit_byte(code, modrm(0b11, 0, Reg::RSP.lo()));
    emit_u32(code, imm);
}

// ---- Two-register integer ALU. The `r/m, r` family of opcodes:
//      ADD=01 SUB=29 AND=21 OR=09 XOR=31 CMP=39. ModR/M.reg=src,
//      r/m=dst.

/// `ADD dst, src` -- 64-bit, `dst += src`.
pub(super) fn emit_add_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x01, dst, src);
}

/// `SUB dst, src` -- 64-bit, `dst -= src`.
pub(super) fn emit_sub_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x29, dst, src);
}

/// `AND dst, src` -- 64-bit, `dst &= src`.
pub(super) fn emit_and_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x21, dst, src);
}

/// `OR dst, src` -- 64-bit, `dst |= src`.
pub(super) fn emit_or_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x09, dst, src);
}

/// `XOR dst, src` -- 64-bit, `dst ^= src`.
pub(super) fn emit_xor_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x31, dst, src);
}

/// `CMP dst, src` -- 64-bit; sets flags = `dst - src` without storing.
pub(super) fn emit_cmp_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x39, dst, src);
}

fn emit_alu_rr(code: &mut Vec<u8>, opcode: u8, dst: Reg, src: Reg) {
    emit_byte(code, rex(true, src.high(), false, dst.high()));
    emit_byte(code, opcode);
    emit_byte(code, modrm(0b11, src.lo(), dst.lo()));
}

/// `IMUL dst, src` -- two-operand signed multiply, `dst = dst * src`.
/// Encoding: `REX.W + 0F AF /r`.
pub(super) fn emit_imul_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, rex(true, dst.high(), false, src.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xAF);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `IDIV r/m64` -- signed divide `rdx:rax / r`. Quotient -> rax,
/// remainder -> rdx. The caller must sign-extend rax into rdx with
/// [`emit_cqo`] first.
pub(super) fn emit_idiv_r(code: &mut Vec<u8>, divisor: Reg) {
    emit_byte(code, rex(true, false, false, divisor.high()));
    emit_byte(code, 0xF7);
    emit_byte(code, modrm(0b11, 7, divisor.lo()));
}

/// `CQO` (`CDQE` for 32-bit; we want the 64-bit form) -- sign-extend
/// rax into rdx:rax. Encoding: `REX.W + 99`.
pub(super) fn emit_cqo(code: &mut Vec<u8>) {
    emit_byte(code, rex(true, false, false, false));
    emit_byte(code, 0x99);
}

// ---- Shifts. The `D3` opcode shifts by `cl`; `C1` shifts by an
//      8-bit immediate. We expose both forms because the optimizer
//      emits constant-shift IR ops (`ShlI N`, `ShrI N`) that benefit
//      from the immediate path.

/// `SHL r/m64, cl`. ModR/M.reg = 4. `cl` is implicit.
pub(super) fn emit_shl_r_cl(code: &mut Vec<u8>, dst: Reg) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xD3);
    emit_byte(code, modrm(0b11, 4, dst.lo()));
}

/// `SAR r/m64, cl` -- arithmetic right shift (signed; sign bit
/// replicates). ModR/M.reg = 7.
pub(super) fn emit_sar_r_cl(code: &mut Vec<u8>, dst: Reg) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xD3);
    emit_byte(code, modrm(0b11, 7, dst.lo()));
}

/// `SHL r/m64, imm8`. ModR/M.reg = 4, imm at end.
pub(super) fn emit_shl_r_imm8(code: &mut Vec<u8>, dst: Reg, imm: u8) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xC1);
    emit_byte(code, modrm(0b11, 4, dst.lo()));
    emit_byte(code, imm);
}

/// `SAR r/m64, imm8`. ModR/M.reg = 7, imm at end.
pub(super) fn emit_sar_r_imm8(code: &mut Vec<u8>, dst: Reg, imm: u8) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xC1);
    emit_byte(code, modrm(0b11, 7, dst.lo()));
    emit_byte(code, imm);
}

// ---- Immediate-form ALU. `ADD r/m64, imm32` / `SUB r/m64, imm32`,
//      etc. All share opcode `81` with a different /N digit.

fn emit_alu_r_imm32(code: &mut Vec<u8>, digit: u8, dst: Reg, imm: i32) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0x81);
    emit_byte(code, modrm(0b11, digit, dst.lo()));
    emit_i32(code, imm);
}

/// `ADD r64, imm32` -- 32-bit immediate, sign-extended to 64.
pub(super) fn emit_add_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 0, dst, imm);
}

/// `SUB r64, imm32`.
pub(super) fn emit_sub_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 5, dst, imm);
}

/// `AND r64, imm32`.
pub(super) fn emit_and_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 4, dst, imm);
}

/// `OR r64, imm32`.
pub(super) fn emit_or_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 1, dst, imm);
}

/// `XOR r64, imm32`.
pub(super) fn emit_xor_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 6, dst, imm);
}

/// `CMP r64, imm32` -- sets flags = `dst - imm`.
pub(super) fn emit_cmp_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 7, dst, imm);
}

// ---- 8-bit memory + setcc. Used for `Op::Lc` / `Op::Sc` and for
//      the comparison ops that produce 0/1 in the low byte.

/// Condition codes for `Jcc` and `setcc`. Values match Intel's CC
/// encoding so the opcode byte for `Jcc` is `0F 8X+cc` and for
/// `setcc` it is `0F 9X+cc`.
#[derive(Debug, Clone, Copy)]
pub(super) enum Cc {
    /// Equal / zero.
    E = 0x4,
    /// Not equal.
    Ne = 0x5,
    /// Less than (signed).
    L = 0xC,
    /// Greater than (signed).
    G = 0xF,
    /// Less than or equal (signed).
    Le = 0xE,
    /// Greater than or equal (signed).
    Ge = 0xD,
}

/// `SETcc r/m8` -- write byte = 1 if condition holds, else 0. The
/// upper bits of the destination are *not* zeroed -- the caller is
/// expected to zero the register first (we use `xor r, r`).
pub(super) fn emit_setcc_r8(code: &mut Vec<u8>, cc: Cc, dst: Reg) {
    // SET<cc> r/m8 needs a REX prefix to address SPL/BPL/SIL/DIL or
    // R8B..R15B; using REX with the low GPRs disables the
    // AH/CH/DH/BH high-byte aliases, which is exactly what we want.
    emit_byte(code, rex(false, false, false, dst.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0x90 | (cc as u8));
    emit_byte(code, modrm(0b11, 0, dst.lo()));
}

/// `MOVZX r64, byte ptr [base + disp]` -- load a byte zero-extended
/// into a 64-bit register. Encoding: `REX.W + 0F B6 /r`.
pub(super) fn emit_movzx_r_mem8(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xB6);
    emit_modrm_mem(code, dst, base, disp);
}

/// `MOVZX r64, r/m8` -- zero-extend a byte register into a 64-bit
/// register. Encoding: `REX.W + 0F B6 /r` with `mod=11`. The REX
/// prefix also disables the AH/CH/DH/BH high-byte aliases so we
/// can treat any of the 16 GPRs as an 8-bit source.
pub(super) fn emit_movzx_r_r8(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, rex(true, dst.high(), false, src.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xB6);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `MOV byte ptr [base + disp], r8` -- store the low byte of `src`.
/// Encoding: `MOV r/m8, r8` = `88 /r`. REX is mandatory when storing
/// from one of the upper or new low-byte registers.
pub(super) fn emit_mov_mem8_r(code: &mut Vec<u8>, base: Reg, disp: i32, src: Reg) {
    emit_byte(code, rex(false, src.high(), false, base.high()));
    emit_byte(code, 0x88);
    emit_modrm_mem(code, src, base, disp);
}

// ---- Branches. All forms encode the displacement relative to the
//      *byte after* the instruction. `JMP rel32` is 5 bytes; `Jcc
//      rel32` is 6.

/// `JMP rel32` -- unconditional branch, 5 bytes.
pub(super) fn emit_jmp_rel32(code: &mut Vec<u8>, rel32: i32) {
    emit_byte(code, 0xE9);
    emit_i32(code, rel32);
}

/// `Jcc rel32` -- conditional branch, 6 bytes.
pub(super) fn emit_jcc_rel32(code: &mut Vec<u8>, cc: Cc, rel32: i32) {
    emit_byte(code, 0x0F);
    emit_byte(code, 0x80 | (cc as u8));
    emit_i32(code, rel32);
}

/// `CALL r64` -- indirect call through a register. Encoding:
/// `FF /2`.
pub(super) fn emit_call_r(code: &mut Vec<u8>, target: Reg) {
    if target.high() {
        emit_byte(code, rex(false, false, false, true));
    }
    emit_byte(code, 0xFF);
    emit_byte(code, modrm(0b11, 2, target.lo()));
}

/// `CALL qword ptr [rip + disp32]` -- PC-relative indirect call
/// through a memory operand. Encoding: `FF /2` with ModR/M
/// `mod=00 reg=2 r/m=101` (the magic "RIP-relative" encoding under
/// mod=00) + disp32. 6 bytes total. Used for GOT calls on Linux
/// x86_64; the writer patches `disp32` so the load points at the
/// right `.got` slot.
pub(super) fn emit_call_qword_rip32(code: &mut Vec<u8>, disp32: i32) {
    emit_byte(code, 0xFF);
    emit_byte(code, modrm(0b00, 2, 0b101));
    emit_i32(code, disp32);
}

/// Byte length of [`emit_call_qword_rip32`]. Used by the writer to
/// compute the `disp32` measurement origin (just after the call).
pub(super) const CALL_QWORD_RIP32_LEN: usize = 6;

/// `XOR eax, eax` -- 32-bit form, zero-extends to 64 (sets rax = 0).
/// Used as the System V variadic-ABI "no XMM args" marker before
/// printf-shape calls: AL must be 0 going in.
pub(super) fn emit_xor_eax_eax(code: &mut Vec<u8>) {
    emit_byte(code, 0x31);
    emit_byte(code, 0xC0);
}

// ------------------------------------------------------------------
// ModR/M + SIB + displacement encoding for memory operands.
//
// Three special cases drive most of the complexity:
//   * `r/m == 100` (rsp / r12) always means "SIB byte follows", so
//     [rsp+disp] requires a SIB even with disp == 0.
//   * `r/m == 101` (rbp / r13) at mod=00 means "RIP-relative", so
//     [rbp+0] / [r13+0] must use mod=01 with disp8=0.
//   * Otherwise mod is picked by displacement magnitude: 0 for
//     mod=00, fits-in-i8 for mod=01, full 32-bit for mod=10.
// ------------------------------------------------------------------

fn emit_modrm_mem(code: &mut Vec<u8>, reg: Reg, base: Reg, disp: i32) {
    let needs_sib = base.lo() == 4; // rsp or r12
    let bp_form = base.lo() == 5; // rbp or r13 -- mod=00 is RIP-rel, must use mod=01
    let (mod_, want_disp8, want_disp32) = if disp == 0 && !bp_form {
        (0b00, false, false)
    } else if (-128..=127).contains(&disp) {
        (0b01, true, false)
    } else {
        (0b10, false, true)
    };
    emit_byte(code, modrm(mod_, reg.lo(), base.lo()));
    if needs_sib {
        // scale=0, index=100 (none), base=base.lo()
        emit_byte(code, sib(0, 4, base.lo()));
    }
    if want_disp8 {
        emit_byte(code, disp as i8 as u8);
    } else if want_disp32 {
        emit_i32(code, disp);
    }
}

// ------------------------------------------------------------------
// `_start` stub.
//
// Linux x86_64 process startup hands control to `e_entry` with `rsp`
// pointing at argc:
//   [rsp + 0]  : argc
//   [rsp + 8]  : argv[0]
//   [rsp + 16] : argv[1]
//   ...
//
// We load argc/argv into rdi/rsi, call main, then call libc `exit`
// through the GOT so atexit hooks and stdio flushing run -- without
// that, printf("...\n") to a pipe loses output because glibc
// block-buffers non-tty stdout.
// ------------------------------------------------------------------

/// Length of the `_start` stub in bytes. Used by the ELF writer to
/// compute branch offsets and segment sizes.
pub(super) const START_STUB_LEN: u64 = 23;

/// Emit the `_start` prologue. Returns the byte offset (within the
/// emitted code blob) of the `call qword [rip+...]` placeholder for
/// libc `exit` -- the writer registers a GotFixup against it.
pub(super) fn emit_start_stub(code: &mut Vec<u8>, main_offset_in_code: u64) -> usize {
    let stub_start = code.len();

    // mov rdi, [rsp]            -- argc into 1st arg register
    emit_mov_r_mem(code, Reg::RDI, Reg::RSP, 0);
    // lea rsi, [rsp + 8]        -- argv into 2nd arg register
    emit_lea_r_mem(code, Reg::RSI, Reg::RSP, 8);

    // call main. Target byte offset (within the code blob) is
    // START_STUB_LEN + main_offset_in_code; the rel32 for `call` is
    // measured from the byte *after* the 5-byte `call` instruction.
    let call_byte_off = (code.len() - stub_start) as i64;
    let after_call = call_byte_off + 5;
    let main_byte = (START_STUB_LEN as i64) + main_offset_in_code as i64;
    let rel32 = (main_byte - after_call) as i32;
    emit_call_rel32(code, rel32);

    // mov rdi, rax              -- pass main's return value into
    //                              libc `exit`'s first arg.
    emit_mov_rr(code, Reg::RDI, Reg::RAX);

    // call qword [rip + disp32] -- placeholder, writer patches the
    // disp32 to point at the libc `exit` GOT slot.
    let exit_call_offset = code.len() - stub_start;
    emit_call_qword_rip32(code, 0);

    debug_assert_eq!(
        (code.len() - stub_start) as u64,
        START_STUB_LEN,
        "_start stub length mismatch"
    );
    stub_start + exit_call_offset
}

// ------------------------------------------------------------------
// Branch fixups. Bytecode branches target absolute bytecode PCs, but
// the native PC of those targets isn't known until the whole function
// body is laid out. Two-pass approach mirrors aarch64.rs: emit a
// 5-byte (jmp / call) or 6-byte (jcc) placeholder, record (offset,
// target bc PC, kind), patch after the walk.
// ------------------------------------------------------------------

#[derive(Debug, Clone, Copy)]
enum BranchKind {
    Jmp,
    Jcc(Cc),
    Call,
}

#[derive(Debug, Clone, Copy)]
struct Fixup {
    /// Byte offset within `code` of the placeholder's first byte.
    native_offset: usize,
    target_bytecode_pc: usize,
    kind: BranchKind,
}

/// Translate a c4 `Op::Lea` offset (in 8-byte VM-slot units) into
/// the matching native byte offset from rbp. Same convention as the
/// aarch64 backend: locals (val < 2) keep `* 8`; args (val >= 2)
/// switch to `* 16` because Op::Psh writes 16-byte slots so SP stays
/// aligned at libc-call sites.
fn lea_offset_bytes(offset: i64) -> i64 {
    if offset >= 2 {
        (offset - 1) * 16
    } else {
        offset * 8
    }
}

// ------------------------------------------------------------------
// Lowering pass. Walks the bytecode once, emits native code per Op,
// records branch fixups for later patching. Mirrors aarch64::lower.
// ------------------------------------------------------------------

pub(super) fn lower(
    program: &Program,
    target: Target,
    native: NativeOptions,
) -> Result<Build, C4Error> {
    // See the same comment in `aarch64::lower`. N5 wires `native`
    // up to the register-pool lowering; for now we accept it for
    // symmetry and ignore it.
    let _ = native;
    let _options: TargetOptions = target.options();

    let mut code: Vec<u8> = Vec::new();
    let mut bytecode_to_native: Vec<usize> = alloc::vec![usize::MAX; program.text.len() + 1];
    let mut fixups: Vec<Fixup> = Vec::new();
    let mut data_fixups: Vec<DataFixup> = Vec::new();
    let mut got_fixups: Vec<GotFixup> = Vec::new();
    // Function-pointer Imms get their target resolved post-walk
    // against `bytecode_to_native`, mirroring aarch64::lower.
    let mut pending_func_fixups: Vec<(usize, usize)> = Vec::new();
    let data_imm_positions: &[usize] = &program.data_imm_positions;

    let mut in_main = false;
    let mut pc = 0usize;
    while pc < program.text.len() {
        let op_pc = pc;
        bytecode_to_native[op_pc] = code.len();
        let raw = program.text[pc];
        let op = Op::from_i64(raw).ok_or_else(|| {
            C4Error::Compile(format!(
                "native codegen (x86_64): bad opcode at PC {pc}: {raw}"
            ))
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
            &mut data_fixups,
            &mut got_fixups,
            &mut pending_func_fixups,
            data_imm_positions,
            in_main,
        )?;
    }
    bytecode_to_native[program.text.len()] = code.len();

    apply_fixups(&mut code, &fixups, &bytecode_to_native, program.text.len())?;

    // Resolve pending function-pointer fixups now that the bc-to-
    // native map is complete.
    let mut func_fixups: Vec<FuncFixup> = Vec::with_capacity(pending_func_fixups.len());
    for (instr_offset, target_bc_pc) in pending_func_fixups {
        if target_bc_pc > program.text.len() {
            return Err(C4Error::Compile(format!(
                "native codegen (x86_64): function pointer target {target_bc_pc} past end of bytecode"
            )));
        }
        let target = bytecode_to_native[target_bc_pc];
        if target == usize::MAX {
            return Err(C4Error::Compile(format!(
                "native codegen (x86_64): function pointer target {target_bc_pc} did not land on an instruction"
            )));
        }
        func_fixups.push(FuncFixup {
            adrp_offset: instr_offset,
            target_native_offset: target,
        });
    }

    let entry_offset = bytecode_to_native
        .get(program.entry_pc)
        .copied()
        .unwrap_or(usize::MAX);
    if entry_offset == usize::MAX {
        return Err(C4Error::Compile(format!(
            "native codegen (x86_64): entry_pc {} did not align with any instruction start",
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

fn apply_fixups(
    code: &mut [u8],
    fixups: &[Fixup],
    bc_to_native: &[usize],
    bc_len: usize,
) -> Result<(), C4Error> {
    for f in fixups {
        if f.target_bytecode_pc > bc_len {
            return Err(C4Error::Compile(format!(
                "native codegen (x86_64): branch target {} past end of bytecode",
                f.target_bytecode_pc
            )));
        }
        let target = bc_to_native[f.target_bytecode_pc];
        if target == usize::MAX {
            return Err(C4Error::Compile(format!(
                "native codegen (x86_64): branch target {} did not land on an instruction",
                f.target_bytecode_pc
            )));
        }
        // The rel32 displacement is computed from the byte *after*
        // the placeholder. Layouts:
        //   JMP rel32:  E9 dd dd dd dd        (5 bytes, rel32 at +1)
        //   Jcc rel32:  0F 8x dd dd dd dd     (6 bytes, rel32 at +2)
        //   CALL rel32: E8 dd dd dd dd        (5 bytes, rel32 at +1)
        let (placeholder_len, rel32_offset) = match f.kind {
            BranchKind::Jmp => (5usize, 1usize),
            BranchKind::Jcc(_) => (6usize, 2usize),
            BranchKind::Call => (5usize, 1usize),
        };
        let after = (f.native_offset + placeholder_len) as i64;
        let rel32 = (target as i64 - after) as i32;
        let lo = f.native_offset + rel32_offset;
        code[lo..lo + 4].copy_from_slice(&rel32.to_le_bytes());
    }
    Ok(())
}

#[allow(clippy::too_many_arguments)]
fn lower_op(
    op: Op,
    text: &[i64],
    pc: &mut usize,
    code: &mut Vec<u8>,
    fixups: &mut Vec<Fixup>,
    data_fixups: &mut Vec<DataFixup>,
    got_fixups: &mut Vec<GotFixup>,
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
            // Drop N pushed slots (16 bytes each, matching Op::Psh).
            let n = read_operand(text, pc, "Adj")?;
            if n != 0 {
                emit_add_rsp_imm32(code, (n as u32) * 16);
            }
        }

        // ---- Constants and addresses ----
        Op::Imm => {
            // The operand sits at `*pc` *before* read_operand bumps
            // it; the side-channel uses that index.
            let operand_pc = *pc;
            let v = read_operand(text, pc, "Imm")?;
            if data_imm_positions.binary_search(&operand_pc).is_ok() {
                // Address of a string literal or global: emit
                // `lea r13, [rip + 0]` placeholder, record the data
                // offset for the writer to patch.
                let instr_offset = code.len();
                data_fixups.push(DataFixup {
                    adrp_offset: instr_offset,
                    data_offset: v as u64,
                });
                emit_lea_r_rip32(code, Reg::R13, 0);
            } else if (v as usize) >= CODE_BASE && ((v as usize) - CODE_BASE) < text.len() {
                // Function-pointer literal. Resolve the target
                // bytecode PC to a native offset post-walk.
                let target_bc_pc = (v as usize) - CODE_BASE;
                let instr_offset = code.len();
                pending_func_fixups.push((instr_offset, target_bc_pc));
                emit_lea_r_rip32(code, Reg::R13, 0);
            } else {
                emit_mov_r_imm64(code, Reg::R13, v);
            }
        }
        Op::Lea => {
            // a = bp + lea_offset_bytes(off). lea r13, [rbp + N].
            let off = read_operand(text, pc, "Lea")?;
            let bytes = lea_offset_bytes(off) as i32;
            emit_lea_r_mem(code, Reg::R13, Reg::RBP, bytes);
        }

        // ---- Memory loads / stores ----
        Op::Li => {
            // r13 = *(i64*)r13. r13 is the BP-aliased register, so
            // emit_modrm_mem encodes [r13] as mod=01 disp8=0.
            emit_mov_r_mem(code, Reg::R13, Reg::R13, 0);
        }
        Op::Lc => emit_movzx_r_mem8(code, Reg::R13, Reg::R13, 0),
        Op::Si => {
            pop_into(code, Reg::R10);
            emit_mov_mem_r(code, Reg::R10, 0, Reg::R13);
        }
        Op::Sc => {
            pop_into(code, Reg::R10);
            emit_mov_mem8_r(code, Reg::R10, 0, Reg::R13);
        }
        Op::Psh => {
            // Push r13 onto the VM stack in a 16-byte slot. We claim
            // 16 bytes per push so rsp stays 16-byte aligned across
            // any libc call we might issue later.
            emit_sub_rsp_imm32(code, 16);
            emit_mov_mem_r(code, Reg::RSP, 0, Reg::R13);
        }

        // ---- Bitwise + arithmetic. The c4 VM does `popped <op> a`
        //      with the popped value as LHS. On x86_64: pop into r10,
        //      perform `r10 op= r13`, mov r10 -> r13 to update the
        //      accumulator.
        Op::Or => binop_with_pop(code, emit_or_rr),
        Op::Xor => binop_with_pop(code, emit_xor_rr),
        Op::And => binop_with_pop(code, emit_and_rr),
        Op::Add => binop_with_pop(code, emit_add_rr),
        Op::Sub => binop_with_pop(code, emit_sub_rr),
        Op::Mul => binop_with_pop(code, emit_imul_rr),

        // ---- Comparisons. cmp popped, r13 sets flags so the cc
        //      reflects `popped <cmp> r13`. Then xor r13d, r13d to
        //      zero the result, and setcc r13b for the 0/1 byte.
        Op::Eq => cmp_with_pop(code, Cc::E),
        Op::Ne => cmp_with_pop(code, Cc::Ne),
        Op::Lt => cmp_with_pop(code, Cc::L),
        Op::Gt => cmp_with_pop(code, Cc::G),
        Op::Le => cmp_with_pop(code, Cc::Le),
        Op::Ge => cmp_with_pop(code, Cc::Ge),

        // ---- Shifts. Pop into r10, shift r10 by cl (=r13 lo byte),
        //      then move r10 back into r13.
        Op::Shl => shift_with_pop(code, /*arithmetic=*/ false),
        Op::Shr => shift_with_pop(code, /*arithmetic=*/ true),

        Op::Div => div_or_mod_with_pop(code, /*want_remainder=*/ false),
        Op::Mod => div_or_mod_with_pop(code, /*want_remainder=*/ true),

        // ---- Control flow ----
        Op::Jmp => {
            let target = read_operand(text, pc, "Jmp")? as usize;
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind: BranchKind::Jmp,
            });
            emit_jmp_rel32(code, 0);
        }
        Op::Bz => {
            emit_cmp_r_imm32(code, Reg::R13, 0);
            let target = read_operand(text, pc, "Bz")? as usize;
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind: BranchKind::Jcc(Cc::E),
            });
            emit_jcc_rel32(code, Cc::E, 0);
        }
        Op::Bnz => {
            emit_cmp_r_imm32(code, Reg::R13, 0);
            let target = read_operand(text, pc, "Bnz")? as usize;
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind: BranchKind::Jcc(Cc::Ne),
            });
            emit_jcc_rel32(code, Cc::Ne, 0);
        }
        Op::Jsr => {
            let target = read_operand(text, pc, "Jsr")? as usize;
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind: BranchKind::Call,
            });
            emit_call_rel32(code, 0);
            // Callee returned with rax = result; copy into the
            // accumulator.
            emit_mov_rr(code, Reg::R13, Reg::RAX);
        }
        Op::Jsri => {
            // Indirect call: target in r13, args already pushed onto
            // the VM stack in 16-byte slots. As on aarch64, peek for
            // an Op::Adj N and load args into rdi..r9 *in addition
            // to* leaving them on the stack -- c4 callees ignore the
            // registers; libc / dlsym'd callees expect them per
            // System V ABI.
            let nargs = match Op::from_i64(text.get(*pc).copied().unwrap_or(0)) {
                Some(Op::Adj) => text[*pc + 1] as usize,
                _ => 0,
            };
            if nargs > 6 {
                return Err(C4Error::Compile(format!(
                    "native codegen (x86_64): Jsri arg count {nargs} exceeds 6 (rdi..r9)"
                )));
            }
            let arg_regs = [Reg::RDI, Reg::RSI, Reg::RDX, Reg::RCX, Reg::R8, Reg::R9];
            for (i, &r) in arg_regs.iter().take(nargs).enumerate() {
                let off = ((nargs - 1 - i) as i32) * 16;
                emit_mov_r_mem(code, r, Reg::RSP, off);
            }
            // Move r13 into r10 so the callee doesn't trample it.
            emit_mov_rr(code, Reg::R10, Reg::R13);
            emit_call_r(code, Reg::R10);
            emit_mov_rr(code, Reg::R13, Reg::RAX);
        }

        // ---- Immediate-form ALU (optimizer-emitted). Each takes
        //      one operand and folds with the accumulator.
        Op::AddI => {
            let n = read_operand(text, pc, "AddI")? as i32;
            emit_add_r_imm32(code, Reg::R13, n);
        }
        Op::SubI => {
            let n = read_operand(text, pc, "SubI")? as i32;
            emit_sub_r_imm32(code, Reg::R13, n);
        }
        Op::AndI => {
            let n = read_operand(text, pc, "AndI")? as i32;
            emit_and_r_imm32(code, Reg::R13, n);
        }
        Op::OrI => {
            let n = read_operand(text, pc, "OrI")? as i32;
            emit_or_r_imm32(code, Reg::R13, n);
        }
        Op::XorI => {
            let n = read_operand(text, pc, "XorI")? as i32;
            emit_xor_r_imm32(code, Reg::R13, n);
        }
        Op::MulI => {
            // `imul r64, r/m64, imm32` -- 3-operand form; let dst
            // and src both be r13. Encoding: REX.W + 69 /r id.
            let n = read_operand(text, pc, "MulI")? as i32;
            emit_byte(code, rex(true, Reg::R13.high(), false, Reg::R13.high()));
            emit_byte(code, 0x69);
            emit_byte(code, modrm(0b11, Reg::R13.lo(), Reg::R13.lo()));
            emit_i32(code, n);
        }
        Op::ShlI => {
            let n = read_operand(text, pc, "ShlI")? as u32;
            emit_shl_r_imm8(code, Reg::R13, (n & 0x3f) as u8);
        }
        Op::ShrI => {
            let n = read_operand(text, pc, "ShrI")? as u32;
            emit_sar_r_imm8(code, Reg::R13, (n & 0x3f) as u8);
        }
        Op::EqI => imm_cmp(code, text, pc, "EqI", Cc::E)?,
        Op::NeI => imm_cmp(code, text, pc, "NeI", Cc::Ne)?,
        Op::LtI => imm_cmp(code, text, pc, "LtI", Cc::L)?,
        Op::GtI => imm_cmp(code, text, pc, "GtI", Cc::G)?,
        Op::LeI => imm_cmp(code, text, pc, "LeI", Cc::Le)?,
        Op::GeI => imm_cmp(code, text, pc, "GeI", Cc::Ge)?,
        Op::LdLocI => {
            let off = read_operand(text, pc, "LdLocI")?;
            let bytes = lea_offset_bytes(off) as i32;
            emit_mov_r_mem(code, Reg::R13, Reg::RBP, bytes);
        }
        Op::LdLocC => {
            let off = read_operand(text, pc, "LdLocC")?;
            let bytes = lea_offset_bytes(off) as i32;
            emit_movzx_r_mem8(code, Reg::R13, Reg::RBP, bytes);
        }

        // ---- Syscalls -- routed through the GOT. The codegen
        //      records a GotFixup at the call site; the ELF writer
        //      patches the disp32 to point at the right .got slot.
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
        | Op::Senv
        | Op::Dlop
        | Op::Dlsm
        | Op::Dlcl
        | Op::Dler => emit_libc_call(op, text, *pc, code, got_fixups)?,
    }
    Ok(())
}

/// Lower a syscall op to a libc call through the GOT. The caller
/// pushed args onto the VM stack in 16-byte slots; we peek (don't
/// pop) to load them into rdi..r9 per the System V ABI. The c4
/// emitter follows every libc call with `Op::Adj N` which the next
/// loop iteration lowers to `add rsp, N*16` to drop the args.
///
/// Variadic functions (printf) on Linux/x86_64 follow standard
/// AAPCS-style register-passing for integer args (no special stack
/// packing like macOS arm64 needs); the only extra requirement is
/// `al = 0` to indicate "no XMM regs used", which we set
/// unconditionally before the call.
fn emit_libc_call(
    op: Op,
    text: &[i64],
    pc_after_op: usize,
    code: &mut Vec<u8>,
    got_fixups: &mut Vec<GotFixup>,
) -> Result<(), C4Error> {
    let import_index = aarch64::IMPORTS
        .iter()
        .position(|imp| imp.op == op)
        .ok_or_else(|| {
            C4Error::Compile(format!(
                "native codegen (x86_64): no import index for {op:?}"
            ))
        })?;

    // Peek for the trailing Op::Adj N; Op::Exit and Op::Dler are
    // emitted without one (Exit doesn't return; Dler takes 0 args).
    let arg_count = match Op::from_i64(text.get(pc_after_op).copied().unwrap_or(0)) {
        Some(Op::Adj) => text[pc_after_op + 1] as usize,
        _ if matches!(op, Op::Exit) => 1,
        _ if matches!(op, Op::Dler) => 0,
        _ => {
            return Err(C4Error::Compile(format!(
                "native codegen (x86_64): {op:?} not followed by Adj"
            )));
        }
    };
    if arg_count > 6 {
        return Err(C4Error::Compile(format!(
            "native codegen (x86_64): {op:?} arg count {arg_count} out of supported range (0..=6)"
        )));
    }

    // Load args into rdi..r9. c4-arg-K is at sp + (arg_count-1-K)*16.
    let arg_regs = [Reg::RDI, Reg::RSI, Reg::RDX, Reg::RCX, Reg::R8, Reg::R9];
    for (i, &r) in arg_regs.iter().take(arg_count).enumerate() {
        let off = ((arg_count - 1 - i) as i32) * 16;
        emit_mov_r_mem(code, r, Reg::RSP, off);
    }

    // Variadic ABI: AL = number of XMM regs used. c4 has no float
    // ops, so it's always 0. Do this for Op::Prtf only (plain libc
    // calls preserve rax across argument loads anyway, but xor'ing
    // it where unnecessary just churns bytes).
    if matches!(op, Op::Prtf) {
        emit_xor_eax_eax(code);
    }

    // call qword [rip + disp32] -- placeholder, writer patches
    // disp32 to point at the right .got slot.
    let instr_offset = code.len();
    got_fixups.push(GotFixup {
        adrp_offset: instr_offset,
        import_index,
    });
    emit_call_qword_rip32(code, 0);

    if matches!(op, Op::Exit) {
        // exit() doesn't return; the c4 compiler emits no Adj after.
        // Drop the 1 pushed arg ourselves so any stale code after is
        // SP-balanced.
        emit_add_rsp_imm32(code, 16);
    } else {
        // Move the libc return value into r13 so the c4 caller sees
        // it as the new accumulator.
        emit_mov_rr(code, Reg::R13, Reg::RAX);
    }
    Ok(())
}

/// Pop the top of the VM stack into `dst`. Mirrors the aarch64
/// `enc_ldr_post(Reg::X16, Reg::SP, 16)` shape -- load the value,
/// then bump rsp by 16.
fn pop_into(code: &mut Vec<u8>, dst: Reg) {
    emit_mov_r_mem(code, dst, Reg::RSP, 0);
    emit_add_rsp_imm32(code, 16);
}

/// Pop, perform `r10 op= r13`, then mov result back into r13.
fn binop_with_pop<F: Fn(&mut Vec<u8>, Reg, Reg)>(code: &mut Vec<u8>, op_rr: F) {
    pop_into(code, Reg::R10);
    op_rr(code, Reg::R10, Reg::R13);
    emit_mov_rr(code, Reg::R13, Reg::R10);
}

/// Pop, compare, set r13 = 0/1 by condition. The setcc/movzx pair
/// avoids clobbering the cmp's flags between cmp and setcc -- we
/// can't `xor r13, r13` first because xor sets the flags.
fn cmp_with_pop(code: &mut Vec<u8>, cc: Cc) {
    pop_into(code, Reg::R10);
    emit_cmp_rr(code, Reg::R10, Reg::R13);
    emit_setcc_r8(code, cc, Reg::R10);
    emit_movzx_r_r8(code, Reg::R13, Reg::R10);
}

/// Pop into r10, shift r10 by cl (lo byte of r13), mov r10 to r13.
fn shift_with_pop(code: &mut Vec<u8>, arithmetic_right: bool) {
    pop_into(code, Reg::R10);
    // mov rcx, r13 -- the shift count register is fixed to cl.
    emit_mov_rr(code, Reg::RCX, Reg::R13);
    if arithmetic_right {
        emit_sar_r_cl(code, Reg::R10);
    } else {
        emit_shl_r_cl(code, Reg::R10);
    }
    emit_mov_rr(code, Reg::R13, Reg::R10);
}

/// Signed divide. c4 semantics: `popped / r13` (or `% r13`). On
/// x86_64: load popped into rax, sign-extend to rdx:rax via cqo,
/// idiv divisor (we keep the divisor in r10 because rax/rdx can't
/// host it), then move rax (quotient) or rdx (remainder) into r13.
fn div_or_mod_with_pop(code: &mut Vec<u8>, want_remainder: bool) {
    // The divisor must not be in rax or rdx (idiv overwrites both).
    emit_mov_rr(code, Reg::R10, Reg::R13); // r10 = divisor
    pop_into(code, Reg::RAX); // rax = dividend
    emit_cqo(code); // rdx:rax = sign-extend rax
    emit_idiv_r(code, Reg::R10);
    if want_remainder {
        emit_mov_rr(code, Reg::R13, Reg::RDX);
    } else {
        emit_mov_rr(code, Reg::R13, Reg::RAX);
    }
}

/// Comparison-with-immediate optimizer-emitted op: `cmp r13, imm32;
/// setcc r13b` (with a zeroing xor first to clear high bits).
fn imm_cmp(
    code: &mut Vec<u8>,
    text: &[i64],
    pc: &mut usize,
    op_name: &str,
    cc: Cc,
) -> Result<(), C4Error> {
    let n = read_operand(text, pc, op_name)? as i32;
    emit_cmp_r_imm32(code, Reg::R13, n);
    emit_setcc_r8(code, cc, Reg::R10);
    emit_movzx_r_r8(code, Reg::R13, Reg::R10);
    Ok(())
}

fn read_operand(text: &[i64], pc: &mut usize, op_name: &str) -> Result<i64, C4Error> {
    if *pc >= text.len() {
        return Err(C4Error::Compile(format!(
            "native codegen (x86_64): {op_name} missing operand at end of bytecode"
        )));
    }
    let v = text[*pc];
    *pc += 1;
    Ok(v)
}

/// Standard System V ABI prologue: save rbp, set new frame, allocate
/// locals (rounded up to keep rsp 16-byte aligned at any call site).
///
/// For the program's entry function (`is_main = true`) the c4
/// calling convention wants argv at `rbp + 16` (top arg, val=2) and
/// argc at `rbp + 32` (deeper arg, val=3). On x86_64 the `call` from
/// `_start` has already pushed the return address to the stack, so
/// we can't just push argc / argv before saving rbp -- they'd land
/// *below* the saved rbp. Instead we pop the ret addr into a temp,
/// push argc / argv as 16-byte slots in caller-style, then re-push
/// the ret addr; the resulting layout matches what
/// [`lea_offset_bytes`] expects.
fn emit_prologue(code: &mut Vec<u8>, locals: i64, is_main: bool) {
    if is_main {
        emit_pop_r(code, Reg::R10); // r10 = ret addr
        // Push argc (rdi) first (deeper), then argv (rsi) (shallower).
        emit_sub_rsp_imm32(code, 16);
        emit_mov_mem_r(code, Reg::RSP, 0, Reg::RDI);
        emit_sub_rsp_imm32(code, 16);
        emit_mov_mem_r(code, Reg::RSP, 0, Reg::RSI);
        emit_push_r(code, Reg::R10); // restore ret addr above the slots
    }
    emit_push_r(code, Reg::RBP);
    emit_mov_rr(code, Reg::RBP, Reg::RSP);
    if locals > 0 {
        let bytes = (locals as u32) * 8;
        // Keep rsp 16-aligned. After `call` (pushed return addr,
        // 8 bytes) and `push rbp` (8 more) rsp is at -16 mod 16
        // again. Round local space up to 16 to preserve that.
        let aligned = (bytes + 15) & !15;
        emit_sub_rsp_imm32(code, aligned);
    }
    // Save r13 (the VM accumulator) below the locals. r13 is
    // callee-saved per System V x86_64 ABI -- self-hosted c4-to-c4
    // calls don't actually need the saved value (the caller refills
    // its accumulator from the return value), but JIT entry from
    // Rust and any other external caller does. Use a 16-byte slot so
    // rsp stays 16-aligned across libc call sites.
    emit_sub_rsp_imm32(code, 16);
    emit_mov_mem_r(code, Reg::RSP, 0, Reg::R13);
}

/// Mirror of [`emit_prologue`]. Move the VM accumulator into rax
/// (return register), restore r13, tear down the frame, return. For
/// main we also drop the two 16-byte argc / argv slots inserted by
/// the prologue -- they sit between the saved rbp and the return
/// address, so we pop the ret addr into a temp, drop the slots, then
/// push it back before `ret` consumes it.
fn emit_epilogue(code: &mut Vec<u8>, is_main: bool) {
    emit_mov_rr(code, Reg::RAX, Reg::R13);
    // Restore r13 from its 16-byte slot at [rsp]. We then drop both
    // the locals and the saved-r13 slot via `mov rsp, rbp`.
    emit_mov_r_mem(code, Reg::R13, Reg::RSP, 0);
    emit_mov_rr(code, Reg::RSP, Reg::RBP);
    emit_pop_r(code, Reg::RBP);
    if is_main {
        emit_pop_r(code, Reg::R10); // ret addr
        emit_add_rsp_imm32(code, 32); // drop argc + argv slots
        emit_push_r(code, Reg::R10);
    }
    emit_ret(code);
}

// ------------------------------------------------------------------
// Encoder unit tests. Expected byte sequences cross-checked against
// `clang -c` + `objdump -d` on x86_64.
// ------------------------------------------------------------------

#[cfg(test)]
mod tests {
    use super::*;
    use alloc::vec;

    fn assemble<F: FnOnce(&mut Vec<u8>)>(f: F) -> Vec<u8> {
        let mut buf = Vec::new();
        f(&mut buf);
        buf
    }

    #[test]
    fn rex_w_only() {
        assert_eq!(rex(true, false, false, false), 0x48);
        assert_eq!(rex(false, false, false, false), 0x40);
        assert_eq!(rex(true, true, true, true), 0x4F);
    }

    #[test]
    fn modrm_register_form() {
        // mod=11 reg=rax(0) rm=rdi(7) -> 11_000_111 = 0xC7
        assert_eq!(modrm(0b11, 0, 7), 0xC7);
        // mod=11 reg=rdi(7) rm=rax(0) -> 11_111_000 = 0xF8
        assert_eq!(modrm(0b11, 7, 0), 0xF8);
    }

    #[test]
    fn mov_rdi_rax() {
        // mov rdi, rax  ->  48 89 C7
        assert_eq!(
            assemble(|c| emit_mov_rr(c, Reg::RDI, Reg::RAX)),
            vec![0x48, 0x89, 0xC7]
        );
    }

    #[test]
    fn mov_rax_r13_uses_rex_b() {
        // mov rax, r13  ->  4C 89 E8 (REX.W + REX.R for src=R13)
        assert_eq!(
            assemble(|c| emit_mov_rr(c, Reg::RAX, Reg::R13)),
            vec![0x4C, 0x89, 0xE8]
        );
    }

    #[test]
    fn mov_r13_imm64() {
        // mov r13, 42  ->  49 BD 2A 00 00 00 00 00 00 00
        assert_eq!(
            assemble(|c| emit_mov_r_imm64(c, Reg::R13, 42)),
            vec![0x49, 0xBD, 0x2A, 0, 0, 0, 0, 0, 0, 0]
        );
    }

    #[test]
    fn push_pop_rbp_no_rex() {
        assert_eq!(assemble(|c| emit_push_r(c, Reg::RBP)), vec![0x55]);
        assert_eq!(assemble(|c| emit_pop_r(c, Reg::RBP)), vec![0x5D]);
    }

    #[test]
    fn push_pop_r13_uses_rex_b() {
        assert_eq!(assemble(|c| emit_push_r(c, Reg::R13)), vec![0x41, 0x55]);
        assert_eq!(assemble(|c| emit_pop_r(c, Reg::R13)), vec![0x41, 0x5D]);
    }

    #[test]
    fn mov_rdi_at_rsp_zero() {
        // mov rdi, [rsp]  ->  48 8B 3C 24
        // mod=00 reg=rdi(7) rm=100 (SIB), SIB=00_100_100
        assert_eq!(
            assemble(|c| emit_mov_r_mem(c, Reg::RDI, Reg::RSP, 0)),
            vec![0x48, 0x8B, 0x3C, 0x24]
        );
    }

    #[test]
    fn lea_rsi_rsp_plus_8() {
        // lea rsi, [rsp + 8]  ->  48 8D 74 24 08
        assert_eq!(
            assemble(|c| emit_lea_r_mem(c, Reg::RSI, Reg::RSP, 8)),
            vec![0x48, 0x8D, 0x74, 0x24, 0x08]
        );
    }

    #[test]
    fn mov_rbp_zero_uses_disp8() {
        // [rbp+0] cannot use mod=00 (that would mean RIP-relative);
        // must encode as mod=01 with disp8=0.
        // mov rax, [rbp]  ->  48 8B 45 00
        assert_eq!(
            assemble(|c| emit_mov_r_mem(c, Reg::RAX, Reg::RBP, 0)),
            vec![0x48, 0x8B, 0x45, 0x00]
        );
    }

    #[test]
    fn mov_rsp_at_disp32() {
        // [rsp + 0x1000]  ->  48 8B 84 24 00 10 00 00
        assert_eq!(
            assemble(|c| emit_mov_r_mem(c, Reg::RAX, Reg::RSP, 0x1000)),
            vec![0x48, 0x8B, 0x84, 0x24, 0x00, 0x10, 0x00, 0x00]
        );
    }

    #[test]
    fn ret_is_c3() {
        assert_eq!(assemble(emit_ret), vec![0xC3]);
    }

    #[test]
    fn syscall_is_0f_05() {
        assert_eq!(assemble(emit_syscall), vec![0x0F, 0x05]);
    }

    #[test]
    fn call_rel32_zero() {
        // call .+0 (next instruction)  ->  E8 00 00 00 00
        assert_eq!(
            assemble(|c| emit_call_rel32(c, 0)),
            vec![0xE8, 0x00, 0x00, 0x00, 0x00]
        );
    }

    #[test]
    fn sub_rsp_imm32() {
        // sub rsp, 0x10  ->  48 81 EC 10 00 00 00
        assert_eq!(
            assemble(|c| emit_sub_rsp_imm32(c, 0x10)),
            vec![0x48, 0x81, 0xEC, 0x10, 0x00, 0x00, 0x00]
        );
    }

    #[test]
    fn start_stub_decodes_to_known_bytes() {
        // Spot-check the full stub for entry_offset = 0 (main lives
        // immediately after the stub). The stub is:
        //   mov rdi, [rsp]              ; argc
        //   lea rsi, [rsp+8]            ; argv
        //   call main                   ; rel32 placeholder
        //   mov rdi, rax                ; pass to libc exit
        //   call qword [rip + disp32]   ; libc exit slot
        let mut buf = Vec::new();
        let exit_off = emit_start_stub(&mut buf, 0);
        assert_eq!(buf.len() as u64, START_STUB_LEN);
        // mov rdi, [rsp]              -> 48 8B 3C 24
        assert_eq!(&buf[0..4], &[0x48, 0x8B, 0x3C, 0x24]);
        // lea rsi, [rsp+8]            -> 48 8D 74 24 08
        assert_eq!(&buf[4..9], &[0x48, 0x8D, 0x74, 0x24, 0x08]);
        // call main rel32 = (23 - (9+5)) = 9 -> E8 09 00 00 00
        assert_eq!(&buf[9..14], &[0xE8, 0x09, 0x00, 0x00, 0x00]);
        // mov rdi, rax                -> 48 89 C7
        assert_eq!(&buf[14..17], &[0x48, 0x89, 0xC7]);
        // call qword [rip + 0]        -> FF 15 00 00 00 00
        assert_eq!(exit_off, 17);
        assert_eq!(
            &buf[17..23],
            &[0xFF, 0x15, 0x00, 0x00, 0x00, 0x00],
            "call qword [rip+0] placeholder"
        );
    }
}

//! x86_64 instruction encoder + per-function lowering shell.
//!
//! Mirrors the structure of [`super::aarch64`]. Per-function code
//! generation routes through [`super::ssa::shadow::produce_ssa_funcs`]
//! + [`super::ssa::reg_alloc::allocate`] + `super::emit`; this
//! module owns the encoder catalogue, the start-stub, the PLT
//! trampoline emit, and the post-pass fixup walks that the SSA emit
//! defers to.
//!
//! ## Always-on peepholes
//!
//! [`emit_mov_rr`] drops `mov rd, rd` instead of emitting it. Used
//! by the SSA emit, the start stub, and `emit_libc_call`-shaped
//! helpers where source and destination can coincide.
//!
//! [`emit_mov_r_imm64`] picks the smallest encoding for the
//! constant: `xor rd, rd` for zero, 5-byte `mov r32, imm32` for
//! 0..u32::MAX (which zero-extends to 64 per the SDM), 10-byte
//! `REX.W + B8+rd io` otherwise.

#![allow(dead_code)] // Encoders ahead of lowering coverage.

use alloc::format;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::program::Program;
use super::{Abi, Build, DataFixup, FuncFixup, GotFixup, NativeOptions, Target};

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
pub(crate) struct Reg(pub u8);

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
    // XMM register names. The newtype `Reg` is reused for them
    // because every encoder we hit uses the same 4-bit reg field;
    // a separate `Xmm(u8)` would only duplicate `lo`/`high`. The
    // SSE2 emitters above assert their args by intent (their
    // opcodes are unique), so the GPR/XMM mix-up class of bug is
    // mostly caught by reading the call sites.
    pub const XMM0: Reg = Reg(0);
    pub const XMM1: Reg = Reg(1);

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
/// * `w`: 1 = 64-bit operand size.
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
///
/// Skips emission entirely when `dst == src`: the move would be a
/// no-op but cost 3 bytes of code. The lowering pass calls this on
/// dynamically-chosen register pairs (e.g. moving a popped pool
/// register into r13), so guarding here catches every emit site
/// without the lowering having to spell out the check.
pub(crate) fn emit_mov_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    if dst == src {
        return;
    }
    emit_byte(code, rex(true, src.high(), false, dst.high()));
    emit_byte(code, 0x89);
    emit_byte(code, modrm(0b11, src.lo(), dst.lo()));
}

/// `mov r32, r32` (89 /r without REX.W). Writing a 32-bit register
/// zero-extends it to the full 64-bit register, so this materialises
/// `dst = src & 0xffffffff` in one instruction with no scratch. The
/// REX prefix is emitted only when either operand is a high (r8..r15)
/// register; for low registers the 32-bit form needs no REX so the
/// upper-half clear stays intact.
pub(crate) fn emit_mov_r32_r32(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    if src.high() || dst.high() {
        emit_byte(code, rex(false, src.high(), false, dst.high()));
    }
    emit_byte(code, 0x89);
    emit_byte(code, modrm(0b11, src.lo(), dst.lo()));
}

/// Extend a libc return value sitting in `RAX` to fill the
/// full 64-bit register, per `ext`. msvcrt's int-typed returns
/// (atoi, fclose, isatty, ...) leave the upper 32 bits undefined,
/// so callers that consume the result through c5's 64-bit
/// accumulator need this before reading. Encodings are spelled
/// out as raw bytes -- the dst/src are always RAX/EAX/AX/AL so
/// the ModR/M byte is fixed.
pub(crate) fn emit_extend_rax_for_return(code: &mut Vec<u8>, ext: super::ReturnExt) {
    use super::ReturnExt;
    match ext {
        ReturnExt::None => {}
        // movsxd rax, eax -- REX.W + 63 /r, ModR/M C0.
        ReturnExt::Sign32 => emit_bytes(code, &[0x48, 0x63, 0xC0]),
        // mov eax, eax -- 32-bit MOV implicitly zero-extends to RAX.
        ReturnExt::Zero32 => emit_bytes(code, &[0x89, 0xC0]),
        // movsx rax, ax -- REX.W + 0F BF /r, ModR/M C0.
        ReturnExt::Sign16 => emit_bytes(code, &[0x48, 0x0F, 0xBF, 0xC0]),
        // movzx rax, ax -- REX.W + 0F B7 /r, ModR/M C0.
        ReturnExt::Zero16 => emit_bytes(code, &[0x48, 0x0F, 0xB7, 0xC0]),
        // movsx rax, al -- REX.W + 0F BE /r, ModR/M C0.
        ReturnExt::Sign8 => emit_bytes(code, &[0x48, 0x0F, 0xBE, 0xC0]),
        // movzx rax, al -- REX.W + 0F B6 /r, ModR/M C0.
        ReturnExt::Zero8 => emit_bytes(code, &[0x48, 0x0F, 0xB6, 0xC0]),
    }
}

/// `MOV r64, imm64`. Picks the smallest encoding that holds
/// the constant exactly:
/// * `imm == 0`              -> `xor rd, rd` (3 bytes).
/// * `0 <= imm <= u32::MAX`  -> `mov r32, imm32` (5 bytes; the
///                              32-bit operand-size MOV
///                              implicitly zero-extends to 64
///                              bits, per the Intel SDM).
/// * otherwise               -> `REX.W + B8+rd io` (10 bytes).
pub(crate) fn emit_mov_r_imm64(code: &mut Vec<u8>, dst: Reg, imm: i64) {
    if imm == 0 {
        emit_xor_rr(code, dst, dst);
        return;
    }
    if (0..=u32::MAX as i64).contains(&imm) {
        if dst.high() {
            emit_byte(code, rex(false, false, false, true));
        }
        emit_byte(code, 0xB8 | dst.lo());
        emit_u32(code, imm as u32);
        return;
    }
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xB8 | dst.lo());
    emit_i64(code, imm);
}

/// `PUSH r64`. Encoding: `50+rd`, plus REX.B if `dst` is R8..R15.
pub(crate) fn emit_push_r(code: &mut Vec<u8>, r: Reg) {
    if r.high() {
        emit_byte(code, rex(false, false, false, true));
    }
    emit_byte(code, 0x50 | r.lo());
}

/// `POP r64`. Encoding: `58+rd`, plus REX.B if `dst` is R8..R15.
pub(crate) fn emit_pop_r(code: &mut Vec<u8>, r: Reg) {
    if r.high() {
        emit_byte(code, rex(false, false, false, true));
    }
    emit_byte(code, 0x58 | r.lo());
}

/// `RET`. The near-return form, no operand.
pub(crate) fn emit_ret(code: &mut Vec<u8>) {
    emit_byte(code, 0xC3);
}

/// `SYSCALL`. Linux x86_64 intrinsic entry; nr in `rax`, args in
/// `rdi/rsi/rdx/r10/r8/r9`, return in `rax`.
pub(crate) fn emit_syscall(code: &mut Vec<u8>) {
    emit_bytes(code, &[0x0F, 0x05]);
}

/// `MOV r64, [base + disp]` -- 64-bit memory load.
/// Encoding: `REX.W + 8B /r` with the addressing form chosen by
/// `disp`'s magnitude. Handles `[rsp + disp]` (which always needs a
/// SIB byte) and `[rbp + disp]` (which always needs `mod >= 01`).
pub(crate) fn emit_mov_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, 0x8B);
    emit_modrm_mem(code, dst, base, disp);
}

/// `MOV [base + disp], r64` -- 64-bit memory store.
/// Encoding: `REX.W + 89 /r`.
pub(crate) fn emit_mov_mem_r(code: &mut Vec<u8>, base: Reg, disp: i32, src: Reg) {
    emit_byte(code, rex(true, src.high(), false, base.high()));
    emit_byte(code, 0x89);
    emit_modrm_mem(code, src, base, disp);
}

/// `MOV [base + disp], r32` -- 32-bit store.
pub(crate) fn emit_mov_mem_r32(code: &mut Vec<u8>, base: Reg, disp: i32, src: Reg) {
    if src.high() || base.high() {
        emit_byte(code, rex(false, src.high(), false, base.high()));
    }
    emit_byte(code, 0x89);
    emit_modrm_mem(code, src, base, disp);
}

/// `MOV [base + disp], r16` -- 16-bit store.
pub(crate) fn emit_mov_mem_r16(code: &mut Vec<u8>, base: Reg, disp: i32, src: Reg) {
    emit_byte(code, 0x66);
    if src.high() || base.high() {
        emit_byte(code, rex(false, src.high(), false, base.high()));
    }
    emit_byte(code, 0x89);
    emit_modrm_mem(code, src, base, disp);
}

/// `MOV [base + disp], r8` -- 8-bit store. The REX prefix (even empty)
/// selects the uniform byte registers so `sil` / `dil` and the high
/// extensions encode rather than `ah` / `ch`.
pub(crate) fn emit_mov_mem_r8(code: &mut Vec<u8>, base: Reg, disp: i32, src: Reg) {
    emit_byte(code, rex(false, src.high(), false, base.high()));
    emit_byte(code, 0x88);
    emit_modrm_mem(code, src, base, disp);
}

/// `MOVSXD r64, [base + disp]` -- 32-bit load sign-extended into a
/// 64-bit destination. Encoding: `REX.W + 63 /r`. Used by [`LoadKind::I32`]
/// for signed `int` lvalue reads -- C signed semantics require the
/// high bit of the 4-byte slot to propagate.
pub(crate) fn emit_movsxd_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, 0x63);
    emit_modrm_mem(code, dst, base, disp);
}

/// `MOV r32, [base + disp]` -- 32-bit load. The CPU implicitly
/// zero-extends every write to a 32-bit GPR into the full 64-bit
/// register, so this doubles as a zero-extending u32 load. Used by
/// [`LoadKind::U32`] for `unsigned int` lvalue reads. Encoding: no REX.W,
/// just `8B /r` (with REX only if any operand needs the high bank).
pub(crate) fn emit_mov_r32_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    let needs_rex = dst.high() || base.high();
    if needs_rex {
        emit_byte(code, rex(false, dst.high(), false, base.high()));
    }
    emit_byte(code, 0x8B);
    emit_modrm_mem(code, dst, base, disp);
}

/// `MOV [base + disp], r32` -- 32-bit memory store of the low half
/// of `src`. Encoding: no REX.W, just `89 /r` (with REX only if any
/// operand register needs the high bank). Companion to
/// [`emit_movsxd_r_mem`] for the `StoreKind::I32` lowering.
pub(crate) fn emit_mov_mem32_r(code: &mut Vec<u8>, base: Reg, disp: i32, src: Reg) {
    let needs_rex = src.high() || base.high();
    if needs_rex {
        emit_byte(code, rex(false, src.high(), false, base.high()));
    }
    emit_byte(code, 0x89);
    emit_modrm_mem(code, src, base, disp);
}

/// `MOV DWORD PTR [base + disp], imm32` -- 32-bit immediate store.
/// Encoding: `C7 /0 id` (with REX only when `base` needs the high
/// bank). Used to initialise the System V `__va_list_tag`
/// `gp_offset` / `fp_offset` (4-byte each) in `va_start`.
pub(crate) fn emit_mov_mem32_imm32(code: &mut Vec<u8>, base: Reg, disp: i32, imm: i32) {
    if base.high() {
        emit_byte(code, rex(false, false, false, base.high()));
    }
    emit_byte(code, 0xC7);
    // Reg field is the /0 opcode extension.
    emit_modrm_mem(code, Reg(0), base, disp);
    emit_i32(code, imm);
}

/// `ADD dword [base + disp], imm32` -- add an immediate to a 32-bit
/// memory operand in place. Encoding: `81 /0 id`.
pub(crate) fn emit_add_mem32_imm32(code: &mut Vec<u8>, base: Reg, disp: i32, imm: i32) {
    if base.high() {
        emit_byte(code, rex(false, false, false, base.high()));
    }
    emit_byte(code, 0x81);
    emit_modrm_mem(code, Reg(0), base, disp);
    emit_i32(code, imm);
}

/// `ADD qword [base + disp], imm32` -- add a sign-extended immediate to
/// a 64-bit memory operand in place. Encoding: `REX.W 81 /0 id`.
pub(crate) fn emit_add_mem64_imm32(code: &mut Vec<u8>, base: Reg, disp: i32, imm: i32) {
    emit_byte(code, rex(true, false, false, base.high()));
    emit_byte(code, 0x81);
    emit_modrm_mem(code, Reg(0), base, disp);
    emit_i32(code, imm);
}

/// `MOVSX r64, [base + disp]` (16-bit memory source) -- 16-bit load
/// sign-extended into a 64-bit register. Used by [`LoadKind::I16`] for
/// `short` lvalue reads. Encoding: `REX.W + 0F BF /r`.
pub(crate) fn emit_movsx_r_mem16(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xBF);
    emit_modrm_mem(code, dst, base, disp);
}

/// `MOVZX r64, [base + disp]` (16-bit memory source) -- 16-bit load
/// zero-extended into a 64-bit register. Used by [`LoadKind::U16`] for
/// `unsigned short` / `u16` lvalue reads. Encoding: `REX.W + 0F B7 /r`.
pub(crate) fn emit_movzx_r_mem16(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xB7);
    emit_modrm_mem(code, dst, base, disp);
}

/// `MOV [base + disp], r16` -- 16-bit memory store of the low half-
/// word of `src`. Encoding: `66` prefix (operand-size override to
/// 16-bit) + optional REX (no W) + `89 /r`. Companion to
/// [`emit_movsx_r_mem16`] / [`emit_movzx_r_mem16`] for the
/// `StoreKind::I16` lowering.
pub(crate) fn emit_mov_mem16_r(code: &mut Vec<u8>, base: Reg, disp: i32, src: Reg) {
    emit_byte(code, 0x66);
    let needs_rex = src.high() || base.high();
    if needs_rex {
        emit_byte(code, rex(false, src.high(), false, base.high()));
    }
    emit_byte(code, 0x89);
    emit_modrm_mem(code, src, base, disp);
}

/// `LEA r64, [base + disp]` -- compute effective address.
/// Encoding: `REX.W + 8D /r`.
pub(crate) fn emit_lea_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, 0x8D);
    emit_modrm_mem(code, dst, base, disp);
}

/// `LEA r64, [rip + disp32]` -- the RIP-relative addressing form
/// (mod=00, r/m=101). 7 bytes total. The writer patches `disp32`
/// after layout to point at a data-segment address or another
/// function inside the code blob.
pub(crate) fn emit_lea_r_rip32(code: &mut Vec<u8>, dst: Reg, disp32: i32) {
    emit_byte(code, rex(true, dst.high(), false, false));
    emit_byte(code, 0x8D);
    // mod=00, reg=dst.lo(), r/m=101 -- the RIP-relative r/m
    // encoding (Intel SDM Vol. 2A, Table 2-7).
    emit_byte(code, modrm(0b00, dst.lo(), 0b101));
    emit_i32(code, disp32);
}

/// Byte length of [`emit_lea_r_rip32`]. The writer needs this to
/// compute the RIP that the disp32 is measured from (i.e. the byte
/// just after the lea, which is `instr_offset + LEA_RIP32_LEN`).
pub(crate) const LEA_RIP32_LEN: usize = 7;

/// `CALL rel32`. The 5-byte direct-call form. `rel32` is a signed
/// 32-bit displacement from the byte *after* the instruction.
pub(crate) fn emit_call_rel32(code: &mut Vec<u8>, rel32: i32) {
    emit_byte(code, 0xE8);
    emit_i32(code, rel32);
}

/// `SUB rsp, imm32`. Used by the function prologue to reserve local
/// stack space. Encoding: `REX.W + 81 /5 id`.
pub(crate) fn emit_sub_rsp_imm32(code: &mut Vec<u8>, imm: u32) {
    emit_byte(code, rex(true, false, false, false));
    emit_byte(code, 0x81);
    // `/5` means ModR/M.reg = 5 (the opcode-extension digit for
    // `SUB`). r/m = rsp(4) and mod = 11 (register-direct).
    emit_byte(code, modrm(0b11, 5, Reg::RSP.lo()));
    emit_u32(code, imm);
}

/// `ADD rsp, imm32`. Used by epilogue / Adj. Encoding: `REX.W + 81
/// /0 id`.
pub(crate) fn emit_add_rsp_imm32(code: &mut Vec<u8>, imm: u32) {
    emit_byte(code, rex(true, false, false, false));
    emit_byte(code, 0x81);
    emit_byte(code, modrm(0b11, 0, Reg::RSP.lo()));
    emit_u32(code, imm);
}

// ---- Two-register integer ALU. The `r/m, r` family of opcodes:
//      ADD=01 SUB=29 AND=21 OR=09 XOR=31 CMP=39. ModR/M.reg=src,
//      r/m=dst.

/// `ADD dst, src` -- 64-bit, `dst += src`.
pub(crate) fn emit_add_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x01, dst, src);
}

/// `SUB dst, src` -- 64-bit, `dst -= src`.
pub(crate) fn emit_sub_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x29, dst, src);
}

/// `AND dst, src` -- 64-bit, `dst &= src`.
pub(crate) fn emit_and_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x21, dst, src);
}

/// `OR dst, src` -- 64-bit, `dst |= src`.
pub(crate) fn emit_or_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x09, dst, src);
}

/// `XOR dst, src` -- 64-bit, `dst ^= src`.
pub(crate) fn emit_xor_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x31, dst, src);
}

/// `CMP dst, src` -- 64-bit; sets flags = `dst - src` without storing.
pub(crate) fn emit_cmp_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x39, dst, src);
}

/// `TEST dst, src` -- `dst & src`, setting ZF / SF (and clearing
/// CF / OF). Encoding: `REX.W + 85 /r`. `test reg, reg` is the 3-byte
/// compare-with-zero that replaces a 7-byte `cmp reg, imm32` against 0:
/// ZF / SF / CF / OF match, so every dependent `jcc` / `setcc` is
/// unchanged.
pub(crate) fn emit_test_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_alu_rr(code, 0x85, dst, src);
}

fn emit_alu_rr(code: &mut Vec<u8>, opcode: u8, dst: Reg, src: Reg) {
    emit_byte(code, rex(true, src.high(), false, dst.high()));
    emit_byte(code, opcode);
    emit_byte(code, modrm(0b11, src.lo(), dst.lo()));
}

/// `IMUL dst, src` -- two-operand signed multiply, `dst = dst * src`.
/// Encoding: `REX.W + 0F AF /r`.
pub(crate) fn emit_imul_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, rex(true, dst.high(), false, src.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xAF);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

// ---- ALU with a memory source: `OP dst, [base + disp]`. The
//      `r, r/m` family of opcodes (ModR/M.reg=dst, r/m=memory):
//      ADD=03 SUB=2B AND=23 OR=0B XOR=33 CMP=3B. A spilled second
//      operand is read in place, avoiding a scratch register the
//      surrounding allocation may not have free.

fn emit_alu_r_mem(code: &mut Vec<u8>, opcode: u8, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, opcode);
    emit_modrm_mem(code, dst, base, disp);
}

/// `ADD dst, [base + disp]` -- 64-bit, `dst += [mem]`.
pub(crate) fn emit_add_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_alu_r_mem(code, 0x03, dst, base, disp);
}

/// `SUB dst, [base + disp]` -- 64-bit, `dst -= [mem]`.
pub(crate) fn emit_sub_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_alu_r_mem(code, 0x2B, dst, base, disp);
}

/// `AND dst, [base + disp]` -- 64-bit, `dst &= [mem]`.
pub(crate) fn emit_and_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_alu_r_mem(code, 0x23, dst, base, disp);
}

/// `OR dst, [base + disp]` -- 64-bit, `dst |= [mem]`.
pub(crate) fn emit_or_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_alu_r_mem(code, 0x0B, dst, base, disp);
}

/// `XOR dst, [base + disp]` -- 64-bit, `dst ^= [mem]`.
pub(crate) fn emit_xor_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_alu_r_mem(code, 0x33, dst, base, disp);
}

/// `CMP dst, [base + disp]` -- 64-bit; flags = `dst - [mem]`.
pub(crate) fn emit_cmp_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_alu_r_mem(code, 0x3B, dst, base, disp);
}

/// `IMUL dst, [base + disp]` -- two-operand signed multiply with a
/// memory source. Encoding: `REX.W + 0F AF /r`.
pub(crate) fn emit_imul_r_mem(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xAF);
    emit_modrm_mem(code, dst, base, disp);
}

/// `IMUL dst, src, imm32` -- three-operand signed multiply with an
/// immediate source. Encoding: `REX.W + 69 /r id`, ModR/M.reg = dst,
/// ModR/M.r/m = src. Computes `dst = src * sign_extend(imm32)`; `dst`
/// and `src` may be the same register, so no staging mov or scratch
/// is needed for a multiply by a constant that fits a signed 32-bit
/// immediate.
pub(crate) fn emit_imul_r_r_imm32(code: &mut Vec<u8>, dst: Reg, src: Reg, imm: i32) {
    emit_byte(code, rex(true, dst.high(), false, src.high()));
    emit_byte(code, 0x69);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
    code.extend_from_slice(&imm.to_le_bytes());
}

/// `NEG r64` -- two's-complement negate (Intel SDM Vol.2, group 3
/// `F7 /3`). Used by the atomic subtract lowering, which negates the
/// operand before a `LOCK XADD`.
pub(crate) fn emit_neg_r(code: &mut Vec<u8>, r: Reg) {
    emit_byte(code, rex(true, false, false, r.high()));
    emit_byte(code, 0xF7);
    emit_byte(code, modrm(0b11, 3, r.lo()));
}

// ---- Atomic memory operations (Intel SDM Vol.2). The memory operand
//      is `[base + disp]`; `reg` carries the register operand in the
//      ModR/M.reg field. `width` is the access size in bytes. The
//      operand-size prefix `66` selects 16-bit; REX.W selects 64-bit;
//      an 8-bit access uses the byte opcode and a mandatory REX so the
//      low byte of any of the 16 GPRs is addressable.

/// Emit the operand-size prefix and REX byte for an atomic memory op
/// of `width` bytes with register `reg` and memory base `base`. A
/// byte access always emits REX (per SETcc / MOVZX convention) so
/// SPL/BPL/SIL/DIL and R8B..R15B are reachable; a 64-bit access sets
/// REX.W; otherwise REX is emitted only when a high register is used.
fn atomic_prefix(code: &mut Vec<u8>, width: u8, reg: Reg, base: Reg) {
    if width == 2 {
        emit_byte(code, 0x66);
    }
    let w = width == 8;
    if w || width == 1 || reg.high() || base.high() {
        emit_byte(code, rex(w, reg.high(), false, base.high()));
    }
}

/// `LOCK XADD [base + disp], reg` -- atomically add `reg` to the memory
/// operand and load the prior contents into `reg` (Intel SDM Vol.2,
/// XADD with the `F0` LOCK prefix). Encoding: `F0 [66] [REX] 0F C0/C1
/// /r`, byte opcode `C0` else `C1`.
pub(crate) fn emit_lock_xadd_mem_r(code: &mut Vec<u8>, base: Reg, disp: i32, reg: Reg, width: u8) {
    emit_byte(code, 0xF0);
    atomic_prefix(code, width, reg, base);
    emit_byte(code, 0x0F);
    emit_byte(code, if width == 1 { 0xC0 } else { 0xC1 });
    emit_modrm_mem(code, reg, base, disp);
}

/// `XCHG [base + disp], reg` -- atomically exchange `reg` with the
/// memory operand (Intel SDM Vol.2; a memory operand makes XCHG
/// implicitly LOCK-ed, so no `F0` prefix is emitted). Encoding:
/// `[66] [REX] 86/87 /r`, byte opcode `86` else `87`.
pub(crate) fn emit_xchg_mem_r(code: &mut Vec<u8>, base: Reg, disp: i32, reg: Reg, width: u8) {
    atomic_prefix(code, width, reg, base);
    emit_byte(code, if width == 1 { 0x86 } else { 0x87 });
    emit_modrm_mem(code, reg, base, disp);
}

/// `XCHG r64, r64` -- exchange two registers (Intel SDM Vol.2,
/// `REX.W + 87 /r`). A register operand carries no implicit LOCK (that
/// applies only to a memory operand), so this is a plain register swap.
/// Used to break a register-register parallel-move cycle with no scratch.
pub(crate) fn emit_xchg_rr(code: &mut Vec<u8>, a: Reg, b: Reg) {
    if a == b {
        return;
    }
    emit_byte(code, rex(true, b.high(), false, a.high()));
    emit_byte(code, 0x87);
    emit_byte(code, modrm(0b11, b.lo(), a.lo()));
}

/// `LOCK CMPXCHG [base + disp], reg` -- compare RAX with the memory
/// operand; on equality store `reg` and set ZF, else load the memory
/// operand into RAX and clear ZF (Intel SDM Vol.2 CMPXCHG with the
/// `F0` LOCK prefix). Encoding: `F0 [66] [REX] 0F B0/B1 /r`, byte
/// opcode `B0` else `B1`.
pub(crate) fn emit_lock_cmpxchg_mem_r(
    code: &mut Vec<u8>,
    base: Reg,
    disp: i32,
    reg: Reg,
    width: u8,
) {
    emit_byte(code, 0xF0);
    atomic_prefix(code, width, reg, base);
    emit_byte(code, 0x0F);
    emit_byte(code, if width == 1 { 0xB0 } else { 0xB1 });
    emit_modrm_mem(code, reg, base, disp);
}

/// `IDIV r/m64` -- signed divide `rdx:rax / r`. Quotient -> rax,
/// remainder -> rdx. The caller must sign-extend rax into rdx with
/// [`emit_cqo`] first.
pub(crate) fn emit_idiv_r(code: &mut Vec<u8>, divisor: Reg) {
    emit_byte(code, rex(true, false, false, divisor.high()));
    emit_byte(code, 0xF7);
    emit_byte(code, modrm(0b11, 7, divisor.lo()));
}

/// `DIV r/m64` -- unsigned divide `rdx:rax / r`. Quotient -> rax,
/// remainder -> rdx. The caller must zero rdx (e.g. `xor edx, edx`)
/// instead of sign-extending with [`emit_cqo`].
pub(crate) fn emit_div_r(code: &mut Vec<u8>, divisor: Reg) {
    emit_byte(code, rex(true, false, false, divisor.high()));
    emit_byte(code, 0xF7);
    emit_byte(code, modrm(0b11, 6, divisor.lo()));
}

/// `IDIV r/m64` with a memory divisor at `[base + disp]`. The reg
/// field carries the `/7` opcode extension; REX.R is therefore clear.
pub(crate) fn emit_idiv_m(code: &mut Vec<u8>, base: Reg, disp: i32) {
    emit_byte(code, rex(true, false, false, base.high()));
    emit_byte(code, 0xF7);
    emit_modrm_mem(code, Reg(7), base, disp);
}

/// `DIV r/m64` with a memory divisor at `[base + disp]` (`/6`).
pub(crate) fn emit_div_m(code: &mut Vec<u8>, base: Reg, disp: i32) {
    emit_byte(code, rex(true, false, false, base.high()));
    emit_byte(code, 0xF7);
    emit_modrm_mem(code, Reg(6), base, disp);
}

// ---- SSE2 floating-point. ----
//
// XMM registers share the 0..15 register-id field with GPRs; the
// `Reg` newtype is reused for them as a dedicated `Xmm` newtype
// would balloon the encoder API for negligible safety gain.
//
// The c5 stack carries an FP value as the raw `f64::to_bits()`
// pattern in a GPR slot; the lowering pulls it into XMM only for
// the math itself (`movq xmm, gpr` / `movq gpr, xmm`).

/// `MOVQ xmm, r64` -- move 64 bits from a GPR into the low quad of
/// an XMM register. Encoding: `66 REX.W 0F 6E /r`.
pub(crate) fn emit_movq_xmm_r(code: &mut Vec<u8>, xmm: Reg, src: Reg) {
    emit_byte(code, 0x66);
    emit_byte(code, rex(true, xmm.high(), false, src.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0x6E);
    emit_byte(code, modrm(0b11, xmm.lo(), src.lo()));
}

/// `MOVQ r64, xmm` -- move 64 bits from an XMM low quad to a GPR.
/// Encoding: `66 REX.W 0F 7E /r` (note `/r` field carries the
/// XMM source, the `r/m` carries the destination GPR).
pub(crate) fn emit_movq_r_xmm(code: &mut Vec<u8>, dst: Reg, xmm: Reg) {
    emit_byte(code, 0x66);
    emit_byte(code, rex(true, xmm.high(), false, dst.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0x7E);
    emit_byte(code, modrm(0b11, xmm.lo(), dst.lo()));
}

/// `MOVQ xmm, [base+disp32]` -- load 8 bytes from memory into the
/// low quad of an XMM register. Encoding: `F3 0F 7E /r` with a SIB
/// byte for `[base+disp]`. Used by the variadic-FP packer to feed
/// arg slots straight from the c5 stack into the FP-arg registers
/// without a GPR roundtrip.
pub(crate) fn emit_movq_xmm_r_mem(code: &mut Vec<u8>, xmm: Reg, base: Reg, disp: i32) {
    emit_byte(code, 0xF3);
    if xmm.high() || base.high() {
        emit_byte(code, rex(false, xmm.high(), false, base.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x7E);
    // mod=10 (disp32), reg=xmm.lo, rm=100 (SIB follows for sp/r12).
    emit_byte(code, modrm(0b10, xmm.lo(), 0b100));
    emit_byte(code, sib(0, 0b100, base.lo()));
    emit_i32(code, disp);
}

/// `MOVSD xmm, [base+disp32]` -- load 8 bytes (scalar double) into
/// the low quad of an XMM register, zeroing the rest. Encoding:
/// `F2 0F 10 /r`. SIB-driven mod=10/disp32 form matches the other
/// xmm memory helpers.
pub(crate) fn emit_movsd_xmm_mem(code: &mut Vec<u8>, xmm: Reg, base: Reg, disp: i32) {
    emit_byte(code, 0xF2);
    if xmm.high() || base.high() {
        emit_byte(code, rex(false, xmm.high(), false, base.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x10);
    emit_byte(code, modrm(0b10, xmm.lo(), 0b100));
    emit_byte(code, sib(0, 0b100, base.lo()));
    emit_i32(code, disp);
}

/// `MOVSD [base+disp32], xmm` -- store 8 bytes from the low quad of
/// an XMM register. Encoding: `F2 0F 11 /r`.
pub(crate) fn emit_movsd_mem_xmm(code: &mut Vec<u8>, base: Reg, disp: i32, xmm: Reg) {
    emit_byte(code, 0xF2);
    if xmm.high() || base.high() {
        emit_byte(code, rex(false, xmm.high(), false, base.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x11);
    emit_byte(code, modrm(0b10, xmm.lo(), 0b100));
    emit_byte(code, sib(0, 0b100, base.lo()));
    emit_i32(code, disp);
}

/// `MOVUPS m128, xmm` -- store a full 128-bit xmm to memory with no
/// alignment requirement. Preserves a Win64 non-volatile xmm
/// (xmm6..xmm15) the emit pass uses as FP scratch; the whole 128 bits
/// are saved because the caller's value may occupy the upper lanes.
/// Encoding: `0F 11 /r` with a `[base + disp32]` SIB operand.
pub(crate) fn emit_movups_mem_xmm(code: &mut Vec<u8>, base: Reg, disp: i32, xmm: Reg) {
    if xmm.high() || base.high() {
        emit_byte(code, rex(false, xmm.high(), false, base.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x11);
    emit_byte(code, modrm(0b10, xmm.lo(), 0b100));
    emit_byte(code, sib(0, 0b100, base.lo()));
    emit_i32(code, disp);
}

/// `MOVUPS xmm, m128` -- load a full 128-bit xmm from memory with no
/// alignment requirement. Restores a saved Win64 non-volatile xmm.
/// Encoding: `0F 10 /r` with a `[base + disp32]` SIB operand.
pub(crate) fn emit_movups_xmm_mem(code: &mut Vec<u8>, xmm: Reg, base: Reg, disp: i32) {
    if xmm.high() || base.high() {
        emit_byte(code, rex(false, xmm.high(), false, base.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x10);
    emit_byte(code, modrm(0b10, xmm.lo(), 0b100));
    emit_byte(code, sib(0, 0b100, base.lo()));
    emit_i32(code, disp);
}

/// `MOVAPD xmm, xmm` -- register-to-register copy of a 128-bit
/// SSE2 packed-double. The scalar form is overkill but
/// instruction-size identical to MOVSD and avoids the
/// merge-with-upper-half semantics of `MOVSD reg, reg`.
/// Encoding: `66 0F 28 /r`.
pub(crate) fn emit_movapd_xmm_xmm(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, 0x66);
    if dst.high() || src.high() {
        emit_byte(code, rex(false, dst.high(), false, src.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x28);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `MOV AL, imm8` -- set the low byte of rax to a constant. Used
/// to seed the SysV variadic-ABI XMM-register count in AL just
/// before a `printf`-style call.
pub(crate) fn emit_mov_al_imm8(code: &mut Vec<u8>, imm: u8) {
    emit_byte(code, 0xB0);
    emit_byte(code, imm);
}

/// `TEST AL, AL` -- set ZF from the low byte of rax. The System V
/// variadic-ABI XMM-register count rides AL (3.2.3); a variadic
/// callee's prologue tests it to skip the XMM save when the caller
/// passed no floating-point arguments (`al == 0`).
pub(crate) fn emit_test_al_al(code: &mut Vec<u8>) {
    // 84 /r -- TEST r/m8, r8 with both operands AL.
    emit_byte(code, 0x84);
    emit_byte(code, modrm(0b11, Reg::RAX.lo(), Reg::RAX.lo()));
}

/// Internal: emit a `F2 0F <op> /r` SSE2 SD instruction with two
/// XMM operands, encoded as `dst <op>= src`.
fn emit_sse2_sd(code: &mut Vec<u8>, opcode: u8, dst: Reg, src: Reg) {
    emit_byte(code, 0xF2);
    if dst.high() || src.high() {
        emit_byte(code, rex(false, dst.high(), false, src.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, opcode);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// Internal: emit a `F3 0F <op> /r` SSE single-precision scalar
/// instruction with two XMM operands, encoded as `dst <op>= src`.
fn emit_sse_ss(code: &mut Vec<u8>, opcode: u8, dst: Reg, src: Reg) {
    emit_byte(code, 0xF3);
    if dst.high() || src.high() {
        emit_byte(code, rex(false, dst.high(), false, src.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, opcode);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `ADDSS xmm, xmm` -- single-precision add (C99 6.3.1.8).
pub(crate) fn emit_addss(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_sse_ss(code, 0x58, dst, src);
}

/// `SUBSS xmm, xmm` -- `dst = dst - src`.
pub(crate) fn emit_subss(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_sse_ss(code, 0x5C, dst, src);
}

/// `MULSS xmm, xmm`.
pub(crate) fn emit_mulss(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_sse_ss(code, 0x59, dst, src);
}

/// `DIVSS xmm, xmm` -- `dst = dst / src`.
pub(crate) fn emit_divss(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_sse_ss(code, 0x5E, dst, src);
}

/// `UCOMISS xmm, xmm` -- ordered scalar single-precision compare,
/// sets EFLAGS. Encoding: `0F 2E /r` (no mandatory prefix).
pub(crate) fn emit_ucomiss(code: &mut Vec<u8>, lhs: Reg, rhs: Reg) {
    if lhs.high() || rhs.high() {
        emit_byte(code, rex(false, lhs.high(), false, rhs.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x2E);
    emit_byte(code, modrm(0b11, lhs.lo(), rhs.lo()));
}

/// `ADDSD xmm, xmm`.
pub(crate) fn emit_addsd(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_sse2_sd(code, 0x58, dst, src);
}

/// `SUBSD xmm, xmm` -- `dst = dst - src`.
pub(crate) fn emit_subsd(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_sse2_sd(code, 0x5C, dst, src);
}

/// `MULSD xmm, xmm`.
pub(crate) fn emit_mulsd(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_sse2_sd(code, 0x59, dst, src);
}

/// `DIVSD xmm, xmm` -- `dst = dst / src`.
pub(crate) fn emit_divsd(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_sse2_sd(code, 0x5E, dst, src);
}

/// `SQRTSD xmm, xmm` -- `dst = sqrt(src)`, scalar double. `F2 0F 51 /r`.
pub(crate) fn emit_sqrtsd(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_sse2_sd(code, 0x51, dst, src);
}

/// `SQRTSS xmm, xmm` -- `dst = sqrt(src)`, scalar single. `F3 0F 51 /r`.
pub(crate) fn emit_sqrtss(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_sse_ss(code, 0x51, dst, src);
}

/// `ANDPD xmm, xmm` -- bitwise AND of two doubles. `66 0F 54 /r`. Used
/// for `FABS` (AND with the inverted sign-bit mask in another XMM).
pub(crate) fn emit_andpd(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, 0x66);
    if dst.high() || src.high() {
        emit_byte(code, rex(false, dst.high(), false, src.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x54);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `ROUNDSD xmm, xmm, imm8` -- round a scalar double per the immediate
/// rounding mode (SSE4.1). `66 0F 3A 0B /r ib`. The mode bits: 0x09
/// floor (round down), 0x0A ceil (round up), 0x0B truncate; each sets
/// bit 3 to suppress the precision exception.
pub(crate) fn emit_roundsd(code: &mut Vec<u8>, dst: Reg, src: Reg, imm: u8) {
    emit_byte(code, 0x66);
    if dst.high() || src.high() {
        emit_byte(code, rex(false, dst.high(), false, src.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x3A);
    emit_byte(code, 0x0B);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
    emit_byte(code, imm);
}

/// `ROUNDSS xmm, xmm, imm8` -- scalar single-precision form. `66 0F 3A
/// 0A /r ib`.
pub(crate) fn emit_roundss(code: &mut Vec<u8>, dst: Reg, src: Reg, imm: u8) {
    emit_byte(code, 0x66);
    if dst.high() || src.high() {
        emit_byte(code, rex(false, dst.high(), false, src.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x3A);
    emit_byte(code, 0x0A);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
    emit_byte(code, imm);
}

/// `XORPD xmm, xmm` -- bitwise XOR of two doubles. With identical
/// operands it zeroes the register, used as a building block for
/// `FNEG` (we XOR with the sign-bit mask in another XMM).
pub(crate) fn emit_xorpd(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, 0x66);
    if dst.high() || src.high() {
        emit_byte(code, rex(false, dst.high(), false, src.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x57);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `UCOMISD xmm, xmm` -- ordered scalar double-precision compare,
/// sets EFLAGS. Encoding: `66 0F 2E /r`.
pub(crate) fn emit_ucomisd(code: &mut Vec<u8>, lhs: Reg, rhs: Reg) {
    emit_byte(code, 0x66);
    if lhs.high() || rhs.high() {
        emit_byte(code, rex(false, lhs.high(), false, rhs.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x2E);
    emit_byte(code, modrm(0b11, lhs.lo(), rhs.lo()));
}

/// Emit a VEX-encoded FMA3 scalar instruction in the `231` operand
/// order: `dst = (a * b) <op> dst`. `a` is the VEX.vvvv multiplicand,
/// `b` the ModR/M.r/m multiplicand, `dst` the ModR/M.reg destination
/// that also supplies the accumulator. `opcode` picks the variant
/// (B9 / BB / BD / BF); `w64` selects the double-precision (W1) form,
/// otherwise single-precision (W0). FMA3 is Haswell-and-later baseline.
fn emit_vex_fma231(code: &mut Vec<u8>, opcode: u8, w64: bool, dst: Reg, a: Reg, b: Reg) {
    // 3-byte VEX (C4): the 0F38 opcode map forces the long form.
    //   byte1: R X B mmmmm   (R/B inverted high bits; mmmmm = 00010)
    //   byte2: W vvvv L pp    (vvvv inverted; L = 0 scalar; pp = 01 -> 66)
    let r = if dst.high() { 0u8 } else { 1u8 };
    let b_bit = if b.high() { 0u8 } else { 1u8 };
    let a_num = ((a.high() as u8) << 3) | a.lo();
    let vvvv = (!a_num) & 0xF;
    emit_byte(code, 0xC4);
    emit_byte(code, (r << 7) | (1 << 6) | (b_bit << 5) | 0b00010);
    emit_byte(code, ((w64 as u8) << 7) | (vvvv << 3) | 0b01);
    emit_byte(code, opcode);
    emit_byte(code, modrm(0b11, dst.lo(), b.lo()));
}

/// `VFMADD231SD dst, a, b` -- `dst = a*b + dst` (double, single round).
pub(crate) fn emit_vfmadd231sd(code: &mut Vec<u8>, dst: Reg, a: Reg, b: Reg) {
    emit_vex_fma231(code, 0xB9, true, dst, a, b);
}

/// `VFMSUB231SD dst, a, b` -- `dst = a*b - dst`.
pub(crate) fn emit_vfmsub231sd(code: &mut Vec<u8>, dst: Reg, a: Reg, b: Reg) {
    emit_vex_fma231(code, 0xBB, true, dst, a, b);
}

/// `VFNMADD231SD dst, a, b` -- `dst = -(a*b) + dst`.
pub(crate) fn emit_vfnmadd231sd(code: &mut Vec<u8>, dst: Reg, a: Reg, b: Reg) {
    emit_vex_fma231(code, 0xBD, true, dst, a, b);
}

/// `VFNMSUB231SD dst, a, b` -- `dst = -(a*b) - dst`.
pub(crate) fn emit_vfnmsub231sd(code: &mut Vec<u8>, dst: Reg, a: Reg, b: Reg) {
    emit_vex_fma231(code, 0xBF, true, dst, a, b);
}

/// `VFMADD231SS dst, a, b` -- `dst = a*b + dst` (single, single round).
pub(crate) fn emit_vfmadd231ss(code: &mut Vec<u8>, dst: Reg, a: Reg, b: Reg) {
    emit_vex_fma231(code, 0xB9, false, dst, a, b);
}

/// `VFMSUB231SS dst, a, b` -- `dst = a*b - dst`.
pub(crate) fn emit_vfmsub231ss(code: &mut Vec<u8>, dst: Reg, a: Reg, b: Reg) {
    emit_vex_fma231(code, 0xBB, false, dst, a, b);
}

/// `VFNMADD231SS dst, a, b` -- `dst = -(a*b) + dst`.
pub(crate) fn emit_vfnmadd231ss(code: &mut Vec<u8>, dst: Reg, a: Reg, b: Reg) {
    emit_vex_fma231(code, 0xBD, false, dst, a, b);
}

/// `VFNMSUB231SS dst, a, b` -- `dst = -(a*b) - dst`.
pub(crate) fn emit_vfnmsub231ss(code: &mut Vec<u8>, dst: Reg, a: Reg, b: Reg) {
    emit_vex_fma231(code, 0xBF, false, dst, a, b);
}

/// `CVTSI2SD xmm, r64` -- signed 64-bit int to double, with REX.W.
/// Encoding: `F2 REX.W 0F 2A /r`.
pub(crate) fn emit_cvtsi2sd(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, 0xF2);
    emit_byte(code, rex(true, dst.high(), false, src.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0x2A);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `CVTTSD2SI r64, xmm` -- truncating double-to-signed-int.
/// Encoding: `F2 REX.W 0F 2C /r`.
pub(crate) fn emit_cvttsd2si(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, 0xF2);
    emit_byte(code, rex(true, dst.high(), false, src.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0x2C);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `MOVSS xmm, [base+disp32]` -- load 4 bytes (single-precision) into
/// the low dword of an XMM register, zeroing the rest. Encoding:
/// `F3 0F 10 /r`. Used by [`LoadKind::F32`] to pull a `float`-typed lvalue
/// out of its 4-byte storage before the widening `cvtss2sd`.
pub(crate) fn emit_movss_xmm_mem(code: &mut Vec<u8>, xmm: Reg, base: Reg, disp: i32) {
    emit_byte(code, 0xF3);
    if xmm.high() || base.high() {
        emit_byte(code, rex(false, xmm.high(), false, base.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x10);
    // SIB-driven mod=10/disp32 form, matching emit_movq_xmm_r_mem so
    // rsp/r12 base registers stay correct.
    emit_byte(code, modrm(0b10, xmm.lo(), 0b100));
    emit_byte(code, sib(0, 0b100, base.lo()));
    emit_i32(code, disp);
}

/// `MOVSS [base+disp32], xmm` -- store 4 bytes from the low dword of
/// an XMM register. Encoding: `F3 0F 11 /r`. Companion to
/// [`emit_movss_xmm_mem`]; the `StoreKind::F32` lowering uses
/// this for the final narrowed store.
pub(crate) fn emit_movss_mem_xmm(code: &mut Vec<u8>, base: Reg, disp: i32, xmm: Reg) {
    emit_byte(code, 0xF3);
    if xmm.high() || base.high() {
        emit_byte(code, rex(false, xmm.high(), false, base.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x11);
    emit_byte(code, modrm(0b10, xmm.lo(), 0b100));
    emit_byte(code, sib(0, 0b100, base.lo()));
    emit_i32(code, disp);
}

/// `CVTSS2SD xmm, xmm` -- widen single-precision to double-precision.
/// Encoding: `F3 0F 5A /r`. The IEEE 754 single -> double widening
/// is bit-exact for every finite source value.
pub(crate) fn emit_cvtss2sd(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, 0xF3);
    if dst.high() || src.high() {
        emit_byte(code, rex(false, dst.high(), false, src.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x5A);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `CVTSD2SS xmm, xmm` -- narrow double-precision to single-precision
/// with round-to-nearest-ties-to-even (matching IEEE 754 and the
/// VM's `f64 as f32` semantics). Encoding: `F2 0F 5A /r`. Used
/// by the `StoreKind::F32` lowering before the single-precision
/// store.
pub(crate) fn emit_cvtsd2ss(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, 0xF2);
    if dst.high() || src.high() {
        emit_byte(code, rex(false, dst.high(), false, src.high()));
    }
    emit_byte(code, 0x0F);
    emit_byte(code, 0x5A);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `CQO` -- sign-extend rax into rdx:rax (the 64-bit form;
/// `CDQE` is the 32-bit counterpart). Encoding: `REX.W + 99`.
pub(crate) fn emit_cqo(code: &mut Vec<u8>) {
    emit_byte(code, rex(true, false, false, false));
    emit_byte(code, 0x99);
}

// ---- Shifts. The `D3` opcode shifts by `cl`; `C1` shifts by an
//      8-bit immediate. We expose both forms because the optimizer
//      emits constant-shift IR ops (`ShlI N`, `ShrI N`) that benefit
//      from the immediate path.

/// `SHL r/m64, cl`. ModR/M.reg = 4. `cl` is implicit.
pub(crate) fn emit_shl_r_cl(code: &mut Vec<u8>, dst: Reg) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xD3);
    emit_byte(code, modrm(0b11, 4, dst.lo()));
}

/// `SAR r/m64, cl` -- arithmetic right shift (signed; sign bit
/// replicates). ModR/M.reg = 7.
pub(crate) fn emit_sar_r_cl(code: &mut Vec<u8>, dst: Reg) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xD3);
    emit_byte(code, modrm(0b11, 7, dst.lo()));
}

/// `SHR r/m64, cl` -- logical right shift (zero fills high bits).
/// ModR/M.reg = 5. Used by [`BinOp::Shru`] / unsigned `>>`.
pub(crate) fn emit_shr_r_cl(code: &mut Vec<u8>, dst: Reg) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xD3);
    emit_byte(code, modrm(0b11, 5, dst.lo()));
}

/// `SHL r/m64, imm8`. ModR/M.reg = 4, imm at end.
pub(crate) fn emit_shl_r_imm8(code: &mut Vec<u8>, dst: Reg, imm: u8) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xC1);
    emit_byte(code, modrm(0b11, 4, dst.lo()));
    emit_byte(code, imm);
}

/// `SAR r/m64, imm8`. ModR/M.reg = 7, imm at end.
pub(crate) fn emit_sar_r_imm8(code: &mut Vec<u8>, dst: Reg, imm: u8) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xC1);
    emit_byte(code, modrm(0b11, 7, dst.lo()));
    emit_byte(code, imm);
}

/// `SHR r/m64, imm8` (logical right shift). ModR/M.reg = 5, imm at end.
pub(crate) fn emit_shr_r_imm8(code: &mut Vec<u8>, dst: Reg, imm: u8) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xC1);
    emit_byte(code, modrm(0b11, 5, dst.lo()));
    emit_byte(code, imm);
}

/// `ROR r/m64, imm8` (bit-rotate right). ModR/M.reg = 1, imm at end.
pub(crate) fn emit_ror_r_imm8(code: &mut Vec<u8>, dst: Reg, imm: u8) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xC1);
    emit_byte(code, modrm(0b11, 1, dst.lo()));
    emit_byte(code, imm);
}

/// `ROR r/m64, cl` (bit-rotate right by `cl`). ModR/M.reg = 1.
pub(crate) fn emit_ror_r_cl(code: &mut Vec<u8>, dst: Reg) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xD3);
    emit_byte(code, modrm(0b11, 1, dst.lo()));
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
pub(crate) fn emit_add_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 0, dst, imm);
}

/// `SUB r64, imm32`.
pub(crate) fn emit_sub_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 5, dst, imm);
}

/// `INC r64` -- `REX.W FF /0`. The single-byte `40+rd` encoding is a
/// REX prefix in 64-bit mode, so the `FF` form is the only one.
pub(crate) fn emit_inc_r(code: &mut Vec<u8>, dst: Reg) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xFF);
    emit_byte(code, modrm(0b11, 0, dst.lo()));
}

/// `DEC r64` -- `REX.W FF /1`.
pub(crate) fn emit_dec_r(code: &mut Vec<u8>, dst: Reg) {
    emit_byte(code, rex(true, false, false, dst.high()));
    emit_byte(code, 0xFF);
    emit_byte(code, modrm(0b11, 1, dst.lo()));
}

/// `AND r64, imm32`.
pub(crate) fn emit_and_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 4, dst, imm);
}

/// `OR r64, imm32`.
pub(crate) fn emit_or_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 1, dst, imm);
}

/// `XOR r64, imm32`.
pub(crate) fn emit_xor_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 6, dst, imm);
}

/// `CMP r64, imm32` -- sets flags = `dst - imm`.
pub(crate) fn emit_cmp_r_imm32(code: &mut Vec<u8>, dst: Reg, imm: i32) {
    emit_alu_r_imm32(code, 7, dst, imm);
}

// ---- 8-bit memory + setcc. Used for `LoadKind::U8` /
//      `StoreKind::I8` and for the comparison ops that produce
//      0/1 in the low byte.

/// Condition codes for `Jcc` and `setcc`. Values match Intel's CC
/// encoding so the opcode byte for `Jcc` is `0F 8X+cc` and for
/// `setcc` it is `0F 9X+cc`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Cc {
    /// Equal / zero.
    E = 0x4,
    /// Not equal.
    Ne = 0x5,
    /// Sign (SF=1) -- the result's high bit is set; used to test a
    /// 64-bit value's bit 63.
    S = 0x8,
    /// Not sign (SF=0) -- the complement of `S`, completing the
    /// `flip` pairing.
    Ns = 0x9,
    /// Less than (signed).
    L = 0xC,
    /// Greater than (signed).
    G = 0xF,
    /// Less than or equal (signed).
    Le = 0xE,
    /// Greater than or equal (signed).
    Ge = 0xD,
    /// Below (CF=1) -- used by FP comparisons after `UCOMISD`,
    /// where the "less" result lives under the carry flag rather
    /// than the signed less-than encoding.
    B = 0x2,
    /// Below or equal (CF=1 || ZF=1) -- FP `<=`.
    Be = 0x6,
    /// Above (CF=0 && ZF=0) -- FP `>`.
    A = 0x7,
    /// Above or equal (CF=0) -- FP `>=`.
    Ae = 0x3,
    /// Parity (PF=1). After `UCOMISD` PF=1 indicates an unordered
    /// (NaN) comparison.
    P = 0xA,
    /// Not parity (PF=0). After `UCOMISD` PF=0 indicates an
    /// ordered comparison.
    Np = 0xB,
}

impl Cc {
    /// Logical complement of the condition. The cmp+branch
    /// fusion peephole calls this when a `Terminator::Bz` (test
    /// for boolean zero) lands on a compare op whose `setcc` was
    /// elided: the branch must fire on the inverted predicate.
    /// Mirror of
    /// [`super::aarch64::Cond::flip`].
    fn flip(self) -> Cc {
        match self {
            Cc::E => Cc::Ne,
            Cc::Ne => Cc::E,
            Cc::L => Cc::Ge,
            Cc::Ge => Cc::L,
            Cc::G => Cc::Le,
            Cc::Le => Cc::G,
            Cc::B => Cc::Ae,
            Cc::Ae => Cc::B,
            Cc::A => Cc::Be,
            Cc::Be => Cc::A,
            Cc::P => Cc::Np,
            Cc::Np => Cc::P,
            Cc::S => Cc::Ns,
            Cc::Ns => Cc::S,
        }
    }
}

/// `SETcc r/m8` -- write byte = 1 if condition holds, else 0. The
/// upper bits of the destination are *not* zeroed; the caller is
/// expected to pre-zero the register (the emit path uses
/// `xor r, r`).
pub(crate) fn emit_setcc_r8(code: &mut Vec<u8>, cc: Cc, dst: Reg) {
    // SET<cc> r/m8 needs a REX prefix to address SPL/BPL/SIL/DIL or
    // R8B..R15B; REX with the low GPRs disables the AH/CH/DH/BH
    // high-byte aliases, which matches the encoder's requirement.
    emit_byte(code, rex(false, false, false, dst.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0x90 | (cc as u8));
    emit_byte(code, modrm(0b11, 0, dst.lo()));
}

/// `MOVZX r64, byte ptr [base + disp]` -- load a byte zero-extended
/// into a 64-bit register. Encoding: `REX.W + 0F B6 /r`.
pub(crate) fn emit_movzx_r_mem8(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xB6);
    emit_modrm_mem(code, dst, base, disp);
}

/// `MOVSX r64, byte ptr [base + disp]` -- load a byte sign-extended
/// into a 64-bit register. Used by [`LoadKind::I8`] for `signed char`
/// lvalue reads. Encoding: `REX.W + 0F BE /r`.
pub(crate) fn emit_movsx_r_mem8(code: &mut Vec<u8>, dst: Reg, base: Reg, disp: i32) {
    emit_byte(code, rex(true, dst.high(), false, base.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xBE);
    emit_modrm_mem(code, dst, base, disp);
}

/// `MOVZX r64, r/m8` -- zero-extend a byte register into a 64-bit
/// register. Encoding: `REX.W + 0F B6 /r` with `mod=11`. The REX
/// prefix also disables the AH/CH/DH/BH high-byte aliases so we
/// can treat any of the 16 GPRs as an 8-bit source.
pub(crate) fn emit_movzx_r_r8(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, rex(true, dst.high(), false, src.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xB6);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `MOV byte ptr [base + disp], r8` -- store the low byte of `src`.
/// Encoding: `MOV r/m8, r8` = `88 /r`. REX is mandatory when storing
/// from one of the upper or new low-byte registers.
pub(crate) fn emit_mov_mem8_r(code: &mut Vec<u8>, base: Reg, disp: i32, src: Reg) {
    emit_byte(code, rex(false, src.high(), false, base.high()));
    emit_byte(code, 0x88);
    emit_modrm_mem(code, src, base, disp);
}

// ---- Branches. All forms encode the displacement relative to the
//      *byte after* the instruction. `JMP rel32` is 5 bytes; `Jcc
//      rel32` is 6.

/// `JMP rel32` -- unconditional branch, 5 bytes.
pub(crate) fn emit_jmp_rel32(code: &mut Vec<u8>, rel32: i32) {
    emit_byte(code, 0xE9);
    emit_i32(code, rel32);
}

/// `Jcc rel32` -- conditional branch, 6 bytes.
pub(crate) fn emit_jcc_rel32(code: &mut Vec<u8>, cc: Cc, rel32: i32) {
    emit_byte(code, 0x0F);
    emit_byte(code, 0x80 | (cc as u8));
    emit_i32(code, rel32);
}

/// `Jmp rel8` -- short unconditional branch, 2 bytes. The target must
/// be within -128..127 of the byte after the rel8 field; the caller
/// (branch relaxation) guarantees the range.
pub(crate) fn emit_jmp_rel8(code: &mut Vec<u8>, rel8: i8) {
    emit_byte(code, 0xEB);
    emit_byte(code, rel8 as u8);
}

/// `Jcc rel8` -- short conditional branch, 2 bytes. The opcode is
/// `0x70 | cc`, the one-byte-displacement form of the `0x0F 0x80 | cc`
/// rel32 encoding.
pub(crate) fn emit_jcc_rel8(code: &mut Vec<u8>, cc: Cc, rel8: i8) {
    emit_byte(code, 0x70 | (cc as u8));
    emit_byte(code, rel8 as u8);
}

/// `CALL r64` -- indirect call through a register. Encoding:
/// `FF /2`.
pub(crate) fn emit_call_r(code: &mut Vec<u8>, target: Reg) {
    if target.high() {
        emit_byte(code, rex(false, false, false, true));
    }
    emit_byte(code, 0xFF);
    emit_byte(code, modrm(0b11, 2, target.lo()));
}

/// `JMP r64` -- indirect branch through a register (GCC computed
/// goto). Same `FF` opcode family as the indirect `CALL` above; only
/// the ModR/M `/4` extension changes (4 = JMP, 2 = CALL).
pub(crate) fn emit_jmp_r(code: &mut Vec<u8>, target: Reg) {
    if target.high() {
        emit_byte(code, rex(false, false, false, true));
    }
    emit_byte(code, 0xFF);
    emit_byte(code, modrm(0b11, 4, target.lo()));
}

/// `CALL qword ptr [rip + disp32]` -- PC-relative indirect call
/// through a memory operand. Encoding: `FF /2` with ModR/M
/// `mod=00 reg=2 r/m=101` (the RIP-relative addressing form,
/// Intel SDM Vol. 2A, Table 2-7) + disp32. 6 bytes total. Used
/// for GOT calls on Linux x86_64; the writer patches `disp32` so
/// the load points at the right `.got` slot.
pub(crate) fn emit_call_qword_rip32(code: &mut Vec<u8>, disp32: i32) {
    emit_byte(code, 0xFF);
    emit_byte(code, modrm(0b00, 2, 0b101));
    emit_i32(code, disp32);
}

/// Byte length of [`emit_call_qword_rip32`]. Used by the writer to
/// compute the `disp32` measurement origin (just after the call).
pub(crate) const CALL_QWORD_RIP32_LEN: usize = 6;

/// `JMP qword ptr [rip+disp32]` -- 6-byte indirect tail-jump
/// through a memory operand. Same `FF /4` opcode family as the
/// indirect `CALL` above; only the `/4` ModR/M extension changes
/// (4 = JMP, 2 = CALL). Used by the `Terminator::TailExt`
/// lowering to forward control
/// from a c5 trampoline to the IAT/GOT-resolved libc address
/// without disturbing the caller's argument registers or shadow
/// space. Disp32 measurement origin is the byte just past the
/// instruction; the writer (PE / ELF / Mach-O) patches `disp32`
/// to the resolved IAT / GOT slot RVA, identical to how
/// `emit_call_qword_rip32`'s site is patched.
pub(crate) fn emit_jmp_qword_rip32(code: &mut Vec<u8>, disp32: i32) {
    emit_byte(code, 0xFF);
    emit_byte(code, modrm(0b00, 4, 0b101));
    emit_i32(code, disp32);
}

/// Byte length of [`emit_jmp_qword_rip32`]. Same encoding family
/// as the indirect call, so the length is also 6.
pub(crate) const JMP_QWORD_RIP32_LEN: usize = 6;

/// `XOR eax, eax` -- 32-bit form, zero-extends to 64 (sets rax = 0).
/// Used as the System V variadic-ABI "no XMM args" marker before
/// printf-shape calls: AL must be 0 going in.
pub(crate) fn emit_xor_eax_eax(code: &mut Vec<u8>) {
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

/// `MOVSXD r64, r32` -- sign-extend a 32-bit register to 64 bits.
/// Reg-to-reg form of [`emit_movsxd_r_mem`].
pub(crate) fn emit_movsxd_r_r(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, rex(true, dst.high(), false, src.high()));
    emit_byte(code, 0x63);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `MOVSX r64, r/m16` (register form) -- sign-extend low 16 bits.
pub(crate) fn emit_movsx_r_r16(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, rex(true, dst.high(), false, src.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xBF);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// `MOVSX r64, r/m8` (register form) -- sign-extend low 8 bits.
/// REX is always emitted to access the new-encoding 8-bit subregs
/// (`sil` / `dil` / `bpl` / `spl`) instead of the legacy AH/CH/etc.
pub(crate) fn emit_movsx_r_r8(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    emit_byte(code, rex(true, dst.high(), false, src.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xBE);
    emit_byte(code, modrm(0b11, dst.lo(), src.lo()));
}

/// Emit the ModR/M + SIB + displacement bytes for a memory operand
/// of the form `[base + index * scale + disp]`. `scale` must be 1,
/// 2, 4, or 8. When `disp == 0` and `base` isn't RBP/R13, emits
/// the mod=00 short form (no displacement byte); for RBP/R13 base
/// the form requires mod=01 with disp8=0 because mod=00 means
/// RIP-relative addressing.
fn emit_modrm_sib_mem(code: &mut Vec<u8>, reg: Reg, base: Reg, index: Reg, scale: u8, disp: i32) {
    let bp_form = base.lo() == 5; // RBP/R13
    let scale_bits: u8 = match scale {
        1 => 0,
        2 => 1,
        4 => 2,
        8 => 3,
        _ => panic!("emit_modrm_sib_mem: invalid scale {scale}"),
    };
    let (mod_, want_disp8, want_disp32) = if disp == 0 && !bp_form {
        (0b00, false, false)
    } else if (-128..=127).contains(&disp) {
        (0b01, true, false)
    } else {
        (0b10, false, true)
    };
    // mod=..., reg=reg.lo(), r/m=100 (SIB follows).
    emit_byte(code, modrm(mod_, reg.lo(), 4));
    // scale=scale_bits, index=index.lo(), base=base.lo().
    emit_byte(code, sib(scale_bits, index.lo(), base.lo()));
    if want_disp8 {
        emit_byte(code, disp as i8 as u8);
    } else if want_disp32 {
        emit_i32(code, disp);
    }
}

/// `MOVSXD r64, [base + index * scale]` -- 32-bit signed indexed load.
pub(crate) fn emit_movsxd_r_sib(code: &mut Vec<u8>, dst: Reg, base: Reg, index: Reg, scale: u8) {
    emit_byte(code, rex(true, dst.high(), index.high(), base.high()));
    emit_byte(code, 0x63);
    emit_modrm_sib_mem(code, dst, base, index, scale, 0);
}

/// `MOV r64, [base + index * scale]` -- 64-bit indexed load.
pub(crate) fn emit_mov_r_sib(code: &mut Vec<u8>, dst: Reg, base: Reg, index: Reg, scale: u8) {
    emit_byte(code, rex(true, dst.high(), index.high(), base.high()));
    emit_byte(code, 0x8B);
    emit_modrm_sib_mem(code, dst, base, index, scale, 0);
}

/// `LEA r64, [base + index * scale]` -- compute the effective address.
pub(crate) fn emit_lea_r_sib(code: &mut Vec<u8>, dst: Reg, base: Reg, index: Reg, scale: u8) {
    emit_byte(code, rex(true, dst.high(), index.high(), base.high()));
    emit_byte(code, 0x8D);
    emit_modrm_sib_mem(code, dst, base, index, scale, 0);
}

/// `MOV r32, [base + index * scale]` -- 32-bit zero-extending indexed
/// load.
pub(crate) fn emit_mov_r32_sib(code: &mut Vec<u8>, dst: Reg, base: Reg, index: Reg, scale: u8) {
    let needs_rex = dst.high() || index.high() || base.high();
    if needs_rex {
        emit_byte(code, rex(false, dst.high(), index.high(), base.high()));
    }
    emit_byte(code, 0x8B);
    emit_modrm_sib_mem(code, dst, base, index, scale, 0);
}

/// `MOVSX r64, [base + index * scale]` (16-bit) -- 16-bit signed
/// indexed load.
pub(crate) fn emit_movsx_r_sib16(code: &mut Vec<u8>, dst: Reg, base: Reg, index: Reg, scale: u8) {
    emit_byte(code, rex(true, dst.high(), index.high(), base.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xBF);
    emit_modrm_sib_mem(code, dst, base, index, scale, 0);
}

/// `MOVZX r64, [base + index * scale]` (16-bit) -- 16-bit unsigned
/// indexed load.
pub(crate) fn emit_movzx_r_sib16(code: &mut Vec<u8>, dst: Reg, base: Reg, index: Reg, scale: u8) {
    emit_byte(code, rex(true, dst.high(), index.high(), base.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xB7);
    emit_modrm_sib_mem(code, dst, base, index, scale, 0);
}

/// `MOVSX r64, [base + index * scale]` (8-bit) -- 8-bit signed
/// indexed load.
pub(crate) fn emit_movsx_r_sib8(code: &mut Vec<u8>, dst: Reg, base: Reg, index: Reg, scale: u8) {
    emit_byte(code, rex(true, dst.high(), index.high(), base.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xBE);
    emit_modrm_sib_mem(code, dst, base, index, scale, 0);
}

/// `MOVZX r64, [base + index * scale]` (8-bit) -- 8-bit unsigned
/// indexed load.
pub(crate) fn emit_movzx_r_sib8(code: &mut Vec<u8>, dst: Reg, base: Reg, index: Reg, scale: u8) {
    emit_byte(code, rex(true, dst.high(), index.high(), base.high()));
    emit_byte(code, 0x0F);
    emit_byte(code, 0xB6);
    emit_modrm_sib_mem(code, dst, base, index, scale, 0);
}

/// `MOV [base + index * scale], r64` -- 64-bit indexed store.
pub(crate) fn emit_mov_sib_r(code: &mut Vec<u8>, base: Reg, index: Reg, scale: u8, src: Reg) {
    emit_byte(code, rex(true, src.high(), index.high(), base.high()));
    emit_byte(code, 0x89);
    emit_modrm_sib_mem(code, src, base, index, scale, 0);
}

/// `MOV [base + index * scale], r32` -- 32-bit indexed store.
pub(crate) fn emit_mov_sib_r32(code: &mut Vec<u8>, base: Reg, index: Reg, scale: u8, src: Reg) {
    let needs_rex = src.high() || index.high() || base.high();
    if needs_rex {
        emit_byte(code, rex(false, src.high(), index.high(), base.high()));
    }
    emit_byte(code, 0x89);
    emit_modrm_sib_mem(code, src, base, index, scale, 0);
}

/// `MOV [base + index * scale], r16` -- 16-bit indexed store.
/// Operand-size prefix 66h selects 16-bit, then the standard REX is
/// optional based on register banks.
pub(crate) fn emit_mov_sib_r16(code: &mut Vec<u8>, base: Reg, index: Reg, scale: u8, src: Reg) {
    emit_byte(code, 0x66);
    let needs_rex = src.high() || index.high() || base.high();
    if needs_rex {
        emit_byte(code, rex(false, src.high(), index.high(), base.high()));
    }
    emit_byte(code, 0x89);
    emit_modrm_sib_mem(code, src, base, index, scale, 0);
}

/// `MOV [base + index * scale], r8` -- 8-bit indexed store.
/// Uses opcode 88h (MOV r/m8, r8). Any high-bank operand forces a
/// REX byte (which also picks the new-8-bit subreg encoding for
/// rsi/rdi/rbp/rsp instead of their legacy AH/BH/CH/DH halves).
pub(crate) fn emit_mov_sib_r8(code: &mut Vec<u8>, base: Reg, index: Reg, scale: u8, src: Reg) {
    let needs_rex = src.high() || index.high() || base.high() || src.lo() >= 4;
    if needs_rex {
        emit_byte(code, rex(false, src.high(), index.high(), base.high()));
    }
    emit_byte(code, 0x88);
    emit_modrm_sib_mem(code, src, base, index, scale, 0);
}

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

/// Length of the libc-routed `_start` stub: 14 bytes of prefix
/// (mov rdi, [rsp]; lea rsi, [rsp+8]; call rel32) +
/// 3 bytes of `mov rdi, rax` + 6 bytes of `call qword [rip+disp32]`.
/// The kernel hands `_start` rsp at a 16-byte boundary
/// (AMD64 ABI process-entry state), so leaving rsp untouched
/// keeps the caller-side `0 mod 16` SysV requires before `call`:
/// the call's return-address push then lands main at
/// `(%rsp + 8) % 16 == 0` per ABI 3.4.1.
pub(crate) const START_STUB_LEN: u64 = 23;
/// Length of the syscall-tail `_start` stub. One byte
/// longer than the libc tail because `mov eax, 231` (5 bytes) +
/// `syscall` (2 bytes) totals 7 vs. the libc tail's `call
/// qword [rip+disp32]` (6 bytes).
pub(crate) const START_STUB_LEN_SYSCALL: u64 = 24;

/// Emit the `_start` prologue. When `use_libc_exit` is true, the
/// stub's tail is `call qword [rip+disp32]` through the libc
/// `exit` GOT slot, and we return `Some(byte_offset)` so the
/// writer can register a GotFixup against it. When false (gh
/// #69), the stub direct-syscalls `sys_exit_group` (Linux
/// x86_64 syscall 231) and we return `None` -- the resulting
/// binary has no libc dependency.
pub(crate) fn emit_start_stub(
    code: &mut Vec<u8>,
    abi: Abi,
    main_offset_in_code: u64,
    use_libc_exit: bool,
) -> Option<usize> {
    let stub_start = code.len();

    // argc / argv go in the first two of the ABI's
    // int-arg-passing registers. SysV picks rdi, rsi here; a
    // hypothetical Linux x86_64 ABI variant with a different
    // arg register would only need to flip `Target::abi`.
    let argc_reg = Reg(abi.int_arg_regs[0]);
    let argv_reg = Reg(abi.int_arg_regs[1]);
    // mov <argc>, [rsp]         -- argc lives at the kernel-pushed
    //                              stack top; reading via memory
    //                              keeps rsp at its kernel-aligned
    //                              16-byte boundary so the `call`
    //                              below lands `main` at the
    //                              `(%rsp + 8) % 16 == 0` callee
    //                              entry state SysV 3.4.1 requires.
    //                              Using `pop` instead would shift
    //                              rsp by 8 and misalign every
    //                              SSE-aligned spill in glibc on
    //                              real Intel hardware (QEMU
    //                              tolerates the misalignment).
    emit_mov_r_mem(code, argc_reg, Reg::RSP, 0);
    // lea <argv>, [rsp + 8]     -- argv array starts one slot up.
    emit_lea_r_mem(code, argv_reg, Reg::RSP, 8);

    // call main. Target byte offset (within the code blob) is
    // start_stub_len + main_offset_in_code; the rel32 for `call`
    // is measured from the byte *after* the 5-byte `call`
    // instruction. Syscall vs libc tails differ by 1 byte,
    // so the math has to track which we picked.
    let call_byte_off = (code.len() - stub_start) as i64;
    let after_call = call_byte_off + 5;
    let stub_len = if use_libc_exit {
        START_STUB_LEN
    } else {
        START_STUB_LEN_SYSCALL
    };
    let main_byte = (stub_len as i64) + main_offset_in_code as i64;
    let rel32 = (main_byte - after_call) as i32;
    emit_call_rel32(code, rel32);

    // Move main's return value into the ABI's first int-arg
    // register (= libc `exit`'s / sys_exit_group's 1st parameter).
    emit_mov_rr(code, argc_reg, Reg::RAX);

    let result = if use_libc_exit {
        // call qword [rip + disp32] -- placeholder, writer
        // patches the disp32 to point at the libc `exit` GOT
        // slot.
        let exit_call_offset = code.len() - stub_start;
        emit_call_qword_rip32(code, 0);
        Some(stub_start + exit_call_offset)
    } else {
        // Linux x86_64 sys_exit_group = 231. Status is
        // already in rdi from the mov above.
        // mov eax, 231 (5 bytes)
        code.extend_from_slice(&[0xb8, 0xe7, 0x00, 0x00, 0x00]);
        // syscall (2 bytes)
        code.extend_from_slice(&[0x0f, 0x05]);
        None
    };

    debug_assert_eq!(
        (code.len() - stub_start) as u64,
        stub_len,
        "_start stub length mismatch"
    );
    result
}

// ------------------------------------------------------------------
// Branch fixups. Bytecode branches target absolute ent_pcs, but
// the native PC of those targets isn't known until the whole function
// body is laid out. Two-pass approach mirrors aarch64.rs: emit a
// 5-byte (jmp / call) or 6-byte (jcc) placeholder, record (offset,
// target bc PC, kind), patch after the walk.
// ------------------------------------------------------------------

#[derive(Debug, Clone, Copy)]
pub(crate) enum BranchKind {
    Jmp,
    Jcc(Cc),
    Call,
}

#[derive(Debug, Clone, Copy)]
pub(crate) struct Fixup {
    /// Byte offset within `code` of the placeholder's first byte.
    pub(crate) native_offset: usize,
    pub(crate) target_ent_pc: usize,
    pub(crate) kind: BranchKind,
}

/// Translate a c5 address-of-local offset (in 8-byte VM-slot
/// units) into the matching native byte offset from rbp. Same
/// convention as the aarch64 backend: locals (val < 2) keep
/// `* 8`; args (val >= 2) switch to `* 16` because the
/// accumulator push writes 16-byte slots so SP stays aligned at
/// libc-call sites.
fn lea_offset_bytes(offset: i64) -> i64 {
    if offset >= 2 {
        (offset - 1) * 16
    } else {
        offset * 8
    }
}

// ------------------------------------------------------------------
// Lowering pass. Walks every SSA function once, emits native code
// per Inst, and records branch fixups for later patching. Mirrors
// aarch64::lower.
// ------------------------------------------------------------------

pub(crate) fn lower(
    program: &Program,
    target: Target,
    #[cfg_attr(not(feature = "std"), allow(unused_variables))] native: NativeOptions,
    imports: &super::ResolvedImports,
) -> Result<Build, C5Error> {
    let mut code: Vec<u8> = Vec::new();
    let mut func_ent_pcs: Vec<usize> = Vec::new();
    let mut func_names: Vec<alloc::string::String> = Vec::new();
    let mut func_prologue_native: alloc::collections::BTreeMap<usize, usize> =
        alloc::collections::BTreeMap::new();
    let mut fn_unwind: Vec<super::FnUnwind> = Vec::new();
    let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();
    let mut fixups: Vec<Fixup> = Vec::new();
    let mut data_fixups: Vec<DataFixup> = Vec::new();
    let mut user_extern_data_refs: Vec<super::UserExternDataRef> = Vec::new();
    let mut got_fixups: Vec<GotFixup> = Vec::new();
    // Each `JsrExt` / `TailExt` site records a `CALL rel32`
    // / `JMP rel32` placeholder; displacements get backfilled once
    // trampolines are appended to `code`. Mirrors the aarch64 path.
    let mut plt_call_fixups: Vec<PltCallFixup> = Vec::new();
    // Function-pointer Imms get their target resolved post-walk
    // against `pc_to_native`, mirroring aarch64::lower.
    let mut pending_func_fixups: Vec<(usize, usize)> = Vec::new();
    // Win64 TLS-index fixups -- one entry per `Inst::TlsAddr`
    // lowering site when targeting Windows. The PE writer reserves
    // the `_tls_index` DWORD slot and patches each fixup with the
    // displacement to it.
    let mut tls_index_fixups: Vec<super::TlsIndexFixup> = Vec::new();
    // TLS access fixups (Linux/x86_64). Each `Inst::TlsAddr` site
    // records a `sub` immediate the linker patches with the variable's
    // TPOFF once the units' TLS blocks are merged.
    let mut elf_tpoff_fixups: Vec<super::ElfTpoffFixup> = Vec::new();
    // Lift the program into SSA once and run the linear-scan
    // allocator per function. Each function lowers through
    // `ssa_emit_x86_64::emit_function`; a per-function emit bail
    // is a hard error so any IR + emit coverage gap surfaces
    // immediately.
    let mut ssa_funcs: alloc::vec::Vec<super::super::ir::FunctionSsa> =
        super::ssa::emit_common::time_pass("ssa::produce_ssa_funcs (x86_64)", || {
            super::ssa::shadow::produce_ssa_funcs(program, target)
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
            super::ssa::emit_common::time_pass("ssa::slot_coalesce::run (x86_64)", || {
                super::ssa::slot_coalesce::run(&mut ssa_funcs)
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
        super::ssa::emit_common::time_pass("ssa::mem2reg::run (x86_64)", || {
            for f in &mut ssa_funcs {
                let promoted = super::ssa::mem2reg::run(f);
                if !promoted.is_empty() {
                    promoted_local_slots.insert(f.ent_pc, promoted);
                }
            }
        });
        // Inline after mem2reg so the candidate filter sees the
        // promoted form: dead cell loads / stores are gone and the
        // callee's body reads its parameters via `ParamRef`.
        super::ssa::emit_common::time_pass("passes::inline::run (x86_64)", || {
            crate::c5::codegen::passes::inline::run(
                &mut ssa_funcs,
                native.inline_cap,
                target.abi(),
            );
        });
        // Forward an inlined one-word struct return out of its frame slot:
        // a single full-width store + slot reads collapse to the stored
        // register value. Runs after the inliner produces the slot and
        // before store-forwarding cleans up any second-hop reload.
        super::ssa::emit_common::time_pass("passes::struct_return_reg::run (x86_64)", || {
            crate::c5::codegen::passes::struct_return_reg::run(&mut ssa_funcs);
        });
        // Rotate idiom recognition: collapses `(x >> c) | (x << (W -
        // c))` chains to `BinopI(Ror, x, c)`. Runs after the inliner
        // so post-inline parameter substitutions expose the constant
        // rotate counts.
        super::ssa::emit_common::time_pass("passes::rotate::run (x86_64)", || {
            crate::c5::codegen::passes::rotate::run(&mut ssa_funcs);
        });
        // Fused multiply-add contraction (C99 6.5p8 / FP_CONTRACT ON at
        // -O). Runs after the inliner so products exposed by parameter
        // substitution into an add/sub become contractible.
        super::ssa::emit_common::time_pass("passes::fma::run (x86_64)", || {
            crate::c5::codegen::passes::fma::run(&mut ssa_funcs);
        });
        super::ssa::emit_common::time_pass("passes::constfold_branch::run (x86_64)", || {
            crate::c5::codegen::passes::constfold_branch::run(&mut ssa_funcs);
        });
        super::ssa::emit_common::time_pass("passes::split_crit_edges::run (x86_64)", || {
            crate::c5::codegen::passes::split_crit_edges::run(&mut ssa_funcs);
        });
        super::ssa::emit_common::time_pass("passes::dedup_imm::run (x86_64)", || {
            crate::c5::codegen::passes::dedup_imm::run(&mut ssa_funcs);
        });
        super::ssa::emit_common::time_pass("passes::drop_redundant_extend::run (x86_64)", || {
            crate::c5::codegen::passes::drop_redundant_extend::run(&mut ssa_funcs);
        });
        // Scaled-index addressing: fold `base + index*scale` into the
        // load / store. Runs last so it sees the final address shape;
        // the optimizer passes never traverse `LoadIndexed` /
        // `StoreIndexed`, so the per-arch emit is the only later consumer.
        super::ssa::emit_common::time_pass("passes::index_fold::run (x86_64)", || {
            crate::c5::codegen::passes::index_fold::run(&mut ssa_funcs);
        });
        // Store-to-load and load-to-load forwarding within a block. Runs
        // after the index fold so a struct field's store and load address
        // are both normalised to the same `(base, disp)`. Bounded by
        // live-range extension so it does not pin scattered re-reads in a
        // register-starved unrolled loop.
        super::ssa::emit_common::time_pass("passes::store_forward::run (x86_64)", || {
            crate::c5::codegen::passes::store_forward::run(&mut ssa_funcs);
        });
    }
    // Upper bound on ent_pcs the lowering will reference. The
    // walker stamps `ent_pc` / `end_pc` against the ent_pc
    // space, and the dense `pc_to_native` table holds
    // every reachable PC.
    let pc_extent = super::pc_extent_for_lowering(program, &ssa_funcs);
    let mut pc_to_native: Vec<usize> = alloc::vec![usize::MAX; pc_extent + 1];
    // Per-callee variadic flag, derived from FunctionSsa::is_variadic.
    // Each call site reads it to pick the host-ABI vs c5-stack arg
    // passing shape for the callee.
    let mut variadic_targets: alloc::collections::BTreeSet<usize> = ssa_funcs
        .iter()
        .filter(|f| f.is_variadic)
        .map(|f| f.ent_pc)
        .collect();
    // Cross-TU extern variadic callees too: see the matching
    // comment on the aarch64 lowering's `variadic_targets`.
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
    let ssa_allocs: alloc::vec::Vec<super::ssa::reg_alloc::Allocation> =
        super::ssa::emit_common::time_pass("ssa::reg_alloc::allocate (x86_64)", || {
            ssa_funcs
                .iter()
                .map(|f| super::ssa::reg_alloc::allocate(f, target))
                .collect()
        });
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
        let extern_tls_names: alloc::collections::BTreeMap<u32, alloc::string::String> = func_ssa
            .extern_tls_refs
            .iter()
            .map(|(v, sym_idx)| (*v, program.symbols[*sym_idx as usize].name.clone()))
            .collect();
        let ok = {
            let mut cx = super::ssa::emit_common::EmitCtx {
                code: &mut code,
                plt_call_fixups: &mut plt_call_fixups,
                data_fixups: &mut data_fixups,
                user_extern_data_refs: &mut user_extern_data_refs,
                pending_func_fixups: &mut pending_func_fixups,
                tls_index_fixups: &mut tls_index_fixups,
                elf_tpoff_fixups: &mut elf_tpoff_fixups,
                ssa_line_rows: &mut ssa_line_rows,
                pc_to_native: &mut pc_to_native,
                prologue_native: &mut func_prologue_native,
            };
            super::emit::emit_function(
                func_ssa,
                alloc_for,
                target,
                &mut cx,
                &mut fixups,
                &mut got_fixups,
                &extern_data_names,
                &extern_tls_names,
                imports,
                &variadic_targets,
                program.tls_data.len(),
                &mut fn_unwind,
            )
        };
        #[cfg(feature = "std")]
        if super::ssa::dump::enabled(native) {
            eprintln!(
                "; --- SSA dump (ok={ok}) ent_pc={ent_pc} ---",
                ok = ok,
                ent_pc = ent_pc,
            );
            eprintln!("; name={}", func_ssa.name);
            eprint!("{}", super::ssa::dump::dump_function(func_ssa, alloc_for),);
        }
        if !ok {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &alloc::format!(
                    "ssa emit (x86_64): function `{}` (ent_pc {ent_pc}) contains an op outside the implemented subset",
                    func_ssa.name,
                ),
            )));
        }
    }
    #[cfg(feature = "std")]
    if super::ssa::emit_common::time_passes_enabled() {
        let us = _ssa_emit_pass_start.elapsed().as_micros();
        eprintln!("pass: ssa_emit_x86_64 (block walk) -- {us}us");
    }
    pc_to_native[pc_extent] = code.len();

    // Cross-TU user-function imports surfaced by the parser as
    // placeholder ent_pcs past `text.len()`. Each `Inst::Call`
    // emits a `Fixup::Call` with `target_ent_pc` equal to
    // the placeholder; we partition those out before
    // `apply_fixups` and re-emit them as
    // `Build::user_extern_call_sites` entries that the writer
    // surfaces as `R_X86_64_PLT32` relocs against the
    // callee's symbol.
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
                let is_tail = matches!(f.kind, BranchKind::Jmp);
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

    // Append one PLT trampoline per import. CALL rel32 /
    // JMP rel32 placeholders recorded in `plt_call_fixups` get
    // their disp32 backfilled to the matching trampoline. The
    // trampoline body is a single `JMP qword ptr [rip + disp32]`
    // patched by the per-format writer via `GotFixup`.
    // Capture call sites before the PLT-fixup pass rewrites the
    // disp32 fields. The `OutputKind::Relocatable` writer reads
    // these to emit `R_X86_64_PLT32` relocations against each
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
    // the tail of `.text` and rewrites every CALL/JMP rel32
    // placeholder to reach the matching trampoline. Relocatable
    // output leaves the placeholders raw (disp32 = 0) so the
    // linker materialises the PLT pool when it produces the
    // final image -- the matching `R_X86_64_PLT32` reloc in
    // `.rela.text` carries the call site's import symbol.
    let plt_trampoline_offsets: Vec<usize> = if native.output_kind != super::OutputKind::Relocatable
    {
        let offsets = emit_plt_trampolines(&mut code, &mut got_fixups, imports.imports.len());
        apply_plt_call_fixups(&mut code, &plt_call_fixups, &offsets)?;
        offsets
    } else {
        Vec::new()
    };

    // Function-pointer fixups land on the callee's body offset
    // directly: every non-variadic function's prologue spills host
    // arg registers into c5 cdecl slots before the body runs, so
    // a host caller (`pthread_create`, `CreateThread`, `qsort`,
    // a static dispatch table) can call the body straight. Variadic
    // c5 functions keep the c5-stack-based ABI and reach only via
    // indirect c5 callers that lay args onto the c5 stack first;
    // their fn-pointer fixups also land on the body, which keeps
    // that contract intact.
    let mut func_fixups: Vec<FuncFixup> = Vec::with_capacity(pending_func_fixups.len());
    for (instr_offset, target_ent_pc) in pending_func_fixups {
        // Cross-TU target: the placeholder ent_pc has no entry in
        // `pc_to_native`. Route to the named-symbol channel that
        // data extern refs use; the linker resolves the LEA's
        // disp32 (or the writer's named reloc) to `text_vaddr +
        // target` via the data_abs_relocs Text-section path.
        // Mirrors the aarch64 lowering's identical short-circuit.
        if let Some(&name) = extern_pc_lookup.get(&target_ent_pc) {
            user_extern_data_refs.push(super::UserExternDataRef {
                instr_offset,
                symbol_name: (*name).into(),
            });
            continue;
        }
        if target_ent_pc > pc_extent {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen (x86_64): function pointer target {target_ent_pc} past end of PC space"
                ),
            )));
        }
        let target = pc_to_native[target_ent_pc];
        if target == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen (x86_64): function pointer target {target_ent_pc} did not land on an instruction"
                ),
            )));
        }
        func_fixups.push(FuncFixup {
            adrp_offset: instr_offset,
            target_native_offset: target,
        });
    }

    // Address-of-import sites (`&strcmp`, `Inst::ImmExtCode`) in the
    // local-image path resolve to the import's PLT trampoline, the
    // same stub a call to the import reaches. The trampoline offset
    // is known once `emit_plt_trampolines` has run; a `FuncFixup`
    // routes the `lea`'s disp32 through the writer's func-fixup pass
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
        let off = pc_to_native
            .get(program.entry_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if off == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen (x86_64): entry_pc {} did not align with any instruction start",
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
        data_align: program.data_align,
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
        fn_unwind,
        reloc_call_sites,
        user_extern_call_sites,
        user_extern_data_refs,
        ssa_line_rows,
        // Set by `lower_for` after this returns; see the matching
        // comment on the aarch64 lowering's `Build` construction.
        imports: super::ResolvedImports::default(),
        abi: super::Abi::default(),
        tls_data: program.tls_data.clone(),
        tls_init_size: program.tls_init_size,
        tls_index_fixups,
        elf_tpoff_fixups,
        data_relocs: Vec::new(),
        extern_data_relocs: Vec::new(),
        code_relocs: Vec::new(),
        exports: Vec::new(),
        dynamic_exports: Vec::new(),
        output_kind: super::OutputKind::Executable,
        shared_lib_name: None,
        dllmain_pc: None,
        // Mach-O TLV is arm64-only on Apple Silicon; x86_64 macOS
        // is not in our target list.
        macho_tlv_fixups: Vec::new(),
        macho_tlv_descriptors: Vec::new(),
        // Overwritten by `lower_for` from `NativeOptions::debug_info`.
        debug_info: true,
        merged_dwarf: None,
        plt_trampoline_offsets,
    })
}

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
                    "native codegen (x86_64): branch target {} past end of PC space",
                    f.target_ent_pc
                ),
            )));
        }
        let target = pc_to_native[f.target_ent_pc];
        if target == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "native codegen (x86_64): branch target {} did not land on an instruction",
                    f.target_ent_pc
                ),
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

pub(crate) use super::PltCallFixup;

/// Append one PLT trampoline per import. Each trampoline is a
/// single 6-byte `JMP qword ptr [rip + disp32]` whose disp32 is
/// patched by the per-format writer (via the recorded
/// `GotFixup`) to point at the GOT/IAT slot. libc's `RET`
/// returns directly to the original `CALL rel32` caller, so the
/// trampoline costs one branch on the call path -- predicted
/// after the first hit.
fn emit_plt_trampolines(
    code: &mut Vec<u8>,
    got_fixups: &mut Vec<GotFixup>,
    n_imports: usize,
) -> Vec<usize> {
    let mut offsets = Vec::with_capacity(n_imports);
    for import_index in 0..n_imports {
        let tramp_off = code.len();
        offsets.push(tramp_off);
        // Same `GotFixup` shape the inline indirect-call site used
        // pre-#61. The writer reads `adrp_offset` as the byte
        // position of the instruction whose disp32 needs the
        // GOT-slot RVA; the JMP's encoding puts disp32 at byte 2.
        got_fixups.push(GotFixup {
            adrp_offset: tramp_off,
            import_index,
            is_data_load: false,
        });
        emit_jmp_qword_rip32(code, 0);
    }
    offsets
}

/// Resolve every `PltCallFixup` against the trampoline byte
/// offsets. CALL rel32 / JMP rel32 measure their displacement
/// from the byte just past the instruction (5 bytes long).
fn apply_plt_call_fixups(
    code: &mut [u8],
    fixups: &[PltCallFixup],
    trampoline_offsets: &[usize],
) -> Result<(), C5Error> {
    const REL32_INSTR_LEN: usize = 5;
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
        if fx.is_addr {
            // Address-of sites (`lea` taking the import's address)
            // resolve through a `FuncFixup` to the trampoline offset
            // in the local-image path, so the writer's func-fixup
            // pass patches them. Nothing to do here.
            continue;
        }
        let after = fx.instr_offset + REL32_INSTR_LEN;
        let rel32 = (tramp_off as i64 - after as i64) as i32;
        // Opcode byte at instr_offset: 0xE8 (CALL rel32) or
        // 0xE9 (JMP rel32). The lower-pass already wrote the
        // correct opcode; we only patch the disp32 field at
        // `instr_offset + 1`.
        code[fx.instr_offset + 1..fx.instr_offset + 1 + 4].copy_from_slice(&rel32.to_le_bytes());
    }
    Ok(())
}

/// Recover a function's Win64 unwind descriptor from its emitted
/// prologue bytes. Used by the multi-TU link path, which holds the
/// merged `.text` and each function's `[begin, end)` extent but not
/// the structured [`super::FnUnwind`] the single-TU lowering records
/// directly. The decode matches this backend's own fixed prologue
/// grammar, not arbitrary machine code:
///
/// * optional arg-spill group: `41 5A` (pop r10), `48 81 EC <M>`
///   (sub rsp,M), spill stores, `41 52` (push r10);
/// * standard frame: `55` (push rbp), `48 89 E5` (mov rbp,rsp),
///   optional `48 81 EC <N>` (sub rsp,N) -- a larger frame lowers
///   to a page-probe loop, which has no single `sub` to read, so
///   the alloc is left out of the codes (the body still unwinds
///   through the frame pointer);
/// * leaf functions emit none of the above.
///
/// The frame-pointer save/establish pair is matched as the 6-byte
/// unit `41 52 55 48 89 E5` (arg-spill) or `55 48 89 E5` at offset 0
/// (no arg-spill), both at instruction boundaries, so a spill
/// store's bytes cannot alias the match. Any shape that does not
/// match a standard frame is described as a frameless leaf -- safe
/// (the unwinder returns off the top-of-stack RA) rather than
/// emitting codes that do not match the prologue.
pub(crate) fn decode_x86_64_prologue_unwind(
    text: &[u8],
    begin: u32,
    end: u32,
    prologue_end: u32,
) -> super::FnUnwind {
    let mut uw = super::FnUnwind {
        begin,
        end,
        leaf: true,
        ..super::FnUnwind::default()
    };
    let b = begin as usize;
    let pe = (prologue_end as usize).min(text.len());
    if b >= pe {
        return uw;
    }
    let read_sub_rsp = |at: usize| -> Option<u32> {
        // `sub rsp, imm32` == REX.W 0x81 /5 (modrm 0xEC) + imm32.
        if at + 7 <= text.len() && text[at] == 0x48 && text[at + 1] == 0x81 && text[at + 2] == 0xEC
        {
            Some(u32::from_le_bytes([
                text[at + 3],
                text[at + 4],
                text[at + 5],
                text[at + 6],
            ]))
        } else {
            None
        }
    };
    // Locate the `push rbp; mov rbp,rsp` pair that establishes the
    // frame. Without an arg-spill group it is at offset 0; with one it
    // follows the group's `push r10` as the 6-byte unit below.
    let no_spill = text[b..].starts_with(&[0x55, 0x48, 0x89, 0xE5]);
    let fp_at = if no_spill {
        Some(b)
    } else if text[b..].starts_with(&[0x41, 0x5A]) {
        // Arg-spill present: `sub rsp,M` sits right after `pop r10`.
        if let Some(m) = read_sub_rsp(b + 2) {
            uw.param_spill_bytes = m;
        }
        let unit = [0x41u8, 0x52, 0x55, 0x48, 0x89, 0xE5];
        text[b..pe]
            .windows(unit.len())
            .position(|w| w == unit)
            .map(|p| {
                // `arg_spill_end` is just past `push r10` (the first two
                // bytes of the matched unit); `push rbp` starts after.
                // All `*_end` offsets are relative to the function start.
                uw.arg_spill_end = (p + 2) as u32;
                b + p + 2
            })
    } else {
        None
    };
    let Some(fp) = fp_at else {
        return uw; // Unrecognised shape -> safe frameless leaf.
    };
    uw.leaf = false;
    uw.push_rbp_end = (fp - b + 1) as u32;
    uw.set_fpreg_end = (fp - b + 4) as u32;
    if let Some(n) = read_sub_rsp(fp + 4) {
        uw.frame_bytes = n;
        uw.frame_alloc_end = (fp - b + 4 + 7) as u32;
    }
    uw
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
    fn test_rax_rax_is_three_bytes() {
        // test rax, rax  ->  48 85 C0 -- the compare-with-zero form,
        // shorter than `cmp rax, 0` (48 81 F8 00 00 00 00).
        assert_eq!(
            assemble(|c| emit_test_rr(c, Reg::RAX, Reg::RAX)),
            vec![0x48, 0x85, 0xC0]
        );
    }

    #[test]
    fn short_branch_encodings() {
        // jmp rel8  ->  EB cb (2 bytes), vs the 5-byte E9 rel32 form.
        assert_eq!(assemble(|c| emit_jmp_rel8(c, 0x10)), vec![0xEB, 0x10]);
        assert_eq!(assemble(|c| emit_jmp_rel8(c, -2)), vec![0xEB, 0xFE]);
        // jcc rel8  ->  (0x70 | cc) cb (2 bytes), vs the 6-byte
        // 0F 8x rel32 form. je -> 74, jne -> 75, jl -> 7C.
        assert_eq!(
            assemble(|c| emit_jcc_rel8(c, Cc::E, 0x05)),
            vec![0x74, 0x05]
        );
        assert_eq!(
            assemble(|c| emit_jcc_rel8(c, Cc::Ne, 0x05)),
            vec![0x75, 0x05]
        );
        assert_eq!(assemble(|c| emit_jcc_rel8(c, Cc::L, -4)), vec![0x7C, 0xFC]);
    }

    #[test]
    fn vfma231_encodings() {
        // vfmadd231sd xmm0, xmm1, xmm2  ->  C4 E2 F1 B9 C2
        assert_eq!(
            assemble(|c| emit_vfmadd231sd(c, Reg(0), Reg(1), Reg(2))),
            vec![0xC4, 0xE2, 0xF1, 0xB9, 0xC2]
        );
        // vfmsub231sd xmm0, xmm1, xmm2  ->  C4 E2 F1 BB C2
        assert_eq!(
            assemble(|c| emit_vfmsub231sd(c, Reg(0), Reg(1), Reg(2))),
            vec![0xC4, 0xE2, 0xF1, 0xBB, 0xC2]
        );
        // vfnmadd231sd xmm0, xmm1, xmm2 ->  C4 E2 F1 BD C2
        assert_eq!(
            assemble(|c| emit_vfnmadd231sd(c, Reg(0), Reg(1), Reg(2))),
            vec![0xC4, 0xE2, 0xF1, 0xBD, 0xC2]
        );
        // vfnmsub231sd xmm0, xmm1, xmm2 ->  C4 E2 F1 BF C2
        assert_eq!(
            assemble(|c| emit_vfnmsub231sd(c, Reg(0), Reg(1), Reg(2))),
            vec![0xC4, 0xE2, 0xF1, 0xBF, 0xC2]
        );
        // Single-precision clears VEX.W: vfmadd231ss xmm0, xmm1, xmm2
        //   ->  C4 E2 71 B9 C2
        assert_eq!(
            assemble(|c| emit_vfmadd231ss(c, Reg(0), Reg(1), Reg(2))),
            vec![0xC4, 0xE2, 0x71, 0xB9, 0xC2]
        );
        // Extended registers clear VEX.R / VEX.B: vfmadd231sd xmm8,
        // xmm9, xmm10  ->  C4 42 B1 B9 C2
        assert_eq!(
            assemble(|c| emit_vfmadd231sd(c, Reg(8), Reg(9), Reg(10))),
            vec![0xC4, 0x42, 0xB1, 0xB9, 0xC2]
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
    fn mov_rr_self_is_elided() {
        // mov r13, r13 -- no bytes. Same for rax, rax (which would
        // cost a REX even if the encoder chose the no-REX form).
        assert!(assemble(|c| emit_mov_rr(c, Reg::R13, Reg::R13)).is_empty());
        assert!(assemble(|c| emit_mov_rr(c, Reg::RAX, Reg::RAX)).is_empty());
        // Distinct regs still produce the 3-byte mov.
        assert_eq!(assemble(|c| emit_mov_rr(c, Reg::R13, Reg::RAX)).len(), 3);
    }

    #[test]
    fn cc_flip_round_trips() {
        for c in [Cc::E, Cc::Ne, Cc::L, Cc::Ge, Cc::G, Cc::Le] {
            assert_eq!(c.flip().flip(), c, "double flip should be identity");
        }
        assert_eq!(Cc::E.flip(), Cc::Ne);
        assert_eq!(Cc::L.flip(), Cc::Ge);
        assert_eq!(Cc::G.flip(), Cc::Le);
    }

    #[test]
    fn mov_r13_imm64() {
        // mov r13, 42 -> short form (5 bytes, zero-extends).
        // 41 BD 2A 00 00 00
        assert_eq!(
            assemble(|c| emit_mov_r_imm64(c, Reg::R13, 42)),
            vec![0x41, 0xBD, 0x2A, 0, 0, 0]
        );
    }

    #[test]
    fn mov_r_imm64_zero_uses_xor() {
        // mov rax, 0 -> xor rax, rax (3 bytes through the shared
        // 64-bit alu encoder).
        assert_eq!(
            assemble(|c| emit_mov_r_imm64(c, Reg::RAX, 0)),
            vec![0x48, 0x31, 0xC0]
        );
    }

    #[test]
    fn mov_r_imm64_negative_keeps_long_form() {
        // mov rax, -1 -> 48 B8 FF FF FF FF FF FF FF FF
        // Negative immediates need the 10-byte REX.W form so the
        // sign-extension reaches the top of rax.
        assert_eq!(
            assemble(|c| emit_mov_r_imm64(c, Reg::RAX, -1)),
            vec![0x48, 0xB8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]
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
        let exit_off = emit_start_stub(&mut buf, super::super::Target::LinuxX64.abi(), 0, true);
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
        assert_eq!(exit_off, Some(17));
        assert_eq!(
            &buf[17..23],
            &[0xFF, 0x15, 0x00, 0x00, 0x00, 0x00],
            "call qword [rip+0] placeholder"
        );
    }

    #[test]
    fn start_stub_syscall_tail_decodes_to_known_bytes() {
        // When no libc `exit` binding is in scope the
        // stub's tail is a direct sys_exit_group syscall (231)
        // instead of the libc-routed indirect call. Tail layout:
        //   mov rdi, rax        (3 bytes, rax = main's return)
        //   mov eax, 231        (5 bytes, sys_exit_group)
        //   syscall             (2 bytes)
        let mut buf = Vec::new();
        let exit_off = emit_start_stub(&mut buf, super::super::Target::LinuxX64.abi(), 0, false);
        assert_eq!(exit_off, None, "syscall tail returns no GotFixup offset");
        assert_eq!(buf.len() as u64, START_STUB_LEN_SYSCALL);
        // mov rdi, rax (= status from main's return value).
        assert_eq!(&buf[14..17], &[0x48, 0x89, 0xC7]);
        // mov eax, 231 (= sys_exit_group on Linux x86_64).
        assert_eq!(&buf[17..22], &[0xb8, 0xe7, 0x00, 0x00, 0x00]);
        // syscall.
        assert_eq!(&buf[22..24], &[0x0f, 0x05]);
    }

    /// `#pragma entrypoint(WinMain)` on Windows x64 must spill
    /// all four int-arg-register parameters (rcx/rdx/r8/r9) into
    /// the c5 frame. Probes the prologue bytes for each
    /// `mov [rsp], <reg>` form.
    #[test]
    fn winmain_4arg_prologue_spills_all_four_host_arg_regs() {
        use crate::Compiler;
        let src = "
            #pragma subsystem(windows)
            #pragma entrypoint(WinMain)
            int WinMain(long hinst, long prev, long cmdline, int show) {
                (void)hinst; (void)prev; (void)cmdline;
                return show;
            }
        ";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let imports = super::super::ResolvedImports::resolve(&program).expect("resolve");
        let build = super::lower(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
            &imports,
        )
        .expect("lower");

        let entry = build.entry_offset;
        // 128-byte window covers 4 spills + frame setup + pool
        // save without overlapping the function body.
        let prologue_end = (entry + 128).min(build.text.len());
        let prologue = &build.text[entry..prologue_end];

        // Each parameter spills into its positional c5 cdecl cell at
        // `[rsp + 16*i]`, so the four `mov [rsp+disp], <reg>` stores carry
        // the parameter's displacement (param 0 at disp 0, the rest at
        // disp8). Encodings:
        //   rcx -> [rsp+0x00]: 48 89 0C 24
        //   rdx -> [rsp+0x10]: 48 89 54 24 10
        //   r8  -> [rsp+0x20]: 4C 89 44 24 20
        //   r9  -> [rsp+0x30]: 4C 89 4C 24 30
        let contains = |needle: &[u8]| prologue.windows(needle.len()).any(|w| w == needle);
        assert!(
            contains(&[0x4C, 0x89, 0x4C, 0x24, 0x30]),
            "WinMain prologue must spill r9 (= nShowCmd) into the c5 frame; got {:02X?}",
            prologue
        );
        assert!(
            contains(&[0x4C, 0x89, 0x44, 0x24, 0x20]),
            "WinMain prologue must spill r8 (= lpCmdLine) into the c5 frame; got {:02X?}",
            prologue
        );
        assert!(
            contains(&[0x48, 0x89, 0x54, 0x24, 0x10]),
            "WinMain prologue must spill rdx (= hPrevInstance) into the c5 frame; got {:02X?}",
            prologue
        );
        assert!(
            contains(&[0x48, 0x89, 0x0C, 0x24]),
            "WinMain prologue must spill rcx (= hInstance) into the c5 frame; got {:02X?}",
            prologue
        );
    }

    /// Two-arg `main(argc, argv)`: prologue spills rcx and rdx
    /// on Win64, not r8 / r9.
    #[test]
    fn console_main_prologue_spills_only_argc_argv() {
        use crate::Compiler;
        let src = "int main(int argc, char **argv) { (void)argc; return (long)argv & 1; }";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let imports = super::super::ResolvedImports::resolve(&program).expect("resolve");
        let build = super::lower(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
            &imports,
        )
        .expect("lower");

        let entry = build.entry_offset;
        let prologue_end = (entry + 128).min(build.text.len());
        let prologue = &build.text[entry..prologue_end];
        // Positional c5 cdecl cells: argc (rcx) at [rsp+0x00], argv
        // (rdx) at [rsp+0x10]. r8 / r9 are not parameters, so no cell2 /
        // cell3 store appears.
        //   rcx -> [rsp+0x00]: 48 89 0C 24
        //   rdx -> [rsp+0x10]: 48 89 54 24 10
        //   r8  -> [rsp+0x20]: 4C 89 44 24 20  (absent)
        //   r9  -> [rsp+0x30]: 4C 89 4C 24 30  (absent)
        let contains = |needle: &[u8]| prologue.windows(needle.len()).any(|w| w == needle);
        assert!(
            contains(&[0x48, 0x89, 0x0C, 0x24]),
            "console main must spill rcx (= argc) into the c5 frame; got {:02X?}",
            prologue
        );
        assert!(
            contains(&[0x48, 0x89, 0x54, 0x24, 0x10]),
            "console main must spill rdx (= argv) into the c5 frame; got {:02X?}",
            prologue
        );
        assert!(
            !contains(&[0x4C, 0x89, 0x44, 0x24, 0x20]),
            "console main must NOT spill r8 (function has only 2 params); got {:02X?}",
            prologue
        );
        assert!(
            !contains(&[0x4C, 0x89, 0x4C, 0x24, 0x30]),
            "console main must NOT spill r9 (function has only 2 params); got {:02X?}",
            prologue
        );
    }

    // The atomic encodings below were cross-checked against
    // `clang -target x86_64-linux-gnu` + `objdump -d`.

    #[test]
    fn lock_xadd_qword_rcx_rax() {
        // lock xadd qword [rcx], rax -> F0 48 0F C1 01
        assert_eq!(
            assemble(|c| emit_lock_xadd_mem_r(c, Reg::RCX, 0, Reg::RAX, 8)),
            vec![0xF0, 0x48, 0x0F, 0xC1, 0x01]
        );
    }

    #[test]
    fn xchg_qword_rcx_rax() {
        // xchg qword [rcx], rax -> 48 87 01 (implicitly locked, no F0)
        assert_eq!(
            assemble(|c| emit_xchg_mem_r(c, Reg::RCX, 0, Reg::RAX, 8)),
            vec![0x48, 0x87, 0x01]
        );
    }

    #[test]
    fn lock_cmpxchg_qword_rcx_rdx() {
        // lock cmpxchg qword [rcx], rdx -> F0 48 0F B1 11
        assert_eq!(
            assemble(|c| emit_lock_cmpxchg_mem_r(c, Reg::RCX, 0, Reg::RDX, 8)),
            vec![0xF0, 0x48, 0x0F, 0xB1, 0x11]
        );
    }

    #[test]
    fn neg_rax() {
        // neg rax -> 48 F7 D8
        assert_eq!(
            assemble(|c| emit_neg_r(c, Reg::RAX)),
            vec![0x48, 0xF7, 0xD8]
        );
    }

    #[test]
    fn atomic_byte_op_emits_rex_and_byte_opcode() {
        // lock xadd byte [rax], cl -> F0 [REX] 0F C0 08. A byte access
        // always emits REX so SPL/BPL/SIL/DIL and R8B.. are addressable.
        let bytes = assemble(|c| emit_lock_xadd_mem_r(c, Reg::RAX, 0, Reg::RCX, 1));
        assert_eq!(bytes[0], 0xF0, "missing LOCK prefix");
        assert_eq!(bytes[1] & 0xF0, 0x40, "byte access must emit REX");
        assert_eq!(&bytes[2..4], &[0x0F, 0xC0], "byte XADD opcode");
    }

    #[test]
    fn atomic_word_op_emits_operand_size_prefix() {
        // lock cmpxchg word [rax], cx -> F0 66 0F B1 08.
        let bytes = assemble(|c| emit_lock_cmpxchg_mem_r(c, Reg::RAX, 0, Reg::RCX, 2));
        assert_eq!(&bytes[0..2], &[0xF0, 0x66], "LOCK + operand-size prefix");
        assert_eq!(&bytes[2..4], &[0x0F, 0xB1], "word CMPXCHG opcode");
    }
}

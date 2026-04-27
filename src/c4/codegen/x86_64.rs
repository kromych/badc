//! x86_64 instruction encoder + bytecode -> x86_64 lowering.
//!
//! M3.1 (this file, current state): just enough of the encoder
//! catalogue and the lowering pass to produce a "return 42" ELF that
//! exits cleanly. Full Op coverage and libc/data fixups land in
//! follow-on milestones (see the project memory).
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

use super::super::error::C4Error;
use super::super::op::Op;
use super::super::program::Program;
use super::{Build, Target, TargetOptions};

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
// We:
//   * load argc into rdi, argv into rsi (System V ABI: first two args)
//   * call main
//   * pass main's return value (rax) as the exit-syscall arg
//   * SYS_exit = 60 on Linux x86_64; nr in rax, arg in rdi
//
// M3.1 uses raw syscall exit -- libc isn't linked yet, so there's
// nothing to flush. M3.4 will switch to libc `exit` through the GOT
// once the dynamic-linking machinery comes online.
// ------------------------------------------------------------------

/// Length of the `_start` stub in bytes. Used by [`lower`] / the ELF
/// writer to compute branch offsets and segment sizes.
pub(super) const START_STUB_LEN: u64 = 24;

/// Emit the `_start` prologue. Returns `Ok(())` on success; the byte
/// length always equals [`START_STUB_LEN`].
pub(super) fn emit_start_stub(code: &mut Vec<u8>, main_offset_in_code: u64) {
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

    // mov rdi, rax              -- pass main's return into the exit
    //                              syscall's first arg.
    emit_mov_rr(code, Reg::RDI, Reg::RAX);

    // mov eax, 60               -- SYS_exit on Linux x86_64. Using
    //                              the 5-byte `mov r32, imm32` form
    //                              (no REX.W); writing eax zero-
    //                              extends into rax.
    emit_byte(code, 0xB8 | Reg::RAX.lo());
    emit_u32(code, 60);

    // syscall
    emit_syscall(code);

    debug_assert_eq!(
        (code.len() - stub_start) as u64,
        START_STUB_LEN,
        "_start stub length mismatch"
    );
}

// ------------------------------------------------------------------
// Lowering pass. M3.1 only handles Op::Ent / Op::Imm / Op::Lev --
// enough for `int main() { return 42; }`. Everything else returns a
// "not yet implemented" error so we don't ship a binary that
// silently misbehaves.
// ------------------------------------------------------------------

pub(super) fn lower(program: &Program, target: Target) -> Result<Build, C4Error> {
    let _options: TargetOptions = target.options();

    let mut code: Vec<u8> = Vec::new();
    let mut bytecode_to_native: Vec<usize> = alloc::vec![usize::MAX; program.text.len() + 1];

    // Walk the bytecode, dispatching per Op.
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
        lower_op(op, &program.text, &mut pc, &mut code)?;
    }
    bytecode_to_native[program.text.len()] = code.len();

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
        got_fixups: Vec::new(),
        data_fixups: Vec::new(),
        func_fixups: Vec::new(),
    })
}

fn lower_op(op: Op, text: &[i64], pc: &mut usize, code: &mut Vec<u8>) -> Result<(), C4Error> {
    match op {
        // ---- Function frame ----
        Op::Ent => {
            let locals = read_operand(text, pc, "Ent")?;
            emit_prologue(code, locals);
        }
        Op::Lev => {
            emit_epilogue(code);
        }

        // ---- Constants ----
        Op::Imm => {
            let v = read_operand(text, pc, "Imm")?;
            emit_mov_r_imm64(code, Reg::R13, v);
        }

        // Everything else lands here. M3.2+ will fill these in.
        _ => {
            return Err(C4Error::Compile(format!(
                "native codegen (x86_64): {op:?} not yet implemented (M3.1 covers Ent/Imm/Lev only)"
            )));
        }
    }
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
fn emit_prologue(code: &mut Vec<u8>, locals: i64) {
    emit_push_r(code, Reg::RBP);
    emit_mov_rr(code, Reg::RBP, Reg::RSP);
    if locals > 0 {
        let bytes = (locals as u32) * 8;
        // Keep rsp 16-aligned. After `push rbp` rsp was 8-misaligned
        // (call instruction pushed a 8-byte return addr, then we
        // pushed rbp) -- 16-byte total. So local space rounded up to
        // 16 keeps the alignment.
        let aligned = (bytes + 15) & !15;
        emit_sub_rsp_imm32(code, aligned);
    }
}

/// Mirror of [`emit_prologue`]. Move the VM accumulator into rax
/// (return register), tear down the frame, return.
fn emit_epilogue(code: &mut Vec<u8>) {
    emit_mov_rr(code, Reg::RAX, Reg::R13);
    emit_mov_rr(code, Reg::RSP, Reg::RBP);
    emit_pop_r(code, Reg::RBP);
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
        // immediately after the stub).
        let mut buf = Vec::new();
        emit_start_stub(&mut buf, 0);
        assert_eq!(buf.len() as u64, START_STUB_LEN);
        // First instruction: mov rdi, [rsp]  ->  48 8B 3C 24
        assert_eq!(&buf[0..4], &[0x48, 0x8B, 0x3C, 0x24]);
        // Second: lea rsi, [rsp+8]  ->  48 8D 74 24 08
        assert_eq!(&buf[4..9], &[0x48, 0x8D, 0x74, 0x24, 0x08]);
        // Third: call rel32 = (24 - (9+5)) = 10  ->  E8 0A 00 00 00
        assert_eq!(&buf[9..14], &[0xE8, 0x0A, 0x00, 0x00, 0x00]);
        // Last three: mov rdi, rax; mov eax, 60; syscall
        assert_eq!(&buf[14..17], &[0x48, 0x89, 0xC7]);
        assert_eq!(&buf[17..22], &[0xB8, 0x3C, 0x00, 0x00, 0x00]);
        assert_eq!(&buf[22..24], &[0x0F, 0x05]);
    }
}

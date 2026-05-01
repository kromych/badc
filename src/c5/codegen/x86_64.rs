//! x86_64 instruction encoder + bytecode -> x86_64 lowering.
//!
//! M3.2 covers every non-intrinsic Op (arithmetic, control flow,
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
//!
//! ## Always-on peepholes
//!
//! Same two rewrites as the aarch64 backend, applied unconditionally
//! because both are strict wins.
//!
//! [`emit_mov_rr`] drops `mov rd, rd` instead of emitting it. Every
//! reg-to-reg move in the lowering goes through this helper, so the
//! check catches dynamically-chosen pool registers too without
//! sprinkling guards across the lowering.
//!
//! Compare-and-branch fusion is more impactful here than on
//! aarch64. Naive lowering of `<cmp>; Bz` is `cmp; setcc r10b;
//! movzx r13, r10b; cmp r13, 0; jcc rel32` -- 24 bytes and four
//! uops. Fused, the compare emits just `cmp` and the branch emits
//! `jcc rel32` reading the flags, for a total of 9 bytes and two
//! uops. The same safety gates as aarch64 apply: refuse to fuse
//! if another branch lands on the `Bz`/`Bnz` PC, or if the
//! taken-target or fall-through op reads `r13` before writing it.
//! The latter check matters because the elided `setcc + movzx`
//! leaves `r13` holding the rhs of the compare instead of the 0/1
//! boolean, which would miscompile c4's short-circuit `a && b`
//! pattern (one `Bz` lands on another `Bz` expecting that
//! boolean).

#![allow(dead_code)] // Encoders ahead of lowering coverage.

use alloc::format;
use alloc::vec::Vec;

use super::super::CODE_BASE;
use super::super::error::C5Error;
use super::super::op::Op;
use super::super::program::Program;
use super::regalloc::{self, PoolBank, PushKind, RegStackPlan};
use super::{Abi, Build, DataFixup, FuncFixup, GotFixup, NativeOptions, Target};

/// Register-pool sizes used by the native optimizer on x86_64.
/// Four callee-saved registers (rbx, r12, r14, r15) plus one
/// caller-saved (r11). The other System V callee-saved registers
/// are spoken for: rbp = frame pointer, r13 = VM accumulator. r10
/// stays out of the pool because the lowering uses it as a
/// general-purpose scratch (popped real-stack operand, indirect
/// call target, divisor stash, comparison setcc target,
/// argv/argc rotation in main's prologue/epilogue, libc-thunk
/// stack-arg courier). r11 is never used as scratch, so it's free
/// for caller-bank slots whose lifetimes never cross a call op
/// (analyzer guarantee) -- no prologue save needed.
pub(super) const POOL_SIZES: regalloc::PoolSizes = regalloc::PoolSizes {
    callee: 4,
    caller: 1,
};

/// Map a regalloc slot index to its pool register. The callee bank
/// (rbx, r12, r14, r15) is non-contiguous so an array is simplest.
/// The caller bank has a single slot mapped to r11.
fn pool_reg(slot: u8, bank: PoolBank) -> Reg {
    const CALLEE_POOL: [Reg; POOL_SIZES.callee as usize] = [Reg::RBX, Reg::R12, Reg::R14, Reg::R15];
    const CALLER_POOL: [Reg; POOL_SIZES.caller as usize] = [Reg::R11];
    match bank {
        PoolBank::Callee => CALLEE_POOL[slot as usize],
        PoolBank::Caller => CALLER_POOL[slot as usize],
    }
}

/// Per-function lowering state, mirror of the aarch64 `RegState`.
/// See `aarch64.rs` for the design notes; the only difference here
/// is the per-arch pool size and register set.
struct RegState<'a> {
    /// Whether the user requested the register-pool pass
    /// ([`NativeOptions::optimize`]). When `false`, every Pseudo
    /// `Op::Psh` lands on the real stack. The cmp+branch fusion
    /// peephole is *not* gated on this flag -- it runs
    /// unconditionally as a safety-checked strict win.
    optimize: bool,
    plan: Option<&'a RegStackPlan>,
    use_pool: bool,
    current_callee_depth: u8,
    pseudo_stack: Vec<Option<(u8, PoolBank)>>,
    /// cmp+branch fusion peephole, mirror of the aarch64 field.
    /// When a compare op (`Lt`/`Eq`/...) elides its `setcc + movzx`
    /// because the next op is a fusable `Bz`/`Bnz`, the condition
    /// is stashed here. The matching branch op consumes it and
    /// emits `jcc` directly without the redundant `cmp r13, 0`.
    /// Independent of [`Self::optimize`] -- always-on like the
    /// self-mov elision check.
    pending_cmp_cond: Option<Cc>,
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
///
/// Skips emission entirely when `dst == src`: the move would be a
/// no-op but cost 3 bytes of code. The lowering pass calls this on
/// dynamically-chosen register pairs (e.g. moving a popped pool
/// register into r13), so guarding here catches every emit site
/// without the lowering having to spell out the check.
pub(super) fn emit_mov_rr(code: &mut Vec<u8>, dst: Reg, src: Reg) {
    if dst == src {
        return;
    }
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

/// `SYSCALL`. Linux x86_64 intrinsic entry; nr in `rax`, args in
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
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
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

impl Cc {
    /// Logical complement of the condition. Used by the cmp+branch
    /// fusion peephole when `Op::Bz` (test for boolean zero) lands
    /// on a compare op whose `setcc` was elided -- we need the
    /// branch to fire on the inverted predicate. Mirror of
    /// [`super::aarch64::Cond::flip`].
    fn flip(self) -> Cc {
        match self {
            Cc::E => Cc::Ne,
            Cc::Ne => Cc::E,
            Cc::L => Cc::Ge,
            Cc::Ge => Cc::L,
            Cc::G => Cc::Le,
            Cc::Le => Cc::G,
        }
    }
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
pub(super) fn emit_start_stub(code: &mut Vec<u8>, abi: Abi, main_offset_in_code: u64) -> usize {
    let stub_start = code.len();

    // argc / argv go in the first two of the ABI's
    // int-arg-passing registers. SysV picks rdi, rsi here; a
    // hypothetical Linux x86_64 ABI variant with a different
    // arg register would only need to flip `Target::abi`.
    let argc_reg = Reg(abi.int_arg_regs[0]);
    let argv_reg = Reg(abi.int_arg_regs[1]);
    // mov <argc>, [rsp]         -- argc lives at the kernel-pushed
    //                              stack top.
    emit_mov_r_mem(code, argc_reg, Reg::RSP, 0);
    // lea <argv>, [rsp + 8]     -- argv array starts one slot up.
    emit_lea_r_mem(code, argv_reg, Reg::RSP, 8);

    // call main. Target byte offset (within the code blob) is
    // START_STUB_LEN + main_offset_in_code; the rel32 for `call` is
    // measured from the byte *after* the 5-byte `call` instruction.
    let call_byte_off = (code.len() - stub_start) as i64;
    let after_call = call_byte_off + 5;
    let main_byte = (START_STUB_LEN as i64) + main_offset_in_code as i64;
    let rel32 = (main_byte - after_call) as i32;
    emit_call_rel32(code, rel32);

    // Move main's return value into the ABI's first int-arg
    // register (= libc `exit`'s 1st parameter).
    emit_mov_rr(code, argc_reg, Reg::RAX);

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

/// Translate a c5 `Op::Lea` offset (in 8-byte VM-slot units) into
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

/// Walk a function body starting at `ent_pc` and return the number of
/// parameter slots it actually reads. The c5 parser hands params
/// `Op::Lea` operands `2..=N+1` (matching `lea_offset_bytes`'s arg
/// branch); locals get `<= -1`. The optimizer's local-load fusion
/// rewrites `Lea N; Li` / `Lea N; Lc` into `LdLocI N` / `LdLocC N`,
/// so we have to scan all three opcodes; otherwise the optimized
/// bytecode would look like the function never reads its params.
/// The maximum positive operand inside the body is `N + 1`, which
/// gives us `N`.
///
/// Underestimates (rather than over-) by design: a declared param
/// the function never references contributes no `Lea`/`LdLoc*` op
/// and looks like one fewer param. That's the safe side -- the
/// host-arg thunks built on top of this only spill the regs the
/// function actually reads, so an unused declared param never reads
/// garbage.
pub(super) fn param_count_for_func(text: &[i64], ent_pc: usize) -> usize {
    if ent_pc >= text.len() || Op::from_i64(text[ent_pc]) != Some(Op::Ent) {
        return 0;
    }
    let mut max_param_offset: Option<i64> = None;
    let mut pc = ent_pc + Op::Ent.word_size();
    while pc < text.len() {
        let op = match Op::from_i64(text[pc]) {
            Some(o) => o,
            None => break,
        };
        if matches!(op, Op::Ent) {
            break;
        }
        if matches!(op, Op::Lea | Op::LdLocI | Op::LdLocC) {
            let off = text[pc + 1];
            if off >= 2 {
                max_param_offset = Some(max_param_offset.map_or(off, |m| m.max(off)));
            }
        }
        pc += op.word_size();
    }
    max_param_offset.map_or(0, |off| (off - 1) as usize)
}

/// Emit a host-ABI -> c5-ABI argument-shuffling thunk for a function
/// at `target_offset` with `n_params` declared parameters. The
/// platform call site (pthread_create's start_routine, CreateThread's
/// lpStartAddress, qsort's compar, ...) hands us args in the ABI's
/// integer arg registers (and on the host's stack past that); the c5
/// callee reads them off the c5 stack at `[rbp + 16]`, `[rbp + 32]`,
/// ... per `lea_offset_bytes`. This thunk bridges the two:
///
///   push rbp; mov rbp, rsp                ; standard frame
///   sub rsp, 16 * N                       ; reserve N c5 arg slots
///   ; reg args (i = 0 .. n_reg)
///   mov [rbp - 16*(i+1)], <arg_reg[i]>
///   ; stack args (i = n_reg .. N) -- copied from the host's stack
///   mov rax, [rbp + host_stack_off(i)]
///   mov [rbp - 16*(i+1)], rax
///   call F_real                           ; pushes ret addr; F reads
///                                         ;   args off the new stack
///   mov rsp, rbp; pop rbp; ret            ; tear down + return to host
///
/// Stack-arg layout in the host's frame at thunk entry:
///   * SysV  -- arg n_reg+i sits at [rbp + 16 + i*8]
///     (16 = saved rbp + ret addr)
///   * Win64 -- arg n_reg+i sits at [rbp + 16 + 32 + i*8]
///     (16 + 32-byte shadow space)
pub(super) fn emit_arg_thunk(
    code: &mut Vec<u8>,
    n_params: usize,
    target_offset: usize,
    abi: Abi,
) -> usize {
    let thunk_offset = code.len();
    let n_reg = n_params.min(abi.int_arg_regs.len());
    let n_stack = n_params - n_reg;
    let host_stack_base = 16 + abi.shadow_space as i32;

    emit_push_r(code, Reg::RBP);
    emit_mov_rr(code, Reg::RBP, Reg::RSP);

    if n_params > 0 {
        emit_sub_rsp_imm32(code, (16 * n_params) as u32);
        // C arg `i` is the i'th source-order parameter. With c5's
        // cdecl push order, the i'th declared param has val = i + 2,
        // so F-real reads it at `[rbp + 16*(i+1)]`. After F's
        // `push rbp + mov rbp, rsp`, that's `thunk_rbp - 16*(N-i)`.
        // Reg args (i = 0 .. n_reg).
        for i in 0..n_reg {
            let disp = -((16 * (n_params - i)) as i32);
            emit_mov_mem_r(code, Reg::RBP, disp, Reg(abi.int_arg_regs[i]));
        }
        // Stack args (i = n_reg .. N) -- read from the host stack.
        // RAX is caller-saved and not reserved at the thunk-entry
        // point, so it works as a courier here.
        for i in 0..n_stack {
            let host_off = host_stack_base + (i as i32) * 8;
            let disp = -((16 * (n_stack - i)) as i32);
            emit_mov_r_mem(code, Reg::RAX, Reg::RBP, host_off);
            emit_mov_mem_r(code, Reg::RBP, disp, Reg::RAX);
        }
    }

    // call F_real (5-byte rel32)
    let after_call = code.len() + 5;
    let rel32 = (target_offset as i64) - (after_call as i64);
    debug_assert!(
        i32::try_from(rel32).is_ok(),
        "arg thunk: call rel32 out of range"
    );
    emit_call_rel32(code, rel32 as i32);

    emit_mov_rr(code, Reg::RSP, Reg::RBP);
    emit_pop_r(code, Reg::RBP);
    emit_ret(code);
    thunk_offset
}

/// Mark every bytecode PC that is the target of some `Jmp` / `Bz`
/// / `Bnz` / `Jsr`. The cmp+branch fusion peephole consults this
/// to skip fusion when the matching `Bz`/`Bnz` PC is reachable
/// from elsewhere -- the alternate path would arrive without the
/// preceding `cmp` and read stale flags. Mirror of the aarch64
/// helper of the same name.
fn collect_branch_targets(text: &[i64]) -> Vec<bool> {
    let mut targets = alloc::vec![false; text.len() + 1];
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

/// Decide whether a compare op can fuse with the immediately
/// following `Bz`/`Bnz`. Returns the c4-`Bz`/c4-`Bnz` opcode if
/// fusion is safe; otherwise `None`. Same gates as the aarch64
/// backend:
///
/// * the next op must be `Bz`/`Bnz`,
/// * landing on the `Bz`/`Bnz` from elsewhere must be impossible,
/// * the taken-target op AND the fall-through op must each write
///   `r13` before reading it (the elided `setcc + movzx` would
///   otherwise leave `r13` holding the rhs of the compare instead
///   of a 0/1 boolean, which the c4 short-circuit pattern
///   `a && b` consumes via a downstream `Bz`/`Bnz`).
///
/// `next_pc` is the bytecode PC of the candidate `Bz`/`Bnz`,
/// i.e. `*pc` after the compare op consumed itself.
fn fusion_candidate(text: &[i64], next_pc: usize, branch_targets: &[bool]) -> Option<Op> {
    let raw = *text.get(next_pc)?;
    let next_op = Op::from_i64(raw)?;
    if !matches!(next_op, Op::Bz | Op::Bnz) {
        return None;
    }
    if branch_targets.get(next_pc).copied().unwrap_or(false) {
        return None;
    }
    // Bz/Bnz are 2-word ops (opcode + target operand).
    let target_pc = (*text.get(next_pc + 1)?) as usize;
    let target_op = Op::from_i64(*text.get(target_pc)?)?;
    let fallthrough_op = Op::from_i64(*text.get(next_pc + 2)?)?;
    if !writes_r13_first(target_op) || !writes_r13_first(fallthrough_op) {
        return None;
    }
    Some(next_op)
}

/// Set of c4 ops whose x86_64 lowering writes `r13` before reading
/// any prior value. Same membership as the aarch64 mirror -- the
/// classification is an abstract property of c4's lowering rules,
/// not the per-arch encoding.
fn writes_r13_first(op: Op) -> bool {
    use Op::*;
    matches!(
        op,
        Imm | Lea
        | LdLocI | LdLocC
        // Direct call: `call rel32; mov r13, rax`. The call reads
        // no r13-derived state and the trailing mov overwrites r13.
        | Jsr
        // External library call: load args from rsp offsets
        // (r13-independent), call, then `mov r13, rax`.
        | JsrExt
    )
}

// ------------------------------------------------------------------
// Lowering pass. Walks the bytecode once, emits native code per Op,
// records branch fixups for later patching. Mirrors aarch64::lower.
// ------------------------------------------------------------------

pub(super) fn lower(
    program: &Program,
    target: Target,
    native: NativeOptions,
    imports: &super::ResolvedImports,
) -> Result<Build, C5Error> {
    let abi: Abi = target.abi();

    // Build the regalloc plan once if `--optimize` is on.
    let plan_storage: Option<RegStackPlan> = if native.optimize {
        Some(regalloc::analyze(&program.text, POOL_SIZES)?)
    } else {
        None
    };
    let plan: Option<&RegStackPlan> = plan_storage.as_ref();
    let mut reg_state = RegState::new(native.optimize, plan);

    // Pre-scan for branch targets so the cmp+branch fusion peephole
    // refuses to fuse when the matching Bz/Bnz is reachable from a
    // path bypassing the compare.
    let branch_targets = collect_branch_targets(&program.text);

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
            C5Error::Compile(format!(
                "native codegen (x86_64): bad opcode at PC {pc}: {raw}"
            ))
        })?;
        pc += 1;
        if matches!(op, Op::Ent) {
            in_main = op_pc == program.entry_pc;
            // Clear cmp+branch fusion state at function boundaries
            // -- pending_cmp_cond is only legal for the gap between
            // a compare op and its matching Bz/Bnz.
            reg_state.pending_cmp_cond = None;
            // Refresh per-function regalloc state. With no plan,
            // both stay at their default (use_pool=false, depth=0).
            if let Some(p) = reg_state.plan {
                if let Some(f) = p.function_at(op_pc) {
                    reg_state.use_pool = f.use_pool;
                    reg_state.current_callee_depth = if f.use_pool { f.callee_depth } else { 0 };
                } else {
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
            &mut data_fixups,
            &mut got_fixups,
            &mut pending_func_fixups,
            data_imm_positions,
            in_main,
            abi,
            &mut reg_state,
            op_pc,
            &branch_targets,
            imports,
        )?;
    }
    bytecode_to_native[program.text.len()] = code.len();

    apply_fixups(&mut code, &fixups, &bytecode_to_native, program.text.len())?;

    // Emit per-function arg-shuffling thunks for any function whose
    // address is taken (`fp = worker_main`). The thunk lets pthread /
    // CreateThread / qsort / signal handlers etc. hand args in
    // host-ABI registers and have the c5 callee see them at
    // `[rbp + 16]`, `[rbp + 32]`, ... where lea_offset_bytes expects.
    //
    // Functions with zero params don't need a thunk -- the host call
    // can land on the c5 entry directly; the function won't read the
    // arg regs.
    let mut thunk_for_func: alloc::collections::BTreeMap<usize, usize> =
        alloc::collections::BTreeMap::new();
    let mut addr_taken: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    for (_, target_bc_pc) in &pending_func_fixups {
        addr_taken.insert(*target_bc_pc);
    }
    for &func_pc in &addr_taken {
        let n_params = param_count_for_func(&program.text, func_pc);
        if n_params == 0 {
            continue;
        }
        if func_pc >= bytecode_to_native.len() {
            continue;
        }
        let target = bytecode_to_native[func_pc];
        if target == usize::MAX {
            continue;
        }
        let thunk_offset = emit_arg_thunk(&mut code, n_params, target, abi);
        thunk_for_func.insert(func_pc, thunk_offset);
    }

    // Resolve pending function-pointer fixups now that the bc-to-
    // native map is complete. Prefer a thunk address if we emitted
    // one for the target function; otherwise the literal points at
    // the function's own native entry.
    let mut func_fixups: Vec<FuncFixup> = Vec::with_capacity(pending_func_fixups.len());
    for (instr_offset, target_bc_pc) in pending_func_fixups {
        if target_bc_pc > program.text.len() {
            return Err(C5Error::Compile(format!(
                "native codegen (x86_64): function pointer target {target_bc_pc} past end of bytecode"
            )));
        }
        let target = match thunk_for_func.get(&target_bc_pc).copied() {
            Some(t) => t,
            None => {
                let t = bytecode_to_native[target_bc_pc];
                if t == usize::MAX {
                    return Err(C5Error::Compile(format!(
                        "native codegen (x86_64): function pointer target {target_bc_pc} did not land on an instruction"
                    )));
                }
                t
            }
        };
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
        return Err(C5Error::Compile(format!(
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
        // Set by `lower_for` after this returns; see the matching
        // comment on the aarch64 lowering's `Build` construction.
        imports: super::ResolvedImports::default(),
        abi: super::Abi::default(),
    })
}

fn apply_fixups(
    code: &mut [u8],
    fixups: &[Fixup],
    bc_to_native: &[usize],
    bc_len: usize,
) -> Result<(), C5Error> {
    for f in fixups {
        if f.target_bytecode_pc > bc_len {
            return Err(C5Error::Compile(format!(
                "native codegen (x86_64): branch target {} past end of bytecode",
                f.target_bytecode_pc
            )));
        }
        let target = bc_to_native[f.target_bytecode_pc];
        if target == usize::MAX {
            return Err(C5Error::Compile(format!(
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
    abi: Abi,
    reg_state: &mut RegState<'_>,
    op_pc: usize,
    branch_targets: &[bool],
    imports: &super::ResolvedImports,
) -> Result<(), C5Error> {
    match op {
        // ---- Function frame ----
        Op::Ent => {
            let locals = read_operand(text, pc, "Ent")?;
            emit_prologue(code, locals, in_main, abi, reg_state.current_callee_depth);
        }
        Op::Lev => emit_epilogue(code, in_main, reg_state.current_callee_depth),
        Op::Adj => {
            // Drop N pushed slots (16 bytes each, matching Op::Psh).
            // The analyzer guarantees these were all Real pushes;
            // we still pop the runtime tracker so it stays in sync.
            let n = read_operand(text, pc, "Adj")?;
            if n != 0 {
                emit_add_rsp_imm32(code, (n as u32) * 16);
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
            // pop addr; *addr = r13. With pool: addr is in rN
            // (no load needed). Without pool: pop r10 from stack.
            let lhs = pop_lhs_reg(code, reg_state);
            emit_mov_mem_r(code, lhs, 0, Reg::R13);
        }
        Op::Sc => {
            let lhs = pop_lhs_reg(code, reg_state);
            emit_mov_mem8_r(code, lhs, 0, Reg::R13);
        }
        Op::Psh => {
            // With the native optimizer on AND a Pseudo classification,
            // emit `mov rN, r13` into the assigned pool slot. The
            // bank picks between the callee-saved pool (rbx/r12/
            // r14/r15) and the single caller-saved slot (r11).
            // Otherwise claim a 16-byte slot on the real stack so
            // rsp stays 16-byte aligned across any libc call we make
            // later.
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
                    emit_mov_rr(code, pool_reg(s, bank), Reg::R13);
                    reg_state.pseudo_stack.push(Some((s, bank)));
                }
                None => {
                    emit_sub_rsp_imm32(code, 16);
                    emit_mov_mem_r(code, Reg::RSP, 0, Reg::R13);
                    reg_state.pseudo_stack.push(None);
                }
            }
        }

        // ---- Bitwise + arithmetic. The c5 VM does `popped <op> a`
        //      with the popped value as LHS. With pool: lhs is rN,
        //      we either fold to `r13 op= rN` (commutative) or do
        //      `rN op= r13; mov r13, rN` (non-commutative). Without
        //      pool: same shape but with r10 popped from the stack.
        Op::Or => binop_with_pop(code, reg_state, /*commutative=*/ true, emit_or_rr),
        Op::Xor => binop_with_pop(code, reg_state, true, emit_xor_rr),
        Op::And => binop_with_pop(code, reg_state, true, emit_and_rr),
        Op::Add => binop_with_pop(code, reg_state, true, emit_add_rr),
        Op::Mul => binop_with_pop(code, reg_state, true, emit_imul_rr),
        Op::Sub => binop_with_pop(code, reg_state, /*commutative=*/ false, emit_sub_rr),

        // ---- Comparisons. cmp popped, r13 sets flags so the cc
        //      reflects `popped <cmp> r13`. Then setcc r10b and
        //      movzx r13, r10b for the 0/1 byte. With the cmp+
        //      branch fusion peephole (when next op is `Bz`/`Bnz`
        //      and the gates pass), the setcc + movzx are skipped
        //      and the matching branch op consumes the condition
        //      directly via `jcc`.
        Op::Eq => lower_cmp(code, text, *pc, reg_state, branch_targets, Cc::E),
        Op::Ne => lower_cmp(code, text, *pc, reg_state, branch_targets, Cc::Ne),
        Op::Lt => lower_cmp(code, text, *pc, reg_state, branch_targets, Cc::L),
        Op::Gt => lower_cmp(code, text, *pc, reg_state, branch_targets, Cc::G),
        Op::Le => lower_cmp(code, text, *pc, reg_state, branch_targets, Cc::Le),
        Op::Ge => lower_cmp(code, text, *pc, reg_state, branch_targets, Cc::Ge),

        // ---- Shifts. Pop into lhs (rN or r10), shift by cl (=r13
        //      lo byte), then mov r13 = lhs.
        Op::Shl => shift_with_pop(code, reg_state, /*arithmetic=*/ false),
        Op::Shr => shift_with_pop(code, reg_state, /*arithmetic=*/ true),

        Op::Div => div_or_mod_with_pop(code, reg_state, /*want_remainder=*/ false),
        Op::Mod => div_or_mod_with_pop(code, reg_state, /*want_remainder=*/ true),

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
            // Fusion: if the previous compare op stashed a
            // condition, skip the redundant `cmp r13, 0` and emit
            // `jcc<flip(cond)>` directly. Bz tests for "boolean was
            // 0" which is "the compare condition did NOT hold".
            let cc = match reg_state.pending_cmp_cond.take() {
                Some(cond) => cond.flip(),
                None => {
                    emit_cmp_r_imm32(code, Reg::R13, 0);
                    Cc::E
                }
            };
            let target = read_operand(text, pc, "Bz")? as usize;
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind: BranchKind::Jcc(cc),
            });
            emit_jcc_rel32(code, cc, 0);
        }
        Op::Bnz => {
            // Fusion: Bnz tests for "boolean was 1" which is "the
            // compare condition held" -- same condition as the
            // compare itself.
            let cc = match reg_state.pending_cmp_cond.take() {
                Some(cond) => cond,
                None => {
                    emit_cmp_r_imm32(code, Reg::R13, 0);
                    Cc::Ne
                }
            };
            let target = read_operand(text, pc, "Bnz")? as usize;
            fixups.push(Fixup {
                native_offset: code.len(),
                target_bytecode_pc: target,
                kind: BranchKind::Jcc(cc),
            });
            emit_jcc_rel32(code, cc, 0);
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
            // the VM stack in 16-byte slots.
            //
            // Both ABI flavours load the c5-stack args into the
            // platform's first N int-arg registers before the call --
            // SysV uses rdi/rsi/rdx/rcx/r8/r9, Win64 uses rcx/rdx/r8/r9.
            // That covers libc / dlsym'd targets, which read from those
            // regs directly, *and* c5-internal targets, which the
            // codegen reaches through a per-function arg-shuffling
            // thunk that re-spills the regs onto the c5 stack at
            // `[rbp + 16]`, `[rbp + 32]`, ... (see emit_arg_thunk and
            // the post-walk thunk-emission step in `lower`).
            //
            // Args past the platform's reg cap spill onto the host
            // stack: SysV puts them at `[rsp+0]`, `[rsp+8]`, ...
            // contiguously; Win64 leaves a 32-byte shadow space
            // first and writes them at `[rsp+32]`, `[rsp+40]`, ...
            // Whichever flavour, total scratch is rounded up to 16
            // so `rsp` stays 16-aligned at the call.
            let nargs = match Op::from_i64(text.get(*pc).copied().unwrap_or(0)) {
                Some(Op::Adj) => text[*pc + 1] as usize,
                _ => 0,
            };
            let n_reg = nargs.min(abi.int_arg_regs.len());
            let n_stack = nargs - n_reg;
            let scratch = (abi.shadow_space + (n_stack as u32) * 8 + 15) & !15;
            emit_mov_rr(code, Reg::R10, Reg::R13);
            if scratch > 0 {
                emit_sub_rsp_imm32(code, scratch);
            }
            // Reg args. With cdecl push order, c5-arg-i sits at
            // [rsp + scratch + i*16]: first declared is on top.
            for (i, &r) in abi.int_arg_regs.iter().take(n_reg).enumerate() {
                let src = (scratch as i32) + (i as i32) * 16;
                emit_mov_r_mem(code, Reg(r), Reg::RSP, src);
            }
            // Stack args -- copy from c5 stack down to the host's
            // outgoing-args region. r11 is caller-saved and not
            // claimed elsewhere on this code path; safe courier.
            for i in 0..n_stack {
                let src = (scratch as i32) + ((n_reg + i) as i32) * 16;
                let dst = (abi.shadow_space + (i as u32) * 8) as i32;
                emit_mov_r_mem(code, Reg::R11, Reg::RSP, src);
                emit_mov_mem_r(code, Reg::RSP, dst, Reg::R11);
            }
            if abi.shadow_space == 0 {
                // SysV variadic ABI: AL must hold the number of XMM
                // registers used to pass float args. We never pass
                // floats, but there's no way to know whether the
                // dlsym'd target is variadic (sscanf, printf, ...)
                // from a c5-side `int *fn`, so zero AL unconditionally
                // before the call. Cheap (2 bytes), and `rax` is
                // caller-saved so clobbering it is safe; the call
                // overwrites it with the return value anyway.
                emit_xor_eax_eax(code);
            }
            emit_call_r(code, Reg::R10);
            if scratch > 0 {
                emit_add_rsp_imm32(code, scratch);
            }
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
        Op::EqI => imm_cmp(code, text, pc, "EqI", Cc::E, reg_state, branch_targets)?,
        Op::NeI => imm_cmp(code, text, pc, "NeI", Cc::Ne, reg_state, branch_targets)?,
        Op::LtI => imm_cmp(code, text, pc, "LtI", Cc::L, reg_state, branch_targets)?,
        Op::GtI => imm_cmp(code, text, pc, "GtI", Cc::G, reg_state, branch_targets)?,
        Op::LeI => imm_cmp(code, text, pc, "LeI", Cc::Le, reg_state, branch_targets)?,
        Op::GeI => imm_cmp(code, text, pc, "GeI", Cc::Ge, reg_state, branch_targets)?,
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
        Op::JsrExt => {
            let binding_idx = read_operand(text, pc, "JsrExt")?;
            emit_libc_call(binding_idx, text, *pc, code, got_fixups, abi, imports)?;
        }
    }
    Ok(())
}

/// Lower a intrinsic op to a libc call through the GOT (System V) /
/// IAT (Win64). The caller pushed args onto the VM stack in 16-byte
/// slots; we peek (don't pop) to load them into the platform's
/// integer arg registers. The c5 emitter follows every libc call
/// with `Op::Adj N` which the next loop iteration lowers to
/// `add rsp, N*16` to drop the args.
///
/// Two ABI flavours diverge in this function:
///
/// * System V (Linux): integer args go in rdi, rsi, rdx, rcx, r8,
///   r9 (up to 6). Variadic functions like printf require AL = 0 to
///   signal "zero XMM regs used".
/// * Win64 (Windows): integer args go in rcx, rdx, r8, r9 (up to
///   4). The caller reserves a 32-byte shadow space below each
///   call site for the callee to spill the four register args. No
///   AL = 0 dance for variadics.
#[allow(clippy::too_many_arguments)]
fn emit_libc_call(
    binding_idx: i64,
    text: &[i64],
    pc_after_op: usize,
    code: &mut Vec<u8>,
    got_fixups: &mut Vec<GotFixup>,
    abi: Abi,
    imports: &super::ResolvedImports,
) -> Result<(), C5Error> {
    let import_index = imports.index_of_binding(binding_idx).ok_or_else(|| {
        C5Error::Compile(format!(
            "native codegen (x86_64): no import slot for binding {binding_idx} -- the resolver should have placed it"
        ))
    })?;
    let local_name: &str = imports.imports[import_index].local_name.as_str();

    // Peek for the trailing `Adj N`. The c5 emitter omits `Adj` for
    // 0-arg calls (e.g. `dlerror()`), so a missing `Adj` collapses
    // to `arg_count = 0`.
    let arg_count = match Op::from_i64(text.get(pc_after_op).copied().unwrap_or(0)) {
        Some(Op::Adj) => text[pc_after_op + 1] as usize,
        _ => 0,
    };
    // Integer args go through `abi.int_arg_regs` (SysV: 6 regs;
    // Win64: 4 regs). Args past that count spill to the host stack:
    // SysV places them at [rsp+0], [rsp+8], ... contiguously; Win64
    // places them at [rsp+shadow_space], [rsp+shadow_space+8], ...
    // (above the 32-byte shadow space). Either way, total scratch
    // is rounded up to 16 so rsp stays 16-aligned at the call.
    let arg_regs = abi.int_arg_regs;
    let extras = arg_count.saturating_sub(arg_regs.len()) as u32;
    let scratch = (abi.shadow_space + extras * 8 + 15) & !15;
    let _ = local_name;

    if scratch > 0 {
        emit_sub_rsp_imm32(code, scratch);
    }
    // Reg args. With cdecl push order, c5-arg-i sits at
    // [rsp + scratch + i*16] (first declared is on top).
    for (i, &r) in arg_regs
        .iter()
        .take(arg_count.min(arg_regs.len()))
        .enumerate()
    {
        let src = scratch + (i as u32) * 16;
        emit_mov_r_mem(code, Reg(r), Reg::RSP, src as i32);
    }
    // Stack args. Use r10 as a scratch courier; r10 is caller-saved
    // and free at call sites.
    for i in arg_regs.len()..arg_count {
        let src = scratch + (i as u32) * 16;
        let dst = abi.shadow_space + ((i - arg_regs.len()) as u32) * 8;
        emit_mov_r_mem(code, Reg::R10, Reg::RSP, src as i32);
        emit_mov_mem_r(code, Reg::RSP, dst as i32, Reg::R10);
    }
    if abi.shadow_space == 0
        && abi.variadic_zero_xmm_count
        && imports.imports[import_index].is_variadic
    {
        // Variadic System V: AL = number of XMM regs used.
        // c5 has no floats, so always 0. Plain libc calls preserve
        // rax across argument loads anyway; only variadic call
        // sites (`printf`, `sscanf`, `fprintf`, ...) need the xor.
        // The variadic flag comes from the binding's prototype.
        emit_xor_eax_eax(code);
    }

    // call qword [rip + disp32] -- placeholder, writer patches
    // disp32 to point at the right .got / IAT slot.
    let instr_offset = code.len();
    got_fixups.push(GotFixup {
        adrp_offset: instr_offset,
        import_index,
    });
    emit_call_qword_rip32(code, 0);

    if scratch > 0 {
        emit_add_rsp_imm32(code, scratch);
    }

    {
        // Move the libc return value into r13 so the c5 caller
        // sees it as the new accumulator. (For functions that
        // don't return -- e.g. `exit` -- the call doesn't reach
        // this point at runtime, so the mov is harmless dead code.)
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

/// Pop the top of the VM push-stack -- either the pool register
/// `pool_reg(slot, bank)` (no instructions emitted) or `r10` after
/// a pop_into from the real stack -- and return the holding
/// register. Updates `reg_state.pseudo_stack`.
fn pop_lhs_reg(code: &mut Vec<u8>, reg_state: &mut RegState<'_>) -> Reg {
    match reg_state.pseudo_stack.pop() {
        Some(Some((slot, bank))) => pool_reg(slot, bank),
        Some(None) | None => {
            pop_into(code, Reg::R10);
            Reg::R10
        }
    }
}

/// Pop the LHS, then run the encoder. `commutative = true` collapses
/// to a single `r13 op= lhs` (one instruction). `commutative = false`
/// keeps the c5 VM order with `lhs op= r13; mov r13, lhs` (two
/// instructions; clobbers `lhs` but it's already popped from the
/// pseudo stack so it's dead by then).
fn binop_with_pop<F: Fn(&mut Vec<u8>, Reg, Reg)>(
    code: &mut Vec<u8>,
    reg_state: &mut RegState<'_>,
    commutative: bool,
    op_rr: F,
) {
    let lhs = pop_lhs_reg(code, reg_state);
    if commutative {
        op_rr(code, Reg::R13, lhs);
    } else {
        op_rr(code, lhs, Reg::R13);
        emit_mov_rr(code, Reg::R13, lhs);
    }
}

/// Pop the LHS, compare against r13, set r13 = 0/1 by `cc`.
fn cmp_with_pop(code: &mut Vec<u8>, reg_state: &mut RegState<'_>, cc: Cc) {
    let lhs = pop_lhs_reg(code, reg_state);
    emit_cmp_rr(code, lhs, Reg::R13);
    // Set into r10b and movzx into r13. We can't `xor r13, r13`
    // first because xor sets the flags the setcc would read.
    emit_setcc_r8(code, cc, Reg::R10);
    emit_movzx_r_r8(code, Reg::R13, Reg::R10);
}

/// Lower a register-register compare op (`Lt`/`Eq`/...). When the
/// next bytecode op is `Bz`/`Bnz` and the peephole gate
/// ([`fusion_candidate`]) clears it, emit `cmp` only and stash the
/// condition in `reg_state.pending_cmp_cond` for the matching
/// branch op to consume as a `jcc`. Otherwise fall back to
/// `cmp + setcc + movzx`.
///
/// `next_pc` is the bytecode PC of the next op (i.e. `*pc` after
/// the compare op consumed itself; the compare ops are 1-word).
fn lower_cmp(
    code: &mut Vec<u8>,
    text: &[i64],
    next_pc: usize,
    reg_state: &mut RegState<'_>,
    branch_targets: &[bool],
    cc: Cc,
) {
    let lhs = pop_lhs_reg(code, reg_state);
    emit_cmp_rr(code, lhs, Reg::R13);
    if fusion_candidate(text, next_pc, branch_targets).is_some() {
        // Skip setcc + movzx; the matching Bz/Bnz will read flags
        // via jcc.
        reg_state.pending_cmp_cond = Some(cc);
    } else {
        emit_setcc_r8(code, cc, Reg::R10);
        emit_movzx_r_r8(code, Reg::R13, Reg::R10);
    }
}

/// Pop the LHS, shift it by cl (lo byte of r13), mov r13 = lhs.
fn shift_with_pop(code: &mut Vec<u8>, reg_state: &mut RegState<'_>, arithmetic_right: bool) {
    let lhs = pop_lhs_reg(code, reg_state);
    // The shift count register is fixed to cl. mov rcx, r13 first
    // since the shift will overwrite r13's role on the read side.
    emit_mov_rr(code, Reg::RCX, Reg::R13);
    if arithmetic_right {
        emit_sar_r_cl(code, lhs);
    } else {
        emit_shl_r_cl(code, lhs);
    }
    emit_mov_rr(code, Reg::R13, lhs);
}

/// Signed divide. c4 semantics: `popped / r13` (or `% r13`). The
/// divisor must not be in rax or rdx (idiv overwrites both), so we
/// stash it in r10 first. The dividend ends up in rax via either
/// `mov rax, lhs_pool_reg` or `pop_into(rax)`.
fn div_or_mod_with_pop(code: &mut Vec<u8>, reg_state: &mut RegState<'_>, want_remainder: bool) {
    emit_mov_rr(code, Reg::R10, Reg::R13); // r10 = divisor
    match reg_state.pseudo_stack.pop() {
        Some(Some((slot, bank))) => {
            // dividend is in pool reg; mov it to rax.
            emit_mov_rr(code, Reg::RAX, pool_reg(slot, bank));
        }
        Some(None) | None => {
            // dividend on real stack; pop into rax.
            pop_into(code, Reg::RAX);
        }
    }
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
/// Participates in the cmp+branch fusion peephole the same way
/// [`lower_cmp`] does.
fn imm_cmp(
    code: &mut Vec<u8>,
    text: &[i64],
    pc: &mut usize,
    op_name: &str,
    cc: Cc,
    reg_state: &mut RegState<'_>,
    branch_targets: &[bool],
) -> Result<(), C5Error> {
    let n = read_operand(text, pc, op_name)? as i32;
    emit_cmp_r_imm32(code, Reg::R13, n);
    if fusion_candidate(text, *pc, branch_targets).is_some() {
        reg_state.pending_cmp_cond = Some(cc);
    } else {
        emit_setcc_r8(code, cc, Reg::R10);
        emit_movzx_r_r8(code, Reg::R13, Reg::R10);
    }
    Ok(())
}

fn read_operand(text: &[i64], pc: &mut usize, op_name: &str) -> Result<i64, C5Error> {
    if *pc >= text.len() {
        return Err(C5Error::Compile(format!(
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
fn emit_prologue(code: &mut Vec<u8>, locals: i64, is_main: bool, abi: Abi, pool_depth: u8) {
    if is_main {
        // The entry stub passed argc / argv via the platform's first
        // two integer arg registers: System V uses rdi/rsi, Win64
        // uses rcx/rdx. c5's cdecl push order maps `int main(int
        // argc, char **argv)` to argc at `rbp + 16` (val=2, first
        // declared, on top) and argv at `rbp + 24` (val=3, second
        // declared, deeper). We pop the ret addr into a temp, push
        // argv first (deeper) then argc (top), then re-push the ret
        // addr so the rest of the prologue lines up.
        let (argc_reg, argv_reg) = if abi.shadow_space != 0 {
            (Reg::RCX, Reg::RDX)
        } else {
            (Reg::RDI, Reg::RSI)
        };
        emit_pop_r(code, Reg::R10); // r10 = ret addr
        emit_sub_rsp_imm32(code, 16);
        emit_mov_mem_r(code, Reg::RSP, 0, argv_reg); // argv deeper
        emit_sub_rsp_imm32(code, 16);
        emit_mov_mem_r(code, Reg::RSP, 0, argc_reg); // argc on top
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

    // Save the pool registers actually used by this function.
    // System V x86_64 makes rbx, r12, r14, r15 callee-saved, so
    // we don't need to spill them at every call site -- one save
    // per function entry is enough. Layout below saved-r13:
    //   [rsp + 0]: pool slot 0 (rbx)
    //   [rsp + 8]: pool slot 1 (r12)
    //   ... up to pool_depth - 1 ...
    // padded to 16 bytes for alignment.
    emit_save_pool(code, pool_depth);
}

/// Mirror of [`emit_prologue`]. Move the VM accumulator into rax
/// (return register), restore the pool, restore r13, tear down the
/// frame, return. For main we also drop the two 16-byte argc / argv
/// slots inserted by the prologue -- they sit between the saved rbp
/// and the return address, so we pop the ret addr into a temp, drop
/// the slots, then push it back before `ret` consumes it.
fn emit_epilogue(code: &mut Vec<u8>, is_main: bool, pool_depth: u8) {
    emit_mov_rr(code, Reg::RAX, Reg::R13);
    // Restore the pool first (it sits on top of saved-r13).
    emit_restore_pool(code, pool_depth);
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

/// Reserve a 16-aligned region on the stack and store the first
/// `depth` pool registers into it at slot * 8 byte offsets. Using a
/// contiguous region (rather than per-reg push) keeps a stable
/// layout across the [save, restore] pair regardless of `depth`'s
/// parity.
fn emit_save_pool(code: &mut Vec<u8>, depth: u8) {
    if depth == 0 {
        return;
    }
    let aligned = (((depth as u32) * 8) + 15) & !15;
    emit_sub_rsp_imm32(code, aligned);
    for i in 0..depth {
        emit_mov_mem_r(
            code,
            Reg::RSP,
            (i as i32) * 8,
            pool_reg(i, PoolBank::Callee),
        );
    }
}

/// Reverse of [`emit_save_pool`].
fn emit_restore_pool(code: &mut Vec<u8>, depth: u8) {
    if depth == 0 {
        return;
    }
    let aligned = (((depth as u32) * 8) + 15) & !15;
    for i in 0..depth {
        emit_mov_r_mem(
            code,
            pool_reg(i, PoolBank::Callee),
            Reg::RSP,
            (i as i32) * 8,
        );
    }
    emit_add_rsp_imm32(code, aligned);
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
    fn cmp_branch_fusion_collapses_lt_bz_in_fib_shape() {
        // Mirror of the aarch64 fusion check, but at the lowering
        // level. Compile a small fib-shape function and confirm the
        // Op::Lt + Op::Bz pair shrinks from 24 bytes (3 + 4 + 4 + 7
        // + 6) to 9 bytes (3 + 6) when fusion fires.
        use crate::Compiler;
        let src = r#"
            int main() {
                int x;
                x = 5;
                if (x < 2) return x;
                return 0;
            }
        "#;
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let imports = super::super::ResolvedImports::resolve(&program).expect("resolve");
        let build = super::lower(
            &program,
            super::Target::LinuxX64,
            super::NativeOptions::new().with_optimize(),
            &imports,
        )
        .expect("lower");
        // Find the Lt op's PC (must exist in the bytecode).
        let lt_pc = (0..program.text.len())
            .find(|&pc| Op::from_i64(program.text[pc]) == Some(Op::Lt))
            .expect("Lt should appear in fib-shape program");
        // bytecode_to_native gives the start of each op's emit;
        // the gap between Lt and the next entry (Bz) is Lt's
        // emitted bytes. Bz is 2 words further on.
        let lt_native = build.bytecode_to_native[lt_pc];
        let bz_native = build.bytecode_to_native[lt_pc + 1];
        let lt_bytes = bz_native - lt_native;
        // Fused Lt should emit just `cmp lhs, r13` -- 3 bytes (no
        // REX.W on cmp r13 with rbx since rbx is callee-saved
        // pool slot 0; with caller bank, lhs would be a different
        // pool reg but still 3 bytes via the standard cmp r/m64,
        // r64 encoding).
        assert!(
            lt_bytes <= 4,
            "fused Lt should be at most 4 bytes (cmp+REX), got {lt_bytes}: {:02x?}",
            &build.text[lt_native..bz_native]
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
        let exit_off = emit_start_stub(&mut buf, super::super::Target::LinuxX64.abi(), 0);
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

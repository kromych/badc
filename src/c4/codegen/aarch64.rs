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

use alloc::vec::Vec;

use super::super::error::C4Error;
use super::super::program::Program;
use super::Build;

/// Lower a bytecode [`Program`] to AArch64 machine code. Phase 1
/// stub -- returns a not-yet-implemented error so the CLI flag can be
/// wired and the rest of the pipeline can be tested before the
/// encoder lands in M1.1+.
pub(super) fn lower(_program: &Program) -> Result<Build, C4Error> {
    Err(C4Error::Compile(
        "native codegen for macOS aarch64 is not yet implemented (M1.0 scaffolding only)".into(),
    ))
}

/// Helper: append a 32-bit instruction word to a code buffer in
/// little-endian byte order. Every encoder in this module funnels
/// through here so the byte order can't get accidentally inverted.
#[allow(dead_code)] // Used starting M1.1.
pub(super) fn emit(code: &mut Vec<u8>, word: u32) {
    code.extend_from_slice(&word.to_le_bytes());
}

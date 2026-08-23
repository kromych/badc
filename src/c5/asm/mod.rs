//! The target-neutral assembler. GNU as source -- a `.s` unit, a
//! file-scope `asm` block, or an extended inline-asm template -- is
//! preprocessed here, parsed into section items, laid out, and
//! materialized into section bytes plus relocations. The per-target
//! mnemonic parsers and encoders live under `codegen/x86_64` and
//! `codegen/aarch64` and consume these types.
//!
//! The submodules are an internal split; the module re-exports their
//! surface, so callers name `crate::c5::asm::<item>` throughout.

mod expr;
mod text;

pub(crate) use expr::*;
pub(crate) use text::*;

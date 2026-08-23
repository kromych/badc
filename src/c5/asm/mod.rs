//! The target-neutral assembler. GNU as source -- a `.s` unit, a
//! file-scope `asm` block, or an extended inline-asm template -- is
//! preprocessed here, parsed into section items, laid out, and
//! materialized into section bytes plus relocations. The per-target
//! mnemonic parsers and encoders live under `codegen/x86_64` and
//! `codegen/aarch64` and consume these types.
//!
//! The submodules are an internal split; the module re-exports their
//! surface, so callers name `crate::c5::asm::<item>` throughout.

mod align;
mod directive;
mod expr;
mod gas;
mod layout;
mod operand;
mod section;
mod sink;
mod template;
mod text;

pub(crate) use align::*;
pub(crate) use directive::*;
pub(crate) use expr::*;
pub(crate) use gas::*;
pub(crate) use layout::*;
pub(crate) use operand::*;
pub(crate) use section::*;
pub(crate) use sink::*;
pub(crate) use template::*;
pub(crate) use text::*;

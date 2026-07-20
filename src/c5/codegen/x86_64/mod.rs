//! x86_64 backend: the instruction encoder (`encode`) and the SSA-to-machine
//! lowering (`emit`). The encoder's public surface is re-exported so callers
//! reference it as `x86_64::<item>` regardless of the internal split.

pub(crate) mod asm;
pub(crate) mod emit;
pub(crate) mod encode;
mod isa_x86_table;
pub(crate) mod table;

// Resolve the codegen-level paths the two large modules reference relative to
// their original location, now that they sit one level deeper.
pub(crate) use super::*;
pub(crate) use encode::*;

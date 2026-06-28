//! SSA construction, the target-neutral analyses and register allocator, and
//! the shared emit substrate. The per-target instruction selection lives in
//! the sibling x86_64/ and aarch64/ modules.

pub(crate) mod build;
#[cfg(feature = "std")]
pub(crate) mod dump;
pub(crate) mod emit_common;
pub(crate) mod liveness;
pub(crate) mod mem2reg;
pub(crate) mod native;
pub(crate) mod phi_class;
pub(crate) mod reg_alloc;
pub(crate) mod shadow;
pub(crate) mod slot_coalesce;

// Resolve the codegen-level paths the moved files reference relative to their
// original location, now that they sit one level deeper.
pub(crate) use super::*;

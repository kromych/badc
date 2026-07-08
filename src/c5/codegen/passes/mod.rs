//! Architecture-independent SSA-to-SSA transforms. Each pass rewrites a
//! `FunctionSsa` in place and is target-neutral; the per-target lowering
//! drivers run a selection of them before instruction selection.

pub(crate) mod constfold;
pub(crate) mod constfold_branch;
pub(crate) mod dedup_imm;
pub(crate) mod drop_redundant_extend;
pub(crate) mod fma;
pub(crate) mod index_fold;
pub(crate) mod inline;
pub(crate) mod layout;
pub(crate) mod prune_unreachable;
pub(crate) mod remap_blocks;
pub(crate) mod rotate;
pub(crate) mod split_crit_edges;
pub(crate) mod sroa;
pub(crate) mod store_forward;
pub(crate) mod struct_return_reg;
pub(crate) mod tailrec;
pub(crate) mod unroll;

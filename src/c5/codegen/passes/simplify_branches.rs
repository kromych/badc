//! Fixed point of constant-condition branch folding and unreachable-block
//! pruning.
//!
//! Folding a `Bz`/`Bnz` on a constant orphans its not-taken successor;
//! pruning that block drops the phi incomings naming it, which can
//! collapse a merge phi to a single incoming. A constant then reaches
//! the survivor either directly (`constfold_branch::fold` chases the
//! degenerate phi) or through a value chain built on it -- an `Extend`,
//! a `BinopI` -- which `constfold` resolves once its `imm_of` sees
//! through the phi. This is the pattern a constant argument produces
//! after inlining an `if`/`else-if` chain, and any constant that flows
//! through one folded branch into a later one. The three passes alternate
//! until the branch fold and the prune both reach a fixed point.

use crate::c5::ir::FunctionSsa;

/// `resolve_constant_p` is false for the post-walk cleanup, where a
/// deferred `__builtin_constant_p` must survive for the inliner's later
/// argument substitution, and true for the post-inline `-O` pipeline,
/// whose fixed point is the last chance to discover a constant: the
/// survivors resolve to 0 so no such node reaches an emitter.
pub(crate) fn run(funcs: &mut [FunctionSsa], resolve_constant_p: bool) {
    for func in funcs {
        // Each productive round folds at least one conditional terminator
        // or prunes at least one block; both counts decrease
        // monotonically, so the block count bounds the iteration. The
        // value fold runs first each round to collapse the chains a
        // freshly degenerate phi exposes into the immediates the branch
        // fold reads.
        let mut bound = func.blocks.len() + 1;
        let mut resolved = !resolve_constant_p;
        loop {
            super::constfold::run_one(func);
            let folded = super::constfold_branch::run_one(func);
            let pruned = super::prune_unreachable::run_one(func);
            bound -= 1;
            if (!folded && !pruned) || bound == 0 {
                if !resolved {
                    resolved = true;
                    if super::constfold::resolve_constant_p(func) {
                        bound = func.blocks.len() + 1;
                        continue;
                    }
                }
                break;
            }
        }
    }
}

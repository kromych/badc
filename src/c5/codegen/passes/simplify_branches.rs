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

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
        // Each productive round folds at least one conditional terminator
        // or prunes at least one block; both counts decrease
        // monotonically, so the block count bounds the iteration. The
        // value fold runs first each round to collapse the chains a
        // freshly degenerate phi exposes into the immediates the branch
        // fold reads.
        let mut bound = func.blocks.len() + 1;
        loop {
            super::constfold::run_one(func);
            let folded = super::constfold_branch::run_one(func);
            let pruned = super::prune_unreachable::run_one(func);
            bound -= 1;
            if (!folded && !pruned) || bound == 0 {
                break;
            }
        }
    }
}

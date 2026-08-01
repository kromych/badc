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
//! through one folded branch into a later one. The passes alternate
//! until the branch fold and the prune both reach a fixed point.
//!
//! The `-O` pipeline runs the const-data-aware form: loads from const
//! initialized data fold inside the same fixed point, so an address that
//! becomes constant only after a branch fold collapses its phi (an
//! inlined table lookup behind a folded bounds check) still folds and
//! can decide the next branch.

use crate::c5::ir::FunctionSsa;
use crate::c5::program::Program;

/// What the fixed point may do beyond folding constant-condition
/// branches and pruning what they orphan. All are off for the
/// post-walk cleanup: a deferred `__builtin_constant_p` must survive
/// there for the inliner's later argument substitution, and the others
/// are `-O` capabilities.
struct Opts<'a> {
    const_data: Option<&'a super::const_global_fold::ConstData<'a>>,
    addr_facts: Option<&'a super::constfold::AddrFacts>,
    resolve_constant_p: bool,
    fold_selects: bool,
}

/// The post-walk correctness cleanup, run at every optimization level.
pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
        run_one(
            func,
            &Opts {
                const_data: None,
                addr_facts: None,
                resolve_constant_p: false,
                fold_selects: false,
            },
        );
    }
}

/// The `-O` form: const-object loads, select consumers, and null
/// comparisons of non-null symbol addresses fold inside the same fixed
/// point, and a surviving deferred `__builtin_constant_p` resolves to 0
/// on the way out, so no such node reaches an emitter.
pub(crate) fn run_with_const_data(funcs: &mut [FunctionSsa], program: &Program) {
    let cd = super::const_global_fold::ConstData::build(program);
    let facts = super::constfold::addr_facts(program);
    for func in funcs {
        run_one(
            func,
            &Opts {
                const_data: Some(&cd),
                addr_facts: Some(&facts),
                resolve_constant_p: true,
                fold_selects: true,
            },
        );
    }
}

fn run_one(func: &mut FunctionSsa, opts: &Opts<'_>) {
    // Each productive round folds at least one conditional terminator,
    // prunes at least one block, or rewrites at least one instruction to
    // an `Imm` (a const-object load, a select consumer); each count
    // decreases monotonically, so the block and instruction counts bound
    // the iteration. The value fold runs first each round to collapse
    // the chains a freshly degenerate phi exposes into the immediates
    // the branch fold reads.
    let mut bound = func.blocks.len() + func.insts.len() + 1;
    let mut resolved = !opts.resolve_constant_p;
    loop {
        super::constfold::run_one(func);
        let selected = opts.fold_selects && super::constfold::fold_selects(func);
        let nulled = opts
            .addr_facts
            .is_some_and(|facts| super::constfold::fold_addr_compares(func, facts));
        let loaded = opts
            .const_data
            .is_some_and(|cd| super::const_global_fold::fold_loads(func, cd));
        let folded = super::constfold_branch::run_one(func);
        let pruned = super::prune_unreachable::run_one(func);
        bound -= 1;
        if (!folded && !pruned && !loaded && !selected && !nulled) || bound == 0 {
            // The fixed point is the last chance to discover a constant,
            // so survivors resolve here; a resolution that changes the
            // function re-enters the loop to fold what it exposed.
            if !resolved {
                resolved = true;
                if super::constfold::resolve_constant_p(func) {
                    bound = func.blocks.len() + func.insts.len() + 1;
                    continue;
                }
            }
            break;
        }
    }
}

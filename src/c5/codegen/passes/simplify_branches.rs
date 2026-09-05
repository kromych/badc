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
//! can decide the next branch. The same round folds a load of a location
//! this function stored a constant into, which is what a build-time
//! assertion written on a member the function just assigned reads.

use super::value_range::Range;
use crate::c5::ir::FunctionSsa;
use crate::c5::program::Program;
use alloc::collections::BTreeMap;
use alloc::vec::Vec;

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
    implied_ranges: bool,
    /// Fold a load of a location this function stored a constant into
    /// ([`super::store_forward::fold_const_loads`]).
    const_stores: bool,
    /// Entry range per declared parameter, from the interprocedural
    /// join in [`super::ipa_const_param`]. Empty when none is known.
    param_ranges: &'a [Range],
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
                implied_ranges: false,
                const_stores: false,
                param_ranges: &[],
            },
        );
    }
}

/// The `-O` form: const-object loads, select consumers, and null
/// comparisons of non-null symbol addresses fold inside the same fixed
/// point, and a surviving deferred `__builtin_constant_p` resolves to 0
/// on the way out, so no such node reaches an emitter.
pub(crate) fn run_with_const_data(
    funcs: &mut [FunctionSsa],
    program: &Program,
    param_ranges: &BTreeMap<usize, Vec<Range>>,
) {
    let cd = super::const_global_fold::ConstData::build(program);
    let facts = super::constfold::addr_facts(program);
    for func in funcs {
        let ranges = param_ranges
            .get(&func.ent_pc)
            .map_or(&[][..], |r| r.as_slice());
        run_one(
            func,
            &Opts {
                const_data: Some(&cd),
                addr_facts: Some(&facts),
                resolve_constant_p: true,
                fold_selects: true,
                implied_ranges: true,
                const_stores: true,
                param_ranges: ranges,
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
        let forwarded = opts
            .const_data
            .is_some_and(|cd| super::const_global_fold::fold_template_loads(func, cd));
        let ranged = opts.implied_ranges && super::value_range::run_one(func, opts.param_ranges);
        let stored = opts.const_stores && super::store_forward::fold_const_loads(func);
        let folded = super::constfold_branch::run_one(func);
        let threaded = super::thread_phi_branches::run_one(func);
        let pruned = super::prune_unreachable::run_one(func);
        bound -= 1;
        if (!folded
            && !threaded
            && !pruned
            && !loaded
            && !forwarded
            && !selected
            && !nulled
            && !ranged
            && !stored)
            || bound == 0
        {
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

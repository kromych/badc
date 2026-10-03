//! Calls that do not return end their block.
//!
//! A call to a function declared `_Noreturn` (C11 6.7.4) does not return
//! to its caller (6.7.4p8), whatever expression the call stands in. The
//! walker seals a call statement; this pass seals the rest -- `return
//! f(x);`, an initializer, an operand -- by ending the block after the
//! call with `Terminator::Unreachable`. What followed the call moves to a
//! block of its own no edge reaches, which `prune_unreachable` deletes.
//!
//! With `infer`, a function this unit defines does not return either when
//! no path of its body returns: each one ends in a trap, a loop with no
//! exit, or a sealed call. The calls to it are sealed in turn, to a fixed
//! point over the unit's call graph. A weak definition can be replaced by
//! one that returns, and a naked body returns from its own asm, so neither
//! is inferred. The inference changes the callers' code only, not the
//! function's own or its ABI.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use crate::c5::ir::{Block, BlockId, FunctionSsa, Inst, NO_VALUE, Terminator};
use crate::c5::program::Program;
use crate::c5::token::Token;

/// Seal every call to a function that does not return, in `funcs`, and
/// with `infer` the calls to the functions of `funcs` found not to.
pub(crate) fn run(funcs: &mut [FunctionSsa], program: &Program, infer: bool) {
    let known = Known::of(program, funcs);
    seal_all(funcs, known, infer);
}

/// The callees known not to return: parser symbols, `CallExt` bindings,
/// and entry points, of this unit's functions and of its imports.
struct Known {
    declared: BTreeSet<u32>,
    bindings: BTreeSet<i64>,
    entries: BTreeSet<usize>,
}

impl Known {
    fn of(program: &Program, funcs: &[FunctionSsa]) -> Self {
        let symbols = &program.symbols;
        // A function this unit only declares is called at the entry the
        // parser gave its import; one it never calls has none.
        let callable: BTreeSet<usize> = program
            .extern_function_imports
            .iter()
            .map(|&(pc, _)| pc)
            .chain(funcs.iter().map(|f| f.ent_pc))
            .collect();
        Known {
            declared: (0..symbols.len() as u32)
                .filter(|&i| symbols[i as usize].is_noreturn)
                .collect(),
            bindings: symbols
                .iter()
                .filter(|s| s.is_noreturn && s.class == Token::Sys as i64)
                .map(|s| s.val)
                .collect(),
            entries: symbols
                .iter()
                .filter(|s| s.is_noreturn && s.is_fun_entity())
                .map(|s| s.val as usize)
                .filter(|pc| callable.contains(pc))
                .chain(funcs.iter().filter(|f| f.is_noreturn).map(|f| f.ent_pc))
                .collect(),
        }
    }
}

fn seal_all(funcs: &mut [FunctionSsa], mut known: Known, infer: bool) {
    loop {
        for func in funcs.iter_mut() {
            if seal(func, &known) {
                super::prune_unreachable::run_one(func);
            }
        }
        if !infer {
            return;
        }
        let found: Vec<usize> = funcs
            .iter()
            .filter(|f| {
                !f.is_weak && !f.is_naked && !known.entries.contains(&f.ent_pc) && !returns(f)
            })
            .map(|f| f.ent_pc)
            .collect();
        if found.is_empty() {
            return;
        }
        known.entries.extend(found);
    }
}

/// Whether some block of `func` returns to its caller. Run on a function
/// `prune_unreachable` has left only reachable blocks in.
fn returns(func: &FunctionSsa) -> bool {
    func.blocks
        .iter()
        .any(|b| matches!(b.terminator, Terminator::Return(_) | Terminator::TailExt(_)))
}

/// End each block of `func` after its first call to a function that does
/// not return. Returns whether a block was split.
fn seal(func: &mut FunctionSsa, ends: &Known) -> bool {
    let externs: BTreeMap<u32, u32> = func.extern_call_refs.iter().copied().collect();
    let ends_path = |id: u32, inst: &Inst| match inst {
        Inst::Call { target_pc, .. } => match externs.get(&id) {
            Some(sym) => ends.declared.contains(sym),
            None => ends.entries.contains(target_pc),
        },
        Inst::CallExt { binding_idx, .. } => ends.bindings.contains(binding_idx),
        _ => false,
    };
    let mut split = false;
    for b in 0..func.blocks.len() {
        let range = func.blocks[b].inst_range.clone();
        let Some(call) = range
            .clone()
            .find(|&v| ends_path(v, &func.insts[v as usize]))
        else {
            continue;
        };
        if call + 1 == range.end && matches!(func.blocks[b].terminator, Terminator::Unreachable) {
            continue;
        }
        // The rest of the block, with its exit, becomes a block no edge
        // reaches; the phis past it take that block as the predecessor.
        let tail = func.blocks.len() as BlockId;
        let block = &mut func.blocks[b];
        let rest = Block {
            start_pc: block.start_pc,
            inst_range: call + 1..range.end,
            terminator: block.terminator,
            exit_acc: block.exit_acc,
        };
        block.inst_range = range.start..call + 1;
        block.terminator = Terminator::Unreachable;
        block.exit_acc = NO_VALUE;
        let succs = crate::c5::codegen::ssa::mem2reg::successors(
            &rest.terminator,
            &func.computed_goto_targets,
            &func.jump_tables,
        );
        func.blocks.push(rest);
        for s in succs {
            for id in func.blocks[s as usize].inst_range.clone() {
                let Inst::Phi { incoming, .. } = &mut func.insts[id as usize] else {
                    break;
                };
                for (pred, _) in incoming.iter_mut() {
                    if *pred == b as BlockId {
                        *pred = tail;
                    }
                }
            }
        }
        split = true;
    }
    split
}

#[cfg(test)]
mod tests;

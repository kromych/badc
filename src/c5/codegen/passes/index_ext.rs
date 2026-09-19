//! Take the widening of a 32-bit index into the indexed access.
//!
//! `LoadIndexed { index: e }` over `e = Extend { s, I32 }` (or `s &
//! 0xffff_ffff`) becomes `LoadIndexed { index: s, index_ext: Sxtw }`
//! (`Uxtw`), AArch64's `[Xn, Wm, sxtw #s]`, when every reader of `e` is
//! such an index, so `e` dies. A reader of all 64 bits keeps `e` and its
//! accesses: redirecting them would hold `s` live beside it and save no
//! instruction. An `int` parameter is a sign-extended word already; its
//! accesses are marked in place, which takes them out of the readers of
//! its upper half (`drop_redundant_extend::compute_high_observed`).

use alloc::vec::Vec;

use crate::c5::codegen::ssa::reg_alloc::compute_use_counts;
use crate::c5::ir::{BinOp, FunctionSsa, IndexExt, Inst, LoadKind, ValueId};

/// `(source, extension)` when `v` widens the low word of `source`.
fn word_extension(insts: &[Inst], v: ValueId) -> Option<(ValueId, IndexExt)> {
    match insts.get(v as usize)? {
        Inst::Extend {
            value,
            kind: LoadKind::I32,
        } => Some((*value, IndexExt::Sxtw)),
        Inst::BinopI {
            op: BinOp::And,
            lhs,
            rhs_imm: 0xffff_ffff,
        } => Some((*lhs, IndexExt::Uxtw)),
        _ => None,
    }
}

/// The index operand of a live indexed access.
fn index_of(inst: &Inst, live: bool) -> Option<(ValueId, IndexExt)> {
    match inst {
        Inst::LoadIndexed {
            index, index_ext, ..
        } if live => Some((*index, *index_ext)),
        Inst::StoreIndexed {
            index, index_ext, ..
        } => Some((*index, *index_ext)),
        _ => None,
    }
}

fn set_index(inst: &mut Inst, to: ValueId, ext: IndexExt) {
    if let Inst::LoadIndexed {
        index, index_ext, ..
    }
    | Inst::StoreIndexed {
        index, index_ext, ..
    } = inst
    {
        *index = to;
        *index_ext = ext;
    }
}

/// One round; true when an access changed. A chain of extensions goes
/// one link per round, on the use counts the previous round changed.
fn run_round(func: &mut FunctionSsa) -> bool {
    let counts = compute_use_counts(func);
    let live = |v: usize| counts.get(v).copied().unwrap_or(0) > 0;
    // Per value: how many live accesses read it as their index.
    let mut as_index: Vec<u32> = alloc::vec![0; func.insts.len()];
    for (v, inst) in func.insts.iter().enumerate() {
        if let Some((index, _)) = index_of(inst, live(v))
            && let Some(n) = as_index.get_mut(index as usize)
        {
            *n += 1;
        }
    }
    let mut changed = false;
    for v in 0..func.insts.len() {
        let Some((index, ext)) = index_of(&func.insts[v], live(v)) else {
            continue;
        };
        if let Some((source, widening)) = word_extension(&func.insts, index) {
            // A base that is also `index` counts as another reader.
            if counts[index as usize] == as_index[index as usize] {
                let ext = if ext == IndexExt::None { widening } else { ext };
                set_index(&mut func.insts[v], source, ext);
                changed = true;
            }
        } else if ext == IndexExt::None
            && matches!(
                func.insts.get(index as usize),
                Some(Inst::ParamRef {
                    kind: LoadKind::I32,
                    ..
                })
            )
        {
            set_index(&mut func.insts[v], index, IndexExt::Sxtw);
            changed = true;
        }
    }
    changed
}

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        let indexed = |i: &Inst| matches!(i, Inst::LoadIndexed { .. } | Inst::StoreIndexed { .. });
        if !func.insts.iter().any(indexed) {
            continue;
        }
        for _ in 0..func.insts.len() {
            if !run_round(func) {
                break;
            }
        }
    }
}

#[cfg(test)]
mod tests;

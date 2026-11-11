//! A store to a local's frame slot that nothing reads: the forwarding
//! replaced every load of the slot, so the bytes the store writes are never
//! observed and it goes. Only a function in which no live instruction holds
//! a local's address qualifies: an address reaches the whole object behind
//! it, whose extent the slots do not record; without one, a load is the
//! only reader. A function with a `__try` region, whose handlers read the
//! frame, and one that calls a returns-twice function keep their stores.

use alloc::vec::Vec;

use crate::c5::codegen::ssa::reg_alloc::compute_use_counts;
use crate::c5::ir::{FunctionSsa, Inst};

/// Drop the dead stores of `func`; the local slots they wrote.
pub(crate) fn run(func: &mut FunctionSsa) -> Vec<i64> {
    if func.has_seh() || func.has_returns_twice_call {
        return Vec::new();
    }
    let uses = compute_use_counts(func);
    let addressed = (func.insts.iter().enumerate())
        .any(|(v, inst)| matches!(inst, Inst::LocalAddr(_)) && uses[v] > 0);
    if addressed {
        return Vec::new();
    }
    // Object of a cell: the first cell and count of its multi-cell object.
    let object = |cell: i64| {
        (func.multi_cell_slots.iter())
            .find(|&&(base, cells)| (base..base + cells).contains(&cell))
            .copied()
            .unwrap_or((cell, 1))
    };
    let mut read: Vec<(i64, i64)> = Vec::new();
    let mut mark = |cells: (i64, i64)| {
        if !read.contains(&cells) {
            read.push(cells);
        }
    };
    let cells_of = |off: i64, disp: i32, width: i64| {
        let at = off * 8 + i64::from(disp);
        at.div_euclid(8)..=(at + width.max(1) - 1).div_euclid(8)
    };
    for inst in &func.insts {
        match *inst {
            Inst::LoadLocal {
                off, disp, kind, ..
            } => {
                for cell in cells_of(off, disp, kind.bytes() as i64) {
                    mark(object(cell));
                }
            }
            Inst::AllocaInit(off) => mark(object(off)),
            _ => {}
        }
    }
    let kept = |cell: i64| {
        cell >= 0
            || read.contains(&object(cell))
            || func.array_slots.contains(&object(cell).0)
            || func.over_aligned.iter().any(|m| m.slot == object(cell).0)
    };
    let mut freed: Vec<i64> = Vec::new();
    for (v, &used) in uses.iter().enumerate() {
        let Inst::StoreLocal {
            off,
            disp,
            kind,
            volatile: false,
            ..
        } = func.insts[v]
        else {
            continue;
        };
        let cells = cells_of(off, disp, super::copy_elide::store_width(kind));
        if used == 0 && !cells.clone().any(kept) {
            func.insts[v] = Inst::Imm(0);
            for cell in cells {
                if !freed.contains(&cell) {
                    freed.push(cell);
                }
            }
        }
    }
    freed
}

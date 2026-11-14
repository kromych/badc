//! A store to a local's frame slot that nothing reads: the forwarding
//! replaced every load of the slot, so the bytes the store writes are never
//! observed and it goes. Only a function in which no live address of a
//! local reaches anything but a write into it -- a fill, a copy's
//! destination, a store's address, also past a constant offset --
//! qualifies: such an address reaches the whole object behind it, whose
//! extent the slots do not record; without one, a load is the only reader,
//! and a write through an address goes too when no load reads the cells it
//! covers. A function with a `__try` region, whose handlers read the frame,
//! and one that calls a returns-twice function keep their stores.

use alloc::vec::Vec;

use crate::c5::codegen::ssa::reg_alloc::compute_use_counts;
use crate::c5::ir::{BinOp, FunctionSsa, Inst, NO_VALUE, ValueId};

/// Drop the dead stores of `func`; the local slots they wrote.
pub(crate) fn run(func: &mut FunctionSsa) -> Vec<i64> {
    if func.has_seh() || func.has_returns_twice_call {
        return Vec::new();
    }
    let uses = compute_use_counts(func);
    let mut users: Vec<Vec<usize>> = alloc::vec![Vec::new(); func.insts.len()];
    for (u, inst) in func.insts.iter().enumerate() {
        inst.for_each_operand(|v| {
            if let Some(list) = users.get_mut(v as usize) {
                list.push(u);
            }
        });
    }
    let mut ends = alloc::vec![false; func.insts.len()];
    for b in &func.blocks {
        let mut end = |v: ValueId| {
            if let Some(e) = ends.get_mut(v as usize) {
                *e = true;
            }
        };
        b.terminator.for_each_operand(&mut end);
        if b.exit_acc != NO_VALUE {
            end(b.exit_acc);
        }
    }
    let addressed = (func.insts.iter().enumerate()).any(|(v, inst)| {
        matches!(inst, Inst::LocalAddr(_)) && uses[v] > 0 && !writes_only(func, &users, &ends, v, 4)
    });
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
    // A load nothing reads, one the forwarding replaced, observes nothing.
    for (v, inst) in func.insts.iter().enumerate() {
        match *inst {
            Inst::LoadLocal {
                off,
                disp,
                kind,
                volatile,
            } if volatile || uses[v] > 0 || ends[v] => {
                for cell in cells_of(off, disp, kind.bytes() as i64) {
                    mark(object(cell));
                }
            }
            Inst::AllocaInit(off) => mark(object(off)),
            _ => {}
        }
    }
    let kept = |cell: i64| cell >= 0 || read.contains(&object(cell));
    // An array or over-aligned object keeps its cells where the frame
    // orders it, though nothing reads them.
    let placed = |cell: i64| {
        func.array_slots.contains(&object(cell).0)
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
            for cell in cells.filter(|&c| !placed(c)) {
                if !freed.contains(&cell) {
                    freed.push(cell);
                }
            }
        }
    }
    // A write through an address whose cells no load reads.
    let slot_of = |mut a: ValueId| {
        let mut disp = 0i64;
        for _ in 0..5 {
            match func.insts.get(a as usize)? {
                Inst::LocalAddr(off) => return Some((*off, disp)),
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs,
                    rhs_imm,
                } => {
                    disp += rhs_imm;
                    a = *lhs;
                }
                _ => return None,
            }
        }
        None
    };
    let mut dead: Vec<usize> = Vec::new();
    for (v, inst) in func.insts.iter().enumerate() {
        let (dst, at, width) = match *inst {
            Inst::Mzero { dst, size, .. } | Inst::Mcpy { dst, size, .. } => (dst, 0, size),
            Inst::Store {
                addr,
                disp,
                kind,
                volatile: false,
                ..
            } => (addr, i64::from(disp), super::copy_elide::store_width(kind)),
            _ => continue,
        };
        let Some((off, disp)) = slot_of(dst) else {
            continue;
        };
        let Ok(disp) = i32::try_from(disp + at) else {
            continue;
        };
        let cells = cells_of(off, disp, width);
        if uses[v] == 0 && off < 0 && !cells.clone().any(kept) {
            dead.push(v);
            for cell in cells.filter(|&c| !placed(c)) {
                if !freed.contains(&cell) {
                    freed.push(cell);
                }
            }
        }
    }
    for v in dead {
        func.insts[v] = Inst::Imm(0);
    }
    freed
}

/// Whether address `a` reaches only writes into its object: a fill, a
/// copy's destination or a store's address, directly or past `depth`
/// constant offsets.
fn writes_only(
    func: &FunctionSsa,
    users: &[Vec<usize>],
    ends: &[bool],
    a: usize,
    depth: u32,
) -> bool {
    let id = a as ValueId;
    !ends[a]
        && users[a].iter().all(|&u| match func.insts[u] {
            Inst::Mzero { dst, .. } => dst == id,
            Inst::Mcpy { dst, src, .. } => dst == id && src != id,
            Inst::Store {
                addr,
                value,
                volatile: false,
                ..
            } => addr == id && value != id,
            Inst::BinopI {
                op: BinOp::Add,
                lhs,
                ..
            } => lhs == id && depth > 0 && writes_only(func, users, ends, u, depth - 1),
            _ => false,
        })
}

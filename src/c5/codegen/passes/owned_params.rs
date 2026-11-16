//! An aggregate the caller passes as the address of a copy the callee owns
//! (AAPCS64 B.4, the Microsoft x64 convention) is copied again on entry
//! into the parameter's slot group, which the body addresses. When the
//! body never writes the group, or lets its address escape -- where the
//! copy could not be promoted to registers anyway -- the body uses the
//! caller's copy: each access to the group goes through the address the
//! argument cell holds, and the entry copy goes. A group written only
//! through its own accesses keeps the copy, which scalar replacement
//! promotes.

use alloc::vec;
use alloc::vec::Vec;

use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, OwnedParam, ValueId};

/// Use the caller's copy for each qualifying parameter of `func`; the
/// frame slots left unused.
pub(crate) fn run(func: &mut FunctionSsa) -> Vec<i64> {
    let params = core::mem::take(&mut func.owned_params);
    let mut freed = Vec::new();
    for p in params {
        match entry_copy(func, &p) {
            Some((copy, addr)) if in_place(func, &p, copy) => {
                rewrite(func, &p, copy, addr);
                freed.extend(p.base..p.base + p.cells);
            }
            _ => func.owned_params.push(p),
        }
    }
    freed
}

fn in_group(p: &OwnedParam, slot: i64) -> bool {
    (p.base..p.base + p.cells).contains(&slot)
}

/// The entry block's copy of `p` and the address it reads, which the
/// argument cell holds.
fn entry_copy(func: &FunctionSsa, p: &OwnedParam) -> Option<(ValueId, ValueId)> {
    let entry = func.blocks.first()?.inst_range.clone();
    entry
        .into_iter()
        .find_map(|v| match func.insts[v as usize] {
            Inst::Mcpy { dst, src, .. }
                if matches!(func.insts[dst as usize], Inst::LocalAddr(b) if b == p.base)
                    && matches!(func.insts[src as usize],
                    Inst::LoadLocal { off, disp: 0, kind: LoadKind::I64, .. } if off == p.cell) =>
            {
                Some((v, src))
            }
            _ => None,
        })
}

/// Whether the body may use the caller's copy: every access to the group
/// follows the entry copy, and the group is never written or its address
/// escapes.
fn in_place(func: &FunctionSsa, p: &OwnedParam, copy: ValueId) -> bool {
    let dst = copy_dst(func, copy);
    let slot_of = |inst: &Inst| match *inst {
        Inst::LocalAddr(s) | Inst::LoadLocal { off: s, .. } | Inst::StoreLocal { off: s, .. } => {
            Some(s)
        }
        _ => None,
    };
    let early = (0..copy)
        .any(|v| v != dst && slot_of(&func.insts[v as usize]).is_some_and(|s| in_group(p, s)));
    if early {
        return false;
    }
    // Addresses into the group: its slots' and offsets from them, each
    // listed on the tape ahead of its readers. A phi of one escapes.
    let mut addr = vec![false; func.insts.len()];
    for (v, inst) in func.insts.iter().enumerate() {
        let is_addr = |x: ValueId| addr[x as usize];
        addr[v] = match *inst {
            Inst::LocalAddr(s) => in_group(p, s) && v as ValueId != dst,
            Inst::BinopI {
                op: BinOp::Add | BinOp::Sub,
                lhs,
                ..
            } => is_addr(lhs),
            Inst::Binop {
                op: BinOp::Add,
                lhs,
                rhs,
            } => is_addr(lhs) || is_addr(rhs),
            Inst::Copy { value, .. } => is_addr(value),
            _ => false,
        };
    }
    let is_addr = |x: ValueId| addr.get(x as usize).copied().unwrap_or(false);
    let (mut written, mut escapes) = (false, false);
    for (v, inst) in func.insts.iter().enumerate() {
        match *inst {
            _ if v as ValueId == copy || addr[v] => {}
            Inst::StoreLocal { off, .. } => written |= in_group(p, off),
            Inst::LocalAddr(_) | Inst::LoadLocal { .. } | Inst::Load { .. } => {}
            Inst::LoadIndexed { index, .. } => escapes |= is_addr(index),
            Inst::Store { addr: a, value, .. } => {
                written |= is_addr(a);
                escapes |= is_addr(value);
            }
            Inst::StoreIndexed {
                base, index, value, ..
            } => {
                written |= is_addr(base);
                escapes |= is_addr(index) || is_addr(value);
            }
            Inst::Mcpy { dst, .. } | Inst::Mzero { dst, .. } => written |= is_addr(dst),
            _ => inst.for_each_operand(|o| escapes |= is_addr(o)),
        }
    }
    for block in &func.blocks {
        block.terminator.for_each_operand(|o| escapes |= is_addr(o));
    }
    escapes || !written
}

/// The `LocalAddr` the entry copy writes through.
fn copy_dst(func: &FunctionSsa, copy: ValueId) -> ValueId {
    match func.insts[copy as usize] {
        Inst::Mcpy { dst, .. } => dst,
        _ => crate::c5::ir::NO_VALUE,
    }
}

/// Point every access to the group at the caller's copy at `addr` and
/// drop the entry copy. The object's own address is `addr` itself: its
/// readers read `addr`, and it is left a dead constant.
fn rewrite(func: &mut FunctionSsa, p: &OwnedParam, copy: ValueId, addr: ValueId) {
    let dst = copy_dst(func, copy);
    let disp_of = |s: i64, d: i64| ((s - p.base) * 8 + d) as i32;
    let mut same: Vec<ValueId> = Vec::new();
    for v in 0..func.insts.len() {
        let new = match func.insts[v] {
            Inst::LocalAddr(s) if in_group(p, s) && v as ValueId != dst => {
                let d = (s - p.base) * 8;
                if d == 0 {
                    same.push(v as ValueId);
                    Inst::Imm(0)
                } else {
                    Inst::BinopI {
                        op: BinOp::Add,
                        lhs: addr,
                        rhs_imm: d,
                    }
                }
            }
            Inst::LoadLocal {
                off,
                disp,
                kind,
                volatile,
            } if in_group(p, off) => Inst::Load {
                addr,
                disp: disp_of(off, disp as i64),
                kind,
                volatile,
                align: p.align,
                pc_rel: false,
            },
            Inst::StoreLocal {
                off,
                disp,
                value,
                kind,
                volatile,
                ..
            } if in_group(p, off) => Inst::Store {
                addr,
                disp: disp_of(off, disp as i64),
                value,
                kind,
                volatile,
                align: p.align,
                pc_rel: false,
            },
            _ => continue,
        };
        func.insts[v] = new;
    }
    func.insts[copy as usize] = Inst::Imm(0);
    let to_addr = |o: &mut ValueId| {
        if same.contains(o) {
            *o = addr;
        }
    };
    for inst in func.insts.iter_mut() {
        inst.for_each_operand_mut(to_addr);
    }
    for block in func.blocks.iter_mut() {
        to_addr(&mut block.exit_acc);
        block.terminator.for_each_operand_mut(to_addr);
    }
}

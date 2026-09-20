//! Aggregates built in a temporary and copied once.
//!
//! A compound literal is an object of its own (C99 6.5.2.5p5), so
//! `*a = (struct A){ ... }` fills a frame temporary and copies it into
//! place; a by-value aggregate the walker stages does the same. When the
//! temporary's whole content is written in the block that copies it,
//! before the copy, and nothing between the first write and the copy
//! touches memory at all, the writes can address the destination and the
//! copy goes with the temporary's storage.
//!
//! The window condition is what keeps the rewrite honest. Moving a write
//! earlier makes it visible to everything in between, so anything that
//! may read the destination would see the new value early, anything that
//! may write it would win where the copy used to, and an initializer
//! that reads the destination -- `*a = (struct A){ a->N, 1 }` -- would
//! read what the move already overwrote. Requiring the window to hold no
//! memory access and no call answers all three at once.

use super::super::ir::{BinOp, FunctionSsa, Inst, ValueId};
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for f in funcs.iter_mut() {
        run_one(f);
    }
}

/// The frame slot and byte offset an address value names: a
/// `LocalAddr`, or a constant add off one.
fn base_of(f: &FunctionSsa, v: ValueId) -> Option<(i64, i64)> {
    match f.insts.get(v as usize)? {
        Inst::LocalAddr(off) if *off < 0 => Some((*off, 0)),
        Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm,
        } => base_of(f, *lhs).map(|(b, o)| (b, o + rhs_imm)),
        _ => None,
    }
}

fn run_one(f: &mut FunctionSsa) {
    if f.synthetic_base <= 0 || !f.insts.iter().any(|i| matches!(i, Inst::Mcpy { .. })) {
        return;
    }
    // Where each slot is named, and by what. A slot this pass may
    // rewrite is named only by `LocalAddr`s feeding its writers and the
    // one copy that reads it.
    let mut named: BTreeMap<i64, Vec<usize>> = BTreeMap::new();
    for (i, inst) in f.insts.iter().enumerate() {
        match inst {
            Inst::LocalAddr(off) | Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => {
                named.entry(*off).or_default().push(i);
            }
            Inst::AllocaInit(off) | Inst::LifetimeEnd(off) => {
                named.entry(*off).or_default().push(i);
            }
            Inst::Call { ret_slot_local, .. }
            | Inst::CallIndirect { ret_slot_local, .. }
            | Inst::CallExt { ret_slot_local, .. } => {
                named.entry(*ret_slot_local).or_default().push(i);
            }
            _ => {}
        }
    }
    // Uses of each value, so a temporary's address is known to reach
    // nothing but its writers and the copy.
    let mut users: Vec<Vec<usize>> = alloc::vec![Vec::new(); f.insts.len()];
    for (i, inst) in f.insts.iter().enumerate() {
        inst.for_each_operand(|v| {
            if let Some(u) = users.get_mut(v as usize) {
                u.push(i);
            }
        });
    }
    for blk in &f.blocks {
        let mut t = blk.terminator;
        t.for_each_operand_mut(|v| {
            if let Some(u) = users.get_mut(*v as usize) {
                u.push(usize::MAX);
            }
        });
        if let Some(u) = users.get_mut(blk.exit_acc as usize) {
            u.push(usize::MAX);
        }
    }

    let mut redirects: Vec<(usize, ValueId)> = Vec::new();
    let mut elided: Vec<(usize, ValueId)> = Vec::new();
    let mut taken: BTreeSet<i64> = BTreeSet::new();
    for blk in &f.blocks {
        for pc in blk.inst_range.clone() {
            let i = pc as usize;
            let Some(&Inst::Mcpy { dst, src, size, .. }) = f.insts.get(i) else {
                continue;
            };
            let Some((slot, 0)) = base_of(f, src) else {
                continue;
            };
            if taken.contains(&slot) || base_of(f, dst).is_some_and(|(d, _)| d == slot) {
                continue;
            }
            let Some(plan) = plan_one(f, &named, &users, slot, blk.inst_range.start as usize, i)
            else {
                continue;
            };
            if !covers(&plan.spans, size) {
                continue;
            }
            redirects.extend(plan.redirects.iter().map(|&r| (r, dst)));
            elided.push((i, dst));
            taken.insert(slot);
        }
    }
    if elided.is_empty() {
        return;
    }
    // Each redirected instruction is a writer whose address is the
    // temporary's base, or the add that formed an interior address from
    // it; either takes the destination's address in its place.
    for (r, dst) in redirects {
        match &mut f.insts[r] {
            Inst::Store { addr, .. }
            | Inst::Mzero { dst: addr, .. }
            | Inst::BinopI { lhs: addr, .. } => *addr = dst,
            _ => unreachable!("only a write or its address is redirected"),
        }
    }
    // The copy's value is the destination address, which an assignment
    // expression may yield; a `Copy` of it keeps that and emits nothing
    // where nothing reads it.
    for (i, dst) in elided {
        f.insts[i] = Inst::Copy {
            value: dst,
            is_fp: false,
        };
    }
    // The temporary's address values have no readers left. They emit no
    // code either way, but the frame repack keeps a slot any instruction
    // names, so drop the name.
    let mut live = alloc::vec![false; f.insts.len()];
    for inst in &f.insts {
        inst.for_each_operand(|v| {
            if let Some(l) = live.get_mut(v as usize) {
                *l = true;
            }
        });
    }
    for blk in &f.blocks {
        let mut t = blk.terminator;
        t.for_each_operand_mut(|v| {
            if let Some(l) = live.get_mut(*v as usize) {
                *l = true;
            }
        });
        if let Some(l) = live.get_mut(blk.exit_acc as usize) {
            *l = true;
        }
    }
    for (i, inst) in f.insts.iter_mut().enumerate() {
        if let Inst::LocalAddr(off) = inst
            && taken.contains(off)
            && !live[i]
        {
            *inst = Inst::Imm(0);
        }
    }
}

/// What one elision changes: the instructions whose address operand
/// becomes the destination's, and the byte spans the writes cover.
struct Plan {
    redirects: Vec<usize>,
    spans: Vec<(i64, i64)>,
}

/// Whether `spans` cover `[0, size)` with nothing outside it. A byte
/// left unwritten would reach the destination holding what it held.
fn covers(spans: &[(i64, i64)], size: i64) -> bool {
    let mut spans = spans.to_vec();
    spans.sort_unstable();
    let mut at = 0i64;
    for (lo, w) in spans {
        if lo < 0 || lo + w > size || lo > at {
            return false;
        }
        at = at.max(lo + w);
    }
    at >= size
}

fn store_width(kind: crate::c5::ir::StoreKind) -> i64 {
    use crate::c5::ir::StoreKind::*;
    match kind {
        I8 => 1,
        I16 => 2,
        I32 | F32 => 4,
        I64 | F64 => 8,
        F80 | F128 | V128 => 16,
    }
}

/// The plan for the copy at `mcpy`, when the temporary at `slot`
/// qualifies: its address reaches nothing but the writes it owns and
/// that copy, every write is in `[start, mcpy)`, and nothing else in the
/// window from the first write touches memory or calls.
fn plan_one(
    f: &FunctionSsa,
    named: &BTreeMap<i64, Vec<usize>>,
    users: &[Vec<usize>],
    slot: i64,
    start: usize,
    mcpy: usize,
) -> Option<Plan> {
    // Every value that names the temporary: its base address and the
    // constant adds off it.
    let mut addrs: BTreeMap<usize, i64> = BTreeMap::new();
    for &a in named.get(&slot)? {
        if !matches!(f.insts.get(a), Some(Inst::LocalAddr(_))) || a < start || a > mcpy {
            return None;
        }
        addrs.insert(a, 0);
    }
    for i in start..mcpy {
        if let Some(Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm,
        }) = f.insts.get(i)
            && let Some(&off) = addrs.get(&(*lhs as usize))
        {
            addrs.insert(i, off + rhs_imm);
        }
    }
    let mut redirects: Vec<usize> = Vec::new();
    let mut spans: Vec<(i64, i64)> = Vec::new();
    let mut writes: Vec<usize> = Vec::new();
    for (&a, &off) in &addrs {
        let mut reached = false;
        for &u in &users[a] {
            if u == mcpy {
                continue;
            }
            match f.insts.get(u) {
                Some(Inst::Store {
                    addr,
                    disp,
                    kind,
                    volatile: false,
                    ..
                }) if *addr == a as ValueId => {
                    spans.push((off + *disp as i64, store_width(*kind)));
                    writes.push(u);
                    reached = true;
                }
                Some(Inst::Mzero { dst, size, .. }) if *dst == a as ValueId => {
                    spans.push((off, *size));
                    writes.push(u);
                    reached = true;
                }
                // An interior address formed from this one; it is in
                // `addrs` and answers for its own users.
                _ if addrs.contains_key(&u) => reached = true,
                // An address the walker formed and nothing reads.
                Some(inst) if inst.is_pure() && users[u].is_empty() => {}
                _ => return None,
            }
        }
        // The base keeps its slot; an interior address takes the
        // destination in the add that formed it.
        if reached && off != 0 {
            redirects.push(a);
        }
    }
    // A write through the base address takes the destination directly.
    for &w in &writes {
        let base = match f.insts.get(w) {
            Some(Inst::Store { addr, .. }) | Some(Inst::Mzero { dst: addr, .. }) => *addr as usize,
            _ => return None,
        };
        if addrs.get(&base) == Some(&0) {
            redirects.push(w);
        }
    }
    if writes.is_empty() {
        return None;
    }
    writes.sort_unstable();
    let first = *writes.first()?;
    if *writes.last()? >= mcpy {
        return None;
    }
    // Between the first write and the copy only the writes themselves,
    // the addresses they take and values computed without reading
    // memory may stand.
    for i in first..mcpy {
        if writes.contains(&i) || addrs.contains_key(&i) {
            continue;
        }
        match f.insts.get(i) {
            Some(
                Inst::Imm(_)
                | Inst::ImmData(_)
                | Inst::ImmCode(_)
                | Inst::ImmExtCode(_)
                | Inst::BlockAddr(_)
                | Inst::TlsAddr(_)
                | Inst::Binop { .. }
                | Inst::BinopI { .. }
                | Inst::Neg(_)
                | Inst::Fneg(_)
                | Inst::Fma { .. }
                | Inst::MulAdd { .. }
                | Inst::Extend { .. }
                | Inst::Bswap { .. }
                | Inst::BitCount { .. }
                | Inst::Copy { .. }
                | Inst::FpCast { .. }
                | Inst::ParamRef { .. }
                | Inst::LifetimeEnd(_),
            ) => {}
            // An address into anything else may reach the destination.
            _ => return None,
        }
    }
    redirects.sort_unstable();
    redirects.dedup();
    Some(Plan { redirects, spans })
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{Block, FunctionSsa, Inst, StoreKind, Terminator};
    use super::*;

    /// The instruction sequence as text, so a decline is compared
    /// without `Inst` needing an equality of its own.
    fn shape(f: &FunctionSsa) -> alloc::vec::Vec<alloc::string::String> {
        f.insts.iter().map(|i| alloc::format!("{i:?}")).collect()
    }

    fn one_block(insts: Vec<Inst>, locals: i64, groups: Vec<(i64, i64)>) -> FunctionSsa {
        let n = insts.len() as u32;
        FunctionSsa {
            locals,
            synthetic_base: 1,
            multi_cell_slots: groups,
            inst_src: alloc::vec![(0, 0); n as usize],
            f32_values: alloc::vec![false; n as usize],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: Terminator::Return(crate::c5::ir::NO_VALUE),
                exit_acc: crate::c5::ir::NO_VALUE,
            }],
            insts,
            ..Default::default()
        }
    }

    /// v0 is the destination address; the temporary at -2 is filled by
    /// two stores and copied whole, so both stores take the destination
    /// and the copy goes.
    fn built_and_copied() -> FunctionSsa {
        one_block(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: crate::c5::ir::LoadKind::I64
                },
                Inst::Imm(7),
                Inst::LocalAddr(-2),
                Inst::Store {
                    addr: 2,
                    disp: 0,
                    value: 1,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                },
                Inst::LocalAddr(-2),
                Inst::Store {
                    addr: 4,
                    disp: 8,
                    value: 1,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                },
                Inst::Mcpy {
                    dst: 0,
                    src: 2,
                    size: 16,
                    align: 8,
                },
            ],
            2,
            alloc::vec![(-2, 2)],
        )
    }

    #[test]
    fn a_temporary_written_before_its_copy_is_built_in_place() {
        let mut f = built_and_copied();
        run_one(&mut f);
        assert!(matches!(
            f.insts[3],
            Inst::Store {
                addr: 0,
                disp: 0,
                ..
            }
        ));
        assert!(matches!(
            f.insts[5],
            Inst::Store {
                addr: 0,
                disp: 8,
                ..
            }
        ));
        assert!(matches!(f.insts[6], Inst::Copy { value: 0, .. }));
    }

    /// A load in the window may read the destination, which the moved
    /// stores would have overwritten.
    #[test]
    fn a_load_between_the_writes_and_the_copy_declines() {
        let mut f = built_and_copied();
        f.insts.insert(
            5,
            Inst::Load {
                addr: 0,
                disp: 0,
                kind: crate::c5::ir::LoadKind::I64,
                volatile: false,
                align: 0,
            },
        );
        for inst in f.insts.iter_mut().skip(6) {
            inst.for_each_operand_mut(|v| {
                if *v >= 5 {
                    *v += 1;
                }
            });
        }
        f.blocks[0].inst_range = 0..f.insts.len() as u32;
        f.inst_src.push((0, 0));
        f.f32_values.push(false);
        let before = shape(&f);
        run_one(&mut f);
        assert_eq!(shape(&f), before, "the load bars the rewrite");
    }

    /// A copy narrower than the temporary would leave bytes of it
    /// unwritten at the destination.
    #[test]
    fn a_partial_copy_declines() {
        let mut f = built_and_copied();
        let Inst::Mcpy { size, .. } = &mut f.insts[6] else {
            unreachable!()
        };
        *size = 8;
        let before = shape(&f);
        run_one(&mut f);
        assert_eq!(shape(&f), before);
    }

    /// An address of the temporary that reaches anything but its own
    /// writes and the copy bars the rewrite.
    #[test]
    fn an_escaping_temporary_declines() {
        let mut f = built_and_copied();
        f.insts.push(Inst::Store {
            addr: 0,
            disp: 0,
            value: 2,
            kind: StoreKind::I64,
            volatile: false,
            align: 0,
        });
        f.blocks[0].inst_range = 0..f.insts.len() as u32;
        f.inst_src.push((0, 0));
        f.f32_values.push(false);
        let before = shape(&f);
        run_one(&mut f);
        assert_eq!(shape(&f), before);
    }
}

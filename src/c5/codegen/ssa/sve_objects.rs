//! SVE objects as values. An automatic SVE object takes arena storage whose
//! base a hidden slot holds (`Decl::Vla`). Where that base addresses only the
//! object's own whole-register loads and stores, the object becomes values:
//! each store defines it and each load reads the reaching definition, a phi
//! where definitions meet; the storage and, with no `alloca` left, the
//! arena's bookkeeping go. An object read where no store reaches keeps its
//! memory, as do those of a function with `setjmp`, a computed goto, `asm
//! goto` or `__try`.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use super::super::ir::{BlockId, FunctionSsa, Inst, LoadKind, StoreKind, Terminator, ValueId};
use super::mem2reg::{dominance_frontiers, dominators, insert_phis, successors};
use crate::c5::op::Intrinsic as I;

/// An SVE load or store: its kind, address and stored value.
fn access(inst: &Inst) -> Option<(LoadKind, ValueId, Option<ValueId>)> {
    let Inst::Intrinsic { kind, args } = inst else {
        return None;
    };
    let (k, store) = match I::from_i64(*kind)? {
        I::SveLoadZ => (LoadKind::SveVector, false),
        I::SveLoadP => (LoadKind::SvePredicate, false),
        I::SveStoreZ => (LoadKind::SveVector, true),
        I::SveStoreP => (LoadKind::SvePredicate, true),
        _ => return None,
    };
    let (&addr, rest) = args.split_first()?;
    Some((k, addr, if store { rest.first().copied() } else { None }))
}

/// The kind of the SVE object the `Alloca` at `v` allocates.
fn arena_object(func: &FunctionSsa, v: ValueId) -> Option<LoadKind> {
    let Inst::Intrinsic { kind, args } = func.insts.get(v as usize)? else {
        return None;
    };
    if *kind != I::Alloca as i64 {
        return None;
    }
    let Inst::Intrinsic { kind, .. } = func.insts.get(*args.first()? as usize)? else {
        return None;
    };
    match I::from_i64(*kind)? {
        I::SveVlBytes => Some(LoadKind::SveVector),
        I::SvePlBytes => Some(LoadKind::SvePredicate),
        _ => None,
    }
}

/// Per value, the instructions reading it, and whether a terminator does.
fn readers(func: &FunctionSsa) -> (Vec<Vec<ValueId>>, Vec<bool>) {
    let n = func.insts.len();
    let mut by = alloc::vec![Vec::new(); n];
    for (pc, inst) in func.insts.iter().enumerate() {
        inst.for_each_operand(|v| {
            if (v as usize) < n {
                by[v as usize].push(pc as ValueId);
            }
        });
    }
    let mut term = alloc::vec![false; n];
    for blk in &func.blocks {
        blk.terminator.for_each_operand(|v| {
            if (v as usize) < n {
                term[v as usize] = true;
            }
        });
    }
    (by, term)
}

/// The hidden slots of the objects whose base addresses nothing but their
/// own whole-register accesses, with their kinds.
fn candidates(func: &FunctionSsa) -> BTreeMap<i64, LoadKind> {
    let (by, term) = readers(func);
    let mut kind: BTreeMap<i64, Option<LoadKind>> = BTreeMap::new();
    let merge = |kind: &mut BTreeMap<i64, Option<LoadKind>>, slot: i64, k: Option<LoadKind>| {
        let e = kind.entry(slot).or_insert(k);
        if *e != k {
            *e = None;
        }
    };
    let base_read = |inst: &Inst| {
        matches!(
            inst,
            Inst::LoadLocal {
                disp: 0,
                kind: LoadKind::I64,
                volatile: false,
                ..
            }
        )
    };
    for (pc, inst) in func.insts.iter().enumerate() {
        match inst {
            Inst::StoreLocal {
                off,
                disp: 0,
                value,
                kind: StoreKind::I64,
                volatile: false,
                ..
            } => {
                let own = by[*value as usize] == [pc as ValueId] && !term[*value as usize];
                merge(&mut kind, *off, arena_object(func, *value).filter(|_| own));
            }
            Inst::LoadLocal { .. } if base_read(inst) => {}
            Inst::StoreLocal { off, .. }
            | Inst::LoadLocal { off, .. }
            | Inst::LocalAddr(off)
            | Inst::AllocaInit(off) => merge(&mut kind, *off, None),
            _ => {}
        }
    }
    for (pc, inst) in func.insts.iter().enumerate() {
        let Inst::LoadLocal { off, .. } = inst else {
            continue;
        };
        let Some(Some(k)) = kind.get(off).copied() else {
            continue;
        };
        let pc = pc as ValueId;
        let addresses = |r: &ValueId| {
            access(&func.insts[*r as usize])
                .is_some_and(|(rk, addr, value)| rk == k && addr == pc && value != Some(pc))
        };
        if !base_read(inst) || term[pc as usize] || !by[pc as usize].iter().all(addresses) {
            kind.insert(*off, None);
        }
    }
    kind.into_iter()
        .filter_map(|(s, k)| Some((s, k?)))
        .collect()
}

/// Make the SVE objects of `func` that qualify values; the hidden slots
/// of those that did.
pub(crate) fn run(func: &mut FunctionSsa) -> Vec<i64> {
    if !func.insts.iter().any(|i| access(i).is_some())
        || func.has_returns_twice_call
        || func.has_seh()
        || (func.blocks.iter()).any(|b| {
            matches!(
                b.terminator,
                Terminator::GotoIndirect { .. } | Terminator::AsmGoto { .. }
            )
        })
    {
        return Vec::new();
    }
    let objects = candidates(func);
    if objects.is_empty() {
        return Vec::new();
    }
    let idom = dominators(func);
    let phis = phi_blocks(func, &objects, &idom);
    let objects: BTreeMap<i64, LoadKind> = objects
        .into_iter()
        .filter(|(s, _)| phis.contains_key(s))
        .collect();
    if objects.is_empty() {
        return Vec::new();
    }
    let placed: BTreeMap<i64, BTreeSet<BlockId>> =
        (phis.into_iter()).filter(|(_, b)| !b.is_empty()).collect();
    let phi_at = insert_phis(func, &placed, &objects);
    rename(func, &objects, &phi_at, &dominators(func));
    release_storage(func, &objects);
    objects.into_keys().collect()
}

/// The blocks taking a phi per object, the iterated dominance frontier of
/// its stores where it is live; an object read where no store reaches, or
/// accessed in a block the entry does not reach, has no entry.
fn phi_blocks(
    func: &FunctionSsa,
    objects: &BTreeMap<i64, LoadKind>,
    idom: &[BlockId],
) -> BTreeMap<i64, BTreeSet<BlockId>> {
    let nb = func.blocks.len();
    let base = bases(func, objects);
    let df = dominance_frontiers(func, idom);
    let succs: Vec<Vec<BlockId>> = (func.blocks.iter())
        .map(|b| {
            successors(
                &b.terminator,
                &func.computed_goto_targets,
                &func.jump_tables,
            )
        })
        .collect();
    let mut out = BTreeMap::new();
    'object: for &slot in objects.keys() {
        // Per block: a load ahead of any store, and a store.
        let (mut upward, mut defs) = (alloc::vec![false; nb], alloc::vec![false; nb]);
        for (b, blk) in func.blocks.iter().enumerate() {
            for pc in blk.inst_range.clone() {
                let Some((_, addr, value)) = access(&func.insts[pc as usize]) else {
                    continue;
                };
                if base.get(&addr) != Some(&slot) {
                    continue;
                }
                if idom[b] == BlockId::MAX {
                    continue 'object;
                }
                if value.is_some() {
                    defs[b] = true;
                } else if !defs[b] {
                    upward[b] = true;
                }
            }
        }
        let mut live_in = upward.clone();
        let mut changed = true;
        while changed {
            changed = false;
            for b in (0..nb).rev() {
                if live_in[b] || defs[b] {
                    continue;
                }
                if succs[b].iter().any(|&s| live_in[s as usize]) {
                    live_in[b] = true;
                    changed = true;
                }
            }
        }
        if live_in[0] {
            continue;
        }
        let mut work: Vec<BlockId> = (0..nb as BlockId).filter(|&b| defs[b as usize]).collect();
        let mut at: BTreeSet<BlockId> = BTreeSet::new();
        while let Some(b) = work.pop() {
            for &f in &df[b as usize] {
                if live_in[f as usize] && at.insert(f) {
                    work.push(f);
                }
            }
        }
        out.insert(slot, at);
    }
    out
}

/// Per base read of an object's slot, the slot.
fn bases(func: &FunctionSsa, objects: &BTreeMap<i64, LoadKind>) -> BTreeMap<ValueId, i64> {
    (func.insts.iter().enumerate())
        .filter_map(|(pc, inst)| match inst {
            Inst::LoadLocal { off, .. } if objects.contains_key(off) => Some((pc as ValueId, *off)),
            _ => None,
        })
        .collect()
}

/// Rewrite each load of an object to the definition reaching it, over the
/// dominator tree, and fill the phis; the accesses become dead `Imm`s.
fn rename(
    func: &mut FunctionSsa,
    objects: &BTreeMap<i64, LoadKind>,
    phi_at: &BTreeMap<(BlockId, i64), ValueId>,
    idom: &[BlockId],
) {
    let base = bases(func, objects);
    let nb = func.blocks.len();
    let mut children: Vec<Vec<BlockId>> = alloc::vec![Vec::new(); nb];
    for (b, &d) in idom.iter().enumerate() {
        if d != BlockId::MAX && d as usize != b {
            children[d as usize].push(b as BlockId);
        }
    }
    let mut redirect: BTreeMap<ValueId, ValueId> = BTreeMap::new();
    let mut dead: Vec<ValueId> = Vec::new();
    let mut incoming: Vec<(ValueId, BlockId, ValueId)> = Vec::new();
    enum Step {
        Visit(BlockId),
        Restore(BTreeMap<i64, ValueId>),
    }
    let mut current: BTreeMap<i64, ValueId> = BTreeMap::new();
    let mut stack = alloc::vec![Step::Visit(0)];
    while let Some(step) = stack.pop() {
        let b = match step {
            Step::Restore(saved) => {
                current = saved;
                continue;
            }
            Step::Visit(b) => b,
        };
        stack.push(Step::Restore(current.clone()));
        for (&(at, slot), &phi) in phi_at.range((b, i64::MIN)..=(b, i64::MAX)) {
            debug_assert_eq!(at, b);
            current.insert(slot, phi);
        }
        for pc in func.blocks[b as usize].inst_range.clone() {
            let Some((_, addr, value)) = access(&func.insts[pc as usize]) else {
                continue;
            };
            let Some(&slot) = base.get(&addr) else {
                continue;
            };
            match value {
                Some(v) => {
                    current.insert(slot, redirect.get(&v).copied().unwrap_or(v));
                }
                None => {
                    redirect.insert(pc, current[&slot]);
                }
            }
            dead.push(pc);
        }
        let term = &func.blocks[b as usize].terminator;
        for s in successors(term, &func.computed_goto_targets, &func.jump_tables) {
            for (&(_, slot), &phi) in phi_at.range((s, i64::MIN)..=(s, i64::MAX)) {
                incoming.push((phi, b, current[&slot]));
            }
        }
        stack.extend(children[b as usize].iter().map(|&c| Step::Visit(c)));
    }
    for (phi, pred, v) in incoming {
        if let Inst::Phi { incoming, .. } = &mut func.insts[phi as usize] {
            incoming.push((pred, v));
        }
    }
    let resolve = |v: &mut ValueId| {
        if let Some(&to) = redirect.get(v) {
            *v = to;
        }
    };
    for inst in func.insts.iter_mut() {
        inst.for_each_operand_mut(resolve);
    }
    for blk in func.blocks.iter_mut() {
        blk.terminator.for_each_operand_mut(resolve);
    }
    for pc in dead.into_iter().chain(base.into_keys()) {
        func.insts[pc as usize] = Inst::Imm(0);
    }
}

/// Drop the storage of the objects, now values: the base's stores, the
/// `Alloca`s, and a size nothing reads but a store to a slot nothing reads.
/// With no `Alloca` left, the arena's save, restore and setup go too.
fn release_storage(func: &mut FunctionSsa, objects: &BTreeMap<i64, LoadKind>) {
    let mut sizes: BTreeSet<ValueId> = BTreeSet::new();
    for pc in 0..func.insts.len() {
        let Inst::StoreLocal { off, value, .. } = func.insts[pc] else {
            continue;
        };
        if !objects.contains_key(&off) {
            continue;
        }
        if let Inst::Intrinsic { args, .. } = &func.insts[value as usize] {
            sizes.extend(args.first().copied());
        }
        func.insts[value as usize] = Inst::Imm(0);
        func.insts[pc] = Inst::Imm(0);
    }
    let (by, term) = readers(func);
    let read_slots: BTreeSet<i64> = (func.insts.iter())
        .filter_map(|inst| match inst {
            Inst::LoadLocal { off, .. } | Inst::LocalAddr(off) => Some(*off),
            _ => None,
        })
        .collect();
    for n in sizes {
        let unread = !term[n as usize]
            && by[n as usize].iter().all(|&r| {
                matches!(func.insts[r as usize], Inst::StoreLocal { off, .. } if !read_slots.contains(&off))
            });
        if unread {
            for &r in &by[n as usize] {
                func.insts[r as usize] = Inst::Imm(0);
            }
            func.insts[n as usize] = Inst::Imm(0);
        }
    }
    let arena = |i: &Inst| matches!(i, Inst::Intrinsic { kind, .. } if *kind == I::Alloca as i64);
    if func.insts.iter().any(arena) {
        return;
    }
    for inst in func.insts.iter_mut() {
        let bookkeeping = match inst {
            Inst::Intrinsic { kind, .. } => {
                *kind == I::AllocaSave as i64 || *kind == I::AllocaRestore as i64
            }
            Inst::AllocaInit(_) => true,
            _ => false,
        };
        if bookkeeping {
            *inst = Inst::Imm(0);
        }
    }
}

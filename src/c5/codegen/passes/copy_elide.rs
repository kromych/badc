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
//!
//! A call returning an aggregate through a hidden result pointer writes
//! the temporary its `ret_slot_local` names -- the AArch64 x8 return, or
//! the out-pointer the call passes first on System V and Win64 -- and
//! `s = f(...)` copies that into `s`; pointing the call at `s` builds the
//! result in place, as the return-slot rule of gcc and clang does. The
//! callee then writes `s` while it runs, so it must have no way to reach
//! `s`: no escaping use of `s`'s address may execute on a path to the
//! call, the call's own operands included. A local whose address first
//! escapes after the call qualifies; a destination reached through a
//! pointer never does, since the callee may hold another pointer to it.
//! The window rule applies from the call to the copy, and a function
//! calling a returns-twice function keeps its copies: a `longjmp` out of
//! the callee would leave `s` partly written, where the abstract machine
//! left it unchanged (C99 7.13.2.1p3). A read of the temporary past the
//! copy -- one of `s` an earlier pass forwarded -- reads `s` instead,
//! which holds the same bytes there when nothing else writes `s` and no
//! escape of `s` reaches the read. An out-pointer call carries no result
//! layout, so its copy must cover the temporary's whole cells, which a
//! copy of a leading member cannot.

use super::super::ir::{BinOp, BlockId, FunctionSsa, Inst, NO_VALUE, ValueId};
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
    // Calls pointed at their destination, and the destinations taken;
    // addresses of a temporary that name the destination in its place.
    let mut retargets: Vec<(usize, i64)> = Vec::new();
    let mut renamed: Vec<(usize, i64)> = Vec::new();
    let mut escapes = Escapes::new(f);
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
            let start = blk.inst_range.start as usize;
            let Some(plan) = plan_one(f, &named, &users, slot, start, i) else {
                if let Some((call, renames, reads)) =
                    call_writer(f, &named, &users, slot, start, i, size)
                    && let Some((d, 0)) = base_of(f, dst)
                    && !taken.contains(&d)
                    && !retargets.iter().any(|&(_, t)| t == slot)
                    && slot_stays_put(f, d)
                    && !escapes.reaches(f, d, call)
                    && (reads.is_empty() || sole_writer(f, d, i))
                    && reads.iter().all(|&at| !escapes.reaches(f, d, at))
                {
                    retargets.push((call, d));
                    renamed.extend(renames.iter().map(|&a| (a, d)));
                    elided.push((i, dst));
                    taken.insert(slot);
                }
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
    for (call, d) in retargets {
        match &mut f.insts[call] {
            Inst::Call { ret_slot_local, .. }
            | Inst::CallIndirect { ret_slot_local, .. }
            | Inst::CallExt { ret_slot_local, .. } => *ret_slot_local = d,
            _ => unreachable!("only a call is retargeted"),
        }
    }
    for (a, d) in renamed {
        f.insts[a] = Inst::LocalAddr(d);
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

/// The call that writes the temporary at `slot` whole through its
/// result pointer, when nothing else names the slot but addresses the
/// copy at `mcpy` and plain loads read, or that an out-pointer call
/// passes first, the call sits in the copy's block, and the window from
/// the call to the copy holds no memory access. With it, the addresses
/// to rename and the positions of the loads among their readers. `None`
/// for a function calling a returns-twice function.
#[allow(clippy::type_complexity)]
fn call_writer(
    f: &FunctionSsa,
    named: &BTreeMap<i64, Vec<usize>>,
    users: &[Vec<usize>],
    slot: i64,
    start: usize,
    mcpy: usize,
    size: i64,
) -> Option<(usize, Vec<usize>, Vec<usize>)> {
    if f.has_returns_twice_call {
        return None;
    }
    let mut call = None;
    for &a in named.get(&slot)? {
        let (ret_agg, args) = match f.insts.get(a)? {
            Inst::LocalAddr(_) => continue,
            Inst::Call {
                ret_agg,
                ret_slot_local,
                args,
                ..
            }
            | Inst::CallIndirect {
                ret_agg,
                ret_slot_local,
                args,
                ..
            }
            | Inst::CallExt {
                ret_agg,
                ret_slot_local,
                args,
                ..
            } if *ret_slot_local == slot && call.is_none() => (ret_agg, args),
            _ => return None,
        };
        let whole = match ret_agg {
            Some(ai) => f.agg_descs.get(*ai as usize)?.size as i64,
            None => {
                let &(_, cells) = f.multi_cell_slots.iter().find(|&&(b, _)| b == slot)?;
                cells * 8
            }
        };
        if whole != size {
            return None;
        }
        call = Some((
            a,
            ret_agg.is_none().then(|| args.first().copied()).flatten(),
        ));
    }
    let (call, out_arg) = call?;
    let mut renames: Vec<usize> = Vec::new();
    let mut reads: Vec<usize> = Vec::new();
    for &a in &named[&slot] {
        if !matches!(f.insts.get(a), Some(Inst::LocalAddr(_))) {
            continue;
        }
        let mut renamed = false;
        for &u in &users[a] {
            match f.insts.get(u) {
                _ if u == mcpy => {}
                Some(Inst::Load {
                    addr,
                    volatile: false,
                    ..
                }) if *addr == a as ValueId => {
                    reads.push(u);
                    renamed = true;
                }
                // The out-pointer, and in no other argument position.
                Some(Inst::Call { args, .. })
                | Some(Inst::CallIndirect { args, .. })
                | Some(Inst::CallExt { args, .. })
                    if u == call
                        && out_arg == Some(a as ValueId)
                        && args.iter().filter(|&&x| x == a as ValueId).count() == 1 =>
                {
                    renamed = true;
                }
                _ => return None,
            }
        }
        if renamed {
            renames.push(a);
        }
    }
    if out_arg.is_some_and(|o| !renames.contains(&(o as usize))) {
        return None;
    }
    if call < start || call >= mcpy || reads.iter().any(|&u| u > call && u < mcpy) {
        return None;
    }
    let quiet = ((call + 1)..mcpy).all(|i| {
        matches!(
            f.insts.get(i),
            Some(
                Inst::Imm(_)
                    | Inst::ImmData(_)
                    | Inst::ImmCode(_)
                    | Inst::ImmExtCode(_)
                    | Inst::BlockAddr(_)
                    | Inst::LocalAddr(_)
                    | Inst::Binop { .. }
                    | Inst::BinopI { .. }
                    | Inst::Neg(_)
                    | Inst::Extend { .. }
                    | Inst::Copy { .. }
                    | Inst::LifetimeEnd(_)
            )
        )
    });
    quiet.then_some((call, renames, reads))
}

/// Whether the copy at `mcpy` is the only instruction writing slot `d`:
/// no store, fill or copy through its addresses and no call result
/// lands there.
fn sole_writer(f: &FunctionSsa, d: i64, mcpy: usize) -> bool {
    let into = |v: ValueId| base_of(f, v).is_some_and(|(b, _)| b == d);
    f.insts.iter().enumerate().all(|(i, inst)| match inst {
        Inst::Store { addr, .. } | Inst::StoreIndexed { base: addr, .. } => !into(*addr),
        Inst::Mcpy { dst, .. } | Inst::Mzero { dst, .. } => i == mcpy || !into(*dst),
        Inst::StoreLocal { off, .. } => *off != d,
        Inst::Call { ret_slot_local, .. }
        | Inst::CallIndirect { ret_slot_local, .. }
        | Inst::CallExt { ret_slot_local, .. } => *ret_slot_local != d,
        _ => true,
    })
}

/// Whether slot `d` is ordinary frame storage a result pointer may name:
/// not a parameter's object or the indirect-result cell, which the
/// prologue fills, not over-aligned storage the emit places elsewhere,
/// and never accessed volatile.
fn slot_stays_put(f: &FunctionSsa, d: i64) -> bool {
    if d >= 0
        || d == f.indirect_result_slot
        || f.param_local_slots.contains(&d)
        || f.over_aligned.iter().any(|m| m.slot == d)
    {
        return false;
    }
    !f.insts.iter().any(|i| match i {
        Inst::LoadLocal { off, volatile, .. } | Inst::StoreLocal { off, volatile, .. } => {
            *off == d && *volatile
        }
        Inst::AllocaInit(off) => *off == d,
        Inst::Load {
            addr,
            volatile: true,
            ..
        }
        | Inst::Store {
            addr,
            volatile: true,
            ..
        } => base_of(f, *addr).is_some_and(|(b, _)| b == d),
        _ => false,
    })
}

/// Where the address of a frame slot escapes: a use of a value naming the
/// slot other than as the address of an access or a copy, or as the base
/// of an address formed from it. Computed per slot on demand.
struct Escapes {
    block_of: Vec<BlockId>,
    succ: crate::c5::codegen::ssa::mem2reg::SuccGraph,
    done: BTreeMap<i64, Escape>,
}

/// One slot's escapes: the positions in each block, and the blocks some
/// path from an escape enters.
struct Escape {
    at: BTreeMap<BlockId, Vec<usize>>,
    entered: Vec<bool>,
}

impl Escapes {
    fn new(f: &FunctionSsa) -> Self {
        let mut block_of = alloc::vec![BlockId::MAX; f.insts.len()];
        for (b, blk) in f.blocks.iter().enumerate() {
            for v in blk.inst_range.clone() {
                block_of[v as usize] = b as BlockId;
            }
        }
        Self {
            block_of,
            succ: crate::c5::codegen::ssa::mem2reg::SuccGraph::new(f),
            done: BTreeMap::new(),
        }
    }

    /// Whether an escape of slot `d` can execute before the instruction
    /// at `at`: earlier in its block, the instruction itself, or in a
    /// block from which a path enters `at`'s block.
    fn reaches(&mut self, f: &FunctionSsa, d: i64, at: usize) -> bool {
        if !self.done.contains_key(&d) {
            let e = self.scan(f, d);
            self.done.insert(d, e);
        }
        let e = &self.done[&d];
        let b = self.block_of[at];
        e.entered[b as usize] || e.at.get(&b).is_some_and(|pos| pos.iter().any(|&u| u <= at))
    }

    fn scan(&self, f: &FunctionSsa, d: i64) -> Escape {
        let n = f.insts.len();
        // Values naming the slot: its base and the constant offsets off it.
        let mut names = alloc::vec![false; n];
        let mut changed = true;
        while changed {
            changed = false;
            for (v, inst) in f.insts.iter().enumerate() {
                let is = match inst {
                    Inst::LocalAddr(off) => *off == d,
                    Inst::BinopI {
                        op: BinOp::Add | BinOp::Sub,
                        lhs,
                        ..
                    } => names.get(*lhs as usize).copied().unwrap_or(false),
                    _ => false,
                };
                if is && !names[v] {
                    names[v] = true;
                    changed = true;
                }
            }
        }
        let named = |v: ValueId| v != NO_VALUE && names.get(v as usize).copied().unwrap_or(false);
        let mut at: BTreeMap<BlockId, Vec<usize>> = BTreeMap::new();
        for (u, inst) in f.insts.iter().enumerate() {
            let b = self.block_of[u];
            if b == BlockId::MAX {
                continue;
            }
            let escapes = match inst {
                Inst::Load { .. } | Inst::LoadIndexed { .. } | Inst::BinopI { .. } => false,
                Inst::Store { value, .. } => named(*value),
                Inst::StoreIndexed { index, value, .. } => named(*index) || named(*value),
                Inst::Mcpy { .. } | Inst::Mzero { .. } => false,
                _ => {
                    let mut any = false;
                    inst.for_each_operand(|o| any |= named(o));
                    any
                }
            };
            if escapes {
                at.entry(b).or_default().push(u);
            }
        }
        for (b, blk) in f.blocks.iter().enumerate() {
            let mut any = false;
            blk.terminator.for_each_operand(|o| any |= named(o));
            if any {
                at.entry(b as BlockId)
                    .or_default()
                    .push(blk.inst_range.end as usize);
            }
        }
        // Blocks entered by a path from an escape, over one edge or more.
        let mut entered = alloc::vec![false; f.blocks.len()];
        let mut work: Vec<BlockId> = at.keys().copied().collect();
        while let Some(b) = work.pop() {
            for &s in self.succ.of(b) {
                if !entered[s as usize] {
                    entered[s as usize] = true;
                    work.push(s);
                }
            }
        }
        Escape { at, entered }
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
                | Inst::Udiv128 { .. }
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

    /// The walker's SSA of `name` in `src` for AArch64, where a 32-byte
    /// result takes the x8 pointer the call's `ret_slot_local` names.
    fn walked(src: &str, name: &str) -> FunctionSsa {
        let target = crate::Target::LinuxAarch64;
        let program = crate::Compiler::with_target(
            alloc::format!("{src} int main(void){{ return 0; }}"),
            target,
        )
        .compile()
        .expect("compile");
        crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false, true)
            .expect("ssa")
            .into_iter()
            .find(|f| f.name == name)
            .expect("the function")
    }

    /// Per call returning an aggregate, in tape order: whether it now
    /// writes the slot its copy used to fill.
    fn in_place(src: &str, name: &str) -> Vec<bool> {
        let mut f = walked(src, name);
        let mut dests: Vec<(usize, i64)> = Vec::new();
        for (i, inst) in f.insts.iter().enumerate() {
            let Inst::Call {
                ret_agg: Some(_),
                ret_slot_local,
                ..
            } = inst
            else {
                continue;
            };
            let dst = f.insts.iter().find_map(|m| match m {
                Inst::Mcpy { dst, src, .. } if base_of(&f, *src) == Some((*ret_slot_local, 0)) => {
                    base_of(&f, *dst).map(|(d, _)| d)
                }
                _ => None,
            });
            dests.push((i, dst.unwrap_or(0)));
        }
        run_one(&mut f);
        dests
            .into_iter()
            .map(|(i, d)| matches!(f.insts[i], Inst::Call { ret_slot_local, .. } if ret_slot_local == d))
            .collect()
    }

    const DECLS: &str = "struct S { long a, b, c, d; };\n\
        struct S make(long);\n\
        struct S take(struct S *);\n\
        long use(struct S *);\n\
        struct S *gp;\n";

    /// A fresh object and a local whose address escapes only after the
    /// call take the result pointer; an escape the call can see -- a
    /// global holding the address, the call's own argument, the address
    /// published around a loop -- keeps the temporary.
    #[test]
    fn a_result_pointer_names_a_destination_the_callee_cannot_reach() {
        let case = |body: &str, name: &str| in_place(&alloc::format!("{DECLS}{body}"), name);
        assert_eq!(
            case(
                "long f(void) { struct S s = make(1); return use(&s); }",
                "f"
            ),
            [true]
        );
        assert_eq!(
            case(
                "long f(void) { struct S s; s = make(1); return use(&s); }",
                "f"
            ),
            [true]
        );
        assert_eq!(
            case(
                "long f(void) { struct S s = make(1); gp = &s; s = make(2); return s.a; }",
                "f"
            ),
            [true, false]
        );
        assert_eq!(
            case(
                "long f(void) { struct S s = make(1); s = take(&s); return s.a; }",
                "f"
            ),
            [true, false]
        );
        assert_eq!(
            case(
                "long f(int n) { struct S s = make(0); long t = 0;\n\
                 while (n--) { s = make(n); t += use(&s); } return t; }",
                "f"
            ),
            [true, false]
        );
    }

    /// A function calling a returns-twice function keeps its copies: a
    /// `longjmp` out of the callee would leave the destination partly
    /// written.
    #[test]
    fn a_returns_twice_caller_keeps_the_temporary() {
        let src = alloc::format!(
            "{DECLS}int setjmp(long *); long buf[32];\n\
             long f(void) {{ struct S s; if (setjmp(buf)) return 0; s = make(1); return use(&s); }}"
        );
        assert_eq!(in_place(&src, "f"), [false]);
    }
}

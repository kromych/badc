//! Promotion of address-free local slots to SSA values (mem2reg).
//!
//! Runs under `-O` ahead of the register allocator. A local whose
//! address is never taken is accessed only through `LoadLocal` /
//! `StoreLocal` against a fixed frame slot; its value can live in a
//! register across the whole function instead of being spilled to
//! and reloaded from the frame. Promotion rewrites those loads and
//! stores into direct value references, inserting phi joins where
//! control flow merges two distinct definitions.
//!
//! This module currently provides the analysis prerequisites for the
//! transform: which slots may be promoted, and the control-flow
//! predecessor map phi placement needs.

// The phi-placement and rename passes that consume these analyses
// land in a follow-up; keep the building blocks compiling until then.
#![allow(dead_code)]

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use super::super::ir::{
    BinOp, BlockId, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId,
};

/// Frame slots eligible for register promotion: those accessed only
/// via `LoadLocal` / `StoreLocal` and never via `LocalAddr`. A slot
/// whose address is taken may be read or written through that pointer
/// (including by a callee), so its definition point is not visible in
/// the SSA and it must stay resident in the frame.
pub(crate) fn promotable_slots(func: &FunctionSsa) -> BTreeSet<i64> {
    let mut touched: BTreeSet<i64> = BTreeSet::new();
    let mut address_taken: BTreeSet<i64> = BTreeSet::new();
    for inst in &func.insts {
        match inst {
            Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => {
                touched.insert(*off);
            }
            // A taken address escapes the slot's value to memory and
            // cannot be lifted into a register.
            Inst::LocalAddr(off) => {
                address_taken.insert(*off);
            }
            // A non-zero alloca top names a frame-resident arena the
            // per-arch emit reads directly; `AllocaInit(0)` is the
            // unconditional no-alloca marker and aliases nothing.
            Inst::AllocaInit(off) if *off != 0 => {
                address_taken.insert(*off);
            }
            _ => {}
        }
    }
    touched.retain(|slot| !address_taken.contains(slot));
    touched
}

/// Successor block ids of a terminator, in branch order.
pub(crate) fn successors(term: &Terminator) -> Vec<BlockId> {
    match term {
        Terminator::Jmp(b) | Terminator::FallThrough(b) => alloc::vec![*b],
        Terminator::Bz {
            target,
            fall_through,
            ..
        }
        | Terminator::Bnz {
            target,
            fall_through,
            ..
        } => alloc::vec![*target, *fall_through],
        Terminator::Return(_) | Terminator::TailExt(_) => Vec::new(),
    }
}

/// Predecessor block ids for every block, indexed by `BlockId`.
/// Built by inverting each block's terminator successors.
pub(crate) fn predecessors(func: &FunctionSsa) -> Vec<Vec<BlockId>> {
    let mut preds: Vec<Vec<BlockId>> = alloc::vec![Vec::new(); func.blocks.len()];
    for (idx, block) in func.blocks.iter().enumerate() {
        for succ in successors(&block.terminator) {
            preds[succ as usize].push(idx as BlockId);
        }
    }
    preds
}

/// Sentinel for an undefined / unreachable immediate dominator.
const NO_BLOCK: BlockId = BlockId::MAX;

/// Depth-first postorder of the blocks reachable from the entry
/// (block 0). Blocks unreachable from the entry do not appear.
fn postorder(func: &FunctionSsa) -> Vec<BlockId> {
    let n = func.blocks.len();
    let mut order: Vec<BlockId> = Vec::with_capacity(n);
    let mut visited = alloc::vec![false; n];
    // Iterative DFS: stack holds (block, next-successor-index) so a
    // block is appended to the postorder only after all successors.
    let mut stack: Vec<(BlockId, usize)> = Vec::new();
    if n == 0 {
        return order;
    }
    visited[0] = true;
    stack.push((0, 0));
    while let Some(&(b, si)) = stack.last() {
        let succ = successors(&func.blocks[b as usize].terminator);
        if si < succ.len() {
            stack.last_mut().unwrap().1 += 1;
            let s = succ[si];
            if !visited[s as usize] {
                visited[s as usize] = true;
                stack.push((s, 0));
            }
        } else {
            order.push(b);
            stack.pop();
        }
    }
    order
}

/// Immediate dominator of every block, indexed by `BlockId`
/// (Cooper-Harvey-Kennedy iterative dominators, which handle
/// irreducible control flow from `goto`). `idom[entry] == entry`;
/// blocks unreachable from the entry get [`NO_BLOCK`].
pub(crate) fn dominators(func: &FunctionSsa) -> Vec<BlockId> {
    let n = func.blocks.len();
    let mut idom = alloc::vec![NO_BLOCK; n];
    if n == 0 {
        return idom;
    }
    let po = postorder(func);
    // Postorder number per block; entry has the highest number.
    let mut po_num = alloc::vec![usize::MAX; n];
    for (i, &b) in po.iter().enumerate() {
        po_num[b as usize] = i;
    }
    let preds = predecessors(func);
    idom[0] = 0;
    // Reverse postorder, entry first.
    let rpo: Vec<BlockId> = po.iter().rev().copied().collect();
    let mut changed = true;
    while changed {
        changed = false;
        for &b in &rpo {
            if b == 0 || po_num[b as usize] == usize::MAX {
                continue;
            }
            let mut new_idom = NO_BLOCK;
            for &p in &preds[b as usize] {
                if idom[p as usize] == NO_BLOCK {
                    continue;
                }
                new_idom = if new_idom == NO_BLOCK {
                    p
                } else {
                    intersect(p, new_idom, &idom, &po_num)
                };
            }
            if new_idom != NO_BLOCK && idom[b as usize] != new_idom {
                idom[b as usize] = new_idom;
                changed = true;
            }
        }
    }
    idom
}

/// Walk two finger pointers up the partial dominator tree until they
/// meet, the block with the smaller postorder number climbing first.
fn intersect(mut b1: BlockId, mut b2: BlockId, idom: &[BlockId], po_num: &[usize]) -> BlockId {
    while b1 != b2 {
        while po_num[b1 as usize] < po_num[b2 as usize] {
            b1 = idom[b1 as usize];
        }
        while po_num[b2 as usize] < po_num[b1 as usize] {
            b2 = idom[b2 as usize];
        }
    }
    b1
}

/// Dominance frontier of every block (Cytron et al.): the set of
/// blocks where a definition in this block stops dominating, i.e.
/// the phi-placement candidates. Indexed by `BlockId`.
pub(crate) fn dominance_frontiers(func: &FunctionSsa, idom: &[BlockId]) -> Vec<BTreeSet<BlockId>> {
    let n = func.blocks.len();
    let preds = predecessors(func);
    let mut df: Vec<BTreeSet<BlockId>> = alloc::vec![BTreeSet::new(); n];
    for b in 0..n {
        if preds[b].len() < 2 || idom[b] == NO_BLOCK {
            continue;
        }
        for &p in &preds[b] {
            if idom[p as usize] == NO_BLOCK {
                continue;
            }
            let mut runner = p;
            while runner != idom[b] {
                df[runner as usize].insert(b as BlockId);
                runner = idom[runner as usize];
            }
        }
    }
    df
}

/// Blocks where each promotable slot needs a phi: the iterated
/// dominance frontier of the slot's definition blocks (every block
/// holding a `StoreLocal` to it). Standard worklist closure -- a
/// freshly placed phi is itself a definition, so its block re-enters
/// the frontier walk.
pub(crate) fn phi_placement(
    func: &FunctionSsa,
    promotable: &BTreeSet<i64>,
    df: &[BTreeSet<BlockId>],
) -> alloc::collections::BTreeMap<i64, BTreeSet<BlockId>> {
    use alloc::collections::BTreeMap;
    // Definition blocks per slot.
    let mut def_blocks: BTreeMap<i64, BTreeSet<BlockId>> = BTreeMap::new();
    for (b, block) in func.blocks.iter().enumerate() {
        for inst in &func.insts[block.inst_range.start as usize..block.inst_range.end as usize] {
            if let Inst::StoreLocal { off, .. } = inst
                && promotable.contains(off)
            {
                def_blocks.entry(*off).or_default().insert(b as BlockId);
            }
        }
    }
    let mut result: BTreeMap<i64, BTreeSet<BlockId>> = BTreeMap::new();
    for (slot, defs) in &def_blocks {
        let mut worklist: Vec<BlockId> = defs.iter().copied().collect();
        let mut phis: BTreeSet<BlockId> = BTreeSet::new();
        while let Some(b) = worklist.pop() {
            for &frontier in &df[b as usize] {
                if phis.insert(frontier) {
                    worklist.push(frontier);
                }
            }
        }
        if !phis.is_empty() {
            result.insert(*slot, phis);
        }
    }
    result
}

/// Apply `f` to every value-id operand of an instruction. Exhaustive
/// over `Inst`: a missed operand would leave a stale reference to a
/// promoted load after the rewrite below.
fn for_each_operand_mut(inst: &mut Inst, mut f: impl FnMut(&mut ValueId)) {
    match inst {
        Inst::Imm(_)
        | Inst::ImmData(_)
        | Inst::ImmCode(_)
        | Inst::LocalAddr(_)
        | Inst::TlsAddr(_)
        | Inst::LoadLocal { .. }
        | Inst::TailExt(_)
        | Inst::AllocaInit(_) => {}
        Inst::Load { addr, .. } => f(addr),
        Inst::Store { addr, value, .. } => {
            f(addr);
            f(value);
        }
        Inst::StoreLocal { value, .. } => f(value),
        Inst::LoadIndexed { base, index, .. } => {
            f(base);
            f(index);
        }
        Inst::StoreIndexed {
            base, index, value, ..
        } => {
            f(base);
            f(index);
            f(value);
        }
        Inst::Binop { lhs, rhs, .. } => {
            f(lhs);
            f(rhs);
        }
        Inst::BinopI { lhs, .. } => f(lhs),
        Inst::Fneg(v) => f(v),
        Inst::Extend { value, .. } => f(value),
        Inst::FpCast { value, .. } => f(value),
        Inst::Call { args, .. } | Inst::CallExt { args, .. } | Inst::Intrinsic { args, .. } => {
            for a in args {
                f(a);
            }
        }
        Inst::CallIndirect { target, args } => {
            f(target);
            for a in args {
                f(a);
            }
        }
        Inst::Mcpy { dst, src, .. } => {
            f(dst);
            f(src);
        }
    }
}

/// True when every `LoadLocal` / `StoreLocal` against `slot` uses the
/// full 8-byte width. Sub-width slots carry truncation / extension
/// semantics that promoting to a plain value reference would drop, so
/// they stay in memory until the rename models the width.
/// Only full-width slots are promoted. A narrowing store leaves the
/// frame slot holding the truncated value while the source register
/// keeps its full width; the matching load re-extends from the slot
/// (C99 6.5.16.1p2 conversion is realized by the StoreLocal /
/// LoadLocal width pair, not by the stored register). Redirecting the
/// load to the stored value would skip that truncate-then-extend, so
/// sub-width slots stay in memory until the rewrite can materialize
/// the extension at each use.
fn slot_is_full_width(func: &FunctionSsa, slot: i64) -> bool {
    for inst in &func.insts {
        match inst {
            Inst::LoadLocal { off, kind } if *off == slot && *kind != LoadKind::I64 => {
                return false;
            }
            Inst::StoreLocal { off, kind, .. } if *off == slot && *kind != StoreKind::I64 => {
                return false;
            }
            _ => {}
        }
    }
    true
}

/// For a slot read only through one narrow `LoadKind` and written
/// only at the matching width, that load kind. A narrowing store
/// keeps the low `w` bytes; the load re-extends them per signedness
/// (C99 6.3.1.3). Each load is then replaced by an extension of the
/// reaching value -- a mask for an unsigned kind, an `Inst::Extend`
/// for a signed one -- which reproduces the frame round-trip
/// regardless of the stored register's high bits. A mixed-width,
/// `F32`, or full-width access returns `None`.
fn slot_narrow_load_kind(func: &FunctionSsa, slot: i64) -> Option<LoadKind> {
    let mut load_kind: Option<LoadKind> = None;
    let mut store_kind: Option<StoreKind> = None;
    for inst in &func.insts {
        match inst {
            Inst::LoadLocal { off, kind } if *off == slot => match load_kind {
                None => load_kind = Some(*kind),
                Some(k) if k == *kind => {}
                Some(_) => return None,
            },
            Inst::StoreLocal { off, kind, .. } if *off == slot => match store_kind {
                None => store_kind = Some(*kind),
                Some(k) if k == *kind => {}
                Some(_) => return None,
            },
            _ => {}
        }
    }
    let lk = load_kind?;
    let (lw, sw) = (load_byte_width(lk)?, store_byte_width(store_kind?)?);
    if lw == sw && lw < 8 { Some(lk) } else { None }
}

fn load_byte_width(kind: LoadKind) -> Option<u8> {
    match kind {
        LoadKind::I8 | LoadKind::U8 => Some(1),
        LoadKind::I16 | LoadKind::U16 => Some(2),
        LoadKind::I32 | LoadKind::U32 => Some(4),
        LoadKind::I64 => Some(8),
        LoadKind::F32 => None,
    }
}

fn store_byte_width(kind: StoreKind) -> Option<u8> {
    match kind {
        StoreKind::I8 => Some(1),
        StoreKind::I16 => Some(2),
        StoreKind::I32 => Some(4),
        StoreKind::I64 => Some(8),
        StoreKind::F32 => None,
    }
}

/// The replacement instruction for a promoted narrow load: a mask of
/// the reaching value for an unsigned kind, a sign-extension for a
/// signed one.
fn narrow_load_replacement(kind: LoadKind, value: ValueId) -> Inst {
    match kind {
        LoadKind::U8 => Inst::BinopI {
            op: BinOp::And,
            lhs: value,
            rhs_imm: 0xff,
        },
        LoadKind::U16 => Inst::BinopI {
            op: BinOp::And,
            lhs: value,
            rhs_imm: 0xffff,
        },
        LoadKind::U32 => Inst::BinopI {
            op: BinOp::And,
            lhs: value,
            rhs_imm: 0xffff_ffff,
        },
        LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => Inst::Extend { value, kind },
        LoadKind::I64 | LoadKind::F32 => unreachable!("not a narrow load kind"),
    }
}

/// A slot whose value lives in the integer register file at every
/// definition. An `I64` slot load is integer-classed, so its
/// consumers read an integer register; promoting a slot whose store
/// value is FP-classed (a `double` produced by an FP op, stored via
/// the `StoreLocal { kind: I64 }` bit-pattern path) would redirect
/// those consumers to an FP register and cross the register files.
fn slot_stores_only_int(func: &FunctionSsa, slot: i64) -> bool {
    for inst in &func.insts {
        if let Inst::StoreLocal { off, value, .. } = inst
            && *off == slot
            && super::ssa_alloc::produces_fp_result(&func.insts[*value as usize])
        {
            return false;
        }
    }
    true
}

/// Promote address-free, full-width local slots that need no phi to
/// direct value references, dropping their frame loads and stores.
/// Slots that merge two definitions (non-empty phi placement) stay in
/// memory until phi insertion lands.
///
/// The rewrite keeps every `ValueId` stable: a promoted `LoadLocal`
/// has its uses redirected to the reaching definition (it then has no
/// consumers and the emit drops it as dead-pure), and a promoted
/// `StoreLocal` is replaced with `Imm(0)` after its id -- which the c5
/// semantics treat as the stored value -- is redirected to that value.
pub(crate) fn run(func: &mut FunctionSsa) {
    // Opt out of promotion for A/B measurement against the unpromoted
    // frame-slot codegen.
    #[cfg(feature = "std")]
    if std::env::var("BADC_NO_MEM2REG").is_ok() {
        return;
    }
    // A function with a non-zero alloca top grows its frame at
    // runtime and reaches it through a computed pointer, so no slot is
    // promoted there; `AllocaInit(0)` is the unconditional no-alloca
    // marker and is ignored. Taken addresses of individual locals are
    // handled per slot in `promotable_slots`: `LoadLocal` /
    // `StoreLocal` name only scalar locals (aggregate fields are
    // reached through `LocalAddr(base)` plus an offset, never a
    // load-local), so a candidate slot is aliased only when its own
    // address is taken, which that pass already excludes.
    if func.insts.iter().any(|i| match i {
        Inst::AllocaInit(s) => *s != 0,
        _ => false,
    }) {
        return;
    }
    let promotable = promotable_slots(func);
    if promotable.is_empty() {
        return;
    }
    let idom = dominators(func);
    let df = dominance_frontiers(func, &idom);
    let phi_blocks = phi_placement(func, &promotable, &df);
    // Slots read at one narrow width promote by extending the reaching
    // value at each load; full-width I64 slots redirect the load to
    // the value directly.
    let mut narrow_load: alloc::collections::BTreeMap<i64, LoadKind> =
        alloc::collections::BTreeMap::new();
    let slots: BTreeSet<i64> = promotable
        .into_iter()
        .filter(|s| !phi_blocks.contains_key(s))
        .filter(|s| slot_stores_only_int(func, *s))
        .filter(|s| {
            if slot_is_full_width(func, *s) {
                return true;
            }
            if let Some(kind) = slot_narrow_load_kind(func, *s) {
                narrow_load.insert(*s, kind);
                return true;
            }
            false
        })
        .collect();
    if slots.is_empty() {
        return;
    }
    #[cfg(feature = "std")]
    if std::env::var("BADC_DUMP_MEM2REG").is_ok() {
        eprintln!(
            "mem2reg: fn {} ent_pc={} promoting slots {:?}",
            func.name, func.ent_pc, slots
        );
    }

    // Dominator-tree children, from idom.
    let n = func.blocks.len();
    let mut children: Vec<Vec<BlockId>> = alloc::vec![Vec::new(); n];
    for (b, &id) in idom.iter().enumerate() {
        if id != NO_BLOCK && id as usize != b {
            children[id as usize].push(b as BlockId);
        }
    }

    // Reaching-definition rename over the dom tree. `redirect[id]`
    // maps a promoted load / store id to the value that replaces it.
    // A slot whose load is reached by no definition (read before
    // write) is recorded in `failed` and left entirely in memory.
    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; func.insts.len()];
    let mut store_ids: Vec<u32> = Vec::new();
    let mut failed: BTreeSet<i64> = BTreeSet::new();
    let mut load_slot: alloc::collections::BTreeMap<u32, i64> = alloc::collections::BTreeMap::new();
    let mut store_slot: alloc::collections::BTreeMap<u32, i64> =
        alloc::collections::BTreeMap::new();

    enum Frame {
        Visit(BlockId),
        Restore(Vec<(i64, Option<ValueId>)>),
    }
    let mut current: alloc::collections::BTreeMap<i64, ValueId> =
        alloc::collections::BTreeMap::new();
    let mut stack: Vec<Frame> = alloc::vec![Frame::Visit(0)];
    while let Some(frame) = stack.pop() {
        match frame {
            Frame::Restore(saved) => {
                for (slot, old) in saved {
                    match old {
                        Some(v) => {
                            current.insert(slot, v);
                        }
                        None => {
                            current.remove(&slot);
                        }
                    }
                }
            }
            Frame::Visit(b) => {
                let range = func.blocks[b as usize].inst_range.clone();
                let mut saved: Vec<(i64, Option<ValueId>)> = Vec::new();
                for id in range.start..range.end {
                    match &func.insts[id as usize] {
                        Inst::StoreLocal { off, value, .. } if slots.contains(off) => {
                            saved.push((*off, current.get(off).copied()));
                            current.insert(*off, *value);
                            redirect[id as usize] = Some(*value);
                            store_ids.push(id);
                            store_slot.insert(id, *off);
                        }
                        Inst::LoadLocal { off, .. } if slots.contains(off) => {
                            match current.get(off).copied() {
                                Some(r) => {
                                    redirect[id as usize] = Some(r);
                                    load_slot.insert(id, *off);
                                }
                                None => {
                                    failed.insert(*off);
                                }
                            }
                        }
                        _ => {}
                    }
                }
                stack.push(Frame::Restore(saved));
                for &c in children[b as usize].iter().rev() {
                    stack.push(Frame::Visit(c));
                }
            }
        }
    }

    // Drop every record for a slot that could not be fully promoted
    // (a load reached by no definition): leave its loads and stores in
    // memory untouched.
    if !failed.is_empty() {
        for (id, slot) in load_slot.iter().chain(store_slot.iter()) {
            if failed.contains(slot) {
                redirect[*id as usize] = None;
            }
        }
        store_ids.retain(|id| !failed.contains(&store_slot[id]));
    }
    if redirect.iter().all(|r| r.is_none()) {
        return;
    }

    // Narrow loads keep their own id but become an extension of the
    // reaching value, so their consumers read the same low bytes the
    // frame round-trip produced (masked for an unsigned kind,
    // sign-extended for a signed one). The store value keeps its full
    // width for the assignment expression. The value operand is left
    // unresolved here; the operand rewrite below threads it through
    // the redirect chain.
    if !narrow_load.is_empty() {
        for (&load_id, &slot) in &load_slot {
            if let Some(&kind) = narrow_load.get(&slot)
                && let Some(v) = redirect[load_id as usize]
            {
                func.insts[load_id as usize] = narrow_load_replacement(kind, v);
                redirect[load_id as usize] = None;
            }
        }
    }

    // Resolve a value through the redirect chain to a stable id.
    fn resolve(redirect: &[Option<ValueId>], mut v: ValueId) -> ValueId {
        let mut guard = 0;
        while v != NO_VALUE {
            match redirect[v as usize] {
                Some(t) if t != v => {
                    v = t;
                    guard += 1;
                    if guard > redirect.len() {
                        break;
                    }
                }
                _ => break,
            }
        }
        v
    }

    // Rewrite every operand, terminator value, and block accumulator.
    for inst in func.insts.iter_mut() {
        for_each_operand_mut(inst, |op| *op = resolve(&redirect, *op));
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            block.exit_acc = resolve(&redirect, block.exit_acc);
        }
        match &mut block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                *cond = resolve(&redirect, *cond);
            }
            Terminator::Return(v) => {
                if *v != NO_VALUE {
                    *v = resolve(&redirect, *v);
                }
            }
            Terminator::Jmp(_) | Terminator::FallThrough(_) | Terminator::TailExt(_) => {}
        }
    }
    // Neutralize promoted stores: their id has been redirected to the
    // stored value, and their memory write is no longer wanted.
    for &id in &store_ids {
        func.insts[id as usize] = Inst::Imm(0);
    }
    // Promoted loads now have no consumers; the emit's dead-pure check
    // drops them. Leaving the LoadLocal in place keeps every later id
    // stable.
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{Block, Inst, LoadKind, NO_VALUE, StoreKind, Terminator};
    use super::*;

    fn empty_block(term: Terminator) -> Block {
        Block {
            start_pc: 0,
            inst_range: 0..0,
            terminator: term,
            exit_acc: NO_VALUE,
        }
    }

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            n_params: 0,
            is_variadic: false,
            inst_src: alloc::vec![(0, 0); insts.len()],
            insts,
            blocks,
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    #[test]
    fn address_taken_slot_is_not_promotable() {
        // Slot -1 is loaded and stored; slot -2 has its address
        // taken. Only -1 is promotable.
        let insts = alloc::vec![
            Inst::Imm(1),
            Inst::StoreLocal {
                off: -1,
                value: 0,
                kind: StoreKind::I64,
            },
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::I64,
            },
            Inst::LocalAddr(-2),
            Inst::StoreLocal {
                off: -2,
                value: 0,
                kind: StoreKind::I64,
            },
        ];
        let blocks = alloc::vec![empty_block(Terminator::Return(NO_VALUE))];
        let f = func_with(insts, blocks);
        let p = promotable_slots(&f);
        assert!(p.contains(&-1), "address-free slot -1 should be promotable");
        assert!(
            !p.contains(&-2),
            "address-taken slot -2 must not be promotable"
        );
    }

    #[test]
    fn dominance_of_a_diamond() {
        // 0 -> {1, 2} -> 3. Both arms join at 3.
        let blocks = alloc::vec![
            empty_block(Terminator::Bz {
                cond: NO_VALUE,
                target: 1,
                fall_through: 2,
            }),
            empty_block(Terminator::Jmp(3)),
            empty_block(Terminator::Jmp(3)),
            empty_block(Terminator::Return(NO_VALUE)),
        ];
        let f = func_with(Vec::new(), blocks);
        let idom = dominators(&f);
        // Every block is dominated directly by the entry.
        assert_eq!(idom, alloc::vec![0, 0, 0, 0]);
        let df = dominance_frontiers(&f, &idom);
        assert_eq!(df[0], BTreeSet::new());
        assert_eq!(df[1], BTreeSet::from([3]));
        assert_eq!(df[2], BTreeSet::from([3]));
        assert_eq!(df[3], BTreeSet::new());
    }

    #[test]
    fn dominance_of_a_loop() {
        // 0 -> 1(header); 1 -> {3(exit), 2(body)}; 2 -> 1(back edge).
        let blocks = alloc::vec![
            empty_block(Terminator::Jmp(1)),
            empty_block(Terminator::Bz {
                cond: NO_VALUE,
                target: 3,
                fall_through: 2,
            }),
            empty_block(Terminator::Jmp(1)),
            empty_block(Terminator::Return(NO_VALUE)),
        ];
        let f = func_with(Vec::new(), blocks);
        let idom = dominators(&f);
        assert_eq!(idom[0], 0);
        assert_eq!(idom[1], 0, "loop header dominated by entry, not body");
        assert_eq!(idom[2], 1);
        assert_eq!(idom[3], 1);
        let df = dominance_frontiers(&f, &idom);
        // The back edge puts the header in the body's (and its own)
        // dominance frontier.
        assert!(df[2].contains(&1), "back edge -> header in body DF");
        assert!(df[1].contains(&1), "loop header is in its own DF");
    }

    #[test]
    fn run_promotes_dominating_store_to_cross_block_load() {
        // Block 0: x = 5 (slot -1), jmp 1. Block 1: return x.
        // The store dominates the load with no merge, so x promotes:
        // the store becomes Imm(0) (neutralized) and the return reads
        // the stored value directly.
        let insts = alloc::vec![
            Inst::Imm(5),
            Inst::StoreLocal {
                off: -1,
                value: 0,
                kind: StoreKind::I64,
            },
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::I64,
            },
        ];
        let blocks = alloc::vec![
            Block {
                start_pc: 0,
                inst_range: 0..2,
                terminator: Terminator::Jmp(1),
                exit_acc: 1,
            },
            Block {
                start_pc: 0,
                inst_range: 2..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            },
        ];
        let mut f = func_with(insts, blocks);
        run(&mut f);
        // The store is neutralized to a dead Imm.
        assert!(matches!(f.insts[1], Inst::Imm(0)));
        // The return now reads the stored value (id 0), not the load.
        assert!(matches!(f.blocks[1].terminator, Terminator::Return(0)));
        assert_eq!(f.blocks[1].exit_acc, 0);
    }

    #[test]
    fn run_leaves_address_taken_slot_in_memory() {
        // Slot -1 has its address taken; run must not touch its load.
        let insts = alloc::vec![
            Inst::Imm(5),
            Inst::StoreLocal {
                off: -1,
                value: 0,
                kind: StoreKind::I64,
            },
            Inst::LocalAddr(-1),
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::I64,
            },
        ];
        let blocks = alloc::vec![Block {
            start_pc: 0,
            inst_range: 0..4,
            terminator: Terminator::Return(3),
            exit_acc: 3,
        }];
        let mut f = func_with(insts, blocks);
        run(&mut f);
        assert!(
            matches!(f.insts[1], Inst::StoreLocal { .. }),
            "address-taken slot's store must remain"
        );
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(3)));
    }

    #[test]
    fn run_sign_extends_signed_narrow_load() {
        // A signed char (I8) slot promotes: the load becomes an
        // `Extend` of the reaching value, reproducing the sign
        // extension a frame load performs. The store is neutralized.
        let insts = alloc::vec![
            Inst::Imm(300),
            Inst::StoreLocal {
                off: -1,
                value: 0,
                kind: StoreKind::I8,
            },
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::I8,
            },
        ];
        let blocks = alloc::vec![Block {
            start_pc: 0,
            inst_range: 0..3,
            terminator: Terminator::Return(2),
            exit_acc: 2,
        }];
        let mut f = func_with(insts, blocks);
        run(&mut f);
        assert!(
            matches!(
                f.insts[2],
                Inst::Extend {
                    value: 0,
                    kind: LoadKind::I8,
                }
            ),
            "load should become Extend, got {:?}",
            f.insts[2]
        );
        assert!(matches!(f.insts[1], Inst::Imm(0)), "store neutralized");
    }

    #[test]
    fn run_masks_unsigned_narrow_load() {
        // An unsigned char (U8) slot promotes: the load becomes a mask
        // of the reaching store value, reproducing the zero-extension
        // a frame load would perform. The store is neutralized.
        let insts = alloc::vec![
            Inst::Imm(300),
            Inst::StoreLocal {
                off: -1,
                value: 0,
                kind: StoreKind::I8,
            },
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::U8,
            },
        ];
        let blocks = alloc::vec![Block {
            start_pc: 0,
            inst_range: 0..3,
            terminator: Terminator::Return(2),
            exit_acc: 2,
        }];
        let mut f = func_with(insts, blocks);
        run(&mut f);
        assert!(
            matches!(
                f.insts[2],
                Inst::BinopI {
                    op: BinOp::And,
                    lhs: 0,
                    rhs_imm: 0xff,
                }
            ),
            "load should become `value & 0xff`, got {:?}",
            f.insts[2]
        );
        assert!(matches!(f.insts[1], Inst::Imm(0)), "store neutralized");
    }

    #[test]
    fn phi_placement_at_diamond_join() {
        // Slot -1 assigned in both arms of a diamond; the join (3)
        // needs a phi.
        let insts = alloc::vec![
            Inst::Imm(0), // block 0 cond
            Inst::Imm(1), // block 1
            Inst::StoreLocal {
                off: -1,
                value: 1,
                kind: StoreKind::I64,
            },
            Inst::Imm(2), // block 2
            Inst::StoreLocal {
                off: -1,
                value: 3,
                kind: StoreKind::I64,
            },
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::I64,
            }, // block 3
        ];
        let blocks = alloc::vec![
            Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Bz {
                    cond: 0,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 0,
            },
            Block {
                start_pc: 0,
                inst_range: 1..3,
                terminator: Terminator::Jmp(3),
                exit_acc: NO_VALUE,
            },
            Block {
                start_pc: 0,
                inst_range: 3..5,
                terminator: Terminator::Jmp(3),
                exit_acc: NO_VALUE,
            },
            Block {
                start_pc: 0,
                inst_range: 5..6,
                terminator: Terminator::Return(5),
                exit_acc: 5,
            },
        ];
        let f = func_with(insts, blocks);
        let promotable = promotable_slots(&f);
        assert!(promotable.contains(&-1));
        let idom = dominators(&f);
        let df = dominance_frontiers(&f, &idom);
        let phis = phi_placement(&f, &promotable, &df);
        assert_eq!(phis.get(&-1), Some(&BTreeSet::from([3])));
    }

    #[test]
    fn predecessors_invert_terminator_successors() {
        // Block 0 conditionally branches to 1 (target) / 2
        // (fall-through); both jump to 3.
        let blocks = alloc::vec![
            empty_block(Terminator::Bz {
                cond: NO_VALUE,
                target: 1,
                fall_through: 2,
            }),
            empty_block(Terminator::Jmp(3)),
            empty_block(Terminator::Jmp(3)),
            empty_block(Terminator::Return(NO_VALUE)),
        ];
        let f = func_with(Vec::new(), blocks);
        let preds = predecessors(&f);
        assert_eq!(preds[0], Vec::<BlockId>::new());
        assert_eq!(preds[1], alloc::vec![0]);
        assert_eq!(preds[2], alloc::vec![0]);
        assert_eq!(preds[3], alloc::vec![1, 2]);
    }
}

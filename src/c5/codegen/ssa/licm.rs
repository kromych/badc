//! Hoisting loop-invariant materializations out of loop bodies.
//!
//! An operand-free instruction -- a file-scope object's address, a
//! function address, a TLS base, a wide integer constant -- yields a
//! link-time or compile-time constant, so a copy of it inside a loop
//! recomputes the same value every iteration. This pass places one copy
//! in a block outside the loop that dominates the body and points the
//! body's uses at it. No memory analysis is involved: the instructions
//! have no operands and read no memory, so invariance is a property of
//! the opcode rather than of the loop.
//!
//! A `BinopI` whose immediate the target builds into a register at the
//! site (an AArch64 reciprocal-multiply constant, an x86-64 immediate
//! wider than imm32) is the same materialization with the operand
//! folded in. Such a site is rewritten to the register form of the
//! binop over a hoisted `Inst::Imm`, which puts it on the path above --
//! one mechanism covers both shapes.
//!
//! Destination: the immediate dominator of the header of the outermost
//! loop containing the site, taken repeatedly until the destination
//! itself is in no loop. That block dominates the header, the header
//! dominates every block of a natural loop, and dominance is
//! transitive, so it dominates every site and every predecessor an
//! edge use of a site sits on. After `passes::split_crit_edges` a
//! single-entry loop's header has a dedicated predecessor, which is
//! what the immediate dominator resolves to.
//!
//! Placement is measured, not assumed: a hoist lengthens a live range
//! across the whole loop, so the function is allocated a second time
//! and the plan is kept only when the loop-weighted spill traffic plus
//! the prologue's save / restore pairs does not grow. A hoist that
//! takes a register the loop needed shows up there as extra traffic,
//! and one that buys its register out of the callee-saved bank as an
//! extra save; either restores the tape, so the pass cannot leave a
//! function worse than the un-hoisted baseline. The number of values
//! hoisted into one destination is also capped against the register
//! file, so one loop cannot force the whole plan out.

use alloc::vec;
use alloc::vec::Vec;
use hashbrown::HashMap;

use super::super::ir::{BinOp, Block, BlockId, FunctionSsa, Inst, NO_VALUE, ValueId};
use super::Target;
use super::mem2reg::{dominators, predecessors};
use super::reg_alloc::Allocation;
use crate::c5::codegen::passes::layout::{natural_loops, rpo_numbers};

const NO_BLOCK: BlockId = BlockId::MAX;
/// `extern_*_refs` sentinel for an instruction with no bound symbol.
const NO_SYM: u32 = u32::MAX;

/// Identity of a materialization: two sites with the same key produce
/// the same value, so one hoisted copy serves both. The extern-symbol
/// binding is part of the key -- an `ImmData` bound to a cross-TU
/// symbol names that symbol's address, not a writer-layout offset.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, PartialOrd, Ord)]
enum Key {
    Imm(i64),
    Data(i64, u32),
    Code(usize, u32),
    ExtCode(i64),
    Tls(i64, u32),
}

impl Key {
    fn inst(self) -> Inst {
        match self {
            Key::Imm(k) => Inst::Imm(k),
            Key::Data(k, _) => Inst::ImmData(k),
            Key::Code(t, _) => Inst::ImmCode(t),
            Key::ExtCode(b) => Inst::ImmExtCode(b),
            Key::Tls(o, _) => Inst::TlsAddr(o),
        }
    }

    /// Bound symbol and the `FunctionSsa` table it rides, so the copy
    /// inherits the site's binding.
    fn binding(self) -> (u32, SymTable) {
        match self {
            Key::Data(_, s) => (s, SymTable::Data),
            Key::Code(_, s) => (s, SymTable::Code),
            Key::Tls(_, s) => (s, SymTable::Tls),
            _ => (NO_SYM, SymTable::None),
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum SymTable {
    None,
    Data,
    Code,
    Tls,
}

/// One materialization placed outside a loop, with the sites it serves.
struct Hoist {
    key: Key,
    /// Tape index the copy goes ahead of; inside the destination block.
    at: ValueId,
    /// Loop-weighted instruction count the sites stop paying.
    profit: u64,
    /// Materializations whose uses move to the copy. Each is left in
    /// place with no reader, where the emit's dead-pure skip drops it.
    redirect: Vec<ValueId>,
    /// `BinopI` sites rewritten to the register form over the copy.
    unfold: Vec<ValueId>,
}

/// Instruction tape and the tables parallel to it, as they were before
/// [`apply`].
struct Undo {
    insts: Vec<Inst>,
    inst_src: Vec<(u32, u32)>,
    f32_values: Vec<bool>,
    blocks: Vec<Block>,
    extern_call_refs: Vec<(u32, u32)>,
    extern_imm_code_refs: Vec<(u32, u32)>,
    extern_imm_data_refs: Vec<(u32, u32)>,
    extern_tls_refs: Vec<(u32, u32)>,
}

impl Undo {
    fn restore(self, func: &mut FunctionSsa) {
        func.insts = self.insts;
        func.inst_src = self.inst_src;
        func.f32_values = self.f32_values;
        func.blocks = self.blocks;
        func.extern_call_refs = self.extern_call_refs;
        func.extern_imm_code_refs = self.extern_imm_code_refs;
        func.extern_imm_data_refs = self.extern_imm_data_refs;
        func.extern_tls_refs = self.extern_tls_refs;
    }
}

/// Native instructions the target spends materializing `k`.
fn imm_cost(target: Target, k: i64) -> u32 {
    if target.is_aarch64() {
        crate::c5::codegen::aarch64::encode::imm64_insts(k as u64)
    } else {
        1
    }
}

/// Native instructions the target spends materializing an address that
/// a relocation supplies: an `adrp` + `add` pair on AArch64, one
/// RIP-relative `lea` on x86-64.
fn addr_cost(target: Target) -> u32 {
    if target.is_aarch64() { 2 } else { 1 }
}

/// Whether the target builds a `BinopI` immediate into a register at
/// the site rather than into the instruction's own immediate field.
/// The copy a hoist places is an integer `Inst::Imm`, so a float op --
/// which has no immediate form to unfold on either target -- is not one.
fn binop_imm_materializes(target: Target, op: BinOp, imm: i64) -> bool {
    if matches!(
        op,
        BinOp::Fadd
            | BinOp::Fsub
            | BinOp::Fmul
            | BinOp::Fdiv
            | BinOp::Feq
            | BinOp::Fne
            | BinOp::Flt
            | BinOp::Fgt
            | BinOp::Fle
            | BinOp::Fge
    ) {
        return false;
    }
    if target.is_aarch64() {
        crate::c5::codegen::aarch64::emit::binop_imm_materializes(op, imm)
    } else {
        crate::c5::codegen::x86_64::emit::binop_imm_materializes(op, imm)
    }
}

/// Where a copy goes inside `b`: as late as the block allows, so the
/// hoisted value's range covers no more of the destination than it has
/// to. That is ahead of the last instruction, or ahead of the compare a
/// conditional terminator reads -- the emit may fuse that compare into
/// the branch, which no unrelated instruction may come between. `None`
/// when the position that leaves is a phi or a `ParamRef`, neither of
/// which a copy may precede: a phi belongs to the block's leading run,
/// and a `ParamRef` reads an incoming argument register live until it.
fn insert_point(func: &FunctionSsa, b: BlockId) -> Option<ValueId> {
    let range = func.blocks[b as usize].inst_range.clone();
    if range.is_empty() {
        return None;
    }
    let mut at = range.end - 1;
    let mut cond = NO_VALUE;
    func.blocks[b as usize]
        .terminator
        .for_each_operand(|v| cond = v);
    if range.contains(&cond) {
        at = at.min(cond);
    }
    let blocked = (at..range.end).any(|i| {
        matches!(
            func.insts[i as usize],
            Inst::Phi { .. } | Inst::ParamRef { .. }
        )
    });
    if blocked { None } else { Some(at) }
}

/// Destination block per block: where a materialization in it hoists
/// to, or [`NO_BLOCK`] when it is in no loop or no destination exists.
fn destinations(func: &FunctionSsa) -> Vec<BlockId> {
    let n = func.blocks.len();
    let mut dest = vec![NO_BLOCK; n];
    if n < 2 || !func.computed_goto_targets.is_empty() {
        return dest;
    }
    let idom = dominators(func);
    let preds = predecessors(func);
    let rpo = rpo_numbers(func);
    let loops = natural_loops(func, &idom, &preds, &rpo);
    if loops.is_empty() {
        return dest;
    }
    // Outermost loop containing each block. Two natural loops are
    // disjoint or nested once loops sharing a header are merged, so the
    // largest body containing a block is the outermost one.
    let mut outer = vec![usize::MAX; n];
    for (li, l) in loops.iter().enumerate() {
        for &b in &l.body {
            let cur = outer[b as usize];
            if cur == usize::MAX || loops[cur].body.len() < l.body.len() {
                outer[b as usize] = li;
            }
        }
    }
    for (b, slot) in dest.iter_mut().enumerate() {
        let mut t = b as BlockId;
        for _ in 0..=n {
            let li = outer[t as usize];
            if li == usize::MAX {
                break;
            }
            let up = idom[loops[li].header as usize];
            if up == NO_BLOCK || up == loops[li].header {
                break;
            }
            t = up;
        }
        *slot = if t == b as BlockId { NO_BLOCK } else { t };
    }
    dest
}

/// Symbol bound to each instruction in one of the extern-ref tables.
fn sym_of(refs: &[(u32, u32)]) -> HashMap<u32, u32> {
    refs.iter().copied().collect()
}

/// Materializations worth hoisting, one entry per destination and key.
fn plan(func: &FunctionSsa, target: Target) -> Vec<Hoist> {
    // A longjmp restores the callee-saved registers and the stack
    // pointer only, so a value the allocator leaves in a caller-saved
    // register does not survive the second return from a setjmp
    // (C99 7.13.2.1p3 requires an unchanged automatic object to). The
    // allocator does not model that edge, so a range this pass would
    // lengthen across one stays where the walker put it.
    if func.has_returns_twice_call {
        return Vec::new();
    }
    let dest = destinations(func);
    if dest.iter().all(|&d| d == NO_BLOCK) {
        return Vec::new();
    }
    let weights = super::reg_alloc::block_weights(func);
    let uses = super::reg_alloc::compute_use_counts(func);
    let data_sym = sym_of(&func.extern_imm_data_refs);
    let code_sym = sym_of(&func.extern_imm_code_refs);
    let tls_sym = sym_of(&func.extern_tls_refs);
    let mut at_of: Vec<Option<ValueId>> = vec![None; func.blocks.len()];
    let mut out: Vec<Hoist> = Vec::new();
    let mut slot_of: HashMap<(BlockId, Key), usize> = HashMap::new();
    for (b, block) in func.blocks.iter().enumerate() {
        let to = dest[b];
        if to == NO_BLOCK {
            continue;
        }
        let at = match at_of[to as usize] {
            Some(at) => Some(at),
            None => {
                let p = insert_point(func, to);
                at_of[to as usize] = p;
                p
            }
        };
        let Some(at) = at else { continue };
        let wb = weights[b];
        for v in block.inst_range.clone() {
            if uses.get(v as usize).copied().unwrap_or(0) == 0 {
                continue;
            }
            let sym = |m: &HashMap<u32, u32>| m.get(&v).copied().unwrap_or(NO_SYM);
            let (key, cost, unfold) = match func.insts[v as usize] {
                Inst::ImmData(k) => (Key::Data(k, sym(&data_sym)), addr_cost(target), false),
                Inst::ImmCode(t) => (Key::Code(t, sym(&code_sym)), addr_cost(target), false),
                Inst::ImmExtCode(import) => (Key::ExtCode(import), addr_cost(target), false),
                Inst::TlsAddr(o) => (Key::Tls(o, sym(&tls_sym)), addr_cost(target), false),
                // A one-instruction constant costs no more at the site
                // than the register it would occupy across the loop.
                Inst::Imm(k) if imm_cost(target, k) > 1 => {
                    (Key::Imm(k), imm_cost(target, k), false)
                }
                Inst::BinopI { op, rhs_imm, .. } if binop_imm_materializes(target, op, rhs_imm) => {
                    (Key::Imm(rhs_imm), imm_cost(target, rhs_imm), true)
                }
                _ => continue,
            };
            let slot = *slot_of.entry((to, key)).or_insert_with(|| {
                out.push(Hoist {
                    key,
                    at,
                    profit: 0,
                    redirect: Vec::new(),
                    unfold: Vec::new(),
                });
                out.len() - 1
            });
            out[slot].profit = out[slot]
                .profit
                .saturating_add(wb.saturating_mul(cost as u64));
            if unfold {
                out[slot].unfold.push(v);
            } else {
                out[slot].redirect.push(v);
            }
        }
    }
    cap_per_destination(func, target, out)
}

/// Keep the most profitable hoists per destination, bounded by a share
/// of the register file. Every hoist adds a value live across the whole
/// loop; past that bound the allocation retry would reject the plan
/// wholesale and the profitable entries would go with it.
fn cap_per_destination(func: &FunctionSsa, target: Target, mut hoists: Vec<Hoist>) -> Vec<Hoist> {
    let cap = (super::reg_alloc::usable_gpr_count(target) / 2).max(1);
    // Destination block per hoist, read back off the insertion point.
    let mut block_of = vec![NO_BLOCK; func.insts.len()];
    for (b, block) in func.blocks.iter().enumerate() {
        for v in block.inst_range.clone() {
            block_of[v as usize] = b as BlockId;
        }
    }
    hoists.sort_by(|a, b| {
        b.profit
            .cmp(&a.profit)
            .then((a.at, a.key).cmp(&(b.at, b.key)))
    });
    let mut taken: HashMap<BlockId, usize> = HashMap::new();
    hoists.retain(|h| {
        let slot = taken.entry(block_of[h.at as usize]).or_insert(0);
        if *slot >= cap {
            return false;
        }
        *slot += 1;
        true
    });
    hoists.sort_by_key(|h| (h.at, h.key));
    hoists
}

/// Place each hoist's copy and point its sites at it. Rewrites the
/// instruction tape, the parallel per-value tables, every block range
/// and every value reference through one old-to-new id map, as
/// [`super::split_ranges`] does for its copies.
fn apply(func: &mut FunctionSsa, hoists: &[Hoist]) -> Undo {
    let n_old = func.insts.len();
    let mut undo = Undo {
        insts: Vec::new(),
        inst_src: Vec::new(),
        f32_values: Vec::new(),
        blocks: func.blocks.clone(),
        extern_call_refs: func.extern_call_refs.clone(),
        extern_imm_code_refs: func.extern_imm_code_refs.clone(),
        extern_imm_data_refs: func.extern_imm_data_refs.clone(),
        extern_tls_refs: func.extern_tls_refs.clone(),
    };
    // Copies inserted strictly before their index, so a block's new
    // bounds follow from its old ones. Index `n_old` closes the last
    // block's range.
    let mut before: Vec<u32> = vec![0; n_old + 1];
    for h in hoists {
        before[h.at as usize + 1] += 1;
    }
    for old in 0..n_old {
        before[old + 1] += before[old];
    }
    let extra = hoists.len();
    let mut insts: Vec<Inst> = Vec::with_capacity(n_old + extra);
    let mut inst_src: Vec<(u32, u32)> = Vec::with_capacity(n_old + extra);
    let mut f32_values: Vec<bool> = Vec::with_capacity(n_old + extra);
    let mut remap: Vec<ValueId> = vec![NO_VALUE; n_old];
    let mut copy_id: Vec<ValueId> = vec![NO_VALUE; hoists.len()];
    let mut cur = 0usize;
    for (old, slot) in remap.iter_mut().enumerate() {
        while cur < hoists.len() && hoists[cur].at as usize == old {
            copy_id[cur] = insts.len() as ValueId;
            insts.push(hoists[cur].key.inst());
            inst_src.push(func.inst_src.get(old).copied().unwrap_or((0, 0)));
            f32_values.push(false);
            cur += 1;
        }
        *slot = insts.len() as ValueId;
        insts.push(func.insts[old].clone());
        inst_src.push(func.inst_src.get(old).copied().unwrap_or((0, 0)));
        f32_values.push(func.f32_values.get(old).copied().unwrap_or(false));
    }
    for block in func.blocks.iter_mut() {
        let (s, e) = (block.inst_range.start, block.inst_range.end);
        block.inst_range = (s + before[s as usize])..(e + before[e as usize]);
    }
    let map = |op: &mut ValueId| {
        if *op != NO_VALUE && (*op as usize) < n_old {
            *op = remap[*op as usize];
        }
    };
    for inst in insts.iter_mut() {
        inst.for_each_operand_mut(map);
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE && (block.exit_acc as usize) < n_old {
            block.exit_acc = remap[block.exit_acc as usize];
        }
        block.terminator.for_each_operand_mut(map);
    }
    for table in [
        &mut func.extern_call_refs,
        &mut func.extern_imm_code_refs,
        &mut func.extern_imm_data_refs,
        &mut func.extern_tls_refs,
    ] {
        for (v, _) in table.iter_mut() {
            map(v);
        }
    }
    // The copy inherits the site's binding: a bound `ImmData` /
    // `ImmCode` / `TlsAddr` names a cross-TU symbol's address, which
    // only the table records.
    for (k, h) in hoists.iter().enumerate() {
        let (sym, table) = h.key.binding();
        if sym == NO_SYM {
            continue;
        }
        match table {
            SymTable::Data => func.extern_imm_data_refs.push((copy_id[k], sym)),
            SymTable::Code => func.extern_imm_code_refs.push((copy_id[k], sym)),
            SymTable::Tls => func.extern_tls_refs.push((copy_id[k], sym)),
            SymTable::None => {}
        }
    }
    for table in [
        &mut func.extern_imm_code_refs,
        &mut func.extern_imm_data_refs,
        &mut func.extern_tls_refs,
    ] {
        table.sort_unstable();
    }
    // Rewrite each folded-immediate site to the register form over the
    // copy, reading the already-remapped lhs back off the tape.
    for (k, h) in hoists.iter().enumerate() {
        for &site in &h.unfold {
            let at = remap[site as usize] as usize;
            if let Inst::BinopI { op, lhs, .. } = insts[at] {
                insts[at] = Inst::Binop {
                    op,
                    lhs,
                    rhs: copy_id[k],
                };
            }
        }
    }
    // Point every reader of a hoisted site at the copy. A site's uses
    // are dominated by its definition, which the destination dominates,
    // so each rewritten use -- including a phi operand, which is a use
    // on the predecessor edge -- stays dominated by the copy.
    let mut redirect: Vec<ValueId> = vec![NO_VALUE; insts.len()];
    for (k, h) in hoists.iter().enumerate() {
        for &site in &h.redirect {
            redirect[remap[site as usize] as usize] = copy_id[k];
        }
    }
    let redirect_of = |op: &mut ValueId| {
        if *op != NO_VALUE && (*op as usize) < redirect.len() && redirect[*op as usize] != NO_VALUE
        {
            *op = redirect[*op as usize];
        }
    };
    for inst in insts.iter_mut() {
        inst.for_each_operand_mut(redirect_of);
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            redirect_of(&mut block.exit_acc);
        }
        block.terminator.for_each_operand_mut(redirect_of);
    }
    undo.insts = core::mem::replace(&mut func.insts, insts);
    undo.inst_src = core::mem::replace(&mut func.inst_src, inst_src);
    undo.f32_values = core::mem::replace(&mut func.f32_values, f32_values);
    undo
}

/// Loop-weighted spill traffic plus the prologue's save / restore pairs.
/// The traffic metric charges only what a block executes, so it cannot
/// see a hoist that buys its register out of the callee-saved bank --
/// paid once per call of the function, and invisible to a loop whose
/// body the hoist did shorten. `Allocation::gpr_used` / `fp_used` are
/// exactly what the prologue saves.
fn placement_cost(func: &FunctionSsa, alloc: &Allocation) -> u64 {
    let saved = (alloc.gpr_used.len() + alloc.fp_used.len()) as u64;
    super::split_ranges::spill_traffic(func, alloc).saturating_add(2 * saved)
}

/// Allocate `func`, then retry with its loop-invariant materializations
/// hoisted out of the loops that hold them. Returns whichever
/// allocation carries the lower [`placement_cost`], leaving `func`
/// matching the returned allocation, and finishes through the
/// live-range split so both retries share one baseline allocation.
pub(crate) fn allocate_hoisted(func: &mut FunctionSsa, target: Target) -> Allocation {
    let hoists = plan(func, target);
    if hoists.is_empty() {
        return super::split_ranges::allocate_split(func, target);
    }
    let base = super::reg_alloc::allocate(func, target);
    let base_cost = placement_cost(func, &base);
    let undo = apply(func, &hoists);
    let alt = super::reg_alloc::allocate(func, target);
    // A hoist removes work from the loop unconditionally; the only way
    // it can lose is by taking a register the function had another use
    // for, which shows up here as extra traffic or an extra save.
    let kept = placement_cost(func, &alt) <= base_cost;
    let picked = if kept {
        alt
    } else {
        undo.restore(func);
        base
    };
    super::split_ranges::allocate_split_with(func, target, picked)
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{LoadKind, StoreKind, Terminator};
    use super::*;

    /// Tape index of the first body instruction in [`loop_func`].
    const BODY: u32 = 4;
    /// Insertion point [`insert_point`] picks in the default preheader.
    const PRE_AT: ValueId = 2;

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            inst_src: vec![(0, 0); n],
            f32_values: vec![false; n],
            insts,
            blocks,
            ..Default::default()
        }
    }

    fn block(range: core::ops::Range<u32>, terminator: Terminator) -> Block {
        Block {
            start_pc: 0,
            inst_range: range,
            terminator,
            exit_acc: NO_VALUE,
        }
    }

    fn local(off: i64) -> Inst {
        Inst::LoadLocal {
            off,
            kind: LoadKind::I64,
            volatile: false,
        }
    }

    fn load(addr: ValueId) -> Inst {
        Inst::Load {
            addr,
            disp: 0,
            kind: LoadKind::I64,
            volatile: false,
            align: 0,
        }
    }

    /// A store keeps a body value read, so nothing under test is dead.
    fn sink(value: ValueId) -> Inst {
        Inst::StoreLocal {
            off: -1,
            value,
            kind: StoreKind::I64,
            volatile: false,
        }
    }

    /// `pre -> header -> body -> header`. Block 0 is the preheader and
    /// the only block outside the loop; the body starts at [`BODY`].
    fn loop_func_pre(pre: Vec<Inst>, body: Vec<Inst>) -> FunctionSsa {
        let head = pre.len() as u32;
        let mut insts = pre;
        insts.push(Inst::BinopI {
            op: BinOp::Lt,
            lhs: 0,
            rhs_imm: 7,
        });
        let body_start = insts.len() as u32;
        insts.extend(body);
        let body_end = insts.len() as u32;
        func_with(
            insts,
            vec![
                block(0..head, Terminator::Jmp(1)),
                block(
                    head..body_start,
                    Terminator::Bz {
                        cond: head,
                        target: 2,
                        fall_through: 2,
                    },
                ),
                block(body_start..body_end, Terminator::Jmp(1)),
            ],
        )
    }

    fn loop_func(body: Vec<Inst>) -> FunctionSsa {
        loop_func_pre(vec![local(2), local(3), local(4)], body)
    }

    #[test]
    fn invariant_global_address_hoists_to_the_preheader() {
        let mut f = loop_func(vec![Inst::ImmData(0x38), load(BODY), sink(BODY + 1)]);
        let hoists = plan(&f, Target::LinuxAarch64);
        assert_eq!(hoists.len(), 1);
        assert_eq!(hoists[0].key, Key::Data(0x38, NO_SYM));
        assert_eq!(hoists[0].redirect, vec![BODY]);
        assert_eq!(hoists[0].at, PRE_AT);
        apply(&mut f, &hoists);
        let copy = f.blocks[0]
            .inst_range
            .clone()
            .find(|&v| matches!(f.insts[v as usize], Inst::ImmData(0x38)))
            .expect("copy in the preheader");
        let loaded = f.blocks[2]
            .inst_range
            .clone()
            .find(|&v| matches!(f.insts[v as usize], Inst::Load { .. }))
            .expect("load in the body");
        assert!(matches!(f.insts[loaded as usize], Inst::Load { addr, .. } if addr == copy));
    }

    #[test]
    fn a_loop_varying_address_is_not_hoisted() {
        // `base + i` rebuilt from a loop-carried value: an operand makes
        // the address vary, so no part of it is invariant by opcode.
        let mut f = loop_func(vec![
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
            load(BODY),
            sink(BODY + 1),
        ]);
        let hoists = plan(&f, Target::LinuxAarch64);
        assert!(hoists.is_empty());
        let before = f.insts.len();
        apply(&mut f, &hoists);
        assert_eq!(f.insts.len(), before);
    }

    #[test]
    fn a_volatile_access_is_left_alone() {
        // The address feeding a volatile access is invariant and hoists;
        // the access itself is neither moved nor duplicated, so it is
        // still performed exactly once per iteration (C99 6.7.3p6).
        let mut f = loop_func(vec![
            Inst::ImmData(0x40),
            Inst::Load {
                addr: BODY,
                disp: 0,
                kind: LoadKind::I64,
                volatile: true,
                align: 0,
            },
            sink(BODY + 1),
        ]);
        let hoists = plan(&f, Target::LinuxAarch64);
        assert_eq!(hoists.len(), 1);
        apply(&mut f, &hoists);
        let volatile_loads = f
            .blocks
            .iter()
            .flat_map(|b| b.inst_range.clone())
            .filter(|&v| matches!(f.insts[v as usize], Inst::Load { volatile: true, .. }))
            .count();
        assert_eq!(volatile_loads, 1);
        let pre = f.blocks[0].inst_range.clone();
        assert!(f.blocks[2].inst_range.clone().any(|v| matches!(
            f.insts[v as usize],
            Inst::Load { volatile: true, addr, .. } if pre.contains(&addr)
        )));
    }

    #[test]
    fn two_sites_of_one_address_share_a_copy() {
        let mut f = loop_func(vec![
            Inst::ImmData(0x10),
            load(BODY),
            Inst::ImmData(0x10),
            load(BODY + 2),
            Inst::Binop {
                op: BinOp::Add,
                lhs: BODY + 1,
                rhs: BODY + 3,
            },
            sink(BODY + 4),
        ]);
        let hoists = plan(&f, Target::LinuxAarch64);
        assert_eq!(hoists.len(), 1);
        assert_eq!(hoists[0].redirect, vec![BODY, BODY + 2]);
        apply(&mut f, &hoists);
        let body = f.blocks[2].inst_range.clone();
        let from_preheader = body
            .clone()
            .filter(
                |&v| matches!(f.insts[v as usize], Inst::Load { addr, .. } if addr < body.start),
            )
            .count();
        assert_eq!(from_preheader, 2);
    }

    #[test]
    fn a_wide_constant_hoists_and_a_narrow_one_does_not() {
        let wide = loop_func(vec![Inst::Imm(0x6666_6667), sink(BODY)]);
        assert_eq!(plan(&wide, Target::LinuxAarch64).len(), 1);
        // One movz builds it, so a register held across the loop buys
        // nothing.
        let narrow = loop_func(vec![Inst::Imm(10), sink(BODY)]);
        assert!(plan(&narrow, Target::LinuxAarch64).is_empty());
        // x86-64 builds either in one instruction.
        assert!(plan(&wide, Target::LinuxX64).is_empty());
    }

    #[test]
    fn a_folded_immediate_the_target_materializes_unfolds_over_a_copy() {
        let body = vec![
            Inst::BinopI {
                op: BinOp::Mul,
                lhs: 0,
                rhs_imm: 0x6666_6667,
            },
            sink(BODY),
        ];
        let mut f = loop_func(body.clone());
        let hoists = plan(&f, Target::LinuxAarch64);
        assert_eq!(hoists.len(), 1);
        assert_eq!(hoists[0].key, Key::Imm(0x6666_6667));
        assert_eq!(hoists[0].unfold, vec![BODY]);
        apply(&mut f, &hoists);
        let copy = f.blocks[0]
            .inst_range
            .clone()
            .find(|&v| matches!(f.insts[v as usize], Inst::Imm(0x6666_6667)))
            .expect("copy in the preheader");
        assert!(f.blocks[2].inst_range.clone().any(|v| matches!(
            f.insts[v as usize],
            Inst::Binop { op: BinOp::Mul, rhs, .. } if rhs == copy
        )));
        // x86-64 encodes the same multiply as `imul r, r, imm32`.
        assert!(plan(&loop_func(body), Target::LinuxX64).is_empty());
    }

    #[test]
    fn a_multiply_by_a_small_constant_unfolds_only_where_it_costs() {
        // AArch64 `mul` has no immediate form, so any non-power-of-two
        // multiplier is built into a register at the site.
        let f = loop_func(vec![
            Inst::BinopI {
                op: BinOp::Mul,
                lhs: 0,
                rhs_imm: 10,
            },
            sink(BODY),
        ]);
        assert_eq!(plan(&f, Target::LinuxAarch64).len(), 1);
        assert!(plan(&f, Target::LinuxX64).is_empty());
        // A power of two is a shift on both.
        let shifted = loop_func(vec![
            Inst::BinopI {
                op: BinOp::Mul,
                lhs: 0,
                rhs_imm: 8,
            },
            sink(BODY),
        ]);
        assert!(plan(&shifted, Target::LinuxAarch64).is_empty());
        assert!(plan(&shifted, Target::LinuxX64).is_empty());
    }

    #[test]
    fn a_shift_count_stays_folded() {
        // `x >> 34` rides the instruction's own immediate field on both
        // targets, so the site builds nothing.
        let f = loop_func(vec![
            Inst::BinopI {
                op: BinOp::Shr,
                lhs: 0,
                rhs_imm: 34,
            },
            sink(BODY),
        ]);
        assert!(plan(&f, Target::LinuxAarch64).is_empty());
        assert!(plan(&f, Target::LinuxX64).is_empty());
    }

    #[test]
    fn a_materialization_outside_every_loop_stays_put() {
        let f = loop_func_pre(
            vec![local(2), local(3), Inst::ImmData(0x8)],
            vec![load(2), sink(BODY)],
        );
        assert!(plan(&f, Target::LinuxAarch64).is_empty());
    }

    #[test]
    fn the_dead_original_keeps_no_reader() {
        let mut f = loop_func(vec![Inst::ImmData(0x20), load(BODY), sink(BODY + 1)]);
        let hoists = plan(&f, Target::LinuxAarch64);
        apply(&mut f, &hoists);
        let uses = super::super::reg_alloc::compute_use_counts(&f);
        let site = f.blocks[2]
            .inst_range
            .clone()
            .find(|&v| matches!(f.insts[v as usize], Inst::ImmData(0x20)))
            .expect("the original stays on the tape");
        assert_eq!(uses[site as usize], 0);
    }

    #[test]
    fn a_rejected_plan_restores_the_tape() {
        let mut f = loop_func(vec![Inst::ImmData(0x20), load(BODY), sink(BODY + 1)]);
        let before = f.clone();
        let hoists = plan(&f, Target::LinuxAarch64);
        let undo = apply(&mut f, &hoists);
        assert_ne!(f.insts.len(), before.insts.len());
        undo.restore(&mut f);
        assert_eq!(f.insts.len(), before.insts.len());
        assert_eq!(f.blocks[2].inst_range, before.blocks[2].inst_range);
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(1)));
    }

    #[test]
    fn a_bound_symbol_rides_the_copy() {
        let mut f = loop_func(vec![Inst::ImmData(0), load(BODY), sink(BODY + 1)]);
        f.extern_imm_data_refs.push((BODY, 9));
        let hoists = plan(&f, Target::LinuxAarch64);
        assert_eq!(hoists.len(), 1);
        assert_eq!(hoists[0].key, Key::Data(0, 9));
        apply(&mut f, &hoists);
        let copy = f.blocks[0]
            .inst_range
            .clone()
            .find(|&v| matches!(f.insts[v as usize], Inst::ImmData(0)))
            .expect("copy in the preheader");
        assert!(f.extern_imm_data_refs.contains(&(copy, 9)));
    }

    #[test]
    fn two_symbols_at_one_offset_stay_apart() {
        let mut f = loop_func(vec![
            Inst::ImmData(0),
            load(BODY),
            Inst::ImmData(0),
            load(BODY + 2),
            Inst::Binop {
                op: BinOp::Add,
                lhs: BODY + 1,
                rhs: BODY + 3,
            },
            sink(BODY + 4),
        ]);
        f.extern_imm_data_refs.push((BODY, 9));
        f.extern_imm_data_refs.push((BODY + 2, 11));
        assert_eq!(plan(&f, Target::LinuxAarch64).len(), 2);
    }

    #[test]
    fn the_copy_clears_the_incoming_argument_reads() {
        let body = vec![Inst::ImmData(0x20), load(BODY), sink(BODY + 1)];
        let param = Inst::ParamRef {
            idx: 0,
            kind: LoadKind::I64,
        };
        let f = loop_func_pre(vec![param.clone(), local(3), local(4)], body.clone());
        assert_eq!(plan(&f, Target::LinuxAarch64)[0].at, PRE_AT);
        // Nothing may precede a `ParamRef`, so a destination that ends
        // in one offers no position and the sites stay where they are.
        let trailing = loop_func_pre(vec![local(2), local(3), param], body);
        assert!(plan(&trailing, Target::LinuxAarch64).is_empty());
    }

    #[test]
    fn the_copy_stays_ahead_of_a_fusable_compare() {
        // The destination's compare feeds its conditional terminator;
        // nothing may land between the two.
        let mut f = loop_func(vec![Inst::ImmData(0x20), load(BODY), sink(BODY + 1)]);
        f.insts[1] = Inst::BinopI {
            op: BinOp::Lt,
            lhs: 0,
            rhs_imm: 1,
        };
        f.blocks[0].terminator = Terminator::Bz {
            cond: 1,
            target: 1,
            fall_through: 1,
        };
        assert_eq!(plan(&f, Target::LinuxAarch64)[0].at, 1);
    }

    #[test]
    fn one_destination_takes_no_more_than_the_register_share() {
        let cap = (super::super::reg_alloc::usable_gpr_count(Target::LinuxAarch64) / 2).max(1);
        // Each load feeds a running sum, so no materialization is dead.
        let mut body: Vec<Inst> = Vec::new();
        let (mut idx, mut acc) = (BODY, NO_VALUE);
        for i in 0..(cap + 4) {
            body.push(Inst::ImmData(0x100 + i as i64 * 8));
            body.push(load(idx));
            let loaded = idx + 1;
            idx += 2;
            acc = if acc == NO_VALUE {
                loaded
            } else {
                body.push(Inst::Binop {
                    op: BinOp::Add,
                    lhs: acc,
                    rhs: loaded,
                });
                idx += 1;
                idx - 1
            };
        }
        body.push(sink(acc));
        assert_eq!(plan(&loop_func(body), Target::LinuxAarch64).len(), cap);
    }

    #[test]
    fn a_function_that_can_return_twice_is_left_alone() {
        let mut f = loop_func(vec![Inst::ImmData(0x38), load(BODY), sink(BODY + 1)]);
        assert_eq!(plan(&f, Target::LinuxAarch64).len(), 1);
        f.has_returns_twice_call = true;
        assert!(plan(&f, Target::LinuxAarch64).is_empty());
    }

    #[test]
    fn a_hoist_that_would_buy_a_callee_saved_register_is_dropped() {
        // The body calls, so a value held across it lands in the
        // callee-saved bank and the prologue grows by a save / restore
        // pair the loop never repays.
        let mut f = loop_func(vec![
            Inst::ImmData(0x38),
            load(BODY),
            Inst::CallExt {
                binding_idx: 0,
                args: vec![BODY + 1],
                fp_arg_mask: 0,
                fp_return: false,
                arg_aggs: Vec::new(),
                ret_agg: None,
                ret_slot_local: 0,
            },
            sink(BODY + 2),
        ]);
        assert_eq!(plan(&f, Target::LinuxAarch64).len(), 1);
        allocate_hoisted(&mut f, Target::LinuxAarch64);
        let pre = f.blocks[0].inst_range.clone();
        assert!(
            !pre.clone()
                .any(|v| matches!(f.insts[v as usize], Inst::ImmData(0x38)))
        );
    }

    #[test]
    fn the_placement_gate_leaves_a_consistent_function() {
        let mut f = loop_func(vec![Inst::ImmData(0x38), load(BODY), sink(BODY + 1)]);
        let alloc = allocate_hoisted(&mut f, Target::LinuxAarch64);
        assert_eq!(alloc.places.len(), f.insts.len());
        for b in &f.blocks {
            assert!(b.inst_range.end as usize <= f.insts.len());
        }
    }
}

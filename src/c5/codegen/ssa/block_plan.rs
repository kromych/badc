//! Which blocks reach the machine code, and where each branch lands.
//!
//! The allocation decides whether a block emits a byte (coalesced edge
//! moves, a join of phis, unread values), so the plan is built after it and
//! read-only: a phi block cannot go without renumbering the value tables.
//! At `-O` a small bottom test is repeated in place of the jump into a
//! rotated loop; it runs what the jump would have reached.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use super::emit_common::{edge_moves, inst_emits_nothing};
use super::mem2reg::successors;
use super::reg_alloc::{Allocation, for_each_operand};
use crate::c5::codegen::passes::layout::JumpChains;
use crate::c5::codegen::passes::unroll::eval_value;
use crate::c5::ir::{BlockId, FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator, ValueId};

const NO_BLOCK: BlockId = BlockId::MAX;

/// Of the 842 rotated loops of the aarch64 fixture corpus 82.8 % test in
/// one instruction, 94.9 % in two, 99.6 % in four.
const MAX_REPEATED_INSTS: usize = 4;

pub(crate) struct BlockPlan {
    target: Vec<BlockId>,
    skipped: Vec<bool>,
    /// The next emitted block.
    next: Vec<BlockId>,
    /// The block repeated in place of the closing jump.
    repeat: Vec<BlockId>,
    /// The arm a repeat takes when its test is decided where it is repeated.
    decided: Vec<BlockId>,
    /// Instructions only a decided repeat's test reads.
    test_only: BTreeSet<ValueId>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum CondShape {
    /// Both arms land on one block: no test.
    Jump(BlockId),
    /// Branch to `taken` on the (negated) condition, then reach `other`.
    Branch {
        taken: BlockId,
        other: BlockId,
        negate: bool,
    },
}

impl BlockPlan {
    pub(crate) fn build(func: &FunctionSsa, alloc: &Allocation, repeat_tests: bool) -> BlockPlan {
        let n = func.blocks.len();
        let mut plan = BlockPlan {
            target: (0..n as BlockId).collect(),
            skipped: alloc::vec![false; n],
            next: alloc::vec![NO_BLOCK; n],
            repeat: alloc::vec![NO_BLOCK; n],
            decided: alloc::vec![NO_BLOCK; n],
            test_only: BTreeSet::new(),
        };
        // Neither emitter lowers anything but the asm of a naked function.
        if !func.is_naked {
            let hops: Vec<BlockId> = (0..n as BlockId)
                .map(|b| forwards_to(func, alloc, b).unwrap_or(NO_BLOCK))
                .collect();
            let mut chains = JumpChains::default();
            chains.build_with(n, |b| Some(hops[b as usize]).filter(|&t| t != NO_BLOCK));
            let pinned = pinned_blocks(func);
            for (b, &pinned) in pinned.iter().enumerate() {
                // A chain into a jump cycle has no end and stays.
                if let Some(end) = chains.end(b as BlockId) {
                    plan.target[b] = end;
                    plan.skipped[b] = end != b as BlockId && !pinned;
                }
            }
        }
        let mut next = NO_BLOCK;
        for b in (0..n).rev() {
            plan.next[b] = next;
            if !plan.skipped[b] {
                next = b as BlockId;
            }
        }
        if repeat_tests && !func.is_naked {
            plan.plan_repeats(func, alloc);
        }
        plan
    }

    /// The block to repeat where `block_idx` would jump along an edge to `t`.
    pub(crate) fn repeated_at(&self, block_idx: usize, t: BlockId) -> Option<BlockId> {
        let h = self.repeat[block_idx];
        (h != NO_BLOCK && h == self.resolve(t)).then_some(h)
    }

    /// The arm the repeat ending `block_idx` takes; never the repeated block.
    pub(crate) fn decided_at(&self, block_idx: usize) -> Option<BlockId> {
        Some(self.decided[block_idx]).filter(|&arm| arm != NO_BLOCK)
    }

    pub(crate) fn is_test_only(&self, v: ValueId) -> bool {
        self.test_only.contains(&v)
    }

    /// The edge `b`'s code ends with a jump along.
    fn closing_jump(&self, func: &FunctionSsa, b: usize) -> Option<BlockId> {
        let t = match func.blocks[b].terminator {
            Terminator::Jmp(t) | Terminator::FallThrough(t) => t,
            Terminator::Bz {
                target,
                fall_through,
                ..
            }
            | Terminator::Bnz {
                target,
                fall_through,
                ..
            } => match self.cond_shape(b, target, fall_through, false) {
                CondShape::Jump(t) | CondShape::Branch { other: t, .. } => t,
            },
            Terminator::AsmGoto { table } => func.jump_tables[table as usize][0],
            _ => return None,
        };
        (!self.falls_into(b, t)).then_some(t)
    }

    fn plan_repeats(&mut self, func: &FunctionSsa, alloc: &Allocation) {
        let n = func.blocks.len();
        for p in (0..n).filter(|&p| !self.skipped[p]) {
            let Some(t) = self.closing_jump(func, p) else {
                continue;
            };
            let h = self.resolve(t);
            if h as usize == p {
                continue;
            }
            let Some((a, b)) = repeatable_arms(func, alloc, h) else {
                continue;
            };
            // The code runs into one arm: the repeat ends in one branch.
            let into = self.runs_into(p);
            if into != NO_BLOCK && (into == self.resolve(a) || into == self.resolve(b)) {
                self.repeat[p] = h;
                if let Some(arm) = self.decide(func, alloc, p as BlockId, t, h) {
                    self.decided[p] = arm;
                }
            }
        }
        // A block reached by repeated edges only would be dead code.
        let mut reached = alloc::vec![false; n];
        for q in (0..n).filter(|&q| !self.skipped[q]) {
            for s in successors(
                &func.blocks[q].terminator,
                &func.computed_goto_targets,
                &func.jump_tables,
            ) {
                let h = self.resolve(s);
                reached[h as usize] |= self.repeat[q] != h;
            }
        }
        for p in 0..n {
            if self.repeat[p] != NO_BLOCK && !reached[self.repeat[p] as usize] {
                self.repeat[p] = NO_BLOCK;
                self.decided[p] = NO_BLOCK;
            }
        }
        let decided: BTreeSet<BlockId> = (0..n)
            .filter(|&p| self.decided[p] != NO_BLOCK)
            .map(|p| self.repeat[p])
            .collect();
        for h in decided {
            self.test_only.extend(test_only(func, alloc, h));
        }
    }

    /// The arm `h`'s test takes when `p` reaches it through `t`: the path binds
    /// its phis to constants, `h` computes over values alone, and the test is
    /// read at the widths the emit issues (`cmp32`, `low_word_tests`).
    fn decide(
        &self,
        func: &FunctionSsa,
        alloc: &Allocation,
        p: BlockId,
        t: BlockId,
        h: BlockId,
    ) -> Option<BlockId> {
        let block = &func.blocks[h as usize];
        let range = block.inst_range.clone();
        let computes = |v: ValueId| {
            let inst = &func.insts[v as usize];
            inst_emits_nothing(inst, v, alloc)
                || matches!(
                    inst,
                    Inst::Imm(_) | Inst::Binop { .. } | Inst::BinopI { .. } | Inst::Extend { .. }
                )
        };
        if !range.clone().all(computes) {
            return None;
        }
        let mut state: BTreeMap<ValueId, Option<i64>> = BTreeMap::new();
        let (mut pred, mut cur) = (p, t);
        loop {
            bind_phis(func, pred, cur, &mut state);
            if cur == h {
                break;
            }
            (pred, cur) = (cur, forwards_to(func, alloc, cur)?);
        }
        let (cond, on_zero, other) = match block.terminator {
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => (cond, target, fall_through),
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => (cond, fall_through, target),
            _ => return None,
        };
        let c = eval_value(func, cond, &state, &mut BTreeMap::new(), 0, &alloc.cmp32)?;
        let low_word = func
            .low_word_tests
            .get(h as usize)
            .copied()
            .unwrap_or(false);
        let zero = if low_word { c as i32 == 0 } else { c == 0 };
        let arm = if zero { on_zero } else { other };
        (self.resolve(arm) != h).then_some(arm)
    }

    pub(crate) fn resolve(&self, b: BlockId) -> BlockId {
        self.target[b as usize]
    }

    pub(crate) fn is_skipped(&self, b: usize) -> bool {
        self.skipped[b]
    }

    /// Where the code of `block_idx` runs off its end; a kept block that
    /// emits nothing passes it on.
    fn runs_into(&self, block_idx: usize) -> BlockId {
        match self.next[block_idx] {
            NO_BLOCK => NO_BLOCK,
            next => self.resolve(next),
        }
    }

    /// Whether the code of `block_idx` runs into where an edge to `t` lands.
    pub(crate) fn falls_into(&self, block_idx: usize, t: BlockId) -> bool {
        self.runs_into(block_idx) == self.resolve(t)
    }

    /// A taken arm the code runs into swaps the arms and inverts the test.
    pub(crate) fn cond_shape(
        &self,
        block_idx: usize,
        target: BlockId,
        fall_through: BlockId,
        negate: bool,
    ) -> CondShape {
        let (t, f) = (self.resolve(target), self.resolve(fall_through));
        if t == f {
            CondShape::Jump(t)
        } else if self.runs_into(block_idx) == t {
            CondShape::Branch {
                taken: f,
                other: t,
                negate: !negate,
            }
        } else {
            CondShape::Branch {
                taken: t,
                other: f,
                negate,
            }
        }
    }
}

/// Bind the integer phis of `b`, at once, to the `Imm` or earlier-bound phi
/// `pred` feeds each; any other input leaves a phi unknown.
fn bind_phis(
    func: &FunctionSsa,
    pred: BlockId,
    b: BlockId,
    state: &mut BTreeMap<ValueId, Option<i64>>,
) {
    let mut bound: Vec<(ValueId, Option<i64>)> = Vec::new();
    for v in func.blocks[b as usize].inst_range.clone() {
        let Inst::Phi { incoming, kind } = &func.insts[v as usize] else {
            break;
        };
        let fp = matches!(
            kind,
            LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 | LoadKind::V128
        );
        let input = incoming.iter().find(|(from, _)| *from == pred).map(|i| i.1);
        let value = input.filter(|_| !fp).and_then(|src| {
            let f32 = func.f32_values.get(src as usize).copied().unwrap_or(false);
            match func.insts[src as usize] {
                Inst::Imm(k) if !f32 => Some(k),
                Inst::Phi { .. } => state.get(&src).copied().flatten(),
                _ => None,
            }
        });
        bound.push((v, value));
    }
    state.extend(bound);
}

/// Instructions of `h` read by its test alone, directly or through each other.
fn test_only(func: &FunctionSsa, alloc: &Allocation, h: BlockId) -> Vec<ValueId> {
    let block = &func.blocks[h as usize];
    let (Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. }) = block.terminator else {
        return Vec::new();
    };
    let range = block.inst_range.clone();
    let at = |v: ValueId| range.contains(&v).then(|| (v - range.start) as usize);
    let mut readers: Vec<u32> = range
        .clone()
        .map(|v| alloc.use_counts.get(v as usize).copied().unwrap_or(1))
        .collect();
    if let Some(i) = at(cond) {
        readers[i] = readers[i].saturating_sub(1);
    }
    let mut only = Vec::new();
    for v in range.clone().rev() {
        let inst = &func.insts[v as usize];
        if inst_emits_nothing(inst, v, alloc) || readers[(v - range.start) as usize] != 0 {
            continue;
        }
        only.push(v);
        let mut drop_read = |o: ValueId| {
            if let Some(i) = at(o) {
                readers[i] = readers[i].saturating_sub(1);
            }
        };
        // A folded shift pair reads its source alone; the counts omit the rest.
        match alloc.sxtw_source.get(v as usize) {
            Some(&src) if src != NO_VALUE => drop_read(src),
            _ => for_each_operand(inst, drop_read),
        }
    }
    only
}

/// `b` emits nothing and its one unconditional edge moves nothing.
fn forwards_to(func: &FunctionSsa, alloc: &Allocation, b: BlockId) -> Option<BlockId> {
    let block = &func.blocks[b as usize];
    let (Terminator::Jmp(t) | Terminator::FallThrough(t)) = block.terminator else {
        return None;
    };
    let silent = block
        .inst_range
        .clone()
        .all(|v| inst_emits_nothing(&func.insts[v as usize], v, alloc));
    (t != b && silent && edge_moves(func, alloc, b, t).is_empty()).then_some(t)
}

/// The arms of `h` when a second copy of it may run: a bounded run of
/// computations over values and non-volatile memory (C99 6.7.3p6), a
/// conditional branch, no moves on either edge out.
fn repeatable_arms(
    func: &FunctionSsa,
    alloc: &Allocation,
    h: BlockId,
) -> Option<(BlockId, BlockId)> {
    let block = &func.blocks[h as usize];
    let (Terminator::Bz {
        target,
        fall_through,
        ..
    }
    | Terminator::Bnz {
        target,
        fall_through,
        ..
    }) = block.terminator
    else {
        return None;
    };
    let mut live = 0;
    for v in block.inst_range.clone() {
        let inst = &func.insts[v as usize];
        if inst_emits_nothing(inst, v, alloc) {
            continue;
        }
        let recomputable = matches!(
            inst,
            Inst::Imm(_)
                | Inst::Binop { .. }
                | Inst::BinopI { .. }
                | Inst::Extend { .. }
                | Inst::Copy { .. }
                | Inst::Load {
                    volatile: false,
                    ..
                }
                | Inst::LoadLocal {
                    volatile: false,
                    ..
                }
                | Inst::LoadIndexed { .. }
        );
        live += 1;
        if !recomputable || live > MAX_REPEATED_INSTS {
            return None;
        }
    }
    let quiet = |s: BlockId| edge_moves(func, alloc, h, s).is_empty();
    (quiet(target) && quiet(fall_through)).then_some((target, fall_through))
}

/// Blocks that stay: the entry, and every block addressed by other than a
/// direct edge -- a label address, a jump-table slot (it takes the landing
/// pad), an `asm goto` label (its template branch has its own reach).
fn pinned_blocks(func: &FunctionSsa) -> Vec<bool> {
    let mut pinned = alloc::vec![false; func.blocks.len()];
    let mut pin = |b: BlockId| {
        if let Some(p) = pinned.get_mut(b as usize) {
            *p = true;
        }
    };
    pin(0);
    func.computed_goto_targets.iter().for_each(|&b| pin(b));
    func.label_data_relocs.iter().for_each(|r| pin(r.block));
    for block in &func.blocks {
        match block.terminator {
            Terminator::JumpTable { table, .. } => {
                func.jump_tables[table as usize]
                    .iter()
                    .for_each(|&b| pin(b));
            }
            // Row entry 0 is the fall-through, a direct edge.
            Terminator::AsmGoto { table } => {
                func.jump_tables[table as usize][1..]
                    .iter()
                    .for_each(|&b| pin(b));
            }
            _ => {}
        }
    }
    pinned
}

#[cfg(test)]
mod tests {
    use super::super::reg_alloc::{Place, RegBanks};
    use super::*;
    use crate::c5::codegen::Target;
    use crate::c5::ir::{
        BinOp, Block, Inst, LabelDataReloc, LoadKind, NO_VALUE, StoreKind, ValueId,
    };

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            inst_src: alloc::vec![(0, 0); n],
            f32_values: alloc::vec![false; n],
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

    /// Every value read once and placed as `places` says.
    fn alloc_with(places: Vec<Place>) -> Allocation {
        let n = places.len();
        Allocation {
            places,
            spill_count: 0,
            gpr_used: Vec::new(),
            fp_used: Vec::new(),
            fp_scratch: RegBanks::for_target(Target::host()).fp_scratch,
            use_counts: alloc::vec![1; n],
            last_use: alloc::vec![0; n],
            cmp32: alloc::vec![false; n],
            sxtw_source: alloc::vec![NO_VALUE; n],
            sxtw_k: alloc::vec![0; n],
            branch_fused: alloc::vec![false; n],
            imm_store: alloc::vec![false; n],
            implicit_live: alloc::vec::Vec::new(),
            hints: alloc::vec![None; n],
            f32_values: alloc::vec![false; n],
            high_observed: Vec::new(),
            high_clear: Vec::new(),
            wide: alloc::vec![false; n],
            asm_preserve: (u32::MAX, u32::MAX),
        }
    }

    fn phi(incoming: &[(BlockId, ValueId)], kind: LoadKind) -> Inst {
        Inst::Phi {
            incoming: incoming.to_vec(),
            kind,
        }
    }

    fn skipped(plan: &BlockPlan) -> Vec<usize> {
        (0..plan.skipped.len())
            .filter(|&b| plan.is_skipped(b))
            .collect()
    }

    /// `b0: v0; Jmp b1 / b1: Jmp b2 / b2: v1 = Phi[b1: v0]; Jmp b3 /
    /// b3: Return v1`, with `v1` placed in `phi_place`.
    fn chain(phi_place: Place) -> (FunctionSsa, Allocation) {
        let f = func_with(
            alloc::vec![Inst::Imm(5), phi(&[(1, 0)], LoadKind::I64)],
            alloc::vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..1, Terminator::Jmp(2)),
                block(1..2, Terminator::Jmp(3)),
                block(2..2, Terminator::Return(1)),
            ],
        );
        (f, alloc_with(alloc::vec![Place::IntReg(3), phi_place]))
    }

    #[test]
    fn a_chain_of_blocks_without_code_lands_on_its_end() {
        let (f, a) = chain(Place::IntReg(3));
        let plan = BlockPlan::build(&f, &a, false);
        assert_eq!(skipped(&plan), [1, 2]);
        assert_eq!(
            (plan.resolve(1), plan.resolve(2), plan.resolve(3)),
            (3, 3, 3)
        );
        assert!(plan.falls_into(0, 1), "block 0 runs into block 3");
    }

    #[test]
    fn an_edge_that_moves_a_value_keeps_its_block() {
        let (f, a) = chain(Place::IntReg(4));
        let plan = BlockPlan::build(&f, &a, false);
        // The move sits at the end of b1; the phi block behind it is silent.
        assert_eq!(skipped(&plan), [2]);
        assert_eq!((plan.resolve(1), plan.resolve(2)), (1, 3));
        let (f, a) = chain(Place::Spill(0));
        assert_eq!(skipped(&BlockPlan::build(&f, &a, false)), [2]);
    }

    #[test]
    fn a_constant_into_an_fp_phi_keeps_its_block() {
        let f = func_with(
            alloc::vec![Inst::Imm(0), phi(&[(1, 0)], LoadKind::F64)],
            alloc::vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..1, Terminator::Jmp(2)),
                block(1..2, Terminator::Return(1)),
            ],
        );
        let a = alloc_with(alloc::vec![Place::IntReg(0), Place::FpReg(0)]);
        assert!(skipped(&BlockPlan::build(&f, &a, false)).is_empty());
    }

    #[test]
    fn only_dead_pure_values_and_phis_are_no_code() {
        let store = Inst::StoreLocal {
            off: -1,
            value: 0,
            kind: StoreKind::I64,
            volatile: false,
        };
        for (inst, uses, silent) in [
            (Inst::Imm(9), 0, true),
            (Inst::Imm(9), 1, false),
            (store, 0, false),
        ] {
            let f = func_with(
                alloc::vec![Inst::Imm(1), inst],
                alloc::vec![
                    block(0..1, Terminator::Jmp(1)),
                    block(1..2, Terminator::Jmp(2)),
                    block(2..2, Terminator::Return(0)),
                ],
            );
            let mut a = alloc_with(alloc::vec![Place::IntReg(0), Place::IntReg(1)]);
            a.use_counts[1] = uses;
            let plan = BlockPlan::build(&f, &a, false);
            assert_eq!(
                plan.is_skipped(1),
                silent,
                "{:?} read {uses} times",
                f.insts[1]
            );
        }
    }

    #[test]
    fn a_jump_cycle_keeps_its_blocks() {
        // b1 <-> b2, b3 -> b3, and b4 leading into the first cycle.
        let f = func_with(
            alloc::vec![Inst::Imm(1)],
            alloc::vec![
                block(
                    0..1,
                    Terminator::Bnz {
                        cond: 0,
                        target: 4,
                        fall_through: 3,
                    }
                ),
                block(1..1, Terminator::Jmp(2)),
                block(1..1, Terminator::Jmp(1)),
                block(1..1, Terminator::Jmp(3)),
                block(1..1, Terminator::Jmp(1)),
            ],
        );
        let plan = BlockPlan::build(&f, &alloc_with(alloc::vec![Place::IntReg(0)]), false);
        assert!(skipped(&plan).is_empty());
        assert_eq!(
            (1..5).map(|b| plan.resolve(b)).collect::<Vec<_>>(),
            [1, 2, 3, 4]
        );
    }

    /// Five blocks without code behind the entry, all jumping to `b6`.
    fn addressed() -> FunctionSsa {
        let mut blocks = alloc::vec![block(0..1, Terminator::Jmp(1))];
        blocks.extend((1..6).map(|_| block(1..1, Terminator::Jmp(6))));
        blocks.push(block(1..1, Terminator::Return(0)));
        func_with(alloc::vec![Inst::Imm(1)], blocks)
    }

    #[test]
    fn addressed_blocks_are_kept_and_direct_edges_pass_them() {
        let a = alloc_with(alloc::vec![Place::IntReg(0)]);
        let plan = BlockPlan::build(&addressed(), &a, false);
        assert_eq!(skipped(&plan), [1, 2, 3, 4, 5]);

        let mut f = addressed();
        f.computed_goto_targets = alloc::vec![1];
        f.label_data_relocs = alloc::vec![LabelDataReloc {
            data_offset: 0,
            block: 2,
        }];
        f.jump_tables = alloc::vec![alloc::vec![3, 6], alloc::vec![5, 4]];
        f.blocks[0].terminator = Terminator::JumpTable { idx: 0, table: 0 };
        f.blocks[6].terminator = Terminator::AsmGoto { table: 1 };
        let plan = BlockPlan::build(&f, &a, false);
        // Row entry 0 of the `asm goto` is its fall-through, a direct edge.
        assert_eq!(skipped(&plan), [5]);
        // A direct edge still passes a kept block, and code that runs into
        // one runs into the block behind it.
        assert_eq!(plan.resolve(1), 6);
        assert!(plan.falls_into(3, 6) && plan.falls_into(4, 6));
    }

    #[test]
    fn a_naked_function_keeps_every_block() {
        let (mut f, a) = chain(Place::IntReg(3));
        f.is_naked = true;
        let plan = BlockPlan::build(&f, &a, false);
        assert!(skipped(&plan).is_empty());
        assert_eq!(plan.resolve(1), 1);
    }

    #[test]
    fn conditional_shape_follows_where_the_arms_land() {
        // b0: Bnz v0 -> b1 | b2; b1, b2 without code; b3, b4 with code.
        let build = |t1: BlockId, t2: BlockId| {
            let f = func_with(
                alloc::vec![Inst::Imm(1), Inst::Imm(2), Inst::Imm(3)],
                alloc::vec![
                    block(
                        0..1,
                        Terminator::Bnz {
                            cond: 0,
                            target: 1,
                            fall_through: 2,
                        }
                    ),
                    block(1..1, Terminator::Jmp(t1)),
                    block(1..1, Terminator::Jmp(t2)),
                    block(1..2, Terminator::Return(1)),
                    block(2..3, Terminator::Return(2)),
                ],
            );
            let a = alloc_with(alloc::vec![Place::IntReg(0); 3]);
            BlockPlan::build(&f, &a, false)
        };
        assert_eq!(build(4, 4).cond_shape(0, 1, 2, false), CondShape::Jump(4));
        // The taken arm lands on the next emitted block: the test inverts.
        assert_eq!(
            build(3, 4).cond_shape(0, 1, 2, false),
            CondShape::Branch {
                taken: 4,
                other: 3,
                negate: true
            }
        );
        assert_eq!(
            build(4, 3).cond_shape(0, 1, 2, true),
            CondShape::Branch {
                taken: 4,
                other: 3,
                negate: true
            }
        );
    }
    /// A rotated loop: `b0: v0; Jmp b2 / b1: v1; Jmp b2 / b2: test; Bnz v.. ->
    /// b1 | b3 / b3: Return`. `test` is block 2's instructions; the values
    /// 0 and 1 are defined ahead of it.
    fn rotated(test: Vec<Inst>) -> (FunctionSsa, Allocation) {
        let mut insts = alloc::vec![Inst::Imm(1), Inst::Imm(2)];
        let head = insts.len() as u32;
        insts.extend(test);
        let end = insts.len() as u32;
        let f = func_with(
            insts,
            alloc::vec![
                block(0..1, Terminator::Jmp(2)),
                block(1..2, Terminator::Jmp(2)),
                block(
                    head..end,
                    Terminator::Bnz {
                        cond: end - 1,
                        target: 1,
                        fall_through: 3,
                    }
                ),
                block(end..end, Terminator::Return(0)),
            ],
        );
        let a = alloc_with((0..end).map(|v| Place::IntReg(v as u8)).collect());
        (f, a)
    }

    fn compare() -> Inst {
        Inst::Binop {
            op: crate::c5::ir::BinOp::Lt,
            lhs: 0,
            rhs: 1,
        }
    }

    fn repeats(plan: &BlockPlan) -> Vec<(usize, BlockId)> {
        (0..plan.repeat.len())
            .filter(|&p| plan.repeat[p] != NO_BLOCK)
            .map(|p| (p, plan.repeat[p]))
            .collect()
    }

    #[test]
    fn the_jump_into_a_rotated_loop_repeats_its_test() {
        let (f, a) = rotated(alloc::vec![compare()]);
        let plan = BlockPlan::build(&f, &a, true);
        assert_eq!(repeats(&plan), [(0, 2)]);
        assert_eq!(plan.repeated_at(0, 2), Some(2));
        // The latch runs into the test and repeats nothing.
        assert_eq!(plan.repeated_at(1, 2), None);
        assert!(repeats(&BlockPlan::build(&f, &a, false)).is_empty());
    }

    #[test]
    fn a_test_that_may_not_run_twice_is_not_repeated() {
        let load = |volatile| Inst::Load {
            addr: 0,
            disp: 0,
            kind: LoadKind::I32,
            volatile,
            align: 0,
        };
        let (f, a) = rotated(alloc::vec![load(false), compare()]);
        assert_eq!(repeats(&BlockPlan::build(&f, &a, true)), [(0, 2)]);
        let (f, a) = rotated(alloc::vec![load(true), compare()]);
        assert!(repeats(&BlockPlan::build(&f, &a, true)).is_empty());
        let store = Inst::StoreLocal {
            off: -1,
            value: 0,
            kind: StoreKind::I64,
            volatile: false,
        };
        let (f, a) = rotated(alloc::vec![store, compare()]);
        assert!(repeats(&BlockPlan::build(&f, &a, true)).is_empty());
        let (f, a) = rotated(alloc::vec![Inst::BlockAddr(3), compare()]);
        assert!(repeats(&BlockPlan::build(&f, &a, true)).is_empty());
    }

    #[test]
    fn the_repeat_is_bounded_by_its_live_instructions() {
        let body = |n: usize| (0..n).map(|_| compare()).collect::<Vec<_>>();
        let (f, a) = rotated(body(MAX_REPEATED_INSTS));
        assert_eq!(repeats(&BlockPlan::build(&f, &a, true)), [(0, 2)]);
        let (f, a) = rotated(body(MAX_REPEATED_INSTS + 1));
        assert!(repeats(&BlockPlan::build(&f, &a, true)).is_empty());
        // A value nobody reads emits nothing and does not count.
        let (f, mut a) = rotated(body(MAX_REPEATED_INSTS + 1));
        a.use_counts[2] = 0;
        assert_eq!(repeats(&BlockPlan::build(&f, &a, true)), [(0, 2)]);
    }

    #[test]
    fn a_test_with_a_move_on_an_edge_out_is_not_repeated() {
        let (mut f, mut a) = rotated(alloc::vec![compare()]);
        // The exit block takes a phi fed by the test block from another place.
        let at = f.insts.len() as u32;
        f.insts.push(phi(&[(2, 0)], LoadKind::I64));
        f.inst_src.push((0, 0));
        f.f32_values.push(false);
        f.blocks[3] = block(at..at + 1, Terminator::Return(at));
        a = alloc_with(a.places.iter().copied().chain([Place::IntReg(9)]).collect());
        assert!(repeats(&BlockPlan::build(&f, &a, true)).is_empty());
    }

    #[test]
    fn a_test_no_other_edge_reaches_keeps_the_jump() {
        // The same blocks without the back edge: block 1 returns.
        let (mut f, a) = rotated(alloc::vec![compare()]);
        f.blocks[1].terminator = Terminator::Return(0);
        assert!(repeats(&BlockPlan::build(&f, &a, true)).is_empty());
    }

    /// A counted loop: `b0: v0 = init; Jmp b2 / b1: v1 = v2 + 1; Jmp b2 /
    /// b2: v2 = Phi[b0: v0, b1: v1]; test; Bnz (last value) -> b1 | b3 /
    /// b3: Return v2`, every value in one register, so no edge moves.
    fn counted(init: Inst, test: Vec<Inst>) -> (FunctionSsa, Allocation) {
        let mut insts = alloc::vec![
            init,
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 2,
                rhs_imm: 1
            },
            phi(&[(0, 0), (1, 1)], LoadKind::I64),
        ];
        insts.extend(test);
        let end = insts.len() as u32;
        let f = func_with(
            insts,
            alloc::vec![
                block(0..1, Terminator::Jmp(2)),
                block(1..2, Terminator::Jmp(2)),
                block(
                    2..end,
                    Terminator::Bnz {
                        cond: end - 1,
                        target: 1,
                        fall_through: 3,
                    }
                ),
                block(end..end, Terminator::Return(2)),
            ],
        );
        (f, alloc_with(alloc::vec![Place::IntReg(0); end as usize]))
    }

    fn op_imm(op: BinOp, lhs: ValueId, rhs_imm: i64) -> Inst {
        Inst::BinopI { op, lhs, rhs_imm }
    }

    /// The arm the repeat at the end of `b0` takes.
    fn decided(f: &FunctionSsa, a: &Allocation) -> Option<BlockId> {
        let plan = BlockPlan::build(f, a, true);
        assert_eq!(repeats(&plan), [(0, 2)], "the test is repeated");
        plan.decided_at(0)
    }

    #[test]
    fn a_test_over_constants_is_decided_where_it_is_repeated() {
        let (f, a) = counted(Inst::Imm(0), alloc::vec![op_imm(BinOp::Lt, 2, 16)]);
        let plan = BlockPlan::build(&f, &a, true);
        assert_eq!(plan.decided_at(0), Some(1), "0 < 16 enters the loop");
        assert!(plan.is_test_only(3) && !plan.is_test_only(2));
        assert_eq!(plan.decided_at(1), None, "the latch repeats nothing");
        let (f, a) = counted(Inst::Imm(20), alloc::vec![op_imm(BinOp::Lt, 2, 16)]);
        assert_eq!(decided(&f, &a), Some(3), "20 < 16 leaves it");
        // Without `-O` nothing is repeated, so nothing is decided.
        assert_eq!(BlockPlan::build(&f, &a, false).decided_at(0), None);
    }

    #[test]
    fn a_test_over_unknown_values_is_left_to_run() {
        let lt = || op_imm(BinOp::Lt, 2, 16);
        let param = Inst::ParamRef {
            idx: 0,
            kind: LoadKind::I64,
        };
        let (f, a) = counted(param, alloc::vec![lt()]);
        assert_eq!(decided(&f, &a), None, "a parameter feeds the phi");
        let mut fp = counted(Inst::Imm(0), alloc::vec![lt()]);
        fp.0.f32_values[0] = true;
        assert_eq!(decided(&fp.0, &fp.1), None, "an f32 pattern feeds the phi");
        // A load in the test block, even one the test does not read.
        let load = Inst::Load {
            addr: 2,
            disp: 0,
            kind: LoadKind::I32,
            volatile: false,
            align: 0,
        };
        let (f, a) = counted(Inst::Imm(0), alloc::vec![load, lt()]);
        assert_eq!(decided(&f, &a), None);
        // A divisor of zero is left to trap at run time.
        let div = Inst::Binop {
            op: BinOp::Div,
            lhs: 2,
            rhs: 2,
        };
        let (f, a) = counted(Inst::Imm(0), alloc::vec![div, op_imm(BinOp::Lt, 3, 16)]);
        assert_eq!(decided(&f, &a), None);
    }

    #[test]
    fn a_decided_test_reads_the_widths_the_emit_issues() {
        let wide = 1i64 << 32;
        let lt = |op| alloc::vec![op_imm(op, 2, 16)];
        // `cmp x` sees 2^32; `cmp w` sees its low word, 0.
        let (f, mut a) = counted(Inst::Imm(wide), lt(BinOp::Lt));
        assert_eq!(decided(&f, &a), Some(3));
        a.cmp32[3] = true;
        assert_eq!(decided(&f, &a), Some(1));
        // The low word of 2^31 is below 16 signed, not unsigned.
        let (f, mut a) = counted(Inst::Imm(1 << 31), lt(BinOp::Lt));
        a.cmp32[3] = true;
        assert_eq!(decided(&f, &a), Some(1));
        let (f, mut a) = counted(Inst::Imm(1 << 31), lt(BinOp::Ult));
        a.cmp32[3] = true;
        assert_eq!(decided(&f, &a), Some(3));
        // `cbnz x` / `test r64` see 2^32; `cbnz w` / `test r32` see 0.
        let (mut f, a) = counted(Inst::Imm(wide), Vec::new());
        assert_eq!(decided(&f, &a), Some(1));
        f.low_word_tests = alloc::vec![false, false, true, false];
        assert_eq!(decided(&f, &a), Some(3));
    }

    #[test]
    fn a_decided_test_wraps_signed_arithmetic() {
        // `i + 1 < i` holds where `i + 1` wraps, at either width.
        let wraps = || {
            alloc::vec![
                op_imm(BinOp::Add, 2, 1),
                Inst::Binop {
                    op: BinOp::Lt,
                    lhs: 3,
                    rhs: 2,
                },
            ]
        };
        let (f, a) = counted(Inst::Imm(i64::MAX), wraps());
        assert_eq!(decided(&f, &a), Some(1));
        let (f, mut a) = counted(Inst::Imm(i64::from(i32::MAX)), wraps());
        assert_eq!(decided(&f, &a), Some(3));
        a.cmp32[4] = true;
        assert_eq!(decided(&f, &a), Some(1));
    }

    #[test]
    fn a_decided_arm_on_the_test_itself_is_left_to_the_test() {
        // b0: v0 = init; Jmp b2 / b1: Return / b2: v2 = Phi[b0: v0, b2: v3];
        // v3 = v2 + 1; v4 = v3 < 16; Bnz v4 -> b2 | b1.
        let build = |init: i64| {
            let f = func_with(
                alloc::vec![
                    Inst::Imm(init),
                    Inst::Imm(0),
                    phi(&[(0, 0), (2, 3)], LoadKind::I64),
                    op_imm(BinOp::Add, 2, 1),
                    op_imm(BinOp::Lt, 3, 16),
                ],
                alloc::vec![
                    block(0..1, Terminator::Jmp(2)),
                    block(1..2, Terminator::Return(1)),
                    block(
                        2..5,
                        Terminator::Bnz {
                            cond: 4,
                            target: 2,
                            fall_through: 1,
                        }
                    ),
                ],
            );
            let a = alloc_with(alloc::vec![Place::IntReg(0); 5]);
            decided(&f, &a)
        };
        assert_eq!(build(0), None);
        assert_eq!(build(20), Some(1));
    }

    #[test]
    fn what_else_reads_a_repeated_value_stays_in_the_repeat() {
        // v3 = v2 * 4 is read by the return, v4 = v3 < 64 by the test alone.
        let (mut f, mut a) = counted(
            Inst::Imm(0),
            alloc::vec![op_imm(BinOp::Mul, 2, 4), op_imm(BinOp::Lt, 3, 64)],
        );
        f.blocks[3].terminator = Terminator::Return(3);
        a.use_counts[3] = 2;
        let plan = BlockPlan::build(&f, &a, true);
        assert_eq!(plan.decided_at(0), Some(1));
        assert!(plan.is_test_only(4) && !plan.is_test_only(3));
        // The same value read by the test alone goes with it.
        a.use_counts[3] = 1;
        f.blocks[3].terminator = Terminator::Return(2);
        assert!(BlockPlan::build(&f, &a, true).is_test_only(3));
    }

    #[test]
    fn a_folded_shift_pair_reads_only_its_source() {
        // v3 = 32; v4 = v2 << v3; v5 = v4 >> v3, emitted as `sxtw` of v2;
        // v6 = v2 << v3, returned; v7 = v5 < 16, the test. The allocation
        // counted neither shift's read of v3, nor v4 at all.
        let shift = |op, lhs| Inst::Binop { op, lhs, rhs: 3 };
        let (mut f, mut a) = counted(
            Inst::Imm(0),
            alloc::vec![
                Inst::Imm(32),
                shift(BinOp::Shl, 2),
                shift(BinOp::Shr, 4),
                shift(BinOp::Shl, 2),
                op_imm(BinOp::Lt, 5, 16),
            ],
        );
        f.blocks[3].terminator = Terminator::Return(6);
        a.use_counts[4] = 0;
        a.sxtw_source[5] = 2;
        a.sxtw_k[5] = 32;
        let plan = BlockPlan::build(&f, &a, true);
        assert_eq!(plan.decided_at(0), Some(1));
        let only: Vec<ValueId> = (3..8).filter(|&v| plan.is_test_only(v)).collect();
        assert_eq!(only, [5, 7], "v3 is still read by v6");
    }

    #[test]
    fn a_jump_not_followed_by_an_arm_of_the_test_stays() {
        // Layout b0, b3', b1, b2: the block after the jump is neither arm.
        let (mut f, a) = rotated(alloc::vec![compare()]);
        let end = f.insts.len() as u32;
        f.blocks.insert(1, block(end..end, Terminator::Return(1)));
        for b in f.blocks.iter_mut() {
            b.terminator = match b.terminator {
                Terminator::Jmp(t) => Terminator::Jmp(t + 1),
                Terminator::Bnz {
                    cond,
                    target,
                    fall_through,
                } => Terminator::Bnz {
                    cond,
                    target: target + 1,
                    fall_through: fall_through + 1,
                },
                t => t,
            };
        }
        assert!(repeats(&BlockPlan::build(&f, &a, true)).is_empty());
    }
}

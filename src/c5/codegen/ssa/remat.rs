//! Setting an operand-free value again after a call in place of keeping
//! it across the call.
//!
//! A value live across a call takes a callee-saved register, saved and
//! restored once per call of the function, or a spill slot. A constant
//! or the address of a local, an object, a function or a TLS object is
//! set from its encoding in one or two instructions, so a use of it
//! reached across a call -- some path from the definition passes a call
//! site -- reads a definition of its own after the call. Such uses form
//! runs no call separates, over a block and the blocks following it on
//! the tape with their one predecessor in the run, one definition ahead
//! of each run's first use. A run in a loop keeps the original: set
//! again per iteration, the value costs every time what the register
//! costs once; that register paid for, the other runs keep it too.

use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{BinOp, BlockId, FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};
use super::Target;
use super::mem2reg::{SuccGraph, predecessors};
use super::reg_alloc::{
    block_weights, compute_use_counts, drop_rebuilt_incomes, for_each_operand, is_call_site,
    operands_read, tls_addr_is_call,
};
use super::tape::{At, Insertion};

const NO_BLOCK: BlockId = BlockId::MAX;
/// A use at a block's end: a phi income on an out edge or a terminator operand.
const END: u32 = u32::MAX;

/// Whether `inst` sets its value from its encoding alone, a TLS address where that is no call.
fn rematerializable(inst: &Inst, tls_addr_is_call: bool) -> bool {
    match inst {
        Inst::Imm(_)
        | Inst::ImmData(_)
        | Inst::ImmCode(_)
        | Inst::ImmExtCode(_)
        | Inst::LocalAddr(_) => true,
        Inst::TlsAddr(_) => !tls_addr_is_call,
        _ => false,
    }
}

/// Longest chain of folded immediate adds over an operand-free value.
const CHAIN_MAX: usize = 3;

/// The instructions setting `v`, base first: an operand-free value, or the
/// adds and subtracts of a folded immediate over one (`&tab[1]`).
fn chain(
    func: &FunctionSsa,
    target: Target,
    tls_addr_is_call: bool,
    v: ValueId,
) -> Option<Vec<ValueId>> {
    let mut out = Vec::new();
    let mut at = v;
    loop {
        out.push(at);
        match func.insts[at as usize] {
            Inst::BinopI {
                op: op @ (BinOp::Add | BinOp::Sub),
                lhs,
                rhs_imm,
            } if out.len() < CHAIN_MAX
                && !super::licm::binop_imm_materializes(target, op, rhs_imm, false) =>
            {
                at = lhs
            }
            ref inst if rematerializable(inst, tls_addr_is_call) => {
                out.reverse();
                return Some(out);
            }
            _ => return None,
        }
    }
}

/// One read of a candidate value.
#[derive(Clone, Copy)]
struct Use {
    value: ValueId,
    block: BlockId,
    /// Instruction index of the reader, or [`END`].
    at: u32,
    /// The phi an [`END`] income belongs to; `NO_VALUE` for a terminator.
    phi: ValueId,
}

/// The tape's call sites and block chains.
struct Layout {
    /// Call sites at indices below each index; `n + 1` entries.
    calls: Vec<u32>,
    block_of: Vec<BlockId>,
    /// Per block, its chain: the blocks following it on the tape with their one predecessor in it.
    chain_of: Vec<u32>,
    /// Per block, its place in tape order: an empty block before the one starting where it stands.
    rank: Vec<u32>,
}

impl Layout {
    fn new(func: &FunctionSsa, tls_addr_is_call: bool) -> Self {
        let n = func.insts.len();
        let mut calls = vec![0; n + 1];
        for (i, inst) in func.insts.iter().enumerate() {
            calls[i + 1] = calls[i] + u32::from(is_call_site(inst, tls_addr_is_call));
        }
        let mut block_of = vec![NO_BLOCK; n];
        for (b, block) in func.blocks.iter().enumerate() {
            for idx in block.inst_range.clone() {
                block_of[idx as usize] = b as BlockId;
            }
        }
        let preds = predecessors(func);
        let mut order: Vec<usize> = (0..func.blocks.len()).collect();
        order.sort_unstable_by_key(|&b| {
            let r = &func.blocks[b].inst_range;
            (r.start, r.end, b)
        });
        let mut chain_of = vec![0; func.blocks.len()];
        let mut rank = vec![0; func.blocks.len()];
        let mut chain = 0;
        let mut prev: Option<usize> = None;
        for (k, &b) in order.iter().enumerate() {
            rank[b] = k as u32;
            let chains = prev.is_some_and(|p| {
                func.blocks[p].inst_range.end == func.blocks[b].inst_range.start
                    && preds[b].len() == 1
                    && preds[b][0] as usize == p
                    && !matches!(func.blocks[p].terminator, Terminator::AsmGoto { .. })
            });
            if !chains {
                chain += 1;
            }
            chain_of[b] = chain;
            prev = Some(b);
        }
        Layout {
            calls,
            block_of,
            chain_of,
            rank,
        }
    }

    /// Call sites at indices in `from..to`.
    fn calls_in(&self, from: u32, to: u32) -> u32 {
        self.calls[to as usize] - self.calls[from as usize]
    }

    /// The tape index a use is read at: the block's end for [`END`].
    fn read_at(&self, func: &FunctionSsa, u: &Use) -> u32 {
        if u.at == END {
            func.blocks[u.block as usize].inst_range.end
        } else {
            u.at
        }
    }

    /// Tape order of uses: an [`END`] use ahead of the next block's first.
    fn pos(&self, func: &FunctionSsa, u: &Use) -> u32 {
        2 * self.read_at(func, u) + u32::from(u.at != END)
    }
}

/// Where a run of uses at a block's end takes its definition: ahead of a
/// branch condition defined after the block's last call, so the compare
/// stays next to its branch, else after the last instruction or into an empty block.
fn end_position(func: &FunctionSsa, layout: &Layout, b: BlockId) -> At {
    let block = &func.blocks[b as usize];
    let range = block.inst_range.clone();
    if range.is_empty() {
        return At::Empty(b);
    }
    let mut cond = NO_VALUE;
    if let Terminator::Bz { cond: c, .. } | Terminator::Bnz { cond: c, .. } = block.terminator {
        cond = c;
    }
    if range.contains(&cond)
        && layout.calls_in(cond, range.end) == 0
        && !matches!(
            func.insts[cond as usize],
            Inst::Phi { .. } | Inst::ParamRef { .. }
        )
    {
        return At::Before(cond);
    }
    At::After(range.end - 1)
}

/// Blocks a path from a value's definition, not through it again, enters past a call.
struct Reach {
    /// Per block: bit 0 entered with no call on the path, bit 1 with one.
    state: Vec<u8>,
    touched: Vec<BlockId>,
    work: Vec<(BlockId, bool)>,
}

impl Reach {
    fn new(blocks: usize) -> Self {
        Reach {
            state: vec![0; blocks],
            touched: Vec::new(),
            work: Vec::new(),
        }
    }

    fn compute(&mut self, func: &FunctionSsa, succ: &SuccGraph, layout: &Layout, v: ValueId) {
        for &b in &self.touched {
            self.state[b as usize] = 0;
        }
        self.touched.clear();
        let d = layout.block_of[v as usize];
        let out = layout.calls_in(v + 1, func.blocks[d as usize].inst_range.end) > 0;
        self.work.extend(succ.of(d).iter().map(|&s| (s, out)));
        while let Some((b, past)) = self.work.pop() {
            if b == d {
                continue;
            }
            let bit = 1u8 << u8::from(past);
            let state = &mut self.state[b as usize];
            if *state & bit != 0 {
                continue;
            }
            if *state == 0 {
                self.touched.push(b);
            }
            *state |= bit;
            let range = &func.blocks[b as usize].inst_range;
            let out = past || layout.calls_in(range.start, range.end) > 0;
            self.work.extend(succ.of(b).iter().map(|&s| (s, out)));
        }
    }

    fn past_call(&self, b: BlockId) -> bool {
        self.state[b as usize] & 2 != 0
    }
}

/// A run of uses reading one new definition.
struct Run {
    value: ValueId,
    at: At,
    uses: core::ops::Range<usize>,
}

/// Every read of a candidate, ordered by value, chain and position.
fn collect_uses(func: &FunctionSsa, layout: &Layout, cand: &[bool], reads: &[bool]) -> Vec<Use> {
    let n = func.insts.len();
    let mut uses: Vec<Use> = Vec::new();
    let is_cand = |v: ValueId| (v as usize) < n && cand[v as usize];
    for (b, block) in func.blocks.iter().enumerate() {
        let b = b as BlockId;
        for idx in block.inst_range.clone() {
            let inst = &func.insts[idx as usize];
            if let Inst::Phi { incoming, kind } = inst {
                for &(pred, v) in incoming {
                    if is_cand(v) && !super::emit_common::phi_rebuilds_income(func, *kind, v) {
                        uses.push(Use {
                            value: v,
                            block: pred,
                            at: END,
                            phi: idx,
                        });
                    }
                }
                continue;
            }
            if !reads[idx as usize] {
                continue;
            }
            for_each_operand(inst, |v| {
                if is_cand(v) {
                    uses.push(Use {
                        value: v,
                        block: b,
                        at: idx,
                        phi: NO_VALUE,
                    });
                }
            });
        }
        block.terminator.for_each_operand(|v| {
            if is_cand(v) {
                uses.push(Use {
                    value: v,
                    block: b,
                    at: END,
                    phi: NO_VALUE,
                });
            }
        });
    }
    uses.sort_unstable_by_key(|u| {
        (
            u.value,
            layout.chain_of[u.block as usize],
            layout.rank[u.block as usize],
            layout.pos(func, u),
            u.phi,
        )
    });
    uses
}

/// The runs of `uses` reached across a call; a value with such a run in a loop keeps every use.
fn plan(func: &FunctionSsa, layout: &Layout, uses: &[Use]) -> Vec<Run> {
    let weights = block_weights(func);
    let succ = SuccGraph::new(func);
    let mut reach = Reach::new(func.blocks.len());
    let mut runs: Vec<Run> = Vec::new();
    let mut g0 = 0;
    while g0 < uses.len() {
        let v = uses[g0].value;
        let mut g1 = g0;
        while g1 < uses.len() && uses[g1].value == v {
            g1 += 1;
        }
        let group = g0..g1;
        g0 = g1;
        let d = layout.block_of[v as usize];
        if d == NO_BLOCK {
            continue;
        }
        if uses[group.clone()].iter().any(|u| u.block != d) {
            reach.compute(func, &succ, layout, v);
        }
        let reached = |u: &Use| {
            let at = layout.read_at(func, u);
            if u.block == d {
                layout.calls_in(v + 1, at) > 0
            } else {
                reach.past_call(u.block)
                    || layout.calls_in(func.blocks[u.block as usize].inst_range.start, at) > 0
            }
        };
        let mark = runs.len();
        let mut i = group.start;
        while i < group.end {
            let u = uses[i];
            if !reached(&u) {
                i += 1;
                continue;
            }
            if weights[u.block as usize] > 1 {
                runs.truncate(mark);
                break;
            }
            let at = if u.at == END {
                end_position(func, layout, u.block)
            } else {
                At::Before(u.at)
            };
            // A reader that is a call ends the run: it clobbers what it read.
            let mut j = i + 1;
            while j < group.end
                && layout.chain_of[uses[j].block as usize] == layout.chain_of[u.block as usize]
                && layout.calls_in(
                    layout.read_at(func, &uses[j - 1]),
                    layout.read_at(func, &uses[j]),
                ) == 0
            {
                j += 1;
            }
            runs.push(Run {
                value: v,
                at,
                uses: i..j,
            });
            i = j;
        }
    }
    runs
}

/// Give every use reached across a call a definition after the call.
pub(crate) fn split_across_calls(func: &mut FunctionSsa, target: Target) {
    let n = func.insts.len();
    if n == 0 || func.blocks.is_empty() {
        return;
    }
    let tls_call = tls_addr_is_call(target);
    let mut use_counts = compute_use_counts(func);
    drop_rebuilt_incomes(func, &mut use_counts);
    let cand: Vec<bool> = (0..n)
        .map(|v| use_counts[v] > 0 && chain(func, target, tls_call, v as ValueId).is_some())
        .collect();
    if !cand.contains(&true) {
        return;
    }
    let reads = operands_read(func, &use_counts);
    let layout = Layout::new(func, tls_call);
    let uses = collect_uses(func, &layout, &cand, &reads);
    let runs = plan(func, &layout, &uses);
    if runs.is_empty() {
        return;
    }
    let mut order: Vec<usize> = (0..runs.len()).collect();
    order.sort_by_key(|&k| (runs[k].at.order(&func.blocks), k));
    let data_sym = super::licm::sym_of(&func.extern_imm_data_refs);
    let code_sym = super::licm::sym_of(&func.extern_imm_code_refs);
    let tls_sym = super::licm::sym_of(&func.extern_tls_refs);
    // A run's copies are its value's chain at one position, from `first` in `ins`.
    let mut ins: Vec<Insertion> = Vec::new();
    let mut first: Vec<usize> = Vec::with_capacity(order.len());
    let mut members: Vec<ValueId> = Vec::new();
    for &k in &order {
        first.push(ins.len());
        let Some(chain) = chain(func, target, tls_call, runs[k].value) else {
            continue;
        };
        for &m in &chain {
            ins.push(Insertion {
                at: runs[k].at,
                inst: func.insts[m as usize].clone(),
                is_f32: func.f32_values.get(m as usize).copied().unwrap_or(false),
            });
            members.push(m);
        }
    }
    first.push(ins.len());
    let (rewrite, _undo) = super::tape::insert(func, &ins);
    for (i, &k) in order.iter().enumerate() {
        let r = &runs[k];
        let ids = &rewrite.ids[first[i]..first[i + 1]];
        let Some(&id) = ids.last() else {
            continue;
        };
        let nv = rewrite.remap[r.value as usize];
        for (j, &copy) in ids.iter().enumerate() {
            // A copy inherits its original's binding and reads the copy of its operand.
            let orig = members[first[i] + j];
            let bound = |table: &mut Vec<(u32, u32)>, syms: &hashbrown::HashMap<u32, u32>| {
                if let Some(&s) = syms.get(&orig) {
                    table.push((copy, s));
                }
            };
            match &mut func.insts[copy as usize] {
                Inst::ImmData(_) => bound(&mut func.extern_imm_data_refs, &data_sym),
                Inst::ImmCode(_) => bound(&mut func.extern_imm_code_refs, &code_sym),
                Inst::TlsAddr(_) => bound(&mut func.extern_tls_refs, &tls_sym),
                Inst::BinopI { lhs, .. } => *lhs = ids[j - 1],
                _ => {}
            }
        }
        let redirect = |op: &mut ValueId| {
            if *op == nv {
                *op = id;
            }
        };
        for u in &uses[r.uses.clone()] {
            if u.at != END {
                func.insts[rewrite.remap[u.at as usize] as usize].for_each_operand_mut(redirect);
            } else if u.phi != NO_VALUE {
                if let Inst::Phi { incoming, .. } =
                    &mut func.insts[rewrite.remap[u.phi as usize] as usize]
                {
                    for (pred, income) in incoming.iter_mut() {
                        if *pred == u.block {
                            redirect(income);
                        }
                    }
                }
            } else {
                let block = &mut func.blocks[u.block as usize];
                block.terminator.for_each_operand_mut(redirect);
                redirect(&mut block.exit_acc);
            }
        }
    }
    for table in [
        &mut func.extern_imm_code_refs,
        &mut func.extern_imm_data_refs,
        &mut func.extern_tls_refs,
    ] {
        table.sort_unstable();
    }
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{Block, LoadKind, StoreKind, Terminator};
    use super::*;

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

    fn store_of(value: ValueId) -> Inst {
        Inst::StoreLocal {
            off: -1,
            value,
            kind: StoreKind::I64,
            volatile: false,
            nsw: false,
        }
    }

    fn call_of(args: Vec<ValueId>) -> Inst {
        Inst::CallExt {
            binding_idx: 0,
            args,
            fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
            low_word_args: 0,
            arg_widths: crate::c5::ir::ArgWidths::default(),
            fp_return: false,
            arg_aggs: Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        }
    }

    fn add(lhs: ValueId, rhs: ValueId) -> Inst {
        Inst::Binop {
            op: crate::c5::ir::BinOp::Add,
            lhs,
            rhs,
        }
    }

    fn phi(incoming: Vec<(BlockId, ValueId)>) -> Inst {
        Inst::Phi {
            incoming,
            kind: LoadKind::I64,
        }
    }

    fn imms(func: &FunctionSsa, k: i64) -> Vec<ValueId> {
        func.insts
            .iter()
            .enumerate()
            .filter(|(_, i)| matches!(i, Inst::Imm(v) if *v == k))
            .map(|(i, _)| i as ValueId)
            .collect()
    }

    fn stored(func: &FunctionSsa, at: ValueId) -> ValueId {
        match func.insts[at as usize] {
            Inst::StoreLocal { value, .. } => value,
            ref other => panic!("{other:?}"),
        }
    }

    /// `k = 5; store k; call; store k; store k`: the stores past the
    /// call read one new definition placed ahead of the first, and the
    /// original keeps the store before the call.
    #[test]
    fn uses_past_a_call_read_a_definition_after_it() {
        let mut f = func_with(
            vec![
                Inst::Imm(5),
                store_of(0),
                call_of(vec![]),
                store_of(0),
                store_of(0),
            ],
            vec![block(0..5, Terminator::Return(NO_VALUE))],
        );
        split_across_calls(&mut f, Target::LinuxAarch64);
        assert_eq!(imms(&f, 5), vec![0, 3]);
        assert!(matches!(f.insts[2], Inst::CallExt { .. }));
        assert_eq!(stored(&f, 1), 0);
        assert_eq!(stored(&f, 4), 3);
        assert_eq!(stored(&f, 5), 3);
        assert_eq!(f.blocks[0].inst_range, 0..6);
    }

    /// A second call between two uses past the first gives the second
    /// use a definition of its own.
    #[test]
    fn a_call_between_two_reached_uses_splits_them() {
        let mut f = func_with(
            vec![
                Inst::Imm(5),
                call_of(vec![]),
                store_of(0),
                call_of(vec![]),
                store_of(0),
            ],
            vec![block(0..5, Terminator::Return(NO_VALUE))],
        );
        split_across_calls(&mut f, Target::LinuxAarch64);
        assert_eq!(imms(&f, 5), vec![0, 2, 5]);
        assert_eq!(stored(&f, 3), 2);
        assert_eq!(stored(&f, 6), 5);
    }

    /// `k = 5; a = f(x); f(k) + a + k * x` as the pipeline leaves it: the
    /// second call's argument and the multiply past that call each read
    /// a definition of their own, since the call clobbers what it read.
    #[test]
    fn a_reader_that_is_a_call_ends_the_run() {
        let call = |args: Vec<ValueId>| Inst::Call {
            target_pc: 2,
            args,
            fixed_args: 1,
            fp_return: false,
            fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
            low_word_args: 0,
            arg_widths: crate::c5::ir::ArgWidths::default(),
            arg_aggs: Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        };
        let mul = |lhs, rhs| Inst::Binop {
            op: crate::c5::ir::BinOp::Mul,
            lhs,
            rhs,
        };
        let mut f = func_with(
            vec![
                Inst::AllocaInit(0),
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::Imm(0),
                Inst::Imm(5),
                Inst::Imm(0),
                Inst::Imm(0),
                call(vec![1]),
                Inst::Imm(0),
                Inst::Imm(0),
                call(vec![3]),
                Inst::Imm(0),
                add(9, 6),
                Inst::Imm(0),
                Inst::Imm(0),
                mul(3, 1),
                add(11, 14),
            ],
            vec![block(0..16, Terminator::Return(15))],
        );
        split_across_calls(&mut f, Target::LinuxX64);
        assert_eq!(imms(&f, 5), vec![3, 9, 15], "{:?}", f.insts);
        assert!(matches!(&f.insts[10], Inst::Call { args, .. } if args == &[9]));
        assert!(matches!(
            f.insts[16],
            Inst::Binop {
                lhs: 15,
                rhs: 1,
                ..
            }
        ));
    }

    /// A call reading the value as an argument is a use ahead of the
    /// call, not past it.
    #[test]
    fn a_call_argument_is_read_ahead_of_the_call() {
        let mut f = func_with(
            vec![Inst::Imm(5), call_of(vec![0]), call_of(vec![0])],
            vec![block(0..3, Terminator::Return(NO_VALUE))],
        );
        split_across_calls(&mut f, Target::LinuxAarch64);
        assert_eq!(imms(&f, 5), vec![0, 2]);
        assert!(matches!(&f.insts[1], Inst::CallExt { args, .. } if args == &[0]));
        assert!(matches!(&f.insts[3], Inst::CallExt { args, .. } if args == &[2]));
    }

    /// Two-block shape: `b0: k; call; branch` -- `b1: store k`, `b2: store k`.
    fn branch_after_call(call_in_b1: bool) -> FunctionSsa {
        let mut insts = vec![Inst::Imm(5), Inst::Imm(1), call_of(vec![])];
        let b1_start = insts.len() as u32;
        if call_in_b1 {
            insts.push(call_of(vec![]));
        }
        insts.push(store_of(0));
        let b2_start = insts.len() as u32;
        insts.push(store_of(0));
        let end = insts.len() as u32;
        func_with(
            insts,
            vec![
                block(
                    0..b1_start,
                    Terminator::Bz {
                        cond: 1,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(b1_start..b2_start, Terminator::Return(NO_VALUE)),
                block(b2_start..end, Terminator::Return(NO_VALUE)),
            ],
        )
    }

    /// A use in a block entered past the call reads its own definition
    /// there; the block's calls ahead of the use count the same way.
    #[test]
    fn a_use_in_a_block_past_the_call_reads_its_own_definition() {
        for call_in_b1 in [false, true] {
            let mut f = branch_after_call(call_in_b1);
            split_across_calls(&mut f, Target::LinuxAarch64);
            let new = imms(&f, 5);
            assert_eq!(new.len(), 3, "{call_in_b1}: {:?}", f.insts);
            let s1 = f.blocks[1].inst_range.end - 1;
            let s2 = f.blocks[2].inst_range.end - 1;
            assert_eq!(stored(&f, s1), new[1]);
            assert_eq!(stored(&f, s2), new[2]);
            assert!(f.blocks[1].inst_range.contains(&new[1]));
            assert!(f.blocks[2].inst_range.contains(&new[2]));
        }
    }

    /// `b0: k; call; store k; branch` -- `b1: store k; branch` -- `b2:
    /// store k`, each block the next one's only predecessor: one
    /// definition ahead of the first store serves all three, and a call
    /// in `b1` splits the chain there.
    #[test]
    fn a_run_reaches_along_a_chain_of_single_predecessor_blocks() {
        for call_in_b1 in [false, true] {
            let mut insts = vec![Inst::Imm(5), call_of(vec![]), store_of(0), Inst::Imm(1)];
            let b1 = insts.len() as u32;
            if call_in_b1 {
                insts.push(call_of(vec![]));
            }
            insts.extend([store_of(0), Inst::Imm(1)]);
            let b2 = insts.len() as u32;
            insts.push(store_of(0));
            let end = insts.len() as u32;
            let branch = |cond: ValueId, next: BlockId| Terminator::Bz {
                cond,
                target: 3,
                fall_through: next,
            };
            let mut f = func_with(
                insts,
                vec![
                    block(0..b1, branch(3, 1)),
                    block(b1..b2, branch(b2 - 1, 2)),
                    block(b2..end, Terminator::Return(NO_VALUE)),
                    block(end..end, Terminator::Return(NO_VALUE)),
                ],
            );
            split_across_calls(&mut f, Target::LinuxAarch64);
            let new = imms(&f, 5);
            let stores: Vec<ValueId> = (0..f.insts.len() as ValueId)
                .filter(|&i| matches!(f.insts[i as usize], Inst::StoreLocal { .. }))
                .map(|i| stored(&f, i))
                .collect();
            if call_in_b1 {
                assert_eq!(new.len(), 3, "{:?}", f.insts);
                assert_eq!(stores, vec![new[1], new[2], new[2]]);
            } else {
                assert_eq!(new.len(), 2, "{:?}", f.insts);
                assert_eq!(stores, vec![new[1]; 3]);
            }
        }
    }

    /// `b0: k; branch` -- `b1: call; store k` -- `b2: store k`: only the
    /// branch with the call reads a new definition.
    #[test]
    fn a_use_no_path_reaches_past_a_call_keeps_the_original() {
        let mut f = func_with(
            vec![
                Inst::Imm(5),
                Inst::Imm(1),
                call_of(vec![]),
                store_of(0),
                store_of(0),
            ],
            vec![
                block(
                    0..2,
                    Terminator::Bz {
                        cond: 1,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(2..4, Terminator::Return(NO_VALUE)),
                block(4..5, Terminator::Return(NO_VALUE)),
            ],
        );
        split_across_calls(&mut f, Target::LinuxAarch64);
        assert_eq!(imms(&f, 5), vec![0, 3]);
        assert_eq!(stored(&f, 4), 3);
        assert_eq!(stored(&f, 5), 0);
    }

    /// `b0: k` -- `b1 (loop): call; store k; branch back`: the run in
    /// the loop keeps the original, and so does the use after the loop.
    #[test]
    fn a_reached_run_in_a_loop_keeps_the_whole_value() {
        let mut f = func_with(
            vec![
                Inst::Imm(5),
                call_of(vec![]),
                store_of(0),
                Inst::Imm(1),
                store_of(0),
            ],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(
                    1..4,
                    Terminator::Bnz {
                        cond: 3,
                        target: 1,
                        fall_through: 2,
                    },
                ),
                block(4..5, Terminator::Return(NO_VALUE)),
            ],
        );
        let before = f.insts.len();
        split_across_calls(&mut f, Target::LinuxAarch64);
        assert_eq!(f.insts.len(), before);
    }

    /// `b0: k; call; branch` -- `b1: k2` -- `b2: phi(k from b0, k2 from
    /// b1)`: the income from `b0` reads a definition at `b0`'s end, after
    /// the call, ahead of the branch condition.
    #[test]
    fn a_phi_income_past_a_call_reads_a_definition_at_the_block_end() {
        let mut f = func_with(
            vec![
                Inst::Imm(5),
                call_of(vec![]),
                Inst::Imm(1),
                Inst::Imm(6),
                phi(vec![(0, 0), (1, 3)]),
            ],
            vec![
                block(
                    0..3,
                    Terminator::Bz {
                        cond: 2,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(3..4, Terminator::Jmp(2)),
                block(4..5, Terminator::Return(4)),
            ],
        );
        split_across_calls(&mut f, Target::LinuxAarch64);
        assert_eq!(imms(&f, 5), vec![0, 2]);
        assert_eq!(f.blocks[0].inst_range, 0..4);
        assert!(matches!(f.insts[3], Inst::Imm(1)));
        let Inst::Phi { incoming, .. } = &f.insts[5] else {
            panic!("{:?}", f.insts[5]);
        };
        assert_eq!(incoming, &[(0, 2), (1, 4)]);
    }

    /// `b0: k; call; branch` -- `b1: k2` -- `b3: (empty)` -- `b2: phi(k
    /// from b3, k2 from b1)`: the income on the split edge reads a
    /// definition placed into the empty block.
    #[test]
    fn a_phi_income_through_an_empty_block_reads_a_definition_there() {
        let mut f = func_with(
            vec![
                Inst::Imm(5),
                call_of(vec![]),
                Inst::Imm(6),
                phi(vec![(3, 0), (1, 2)]),
            ],
            vec![
                block(
                    0..2,
                    Terminator::Bz {
                        cond: 1,
                        target: 3,
                        fall_through: 1,
                    },
                ),
                block(2..3, Terminator::Jmp(2)),
                block(3..4, Terminator::Return(3)),
                block(3..3, Terminator::Jmp(2)),
            ],
        );
        split_across_calls(&mut f, Target::LinuxAarch64);
        assert_eq!(imms(&f, 5), vec![0, 3]);
        assert_eq!(f.blocks[3].inst_range, 3..4);
        assert_eq!(f.blocks[2].inst_range, 4..5);
        let Inst::Phi { incoming, .. } = &f.insts[4] else {
            panic!("{:?}", f.insts[4]);
        };
        assert_eq!(incoming, &[(3, 3), (1, 2)]);
    }

    /// A branch on `k` and the income through its empty successor read at one index; the branch,
    /// which runs first, takes the definition.
    #[test]
    fn a_branch_ahead_of_an_empty_successor_takes_the_definition() {
        let mut f = func_with(
            vec![
                Inst::ImmData(16),
                call_of(vec![]),
                Inst::Imm(3),
                phi(vec![(1, 2), (2, 0)]),
            ],
            vec![
                block(0..2, Terminator::Jmp(1)),
                block(
                    2..3,
                    Terminator::Bz {
                        cond: 0,
                        target: 3,
                        fall_through: 2,
                    },
                ),
                block(3..3, Terminator::Jmp(3)),
                block(3..4, Terminator::Return(3)),
            ],
        );
        split_across_calls(&mut f, Target::LinuxAarch64);
        assert_eq!(super::super::verify::check(&f), Ok(()), "{:?}", f.blocks);
        let Terminator::Bz { cond, .. } = f.blocks[1].terminator else {
            panic!("{:?}", f.blocks[1].terminator);
        };
        assert!(f.blocks[1].inst_range.contains(&cond), "{:?}", f.blocks);
        assert!(matches!(f.insts[cond as usize], Inst::ImmData(16)));
        let Inst::Phi { incoming, .. } = &f.insts[f.blocks[3].inst_range.start as usize] else {
            panic!("{:?}", f.insts);
        };
        assert_eq!(incoming[1], (2, cond));
    }

    /// `k; call; return k`: the return reads a definition after the
    /// call, the block's last instruction, and `exit_acc` follows.
    #[test]
    fn a_returned_value_past_a_call_reads_a_definition_after_it() {
        let mut f = func_with(
            vec![Inst::Imm(7), call_of(vec![])],
            vec![block(0..2, Terminator::Return(0))],
        );
        f.blocks[0].exit_acc = 0;
        split_across_calls(&mut f, Target::LinuxAarch64);
        assert_eq!(imms(&f, 7), vec![0, 2]);
        assert_eq!(f.blocks[0].inst_range, 0..3);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(2)));
        assert_eq!(f.blocks[0].exit_acc, 2);
    }

    /// `p = &tab[1]`, an `ImmData` plus a folded 8, read past a call: the
    /// two instructions are set again together ahead of the use, the add
    /// over the new address, and the address's binding rides along. A
    /// folded immediate the target builds in a register is no chain.
    #[test]
    fn an_address_with_a_folded_offset_is_set_again_as_a_chain() {
        let plus = |lhs, rhs_imm| Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm,
        };
        let mut f = func_with(
            vec![Inst::ImmData(8), plus(0, 8), call_of(vec![]), store_of(1)],
            vec![block(0..4, Terminator::Return(NO_VALUE))],
        );
        f.extern_imm_data_refs = vec![(0, 4)];
        split_across_calls(&mut f, Target::LinuxAarch64);
        assert!(matches!(f.insts[3], Inst::ImmData(8)), "{:?}", f.insts);
        assert!(matches!(
            f.insts[4],
            Inst::BinopI {
                lhs: 3,
                rhs_imm: 8,
                ..
            }
        ));
        assert_eq!(stored(&f, 5), 4);
        assert_eq!(f.extern_imm_data_refs, vec![(0, 4), (3, 4)]);
        let mut g = func_with(
            vec![
                Inst::ImmData(8),
                plus(0, 1 << 40),
                call_of(vec![]),
                store_of(1),
            ],
            vec![block(0..4, Terminator::Return(NO_VALUE))],
        );
        split_across_calls(&mut g, Target::LinuxAarch64);
        assert_eq!(g.insts.len(), 4);
    }

    /// A bound data address set again carries its binding.
    #[test]
    fn a_bound_address_set_again_carries_its_binding() {
        let mut f = func_with(
            vec![Inst::ImmData(8), call_of(vec![]), store_of(0)],
            vec![block(0..3, Terminator::Return(NO_VALUE))],
        );
        f.extern_imm_data_refs = vec![(0, 4)];
        split_across_calls(&mut f, Target::LinuxX64);
        assert!(matches!(f.insts[2], Inst::ImmData(8)));
        assert_eq!(f.extern_imm_data_refs, vec![(0, 4), (2, 4)]);
    }

    /// A TLS address is a call on Mach-O AArch64, where it stays; on
    /// Linux it is set again like an address.
    #[test]
    fn a_tls_address_is_set_again_where_its_lowering_is_no_call() {
        let build = || {
            func_with(
                vec![Inst::TlsAddr(0), call_of(vec![]), store_of(0)],
                vec![block(0..3, Terminator::Return(NO_VALUE))],
            )
        };
        let mut linux = build();
        split_across_calls(&mut linux, Target::LinuxAarch64);
        assert_eq!(linux.insts.len(), 4);
        let mut macos = build();
        split_across_calls(&mut macos, Target::MacOSAarch64);
        assert_eq!(macos.insts.len(), 3);
    }

    /// A reader the emit skips keeps no value live, so it plans nothing;
    /// a floating phi rebuilds a constant income on the edge, so that
    /// income is no use either.
    #[test]
    fn an_unread_reader_and_a_rebuilt_income_plan_nothing() {
        let mut f = func_with(
            vec![Inst::Imm(5), call_of(vec![]), add(0, 0)],
            vec![block(0..3, Terminator::Return(NO_VALUE))],
        );
        split_across_calls(&mut f, Target::LinuxAarch64);
        assert_eq!(f.insts.len(), 3);
        let mut g = func_with(
            vec![
                Inst::Imm(5),
                call_of(vec![]),
                Inst::Phi {
                    incoming: vec![(0, 0)],
                    kind: LoadKind::F64,
                },
            ],
            vec![
                block(0..2, Terminator::Jmp(1)),
                block(2..3, Terminator::Return(2)),
            ],
        );
        split_across_calls(&mut g, Target::LinuxAarch64);
        assert_eq!(g.insts.len(), 3);
    }
}

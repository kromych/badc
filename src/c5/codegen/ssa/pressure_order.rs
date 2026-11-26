//! Reordering a block's instructions to lower the number of values live at
//! once where it passes a register bank's capacity.
//!
//! An unrolled body that issues every lane's loads, then every lane's first
//! operation, then every lane's second, keeps all the lanes' intermediates
//! live together, and the allocator spills what the bank cannot hold. Where
//! a block's peak passes the capacity, each run of instructions that may move
//! -- pure ones, which no store, call or other effect separates -- is placed
//! anew bottom-up: of the instructions whose readers in the run are placed,
//! the one that adds the fewest live values to the full banks goes next, and
//! among equals the one a just-placed instruction reads, which keeps one
//! chain together. An end-of-lifetime marker goes behind its run, which only
//! lengthens the object's lifetime. The order is kept only where it lowers
//! the block's peak in a full bank.

use alloc::vec;
use alloc::vec::Vec;

use super::liveness::BlockLiveness;
use super::reg_alloc::{
    BankCapacity, compute_use_counts, for_each_operand, operands_read, produces_fp_result,
    produces_pred_result, produces_value,
};
use crate::c5::ir::{BlockId, FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};

/// A bank index per value: 0 integer, 1 floating-point and vector.
const NO_BANK: u8 = u8::MAX;

/// Reorder the blocks of `func` whose peak passes `capacity`, where a new
/// order lowers it. Returns whether any block changed.
pub(crate) fn lower_peaks(func: &mut FunctionSsa, capacity: BankCapacity) -> bool {
    let n = func.insts.len();
    let use_counts = compute_use_counts(func);
    let reads = operands_read(func, &use_counts);
    let liveness = BlockLiveness::compute_reading(func, &reads);
    let bank: Vec<u8> = (func.insts.iter())
        .map(|i| match (produces_value(i), produces_fp_result(i)) {
            (false, _) => NO_BANK,
            _ if produces_pred_result(i) => NO_BANK,
            (true, fp) => u8::from(fp),
        })
        .collect();
    let cx = Cx {
        func,
        reads: &reads,
        bank: &bank,
    };
    let mut order: Vec<ValueId> = (0..n as ValueId).collect();
    let mut live = Live::new(n);
    let mut changed = false;
    for (b, blk) in func.blocks.iter().enumerate() {
        let (lo, hi) = (blk.inst_range.start as usize, blk.inst_range.end as usize);
        if hi - lo < 2 || hi > n {
            continue;
        }
        let at_end = |live: &mut Live| {
            live.reset();
            liveness.for_each_live_out(b as BlockId, |v| live.add(v, &bank));
            blk.terminator.for_each_operand(|v| live.add(v, &bank));
        };
        let old: Vec<ValueId> = (lo as ValueId..hi as ValueId).collect();
        at_end(&mut live);
        let end = live.count;
        let before = cx.peak(&old, &mut live);
        // No order holds fewer than the values live at the block's ends.
        let floor = [end[0].max(live.count[0]), end[1].max(live.count[1])];
        let full = [0, 1].map(|k| before[k] > capacity.total[k] && before[k] > floor[k]);
        if !full.contains(&true) {
            continue;
        }
        at_end(&mut live);
        let new = cx.schedule(&old, &blk.terminator, &mut live, full);
        at_end(&mut live);
        let after = cx.peak(&new, &mut live);
        let lower = (0..2).any(|k| full[k] && after[k] < before[k]);
        let higher = (0..2).any(|k| after[k] > before[k].max(capacity.total[k]));
        if lower && !higher {
            order[lo..hi].copy_from_slice(&new);
            changed = true;
        }
    }
    if changed {
        super::tape::reorder(func, &order);
    }
    changed
}

struct Cx<'a> {
    func: &'a FunctionSsa,
    reads: &'a [bool],
    bank: &'a [u8],
}

/// The values live at a point and their count per bank.
struct Live {
    on: Vec<bool>,
    touched: Vec<ValueId>,
    count: [u32; 2],
}

impl Live {
    fn new(n: usize) -> Self {
        Live {
            on: vec![false; n],
            touched: Vec::new(),
            count: [0; 2],
        }
    }

    fn reset(&mut self) {
        for &v in &self.touched {
            self.on[v as usize] = false;
        }
        self.touched.clear();
        self.count = [0; 2];
    }

    fn has(&self, v: ValueId) -> bool {
        self.on.get(v as usize).copied().unwrap_or(false)
    }

    fn add(&mut self, v: ValueId, bank: &[u8]) {
        let Some(&k) = bank.get(v as usize) else {
            return;
        };
        if k == NO_BANK || self.on[v as usize] {
            return;
        }
        self.on[v as usize] = true;
        self.touched.push(v);
        self.count[k as usize] += 1;
    }

    fn remove(&mut self, v: ValueId, bank: &[u8]) {
        if self.has(v) {
            self.on[v as usize] = false;
            self.count[bank[v as usize] as usize] -= 1;
        }
    }
}

impl Cx<'_> {
    /// Whether instruction `v` belongs to a run: one that may move within
    /// it, or an end-of-lifetime marker, which goes behind it.
    fn movable(&self, v: ValueId) -> bool {
        let inst = &self.func.insts[v as usize];
        inst.is_lifetime_marker()
            || (self.func.is_pure(inst)
                && !matches!(
                    inst,
                    Inst::ParamPart { .. } | Inst::RetPart { .. } | Inst::AsmOut { .. }
                ))
    }

    /// Pass `v` walking up: its value is no longer live above it, and the
    /// operands it reads are.
    fn step_up(&self, v: ValueId, live: &mut Live) {
        live.remove(v, self.bank);
        let inst = &self.func.insts[v as usize];
        if !matches!(inst, Inst::Phi { .. }) && self.reads[v as usize] {
            for_each_operand(inst, |op| live.add(op, self.bank));
        }
    }

    /// The most values live per bank between the instructions of `seq`, with
    /// `live` holding those live after its last.
    fn peak(&self, seq: &[ValueId], live: &mut Live) -> [u32; 2] {
        let mut peak = live.count;
        for &v in seq.iter().rev() {
            self.step_up(v, live);
            peak = [peak[0].max(live.count[0]), peak[1].max(live.count[1])];
        }
        peak
    }

    /// The block `seq` in a new order, `live` holding the values live at
    /// its end. The instruction a conditional branch reads stays last, where
    /// the emitters fuse it into the branch.
    fn schedule(
        &self,
        seq: &[ValueId],
        exit: &Terminator,
        live: &mut Live,
        full: [bool; 2],
    ) -> Vec<ValueId> {
        let last = *seq.last().expect("a block of two or more");
        let pinned_last = matches!(exit,
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } if *cond == last);
        let mut out: Vec<ValueId> = Vec::with_capacity(seq.len());
        let mut end = seq.len();
        while end > 0 {
            let v = seq[end - 1];
            if !self.movable(v) || (pinned_last && v == last) {
                out.push(v);
                self.step_up(v, live);
                end -= 1;
                continue;
            }
            let mut start = end - 1;
            while start > 0 && self.movable(seq[start - 1]) {
                start -= 1;
            }
            out.extend(self.run(&seq[start..end], live, full));
            end = start;
        }
        out.reverse();
        out
    }

    /// One run of movable instructions placed bottom-up; returns them last
    /// first, with the markers of the run ahead, so behind it once reversed.
    fn run(&self, run: &[ValueId], live: &mut Live, full: [bool; 2]) -> Vec<ValueId> {
        let lo = run[0];
        let at = |v: ValueId| {
            v.checked_sub(lo)
                .map(|k| k as usize)
                .filter(|&k| k < run.len())
        };
        let mut out: Vec<ValueId> = run
            .iter()
            .copied()
            .filter(|&v| self.func.insts[v as usize].is_lifetime_marker())
            .rev()
            .collect();
        // Per instruction of the run, its readers in the run not yet placed,
        // and when the latest one was. Every operand orders, also one the
        // lowering folds and the allocator does not count.
        let mut waiting = vec![0u32; run.len()];
        let mut operands: Vec<Vec<ValueId>> = vec![Vec::new(); run.len()];
        for (k, &v) in run.iter().enumerate() {
            self.func.insts[v as usize].for_each_operand(|op| {
                if at(op).is_some() && !operands[k].contains(&op) {
                    operands[k].push(op);
                }
            });
            for &op in &operands[k] {
                waiting[at(op).expect("in the run")] += 1;
            }
        }
        let mut read_at = vec![0usize; run.len()];
        let mut ready: Vec<ValueId> = (run.iter().copied())
            .filter(|&v| !self.func.insts[v as usize].is_lifetime_marker())
            .filter(|&v| waiting[at(v).expect("in the run")] == 0)
            .collect();
        let mut time = 1usize;
        while !ready.is_empty() {
            let pick = (0..ready.len())
                .min_by_key(|&r| {
                    let v = ready[r];
                    let d = self.added(v, live);
                    let hot: i32 = (0..2).filter(|&k| full[k]).map(|k| d[k]).sum();
                    let cold: i32 = (0..2).filter(|&k| !full[k]).map(|k| d[k]).sum();
                    (
                        hot,
                        cold,
                        usize::MAX - read_at[at(v).expect("in the run")],
                        u32::MAX - v,
                    )
                })
                .expect("a ready instruction");
            let v = ready.swap_remove(pick);
            out.push(v);
            self.step_up(v, live);
            for &op in &operands[at(v).expect("in the run")] {
                let k = at(op).expect("in the run");
                read_at[k] = time;
                waiting[k] -= 1;
                if waiting[k] == 0 {
                    ready.push(op);
                }
            }
            time += 1;
        }
        debug_assert_eq!(out.len(), run.len(), "every instruction of the run placed");
        out
    }

    /// The live values per bank that placing `v` next, walking up, adds.
    fn added(&self, v: ValueId, live: &Live) -> [i32; 2] {
        let mut d = [0i32; 2];
        let bank = |x: ValueId| self.bank.get(x as usize).copied().unwrap_or(NO_BANK);
        if live.has(v) && bank(v) != NO_BANK {
            d[bank(v) as usize] -= 1;
        }
        let inst = &self.func.insts[v as usize];
        if self.reads[v as usize] {
            // An operand read twice counts once: the first reads up to 8.
            let mut seen = [NO_VALUE; 8];
            let mut k = 0;
            for_each_operand(inst, |op| {
                if live.has(op) || bank(op) == NO_BANK || seen[..k].contains(&op) {
                    return;
                }
                if k < seen.len() {
                    seen[k] = op;
                    k += 1;
                }
                d[bank(op) as usize] += 1;
            });
        }
        d
    }
}

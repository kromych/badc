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

/// A ready instruction's priority, least first: the live values it adds to
/// the full banks and to the others, the latest time a reader of it was
/// placed (inverted), and its id (inverted, the later first).
type Key = (i32, i32, usize, u32);

/// Reorder the blocks of `func` whose peak passes `capacity`, where a new
/// order lowers it. Returns whether any block changed.
pub(crate) fn lower_peaks(func: &mut FunctionSsa, capacity: BankCapacity) -> bool {
    lower_peaks_counting(func, capacity).0
}

/// [`lower_peaks`], and how many priorities its runs computed.
fn lower_peaks_counting(func: &mut FunctionSsa, capacity: BankCapacity) -> (bool, usize) {
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
        keys: core::cell::Cell::new(0),
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
    let keys = cx.keys.get();
    if changed {
        super::tape::reorder(func, &order);
    }
    (changed, keys)
}

struct Cx<'a> {
    func: &'a FunctionSsa,
    reads: &'a [bool],
    bank: &'a [u8],
    keys: core::cell::Cell<usize>,
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
    /// An instruction's key only falls once its readers are placed: its
    /// value stays live, and an operand, once live, stays live until its
    /// own definition, which waits for this reader. So the ready ones sit in
    /// a heap, an entry pushed anew whenever an operand of one turns live,
    /// and the run costs O(e log e) in its operand reads.
    fn run(&self, run: &[ValueId], live: &mut Live, full: [bool; 2]) -> Vec<ValueId> {
        use alloc::collections::BinaryHeap;
        use core::cmp::Reverse;
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
        // The run's instructions reading each value the allocator counts.
        let mut readers: hashbrown::HashMap<ValueId, Vec<u32>> = hashbrown::HashMap::new();
        for (k, &v) in run.iter().enumerate() {
            let inst = &self.func.insts[v as usize];
            inst.for_each_operand(|op| {
                if at(op).is_some() && !operands[k].contains(&op) {
                    operands[k].push(op);
                }
            });
            for &op in &operands[k] {
                waiting[at(op).expect("in the run")] += 1;
            }
            if self.reads[v as usize] {
                for_each_operand(inst, |op| {
                    let list = readers.entry(op).or_default();
                    if list.last() != Some(&(k as u32)) {
                        list.push(k as u32);
                    }
                });
            }
        }
        let mut read_at = vec![0usize; run.len()];
        let mut key_now: Vec<Option<Key>> = vec![None; run.len()];
        let mut heap: BinaryHeap<Reverse<(Key, u32)>> = BinaryHeap::new();
        let key = |k: usize, live: &Live, read_at: &[usize]| -> Key {
            self.keys.set(self.keys.get() + 1);
            let v = run[k];
            let d = self.added(v, live);
            let hot: i32 = (0..2).filter(|&b| full[b]).map(|b| d[b]).sum();
            let cold: i32 = (0..2).filter(|&b| !full[b]).map(|b| d[b]).sum();
            (hot, cold, usize::MAX - read_at[k], u32::MAX - v)
        };
        for (k, &v) in run.iter().enumerate() {
            if waiting[k] == 0 && !self.func.insts[v as usize].is_lifetime_marker() {
                let kk = key(k, live, &read_at);
                key_now[k] = Some(kk);
                heap.push(Reverse((kk, k as u32)));
            }
        }
        let mut time = 1usize;
        while let Some(Reverse((kk, k))) = heap.pop() {
            let k = k as usize;
            if key_now[k] != Some(kk) {
                continue;
            }
            key_now[k] = None;
            let v = run[k];
            out.push(v);
            // Pass `v` walking up; each operand that turns live lowers the
            // key of the ready instructions reading it.
            live.remove(v, self.bank);
            let inst = &self.func.insts[v as usize];
            if self.reads[v as usize] {
                for_each_operand(inst, |op| {
                    if live.has(op) {
                        return;
                    }
                    live.add(op, self.bank);
                    for &r in readers.get(&op).map_or(&[][..], |l| &l[..]) {
                        let r = r as usize;
                        if key_now[r].is_some() {
                            let kr = key(r, live, &read_at);
                            key_now[r] = Some(kr);
                            heap.push(Reverse((kr, r as u32)));
                        }
                    }
                });
            }
            for &op in &operands[k] {
                let j = at(op).expect("in the run");
                read_at[j] = time;
                waiting[j] -= 1;
                if waiting[j] == 0 {
                    let kj = key(j, live, &read_at);
                    key_now[j] = Some(kj);
                    heap.push(Reverse((kj, j as u32)));
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

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{BinOp, Block, LoadKind, NO_VALUE, StoreKind};

    /// A run thousands of instructions wide costs priorities in proportion
    /// to its operand reads: one as an instruction turns ready and one as an
    /// operand of it turns live, not one per ready instruction at each step.
    /// N loads off one base, N additions each reading two of them, then N
    /// stores; the scan this replaced computed about N^2 / 2.
    #[test]
    fn a_wide_run_computes_priorities_in_proportion_to_its_reads() {
        let n: u32 = 4000;
        let mut insts = vec![Inst::ImmData(0x10)];
        for k in 0..n {
            insts.push(Inst::Load {
                addr: 0,
                disp: 8 * k as i32,
                kind: LoadKind::I64,
                volatile: false,
                align: 8,
                pc_rel: false,
            });
        }
        for k in 0..n {
            insts.push(Inst::Binop {
                op: BinOp::Add,
                lhs: 1 + k,
                rhs: 1 + (k * 7 + 1) % n,
            });
        }
        for k in 0..n {
            insts.push(Inst::Store {
                addr: 0,
                disp: 8 * k as i32,
                value: 1 + n + k,
                kind: StoreKind::I64,
                volatile: false,
                align: 8,
                pc_rel: false,
            });
        }
        let len = insts.len() as u32;
        let mut f = FunctionSsa {
            inst_src: vec![Default::default(); len as usize],
            f32_values: vec![false; len as usize],
            insts,
            blocks: vec![Block {
                start_pc: 0,
                inst_range: 0..len,
                terminator: Terminator::Return(NO_VALUE),
            }],
            ..Default::default()
        };
        let capacity = BankCapacity {
            total: [12, 12],
            callee: [6, 6],
        };
        let (changed, keys) = lower_peaks_counting(&mut f, capacity);
        assert!(changed, "the run's peak passes the bank");
        let reads = 4 * n as usize;
        assert!(keys <= 2 * (len as usize + reads), "{keys} priorities");
        super::super::verify::check(&f).expect("every value defined before it is read");
    }
}

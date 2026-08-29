//! Phi-aware block liveness and SSA value interference.
//!
//! Liveness is the standard backward dataflow over the control-flow
//! graph, with phi semantics modelled on the edges: a phi operand is
//! a use at the end of the corresponding predecessor (live-out of that
//! predecessor), and every phi result of a block is a definition at
//! that block's head -- one program point shared by all of them, since
//! one parallel copy per edge writes them together. This is the
//! lazy-copy view of out-of-SSA: the predecessor-exit move that
//! materialises a phi operand executes on the edge, so the operand is
//! live up to that edge and the result from the join onward.
//!
//! The interference query answers whether two SSA values are live at
//! the same program point. With one definition per value, two ranges
//! overlap iff one value's definition lies inside the other's live
//! range. The phi-congruence builder uses this to decide which phi
//! operands may share a register with the phi result.

use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{BlockId, FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};

/// Sentinel for a value outside the live-set universe.
const NO_RANK: u32 = u32::MAX;

/// Sentinel for a value covered by no block's `inst_range`.
const NO_BLOCK: BlockId = BlockId::MAX;

/// Ceiling on the words a dense live-set row array may occupy, 1 MiB
/// each. Every ordinary function stays far below it; past it the
/// `blocks * values / 64` area is the storage and the sweep cost alike,
/// and the per-value walk takes over.
const DENSE_WORD_BUDGET: usize = 1 << 17;

/// Group `(block, element)` pairs into one row per block. The pairs
/// arrive element-major, so the stable scatter leaves each row
/// ascending.
fn rows_by_block(nblocks: usize, pairs: &[(u32, u32)]) -> (Vec<u32>, Vec<u32>) {
    let mut off = vec![0u32; nblocks + 1];
    for &(b, _) in pairs {
        off[b as usize + 1] += 1;
    }
    for i in 0..nblocks {
        off[i + 1] += off[i];
    }
    let mut cur: Vec<u32> = off[..nblocks].to_vec();
    let mut dat = vec![0u32; pairs.len()];
    for &(b, e) in pairs {
        dat[cur[b as usize] as usize] = e;
        cur[b as usize] += 1;
    }
    (off, dat)
}

/// Counting sort of `(element, payload)` pairs into one row per
/// element, returned as CSR offsets plus the payloads.
fn rows_by_elem<T: Copy + Default>(nelems: usize, pairs: &[(u32, T)]) -> (Vec<u32>, Vec<T>) {
    let mut off = vec![0u32; nelems + 1];
    for &(e, _) in pairs {
        off[e as usize + 1] += 1;
    }
    for i in 0..nelems {
        off[i + 1] += off[i];
    }
    let mut cur: Vec<u32> = off[..nelems].to_vec();
    let mut dat = vec![T::default(); pairs.len()];
    for &(e, p) in pairs {
        dat[cur[e as usize] as usize] = p;
        cur[e as usize] += 1;
    }
    (off, dat)
}

/// Least fixed point of the backward liveness equations
///
///   live_out[b] = exit_seed[b] + U live_in[s] for s in succ(b)
///   live_in[b]  = use_seed[b] + (live_out[b] minus kill[b])
///
/// over an arbitrary element domain. The result is one ascending row of
/// element ids per block, so a membership query is a binary search and
/// an enumeration costs the row length.
///
/// Each element is walked back from its seed blocks until a killing
/// block stops the propagation, so the cost follows the (block, live
/// element) pairs the answer contains rather than the
/// `blocks * elements / 64` area a bit row per block sweeps whatever
/// the answer is. The area term is what grew faster than the function;
/// the walk pays a per-element and a per-solve overhead instead, so
/// [`BlockLiveness`] uses it only once the area outgrows the function.
pub(crate) struct SparseLive {
    in_off: Vec<u32>,
    in_rows: Vec<u32>,
    out_off: Vec<u32>,
    out_rows: Vec<u32>,
}

impl SparseLive {
    /// `use_seed` names blocks with an upward-exposed use, `exit_seed`
    /// blocks where the element is live on exit regardless of its
    /// successors (a phi operand consumed on the edge), and `kill` the
    /// blocks that define the element. All three are `(element, block)`
    /// pairs in any order; duplicates are ignored.
    pub(crate) fn solve(
        nelems: usize,
        nblocks: usize,
        graph: &super::mem2reg::SuccGraph,
        use_seed: &[(u32, BlockId)],
        exit_seed: &[(u32, BlockId)],
        kill: &[(u32, BlockId)],
    ) -> Self {
        let (use_off, use_dat) = rows_by_elem(nelems, use_seed);
        let (exit_off, exit_dat) = rows_by_elem(nelems, exit_seed);
        let (kill_off, kill_dat) = rows_by_elem(nelems, kill);
        // Per-block stamps: a block carries the element id it was last
        // marked for, so each (block, element) pair is recorded once
        // without clearing between elements.
        let mut in_stamp = vec![u32::MAX; nblocks];
        let mut out_stamp = vec![u32::MAX; nblocks];
        let mut kill_stamp = vec![u32::MAX; nblocks];
        let mut in_pairs: Vec<(u32, u32)> = Vec::new();
        let mut out_pairs: Vec<(u32, u32)> = Vec::new();
        let mut stack: Vec<BlockId> = Vec::new();
        for e in 0..nelems as u32 {
            for &b in &kill_dat[kill_off[e as usize] as usize..kill_off[e as usize + 1] as usize] {
                kill_stamp[b as usize] = e;
            }
            let mut mark_in = |b: BlockId, pairs: &mut Vec<(u32, u32)>, st: &mut Vec<BlockId>| {
                if in_stamp[b as usize] != e {
                    in_stamp[b as usize] = e;
                    pairs.push((b, e));
                    st.push(b);
                }
            };
            for &b in &use_dat[use_off[e as usize] as usize..use_off[e as usize + 1] as usize] {
                mark_in(b, &mut in_pairs, &mut stack);
            }
            for &b in &exit_dat[exit_off[e as usize] as usize..exit_off[e as usize + 1] as usize] {
                if out_stamp[b as usize] != e {
                    out_stamp[b as usize] = e;
                    out_pairs.push((b, e));
                    if kill_stamp[b as usize] != e {
                        mark_in(b, &mut in_pairs, &mut stack);
                    }
                }
            }
            while let Some(b) = stack.pop() {
                for &p in graph.preds_of(b) {
                    if out_stamp[p as usize] != e {
                        out_stamp[p as usize] = e;
                        out_pairs.push((p, e));
                        if kill_stamp[p as usize] != e {
                            mark_in(p, &mut in_pairs, &mut stack);
                        }
                    }
                }
            }
        }
        let (in_off, in_rows) = rows_by_block(nblocks, &in_pairs);
        let (out_off, out_rows) = rows_by_block(nblocks, &out_pairs);
        SparseLive {
            in_off,
            in_rows,
            out_off,
            out_rows,
        }
    }

    /// Elements live on entry to `b`, ascending.
    pub(crate) fn in_row(&self, b: BlockId) -> &[u32] {
        &self.in_rows[self.in_off[b as usize] as usize..self.in_off[b as usize + 1] as usize]
    }

    /// Elements live on exit from `b`, ascending.
    pub(crate) fn out_row(&self, b: BlockId) -> &[u32] {
        &self.out_rows[self.out_off[b as usize] as usize..self.out_off[b as usize + 1] as usize]
    }
}

/// Per-block live-in / live-out sets over the CFG.
///
/// The element domain is the set of values that cross a block
/// boundary: those referenced from a block other than the one defining
/// them, plus those a phi names on an incoming edge. Every other value
/// is defined and dies inside one block, so it can never appear in a
/// live-in or live-out set.
///
/// The sets are held one of two ways, chosen per function by
/// [`BlockLiveness::compute`]: a bit row per block, whose area is
/// `blocks * ceil(universe / 64)` words, or one ascending row of live
/// ranks per block. The bit rows are the compact and faster form while
/// that area stays within the function's own size; past it the area is
/// what grows faster than the function, and the rows -- which hold only
/// the pairs that are live -- take over.
pub(crate) struct BlockLiveness {
    /// Value id -> universe rank, `NO_RANK` outside the universe.
    rank: Vec<u32>,
    /// Rank -> value id; ascending, so rank order is value order.
    universe: Vec<ValueId>,
    live: LiveSets,
}

enum LiveSets {
    Dense {
        words: usize,
        live_in: Vec<u64>,
        live_out: Vec<u64>,
    },
    Sparse(SparseLive),
}

impl BlockLiveness {
    pub(crate) fn compute(func: &FunctionSsa) -> Self {
        let nblocks = func.blocks.len();
        let n = func.insts.len();
        // Universe: upward-exposed operands and phi-incoming values.
        let mut crossing = vec![false; n];
        for blk in &func.blocks {
            let (start, end) = (blk.inst_range.start, blk.inst_range.end);
            for idx in start..end {
                if let Inst::Phi { incoming, .. } = &func.insts[idx as usize] {
                    for (_, v) in incoming {
                        if *v != NO_VALUE && (*v as usize) < n {
                            crossing[*v as usize] = true;
                        }
                    }
                    continue;
                }
                super::reg_alloc::for_each_operand(&func.insts[idx as usize], |v| {
                    if v != NO_VALUE && (v < start || v >= end) && (v as usize) < n {
                        crossing[v as usize] = true;
                    }
                });
            }
            let mut mark = |v: ValueId| {
                if v != NO_VALUE && (v < start || v >= end) && (v as usize) < n {
                    crossing[v as usize] = true;
                }
            };
            if blk.exit_acc != NO_VALUE {
                mark(blk.exit_acc);
            }
            match &blk.terminator {
                Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => mark(*cond),
                Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. }
                    if *target != NO_VALUE =>
                {
                    mark(*target)
                }
                Terminator::Return(v) if *v != NO_VALUE => mark(*v),
                _ => {}
            }
        }
        let mut rank: Vec<u32> = vec![NO_RANK; n];
        let mut universe: Vec<ValueId> = Vec::new();
        for (v, &c) in crossing.iter().enumerate() {
            if c {
                rank[v] = universe.len() as u32;
                universe.push(v as ValueId);
            }
        }
        let words = universe.len().div_ceil(64).max(1);
        let graph = super::mem2reg::SuccGraph::new(func);
        // The bit rows cost their whole area whatever is live, so they
        // stay only while that area is within the budget.
        let live = if nblocks.saturating_mul(words) <= DENSE_WORD_BUDGET {
            Self::solve_dense(func, &graph, &rank, words)
        } else {
            LiveSets::Sparse(Self::solve_sparse(func, &graph, &rank, universe.len()))
        };
        Self {
            rank,
            universe,
            live,
        }
    }

    /// Backward dataflow over one bit row per block, off a postorder
    /// worklist: a block is revisited only when a successor's live-in
    /// grew, so the iteration count tracks loop depth rather than the
    /// block count.
    ///   live_out[b] = phi_live_out[b] | U live_in[succ];
    ///   live_in[b]  = used_set[b] | (live_out[b] & ~kill[b]).
    fn solve_dense(
        func: &FunctionSsa,
        graph: &super::mem2reg::SuccGraph,
        rank: &[u32],
        words: usize,
    ) -> LiveSets {
        let nblocks = func.blocks.len();
        if nblocks == 0 {
            return LiveSets::Dense {
                words,
                live_in: Vec::new(),
                live_out: Vec::new(),
            };
        }
        let set = |bits: &mut [u64], base: usize, r: u32| {
            bits[base + (r as usize) / 64] |= 1u64 << ((r as usize) % 64);
        };
        // used_set: universe values referenced in a block but defined
        // outside it. kill: universe values defined in the block.
        // phi_live_out: per-predecessor phi-operand values that must be
        // live at that predecessor's exit.
        let mut used_set = vec![0u64; nblocks * words];
        let mut kill = vec![0u64; nblocks * words];
        let mut phi_live_out = vec![0u64; nblocks * words];
        for (b, blk) in func.blocks.iter().enumerate() {
            let base = b * words;
            let (start, end) = (blk.inst_range.start, blk.inst_range.end);
            for v in start..end {
                if let Some(&r) = rank.get(v as usize)
                    && r != NO_RANK
                {
                    set(&mut kill, base, r);
                }
            }
            let mut mark = |v: ValueId| {
                if v != NO_VALUE
                    && (v < start || v >= end)
                    && let Some(&r) = rank.get(v as usize)
                    && r != NO_RANK
                {
                    set(&mut used_set, base, r);
                }
            };
            for idx in start..end {
                if let Inst::Phi { incoming, .. } = &func.insts[idx as usize] {
                    for (pred, v) in incoming {
                        if *v != NO_VALUE
                            && let Some(&r) = rank.get(*v as usize)
                            && r != NO_RANK
                        {
                            set(&mut phi_live_out, (*pred as usize) * words, r);
                        }
                    }
                    continue;
                }
                super::reg_alloc::for_each_operand(&func.insts[idx as usize], &mut mark);
            }
            Self::for_each_exit_use(blk, &mut mark);
        }
        let mut live_in = vec![0u64; nblocks * words];
        let mut live_out = vec![0u64; nblocks * words];
        let mut scratch = vec![0u64; words];
        let mut worklist = graph.backward_worklist();
        let mut queued = vec![true; nblocks];
        while let Some(bb) = worklist.pop() {
            let b = bb as usize;
            queued[b] = false;
            let base = b * words;
            scratch.iter_mut().for_each(|w| *w = 0);
            for &s in graph.of(bb) {
                let sb = s as usize * words;
                for w in 0..words {
                    scratch[w] |= live_in[sb + w];
                }
            }
            let mut changed = false;
            for w in 0..words {
                scratch[w] |= phi_live_out[base + w];
                live_out[base + w] = scratch[w];
                let ni = used_set[base + w] | (scratch[w] & !kill[base + w]);
                if ni != live_in[base + w] {
                    live_in[base + w] = ni;
                    changed = true;
                }
            }
            if changed {
                for &p in graph.preds_of(bb) {
                    if !queued[p as usize] {
                        queued[p as usize] = true;
                        worklist.push(p);
                    }
                }
            }
        }
        LiveSets::Dense {
            words,
            live_in,
            live_out,
        }
    }

    /// The same fixed point solved per value over the seed lists the
    /// scan below collects.
    fn solve_sparse(
        func: &FunctionSsa,
        graph: &super::mem2reg::SuccGraph,
        rank: &[u32],
        nelems: usize,
    ) -> SparseLive {
        // Kill: the block defining each universe value. A value covered
        // by no block's `inst_range` (an instruction orphaned by branch
        // folding) has none, so nothing stops its propagation -- the
        // same answer the dense rows give, whose kill set only ever held
        // values a block covers.
        let mut kill: Vec<(u32, BlockId)> = Vec::new();
        let mut exit_seed: Vec<(u32, BlockId)> = Vec::new();
        for (b, blk) in func.blocks.iter().enumerate() {
            for v in blk.inst_range.clone() {
                if let Some(&r) = rank.get(v as usize)
                    && r != NO_RANK
                {
                    kill.push((r, b as BlockId));
                }
            }
            for idx in blk.inst_range.clone() {
                let Inst::Phi { incoming, .. } = &func.insts[idx as usize] else {
                    continue;
                };
                for (pred, v) in incoming {
                    if *v != NO_VALUE
                        && let Some(&r) = rank.get(*v as usize)
                        && r != NO_RANK
                    {
                        exit_seed.push((r, *pred));
                    }
                }
            }
        }
        // An upward-exposed use makes the value live-in at its block;
        // `seen` stamps dedup the uses within one block.
        let mut use_seed: Vec<(u32, BlockId)> = Vec::new();
        let mut seen: Vec<u32> = vec![u32::MAX; nelems];
        for (b, blk) in func.blocks.iter().enumerate() {
            let (start, end) = (blk.inst_range.start, blk.inst_range.end);
            let mut mark = |v: ValueId| {
                if v != NO_VALUE
                    && (v < start || v >= end)
                    && let Some(&r) = rank.get(v as usize)
                    && r != NO_RANK
                    && seen[r as usize] != b as u32
                {
                    seen[r as usize] = b as u32;
                    use_seed.push((r, b as BlockId));
                }
            };
            for idx in start..end {
                if matches!(func.insts[idx as usize], Inst::Phi { .. }) {
                    continue;
                }
                super::reg_alloc::for_each_operand(&func.insts[idx as usize], &mut mark);
            }
            Self::for_each_exit_use(blk, &mut mark);
        }
        SparseLive::solve(
            nelems,
            func.blocks.len(),
            graph,
            &use_seed,
            &exit_seed,
            &kill,
        )
    }

    /// The values a block reads at its exit: the accumulator and the
    /// terminator's operand.
    fn for_each_exit_use(blk: &super::super::ir::Block, mut mark: impl FnMut(ValueId)) {
        if blk.exit_acc != NO_VALUE {
            mark(blk.exit_acc);
        }
        match &blk.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => mark(*cond),
            Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. }
                if *target != NO_VALUE =>
            {
                mark(*target)
            }
            Terminator::Return(v) if *v != NO_VALUE => mark(*v),
            _ => {}
        }
    }

    pub(crate) fn live_in(&self, b: BlockId, v: ValueId) -> bool {
        match self.rank.get(v as usize) {
            Some(&r) if r != NO_RANK => match &self.live {
                LiveSets::Dense { words, live_in, .. } => is_set(live_in, b as usize * words, r),
                LiveSets::Sparse(s) => s.in_row(b).binary_search(&r).is_ok(),
            },
            _ => false,
        }
    }

    pub(crate) fn live_out(&self, b: BlockId, v: ValueId) -> bool {
        match self.rank.get(v as usize) {
            Some(&r) if r != NO_RANK => match &self.live {
                LiveSets::Dense {
                    words, live_out, ..
                } => is_set(live_out, b as usize * words, r),
                LiveSets::Sparse(s) => s.out_row(b).binary_search(&r).is_ok(),
            },
            _ => false,
        }
    }

    /// Every value live on exit from `b`, in ascending value order.
    pub(crate) fn for_each_live_out(&self, b: BlockId, mut f: impl FnMut(ValueId)) {
        match &self.live {
            LiveSets::Dense {
                words, live_out, ..
            } => {
                let base = b as usize * words;
                for w in 0..*words {
                    let mut bits = live_out[base + w];
                    while bits != 0 {
                        let r = w * 64 + bits.trailing_zeros() as usize;
                        f(self.universe[r]);
                        bits &= bits - 1;
                    }
                }
            }
            LiveSets::Sparse(s) => {
                for &r in s.out_row(b) {
                    f(self.universe[r as usize]);
                }
            }
        }
    }
}

fn is_set(bits: &[u64], base: usize, r: u32) -> bool {
    bits[base + (r as usize) / 64] & (1u64 << ((r as usize) % 64)) != 0
}

pub(crate) struct Liveness {
    /// Per-block live-in / live-out sets over the values that cross a
    /// block boundary.
    blocks: BlockLiveness,
    /// Defining block per value, `NO_BLOCK` for a value covered by no
    /// block's `inst_range`.
    block_of: Vec<BlockId>,
    /// Last program position at which each value is used, excluding phi
    /// operands (which are edge uses): the instruction index of its
    /// latest non-phi operand use, or the defining block's
    /// `inst_range.end` for a terminator use. `0` when never used.
    /// Drives the O(1) `block_has_use_after` query.
    last_use_pos: Vec<u32>,
}

impl Liveness {
    pub(crate) fn compute(func: &FunctionSsa) -> Self {
        let n = func.insts.len();

        let mut block_of: Vec<BlockId> = vec![NO_BLOCK; n];
        for (b, blk) in func.blocks.iter().enumerate() {
            for v in blk.inst_range.clone() {
                block_of[v as usize] = b as BlockId;
            }
        }

        // Latest non-phi use position per value (see `last_use_pos`).
        let mut last_use_pos: Vec<u32> = vec![0; n];
        for blk in &func.blocks {
            for idx in blk.inst_range.clone() {
                if matches!(func.insts[idx as usize], Inst::Phi { .. }) {
                    continue;
                }
                super::reg_alloc::for_each_operand(&func.insts[idx as usize], |op| {
                    if (op as usize) < n && last_use_pos[op as usize] < idx {
                        last_use_pos[op as usize] = idx;
                    }
                });
            }
            let term_pos = blk.inst_range.end;
            let mut term_use = |v: ValueId| {
                if v != NO_VALUE && (v as usize) < n && last_use_pos[v as usize] < term_pos {
                    last_use_pos[v as usize] = term_pos;
                }
            };
            match &blk.terminator {
                Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => term_use(*cond),
                Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. } => {
                    term_use(*target)
                }
                Terminator::Return(v) => term_use(*v),
                Terminator::Jmp(_)
                | Terminator::TailExt(_)
                | Terminator::FallThrough(_)
                | Terminator::AsmGoto { .. }
                | Terminator::Unreachable => {}
            }
        }

        let blocks = BlockLiveness::compute(func);

        Self {
            blocks,
            block_of,
            last_use_pos,
        }
    }

    /// The block-level live-in / live-out sets this analysis solved, for
    /// a caller that needs them directly rather than through a query.
    pub(crate) fn block_liveness(&self) -> &BlockLiveness {
        &self.blocks
    }

    /// Whether `v` is covered by some block's `inst_range`, i.e. whether
    /// it is part of the tape the emit walks. `prune_unreachable` deletes
    /// a block orphaned by a folded branch and leaves its instructions in
    /// `insts`, rewritten to inert immediates; those are covered by no
    /// block and carry no live range.
    pub(crate) fn in_cfg(&self, v: ValueId) -> bool {
        matches!(self.block_of.get(v as usize), Some(&b) if b != NO_BLOCK)
    }

    fn live_in(&self, b: BlockId, v: ValueId) -> bool {
        self.blocks.live_in(b, v)
    }

    fn live_out(&self, b: BlockId, v: ValueId) -> bool {
        self.blocks.live_out(b, v)
    }

    /// Whether `x` is live at the program point immediately after `y`
    /// is defined. `y` names a value definition (an instruction
    /// index); `x` is any other value.
    fn live_just_after_def(&self, func: &FunctionSsa, x: ValueId, y: ValueId) -> bool {
        if x == y {
            return false;
        }
        // A value covered by no block is never reached, so it is live at
        // no program point and defines none.
        if !self.in_cfg(x) || !self.in_cfg(y) {
            return false;
        }
        let b = self.block_of[y as usize];
        // Two phis of one block are defined at the same point, so they
        // always overlap. Tested before the index comparison below, which
        // would read the later-indexed phi as defined afterwards.
        if self.block_of[x as usize] == b
            && matches!(func.insts[x as usize], Inst::Phi { .. })
            && matches!(func.insts[y as usize], Inst::Phi { .. })
        {
            return true;
        }
        // A value defined later in the same block is not yet live at
        // `y`'s definition.
        if self.block_of[x as usize] == b && x > y {
            return false;
        }
        if self.live_out(b, x) {
            // `x` reaches `b`'s exit and is defined no later than `y`,
            // so it is live across `y`'s definition.
            return true;
        }
        // `x` dies inside `b` (or is not live in `b` at all). It is
        // live just after `y` only if it is already defined and has a
        // use in `b` past `y`.
        let defined_by_y = (self.block_of[x as usize] == b && x <= y)
            || (self.block_of[x as usize] != b && self.live_in(b, x));
        if !defined_by_y {
            return false;
        }
        self.block_has_use_after(func, b, x, y)
    }

    /// Whether `x` is used as a non-phi operand or terminator operand in
    /// block `b` at a program point after `y`. `b` is `y`'s block.
    ///
    /// Fast path: when `x`'s last use across the whole function lies at
    /// or before `b`'s end, the precomputed position answers in O(1).
    /// This holds for every value in a single-block function, which is
    /// where the former per-call block scan made the interference checks
    /// super-linear. The scan survives only for the rare case where `x`
    /// is also used past `b` on a sibling path (so `last_use_pos` points
    /// outside `b` and cannot speak for the in-block window); the
    /// caller's `!live_out(b, x)` guard rules out a successor use.
    fn block_has_use_after(&self, func: &FunctionSsa, b: BlockId, x: ValueId, y: ValueId) -> bool {
        let blk = &func.blocks[b as usize];
        let lup = self.last_use_pos.get(x as usize).copied().unwrap_or(0);
        // A use strictly before `b`'s end lies in `b` or an earlier
        // block, so the precomputed position decides directly. The bound
        // is strict: position `inst_range.end` is both `b`'s terminator
        // slot and the next block's first instruction index, so a value
        // last used there is resolved by the scan to avoid the ambiguity.
        if lup < blk.inst_range.end {
            return lup > y;
        }
        for idx in (y + 1)..blk.inst_range.end {
            if matches!(func.insts[idx as usize], Inst::Phi { .. }) {
                continue;
            }
            let mut found = false;
            super::reg_alloc::for_each_operand(&func.insts[idx as usize], |op| {
                if op == x {
                    found = true;
                }
            });
            if found {
                return true;
            }
        }
        match &blk.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => *cond == x,
            Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. } => {
                *target == x
            }
            Terminator::Return(v) => *v == x,
            _ => false,
        }
    }

    /// Whether `v` is live at the program point immediately after the
    /// instruction at index `point`. With `point` a call instruction
    /// this is exactly "v's live range spans the call": v is defined no
    /// later than the call and is still live once it returns, so a
    /// caller-saved register holding v would be clobbered.
    #[allow(dead_code)]
    pub(crate) fn live_after(&self, func: &FunctionSsa, v: ValueId, point: ValueId) -> bool {
        self.live_just_after_def(func, v, point)
    }

    /// Whether `a` and `b` are ever simultaneously live. Two
    /// single-definition values interfere iff one definition lies in
    /// the other's live range.
    /// The per-pair form of the relation [`Liveness::interference`] builds
    /// a graph of. The passes read the graph; this is the reference the
    /// congruence-class test and the `codegen_test` allocation audit hold
    /// it to.
    #[cfg(any(test, feature = "codegen_test"))]
    pub(crate) fn interfere(&self, func: &FunctionSsa, a: ValueId, b: ValueId) -> bool {
        if a == b {
            return false;
        }
        self.live_just_after_def(func, a, b) || self.live_just_after_def(func, b, a)
    }

    /// Build the interference graph over the nodes named by
    /// `node_of[v]` (the register-allocation unit a value belongs to,
    /// typically its phi-congruence-class root). Two nodes interfere
    /// when any value in one is live at a point a value in the other is
    /// also live; the allocator must give interfering nodes distinct
    /// registers or spill one of them.
    ///
    /// Construction is the standard liveness sweep: for each block seed
    /// the live set from the block's exit (the dataflow live-out plus
    /// the terminator and accumulator operands), then walk the block
    /// backward. At each value definition, the defined node interferes
    /// with every node currently live; the definition is then removed
    /// and its non-phi operands become live. Phi operands are edge uses
    /// counted in the predecessors' live-out, so they are not added
    /// here. The cost is linear in code size times the live-set width,
    /// not quadratic in the value count.
    /// The live values ride a sparse set and the nodes currently live
    /// a counted sparse set, so a definition point emits each
    /// (def-node, live-node) edge exactly once with no per-edge
    /// allocation; the pair list is laid out as a CSR row per node at
    /// the end.
    #[allow(dead_code)]
    pub(crate) fn interference(&self, func: &FunctionSsa, node_of: &[ValueId]) -> Interference {
        let n = func.insts.len();
        // Edges packed (low << 32) | high: one-word sort + dedup.
        let mut pairs: Vec<u64> = Vec::new();
        let mut live = LiveNodeSet::new(n, track_occupancy(func));
        for (b, blk) in func.blocks.iter().enumerate() {
            live.clear();
            self.blocks
                .for_each_live_out(b as BlockId, |v| live.insert(v, node_of));
            if blk.exit_acc != NO_VALUE && (blk.exit_acc as usize) < n {
                live.insert(blk.exit_acc, node_of);
            }
            match &blk.terminator {
                Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                    if (*cond as usize) < n {
                        live.insert(*cond, node_of);
                    }
                }
                Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. }
                    if (*target as usize) < n =>
                {
                    live.insert(*target, node_of);
                }
                Terminator::Return(v) if *v != NO_VALUE && (*v as usize) < n => {
                    live.insert(*v, node_of);
                }
                _ => {}
            }
            // The block's phi results occupy the leading run of its
            // range and are handled after the sweep, together.
            let mut phi_end = blk.inst_range.start;
            while phi_end < blk.inst_range.end
                && matches!(func.insts[phi_end as usize], Inst::Phi { .. })
            {
                phi_end += 1;
            }
            for idx in (phi_end..blk.inst_range.end).rev() {
                let inst = &func.insts[idx as usize];
                if super::reg_alloc::produces_value(inst) {
                    let di = node_of[idx as usize];
                    for &nd in &live.nodes {
                        if nd != di {
                            pairs.push(((di.min(nd) as u64) << 32) | di.max(nd) as u64);
                        }
                    }
                    live.remove(idx, node_of);
                }
                if !matches!(inst, Inst::Phi { .. }) {
                    super::reg_alloc::for_each_operand(inst, |op| {
                        if op != NO_VALUE && (op as usize) < n {
                            live.insert(op, node_of);
                        }
                    });
                }
            }
            // One parallel copy per incoming edge writes every phi of the
            // block, so each interferes with every value live at entry and
            // with every other phi -- a dead phi included, since the copy
            // writes it too.
            for idx in blk.inst_range.start..phi_end {
                live.insert(idx, node_of);
            }
            for idx in blk.inst_range.start..phi_end {
                let di = node_of[idx as usize];
                for &nd in &live.nodes {
                    if nd != di {
                        pairs.push(((di.min(nd) as u64) << 32) | di.max(nd) as u64);
                    }
                }
            }
        }
        Interference::from_pairs(n, pairs)
    }

    /// Per-value flag: true when the value's live range spans a call,
    /// i.e. the value is live at the program point immediately after
    /// some `Call` / `CallIndirect` / `CallExt` instruction (and, on
    /// targets where `Inst::TlsAddr` lowers to a call, that as well).
    /// A caller-saved register holding such a value would be clobbered
    /// by the call, so the allocator must place it in a callee-saved
    /// register or spill it.
    ///
    /// This is the same CFG-liveness view the interference graph uses
    /// (the per-block backward sweep over the dataflow live-out),
    /// rather than a linear `def < call_pc < last_use` pc interval.
    /// The pc interval disagrees with the true live range whenever a
    /// value is live across a call only on a branch or back-edge path
    /// -- the call then falls outside `[def, last_use]` and the value
    /// is wrongly judged not to cross it. A computed-dispatch loop is
    /// exactly that shape: a value defined in the loop body and used
    /// again after the back-edge crosses the body's calls without the
    /// linear interval covering them.
    pub(crate) fn values_live_across_calls(
        &self,
        func: &FunctionSsa,
        tls_addr_is_call: bool,
    ) -> Vec<bool> {
        // Monomorphised on the occupancy mode so the ordinary function
        // pays no test for bookkeeping it does not do.
        if track_occupancy(func) {
            self.sweep_calls::<true>(func, tls_addr_is_call)
        } else {
            self.sweep_calls::<false>(func, tls_addr_is_call)
        }
    }

    fn sweep_calls<const TRACK: bool>(
        &self,
        func: &FunctionSsa,
        tls_addr_is_call: bool,
    ) -> Vec<bool> {
        let n = func.insts.len();
        let mut out = vec![false; n];
        let mut live = SparseValueSet::new(n, TRACK);
        for (b, blk) in func.blocks.iter().enumerate() {
            live.clear();
            self.blocks.for_each_live_out(b as BlockId, |v| {
                live.set::<TRACK>(v);
            });
            if blk.exit_acc != NO_VALUE && (blk.exit_acc as usize) < n {
                live.set::<TRACK>(blk.exit_acc);
            }
            match &blk.terminator {
                Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                    if (*cond as usize) < n {
                        live.set::<TRACK>(*cond);
                    }
                }
                Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. }
                    if (*target as usize) < n =>
                {
                    live.set::<TRACK>(*target);
                }
                Terminator::Return(v) if *v != NO_VALUE && (*v as usize) < n => {
                    live.set::<TRACK>(*v);
                }
                _ => {}
            }
            for idx in (blk.inst_range.start..blk.inst_range.end).rev() {
                let inst = &func.insts[idx as usize];
                let is_call = matches!(
                    inst,
                    Inst::Call { .. } | Inst::CallIndirect { .. } | Inst::CallExt { .. }
                ) || (tls_addr_is_call && matches!(inst, Inst::TlsAddr(_)))
                    || super::reg_alloc::is_setjmp_barrier(inst);
                if super::reg_alloc::produces_value(inst) {
                    live.unset(idx);
                }
                // After removing the call's own result (its definition
                // point), `live` holds exactly the values live at the
                // point just after the call returns. Each such value's
                // range spans the call.
                if is_call {
                    live.for_each(|v| out[v as usize] = true);
                }
                if !matches!(inst, Inst::Phi { .. }) {
                    super::reg_alloc::for_each_operand(inst, |op| {
                        if op != NO_VALUE && (op as usize) < n {
                            live.set::<TRACK>(op);
                        }
                    });
                }
            }
        }
        out
    }
}

/// Whether a per-block live-set sweep over `func` should track which
/// words of its bit vector hold members. The sweep clears the set once
/// per block and scans it at each call, so the full-width form costs
/// `blocks * values / 64` -- the area term that grows faster than the
/// function. Tracking removes it, at a per-insertion cost that only
/// pays once the area is large.
fn track_occupancy(func: &FunctionSsa) -> bool {
    func.blocks
        .len()
        .saturating_mul(func.insts.len().div_ceil(64))
        > DENSE_WORD_BUDGET
}

/// Set of value ids as a bit vector that also tracks which of its words
/// hold a member, so enumerating and clearing cost the occupied words
/// rather than the vector's width -- the term that made a per-call scan
/// of the whole set grow with the function. Insertion stays a load, a
/// test and a store; only the first member of a word appends to the
/// occupancy list.
struct SparseValueSet {
    bits: Vec<u64>,
    /// Words that have held a member since the last clear, each listed
    /// once -- a word that empties and refills must not be listed
    /// again, or the list grows with the instruction count rather than
    /// with the set's width. Empty when `track` is false.
    touched: Vec<u32>,
    listed: Vec<bool>,
    track: bool,
}

impl SparseValueSet {
    /// `track` records which words hold members, so a clear or an
    /// enumeration costs the occupied words instead of the set's whole
    /// width. It earns its per-insertion bookkeeping only once that
    /// width is large: over a narrow set the full-width memset and scan
    /// are contiguous and vectorised, and cost less.
    fn new(n: usize, track: bool) -> Self {
        let words = n.div_ceil(64).max(1);
        SparseValueSet {
            bits: alloc::vec![0; words],
            touched: Vec::new(),
            listed: alloc::vec![false; if track { words } else { 0 }],
            track,
        }
    }

    /// Add `v`, without reporting whether it was already a member.
    /// `TRACK` must match the mode the set was built with.
    fn set<const TRACK: bool>(&mut self, v: ValueId) {
        let w = v as usize / 64;
        self.bits[w] |= 1u64 << (v % 64);
        if TRACK && !self.listed[w] {
            self.listed[w] = true;
            self.touched.push(w as u32);
        }
    }

    /// Drop `v` if present.
    fn unset(&mut self, v: ValueId) {
        self.bits[v as usize / 64] &= !(1u64 << (v % 64));
    }

    /// Whether `v` was absent and is now a member.
    fn insert(&mut self, v: ValueId) -> bool {
        let (w, m) = (v as usize / 64, 1u64 << (v % 64));
        if self.bits[w] & m != 0 {
            return false;
        }
        if self.track {
            self.set::<true>(v);
        } else {
            self.set::<false>(v);
        }
        true
    }

    /// Whether `v` was a member and is now removed.
    fn remove(&mut self, v: ValueId) -> bool {
        let (w, m) = (v as usize / 64, 1u64 << (v % 64));
        if self.bits[w] & m == 0 {
            return false;
        }
        self.bits[w] &= !m;
        true
    }

    /// Call `f` with every member, in no particular order.
    fn for_each(&mut self, mut f: impl FnMut(ValueId)) {
        let mut emit = |w: u32, mut word: u64| {
            while word != 0 {
                f(w * 64 + word.trailing_zeros());
                word &= word - 1;
            }
        };
        if self.track {
            for &w in &self.touched {
                emit(w, self.bits[w as usize]);
            }
        } else {
            for (w, &word) in self.bits.iter().enumerate() {
                emit(w as u32, word);
            }
        }
    }

    fn clear(&mut self) {
        if !self.track {
            self.bits.iter_mut().for_each(|w| *w = 0);
            return;
        }
        for &w in &self.touched {
            self.bits[w as usize] = 0;
            self.listed[w as usize] = false;
        }
        self.touched.clear();
    }
}

/// The values live at a sweep point, tracked at two granularities:
/// membership as a sparse value set and the distinct register-
/// allocation nodes those values belong to as a counted sparse set,
/// so a definition can enumerate live nodes without touching
/// per-value state.
struct LiveNodeSet {
    vals: SparseValueSet,
    /// Live-value count per node; a node leaves `nodes` at zero.
    count: Vec<u32>,
    /// Compact list of nodes with a nonzero count.
    nodes: Vec<ValueId>,
    /// Position of a live node in `nodes` (swap-removed on exit).
    pos: Vec<u32>,
}

impl LiveNodeSet {
    fn new(n: usize, track: bool) -> Self {
        LiveNodeSet {
            vals: SparseValueSet::new(n, track),
            count: alloc::vec![0; n],
            nodes: Vec::new(),
            pos: alloc::vec![u32::MAX; n],
        }
    }

    /// Drop every member, ready to be re-seeded.
    fn clear(&mut self) {
        for &nd in &self.nodes {
            self.count[nd as usize] = 0;
            self.pos[nd as usize] = u32::MAX;
        }
        self.nodes.clear();
        self.vals.clear();
    }

    fn enter(&mut self, nd: ValueId) {
        let c = &mut self.count[nd as usize];
        if *c == 0 {
            self.pos[nd as usize] = self.nodes.len() as u32;
            self.nodes.push(nd);
        }
        *c += 1;
    }

    fn insert(&mut self, v: ValueId, node_of: &[ValueId]) {
        if !self.vals.insert(v) {
            return;
        }
        self.enter(node_of[v as usize]);
    }

    fn remove(&mut self, v: ValueId, node_of: &[ValueId]) {
        if !self.vals.remove(v) {
            return;
        }
        let nd = node_of[v as usize] as usize;
        self.count[nd] -= 1;
        if self.count[nd] == 0 {
            let at = self.pos[nd] as usize;
            let last = self.nodes.pop().unwrap();
            if at < self.nodes.len() {
                self.nodes[at] = last;
                self.pos[last as usize] = at as u32;
            }
            self.pos[nd] = u32::MAX;
        }
    }
}

/// Interference graph over register-allocation nodes (phi-congruence
/// roots), stored as one CSR row of neighbors per node. Non-node
/// value ids have empty rows.
pub(crate) struct Interference {
    offsets: Vec<u32>,
    edges: Vec<ValueId>,
}

#[allow(dead_code)]
impl Interference {
    /// Nodes that interfere with `node`, each listed once. The row order
    /// is the order the sweep emitted the edges; both consumers (the
    /// coalescer's membership test and the colourer's neighbour-colour
    /// scan) read a row as a set.
    pub(crate) fn neighbors(&self, node: ValueId) -> &[ValueId] {
        let (a, b) = (
            self.offsets[node as usize] as usize,
            self.offsets[node as usize + 1] as usize,
        );
        &self.edges[a..b]
    }

    /// Number of nodes that interfere with `node`.
    pub(crate) fn degree(&self, node: ValueId) -> usize {
        self.neighbors(node).len()
    }

    /// Build the CSR rows from canonicalized `(low << 32) | high`
    /// pairs, duplicates welcome.
    ///
    /// Counting the two endpoints of every pair sizes each row directly,
    /// so the pairs need no global order: the scatter places each edge in
    /// both rows, and a per-row pass with a stamp array drops the repeats
    /// a pair list can carry (an edge whose two definition points each see
    /// the other value live). Compaction runs in place -- the write cursor
    /// never passes the row being read -- so no second edge buffer exists.
    fn from_pairs(n: usize, pairs: Vec<u64>) -> Self {
        let unpack = |p: u64| ((p >> 32) as usize, (p & 0xffff_ffff) as usize);
        let mut cap = alloc::vec![0u32; n + 1];
        for &p in &pairs {
            let (a, b) = unpack(p);
            cap[a + 1] += 1;
            cap[b + 1] += 1;
        }
        for i in 0..n {
            cap[i + 1] += cap[i];
        }
        let mut cursor: Vec<u32> = cap[..n].to_vec();
        let mut edges = alloc::vec![0 as ValueId; cap[n] as usize];
        for &p in &pairs {
            let (a, b) = unpack(p);
            edges[cursor[a] as usize] = b as ValueId;
            cursor[a] += 1;
            edges[cursor[b] as usize] = a as ValueId;
            cursor[b] += 1;
        }
        let mut offsets = alloc::vec![0u32; n + 1];
        let mut seen = alloc::vec![u32::MAX; n];
        let mut w = 0u32;
        for a in 0..n {
            offsets[a] = w;
            for i in cap[a]..cap[a + 1] {
                let nb = edges[i as usize];
                if seen[nb as usize] != a as u32 {
                    seen[nb as usize] = a as u32;
                    edges[w as usize] = nb;
                    w += 1;
                }
            }
        }
        offsets[n] = w;
        edges.truncate(w as usize);
        Self { offsets, edges }
    }

    /// Build a graph directly from an edge list, for unit tests that
    /// exercise coloring without constructing a whole function.
    #[cfg(test)]
    pub(crate) fn from_edges(n: usize, edges: &[(ValueId, ValueId)]) -> Self {
        Self::from_pairs(
            n,
            edges
                .iter()
                .map(|&(a, b)| ((a.min(b) as u64) << 32) | a.max(b) as u64)
                .collect(),
        )
    }
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::Inst;
    use super::super::super::ir::{BinOp, Block, FunctionSsa, LoadKind, Terminator};
    use super::*;
    use alloc::string::String;

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            name: String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            ssp: crate::c5::ir::SspFacts::default(),
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
            is_noinline: false,
            is_naked: false,
            section: None,
            patchable_entry: None,
            no_instrument: false,
            is_weak: false,
            is_internal: false,
            const_params: 0,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            cmp32: Vec::new(),
            param_fp_mask: 0,
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            ret_type_tag: 0,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            label_data_relocs: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            over_aligned: Default::default(),
            frame_align: 0,
            realign_region_bytes: 0,
            has_returns_twice_call: false,
            did_unroll: false,
            did_inline: false,
            insts,
            blocks,
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    fn identity(n: usize) -> Vec<ValueId> {
        (0..n as ValueId).collect()
    }

    fn blk(inst_range: core::ops::Range<u32>, terminator: Terminator) -> Block {
        Block {
            start_pc: 0,
            inst_range,
            terminator,
            exit_acc: NO_VALUE,
        }
    }

    /// The backward equations iterated over dense rows to a fixed
    /// point, the form [`SparseLive`] replaces. Rows are returned as
    /// ascending element lists so they compare directly.
    fn reference_live(
        nelems: usize,
        nblocks: usize,
        graph: &super::super::mem2reg::SuccGraph,
        use_seed: &[(u32, BlockId)],
        exit_seed: &[(u32, BlockId)],
        kill: &[(u32, BlockId)],
    ) -> (Vec<Vec<u32>>, Vec<Vec<u32>>) {
        let mut used = alloc::vec![alloc::vec![false; nelems]; nblocks];
        let mut exits = alloc::vec![alloc::vec![false; nelems]; nblocks];
        let mut kills = alloc::vec![alloc::vec![false; nelems]; nblocks];
        for (tbl, src) in [
            (&mut used, use_seed),
            (&mut exits, exit_seed),
            (&mut kills, kill),
        ] {
            for &(e, b) in src {
                tbl[b as usize][e as usize] = true;
            }
        }
        let mut live_in = alloc::vec![alloc::vec![false; nelems]; nblocks];
        let mut live_out = alloc::vec![alloc::vec![false; nelems]; nblocks];
        loop {
            let mut changed = false;
            for b in 0..nblocks {
                for e in 0..nelems {
                    let mut o = exits[b][e];
                    for &s in graph.of(b as BlockId) {
                        o |= live_in[s as usize][e];
                    }
                    live_out[b][e] = o;
                    let i = used[b][e] || (o && !kills[b][e]);
                    if i != live_in[b][e] {
                        live_in[b][e] = i;
                        changed = true;
                    }
                }
            }
            if !changed {
                break;
            }
        }
        let rows = |t: &[Vec<bool>]| -> Vec<Vec<u32>> {
            t.iter()
                .map(|r| {
                    r.iter()
                        .enumerate()
                        .filter(|&(_, &v)| v)
                        .map(|(e, _)| e as u32)
                        .collect()
                })
                .collect()
        };
        (rows(&live_in), rows(&live_out))
    }

    /// The per-element walk must reproduce the fixed point exactly on
    /// arbitrary graphs: loops, unreachable blocks, empty blocks,
    /// multiple killing blocks per element, and elements live across
    /// most of the graph.
    #[test]
    fn sparse_live_matches_the_reference_dataflow() {
        let mut state = 0x2545_f491_4f6c_dd1du64;
        let mut next = move |m: u32| {
            state ^= state << 13;
            state ^= state >> 7;
            state ^= state << 17;
            (state >> 33) as u32 % m
        };
        let mut covered = 0usize;
        for case in 0..64 {
            let nblocks = 2 + (case % 11);
            let nelems = 1 + (case % 7);
            let blocks: Vec<Block> = (0..nblocks)
                .map(|b| {
                    let term = match next(3) {
                        0 => Terminator::Return(NO_VALUE),
                        1 => Terminator::Jmp(next(nblocks as u32)),
                        _ => Terminator::Bz {
                            cond: 0,
                            target: next(nblocks as u32),
                            fall_through: next(nblocks as u32),
                        },
                    };
                    // Half the blocks are empty; `b` keeps the ranges
                    // distinct so no two blocks claim one instruction.
                    let start = b as u32;
                    blk(start..start + next(2), term)
                })
                .collect();
            let func = func_with(alloc::vec![Inst::Imm(0); nblocks + 1], blocks);
            let graph = super::super::mem2reg::SuccGraph::new(&func);
            let mut pick = |n: usize| -> Vec<(u32, BlockId)> {
                (0..n)
                    .map(|_| (next(nelems as u32), next(nblocks as u32)))
                    .collect()
            };
            let (uses, exits, kills) = (pick(nblocks), pick(nblocks / 2), pick(nblocks));
            let (ref_in, ref_out) = reference_live(nelems, nblocks, &graph, &uses, &exits, &kills);
            let live = SparseLive::solve(nelems, nblocks, &graph, &uses, &exits, &kills);
            for b in 0..nblocks {
                assert_eq!(live.in_row(b as BlockId), &ref_in[b][..], "live-in b{b}");
                assert_eq!(live.out_row(b as BlockId), &ref_out[b][..], "live-out b{b}");
            }
            for b in 0..nblocks {
                covered += ref_in[b].len() + ref_out[b].len();
            }
        }
        // The generated cases must carry real live sets; an all-empty
        // fixed point would compare equal without testing anything.
        assert!(covered > 1000, "thin coverage: {covered} live pairs");
    }

    /// The two representations must answer every query alike, so which
    /// one a function's shape selects cannot move a single allocation
    /// decision. Driven over a chain of blocks whose values cross it.
    #[test]
    fn dense_and_sparse_sets_answer_alike() {
        const W: u32 = 70;
        let mut insts: Vec<Inst> = (0..W).map(|i| Inst::Imm(i as i64)).collect();
        let mut blocks = alloc::vec![blk(0..W, Terminator::Jmp(1))];
        // Each block consumes one of the wide block's values, so the
        // rest stay live past it.
        for b in 1..W {
            let at = insts.len() as u32;
            insts.push(Inst::Binop {
                op: BinOp::Add,
                lhs: b - 1,
                rhs: b,
            });
            blocks.push(blk(at..at + 1, Terminator::Jmp(b + 1)));
        }
        let end = insts.len() as u32;
        blocks.push(blk(end..end, Terminator::Return(end - 1)));
        let func = func_with(insts, blocks);
        let dense = BlockLiveness::compute(&func);
        assert!(
            matches!(dense.live, LiveSets::Dense { .. }),
            "a function of this size must keep the dense rows",
        );
        let graph = super::super::mem2reg::SuccGraph::new(&func);
        let sparse = BlockLiveness {
            rank: dense.rank.clone(),
            universe: dense.universe.clone(),
            live: LiveSets::Sparse(BlockLiveness::solve_sparse(
                &func,
                &graph,
                &dense.rank,
                dense.universe.len(),
            )),
        };
        for b in 0..func.blocks.len() as BlockId {
            for v in 0..func.insts.len() as ValueId {
                assert_eq!(
                    dense.live_in(b, v),
                    sparse.live_in(b, v),
                    "live_in b{b} v{v}"
                );
                assert_eq!(
                    dense.live_out(b, v),
                    sparse.live_out(b, v),
                    "live_out b{b} v{v}"
                );
            }
            let (mut d, mut s) = (Vec::new(), Vec::new());
            dense.for_each_live_out(b, |v| d.push(v));
            sparse.for_each_live_out(b, |v| s.push(v));
            assert_eq!(d, s, "live-out enumeration of b{b}");
            assert!(!d.is_empty() || b + 1 == func.blocks.len() as BlockId);
        }
    }

    /// A block holding no instruction still carries a live value
    /// across: the old bit rows stored one per block whatever its
    /// contents, and the sparse rows must keep the pass-through pairs.
    #[test]
    fn empty_blocks_pass_a_live_value_through() {
        // b0: v0 = Imm; b1, b2 empty; b3: Return v0.
        let insts = alloc::vec![Inst::Imm(0)];
        let blocks = alloc::vec![
            blk(0..1, Terminator::Jmp(1)),
            blk(1..1, Terminator::Jmp(2)),
            blk(1..1, Terminator::Jmp(3)),
            blk(1..1, Terminator::Return(0)),
        ];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        let b = live.block_liveness();
        for mid in 1..4 {
            assert!(b.live_in(mid, 0), "v0 must be live-in at b{mid}");
        }
        for pass in 0..3 {
            assert!(b.live_out(pass, 0), "v0 must be live-out of b{pass}");
        }
        assert!(!b.live_out(3, 0), "v0 dies at the return");
        assert!(!b.live_in(0, 0), "v0's own block does not carry it in");
    }

    /// Every value of a wide definition block read again at the far end
    /// of a chain stays live at each intermediate block, and the rows
    /// enumerate in value order.
    #[test]
    fn dense_cross_block_ranges_are_carried_at_every_block() {
        const W: u32 = 40;
        let mut insts: Vec<Inst> = (0..W).map(|i| Inst::Imm(i as i64)).collect();
        let mut acc = W - 1;
        // The tail block sums them, so all W values cross every block.
        let chain = 6;
        for i in 0..W - 1 {
            insts.push(Inst::Binop {
                op: BinOp::Add,
                lhs: i,
                rhs: acc,
            });
            acc = W + i;
        }
        let mut blocks = alloc::vec![blk(0..W, Terminator::Jmp(1))];
        for b in 1..chain {
            blocks.push(blk(W..W, Terminator::Jmp(b + 1)));
        }
        blocks.push(blk(
            W..insts.len() as u32,
            Terminator::Return(insts.len() as u32 - 1),
        ));
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        let bl = live.block_liveness();
        for b in 1..=chain {
            let mut seen: Vec<ValueId> = Vec::new();
            bl.for_each_live_out(b - 1, |v| seen.push(v));
            assert_eq!(seen, identity(W as usize), "b{} live-out", b - 1);
            for v in 0..W {
                assert!(bl.live_in(b, v), "v{v} must be live-in at b{b}");
            }
        }
    }

    /// A phi operand is a use on its own incoming edge only: it is
    /// live-out of the predecessor the phi names and of no other, and
    /// the phi's block does not carry it in.
    #[test]
    fn phi_operand_is_live_out_of_its_named_predecessor_only() {
        // b0: v0 = Imm; Bz -> b1 / b2
        // b1: v1 = Imm;  b2: v2 = Imm
        // b3: v3 = Phi[b1:v1, b2:v2]; Return v3
        let insts = alloc::vec![
            Inst::Imm(0),
            Inst::Imm(1),
            Inst::Imm(2),
            Inst::Phi {
                incoming: alloc::vec![(1, 1), (2, 2)],
                kind: LoadKind::I64,
            },
        ];
        let blocks = alloc::vec![
            blk(
                0..1,
                Terminator::Bz {
                    cond: 0,
                    target: 2,
                    fall_through: 1,
                },
            ),
            blk(1..2, Terminator::Jmp(3)),
            blk(2..3, Terminator::Jmp(3)),
            blk(3..4, Terminator::Return(3)),
        ];
        let func = func_with(insts, blocks);
        let bl = Liveness::compute(&func);
        let b = bl.block_liveness();
        assert!(
            b.live_out(1, 1) && !b.live_out(2, 1),
            "v1 crosses b1's edge"
        );
        assert!(
            b.live_out(2, 2) && !b.live_out(1, 2),
            "v2 crosses b2's edge"
        );
        assert!(
            !b.live_in(3, 1) && !b.live_in(3, 2),
            "a phi operand is consumed on the edge, not live into the join",
        );
        assert!(
            !b.live_out(0, 1) && !b.live_out(0, 2),
            "neither operand is live before its own definition",
        );
    }

    /// `block_has_use_after` (now table-driven) must still distinguish a
    /// value used past another's definition from one that dies before
    /// it. b0: v0,v1 = Imm; v2 = v0+v1; v3 = v2+v0; Return v3. v0's last
    /// use is v3, so v0 is live across v2's def (interfere). v1 dies at
    /// v2, before v3's def (no interfere with v3).
    #[test]
    fn use_after_def_drives_interference() {
        let insts = alloc::vec![
            Inst::Imm(0),
            Inst::Imm(1),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
            Inst::Binop {
                op: BinOp::Add,
                lhs: 2,
                rhs: 0,
            },
        ];
        let blocks = alloc::vec![Block {
            start_pc: 0,
            inst_range: 0..4,
            terminator: Terminator::Return(3),
            exit_acc: 3,
        }];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        assert!(
            live.interfere(&func, 0, 2),
            "v0 used at v3 is live across v2's def"
        );
        assert!(
            !live.interfere(&func, 1, 3),
            "v1 dies at v2, before v3 is defined"
        );
    }

    /// `prune_unreachable` leaves a deleted block's instructions in
    /// `insts` covered by no `inst_range`. Those values are reached by
    /// nothing, so they are in no block and interfere with nothing --
    /// before, `block_of` defaulted to 0 and attributed them to the
    /// entry block, which made the query report an overlap with every
    /// entry-block value still live at their index.
    #[test]
    fn value_outside_every_block_is_not_in_the_cfg() {
        let insts = alloc::vec![
            Inst::Imm(0),
            Inst::Imm(1),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
            Inst::Imm(0),
            Inst::Imm(0),
        ];
        let blocks = alloc::vec![Block {
            start_pc: 0,
            inst_range: 0..3,
            terminator: Terminator::Return(2),
            exit_acc: 2,
        }];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        assert!(live.in_cfg(0) && live.in_cfg(2));
        assert!(!live.in_cfg(3) && !live.in_cfg(4));
        for covered in 0..3 {
            for orphan in 3..5 {
                assert!(
                    !live.interfere(&func, covered, orphan),
                    "v{covered} cannot interfere with uncovered v{orphan}"
                );
            }
        }
        assert!(!live.interfere(&func, 3, 4));
        let g = live.interference(&func, &identity(func.insts.len()));
        assert!(g.neighbors(3).is_empty() && g.neighbors(4).is_empty());
    }

    #[test]
    fn overlapping_values_interfere_disjoint_do_not() {
        // b0: v0=Imm(0); v1=Imm(1); v2=Binop add v0,v1; Return v2
        // v0 and v1 are both live at v2's definition -> interfere.
        // v2 is defined after both die -> no other edges.
        let insts = alloc::vec![
            Inst::Imm(0),
            Inst::Imm(1),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
        ];
        let blocks = alloc::vec![Block {
            start_pc: 0,
            inst_range: 0..3,
            terminator: Terminator::Return(2),
            exit_acc: 2,
        }];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        let g = live.interference(&func, &identity(func.insts.len()));
        assert!(g.neighbors(0).contains(&1), "v0 and v1 overlap at v2's def");
        assert!(g.neighbors(1).contains(&0));
        assert!(
            !g.neighbors(2).contains(&0) && !g.neighbors(2).contains(&1),
            "v2 is born after v0 / v1 die",
        );
    }

    #[test]
    fn back_edge_source_interferes_with_passthrough_value() {
        // Loop laid out b0,b1,b2,b3,b4 but executed b1->b3->b2->b1:
        //   b1 (header): A=phi[b0:v0,b2:v5], B=phi[b0:v0,b2:v4], cond
        //   b3 (body):   v5 = A+1   (A's next value)
        //   b2 (step):   v4 = B+1   (B's next value)
        // v5 is defined in b3 (high index) yet flows b3->b2->b1, so it
        // is live across b2 where v4 is defined. A PC-interval model
        // (v5 interval starts at index 5, past b2's range 4..5) misses
        // the overlap; the liveness sweep records the edge.
        let insts = alloc::vec![
            Inst::Imm(0), // 0  b0
            Inst::Phi {
                incoming: alloc::vec![(0, 0), (2, 5)],
                kind: LoadKind::I64,
            }, // 1  b1 A
            Inst::Phi {
                incoming: alloc::vec![(0, 0), (2, 4)],
                kind: LoadKind::I64,
            }, // 2  b1 B
            Inst::BinopI {
                op: BinOp::Lt,
                lhs: 1,
                rhs_imm: 10,
            }, // 3  b1 cond
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 2,
                rhs_imm: 1,
            }, // 4  b2 v4 = B+1
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 1,
                rhs_imm: 1,
            }, // 5  b3 v5 = A+1
        ];
        let blocks = alloc::vec![
            Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Jmp(1),
                exit_acc: 0,
            },
            Block {
                start_pc: 0,
                inst_range: 1..4,
                terminator: Terminator::Bz {
                    cond: 3,
                    target: 4,
                    fall_through: 3,
                },
                exit_acc: 3,
            },
            Block {
                start_pc: 0,
                inst_range: 4..5,
                terminator: Terminator::Jmp(1),
                exit_acc: 4,
            },
            Block {
                start_pc: 0,
                inst_range: 5..6,
                terminator: Terminator::Jmp(2),
                exit_acc: 5,
            },
            Block {
                start_pc: 0,
                inst_range: 6..6,
                terminator: Terminator::Return(1),
                exit_acc: 1,
            },
        ];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        // Sanity: the interference query agrees.
        assert!(
            live.interfere(&func, 5, 4),
            "back-edge source v5 must interfere with passthrough value v4",
        );
        let g = live.interference(&func, &identity(func.insts.len()));
        assert!(
            g.neighbors(5).contains(&4),
            "interference graph must record the back-edge wrap-around edge v5--v4",
        );
        assert!(g.neighbors(4).contains(&5));
    }

    /// Every row is the neighbour set, each entry once and both
    /// directions present, whatever order and multiplicity the sweep
    /// emitted the pairs in. The CSR build sizes the rows off the raw
    /// pair count, so a repeated edge would otherwise show up twice.
    #[test]
    fn rows_are_deduplicated_and_symmetric() {
        let g = Interference::from_edges(4, &[(0, 1), (1, 0), (0, 1), (2, 0), (3, 2), (3, 2)]);
        let row = |v: ValueId| {
            let mut r: Vec<ValueId> = g.neighbors(v).to_vec();
            r.sort_unstable();
            r
        };
        assert_eq!(row(0), alloc::vec![1, 2]);
        assert_eq!(row(1), alloc::vec![0]);
        assert_eq!(row(2), alloc::vec![0, 3]);
        assert_eq!(row(3), alloc::vec![2]);
        for v in 0..4 as ValueId {
            assert_eq!(g.degree(v), row(v).len(), "degree counts a row once");
        }
    }

    /// One parallel copy per incoming edge writes every phi of a block,
    /// so the phis interfere pairwise however the block orders them and
    /// whether or not each is itself read. Without the edge the colourer
    /// can place a dead phi on a live one and the copy destroys it.
    #[test]
    fn phis_of_one_block_always_interfere() {
        // b0: v0=Imm(0); v1=Imm(7); Jmp b1
        // b1: v2=Phi[b0:v0, b1:v4]   (live: the counter)
        //     v3=Phi[b0:v1, b1:v1]   (dead: nothing reads it)
        //     v4=BinopI add v2,1; Bnz v4 -> b1 else b2
        // b2: Return v2
        let insts = alloc::vec![
            Inst::Imm(0),
            Inst::Imm(7),
            Inst::Phi {
                incoming: alloc::vec![(0, 0), (1, 4)],
                kind: LoadKind::I64,
            },
            Inst::Phi {
                incoming: alloc::vec![(0, 1), (1, 1)],
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 2,
                rhs_imm: 1,
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
                inst_range: 2..5,
                terminator: Terminator::Bnz {
                    cond: 4,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 4,
            },
            Block {
                start_pc: 0,
                inst_range: 5..5,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            },
        ];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        let g = live.interference(&func, &identity(func.insts.len()));
        assert!(
            g.neighbors(3).contains(&2) && g.neighbors(2).contains(&3),
            "the dead phi v3 must interfere with the live phi v2 of the same block",
        );
        assert!(
            live.interfere(&func, 2, 3) && live.interfere(&func, 3, 2),
            "the per-pair query must agree with the graph",
        );
    }

    #[test]
    fn coalesced_nodes_collapse_edges() {
        // Same overlap as the first test, but map v0 and v1 to one
        // node (as a phi-congruence coalesce would). A self-edge is
        // never recorded, so the collapsed node has no neighbor here.
        let insts = alloc::vec![
            Inst::Imm(0),
            Inst::Imm(1),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
        ];
        let blocks = alloc::vec![Block {
            start_pc: 0,
            inst_range: 0..3,
            terminator: Terminator::Return(2),
            exit_acc: 2,
        }];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        // node_of maps v1 -> v0's node.
        let node_of: Vec<ValueId> = alloc::vec![0, 0, 2];
        let g = live.interference(&func, &node_of);
        assert!(
            g.neighbors(0).is_empty(),
            "coalescing two overlapping values into one node drops their edge",
        );
    }
}

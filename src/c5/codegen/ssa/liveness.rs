//! Phi-aware block liveness and SSA value interference.
//!
//! Liveness is the standard backward dataflow over the control-flow
//! graph, with phi semantics modelled on the edges: a phi operand is
//! a use at the end of the corresponding predecessor (live-out of that
//! predecessor), and a phi result is a definition at its block head.
//! This is the lazy-copy view of out-of-SSA -- the predecessor-exit
//! move that materialises a phi operand executes on the edge, so the
//! operand is live up to that edge and the result from the join
//! onward.
//!
//! The interference query answers whether two SSA values are live at
//! the same program point. With one definition per value, two ranges
//! overlap iff one value's definition lies inside the other's live
//! range. The phi-congruence builder uses this to decide which phi
//! operands may share a register with the phi result.

use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{BlockId, FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};

pub(crate) struct Liveness {
    words: usize,
    /// `live_in[b*words .. ]` / `live_out[b*words .. ]`: bitset of
    /// values live on entry to / exit from block `b`.
    live_in: Vec<u64>,
    live_out: Vec<u64>,
    /// Defining block per value.
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
        let nblocks = func.blocks.len();
        let n = func.insts.len();
        let words = n.div_ceil(64).max(1);

        let mut block_of: Vec<BlockId> = vec![0; n];
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
                | Terminator::Unreachable => {}
            }
        }

        if nblocks == 0 {
            return Self {
                words,
                live_in: Vec::new(),
                live_out: Vec::new(),
                block_of,
                last_use_pos,
            };
        }

        let set = |bits: &mut [u64], base: usize, v: u32| {
            bits[base + (v as usize) / 64] |= 1u64 << ((v as usize) % 64);
        };
        // used_set: values referenced in a block but defined outside it
        // (upward exposed). kill: values defined in the block.
        // phi_live_out: per-predecessor phi-operand values that must be
        // live at that predecessor's exit.
        let mut used_set = vec![0u64; nblocks * words];
        let mut kill = vec![0u64; nblocks * words];
        let mut phi_live_out = vec![0u64; nblocks * words];
        for (b, blk) in func.blocks.iter().enumerate() {
            let base = b * words;
            let (start, end) = (blk.inst_range.start, blk.inst_range.end);
            for v in start..end {
                set(&mut kill, base, v);
            }
            let mut mark = |v: ValueId| {
                if v != NO_VALUE && (v < start || v >= end) {
                    set(&mut used_set, base, v);
                }
            };
            for idx in start..end {
                if let Inst::Phi { incoming, .. } = &func.insts[idx as usize] {
                    for (pred, v) in incoming {
                        if *v != NO_VALUE {
                            set(&mut phi_live_out, (*pred as usize) * words, *v);
                        }
                    }
                    continue;
                }
                super::reg_alloc::for_each_operand(&func.insts[idx as usize], &mut mark);
            }
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

        let mut live_in = vec![0u64; nblocks * words];
        let mut live_out = vec![0u64; nblocks * words];
        let mut scratch = vec![0u64; words];
        let mut changed = true;
        while changed {
            changed = false;
            for b in (0..nblocks).rev() {
                let base = b * words;
                scratch.iter_mut().for_each(|w| *w = 0);
                for s in super::mem2reg::successors(
                    &func.blocks[b].terminator,
                    &func.computed_goto_targets,
                    &func.jump_tables,
                ) {
                    let sb = s as usize * words;
                    for w in 0..words {
                        scratch[w] |= live_in[sb + w];
                    }
                }
                for w in 0..words {
                    scratch[w] |= phi_live_out[base + w];
                    live_out[base + w] = scratch[w];
                    let ni = used_set[base + w] | (scratch[w] & !kill[base + w]);
                    if ni != live_in[base + w] {
                        live_in[base + w] = ni;
                        changed = true;
                    }
                }
            }
        }

        Self {
            words,
            live_in,
            live_out,
            block_of,
            last_use_pos,
        }
    }

    fn is_set(bits: &[u64], base: usize, v: ValueId) -> bool {
        bits[base + (v as usize) / 64] & (1u64 << ((v as usize) % 64)) != 0
    }

    fn live_in(&self, b: BlockId, v: ValueId) -> bool {
        Self::is_set(&self.live_in, b as usize * self.words, v)
    }

    fn live_out(&self, b: BlockId, v: ValueId) -> bool {
        Self::is_set(&self.live_out, b as usize * self.words, v)
    }

    /// Whether `x` is live at the program point immediately after `y`
    /// is defined. `y` names a value definition (an instruction
    /// index); `x` is any other value.
    fn live_just_after_def(&self, func: &FunctionSsa, x: ValueId, y: ValueId) -> bool {
        if x == y {
            return false;
        }
        let b = self.block_of[y as usize];
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
    /// The live set is a bit vector (the `live_out` rows' own shape)
    /// and the nodes currently live ride a counted sparse set, so a
    /// definition point emits each (def-node, live-node) edge exactly
    /// once with no per-edge allocation; the pair list is sorted,
    /// deduplicated, and laid out as a CSR row per node at the end.
    #[allow(dead_code)]
    pub(crate) fn interference(&self, func: &FunctionSsa, node_of: &[ValueId]) -> Interference {
        let n = func.insts.len();
        // Edges packed (low << 32) | high: one-word sort + dedup.
        let mut pairs: Vec<u64> = Vec::new();
        let mut live = LiveNodeSet::new(n, self.words);
        for (b, blk) in func.blocks.iter().enumerate() {
            live.seed(
                &self.live_out[b * self.words..(b + 1) * self.words],
                node_of,
            );
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
            for idx in (blk.inst_range.start..blk.inst_range.end).rev() {
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
        let n = func.insts.len();
        let mut out = vec![false; n];
        let mut live: Vec<u64> = vec![0; self.words];
        let set = |live: &mut [u64], v: ValueId| live[v as usize / 64] |= 1 << (v % 64);
        for (b, blk) in func.blocks.iter().enumerate() {
            let base = b * self.words;
            live.copy_from_slice(&self.live_out[base..base + self.words]);
            if blk.exit_acc != NO_VALUE && (blk.exit_acc as usize) < n {
                set(&mut live, blk.exit_acc);
            }
            match &blk.terminator {
                Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                    if (*cond as usize) < n {
                        set(&mut live, *cond);
                    }
                }
                Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. }
                    if (*target as usize) < n =>
                {
                    set(&mut live, *target);
                }
                Terminator::Return(v) if *v != NO_VALUE && (*v as usize) < n => {
                    set(&mut live, *v);
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
                    live[idx as usize / 64] &= !(1 << (idx % 64));
                }
                // After removing the call's own result (its definition
                // point), `live` holds exactly the values live at the
                // point just after the call returns. Each such value's
                // range spans the call.
                if is_call {
                    for (w, &word) in live.iter().enumerate() {
                        let mut bits = word;
                        while bits != 0 {
                            let v = (w as u32) * 64 + bits.trailing_zeros();
                            bits &= bits - 1;
                            out[v as usize] = true;
                        }
                    }
                }
                if !matches!(inst, Inst::Phi { .. }) {
                    super::reg_alloc::for_each_operand(inst, |op| {
                        if op != NO_VALUE && (op as usize) < n {
                            set(&mut live, op);
                        }
                    });
                }
            }
        }
        out
    }
}

/// LSD radix sort by 16-bit digits: the packed interference pairs
/// run to millions of keys, where counting passes beat comparison
/// sorting. Passes above the maximum key's width are skipped.
fn radix_sort_u64(keys: &mut [u64]) {
    if keys.len() < 64 {
        keys.sort_unstable();
        return;
    }
    let max = keys.iter().copied().max().unwrap_or(0);
    let mut scratch = alloc::vec![0u64; keys.len()];
    let mut counts = alloc::vec![0u32; 1 << 16];
    let mut src_is_keys = true;
    for pass in 0..4 {
        let shift = pass * 16;
        if max >> shift == 0 {
            break;
        }
        counts.iter_mut().for_each(|c| *c = 0);
        let (src, dst): (&[u64], &mut [u64]) = if src_is_keys {
            (keys, &mut scratch)
        } else {
            (&scratch, keys)
        };
        for &k in src {
            counts[((k >> shift) & 0xffff) as usize] += 1;
        }
        let mut sum = 0u32;
        for c in counts.iter_mut() {
            let v = *c;
            *c = sum;
            sum += v;
        }
        for &k in src {
            let d = ((k >> shift) & 0xffff) as usize;
            dst[counts[d] as usize] = k;
            counts[d] += 1;
        }
        src_is_keys = !src_is_keys;
    }
    if !src_is_keys {
        keys.copy_from_slice(&scratch);
    }
}

/// The values live at a sweep point, tracked at two granularities:
/// membership as a bit vector (the `live_out` rows' own shape) and
/// the distinct register-allocation nodes those values belong to as
/// a counted sparse set, so a definition can enumerate live nodes
/// without touching per-value state.
struct LiveNodeSet {
    bits: Vec<u64>,
    /// Live-value count per node; a node leaves `nodes` at zero.
    count: Vec<u32>,
    /// Compact list of nodes with a nonzero count.
    nodes: Vec<ValueId>,
    /// Position of a live node in `nodes` (swap-removed on exit).
    pos: Vec<u32>,
}

impl LiveNodeSet {
    fn new(n: usize, words: usize) -> Self {
        LiveNodeSet {
            bits: alloc::vec![0; words],
            count: alloc::vec![0; n],
            nodes: Vec::new(),
            pos: alloc::vec![u32::MAX; n],
        }
    }

    /// Reset to a block's live-out row.
    fn seed(&mut self, live_out: &[u64], node_of: &[ValueId]) {
        for &nd in &self.nodes {
            self.count[nd as usize] = 0;
            self.pos[nd as usize] = u32::MAX;
        }
        self.nodes.clear();
        self.bits.copy_from_slice(live_out);
        for (w, &word) in live_out.iter().enumerate() {
            let mut bits = word;
            while bits != 0 {
                let v = (w as u32) * 64 + bits.trailing_zeros();
                bits &= bits - 1;
                self.enter(node_of[v as usize]);
            }
        }
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
        let (w, m) = (v as usize / 64, 1u64 << (v % 64));
        if self.bits[w] & m != 0 {
            return;
        }
        self.bits[w] |= m;
        self.enter(node_of[v as usize]);
    }

    fn remove(&mut self, v: ValueId, node_of: &[ValueId]) {
        let (w, m) = (v as usize / 64, 1u64 << (v % 64));
        if self.bits[w] & m == 0 {
            return;
        }
        self.bits[w] &= !m;
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
    /// Nodes that interfere with `node`, ascending.
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
    fn from_pairs(n: usize, mut pairs: Vec<u64>) -> Self {
        radix_sort_u64(&mut pairs);
        pairs.dedup();
        let unpack = |p: u64| ((p >> 32) as usize, (p & 0xffff_ffff) as usize);
        let mut deg = alloc::vec![0u32; n];
        for &p in &pairs {
            let (a, b) = unpack(p);
            deg[a] += 1;
            deg[b] += 1;
        }
        let mut offsets = alloc::vec![0u32; n + 1];
        for i in 0..n {
            offsets[i + 1] = offsets[i] + deg[i];
        }
        let mut cursor: Vec<u32> = offsets[..n].to_vec();
        let mut edges = alloc::vec![0 as ValueId; offsets[n] as usize];
        // Pairs are sorted and each row's second-position entries (all
        // below the node id) fill before its first-position entries
        // (all above it), so every row comes out ascending.
        for &p in &pairs {
            let (a, b) = unpack(p);
            edges[cursor[a] as usize] = b as ValueId;
            cursor[a] += 1;
            edges[cursor[b] as usize] = a as ValueId;
            cursor[b] += 1;
        }
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
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
            is_naked: false,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            param_fp_mask: 0,
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            ret_type_tag: 0,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            has_returns_twice_call: false,
            did_unroll: false,
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

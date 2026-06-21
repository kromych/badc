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

use alloc::collections::BTreeSet;
use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{BlockId, FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};

pub(super) struct Liveness {
    words: usize,
    /// `live_in[b*words .. ]` / `live_out[b*words .. ]`: bitset of
    /// values live on entry to / exit from block `b`.
    live_in: Vec<u64>,
    live_out: Vec<u64>,
    /// Defining block per value.
    block_of: Vec<BlockId>,
}

impl Liveness {
    pub(super) fn compute(func: &FunctionSsa) -> Self {
        let nblocks = func.blocks.len();
        let n = func.insts.len();
        let words = n.div_ceil(64).max(1);

        let mut block_of: Vec<BlockId> = vec![0; n];
        for (b, blk) in func.blocks.iter().enumerate() {
            for v in blk.inst_range.clone() {
                block_of[v as usize] = b as BlockId;
            }
        }

        if nblocks == 0 {
            return Self {
                words,
                live_in: Vec::new(),
                live_out: Vec::new(),
                block_of,
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
                super::ssa_alloc::for_each_operand(&func.insts[idx as usize], &mut mark);
            }
            if blk.exit_acc != NO_VALUE {
                mark(blk.exit_acc);
            }
            match &blk.terminator {
                Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => mark(*cond),
                Terminator::GotoIndirect { target } if *target != NO_VALUE => mark(*target),
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
                for s in super::ssa_mem2reg::successors(
                    &func.blocks[b].terminator,
                    &func.computed_goto_targets,
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

    /// Whether `x` is used as a non-phi operand or terminator operand
    /// in block `b` at an instruction index strictly greater than `y`.
    fn block_has_use_after(&self, func: &FunctionSsa, b: BlockId, x: ValueId, y: ValueId) -> bool {
        let blk = &func.blocks[b as usize];
        for idx in (y + 1)..blk.inst_range.end {
            if matches!(func.insts[idx as usize], Inst::Phi { .. }) {
                continue;
            }
            let mut found = false;
            super::ssa_alloc::for_each_operand(&func.insts[idx as usize], |op| {
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
            Terminator::GotoIndirect { target } => *target == x,
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
    pub(super) fn live_after(&self, func: &FunctionSsa, v: ValueId, point: ValueId) -> bool {
        self.live_just_after_def(func, v, point)
    }

    /// Whether `a` and `b` are ever simultaneously live. Two
    /// single-definition values interfere iff one definition lies in
    /// the other's live range.
    pub(super) fn interfere(&self, func: &FunctionSsa, a: ValueId, b: ValueId) -> bool {
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
    #[allow(dead_code)]
    pub(super) fn interference(&self, func: &FunctionSsa, node_of: &[ValueId]) -> Interference {
        let n = func.insts.len();
        let mut adj: Vec<BTreeSet<ValueId>> = (0..n).map(|_| BTreeSet::new()).collect();
        for (b, blk) in func.blocks.iter().enumerate() {
            let mut live: BTreeSet<ValueId> = BTreeSet::new();
            let base = b * self.words;
            for w in 0..self.words {
                let mut bits = self.live_out[base + w];
                while bits != 0 {
                    live.insert((w as u32) * 64 + bits.trailing_zeros());
                    bits &= bits - 1;
                }
            }
            if blk.exit_acc != NO_VALUE && (blk.exit_acc as usize) < n {
                live.insert(blk.exit_acc);
            }
            match &blk.terminator {
                Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                    if (*cond as usize) < n {
                        live.insert(*cond);
                    }
                }
                Terminator::GotoIndirect { target } if (*target as usize) < n => {
                    live.insert(*target);
                }
                Terminator::Return(v) if *v != NO_VALUE && (*v as usize) < n => {
                    live.insert(*v);
                }
                _ => {}
            }
            for idx in (blk.inst_range.start..blk.inst_range.end).rev() {
                let inst = &func.insts[idx as usize];
                if super::ssa_alloc::produces_value(inst) {
                    let di = node_of[idx as usize];
                    for &x in &live {
                        let xi = node_of[x as usize];
                        if di != xi {
                            adj[di as usize].insert(xi);
                            adj[xi as usize].insert(di);
                        }
                    }
                    live.remove(&idx);
                }
                if !matches!(inst, Inst::Phi { .. }) {
                    super::ssa_alloc::for_each_operand(inst, |op| {
                        if op != NO_VALUE && (op as usize) < n {
                            live.insert(op);
                        }
                    });
                }
            }
        }
        Interference { adj }
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
    /// is wrongly judged not to cross it. `luaV_execute`'s dispatch
    /// loop is exactly that shape: a value defined in the loop body and
    /// used again after the back-edge crosses the body's calls without
    /// the linear interval covering them.
    pub(super) fn values_live_across_calls(
        &self,
        func: &FunctionSsa,
        tls_addr_is_call: bool,
    ) -> Vec<bool> {
        let n = func.insts.len();
        let mut out = vec![false; n];
        for (b, blk) in func.blocks.iter().enumerate() {
            let mut live: BTreeSet<ValueId> = BTreeSet::new();
            let base = b * self.words;
            for w in 0..self.words {
                let mut bits = self.live_out[base + w];
                while bits != 0 {
                    live.insert((w as u32) * 64 + bits.trailing_zeros());
                    bits &= bits - 1;
                }
            }
            if blk.exit_acc != NO_VALUE && (blk.exit_acc as usize) < n {
                live.insert(blk.exit_acc);
            }
            match &blk.terminator {
                Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                    if (*cond as usize) < n {
                        live.insert(*cond);
                    }
                }
                Terminator::GotoIndirect { target } if (*target as usize) < n => {
                    live.insert(*target);
                }
                Terminator::Return(v) if *v != NO_VALUE && (*v as usize) < n => {
                    live.insert(*v);
                }
                _ => {}
            }
            for idx in (blk.inst_range.start..blk.inst_range.end).rev() {
                let inst = &func.insts[idx as usize];
                let is_call = matches!(
                    inst,
                    Inst::Call { .. } | Inst::CallIndirect { .. } | Inst::CallExt { .. }
                ) || (tls_addr_is_call && matches!(inst, Inst::TlsAddr(_)));
                if super::ssa_alloc::produces_value(inst) {
                    live.remove(&idx);
                }
                // After removing the call's own result (its definition
                // point), `live` holds exactly the values live at the
                // point just after the call returns. Each such value's
                // range spans the call.
                if is_call {
                    for &x in &live {
                        out[x as usize] = true;
                    }
                }
                if !matches!(inst, Inst::Phi { .. }) {
                    super::ssa_alloc::for_each_operand(inst, |op| {
                        if op != NO_VALUE && (op as usize) < n {
                            live.insert(op);
                        }
                    });
                }
            }
        }
        out
    }
}

/// Interference graph over register-allocation nodes (phi-congruence
/// roots). `adj[node]` lists the nodes that must not share a register
/// with `node`. Non-node value ids have empty entries.
pub(super) struct Interference {
    adj: Vec<BTreeSet<ValueId>>,
}

#[allow(dead_code)]
impl Interference {
    /// Nodes that interfere with `node`.
    pub(super) fn neighbors(&self, node: ValueId) -> &BTreeSet<ValueId> {
        &self.adj[node as usize]
    }

    /// Number of nodes that interfere with `node`.
    pub(super) fn degree(&self, node: ValueId) -> usize {
        self.adj[node as usize].len()
    }

    /// Build a graph directly from an edge list, for unit tests that
    /// exercise coloring without constructing a whole function.
    #[cfg(test)]
    pub(super) fn from_edges(n: usize, edges: &[(ValueId, ValueId)]) -> Self {
        let mut adj: Vec<BTreeSet<ValueId>> = (0..n).map(|_| BTreeSet::new()).collect();
        for &(a, b) in edges {
            adj[a as usize].insert(b);
            adj[b as usize].insert(a);
        }
        Self { adj }
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
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            param_fp_mask: 0,
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
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

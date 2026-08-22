//! Dominator-scoped common-subexpression elimination for pure
//! arithmetic and address values, gated on register pressure.
//!
//! The builder's value cache (`ssa/build.rs`) merges duplicates inside a
//! block and resets at block boundaries, so a computation repeated in a
//! dominated block survives to emit; the inliner's splices add more, and
//! `dedup_imm` only canonicalises data / code / TLS address immediates.
//! This pass numbers pure values over the dominator tree and redirects a
//! duplicate's consumers to the dominating leader.
//!
//! A merge trades a recomputation for a live range covering the region
//! between leader and duplicate -- the blocks backward-reachable from
//! the duplicate up to the leader's block, so the whole loop body when
//! the duplicate sits in a loop the leader is outside of. It is taken
//! only when the region's peak live-value count plus the leader and a
//! headroom fits the register bank, the count at any call in the region
//! fits the callee-saved bank (where a range spanning a call must go),
//! and no block of the region nests deeper in a loop than the duplicate.
//! The headroom widens as the duplicate gets cheaper to recompute, and
//! is widest for the operand-free values, which rematerialise anywhere.
//!
//! Not numbered: values with no consumers, comparisons a branch consumes
//! alone (a second use costs them the flag-branch fusion), memory reads
//! (no aliasing analysis here), and phis.
//!
//! Determinism: a fixed dominator-tree DFS fills the leader map and a
//! tape-order rewrite consumes it, so no hash order reaches the output.

use crate::c5::codegen::ssa::liveness::BlockLiveness;
use crate::c5::codegen::ssa::reg_alloc::{
    BankCapacity, compute_use_counts, produces_fp_result, produces_value,
};
use crate::c5::ir::{
    BinOp, BlockId, FpCastKind, FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator, ValueId,
};
use alloc::vec::Vec;
use hashbrown::HashMap;

const NO_BLOCK: BlockId = BlockId::MAX;
const MAX_REGION_BLOCKS: usize = 24;
const MAX_REGION_INSTS: u32 = 256;

const GPR: usize = 0;
const FP: usize = 1;

/// Value-number key over leader-resolved operands: equal keys, equal
/// values. Every variant carries the `f32_values` flag, which is part of
/// a value's identity and which the operands do not fix -- a `(double)x`
/// and a `(float)x` are one `FpCast` shape over one operand.
#[derive(PartialEq, Eq, Hash, Clone, Copy)]
enum Key {
    Imm(i64, bool),
    LocalAddr(i64, bool),
    Binop(BinOp, ValueId, ValueId, bool),
    BinopI(BinOp, ValueId, i64, bool),
    Extend(ValueId, LoadKind, bool),
    Bswap(ValueId, u8, bool),
    Fneg(ValueId, bool),
    FpCast(FpCastKind, ValueId, bool),
    Fma(ValueId, ValueId, ValueId, bool, bool, bool),
}

pub(crate) fn run(funcs: &mut [FunctionSsa], caps: BankCapacity) {
    for func in funcs {
        run_one(func, caps);
    }
}

/// `a op b == b op a` for integer arithmetic and equality (C99 6.5.5,
/// 6.5.9, 6.5.10-12). The FP kinds keep their operand order.
fn commutative_int(op: BinOp) -> bool {
    matches!(
        op,
        BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor | BinOp::Eq | BinOp::Ne
    )
}

fn is_compare(op: BinOp) -> bool {
    matches!(
        op,
        BinOp::Eq
            | BinOp::Ne
            | BinOp::Lt
            | BinOp::Gt
            | BinOp::Le
            | BinOp::Ge
            | BinOp::Ult
            | BinOp::Ugt
            | BinOp::Ule
            | BinOp::Uge
            | BinOp::Feq
            | BinOp::Fne
            | BinOp::Flt
            | BinOp::Fgt
            | BinOp::Fle
            | BinOp::Fge
    )
}

fn is_call(inst: &Inst) -> bool {
    matches!(
        inst,
        Inst::Call { .. }
            | Inst::CallExt { .. }
            | Inst::CallIndirect { .. }
            | Inst::Intrinsic { .. }
            | Inst::InlineAsm { .. }
    )
}

fn remat_cost(inst: &Inst) -> u32 {
    match inst {
        Inst::Imm(k) => {
            if (-0x8000..0x10000).contains(k) {
                1
            } else {
                2
            }
        }
        Inst::Binop { op, .. } | Inst::BinopI { op, .. } => match op {
            BinOp::Mul => 3,
            BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu => 12,
            BinOp::Fdiv => 8,
            BinOp::Fadd | BinOp::Fsub | BinOp::Fmul => 3,
            _ => 1,
        },
        Inst::Fma { .. } | Inst::FpCast { .. } => 3,
        _ => 1,
    }
}

/// Free registers a merge must leave, capped so a small bank still merges.
fn headroom(inst: &Inst, capacity: u32) -> u32 {
    let want = match (inst, remat_cost(inst)) {
        (Inst::Imm(_) | Inst::LocalAddr(_), _) => 4,
        (_, 0..=2) => 2,
        (_, 3..=7) => 1,
        _ => 0,
    };
    want.min(capacity / 3)
}

/// Live-value counts per bank, measured over the pre-merge code.
struct Pressure {
    at: Vec<[u32; 2]>,
    /// Per-block maximum of `at`, and of `at` over the block's calls.
    block_peak: Vec<[u32; 2]>,
    block_call_peak: Vec<[u32; 2]>,
    call_at: Vec<bool>,
}

struct LiveCount<'a> {
    live: Vec<bool>,
    touched: Vec<ValueId>,
    cnt: [u32; 2],
    bank: &'a [u8],
}

impl LiveCount<'_> {
    fn add(&mut self, v: ValueId) {
        let Some(&bank) = self.bank.get(v as usize) else {
            return;
        };
        if bank == u8::MAX || self.live[v as usize] {
            return;
        }
        self.live[v as usize] = true;
        self.touched.push(v);
        self.cnt[bank as usize] += 1;
    }

    fn remove(&mut self, v: ValueId) {
        if !matches!(self.live.get(v as usize), Some(true)) {
            return;
        }
        self.live[v as usize] = false;
        self.cnt[self.bank[v as usize] as usize] -= 1;
    }

    fn reset(&mut self) {
        for &v in &self.touched {
            self.live[v as usize] = false;
        }
        self.touched.clear();
        self.cnt = [0, 0];
    }
}

fn pressure(func: &FunctionSsa) -> Pressure {
    let n = func.insts.len();
    let live_sets = BlockLiveness::compute(func);
    // Bank per value, `u8::MAX` for one the allocator never places.
    let bank: Vec<u8> = func
        .insts
        .iter()
        .map(|i| match (produces_value(i), produces_fp_result(i)) {
            (false, _) => u8::MAX,
            (true, true) => FP as u8,
            (true, false) => GPR as u8,
        })
        .collect();
    let mut p = Pressure {
        at: alloc::vec![[0; 2]; n],
        block_peak: alloc::vec![[0; 2]; func.blocks.len()],
        block_call_peak: alloc::vec![[0; 2]; func.blocks.len()],
        call_at: alloc::vec![false; n],
    };
    let mut lc = LiveCount {
        live: alloc::vec![false; n],
        touched: Vec::new(),
        cnt: [0, 0],
        bank: &bank,
    };
    for (b, blk) in func.blocks.iter().enumerate() {
        lc.reset();
        live_sets.for_each_live_out(b as BlockId, |v| lc.add(v));
        if blk.exit_acc != NO_VALUE {
            lc.add(blk.exit_acc);
        }
        let mut term = blk.terminator;
        term.for_each_operand_mut(|v| lc.add(*v));
        for idx in blk.inst_range.clone().rev() {
            let i = idx as usize;
            if i >= n {
                continue;
            }
            p.at[i] = lc.cnt;
            for k in 0..2 {
                p.block_peak[b][k] = p.block_peak[b][k].max(lc.cnt[k]);
            }
            if is_call(&func.insts[i]) {
                p.call_at[i] = true;
                for k in 0..2 {
                    p.block_call_peak[b][k] = p.block_call_peak[b][k].max(lc.cnt[k]);
                }
            }
            lc.remove(idx);
            // Phi operands are edge uses, in the predecessors' live-out.
            if !matches!(func.insts[i], Inst::Phi { .. }) {
                func.insts[i].for_each_operand(|op| lc.add(op));
            }
        }
    }
    p
}

/// Values a `Bz` / `Bnz` consumes alone, through the zero-test chain
/// `constfold_branch::strip_zero_test_conds` strips: the allocator
/// fuses such a comparison into the branch.
fn branch_pinned(func: &FunctionSsa, use_counts: &[u32]) -> Vec<bool> {
    let n = func.insts.len();
    let mut pinned = alloc::vec![false; n];
    for blk in &func.blocks {
        let (Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. }) = blk.terminator else {
            continue;
        };
        let mut v = cond;
        for _ in 0..n {
            if v == NO_VALUE || v as usize >= n || use_counts[v as usize] != 1 {
                break;
            }
            let (op, lhs) = match &func.insts[v as usize] {
                Inst::Binop { op, lhs, rhs }
                    if matches!(func.insts.get(*rhs as usize), Some(Inst::Imm(0))) =>
                {
                    (*op, Some(*lhs))
                }
                Inst::BinopI {
                    op,
                    lhs,
                    rhs_imm: 0,
                } => (*op, Some(*lhs)),
                Inst::Binop { op, .. } | Inst::BinopI { op, .. } => (*op, None),
                _ => break,
            };
            if !is_compare(op) {
                break;
            }
            if blk.inst_range.contains(&v) {
                pinned[v as usize] = true;
            }
            match (op, lhs) {
                (BinOp::Eq | BinOp::Ne, Some(next)) => v = next,
                _ => break,
            }
        }
    }
    pinned
}

/// Dominator-tree entry / exit stamps, so dominance is a range test.
fn dom_stamps(children: &[Vec<BlockId>]) -> (Vec<u32>, Vec<u32>) {
    let nb = children.len();
    let mut tin = alloc::vec![u32::MAX; nb];
    let mut tout = alloc::vec![0u32; nb];
    let mut clock = 0u32;
    let mut stack: Vec<(BlockId, bool)> = alloc::vec![(0, false)];
    while let Some((b, done)) = stack.pop() {
        if done {
            tout[b as usize] = clock;
            continue;
        }
        if tin[b as usize] != u32::MAX {
            continue;
        }
        tin[b as usize] = clock;
        clock += 1;
        stack.push((b, true));
        for &c in children[b as usize].iter().rev() {
            stack.push((c, false));
        }
    }
    (tin, tout)
}

/// Natural-loop nesting depth per block: a back edge's head dominates
/// its tail, and its body reaches the tail without passing the head.
fn loop_depth(preds: &[Vec<BlockId>], tin: &[u32], tout: &[u32]) -> Vec<u32> {
    let nb = preds.len();
    let mut depth = alloc::vec![0u32; nb];
    let mut stamp = alloc::vec![u32::MAX; nb];
    let (mut stamp_gen, mut stack, mut body) = (0u32, Vec::new(), Vec::new());
    for v in 0..nb {
        if tin[v] == u32::MAX {
            continue;
        }
        for &u in &preds[v] {
            let back = tin[u as usize] != u32::MAX
                && tin[v] <= tin[u as usize]
                && tout[u as usize] <= tout[v];
            if !back {
                continue;
            }
            stamp[v] = stamp_gen;
            body.clear();
            body.push(v as BlockId);
            stack.clear();
            stack.push(u);
            while let Some(x) = stack.pop() {
                if stamp[x as usize] == stamp_gen {
                    continue;
                }
                stamp[x as usize] = stamp_gen;
                body.push(x);
                stack.extend_from_slice(&preds[x as usize]);
            }
            for &b in &body {
                depth[b as usize] += 1;
            }
            stamp_gen += 1;
        }
    }
    depth
}

/// A merge's cost: peak live count over its region, count at its calls,
/// deepest loop nesting reached.
struct Cost {
    peak: [u32; 2],
    call_peak: Option<[u32; 2]>,
    hottest: u32,
}

/// The analyses the gate reads, plus the scratch its region walk reuses.
struct Gate<'a> {
    preds: &'a [Vec<BlockId>],
    p: &'a Pressure,
    depth: &'a [u32],
    caps: BankCapacity,
    seen: Vec<u32>,
    stamp_gen: u32,
    stack: Vec<BlockId>,
    /// What the merges already taken added, whole-block over a region's
    /// interior and per instruction over its endpoint stretches (with
    /// the per-block maximum of those alongside). `Pressure` measures
    /// the code as it arrived, so without this a run of merges over one
    /// region would each see the same headroom and jointly overrun it.
    extra_block: Vec<[u32; 2]>,
    extra_inst: Vec<[u32; 2]>,
    extra_inst_peak: Vec<[u32; 2]>,
    /// What the last `region_cost` covered, replayed when it commits.
    region: Vec<BlockId>,
    spans: Vec<(BlockId, ValueId, ValueId)>,
}

impl Gate<'_> {
    /// Fold one stretch of a block into the cost, recording it.
    fn span(&mut self, c: &mut Cost, blk: BlockId, lo: ValueId, hi: ValueId) -> bool {
        if hi.saturating_sub(lo) > MAX_REGION_INSTS {
            return false;
        }
        let base = self.extra_block[blk as usize];
        for i in lo..hi {
            let at = self.p.at[i as usize];
            let add = self.extra_inst[i as usize];
            for (k, &v) in at.iter().enumerate() {
                c.peak[k] = c.peak[k].max(v + add[k] + base[k]);
            }
            if self.p.call_at[i as usize] {
                let cp = c.call_peak.get_or_insert([0; 2]);
                for (k, &v) in at.iter().enumerate() {
                    cp[k] = cp[k].max(v + add[k] + base[k]);
                }
            }
        }
        self.spans.push((blk, lo, hi));
        true
    }

    /// Fold a whole interior block into the cost.
    fn whole(&mut self, c: &mut Cost, x: BlockId) {
        self.region.push(x);
        for k in 0..2 {
            let add = self.extra_block[x as usize][k] + self.extra_inst_peak[x as usize][k];
            c.peak[k] = c.peak[k].max(self.p.block_peak[x as usize][k] + add);
            if self.p.block_call_peak[x as usize][k] != 0 {
                let cp = c.call_peak.get_or_insert([0; 2]);
                cp[k] = cp[k].max(self.p.block_call_peak[x as usize][k] + add);
            }
        }
        c.hottest = c.hottest.max(self.depth[x as usize]);
    }

    fn region_cost(
        &mut self,
        func: &FunctionSsa,
        lb: BlockId,
        b: BlockId,
        leader: ValueId,
        dup: ValueId,
    ) -> Option<Cost> {
        let mut c = Cost {
            peak: [0; 2],
            call_peak: None,
            hottest: self.depth[b as usize].max(self.depth[lb as usize]),
        };
        self.region.clear();
        self.spans.clear();
        if lb == b {
            return self.span(&mut c, lb, leader, dup + 1).then_some(c);
        }
        // Blocks from the leader's to the duplicate's, walked backward.
        self.stamp_gen += 1;
        self.seen[lb as usize] = self.stamp_gen;
        self.stack.clear();
        self.stack.extend_from_slice(&self.preds[b as usize]);
        let mut count = 0usize;
        while let Some(x) = self.stack.pop() {
            if self.seen[x as usize] == self.stamp_gen {
                continue;
            }
            self.seen[x as usize] = self.stamp_gen;
            count += 1;
            if count > MAX_REGION_BLOCKS {
                return None;
            }
            self.whole(&mut c, x);
            self.stack.extend_from_slice(&self.preds[x as usize]);
        }
        // An endpoint contributes its covered stretch; a loop that
        // re-entered the duplicate's block already folded all of it in.
        if self.seen[b as usize] != self.stamp_gen
            && !self.span(&mut c, b, func.blocks[b as usize].inst_range.start, dup + 1)
        {
            return None;
        }
        if !self.span(&mut c, lb, leader, func.blocks[lb as usize].inst_range.end) {
            return None;
        }
        Some(c)
    }

    /// Whether the leader reaches the duplicate without overrunning a
    /// bank or pinning a register through hotter code. Charges the
    /// region on success, so the next merge sees this one.
    fn pays(
        &mut self,
        func: &FunctionSsa,
        lb: BlockId,
        b: BlockId,
        leader: ValueId,
        dup: ValueId,
    ) -> bool {
        if lb == NO_BLOCK {
            return false;
        }
        let bank = if produces_fp_result(&func.insts[leader as usize]) {
            FP
        } else {
            GPR
        };
        let need = 1 + headroom(&func.insts[dup as usize], self.caps.total[bank]);
        let Some(c) = self.region_cost(func, lb, b, leader, dup) else {
            return false;
        };
        if c.hottest > self.depth[b as usize] || c.peak[bank] + need > self.caps.total[bank] {
            return false;
        }
        if let Some(cp) = c.call_peak
            && cp[bank] + need > self.caps.callee[bank]
        {
            return false;
        }
        for &x in &self.region {
            self.extra_block[x as usize][bank] += 1;
        }
        for &(blk, lo, hi) in &self.spans {
            for i in lo..hi {
                let v = self.extra_inst[i as usize][bank] + 1;
                self.extra_inst[i as usize][bank] = v;
                let peak = &mut self.extra_inst_peak[blk as usize][bank];
                *peak = (*peak).max(v);
            }
        }
        true
    }
}

fn key_of(inst: &Inst, vn: &[ValueId], is_f32: bool) -> Option<Key> {
    let r = |v: ValueId| resolve_vn(vn, v);
    match inst {
        Inst::Imm(k) => Some(Key::Imm(*k, is_f32)),
        Inst::LocalAddr(off) => Some(Key::LocalAddr(*off, is_f32)),
        Inst::Binop { op, lhs, rhs } => {
            let (mut a, mut b) = (r(*lhs), r(*rhs));
            if commutative_int(*op) && a > b {
                core::mem::swap(&mut a, &mut b);
            }
            Some(Key::Binop(*op, a, b, is_f32))
        }
        Inst::BinopI { op, lhs, rhs_imm } => Some(Key::BinopI(*op, r(*lhs), *rhs_imm, is_f32)),
        Inst::Extend { value, kind } => Some(Key::Extend(r(*value), *kind, is_f32)),
        Inst::Bswap { value, width } => Some(Key::Bswap(r(*value), *width, is_f32)),
        Inst::Fneg(v) => Some(Key::Fneg(r(*v), is_f32)),
        Inst::FpCast { kind, value } => Some(Key::FpCast(*kind, r(*value), is_f32)),
        Inst::Fma {
            a,
            b,
            c,
            neg_product,
            neg_addend,
        } => Some(Key::Fma(
            r(*a),
            r(*b),
            r(*c),
            *neg_product,
            *neg_addend,
            is_f32,
        )),
        _ => None,
    }
}

/// Resolve through the leader map. Guarded against a cycle.
fn resolve_vn(vn: &[ValueId], mut v: ValueId) -> ValueId {
    let mut guard = 0u32;
    while (v as usize) < vn.len() && vn[v as usize] != v {
        v = vn[v as usize];
        guard += 1;
        if guard > vn.len() as u32 {
            break;
        }
    }
    v
}

fn resolve(redirect: &[Option<ValueId>], mut v: ValueId) -> ValueId {
    let mut guard = 0u32;
    while v != NO_VALUE && (v as usize) < redirect.len() {
        match redirect[v as usize] {
            Some(t) if t != v => {
                v = t;
                guard += 1;
                if guard > redirect.len() as u32 {
                    break;
                }
            }
            _ => break,
        }
    }
    v
}

fn run_one(func: &mut FunctionSsa, caps: BankCapacity) {
    let n = func.insts.len();
    let nb = func.blocks.len();
    if n == 0 || nb == 0 {
        return;
    }
    let idom = crate::c5::codegen::ssa::mem2reg::dominators(func);
    let preds = crate::c5::codegen::ssa::mem2reg::predecessors(func);
    let mut children: Vec<Vec<BlockId>> = alloc::vec![Vec::new(); nb];
    for (b, &id) in idom.iter().enumerate().skip(1) {
        if id != NO_BLOCK {
            children[id as usize].push(b as BlockId);
        }
    }
    let (tin, tout) = dom_stamps(&children);
    let depth = loop_depth(&preds, &tin, &tout);
    let use_counts = compute_use_counts(func);
    let pinned = branch_pinned(func, &use_counts);
    let p = pressure(func);
    let mut gate = Gate {
        preds: &preds,
        p: &p,
        depth: &depth,
        caps,
        seen: alloc::vec![u32::MAX; nb],
        stamp_gen: 0,
        stack: Vec::new(),
        extra_block: alloc::vec![[0; 2]; nb],
        extra_inst: alloc::vec![[0; 2]; n],
        extra_inst_peak: alloc::vec![[0; 2]; nb],
        region: Vec::new(),
        spans: Vec::new(),
    };

    let mut inst_block = alloc::vec![NO_BLOCK; n];
    for (bid, block) in func.blocks.iter().enumerate() {
        for idx in block.inst_range.clone() {
            if let Some(slot) = inst_block.get_mut(idx as usize) {
                *slot = bid as BlockId;
            }
        }
    }

    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; n];
    let mut vn: Vec<ValueId> = (0..n as ValueId).collect();
    let mut map: HashMap<Key, ValueId> = HashMap::new();
    // Per-subtree shadow stack: `(key, previous)` to restore on exit.
    let mut undo: Vec<(Key, Option<ValueId>)> = Vec::new();
    let mut any = false;

    enum Action {
        Enter(BlockId),
        Exit(usize),
    }
    let mut work: Vec<Action> = alloc::vec![Action::Enter(0)];
    while let Some(act) = work.pop() {
        match act {
            Action::Enter(b) => {
                let marker = undo.len();
                for idx in func.blocks[b as usize].inst_range.clone() {
                    let i = idx as usize;
                    if i >= n {
                        break;
                    }
                    // Nothing reads it, or its branch consumes it alone.
                    if use_counts[i] == 0 || pinned[i] {
                        continue;
                    }
                    let is_f32 = func.f32_values.get(i).copied().unwrap_or(false);
                    let Some(key) = key_of(&func.insts[i], &vn, is_f32) else {
                        continue;
                    };
                    if let Some(&leader) = map.get(&key)
                        && leader < idx
                        && gate.pays(func, inst_block[leader as usize], b, leader, idx)
                    {
                        redirect[i] = Some(leader);
                        vn[i] = leader;
                        any = true;
                        continue;
                    }
                    // No affordable leader: lead the subtree from here.
                    undo.push((key, map.insert(key, idx)));
                }
                work.push(Action::Exit(marker));
                for &c in children[b as usize].iter().rev() {
                    work.push(Action::Enter(c));
                }
            }
            Action::Exit(marker) => {
                while undo.len() > marker {
                    let (key, prev) = undo.pop().unwrap();
                    match prev {
                        Some(v) => {
                            map.insert(key, v);
                        }
                        None => {
                            map.remove(&key);
                        }
                    }
                }
            }
        }
    }

    if !any {
        return;
    }
    for inst in func.insts.iter_mut() {
        inst.for_each_operand_mut(|op| *op = resolve(&redirect, *op));
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            block.exit_acc = resolve(&redirect, block.exit_acc);
        }
        block
            .terminator
            .for_each_operand_mut(|v| *v = resolve(&redirect, *v));
    }
}

#[cfg(test)]
mod tests {
    use super::{BankCapacity, run_one};
    use crate::c5::ir::{BinOp, Block, FpCastKind, FunctionSsa, Inst, Terminator, ValueId};
    use alloc::vec::Vec;

    fn fresh(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
            is_noinline: false,
            is_naked: false,
            section: None,
            is_weak: false,
            is_internal: false,
            const_params: 0,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            param_fp_mask: 0,
            agg_descs: Vec::new(),
            param_aggs: Vec::new(),
            param_local_slots: Vec::new(),
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

    /// Registers the gate may hand out, the same count in both banks.
    fn caps(total: u32, callee: u32) -> BankCapacity {
        BankCapacity {
            total: [total, total],
            callee: [callee, callee],
        }
    }

    fn add(l: ValueId, r: ValueId) -> Inst {
        Inst::Binop {
            op: BinOp::Add,
            lhs: l,
            rhs: r,
        }
    }

    fn muli(l: ValueId, k: i64) -> Inst {
        Inst::BinopI {
            op: BinOp::Mul,
            lhs: l,
            rhs_imm: k,
        }
    }

    fn blk(range: core::ops::Range<u32>, term: Terminator, acc: ValueId) -> Block {
        Block {
            start_pc: 0,
            inst_range: range,
            terminator: term,
            exit_acc: acc,
        }
    }

    fn bz(cond: ValueId, target: u32, fall_through: u32) -> Terminator {
        Terminator::Bz {
            cond,
            target,
            fall_through,
        }
    }

    fn return_val(f: &FunctionSsa, block: usize) -> ValueId {
        match f.blocks[block].terminator {
            Terminator::Return(v) => v,
            other => panic!("expected Return, got {other:?}"),
        }
    }

    /// b0: v2 = v0 + v1, branch;  b1: v3 = v0 + v1, return v3.
    /// b0 dominates b1, so v3 is a duplicate of a computation already
    /// available on every path reaching it.
    fn dominated_dup() -> FunctionSsa {
        fresh(
            alloc::vec![Inst::Imm(3), Inst::Imm(5), add(0, 1), add(0, 1)],
            alloc::vec![
                blk(0..3, bz(2, 2, 1), 2),
                blk(3..4, Terminator::Return(3), 3),
                blk(4..4, Terminator::Return(0), 0),
            ],
        )
    }

    #[test]
    fn dominated_duplicate_redirects_to_the_leader() {
        let mut f = dominated_dup();
        run_one(&mut f, caps(16, 8));
        assert_eq!(return_val(&f, 1), 2, "b1 dup must reuse the b0 leader");
    }

    /// The same function with a bank too small to hold the region's live
    /// values plus the leader: the merge would spill, so it is declined.
    #[test]
    fn pressure_gate_declines_a_merge_that_would_spill() {
        let mut f = dominated_dup();
        run_one(&mut f, caps(3, 3));
        assert_eq!(
            return_val(&f, 1),
            3,
            "a merge that overruns the bank must not happen"
        );
    }

    /// b1 and b2 are siblings, so b1's computation is not available on
    /// the path through b2 and the scoped map must not leak it.
    #[test]
    fn sibling_block_duplicate_is_not_merged() {
        let mut f = fresh(
            alloc::vec![Inst::Imm(3), Inst::Imm(5), muli(0, 7), add(0, 1), add(0, 1)],
            alloc::vec![
                blk(0..3, bz(2, 2, 1), 2),
                blk(3..4, Terminator::Return(3), 3),
                blk(4..5, Terminator::Return(4), 4),
            ],
        );
        run_one(&mut f, caps(16, 8));
        assert_eq!(return_val(&f, 2), 4, "no dominance, no merge");
    }

    /// The leader sits before a loop and the duplicate after it, so the
    /// merge would pin a register through every iteration to save one
    /// instruction outside. The loop-depth rule declines it.
    #[test]
    fn merge_through_a_hotter_loop_is_declined() {
        let mut f = fresh(
            alloc::vec![
                Inst::Imm(3),
                Inst::Imm(5),
                add(0, 1),
                muli(2, 3),
                Inst::Imm(1),
                muli(4, 2),
                add(0, 1)
            ],
            alloc::vec![
                blk(0..4, bz(3, 2, 1), 3),
                blk(4..6, bz(5, 2, 1), 5),
                blk(6..7, Terminator::Return(6), 6),
            ],
        );
        run_one(&mut f, caps(16, 8));
        assert_eq!(return_val(&f, 2), 6, "the loop in the region blocks it");
    }

    /// A comparison whose only consumer is its block's branch fuses into
    /// that branch; a second use would force it to materialise, so it is
    /// neither leader nor duplicate.
    #[test]
    fn branch_fused_comparison_is_not_numbered() {
        let cmp = |l: ValueId, r: ValueId| Inst::Binop {
            op: BinOp::Lt,
            lhs: l,
            rhs: r,
        };
        let mut f = fresh(
            alloc::vec![Inst::Imm(3), Inst::Imm(5), cmp(0, 1), cmp(0, 1)],
            alloc::vec![
                blk(0..3, bz(2, 2, 1), 2),
                blk(3..4, Terminator::Return(3), 3),
                blk(4..4, Terminator::Return(0), 0),
            ],
        );
        run_one(&mut f, caps(16, 8));
        assert_eq!(return_val(&f, 1), 3, "a fused comparison must stay alone");
    }

    fn dup_across_call() -> FunctionSsa {
        let call = Inst::CallExt {
            binding_idx: 0,
            args: Vec::new(),
            fp_arg_mask: 0,
            fp_return: false,
            arg_aggs: Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        };
        fresh(
            alloc::vec![Inst::Imm(3), Inst::Imm(5), add(0, 1), call, add(0, 1)],
            alloc::vec![
                blk(0..4, bz(2, 2, 1), 2),
                blk(4..5, Terminator::Return(4), 4),
                blk(5..5, Terminator::Return(0), 0),
            ],
        )
    }

    /// A leader whose extended range spans a call must live in a
    /// callee-saved register. With that bank empty the merge is declined.
    #[test]
    fn merge_across_a_call_needs_the_callee_saved_bank() {
        let mut f = dup_across_call();
        run_one(&mut f, caps(16, 0));
        assert_eq!(return_val(&f, 1), 4, "no callee-saved register, no merge");
        let mut f = dup_across_call();
        run_one(&mut f, caps(16, 8));
        assert_eq!(return_val(&f, 1), 2, "a callee-saved bank admits it");
    }

    /// One conversion shape over one operand at two result widths is two
    /// values: `f32_values` is part of the key.
    #[test]
    fn result_width_separates_two_conversions() {
        let cast = |v: ValueId| Inst::FpCast {
            kind: FpCastKind::IntToFp,
            value: v,
        };
        let mut f = fresh(
            alloc::vec![Inst::Imm(3), cast(0), cast(0)],
            alloc::vec![
                blk(0..2, bz(1, 2, 1), 1),
                blk(2..3, Terminator::Return(2), 2),
                blk(3..3, Terminator::Return(0), 0),
            ],
        );
        f.f32_values[2] = true;
        run_one(&mut f, caps(16, 8));
        assert_eq!(return_val(&f, 1), 2, "a float result is not a double one");
    }

    /// Two duplicates over one region cost two registers, not one: the
    /// gate charges each merge it takes, so a bank with room for one
    /// admits the first and declines the second.
    #[test]
    fn a_taken_merge_narrows_the_next_one() {
        let build = || {
            fresh(
                alloc::vec![
                    Inst::Imm(3),
                    Inst::Imm(5),
                    Inst::Imm(7),
                    add(0, 1),
                    add(0, 2),
                    add(3, 4),
                    add(0, 1),
                    add(0, 2),
                    add(6, 7)
                ],
                alloc::vec![
                    blk(0..6, bz(5, 2, 1), 5),
                    blk(6..9, Terminator::Return(8), 8),
                    blk(9..9, Terminator::Return(0), 0),
                ],
            )
        };
        let mut f = build();
        run_one(&mut f, caps(8, 4));
        let Inst::Binop { lhs, rhs, .. } = f.insts[8] else {
            panic!("expected a Binop at v8");
        };
        assert_eq!((lhs, rhs), (3, 7), "the first merge takes the last slot");
        let mut wide = build();
        run_one(&mut wide, caps(16, 8));
        let Inst::Binop { lhs, rhs, .. } = wide.insts[8] else {
            panic!("expected a Binop at v8");
        };
        assert_eq!((lhs, rhs), (3, 4), "a wider bank admits both");
    }

    /// Same input, same output: the dominator-tree DFS and the tape-order
    /// rewrite carry no hash iteration order into the result.
    #[test]
    fn output_is_deterministic() {
        let (mut a, mut b) = (dominated_dup(), dominated_dup());
        run_one(&mut a, caps(16, 8));
        run_one(&mut b, caps(16, 8));
        assert_eq!(
            alloc::format!("{:?}{:?}", a.insts, a.blocks),
            alloc::format!("{:?}{:?}", b.insts, b.blocks),
        );
    }
}

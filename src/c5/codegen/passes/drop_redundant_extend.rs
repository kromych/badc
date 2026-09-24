//! Drop a redundant `Inst::Extend { value, kind }` by redirecting its
//! consumers to `value`. An extend is redundant in three cases:
//!
//!   1. `value` is a narrow integer load whose own extension already
//!      covers the extend: a signed load (`I8`/`I16`/`I32`) no wider than
//!      the extend, or an unsigned load (`U8`/`U16`/`U32`) strictly
//!      narrower than it. A signed load (`ldrs*` / `movsx`) fills the bits
//!      above its width with the sign; an unsigned load (`ldr*` / `movzx`)
//!      fills them with zero, into which a strictly-wider sign-extend
//!      deposits its (zero) sign bit -- either way the extend reproduces
//!      the bits already present and is a no-op.
//!
//!   2. The extend is an `I32` sign-extend whose upper 32 bits no
//!      consumer reads (`compute_high_observed`). Every consumer sees
//!      the same low 32 bits in `value`, and the extend only differs in
//!      the unread upper half, so it can be dropped. This removes the
//!      per-op renormalization left over from a chain of low-word
//!      integer arithmetic. The unsigned renormalization, an `And` by a
//!      constant whose low word is all ones, drops on the same terms.
//!
//!   3. `value` is itself an `Extend` no wider than this one. The inner
//!      result already holds its sign bit in every position at and above
//!      its width, so re-extending from an equal or greater width
//!      reproduces it bit for bit -- the covering argument of (1) with a
//!      signed load replaced by a signed extend. Unlike (2) this holds in
//!      all 64 bits, so it applies wherever the value is consumed; such
//!      an extend is in turn transparent to the case-(2) analysis, which
//!      would otherwise judge the operand against a consumer set the
//!      collapse widens.
//!
//! A fourth case works across blocks: two `Extend`s of the same SSA
//! value with the same `kind` compute the same result, so an occurrence
//! at a position dominated by another redirects to the dominating one
//! (`dedup_dominated_extends`). Extends of a value round-tripped
//! through a spill slot are not tracked: proving the slot was stored
//! extended needs a per-slot reaching-store analysis, so those stay.
//!
//! A fifth case works on value ranges: `drop_fitting` redirects an
//! `Extend`, or an `And` by a constant, that is the identity on every
//! value its operand can hold where the instruction reads it, or, for an
//! induction variable (`value_range::iv`), in a defined execution where
//! only addresses and comparisons read the upper half.
//!
//! Finally, `drop_call_arg_reextends` removes the caller-side
//! re-extension of an argument to a direct internal call whose callee
//! re-derives the parameter from the low bits of the incoming register
//! anyway (its every read of the parameter is a `ParamRef` of a narrow
//! signed kind, which the per-arch entry lowering sign-extends).
//!
//! The dead Extend is left in place; the allocator's dead-pure DCE and
//! the per-arch emit's `is_dead_pure` skip drop it. `resolve` walks
//! redirect chains so stacked extends collapse.

use crate::c5::ir::{
    BinOp, FunctionSsa, IndexExt, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId,
};
use alloc::vec::Vec;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        // Decide the comparison operand widths first: a comparison
        // read at 32 bits stops observing its operands' upper half,
        // which is what makes the renormalizations feeding it dead.
        super::narrow::mark_compares(func);
        let assumed = super::value_range::iv::assumptions(func);
        run_one(func);
        drop_fitting(func, &assumed);
    }
    drop_call_arg_reextends(funcs);
}

/// Mark `v`'s upper bits as observed and enqueue it for propagation.
fn observe(hi: &mut [bool], work: &mut Vec<ValueId>, v: ValueId) {
    if (v as usize) < hi.len() && !hi[v as usize] {
        hi[v as usize] = true;
        work.push(v);
    }
}

/// Observe the arguments of a call outside its `low_word_args`.
fn observe_args(hi: &mut [bool], work: &mut Vec<ValueId>, args: &[ValueId], low_word_args: u64) {
    for (i, &a) in args.iter().enumerate() {
        if i >= 64 || low_word_args >> i & 1 == 0 {
            observe(hi, work, a);
        }
    }
}

/// For every value, whether any consumer reads bits at or above bit 32.
///
/// An `Add`/`Sub`/`Mul`/`And`/`Or`/`Xor`/`Shl` result's low 32 bits depend only
/// on its operands' low 32 bits (C99 6.2.5p9 / 6.5p5: two's-complement low-word
/// arithmetic), and a `Phi` selects one operand, so these forward the consumer's
/// observation to their operands and are transparent to the low word. A right
/// shift, divide/modulo, rotate, ordered/equality compare, 64-bit store, address
/// operand, FP cast, atomic, branch condition, or call argument outside the call's
/// `low_word_args` reads the full register, so it observes the upper bits directly.
/// `Inst::Extend` reads only the low `kind`-width bits, so it never observes its
/// source's upper bits. An `And` with a constant whose high word is clear forwards
/// none: its result's high word is clear whatever the other operand holds. A
/// return observes the full register unless the declared return type is narrower
/// than it on every target (`return_is_low_word`), in which case the result rides
/// the low word and the reading side widens it.
/// Anything not positively classified as low-word-only is treated as observing,
/// so the result is a conservative over-approximation. Shared with the allocator,
/// which consults it to skip a `ParamRef` entry sign-extension whose result is
/// never read above bit 31 (the parameter's low word already holds the C99
/// 6.5.2.2p4-converted value).
pub(crate) fn compute_high_observed(func: &FunctionSsa) -> Vec<bool> {
    compute_high_observed_through(func, &[], false)
}

/// `compute_high_observed`, with the extends flagged in `collapsing`
/// treated as transparent rather than as a barrier. Such an extend is
/// about to be replaced by its operand in all 64 bits, so it hands its
/// own consumers' observation down: without that, the operand's low-word
/// rule could fire against a consumer set the collapse is going to widen.
/// With `addressing`, addresses, comparisons and branch conditions do not
/// observe either.
fn compute_high_observed_through(
    func: &FunctionSsa,
    collapsing: &[bool],
    addressing: bool,
) -> Vec<bool> {
    let n = func.insts.len();
    let mut hi = alloc::vec![false; n];
    let mut work: Vec<ValueId> = Vec::new();
    let observe_addr = |hi: &mut [bool], work: &mut Vec<ValueId>, v: ValueId| {
        if !addressing {
            observe(hi, work, v);
        }
    };

    for (i, inst) in func.insts.iter().enumerate() {
        let cmp32 = super::narrow::is_cmp32(&func.cmp32, i as ValueId)
            || addressing
                && matches!(inst, Inst::Binop { op, .. } | Inst::BinopI { op, .. }
                    if crate::c5::ir::is_comparison_op(*op));
        match inst {
            Inst::Imm(_)
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::ImmExtCode(_)
            | Inst::BlockAddr(_)
            | Inst::LocalAddr(_)
            | Inst::TlsAddr(_)
            | Inst::LoadLocal { .. }
            | Inst::TailExt(_)
            | Inst::AllocaInit(_)
            | Inst::LifetimeEnd(_)
            | Inst::ParamRef { .. }
            | Inst::ParamPart { .. }
            | Inst::RetPart { .. }
            | Inst::Extend { .. } => {}
            // A part is returned whole in its register.
            Inst::AggParts { parts, .. } => {
                parts.iter().for_each(|&p| observe(&mut hi, &mut work, p))
            }
            Inst::Copy { value, .. } => observe(&mut hi, &mut work, *value),
            Inst::Load { addr, .. } => observe_addr(&mut hi, &mut work, *addr),
            // An extending access reads the low word of its index.
            Inst::LoadIndexed {
                base,
                index,
                index_ext,
                ..
            } => {
                observe_addr(&mut hi, &mut work, *base);
                if *index_ext == IndexExt::None {
                    observe_addr(&mut hi, &mut work, *index);
                }
            }
            Inst::Store {
                addr, value, kind, ..
            } => {
                observe_addr(&mut hi, &mut work, *addr);
                if *kind == StoreKind::I64 {
                    observe(&mut hi, &mut work, *value);
                }
            }
            Inst::SegLoad { addr, .. } => observe(&mut hi, &mut work, *addr),
            Inst::SegStore {
                addr, value, kind, ..
            } => {
                observe(&mut hi, &mut work, *addr);
                if *kind == StoreKind::I64 {
                    observe(&mut hi, &mut work, *value);
                }
            }
            Inst::StoreLocal { value, kind, .. } => {
                if *kind == StoreKind::I64 {
                    observe(&mut hi, &mut work, *value);
                }
            }
            Inst::StoreIndexed {
                base,
                index,
                index_ext,
                value,
                kind,
                ..
            } => {
                observe_addr(&mut hi, &mut work, *base);
                if *index_ext == IndexExt::None {
                    observe_addr(&mut hi, &mut work, *index);
                }
                if *kind == StoreKind::I64 {
                    observe(&mut hi, &mut work, *value);
                }
            }
            // Same low-word rule as the `Mul` / `Add` / `Sub` pair it
            // contracts: the result's low bytes need only the operands'.
            Inst::MulAdd { .. } => {}
            // A quotient depends on every bit of its operands.
            Inst::Udiv128 {
                hi: h,
                lo: l,
                divisor: d,
            } => {
                observe(&mut hi, &mut work, *h);
                observe(&mut hi, &mut work, *l);
                observe(&mut hi, &mut work, *d);
            }
            Inst::Binop { op, lhs, rhs } => match op {
                BinOp::Add | BinOp::Sub | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor => {}
                BinOp::Shl => observe(&mut hi, &mut work, *rhs),
                _ if cmp32 => {}
                _ => {
                    observe(&mut hi, &mut work, *lhs);
                    observe(&mut hi, &mut work, *rhs);
                }
            },
            Inst::BinopI { op, lhs, .. } => match op {
                BinOp::Add
                | BinOp::Sub
                | BinOp::Mul
                | BinOp::And
                | BinOp::Or
                | BinOp::Xor
                | BinOp::Shl => {}
                _ if cmp32 => {}
                _ => observe(&mut hi, &mut work, *lhs),
            },
            // The 2- and 4-byte reversals and counts read only the low
            // bytes they operate on; the 8-byte forms read the full register.
            Inst::Bswap { value, width } | Inst::BitCount { value, width, .. } => {
                if *width == 8 {
                    observe(&mut hi, &mut work, *value);
                }
            }
            Inst::FpCast { value, .. } => observe(&mut hi, &mut work, *value),
            // Negation is exact modulo 2^64, so the result's low bytes
            // need only the operand's, as `Sub` does.
            Inst::Neg(_) => {}
            Inst::Fneg(v) => observe(&mut hi, &mut work, *v),
            Inst::Fma { a, b, c, .. } => {
                observe(&mut hi, &mut work, *a);
                observe(&mut hi, &mut work, *b);
                observe(&mut hi, &mut work, *c);
            }
            Inst::Intrinsic { args, .. }
            | Inst::X86Simd { args, .. }
            | Inst::InlineAsm { args, .. } => {
                for a in args {
                    observe(&mut hi, &mut work, *a);
                }
            }
            Inst::Call {
                args,
                low_word_args,
                ..
            }
            | Inst::CallExt {
                args,
                low_word_args,
                ..
            } => observe_args(&mut hi, &mut work, args, *low_word_args),
            Inst::CallIndirect {
                target,
                args,
                low_word_args,
                ..
            } => {
                observe(&mut hi, &mut work, *target);
                observe_args(&mut hi, &mut work, args, *low_word_args);
            }
            Inst::Mcpy { dst, src, .. } => {
                observe(&mut hi, &mut work, *dst);
                observe(&mut hi, &mut work, *src);
            }
            Inst::Mzero { dst, .. } => observe(&mut hi, &mut work, *dst),
            // A narrow atomic reads only its operands' low `width` bytes.
            Inst::AtomicRmw {
                addr, value, width, ..
            }
            | Inst::AtomicStore {
                addr, value, width, ..
            } => {
                observe(&mut hi, &mut work, *addr);
                if *width == 8 {
                    observe(&mut hi, &mut work, *value);
                }
            }
            Inst::AtomicLoad { addr, .. } => observe(&mut hi, &mut work, *addr),
            Inst::AtomicCas {
                addr,
                expected,
                desired,
                width,
                ..
            } => {
                observe(&mut hi, &mut work, *addr);
                if *width == 8 {
                    observe(&mut hi, &mut work, *expected);
                    observe(&mut hi, &mut work, *desired);
                }
            }
            Inst::Phi { .. } => {}
        }
    }
    // A terminator reads its operand at full width, except a zero test
    // that reads the low word (`low_word_tests`) and a return whose
    // declared type is narrower than the return register, which carries
    // the result in its low word alone. `Block::exit_acc` names a value
    // and reads none.
    let ret_low_word = crate::c5::codegen::return_is_low_word(func.ret_type_tag);
    for (b, block) in func.blocks.iter().enumerate() {
        if func.low_word_tests.get(b).copied().unwrap_or(false)
            || addressing
                && matches!(
                    block.terminator,
                    Terminator::Bz { .. } | Terminator::Bnz { .. }
                )
        {
            continue;
        }
        if ret_low_word && matches!(block.terminator, Terminator::Return(_)) {
            continue;
        }
        block
            .terminator
            .for_each_operand(|v| observe(&mut hi, &mut work, v));
    }

    // Propagate: an observed transparent result observes its operands.
    while let Some(r) = work.pop() {
        match &func.insts[r as usize] {
            Inst::Binop {
                op: BinOp::And,
                lhs,
                rhs,
            } if clear_high_imm(func, *lhs) || clear_high_imm(func, *rhs) => {}
            Inst::BinopI {
                op: BinOp::And,
                rhs_imm,
                ..
            } if (*rhs_imm as u64) >> 32 == 0 => {}
            Inst::Binop {
                op: BinOp::Add | BinOp::Sub | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor,
                lhs,
                rhs,
            } => {
                observe(&mut hi, &mut work, *lhs);
                observe(&mut hi, &mut work, *rhs);
            }
            Inst::Neg(v) => observe(&mut hi, &mut work, *v),
            Inst::Binop {
                op: BinOp::Shl,
                lhs,
                ..
            } => observe(&mut hi, &mut work, *lhs),
            Inst::BinopI {
                op:
                    BinOp::Add
                    | BinOp::Sub
                    | BinOp::Mul
                    | BinOp::And
                    | BinOp::Or
                    | BinOp::Xor
                    | BinOp::Shl,
                lhs,
                ..
            } => observe(&mut hi, &mut work, *lhs),
            Inst::Phi { incoming, .. } => {
                let ops: Vec<ValueId> = incoming.iter().map(|(_, v)| *v).collect();
                for v in ops {
                    observe(&mut hi, &mut work, v);
                }
            }
            // `c + a*b`: its high bits depend on the full operands, so an
            // observed result observes all three, as the `Mul` / `Add`
            // pair it contracts would.
            Inst::MulAdd { a, b, c, .. } => {
                observe(&mut hi, &mut work, *a);
                observe(&mut hi, &mut work, *b);
                observe(&mut hi, &mut work, *c);
            }
            Inst::Udiv128 {
                hi: h,
                lo: l,
                divisor: d,
            } => {
                observe(&mut hi, &mut work, *h);
                observe(&mut hi, &mut work, *l);
                observe(&mut hi, &mut work, *d);
            }
            Inst::Extend { value, .. } if collapsing.get(r as usize).copied().unwrap_or(false) => {
                observe(&mut hi, &mut work, *value)
            }
            _ => {}
        }
    }
    hi
}

/// Whether `v` is an integer constant with a clear high word.
fn clear_high_imm(func: &FunctionSsa, v: ValueId) -> bool {
    matches!(func.insts.get(v as usize), Some(Inst::Imm(k)) if (*k as u64) >> 32 == 0)
}

// Resolve through chains: Extend(Extend(load)) becomes load.
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

/// Redirect an `Extend { value, kind }` to an earlier `Extend` of the
/// same `(value, kind)` at a dominating position: same block at a lower
/// index, or a block that strictly dominates. SSA values are immutable,
/// so the two extends compute the same result, and the dominating
/// definition reaches every consumer of the dominated one. Sources are
/// resolved through the already-collected redirects so extends of a
/// value and of its dropped re-extension land in one group.
///
/// An extend that feeds a call argument or the return value is not
/// redirected: the emit computes it directly into the argument /
/// return register at its own position, whereas redirecting stretches
/// the dominating extend's live range to the call and trades the one
/// extend for parallel-copy moves and a saved register.
///
/// A redirect whose live range would cross a call is also skipped
/// (`call_between`): the allocator has no rematerialization, so the
/// value would occupy a callee-saved register (or a spill slot) across
/// the call, costing save/restore traffic that outweighs the one
/// recomputed extend.
fn dedup_dominated_extends(func: &FunctionSsa, redirect: &mut [Option<ValueId>]) {
    use hashbrown::HashMap;
    let mut inst_block = alloc::vec![u32::MAX; func.insts.len()];
    for (bid, block) in func.blocks.iter().enumerate() {
        for idx in block.inst_range.clone() {
            if let Some(slot) = inst_block.get_mut(idx as usize) {
                *slot = bid as u32;
            }
        }
    }
    let mut placed = alloc::vec![false; func.insts.len()];
    let mark = |placed: &mut [bool], v: ValueId| {
        if let Some(slot) = placed.get_mut(v as usize) {
            *slot = true;
        }
    };
    for inst in &func.insts {
        match inst {
            Inst::Call { args, .. }
            | Inst::CallExt { args, .. }
            | Inst::Intrinsic { args, .. }
            | Inst::X86Simd { args, .. }
            | Inst::InlineAsm { args, .. } => {
                for a in args {
                    mark(&mut placed, *a);
                }
            }
            Inst::CallIndirect { args, .. } => {
                for a in args {
                    mark(&mut placed, *a);
                }
            }
            _ => {}
        }
    }
    for block in &func.blocks {
        if let Terminator::Return(v) = block.terminator
            && v != NO_VALUE
        {
            mark(&mut placed, v);
        }
    }
    let idom = crate::c5::codegen::ssa::mem2reg::dominators(func);
    // Dominator-tree depth per block; unreachable blocks get MAX.
    // Reverse postorder settles a block's immediate dominator before the
    // block itself, so one pass suffices.
    let mut depth = alloc::vec![u32::MAX; func.blocks.len()];
    let mut po = crate::c5::codegen::ssa::mem2reg::postorder(func);
    po.reverse();
    for b in po {
        depth[b as usize] = if b == 0 {
            0
        } else if idom[b as usize] == u32::MAX {
            continue;
        } else {
            depth[idom[b as usize] as usize].saturating_add(1)
        };
    }
    let mut groups: HashMap<(ValueId, LoadKind), Vec<ValueId>> = HashMap::new();
    for (idx, inst) in func.insts.iter().enumerate() {
        let Inst::Extend { value, kind, .. } = inst else {
            continue;
        };
        if redirect[idx].is_some() {
            continue;
        }
        let blk = inst_block[idx];
        if blk == u32::MAX || depth.get(blk as usize).copied() == Some(u32::MAX) {
            continue;
        }
        groups
            .entry((resolve(redirect, *value), *kind))
            .or_default()
            .push(idx as ValueId);
    }
    let dominates = |c_blk: u32, e_blk: u32| -> bool {
        let mut b = e_blk;
        while b != 0 {
            b = idom[b as usize];
            if b == u32::MAX {
                return false;
            }
            if b == c_blk {
                return true;
            }
        }
        false
    };
    let is_call = |inst: &Inst| {
        matches!(
            inst,
            Inst::Call { .. } | Inst::CallExt { .. } | Inst::CallIndirect { .. }
        )
    };
    let block_has_call: Vec<bool> = func
        .blocks
        .iter()
        .map(|b| {
            b.inst_range
                .clone()
                .any(|idx| is_call(&func.insts[idx as usize]))
        })
        .collect();
    // Whether a call sits at a position in `range` of `blk`'s insts.
    let call_in = |blk: u32, range: core::ops::Range<u32>| -> bool {
        let br = func.blocks[blk as usize].inst_range.clone();
        (range.start.max(br.start)..range.end.min(br.end))
            .any(|idx| is_call(&func.insts[idx as usize]))
    };
    let preds = crate::c5::codegen::ssa::mem2reg::predecessors(func);
    // A function with no call at all cannot have one between two
    // points, so the search below never fires.
    let any_call = block_has_call.iter().any(|&c| c);
    // Visit marks for the search, reused across queries: `seen[b]` holds
    // the query number that last marked block `b`.
    let mut seen = alloc::vec![0u32; func.blocks.len()];
    let mut query = 0u32;
    let mut work: Vec<u32> = Vec::new();
    // Whether a call sits where `c` would be live on its way to `e`: the
    // points from which `e` is reached without passing `c` again, walked
    // backward from `e` up to `c`, which dominates it. In one block that
    // is the stretch between them; otherwise the leader's block after
    // `c`, the use's block before `e`, and every block the walk enters
    // in between (the use's block again when a loop leads back to it).
    let mut call_between = |c: ValueId, e: ValueId| -> bool {
        if !any_call {
            return false;
        }
        let c_blk = inst_block[c as usize];
        let e_blk = inst_block[e as usize];
        if c_blk == e_blk {
            return call_in(c_blk, c + 1..e);
        }
        if call_in(c_blk, c + 1..u32::MAX) || call_in(e_blk, 0..e) {
            return true;
        }
        query += 1;
        seen[c_blk as usize] = query;
        work.clear();
        work.extend_from_slice(&preds[e_blk as usize]);
        while let Some(b) = work.pop() {
            if core::mem::replace(&mut seen[b as usize], query) == query {
                continue;
            }
            if block_has_call[b as usize] {
                return true;
            }
            work.extend_from_slice(&preds[b as usize]);
        }
        false
    };
    for mut members in groups.into_values() {
        if members.len() < 2 {
            continue;
        }
        // Sorting by (depth, idx) means a member can only be dominated
        // by an earlier one, so redirects always point backward.
        members.sort_by_key(|&v| (depth[inst_block[v as usize] as usize], v));
        for i in 1..members.len() {
            let e = members[i];
            if placed[e as usize] {
                continue;
            }
            let e_blk = inst_block[e as usize];
            for &c in &members[..i] {
                let c_blk = inst_block[c as usize];
                if ((c_blk == e_blk && c < e) || dominates(c_blk, e_blk)) && !call_between(c, e) {
                    redirect[e as usize] = Some(c);
                    break;
                }
            }
        }
    }
}

/// Bit width of a narrow signed extend kind; `None` otherwise.
fn narrow_kind_bits(kind: LoadKind) -> Option<u32> {
    match kind {
        LoadKind::I8 => Some(8),
        LoadKind::I16 => Some(16),
        LoadKind::I32 => Some(32),
        _ => None,
    }
}

/// Per-parameter re-extension proof for `func`: `Some(kind)` when every
/// read of parameter `i` is a `ParamRef { idx: i, kind }` of one narrow
/// signed kind, so the callee derives the parameter from the low
/// `kind`-width bits of the incoming register (the per-arch entry
/// lowering sign-extends them; an elided I32 extension means no
/// consumer reads higher bits). The parameter's c5 cdecl cell must not
/// leak the raw incoming register: the prologue spills it unextended
/// when the cell survives, so any address take or live 8-byte read of
/// the cell disqualifies. Reads of 4 bytes or fewer see only the low
/// word, which the caller-side drop preserves.
fn param_reextend_kinds(func: &FunctionSsa) -> Vec<Option<LoadKind>> {
    let n = func.n_params;
    let mut kinds: Vec<Option<LoadKind>> = alloc::vec![None; n];
    if n == 0 || func.is_variadic || func.indirect_result_slot != 0 {
        return kinds;
    }
    let mut use_counts = alloc::vec![0u32; func.insts.len()];
    let bump = |counts: &mut [u32], v: ValueId| {
        if let Some(slot) = counts.get_mut(v as usize) {
            *slot += 1;
        }
    };
    for inst in &func.insts {
        crate::c5::codegen::ssa::reg_alloc::for_each_operand(inst, |v| bump(&mut use_counts, v));
    }
    for block in &func.blocks {
        block
            .terminator
            .for_each_operand(|v| bump(&mut use_counts, v));
    }
    for (i, kind) in kinds.iter_mut().enumerate() {
        let slot = i as i64 + 2;
        if func
            .multi_cell_slots
            .iter()
            .any(|&(base, cells)| slot >= base && slot < base + cells)
        {
            continue;
        }
        let mut seen: Option<LoadKind> = None;
        let mut ok = true;
        for (idx, inst) in func.insts.iter().enumerate() {
            match inst {
                Inst::ParamRef { idx: p, kind: k } if *p as usize == i => {
                    if narrow_kind_bits(*k).is_none() || seen.is_some_and(|s| s != *k) {
                        ok = false;
                        break;
                    }
                    seen = Some(*k);
                }
                Inst::LocalAddr(off) if *off == slot => {
                    ok = false;
                    break;
                }
                Inst::LoadLocal {
                    off,
                    kind: k,
                    volatile,
                } if *off == slot
                    && matches!(k, LoadKind::I64 | LoadKind::F64 | LoadKind::F32)
                    && (*volatile || use_counts[idx] > 0) =>
                {
                    ok = false;
                    break;
                }
                _ => {}
            }
        }
        if ok {
            *kind = seen;
        }
    }
    kinds
}

/// For each direct internal call, replace an `Extend { value, kind }`
/// argument with `value` when the callee's parameter re-extends from a
/// width no wider than `kind` (see [`param_reextend_kinds`]). The bits
/// the drop changes are above the extend's width, and the callee reads
/// none of them. Restricted to `Inst::Call`: an external or indirect
/// callee's entry behavior is unknown, so those keep the argument's low
/// word as C99 6.5.2.2p4 converts it.
fn drop_call_arg_reextends(funcs: &mut [FunctionSsa]) {
    use hashbrown::HashMap;
    let mut by_ent: HashMap<usize, Vec<Option<LoadKind>>> = HashMap::new();
    for func in funcs.iter() {
        if func
            .insts
            .iter()
            .any(|i| matches!(i, Inst::ParamRef { .. }))
        {
            by_ent.insert(func.ent_pc, param_reextend_kinds(func));
        }
    }
    if by_ent.is_empty() {
        return;
    }
    for func in funcs.iter_mut() {
        for idx in 0..func.insts.len() {
            let Inst::Call {
                target_pc,
                args,
                arg_aggs,
                ..
            } = &func.insts[idx]
            else {
                continue;
            };
            let Some(params) = by_ent.get(target_pc) else {
                continue;
            };
            let mut rewrites: Vec<(usize, ValueId)> = Vec::new();
            for (k, &a) in args.iter().enumerate() {
                if arg_aggs.get(k).copied().flatten().is_some() {
                    continue;
                }
                let Some(Inst::Extend { value, kind, .. }) = func.insts.get(a as usize) else {
                    continue;
                };
                let (Some(ext_bits), Some(param_kind)) =
                    (narrow_kind_bits(*kind), params.get(k).copied().flatten())
                else {
                    continue;
                };
                if narrow_kind_bits(param_kind).is_some_and(|pb| pb <= ext_bits) {
                    rewrites.push((k, *value));
                }
            }
            if rewrites.is_empty() {
                continue;
            }
            if let Inst::Call { args, .. } = &mut func.insts[idx] {
                for (k, v) in rewrites {
                    args[k] = v;
                }
            }
        }
    }
}

/// If `v` is a narrow integer load, its width in bits and whether it
/// sign-extends. A signed load fills the bits above its width with the sign
/// bit; an unsigned load fills them with zero.
fn narrow_int_load(insts: &[Inst], v: ValueId) -> Option<(u32, bool)> {
    if v == NO_VALUE {
        return None;
    }
    let kind = match insts.get(v as usize)? {
        Inst::Load { kind, .. } => *kind,
        Inst::LoadLocal { kind, .. } => *kind,
        Inst::LoadIndexed { kind, .. } => *kind,
        _ => return None,
    };
    Some(match kind {
        LoadKind::I8 => (8, true),
        LoadKind::U8 => (8, false),
        LoadKind::I16 => (16, true),
        LoadKind::U16 => (16, false),
        LoadKind::I32 => (32, true),
        LoadKind::U32 => (32, false),
        _ => return None,
    })
}

/// The operand an `And` by a constant with an all-ones low word passes
/// through in its low 32 bits: the unsigned renormalization
/// `x & 0xffff_ffff` and any wider mask of that shape.
fn low_word_mask_operand(func: &FunctionSsa, inst: &Inst) -> Option<ValueId> {
    let keeps_low_word = |v: ValueId| {
        matches!(func.insts.get(v as usize), Some(Inst::Imm(k)) if *k as u32 == u32::MAX)
            && !func.f32_values.get(v as usize).copied().unwrap_or(false)
    };
    match *inst {
        Inst::BinopI {
            op: BinOp::And,
            lhs,
            rhs_imm,
        } if rhs_imm as u32 == u32::MAX => Some(lhs),
        Inst::Binop {
            op: BinOp::And,
            lhs,
            rhs,
        } if keeps_low_word(rhs) => Some(lhs),
        Inst::Binop {
            op: BinOp::And,
            lhs,
            rhs,
        } if keeps_low_word(lhs) => Some(rhs),
        _ => None,
    }
}

fn run_one(func: &mut FunctionSsa) {
    let n = func.insts.len();
    let candidate =
        |i: &Inst| matches!(i, Inst::Extend { .. }) || low_word_mask_operand(func, i).is_some();
    if !func.insts.iter().any(candidate) {
        return;
    }
    // An Extend is redundant when (1) its operand is a narrow integer load
    // whose extension it re-applies: a signed load already sign-extends to 64
    // bits, so an equal-or-wider sign-extend reproduces the same bits; an
    // unsigned load zero-extends, so a strictly-wider sign-extend lands its
    // sign bit in the zero region and is likewise a no-op. This covers the
    // `int`-return sign-extend of a char/short load left by the callee-
    // narrowing convention. Or (3) its operand is an Extend no wider than
    // it: the inner result holds its sign bit in every position at and
    // above its own width, so re-extending from an equal or greater width
    // reproduces it bit for bit. Or (2) it is an i32 sign-extend whose
    // upper bits no consumer reads, so every consumer sees the same low 32
    // bits in the operand. All three redirect the extend's consumers to the
    // operand; `resolve` walks redirect chains.
    //
    // (1) and (3) hold in all 64 bits, (2) only in the low word, so a
    // chain must never run one of the former into the latter. Case (3) is
    // decided first, structurally, and its extends enter the high-bit
    // analysis as transparent: an operand whose collapsing consumers read
    // the upper half then fails (2) instead of being redirected under it.
    let mut collapsing = alloc::vec![false; n];
    for (idx, inst) in func.insts.iter().enumerate() {
        let Inst::Extend { value, kind, .. } = inst else {
            continue;
        };
        let Some(Inst::Extend { kind: inner, .. }) = func.insts.get(*value as usize) else {
            continue;
        };
        collapsing[idx] = narrow_kind_bits(*inner)
            .zip(narrow_kind_bits(*kind))
            .is_some_and(|(ibits, ebits)| ibits <= ebits);
    }
    let high = compute_high_observed_through(func, &collapsing, false);
    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; n];
    for (idx, inst) in func.insts.iter().enumerate() {
        // (2) for the unsigned renormalization: the mask changes bits
        // 32..63 only, which no consumer reads.
        if let Some(operand) = low_word_mask_operand(func, inst)
            && !high[idx]
        {
            redirect[idx] = Some(operand);
            continue;
        }
        let Inst::Extend { value, kind, .. } = inst else {
            continue;
        };
        let load_covers = narrow_int_load(&func.insts, *value)
            .zip(narrow_kind_bits(*kind))
            .is_some_and(|((lbits, signed), ebits)| {
                if signed {
                    lbits <= ebits
                } else {
                    lbits < ebits
                }
            });
        if load_covers || collapsing[idx] || (*kind == LoadKind::I32 && !high[idx]) {
            redirect[idx] = Some(*value);
        }
    }
    dedup_dominated_extends(func, &mut redirect);
    apply_redirects(func, &redirect);
}

/// Rewrite every operand, terminator value, and block accumulator. A
/// redirected instruction is dead; its operand follows the redirects too,
/// so it keeps no redirected value live.
fn apply_redirects(func: &mut FunctionSsa, redirect: &[Option<ValueId>]) {
    if redirect.iter().all(Option::is_none) {
        return;
    }
    for inst in func.insts.iter_mut() {
        inst.for_each_operand_mut(|op| *op = resolve(redirect, *op));
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            block.exit_acc = resolve(redirect, block.exit_acc);
        }
        block
            .terminator
            .for_each_operand_mut(|v| *v = resolve(redirect, *v));
    }
}

/// Per value: its register contents have a clear high word by range.
pub(crate) fn compute_high_clear(func: &FunctionSsa) -> Vec<bool> {
    let logical = |i: &Inst| {
        matches!(
            i,
            Inst::BinopI {
                op: BinOp::And | BinOp::Or | BinOp::Xor,
                ..
            }
        )
    };
    if !func.insts.iter().any(logical) {
        return Vec::new();
    }
    super::value_range::def_ranges(func, &[])
        .into_iter()
        .map(|r| r.high_word_clear())
        .collect()
}

/// Redirect an extension that is the identity on every value its operand
/// holds where the extension reads it: the operand's definition range met
/// with the branch bounds in force in the extension's block
/// (`value_range::Ranges::at`). The operand then holds the extension's
/// result in all 64 bits, so every consumer can read it.
///
/// After `run_one`: the ranges describe the registers as that pass left
/// them, and a renormalization it dropped for an unread upper half is not
/// kept alive by a range that would rest on it.
/// Then, under the `assumed` induction facts, an `I32` extension whose upper
/// half only addresses and comparisons read; any other reader keeps it and
/// sees the value wrapped in every execution.
fn drop_fitting(func: &mut FunctionSsa, assumed: &[Option<LoadKind>]) {
    let narrows = |i: &Inst| {
        matches!(
            i,
            Inst::Extend { .. }
                | Inst::BinopI { op: BinOp::And, .. }
                | Inst::Binop { op: BinOp::And, .. }
        )
    };
    if !func.insts.iter().any(narrows) {
        return;
    }
    let ranges = super::value_range::Ranges::compute(func, &[]);
    let imm = |v: ValueId| match func.insts.get(v as usize) {
        Some(Inst::Imm(k)) if !func.f32_values.get(v as usize).copied().unwrap_or(false) => {
            Some(*k)
        }
        _ => None,
    };
    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; func.insts.len()];
    for (b, block) in func.blocks.iter().enumerate() {
        let b = b as crate::c5::ir::BlockId;
        let kept =
            |v: ValueId, mask: Option<i64>| mask.is_some_and(|k| ranges.at(b, v).kept_by_mask(k));
        for idx in block.inst_range.clone() {
            let Some(inst) = func.insts.get(idx as usize) else {
                continue;
            };
            redirect[idx as usize] = match *inst {
                Inst::Extend {
                    value,
                    kind: kind @ (LoadKind::I8 | LoadKind::I16 | LoadKind::I32),
                    ..
                } => ranges.at(b, value).fits(kind).then_some(value),
                Inst::BinopI {
                    op: BinOp::And,
                    lhs,
                    rhs_imm,
                } => kept(lhs, Some(rhs_imm)).then_some(lhs),
                Inst::Binop {
                    op: BinOp::And,
                    lhs,
                    rhs,
                } if kept(lhs, imm(rhs)) => Some(lhs),
                Inst::Binop {
                    op: BinOp::And,
                    lhs,
                    rhs,
                } if kept(rhs, imm(lhs)) => Some(rhs),
                _ => None,
            };
        }
    }
    apply_redirects(func, &redirect);
    if !assumed.iter().any(Option::is_some) {
        return;
    }
    let ranges = super::value_range::Ranges::compute_assuming(func, &[], assumed);
    let escaping = compute_high_observed_through(func, &[], true);
    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; func.insts.len()];
    for (b, block) in func.blocks.iter().enumerate() {
        for idx in block.inst_range.clone() {
            if let Some(&Inst::Extend {
                value,
                kind: LoadKind::I32,
                ..
            }) = func.insts.get(idx as usize)
                && !escaping[idx as usize]
                && ranges
                    .at(b as crate::c5::ir::BlockId, value)
                    .fits(LoadKind::I32)
            {
                redirect[idx as usize] = Some(value);
            }
        }
    }
    apply_redirects(func, &redirect);
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{BinOp, Block, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
    use alloc::vec;

    fn fresh(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            name: alloc::string::String::new(),
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
            conv: crate::c5::codegen::CallConv::Target,
            section: None,
            patchable_entry: None,
            no_instrument: false,
            no_stack_protector: false,
            is_weak: false,
            is_internal: false,
            const_params: 0,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            cmp32: Vec::new(),
            low_word_tests: Vec::new(),
            param_fp_mask: crate::c5::ir::FpMask::EMPTY,
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
            array_slots: Vec::new(),
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

    #[test]
    fn extend_i32_of_load_i32_redirects_to_load() {
        // v0: Imm(0) (address)
        // v1: Load(addr=v0, kind=I32)
        // v2: Extend(value=v1, kind=I32)
        // Return(v2) -- should rewrite to Return(v1).
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                    volatile: false,
                    align: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                    nsw: false,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(1)),
            "Return should redirect from v2 (Extend) to v1 (Load); got {:?}",
            f.blocks[0].terminator
        );
    }

    #[test]
    fn extend_i32_of_narrower_sign_load_redirects() {
        // v1: Load(kind=I8) already sign-extends to 64 bits; v2: Extend(v1, I32)
        // re-extends from a wider width -- a no-op, since the I8 sign already
        // fills every bit the i32 extend would set. Return(v2) -> Return(v1).
        // (This is the int-return sign-extend of a char load.)
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I8,
                    volatile: false,
                    align: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                    nsw: false,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(1)),
            "Return should redirect from v2 (Extend i32) to v1 (I8 Load); got {:?}",
            f.blocks[0].terminator
        );
    }

    #[test]
    fn extend_i32_of_narrower_unsigned_load_redirects() {
        // v1: Load(kind=U8) zero-extends; v2: Extend(v1, I32) sign-extends from
        // a strictly wider width, so its sign bit lands in the zero region -- a
        // no-op (the aarch64 unsigned-char int-return case). Return(v2) ->
        // Return(v1).
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::U8,
                    volatile: false,
                    align: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                    nsw: false,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(1)),
            "Return should redirect from v2 (Extend i32) to v1 (U8 Load); got {:?}",
            f.blocks[0].terminator
        );
    }

    #[test]
    fn extend_of_wider_sign_load_is_not_redirected() {
        // v1: Load(kind=I32); v2: Extend(v1, I8) truncates to 8 bits and
        // changes the value, so it must stay.
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                    volatile: false,
                    align: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I8,
                    nsw: false,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(2)));
    }

    #[test]
    fn extend_i64_of_load_i32_is_not_redirected() {
        // Different widths -- the Extend changes the value's width
        // and must stay. (Currently the IR only sign-extends but
        // be conservative.)
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                    volatile: false,
                    align: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I64,
                    nsw: false,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(2)));
    }

    #[test]
    fn extend_u32_of_load_u32_is_not_redirected() {
        // Unsigned loads zero-extend; Extend is conservative here.
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::U32,
                    volatile: false,
                    align: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                    nsw: false,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(2)));
    }

    #[test]
    fn no_extend_no_change() {
        let mut f = fresh(
            vec![Inst::Imm(0)],
            vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Return(0),
                exit_acc: 0,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(0)));
    }

    /// v0 Imm(addr); v1 Load I32; v2 Add(v1,v1); v3 Extend(v2,I32);
    /// v4 Store(v3, kind). A 4-byte store reads only the low 32 bits,
    /// so the extend's upper half is dead and v4 redirects to v2; a
    /// 8-byte store reads the full value, so the extend stays.
    fn extend_over_add_feeding_store(store_kind: StoreKind) -> FunctionSsa {
        fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                    volatile: false,
                    align: 0,
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 1,
                    rhs: 1,
                },
                Inst::Extend {
                    value: 2,
                    kind: LoadKind::I32,
                    nsw: false,
                },
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 3,
                    kind: store_kind,
                    volatile: false,
                    align: 0,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..5,
                terminator: Terminator::Return(NO_VALUE),
                exit_acc: NO_VALUE,
            }],
        )
    }

    fn masked(op: BinOp, k: i64, folded: bool, operand_store: bool) -> FunctionSsa {
        let load = Inst::Load {
            addr: 0,
            disp: 0,
            kind: LoadKind::I64,
            volatile: false,
            align: 0,
        };
        let store = |value| Inst::Store {
            addr: 0,
            disp: 0,
            value,
            kind: StoreKind::I64,
            volatile: false,
            align: 0,
        };
        let op = if folded {
            Inst::BinopI {
                op,
                lhs: 1,
                rhs_imm: k,
            }
        } else {
            Inst::Binop { op, lhs: 1, rhs: 2 }
        };
        let mut insts = vec![Inst::Imm(0), load, Inst::Imm(k), op, store(3)];
        if operand_store {
            insts.push(store(1));
        }
        let n = insts.len() as u32;
        let block = Block {
            start_pc: 0,
            inst_range: 0..n,
            terminator: Terminator::Return(NO_VALUE),
            exit_acc: NO_VALUE,
        };
        fresh(insts, vec![block])
    }

    #[test]
    fn an_and_with_a_clear_high_mask_does_not_observe_its_operand() {
        for folded in [true, false] {
            let high = compute_high_observed(&masked(BinOp::And, 0x00ff_00ff, folded, false));
            assert!(high[3] && !high[1], "folded={folded}: {high:?}");
        }
    }

    #[test]
    fn an_operand_high_word_read_elsewhere_stays_observed() {
        let cases = [
            (BinOp::And, 0x1_0000_00ff, false),
            (BinOp::And, -256, false),
            (BinOp::Or, 0xff, false),
            (BinOp::Xor, 0xff, false),
            (BinOp::And, 0xff, true),
        ];
        for (op, k, operand_store) in cases {
            for folded in [true, false] {
                let high = compute_high_observed(&masked(op, k, folded, operand_store));
                assert!(
                    high[1],
                    "{op:?} {k:#x} folded={folded} store={operand_store}"
                );
            }
        }
    }

    fn extend_under_mask(mask: i64) -> FunctionSsa {
        let mut f = extend_over_add_feeding_store(StoreKind::I64);
        f.insts[4] = Inst::BinopI {
            op: BinOp::And,
            lhs: 3,
            rhs_imm: mask,
        };
        f.insts.push(Inst::Store {
            addr: 0,
            disp: 0,
            value: 4,
            kind: StoreKind::I64,
            volatile: false,
            align: 0,
        });
        f.inst_src.push((0, 0));
        f.f32_values.push(false);
        f.blocks[0].inst_range = 0..6;
        f
    }

    #[test]
    fn an_extend_under_a_clear_high_mask_is_dropped() {
        for (mask, lhs) in [(0xff, 2), (0x1_0000_00ff, 3), (-256, 3)] {
            let mut f = extend_under_mask(mask);
            run_one(&mut f);
            assert!(
                matches!(f.insts[4], Inst::BinopI { lhs: l, .. } if l == lhs),
                "{mask:#x}: {:?}",
                f.insts[4]
            );
        }
    }

    /// v0 Imm(addr); v1 Load I64; v2 = v1 & 0xffff_ffff; v3 = `reader`
    /// of v2; v4 = Store(v3, I64); an optional v5 follows.
    fn unsigned_renormalization_read_by(reader: Inst, tail: Option<Inst>) -> FunctionSsa {
        let mut insts = vec![
            Inst::Imm(0),
            Inst::Load {
                addr: 0,
                disp: 0,
                kind: LoadKind::I64,
                volatile: false,
                align: 0,
            },
            Inst::BinopI {
                op: BinOp::And,
                lhs: 1,
                rhs_imm: 0xffff_ffff,
            },
            reader,
            Inst::Store {
                addr: 0,
                disp: 0,
                value: 3,
                kind: StoreKind::I64,
                volatile: false,
                align: 0,
            },
        ];
        insts.extend(tail);
        let n = insts.len() as u32;
        fresh(
            insts,
            vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: Terminator::Return(NO_VALUE),
                exit_acc: NO_VALUE,
            }],
        )
    }

    fn first_operand(inst: &Inst) -> ValueId {
        let mut first = NO_VALUE;
        inst.for_each_operand(|v| {
            if first == NO_VALUE {
                first = v;
            }
        });
        first
    }

    /// `(x & 0xffff_ffff) + k` masked again reads only the low word of the
    /// first mask, which therefore drops; the second one is stored at 8
    /// bytes and stays.
    #[test]
    fn unsigned_renormalization_with_an_unread_high_word_is_dropped() {
        for mask in [0xffff_ffff, 0x1_ffff_ffff] {
            let mut f = unsigned_renormalization_read_by(
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 2,
                    rhs_imm: 12345,
                },
                None,
            );
            f.insts[2] = Inst::BinopI {
                op: BinOp::And,
                lhs: 1,
                rhs_imm: mask,
            };
            f.insts[4] = Inst::BinopI {
                op: BinOp::And,
                lhs: 3,
                rhs_imm: 0xffff_ffff,
            };
            f.insts.push(Inst::Store {
                addr: 0,
                disp: 0,
                value: 4,
                kind: StoreKind::I64,
                volatile: false,
                align: 0,
            });
            f.inst_src.push((0, 0));
            f.f32_values.push(false);
            f.blocks[0].inst_range = 0..6;
            run_one(&mut f);
            assert_eq!(first_operand(&f.insts[3]), 1, "{mask:#x}: {:?}", f.insts[3]);
            assert!(
                matches!(f.insts[5], Inst::Store { value: 4, .. }),
                "{mask:#x}: {:?}",
                f.insts[5]
            );
        }
    }

    /// Every reader of bits 32..63 keeps the mask: an 8-byte store, a
    /// right shift, a division, a 64-bit comparison, an address, a call
    /// argument, an indexed access and a floating conversion.
    #[test]
    fn unsigned_renormalization_with_a_read_high_word_is_kept() {
        let binop = |op| Inst::Binop { op, lhs: 2, rhs: 1 };
        let imm = |op| Inst::BinopI {
            op,
            lhs: 2,
            rhs_imm: 3,
        };
        let readers = [
            // v3 is stored at 8 bytes, and an `Or` passes the high word on.
            imm(BinOp::Or),
            imm(BinOp::Shr),
            imm(BinOp::Shru),
            binop(BinOp::Div),
            binop(BinOp::Divu),
            binop(BinOp::Modu),
            binop(BinOp::Ult),
            imm(BinOp::Lt),
            Inst::Load {
                addr: 2,
                disp: 0,
                kind: LoadKind::I32,
                volatile: false,
                align: 0,
            },
            Inst::LoadIndexed {
                base: 1,
                index: 2,
                index_ext: IndexExt::None,
                scale: 4,
                kind: LoadKind::I32,
            },
            Inst::CallExt {
                binding_idx: 0,
                args: vec![2],
                fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
                low_word_args: 0,
                fp_return: false,
                arg_aggs: Vec::new(),
                ret_agg: None,
                ret_slot_local: 0,
            },
            Inst::FpCast {
                kind: crate::c5::ir::FpCastKind::IntToFp,
                value: 2,
            },
        ];
        for reader in readers {
            let mut f = unsigned_renormalization_read_by(reader.clone(), None);
            run_one(&mut f);
            let mut reads_mask = false;
            f.insts[3].for_each_operand(|v| reads_mask |= v == 2);
            assert!(reads_mask, "{reader:?} -> {:?}", f.insts[3]);
        }
        // The mask itself stored at 8 bytes next to a low-word reader.
        let mut f = unsigned_renormalization_read_by(
            imm(BinOp::Add),
            Some(Inst::Store {
                addr: 0,
                disp: 0,
                value: 2,
                kind: StoreKind::I64,
                volatile: false,
                align: 0,
            }),
        );
        f.insts[4] = Inst::Store {
            addr: 0,
            disp: 0,
            value: 3,
            kind: StoreKind::I32,
            volatile: false,
            align: 0,
        };
        run_one(&mut f);
        assert_eq!(first_operand(&f.insts[3]), 2, "{:?}", f.insts[3]);
    }

    /// A mask that clears a bit of the low word is no renormalization.
    #[test]
    fn mask_clearing_a_low_word_bit_is_kept() {
        for mask in [0x7fff_ffff, 0xffff_fffe, 0xffff] {
            let mut f = unsigned_renormalization_read_by(
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 2,
                    rhs_imm: 1,
                },
                None,
            );
            f.insts[2] = Inst::BinopI {
                op: BinOp::And,
                lhs: 1,
                rhs_imm: mask,
            };
            f.insts[4] = Inst::Store {
                addr: 0,
                disp: 0,
                value: 3,
                kind: StoreKind::I32,
                volatile: false,
                align: 0,
            };
            run_one(&mut f);
            assert_eq!(first_operand(&f.insts[3]), 2, "{mask:#x}");
        }
    }

    #[test]
    fn extend_with_dead_high_bits_is_dropped() {
        let mut f = extend_over_add_feeding_store(StoreKind::I32);
        run_one(&mut f);
        assert!(
            matches!(f.insts[4], Inst::Store { value: 2, .. }),
            "narrow store should read the pre-extend add directly; got {:?}",
            f.insts[4],
        );
    }

    /// `Block::exit_acc` names the extend without reading it, so the
    /// extend is dropped as it is without the naming.
    #[test]
    fn block_exit_value_reads_no_high_bits() {
        let mut f = extend_over_add_feeding_store(StoreKind::I32);
        f.blocks[0].exit_acc = 3;
        run_one(&mut f);
        assert!(
            matches!(f.insts[4], Inst::Store { value: 2, .. }),
            "{:?}",
            f.insts[4]
        );
        assert_eq!(f.blocks[0].exit_acc, 2);
    }

    /// A terminator operand is read at full width: the returned extend
    /// stays, for its narrow consumer too.
    #[test]
    fn returned_extend_is_kept() {
        let mut f = extend_over_add_feeding_store(StoreKind::I32);
        f.blocks[0].terminator = Terminator::Return(3);
        f.blocks[0].exit_acc = 3;
        run_one(&mut f);
        assert!(
            matches!(f.insts[4], Inst::Store { value: 3, .. }),
            "{:?}",
            f.insts[4]
        );
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(3)));
    }

    #[test]
    fn extend_feeding_wide_store_is_kept() {
        let mut f = extend_over_add_feeding_store(StoreKind::I64);
        run_one(&mut f);
        assert!(
            matches!(f.insts[4], Inst::Store { value: 3, .. }),
            "8-byte store observes the upper bits; extend must stay",
        );
    }

    /// b0: v0 Imm; v1 Add(v0,v0); v2 Extend(v1, k0); Bz v2 -> b2 / b1
    /// b1: v3 Extend(v1, k1); v4 Add(v3, 1); Return(v4)
    /// b2: v5 Extend(v1, k0); v6 Add(v5, 1); Return(v6)
    /// I8/I16 kinds keep case 1/2 out of the way so the cross-block
    /// dedup is the only redirect source; the adds consume the extends
    /// away from the call-argument / return positions dedup skips.
    fn diamond_extends(k0: LoadKind, k1: LoadKind) -> FunctionSsa {
        fresh(
            vec![
                Inst::Imm(300),
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: k0,
                    nsw: false,
                },
                Inst::Extend {
                    value: 1,
                    kind: k1,
                    nsw: false,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 3,
                    rhs_imm: 1,
                },
                Inst::Extend {
                    value: 1,
                    kind: k0,
                    nsw: false,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 5,
                    rhs_imm: 1,
                },
            ],
            vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..3,
                    terminator: Terminator::Bz {
                        cond: 2,
                        target: 2,
                        fall_through: 1,
                    },
                    exit_acc: 2,
                },
                Block {
                    start_pc: 0,
                    inst_range: 3..5,
                    terminator: Terminator::Return(4),
                    exit_acc: 4,
                },
                Block {
                    start_pc: 0,
                    inst_range: 5..7,
                    terminator: Terminator::Return(6),
                    exit_acc: 6,
                },
            ],
        )
    }

    #[test]
    fn dominated_same_kind_extend_redirects_to_dominating_one() {
        let mut f = diamond_extends(LoadKind::I8, LoadKind::I8);
        run_one(&mut f);
        assert!(
            matches!(f.insts[4], Inst::BinopI { lhs: 2, .. }),
            "b1's extend duplicates the entry-block extend of the same \
             (value, kind) and must redirect to it; got {:?}",
            f.insts[4]
        );
        assert!(matches!(f.insts[6], Inst::BinopI { lhs: 2, .. }));
    }

    #[test]
    fn kind_mismatch_blocks_the_dedup() {
        let mut f = diamond_extends(LoadKind::I8, LoadKind::I16);
        run_one(&mut f);
        assert!(
            matches!(f.insts[4], Inst::BinopI { lhs: 3, .. }),
            "an I16 extend must not redirect to an I8 extend of the same value",
        );
    }

    #[test]
    fn sibling_branch_extend_is_not_deduped() {
        // b0: v0 Imm; v1 Add; Bz -> b2 / b1
        // b1: v2 Extend(v1, I8); v3 Add(v2, 1); Return(v3)
        // b2: v4 Extend(v1, I8); v5 Add(v4, 1); Return(v5)
        // Neither branch dominates the other; both extends stay.
        let mut f = fresh(
            vec![
                Inst::Imm(300),
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I8,
                    nsw: false,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 2,
                    rhs_imm: 1,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I8,
                    nsw: false,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 4,
                    rhs_imm: 1,
                },
            ],
            vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..2,
                    terminator: Terminator::Bz {
                        cond: 1,
                        target: 2,
                        fall_through: 1,
                    },
                    exit_acc: 1,
                },
                Block {
                    start_pc: 0,
                    inst_range: 2..4,
                    terminator: Terminator::Return(3),
                    exit_acc: 3,
                },
                Block {
                    start_pc: 0,
                    inst_range: 4..6,
                    terminator: Terminator::Return(5),
                    exit_acc: 5,
                },
            ],
        );
        run_one(&mut f);
        assert!(matches!(f.insts[3], Inst::BinopI { lhs: 2, .. }));
        assert!(
            matches!(f.insts[5], Inst::BinopI { lhs: 4, .. }),
            "sibling-branch extends have no dominance relation and must both stay",
        );
    }

    #[test]
    fn call_argument_extend_is_not_dedup_redirected() {
        // b0: v0 Imm; v1 Add; v2 Extend(v1, I8); Bz -> b2 / b1
        // b1: v3 Extend(v1, I8); v4 Call(args=[v3]); Return(v4)
        // b2: Return(v2)
        // The dominated extend feeds a call argument, so it stays: the
        // emit materialises it into the argument register in place.
        let mut f = fresh(
            vec![
                Inst::Imm(300),
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I8,
                    nsw: false,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I8,
                    nsw: false,
                },
                Inst::Call {
                    target_pc: 99,
                    args: alloc::vec![3],
                    fixed_args: 1,
                    fp_return: false,
                    fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
                    low_word_args: 0,
                    arg_aggs: Vec::new(),
                    ret_agg: None,
                    ret_slot_local: 0,
                },
            ],
            vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..3,
                    terminator: Terminator::Bz {
                        cond: 2,
                        target: 2,
                        fall_through: 1,
                    },
                    exit_acc: 2,
                },
                Block {
                    start_pc: 0,
                    inst_range: 3..5,
                    terminator: Terminator::Return(4),
                    exit_acc: 4,
                },
                Block {
                    start_pc: 0,
                    inst_range: 5..5,
                    terminator: Terminator::Return(2),
                    exit_acc: 2,
                },
            ],
        );
        run_one(&mut f);
        let Inst::Call { args, .. } = &f.insts[4] else {
            panic!("expected Call at v4");
        };
        assert_eq!(
            args[0], 3,
            "a call-argument extend keeps its own position; dedup must not \
             stretch the dominating extend's live range to the call",
        );
    }

    /// `v0 = param`, then per block its extends of `v0` (`E`) and calls
    /// (`C`), ended by the given terminator. Returns each value's redirect.
    fn dedup_around_calls(shape: &[(&str, Terminator)]) -> Vec<Option<ValueId>> {
        let mut insts = vec![Inst::ParamRef {
            idx: 0,
            kind: LoadKind::I64,
        }];
        let mut blocks = Vec::new();
        for (b, (ops, terminator)) in shape.iter().enumerate() {
            let start = if b == 0 { 0 } else { insts.len() as u32 };
            for op in ops.chars() {
                insts.push(match op {
                    'E' => Inst::Extend {
                        value: 0,
                        kind: LoadKind::I32,
                        nsw: false,
                    },
                    _ => Inst::Call {
                        target_pc: 99,
                        args: Vec::new(),
                        fixed_args: 0,
                        fp_return: false,
                        fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
                        low_word_args: 0,
                        arg_aggs: Vec::new(),
                        ret_agg: None,
                        ret_slot_local: 0,
                    },
                });
            }
            blocks.push(Block {
                start_pc: 0,
                inst_range: start..insts.len() as u32,
                terminator: *terminator,
                exit_acc: NO_VALUE,
            });
        }
        let f = fresh(insts, blocks);
        let mut redirect = vec![None; f.insts.len()];
        dedup_dominated_extends(&f, &mut redirect);
        redirect
    }

    fn bnz(cond: ValueId, target: u32, fall_through: u32) -> Terminator {
        Terminator::Bnz {
            cond,
            target,
            fall_through,
        }
    }

    /// A call on a cycle through the block is not between two extends
    /// of that block: the path around it runs the first one again.
    #[test]
    fn extends_of_one_block_share_past_a_call_on_its_cycle() {
        let r = dedup_around_calls(&[
            ("", Terminator::Jmp(1)),
            ("EE", Terminator::Jmp(2)),
            ("C", bnz(3, 1, 3)),
            ("", Terminator::Return(NO_VALUE)),
        ]);
        assert_eq!(r[2], Some(1));
    }

    /// A loop header's extend reaches its body past a call on the latch.
    #[test]
    fn header_extend_reaches_the_body_past_a_call_on_the_latch() {
        let r = dedup_around_calls(&[
            ("", Terminator::Jmp(1)),
            ("E", Terminator::Jmp(2)),
            ("E", Terminator::Jmp(3)),
            ("C", bnz(3, 1, 4)),
            ("", Terminator::Return(NO_VALUE)),
        ]);
        assert_eq!(r[2], Some(1));
    }

    /// Where the leader would live across a call, each extend stays: a
    /// call between them in one block, after the leader in its block,
    /// in a block between them, and in a loop the leader is outside of.
    #[test]
    fn an_extend_across_a_call_keeps_its_own() {
        let ret = || Terminator::Return(NO_VALUE);
        let r = dedup_around_calls(&[("ECE", ret())]);
        assert_eq!(r[3], None);
        let r = dedup_around_calls(&[("EC", Terminator::Jmp(1)), ("E", ret())]);
        assert_eq!(r[3], None);
        let r = dedup_around_calls(&[
            ("E", Terminator::Jmp(1)),
            ("C", Terminator::Jmp(2)),
            ("E", ret()),
        ]);
        assert_eq!(r[3], None);
        let r = dedup_around_calls(&[
            ("E", Terminator::Jmp(1)),
            ("E", Terminator::Jmp(2)),
            ("C", bnz(3, 1, 3)),
            ("", ret()),
        ]);
        assert_eq!(r[2], None);
    }

    /// Callee at ent_pc 7: ParamRef(0, I32) returned; caller passes
    /// Extend { v, I32 } as the argument of a direct call to it.
    fn caller_callee(callee_kind: LoadKind, variadic: bool) -> Vec<FunctionSsa> {
        let mut callee = fresh(
            vec![Inst::ParamRef {
                idx: 0,
                kind: callee_kind,
            }],
            vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Return(0),
                exit_acc: 0,
            }],
        );
        callee.ent_pc = 7;
        callee.n_params = 1;
        callee.is_variadic = variadic;
        let mut caller = fresh(
            vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                    nsw: false,
                },
                Inst::Call {
                    target_pc: 7,
                    args: alloc::vec![2],
                    fixed_args: 1,
                    fp_return: false,
                    fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
                    low_word_args: 0,
                    arg_aggs: Vec::new(),
                    ret_agg: None,
                    ret_slot_local: 0,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..4,
                terminator: Terminator::Return(3),
                exit_acc: 3,
            }],
        );
        caller.ent_pc = 9;
        alloc::vec![callee, caller]
    }

    fn call_arg(funcs: &[FunctionSsa]) -> u32 {
        let Inst::Call { args, .. } = &funcs[1].insts[3] else {
            panic!("expected Call at v3");
        };
        args[0]
    }

    #[test]
    fn call_arg_extend_drops_when_callee_reextends() {
        let mut funcs = caller_callee(LoadKind::I32, false);
        run(&mut funcs);
        assert_eq!(
            call_arg(&funcs),
            1,
            "the callee's ParamRef(I32) re-extends, so the caller passes the raw add",
        );
    }

    #[test]
    fn call_arg_extend_stays_for_wider_param_kind() {
        // Callee reads 8 bytes of the incoming register (ParamRef I64):
        // dropping the caller's I32 extend would expose raw high bits.
        let mut funcs = caller_callee(LoadKind::I64, false);
        run(&mut funcs);
        assert_eq!(call_arg(&funcs), 2);
    }

    #[test]
    fn call_arg_extend_stays_for_variadic_callee() {
        let mut funcs = caller_callee(LoadKind::I32, true);
        run(&mut funcs);
        assert_eq!(call_arg(&funcs), 2);
    }

    #[test]
    fn call_arg_extend_stays_when_param_cell_escapes() {
        let mut funcs = caller_callee(LoadKind::I32, false);
        // Take the address of the parameter's c5 cdecl cell: the raw
        // incoming register is spilled there and may be read wide.
        funcs[0].insts.push(Inst::LocalAddr(2));
        funcs[0].blocks[0].inst_range = 0..2;
        run(&mut funcs);
        assert_eq!(call_arg(&funcs), 2);
    }

    #[test]
    fn call_arg_extend_stays_for_external_callee() {
        // The argument feeds an external call (CallExt), whose entry
        // behavior is unknown, so the caller-side extend must stay: the
        // rewrite pass only touches direct internal `Inst::Call`.
        let mut caller = fresh(
            vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                    nsw: false,
                },
                Inst::CallExt {
                    binding_idx: 0,
                    args: alloc::vec![2],
                    fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
                    low_word_args: 0,
                    fp_return: false,
                    arg_aggs: Vec::new(),
                    ret_agg: None,
                    ret_slot_local: 0,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..4,
                terminator: Terminator::Return(3),
                exit_acc: 3,
            }],
        );
        caller.ent_pc = 9;
        let mut funcs = alloc::vec![caller];
        run(&mut funcs);
        let Inst::CallExt { args, .. } = &funcs[0].insts[3] else {
            panic!("expected CallExt at v3");
        };
        assert_eq!(
            args[0], 2,
            "an external callee's entry behavior is unknown; the extend stays",
        );
    }

    #[test]
    fn extend_feeding_signed_compare_is_kept() {
        // v3 Extend(v2) feeds a signed `Lt` compare, which reads the
        // sign bit in the high half, so it must not be dropped.
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                    volatile: false,
                    align: 0,
                },
                Inst::Binop {
                    op: BinOp::Mul,
                    lhs: 1,
                    rhs: 1,
                },
                Inst::Extend {
                    value: 2,
                    kind: LoadKind::I32,
                    nsw: false,
                },
                Inst::BinopI {
                    op: BinOp::Lt,
                    lhs: 3,
                    rhs_imm: 0,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..5,
                terminator: Terminator::Return(4),
                exit_acc: 4,
            }],
        );
        run_one(&mut f);
        assert!(
            matches!(f.insts[4], Inst::BinopI { lhs: 3, .. }),
            "signed compare must keep reading the sign-extended value",
        );
    }

    /// A `MulAdd` read at 64 bits observes its operands' high bits, so a
    /// narrow extension feeding it is not high-dead.
    #[test]
    fn mul_add_read_wide_observes_its_operands() {
        let f = fresh(
            vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I32,
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64,
                },
                Inst::Extend {
                    value: 0,
                    kind: LoadKind::I32,
                    nsw: false,
                },
                Inst::MulAdd {
                    a: 2,
                    b: 1,
                    c: 1,
                    neg_product: false,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..4,
                terminator: Terminator::Return(3),
                exit_acc: 3,
            }],
        );
        assert!(
            compute_high_observed(&f)[2],
            "the extension feeding a wide-read MulAdd is observed",
        );
    }

    /// v0 Imm; v1 Add(v0,v0); v2 Extend(v1,inner); v3 Extend(v2,outer);
    /// Return(v3). The return reads all 64 bits, so only the covering
    /// widths may collapse.
    fn stacked_extends(inner: LoadKind, outer: LoadKind) -> FunctionSsa {
        fresh(
            vec![
                Inst::Imm(0),
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: inner,
                    nsw: false,
                },
                Inst::Extend {
                    value: 2,
                    kind: outer,
                    nsw: false,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..4,
                terminator: Terminator::Return(3),
                exit_acc: 3,
            }],
        )
    }

    #[test]
    fn extend_of_no_wider_extend_collapses() {
        for (inner, outer) in [
            (LoadKind::I32, LoadKind::I32),
            (LoadKind::I8, LoadKind::I32),
            (LoadKind::I16, LoadKind::I32),
            (LoadKind::I8, LoadKind::I16),
        ] {
            let mut f = stacked_extends(inner, outer);
            run_one(&mut f);
            assert!(
                matches!(f.blocks[0].terminator, Terminator::Return(2)),
                "{inner:?} inside {outer:?} reproduces the inner bits; the \
                 outer extend must drop",
            );
            assert_eq!(f.blocks[0].exit_acc, 2);
        }
    }

    #[test]
    fn extend_narrower_than_its_operand_is_kept() {
        for (inner, outer) in [
            (LoadKind::I32, LoadKind::I8),
            (LoadKind::I32, LoadKind::I16),
            (LoadKind::I16, LoadKind::I8),
        ] {
            let mut f = stacked_extends(inner, outer);
            run_one(&mut f);
            assert!(
                matches!(f.blocks[0].terminator, Terminator::Return(3)),
                "{outer:?} truncates below {inner:?}; the outer extend stays",
            );
        }
    }

    #[test]
    fn collapsed_extend_forwards_its_high_use_to_the_operand() {
        // The outer extend collapses onto the inner one, so the inner
        // one inherits the return's read of the upper half and must not
        // be dropped under the low-word rule -- the resolved chain would
        // otherwise hand the return the un-normalized add.
        let mut f = stacked_extends(LoadKind::I32, LoadKind::I32);
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(2)),
            "the return must read the surviving extend, not the raw add",
        );
    }

    fn block(range: core::ops::Range<u32>, terminator: Terminator) -> Block {
        Block {
            start_pc: 0,
            inst_range: range,
            terminator,
            exit_acc: NO_VALUE,
        }
    }

    fn and(lhs: ValueId, rhs_imm: i64) -> Inst {
        Inst::BinopI {
            op: BinOp::And,
            lhs,
            rhs_imm,
        }
    }

    /// `b0: Bz(p) -> b2 else b1; b1: -> b2; b2: v3 = phi(b0: v1, b1: v2)`, `tail`.
    fn join(v1: Inst, v2: Inst, tail: Vec<Inst>) -> FunctionSsa {
        let mut insts = vec![
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I32,
            },
            v1,
            v2,
            Inst::Phi {
                incoming: vec![(0, 1), (1, 2)],
                kind: LoadKind::I64,
            },
        ];
        insts.extend(tail);
        let n = insts.len() as u32;
        fresh(
            insts,
            vec![
                block(
                    0..3,
                    Terminator::Bz {
                        cond: 0,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(3..3, Terminator::Jmp(2)),
                block(3..n, Terminator::Return(n - 1)),
            ],
        )
    }

    #[test]
    fn mask_of_a_join_of_masked_values_is_dropped() {
        // v4 = v3 & 0xff and v5 = v3 & 0x1ff keep every bit the join can
        // hold; v6 = v3 & 0x7f clears bit 7, which the masked byte can set.
        let mut f = join(
            Inst::Imm(0),
            and(0, 0xff),
            vec![
                and(3, 0xff),
                and(3, 0x1ff),
                and(3, 0x7f),
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 4,
                    rhs: 5,
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 7,
                    rhs: 6,
                },
            ],
        );
        drop_fitting(&mut f, &[]);
        assert!(
            matches!(f.insts[7], Inst::Binop { lhs: 3, rhs: 3, .. })
                && matches!(f.insts[8], Inst::Binop { lhs: 7, rhs: 6, .. }),
            "{:?}",
            f.insts
        );
    }

    #[test]
    fn mask_of_a_join_with_a_wider_incoming_value_is_kept() {
        let mut f = join(
            Inst::Imm(0),
            Inst::ParamRef {
                idx: 1,
                kind: LoadKind::I32,
            },
            vec![and(3, 0xff)],
        );
        drop_fitting(&mut f, &[]);
        assert!(matches!(f.blocks[2].terminator, Terminator::Return(4)));
    }

    #[test]
    fn sign_extend_of_a_join_drops_only_where_the_incoming_values_fit() {
        let byte = |v2: Inst| {
            let tail = vec![Inst::Extend {
                value: 3,
                kind: LoadKind::I8,
                nsw: false,
            }];
            let mut f = join(Inst::Imm(-3), v2, tail);
            drop_fitting(&mut f, &[]);
            f.blocks[2].terminator
        };
        let sext = Inst::Extend {
            value: 0,
            kind: LoadKind::I8,
            nsw: false,
        };
        assert!(matches!(byte(sext), Terminator::Return(3)));
        // A masked byte reaches 0xff, which a signed char does not hold.
        assert!(matches!(byte(and(0, 0xff)), Terminator::Return(4)));
    }

    /// `n - 2` on both sides of `n < 2`, each renormalized and stored at 8
    /// bytes so the extension's upper half is read:
    ///
    /// b0: v0 = n; v1 = v0 < 2                     Bnz v1 -> b2 else b1
    /// b1: v2 = v0 - 2; v3 = sext32(v2); store v3  return
    /// b2: v4 = v0 - 2; v5 = sext32(v4); store v5  return
    fn decrement_on_both_sides(n: Inst, narrow_compare: bool) -> FunctionSsa {
        let sub = Inst::BinopI {
            op: BinOp::Sub,
            lhs: 0,
            rhs_imm: 2,
        };
        let ext = |value| Inst::Extend {
            value,
            kind: LoadKind::I32,
            nsw: false,
        };
        let store = |value| Inst::StoreLocal {
            off: -1,
            value,
            kind: StoreKind::I64,
            volatile: false,
            nsw: false,
        };
        let insts = vec![
            n,
            Inst::BinopI {
                op: BinOp::Lt,
                lhs: 0,
                rhs_imm: 2,
            },
            sub.clone(),
            ext(2),
            store(3),
            sub,
            ext(5),
            store(6),
        ];
        let block = |inst_range, terminator| Block {
            start_pc: 0,
            inst_range,
            terminator,
            exit_acc: NO_VALUE,
        };
        let mut f = fresh(
            insts,
            vec![
                block(
                    0..2,
                    Terminator::Bnz {
                        cond: 1,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(2..5, Terminator::Return(NO_VALUE)),
                block(5..8, Terminator::Return(NO_VALUE)),
            ],
        );
        f.n_params = 1;
        if narrow_compare {
            f.cmp32 = vec![false, true];
        }
        f
    }

    /// Under `n >= 2` the decrement of an `int` stays inside `int` and its
    /// renormalization is the identity; under `n < 2` it can wrap and the
    /// renormalization stays. The same expression in the two blocks takes
    /// each block's own bound.
    #[test]
    fn renormalization_under_a_guard_drops_where_the_range_fits() {
        let n = Inst::ParamRef {
            idx: 0,
            kind: LoadKind::I32,
        };
        for narrow_compare in [false, true] {
            let mut f = decrement_on_both_sides(n.clone(), narrow_compare);
            drop_fitting(&mut f, &[]);
            assert!(
                matches!(f.insts[4], Inst::StoreLocal { value: 2, .. }),
                "narrow={narrow_compare}: {:?}",
                f.insts[4]
            );
            assert!(
                matches!(f.insts[7], Inst::StoreLocal { value: 6, .. }),
                "narrow={narrow_compare}: {:?}",
                f.insts[7]
            );
        }
    }

    /// A 32-bit comparison of a register whose upper half is unknown says
    /// nothing about the register: `n - 2` over a 64-bit `n` keeps its
    /// renormalization on both sides. Read at 64 bits, the comparison
    /// bounds `n` from below only, and `n - 2` still leaves `int` above.
    #[test]
    fn narrow_guard_of_a_wide_value_drops_no_renormalization() {
        let wide = Inst::LoadLocal {
            off: -2,
            kind: LoadKind::I64,
            volatile: false,
        };
        for narrow_compare in [true, false] {
            let mut f = decrement_on_both_sides(wide.clone(), narrow_compare);
            drop_fitting(&mut f, &[]);
            assert!(matches!(f.insts[4], Inst::StoreLocal { value: 3, .. }));
            assert!(matches!(f.insts[7], Inst::StoreLocal { value: 6, .. }));
        }
    }

    /// A byte carried around a back edge, masked by register operands.
    #[test]
    fn mask_of_a_loop_carried_byte_is_dropped() {
        // b0: v0 = 0xff; v1 = p; v2 = 0                 -> b1
        // b1: v3 = phi(b0: v2, b2: v6); v4 = v0 & v3    Bnz v1 -> b2 else b3
        // b2: v5 = v4 + 1; v6 = v5 & v0                 -> b1
        // b3: v7 = v3 & 0xff                            return v7
        let mut f = fresh(
            vec![
                Inst::Imm(0xff),
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::Imm(0),
                Inst::Phi {
                    incoming: vec![(0, 2), (2, 6)],
                    kind: LoadKind::I64,
                },
                Inst::Binop {
                    op: BinOp::And,
                    lhs: 0,
                    rhs: 3,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 4,
                    rhs_imm: 1,
                },
                Inst::Binop {
                    op: BinOp::And,
                    lhs: 5,
                    rhs: 0,
                },
                and(3, 0xff),
            ],
            vec![
                block(0..3, Terminator::Jmp(1)),
                block(
                    3..5,
                    Terminator::Bnz {
                        cond: 1,
                        target: 2,
                        fall_through: 3,
                    },
                ),
                block(5..7, Terminator::Jmp(1)),
                block(7..8, Terminator::Return(7)),
            ],
        );
        drop_fitting(&mut f, &[]);
        assert!(
            matches!(f.insts[5], Inst::BinopI { lhs: 3, .. })
                && matches!(f.insts[6], Inst::Binop { lhs: 5, rhs: 0, .. })
                && matches!(f.blocks[3].terminator, Terminator::Return(3)),
            "{:?} {:?}",
            f.insts,
            f.blocks[3].terminator
        );
    }
}

//! Drop a redundant `Inst::Extend { value, kind }` by redirecting its
//! consumers to `value`. An extend is redundant in two cases:
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
//!      integer arithmetic.
//!
//! A third case works across blocks: two `Extend`s of the same SSA
//! value with the same `kind` compute the same result, so an occurrence
//! at a position dominated by another redirects to the dominating one
//! (`dedup_dominated_extends`). Extends of a value round-tripped
//! through a spill slot are not tracked: proving the slot was stored
//! extended needs a per-slot reaching-store analysis, so those stay.
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

use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId};
use alloc::vec::Vec;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        run_one(func);
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

/// For every value, whether any consumer reads bits at or above bit 32.
///
/// An `Add`/`Sub`/`Mul`/`And`/`Or`/`Xor`/`Shl` result's low 32 bits depend only
/// on its operands' low 32 bits (C99 6.2.5p9 / 6.5p5: two's-complement low-word
/// arithmetic), and a `Phi` selects one operand, so these forward the consumer's
/// observation to their operands and are transparent to the low word. A right
/// shift, divide/modulo, rotate, ordered/equality compare, 64-bit store, address
/// operand, call argument, FP cast, atomic, return, or branch condition reads the
/// full register, so it observes the upper bits directly. `Inst::Extend` reads
/// only the low `kind`-width bits, so it never observes its source's upper bits.
/// Anything not positively classified as low-word-only is treated as observing,
/// so the result is a conservative over-approximation. Shared with the allocator,
/// which consults it to skip a `ParamRef` entry sign-extension whose result is
/// never read above bit 31 (the parameter's low word already holds the C99
/// 6.5.2.2p4-converted value; the return boundary stays conservative, so a value
/// feeding the return keeps its canonicalization).
pub(crate) fn compute_high_observed(func: &FunctionSsa) -> Vec<bool> {
    let n = func.insts.len();
    let mut hi = alloc::vec![false; n];
    let mut work: Vec<ValueId> = Vec::new();

    for inst in &func.insts {
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
            | Inst::ParamRef { .. }
            | Inst::Extend { .. } => {}
            Inst::Load { addr, .. } => observe(&mut hi, &mut work, *addr),
            Inst::LoadIndexed { base, index, .. } => {
                observe(&mut hi, &mut work, *base);
                observe(&mut hi, &mut work, *index);
            }
            Inst::Store {
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
                value,
                kind,
                ..
            } => {
                observe(&mut hi, &mut work, *base);
                observe(&mut hi, &mut work, *index);
                if *kind == StoreKind::I64 {
                    observe(&mut hi, &mut work, *value);
                }
            }
            Inst::Binop { op, lhs, rhs } => match op {
                BinOp::Add | BinOp::Sub | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor => {}
                BinOp::Shl => observe(&mut hi, &mut work, *rhs),
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
                _ => observe(&mut hi, &mut work, *lhs),
            },
            Inst::FpCast { value, .. } => observe(&mut hi, &mut work, *value),
            Inst::Fneg(v) => observe(&mut hi, &mut work, *v),
            Inst::Fma { a, b, c, .. } => {
                observe(&mut hi, &mut work, *a);
                observe(&mut hi, &mut work, *b);
                observe(&mut hi, &mut work, *c);
            }
            Inst::Call { args, .. }
            | Inst::CallExt { args, .. }
            | Inst::Intrinsic { args, .. }
            | Inst::InlineAsm { args, .. } => {
                for a in args {
                    observe(&mut hi, &mut work, *a);
                }
            }
            Inst::CallIndirect { target, args, .. } => {
                observe(&mut hi, &mut work, *target);
                for a in args {
                    observe(&mut hi, &mut work, *a);
                }
            }
            Inst::Mcpy { dst, src, .. } => {
                observe(&mut hi, &mut work, *dst);
                observe(&mut hi, &mut work, *src);
            }
            Inst::AtomicRmw { addr, value, .. } => {
                observe(&mut hi, &mut work, *addr);
                observe(&mut hi, &mut work, *value);
            }
            Inst::AtomicCas {
                addr,
                expected_addr,
                desired,
                ..
            } => {
                observe(&mut hi, &mut work, *addr);
                observe(&mut hi, &mut work, *expected_addr);
                observe(&mut hi, &mut work, *desired);
            }
            Inst::Phi { .. } => {}
        }
    }
    for block in &func.blocks {
        if block.exit_acc != NO_VALUE {
            observe(&mut hi, &mut work, block.exit_acc);
        }
        match &block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                observe(&mut hi, &mut work, *cond);
            }
            Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. } => {
                observe(&mut hi, &mut work, *target)
            }
            Terminator::Return(v) if *v != NO_VALUE => observe(&mut hi, &mut work, *v),
            _ => {}
        }
    }

    // Propagate: an observed transparent result observes its operands.
    while let Some(r) = work.pop() {
        match &func.insts[r as usize] {
            Inst::Binop {
                op: BinOp::Add | BinOp::Sub | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor,
                lhs,
                rhs,
            } => {
                observe(&mut hi, &mut work, *lhs);
                observe(&mut hi, &mut work, *rhs);
            }
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
            _ => {}
        }
    }
    hi
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
    let mut depth = alloc::vec![u32::MAX; func.blocks.len()];
    for b in 0..func.blocks.len() {
        if idom[b] == u32::MAX {
            continue;
        }
        let (mut d, mut cur) = (0u32, b as u32);
        while cur != 0 && idom[cur as usize] != u32::MAX {
            cur = idom[cur as usize];
            d += 1;
        }
        depth[b] = d;
    }
    let mut groups: HashMap<(ValueId, LoadKind), Vec<ValueId>> = HashMap::new();
    for (idx, inst) in func.insts.iter().enumerate() {
        let Inst::Extend { value, kind } = inst else {
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
    let succs = |b: u32| {
        crate::c5::codegen::ssa::mem2reg::successors(
            &func.blocks[b as usize].terminator,
            &func.computed_goto_targets,
            &func.jump_tables,
        )
    };
    // Whether some path from `c` (exclusive) to `e` (exclusive) passes a
    // call: the straight-line segment when both sit in one block, else a
    // forward search over successor edges carrying a seen-a-call state.
    // The start block contributes its calls after `c`, the target block
    // its calls before `e`, and any block in between its calls
    // wholesale (a cyclic revisit of the start / target block too).
    let call_between = |c: ValueId, e: ValueId| -> bool {
        let c_blk = inst_block[c as usize];
        let e_blk = inst_block[e as usize];
        if c_blk == e_blk && c < e && call_in(c_blk, c + 1..e) {
            return true;
        }
        let n = func.blocks.len();
        let mut seen = alloc::vec![[false; 2]; n];
        let mut work: Vec<(u32, bool)> = Vec::new();
        let start_flag = call_in(c_blk, c + 1..u32::MAX);
        for s in succs(c_blk) {
            if !seen[s as usize][start_flag as usize] {
                seen[s as usize][start_flag as usize] = true;
                work.push((s, start_flag));
            }
        }
        while let Some((b, f)) = work.pop() {
            if b == e_blk && (f || call_in(b, 0..e)) {
                return true;
            }
            let f2 = f || block_has_call[b as usize];
            for s in succs(b) {
                if !seen[s as usize][f2 as usize] {
                    seen[s as usize][f2 as usize] = true;
                    work.push((s, f2));
                }
            }
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
        if block.exit_acc != NO_VALUE {
            bump(&mut use_counts, block.exit_acc);
        }
        match block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                bump(&mut use_counts, cond)
            }
            Terminator::GotoIndirect { target } => bump(&mut use_counts, target),
            Terminator::Return(v) if v != NO_VALUE => bump(&mut use_counts, v),
            _ => {}
        }
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
/// callee's entry behavior is unknown, so those keep the canonical
/// C99 6.5.2.2p4-converted argument value.
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
                let Some(Inst::Extend { value, kind }) = func.insts.get(a as usize) else {
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

fn run_one(func: &mut FunctionSsa) {
    let n = func.insts.len();
    if !func.insts.iter().any(|i| matches!(i, Inst::Extend { .. })) {
        return;
    }
    // An Extend is redundant when (1) its operand is a narrow integer load
    // whose extension it re-applies: a signed load already sign-extends to 64
    // bits, so an equal-or-wider sign-extend reproduces the same bits; an
    // unsigned load zero-extends, so a strictly-wider sign-extend lands its
    // sign bit in the zero region and is likewise a no-op. This covers the
    // `int`-return sign-extend of a char/short load left by the callee-
    // narrowing convention. Or (2) it is an i32 sign-extend whose upper bits no
    // consumer reads, so every consumer sees the same low 32 bits in the
    // operand. Both redirect the extend's consumers to the operand; `resolve`
    // walks redirect chains.
    let high = compute_high_observed(func);
    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; n];
    for (idx, inst) in func.insts.iter().enumerate() {
        let Inst::Extend { value, kind } = inst else {
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
        if load_covers || (*kind == LoadKind::I32 && !high[idx]) {
            redirect[idx] = Some(*value);
        }
    }
    dedup_dominated_extends(func, &mut redirect);
    if redirect.iter().all(|r| r.is_none()) {
        return;
    }
    // Rewrite every operand, terminator value, and block accumulator.
    for inst in func.insts.iter_mut() {
        // The redirect-from list (the dead Extends) reads the load
        // operand; rewriting it would be a self-edit, so skip those
        // and let the per-arch emit's is_dead_pure path drop them.
        if let Inst::Extend { value: _, kind: _ } = inst {
            continue;
        }
        for_each_operand_mut(inst, |op| *op = resolve(&redirect, *op));
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            block.exit_acc = resolve(&redirect, block.exit_acc);
        }
        match &mut block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                *cond = resolve(&redirect, *cond);
            }
            Terminator::Return(v) if *v != NO_VALUE => {
                *v = resolve(&redirect, *v);
            }
            _ => {}
        }
    }
}

/// Walk every value operand the inst references and call `f` with
/// a mutable reference. Mirrors `ssa_mem2reg::for_each_operand_mut`.
fn for_each_operand_mut(inst: &mut Inst, mut f: impl FnMut(&mut ValueId)) {
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
        | Inst::ParamRef { .. } => {}
        Inst::Load { addr, .. } => f(addr),
        Inst::Store { addr, value, .. } => {
            f(addr);
            f(value);
        }
        Inst::StoreLocal { value, .. } => f(value),
        Inst::LoadIndexed { base, index, .. } => {
            f(base);
            f(index);
        }
        Inst::StoreIndexed {
            base, index, value, ..
        } => {
            f(base);
            f(index);
            f(value);
        }
        Inst::Binop { lhs, rhs, .. } => {
            f(lhs);
            f(rhs);
        }
        Inst::BinopI { lhs, .. } => f(lhs),
        Inst::Fneg(v) => f(v),
        Inst::Fma { a, b, c, .. } => {
            f(a);
            f(b);
            f(c);
        }
        Inst::Extend { value, .. } => f(value),
        Inst::FpCast { value, .. } => f(value),
        Inst::Call { args, .. }
        | Inst::CallExt { args, .. }
        | Inst::Intrinsic { args, .. }
        | Inst::InlineAsm { args, .. } => {
            for a in args {
                f(a);
            }
        }
        Inst::CallIndirect { target, args, .. } => {
            f(target);
            for a in args {
                f(a);
            }
        }
        Inst::Mcpy { dst, src, .. } => {
            f(dst);
            f(src);
        }
        Inst::AtomicRmw { addr, value, .. } => {
            f(addr);
            f(value);
        }
        Inst::AtomicCas {
            addr,
            expected_addr,
            desired,
            ..
        } => {
            f(addr);
            f(expected_addr);
            f(desired);
        }
        Inst::Phi { incoming, .. } => {
            for (_, v) in incoming {
                f(v);
            }
        }
    }
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
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
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
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
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
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
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
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
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
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I8,
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
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I64,
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
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
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
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 1,
                    rhs: 1,
                },
                Inst::Extend {
                    value: 2,
                    kind: LoadKind::I32,
                },
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 3,
                    kind: store_kind,
                    volatile: false,
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
                Inst::Extend { value: 1, kind: k0 },
                Inst::Extend { value: 1, kind: k1 },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 3,
                    rhs_imm: 1,
                },
                Inst::Extend { value: 1, kind: k0 },
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
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 2,
                    rhs_imm: 1,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I8,
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
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I8,
                },
                Inst::Call {
                    target_pc: 99,
                    args: alloc::vec![3],
                    fixed_args: 1,
                    fp_return: false,
                    fp_arg_mask: 0,
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
                Inst::Imm(300),
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                },
                Inst::Call {
                    target_pc: 7,
                    args: alloc::vec![2],
                    fixed_args: 1,
                    fp_return: false,
                    fp_arg_mask: 0,
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
                Inst::Imm(300),
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 0,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                },
                Inst::CallExt {
                    binding_idx: 0,
                    args: alloc::vec![2],
                    fp_arg_mask: 0,
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
                },
                Inst::Binop {
                    op: BinOp::Mul,
                    lhs: 1,
                    rhs: 1,
                },
                Inst::Extend {
                    value: 2,
                    kind: LoadKind::I32,
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
}

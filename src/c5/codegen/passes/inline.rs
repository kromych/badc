//! Function inlining over the SSA tier.
//!
//! Runs under `-O` after `ssa_mem2reg`, so the candidate filter sees
//! the promoted form: dead cell loads / stores are gone and the
//! callee reads its parameters via `ParamRef`. Substitutes eligible
//! `Inst::Call` sites with the callee's body. Eligibility
//! is intentionally narrow:
//!
//! * caller and callee bodies remain in the same translation unit;
//! * callee has a single basic block terminating in `Return`;
//! * callee's body is at most `cap` instructions (the
//!   `--inline-cap=N` knob; default 32);
//! * callee is non-variadic;
//! * callee's body contains no `Call*` / `Phi` / `AllocaInit` / `Mcpy`
//!   / `Store*` / `Intrinsic` / `TailExt` -- only the pure
//!   straight-line shapes whose `for_each_operand` walks a known set of
//!   `ValueId` fields. A `LocalAddr` is admitted only when it names a
//!   register-passed struct parameter's slot: the splice redirects it
//!   to the caller's argument address, inlining a one-word-struct
//!   read-only helper. Any other `LocalAddr` stays rejected.
//!
//! Those constraints cover the small leaf helpers (R / Ch / Maj /
//! Sigma / sigma in SHA-512, `stb__perlin_lerp` / `fastfloor` /
//! `grad` in Perlin noise) whose call overhead dominates the
//! crypto / stb perf rows.
//!
//! Substitution rewrites each callee `Inst` into the caller's value
//! space, mapping `ParamRef(i)` to the i-th call argument and other
//! operands through the caller's running remap. The `Inst::Call`
//! itself is removed; the callee's `Return(v)` value replaces every
//! later reference to the call's old `ValueId`. Block boundaries
//! shift forward, terminators and exit_acc get remapped.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec;
use alloc::vec::Vec;

use crate::c5::codegen::Abi;
use crate::c5::codegen::abi_classify::{AggClass, RegClass, classify_aggregate};
use crate::c5::ir::{
    BinOp, Block, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId,
};

/// Outer candidacy fixpoint cap: re-evaluating candidacy after each
/// substitution pass lets a helper that became a leaf inline on the
/// next round. A 3-level call chain reaches the bottom in 3 rounds, so
/// this bounds the chain depth that fully collapses.
const INLINE_FIXPOINT_ITERS: usize = 8;

/// Per-call-step cap on multi-block splices into one caller, bounding
/// expansion when a caller has many distinct multi-block call sites.
const MAX_MULTI_BLOCK_SPLICE_STEPS: usize = 64;

fn store_width(kind: StoreKind) -> i64 {
    match kind {
        StoreKind::I8 => 1,
        StoreKind::I16 => 2,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::I64 | StoreKind::F64 => 8,
    }
}

/// Whether `addr`'s defining instruction is `LocalAddr(slot)`.
fn addr_is_slot(func: &FunctionSsa, addr: ValueId, slot: i64) -> bool {
    slot_base_offset(func, addr, slot).is_some()
}

/// If `addr` names `slot` -- either `LocalAddr(slot)` directly, or
/// `BinopI(Add, LocalAddr(slot), K)` (a field address before the per-arch
/// disp folds it into the store) -- return the byte offset from the slot
/// base. A second-eightbyte store of a two-register return reaches the
/// candidate filter in the unfolded `Add` form, so the result-slot writes
/// must be recognised through it.
fn slot_base_offset(func: &FunctionSsa, addr: ValueId, slot: i64) -> Option<i64> {
    match func.insts.get(addr as usize) {
        Some(Inst::LocalAddr(s)) if *s == slot => Some(0),
        Some(Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm,
        }) => match func.insts.get(*lhs as usize) {
            Some(Inst::LocalAddr(s)) if *s == slot => Some(*rhs_imm),
            _ => None,
        },
        _ => None,
    }
}

/// `inst.is_inline_candidate(cap)`-style predicate. See module docs.
fn is_inline_candidate(func: &FunctionSsa, cap: u32, abi: Abi) -> bool {
    #[cfg(feature = "codegen_test")]
    let trace = std::env::var("BADC_LOG_INLINE").is_ok();
    #[cfg(feature = "codegen_test")]
    let say = |reason: &str| {
        if trace {
            eprintln!(
                "[inline] reject {n} (ent_pc={pc}): {r}",
                n = func.name,
                pc = func.ent_pc,
                r = reason
            );
        }
    };
    #[cfg(not(feature = "codegen_test"))]
    let say = |_: &str| {};

    if func.is_variadic {
        say("variadic");
        return false;
    }
    // A body calling a returns-twice function (setjmp family / vfork)
    // stays out of line: splicing it would silently drop the caller's
    // no-slot-share discipline (`FunctionSsa::has_returns_twice_call`).
    if func.has_returns_twice_call {
        say("calls a returns-twice function");
        return false;
    }
    // Host-ABI aggregates are admitted only in the shapes the splice can
    // reproduce: a by-value parameter passed in a single integer register
    // (it arrives as the address of the caller's copy in one argument, and
    // the body's field loads off the parameter slot redirect to that
    // address), and a return passed in one or two integer registers (the
    // body's result-slot writes redirect to the caller's return slot).
    // Memory-class and FP-class shapes stay rejected.
    if !func.agg_descs.is_empty() {
        // The redirect (parameter slot -> caller argument address; result
        // slot -> caller return slot) is wired only through the flat
        // single-block splice; a multi-block aggregate callee would reach
        // `splice_multi_block`, which has no redirect.
        if func.blocks.len() != 1 {
            say("multi-block aggregate");
            return false;
        }
        // Every descriptor must pass by value in integer registers. A
        // by-value parameter arrives as a single argument value -- the
        // address of the caller's copy (the SSA `Inst::Call` carries one
        // arg per struct parameter regardless of how many registers the
        // ABI marshals it into), which the splice redirects the body's
        // `LocalAddr(slot)` reads to. So a one- or two-register integer
        // aggregate parameter is admissible; the redirect is identical
        // either way. A return is delivered in the integer return
        // registers (rax:rdx / x0:x1), so it may occupy one or two.
        // FP-class and memory-class shapes stay rejected.
        for (i, d) in func.agg_descs.iter().enumerate() {
            let is_ret = func.ret_agg == Some(i as u32);
            let max_regs = 2;
            match classify_aggregate(d.size, d.align, &d.fields, abi, is_ret) {
                AggClass::Regs(regs)
                    if !regs.is_empty()
                        && regs.len() <= max_regs
                        && regs.iter().all(|r| *r == RegClass::Integer) => {}
                _ => {
                    say("aggregate not in one or two integer registers");
                    return false;
                }
            }
        }
    }
    // Multi-block callees are supported when exactly one block
    // terminates in `Return`. Other terminator shapes (Jmp, Bz, Bnz,
    // FallThrough) drive intra-callee control flow; the splice
    // rewrites the single Return to a `Jmp(postfix)`. Multi-Return
    // shapes would need a postfix phi and are rejected.
    // TODO: support multi-Return callees via a postfix phi.
    let mut return_blocks = 0usize;
    for blk in &func.blocks {
        match blk.terminator {
            Terminator::Return(_) => return_blocks += 1,
            Terminator::TailExt(_) => {
                say("TailExt terminator");
                return false;
            }
            Terminator::GotoIndirect { .. } => {
                // A computed goto's successors are the function's
                // address-taken label blocks; splicing the body into a
                // caller would shift those block ids. Keep it out of line.
                say("GotoIndirect terminator");
                return false;
            }
            Terminator::Jmp(_)
            | Terminator::FallThrough(_)
            | Terminator::Bz { .. }
            | Terminator::Bnz { .. } => {}
        }
    }
    if return_blocks != 1 {
        say(&alloc::format!("{return_blocks} Return blocks (need 1)"));
        return false;
    }
    // `inline` / `__attribute__((always_inline))`-marked functions
    // bypass the body-size cap (gcc / clang -O2 policy). The other
    // shape constraints still apply.
    if !func.is_inline && func.insts.len() > cap as usize {
        say(&alloc::format!(
            "{n} insts > cap {c}",
            n = func.insts.len(),
            c = cap
        ));
        return false;
    }
    // Walker emits dead `LoadLocal { off >= 2 }` cells alongside the
    // matching `ParamRef`; the cells carry no live value into the
    // body. The inliner drops them at splice time. A live LoadLocal
    // (its result feeds a downstream operand) would lose data after
    // the drop, so this loop builds a use mask first and rejects the
    // function if any allowed-but-dropped inst is actually live.
    let n = func.insts.len();
    let mut used = vec![false; n];
    let mark = |v: ValueId, used: &mut [bool]| {
        if v != NO_VALUE && (v as usize) < used.len() {
            used[v as usize] = true;
        }
    };
    for inst in &func.insts {
        match inst {
            Inst::Load { addr, .. } => mark(*addr, &mut used),
            Inst::Store { addr, value, .. } => {
                mark(*addr, &mut used);
                mark(*value, &mut used);
            }
            Inst::StoreLocal { value, .. } => mark(*value, &mut used),
            Inst::LoadIndexed { base, index, .. } => {
                mark(*base, &mut used);
                mark(*index, &mut used);
            }
            Inst::StoreIndexed {
                base, index, value, ..
            } => {
                mark(*base, &mut used);
                mark(*index, &mut used);
                mark(*value, &mut used);
            }
            Inst::Binop { lhs, rhs, .. } => {
                mark(*lhs, &mut used);
                mark(*rhs, &mut used);
            }
            Inst::BinopI { lhs, .. } => mark(*lhs, &mut used),
            Inst::Fneg(v) => mark(*v, &mut used),
            Inst::Fma { a, b, c, .. } => {
                mark(*a, &mut used);
                mark(*b, &mut used);
                mark(*c, &mut used);
            }
            Inst::Extend { value, .. } => mark(*value, &mut used),
            Inst::FpCast { value, .. } => mark(*value, &mut used),
            Inst::Mcpy { dst, src, .. } => {
                mark(*dst, &mut used);
                mark(*src, &mut used);
            }
            Inst::Call { args, .. } | Inst::CallExt { args, .. } | Inst::Intrinsic { args, .. } => {
                for &a in args {
                    mark(a, &mut used);
                }
            }
            Inst::CallIndirect { target, args, .. } => {
                mark(*target, &mut used);
                for &a in args {
                    mark(a, &mut used);
                }
            }
            _ => {}
        }
    }
    // Each block contributes its terminator's value operand to the
    // use mask: the Return's payload, a Bz / Bnz cond, and any
    // block's exit_acc all live to the end of the block.
    for blk in &func.blocks {
        match blk.terminator {
            Terminator::Return(v) => mark(v, &mut used),
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => mark(cond, &mut used),
            _ => {}
        }
        if blk.exit_acc != NO_VALUE {
            mark(blk.exit_acc, &mut used);
        }
    }
    // Phi-incoming values are uses too; the splice has to translate
    // each, but it must not drop a value the body relies on.
    for inst in &func.insts {
        if let Inst::Phi { incoming, .. } = inst {
            for &(_, v) in incoming {
                mark(v, &mut used);
            }
        }
    }
    // Frame slots holding a register-passed struct parameter's bytes. A
    // body `LocalAddr` of one of these redirects to the caller's
    // argument address at the splice; any other `LocalAddr` names a
    // caller frame slot that does not exist after inlining.
    let param_agg_slots: BTreeSet<i64> = func
        .param_aggs
        .iter()
        .enumerate()
        .filter(|(_, a)| a.is_some())
        .filter_map(|(i, _)| func.param_local_slots.get(i).copied())
        .filter(|&s| s != 0)
        .collect();
    // For an aggregate return, the result lives in the slot named by the
    // single `Return(LocalAddr(result_slot))`; the splice redirects that
    // slot to the caller's return slot. Reject shapes the redirect cannot
    // handle: a non-LocalAddr return (a global address or an
    // indirect-result pointer), and a result slot that is also a
    // parameter slot (the two redirects would collide and the return slot
    // would be left unwritten).
    let result_slot: Option<i64> = if func.ret_agg.is_some() {
        let Terminator::Return(rv) = func.blocks[0].terminator else {
            say("aggregate return without a Return terminator");
            return false;
        };
        match func.insts.get(rv as usize) {
            Some(Inst::LocalAddr(s)) if !param_agg_slots.contains(s) => Some(*s),
            Some(Inst::LocalAddr(_)) => {
                say("aggregate return slot is a parameter slot");
                return false;
            }
            _ => {
                say("aggregate return not via a local slot");
                return false;
            }
        }
    } else {
        None
    };
    // Every write into the result slot must stay within its bounds: the
    // splice reproduces each result-slot store against the caller's return
    // slot, so a store past the slot would corrupt the caller's frame.
    // Bytes the body leaves unwritten (a union's inactive members, struct
    // padding) take unspecified values (C99 6.2.6.1p6-7); the non-inlined
    // return register leaves them unspecified too, so they need not match
    // and full coverage is not required.
    if let Some(rs) = result_slot {
        let agg_size = func.agg_descs[func.ret_agg.unwrap() as usize].size as i64;
        for inst in &func.insts {
            let interval = match inst {
                Inst::Store {
                    addr, disp, kind, ..
                } => slot_base_offset(func, *addr, rs).map(|base| {
                    (
                        base + *disp as i64,
                        base + *disp as i64 + store_width(*kind),
                    )
                }),
                Inst::Mcpy { dst, size, .. } => {
                    slot_base_offset(func, *dst, rs).map(|base| (base, base + *size))
                }
                _ => None,
            };
            if let Some((lo, hi)) = interval
                && (lo < 0 || hi > agg_size)
            {
                say("aggregate return slot write out of bounds");
                return false;
            }
        }
    }
    for (idx, inst) in func.insts.iter().enumerate() {
        match inst {
            Inst::Imm(_)
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::ImmExtCode(_)
            | Inst::ParamRef { .. }
            | Inst::AllocaInit(_)
            | Inst::Binop { .. }
            | Inst::BinopI { .. }
            | Inst::Extend { .. }
            | Inst::Fneg(_)
            | Inst::Fma { .. }
            | Inst::FpCast { .. }
            | Inst::Load { .. }
            | Inst::LoadIndexed { .. } => {}
            Inst::LocalAddr(s) => {
                // A register-passed struct parameter's slot redirects to
                // the caller's argument address; the aggregate-return
                // result slot redirects to the caller's return slot. Any
                // other `LocalAddr` has no caller equivalent.
                if !param_agg_slots.contains(s) && Some(*s) != result_slot {
                    say(&alloc::format!("LocalAddr of non-parameter slot {s}"));
                    return false;
                }
            }
            Inst::Store { addr, .. } => {
                // A write is admitted only into the aggregate-return
                // result slot (it redirects to the caller's return slot).
                // A write elsewhere -- through a parameter address, an
                // escaped pointer, or arbitrary memory -- has no caller
                // equivalent and is rejected.
                if result_slot.is_none() || !addr_is_slot(func, *addr, result_slot.unwrap()) {
                    say("store outside the aggregate return slot");
                    return false;
                }
            }
            Inst::Mcpy { dst, src, .. } => {
                // Only the compound-literal template init (an `ImmData`
                // template copied into the result slot) is admitted.
                let to_result =
                    result_slot.is_some() && addr_is_slot(func, *dst, result_slot.unwrap());
                let from_template = matches!(func.insts.get(*src as usize), Some(Inst::ImmData(_)));
                if !to_result || !from_template {
                    say("mcpy outside the aggregate return slot or non-template source");
                    return false;
                }
            }
            Inst::LoadLocal { .. } => {
                // The splice drops every LoadLocal because the
                // caller's frame has no matching slot. That is only
                // safe when the load's result is dead inside the
                // callee body -- a live read would lose data.
                if used[idx] {
                    say(&alloc::format!("live LoadLocal at v{}", idx));
                    return false;
                }
            }
            Inst::StoreLocal { off, .. } => {
                // StoreLocal has no result; the splice drops it. A drop
                // is unobservable only when no surviving read sees the
                // slot. A struct-parameter slot is now read by address
                // (the redirected LocalAddr), so a dropped write into it
                // would leave that read stale -- reject.
                if param_agg_slots.contains(off) {
                    say("StoreLocal into a struct-parameter slot");
                    return false;
                }
            }
            _ => {
                say(&alloc::format!("disallowed inst {:?}", inst));
                return false;
            }
        }
    }
    true
}

/// Map a single operand `v` through `remap`. `NO_VALUE` stays.
#[inline]
fn map_v(v: ValueId, remap: &[ValueId]) -> ValueId {
    if v == NO_VALUE || (v as usize) >= remap.len() {
        v
    } else {
        remap[v as usize]
    }
}

/// Apply the caller's value remap to every operand in `inst`. The
/// caller hands us a fresh clone; we mutate in place.
fn remap_caller_inst(inst: &mut Inst, remap: &[ValueId]) {
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
        Inst::Load { addr, .. } => *addr = map_v(*addr, remap),
        Inst::Store { addr, value, .. } => {
            *addr = map_v(*addr, remap);
            *value = map_v(*value, remap);
        }
        Inst::StoreLocal { value, .. } => *value = map_v(*value, remap),
        Inst::LoadIndexed { base, index, .. } => {
            *base = map_v(*base, remap);
            *index = map_v(*index, remap);
        }
        Inst::StoreIndexed {
            base, index, value, ..
        } => {
            *base = map_v(*base, remap);
            *index = map_v(*index, remap);
            *value = map_v(*value, remap);
        }
        Inst::Binop { lhs, rhs, .. } => {
            *lhs = map_v(*lhs, remap);
            *rhs = map_v(*rhs, remap);
        }
        Inst::BinopI { lhs, .. } => *lhs = map_v(*lhs, remap),
        Inst::Fneg(v) => *v = map_v(*v, remap),
        Inst::Fma { a, b, c, .. } => {
            *a = map_v(*a, remap);
            *b = map_v(*b, remap);
            *c = map_v(*c, remap);
        }
        Inst::Extend { value, .. } => *value = map_v(*value, remap),
        Inst::FpCast { value, .. } => *value = map_v(*value, remap),
        Inst::Call { args, .. } | Inst::CallExt { args, .. } | Inst::Intrinsic { args, .. } => {
            for a in args.iter_mut() {
                *a = map_v(*a, remap);
            }
        }
        Inst::CallIndirect { target, args, .. } => {
            *target = map_v(*target, remap);
            for a in args.iter_mut() {
                *a = map_v(*a, remap);
            }
        }
        Inst::Mcpy { dst, src, .. } => {
            *dst = map_v(*dst, remap);
            *src = map_v(*src, remap);
        }
        Inst::AtomicRmw { addr, value, .. } => {
            *addr = map_v(*addr, remap);
            *value = map_v(*value, remap);
        }
        Inst::AtomicCas {
            addr,
            expected_addr,
            desired,
            ..
        } => {
            *addr = map_v(*addr, remap);
            *expected_addr = map_v(*expected_addr, remap);
            *desired = map_v(*desired, remap);
        }
        Inst::Phi { incoming, .. } => {
            for (_, v) in incoming.iter_mut() {
                *v = map_v(*v, remap);
            }
        }
    }
}

/// Translate a callee inst into the caller's value space. `ParamRef`
/// resolves to the matching call-site argument; every other operand
/// runs through `callee_remap`. `args` is already in the caller's
/// remapped space.
fn rewrite_callee_inst(inst: &Inst, args: &[ValueId], callee_remap: &[ValueId]) -> Option<Inst> {
    match inst {
        Inst::ParamRef { idx, .. } => {
            let i = *idx as usize;
            if i < args.len() {
                // Wrap the substituted arg in a benign no-op that the
                // caller's later inst-walk will reference. The args
                // already live in the caller's value space, so we
                // simply mark the slot to be redirected via the
                // callee_remap built by `inline_caller`.
                None
            } else {
                // Out-of-range ParamRef -- leave inst untouched so the
                // candidate filter's invariants surface as a bug
                // rather than silent corruption.
                Some(inst.clone())
            }
        }
        _ => {
            let mut copy = inst.clone();
            // Phi never reaches here (filtered out) so the &mut visit
            // walks only operand fields whose target lives in the
            // callee body and routes through `callee_remap`.
            match &mut copy {
                Inst::Load { addr, .. } => *addr = map_v(*addr, callee_remap),
                Inst::Store { addr, value, .. } => {
                    *addr = map_v(*addr, callee_remap);
                    *value = map_v(*value, callee_remap);
                }
                Inst::StoreLocal { value, .. } => *value = map_v(*value, callee_remap),
                Inst::LoadIndexed { base, index, .. } => {
                    *base = map_v(*base, callee_remap);
                    *index = map_v(*index, callee_remap);
                }
                Inst::StoreIndexed {
                    base, index, value, ..
                } => {
                    *base = map_v(*base, callee_remap);
                    *index = map_v(*index, callee_remap);
                    *value = map_v(*value, callee_remap);
                }
                Inst::Binop { lhs, rhs, .. } => {
                    *lhs = map_v(*lhs, callee_remap);
                    *rhs = map_v(*rhs, callee_remap);
                }
                Inst::BinopI { lhs, .. } => *lhs = map_v(*lhs, callee_remap),
                Inst::Fneg(v) => *v = map_v(*v, callee_remap),
                Inst::Fma { a, b, c, .. } => {
                    *a = map_v(*a, callee_remap);
                    *b = map_v(*b, callee_remap);
                    *c = map_v(*c, callee_remap);
                }
                Inst::Extend { value, .. } => *value = map_v(*value, callee_remap),
                Inst::FpCast { value, .. } => *value = map_v(*value, callee_remap),
                Inst::Mcpy { dst, src, .. } => {
                    *dst = map_v(*dst, callee_remap);
                    *src = map_v(*src, callee_remap);
                }
                _ => {}
            }
            Some(copy)
        }
    }
}

/// Rewrite block terminators through the caller's value remap.
fn remap_terminator(term: &mut Terminator, remap: &[ValueId]) {
    match term {
        Terminator::Jmp(_) | Terminator::FallThrough(_) | Terminator::TailExt(_) => {}
        Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
            *cond = map_v(*cond, remap);
        }
        Terminator::GotoIndirect { target } => {
            *target = map_v(*target, remap);
        }
        Terminator::Return(v) => {
            *v = map_v(*v, remap);
        }
    }
}

/// Splice a single multi-block callee into `caller` at the call site
/// named by `(splice_block_idx, call_pc)`. The caller's block layout
/// after the splice:
///
/// * caller blocks `0..splice_block_idx`: unchanged.
/// * caller block `splice_block_idx`: rebuilt as the prefix --
///   carries the original block's leading insts up to but not
///   including the call; terminator becomes `Jmp(callee_entry)`.
/// * a synthetic postfix block at `splice_block_idx + 1`: carries
///   the original block's trailing insts plus the original
///   terminator (with `FallThrough` lowered to `Jmp` since the
///   layout no longer guarantees fall-through).
/// * caller blocks `splice_block_idx + 1..` (original indices)
///   shift up by 1.
/// * callee blocks appended at the end, terminator block-ids offset
///   by the new caller block count. The callee's `Return(v)`
///   becomes `Jmp(postfix)`; `v` (in the post-remap caller space)
///   feeds the call's old `ValueId` for every later use.
fn splice_multi_block(
    caller: &mut FunctionSsa,
    callee: &FunctionSsa,
    splice_block_idx: usize,
    call_pc: u32,
    call_args: &[ValueId],
) {
    let n_caller = caller.blocks.len();
    let n_callee = callee.blocks.len();
    let prefix_id = splice_block_idx as u32;
    let postfix_id = (splice_block_idx + 1) as u32;
    // Caller-block-id remap: blocks > splice shift by +1 to make room
    // for the postfix.
    let shift_caller_bid = |b: u32| -> u32 {
        if b > splice_block_idx as u32 {
            b + 1
        } else {
            b
        }
    };
    let callee_block_base = (n_caller + 1) as u32;
    let shift_callee_bid = |b: u32| -> u32 { b + callee_block_base };
    let map_terminator_caller = |term: Terminator, remap: &[ValueId]| -> Terminator {
        match term {
            Terminator::Jmp(b) => Terminator::Jmp(shift_caller_bid(b)),
            Terminator::FallThrough(b) => Terminator::FallThrough(shift_caller_bid(b)),
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => Terminator::Bz {
                cond: map_v(cond, remap),
                target: shift_caller_bid(target),
                fall_through: shift_caller_bid(fall_through),
            },
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => Terminator::Bnz {
                cond: map_v(cond, remap),
                target: shift_caller_bid(target),
                fall_through: shift_caller_bid(fall_through),
            },
            Terminator::Return(v) => Terminator::Return(map_v(v, remap)),
            Terminator::TailExt(x) => Terminator::TailExt(x),
            Terminator::GotoIndirect { target } => Terminator::GotoIndirect {
                target: map_v(target, remap),
            },
        }
    };

    let original = core::mem::take(caller);
    let splice_block = original.blocks[splice_block_idx].clone();

    let mut new_insts: Vec<Inst> = Vec::with_capacity(original.insts.len() + callee.insts.len());
    let mut new_inst_src: Vec<(u32, u32)> = Vec::with_capacity(new_insts.capacity());
    let mut new_f32: Vec<bool> = Vec::with_capacity(new_insts.capacity());
    let mut new_blocks: Vec<Block> = Vec::with_capacity(n_caller + n_callee + 1);
    let mut remap: Vec<ValueId> = vec![NO_VALUE; original.insts.len()];
    let mut callee_remap: Vec<ValueId> = vec![NO_VALUE; callee.insts.len()];

    let emit_caller_inst = |pc: u32,
                            new_insts: &mut Vec<Inst>,
                            new_inst_src: &mut Vec<(u32, u32)>,
                            new_f32: &mut Vec<bool>,
                            remap: &mut [ValueId],
                            original: &FunctionSsa| {
        let src = original
            .inst_src
            .get(pc as usize)
            .copied()
            .unwrap_or((0, 0));
        let f32 = original
            .f32_values
            .get(pc as usize)
            .copied()
            .unwrap_or(false);
        let mut mapped = original.insts[pc as usize].clone();
        remap_caller_inst(&mut mapped, remap);
        let new_id = new_insts.len() as u32;
        remap[pc as usize] = new_id;
        new_insts.push(mapped);
        new_inst_src.push(src);
        new_f32.push(f32);
    };

    // Neither block array is ordered definitions-before-uses, and the
    // call result's mapping only materializes when the callee's Return
    // is spliced (Step 6) -- after Step 4 already emitted the caller
    // blocks that follow the splice point. Run the emission to a fixed
    // point, as the flat single-block splice does: emission is
    // structurally identical across passes, so every inst keeps its new
    // id and the maps converge one forward-reference level per pass.
    let mut guard = original.insts.len() + callee.insts.len() + 2;
    loop {
        new_insts.clear();
        new_inst_src.clear();
        new_f32.clear();
        new_blocks.clear();
        let remap_before = remap.clone();
        let callee_remap_before = callee_remap.clone();

        // Step 1: caller blocks 0..splice_block_idx (unchanged).
        for (b_idx, block) in original.blocks.iter().enumerate().take(splice_block_idx) {
            let block_start = new_insts.len() as u32;
            for pc in block.inst_range.start..block.inst_range.end {
                emit_caller_inst(
                    pc,
                    &mut new_insts,
                    &mut new_inst_src,
                    &mut new_f32,
                    &mut remap,
                    &original,
                );
            }
            let term = map_terminator_caller(block.terminator, &remap);
            let exit_acc = map_v(block.exit_acc, &remap);
            new_blocks.push(Block {
                start_pc: block.start_pc,
                inst_range: block_start..new_insts.len() as u32,
                terminator: term,
                exit_acc,
            });
            let _ = b_idx;
        }

        // Step 2: prefix (caller's splice block, insts up to call).
        let prefix_start = new_insts.len() as u32;
        for pc in splice_block.inst_range.start..call_pc {
            emit_caller_inst(
                pc,
                &mut new_insts,
                &mut new_inst_src,
                &mut new_f32,
                &mut remap,
                &original,
            );
        }
        let callee_entry_new_id = callee_block_base;
        new_blocks.push(Block {
            start_pc: splice_block.start_pc,
            inst_range: prefix_start..new_insts.len() as u32,
            terminator: Terminator::Jmp(callee_entry_new_id),
            exit_acc: NO_VALUE,
        });
        let _ = prefix_id;

        // Step 3: postfix block placeholder (filled after callee splices).
        // We need its ID stable now so the callee's Return -> Jmp(postfix)
        // points to it; emit insts + terminator below after the callee.
        let postfix_block_slot = new_blocks.len();
        new_blocks.push(Block {
            start_pc: 0,
            inst_range: 0..0,
            terminator: Terminator::Jmp(0),
            exit_acc: NO_VALUE,
        });
        let _ = postfix_id;

        // Step 4: caller blocks splice_block_idx+1..n_caller (shifted +1).
        for (b_idx, block) in original
            .blocks
            .iter()
            .enumerate()
            .skip(splice_block_idx + 1)
        {
            let block_start = new_insts.len() as u32;
            for pc in block.inst_range.start..block.inst_range.end {
                emit_caller_inst(
                    pc,
                    &mut new_insts,
                    &mut new_inst_src,
                    &mut new_f32,
                    &mut remap,
                    &original,
                );
            }
            let term = map_terminator_caller(block.terminator, &remap);
            let exit_acc = map_v(block.exit_acc, &remap);
            new_blocks.push(Block {
                start_pc: block.start_pc,
                inst_range: block_start..new_insts.len() as u32,
                terminator: term,
                exit_acc,
            });
            let _ = b_idx;
        }

        // Step 5: remap the call's args through the caller's now-built remap.
        let remapped_args: Vec<ValueId> = call_args.iter().map(|&a| map_v(a, &remap)).collect();

        // Step 6: splice every callee block.
        for cblock in &callee.blocks {
            let block_start = new_insts.len() as u32;
            for ce_pc in cblock.inst_range.start..cblock.inst_range.end {
                let cinst = &callee.insts[ce_pc as usize];
                match cinst {
                    Inst::ParamRef { idx, kind } => {
                        let i = *idx as usize;
                        let arg = if i < remapped_args.len() {
                            remapped_args[i]
                        } else {
                            NO_VALUE
                        };
                        callee_remap[ce_pc as usize] = splice_param_ref(
                            *kind,
                            arg,
                            (0, 0),
                            &mut new_insts,
                            &mut new_inst_src,
                            &mut new_f32,
                        );
                        continue;
                    }
                    Inst::LoadLocal { .. } | Inst::StoreLocal { .. } | Inst::AllocaInit(_) => {
                        callee_remap[ce_pc as usize] = NO_VALUE;
                        continue;
                    }
                    _ => {}
                }
                if let Some(translated) = rewrite_callee_inst(cinst, &remapped_args, &callee_remap)
                {
                    let new_id = new_insts.len() as u32;
                    callee_remap[ce_pc as usize] = new_id;
                    new_insts.push(translated);
                    new_inst_src.push((0, 0));
                    new_f32.push(
                        callee
                            .f32_values
                            .get(ce_pc as usize)
                            .copied()
                            .unwrap_or(false),
                    );
                }
            }
            let new_term = match cblock.terminator {
                Terminator::Jmp(b) => Terminator::Jmp(shift_callee_bid(b)),
                Terminator::FallThrough(b) => Terminator::Jmp(shift_callee_bid(b)),
                Terminator::Bz {
                    cond,
                    target,
                    fall_through,
                } => Terminator::Bz {
                    cond: map_v(cond, &callee_remap),
                    target: shift_callee_bid(target),
                    fall_through: shift_callee_bid(fall_through),
                },
                Terminator::Bnz {
                    cond,
                    target,
                    fall_through,
                } => Terminator::Bnz {
                    cond: map_v(cond, &callee_remap),
                    target: shift_callee_bid(target),
                    fall_through: shift_callee_bid(fall_through),
                },
                Terminator::Return(v) => {
                    remap[call_pc as usize] = map_v(v, &callee_remap);
                    Terminator::Jmp(postfix_id)
                }
                Terminator::TailExt(_) => unreachable!("filter rejects TailExt"),
                Terminator::GotoIndirect { .. } => {
                    unreachable!("filter rejects GotoIndirect")
                }
            };
            let exit_acc = if cblock.exit_acc != NO_VALUE {
                map_v(cblock.exit_acc, &callee_remap)
            } else {
                NO_VALUE
            };
            new_blocks.push(Block {
                start_pc: 0,
                inst_range: block_start..new_insts.len() as u32,
                terminator: new_term,
                exit_acc,
            });
        }

        // Step 7: fill the postfix slot now that the call's remap is set.
        let postfix_start = new_insts.len() as u32;
        for pc in (call_pc + 1)..splice_block.inst_range.end {
            emit_caller_inst(
                pc,
                &mut new_insts,
                &mut new_inst_src,
                &mut new_f32,
                &mut remap,
                &original,
            );
        }
        let postfix_term = match splice_block.terminator {
            Terminator::FallThrough(b) => Terminator::Jmp(shift_caller_bid(b)),
            other => map_terminator_caller(other, &remap),
        };
        let postfix_exit_acc = map_v(splice_block.exit_acc, &remap);
        new_blocks[postfix_block_slot] = Block {
            start_pc: 0,
            inst_range: postfix_start..new_insts.len() as u32,
            terminator: postfix_term,
            exit_acc: postfix_exit_acc,
        };

        if remap == remap_before && callee_remap == callee_remap_before {
            break;
        }
        guard -= 1;
        if guard == 0 {
            break;
        }
    }

    // Carry both the caller's own and the spliced callee's cross-TU
    // symbol references onto their new value-ids. The symbol indices
    // are translation-unit parser symbols, valid in the merged
    // function because the callee is in the same unit.
    let carry = |refs: &[(u32, u32)], m: &[ValueId], out: &mut Vec<(u32, u32)>| {
        for &(vid, sym) in refs {
            let nv = map_v(vid, m);
            if nv != NO_VALUE {
                out.push((nv, sym));
            }
        }
    };
    let mut call_refs = Vec::new();
    carry(&original.extern_call_refs, &remap, &mut call_refs);
    carry(&callee.extern_call_refs, &callee_remap, &mut call_refs);
    let mut code_refs = Vec::new();
    carry(&original.extern_imm_code_refs, &remap, &mut code_refs);
    carry(&callee.extern_imm_code_refs, &callee_remap, &mut code_refs);
    let mut data_refs = Vec::new();
    carry(&original.extern_imm_data_refs, &remap, &mut data_refs);
    carry(&callee.extern_imm_data_refs, &callee_remap, &mut data_refs);
    let mut tls_refs = Vec::new();
    carry(&original.extern_tls_refs, &remap, &mut tls_refs);
    carry(&callee.extern_tls_refs, &callee_remap, &mut tls_refs);

    *caller = FunctionSsa {
        name: original.name,
        ent_pc: original.ent_pc,
        end_pc: original.end_pc,
        locals: original.locals,
        n_params: original.n_params,
        is_variadic: original.is_variadic,
        is_inline: original.is_inline,
        insts: new_insts,
        inst_src: new_inst_src,
        blocks: new_blocks,
        extern_call_refs: call_refs,
        extern_imm_code_refs: code_refs,
        extern_imm_data_refs: data_refs,
        extern_tls_refs: tls_refs,
        f32_values: new_f32,
        param_fp_mask: original.param_fp_mask,
        // The caller's own `agg_descs` carry through unchanged. A
        // spliced callee may carry agg_descs, but only the
        // single-integer-register parameter shape (see the eligibility
        // guard): its sole agg-referencing inst is the parameter-slot
        // `LocalAddr`, which the splice redirects to the caller argument
        // and never re-emits, so no spliced instruction references a
        // callee-side index. Do not merge the callee's agg_descs.
        agg_descs: original.agg_descs,
        param_aggs: original.param_aggs,

        param_local_slots: original.param_local_slots,
        ret_agg: original.ret_agg,
        ret_is_fp: original.ret_is_fp,
        indirect_result_slot: original.indirect_result_slot,
        computed_goto_targets: original.computed_goto_targets,
        synthetic_base: original.synthetic_base,
        multi_cell_slots: original.multi_cell_slots,
        // The candidate filter rejects returns-twice callees, so only
        // the caller's own flag can be set here.
        has_returns_twice_call: original.has_returns_twice_call,
    };
}

/// Resolve a callee `ParamRef(idx, kind)` to a caller value, mirroring
/// the parameter load a non-inlined call performs at entry. That load
/// sign-extends a signed narrow parameter (`movsx` / `sxtw`); every
/// other kind is a plain register copy -- the unsigned base types and
/// `long` / pointer parameters arrive full-width (the walker emits a
/// `ParamRef(I64)` and the body re-narrows unsigned uses with a mask the
/// splice preserves), and FP arguments are converted at the call site.
/// So sign-extend the signed narrow kinds and pass everything else
/// through unchanged. `arg` may be `NO_VALUE` on an early flat-splice
/// fixpoint pass and resolves on a later one, so the `Extend` is emitted
/// unconditionally to keep emission structurally identical across passes.
fn splice_param_ref(
    kind: LoadKind,
    arg: ValueId,
    src_pos: (u32, u32),
    new_insts: &mut Vec<Inst>,
    new_inst_src: &mut Vec<(u32, u32)>,
    new_f32: &mut Vec<bool>,
) -> ValueId {
    match kind {
        LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => {
            let id = new_insts.len() as u32;
            new_insts.push(Inst::Extend { value: arg, kind });
            new_inst_src.push(src_pos);
            new_f32.push(false);
            id
        }
        LoadKind::I64
        | LoadKind::U8
        | LoadKind::U16
        | LoadKind::U32
        | LoadKind::F32
        | LoadKind::F64 => arg,
    }
}

/// Splice eligible call sites in `caller` with the bodies named by
/// `callees`. Modifies `caller` in place.
fn inline_caller(caller: &mut FunctionSsa, callees: &BTreeMap<usize, &FunctionSsa>) {
    let mut new_insts: Vec<Inst> = Vec::with_capacity(caller.insts.len());
    let mut new_inst_src: Vec<(u32, u32)> = Vec::with_capacity(caller.inst_src.len());
    let mut new_f32: Vec<bool> = Vec::with_capacity(caller.insts.len());
    // `remap[old_id]` is the new ValueId in the spliced caller. An
    // inlined Call's slot maps to the callee's translated Return value.
    let mut remap: Vec<ValueId> = vec![NO_VALUE; caller.insts.len()];
    let mut new_block_starts: Vec<u32> = Vec::with_capacity(caller.blocks.len());
    // `inst_idx` rewrites recorded per-section so the extern-ref
    // tables (`extern_call_refs` etc.) can be retargeted at the end.
    let mut extern_call_remap: Vec<(u32, u32, u32)> = Vec::new(); // (old_idx, new_idx, sym)
    let mut extern_imm_code_remap: Vec<(u32, u32, u32)> = Vec::new();
    let mut extern_imm_data_remap: Vec<(u32, u32, u32)> = Vec::new();
    let mut extern_tls_remap: Vec<(u32, u32, u32)> = Vec::new();
    let mut any_change = false;

    // The block array is not ordered definitions-before-uses: a value
    // can be defined in a block positioned after one that uses it, so
    // resolving an operand needs `remap` populated for that definition.
    // The walk runs to a fixed point -- each pass reads the prior pass's
    // `remap` and recomputes it. Emission is structurally identical
    // across passes, so every old inst keeps the same new id and the map
    // converges (one forward-reference level per pass).
    let mut guard = caller.insts.len() + 2;
    // Cross-TU symbol references carried from spliced callee insts onto
    // their new caller value-ids. The symbol index is a translation-unit
    // parser symbol, valid in the caller because the callee is in the
    // same unit. Rebuilt every pass; the final pass's entries are kept.
    let mut spliced_data_refs: Vec<(u32, u32)> = Vec::new();
    let mut spliced_code_refs: Vec<(u32, u32)> = Vec::new();
    let mut spliced_tls_refs: Vec<(u32, u32)> = Vec::new();
    loop {
        new_insts.clear();
        new_inst_src.clear();
        new_f32.clear();
        new_block_starts.clear();
        spliced_data_refs.clear();
        spliced_code_refs.clear();
        spliced_tls_refs.clear();
        let before = remap.clone();
        for block in &caller.blocks {
            new_block_starts.push(new_insts.len() as u32);
            for old_pc in block.inst_range.start..block.inst_range.end {
                let src_pos = caller
                    .inst_src
                    .get(old_pc as usize)
                    .copied()
                    .unwrap_or((0, 0));
                let inst = &caller.insts[old_pc as usize];
                let inlined = match inst {
                    Inst::Call {
                        target_pc,
                        args,
                        ret_slot_local,
                        ..
                    } => callees
                        .get(target_pc)
                        // A call passing fewer arguments than the callee has
                        // parameters (an argument-count mismatch, e.g. via a
                        // macro) would leave a callee `ParamRef` with no
                        // matching argument; inlining it resolves that ref to
                        // NO_VALUE. Leave such a call un-inlined so the IR
                        // stays well-formed.
                        .filter(|c| args.len() >= c.n_params)
                        .map(|c| (*c, args, *ret_slot_local)),
                    _ => None,
                };
                // Multi-block callees: handled by `splice_multi_block`
                // after this block-walk pass exits via the early-return
                // below. Skip the single-block inline path here and let
                // the call survive the local walk; the multi-block
                // pass runs once over the whole function.
                let inlined = inlined.filter(|(c, ..)| c.blocks.len() == 1);
                if let Some((callee, call_args, ret_slot)) = inlined {
                    any_change = true;
                    let remapped_args: Vec<ValueId> =
                        call_args.iter().map(|&a| map_v(a, &remap)).collect();
                    let callee_block = &callee.blocks[0];
                    let mut callee_remap: Vec<ValueId> = vec![NO_VALUE; callee.insts.len()];
                    // The result slot of an aggregate-return callee (the
                    // slot named by its `Return(LocalAddr(..))`) redirects
                    // to the caller's return slot `ret_slot`.
                    let callee_result_slot: Option<i64> = if callee.ret_agg.is_some() {
                        match callee_block.terminator {
                            Terminator::Return(rv) => match callee.insts.get(rv as usize) {
                                Some(Inst::LocalAddr(s)) => Some(*s),
                                _ => None,
                            },
                            _ => None,
                        }
                    } else {
                        None
                    };
                    // A register-passed struct parameter is read in the
                    // body through `LocalAddr(slot)`; map each such slot to
                    // its parameter index so the splice redirects it to the
                    // caller's argument address (the candidate filter
                    // admitted only this shape).
                    let param_slot_arg: BTreeMap<i64, usize> = callee
                        .param_aggs
                        .iter()
                        .enumerate()
                        .filter(|(_, a)| a.is_some())
                        .filter_map(|(i, _)| callee.param_local_slots.get(i).map(|&s| (s, i)))
                        .filter(|&(s, _)| s != 0)
                        .collect();
                    for ce_pc in callee_block.inst_range.start..callee_block.inst_range.end {
                        let cinst = &callee.insts[ce_pc as usize];
                        match cinst {
                            Inst::LocalAddr(s) => {
                                if let Some(&i) = param_slot_arg.get(s) {
                                    callee_remap[ce_pc as usize] =
                                        remapped_args.get(i).copied().unwrap_or(NO_VALUE);
                                    continue;
                                }
                                if Some(*s) == callee_result_slot {
                                    // Emit a fresh caller LocalAddr of the
                                    // return slot; the callee's result
                                    // writes land where the caller reads
                                    // the aggregate return.
                                    let new_id = new_insts.len() as u32;
                                    new_insts.push(Inst::LocalAddr(ret_slot));
                                    new_inst_src.push(src_pos);
                                    new_f32.push(false);
                                    callee_remap[ce_pc as usize] = new_id;
                                    continue;
                                }
                            }
                            Inst::ParamRef { idx, kind } => {
                                let i = *idx as usize;
                                let arg = if i < remapped_args.len() {
                                    remapped_args[i]
                                } else {
                                    NO_VALUE
                                };
                                callee_remap[ce_pc as usize] = splice_param_ref(
                                    *kind,
                                    arg,
                                    src_pos,
                                    &mut new_insts,
                                    &mut new_inst_src,
                                    &mut new_f32,
                                );
                                continue;
                            }
                            // Walker-emitted cdecl-cell loads + stores
                            // and the alloca-init no-op marker carry no
                            // value into the caller's frame (the candidate
                            // filter verified loads are dead and stores
                            // address cells off >= 2); the splice drops
                            // them entirely.
                            Inst::LoadLocal { .. }
                            | Inst::StoreLocal { .. }
                            | Inst::AllocaInit(_) => {
                                callee_remap[ce_pc as usize] = NO_VALUE;
                                continue;
                            }
                            _ => {}
                        }
                        if let Some(translated) =
                            rewrite_callee_inst(cinst, &remapped_args, &callee_remap)
                        {
                            let new_id = new_insts.len() as u32;
                            callee_remap[ce_pc as usize] = new_id;
                            new_insts.push(translated);
                            new_inst_src.push(src_pos);
                            new_f32.push(
                                callee
                                    .f32_values
                                    .get(ce_pc as usize)
                                    .copied()
                                    .unwrap_or(false),
                            );
                        }
                    }
                    for &(ce_vid, sym) in &callee.extern_imm_data_refs {
                        let nv = map_v(ce_vid, &callee_remap);
                        if nv != NO_VALUE {
                            spliced_data_refs.push((nv, sym));
                        }
                    }
                    for &(ce_vid, sym) in &callee.extern_imm_code_refs {
                        let nv = map_v(ce_vid, &callee_remap);
                        if nv != NO_VALUE {
                            spliced_code_refs.push((nv, sym));
                        }
                    }
                    for &(ce_vid, sym) in &callee.extern_tls_refs {
                        let nv = map_v(ce_vid, &callee_remap);
                        if nv != NO_VALUE {
                            spliced_tls_refs.push((nv, sym));
                        }
                    }
                    let Terminator::Return(ret_v) = callee_block.terminator else {
                        unreachable!("inline candidate guaranteed Return terminator")
                    };
                    // An aggregate return delivers its value in the
                    // caller's return slot (written by the redirected
                    // result-slot stores), not as the call's ValueId; the
                    // caller consumes it through its own return-slot copy.
                    // A scalar return maps the call's ValueId to the
                    // translated Return value.
                    remap[old_pc as usize] = if callee_result_slot.is_some() {
                        NO_VALUE
                    } else {
                        map_v(ret_v, &callee_remap)
                    };
                } else {
                    let new_id = new_insts.len() as u32;
                    let mut mapped = inst.clone();
                    remap_caller_inst(&mut mapped, &remap);
                    new_insts.push(mapped);
                    new_inst_src.push(src_pos);
                    new_f32.push(
                        caller
                            .f32_values
                            .get(old_pc as usize)
                            .copied()
                            .unwrap_or(false),
                    );
                    remap[old_pc as usize] = new_id;
                }
            }
        }
        // No candidate matched: `remap` is the identity and the caller
        // is left unchanged below.
        if !any_change {
            break;
        }
        // Converged once a full pass leaves `remap` unchanged; the
        // emission just produced is resolved against a stable map.
        if remap == before {
            break;
        }
        guard -= 1;
        if guard == 0 {
            break;
        }
    }

    if !any_change {
        return;
    }

    let mut new_blocks: Vec<Block> = Vec::with_capacity(caller.blocks.len());
    for (block_idx, block) in caller.blocks.iter().enumerate() {
        let start = new_block_starts[block_idx];
        let end = if block_idx + 1 < new_block_starts.len() {
            new_block_starts[block_idx + 1]
        } else {
            new_insts.len() as u32
        };
        let mut term = block.terminator;
        remap_terminator(&mut term, &remap);
        let exit_acc = map_v(block.exit_acc, &remap);
        new_blocks.push(Block {
            start_pc: block.start_pc,
            inst_range: start..end,
            terminator: term,
            exit_acc,
        });
    }

    // Retarget extern-ref tables through the caller's remap. Drop
    // entries whose old inst was an inlined call (remap may now point
    // at a translated callee inst that's not the original Call).
    let retarget = |refs: &Vec<(u32, u32)>, out: &mut Vec<(u32, u32, u32)>| {
        for &(inst_idx, sym) in refs {
            if (inst_idx as usize) < remap.len() {
                let new_idx = remap[inst_idx as usize];
                if new_idx != NO_VALUE
                    && let Some(orig) = caller.insts.get(inst_idx as usize)
                    && let Some(new) = new_insts.get(new_idx as usize)
                    && core::mem::discriminant(orig) == core::mem::discriminant(new)
                {
                    out.push((inst_idx, new_idx, sym));
                }
            }
        }
    };
    retarget(&caller.extern_call_refs, &mut extern_call_remap);
    retarget(&caller.extern_imm_code_refs, &mut extern_imm_code_remap);
    retarget(&caller.extern_imm_data_refs, &mut extern_imm_data_remap);
    retarget(&caller.extern_tls_refs, &mut extern_tls_remap);

    caller.insts = new_insts;
    caller.inst_src = new_inst_src;
    caller.f32_values = new_f32;
    caller.blocks = new_blocks;
    caller.extern_call_refs = extern_call_remap.iter().map(|(_, n, s)| (*n, *s)).collect();
    caller.extern_imm_code_refs = extern_imm_code_remap
        .iter()
        .map(|(_, n, s)| (*n, *s))
        .collect();
    caller.extern_imm_data_refs = extern_imm_data_remap
        .iter()
        .map(|(_, n, s)| (*n, *s))
        .collect();
    caller.extern_tls_refs = extern_tls_remap.iter().map(|(_, n, s)| (*n, *s)).collect();

    // Append the symbol references carried from spliced callee insts.
    caller
        .extern_imm_data_refs
        .extend(spliced_data_refs.iter().copied());
    caller
        .extern_imm_code_refs
        .extend(spliced_code_refs.iter().copied());
    caller
        .extern_tls_refs
        .extend(spliced_tls_refs.iter().copied());

    // Single-block flat splice complete. Now find any remaining
    // multi-block inlinable Call sites and apply the multi-block
    // splice one at a time. Each splice re-shapes the caller's
    // blocks so the loop re-scans from scratch after every step.
    // Bounded by a generous step cap to keep runaway expansion in
    // check.
    // `splice_multi_block` shifts caller block ids > the splice point;
    // a surviving caller phi's incoming.0 would then name the wrong
    // predecessor (a silent miscompile, since emit matches incoming by
    // block id). The same shift invalidates a computed-goto caller's
    // `Inst::BlockAddr` and `computed_goto_targets` block-id references.
    // Skip multi-block splicing for either shape; the flat single-block
    // path above already ran and keeps block ids fixed.
    let block_id_shift_unsafe = !caller.computed_goto_targets.is_empty()
        || caller
            .insts
            .iter()
            .any(|inst| matches!(inst, Inst::Phi { .. }));
    let mut steps = 0usize;
    while steps < MAX_MULTI_BLOCK_SPLICE_STEPS && !block_id_shift_unsafe {
        let mut hit: Option<(usize, u32, &FunctionSsa, Vec<ValueId>)> = None;
        'find: for (b_idx, block) in caller.blocks.iter().enumerate() {
            for pc in block.inst_range.start..block.inst_range.end {
                if let Inst::Call {
                    target_pc, args, ..
                } = &caller.insts[pc as usize]
                    && let Some(c) = callees.get(target_pc)
                    && c.blocks.len() > 1
                    // Same argument-count guard as the single-block path.
                    && args.len() >= c.n_params
                {
                    hit = Some((b_idx, pc, *c, args.clone()));
                    break 'find;
                }
            }
        }
        let Some((b_idx, pc, callee, args)) = hit else {
            break;
        };
        splice_multi_block(caller, callee, b_idx, pc, &args);
        steps += 1;
    }
}

/// Inline eligible callees across every function in `funcs`. A
/// callee is eligible per `is_inline_candidate`; `cap == 0` disables
/// the pass.
pub(crate) fn run(funcs: &mut [FunctionSsa], cap: u32, abi: Abi) {
    #[cfg(feature = "codegen_test")]
    let trace = std::env::var("BADC_LOG_INLINE").is_ok();
    // Env-var override for the `is_inline` attribute pending parser
    // plumbing for the `inline` keyword: a comma-separated list of
    // function names flips `is_inline = true` so the body-size cap
    // is bypassed at candidate evaluation. Read only under the
    // `codegen_test` feature so a production build never consults the
    // environment.
    // TODO: drive `is_inline` from the parsed `inline` specifier and
    // drop this override.
    #[cfg(feature = "codegen_test")]
    if let Ok(names) = std::env::var("BADC_FORCE_INLINE") {
        let want: alloc::collections::BTreeSet<&str> = names
            .split(',')
            .map(str::trim)
            .filter(|s| !s.is_empty())
            .collect();
        for f in funcs.iter_mut() {
            if want.contains(f.name.as_str()) {
                f.is_inline = true;
            }
        }
    }
    let any_marked = funcs.iter().any(|f| f.is_inline);
    if funcs.is_empty() || (cap == 0 && !any_marked) {
        #[cfg(feature = "codegen_test")]
        if trace {
            eprintln!(
                "[inline] short-circuit cap={cap} funcs={n} any_marked={m}",
                n = funcs.len(),
                m = any_marked
            );
        }
        return;
    }
    // Iterate to a fixed point: each pass re-evaluates candidacy on
    // the now-substituted function bodies, so a helper that became a
    // leaf after its own sub-calls were inlined becomes eligible on
    // the next round. `INLINE_FIXPOINT_ITERS` bounds the depth.
    for iter in 0..INLINE_FIXPOINT_ITERS {
        let snapshot: Vec<FunctionSsa> = funcs.to_vec();
        let mut candidates: BTreeMap<usize, &FunctionSsa> = BTreeMap::new();
        for f in &snapshot {
            if is_inline_candidate(f, cap, abi) {
                candidates.insert(f.ent_pc, f);
            }
        }
        #[cfg(feature = "codegen_test")]
        if trace {
            eprintln!(
                "[inline] iter={i} cap={cap} funcs={n} candidates={c}",
                i = iter,
                cap = cap,
                n = funcs.len(),
                c = candidates.len()
            );
            for (pc, f) in &candidates {
                eprintln!(
                    "[inline] candidate ent_pc={pc} name={n} insts={i}",
                    n = f.name,
                    i = f.insts.len()
                );
            }
        }
        if candidates.is_empty() {
            break;
        }
        let mut changed = false;
        for caller in funcs.iter_mut() {
            // Drop self-recursive inlines: a recursive call would
            // expand indefinitely. The candidate set names ent_pc;
            // the caller's ent_pc is the loop guard.
            let mut local = candidates.clone();
            local.remove(&caller.ent_pc);
            if local.is_empty() {
                continue;
            }
            // A caller with phis can inline single-block callees. The
            // flat splice keeps block ids fixed, so a phi's incoming.0
            // (a block id) stays valid, and the value-remap fixpoint
            // converges every phi's incoming value -- including a loop
            // back-edge whose definition follows the phi in array order.
            // A computed-goto caller is handled the same way: the flat
            // splice rebuilds the block array one-to-one, leaving every
            // block id, `Inst::BlockAddr`, and `computed_goto_targets`
            // entry valid. Only multi-block splicing shifts block ids;
            // `inline_caller` gates that path off for such callers.
            let before = caller.insts.len();
            inline_caller(caller, &local);
            if caller.insts.len() != before {
                changed = true;
            }
        }
        if !changed {
            break;
        }
        let _ = iter;
    }
}

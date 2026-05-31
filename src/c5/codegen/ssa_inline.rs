//! Function inlining over the SSA tier.
//!
//! Pre-pass that runs before `ssa_mem2reg` under `-O`. Substitutes
//! eligible `Inst::Call` sites with the callee's body. Eligibility
//! is intentionally narrow:
//!
//! * caller and callee bodies remain in the same translation unit;
//! * callee has a single basic block terminating in `Return`;
//! * callee's body is at most `cap` instructions (the
//!   `--inline-cap=N` knob; default 32);
//! * callee is non-variadic;
//! * callee's body contains no `Call*` / `Phi` / `LocalAddr` /
//!   `AllocaInit` / `Mcpy` / `Store*` / `Intrinsic` / `TailExt` --
//!   only the pure straight-line shapes whose `for_each_operand`
//!   walks a known set of `ValueId` fields.
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

use alloc::collections::BTreeMap;
use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{Block, FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};

/// `inst.is_inline_candidate(cap)`-style predicate. See module docs.
fn is_inline_candidate(func: &FunctionSsa, cap: u32) -> bool {
    #[cfg(feature = "std")]
    let trace = std::env::var("BADC_LOG_INLINE").is_ok();
    #[cfg(feature = "std")]
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
    #[cfg(not(feature = "std"))]
    let say = |_: &str| {};

    if func.is_variadic {
        say("variadic");
        return false;
    }
    if func.blocks.len() != 1 {
        say(&alloc::format!(
            "{n} blocks (need 1)",
            n = func.blocks.len()
        ));
        return false;
    }
    if func.insts.len() > cap as usize {
        say(&alloc::format!(
            "{n} insts > cap {c}",
            n = func.insts.len(),
            c = cap
        ));
        return false;
    }
    let block = &func.blocks[0];
    if !matches!(block.terminator, Terminator::Return(_)) {
        say(&alloc::format!("terminator {:?}", block.terminator));
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
            Inst::LoadIndexed { base, index, .. } => {
                mark(*base, &mut used);
                mark(*index, &mut used);
            }
            Inst::Binop { lhs, rhs, .. } => {
                mark(*lhs, &mut used);
                mark(*rhs, &mut used);
            }
            Inst::BinopI { lhs, .. } => mark(*lhs, &mut used),
            Inst::Fneg(v) => mark(*v, &mut used),
            Inst::Extend { value, .. } => mark(*value, &mut used),
            Inst::FpCast { value, .. } => mark(*value, &mut used),
            _ => {}
        }
    }
    if let Terminator::Return(v) = &block.terminator {
        mark(*v, &mut used);
    }
    for (idx, inst) in func.insts.iter().enumerate() {
        match inst {
            Inst::Imm(_)
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::ParamRef { .. }
            | Inst::AllocaInit(_)
            | Inst::Binop { .. }
            | Inst::BinopI { .. }
            | Inst::Extend { .. }
            | Inst::Fneg(_)
            | Inst::FpCast { .. }
            | Inst::Load { .. }
            | Inst::LoadIndexed { .. } => {}
            Inst::LoadLocal { off, .. } => {
                if used[idx] {
                    say(&alloc::format!("live LoadLocal at v{}", idx));
                    return false;
                }
                // True locals (off < 2) and the BP / return-addr slots
                // would not exist in the caller's frame after splice.
                if *off < 2 {
                    say(&alloc::format!("LoadLocal off={} below cdecl cells", off));
                    return false;
                }
            }
            Inst::StoreLocal { off, .. } => {
                // Walker emits `StoreLocal { off >= 2 }` as the cdecl
                // param-cell save at function entry. The splice drops
                // it because the caller's frame has no matching cell.
                // True-local stores (off < 2) escape the splice.
                if *off < 2 {
                    say(&alloc::format!("StoreLocal off={} below cdecl cells", off));
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
        Inst::Extend { value, .. } => *value = map_v(*value, remap),
        Inst::FpCast { value, .. } => *value = map_v(*value, remap),
        Inst::Call { args, .. } | Inst::CallExt { args, .. } | Inst::Intrinsic { args, .. } => {
            for a in args.iter_mut() {
                *a = map_v(*a, remap);
            }
        }
        Inst::CallIndirect { target, args } => {
            *target = map_v(*target, remap);
            for a in args.iter_mut() {
                *a = map_v(*a, remap);
            }
        }
        Inst::Mcpy { dst, src, .. } => {
            *dst = map_v(*dst, remap);
            *src = map_v(*src, remap);
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
                Inst::Extend { value, .. } => *value = map_v(*value, callee_remap),
                Inst::FpCast { value, .. } => *value = map_v(*value, callee_remap),
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
        Terminator::Return(v) => {
            *v = map_v(*v, remap);
        }
    }
}

/// Splice eligible call sites in `caller` with the bodies named by
/// `callees`. Modifies `caller` in place.
fn inline_caller(caller: &mut FunctionSsa, callees: &BTreeMap<usize, &FunctionSsa>) {
    let mut new_insts: Vec<Inst> = Vec::with_capacity(caller.insts.len());
    let mut new_inst_src: Vec<(u32, u32)> = Vec::with_capacity(caller.inst_src.len());
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
                Inst::Call { target_pc, args } => callees.get(target_pc).map(|c| (*c, args)),
                _ => None,
            };
            if let Some((callee, call_args)) = inlined {
                any_change = true;
                let remapped_args: Vec<ValueId> =
                    call_args.iter().map(|&a| map_v(a, &remap)).collect();
                let callee_block = &callee.blocks[0];
                let mut callee_remap: Vec<ValueId> = vec![NO_VALUE; callee.insts.len()];
                for ce_pc in callee_block.inst_range.start..callee_block.inst_range.end {
                    let cinst = &callee.insts[ce_pc as usize];
                    match cinst {
                        Inst::ParamRef { idx, .. } => {
                            let i = *idx as usize;
                            let mapped = if i < remapped_args.len() {
                                remapped_args[i]
                            } else {
                                NO_VALUE
                            };
                            callee_remap[ce_pc as usize] = mapped;
                            continue;
                        }
                        // Walker-emitted cdecl-cell loads + stores
                        // and the alloca-init no-op marker carry no
                        // value into the caller's frame (the candidate
                        // filter verified loads are dead and stores
                        // address cells off >= 2); the splice drops
                        // them entirely.
                        Inst::LoadLocal { .. } | Inst::StoreLocal { .. } | Inst::AllocaInit(_) => {
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
                    }
                }
                let Terminator::Return(ret_v) = callee_block.terminator else {
                    unreachable!("inline candidate guaranteed Return terminator")
                };
                remap[old_pc as usize] = map_v(ret_v, &callee_remap);
            } else {
                let new_id = new_insts.len() as u32;
                let mut mapped = inst.clone();
                remap_caller_inst(&mut mapped, &remap);
                new_insts.push(mapped);
                new_inst_src.push(src_pos);
                remap[old_pc as usize] = new_id;
            }
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
}

/// Inline eligible callees across every function in `funcs`. A
/// callee is eligible per `is_inline_candidate`; `cap == 0` disables
/// the pass.
pub(super) fn run(funcs: &mut [FunctionSsa], cap: u32) {
    #[cfg(feature = "std")]
    let trace = std::env::var("BADC_LOG_INLINE").is_ok();
    if cap == 0 || funcs.is_empty() {
        #[cfg(feature = "std")]
        if trace {
            eprintln!(
                "[inline] short-circuit cap={cap} funcs={n}",
                n = funcs.len()
            );
        }
        return;
    }
    // Iterate to a fixed point: each pass re-evaluates candidacy on
    // the now-substituted function bodies, so a helper that became a
    // leaf after its own sub-calls were inlined becomes eligible on
    // the next round. The 8-iteration cap bounds runaway expansion
    // (a 3-level call chain reaches the bottom in 3 iterations).
    for iter in 0..8 {
        let snapshot: Vec<FunctionSsa> = funcs.to_vec();
        let mut candidates: BTreeMap<usize, &FunctionSsa> = BTreeMap::new();
        for f in &snapshot {
            if is_inline_candidate(f, cap) {
                candidates.insert(f.ent_pc, f);
            }
        }
        #[cfg(feature = "std")]
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

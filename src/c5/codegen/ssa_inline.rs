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
    // Host-ABI aggregate metadata does not survive a splice: a struct
    // parameter has no entry copy in the IR (the callee prologue
    // scatters its argument registers into a body local, which the
    // splice cannot reproduce), and a host-ABI struct call in the body
    // carries `agg_descs` indices that are valid only against this
    // function's own table. `agg_descs` is non-empty whenever either
    // is present, so reject such callees outright.
    if !func.agg_descs.is_empty() {
        say("host-ABI aggregate metadata");
        return false;
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
            | Inst::Fma { .. }
            | Inst::FpCast { .. }
            | Inst::Load { .. }
            | Inst::LoadIndexed { .. } => {}
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
            Inst::StoreLocal { .. } => {
                // StoreLocal has no result; the splice drops it.
                // The store's slot writes into a frame the caller
                // does not own, but with every LoadLocal also
                // dropped no observation of the missing write
                // survives the splice.
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
                Inst::ParamRef { idx, .. } => {
                    let i = *idx as usize;
                    callee_remap[ce_pc as usize] = if i < remapped_args.len() {
                        remapped_args[i]
                    } else {
                        NO_VALUE
                    };
                    continue;
                }
                Inst::LoadLocal { .. } | Inst::StoreLocal { .. } | Inst::AllocaInit(_) => {
                    callee_remap[ce_pc as usize] = NO_VALUE;
                    continue;
                }
                _ => {}
            }
            if let Some(translated) = rewrite_callee_inst(cinst, &remapped_args, &callee_remap) {
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
        extern_call_refs: Vec::new(),
        extern_imm_code_refs: Vec::new(),
        extern_imm_data_refs: Vec::new(),
        extern_tls_refs: Vec::new(),
        f32_values: new_f32,
        param_fp_mask: original.param_fp_mask,
        // Inlining only splices callees with no aggregate ABI
        // metadata (see the eligibility guard), so the caller's own
        // `agg_descs` carry through unchanged and no spliced
        // instruction references a callee-side index.
        agg_descs: original.agg_descs,
        param_aggs: original.param_aggs,

        param_local_slots: original.param_local_slots,
        ret_agg: original.ret_agg,
        indirect_result_slot: original.indirect_result_slot,
    };
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
                    target_pc, args, ..
                } => callees.get(target_pc).map(|c| (*c, args)),
                _ => None,
            };
            // Multi-block callees: handled by `splice_multi_block`
            // after this block-walk pass exits via the early-return
            // below. Skip the single-block inline path here and let
            // the call survive the local walk; the multi-block
            // pass runs once over the whole function.
            let inlined = inlined.filter(|(c, _)| c.blocks.len() == 1);
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
                        new_f32.push(
                            callee
                                .f32_values
                                .get(ce_pc as usize)
                                .copied()
                                .unwrap_or(false),
                        );
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

    // Single-block flat splice complete. Now find any remaining
    // multi-block inlinable Call sites and apply the multi-block
    // splice one at a time. Each splice re-shapes the caller's
    // blocks so the loop re-scans from scratch after every step.
    // Bounded by a generous step cap to keep runaway expansion in
    // check.
    let mut steps = 0usize;
    while steps < 64 {
        let mut hit: Option<(usize, u32, &FunctionSsa, Vec<ValueId>)> = None;
        'find: for (b_idx, block) in caller.blocks.iter().enumerate() {
            for pc in block.inst_range.start..block.inst_range.end {
                if let Inst::Call {
                    target_pc, args, ..
                } = &caller.insts[pc as usize]
                    && let Some(c) = callees.get(target_pc)
                    && c.blocks.len() > 1
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
pub(super) fn run(funcs: &mut [FunctionSsa], cap: u32) {
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
            // Skip callers that contain phis. `remap_caller_inst`
            // remaps a phi's incoming values through the caller
            // remap table in PC order, but a loop-head phi
            // references back-edge incomings whose remap entries
            // are still NO_VALUE when the phi is processed -- the
            // phi then carries `incoming = (pred, NO_VALUE)` into
            // the inlined IR and the per-arch emit bails on the
            // first downstream operand that resolves to NO_VALUE.
            // TODO: two-pass remap (populate the full caller/callee
            // value and block remap, then rewrite phi incomings)
            // so a caller with loop-head phis can still inline; the
            // skip leaves loop-carrying callers un-inlined.
            if caller
                .insts
                .iter()
                .any(|inst| matches!(inst, Inst::Phi { .. }))
            {
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

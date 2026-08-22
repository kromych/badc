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
//! * callee's body contains no `TailExt` and no aggregate-returning
//!   nested call -- otherwise the straight-line shapes whose
//!   `for_each_operand` walks a known set of `ValueId` fields. A
//!   `LocalAddr` naming a frame slot is admitted only where the splice
//!   has somewhere to send it: a register-passed struct parameter's slot
//!   relocates into the caller's frame and the prefix copies the argument
//!   into it, the slot a return delivers through redirects to the
//!   caller's object, and the reloc path relocates a callee's own slots
//!   and frame-kept parameter cells into the caller's frame.
//!
//! Those constraints cover the small leaf helpers (R / Ch / Maj /
//! Sigma / sigma in SHA-512, `lerp` / `fastfloor` / `grad` in
//! Perlin noise) whose call overhead dominates the crypto and
//! noise-generation perf rows.
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
use crate::c5::codegen::ssa::reg_alloc::for_each_operand;
use crate::c5::ir::{
    AsmConstraint, BinOp, Block, BlockId, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind,
    Terminator, ValueId,
};

/// Outer candidacy fixpoint cap: re-evaluating candidacy after each
/// substitution pass lets a helper that became a leaf inline on the
/// next round. A 3-level call chain reaches the bottom in 3 rounds, so
/// this bounds the chain depth that fully collapses.
const INLINE_FIXPOINT_ITERS: usize = 8;

/// Per-call-step cap on multi-block splices into one caller, bounding
/// expansion when a caller has many distinct multi-block call sites.
const MAX_MULTI_BLOCK_SPLICE_STEPS: usize = 64;

/// Instruction count past which a caller stops absorbing size-driven
/// candidates. The per-callee body cap bounds each inlined fragment, but
/// across the candidacy fixpoint many small fragments otherwise compound
/// into a function that is large in both code and stack frame. Once a
/// caller reaches this size only callees the source explicitly marked
/// `inline` are still inlined into it (they bypass the body-size cap for
/// the same reason). Mirrors gcc's large-function-growth limit.
const CALLER_INST_BUDGET: usize = 2048;

/// Local-slot count past which a *self-recursive* caller stops absorbing
/// size-driven candidates. A recursive frame is paid once per recursion
/// level, so inlining that inflates it multiplies stack use by the depth
/// and can overflow a small (firmware / kernel) stack. The threshold is
/// well above the frame a leaf helper contributes -- a recursion that
/// only inlines a swap / partition-sized body stays small and is
/// unaffected -- but far below the runaway growth an inline fixpoint can
/// otherwise reach. Mirrors gcc's large-stack-frame limit. Each slot is
/// 8 bytes, so this caps the inlined-frame growth at 256 bytes.
const RECURSIVE_FRAME_SLOTS: i64 = 32;

/// Local-slot count (2 KiB) a caller's frame must exceed -- together with
/// `FRAME_GROWTH_FACTOR` times its pre-inline size -- before optional
/// inlining into it stops; only a mandatory (`always_inline`) request is
/// honoured past the bound. Region reuse and the post-inline slot
/// compaction keep organic growth under this backstop. Mirrors gcc's
/// large-stack-frame / large-stack-frame-growth pair, which a plain
/// `inline` hint does not bypass.
const CALLER_FRAME_SLOTS: i64 = 256;

/// Relative growth bound for the caller frame gate.
const FRAME_GROWTH_FACTOR: i64 = 4;

/// Local-slot count (one 4 KiB page, at 8 bytes per slot) a caller's
/// relocated-slot region may not cross to absorb a size-driven callee.
/// The `CALLER_FRAME_SLOTS` / `FRAME_GROWTH_FACTOR` pair is relative, so a
/// caller that already declares a large frame may still multiply it, and
/// neither bounds the frame itself; a frame that spans a page costs a
/// noticeable fraction of the smallest stacks a target runs on (a 16 KiB
/// kernel task stack), which is worth paying for a mandatory
/// (`always_inline`) request and not for a size-driven candidate.
///
/// Checked per splice rather than per round: a splice exposes the callee's
/// own call sites, so the sites a round will absorb cannot be counted
/// before it runs. The bound is on the slots the splice relocates -- the
/// allocator's spill and save regions sit outside it and are not
/// predictable here -- so a frame can still end slightly past a page.
/// What keeps that safe is the probing prologue, not this bound.
const CALLER_FRAME_ABS_SLOTS: i64 = 512;

#[derive(Clone, Copy)]
enum RegionKey {
    Pool,
    Callee(usize),
}

/// Frame regions recorded for one caller, persisting across the candidacy
/// fixpoint: a splice places the callee's relocated locals (own slots plus
/// materialized parameter cells) into a recorded region instead of
/// appending a fresh one per call site, so N sites cost one region.
///
/// A region may back at most one live activation: the spliced objects'
/// lifetimes end when the inlined body exits (C99 6.2.4p2), so a non-UB
/// access happens only from inside that splice's own blocks, and a second
/// activation can nest inside the first only when a later fixpoint round
/// splices a body into those blocks -- which requires an `Inst::Call`
/// there (`CallExt` / `CallIndirect` sites are never spliced). A call-free
/// body therefore never contains another splice and every call-free splice
/// shares the one `pool` region; a call-bearing callee can nest an
/// activation of itself only through a call cycle, so one off every cycle
/// (`call_cycle_members`) reuses a single per-callee region across its
/// sites, and a cycle member appends per site.
/// Where a spliced body's relocated locals may live: the caller's region
/// records plus the two sets that force a fresh region per site -- callees
/// on a call cycle, and functions that can reach stack-pointer asm.
struct SlotPlacement<'a> {
    regions: &'a mut CallerRegions,
    cyclic: &'a BTreeSet<usize>,
    sp_tainted: &'a BTreeSet<usize>,
}

#[derive(Default)]
struct CallerRegions {
    /// Shared region for call-free bodies: `(base, size)` slot-magnitude
    /// record occupying offsets `-(base + 1) ..= -(base + size)`.
    pool: Option<(i64, i64)>,
    /// One region per call-bearing off-cycle callee, keyed by ent_pc.
    per_callee: BTreeMap<usize, Option<(i64, i64)>>,
}

/// Which region record backs a splice of `callee` into the caller at
/// `caller_pc`, or `None` when the site must append its own. A cycle
/// member appends, and so does any splice whose caller or callee can come
/// to execute stack-pointer asm (`sp_asm_reachers`): a stack switch lets a
/// spliced activation stay live -- suspended mid-body on another stack --
/// while the caller proceeds to further sites, so no two sites may share.
/// An indirect call constrains neither set. The stack-pointer guard
/// covers asm the caller can come to execute on its own frame -- asm
/// acquired by inlining, which moves bodies along `Inst::Call` edges --
/// and an indirect call site is never spliced, so its target's asm can
/// never run on the caller's frame; at run time the target executes in a
/// frame of its own, as a `CallExt` target does. Nesting is not at issue
/// either: a splice site is always an `Inst::Call`, and re-entering the
/// caller through the pointer activates a fresh frame with fresh
/// regions. (A returns-twice target would fork one frame's control, but
/// accessing the setjmp family other than through its macro name is
/// undefined, C99 7.13.1.1p5.) Read by the splice and by the frame
/// budget, which charges an appending callee once per site.
fn region_key(
    caller_pc: usize,
    callee: &FunctionSsa,
    cyclic: &BTreeSet<usize>,
    sp_tainted: &BTreeSet<usize>,
) -> Option<RegionKey> {
    let sp = sp_tainted.contains(&caller_pc) || sp_tainted.contains(&callee.ent_pc);
    if sp || cyclic.contains(&callee.ent_pc) {
        None
    } else if callee.over_aligned.is_empty()
        && !callee.insts.iter().any(|i| matches!(i, Inst::Call { .. }))
    {
        // A callee with over-aligned slots keeps a per-callee record even when
        // call-free: the pool overlays different callees' slots, and a slot
        // that is a region member for one callee and plain (or differently
        // sized) storage for another cannot share bytes.
        Some(RegionKey::Pool)
    } else {
        Some(RegionKey::Callee(callee.ent_pc))
    }
}

/// True when the spliced copy may contain a `CallIndirect` the devirt
/// sweep (`devirtualize_indirect_calls`) later turns into a direct
/// `Call`: its target is an `ImmCode` in the callee's own body, or a
/// parameter whose argument at this site defines one. Pool safety rests
/// on pool copies never holding an `Inst::Call` -- nothing is ever
/// spliced into them, so no activation nests -- so such a copy takes
/// the callee's own record instead (`region_key` callers downgrade).
/// Mirrors the sweep's one-level target match.
fn splice_may_gain_direct_call(
    callee: &FunctionSsa,
    call_args: &[ValueId],
    caller_insts: &[Inst],
) -> bool {
    callee.insts.iter().any(|i| {
        let Inst::CallIndirect { target, .. } = i else {
            return false;
        };
        match callee.insts.get(*target as usize) {
            Some(Inst::ImmCode(_)) => true,
            Some(Inst::ParamRef { idx, .. }) => call_args
                .get(*idx as usize)
                .and_then(|&a| caller_insts.get(a as usize))
                .is_some_and(|ai| matches!(ai, Inst::ImmCode(_))),
            _ => false,
        }
    })
}

impl CallerRegions {
    /// Slot-magnitude base for a splice needing `needed` slots given the
    /// caller's current locals count. Reuses the keyed record when it
    /// fits, grows it in place while it is still the top of the locals
    /// region, and otherwise opens a fresh region at the top (a stale
    /// record's sites keep their baked offsets). The caller then sets
    /// `locals = locals.max(base + needed)`; records never overlap each
    /// other or the caller's own slots because every record is carved at
    /// the top of the locals region current at its creation.
    fn place(&mut self, key: Option<RegionKey>, needed: i64, locals: i64) -> i64 {
        let rec: &mut Option<(i64, i64)> = match key {
            None => return locals,
            Some(RegionKey::Pool) => &mut self.pool,
            Some(RegionKey::Callee(pc)) => self.per_callee.entry(pc).or_default(),
        };
        match rec {
            Some((base, size)) if needed <= *size => *base,
            Some((base, size)) if *base + *size == locals => {
                *size = needed;
                *base
            }
            _ => {
                *rec = Some((locals, needed));
                locals
            }
        }
    }
}

/// Functions on a direct-call cycle (a non-singleton SCC or a self edge)
/// in the unit's `Inst::Call` graph, by ent_pc. Inlining replaces a call
/// with the callee's own calls -- all existing edges of the callee -- so
/// the graph's transitive closure never grows and membership decided on
/// the pre-inline bodies stays sound for the whole fixpoint. Iterative
/// Tarjan.
fn call_cycle_members(funcs: &[FunctionSsa]) -> BTreeSet<usize> {
    let n = funcs.len();
    let idx_of: BTreeMap<usize, usize> = funcs
        .iter()
        .enumerate()
        .map(|(i, f)| (f.ent_pc, i))
        .collect();
    let succ: Vec<Vec<usize>> = funcs
        .iter()
        .map(|f| {
            let mut out: Vec<usize> = f
                .insts
                .iter()
                .filter_map(|i| match i {
                    Inst::Call { target_pc, .. } => idx_of.get(target_pc).copied(),
                    _ => None,
                })
                .collect();
            out.sort_unstable();
            out.dedup();
            out
        })
        .collect();
    let mut index = vec![usize::MAX; n];
    let mut low = vec![0usize; n];
    let mut on_stack = vec![false; n];
    let mut stack: Vec<usize> = Vec::new();
    let mut next_index = 0usize;
    let mut members = BTreeSet::new();
    for root in 0..n {
        if index[root] != usize::MAX {
            continue;
        }
        let mut work: Vec<(usize, usize)> = vec![(root, 0)];
        while let Some((v, ci)) = work.pop() {
            if ci == 0 {
                index[v] = next_index;
                low[v] = next_index;
                next_index += 1;
                stack.push(v);
                on_stack[v] = true;
            }
            let mut resumed = false;
            let mut i = ci;
            while let Some(&w) = succ[v].get(i) {
                i += 1;
                if index[w] == usize::MAX {
                    work.push((v, i));
                    work.push((w, 0));
                    resumed = true;
                    break;
                }
                if on_stack[w] {
                    low[v] = low[v].min(index[w]);
                }
            }
            if resumed {
                continue;
            }
            if low[v] == index[v] {
                let mut scc: Vec<usize> = Vec::new();
                loop {
                    let w = stack.pop().unwrap();
                    on_stack[w] = false;
                    scc.push(w);
                    if w == v {
                        break;
                    }
                }
                if scc.len() > 1 || succ[v].contains(&v) {
                    for m in scc {
                        members.insert(funcs[m].ent_pc);
                    }
                }
            }
            if let Some(&(p, _)) = work.last() {
                low[p] = low[p].min(low[v]);
            }
        }
    }
    members
}

/// Rewrite each `Inst::CallIndirect` whose target value is an
/// `Inst::ImmCode` of a function defined in this unit into the direct
/// `Inst::Call`, keeping the argument list and return metadata; the
/// emit then issues a direct call and the site becomes an inline
/// candidate on the next candidacy round. Inlining a higher-order
/// wrapper is what produces these pairs: the callee's `ImmCode`
/// argument lands next to the wrapper's `CallIndirect`.
///
/// A site is skipped when the rewrite could change behavior or an
/// invariant this run relies on:
///
/// * the `ImmCode` payload names no function of this unit (an
///   undefined callee's placeholder ent_pc), or it carries an
///   `extern_imm_code_refs` entry whose symbol `code_syms` does not
///   resolve to that same ent_pc -- the walker records the entry for
///   any symbol whose value was 0, which is a defined function at
///   ent_pc 0 as often as an unresolved reference, and only the
///   symbol table tells them apart;
/// * the pointer's declared variadic-ness disagrees with the callee's
///   (`is_variadic` drives the direct call's argument placement);
/// * the target can reach stack-pointer asm (`sp_asm_reachers`
///   propagates over direct edges only, so an admitted edge must not
///   lead there);
/// * the edge would close a direct-call cycle (`call_cycle_members`
///   likewise assumes the direct graph gains no cycle mid-run);
/// * the target reaches a callee with a shared region record in this
///   caller (`CallerRegions::per_callee`). The record's sharing rests
///   on same-callee copies never nesting, and every copy enclosing
///   this site carries such a record if it holds any slots; inlining
///   the devirtualized call could otherwise re-splice an enclosing
///   copy's callee inside itself, re-activating its record's slots.
///
/// The `ImmCode` keeps its definition; with no use left it is
/// dead-pure and the emit drops it.
fn devirtualize_indirect_calls(
    funcs: &mut [FunctionSsa],
    sp_tainted: &BTreeSet<usize>,
    regions: &BTreeMap<usize, CallerRegions>,
    code_syms: &BTreeMap<u32, usize>,
) -> bool {
    let idx_of: BTreeMap<usize, usize> = funcs
        .iter()
        .enumerate()
        .map(|(i, f)| (f.ent_pc, i))
        .collect();
    let variadic: BTreeMap<usize, bool> = funcs.iter().map(|f| (f.ent_pc, f.is_variadic)).collect();
    // Direct-call adjacency by function index, extended as rewrites land
    // so every reachability check runs against the current graph.
    let mut succ: Vec<BTreeSet<usize>> = funcs
        .iter()
        .map(|f| {
            f.insts
                .iter()
                .filter_map(|i| match i {
                    Inst::Call { target_pc, .. } => idx_of.get(target_pc).copied(),
                    _ => None,
                })
                .collect()
        })
        .collect();
    let reach_set = |succ: &[BTreeSet<usize>], from: usize| -> Vec<bool> {
        let mut seen = vec![false; succ.len()];
        let mut work = vec![from];
        while let Some(v) = work.pop() {
            if core::mem::replace(&mut seen[v], true) {
                continue;
            }
            work.extend(succ[v].iter().copied().filter(|&w| !seen[w]));
        }
        seen
    };
    let mut changed = false;
    for fi in 0..funcs.len() {
        let ref_sym: BTreeMap<u32, u32> = funcs[fi].extern_imm_code_refs.iter().copied().collect();
        let recorded: Vec<usize> = regions
            .get(&funcs[fi].ent_pc)
            .map(|r| {
                r.per_callee
                    .keys()
                    .filter_map(|pc| idx_of.get(pc).copied())
                    .collect()
            })
            .unwrap_or_default();
        let mut rewrites: Vec<(usize, usize)> = Vec::new();
        for (ci, inst) in funcs[fi].insts.iter().enumerate() {
            let Inst::CallIndirect {
                target,
                callee_variadic,
                ..
            } = inst
            else {
                continue;
            };
            let Some(Inst::ImmCode(k)) = funcs[fi].insts.get(*target as usize) else {
                continue;
            };
            if let Some(sym) = ref_sym.get(target)
                && code_syms.get(sym) != Some(k)
            {
                continue;
            }
            let Some(&ki) = idx_of.get(k) else { continue };
            if variadic[k] != *callee_variadic || sp_tainted.contains(k) {
                continue;
            }
            let reach = reach_set(&succ, ki);
            if reach[fi] || recorded.iter().any(|&r| reach[r]) {
                continue;
            }
            rewrites.push((ci, ki));
        }
        for (ci, ki) in rewrites {
            let target_pc = funcs[ki].ent_pc;
            let taken = core::mem::replace(&mut funcs[fi].insts[ci], Inst::Imm(0));
            let Inst::CallIndirect {
                args,
                fixed_args,
                fp_return,
                fp_arg_mask,
                arg_aggs,
                ret_agg,
                ret_slot_local,
                ..
            } = taken
            else {
                unreachable!("collected above");
            };
            funcs[fi].insts[ci] = Inst::Call {
                target_pc,
                args,
                fixed_args,
                fp_return,
                fp_arg_mask,
                arg_aggs,
                ret_agg,
                ret_slot_local,
            };
            succ[fi].insert(ki);
            changed = true;
        }
    }
    changed
}

fn store_width(kind: StoreKind) -> i64 {
    match kind {
        StoreKind::I8 => 1,
        StoreKind::I16 => 2,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::I64 | StoreKind::F64 => 8,
        StoreKind::F80 | StoreKind::F128 => 16,
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

/// The c5 out-pointer return epilogue: the caller passes the address of
/// its result object as the hidden first argument, and `return s;` copies
/// the whole object into it and returns the pointer (`walk_stmt`'s
/// `returns_struct` path). Splicing keeps the copy's source and its
/// destination in the same frame, so the redirect below sends the body's
/// result slot straight to the hidden argument and drops the copy --
/// exactly what the host-ABI aggregate return does with the call site's
/// return slot.
struct OutPtrReturn {
    /// Callee frame slot holding the returned object.
    slot: i64,
    /// Object size in bytes; bounds every write the redirect reproduces.
    size: i64,
    /// The whole-object copy the redirect makes a self-copy.
    copy: ValueId,
}

/// Recognise [`OutPtrReturn`] in a single-block callee. The declared
/// return type must be a by-value structure the host-ABI classification
/// left on this convention, which is what makes the destination the call
/// site's own result temporary: every such site is the walker's, and it
/// reserves a fresh object per call. Declines unless the hidden
/// out-pointer is read exactly once, by the trailing copy that is the
/// block's last instruction -- any other read could observe the object
/// before the redirected writes complete, and a write after the copy
/// would be lost.
fn out_ptr_return(c: &FunctionSsa) -> Option<OutPtrReturn> {
    use crate::c5::compiler::types::{is_struct_ty, struct_ptr_depth};
    if c.ret_agg.is_some() || c.blocks.len() != 1 {
        return None;
    }
    if !is_struct_ty(c.ret_type_tag) || struct_ptr_depth(c.ret_type_tag) != 0 {
        return None;
    }
    let block = &c.blocks[0];
    let Terminator::Return(rv) = block.terminator else {
        return None;
    };
    if !matches!(
        c.insts.get(rv as usize),
        Some(Inst::LoadLocal {
            off: 2,
            kind: LoadKind::I64,
            volatile: false
        })
    ) {
        return None;
    }
    let copy = block.inst_range.end.checked_sub(1)?;
    let Some(Inst::Mcpy { dst, src, size, .. }) = c.insts.get(copy as usize) else {
        return None;
    };
    if *dst != rv || *size <= 0 {
        return None;
    }
    let slot = match c.insts.get(*src as usize) {
        Some(Inst::LocalAddr(s)) if *s < 0 => *s,
        _ => return None,
    };
    // The cell itself must stay the caller's address for the whole body,
    // and the copy must be the only consumer of the value read out of it.
    let mut ok = true;
    for pc in block.inst_range.clone() {
        if pc == copy {
            continue;
        }
        match &c.insts[pc as usize] {
            Inst::StoreLocal { off: 2, .. } | Inst::LocalAddr(2) => ok = false,
            other => for_each_operand(other, |v| {
                if v == rv {
                    ok = false;
                }
            }),
        }
    }
    ok.then_some(OutPtrReturn {
        slot,
        size: *size,
        copy,
    })
}

/// `inst.is_inline_candidate(cap)`-style predicate. See module docs.
fn is_inline_candidate(
    func: &FunctionSsa,
    cap: u32,
    abi: Abi,
    mut reason_out: Option<&mut alloc::string::String>,
) -> bool {
    #[cfg(feature = "codegen_test")]
    let trace = std::env::var("BADC_LOG_INLINE").is_ok();
    // Record the rejection reason both to the optional caller sink (the
    // always_inline warning) and, under `codegen_test`, to the trace log.
    // `format_args!` leaves the message unbuilt on the hot path where no
    // sink is set and tracing is off.
    let mut say = |args: core::fmt::Arguments| {
        #[cfg(feature = "codegen_test")]
        if trace {
            eprintln!(
                "[inline] reject {n} (ent_pc={pc}): {r}",
                n = func.name,
                pc = func.ent_pc,
                r = args
            );
        }
        if let Some(out) = reason_out.as_mut() {
            use core::fmt::Write;
            out.clear();
            let _ = write!(out, "{args}");
        }
    };

    // gcc's documented way to keep a body out of line, and the escape hatch
    // its `__builtin_return_address` wording names. Checked before every
    // other gate so the request holds whatever the body's shape.
    if func.is_noinline {
        say(format_args!("noinline"));
        return false;
    }
    if func.is_variadic {
        say(format_args!("variadic"));
        return false;
    }
    // A naked function's body is raw asm implementing its own calling
    // convention -- prologue, stack management, and the return / control
    // transfer (a `ret` or a stack-switching `jmp`). Splicing that asm into
    // a caller discards the contract: the inlined `ret` transfers control
    // away from the caller and the stack manipulation corrupts the caller's
    // frame. A naked function is never an inline candidate.
    if func.is_naked {
        say(format_args!("naked function"));
        return false;
    }
    // A weak definition is replaceable: the linker binds every reference to
    // a strong definition of the same name when one exists in another
    // object, so the body visible here need not be the one that runs.
    // Splicing it in would commit the caller to this unit's copy. gcc and
    // clang keep the out-of-line call for the same reason.
    if func.is_weak {
        say(format_args!("weak definition"));
        return false;
    }
    // An automatic object aligned above 16 lives in the callee's prologue-
    // realigned region; the splice cannot reproduce the sp realignment in the
    // caller frame, so the body stays out of line. A 16-aligned region sits at
    // a static frame offset and relocates with the callee's slots (the splice
    // merges `over_aligned` into the caller's region).
    if func.frame_align > 16 {
        say(format_args!("automatic object aligned above 16"));
        return false;
    }
    // A self-recursive callee stays out of line: splicing it does not
    // remove the recursion -- the recursive calls come along -- so
    // inlining only unrolls the call tree one level per candidacy-fixpoint
    // round, unbounded code growth for no call elimination. Matches gcc's
    // -O2 default of not inlining recursive functions.
    if func
        .insts
        .iter()
        .any(|i| matches!(i, Inst::Call { target_pc, .. } if *target_pc == func.ent_pc))
    {
        say(format_args!("self-recursive"));
        return false;
    }
    // A body calling a returns-twice function (setjmp family / vfork)
    // stays out of line: splicing it would silently drop the caller's
    // no-slot-share discipline (`FunctionSsa::has_returns_twice_call`).
    if func.has_returns_twice_call {
        say(format_args!("calls a returns-twice function"));
        return false;
    }
    // Host-ABI aggregates the splice itself has to reproduce: the callee's
    // by-value parameters, whose frame copy the prefix re-emits from the
    // caller's argument, and its return, which the splice delivers into the
    // caller's return slot. `agg_descs` also holds the layouts a nested
    // call's `arg_aggs` names; those are marshalled by the per-arch call
    // plan exactly as they would be out of line, so their class is not
    // this pass's concern.
    let spliced_aggs: BTreeSet<u32> = func
        .param_aggs
        .iter()
        .flatten()
        .copied()
        .chain(func.ret_agg)
        .collect();
    // A by-value parameter arrives as a single argument value -- the
    // address of the caller's copy (the SSA `Inst::Call` carries one arg
    // per struct parameter regardless of how many registers the ABI
    // marshals it into), which the splice copies into the relocated
    // parameter cell the body's `LocalAddr(slot)` reads. So a one- or
    // two-register integer aggregate parameter is admissible; the copy is
    // identical either way. FP-class and memory-class parameters stay rejected. The return
    // and the parameters are classified separately: a function whose
    // parameter and return share a layout interns one descriptor, and the
    // two sides classify differently (a return may be indirect where the
    // same layout as a parameter goes by reference or on the stack).
    let integer_regs = |d: &crate::c5::ir::AggDesc, is_ret: bool| {
        matches!(
            classify_aggregate(d.size, d.align, &d.fields, abi, is_ret),
            AggClass::Regs(ref regs)
                if !regs.is_empty()
                    && regs.len() <= 2
                    && regs.iter().all(|r| *r == RegClass::Integer)
        )
    };
    for &i in func.param_aggs.iter().flatten() {
        let Some(d) = func.agg_descs.get(i as usize) else {
            say(format_args!("aggregate descriptor {i} out of range"));
            return false;
        };
        if !integer_regs(d, false) {
            say(format_args!(
                "aggregate parameter not in one or two integer registers"
            ));
            return false;
        }
    }
    // A by-value aggregate parameter's cell is filled by the prologue from
    // the incoming argument. The splice reproduces that copy into the
    // relocated cell, which needs the cell to sit inside the callee's own
    // local range the splice relocates.
    for (i, _) in func
        .param_aggs
        .iter()
        .enumerate()
        .filter(|(_, a)| a.is_some())
    {
        let s = func.param_local_slots.get(i).copied().unwrap_or(0);
        if s != 0 && !(s < 0 && -s <= func.locals) {
            say(format_args!(
                "by-value aggregate parameter cell outside the relocatable frame"
            ));
            return false;
        }
    }
    // A return is delivered either in the integer return registers
    // (rax:rdx / x0:x1) or through the caller-supplied indirect-result
    // pointer. Both name the caller's return slot, which the splice writes
    // directly -- by redirecting the callee's result slot to it (flat
    // path) or by the postfix per-field copy (reloc path) -- so the two
    // classes are equally reproducible. FP-class returns stay rejected.
    if let Some(i) = func.ret_agg {
        let Some(d) = func.agg_descs.get(i as usize) else {
            say(format_args!("aggregate descriptor {i} out of range"));
            return false;
        };
        let indirect = matches!(
            classify_aggregate(d.size, d.align, &d.fields, abi, true),
            AggClass::ReturnIndirect
        );
        if !integer_regs(d, true) && !indirect {
            say(format_args!(
                "aggregate return neither in integer registers nor indirect"
            ));
            return false;
        }
    }
    // A static initializer holding one of the callee's label addresses
    // names a single code location, so that label's block has to stay in
    // the out-of-line body the data slot relocates against.
    if !func.label_data_relocs.is_empty() {
        say(format_args!("label address in static data"));
        return false;
    }
    // A single `Return` block rewrites to `Jmp(postfix)`; multiple route
    // through a synthetic join block whose phi merges the per-return
    // values into the call result. Both need the no-aggregate multi-block
    // splice (`splice_multi_block`); the flat aggregate splice handles one
    // Return only. `AsmGoto` rides the same path -- the splice clones its
    // `jump_tables` row with the callee's block ids shifted into the
    // caller. `JumpTable` / `GotoIndirect` stay out of line: their
    // block-id references (the switch bounds check / the `BlockAddr`
    // computed-goto set) are not remapped here.
    let no_agg = spliced_aggs.is_empty();
    let mut return_blocks = 0usize;
    for blk in &func.blocks {
        match blk.terminator {
            Terminator::Return(_) => return_blocks += 1,
            Terminator::TailExt(_) => {
                say(format_args!("TailExt terminator"));
                return false;
            }
            Terminator::GotoIndirect { .. } => {
                say(format_args!("GotoIndirect terminator"));
                return false;
            }
            Terminator::JumpTable { .. } => {
                say(format_args!("JumpTable terminator"));
                return false;
            }
            Terminator::AsmGoto { .. } => {
                if !no_agg {
                    say(format_args!("AsmGoto terminator"));
                    return false;
                }
            }
            // A block sealed after a `_Noreturn` call is not a return:
            // control never reaches its end, so the splice needs no
            // postfix merge for it. The multi-block splice preserves it
            // as-is (it has no successor and no block-id operands).
            Terminator::Unreachable => {}
            Terminator::Jmp(_)
            | Terminator::FallThrough(_)
            | Terminator::Bz { .. }
            | Terminator::Bnz { .. } => {}
        }
    }
    if return_blocks == 0 {
        say(format_args!("no Return block"));
        return false;
    }
    // Multiple returns merge through the postfix join phi, built only for
    // an integer value (an FP join phi is out of scope). An aggregate
    // return joins its per-return result addresses the same way -- the
    // postfix copy then reads the merged address -- so only the FP scalar
    // shape stays out. A flat (single-block) callee has one Return by
    // construction.
    if return_blocks > 1 && func.ret_is_fp {
        say(format_args!("{return_blocks} FP Return blocks (need 1)"));
        return false;
    }
    // `inline` / `__attribute__((always_inline))`-marked functions
    // bypass the body-size cap (gcc / clang -O2 policy). The other
    // shape constraints still apply.
    if !func.is_inline && func.insts.len() > cap as usize {
        say(format_args!(
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
    // the drop, so build a use mask first and reject the function if
    // any allowed-but-dropped inst is actually live. A parameter cell
    // kept in the frame -- spilled or materialized -- instead
    // relocates into a caller slot, so its live accesses are
    // admissible.
    let used = value_use_mask(func);
    let spilled = spilled_param_cells(func);
    // Parameter cells the splice reads straight from the call-site
    // argument (a parameter past the ABI's argument registers).
    let forwarded = forwarded_param_cells(func, &used);
    // Cells the reloc splice gives caller frame slots: spilled ones the
    // body reads back, plus the unspilled ones it materializes with a
    // synthesized initializing store.
    let materialized = materialized_param_cells(func, &used);
    let relocated_cells = relocated_param_cells(func, &used, &materialized);
    // Frame slots holding a register-passed struct parameter's bytes. A
    // body `LocalAddr` of one of these names the relocated cell the splice
    // copies the argument into; any other `LocalAddr` names a caller frame
    // slot that does not exist after inlining.
    let param_agg_slots: BTreeSet<i64> = func
        .param_aggs
        .iter()
        .enumerate()
        .filter(|(_, a)| a.is_some())
        .filter_map(|(i, _)| func.param_local_slots.get(i).copied())
        .filter(|&s| s != 0)
        .collect();
    // A callee's own local slots are relocated into the caller's frame by
    // `splice_multi_block`, which `inline_caller` runs for every multi-block
    // callee and for the single-block callees `needs_reloc_splice` names.
    // The reloc path is what lets an asm output write through an own local
    // (the output's `LocalAddr(<0)` and the read-back `LoadLocal(<0)`
    // relocate into the caller frame), what gives an address-taken own
    // local a caller slot, and what carries an aggregate across blocks: an
    // aggregate return is copied field by field from the returned address
    // into the caller's return slot, and a struct-parameter slot is filled
    // from the caller's argument. Every other single-block callee takes
    // the flat path and keeps its strict gates.
    let reloc = func.blocks.len() > 1 || needs_reloc_splice(func, &used);
    // On the flat path an aggregate return lives in the slot named by the
    // single `Return(LocalAddr(result_slot))`; the splice redirects that
    // slot to the caller's return slot. Reject shapes the redirect cannot
    // handle: a non-LocalAddr return (a global address or an
    // indirect-result pointer), and a result slot that is also a
    // parameter slot (the two redirects would collide and the return slot
    // would be left unwritten). The reloc path has no result slot: it
    // copies from whatever address each `Return` carries, so it only
    // rejects a value-less aggregate Return.
    let result_slot: Option<i64> = if func.ret_agg.is_some() && !reloc {
        let Terminator::Return(rv) = func.blocks[0].terminator else {
            say(format_args!("aggregate return without a Return terminator"));
            return false;
        };
        match func.insts.get(rv as usize) {
            Some(Inst::LocalAddr(s)) if !param_agg_slots.contains(s) => Some(*s),
            Some(Inst::LocalAddr(_)) => {
                say(format_args!("aggregate return slot is a parameter slot"));
                return false;
            }
            _ => {
                say(format_args!("aggregate return not via a local slot"));
                return false;
            }
        }
    } else {
        None
    };
    // The by-address return convention's result slot takes the same
    // redirect, sending the body's writes to the caller's object rather
    // than to a slot of its own.
    let out_ptr = if reloc { None } else { out_ptr_return(func) };
    // The per-field copy reads the returned address, so every aggregate
    // Return must carry one. A prologue-spilled struct-parameter slot
    // would take both the spill's relocation and the prefix copy into the
    // same cell; reject the overlap.
    if reloc {
        if func.ret_agg.is_some()
            && func
                .blocks
                .iter()
                .any(|b| matches!(b.terminator, Terminator::Return(v) if v == NO_VALUE))
        {
            say(format_args!("aggregate return without a value"));
            return false;
        }
        if param_agg_slots.iter().any(|s| spilled.contains(s)) {
            say(format_args!("struct-parameter slot with a prologue spill"));
            return false;
        }
    }
    // Every write into the result slot must stay within its bounds: the
    // splice reproduces each result-slot store against the caller's return
    // slot, so a store past the slot would corrupt the caller's frame.
    // Bytes the body leaves unwritten (a union's inactive members, struct
    // padding) take unspecified values (C99 6.2.6.1p6-7); the non-inlined
    // return register leaves them unspecified too, so they need not match
    // and full coverage is not required.
    let redirected = match (result_slot, &out_ptr) {
        (Some(rs), _) => Some((
            rs,
            func.agg_descs[func.ret_agg.unwrap() as usize].size as i64,
        )),
        (None, Some(o)) => Some((o.slot, o.size)),
        (None, None) => None,
    };
    let redirect_slot = redirected.map(|(s, _)| s);
    if let Some((rs, agg_size)) = redirected {
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
                say(format_args!("aggregate return slot write out of bounds"));
                return false;
            }
        }
    }
    let in_block = in_block_mask(func);
    for (idx, inst) in func.insts.iter().enumerate() {
        if !in_block[idx] {
            continue;
        }
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
            | Inst::Bswap { .. }
            | Inst::Fneg(_)
            | Inst::Fma { .. }
            | Inst::FpCast { .. }
            | Inst::Load { .. }
            | Inst::LoadIndexed { .. } => {}
            Inst::LocalAddr(s) => {
                // On the reloc path the splice relocates a callee's own local
                // slot (negative) and a frame-kept parameter cell -- spilled
                // (its prologue spill initializes the relocated slot) or
                // materialized (the splice synthesizes that store from the
                // argument) -- into the caller's frame, and redirects a
                // struct-parameter slot to the caller's argument address; the
                // remaining cells (past the parameters, FP, the reserved
                // cells) have no reproducible initialization. On the flat
                // path only a struct-parameter slot or the return's result
                // slot (redirected to the caller's object) is admissible.
                if reloc {
                    if *s >= 0 && !relocated_cells.contains(s) && !param_agg_slots.contains(s) {
                        say(format_args!(
                            "LocalAddr of non-relocated parameter cell {s}"
                        ));
                        return false;
                    }
                } else if !param_agg_slots.contains(s) && Some(*s) != redirect_slot {
                    say(format_args!("LocalAddr of non-parameter slot {s}"));
                    return false;
                }
            }
            Inst::Store { addr, .. } => {
                // With no aggregate parameter or return, a store either
                // addresses a callee frame slot -- whose `LocalAddr` the arm
                // above already rejects (no caller equivalent) -- or writes
                // through a pointer value the splice reproduces by remapping
                // the address operand (`rewrite_callee_inst`). With
                // aggregates a store must not reach a by-value parameter's
                // frame copy: its slot redirects to the caller's argument,
                // so the write would corrupt the caller's object. The reloc
                // path rejects exactly those; the flat path keeps the strict
                // result-slot gate (the redirect to the caller's return slot
                // is its only reproducible write).
                if !spliced_aggs.is_empty() {
                    if reloc {
                        if param_agg_slots
                            .iter()
                            .any(|&p| slot_base_offset(func, *addr, p).is_some())
                        {
                            say(format_args!("store into a struct-parameter slot"));
                            return false;
                        }
                    } else if redirect_slot.is_none()
                        || !addr_is_slot(func, *addr, redirect_slot.unwrap())
                    {
                        say(format_args!("store outside the aggregate return slot"));
                        return false;
                    }
                }
            }
            Inst::Mcpy { dst, src, .. } => {
                // For a reloc callee an Mcpy is reproducible: the splice
                // remaps its dst / src operands (`rewrite_callee_inst`), and a
                // dst / src that names a relocated local slot rides the
                // LocalAddr relocation -- but the dst must not reach a
                // struct-parameter slot (redirected to the caller's argument,
                // as for `Store`). On the flat path the compound-literal
                // template init (an `ImmData` template copied into the result
                // slot) and the by-address return's trailing copy -- which
                // the redirect turns into a copy of the caller's object onto
                // itself, so the splice drops it -- are admitted.
                if reloc {
                    if !spliced_aggs.is_empty()
                        && param_agg_slots
                            .iter()
                            .any(|&p| slot_base_offset(func, *dst, p).is_some())
                    {
                        say(format_args!("mcpy into a struct-parameter slot"));
                        return false;
                    }
                } else if !out_ptr.as_ref().is_some_and(|o| o.copy == idx as ValueId) {
                    let to_result =
                        redirect_slot.is_some() && addr_is_slot(func, *dst, redirect_slot.unwrap());
                    let from_template =
                        matches!(func.insts.get(*src as usize), Some(Inst::ImmData(_)));
                    if !to_result || !from_template {
                        say(format_args!(
                            "mcpy outside the aggregate return slot or non-template source"
                        ));
                        return false;
                    }
                }
            }
            Inst::LoadLocal { off, volatile, .. } => {
                // A relocated slot read (own local or frame-kept parameter
                // cell on the reloc path) is kept by the splice, and a
                // forwarded parameter cell's read resolves to the call-site
                // argument on either path. Otherwise the splice drops the
                // read, which is safe only when the result is dead in the
                // callee body and the access is not volatile (C99 5.1.2.3p2:
                // a volatile read is a side effect even when the value is
                // unused).
                let relocated = reloc && (*off < 0 || relocated_cells.contains(off));
                if !relocated && !forwarded.contains(off) && (used[idx] || *volatile) {
                    say(format_args!("live or volatile LoadLocal at v{}", idx));
                    return false;
                }
            }
            Inst::StoreLocal { off, volatile, .. } => {
                // A relocated slot write is kept by the splice. Otherwise the
                // store is dropped; a drop into a struct-parameter slot would
                // leave the redirected read stale, and a dropped volatile
                // store would elide a required access (C99 6.7.3p6).
                let relocated = reloc && (*off < 0 || relocated_cells.contains(off));
                if !relocated && (param_agg_slots.contains(off) || *volatile) {
                    say(format_args!(
                        "StoreLocal into a struct-parameter slot or volatile at v{}",
                        idx
                    ));
                    return false;
                }
            }
            // A non-leaf same-unit call is admitted when it returns no
            // aggregate: the splice reproduces it by copying the Call,
            // remapping its arguments and re-interning the layouts its
            // `arg_aggs` name (`rewrite_callee_inst`). `target_pc` names a
            // same-unit function and stays valid in the caller. An
            // aggregate return stays rejected -- it delivers into a caller
            // frame slot (`ret_slot_local`) the splice does not allocate.
            // A by-value aggregate argument needs no such slot: its address
            // is one more value operand, and the per-arch call plan lays
            // the bytes into the outgoing argument area. This lets a
            // dispatcher whose only non-purity is per-case calls inline; a
            // constant-argument switch it wraps then folds after the
            // splice, dropping an otherwise-live unreachable default.
            Inst::Call { ret_agg, .. } if ret_agg.is_none() => {}
            // A call through a function pointer in the same shape. The
            // target is one more value operand for the splice to remap;
            // the call is opaque -- the target is never spliced and runs
            // in a frame of its own -- so it constrains neither the
            // frame-region choice nor cycle membership (`region_key`).
            Inst::CallIndirect { ret_agg, .. } if ret_agg.is_none() => {}
            // A phi merging values across the callee's own blocks. The
            // multi-block splice translates its incoming values through
            // `callee_remap` and shifts its predecessor block ids into the
            // caller's post-splice numbering (`shift_callee_bid`).
            Inst::Phi { .. } => {}
            // Inline asm on the reloc path: `rewrite_callee_inst` remaps the
            // operand args -- an output's destination address among them --
            // and an asm-goto's `jump_tables` row clones into the caller. An
            // output address is then a relocated slot (own-local or parameter
            // cell, riding the slot relocation), a remapped pointer, or a
            // carried global, so no output escapes to a slot the splice
            // cannot write.
            //
            // A by-value aggregate parameter is the exception: its slot
            // redirects to the caller's argument address, so an asm operand
            // that writes through it would mutate the caller's object, which
            // by-value passing forbids (C99 6.5.2.2p4 -- the parameter is a
            // copy). Reject rather than splice.
            Inst::InlineAsm { asm, args } => {
                if !reloc {
                    say(format_args!("inline asm in a non-reloc callee"));
                    return false;
                }
                for (op, &a) in asm.operands.iter().zip(args.iter()) {
                    if !(op.is_output || matches!(op.constraint, AsmConstraint::Mem)) {
                        continue;
                    }
                    if let Some(Inst::LocalAddr(s)) = func.insts.get(a as usize)
                        && param_agg_slots.contains(s)
                    {
                        say(format_args!(
                            "asm output writes a by-value aggregate parameter"
                        ));
                        return false;
                    }
                }
            }
            // An intrinsic is a leaf the splice reproduces by an operand
            // remap (`rewrite_callee_inst`), like a Call. Admit all but the
            // frame-bound ones, whose result depends on the enclosing
            // frame / stack and cannot relocate into a caller. This inlines
            // an always_inline accessor holding `__builtin_unreachable` (an
            // `Intrinsic::Trap`), so an asm operand that is an integer-
            // constant-expression (C99 6.6) only after the constant argument
            // substitutes folds at the call site rather than failing an
            // out-of-line emit.
            Inst::Intrinsic { kind, .. } => {
                let frame_bound =
                    crate::c5::op::Intrinsic::from_i64(*kind).is_none_or(|i| i.is_frame_bound());
                if frame_bound {
                    say(format_args!("frame-bound intrinsic {kind}"));
                    return false;
                }
            }
            // A segment base is per-CPU state, not frame state, so a spliced
            // access has nothing frame-bound to relocate; `remap_inst_operands`
            // routes both variants' operands.
            Inst::SegLoad { .. } | Inst::SegStore { .. } => {}
            _ => {
                say(format_args!("disallowed inst {:?}", inst));
                return false;
            }
        }
    }
    true
}

/// Parameter cells (slots >= 2) whose first program-order access is the
/// walker's prologue spill: a `StoreLocal` of the cell's own `ParamRef`
/// (the i-th declared parameter sits at cell i + 2). Only such a cell
/// relocates into a caller frame slot at the splice with the kept spill
/// initializing the relocated slot from the remapped argument. A
/// stack-passed parameter's cell has no spill (the caller's
/// outgoing-argument slot arrives initialized); the splice materializes
/// it instead, synthesizing the store this spill provides
/// (`materialized_param_cells`).
fn spilled_param_cells(func: &FunctionSsa) -> BTreeSet<i64> {
    let mut seen: BTreeSet<i64> = BTreeSet::new();
    let mut spilled: BTreeSet<i64> = BTreeSet::new();
    for inst in &func.insts {
        let (cell, is_spill) = match inst {
            Inst::LocalAddr(s) if *s >= 2 => (*s, false),
            Inst::LoadLocal { off, .. } if *off >= 2 => (*off, false),
            Inst::StoreLocal { off, value, .. } if *off >= 2 => {
                let spill = matches!(
                    func.insts.get(*value as usize),
                    Some(Inst::ParamRef { idx, .. }) if *idx as i64 + 2 == *off
                );
                (*off, spill)
            }
            _ => continue,
        };
        if seen.insert(cell) && is_spill {
            spilled.insert(cell);
        }
    }
    spilled
}

/// Parameter cells (slots >= 2) whose reads the splice resolves to the
/// call-site argument, the way it resolves a `ParamRef`.
///
/// A parameter past the ABI's argument registers has no prologue spill:
/// the caller stores the argument's full 8-byte value into its outgoing
/// stack slot (System V AMD64 3.2.3 / AAPCS64 6.4.2) and the prologue
/// restripes those eight bytes into the cell, so the cell holds the
/// argument. Cell `k` holds argument `k - 2` -- the walker lays the cells
/// out in argument order and counts the hidden out-pointer of a
/// by-address struct return in `n_params`, which bounds the index because
/// every splice site passes at least that many arguments.
///
/// Read-only shapes only: a stored or address-taken cell needs frame
/// storage and is materialized instead (`materialized_param_cells`; the
/// spill defining `spilled_param_cells` is such a store, so all three
/// sets are disjoint). A floating-point read is out -- the body reads
/// the walker's entry conversion, not the raw cell. A cell whose reads
/// are all dead keeps the established drop. `used` is
/// `value_use_mask(func)`.
fn forwarded_param_cells(func: &FunctionSsa, used: &[bool]) -> BTreeSet<i64> {
    let mut live: BTreeSet<i64> = BTreeSet::new();
    let mut barred: BTreeSet<i64> = BTreeSet::new();
    for (idx, inst) in func.insts.iter().enumerate() {
        match inst {
            Inst::LocalAddr(s) if *s >= 2 => {
                barred.insert(*s);
            }
            Inst::StoreLocal { off, .. } if *off >= 2 => {
                barred.insert(*off);
            }
            Inst::LoadLocal {
                off,
                kind,
                volatile,
            } if *off >= 2 => {
                if *volatile
                    || matches!(kind, LoadKind::F32 | LoadKind::F64)
                    || *off - 2 >= func.n_params as i64
                {
                    barred.insert(*off);
                } else if used[idx] {
                    live.insert(*off);
                }
            }
            _ => {}
        }
    }
    live.difference(&barred).copied().collect()
}

/// Parameter cells (slots >= 2) without a prologue spill that the reloc
/// splice materializes: the cell relocates into a fresh caller slot and
/// the splice prefix synthesizes the initializing store the spill would
/// have provided, from the call-site argument. A stack-passed
/// parameter's cell arrives holding the argument's full eight bytes
/// (the caller's outgoing-argument store, System V AMD64 3.2.3 /
/// AAPCS64 6.4.2, restriped by the prologue), so an I64 store of the
/// argument reproduces the entry state; the body's accesses -- an
/// assignment among them -- then relocate with the cell.
///
/// Materialized are the cells forwarding cannot resolve (a store, a
/// taken address, or a volatile read) that carry an access the splice
/// must keep (a live or volatile access, or the taken address);
/// read-only cells stay forwarded and dead traffic keeps the
/// established drop. An FP-kind access reads the walker's entry
/// conversion rather than the raw cell, and a cell past the declared
/// parameters has no argument; both bar the cell. `used` is
/// `value_use_mask(func)`.
fn materialized_param_cells(func: &FunctionSsa, used: &[bool]) -> BTreeSet<i64> {
    let spilled = spilled_param_cells(func);
    let mut unforwardable: BTreeSet<i64> = BTreeSet::new();
    let mut kept: BTreeSet<i64> = BTreeSet::new();
    let mut barred: BTreeSet<i64> = BTreeSet::new();
    for (idx, inst) in func.insts.iter().enumerate() {
        let (cell, fp) = match inst {
            Inst::LocalAddr(s) if *s >= 2 => {
                unforwardable.insert(*s);
                kept.insert(*s);
                (*s, false)
            }
            Inst::StoreLocal {
                off,
                kind,
                volatile,
                ..
            } if *off >= 2 => {
                unforwardable.insert(*off);
                if *volatile {
                    kept.insert(*off);
                }
                (*off, matches!(kind, StoreKind::F32 | StoreKind::F64))
            }
            Inst::LoadLocal {
                off,
                kind,
                volatile,
            } if *off >= 2 => {
                if *volatile {
                    unforwardable.insert(*off);
                }
                if *volatile || used[idx] {
                    kept.insert(*off);
                }
                (*off, matches!(kind, LoadKind::F32 | LoadKind::F64))
            }
            _ => continue,
        };
        if fp || cell - 2 >= func.n_params as i64 {
            barred.insert(cell);
        }
    }
    unforwardable
        .intersection(&kept)
        .copied()
        .filter(|c| !barred.contains(c) && !spilled.contains(c))
        .collect()
}

/// Which instructions a block actually contains. Folding a constant
/// condition leaves the dead arm's instructions in the flat array with
/// no block naming them; a scan over the raw array would read code that
/// cannot execute -- as a body shape the splice must reproduce, or as a
/// use keeping a value alive.
fn in_block_mask(func: &FunctionSsa) -> Vec<bool> {
    let mut mask = vec![false; func.insts.len()];
    for blk in &func.blocks {
        for v in blk.inst_range.clone() {
            if let Some(slot) = mask.get_mut(v as usize) {
                *slot = true;
            }
        }
    }
    mask
}

/// Parameter cells a splice of `callee` has to give frame slots of its
/// own: those the body spills and then reads back through a slot, plus
/// the materialized cells, whose slot the splice initializes instead.
fn relocated_param_cells(
    callee: &FunctionSsa,
    callee_used: &[bool],
    materialized: &BTreeSet<i64>,
) -> BTreeSet<i64> {
    let spilled = spilled_param_cells(callee);
    let mut out: BTreeSet<i64> = callee
        .insts
        .iter()
        .enumerate()
        .filter_map(|(idx, inst)| match inst {
            Inst::LocalAddr(s) if *s >= 2 => Some(*s),
            Inst::LoadLocal { off, volatile, .. } | Inst::StoreLocal { off, volatile, .. }
                if *off >= 2 && (*volatile || callee_used[idx]) =>
            {
                Some(*off)
            }
            _ => None,
        })
        .filter(|s| spilled.contains(s))
        .collect();
    out.extend(materialized.iter().copied());
    out
}

/// Per-callee body facts the frame gates and the splice read. Each is
/// a pure function of the body, so the pass derives them once per
/// candidate per fixpoint iteration (the candidate bodies are the
/// iteration's immutable snapshot) instead of per caller and per call
/// site.
struct CalleeFacts {
    /// Parameter cells a splice gives frame slots of its own.
    relocated: BTreeSet<i64>,
    /// Cells in `relocated` without a prologue spill; the splice prefix
    /// synthesizes their initializing store from the call-site argument.
    materialized: BTreeSet<i64>,
    /// Parameter cells whose reads resolve to the call-site argument.
    forwarded: BTreeSet<i64>,
    /// Frame slots one splice relocates into the caller: the callee's
    /// own locals plus the parameter cells it keeps in the frame. A
    /// body that reads its parameters out of the argument values and
    /// holds nothing in the frame costs nothing.
    frame_cost: i64,
    /// Routed to the relocating splice (`needs_reloc_splice`).
    needs_reloc: bool,
}

/// Facts keyed by callee entry pc.
type FactsMap = BTreeMap<usize, CalleeFacts>;

#[cfg(test)]
thread_local! {
    /// Candidate entries the pass has materialized on this thread. Every
    /// candidate container goes through [`CandidatePool::build`], so this
    /// is the pass's whole candidate bookkeeping; a per-caller set would
    /// make it grow with callers x candidates. Read by the scaling test.
    static CANDIDATE_ENTRIES: core::cell::Cell<usize> = const { core::cell::Cell::new(0) };
}

/// One fixpoint iteration's candidate bodies under a single gate
/// combination, shared by every caller the gates admit. Building the
/// gated sets once per iteration keeps the pass off callers x
/// candidates. `build` is the only constructor, so the entry count it
/// records covers every candidate set the pass holds.
struct CandidatePool<'a> {
    map: BTreeMap<usize, &'a FunctionSsa>,
    /// Entry pcs of candidates whose loops were unrolled, at most two:
    /// a caller excludes only its own entry, so two settle the query.
    unrolled: Vec<usize>,
}

impl<'a> CandidatePool<'a> {
    fn build(src: &'a [FunctionSsa], keep: impl Fn(&FunctionSsa) -> bool) -> Self {
        let map: BTreeMap<usize, &'a FunctionSsa> = src
            .iter()
            .filter(|c| keep(c))
            .map(|c| (c.ent_pc, c))
            .collect();
        #[cfg(test)]
        CANDIDATE_ENTRIES.with(|n| n.set(n.get() + map.len()));
        let unrolled = map
            .iter()
            .filter(|(_, c)| c.did_unroll)
            .map(|(&pc, _)| pc)
            .take(2)
            .collect();
        CandidatePool { map, unrolled }
    }

    fn view(
        &self,
        exclude: usize,
        caller_section: Option<alloc::string::String>,
    ) -> CandidateSet<'_, 'a> {
        CandidateSet {
            pool: self,
            exclude,
            caller_section,
        }
    }
}

/// One caller's view of a pool. The caller's own entry is excluded:
/// splicing a self-recursive call would expand without bound. A callee
/// with an explicit section is visible only to callers placed in the
/// same section: its placement is a contract (the kernel's section
/// whitelists), which the splice would erase, so gcc keeps such calls
/// out of line too.
struct CandidateSet<'p, 'a> {
    pool: &'p CandidatePool<'a>,
    exclude: usize,
    caller_section: Option<alloc::string::String>,
}

impl<'a> CandidateSet<'_, 'a> {
    fn get(&self, pc: &usize) -> Option<&&'a FunctionSsa> {
        if *pc == self.exclude {
            None
        } else {
            self.pool
                .map
                .get(pc)
                .filter(|c| c.section.is_none() || c.section == self.caller_section)
        }
    }

    fn is_empty(&self) -> bool {
        !self.pool.map.keys().any(|&pc| pc != self.exclude)
    }

    fn any_unrolled(&self) -> bool {
        self.pool.unrolled.iter().any(|&pc| pc != self.exclude)
    }
}

/// A splice target: the callee body with the facts derived from it.
#[derive(Clone, Copy)]
struct Callee<'a> {
    body: &'a FunctionSsa,
    facts: &'a CalleeFacts,
}

fn callee_facts(callee: &FunctionSsa) -> CalleeFacts {
    let used = value_use_mask(callee);
    let materialized = materialized_param_cells(callee, &used);
    let relocated = relocated_param_cells(callee, &used, &materialized);
    let forwarded = forwarded_param_cells(callee, &used);
    let needs_reloc = needs_reloc_splice(callee, &used);
    let frame_cost = callee.locals + relocated.len() as i64;
    CalleeFacts {
        relocated,
        materialized,
        forwarded,
        frame_cost,
        needs_reloc,
    }
}

/// Per-value "referenced by an operand" mask: instruction operands,
/// terminator values (Return payload, Bz / Bnz cond), block exit
/// accumulators, and phi-incoming values all mark their value used.
fn value_use_mask(func: &FunctionSsa) -> Vec<bool> {
    let mut used = vec![false; func.insts.len()];
    let mark = |v: ValueId, used: &mut [bool]| {
        if v != NO_VALUE && (v as usize) < used.len() {
            used[v as usize] = true;
        }
    };
    let in_block = in_block_mask(func);
    // Routed through the exhaustive walker so a new variant cannot
    // leave its operands out of the mask.
    for (i, inst) in func.insts.iter().enumerate() {
        if !in_block[i] {
            continue;
        }
        inst.for_each_operand(|v| mark(v, &mut used));
    }
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
    used
}

/// Map a single operand `v` through `remap`. `NO_VALUE` stays.
#[inline]
pub(super) fn map_v(v: ValueId, remap: &[ValueId]) -> ValueId {
    if v == NO_VALUE || (v as usize) >= remap.len() {
        v
    } else {
        remap[v as usize]
    }
}

/// Map every value operand in `inst` through `remap`, in place. Routes
/// through the exhaustive walker: a variant missed here would silently
/// carry a foreign `ValueId` into the target function.
pub(super) fn remap_inst_operands(inst: &mut Inst, remap: &[ValueId]) {
    inst.for_each_operand_mut(|v| *v = map_v(*v, remap));
}

/// Translate a callee inst into the caller's value space. `ParamRef`
/// resolves to the matching call-site argument; every other operand
/// runs through `callee_remap`. `args` is already in the caller's
/// remapped space.
fn rewrite_callee_inst(
    inst: &Inst,
    args: &[ValueId],
    callee_remap: &[ValueId],
    agg_map: &[u32],
) -> Option<Inst> {
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
            // Every operand of a callee inst names a callee value, so the
            // whole inst routes through `callee_remap`. A `Phi` is handled
            // by the splice before it reaches here (its predecessor block
            // ids also need shifting).
            let mut copy = inst.clone();
            remap_inst_operands(&mut copy, callee_remap);
            remap_inst_agg_descs(&mut copy, agg_map);
            Some(copy)
        }
    }
}

/// Frame slots holding a by-value aggregate parameter's bytes. These are
/// `param_local_slots` entries: storage no instruction writes, filled by
/// the prologue from the incoming argument registers.
fn param_agg_slots(c: &FunctionSsa) -> BTreeSet<i64> {
    c.param_aggs
        .iter()
        .enumerate()
        .filter(|(_, a)| a.is_some())
        .filter_map(|(i, _)| c.param_local_slots.get(i).copied())
        .filter(|&s| s != 0)
        .collect()
}

/// Whether the splice must reproduce the prologue's copy of a by-value
/// aggregate argument into the parameter's cell, rather than binding the
/// cell to the caller's argument address.
///
/// Binding is the cheaper form and observationally equal while nothing
/// writes the caller's object for the body's duration (C99 6.5.2.2p4:
/// the parameter holds the argument's value as of the call). The pass
/// has no alias analysis, so any write the body makes outside its own
/// frame slots is taken to reach that object and forces the copy.
///
/// The match is exhaustive by design: a new instruction must be
/// classified here rather than defaulting to "cannot write".
fn needs_param_agg_copy(c: &FunctionSsa) -> bool {
    let agg_slots = param_agg_slots(c);
    if agg_slots.is_empty() {
        return false;
    }
    // An address the callee owns: one of its own frame slots. A bound
    // parameter cell names the caller's object, so it is not one.
    let own = |v: ValueId| {
        matches!(c.insts.get(v as usize),
            Some(Inst::LocalAddr(s)) if *s < 0 && !agg_slots.contains(s))
    };
    c.insts.iter().any(|i| match i {
        Inst::Store { addr, .. } | Inst::SegStore { addr, .. } => !own(*addr),
        Inst::Mcpy { dst, .. } => !own(*dst),
        // A scaled index can leave the base object.
        Inst::StoreIndexed { .. } => true,
        Inst::StoreLocal { off, .. } => agg_slots.contains(off),
        Inst::AtomicRmw { .. } | Inst::AtomicCas { .. } => true,
        Inst::Call { .. } | Inst::CallIndirect { .. } | Inst::CallExt { .. } | Inst::TailExt(_) => {
            true
        }
        // Extended asm writes through its output operands' destination
        // addresses; a `"memory"` clobber widens that to anything, and
        // stack-pointer asm is outside the model entirely.
        Inst::InlineAsm { asm, args } => {
            asm.clobber_memory
                || asm.references_sp()
                || asm
                    .operands
                    .iter()
                    .zip(args)
                    .any(|(o, &a)| o.is_output && !own(a))
        }
        Inst::Intrinsic { .. } => true,
        Inst::Imm(_)
        | Inst::ImmData(_)
        | Inst::ImmCode(_)
        | Inst::ImmExtCode(_)
        | Inst::BlockAddr(_)
        | Inst::LocalAddr(_)
        | Inst::TlsAddr(_)
        | Inst::Load { .. }
        | Inst::LoadLocal { .. }
        | Inst::LoadIndexed { .. }
        | Inst::SegLoad { .. }
        | Inst::Binop { .. }
        | Inst::BinopI { .. }
        | Inst::Fneg(_)
        | Inst::Fma { .. }
        | Inst::Extend { .. }
        | Inst::Bswap { .. }
        | Inst::FpCast { .. }
        | Inst::AllocaInit(_)
        | Inst::ParamRef { .. }
        | Inst::Phi { .. } => false,
    })
}

/// The argument list a splice binds the callee's parameters to, with
/// every by-value aggregate argument in address form.
///
/// There are two call-site forms for such an argument. Usually the
/// operand is the address of the caller's copy and `arg_aggs[i]` names
/// the layout the host ABI marshals it by. When the callee's declared
/// parameter list is not in scope at the call site -- a redeclaration
/// that drops it, or a call past the declared parameters -- the walker
/// instead loads the aggregate's single eightbyte into a machine word
/// and leaves `arg_aggs[i]` unset. The splice copies from the operand
/// into the parameter's cell, so it needs the address: recover the one
/// that load reads, which is the address of the caller's copy either
/// way.
///
/// `None` when a value-form argument is not a recoverable load, so the
/// caller declines the site rather than copying from a value where the
/// body needs an address.
fn splice_arg_addresses(
    insts: &[Inst],
    args: &[ValueId],
    arg_aggs: &[Option<u32>],
    callee: &FunctionSsa,
) -> Option<Vec<ValueId>> {
    // Parameters whose cell the splice fills from the argument; mirrors
    // the `param_slot_copy` list `splice_multi_block` builds.
    let copied = |i: usize| {
        callee.param_aggs.get(i).copied().flatten().is_some()
            && callee.param_local_slots.get(i).copied().unwrap_or(0) != 0
    };
    let value_form = |i: usize| copied(i) && arg_aggs.get(i).copied().flatten().is_none();
    if !(0..args.len()).any(value_form) {
        return Some(args.to_vec());
    }
    let mut out = args.to_vec();
    for (i, slot) in out.iter_mut().enumerate() {
        if !value_form(i) {
            continue;
        }
        // The value form is the walker's whole-eightbyte load off the
        // aggregate's address; any other shape leaves nothing to recover.
        match insts.get(*slot as usize) {
            Some(Inst::Load {
                addr,
                disp: 0,
                kind: LoadKind::I64,
                volatile: false,
                ..
            }) => *slot = *addr,
            _ => return None,
        }
        // The operand must not also reach a scalar read of the same
        // parameter, which would want the loaded word rather than the
        // address. The walker emits no such read for an aggregate
        // parameter; decline rather than rely on that.
        let scalar_read = callee.insts.iter().any(|c| match c {
            Inst::ParamRef { idx, .. } => *idx as usize == i,
            Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => *off - 2 == i as i64,
            _ => false,
        });
        if scalar_read {
            return None;
        }
    }
    Some(out)
}

/// Rewrite a spliced call's aggregate-layout indices from the callee's
/// `agg_descs` table into the caller's. `agg_descs` is per-function, so
/// a copied instruction that names a callee layout would otherwise
/// index whatever sits at that position in the caller.
fn remap_inst_agg_descs(inst: &mut Inst, agg_map: &[u32]) {
    let arg_aggs = match inst {
        Inst::Call { arg_aggs, .. }
        | Inst::CallIndirect { arg_aggs, .. }
        | Inst::CallExt { arg_aggs, .. } => arg_aggs,
        _ => return,
    };
    for a in arg_aggs.iter_mut().flatten() {
        *a = agg_map[*a as usize];
    }
}

/// Append the callee's aggregate layouts to the caller's table and
/// return the callee-index -> caller-index map [`remap_inst_agg_descs`]
/// rewrites through.
fn merge_agg_descs(
    caller: &mut Vec<crate::c5::ir::AggDesc>,
    callee: &[crate::c5::ir::AggDesc],
) -> Vec<u32> {
    let base = caller.len() as u32;
    caller.extend(callee.iter().cloned());
    (0..callee.len() as u32).map(|i| base + i).collect()
}

/// Rewrite block terminators through the caller's value remap.
pub(super) fn remap_terminator(term: &mut Terminator, remap: &[ValueId]) {
    match term {
        Terminator::Jmp(_)
        | Terminator::FallThrough(_)
        | Terminator::TailExt(_)
        | Terminator::AsmGoto { .. }
        | Terminator::Unreachable => {}
        Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
            *cond = map_v(*cond, remap);
        }
        Terminator::GotoIndirect { target } => {
            *target = map_v(*target, remap);
        }
        Terminator::JumpTable { idx, .. } => {
            *idx = map_v(*idx, remap);
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
///   by the new caller block count. A single callee `Return(v)`
///   becomes `Jmp(postfix)`; `v` (in the post-remap caller space)
///   feeds the call's old `ValueId` for every later use. With more than
///   one `Return`, each becomes `Jmp(join)` where a synthetic join block
///   holds a phi merging the per-return values; the phi feeds the call's
///   old `ValueId`, and the join branches to the postfix.
/// * an `AsmGoto` callee block keeps its terminator; its `jump_tables`
///   row is cloned into the caller with the successor block ids shifted.
/// Scalar (offset, width) pieces covering an aggregate's fields, for the
/// per-field copy an aggregate-returning splice emits. Non-overlapping
/// flat fields are used as-is so a caller's field read matches a piece
/// exactly; overlapping fields (a union) fall back to power-of-two
/// chunks of the merged ranges. A field whose size is not a load width
/// is chunked the same way. Padding bytes are not copied; they hold
/// unspecified values either way (C99 6.2.6.1p6).
/// Alignment an aggregate piece at `off` is proven to have, as
/// [`Inst::Load`] records it: zero when the object's own alignment
/// already covers the piece width.
fn piece_align(agg_align: u32, off: u32, size: u32) -> u8 {
    let at = crate::c5::codegen::offset_align(agg_align, off as i64);
    if at >= size { 0 } else { at as u8 }
}

fn agg_pieces(d: &crate::c5::ir::AggDesc) -> Vec<(u32, u32)> {
    let mut fields: Vec<(u32, u32)> = d.fields.iter().map(|f| (f.offset, f.size)).collect();
    fields.sort_unstable();
    fields.dedup();
    let overlap = fields.windows(2).any(|w| w[0].0 + w[0].1 > w[1].0);
    let ranges: Vec<(u32, u32)> = if overlap {
        // Merge into maximal covered ranges.
        let mut merged: Vec<(u32, u32)> = Vec::new();
        for &(off, size) in &fields {
            match merged.last_mut() {
                Some((_, end)) if off <= *end => *end = (*end).max(off + size),
                _ => merged.push((off, off + size)),
            }
        }
        merged.iter().map(|&(lo, hi)| (lo, hi - lo)).collect()
    } else {
        fields
    };
    let mut pieces = Vec::new();
    for (off, size) in ranges {
        if !overlap && matches!(size, 1 | 2 | 4 | 8) {
            pieces.push((off, size));
            continue;
        }
        let (mut at, end) = (off, off + size);
        while at < end {
            let mut w = 8u32;
            while w > 1 && (at % w != 0 || at + w > end) {
                w /= 2;
            }
            pieces.push((at, w));
            at += w;
        }
    }
    pieces
}

fn piece_kinds(size: u32) -> (LoadKind, StoreKind) {
    match size {
        1 => (LoadKind::U8, StoreKind::I8),
        2 => (LoadKind::U16, StoreKind::I16),
        4 => (LoadKind::U32, StoreKind::I32),
        _ => (LoadKind::I64, StoreKind::I64),
    }
}

fn splice_multi_block(
    caller: &mut FunctionSsa,
    callee: Callee<'_>,
    splice_block_idx: usize,
    call_pc: u32,
    call_args: &[ValueId],
    ret_slot: i64,
    placement: &mut SlotPlacement<'_>,
) {
    let Callee {
        body: callee,
        facts,
    } = callee;
    let SlotPlacement {
        regions,
        cyclic,
        sp_tainted,
    } = placement;
    let n_caller = caller.blocks.len();
    let n_callee = callee.blocks.len();
    let prefix_id = splice_block_idx as u32;
    let postfix_id = (splice_block_idx + 1) as u32;
    // For an aggregate-returning callee the postfix block opens with a
    // per-field copy from the returned address into the caller's return
    // slot -- the register transfer a non-inlined call performs. The call
    // result has no scalar value (the caller reads its own slot), so
    // `remap[call_pc]` stays NO_VALUE.
    let ret_pieces: Option<Vec<(u32, u32)>> = callee
        .ret_agg
        .map(|i| agg_pieces(&callee.agg_descs[i as usize]));
    // The pieces are read from the caller's object, so its own
    // alignment bounds each read; the return slot they land in is a
    // frame slot and needs no bound.
    let ret_align: u32 = callee
        .ret_agg
        .map_or(0, |i| callee.agg_descs[i as usize].align);
    // Frame slots holding a register-passed struct parameter's bytes,
    // mapped to (parameter index, layout). The cell relocates into the
    // caller frame with the callee's other own locals; the prefix copies
    // the argument into it, which is what the prologue does out of line.
    // `splice_arg_addresses` normalised each such argument to the address
    // of the caller's copy, so it is the copy's source. A cell the body
    // never names is unobservable and takes no copy.
    let names_slot = |s: i64| {
        callee.insts.iter().any(|i| match i {
            Inst::LocalAddr(o)
            | Inst::LoadLocal { off: o, .. }
            | Inst::StoreLocal { off: o, .. } => *o == s,
            _ => false,
        })
    };
    let param_slot_copy: Vec<(i64, usize, u32)> = if needs_param_agg_copy(callee) {
        callee
            .param_aggs
            .iter()
            .enumerate()
            .filter_map(|(i, a)| a.map(|d| (i, d)))
            .filter_map(|(i, d)| callee.param_local_slots.get(i).map(|&s| (s, i, d)))
            .filter(|&(s, ..)| s != 0 && names_slot(s))
            .collect()
    } else {
        Vec::new()
    };
    // Cells with no copy bind to the caller's argument instead; the body's
    // `LocalAddr(slot)` reads resolve to it and no instruction is emitted.
    let param_slot_arg: BTreeMap<i64, usize> = if param_slot_copy.is_empty() {
        callee
            .param_aggs
            .iter()
            .enumerate()
            .filter(|(_, a)| a.is_some())
            .filter_map(|(i, _)| callee.param_local_slots.get(i).map(|&s| (s, i)))
            .filter(|&(s, _)| s != 0)
            .collect()
    } else {
        BTreeMap::new()
    };
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
    // Multiple returns route through a synthetic join block appended after
    // the callee blocks; its phi merges the per-return values -- for an
    // aggregate return, the per-return result addresses the postfix copy
    // reads. A void multi-return has no value to merge and needs no join.
    // A single return keeps the direct `Jmp(postfix)`.
    let n_returns = callee
        .blocks
        .iter()
        .filter(|b| matches!(b.terminator, Terminator::Return(_)))
        .count();
    let non_void_return = callee
        .blocks
        .iter()
        .any(|b| matches!(b.terminator, Terminator::Return(v) if v != NO_VALUE));
    let use_join = n_returns > 1 && non_void_return;
    let join_id = callee_block_base + n_callee as u32;
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
            Terminator::Unreachable => Terminator::Unreachable,
            Terminator::GotoIndirect { target } => Terminator::GotoIndirect {
                target: map_v(target, remap),
            },
            // The caller's own asm-goto and switch rows are shifted in
            // `merged_jump_tables` with the table index kept, so both
            // terminators carry their index through unchanged.
            Terminator::AsmGoto { table } => Terminator::AsmGoto { table },
            Terminator::JumpTable { idx, table } => Terminator::JumpTable {
                idx: map_v(idx, remap),
                table,
            },
        }
    };

    let mut original = core::mem::take(caller);
    let agg_map = merge_agg_descs(&mut original.agg_descs, &callee.agg_descs);
    let splice_block = original.blocks[splice_block_idx].clone();
    // Frame-kept parameter cells -- the cell's address is taken, an access
    // is volatile, or an access whose value the body consumes -- relocate
    // into fresh caller slots below the callee's relocated own locals. A
    // spilled cell's kept prologue spill (`StoreLocal` of the `ParamRef`,
    // first access by construction) initializes the relocated cell with
    // the remapped argument value; a materialized cell has no spill and
    // the prefix synthesizes that store instead. A cell touched only by
    // dead non-volatile accesses keeps the established drop.
    let param_cells = &facts.relocated;
    let materialized = &facts.materialized;
    // Parameter cells whose reads resolve to the call-site argument
    // instead of a frame slot; disjoint from `param_cells`.
    let forwarded = &facts.forwarded;
    // Region backing the callee's relocated slots, shared across call
    // sites when sound (see `CallerRegions`). A cycle member appends, and
    // so does any splice whose caller or callee can come to execute
    // stack-pointer asm (`sp_asm_reachers`): a stack switch lets a spliced
    // activation stay live -- suspended mid-body on another stack -- while
    // the caller proceeds to further sites, so no two sites may share.
    let needed = callee.locals + param_cells.len() as i64;
    let region_base = if needed > 0 {
        // A copy that may gain a direct call through the devirt sweep
        // must not share the pool (see `splice_may_gain_direct_call`).
        let key = region_key(original.ent_pc, callee, cyclic, sp_tainted).map(|k| {
            if matches!(k, RegionKey::Pool)
                && splice_may_gain_direct_call(callee, call_args, &original.insts)
            {
                RegionKey::Callee(callee.ent_pc)
            } else {
                k
            }
        });
        regions.place(key, needed, original.locals)
    } else {
        original.locals
    };
    let param_cell_reloc: alloc::collections::BTreeMap<i64, i64> = param_cells
        .iter()
        .enumerate()
        .map(|(i, &s)| (s, -(region_base + callee.locals + i as i64 + 1)))
        .collect();
    // Caller's own asm-goto rows precede the callee's in `merged_jump_tables`;
    // a spliced callee `AsmGoto { table }` re-indexes to `caller_jt_len + table`.
    let caller_jt_len = original.jump_tables.len() as u32;

    let mut new_insts: Vec<Inst> = Vec::with_capacity(original.insts.len() + callee.insts.len());
    let mut new_inst_src: Vec<(u32, u32)> = Vec::with_capacity(new_insts.capacity());
    let mut new_f32: Vec<bool> = Vec::with_capacity(new_insts.capacity());
    let mut new_blocks: Vec<Block> = Vec::with_capacity(n_caller + n_callee + 1);
    let mut remap: Vec<ValueId> = vec![NO_VALUE; original.insts.len()];
    let mut callee_remap: Vec<ValueId> = vec![NO_VALUE; callee.insts.len()];
    // First new-inst id of the spliced callee body (Step 6, emitted last).
    // Callee phis are shifted at emission; the post-fixpoint caller-phi
    // shift skips this tail so it does not double-shift them. Assigned on
    // every fixpoint pass (Step 6 precedes the loop's breaks).
    let callee_insts_start: u32;

    let emit_caller_inst = |pc: u32,
                            new_insts: &mut Vec<Inst>,
                            new_inst_src: &mut Vec<(u32, u32)>,
                            new_f32: &mut Vec<bool>,
                            remap: &mut [ValueId],
                            original: &mut FunctionSsa| {
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
        // The emission runs once and `original` is dropped afterward:
        // move the instruction out rather than deep-cloning its
        // operand vectors.
        let mut mapped = core::mem::replace(&mut original.insts[pc as usize], Inst::Imm(0));
        remap_inst_operands(&mut mapped, remap);
        // `&&label` names a block, not a value, so the value remap leaves
        // it alone; it moves with the splice's block-id shift.
        if let Inst::BlockAddr(b) = &mut mapped {
            *b = shift_caller_bid(*b);
        }
        let new_id = new_insts.len() as u32;
        debug_assert_eq!(remap[pc as usize], new_id);
        remap[pc as usize] = new_id;
        new_insts.push(mapped);
        new_inst_src.push(src);
        new_f32.push(f32);
    };

    // Neither block array is ordered definitions-before-uses, and the
    // call result's mapping only materializes when the callee's Return
    // is spliced (Step 6) -- after Step 4 already emitted the caller
    // blocks that follow the splice point. The emission order and the
    // per-site emit counts never depend on mapped values, so every new
    // id is position arithmetic: assign the complete value maps up
    // front, then emit once. The emission re-derives each id and
    // debug-asserts it matches the assignment.
    // First new-inst id of the aggregate-return postfix copy (the
    // `LocalAddr(ret_slot)` + per-piece load/store run opening the postfix
    // block), and the id of the join phi it reads for a multi-return
    // callee. Assigned by the counting pass below.
    let mut pieces_base: u32 = 0;
    let mut agg_join_phi: ValueId = NO_VALUE;
    {
        let mut at: u32 = 0;
        let count = |pc: u32, remap: &mut [ValueId], at: &mut u32| {
            remap[pc as usize] = *at;
            *at += 1;
        };
        for block in original.blocks.iter().take(splice_block_idx) {
            for pc in block.inst_range.clone() {
                count(pc, &mut remap, &mut at);
            }
        }
        for pc in splice_block.inst_range.start..call_pc {
            count(pc, &mut remap, &mut at);
        }
        // The by-value aggregate parameter copies close the prefix block:
        // a `LocalAddr` of the relocated cell plus the `Mcpy` per parameter.
        at += 2 * param_slot_copy.len() as u32;
        // One synthesized initializing store per materialized cell.
        at += materialized.len() as u32;
        // The aggregate-return copy opens the postfix block: one
        // `LocalAddr(ret_slot)` plus a load and a store per piece. The ids
        // are position arithmetic like everything else; only the copy's own
        // stores reference them.
        if let Some(pieces) = &ret_pieces {
            pieces_base = at;
            at += 1 + 2 * pieces.len() as u32;
        }
        for pc in (call_pc + 1)..splice_block.inst_range.end {
            count(pc, &mut remap, &mut at);
        }
        for block in original.blocks.iter().skip(splice_block_idx + 1) {
            for pc in block.inst_range.clone() {
                count(pc, &mut remap, &mut at);
            }
        }
        let counted_args: Vec<ValueId> = call_args.iter().map(|&a| map_v(a, &remap)).collect();
        for cblock in &callee.blocks {
            for ce_pc in cblock.inst_range.clone() {
                match &callee.insts[ce_pc as usize] {
                    Inst::ParamRef { idx, kind } => {
                        let arg = counted_args.get(*idx as usize).copied().unwrap_or(NO_VALUE);
                        callee_remap[ce_pc as usize] = if param_read_insts(*kind) == 0 {
                            arg
                        } else {
                            at += 1;
                            at - 1
                        };
                    }
                    // A forwarded parameter cell's read takes the same
                    // width conversion against the call-site argument.
                    Inst::LoadLocal { off, kind, .. } if forwarded.contains(off) => {
                        let arg = counted_args
                            .get((*off - 2) as usize)
                            .copied()
                            .unwrap_or(NO_VALUE);
                        callee_remap[ce_pc as usize] = if param_read_insts(*kind) == 0 {
                            arg
                        } else {
                            at += 1;
                            at - 1
                        };
                    }
                    // A bound parameter cell resolves to the caller's
                    // argument; no instruction is emitted for it.
                    Inst::LocalAddr(s) if param_slot_arg.contains_key(s) => {
                        callee_remap[ce_pc as usize] = counted_args
                            .get(param_slot_arg[s])
                            .copied()
                            .unwrap_or(NO_VALUE);
                    }
                    Inst::LocalAddr(s) if *s < 0 || *s >= 2 => {
                        callee_remap[ce_pc as usize] = at;
                        at += 1;
                    }
                    Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. }
                        if *off < 0 || param_cell_reloc.contains_key(off) =>
                    {
                        callee_remap[ce_pc as usize] = at;
                        at += 1;
                    }
                    Inst::LoadLocal { .. } | Inst::StoreLocal { .. } | Inst::AllocaInit(_) => {
                        callee_remap[ce_pc as usize] = NO_VALUE;
                    }
                    _ => {
                        callee_remap[ce_pc as usize] = at;
                        at += 1;
                    }
                }
            }
        }
        // The call result. One return maps directly; multiple feed the
        // join phi, whose id is one past the spliced callee body -- the
        // current `at`, since Step 6 emits exactly that many callee insts
        // and the phi is pushed right after. A void multi-return has no
        // value. An aggregate return has no scalar result either -- the
        // postfix copy writes the caller's return slot -- but its
        // multi-return join phi (over the result addresses) sits at the
        // same reserved id.
        if ret_pieces.is_some() {
            if use_join {
                agg_join_phi = at;
            }
        } else if use_join {
            remap[call_pc as usize] = at;
        } else {
            for cblock in &callee.blocks {
                if let Terminator::Return(v) = cblock.terminator {
                    remap[call_pc as usize] = map_v(v, &callee_remap);
                }
            }
        }
    }
    // Source address the aggregate-return copy reads: the single Return's
    // mapped result address, or the join phi merging the per-return
    // addresses. Resolvable here because the counting pass above assigned
    // the complete callee map.
    let agg_ret_src: ValueId = if ret_pieces.is_some() {
        if use_join {
            agg_join_phi
        } else {
            let mut src = NO_VALUE;
            for cblock in &callee.blocks {
                if let Terminator::Return(v) = cblock.terminator {
                    src = map_v(v, &callee_remap);
                }
            }
            src
        }
    } else {
        NO_VALUE
    };
    {
        // Step 1: caller blocks 0..splice_block_idx (unchanged).
        for b_idx in 0..splice_block_idx {
            let blk = &original.blocks[b_idx];
            let (rng, term0, exit0, start_pc) = (
                blk.inst_range.clone(),
                blk.terminator,
                blk.exit_acc,
                blk.start_pc,
            );
            let block_start = new_insts.len() as u32;
            for pc in rng {
                emit_caller_inst(
                    pc,
                    &mut new_insts,
                    &mut new_inst_src,
                    &mut new_f32,
                    &mut remap,
                    &mut original,
                );
            }
            let term = map_terminator_caller(term0, &remap);
            let exit_acc = map_v(exit0, &remap);
            new_blocks.push(Block {
                start_pc,
                inst_range: block_start..new_insts.len() as u32,
                terminator: term,
                exit_acc,
            });
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
                &mut original,
            );
        }
        // The prologue's copy of each by-value aggregate argument into the
        // parameter's cell, reproduced here because the splice removes the
        // prologue. C99 6.5.2.2p4: the parameter holds the argument's value
        // as of the call, so the body must not read the caller's object --
        // which a write through another pointer into it would change.
        for &(slot, i, desc) in &param_slot_copy {
            let src = call_args
                .get(i)
                .map(|&a| map_v(a, &remap))
                .unwrap_or(NO_VALUE);
            let d = &callee.agg_descs[desc as usize];
            let dst = new_insts.len() as u32;
            new_insts.push(Inst::LocalAddr(slot - region_base));
            new_inst_src.push((0, 0));
            new_f32.push(false);
            // The type's alignment is the bound both endpoints are known
            // to meet: the destination is a frame slot and the source is
            // the caller's object of this type.
            new_insts.push(Inst::Mcpy {
                dst,
                src,
                size: d.size as i64,
                align: d.align,
            });
            new_inst_src.push((0, 0));
            new_f32.push(false);
        }
        // The initializing store a materialized cell's missing prologue
        // spill would have provided: the argument occupies its outgoing
        // stack slot as a full eight-byte value, so an I64 store of the
        // call-site argument reproduces the cell's entry state.
        for &cell in materialized.iter() {
            let value = call_args
                .get((cell - 2) as usize)
                .map(|&a| map_v(a, &remap))
                .unwrap_or(NO_VALUE);
            new_insts.push(Inst::StoreLocal {
                off: param_cell_reloc[&cell],
                value,
                kind: StoreKind::I64,
                volatile: false,
            });
            new_inst_src.push((0, 0));
            new_f32.push(false);
        }
        let callee_entry_new_id = callee_block_base;
        new_blocks.push(Block {
            start_pc: splice_block.start_pc,
            inst_range: prefix_start..new_insts.len() as u32,
            terminator: Terminator::Jmp(callee_entry_new_id),
            exit_acc: NO_VALUE,
        });
        let _ = prefix_id;

        // Step 3: postfix block (the splice block's insts after the call).
        // Emitted here, in block-index order, so every block's inst_range
        // tiles `new_insts` contiguously and ascending -- the invariant the
        // flat splice and the liveness/reg-alloc value-id ordering rely on.
        // The call result feeds these insts; its remap is set when the
        // callee Return is spliced (Step 6) and resolves across the
        // emission fixpoint, one forward-reference level per pass.
        let postfix_start = new_insts.len() as u32;
        // Aggregate-return copy: read each piece from the returned address
        // (`agg_ret_src`, assigned by the counting pass) and store it into
        // the caller's return slot. All loads precede all stores so an
        // overlapping source (the callee returning through a pointer into
        // the caller's own slot) copies correctly, matching the register
        // transfer of a non-inlined call.
        if let Some(pieces) = &ret_pieces {
            debug_assert_eq!(postfix_start, pieces_base);
            let la = new_insts.len() as u32;
            new_insts.push(Inst::LocalAddr(ret_slot));
            new_inst_src.push((0, 0));
            new_f32.push(false);
            let mut loaded: Vec<ValueId> = Vec::with_capacity(pieces.len());
            for &(off, size) in pieces.iter() {
                let (lk, _) = piece_kinds(size);
                loaded.push(new_insts.len() as u32);
                new_insts.push(Inst::Load {
                    addr: agg_ret_src,
                    disp: off as i32,
                    kind: lk,
                    volatile: false,
                    align: piece_align(ret_align, off, size),
                });
                new_inst_src.push((0, 0));
                new_f32.push(false);
            }
            for (&(off, size), &lv) in pieces.iter().zip(&loaded) {
                let (_, sk) = piece_kinds(size);
                new_insts.push(Inst::Store {
                    addr: la,
                    disp: off as i32,
                    value: lv,
                    kind: sk,
                    volatile: false,
                    align: 0,
                });
                new_inst_src.push((0, 0));
                new_f32.push(false);
            }
        }
        for pc in (call_pc + 1)..splice_block.inst_range.end {
            emit_caller_inst(
                pc,
                &mut new_insts,
                &mut new_inst_src,
                &mut new_f32,
                &mut remap,
                &mut original,
            );
        }
        let postfix_term = match splice_block.terminator {
            Terminator::FallThrough(b) => Terminator::Jmp(shift_caller_bid(b)),
            other => map_terminator_caller(other, &remap),
        };
        let postfix_exit_acc = map_v(splice_block.exit_acc, &remap);
        new_blocks.push(Block {
            start_pc: 0,
            inst_range: postfix_start..new_insts.len() as u32,
            terminator: postfix_term,
            exit_acc: postfix_exit_acc,
        });
        let _ = postfix_id;

        // Step 4: caller blocks splice_block_idx+1..n_caller (shifted +1).
        for b_idx in (splice_block_idx + 1)..original.blocks.len() {
            let blk = &original.blocks[b_idx];
            let (rng, term0, exit0, start_pc) = (
                blk.inst_range.clone(),
                blk.terminator,
                blk.exit_acc,
                blk.start_pc,
            );
            let block_start = new_insts.len() as u32;
            for pc in rng {
                emit_caller_inst(
                    pc,
                    &mut new_insts,
                    &mut new_inst_src,
                    &mut new_f32,
                    &mut remap,
                    &mut original,
                );
            }
            let term = map_terminator_caller(term0, &remap);
            let exit_acc = map_v(exit0, &remap);
            new_blocks.push(Block {
                start_pc,
                inst_range: block_start..new_insts.len() as u32,
                terminator: term,
                exit_acc,
            });
        }

        // Step 5: remap the call's args through the caller's now-built remap.
        let remapped_args: Vec<ValueId> = call_args.iter().map(|&a| map_v(a, &remap)).collect();

        // Step 6: splice every callee block. A multi-return callee
        // collects each return's (predecessor block, value) for the join
        // phi emitted after the loop.
        callee_insts_start = new_insts.len() as u32;
        let mut phi_incoming: Vec<(BlockId, ValueId)> = Vec::new();
        for (ci, cblock) in callee.blocks.iter().enumerate() {
            let block_start = new_insts.len() as u32;
            for ce_pc in cblock.inst_range.start..cblock.inst_range.end {
                let cinst = &callee.insts[ce_pc as usize];
                match cinst {
                    Inst::Phi { incoming, kind } => {
                        // Reproduce the phi in the caller: incoming values
                        // route through `callee_remap`; predecessor block ids
                        // shift into the caller's post-splice numbering.
                        let new_incoming = incoming
                            .iter()
                            .map(|&(pred, v)| (shift_callee_bid(pred), map_v(v, &callee_remap)))
                            .collect();
                        let new_id = new_insts.len() as u32;
                        callee_remap[ce_pc as usize] = new_id;
                        new_insts.push(Inst::Phi {
                            incoming: new_incoming,
                            kind: *kind,
                        });
                        new_inst_src.push((0, 0));
                        new_f32.push(
                            callee
                                .f32_values
                                .get(ce_pc as usize)
                                .copied()
                                .unwrap_or(false),
                        );
                        continue;
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
                            (0, 0),
                            &mut new_insts,
                            &mut new_inst_src,
                            &mut new_f32,
                        );
                        continue;
                    }
                    // A forwarded parameter cell: the argument value the
                    // caller would have placed in its outgoing stack slot,
                    // taking the read's width conversion.
                    Inst::LoadLocal { off, kind, .. } if forwarded.contains(off) => {
                        let arg = remapped_args
                            .get((*off - 2) as usize)
                            .copied()
                            .unwrap_or(NO_VALUE);
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
                    // A bound parameter cell resolves to the caller's
                    // argument, mirroring the counting pass.
                    Inst::LocalAddr(s) if param_slot_arg.contains_key(s) => {
                        callee_remap[ce_pc as usize] = remapped_args
                            .get(param_slot_arg[s])
                            .copied()
                            .unwrap_or(NO_VALUE);
                        continue;
                    }
                    // A relocated slot access: a callee own local (negative)
                    // shifts below the caller's own locals; a materialized
                    // parameter cell takes its fresh slot from
                    // `param_cell_reloc`. The remaining cells (0, 1, dead
                    // parameter spills) and the alloca init carry no live
                    // value into the body and are dropped.
                    Inst::LocalAddr(s) if *s < 0 || *s >= 2 => {
                        let slot = if *s < 0 {
                            s - region_base
                        } else {
                            param_cell_reloc[s]
                        };
                        callee_remap[ce_pc as usize] = new_insts.len() as u32;
                        new_insts.push(Inst::LocalAddr(slot));
                        new_inst_src.push((0, 0));
                        new_f32.push(false);
                        continue;
                    }
                    Inst::LoadLocal {
                        off,
                        kind,
                        volatile,
                    } if *off < 0 || param_cell_reloc.contains_key(off) => {
                        let off = if *off < 0 {
                            off - region_base
                        } else {
                            param_cell_reloc[off]
                        };
                        callee_remap[ce_pc as usize] = new_insts.len() as u32;
                        new_insts.push(Inst::LoadLocal {
                            off,
                            kind: *kind,
                            volatile: *volatile,
                        });
                        new_inst_src.push((0, 0));
                        new_f32.push(
                            callee
                                .f32_values
                                .get(ce_pc as usize)
                                .copied()
                                .unwrap_or(false),
                        );
                        continue;
                    }
                    Inst::StoreLocal {
                        off,
                        value,
                        kind,
                        volatile,
                    } if *off < 0 || param_cell_reloc.contains_key(off) => {
                        let off = if *off < 0 {
                            off - region_base
                        } else {
                            param_cell_reloc[off]
                        };
                        callee_remap[ce_pc as usize] = new_insts.len() as u32;
                        new_insts.push(Inst::StoreLocal {
                            off,
                            value: map_v(*value, &callee_remap),
                            kind: *kind,
                            volatile: *volatile,
                        });
                        new_inst_src.push((0, 0));
                        new_f32.push(false);
                        continue;
                    }
                    Inst::LoadLocal { .. } | Inst::StoreLocal { .. } | Inst::AllocaInit(_) => {
                        callee_remap[ce_pc as usize] = NO_VALUE;
                        continue;
                    }
                    _ => {}
                }
                if let Some(translated) =
                    rewrite_callee_inst(cinst, &remapped_args, &callee_remap, &agg_map)
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
                    let rv = map_v(v, &callee_remap);
                    if use_join {
                        phi_incoming.push((shift_callee_bid(ci as u32), rv));
                        Terminator::Jmp(join_id)
                    } else {
                        // An aggregate return leaves the call's remap at
                        // NO_VALUE: the postfix copy reads `rv` and the
                        // caller consumes its own return slot.
                        if ret_pieces.is_none() {
                            remap[call_pc as usize] = rv;
                        }
                        Terminator::Jmp(postfix_id)
                    }
                }
                // A block sealed after a noreturn call: no successor, no
                // value; carry it through unchanged (no block id to shift).
                Terminator::Unreachable => Terminator::Unreachable,
                Terminator::TailExt(_) => unreachable!("filter rejects TailExt"),
                Terminator::GotoIndirect { .. } => {
                    unreachable!("filter rejects GotoIndirect")
                }
                Terminator::JumpTable { .. } => {
                    unreachable!("filter rejects JumpTable")
                }
                // The callee row is appended after the caller's own rows in
                // `merged_jump_tables`; the successors it names shift into
                // caller space there. The template's label refs resolve
                // through that row at emit.
                Terminator::AsmGoto { table } => Terminator::AsmGoto {
                    table: caller_jt_len + table,
                },
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

        // Multi-return join: a phi merges each return's value into the call
        // result, then branches to the postfix. The phi lands one id past
        // the spliced callee body, matching the pre-pass reservation. The
        // integer kind is safe -- an FP multi-return callee is rejected.
        if use_join {
            let phi_id = new_insts.len() as u32;
            debug_assert_eq!(
                phi_id,
                if ret_pieces.is_some() {
                    agg_join_phi
                } else {
                    remap[call_pc as usize]
                }
            );
            new_insts.push(Inst::Phi {
                incoming: phi_incoming,
                kind: LoadKind::I64,
            });
            new_inst_src.push((0, 0));
            new_f32.push(false);
            new_blocks.push(Block {
                start_pc: 0,
                inst_range: phi_id..new_insts.len() as u32,
                terminator: Terminator::Jmp(postfix_id),
                exit_acc: phi_id,
            });
        }
    }

    // Remap surviving caller phis' incoming predecessor block ids across
    // the block-id shift the splice introduced. A predecessor at or past
    // the splice block moves up by one: blocks after the splice shift +1,
    // and the splice block's own out-edges now leave from the postfix
    // (splice_block_idx + 1), not the prefix. `emit_caller_inst` clones
    // phis from the original with their block ids intact, so this reads the
    // original ids once after the emission fixpoint. Only caller-origin
    // phis (below `callee_insts_start`) take this shift; spliced callee
    // phis had their predecessors mapped through `shift_callee_bid` at
    // emission (Step 6) and must not shift again.
    let splice_bid = splice_block_idx as u32;
    for inst in new_insts[..callee_insts_start as usize].iter_mut() {
        if let Inst::Phi { incoming, .. } = inst {
            for (pred, _) in incoming.iter_mut() {
                if *pred >= splice_bid {
                    *pred += 1;
                }
            }
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

    // Relocate the callee's own local slots into the caller frame region
    // at `region_base` (Step 6 shifts each slot by it; relocated parameter
    // cells follow below the shifted locals); grow the frame and carry the
    // callee's multi-cell (struct/union) slot records at their shifted
    // ids, skipping the duplicates a shared region re-records per site. A
    // callee with no locals leaves everything alone.
    let merged_locals = original.locals.max(region_base + needed);
    let mut merged_multi_cell = original.multi_cell_slots;
    for &(slot, size) in &callee.multi_cell_slots {
        let rec = (slot - region_base, size);
        if !merged_multi_cell.contains(&rec) {
            merged_multi_cell.push(rec);
        }
    }
    // Merge the callee's over-aligned region (16-aligned only; the candidate
    // filter rejects above 16) behind the caller's: the callee's packed
    // offsets shift by the caller's region size, a 16-byte multiple, so every
    // member keeps a 16-aligned base. A shared per-callee record replays the
    // same relocated slots at a later site; those entries already exist and
    // grow nothing.
    let mut merged_over_aligned = core::mem::take(&mut original.over_aligned);
    let mut merged_frame_align = original.frame_align;
    let mut merged_region_bytes = original.realign_region_bytes;
    if !callee.over_aligned.is_empty() {
        let base_off = merged_region_bytes;
        let mut appended = false;
        for &(slot, region_off) in &callee.over_aligned {
            let rec = (slot - region_base, base_off + region_off);
            if !merged_over_aligned.iter().any(|&(s, _)| s == rec.0) {
                merged_over_aligned.push(rec);
                appended = true;
            }
        }
        if appended {
            merged_frame_align = merged_frame_align.max(callee.frame_align);
            merged_region_bytes += callee.realign_region_bytes;
        }
    }

    // Shift the caller's own rows -- switch tables and asm-goto edge
    // lists alike -- across the block-id shift, then append the callee's,
    // shifted into the caller's post-splice block space. The filter
    // rejects JumpTable / GotoIndirect callees, so every callee row is an
    // asm-goto edge list.
    let mut merged_jump_tables: Vec<Vec<BlockId>> = original
        .jump_tables
        .iter()
        .map(|row| row.iter().map(|&b| shift_caller_bid(b)).collect())
        .collect();
    for row in &callee.jump_tables {
        merged_jump_tables.push(row.iter().map(|&b| shift_callee_bid(b)).collect());
    }

    *caller = FunctionSsa {
        name: original.name,
        ent_pc: original.ent_pc,
        end_pc: original.end_pc,
        locals: merged_locals,
        n_params: original.n_params,
        is_variadic: original.is_variadic,
        is_inline: original.is_inline,
        is_always_inline: original.is_always_inline,
        is_noinline: original.is_noinline,
        section: original.section,
        is_naked: original.is_naked,
        is_weak: original.is_weak,
        is_internal: original.is_internal,
        const_params: original.const_params,
        insts: new_insts,
        inst_src: new_inst_src,
        blocks: new_blocks,
        extern_call_refs: call_refs,
        extern_imm_code_refs: code_refs,
        extern_imm_data_refs: data_refs,
        extern_tls_refs: tls_refs,
        f32_values: new_f32,
        param_fp_mask: original.param_fp_mask,
        // The caller's own layouts, plus the callee's (merged above so a
        // spliced call's `arg_aggs` can name them).
        agg_descs: original.agg_descs,
        param_aggs: original.param_aggs,

        param_local_slots: original.param_local_slots,
        ret_agg: original.ret_agg,
        ret_is_fp: original.ret_is_fp,
        ret_type_tag: original.ret_type_tag,
        indirect_result_slot: original.indirect_result_slot,
        computed_goto_targets: original
            .computed_goto_targets
            .iter()
            .map(|&b| shift_caller_bid(b))
            .collect(),
        label_data_relocs: original
            .label_data_relocs
            .iter()
            .map(|r| crate::c5::ir::LabelDataReloc {
                block: shift_caller_bid(r.block),
                ..*r
            })
            .collect(),
        // The filter rejects JumpTable / GotoIndirect callees; only an
        // asm-goto callee's rows join the caller's own (`merged_jump_tables`).
        jump_tables: merged_jump_tables,
        synthetic_base: original.synthetic_base,
        multi_cell_slots: merged_multi_cell,
        over_aligned: merged_over_aligned,
        frame_align: merged_frame_align,
        realign_region_bytes: merged_region_bytes,
        // The candidate filter rejects returns-twice callees, so only
        // the caller's own flag can be set here.
        has_returns_twice_call: original.has_returns_twice_call,
        did_unroll: original.did_unroll,
        did_inline: original.did_inline,
    };
}

/// Resolve a callee parameter read of `kind` -- a `ParamRef(idx, kind)`
/// or a forwarded parameter cell's `LoadLocal { kind }` -- to a caller
/// value, reproducing the width conversion the non-inlined read performs
/// on the caller's full-width argument value. A signed narrow read
/// sign-extends (`movsx` / `sxtw`), an unsigned narrow read zero-extends
/// (`movzx` / `ldrb`), and the 64-bit and FP kinds take the value
/// unchanged (an FP argument is converted at the call site). `arg` may be
/// `NO_VALUE` on an early flat-splice fixpoint pass and resolves on a
/// later one, so the conversion is emitted unconditionally to keep
/// emission structurally identical across passes -- `param_read_insts`
/// reports how many instructions that is.
fn splice_param_ref(
    kind: LoadKind,
    arg: ValueId,
    src_pos: (u32, u32),
    new_insts: &mut Vec<Inst>,
    new_inst_src: &mut Vec<(u32, u32)>,
    new_f32: &mut Vec<bool>,
) -> ValueId {
    let inst = match kind {
        LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => Inst::Extend { value: arg, kind },
        LoadKind::U8 | LoadKind::U16 | LoadKind::U32 => Inst::BinopI {
            op: BinOp::And,
            lhs: arg,
            rhs_imm: match kind {
                LoadKind::U8 => 0xff,
                LoadKind::U16 => 0xffff,
                _ => 0xffff_ffff,
            },
        },
        LoadKind::I64 | LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => {
            return arg;
        }
    };
    let id = new_insts.len() as u32;
    new_insts.push(inst);
    new_inst_src.push(src_pos);
    new_f32.push(false);
    id
}

/// Instructions `splice_param_ref` emits for `kind`; the multi-block
/// splice's value-id counting pass reserves exactly this many.
fn param_read_insts(kind: LoadKind) -> u32 {
    match kind {
        LoadKind::I64 | LoadKind::F32 | LoadKind::F64 => 0,
        _ => 1,
    }
}

/// The frame slot holding a single-block callee's returned aggregate,
/// under either return convention. The flat splice redirects that one
/// slot -- to the call site's return slot for a host-ABI return, to the
/// hidden out-pointer argument for a c5 by-address return -- so it is the
/// only own local the flat path can reproduce.
fn flat_result_slot(c: &FunctionSsa) -> Option<i64> {
    if c.blocks.len() != 1 {
        return None;
    }
    if c.ret_agg.is_none() {
        return out_ptr_return(c).map(|o| o.slot);
    }
    let Terminator::Return(rv) = c.blocks[0].terminator else {
        return None;
    };
    match c.insts.get(rv as usize) {
        Some(Inst::LocalAddr(s)) => Some(*s),
        _ => None,
    }
}

/// Whether a single-block callee must go through `splice_multi_block`
/// rather than the flat single-block path. The flat path never allocates
/// a caller slot, so a body that takes the address of an own local -- an
/// asm output written through it, an aggregate the body builds in the
/// frame before copying it out -- needs the relocation the multi-block
/// splice performs, and so does a parameter cell kept in the frame
/// (spilled and read back, or materialized from the argument). The one
/// exception is the slot a flat aggregate return redirects to the
/// caller's return slot. Multi-block callees always take that path
/// regardless; this only reclassifies single-block ones, and
/// `is_inline_candidate` derives its `reloc` gate from the same
/// predicate. `used` is `value_use_mask(c)`.
fn needs_reloc_splice(c: &FunctionSsa, used: &[bool]) -> bool {
    if c.blocks.len() != 1 {
        return false;
    }
    if c.insts.iter().any(|i| matches!(i, Inst::InlineAsm { .. })) {
        return true;
    }
    // A by-value aggregate parameter's cell that needs the argument copy
    // is relocated into the caller frame and filled there, which only the
    // relocating path emits. A cell that binds to the argument instead
    // needs nothing this path does not already provide.
    if needs_param_agg_copy(c) {
        return true;
    }
    let materialized = materialized_param_cells(c, used);
    if !relocated_param_cells(c, used, &materialized).is_empty() {
        return true;
    }
    let result = flat_result_slot(c);
    c.insts
        .iter()
        .any(|i| matches!(i, Inst::LocalAddr(s) if *s < 0 && Some(*s) != result))
}

/// Splice eligible call sites in `caller` with the bodies named by
/// `callees`. Modifies `caller` in place.
fn inline_caller(
    caller: &mut FunctionSsa,
    callees: &CandidateSet<'_, '_>,
    facts: &FactsMap,
    placement: &mut SlotPlacement<'_>,
) {
    // No live call names a candidate, so neither splice path can fire.
    // Both walks below rebuild the whole body before reaching that
    // conclusion; the scan reaches it in one pass over the tape.
    if !caller.blocks.iter().any(|b| {
        (b.inst_range.start..b.inst_range.end).any(|pc| {
            matches!(&caller.insts[pc as usize],
                Inst::Call { target_pc, .. } if callees.get(target_pc).is_some())
        })
    }) {
        return;
    }
    // A spliced call's `arg_aggs` names its own function's layouts, so
    // each candidate's table merges into the caller's once -- before the
    // fixpoint walk below, which re-emits the body every pass.
    let called: BTreeSet<usize> = caller
        .insts
        .iter()
        .filter_map(|i| match i {
            Inst::Call { target_pc, .. } if callees.get(target_pc).is_some() => Some(*target_pc),
            _ => None,
        })
        .collect();
    let agg_maps: BTreeMap<usize, Vec<u32>> = called
        .into_iter()
        .map(|pc| {
            let descs = callees
                .get(&pc)
                .map(|c| c.agg_descs.clone())
                .unwrap_or_default();
            (pc, merge_agg_descs(&mut caller.agg_descs, &descs))
        })
        .collect();
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
                        arg_aggs,
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
                        // An aggregate-returning callee's result slot
                        // redirects to the site's return slot; without one
                        // the redirect has no destination.
                        .filter(|c| c.ret_agg.is_none() || *ret_slot_local != 0)
                        .and_then(|c| {
                            splice_arg_addresses(&caller.insts, args, arg_aggs, c)
                                .map(|a| (*c, a, *ret_slot_local, *target_pc))
                        }),
                    _ => None,
                };
                // Multi-block callees, and single-block callees whose asm /
                // own-local accesses need relocation, are handled by
                // `splice_multi_block` after this block-walk pass exits via
                // the early-return below. Skip them on the flat path here and
                // let the call survive the local walk; the multi-block pass
                // runs once over the whole function.
                let inlined =
                    inlined.filter(|(c, ..)| c.blocks.len() == 1 && !facts[&c.ent_pc].needs_reloc);
                if let Some((callee, call_args, ret_slot, callee_pc)) = inlined {
                    let agg_map: &[u32] = agg_maps
                        .get(&callee_pc)
                        .map(|m| m.as_slice())
                        .unwrap_or(&[]);
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
                    // A by-address return instead redirects its result slot
                    // to the hidden out-pointer argument (the caller's own
                    // object), which makes the body's trailing copy into
                    // that pointer a self-copy the splice drops.
                    let out_ptr = out_ptr_return(callee);
                    // A register-passed struct parameter is read in the
                    // body through `LocalAddr(slot)`; map each such slot to
                    // its parameter index so the splice binds it to the
                    // caller's argument address (`splice_arg_addresses`
                    // established that the argument is one). A cell needing
                    // the argument copy instead takes the relocating path,
                    // which `needs_reloc_splice` routes it to.
                    debug_assert!(
                        !needs_param_agg_copy(callee),
                        "flat splice reached a callee whose parameter cell needs the argument copy"
                    );
                    let param_slot_arg: BTreeMap<i64, usize> = callee
                        .param_aggs
                        .iter()
                        .enumerate()
                        .filter(|(_, a)| a.is_some())
                        .filter_map(|(i, _)| callee.param_local_slots.get(i).map(|&s| (s, i)))
                        .filter(|&(s, _)| s != 0)
                        .collect();
                    // Parameter cells whose reads resolve to the call-site
                    // argument rather than being dropped with the rest of
                    // the cell traffic.
                    let forwarded = &facts[&callee.ent_pc].forwarded;
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
                                if out_ptr.as_ref().is_some_and(|o| o.slot == *s) {
                                    callee_remap[ce_pc as usize] =
                                        remapped_args.first().copied().unwrap_or(NO_VALUE);
                                    continue;
                                }
                            }
                            // The trailing by-address return copy: source and
                            // destination are now the caller's one object.
                            Inst::Mcpy { .. }
                                if out_ptr.as_ref().is_some_and(|o| o.copy == ce_pc) =>
                            {
                                callee_remap[ce_pc as usize] = NO_VALUE;
                                continue;
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
                            // A forwarded parameter cell: the argument value
                            // the caller would have placed in its outgoing
                            // stack slot, taking the read's width conversion.
                            Inst::LoadLocal { off, kind, .. } if forwarded.contains(off) => {
                                let arg = remapped_args
                                    .get((*off - 2) as usize)
                                    .copied()
                                    .unwrap_or(NO_VALUE);
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
                            rewrite_callee_inst(cinst, &remapped_args, &callee_remap, agg_map)
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
                    remap_inst_operands(&mut mapped, &remap);
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

    let has_multiblock_call = caller.blocks.iter().any(|b| {
        (b.inst_range.start..b.inst_range.end).any(|pc| {
            matches!(&caller.insts[pc as usize],
                Inst::Call { target_pc, args, ret_slot_local, .. }
                if callees.get(target_pc).is_some_and(|c| (c.blocks.len() > 1
                    || facts[target_pc].needs_reloc)
                    && args.len() >= c.n_params
                    && (c.ret_agg.is_none() || *ret_slot_local != 0)))
        })
    });
    if !any_change && !has_multiblock_call {
        return;
    }

    // Commit the flat single-block splice only when it inlined something.
    // With no flat inline the fixpoint above ran a single pass and broke,
    // so `new_insts` carries unresolved forward references (a loop
    // back-edge phi's incoming value stays NO_VALUE); committing it would
    // corrupt the caller. Leave the caller body untouched in that case and
    // let the multi-block splice loop below operate on the original body.
    if any_change {
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
    }

    // Single-block flat splice complete. Now find any remaining
    // multi-block inlinable Call sites and apply the multi-block
    // splice one at a time. Each splice re-shapes the caller's
    // blocks so the loop re-scans from scratch after every step.
    // Bounded by a generous step cap to keep runaway expansion in
    // check.
    // `splice_multi_block` shifts caller block ids > the splice point.
    // Every block-id reference the caller can hold moves with it: phi
    // incoming predecessors and `Inst::BlockAddr` inside the splice,
    // `computed_goto_targets` and the `jump_tables` rows behind a
    // `JumpTable` (switch) or `AsmGoto` terminator on the way out. So any
    // caller shape is spliceable.
    let mut steps = 0usize;
    // Callees this caller can no longer afford: every splice through this
    // loop relocates the callee's slots into the caller's frame, and the
    // absolute frame bound is enforced here rather than on the round's
    // candidate set, because a splice exposes the callee's own call sites
    // and a pre-round count cannot see them. A mandatory request is
    // exempt; the probed prologue keeps the result safe.
    let mut unaffordable: BTreeSet<usize> = BTreeSet::new();
    while steps < MAX_MULTI_BLOCK_SPLICE_STEPS {
        let mut hit: Option<(usize, u32, &FunctionSsa, Vec<ValueId>, i64)> = None;
        'find: for (b_idx, block) in caller.blocks.iter().enumerate() {
            for pc in block.inst_range.start..block.inst_range.end {
                if let Inst::Call {
                    target_pc,
                    args,
                    arg_aggs,
                    ret_slot_local,
                    ..
                } = &caller.insts[pc as usize]
                    && let Some(c) = callees.get(target_pc)
                    && !unaffordable.contains(target_pc)
                    && (c.blocks.len() > 1 || facts[target_pc].needs_reloc)
                    // Same argument-count guard as the single-block path;
                    // an aggregate-returning callee also needs the site's
                    // return slot for the postfix copy.
                    && args.len() >= c.n_params
                    && (c.ret_agg.is_none() || *ret_slot_local != 0)
                {
                    if !c.is_always_inline
                        && caller.locals + facts[target_pc].frame_cost > CALLER_FRAME_ABS_SLOTS
                    {
                        unaffordable.insert(*target_pc);
                        continue;
                    }
                    // A value-form aggregate argument the splice cannot
                    // resolve to an address leaves the site out of line.
                    let Some(bound) = splice_arg_addresses(&caller.insts, args, arg_aggs, c) else {
                        continue;
                    };
                    hit = Some((b_idx, pc, *c, bound, *ret_slot_local));
                    break 'find;
                }
            }
        }
        let Some((b_idx, pc, callee, args, ret_slot)) = hit else {
            break;
        };
        #[cfg(feature = "codegen_test")]
        if std::env::var("BADC_LOG_INLINE").is_ok() {
            eprintln!(
                "[inline] MULTIBLOCK splice callee={cn} ({cb} blks) into caller={n}",
                cn = callee.name,
                cb = callee.blocks.len(),
                n = caller.name
            );
        }
        splice_multi_block(
            caller,
            Callee {
                body: callee,
                facts: &facts[&callee.ent_pc],
            },
            b_idx,
            pc,
            &args,
            ret_slot,
            placement,
        );
        steps += 1;
    }
}

/// Inline eligible callees across every function in `funcs`. A
/// callee is eligible per `is_inline_candidate`; `cap == 0` disables
/// the splicing but not the devirtualization sweep. `code_syms` maps
/// each parser-symbol index defined here as a function to its ent_pc
/// (see `devirtualize_indirect_calls`).
pub(crate) fn run(funcs: &mut [FunctionSsa], cap: u32, abi: Abi, code_syms: &BTreeMap<u32, usize>) {
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
    // Pair up `CallIndirect` sites with the `ImmCode` targets already on
    // the tape before candidacy is evaluated; the sweep is independent of
    // the splicing below, so it runs even with inlining disabled.
    let sp_tainted = crate::c5::ir::sp_asm_reachers(funcs);
    devirtualize_indirect_calls(funcs, &sp_tainted, &BTreeMap::new(), code_syms);
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
    // Pre-inline state driving the frame gates and region reuse: the
    // per-caller locals snapshot, call-cycle membership, stack-pointer-asm
    // taint, and the per-caller region records. Both sets stay exact
    // across the run: splicing only moves bodies along existing edges,
    // and the devirt sweep admits no edge that reaches stack-pointer asm
    // or closes a cycle.
    let orig_locals: Vec<i64> = funcs.iter().map(|f| f.locals).collect();
    let cyclic = call_cycle_members(funcs);
    let mut regions: BTreeMap<usize, CallerRegions> = BTreeMap::new();
    // Iterate to a fixed point: each pass re-evaluates candidacy on
    // the now-substituted function bodies, so a helper that became a
    // leaf after its own sub-calls were inlined becomes eligible on
    // the next round. `INLINE_FIXPOINT_ITERS` bounds the depth.
    for iter in 0..INLINE_FIXPOINT_ITERS {
        // Pair up `CallIndirect` sites the previous round's splices put
        // next to an `ImmCode` argument, so the devirtualized call is an
        // inline candidate this round.
        if iter > 0 {
            devirtualize_indirect_calls(funcs, &sp_tainted, &regions, code_syms);
        }
        // The splice reads each callee's pre-iteration body while the
        // callers are rewritten in place, so the candidates -- and only
        // they -- are copied; a body no call site can splice is never
        // read.
        let bodies: Vec<FunctionSsa> = funcs
            .iter()
            .filter(|f| is_inline_candidate(f, cap, abi, None))
            .cloned()
            .collect();
        if bodies.is_empty() {
            break;
        }
        // The candidate bodies are fixed for this iteration, so their
        // splice facts are derived once here rather than per caller and
        // per call site.
        let facts: FactsMap = bodies.iter().map(|c| (c.ent_pc, callee_facts(c))).collect();
        // The two caller gates below are predicates over the candidate
        // body alone, so each combination they select is one shared pool
        // rather than a per-caller copy of the candidate map.
        let marked = |c: &FunctionSsa| c.is_inline;
        let frame_free = |c: &FunctionSsa| c.is_always_inline || facts[&c.ent_pc].frame_cost == 0;
        let pools = [
            CandidatePool::build(&bodies, |_| true),
            CandidatePool::build(&bodies, marked),
            CandidatePool::build(&bodies, frame_free),
            CandidatePool::build(&bodies, |c| marked(c) && frame_free(c)),
        ];
        #[cfg(feature = "codegen_test")]
        if trace {
            eprintln!(
                "[inline] iter={iter} cap={cap} funcs={n} candidates={c}",
                n = funcs.len(),
                c = pools[0].map.len(),
            );
            for (pc, f) in &pools[0].map {
                eprintln!(
                    "[inline] candidate ent_pc={pc} name={n} insts={i}",
                    n = f.name,
                    i = f.insts.len()
                );
            }
        }
        let mut changed = false;
        for (fi, caller) in funcs.iter_mut().enumerate() {
            // A self-recursive caller's frame is paid once per recursion
            // level, so inlining that inflates it costs stack in proportion
            // to the depth -- a per-callee body cap is not enough. Once such
            // a caller's frame has grown past RECURSIVE_FRAME_SLOTS, keep
            // only callees the source explicitly marked `inline`; a shallow
            // recursion that only absorbs a leaf-sized helper stays under
            // the threshold and is unaffected. A non-recursive caller is
            // bounded by the cumulative code-growth budget instead, so small
            // fragments cannot compound across the fixpoint into a function
            // whose frame overflows a small stack. Both budgets are runtime
            // stack / code-size heuristics, not a codegen bound: a marked
            // callee is admitted at any caller size, and the frame it grows
            // is representable up to the backends' addressable maximum,
            // which the per-function emit checks and reports.
            let recursive = caller
                .insts
                .iter()
                .any(|i| matches!(i, Inst::Call { target_pc, .. } if *target_pc == caller.ent_pc));
            let only_marked = (recursive && caller.locals > RECURSIVE_FRAME_SLOTS)
                || caller.insts.len() > CALLER_INST_BUDGET;
            // Once a caller's frame has grown past CALLER_FRAME_SLOTS and
            // multiplied its pre-inline size, keep a mandatory request and
            // any candidate whose splice relocates no frame slots -- the
            // gate bounds frame growth, and such a candidate causes none.
            // The absolute bound is enforced per splice (see
            // `inline_caller_multi_block`), where the growth is known
            // exactly.
            let only_frame_free = caller.locals > CALLER_FRAME_SLOTS
                && caller.locals > orig_locals[fi].saturating_mul(FRAME_GROWTH_FACTOR);
            // Splicing a self-recursive call would expand indefinitely,
            // so the caller's own entry is excluded from its view.
            let local = pools[usize::from(only_marked) | (usize::from(only_frame_free) << 1)]
                .view(caller.ent_pc, caller.section.clone());
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
            // entry valid. Multi-block splicing shifts block ids and
            // carries each of those reference sets across the shift.
            let before = caller.insts.len();
            inline_caller(
                caller,
                &local,
                &facts,
                &mut SlotPlacement {
                    regions: regions.entry(caller.ent_pc).or_default(),
                    cyclic: &cyclic,
                    sp_tainted: &sp_tainted,
                },
            );
            if caller.insts.len() != before {
                changed = true;
                // The splice relocated the callee's own local slots into
                // this caller's frame; mark it so the post-inline mem2reg
                // re-run promotes any now-address-free single-width slot.
                caller.did_inline = true;
                // A spliced callee whose loops were unrolled carries
                // constant-offset array accesses into the caller; mark
                // the caller so the post-inline scalar promotion scans it.
                if local.any_unrolled() {
                    caller.did_unroll = true;
                }
            }
        }
        if !changed {
            break;
        }
        let _ = iter;
    }
    // Pairs the final round's splices created have had no sweep yet.
    devirtualize_indirect_calls(funcs, &sp_tainted, &regions, code_syms);
    // Surface a mandatory inline request the pass could not honour. The
    // detection is factored into `unhonoured_always_inline` so it is
    // unit-testable without capturing stderr.
    #[cfg(feature = "std")]
    for (i, reason) in unhonoured_always_inline(funcs, cap, abi) {
        eprintln!(
            "badc: warning: `{name}` is marked always_inline but was not inlined: {reason}",
            name = funcs[i].name,
        );
    }
}

/// Standalone devirtualization sweep for after the inline run: the
/// post-inline promotions (mem2reg on spliced callers, sroa) turn
/// function-pointer cells into `ImmCode` values and expose pairs the
/// in-run sweeps could not see. No splicing follows, so no region
/// record constrains the rewrite; the remaining guards are those of
/// `devirtualize_indirect_calls`.
pub(crate) fn devirtualize(funcs: &mut [FunctionSsa], code_syms: &BTreeMap<u32, usize>) {
    let sp_tainted = crate::c5::ir::sp_asm_reachers(funcs);
    devirtualize_indirect_calls(funcs, &sp_tainted, &BTreeMap::new(), code_syms);
}

/// Return `(index, reason)` for each function marked always_inline /
/// `__forceinline` that the pass could not inline: its shape keeps it out
/// of the candidate set and at least one call to it remains un-inlined.
/// An uncalled callee is omitted -- nothing needed inlining. The reason
/// mirrors the candidate filter's rejection.
#[cfg(feature = "std")]
fn unhonoured_always_inline(
    funcs: &[FunctionSsa],
    cap: u32,
    abi: Abi,
) -> Vec<(usize, alloc::string::String)> {
    let mut out = Vec::new();
    for i in 0..funcs.len() {
        if !funcs[i].is_always_inline {
            continue;
        }
        let mut reason = alloc::string::String::new();
        if is_inline_candidate(&funcs[i], cap, abi, Some(&mut reason)) {
            continue;
        }
        let ent_pc = funcs[i].ent_pc;
        let still_called = funcs.iter().any(|g| {
            g.insts
                .iter()
                .any(|inst| matches!(inst, Inst::Call { target_pc, .. } if *target_pc == ent_pc))
        });
        if still_called {
            out.push((i, reason));
        }
    }
    out
}

#[cfg(all(test, feature = "std"))]
mod tests {
    use super::*;
    use crate::c5::codegen::Target;

    fn call_to(target_pc: usize) -> Inst {
        Inst::Call {
            target_pc,
            args: Vec::new(),
            fixed_args: 0,
            fp_return: false,
            fp_arg_mask: 0,
            arg_aggs: Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        }
    }

    /// Single-block asm callee writing an output through an own local
    /// (reloc-splice shape) with `locals` frame slots.
    fn asm_callee(ent_pc: usize, locals: i64) -> FunctionSsa {
        asm_callee_with_template(ent_pc, locals, b"mov %0, 1")
    }

    fn asm_callee_with_template(ent_pc: usize, locals: i64, template: &[u8]) -> FunctionSsa {
        use crate::c5::ir::{AsmBlock, AsmConstraint, AsmOperand, AsmSeg};
        let insts = alloc::vec![
            Inst::LocalAddr(-1),
            Inst::InlineAsm {
                asm: alloc::boxed::Box::new(AsmBlock {
                    template: template.to_vec(),
                    operands: alloc::vec![AsmOperand {
                        constraint: AsmConstraint::Reg,
                        is_output: true,
                        is_rw: false,
                        width: 8,
                        seg: AsmSeg::None,
                    }],
                    clobber_regs: 0,
                    clobber_fp_regs: 0,
                    clobber_memory: false,
                    volatile: false,
                }),
                args: alloc::vec![0],
            },
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::I64,
                volatile: false,
            },
        ];
        FunctionSsa {
            ent_pc,
            locals,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..insts.len() as u32,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
            insts,
            ..Default::default()
        }
    }

    /// Two-block callee with `locals` slots whose body keeps a call to
    /// `inner_pc` (splices through the multi-block path; the inner call
    /// survives when `inner_pc` is not a candidate).
    fn calling_callee(ent_pc: usize, locals: i64, inner_pc: usize) -> FunctionSsa {
        let insts = alloc::vec![
            Inst::Imm(5),
            Inst::StoreLocal {
                off: -1,
                value: 0,
                kind: StoreKind::I64,
                volatile: false,
            },
            call_to(inner_pc),
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::I64,
                volatile: false,
            },
        ];
        FunctionSsa {
            ent_pc,
            locals,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            blocks: alloc::vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..3,
                    terminator: Terminator::Jmp(1),
                    exit_acc: NO_VALUE,
                },
                Block {
                    start_pc: 0,
                    inst_range: 3..4,
                    terminator: Terminator::Return(3),
                    exit_acc: 3,
                },
            ],
            insts,
            ..Default::default()
        }
    }

    /// Caller with `n_calls` sequential calls to `target_pc` and `locals`
    /// own slots.
    fn multi_call_caller(
        ent_pc: usize,
        locals: i64,
        target_pc: usize,
        n_calls: usize,
    ) -> FunctionSsa {
        let mut insts: Vec<Inst> = (0..n_calls).map(|_| call_to(target_pc)).collect();
        insts.push(Inst::Imm(0));
        let n = insts.len() as u32;
        FunctionSsa {
            ent_pc,
            locals,
            inst_src: alloc::vec![(0, 0); n as usize],
            f32_values: alloc::vec![false; n as usize],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: Terminator::Return(n - 1),
                exit_acc: n - 1,
            }],
            insts,
            ..Default::default()
        }
    }

    /// A call-free (pooled) callee spliced at 8 sites grows the caller's
    /// frame by one region, not one per site.
    #[test]
    fn callfree_region_pools_across_sites() {
        let abi = Target::LinuxX64.abi();
        let mut funcs = alloc::vec![multi_call_caller(1, 2, 100, 8), asm_callee(100, 4),];
        run(&mut funcs, 32, abi, &BTreeMap::new());
        assert!(
            funcs[0]
                .insts
                .iter()
                .all(|i| !matches!(i, Inst::Call { .. })),
            "all 8 sites must inline"
        );
        assert_eq!(
            funcs[0].locals, 6,
            "8 splices of a 4-slot call-free callee must add one 4-slot region"
        );
    }

    /// A call-bearing callee off every call cycle reuses one per-callee
    /// region across its sites.
    #[test]
    fn offcycle_callee_region_reused_across_sites() {
        let abi = Target::LinuxX64.abi();
        let mut funcs = alloc::vec![multi_call_caller(1, 2, 200, 2), calling_callee(200, 3, 999),];
        run(&mut funcs, 32, abi, &BTreeMap::new());
        let inner_calls = funcs[0]
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::Call { target_pc, .. } if *target_pc == 999))
            .count();
        assert_eq!(inner_calls, 2, "both spliced bodies keep the inner call");
        assert_eq!(
            funcs[0].locals, 5,
            "2 splices of a 3-slot off-cycle callee must share one region"
        );
    }

    /// A callee whose only call is indirect shares a region across its
    /// sites: the target is never spliced and runs in a frame of its
    /// own, so the call is opaque like an external one -- neither a
    /// cycle member nor a stack-pointer taint source.
    #[test]
    fn indirect_call_callee_shares_region_across_sites() {
        let abi = Target::LinuxX64.abi();
        let insts = alloc::vec![
            Inst::Imm(5),
            Inst::StoreLocal {
                off: -1,
                value: 0,
                kind: StoreKind::I64,
                volatile: false,
            },
            Inst::Imm(0x4000),
            Inst::CallIndirect {
                target: 2,
                args: alloc::vec![],
                callee_variadic: false,
                fixed_args: 0,
                fp_return: false,
                fp_arg_mask: 0,
                arg_aggs: alloc::vec![],
                ret_agg: None,
                ret_slot_local: 0,
            },
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::I64,
                volatile: false,
            },
        ];
        let callee = FunctionSsa {
            ent_pc: 200,
            locals: 3,
            inst_src: alloc::vec![(0, 0); 5],
            f32_values: alloc::vec![false; 5],
            blocks: alloc::vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..4,
                    terminator: Terminator::Jmp(1),
                    exit_acc: NO_VALUE,
                },
                Block {
                    start_pc: 0,
                    inst_range: 4..5,
                    terminator: Terminator::Return(4),
                    exit_acc: 4,
                },
            ],
            insts,
            ..Default::default()
        };
        let mut funcs = alloc::vec![multi_call_caller(1, 2, 200, 2), callee];
        run(&mut funcs, 32, abi, &BTreeMap::new());
        let indirect = funcs[0]
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::CallIndirect { .. }))
            .count();
        assert_eq!(indirect, 2, "both spliced bodies keep the indirect call");
        assert_eq!(
            funcs[0].locals, 5,
            "2 splices of a 3-slot indirect-calling callee must share one region"
        );
    }

    /// A callee on a call cycle appends a region per site: a later round
    /// can splice its mutual-recursion partner -- and with it another
    /// activation of the callee -- inside a prior body, so its regions
    /// never share.
    #[test]
    fn cycle_member_regions_append_per_site() {
        let abi = Target::LinuxX64.abi();
        let partner = FunctionSsa {
            ent_pc: 400,
            is_variadic: true,
            insts: alloc::vec![call_to(300), Inst::Imm(0)],
            inst_src: alloc::vec![(0, 0); 2],
            f32_values: alloc::vec![false; 2],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..2,
                terminator: Terminator::Return(1),
                exit_acc: 1,
            }],
            ..Default::default()
        };
        let mut funcs = alloc::vec![
            multi_call_caller(1, 2, 300, 2),
            calling_callee(300, 2, 400),
            partner,
        ];
        run(&mut funcs, 32, abi, &BTreeMap::new());
        assert_eq!(
            funcs[0].locals, 6,
            "2 splices of a 2-slot cycle member must append 2 regions"
        );
    }

    /// The caller frame gate: once a caller's locals exceed both bounds,
    /// an optional callee that relocates frame slots is no longer
    /// spliced. A mandatory request is honoured, and so is a callee that
    /// relocates no slots -- the gate bounds frame growth, which such a
    /// callee does not cause.
    #[test]
    fn caller_frame_gate_blocks_optional_inlining() {
        let abi = Target::LinuxX64.abi();
        for always in [false, true] {
            for leaf_locals in [0, 4] {
                let leaf = FunctionSsa {
                    ent_pc: 600,
                    is_inline: always,
                    is_always_inline: always,
                    locals: leaf_locals,
                    insts: alloc::vec![Inst::Imm(7)],
                    inst_src: alloc::vec![(0, 0)],
                    f32_values: alloc::vec![false],
                    blocks: alloc::vec![Block {
                        start_pc: 0,
                        inst_range: 0..1,
                        terminator: Terminator::Return(0),
                        exit_acc: 0,
                    }],
                    ..Default::default()
                };
                // Iteration 1 splices the 400-slot callee (gate not yet
                // hit), materializing its inner call; iteration 2
                // re-checks the gate at 402 slots.
                let mut funcs = alloc::vec![
                    multi_call_caller(1, 2, 500, 1),
                    calling_callee(500, 400, 600),
                    leaf,
                ];
                run(&mut funcs, 32, abi, &BTreeMap::new());
                let leaf_calls = funcs[0]
                    .insts
                    .iter()
                    .filter(|i| matches!(i, Inst::Call { target_pc, .. } if *target_pc == 600))
                    .count();
                assert_eq!(
                    leaf_calls,
                    usize::from(!always && leaf_locals > 0),
                    "always={always} leaf_locals={leaf_locals}: \
                     gate must block exactly the optional frame-growing case"
                );
            }
        }
    }

    /// The absolute frame bound: a callee whose relocated slots would
    /// carry the caller's region past one page is not spliced, even though
    /// the caller's frame has not grown relative to its pre-inline size,
    /// so the relative gate never fires. A mandatory request is still
    /// honoured.
    #[test]
    fn caller_frame_absolute_bound_blocks_optional_inlining() {
        let abi = Target::LinuxX64.abi();
        for always in [false, true] {
            // The same shape the relative-gate test uses, whose 400-slot
            // callee is spliced in the first round; here the callee's own
            // slots alone cross the absolute bound, so the caller's
            // starting frame is irrelevant and the relative gate cannot be
            // what blocks it.
            let mut callee = calling_callee(500, CALLER_FRAME_ABS_SLOTS + 1, 600);
            callee.is_inline = always;
            callee.is_always_inline = always;
            let leaf = FunctionSsa {
                ent_pc: 600,
                insts: alloc::vec![Inst::Imm(7)],
                inst_src: alloc::vec![(0, 0)],
                f32_values: alloc::vec![false],
                blocks: alloc::vec![Block {
                    start_pc: 0,
                    inst_range: 0..1,
                    terminator: Terminator::Return(0),
                    exit_acc: 0,
                }],
                ..Default::default()
            };
            let mut funcs = alloc::vec![multi_call_caller(1, 2, 500, 1), callee, leaf];
            run(&mut funcs, 32, abi, &BTreeMap::new());
            let calls = funcs[0]
                .insts
                .iter()
                .filter(|i| matches!(i, Inst::Call { target_pc, .. } if *target_pc == 500))
                .count();
            assert_eq!(
                calls,
                usize::from(!always),
                "always={always}: absolute bound must block exactly the optional case"
            );
        }
    }

    /// A callee whose asm names the stack pointer appends a region per
    /// site: a stack switch can park one activation -- suspended mid-body
    /// on another stack -- while a later site runs, so sites never share.
    #[test]
    fn sp_asm_callee_regions_append_per_site() {
        let abi = Target::LinuxX64.abi();
        let mut funcs = alloc::vec![
            multi_call_caller(1, 2, 100, 2),
            asm_callee_with_template(100, 4, b"mov %%rsp, (%0)"),
        ];
        run(&mut funcs, 32, abi, &BTreeMap::new());
        assert_eq!(
            funcs[0].locals, 10,
            "2 sites of a 4-slot sp-asm callee append"
        );
    }

    /// A caller that can come to execute stack-pointer asm -- here through
    /// a call to a non-candidate holding one -- gets no region sharing for
    /// any callee.
    #[test]
    fn sp_tainted_caller_disables_region_reuse() {
        let abi = Target::LinuxX64.abi();
        let mut caller = multi_call_caller(1, 2, 100, 2);
        caller.insts.insert(0, call_to(999));
        caller.inst_src.push((0, 0));
        caller.f32_values.push(false);
        let end = caller.insts.len() as u32;
        caller.blocks[0].inst_range = 0..end;
        caller.blocks[0].terminator = Terminator::Return(end - 1);
        caller.blocks[0].exit_acc = end - 1;
        let mut sw = asm_callee_with_template(999, 1, b"mov %%rsp, (%0)");
        sw.is_variadic = true; // keep it out of the candidate set
        let mut funcs = alloc::vec![caller, asm_callee(100, 4), sw];
        run(&mut funcs, 32, abi, &BTreeMap::new());
        assert_eq!(funcs[0].locals, 10, "sp-tainted caller: sites append");
    }

    /// Stack-pointer template detection: x86 and arm64 spellings match;
    /// mnemonics merely containing the letters do not.
    #[test]
    fn sp_template_detection() {
        use crate::c5::ir::AsmBlock;
        let blk = |t: &[u8]| AsmBlock {
            template: t.to_vec(),
            operands: alloc::vec![],
            clobber_regs: 0,
            clobber_fp_regs: 0,
            clobber_memory: false,
            volatile: false,
        };
        for t in [
            b"mov %%rsp, 24(%%rdx)".as_slice(),
            b"mov %0, %%rsp",
            b"mov x9, sp",
            b"add sp, sp, #16",
            b"mov w9, wsp",
            b"mov %esp, %eax",
        ] {
            assert!(blk(t).references_sp());
        }
        for t in [
            b"casp x0, x1, x2, x3, [x5]".as_slice(),
            b"stp x29, x30, [x8]",
            b"mov %0, 1",
            b"cpuid",
        ] {
            assert!(!blk(t).references_sp());
        }
    }

    /// Direct-call cycle membership: mutual recursion and self edges are
    /// members; acyclic callers and leaves are not.
    #[test]
    fn call_cycle_membership() {
        let f = |ent_pc: usize, targets: &[usize]| FunctionSsa {
            ent_pc,
            insts: targets.iter().map(|&t| call_to(t)).collect(),
            ..Default::default()
        };
        let funcs = alloc::vec![f(1, &[2]), f(2, &[1]), f(3, &[1]), f(4, &[4]), f(5, &[]),];
        let members = call_cycle_members(&funcs);
        assert_eq!(members, BTreeSet::from([1, 2, 4]));
    }

    /// A self-recursive callee is not a candidate: inlining it does not
    /// remove the recursion, so it would only unroll the call tree.
    #[test]
    fn self_recursive_callee_is_rejected() {
        let abi = Target::LinuxX64.abi();
        let call_self = Inst::Call {
            target_pc: 5,
            args: Vec::new(),
            fixed_args: 0,
            fp_return: false,
            fp_arg_mask: 0,
            arg_aggs: Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        };
        let f = FunctionSsa {
            ent_pc: 5,
            insts: alloc::vec![call_self, Inst::Imm(0)],
            inst_src: alloc::vec![(0, 0); 2],
            f32_values: alloc::vec![false; 2],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..2,
                terminator: Terminator::Return(1),
                exit_acc: 1,
            }],
            ..Default::default()
        };
        let mut reason = alloc::string::String::new();
        assert!(!is_inline_candidate(&f, 32, abi, Some(&mut reason)));
        assert_eq!(reason, "self-recursive");
    }

    /// A two-Return callee is a candidate on the no-aggregate integer
    /// path (its returns route into a postfix join phi) but not when the
    /// return is FP (an FP join phi is out of scope).
    #[test]
    fn multi_return_candidacy_gated_on_integer_no_aggregate() {
        let abi = Target::LinuxX64.abi();
        // block 0: Bz(cond) -> b1 / b2; b1: Return(imm); b2: Return(imm).
        let two_return = |ret_is_fp: bool| FunctionSsa {
            n_params: 1,
            ret_is_fp,
            insts: alloc::vec![Inst::Imm(0), Inst::Imm(1), Inst::Imm(2)],
            inst_src: alloc::vec![(0, 0); 3],
            f32_values: alloc::vec![false; 3],
            blocks: alloc::vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..1,
                    terminator: Terminator::Bz {
                        cond: 0,
                        target: 1,
                        fall_through: 2,
                    },
                    exit_acc: 0,
                },
                Block {
                    start_pc: 0,
                    inst_range: 1..2,
                    terminator: Terminator::Return(1),
                    exit_acc: 1,
                },
                Block {
                    start_pc: 0,
                    inst_range: 2..3,
                    terminator: Terminator::Return(2),
                    exit_acc: 2,
                },
            ],
            ..Default::default()
        };
        assert!(is_inline_candidate(&two_return(false), 32, abi, None));
        let mut reason = alloc::string::String::new();
        assert!(!is_inline_candidate(
            &two_return(true),
            32,
            abi,
            Some(&mut reason)
        ));
        assert_eq!(reason, "2 FP Return blocks (need 1)");
    }

    /// A variadic always_inline callee cannot be inlined; the candidate
    /// filter reports the reason through the optional sink.
    #[test]
    fn variadic_reject_reason_is_reported() {
        let f = FunctionSsa {
            is_variadic: true,
            is_always_inline: true,
            ..Default::default()
        };
        let mut reason = alloc::string::String::new();
        let ok = is_inline_candidate(&f, 32, Target::LinuxX64.abi(), Some(&mut reason));
        assert!(!ok);
        assert_eq!(reason, "variadic");
    }

    /// A volatile access the splice would drop keeps the callee out of
    /// line (C99 5.1.2.3p2 / 6.7.3p6): a dead volatile read of a cell
    /// past the declared parameters (no argument to materialize the cell
    /// from) and a volatile local store both reject; the same shapes
    /// without `volatile` stay candidates. A callee without inline asm
    /// keeps the strict flat-path gates, so the negative-slot store
    /// still rejects when volatile. A volatile read of a declared
    /// parameter's cell is materialized instead and stays a candidate.
    #[test]
    fn volatile_access_rejects_inlining() {
        let abi = Target::LinuxX64.abi();
        let single = |insts: Vec<Inst>, ret: ValueId| FunctionSsa {
            n_params: 1,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..insts.len() as u32,
                terminator: Terminator::Return(ret),
                exit_acc: ret,
            }],
            insts,
            ..Default::default()
        };
        let in_range = single(
            alloc::vec![
                Inst::LoadLocal {
                    off: 2,
                    kind: LoadKind::I32,
                    volatile: true,
                },
                Inst::Imm(1),
            ],
            1,
        );
        assert_eq!(
            materialized_param_cells(&in_range, &value_use_mask(&in_range)),
            BTreeSet::from([2])
        );
        assert!(is_inline_candidate(&in_range, 32, abi, None));
        for volatile in [false, true] {
            let read = single(
                alloc::vec![
                    Inst::LoadLocal {
                        off: 3,
                        kind: LoadKind::I32,
                        volatile,
                    },
                    Inst::Imm(1),
                ],
                1,
            );
            let write = single(
                alloc::vec![
                    Inst::Imm(3),
                    Inst::StoreLocal {
                        off: -1,
                        value: 0,
                        kind: StoreKind::I32,
                        volatile,
                    },
                    Inst::Imm(4),
                ],
                2,
            );
            for f in [&read, &write] {
                assert_eq!(
                    is_inline_candidate(f, 32, abi, None),
                    !volatile,
                    "volatile={volatile} candidacy must be {}",
                    !volatile
                );
            }
        }
    }

    /// A single-block helper whose inline asm writes an output through an
    /// own local (`get_current` / `__rdmsr` shape) is a candidate on the
    /// reloc path -- the output address is a negative-slot `LocalAddr` the
    /// multi-block splice relocates -- and `needs_reloc_splice` routes it
    /// off the flat path. An input-only single-block asm (`__wrmsr` shape)
    /// is likewise admitted. The same output addressing a parameter cell
    /// relocates when the walker's prologue spill precedes it (the spill
    /// initializes the fresh caller slot); without the spill and without
    /// a declared parameter to materialize from, the candidate is
    /// rejected.
    #[test]
    fn output_asm_to_own_local_inlines() {
        use crate::c5::ir::{AsmBlock, AsmConstraint, AsmOperand, AsmSeg};
        let abi = Target::LinuxX64.abi();
        let reg_output = || AsmBlock {
            template: b"mov %0, 1".to_vec(),
            operands: alloc::vec![AsmOperand {
                constraint: AsmConstraint::Reg,
                is_output: true,
                is_rw: false,
                width: 8,
                seg: AsmSeg::None,
            }],
            clobber_regs: 0,
            clobber_fp_regs: 0,
            clobber_memory: false,
            volatile: false,
        };
        // Spill (params only): v0 ParamRef, v1 StoreLocal; then v2
        // LocalAddr(slot); v3 asm writes the output through v2; v4 reads
        // the slot; Return(v4).
        let out_via_local = |slot: i64, spill: bool| {
            let mut insts = alloc::vec::Vec::new();
            if spill {
                insts.push(Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                });
                insts.push(Inst::StoreLocal {
                    off: slot,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                });
            }
            let addr = insts.len() as u32;
            insts.push(Inst::LocalAddr(slot));
            insts.push(Inst::InlineAsm {
                asm: alloc::boxed::Box::new(reg_output()),
                args: alloc::vec![addr],
            });
            insts.push(Inst::LoadLocal {
                off: slot,
                kind: LoadKind::I64,
                volatile: false,
            });
            let n = insts.len() as u32;
            FunctionSsa {
                locals: if slot < 0 { -slot } else { 0 },
                n_params: usize::from(spill),
                inst_src: alloc::vec![(0, 0); n as usize],
                f32_values: alloc::vec![false; n as usize],
                blocks: alloc::vec![Block {
                    start_pc: 0,
                    inst_range: 0..n,
                    terminator: Terminator::Return(n - 1),
                    exit_acc: n - 1,
                }],
                insts,
                ..Default::default()
            }
        };
        let own = out_via_local(-1, false);
        assert!(is_inline_candidate(&own, 32, abi, None));
        assert!(needs_reloc_splice(&own, &value_use_mask(&own)));
        let param = out_via_local(2, true);
        assert!(is_inline_candidate(&param, 32, abi, None));
        assert!(needs_reloc_splice(&param, &value_use_mask(&param)));
        // Without the spill and without a matching argument (n_params is
        // 0 here), the cell can be neither relocated nor materialized.
        let unspilled = out_via_local(2, false);
        let mut reason = alloc::string::String::new();
        assert!(!is_inline_candidate(&unspilled, 32, abi, Some(&mut reason)));
        assert_eq!(reason, "LocalAddr of non-relocated parameter cell 2");

        // Input-only single-block asm: admitted, routed to the reloc splice.
        let input_only = FunctionSsa {
            n_params: 1,
            insts: alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::InlineAsm {
                    asm: alloc::boxed::Box::new(AsmBlock {
                        template: b"nop".to_vec(),
                        operands: alloc::vec![AsmOperand {
                            constraint: AsmConstraint::Reg,
                            is_output: false,
                            is_rw: false,
                            width: 8,
                            seg: AsmSeg::None,
                        }],
                        clobber_regs: 0,
                        clobber_fp_regs: 0,
                        clobber_memory: true,
                        volatile: true,
                    }),
                    args: alloc::vec![0],
                },
                Inst::Imm(0),
            ],
            inst_src: alloc::vec![(0, 0); 3],
            f32_values: alloc::vec![false; 3],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
            ..Default::default()
        };
        assert!(is_inline_candidate(&input_only, 32, abi, None));
        assert!(needs_reloc_splice(
            &input_only,
            &value_use_mask(&input_only)
        ));
    }

    /// Both segment-access variants are inline candidates, and the operand
    /// walk routes them: an unrouted address operand would keep the callee's
    /// `ValueId` and land the access at an unrelated offset from the segment
    /// base. A segment base is per-CPU state rather than frame state, so the
    /// splice has nothing frame-bound to relocate.
    #[test]
    fn segment_access_operands_are_routed() {
        use crate::c5::ir::AsmSeg;
        let abi = Target::LinuxX64.abi();
        // v0/v1 params, v2 = v0 + v1, v3 = load through %gs:v2.
        let read = FunctionSsa {
            n_params: 2,
            insts: alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64,
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 1,
                },
                Inst::SegLoad {
                    addr: 2,
                    kind: LoadKind::I64,
                    volatile: false,
                    seg: AsmSeg::Gs,
                },
            ],
            inst_src: alloc::vec![(0, 0); 4],
            f32_values: alloc::vec![false; 4],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..4,
                terminator: Terminator::Return(3),
                exit_acc: 3,
            }],
            ..Default::default()
        };
        let mut reason = alloc::string::String::new();
        assert!(
            is_inline_candidate(&read, 32, abi, Some(&mut reason)),
            "{reason}"
        );
        // The same with a store: v3 = v0 + v1, %fs:v3 = v2.
        let write = FunctionSsa {
            n_params: 3,
            insts: alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64,
                },
                Inst::ParamRef {
                    idx: 2,
                    kind: LoadKind::I64,
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 1,
                },
                Inst::SegStore {
                    addr: 3,
                    value: 2,
                    kind: StoreKind::I64,
                    volatile: false,
                    seg: AsmSeg::Fs,
                },
            ],
            inst_src: alloc::vec![(0, 0); 5],
            f32_values: alloc::vec![false; 5],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..5,
                terminator: Terminator::Return(4),
                exit_acc: 4,
            }],
            ..Default::default()
        };
        reason.clear();
        assert!(
            is_inline_candidate(&write, 32, abi, Some(&mut reason)),
            "{reason}"
        );
        // Operand routing, the half an allow-list entry cannot supply.
        let remap = alloc::vec![7, 8, 9, 10, 11];
        let mut load = read.insts[3].clone();
        remap_inst_operands(&mut load, &remap);
        assert!(matches!(load, Inst::SegLoad { addr: 9, .. }));
        let mut store = write.insts[4].clone();
        remap_inst_operands(&mut store, &remap);
        assert!(matches!(
            store,
            Inst::SegStore {
                addr: 10,
                value: 9,
                ..
            }
        ));
    }

    /// A naked function is never inlined: its body is raw asm carrying its
    /// own calling convention, so splicing it into a caller would transfer
    /// control through the inlined return and corrupt the frame -- the
    /// coroutine context-switch hang.
    #[test]
    fn naked_function_is_never_inlined() {
        use crate::c5::ir::AsmBlock;
        let asm = AsmBlock {
            template: b"ret".to_vec(),
            operands: alloc::vec![],
            clobber_regs: 0,
            clobber_fp_regs: 0,
            clobber_memory: false,
            volatile: false,
        };
        let f = FunctionSsa {
            is_naked: true,
            insts: alloc::vec![
                Inst::InlineAsm {
                    asm: alloc::boxed::Box::new(asm),
                    args: alloc::vec![],
                },
                Inst::Imm(0),
            ],
            inst_src: alloc::vec![(0, 0); 2],
            f32_values: alloc::vec![false; 2],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..2,
                terminator: Terminator::Return(1),
                exit_acc: 1,
            }],
            ..Default::default()
        };
        let mut reason = alloc::string::String::new();
        assert!(!is_inline_candidate(
            &f,
            32,
            Target::LinuxX64.abi(),
            Some(&mut reason)
        ));
        assert_eq!(reason, "naked function");
    }

    /// `unhonoured_always_inline` flags a called-but-uninlinable
    /// always_inline callee with its reason and omits an uncalled one.
    #[test]
    fn unhonoured_flags_only_called_callees() {
        let abi = Target::LinuxX64.abi();
        let caller = FunctionSsa {
            ent_pc: 1,
            name: "use".into(),
            insts: vec![Inst::Call {
                target_pc: 5,
                args: Vec::new(),
                fixed_args: 0,
                fp_return: false,
                fp_arg_mask: 0,
                arg_aggs: Vec::new(),
                ret_agg: None,
                ret_slot_local: 0,
            }],
            ..Default::default()
        };
        let callee = FunctionSsa {
            ent_pc: 5,
            name: "va".into(),
            is_variadic: true,
            is_always_inline: true,
            ..Default::default()
        };
        let uncalled = FunctionSsa {
            ent_pc: 9,
            name: "va_unused".into(),
            is_variadic: true,
            is_always_inline: true,
            ..Default::default()
        };
        let funcs = [caller, callee, uncalled];
        let hits = unhonoured_always_inline(&funcs, 32, abi);
        assert_eq!(hits.len(), 1);
        let (idx, reason) = &hits[0];
        assert_eq!(funcs[*idx].name, "va");
        assert_eq!(reason, "variadic");
    }
    /// A parameter past the ABI's argument registers has no prologue
    /// spill, so its cell read is resolved to the call-site argument
    /// rather than relocated. The read's own width conversion carries
    /// over: signed narrow sign-extends, unsigned narrow masks. A write
    /// to the cell, or its address being taken, materializes the cell
    /// instead; a cell past the declared parameters or with an FP-kind
    /// access keeps the rejection.
    #[test]
    fn stack_passed_parameter_cell_is_read_from_the_argument() {
        let abi = Target::LinuxX64.abi();
        // Two declared parameters; the second reads its cell (slot 3).
        let cell_read = |kind: LoadKind, extra: Option<Inst>| {
            let mut insts = alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::StoreLocal {
                    off: 2,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                },
                Inst::LoadLocal {
                    off: 3,
                    kind,
                    volatile: false,
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 2,
                },
            ];
            if let Some(e) = extra {
                insts.push(e);
            }
            let n = insts.len() as u32;
            FunctionSsa {
                n_params: 2,
                inst_src: alloc::vec![(0, 0); n as usize],
                f32_values: alloc::vec![false; n as usize],
                blocks: alloc::vec![Block {
                    start_pc: 0,
                    inst_range: 0..n,
                    terminator: Terminator::Return(3),
                    exit_acc: 3,
                }],
                insts,
                ..Default::default()
            }
        };
        for kind in [
            LoadKind::I64,
            LoadKind::I32,
            LoadKind::I16,
            LoadKind::I8,
            LoadKind::U32,
            LoadKind::U16,
            LoadKind::U8,
        ] {
            let f = cell_read(kind, None);
            let mut reason = alloc::string::String::new();
            assert!(
                is_inline_candidate(&f, 32, abi, Some(&mut reason)),
                "{kind:?}: {reason}"
            );
            assert_eq!(
                forwarded_param_cells(&f, &value_use_mask(&f)),
                BTreeSet::from([3])
            );
        }
        // The conversion the splice emits for each kind.
        let emit = |kind: LoadKind| {
            let (mut i, mut s, mut f) = (
                alloc::vec::Vec::new(),
                alloc::vec::Vec::new(),
                alloc::vec::Vec::new(),
            );
            let v = splice_param_ref(kind, 5, (0, 0), &mut i, &mut s, &mut f);
            assert_eq!(i.len(), param_read_insts(kind) as usize);
            (v, i)
        };
        let (v, insts) = emit(LoadKind::I64);
        assert_eq!((v, insts.len()), (5, 0));
        let (v, insts) = emit(LoadKind::I32);
        assert_eq!(v, 0);
        assert!(matches!(
            insts[0],
            Inst::Extend {
                value: 5,
                kind: LoadKind::I32
            }
        ));
        let (v, insts) = emit(LoadKind::U16);
        assert_eq!(v, 0);
        assert!(matches!(
            insts[0],
            Inst::BinopI {
                op: BinOp::And,
                lhs: 5,
                rhs_imm: 0xffff
            }
        ));
        // A cell the body writes, or whose address it takes, cannot
        // forward; it is materialized -- relocated into a fresh caller
        // slot the splice initializes from the argument -- and the callee
        // routes to the relocating splice.
        let written = cell_read(
            LoadKind::I64,
            Some(Inst::StoreLocal {
                off: 3,
                value: 3,
                kind: StoreKind::I64,
                volatile: false,
            }),
        );
        let used = value_use_mask(&written);
        assert!(forwarded_param_cells(&written, &used).is_empty());
        assert_eq!(
            materialized_param_cells(&written, &used),
            BTreeSet::from([3])
        );
        assert!(needs_reloc_splice(&written, &used));
        let mut reason = alloc::string::String::new();
        assert!(
            is_inline_candidate(&written, 32, abi, Some(&mut reason)),
            "{reason}"
        );
        let addressed = cell_read(LoadKind::I64, Some(Inst::LocalAddr(3)));
        let used = value_use_mask(&addressed);
        assert!(forwarded_param_cells(&addressed, &used).is_empty());
        assert_eq!(
            materialized_param_cells(&addressed, &used),
            BTreeSet::from([3])
        );
        assert!(is_inline_candidate(&addressed, 32, abi, None));
        // A cell index past the declared parameters has no argument.
        let mut past = cell_read(LoadKind::I64, None);
        past.n_params = 1;
        assert!(forwarded_param_cells(&past, &value_use_mask(&past)).is_empty());
        assert!(!is_inline_candidate(&past, 32, abi, None));
        // An FP-kind access reads the walker's entry conversion, not the
        // raw cell: neither forwarded nor materialized.
        let fp = cell_read(
            LoadKind::F64,
            Some(Inst::StoreLocal {
                off: 3,
                value: 3,
                kind: StoreKind::F64,
                volatile: false,
            }),
        );
        let used = value_use_mask(&fp);
        assert!(forwarded_param_cells(&fp, &used).is_empty());
        assert!(materialized_param_cells(&fp, &used).is_empty());
        assert!(!is_inline_candidate(&fp, 32, abi, None));
    }

    /// A stack-passed parameter's cell the body assigns is materialized:
    /// the splice relocates it into a fresh caller slot, synthesizes the
    /// initializing store from the call-site argument in the prefix, and
    /// the call-free callee's sites share one pooled region.
    #[test]
    fn assigned_stack_passed_parameter_cell_is_materialized() {
        let abi = Target::LinuxX64.abi();
        // v0 read cell 2, v1 = v0 + 1, v2 write it back, v3 re-read;
        // Return(v3).
        let insts = alloc::vec![
            Inst::LoadLocal {
                off: 2,
                kind: LoadKind::I64,
                volatile: false,
            },
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 0,
                rhs_imm: 1,
            },
            Inst::StoreLocal {
                off: 2,
                value: 1,
                kind: StoreKind::I64,
                volatile: false,
            },
            Inst::LoadLocal {
                off: 2,
                kind: LoadKind::I64,
                volatile: false,
            },
        ];
        let callee = FunctionSsa {
            ent_pc: 100,
            n_params: 1,
            inst_src: alloc::vec![(0, 0); 4],
            f32_values: alloc::vec![false; 4],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..4,
                terminator: Terminator::Return(3),
                exit_acc: 3,
            }],
            insts,
            ..Default::default()
        };
        let used = value_use_mask(&callee);
        assert_eq!(
            materialized_param_cells(&callee, &used),
            BTreeSet::from([2])
        );
        assert!(needs_reloc_splice(&callee, &used));
        assert!(is_inline_candidate(&callee, 32, abi, None));
        let call = |arg: ValueId| Inst::Call {
            target_pc: 100,
            args: alloc::vec![arg],
            fixed_args: 1,
            fp_return: false,
            fp_arg_mask: 0,
            arg_aggs: Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        };
        let caller_insts = alloc::vec![
            Inst::Imm(41),
            call(0),
            Inst::Imm(7),
            call(2),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 1,
                rhs: 3,
            },
        ];
        let caller = FunctionSsa {
            ent_pc: 1,
            inst_src: alloc::vec![(0, 0); 5],
            f32_values: alloc::vec![false; 5],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..5,
                terminator: Terminator::Return(4),
                exit_acc: 4,
            }],
            insts: caller_insts,
            ..Default::default()
        };
        let mut funcs = alloc::vec![caller, callee];
        run(&mut funcs, 32, abi, &BTreeMap::new());
        let caller = &funcs[0];
        assert!(
            caller.insts.iter().all(|i| !matches!(i, Inst::Call { .. })),
            "both sites must inline"
        );
        assert_eq!(caller.locals, 1, "two sites share one 1-slot region");
        // Each site carries the synthesized init (an I64 store of the
        // argument Imm into the relocated slot) plus the body's store.
        let stores: Vec<i64> = caller
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::StoreLocal {
                    off,
                    value,
                    kind: StoreKind::I64,
                    volatile: false,
                } => {
                    if matches!(caller.insts.get(*value as usize), Some(Inst::Imm(k)) if *k == 41 || *k == 7)
                    {
                        Some(*off)
                    } else {
                        None
                    }
                }
                _ => None,
            })
            .collect();
        assert_eq!(stores, alloc::vec![-1, -1], "one init store per site");
        assert!(
            caller
                .insts
                .iter()
                .all(|i| !matches!(i, Inst::LoadLocal { off, .. } if *off >= 0)),
            "every cell read must address the relocated slot"
        );
    }

    /// One-instruction leaf returning a constant: the smallest shape the
    /// candidate filter admits.
    fn leaf_callee(ent_pc: usize) -> FunctionSsa {
        let insts = alloc::vec![Inst::Imm(ent_pc as i64)];
        FunctionSsa {
            ent_pc,
            inst_src: alloc::vec![(0, 0); 1],
            f32_values: alloc::vec![false; 1],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Return(0),
                exit_acc: 0,
            }],
            insts,
            ..Default::default()
        }
    }

    /// Driver calling every entry pc in `targets` once.
    fn driver(ent_pc: usize, targets: &[usize]) -> FunctionSsa {
        let insts: Vec<Inst> = targets.iter().map(|&t| call_to(t)).collect();
        let n = insts.len() as u32;
        FunctionSsa {
            ent_pc,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: Terminator::Return(NO_VALUE),
                exit_acc: NO_VALUE,
            }],
            insts,
            ..Default::default()
        }
    }

    /// The pass copied the candidate map once per caller, so a module of
    /// N helpers materialized N^2 candidate entries. The count is taken
    /// from `CANDIDATE_ENTRIES`, which every candidate set the pass
    /// builds feeds, so the bound holds whatever the machine is doing.
    /// Quadrupling the helper count must not quadruple the entries --
    /// 16x is what a per-caller copy would spend.
    #[test]
    fn candidate_bookkeeping_is_not_quadratic_in_the_module() {
        let entries = |n: usize| -> usize {
            let mut funcs: Vec<FunctionSsa> = (0..n).map(|i| leaf_callee(i + 1)).collect();
            funcs.push(driver(0, &(1..=n).collect::<Vec<_>>()));
            CANDIDATE_ENTRIES.with(|c| c.set(0));
            run(&mut funcs, 64, Target::LinuxX64.abi(), &BTreeMap::new());
            assert!(
                !funcs
                    .last()
                    .unwrap()
                    .insts
                    .iter()
                    .any(|i| matches!(i, Inst::Call { .. })),
                "the driver's calls must all have been spliced",
            );
            CANDIDATE_ENTRIES.with(|c| c.get())
        };
        let (small, large) = (entries(500), entries(2000));
        assert!(small > 0, "no candidate bookkeeping to compare");
        assert!(
            large < small * 6,
            "4x the module materialized {large} candidate entries against \
             {small}, past the 6x headroom over linear",
        );
    }

    /// A callee whose over-aligned region needs exactly 16 splices; its
    /// entries relocate into the caller's region behind the caller's own,
    /// and repeated sites of the shared per-callee record add nothing.
    #[test]
    fn region_16_callee_merges_into_caller() {
        let abi = Target::LinuxX64.abi();
        let mut callee = asm_callee(100, 2);
        callee.over_aligned = alloc::vec![(-1, 0)];
        callee.frame_align = 16;
        callee.realign_region_bytes = 16;
        let mut caller = multi_call_caller(1, 2, 100, 2);
        caller.over_aligned = alloc::vec![(-2, 0)];
        caller.frame_align = 16;
        caller.realign_region_bytes = 16;
        let mut funcs = alloc::vec![caller, callee];
        run(&mut funcs, 32, abi, &BTreeMap::new());
        assert!(
            funcs[0]
                .insts
                .iter()
                .all(|i| !matches!(i, Inst::Call { .. })),
            "a 16-aligned-region callee must inline"
        );
        assert_eq!(
            funcs[0].over_aligned,
            alloc::vec![(-2, 0), (-3, 16)],
            "callee entry must relocate behind the caller's region"
        );
        assert_eq!(funcs[0].frame_align, 16);
        assert_eq!(
            funcs[0].realign_region_bytes, 32,
            "two sites of one shared record must add the region once"
        );
    }

    /// A callee whose region alignment is above 16 needs the realigning
    /// prologue the splice cannot reproduce; it stays out of line.
    #[test]
    fn region_above_16_callee_stays_out_of_line() {
        let abi = Target::LinuxX64.abi();
        let mut callee = asm_callee(100, 2);
        callee.over_aligned = alloc::vec![(-1, 0)];
        callee.frame_align = 32;
        callee.realign_region_bytes = 32;
        let mut funcs = alloc::vec![multi_call_caller(1, 2, 100, 1), callee];
        run(&mut funcs, 32, abi, &BTreeMap::new());
        assert!(
            funcs[0]
                .insts
                .iter()
                .any(|i| matches!(i, Inst::Call { target_pc, .. } if *target_pc == 100)),
            "an above-16 region callee must not inline"
        );
    }

    /// Caller whose only call is indirect through an `ImmCode(k)`.
    fn indirect_pair_caller(ent_pc: usize, k: usize, callee_variadic: bool) -> FunctionSsa {
        let insts = alloc::vec![
            Inst::ImmCode(k),
            Inst::CallIndirect {
                target: 0,
                args: alloc::vec![],
                callee_variadic,
                fixed_args: 0,
                fp_return: false,
                fp_arg_mask: 0,
                arg_aggs: alloc::vec![],
                ret_agg: None,
                ret_slot_local: 0,
            },
            Inst::Imm(0),
        ];
        FunctionSsa {
            ent_pc,
            inst_src: alloc::vec![(0, 0); 3],
            f32_values: alloc::vec![false; 3],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
            insts,
            ..Default::default()
        }
    }

    fn leaf(ent_pc: usize) -> FunctionSsa {
        FunctionSsa {
            ent_pc,
            inst_src: alloc::vec![(0, 0)],
            f32_values: alloc::vec![false],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Return(0),
                exit_acc: 0,
            }],
            insts: alloc::vec![Inst::Imm(7)],
            ..Default::default()
        }
    }

    fn devirt(
        funcs: &mut [FunctionSsa],
        sp: &[usize],
        regions: &BTreeMap<usize, CallerRegions>,
        syms: &BTreeMap<u32, usize>,
    ) -> bool {
        let sp: BTreeSet<usize> = sp.iter().copied().collect();
        devirtualize_indirect_calls(funcs, &sp, regions, syms)
    }

    /// The pair rewrites into the direct call; the guards each hold it
    /// back: a variadic-ness mismatch, a stack-pointer-asm target, and a
    /// cycle-closing edge.
    #[test]
    fn indirect_call_of_imm_code_becomes_direct() {
        let mut funcs = alloc::vec![indirect_pair_caller(1, 200, false), leaf(200)];
        assert!(devirt(&mut funcs, &[], &BTreeMap::new(), &BTreeMap::new()));
        assert!(matches!(
            funcs[0].insts[1],
            Inst::Call { target_pc: 200, .. }
        ));

        let mut funcs = alloc::vec![indirect_pair_caller(1, 200, false), {
            let mut f = leaf(200);
            f.is_variadic = true;
            f
        }];
        assert!(!devirt(&mut funcs, &[], &BTreeMap::new(), &BTreeMap::new()));

        let mut funcs = alloc::vec![indirect_pair_caller(1, 200, false), leaf(200)];
        assert!(!devirt(
            &mut funcs,
            &[200],
            &BTreeMap::new(),
            &BTreeMap::new()
        ));

        // 200 calls 1 directly: the edge 1 -> 200 would close a cycle.
        let mut funcs = alloc::vec![
            indirect_pair_caller(1, 200, false),
            calling_callee(200, 0, 1),
        ];
        assert!(!devirt(&mut funcs, &[], &BTreeMap::new(), &BTreeMap::new()));
    }

    /// An `extern_imm_code_refs` entry admits the rewrite only when the
    /// symbol resolves to the payload ent_pc: a defined function at
    /// ent_pc 0 and an unresolved reference carry the same entry shape.
    #[test]
    fn devirt_consults_the_symbol_for_a_ref_carrying_target() {
        let mut pair = indirect_pair_caller(1, 0, false);
        pair.extern_imm_code_refs = alloc::vec![(0, 7)];
        let mut funcs = alloc::vec![pair.clone(), leaf(0)];
        assert!(!devirt(&mut funcs, &[], &BTreeMap::new(), &BTreeMap::new()));

        let syms: BTreeMap<u32, usize> = [(7u32, 0usize)].into_iter().collect();
        let mut funcs = alloc::vec![pair, leaf(0)];
        assert!(devirt(&mut funcs, &[], &BTreeMap::new(), &syms));
        assert!(matches!(funcs[0].insts[1], Inst::Call { target_pc: 0, .. }));
    }

    /// A target reaching a callee with a shared region record in this
    /// caller stays indirect: inlining it could re-splice that callee
    /// inside its own recorded copy.
    #[test]
    fn devirt_skips_target_reaching_a_recorded_region() {
        let mut funcs = alloc::vec![
            indirect_pair_caller(1, 200, false),
            calling_callee(200, 0, 300),
            leaf(300),
        ];
        let mut regions: BTreeMap<usize, CallerRegions> = BTreeMap::new();
        regions
            .entry(1)
            .or_default()
            .per_callee
            .insert(300, Some((0, 4)));
        assert!(!devirt(&mut funcs, &[], &regions, &BTreeMap::new()));
        // The same record in another caller does not constrain this one.
        let mut other: BTreeMap<usize, CallerRegions> = BTreeMap::new();
        other
            .entry(9)
            .or_default()
            .per_callee
            .insert(300, Some((0, 4)));
        assert!(devirt(&mut funcs, &[], &other, &BTreeMap::new()));
    }

    /// `run` pairs, devirtualizes and then inlines the target: no call
    /// of either form is left.
    #[test]
    fn run_inlines_the_devirtualized_call() {
        let abi = Target::LinuxX64.abi();
        let mut funcs = alloc::vec![indirect_pair_caller(1, 200, false), leaf(200)];
        run(&mut funcs, 32, abi, &BTreeMap::new());
        assert!(
            funcs[0]
                .insts
                .iter()
                .all(|i| !matches!(i, Inst::Call { .. } | Inst::CallIndirect { .. })),
            "the devirtualized call must inline"
        );
    }

    /// The standalone sweep derives the stack-pointer set itself: a
    /// target holding stack-pointer asm stays indirect, a plain one
    /// rewrites.
    #[test]
    fn standalone_devirtualize_guards_sp_targets() {
        let mut funcs = alloc::vec![
            indirect_pair_caller(1, 200, false),
            asm_callee_with_template(200, 0, b"mov sp, x0"),
        ];
        devirtualize(&mut funcs, &BTreeMap::new());
        assert!(matches!(funcs[0].insts[1], Inst::CallIndirect { .. }));

        let mut funcs = alloc::vec![indirect_pair_caller(1, 200, false), leaf(200)];
        devirtualize(&mut funcs, &BTreeMap::new());
        assert!(matches!(funcs[0].insts[1], Inst::Call { .. }));
    }

    /// The splice-time predicate behind the pool downgrade: an in-body
    /// `ImmCode` target or an `ImmCode` argument feeding a `ParamRef`
    /// target counts; anything else does not.
    #[test]
    fn splice_devirt_predicate_matches_the_sweep() {
        let body = indirect_pair_caller(5, 200, false);
        assert!(splice_may_gain_direct_call(&body, &[], &[]));

        let mut param_target = indirect_pair_caller(5, 200, false);
        param_target.insts[0] = Inst::ParamRef {
            idx: 0,
            kind: LoadKind::I64,
        };
        let caller_imm = [Inst::ImmCode(200)];
        let caller_plain = [Inst::Imm(3)];
        assert!(splice_may_gain_direct_call(
            &param_target,
            &[0],
            &caller_imm
        ));
        assert!(!splice_may_gain_direct_call(
            &param_target,
            &[0],
            &caller_plain
        ));
    }
}

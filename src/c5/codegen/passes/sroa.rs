//! Scalar promotion of an address-taken automatic aggregate (SROA).
//!
//! Runs under `-O` after the inliner and the post-inline mem2reg. An
//! aggregate whose base address is taken (`Inst::LocalAddr`) is an
//! unanalysable pin to mem2reg, so it stays memory-resident and no fact
//! about a member survives a store that may alias it. This pass rewrites
//! every access through that address to a per-field frame slot and
//! re-runs mem2reg, which lifts the now address-free slots to SSA values
//! (with phis across any surrounding loop) that the constant folder, the
//! branch folder, and the range analysis can read.
//!
//! Admission: an object is split only when every value resolving to an
//! address inside it -- a `LocalAddr` of its base plus constant `Add` /
//! `Sub` -- is used exclusively as
//!
//!   * the address of a non-volatile `Load` / `Store` whose byte range
//!     lies inside the object, or
//!   * the destination of an `Mcpy` starting at the object's first byte
//!     (a template initializer or a whole-object assignment),
//!
//! and the accessed ranges partition the object: two accesses are the
//! same `(offset, width)` field or disjoint, so no field's storage is
//! observed at a second width. Every other use -- a stored pointer, a
//! comparison, a runtime index, a terminator operand, an `Mcpy` source,
//! an atomic or segment-relative access -- can reach the object through
//! a pointer this pass does not track, and declines it.
//! `Block::exit_acc` is not such a use: it names the block's last
//! defined value for liveness, and every rewrite here leaves that id
//! defining something.
//!
//! A fixed argument of a same-unit call is admitted on what the callee
//! does with it ([`param_footprints`]): the object stays where it is,
//! keeping its storage and its base address for the callee to read, and
//! gives up the fields no callee writes. A field some callee reads keeps
//! its stored bytes up to date -- its store writes both the object and
//! the field's slot -- so the promoted value and the memory the call
//! sees never disagree; that costs a store per store, so such a field
//! moves only where its reads outnumber its writes. A parameter with no
//! footprint declines the object as any untracked use does.
//!
//! The object's storage must also be named by nothing but those address
//! expressions. A slot the emit or the callee ABI writes without an
//! instruction operand -- a by-value aggregate parameter's prologue
//! copy, the indirect-result address, an alloca base, the caller-side
//! temporary an aggregate return materialises into -- has no store in
//! the tape to redirect, and a slot a direct `LoadLocal` / `StoreLocal`
//! names is read or written under a second name that the redirect would
//! not follow. Both, and over-aligned objects, are excluded up front.
//!
//! A field takes the object's own cell when every field starts on a
//! distinct 8-byte boundary -- what a fully unrolled constant-index
//! array produces -- and a fresh single-cell slot otherwise, since a
//! member's byte offset need not be a multiple of the slot pitch. Either
//! way the base address dies and the frame compaction reclaims what is
//! left unreferenced.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use crate::c5::codegen::ssa::reg_alloc::for_each_operand;
use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId};

/// Byte ranges, relative to the object a pointer parameter points at,
/// that a body reads and writes through it. A parameter absent from
/// [`FootprintMap`] is opaque: its pointer reaches a use this analysis
/// does not model, so the callee may read, write, or retain the object
/// anywhere.
#[derive(Default, Clone)]
pub(crate) struct ParamFootprint {
    reads: Vec<(i64, i64)>,
    writes: Vec<(i64, i64)>,
}

/// Footprints by `(callee entry pc, parameter index)`.
pub(crate) type FootprintMap = BTreeMap<(usize, usize), ParamFootprint>;

/// Ranges one parameter's footprint may carry before it is treated as
/// opaque. Bounds both the analysis's memory and the intersection tests
/// the split admission runs per field.
const MAX_FOOTPRINT_RANGES: usize = 32;

/// Rounds the forwarding fixpoint may take. The lattice only grows
/// (ranges are added, then the footprint goes opaque), so this bounds a
/// call chain's depth rather than the iteration; a module that has not
/// converged by then is treated as opaque throughout.
const FOOTPRINT_ROUNDS: usize = 32;

/// What every function does with the pointer value of each of its
/// parameters, for [`run`]'s split admission: an object whose address a
/// call takes can still give up the fields that call cannot reach.
///
/// A parameter is listed only when every use of its value is an access
/// at a constant offset -- the address expressions [`resolve_base`]
/// tracks -- or a fixed argument of another same-unit call, whose
/// footprint it inherits. Any other use, a variadic body, and a body
/// that keeps a parameter in a frame cell (where the value reaches its
/// uses through memory this walk does not follow) leave the parameter
/// out of the map.
pub(crate) fn param_footprints(funcs: &[FunctionSsa]) -> FootprintMap {
    let mut local: BTreeMap<(usize, usize), Option<ParamFootprint>> = BTreeMap::new();
    // `(caller parameter) inherits (callee parameter) shifted by the
    // offset the argument carries`.
    let mut edges: Vec<((usize, usize), (usize, usize), i64)> = Vec::new();
    for func in funcs {
        if func.n_params == 0 {
            continue;
        }
        // The va machinery reads a variadic body's arguments off the
        // stack rather than through a `ParamRef`.
        if func.is_variadic {
            continue;
        }
        let n = func.insts.len();
        let mut state: Vec<u8> = alloc::vec![0u8; n];
        let mut resolved: Vec<Option<(i64, i64)>> = alloc::vec![None; n];
        for v in 0..n {
            resolve_base(&func.insts, v as ValueId, &mut state, &mut resolved, true);
        }
        let np = func.n_params;
        let mut fps: Vec<Option<ParamFootprint>> = alloc::vec![Some(ParamFootprint::default()); np];
        // A parameter whose value reaches a use through its frame cell
        // (slot 2 + index) rather than the `ParamRef` this walk follows
        // is not tracked. The walker emits a dead cell read beside every
        // promoted parameter, so only a live one counts.
        let mut used: Vec<bool> = alloc::vec![false; n];
        let mark = |v: ValueId, used: &mut Vec<bool>| {
            if let Some(u) = used.get_mut(v as usize) {
                *u = true;
            }
        };
        for inst in &func.insts {
            for_each_operand(inst, |v| mark(v, &mut used));
        }
        for block in &func.blocks {
            let mut term = block.terminator;
            term.for_each_operand_mut(|v| mark(*v, &mut used));
            mark(block.exit_acc, &mut used);
        }
        for (i, inst) in func.insts.iter().enumerate() {
            let cell = match inst {
                Inst::LocalAddr(s) => *s,
                Inst::LoadLocal { off, volatile, .. } if used[i] || *volatile => *off,
                _ => continue,
            };
            if cell >= 2
                && let Some(slot) = fps.get_mut((cell - 2) as usize)
            {
                *slot = None;
            }
        }
        let at = |v: ValueId| -> Option<(i64, i64)> {
            resolved
                .get(v as usize)
                .copied()
                .flatten()
                .filter(|&(p, _)| (p as usize) < np)
        };
        for (i, inst) in func.insts.iter().enumerate() {
            match inst {
                // An address expression is validated through its own uses.
                Inst::BinopI {
                    op: BinOp::Add | BinOp::Sub,
                    ..
                }
                | Inst::Binop {
                    op: BinOp::Add | BinOp::Sub,
                    ..
                } if resolved[i].is_some() => {}
                Inst::ParamRef { .. } => {}
                Inst::Load {
                    addr, disp, kind, ..
                } => {
                    if let Some((p, off)) = at(*addr) {
                        add_range(&mut fps[p as usize], false, off + *disp as i64, load_width(*kind));
                    }
                }
                Inst::Store {
                    addr,
                    disp,
                    value,
                    kind,
                    ..
                } => {
                    if let Some((p, off)) = at(*addr) {
                        add_range(&mut fps[p as usize], true, off + *disp as i64, store_width(*kind));
                    }
                    if let Some((p, _)) = at(*value) {
                        fps[p as usize] = None;
                    }
                }
                Inst::Mcpy { dst, src, size, .. } => {
                    if let Some((p, off)) = at(*dst) {
                        add_range(&mut fps[p as usize], true, off, *size);
                    }
                    if let Some((p, off)) = at(*src) {
                        add_range(&mut fps[p as usize], false, off, *size);
                    }
                }
                Inst::Call {
                    target_pc,
                    args,
                    fixed_args,
                    arg_aggs,
                    ..
                } => {
                    for (j, &a) in args.iter().enumerate() {
                        if let Some((p, off)) = at(a) {
                            // A variadic argument is read off the stack,
                            // and an aggregate one is marshalled from the
                            // whole pointee rather than the parameter's
                            // own accesses.
                            if j < *fixed_args && !matches!(arg_aggs.get(j), Some(Some(_))) {
                                edges.push(((func.ent_pc, p as usize), (*target_pc, j), off));
                            } else {
                                fps[p as usize] = None;
                            }
                        }
                    }
                }
                other => for_each_operand(other, |v| {
                    if let Some((p, _)) = at(v) {
                        fps[p as usize] = None;
                    }
                }),
            }
        }
        // Returning the pointer hands the object to the caller; a
        // terminator reading it is not modelled either.
        for block in &func.blocks {
            let mut term = block.terminator;
            term.for_each_operand_mut(|v| {
                if let Some((p, _)) = at(*v) {
                    fps[p as usize] = None;
                }
            });
        }
        for (i, fp) in fps.into_iter().enumerate() {
            local.insert((func.ent_pc, i), fp);
        }
    }
    // Propagate along the forwarding edges. Monotone: a footprint only
    // gains ranges or goes opaque, so the iteration settles.
    let mut converged = false;
    for _ in 0..FOOTPRINT_ROUNDS {
        let mut changed = false;
        for (from, to, off) in &edges {
            let src = local.get(to).cloned();
            let Some(dst) = local.get_mut(from) else {
                continue;
            };
            changed |= inherit(dst, src, *off);
        }
        if !changed {
            converged = true;
            break;
        }
    }
    if !converged {
        return FootprintMap::new();
    }
    local
        .into_iter()
        .filter_map(|(k, v)| v.map(|fp| (k, fp)))
        .collect()
}

/// Record one access range on a footprint, or make it opaque once it
/// carries more ranges than the cap.
fn add_range(fp: &mut Option<ParamFootprint>, write: bool, off: i64, width: i64) {
    let Some(f) = fp else { return };
    let side = if write { &mut f.writes } else { &mut f.reads };
    if !side.contains(&(off, width)) {
        side.push((off, width));
    }
    if f.reads.len() + f.writes.len() > MAX_FOOTPRINT_RANGES {
        *fp = None;
    }
}

/// Fold a callee parameter's footprint into the caller parameter handed
/// to it, shifted by the argument's offset. Reports whether `dst` grew.
fn inherit(
    dst: &mut Option<ParamFootprint>,
    src: Option<Option<ParamFootprint>>,
    off: i64,
) -> bool {
    if dst.is_none() {
        return false;
    }
    let Some(Some(src)) = src else {
        *dst = None;
        return true;
    };
    let before = dst.as_ref().map(|f| f.reads.len() + f.writes.len());
    for &(o, w) in &src.reads {
        add_range(dst, false, o + off, w);
    }
    for &(o, w) in &src.writes {
        add_range(dst, true, o + off, w);
    }
    dst.as_ref().map(|f| f.reads.len() + f.writes.len()) != before
}

/// Whether two byte ranges overlap.
fn overlaps(a: (i64, i64), b: (i64, i64)) -> bool {
    a.0 < b.0 + b.1 && b.0 < a.0 + a.1
}

/// Split local aggregates into per-field scalar slots and re-run mem2reg
/// to promote them. Returns the base slots of objects that were fully
/// promoted (every field lifted to a register), for the debug-info
/// emitter to drop their now-stale frame location.
pub(crate) fn run(
    func: &mut FunctionSsa,
    usable_gpr: usize,
    footprints: &FootprintMap,
) -> Vec<i64> {
    // mem2reg leaves computed-goto functions unpromoted; keep this pass
    // consistent so its split can never strand a slot the re-run refuses
    // to lift.
    if !func.computed_goto_targets.is_empty() {
        return Vec::new();
    }
    // Splitting is iterated: expanding one object's block initializer
    // consumes the copy that made its source object ineligible (a copy
    // reads the source through a pointer this pass does not model), so
    // the source becomes splittable on the next round. An object already
    // split is out of the next round's view -- its fields have their
    // slots -- so each round splits an object no earlier one did and the
    // finite object count ends the iteration.
    let mut fully: Vec<i64> = Vec::new();
    let mut seen: BTreeSet<i64> = BTreeSet::new();
    loop {
        let split = split_objects(func, usable_gpr, footprints, &seen);
        if split.is_empty() {
            return fully;
        }
        seen.extend(split.iter().map(|s| s.base));
        // The split produced address-free field slots; the mem2reg re-run
        // promotes them (a full pruned-SSA rebuild, confined to this
        // function by the gate at the call site).
        let promoted: BTreeSet<i64> = crate::c5::codegen::ssa::mem2reg::run(func)
            .into_iter()
            .collect();
        // Report an object as promoted only when every field slot was
        // lifted; a partially promoted object keeps a live frame location
        // the debug info must still point at, and so does one whose
        // storage a call still reaches.
        for s in split {
            if !s.address_live && s.slots.iter().all(|f| promoted.contains(f)) {
                fully.push(s.base);
            }
        }
    }
}

/// One object the round split: the field slots it now uses, and whether
/// its own storage and base address survive because a call reaches them.
struct Split {
    base: i64,
    slots: Vec<i64>,
    address_live: bool,
}

/// A constant-offset scalar access to an object, resolved to the byte
/// range it reads or writes. `fill` carries the stored constant when the
/// access is a store of an immediate, which is the one store form that
/// can be rewritten to a narrower one.
struct Access {
    id: u32,
    base: i64,
    off: i64,
    width: i64,
    store: bool,
    fill: Option<i64>,
}

/// Where the bytes an object-granularity write moves come from.
enum InitSource {
    /// `Mcpy`; the source pointer is read off the tape at expansion.
    Copy,
    /// `Store` of the given immediate.
    Fill(i64),
}

/// A write covering a whole span of an object rather than one of its
/// fields, decomposed below into a per-field write each.
struct BlockInit {
    id: u32,
    base: i64,
    off: i64,
    size: i64,
    align: i64,
    source: InitSource,
}

/// One field a [`BlockInit`] is decomposed into: write `width` bytes to
/// `slot`, taken either from the copy source at `off` or from `imm`.
struct CopyField {
    off: i64,
    slot: i64,
    load: LoadKind,
    store: StoreKind,
    imm: Option<i64>,
}

/// How a candidate object's field is accessed: `fp` when it moves
/// through an FP register, and the count of reads and writes the
/// function makes of it.
#[derive(Default)]
struct FieldUse {
    fp: bool,
    loads: usize,
    stores: usize,
}

/// Rewrite every splittable object's accesses to per-field slots,
/// decompose its block initializer, and neutralise the dead
/// base-address instructions. Returns one [`Split`] per object actually
/// split. `budget` is the target's usable GPR file: a round admits
/// objects greedily under it, largest register demand first, so the
/// object paying for the most memory traffic is never displaced by a
/// smaller one. An object that does not fit stays memory-resident this
/// round -- the mem2reg re-run would spill the loop-carried phis back to
/// the frame at a net loss -- and is reconsidered next round, once this
/// round's promotions have collapsed into their consumers.
fn split_objects(
    func: &mut FunctionSsa,
    budget: usize,
    footprints: &FootprintMap,
    split_already: &BTreeSet<i64>,
) -> Vec<Split> {
    let Some(mut cells_of) = candidate_objects(func) else {
        return Vec::new();
    };
    cells_of.retain(|base, _| !split_already.contains(base));
    if cells_of.is_empty() {
        return Vec::new();
    }

    // Resolve every value to its (base_slot, byte_offset) when it is an
    // address expression rooted at a `LocalAddr` through constant Add /
    // Sub chains; None otherwise. Memoised with an in-progress guard
    // against the cyclic references the unordered SSA tape may carry.
    let n = func.insts.len();
    let mut state: Vec<u8> = alloc::vec![0u8; n];
    let mut resolved: Vec<Option<(i64, i64)>> = alloc::vec![None; n];
    for v in 0..n {
        resolve_addr(&func.insts, v as ValueId, &mut state, &mut resolved);
    }
    let base_of = |v: ValueId| -> Option<i64> {
        resolved
            .get(v as usize)
            .copied()
            .flatten()
            .map(|(b, _)| b)
            .filter(|b| cells_of.contains_key(b))
    };

    // A base drops out the moment any access or use fails a condition.
    let mut declined: BTreeSet<i64> = BTreeSet::new();
    let mut accesses: Vec<Access> = Vec::new();
    let mut inits: Vec<BlockInit> = Vec::new();
    // Objects a same-unit call reaches through an argument that is their
    // address, with the byte ranges its callee reads and writes there.
    // Such an object keeps its storage and its base address; only the
    // fields no callee writes leave it, and one a callee reads keeps its
    // stored bytes up to date (`Expansion::mirror`).
    let mut address_live: BTreeSet<i64> = BTreeSet::new();
    let mut call_reads: BTreeMap<i64, Vec<(i64, i64)>> = BTreeMap::new();
    let mut call_writes: BTreeMap<i64, Vec<(i64, i64)>> = BTreeMap::new();

    for (i, inst) in func.insts.iter().enumerate() {
        match inst {
            // An address expression built by a constant Add / Sub is a
            // safe intermediate: its address operand is skipped here and
            // its result is validated through the uses of `i`.
            Inst::BinopI {
                op: BinOp::Add | BinOp::Sub,
                ..
            }
            | Inst::Binop {
                op: BinOp::Add | BinOp::Sub,
                ..
            } if resolved[i].is_some() => {}
            Inst::Load {
                addr,
                disp,
                kind,
                volatile,
                ..
            } => {
                if let Some((base, off)) = resolved.get(*addr as usize).copied().flatten()
                    && let Some(&cells) = cells_of.get(&base)
                {
                    let off = off + *disp as i64;
                    let width = load_width(*kind);
                    if *volatile || off < 0 || off + width > cells * 8 {
                        declined.insert(base);
                    } else {
                        accesses.push(Access {
                            id: i as u32,
                            base,
                            off,
                            width,
                            store: false,
                            fill: None,
                        });
                    }
                }
            }
            Inst::Store {
                addr,
                disp,
                value,
                kind,
                volatile,
                ..
            } => {
                if let Some((base, off)) = resolved.get(*addr as usize).copied().flatten()
                    && let Some(&cells) = cells_of.get(&base)
                {
                    let off = off + *disp as i64;
                    let width = store_width(*kind);
                    if *volatile || off < 0 || off + width > cells * 8 {
                        declined.insert(base);
                    } else {
                        accesses.push(Access {
                            id: i as u32,
                            base,
                            off,
                            width,
                            store: true,
                            fill: match func.insts.get(*value as usize) {
                                Some(Inst::Imm(k)) => Some(*k),
                                _ => None,
                            },
                        });
                    }
                }
                // The stored value being an address escapes that base.
                if let Some(base) = base_of(*value) {
                    declined.insert(base);
                }
            }
            Inst::Mcpy {
                dst,
                src,
                size,
                align,
            } => {
                // Reading the object through a block copy is not
                // modelled; only a copy that fills it from its first
                // byte is.
                if let Some(base) = base_of(*src) {
                    declined.insert(base);
                }
                if let Some((base, off)) = resolved.get(*dst as usize).copied().flatten()
                    && cells_of.contains_key(&base)
                {
                    if off == 0 && *size > 0 {
                        inits.push(BlockInit {
                            id: i as u32,
                            base,
                            off: 0,
                            size: *size,
                            align: *align as i64,
                            source: InitSource::Copy,
                        });
                    } else {
                        declined.insert(base);
                    }
                }
            }
            // A same-unit call reaches only what its callee's footprint
            // says; an opaque parameter, a variadic argument, and every
            // other call form decline the object as any other use does.
            Inst::Call {
                target_pc,
                args,
                fixed_args,
                arg_aggs,
                ..
            } => {
                for (j, &a) in args.iter().enumerate() {
                    let Some((base, off)) = resolved.get(a as usize).copied().flatten() else {
                        continue;
                    };
                    if !cells_of.contains_key(&base) {
                        continue;
                    }
                    // An aggregate passed by value is marshalled from
                    // every byte of the object, not just the bytes the
                    // callee's own accesses name.
                    let by_value = matches!(arg_aggs.get(j), Some(Some(_)));
                    match footprints.get(&(*target_pc, j)) {
                        Some(fp) if j < *fixed_args && !by_value => {
                            address_live.insert(base);
                            call_reads
                                .entry(base)
                                .or_default()
                                .extend(fp.reads.iter().map(|&(o, w)| (o + off, w)));
                            call_writes
                                .entry(base)
                                .or_default()
                                .extend(fp.writes.iter().map(|&(o, w)| (o + off, w)));
                        }
                        _ => {
                            declined.insert(base);
                        }
                    }
                }
            }
            other => {
                for_each_operand(other, |v| {
                    if let Some(base) = base_of(v) {
                        declined.insert(base);
                    }
                });
            }
        }
    }
    // A base address reaching a terminator or block accumulator escapes.
    for block in &func.blocks {
        let v = match &block.terminator {
            Terminator::Return(v)
            | Terminator::Bz { cond: v, .. }
            | Terminator::Bnz { cond: v, .. }
            | Terminator::GotoIndirect { target: v }
            | Terminator::JumpTable { idx: v, .. } => *v,
            _ => NO_VALUE,
        };
        if let Some(base) = base_of(v) {
            declined.insert(base);
        }
    }
    // A store of an immediate spanning more than one of the object's
    // fields is object-granularity initialization written as a store
    // rather than a copy -- what an aggregate's zero fill emits per cell
    // -- and is decomposed like one. It is recognised by strictly
    // containing another access's byte range, so a store that is itself
    // a field keeps its own width and stays a plain access.
    let mut ranges_of: BTreeMap<i64, BTreeSet<(i64, i64)>> = BTreeMap::new();
    for a in &accesses {
        ranges_of
            .entry(a.base)
            .or_default()
            .insert((a.off, a.width));
    }
    let mut demoted: BTreeSet<u32> = BTreeSet::new();
    for a in &accesses {
        let Some(k) = a.fill else { continue };
        let spans = ranges_of[&a.base].iter().any(|&(off, width)| {
            (off, width) != (a.off, a.width) && off >= a.off && off + width <= a.off + a.width
        });
        if spans {
            demoted.insert(a.id);
            inits.push(BlockInit {
                id: a.id,
                base: a.base,
                off: a.off,
                size: a.width,
                align: a.width,
                source: InitSource::Fill(k),
            });
        }
    }

    // A decomposed write's own value id must have no operand consumer:
    // the per-field writes below produce neither the copied object's
    // address nor the whole stored value. `Block::exit_acc` is not a
    // consumer -- it names the block's last defined value so liveness
    // keeps it to the block end, and every rewrite here leaves that id
    // defining some value.
    if !inits.is_empty() {
        let mut used: BTreeSet<ValueId> = BTreeSet::new();
        for inst in &func.insts {
            for_each_operand(inst, |v| {
                used.insert(v);
            });
        }
        for block in &func.blocks {
            let mut term = block.terminator;
            term.for_each_operand_mut(|v| {
                used.insert(*v);
            });
        }
        for init in &inits {
            if used.contains(&init.id) {
                declined.insert(init.base);
            }
        }
    }

    // Group the surviving accesses into fields and check that the byte
    // ranges partition: two accesses are the same field or disjoint.
    let mut fields_of: BTreeMap<i64, BTreeMap<(i64, i64), FieldUse>> = BTreeMap::new();
    for a in &accesses {
        if declined.contains(&a.base) || demoted.contains(&a.id) {
            continue;
        }
        let (fp, load) = match &func.insts[a.id as usize] {
            Inst::Load { kind, .. } => (matches!(kind, LoadKind::F32 | LoadKind::F64), true),
            Inst::Store { kind, .. } => (matches!(kind, StoreKind::F32 | StoreKind::F64), false),
            _ => (false, false),
        };
        let use_ = fields_of
            .entry(a.base)
            .or_default()
            .entry((a.off, a.width))
            .or_default();
        use_.fp |= fp;
        if load {
            use_.loads += 1;
        } else {
            use_.stores += 1;
        }
    }
    for (base, fields) in &fields_of {
        let mut end = 0i64;
        for &(off, width) in fields.keys() {
            if off < end {
                declined.insert(*base);
                break;
            }
            end = off + width;
        }
    }
    // A field a call can write stays in the object's storage: the callee
    // writes those bytes and a promoted copy would go stale. The rest
    // leave, and the object keeps its storage for the callee to read.
    // An object with nothing left to give up is no different from a
    // declined one.
    for base in &address_live {
        let Some(fields) = fields_of.get_mut(base) else {
            continue;
        };
        let writes = call_writes.get(base).map(Vec::as_slice).unwrap_or(&[]);
        let reads = call_reads.get(base).map(Vec::as_slice).unwrap_or(&[]);
        fields.retain(|&(off, width), u| {
            if writes.iter().any(|&w| overlaps((off, width), w)) {
                return false;
            }
            // A field the call reads keeps its memory write beside the
            // slot's, so promoting it trades one store per store for one
            // load per load. Worth it only where the reads outnumber the
            // writes that pay for them.
            !reads.iter().any(|&r| overlaps((off, width), r)) || u.loads > u.stores
        });
        if fields.is_empty() {
            declined.insert(*base);
        }
    }
    // A block initializer must decompose exactly: every field is either
    // wholly outside it, keeping its own slot's value, or wholly inside
    // it, at its natural alignment within the guarantee a copy carries,
    // and moving through an integer register. A field straddling either
    // end satisfies neither and declines the object.
    for init in &inits {
        let Some(fields) = fields_of.get(&init.base) else {
            continue;
        };
        let end = init.off + init.size;
        let ok = fields.iter().all(|(&(off, width), use_)| {
            if off + width <= init.off || off >= end {
                return true;
            }
            off >= init.off
                && off + width <= end
                && !use_.fp
                && width <= init.align
                && (off - init.off) % width == 0
                && off <= i32::MAX as i64
        });
        if !ok {
            declined.insert(init.base);
        }
    }

    // Only a field some load reads occupies a register: one that is
    // written and never read becomes a dead def the store elimination
    // removes, so counting it would decline the split for a demand the
    // split does not create. Rank the surviving objects by that demand,
    // largest first (ties by base for determinism), and admit each that
    // still fits the remaining budget.
    let mut ranked: Vec<(usize, i64)> = fields_of
        .iter()
        .filter(|(b, _)| !declined.contains(b))
        .map(|(&b, fields)| (fields.values().filter(|u| u.loads > 0).count(), b))
        .collect();
    ranked.sort_by_key(|&(demand, base)| (core::cmp::Reverse(demand), base));
    let mut remaining = budget;
    let mut order: Vec<i64> = Vec::new();
    for (demand, base) in ranked {
        if demand <= remaining {
            remaining -= demand;
            order.push(base);
        }
    }
    if order.is_empty() {
        return Vec::new();
    }
    let mut slots_of: BTreeMap<i64, BTreeMap<(i64, i64), i64>> = BTreeMap::new();
    for &base in &order {
        let fields = &fields_of[&base];
        // Reuse the object's own cells when every field starts on a
        // distinct 8-byte boundary; the frame already reserved them. An
        // object a call still reaches keeps its cells as storage, so its
        // fields take slots of their own.
        let cellwise = !address_live.contains(&base)
            && fields.keys().all(|&(off, _)| off % 8 == 0)
            && fields
                .keys()
                .map(|&(off, _)| off / 8)
                .collect::<BTreeSet<i64>>()
                .len()
                == fields.len();
        let mut assigned: BTreeMap<(i64, i64), i64> = BTreeMap::new();
        for &(off, width) in fields.keys() {
            let slot = if cellwise {
                base + off / 8
            } else {
                func.locals += 1;
                -func.locals
            };
            assigned.insert((off, width), slot);
        }
        slots_of.insert(base, assigned);
    }

    let mut expand: BTreeMap<u32, Expansion> = BTreeMap::new();
    for init in &inits {
        let Some(assigned) = slots_of.get(&init.base) else {
            continue;
        };
        let end = init.off + init.size;
        let copies = assigned
            .iter()
            .filter(|((off, width), _)| *off >= init.off && *off + *width <= end)
            .map(|(&(off, width), &slot)| {
                let (load, store) = copy_kinds(width);
                CopyField {
                    off: off - init.off,
                    slot,
                    load,
                    store,
                    // The field takes the bytes of the stored constant
                    // that land on it, sign-extended to the register the
                    // narrowed store reads, as a direct store of the same
                    // constant to that member would produce.
                    imm: match init.source {
                        InitSource::Copy => None,
                        InitSource::Fill(k) => Some(sub_word(k, off - init.off, width)),
                    },
                }
            })
            .collect();
        expand.insert(
            init.id,
            Expansion {
                keep: address_live.contains(&init.base),
                mirror: None,
                copies,
            },
        );
    }

    // Commit: rewrite each surviving access to its field slot. A demoted
    // store names no field; the expansion below replaces it. A field the
    // split left in the object keeps its access, and a store to a field
    // a call reads keeps its memory write beside the slot's.
    for a in &accesses {
        let Some(assigned) = slots_of.get(&a.base) else {
            continue;
        };
        if demoted.contains(&a.id) {
            continue;
        }
        let Some(&slot) = assigned.get(&(a.off, a.width)) else {
            continue;
        };
        let read_by_call = call_reads
            .get(&a.base)
            .is_some_and(|r| r.iter().any(|&x| overlaps((a.off, a.width), x)));
        let inst = &mut func.insts[a.id as usize];
        if a.store {
            if let Inst::Store { value, kind, .. } = *inst {
                if read_by_call {
                    expand.insert(
                        a.id,
                        Expansion {
                            keep: true,
                            mirror: Some((slot, kind)),
                            copies: Vec::new(),
                        },
                    );
                } else {
                    *inst = Inst::StoreLocal {
                        off: slot,
                        value,
                        kind,
                        volatile: false,
                    };
                }
            }
        } else if let Inst::Load { kind, .. } = *inst {
            *inst = Inst::LoadLocal {
                off: slot,
                kind,
                volatile: false,
            };
        }
    }
    // Neutralise the now-dead base-address expressions of every fully
    // split object: every consumer was a rewritten access or another
    // address expression, so the value has no live use. An object a call
    // still reaches keeps them. Before the expansion below, which
    // renumbers the tape `resolved` is indexed by.
    for (v, r) in resolved.iter().enumerate() {
        if let Some((base, _)) = r
            && slots_of.contains_key(base)
            && !address_live.contains(base)
        {
            func.insts[v] = Inst::Imm(0);
        }
    }
    if !expand.is_empty() {
        expand_writes(func, &expand);
    }
    slots_of
        .into_iter()
        .map(|(base, assigned)| Split {
            address_live: address_live.contains(&base),
            base,
            slots: assigned.into_values().collect(),
        })
        .collect()
}

/// Local aggregates this pass may consider, as `base -> cells`. A base
/// repeated across disjoint scopes takes the smallest cell count so an
/// access is bounds-checked against every occupant. `None` when there is
/// nothing to do.
fn candidate_objects(func: &FunctionSsa) -> Option<BTreeMap<i64, i64>> {
    let mut cells_of: BTreeMap<i64, i64> = BTreeMap::new();
    for &(base, cells) in &func.multi_cell_slots {
        if base >= 0 || cells < 1 {
            continue;
        }
        // An over-aligned automatic object (C11 6.7.5) lives sp-relative in the
        // realigned region keyed by its base slot; splitting it would strand
        // the fields at fp-relative slots off their boundary.
        if func.over_aligned.iter().any(|&(s, _)| s == base) {
            continue;
        }
        cells_of
            .entry(base)
            .and_modify(|c| *c = (*c).min(cells))
            .or_insert(cells);
    }
    if cells_of.is_empty() {
        return None;
    }
    let pinned = pinned_slots(func);
    cells_of.retain(|&base, &mut cells| pinned.range(base..base + cells).next().is_none());
    if cells_of.is_empty() {
        None
    } else {
        Some(cells_of)
    }
}

/// Frame slots whose contents this pass cannot redirect, because
/// something other than the base-address expressions it rewrites reaches
/// the same storage: the emit and the callee ABI write some of it
/// without naming an instruction operand, and a direct slot access reads
/// or writes it under a second name. Redirecting only the address-based
/// accesses would leave the two views disagreeing -- or, for storage
/// with no store in the tape at all, promote an undefined value.
///
/// The set mirrors what `ssa::slot_coalesce` reserves and renumbers, the
/// one enumeration of every way a frame slot is named.
fn pinned_slots(func: &FunctionSsa) -> BTreeSet<i64> {
    let mut pinned: BTreeSet<i64> = BTreeSet::new();
    let mut add = |s: i64| {
        if s < 0 {
            pinned.insert(s);
        }
    };
    add(func.indirect_result_slot);
    for &s in &func.param_local_slots {
        add(s);
    }
    for inst in &func.insts {
        match inst {
            Inst::AllocaInit(off) | Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => {
                add(*off)
            }
            Inst::Call { ret_slot_local, .. }
            | Inst::CallIndirect { ret_slot_local, .. }
            | Inst::CallExt { ret_slot_local, .. } => add(*ret_slot_local),
            _ => {}
        }
    }
    pinned
}

/// Bytes `[off, off + width)` of the little-endian representation of
/// `k`, sign-extended to the register a store of that width reads.
fn sub_word(k: i64, off: i64, width: i64) -> i64 {
    if !(0..8).contains(&off) {
        return 0;
    }
    let shifted = ((k as u64) >> (8 * off as u32)) as i64;
    match width {
        1 => shifted as i8 as i64,
        2 => shifted as i16 as i64,
        4 => shifted as i32 as i64,
        _ => shifted,
    }
}

/// What one old instruction expands to: the original write when `keep`
/// -- an object a call still reads needs its storage written -- then the
/// slot store `mirror` names, taking the kept store's value, then the
/// per-field writes in `copies`. All three empty replaces the write with
/// a no-op, which is what decomposing a write to a fully split object
/// leaves.
#[derive(Default)]
struct Expansion {
    keep: bool,
    mirror: Option<(i64, StoreKind)>,
    copies: Vec<CopyField>,
}

/// Replace each write named in `expand` with what it expands to,
/// renumbering the tape around the insertions.
fn expand_writes(func: &mut FunctionSsa, splits: &BTreeMap<u32, Expansion>) {
    let n = func.insts.len();
    let old_ranges: Vec<core::ops::Range<u32>> =
        func.blocks.iter().map(|b| b.inst_range.clone()).collect();
    // Layout first: an instruction's new id is the last id of its
    // replacement group, so the operand rewrite below reads a complete
    // map.
    let mut value_remap: Vec<ValueId> = alloc::vec![NO_VALUE; n];
    let mut next: u32 = 0;
    for range in &old_ranges {
        for old in range.start..range.end {
            next += group_len(splits, old);
            value_remap[old as usize] = next - 1;
        }
    }
    let total = next as usize;
    let remap = |v: ValueId| -> ValueId {
        match value_remap.get(v as usize) {
            Some(&new) if v != NO_VALUE => new,
            _ => v,
        }
    };

    let mut new_insts: Vec<Inst> = Vec::with_capacity(total);
    let mut new_src: Vec<(u32, u32)> = Vec::with_capacity(total);
    let mut new_f32: Vec<bool> = Vec::with_capacity(total);
    for (bi, range) in old_ranges.iter().enumerate() {
        let start = new_insts.len() as u32;
        for old in range.start..range.end {
            let loc = func.inst_src.get(old as usize).copied().unwrap_or((0, 0));
            match splits.get(&old) {
                Some(e) => {
                    let src = match func.insts[old as usize] {
                        Inst::Mcpy { src, .. } => remap(src),
                        _ => NO_VALUE,
                    };
                    let mut kept_value = NO_VALUE;
                    if e.keep {
                        let mut inst = func.insts[old as usize].clone();
                        inst.for_each_operand_mut(|v| *v = remap(*v));
                        if let Inst::Store { value, .. } = inst {
                            kept_value = value;
                        }
                        new_insts.push(inst);
                        new_src.push(loc);
                        new_f32.push(func.f32_values.get(old as usize).copied().unwrap_or(false));
                    }
                    if let Some((slot, kind)) = e.mirror {
                        new_insts.push(Inst::StoreLocal {
                            off: slot,
                            value: kept_value,
                            kind,
                            volatile: false,
                        });
                        new_src.push(loc);
                        new_f32.push(false);
                    }
                    for c in &e.copies {
                        let loaded = new_insts.len() as ValueId;
                        new_insts.push(match c.imm {
                            Some(k) => Inst::Imm(k),
                            None => Inst::Load {
                                addr: src,
                                disp: c.off as i32,
                                kind: c.load,
                                volatile: false,
                                align: 0,
                            },
                        });
                        new_insts.push(Inst::StoreLocal {
                            off: c.slot,
                            value: loaded,
                            kind: c.store,
                            volatile: false,
                        });
                        new_src.push(loc);
                        new_src.push(loc);
                        new_f32.push(false);
                        new_f32.push(false);
                    }
                    if !e.keep && e.mirror.is_none() && e.copies.is_empty() {
                        new_insts.push(Inst::Imm(0));
                        new_src.push(loc);
                        new_f32.push(false);
                    }
                }
                None => {
                    let mut inst = func.insts[old as usize].clone();
                    inst.for_each_operand_mut(|v| *v = remap(*v));
                    new_insts.push(inst);
                    new_src.push(loc);
                    new_f32.push(func.f32_values.get(old as usize).copied().unwrap_or(false));
                }
            }
        }
        func.blocks[bi].inst_range = start..new_insts.len() as u32;
    }
    for block in func.blocks.iter_mut() {
        block.exit_acc = remap(block.exit_acc);
        block.terminator.for_each_operand_mut(|v| *v = remap(*v));
    }
    // The per-site cross-TU relocation tables key on the value id of the
    // instruction naming the symbol, so they move with the operands.
    for table in [
        &mut func.extern_call_refs,
        &mut func.extern_imm_code_refs,
        &mut func.extern_imm_data_refs,
        &mut func.extern_tls_refs,
    ] {
        for (v, _) in table.iter_mut() {
            *v = remap(*v);
        }
    }
    func.insts = new_insts;
    func.inst_src = new_src;
    func.f32_values = new_f32;
}

/// Instruction count an old tape position expands to.
fn group_len(splits: &BTreeMap<u32, Expansion>, old: u32) -> u32 {
    match splits.get(&old) {
        Some(e) => {
            (u32::from(e.keep) + u32::from(e.mirror.is_some()) + 2 * e.copies.len() as u32).max(1)
        }
        None => 1,
    }
}

/// Load / store kinds moving `width` bytes through an integer register.
fn copy_kinds(width: i64) -> (LoadKind, StoreKind) {
    match width {
        1 => (LoadKind::U8, StoreKind::I8),
        2 => (LoadKind::U16, StoreKind::I16),
        4 => (LoadKind::U32, StoreKind::I32),
        _ => (LoadKind::I64, StoreKind::I64),
    }
}

fn load_width(kind: LoadKind) -> i64 {
    match kind {
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I64 | LoadKind::F64 => 8,
        LoadKind::F80 | LoadKind::F128 => 16,
    }
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

/// Resolve `v` to `(base_slot, byte_offset)` when it is a `LocalAddr`
/// plus a chain of constant Add / Sub, else `None`. Memoised; `state`
/// holds 0 (unvisited), 1 (in progress -- a cycle, treated as None), or
/// 2 (done).
fn resolve_addr(
    insts: &[Inst],
    v: ValueId,
    state: &mut [u8],
    resolved: &mut [Option<(i64, i64)>],
) -> Option<(i64, i64)> {
    resolve_base(insts, v, state, resolved, false)
}

/// Resolve `v` to `(root, byte offset)` when it is an address expression
/// built from a root through constant `Add` / `Sub`. The root is a
/// `LocalAddr`'s slot, or -- under `param_root` -- a `ParamRef`'s
/// parameter index.
fn resolve_base(
    insts: &[Inst],
    v: ValueId,
    state: &mut [u8],
    resolved: &mut [Option<(i64, i64)>],
    param_root: bool,
) -> Option<(i64, i64)> {
    let vi = v as usize;
    if vi >= insts.len() {
        return None;
    }
    match state[vi] {
        1 => return None,
        2 => return resolved[vi],
        _ => {}
    }
    state[vi] = 1;
    let imm = |id: ValueId| -> Option<i64> {
        match insts.get(id as usize) {
            Some(Inst::Imm(k)) => Some(*k),
            _ => None,
        }
    };
    let r = match &insts[vi] {
        Inst::LocalAddr(s) if !param_root => Some((*s, 0)),
        Inst::ParamRef { idx, .. } if param_root => Some((*idx as i64, 0)),
        Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm,
        } => resolve_base(insts, *lhs, state, resolved, param_root).map(|(s, o)| (s, o + *rhs_imm)),
        Inst::BinopI {
            op: BinOp::Sub,
            lhs,
            rhs_imm,
        } => resolve_base(insts, *lhs, state, resolved, param_root).map(|(s, o)| (s, o - *rhs_imm)),
        Inst::Binop {
            op: BinOp::Add,
            lhs,
            rhs,
        } => {
            if let Some(c) = imm(*rhs) {
                resolve_base(insts, *lhs, state, resolved, param_root).map(|(s, o)| (s, o + c))
            } else if let Some(c) = imm(*lhs) {
                resolve_base(insts, *rhs, state, resolved, param_root).map(|(s, o)| (s, o + c))
            } else {
                None
            }
        }
        Inst::Binop {
            op: BinOp::Sub,
            lhs,
            rhs,
        } => {
            if let Some(c) = imm(*rhs) {
                resolve_base(insts, *lhs, state, resolved, param_root).map(|(s, o)| (s, o - c))
            } else {
                None
            }
        }
        _ => None,
    };
    state[vi] = 2;
    resolved[vi] = r;
    r
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{Block, Terminator};

    /// The pass over one function with no other function in view: every
    /// call parameter is opaque, which is what the pre-footprint
    /// admission did.
    fn split_objects(func: &mut FunctionSsa, budget: usize) -> Vec<Split> {
        super::split_objects(func, budget, &FootprintMap::new(), &BTreeSet::new())
    }

    fn run(func: &mut FunctionSsa, budget: usize) -> Vec<i64> {
        super::run(func, budget, &FootprintMap::new())
    }

    fn func(insts: Vec<Inst>, term: Terminator, multi_cell: Vec<(i64, i64)>) -> FunctionSsa {
        let n = insts.len() as u32;
        FunctionSsa {
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            insts,
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: term,
                exit_acc: NO_VALUE,
            }],
            multi_cell_slots: multi_cell,
            locals: 4,
            ..FunctionSsa::default()
        }
    }

    fn store(addr: ValueId, value: ValueId) -> Inst {
        Inst::Store {
            addr,
            disp: 0,
            value,
            kind: StoreKind::I64,
            volatile: false,
            align: 0,
        }
    }
    fn load(addr: ValueId) -> Inst {
        Inst::Load {
            addr,
            disp: 0,
            kind: LoadKind::I64,
            volatile: false,
            align: 0,
        }
    }
    fn add_imm(lhs: ValueId, k: i64) -> Inst {
        Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm: k,
        }
    }

    /// Two-element local array `a` at base slot -2: a[0]=v0 via
    /// LocalAddr(-2), a[1]=v3 via LocalAddr(-2)+8, then read back.
    fn two_elem_array() -> FunctionSsa {
        let insts = alloc::vec![
            Inst::Imm(5),        // v0
            Inst::LocalAddr(-2), // v1
            store(1, 0),         // v2  a[0] = 5
            Inst::Imm(7),        // v3
            Inst::LocalAddr(-2), // v4
            add_imm(4, 8),       // v5  &a[1]
            store(5, 3),         // v6  a[1] = 7
            Inst::LocalAddr(-2), // v7
            load(7),             // v8  a[0]
            Inst::LocalAddr(-2), // v9
            add_imm(9, 8),       // v10 &a[1]
            load(10),            // v11 a[1]
            Inst::Binop {
                op: BinOp::Add,
                lhs: 8,
                rhs: 11,
            }, // v12 a[0] + a[1]
        ];
        func(insts, Terminator::Return(12), alloc::vec![(-2, 2)])
    }

    #[test]
    fn const_index_array_splits_and_promotes() {
        let mut f = two_elem_array();
        let promoted = run(&mut f, 64);
        assert_eq!(promoted, alloc::vec![-2], "the array's base slot promotes");
        assert!(
            !f.insts
                .iter()
                .any(|i| matches!(i, Inst::StoreLocal { off: -2 | -1, .. })),
            "promoted stores are neutralised"
        );
    }

    #[test]
    fn dead_local_addr_neutralised() {
        let mut f = two_elem_array();
        let split = split_objects(&mut f, 64);
        assert_eq!(split.len(), 1);
        assert_eq!((split[0].base, split[0].slots.clone()), (-2, alloc::vec![-2, -1]));
        // Store/Load rewritten to per-element slots (-2 for a[0], -1 for a[1]).
        assert!(matches!(f.insts[2], Inst::StoreLocal { off: -2, .. }));
        assert!(matches!(f.insts[6], Inst::StoreLocal { off: -1, .. }));
        assert!(matches!(f.insts[8], Inst::LoadLocal { off: -2, .. }));
        assert!(matches!(f.insts[11], Inst::LoadLocal { off: -1, .. }));
        // Base-address instructions (LocalAddr + Add) neutralised.
        for id in [1usize, 4, 5, 7, 9, 10] {
            assert!(
                matches!(f.insts[id], Inst::Imm(0)),
                "address expr v{id} must be neutralised, got {:?}",
                f.insts[id]
            );
        }
    }

    #[test]
    fn over_budget_object_not_split() {
        // The two-element array needs 2 register slots; a budget of 1
        // leaves it memory-resident (the re-run would spill it back).
        let mut f = two_elem_array();
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 1);
        assert!(split.is_empty(), "over-budget object must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    /// Two objects whose joint demand exceeds the budget: the one with
    /// the larger demand splits, the other stays memory-resident, so a
    /// small newcomer never turns a fitting split into no split at all.
    #[test]
    fn budget_admits_largest_demand_first() {
        let mut insts = two_elem_array().insts;
        let k = insts.len() as ValueId;
        // One-cell object at -3: store then load one 8-byte field.
        insts.push(Inst::Imm(9)); //          v13
        insts.push(Inst::LocalAddr(-3)); //   v14
        insts.push(store(k + 1, k)); //       v15
        insts.push(Inst::LocalAddr(-3)); //   v16
        insts.push(load(k + 3)); //           v17
        let mut f = func(insts, Terminator::Return(12), alloc::vec![(-2, 2), (-3, 1)]);
        let split = split_objects(&mut f, 2);
        assert_eq!(
            split.iter().map(|s| (s.base, s.slots.clone())).collect::<Vec<_>>(),
            alloc::vec![(-2, alloc::vec![-2, -1])],
            "only the two-field array fits the budget"
        );
        assert!(
            matches!(f.insts[14], Inst::LocalAddr(-3)),
            "the skipped object keeps its address expressions"
        );
    }

    /// `Block::exit_acc` naming an address into the object is a liveness
    /// pin, not a use of the address, so it must not decline the split;
    /// the neutralised expression still defines a value there.
    #[test]
    fn base_address_as_exit_acc_still_splits() {
        let mut f = two_elem_array();
        f.blocks[0].exit_acc = 9; // LocalAddr(-2)
        let split = split_objects(&mut f, 64);
        assert_eq!(split.len(), 1);
        assert_eq!((split[0].base, split[0].slots.clone()), (-2, alloc::vec![-2, -1]));
        assert!(matches!(f.insts[9], Inst::Imm(0)));
    }

    #[test]
    fn runtime_index_object_not_split() {
        // a[0]=v0 (constant), then a load at a runtime offset.
        let insts = alloc::vec![
            Inst::Imm(5),        // v0
            Inst::LocalAddr(-2), // v1
            store(1, 0),         // v2 a[0]=5
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I64,
            }, // v3 runtime k
            Inst::LocalAddr(-2), // v4
            Inst::Binop {
                op: BinOp::Add,
                lhs: 4,
                rhs: 3,
            }, // v5 &a[k] (runtime)
            load(5),             // v6
        ];
        let mut f = func(insts, Terminator::Return(6), alloc::vec![(-2, 2)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "runtime-index object must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    #[test]
    fn escaped_address_object_not_split() {
        // Const-index stores plus the base address escaping through the
        // terminator: the whole object must stay memory-resident.
        let insts = alloc::vec![
            Inst::Imm(5),        // v0
            Inst::LocalAddr(-2), // v1
            store(1, 0),         // v2 a[0]=5
            Inst::LocalAddr(-2), // v3 escapes below
        ];
        let mut f = func(insts, Terminator::Return(3), alloc::vec![(-2, 2)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "escaped-address object must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    #[test]
    fn function_without_candidate_objects_untouched() {
        // No multi-cell locals: nothing to scalarize, and the mem2reg
        // re-run never fires.
        let insts = alloc::vec![
            Inst::Imm(1),
            Inst::LoadLocal {
                off: 2,
                kind: LoadKind::I64,
                volatile: false,
            },
        ];
        let mut f = func(insts, Terminator::Return(1), alloc::vec![]);
        let before = alloc::format!("{:?}", f.insts);
        let promoted = run(&mut f, 64);
        assert!(promoted.is_empty());
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    /// A struct with a 4-byte member at offset 0 and an 8-byte member at
    /// offset 8: the fields are not slot-pitch aligned as a group, so
    /// each takes a fresh slot.
    #[test]
    fn sub_word_fields_take_fresh_slots() {
        let insts = alloc::vec![
            Inst::Imm(3),        // v0
            Inst::LocalAddr(-4), // v1
            Inst::Store {
                addr: 1,
                disp: 0,
                value: 0,
                kind: StoreKind::I32,
                volatile: false,
                align: 0,
            }, // v2 s.state = 3
            Inst::LocalAddr(-4), // v3
            Inst::Load {
                addr: 3,
                disp: 0,
                kind: LoadKind::U32,
                volatile: false,
                align: 0,
            }, // v4 s.state
        ];
        let mut f = func(insts, Terminator::Return(4), alloc::vec![(-4, 4)]);
        let split = split_objects(&mut f, 64);
        assert_eq!(split.len(), 1, "the struct splits");
        // Offset 0 is a lone 8-aligned field, so it reuses cell 0.
        assert!(matches!(
            f.insts[2],
            Inst::StoreLocal {
                off: -4,
                kind: StoreKind::I32,
                ..
            }
        ));
        assert!(matches!(
            f.insts[4],
            Inst::LoadLocal {
                off: -4,
                kind: LoadKind::U32,
                ..
            }
        ));
    }

    /// A one-cell aggregate splits and promotes end to end: both
    /// members are lifted and the base slot is reported fully promoted.
    #[test]
    fn one_cell_aggregate_promotes_through_run() {
        let insts = alloc::vec![
            Inst::Imm(1),        // v0
            Inst::LocalAddr(-2), // v1
            Inst::Store {
                addr: 1,
                disp: 0,
                value: 0,
                kind: StoreKind::I32,
                volatile: false,
                align: 0,
            }, // v2
            Inst::Imm(2),        // v3
            Inst::LocalAddr(-2), // v4
            Inst::Store {
                addr: 4,
                disp: 4,
                value: 3,
                kind: StoreKind::I32,
                volatile: false,
                align: 0,
            }, // v5
            Inst::LocalAddr(-2), // v6
            Inst::Load {
                addr: 6,
                disp: 0,
                kind: LoadKind::U32,
                volatile: false,
                align: 0,
            }, // v7
            Inst::LocalAddr(-2), // v8
            Inst::Load {
                addr: 8,
                disp: 4,
                kind: LoadKind::U32,
                volatile: false,
                align: 0,
            }, // v9
            Inst::Binop {
                op: BinOp::Add,
                lhs: 7,
                rhs: 9,
            }, // v10
        ];
        let mut f = func(insts, Terminator::Return(10), alloc::vec![(-2, 1)]);
        let promoted = run(&mut f, 64);
        assert_eq!(promoted, alloc::vec![-2], "the one-cell base promotes");
        assert!(
            !f.insts
                .iter()
                .any(|i| matches!(i, Inst::Store { .. } | Inst::StoreLocal { .. })),
            "no member store survives: {:?}",
            f.insts
        );
        // The re-run forwarded both member loads to the stored values.
        assert!(
            f.insts.iter().any(|i| matches!(
                i,
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs: 3,
                }
            )),
            "the sum reads the stored values directly: {:?}",
            f.insts
        );
    }

    /// Two fields inside one 8-byte cell cannot reuse the object's
    /// storage; both take fresh slots below the existing frame.
    #[test]
    fn fields_sharing_a_cell_take_fresh_slots() {
        let insts = alloc::vec![
            Inst::Imm(1),        // v0
            Inst::LocalAddr(-2), // v1
            Inst::Store {
                addr: 1,
                disp: 0,
                value: 0,
                kind: StoreKind::I32,
                volatile: false,
                align: 0,
            }, // v2
            Inst::LocalAddr(-2), // v3
            Inst::Store {
                addr: 3,
                disp: 4,
                value: 0,
                kind: StoreKind::I32,
                volatile: false,
                align: 0,
            }, // v4
            Inst::LocalAddr(-2), // v5
            Inst::Load {
                addr: 5,
                disp: 4,
                kind: LoadKind::I32,
                volatile: false,
                align: 0,
            }, // v6
        ];
        let mut f = func(insts, Terminator::Return(6), alloc::vec![(-2, 1)]);
        let split = split_objects(&mut f, 64);
        assert_eq!(split.len(), 1);
        let slots = &split[0].slots;
        assert!(
            slots.iter().all(|&s| s < -4),
            "fields sharing a cell take fresh slots, got {slots:?}"
        );
    }

    /// An access that overlaps another at a second width and carries a
    /// value no narrower store can reproduce leaves the object in
    /// memory: the field decomposition is not a partition.
    #[test]
    fn overlapping_widths_not_split() {
        let insts = alloc::vec![
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I64
            }, // v0
            Inst::LocalAddr(-2), // v1
            store(1, 0),         // v2 8-byte store at 0
            Inst::LocalAddr(-2), // v3
            Inst::Load {
                addr: 3,
                disp: 0,
                kind: LoadKind::I32,
                volatile: false,
                align: 0,
            }, // v4 4-byte load at 0
        ];
        let mut f = func(insts, Terminator::Return(4), alloc::vec![(-2, 1)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "overlapping widths must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    /// A store of an immediate spanning a narrower field is
    /// object-granularity initialization -- what an aggregate's zero
    /// fill emits per cell -- and decomposes into a store of the bytes
    /// that land on each field, which is what lets the object split.
    #[test]
    fn constant_fill_over_a_narrower_field_splits() {
        let insts = alloc::vec![
            Inst::Imm(0x9abc_def0_1234_5678u64 as i64), // v0
            Inst::LocalAddr(-2),                        // v1
            store(1, 0),                                // v2 8-byte fill at 0
            Inst::LocalAddr(-2),                        // v3
            Inst::Load {
                addr: 3,
                disp: 0,
                kind: LoadKind::I32,
                volatile: false,
                align: 0,
            }, // v4 4-byte load at 0
            Inst::Load {
                addr: 3,
                disp: 4,
                kind: LoadKind::I32,
                volatile: false,
                align: 0,
            }, // v5 4-byte load at 4
        ];
        let mut f = func(insts, Terminator::Return(5), alloc::vec![(-2, 1)]);
        let split = split_objects(&mut f, 64);
        assert_eq!(split.len(), 1, "the fill must not block the split");
        // The fill became one immediate + store per field, little-endian:
        // the low word to the field at 0, the high word to the field at 4.
        let imms: Vec<i64> = f
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Imm(k) => Some(*k),
                _ => None,
            })
            .collect();
        assert!(
            imms.contains(&0x1234_5678) && imms.contains(&(0x9abc_def0u32 as i32 as i64)),
            "each field takes the bytes of the constant that land on it: {imms:x?}"
        );
        assert!(
            !f.insts.iter().any(|i| matches!(i, Inst::Store { .. })),
            "no address-based store survives the split"
        );
    }

    /// A store of an immediate that is itself a field keeps its width:
    /// demotion is for a store spanning more than one field, so an
    /// ordinary constant member assignment stays a plain access.
    #[test]
    fn constant_store_matching_a_field_stays_an_access() {
        let insts = alloc::vec![
            Inst::Imm(7),        // v0
            Inst::LocalAddr(-2), // v1
            store(1, 0),         // v2 8-byte store at 0
            Inst::LocalAddr(-2), // v3
            load(3),             // v4 8-byte load at 0
        ];
        let mut f = func(insts, Terminator::Return(4), alloc::vec![(-2, 1)]);
        let split = split_objects(&mut f, 64);
        assert_eq!(split.len(), 1);
        assert!(
            f.insts.iter().any(|i| matches!(
                i,
                Inst::StoreLocal {
                    value: 0,
                    kind: StoreKind::I64,
                    ..
                }
            )),
            "the store keeps its own value and width: {:?}",
            f.insts
        );
    }

    /// A template `Mcpy` filling the object decomposes into a per-field
    /// load from the template plus a store to the field slot.
    #[test]
    fn block_initializer_splits_into_field_copies() {
        let insts = alloc::vec![
            Inst::LocalAddr(-2), // v0
            Inst::ImmData(64),   // v1
            Inst::Mcpy {
                dst: 0,
                src: 1,
                size: 16,
                align: 8
            }, // v2
            Inst::LocalAddr(-2), // v3
            Inst::Load {
                addr: 3,
                disp: 8,
                kind: LoadKind::I64,
                volatile: false,
                align: 0,
            }, // v4
        ];
        let mut f = func(insts, Terminator::Return(4), alloc::vec![(-2, 2)]);
        let split = split_objects(&mut f, 64);
        assert_eq!(split.len(), 1, "the initialized object splits");
        // The Mcpy became one load/store pair for the single live field.
        let pairs: Vec<_> = f
            .insts
            .iter()
            .enumerate()
            .filter(|(_, i)| matches!(i, Inst::StoreLocal { .. }))
            .collect();
        assert_eq!(pairs.len(), 1, "one field copy, got {:?}", f.insts);
        let (si, _) = pairs[0];
        assert!(
            matches!(
                f.insts[si - 1],
                Inst::Load {
                    addr: 1,
                    disp: 8,
                    kind: LoadKind::I64,
                    ..
                }
            ),
            "field copy reads the template at the field offset, got {:?}",
            f.insts[si - 1]
        );
        // The block range covers the grown tape.
        assert_eq!(f.blocks[0].inst_range, 0..f.insts.len() as u32);
    }

    /// An `Mcpy` reading the object escapes it: the pass models filling
    /// an object from elsewhere, not copying it out.
    #[test]
    fn block_copy_out_of_object_not_split() {
        let insts = alloc::vec![
            Inst::LocalAddr(-2), // v0
            Inst::ImmData(64),   // v1
            Inst::Mcpy {
                dst: 1,
                src: 0,
                size: 16,
                align: 8
            }, // v2
            Inst::LocalAddr(-2), // v3
            load(3),             // v4
        ];
        let mut f = func(insts, Terminator::Return(4), alloc::vec![(-2, 2)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(
            split.is_empty(),
            "object read by a block copy must not split"
        );
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    /// A by-value aggregate parameter's body slot is filled by the
    /// prologue, not by the tape, so it is never a candidate.
    #[test]
    fn aggregate_parameter_slot_not_split() {
        let insts = alloc::vec![
            Inst::LocalAddr(-2), // v0
            load(0),             // v1
        ];
        let mut f = func(insts, Terminator::Return(1), alloc::vec![(-2, 2)]);
        f.param_local_slots = alloc::vec![-2];
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "parameter storage must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    /// The caller-side temporary a callee's aggregate return
    /// materialises into is filled through the host ABI, named only by
    /// the call's `ret_slot_local`. Redirecting its member loads to
    /// field slots would leave them reading storage nothing wrote.
    #[test]
    fn aggregate_return_temp_not_split() {
        let insts = alloc::vec![
            Inst::Call {
                target_pc: 7,
                args: Vec::new(),
                fixed_args: 0,
                fp_return: false,
                fp_arg_mask: 0,
                arg_aggs: Vec::new(),
                ret_agg: Some(0),
                ret_slot_local: -2,
            }, // v0
            Inst::LocalAddr(-2), // v1
            load(1),             // v2
            Inst::LocalAddr(-2), // v3
            add_imm(3, 8),       // v4
            load(4),             // v5
        ];
        let mut f = func(insts, Terminator::Return(5), alloc::vec![(-2, 2)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "an aggregate-return temp must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    /// A cell the tape also names directly is read and written under a
    /// second name the redirect would not follow.
    #[test]
    fn cell_with_a_direct_slot_access_not_split() {
        let insts = alloc::vec![
            Inst::Imm(5), // v0
            Inst::StoreLocal {
                off: -1,
                value: 0,
                kind: StoreKind::I64,
                volatile: false
            }, // v1  a[1] through the slot
            Inst::LocalAddr(-2), // v2
            store(2, 0),  // v3  a[0] through the address
            Inst::LocalAddr(-2), // v4
            add_imm(4, 8), // v5
            load(5),      // v6  a[1] through the address
        ];
        let mut f = func(insts, Terminator::Return(6), alloc::vec![(-2, 2)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "a directly named cell must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    /// A volatile access keeps the object memory-resident (C99 6.7.3p6).
    #[test]
    fn volatile_access_not_split() {
        let insts = alloc::vec![
            Inst::Imm(1),        // v0
            Inst::LocalAddr(-2), // v1
            Inst::Store {
                addr: 1,
                disp: 0,
                value: 0,
                kind: StoreKind::I64,
                volatile: true,
                align: 0,
            }, // v2
        ];
        let mut f = func(insts, Terminator::Return(2), alloc::vec![(-2, 1)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "volatile access must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    /// One-parameter callee with the given body, entered at `ent_pc`.
    fn callee(ent_pc: usize, insts: Vec<Inst>, term: Terminator) -> FunctionSsa {
        let n = insts.len() as u32;
        FunctionSsa {
            ent_pc,
            n_params: 1,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            insts,
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: term,
                exit_acc: NO_VALUE,
            }],
            ..FunctionSsa::default()
        }
    }

    fn param() -> Inst {
        Inst::ParamRef {
            idx: 0,
            kind: LoadKind::I64,
        }
    }

    fn call_to(target_pc: usize, args: Vec<ValueId>) -> Inst {
        Inst::Call {
            target_pc,
            fixed_args: args.len(),
            args,
            fp_return: false,
            fp_arg_mask: 0,
            arg_aggs: Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        }
    }

    /// A body reaching its pointer parameter only through constant
    /// offsets reports those ranges; the caller handing the pointer on
    /// inherits them, shifted by the argument's own offset.
    #[test]
    fn param_footprint_records_ranges_and_forwards() {
        let leaf = callee(
            100,
            alloc::vec![
                param(),                              // v0
                Inst::Load {
                    addr: 0,
                    disp: 8,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                }, // v1  reads [8, 16)
                Inst::Imm(5),                         // v2
                store(0, 2),                          // v3  writes [0, 8)
            ],
            Terminator::Return(1),
        );
        let mid = callee(
            200,
            alloc::vec![
                param(),          // v0
                add_imm(0, 16),   // v1
                call_to(100, alloc::vec![1]), // v2
            ],
            Terminator::Return(2),
        );
        let fps = param_footprints(&[leaf, mid]);
        assert_eq!(fps[&(100, 0)].reads, alloc::vec![(8, 8)]);
        assert_eq!(fps[&(100, 0)].writes, alloc::vec![(0, 8)]);
        assert_eq!(fps[&(200, 0)].reads, alloc::vec![(24, 8)]);
        assert_eq!(fps[&(200, 0)].writes, alloc::vec![(16, 8)]);
    }

    /// A body that lets the pointer reach anything else keeps no
    /// footprint, so an object handed to it is declined as before.
    #[test]
    fn param_footprint_absent_when_the_pointer_escapes() {
        let escaping = callee(
            100,
            alloc::vec![
                param(),             // v0
                Inst::LocalAddr(-1), // v1
                store(1, 0),         // v2  the pointer itself is stored
            ],
            Terminator::Return(2),
        );
        let variadic = FunctionSsa {
            is_variadic: true,
            ..callee(200, alloc::vec![param()], Terminator::Return(0))
        };
        let fps = param_footprints(&[escaping, variadic]);
        assert!(fps.get(&(100, 0)).is_none(), "a stored pointer is opaque");
        assert!(fps.get(&(200, 0)).is_none(), "a variadic body is opaque");
    }

    /// Caller holding a two-cell object at -2: field 0 written then
    /// read, field 8 written then read, and the object's address handed
    /// to `target`.
    fn caller_passing_object(target: usize) -> FunctionSsa {
        let insts = alloc::vec![
            Inst::Imm(1),        // v0
            Inst::LocalAddr(-2), // v1
            store(1, 0),         // v2  o.a = 1
            Inst::Imm(2),        // v3
            Inst::LocalAddr(-2), // v4
            add_imm(4, 8),       // v5
            store(5, 3),         // v6  o.b = 2
            Inst::LocalAddr(-2), // v7
            call_to(target, alloc::vec![7]), // v8
            Inst::LocalAddr(-2), // v9
            load(9),             // v10 o.a
            Inst::LocalAddr(-2), // v11
            add_imm(11, 8),      // v12
            load(12),            // v13 o.b
            Inst::Binop {
                op: BinOp::Add,
                lhs: 10,
                rhs: 13,
            }, // v14
            Inst::LocalAddr(-2), // v15
            add_imm(15, 8),      // v16
            load(16),            // v17 o.b again: two reads, one write
            Inst::Binop {
                op: BinOp::Add,
                lhs: 14,
                rhs: 17,
            }, // v18
        ];
        func(insts, Terminator::Return(18), alloc::vec![(-2, 2)])
    }

    /// An object a call reaches gives up the fields that call cannot
    /// write: the written field keeps its storage and its accesses, the
    /// other moves to a slot, and the base address survives for the
    /// callee to read.
    #[test]
    fn call_argument_object_splits_the_fields_the_callee_cannot_write() {
        let writer = callee(
            100,
            alloc::vec![param(), Inst::Imm(9), store(0, 1)],
            Terminator::Return(2),
        );
        let fps = param_footprints(&[writer]);
        let mut f = caller_passing_object(100);
        let split = super::split_objects(&mut f, 64, &fps, &BTreeSet::new());
        assert_eq!(split.len(), 1, "the object splits partially");
        assert!(split[0].address_live, "its storage stays for the callee");
        assert!(
            matches!(f.insts[1], Inst::LocalAddr(-2)),
            "the base address must survive"
        );
        assert!(
            matches!(f.insts[10], Inst::Load { .. }),
            "the written field keeps its memory read"
        );
        assert!(
            matches!(f.insts[13], Inst::LoadLocal { .. }),
            "the untouched field reads its slot"
        );
        assert!(
            matches!(f.insts[6], Inst::StoreLocal { .. }),
            "and writes it, with no memory write left"
        );
    }

    /// A field the callee only reads still moves to a slot, and its
    /// store writes both, so the bytes the call sees stay current.
    #[test]
    fn a_field_the_callee_reads_keeps_its_memory_write() {
        let reader = callee(
            100,
            alloc::vec![
                param(),
                Inst::Load {
                    addr: 0,
                    disp: 8,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                },
            ],
            Terminator::Return(1),
        );
        let fps = param_footprints(&[reader]);
        let mut f = caller_passing_object(100);
        let split = super::split_objects(&mut f, 64, &fps, &BTreeSet::new());
        assert_eq!(split.len(), 1);
        assert!(split[0].address_live);
        let stores = f
            .insts
            .iter()
            .enumerate()
            .filter(|(_, i)| matches!(i, Inst::Store { .. } | Inst::StoreLocal { .. }))
            .map(|(i, _)| i)
            .collect::<Vec<_>>();
        assert_eq!(
            stores.len(),
            3,
            "the read field's store is mirrored into its slot: {:?}",
            f.insts
        );
        assert!(
            matches!(f.insts[stores[1]], Inst::Store { .. })
                && matches!(f.insts[stores[2]], Inst::StoreLocal { .. }),
            "the memory write comes first, then the slot's"
        );
    }

    /// The mirror is not free: a field the call reads whose writes match
    /// its reads pays a store for every load it saves, so it stays in
    /// the object.
    #[test]
    fn a_read_field_with_no_reuse_stays_in_the_object() {
        let reader = callee(
            100,
            alloc::vec![
                param(),
                Inst::Load {
                    addr: 0,
                    disp: 8,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                },
            ],
            Terminator::Return(1),
        );
        let fps = param_footprints(&[reader]);
        let mut f = caller_passing_object(100);
        // Drop the second read of the field, leaving one of each.
        f.insts[17] = Inst::Imm(0);
        let split = super::split_objects(&mut f, 64, &fps, &BTreeSet::new());
        assert_eq!(split.len(), 1);
        assert!(
            matches!(f.insts[13], Inst::Load { .. }),
            "the mirrored field must not pay for itself"
        );
        assert!(
            matches!(f.insts[10], Inst::LoadLocal { .. }),
            "the untouched field still promotes"
        );
    }

    /// An opaque parameter declines the object, as every other use this
    /// pass does not model does.
    #[test]
    fn call_with_an_opaque_parameter_declines_the_object() {
        let mut f = caller_passing_object(100);
        let before = alloc::format!("{:?}", f.insts);
        let split = super::split_objects(&mut f, 64, &FootprintMap::new(), &BTreeSet::new());
        assert!(split.is_empty(), "an unsummarised callee declines");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }
}

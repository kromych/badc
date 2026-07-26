//! Promotion of a single-store address-taken slot to its stored value.
//!
//! A one-word struct return is materialised into a caller frame slot: the
//! callee's result write lands in the slot, and the caller reads it back
//! with a `disp == 0` load or copies the whole slot elsewhere with an
//! `Mcpy`. When the slot's address is taken only by those reads and the
//! slot is written by a single full-width store, the slot is redundant:
//! the stored register value is what every read produces.
//!
//! ```text
//!   Store { addr=LocalAddr(S), disp=0, value=w, kind }   # the only write
//!   ...
//!   v = Load { addr=LocalAddr(S), disp=0, kind }          # -> uses of v become w
//!   Mcpy { dst=d, src=LocalAddr(S), size }                # -> Store { addr=d, value=w }
//! ```
//!
//! After inlining a one-word-struct-returning helper this collapses the
//! store + copy/reload the return slot would otherwise keep in memory,
//! handing the value to the caller in a register instead.
//!
//! Soundness rests on three conditions checked per slot:
//!   - the slot's address escapes nowhere (every `LocalAddr(S)` use is one
//!     of the recognised reads or the single store), so no other access
//!     can read or write it;
//!   - exactly one store writes it, at `disp 0`, covering the slot's full
//!     width, so one register value is the slot's entire contents;
//!   - the store and every read sit in one block with the store first, so
//!     the store dominates the reads and the value is available at each.
//! A slot failing any condition is left in memory.
//!
//! A second, piece-level form (`promote_pieces_once`) covers the
//! multi-word struct return the inliner materialises as per-field stores
//! into the call's return slot: a linear walk of the block tracks each
//! slot's disjoint (offset, width) piece values, forwards a load a piece
//! covers exactly, and propagates pieces across a whole-slot `Mcpy` into
//! another tracked slot (`S r = f(...)` copies the return slot into r's
//! slot, then reads r's fields). The same escape / one-block /
//! `LoadLocal` disciplines apply, extended to the constant displacements
//! built off a slot address. Between blocks the pieces every reachable
//! predecessor agrees on -- same offset, width and value id -- carry
//! forward, iterated to a fixed point, so a field read past an
//! intervening call and branch still forwards. A compiler-allocated slot
//! left with no unforwarded read has its writes dropped; the outer fixed
//! point then drains the copy chain one link per round.

use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId};
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

fn store_width(kind: StoreKind) -> u8 {
    match kind {
        StoreKind::I8 => 1,
        StoreKind::I16 => 2,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::I64 | StoreKind::F64 => 8,
    }
}

fn load_width(kind: LoadKind) -> u8 {
    match kind {
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I64 | LoadKind::F64 => 8,
    }
}

/// How a `disp == 0` load of width `lw` reads back a store of `sk`.
enum LoadForward {
    /// Reuse the stored value unchanged (same width, integer).
    Direct,
    /// Sign-extend the stored value's low bytes.
    Extend(LoadKind),
    /// Not forwardable (unsigned narrow or floating; see store_forward).
    No,
}

fn forward_kind(sk: StoreKind, lk: LoadKind) -> LoadForward {
    let int_store = matches!(
        sk,
        StoreKind::I8 | StoreKind::I16 | StoreKind::I32 | StoreKind::I64
    );
    if !int_store || store_width(sk) != 8 {
        // The register-resident value is a full 64-bit store; a narrower
        // store leaves the upper bits of the read undefined relative to
        // the spilled image, so restrict forwarding to the 64-bit case.
        return LoadForward::No;
    }
    match lk {
        LoadKind::I64 => LoadForward::Direct,
        LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => LoadForward::Extend(lk),
        // Unsigned sub-width and floating loads are not forwarded: Extend
        // sign-extends, and the float kinds reinterpret the bits.
        _ => LoadForward::No,
    }
}

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
        run_one(func);
    }
}

/// Per-slot accumulation while scanning a block.
struct SlotUse {
    store_idx: u32,
    word: ValueId,
    kind: StoreKind,
    loads: Vec<(u32, LoadKind)>,
    mcpys: Vec<(u32, ValueId)>, // (inst idx, dst)
    /// Full-size compound-literal zero/template copies into the slot that
    /// precede the full-width store and so are dead. A compound literal
    /// `(S){.f = v}` emits one before the field store.
    templates: Vec<u32>,
    disqualified: bool,
}

impl SlotUse {
    fn empty() -> Self {
        SlotUse {
            store_idx: 0,
            word: NO_VALUE,
            kind: StoreKind::I64,
            loads: Vec::new(),
            mcpys: Vec::new(),
            templates: Vec::new(),
            disqualified: false,
        }
    }
}

fn run_one(func: &mut FunctionSsa) {
    // A copy out of one slot can leave a second slot in the single-store
    // shape (`S r = f();` copies the return slot into r's slot, then reads
    // r). Re-run until stable so a forwarding chain fully collapses; both
    // passes are monotone (each round only removes accesses) so the
    // instruction count bounds the iterations. The one-word pass runs
    // first each round so it keeps every slot it fully handles.
    let mut rounds = func.insts.len() + 1;
    while rounds > 0 && (promote_once(func) || promote_pieces_once(func)) {
        rounds -= 1;
    }
}

/// Escape-and-visibility context shared by both promotion forms.
struct SlotCtx {
    /// Every value naming a frame-slot byte -> `(slot, byte offset)`.
    /// With `derived` set this also holds the constant `add` / `sub`
    /// displacements built off a slot address, which the piece form
    /// resolves into an access displacement.
    addrs: BTreeMap<ValueId, (i64, i64)>,
    /// Slots accessed outside the `LocalAddr` forms modelled here:
    /// `LoadLocal` / `StoreLocal`, a call's aggregate-return result temp
    /// (written by the call itself), and the indirect-result slot.
    opaque: BTreeSet<i64>,
}

fn slot_ctx(func: &FunctionSsa, derived: bool) -> SlotCtx {
    let mut addrs: BTreeMap<ValueId, (i64, i64)> = BTreeMap::new();
    for (i, inst) in func.insts.iter().enumerate() {
        match inst {
            Inst::LocalAddr(s) => {
                addrs.insert(i as ValueId, (*s, 0));
            }
            // Operand ids precede their use, so one forward walk resolves
            // a chain of constant displacements off a slot address.
            Inst::BinopI { op, lhs, rhs_imm } if derived => {
                let step = match op {
                    BinOp::Add => Some(*rhs_imm),
                    BinOp::Sub => rhs_imm.checked_neg(),
                    _ => None,
                };
                if let (Some(step), Some(&(s, off))) = (step, addrs.get(lhs))
                    && let Some(off) = off.checked_add(step)
                {
                    addrs.insert(i as ValueId, (s, off));
                }
            }
            _ => {}
        }
    }
    let mut opaque: BTreeSet<i64> = BTreeSet::new();
    for inst in &func.insts {
        match inst {
            Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => {
                opaque.insert(*off);
            }
            Inst::Call {
                ret_slot_local: s, ..
            }
            | Inst::CallIndirect {
                ret_slot_local: s, ..
            }
            | Inst::CallExt {
                ret_slot_local: s, ..
            } if *s != 0 => {
                opaque.insert(*s);
            }
            _ => {}
        }
    }
    if func.indirect_result_slot != 0 {
        opaque.insert(func.indirect_result_slot);
    }
    SlotCtx { addrs, opaque }
}

/// Slots whose address is referenced as an operand in more than one
/// block. The one-word form neutralises its store function-wide, so a
/// read anywhere else would see the slot after the store is gone.
fn multi_block_slots(func: &FunctionSsa, addrs: &BTreeMap<ValueId, (i64, i64)>) -> BTreeSet<i64> {
    let mut slot_block: BTreeMap<i64, u32> = BTreeMap::new();
    let mut multi_block: BTreeSet<i64> = BTreeSet::new();
    for (b, block) in func.blocks.iter().enumerate() {
        let b = b as u32;
        let mut refs: Vec<ValueId> = Vec::new();
        for idx in block.inst_range.clone() {
            if let Some(inst) = func.insts.get(idx as usize) {
                for_each_operand(inst, &mut |v| refs.push(*v));
            }
        }
        match &block.terminator {
            Terminator::Return(v)
            | Terminator::Bz { cond: v, .. }
            | Terminator::Bnz { cond: v, .. }
            | Terminator::GotoIndirect { target: v }
            | Terminator::JumpTable { idx: v, .. } => refs.push(*v),
            _ => {}
        }
        if block.exit_acc != NO_VALUE {
            refs.push(block.exit_acc);
        }
        for v in refs {
            if let Some(&(s, _)) = addrs.get(&v) {
                match slot_block.get(&s) {
                    Some(&bb) if bb != b => {
                        multi_block.insert(s);
                    }
                    None => {
                        slot_block.insert(s, b);
                    }
                    _ => {}
                }
            }
        }
    }
    multi_block
}

fn promote_once(func: &mut FunctionSsa) -> bool {
    let n = func.insts.len();
    if n == 0 {
        return false;
    }
    let SlotCtx {
        addrs: la_slot,
        opaque: local_accessed,
    } = slot_ctx(func, false);
    if la_slot.is_empty() {
        return false;
    }
    let multi_block = multi_block_slots(func, &la_slot);

    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; n];
    let mut rewrites: Vec<(usize, Inst)> = Vec::new();
    let mut any = false;

    for block in &func.blocks {
        // Per-block slot bookkeeping: the store and all reads must share
        // one block, so a slot's state never crosses a block boundary.
        let mut slots: BTreeMap<i64, SlotUse> = BTreeMap::new();
        let mark_disq = |slots: &mut BTreeMap<i64, SlotUse>, s: i64| {
            slots.entry(s).or_insert_with(SlotUse::empty).disqualified = true;
        };
        for idx in block.inst_range.clone() {
            let i = idx as usize;
            if i >= func.insts.len() {
                break;
            }
            match &func.insts[i] {
                Inst::Store {
                    addr,
                    disp,
                    value,
                    kind,
                    volatile,
                } => {
                    if let Some(&(s, _)) = la_slot.get(addr) {
                        // A write into a tracked slot. Promotable only as a
                        // single full-width non-volatile store at offset 0;
                        // any other store shape disqualifies the slot.
                        let full = *disp == 0 && store_width(*kind) == 8 && !*volatile;
                        let u = slots.entry(s).or_insert_with(SlotUse::empty);
                        if !u.disqualified && u.store_idx == 0 && full {
                            u.store_idx = idx;
                            u.word = *value;
                            u.kind = *kind;
                        } else {
                            u.disqualified = true;
                        }
                    }
                    // The stored value being a slot address is an escape.
                    if let Some(&(s, _)) = la_slot.get(value) {
                        mark_disq(&mut slots, s);
                    }
                }
                Inst::Load {
                    addr,
                    disp,
                    kind,
                    volatile,
                } => {
                    if let Some(&(s, _)) = la_slot.get(addr) {
                        if *disp == 0 && !*volatile {
                            slots
                                .entry(s)
                                .or_insert_with(SlotUse::empty)
                                .loads
                                .push((idx, *kind));
                        } else {
                            mark_disq(&mut slots, s);
                        }
                    }
                }
                Inst::Mcpy { dst, src, size } => {
                    // A whole-slot copy out of the slot is a read.
                    if let Some(&(s, _)) = la_slot.get(src) {
                        if *size == 8 {
                            slots
                                .entry(s)
                                .or_insert_with(SlotUse::empty)
                                .mcpys
                                .push((idx, *dst));
                        } else {
                            mark_disq(&mut slots, s);
                        }
                    }
                    // A copy INTO the slot is a write. A full-size copy from
                    // a data-segment template (the compound-literal zero
                    // init) before the full-width store is dead; any other
                    // copy carries data the single store does not, so it
                    // disqualifies the slot.
                    if let Some(&(s, _)) = la_slot.get(dst) {
                        let template = *size == 8
                            && matches!(func.insts.get(*src as usize), Some(Inst::ImmData(_)));
                        let u = slots.entry(s).or_insert_with(SlotUse::empty);
                        if template && u.store_idx == 0 && !u.disqualified {
                            u.templates.push(idx);
                        } else {
                            u.disqualified = true;
                        }
                    }
                }
                // Any other operand that is a slot address escapes it.
                other => {
                    let mut esc = |v: &ValueId| {
                        if let Some(&(s, _)) = la_slot.get(v) {
                            mark_disq(&mut slots, s);
                        }
                    };
                    for_each_operand(other, &mut esc);
                }
            }
        }
        // A slot address used by the block terminator escapes it.
        match &block.terminator {
            Terminator::Return(v)
            | Terminator::Bz { cond: v, .. }
            | Terminator::Bnz { cond: v, .. }
            | Terminator::GotoIndirect { target: v }
            | Terminator::JumpTable { idx: v, .. } => {
                if let Some(&(s, _)) = la_slot.get(v) {
                    mark_disq(&mut slots, s);
                }
            }
            _ => {}
        }
        if block.exit_acc != NO_VALUE
            && let Some(&(s, _)) = la_slot.get(&block.exit_acc)
        {
            mark_disq(&mut slots, s);
        }

        for (slot, u) in &slots {
            if u.disqualified
                || u.store_idx == 0
                || u.word == NO_VALUE
                || local_accessed.contains(slot)
                || multi_block.contains(slot)
                || (u.loads.is_empty() && u.mcpys.is_empty())
            {
                continue;
            }
            // Every read must follow the store in this block and forward
            // soundly. Validate before mutating so a single bad read leaves
            // the whole slot in memory.
            let mut load_actions: Vec<(u32, LoadForward)> = Vec::new();
            let mut ok = true;
            for &(lidx, lk) in &u.loads {
                if lidx <= u.store_idx || load_width(lk) > 8 {
                    ok = false;
                    break;
                }
                match forward_kind(u.kind, lk) {
                    LoadForward::No => {
                        ok = false;
                        break;
                    }
                    fwd => load_actions.push((lidx, fwd)),
                }
            }
            if !ok {
                continue;
            }
            for &(midx, _) in &u.mcpys {
                if midx <= u.store_idx {
                    ok = false;
                    break;
                }
            }
            if !ok {
                continue;
            }
            // Every template copy must precede the store so the store fully
            // overwrites it (guaranteed by construction -- templates are
            // only recorded before the store -- but checked for safety).
            if u.templates.iter().any(|&t| t >= u.store_idx) {
                continue;
            }
            // Commit. Loads forward to the stored word (directly or through
            // a sign-extend); whole-slot copies become a register store of
            // the word; the dead template copies and the now-dead store and
            // slot addresses drop out via the emit's is_dead_pure skip.
            for &t in &u.templates {
                rewrites.push((t as usize, Inst::Imm(0)));
            }
            for (lidx, fwd) in load_actions {
                match fwd {
                    LoadForward::Direct => {
                        redirect[lidx as usize] = Some(u.word);
                    }
                    LoadForward::Extend(lk) => {
                        rewrites.push((
                            lidx as usize,
                            Inst::Extend {
                                value: u.word,
                                kind: lk,
                            },
                        ));
                    }
                    LoadForward::No => unreachable!("validated above"),
                }
            }
            for &(midx, dst) in &u.mcpys {
                rewrites.push((
                    midx as usize,
                    Inst::Store {
                        addr: dst,
                        disp: 0,
                        value: u.word,
                        kind: u.kind,
                        volatile: false,
                    },
                ));
                // A reference to the copy's result reads the stored value.
                redirect[midx as usize] = Some(u.word);
            }
            // Neutralise the store; a reference to its propagated value
            // reads the stored word.
            rewrites.push((u.store_idx as usize, Inst::Imm(0)));
            redirect[u.store_idx as usize] = Some(u.word);
            any = true;
        }
    }

    for (idx, inst) in rewrites {
        func.insts[idx] = inst;
    }
    if !any {
        return false;
    }
    apply_redirect(func, &redirect);
    true
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

/// Rewrite every operand, terminator and `exit_acc` through `redirect`.
/// Reports whether any reference actually moved.
fn apply_redirect(func: &mut FunctionSsa, redirect: &[Option<ValueId>]) -> bool {
    let mut moved = false;
    let mut fix = |op: &mut ValueId| {
        let t = resolve(redirect, *op);
        moved |= t != *op;
        *op = t;
    };
    for inst in func.insts.iter_mut() {
        for_each_operand_mut(inst, &mut fix);
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            fix(&mut block.exit_acc);
        }
        match &mut block.terminator {
            Terminator::Bz { cond: v, .. }
            | Terminator::Bnz { cond: v, .. }
            | Terminator::GotoIndirect { target: v }
            | Terminator::JumpTable { idx: v, .. } => fix(v),
            Terminator::Return(v) if *v != NO_VALUE => fix(v),
            _ => {}
        }
    }
    moved
}

/// A byte range of a slot whose contents are a known register value.
#[derive(Clone, Copy, PartialEq)]
struct Piece {
    width: u8,
    value: ValueId,
}

/// What a load reads when a piece covers it exactly.
enum PieceFwd {
    /// Reuse the stored value unchanged (a full 64-bit integer piece).
    Direct(ValueId),
    /// Renormalize the stored value to the load's width and signedness.
    Rewrite(Inst),
}

/// Byte offset -> the piece starting there, per slot. Disjoint by
/// construction: a write clears every range it covers before recording
/// its own.
type PieceMap = BTreeMap<i64, BTreeMap<i64, Piece>>;

/// What the scan found for one slot, accumulated across blocks.
#[derive(Default)]
struct PieceAcc {
    /// (load inst, replacement) per covered load.
    fwds: Vec<(u32, PieceFwd)>,
    /// (write inst, the value its id stands for) per `Store` / `Mcpy`.
    writes: Vec<(u32, ValueId)>,
    /// A read the scan could not forward, so the writes must stay.
    live_read: bool,
}

fn clear_range(m: &mut BTreeMap<i64, Piece>, lo: i64, hi: i64) {
    m.retain(|&off, p| off + p.width as i64 <= lo || off >= hi);
}

/// The value a `kind` load produces off `p`. `None` when the piece does
/// not cover the load exactly, or when the two cross register classes --
/// only an integer store records a piece, so an FP load never forwards.
fn piece_fwd(p: &Piece, kind: LoadKind) -> Option<PieceFwd> {
    if p.width != load_width(kind) {
        return None;
    }
    Some(match kind {
        LoadKind::I64 => PieceFwd::Direct(p.value),
        LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => PieceFwd::Rewrite(Inst::Extend {
            value: p.value,
            kind,
        }),
        // `Inst::Extend` sign-extends; an unsigned width reads back as
        // the stored value masked to its bytes.
        LoadKind::U8 | LoadKind::U16 | LoadKind::U32 => PieceFwd::Rewrite(Inst::BinopI {
            op: BinOp::And,
            lhs: p.value,
            rhs_imm: (1i64 << (p.width * 8)) - 1,
        }),
        LoadKind::F32 | LoadKind::F64 => return None,
    })
}

/// Slots whose address reaches a use outside the modelled access forms,
/// or that carry a volatile access, anywhere in the function. Another
/// pointer may then alias the slot, so neither its contents nor its
/// writes are known.
fn escaped_slots(func: &FunctionSsa, addrs: &BTreeMap<ValueId, (i64, i64)>) -> BTreeSet<i64> {
    let mut escaped: BTreeSet<i64> = BTreeSet::new();
    for block in func.blocks.iter() {
        for idx in block.inst_range.clone() {
            let Some(inst) = func.insts.get(idx as usize) else {
                break;
            };
            // A slot address is not itself an access; its own uses decide.
            if addrs.contains_key(&idx) {
                continue;
            }
            match inst {
                Inst::Load {
                    addr, volatile: v, ..
                } => {
                    if let Some(&(s, _)) = addrs.get(addr)
                        && *v
                    {
                        escaped.insert(s);
                    }
                }
                Inst::Store {
                    addr,
                    value,
                    volatile: v,
                    ..
                } => {
                    if let Some(&(s, _)) = addrs.get(addr)
                        && *v
                    {
                        escaped.insert(s);
                    }
                    // A stored slot address outlives the instruction.
                    if let Some(&(s, _)) = addrs.get(value) {
                        escaped.insert(s);
                    }
                }
                Inst::Mcpy { dst, src, .. } => {
                    // A copy within one slot is outside the model.
                    if let (Some(&(d, _)), Some(&(s, _))) = (addrs.get(dst), addrs.get(src))
                        && d == s
                    {
                        escaped.insert(s);
                    }
                }
                other => for_each_operand(other, &mut |v| {
                    if let Some(&(s, _)) = addrs.get(v) {
                        escaped.insert(s);
                    }
                }),
            }
        }
        match &block.terminator {
            Terminator::Return(v)
            | Terminator::Bz { cond: v, .. }
            | Terminator::Bnz { cond: v, .. }
            | Terminator::GotoIndirect { target: v }
            | Terminator::JumpTable { idx: v, .. } => {
                if let Some(&(s, _)) = addrs.get(v) {
                    escaped.insert(s);
                }
            }
            _ => {}
        }
        if block.exit_acc != NO_VALUE
            && let Some(&(s, _)) = addrs.get(&block.exit_acc)
        {
            escaped.insert(s);
        }
    }
    escaped
}

/// Linear walk of one block, tracking each tracked slot's known pieces
/// from the `pieces` state at block entry. With `acc` given, the walk
/// also records the covered loads, the writes, and the reads it could
/// not forward.
fn scan_block(
    func: &FunctionSsa,
    ctx: &SlotCtx,
    escaped: &BTreeSet<i64>,
    block: &crate::c5::ir::Block,
    pieces: &mut PieceMap,
    mut acc: Option<&mut BTreeMap<i64, PieceAcc>>,
) {
    let tracked = |v: &ValueId| -> Option<(i64, i64)> {
        ctx.addrs
            .get(v)
            .copied()
            .filter(|(s, _)| !escaped.contains(s) && !ctx.opaque.contains(s))
    };
    for idx in block.inst_range.clone() {
        let Some(inst) = func.insts.get(idx as usize) else {
            break;
        };
        match inst {
            Inst::Store {
                addr,
                disp,
                value,
                kind,
                ..
            } => {
                if let Some((s, off)) = tracked(addr) {
                    let at = off + *disp as i64;
                    let w = store_width(*kind);
                    let m = pieces.entry(s).or_default();
                    clear_range(m, at, at + w as i64);
                    // An FP store leaves the range unknown: its value
                    // sits in the other register class.
                    if matches!(
                        kind,
                        StoreKind::I8 | StoreKind::I16 | StoreKind::I32 | StoreKind::I64
                    ) {
                        m.insert(
                            at,
                            Piece {
                                width: w,
                                value: *value,
                            },
                        );
                    }
                    if let Some(acc) = acc.as_deref_mut() {
                        acc.entry(s).or_default().writes.push((idx, *value));
                    }
                }
            }
            Inst::Load {
                addr, disp, kind, ..
            } => {
                if let Some((s, off)) = tracked(addr)
                    && let Some(acc) = acc.as_deref_mut()
                {
                    let at = off + *disp as i64;
                    let fwd = pieces
                        .get(&s)
                        .and_then(|m| m.get(&at))
                        .and_then(|p| piece_fwd(p, *kind));
                    let a = acc.entry(s).or_default();
                    match fwd {
                        Some(f) => a.fwds.push((idx, f)),
                        None => a.live_read = true,
                    }
                }
            }
            Inst::Mcpy { dst, src, size } => match (tracked(dst), tracked(src)) {
                // A copy between two tracked slots carries the source's
                // covered pieces to the destination; bytes the source
                // does not track become unknown there.
                (Some((ds, doff)), Some((ss, soff))) => {
                    let moved: Vec<(i64, Piece)> = pieces
                        .get(&ss)
                        .map(|m| {
                            m.iter()
                                .filter(|&(&o, p)| o >= soff && o + p.width as i64 <= soff + *size)
                                .map(|(&o, p)| (doff + (o - soff), *p))
                                .collect()
                        })
                        .unwrap_or_default();
                    let m = pieces.entry(ds).or_default();
                    clear_range(m, doff, doff + *size);
                    m.extend(moved);
                    if let Some(acc) = acc.as_deref_mut() {
                        acc.entry(ss).or_default().live_read = true;
                        acc.entry(ds).or_default().writes.push((idx, *dst));
                    }
                }
                (Some((ds, doff)), None) => {
                    clear_range(pieces.entry(ds).or_default(), doff, doff + *size);
                    if let Some(acc) = acc.as_deref_mut() {
                        acc.entry(ds).or_default().writes.push((idx, *dst));
                    }
                }
                (None, Some((ss, _))) => {
                    if let Some(acc) = acc.as_deref_mut() {
                        acc.entry(ss).or_default().live_read = true;
                    }
                }
                (None, None) => {}
            },
            _ => {}
        }
    }
}

/// Block-entry state: the pieces every reachable predecessor's exit
/// agrees on, value id included. A predecessor with no state yet is
/// skipped -- availability is a must-property, so the iteration starts
/// optimistic and shrinks to its fixed point.
///
/// A piece surviving the meet was stored on every path into the block,
/// so its single defining instruction lies on every path from the entry
/// and therefore dominates the block: the value is available at the
/// reads this seeds.
fn meet(preds: &[crate::c5::ir::BlockId], exit: &[Option<PieceMap>]) -> PieceMap {
    let mut cur: Option<PieceMap> = None;
    for &p in preds {
        let Some(other) = exit[p as usize].as_ref() else {
            continue;
        };
        let Some(cur) = cur.as_mut() else {
            cur = Some(other.clone());
            continue;
        };
        cur.retain(|s, _| other.contains_key(s));
        for (s, m) in cur.iter_mut() {
            let om = &other[s];
            m.retain(|off, p| om.get(off).is_some_and(|q| q == p));
        }
        cur.retain(|_, m| !m.is_empty());
    }
    cur.unwrap_or_default()
}

/// Rounds the availability iteration may take before the pass gives up
/// and falls back to per-block state only. Each round can only remove
/// pieces, so convergence is bounded by the store count; the cap is a
/// backstop on compile time for a very large control-flow graph.
const MAX_AVAIL_ROUNDS: usize = 8;

fn promote_pieces_once(func: &mut FunctionSsa) -> bool {
    let n = func.insts.len();
    if n == 0 {
        return false;
    }
    let ctx = slot_ctx(func, true);
    if ctx.addrs.is_empty() {
        return false;
    }
    let escaped = escaped_slots(func, &ctx.addrs);
    let nb = func.blocks.len();
    let preds = crate::c5::codegen::ssa::mem2reg::predecessors(func);
    let rpo: Vec<crate::c5::ir::BlockId> = crate::c5::codegen::ssa::mem2reg::postorder(func)
        .into_iter()
        .rev()
        .collect();
    // Per-block exit state, iterated to its fixed point. `None` is the
    // optimistic start (and the final state of an unreachable block,
    // which contributes nothing to a meet since control never comes
    // from there).
    let mut exit: Vec<Option<PieceMap>> = alloc::vec![None; nb];
    let mut settled = false;
    for _ in 0..MAX_AVAIL_ROUNDS {
        let mut changed = false;
        for &b in &rpo {
            let mut pieces = meet(&preds[b as usize], &exit);
            scan_block(
                func,
                &ctx,
                &escaped,
                &func.blocks[b as usize],
                &mut pieces,
                None,
            );
            if exit[b as usize].as_ref() != Some(&pieces) {
                exit[b as usize] = Some(pieces);
                changed = true;
            }
        }
        if !changed {
            settled = true;
            break;
        }
    }
    if !settled {
        // Not a fixed point: an unsettled state may claim a piece a later
        // round would drop, so keep nothing across block boundaries.
        exit.iter_mut().for_each(|e| *e = Some(BTreeMap::new()));
    }

    let mut acc: BTreeMap<i64, PieceAcc> = BTreeMap::new();
    for (block, bp) in func.blocks.iter().zip(&preds) {
        let mut pieces = meet(bp, &exit);
        scan_block(func, &ctx, &escaped, block, &mut pieces, Some(&mut acc));
    }

    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; n];
    let mut rewrites: Vec<(usize, Inst)> = Vec::new();
    for (slot, u) in acc {
        for (lidx, f) in u.fwds {
            match f {
                PieceFwd::Direct(w) => redirect[lidx as usize] = Some(w),
                PieceFwd::Rewrite(inst) => rewrites.push((lidx as usize, inst)),
            }
        }
        // A compiler-allocated local whose every read forwarded is
        // unobservable: its writes drop out. A parameter cell keeps them
        // -- the prologue spill initializing it is not in the IR, so
        // "every write seen" does not hold there.
        if slot < 0 && !u.live_read {
            for (widx, rv) in u.writes {
                rewrites.push((widx as usize, Inst::Imm(0)));
                redirect[widx as usize] = Some(rv);
            }
        }
    }

    let mut any = !rewrites.is_empty();
    for (idx, inst) in rewrites {
        func.insts[idx] = inst;
    }
    any |= apply_redirect(func, &redirect);
    any
}

fn for_each_operand(inst: &Inst, f: &mut impl FnMut(&ValueId)) {
    match inst {
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
        Inst::Mcpy { dst, src, .. } => {
            f(dst);
            f(src);
        }
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
        _ => {}
    }
}

fn for_each_operand_mut(inst: &mut Inst, mut f: impl FnMut(&mut ValueId)) {
    match inst {
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
        Inst::Mcpy { dst, src, .. } => {
            f(dst);
            f(src);
        }
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
        _ => {}
    }
}

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

use super::super::ir::{FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId};
use alloc::collections::BTreeMap;
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
    /// Not forwardable (unsigned narrow or floating; see ssa_store_forward).
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
    // r). Re-run until stable so a forwarding chain fully collapses; the
    // pass is monotone (each pass only removes slots) so the slot count
    // bounds the iterations.
    let mut rounds = func.insts.len() + 1;
    while rounds > 0 && promote_once(func) {
        rounds -= 1;
    }
}

fn promote_once(func: &mut FunctionSsa) -> bool {
    let n = func.insts.len();
    if n == 0 {
        return false;
    }
    // value id of every `LocalAddr(S)` -> its slot S.
    let mut la_slot: BTreeMap<ValueId, i64> = BTreeMap::new();
    for (i, inst) in func.insts.iter().enumerate() {
        if let Inst::LocalAddr(s) = inst {
            la_slot.insert(i as ValueId, *s);
        }
    }
    if la_slot.is_empty() {
        return false;
    }
    // A slot accessed via LoadLocal / StoreLocal mixes addressing forms the
    // pass does not model; disqualify it up front.
    let mut local_accessed: alloc::collections::BTreeSet<i64> = alloc::collections::BTreeSet::new();
    for inst in &func.insts {
        match inst {
            Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => {
                local_accessed.insert(*off);
            }
            _ => {}
        }
    }
    // Promotion neutralises the single store globally, so a slot whose
    // address is used in more than one block is unsafe: a read in another
    // block would see the slot after the store is removed. Exclude any slot
    // whose `LocalAddr` is referenced as an operand in more than one block;
    // the per-block pass below promotes only block-local slots.
    let mut slot_block: BTreeMap<i64, u32> = BTreeMap::new();
    let mut multi_block: alloc::collections::BTreeSet<i64> = alloc::collections::BTreeSet::new();
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
            | Terminator::GotoIndirect { target: v } => refs.push(*v),
            _ => {}
        }
        if block.exit_acc != NO_VALUE {
            refs.push(block.exit_acc);
        }
        for v in refs {
            if let Some(&s) = la_slot.get(&v) {
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
                } => {
                    if let Some(&s) = la_slot.get(addr) {
                        // A write into a tracked slot. Promotable only as a
                        // single full-width store at offset 0; any other
                        // store shape disqualifies the slot.
                        let full = *disp == 0 && store_width(*kind) == 8;
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
                    if let Some(&s) = la_slot.get(value) {
                        mark_disq(&mut slots, s);
                    }
                }
                Inst::Load { addr, disp, kind } => {
                    if let Some(&s) = la_slot.get(addr) {
                        if *disp == 0 {
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
                    if let Some(&s) = la_slot.get(src) {
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
                    if let Some(&s) = la_slot.get(dst) {
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
                        if let Some(&s) = la_slot.get(v) {
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
            | Terminator::GotoIndirect { target: v } => {
                if let Some(&s) = la_slot.get(v) {
                    mark_disq(&mut slots, s);
                }
            }
            _ => {}
        }
        if block.exit_acc != NO_VALUE
            && let Some(&s) = la_slot.get(&block.exit_acc)
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
    for inst in func.insts.iter_mut() {
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
            Terminator::GotoIndirect { target } => {
                *target = resolve(&redirect, *target);
            }
            Terminator::Return(v) if *v != NO_VALUE => {
                *v = resolve(&redirect, *v);
            }
            _ => {}
        }
    }
    true
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
        Inst::Call { args, .. } | Inst::CallExt { args, .. } | Inst::Intrinsic { args, .. } => {
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
        Inst::Call { args, .. } | Inst::CallExt { args, .. } | Inst::Intrinsic { args, .. } => {
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

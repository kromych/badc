//! Intra-block store-to-load and load-to-load forwarding.
//!
//! A value stored to a memory location and then loaded back from the
//! same location, with nothing between that can write or alias that
//! location, makes the load redundant: the value is already in a
//! register. The same holds for two loads of one location. Forwarding
//! replaces the second access with the value already computed, and the
//! now-unreferenced load drops out through the emit's `is_dead_pure`
//! skip.
//!
//! ```text
//!   Store { addr=p, value=s, kind=I64 }
//!   ...                                  # nothing writes or aliases *p
//!   v = Load { addr=p, kind=I64 }        # -> uses of v become uses of s
//! ```
//!
//! The tables run over an extended basic block: a block that one
//! predecessor alone reaches starts from that block's tables at its end,
//! and any other block starts empty. A merge would need per-path
//! availability and is left out.
//!
//! Aliasing is tracked conservatively. Two locations are known distinct
//! only when they share the same address value and their byte ranges do
//! not overlap; any other store clears the entries it cannot prove
//! disjoint. A call, an indexed or local store, a block copy, or an
//! alloca clears the whole table, since each can write through a pointer
//! the pass does not model.
//!
//! An indexed access is one location per `(base, index, scale)` of value
//! ids and index extension, and forwards on an exact match. Two index values can hold the same
//! number, so no two indexed locations are known distinct: any store
//! drops all of them, and an indexed store drops every pointer entry.
//!
//! Width and signedness. The forwarded value must equal what the load
//! would have produced from memory:
//!   - An `I64` load of an `I64` store reuses the stored value directly.
//!   - A signed sub-width load (`I8`/`I16`/`I32`) of a same-width store
//!     becomes `Extend { value=s, kind }`; `narrow_store` writes the low
//!     bytes and the load sign-extends them, which `Extend` reproduces.
//!   - An `F64` load of an `F64` store from a floating register reuses the
//!     stored value; an `F64` load of an 8-byte integer store, or an `I64`
//!     load of such an `F64` store, becomes the bit-for-bit `FpCast`
//!     (`BitsFp`, `FpBits`).
//!   - Unsigned sub-width loads and `F32` loads are not forwarded:
//!     `Inst::Extend` does not zero-extend the unsigned widths (it assumes
//!     a clean upper half), and an `F32` load widens.
//!   - A whole vector load of a store of the same vector kind reuses the
//!     stored register, unless the stored value is an immediate.
//! A load forwards from an earlier load only when the load kinds match
//! exactly, so the extension already applied is the one wanted.
//!
//! Frame slots (`StoreLocal` / `LoadLocal`) are tracked in a second
//! table keyed by slot index and displacement, with the same width, volatile, and
//! distance discipline. A slot reachable only through `LoadLocal` /
//! `StoreLocal` -- no `LocalAddr`, no volatile access
//! (`mem2reg::address_free_slots`), and not a call's result slot --
//! has no address value, so no `Store`,
//! `Mcpy`, or atomic can write it; its entries survive those
//! instructions and die at an overlapping `StoreLocal`, at a
//! call (a reload after the call is cheaper than keeping the value live
//! across it), or where control merges. An address-exposed slot
//! (`LocalAddr` taken, e.g. by an asm output) still forwards, under a
//! stricter discipline: any instruction that can write memory through a
//! pointer also kills its entries. A volatile access neither forwards
//! nor seeds on either discipline.

use crate::c5::codegen::ssa::mem2reg::address_free_slots;
use crate::c5::ir::{
    FpCastKind, FunctionSsa, IndexExt, Inst, LoadKind, NO_VALUE, StoreKind, ValueId,
};
use alloc::collections::BTreeSet;
use alloc::vec::Vec;

/// Access width in bytes for a load kind.
fn load_width(kind: LoadKind) -> u8 {
    match kind {
        LoadKind::I64 | LoadKind::F64 => 8,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::F80 | LoadKind::F128 | LoadKind::V128 => 16,
        LoadKind::V256 => 32,
        LoadKind::V512 => 64,
    }
}

/// Access width in bytes for a store kind.
fn store_width(kind: StoreKind) -> u8 {
    match kind {
        StoreKind::I64 | StoreKind::F64 => 8,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F80 | StoreKind::F128 | StoreKind::V128 => 16,
        StoreKind::V256 => 32,
        StoreKind::V512 => 64,
    }
}

/// True for the integer store kinds the pass forwards from. Floating
/// stores still clear aliasing entries but never seed a forward, so an
/// integer load that punned the same address reads memory.
fn is_int_store(kind: StoreKind) -> bool {
    matches!(
        kind,
        StoreKind::I64 | StoreKind::I32 | StoreKind::I16 | StoreKind::I8
    )
}

/// The origin an entry seeded by a store of `kind` carries: an integer
/// store's value describes the loads [`reuse`] lists (`Some(None)`); a
/// whole vector's or a double's FP register holds the bytes a load of that
/// kind reads back; `None` for a store that seeds nothing.
fn store_origin(func: &FunctionSsa, kind: StoreKind, value: ValueId) -> Option<Option<LoadKind>> {
    let Some(inst) = func.insts.get(value as usize) else {
        return is_int_store(kind).then_some(None);
    };
    let fp = crate::c5::codegen::ssa::reg_alloc::produces_fp_result(inst);
    // A single-precision value is not the double a load reads back.
    let single = func
        .f32_values
        .get(value as usize)
        .copied()
        .unwrap_or(false);
    let double = fp && !single && !matches!(inst, Inst::Imm(_));
    let vector = match kind {
        // An integer store of an FP register's value writes its bits: an
        // 8-byte one those of the double, a narrower one serves no load.
        StoreKind::I64 | StoreKind::I32 | StoreKind::I16 | StoreKind::I8 if !fp => {
            return Some(None);
        }
        StoreKind::V128 => LoadKind::V128,
        StoreKind::V256 => LoadKind::V256,
        StoreKind::V512 => LoadKind::V512,
        // A double from an FP register reads back the same 64 bits.
        StoreKind::F64 | StoreKind::I64 => LoadKind::F64,
        _ => return None,
    };
    double.then_some(Some(vector))
}

/// Whether a load of `kind` reads a lane of a `bytes`-byte vector the
/// targets extract: an integer or floating scalar, or a 16-byte half.
fn lane_kind(kind: LoadKind, bytes: u8) -> bool {
    match kind {
        LoadKind::V128 => bytes == 32,
        LoadKind::F80 | LoadKind::F128 | LoadKind::V256 | LoadKind::V512 => false,
        _ => true,
    }
}

/// Maximum instruction distance between the store or first load and the
/// consuming load for forwarding to fire. Forwarding removes a reload
/// but keeps the value live across this span; past a bound the extended
/// live range costs more in spills than the reload it removes, so a
/// value cheap to reload (a load from a still-valid address) is better
/// rematerialized. Sized to cover adjacent struct-field and pointer
/// re-reads while leaving the scattered re-reads of an unrolled loop to
/// reload.
const MAX_FORWARD_DISTANCE: u32 = 16;

/// Distance between two instruction indices in emitted instructions:
/// the bound above is about the live range the forward extends, and
/// neither a lifetime marker nor a pure value nothing reads adds any. Returns a closure over a prefix count so
/// each query is O(1).
fn emitted_span(func: &FunctionSsa) -> impl Fn(u32, usize) -> u32 + use<> {
    let mut used = alloc::vec![false; func.insts.len()];
    let mut mark = |v: ValueId| {
        if let Some(u) = used.get_mut(v as usize) {
            *u = true;
        }
    };
    func.insts
        .iter()
        .for_each(|inst| inst.for_each_operand(&mut mark));
    func.blocks
        .iter()
        .for_each(|b| b.terminator.for_each_operand(&mut mark));
    let mut prefix: Vec<u32> = Vec::with_capacity(func.insts.len() + 1);
    let mut n = 0u32;
    for (inst, used) in func.insts.iter().zip(used) {
        prefix.push(n);
        n += u32::from(!inst.is_lifetime_marker() && (used || !inst.is_pure()));
    }
    prefix.push(n);
    move |from: u32, to: usize| {
        let (a, b) = (
            prefix.get(from as usize).copied().unwrap_or(0),
            prefix.get(to).copied().unwrap_or(0),
        );
        b.saturating_sub(a)
    }
}

/// A known-available memory value within the current extended block.
#[derive(Clone, Copy)]
struct Entry {
    addr: ValueId,
    disp: i32,
    width: u8,
    /// The value id that holds the location's contents.
    value: ValueId,
    /// Instruction index of the store or load that produced this entry.
    /// Forwarding is bounded by the distance from here to the consuming
    /// load.
    src_idx: u32,
    /// `Some(kind)` for a load-origin entry, whose value carries that
    /// load kind's extension; `None` for a store-origin entry, whose
    /// value is the raw stored register.
    load_kind: Option<LoadKind>,
}

/// A known-available frame-slot value within the current extended block: the
/// `width` bytes at `disp` past slot `off`'s base, which may reach the next cell.
#[derive(Clone, Copy)]
struct SlotEntry {
    off: i64,
    disp: i32,
    width: u8,
    value: ValueId,
    src_idx: u32,
    /// As [`Entry::load_kind`].
    load_kind: Option<LoadKind>,
}

/// As [`Entry`], for the location `base + index * scale`.
#[derive(Clone, Copy)]
struct IndexedEntry {
    base: ValueId,
    index: ValueId,
    index_ext: IndexExt,
    scale: u8,
    width: u8,
    value: ValueId,
    src_idx: u32,
    load_kind: Option<LoadKind>,
}

/// How a load takes a location's available value: as it stands,
/// sign-extended from the load's width, or its 64 bits moved to the other
/// register file.
#[derive(Clone, Copy)]
enum Reuse {
    Direct,
    Extended,
    Bits(FpCastKind),
}

/// The reuse open to a load of `kind` from an entry of origin `origin`
/// ([`Entry::load_kind`]), per the module note; `None` reads memory.
fn reuse(origin: Option<LoadKind>, kind: LoadKind) -> Option<Reuse> {
    match origin {
        None => match kind {
            LoadKind::I64 => Some(Reuse::Direct),
            LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => Some(Reuse::Extended),
            LoadKind::F64 => Some(Reuse::Bits(FpCastKind::BitsFp)),
            _ => None,
        },
        Some(LoadKind::F64) if kind == LoadKind::I64 => Some(Reuse::Bits(FpCastKind::FpBits)),
        Some(k) => (k == kind).then_some(Reuse::Direct),
    }
}

/// Slots whose store -> load pairs may forward: reachable only through
/// `LoadLocal` / `StoreLocal` (`mem2reg::address_free_slots`: no `LocalAddr`,
/// no volatile access, no alloca slot), so every write but the prologue's,
/// which precede every entry, is visible in the SSA. A call writes its
/// result slot, and [`fold_const_loads`] keeps these entries across calls.
fn forwardable_slots(func: &FunctionSsa) -> BTreeSet<i64> {
    let mut slots = address_free_slots(func);
    for inst in &func.insts {
        if let Inst::Call { ret_slot_local, .. }
        | Inst::CallIndirect { ret_slot_local, .. }
        | Inst::CallExt { ret_slot_local, .. } = inst
        {
            slots.remove(ret_slot_local);
        }
    }
    slots
}

/// Slots outside `forwardable` that still forward under the stricter
/// exposed discipline (every pointer write kills): any slot the body
/// accesses through `LoadLocal` / `StoreLocal` but the alloca slot.
fn exposed_slots(func: &FunctionSsa, forwardable: &BTreeSet<i64>) -> BTreeSet<i64> {
    let reserved: BTreeSet<i64> = func
        .insts
        .iter()
        .filter_map(|i| match i {
            Inst::AllocaInit(off) if *off < 0 => Some(*off),
            _ => None,
        })
        .collect();
    func.insts
        .iter()
        .filter_map(|i| match i {
            Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => Some(*off),
            _ => None,
        })
        .filter(|off| !forwardable.contains(off) && !reserved.contains(off))
        .collect()
}

/// Byte ranges `[a, a+aw)` and `[b, b+bw)` overlap.
fn overlaps(a: i32, aw: u8, b: i32, bw: u8) -> bool {
    let a_end = a as i64 + aw as i64;
    let b_end = b as i64 + bw as i64;
    (a as i64) < b_end && (b as i64) < a_end
}

/// Apply [`reuse`] to load `i`; true when it recorded a redirect.
fn take(
    redirect: &mut [Option<ValueId>],
    rewrites: &mut Vec<(usize, Inst)>,
    i: usize,
    value: ValueId,
    origin: Option<LoadKind>,
    kind: LoadKind,
) -> bool {
    match reuse(origin, kind) {
        Some(Reuse::Direct) => {
            redirect[i] = Some(value);
            true
        }
        Some(Reuse::Extended) => {
            rewrites.push((
                i,
                Inst::Extend {
                    value,
                    kind,
                    nsw: false,
                },
            ));
            false
        }
        Some(Reuse::Bits(kind)) => {
            rewrites.push((i, Inst::FpCast { kind, value }));
            false
        }
        None => false,
    }
}

/// An 8-byte store of a bit-for-bit `FpCast` writes the same bytes from
/// the cast's operand, in that operand's register file.
fn store_bits_directly(func: &mut FunctionSsa) {
    for i in 0..func.insts.len() {
        let (Inst::Store { value, kind, .. }
        | Inst::StoreLocal { value, kind, .. }
        | Inst::StoreIndexed { value, kind, .. }) = &func.insts[i]
        else {
            continue;
        };
        let retyped = match (*kind, &func.insts[*value as usize]) {
            (
                StoreKind::I64,
                &Inst::FpCast {
                    kind: FpCastKind::FpBits,
                    value,
                },
            ) => (StoreKind::F64, value),
            (
                StoreKind::F64,
                &Inst::FpCast {
                    kind: FpCastKind::BitsFp,
                    value,
                },
            ) => (StoreKind::I64, value),
            _ => continue,
        };
        if let Inst::Store { value, kind, .. }
        | Inst::StoreLocal { value, kind, .. }
        | Inst::StoreIndexed { value, kind, .. } = &mut func.insts[i]
        {
            (*kind, *value) = retyped;
        }
    }
}

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    // A `__try` region's stores are the handler's to read.
    for func in funcs.iter_mut().filter(|f| !f.has_seh()) {
        run_one(func);
    }
}

fn run_one(func: &mut FunctionSsa) {
    let n = func.insts.len();
    if n == 0 {
        return;
    }
    // Loads that reuse an earlier value: the load's id maps to that
    // value, and the operand rewrite at the end redirects every use.
    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; n];
    // Loads replaced in place by an `Extend` of the stored value.
    let mut rewrites: Vec<(usize, Inst)> = Vec::new();
    let mut any = false;
    let slots = forwardable_slots(func);
    let exposed = exposed_slots(func, &slots);
    let span = emitted_span(func);

    // A block one predecessor alone reaches starts from what that block
    // ended with: the predecessor dominates it, and no other path enters.
    let preds = crate::c5::codegen::ssa::mem2reg::predecessors(func);
    type Tables = (Vec<Entry>, Vec<IndexedEntry>, Vec<SlotEntry>, Vec<Copied>);
    let mut exits: Vec<Option<Tables>> = alloc::vec![None; func.blocks.len()];
    for b in 0..func.blocks.len() {
        let range = func.blocks[b].inst_range.clone();
        let (mut table, mut indexed, mut slot_table, mut copies) = match preds[b].as_slice() {
            [p] if *p as usize != b => exits[*p as usize].clone().unwrap_or_default(),
            _ => Default::default(),
        };
        for idx in range {
            let i = idx as usize;
            if i >= func.insts.len() {
                break;
            }
            // A copy of a copy reads the first source; the load then
            // forwards from what that source holds.
            for _ in 0..copies.len() {
                let Some(load) = copy_source(func, &copies, i) else {
                    break;
                };
                func.insts[i] = load;
                any = true;
            }
            if writes_memory(&func.insts[i]) {
                copies.clear();
            }
            if let Inst::Mcpy {
                dst,
                src,
                size,
                align,
            } = func.insts[i]
                && let (base, at) = base_disp(func, dst, 0)
                && let Some(&Inst::LocalAddr(off)) = func.insts.get(base as usize)
            {
                copies.push(Copied {
                    off,
                    at,
                    size,
                    src,
                    align,
                });
            }
            match &func.insts[i] {
                // A volatile load must perform its own memory access
                // (C99 5.1.2.3p2 / 6.7.3p6): it neither reuses an
                // available value nor seeds one. It reads only, so
                // existing entries stay valid.
                Inst::Load { volatile: true, .. } => {}
                Inst::Load {
                    addr,
                    disp,
                    kind,
                    volatile: false,
                    ..
                } => {
                    let addr = *addr;
                    let disp = *disp;
                    let kind = *kind;
                    let w = load_width(kind);
                    let hit = table
                        .iter()
                        .find(|e| e.addr == addr && e.disp == disp && e.width == w)
                        .copied();
                    // Only forward when the source is within the
                    // live-range-extension bound; a farther reuse reloads.
                    let hit = hit.filter(|e| span(e.src_idx, i) <= MAX_FORWARD_DISTANCE);
                    if let Some(e) = hit {
                        any |= take(&mut redirect, &mut rewrites, i, e.value, e.load_kind, kind);
                    }
                    // Record this load so a later identical one forwards:
                    // one that did not forward stands in for an entry too
                    // far to serve; one that did leaves the entry it reused.
                    if redirect[i].is_none() {
                        table.retain(|e| !(e.addr == addr && e.disp == disp && e.width == w));
                        table.push(Entry {
                            addr,
                            disp,
                            width: w,
                            value: i as ValueId,
                            src_idx: idx,
                            load_kind: Some(kind),
                        });
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
                    let addr = *addr;
                    let disp = *disp;
                    let value = *value;
                    let kind = *kind;
                    let volatile = *volatile;
                    let w = store_width(kind);
                    // Drop every entry not provably disjoint from the
                    // written range. An exposed slot's address is a value,
                    // so the write can reach it, off its own address the bytes named.
                    table.retain(|e| e.addr == addr && !overlaps(e.disp, e.width, disp, w));
                    indexed.clear();
                    match slot_bytes(func, addr, disp) {
                        Some(at) => slot_table
                            .retain(|e| !overlaps64(e.off * 8 + i64::from(e.disp), e.width, at, w)),
                        None => slot_table.retain(|e| !exposed.contains(&e.off)),
                    }
                    // A volatile store invalidates like any store but
                    // seeds no forward: a later load of the location
                    // must read memory (C99 6.7.3p6).
                    if let Some(origin) = store_origin(func, kind, value).filter(|_| !volatile) {
                        table.push(Entry {
                            addr,
                            disp,
                            width: w,
                            value,
                            src_idx: idx,
                            load_kind: origin,
                        });
                    }
                }
                // A volatile slot access neither forwards nor seeds
                // (C99 6.7.3p6). A volatile load reads only, so
                // existing entries stay valid.
                Inst::LoadLocal { volatile: true, .. } => {}
                Inst::LoadLocal {
                    off,
                    disp,
                    kind,
                    volatile: false,
                } => {
                    let (off, disp, kind) = (*off, *disp, *kind);
                    if !slots.contains(&off) && !exposed.contains(&off) {
                        continue;
                    }
                    let w = load_width(kind);
                    let same = |e: &SlotEntry| e.off == off && e.disp == disp && e.width == w;
                    // A load no entry serves seeds one for the next load of its kind.
                    let hit = slot_table
                        .iter()
                        .rev()
                        .find(|e| {
                            same(e)
                                && reuse(e.load_kind, kind).is_some()
                                && span(e.src_idx, i) <= MAX_FORWARD_DISTANCE
                        })
                        .copied();
                    // A lane of a vector the slot holds whole is that lane
                    // of the vector's register.
                    let lane = |e: &SlotEntry| {
                        let at = disp - e.disp;
                        e.off == off
                            && matches!(e.load_kind, Some(LoadKind::V128 | LoadKind::V256))
                            && lane_kind(kind, e.width)
                            && at >= 0
                            && at + i32::from(w) <= i32::from(e.width)
                            && at % i32::from(w) == 0
                            && span(e.src_idx, i) <= MAX_FORWARD_DISTANCE
                    };
                    // Two doubles the slot holds side by side are a 16-byte
                    // vector: the high one inserted over the low one's
                    // register.
                    let half = |at: i32| {
                        slot_table
                            .iter()
                            .rev()
                            .find(|e| {
                                e.off == off
                                    && e.disp == at
                                    && e.width == 8
                                    && e.load_kind == Some(LoadKind::F64)
                                    && span(e.src_idx, i) <= MAX_FORWARD_DISTANCE
                            })
                            .copied()
                    };
                    let pair = (kind == LoadKind::V128)
                        .then(|| half(disp).zip(half(disp + 8)))
                        .flatten();
                    if let Some(e) = hit {
                        any |= take(&mut redirect, &mut rewrites, i, e.value, e.load_kind, kind);
                    } else if let Some((lo, hi)) = pair {
                        rewrites.push((
                            i,
                            Inst::VecInsert {
                                vec: lo.value,
                                value: hi.value,
                                off: 8,
                                kind: StoreKind::F64,
                                bytes: 16,
                            },
                        ));
                    } else if let Some(e) = slot_table.iter().rev().find(|e| lane(e)).copied() {
                        rewrites.push((
                            i,
                            Inst::VecExtract {
                                vec: e.value,
                                off: (disp - e.disp) as u8,
                                kind,
                                bytes: e.width,
                            },
                        ));
                    } else {
                        slot_table.retain(|e| !(same(e) && e.load_kind == Some(kind)));
                        slot_table.push(SlotEntry {
                            off,
                            disp,
                            width: w,
                            value: i as ValueId,
                            src_idx: idx,
                            load_kind: Some(kind),
                        });
                    }
                }
                Inst::StoreLocal {
                    off,
                    disp,
                    value,
                    kind,
                    volatile,
                    ..
                } => {
                    let off = *off;
                    let disp = *disp;
                    let value = *value;
                    let kind = *kind;
                    let volatile = *volatile;
                    // A frame write can alias a tracked pointer entry
                    // (the pointer can be a `LocalAddr` of this slot),
                    // so the pointer table clears as before.
                    table.clear();
                    indexed.clear();
                    let at = off * 8 + i64::from(disp);
                    let w = store_width(kind);
                    slot_table
                        .retain(|e| !overlaps64(e.off * 8 + i64::from(e.disp), e.width, at, w));
                    if let Some(origin) = store_origin(func, kind, value)
                        .filter(|_| (slots.contains(&off) || exposed.contains(&off)) && !volatile)
                    {
                        slot_table.push(SlotEntry {
                            off,
                            disp,
                            width: store_width(kind),
                            value,
                            src_idx: idx,
                            load_kind: origin,
                        });
                    }
                }
                // Reads and pure computes the pass does not model: no
                // clobber, no entry. A `__seg_gs` / `__seg_fs` access names a
                // distinct address space that does not alias the generic-space
                // pointer table or any tracked slot, so it neither forwards nor
                // invalidates an entry here.
                Inst::SegLoad { .. }
                | Inst::SegStore { .. }
                | Inst::Imm(_)
                | Inst::Undef
                | Inst::ExceptionCode
                | Inst::ParentLocalAddr { .. }
                | Inst::ImmData(_)
                | Inst::ImmCode(_)
                | Inst::ImmExtCode(_)
                | Inst::BlockAddr(_)
                | Inst::LocalAddr(_)
                | Inst::TlsAddr(_)
                | Inst::LifetimeEnd(_)
                | Inst::Binop { .. }
                | Inst::SimdVal { .. }
                | Inst::VecBinop { .. }
                | Inst::VecInsert { .. }
                | Inst::VecSplat { .. }
                | Inst::VecConst { .. }
                | Inst::VecExtract { .. }
                | Inst::Select { .. }
                | Inst::BinopI { .. }
                | Inst::Neg(_)
                | Inst::Fneg(_)
                | Inst::Fma { .. }
                | Inst::MulAdd { .. }
                | Inst::ShiftOp { .. }
                | Inst::BitField { .. }
                | Inst::Udiv128 { .. }
                | Inst::Extend { .. }
                | Inst::Bswap { .. }
                | Inst::BitCount { .. }
                | Inst::Copy { .. }
                | Inst::FpCast { .. }
                | Inst::ParamRef { .. }
                | Inst::ParamPart { .. }
                | Inst::RetPart { .. }
                | Inst::AsmOut { .. }
                | Inst::AggParts { .. }
                | Inst::Phi { .. } => {}
                Inst::LoadIndexed {
                    base,
                    index,
                    index_ext,
                    scale,
                    kind,
                    ..
                } => {
                    let (base, index, ext, scale, kind) =
                        (*base, *index, *index_ext, *scale, *kind);
                    let w = load_width(kind);
                    let same = |e: &IndexedEntry| {
                        (e.base, e.index, e.index_ext, e.scale, e.width)
                            == (base, index, ext, scale, w)
                    };
                    let hit = indexed
                        .iter()
                        .find(|e| same(e))
                        .copied()
                        .filter(|e| span(e.src_idx, i) <= MAX_FORWARD_DISTANCE);
                    if let Some(e) = hit {
                        any |= take(&mut redirect, &mut rewrites, i, e.value, e.load_kind, kind);
                    }
                    if redirect[i].is_none() {
                        indexed.retain(|e| !same(e));
                        indexed.push(IndexedEntry {
                            base,
                            index,
                            index_ext: ext,
                            scale,
                            width: w,
                            value: i as ValueId,
                            src_idx: idx,
                            load_kind: Some(kind),
                        });
                    }
                }
                // No other location is known distinct from the written
                // one (see the module note).
                Inst::StoreIndexed {
                    base,
                    index,
                    index_ext,
                    scale,
                    value,
                    kind,
                    ..
                } => {
                    table.clear();
                    indexed.clear();
                    slot_table.retain(|e| !exposed.contains(&e.off));
                    if let Some(origin) = store_origin(func, *kind, *value) {
                        indexed.push(IndexedEntry {
                            base: *base,
                            index: *index,
                            index_ext: *index_ext,
                            scale: *scale,
                            width: store_width(*kind),
                            value: *value,
                            src_idx: idx,
                            load_kind: origin,
                        });
                    }
                }
                // A zero alloca slot marks a function with no alloca: it
                // writes nothing.
                Inst::AllocaInit(0) => {}
                // Anything that can write through a pointer the pass
                // does not track clears the pointer tables. Forwardable
                // slot entries survive (no address value); exposed slot
                // entries die.
                Inst::Mcpy { .. }
                | Inst::Mzero { .. }
                | Inst::AtomicRmw { .. }
                | Inst::AtomicCas { .. }
                | Inst::AtomicCas16 { .. }
                | Inst::AtomicLoad { .. }
                | Inst::AtomicStore { .. }
                | Inst::AllocaInit(_) => {
                    table.clear();
                    indexed.clear();
                    slot_table.retain(|e| !exposed.contains(&e.off));
                }
                // A call cannot write a forwardable slot either, but
                // forwarding across one would hold the value in a
                // register (or a spill slot) over the call, which costs
                // more than the frame reload it removes. Every table
                // clears.
                Inst::Call { .. }
                | Inst::CallIndirect { .. }
                | Inst::CallExt { .. }
                | Inst::Intrinsic { .. }
                | Inst::Simd { .. }
                | Inst::InlineAsm { .. }
                | Inst::TailExt(_) => {
                    table.clear();
                    indexed.clear();
                    slot_table.clear();
                }
            }
        }
        exits[b] = Some((table, indexed, slot_table, copies));
    }
    for (idx, inst) in rewrites {
        func.insts[idx] = inst;
    }
    store_bits_directly(func);
    if !any {
        return;
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
        // A forwarded load keeps its slot but is now unreferenced; its
        // own operand need not be resolved.
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

/// The value a load of `kind` yields from a location whose low bytes
/// hold `bits`, canonically extended per C99 6.3.1.3. `None` for a
/// floating load, whose value an integer immediate does not describe.
fn const_for_load(bits: i64, kind: LoadKind) -> Option<i64> {
    match kind {
        LoadKind::I64 => Some(bits),
        LoadKind::I32 => Some(bits as i32 as i64),
        LoadKind::U32 => Some(bits as u32 as i64),
        LoadKind::I16 => Some(bits as i16 as i64),
        LoadKind::U16 => Some(bits as u16 as i64),
        LoadKind::I8 => Some(bits as i8 as i64),
        LoadKind::U8 => Some(bits as u8 as i64),
        LoadKind::F32
        | LoadKind::F64
        | LoadKind::F80
        | LoadKind::F128
        | LoadKind::V128
        | LoadKind::V256
        | LoadKind::V512 => None,
    }
}

/// The `(base, displacement)` an access address denotes, following the
/// constant pointer additions the builder emits for a member or an
/// element at a fixed offset. `super::index_fold` folds these into the
/// access's own `disp` field, but it runs after the fixed point this
/// serves, so the store and the load of one member still reach here as
/// two separate additions off the same base.
fn base_disp(func: &FunctionSsa, addr: ValueId, disp: i32) -> (ValueId, i64) {
    let mut base = addr;
    let mut off = disp as i64;
    // Each step consumes one addition; a chain longer than this is not
    // a member path the builder produced.
    for _ in 0..8 {
        let (lhs, k) = match func.insts.get(base as usize) {
            Some(Inst::BinopI {
                op: crate::c5::ir::BinOp::Add,
                lhs,
                rhs_imm,
            }) => (*lhs, *rhs_imm),
            Some(Inst::Binop {
                op: crate::c5::ir::BinOp::Add,
                lhs,
                rhs,
            }) => match (func.insts.get(*lhs as usize), func.insts.get(*rhs as usize)) {
                (_, Some(Inst::Imm(k))) => (*lhs, *k),
                (Some(Inst::Imm(k)), _) => (*rhs, *k),
                _ => break,
            },
            _ => break,
        };
        let Some(next) = off.checked_add(k) else {
            break;
        };
        base = lhs;
        off = next;
    }
    (base, off)
}

/// Byte ranges `[a, a+aw)` and `[b, b+bw)` overlap, at the widened
/// displacements [`base_disp`] produces.
fn overlaps64(a: i64, aw: u8, b: i64, bw: u8) -> bool {
    a < b + bw as i64 && b < a + aw as i64
}

/// The slot byte an access through a slot's `LocalAddr` plus constants names.
fn slot_bytes(func: &FunctionSsa, addr: ValueId, disp: i32) -> Option<i64> {
    let (base, at) = base_disp(func, addr, disp);
    match func.insts.get(base as usize)? {
        Inst::LocalAddr(off) => off.checked_mul(8)?.checked_add(at),
        _ => None,
    }
}

/// `size` bytes of frame object `off` from byte `at` on, copied from `src`
/// at the copy's alignment `align`, while nothing has written memory since:
/// a load of the range reads the source.
#[derive(Clone, Copy, Debug)]
struct Copied {
    off: i64,
    at: i64,
    size: i64,
    src: ValueId,
    align: u32,
}

/// The frame load of the copy source a frame load `i` within one of
/// `copies` becomes, when the source is a frame object: the same bytes of
/// it, at an alignment the copy proves at that offset. A source behind a
/// pointer would keep the pointer live to the load.
fn copy_source(func: &FunctionSsa, copies: &[Copied], i: usize) -> Option<Inst> {
    let Inst::LoadLocal {
        off,
        disp,
        kind,
        volatile: false,
    } = func.insts[i]
    else {
        return None;
    };
    let (at, w) = (i64::from(disp), i64::from(load_width(kind)));
    let c = copies
        .iter()
        .rev()
        .find(|c| c.off == off && at >= c.at && at + w <= c.at + c.size)?;
    let delta = at - c.at;
    let proven = match delta {
        0 => c.align,
        d => c.align.min(1 << d.trailing_zeros()),
    };
    let (s, sat) = base_disp(func, c.src, i32::try_from(delta).ok()?);
    match func.insts.get(s as usize)? {
        &Inst::LocalAddr(off) if i64::from(proven) >= w => Some(Inst::LoadLocal {
            off,
            disp: i32::try_from(sat).ok()?,
            kind,
            volatile: false,
        }),
        _ => None,
    }
}

/// Whether `inst` may change memory: any store, fill, copy, call, atomic,
/// asm statement, alloca, lifetime end or SIMD instruction with a memory
/// destination.
fn writes_memory(inst: &Inst) -> bool {
    !matches!(
        inst,
        Inst::Load { .. }
            | Inst::LoadLocal { .. }
            | Inst::LoadIndexed { .. }
            | Inst::SegLoad { .. }
            | Inst::Imm(_)
            | Inst::Undef
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::ImmExtCode(_)
            | Inst::BlockAddr(_)
            | Inst::LocalAddr(_)
            | Inst::TlsAddr(_)
            | Inst::AllocaInit(0)
            | Inst::Binop { .. }
            | Inst::BinopI { .. }
            | Inst::Neg(_)
            | Inst::Fneg(_)
            | Inst::Fma { .. }
            | Inst::MulAdd { .. }
            | Inst::ShiftOp { .. }
            | Inst::BitField { .. }
            | Inst::Extend { .. }
            | Inst::Bswap { .. }
            | Inst::BitCount { .. }
            | Inst::Copy { .. }
            | Inst::FpCast { .. }
            | Inst::ParamRef { .. }
            | Inst::ParamPart { .. }
            | Inst::SimdVal { .. }
            | Inst::VecBinop { .. }
            | Inst::VecInsert { .. }
            | Inst::VecSplat { .. }
            | Inst::VecConst { .. }
            | Inst::VecExtract { .. }
            | Inst::Select { .. }
            | Inst::Phi { .. }
    )
}

/// A location the block prefix has written a known constant to.
#[derive(Clone, Copy, PartialEq)]
struct ConstEntry {
    addr: ValueId,
    disp: i64,
    width: u8,
    /// The stored constant. A load reads its low `width` bytes.
    bits: i64,
}

/// As [`ConstEntry`], for a frame slot.
#[derive(Clone, Copy, PartialEq)]
struct ConstSlotEntry {
    off: i64,
    width: u8,
    bits: i64,
}

/// The constant an integer store writes, if it writes one.
fn stored_const(
    func: &FunctionSsa,
    value: ValueId,
    kind: StoreKind,
    volatile: bool,
) -> Option<i64> {
    if volatile || !is_int_store(kind) {
        return None;
    }
    match func.insts.get(value as usize) {
        Some(Inst::Imm(k)) => Some(*k),
        _ => None,
    }
}

/// Rewrite every load that reads back a constant this function stored
/// into the location, and report whether anything changed.
///
/// This is the memory half of constant propagation: the value a load
/// yields is decided by the store that last wrote the location, so a
/// location the function itself initialized with a constant makes the
/// load a constant (C99 6.5p2 -- the store and the load are separated
/// by a sequence point and nothing between them writes the object).
/// It runs inside the [`super::simplify_branches`] fixed point beside
/// the const-object load fold, so a build-time assertion written on a
/// member the function just assigned decides its branch and the
/// unreachable call goes away with the block.
///
/// The aliasing and volatile discipline is the one [`run`] documents.
/// Two differences follow from the value being a constant rather than a
/// register: there is no live-range bound, since an immediate
/// rematerializes wherever it is read; and the availability carries
/// into a block with a single predecessor, whose only path in is
/// through that predecessor's exit state. A load-origin entry is not
/// recorded -- only a store seeds a constant here -- so a load left
/// alone stays a load.
pub(crate) fn fold_const_loads(func: &mut FunctionSsa) -> bool {
    // A funclet writes the frame while a call runs, with no address in
    // the tape; the handler reads what the region left.
    if func.has_seh()
        || func.blocks.is_empty()
        || !func
            .insts
            .iter()
            .any(|i| matches!(i, Inst::Store { .. } | Inst::StoreLocal { disp: 0, .. }))
    {
        return false;
    }
    let slots = forwardable_slots(func);
    let exposed = exposed_slots(func, &slots);
    let preds = crate::c5::codegen::ssa::mem2reg::predecessors(func);
    let rpo = super::layout::rpo_numbers(func);
    // Blocks in reverse postorder, so a block's single predecessor is
    // already processed when the block is reached.
    let mut order: Vec<usize> = (0..func.blocks.len()).collect();
    order.sort_by_key(|&b| rpo[b]);

    let mut exit_tables: Vec<Option<(Vec<ConstEntry>, Vec<ConstSlotEntry>)>> =
        alloc::vec![None; func.blocks.len()];
    let mut folds: Vec<(usize, i64)> = Vec::new();

    for b in order {
        let (mut table, mut slot_table) = match preds[b].as_slice() {
            [p] if *p as usize != b => exit_tables[*p as usize].clone().unwrap_or_default(),
            _ => (Vec::new(), Vec::new()),
        };
        let range = func.blocks[b].inst_range.clone();
        for idx in range {
            let i = idx as usize;
            if i >= func.insts.len() {
                break;
            }
            match func.insts[i] {
                Inst::Load { volatile: true, .. } | Inst::LoadLocal { volatile: true, .. } => {}
                Inst::Load {
                    addr, disp, kind, ..
                } => {
                    let (addr, disp) = base_disp(func, addr, disp);
                    let w = load_width(kind);
                    if let Some(e) = table
                        .iter()
                        .find(|e| e.addr == addr && e.disp == disp && e.width == w)
                        && let Some(c) = const_for_load(e.bits, kind)
                    {
                        folds.push((i, c));
                    }
                }
                // Entries hold slots' base bytes only.
                Inst::LoadLocal { disp, .. } if disp != 0 => {}
                Inst::LoadLocal {
                    off,
                    kind,
                    volatile: false,
                    ..
                } => {
                    let w = load_width(kind);
                    if let Some(e) = slot_table.iter().find(|e| e.off == off && e.width == w)
                        && let Some(c) = const_for_load(e.bits, kind)
                    {
                        folds.push((i, c));
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
                    let (addr, disp) = base_disp(func, addr, disp);
                    let w = store_width(kind);
                    table.retain(|e| e.addr == addr && !overlaps64(e.disp, e.width, disp, w));
                    slot_table.retain(|e| !exposed.contains(&e.off));
                    if let Some(bits) = stored_const(func, value, kind, volatile) {
                        table.push(ConstEntry {
                            addr,
                            disp,
                            width: w,
                            bits,
                        });
                    }
                }
                Inst::StoreLocal {
                    off,
                    disp,
                    value,
                    kind,
                    volatile,
                    ..
                } => {
                    table.clear();
                    let at = off * 8 + i64::from(disp);
                    let w = store_width(kind);
                    slot_table.retain(|e| !overlaps64(e.off * 8, e.width, at, w));
                    if disp == 0
                        && (slots.contains(&off) || exposed.contains(&off))
                        && let Some(bits) = stored_const(func, value, kind, volatile)
                    {
                        slot_table.push(ConstSlotEntry {
                            off,
                            width: store_width(kind),
                            bits,
                        });
                    }
                }
                Inst::SegLoad { .. }
                | Inst::SegStore { .. }
                | Inst::LoadIndexed { .. }
                | Inst::Imm(_)
                | Inst::Undef
                | Inst::ExceptionCode
                | Inst::ParentLocalAddr { .. }
                | Inst::ImmData(_)
                | Inst::ImmCode(_)
                | Inst::ImmExtCode(_)
                | Inst::BlockAddr(_)
                | Inst::LocalAddr(_)
                | Inst::TlsAddr(_)
                | Inst::LifetimeEnd(_)
                | Inst::Binop { .. }
                | Inst::SimdVal { .. }
                | Inst::VecBinop { .. }
                | Inst::VecInsert { .. }
                | Inst::VecSplat { .. }
                | Inst::VecConst { .. }
                | Inst::VecExtract { .. }
                | Inst::Select { .. }
                | Inst::BinopI { .. }
                | Inst::Neg(_)
                | Inst::Fneg(_)
                | Inst::Fma { .. }
                | Inst::MulAdd { .. }
                | Inst::ShiftOp { .. }
                | Inst::BitField { .. }
                | Inst::Udiv128 { .. }
                | Inst::Extend { .. }
                | Inst::Bswap { .. }
                | Inst::BitCount { .. }
                | Inst::Copy { .. }
                | Inst::FpCast { .. }
                | Inst::ParamRef { .. }
                | Inst::ParamPart { .. }
                | Inst::RetPart { .. }
                | Inst::AsmOut { .. }
                | Inst::AggParts { .. }
                | Inst::Phi { .. } => {}
                Inst::AllocaInit(0) => {}
                Inst::StoreIndexed { .. }
                | Inst::Mcpy { .. }
                | Inst::Mzero { .. }
                | Inst::AtomicRmw { .. }
                | Inst::AtomicCas { .. }
                | Inst::AtomicCas16 { .. }
                | Inst::AtomicLoad { .. }
                | Inst::AtomicStore { .. }
                | Inst::AllocaInit(_) => {
                    table.clear();
                    slot_table.retain(|e| !exposed.contains(&e.off));
                }
                // A call can write any location a pointer reaches, so
                // the pointer table dies. A forwardable slot has no
                // address value for a callee to write through, and an
                // immediate costs nothing to keep available, so its
                // entries survive; an exposed slot's do not.
                Inst::Call { .. }
                | Inst::CallIndirect { .. }
                | Inst::CallExt { .. }
                | Inst::Intrinsic { .. }
                | Inst::Simd { .. }
                | Inst::InlineAsm { .. }
                | Inst::TailExt(_) => {
                    table.clear();
                    slot_table.retain(|e| !exposed.contains(&e.off));
                }
            }
        }
        exit_tables[b] = Some((table, slot_table));
    }

    if folds.is_empty() {
        return false;
    }
    for (i, c) in folds {
        func.insts[i] = Inst::Imm(c);
    }
    true
}

#[cfg(test)]
mod tests {
    use super::run_one;
    use crate::c5::ir::{
        Block, FpCastKind, FunctionSsa, IndexExt, Inst, LoadKind, StoreKind, Terminator,
    };
    use alloc::vec::Vec;

    fn fresh(insts: Vec<Inst>, term: Terminator, exit_acc: u32) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            seh_scopes: Vec::new(),
            block_seh: Vec::new(),
            funclet_slots: Vec::new(),
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            ssp: crate::c5::ir::SspFacts::default(),
            n_params: 2,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
            is_noinline: false,
            is_naked: false,
            is_noreturn: false,
            conv: crate::c5::codegen::CallConv::Target,
            general_regs_only: false,
            tls_dynamic: false,
            section: None,
            patchable_entry: None,
            no_instrument: false,
            no_stack_protector: false,
            is_weak: false,
            is_internal: false,
            const_params: 0,
            inst_src: alloc::vec![crate::c5::ir::InstSrc::default(); n],
            f32_values: alloc::vec![false; n],
            cmp32: Vec::new(),
            div32: Vec::new(),
            low_word_tests: Vec::new(),
            param_fp_mask: crate::c5::ir::FpMask::EMPTY,
            param_widths: crate::c5::ir::ArgWidths::default(),
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            ret_type_tag: None,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            label_data_relocs: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            array_slots: Vec::new(),
            vector_objects: Vec::new(),
            owned_params: Vec::new(),
            over_aligned: Default::default(),
            frame_align: 0,
            realign_region_bytes: 0,
            has_returns_twice_call: false,
            did_unroll: false,
            did_inline: false,
            insts,
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n as u32,
                terminator: term,
                exit_acc,
            }],
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    /// `AllocaInit(off)` reserves slot `off` for the alloca bookkeeping: a
    /// load of it never forwards, while another slot's load does.
    #[test]
    fn the_slot_alloca_reserves_does_not_forward() {
        for (off, forwarded) in [(-3, false), (-2, true)] {
            let mut f = fresh(
                alloc::vec![
                    Inst::AllocaInit(-3),
                    Inst::ParamRef {
                        idx: 0,
                        kind: LoadKind::I64
                    },
                    Inst::StoreLocal {
                        off,
                        disp: 0,
                        value: 1,
                        kind: StoreKind::I64,
                        volatile: false,
                        nsw: false,
                    },
                    Inst::LoadLocal {
                        off,
                        disp: 0,
                        kind: LoadKind::I64,
                        volatile: false,
                    },
                ],
                Terminator::Return(3),
                3,
            );
            run_one(&mut f);
            let ret = if forwarded { 1 } else { 3 };
            assert!(
                matches!(f.blocks[0].terminator, Terminator::Return(r) if r == ret),
                "slot {off}: {:?}",
                f.blocks[0].terminator
            );
        }
    }

    /// A store into either half of a 16-byte slot entry invalidates it,
    /// one into a disjoint cell does not.
    #[test]
    fn a_store_overlapping_a_wide_slot_entry_invalidates_it() {
        let wide = |off| Inst::LoadLocal {
            off,
            disp: 0,
            kind: LoadKind::V128,
            volatile: false,
        };
        for (off, disp, forwarded) in [
            (-2, 9, false),
            (-1, 0, false),
            (-3, 0, true),
            (-2, 16, true),
        ] {
            let mut f = fresh(
                alloc::vec![
                    Inst::ParamRef {
                        idx: 0,
                        kind: LoadKind::I64
                    },
                    wide(-2),
                    Inst::StoreLocal {
                        off,
                        disp,
                        value: 0,
                        kind: StoreKind::I8,
                        volatile: false,
                        nsw: false,
                    },
                    wide(-2),
                ],
                Terminator::Return(3),
                3,
            );
            run_one(&mut f);
            let ret = if forwarded { 1 } else { 3 };
            assert!(
                matches!(f.blocks[0].terminator, Terminator::Return(r) if r == ret),
                "store at slot {off} + {disp}: {:?}",
                f.blocks[0].terminator
            );
        }
    }

    /// A displaced slot load forwards from its store unless a store between
    /// them, to the slot or through its address, overlaps its bytes.
    #[test]
    fn a_displaced_slot_load_forwards_from_its_store() {
        let local = |off, disp, kind| Inst::LoadLocal {
            off,
            disp,
            kind,
            volatile: false,
        };
        let store = |off, disp, value, kind| Inst::StoreLocal {
            off,
            disp,
            value,
            kind,
            volatile: false,
            nsw: false,
        };
        let through = |addr, disp, kind| Inst::Store {
            addr,
            disp,
            value: 0,
            kind,
            volatile: false,
            align: 8,
            pc_rel: false,
        };
        for (between, forwarded) in [
            (store(-4, 0, 0, StoreKind::I64), true),
            (store(-4, 12, 0, StoreKind::I32), false),
            (store(-3, 0, 0, StoreKind::I32), false),
            (store(-3, 4, 0, StoreKind::I8), false),
            (store(-4, 16, 0, StoreKind::I64), true),
            (through(1, 0, StoreKind::I64), true),
            (through(1, 12, StoreKind::I32), false),
            (through(0, 0, StoreKind::I64), false),
        ] {
            let mut f = fresh(
                alloc::vec![
                    Inst::ParamRef {
                        idx: 0,
                        kind: LoadKind::I64
                    },
                    Inst::LocalAddr(-4),
                    store(-4, 8, 0, StoreKind::I64),
                    between.clone(),
                    local(-4, 8, LoadKind::I64),
                ],
                Terminator::Return(4),
                4,
            );
            run_one(&mut f);
            let ret = if forwarded { 0 } else { 4 };
            assert!(
                matches!(f.blocks[0].terminator, Terminator::Return(r) if r == ret),
                "{between:?}: {:?}",
                f.blocks[0].terminator
            );
        }
    }

    /// An unsigned re-read of a signed store's bytes forwards from the first.
    #[test]
    fn a_slot_load_no_entry_serves_seeds_one_for_its_kind() {
        let store = |disp| Inst::StoreLocal {
            off: -2,
            disp,
            value: 0,
            kind: StoreKind::I32,
            volatile: false,
            nsw: false,
        };
        let load = Inst::LoadLocal {
            off: -2,
            disp: 0,
            kind: LoadKind::U32,
            volatile: false,
        };
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                store(0),
                load.clone(),
                store(4),
                load,
            ],
            Terminator::Return(4),
            4,
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(2)),
            "{:?}",
            f.blocks[0].terminator
        );
    }

    /// `*p = s; return *p;` forwards the I64 load to the stored value, so
    /// the return reads the stored register and the load goes dead.
    #[test]
    fn store_then_load_i64_redirects_to_stored_value() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64
                },
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 1,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
            ],
            Terminator::Return(3),
            3,
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(1)),
            "the I64 load should redirect to the stored value v1",
        );
    }

    /// A signed sub-width reload becomes an `Extend` of the stored value:
    /// `narrow_store` writes the low bytes, the load sign-extends them.
    #[test]
    fn signed_subwidth_load_becomes_extend() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64
                },
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 1,
                    kind: StoreKind::I32,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
            ],
            Terminator::Return(3),
            3,
        );
        run_one(&mut f);
        assert!(
            matches!(
                f.insts[3],
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                    ..
                }
            ),
            "an I32 reload of an I32 store should become Extend(stored, I32)",
        );
    }

    /// An unsigned sub-width reload is left alone: `Inst::Extend` does
    /// not zero-extend the unsigned widths, so the stored register cannot
    /// be reused without a mask the pass does not emit.
    #[test]
    fn unsigned_subwidth_load_not_forwarded() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64
                },
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 1,
                    kind: StoreKind::I8,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::U8,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
            ],
            Terminator::Return(3),
            3,
        );
        run_one(&mut f);
        assert!(
            matches!(
                f.insts[3],
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::U8,
                    volatile: false,
                    align: 0,
                    ..
                }
            ),
            "an unsigned sub-width reload must not forward",
        );
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(3)));
    }

    /// A block copy between the store and the load clears the table: the
    /// copy can write through the destination pointer, so the reload is
    /// not forwarded.
    #[test]
    fn clobber_between_store_and_load_blocks_forward() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64
                },
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 1,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
                Inst::Mcpy {
                    dst: 0,
                    src: 1,
                    size: 8,
                    align: 8,
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
            ],
            Terminator::Return(4),
            4,
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(4)),
            "the load past a block copy must not forward",
        );
        assert!(matches!(f.insts[4], Inst::Load { .. }));
    }

    /// An `Inst::InlineAsm` is an ordering barrier (`asm
    /// volatile("" ::: "memory")`): a store before it may not satisfy
    /// a load after it.
    #[test]
    fn inline_asm_barrier_blocks_forwarding() {
        let asm = alloc::boxed::Box::new(crate::c5::ir::AsmBlock {
            template: Vec::new(),
            operands: Vec::new(),
            clobber_regs: 0,
            clobber_fp_regs: 0,
            clobber_memory: true,
            volatile: true,
        });
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64
                },
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 1,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
                Inst::InlineAsm {
                    asm,
                    args: Vec::new()
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
            ],
            Terminator::Return(4),
            4,
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(4)),
            "a load must not forward across an asm barrier",
        );
    }

    /// A volatile store seeds no forwarding entry: the reload after it
    /// must read memory (C99 6.7.3p6).
    #[test]
    fn volatile_store_seeds_no_forward() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64
                },
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 1,
                    kind: StoreKind::I64,
                    volatile: true,
                    align: 0,
                    pc_rel: false
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
            ],
            Terminator::Return(3),
            3,
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(3)),
            "a load after a volatile store must not forward",
        );
        assert!(matches!(f.insts[3], Inst::Load { .. }));
    }

    /// A volatile load neither reuses an available value nor seeds one:
    /// each source-level read performs its own access (C99 5.1.2.3p2).
    #[test]
    fn volatile_load_neither_reuses_nor_seeds() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64
                },
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 1,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: true,
                    align: 0,
                    pc_rel: false
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: true,
                    align: 0,
                    pc_rel: false
                },
                Inst::Binop {
                    op: crate::c5::ir::BinOp::Add,
                    lhs: 3,
                    rhs: 4
                },
            ],
            Terminator::Return(5),
            5,
        );
        run_one(&mut f);
        assert!(
            matches!(f.insts[5], Inst::Binop { lhs: 3, rhs: 4, .. }),
            "volatile loads must not forward from the store or each other",
        );
    }

    /// `slot = s; return slot;` forwards the I64 slot reload to the
    /// stored value.
    #[test]
    fn store_local_then_load_local_redirects() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::StoreLocal {
                    disp: 0,
                    off: -1,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                    nsw: false,
                },
                Inst::LoadLocal {
                    disp: 0,
                    off: -1,
                    kind: LoadKind::I64,
                    volatile: false,
                },
            ],
            Terminator::Return(2),
            2,
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(0)),
            "the slot reload should redirect to the stored value v0",
        );
    }

    /// A whole vector stored to a slot and reloaded as the same vector kind
    /// is the stored register's value; an immediate vector, a pattern in a
    /// general register, still reads memory.
    #[test]
    fn a_vector_slot_reload_redirects_to_the_stored_vector() {
        for (value, forwards) in [
            (
                Inst::ParamPart {
                    idx: 0,
                    part: 0,
                    kind: LoadKind::V128,
                },
                true,
            ),
            (Inst::Imm(0), false),
        ] {
            let mut f = fresh(
                alloc::vec![
                    value,
                    Inst::StoreLocal {
                        disp: 0,
                        off: -2,
                        value: 0,
                        kind: StoreKind::V128,
                        volatile: false,
                        nsw: false,
                    },
                    Inst::LoadLocal {
                        disp: 0,
                        off: -2,
                        kind: LoadKind::V128,
                        volatile: false,
                    },
                ],
                Terminator::Return(2),
                2,
            );
            run_one(&mut f);
            let redirected = matches!(f.blocks[0].terminator, Terminator::Return(0));
            assert_eq!(redirected, forwards, "{:?}", f.insts[0]);
        }
    }

    /// The forward distance counts the instructions the emit performs: a
    /// run of constants nothing reads leaves the reload in reach, the same
    /// run of live arithmetic does not.
    #[test]
    fn unread_constants_add_no_forward_distance() {
        for (live, forwards) in [(false, true), (true, false)] {
            let mut insts = alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::StoreLocal {
                    disp: 0,
                    off: -1,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                    nsw: false,
                },
            ];
            for k in 0..20 {
                insts.push(if live {
                    Inst::BinopI {
                        op: crate::c5::ir::BinOp::Add,
                        lhs: if k == 0 {
                            0
                        } else {
                            insts.len() as ValueId - 1
                        },
                        rhs_imm: 1,
                    }
                } else {
                    Inst::Imm(0)
                });
            }
            let chain = insts.len() as ValueId - 1;
            insts.push(Inst::LoadLocal {
                disp: 0,
                off: -1,
                kind: LoadKind::I64,
                volatile: false,
            });
            let load = chain + 1;
            insts.push(Inst::Binop {
                op: crate::c5::ir::BinOp::Add,
                lhs: chain,
                rhs: load,
            });
            let n = insts.len() as ValueId - 1;
            let mut f = fresh(insts, Terminator::Return(n), n);
            run_one(&mut f);
            let forwarded = matches!(f.insts[n as usize], Inst::Binop { rhs: 0, .. });
            assert_eq!(forwarded, forwards, "live arithmetic in between: {live}");
        }
    }

    /// A frame load of bytes a block copy filled from a frame object reads
    /// that object at the same offset. A source behind a pointer, or a
    /// store after the copy, keeps the frame load.
    #[test]
    fn a_load_of_copied_bytes_reads_the_copy_source() {
        for (src, stored, want) in [
            (
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                false,
                Inst::LoadLocal {
                    off: -2,
                    disp: 8,
                    kind: LoadKind::I64,
                    volatile: false,
                },
            ),
            (
                Inst::LocalAddr(-6),
                false,
                Inst::LoadLocal {
                    off: -6,
                    disp: 8,
                    kind: LoadKind::I64,
                    volatile: false,
                },
            ),
            (
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                true,
                Inst::LoadLocal {
                    off: -2,
                    disp: 8,
                    kind: LoadKind::I64,
                    volatile: false,
                },
            ),
        ] {
            let mut f = fresh(
                alloc::vec![
                    src,
                    Inst::LocalAddr(-2),
                    Inst::Mcpy {
                        dst: 1,
                        src: 0,
                        size: 16,
                        align: 8,
                    },
                    if stored {
                        Inst::StoreLocal {
                            disp: 0,
                            off: -4,
                            value: 0,
                            kind: StoreKind::I64,
                            volatile: false,
                            nsw: false,
                        }
                    } else {
                        Inst::Imm(0)
                    },
                    Inst::LoadLocal {
                        off: -2,
                        disp: 8,
                        kind: LoadKind::I64,
                        volatile: false,
                    },
                ],
                Terminator::Return(4),
                4,
            );
            run_one(&mut f);
            assert_eq!(format!("{:?}", f.insts[4]), format!("{want:?}"));
        }
    }

    /// Each frame object has its own number, whatever its size: a copy into
    /// the 16-byte object -2 leaves a load of object -1 reading that object.
    #[test]
    fn a_copy_into_one_object_leaves_the_next_one_alone() {
        let load = Inst::LoadLocal {
            off: -1,
            disp: 0,
            kind: LoadKind::I64,
            volatile: false,
        };
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::LocalAddr(-2),
                Inst::Mcpy {
                    dst: 1,
                    src: 0,
                    size: 16,
                    align: 8,
                },
                load.clone(),
            ],
            Terminator::Return(3),
            3,
        );
        run_one(&mut f);
        assert_eq!(format!("{:?}", f.insts[3]), format!("{load:?}"));
    }

    /// A call between the slot store and the reload blocks the forward:
    /// not for aliasing (the callee cannot reach the slot) but because
    /// forwarding would keep the value live across the call.
    #[test]
    fn store_local_does_not_forward_across_call() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::StoreLocal {
                    disp: 0,
                    off: -1,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                    nsw: false,
                },
                Inst::Call {
                    target_pc: 0,
                    args: Vec::new(),
                    fixed_args: 0,
                    fp_return: false,
                    fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
                    low_word_args: 0,
                    arg_widths: crate::c5::ir::ArgWidths::default(),
                    callee_conv: crate::c5::codegen::CallConv::Target,
                    arg_aggs: Vec::new(),
                    ret_agg: None,
                    ret_slot_local: 0,
                },
                Inst::LoadLocal {
                    disp: 0,
                    off: -1,
                    kind: LoadKind::I64,
                    volatile: false,
                },
            ],
            Terminator::Return(3),
            3,
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(3)),
            "a reload after a call must stay a reload",
        );
    }

    /// A slot whose address is taken anywhere in the function never
    /// forwards: a store through the pointer could sit between the
    /// slot store and the reload.
    #[test]
    fn address_taken_slot_does_not_forward() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::LocalAddr(-1),
                Inst::StoreLocal {
                    disp: 0,
                    off: -1,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                    nsw: false,
                },
                Inst::Store {
                    addr: 1,
                    disp: 0,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
                Inst::LoadLocal {
                    disp: 0,
                    off: -1,
                    kind: LoadKind::I64,
                    volatile: false,
                },
            ],
            Terminator::Return(4),
            4,
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(4)),
            "an address-taken slot must not forward",
        );
    }

    /// A volatile slot store pins the slot: neither it nor any access
    /// of the slot forwards (C99 6.7.3p6).
    #[test]
    fn volatile_store_local_does_not_forward() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::StoreLocal {
                    disp: 0,
                    off: -1,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: true,
                    nsw: false,
                },
                Inst::LoadLocal {
                    disp: 0,
                    off: -1,
                    kind: LoadKind::I64,
                    volatile: false,
                },
            ],
            Terminator::Return(2),
            2,
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(2)),
            "a volatile-stored slot must not forward",
        );
    }

    /// A second store to the slot replaces the tracked value: the
    /// reload forwards to the newer store, not the older one.
    #[test]
    fn second_store_local_replaces_entry() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64
                },
                Inst::StoreLocal {
                    disp: 0,
                    off: -1,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                    nsw: false,
                },
                Inst::StoreLocal {
                    disp: 0,
                    off: -1,
                    value: 1,
                    kind: StoreKind::I64,
                    volatile: false,
                    nsw: false,
                },
                Inst::LoadLocal {
                    disp: 0,
                    off: -1,
                    kind: LoadKind::I64,
                    volatile: false,
                },
            ],
            Terminator::Return(4),
            4,
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(1)),
            "the reload should forward to the second store's value",
        );
    }

    /// A signed sub-width slot reload becomes an `Extend` of the
    /// stored value, as for the pointer path.
    #[test]
    fn signed_subwidth_slot_reload_becomes_extend() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::StoreLocal {
                    disp: 0,
                    off: -1,
                    value: 0,
                    kind: StoreKind::I32,
                    volatile: false,
                    nsw: false,
                },
                Inst::LoadLocal {
                    disp: 0,
                    off: -1,
                    kind: LoadKind::I32,
                    volatile: false,
                },
            ],
            Terminator::Return(2),
            2,
        );
        run_one(&mut f);
        assert!(
            matches!(
                f.insts[2],
                Inst::Extend {
                    value: 0,
                    kind: LoadKind::I32,
                    ..
                }
            ),
            "an I32 slot reload of an I32 store should become Extend(stored, I32)",
        );
    }

    /// A call's aggregate-return slot is written by the call itself, so
    /// it never forwards even without a `LocalAddr`.
    #[test]
    fn call_ret_slot_does_not_forward() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::StoreLocal {
                    disp: 0,
                    off: -2,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                    nsw: false,
                },
                Inst::Call {
                    target_pc: 0,
                    args: Vec::new(),
                    fixed_args: 0,
                    fp_return: false,
                    fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
                    low_word_args: 0,
                    arg_widths: crate::c5::ir::ArgWidths::default(),
                    callee_conv: crate::c5::codegen::CallConv::Target,
                    arg_aggs: Vec::new(),
                    ret_agg: Some(0),
                    ret_slot_local: -2,
                },
                Inst::LoadLocal {
                    disp: 0,
                    off: -2,
                    kind: LoadKind::I64,
                    volatile: false,
                },
            ],
            Terminator::Return(3),
            3,
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(3)),
            "a call result slot must not forward across the call",
        );
    }

    /// Two loads of the same location with no write between: the second
    /// forwards to the first.
    #[test]
    fn load_to_load_forwards_same_kind() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
                Inst::Binop {
                    op: crate::c5::ir::BinOp::Add,
                    lhs: 2,
                    rhs: 3
                },
            ],
            Terminator::Return(4),
            4,
        );
        run_one(&mut f);
        // v3 redirects to v2, so the add reads v2 twice.
        assert!(
            matches!(f.insts[4], Inst::Binop { lhs: 2, rhs: 2, .. }),
            "the second identical load should forward to the first",
        );
    }

    fn param(idx: u8) -> Inst {
        Inst::ParamRef {
            idx: idx.into(),
            kind: LoadKind::I64,
        }
    }

    fn load_indexed(base: u32, index: u32, scale: u8, kind: LoadKind) -> Inst {
        Inst::LoadIndexed {
            base,
            index,
            index_ext: IndexExt::None,
            scale,
            kind,
            abs_base: false,
        }
    }

    fn store_indexed(base: u32, index: u32, scale: u8, value: u32, kind: StoreKind) -> Inst {
        Inst::StoreIndexed {
            base,
            index,
            index_ext: IndexExt::None,
            scale,
            value,
            kind,
            abs_base: false,
        }
    }

    /// v0 = base, v1 = index, v2 = a second index / pointer / value;
    /// v3 = `first`, then `between`, then a final `LoadIndexed` of
    /// `(v0, v1, scale 1, kind)`, which the function returns. Yields the
    /// value returned and the final load's instruction after the pass.
    fn indexed_reload(first: Inst, between: Vec<Inst>, kind: LoadKind) -> (u32, Inst) {
        let mut insts = alloc::vec![param(0), param(1), param(2), first];
        insts.extend(between);
        let last = insts.len() as u32;
        insts.push(load_indexed(0, 1, 1, kind));
        let mut f = fresh(insts, Terminator::Return(last), last);
        run_one(&mut f);
        let Terminator::Return(v) = f.blocks[0].terminator else {
            unreachable!()
        };
        (v, f.insts[last as usize].clone())
    }

    #[test]
    fn indexed_load_to_load_forwards_on_the_same_key() {
        let (v, _) = indexed_reload(
            load_indexed(0, 1, 1, LoadKind::U8),
            Vec::new(),
            LoadKind::U8,
        );
        assert_eq!(
            v, 3,
            "a second load of (base, index, scale, kind) reuses the first"
        );
    }

    /// A different index value, scale, base or load kind is another key.
    #[test]
    fn indexed_load_with_another_key_reads_memory() {
        for first in [
            load_indexed(0, 2, 1, LoadKind::U8),
            load_indexed(2, 1, 1, LoadKind::U8),
            load_indexed(0, 1, 1, LoadKind::I8),
            load_indexed(0, 1, 4, LoadKind::U32),
        ] {
            let (v, last) = indexed_reload(first.clone(), Vec::new(), LoadKind::U8);
            assert_eq!(v, 4, "{first:?} must not satisfy the load");
            assert!(matches!(last, Inst::LoadIndexed { .. }));
        }
    }

    #[test]
    fn indexed_store_forwards_by_width_and_signedness() {
        let (v, last) = indexed_reload(
            store_indexed(0, 1, 1, 2, StoreKind::I8),
            Vec::new(),
            LoadKind::I8,
        );
        assert_eq!(v, 4);
        assert!(
            matches!(
                last,
                Inst::Extend {
                    value: 2,
                    kind: LoadKind::I8,
                    ..
                }
            ),
            "a signed reload sign-extends the stored value: {last:?}"
        );
        let (v, last) = indexed_reload(
            store_indexed(0, 1, 1, 2, StoreKind::I8),
            Vec::new(),
            LoadKind::U8,
        );
        assert_eq!(v, 4);
        assert!(
            matches!(last, Inst::LoadIndexed { .. }),
            "an unsigned sub-width reload reads memory: {last:?}"
        );
    }

    /// Every instruction that can write the element between the two
    /// accesses sends the second one to memory. `v2` may equal `v1` at run
    /// time, so a store through another index value is such a write.
    #[test]
    fn indexed_forward_stops_at_every_possible_write() {
        let asm = alloc::boxed::Box::new(crate::c5::ir::AsmBlock {
            template: Vec::new(),
            operands: Vec::new(),
            clobber_regs: 0,
            clobber_fp_regs: 0,
            clobber_memory: true,
            volatile: true,
        });
        let plain_store = |volatile| Inst::Store {
            addr: 2,
            disp: 0,
            value: 2,
            kind: StoreKind::I8,
            volatile,
            align: 0,
            pc_rel: false,
        };
        let barriers: Vec<Inst> = alloc::vec![
            store_indexed(0, 2, 1, 2, StoreKind::I8),
            store_indexed(2, 1, 1, 2, StoreKind::I8),
            plain_store(false),
            plain_store(true),
            Inst::StoreLocal {
                disp: 0,
                off: 8,
                value: 2,
                kind: StoreKind::I64,
                volatile: false,
                nsw: false,
            },
            Inst::Mcpy {
                dst: 2,
                src: 0,
                size: 16,
                align: 1,
            },
            Inst::Mzero {
                dst: 2,
                size: 16,
                align: 1,
            },
            Inst::CallExt {
                binding_idx: 0,
                args: Vec::new(),
                fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
                low_word_args: 0,
                arg_widths: crate::c5::ir::ArgWidths::default(),
                fp_return: false,
                arg_aggs: Vec::new(),
                ret_agg: None,
                ret_slot_local: 0,
            },
            Inst::InlineAsm {
                asm,
                args: Vec::new(),
            },
        ];
        for barrier in barriers {
            for first in [
                load_indexed(0, 1, 1, LoadKind::I8),
                store_indexed(0, 1, 1, 2, StoreKind::I8),
            ] {
                let (v, last) =
                    indexed_reload(first.clone(), alloc::vec![barrier.clone()], LoadKind::I8);
                assert_eq!(v, 5, "{first:?} forwarded across {barrier:?}");
                assert!(
                    matches!(last, Inst::LoadIndexed { .. }),
                    "{first:?} forwarded across {barrier:?}: {last:?}"
                );
            }
        }
    }

    /// A volatile load reads only: the entries around it stay valid.
    #[test]
    fn indexed_forward_passes_a_volatile_load() {
        let volatile_load = Inst::Load {
            addr: 2,
            disp: 0,
            kind: LoadKind::I8,
            volatile: true,
            align: 0,
            pc_rel: false,
        };
        let (v, _) = indexed_reload(
            load_indexed(0, 1, 1, LoadKind::I8),
            alloc::vec![volatile_load],
            LoadKind::I8,
        );
        assert_eq!(v, 3);
    }

    /// An indexed store can write the location a pointer entry names.
    #[test]
    fn indexed_store_drops_pointer_entries() {
        let mut f = fresh(
            alloc::vec![
                param(0),
                param(1),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I8,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
                store_indexed(1, 0, 1, 1, StoreKind::I8),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I8,
                    volatile: false,
                    align: 0,
                    pc_rel: false
                },
            ],
            Terminator::Return(4),
            4,
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(4)));
    }

    use crate::c5::ir::{BinOp, NO_VALUE, ValueId};

    fn load_of(addr: ValueId) -> Inst {
        Inst::Load {
            addr,
            disp: 0,
            kind: LoadKind::I64,
            volatile: false,
            align: 0,
            pc_rel: false,
        }
    }

    /// `insts` over two blocks split at `split`, the first jumping to the
    /// second, which returns `ret`.
    fn two_blocks(insts: Vec<Inst>, split: u32, ret: ValueId) -> FunctionSsa {
        let n = insts.len() as u32;
        let mut f = fresh(insts, Terminator::Return(ret), ret);
        let block = |r: core::ops::Range<u32>, terminator| crate::c5::ir::Block {
            start_pc: 0,
            inst_range: r,
            terminator,
            exit_acc: NO_VALUE,
        };
        f.blocks = alloc::vec![
            block(0..split, Terminator::Jmp(1)),
            block(split..n, Terminator::Return(ret)),
        ];
        f
    }

    /// A block its one predecessor alone reaches reuses a load that block
    /// made.
    #[test]
    fn a_load_forwards_into_a_block_one_predecessor_reaches() {
        let param = Inst::ParamRef {
            idx: 0,
            kind: LoadKind::I64,
        };
        let add = Inst::Binop {
            op: BinOp::Add,
            lhs: 1,
            rhs: 2,
        };
        let mut f = two_blocks(alloc::vec![param, load_of(0), load_of(0), add], 2, 3);
        run_one(&mut f);
        assert!(
            matches!(f.insts[3], Inst::Binop { lhs: 1, rhs: 1, .. }),
            "{:?}",
            f.insts[3]
        );
    }

    /// An entry too far to serve gives way to the next load of its
    /// location, which the load after it then reuses.
    #[test]
    fn a_load_stands_in_for_an_entry_too_far_to_serve() {
        let param = Inst::ParamRef {
            idx: 0,
            kind: LoadKind::I64,
        };
        let mut insts = alloc::vec![param, load_of(0)];
        insts.extend(live_filler(2));
        let near = insts.len() as ValueId;
        insts.extend([load_of(0), load_of(0)]);
        insts.push(Inst::Binop {
            op: BinOp::Sub,
            lhs: near,
            rhs: near + 1,
        });
        let ret = near + 2;
        let mut f = two_blocks(insts, 2, ret);
        run_one(&mut f);
        assert!(
            matches!(f.insts[ret as usize], Inst::Binop { lhs, rhs, .. } if lhs == near && rhs == near),
            "{:?}",
            f.insts[ret as usize]
        );
    }

    /// Arithmetic from the parameter `v0`, starting at value `start`, that
    /// the emit performs past the forward bound: each step reads the one
    /// before it.
    fn live_filler(start: ValueId) -> Vec<Inst> {
        (0..super::MAX_FORWARD_DISTANCE + 2)
            .map(|k| Inst::BinopI {
                op: BinOp::Add,
                lhs: if k == 0 { 0 } else { start + k - 1 },
                rhs_imm: 1,
            })
            .collect()
    }

    #[test]
    fn indexed_forward_is_bounded_by_distance() {
        let filler = live_filler(4);
        let (v, _) = indexed_reload(load_indexed(0, 1, 1, LoadKind::I8), filler, LoadKind::I8);
        assert_ne!(v, 3, "a reuse past the bound reloads");
    }

    /// A double stored from a floating register and read back as a 64-bit
    /// integer, or the reverse, is the bit-for-bit cast of the stored
    /// value, and an 8-byte store of that cast stores its operand.
    #[test]
    fn a_load_of_the_other_register_file_moves_the_bits() {
        for (param, stored, loaded, cast) in [
            (
                LoadKind::F64,
                StoreKind::F64,
                LoadKind::I64,
                FpCastKind::FpBits,
            ),
            (
                LoadKind::I64,
                StoreKind::I64,
                LoadKind::F64,
                FpCastKind::BitsFp,
            ),
        ] {
            let store = |off, value, kind| Inst::StoreLocal {
                off,
                disp: 0,
                value,
                kind,
                volatile: false,
                nsw: false,
            };
            let restored = if stored == StoreKind::F64 {
                StoreKind::I64
            } else {
                StoreKind::F64
            };
            let mut f = fresh(
                alloc::vec![
                    Inst::ParamRef {
                        idx: 0,
                        kind: param
                    },
                    store(-2, 0, stored),
                    Inst::LoadLocal {
                        off: -2,
                        disp: 0,
                        kind: loaded,
                        volatile: false,
                    },
                    store(-3, 2, restored),
                ],
                Terminator::Return(2),
                4,
            );
            run_one(&mut f);
            assert!(
                matches!(f.insts[2], Inst::FpCast { kind, value: 0 } if kind == cast),
                "{cast:?}: {:?}",
                f.insts[2]
            );
            assert!(
                matches!(f.insts[3], Inst::StoreLocal { value: 0, kind, .. } if kind == stored),
                "{cast:?}: {:?}",
                f.insts[3]
            );
        }
    }

    /// An integer store of a double held in an FP register writes the
    /// double's bits: an 8-byte reload of either kind reads them, and a
    /// narrower one reads memory.
    #[test]
    fn an_integer_store_of_a_double_is_the_double() {
        for (stored, loaded, want) in [
            (StoreKind::I64, LoadKind::I64, Some(FpCastKind::FpBits)),
            (StoreKind::I64, LoadKind::F64, None),
            (StoreKind::I32, LoadKind::I32, None),
        ] {
            let mut f = fresh(
                alloc::vec![
                    Inst::ParamRef {
                        idx: 0,
                        kind: LoadKind::F64
                    },
                    Inst::StoreLocal {
                        off: -2,
                        disp: 0,
                        value: 0,
                        kind: stored,
                        volatile: false,
                        nsw: false,
                    },
                    Inst::LoadLocal {
                        off: -2,
                        disp: 0,
                        kind: loaded,
                        volatile: false,
                    },
                ],
                Terminator::Return(2),
                2,
            );
            run_one(&mut f);
            let ret = match f.blocks[0].terminator {
                Terminator::Return(r) => r,
                _ => unreachable!(),
            };
            match want {
                Some(cast) => assert!(
                    ret == 2
                        && matches!(f.insts[2], Inst::FpCast { kind, value: 0 } if kind == cast),
                    "{stored:?} -> {loaded:?}: {:?}",
                    f.insts[2]
                ),
                None if stored == StoreKind::I32 => assert!(
                    ret == 2 && matches!(f.insts[2], Inst::LoadLocal { .. }),
                    "{stored:?} -> {loaded:?}: {:?}",
                    f.insts[2]
                ),
                None => assert_eq!(ret, 0, "{stored:?} -> {loaded:?} reuses the double"),
            }
        }
    }
}

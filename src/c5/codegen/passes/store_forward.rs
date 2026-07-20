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
//! The pass is intra-block: the forwarding table resets at every block
//! boundary, so a forward only fires when the store and the load sit in
//! one straight-line run. Cross-block forwarding needs dominance and
//! per-path availability and is left out.
//!
//! Aliasing is tracked conservatively. Two locations are known distinct
//! only when they share the same address value and their byte ranges do
//! not overlap; any other store clears the entries it cannot prove
//! disjoint. A call, an indexed or local store, a block copy, or an
//! alloca clears the whole table, since each can write through a pointer
//! the pass does not model.
//!
//! Width and signedness. The forwarded value must equal what the load
//! would have produced from memory:
//!   - An `I64` load of an `I64` store reuses the stored value directly.
//!   - A signed sub-width load (`I8`/`I16`/`I32`) of a same-width store
//!     becomes `Extend { value=s, kind }`; `narrow_store` writes the low
//!     bytes and the load sign-extends them, which `Extend` reproduces.
//!   - Unsigned sub-width loads and the floating kinds are not forwarded:
//!     `Inst::Extend` does not zero-extend the unsigned widths (it
//!     assumes a clean upper half), so reusing the stored value there
//!     would be unsound.
//! A load forwards from an earlier load only when the load kinds match
//! exactly, so the extension already applied is the one wanted.
//!
//! Frame slots (`StoreLocal` / `LoadLocal`) are tracked in a second
//! table keyed by slot index, with the same width, volatile, and
//! distance discipline. A slot participates only when nothing but
//! `LoadLocal` / `StoreLocal` can reach it: no `LocalAddr`, no volatile
//! access (`mem2reg::promotable_slots`), and no write through a
//! `FunctionSsa` field or call result slot. Such a slot's address is
//! never a value, so no `Store`, `Mcpy`, or atomic can write it; its
//! entries survive those instructions and die at another `StoreLocal`
//! to the same slot, at a call (a reload after the call is cheaper
//! than keeping the value live across it), or at the block boundary.

use crate::c5::codegen::ssa::mem2reg::promotable_slots;
use crate::c5::ir::{FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId};
use alloc::collections::BTreeSet;
use alloc::vec::Vec;

/// Access width in bytes for a load kind.
fn load_width(kind: LoadKind) -> u8 {
    match kind {
        LoadKind::I64 | LoadKind::F64 => 8,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
    }
}

/// Access width in bytes for a store kind.
fn store_width(kind: StoreKind) -> u8 {
    match kind {
        StoreKind::I64 | StoreKind::F64 => 8,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
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

/// Maximum instruction distance between the store or first load and the
/// consuming load for forwarding to fire. Forwarding removes a reload
/// but keeps the value live across this span; past a bound the extended
/// live range costs more in spills than the reload it removes, so a
/// value cheap to reload (a load from a still-valid address) is better
/// rematerialized. Sized to cover adjacent struct-field and pointer
/// re-reads while leaving the scattered re-reads of an unrolled loop to
/// reload.
const MAX_FORWARD_DISTANCE: u32 = 16;

/// A known-available memory value within the current block.
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

/// A known-available frame-slot value within the current block. Slots
/// are 8-byte cells and every `LoadLocal` / `StoreLocal` accesses a
/// slot from its base, so entries for distinct slots are disjoint and
/// any two accesses of one slot overlap.
#[derive(Clone, Copy)]
struct SlotEntry {
    off: i64,
    width: u8,
    value: ValueId,
    src_idx: u32,
    /// As [`Entry::load_kind`].
    load_kind: Option<LoadKind>,
}

/// Slots whose store -> load pairs may forward: reachable only through
/// `LoadLocal` / `StoreLocal`, so every write is visible in the SSA.
/// Starts from `mem2reg::promotable_slots` (no `LocalAddr`, no volatile
/// access, no alloca-arena slot) and removes the slots the emit writes
/// through `FunctionSsa` fields or call metadata rather than an
/// instruction. A function with a runtime-growing frame is skipped
/// entirely, as in mem2reg.
fn forwardable_slots(func: &FunctionSsa) -> BTreeSet<i64> {
    if func
        .insts
        .iter()
        .any(|i| matches!(i, Inst::AllocaInit(s) if *s != 0))
    {
        return BTreeSet::new();
    }
    let mut slots = promotable_slots(func);
    slots.remove(&func.indirect_result_slot);
    for s in &func.param_local_slots {
        slots.remove(s);
    }
    for inst in &func.insts {
        match inst {
            Inst::Call { ret_slot_local, .. }
            | Inst::CallIndirect { ret_slot_local, .. }
            | Inst::CallExt { ret_slot_local, .. }
                if *ret_slot_local != 0 =>
            {
                slots.remove(ret_slot_local);
            }
            _ => {}
        }
    }
    slots
}

/// Byte ranges `[a, a+aw)` and `[b, b+bw)` overlap.
fn overlaps(a: i32, aw: u8, b: i32, bw: u8) -> bool {
    let a_end = a as i64 + aw as i64;
    let b_end = b as i64 + bw as i64;
    (a as i64) < b_end && (b as i64) < a_end
}

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
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

    for block in &func.blocks {
        let mut table: Vec<Entry> = Vec::new();
        let mut slot_table: Vec<SlotEntry> = Vec::new();
        for idx in block.inst_range.clone() {
            let i = idx as usize;
            if i >= func.insts.len() {
                break;
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
                    let hit = hit
                        .filter(|e| (i as u32).saturating_sub(e.src_idx) <= MAX_FORWARD_DISTANCE);
                    if let Some(e) = hit {
                        match e.load_kind {
                            None => {
                                // Store-origin: reuse the raw stored value.
                                match kind {
                                    LoadKind::I64 => {
                                        redirect[i] = Some(e.value);
                                        any = true;
                                    }
                                    LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => {
                                        rewrites.push((
                                            i,
                                            Inst::Extend {
                                                value: e.value,
                                                kind,
                                            },
                                        ));
                                    }
                                    // Unsigned sub-width and floating: not
                                    // forwarded (see the module note).
                                    _ => {}
                                }
                            }
                            Some(k) if k == kind => {
                                // Load-origin with the same kind: the
                                // extension already matches.
                                redirect[i] = Some(e.value);
                                any = true;
                            }
                            Some(_) => {}
                        }
                    }
                    // Record this load so a later identical one forwards.
                    // The value a future load should reuse is the stored
                    // value when this load redirected to it, otherwise
                    // this load's own id.
                    if !table
                        .iter()
                        .any(|e| e.addr == addr && e.disp == disp && e.width == w)
                    {
                        let value = redirect[i].unwrap_or(i as ValueId);
                        table.push(Entry {
                            addr,
                            disp,
                            width: w,
                            value,
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
                } => {
                    let addr = *addr;
                    let disp = *disp;
                    let value = *value;
                    let kind = *kind;
                    let volatile = *volatile;
                    let w = store_width(kind);
                    // Drop every entry not provably disjoint from the
                    // written range.
                    table.retain(|e| e.addr == addr && !overlaps(e.disp, e.width, disp, w));
                    // A volatile store invalidates like any store but
                    // seeds no forward: a later load of the location
                    // must read memory (C99 6.7.3p6).
                    if is_int_store(kind) && !volatile {
                        table.push(Entry {
                            addr,
                            disp,
                            width: w,
                            value,
                            src_idx: idx,
                            load_kind: None,
                        });
                    }
                }
                // A volatile slot access is never tracked; its slot is
                // outside `forwardable_slots`. A volatile load reads
                // only, so existing entries stay valid.
                Inst::LoadLocal { volatile: true, .. } => {}
                Inst::LoadLocal {
                    off,
                    kind,
                    volatile: false,
                } => {
                    let off = *off;
                    let kind = *kind;
                    if !slots.contains(&off) {
                        continue;
                    }
                    let w = load_width(kind);
                    let hit = slot_table
                        .iter()
                        .find(|e| e.off == off && e.width == w)
                        .copied()
                        .filter(|e| (i as u32).saturating_sub(e.src_idx) <= MAX_FORWARD_DISTANCE);
                    if let Some(e) = hit {
                        match e.load_kind {
                            None => match kind {
                                LoadKind::I64 => {
                                    redirect[i] = Some(e.value);
                                    any = true;
                                }
                                LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => {
                                    rewrites.push((
                                        i,
                                        Inst::Extend {
                                            value: e.value,
                                            kind,
                                        },
                                    ));
                                }
                                // Unsigned sub-width and floating: not
                                // forwarded (see the module note).
                                _ => {}
                            },
                            Some(k) if k == kind => {
                                redirect[i] = Some(e.value);
                                any = true;
                            }
                            Some(_) => {}
                        }
                    }
                    if !slot_table.iter().any(|e| e.off == off && e.width == w) {
                        let value = redirect[i].unwrap_or(i as ValueId);
                        slot_table.push(SlotEntry {
                            off,
                            width: w,
                            value,
                            src_idx: idx,
                            load_kind: Some(kind),
                        });
                    }
                }
                Inst::StoreLocal {
                    off,
                    value,
                    kind,
                    volatile,
                } => {
                    let off = *off;
                    let value = *value;
                    let kind = *kind;
                    let volatile = *volatile;
                    // A frame write can alias a tracked pointer entry
                    // (the pointer can be a `LocalAddr` of this slot),
                    // so the pointer table clears as before.
                    table.clear();
                    slot_table.retain(|e| e.off != off);
                    if slots.contains(&off) && is_int_store(kind) && !volatile {
                        slot_table.push(SlotEntry {
                            off,
                            width: store_width(kind),
                            value,
                            src_idx: idx,
                            load_kind: None,
                        });
                    }
                }
                // Reads and pure computes the pass does not model: no
                // clobber, no entry.
                Inst::LoadIndexed { .. }
                | Inst::Imm(_)
                | Inst::ImmData(_)
                | Inst::ImmCode(_)
                | Inst::ImmExtCode(_)
                | Inst::BlockAddr(_)
                | Inst::LocalAddr(_)
                | Inst::TlsAddr(_)
                | Inst::Binop { .. }
                | Inst::BinopI { .. }
                | Inst::Fneg(_)
                | Inst::Fma { .. }
                | Inst::Extend { .. }
                | Inst::FpCast { .. }
                | Inst::ParamRef { .. }
                | Inst::Phi { .. } => {}
                // Anything that can write through a pointer the pass
                // does not track clears the pointer table. Slot entries
                // survive: a forwardable slot's address is never a
                // value, so none of these can write it.
                Inst::StoreIndexed { .. }
                | Inst::Mcpy { .. }
                | Inst::AtomicRmw { .. }
                | Inst::AtomicCas { .. }
                | Inst::AllocaInit(_) => {
                    table.clear();
                }
                // A call cannot write a forwardable slot either, but
                // forwarding across one would hold the value in a
                // register (or a spill slot) over the call, which costs
                // more than the frame reload it removes. Both tables
                // clear.
                Inst::Call { .. }
                | Inst::CallIndirect { .. }
                | Inst::CallExt { .. }
                | Inst::Intrinsic { .. }
                | Inst::InlineAsm { .. }
                | Inst::TailExt(_) => {
                    table.clear();
                    slot_table.clear();
                }
            }
        }
    }
    for (idx, inst) in rewrites {
        func.insts[idx] = inst;
    }
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
            Terminator::JumpTable { idx, .. } => {
                *idx = resolve(&redirect, *idx);
            }
            Terminator::Return(v) if *v != NO_VALUE => {
                *v = resolve(&redirect, *v);
            }
            _ => {}
        }
    }
}

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
    use super::run_one;
    use crate::c5::ir::{Block, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
    use alloc::vec::Vec;

    fn fresh(insts: Vec<Inst>, term: Terminator, exit_acc: u32) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            n_params: 2,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
            inst_src: alloc::vec![(0, 0); n],
            f32_values: alloc::vec![false; n],
            param_fp_mask: 0,
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            ret_type_tag: 0,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            has_returns_twice_call: false,
            did_unroll: false,
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
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
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
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                    volatile: false,
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
                    kind: LoadKind::I32
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
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::U8,
                    volatile: false,
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
                },
                Inst::Mcpy {
                    dst: 0,
                    src: 1,
                    size: 8
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
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
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
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
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: true,
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: true,
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
                    off: -1,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                },
                Inst::LoadLocal {
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
                    off: -1,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                },
                Inst::Call {
                    target_pc: 0,
                    args: Vec::new(),
                    fixed_args: 0,
                    fp_return: false,
                    fp_arg_mask: 0,
                    arg_aggs: Vec::new(),
                    ret_agg: None,
                    ret_slot_local: 0,
                },
                Inst::LoadLocal {
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
                    off: -1,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                },
                Inst::Store {
                    addr: 1,
                    disp: 0,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                },
                Inst::LoadLocal {
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
                    off: -1,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: true,
                },
                Inst::LoadLocal {
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
                    off: -1,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                },
                Inst::StoreLocal {
                    off: -1,
                    value: 1,
                    kind: StoreKind::I64,
                    volatile: false,
                },
                Inst::LoadLocal {
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
                    off: -1,
                    value: 0,
                    kind: StoreKind::I32,
                    volatile: false,
                },
                Inst::LoadLocal {
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
                    kind: LoadKind::I32
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
                    off: -2,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                },
                Inst::Call {
                    target_pc: 0,
                    args: Vec::new(),
                    fixed_args: 0,
                    fp_return: false,
                    fp_arg_mask: 0,
                    arg_aggs: Vec::new(),
                    ret_agg: Some(0),
                    ret_slot_local: -2,
                },
                Inst::LoadLocal {
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
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
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
}

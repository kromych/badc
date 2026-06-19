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

use super::super::ir::{FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId};
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

    for block in &func.blocks {
        let mut table: Vec<Entry> = Vec::new();
        for idx in block.inst_range.clone() {
            let i = idx as usize;
            if i >= func.insts.len() {
                break;
            }
            match &func.insts[i] {
                Inst::Load { addr, disp, kind } => {
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
                } => {
                    let addr = *addr;
                    let disp = *disp;
                    let value = *value;
                    let kind = *kind;
                    let w = store_width(kind);
                    // Drop every entry not provably disjoint from the
                    // written range.
                    table.retain(|e| e.addr == addr && !overlaps(e.disp, e.width, disp, w));
                    if is_int_store(kind) {
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
                // Reads and pure computes the pass does not model: no
                // clobber, no entry.
                Inst::LoadLocal { .. }
                | Inst::LoadIndexed { .. }
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
                // Anything that can write through a pointer the pass does
                // not track clears the whole table.
                Inst::StoreLocal { .. }
                | Inst::StoreIndexed { .. }
                | Inst::Mcpy { .. }
                | Inst::AtomicRmw { .. }
                | Inst::AtomicCas { .. }
                | Inst::AllocaInit(_)
                | Inst::Call { .. }
                | Inst::CallIndirect { .. }
                | Inst::CallExt { .. }
                | Inst::Intrinsic { .. }
                | Inst::TailExt(_) => {
                    table.clear();
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
    use super::super::super::ir::{Block, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
    use super::run_one;
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
            inst_src: alloc::vec![(0, 0); n],
            f32_values: alloc::vec![false; n],
            param_fp_mask: 0,
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
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
                    kind: StoreKind::I64
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64
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
                    kind: StoreKind::I32
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32
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
                    kind: StoreKind::I8
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::U8
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
                    kind: LoadKind::U8
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
                    kind: StoreKind::I64
                },
                Inst::Mcpy {
                    dst: 0,
                    src: 1,
                    size: 8
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64
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
                    kind: LoadKind::I64
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64
                },
                Inst::Binop {
                    op: super::super::super::ir::BinOp::Add,
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

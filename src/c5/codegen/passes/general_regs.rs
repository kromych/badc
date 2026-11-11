//! `-mno-sse` / `-mgeneral-regs-only` withhold the floating-point and
//! SIMD registers. A `float` or `double` loaded only to be stored moves
//! through a general register as an integer of its width; any other
//! floating-point value a function computes is refused.

use crate::c5::codegen::ssa::reg_alloc::{compute_use_counts, produces_fp_result};
use crate::c5::ir::{FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, ValueId};
use alloc::vec::Vec;

/// The store kind that copies a floating-point load, and the integer
/// kinds of the load and the store.
fn copy_kinds(kind: LoadKind) -> Option<(StoreKind, LoadKind, StoreKind)> {
    match kind {
        LoadKind::F64 => Some((StoreKind::F64, LoadKind::I64, StoreKind::I64)),
        LoadKind::F32 => Some((StoreKind::F32, LoadKind::U32, StoreKind::I32)),
        _ => None,
    }
}

fn load_kind(inst: &mut Inst) -> Option<&mut LoadKind> {
    match inst {
        Inst::Load { kind, .. } | Inst::LoadLocal { kind, .. } | Inst::LoadIndexed { kind, .. } => {
            Some(kind)
        }
        _ => None,
    }
}

fn store_kind(inst: &mut Inst) -> Option<&mut StoreKind> {
    match inst {
        Inst::Store { kind, .. }
        | Inst::StoreLocal { kind, .. }
        | Inst::StoreIndexed { kind, .. } => Some(kind),
        _ => None,
    }
}

/// The value a store writes, its kind, and whether `v` forms its address.
fn stored(inst: &Inst, v: ValueId) -> Option<(ValueId, StoreKind, bool)> {
    match *inst {
        Inst::Store {
            addr, value, kind, ..
        } => Some((value, kind, addr == v)),
        Inst::StoreLocal { value, kind, .. } => Some((value, kind, false)),
        Inst::StoreIndexed {
            base,
            index,
            value,
            kind,
            ..
        } => Some((value, kind, base == v || index == v)),
        _ => None,
    }
}

/// Move `func`'s floating-point copies through general registers; an
/// error when a floating-point value is left that the function computes.
pub(crate) fn run(func: &mut FunctionSsa) -> Result<(), ()> {
    let uses = compute_use_counts(func);
    // Per load: the store kind copying it, while every read is such a store.
    let mut copy: Vec<Option<StoreKind>> = (func.insts.iter_mut())
        .map(|inst| load_kind(inst).and_then(|k| copy_kinds(*k)).map(|c| c.0))
        .collect();
    for (j, inst) in func.insts.iter().enumerate() {
        inst.for_each_operand(|v| {
            if let Some(slot) = copy.get_mut(v as usize)
                && let Some(want) = *slot
                && !matches!(stored(inst, v), Some((value, kind, false))
                    if value == v && kind == want && uses[j] == 0)
            {
                *slot = None;
            }
        });
    }
    for block in &func.blocks {
        block.terminator.for_each_operand(|v| {
            if let Some(slot) = copy.get_mut(v as usize) {
                *slot = None;
            }
        });
    }
    for j in 0..func.insts.len() {
        let src = stored(&func.insts[j], NO_VALUE).map(|(value, ..)| value as usize);
        let inst = &mut func.insts[j];
        if copy[j].is_some()
            && let Some(k) = load_kind(inst)
            && let Some((_, int, _)) = copy_kinds(*k)
        {
            *k = int;
        } else if let Some(k) = store_kind(inst)
            && src.is_some_and(|v| copy.get(v).is_some_and(Option::is_some))
        {
            *k = if *k == StoreKind::F64 {
                StoreKind::I64
            } else {
                StoreKind::I32
            };
        }
    }
    let live = |i: usize| uses[i] > 0 || !func.insts[i].is_pure();
    if (0..func.insts.len()).any(|i| produces_fp_result(&func.insts[i]) && live(i)) {
        return Err(());
    }
    Ok(())
}

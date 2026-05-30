//! C5 cdecl ABI audit pass.
//!
//! Classifies each `FunctionSsa` by whether its body still
//! depends on the c5 cdecl 16-byte-cell parameter-slot layout
//! (`PrologueKind::C5Cdecl`) or whether it could lower through
//! the host ABI without ever materialising a slot
//! (`PrologueKind::Native`). The audit runs after `ssa_mem2reg`
//! so its view of `LoadLocal` consumer counts reflects the
//! post-promotion IR.
//!
//! The pass is data-only: it does not modify the IR or fail on
//! any classification. Each per-function report is printed when
//! the `BADC_C5_CDECL_AUDIT` environment variable is set and
//! the `std` feature is on; the suite stays green either way.
//! The downstream prologue / call-marshal switches use the
//! classification once the per-arch emit consumes it.

#![cfg_attr(not(feature = "std"), allow(dead_code))]

use alloc::collections::BTreeSet;

use super::super::ir::{FunctionSsa, Inst, ValueId};
use super::ssa_alloc::for_each_operand;

/// What shape of prologue / arg marshal the function still
/// requires. A `Native` callee can use the host ABI directly:
/// no per-parameter 16-byte cell, no `str x_i, [sp, -16]!` loop,
/// no `va_arg` cursor walk. A `C5Cdecl` callee keeps the
/// existing layout.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum PrologueKind {
    Native,
    C5Cdecl,
}

/// Per-function report. The `reason` field carries the dominant
/// classification driver so a future regression at the source
/// site is easy to localise.
#[derive(Debug, Clone)]
pub(crate) struct C5CdeclAudit {
    pub kind: PrologueKind,
    pub address_taken_param_slots: BTreeSet<i64>,
    pub unredirected_load_param_slots: BTreeSet<i64>,
    pub reason: &'static str,
}

/// Classify `func` against the c5 cdecl layout. Reads only the
/// IR; no allocator state required.
pub(crate) fn audit_function(func: &FunctionSsa) -> C5CdeclAudit {
    // Count operand uses so a `LoadLocal` that mem2reg redirected
    // (every consumer now points at the reaching value) and an
    // emit-stage dead-pure check would drop is not counted as a
    // live slot reference.
    let mut use_counts: alloc::vec::Vec<u32> = alloc::vec![0; func.insts.len()];
    for inst in &func.insts {
        for_each_operand(inst, |v: ValueId| {
            if (v as usize) < use_counts.len() {
                use_counts[v as usize] = use_counts[v as usize].saturating_add(1);
            }
        });
    }
    for block in &func.blocks {
        use super::super::ir::Terminator;
        let cond = match block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => Some(cond),
            Terminator::Return(v) => Some(v),
            _ => None,
        };
        if let Some(c) = cond
            && (c as usize) < use_counts.len()
        {
            use_counts[c as usize] = use_counts[c as usize].saturating_add(1);
        }
    }

    let mut address_taken: BTreeSet<i64> = BTreeSet::new();
    let mut unredirected: BTreeSet<i64> = BTreeSet::new();
    for (idx, inst) in func.insts.iter().enumerate() {
        match inst {
            Inst::LocalAddr(off) if *off >= 2 => {
                address_taken.insert(*off);
            }
            Inst::LoadLocal { off, .. } if *off >= 2 && use_counts[idx] > 0 => {
                unredirected.insert(*off);
            }
            Inst::StoreLocal { off, .. } if *off >= 2 => {
                // A surviving StoreLocal at a parameter slot is
                // also a memory write to the c5 cdecl cell.
                // mem2reg neutralises promoted stores to
                // `Inst::Imm(0)`, so any StoreLocal that remains
                // genuinely writes the slot.
                unredirected.insert(*off);
            }
            _ => {}
        }
    }

    let (kind, reason) = if func.is_variadic {
        (PrologueKind::C5Cdecl, "is_variadic")
    } else if !address_taken.is_empty() {
        (PrologueKind::C5Cdecl, "address_taken_param")
    } else if !unredirected.is_empty() {
        (PrologueKind::C5Cdecl, "unredirected_param_slot_access")
    } else {
        (PrologueKind::Native, "native_eligible")
    };

    C5CdeclAudit {
        kind,
        address_taken_param_slots: address_taken,
        unredirected_load_param_slots: unredirected,
        reason,
    }
}

/// Emit one audit line per function to stderr when the env var
/// is set. No-op when the feature is off or the variable is not
/// set so a default release build pays no per-function cost.
#[cfg(feature = "std")]
pub(crate) fn maybe_dump_audit(funcs: &[FunctionSsa]) {
    if std::env::var("BADC_C5_CDECL_AUDIT").is_err() {
        return;
    }
    let mut total = 0usize;
    let mut native = 0usize;
    let mut c5cdecl_variadic = 0usize;
    let mut c5cdecl_address_taken = 0usize;
    let mut c5cdecl_unredirected = 0usize;
    for f in funcs {
        let audit = audit_function(f);
        total += 1;
        match (audit.kind, audit.reason) {
            (PrologueKind::Native, _) => native += 1,
            (PrologueKind::C5Cdecl, "is_variadic") => c5cdecl_variadic += 1,
            (PrologueKind::C5Cdecl, "address_taken_param") => c5cdecl_address_taken += 1,
            (PrologueKind::C5Cdecl, _) => c5cdecl_unredirected += 1,
        }
        let name = if f.name.is_empty() {
            alloc::format!("fn_{}", f.ent_pc)
        } else {
            f.name.clone()
        };
        eprintln!(
            "c5-cdecl-audit: fn={:<32} variadic={:<5} n_params={} kind={:?} reason={:<32} address_taken={:?} unredirected={:?}",
            name,
            f.is_variadic,
            f.n_params,
            audit.kind,
            audit.reason,
            audit.address_taken_param_slots,
            audit.unredirected_load_param_slots,
        );
    }
    eprintln!(
        "c5-cdecl-audit-summary: total={total} native={native} c5cdecl_variadic={c5cdecl_variadic} c5cdecl_address_taken={c5cdecl_address_taken} c5cdecl_unredirected={c5cdecl_unredirected}",
    );
}

#[cfg(not(feature = "std"))]
pub(crate) fn maybe_dump_audit(_funcs: &[FunctionSsa]) {}

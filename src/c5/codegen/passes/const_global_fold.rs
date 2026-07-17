//! Fold a null comparison of a const global's relocated pointer field.
//!
//! A `const`-element file-scope array whose initializer stores the address
//! of another object carries a data relocation at that member: the member
//! holds a runtime address, which is never null. Guards such as qemu's
//! `device_class_set_props` read such a member and call an
//! `__attribute__((error))` build-time-unreachable helper when it is null,
//! expecting the optimizer to prove it non-null and drop the call.
//!
//! This pass performs that proof: `load(member) == 0` becomes `0` and
//! `load(member) != 0` becomes `1` when `member` is a relocated pointer
//! inside a const, defined, initialized array, so `constfold_branch` then
//! deletes the unreachable arm. It leaves the load in place and rewrites
//! only the comparison, so any other use of the loaded value is unaffected.
//! A `const` array's elements cannot be modified (C99 6.7.3), so the
//! relocated address the initializer stored is what the member holds.

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind};
use crate::c5::program::Program;
use crate::c5::token::Token;

pub(crate) fn run(funcs: &mut [FunctionSsa], program: &Program) {
    // [lo, hi) byte ranges of const-element, defined, initialized
    // file-scope arrays in the data segment.
    let const_intervals: Vec<(i64, i64)> = program
        .symbols
        .iter()
        .filter(|s| {
            s.class == Token::Glo as i64
                && s.storage_is_const
                && s.has_initializer
                && s.defined_here
                && s.reserved_data_bytes > 0
        })
        .map(|s| (s.val, s.val + s.reserved_data_bytes))
        .collect();
    if const_intervals.is_empty() {
        return;
    }
    // Data-segment byte offsets that hold a relocated pointer -- a non-null
    // runtime address -- inside one of those arrays.
    let mut const_reloc_offsets: BTreeSet<i64> = BTreeSet::new();
    for r in &program.data_relocs {
        let off = r.data_offset as i64;
        if const_intervals
            .iter()
            .any(|&(lo, hi)| off >= lo && off < hi)
        {
            const_reloc_offsets.insert(off);
        }
    }
    if const_reloc_offsets.is_empty() {
        return;
    }

    for f in funcs.iter_mut() {
        // A value's id is its instruction index, so `insts[id]` is the
        // defining instruction.
        for i in 0..f.insts.len() {
            let (op, lhs) = match f.insts[i] {
                Inst::BinopI {
                    op: op @ (BinOp::Eq | BinOp::Ne),
                    lhs,
                    rhs_imm: 0,
                } => (op, lhs),
                _ => continue,
            };
            let (addr, disp) = match f.insts.get(lhs as usize) {
                Some(Inst::Load {
                    addr,
                    disp,
                    kind: LoadKind::I64,
                    volatile: false,
                }) => (*addr, *disp),
                _ => continue,
            };
            // The member address is `ImmData(base)` directly, or -- before
            // index_fold folds the member offset into the load's `disp` --
            // `BinopI{add, ImmData(base), k}`.
            let base = match f.insts.get(addr as usize) {
                Some(Inst::ImmData(base)) => *base,
                Some(Inst::BinopI {
                    op: BinOp::Add,
                    lhs,
                    rhs_imm,
                }) => match f.insts.get(*lhs as usize) {
                    Some(Inst::ImmData(base)) => *base + *rhs_imm,
                    _ => continue,
                },
                _ => continue,
            };
            if !const_reloc_offsets.contains(&(base + disp as i64)) {
                continue;
            }
            // The member holds a non-null address; the comparison is a
            // compile-time constant.
            f.insts[i] = Inst::Imm(i64::from(op == BinOp::Ne));
        }
    }
}

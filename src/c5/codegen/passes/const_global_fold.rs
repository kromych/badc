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

use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, ValueId};
use crate::c5::program::Program;
use crate::c5::token::Token;

/// Const-data view for folding loads of `const` objects: the `[lo, hi)`
/// byte ranges of const, defined, initialized file-scope arrays whose
/// image already holds their value, the data-segment offsets a
/// relocation patches (unknown until link, so never folded), and the
/// data image itself.
pub(crate) struct ConstData<'a> {
    intervals: Vec<(i64, i64)>,
    reloc_offsets: Vec<i64>,
    data: &'a [u8],
}

impl<'a> ConstData<'a> {
    pub(crate) fn build(program: &'a Program) -> Self {
        let intervals: Vec<(i64, i64)> = program
            .symbols
            .iter()
            .filter(|s| {
                s.class == Token::Glo as i64
                    && s.storage_is_const
                    && s.has_initializer
                    && s.defined_here
                    && s.reserved_data_bytes > 0
                    // A thread-local object's bytes live in `tls_data`;
                    // `val` would index the wrong image here.
                    && !s.is_thread_local
                    // An object filled by stores at its declaration point
                    // (a `&&label` element) leaves the image zeroed.
                    && !s.runtime_initialized
            })
            .map(|s| (s.val, s.val + s.reserved_data_bytes))
            .collect();
        // Every form of data relocation: a link-time address in this
        // unit's data, an extern symbol's address, and a function
        // address. The image bytes under any of them are a placeholder.
        let mut reloc_offsets: Vec<i64> = program
            .data_relocs
            .iter()
            .map(|r| r.data_offset as i64)
            .chain(
                program
                    .extern_data_relocs
                    .iter()
                    .map(|r| r.data_offset as i64),
            )
            .chain(program.code_relocs.iter().map(|r| r.data_offset as i64))
            .collect();
        reloc_offsets.sort_unstable();
        ConstData {
            intervals,
            reloc_offsets,
            data: &program.data,
        }
    }

    /// The image bytes of `[off, off + width)` when the whole read sits
    /// inside one const interval and overlaps no relocation slot.
    fn read(&self, off: i64, width: i64) -> Option<&[u8]> {
        if !self
            .intervals
            .iter()
            .any(|&(lo, hi)| off >= lo && off + width <= hi)
        {
            return None;
        }
        // A relocation patches 8 bytes at its offset with a link-time
        // address; any overlap makes the read's value unknown here.
        let i = self.reloc_offsets.partition_point(|&r| r + 8 <= off);
        if self.reloc_offsets.get(i).is_some_and(|&r| r < off + width) {
            return None;
        }
        self.data.get(off as usize..(off + width) as usize)
    }
}

/// Resolve `v` to a data-segment offset when it is an `ImmData` plus a
/// folded constant displacement chain.
fn data_addr(func: &FunctionSsa, mut v: ValueId, mut off: i64) -> Option<i64> {
    for _ in 0..8 {
        match func.insts.get(v as usize)? {
            Inst::ImmData(base) => return Some(base.wrapping_add(off)),
            Inst::BinopI {
                op: BinOp::Add,
                lhs,
                rhs_imm,
            } => {
                off = off.wrapping_add(*rhs_imm);
                v = *lhs;
            }
            Inst::BinopI {
                op: BinOp::Sub,
                lhs,
                rhs_imm,
            } => {
                off = off.wrapping_sub(*rhs_imm);
                v = *lhs;
            }
            _ => return None,
        }
    }
    None
}

/// Fold non-volatile integer loads from const, initialized data into the
/// initializer's value (C99 6.7.3: a const object's stored value cannot
/// be modified, so the image bytes are the object's value for the whole
/// execution). Returns true when any load folded. Runs inside the branch
/// fold's fixed point so a load whose address becomes constant only
/// after a phi collapses still folds; all emission targets are
/// little-endian, so the image decodes with `from_le_bytes`.
pub(crate) fn fold_loads(func: &mut FunctionSsa, cd: &ConstData<'_>) -> bool {
    let mut changed = false;
    for i in 0..func.insts.len() {
        let Inst::Load {
            addr,
            disp,
            kind,
            volatile: false,
        } = func.insts[i]
        else {
            continue;
        };
        let width = match kind {
            LoadKind::I8 | LoadKind::U8 => 1i64,
            LoadKind::I16 | LoadKind::U16 => 2,
            LoadKind::I32 | LoadKind::U32 => 4,
            LoadKind::I64 => 8,
            // The FP kinds keep their register class through the load;
            // an integer immediate would misclassify them.
            LoadKind::F32 | LoadKind::F64 => continue,
        };
        let Some(off) = data_addr(func, addr, disp as i64) else {
            continue;
        };
        let Some(bytes) = cd.read(off, width) else {
            continue;
        };
        let mut raw = [0u8; 8];
        raw[..width as usize].copy_from_slice(bytes);
        let u = u64::from_le_bytes(raw);
        let value = match kind {
            LoadKind::I8 => u as u8 as i8 as i64,
            LoadKind::I16 => u as u16 as i16 as i64,
            LoadKind::I32 => u as u32 as i32 as i64,
            _ => u as i64,
        };
        func.insts[i] = Inst::Imm(value);
        changed = true;
    }
    changed
}

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

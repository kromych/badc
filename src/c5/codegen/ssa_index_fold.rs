//! Fold a scaled-index address computation into the load or store that
//! consumes it. Array subscript `a[i]` lowers to
//!
//! ```text
//!   s = BinopI(Shl, i, log2(width))     # i * element_size
//!   p = Binop(Add, base, s)             # base + i * element_size
//!   v = Load { addr=p, kind }           # (or Store { addr=p, .. })
//! ```
//!
//! Both targets can address `base + index * scale` directly -- x86-64
//! through a SIB byte, AArch64 through a register-offset load/store with
//! an `lsl` amount -- so the shift and add collapse into the access:
//!
//! ```text
//!   v = LoadIndexed { base, index=i, scale=width, kind }
//! ```
//!
//! The fold fires when the shift amount matches the access width (the
//! per-arch emit requires `scale == width`) and the shift feeds only its
//! address. A shared `base + i*scale` (one address feeding both the load
//! and the store of a swapped element) folds into every use, provided
//! every use is a load or store of the matching width, so the shared
//! shift and add still drop out; an address that also feeds non-access
//! uses is left alone.
//!
//! The same pass folds a constant pointer offset (a struct field offset)
//! into the load/store displacement: a single-use `BinopI(Add, base, c)`
//! address with an aligned, in-range `c` becomes `Load { addr=base,
//! disp=c }`.

use alloc::vec::Vec;

use super::super::ir::{
    BinOp, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId,
};

/// Access width in bytes for a load kind, or `None` for the floating
/// kinds (the indexed emit handles integers only).
fn load_width(kind: LoadKind) -> Option<u8> {
    match kind {
        LoadKind::I64 => Some(8),
        LoadKind::I32 | LoadKind::U32 => Some(4),
        LoadKind::I16 | LoadKind::U16 => Some(2),
        LoadKind::I8 | LoadKind::U8 => Some(1),
        LoadKind::F32 | LoadKind::F64 => None,
    }
}

/// Access width in bytes for a store kind, or `None` for the floating
/// kinds.
fn store_width(kind: StoreKind) -> Option<u8> {
    match kind {
        StoreKind::I64 => Some(8),
        StoreKind::I32 => Some(4),
        StoreKind::I16 => Some(2),
        StoreKind::I8 => Some(1),
        StoreKind::F32 | StoreKind::F64 => None,
    }
}

/// Count uses of every value across instructions, terminators, and
/// block exit accumulators.
fn use_counts(func: &FunctionSsa) -> Vec<u32> {
    let mut counts = alloc::vec![0u32; func.insts.len()];
    let bump = |v: ValueId, counts: &mut [u32]| {
        if let Some(slot) = counts.get_mut(v as usize) {
            *slot += 1;
        }
    };
    for inst in &func.insts {
        super::ssa_alloc::for_each_operand(inst, |v| bump(v, &mut counts));
    }
    for block in &func.blocks {
        match block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => bump(cond, &mut counts),
            Terminator::Return(v) => bump(v, &mut counts),
            Terminator::Jmp(_) | Terminator::TailExt(_) | Terminator::FallThrough(_) => {}
        }
        if block.exit_acc != NO_VALUE {
            bump(block.exit_acc, &mut counts);
        }
    }
    counts
}

/// Scaled-index addresses whose every use is a same-width load or store,
/// keyed by the address value id and mapping to `(base, index, scale)`.
/// A shared `base + index*scale` (one address feeding both the load and
/// the store of a swapped element) folds into every access so the shared
/// shift and add drop out, not only the single-use case.
fn foldable_scaled_addresses(
    func: &FunctionSsa,
    counts: &[u32],
) -> alloc::collections::BTreeMap<ValueId, (ValueId, ValueId, u8)> {
    let mut cand: alloc::collections::BTreeMap<ValueId, (ValueId, ValueId, u8)> =
        alloc::collections::BTreeMap::new();
    for (p, inst) in func.insts.iter().enumerate() {
        let Inst::Binop {
            op: BinOp::Add,
            lhs,
            rhs,
        } = inst
        else {
            continue;
        };
        // The shift may be either operand of the commutative add; it must
        // feed only this address so it dies once the address is folded.
        for (base, scaled) in [(*lhs, *rhs), (*rhs, *lhs)] {
            if counts.get(scaled as usize).copied().unwrap_or(0) != 1 {
                continue;
            }
            let Some(Inst::BinopI {
                op: BinOp::Shl,
                lhs: index,
                rhs_imm,
            }) = func.insts.get(scaled as usize)
            else {
                continue;
            };
            if *rhs_imm >= 1 && *rhs_imm <= 3 {
                cand.insert(p as ValueId, (base, *index, 1u8 << *rhs_imm));
                break;
            }
        }
    }
    // Count, per candidate address, the uses that are a load or store of
    // the matching width; keep only addresses whose every use qualifies.
    let mut valid: alloc::collections::BTreeMap<ValueId, u32> = alloc::collections::BTreeMap::new();
    for inst in &func.insts {
        let (addr, width) = match inst {
            Inst::Load {
                addr,
                disp: 0,
                kind,
            } => (*addr, load_width(*kind)),
            Inst::Store {
                addr,
                disp: 0,
                kind,
                ..
            } => (*addr, store_width(*kind)),
            _ => continue,
        };
        if let Some(&(_, _, scale)) = cand.get(&addr)
            && width == Some(scale)
        {
            *valid.entry(addr).or_insert(0) += 1;
        }
    }
    cand.into_iter()
        .filter(|(p, _)| {
            let total = counts.get(*p as usize).copied().unwrap_or(0);
            total >= 1 && valid.get(p).copied().unwrap_or(0) == total
        })
        .collect()
}

/// When `addr` is a single-use `BinopI(Add, base, c)` whose constant `c`
/// is a non-negative byte offset aligned to `width` and within the
/// scaled immediate-offset range of both targets, return `(base, c)`.
/// Aligning to the access width keeps the AArch64 `ldr` / `str`
/// immediate encoding (which scales by the width) valid; struct field
/// offsets for a width-`width` field are naturally width-aligned, while
/// a packed field at an unaligned offset is left for the plain add path.
fn displaced_address(
    func: &FunctionSsa,
    counts: &[u32],
    addr: ValueId,
    width: u8,
) -> Option<(ValueId, i32)> {
    if counts.get(addr as usize).copied().unwrap_or(0) != 1 {
        return None;
    }
    let Inst::BinopI {
        op: BinOp::Add,
        lhs,
        rhs_imm,
    } = func.insts.get(addr as usize)?
    else {
        return None;
    };
    let c = *rhs_imm;
    if c <= 0 || c % (width as i64) != 0 || c >= (width as i64) * 4096 {
        return None;
    }
    Some((*lhs, c as i32))
}

/// Rewrite recognised scaled-index loads and stores in place.
pub(super) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        let counts = use_counts(func);
        let scaled = foldable_scaled_addresses(func, &counts);
        let n = func.insts.len();
        let mut rewrites: Vec<(usize, Inst)> = Vec::new();
        for idx in 0..n {
            match &func.insts[idx] {
                // A displacement already present means the address was
                // folded once; leave it rather than compose for now.
                Inst::Load {
                    addr,
                    disp: 0,
                    kind,
                } => {
                    if let Some(width) = load_width(*kind) {
                        if let Some(&(base, index, scale)) = scaled.get(addr) {
                            debug_assert_eq!(scale, width);
                            rewrites.push((
                                idx,
                                Inst::LoadIndexed {
                                    base,
                                    index,
                                    scale,
                                    kind: *kind,
                                },
                            ));
                        } else if let Some((base, disp)) =
                            displaced_address(func, &counts, *addr, width)
                        {
                            rewrites.push((
                                idx,
                                Inst::Load {
                                    addr: base,
                                    disp,
                                    kind: *kind,
                                },
                            ));
                        }
                    }
                }
                Inst::Store {
                    addr,
                    disp: 0,
                    value,
                    kind,
                } => {
                    if let Some(width) = store_width(*kind) {
                        if let Some(&(base, index, scale)) = scaled.get(addr) {
                            debug_assert_eq!(scale, width);
                            rewrites.push((
                                idx,
                                Inst::StoreIndexed {
                                    base,
                                    index,
                                    scale,
                                    value: *value,
                                    kind: *kind,
                                },
                            ));
                        } else if let Some((base, disp)) =
                            displaced_address(func, &counts, *addr, width)
                        {
                            rewrites.push((
                                idx,
                                Inst::Store {
                                    addr: base,
                                    disp,
                                    value: *value,
                                    kind: *kind,
                                },
                            ));
                        }
                    }
                }
                _ => {}
            }
        }
        for (idx, inst) in rewrites {
            func.insts[idx] = inst;
        }
    }
}

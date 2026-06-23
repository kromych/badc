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
//! into the load/store displacement: a `BinopI(Add, base, c)` address
//! with an aligned, in-range `c` becomes `Load { addr=base, disp=c }`.
//! As with the scaled-index case this fires for a shared address too --
//! the load and store of a read-modify-write of one field fold the
//! offset into both accesses, provided every use is a same-width access.

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
            Terminator::GotoIndirect { target } => bump(target, &mut counts),
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

/// Constant-offset addresses `BinopI(Add, base, c)` whose every use is a
/// load or store of one consistent width with no existing displacement,
/// keyed by the address value id and mapping to `(base, c)`. Mirrors
/// [`foldable_scaled_addresses`]: a shared address -- one `base + c`
/// feeding both the load and the store of a read-modify-write of the same
/// field -- folds into every access, so the add drops out, not only the
/// single-use case.
///
/// `c` must be a positive byte offset aligned to the access width and
/// within the scaled immediate-offset range of both targets. Aligning to
/// the width keeps the AArch64 `ldr` / `str` immediate encoding (which
/// scales by the width) valid; a width-`w` field is naturally
/// `w`-aligned, while a packed field at an unaligned offset is left for
/// the plain add path. A mix of access widths on one address, or any
/// non-access use, leaves the address alone.
fn foldable_displaced_addresses(
    func: &FunctionSsa,
    counts: &[u32],
) -> alloc::collections::BTreeMap<ValueId, (ValueId, i32)> {
    let mut cand: alloc::collections::BTreeMap<ValueId, (ValueId, i64)> =
        alloc::collections::BTreeMap::new();
    for (p, inst) in func.insts.iter().enumerate() {
        if let Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm,
        } = inst
            && *rhs_imm > 0
        {
            cand.insert(p as ValueId, (*lhs, *rhs_imm));
        }
    }
    // Per candidate, require every use to be a same-width load or store
    // with no existing displacement. `width_seen` records the first
    // access width and marks `0xff` on a width conflict; `valid` counts
    // the qualifying accesses so a non-access use (valid < total) drops
    // the candidate.
    let mut width_seen: alloc::collections::BTreeMap<ValueId, u8> =
        alloc::collections::BTreeMap::new();
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
        let (Some(w), true) = (width, cand.contains_key(&addr)) else {
            continue;
        };
        let seen = width_seen.entry(addr).or_insert(0);
        *seen = if *seen == 0 || *seen == w { w } else { 0xff };
        *valid.entry(addr).or_insert(0) += 1;
    }
    cand.into_iter()
        .filter_map(|(p, (base, c))| {
            let total = counts.get(p as usize).copied().unwrap_or(0);
            let w = width_seen.get(&p).copied().unwrap_or(0);
            if w == 0 || w == 0xff || valid.get(&p).copied().unwrap_or(0) != total {
                return None;
            }
            if c % (w as i64) != 0 || c >= (w as i64) * 4096 {
                return None;
            }
            i32::try_from(c).ok().map(|disp| (p, (base, disp)))
        })
        .collect()
}

/// Rewrite recognised scaled-index loads and stores in place.
/// When `v` is `Shr K` (arithmetic) or `Shru K` (logical) of `Shl K` of
/// some `w`, return `w` if a store of `store_width` bytes keeps only the
/// low bits the normalize leaves unchanged (`8 * store_width <= 64 - K`).
/// The `Shl K; Shr K` pair is the walker's narrowing sign/zero-extend;
/// the low `64 - K` bits of the result equal those of `w`, so a store
/// that writes no more than that many bits sees the same value.
fn pre_normalize(insts: &[Inst], v: ValueId, store_width: u8) -> Option<ValueId> {
    // The builder canonicalizes the signed `Shl K; Shr K` pair into
    // `Inst::Extend`; its low `kind`-width bits equal those of the
    // source, so a store no wider than that sees the same value.
    if let Some(Inst::Extend { value: w, kind }) = insts.get(v as usize) {
        let kind_bits = match kind {
            LoadKind::I8 => 8i64,
            LoadKind::I16 => 16,
            LoadKind::I32 => 32,
            _ => return None,
        };
        if (store_width as i64) * 8 <= kind_bits {
            return Some(*w);
        }
        return None;
    }
    let Some(Inst::BinopI {
        op: BinOp::Shr | BinOp::Shru,
        lhs,
        rhs_imm: k,
    }) = insts.get(v as usize)
    else {
        return None;
    };
    if *k <= 0 || *k >= 64 || (store_width as i64) * 8 > 64 - *k {
        return None;
    }
    let Some(Inst::BinopI {
        op: BinOp::Shl,
        lhs: w,
        rhs_imm: shl_k,
    }) = insts.get(*lhs as usize)
    else {
        return None;
    };
    if *shl_k != *k {
        return None;
    }
    Some(*w)
}

/// Redirect each sub-word store past a dead narrowing normalize (see
/// [`pre_normalize`]). The normalize is left in place; it is dropped by
/// the emit's dead-pure skip once it has no remaining use.
fn narrow_store_values(func: &mut FunctionSsa) {
    let n = func.insts.len();
    for idx in 0..n {
        let (value, width) = match &func.insts[idx] {
            Inst::Store { value, kind, .. } => match store_width(*kind) {
                Some(w) => (*value, w),
                None => continue,
            },
            _ => continue,
        };
        if let Some(pre) = pre_normalize(&func.insts, value, width)
            && let Inst::Store { value, .. } = &mut func.insts[idx]
        {
            *value = pre;
        }
    }
}

pub(super) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        narrow_store_values(func);
        let counts = use_counts(func);
        let scaled = foldable_scaled_addresses(func, &counts);
        let displaced = foldable_displaced_addresses(func, &counts);
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
                        } else if let Some(&(base, disp)) = displaced.get(addr) {
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
                        } else if let Some(&(base, disp)) = displaced.get(addr) {
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

#[cfg(test)]
mod tests {
    use super::*;
    use alloc::vec;

    // v0 = Imm (the pre-normalize w); v1 = Shl(v0, k); v2 = Shr(v1, k).
    fn shl_shr(k: i64) -> alloc::vec::Vec<Inst> {
        vec![
            Inst::Imm(0),
            Inst::BinopI {
                op: BinOp::Shl,
                lhs: 0,
                rhs_imm: k,
            },
            Inst::BinopI {
                op: BinOp::Shr,
                lhs: 1,
                rhs_imm: k,
            },
        ]
    }

    #[test]
    fn pre_normalize_k32_drops_for_i32_store_not_i64() {
        let insts = shl_shr(32);
        assert_eq!(pre_normalize(&insts, 2, 4), Some(0)); // I32: 32 <= 64-32
        assert_eq!(pre_normalize(&insts, 2, 8), None); // I64: 64 > 32
    }

    #[test]
    fn pre_normalize_k48_only_drops_for_i16_or_narrower() {
        let insts = shl_shr(48);
        assert_eq!(pre_normalize(&insts, 2, 2), Some(0)); // I16: 16 <= 64-48
        assert_eq!(pre_normalize(&insts, 2, 4), None); // I32: 32 > 16
    }

    #[test]
    fn pre_normalize_requires_matching_shift_amounts() {
        let insts = vec![
            Inst::Imm(0),
            Inst::BinopI {
                op: BinOp::Shl,
                lhs: 0,
                rhs_imm: 32,
            },
            Inst::BinopI {
                op: BinOp::Shr,
                lhs: 1,
                rhs_imm: 16,
            },
        ];
        assert_eq!(pre_normalize(&insts, 2, 4), None);
    }
}

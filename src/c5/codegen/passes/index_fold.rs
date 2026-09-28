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
//! address. A byte subscript has no shift: `Binop(Add, base, i)` folds at
//! scale 1. A shared `base + i*scale` (one address feeding both the load
//! and the store of a swapped element) folds into every use, provided
//! every use is a load or store of the matching width, so the shared
//! shift and add still drop out; an address that also feeds non-access
//! uses is left alone.
//!
//! The same pass folds a constant pointer offset (a struct field offset)
//! into the load/store displacement: a `BinopI(Add, base, c)` address
//! with an aligned, in-range `c` becomes `Load { addr=base, disp=c }`.
//! Unlike the scaled-index fold this covers the floating kinds too.
//! As with the scaled-index case this fires for a shared address too --
//! the load and store of a read-modify-write of one field fold the
//! offset into both accesses, provided every use is a same-width access.

use alloc::vec::Vec;

use crate::c5::ir::{
    BinOp, FunctionSsa, IndexExt, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId,
};

/// Access width in bytes for a load kind. Used by the displacement
/// fold, which applies to integer and floating accesses alike (the
/// immediate-offset emit honors `disp` for every kind on both targets).
fn load_width(kind: LoadKind) -> u8 {
    match kind {
        LoadKind::I64 | LoadKind::F64 => 8,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::F80 | LoadKind::F128 | LoadKind::V128 => 16,
    }
}

/// Access width in bytes for a store kind. See [`load_width`].
fn store_width(kind: StoreKind) -> u8 {
    match kind {
        StoreKind::I64 | StoreKind::F64 => 8,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F80 | StoreKind::F128 | StoreKind::V128 => 16,
    }
}

/// The transfer unit an emit's scaled displacement field is expressed
/// in. A 16-byte `long double` object moves as two 8-byte halves, so
/// its displacement scales by 8 and reaches half as far.
fn disp_unit(w: u8) -> i64 {
    if w == 16 { 8 } else { w as i64 }
}

/// Whether an access of `w` bytes at its natural alignment reaches byte
/// offset `disp` through its displacement: a multiple of the width inside
/// the scaled immediate-offset range of both targets, which AArch64
/// encodes as an unsigned 12-bit count of transfer units.
pub(crate) fn displacement_fits(disp: i64, w: u8) -> bool {
    disp >= 0 && disp % w as i64 == 0 && disp + w as i64 <= disp_unit(w) * 4096
}

/// [`load_width`] restricted to the integer kinds, `None` for the
/// floating kinds (the indexed emit handles integers only).
fn int_load_width(kind: LoadKind) -> Option<u8> {
    match kind {
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => None,
        k => Some(load_width(k)),
    }
}

/// [`store_width`] restricted to the integer kinds; the scaled-index
/// emit and the narrowing-store rewrite apply to integer values only.
fn int_store_width(kind: StoreKind) -> Option<u8> {
    match kind {
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => None,
        k => Some(store_width(k)),
    }
}

/// Mark the indexed integer accesses whose base is a data address to carry
/// that address as their displacement (`abs_base`), for an x86-64 object
/// linked at fixed addresses
/// ([`crate::c5::codegen::NativeOptions::abs32_addrs`]). A base another
/// unit defines qualifies only with `extern_bases`: the kernel code model
/// addresses one absolutely, the small model through the GOT.
pub(crate) fn mark_abs_bases(func: &mut FunctionSsa, extern_bases: bool) {
    let foreign: alloc::collections::BTreeSet<ValueId> =
        func.extern_imm_data_refs.iter().map(|&(v, _)| v).collect();
    let gpr = |w: Option<u8>| w.filter(|&w| w <= 8);
    let marks: Vec<usize> = func
        .insts
        .iter()
        .enumerate()
        .filter_map(|(i, inst)| {
            let (base, ext, scale, width) = match inst {
                Inst::LoadIndexed {
                    base,
                    index_ext,
                    scale,
                    kind,
                    ..
                } => (*base, *index_ext, *scale, gpr(int_load_width(*kind))?),
                Inst::StoreIndexed {
                    base,
                    index_ext,
                    scale,
                    kind,
                    ..
                } => (*base, *index_ext, *scale, gpr(int_store_width(*kind))?),
                _ => return None,
            };
            let data = matches!(func.insts.get(base as usize), Some(Inst::ImmData(_)));
            (ext == IndexExt::None
                && scale == width
                && data
                && (extern_bases || !foreign.contains(&base)))
            .then_some(i)
        })
        .collect();
    for i in marks {
        if let Inst::LoadIndexed { abs_base, .. } | Inst::StoreIndexed { abs_base, .. } =
            &mut func.insts[i]
        {
            *abs_base = true;
        }
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
        crate::c5::codegen::ssa::reg_alloc::for_each_operand(inst, |v| bump(v, &mut counts));
    }
    for block in &func.blocks {
        match block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => bump(cond, &mut counts),
            Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. } => {
                bump(target, &mut counts)
            }
            Terminator::Return(v) => bump(v, &mut counts),
            Terminator::Jmp(_)
            | Terminator::TailExt(_)
            | Terminator::FallThrough(_)
            | Terminator::AsmGoto { .. }
            | Terminator::Unreachable => {}
        }
        if block.exit_acc != NO_VALUE {
            bump(block.exit_acc, &mut counts);
        }
    }
    counts
}

/// `(base, index)` of `lhs + rhs` read as `base + index * scale`. Above
/// scale 1 the index is the operand of a single-use `Shl` by `log2(scale)`;
/// at scale 1 an extension or a mask is the index, an address constant the
/// base.
fn split_address(
    func: &FunctionSsa,
    counts: &[u32],
    lhs: ValueId,
    rhs: ValueId,
    scale: u8,
) -> Option<(ValueId, ValueId)> {
    let inst = |v: ValueId| func.insts.get(v as usize);
    if scale == 1 {
        let index_like = |v: ValueId| {
            matches!(
                inst(v),
                Some(Inst::Extend { .. })
                    | Some(Inst::BinopI {
                        op: BinOp::And,
                        rhs_imm: 0xffff_ffff,
                        ..
                    })
            )
        };
        let address = |v: ValueId| {
            matches!(
                inst(v),
                Some(Inst::LocalAddr(_) | Inst::ImmData(_) | Inst::TlsAddr(_))
            )
        };
        let swap = (index_like(lhs) && !index_like(rhs)) || (address(rhs) && !address(lhs));
        return Some(if swap { (rhs, lhs) } else { (lhs, rhs) });
    }
    if !matches!(scale, 2 | 4 | 8) {
        return None;
    }
    let shift = scale.trailing_zeros() as i64;
    [(lhs, rhs), (rhs, lhs)]
        .into_iter()
        .find_map(|(base, scaled)| match inst(scaled) {
            Some(Inst::BinopI {
                op: BinOp::Shl,
                lhs: index,
                rhs_imm,
            }) if *rhs_imm == shift && counts.get(scaled as usize) == Some(&1) => {
                Some((base, *index))
            }
            _ => None,
        })
}

/// Addresses whose every use is an integer load or store of one width,
/// mapped to `(base, index, scale)` with `scale` that width. A shared
/// address (the load and the store of a swapped element) folds into every
/// access, so the add and the shift drop out.
fn foldable_scaled_addresses(
    func: &FunctionSsa,
    counts: &[u32],
) -> alloc::collections::BTreeMap<ValueId, (ValueId, ValueId, u8)> {
    const MIXED: u8 = 0xff;
    // Per `Add` address: the width of its qualifying accesses and their
    // count; any other use leaves the count short of the total.
    let mut seen: alloc::collections::BTreeMap<ValueId, (u8, u32)> =
        alloc::collections::BTreeMap::new();
    for inst in &func.insts {
        let (addr, width) = match inst {
            Inst::Load {
                addr,
                disp: 0,
                kind,
                volatile: false,
                align: 0,
            } => (*addr, int_load_width(*kind)),
            Inst::Store {
                addr,
                disp: 0,
                kind,
                volatile: false,
                align: 0,
                ..
            } => (*addr, int_store_width(*kind)),
            _ => continue,
        };
        let is_add = matches!(
            func.insts.get(addr as usize),
            Some(Inst::Binop { op: BinOp::Add, .. })
        );
        if let (true, Some(w)) = (is_add, width) {
            let e = seen.entry(addr).or_insert((w, 0));
            e.0 = if e.0 == w { w } else { MIXED };
            e.1 += 1;
        }
    }
    seen.into_iter()
        .filter_map(|(p, (w, valid))| {
            let total = counts.get(p as usize).copied().unwrap_or(0);
            if w == MIXED || valid != total {
                return None;
            }
            let Some(Inst::Binop { lhs, rhs, .. }) = func.insts.get(p as usize) else {
                return None;
            };
            split_address(func, counts, *lhs, *rhs, w).map(|(base, index)| (p, (base, index, w)))
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
/// within the scaled immediate-offset range of both targets, or below
/// 256: the AArch64 `ldr` / `str` immediate scales by the width, and an
/// unaligned offset -- a packed field's -- takes the unscaled 9-bit form.
/// The fold leaves the address itself unchanged, so
/// an access carrying a proven alignment keeps it. A volatile access
/// folds too: it stays one access of its width (C99 6.7.3p6), with its
/// flag; the indexed forms carry no such flag, so it takes this fold
/// only. A mix of access widths on one address, or any non-access use,
/// leaves the address alone.
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
    // Addresses an access carries a proven alignment for: the lowering
    // may split such an access into byte units, whose scaled immediate
    // reaches only 4095 rather than the width-scaled range below.
    let mut bounded: alloc::collections::BTreeSet<ValueId> = alloc::collections::BTreeSet::new();
    for inst in &func.insts {
        let (addr, w, align) = match inst {
            Inst::Load {
                addr,
                disp: 0,
                kind,
                align,
                ..
            } => (*addr, load_width(*kind), *align),
            Inst::Store {
                addr,
                disp: 0,
                kind,
                align,
                ..
            } => (*addr, store_width(*kind), *align),
            _ => continue,
        };
        if !cand.contains_key(&addr) {
            continue;
        }
        let seen = width_seen.entry(addr).or_insert(0);
        *seen = if *seen == 0 || *seen == w { w } else { 0xff };
        *valid.entry(addr).or_insert(0) += 1;
        if align != 0 {
            bounded.insert(addr);
        }
    }
    cand.into_iter()
        .filter_map(|(p, (base, c))| {
            let total = counts.get(p as usize).copied().unwrap_or(0);
            let w = width_seen.get(&p).copied().unwrap_or(0);
            if w == 0 || w == 0xff || valid.get(&p).copied().unwrap_or(0) != total {
                return None;
            }
            let fits = if bounded.contains(&p) {
                c + (w as i64) <= 4096
            } else {
                displacement_fits(c, w) || c < 256
            };
            if !fits {
                return None;
            }
            i32::try_from(c).ok().map(|disp| (p, (base, disp)))
        })
        .collect()
}

/// The slot a frame address names, for an access that the local forms can
/// carry unchanged: no displacement (they hold none) and no alignment
/// bound below the natural one (they state none, so the strict-alignment
/// lowering would widen the transfer). The access must be the address's
/// only use, so the fold drops the address instead of leaving it to serve
/// the rest: a frame offset past the immediate-offset forms is rebuilt
/// once per access, which costs more than one shared base.
fn folded_slot(insts: &[Inst], counts: &[u32], addr: ValueId, disp: i32, align: u8) -> Option<i64> {
    if disp != 0 || align != 0 || counts.get(addr as usize) != Some(&1) {
        return None;
    }
    match insts.get(addr as usize)? {
        Inst::LocalAddr(off) => Some(*off),
        _ => None,
    }
}

/// Fold a frame address its access is the sole consumer of into that
/// access: `Load`/`Store` through `LocalAddr(off)` become `LoadLocal` /
/// `StoreLocal`, which the per-arch emit addresses off the frame base
/// with no register for the address. Runs after the value numbering, so
/// the duplicate `LocalAddr`s the builder emits per access -- it keeps
/// them out of its own cache -- are already merged and the use count
/// says whether the address really serves one access. The address itself
/// is left in place; the emit skips it once dead.
pub(crate) fn fold_slot_addresses(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        let counts = use_counts(func);
        let mut rewrites: Vec<(usize, Inst)> = Vec::new();
        for (idx, inst) in func.insts.iter().enumerate() {
            let folded = match inst {
                Inst::Load {
                    addr,
                    disp,
                    kind,
                    volatile,
                    align,
                } => folded_slot(&func.insts, &counts, *addr, *disp, *align).map(|off| {
                    Inst::LoadLocal {
                        off,
                        kind: *kind,
                        volatile: *volatile,
                    }
                }),
                Inst::Store {
                    addr,
                    disp,
                    value,
                    kind,
                    volatile,
                    align,
                } => folded_slot(&func.insts, &counts, *addr, *disp, *align).map(|off| {
                    Inst::StoreLocal {
                        off,
                        value: *value,
                        kind: *kind,
                        volatile: *volatile,
                        nsw: false,
                    }
                }),
                _ => None,
            };
            if let Some(inst) = folded {
                rewrites.push((idx, inst));
            }
        }
        for (idx, inst) in rewrites {
            func.insts[idx] = inst;
        }
    }
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
    if let Some(Inst::Extend { value: w, kind, .. }) = insts.get(v as usize) {
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
            Inst::Store { value, kind, .. } => match int_store_width(*kind) {
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

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
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
                    volatile,
                    align,
                } => {
                    if let (Some(width), Some(&(base, index, scale))) = (
                        int_load_width(*kind),
                        scaled.get(addr).filter(|_| *align == 0 && !*volatile),
                    ) {
                        debug_assert_eq!(scale, width);
                        rewrites.push((
                            idx,
                            Inst::LoadIndexed {
                                base,
                                index,
                                index_ext: IndexExt::None,
                                scale,
                                kind: *kind,
                                abs_base: false,
                            },
                        ));
                    } else if let Some(&(base, disp)) = displaced.get(addr) {
                        rewrites.push((
                            idx,
                            Inst::Load {
                                addr: base,
                                disp,
                                kind: *kind,
                                volatile: *volatile,
                                align: *align,
                            },
                        ));
                    }
                }
                Inst::Store {
                    addr,
                    disp: 0,
                    value,
                    kind,
                    volatile,
                    align,
                } => {
                    if let (Some(width), Some(&(base, index, scale))) = (
                        int_store_width(*kind),
                        scaled.get(addr).filter(|_| *align == 0 && !*volatile),
                    ) {
                        debug_assert_eq!(scale, width);
                        rewrites.push((
                            idx,
                            Inst::StoreIndexed {
                                base,
                                index,
                                index_ext: IndexExt::None,
                                scale,
                                value: *value,
                                kind: *kind,
                                abs_base: false,
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
                                volatile: *volatile,
                                align: *align,
                            },
                        ));
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

    use crate::c5::ir::Block;

    /// One block over `insts` returning its last value, after the fold.
    fn folded(insts: alloc::vec::Vec<Inst>) -> alloc::vec::Vec<Inst> {
        let n = insts.len() as u32;
        let mut funcs = vec![FunctionSsa {
            inst_src: vec![(0, 0); insts.len()],
            f32_values: vec![false; insts.len()],
            insts,
            blocks: vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: Terminator::Return(n - 1),
                exit_acc: NO_VALUE,
            }],
            ..Default::default()
        }];
        run(&mut funcs);
        funcs.pop().unwrap().insts
    }

    fn param(idx: u8, kind: LoadKind) -> Inst {
        Inst::ParamRef {
            idx: idx.into(),
            kind,
        }
    }

    fn add(lhs: ValueId, rhs: ValueId) -> Inst {
        Inst::Binop {
            op: BinOp::Add,
            lhs,
            rhs,
        }
    }

    fn load(addr: ValueId, kind: LoadKind) -> Inst {
        Inst::Load {
            addr,
            disp: 0,
            kind,
            volatile: false,
            align: 0,
        }
    }

    fn store(addr: ValueId, value: ValueId, kind: StoreKind) -> Inst {
        Inst::Store {
            addr,
            disp: 0,
            value,
            kind,
            volatile: false,
            align: 0,
        }
    }

    /// v0 = pointer, v1 = int, v2 = its extension.
    fn pointer_and_index() -> alloc::vec::Vec<Inst> {
        vec![
            param(0, LoadKind::I64),
            param(1, LoadKind::I32),
            Inst::Extend {
                value: 1,
                kind: LoadKind::I32,
                nsw: false,
            },
        ]
    }

    #[test]
    fn byte_accesses_of_a_shared_add_fold_at_scale_1() {
        let mut insts = pointer_and_index();
        insts.extend([
            add(0, 2),
            load(3, LoadKind::U8),
            store(3, 4, StoreKind::I8),
            load(3, LoadKind::I8),
        ]);
        let out = folded(insts);
        assert!(matches!(
            out[4],
            Inst::LoadIndexed {
                base: 0,
                index: 2,
                index_ext: IndexExt::None,
                scale: 1,
                kind: LoadKind::U8,
                ..
            }
        ));
        assert!(matches!(
            out[5],
            Inst::StoreIndexed {
                base: 0,
                index: 2,
                index_ext: IndexExt::None,
                scale: 1,
                value: 4,
                kind: StoreKind::I8,
                ..
            }
        ));
        assert!(matches!(
            out[6],
            Inst::LoadIndexed {
                base: 0,
                index: 2,
                index_ext: IndexExt::None,
                scale: 1,
                kind: LoadKind::I8,
                ..
            }
        ));
    }

    /// A volatile access takes a constant offset as its displacement and
    /// keeps its flag; a scaled index stays an address computation, since
    /// the indexed forms carry no volatile flag.
    #[test]
    fn volatile_access_folds_a_displacement_only() {
        let volatile = |mut i: Inst| {
            if let Inst::Load { volatile, .. } | Inst::Store { volatile, .. } = &mut i {
                *volatile = true;
            }
            i
        };
        let out = folded(vec![
            param(0, LoadKind::I64),
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 0,
                rhs_imm: 16,
            },
            volatile(load(1, LoadKind::U32)),
            volatile(store(1, 2, StoreKind::I32)),
        ]);
        for i in [2, 3] {
            assert!(
                matches!(
                    out[i],
                    Inst::Load {
                        addr: 0,
                        disp: 16,
                        volatile: true,
                        ..
                    } | Inst::Store {
                        addr: 0,
                        disp: 16,
                        volatile: true,
                        ..
                    }
                ),
                "{:?}",
                out[i]
            );
        }
        let mut insts = pointer_and_index();
        insts.extend([
            Inst::BinopI {
                op: BinOp::Shl,
                lhs: 2,
                rhs_imm: 2,
            },
            add(0, 3),
            volatile(load(4, LoadKind::U32)),
        ]);
        let out = folded(insts);
        assert!(
            matches!(
                out[5],
                Inst::Load {
                    addr: 4,
                    disp: 0,
                    volatile: true,
                    ..
                }
            ),
            "{:?}",
            out[5]
        );
    }

    /// An offset the access width does not divide folds below 256, where
    /// the unscaled form takes it, and for an access with a proven
    /// alignment wherever its pieces reach; a farther one stays an add.
    #[test]
    fn unaligned_offset_folds_where_an_encoding_takes_it() {
        let run = |off: i64, align: u8| {
            let mut ld = load(1, LoadKind::I32);
            if let Inst::Load { align: a, .. } = &mut ld {
                *a = align;
            }
            let out = folded(vec![
                param(0, LoadKind::I64),
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs_imm: off,
                },
                ld,
            ]);
            matches!(out[2], Inst::Load { addr: 0, disp, .. } if disp as i64 == off)
        };
        assert!(run(1, 0), "unscaled reach");
        assert!(!run(257, 0), "past the unscaled reach");
        assert!(run(257, 1), "a split access's byte pieces reach it");
        assert!(!run(4093, 1), "past the pieces' reach");
    }

    /// The extension is the index and an address constant the base,
    /// whichever side of the add they sit on.
    #[test]
    fn unscaled_operands_take_their_roles() {
        let mut insts = pointer_and_index();
        insts.extend([add(2, 0), load(3, LoadKind::U8)]);
        assert!(matches!(
            folded(insts)[4],
            Inst::LoadIndexed {
                base: 0,
                index: 2,
                ..
            }
        ));
        let insts = vec![
            param(0, LoadKind::I64),
            Inst::ImmData(16),
            add(0, 1),
            load(2, LoadKind::U8),
        ];
        assert!(matches!(
            folded(insts)[3],
            Inst::LoadIndexed {
                base: 1,
                index: 0,
                ..
            }
        ));
    }

    /// A byte read of `base + (i << 2)` has no scale to take from the
    /// shift: the shifted value is the index.
    #[test]
    fn byte_access_of_a_shifted_index_keeps_the_shift() {
        let mut insts = pointer_and_index();
        insts.extend([
            Inst::BinopI {
                op: BinOp::Shl,
                lhs: 2,
                rhs_imm: 2,
            },
            add(0, 3),
            load(4, LoadKind::U8),
        ]);
        assert!(matches!(
            folded(insts)[5],
            Inst::LoadIndexed {
                base: 0,
                index: 3,
                scale: 1,
                ..
            }
        ));
    }

    #[test]
    fn word_access_takes_its_scale_from_a_single_use_shift() {
        let shifted = |extra_use: bool| {
            let mut insts = pointer_and_index();
            insts.extend([
                Inst::BinopI {
                    op: BinOp::Shl,
                    lhs: 2,
                    rhs_imm: 2,
                },
                add(0, 3),
                load(4, LoadKind::I32),
            ]);
            if extra_use {
                insts.push(add(3, 5));
            }
            folded(insts)
        };
        assert!(matches!(
            shifted(false)[5],
            Inst::LoadIndexed {
                base: 0,
                index: 2,
                index_ext: IndexExt::None,
                scale: 4,
                kind: LoadKind::I32,
                ..
            }
        ));
        assert!(matches!(shifted(true)[5], Inst::Load { addr: 4, .. }));
    }

    /// The address stays when a use is not a plain one-byte access or the
    /// access is wider than a byte and no shift supplies its scale.
    #[test]
    fn unscaled_fold_needs_every_use_to_be_a_byte_access() {
        let with = |uses: alloc::vec::Vec<Inst>| {
            let mut insts = pointer_and_index();
            insts.push(add(0, 2));
            insts.extend(uses);
            folded(insts)
        };
        let kept = |out: &[Inst], at: usize| {
            matches!(
                out[at],
                Inst::Load { addr: 3, .. } | Inst::Store { addr: 3, .. }
            )
        };
        // The address itself is returned.
        let out = with(vec![load(3, LoadKind::U8), add(3, 3)]);
        assert!(kept(&out, 4));
        // A second access of another width.
        let out = with(vec![load(3, LoadKind::U8), load(3, LoadKind::I32)]);
        assert!(kept(&out, 4) && kept(&out, 5));
        // A word access without a shift.
        let out = with(vec![load(3, LoadKind::I32)]);
        assert!(kept(&out, 4));
        // A floating access.
        let out = with(vec![load(3, LoadKind::F32)]);
        assert!(kept(&out, 4));
        // A volatile access, a displaced one and an aligned one.
        for odd in [
            Inst::Load {
                addr: 3,
                disp: 0,
                kind: LoadKind::U8,
                volatile: true,
                align: 0,
            },
            Inst::Load {
                addr: 3,
                disp: 1,
                kind: LoadKind::U8,
                volatile: false,
                align: 0,
            },
            Inst::Load {
                addr: 3,
                disp: 0,
                kind: LoadKind::U8,
                volatile: false,
                align: 1,
            },
        ] {
            let out = with(vec![load(3, LoadKind::U8), odd.clone()]);
            assert!(kept(&out, 4), "folded beside {odd:?}");
        }
        // The stored value is the address: a use that is not the access's
        // address operand.
        let out = with(vec![store(3, 3, StoreKind::I8)]);
        assert!(kept(&out, 4));
    }

    /// The local forms carry no displacement and no alignment bound, so
    /// the fold refuses both.
    #[test]
    fn a_local_address_folds_only_at_offset_zero_and_natural_alignment() {
        let insts = vec![Inst::LocalAddr(-3)];
        assert_eq!(folded_slot(&insts, &[1], 0, 0, 0), Some(-3));
        assert_eq!(folded_slot(&insts, &[1], 0, 8, 0), None);
        assert_eq!(folded_slot(&insts, &[1], 0, 0, 1), None);
        // A second use keeps the address; folding one access would leave
        // the materialisation standing.
        assert_eq!(folded_slot(&insts, &[2], 0, 0, 0), None);
        // Only a frame address folds; a computed one keeps its `Load`.
        let insts = vec![Inst::Imm(0)];
        assert_eq!(folded_slot(&insts, &[1], 0, 0, 0), None);
    }
}

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
//! The fold fires only when the shift amount matches the access width
//! (the per-arch emit requires `scale == width`) and when the shift and
//! the add each feed nothing but this one access, so the collapsed
//! instructions become unreferenced and the emit's use-count skip drops
//! them. A shared address (one `base + i*scale` feeding several accesses)
//! is left alone: re-deriving it inside each addressing mode would not
//! remove the shared computation.

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

/// When `addr` is `Add(base, Shl(index, s))` with `1 << s == width`, and
/// the add and shift each have a single use, return `(base, index)`.
fn scaled_address(
    func: &FunctionSsa,
    counts: &[u32],
    addr: ValueId,
    width: u8,
) -> Option<(ValueId, ValueId)> {
    if counts.get(addr as usize).copied().unwrap_or(0) != 1 {
        return None;
    }
    let Inst::Binop {
        op: BinOp::Add,
        lhs,
        rhs,
    } = func.insts.get(addr as usize)?
    else {
        return None;
    };
    // The shift may be either operand of the commutative add.
    let try_arm = |base: ValueId, scaled: ValueId| -> Option<(ValueId, ValueId)> {
        if counts.get(scaled as usize).copied().unwrap_or(0) != 1 {
            return None;
        }
        let Inst::BinopI {
            op: BinOp::Shl,
            lhs: index,
            rhs_imm,
        } = func.insts.get(scaled as usize)?
        else {
            return None;
        };
        if *rhs_imm < 0 || *rhs_imm > 3 || (1u8 << *rhs_imm) != width {
            return None;
        }
        Some((base, *index))
    };
    try_arm(*lhs, *rhs).or_else(|| try_arm(*rhs, *lhs))
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
                        if let Some((base, index)) = scaled_address(func, &counts, *addr, width) {
                            rewrites.push((
                                idx,
                                Inst::LoadIndexed {
                                    base,
                                    index,
                                    scale: width,
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
                        if let Some((base, index)) = scaled_address(func, &counts, *addr, width) {
                            rewrites.push((
                                idx,
                                Inst::StoreIndexed {
                                    base,
                                    index,
                                    scale: width,
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

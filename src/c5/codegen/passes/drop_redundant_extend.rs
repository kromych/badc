//! Drop a redundant `Inst::Extend { value, kind }` by redirecting its
//! consumers to `value`. An extend is redundant in two cases:
//!
//!   1. `value` is a sign-extending load of the same `kind`
//!      (`Load` / `LoadLocal` / `LoadIndexed` with `I8` / `I16` / `I32`).
//!      Those lower to `ldrsb` / `ldrsh` / `ldrsw` (AArch64) or the
//!      `movsx` family (x86_64), already depositing a 64-bit
//!      sign-extended value, so the extend re-applies the same
//!      extension and is a no-op.
//!
//!   2. The extend is an `I32` sign-extend whose upper 32 bits no
//!      consumer reads (`compute_high_observed`). Every consumer sees
//!      the same low 32 bits in `value`, and the extend only differs in
//!      the unread upper half, so it can be dropped. This removes the
//!      per-op renormalization left over from a chain of low-word
//!      integer arithmetic.
//!
//! The dead Extend is left in place; the allocator's dead-pure DCE and
//! the per-arch emit's `is_dead_pure` skip drop it. `resolve` walks
//! redirect chains so stacked extends collapse.

use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId};
use alloc::vec::Vec;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
        run_one(func);
    }
}

/// Mark `v`'s upper bits as observed and enqueue it for propagation.
fn observe(hi: &mut [bool], work: &mut Vec<ValueId>, v: ValueId) {
    if (v as usize) < hi.len() && !hi[v as usize] {
        hi[v as usize] = true;
        work.push(v);
    }
}

/// For every value, whether any consumer reads bits at or above bit 32.
///
/// An `Add`/`Sub`/`Mul`/`And`/`Or`/`Xor`/`Shl` result's low 32 bits depend only
/// on its operands' low 32 bits (C99 6.2.5p9 / 6.5p5: two's-complement low-word
/// arithmetic), and a `Phi` selects one operand, so these forward the consumer's
/// observation to their operands and are transparent to the low word. A right
/// shift, divide/modulo, rotate, ordered/equality compare, 64-bit store, address
/// operand, call argument, FP cast, atomic, return, or branch condition reads the
/// full register, so it observes the upper bits directly. `Inst::Extend` reads
/// only the low `kind`-width bits, so it never observes its source's upper bits.
/// Anything not positively classified as low-word-only is treated as observing,
/// so the result is a conservative over-approximation. Shared with the allocator,
/// which consults it to skip a `ParamRef` entry sign-extension whose result is
/// never read above bit 31 (the parameter's low word already holds the C99
/// 6.5.2.2p4-converted value; the return boundary stays conservative, so a value
/// feeding the return keeps its canonicalization).
pub(crate) fn compute_high_observed(func: &FunctionSsa) -> Vec<bool> {
    let n = func.insts.len();
    let mut hi = alloc::vec![false; n];
    let mut work: Vec<ValueId> = Vec::new();

    for inst in &func.insts {
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
            | Inst::ParamRef { .. }
            | Inst::Extend { .. } => {}
            Inst::Load { addr, .. } => observe(&mut hi, &mut work, *addr),
            Inst::LoadIndexed { base, index, .. } => {
                observe(&mut hi, &mut work, *base);
                observe(&mut hi, &mut work, *index);
            }
            Inst::Store {
                addr, value, kind, ..
            } => {
                observe(&mut hi, &mut work, *addr);
                if *kind == StoreKind::I64 {
                    observe(&mut hi, &mut work, *value);
                }
            }
            Inst::StoreLocal { value, kind, .. } => {
                if *kind == StoreKind::I64 {
                    observe(&mut hi, &mut work, *value);
                }
            }
            Inst::StoreIndexed {
                base,
                index,
                value,
                kind,
                ..
            } => {
                observe(&mut hi, &mut work, *base);
                observe(&mut hi, &mut work, *index);
                if *kind == StoreKind::I64 {
                    observe(&mut hi, &mut work, *value);
                }
            }
            Inst::Binop { op, lhs, rhs } => match op {
                BinOp::Add | BinOp::Sub | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor => {}
                BinOp::Shl => observe(&mut hi, &mut work, *rhs),
                _ => {
                    observe(&mut hi, &mut work, *lhs);
                    observe(&mut hi, &mut work, *rhs);
                }
            },
            Inst::BinopI { op, lhs, .. } => match op {
                BinOp::Add
                | BinOp::Sub
                | BinOp::Mul
                | BinOp::And
                | BinOp::Or
                | BinOp::Xor
                | BinOp::Shl => {}
                _ => observe(&mut hi, &mut work, *lhs),
            },
            Inst::FpCast { value, .. } => observe(&mut hi, &mut work, *value),
            Inst::Fneg(v) => observe(&mut hi, &mut work, *v),
            Inst::Fma { a, b, c, .. } => {
                observe(&mut hi, &mut work, *a);
                observe(&mut hi, &mut work, *b);
                observe(&mut hi, &mut work, *c);
            }
            Inst::Call { args, .. } | Inst::CallExt { args, .. } | Inst::Intrinsic { args, .. } => {
                for a in args {
                    observe(&mut hi, &mut work, *a);
                }
            }
            Inst::CallIndirect { target, args, .. } => {
                observe(&mut hi, &mut work, *target);
                for a in args {
                    observe(&mut hi, &mut work, *a);
                }
            }
            Inst::Mcpy { dst, src, .. } => {
                observe(&mut hi, &mut work, *dst);
                observe(&mut hi, &mut work, *src);
            }
            Inst::AtomicRmw { addr, value, .. } => {
                observe(&mut hi, &mut work, *addr);
                observe(&mut hi, &mut work, *value);
            }
            Inst::AtomicCas {
                addr,
                expected_addr,
                desired,
                ..
            } => {
                observe(&mut hi, &mut work, *addr);
                observe(&mut hi, &mut work, *expected_addr);
                observe(&mut hi, &mut work, *desired);
            }
            Inst::Phi { .. } => {}
        }
    }
    for block in &func.blocks {
        if block.exit_acc != NO_VALUE {
            observe(&mut hi, &mut work, block.exit_acc);
        }
        match &block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                observe(&mut hi, &mut work, *cond);
            }
            Terminator::GotoIndirect { target } => observe(&mut hi, &mut work, *target),
            Terminator::Return(v) if *v != NO_VALUE => observe(&mut hi, &mut work, *v),
            _ => {}
        }
    }

    // Propagate: an observed transparent result observes its operands.
    while let Some(r) = work.pop() {
        match &func.insts[r as usize] {
            Inst::Binop {
                op: BinOp::Add | BinOp::Sub | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor,
                lhs,
                rhs,
            } => {
                observe(&mut hi, &mut work, *lhs);
                observe(&mut hi, &mut work, *rhs);
            }
            Inst::Binop {
                op: BinOp::Shl,
                lhs,
                ..
            } => observe(&mut hi, &mut work, *lhs),
            Inst::BinopI {
                op:
                    BinOp::Add
                    | BinOp::Sub
                    | BinOp::Mul
                    | BinOp::And
                    | BinOp::Or
                    | BinOp::Xor
                    | BinOp::Shl,
                lhs,
                ..
            } => observe(&mut hi, &mut work, *lhs),
            Inst::Phi { incoming, .. } => {
                let ops: Vec<ValueId> = incoming.iter().map(|(_, v)| *v).collect();
                for v in ops {
                    observe(&mut hi, &mut work, v);
                }
            }
            _ => {}
        }
    }
    hi
}

fn is_signed_load(insts: &[Inst], v: ValueId) -> Option<LoadKind> {
    if v == NO_VALUE {
        return None;
    }
    let idx = v as usize;
    if idx >= insts.len() {
        return None;
    }
    let kind = match &insts[idx] {
        Inst::Load { kind, .. } => *kind,
        Inst::LoadLocal { kind, .. } => *kind,
        Inst::LoadIndexed { kind, .. } => *kind,
        _ => return None,
    };
    match kind {
        LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => Some(kind),
        _ => None,
    }
}

fn run_one(func: &mut FunctionSsa) {
    let n = func.insts.len();
    if !func.insts.iter().any(|i| matches!(i, Inst::Extend { .. })) {
        return;
    }
    // An Extend is redundant when (1) its operand is a sign-extending load of
    // the same kind, so the extend re-applies the load's own sign extension; or
    // (2) it is an i32 sign-extend whose upper bits no consumer reads, so every
    // consumer sees the same low 32 bits in the operand. Both redirect the
    // extend's consumers to the operand; `resolve` walks redirect chains.
    let high = compute_high_observed(func);
    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; n];
    for (idx, inst) in func.insts.iter().enumerate() {
        let Inst::Extend { value, kind } = inst else {
            continue;
        };
        if is_signed_load(&func.insts, *value) == Some(*kind)
            || (*kind == LoadKind::I32 && !high[idx])
        {
            redirect[idx] = Some(*value);
        }
    }
    if redirect.iter().all(|r| r.is_none()) {
        return;
    }
    // Resolve through chains: Extend(Extend(load)) becomes load.
    fn resolve(redirect: &[Option<ValueId>], mut v: ValueId) -> ValueId {
        let mut guard = 0u32;
        while v != NO_VALUE {
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
    // Rewrite every operand, terminator value, and block accumulator.
    for inst in func.insts.iter_mut() {
        // The redirect-from list (the dead Extends) reads the load
        // operand; rewriting it would be a self-edit, so skip those
        // and let the per-arch emit's is_dead_pure path drop them.
        if let Inst::Extend { value: _, kind: _ } = inst {
            continue;
        }
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

/// Walk every value operand the inst references and call `f` with
/// a mutable reference. Mirrors `ssa_mem2reg::for_each_operand_mut`.
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
    use super::*;
    use crate::c5::ir::{BinOp, Block, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
    use alloc::vec;

    fn fresh(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
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
            blocks,
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    #[test]
    fn extend_i32_of_load_i32_redirects_to_load() {
        // v0: Imm(0) (address)
        // v1: Load(addr=v0, kind=I32)
        // v2: Extend(value=v1, kind=I32)
        // Return(v2) -- should rewrite to Return(v1).
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                    volatile: false,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(1)),
            "Return should redirect from v2 (Extend) to v1 (Load); got {:?}",
            f.blocks[0].terminator
        );
    }

    #[test]
    fn extend_i64_of_load_i32_is_not_redirected() {
        // Different widths -- the Extend changes the value's width
        // and must stay. (Currently the IR only sign-extends but
        // be conservative.)
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                    volatile: false,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I64,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(2)));
    }

    #[test]
    fn extend_u32_of_load_u32_is_not_redirected() {
        // Unsigned loads zero-extend; Extend is conservative here.
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::U32,
                    volatile: false,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(2)));
    }

    #[test]
    fn no_extend_no_change() {
        let mut f = fresh(
            vec![Inst::Imm(0)],
            vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Return(0),
                exit_acc: 0,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(0)));
    }

    /// v0 Imm(addr); v1 Load I32; v2 Add(v1,v1); v3 Extend(v2,I32);
    /// v4 Store(v3, kind). A 4-byte store reads only the low 32 bits,
    /// so the extend's upper half is dead and v4 redirects to v2; a
    /// 8-byte store reads the full value, so the extend stays.
    fn extend_over_add_feeding_store(store_kind: StoreKind) -> FunctionSsa {
        fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                    volatile: false,
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 1,
                    rhs: 1,
                },
                Inst::Extend {
                    value: 2,
                    kind: LoadKind::I32,
                },
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 3,
                    kind: store_kind,
                    volatile: false,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..5,
                terminator: Terminator::Return(NO_VALUE),
                exit_acc: NO_VALUE,
            }],
        )
    }

    #[test]
    fn extend_with_dead_high_bits_is_dropped() {
        let mut f = extend_over_add_feeding_store(StoreKind::I32);
        run_one(&mut f);
        assert!(
            matches!(f.insts[4], Inst::Store { value: 2, .. }),
            "narrow store should read the pre-extend add directly; got {:?}",
            f.insts[4],
        );
    }

    #[test]
    fn extend_feeding_wide_store_is_kept() {
        let mut f = extend_over_add_feeding_store(StoreKind::I64);
        run_one(&mut f);
        assert!(
            matches!(f.insts[4], Inst::Store { value: 3, .. }),
            "8-byte store observes the upper bits; extend must stay",
        );
    }

    #[test]
    fn extend_feeding_signed_compare_is_kept() {
        // v3 Extend(v2) feeds a signed `Lt` compare, which reads the
        // sign bit in the high half, so it must not be dropped.
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                    volatile: false,
                },
                Inst::Binop {
                    op: BinOp::Mul,
                    lhs: 1,
                    rhs: 1,
                },
                Inst::Extend {
                    value: 2,
                    kind: LoadKind::I32,
                },
                Inst::BinopI {
                    op: BinOp::Lt,
                    lhs: 3,
                    rhs_imm: 0,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..5,
                terminator: Terminator::Return(4),
                exit_acc: 4,
            }],
        );
        run_one(&mut f);
        assert!(
            matches!(f.insts[4], Inst::BinopI { lhs: 3, .. }),
            "signed compare must keep reading the sign-extended value",
        );
    }
}

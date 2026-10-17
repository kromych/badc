//! Folding a constant shift into the add / sub / logical operation that
//! reads it. The SSA comes from [`SsaBuilder`].

use super::*;
use crate::c5::codegen::ssa::build::SsaBuilder;
use crate::c5::ir::LoadKind;

/// Two parameters, then `f(a, b)` over one block.
fn build<F>(body: F) -> FunctionSsa
where
    F: FnOnce(&mut SsaBuilder, ValueId, ValueId) -> ValueId,
{
    let mut b = SsaBuilder::new(0, 2, false);
    let x = b.load_local(2, LoadKind::I64);
    let y = b.load_local(3, LoadKind::I64);
    let out = body(&mut b, x, y);
    b.return_(out);
    let mut func = b.finish();
    run(core::slice::from_mut(&mut func));
    func
}

/// The fused node at the returned value, as `(op, lhs, rhs, shift, amount)`.
fn fused(func: &FunctionSsa) -> Option<(BinOp, ValueId, ValueId, BinOp, u8)> {
    let out = func.insts.len() - 1;
    match func.insts[out] {
        Inst::ShiftOp {
            op,
            lhs,
            rhs,
            shift,
            amount,
        } => Some((op, lhs, rhs, shift, amount)),
        _ => None,
    }
}

/// Shifts still reaching the emit: a folded one is left unread.
fn live_shifts(func: &FunctionSsa) -> usize {
    let counts = compute_use_counts(func);
    func.insts
        .iter()
        .enumerate()
        .filter(|(v, inst)| counts[*v] > 0 && matches!(inst, Inst::BinopI { .. }))
        .count()
}

/// Each operation and each shift kind folds from the right operand.
#[test]
fn every_operation_takes_every_shift_on_its_right_operand() {
    for op in [BinOp::Add, BinOp::Sub, BinOp::And, BinOp::Or, BinOp::Xor] {
        for shift in [BinOp::Shl, BinOp::Shr, BinOp::Shru] {
            let func = build(|b, x, y| {
                let s = b.binop_imm(shift, y, 7);
                b.binop(op, x, s)
            });
            assert_eq!(fused(&func), Some((op, 0, 1, shift, 7)), "{op:?} {shift:?}");
            assert_eq!(live_shifts(&func), 0);
        }
    }
}

/// A commutative operation folds a shift on its left as well, naming the
/// other operand as `lhs`; `(y << k) - x` has no shifted-register form.
#[test]
fn a_left_shift_operand_folds_only_under_a_commutative_operation() {
    for op in [BinOp::Add, BinOp::And, BinOp::Or, BinOp::Xor, BinOp::Sub] {
        let func = build(|b, x, y| {
            let s = b.binop_imm(BinOp::Shl, y, 16);
            b.binop(op, s, x)
        });
        if op == BinOp::Sub {
            assert_eq!(fused(&func), None);
            assert_eq!(live_shifts(&func), 1);
        } else {
            assert_eq!(fused(&func), Some((op, 0, 1, BinOp::Shl, 16)), "{op:?}");
        }
    }
}

/// A multiply by a power of two is the left shift the emit lowers it to.
#[test]
fn a_power_of_two_multiplier_folds_as_a_left_shift() {
    let func = build(|b, x, y| {
        let s = b.binop_imm(BinOp::Mul, y, 8);
        b.binop(BinOp::Add, x, s)
    });
    assert_eq!(fused(&func), Some((BinOp::Add, 0, 1, BinOp::Shl, 3)));
}

/// A shift with a second reader is still materialised, an amount outside
/// 1..=63 has no encoding, and a multiplier that is not a power of two is
/// not a shift.
#[test]
fn shifts_the_operand_cannot_absorb_stay() {
    let func = build(|b, x, y| {
        let s = b.binop_imm(BinOp::Shl, y, 4);
        let t = b.binop(BinOp::Or, x, s);
        b.binop(BinOp::Xor, t, s)
    });
    assert!(
        func.insts
            .iter()
            .all(|i| !matches!(i, Inst::ShiftOp { .. }))
    );
    for (op, k) in [
        (BinOp::Shl, 64),
        (BinOp::Shru, -1),
        (BinOp::Mul, 6),
        (BinOp::Mul, i64::MIN),
    ] {
        let func = build(|b, x, y| {
            let s = b.binop_imm(op, y, k);
            b.binop(BinOp::Add, x, s)
        });
        assert_eq!(fused(&func), None, "{op:?} {k}");
    }
}

/// Two shifted operands: the right one folds, the left one stays the
/// register operand it computes.
#[test]
fn two_shifted_operands_fold_once() {
    let func = build(|b, x, y| {
        let s = b.binop_imm(BinOp::Shl, x, 2);
        let t = b.binop_imm(BinOp::Shru, y, 3);
        b.binop(BinOp::Or, s, t)
    });
    let (op, lhs, rhs, shift, amount) = fused(&func).expect("the or folds");
    assert_eq!((op, rhs, shift, amount), (BinOp::Or, 1, BinOp::Shru, 3));
    assert!(matches!(
        func.insts[lhs as usize],
        Inst::BinopI {
            op: BinOp::Shl,
            lhs: 0,
            rhs_imm: 2
        }
    ));
    assert_eq!(live_shifts(&func), 1);
}

/// A commutative operation of a single-use shift and an immediate the
/// emit builds into a register takes the immediate into the shift's slot
/// and the shifted value as its own operand; an immediate the instruction
/// encodes, a shift read twice and a subtraction stay.
#[test]
fn a_materialized_immediate_takes_the_shifts_slot() {
    for (op, k) in [
        (BinOp::Or, 0x181c),
        (BinOp::Xor, 0x181c),
        (BinOp::And, 0x181c),
        (BinOp::Add, 0x1_2345_6789),
    ] {
        let func = build(|b, _, y| {
            let s = b.binop_imm(BinOp::Shl, y, 32);
            b.binop_imm(op, s, k)
        });
        let (fop, lhs, rhs, shift, amount) = fused(&func).expect("the reader folds");
        assert_eq!((fop, rhs, shift, amount), (op, 1, BinOp::Shl, 32), "{op:?}");
        assert!(
            matches!(func.insts[lhs as usize], Inst::Imm(v) if v == k),
            "{op:?}"
        );
    }
    let encoded = build(|b, _, y| {
        let s = b.binop_imm(BinOp::Shl, y, 32);
        b.binop_imm(BinOp::Or, s, 0xff)
    });
    assert_eq!(fused(&encoded), None);
    let twice = build(|b, _, y| {
        let s = b.binop_imm(BinOp::Shl, y, 32);
        let t = b.binop_imm(BinOp::Or, s, 0x181c);
        b.binop(BinOp::Add, t, s)
    });
    assert!(matches!(
        twice.insts[2],
        Inst::BinopI { op: BinOp::Shl, .. }
    ));
    let sub = build(|b, _, y| {
        let s = b.binop_imm(BinOp::Shl, y, 32);
        b.binop_imm(BinOp::Sub, s, 0x1_2345_6789)
    });
    assert_eq!(fused(&sub), None);
}

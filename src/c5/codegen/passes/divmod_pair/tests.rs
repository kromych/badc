//! Pairing a division with a modulo over the same operands. The SSA is
//! built through [`SsaBuilder`] with the split enabled, so these cover
//! the builder's shape and the contraction together.

use super::*;
use crate::c5::codegen::ssa::build::SsaBuilder;
use crate::c5::ir::LoadKind;

/// `(Div, Mod, Divu, Modu)` counts over the values that reach the
/// emit; a value nothing reads is dropped before it.
fn divmod_counts(func: &FunctionSsa) -> (usize, usize, usize, usize) {
    let counts = compute_use_counts(func);
    let mut n = (0, 0, 0, 0);
    for (v, inst) in func.insts.iter().enumerate() {
        if counts[v] == 0 {
            continue;
        }
        match inst {
            Inst::Binop { op: BinOp::Div, .. } => n.0 += 1,
            Inst::Binop { op: BinOp::Mod, .. } => n.1 += 1,
            Inst::Binop {
                op: BinOp::Divu, ..
            } => n.2 += 1,
            Inst::Binop {
                op: BinOp::Modu, ..
            } => n.3 += 1,
            _ => {}
        }
    }
    n
}

/// Two parameters, then `f(a, b)` over one block.
fn build<F>(body: F) -> FunctionSsa
where
    F: FnOnce(&mut SsaBuilder, ValueId, ValueId) -> ValueId,
{
    let mut b = SsaBuilder::new(0, 2, false);
    b.set_split_modulo(true);
    let a = b.load_local(2, LoadKind::I64);
    let d = b.load_local(3, LoadKind::I64);
    let out = body(&mut b, a, d);
    b.return_(out);
    let mut func = b.finish();
    run_one(&mut func);
    func
}

/// `a / b + a % b`: one divide feeds both halves.
#[test]
fn same_operands_share_one_divide() {
    let func = build(|b, a, d| {
        let q = b.binop(BinOp::Div, a, d);
        let r = b.binop(BinOp::Mod, a, d);
        b.binop(BinOp::Add, q, r)
    });
    assert_eq!(divmod_counts(&func), (1, 0, 0, 0));
}

/// Source order does not decide it: the modulo first still shares.
#[test]
fn modulo_first_shares_one_divide() {
    let func = build(|b, a, d| {
        let r = b.binop(BinOp::Mod, a, d);
        let q = b.binop(BinOp::Div, a, d);
        b.binop(BinOp::Add, q, r)
    });
    assert_eq!(divmod_counts(&func), (1, 0, 0, 0));
}

/// `a / b + b % a`: the operands differ, so neither is derivable from
/// the other and both keep their own divide.
#[test]
fn different_operands_keep_both() {
    let func = build(|b, a, d| {
        let q = b.binop(BinOp::Div, a, d);
        let r = b.binop(BinOp::Mod, d, a);
        b.binop(BinOp::Add, q, r)
    });
    assert_eq!(divmod_counts(&func), (1, 1, 0, 0));
}

/// A signed division does not supply an unsigned modulo's quotient.
#[test]
fn signedness_must_match() {
    let func = build(|b, a, d| {
        let q = b.binop(BinOp::Div, a, d);
        let r = b.binop(BinOp::Modu, a, d);
        b.binop(BinOp::Add, q, r)
    });
    assert_eq!(divmod_counts(&func), (1, 0, 0, 1));
}

/// The unsigned pair shares exactly as the signed one does.
#[test]
fn unsigned_pair_shares_one_divide() {
    let func = build(|b, a, d| {
        let q = b.binop(BinOp::Divu, a, d);
        let r = b.binop(BinOp::Modu, a, d);
        b.binop(BinOp::Add, q, r)
    });
    assert_eq!(divmod_counts(&func), (0, 0, 1, 0));
}

/// A modulo with no division to pair with folds back to one `Mod`:
/// both targets get the remainder out of a single divide instruction,
/// so the split would only add a multiply and a subtract.
#[test]
fn lone_modulo_folds_back() {
    let func = build(|b, a, d| b.binop(BinOp::Mod, a, d));
    assert_eq!(divmod_counts(&func), (0, 1, 0, 0));
    let counts = compute_use_counts(&func);
    assert!(
        func.insts
            .iter()
            .enumerate()
            .all(|(v, i)| !matches!(i, Inst::Binop { op: BinOp::Mul, .. }) || counts[v] == 0),
        "the folded multiply must be left unreferenced",
    );
}

/// A lone division is untouched: the split only ever runs on a modulo.
#[test]
fn lone_division_is_untouched() {
    let func = build(|b, a, d| b.binop(BinOp::Div, a, d));
    assert_eq!(divmod_counts(&func), (1, 0, 0, 0));
}

/// A constant divisor stays a whole modulo here -- `divmod_const`
/// strength-reduces it before the builder sees a `Binop`, and a zero
/// divisor is left to the hardware divide.
#[test]
fn immediate_divisor_is_not_split() {
    let func = build(|b, a, _| {
        let zero = b.imm(0);
        b.binop(BinOp::Mod, a, zero)
    });
    assert_eq!(divmod_counts(&func), (0, 1, 0, 0));
}

/// Inlining a constant into a divisor parameter leaves the divide with
/// its operand and the multiply with an immediate; the fold reads
/// through the immediate so the lone modulo still comes back whole.
#[test]
fn folded_immediate_divisor_still_folds_back() {
    let mut b = SsaBuilder::new(0, 1, false);
    let a = b.load_local(2, LoadKind::I64);
    let d = b.imm(7);
    let q = b.binop(BinOp::Div, a, d);
    let t = b.binop_imm(BinOp::Mul, q, 7);
    let r = b.binop(BinOp::Sub, a, t);
    b.return_(r);
    let mut func = b.finish();
    run_one(&mut func);
    assert_eq!(divmod_counts(&func), (0, 1, 0, 0));
}

/// A divide in a dominating block also runs where the subtract does
/// not, so folding it in would move a divide-by-zero trap. The pass
/// declines and both keep their own instruction.
#[test]
fn split_over_two_blocks_is_left_alone() {
    let mut b = SsaBuilder::new(0, 2, false);
    b.set_split_modulo(true);
    let a = b.load_local(2, LoadKind::I64);
    let d = b.load_local(3, LoadKind::I64);
    let q = b.binop(BinOp::Div, a, d);
    let t = b.binop(BinOp::Mul, q, d);
    let next = b.new_block();
    b.jmp(next);
    b.switch_to(next);
    let r = b.binop(BinOp::Sub, a, t);
    b.return_(r);
    let mut func = b.finish();
    run_one(&mut func);
    assert_eq!(divmod_counts(&func), (1, 0, 0, 0));
}

/// The split is off by default, so a build that never asks for it
/// emits the same single modulo it always did.
#[test]
fn split_is_opt_in() {
    let mut b = SsaBuilder::new(0, 2, false);
    let a = b.load_local(2, LoadKind::I64);
    let d = b.load_local(3, LoadKind::I64);
    let q = b.binop(BinOp::Div, a, d);
    let r = b.binop(BinOp::Mod, a, d);
    let sum = b.binop(BinOp::Add, q, r);
    b.return_(sum);
    let func = b.finish();
    assert_eq!(divmod_counts(&func), (1, 1, 0, 0));
}

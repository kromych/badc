//! Contraction of an integer multiply into the add / sub that reads
//! it. The SSA comes from [`SsaBuilder`], so the shapes are the ones
//! the front end actually produces.

use super::*;
use crate::c5::codegen::ssa::build::SsaBuilder;
use crate::c5::ir::LoadKind;

/// Three parameters, then `f(a, b, c)` over one block.
fn build<F>(body: F) -> FunctionSsa
where
    F: FnOnce(&mut SsaBuilder, ValueId, ValueId, ValueId) -> ValueId,
{
    let mut b = SsaBuilder::new(0, 3, false);
    let x = b.load_local(2, LoadKind::I64);
    let y = b.load_local(3, LoadKind::I64);
    let z = b.load_local(4, LoadKind::I64);
    let out = body(&mut b, x, y, z);
    b.return_(out);
    let mut func = b.finish();
    run(core::slice::from_mut(&mut func));
    func
}

/// The contracted node at `v`, if it is one.
fn fused(func: &FunctionSsa, v: ValueId) -> Option<(ValueId, ValueId, ValueId, bool)> {
    match func.insts[v as usize] {
        Inst::MulAdd {
            a,
            b,
            c,
            neg_product,
        } => Some((a, b, c, neg_product)),
        _ => None,
    }
}

/// Multiplies still reaching the emit: a contracted one is left
/// unreferenced and skipped there.
fn live_muls(func: &FunctionSsa) -> usize {
    let counts = compute_use_counts(func);
    func.insts
        .iter()
        .enumerate()
        .filter(|(v, inst)| counts[*v] > 0 && matches!(inst, Inst::Binop { op: BinOp::Mul, .. }))
        .count()
}

/// `c - a*b`: the subtract's left operand is the addend.
#[test]
fn subtract_of_a_product_contracts() {
    let func = build(|b, x, y, z| {
        let m = b.binop(BinOp::Mul, x, y);
        b.binop(BinOp::Sub, z, m)
    });
    let out = func.insts.len() as ValueId - 1;
    assert_eq!(fused(&func, out), Some((0, 1, 2, true)));
    assert_eq!(live_muls(&func), 0);
}

/// `a*b - c` is not `c - a*b`: no fused form subtracts the addend
/// from the product, so the pair stays.
#[test]
fn product_minus_addend_does_not_contract() {
    let func = build(|b, x, y, z| {
        let m = b.binop(BinOp::Mul, x, y);
        b.binop(BinOp::Sub, m, z)
    });
    let out = func.insts.len() as ValueId - 1;
    assert_eq!(fused(&func, out), None);
    assert_eq!(live_muls(&func), 1);
}

/// `a*b + c` and `c + a*b` both contract, and both name `c` as the
/// addend.
#[test]
fn add_contracts_in_either_operand_order() {
    for product_first in [true, false] {
        let func = build(|b, x, y, z| {
            let m = b.binop(BinOp::Mul, x, y);
            if product_first {
                b.binop(BinOp::Add, m, z)
            } else {
                b.binop(BinOp::Add, z, m)
            }
        });
        let out = func.insts.len() as ValueId - 1;
        assert_eq!(fused(&func, out), Some((0, 1, 2, false)));
        assert_eq!(live_muls(&func), 0);
    }
}

/// A product with a second reader must still be materialised, so it
/// does not contract.
#[test]
fn multi_use_product_stays() {
    let func = build(|b, x, y, z| {
        let m = b.binop(BinOp::Mul, x, y);
        let s = b.binop(BinOp::Sub, z, m);
        b.binop(BinOp::Xor, s, m)
    });
    assert!(func.insts.iter().all(|i| !matches!(i, Inst::MulAdd { .. })));
    assert_eq!(live_muls(&func), 1);
}

/// Each of two products feeding one add contracts once: the first
/// takes the fused node, the second stays as the addend it computes.
#[test]
fn two_products_under_one_add_contract_once() {
    let func = build(|b, x, y, z| {
        let m = b.binop(BinOp::Mul, x, y);
        let n = b.binop(BinOp::Mul, y, z);
        b.binop(BinOp::Add, m, n)
    });
    let out = func.insts.len() as ValueId - 1;
    let (a, bb, c, neg) = fused(&func, out).expect("the add contracts");
    assert_eq!((a, bb, neg), (0, 1, false));
    assert!(matches!(
        func.insts[c as usize],
        Inst::Binop {
            op: BinOp::Mul,
            lhs: 1,
            rhs: 2
        }
    ));
    assert_eq!(live_muls(&func), 1);
}

/// A remainder derived from a shared quotient (`n - q*d`) is the
/// shape the divide pairing leaves behind; it contracts.
#[test]
fn derived_remainder_contracts() {
    let func = build(|b, n, d, _z| {
        let q = b.binop(BinOp::Div, n, d);
        let t = b.binop(BinOp::Mul, q, d);
        let r = b.binop(BinOp::Sub, n, t);
        b.binop(BinOp::Add, q, r)
    });
    let rem = func
        .insts
        .iter()
        .position(|i| matches!(i, Inst::MulAdd { .. }))
        .expect("the remainder contracts");
    let (a, bb, c, neg) = fused(&func, rem as ValueId).unwrap();
    assert!(matches!(
        func.insts[a as usize],
        Inst::Binop { op: BinOp::Div, .. }
    ));
    assert_eq!((bb, c, neg), (1, 0, true));
    assert_eq!(live_muls(&func), 0);
}

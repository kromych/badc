//! Folding the shifts and the mask of a bit-field extract. The SSA comes
//! from [`SsaBuilder`].

use super::*;
use crate::c5::codegen::ssa::build::SsaBuilder;
use crate::c5::ir::LoadKind;

/// One parameter, then `f(x)` over one block, through the pass.
fn build<F>(body: F) -> FunctionSsa
where
    F: FnOnce(&mut SsaBuilder, ValueId) -> ValueId,
{
    let mut b = SsaBuilder::new(0, 1, false);
    let x = b.load_local(2, LoadKind::I64);
    let out = body(&mut b, x);
    b.return_(out);
    let mut func = b.finish();
    run(core::slice::from_mut(&mut func));
    func
}

/// The returned value as `(value, lsb, width, signed)` when it is a field.
fn field(func: &FunctionSsa) -> Option<(ValueId, u8, u8, bool)> {
    match func.insts[func.insts.len() - 1] {
        Inst::BitField {
            value,
            lsb,
            width,
            signed,
        } => Some((value, lsb, width, signed)),
        _ => None,
    }
}

/// Shifts and masks still reaching the emit: a folded one is left unread.
fn live_binops(func: &FunctionSsa) -> usize {
    let counts = compute_use_counts(func);
    func.insts
        .iter()
        .enumerate()
        .filter(|(v, inst)| counts[*v] > 0 && matches!(inst, Inst::BinopI { .. }))
        .count()
}

/// `(x << a) >> b` is the `64 - b`-bit field at `b - a`, signed for an
/// arithmetic shift, also when `a == b` and at the extreme amounts.
#[test]
fn a_shift_pair_is_one_field() {
    for (shr, signed) in [(BinOp::Shr, true), (BinOp::Shru, false)] {
        for (a, b, lsb, width) in [
            (42, 42, 0, 22),
            (20, 40, 20, 24),
            (1, 63, 62, 1),
            (63, 63, 0, 1),
        ] {
            let func = build(|bd, x| {
                let s = bd.binop_imm(BinOp::Shl, x, a);
                bd.binop_imm(shr, s, b)
            });
            assert_eq!(
                field(&func),
                Some((0, lsb, width, signed)),
                "{shr:?} {a} {b}"
            );
            assert_eq!(live_binops(&func), 0);
        }
    }
}

/// A right shift under a low mask is the zero-extended field the mask
/// keeps, and the whole shifted field when the mask reaches past it and
/// the shift fills with zeros.
#[test]
fn a_masked_right_shift_is_one_unsigned_field() {
    for (shr, p, mask, lsb, width) in [
        (BinOp::Shru, 7, 0x3ff, 7, 10),
        (BinOp::Shr, 22, 0x7f, 22, 7),
        (BinOp::Shr, 40, 0xf_ffff, 40, 20),
        (BinOp::Shru, 60, 0xff, 60, 4),
    ] {
        let func = build(|bd, x| {
            let s = bd.binop_imm(shr, x, p);
            bd.binop_imm(BinOp::And, s, mask)
        });
        assert_eq!(
            field(&func),
            Some((0, lsb, width, false)),
            "{shr:?} {p} {mask:#x}"
        );
    }
}

/// A field of a right shift whose bits all come from the shift's operand
/// reads that operand further up; the mask over a shift pair keeps the
/// pair's low bits.
#[test]
fn an_inner_right_shift_and_a_shift_pair_fold_in() {
    let func = build(|bd, x| {
        let r = bd.binop_imm(BinOp::Shr, x, 29);
        let s = bd.binop_imm(BinOp::Shl, r, 61);
        bd.binop_imm(BinOp::Shr, s, 61)
    });
    assert_eq!(field(&func), Some((0, 29, 3, true)));
    assert_eq!(live_binops(&func), 0);
    let func = build(|bd, x| {
        let s = bd.binop_imm(BinOp::Shl, x, 8);
        let r = bd.binop_imm(BinOp::Shr, s, 16);
        bd.binop_imm(BinOp::And, r, 0xff)
    });
    assert_eq!(field(&func), Some((0, 8, 8, false)));
}

/// Shapes that are no field, or that fold nothing in, stay: a left shift
/// with a second reader, a left shift past the right one, a lone right
/// shift, a mask that is not a low run of ones, a mask that keeps sign
/// bits of an arithmetic shift, and a field of a right shift that reaches
/// its fill.
#[test]
fn shapes_without_a_field_stay() {
    let shared = build(|bd, x| {
        let s = bd.binop_imm(BinOp::Shl, x, 8);
        let r = bd.binop_imm(BinOp::Shr, s, 8);
        bd.binop(BinOp::Add, r, s)
    });
    assert!(
        shared
            .insts
            .iter()
            .all(|i| !matches!(i, Inst::BitField { .. }))
    );
    let cases: [(BinOp, i64, BinOp, i64); 4] = [
        (BinOp::Shl, 20, BinOp::Shr, 10),
        (BinOp::Shru, 3, BinOp::And, 0xf0),
        (BinOp::Shr, 60, BinOp::And, 0xff),
        (BinOp::Shr, 0, BinOp::And, 0xff),
    ];
    for (inner, k, outer, m) in cases {
        let func = build(|bd, x| {
            let s = bd.binop_imm(inner, x, k);
            bd.binop_imm(outer, s, m)
        });
        assert_eq!(field(&func), None, "{inner:?} {k} {outer:?} {m:#x}");
    }
    let lone = build(|bd, x| bd.binop_imm(BinOp::Shr, x, 5));
    assert_eq!(field(&lone), None);
    let past = build(|bd, x| {
        let r = bd.binop_imm(BinOp::Shr, x, 48);
        let s = bd.binop_imm(BinOp::Shl, r, 24);
        bd.binop_imm(BinOp::Shr, s, 24)
    });
    assert_eq!(
        field(&past).map(|(v, ..)| v),
        Some(1),
        "the field stays on the shift"
    );
}

/// The node computes what the shifts did, every width at both ends.
#[test]
fn the_field_value_matches_the_shift_pair() {
    let x = 0x8123_4567_89ab_cdef_u64 as i64;
    for width in 1..64u8 {
        for lsb in [0, 64 - width] {
            let up = u32::from(64 - lsb - width);
            let down = u32::from(64 - width);
            let signed = x.wrapping_shl(up) >> down;
            let unsigned = ((x.wrapping_shl(up) as u64) >> down) as i64;
            assert_eq!(crate::c5::ir::eval_bit_field(x, lsb, width, true), signed);
            assert_eq!(
                crate::c5::ir::eval_bit_field(x, lsb, width, false),
                unsigned
            );
        }
    }
}

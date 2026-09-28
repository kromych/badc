//! The expansion over hand-built functions: which width it takes, that
//! no divide by a constant is left, and that the rewritten function
//! computes what the division did.

use super::*;
use crate::c5::ir::{Block, Terminator};
use crate::c5::vm::eval::{apply_binop, eval_extend};

/// One block over `insts`, returning the last value.
fn func(insts: Vec<Inst>) -> FunctionSsa {
    let n = insts.len();
    FunctionSsa {
        n_params: 1,
        inst_src: alloc::vec![(0, 0); n],
        f32_values: alloc::vec![false; n],
        insts,
        blocks: alloc::vec![Block {
            start_pc: 0,
            inst_range: 0..n as u32,
            terminator: Terminator::Return(n as ValueId - 1),
            exit_acc: n as ValueId - 1,
        }],
        ..FunctionSsa::default()
    }
}

fn returned(f: &FunctionSsa) -> ValueId {
    match f.blocks[0].terminator {
        Terminator::Return(r) => r,
        ref other => panic!("no return: {other:?}"),
    }
}

/// The value `f` returns for the 64-bit parameter `x`. `None` when a
/// divide traps.
fn returns(f: &FunctionSsa, x: i64) -> Option<i64> {
    let mut vals = alloc::vec![0i64; f.insts.len()];
    for v in f.blocks[0].inst_range.clone() {
        let v = v as usize;
        vals[v] = match f.insts[v] {
            Inst::ParamRef {
                kind: LoadKind::I64,
                ..
            } => x,
            Inst::Imm(k) => k,
            Inst::Extend { value, kind, .. } => eval_extend(vals[value as usize], kind),
            Inst::Binop { op, lhs, rhs } => {
                apply_binop(op, vals[lhs as usize], vals[rhs as usize]).ok()?
            }
            Inst::BinopI { op, lhs, rhs_imm } => {
                apply_binop(op, vals[lhs as usize], rhs_imm).ok()?
            }
            ref other => panic!("unexpected {other:?}"),
        };
    }
    Some(vals[returned(f) as usize])
}

fn has(f: &FunctionSsa, want: BinOp) -> bool {
    f.blocks[0].inst_range.clone().any(|v| {
        matches!(f.insts[v as usize],
            Inst::Binop { op, .. } | Inst::BinopI { op, .. } if op == want)
    })
}

/// Whether a divide by a nonzero constant is left, in either form.
fn divides_by_constant(f: &FunctionSsa) -> bool {
    f.insts.iter().any(|i| match *i {
        Inst::BinopI { op, .. } => is_divmod_op(op),
        Inst::Binop { op, rhs, .. } if is_divmod_op(op) => {
            matches!(f.insts[rhs as usize], Inst::Imm(k) if k != 0)
        }
        _ => false,
    })
}

const SAMPLES: [i64; 18] = [
    0,
    1,
    -1,
    9,
    10,
    -10,
    127,
    -128,
    255,
    256,
    i32::MAX as i64,
    i32::MIN as i64,
    u32::MAX as i64,
    1 << 32,
    i64::MAX,
    i64::MIN,
    0x1234_5678_9abc_def0,
    -0x1234_5678_9abc_def0,
];

/// How the dividend is derived from the 64-bit parameter `v0`: the
/// walker's own narrowing instructions, which the evaluator and the range
/// analysis read alike.
#[derive(Clone, Copy, Debug, PartialEq)]
enum Dividend {
    I64,
    I32,
    I8,
    U32,
    U8,
}

impl Dividend {
    fn inst(self) -> Inst {
        let extend = |kind| Inst::Extend {
            value: 0,
            kind,
            nsw: false,
        };
        let mask = |rhs_imm| Inst::BinopI {
            op: BinOp::And,
            lhs: 0,
            rhs_imm,
        };
        match self {
            Dividend::I64 => extend(LoadKind::I64),
            Dividend::I32 => extend(LoadKind::I32),
            Dividend::I8 => extend(LoadKind::I8),
            Dividend::U32 => mask(0xffff_ffff),
            Dividend::U8 => mask(0xff),
        }
    }
}

const PARAM: Inst = Inst::ParamRef {
    idx: 0,
    kind: LoadKind::I64,
};

/// `dividend(v0) op d` before and after the pass, over `SAMPLES`.
fn check(n: Dividend, op: BinOp, d: i64) -> FunctionSsa {
    let before = func(alloc::vec![
        PARAM,
        n.inst(),
        Inst::BinopI {
            op,
            lhs: 1,
            rhs_imm: d,
        },
    ]);
    let mut after = before.clone();
    run_one(&mut after, &[]);
    assert!(
        !divides_by_constant(&after),
        "{op:?} by {d}: {:?}",
        after.insts
    );
    for x in SAMPLES {
        // `i64::MIN / -1` traps in the evaluator and wraps in the expansion.
        if let Some(want) = returns(&before, x) {
            assert_eq!(returns(&after, x), Some(want), "{n:?} {x} {op:?} {d}");
        }
    }
    after
}

const OPS: [BinOp; 4] = [BinOp::Div, BinOp::Mod, BinOp::Divu, BinOp::Modu];

/// Every form is expanded and computes the division, whatever range the
/// dividend has: the width follows the range, never the other way.
#[test]
fn expansion_computes_the_division_at_every_dividend_range() {
    let divisors = [
        1,
        -1,
        2,
        -2,
        3,
        7,
        10,
        -10,
        16,
        255,
        256,
        1000,
        i32::MAX as i64,
        i32::MIN as i64,
        1 << 31,
        u32::MAX as i64,
        1 << 32,
        i64::MAX,
        i64::MIN,
    ];
    for n in [
        Dividend::I64,
        Dividend::I32,
        Dividend::U32,
        Dividend::I8,
        Dividend::U8,
    ] {
        for op in OPS {
            for d in divisors {
                check(n, op, d);
            }
        }
    }
}

/// A dividend extended from 32 bits takes the multiply of the 32-bit
/// reciprocal; one that is not takes the high multiply.
#[test]
fn width_follows_the_dividend_range() {
    for (n, op, narrow) in [
        (Dividend::I32, BinOp::Div, true),
        (Dividend::I64, BinOp::Div, false),
        (Dividend::U32, BinOp::Divu, true),
        // Sign-extended: its unsigned reading reaches 2^64 - 1.
        (Dividend::I32, BinOp::Divu, false),
        (Dividend::I64, BinOp::Modu, false),
        // Zero-extended, so non-negative: the unsigned 32-bit sequence.
        (Dividend::U32, BinOp::Mod, true),
        // Sign-extended from 8 bits under an unsigned reading: 64 bits.
        (Dividend::I8, BinOp::Modu, false),
    ] {
        let f = check(n, op, 10);
        let high = has(&f, BinOp::Mulh) || has(&f, BinOp::Mulhu);
        assert_eq!(!high, narrow, "{n:?} {op:?}: {:?}", f.insts);
    }
    // A divisor outside 32 bits is not one the 32-bit sequences take; the
    // dividend is below it, so nothing is computed at all.
    let f = check(Dividend::I32, BinOp::Div, 10_000_000_000);
    assert!(
        !has(&f, BinOp::Mul) && !has(&f, BinOp::Mulh),
        "{:?}",
        f.insts
    );
}

/// A dividend below the divisor in magnitude: the quotient is 0 and the
/// remainder is the dividend, with no arithmetic left.
#[test]
fn dividend_below_the_divisor_needs_no_arithmetic() {
    for (n, d) in [
        (Dividend::U8, 256),
        (Dividend::I8, -129),
        (Dividend::I8, 129),
    ] {
        for op in OPS {
            // The unsigned reading of an `I8` dividend is not below 129.
            if n == Dividend::I8 && !is_signed(op) {
                continue;
            }
            let f = check(n, op, d);
            let r = returned(&f);
            match op {
                BinOp::Div | BinOp::Divu => assert!(matches!(f.insts[r as usize], Inst::Imm(0))),
                _ => assert_eq!(r, 1, "the remainder is the dividend: {:?}", f.insts),
            }
        }
    }
    // `I8 % 128` is not the dividend at -128, nor `U8 % 255` at 255.
    let f = check(Dividend::I8, BinOp::Mod, 128);
    assert!(has(&f, BinOp::And), "{:?}", f.insts);
    let f = check(Dividend::U8, BinOp::Modu, 255);
    assert!(has(&f, BinOp::Mul), "{:?}", f.insts);
}

/// `x / 1` is `x`: the readers move to it, the exit value included, and
/// a division over the forwarded value reads `x` too.
#[test]
fn forwarded_quotient_redirects_every_reader() {
    let mut f = func(alloc::vec![
        PARAM,
        Inst::BinopI {
            op: BinOp::Div,
            lhs: 0,
            rhs_imm: 1,
        },
        Inst::BinopI {
            op: BinOp::Divu,
            lhs: 1,
            rhs_imm: 1,
        },
        Inst::BinopI {
            op: BinOp::Mod,
            lhs: 2,
            rhs_imm: 10,
        },
    ]);
    let before = f.clone();
    run_one(&mut f, &[]);
    assert!(!divides_by_constant(&f), "{:?}", f.insts);
    for x in SAMPLES {
        assert_eq!(returns(&f, x), returns(&before, x), "{x}");
    }
    let reads_param = f.insts.iter().any(|i| {
        matches!(
            i,
            Inst::Binop {
                op: BinOp::Mulh,
                lhs: 0,
                ..
            }
        )
    });
    assert!(reads_param, "{:?}", f.insts);
    // A forwarded value that is what the function returns.
    let mut g = func(alloc::vec![
        PARAM,
        Inst::BinopI {
            op: BinOp::Divu,
            lhs: 0,
            rhs_imm: 1,
        },
    ]);
    run_one(&mut g, &[]);
    assert_eq!((returned(&g), g.blocks[0].exit_acc), (0, 0));
}

/// A zero divisor is left to the hardware divide (C99 6.5.5p5): the
/// immediate form goes back to a register divisor, and the register form
/// stays.
#[test]
fn zero_divisor_keeps_the_divide() {
    for op in OPS {
        let mut f = func(alloc::vec![
            PARAM,
            Inst::BinopI {
                op,
                lhs: 0,
                rhs_imm: 0,
            },
        ]);
        run_one(&mut f, &[]);
        let Inst::Binop { op: got, lhs, rhs } = f.insts[returned(&f) as usize] else {
            panic!("{op:?}: {:?}", f.insts);
        };
        assert_eq!((got, lhs), (op, 0));
        assert!(matches!(f.insts[rhs as usize], Inst::Imm(0)));
        assert!(f.blocks[0].inst_range.contains(&rhs));
        assert_eq!(returns(&f, 5), None, "{op:?} by zero traps");

        let mut g = func(alloc::vec![
            PARAM,
            Inst::Imm(0),
            Inst::Binop { op, lhs: 0, rhs: 1 },
        ]);
        let before = alloc::format!("{:?}", g.insts);
        run_one(&mut g, &[]);
        assert_eq!(alloc::format!("{:?}", g.insts), before);
    }
}

/// A register divisor that is an `Imm` is a constant divisor too, and a
/// divisor that is no constant is not touched.
#[test]
fn register_form_with_an_immediate_divisor_is_expanded() {
    let mut f = func(alloc::vec![
        PARAM,
        Inst::Imm(10),
        Inst::Binop {
            op: BinOp::Mod,
            lhs: 0,
            rhs: 1,
        },
    ]);
    let before = f.clone();
    run_one(&mut f, &[]);
    assert!(!divides_by_constant(&f), "{:?}", f.insts);
    for x in SAMPLES {
        assert_eq!(returns(&f, x), returns(&before, x), "{x}");
    }
    let mut g = func(alloc::vec![
        PARAM,
        Inst::Extend {
            value: 0,
            kind: LoadKind::I8,
            nsw: false,
        },
        Inst::Binop {
            op: BinOp::Div,
            lhs: 0,
            rhs: 1,
        },
    ]);
    let n = g.insts.len();
    run_one(&mut g, &[]);
    assert_eq!(g.insts.len(), n);
    assert!(has(&g, BinOp::Div));
}

/// Several sites in one block: a later one's operands and the block's
/// range follow the earlier ones' insertions, and the parallel tables
/// stay as long as the tape.
#[test]
fn later_sites_follow_earlier_insertions() {
    let mut f = func(alloc::vec![
        PARAM,
        Inst::Extend {
            value: 0,
            kind: LoadKind::I32,
            nsw: false,
        },
        Inst::BinopI {
            op: BinOp::Mod,
            lhs: 1,
            rhs_imm: 10,
        },
        Inst::BinopI {
            op: BinOp::Div,
            lhs: 1,
            rhs_imm: 10,
        },
        Inst::Binop {
            op: BinOp::Add,
            lhs: 2,
            rhs: 3,
        },
        Inst::BinopI {
            op: BinOp::Divu,
            lhs: 4,
            rhs_imm: 7,
        },
    ]);
    let before = f.clone();
    run_one(&mut f, &[]);
    assert!(!divides_by_constant(&f), "{:?}", f.insts);
    assert_eq!(f.blocks[0].inst_range, 0..f.insts.len() as u32);
    assert_eq!(f.inst_src.len(), f.insts.len());
    assert_eq!(f.f32_values.len(), f.insts.len());
    for x in SAMPLES {
        assert_eq!(returns(&f, x), returns(&before, x), "{x}");
    }
}

fn count(f: &FunctionSsa, p: impl Fn(&Inst) -> bool) -> usize {
    f.blocks[0]
        .inst_range
        .clone()
        .filter(|&v| p(&f.insts[v as usize]))
        .count()
}

/// `n % 10` and `n / 10` in one block compute one quotient, in either
/// order, without the value numbering: the second site reads the first
/// one's instructions.
#[test]
fn sites_of_one_block_share_their_instructions() {
    for ops in [[BinOp::Mod, BinOp::Div], [BinOp::Div, BinOp::Mod]] {
        let mut f = func(alloc::vec![
            PARAM,
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32,
                nsw: false,
            },
            Inst::BinopI {
                op: ops[0],
                lhs: 1,
                rhs_imm: 10,
            },
            Inst::BinopI {
                op: ops[1],
                lhs: 1,
                rhs_imm: 10,
            },
            Inst::Binop {
                op: BinOp::Xor,
                lhs: 2,
                rhs: 3,
            },
        ]);
        let before = f.clone();
        run_one(&mut f, &[]);
        let reciprocal = |i: &Inst| {
            matches!(
                i,
                Inst::BinopI {
                    op: BinOp::Mul,
                    rhs_imm: 1_717_986_919,
                    ..
                }
            )
        };
        assert_eq!(count(&f, reciprocal), 1, "{ops:?}: {:?}", f.insts);
        // mul, shr, shru, add for the quotient; mul, sub for the remainder.
        let arithmetic = |i: &Inst| matches!(i, Inst::Binop { .. } | Inst::BinopI { .. });
        assert_eq!(count(&f, arithmetic), 6 + 1, "{ops:?}: {:?}", f.insts);
        for x in SAMPLES {
            assert_eq!(returns(&f, x), returns(&before, x), "{ops:?} {x}");
        }
    }
}

/// A signed division of a dividend that cannot be negative is the
/// unsigned one: no sign fix-up, a shift or a mask for a power of two,
/// and a multiplier sized by the dividend's bound. A dividend that can be
/// negative keeps the signed sequence.
#[test]
fn non_negative_dividend_takes_the_unsigned_sequence() {
    let arithmetic_shift = |i: &Inst| matches!(i, Inst::BinopI { op: BinOp::Shr, .. });
    // Less the dividend's own instruction where that is a mask.
    let steps = |f: &FunctionSsa, n: Dividend| {
        let arithmetic = |i: &Inst| matches!(i, Inst::Binop { .. } | Inst::BinopI { .. });
        count(f, arithmetic) - matches!(n, Dividend::U8 | Dividend::U32) as usize
    };
    for (op, d, want) in [
        (BinOp::Div, 10, 2),
        (BinOp::Mod, 10, 4),
        (BinOp::Div, 7, 2),
        (BinOp::Div, 8, 1),
        (BinOp::Mod, 8, 1),
    ] {
        let f = check(Dividend::U8, op, d);
        assert_eq!(steps(&f, Dividend::U8), want, "{op:?} {d}: {:?}", f.insts);
        assert_eq!(count(&f, arithmetic_shift), 0, "{op:?} {d}: {:?}", f.insts);
    }
    // Zero-extended from 32 bits: non-negative, as wide as the register
    // half, so 7 takes the add-back form there.
    let f = check(Dividend::U32, BinOp::Div, 7);
    assert_eq!(count(&f, arithmetic_shift), 0, "{:?}", f.insts);
    // A negative divisor or a dividend that can be negative: signed.
    let f = check(Dividend::U8, BinOp::Div, -10);
    assert_eq!(count(&f, arithmetic_shift), 1, "{:?}", f.insts);
    let f = check(Dividend::I8, BinOp::Div, 8);
    assert_eq!(steps(&f, Dividend::I8), 3, "{:?}", f.insts);
}

/// The interprocedural range of a parameter counts as its bound: a
/// parameter every call passes non-negative halves with one shift, and
/// the same body without that range keeps the bias.
#[test]
fn parameter_ranges_bound_the_dividend() {
    let body = || {
        func(alloc::vec![
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I32,
            },
            Inst::BinopI {
                op: BinOp::Div,
                lhs: 0,
                rhs_imm: 2,
            },
        ])
    };
    let bound = |k: i64| value_range::arg_range(&[Inst::Imm(k)], 0);
    let mut f = body();
    run_one(&mut f, &[bound(0).hull(bound(1000))]);
    assert!(
        matches!(
            f.insts[returned(&f) as usize],
            Inst::BinopI {
                op: BinOp::Shru,
                lhs: 0,
                rhs_imm: 1
            }
        ),
        "{:?}",
        f.insts
    );
    let mut g = body();
    run_one(&mut g, &[]);
    assert!(has(&g, BinOp::Add) && has(&g, BinOp::Shr), "{:?}", g.insts);
    // A range reaching below zero is no such bound.
    let mut h = body();
    run_one(&mut h, &[bound(-1).hull(bound(1000))]);
    assert!(has(&h, BinOp::Add) && has(&h, BinOp::Shr), "{:?}", h.insts);
}

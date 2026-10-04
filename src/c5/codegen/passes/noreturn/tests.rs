use super::*;
use crate::c5::ir::{BinOp, LoadKind, ValueId};
use alloc::vec;

fn call(target_pc: usize) -> Inst {
    Inst::Call {
        target_pc,
        args: Vec::new(),
        fixed_args: 0,
        fp_return: false,
        fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
        low_word_args: 0,
        arg_widths: crate::c5::ir::ArgWidths::default(),
        arg_aggs: Vec::new(),
        ret_agg: None,
        ret_slot_local: 0,
    }
}

fn block(range: core::ops::Range<u32>, terminator: Terminator) -> Block {
    Block {
        start_pc: 0,
        inst_range: range,
        terminator,
        exit_acc: NO_VALUE,
    }
}

fn func(ent_pc: usize, insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
    FunctionSsa {
        name: alloc::format!("f{ent_pc}"),
        ent_pc,
        inst_src: vec![(0, 0); insts.len()],
        f32_values: vec![false; insts.len()],
        insts,
        blocks,
        ..FunctionSsa::default()
    }
}

/// `long f(void) { return g() + 1; }` with `g` at `target`.
fn returns_call_plus_one(ent_pc: usize, target: usize) -> FunctionSsa {
    func(
        ent_pc,
        vec![
            call(target),
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 0,
                rhs_imm: 1,
            },
        ],
        vec![block(0..2, Terminator::Return(1))],
    )
}

/// A body whose only exit is the trap that seals a call to `target`.
fn sealed_call(ent_pc: usize, target: usize) -> FunctionSsa {
    func(
        ent_pc,
        vec![call(target)],
        vec![block(0..1, Terminator::Unreachable)],
    )
}

/// Callees known not to return: the entries `entries`, the parser symbols
/// `declared` and the `CallExt` bindings `bindings`.
fn known(entries: &[usize], declared: &[u32], bindings: &[i64]) -> Known {
    Known {
        declared: declared.iter().copied().collect(),
        bindings: bindings.iter().copied().collect(),
        entries: entries.iter().copied().collect(),
    }
}

fn sealed(f: &FunctionSsa) -> bool {
    f.blocks.len() == 1
        && f.blocks[0].terminator == Terminator::Unreachable
        && f.blocks[0].inst_range == (0..1)
}

#[test]
fn a_returned_call_to_a_noreturn_function_ends_its_block() {
    // `return exit_like() + 1;`: the add and the return are unreachable.
    let mut funcs = vec![returns_call_plus_one(10, 20)];
    seal_all(&mut funcs, known(&[20], &[], &[]), false);
    assert!(sealed(&funcs[0]), "{:?}", funcs[0].blocks);
    assert!(super::super::super::ssa::verify::check(&funcs[0]).is_ok());
}

#[test]
fn a_call_another_unit_defines_ends_its_block_by_its_declaration() {
    let mut f = returns_call_plus_one(10, 0);
    f.extern_call_refs = vec![(0, 3)];
    let mut funcs = vec![f];
    seal_all(&mut funcs, known(&[], &[3], &[]), false);
    assert!(sealed(&funcs[0]));
}

#[test]
fn a_library_binding_that_does_not_return_ends_its_block() {
    let mut f = returns_call_plus_one(10, 0);
    f.insts[0] = Inst::CallExt {
        binding_idx: 7,
        args: Vec::new(),
        fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
        low_word_args: 0,
        arg_widths: crate::c5::ir::ArgWidths::default(),
        fp_return: false,
        arg_aggs: Vec::new(),
        ret_agg: None,
        ret_slot_local: 0,
    };
    let mut funcs = vec![f];
    seal_all(&mut funcs, known(&[], &[], &[7]), false);
    assert!(sealed(&funcs[0]));
}

#[test]
fn a_chain_of_functions_no_path_of_which_returns_is_inferred() {
    // f30 -> f20 -> f10 -> `die` (declared): each caller's return is
    // unreachable once its callee is known not to return. Without the
    // inference only the declared call is sealed.
    let build = || {
        vec![
            sealed_call(10, 40),
            returns_call_plus_one(20, 10),
            returns_call_plus_one(30, 20),
        ]
    };
    let mut funcs = build();
    seal_all(&mut funcs, known(&[40], &[], &[]), true);
    assert!(funcs.iter().all(sealed), "{funcs:?}");
    let mut funcs = build();
    seal_all(&mut funcs, known(&[40], &[], &[]), false);
    assert!(!sealed(&funcs[1]) && !sealed(&funcs[2]));
}

#[test]
fn a_loop_with_no_exit_does_not_return() {
    // `void spin(void) { for (;;) ; }` and its caller.
    let spin = func(
        10,
        Vec::new(),
        vec![
            block(0..0, Terminator::Jmp(1)),
            block(0..0, Terminator::Jmp(1)),
        ],
    );
    let mut funcs = vec![spin, returns_call_plus_one(20, 10)];
    seal_all(&mut funcs, known(&[], &[], &[]), true);
    assert!(sealed(&funcs[1]));
}

#[test]
fn a_weak_or_naked_definition_is_not_inferred() {
    for weak in [true, false] {
        let mut f = sealed_call(10, 40);
        f.is_weak = weak;
        f.is_naked = !weak;
        let mut funcs = vec![f, returns_call_plus_one(20, 10)];
        seal_all(&mut funcs, known(&[40], &[], &[]), true);
        assert!(!sealed(&funcs[1]), "weak {weak}");
    }
}

#[test]
fn a_merge_past_the_sealed_call_keeps_its_other_incomes() {
    // b0: Bz c -> b2 / b1; b1: call die; v2 = 5; Jmp b3;
    // b2: v3 = 6; Jmp b3; b3: v4 = Phi[b1: v2, b2: v3]; Return v4.
    let insts = vec![
        Inst::ParamRef {
            idx: 0,
            kind: LoadKind::I64,
        },
        call(40),
        Inst::Imm(5),
        Inst::Imm(6),
        Inst::Phi {
            incoming: vec![(1, 2), (2, 3)],
            kind: LoadKind::I64,
        },
    ];
    let blocks = vec![
        block(
            0..1,
            Terminator::Bz {
                cond: 0,
                target: 2,
                fall_through: 1,
            },
        ),
        block(1..3, Terminator::Jmp(3)),
        block(3..4, Terminator::Jmp(3)),
        block(4..5, Terminator::Return(4)),
    ];
    let mut funcs = vec![func(10, insts, blocks)];
    seal_all(&mut funcs, known(&[40], &[], &[]), true);
    let f = &funcs[0];
    assert!(super::super::super::ssa::verify::check(f).is_ok(), "{f:?}");
    let phi = f
        .insts
        .iter()
        .find_map(|i| match i {
            Inst::Phi { incoming, .. } => Some(incoming.clone()),
            _ => None,
        })
        .unwrap();
    let v: Vec<ValueId> = phi.iter().map(|&(_, v)| v).collect();
    assert_eq!(v.len(), 1, "{phi:?}");
    assert!(matches!(f.insts[v[0] as usize], Inst::Imm(6)));
    assert!(
        f.blocks
            .iter()
            .any(|b| b.terminator == Terminator::Unreachable
                && matches!(
                    f.insts[b.inst_range.end as usize - 1],
                    Inst::Call { target_pc: 40, .. }
                )),
        "{:?}",
        f.blocks
    );
}

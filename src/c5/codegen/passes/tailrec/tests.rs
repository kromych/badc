use super::*;
use crate::c5::codegen::ssa::reg_alloc::for_each_operand;
use crate::c5::ir::{BinOp, StoreKind};

fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
    FunctionSsa {
        inst_src: vec![(0, 0); insts.len()],
        f32_values: vec![false; insts.len()],
        insts,
        blocks,
        n_params: 1,
        ..FunctionSsa::default()
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

/// Structural integrity: contiguous ranges cover the tape, every operand
/// resolves, and every phi's incoming covers exactly its predecessors.
fn assert_well_formed(f: &FunctionSsa) {
    let mut expect = 0u32;
    for b in &f.blocks {
        assert_eq!(b.inst_range.start, expect, "ranges must be contiguous");
        assert!(b.inst_range.end >= b.inst_range.start);
        expect = b.inst_range.end;
        match b.terminator {
            Terminator::Jmp(t) | Terminator::FallThrough(t) => {
                assert!((t as usize) < f.blocks.len())
            }
            Terminator::Bz {
                target,
                fall_through,
                ..
            }
            | Terminator::Bnz {
                target,
                fall_through,
                ..
            } => {
                assert!((target as usize) < f.blocks.len());
                assert!((fall_through as usize) < f.blocks.len());
            }
            _ => {}
        }
    }
    assert_eq!(expect as usize, f.insts.len(), "ranges must cover the tape");
    assert_eq!(f.inst_src.len(), f.insts.len());
    assert_eq!(f.f32_values.len(), f.insts.len());
    for inst in &f.insts {
        for_each_operand(inst, |v| {
            assert!(
                v != NO_VALUE && (v as usize) < f.insts.len(),
                "operand {v} out of range in {inst:?}"
            );
        });
    }
    // Each phi's incoming set is exactly the block's CFG predecessors.
    let preds = predecessors(f);
    for (bi, b) in f.blocks.iter().enumerate() {
        for pc in b.inst_range.clone() {
            if let Inst::Phi { incoming, .. } = &f.insts[pc as usize] {
                let mut got: Vec<BlockId> = incoming.iter().map(|&(p, _)| p).collect();
                got.sort_unstable();
                let mut want = preds[bi].clone();
                want.sort_unstable();
                assert_eq!(got, want, "phi v{pc} preds mismatch in b{bi}");
            }
        }
    }
}

fn predecessors(f: &FunctionSsa) -> Vec<Vec<BlockId>> {
    let mut preds = vec![Vec::new(); f.blocks.len()];
    for (i, b) in f.blocks.iter().enumerate() {
        let succ: Vec<BlockId> = match b.terminator {
            Terminator::Jmp(t) | Terminator::FallThrough(t) => vec![t],
            Terminator::Bz {
                target,
                fall_through,
                ..
            }
            | Terminator::Bnz {
                target,
                fall_through,
                ..
            } => vec![target, fall_through],
            _ => vec![],
        };
        for s in succ {
            preds[s as usize].push(i as BlockId);
        }
    }
    preds
}

/// The only conditional back edge is the header's; no block chains
/// through a run of unconditional jumps back to the header.
fn assert_single_backedge(f: &FunctionSsa, header: BlockId) {
    let preds = predecessors(f);
    // The header has the entry plus one edge per tail block; each such
    // predecessor jumps unconditionally to the header and to nothing else.
    for &p in &preds[header as usize] {
        if p == 0 {
            continue;
        }
        assert!(
            matches!(f.blocks[p as usize].terminator, Terminator::Jmp(h) if h == header),
            "tail predecessor b{p} must jump straight to the header",
        );
    }
    // No unconditional-jump chain: a Jmp block may not target another
    // Jmp block that targets the header (the regressing for(;;) shape).
    for b in &f.blocks {
        if let Terminator::Jmp(t) = b.terminator
            && t != header
            && let Terminator::Jmp(t2) = f.blocks[t as usize].terminator
            && t2 == header
        {
            panic!("unconditional-branch chain into the header");
        }
    }
}

/// `long f(long n) { if (n < 2) return n; return n + f(n - 1); }`
/// entry: v0 ParamRef; v1 lt(v0,2); Bz -> base / rec
/// base:  Return(v0)
/// rec:   v2 sub(v0,1); v3 Call(self,[v2]); v4 add(v0,v3); Return(v4)
fn accum_add_long() -> FunctionSsa {
    let mut f = func_with(
        vec![
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Lt,
                lhs: 0,
                rhs_imm: 2,
            },
            Inst::BinopI {
                op: BinOp::Sub,
                lhs: 0,
                rhs_imm: 1,
            },
            Inst::Call {
                target_pc: 0,
                args: vec![2],
                fixed_args: 1,
                fp_return: false,
                fp_arg_mask: 0,
                arg_aggs: Vec::new(),
                ret_agg: None,
                ret_slot_local: 0,
            },
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 3,
            },
        ],
        vec![
            block(
                0..2,
                Terminator::Bz {
                    cond: 1,
                    target: 1,
                    fall_through: 2,
                },
            ),
            block(2..2, Terminator::Return(0)),
            block(2..5, Terminator::Return(4)),
        ],
    );
    f.inst_src = vec![(0, 0); f.insts.len()];
    f.f32_values = vec![false; f.insts.len()];
    f
}

#[test]
fn accumulator_add_forms_a_loop_with_acc_phi() {
    let mut f = accum_add_long();
    run(core::slice::from_mut(&mut f));
    assert_well_formed(&f);
    let header = (f.blocks.len() - 1) as BlockId;
    // Entry jumps to the header; the recursive block jumps back to it.
    assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(h) if h == header));
    let phis: Vec<_> = f
        .insts
        .iter()
        .filter(|i| matches!(i, Inst::Phi { .. }))
        .collect();
    // One parameter phi plus the accumulator phi.
    assert_eq!(phis.len(), 2, "param phi + accumulator phi");
    // No self-call survives: the recursion is gone.
    assert!(
        !f.insts
            .iter()
            .any(|i| matches!(i, Inst::Call { target_pc: 0, .. })),
        "the self-call must be eliminated"
    );
    assert_single_backedge(&f, header);
}

#[test]
fn accumulator_add_backedge_reextends_narrow_param() {
    // Same shape but the parameter is `signed char` (I8): the back edge
    // must sign-extend the recursive argument to reproduce the entry
    // ParamRef's canonicalization on iterations past the first.
    let mut f = accum_add_long();
    f.insts[0] = Inst::ParamRef {
        idx: 0,
        kind: LoadKind::I8,
    };
    run(core::slice::from_mut(&mut f));
    assert_well_formed(&f);
    // A back-edge Extend{I8} of the recursive argument is present.
    assert!(
        f.insts.iter().any(|i| matches!(
            i,
            Inst::Extend {
                kind: LoadKind::I8,
                ..
            }
        )),
        "callee-narrows back-edge Extend must be present"
    );
}

#[test]
fn narrow_return_reextends_the_accumulator() {
    // `int f(int n){ if(n<2) return n; return (int)(n + f(n-1)); }`:
    // the return applies Extend{I32}, so the accumulator and base return
    // re-narrow with Extend{I32}.
    let mut f = accum_add_long();
    f.insts[0] = Inst::ParamRef {
        idx: 0,
        kind: LoadKind::I32,
    };
    // rec block: ... v4 add(v0,v3); v5 Extend(v4,I32); Return(v5)
    f.insts.push(Inst::Extend {
        value: 4,
        kind: LoadKind::I32,
    });
    f.inst_src.push((0, 0));
    f.f32_values.push(false);
    f.blocks[2].inst_range = 2..6;
    f.blocks[2].terminator = Terminator::Return(5);
    run(core::slice::from_mut(&mut f));
    assert_well_formed(&f);
    // Two I32 extends beyond the param back edge: the accumulator step and
    // the base return both re-narrow.
    let i32_extends = f
        .insts
        .iter()
        .filter(|i| {
            matches!(
                i,
                Inst::Extend {
                    kind: LoadKind::I32,
                    ..
                }
            )
        })
        .count();
    assert!(
        i32_extends >= 3,
        "param back edge + acc step + base return all narrow, got {i32_extends}",
    );
}

/// `void f(long n){ if(!n) return; g(); f(n-1); }` modelled as a void
/// helper whose returns are Imm(0): the last effectful op is the
/// self-call and the return is a constant.
fn const_void_tail() -> FunctionSsa {
    let mut f = func_with(
        vec![
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I64,
            },
            Inst::Imm(0), // base return value
            Inst::BinopI {
                op: BinOp::Sub,
                lhs: 0,
                rhs_imm: 1,
            },
            Inst::Call {
                target_pc: 0,
                args: vec![2],
                fixed_args: 1,
                fp_return: false,
                fp_arg_mask: 0,
                arg_aggs: Vec::new(),
                ret_agg: None,
                ret_slot_local: 0,
            },
            Inst::Imm(0), // tail return value
        ],
        vec![
            block(
                0..1,
                Terminator::Bnz {
                    cond: 0,
                    target: 2,
                    fall_through: 1,
                },
            ),
            block(1..2, Terminator::Return(1)),
            block(2..5, Terminator::Return(4)),
        ],
    );
    f.inst_src = vec![(0, 0); f.insts.len()];
    f.f32_values = vec![false; f.insts.len()];
    f
}

#[test]
fn const_void_tail_forms_a_loop_without_acc_phi() {
    let mut f = const_void_tail();
    run(core::slice::from_mut(&mut f));
    assert_well_formed(&f);
    let header = (f.blocks.len() - 1) as BlockId;
    assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(h) if h == header));
    // One parameter phi, no accumulator phi (constant tail).
    let phis = f
        .insts
        .iter()
        .filter(|i| matches!(i, Inst::Phi { .. }))
        .count();
    assert_eq!(phis, 1, "only the parameter phi");
    assert!(
        !f.insts
            .iter()
            .any(|i| matches!(i, Inst::Call { target_pc: 0, .. })),
    );
    assert_single_backedge(&f, header);
}

fn unchanged(f: &FunctionSsa) -> bool {
    let before = alloc::format!("{:?}", f.insts);
    let mut c = f.clone();
    run(core::slice::from_mut(&mut c));
    before == alloc::format!("{:?}", c.insts) && c.blocks.len() == f.blocks.len()
}

#[test]
fn variadic_is_rejected() {
    let mut f = accum_add_long();
    f.is_variadic = true;
    assert!(unchanged(&f));
}

#[test]
fn computed_goto_is_rejected() {
    let mut f = accum_add_long();
    f.computed_goto_targets = vec![2];
    assert!(unchanged(&f));
}

#[test]
fn fp_accumulator_is_rejected() {
    // An Fadd combine is not an associative integer op.
    let mut f = accum_add_long();
    f.insts[4] = Inst::Binop {
        op: BinOp::Fadd,
        lhs: 0,
        rhs: 3,
    };
    assert!(unchanged(&f));
}

#[test]
fn fp_param_is_rejected() {
    let mut f = accum_add_long();
    f.param_fp_mask = 1;
    assert!(unchanged(&f));
}

#[test]
fn address_taken_param_is_rejected() {
    // A LocalAddr anywhere keeps the body recursive: the slot the address
    // names is reused across loop iterations. Append a (dead) LocalAddr of
    // the parameter slot to the recursive block.
    let mut f = accum_add_long();
    f.insts.push(Inst::LocalAddr(2));
    f.inst_src.push((0, 0));
    f.f32_values.push(false);
    f.blocks[2].inst_range = 2..6;
    assert!(unchanged(&f));
}

#[test]
fn subtraction_combine_is_rejected() {
    // `return n - f(n-1)` is not associative; stay recursive.
    let mut f = accum_add_long();
    f.insts[4] = Inst::Binop {
        op: BinOp::Sub,
        lhs: 0,
        rhs: 3,
    };
    assert!(unchanged(&f));
}

#[test]
fn pure_value_tail_is_left_to_emit_conversion() {
    // `return f(n-1)` -- the return is the call value. This pass leaves
    // it for the emit-time jmp conversion.
    let mut f = func_with(
        vec![
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Lt,
                lhs: 0,
                rhs_imm: 2,
            },
            Inst::BinopI {
                op: BinOp::Sub,
                lhs: 0,
                rhs_imm: 1,
            },
            Inst::Call {
                target_pc: 0,
                args: vec![2],
                fixed_args: 1,
                fp_return: false,
                fp_arg_mask: 0,
                arg_aggs: Vec::new(),
                ret_agg: None,
                ret_slot_local: 0,
            },
        ],
        vec![
            block(
                0..2,
                Terminator::Bz {
                    cond: 1,
                    target: 1,
                    fall_through: 2,
                },
            ),
            block(2..2, Terminator::Return(0)),
            block(2..4, Terminator::Return(3)),
        ],
    );
    f.inst_src = vec![(0, 0); f.insts.len()];
    f.f32_values = vec![false; f.insts.len()];
    assert!(unchanged(&f));
}

#[test]
fn store_local_body_is_rejected() {
    // A slot store means unpromoted frame state; keep recursive.
    let mut f = accum_add_long();
    f.insts.push(Inst::StoreLocal {
        off: -1,
        value: 0,
        kind: StoreKind::I64,
        volatile: false,
    });
    f.inst_src.push((0, 0));
    f.f32_values.push(false);
    f.blocks[2].inst_range = 2..6;
    assert!(unchanged(&f));
}

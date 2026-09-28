//! Structural checks of a function's SSA after each pipeline pass, in
//! debug builds and under `--verify-ssa`. Block ranges lie within the
//! tape and share no instruction, and an empty block starts where no other
//! block continues. Branches name blocks and operands name instructions.
//! In a block the entry reaches, phis come first and take one value per
//! predecessor, defined at the end of that predecessor; every other read
//! is of a value defined earlier in the block or in a dominating block.
//! That rule also keeps the instructions of an emptied block, which the
//! passes leave in the tape, unread.

use alloc::format;
use alloc::string::String;

use super::super::ir::{BlockId, FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};
use super::mem2reg::{DomOrder, SuccGraph, dominators_of};

const NO_BLOCK: BlockId = BlockId::MAX;

/// Check every function `pass` left; panic naming the pass, the function
/// and the first violation.
pub(crate) fn after_pass(funcs: &[FunctionSsa], pass: &str) {
    for f in funcs {
        if let Err(e) = check(f) {
            panic!("ICE: SSA check after `{pass}`: `{}`: {e}", f.name);
        }
    }
}

/// The first violation of the SSA rules in `f`.
pub(crate) fn check(f: &FunctionSsa) -> Result<(), String> {
    let n = f.insts.len();
    let block_of = holders(f)?;
    let nb = f.blocks.len();
    let outside = |t: &BlockId| *t as usize >= nb;
    if let Some(t) = f.computed_goto_targets.iter().find(|t| outside(t)) {
        return Err(format!("a computed goto reaches block {t} of {nb}"));
    }
    for (b, blk) in f.blocks.iter().enumerate() {
        let bad_target = match blk.terminator {
            Terminator::Jmp(t) | Terminator::FallThrough(t) => outside(&t).then_some(t),
            Terminator::Bz {
                target,
                fall_through,
                ..
            }
            | Terminator::Bnz {
                target,
                fall_through,
                ..
            } => [target, fall_through].into_iter().find(|t| outside(t)),
            Terminator::JumpTable { table, .. } | Terminator::AsmGoto { table } => {
                let Some(targets) = f.jump_tables.get(table as usize) else {
                    return Err(format!(
                        "block {b} names jump table {table} of {}",
                        f.jump_tables.len()
                    ));
                };
                targets.iter().copied().find(|t| outside(t))
            }
            _ => None,
        };
        if let Some(t) = bad_target {
            return Err(format!("block {b} branches to block {t} of {nb}"));
        }
        let mut bad = None;
        let mut out_of_range = |v: ValueId| {
            if v != NO_VALUE && v as usize >= n && bad.is_none() {
                bad = Some(v);
            }
        };
        for pc in blk.inst_range.clone() {
            f.insts[pc as usize].for_each_operand(&mut out_of_range);
        }
        blk.terminator.for_each_operand(&mut out_of_range);
        out_of_range(blk.exit_acc);
        if let Some(v) = bad {
            return Err(format!("block {b} reads v{v} of a {n}-instruction tape"));
        }
    }
    let graph = SuccGraph::new(f);
    let idom = dominators_of(&graph);
    let dom = DomOrder::build(&idom);
    // Where `v` is not available to a read in block `b` ahead of `pc`
    // (the block's end for `None`).
    let unavailable = |v: ValueId, b: BlockId, pc: Option<u32>| -> Option<String> {
        let db = block_of[v as usize];
        if db == NO_BLOCK {
            Some(format!("v{v}, which no block holds"))
        } else if db == b {
            pc.filter(|&pc| v >= pc)
                .map(|_| format!("v{v}, defined later in block {b}"))
        } else if !dom.dominates(db, b, &idom) {
            Some(format!(
                "v{v} of block {db}, which does not dominate block {b}"
            ))
        } else {
            None
        }
    };
    for (b, blk) in f.blocks.iter().enumerate() {
        if idom[b] == NO_BLOCK {
            continue;
        }
        let b = b as BlockId;
        let mut past_phis = false;
        for pc in blk.inst_range.clone() {
            let inst = &f.insts[pc as usize];
            let Inst::Phi { incoming, .. } = inst else {
                past_phis = true;
                let mut first = None;
                inst.for_each_operand(|v| {
                    if v != NO_VALUE && first.is_none() {
                        first = unavailable(v, b, Some(pc));
                    }
                });
                if let Some(e) = first {
                    return Err(format!("v{pc} reads {e}"));
                }
                continue;
            };
            if past_phis {
                return Err(format!(
                    "phi v{pc} follows another instruction of block {b}"
                ));
            }
            let preds = graph.preds_of(b);
            for &(p, v) in incoming {
                if !preds.contains(&p) {
                    return Err(format!(
                        "phi v{pc} takes a value from block {p}, no predecessor of block {b}"
                    ));
                }
                if v != NO_VALUE
                    && idom[p as usize] != NO_BLOCK
                    && let Some(e) = unavailable(v, p, None)
                {
                    return Err(format!("phi v{pc} takes over the edge from block {p} {e}"));
                }
            }
            if let Some(p) = preds
                .iter()
                .find(|&&p| idom[p as usize] != NO_BLOCK && !incoming.iter().any(|&(q, _)| q == p))
            {
                return Err(format!(
                    "phi v{pc} takes no value from block {p}, a predecessor of block {b}"
                ));
            }
        }
        let mut first = None;
        let mut read = |v: ValueId| {
            if v != NO_VALUE && first.is_none() {
                first = unavailable(v, b, None);
            }
        };
        blk.terminator.for_each_operand(&mut read);
        read(blk.exit_acc);
        if let Some(e) = first {
            return Err(format!("block {b} ends reading {e}"));
        }
    }
    Ok(())
}

/// The block holding each instruction, `NO_BLOCK` for none, once the
/// ranges pass their own rules.
fn holders(f: &FunctionSsa) -> Result<alloc::vec::Vec<BlockId>, String> {
    let n = f.insts.len();
    let mut block_of = alloc::vec![NO_BLOCK; n];
    for (b, blk) in f.blocks.iter().enumerate() {
        let r = &blk.inst_range;
        if r.start > r.end || r.end as usize > n {
            return Err(format!("block {b} holds {r:?} of a {n}-instruction tape"));
        }
        for v in r.clone() {
            let holder = &mut block_of[v as usize];
            if *holder != NO_BLOCK {
                return Err(format!("blocks {} and {b} both hold v{v}", *holder));
            }
            *holder = b as BlockId;
        }
    }
    for (b, blk) in f.blocks.iter().enumerate() {
        let at = blk.inst_range.start as usize;
        if blk.inst_range.is_empty()
            && at > 0
            && at < n
            && block_of[at] != NO_BLOCK
            && block_of[at] == block_of[at - 1]
        {
            return Err(format!(
                "empty block {b} starts at v{at}, inside block {}",
                block_of[at]
            ));
        }
    }
    Ok(block_of)
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{Block, LoadKind};
    use super::*;

    fn func(insts: alloc::vec::Vec<Inst>, blocks: alloc::vec::Vec<Block>) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            name: "f".into(),
            inst_src: alloc::vec![(0, 0); n],
            f32_values: alloc::vec![false; n],
            insts,
            blocks,
            ..Default::default()
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

    fn add(lhs: ValueId, rhs: ValueId) -> Inst {
        Inst::Binop {
            op: super::super::super::ir::BinOp::Add,
            lhs,
            rhs,
        }
    }

    fn phi(incoming: alloc::vec::Vec<(BlockId, ValueId)>) -> Inst {
        Inst::Phi {
            incoming,
            kind: LoadKind::I64,
        }
    }

    fn fails(f: &FunctionSsa, what: &str) {
        let e = check(f).expect_err(what);
        assert!(e.contains(what), "{e}");
    }

    /// Branch on v0 to block 1 or 2, both of which join in block 3.
    fn diamond(join: alloc::vec::Vec<Inst>) -> FunctionSsa {
        let mut insts = alloc::vec![Inst::Imm(1), Inst::Imm(2), Inst::Imm(3)];
        let n = insts.len() as u32 + join.len() as u32;
        insts.extend(join);
        func(
            insts,
            alloc::vec![
                block(
                    0..1,
                    Terminator::Bz {
                        cond: 0,
                        target: 2,
                        fall_through: 1,
                    }
                ),
                block(1..2, Terminator::Jmp(3)),
                block(2..3, Terminator::Jmp(3)),
                block(3..n, Terminator::Return(n - 1)),
            ],
        )
    }

    #[test]
    fn a_well_formed_diamond_passes() {
        let f = diamond(alloc::vec![phi(alloc::vec![(1, 1), (2, 2)]), add(3, 0)]);
        assert_eq!(check(&f), Ok(()));
    }

    #[test]
    fn a_read_ahead_of_its_definition_fails() {
        let f = func(
            alloc::vec![add(1, 1), Inst::Imm(4)],
            alloc::vec![block(0..2, Terminator::Return(0))],
        );
        fails(&f, "v0 reads v1, defined later in block 0");
    }

    #[test]
    fn a_read_from_a_block_that_does_not_dominate_fails() {
        let f = diamond(alloc::vec![add(1, 0)]);
        fails(&f, "v1 of block 1, which does not dominate block 3");
    }

    #[test]
    fn a_read_of_an_instruction_no_block_holds_fails() {
        let f = func(
            alloc::vec![Inst::Imm(4), add(0, 0)],
            alloc::vec![block(1..2, Terminator::Return(1))],
        );
        fails(&f, "v0, which no block holds");
    }

    #[test]
    fn a_phi_from_a_block_that_is_no_predecessor_fails() {
        let f = diamond(alloc::vec![phi(alloc::vec![(1, 1), (0, 0)])]);
        fails(&f, "takes a value from block 0, no predecessor of block 3");
    }

    #[test]
    fn a_phi_missing_a_predecessor_fails() {
        let f = diamond(alloc::vec![phi(alloc::vec![(1, 1)])]);
        fails(&f, "takes no value from block 2");
    }

    #[test]
    fn a_phi_value_undefined_at_its_edge_fails() {
        let f = diamond(alloc::vec![phi(alloc::vec![(1, 2), (2, 2)])]);
        fails(&f, "over the edge from block 1 v2 of block 2");
    }

    #[test]
    fn a_phi_after_another_instruction_fails() {
        let f = diamond(alloc::vec![add(0, 0), phi(alloc::vec![(1, 1), (2, 2)])]);
        fails(&f, "phi v4 follows another instruction of block 3");
    }

    #[test]
    fn overlapping_ranges_fail() {
        let f = func(
            alloc::vec![Inst::Imm(1), Inst::Imm(2)],
            alloc::vec![
                block(0..2, Terminator::Jmp(1)),
                block(1..2, Terminator::Return(1)),
            ],
        );
        fails(&f, "blocks 0 and 1 both hold v1");
    }

    #[test]
    fn an_empty_block_inside_another_fails() {
        let f = func(
            alloc::vec![Inst::Imm(1), Inst::Imm(2)],
            alloc::vec![
                block(0..2, Terminator::Jmp(1)),
                block(1..1, Terminator::Return(NO_VALUE)),
            ],
        );
        fails(&f, "empty block 1 starts at v1, inside block 0");
    }

    #[test]
    fn a_range_past_the_tape_fails() {
        let f = func(
            alloc::vec![Inst::Imm(1)],
            alloc::vec![block(0..2, Terminator::Return(0))],
        );
        fails(&f, "block 0 holds 0..2 of a 1-instruction tape");
    }

    #[test]
    fn a_branch_past_the_last_block_fails() {
        let f = func(
            alloc::vec![Inst::Imm(1)],
            alloc::vec![block(0..1, Terminator::Jmp(5))],
        );
        fails(&f, "block 0 branches to block 5 of 1");
    }

    #[test]
    #[should_panic(expected = "SSA check after `some::pass`: `f`: v0 reads v1")]
    fn a_failed_check_names_the_pass_and_the_function() {
        let f = func(
            alloc::vec![add(1, 1), Inst::Imm(4)],
            alloc::vec![block(0..2, Terminator::Return(0))],
        );
        after_pass(&[f], "some::pass");
    }

    /// The pipeline's output passes the checks on both architectures
    /// when a release build asks for them.
    #[test]
    fn the_optimized_pipeline_passes_under_the_flag() {
        let src = "struct P { long a, b; };\n\
            static long get(struct P *p, int i) { return i & 1 ? p->a : p->b; }\n\
            long run(long n) { struct P p[1] = {{ n, 2 }}; long s = 0;\n\
            for (int i = 0; i < n; i++) { switch (i % 3) { case 0: s += get(p, i); break;\n\
            case 1: s -= i; break; default: if (s > 9) goto out; } }\n\
            out: return s; }\n";
        for target in [crate::Target::LinuxX64, crate::Target::LinuxAarch64] {
            let opts = crate::CompileOptions::default()
                .with_no_entry_point(true)
                .with_optimize(true);
            let program = crate::Compiler::with_options(String::from(src), target, opts)
                .compile()
                .expect("compile");
            let native = crate::NativeOptions {
                output_kind: crate::OutputKind::Relocatable,
                ..crate::NativeOptions::new()
                    .with_optimize()
                    .with_verify_ssa()
            };
            crate::c5::codegen::lower_for(&program, target, native).expect("lower");
        }
    }
}

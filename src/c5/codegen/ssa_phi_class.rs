//! Phi-congruence classes for the SSA register allocator.
//!
//! Each phi joins its result with its incoming sources. The register
//! allocator places every member of a congruence class in one
//! location, so the predecessor-exit move that lowers the phi becomes
//! a self-move and is dropped. A class may hold a value only if no two
//! members are simultaneously live -- otherwise one member's emit
//! would overwrite a value another member still needs.
//!
//! Construction follows the out-of-SSA coalescing of Boissinot et al.:
//! start with every value in its own class, then for each phi attempt
//! to merge the result's class with each operand's class, allowing the
//! merge only when no member of one class interferes with any member of
//! the other. The interference test is the value-liveness query in
//! [`super::ssa_liveness`]. An operand whose class cannot merge keeps
//! its own location, and the per-arch emit materialises it with a real
//! move on the phi's predecessor edge.
//!
//! Output is consumed by `ssa_alloc::allocate`, which indexes its
//! per-class `places` table through `find`.

use alloc::vec::Vec;

use super::super::ir::{FunctionSsa, Inst, NO_VALUE, ValueId};
use super::ssa_liveness::Liveness;

/// Union-find over `ValueId`s. Two values share a class when a chain
/// of non-interfering phi merges connects them.
#[derive(Debug, Clone)]
#[allow(dead_code)]
pub(super) struct PhiClasses {
    /// Parent pointer per value. `parent[v] == v` marks `v` as a root.
    parent: Vec<ValueId>,
}

#[allow(dead_code)]
impl PhiClasses {
    /// Build phi-congruence classes for `func` under the interference
    /// relation in `live`. Each phi result is merged with each of its
    /// operands when, and only when, the combined class stays
    /// interference-free. Processing preserves the invariant that every
    /// class is internally interference-free, so the allocator may
    /// assign one location per class.
    pub(super) fn build(func: &FunctionSsa, live: &Liveness) -> Self {
        let n = func.insts.len();
        let mut classes = Self {
            parent: (0..n as ValueId).collect(),
        };
        // Per-root member lists. A value's list is meaningful only when
        // it is a root; a non-root's list is emptied into its new root
        // on merge.
        let mut members: Vec<Vec<ValueId>> = (0..n as ValueId).map(|v| alloc::vec![v]).collect();

        for idx in 0..n {
            let Inst::Phi { incoming, .. } = &func.insts[idx] else {
                continue;
            };
            // Collect operands first so the borrow of `func.insts` ends
            // before the merge loop mutates nothing in `func` but keeps
            // the borrow checker satisfied.
            let operands: Vec<ValueId> = incoming
                .iter()
                .map(|(_, s)| *s)
                .filter(|s| *s != NO_VALUE && (*s as usize) < n)
                .collect();
            for src in operands {
                let rr = classes.find(idx as ValueId);
                let rs = classes.find(src);
                if rr == rs {
                    continue;
                }
                // Never coalesce two values whose register class differs:
                // the allocator places every class member in one physical
                // location, and an FP value and an integer value cannot
                // share a register or a slot's classification. An FP phi's
                // operands are FP, so this normally never fires, but it
                // guards against an FP-classed operand merging with an
                // integer-classed one (a class-crossing location share).
                if super::ssa_alloc::produces_fp_result(&func.insts[idx])
                    != super::ssa_alloc::produces_fp_result(&func.insts[src as usize])
                {
                    continue;
                }
                if classes_interfere(func, live, &members[rr as usize], &members[rs as usize]) {
                    continue;
                }
                // Attach the smaller member list to the larger to keep
                // the union-find shallow. The retained root owns the
                // combined member list.
                let (keep, drop) = if members[rr as usize].len() >= members[rs as usize].len() {
                    (rr, rs)
                } else {
                    (rs, rr)
                };
                let moved = core::mem::take(&mut members[drop as usize]);
                members[keep as usize].extend(moved);
                classes.parent[drop as usize] = keep;
            }
        }
        classes
    }

    /// Find the root of `v`'s class, compressing the path on the way.
    /// Iterative to avoid recursion overflow on deeply chained phis.
    pub(super) fn find(&mut self, v: ValueId) -> ValueId {
        let mut cur = v;
        while self.parent[cur as usize] != cur {
            cur = self.parent[cur as usize];
        }
        let root = cur;
        cur = v;
        while self.parent[cur as usize] != cur {
            let next = self.parent[cur as usize];
            self.parent[cur as usize] = root;
            cur = next;
        }
        root
    }

    /// Number of values the union-find tracks. Equals
    /// `func.insts.len()` at construction time.
    pub(super) fn len(&self) -> usize {
        self.parent.len()
    }
}

/// Whether any member of `a` interferes with any member of `b`.
fn classes_interfere(func: &FunctionSsa, live: &Liveness, a: &[ValueId], b: &[ValueId]) -> bool {
    for &x in a {
        for &y in b {
            if live.interfere(func, x, y) {
                return true;
            }
        }
    }
    false
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{Block, FunctionSsa, LoadKind, Terminator};
    use super::*;
    use alloc::string::String;
    use alloc::vec;

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            name: String::new(),
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
            insts,
            blocks,
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    #[test]
    fn every_value_is_its_own_singleton_class_when_no_phi() {
        // b0: v0=Imm(7), v1=Imm(11); return v1.
        let insts = vec![Inst::Imm(7), Inst::Imm(11)];
        let blocks = vec![Block {
            start_pc: 0,
            inst_range: 0..2,
            terminator: Terminator::Return(1),
            exit_acc: 1,
        }];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        let mut classes = PhiClasses::build(&func, &live);
        assert_eq!(classes.find(0), 0);
        assert_eq!(classes.find(1), 1);
    }

    #[test]
    fn diamond_phi_merges_non_interfering_operands_with_result() {
        // b0: v0=Imm(0); Bz v0 -> b1 else b2
        // b1: v1=Imm(1); Jmp b3
        // b2: v2=Imm(2); Jmp b3
        // b3: v3=Phi[b1:v1, b2:v2]; Return v3
        // v1 dies on the b1->b3 edge, v2 on the b2->b3 edge; neither
        // interferes with v3, so all three join one class.
        let insts = vec![
            Inst::Imm(0),
            Inst::Imm(1),
            Inst::Imm(2),
            Inst::Phi {
                incoming: vec![(1, 1), (2, 2)],
                kind: LoadKind::I64,
            },
        ];
        let blocks = vec![
            Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Bz {
                    cond: 0,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 0,
            },
            Block {
                start_pc: 0,
                inst_range: 1..2,
                terminator: Terminator::Jmp(3),
                exit_acc: 1,
            },
            Block {
                start_pc: 0,
                inst_range: 2..3,
                terminator: Terminator::Jmp(3),
                exit_acc: 2,
            },
            Block {
                start_pc: 0,
                inst_range: 3..4,
                terminator: Terminator::Return(3),
                exit_acc: 3,
            },
        ];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        let mut classes = PhiClasses::build(&func, &live);
        let root = classes.find(3);
        assert_eq!(classes.find(1), root, "v1 operand must join the phi class");
        assert_eq!(classes.find(2), root, "v2 operand must join the phi class");
    }

    #[test]
    fn class_differing_operand_is_not_coalesced() {
        // b0: v0=Imm(0); Bz v0 -> b1 else b2
        // b1: v1=Fneg(...)  (FP-classed); Jmp b3
        // b2: v2=Imm(2)     (integer-classed); Jmp b3
        // b3: v3=Phi[b1:v1, b2:v2] kind F64 (FP-classed); Return v3
        // v1 and v2 both die on their edge and neither interferes with
        // v3, but v2 is integer-classed while the phi is FP-classed: the
        // class guard must keep v2 in its own singleton class even though
        // the interference test would otherwise allow the merge.
        let insts = vec![
            Inst::Imm(0),
            Inst::Fneg(0),
            Inst::Imm(2),
            Inst::Phi {
                incoming: vec![(1, 1), (2, 2)],
                kind: LoadKind::F64,
            },
        ];
        let blocks = vec![
            Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Bz {
                    cond: 0,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 0,
            },
            Block {
                start_pc: 0,
                inst_range: 1..2,
                terminator: Terminator::Jmp(3),
                exit_acc: 1,
            },
            Block {
                start_pc: 0,
                inst_range: 2..3,
                terminator: Terminator::Jmp(3),
                exit_acc: 2,
            },
            Block {
                start_pc: 0,
                inst_range: 3..4,
                terminator: Terminator::Return(3),
                exit_acc: 3,
            },
        ];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        let mut classes = PhiClasses::build(&func, &live);
        let root = classes.find(3);
        // The FP-classed operand v1 joins the FP phi class.
        assert_eq!(
            classes.find(1),
            root,
            "FP operand v1 must join the phi class"
        );
        // The integer-classed operand v2 must stay in its own class.
        assert_ne!(
            classes.find(2),
            root,
            "integer operand v2 must not coalesce with an FP phi"
        );
    }

    #[test]
    fn interfering_operand_stays_out_of_the_phi_class() {
        // b0: v0=Imm(0); Jmp b1
        // b1: v1=Phi[b0:v0, b1:v2]; v2=BinopI add v1,1; v3=Binop add v1,v2
        //     ; Bz v3 -> b1 else b2     (v1 used after v2's def -> they
        //     interfere; the back-edge operand v2 must NOT join v1)
        // b2: Return v1
        use super::super::super::ir::BinOp;
        let insts = vec![
            Inst::Imm(0),
            Inst::Phi {
                incoming: vec![(0, 0), (1, 2)],
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 1,
                rhs_imm: 1,
            },
            Inst::Binop {
                op: BinOp::Add,
                lhs: 1,
                rhs: 2,
            },
        ];
        let blocks = vec![
            Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Jmp(1),
                exit_acc: 0,
            },
            Block {
                start_pc: 0,
                inst_range: 1..4,
                terminator: Terminator::Bz {
                    cond: 3,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 3,
            },
            Block {
                start_pc: 0,
                inst_range: 4..4,
                terminator: Terminator::Return(1),
                exit_acc: 1,
            },
        ];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        let mut classes = PhiClasses::build(&func, &live);
        // v1 is live past v2's definition (v3 reads both), so v1 and
        // v2 interfere and must occupy distinct classes.
        assert_ne!(
            classes.find(1),
            classes.find(2),
            "interfering back-edge operand must not coalesce with the phi result"
        );
        // The init operand v0 dies into the phi and does join.
        assert_eq!(classes.find(0), classes.find(1));
    }

    #[test]
    fn no_congruence_class_contains_interfering_values() {
        // Two loops chained through one Imm(0): the first loop's phi
        // reads it on the entry edge, and the constant is also the
        // entry value of the second loop's phi (incoming b1:v0), so it
        // stays live across the first loop. The builder must never put
        // two simultaneously-live values in one class regardless of
        // merge order; verify the invariant directly.
        use super::super::super::ir::BinOp;
        // b0: v0=Imm(0); Jmp b1
        // b1: v1=Phi[b0:v0, b1:v2]; v2=BinopI add v1,1; Bz v2 -> b2 else b1
        // b2: v3=Phi[b1:v0, b2:v4]; v4=BinopI add v3,1; Bz v4 -> b3 else b2
        // b3: Return v3
        let insts = vec![
            Inst::Imm(0),
            Inst::Phi {
                incoming: vec![(0, 0), (1, 2)],
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 1,
                rhs_imm: 1,
            },
            Inst::Phi {
                incoming: vec![(1, 0), (2, 4)],
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 3,
                rhs_imm: 1,
            },
        ];
        let blocks = vec![
            Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Jmp(1),
                exit_acc: 0,
            },
            Block {
                start_pc: 0,
                inst_range: 1..3,
                terminator: Terminator::Bz {
                    cond: 2,
                    target: 2,
                    fall_through: 1,
                },
                exit_acc: 2,
            },
            Block {
                start_pc: 0,
                inst_range: 3..5,
                terminator: Terminator::Bz {
                    cond: 4,
                    target: 3,
                    fall_through: 2,
                },
                exit_acc: 4,
            },
            Block {
                start_pc: 0,
                inst_range: 5..5,
                terminator: Terminator::Return(3),
                exit_acc: 3,
            },
        ];
        let func = func_with(insts, blocks);
        let live = Liveness::compute(&func);
        let mut classes = PhiClasses::build(&func, &live);
        // Core invariant: every congruence class is interference-free.
        let n = func.insts.len();
        for a in 0..n as ValueId {
            for b in (a + 1)..n as ValueId {
                if classes.find(a) == classes.find(b) {
                    assert!(
                        !live.interfere(&func, a, b),
                        "v{a} and v{b} interfere yet share a congruence class"
                    );
                }
            }
        }
        // The constant is live across the first phi (the second loop
        // reads it), so it must not coalesce with that phi.
        assert_ne!(
            classes.find(0),
            classes.find(1),
            "a value live past the phi must not coalesce with it"
        );
    }
}

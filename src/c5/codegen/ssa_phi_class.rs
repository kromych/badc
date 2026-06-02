//! Phi-class union-find for the SSA register allocator.
//!
//! Each phi instruction joins its result with every incoming source
//! into a single equivalence class. The register allocator must place
//! every member of a class in the same physical location, since the
//! per-arch emit lowers `Inst::Phi` to a predecessor-exit move from
//! source to result -- a self-mov when source and result share a
//! register, which `schedule_int_reg_moves` drops.
//!
//! The classes are computed once per function before allocation. The
//! `find` operation walks parent pointers with path compression; the
//! `union` step runs over every `Inst::Phi` and merges the phi result
//! with each incoming source. Path compression alone keeps the amortised
//! cost near constant per call; no rank heuristic is needed for SSA
//! shapes observed in practice (a function rarely has more than a
//! few hundred phi classes).
//!
//! Output is consumed by `ssa_alloc::allocate`, which indexes its
//! per-class `places` table through `find`.

use alloc::vec::Vec;

use super::super::ir::{FunctionSsa, Inst, NO_VALUE, ValueId};

/// Union-find over `ValueId`s. Two values are in the same class if
/// they appear together as the result and an incoming source of any
/// `Inst::Phi` in the function (transitive closure).
#[derive(Debug, Clone)]
#[allow(dead_code)]
pub(super) struct PhiClasses {
    /// Parent pointer per value. `parent[v] == v` marks `v` as the
    /// root of its class.
    parent: Vec<ValueId>,
}

#[allow(dead_code)]
impl PhiClasses {
    /// Build the union-find from `func`. Every value starts as its
    /// own singleton class; each phi instruction unions the result
    /// with every incoming source, transitively merging chains of
    /// phis through their shared participants.
    pub(super) fn from_func(func: &FunctionSsa) -> Self {
        let n = func.insts.len();
        let mut classes = Self {
            parent: (0..n as ValueId).collect(),
        };
        for (idx, inst) in func.insts.iter().enumerate() {
            let Inst::Phi { incoming, .. } = inst else {
                continue;
            };
            let phi_root = classes.find(idx as ValueId);
            for (_, src) in incoming {
                if *src == NO_VALUE || (*src as usize) >= n {
                    continue;
                }
                let src_root = classes.find(*src);
                if src_root != phi_root {
                    // Make phi_root the parent of src_root. The order
                    // is arbitrary for correctness; picking phi_root
                    // keeps the root closer to the phi PC so a later
                    // `find` from a phi member's pick site walks a
                    // shorter path before compression kicks in.
                    classes.parent[src_root as usize] = phi_root;
                }
            }
        }
        classes
    }

    /// Find the root of `v`'s class, compressing the path on the way.
    /// Iterative to avoid recursion overflow on deeply chained phis.
    pub(super) fn find(&mut self, v: ValueId) -> ValueId {
        // Two-pass: walk to the root, then re-walk with assignment.
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

#[cfg(test)]
mod tests {
    use super::*;
    use super::super::super::ir::{Block, FunctionSsa, LoadKind, Terminator};
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
        let insts = vec![Inst::Imm(7), Inst::Imm(11)];
        let blocks = vec![Block {
            start_pc: 0,
            inst_range: 0..2,
            terminator: Terminator::Return(1),
            exit_acc: 1,
        }];
        let func = func_with(insts, blocks);
        let mut classes = PhiClasses::from_func(&func);
        assert_eq!(classes.find(0), 0);
        assert_eq!(classes.find(1), 1);
    }

    #[test]
    fn phi_result_and_all_incoming_sources_share_one_class() {
        // v0 = Imm(0)
        // v1 = Imm(1)
        // v2 = Phi { incoming = [(0, v0), (1, v1)], kind = I64 }
        let insts = vec![
            Inst::Imm(0),
            Inst::Imm(1),
            Inst::Phi {
                incoming: vec![(0, 0), (1, 1)],
                kind: LoadKind::I64,
            },
        ];
        let blocks = vec![Block {
            start_pc: 0,
            inst_range: 0..3,
            terminator: Terminator::Return(2),
            exit_acc: 2,
        }];
        let func = func_with(insts, blocks);
        let mut classes = PhiClasses::from_func(&func);
        let root = classes.find(2);
        assert_eq!(classes.find(0), root);
        assert_eq!(classes.find(1), root);
    }

    #[test]
    fn chain_of_phis_merges_into_a_single_class() {
        // v0 = Imm(0)
        // v1 = Imm(1)
        // v2 = Phi(v0, v1)
        // v3 = Phi(v0, v2)  -- pulls v2's class in via the v2 incoming
        let insts = vec![
            Inst::Imm(0),
            Inst::Imm(1),
            Inst::Phi {
                incoming: vec![(0, 0), (1, 1)],
                kind: LoadKind::I64,
            },
            Inst::Phi {
                incoming: vec![(0, 0), (2, 2)],
                kind: LoadKind::I64,
            },
        ];
        let blocks = vec![Block {
            start_pc: 0,
            inst_range: 0..4,
            terminator: Terminator::Return(3),
            exit_acc: 3,
        }];
        let func = func_with(insts, blocks);
        let mut classes = PhiClasses::from_func(&func);
        let root = classes.find(3);
        for v in 0..4 {
            assert_eq!(classes.find(v), root, "v{v} should share v3's class");
        }
    }

    #[test]
    fn back_edge_phi_source_defined_after_the_phi_still_joins() {
        // Loop-shaped:
        //   v0 = Imm(0)
        //   v1 = Phi { incoming = [(0, v0), (1, v2)] }  -- back-edge from v2
        //   v2 = BinopI add v1, 1                       -- defined AFTER v1
        // The union must reach v2 via the (1, v2) incoming entry.
        let insts = vec![
            Inst::Imm(0),
            Inst::Phi {
                incoming: vec![(0, 0), (1, 2)],
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: super::super::super::ir::BinOp::Add,
                lhs: 1,
                rhs_imm: 1,
            },
        ];
        let blocks = vec![Block {
            start_pc: 0,
            inst_range: 0..3,
            terminator: Terminator::Return(1),
            exit_acc: 1,
        }];
        let func = func_with(insts, blocks);
        let mut classes = PhiClasses::from_func(&func);
        let root = classes.find(1);
        assert_eq!(classes.find(0), root, "init source must join");
        assert_eq!(classes.find(2), root, "back-edge source must join");
    }
}

//! Drop `Inst::Extend { value: v_load, kind: K }` when `v_load` is
//! a sign-extending load whose own `kind` already matches `K`.
//!
//! `Load { kind: I8 | I16 | I32 }`, `LoadLocal { kind: I8 | I16 | I32 }`,
//! and `LoadIndexed { kind: I8 | I16 | I32 }` lower to `ldrsb` /
//! `ldrsh` / `ldrsw` on AArch64 and to the `movsx` family on x86_64,
//! both of which deposit a 64-bit sign-extended value in the
//! destination register. The walker's per-load `Inst::Extend`
//! wrapper then re-applies the same sign extension via `sxtw`
//! (or `movsxd`), producing a no-op on the same register.
//!
//! The pass redirects every consumer of the Extend's id to the
//! load's id. Use counts in the allocator track this naturally
//! through `for_each_operand`; the dead Extend is left in place
//! and the per-arch emit's `is_dead_pure` skip drops the
//! instruction.

use super::super::ir::{FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator, ValueId};
use alloc::vec::Vec;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
        run_one(func);
    }
}

fn is_signed_load(insts: &[Inst], v: ValueId) -> Option<LoadKind> {
    if v == NO_VALUE {
        return None;
    }
    let idx = v as usize;
    if idx >= insts.len() {
        return None;
    }
    let kind = match &insts[idx] {
        Inst::Load { kind, .. } => *kind,
        Inst::LoadLocal { kind, .. } => *kind,
        Inst::LoadIndexed { kind, .. } => *kind,
        _ => return None,
    };
    match kind {
        LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => Some(kind),
        _ => None,
    }
}

fn run_one(func: &mut FunctionSsa) {
    // Map every Extend whose operand is a sign-extending load of
    // the same kind to that operand id. `resolve` walks redirect
    // chains so a chain of `Extend(Extend(load))` collapses.
    let n = func.insts.len();
    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; n];
    for (idx, inst) in func.insts.iter().enumerate() {
        let Inst::Extend { value, kind } = inst else {
            continue;
        };
        let Some(load_kind) = is_signed_load(&func.insts, *value) else {
            continue;
        };
        if load_kind != *kind {
            continue;
        }
        redirect[idx] = Some(*value);
    }
    if redirect.iter().all(|r| r.is_none()) {
        return;
    }
    // Resolve through chains: Extend(Extend(load)) becomes load.
    fn resolve(redirect: &[Option<ValueId>], mut v: ValueId) -> ValueId {
        let mut guard = 0u32;
        while v != NO_VALUE {
            match redirect[v as usize] {
                Some(t) if t != v => {
                    v = t;
                    guard += 1;
                    if guard > redirect.len() as u32 {
                        break;
                    }
                }
                _ => break,
            }
        }
        v
    }
    // Rewrite every operand, terminator value, and block accumulator.
    for inst in func.insts.iter_mut() {
        // The redirect-from list (the dead Extends) reads the load
        // operand; rewriting it would be a self-edit, so skip those
        // and let the per-arch emit's is_dead_pure path drop them.
        if let Inst::Extend { value: _, kind: _ } = inst {
            continue;
        }
        for_each_operand_mut(inst, |op| *op = resolve(&redirect, *op));
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            block.exit_acc = resolve(&redirect, block.exit_acc);
        }
        match &mut block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                *cond = resolve(&redirect, *cond);
            }
            Terminator::Return(v) if *v != NO_VALUE => {
                *v = resolve(&redirect, *v);
            }
            _ => {}
        }
    }
}

/// Walk every value operand the inst references and call `f` with
/// a mutable reference. Mirrors `ssa_mem2reg::for_each_operand_mut`.
fn for_each_operand_mut(inst: &mut Inst, mut f: impl FnMut(&mut ValueId)) {
    match inst {
        Inst::Imm(_)
        | Inst::ImmData(_)
        | Inst::ImmCode(_)
        | Inst::BlockAddr(_)
        | Inst::LocalAddr(_)
        | Inst::TlsAddr(_)
        | Inst::LoadLocal { .. }
        | Inst::TailExt(_)
        | Inst::AllocaInit(_)
        | Inst::ParamRef { .. } => {}
        Inst::Load { addr, .. } => f(addr),
        Inst::Store { addr, value, .. } => {
            f(addr);
            f(value);
        }
        Inst::StoreLocal { value, .. } => f(value),
        Inst::LoadIndexed { base, index, .. } => {
            f(base);
            f(index);
        }
        Inst::StoreIndexed {
            base, index, value, ..
        } => {
            f(base);
            f(index);
            f(value);
        }
        Inst::Binop { lhs, rhs, .. } => {
            f(lhs);
            f(rhs);
        }
        Inst::BinopI { lhs, .. } => f(lhs),
        Inst::Fneg(v) => f(v),
        Inst::Fma { a, b, c, .. } => {
            f(a);
            f(b);
            f(c);
        }
        Inst::Extend { value, .. } => f(value),
        Inst::FpCast { value, .. } => f(value),
        Inst::Call { args, .. } | Inst::CallExt { args, .. } | Inst::Intrinsic { args, .. } => {
            for a in args {
                f(a);
            }
        }
        Inst::CallIndirect { target, args, .. } => {
            f(target);
            for a in args {
                f(a);
            }
        }
        Inst::Mcpy { dst, src, .. } => {
            f(dst);
            f(src);
        }
        Inst::Phi { incoming, .. } => {
            for (_, v) in incoming {
                f(v);
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{Block, FunctionSsa, Inst, LoadKind, Terminator};
    use super::*;
    use alloc::vec;

    fn fresh(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            name: alloc::string::String::new(),
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
            ret_is_fp: false,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            insts,
            blocks,
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    #[test]
    fn extend_i32_of_load_i32_redirects_to_load() {
        // v0: Imm(0) (address)
        // v1: Load(addr=v0, kind=I32)
        // v2: Extend(value=v1, kind=I32)
        // Return(v2) -- should rewrite to Return(v1).
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(
            matches!(f.blocks[0].terminator, Terminator::Return(1)),
            "Return should redirect from v2 (Extend) to v1 (Load); got {:?}",
            f.blocks[0].terminator
        );
    }

    #[test]
    fn extend_i64_of_load_i32_is_not_redirected() {
        // Different widths -- the Extend changes the value's width
        // and must stay. (Currently the IR only sign-extends but
        // be conservative.)
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I32,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I64,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(2)));
    }

    #[test]
    fn extend_u32_of_load_u32_is_not_redirected() {
        // Unsigned loads zero-extend; Extend is conservative here.
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::U32,
                },
                Inst::Extend {
                    value: 1,
                    kind: LoadKind::I32,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Return(2),
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(2)));
    }

    #[test]
    fn no_extend_no_change() {
        let mut f = fresh(
            vec![Inst::Imm(0)],
            vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Return(0),
                exit_acc: 0,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(0)));
    }
}

//! A returned call result skips its renormalization when the callee has
//! this function's return contract (`codegen::declared_return_extension`):
//! readers of a narrow result extend it themselves, or the callee did, so
//! the return reads the call, the shape a sibling call takes.

use crate::Target;
use crate::c5::codegen::{ReturnExt, declared_return_extension};
use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, Terminator, ValueId};
use alloc::collections::BTreeMap;

/// `callee_tags` maps a direct call's target to its callee's return type.
pub(crate) fn run(funcs: &mut [FunctionSsa], callee_tags: &BTreeMap<usize, i64>, target: Target) {
    for func in funcs {
        let ext = declared_return_extension(func.ret_type_tag, target);
        if ext == ReturnExt::None {
            continue;
        }
        for b in 0..func.blocks.len() {
            let Terminator::Return(v) = func.blocks[b].terminator else {
                continue;
            };
            let Some(call) = renormalized_call(func, v, ext) else {
                continue;
            };
            let Inst::Call { target_pc, .. } = func.insts[call as usize] else {
                continue;
            };
            if callee_tags
                .get(&target_pc)
                .is_some_and(|&tag| declared_return_extension(tag, target) == ext)
            {
                let block = &mut func.blocks[b];
                block.terminator = Terminator::Return(call);
                if block.exit_acc == v {
                    block.exit_acc = call;
                }
            }
        }
    }
}

/// The direct call whose result `v` extends as `ext` names.
fn renormalized_call(func: &FunctionSsa, v: ValueId, ext: ReturnExt) -> Option<ValueId> {
    let (value, matches) = match *func.insts.get(v as usize)? {
        Inst::BinopI {
            op: BinOp::And,
            lhs,
            rhs_imm,
        } => (
            lhs,
            matches!(
                (ext, rhs_imm),
                (ReturnExt::Zero8, 0xff)
                    | (ReturnExt::Zero16, 0xffff)
                    | (ReturnExt::Zero32, 0xffff_ffff)
            ),
        ),
        Inst::Extend { value, kind, .. } => (
            value,
            matches!(
                (ext, kind),
                (ReturnExt::Sign8, LoadKind::I8)
                    | (ReturnExt::Sign16, LoadKind::I16)
                    | (ReturnExt::Sign32, LoadKind::I32)
            ),
        ),
        _ => return None,
    };
    (matches && matches!(func.insts.get(value as usize)?, Inst::Call { .. })).then_some(value)
}

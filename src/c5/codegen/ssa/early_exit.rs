//! A return taken ahead of the frame: the entry block, or the loop header it
//! jumps into with its phis at their entry values, ends in a test with one
//! arm that only returns. Where both need no more than the argument
//! registers, the backends evaluate the test from them ahead of the prologue
//! and the returned value in a return placed after the body; the frame path
//! follows the test.

use alloc::boxed::Box;
use alloc::collections::BTreeMap;

use super::mem2reg::predecessors;
use super::reg_alloc::{Allocation, incoming_reg};
use crate::c5::codegen::ArgPlacement;
use crate::c5::codegen::passes::constfold::mirror;
use crate::c5::codegen::passes::narrow::is_cmp32;
use crate::c5::ir::{
    BinOp, BlockId, FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator, ValueId,
    is_int_comparison_op,
};

/// Expression nodes the test and the returned value may take together.
const MAX_NODES: usize = 8;

/// An integer value computed from the argument registers alone.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum ShadowExpr {
    /// A parameter's argument register, converted to `kind` (C99 6.5.2.2p4).
    Param {
        reg: u8,
        kind: LoadKind,
    },
    Imm(i64),
    Extend {
        value: Box<ShadowExpr>,
        kind: LoadKind,
    },
    Binop {
        op: BinOp,
        lhs: Box<ShadowExpr>,
        rhs: Box<ShadowExpr>,
    },
}

impl ShadowExpr {
    fn reads_param(&self) -> bool {
        match self {
            ShadowExpr::Param { .. } => true,
            ShadowExpr::Imm(_) => false,
            ShadowExpr::Extend { value, .. } => value.reads_param(),
            ShadowExpr::Binop { lhs, rhs, .. } => lhs.reads_param() || rhs.reads_param(),
        }
    }
}

/// The condition the test block branches on.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum ShadowTest {
    /// An integer comparison, in the 32-bit form where the emit issues one.
    Cmp {
        op: BinOp,
        lhs: ShadowExpr,
        rhs: ShadowExpr,
        narrow: bool,
    },
    /// A value's truth, over its low word where the emit tests that.
    Value { value: ShadowExpr, low_word: bool },
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct EarlyExit {
    /// The block whose terminator tests: the entry or the header it enters.
    pub test_block: BlockId,
    /// The arm that returns, and the one the frame path takes.
    pub exit_block: BlockId,
    pub frame_block: BlockId,
    pub test: ShadowTest,
    /// The function returns when the test is true, or when it is false.
    pub exit_when: bool,
    /// The returned value; `None` for a `Return` naming none.
    pub ret: Option<ShadowExpr>,
}

/// Instructions that neither trap nor touch memory, a register the frame
/// saves or the stack; skipping one on the early return changes nothing.
fn pure(inst: &Inst) -> bool {
    match inst {
        Inst::AllocaInit(slot) => *slot == 0,
        Inst::ParamRef { .. }
        | Inst::ParamPart { .. }
        | Inst::Imm(_)
        | Inst::Extend { .. }
        | Inst::Phi { .. }
        | Inst::LifetimeEnd(_) => true,
        Inst::Binop { op, .. } | Inst::BinopI { op, .. } => {
            !matches!(op, BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu)
        }
        _ => false,
    }
}

/// The early return of `func` under `alloc`, with parameters in the
/// registers `plan` assigns them.
pub(crate) fn early_exit(
    func: &FunctionSsa,
    alloc: &Allocation,
    plan: &[ArgPlacement],
) -> Option<EarlyExit> {
    if func.is_naked
        || func.is_variadic
        || func.indirect_result_slot != 0
        || func.ret_agg.is_some()
        || func.ret_is_fp
        || func.has_returns_twice_call
        || func.blocks.is_empty()
    {
        return None;
    }
    // An edge back into the entry would run its test again.
    let preds = predecessors(func);
    let entry = &func.blocks[0];
    if !preds[0].is_empty()
        || !entry
            .inst_range
            .clone()
            .all(|v| pure(&func.insts[v as usize]))
    {
        return None;
    }
    let t = match entry.terminator {
        Terminator::Jmp(h) if h != 0 => h,
        Terminator::Bz { .. } | Terminator::Bnz { .. } => 0,
        _ => return None,
    };
    let block = &func.blocks[t as usize];
    let mut bind: BTreeMap<ValueId, ValueId> = BTreeMap::new();
    if t != 0 {
        for v in block.inst_range.clone() {
            match &func.insts[v as usize] {
                Inst::Phi { incoming, .. } => {
                    let &(_, from_entry) = incoming.iter().find(|(p, _)| *p == 0)?;
                    bind.insert(v, from_entry);
                }
                inst if pure(inst) => {}
                _ => return None,
            }
        }
    }
    let (cond, taken_on_zero, target, fall_through) = match block.terminator {
        Terminator::Bz {
            cond,
            target,
            fall_through,
        } => (cond, true, target, fall_through),
        Terminator::Bnz {
            cond,
            target,
            fall_through,
        } => (cond, false, target, fall_through),
        _ => return None,
    };
    let returns = |x: BlockId| {
        let xb = &func.blocks[x as usize];
        x != t
            && preds[x as usize] == [t]
            && matches!(xb.terminator, Terminator::Return(_))
            && xb.inst_range.clone().all(|v| pure(&func.insts[v as usize]))
    };
    // The branch reaches `target` when the condition is zero for `Bz`.
    let (exit, frame_block, exit_when) = if returns(target) {
        (target, fall_through, !taken_on_zero)
    } else if returns(fall_through) {
        (fall_through, target, taken_on_zero)
    } else {
        return None;
    };
    let mut cx = Cone {
        func,
        plan,
        bind: &bind,
        nodes: 0,
    };
    let test = match func.insts.get(cond as usize)? {
        Inst::Binop { op, lhs, rhs } if is_int_comparison_op(*op) => ShadowTest::Cmp {
            op: *op,
            lhs: cx.expr(*lhs)?,
            rhs: cx.expr(*rhs)?,
            narrow: is_cmp32(&alloc.cmp32, cond),
        },
        Inst::BinopI { op, lhs, rhs_imm } if is_int_comparison_op(*op) => ShadowTest::Cmp {
            op: *op,
            lhs: cx.expr(*lhs)?,
            rhs: ShadowExpr::Imm(*rhs_imm),
            narrow: is_cmp32(&alloc.cmp32, cond),
        },
        _ => ShadowTest::Value {
            value: cx.expr(cond)?,
            low_word: func
                .low_word_tests
                .get(t as usize)
                .copied()
                .unwrap_or(false),
        },
    };
    let Terminator::Return(r) = func.blocks[exit as usize].terminator else {
        return None;
    };
    let ret = if r == NO_VALUE {
        None
    } else {
        Some(simplify(cx.expr(r)?))
    };
    // A test no parameter reaches is decided before the call: its early
    // return is taken always or never.
    let test = match test {
        ShadowTest::Cmp {
            op,
            lhs,
            rhs,
            narrow,
        } => {
            let (lhs, rhs) = (simplify(lhs), simplify(rhs));
            if !lhs.reads_param() && !rhs.reads_param() {
                return None;
            }
            // The constant goes second, where the compare encodes it.
            if matches!(lhs, ShadowExpr::Imm(_)) {
                ShadowTest::Cmp {
                    op: mirror(op)?,
                    lhs: rhs,
                    rhs: lhs,
                    narrow,
                }
            } else {
                ShadowTest::Cmp {
                    op,
                    lhs,
                    rhs,
                    narrow,
                }
            }
        }
        ShadowTest::Value { value, low_word } => {
            let value = simplify(value);
            if !value.reads_param() {
                return None;
            }
            ShadowTest::Value { value, low_word }
        }
    };
    Some(EarlyExit {
        test_block: t,
        exit_block: exit,
        frame_block,
        test,
        exit_when,
        ret,
    })
}

/// The expression tree of a value, read through the header's entry bindings.
struct Cone<'a> {
    func: &'a FunctionSsa,
    plan: &'a [ArgPlacement],
    bind: &'a BTreeMap<ValueId, ValueId>,
    nodes: usize,
}

impl Cone<'_> {
    fn expr(&mut self, v: ValueId) -> Option<ShadowExpr> {
        if let Some(&from_entry) = self.bind.get(&v) {
            return self.expr(from_entry);
        }
        self.nodes += 1;
        if self.nodes > MAX_NODES {
            return None;
        }
        let inst = self.func.insts.get(v as usize)?;
        Some(match inst {
            Inst::ParamRef { kind, .. } if int_kind(*kind) => {
                match incoming_reg(self.plan, inst)? {
                    (false, reg) => ShadowExpr::Param { reg, kind: *kind },
                    (true, _) => return None,
                }
            }
            Inst::Imm(k) => ShadowExpr::Imm(*k),
            Inst::Extend { value, kind, .. }
                if matches!(kind, LoadKind::I8 | LoadKind::I16 | LoadKind::I32) =>
            {
                ShadowExpr::Extend {
                    value: Box::new(self.expr(*value)?),
                    kind: *kind,
                }
            }
            Inst::BinopI { op, lhs, rhs_imm } if shadow_op(*op) => ShadowExpr::Binop {
                op: *op,
                lhs: Box::new(self.expr(*lhs)?),
                rhs: Box::new(ShadowExpr::Imm(*rhs_imm)),
            },
            Inst::Binop { op, lhs, rhs } if shadow_op(*op) => ShadowExpr::Binop {
                op: *op,
                lhs: Box::new(self.expr(*lhs)?),
                rhs: Box::new(self.expr(*rhs)?),
            },
            _ => return None,
        })
    }
}

fn int_kind(kind: LoadKind) -> bool {
    matches!(
        kind,
        LoadKind::I8
            | LoadKind::U8
            | LoadKind::I16
            | LoadKind::U16
            | LoadKind::I32
            | LoadKind::U32
            | LoadKind::I64
    )
}

/// The arithmetic the backends lower in the shadow evaluation.
fn shadow_op(op: BinOp) -> bool {
    matches!(
        op,
        BinOp::Add
            | BinOp::Sub
            | BinOp::And
            | BinOp::Or
            | BinOp::Xor
            | BinOp::Shl
            | BinOp::Shr
            | BinOp::Shru
    )
}

/// The expression with each `lhs op rhs` whose operand is the identity folded.
fn simplify(e: ShadowExpr) -> ShadowExpr {
    match e {
        ShadowExpr::Binop { op, lhs, rhs } => {
            let (lhs, rhs) = (simplify(*lhs), simplify(*rhs));
            match (op, &lhs, &rhs) {
                (BinOp::Add | BinOp::Or | BinOp::Xor, ShadowExpr::Imm(0), _) => rhs,
                (
                    BinOp::Add
                    | BinOp::Sub
                    | BinOp::Or
                    | BinOp::Xor
                    | BinOp::Shl
                    | BinOp::Shr
                    | BinOp::Shru,
                    _,
                    ShadowExpr::Imm(0),
                ) => lhs,
                _ => ShadowExpr::Binop {
                    op,
                    lhs: Box::new(lhs),
                    rhs: Box::new(rhs),
                },
            }
        }
        ShadowExpr::Extend { value, kind } => ShadowExpr::Extend {
            value: Box::new(simplify(*value)),
            kind,
        },
        other => other,
    }
}

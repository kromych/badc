//! Operand width for integer comparisons.
//!
//! The SSA value model is 64-bit: an `int` expression is computed in a
//! full register and renormalized to its declared width with
//! `Inst::Extend { kind: I32 }` (C99 6.5p5). Two such operands hold the
//! same bits above 31, so the 64-bit comparison and the 32-bit one give
//! the same answer; likewise for two values zero-extended from 32 under
//! an unsigned comparison. Reading the comparison at 32 bits is what
//! makes it stop observing bits 32..63, which is what lets
//! `super::drop_redundant_extend` drop the renormalizations feeding it.
//!
//! The result is recorded on `FunctionSsa::cmp32` rather than re-derived
//! at emit: those drops replace an `Inst::Extend` operand with its
//! source, erasing the evidence. Every drop rule preserves the low word,
//! so a marked comparison stays correct across them.

use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, ValueId};
use alloc::vec::Vec;

/// What a value's register holds above bit 31: `sign` when those bits
/// replicate bit 31, `zero` when they are clear.
#[derive(Clone, Copy, Default)]
struct Ext32 {
    sign: bool,
    zero: bool,
}

const NONE: Ext32 = Ext32 {
    sign: false,
    zero: false,
};
const SIGN: Ext32 = Ext32 {
    sign: true,
    zero: false,
};
const ZERO: Ext32 = Ext32 {
    sign: false,
    zero: true,
};
const BOTH: Ext32 = Ext32 {
    sign: true,
    zero: true,
};

/// Extension a load of `kind` leaves in the destination register.
fn load_ext32(kind: LoadKind) -> Ext32 {
    match kind {
        LoadKind::I8 | LoadKind::I16 | LoadKind::I32 => SIGN,
        LoadKind::U8 | LoadKind::U16 => BOTH,
        LoadKind::U32 => ZERO,
        _ => NONE,
    }
}

fn ext32(func: &FunctionSsa, v: ValueId) -> Ext32 {
    let Some(inst) = func.insts.get(v as usize) else {
        return NONE;
    };
    match inst {
        Inst::Imm(k) => Ext32 {
            sign: *k == *k as i32 as i64,
            zero: (0..=u32::MAX as i64).contains(k),
        },
        Inst::Extend {
            kind: LoadKind::I8 | LoadKind::I16 | LoadKind::I32,
            ..
        } => SIGN,
        Inst::Extend { .. } => NONE,
        Inst::Load { kind, .. }
        | Inst::LoadLocal { kind, .. }
        | Inst::LoadIndexed { kind, .. }
        | Inst::SegLoad { kind, .. } => load_ext32(*kind),
        // The entry lowering sign-extends a narrow signed parameter,
        // skipping the I32 case when nothing reads bits 32..63; the low
        // word holds the argument either way (System V AMD64 3.2.3 /
        // AAPCS64 6.4.1).
        Inst::ParamRef {
            kind: LoadKind::I8 | LoadKind::I16 | LoadKind::I32,
            ..
        } => SIGN,
        Inst::ParamRef { .. } => NONE,
        // The reversed bytes are zero-extended to 64 bits.
        Inst::Bswap { width, .. } => match width {
            2 => BOTH,
            4 => ZERO,
            _ => NONE,
        },
        Inst::Binop { op, .. } if compare_sign(*op).is_some() => BOTH,
        Inst::BinopI { op, rhs_imm, .. } => match op {
            _ if compare_sign(*op).is_some() => BOTH,
            BinOp::And if (0..=u32::MAX as i64).contains(rhs_imm) => Ext32 {
                sign: *rhs_imm <= i32::MAX as i64,
                zero: true,
            },
            _ => NONE,
        },
        _ => NONE,
    }
}

/// Signedness a comparison reads its operands with; `None` for a
/// non-comparison op.
#[derive(Clone, Copy, PartialEq, Eq)]
enum CmpSign {
    Signed,
    Unsigned,
    Either,
}

fn compare_sign(op: BinOp) -> Option<CmpSign> {
    Some(match op {
        BinOp::Eq | BinOp::Ne => CmpSign::Either,
        BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge => CmpSign::Signed,
        BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge => CmpSign::Unsigned,
        _ => return None,
    })
}

/// Whether the comparison `op` over operands with extensions `a` and
/// `b` gives the same answer read at 32 bits as at 64.
fn narrow_ok(op: BinOp, a: Ext32, b: Ext32) -> bool {
    match compare_sign(op) {
        Some(CmpSign::Signed) => a.sign && b.sign,
        Some(CmpSign::Unsigned) => a.zero && b.zero,
        // A sign-extended operand and a zero-extended one differ above
        // bit 31 exactly when the low word is negative, so equality
        // needs one extension shared by both sides.
        Some(CmpSign::Either) => (a.sign && b.sign) || (a.zero && b.zero),
        None => false,
    }
}

/// Extension of a `BinopI` right-hand immediate as the 64-bit
/// comparison sees it; one outside the narrow range carries neither.
fn imm_ext32(imm: i64) -> Ext32 {
    Ext32 {
        sign: imm == imm as i32 as i64,
        zero: (0..=u32::MAX as i64).contains(&imm),
    }
}

/// Fill `func.cmp32`. Must run before the extends the marked
/// comparisons stop reading are dropped, and after every pass that
/// adds, removes or rewrites instructions.
pub(crate) fn mark_compares(func: &mut FunctionSsa) {
    let mut out: Vec<bool> = alloc::vec![false; func.insts.len()];
    for (i, slot) in out.iter_mut().enumerate() {
        *slot = match &func.insts[i] {
            Inst::Binop { op, lhs, rhs } => narrow_ok(*op, ext32(func, *lhs), ext32(func, *rhs)),
            Inst::BinopI { op, lhs, rhs_imm } => {
                narrow_ok(*op, ext32(func, *lhs), imm_ext32(*rhs_imm))
            }
            _ => false,
        };
    }
    func.cmp32 = out;
}

/// Whether `v` is a comparison marked for the 32-bit operand form.
pub(crate) fn is_cmp32(cmp32: &[bool], v: ValueId) -> bool {
    cmp32.get(v as usize).copied().unwrap_or(false)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::StoreKind;

    fn fresh(insts: alloc::vec::Vec<Inst>) -> FunctionSsa {
        FunctionSsa {
            insts,
            ..Default::default()
        }
    }

    fn marked(insts: alloc::vec::Vec<Inst>) -> alloc::vec::Vec<bool> {
        let mut f = fresh(insts);
        mark_compares(&mut f);
        f.cmp32
    }

    fn load(kind: LoadKind) -> Inst {
        Inst::Load {
            addr: 0,
            disp: 0,
            kind,
            volatile: false,
            align: 0,
        }
    }

    #[test]
    fn signed_compare_of_two_int_renormalizations_is_narrow() {
        let m = marked(alloc::vec![
            Inst::Imm(0),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32
            },
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32
            },
            Inst::Binop {
                op: BinOp::Lt,
                lhs: 1,
                rhs: 2
            },
        ]);
        assert!(m[3]);
    }

    #[test]
    fn signed_compare_against_a_wide_operand_stays_64_bit() {
        let m = marked(alloc::vec![
            Inst::Imm(0),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32
            },
            load(LoadKind::I64),
            Inst::Binop {
                op: BinOp::Lt,
                lhs: 1,
                rhs: 2
            },
        ]);
        assert!(!m[3]);
    }

    #[test]
    fn unsigned_compare_needs_zero_extended_operands() {
        // Two u32 loads narrow; a sign-extended operand does not, its
        // bits above 31 carry the sign the 64-bit compare reads.
        let m = marked(alloc::vec![
            Inst::Imm(0),
            load(LoadKind::U32),
            load(LoadKind::U32),
            Inst::Binop {
                op: BinOp::Ult,
                lhs: 1,
                rhs: 2
            },
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32
            },
            Inst::Binop {
                op: BinOp::Ult,
                lhs: 1,
                rhs: 4
            },
        ]);
        assert!(m[3]);
        assert!(!m[5]);
    }

    #[test]
    fn equality_needs_one_extension_on_both_sides() {
        // sext32(-1) and zext32(0xffffffff) hold the same low word and
        // differ at 64 bits, so a mixed pair keeps the wide compare.
        let m = marked(alloc::vec![
            Inst::Imm(0),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32
            },
            load(LoadKind::U32),
            Inst::Binop {
                op: BinOp::Eq,
                lhs: 1,
                rhs: 2
            },
            load(LoadKind::U32),
            Inst::Binop {
                op: BinOp::Eq,
                lhs: 2,
                rhs: 4
            },
        ]);
        assert!(!m[3]);
        assert!(m[5]);
    }

    #[test]
    fn narrow_loads_carry_their_own_extension() {
        // A u8 / u16 load is both sign- and zero-extended, so it pairs
        // with either; an i8 / i16 load is only sign-extended.
        let m = marked(alloc::vec![
            load(LoadKind::U8),
            load(LoadKind::I16),
            Inst::Binop {
                op: BinOp::Lt,
                lhs: 0,
                rhs: 1
            },
            Inst::Binop {
                op: BinOp::Ult,
                lhs: 0,
                rhs: 1
            },
        ]);
        assert!(m[2]);
        assert!(!m[3]);
    }

    #[test]
    fn immediate_outside_the_narrow_range_stays_64_bit() {
        let m = marked(alloc::vec![
            Inst::Imm(0),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32
            },
            Inst::BinopI {
                op: BinOp::Lt,
                lhs: 1,
                rhs_imm: 20
            },
            Inst::BinopI {
                op: BinOp::Lt,
                lhs: 1,
                rhs_imm: 0x1_0000_0000
            },
            load(LoadKind::U32),
            Inst::BinopI {
                op: BinOp::Ugt,
                lhs: 4,
                rhs_imm: -1
            },
            Inst::BinopI {
                op: BinOp::Ugt,
                lhs: 4,
                rhs_imm: 0xffff_fff0
            },
        ]);
        assert!(m[2]);
        assert!(!m[3]);
        assert!(!m[5]);
        assert!(m[6]);
    }

    #[test]
    fn int_parameter_reads_its_value_from_the_low_word() {
        let m = marked(alloc::vec![
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I32
            },
            Inst::ParamRef {
                idx: 1,
                kind: LoadKind::I64
            },
            Inst::BinopI {
                op: BinOp::Gt,
                lhs: 0,
                rhs_imm: 0
            },
            Inst::BinopI {
                op: BinOp::Gt,
                lhs: 1,
                rhs_imm: 0
            },
        ]);
        assert!(m[2]);
        assert!(!m[3]);
    }

    #[test]
    fn a_masked_value_is_zero_extended() {
        let m = marked(alloc::vec![
            load(LoadKind::I64),
            Inst::BinopI {
                op: BinOp::And,
                lhs: 0,
                rhs_imm: 0xffff_ffff
            },
            Inst::BinopI {
                op: BinOp::And,
                lhs: 0,
                rhs_imm: 0xffff_ffff
            },
            Inst::Binop {
                op: BinOp::Uge,
                lhs: 1,
                rhs: 2
            },
            Inst::Binop {
                op: BinOp::Ge,
                lhs: 1,
                rhs: 2
            },
        ]);
        assert!(m[3]);
        // The mask leaves bit 31 free, so the pair is not
        // sign-extended and the signed compare keeps 64 bits.
        assert!(!m[4]);
    }

    #[test]
    fn non_comparisons_are_never_marked() {
        let m = marked(alloc::vec![
            Inst::Imm(1),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32
            },
            Inst::Binop {
                op: BinOp::Add,
                lhs: 1,
                rhs: 1
            },
            Inst::BinopI {
                op: BinOp::Shr,
                lhs: 1,
                rhs_imm: 3
            },
            Inst::Store {
                addr: 0,
                disp: 0,
                value: 1,
                kind: StoreKind::I32,
                volatile: false,
                align: 0,
            },
        ]);
        assert!(m.iter().all(|b| !b));
    }
}

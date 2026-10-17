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

use crate::c5::ir::{
    BinOp, BlockId, FunctionSsa, Inst, LoadKind, StoreKind, ValueId, is_divmod_op,
};
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
        Inst::Load { kind, .. }
        | Inst::LoadLocal { kind, .. }
        | Inst::LoadIndexed { kind, .. }
        | Inst::SegLoad { kind, .. } => load_ext32(*kind),
        // The callee converts a narrow parameter to its declared type
        // (C99 6.5.2.2p4), so the low word carries the argument whatever
        // the ABI left above it; the entry lowering skips the I32
        // extension exactly when nothing reads bits 32..63.
        Inst::ParamRef {
            kind: LoadKind::I8 | LoadKind::I16 | LoadKind::I32,
            ..
        } => SIGN,
        // The reversed bytes are zero-extended to 64 bits.
        Inst::Bswap { width, .. } => match width {
            2 => BOTH,
            4 => ZERO,
            _ => NONE,
        },
        Inst::BitCount { .. } => BOTH,
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

/// Fill `func.cmp32`. Runs before the extends the marked comparisons
/// stop reading are dropped. The table is keyed by value id: the passes
/// that follow rewrite only non-comparison slots, `split_ranges` remaps
/// it with the values, and a table shorter than `insts` reads as
/// all-false -- the 64-bit form.
///
/// With `with_ranges`, an operand whose shape states no extension is
/// judged by its range where the comparison reads it: a value inside
/// `int` holds its own sign extension, one inside `[0, 2^32)` its zero
/// extension. That keeps a comparison 32-bit over an operand whose extend
/// an earlier run of the range fold already removed.
pub(crate) fn mark_compares(func: &mut FunctionSsa, with_ranges: bool) {
    let read: &FunctionSsa = func;
    let mut side = OperandExt::new(read, with_ranges);
    let out: Vec<bool> = read
        .insts
        .iter()
        .enumerate()
        .map(|(i, inst)| {
            let (op, lhs, rhs) = match inst {
                Inst::Binop { op, lhs, rhs } => (*op, *lhs, Ok(*rhs)),
                Inst::BinopI { op, lhs, rhs_imm } => (*op, *lhs, Err(*rhs_imm)),
                _ => return false,
            };
            if compare_sign(op).is_none() {
                return false;
            }
            // A mark from an earlier run stays: operands may have lost
            // their extends on the strength of it.
            if is_cmp32(&read.cmp32, i as ValueId) {
                return true;
            }
            let a = side.of(i, lhs);
            let b = match rhs {
                Ok(v) => side.of(i, v),
                Err(imm) => imm_ext32(imm),
            };
            narrow_ok(op, a, b)
        })
        .collect();
    func.cmp32 = out;
}

/// Whether `v` is a comparison marked for the 32-bit operand form.
pub(crate) fn is_cmp32(cmp32: &[bool], v: ValueId) -> bool {
    cmp32.get(v as usize).copied().unwrap_or(false)
}

/// Whether `v` is marked for the 32-bit division form.
pub(crate) fn is_div32(div32: &[bool], v: ValueId) -> bool {
    div32.get(v as usize).copied().unwrap_or(false)
}

/// [`is_div32`] of a division or remainder, not of a slot rewritten since.
pub(crate) fn is_narrow_div(func: &FunctionSsa, v: ValueId) -> bool {
    matches!(func.insts.get(v as usize),
        Some(Inst::Binop { op, .. } | Inst::BinopI { op, .. }) if is_divmod_op(*op))
        && is_div32(&func.div32, v)
}

/// The `int` divisions (C99 6.5p5): an nsw I32 renormalization or local
/// store reads them, or the split remainder `n - (n / d) * d` its quotient.
fn int_divisions(func: &FunctionSsa) -> Vec<bool> {
    let mut nsw = alloc::vec![false; func.insts.len()];
    for inst in &func.insts {
        let v = match *inst {
            Inst::Extend {
                value,
                kind: LoadKind::I32,
                nsw: true,
            }
            | Inst::StoreLocal {
                value,
                kind: StoreKind::I32,
                nsw: true,
                ..
            } => value,
            _ => continue,
        };
        if let Some(slot) = nsw.get_mut(v as usize) {
            *slot = true;
        }
    }
    let binop = |v: ValueId| match func.insts.get(v as usize) {
        Some(&Inst::Binop { op, lhs, rhs }) => Some((op, lhs, Some(rhs))),
        Some(&Inst::BinopI { op, lhs, .. }) => Some((op, lhs, None)),
        _ => None,
    };
    let mut out = nsw.clone();
    for (s, &marked) in nsw.iter().enumerate() {
        let Some((BinOp::Sub, n, Some(t))) = binop(s as ValueId).filter(|_| marked) else {
            continue;
        };
        let Some((BinOp::Mul, x, y)) = binop(t) else {
            continue;
        };
        for q in core::iter::once(x).chain(y) {
            if let Some((BinOp::Div, dividend, _)) = binop(q)
                && dividend == n
            {
                out[q as usize] = true;
            }
        }
    }
    out
}

/// Fill `func.div32`: an unsigned division of zero-extended operands, the
/// same at either width, and an `int` one ([`int_divisions`]) of
/// sign-extended operands read no higher than bit 31, the 32-bit `idiv`
/// trapping on INT_MIN / -1 and zero-extending. A constant divisor is
/// expanded instead. A mark from an earlier run stays.
pub(crate) fn mark_narrow_divs(func: &mut FunctionSsa) {
    let divides = |i: &Inst| matches!(i, Inst::Binop { op, .. } if is_divmod_op(*op));
    if !func.insts.iter().any(divides) {
        func.div32 = Vec::new();
        return;
    }
    let read: &FunctionSsa = func;
    let mut side = OperandExt::new(read, true);
    let hi = super::drop_redundant_extend::compute_high_observed(read);
    let int_div = int_divisions(read);
    let out: Vec<bool> = read
        .insts
        .iter()
        .enumerate()
        .map(|(i, inst)| {
            let Inst::Binop { op, lhs, rhs } = *inst else {
                return false;
            };
            if !is_divmod_op(op) {
                return false;
            }
            if is_div32(&read.div32, i as ValueId) {
                return true;
            }
            if matches!(read.insts.get(rhs as usize), Some(Inst::Imm(_))) {
                return false;
            }
            let signed = matches!(op, BinOp::Div | BinOp::Mod);
            if signed && (hi.get(i).copied().unwrap_or(true) || !int_div[i]) {
                return false;
            }
            let (a, b) = (side.of(i, lhs), side.of(i, rhs));
            if signed {
                a.sign && b.sign
            } else {
                a.zero && b.zero
            }
        })
        .collect();
    func.div32 = out;
}

/// What an operand's register holds above bit 31 by its shape, else, with
/// `with_ranges`, by its range where the instruction reads it, the ranges
/// built on first need.
struct OperandExt<'a> {
    func: &'a FunctionSsa,
    with_ranges: bool,
    ranges: Option<(super::value_range::Ranges, Vec<BlockId>)>,
}

impl<'a> OperandExt<'a> {
    fn new(func: &'a FunctionSsa, with_ranges: bool) -> Self {
        OperandExt {
            func,
            with_ranges,
            ranges: None,
        }
    }

    fn of(&mut self, at: usize, v: ValueId) -> Ext32 {
        let e = ext32(self.func, v);
        if e.sign || e.zero || !self.with_ranges {
            return e;
        }
        let func = self.func;
        let (ranges, block_of) = self.ranges.get_or_insert_with(|| {
            let mut block_of = alloc::vec![BlockId::MAX; func.insts.len()];
            for (b, block) in func.blocks.iter().enumerate() {
                for idx in block.inst_range.clone() {
                    if let Some(slot) = block_of.get_mut(idx as usize) {
                        *slot = b as BlockId;
                    }
                }
            }
            (super::value_range::Ranges::compute(func, &[]), block_of)
        });
        match block_of[at] {
            BlockId::MAX => NONE,
            b => {
                let r = ranges.at(b, v);
                Ext32 {
                    sign: r.fits(LoadKind::I32),
                    zero: r.high_word_clear(),
                }
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn fresh(insts: alloc::vec::Vec<Inst>) -> FunctionSsa {
        FunctionSsa {
            insts,
            ..Default::default()
        }
    }

    fn marked(insts: alloc::vec::Vec<Inst>) -> alloc::vec::Vec<bool> {
        let mut f = fresh(insts);
        mark_compares(&mut f, true);
        f.cmp32
    }

    fn marked_divs(insts: alloc::vec::Vec<Inst>) -> alloc::vec::Vec<bool> {
        let mut f = fresh(insts);
        mark_narrow_divs(&mut f);
        f.div32
    }

    fn store(value: ValueId, kind: StoreKind) -> Inst {
        Inst::Store {
            addr: 0,
            disp: 0,
            value,
            kind,
            volatile: false,
            align: 0,
        }
    }

    fn ext(value: ValueId, kind: LoadKind, nsw: bool) -> Inst {
        Inst::Extend { value, kind, nsw }
    }

    fn binop(op: BinOp, lhs: ValueId, rhs: ValueId) -> Inst {
        Inst::Binop { op, lhs, rhs }
    }

    /// `v3 = op(v1, v2)` over two `int` renormalizations, its result read
    /// by `reader(3)` and stored at 32 bits from the slot after.
    fn int_operands(op: BinOp, reader: Inst) -> alloc::vec::Vec<Inst> {
        alloc::vec![
            Inst::Imm(0),
            ext(0, LoadKind::I32, false),
            ext(0, LoadKind::I32, false),
            binop(op, 1, 2),
            reader,
            store(4, StoreKind::I32),
        ]
    }

    #[test]
    fn an_int_division_and_remainder_are_narrow() {
        for op in [BinOp::Div, BinOp::Mod] {
            let m = marked_divs(int_operands(op, ext(3, LoadKind::I32, true)));
            assert!(m[3], "{op:?}");
            let stored = int_operands(
                op,
                Inst::StoreLocal {
                    off: -8,
                    disp: 0,
                    value: 3,
                    kind: StoreKind::I32,
                    volatile: false,
                    nsw: true,
                },
            );
            assert!(marked_divs(stored)[3], "{op:?} into a local");
        }
    }

    #[test]
    fn a_wider_division_converted_to_int_keeps_the_64_bit_form() {
        // `(int)((long long)a / (long long)b)`: INT_MIN / -1 is 2^31 there,
        // which the 32-bit idiv traps on; the conversion is not an nsw read.
        for op in [BinOp::Div, BinOp::Mod] {
            let m = marked_divs(int_operands(op, ext(3, LoadKind::I32, false)));
            assert!(!m[3], "{op:?}");
        }
    }

    #[test]
    fn a_split_int_remainder_narrows_its_quotient() {
        // `n - (n / d) * d`, renormalized as an `int` remainder.
        let m = marked_divs(alloc::vec![
            Inst::Imm(0),
            ext(0, LoadKind::I32, false),
            ext(0, LoadKind::I32, false),
            binop(BinOp::Div, 1, 2),
            binop(BinOp::Mul, 3, 2),
            binop(BinOp::Sub, 1, 4),
            ext(5, LoadKind::I32, true),
            store(6, StoreKind::I32),
        ]);
        assert!(m[3]);
    }

    #[test]
    fn an_unsigned_division_needs_zero_extended_operands() {
        let m = marked_divs(alloc::vec![
            Inst::Imm(0),
            load(LoadKind::U32),
            load(LoadKind::U32),
            binop(BinOp::Divu, 1, 2),
            store(3, StoreKind::I64),
            ext(0, LoadKind::I32, false),
            binop(BinOp::Divu, 5, 1),
            store(6, StoreKind::I32),
        ]);
        // Two u32 loads narrow even read wide; a sign-extended operand not.
        assert!(m[3]);
        assert!(!m[6]);
    }

    #[test]
    fn a_wide_operand_keeps_the_64_bit_form() {
        let m = marked_divs(alloc::vec![
            Inst::Imm(0),
            ext(0, LoadKind::I32, false),
            load(LoadKind::I64),
            binop(BinOp::Div, 1, 2),
            ext(3, LoadKind::I32, true),
            store(4, StoreKind::I32),
        ]);
        assert!(!m[3]);
    }

    #[test]
    fn a_signed_result_read_wide_keeps_the_64_bit_form() {
        let mut insts = int_operands(BinOp::Div, ext(3, LoadKind::I32, true));
        insts.push(store(3, StoreKind::I64));
        // The 64-bit store reads the quotient's upper half.
        assert!(!marked_divs(insts)[3]);
    }

    #[test]
    fn a_constant_divisor_keeps_the_division_whole() {
        // `divmod_const` expands it; no divide instruction issues.
        let m = marked_divs(alloc::vec![
            Inst::Imm(7),
            ext(0, LoadKind::I32, false),
            binop(BinOp::Div, 1, 0),
            ext(2, LoadKind::I32, true),
            Inst::BinopI {
                op: BinOp::Mod,
                lhs: 1,
                rhs_imm: 7,
            },
            ext(4, LoadKind::I32, true),
        ]);
        assert!(!m[2] && !m[4]);
    }

    #[test]
    fn a_marked_division_stays_narrow_across_reruns() {
        let mut f = fresh(int_operands(BinOp::Div, ext(3, LoadKind::I32, true)));
        mark_narrow_divs(&mut f);
        // A rerun keeps the mark without the evidence.
        f.insts[3] = binop(BinOp::Div, 0, 0);
        f.insts[4] = Inst::Imm(0);
        mark_narrow_divs(&mut f);
        assert!(f.div32[3]);
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
                kind: LoadKind::I32,
                nsw: false
            },
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32,
                nsw: false
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
                kind: LoadKind::I32,
                nsw: false
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
                kind: LoadKind::I32,
                nsw: false
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
                kind: LoadKind::I32,
                nsw: false
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
    fn a_constant_outside_the_32_bit_range_keeps_the_wide_compare() {
        // The constant reaches the comparison as a `BinopI` immediate,
        // or as an `Imm` operand of `Binop` where the immediate form
        // does not apply. Neither carries a 32-bit extension.
        let m = marked(alloc::vec![
            Inst::Imm(-8589934588),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32,
                nsw: false
            },
            Inst::Binop {
                op: BinOp::Ne,
                lhs: 1,
                rhs: 0
            },
            Inst::BinopI {
                op: BinOp::Ne,
                lhs: 1,
                rhs_imm: -8589934588
            },
        ]);
        assert!(!m[2]);
        assert!(!m[3]);
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
                kind: LoadKind::I32,
                nsw: false
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
                kind: LoadKind::I32,
                nsw: false
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

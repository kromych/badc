//! Fold the shifts and the low mask of a bit-field extract into one AArch64
//! SBFX / UBFX (`Inst::BitField`): `(x << a) >> b` for `1 <= a <= b` is the
//! `64 - b`-bit field of `x` at `b - a`, `(x >> p) & (2^w - 1)` the `w`-bit
//! field at `p`, and a field of a right shift by `p` that reaches no fill
//! bit the field `p` bits up in the shift's operand. Each instruction folded
//! in has one reader; the emit skips it once unread.

use alloc::vec::Vec;

use crate::c5::codegen::ssa::reg_alloc::compute_use_counts;
use crate::c5::ir::{BinOp, FunctionSsa, Inst, ValueId};

/// A field: `(value, lsb, width, signed)`.
type Field = (ValueId, i64, i64, bool);

/// `v`'s definition when the instruction being rewritten is its only reader.
fn single_use<'a>(func: &'a FunctionSsa, counts: &[u32], v: ValueId) -> Option<&'a Inst> {
    (counts.get(v as usize).copied() == Some(1))
        .then(|| func.insts.get(v as usize))
        .flatten()
}

/// The width `w` of a mask `2^w - 1` for `w` in 1..=63.
fn low_mask_width(mask: i64) -> Option<i64> {
    let m = mask as u64;
    (m != 0 && m != u64::MAX && m & (m + 1) == 0).then(|| i64::from(m.count_ones()))
}

/// The field of the right shift `s <op> b`, counting a left shift folded in.
fn right_field(
    func: &FunctionSsa,
    counts: &[u32],
    op: BinOp,
    s: ValueId,
    b: i64,
    folded: &mut u32,
) -> Option<Field> {
    if !(1..=63).contains(&b) {
        return None;
    }
    let signed = op == BinOp::Shr;
    if let Some(&Inst::BinopI {
        op: BinOp::Shl,
        lhs: x,
        rhs_imm: a,
    }) = single_use(func, counts, s)
        && (1..=b).contains(&a)
    {
        *folded += 1;
        return Some((x, b - a, 64 - b, signed));
    }
    Some((s, b, 64 - b, signed))
}

/// The field the instruction at `idx` extracts, when it folds in another.
fn field_of(func: &FunctionSsa, counts: &[u32], idx: usize) -> Option<Field> {
    let Inst::BinopI { op, lhs, rhs_imm } = func.insts[idx] else {
        return None;
    };
    let mut folded = 0;
    let (value, lsb, width, signed) = match op {
        BinOp::Shr | BinOp::Shru => right_field(func, counts, op, lhs, rhs_imm, &mut folded)?,
        BinOp::And => {
            let w = low_mask_width(rhs_imm)?;
            let &Inst::BinopI {
                op: inner @ (BinOp::Shr | BinOp::Shru),
                lhs: s,
                rhs_imm: b,
            } = single_use(func, counts, lhs)?
            else {
                return None;
            };
            folded += 1;
            let (x, l, field_w, sign) = right_field(func, counts, inner, s, b, &mut folded)?;
            match (w <= field_w, sign) {
                (true, _) => (x, l, w, false),
                (false, false) => (x, l, field_w, false),
                (false, true) => return None,
            }
        }
        _ => return None,
    };
    let field = match single_use(func, counts, value) {
        Some(&Inst::BinopI {
            op: BinOp::Shr | BinOp::Shru,
            lhs: y,
            rhs_imm: p,
        }) if p >= 1 && p + lsb + width <= 64 => {
            folded += 1;
            (y, lsb + p, width, signed)
        }
        _ => (value, lsb, width, signed),
    };
    (folded > 0).then_some(field)
}

/// Walk every function, folding each recognised extract into one node.
pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        let counts = compute_use_counts(func);
        let mut rewrites: Vec<(usize, Inst)> = Vec::new();
        for idx in 0..func.insts.len() {
            if counts[idx] == 0 {
                continue;
            }
            if let Some((value, lsb, width, signed)) = field_of(func, &counts, idx) {
                let field = Inst::BitField {
                    value,
                    lsb: lsb as u8,
                    width: width as u8,
                    signed,
                };
                rewrites.push((idx, field));
            }
        }
        for (idx, field) in rewrites {
            func.insts[idx] = field;
        }
    }
}

#[cfg(test)]
mod tests;

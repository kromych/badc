//! Fold a byte reversal of one value written with shifts, masks and ors
//! (the portable `__builtin_bswap16/32/64`) to `Inst::Bswap`. Each value
//! records which byte of one source each of its bytes holds; a value whose
//! low `w` bytes are the source's reversed and whose upper bytes are zero,
//! `w` in {2, 4, 8}, equals that `Bswap` in all 64 bits. Rewrites are in
//! place; the memory forms are `byteload`'s.

use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, ValueId};
use alloc::vec::Vec;

/// A sign extension's copy of the sign bit.
const UNKNOWN: u8 = 0xFF;

/// Per byte, 0 for zero, `k + 1` for byte `k` of `src`, or [`UNKNOWN`].
#[derive(Clone, Copy, PartialEq)]
struct Bytes {
    src: Option<ValueId>,
    map: [u8; 8],
}

impl Bytes {
    fn source(v: ValueId) -> Self {
        Bytes {
            src: Some(v),
            map: [1, 2, 3, 4, 5, 6, 7, 8],
        }
    }

    fn moved(self, f: impl Fn(usize) -> Option<usize>) -> Self {
        let mut map = [0u8; 8];
        for (i, m) in map.iter_mut().enumerate() {
            *m = f(i).map_or(0, |j| self.map[j]);
        }
        Bytes { map, ..self }
    }

    /// The or, xor or sum of operands no byte of which is nonzero in both.
    fn merged(self, other: Bytes) -> Option<Self> {
        if self.src.is_some() && other.src.is_some() && self.src != other.src {
            return None;
        }
        let mut map = [0u8; 8];
        for (i, m) in map.iter_mut().enumerate() {
            *m = match (self.map[i], other.map[i]) {
                (0, b) | (b, 0) => b,
                _ => return None,
            };
        }
        Some(Bytes {
            src: self.src.or(other.src),
            map,
        })
    }

    fn reversal(self) -> Option<u8> {
        [2u8, 4, 8].into_iter().find(|&w| {
            let w = w as usize;
            (0..8).all(|i| self.map[i] == if i < w { (w - i) as u8 } else { 0 })
        })
    }
}

fn shifted(op: BinOp, b: Bytes, k: i64) -> Option<Bytes> {
    if !(0..64).contains(&k) || k % 8 != 0 {
        return None;
    }
    let s = (k / 8) as usize;
    Some(match op {
        BinOp::Shl => b.moved(|i| i.checked_sub(s)),
        BinOp::Shru => b.moved(|i| (i + s < 8).then_some(i + s)),
        BinOp::Shr => {
            let mut out = b.moved(|i| (i + s < 8).then_some(i + s));
            out.map[8 - s..].fill(UNKNOWN);
            out
        }
        BinOp::Ror => b.moved(|i| Some((i + s) % 8)),
        BinOp::Ror32 if s < 4 => b.moved(|i| (i < 4).then_some((i + s) % 4)),
        _ => return None,
    })
}

fn masked(b: Bytes, mask: i64) -> Option<Bytes> {
    let bytes = mask.to_le_bytes();
    if bytes.iter().any(|&m| m != 0 && m != 0xFF) {
        return None;
    }
    Some(b.moved(|i| (bytes[i] == 0xFF).then_some(i)))
}

/// `v`'s bytes from its operands' `known` ones; `None` makes `v` a source.
fn describe(func: &FunctionSsa, v: ValueId, known: &[Bytes]) -> Option<Bytes> {
    let of = |o: ValueId| -> Bytes {
        // An operand later on the tape is a source of its own.
        if o < v {
            known[o as usize]
        } else {
            Bytes::source(o)
        }
    };
    let imm = |o: ValueId| match func.insts.get(o as usize) {
        Some(Inst::Imm(c)) => Some(*c),
        _ => None,
    };
    match func.insts[v as usize] {
        Inst::BinopI {
            op: BinOp::And,
            lhs,
            rhs_imm,
        } => masked(of(lhs), rhs_imm),
        Inst::BinopI { op, lhs, rhs_imm } => shifted(op, of(lhs), rhs_imm),
        Inst::Binop {
            op: BinOp::Or | BinOp::Xor | BinOp::Add,
            lhs,
            rhs,
        } => of(lhs).merged(of(rhs)),
        Inst::Binop {
            op: BinOp::And,
            lhs,
            rhs,
        } => masked(of(lhs), imm(rhs)?),
        Inst::Binop { op, lhs, rhs } => shifted(op, of(lhs), imm(rhs)?),
        Inst::Extend { value, kind, .. } => {
            let (n, fill) = match kind {
                LoadKind::U8 => (1, 0),
                LoadKind::U16 => (2, 0),
                LoadKind::U32 => (4, 0),
                LoadKind::I8 => (1, UNKNOWN),
                LoadKind::I16 => (2, UNKNOWN),
                LoadKind::I32 => (4, UNKNOWN),
                LoadKind::I64 => (8, 0),
                _ => return None,
            };
            let mut b = of(value);
            b.map[n..].fill(fill);
            Some(b)
        }
        Inst::Bswap { value, width } => {
            let w = usize::from(width);
            Some(of(value).moved(|i| (i < w).then(|| w - 1 - i)))
        }
        _ => None,
    }
}

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        run_one(func);
    }
}

fn run_one(func: &mut FunctionSsa) {
    let n = func.insts.len();
    let mut known: Vec<Bytes> = Vec::with_capacity(n);
    let mut rewrites: Vec<(ValueId, ValueId, u8)> = Vec::new();
    for v in 0..n as ValueId {
        let b = describe(func, v, &known);
        // An operand with the same bytes leaves `v` a no-op of it.
        let mut same = false;
        func.insts[v as usize].for_each_operand(|o| same |= o < v && Some(known[o as usize]) == b);
        if let Some(b) = b
            && let Some(src) = b.src
            && let Some(width) = b.reversal()
            && !same
            && !matches!(func.insts[v as usize], Inst::Bswap { .. })
        {
            rewrites.push((v, src, width));
        }
        known.push(b.unwrap_or(Bytes::source(v)));
    }
    for (v, value, width) in rewrites {
        func.insts[v as usize] = Inst::Bswap { value, width };
    }
}

#[cfg(test)]
mod tests {
    use super::run_one;
    use crate::c5::ir::{BinOp, Block, FunctionSsa, Inst, LoadKind, Terminator};
    use alloc::vec::Vec;

    fn one_block(insts: Vec<Inst>) -> FunctionSsa {
        let n = insts.len() as u32;
        FunctionSsa {
            inst_src: alloc::vec![Default::default(); n as usize],
            f32_values: alloc::vec![false; n as usize],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: Terminator::Return(n - 1),
            }],
            insts,
            ..Default::default()
        }
    }

    fn param(idx: u32) -> Inst {
        Inst::ParamRef {
            idx,
            kind: LoadKind::I64,
        }
    }

    fn bi(op: BinOp, lhs: u32, rhs_imm: i64) -> Inst {
        Inst::BinopI { op, lhs, rhs_imm }
    }

    fn or(lhs: u32, rhs: u32) -> Inst {
        Inst::Binop {
            op: BinOp::Or,
            lhs,
            rhs,
        }
    }

    fn last(f: &FunctionSsa) -> &Inst {
        f.insts.last().unwrap()
    }

    /// The three-stage swap of a 64-bit value, its first stage a rotate.
    #[test]
    fn a_staged_64_bit_swap_is_one_bswap() {
        let mut f = one_block(alloc::vec![
            param(0),
            bi(BinOp::Ror, 0, 32),
            bi(BinOp::And, 1, 0x0000_ffff_0000_ffff),
            bi(BinOp::Shl, 2, 16),
            bi(BinOp::And, 1, 0xffff_0000_ffff_0000u64 as i64),
            bi(BinOp::Shru, 4, 16),
            or(3, 5),
            bi(BinOp::And, 6, 0x00ff_00ff_00ff_00ff),
            bi(BinOp::Shl, 7, 8),
            bi(BinOp::And, 6, 0xff00_ff00_ff00_ff00u64 as i64),
            bi(BinOp::Shru, 9, 8),
            or(8, 10),
        ]);
        run_one(&mut f);
        assert!(
            matches!(last(&f), Inst::Bswap { value: 0, width: 8 }),
            "{:?}",
            last(&f)
        );
    }

    /// A 32-bit swap over a zero-extended word, and a 16-bit one.
    #[test]
    fn narrow_swaps_take_their_widths() {
        let mut f = one_block(alloc::vec![
            param(0),
            Inst::Extend {
                value: 0,
                kind: LoadKind::U32,
                nsw: false,
            },
            bi(BinOp::And, 1, 0xff),
            bi(BinOp::Shl, 2, 24),
            bi(BinOp::And, 1, 0xff00),
            bi(BinOp::Shl, 4, 8),
            bi(BinOp::Shru, 1, 8),
            bi(BinOp::And, 6, 0xff00),
            bi(BinOp::Shru, 1, 24),
            or(3, 5),
            or(9, 7),
            or(10, 8),
        ]);
        run_one(&mut f);
        assert!(
            matches!(last(&f), Inst::Bswap { value: 0, width: 4 }),
            "{:?}",
            last(&f)
        );
        let mut f = one_block(alloc::vec![
            param(0),
            bi(BinOp::And, 0, 0xff),
            bi(BinOp::Shl, 1, 8),
            bi(BinOp::Shru, 0, 8),
            bi(BinOp::And, 3, 0xff),
            or(2, 4),
        ]);
        run_one(&mut f);
        assert!(
            matches!(last(&f), Inst::Bswap { value: 0, width: 2 }),
            "{:?}",
            last(&f)
        );
        // A mask over a reversal it leaves intact stays a mask.
        let mut f = one_block(alloc::vec![
            param(0),
            Inst::Bswap { value: 0, width: 4 },
            bi(BinOp::And, 1, 0xffff_ffff),
        ]);
        run_one(&mut f);
        assert!(matches!(last(&f), Inst::BinopI { op: BinOp::And, .. }));
    }

    /// No fold where the upper bytes are not zero, where two values meet,
    /// or where the bytes are not reversed.
    #[test]
    fn other_permutations_stay() {
        // `x << 24` keeps the word's upper bytes above bit 31.
        let upper = alloc::vec![
            param(0),
            bi(BinOp::Shl, 0, 24),
            bi(BinOp::And, 0, 0xff00),
            bi(BinOp::Shl, 2, 8),
            bi(BinOp::Shru, 0, 8),
            bi(BinOp::And, 4, 0xff00),
            bi(BinOp::Shru, 0, 24),
            bi(BinOp::And, 6, 0xff),
            or(1, 3),
            or(8, 5),
            or(9, 7),
        ];
        let two = alloc::vec![
            param(0),
            param(1),
            bi(BinOp::And, 0, 0xff),
            bi(BinOp::Shl, 2, 8),
            bi(BinOp::Shru, 1, 8),
            bi(BinOp::And, 4, 0xff),
            or(3, 5),
        ];
        let kept = alloc::vec![
            param(0),
            bi(BinOp::And, 0, 0xff),
            bi(BinOp::Shl, 1, 8),
            bi(BinOp::And, 0, 0xff00),
            or(2, 3),
        ];
        for insts in [upper, two, kept] {
            let mut f = one_block(insts);
            run_one(&mut f);
            assert!(!f.insts.iter().any(|i| matches!(i, Inst::Bswap { .. })));
        }
    }
}

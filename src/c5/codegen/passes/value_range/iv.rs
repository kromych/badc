//! Induction variables: a header phi each back edge advances by marked
//! steps (C99 6.5p5 without `-fwrapv`) of an immediate, a value defined
//! ahead of the loop, or another such variable of the header (`j += i`).
//! In a defined execution each step, and the marked operation the variable
//! starts from, fits its width. Only addresses and comparisons rest on that
//! (`drop_redundant_extend::drop_fitting`); a return of an accumulator
//! stepped alike (`s += i`) keeps its extension and wraps.
//! TODO: an index built from the variables (`a[i * w + j]`) is not covered.

use alloc::vec::Vec;

use crate::c5::ir::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, ValueId};

/// Longest run of steps followed back from a back-edge value.
const MAX_CHAIN: usize = 16;

/// A phi of a loop header and the values it takes over back edges.
struct Candidate {
    phi: ValueId,
    header: BlockId,
    back: Vec<ValueId>,
}

struct Walk<'a> {
    func: &'a FunctionSsa,
    block_of: Vec<BlockId>,
    tin: &'a [u32],
    tout: &'a [u32],
    /// Per value: the counter phi it is, or a step or sum of one of.
    counter: Vec<Option<ValueId>>,
    marked_extension: Vec<Option<ValueId>>,
}

impl Walk<'_> {
    fn dominates(&self, a: BlockId, b: BlockId) -> bool {
        let (a, b) = (a as usize, b as usize);
        a < self.tin.len()
            && b < self.tin.len()
            && self.tin[a] != u32::MAX
            && self.tin[b] != u32::MAX
            && self.tin[a] <= self.tin[b]
            && self.tout[b] <= self.tout[a]
    }

    fn peel(&self, mut v: ValueId) -> ValueId {
        while let Some(Inst::Extend {
            value,
            kind: LoadKind::I8 | LoadKind::I16 | LoadKind::I32,
            ..
        }) = self.func.insts.get(v as usize)
        {
            v = *value;
        }
        v
    }

    /// An immediate, a value defined ahead of `h`, or with `counters` a
    /// counter of `h` other than `phi`.
    fn admissible(
        &self,
        s: Result<ValueId, i64>,
        phi: ValueId,
        h: BlockId,
        counters: bool,
    ) -> bool {
        let Ok(s) = s else {
            return true;
        };
        let s = self.peel(s);
        if matches!(self.func.insts.get(s as usize), Some(Inst::Imm(_))) {
            return true;
        }
        let at = self
            .block_of
            .get(s as usize)
            .copied()
            .unwrap_or(BlockId::MAX);
        if at != BlockId::MAX && at != h && self.dominates(at, h) {
            return true;
        }
        counters
            && self.counter[s as usize].is_some_and(|q| q != phi && self.block_of[q as usize] == h)
    }

    /// Whether a marked extension of `x` to `kind` dominates `at`.
    fn fits_before(&self, x: ValueId, kind: LoadKind, at: ValueId) -> bool {
        self.marked_extension[x as usize].is_some_and(|e| {
            let (be, ba) = (self.block_of[e as usize], self.block_of[at as usize]);
            matches!(self.func.insts[e as usize], Inst::Extend { kind: k, .. } if k == kind)
                && if be == ba {
                    e < at
                } else {
                    self.dominates(be, ba)
                }
        })
    }

    /// Whether `v` is `phi` advanced by marked steps (or unmarked ones a
    /// marked copy dominates), recording each in `out`.
    fn chain(
        &self,
        v: ValueId,
        phi: ValueId,
        h: BlockId,
        counters: bool,
        depth: usize,
        out: &mut Vec<(ValueId, LoadKind)>,
    ) -> bool {
        if v == phi {
            return true;
        }
        if depth == 0 {
            return false;
        }
        let (x, kind) = match self.func.insts.get(v as usize) {
            Some(&Inst::Extend {
                value,
                kind: kind @ (LoadKind::I8 | LoadKind::I16 | LoadKind::I32),
                nsw,
            }) if nsw || self.fits_before(value, kind, v) => (value, kind),
            Some(&Inst::Extend {
                value,
                kind: LoadKind::I8 | LoadKind::I16 | LoadKind::I32,
                ..
            }) => return self.chain(value, phi, h, counters, depth - 1, out),
            _ => return false,
        };
        let options: [(ValueId, Result<ValueId, i64>); 2] = match self.func.insts.get(x as usize) {
            Some(&Inst::BinopI {
                op: BinOp::Add | BinOp::Sub,
                lhs,
                rhs_imm,
            }) => [(lhs, Err(rhs_imm)); 2],
            Some(&Inst::Binop {
                op: BinOp::Add,
                lhs,
                rhs,
            }) => [(lhs, Ok(rhs)), (rhs, Ok(lhs))],
            Some(&Inst::Binop {
                op: BinOp::Sub,
                lhs,
                rhs,
            }) => [(lhs, Ok(rhs)); 2],
            _ => return false,
        };
        for (var, step) in options {
            if self.admissible(step, phi, h, counters)
                && self.chain(var, phi, h, counters, depth - 1, out)
            {
                out.push((v, kind));
                return true;
            }
        }
        false
    }

    /// The steps of `c`'s back-edge values, if each is a chain of them.
    fn steps_of(&self, c: &Candidate, counters: bool) -> Option<Vec<(ValueId, LoadKind)>> {
        let mut out = Vec::new();
        c.back
            .iter()
            .all(|&e| self.chain(e, c.phi, c.header, counters, MAX_CHAIN, &mut out))
            .then_some(out)
    }
}

/// Per value: the kind a step, or a start, of an induction variable of
/// `func` fits over operands that fit it (`Ranges::compute_assuming`).
pub(crate) fn assumptions(func: &FunctionSsa) -> Vec<Option<LoadKind>> {
    if !may_step(func) {
        return Vec::new();
    }
    let (tin, tout) = super::dom_stamps(func);
    find_in(func, &tin, &tout)
}

/// Whether `func` has the marked extension and the phi over an extension
/// every induction variable has.
fn may_step(func: &FunctionSsa) -> bool {
    let extension = |v: ValueId| matches!(func.insts.get(v as usize), Some(Inst::Extend { .. }));
    func.insts.iter().any(|i| {
        matches!(
            i,
            Inst::Extend {
                kind: LoadKind::I8 | LoadKind::I16 | LoadKind::I32,
                nsw: true,
                ..
            }
        )
    }) && func.insts.iter().any(
        |i| matches!(i, Inst::Phi { incoming, .. } if incoming.iter().any(|&(_, v)| extension(v))),
    )
}

/// [`assumptions`] over the dominator stamps of `func`.
fn find_in(func: &FunctionSsa, tin: &[u32], tout: &[u32]) -> Vec<Option<LoadKind>> {
    let n = func.insts.len();
    let mut block_of = alloc::vec![BlockId::MAX; n];
    for (b, blk) in func.blocks.iter().enumerate() {
        for v in blk.inst_range.clone() {
            if let Some(slot) = block_of.get_mut(v as usize) {
                *slot = b as BlockId;
            }
        }
    }
    let mut marked_extension = alloc::vec![None; n];
    for (e, inst) in func.insts.iter().enumerate() {
        if let Inst::Extend {
            value, nsw: true, ..
        } = inst
            && block_of[e] != BlockId::MAX
        {
            marked_extension[*value as usize] = Some(e as ValueId);
        }
    }
    let mut walk = Walk {
        func,
        block_of,
        tin,
        tout,
        counter: alloc::vec![None; n],
        marked_extension,
    };
    let mut candidates: Vec<Candidate> = Vec::new();
    for (h, blk) in func.blocks.iter().enumerate() {
        let h = h as BlockId;
        for v in blk.inst_range.clone() {
            let Some(Inst::Phi { incoming, kind }) = func.insts.get(v as usize) else {
                continue;
            };
            if matches!(kind, LoadKind::F32 | LoadKind::F64) {
                continue;
            }
            let back: Vec<ValueId> = incoming
                .iter()
                .filter(|&&(pred, _)| walk.dominates(h, pred))
                .map(|&(_, s)| s)
                .collect();
            if !back.is_empty() {
                candidates.push(Candidate {
                    phi: v,
                    header: h,
                    back,
                });
            }
        }
    }
    // Counters: variables stepped by immediates and invariants only.
    for c in &candidates {
        let Some(found) = walk.steps_of(c, false) else {
            continue;
        };
        walk.counter[c.phi as usize] = Some(c.phi);
        for (e, _) in found {
            walk.counter[e as usize] = Some(c.phi);
            if let Some(&Inst::Extend { value, .. }) = func.insts.get(e as usize) {
                walk.counter[value as usize] = Some(c.phi);
            }
        }
    }
    let mut assumed: Vec<Option<LoadKind>> = alloc::vec![None; n];
    for c in &candidates {
        let Some(found) = walk.steps_of(c, true) else {
            continue;
        };
        for (e, kind) in found {
            // No pass hoists arithmetic, so each step stays inside its loop.
            debug_assert!(walk.dominates(c.header, walk.block_of[e as usize]));
            if let Some(&Inst::Extend { value, .. }) = func.insts.get(e as usize) {
                assumed[value as usize] = Some(kind);
            }
        }
        // The marked operations the variable starts from.
        if let Some(Inst::Phi { incoming, .. }) = func.insts.get(c.phi as usize) {
            for &(_, u) in incoming {
                if let Some(&Inst::Extend {
                    value,
                    kind: kind @ (LoadKind::I8 | LoadKind::I16 | LoadKind::I32),
                    nsw: true,
                }) = func.insts.get(u as usize)
                {
                    assumed[value as usize] = Some(kind);
                }
            }
        }
    }
    assumed
}

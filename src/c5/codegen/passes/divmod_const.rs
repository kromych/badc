//! Division and remainder by a constant, expanded to shifts, masks and
//! reciprocal multiplies.
//!
//! At `-O` the walker leaves `n / K` and `n % K` as one `BinopI`
//! (`SsaBuilder::divmod_const`), and inlining or promotion leaves a
//! register divisor that is an `Imm`. The constant folder and
//! `value_range` therefore read a division, where the expansion's
//! `n - q * K` bounds nothing. No emitter lowers the immediate form, so
//! this pass is total over it: a divisor `magic::lower_divmod` declines
//! -- zero -- goes back to the register form and the hardware divide.
//!
//! The IR operation divides the 64-bit register, and the sequence is
//! chosen from the dividend's `value_range::def_ranges` bound:
//!
//!   * below the divisor in magnitude, the quotient is 0 and the
//!     remainder is the dividend;
//!   * non-negative under a positive divisor, a signed division is the
//!     unsigned one, which needs no sign fix-up, over a numerator as
//!     wide as the bound;
//!   * the 32-bit sequences, exact only over an operand extended from
//!     32 bits, where the bound says it is one and the divisor fits;
//!   * the 64-bit sequences otherwise, which hold for any operand.
//!
//! Instructions created in one block are shared by the sites after them
//! there, so `n % K` and `n / K` compute one quotient whatever the value
//! numbering decides; across blocks that merge is `cse`'s.
//!
//! Runs after `drop_redundant_extend`, whose range rule reads the bound
//! of a remainder, and before `cse`.

use super::value_range::{self, Range};
use crate::c5::codegen::magic::{DivSink, lower_divmod, lower_udivmod};
use crate::c5::codegen::ssa::shadow::ParamRanges;
use crate::c5::codegen::ssa::tape::{self, At, Insertion};
use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, NO_VALUE, ValueId, is_divmod_op};
use alloc::vec::Vec;
use hashbrown::HashMap;

pub(crate) fn run(funcs: &mut [FunctionSsa], param_ranges: &ParamRanges) {
    for func in funcs {
        let params = param_ranges
            .get(&func.ent_pc)
            .map_or(&[][..], Vec::as_slice);
        run_one(func, params);
    }
}

/// Tag of an index into [`Steps::insts`] in an operand; an untagged
/// operand is a value of the function. Tape indices stay below it.
const STEP: ValueId = 1 << 31;

#[derive(PartialEq, Eq, Hash)]
enum Key {
    Imm(i64),
    Binop(BinOp, ValueId, ValueId),
    BinopI(BinOp, ValueId, i64),
}

/// The instructions the function's sites ask for, in order. One asked
/// for twice in a block is one instruction: the first dominates the
/// second site.
#[derive(Default)]
struct Steps {
    insts: Vec<Inst>,
    in_block: HashMap<Key, ValueId>,
}

impl Steps {
    fn push(&mut self, key: Key, inst: Inst) -> ValueId {
        *self.in_block.entry(key).or_insert_with(|| {
            self.insts.push(inst);
            STEP | (self.insts.len() - 1) as ValueId
        })
    }
}

impl DivSink for Steps {
    type Val = ValueId;

    fn imm(&mut self, k: i64) -> ValueId {
        self.push(Key::Imm(k), Inst::Imm(k))
    }

    fn binop(&mut self, op: BinOp, lhs: ValueId, rhs: ValueId) -> ValueId {
        self.push(Key::Binop(op, lhs, rhs), Inst::Binop { op, lhs, rhs })
    }

    fn binop_imm(&mut self, op: BinOp, lhs: ValueId, rhs_imm: i64) -> ValueId {
        self.push(
            Key::BinopI(op, lhs, rhs_imm),
            Inst::BinopI { op, lhs, rhs_imm },
        )
    }
}

/// `n op d` at tape index `at`. `imm_form` tells a `BinopI` from a
/// `Binop` whose divisor is an `Imm`.
struct Site {
    block: usize,
    at: ValueId,
    op: BinOp,
    n: ValueId,
    d: i64,
    imm_form: bool,
}

/// A site's share of [`Steps::insts`] and the operand that is its value.
struct Expansion {
    at: ValueId,
    owned: core::ops::Range<usize>,
    result: ValueId,
}

impl Expansion {
    /// Whether the site's own slot takes the last owned step. Otherwise
    /// every owned step goes ahead of the site and its readers move to
    /// `result`, a value that exists already.
    fn in_place(&self) -> bool {
        !self.owned.is_empty() && self.result == STEP | (self.owned.end - 1) as ValueId
    }

    fn inserted(&self) -> usize {
        self.owned.len() - self.in_place() as usize
    }
}

fn sites(func: &FunctionSsa) -> Vec<Site> {
    let imm = |v: ValueId| match func.insts.get(v as usize) {
        Some(Inst::Imm(k)) if !func.f32_values.get(v as usize).copied().unwrap_or(false) => {
            Some(*k)
        }
        _ => None,
    };
    let mut out = Vec::new();
    for (block, b) in func.blocks.iter().enumerate() {
        for at in b.inst_range.clone() {
            let (op, n, d, imm_form) = match func.insts[at as usize] {
                Inst::BinopI { op, lhs, rhs_imm } => (op, lhs, Some(rhs_imm), true),
                Inst::Binop { op, lhs, rhs } => (op, lhs, imm(rhs), false),
                _ => continue,
            };
            if let Some(d) = d.filter(|_| is_divmod_op(op)) {
                out.push(Site {
                    block,
                    at,
                    op,
                    n,
                    d,
                    imm_form,
                });
            }
        }
    }
    out.sort_unstable_by_key(|s| s.at);
    out
}

fn is_signed(op: BinOp) -> bool {
    matches!(op, BinOp::Div | BinOp::Mod)
}

fn wants_remainder(op: BinOp) -> bool {
    matches!(op, BinOp::Mod | BinOp::Modu)
}

/// Whether every dividend in `n` is below `d` in magnitude, as `op`
/// reads the two. The unsigned reading of a negative `d` is 2^63 and up.
fn below_divisor(op: BinOp, n: Range, d: i64) -> bool {
    let (lo, hi) = n.bounds();
    if is_signed(op) {
        let m = (d as i128).abs();
        -m < lo && hi < m
    } else {
        lo >= 0 && (d < 0 || hi < d as i128)
    }
}

/// The value of the site, as a function value or a step. `None` leaves
/// the instruction as it is.
fn lower(steps: &mut Steps, site: &Site, n: Range) -> Option<ValueId> {
    let Site { op, n: lhs, d, .. } = *site;
    let (lo, hi) = n.bounds();
    if d != 0 && below_divisor(op, n, d) {
        return Some(if wants_remainder(op) {
            lhs
        } else {
            steps.imm(0)
        });
    }
    // Both readings agree on a non-negative dividend and a positive
    // divisor; `below_divisor` took the unsigned negative one.
    if lo >= 0 && d > 0 {
        let narrow = hi <= u32::MAX as i128 && d <= u32::MAX as i64;
        let w = if narrow { 32 } else { 64 };
        let bits = (128 - (hi as u128).leading_zeros()).clamp(1, w);
        return lower_udivmod(steps, wants_remainder(op), lhs, d as u64, w, bits);
    }
    // The 32-bit signed sequence reads a register extended from 32 bits;
    // an unsigned dividend that can be negative is 2^63 and up.
    let narrow = is_signed(op) && n.fits(LoadKind::I32) && i32::try_from(d).is_ok();
    let lowered = lower_divmod(steps, op, lhs, d, if narrow { 32 } else { 64 });
    if lowered.is_none() && site.imm_form {
        let rhs = steps.imm(d);
        return Some(steps.binop(op, lhs, rhs));
    }
    lowered
}

fn resolve(redirect: &[Option<ValueId>], mut v: ValueId) -> ValueId {
    while let Some(Some(to)) = redirect.get(v as usize) {
        v = *to;
    }
    v
}

fn run_one(func: &mut FunctionSsa, params: &[Range]) {
    let sites = sites(func);
    if sites.is_empty() {
        return;
    }
    debug_assert!((func.insts.len() as u64) < STEP as u64);
    let ranges = value_range::def_ranges(func, params);
    let range = |v: ValueId| {
        ranges
            .get(v as usize)
            .copied()
            .unwrap_or(value_range::UNIVERSE)
    };
    let mut steps = Steps::default();
    let mut expansions: Vec<Expansion> = Vec::new();
    let mut block = usize::MAX;
    for site in &sites {
        if site.block != block {
            block = site.block;
            steps.in_block.clear();
        }
        let first = steps.insts.len();
        if let Some(result) = lower(&mut steps, site, range(site.n)) {
            expansions.push(Expansion {
                at: site.at,
                owned: first..steps.insts.len(),
                result,
            });
        }
    }
    // A slot ahead of its site for each step that does not take the
    // site's own; then the final id of every step.
    let ins: Vec<Insertion> = expansions
        .iter()
        .flat_map(|e| {
            (0..e.inserted()).map(|_| Insertion {
                at: At::Before(e.at),
                inst: Inst::Imm(0),
                is_f32: false,
            })
        })
        .collect();
    let rewrite = (!ins.is_empty()).then(|| tape::insert(func, &ins).0);
    let moved = |v: ValueId| rewrite.as_ref().map_or(v, |rw| rw.remap[v as usize]);
    let mut final_id: Vec<ValueId> = alloc::vec![NO_VALUE; steps.insts.len()];
    let mut slot = 0usize;
    for e in &expansions {
        for g in e.owned.clone() {
            final_id[g] = if e.in_place() && g + 1 == e.owned.end {
                moved(e.at)
            } else {
                slot += 1;
                rewrite.as_ref().expect("a slot per inserted step").ids[slot - 1]
            };
        }
    }
    let placed = |v: ValueId| match v & STEP != 0 {
        true => final_id[(v & !STEP) as usize],
        false => moved(v),
    };
    for (g, mut inst) in steps.insts.into_iter().enumerate() {
        inst.for_each_operand_mut(|v| *v = placed(*v));
        func.insts[final_id[g] as usize] = inst;
    }
    // A site whose value exists already hands its readers to it.
    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; func.insts.len()];
    for e in expansions.iter().filter(|e| !e.in_place()) {
        let at = moved(e.at);
        redirect[at as usize] = Some(placed(e.result));
        func.insts[at as usize] = Inst::Imm(0);
    }
    if redirect.iter().all(Option::is_none) {
        return;
    }
    for inst in func.insts.iter_mut() {
        inst.for_each_operand_mut(|v| *v = resolve(&redirect, *v));
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            block.exit_acc = resolve(&redirect, block.exit_acc);
        }
        block
            .terminator
            .for_each_operand_mut(|v| *v = resolve(&redirect, *v));
    }
}

#[cfg(test)]
mod tests;

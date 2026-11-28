//! Memory disambiguation: whether two accesses can touch a common byte.
//!
//! An address is an affine form `c + sum(k * x)` modulo 2^64 over terms: a
//! file-scope object's base, a frame slot's base, or a value the form does
//! not see through. A data image offset is relative to its object only:
//! the object writers keep an object whole but move objects apart.
//! Accesses of `wa` and `wb` bytes meet iff the difference of their forms
//! lies in `[1 - wa, wb - 1]` modulo 2^64; shared terms cancel, and what
//! remains is `c` modulo the coefficients' gcd. Unbounded terms keep only
//! the residue modulo the gcd's power-of-two part. With every term bounded
//! where its access executes ([`value_range`]: an induction variable by its
//! type under C17 6.5p5 and by the loop test that guards the access), the
//! exact residue is checked against each wrap of the window. A value both
//! forms name must hold one value at both accesses, which the caller
//! ensures. An instruction's effect on memory is unknown unless listed.

use crate::c5::codegen::passes::value_range::{self, Ranges};
use crate::c5::ir::{BinOp, BlockId, FunctionSsa, IndexExt, Inst, LoadKind, ValueId};
use crate::c5::op::Intrinsic;
use alloc::vec::Vec;

/// Terms a form keeps, past which an address is one opaque term, and
/// definitions it looks through.
const MAX_TERMS: usize = 4;
const MAX_DEPTH: u32 = 8;

#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Debug)]
pub(crate) enum Term {
    /// The base of the file-scope object whose data image offset this is.
    Object(i64),
    /// A data image offset in no object [`data_objects`] lists.
    DataAt(i64),
    /// The address of frame slot `off`.
    Slot(i64),
    /// A value the form does not see through.
    Value(ValueId),
    /// The low word of a value, sign-extended (`true`) or zero-extended,
    /// as an AArch64 indexed access reads its index.
    Ext(ValueId, bool),
}

/// `c + sum(k * x)` modulo 2^64; terms sorted, coefficients non-zero.
#[derive(Clone, PartialEq, Eq, Debug)]
pub(crate) struct Form {
    c: i64,
    terms: Vec<(Term, i64)>,
}

impl Form {
    fn constant(c: i64) -> Self {
        Form {
            c,
            terms: Vec::new(),
        }
    }

    fn term(t: Term) -> Self {
        Form {
            c: 0,
            terms: alloc::vec![(t, 1)],
        }
    }

    fn offset(mut self, k: i64) -> Self {
        self.c = self.c.wrapping_add(k);
        self
    }

    fn scale(mut self, k: i64) -> Self {
        self.c = self.c.wrapping_mul(k);
        for t in &mut self.terms {
            t.1 = t.1.wrapping_mul(k);
        }
        self.terms.retain(|t| t.1 != 0);
        self
    }

    fn plus(&self, other: &Form) -> Form {
        let mut terms = self.terms.clone();
        for &(t, k) in &other.terms {
            match terms.binary_search_by(|e| e.0.cmp(&t)) {
                Ok(i) => terms[i].1 = terms[i].1.wrapping_add(k),
                Err(i) => terms.insert(i, (t, k)),
            }
        }
        terms.retain(|t| t.1 != 0);
        Form {
            c: self.c.wrapping_add(other.c),
            terms,
        }
    }
}

/// The bytes one access covers, and the block it executes in, where the
/// bounds on its terms are read.
#[derive(Clone, Debug)]
pub(crate) struct Access {
    form: Form,
    width: u64,
    block: BlockId,
}

impl Access {
    /// The same bytes read from `block`, a dominator its terms are
    /// defined above.
    pub(crate) fn at(mut self, block: BlockId) -> Self {
        self.block = block;
        self
    }
}

pub(crate) enum Effect {
    None,
    Write(Access),
    Unknown,
}

/// The `[start, end)` data image spans of the unit's defined file-scope
/// objects, sorted: each lies whole in one section of every output.
pub(crate) fn data_objects(program: &crate::c5::program::Program) -> Vec<(i64, i64)> {
    use crate::c5::token::Token;
    let len = program.image_len() as i64;
    let mut out: Vec<(i64, i64)> = (program.symbols.iter())
        .filter(|s| {
            s.class == Token::Glo as i64
                && s.defined_here
                && !s.is_thread_local
                && (0..len).contains(&s.val)
        })
        .filter_map(|s| {
            let size = crate::c5::layout::data_object_extent(s)?.copy as i64;
            Some((s.val, s.val.checked_add(size)?.min(len)))
        })
        .collect();
    out.sort_unstable();
    out.dedup();
    out
}

/// The disambiguation queries over one function.
pub(crate) struct Alias<'o> {
    /// [`data_objects`] of the unit.
    objects: &'o [(i64, i64)],
    /// Per value: an `ImmData` another unit's symbol resolves, whose
    /// offset is not a position in this image.
    bound: Vec<bool>,
    ranges: Option<Ranges>,
}

impl<'o> Alias<'o> {
    pub(crate) fn new(func: &FunctionSsa, objects: &'o [(i64, i64)]) -> Self {
        let mut bound = alloc::vec![false; func.insts.len()];
        for &(v, _) in &func.extern_imm_data_refs {
            if let Some(b) = bound.get_mut(v as usize) {
                *b = true;
            }
        }
        Alias {
            objects,
            bound,
            ranges: None,
        }
    }

    /// The object holding data image offset `k`.
    fn object_of(&self, k: i64) -> Option<(i64, i64)> {
        let i = self.objects.partition_point(|o| o.0 <= k);
        (i > 0).then(|| self.objects[i - 1]).filter(|o| k < o.1)
    }

    fn form(&self, func: &FunctionSsa, v: ValueId, depth: u32) -> Form {
        let atom = Form::term(Term::Value(v));
        if depth == 0 {
            return atom;
        }
        let sub = |x: ValueId| self.form(func, x, depth - 1);
        let f = match func.insts.get(v as usize) {
            Some(&Inst::ImmData(k)) if !self.bound[v as usize] => match self.object_of(k) {
                Some((start, _)) => Form::term(Term::Object(start)).offset(k - start),
                None => Form::term(Term::DataAt(k)),
            },
            Some(&Inst::Imm(k)) => Form::constant(k),
            Some(&Inst::LocalAddr(off)) => Form::term(Term::Slot(off)),
            Some(&Inst::Copy {
                value,
                is_fp: false,
            }) => sub(value),
            // In a defined execution the value fits (C17 6.5p5).
            Some(&Inst::Extend {
                value, nsw: true, ..
            }) => sub(value),
            Some(&Inst::BinopI { op, lhs, rhs_imm }) => match op {
                BinOp::Add => sub(lhs).offset(rhs_imm),
                BinOp::Sub => sub(lhs).offset(rhs_imm.wrapping_neg()),
                BinOp::Mul => sub(lhs).scale(rhs_imm),
                BinOp::Shl if (0..64).contains(&rhs_imm) => sub(lhs).scale(1i64 << rhs_imm),
                _ => return atom,
            },
            Some(&Inst::Binop { op, lhs, rhs }) => match op {
                BinOp::Add => sub(lhs).plus(&sub(rhs)),
                BinOp::Sub => sub(lhs).plus(&sub(rhs).scale(-1)),
                BinOp::Mul => match product(sub(lhs), sub(rhs)) {
                    Some(f) => f,
                    None => return atom,
                },
                _ => return atom,
            },
            Some(&Inst::MulAdd {
                a,
                b,
                c,
                neg_product,
            }) => match product(sub(a), sub(b)) {
                Some(p) => sub(c).plus(&p.scale(if neg_product { -1 } else { 1 })),
                None => return atom,
            },
            Some(&Inst::ShiftOp {
                op,
                lhs,
                rhs,
                shift: BinOp::Shl,
                amount,
            }) if amount < 64 => {
                let r = sub(rhs).scale(1i64 << amount);
                match op {
                    BinOp::Add => sub(lhs).plus(&r),
                    BinOp::Sub => sub(lhs).plus(&r.scale(-1)),
                    _ => return atom,
                }
            }
            _ => return atom,
        };
        if f.terms.len() <= MAX_TERMS { f } else { atom }
    }

    /// The bytes instruction `v` of `block` reads or writes: a
    /// non-volatile load or store, through a pointer or of a frame slot.
    pub(crate) fn access(&self, func: &FunctionSsa, v: ValueId, block: BlockId) -> Option<Access> {
        let (form, width) = match *func.insts.get(v as usize)? {
            Inst::Load {
                addr,
                disp,
                kind,
                volatile: false,
                ..
            } => (
                self.form(func, addr, MAX_DEPTH).offset(disp as i64),
                kind.bytes(),
            ),
            Inst::Store {
                addr,
                disp,
                kind,
                volatile: false,
                ..
            } => (
                self.form(func, addr, MAX_DEPTH).offset(disp as i64),
                kind.bytes(),
            ),
            Inst::LoadIndexed {
                base,
                index,
                index_ext,
                scale,
                kind,
                ..
            } => (
                self.indexed(func, base, index, index_ext, scale),
                kind.bytes(),
            ),
            Inst::StoreIndexed {
                base,
                index,
                index_ext,
                scale,
                kind,
                ..
            } => (
                self.indexed(func, base, index, index_ext, scale),
                kind.bytes(),
            ),
            Inst::LoadLocal {
                off,
                disp,
                kind,
                volatile: false,
            } => (
                Form::term(Term::Slot(off)).offset(disp as i64),
                kind.bytes(),
            ),
            Inst::StoreLocal {
                off,
                disp,
                kind,
                volatile: false,
                ..
            } => (
                Form::term(Term::Slot(off)).offset(disp as i64),
                kind.bytes(),
            ),
            _ => return None,
        };
        (width != 0).then_some(Access {
            form,
            width: width as u64,
            block,
        })
    }

    /// `base + index * scale`, the index read as `index_ext` says.
    fn indexed(
        &self,
        func: &FunctionSsa,
        base: ValueId,
        index: ValueId,
        index_ext: IndexExt,
        scale: u8,
    ) -> Form {
        let index = match index_ext {
            IndexExt::None => self.form(func, index, MAX_DEPTH - 1),
            IndexExt::Sxtw => Form::term(Term::Ext(index, true)),
            IndexExt::Uxtw => Form::term(Term::Ext(index, false)),
        };
        self.form(func, base, MAX_DEPTH - 1)
            .plus(&index.scale(scale as i64))
    }

    /// What instruction `v` of `block` does to memory.
    pub(crate) fn effect(&self, func: &FunctionSsa, v: ValueId, block: BlockId) -> Effect {
        let Some(inst) = func.insts.get(v as usize) else {
            return Effect::Unknown;
        };
        match inst {
            Inst::Store {
                volatile: false, ..
            }
            | Inst::StoreLocal {
                volatile: false, ..
            }
            | Inst::StoreIndexed { .. } => self
                .access(func, v, block)
                .map_or(Effect::Unknown, Effect::Write),
            Inst::Load {
                volatile: false, ..
            }
            | Inst::LoadLocal {
                volatile: false, ..
            }
            | Inst::LoadIndexed { .. }
            | Inst::SegLoad {
                volatile: false, ..
            }
            | Inst::Imm(_)
            | Inst::Undef
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::ImmExtCode(_)
            | Inst::BlockAddr(_)
            | Inst::LocalAddr(_)
            | Inst::TlsAddr(_)
            | Inst::ParentLocalAddr { .. }
            | Inst::Binop { .. }
            | Inst::BinopI { .. }
            | Inst::Neg(_)
            | Inst::Fneg(_)
            | Inst::Fma { .. }
            | Inst::MulAdd { .. }
            | Inst::ShiftOp { .. }
            | Inst::BitField { .. }
            | Inst::Udiv128 { .. }
            | Inst::Extend { .. }
            | Inst::Bswap { .. }
            | Inst::BitCount { .. }
            | Inst::Copy { .. }
            | Inst::FpCast { .. }
            | Inst::ParamRef { .. }
            | Inst::ParamPart { .. }
            | Inst::SimdVal { .. }
            | Inst::VecBinop { .. }
            | Inst::VecInsert { .. }
            | Inst::VecSplat { .. }
            | Inst::VecConst { .. }
            | Inst::VecExtract { .. }
            | Inst::Select { .. }
            | Inst::Phi { .. } => Effect::None,
            // One instruction on both targets: no library fallback, no
            // `errno`.
            Inst::Intrinsic { kind, .. }
                if Intrinsic::from_i64(*kind).is_some_and(|i| i.is_fp_unary()) =>
            {
                Effect::None
            }
            _ => Effect::Unknown,
        }
    }

    /// Bounds on `t` where an instruction of `block` reads it.
    fn bounds(&mut self, func: &FunctionSsa, block: BlockId, t: Term) -> (i128, i128) {
        let (v, ext) = match t {
            Term::Value(v) => (v, None),
            Term::Ext(v, signed) => (v, Some(signed)),
            _ => return value_range::UNIVERSE.bounds(),
        };
        let ranges = self.ranges.get_or_insert_with(|| {
            Ranges::compute_assuming(func, &[], &value_range::iv::assumptions(func))
        });
        let r = ranges.at(block, v).bounds();
        // The extension is the identity on a range its word holds.
        let word = match ext {
            None => return r,
            Some(true) => (i32::MIN as i128, i32::MAX as i128),
            Some(false) => (0, u32::MAX as i128),
        };
        if word.0 <= r.0 && r.1 <= word.1 {
            r
        } else {
            word
        }
    }

    /// Whether `a` and `b` touch no common byte.
    pub(crate) fn disjoint(&mut self, func: &FunctionSsa, a: &Access, b: &Access) -> bool {
        let diff = a.form.plus(&b.form.clone().scale(-1));
        let lo = 1 - a.width as i128;
        let hi = b.width as i128 - 1;
        let g = (diff.terms.iter()).fold(0u128, |g, t| gcd(g, t.1.unsigned_abs() as u128));
        if !residue_meets(diff.c, g.isolate_lowest_one(), lo, hi) {
            return true;
        }
        // A base term has no bound, nor has a sum it is part of. A pointer
        // -- a full-width value read from memory, a parameter or a call's
        // result -- is taken as unbounded too, sparing the range analysis:
        // only a branch on the pointer itself could bound it.
        let pointer = |v: ValueId| {
            matches!(
                func.insts.get(v as usize),
                Some(
                    Inst::Load {
                        kind: LoadKind::I64,
                        ..
                    } | Inst::LoadLocal {
                        kind: LoadKind::I64,
                        ..
                    } | Inst::LoadIndexed {
                        kind: LoadKind::I64,
                        ..
                    } | Inst::ParamRef {
                        kind: LoadKind::I64,
                        ..
                    } | Inst::Call { .. }
                        | Inst::CallExt { .. }
                        | Inst::CallIndirect { .. }
                )
            )
        };
        let unbounded = |t: &(Term, i64)| match t.0 {
            Term::Value(v) => t.1.unsigned_abs() == 1 && pointer(v),
            Term::Ext(..) => false,
            _ => true,
        };
        if g == 0 || diff.terms.iter().any(unbounded) {
            return false;
        }
        // A term of either side is read where that side executes; one both
        // name holds one value, inside both bounds.
        let mut span: Vec<(i64, (i128, i128))> = Vec::with_capacity(diff.terms.len());
        for &(t, k) in &diff.terms {
            let in_a = a.form.terms.iter().any(|e| e.0 == t);
            let in_b = b.form.terms.iter().any(|e| e.0 == t);
            let mut r = value_range::UNIVERSE.bounds();
            if in_a {
                r = meet(r, self.bounds(func, a.block, t));
            }
            if in_b {
                r = meet(r, self.bounds(func, b.block, t));
            }
            if r.0 > r.1 {
                return true;
            }
            span.push((k, r));
        }
        !bounded_meets(diff.c, g, &span, lo, hi)
    }

    /// Whether every byte `a` covers lies in the file-scope object its
    /// base names, for every value its terms take where it executes.
    pub(crate) fn in_object(&mut self, func: &FunctionSsa, a: &Access) -> bool {
        let mut span: Vec<(i64, (i128, i128))> = Vec::new();
        let mut base = None;
        for &(t, k) in &a.form.terms {
            match t {
                Term::Object(start) if k == 1 => base = Some(start),
                Term::Value(_) | Term::Ext(..) => span.push((k, self.bounds(func, a.block, t))),
                _ => return false,
            }
        }
        let Some((start, end)) = base.and_then(|start| self.object_of(start)) else {
            return false;
        };
        let size = (end - start) as i128;
        sum_bounds(a.form.c, &span).is_some_and(|(lo, hi)| lo >= 0 && hi + a.width as i128 <= size)
    }
}

/// The product of two forms one of which is a constant.
fn product(a: Form, b: Form) -> Option<Form> {
    match (a.terms.is_empty(), b.terms.is_empty()) {
        (true, _) => Some(b.scale(a.c)),
        (_, true) => Some(a.scale(b.c)),
        _ => None,
    }
}

fn meet(a: (i128, i128), b: (i128, i128)) -> (i128, i128) {
    (a.0.max(b.0), a.1.min(b.1))
}

fn gcd(a: u128, b: u128) -> u128 {
    if b == 0 { a } else { gcd(b, a % b) }
}

/// Bounds on `c + sum(k * x)`, each `x` within its bounds, or `None` past
/// what `i128` holds.
fn sum_bounds(c: i64, span: &[(i64, (i128, i128))]) -> Option<(i128, i128)> {
    let (mut lo, mut hi) = (c as i128, c as i128);
    for &(k, (xl, xh)) in span {
        let (p, q) = ((k as i128).checked_mul(xl)?, (k as i128).checked_mul(xh)?);
        lo = lo.checked_add(p.min(q))?;
        hi = hi.checked_add(p.max(q))?;
    }
    Some((lo, hi))
}

/// Whether some `t` in `[lo, hi]` is `c` modulo `m`, a power of two up to
/// 2^64; `m == 0` stands for 2^64, the register's own modulus.
fn residue_meets(c: i64, m: u128, lo: i128, hi: i128) -> bool {
    let m = if m == 0 { 1i128 << 64 } else { m as i128 };
    let t = lo + (c as i128 - lo).rem_euclid(m);
    t <= hi
}

/// Whether `e = c + sum(k * x)`, each `x` within its bounds, can lie in
/// `[lo, hi]` modulo 2^64. `e` is `c` modulo `g`, the coefficients' gcd;
/// a span of 2^64 or more says no more than [`residue_meets`] does.
fn bounded_meets(c: i64, g: u128, span: &[(i64, (i128, i128))], lo: i128, hi: i128) -> bool {
    const WRAP: i128 = 1 << 64;
    let Some((elo, ehi)) = sum_bounds(c, span).filter(|&(l, h)| h - l < WRAP) else {
        return true;
    };
    let g = g as i128;
    let first = (elo - hi).div_euclid(WRAP);
    let last = (ehi - lo).div_euclid(WRAP) + 1;
    (first..=last).any(|m| {
        let s_lo = elo.max(lo + m * WRAP);
        let s_hi = ehi.min(hi + m * WRAP);
        s_lo <= s_hi && s_lo + (c as i128 - s_lo).rem_euclid(g) <= s_hi
    })
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{AsmBlock, Block, LoadKind, MemOrder, StoreKind, Terminator};

    fn func(insts: Vec<Inst>) -> FunctionSsa {
        let n = insts.len() as u32;
        FunctionSsa {
            inst_src: alloc::vec![crate::c5::ir::InstSrc::default(); n as usize],
            f32_values: alloc::vec![false; n as usize],
            insts,
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: Terminator::Return(Some(0)),
            }],
            ..Default::default()
        }
    }

    fn param(idx: u32) -> Inst {
        Inst::ParamRef {
            idx,
            kind: LoadKind::I64,
        }
    }

    fn load(addr: ValueId, disp: i32) -> Inst {
        Inst::Load {
            addr,
            disp,
            kind: LoadKind::I64,
            volatile: false,
            align: 0,
            pc_rel: false,
        }
    }

    fn store(addr: ValueId, disp: i32, kind: StoreKind) -> Inst {
        Inst::Store {
            addr,
            disp,
            value: 0,
            kind,
            volatile: false,
            align: 0,
            pc_rel: false,
        }
    }

    fn binop_i(op: BinOp, lhs: ValueId, rhs_imm: i64) -> Inst {
        Inst::BinopI { op, lhs, rhs_imm }
    }

    fn add(lhs: ValueId, rhs: ValueId) -> Inst {
        Inst::Binop {
            op: BinOp::Add,
            lhs,
            rhs,
        }
    }

    fn apart(f: &FunctionSsa, a: ValueId, b: ValueId) -> bool {
        let mut q = Alias::new(f, &[]);
        let (x, y) = (q.access(f, a, 0).unwrap(), q.access(f, b, 0).unwrap());
        q.disjoint(f, &x, &y) && q.disjoint(f, &y, &x)
    }

    /// One base compares offsets; two unrelated bases may always meet.
    #[test]
    fn one_base_compares_offsets_and_two_bases_meet() {
        let f = func(alloc::vec![
            param(0),
            param(1),
            load(0, 0),
            store(0, 8, StoreKind::I64),
            store(0, 4, StoreKind::I32),
            store(1, 64, StoreKind::I64),
            binop_i(BinOp::Add, 0, 16),
            load(6, -8),
        ]);
        assert!(apart(&f, 2, 3));
        assert!(!apart(&f, 2, 4));
        assert!(!apart(&f, 2, 5));
        assert!(!apart(&f, 7, 3));
        assert!(apart(&f, 7, 4));
    }

    /// Unbounded rows of 64 bytes keep fields apart, of 56 bytes do not.
    #[test]
    fn a_power_of_two_stride_needs_no_bounds_and_another_stride_does() {
        let rows = |op: BinOp, k: i64| {
            func(alloc::vec![
                param(0),
                param(1),
                param(2),
                binop_i(op, 1, k),
                add(0, 3),
                binop_i(op, 2, k),
                add(0, 5),
                load(4, 0),
                store(6, 24, StoreKind::I64),
                store(6, 4, StoreKind::I32),
            ])
        };
        let f = rows(BinOp::Shl, 6);
        assert!(apart(&f, 7, 8));
        assert!(!apart(&f, 7, 9));
        let f = rows(BinOp::Mul, 56);
        assert!(!apart(&f, 7, 8));
    }

    /// Bounded rows of 56 bytes keep fields apart, not the next row's.
    #[test]
    fn bounded_rows_of_another_stride_keep_fields_apart() {
        let f = func(alloc::vec![
            param(0),
            param(1),
            param(2),
            binop_i(BinOp::And, 1, 7),
            binop_i(BinOp::And, 2, 7),
            binop_i(BinOp::Mul, 3, 56),
            add(0, 5),
            binop_i(BinOp::Mul, 4, 56),
            add(0, 7),
            load(6, 0),
            store(8, 24, StoreKind::I64),
            store(8, 56, StoreKind::I64),
        ]);
        assert!(apart(&f, 9, 10));
        assert!(!apart(&f, 9, 11));
    }

    /// An indexed store covers what its index, as the access reads it, reaches.
    #[test]
    fn an_indexed_store_covers_what_its_index_reaches() {
        let indexed = |index, index_ext| Inst::StoreIndexed {
            base: 0,
            index,
            index_ext,
            scale: 4,
            value: 0,
            kind: StoreKind::I32,
            abs_base: false,
        };
        let f = func(alloc::vec![
            param(0),
            param(1),
            binop_i(BinOp::And, 1, 7),
            load(0, 64),
            indexed(2, IndexExt::Sxtw),
            indexed(2, IndexExt::None),
            indexed(1, IndexExt::Uxtw),
            load(0, 28),
        ]);
        assert!(apart(&f, 3, 4));
        assert!(apart(&f, 3, 5));
        assert!(!apart(&f, 3, 6));
        assert!(!apart(&f, 7, 4));
        let q = Alias::new(&f, &[]);
        assert!(matches!(q.effect(&f, 4, 0), Effect::Write(_)));
    }

    /// A marked extension is the identity; an unmarked one is opaque.
    #[test]
    fn a_marked_extension_keeps_an_even_index_even() {
        let even = |nsw| {
            func(alloc::vec![
                param(0),
                param(1),
                binop_i(BinOp::Shl, 1, 1),
                Inst::Extend {
                    value: 2,
                    kind: LoadKind::I32,
                    nsw,
                },
                binop_i(BinOp::Shl, 3, 3),
                add(0, 4),
                store(5, 0, StoreKind::I64),
                load(0, 8),
            ])
        };
        assert!(apart(&even(true), 6, 7));
        assert!(!apart(&even(false), 6, 7));
    }

    /// A difference past the signed range wraps onto the window.
    #[test]
    fn a_difference_wraps_onto_the_window() {
        let k = i64::MAX;
        assert!(bounded_meets(k, k as u128, &[(k, (1, 1))], -7, 7));
        assert!(!bounded_meets(0, 16, &[(16, (-4, 4))], 4, 11));
        assert!(!residue_meets(-8, 16, -7, 7));
        assert!(residue_meets(-8, 8, -7, 7));
    }

    /// The object holds the access's last byte for every index value.
    #[test]
    fn an_access_in_its_object_holds_its_width() {
        let f = func(alloc::vec![
            Inst::ImmData(80),
            param(0),
            binop_i(BinOp::And, 1, 3),
            binop_i(BinOp::Mul, 2, 56),
            add(0, 3),
            load(4, 8),
            binop_i(BinOp::Mul, 1, 56),
            add(0, 6),
            load(7, 8),
        ]);
        let fits = |end: i64, v: ValueId| {
            let objects = [(0, 80), (80, end)];
            let mut q = Alias::new(&f, &objects);
            let a = q.access(&f, v, 0).unwrap();
            q.in_object(&f, &a)
        };
        assert!(fits(80 + 3 * 56 + 16, 5));
        assert!(!fits(80 + 3 * 56 + 15, 5));
        assert!(!fits(i64::MAX, 8));
        let mut q = Alias::new(&f, &[]);
        let a = q.access(&f, 5, 0).unwrap();
        assert!(!q.in_object(&f, &a));
    }

    /// Offsets compare within one object; two objects may always meet.
    #[test]
    fn data_offsets_compare_within_one_object_only() {
        let f = func(alloc::vec![
            Inst::ImmData(80),
            Inst::ImmData(104),
            Inst::ImmData(200),
            load(0, 0),
            store(1, 0, StoreKind::I64),
            store(1, -24, StoreKind::I64),
            store(2, 0, StoreKind::I64),
        ]);
        let objects = [(80, 136), (136, 300)];
        let mut q = Alias::new(&f, &objects);
        let x = q.access(&f, 3, 0).unwrap();
        let w: Vec<Access> = (4..7).map(|v| q.access(&f, v, 0).unwrap()).collect();
        assert!(q.disjoint(&f, &x, &w[0]));
        assert!(!q.disjoint(&f, &x, &w[1]));
        assert!(!q.disjoint(&f, &x, &w[2]));
    }

    /// Volatile, atomic, fence, setjmp, asm, block and unlisted intrinsic
    /// effects are unknown; one-instruction floating intrinsics are none.
    #[test]
    fn effects_are_unknown_unless_listed() {
        let intrinsic = |k: Intrinsic| Inst::Intrinsic {
            kind: k as i64,
            args: alloc::vec![0],
        };
        let asm = |clobber_memory| Inst::InlineAsm {
            asm: alloc::boxed::Box::new(AsmBlock {
                template: Vec::new(),
                operands: Vec::new(),
                clobber_regs: 0,
                clobber_fp_regs: 0,
                clobber_memory,
            }),
            args: Vec::new(),
        };
        let unknown = alloc::vec![
            Inst::Load {
                addr: 0,
                disp: 0,
                kind: LoadKind::I64,
                volatile: true,
                align: 0,
                pc_rel: false,
            },
            Inst::Store {
                addr: 0,
                disp: 0,
                value: 0,
                kind: StoreKind::I64,
                volatile: true,
                align: 0,
                pc_rel: false,
            },
            Inst::SegLoad {
                addr: 0,
                kind: LoadKind::I64,
                volatile: true,
                seg: crate::c5::ir::AsmSeg::Gs,
            },
            Inst::AtomicLoad {
                addr: 0,
                width: 8,
                order: MemOrder::Relaxed,
            },
            Inst::AtomicStore {
                addr: 0,
                value: 0,
                width: 8,
                order: MemOrder::Relaxed,
            },
            intrinsic(Intrinsic::AtomicThreadFence),
            intrinsic(Intrinsic::AtomicSignalFence),
            intrinsic(Intrinsic::AtomicAcquireFence),
            intrinsic(Intrinsic::AtomicReleaseFence),
            intrinsic(Intrinsic::SetjmpAArch64),
            intrinsic(Intrinsic::LongjmpAArch64),
            intrinsic(Intrinsic::Popcount),
            intrinsic(Intrinsic::CpuRelax),
            asm(false),
            asm(true),
            Inst::Mzero {
                dst: 0,
                size: 8,
                align: 8,
            },
            Inst::Mcpy {
                dst: 0,
                src: 0,
                size: 8,
                align: 8,
            },
            Inst::LifetimeEnd(-2),
            Inst::AllocaInit(0),
        ];
        let none = [
            Intrinsic::Sqrt,
            Intrinsic::Sqrtf,
            Intrinsic::Fabs,
            Intrinsic::Fabsf,
            Intrinsic::Floor,
            Intrinsic::Floorf,
            Intrinsic::Ceil,
            Intrinsic::Ceilf,
            Intrinsic::Trunc,
            Intrinsic::Truncf,
        ];
        let n_unknown = unknown.len() as ValueId;
        let mut insts = alloc::vec![param(0)];
        insts.extend(unknown);
        insts.extend(none.iter().map(|&k| intrinsic(k)));
        insts.push(load(0, 0));
        insts.push(Inst::SegLoad {
            addr: 0,
            kind: LoadKind::I64,
            volatile: false,
            seg: crate::c5::ir::AsmSeg::Gs,
        });
        let f = func(insts);
        let q = Alias::new(&f, &[]);
        for v in 1..=n_unknown {
            assert!(
                matches!(q.effect(&f, v, 0), Effect::Unknown),
                "{:?}",
                f.insts[v as usize]
            );
        }
        for v in n_unknown + 1..f.insts.len() as ValueId {
            assert!(
                matches!(q.effect(&f, v, 0), Effect::None),
                "{:?}",
                f.insts[v as usize]
            );
        }
    }
}

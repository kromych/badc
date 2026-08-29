//! Folds over the storage of a `const` object with static duration.
//!
//! C99 6.7.3p5 makes modifying an object defined with a const-qualified
//! type undefined, so such an object holds what its initializer put there
//! for the whole execution. Two folds follow, both `-O` only (a `const`
//! object is not a constant expression, C99 6.6):
//!
//!   * [`fold_loads`] replaces a non-volatile integer load from the
//!     object's image with the initializer's value: the image bytes, or
//!     for a slot a relocation patches, the address constant (C99 6.6p9)
//!     the slot receives at link time. A pointer object then has no
//!     reader left, and the data compaction drops it.
//!   * [`run`] replaces `load(member) == 0` with `0` and `!= 0` with `1`
//!     when `member` carries a data relocation: the member holds a
//!     link-time address, which is never null. The load stays, so any
//!     other use of the loaded value is unaffected.
//!
//! Both feed `constfold_branch`, which then deletes the arm a guard on
//! the value makes unreachable -- the shape a build-time assertion, or a
//! call to an `__attribute__((error))` helper, is compiled into.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use crate::c5::codegen::ssa::tape::{self, Insertion};
use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, Terminator, ValueId};
use crate::c5::program::Program;
use crate::c5::symbol::Linkage;
use crate::c5::token::Token;

/// An address constant a relocated slot receives at link time, in the
/// form the IR materializes it.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum AddrConst {
    /// `disp` bytes past the object at `base` in this unit's data.
    Data { base: i64, disp: i64 },
    /// `disp` bytes past another unit's data symbol, by symbol index.
    Extern { sym: u32, disp: i64 },
    /// A function, by entry pc.
    Code(usize),
}

impl AddrConst {
    fn disp(self) -> i64 {
        match self {
            AddrConst::Data { disp, .. } | AddrConst::Extern { disp, .. } => disp,
            AddrConst::Code(_) => 0,
        }
    }

    fn displaced(self, by: i64) -> Self {
        match self {
            AddrConst::Data { base, disp } => AddrConst::Data {
                base,
                disp: disp.wrapping_add(by),
            },
            AddrConst::Extern { sym, disp } => AddrConst::Extern {
                sym,
                disp: disp.wrapping_add(by),
            },
            AddrConst::Code(pc) => AddrConst::Code(pc),
        }
    }

    /// The base as the walker materializes the same address; an
    /// `Extern` base also needs the reference-table entry [`bind`] adds.
    fn base(self) -> Inst {
        match self {
            AddrConst::Data { base, .. } => Inst::ImmData(base),
            AddrConst::Extern { .. } => Inst::ImmData(0),
            AddrConst::Code(pc) => Inst::ImmCode(pc),
        }
    }
}

/// The value of a byte range of const data: the image bytes, zero-extended
/// to eight, or the address a relocation patches into the range.
pub(crate) enum ConstValue {
    Bytes([u8; 8]),
    Addr(AddrConst),
}

/// Const-data view for folding loads of `const` objects: the `[lo, hi)`
/// byte ranges of const-qualified, defined, initialized static-duration
/// objects -- scalar, aggregate or array -- whose image already holds
/// their value, the data-segment offsets a relocation patches with the
/// address each receives, and the data image itself.
pub(crate) struct ConstData<'a> {
    intervals: Vec<(i64, i64)>,
    /// Ascending by offset. `None` marks a slot whose value has no IR
    /// form: a `&&label`, an unresolvable symbol.
    relocs: Vec<(i64, Option<AddrConst>)>,
    data: &'a [u8],
}

impl<'a> ConstData<'a> {
    pub(crate) fn build(program: &'a Program) -> Self {
        let mut intervals: Vec<(i64, i64)> = program
            .symbols
            .iter()
            .filter(|s| {
                s.class == Token::Glo as i64
                    && s.storage_is_const
                    && s.has_initializer
                    && s.defined_here
                    && s.reserved_data_bytes > 0
                    // A thread-local object's bytes live in `tls_data`;
                    // `val` would index the wrong image here.
                    && !s.is_thread_local
                    // An object filled by stores at its declaration point
                    // (a `&&label` element) leaves the image zeroed.
                    && !s.runtime_initialized
                    // A strong definition elsewhere replaces a weak one at
                    // link time, so this image is not necessarily the
                    // object's value.
                    && !s.is_weak
            })
            .map(|s| (s.val, s.val + s.reserved_data_bytes))
            .collect();
        // Anonymous immutable data: string literals (C99 6.4.5p6),
        // `__func__` arrays, and staged local-initializer templates.
        // Nothing can write them; their image is their value.
        intervals.extend(program.const_data_ranges.iter().copied());
        let data_len = program.data.len() as i64;
        // A data symbol's address by link name, as the walker resolves a
        // reference: this unit's definition, else the extern declaration.
        let mut by_name: BTreeMap<&str, AddrConst> = BTreeMap::new();
        for (i, s) in program.symbols.iter().enumerate() {
            if s.class != Token::Glo as i64 || s.is_thread_local {
                continue;
            }
            if s.defined_here && !s.is_weak && (0..data_len).contains(&s.val) {
                by_name.insert(
                    s.link_name(),
                    AddrConst::Data {
                        base: s.val,
                        disp: 0,
                    },
                );
            } else if s.is_extern_decl
                && s.linkage == Linkage::External
                && !s.defined_here
                && s.val == 0
            {
                by_name.entry(s.link_name()).or_insert(AddrConst::Extern {
                    sym: i as u32,
                    disp: 0,
                });
            }
        }
        // Every form of data relocation: the slot's value is the address.
        let mut relocs: Vec<(i64, Option<AddrConst>)> = Vec::new();
        for r in &program.data_relocs {
            let (base, target) = (r.target_anchor as i64, r.target_offset as i64);
            let addr = (0..data_len).contains(&base).then_some(AddrConst::Data {
                base,
                disp: target.wrapping_sub(base),
            });
            relocs.push((r.data_offset as i64, addr));
        }
        for r in &program.extern_data_relocs {
            let addr = by_name
                .get(r.symbol_name.as_str())
                .map(|a| a.displaced(r.addend));
            relocs.push((r.data_offset as i64, addr));
        }
        // A code slot names a body of this unit or an import placeholder
        // the emitters resolve by name, as `ImmCode` does either way.
        for r in &program.code_relocs {
            let pc = r.target_ent_pc as usize;
            relocs.push((r.data_offset as i64, Some(AddrConst::Code(pc))));
        }
        relocs.extend(
            program
                .label_data_slots()
                .map(|(off, _)| (off as i64, None)),
        );
        relocs.sort_unstable_by_key(|&(off, _)| off);
        ConstData {
            intervals,
            relocs,
            data: &program.data,
        }
    }

    /// The value of `[off, off + width)` when the whole read sits inside
    /// one const interval: the image bytes, zero-extended to eight, when
    /// it overlaps no relocation slot; the patched address when it is
    /// exactly one slot. An offset at or past the image end belongs to a
    /// wholly-zero, relocation-free object the data compaction moved to
    /// the `.bss` region, which every writer maps to a zero-filled vaddr
    /// range; its value is zero.
    fn read(&self, off: i64, width: i64) -> Option<ConstValue> {
        if !self
            .intervals
            .iter()
            .any(|&(lo, hi)| off >= lo && off + width <= hi)
        {
            return None;
        }
        // A relocation patches 8 bytes at its offset with a link-time
        // address; a partial read of one has no value here.
        let i = self.relocs.partition_point(|&(r, _)| r + 8 <= off);
        if let Some(&(r, addr)) = self.relocs.get(i).filter(|&&(r, _)| r < off + width) {
            return (r == off && width == 8)
                .then_some(addr)
                .flatten()
                .map(ConstValue::Addr);
        }
        let mut raw = [0u8; 8];
        if off >= self.data.len() as i64 {
            return Some(ConstValue::Bytes(raw));
        }
        let bytes = self.data.get(off as usize..(off + width) as usize)?;
        raw[..width as usize].copy_from_slice(bytes);
        Some(ConstValue::Bytes(raw))
    }
}

/// What a folded load becomes.
#[derive(Clone, Copy)]
enum Folded {
    Imm(i64),
    Addr(AddrConst),
}

impl Folded {
    /// Every emission target is little-endian; `kind` sets the extension.
    fn of(value: ConstValue, kind: LoadKind) -> Self {
        let raw = match value {
            ConstValue::Addr(a) => return Folded::Addr(a),
            ConstValue::Bytes(raw) => raw,
        };
        let u = u64::from_le_bytes(raw);
        Folded::Imm(match kind {
            LoadKind::I8 => u as u8 as i8 as i64,
            LoadKind::I16 => u as u16 as i16 as i64,
            LoadKind::I32 => u as u32 as i32 as i64,
            _ => u as i64,
        })
    }
}

/// Width of an integer load; the FP kinds keep their register class.
fn int_width(kind: LoadKind) -> Option<i64> {
    match kind {
        LoadKind::I8 | LoadKind::U8 => Some(1),
        LoadKind::I16 | LoadKind::U16 => Some(2),
        LoadKind::I32 | LoadKind::U32 => Some(4),
        LoadKind::I64 => Some(8),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => None,
    }
}

/// An `Extern` base names its symbol through the reference table.
fn bind(func: &mut FunctionSsa, v: ValueId, a: AddrConst) {
    if let AddrConst::Extern { sym, .. } = a {
        func.extern_imm_data_refs.push((v, sym));
    }
}

/// Rewrite each folded load. A displaced address is its base plus an
/// add; inserting the base ahead of the load renumbers the tape, so the
/// rewrites go through the remap. Returns whether any load was rewritten.
fn apply(func: &mut FunctionSsa, folds: &mut [(ValueId, Folded)]) -> bool {
    if folds.is_empty() {
        return false;
    }
    folds.sort_unstable_by_key(|&(at, _)| at);
    let ins: Vec<Insertion> = folds
        .iter()
        .filter_map(|&(at, f)| match f {
            Folded::Addr(a) if a.disp() != 0 => Some(Insertion {
                at,
                inst: a.base(),
                is_f32: false,
            }),
            _ => None,
        })
        .collect();
    let rewrite = (!ins.is_empty()).then(|| tape::insert(func, &ins).0);
    let mut bases = rewrite
        .as_ref()
        .map_or(&[][..], |r| r.ids.as_slice())
        .iter();
    for &(at, f) in folds.iter() {
        let i = rewrite.as_ref().map_or(at, |r| r.remap[at as usize]);
        let inst = match f {
            Folded::Imm(v) => Inst::Imm(v),
            Folded::Addr(a) if a.disp() == 0 => {
                bind(func, i, a);
                a.base()
            }
            Folded::Addr(a) => {
                let base = *bases
                    .next()
                    .expect("one inserted base per displaced address");
                bind(func, base, a);
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: base,
                    rhs_imm: a.disp(),
                }
            }
        };
        func.insts[i as usize] = inst;
    }
    true
}

/// Instruction indices whose `Inst::ImmData` payload is a link-time
/// placeholder for an extern symbol rather than an offset into this
/// unit's data. `extern_imm_data_refs` is the emitter's own record of
/// which `ImmData` instructions the linker retargets.
fn extern_imm_data(func: &FunctionSsa) -> BTreeSet<u32> {
    func.extern_imm_data_refs.iter().map(|&(i, _)| i).collect()
}

/// Resolve `v` to a data-segment offset when it is an `ImmData` plus a
/// folded constant displacement chain, chasing degenerate phis -- the
/// residue a pruned branch leaves between an inlined accessor's return
/// and its consumer. An `ImmData` naming an extern symbol resolves to
/// nothing: its payload is a placeholder, so the bytes at that offset
/// belong to an unrelated object of this unit.
fn data_addr(func: &FunctionSsa, ext: &BTreeSet<u32>, mut v: ValueId, mut off: i64) -> Option<i64> {
    for _ in 0..16 {
        match func.insts.get(v as usize)? {
            Inst::ImmData(_) if ext.contains(&v) => return None,
            Inst::ImmData(base) => return Some(base.wrapping_add(off)),
            Inst::BinopI {
                op: BinOp::Add,
                lhs,
                rhs_imm,
            } => {
                off = off.wrapping_add(*rhs_imm);
                v = *lhs;
            }
            Inst::BinopI {
                op: BinOp::Sub,
                lhs,
                rhs_imm,
            } => {
                off = off.wrapping_sub(*rhs_imm);
                v = *lhs;
            }
            Inst::Phi { incoming, .. } if incoming.len() == 1 => v = incoming[0].1,
            _ => return None,
        }
    }
    None
}

/// Fold non-volatile integer loads from const, initialized data into the
/// initializer's value (C99 6.7.3: a const object's stored value cannot
/// be modified, so the image is the object's value for the whole
/// execution). Returns true when any load folded. Runs inside the branch
/// fold's fixed point so a load whose address becomes constant only
/// after a phi collapses still folds.
pub(crate) fn fold_loads(func: &mut FunctionSsa, cd: &ConstData<'_>) -> bool {
    let ext = extern_imm_data(func);
    let mut folds: Vec<(ValueId, Folded)> = Vec::new();
    for i in func.blocks.iter().flat_map(|b| b.inst_range.clone()) {
        let Inst::Load {
            addr,
            disp,
            kind,
            volatile: false,
            ..
        } = func.insts[i as usize]
        else {
            continue;
        };
        let Some(width) = int_width(kind) else {
            continue;
        };
        let Some(off) = data_addr(func, &ext, addr, disp as i64) else {
            continue;
        };
        let Some(value) = cd.read(off, width) else {
            continue;
        };
        folds.push((i, Folded::of(value, kind)));
    }
    apply(func, &mut folds)
}

/// Resolve `v` to a frame byte coordinate: `LocalAddr(slot)` addresses
/// byte `slot * 8` of the 8-byte cell array, plus any folded constant
/// displacement, through degenerate phis.
fn frame_addr(func: &FunctionSsa, mut v: ValueId, mut off: i64) -> Option<i64> {
    for _ in 0..16 {
        match func.insts.get(v as usize)? {
            Inst::LocalAddr(slot) => return Some(slot.wrapping_mul(8).wrapping_add(off)),
            Inst::BinopI {
                op: BinOp::Add,
                lhs,
                rhs_imm,
            } => {
                off = off.wrapping_add(*rhs_imm);
                v = *lhs;
            }
            Inst::BinopI {
                op: BinOp::Sub,
                lhs,
                rhs_imm,
            } => {
                off = off.wrapping_sub(*rhs_imm);
                v = *lhs;
            }
            Inst::Phi { incoming, .. } if incoming.len() == 1 => v = incoming[0].1,
            _ => return None,
        }
    }
    None
}

fn store_width(kind: crate::c5::ir::StoreKind) -> i64 {
    use crate::c5::ir::StoreKind;
    match kind {
        StoreKind::I8 => 1,
        StoreKind::I16 => 2,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::I64 | StoreKind::F64 => 8,
        StoreKind::F80 | StoreKind::F128 => 16,
    }
}

/// What fills a tracked frame range.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Filled {
    /// The data-segment image at this offset, byte for byte.
    Template(i64),
    /// Zero: the inline fill a wholly-zero initializer lowers to,
    /// which stages no template to read.
    Zero,
}

impl Filled {
    /// The value of the `w` bytes at `off` within the range.
    fn read(self, cd: &ConstData<'_>, off: i64, w: i64) -> Option<ConstValue> {
        match self {
            Filled::Template(base) => cd.read(base + off, w),
            Filled::Zero => Some(ConstValue::Bytes([0u8; 8])),
        }
    }

    /// The same fill seen from `off` bytes into the range, for a range
    /// a partial write splits.
    fn advanced(self, off: i64) -> Self {
        match self {
            Filled::Template(base) => Filled::Template(base + off),
            Filled::Zero => Filled::Zero,
        }
    }
}

/// Frame byte range `lo` -> (`hi`, what fills it): the block state of
/// [`fold_template_loads`].
type State = BTreeMap<i64, (i64, Filled)>;

/// Ranges both states agree on: the overlap of entries whose fill
/// matches at every shared byte.
fn meet(a: &State, b: &State) -> State {
    let mut out = State::new();
    for (&alo, &(ahi, af)) in a {
        for (&blo, &(bhi, bf)) in b.range(..ahi) {
            if bhi <= alo {
                continue;
            }
            let lo = alo.max(blo);
            let fill = af.advanced(lo - alo);
            if fill == bf.advanced(lo - blo) {
                out.insert(lo, (ahi.min(bhi), fill));
            }
        }
    }
    out
}

/// Walk block `b` from `state`: tracked writes update the state, and
/// with `fold` set, each load the state resolves rewrites to the
/// initializer's value. Returns whether any load folded.
fn walk_block(
    func: &mut FunctionSsa,
    cd: &ConstData<'_>,
    ext: &BTreeSet<u32>,
    state: &mut State,
    b: usize,
    fold: bool,
    deferred: &mut Vec<(ValueId, Folded)>,
) -> bool {
    let mut changed = false;
    // A write covers part of a tracked range; what it does not reach
    // still holds what the range says, so the remainder is kept.
    let kill = |state: &mut State, lo: i64, hi: i64| {
        let hit: Vec<(i64, (i64, Filled))> = state
            .range(..hi)
            .filter(|entry| entry.1.0 > lo)
            .map(|(&s_lo, &v)| (s_lo, v))
            .collect();
        for (s_lo, (s_hi, src)) in hit {
            state.remove(&s_lo);
            if s_lo < lo {
                state.insert(s_lo, (lo, src));
            }
            if s_hi > hi {
                state.insert(hi, (s_hi, src.advanced(hi - s_lo)));
            }
        }
    };
    for i in func.blocks[b].inst_range.clone() {
        let idx = i as usize;
        match &func.insts[idx] {
            Inst::Mcpy { dst, src, size, .. } => {
                let size = *size;
                match frame_addr(func, *dst, 0) {
                    Some(lo) => {
                        kill(state, lo, lo + size);
                        if let Some(s) = data_addr(func, ext, *src, 0) {
                            state.insert(lo, (lo + size, Filled::Template(s)));
                        }
                    }
                    None => state.clear(),
                }
            }
            Inst::Store {
                addr,
                disp,
                value,
                kind,
                volatile,
                ..
            } => {
                let (zero, w) = (
                    !*volatile && matches!(func.insts.get(*value as usize), Some(Inst::Imm(0))),
                    store_width(*kind),
                );
                match frame_addr(func, *addr, *disp as i64) {
                    Some(a) => {
                        kill(state, a, a + w);
                        // The zero fill that replaces an all-zero
                        // template writes the same bytes the copy did.
                        if zero {
                            state.insert(a, (a + w, Filled::Zero));
                        }
                    }
                    None => state.clear(),
                }
            }
            Inst::StoreLocal {
                off,
                value,
                kind,
                volatile,
            } => {
                let a = off.wrapping_mul(8);
                let w = store_width(*kind);
                kill(state, a, a + w);
                if !*volatile && matches!(func.insts.get(*value as usize), Some(Inst::Imm(0))) {
                    state.insert(a, (a + w, Filled::Zero));
                }
            }
            Inst::Load {
                addr,
                disp,
                kind,
                volatile: false,
                ..
            } if fold => {
                let (kind, Some(w)) = (*kind, int_width(*kind)) else {
                    continue;
                };
                let Some(a) = frame_addr(func, *addr, *disp as i64) else {
                    continue;
                };
                let Some((&lo, &(hi, src))) = state.range(..=a).next_back() else {
                    continue;
                };
                if a + w > hi {
                    continue;
                }
                let Some(value) = src.read(cd, a - lo, w) else {
                    continue;
                };
                match Folded::of(value, kind) {
                    Folded::Imm(v) => {
                        func.insts[idx] = Inst::Imm(v);
                        changed = true;
                    }
                    f => deferred.push((i, f)),
                }
            }
            Inst::LoadLocal {
                off,
                kind,
                volatile: false,
            } if fold => {
                let (kind, Some(w)) = (*kind, int_width(*kind)) else {
                    continue;
                };
                let a = off.wrapping_mul(8);
                let Some((&lo, &(hi, src))) = state.range(..=a).next_back() else {
                    continue;
                };
                if a + w > hi {
                    continue;
                }
                let Some(value) = src.read(cd, a - lo, w) else {
                    continue;
                };
                match Folded::of(value, kind) {
                    Folded::Imm(v) => {
                        func.insts[idx] = Inst::Imm(v);
                        changed = true;
                    }
                    f => deferred.push((i, f)),
                }
            }
            // Pure value producers and reads neither write nor
            // invalidate.
            Inst::Imm(_)
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::ImmExtCode(_)
            | Inst::BlockAddr(_)
            | Inst::LocalAddr(_)
            | Inst::TlsAddr(_)
            | Inst::Load { .. }
            | Inst::LoadLocal { .. }
            | Inst::LoadIndexed { .. }
            | Inst::SegLoad { .. }
            | Inst::Binop { .. }
            | Inst::BinopI { .. }
            | Inst::Fneg(_)
            | Inst::Fma { .. }
            | Inst::MulAdd { .. }
            | Inst::Extend { .. }
            | Inst::Bswap { .. }
            | Inst::FpCast { .. }
            | Inst::ParamRef { .. }
            | Inst::Phi { .. } => {}
            // Calls, atomics, asm, indexed / segment stores,
            // intrinsics, alloca bookkeeping: may write memory the
            // walk does not model.
            _ => state.clear(),
        }
    }
    changed
}

/// Fold loads of a local whose covering write is known. An `Mcpy` from
/// resolvable data leaves those bytes in the slot, so the load reads the
/// source image under the same const rules as [`fold_loads`] -- which
/// admits the staged initializer templates a compound literal or
/// aggregate local is filled from, the shape a byte-level layout
/// assertion probes. A store of zero leaves zero, which is the same
/// initializer once the all-zero template is stored rather than copied.
/// Block input is the intersection of the predecessors' exit states -- a
/// forward must-analysis iterated to a fixed point in reverse post-order,
/// where a predecessor without a computed exit contributes nothing yet;
/// loads then rewrite in one sweep from the converged inputs.
pub(crate) fn fold_template_loads(func: &mut FunctionSsa, cd: &ConstData<'_>) -> bool {
    use alloc::vec;

    let nblocks = func.blocks.len();
    // An address rewrite renumbers the tape, so it waits for the sweep.
    let mut deferred: Vec<(ValueId, Folded)> = Vec::new();
    if nblocks == 0 {
        return false;
    }
    let mut succs: Vec<Vec<u32>> = vec![Vec::new(); nblocks];
    for (b, blk) in func.blocks.iter().enumerate() {
        let mut edge = |t: u32| {
            if (t as usize) < nblocks {
                succs[b].push(t);
            }
        };
        match &blk.terminator {
            Terminator::Jmp(t) | Terminator::FallThrough(t) => edge(*t),
            Terminator::Bz {
                target,
                fall_through,
                ..
            }
            | Terminator::Bnz {
                target,
                fall_through,
                ..
            } => {
                edge(*target);
                edge(*fall_through);
            }
            Terminator::JumpTable { table, .. } => {
                for &t in &func.jump_tables[*table as usize] {
                    edge(t);
                }
            }
            Terminator::GotoIndirect { .. } => {
                for &t in &func.computed_goto_targets {
                    edge(t);
                }
            }
            Terminator::AsmGoto { table } => {
                for &t in &func.jump_tables[*table as usize] {
                    edge(t);
                }
            }
            Terminator::Return(_) | Terminator::TailExt(_) | Terminator::Unreachable => {}
        }
    }
    let mut preds: Vec<Vec<u32>> = vec![Vec::new(); nblocks];
    for (b, ss) in succs.iter().enumerate() {
        for &s in ss {
            preds[s as usize].push(b as u32);
        }
    }
    // Reverse post-order from the entry; an unreachable block stays out
    // of the walk and keeps its loads.
    let mut order: Vec<u32> = Vec::with_capacity(nblocks);
    let mut seen = vec![false; nblocks];
    let mut stack: Vec<(u32, usize)> = vec![(0, 0)];
    seen[0] = true;
    while let Some(&(b, i)) = stack.last() {
        if let Some(&s) = succs[b as usize].get(i) {
            stack.last_mut().expect("nonempty").1 += 1;
            if !seen[s as usize] {
                seen[s as usize] = true;
                stack.push((s, 0));
            }
        } else {
            order.push(b);
            stack.pop();
        }
    }
    order.reverse();
    let ext = extern_imm_data(func);
    let mut in_states: Vec<Option<State>> = vec![None; nblocks];
    let mut exit_states: Vec<Option<State>> = vec![None; nblocks];
    // Exits start unknown and only shrink: the first computed value
    // replaces unknown, and later rounds meet in more predecessors, so
    // each productive round shrinks at least one exit. The bound covers
    // the longest acyclic chain; an overrun folds nothing.
    let mut rounds = nblocks + 2;
    loop {
        let mut changed_any = false;
        for &b in &order {
            let bs = b as usize;
            let mut input: Option<State> = (bs == 0).then(State::new);
            for &p in &preds[bs] {
                let Some(pe) = exit_states[p as usize].as_ref() else {
                    continue;
                };
                input = Some(match input.take() {
                    None => pe.clone(),
                    Some(cur) => meet(&cur, pe),
                });
            }
            let mut st = input.clone().unwrap_or_default();
            walk_block(func, cd, &ext, &mut st, bs, false, &mut deferred);
            if exit_states[bs].as_ref() != Some(&st) {
                exit_states[bs] = Some(st);
                changed_any = true;
            }
            in_states[bs] = input;
        }
        if !changed_any {
            break;
        }
        rounds -= 1;
        if rounds == 0 {
            return false;
        }
    }
    let mut changed = false;
    for &b in &order {
        let bs = b as usize;
        let mut st = in_states[bs].take().unwrap_or_default();
        if walk_block(func, cd, &ext, &mut st, bs, true, &mut deferred) {
            changed = true;
        }
    }
    apply(func, &mut deferred) || changed
}

pub(crate) fn run(funcs: &mut [FunctionSsa], program: &Program) {
    // [lo, hi) byte ranges of const, defined, initialized, non-preemptible
    // static-duration objects in the data segment.
    let const_intervals: Vec<(i64, i64)> = program
        .symbols
        .iter()
        .filter(|s| {
            s.class == Token::Glo as i64
                && s.storage_is_const
                && s.has_initializer
                && s.defined_here
                && s.reserved_data_bytes > 0
                && !s.is_weak
        })
        .map(|s| (s.val, s.val + s.reserved_data_bytes))
        .collect();
    if const_intervals.is_empty() {
        return;
    }
    // Data-segment byte offsets that hold a relocated pointer -- a non-null
    // runtime address -- inside one of those arrays.
    let mut const_reloc_offsets: BTreeSet<i64> = BTreeSet::new();
    for r in &program.data_relocs {
        let off = r.data_offset as i64;
        if const_intervals
            .iter()
            .any(|&(lo, hi)| off >= lo && off < hi)
        {
            const_reloc_offsets.insert(off);
        }
    }
    if const_reloc_offsets.is_empty() {
        return;
    }

    for f in funcs.iter_mut() {
        let ext = extern_imm_data(f);
        // A value's id is its instruction index, so `insts[id]` is the
        // defining instruction.
        for i in 0..f.insts.len() {
            let (op, lhs) = match f.insts[i] {
                Inst::BinopI {
                    op: op @ (BinOp::Eq | BinOp::Ne),
                    lhs,
                    rhs_imm: 0,
                } => (op, lhs),
                _ => continue,
            };
            let (addr, disp) = match f.insts.get(lhs as usize) {
                Some(Inst::Load {
                    addr,
                    disp,
                    kind: LoadKind::I64,
                    volatile: false,
                    ..
                }) => (*addr, *disp),
                _ => continue,
            };
            // The member address is an `ImmData(base)` plus the constant
            // displacement chain `data_addr` resolves. An `ImmData` naming
            // an extern symbol carries a link-time placeholder, so it says
            // nothing about this unit's data.
            let Some(member_off) = data_addr(f, &ext, addr, disp as i64) else {
                continue;
            };
            if !const_reloc_offsets.contains(&member_off) {
                continue;
            }
            // The member holds a non-null address; the comparison is a
            // compile-time constant.
            f.insts[i] = Inst::Imm(i64::from(op == BinOp::Ne));
        }
    }
}

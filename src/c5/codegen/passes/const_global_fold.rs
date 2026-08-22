//! Folds over the storage of a `const` object with static duration.
//!
//! C99 6.7.3p5 makes modifying an object defined with a const-qualified
//! type undefined, so such an object holds what its initializer put there
//! for the whole execution. Two folds follow, both `-O` only (a `const`
//! object is not a constant expression, C99 6.6):
//!
//!   * [`fold_loads`] replaces a non-volatile integer load from the
//!     object's image with the initializer's value.
//!   * [`run`] replaces `load(member) == 0` with `0` and `!= 0` with `1`
//!     when `member` carries a data relocation: the member holds a
//!     link-time address, which is never null. The load stays, so any
//!     other use of the loaded value is unaffected.
//!
//! Both feed `constfold_branch`, which then deletes the arm a guard on
//! the value makes unreachable -- the shape a build-time assertion, or a
//! call to an `__attribute__((error))` helper, is compiled into.

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, Terminator, ValueId};
use crate::c5::program::Program;
use crate::c5::token::Token;

/// Const-data view for folding loads of `const` objects: the `[lo, hi)`
/// byte ranges of const-qualified, defined, initialized static-duration
/// objects -- scalar, aggregate or array -- whose image already holds
/// their value, the data-segment offsets a relocation patches (unknown
/// until link, so never folded), and the data image itself.
pub(crate) struct ConstData<'a> {
    intervals: Vec<(i64, i64)>,
    reloc_offsets: Vec<i64>,
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
        // Every form of data relocation: a link-time address in this
        // unit's data, an extern symbol's address, and a function
        // address. The image bytes under any of them are a placeholder.
        let mut reloc_offsets: Vec<i64> = program
            .data_relocs
            .iter()
            .map(|r| r.data_offset as i64)
            .chain(
                program
                    .extern_data_relocs
                    .iter()
                    .map(|r| r.data_offset as i64),
            )
            .chain(program.code_relocs.iter().map(|r| r.data_offset as i64))
            .collect();
        reloc_offsets.sort_unstable();
        ConstData {
            intervals,
            reloc_offsets,
            data: &program.data,
        }
    }

    /// The value of `[off, off + width)`, zero-extended to eight bytes,
    /// when the whole read sits inside one const interval and overlaps no
    /// relocation slot. An offset at or past the image end belongs to a
    /// wholly-zero, relocation-free object the data compaction moved to
    /// the `.bss` region, which every writer maps to a zero-filled vaddr
    /// range; its value is zero.
    fn read(&self, off: i64, width: i64) -> Option<[u8; 8]> {
        if !self
            .intervals
            .iter()
            .any(|&(lo, hi)| off >= lo && off + width <= hi)
        {
            return None;
        }
        // A relocation patches 8 bytes at its offset with a link-time
        // address; any overlap makes the read's value unknown here.
        let i = self.reloc_offsets.partition_point(|&r| r + 8 <= off);
        if self.reloc_offsets.get(i).is_some_and(|&r| r < off + width) {
            return None;
        }
        let mut raw = [0u8; 8];
        if off >= self.data.len() as i64 {
            return Some(raw);
        }
        let bytes = self.data.get(off as usize..(off + width) as usize)?;
        raw[..width as usize].copy_from_slice(bytes);
        Some(raw)
    }
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
/// be modified, so the image bytes are the object's value for the whole
/// execution). Returns true when any load folded. Runs inside the branch
/// fold's fixed point so a load whose address becomes constant only
/// after a phi collapses still folds; all emission targets are
/// little-endian, so the image decodes with `from_le_bytes`.
pub(crate) fn fold_loads(func: &mut FunctionSsa, cd: &ConstData<'_>) -> bool {
    let mut changed = false;
    let ext = extern_imm_data(func);
    for i in 0..func.insts.len() {
        let Inst::Load {
            addr,
            disp,
            kind,
            volatile: false,
            ..
        } = func.insts[i]
        else {
            continue;
        };
        let width = match kind {
            LoadKind::I8 | LoadKind::U8 => 1i64,
            LoadKind::I16 | LoadKind::U16 => 2,
            LoadKind::I32 | LoadKind::U32 => 4,
            LoadKind::I64 => 8,
            // The FP kinds keep their register class through the load;
            // an integer immediate would misclassify them.
            LoadKind::F32 | LoadKind::F64 => continue,
        };
        let Some(off) = data_addr(func, &ext, addr, disp as i64) else {
            continue;
        };
        let Some(raw) = cd.read(off, width) else {
            continue;
        };
        let u = u64::from_le_bytes(raw);
        let value = match kind {
            LoadKind::I8 => u as u8 as i8 as i64,
            LoadKind::I16 => u as u16 as i16 as i64,
            LoadKind::I32 => u as u32 as i32 as i64,
            _ => u as i64,
        };
        func.insts[i] = Inst::Imm(value);
        changed = true;
    }
    changed
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

fn access_width(kind: LoadKind) -> i64 {
    match kind {
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I64 | LoadKind::F64 => 8,
    }
}

fn store_width(kind: crate::c5::ir::StoreKind) -> i64 {
    use crate::c5::ir::StoreKind;
    match kind {
        StoreKind::I8 => 1,
        StoreKind::I16 => 2,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::I64 | StoreKind::F64 => 8,
    }
}

/// What fills a tracked frame range.
#[derive(Clone, Copy)]
enum Filled {
    /// The data-segment image at this offset, byte for byte.
    Template(i64),
    /// Zero: the inline fill a wholly-zero initializer lowers to,
    /// which stages no template to read.
    Zero,
}

impl Filled {
    /// The `w` bytes at `off` within the range, zero-extended to eight.
    fn read(self, cd: &ConstData<'_>, off: i64, w: i64) -> Option<[u8; 8]> {
        match self {
            Filled::Template(base) => cd.read(base + off, w),
            Filled::Zero => Some([0u8; 8]),
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

/// Fold loads of a local whose covering write is known. An `Mcpy` from
/// resolvable data leaves those bytes in the slot, so the load reads the
/// source image under the same const rules as [`fold_loads`] -- which
/// admits the staged initializer templates a compound literal or
/// aggregate local is filled from, the shape a byte-level layout
/// assertion probes. A store of zero leaves zero, which is the same
/// initializer once the all-zero template is stored rather than copied.
/// State is per block, keyed by frame byte ranges, inherited over an
/// unconditional single-predecessor edge; a tracked write kills what it
/// overlaps and any instruction that can write memory unpredictably
/// clears it.
pub(crate) fn fold_template_loads(func: &mut FunctionSsa, cd: &ConstData<'_>) -> bool {
    use alloc::collections::BTreeMap;
    use alloc::vec;
    // Predecessor sets, for the single-pred inheritance.
    let nblocks = func.blocks.len();
    let mut preds: Vec<Vec<u32>> = vec![Vec::new(); nblocks];
    for (b, blk) in func.blocks.iter().enumerate() {
        let mut edge = |t: u32| {
            if let Some(p) = preds.get_mut(t as usize) {
                p.push(b as u32);
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
    // Frame range lo -> (hi, what fills it).
    type State = BTreeMap<i64, (i64, Filled)>;
    let mut exit_states: Vec<Option<State>> = vec![None; nblocks];
    let ext = extern_imm_data(func);
    let mut changed = false;
    for b in 0..nblocks {
        let mut state: State = match preds[b].as_slice() {
            [p] if (*p as usize) < b
                && matches!(
                    func.blocks[*p as usize].terminator,
                    Terminator::Jmp(t) | Terminator::FallThrough(t) if t as usize == b
                ) =>
            {
                exit_states[*p as usize].clone().unwrap_or_default()
            }
            _ => State::new(),
        };
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
                            kill(&mut state, lo, lo + size);
                            if let Some(s) = data_addr(func, &ext, *src, 0) {
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
                            kill(&mut state, a, a + w);
                            // The zero fill that replaces an all-zero
                            // template writes the same bytes the copy did.
                            if zero {
                                state.insert(a, (a + w, Filled::Zero));
                            }
                        }
                        None => state.clear(),
                    }
                }
                Inst::StoreLocal { off, kind, .. } => {
                    let a = off.wrapping_mul(8);
                    kill(&mut state, a, a + store_width(*kind));
                }
                Inst::Load {
                    addr,
                    disp,
                    kind,
                    volatile: false,
                    ..
                } if !matches!(kind, LoadKind::F32 | LoadKind::F64) => {
                    let (kind, w) = (*kind, access_width(*kind));
                    let Some(a) = frame_addr(func, *addr, *disp as i64) else {
                        continue;
                    };
                    let Some((&lo, &(hi, src))) = state.range(..=a).next_back() else {
                        continue;
                    };
                    if a + w > hi {
                        continue;
                    }
                    let Some(raw) = src.read(cd, a - lo, w) else {
                        continue;
                    };
                    let u = u64::from_le_bytes(raw);
                    let value = match kind {
                        LoadKind::I8 => u as u8 as i8 as i64,
                        LoadKind::I16 => u as u16 as i16 as i64,
                        LoadKind::I32 => u as u32 as i32 as i64,
                        _ => u as i64,
                    };
                    func.insts[idx] = Inst::Imm(value);
                    changed = true;
                }
                Inst::LoadLocal {
                    off,
                    kind,
                    volatile: false,
                } if !matches!(kind, LoadKind::F32 | LoadKind::F64) => {
                    let (kind, w) = (*kind, access_width(*kind));
                    let a = off.wrapping_mul(8);
                    let Some((&lo, &(hi, src))) = state.range(..=a).next_back() else {
                        continue;
                    };
                    if a + w > hi {
                        continue;
                    }
                    let Some(raw) = src.read(cd, a - lo, w) else {
                        continue;
                    };
                    let u = u64::from_le_bytes(raw);
                    let value = match kind {
                        LoadKind::I8 => u as u8 as i8 as i64,
                        LoadKind::I16 => u as u16 as i16 as i64,
                        LoadKind::I32 => u as u32 as i32 as i64,
                        _ => u as i64,
                    };
                    func.insts[idx] = Inst::Imm(value);
                    changed = true;
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
        exit_states[b] = Some(state);
    }
    changed
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

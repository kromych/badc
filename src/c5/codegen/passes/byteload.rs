//! Merge a byte-at-a-time memory idiom into one wide access.
//!
//! Load side: an OR of `unsigned char` loads at consecutive addresses,
//! written as a tree (`b0 | b1 << 8 | ...`) or as a Horner chain
//! (`((b << 8 | b) << 8 | b) ...`), becomes one wide `Load` at the
//! lowest address. Store side: a run of `Store { I8 }` of `src >> 8k`
//! at consecutive addresses becomes one wide `Store` of `src`. An
//! assembly whose byte order is the reverse of the target's takes a
//! `Bswap` of the merged width on top -- the shape big-endian container
//! and crypto code has on a little-endian target.
//!
//! A merge requires a common base value, `n` in {2,4,8} distinct
//! consecutive offsets, the shift of each part matching its offset in
//! one of the two orders, single-use intermediates, non-volatile parts,
//! and no instruction between the parts that can observe or change the
//! range (C99 5.1.2.3p2: with none of those the byte accesses and the
//! wide access have the same observable effect). A mask or a widening
//! on the path is looked through only where it leaves every byte the
//! parts contribute intact. The merged access proves only the byte
//! alignment its parts had, so the pass declines under
//! `-mstrict-align`, where the lowering may not widen past a proven
//! bound.
//!
//! Rewrites are in place: the tape neither grows nor renumbers, and the
//! parts drop out through the allocator's dead-pure scan.

use crate::c5::codegen::ssa::reg_alloc::compute_use_counts;
use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, StoreKind, ValueId};
use alloc::vec::Vec;

/// Widest merge, in bytes.
const MAX_BYTES: usize = 8;

pub(crate) fn run(funcs: &mut [FunctionSsa], target_little_endian: bool, strict_align: bool) {
    if strict_align {
        return;
    }
    for func in funcs.iter_mut() {
        run_one(func, target_little_endian);
    }
}

fn wide_kinds(n: usize) -> Option<(LoadKind, StoreKind)> {
    match n {
        2 => Some((LoadKind::U16, StoreKind::I16)),
        4 => Some((LoadKind::U32, StoreKind::I32)),
        8 => Some((LoadKind::I64, StoreKind::I64)),
        _ => None,
    }
}

/// Displacement for a merged access at byte offset `off` of width `n`.
/// The immediate-offset encodings take a multiple of the access width
/// within the scaled-immediate reach, the bound `index_fold` applies
/// when it folds a constant address addition into `disp`.
fn encodable_disp(off: i64, n: usize) -> Option<i32> {
    let d = i32::try_from(off).ok()?;
    let n = n as i64;
    (off >= 0 && off % n == 0 && off / n < 4096).then_some(d)
}

/// Bits an unsigned widening keeps; every higher bit is cleared.
fn zext_mask(kind: LoadKind) -> Option<u64> {
    match kind {
        LoadKind::U8 => Some(0xff),
        LoadKind::U16 => Some(0xffff),
        LoadKind::U32 => Some(0xffff_ffff),
        _ => None,
    }
}

/// Bits any integer widening leaves unchanged.
fn extend_keeps_low(kind: LoadKind) -> Option<u32> {
    match kind {
        LoadKind::U8 | LoadKind::I8 => Some(8),
        LoadKind::U16 | LoadKind::I16 => Some(16),
        LoadKind::U32 | LoadKind::I32 => Some(32),
        LoadKind::I64 => Some(64),
        _ => None,
    }
}

/// True when `keep` leaves the byte at bit `shift` whole.
fn byte_survives(keep: u64, shift: u32) -> bool {
    shift < 64 && (keep >> shift) & 0xff == 0xff
}

/// Evaluate constant integer arithmetic. Reaches the index expressions
/// an unrolled loop leaves behind, which the constant folder only
/// collapses later in the pipeline.
fn eval_const(func: &FunctionSsa, v: ValueId, depth: u32) -> Option<i64> {
    if depth > 32 {
        return None;
    }
    let apply = |op: BinOp, l: i64, r: i64| -> Option<i64> {
        match op {
            BinOp::Add => Some(l.wrapping_add(r)),
            BinOp::Sub => Some(l.wrapping_sub(r)),
            BinOp::Mul => Some(l.wrapping_mul(r)),
            BinOp::Shl if (0..64).contains(&r) => Some(l.wrapping_shl(r as u32)),
            BinOp::Or => Some(l | r),
            BinOp::And => Some(l & r),
            _ => None,
        }
    };
    match func.insts.get(v as usize)? {
        Inst::Imm(k) => Some(*k),
        Inst::BinopI { op, lhs, rhs_imm } => {
            let l = eval_const(func, *lhs, depth + 1)?;
            apply(*op, l, *rhs_imm)
        }
        Inst::Binop { op, lhs, rhs } => {
            let l = eval_const(func, *lhs, depth + 1)?;
            let r = eval_const(func, *rhs, depth + 1)?;
            apply(*op, l, r)
        }
        Inst::Extend { value, kind } => {
            let x = eval_const(func, *value, depth + 1)?;
            Some(match kind {
                LoadKind::I8 => x as i8 as i64,
                LoadKind::I16 => x as i16 as i64,
                LoadKind::I32 => x as i32 as i64,
                LoadKind::U8 => x as u8 as i64,
                LoadKind::U16 => x as u16 as i64,
                LoadKind::U32 => x as u32 as i64,
                _ => x,
            })
        }
        _ => None,
    }
}

/// Trace an access address to a base value plus a constant byte
/// offset, seeded with the access's own `disp`.
fn resolve_base_offset(func: &FunctionSsa, addr: ValueId, disp: i32) -> (ValueId, i64) {
    let mut base = addr;
    let mut off = disp as i64;
    for _ in 0..16 {
        match func.insts.get(base as usize) {
            Some(Inst::BinopI {
                op: BinOp::Add,
                lhs,
                rhs_imm,
            }) => {
                off += *rhs_imm;
                base = *lhs;
            }
            Some(Inst::Binop {
                op: BinOp::Add,
                lhs,
                rhs,
            }) => {
                if let Some(k) = eval_const(func, *rhs, 0) {
                    off += k;
                    base = *lhs;
                } else if let Some(k) = eval_const(func, *lhs, 0) {
                    off += k;
                    base = *rhs;
                } else {
                    break;
                }
            }
            _ => break,
        }
    }
    (base, off)
}

/// True when the base cannot name a slot of the current frame: a
/// parameter's value predates the frame, and a global or TLS address
/// is not in it. Frame accesses then cannot alias the merged range.
fn base_avoids_frame(func: &FunctionSsa, base: ValueId) -> bool {
    matches!(
        func.insts.get(base as usize),
        Some(Inst::ParamRef { .. }) | Some(Inst::ImmData(_)) | Some(Inst::TlsAddr(_))
    )
}

/// True when `inst` may change the merged range or observe a partial
/// write of it. Purity is the definition, so a new instruction is a
/// hazard until it is declared pure; frame accesses are exempt for a
/// base that cannot name the frame.
fn hazard(inst: &Inst, reads_too: bool, frame_safe: bool) -> bool {
    match inst {
        Inst::LoadLocal {
            volatile: false, ..
        }
        | Inst::StoreLocal {
            volatile: false, ..
        } => !frame_safe,
        Inst::Load { .. } | Inst::LoadIndexed { .. } | Inst::SegLoad { .. } => reads_too,
        other => !other.is_pure(),
    }
}

/// One byte of a load idiom.
struct Term {
    load: ValueId,
    base: ValueId,
    offset: i64,
    shift: u32,
}

/// A clearing operation on the path from the root to the terms
/// `from..to`: it keeps `keep`, positioned `shift` bits below the root.
struct Clear {
    keep: u64,
    shift: u32,
    from: usize,
    to: usize,
}

/// Linearises an OR tree / Horner chain into byte terms.
struct Assembly<'a> {
    func: &'a FunctionSsa,
    terms: Vec<Term>,
    interior: Vec<ValueId>,
    clears: Vec<Clear>,
}

impl Assembly<'_> {
    fn walk(&mut self, node: ValueId, shift: u32, depth: u32) -> bool {
        if depth > 64 || self.terms.len() > MAX_BYTES {
            return false;
        }
        match self.func.insts.get(node as usize) {
            Some(Inst::Binop {
                op: BinOp::Or,
                lhs,
                rhs,
            }) => {
                let (lhs, rhs) = (*lhs, *rhs);
                self.interior.push(node);
                self.walk(lhs, shift, depth + 1) && self.walk(rhs, shift, depth + 1)
            }
            // `acc | 0` off a zero-initialised Horner accumulator.
            Some(Inst::BinopI {
                op: BinOp::Or,
                lhs,
                rhs_imm: 0,
            }) => {
                let lhs = *lhs;
                self.interior.push(node);
                self.walk(lhs, shift, depth + 1)
            }
            Some(Inst::BinopI {
                op: BinOp::Shl,
                lhs,
                rhs_imm,
            }) if (0..64).contains(rhs_imm) => {
                let (lhs, k) = (*lhs, *rhs_imm as u32);
                self.interior.push(node);
                self.walk(lhs, shift.saturating_add(k), depth + 1)
            }
            Some(Inst::BinopI {
                op: BinOp::And,
                lhs,
                rhs_imm,
            }) => {
                let (lhs, keep) = (*lhs, *rhs_imm as u64);
                self.clear(node, lhs, keep, shift, depth)
            }
            Some(Inst::Extend { value, kind }) => match zext_mask(*kind) {
                Some(keep) => {
                    let value = *value;
                    self.clear(node, value, keep, shift, depth)
                }
                None => false,
            },
            // The zero a Horner accumulator starts from; contributes
            // no byte at any shift.
            Some(Inst::Imm(0)) => true,
            Some(Inst::Load {
                addr,
                disp,
                kind: LoadKind::U8,
                volatile: false,
                ..
            }) => {
                let (base, offset) = resolve_base_offset(self.func, *addr, *disp);
                self.terms.push(Term {
                    load: node,
                    base,
                    offset,
                    shift,
                });
                true
            }
            _ => false,
        }
    }

    fn clear(
        &mut self,
        node: ValueId,
        operand: ValueId,
        keep: u64,
        shift: u32,
        depth: u32,
    ) -> bool {
        self.interior.push(node);
        let from = self.terms.len();
        if !self.walk(operand, shift, depth + 1) {
            return false;
        }
        let to = self.terms.len();
        self.clears.push(Clear {
            keep,
            shift,
            from,
            to,
        });
        true
    }
}

/// Byte order of a complete term set: `Some(true)` when the lowest
/// address carries the most significant byte, `None` when the offsets
/// and shifts pair up in neither order.
fn assembled_big_endian(pairs: &[(i64, u32)], o_min: i64, n: usize) -> Option<bool> {
    let le = pairs
        .iter()
        .all(|&(off, sh)| sh as i64 == 8 * (off - o_min));
    let be = pairs
        .iter()
        .all(|&(off, sh)| sh as i64 == 8 * (n as i64 - 1 - (off - o_min)));
    match (le, be) {
        (true, _) => Some(false),
        (_, true) => Some(true),
        _ => None,
    }
}

/// Offsets distinct and covering `o_min .. o_min + n`.
fn offsets_tile(pairs: &[(i64, u32)], o_min: i64, n: usize) -> bool {
    let mut seen = alloc::vec![false; n];
    for &(off, _) in pairs {
        match usize::try_from(off - o_min) {
            Ok(k) if k < n && !seen[k] => seen[k] = true,
            _ => return false,
        }
    }
    seen.iter().all(|&b| b)
}

struct LoadMerge {
    root: ValueId,
    /// Slot the wide load lands in; the root itself unless a byte
    /// reversal takes that slot.
    wide: ValueId,
    base: ValueId,
    disp: i32,
    kind: LoadKind,
    swap_width: Option<u8>,
    members: Vec<ValueId>,
}

fn match_load(
    func: &FunctionSsa,
    root: ValueId,
    uc: &[u32],
    lo: u32,
    hi: u32,
    claimed: &[bool],
    target_little_endian: bool,
) -> Option<LoadMerge> {
    let (lhs, rhs) = match func.insts.get(root as usize)? {
        Inst::Binop {
            op: BinOp::Or,
            lhs,
            rhs,
        } => (*lhs, *rhs),
        _ => return None,
    };
    let mut asm = Assembly {
        func,
        terms: Vec::new(),
        interior: Vec::new(),
        clears: Vec::new(),
    };
    if !asm.walk(lhs, 0, 0) || !asm.walk(rhs, 0, 0) {
        return None;
    }
    let n = asm.terms.len();
    let (kind, _) = wide_kinds(n)?;
    let base = asm.terms.first()?.base;
    if !asm.terms.iter().all(|t| t.base == base) {
        return None;
    }
    // Every clearing operation must leave the bytes below it whole.
    for c in &asm.clears {
        for t in &asm.terms[c.from..c.to] {
            if !t
                .shift
                .checked_sub(c.shift)
                .is_some_and(|p| byte_survives(c.keep, p))
            {
                return None;
            }
        }
    }
    let pairs: Vec<(i64, u32)> = asm.terms.iter().map(|t| (t.offset, t.shift)).collect();
    let o_min = pairs.iter().map(|&(off, _)| off).min()?;
    if !offsets_tile(&pairs, o_min, n) {
        return None;
    }
    let disp = encodable_disp(o_min, n)?;
    let big_endian = assembled_big_endian(&pairs, o_min, n)?;

    let mut members = asm.interior;
    members.extend(asm.terms.iter().map(|t| t.load));
    // Every part feeds this idiom alone, lives in this block, and is
    // not already part of another merge.
    for &m in &members {
        if uc.get(m as usize).copied().unwrap_or(0) != 1
            || m < lo
            || m >= hi
            || claimed.get(m as usize).copied().unwrap_or(true)
        {
            return None;
        }
    }
    if claimed.get(root as usize).copied().unwrap_or(true) {
        return None;
    }
    let first = *members.iter().min()?;
    let frame_safe = base_avoids_frame(func, base);
    if (first..root).any(|id| {
        func.insts
            .get(id as usize)
            .is_some_and(|i| hazard(i, false, frame_safe))
    }) {
        return None;
    }

    let swap = big_endian == target_little_endian;
    let wide = if swap {
        asm.terms.iter().map(|t| t.load).min()?
    } else {
        root
    };
    Some(LoadMerge {
        root,
        wide,
        base,
        disp,
        kind,
        swap_width: swap.then_some(n as u8),
        members,
    })
}

/// One byte of a store idiom: the byte at bit `shift` of `src`.
struct ByteStore {
    id: ValueId,
    base: ValueId,
    offset: i64,
    src: ValueId,
    shift: u32,
}

/// Trace a stored byte to the value it comes from and its bit position
/// in that value, through byte-multiple right shifts and through
/// operations that leave the byte itself intact.
fn resolve_stored_byte(func: &FunctionSsa, value: ValueId) -> (ValueId, u32) {
    let mut cur = value;
    let mut shift = 0u32;
    for _ in 0..32 {
        match func.insts.get(cur as usize) {
            Some(Inst::BinopI {
                op: BinOp::Shr | BinOp::Shru,
                lhs,
                rhs_imm,
            }) if *rhs_imm > 0 && rhs_imm % 8 == 0 && shift + *rhs_imm as u32 + 8 <= 64 => {
                shift += *rhs_imm as u32;
                cur = *lhs;
            }
            Some(Inst::BinopI {
                op: BinOp::And,
                lhs,
                rhs_imm,
            }) if byte_survives(*rhs_imm as u64, shift) => cur = *lhs,
            Some(Inst::Extend { value, kind })
                if extend_keeps_low(*kind).is_some_and(|w| shift + 8 <= w) =>
            {
                cur = *value
            }
            _ => break,
        }
    }
    (cur, shift)
}

struct StoreMerge {
    /// Store the wide store lands in: the last of the run.
    wide: ValueId,
    /// Store whose slot holds the byte reversal feeding the wide store.
    swap_slot: Option<ValueId>,
    blanks: Vec<ValueId>,
    base: ValueId,
    disp: i32,
    src: ValueId,
    kind: StoreKind,
    swap_width: Option<u8>,
}

fn match_store_runs(
    func: &FunctionSsa,
    lo: u32,
    hi: u32,
    uc: &[u32],
    claimed: &mut [bool],
    target_little_endian: bool,
    out: &mut Vec<StoreMerge>,
) {
    let mut cands: Vec<ByteStore> = Vec::new();
    for id in lo..hi {
        if let Some(Inst::Store {
            addr,
            disp,
            value,
            kind: StoreKind::I8,
            volatile: false,
            ..
        }) = func.insts.get(id as usize)
        {
            let (base, offset) = resolve_base_offset(func, *addr, *disp);
            let (src, shift) = resolve_stored_byte(func, *value);
            cands.push(ByteStore {
                id,
                base,
                offset,
                src,
                shift,
            });
        }
    }
    let mut taken = alloc::vec![false; cands.len()];
    for anchor in 0..cands.len() {
        if taken[anchor] || cands[anchor].shift != 0 {
            continue;
        }
        for n in [8usize, 4, 2] {
            // The byte at shift 0 sits at the lowest address in the
            // target's order and at the highest in the reverse one.
            let Some((group, big_endian)) = complete_run(&cands, &taken, anchor, n) else {
                continue;
            };
            if let Some(m) = build_store_merge(
                func,
                &cands,
                &group,
                n,
                big_endian,
                uc,
                claimed,
                target_little_endian,
            ) {
                for &g in &group {
                    taken[g] = true;
                    claimed[cands[g].id as usize] = true;
                }
                out.push(m);
                break;
            }
        }
    }
}

/// Collect the `n` stores that complete a run anchored at the byte of
/// shift 0, in either byte order.
fn complete_run(
    cands: &[ByteStore],
    taken: &[bool],
    anchor: usize,
    n: usize,
) -> Option<(Vec<usize>, bool)> {
    for big_endian in [false, true] {
        let mut group = Vec::with_capacity(n);
        for k in 0..n {
            let step = k as i64;
            let want_off = if big_endian {
                cands[anchor].offset - step
            } else {
                cands[anchor].offset + step
            };
            let want_shift = 8 * k as u32;
            let found = (0..cands.len()).find(|&j| {
                !taken[j]
                    && !group.contains(&j)
                    && cands[j].base == cands[anchor].base
                    && cands[j].src == cands[anchor].src
                    && cands[j].offset == want_off
                    && cands[j].shift == want_shift
            });
            match found {
                Some(j) => group.push(j),
                None => break,
            }
        }
        if group.len() == n {
            return Some((group, big_endian));
        }
    }
    None
}

#[allow(clippy::too_many_arguments)]
fn build_store_merge(
    func: &FunctionSsa,
    cands: &[ByteStore],
    group: &[usize],
    n: usize,
    big_endian: bool,
    uc: &[u32],
    claimed: &[bool],
    target_little_endian: bool,
) -> Option<StoreMerge> {
    let (_, kind) = wide_kinds(n)?;
    let base = cands[group[0]].base;
    let ids: Vec<ValueId> = group.iter().map(|&g| cands[g].id).collect();
    // The stored value each store leaves in the accumulator must be
    // unread, and no id may already belong to another merge.
    for &id in &ids {
        if uc.get(id as usize).copied().unwrap_or(1) != 0
            || claimed.get(id as usize).copied().unwrap_or(true)
        {
            return None;
        }
    }
    let o_min = group.iter().map(|&g| cands[g].offset).min()?;
    let disp = encodable_disp(o_min, n)?;
    let first = *ids.iter().min()?;
    let last = *ids.iter().max()?;
    // A read between the parts would see the range half-written, and a
    // foreign write could land inside it.
    let frame_safe = base_avoids_frame(func, base);
    if (first..=last).any(|id| {
        !ids.contains(&id)
            && func
                .insts
                .get(id as usize)
                .is_some_and(|i| hazard(i, true, frame_safe))
    }) {
        return None;
    }
    let swap = big_endian == target_little_endian;
    let (swap_slot, blanks): (Option<ValueId>, Vec<ValueId>) = if swap {
        (
            Some(first),
            ids.iter()
                .copied()
                .filter(|&id| id != first && id != last)
                .collect(),
        )
    } else {
        (None, ids.iter().copied().filter(|&id| id != last).collect())
    };
    Some(StoreMerge {
        wide: last,
        swap_slot,
        blanks,
        base,
        disp,
        src: cands[group[0]].src,
        kind,
        swap_width: swap.then_some(n as u8),
    })
}

fn run_one(func: &mut FunctionSsa, target_little_endian: bool) {
    if func.insts.is_empty() {
        return;
    }
    let uc = compute_use_counts(func);
    let mut claimed = alloc::vec![false; func.insts.len()];
    let mut loads: Vec<LoadMerge> = Vec::new();
    let mut stores: Vec<StoreMerge> = Vec::new();

    for block in &func.blocks {
        let lo = block.inst_range.start;
        let hi = block.inst_range.end.min(func.insts.len() as u32);
        // Roots high to low, so the widest assembly claims its parts
        // before a nested sub-OR is tried.
        for id in (lo..hi).rev() {
            if let Some(m) = match_load(func, id, &uc, lo, hi, &claimed, target_little_endian) {
                for &mem in &m.members {
                    claimed[mem as usize] = true;
                }
                claimed[m.root as usize] = true;
                loads.push(m);
            }
        }
        match_store_runs(
            func,
            lo,
            hi,
            &uc,
            &mut claimed,
            target_little_endian,
            &mut stores,
        );
    }

    for m in loads {
        // The parts proved only byte alignment; record that rather
        // than the natural alignment of the merged width.
        func.insts[m.wide as usize] = Inst::Load {
            addr: m.base,
            disp: m.disp,
            kind: m.kind,
            volatile: false,
            align: 1,
        };
        if let Some(width) = m.swap_width {
            func.insts[m.root as usize] = Inst::Bswap {
                value: m.wide,
                width,
            };
        }
    }
    for m in stores {
        let value = match (m.swap_width, m.swap_slot) {
            (Some(width), Some(slot)) => {
                func.insts[slot as usize] = Inst::Bswap {
                    value: m.src,
                    width,
                };
                slot
            }
            _ => m.src,
        };
        for b in m.blanks {
            func.insts[b as usize] = Inst::Imm(0);
        }
        func.insts[m.wide as usize] = Inst::Store {
            addr: m.base,
            disp: m.disp,
            value,
            kind: m.kind,
            volatile: false,
            align: 1,
        };
    }
}

#[cfg(test)]
mod tests {
    use super::{run, run_one};
    use crate::c5::ir::{
        BinOp, Block, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId,
    };
    use alloc::vec::Vec;

    fn fresh(insts: Vec<Inst>, term: Terminator) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            n_params: 2,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
            is_noinline: false,
            is_naked: false,
            section: None,
            is_weak: false,
            is_internal: false,
            const_params: 0,
            inst_src: alloc::vec![(0, 0); n],
            f32_values: alloc::vec![false; n],
            cmp32: Vec::new(),
            param_fp_mask: 0,
            agg_descs: Vec::new(),
            param_aggs: Vec::new(),
            param_local_slots: Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            ret_type_tag: 0,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            label_data_relocs: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            over_aligned: Default::default(),
            frame_align: 0,
            realign_region_bytes: 0,
            has_returns_twice_call: false,
            did_unroll: false,
            did_inline: false,
            insts,
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n as u32,
                terminator: term,
                exit_acc: NO_VALUE,
            }],
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    fn param(idx: u32) -> Inst {
        Inst::ParamRef {
            idx,
            kind: LoadKind::I64,
        }
    }
    fn u8_load(addr: ValueId, disp: i32) -> Inst {
        Inst::Load {
            addr,
            disp,
            kind: LoadKind::U8,
            volatile: false,
            align: 0,
        }
    }
    fn shl(lhs: ValueId, k: i64) -> Inst {
        Inst::BinopI {
            op: BinOp::Shl,
            lhs,
            rhs_imm: k,
        }
    }
    fn shru(lhs: ValueId, k: i64) -> Inst {
        Inst::BinopI {
            op: BinOp::Shru,
            lhs,
            rhs_imm: k,
        }
    }
    fn or(lhs: ValueId, rhs: ValueId) -> Inst {
        Inst::Binop {
            op: BinOp::Or,
            lhs,
            rhs,
        }
    }
    fn i8_store(addr: ValueId, disp: i32, value: ValueId) -> Inst {
        Inst::Store {
            addr,
            disp,
            value,
            kind: StoreKind::I8,
            volatile: false,
            align: 0,
        }
    }

    /// `p[0] | p[1]<<8 | p[2]<<16 | p[3]<<24` on a little-endian
    /// target: one wide load, no reversal, and the byte alignment the
    /// parts proved.
    #[test]
    fn le_or_tree_becomes_wide_load() {
        let mut f = fresh(
            alloc::vec![
                param(0),      // v0
                u8_load(0, 0), // v1
                u8_load(0, 1), // v2
                shl(2, 8),     // v3
                u8_load(0, 2), // v4
                shl(4, 16),    // v5
                u8_load(0, 3), // v6
                shl(6, 24),    // v7
                or(1, 3),      // v8
                or(8, 5),      // v9
                or(9, 7),      // v10
            ],
            Terminator::Return(10),
        );
        run_one(&mut f, true);
        assert!(
            matches!(
                f.insts[10],
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::U32,
                    volatile: false,
                    align: 1
                }
            ),
            "expected a wide U32 load, got {:?}",
            f.insts[10]
        );
    }

    /// `(((p[0]<<8 | p[1])<<8 | p[2])<<8 | p[3])`: the reverse of the
    /// target's order, so a wide load plus a byte reversal.
    #[test]
    fn be_horner_becomes_load_plus_bswap() {
        let mut f = fresh(
            alloc::vec![
                param(0),      // v0
                u8_load(0, 0), // v1
                shl(1, 8),     // v2
                u8_load(0, 1), // v3
                or(2, 3),      // v4
                shl(4, 8),     // v5
                u8_load(0, 2), // v6
                or(5, 6),      // v7
                shl(7, 8),     // v8
                u8_load(0, 3), // v9
                or(8, 9),      // v10
            ],
            Terminator::Return(10),
        );
        run_one(&mut f, true);
        let Inst::Bswap { value, width: 4 } = f.insts[10] else {
            panic!("expected a 4-byte reversal, got {:?}", f.insts[10]);
        };
        assert!(
            matches!(
                f.insts[value as usize],
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::U32,
                    volatile: false,
                    align: 1
                }
            ),
            "expected the reversal over a wide load, got {:?}",
            f.insts[value as usize]
        );
    }

    /// The same big-endian assembly on a big-endian target is already
    /// the target's order: a wide load and no reversal.
    #[test]
    fn be_assembly_on_be_target_needs_no_reversal() {
        let mut f = fresh(
            alloc::vec![
                param(0),      // v0
                u8_load(0, 0), // v1
                shl(1, 24),    // v2
                u8_load(0, 1), // v3
                shl(3, 16),    // v4
                u8_load(0, 2), // v5
                shl(5, 8),     // v6
                u8_load(0, 3), // v7
                or(2, 4),      // v8
                or(8, 6),      // v9
                or(9, 7),      // v10
            ],
            Terminator::Return(10),
        );
        run_one(&mut f, false);
        assert!(
            matches!(
                f.insts[10],
                Inst::Load {
                    kind: LoadKind::U32,
                    ..
                }
            ),
            "expected a wide load, got {:?}",
            f.insts[10]
        );
        // The little-endian assembly is the reversed one there.
        let mut g = fresh(
            alloc::vec![param(0), u8_load(0, 0), u8_load(0, 1), shl(2, 8), or(1, 3),],
            Terminator::Return(4),
        );
        run_one(&mut g, false);
        assert!(
            matches!(g.insts[4], Inst::Bswap { width: 2, .. }),
            "expected a 2-byte reversal, got {:?}",
            g.insts[4]
        );
    }

    /// A volatile part is an access the abstract machine performs as
    /// written (C99 6.7.3p6), so the idiom is left alone.
    #[test]
    fn volatile_part_is_not_merged() {
        let mut f = fresh(
            alloc::vec![
                param(0),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::U8,
                    volatile: true,
                    align: 0
                }, // v1
                u8_load(0, 1), // v2
                shl(2, 8),     // v3
                or(1, 3),      // v4
            ],
            Terminator::Return(4),
        );
        run_one(&mut f, true);
        assert!(matches!(f.insts[4], Inst::Binop { op: BinOp::Or, .. }));
    }

    /// `-mstrict-align` forbids widening past the alignment the parts
    /// prove, which is one byte.
    #[test]
    fn strict_align_declines() {
        let mut f = fresh(
            alloc::vec![param(0), u8_load(0, 0), u8_load(0, 1), shl(2, 8), or(1, 3),],
            Terminator::Return(4),
        );
        run(core::slice::from_mut(&mut f), true, true);
        assert!(matches!(f.insts[4], Inst::Binop { op: BinOp::Or, .. }));
        run(core::slice::from_mut(&mut f), true, false);
        assert!(matches!(
            f.insts[4],
            Inst::Load {
                kind: LoadKind::U16,
                ..
            }
        ));
    }

    /// A store between the parts can write the range being read.
    #[test]
    fn intervening_store_blocks_the_load_merge() {
        let mut f = fresh(
            alloc::vec![
                param(0),          // v0
                param(1),          // v1
                u8_load(0, 0),     // v2
                i8_store(1, 0, 2), // v3
                u8_load(0, 1),     // v4
                shl(4, 8),         // v5
                or(2, 5),          // v6
            ],
            Terminator::Return(6),
        );
        run_one(&mut f, true);
        assert!(matches!(f.insts[6], Inst::Binop { op: BinOp::Or, .. }));
    }

    /// A call between the parts can write the range through any
    /// pointer that escaped to it.
    #[test]
    fn intervening_call_blocks_the_load_merge() {
        let mut f = fresh(
            alloc::vec![
                param(0),      // v0
                u8_load(0, 0), // v1
                Inst::Call {
                    target_pc: 0,
                    args: Vec::new(),
                    fixed_args: 0,
                    fp_return: false,
                    fp_arg_mask: 0,
                    arg_aggs: Vec::new(),
                    ret_agg: None,
                    ret_slot_local: 0,
                }, // v2
                u8_load(0, 1), // v3
                shl(3, 8),     // v4
                or(1, 4),      // v5
            ],
            Terminator::Return(5),
        );
        run_one(&mut f, true);
        assert!(matches!(f.insts[5], Inst::Binop { op: BinOp::Or, .. }));
    }

    /// Three bytes are not a hardware width, so they stay as written.
    #[test]
    fn partial_coverage_is_not_merged() {
        let mut f = fresh(
            alloc::vec![
                param(0),
                u8_load(0, 0), // v1
                u8_load(0, 1), // v2
                shl(2, 8),     // v3
                u8_load(0, 2), // v4
                shl(4, 16),    // v5
                or(1, 3),      // v6
                or(6, 5),      // v7
            ],
            Terminator::Return(7),
        );
        run_one(&mut f, true);
        assert!(matches!(f.insts[7], Inst::Binop { op: BinOp::Or, .. }));
    }

    /// A gap at offset 2 leaves the bytes non-contiguous.
    #[test]
    fn gap_in_offsets_is_not_merged() {
        let mut f = fresh(
            alloc::vec![
                param(0),
                u8_load(0, 0), // v1
                u8_load(0, 1), // v2
                shl(2, 8),     // v3
                u8_load(0, 3), // v4
                shl(4, 16),    // v5
                u8_load(0, 4), // v6
                shl(6, 24),    // v7
                or(1, 3),      // v8
                or(8, 5),      // v9
                or(9, 7),      // v10
            ],
            Terminator::Return(10),
        );
        run_one(&mut f, true);
        assert!(matches!(f.insts[10], Inst::Binop { op: BinOp::Or, .. }));
    }

    /// Offsets and shifts that pair up in neither order (bytes 1 and 2
    /// swapped) describe no wide access.
    #[test]
    fn scrambled_order_is_not_merged() {
        let mut f = fresh(
            alloc::vec![
                param(0),
                u8_load(0, 0), // v1
                u8_load(0, 1), // v2
                shl(2, 16),    // v3
                u8_load(0, 2), // v4
                shl(4, 8),     // v5
                u8_load(0, 3), // v6
                shl(6, 24),    // v7
                or(1, 3),      // v8
                or(8, 5),      // v9
                or(9, 7),      // v10
            ],
            Terminator::Return(10),
        );
        run_one(&mut f, true);
        assert!(matches!(f.insts[10], Inst::Binop { op: BinOp::Or, .. }));
    }

    /// The immediate-offset encodings take a displacement that is a
    /// multiple of the access width, so a run starting at an offset
    /// that is not stays as written.
    #[test]
    fn unaligned_displacement_is_not_merged() {
        let mut f = fresh(
            alloc::vec![
                param(0),
                u8_load(0, 1), // v1
                u8_load(0, 2), // v2
                shl(2, 8),     // v3
                u8_load(0, 3), // v4
                shl(4, 16),    // v5
                u8_load(0, 4), // v6
                shl(6, 24),    // v7
                or(1, 3),      // v8
                or(8, 5),      // v9
                or(9, 7),      // v10
            ],
            Terminator::Return(10),
        );
        run_one(&mut f, true);
        assert!(matches!(f.insts[10], Inst::Binop { op: BinOp::Or, .. }));
    }

    /// A mask that clears a byte the assembly contributes is not
    /// transparent.
    #[test]
    fn mask_dropping_a_byte_is_not_merged() {
        let mut f = fresh(
            alloc::vec![
                param(0),      // v0
                u8_load(0, 0), // v1
                u8_load(0, 1), // v2
                shl(2, 8),     // v3
                Inst::BinopI {
                    op: BinOp::And,
                    lhs: 3,
                    rhs_imm: 0xff
                }, // v4 clears byte 1
                or(1, 4),      // v5
            ],
            Terminator::Return(5),
        );
        run_one(&mut f, true);
        assert!(matches!(f.insts[5], Inst::Binop { op: BinOp::Or, .. }));
    }

    /// A part feeding something else as well must keep its own value.
    #[test]
    fn multi_use_part_is_not_merged() {
        let mut f = fresh(
            alloc::vec![
                param(0),      // v0
                u8_load(0, 0), // v1
                u8_load(0, 1), // v2
                shl(2, 8),     // v3
                or(1, 3),      // v4
                or(4, 1),      // v5 second use of v1
            ],
            Terminator::Return(5),
        );
        run_one(&mut f, true);
        assert!(matches!(f.insts[4], Inst::Binop { op: BinOp::Or, .. }));
    }

    /// `p[0]=v; p[1]=v>>8; p[2]=v>>16; p[3]=v>>24` is the target's
    /// order: one wide store of `v`.
    #[test]
    fn le_store_run_becomes_wide_store() {
        let mut f = fresh(
            alloc::vec![
                param(0),          // v0 dst
                param(1),          // v1 src
                i8_store(0, 0, 1), // v2
                shru(1, 8),        // v3
                i8_store(0, 1, 3), // v4
                shru(1, 16),       // v5
                i8_store(0, 2, 5), // v6
                shru(1, 24),       // v7
                i8_store(0, 3, 7), // v8
            ],
            Terminator::Return(NO_VALUE),
        );
        run_one(&mut f, true);
        assert!(
            matches!(
                f.insts[8],
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 1,
                    kind: StoreKind::I32,
                    volatile: false,
                    align: 1
                }
            ),
            "expected a wide I32 store, got {:?}",
            f.insts[8]
        );
    }

    /// The reversed order: a byte reversal of the source feeding one
    /// wide store.
    #[test]
    fn be_store_run_becomes_bswap_plus_wide_store() {
        let mut insts: Vec<Inst> = alloc::vec![param(0), param(1)];
        for d in 0..8i32 {
            let sh = 8 * (7 - d) as i64;
            if sh == 0 {
                insts.push(i8_store(0, d, 1));
            } else {
                insts.push(shru(1, sh));
                let shifted = (insts.len() - 1) as ValueId;
                insts.push(i8_store(0, d, shifted));
            }
        }
        let last = (insts.len() - 1) as ValueId;
        let mut f = fresh(insts, Terminator::Return(NO_VALUE));
        run_one(&mut f, true);
        let Inst::Store {
            value,
            kind: StoreKind::I64,
            disp: 0,
            align: 1,
            ..
        } = f.insts[last as usize]
        else {
            panic!(
                "expected a wide I64 store, got {:?}",
                f.insts[last as usize]
            );
        };
        assert!(
            matches!(f.insts[value as usize], Inst::Bswap { value: 1, width: 8 }),
            "expected the store of a reversal of the source, got {:?}",
            f.insts[value as usize]
        );
    }

    /// Two adjacent runs of the same source merge separately rather
    /// than colliding over the shared shift set.
    #[test]
    fn two_runs_of_one_source_merge_separately() {
        let mut f = fresh(
            alloc::vec![
                param(0),          // v0
                param(1),          // v1
                i8_store(0, 0, 1), // v2
                shru(1, 8),        // v3
                i8_store(0, 1, 3), // v4
                i8_store(0, 2, 1), // v5
                i8_store(0, 3, 3), // v6
            ],
            Terminator::Return(NO_VALUE),
        );
        run_one(&mut f, true);
        assert!(
            matches!(
                f.insts[4],
                Inst::Store {
                    disp: 0,
                    kind: StoreKind::I16,
                    ..
                }
            ),
            "first run: {:?}",
            f.insts[4]
        );
        assert!(
            matches!(
                f.insts[6],
                Inst::Store {
                    disp: 2,
                    kind: StoreKind::I16,
                    ..
                }
            ),
            "second run: {:?}",
            f.insts[6]
        );
    }

    /// A load between the parts would see the range half written.
    #[test]
    fn intervening_load_blocks_the_store_merge() {
        let mut f = fresh(
            alloc::vec![
                param(0),          // v0
                param(1),          // v1
                i8_store(0, 0, 1), // v2
                u8_load(0, 8),     // v3
                shru(1, 8),        // v4
                i8_store(0, 1, 4), // v5
            ],
            Terminator::Return(NO_VALUE),
        );
        run_one(&mut f, true);
        assert!(matches!(
            f.insts[5],
            Inst::Store {
                kind: StoreKind::I8,
                ..
            }
        ));
    }

    /// A stored byte read back by something else keeps its store.
    #[test]
    fn store_value_read_back_blocks_the_merge() {
        let mut f = fresh(
            alloc::vec![
                param(0),          // v0
                param(1),          // v1
                i8_store(0, 0, 1), // v2
                shru(1, 8),        // v3
                i8_store(0, 1, 3), // v4
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 4,
                    rhs_imm: 1
                }, // v5 reads the store's value
            ],
            Terminator::Return(5),
        );
        run_one(&mut f, true);
        assert!(matches!(
            f.insts[4],
            Inst::Store {
                kind: StoreKind::I8,
                ..
            }
        ));
    }
}

//! Integer stores that tile a word become one store of the word.
//!
//! Stores to one base that cover a 2-, 4- or 8-byte unit at a multiple of
//! its width, each of a constant except at most the part holding the
//! unit's low-order bytes, leave the bytes one store of the unit leaves:
//! the constants combined, or the variable part zero-extended when every
//! constant beside it is zero. A union written through a narrower member
//! with its remaining bytes zeroed, and an initializer that zeroes the
//! members and padding it does not name, are the usual sources. A later
//! load of the unit then reads a single store, which x86-64 store-to-load
//! forwarding requires: a load is forwarded only from one store that
//! contains it (Intel 64 and IA-32 Architectures Optimization Reference
//! Manual, store forwarding).
//!
//! The parts are collected walking back from the latest one, which becomes
//! the merged store, so each byte comes from its last writer. No
//! instruction between the parts may read or write the unit, through its
//! base or another address that may reach it. The merged access proves the
//! alignment its parts proved; under `-mstrict-align` a unit not proven
//! aligned to its width stays split.
//!
//! Runs after `store_forward`, which hands the narrow stores to loads of
//! their own width first. Rewrites are in place: the tape neither grows nor
//! renumbers, and the replaced parts drop out as dead constants.

use alloc::vec::Vec;

use super::byteload::{base_avoids_frame, eval_const, resolve_base_offset};
use super::value_range::def_ranges;
use crate::c5::codegen::ssa::reg_alloc::compute_use_counts;
use crate::c5::ir::{BinOp, FunctionSsa, Inst, StoreKind, ValueId};

/// Instructions looked back over from a unit's last part.
const WINDOW: usize = 32;

pub(crate) fn run(funcs: &mut [FunctionSsa], little_endian: bool, strict_align: bool) {
    for func in funcs.iter_mut() {
        run_one(func, little_endian, strict_align);
    }
}

/// What a store writes through: a value's address, or a frame object.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Base {
    Addr(ValueId),
    Frame(i64),
}

/// A non-volatile integer store: its bytes `off..off + width` of `base`,
/// the value, and the alignment proven at its address.
#[derive(Clone, Copy)]
struct Part {
    id: usize,
    base: Base,
    off: i64,
    width: i64,
    value: ValueId,
    align: i64,
}

fn int_width(kind: StoreKind) -> Option<i64> {
    matches!(
        kind,
        StoreKind::I8 | StoreKind::I16 | StoreKind::I32 | StoreKind::I64
    )
    .then(|| i64::from(kind.bytes()))
}

fn part(func: &FunctionSsa, id: usize) -> Option<Part> {
    match func.insts[id] {
        Inst::Store {
            addr,
            disp,
            value,
            kind,
            volatile: false,
            align,
            pc_rel: false,
        } => {
            let width = int_width(kind)?;
            let (base, off) = resolve_base_offset(func, addr, disp);
            let align = if align == 0 { width } else { i64::from(align) };
            Some(Part {
                id,
                base: Base::Addr(base),
                off,
                width,
                value,
                align,
            })
        }
        Inst::StoreLocal {
            off,
            disp,
            value,
            kind,
            volatile: false,
            ..
        } => {
            let width = int_width(kind)?;
            let disp = i64::from(disp);
            // A frame object starts 8-aligned.
            Some(Part {
                id,
                base: Base::Frame(off),
                off: disp,
                width,
                value,
                align: 1 << disp.trailing_zeros().min(3),
            })
        }
        _ => None,
    }
}

fn overlaps(off: i64, width: i64, lo: i64, n: i64) -> bool {
    off < lo + n && lo < off + width
}

/// Whether `inst`, standing between the parts, may read or write bytes
/// `lo..lo + n` of `base`.
fn hazard(func: &FunctionSsa, inst: &Inst, base: Base, lo: i64, n: i64) -> bool {
    let through = |addr: ValueId, disp: i32, width: u8| match base {
        Base::Addr(b) => {
            let (b2, off) = resolve_base_offset(func, addr, disp);
            b2 != b || overlaps(off, i64::from(width), lo, n)
        }
        Base::Frame(_) => true,
    };
    let local = |off: i64, disp: i32, width: u8| match base {
        Base::Frame(f) => off == f && overlaps(i64::from(disp), i64::from(width), lo, n),
        Base::Addr(b) => !base_avoids_frame(func, b),
    };
    match *inst {
        Inst::Store {
            addr,
            disp,
            kind,
            volatile: false,
            pc_rel: false,
            ..
        } => through(addr, disp, kind.bytes()),
        Inst::Load {
            addr,
            disp,
            kind,
            volatile: false,
            pc_rel: false,
            ..
        } => through(addr, disp, kind.bytes()),
        Inst::StoreLocal {
            off,
            disp,
            kind,
            volatile: false,
            ..
        } => local(off, disp, kind.bytes()),
        Inst::LoadLocal {
            off,
            disp,
            kind,
            volatile: false,
            ..
        } => local(off, disp, kind.bytes()),
        _ => !register_only(inst),
    }
}

/// Instructions that neither read nor write memory.
fn register_only(inst: &Inst) -> bool {
    matches!(
        inst,
        Inst::Imm(_)
            | Inst::Undef
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::ImmExtCode(_)
            | Inst::LocalAddr(_)
            | Inst::TlsAddr(_)
            | Inst::Binop { .. }
            | Inst::BinopI { .. }
            | Inst::Neg(_)
            | Inst::Fneg(_)
            | Inst::Fma { .. }
            | Inst::MulAdd { .. }
            | Inst::ShiftOp { .. }
            | Inst::BitField { .. }
            | Inst::FpCast { .. }
            | Inst::Extend { .. }
            | Inst::Bswap { .. }
            | Inst::BitCount { .. }
            | Inst::Copy { .. }
            | Inst::Select { .. }
    )
}

/// A part and the bytes of the unit it leaves, bit `i` for byte `lo + i`.
type Tile = Vec<(Part, u32)>;

/// The parts that tile the unit of `n` bytes holding `last`, found walking
/// back from it; `None` when a byte has no part or a hazard intervenes. A
/// part a later one partly overwrites leaves the rest of its bytes.
fn tile(
    func: &FunctionSsa,
    start: usize,
    last: Part,
    n: i64,
    claimed: &[bool],
) -> Option<(i64, Tile)> {
    let lo = last.off.div_euclid(n) * n;
    if last.width >= n || last.off + last.width > lo + n {
        return None;
    }
    let bits = |p: &Part| ((1u32 << p.width) - 1) << (p.off - lo);
    let full = (1u32 << n) - 1;
    let mut covered = bits(&last);
    let mut parts = alloc::vec![(last, covered)];
    for id in (start..last.id).rev().take(WINDOW) {
        match part(func, id) {
            Some(p) if p.base == last.base => {
                if !overlaps(p.off, p.width, lo, n) {
                    continue;
                }
                if p.off < lo || p.off + p.width > lo + n || claimed[id] {
                    return None;
                }
                let left = bits(&p) & !covered;
                if left == 0 {
                    continue;
                }
                covered |= left;
                parts.push((p, left));
                if covered == full {
                    return Some((lo, parts));
                }
            }
            _ if hazard(func, &func.insts[id], last.base, lo, n) => return None,
            _ => {}
        }
    }
    None
}

/// The alignment the parts prove at the unit's start.
fn proven_align(parts: &Tile, lo: i64) -> i64 {
    parts
        .iter()
        .map(|(p, _)| match p.off - lo {
            0 => p.align,
            d => p.align.min(1 << d.trailing_zeros()),
        })
        .max()
        .unwrap_or(1)
}

/// The value the merged store writes: a constant, or one part's value
/// zero-extended from its width.
enum Merged {
    Const(i64),
    ZeroExt(Part),
}

fn merged_value(func: &FunctionSsa, parts: &Tile, lo: i64, n: i64, le: bool) -> Option<Merged> {
    let mut constant = 0u64;
    let mut var = None;
    for &(p, left) in parts {
        let rel = p.off - lo;
        let Some(k) = eval_const(func, p.value, 0) else {
            // The variable part supplies the low-order end, whole.
            let low_end = if le { rel == 0 } else { rel + p.width == n };
            if var.is_some() || !low_end || left != ((1u32 << p.width) - 1) << rel {
                return None;
            }
            var = Some(p);
            continue;
        };
        for i in (0..n).filter(|&i| left & (1 << i) != 0) {
            let j = i - rel;
            let byte = if le { j } else { p.width - 1 - j };
            let pos = if le { i } else { n - 1 - i };
            constant |= ((k as u64 >> (8 * byte)) & 0xff) << (8 * pos);
        }
    }
    match var {
        None => Some(Merged::Const(constant as i64)),
        Some(p) if constant == 0 => Some(Merged::ZeroExt(p)),
        Some(_) => None,
    }
}

/// The tape slot of the merged value: the latest part but the last that
/// follows the value it extends.
fn value_slot(parts: &Tile, value: &Merged) -> Option<usize> {
    let after = match value {
        Merged::ZeroExt(p) => p.value as usize,
        Merged::Const(_) => 0,
    };
    parts[1..]
        .iter()
        .map(|(p, _)| p.id)
        .filter(|&id| id > after)
        .max()
}

fn run_one(func: &mut FunctionSsa, little_endian: bool, strict_align: bool) {
    let uc = compute_use_counts(func);
    let mut claimed = alloc::vec![false; func.insts.len()];
    let mut merges: Vec<(i64, i64, Tile, Merged, usize)> = Vec::new();
    for block in &func.blocks {
        let start = block.inst_range.start as usize;
        let end = (block.inst_range.end as usize).min(func.insts.len());
        for id in (start..end).rev() {
            if claimed[id] {
                continue;
            }
            let Some(last) = part(func, id) else {
                continue;
            };
            for n in [8, 4, 2] {
                let Some((lo, parts)) = tile(func, start, last, n, &claimed) else {
                    continue;
                };
                // A store's id stands for the value it leaves; a read one
                // keeps its store.
                if parts.iter().any(|(p, _)| uc[p.id] != 0)
                    || (strict_align && proven_align(&parts, lo) < n)
                {
                    continue;
                }
                let Some(value) = merged_value(func, &parts, lo, n, little_endian) else {
                    continue;
                };
                let Some(slot) = value_slot(&parts, &value) else {
                    continue;
                };
                for (p, _) in &parts {
                    claimed[p.id] = true;
                }
                merges.push((lo, n, parts, value, slot));
                break;
            }
        }
    }
    // A value whose range its width's mask keeps is stored as it is.
    let ranges = merges
        .iter()
        .any(|m| matches!(m.3, Merged::ZeroExt(_)))
        .then(|| def_ranges(func, &[]));
    for (lo, n, parts, value, slot) in merges {
        let stored = match &value {
            Merged::ZeroExt(p) => ranges
                .as_ref()
                .and_then(|r| r.get(p.value as usize))
                .is_some_and(|r| r.kept_by_mask(low_mask(p.width)))
                .then_some(p.value),
            Merged::Const(_) => None,
        };
        rewrite(func, lo, n, &parts, value, slot, stored);
    }
}

fn low_mask(width: i64) -> i64 {
    (u64::MAX >> (64 - 8 * width)) as i64
}

fn rewrite(
    func: &mut FunctionSsa,
    lo: i64,
    n: i64,
    parts: &Tile,
    value: Merged,
    slot: usize,
    stored: Option<ValueId>,
) {
    let last = parts[0].0;
    let stored_value = stored.unwrap_or(slot as ValueId);
    let proven = proven_align(parts, lo);
    let at = parts
        .iter()
        .find(|(p, _)| p.off == lo)
        .and_then(|(p, _)| match func.insts[p.id] {
            Inst::Store { addr, disp, .. } => Some((addr, disp)),
            _ => None,
        });
    let kind = match n {
        8 => StoreKind::I64,
        4 => StoreKind::I32,
        _ => StoreKind::I16,
    };
    let store = match (last.base, at) {
        (Base::Frame(off), _) => Inst::StoreLocal {
            off,
            disp: lo as i32,
            value: stored_value,
            kind,
            volatile: false,
            nsw: false,
        },
        (Base::Addr(_), Some((addr, disp))) => Inst::Store {
            addr,
            disp,
            value: stored_value,
            kind,
            volatile: false,
            align: if proven >= n { 0 } else { proven as u8 },
            pc_rel: false,
        },
        (Base::Addr(_), None) => {
            unreachable!("ICE: merge_stores: the unit's first part is not a store")
        }
    };
    for (p, _) in &parts[1..] {
        func.insts[p.id] = Inst::Imm(0);
    }
    func.insts[slot] = match value {
        Merged::Const(k) => Inst::Imm(k),
        Merged::ZeroExt(_) if stored.is_some() => Inst::Imm(0),
        Merged::ZeroExt(p) => Inst::BinopI {
            op: BinOp::And,
            lhs: p.value,
            rhs_imm: low_mask(p.width),
        },
    };
    for (p, _) in parts {
        if let Some(f) = func.f32_values.get_mut(p.id) {
            *f = false;
        }
    }
    func.insts[last.id] = store;
}

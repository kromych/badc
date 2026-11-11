//! Whole-object vector slots as values. A two-cell object accessed whole --
//! 16-byte copies and zero fills, `V128` loads and stores, 16-byte SIMD asm
//! operands -- or by lane at an offset aligned to the lane's width becomes
//! `V128` slot accesses for mem2reg to promote, each lane access a
//! `VecExtract` or `VecInsert` of the slot's vector; a four- or eight-cell
//! one met by `V256` or `V512` accesses becomes one the same way at its
//! width, provided something reads it and it meets a SIMD operand or a
//! vector ABI piece directly or through whole copies. A one-cell object an
//! 8-byte SIMD operand meets becomes `F64` accesses the same way
//! ([`cell_slots`]). An asm output keeps its address for `asm_outputs`,
//! which makes it a value stored to the slot.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use super::super::ir::{
    AsmBlock, AsmConstraint, AsmSeg, BinOp, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind,
    Terminator, ValueId,
};
use super::tape::{At, Insertion, insert};

/// One rewritten access, by its tape index before the rewrite.
enum Edit {
    /// A lane read: the slot's vector loaded and the lane extracted.
    LaneLoad {
        at: ValueId,
        base: i64,
        byte: u8,
        kind: LoadKind,
    },
    /// A lane write: the slot's vector loaded, the lane inserted, the
    /// vector stored back.
    LaneStore {
        at: ValueId,
        base: i64,
        byte: u8,
        kind: StoreKind,
    },
    Addr {
        at: ValueId,
    },
    Load {
        at: ValueId,
        off: i64,
    },
    Store {
        at: ValueId,
        off: i64,
    },
    Copy {
        at: ValueId,
        src: Side,
        dst: Side,
    },
    Zero {
        at: ValueId,
        off: i64,
    },
    Asm {
        at: ValueId,
        inputs: Vec<(usize, i64)>,
    },
}

#[derive(Clone, Copy)]
enum Side {
    Slot(i64),
    Addr(ValueId),
}

/// The whole-object access kinds of a rewritten slot and its size in
/// 8-byte cells.
#[derive(Clone, Copy)]
struct Whole {
    load: LoadKind,
    store: StoreKind,
    cells: i64,
}

const QUAD: Whole = Whole {
    load: LoadKind::V128,
    store: StoreKind::V128,
    cells: 2,
};

/// The AVX and AVX-512 widths; only code built for them accesses a slot
/// at these kinds, which selects it.
const WIDE: [Whole; 2] = [
    Whole {
        load: LoadKind::V256,
        store: StoreKind::V256,
        cells: 4,
    },
    Whole {
        load: LoadKind::V512,
        store: StoreKind::V512,
        cells: 8,
    },
];

const DOUBLE: Whole = Whole {
    load: LoadKind::F64,
    store: StoreKind::F64,
    cells: 1,
};

/// The byte width of a scalar lane access of `kind`, `None` for the wide and
/// long-double kinds.
fn lane_load_bytes(kind: LoadKind) -> Option<u8> {
    match kind {
        LoadKind::F32 => Some(4),
        LoadKind::F64 => Some(8),
        k => k.int_bytes(),
    }
}

fn lane_store_bytes(kind: StoreKind) -> Option<u8> {
    match kind {
        StoreKind::I8 => Some(1),
        StoreKind::I16 => Some(2),
        StoreKind::I32 | StoreKind::F32 => Some(4),
        StoreKind::I64 | StoreKind::F64 => Some(8),
        _ => None,
    }
}

/// Rewrite the eligible slots of `func`; returns them.
pub(crate) fn run(func: &mut FunctionSsa) -> BTreeSet<i64> {
    if !applies(func) {
        return BTreeSet::new();
    }
    let mut slots = BTreeSet::new();
    for w in [QUAD].into_iter().chain(WIDE) {
        let s = eligible(func, false, w);
        if !s.is_empty() {
            rewrite(func, &s, w);
            slots.extend(s);
        }
    }
    let cells = cell_slots(func);
    if !cells.is_empty() {
        retype_cells(func, &cells);
        rewrite(func, &cells, DOUBLE);
        slots.extend(cells);
    }
    slots
}

/// Each lane write into a vector wider than 16 bytes as a write into its
/// 128-bit part: the part read out (a `V128` `VecExtract`), the lane
/// inserted into it and the part inserted back. constfold then reads each
/// part through the writes before it, so lane writes into one part chain
/// on that part alone and the vector takes the part once. A lane read
/// above the low part reads the part, which reads of its other lanes share.
pub(crate) fn split_wide_lanes(func: &mut FunctionSsa) {
    split_wide_reads(func);
    let sites: Vec<ValueId> = func
        .blocks
        .iter()
        .flat_map(|b| b.inst_range.clone())
        .filter(|&v| {
            matches!(func.insts[v as usize], Inst::VecInsert { bytes, kind, .. }
                if bytes > 16 && kind != StoreKind::V128)
        })
        .collect();
    if sites.is_empty() {
        return;
    }
    let mut ins: Vec<Insertion> = Vec::with_capacity(2 * sites.len());
    for &v in &sites {
        let Inst::VecInsert {
            vec, off, bytes, ..
        } = func.insts[v as usize]
        else {
            continue;
        };
        let part = off & !15;
        let mut put = |at: At, inst: Inst| {
            ins.push(Insertion {
                at,
                inst,
                is_f32: false,
                copy_of: None,
            })
        };
        put(
            At::Before(v),
            Inst::VecExtract {
                vec,
                off: part,
                kind: LoadKind::V128,
                bytes,
            },
        );
        put(
            At::After(v),
            Inst::VecInsert {
                vec,
                value: v,
                off: part,
                kind: StoreKind::V128,
                bytes,
            },
        );
    }
    let rw = insert(func, &ins);
    // A reader of a split write reads the vector with the part back in.
    let mut whole: BTreeMap<ValueId, ValueId> = BTreeMap::new();
    for (k, &v) in sites.iter().enumerate() {
        let n = rw.remap[v as usize];
        if let Inst::VecInsert {
            vec, off, bytes, ..
        } = &mut func.insts[n as usize]
        {
            *vec = rw.ids[2 * k];
            *off &= 15;
            *bytes = 16;
        }
        whole.insert(n, rw.ids[2 * k + 1]);
    }
    let back: BTreeSet<ValueId> = whole.values().copied().collect();
    let to = |v: &mut ValueId| {
        if let Some(&w) = whole.get(v) {
            *v = w;
        }
    };
    for (i, inst) in func.insts.iter_mut().enumerate() {
        match inst {
            // The part goes back into the vector the write read.
            Inst::VecInsert { vec, .. } if back.contains(&(i as ValueId)) => to(vec),
            _ => inst.for_each_operand_mut(to),
        }
    }
    for b in func.blocks.iter_mut() {
        b.terminator.for_each_operand_mut(to);
        if b.exit_acc != NO_VALUE {
            to(&mut b.exit_acc);
        }
    }
}

/// The reads half of [`split_wide_lanes`].
fn split_wide_reads(func: &mut FunctionSsa) {
    let sites: Vec<ValueId> = func
        .blocks
        .iter()
        .flat_map(|b| b.inst_range.clone())
        .filter(|&v| {
            matches!(func.insts[v as usize], Inst::VecExtract { bytes, kind, off, .. }
                if bytes > 16 && kind != LoadKind::V128 && off >= 16)
        })
        .collect();
    if sites.is_empty() {
        return;
    }
    let ins: Vec<Insertion> = sites
        .iter()
        .filter_map(|&v| match func.insts[v as usize] {
            Inst::VecExtract {
                vec, off, bytes, ..
            } => Some(Insertion {
                at: At::Before(v),
                inst: Inst::VecExtract {
                    vec,
                    off: off & !15,
                    kind: LoadKind::V128,
                    bytes,
                },
                is_f32: false,
                copy_of: None,
            }),
            _ => None,
        })
        .collect();
    let rw = insert(func, &ins);
    for (k, &v) in sites.iter().enumerate() {
        if let Inst::VecExtract {
            vec, off, bytes, ..
        } = &mut func.insts[rw.remap[v as usize] as usize]
        {
            *vec = rw.ids[k];
            *off &= 15;
            *bytes = 16;
        }
    }
}

pub(crate) fn applies(func: &FunctionSsa) -> bool {
    !(func.is_naked || func.has_returns_twice_call || func.has_sp_asm())
}

/// [`run`]'s slots once `callee` is spliced: its aggregate parameters are
/// ordinary objects there, and a vector return is read back whole.
pub(crate) fn spliced_slots(callee: &FunctionSsa) -> BTreeSet<i64> {
    let mut slots = BTreeSet::new();
    for w in [QUAD].into_iter().chain(WIDE) {
        slots.extend(eligible(callee, true, w));
    }
    slots
}

fn slot_load(off: i64, w: Whole) -> Inst {
    Inst::LoadLocal {
        off,
        disp: 0,
        kind: w.load,
        volatile: false,
    }
}

fn slot_store(off: i64, value: ValueId, w: Whole) -> Inst {
    Inst::StoreLocal {
        off,
        disp: 0,
        value,
        kind: w.store,
        volatile: false,
        nsw: false,
    }
}

/// The slots of `w`'s size accessed whole at its kinds or by lane. With
/// `spliced`, see [`spliced_slots`].
fn eligible(func: &FunctionSsa, spliced: bool, w: Whole) -> BTreeSet<i64> {
    let bytes = w.cells * 8;
    // A lane access of slot `b` at cell `off` and byte `disp`, of `n` bytes.
    let lane = |b: i64, off: i64, disp: i64, n: Option<u8>, volatile: bool| {
        let at = (off - b) * 8 + disp;
        n.is_some_and(|n| {
            let n = i64::from(n);
            !volatile && at >= 0 && at % n == 0 && at + n <= bytes
        })
    };
    let mut slots: BTreeSet<i64> = func
        .multi_cell_slots
        .iter()
        .filter(|&&(_, cells)| cells == w.cells)
        .map(|&(base, _)| base)
        .collect();
    let params = func.param_local_slots.iter().filter(|_| !spliced);
    for s in params.chain([&func.indirect_result_slot]) {
        slots.remove(s);
    }
    if slots.is_empty() {
        return slots;
    }
    let mut covered = alloc::vec![false; func.insts.len()];
    for b in &func.blocks {
        for v in b.inst_range.clone() {
            covered[v as usize] = true;
        }
    }
    let mut used = alloc::vec![false; func.insts.len()];
    let mut mark = |v: ValueId| {
        if let Some(u) = used.get_mut(v as usize) {
            *u = true;
        }
    };
    for inst in &func.insts {
        inst.for_each_operand(&mut mark);
    }
    for b in &func.blocks {
        b.terminator.for_each_operand(&mut mark);
    }
    // An `asm goto` leaves through its labels too, past a store behind it.
    let goto_asm: BTreeSet<ValueId> = func
        .blocks
        .iter()
        .filter(|b| matches!(b.terminator, Terminator::AsmGoto { .. }) && !b.inst_range.is_empty())
        .map(|b| b.inst_range.end - 1)
        .collect();
    let covering = |off: i64| {
        (0..w.cells)
            .map(move |k| off - k)
            .filter(|b| slots.contains(b))
    };
    let mut reject: BTreeSet<i64> = BTreeSet::new();
    let mut addr: BTreeMap<ValueId, i64> = BTreeMap::new();
    // A slot's address plus a constant byte offset inside it.
    let mut derived: BTreeMap<ValueId, (i64, i64)> = BTreeMap::new();
    let (mut reads, mut simd) = (BTreeSet::new(), BTreeSet::new());
    let mut copies: Vec<(i64, i64)> = Vec::new();
    for (v, inst) in func.insts.iter().enumerate() {
        match *inst {
            Inst::LocalAddr(off) => {
                for b in covering(off) {
                    if b == off && covered[v] {
                        addr.insert(v as ValueId, b);
                    } else {
                        reject.insert(b);
                    }
                }
            }
            Inst::BinopI {
                op: BinOp::Add,
                lhs,
                rhs_imm,
            } if covered[v] && (0..bytes).contains(&rhs_imm) => {
                if let Some(&b) = addr.get(&lhs) {
                    derived.insert(v as ValueId, (b, rhs_imm));
                }
            }
            Inst::LoadLocal {
                off,
                disp,
                kind,
                volatile,
            } => {
                let whole = disp == 0 && kind == w.load && !volatile;
                let n = lane_load_bytes(kind);
                for b in covering(off) {
                    if b == off && whole {
                        reads.insert(off);
                        simd.insert(off);
                    } else if lane(b, off, i64::from(disp), n, volatile) {
                        reads.insert(b);
                    } else {
                        reject.insert(b);
                    }
                }
            }
            Inst::StoreLocal {
                off,
                disp,
                kind,
                volatile,
                ..
            } => {
                let whole = disp == 0 && kind == w.store && !volatile;
                let n = lane_store_bytes(kind);
                for b in covering(off) {
                    if b == off && whole {
                        simd.insert(off);
                    } else if used[v] || !lane(b, off, i64::from(disp), n, volatile) {
                        reject.insert(b);
                    }
                }
            }
            Inst::AllocaInit(off)
            | Inst::Call {
                ret_slot_local: off,
                ..
            }
            | Inst::CallIndirect {
                ret_slot_local: off,
                ..
            }
            | Inst::CallExt {
                ret_slot_local: off,
                ..
            } => reject.extend(covering(off)),
            _ => {}
        }
    }
    for (v, inst) in func.insts.iter().enumerate() {
        let check = |a: ValueId, ok: bool, reject: &mut BTreeSet<i64>| {
            if let Some(b) = addr.get(&a).or(derived.get(&a).map(|(b, _)| b))
                && !(ok && covered[v])
            {
                reject.insert(*b);
            }
        };
        // The slot and byte offset an address operand names.
        let at = |a: ValueId| {
            addr.get(&a)
                .map(|&b| (b, 0))
                .or_else(|| derived.get(&a).copied())
        };
        match inst {
            // The copy's alignment bounds nothing: the vector moves are the
            // unaligned forms.
            Inst::Mcpy { dst, src, size, .. } => {
                let ok = *size == bytes && !used[v];
                check(*dst, ok, &mut reject);
                check(*src, ok, &mut reject);
                if let Some(&s) = addr.get(src) {
                    reads.insert(s);
                    if let Some(&d) = addr.get(dst) {
                        copies.push((d, s));
                    }
                }
            }
            Inst::Mzero { dst, size, .. } => check(*dst, *size == bytes && !used[v], &mut reject),
            Inst::Load {
                addr: a,
                disp,
                kind,
                volatile,
                ..
            } => {
                let whole = addr.contains_key(a) && *disp == 0 && *kind == w.load && !*volatile;
                let ok = whole
                    || at(*a).is_some_and(|(b, k)| {
                        lane(
                            b,
                            b,
                            k + i64::from(*disp),
                            lane_load_bytes(*kind),
                            *volatile,
                        )
                    });
                check(*a, ok, &mut reject);
                if let Some((b, _)) = at(*a) {
                    reads.insert(b);
                    if whole {
                        simd.insert(b);
                    }
                }
            }
            Inst::Store {
                addr: a,
                disp,
                value,
                kind,
                volatile,
                ..
            } => {
                let whole = addr.contains_key(a) && *disp == 0 && *kind == w.store && !*volatile;
                let ok = a != value
                    && (whole
                        || !used[v]
                            && at(*a).is_some_and(|(b, k)| {
                                let n = lane_store_bytes(*kind);
                                lane(b, b, k + i64::from(*disp), n, *volatile)
                            }));
                check(*a, ok, &mut reject);
                check(*value, false, &mut reject);
                if whole && let Some(&b) = addr.get(a) {
                    simd.insert(b);
                }
            }
            Inst::InlineAsm { asm, args } => {
                let goto = goto_asm.contains(&(v as ValueId));
                for (i, &a) in args.iter().enumerate() {
                    let op = asm.operands.get(i);
                    let ok = op.is_some_and(|o| {
                        matches!(o.constraint, AsmConstraint::Fp)
                            && o.width == 16
                            && bytes == 16
                            && !o.value
                            && (!o.is_output || !goto)
                    });
                    check(a, ok, &mut reject);
                    if let (Some(&b), Some(o)) = (addr.get(&a), op) {
                        simd.insert(b);
                        if !o.is_output || o.is_rw {
                            reads.insert(b);
                        }
                    }
                }
            }
            _ if derived.contains_key(&(v as ValueId)) => {}
            _ => inst.for_each_operand(|a| check(a, false, &mut reject)),
        }
    }
    let is_vector = |i: u32| {
        let d = &func.agg_descs[i as usize];
        d.vector && d.size as i64 == bytes
    };
    let vector_return = spliced && func.ret_agg.is_some_and(is_vector);
    // Spliced, a vector parameter's object is filled whole from the argument.
    if spliced {
        for (agg, &slot) in func.param_aggs.iter().zip(&func.param_local_slots) {
            if slot != 0 && agg.is_some_and(is_vector) {
                simd.insert(slot);
            }
        }
    }
    for b in &func.blocks {
        let read_back = vector_return && matches!(b.terminator, Terminator::Return(_));
        b.terminator.for_each_operand(|a| {
            if let Some(&s) = addr.get(&a) {
                if read_back {
                    reads.insert(s);
                    simd.insert(s);
                } else {
                    reject.insert(s);
                }
            }
        });
    }
    slots.retain(|s| !reject.contains(s) && reads.contains(s) && addr.values().any(|b| b == s));
    let mut vector: BTreeSet<i64> = simd.intersection(&slots).copied().collect();
    let mut grew = true;
    while grew {
        grew = false;
        for &(d, s) in &copies {
            if slots.contains(&d)
                && slots.contains(&s)
                && vector.contains(&d) != vector.contains(&s)
            {
                vector.insert(d);
                vector.insert(s);
                grew = true;
            }
        }
    }
    vector
}

fn rewrite(func: &mut FunctionSsa, slots: &BTreeSet<i64>, w: Whole) {
    let addr: BTreeMap<ValueId, i64> = func
        .insts
        .iter()
        .enumerate()
        .filter_map(|(v, inst)| match *inst {
            Inst::LocalAddr(off) if slots.contains(&off) => Some((v as ValueId, off)),
            _ => None,
        })
        .collect();
    let slot_of = |a: ValueId| addr.get(&a).copied();
    // A slot's address plus a constant byte offset inside it.
    let derived: BTreeMap<ValueId, (i64, i64)> = func
        .insts
        .iter()
        .enumerate()
        .filter_map(|(v, inst)| match *inst {
            Inst::BinopI {
                op: BinOp::Add,
                lhs,
                rhs_imm,
            } => slot_of(lhs).map(|b| (v as ValueId, (b, rhs_imm))),
            _ => None,
        })
        .collect();
    let lane_of = |a: ValueId, disp: i32| {
        let (b, k) = slot_of(a)
            .map(|b| (b, 0))
            .or_else(|| derived.get(&a).copied())?;
        Some((b, (k + i64::from(disp)) as u8))
    };
    let side = |slot: Option<i64>, a: ValueId| slot.map_or(Side::Addr(a), Side::Slot);
    let out_addrs: BTreeSet<ValueId> = func
        .insts
        .iter()
        .filter_map(|inst| match inst {
            Inst::InlineAsm { asm, args } => Some((asm, args)),
            _ => None,
        })
        .flat_map(|(asm, args)| {
            asm.operands
                .iter()
                .zip(args)
                .filter(|(op, _)| op.is_output)
                .map(|(_, &a)| a)
        })
        .collect();
    let slot_holding = |off: i64| (0..w.cells).map(|k| off - k).find(|b| slots.contains(b));
    let mut edits: Vec<Edit> = Vec::new();
    for (v, inst) in func.insts.iter().enumerate() {
        let at = v as ValueId;
        match inst {
            Inst::LocalAddr(_) if addr.contains_key(&at) && !out_addrs.contains(&at) => {
                edits.push(Edit::Addr { at })
            }
            Inst::Load {
                addr: a,
                disp,
                kind,
                ..
            } => {
                if let Some(off) = slot_of(*a)
                    && *disp == 0
                    && *kind == w.load
                {
                    edits.push(Edit::Load { at, off });
                } else if let Some((base, byte)) = lane_of(*a, *disp) {
                    edits.push(Edit::LaneLoad {
                        at,
                        base,
                        byte,
                        kind: *kind,
                    });
                }
            }
            Inst::Store {
                addr: a,
                disp,
                kind,
                ..
            } => {
                if let Some(off) = slot_of(*a)
                    && *disp == 0
                    && *kind == w.store
                {
                    edits.push(Edit::Store { at, off });
                } else if let Some((base, byte)) = lane_of(*a, *disp) {
                    edits.push(Edit::LaneStore {
                        at,
                        base,
                        byte,
                        kind: *kind,
                    });
                }
            }
            // A lane access of a slot by cell and byte offset.
            &Inst::LoadLocal {
                off, disp, kind, ..
            } if slot_holding(off).is_some_and(|b| b != off || disp != 0 || kind != w.load) => {
                let base = slot_holding(off).unwrap_or(off);
                edits.push(Edit::LaneLoad {
                    at,
                    base,
                    byte: ((off - base) * 8 + i64::from(disp)) as u8,
                    kind,
                });
            }
            &Inst::StoreLocal {
                off, disp, kind, ..
            } if slot_holding(off).is_some_and(|b| b != off || disp != 0 || kind != w.store) => {
                let base = slot_holding(off).unwrap_or(off);
                edits.push(Edit::LaneStore {
                    at,
                    base,
                    byte: ((off - base) * 8 + i64::from(disp)) as u8,
                    kind,
                });
            }
            Inst::Mcpy { dst, src, .. } => {
                let (d, s) = (slot_of(*dst), slot_of(*src));
                if d.is_some() || s.is_some() {
                    edits.push(Edit::Copy {
                        at,
                        src: side(s, *src),
                        dst: side(d, *dst),
                    });
                }
            }
            Inst::Mzero { dst, .. } => {
                if let Some(off) = slot_of(*dst) {
                    edits.push(Edit::Zero { at, off });
                }
            }
            Inst::InlineAsm { asm, args } => {
                let inputs: Vec<(usize, i64)> = args
                    .iter()
                    .enumerate()
                    .filter(|&(i, _)| !asm.operands[i].is_output)
                    .filter_map(|(i, &a)| slot_of(a).map(|off| (i, off)))
                    .collect();
                if !inputs.is_empty() {
                    edits.push(Edit::Asm { at, inputs });
                }
            }
            _ => {}
        }
    }
    let mut ins: Vec<Insertion> = Vec::new();
    for e in &edits {
        let mut put = |at: ValueId, inst: Inst| {
            ins.push(Insertion {
                at: At::Before(at),
                inst,
                is_f32: false,
                copy_of: None,
            })
        };
        match e {
            Edit::LaneLoad { at, base, .. } => put(*at, slot_load(*base, w)),
            Edit::LaneStore { at, base, .. } => {
                put(*at, slot_load(*base, w));
                ins.push(Insertion {
                    at: At::After(*at),
                    inst: slot_store(*base, *at, w),
                    is_f32: false,
                    copy_of: None,
                });
            }
            Edit::Copy { at, src, .. } => put(
                *at,
                match *src {
                    Side::Slot(off) => slot_load(off, w),
                    Side::Addr(a) => Inst::Load {
                        addr: a,
                        disp: 0,
                        kind: w.load,
                        volatile: false,
                        align: 0,
                        pc_rel: false,
                    },
                },
            ),
            Edit::Zero { at, .. } => put(*at, Inst::Imm(0)),
            Edit::Asm { at, inputs } => {
                for &(_, off) in inputs {
                    put(*at, slot_load(off, w));
                }
            }
            _ => {}
        }
    }
    let rw = insert(func, &ins);
    let mut next = 0usize;
    let mut take = || {
        next += 1;
        rw.ids[next - 1]
    };
    // A block accumulator naming a rewritten instruction loses that value.
    let mut gone: BTreeSet<ValueId> = BTreeSet::new();
    let bytes = (w.cells * 8) as u8;
    for e in &edits {
        match e {
            Edit::LaneLoad { at, byte, kind, .. } => {
                let vec = take();
                func.insts[rw.remap[*at as usize] as usize] = Inst::VecExtract {
                    vec,
                    off: *byte,
                    kind: *kind,
                    bytes,
                };
            }
            Edit::LaneStore { at, byte, kind, .. } => {
                let vec = take();
                take();
                let n = rw.remap[*at as usize];
                let value = match func.insts[n as usize] {
                    Inst::Store { value, .. } | Inst::StoreLocal { value, .. } => value,
                    _ => continue,
                };
                func.insts[n as usize] = Inst::VecInsert {
                    vec,
                    value,
                    off: *byte,
                    kind: *kind,
                    bytes,
                };
                gone.insert(n);
            }
            Edit::Addr { at } => {
                let n = rw.remap[*at as usize];
                func.insts[n as usize] = Inst::Imm(0);
                gone.insert(n);
            }
            Edit::Load { at, off } => {
                func.insts[rw.remap[*at as usize] as usize] = slot_load(*off, w)
            }
            Edit::Store { at, off } => {
                let n = rw.remap[*at as usize] as usize;
                if let Inst::Store { value, .. } = func.insts[n] {
                    func.insts[n] = slot_store(*off, value, w);
                }
            }
            Edit::Copy { at, dst, .. } => {
                let load = take();
                let n = rw.remap[*at as usize];
                func.insts[n as usize] = match *dst {
                    Side::Slot(off) => slot_store(off, load, w),
                    Side::Addr(a) => Inst::Store {
                        addr: rw.remap[a as usize],
                        disp: 0,
                        value: load,
                        kind: w.store,
                        volatile: false,
                        align: 0,
                        pc_rel: false,
                    },
                };
                gone.insert(n);
            }
            Edit::Zero { at, off } => {
                let zero = take();
                let n = rw.remap[*at as usize];
                func.insts[n as usize] = slot_store(*off, zero, w);
                gone.insert(n);
            }
            Edit::Asm { at, inputs } => {
                let loads: Vec<ValueId> = inputs.iter().map(|_| take()).collect();
                let site = rw.remap[*at as usize];
                if let Inst::InlineAsm { asm, args } = &mut func.insts[site as usize] {
                    for (&(i, _), &load) in inputs.iter().zip(&loads) {
                        asm.operands[i].value = true;
                        args[i] = load;
                    }
                }
            }
        }
    }
    for b in &mut func.blocks {
        if gone.contains(&b.exit_acc) {
            b.exit_acc = NO_VALUE;
        }
    }
}

/// Whether operand `i` reads 8 bytes into a SIMD register.
fn simd8_input(asm: &AsmBlock, i: usize) -> bool {
    let op = &asm.operands[i];
    !op.is_output && !op.static_arg && op.width == 8 && asm.operand_class(i) == AsmConstraint::Fp
}

/// Whether operand `i` writes 8 bytes from a SIMD register through the
/// address it is given, which `asm_outputs` may make a value.
fn simd8_output(asm: &AsmBlock, i: usize) -> bool {
    let op = &asm.operands[i];
    op.is_output
        && !op.value
        && !op.volatile_object
        && op.seg == AsmSeg::None
        && op.width == 8
        && op.constraint == AsmConstraint::Fp
}

fn natural(align: u8) -> bool {
    align == 0 || align >= 8
}

fn slot_at(func: &FunctionSsa, a: ValueId) -> Option<i64> {
    match func.insts.get(a as usize) {
        Some(Inst::LocalAddr(off)) => Some(*off),
        _ => None,
    }
}

/// A whole read of a slot, directly or through its address: the slot and
/// the kind.
fn slot_read(func: &FunctionSsa, inst: &Inst) -> Option<(i64, LoadKind)> {
    match *inst {
        Inst::LoadLocal {
            off,
            disp: 0,
            kind,
            volatile: false,
        } => Some((off, kind)),
        Inst::Load {
            addr,
            disp: 0,
            kind,
            volatile: false,
            ..
        } => slot_at(func, addr).map(|off| (off, kind)),
        _ => None,
    }
}

/// A whole write of a slot, directly or through its address: the slot,
/// the value and the kind.
fn slot_write(func: &FunctionSsa, inst: &Inst) -> Option<(i64, ValueId, StoreKind)> {
    match *inst {
        Inst::StoreLocal {
            off,
            disp: 0,
            value,
            kind,
            volatile: false,
            ..
        } => Some((off, value, kind)),
        Inst::Store {
            addr,
            disp: 0,
            value,
            kind,
            volatile: false,
            ..
        } if addr != value => slot_at(func, addr).map(|off| (off, value, kind)),
        _ => None,
    }
}

/// One-cell objects an 8-byte SIMD operand reads or writes: accessed only
/// whole, every value read from one going to such an operand, into another
/// such object or to memory, every value written to one a constant or read
/// from such an object or memory. `F64` accesses carry their bits in the
/// SIMD file. Objects joined by a value take part together, when one of
/// them meets an operand.
fn cell_slots(func: &FunctionSsa) -> BTreeSet<i64> {
    let n = func.insts.len();
    let mut by: Vec<Vec<ValueId>> = alloc::vec![Vec::new(); n];
    for (v, inst) in func.insts.iter().enumerate() {
        inst.for_each_operand(|a| {
            if let Some(u) = by.get_mut(a as usize) {
                u.push(v as ValueId);
            }
        });
    }
    let mut ends = alloc::vec![false; n];
    let mut covered = alloc::vec![false; n];
    for b in &func.blocks {
        b.terminator.for_each_operand(|a| {
            if let Some(e) = ends.get_mut(a as usize) {
                *e = true;
            }
        });
        for v in b.inst_range.clone() {
            covered[v as usize] = true;
        }
    }
    let unread = |v: ValueId| by[v as usize].is_empty() && !ends[v as usize];
    let goto_asm: BTreeSet<ValueId> = func
        .blocks
        .iter()
        .filter(|b| matches!(b.terminator, Terminator::AsmGoto { .. }) && !b.inst_range.is_empty())
        .map(|b| b.inst_range.end - 1)
        .collect();
    let addr_use = |u: ValueId, a: ValueId| match &func.insts[u as usize] {
        Inst::InlineAsm { asm, args } => {
            !goto_asm.contains(&u)
                && args
                    .iter()
                    .enumerate()
                    .all(|(i, &x)| x != a || simd8_output(asm, i))
        }
        Inst::Mcpy {
            dst,
            src,
            size: 8,
            align,
        } => *align >= 8 && (*dst == a) != (*src == a) && unread(u),
        Inst::Mzero { dst, size: 8, .. } => *dst == a && unread(u),
        inst => match (slot_read(func, inst), slot_write(func, inst)) {
            (Some((_, kind)), _) => matches!(kind, LoadKind::I64 | LoadKind::F64),
            (_, Some((_, value, kind))) => {
                value != a && matches!(kind, StoreKind::I64 | StoreKind::F64)
            }
            _ => false,
        },
    };
    let multi = |off: i64| {
        func.multi_cell_slots
            .iter()
            .any(|&(b, c)| c > 1 && b <= off && off < b + c)
    };
    let (mut slots, mut reject) = (BTreeSet::new(), BTreeSet::new());
    for (v, inst) in func.insts.iter().enumerate() {
        let (off, ok) = match *inst {
            Inst::LocalAddr(off) => (
                off,
                covered[v] && !ends[v] && by[v].iter().all(|&u| addr_use(u, v as ValueId)),
            ),
            Inst::LoadLocal {
                off,
                disp,
                kind,
                volatile,
            } => (
                off,
                disp == 0 && !volatile && matches!(kind, LoadKind::I64 | LoadKind::F64),
            ),
            Inst::StoreLocal {
                off,
                disp,
                kind,
                volatile,
                ..
            } => (
                off,
                disp == 0 && !volatile && matches!(kind, StoreKind::I64 | StoreKind::F64),
            ),
            Inst::AllocaInit(off)
            | Inst::Call {
                ret_slot_local: off,
                ..
            }
            | Inst::CallIndirect {
                ret_slot_local: off,
                ..
            }
            | Inst::CallExt {
                ret_slot_local: off,
                ..
            } => {
                reject.insert(off);
                continue;
            }
            _ => continue,
        };
        if off < 0 && !multi(off) {
            slots.insert(off);
        }
        if !ok {
            reject.insert(off);
        }
    }
    reject.extend(func.param_local_slots.iter().copied());
    reject.insert(func.indirect_result_slot);
    slots.retain(|s| !reject.contains(s));
    // A read whose kind turns: every reader takes the bits in the SIMD file.
    let load_use = |u: ValueId, v: ValueId, slots: &BTreeSet<i64>| match &func.insts[u as usize] {
        Inst::InlineAsm { asm, args } => args
            .iter()
            .enumerate()
            .all(|(i, &x)| x != v || simd8_input(asm, i)),
        inst => match slot_write(func, inst) {
            Some((off, value, _)) => value == v && slots.contains(&off),
            None => matches!(*inst, Inst::Store {
                addr,
                value,
                kind: StoreKind::I64 | StoreKind::F64,
                volatile: false,
                align,
                ..
            } if value == v && addr != v && natural(align) && unread(u)),
        },
    };
    let bits = |v: ValueId, slots: &BTreeSet<i64>| {
        !ends[v as usize] && by[v as usize].iter().all(|&u| load_use(u, v, slots))
    };
    let source = |value: ValueId, slots: &BTreeSet<i64>| {
        let inst = &func.insts[value as usize];
        match (slot_read(func, inst), inst) {
            (Some((s, kind)), _) => kind == LoadKind::F64 || slots.contains(&s),
            (
                _,
                Inst::Imm(_)
                | Inst::Load {
                    kind: LoadKind::F64,
                    ..
                },
            ) => true,
            (
                _,
                Inst::Load {
                    kind: LoadKind::I64,
                    align,
                    volatile: false,
                    ..
                },
            ) => natural(*align) && bits(value, slots),
            _ => false,
        }
    };
    loop {
        let mut drop: Vec<i64> = Vec::new();
        for (v, inst) in func.insts.iter().enumerate() {
            let v = v as ValueId;
            if let Some((off, LoadKind::I64)) = slot_read(func, inst)
                && slots.contains(&off)
                && !bits(v, &slots)
            {
                drop.push(off);
            }
            if let Some((off, value, StoreKind::I64)) = slot_write(func, inst)
                && slots.contains(&off)
                && !(unread(v) && source(value, &slots))
            {
                drop.push(off);
            }
        }
        if drop.is_empty() {
            break;
        }
        for s in drop {
            slots.remove(&s);
        }
    }
    // Objects one value passes between, or a copy joins, take part together.
    let mut parent: BTreeMap<i64, i64> = slots.iter().map(|&s| (s, s)).collect();
    let root = |p: &BTreeMap<i64, i64>, mut s: i64| {
        while p[&s] != s {
            s = p[&s];
        }
        s
    };
    let join = |p: &mut BTreeMap<i64, i64>, a: i64, b: i64| {
        let (ra, rb) = (root(p, a), root(p, b));
        p.insert(ra, rb);
    };
    let mut carrier: BTreeMap<ValueId, i64> = BTreeMap::new();
    let mut touched: Vec<i64> = Vec::new();
    for (v, inst) in func.insts.iter().enumerate() {
        let (value, off) = match (slot_read(func, inst), slot_write(func, inst), inst) {
            (Some((off, _)), ..) => (v as ValueId, off),
            (_, Some((off, value, _)), _) => (value, off),
            (.., Inst::Mcpy { dst, src, .. }) => {
                if let (Some(d), Some(s)) = (slot_at(func, *dst), slot_at(func, *src))
                    && slots.contains(&d)
                    && slots.contains(&s)
                {
                    join(&mut parent, d, s);
                }
                continue;
            }
            (.., Inst::InlineAsm { asm, args }) => {
                for (i, &a) in args.iter().enumerate() {
                    let met = match func.insts.get(a as usize) {
                        Some(Inst::LocalAddr(off)) if simd8_output(asm, i) => Some(*off),
                        Some(r) if simd8_input(asm, i) => slot_read(func, r).map(|(s, _)| s),
                        _ => None,
                    };
                    touched.extend(met.filter(|s| slots.contains(s)));
                }
                continue;
            }
            _ => continue,
        };
        if !slots.contains(&off) {
            continue;
        }
        // A vector part of the call boundary meets the object it passes
        // through: a parameter or result part stored there, or a read of
        // it that a return carries out.
        let part = match &func.insts[value as usize] {
            Inst::ParamPart { kind, .. } | Inst::RetPart { kind, .. } => *kind == LoadKind::F64,
            Inst::InlineAsm { asm, .. } => asm.operands.iter().any(|o| {
                o.value && o.is_output && o.width == 8 && o.constraint == AsmConstraint::Fp
            }),
            _ => by[value as usize]
                .iter()
                .any(|&u| matches!(func.insts[u as usize], Inst::AggParts { .. })),
        };
        if part {
            touched.push(off);
        }
        match carrier.get(&value) {
            Some(&s) => join(&mut parent, s, off),
            None => {
                carrier.insert(value, off);
            }
        }
    }
    let met: BTreeSet<i64> = touched.iter().map(|&s| root(&parent, s)).collect();
    slots.retain(|&s| met.contains(&root(&parent, s)));
    slots
}

/// The `I64` accesses of `slots`, the memory reads stored into them and
/// the memory writes of what they hold, as `F64`.
fn retype_cells(func: &mut FunctionSsa, slots: &BTreeSet<i64>) {
    let mut bits: BTreeSet<ValueId> = BTreeSet::new();
    for (v, inst) in func.insts.iter().enumerate() {
        if let Some((off, LoadKind::I64)) = slot_read(func, inst)
            && slots.contains(&off)
        {
            bits.insert(v as ValueId);
        }
        if let Some((off, value, _)) = slot_write(func, inst)
            && slots.contains(&off)
            && matches!(
                func.insts[value as usize],
                Inst::Load {
                    kind: LoadKind::I64,
                    ..
                }
            )
        {
            bits.insert(value);
        }
    }
    for (v, inst) in func.insts.iter_mut().enumerate() {
        match inst {
            Inst::LoadLocal { kind, .. } | Inst::Load { kind, .. }
                if bits.contains(&(v as ValueId)) =>
            {
                *kind = LoadKind::F64
            }
            Inst::StoreLocal { off, kind, .. } if slots.contains(off) => *kind = StoreKind::F64,
            Inst::Store { value, kind, .. } if bits.contains(value) => *kind = StoreKind::F64,
            _ => {}
        }
    }
}

//! Whole-object vector slots as values. A two-cell object accessed only
//! whole -- 16-byte copies and zero fills, `V128` loads and stores, 16-byte
//! SIMD asm operands -- becomes `V128` slot accesses for mem2reg to promote,
//! provided something reads it and it meets a SIMD operand or a vector ABI
//! piece directly or through whole copies. An asm output keeps its address
//! for `asm_outputs`, which makes it a value stored to the slot.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use super::super::abi_classify::ScalarKind;
use super::super::ir::{
    AsmConstraint, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId,
};
use super::tape::{At, Insertion, insert};

/// One rewritten access, by its tape index before the rewrite.
enum Edit {
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

pub(crate) fn run(func: &mut FunctionSsa) -> BTreeSet<i64> {
    if !applies(func) {
        return BTreeSet::new();
    }
    let slots = eligible(func, false);
    if !slots.is_empty() {
        rewrite(func, &slots);
    }
    slots
}

pub(crate) fn applies(func: &FunctionSsa) -> bool {
    !(func.is_naked || func.has_returns_twice_call || func.has_sp_asm())
}

/// [`run`]'s slots once `callee` is spliced: its aggregate parameters are
/// ordinary objects there, and a 16-byte vector return is read back whole.
pub(crate) fn spliced_slots(callee: &FunctionSsa) -> BTreeSet<i64> {
    eligible(callee, true)
}

fn slot_load(off: i64) -> Inst {
    Inst::LoadLocal {
        off,
        kind: LoadKind::V128,
        volatile: false,
    }
}

fn slot_store(off: i64, value: ValueId) -> Inst {
    Inst::StoreLocal {
        off,
        value,
        kind: StoreKind::V128,
        volatile: false,
        nsw: false,
    }
}

/// With `spliced`, see [`spliced_slots`].
fn eligible(func: &FunctionSsa, spliced: bool) -> BTreeSet<i64> {
    let mut slots: BTreeSet<i64> = func
        .multi_cell_slots
        .iter()
        .filter(|&&(_, cells)| cells == 2)
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
    let covering = |off: i64| [off, off - 1].into_iter().filter(|b| slots.contains(b));
    let mut reject: BTreeSet<i64> = BTreeSet::new();
    let mut addr: BTreeMap<ValueId, i64> = BTreeMap::new();
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
            Inst::LoadLocal {
                off,
                kind,
                volatile,
            } => {
                let whole = kind == LoadKind::V128 && !volatile;
                reject.extend(covering(off).filter(|&b| b != off || !whole));
                if whole && slots.contains(&off) {
                    reads.insert(off);
                    simd.insert(off);
                }
            }
            Inst::StoreLocal {
                off,
                kind,
                volatile,
                ..
            } => {
                let whole = kind == StoreKind::V128 && !volatile;
                reject.extend(covering(off).filter(|&b| b != off || !whole));
                if whole && slots.contains(&off) {
                    simd.insert(off);
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
            if let Some(&b) = addr.get(&a)
                && !(ok && covered[v])
            {
                reject.insert(b);
            }
        };
        match inst {
            Inst::Mcpy {
                dst,
                src,
                size,
                align,
            } => {
                let ok = *size == 16 && *align >= 16 && !used[v];
                check(*dst, ok, &mut reject);
                check(*src, ok, &mut reject);
                if let Some(&s) = addr.get(src) {
                    reads.insert(s);
                    if let Some(&d) = addr.get(dst) {
                        copies.push((d, s));
                    }
                }
            }
            Inst::Mzero { dst, size, .. } => check(*dst, *size == 16 && !used[v], &mut reject),
            Inst::Load {
                addr: a,
                disp,
                kind,
                volatile,
                ..
            } => {
                let ok = *disp == 0 && *kind == LoadKind::V128 && !*volatile;
                check(*a, ok, &mut reject);
                if let Some(&b) = addr.get(a) {
                    reads.insert(b);
                    simd.insert(b);
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
                let ok = *disp == 0 && *kind == StoreKind::V128 && !*volatile && a != value;
                check(*a, ok, &mut reject);
                check(*value, false, &mut reject);
                if let Some(&b) = addr.get(a) {
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
            _ => inst.for_each_operand(|a| check(a, false, &mut reject)),
        }
    }
    let vector_return = spliced
        && func.ret_agg.is_some_and(|i| {
            let d = &func.agg_descs[i as usize];
            d.size == 16 && d.fields.len() == 1 && matches!(d.fields[0].kind, ScalarKind::Vector)
        });
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

fn rewrite(func: &mut FunctionSsa, slots: &BTreeSet<i64>) {
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
    let mut edits: Vec<Edit> = Vec::new();
    for (v, inst) in func.insts.iter().enumerate() {
        let at = v as ValueId;
        match inst {
            Inst::LocalAddr(_) if addr.contains_key(&at) && !out_addrs.contains(&at) => {
                edits.push(Edit::Addr { at })
            }
            Inst::Load { addr: a, .. } => {
                if let Some(off) = slot_of(*a) {
                    edits.push(Edit::Load { at, off });
                }
            }
            Inst::Store { addr: a, .. } => {
                if let Some(off) = slot_of(*a) {
                    edits.push(Edit::Store { at, off });
                }
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
            })
        };
        match e {
            Edit::Copy { at, src, .. } => put(
                *at,
                match *src {
                    Side::Slot(off) => slot_load(off),
                    Side::Addr(a) => Inst::Load {
                        addr: a,
                        disp: 0,
                        kind: LoadKind::V128,
                        volatile: false,
                        align: 0,
                    },
                },
            ),
            Edit::Zero { at, .. } => put(*at, Inst::Imm(0)),
            Edit::Asm { at, inputs } => {
                for &(_, off) in inputs {
                    put(*at, slot_load(off));
                }
            }
            _ => {}
        }
    }
    let (rw, _) = insert(func, &ins);
    let mut next = 0usize;
    let mut take = || {
        next += 1;
        rw.ids[next - 1]
    };
    // A block accumulator naming a rewritten instruction loses that value.
    let mut gone: BTreeSet<ValueId> = BTreeSet::new();
    for e in &edits {
        match e {
            Edit::Addr { at } => {
                let n = rw.remap[*at as usize];
                func.insts[n as usize] = Inst::Imm(0);
                gone.insert(n);
            }
            Edit::Load { at, off } => func.insts[rw.remap[*at as usize] as usize] = slot_load(*off),
            Edit::Store { at, off } => {
                let n = rw.remap[*at as usize] as usize;
                if let Inst::Store { value, .. } = func.insts[n] {
                    func.insts[n] = slot_store(*off, value);
                }
            }
            Edit::Copy { at, dst, .. } => {
                let load = take();
                let n = rw.remap[*at as usize];
                func.insts[n as usize] = match *dst {
                    Side::Slot(off) => slot_store(off, load),
                    Side::Addr(a) => Inst::Store {
                        addr: rw.remap[a as usize],
                        disp: 0,
                        value: load,
                        kind: StoreKind::V128,
                        volatile: false,
                        align: 0,
                    },
                };
                gone.insert(n);
            }
            Edit::Zero { at, off } => {
                let zero = take();
                let n = rw.remap[*at as usize];
                func.insts[n as usize] = slot_store(*off, zero);
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

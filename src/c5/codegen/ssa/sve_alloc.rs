//! Placement of SVE values. A vector is an FP-file value of width
//! [`VecWidth::Scalable`], as z_n extends v_n; the wide-value rule keeps it
//! out of z8-z15 across a call, whose upper bits the base PCS does not
//! preserve (AAPCS64 6.1.2), and its slots move here into the VL-scaled
//! region. A predicate aliases no other file and is placed here by phi
//! class on p0-p6, p8-p13 and p15, p7 and p14 carrying the moves; one live
//! across a call takes a slot, as the base PCS preserves no P register. A
//! class that governs an instruction takes p0-p6, the 3-bit field's reach
//! less p7, which stages a governing predicate reloaded from its slot.

use alloc::collections::BTreeMap;
use alloc::vec::Vec;

use super::super::ir::{FunctionSsa, LoadKind, ValueId};
use super::reg_alloc::{CallSave, LoopSaveCode, Place, VecWidth};

/// The P registers values may take: all but [`PRED_STAGE`] and
/// [`PRED_HOLD`].
pub(crate) const PRED_REGS: u16 = 0xBF7F;
/// The P registers an operand that governs may take, p0-p6.
pub(crate) const PRED_GOVERNING: u16 = 0x007F;
/// The P register a parallel move parks a cycle's value in, or a result
/// bound for a slot is computed in; and the one a reload or a slot-to-slot
/// move passes through, which can govern.
pub(crate) const PRED_HOLD: u8 = 14;
pub(crate) const PRED_STAGE: u8 = 7;

/// Where an SVE predicate value lives: a register, or a slot of the
/// VL-scaled region.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum PredPlace {
    Reg(u8),
    Slot(u32),
}

/// The SVE side of an allocation: each predicate's place, and the vector
/// and predicate slots of the VL-scaled region.
#[derive(Clone, Debug, Default)]
pub(crate) struct SveAlloc {
    pub pred: BTreeMap<ValueId, PredPlace>,
    pub z_slots: u32,
    pub p_slots: u32,
}

impl SveAlloc {
    pub(crate) fn pred_place(&self, v: ValueId) -> Option<PredPlace> {
        self.pred.get(&v).copied()
    }
}

/// The value width of the result of intrinsic `kind`.
pub(crate) fn intrinsic_width(kind: i64) -> VecWidth {
    let result = crate::c5::op::Intrinsic::from_i64(kind).and_then(|i| i.sve_result());
    if result == Some(LoadKind::SveVector) {
        VecWidth::Scalable
    } else {
        VecWidth::Scalar
    }
}

/// The coloring's results [`place`] rewrites.
pub(crate) struct Colored<'a> {
    pub places: &'a mut [Place],
    pub call_saves: &'a mut [(ValueId, Vec<CallSave>)],
    pub loop_saves: &'a mut LoopSaveCode,
    pub spill_count: &'a mut u32,
}

/// What the placement reads of the coloring's analyses, per value: whether
/// a call lies in its class's live range, its class's width, and whether
/// its code is emitted.
pub(crate) struct Facts<'a> {
    pub interference: &'a super::liveness::Interference,
    pub classes: &'a mut super::phi_class::PhiClasses,
    pub crosses_call: &'a [bool],
    pub width: &'a dyn Fn(ValueId) -> VecWidth,
    pub emitted: &'a dyn Fn(ValueId) -> bool,
}

/// Place the predicates and move the vector slots of `func`.
pub(crate) fn place(func: &FunctionSsa, colored: Colored<'_>, facts: Facts<'_>) -> SveAlloc {
    let z_slots = vector_slots(colored, &facts);
    let preds: Vec<ValueId> = (0..func.insts.len() as ValueId)
        .filter(|&v| func.insts[v as usize].sve_kind() == Some(LoadKind::SvePredicate))
        .collect();
    if preds.is_empty() {
        return SveAlloc {
            z_slots,
            ..SveAlloc::default()
        };
    }
    let mut members: BTreeMap<ValueId, Vec<ValueId>> = BTreeMap::new();
    for &v in &preds {
        members.entry(facts.classes.find(v)).or_default().push(v);
    }
    let governs = governing_operands(func);
    let root_of: BTreeMap<ValueId, ValueId> = members
        .iter()
        .flat_map(|(&r, ms)| ms.iter().map(move |&m| (m, r)))
        .collect();
    let nodes: Vec<PredNode> = members
        .iter()
        .map(|(&root, ms)| {
            let mut near: Vec<ValueId> = ms
                .iter()
                .flat_map(|&m| facts.interference.neighbors(m))
                .filter_map(|nb| root_of.get(nb).copied())
                .filter(|&r| r != root)
                .collect();
            near.sort_unstable();
            near.dedup();
            let allowed = if ms.iter().any(|m| governs.contains(m)) {
                PRED_GOVERNING
            } else {
                PRED_REGS
            };
            PredNode {
                root,
                near,
                allowed,
                crosses_call: ms.iter().any(|&m| facts.crosses_call[m as usize]),
            }
        })
        .collect();
    let (by_root, p_slots) = color_predicates(&nodes);
    let pred = root_of
        .iter()
        .map(|(&v, root)| (v, by_root[root]))
        .collect();
    SveAlloc {
        pred,
        z_slots,
        p_slots,
    }
}

/// A predicate phi class to color: the roots of the classes it interferes
/// with, and the P registers it may take.
pub(crate) struct PredNode {
    pub root: ValueId,
    pub near: Vec<ValueId>,
    pub allowed: u16,
    pub crosses_call: bool,
}

/// The predicates that govern an SVE row or an SVE load or store.
fn governing_operands(func: &FunctionSsa) -> alloc::collections::BTreeSet<ValueId> {
    use crate::c5::ir::Inst;
    let governed = |inst: &Inst| match inst {
        Inst::SimdVal { op, args, .. } => match crate::c5::simd::get(*op).form {
            crate::c5::simd::Form::Sve(f) if f.shape.governed() => args.first().copied(),
            _ => None,
        },
        Inst::Intrinsic { kind, args } => crate::c5::op::Intrinsic::from_i64(*kind)
            .filter(|i| i.sve_lanes().is_some())
            .and_then(|_| args.first().copied()),
        _ => None,
    };
    func.insts.iter().filter_map(governed).collect()
}

/// A place per class root and the slots taken, the classes with the
/// fewest allowed registers first: the lowest allowed register no
/// interfering class holds, else the lowest such slot.
pub(crate) fn color_predicates(nodes: &[PredNode]) -> (BTreeMap<ValueId, PredPlace>, u32) {
    let mut out: BTreeMap<ValueId, PredPlace> = BTreeMap::new();
    let mut slots = 0u32;
    let mut order: Vec<&PredNode> = nodes.iter().collect();
    order.sort_by_key(|n| n.allowed.count_ones());
    for n in order {
        let held = n.near.iter().filter_map(|r| out.get(r));
        let regs = held.clone().fold(0u16, |m, p| match p {
            PredPlace::Reg(r) => m | 1 << r,
            PredPlace::Slot(_) => m,
        });
        let free = n.allowed & !regs;
        let place = if free != 0 && !n.crosses_call {
            PredPlace::Reg(free.trailing_zeros() as u8)
        } else {
            let taken: Vec<u32> = held
                .filter_map(|p| match p {
                    PredPlace::Slot(s) => Some(*s),
                    PredPlace::Reg(_) => None,
                })
                .collect();
            let s = (0..).find(|s| !taken.contains(s)).unwrap_or(0);
            slots = slots.max(s + 1);
            PredPlace::Slot(s)
        };
        out.insert(n.root, place);
    }
    (out, slots)
}

/// Move the coloring's vector slots into the VL-scaled region and close up
/// the 8-byte slots the rest hold in order; the vector slot count.
fn vector_slots(c: Colored<'_>, facts: &Facts<'_>) -> u32 {
    let scalable = |w: VecWidth| w == VecWidth::Scalable;
    let mut vector: Vec<u32> = Vec::new();
    for (v, p) in c.places.iter().enumerate() {
        if let Place::Spill(s) = p
            && scalable((facts.width)(v as ValueId))
        {
            vector.push(*s);
        }
    }
    let all_saves = || {
        (c.call_saves.iter().flat_map(|(_, s)| s.iter()))
            .chain(c.loop_saves.stores.iter().flat_map(|(_, s)| s.iter()))
            .chain(
                c.loop_saves
                    .loads_at_start
                    .iter()
                    .flat_map(|(_, s)| s.iter()),
            )
            .chain(c.loop_saves.loads_at_end.iter().flat_map(|(_, s)| s.iter()))
    };
    vector.extend(all_saves().filter(|s| scalable(s.wide)).map(|s| s.slot));
    if vector.is_empty() {
        return 0;
    }
    vector.sort_unstable();
    vector.dedup();
    // The units the rest hold, ranked: a slot's units stay adjacent.
    let mut used = alloc::vec![false; *c.spill_count as usize];
    let mut mark = |s: u32, w: VecWidth| {
        for u in s..s + w.units() {
            if let Some(x) = used.get_mut(u as usize) {
                *x = true;
            }
        }
    };
    for (v, p) in c.places.iter().enumerate() {
        let w = (facts.width)(v as ValueId);
        if let Place::Spill(s) = p
            && !scalable(w)
            && (facts.emitted)(v as ValueId)
        {
            mark(*s, w);
        }
    }
    for s in all_saves().filter(|s| !scalable(s.wide)) {
        mark(s.slot, s.wide);
    }
    let mut rank = alloc::vec![u32::MAX; used.len()];
    let mut next = 0u32;
    for (u, &x) in used.iter().enumerate() {
        if x {
            rank[u] = next;
            next += 1;
        }
    }
    let renumber = |s: u32, w: VecWidth| -> u32 {
        if scalable(w) {
            vector.binary_search(&s).map_or(s, |k| k as u32)
        } else {
            rank.get(s as usize)
                .copied()
                .filter(|&r| r != u32::MAX)
                .unwrap_or(s)
        }
    };
    for (v, p) in c.places.iter_mut().enumerate() {
        if let Place::Spill(s) = p {
            *s = renumber(*s, (facts.width)(v as ValueId));
        }
    }
    let lists = (c.call_saves.iter_mut().map(|(_, s)| s))
        .chain(c.loop_saves.stores.iter_mut().map(|(_, s)| s))
        .chain(c.loop_saves.loads_at_start.iter_mut().map(|(_, s)| s))
        .chain(c.loop_saves.loads_at_end.iter_mut().map(|(_, s)| s));
    for save in lists.flatten() {
        save.slot = renumber(save.slot, save.wide);
    }
    *c.spill_count = next;
    vector.len() as u32
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::codegen::ssa::build::SsaBuilder;
    use crate::c5::codegen::{CallConv, FixedRegs, Target};
    use crate::c5::ir::{FpMask, Inst};
    use crate::c5::op::Intrinsic as I;

    /// `n` vectors, or predicates, loaded, a call, and each stored back.
    fn loads_then_stores(n: usize, call: bool, preds: bool) -> FunctionSsa {
        let mut b = SsaBuilder::new(0, 1, false);
        let p = b.param_ref(0, LoadKind::I64);
        let (load, store) = if preds {
            (I::SveLoadP, I::SveStoreP)
        } else {
            (I::SveLoadZ, I::SveStoreZ)
        };
        let values: Vec<ValueId> = (0..n)
            .map(|_| b.intrinsic(load as i64, alloc::vec![p]))
            .collect();
        if call {
            b.call(0, Vec::new(), 0, false, FpMask::default(), CallConv::Target);
        }
        for v in values {
            b.intrinsic(store as i64, alloc::vec![p, v]);
        }
        let z = b.imm(0);
        b.return_(z);
        b.finish()
    }

    fn allocate(func: &FunctionSsa) -> super::super::reg_alloc::Allocation {
        super::super::reg_alloc::allocate(func, Target::LinuxAarch64, FixedRegs::NONE)
    }

    fn loaded(func: &FunctionSsa, kind: I) -> Vec<ValueId> {
        (0..func.insts.len() as ValueId)
            .filter(|&v| matches!(&func.insts[v as usize], Inst::Intrinsic { kind: k, .. } if *k == kind as i64))
            .collect()
    }

    /// Forty vectors outnumber the FP registers; the rest take vector slots
    /// and leave no 8-byte slot behind.
    #[test]
    fn vectors_past_the_fp_bank_take_vl_slots() {
        let func = loads_then_stores(40, false, false);
        let alloc = allocate(&func);
        let mut slots: Vec<u32> = Vec::new();
        for v in loaded(&func, I::SveLoadZ) {
            match alloc.places[v as usize] {
                Place::FpReg(_) => {}
                Place::Spill(k) => slots.push(k),
                p => panic!("v{v} placed at {p:?}"),
            }
        }
        slots.sort_unstable();
        assert!(!slots.is_empty(), "every vector took a register");
        assert_eq!(slots, (0..slots.len() as u32).collect::<Vec<_>>());
        assert_eq!(alloc.sve.z_slots, slots.len() as u32);
        assert_eq!(alloc.spill_count, 0, "8-byte slots: {}", alloc.spill_count);
    }

    /// A vector live across a call takes no register z8-z15; it is saved
    /// around the call or takes a vector slot.
    #[test]
    fn a_vector_across_a_call_takes_no_callee_saved_register() {
        let func = loads_then_stores(4, true, false);
        let alloc = allocate(&func);
        for v in loaded(&func, I::SveLoadZ) {
            match alloc.places[v as usize] {
                Place::FpReg(r) => {
                    assert!(!(8..=15).contains(&r), "v{v} in z{r}");
                    let saved = alloc.call_saves.iter().flat_map(|(_, s)| s);
                    let save = saved.into_iter().find(|s| s.reg == r).expect("saved");
                    assert_eq!(save.wide, VecWidth::Scalable);
                    assert!(save.slot < alloc.sve.z_slots);
                }
                Place::Spill(k) => assert!(k < alloc.sve.z_slots),
                p => panic!("v{v} placed at {p:?}"),
            }
        }
    }

    /// Predicates live across a call take slots, not the coloring's places.
    #[test]
    fn predicates_across_a_call_take_slots() {
        let func = loads_then_stores(3, true, true);
        let alloc = allocate(&func);
        let mut slots: Vec<u32> = Vec::new();
        for v in loaded(&func, I::SveLoadP) {
            assert_eq!(alloc.places[v as usize], Place::None);
            match alloc.sve.pred_place(v) {
                Some(PredPlace::Slot(s)) => slots.push(s),
                p => panic!("v{v} placed at {p:?}"),
            }
        }
        slots.sort_unstable();
        assert_eq!(slots, [0, 1, 2]);
        assert_eq!(alloc.sve.p_slots, 3);
        let func = loads_then_stores(3, false, true);
        let alloc = allocate(&func);
        let regs: Vec<_> = loaded(&func, I::SveLoadP)
            .iter()
            .map(|&v| alloc.sve.pred_place(v))
            .collect();
        assert_eq!(regs, [0, 1, 2].map(|r| Some(PredPlace::Reg(r))));
    }

    fn node(root: ValueId, near: &[ValueId], allowed: u16, crosses_call: bool) -> PredNode {
        PredNode {
            root,
            near: near.to_vec(),
            allowed,
            crosses_call,
        }
    }

    /// `n` mutually interfering classes, the first `governing` of them
    /// governing.
    fn clique(n: u32, governing: u32) -> Vec<PredNode> {
        let all: Vec<ValueId> = (0..n).collect();
        (0..n)
            .map(|r| {
                let near: Vec<ValueId> = all.iter().copied().filter(|&x| x != r).collect();
                let allowed = if r < governing {
                    PRED_GOVERNING
                } else {
                    PRED_REGS
                };
                node(r, &near, allowed, false)
            })
            .collect()
    }

    /// Interfering classes take the lowest free registers, the governing
    /// ones first and within p0-p6; one live across a call takes a slot, as
    /// does a governing one once p0-p6 are held.
    #[test]
    fn predicates_take_registers_apart_and_slots_across_calls() {
        let mut nodes = clique(9, 1);
        nodes.push(node(9, &[], PRED_REGS, true));
        let (places, slots) = color_predicates(&nodes);
        let regs: Vec<PredPlace> = (0..9).map(|r| places[&r]).collect();
        assert_eq!(regs, [0, 1, 2, 3, 4, 5, 6, 8, 9].map(PredPlace::Reg));
        assert_eq!((places[&9], slots), (PredPlace::Slot(0), 1));
        let (places, slots) = color_predicates(&clique(9, 8));
        assert_eq!(places[&6], PredPlace::Reg(6));
        assert_eq!(
            (places[&7], places[&8]),
            (PredPlace::Slot(0), PredPlace::Reg(8))
        );
        assert_eq!(slots, 1);
    }

    /// Fourteen interfering classes fill p0-p6, p8-p13 and p15; the
    /// fifteenth takes a slot.
    #[test]
    fn predicates_past_the_bank_take_slots() {
        let (places, slots) = color_predicates(&clique(15, 0));
        assert_eq!(places[&6], PredPlace::Reg(6));
        assert_eq!(places[&7], PredPlace::Reg(8));
        assert_eq!(places[&13], PredPlace::Reg(15));
        assert_eq!((places[&14], slots), (PredPlace::Slot(0), 1));
    }
}

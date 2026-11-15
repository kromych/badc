//! SVE values in registers: whole Z and P transfers, the predicate moves of
//! a phi edge, and the VL-scaled region holding their slots. The region lies
//! below the static frame, reserved with `addvl`: the predicate slots, eight
//! to a vector length, then the vector slots, each at `[base, #-k, mul vl]`
//! from the static frame's bottom (`fp - frame_bytes`, or x19).

use super::super::ssa::sve_alloc::{PRED_HOLD, PRED_STAGE, PredPlace};
use super::*;

/// `ldr` / `str` of a whole Z (`vector`) or P register at
/// `[n, #imm, mul vl]`.
pub(super) fn enc_sve_mem(load: bool, vector: bool, t: u8, n: Reg, imm: i32) -> u32 {
    let base = match (load, vector) {
        (true, true) => 0x8580_4000,
        (false, true) => 0xE580_4000,
        (true, false) => 0x8580_0000,
        (false, false) => 0xE580_0000,
    };
    let imm = (imm as u32) & 0x1FF;
    base | (imm >> 3) << 16 | (imm & 7) << 10 | u32::from(n.0) << 5 | u32::from(t)
}

/// `mov zd.d, zn.d`, the unpredicated ORR of `zn` with itself.
pub(super) fn enc_mov_z(d: u8, n: u8) -> u32 {
    0x0460_3000 | u32::from(n) << 16 | u32::from(n) << 5 | u32::from(d)
}

/// `mov pd.b, pn.b`, the ORR of `pn` with itself under `pn`.
pub(super) fn enc_mov_p(d: u8, n: u8) -> u32 {
    let n = u32::from(n);
    0x2580_4000 | n << 16 | n << 10 | n << 5 | u32::from(d)
}

/// `addvl xd|sp, xn|sp, #imm`.
fn enc_addvl(d: Reg, n: Reg, imm: i32) -> u32 {
    0x0420_5000 | u32::from(n.0) << 16 | ((imm as u32) & 0x3F) << 5 | u32::from(d.0)
}

/// Reserve the VL-scaled region in steps of at most 3840 bytes (15 vector
/// lengths of 2048 bits), each probed when the region can pass the margin.
pub(super) fn emit_vl_region(code: &mut Vec<u8>, frame: Frame) {
    let mut left = frame.sve_region_vls();
    let probe = left * MAX_VL_BYTES > MAX_UNPROBED_STACK_STEP;
    while left > 0 {
        let step = left.min(MAX_UNPROBED_STACK_STEP / MAX_VL_BYTES);
        emit(code, enc_addvl(Reg::SP, Reg::SP, -(step as i32)));
        if probe {
            emit_stack_probe(code);
        }
        left -= step;
    }
}

const MAX_VL_BYTES: u32 = 256;

/// The region's base: x19 where it holds it, else `t`.
fn region_base(code: &mut Vec<u8>, frame: Frame, t: Reg) -> Reg {
    if frame.local_base {
        return Reg(19);
    }
    emit_fp_minus_off(code, t, frame.frame_bytes);
    t
}

/// Load or store Z register `z` at vector slot `slot`; `t` takes the base.
pub(super) fn z_slot(code: &mut Vec<u8>, frame: Frame, load: bool, z: u8, slot: u32, t: Reg) {
    let lengths = frame.sve_p_slots.div_ceil(8) + slot + 1;
    let (base, imm) = slot_base(code, frame, t, true, lengths);
    emit(code, enc_sve_mem(load, true, z, base, imm));
}

/// [`z_slot`] for P register `p` and predicate slot `slot`.
pub(super) fn p_slot(code: &mut Vec<u8>, frame: Frame, load: bool, p: u8, slot: u32, t: Reg) {
    let (base, imm) = slot_base(code, frame, t, false, slot + 1);
    emit(code, enc_sve_mem(load, false, p, base, imm));
}

/// The base and offset of the slot `lengths` vector (or predicate) lengths
/// below the region's base: past the 9-bit offset's reach, `t` steps down
/// 32 lengths at a time with `addvl` (`addpl`).
fn slot_base(code: &mut Vec<u8>, frame: Frame, t: Reg, vector: bool, lengths: u32) -> (Reg, i32) {
    let mut base = region_base(code, frame, t);
    let mut left = lengths;
    while left > 256 {
        let step = (left - 256).min(32);
        // ADDPL differs from ADDVL in bit 22.
        let pl = if vector { 0 } else { 0x0040_0000 };
        emit(code, enc_addvl(t, base, -(step as i32)) | pl);
        (base, left) = (t, left - step);
    }
    (base, -(left as i32))
}

/// An SVE vector's copy between FP-file places; x16 takes the base.
pub(super) fn emit_z_copy(code: &mut Vec<u8>, src: Place, dst: Place, frame: Frame) -> Emit {
    match (src, dst) {
        (Place::FpReg(s), Place::FpReg(d)) if s == d => {}
        (Place::FpReg(s), Place::FpReg(d)) => emit(code, enc_mov_z(d, s)),
        (Place::FpReg(s), Place::Spill(k)) => z_slot(code, frame, false, s, k, Reg(16)),
        (Place::Spill(k), Place::FpReg(d)) => z_slot(code, frame, true, d, k, Reg(16)),
        (Place::Spill(j), Place::Spill(k)) => {
            let z = frame.fp_scratch[0];
            z_slot(code, frame, true, z, j, Reg(16));
            z_slot(code, frame, false, z, k, Reg(16));
        }
        _ => return fail("SVE vector copy: place not of the FP file"),
    }
    Ok(())
}

/// An SVE load or store at `args[0]`. A spilled vector passes through the
/// FP scratch register's Z view, a spilled predicate through p15.
pub(super) fn emit_sve_access(
    code: &mut CodeBuf,
    intrinsic: crate::c5::op::Intrinsic,
    (args, v, dst): (&[u32], u32, Place),
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    use crate::c5::op::Intrinsic as I;
    let Some(&addr) = args.first() else {
        return fail("SVE access: no address");
    };
    let Some(a) = materialize_int(code, place_of(alloc, addr), scratch.primary, frame) else {
        return fail("SVE access: address not int reg / spill");
    };
    let t = scratch.secondary;
    let z = frame.fp_scratch[0];
    let pred = |w: u32| alloc.sve.pred_place(w);
    match (intrinsic, args.get(1).copied()) {
        (I::SveLoadZ, None) => {
            let r = match dst {
                Place::FpReg(r) => r,
                Place::Spill(_) => z,
                _ => return fail("SveLoadZ: dst not fp reg / spill"),
            };
            emit(code, enc_sve_mem(true, true, r, a, 0));
            if let Place::Spill(k) = dst {
                z_slot(code, frame, false, r, k, t);
            }
        }
        (I::SveStoreZ, Some(value)) => {
            let r = match place_of(alloc, value) {
                Place::FpReg(r) => r,
                Place::Spill(k) => {
                    z_slot(code, frame, true, z, k, t);
                    z
                }
                _ => return fail("SveStoreZ: value not fp reg / spill"),
            };
            emit(code, enc_sve_mem(false, true, r, a, 0));
        }
        (I::SveLoadP, None) => {
            let p = match pred(v) {
                Some(PredPlace::Reg(r)) => r,
                Some(PredPlace::Slot(_)) => PRED_STAGE,
                None => return fail("SveLoadP: no predicate place"),
            };
            emit(code, enc_sve_mem(true, false, p, a, 0));
            if let Some(PredPlace::Slot(j)) = pred(v) {
                p_slot(code, frame, false, p, j, t);
            }
        }
        (I::SveStoreP, Some(value)) => {
            let p = match pred(value) {
                Some(PredPlace::Reg(r)) => r,
                Some(PredPlace::Slot(j)) => {
                    p_slot(code, frame, true, PRED_STAGE, j, t);
                    PRED_STAGE
                }
                None => return fail("SveStoreP: value has no predicate place"),
            };
            emit(code, enc_sve_mem(false, false, p, a, 0));
        }
        _ => return fail("SVE access: operands"),
    }
    Ok(())
}

/// Sequentialize a phi edge's parallel predicate moves: a move whose target
/// no other move reads goes first; a cycle parks one source in p14.
pub(super) fn schedule_pred_moves(
    code: &mut Vec<u8>,
    frame: Frame,
    moves: &mut Vec<(PredPlace, PredPlace)>,
) {
    moves.retain(|(s, t)| s != t);
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            if moves.iter().any(|&(o, _)| o == t) {
                i += 1;
                continue;
            }
            pred_move(code, frame, s, t);
            moves.swap_remove(i);
            progress = true;
        }
        if !progress {
            let (cyc, hold) = (moves[0].0, PredPlace::Reg(PRED_HOLD));
            pred_move(code, frame, cyc, hold);
            for m in moves.iter_mut().filter(|m| m.0 == cyc) {
                m.0 = hold;
            }
        }
    }
}

pub(super) fn pred_move(code: &mut Vec<u8>, frame: Frame, src: PredPlace, dst: PredPlace) {
    let t = Reg(16);
    match (src, dst) {
        _ if src == dst => {}
        (PredPlace::Reg(s), PredPlace::Reg(d)) => emit(code, enc_mov_p(d, s)),
        (PredPlace::Reg(s), PredPlace::Slot(j)) => p_slot(code, frame, false, s, j, t),
        (PredPlace::Slot(j), PredPlace::Reg(d)) => p_slot(code, frame, true, d, j, t),
        (PredPlace::Slot(i), PredPlace::Slot(j)) => {
            p_slot(code, frame, true, PRED_STAGE, i, t);
            p_slot(code, frame, false, PRED_STAGE, j, t);
        }
    }
}

/// The VL-scaled region's slots: the allocator's, then those of the
/// registers an SVE-PCS function preserves, then the copies of the
/// arguments its calls pass by reference.
#[derive(Debug, Clone, Copy, Default)]
pub(crate) struct SveFrame {
    pub z_spill: u32,
    pub p_spill: u32,
    /// Bit n set: the function saves z_n, or p_n.
    pub saved_z: u32,
    pub saved_p: u16,
    pub out_z: u32,
    pub out_p: u32,
}

impl SveFrame {
    pub(crate) fn z_slots(&self) -> u32 {
        self.z_spill + self.saved_z.count_ones() + self.out_z
    }

    pub(crate) fn p_slots(&self) -> u32 {
        self.p_spill + self.saved_p.count_ones() + self.out_p
    }

    /// The slot of the `k`-th copy of a vector argument, or of a predicate
    /// one when `pred`.
    pub(crate) fn out_slot(&self, pred: bool, k: u32) -> u32 {
        if pred {
            self.p_spill + self.saved_p.count_ones() + k
        } else {
            self.z_spill + self.saved_z.count_ones() + k
        }
    }
}

/// `alloc` for SVE-PCS `func`: without the base standard's saves of
/// d8-d15, as the function saves z8-z15 whole; and, where it reaches no
/// code of another standard, with each FP scratch register, those the body
/// writes first, moved to a register of z24-z31 no value holds, which the
/// SVE PCS leaves volatile.
pub(super) fn sve_pcs_allocation(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    fixed: super::FixedRegs,
) -> Allocation {
    use super::ssa::reg_alloc::NO_FP_SCRATCH;
    let mut a = alloc.clone();
    a.fp_used.clear();
    if reaches_other_pcs(func, target) {
        return a;
    }
    let held = (alloc.places.iter()).fold(0u32, |m, p| match p {
        Place::FpReg(r) => m | 1 << r,
        _ => m,
    });
    let free = (24..32u8).filter(|&r| held >> r & 1 == 0 && !fixed.has_fpr(r));
    let writes = scratch_writes(func, &a, target).0;
    let mut order: Vec<usize> = (0..a.fp_scratch.len())
        .filter(|&k| a.fp_scratch[k] != NO_FP_SCRATCH)
        .collect();
    order.sort_by_key(|&k| !writes[k]);
    for (k, r) in order.into_iter().zip(free) {
        a.fp_scratch[k] = r;
    }
    a
}

/// The z registers, z8-z23, and p registers, p4-p15, the SVE PCS has a
/// function preserve whole (AAPCS64 6.1.3, 6.1.4).
const SVE_PCS_Z: u32 = 0x00FF_FF00;
const SVE_PCS_P: u16 = 0xFFF0;

/// Whether parameter `i` of `func` is an SVE value.
pub(super) fn sve_param(func: &FunctionSsa, i: usize) -> bool {
    (func.sve_pcs.as_ref()).is_some_and(|k| k.get(i).copied().flatten().is_some())
}

/// Whether `func` reaches code another procedure call standard governs: a
/// call, inline asm, or a TLS descriptor call. The base PCS preserves only
/// the low 64 bits of z8-z15 and no p register.
fn reaches_other_pcs(func: &FunctionSsa, target: Target) -> bool {
    func.insts.iter().any(|i| match i {
        Inst::Call { .. }
        | Inst::CallIndirect { .. }
        | Inst::CallExt { .. }
        | Inst::TailExt(_)
        | Inst::InlineAsm { .. } => true,
        Inst::TlsAddr(_) => super::ssa::reg_alloc::tls_addr_is_call(target, func),
        _ => false,
    })
}

/// The z and p registers the prologue of SVE-PCS `func` saves: all it must
/// preserve when it reaches code under another standard, else those its
/// values and the population count take, and the scratch the emitter
/// writes for it ([`scratch_writes`]).
fn preserved(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    count: Option<u8>,
) -> (u32, u16) {
    if func.sve_pcs.is_none() {
        return (0, 0);
    }
    if reaches_other_pcs(func, target) {
        return (SVE_PCS_Z, SVE_PCS_P);
    }
    let mut z = count.map_or(0, |r| 1u32 << r);
    for p in &alloc.places {
        if let Place::FpReg(r) = p {
            z |= 1 << r;
        }
    }
    let (fp, cycles) = scratch_writes(func, alloc, target);
    for (k, &r) in alloc.fp_scratch.iter().enumerate() {
        if fp[k] {
            z |= 1 << r;
        }
    }
    let mut p = 0u16;
    for place in alloc.sve.pred.values() {
        if let PredPlace::Reg(r) = place {
            p |= 1 << r;
        }
    }
    // A slot's predicate reloads into p7, or p15 or p14 as a row's second
    // or third operand, and a result bound for one is computed in p14.
    if alloc.sve.p_slots > 0 {
        p |= 1 << PRED_STAGE | 1 << PRED_HOLD;
    }
    if super::sve_rows::reloads_second_predicate(func, alloc) {
        p |= 1 << super::super::ssa::sve_alloc::PRED_OPERAND;
    }
    if cycles.1 {
        p |= 1 << PRED_HOLD;
    }
    (z & SVE_PCS_Z, p & SVE_PCS_P)
}

/// The FP scratch registers the emitter may write in `func`, and whether a
/// parallel move of vectors, or of predicates, has a cycle, which a hold
/// register breaks. A body of SVE values alone writes the FP scratch only
/// to stage a spilled vector, break such a cycle or where an SVE row needs
/// it ([`scratch_writes`](super::sve_rows::scratch_writes)); any other FP
/// work takes
/// [`fp_scratch_demand`](super::ssa::reg_alloc::fp_scratch_demand).
fn scratch_writes(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
) -> ([bool; 3], (bool, bool)) {
    use super::ssa::reg_alloc::produces_fp_result;
    let fp = |v: u32| match alloc.places.get(v as usize) {
        Some(Place::FpReg(r)) => Some(*r),
        _ => None,
    };
    let pred = |v: u32| match alloc.sve.pred_place(v) {
        Some(PredPlace::Reg(r)) => Some(r),
        _ => None,
    };
    let (mut z, mut p) = (false, false);
    // Each phi edge, each call's register arguments, the parameters' entry.
    for (b, blk) in func.blocks.iter().enumerate() {
        let term = &blk.terminator;
        let succs =
            super::ssa::mem2reg::successors(term, &func.computed_goto_targets, &func.jump_tables);
        for s in succs {
            let phis = func.blocks[s as usize].inst_range.clone();
            let incoming = |v: u32| match &func.insts[v as usize] {
                Inst::Phi { incoming, .. } => incoming
                    .iter()
                    .find(|(f, _)| *f as usize == b)
                    .map(|&(_, x)| (x, v)),
                _ => None,
            };
            let edge: Vec<(u32, u32)> = phis.filter_map(incoming).collect();
            z |= cyclic(edge.iter().filter_map(|&(x, v)| Some((fp(x)?, fp(v)?))));
            p |= cyclic(edge.iter().filter_map(|&(x, v)| Some((pred(x)?, pred(v)?))));
        }
    }
    for inst in &func.insts {
        if let Inst::Call {
            args,
            fp_arg_mask,
            arg_aggs,
            arg_widths,
            ..
        }
        | Inst::CallIndirect {
            args,
            fp_arg_mask,
            arg_aggs,
            arg_widths,
            ..
        }
        | Inst::CallExt {
            args,
            fp_arg_mask,
            arg_aggs,
            arg_widths,
            ..
        } = inst
        {
            let abi = target.abi_for(inst.call_conv().unwrap_or_default());
            let aggs = super::ssa::emit_common::build_call_aggs(func, args, arg_aggs, abi);
            let n = args.len();
            let plan =
                super::plan_call_args_aggs(n, n, fp_arg_mask, abi, &aggs, false, *arg_widths);
            let plan = plan.placements;
            z |= cyclic(args.iter().zip(&plan).filter_map(|(&a, pl)| match pl {
                super::ArgPlacement::FpReg(r) => Some((fp(a)?, *r)),
                _ => None,
            }));
            p |= cyclic(args.iter().zip(&plan).filter_map(|(&a, pl)| match pl {
                super::ArgPlacement::PredReg(r) => Some((pred(a)?, *r)),
                _ => None,
            }));
        }
    }
    let params = super::ssa::emit_common::param_placements_common(func, target.abi_for(func.conv));
    let incoming = |v: usize| match &func.insts[v] {
        Inst::ParamRef { idx, .. } => params.get(*idx as usize).copied(),
        _ => None,
    };
    let entry = (0..func.insts.len()).filter_map(|v| Some((v as u32, incoming(v)?)));
    z |= cyclic(entry.clone().filter_map(|(v, pl)| match pl {
        super::ArgPlacement::FpReg(n) => Some((n, fp(v)?)),
        _ => None,
    }));
    p |= cyclic(entry.filter_map(|(v, pl)| match pl {
        super::ArgPlacement::PredReg(n) => Some((n, pred(v)?)),
        _ => None,
    }));
    let scalar = (func.insts.iter().enumerate()).any(|(v, i)| {
        (produces_fp_result(i) && func.value_sve_kind(v as u32).is_none())
            || matches!(i, Inst::Simd { .. })
    });
    if scalar {
        return (
            super::ssa::reg_alloc::fp_scratch_demand(func, target),
            (z, p),
        );
    }
    let rows = super::sve_rows::scratch_writes(func, alloc);
    let staged = alloc.sve.z_slots > 0 || z;
    ([staged || rows[0], staged || rows[1], false], (z, p))
}

/// Whether the register moves `(source, target)` form a cycle.
fn cyclic(moves: impl Iterator<Item = (u8, u8)>) -> bool {
    let into: alloc::collections::BTreeMap<u8, u8> =
        moves.filter(|(s, t)| s != t).map(|(s, t)| (t, s)).collect();
    into.keys().any(|&start| {
        let mut at = start;
        for _ in 0..into.len() {
            match into.get(&at) {
                Some(&s) if s == start => return true,
                Some(&s) => at = s,
                None => return false,
            }
        }
        false
    })
}

/// The SVE argument copies one call makes: those of its vector and
/// predicate arguments the plan passes by reference.
pub(super) fn arg_copies(func: &FunctionSsa, plan: &super::CallPlan, args: &[u32]) -> (u32, u32) {
    let mut n = (0, 0);
    for (p, &a) in plan.placements.iter().zip(args) {
        let by_ref = matches!(
            p,
            super::ArgPlacement::IntReg(_) | super::ArgPlacement::Stack(_)
        );
        match func.value_sve_kind(a) {
            Some(LoadKind::SveVector) if by_ref => n.0 += 1,
            Some(LoadKind::SvePredicate) if by_ref => n.1 += 1,
            _ => {}
        }
    }
    n
}

/// The region of `func`: the allocator's slots, the saves and `copies`.
pub(super) fn sve_frame(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    count: Option<u8>,
    copies: (u32, u32),
) -> SveFrame {
    let (saved_z, saved_p) = preserved(func, alloc, target, count);
    SveFrame {
        z_spill: alloc.sve.z_slots,
        p_spill: alloc.sve.p_slots,
        saved_z,
        saved_p,
        out_z: copies.0,
        out_p: copies.1,
    }
}

/// Store (`store`) or reload the registers the SVE PCS has the function
/// preserve; x16 takes the base.
pub(super) fn emit_pcs_saves(code: &mut Vec<u8>, frame: Frame, store: bool) {
    let s = frame.sve;
    if s.saved_z == 0 && s.saved_p == 0 {
        return;
    }
    let z = (0..32u8).filter(|r| s.saved_z >> r & 1 != 0).map(|r| {
        let slot = s.z_spill + (s.saved_z & ((1 << r) - 1)).count_ones();
        (true, r, frame.sve_p_slots.div_ceil(8) + slot + 1)
    });
    let p = (0..16u8).filter(|r| s.saved_p >> r & 1 != 0).map(|r| {
        let slot = s.p_spill + (u32::from(s.saved_p) & ((1 << r) - 1)).count_ones();
        (false, r, slot + 1)
    });
    // One base serves every save within the 9-bit offset's reach.
    let base = region_base(code, frame, Reg(16));
    for (vector, r, lengths) in z.chain(p) {
        if lengths <= 256 {
            emit(
                code,
                enc_sve_mem(!store, vector, r, base, -(lengths as i32)),
            );
        } else if vector {
            z_slot(
                code,
                frame,
                !store,
                r,
                lengths - frame.sve_p_slots.div_ceil(8) - 1,
                Reg(17),
            );
        } else {
            p_slot(code, frame, !store, r, lengths - 1, Reg(17));
        }
    }
}

/// `dst` = the address of vector (or predicate) slot `slot`.
pub(super) fn slot_address(code: &mut Vec<u8>, frame: Frame, vector: bool, slot: u32, dst: Reg) {
    let lengths = if vector {
        frame.sve_p_slots.div_ceil(8) + slot + 1
    } else {
        slot + 1
    };
    let (base, imm) = slot_base(code, frame, dst, vector, lengths);
    let mut left = -imm;
    let mut base = base;
    // ADDPL differs from ADDVL in bit 22.
    let pl = if vector { 0 } else { 0x0040_0000 };
    loop {
        let step = left.min(32);
        emit(code, enc_addvl(dst, base, -step) | pl);
        (base, left) = (dst, left - step);
        if left == 0 {
            break;
        }
    }
}

/// An SVE parameter's or call result's register into the value's place:
/// z_n or p_n of the plan, or z0 / p0 of a call.
pub(super) fn emit_incoming(
    code: &mut Vec<u8>,
    inst: &Inst,
    (v, dst): (u32, Place),
    alloc: &Allocation,
    frame: Frame,
    param_plan: &[super::ArgPlacement],
) -> Emit {
    use super::ArgPlacement as P;
    let (kind, src) = match inst {
        Inst::ParamRef { idx, kind } => match (kind, param_plan.get(*idx as usize)) {
            (LoadKind::SveVector, Some(P::FpReg(n)))
            | (LoadKind::SvePredicate, Some(P::PredReg(n))) => (*kind, *n),
            _ => return fail("SVE parameter: no incoming register"),
        },
        Inst::RetPart { kind, slot: 0 } => (*kind, 0),
        _ => return fail("SVE incoming: not a parameter or result"),
    };
    // An unread value has no place.
    if kind == LoadKind::SvePredicate {
        if let Some(to) = alloc.sve.pred_place(v) {
            pred_move(code, frame, PredPlace::Reg(src), to);
        }
        return Ok(());
    }
    if dst == Place::None {
        return Ok(());
    }
    emit_z_copy(code, Place::FpReg(src), dst, frame)
}

/// Move the predicate parameters opening the entry block from p0-p3 into
/// their places as one parallel copy; the ids it placed, or left unread,
/// which emit nothing, as the coloring of the P file gives an unread value
/// a register another holds.
pub(super) fn place_pred_params(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    param_plan: &[super::ArgPlacement],
) -> Emit<Vec<usize>> {
    let mut moves = Vec::new();
    let mut placed = Vec::new();
    for vid in super::ssa::emit_common::entry_read_run(func, &alloc.use_counts) {
        let Inst::ParamRef {
            idx,
            kind: LoadKind::SvePredicate,
        } = func.insts[vid]
        else {
            continue;
        };
        placed.push(vid);
        if alloc.use_counts.get(vid) == Some(&0) {
            continue;
        }
        let (Some(super::ArgPlacement::PredReg(n)), Some(to)) = (
            param_plan.get(idx as usize),
            alloc.sve.pred_place(vid as u32),
        ) else {
            return fail("SVE predicate parameter: no incoming register or place");
        };
        moves.push((PredPlace::Reg(*n), to));
    }
    schedule_pred_moves(code, frame, &mut moves);
    Ok(placed)
}

/// An SVE return value into z0 or p0.
pub(super) fn emit_return(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    match func.value_sve_kind(value) {
        Some(LoadKind::SvePredicate) => {
            let Some(from) = alloc.sve.pred_place(value) else {
                return fail("SVE predicate result: no place");
            };
            pred_move(code, frame, from, PredPlace::Reg(0));
            Ok(())
        }
        _ => emit_z_copy(code, place_of(alloc, value), Place::FpReg(0), frame),
    }
}

/// Store SVE value `value` into slot `slot`, a predicate's when `pred`.
pub(super) fn store_copy(
    code: &mut Vec<u8>,
    frame: Frame,
    alloc: &Allocation,
    value: u32,
    pred: bool,
    slot: u32,
) -> Emit {
    if !pred {
        return emit_z_copy(code, place_of(alloc, value), Place::Spill(slot), frame);
    }
    let Some(from) = alloc.sve.pred_place(value) else {
        return fail("SVE predicate argument: no place");
    };
    pred_move(code, frame, from, PredPlace::Slot(slot));
    Ok(())
}

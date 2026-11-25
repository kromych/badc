// x86_64 native emit over the SSA and the allocator output; the aarch64
// backend has the same shape with its own encodings and ABI rules.
//
// Per function: the prologue (frame, callee-saved registers, the argument
// registers stored where the body reads the parameters), each block in
// source order with its instructions and terminator, and the epilogue
// inline at every `Terminator::Return`.
//
// Frame layout, top to bottom:
//
// ```text
//   incoming stack arguments      [rbp + 16 + off]   (Win64: the home area first)
//   return address                [rbp + 8]
//   saved rbp                     [rbp]
//   canary                        [rbp - 8]          (protected frames)
//   locals area                   [rbp - locals_bytes - canary .. rbp - canary]
//   parameter cells               [rbp + param_cells_off ..]  (System V register parameters)
//   allocator spill slots         ...
//   register save area            (System V variadic callee)
//   over-aligned region           [rbp + align_region_off ..]  (16-mode only)
//   saved non-volatile xmm        (Win64 FP scratch)
//   saved callee-saved GPRs       rsp; pushed after `sub rsp`, popped before `leave`
// ```
//
// [`emit_function`] returns an `Unsupported` when it meets a shape
// outside the implemented subset; `x86_64::lower` turns that into a
// compile error.

#![allow(dead_code, clippy::too_many_arguments)]

mod arith;
mod call;
mod early_exit;
mod frame;
mod function;
mod inline_asm;
mod inst;
mod intrinsic;
mod mem;
#[cfg(test)]
mod tests;

use alloc::vec::Vec;

use super::super::ir::{
    AsmSeg, BinOp, BitCountOp, FpCastKind, FunctionSsa, IndexExt, Inst, LoadKind, StoreKind,
    Terminator,
};
use super::GotFixup;
use super::Target;
use super::encode::{
    Cc, Fixup, Mem, PltCallFixup, Reg, emit_add_rsp, emit_addsd, emit_addss, emit_cvtsd2ss,
    emit_cvtsi2sd, emit_cvtsi2ss, emit_cvtss2sd, emit_cvttsd2si, emit_cvttss2si, emit_imul_r_mem,
    emit_jcc_rel8, emit_jmp_rel8, emit_lea_r_mem, emit_lock_cmpxchg_mem_r, emit_lock_xadd_mem_r,
    emit_mov_mem_r, emit_mov_r_imm64, emit_mov_r_mem, emit_mov_rr, emit_movapd_xmm_xmm,
    emit_movq_xmm_r, emit_movsd_mem_xmm, emit_movsd_xmm_mem, emit_movss_mem_xmm,
    emit_movss_xmm_mem, emit_movsx_r_mem16, emit_movsxd_r_mem, emit_movups_mem_xmm,
    emit_movups_xmm_mem, emit_movzx_r_mem16, emit_movzx_r_r8, emit_pop_r, emit_push_r, emit_ret,
    emit_ri, emit_rm, emit_rr, emit_setcc_r8, emit_shift_cl, emit_shift_ri, emit_sse_fp_arith,
    emit_sub_rsp, emit_subsd, emit_ucomisd, emit_ucomiss, emit_unary_r, emit_vex_fma,
    emit_vex_fma_mem, emit_vex_fp_arith, emit_vex_fp_arith_mem, emit_xchg_mem_r, emit_xchg_rr,
    emit_xorps,
};
use super::ssa::code_buf::{CodeBuf, ScratchPlan, SpillWidth};
use super::ssa::emit_common::{
    Emit, MAX_UNPROBED_STACK_STEP, PlaceMove, STACK_PROBE_PAGE, STACK_PROBE_UNROLL_MAX,
    Unsupported, build_arg_aggs, c5_slot_to_fp_offset, param_entry_ext, place_same_loc,
};
use super::ssa::reg_alloc::{Allocation, Place, VecWidth};
use super::table::Mnem;
use super::{AddrPart, DataFixup};

// The submodules reach the parent-level items as `super::<item>`, the
// paths the code used when this module was a single file.
use super::*;
pub(crate) use arith::binop_imm_materializes;
use arith::*;
use call::*;
use early_exit::*;
use frame::*;
pub(crate) use frame::{
    Frame, asm_binds_directly, asm_bound_scratch_suffices, asm_site_bound_values,
    asm_site_write_masks, asm_staged_hints, bound_scratch_candidates, frame_pointer_free,
};
pub(crate) use function::emit_function;
use function::*;
use inline_asm::*;
pub(crate) use inline_asm::{encode_x86_file_asm_section_code, jcc_cond, short_branch_opcode};
use inst::*;
use intrinsic::*;
use mem::*;

/// A form outside the implemented subset, named by `reason`.
fn unsupported(reason: impl Into<alloc::borrow::Cow<'static, str>>) -> Unsupported {
    let reason = reason.into();
    super::ssa::emit_common::trace_bail("x86_64", &reason);
    Unsupported::new(reason)
}

/// [`unsupported`] as an emit result.
fn fail<T>(reason: impl Into<alloc::borrow::Cow<'static, str>>) -> Emit<T> {
    Err(unsupported(reason))
}

/// A value's allocated `Place`, `Place::None` when out of range.
fn place_of(alloc: &Allocation, v: u32) -> Place {
    alloc.places.get(v as usize).copied().unwrap_or(Place::None)
}

/// Extract the int reg from a `Place`, or `None` if it's not an
/// integer register.
fn int_reg(place: Place) -> Option<Reg> {
    place.int_reg_u8().map(Reg)
}

/// The scratch pair of a site where no value holds it, which the
/// caller-saved banks give out last: writing it costs no prologue save.
const SCRATCH_PAIR: [u8; 2] = super::ssa::reg_alloc::X86_SCRATCH_PAIR;
use super::ssa::reg_alloc::{X86_MOVE_ORDER as MOVE_ORDER, X86_SCRATCH_ORDER as SCRATCH_ORDER};
/// The register of a scratch its site has none for: taking it fails the
/// function.
const NO_SCRATCH: u8 = 0xFF;
/// The plan outside the planned sites of a function whose values hold the
/// pair.
const NO_PLAN: ScratchPlan = ScratchPlan::free([NO_SCRATCH; 2]);
/// Further scratches inside the allocator's `caller_gprs` pool: a handler
/// that uses one must check that no `rd` or operand place aliases it.
const SCRATCH_RCX: Reg = Reg(1);
const SCRATCH_RDX: Reg = Reg(2);

/// One of the two scratch registers of the site being lowered
/// ([`ScratchPlan`]): none holds an operand or the result of the site.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
struct Scratch(usize);
const S0: Scratch = Scratch(0);
const S1: Scratch = Scratch(1);

/// The plan of the site being lowered; a buffer with none set lowers as a
/// site that borrows nothing.
fn site_plan(code: &CodeBuf) -> ScratchPlan {
    code.scratch_plan()
        .unwrap_or(ScratchPlan::free(SCRATCH_PAIR))
}

/// The register of scratch `s`, which the lowering writes from here on: a
/// borrowed one first stores the value it holds to the plan's slot, and
/// the site's end reloads it ([`end_scratch`]). A lowering takes its
/// scratch before it moves rsp, as the slot's address is rsp's at the
/// site's start in a frame with no pointer.
fn scratch(code: &mut CodeBuf, s: Scratch) -> Reg {
    let plan = site_plan(code);
    if plan.regs[s.0] == NO_SCRATCH {
        code.scratch_fault();
        return Reg::R10;
    }
    let r = Reg(plan.regs[s.0]);
    if code.take_scratch(s.0)
        && let Some((base, disp)) = plan.keep[s.0]
    {
        code.note_kept(keep::BORROW_AREA as u32);
        emit_mov_mem_r(code, Reg(base), disp, r);
    }
    r
}

/// The register of scratch `s`, for a comparison; taking it is
/// [`scratch`].
fn scratch_reg(code: &CodeBuf, s: Scratch) -> Reg {
    Reg(site_plan(code).regs[s.0])
}

/// Begin a site under `plan`. A register an ended site borrowed is
/// reloaded first, unless this plan borrows it into the same slot, where
/// its value stays.
fn begin_site(code: &mut CodeBuf, plan: Option<ScratchPlan>) {
    let pending = code.take_pending();
    code.set_scratch(plan);
    for (k, p) in pending.into_iter().enumerate() {
        let Some((r, slot)) = p else { continue };
        if plan.is_some_and(|q| q.regs[k] == r && q.keep[k] == Some(slot)) {
            code.carry_scratch(k);
        } else {
            emit_mov_r_mem(code, Reg(r), Reg(slot.0), slot.1);
        }
    }
}

/// Reload the registers ended sites borrowed, ahead of code no site plans.
fn flush_scratch(code: &mut CodeBuf) {
    for (r, (base, disp)) in code.take_pending().into_iter().flatten() {
        emit_mov_r_mem(code, Reg(r), Reg(base), disp);
    }
}

/// The registers ended sites borrowed and did not reload, by scratch
/// index, which a plan borrows again first.
fn pending_regs(code: &CodeBuf) -> [Option<u8>; 2] {
    code.pending().map(|p| p.map(|(r, _)| r))
}

/// End the site. The registers it borrowed stay pending until the next
/// site ([`begin_site`]) or a flush. A site that took a scratch its plan
/// has none for, or borrowed one after a branch, whose store would not run
/// on every path, fails the function.
fn end_scratch(code: &mut CodeBuf) -> Emit {
    let (kept, fault) = code.end_scratch();
    code.set_pending(kept);
    if fault {
        return fail("scratch register the site's plan does not give");
    }
    Ok(())
}

/// The plan of a site that reads or writes the registers in `touched`
/// while values live across it hold those in `through`: the first two
/// registers of `order` ([`SCRATCH_ORDER`], [`MOVE_ORDER`]) no value holds,
/// else ones only a value living across holds, borrowed into the
/// allocation's two borrow slots, the register `prefer` names for a slot
/// first ([`pending_regs`]). `None` when no value holds the pair, so each
/// site takes it free.
fn plan_site(
    alloc: &Allocation,
    frame: Frame,
    (touched, through): (u16, u16),
    order: &[u8],
    prefer: [Option<u8>; 2],
) -> Option<ScratchPlan> {
    let sites = alloc.scratch_sites.as_ref()?;
    let usable: alloc::vec::Vec<u8> = order
        .iter()
        .copied()
        .filter(|&r| sites.writable >> r & 1 != 0 && !frame.fixed_regs.has_gpr(r))
        .collect();
    let held = |r: u8, mask: u16| mask >> r & 1 != 0;
    let free = usable
        .iter()
        .filter(|&&r| !held(r, touched | through))
        .map(|&r| (r, false));
    let borrowed = usable
        .iter()
        .filter(|&&r| held(r, through) && !held(r, touched))
        .map(|&r| (r, true));
    let mut picked: alloc::vec::Vec<(u8, bool)> = free.take(2).collect();
    let mut borrowed: alloc::vec::Vec<u8> = borrowed.map(|(r, _)| r).collect();
    for want in prefer.into_iter().skip(picked.len()) {
        let at = want
            .and_then(|r| borrowed.iter().position(|&b| b == r))
            .or((!borrowed.is_empty()).then_some(0));
        if let Some(i) = at {
            picked.push((borrowed.remove(i), true));
        }
    }
    let mut plan = NO_PLAN;
    for (k, &(r, borrow)) in picked.iter().enumerate() {
        plan.regs[k] = r;
        if borrow {
            // A frame without the area is laid out again once a site
            // borrows (keep::BORROW_AREA): this pass's slots are stand-ins.
            let (base, disp) = if frame.borrow_area {
                spill_slot_addr(frame, sites.borrow_slot + k as u32)
            } else {
                (Reg::RSP, 8 * k as i32)
            };
            plan.keep[k] = Some((base.0, disp));
        }
    }
    Some(plan)
}

/// The plan of instruction `v`: a call's lowering takes the pair, which
/// none of its operands holds and no value lives across a call in.
fn plan_inst(
    alloc: &Allocation,
    frame: Frame,
    v: super::super::ir::ValueId,
    call: bool,
    prefer: [Option<u8>; 2],
) -> Option<ScratchPlan> {
    let masks = &alloc.scratch_sites.as_ref()?.masks;
    if call {
        return Some(ScratchPlan::free(SCRATCH_PAIR));
    }
    let at = |m: &[u16]| m.get(v as usize).copied().unwrap_or(u16::MAX);
    plan_site(
        alloc,
        frame,
        (at(&masks.touched), at(&masks.through)),
        &SCRATCH_ORDER,
        prefer,
    )
}

/// The scratch pair of a parallel copy of places (`schedule_place_moves`):
/// taken only when a move may stage through it -- one with a spill slot
/// at either end or an extension, which the x86-64 moves stage or which
/// joins a cycle an exchange cannot break -- else none the copy may write.
fn move_scratch(code: &mut CodeBuf, staged: bool) -> (Reg, Reg) {
    if staged {
        (scratch(code, S0), scratch(code, S1))
    } else {
        (Reg(NO_SCRATCH), Reg(NO_SCRATCH))
    }
}

/// Whether a parallel copy stages a move through scratch ([`move_scratch`]).
pub(crate) fn moves_stage(moves: &[super::ssa::emit_common::PlaceMove]) -> bool {
    moves.iter().any(|m| {
        m.ext.is_some() || matches!(m.src, Place::Spill(_)) || matches!(m.dst, Place::Spill(_))
    })
}

/// Where a helper puts a value it loads: a given register, or a scratch of
/// the site, taken only when the value is loaded.
#[derive(Clone, Copy)]
enum Stage {
    Reg(Reg),
    Scratch(Scratch),
}

impl From<Reg> for Stage {
    fn from(r: Reg) -> Self {
        Stage::Reg(r)
    }
}

impl From<Scratch> for Stage {
    fn from(s: Scratch) -> Self {
        Stage::Scratch(s)
    }
}

impl Stage {
    fn reg(self, code: &mut CodeBuf) -> Reg {
        match self {
            Stage::Reg(r) => r,
            Stage::Scratch(s) => scratch(code, s),
        }
    }
}

/// Extract the FP reg from a `Place`, or `None` if it's not an
/// xmm register.
fn fp_reg(place: Place) -> Option<Reg> {
    place.fp_reg_u8().map(Reg)
}

/// The working xmm of an FP-producing handler: the allocated register for
/// `FpReg`, the first FP scratch for `Spill`.
fn fp_or_spill_dst(dst: Place, frame: Frame) -> Option<Reg> {
    match dst {
        Place::FpReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(Reg(frame.fp_scratch[0])),
        _ => None,
    }
}

/// An FP value's `Place` in an xmm register: `FpReg` in place, `Spill`
/// loaded into `scratch`, `IntReg` reinterpreted through `movq xmm, gpr`
/// (the constant folder places f64 constants as `Imm` bit patterns).
fn materialize_fp(code: &mut CodeBuf, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    materialize_fp_shifted(code, place, scratch, frame, 0)
}

fn materialize_fp_shifted(
    code: &mut CodeBuf,
    place: Place,
    scratch: Reg,
    frame: Frame,
    sp_shift: u32,
) -> Option<Reg> {
    match place {
        Place::FpReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let (sb, sp_off) = spill_slot_addr_shifted(frame, slot, sp_shift);
            match code.holding(sb.0, sp_off, SpillWidth::Scalar) {
                Some(r) if r == scratch.0 => {}
                Some(r) => emit_movapd_xmm_xmm(code, scratch, Reg(r)),
                None => emit_movsd_xmm_mem(code, scratch, sb, sp_off),
            }
            Some(scratch)
        }
        Place::IntReg(r) => {
            emit_movq_xmm_r(code, scratch, Reg(r));
            Some(scratch)
        }
        Place::None => None,
    }
}

/// If `dst` is `Place::Spill`, store `src` (an xmm reg) into the
/// matching spill slot. No-op for FpReg / IntReg / None.
fn fp_spill_dst_to_slot(code: &mut CodeBuf, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let (sb, sp_off) = spill_slot_addr(frame, slot);
        let start = code.len();
        emit_movsd_mem_xmm(code, sb, sp_off, src);
        code.spill_stored(start, sb.0, sp_off, src.0, SpillWidth::Scalar);
    }
}

/// A 128-bit spill occupies its slot and the one below, addressed at the lower.
fn v128_spill_addr(frame: Frame, slot: u32) -> (Reg, i32) {
    spill_slot_addr(frame, slot + 1)
}

/// An `IntReg` source is the zero a fill stores; `movq` clears the upper half.
fn materialize_v128(code: &mut CodeBuf, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    match place {
        Place::FpReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let (sb, off) = v128_spill_addr(frame, slot);
            match code.holding(sb.0, off, SpillWidth::Vector(16)) {
                Some(r) if r == scratch.0 => {}
                Some(r) => emit_movapd_xmm_xmm(code, scratch, Reg(r)),
                None => emit_movups_xmm_mem(code, scratch, sb, off),
            }
            Some(scratch)
        }
        Place::IntReg(r) => {
            emit_movq_xmm_r(code, scratch, Reg(r));
            Some(scratch)
        }
        Place::None => None,
    }
}

/// A 128-, 256- or 512-bit spill occupies its width's units, addressed at the
/// lowest.
fn wide_spill_addr(frame: Frame, w: VecWidth, slot: u32) -> (Reg, i32) {
    spill_slot_addr(frame, slot + w.units() - 1)
}

/// A zmm transfer through the assembler's EVEX tables, which scale an
/// 8-bit displacement by the operand size as EVEX does.
fn emit_zmm(code: &mut Vec<u8>, mnem: &'static str, ops: &[super::asm::Concrete]) {
    let m = super::asm::mnemonic_by_name(mnem).unwrap_or(super::asm::Mnemonic::Table(mnem));
    super::asm::encode(code, 8, m, None, ops).expect("EVEX zmm transfer");
}

fn zmm(n: Reg) -> super::asm::Concrete {
    super::asm::Concrete::Reg {
        reg: super::asm::ZMM_BASE + n.0,
        size: crate::c5::ir::AsmRegSize::Quad,
    }
}

fn zmm_mem(base: Reg, disp: i32) -> super::asm::Concrete {
    super::asm::Concrete::Mem {
        base: base.0,
        index: None,
        scale: 1,
        disp,
        size: crate::c5::ir::AsmRegSize::Quad,
    }
}

/// `vmovups` / `vmovdqu64` of a 128-, 256- or 512-bit register from `[base + disp]`.
fn emit_wide_load(code: &mut Vec<u8>, w: VecWidth, dst: Reg, base: Reg, disp: i32) {
    match w {
        VecWidth::V512 => emit_zmm(code, "vmovdqu64", &[zmm_mem(base, disp), zmm(dst)]),
        VecWidth::V256 => emit_vmovups_ymm_mem(code, dst, base, disp),
        _ => super::encode::emit_vmovups_xmm_mem(code, dst, base, disp),
    }
}

/// `vmovups` / `vmovdqu64` of a 128-, 256- or 512-bit register to
/// `[base + disp]`, writing that many bytes.
fn emit_wide_store(code: &mut Vec<u8>, w: VecWidth, base: Reg, disp: i32, src: Reg) {
    match w {
        VecWidth::V512 => emit_zmm(code, "vmovdqu64", &[zmm(src), zmm_mem(base, disp)]),
        VecWidth::V256 => emit_vmovups_mem_ymm(code, base, disp, src),
        _ => super::encode::emit_vmovups_mem_xmm(code, base, disp, src),
    }
}

/// `vmovaps` / `vmovdqa64` between 128-, 256- or 512-bit registers.
fn emit_wide_mov(code: &mut Vec<u8>, w: VecWidth, dst: Reg, src: Reg) {
    match w {
        VecWidth::V512 => emit_zmm(code, "vmovdqa64", &[zmm(src), zmm(dst)]),
        VecWidth::V256 => emit_vmovaps_ymm_ymm(code, dst, src),
        _ => super::encode::emit_vmovaps_xmm_xmm(code, dst, src),
    }
}

/// [`materialize_v128`] for a value of any vector width; `vmovq` clears the
/// bits above 64.
fn materialize_wide(
    code: &mut CodeBuf,
    w: VecWidth,
    place: Place,
    scratch: Reg,
    frame: Frame,
) -> Option<Reg> {
    match place {
        Place::FpReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let (sb, off) = wide_spill_addr(frame, w, slot);
            match code.holding(sb.0, off, wide_spill_width(w)) {
                Some(r) if r == scratch.0 => {}
                Some(r) => emit_wide_mov(code, w, scratch, Reg(r)),
                None => emit_wide_load(code, w, scratch, sb, off),
            }
            Some(scratch)
        }
        Place::IntReg(r) => {
            emit_vmovq_xmm_r(code, scratch, Reg(r));
            Some(scratch)
        }
        Place::None => None,
    }
}

fn mirror_wide_dst(code: &mut CodeBuf, w: VecWidth, dst: Place, src: Reg, frame: Frame) {
    match dst {
        Place::FpReg(r) if r != src.0 => emit_wide_mov(code, w, Reg(r), src),
        Place::Spill(slot) => {
            let (sb, off) = wide_spill_addr(frame, w, slot);
            let start = code.len();
            emit_wide_store(code, w, sb, off, src);
            code.spill_stored(start, sb.0, off, src.0, wide_spill_width(w));
        }
        _ => {}
    }
}

fn mirror_v128_dst(code: &mut CodeBuf, dst: Place, src: Reg, frame: Frame) {
    match dst {
        Place::FpReg(r) if r != src.0 => emit_movapd_xmm_xmm(code, Reg(r), src),
        Place::Spill(slot) => {
            let (sb, off) = v128_spill_addr(frame, slot);
            let start = code.len();
            emit_movups_mem_xmm(code, sb, off, src);
            code.spill_stored(start, sb.0, off, src.0, SpillWidth::Vector(16));
        }
        _ => {}
    }
}

/// Read an integer operand's place into a register, borrowing `rd`
/// as the load target for a spilled operand (the caller writes `rd`
/// afterwards anyway). `None` for an FP / absent place.
fn int_operand_into_rd(code: &mut CodeBuf, place: Place, rd: Reg, frame: Frame) -> Option<Reg> {
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(slot) => Some(load_spill_slot(code, frame, slot, 0, rd)),
        _ => None,
    }
}

/// Integer spill slot `slot` in `dst`: a move from the register the code
/// just stored it from, else a load.
fn load_spill_slot(code: &mut CodeBuf, frame: Frame, slot: u32, sp_shift: u32, dst: Reg) -> Reg {
    let (sb, off) = spill_slot_addr_shifted(frame, slot, sp_shift);
    match code.holding(sb.0, off, SpillWidth::Int) {
        Some(r) if r == dst.0 => {}
        Some(r) => emit_mov_rr(code, dst, Reg(r)),
        None => emit_mov_r_mem(code, dst, sb, off),
    }
    dst
}

fn wide_spill_width(w: VecWidth) -> SpillWidth {
    SpillWidth::Vector(w.units() as u8 * 8)
}

/// The working register of an int-producing handler: the allocated
/// register for `IntReg`, scratch 0 for `Spill`.
fn int_or_spill_dst(code: &mut CodeBuf, dst: Place) -> Option<Reg> {
    match dst {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(scratch(code, S0)),
        _ => None,
    }
}

/// `(base, disp)` of allocator spill slot `slot`. Every spill access goes
/// through here: a static frame addresses `[rsp + off]`, a dynamic-sp
/// frame the same byte as `[rbp + off - frame_bytes]`.
fn spill_slot_addr(frame: Frame, slot: u32) -> (Reg, i32) {
    spill_slot_addr_shifted(frame, slot, 0)
}

/// [`spill_slot_addr`] for a caller that pushed rsp down by `sp_shift`
/// bytes; only the rsp-based form shifts. Slot 0 is the top of the spill
/// region, slot N+1 eight bytes below slot N, and rsp = rbp - frame_bytes.
fn spill_slot_addr_shifted(frame: Frame, slot: u32, sp_shift: u32) -> (Reg, i32) {
    let off = super::ssa::emit_common::spill_slot_sp_offset(
        frame.frame_bytes,
        frame.alloc_spill_base,
        slot,
    ) as i32;
    if frame.dynamic_sp {
        (Reg::RBP, off - frame.frame_bytes as i32)
    } else {
        (Reg::RSP, off + sp_shift as i32)
    }
}

/// Keep slots, where a lowering in a frame with no pointer keeps a register
/// it borrows within one instruction, as a framed one pushes it: rsp stays
/// where the prologue left it, as the frame's addressing and the unwind
/// information assume. Each lowering owns its slots, so one running inside
/// another's borrow keeps it. Slot `k` is `[rsp - 8 * (k + 1)]` in the red
/// zone (System V AMD64 3.2.2: the 128 bytes below rsp, which signal and
/// interrupt handlers leave alone), else in the frame's keep area
/// ([`Frame::keep`]); slot 0 is the x87 round trip's.
pub(super) mod keep {
    pub(crate) const X87: i32 = 0;
    pub(crate) const CALL_TARGET: i32 = 1;
    pub(crate) const RAX: i32 = 2;
    pub(crate) const RDX: i32 = 3;
    pub(crate) const RCX: i32 = 4;
    pub(crate) const NARROW: i32 = 5;
    pub(crate) const SSE_PART: i32 = 6;
    /// Two slots: the comparand's address and rbx.
    pub(crate) const CAS16: i32 = 7;
    /// [`super::mem::SiteRegs`], through [`LAST`].
    pub(crate) const SITE: i32 = 9;
    pub(crate) const LAST: i32 = 15;
    /// No slot: taken, it asks the frame for the two spill slots a borrowed
    /// scratch register keeps its value in
    /// (`reg_alloc::ScratchSites::borrow_slot`).
    pub(crate) const BORROW_AREA: i32 = 31;
}

/// The address of keep slot `k` ([`keep`]), which `code` records as taken.
pub(super) fn keep_slot(code: &mut CodeBuf, frame: Frame, k: i32) -> (Reg, i32) {
    code.note_kept(k as u32);
    match frame.red_zone {
        true => (Reg::RSP, -8 * (k + 1)),
        false => (Reg::RSP, frame.keep_disp(k)),
    }
}

/// Keep `r` across a sequence that writes it: in keep slot `k` in a frame
/// with no pointer ([`keep`]), else `push r`.
fn save_across(code: &mut CodeBuf, frame: Frame, r: Reg, k: i32) {
    if frame.omit_fp {
        let (base, disp) = keep_slot(code, frame, k);
        emit_mov_mem_r(code, base, disp, r);
    } else {
        emit_push_r(code, r);
    }
}

/// How far `saves` calls to [`save_across`] move rsp: the slot offsets a
/// lowering reads past them grow by it.
fn saved_shift(frame: Frame, saves: u32) -> u32 {
    if frame.omit_fp { 0 } else { 8 * saves }
}

/// Undo [`save_across`].
fn restore_across(code: &mut CodeBuf, frame: Frame, r: Reg, k: i32) {
    if frame.omit_fp {
        let (base, disp) = keep_slot(code, frame, k);
        emit_mov_r_mem(code, r, base, disp);
    } else {
        emit_pop_r(code, r);
    }
}

/// If `dst` is a `Spill` place, write the just-produced value in
/// `src` into the spill slot. No-op for register places (the
/// caller already wrote into the allocator's chosen reg).
fn spill_dst_to_slot(code: &mut CodeBuf, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let (sb, sp_off) = spill_slot_addr(frame, slot);
        let start = code.len();
        emit_mov_mem_r(code, sb, sp_off, src);
        code.spill_stored(start, sb.0, sp_off, src.0, SpillWidth::Int);
    }
}

/// The cells past the first of the spill slot of an integer value as wide
/// as `w`, written from `src`: a zero read as a vector keeps all of them
/// (`reg_alloc::widen_vector_zeros`). Nothing for a scalar or a register.
fn spill_wide_rest(code: &mut CodeBuf, w: VecWidth, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        for k in 1..w.units() {
            let (sb, off) = spill_slot_addr(frame, slot + k);
            let start = code.len();
            emit_mov_mem_r(code, sb, off, src);
            code.spill_stored(start, sb.0, off, src.0, SpillWidth::Int);
        }
    }
}

/// A value's `Place` in a register: `IntReg` in place, `Spill` loaded into
/// `stage`; `None` for the other kinds.
fn materialize_int(
    code: &mut CodeBuf,
    place: Place,
    stage: impl Into<Stage>,
    frame: Frame,
) -> Option<Reg> {
    materialize_int_shifted(code, place, stage, frame, 0)
}

/// Up to two integer operands in distinct registers: a register-resident
/// operand stays, a spilled one loads into the next scratch of the site.
/// `None` when an operand is neither.
fn materialize_int_operands_distinct(
    code: &mut CodeBuf,
    places: &[Place],
    frame: Frame,
) -> Option<alloc::vec::Vec<Reg>> {
    let mut regs: alloc::vec::Vec<Option<Reg>> = alloc::vec![None; places.len()];
    for (i, &p) in places.iter().enumerate() {
        match p {
            Place::IntReg(r) => regs[i] = Some(Reg(r)),
            Place::Spill(_) => {}
            _ => return None,
        }
    }
    let mut pool = [S0, S1].into_iter();
    for (i, &p) in places.iter().enumerate() {
        if regs[i].is_some() {
            continue;
        }
        regs[i] = materialize_int(code, p, pool.next()?, frame);
    }
    Some(
        regs.into_iter()
            .map(|r| r.expect("operand register assigned"))
            .collect(),
    )
}

/// [`materialize_int`] for a caller that pushed rsp down by `sp_shift`
/// bytes since the prologue.
fn materialize_int_shifted(
    code: &mut CodeBuf,
    place: Place,
    stage: impl Into<Stage>,
    frame: Frame,
    sp_shift: u32,
) -> Option<Reg> {
    let stage = stage.into();
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let scratch = stage.reg(code);
            Some(load_spill_slot(code, frame, slot, sp_shift, scratch))
        }
        Place::FpReg(r) => {
            let scratch = stage.reg(code);
            // Reinterpret the xmm-resident f64 as its 8-byte bit
            // pattern via `movq scratch, xmm[r]`. Used at c5-internal
            // call sites that route every argument through the
            // integer arg bank (the callee's prologue spills only
            // int_arg_regs into the c5 cdecl slots).
            super::encode::emit_movq_r_xmm(code, scratch, Reg(r));
            Some(scratch)
        }
        Place::None => None,
    }
}

#[allow(clippy::too_many_arguments)]
/// Read-only per-function context threaded through the per-instruction
/// lowering. Bundles the loop-invariant inputs so emit_inst's signature stays
/// short; Copy (references and small scalars).
#[derive(Clone, Copy)]
struct FnCtx<'a> {
    func: &'a FunctionSsa,
    alloc: &'a Allocation,
    frame: Frame,
    abi: super::Abi,
    target: Target,
    /// The xmm register a zero fill or a copy moves 16 bytes through
    /// (`reg_alloc::free_fp_register`).
    bulk_xmm: Option<u8>,
    imports: &'a super::ResolvedImports,
    variadic_targets: &'a alloc::collections::BTreeSet<usize>,
    extern_tls_names: &'a alloc::collections::BTreeMap<u32, crate::c5::codegen::TlsSymbolRef>,
    /// `Inst::ImmData` value-id -> cross-TU data symbol name, for an `i`-class
    /// inline-asm operand that names an external address, whether in a section
    /// field or via a `%a` address operand.
    extern_data_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    /// `Inst::ImmCode` value-id -> cross-TU function symbol name, for a `%c`
    /// function operand a replacement `call` / `jmp` in a section relocates
    /// against (`call %c[new]` in a pushed `"ax"` section).
    extern_code_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    tls_total_size: usize,
    param_from_home: &'a [bool],
    param_plan: &'a [super::ArgPlacement],
    /// Function name -> entry PC, for resolving an inline-asm `call`/`jmp` to a
    /// bare symbol into a relocation.
    name2entpc: &'a alloc::collections::BTreeMap<alloc::string::String, usize>,
    /// Per value: a call after which nothing runs
    /// (`emit_common::calls_ending_paths`).
    ends_path: &'a [bool],
}

/// The output buffers a function's lowering appends to: the bundle shared
/// with the aarch64 backend and the x86_64-only vectors passed beside it.
struct Out<'a, 'b> {
    cx: &'b mut super::ssa::emit_common::EmitCtx<'a>,
    fixups: &'b mut Vec<Fixup>,
    asm_section_text_refs: &'b mut Vec<super::AsmSectionTextRef>,
    asm_text_abs_refs: &'b mut Vec<super::AsmTextAbsRef>,
    asm_text_labels: &'b mut Vec<super::AsmTextLabel>,
    abs_addr_refs: &'b mut Vec<super::AbsAddrRef>,
    /// `(displacement offset, bits, width)` per floating constant or mask
    /// read from a read-only literal.
    fp_literals: Vec<(usize, u64, u8)>,
}

/// The length of every output buffer at one point of the emission.
struct OutputMark {
    code: usize,
    fixups: usize,
    plt_call_fixups: usize,
    data_fixups: usize,
    user_extern_data_refs: usize,
    pending_func_fixups: usize,
    tls_index_fixups: usize,
    elf_tpoff_fixups: usize,
    ssa_line_rows: usize,
    asm_sections: crate::c5::asm::AsmSectionsSnapshot,
    asm_extern_call_sites: usize,
    asm_sym_fixups: usize,
    asm_warnings: usize,
    text_align: usize,
    mcount_sites: usize,
    early_returns: usize,
    seh_rows: usize,
    asm_section_text_refs: usize,
    asm_text_abs_refs: usize,
    asm_text_labels: usize,
    abs_addr_refs: usize,
}

impl Out<'_, '_> {
    fn mark(&self) -> OutputMark {
        OutputMark {
            code: self.cx.code.len(),
            fixups: self.fixups.len(),
            plt_call_fixups: self.cx.plt_call_fixups.len(),
            data_fixups: self.cx.data_fixups.len(),
            user_extern_data_refs: self.cx.user_extern_data_refs.len(),
            pending_func_fixups: self.cx.pending_func_fixups.len(),
            tls_index_fixups: self.cx.tls_index_fixups.len(),
            elf_tpoff_fixups: self.cx.elf_tpoff_fixups.len(),
            ssa_line_rows: self.cx.ssa_line_rows.len(),
            asm_sections: self.cx.asm_sections.snapshot(),
            asm_extern_call_sites: self.cx.asm_extern_call_sites.len(),
            asm_sym_fixups: self.cx.asm_sym_fixups.len(),
            asm_warnings: self.cx.asm_warnings.len(),
            text_align: *self.cx.text_align,
            mcount_sites: self.cx.mcount_sites.len(),
            early_returns: self.cx.early_returns.len(),
            seh_rows: self.cx.seh_rows.len(),
            asm_section_text_refs: self.asm_section_text_refs.len(),
            asm_text_abs_refs: self.asm_text_abs_refs.len(),
            asm_text_labels: self.asm_text_labels.len(),
            abs_addr_refs: self.abs_addr_refs.len(),
        }
    }

    /// Drop everything appended since `m` was taken.
    fn restore(&mut self, m: &OutputMark) {
        self.cx.code.truncate(m.code);
        self.fixups.truncate(m.fixups);
        self.cx.plt_call_fixups.truncate(m.plt_call_fixups);
        self.cx.data_fixups.truncate(m.data_fixups);
        self.cx
            .user_extern_data_refs
            .truncate(m.user_extern_data_refs);
        self.cx.pending_func_fixups.truncate(m.pending_func_fixups);
        self.cx.tls_index_fixups.truncate(m.tls_index_fixups);
        self.cx.elf_tpoff_fixups.truncate(m.elf_tpoff_fixups);
        self.cx.ssa_line_rows.truncate(m.ssa_line_rows);
        self.cx.asm_sections.restore(&m.asm_sections);
        self.cx
            .asm_extern_call_sites
            .truncate(m.asm_extern_call_sites);
        self.cx.asm_sym_fixups.truncate(m.asm_sym_fixups);
        self.cx.asm_warnings.truncate(m.asm_warnings);
        *self.cx.text_align = m.text_align;
        self.cx.mcount_sites.truncate(m.mcount_sites);
        self.cx.early_returns.truncate(m.early_returns);
        self.cx.seh_rows.truncate(m.seh_rows);
        self.asm_section_text_refs.truncate(m.asm_section_text_refs);
        self.asm_text_abs_refs.truncate(m.asm_text_abs_refs);
        self.asm_text_labels.truncate(m.asm_text_labels);
        self.abs_addr_refs.truncate(m.abs_addr_refs);
    }
}

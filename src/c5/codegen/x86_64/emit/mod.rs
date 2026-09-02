//! x86_64 native emit consuming the SSA + allocator output.
//! Mirrors the aarch64 counterpart's structure; the difference
//! is the per-target instruction encodings and the SysV / Win64
//! ABI shape applied to argument and return placement.
//!
//! ## Pass shape
//!
//! For each function:
//!
//! 1. Prologue: push rbp, set rbp = rsp, reserve locals +
//!    allocator-spill bytes, save the callee-saved GPRs the
//!    allocator reported as used, and spill the host-ABI arg
//!    registers into the c5 cdecl slots the body's
//!    `LocalAddr(>=2)` references.
//! 2. Walk each block in source order. Emit per-`Inst` native
//!    code in `inst_range`, then the terminator.
//! 3. Epilogue lands inline at every `Terminator::Return`: move
//!    the return value into rax, restore saved regs, drop the
//!    frame, pop rbp, ret.
//!
//! ## Frame layout (top -> bottom, growing down from caller's rsp)
//!
//! ```text
//!   c5 cdecl param slots          [rbp + 16*i + 16]
//!   saved rbp, ret address        [rbp]
//!   locals area                   [rbp - locals_bytes .. rbp]
//!   allocator spill slots         ...
//!   over-aligned region           [rbp + align_region_off ..]  (16-mode only)
//!   saved callee-saved GPRs       rsp
//! ```
//!
//! ## Coverage policy
//!
//! [`emit_function`] returns `true` when the SSA emit handled the
//! function end-to-end and `false` when any encountered op is
//! outside the implemented subset. The caller (`x86_64::lower`)
//! turns `false` into a hard compile error -- the IR + emit
//! contract has to cover every shape the walker produces.

#![allow(dead_code, clippy::too_many_arguments)]

mod arith;
mod call;
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
    AsmSeg, BinOp, FpCastKind, FunctionSsa, Inst, LoadKind, StoreKind, Terminator,
};
use super::GotFixup;
use super::Target;
use super::encode::{
    Cc, Fixup, PltCallFixup, Reg, emit_add_rsp_imm32, emit_addsd, emit_addss, emit_cvtsd2ss,
    emit_cvtsi2sd, emit_cvtsi2ss, emit_cvtss2sd, emit_cvttsd2si, emit_cvttss2si, emit_divsd,
    emit_divss, emit_imul_r_mem, emit_jcc_rel8, emit_jmp_rel8, emit_lea_r_mem,
    emit_lock_cmpxchg_mem_r, emit_lock_xadd_mem_r, emit_mov_mem_r, emit_mov_r_imm64,
    emit_mov_r_mem, emit_mov_rr, emit_movapd_xmm_xmm, emit_movq_xmm_r, emit_movsd_mem_xmm,
    emit_movsd_xmm_mem, emit_movss_mem_xmm, emit_movss_xmm_mem, emit_movsx_r_mem16,
    emit_movsxd_r_mem, emit_movups_mem_xmm, emit_movups_xmm_mem, emit_movzx_r_mem16,
    emit_movzx_r_r8, emit_mulsd, emit_mulss, emit_pop_r, emit_push_r, emit_ret, emit_ri, emit_rm,
    emit_rr, emit_setcc_r8, emit_shift_cl, emit_shift_ri, emit_sub_rsp_imm32, emit_subsd,
    emit_subss, emit_ucomisd, emit_ucomiss, emit_unary_r, emit_vfmadd231sd, emit_vfmadd231ss,
    emit_vfmsub231sd, emit_vfmsub231ss, emit_vfnmadd231sd, emit_vfnmadd231ss, emit_vfnmsub231sd,
    emit_vfnmsub231ss, emit_xchg_mem_r, emit_xchg_rr, emit_xorpd, emit_xorps,
};
use super::ssa::emit_common::{
    MAX_UNPROBED_STACK_STEP, STACK_PROBE_PAGE, STACK_PROBE_UNROLL_MAX, build_arg_aggs,
    c5_slot_to_fp_offset, place_same_loc,
};
use super::ssa::reg_alloc::{Allocation, Place};
use super::table::Mnem;
use super::{AddrPart, DataFixup};

// The submodules reach the parent-level items as `super::<item>`, the
// paths the code used when this module was a single file.
use super::*;
pub(crate) use arith::binop_imm_materializes;
use arith::*;
use call::*;
use frame::*;
pub(crate) use frame::{Frame, compute_frame};
pub(crate) use function::emit_function;
use function::*;
use inline_asm::*;
pub(crate) use inline_asm::{encode_x86_file_asm_section_code, jcc_cond, short_branch_opcode};
use inst::*;
use intrinsic::*;
use mem::*;

fn bail_msg(reason: &str) {
    super::ssa::emit_common::bail_msg("x86_64", reason);
}

fn fail(reason: &str) -> bool {
    bail_msg(reason);
    false
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

/// Scratch register for handlers whose dst is a spill: r10 is
/// r10 is in the SSA allocator's `caller_gprs` pool (see
/// `RegBanks::for_target` for `LinuxX64` / `WindowsX64`), so any
/// emit handler that reuses it as a scratch must first check
/// whether the current instruction's `rd` / operand places alias
/// r10 -- otherwise the scratch write clobbers a live value.
/// Emit handlers that need a register guaranteed free of
/// allocator interference use r10 (reserved by the codegen and
/// outside both pools). Caller-saved, so reserving it forces no
/// prologue save.
const SCRATCH_R10: Reg = Reg(10);
/// Secondary / tertiary int scratches for emit handlers that
/// need more than one register beyond `rd`. rcx and rdx are also
/// in the allocator's `caller_gprs` pool, so callers must check
/// for aliasing with `rd` / operand places exactly as with
/// `SCRATCH_R10`. Used by emit handlers that work over a base,
/// an index, and a value (indexed stores) where one register
/// isn't enough.
const SCRATCH_RCX: Reg = Reg(1);
const SCRATCH_RDX: Reg = Reg(2);
/// Reserved secondary scratch outside both allocator pools (see the
/// note on `SCRATCH_R10`). Handlers that already commit `SCRATCH_R10`
/// to one operand and need a second guaranteed-free register use this;
/// it never aliases an allocator-chosen `rd`, a staged dividend in
/// `SCRATCH_R10`, or any argument register. r11 is caller-saved, so
/// reserving it forces no prologue save.
const SCRATCH_R11: Reg = Reg(11);

/// Extract the FP reg from a `Place`, or `None` if it's not an
/// xmm register.
fn fp_reg(place: Place) -> Option<Reg> {
    place.fp_reg_u8().map(Reg)
}

/// Pick the working xmm a single-result FP-producing handler writes
/// into: the allocator's chosen reg for `FpReg`, or the first FP scratch
/// for `Spill`. Other place kinds (`IntReg`, `None`) are not legal
/// for the FP handlers.
fn fp_or_spill_dst(dst: Place, frame: Frame) -> Option<Reg> {
    match dst {
        Place::FpReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(Reg(frame.fp_scratch[0])),
        _ => None,
    }
}

/// Read an FP value's `Place` into a usable xmm register. `FpReg`
/// returns the allocator's chosen reg directly; `Spill` loads the
/// spilled bit pattern into `scratch`; `IntReg` reinterprets the
/// register's bit pattern as an f64 via `movq xmm, gpr` (c5's
/// constant-folder represents f64 constants as `Imm` of the f64 bit
/// pattern, which the allocator places in an IntReg).
fn materialize_fp(code: &mut Vec<u8>, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    materialize_fp_shifted(code, place, scratch, frame, 0)
}

fn materialize_fp_shifted(
    code: &mut Vec<u8>,
    place: Place,
    scratch: Reg,
    frame: Frame,
    sp_shift: u32,
) -> Option<Reg> {
    match place {
        Place::FpReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let (sb, sp_off) = spill_slot_addr_shifted(frame, slot, sp_shift);
            emit_movsd_xmm_mem(code, scratch, sb, sp_off);
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
fn fp_spill_dst_to_slot(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let (sb, sp_off) = spill_slot_addr(frame, slot);
        emit_movsd_mem_xmm(code, sb, sp_off, src);
    }
}

/// Read an integer operand's place into a register, borrowing `rd`
/// as the load target for a spilled operand (the caller writes `rd`
/// afterwards anyway). `None` for an FP / absent place.
fn int_operand_into_rd(code: &mut Vec<u8>, place: Place, rd: Reg, frame: Frame) -> Option<Reg> {
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let (sb, off) = spill_slot_addr(frame, slot);
            emit_mov_r_mem(code, rd, sb, off);
            Some(rd)
        }
        _ => None,
    }
}

/// Pick the working register a single-result int-producing handler
/// writes into: the allocator's chosen reg for `IntReg`, or
/// `SCRATCH_R10` for `Spill`. Other place kinds (FpReg, None) are
/// not legal for the handlers that call this helper.
fn int_or_spill_dst(dst: Place) -> Option<Reg> {
    match dst {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(SCRATCH_R10),
        _ => None,
    }
}

/// `(base, disp)` pair addressing allocator spill slot `slot`. Every
/// spill access routes through here so the dynamic-sp choice cannot be
/// bypassed. A static frame uses `[rsp + off]`; a dynamic-sp frame
/// (alloca / VLA) uses `[rbp + off - frame_bytes]`, the same byte,
/// since rsp no longer has a fixed relation to the slot once the body
/// moves it.
fn spill_slot_addr(frame: Frame, slot: u32) -> (Reg, i32) {
    spill_slot_addr_shifted(frame, slot, 0)
}

/// Like [`spill_slot_addr`], but for callers that temporarily pushed
/// rsp down by `sp_shift` bytes. The shift applies only to the
/// rsp-based form; the rbp-based form is immune to rsp moves.
///
/// The base offset: spill slot 0 sits at the top of the allocator-spill
/// region, slot N+1 eight bytes below slot N. The region lives at
/// `[rbp - alloc_spill_base .. - alloc_spill_bytes]` and rsp =
/// rbp - frame_bytes, so the slot is `frame_bytes - alloc_spill_base
/// - (N+1)*8` from rsp. Mirror of the aarch64 module's formula.
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

/// If `dst` is a `Spill` place, write the just-produced value in
/// `src` into the spill slot. No-op for register places (the
/// caller already wrote into the allocator's chosen reg).
fn spill_dst_to_slot(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let (sb, sp_off) = spill_slot_addr(frame, slot);
        emit_mov_mem_r(code, sb, sp_off, src);
    }
}

/// Read a value's `Place` into a usable register: returns the
/// allocator's chosen reg directly for `IntReg`, or loads the
/// spilled value into `scratch` and returns `scratch` for `Spill`.
/// Returns `None` for `FpReg` / `None` so the caller can bail.
fn materialize_int(code: &mut Vec<u8>, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    materialize_int_shifted(code, place, scratch, frame, 0)
}

/// Materialize up to two integer operands into distinct registers. A
/// register-resident operand keeps its register; a spilled operand is
/// loaded into one of the reserved scratch registers (`r10` / `r11`)
/// that holds no other operand. Both scratch registers sit outside the
/// allocator's pool, so loading a spilled operand cannot clobber an
/// allocated value. Returns `None` if an operand is neither a register
/// nor a spill slot.
fn materialize_int_operands_distinct(
    code: &mut Vec<u8>,
    places: &[Place],
    frame: Frame,
) -> Option<alloc::vec::Vec<Reg>> {
    let mut regs: alloc::vec::Vec<Option<Reg>> = alloc::vec![None; places.len()];
    let mut occupied = [false; 16];
    for (i, &p) in places.iter().enumerate() {
        match p {
            Place::IntReg(r) => {
                regs[i] = Some(Reg(r));
                occupied[r as usize] = true;
            }
            Place::Spill(_) => {}
            _ => return None,
        }
    }
    let pool = [SCRATCH_R10, SCRATCH_R11];
    for (i, &p) in places.iter().enumerate() {
        if regs[i].is_some() {
            continue;
        }
        let scratch = pool.iter().copied().find(|s| !occupied[s.0 as usize])?;
        occupied[scratch.0 as usize] = true;
        materialize_int(code, p, scratch, frame)?;
        regs[i] = Some(scratch);
    }
    Some(
        regs.into_iter()
            .map(|r| r.expect("operand register assigned"))
            .collect(),
    )
}

/// Like [`materialize_int`] but accounts for a temporary `rsp`
/// adjustment that hasn't been undone yet (e.g. the call-args
/// scratch frame). Spill offsets are computed from the
/// post-prologue rsp, so callers that pushed extra bytes on top
/// must pass that delta as `sp_shift` so the load reaches the
/// correct slot.
fn materialize_int_shifted(
    code: &mut Vec<u8>,
    place: Place,
    scratch: Reg,
    frame: Frame,
    sp_shift: u32,
) -> Option<Reg> {
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let (sb, sp_off) = spill_slot_addr_shifted(frame, slot, sp_shift);
            emit_mov_r_mem(code, scratch, sb, sp_off);
            Some(scratch)
        }
        Place::FpReg(r) => {
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
    imports: &'a super::ResolvedImports,
    variadic_targets: &'a alloc::collections::BTreeSet<usize>,
    /// Callee ent_pc -> the convention that callee declares, for the
    /// callees that declare one at all. Absent means the target's own.
    conv_targets: &'a alloc::collections::BTreeMap<usize, super::CallConv>,
    extern_tls_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    /// `Inst::ImmData` value-id -> cross-TU data symbol name, for an `i`-class
    /// inline-asm operand that names an external address, whether in a section
    /// field or via a `%a` address operand.
    extern_data_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    /// `Inst::ImmCode` value-id -> cross-TU function symbol name, for a `%c`
    /// function operand a replacement `call` / `jmp` in a section relocates
    /// against (`call %c[new]` in `.altinstr_replacement`).
    extern_code_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    tls_total_size: usize,
    param_from_home: &'a [bool],
    param_plan: &'a [super::ArgPlacement],
    /// Function name -> entry PC, for resolving an inline-asm `call`/`jmp` to a
    /// bare symbol into a relocation.
    name2entpc: &'a alloc::collections::BTreeMap<alloc::string::String, usize>,
}

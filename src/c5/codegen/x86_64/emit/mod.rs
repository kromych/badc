// x86_64 native emit over the SSA and the allocator output; the aarch64
// backend has the same shape with its own encodings and ABI rules.
//
// Per function: the prologue (frame, callee-saved registers, the argument
// registers spilled into the c5 cdecl cells the body addresses), each
// block in source order with its instructions and terminator, and the
// epilogue inline at every `Terminator::Return`.
//
// Frame layout, top to bottom:
//
// ```text
//   c5 cdecl param slots          [rbp + 16*i + 16]
//   saved rbp, ret address        [rbp]
//   locals area                   [rbp - locals_bytes .. rbp]
//   allocator spill slots         ...
//   over-aligned region           [rbp + align_region_off ..]  (16-mode only)
//   saved callee-saved GPRs       rsp
// ```
//
// [`emit_function`] returns an `Unsupported` when it meets a shape
// outside the implemented subset; `x86_64::lower` turns that into a
// compile error.

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
    Emit, MAX_UNPROBED_STACK_STEP, STACK_PROBE_PAGE, STACK_PROBE_UNROLL_MAX, Unsupported,
    build_arg_aggs, c5_slot_to_fp_offset, place_same_loc,
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

/// Scratch outside both allocator banks (`RegBanks::for_target`), so it
/// never aliases an allocated value; caller-saved, so reserving it costs
/// no prologue save.
const SCRATCH_R10: Reg = Reg(10);
/// Further scratches inside the allocator's `caller_gprs` pool: a handler
/// that uses one must check that no `rd` or operand place aliases it.
const SCRATCH_RCX: Reg = Reg(1);
const SCRATCH_RDX: Reg = Reg(2);
/// The second reserved scratch, outside both allocator banks like
/// `SCRATCH_R10`.
const SCRATCH_R11: Reg = Reg(11);

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

/// The working register of an int-producing handler: the allocated
/// register for `IntReg`, `SCRATCH_R10` for `Spill`.
fn int_or_spill_dst(dst: Place) -> Option<Reg> {
    match dst {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(SCRATCH_R10),
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

/// If `dst` is a `Spill` place, write the just-produced value in
/// `src` into the spill slot. No-op for register places (the
/// caller already wrote into the allocator's chosen reg).
fn spill_dst_to_slot(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let (sb, sp_off) = spill_slot_addr(frame, slot);
        emit_mov_mem_r(code, sb, sp_off, src);
    }
}

/// A value's `Place` in a register: `IntReg` in place, `Spill` loaded into
/// `scratch`; `None` for the other kinds.
fn materialize_int(code: &mut Vec<u8>, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    materialize_int_shifted(code, place, scratch, frame, 0)
}

/// Up to two integer operands in distinct registers: a register-resident
/// operand stays, a spilled one loads into whichever of r10 / r11 holds no
/// other operand. `None` when an operand is neither.
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

/// [`materialize_int`] for a caller that pushed rsp down by `sp_shift`
/// bytes since the prologue.
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

/// The output buffers a function's lowering appends to: the bundle shared
/// with the aarch64 backend and the x86_64-only vectors passed beside it.
struct Out<'a, 'b> {
    cx: &'b mut super::ssa::emit_common::EmitCtx<'a>,
    fixups: &'b mut Vec<Fixup>,
    asm_section_text_refs: &'b mut Vec<super::AsmSectionTextRef>,
    asm_text_abs_refs: &'b mut Vec<super::AsmTextAbsRef>,
    asm_text_labels: &'b mut Vec<super::AsmTextLabel>,
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
    text_align: usize,
    mcount_sites: usize,
    asm_section_text_refs: usize,
    asm_text_abs_refs: usize,
    asm_text_labels: usize,
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
            text_align: *self.cx.text_align,
            mcount_sites: self.cx.mcount_sites.len(),
            asm_section_text_refs: self.asm_section_text_refs.len(),
            asm_text_abs_refs: self.asm_text_abs_refs.len(),
            asm_text_labels: self.asm_text_labels.len(),
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
        *self.cx.text_align = m.text_align;
        self.cx.mcount_sites.truncate(m.mcount_sites);
        self.asm_section_text_refs.truncate(m.asm_section_text_refs);
        self.asm_text_abs_refs.truncate(m.asm_text_abs_refs);
        self.asm_text_labels.truncate(m.asm_text_labels);
    }
}

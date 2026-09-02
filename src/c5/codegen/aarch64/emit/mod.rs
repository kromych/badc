//! AArch64 native emit consuming the SSA + allocator output.
//! A per-function bail is a hard error -- the IR + emit contract
//! has to cover every shape the walker produces.
//!
//! ## Pass shape
//!
//! For each function:
//!
//! 1. Prologue: save fp / lr, set the frame pointer, reserve
//!    locals + allocator-spill bytes, save the callee-saved
//!    GPRs / FP regs the allocator reported as used, and spill
//!    the host-ABI argument registers into the c5 cdecl slots
//!    the body's `LocalAddr(>=2)` references.
//! 2. Walk each block in source order. Emit per-`Inst` native
//!    code in `inst_range`, then the terminator.
//! 3. Epilogue lands inline at every `Terminator::Return`: load
//!    the return value into x0, restore saved regs, drop the
//!    frame, `ret`.
//!
//! ## Frame layout (top -> bottom, growing down from caller's sp)
//!
//! ```text
//!   c5 cdecl param slots          [fp + 16*i]
//!   saved fp, saved lr            [fp +  0]
//!   locals area                   [fp - locals_bytes .. fp]
//!   allocator spill slots         ...
//!   over-aligned region           [fp + align_region_off ..]  (16-mode only)
//!   saved callee-saved GPRs
//!   saved callee-saved FP regs    sp
//! ```
//!
//! Each `Place::Spill(N)` reads / writes 8-byte slot N inside the
//! allocator spill region; the byte address is
//! `fp - frame.alloc_spill_base - (N+1)*8`.
//!
//! ## Coverage policy
//!
//! [`emit_function`] returns `true` when the SSA emit handled the
//! function end-to-end and `false` when any encountered op is
//! outside the implemented subset. The caller (`aarch64::lower`)
//! turns `false` into a hard compile error -- the IR + emit
//! contract has to cover every shape the walker produces.

#![allow(dead_code, clippy::too_many_arguments)]

use super::super::ir::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
use super::Target;
use super::encode::{
    BranchKind, Cond, Fixup, JB_D8_OFF, JB_PC_OFF, JB_SP_OFF, JB_X19_OFF, JB_X29_OFF, PltCallFixup,
    Reg, emit, emit_add_sp_imm, emit_mov_reg, emit_setjmp_aarch64, emit_sub_sp_imm, enc_add_imm,
    enc_add_reg, enc_adr, enc_adrp, enc_and_reg, enc_asrv, enc_b, enc_b_cond, enc_bl, enc_blr,
    enc_br, enc_cbnz, enc_cbz, enc_cinc, enc_cmp_reg, enc_cset, enc_eor_reg, enc_fadd_d,
    enc_fcmp_d, enc_fcmp_s, enc_fcvt_d_s, enc_fcvt_s_d, enc_fcvtzs_x_d, enc_fcvtzs_x_s,
    enc_fcvtzu_x_d, enc_fcvtzu_x_s, enc_fdiv_d, enc_fmov_d_to_x, enc_fmov_w_to_s, enc_fmov_x_to_d,
    enc_fmul_d, enc_fneg_d, enc_fsub_d, enc_ldaxr, enc_ldp_d_off, enc_ldp_d_post, enc_ldp_off,
    enc_ldp_post, enc_ldr_d_imm, enc_ldr_d_post, enc_ldr_imm, enc_ldr_post, enc_ldr_reg_lsl3,
    enc_ldr_s_imm, enc_ldr32_imm, enc_ldrb_imm, enc_ldrh_imm, enc_ldrsb_imm, enc_ldrsh_imm,
    enc_ldrsw_imm, enc_ldrsw_reg_lsl2, enc_lslv, enc_lsrv, enc_movz, enc_msub, enc_mul,
    enc_orr_reg, enc_ret, enc_scvtf_d_x, enc_scvtf_s_x, enc_sdiv, enc_stlxr, enc_stp_d_off,
    enc_stp_d_pre, enc_stp_off, enc_stp_pre, enc_str_d_imm, enc_str_d_pre, enc_str_imm,
    enc_str_pre, enc_str_s_imm, enc_str32_imm, enc_strb_imm, enc_strh_imm, enc_sub_imm,
    enc_sub_reg, enc_subs_imm, enc_ucvtf_d_x, enc_ucvtf_s_x, enc_udiv, load_imm64,
};
use super::ssa::emit_common::{
    MAX_UNPROBED_STACK_STEP, STACK_PROBE_PAGE, STACK_PROBE_UNROLL_MAX, build_arg_aggs,
    place_same_loc,
};
use super::ssa::reg_alloc::{Allocation, Place};
use super::{AddrPart, DataFixup};
use alloc::vec::Vec;

use super::*;

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

use arith::*;
use call::*;
use frame::*;
use function::*;
use inline_asm::*;
use inst::*;
use intrinsic::*;
use mem::*;

pub(crate) use arith::binop_imm_materializes;
pub(crate) use frame::{Frame, compute_frame};
pub(crate) use function::emit_function;
pub(super) use inline_asm::a64_align_asm_stream;
pub(crate) use inline_asm::encode_a64_file_asm_section_code;
pub(super) use mem::{NARROW_BORROW, emit_agg_load_int, enc_store_unit};

fn bail_msg(reason: &str) {
    super::ssa::emit_common::bail_msg("aarch64", reason);
}

fn bail(reason: &str, value: u32, place: Place) {
    #[cfg(feature = "codegen_test")]
    if std::env::var("BADC_DUMP_SSA").is_ok() {
        eprintln!(
            "ssa emit aarch64: bailed -- {reason} v{value} place={:?}",
            place
        );
    }
    let _ = (reason, value, place);
}

/// The allocator's location for `v`; `Place::None` for a value it never
/// placed.
pub(super) fn place_of(alloc: &Allocation, v: u32) -> Place {
    alloc.places.get(v as usize).copied().unwrap_or(Place::None)
}

//! x86_64 native emit consuming the SSA lift + allocator output.
//! Mirrors the aarch64 counterpart's structure; the difference is
//! the per-target instruction encodings and the SysV / Win64 ABI
//! shape applied to argument and return placement.
//!
//! ## Pass shape
//!
//! For each function:
//!
//! 1. Prologue: push rbp, set rbp = rsp, reserve locals + vstack +
//!    allocator-spill bytes, save the callee-saved GPRs the
//!    allocator reported as used, and spill the host-ABI arg
//!    registers into the c5 cdecl slots the body's
//!    `LocalAddr(>=2)` references.
//! 2. Walk each block in source order. Emit `VstackReload`s at
//!    block start, per-`Inst` native code in `inst_range`, then
//!    `VstackSpill`s, then the terminator.
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
//!   vstack spill slots            [rbp - locals_bytes - vstack_bytes .. ...]
//!   allocator spill slots         ...
//!   saved callee-saved GPRs       rsp
//! ```
//!
//! ## Coverage policy
//!
//! [`emit_function`] returns `true` when the SSA emit handled the
//! function end-to-end and `false` when any encountered op is
//! outside the implemented subset. The caller (`x86_64::lower`)
//! turns `false` into a hard compile error -- the IR + emit
//! contract has to cover every shape the lift produces.

#![allow(dead_code, clippy::too_many_arguments)]

use alloc::vec::Vec;

use super::DataFixup;
use super::GotFixup;
use super::Target;
use super::super::ir::{BinOp, FpCastKind, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
use super::ssa_alloc::{Allocation, Place};
use super::x86_64::{
    Cc, Fixup, PltCallFixup, Reg, emit_add_rr, emit_add_rsp_imm32, emit_addsd, emit_and_rr,
    emit_cmp_rr, emit_cvtsd2ss, emit_cvtsi2sd, emit_cvtss2sd, emit_cvttsd2si, emit_divsd,
    emit_imul_rr, emit_lea_r_mem, emit_mov_mem_r, emit_mov_r_imm64, emit_mov_r_mem, emit_mov_rr,
    emit_movapd_xmm_xmm, emit_movq_xmm_r, emit_movsd_mem_xmm, emit_movsd_xmm_mem,
    emit_movss_mem_xmm, emit_movss_xmm_mem, emit_movsx_r_mem16, emit_movsxd_r_mem,
    emit_movzx_r_mem16, emit_movzx_r_r8, emit_mulsd, emit_or_rr, emit_pop_r, emit_push_r, emit_ret,
    emit_sar_r_cl, emit_setcc_r8, emit_shl_r_cl, emit_shr_r_cl, emit_sub_rr, emit_sub_rsp_imm32,
    emit_subsd, emit_ucomisd, emit_xor_rr, emit_xorpd,
};

/// Per-function frame layout. Bytes are 16-aligned at every
/// region boundary so SysV / Win64's sp-at-call invariant holds.
#[derive(Debug, Clone, Copy)]
pub(super) struct Frame {
    pub frame_bytes: u32,
    pub acc_slot_off: u32,
    pub alloc_spill_base: u32,
}

impl Frame {
    pub fn for_function(func: &FunctionSsa, alloc: &Allocation) -> Self {
        let locals_bytes = ((func.locals.max(0) as u32) * 8 + 15) & !15;
        let vstack_bytes = (func.vstack_slots * 8 + 15) & !15;
        let acc_bytes = 16u32;
        let alloc_spill_bytes = (alloc.spill_count * 8 + 15) & !15;
        let saved_gpr_bytes = ((alloc.gpr_used.len() as u32) * 8 + 15) & !15;
        let frame_bytes =
            locals_bytes + vstack_bytes + acc_bytes + alloc_spill_bytes + saved_gpr_bytes;
        Self {
            frame_bytes,
            acc_slot_off: locals_bytes + vstack_bytes + 8,
            alloc_spill_base: locals_bytes + vstack_bytes + acc_bytes,
        }
    }
}

fn bail_msg(reason: &str) {
    super::ssa_emit_common::bail_msg("x86_64", reason);
}

/// Extract the int reg from a `Place`, or `None` if it's not an
/// integer register.
fn int_reg(place: Place) -> Option<Reg> {
    place.int_reg_u8().map(Reg)
}

/// Scratch register for handlers whose dst is a spill: r10 is
/// caller-saved on SysV / Win64 and is excluded from the SSA
/// allocator's caller_gprs pool (which is `[rax, r11]` on x86_64),
/// so reusing it across an instruction can never clobber a value
/// the allocator chose.
const SCRATCH_R10: Reg = Reg(10);
/// Secondary / tertiary int scratches for ops that need more than
/// one. rcx and rdx are caller-saved on SysV and excluded from the
/// allocator's `caller_gprs` pool (`[rax, r11]`), so they can be
/// clobbered freely between insts without colliding with allocator-
/// held values. Used by emit handlers that work over a base, an
/// index, and a value (indexed stores) where one register isn't
/// enough.
const SCRATCH_RCX: Reg = Reg(1);
const SCRATCH_RDX: Reg = Reg(2);

/// Scratch XMM registers for FP handlers. The SSA allocator's
/// caller_fprs pool covers `xmm0..xmm7` and callee_fprs is empty
/// on SysV (no callee-saved xmm), so any allocator-held FP value
/// lives in xmm0..xmm7. xmm14 / xmm15 sit outside both banks and
/// stay free as primary / secondary scratches.
const SCRATCH_XMM14: Reg = Reg(14);
const SCRATCH_XMM15: Reg = Reg(15);

/// Extract the FP reg from a `Place`, or `None` if it's not an
/// xmm register.
fn fp_reg(place: Place) -> Option<Reg> {
    place.fp_reg_u8().map(Reg)
}

/// Pick the working xmm a single-result FP-producing handler writes
/// into: the allocator's chosen reg for `FpReg`, or `SCRATCH_XMM14`
/// for `Spill`. Other place kinds (`IntReg`, `None`) are not legal
/// for the FP handlers.
fn fp_or_spill_dst(dst: Place) -> Option<Reg> {
    match dst {
        Place::FpReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(SCRATCH_XMM14),
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
            let sp_off = spill_slot_sp_offset(frame, slot) + sp_shift as i32;
            emit_movsd_xmm_mem(code, scratch, Reg::RSP, sp_off);
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
        let sp_off = spill_slot_sp_offset(frame, slot);
        emit_movsd_mem_xmm(code, Reg::RSP, sp_off, src);
    }
}

/// Map an FP arithmetic [`BinOp`] to its SSE2 encoder. Returns
/// `None` for any non-FP-arith op.
fn fp_arith_enc(op: BinOp) -> Option<fn(&mut Vec<u8>, Reg, Reg)> {
    Some(match op {
        BinOp::Fadd => emit_addsd,
        BinOp::Fsub => emit_subsd,
        BinOp::Fmul => emit_mulsd,
        BinOp::Fdiv => emit_divsd,
        _ => return None,
    })
}

/// How a `setcc` result needs to be combined with the parity flag
/// for the IEEE-754 NaN semantics required by C99 6.5.9 / 6.5.8.
/// `ucomisd` sets ZF=PF=CF=1 on an unordered (NaN) comparison;
/// a bare `setcc` on Cc::B / Cc::E / Cc::Be / Cc::Ne would then
/// disagree with `!(NaN < x)` / `(NaN != x)`.
#[derive(Clone, Copy)]
enum FpCmpNanFix {
    /// CC already evaluates to 0 on an unordered compare (Cc::A
    /// and Cc::Ae both require CF=0, which NaN never satisfies).
    None,
    /// AND with `setnp` (PF=0) to clear the result when NaN.
    /// Used by `==`, `<`, `<=` per C99 6.5.9p3 / 6.5.8p6.
    AndNotP,
    /// OR with `setp` (PF=1) so the result is 1 on NaN. Used by
    /// `!=` per C99 6.5.9p3.
    OrP,
}

/// Map an FP comparison [`BinOp`] to the x86_64 condition code the
/// matching `ucomisd` + `setcc` pair should use plus the NaN-fix
/// needed after the `setcc`. Returns `None` for any non-FP-compare
/// op. Mirrors the pool path's `emit_fp_cmp` / `emit_fp_cmp_ordered`
/// / `emit_fp_cmp_ne` split in `super::x86_64`.
fn fp_compare_cc(op: BinOp) -> Option<(Cc, FpCmpNanFix)> {
    Some(match op {
        BinOp::Feq => (Cc::E, FpCmpNanFix::AndNotP),
        BinOp::Fne => (Cc::Ne, FpCmpNanFix::OrP),
        BinOp::Flt => (Cc::B, FpCmpNanFix::AndNotP),
        BinOp::Fgt => (Cc::A, FpCmpNanFix::None),
        BinOp::Fle => (Cc::Be, FpCmpNanFix::AndNotP),
        BinOp::Fge => (Cc::Ae, FpCmpNanFix::None),
        _ => return None,
    })
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

/// Byte offset from rsp of allocator spill slot `slot`. Spill
/// slot 0 sits at the top of the allocator-spill region (next to
/// the accumulator slot); slot N+1 sits 8 bytes below slot N. The
/// region itself lives at `[rbp - alloc_spill_base ..
/// rbp - alloc_spill_base - alloc_spill_bytes]`, and rsp =
/// rbp - frame_bytes, so a slot at `rbp - alloc_spill_base
/// - (N+1)*8` is `frame_bytes - alloc_spill_base - (N+1)*8` from
/// rsp. Mirror of the aarch64 module's formula.
fn spill_slot_sp_offset(frame: Frame, slot: u32) -> i32 {
    super::ssa_emit_common::spill_slot_sp_offset(frame.frame_bytes, frame.alloc_spill_base, slot)
        as i32
}

/// If `dst` is a `Spill` place, write the just-produced value in
/// `src` into the spill slot. No-op for register places (the
/// caller already wrote into the allocator's chosen reg).
fn spill_dst_to_slot(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let sp_off = spill_slot_sp_offset(frame, slot);
        emit_mov_mem_r(code, Reg::RSP, sp_off, src);
    }
}

/// Read a value's `Place` into a usable register: returns the
/// allocator's chosen reg directly for `IntReg`, or loads the
/// spilled value into `scratch` and returns `scratch` for `Spill`.
/// Returns `None` for `FpReg` / `None` so the caller can bail.
fn materialize_int(code: &mut Vec<u8>, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    materialize_int_shifted(code, place, scratch, frame, 0)
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
            let sp_off = spill_slot_sp_offset(frame, slot) + sp_shift as i32;
            emit_mov_r_mem(code, scratch, Reg::RSP, sp_off);
            Some(scratch)
        }
        Place::FpReg(r) => {
            // Reinterpret the xmm-resident f64 as its 8-byte bit
            // pattern via `movq scratch, xmm[r]`. Used at c5-internal
            // call sites that route every argument through the
            // integer arg bank (the callee's prologue spills only
            // int_arg_regs into the c5 cdecl slots).
            super::x86_64::emit_movq_r_xmm(code, scratch, Reg(r));
            Some(scratch)
        }
        Place::None => None,
    }
}

/// Marshal one int argument into the placement chosen by the
/// shared `plan_call_args`. Spilled arg values are loaded into
/// the destination arg-reg directly, or via r10 for stack slots.
/// `scratch_bytes` is the rsp adjustment the caller already made
/// for the call's stack scratch frame; the helper threads it
/// into the spill-slot offset so the load reaches the right slot
/// despite the moved rsp.
fn marshal_int_arg(
    code: &mut Vec<u8>,
    arg_place: Place,
    placement: super::ArgPlacement,
    frame: Frame,
    scratch_bytes: u32,
    site: &str,
) -> bool {
    match placement {
        super::ArgPlacement::IntReg(r) => {
            let src = match materialize_int_shifted(code, arg_place, Reg(r), frame, scratch_bytes) {
                Some(s) => s,
                None => {
                    bail_msg(&alloc::format!("{site}: int arg not in int reg / spill"));
                    return false;
                }
            };
            if src.0 != r {
                emit_mov_rr(code, Reg(r), src);
            }
            true
        }
        super::ArgPlacement::Stack(off) => {
            let src =
                match materialize_int_shifted(code, arg_place, SCRATCH_R10, frame, scratch_bytes) {
                    Some(s) => s,
                    None => {
                        bail_msg(&alloc::format!("{site}: stack arg not in int reg / spill"));
                        return false;
                    }
                };
            emit_mov_mem_r(code, Reg::RSP, off as i32, src);
            true
        }
        super::ArgPlacement::FpReg(r) => {
            // SysV / Win64 routes f64 args through xmm0..xmm7.
            // Materialize the value into the destination xmm
            // directly when possible; route a spill or an int-reg
            // f64 bit pattern through the scratch first.
            let src = match materialize_fp_shifted(code, arg_place, Reg(r), frame, scratch_bytes) {
                Some(s) => s,
                None => {
                    bail_msg(&alloc::format!(
                        "{site}: fp arg not in fp reg / spill / int reg"
                    ));
                    return false;
                }
            };
            if src.0 != r {
                emit_movapd_xmm_xmm(code, Reg(r), src);
            }
            true
        }
    }
}

/// Public entry point. Returns `true` when every block + inst +
/// terminator was lowered. Returns `false` (with `code`
/// truncated back to the pre-attempt snapshot) when the function
/// contains an op outside the implemented subset. The handler
/// set is intentionally minimal at this stage; the aarch64 SSA
/// emit grew bottom-up from the same shape and the x86_64 path
/// follows that trajectory.
pub(super) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    code: &mut Vec<u8>,
    fixups: &mut Vec<Fixup>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    _got_fixups: &mut Vec<GotFixup>,
    data_fixups: &mut Vec<DataFixup>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    tls_total_size: usize,
    bytecode_to_native: &mut [usize],
) -> bool {
    let snapshot = code.len();
    let fixups_snapshot = fixups.len();
    let plt_call_fixups_snapshot = plt_call_fixups.len();
    let data_fixups_snapshot = data_fixups.len();
    let pending_func_fixups_snapshot = pending_func_fixups.len();
    let frame = Frame::for_function(func, alloc);
    let abi = target.abi();

    emit_prologue(code, func, alloc, frame, abi);
    super::ssa_emit_common::record_post_prologue_pc(func, bytecode_to_native, code.len());

    let mut block_offsets: Vec<usize> = alloc::vec![0; func.blocks.len()];
    let mut branch_fixups: Vec<BranchFixup> = Vec::new();
    // Set by `Inst::AllocaInit` (slot != 0) and read by the
    // matching `Inst::Intrinsic(Alloca)`. Zero means the
    // function doesn't use alloca.
    let mut current_alloca_top: u32 = 0;

    for (block_idx, block) in func.blocks.iter().enumerate() {
        block_offsets[block_idx] = code.len();
        super::ssa_emit_common::record_block_start_pc(
            block_idx,
            block.start_pc,
            bytecode_to_native,
            code.len(),
        );
        for v in block.inst_range.clone() {
            let inst = &func.insts[v as usize];
            let place = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
            if !emit_inst(
                code,
                inst,
                place,
                alloc,
                frame,
                abi,
                target,
                fixups,
                plt_call_fixups,
                data_fixups,
                pending_func_fixups,
                imports,
                variadic_targets,
                tls_index_fixups,
                tls_total_size,
                &mut current_alloca_top,
            ) {
                #[cfg(feature = "std")]
                if std::env::var("BADC_DUMP_SSA").is_ok() {
                    eprintln!(
                        "ssa emit x86_64: bailed on inst v{v}: {:?} (place {:?})",
                        inst, place,
                    );
                }
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                return false;
            }
        }
        match block.terminator {
            Terminator::Return(v) => emit_return(code, v, alloc, frame, func),
            Terminator::Jmp(t) => {
                branch_fixups.push(BranchFixup {
                    site: code.len() + 1, // rel32 follows the 1-byte opcode
                    target: t,
                    kind: LocalBranchKind::Jmp,
                });
                super::x86_64::emit_jmp_rel32(code, 0);
            }
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => {
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                let Some(rc) = materialize_int(code, cond_place, SCRATCH_R10, frame) else {
                    bail_msg("Bz: cond Place not int reg / spill / fp");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    return false;
                };
                // `cmp rc, 0` sets ZF=1 iff rc==0; je takes the
                // branch on ZF=1.
                super::x86_64::emit_cmp_r_imm32(code, rc, 0);
                branch_fixups.push(BranchFixup {
                    site: code.len() + 2, // 0x0F 0x8x + rel32
                    target,
                    kind: LocalBranchKind::Jcc(Cc::E),
                });
                super::x86_64::emit_jcc_rel32(code, Cc::E, 0);
                if fall_through as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len() + 1,
                        target: fall_through,
                        kind: LocalBranchKind::Jmp,
                    });
                    super::x86_64::emit_jmp_rel32(code, 0);
                }
            }
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => {
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                let Some(rc) = materialize_int(code, cond_place, SCRATCH_R10, frame) else {
                    bail_msg("Bnz: cond Place not int reg / spill / fp");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    return false;
                };
                super::x86_64::emit_cmp_r_imm32(code, rc, 0);
                branch_fixups.push(BranchFixup {
                    site: code.len() + 2,
                    target,
                    kind: LocalBranchKind::Jcc(Cc::Ne),
                });
                super::x86_64::emit_jcc_rel32(code, Cc::Ne, 0);
                if fall_through as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len() + 1,
                        target: fall_through,
                        kind: LocalBranchKind::Jmp,
                    });
                    super::x86_64::emit_jmp_rel32(code, 0);
                }
            }
            Terminator::FallThrough(t) => {
                if t as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len() + 1,
                        target: t,
                        kind: LocalBranchKind::Jmp,
                    });
                    super::x86_64::emit_jmp_rel32(code, 0);
                }
            }
            Terminator::TailExt(binding_idx) => {
                // c5 emits `Op::TailExt` for the sys-trampoline
                // bodies: the matching `Op::Jsri` already placed
                // every arg in the host ABI's argument registers
                // / shadow-space slots, so we just forward control
                // through the PLT trampoline and let the libc fn's
                // `ret` carry us back to the original caller.
                let import_index = match imports.index_of_binding(binding_idx) {
                    Some(i) => i,
                    None => {
                        bail_msg("TailExt: no import slot for binding");
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        return false;
                    }
                };
                plt_call_fixups.push(PltCallFixup {
                    instr_offset: code.len(),
                    import_index,
                    is_tail: true,
                });
                super::x86_64::emit_jmp_rel32(code, 0);
            }
        }
    }
    // Patch recorded branches. `site` is the byte offset of the
    // first rel32 byte; rel32 is computed from the byte *after*
    // the rel32 field (which on x86_64 is `site + 4`).
    for fx in &branch_fixups {
        let target_off = block_offsets[fx.target as usize];
        let next_pc = fx.site + 4;
        let rel = (target_off as i64) - (next_pc as i64);
        let imm = match i32::try_from(rel) {
            Ok(v) => v,
            Err(_) => {
                bail_msg("branch fixup: rel32 out of range");
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                return false;
            }
        };
        let bytes = imm.to_le_bytes();
        code[fx.site..fx.site + 4].copy_from_slice(&bytes);
        let _ = fx.kind;
    }

    true
}

#[derive(Debug, Clone, Copy)]
struct BranchFixup {
    /// Byte offset of the rel32 field in `code`.
    site: usize,
    target: super::super::ir::BlockId,
    kind: LocalBranchKind,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum LocalBranchKind {
    Jmp,
    Jcc(Cc),
}

/// Spill the host-ABI argument registers into the c5 cdecl slots
/// the body references via `Op::Lea N` (`N >= 2`). c5 places the
/// first declared parameter at `[rbp + 16]`, the second at
/// `[rbp + 32]`, etc. AMD64 SysV / Win64 push the return address
/// before `call`, so the prologue needs to interleave the saved
/// rbp with the param slots: pop the return address into r11,
/// push each arg in caller order, push the return address back,
/// then save rbp and proceed.
fn emit_prologue(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) {
    // Host-arg-reg spill. Skipped for variadic functions; the
    // pool path's same prologue does this too. Mirrors the
    // x86_64 pool emit_prologue's shape.
    let entry_spill = if func.is_variadic { 0 } else { func.n_params };
    if entry_spill > 0 {
        emit_pop_r(code, Reg::R10);
        let n_reg = entry_spill.min(abi.int_arg_regs.len());
        let n_stack = entry_spill - n_reg;
        if n_stack > 0 {
            // Reserve every overflow c5 slot in one sub, then
            // copy each host-stack overflow arg into its 16-byte
            // c5 cdecl slot. `host_off` reads the caller-supplied
            // 8-byte-stride argument bank that the `pop r10`
            // above already stripped of the return address.
            let overflow_bytes = (n_stack as u32) * 16;
            emit_sub_rsp_imm32(code, overflow_bytes);
            for i in 0..n_stack {
                let host_off = (overflow_bytes as i32) + (abi.shadow_space as i32) + (i as i32) * 8;
                emit_mov_r_mem(code, Reg::RAX, Reg::RSP, host_off);
                emit_mov_mem_r(code, Reg::RSP, (i as i32) * 16, Reg::RAX);
            }
        }
        for i in (0..n_reg).rev() {
            emit_sub_rsp_imm32(code, 16);
            emit_mov_mem_r(code, Reg::RSP, 0, Reg(abi.int_arg_regs[i]));
        }
        emit_push_r(code, Reg::R10);
    }

    // Standard frame: push rbp; mov rbp, rsp; sub rsp, frame_bytes.
    emit_push_r(code, Reg::RBP);
    emit_mov_rr(code, Reg::RBP, Reg::RSP);
    if frame.frame_bytes > 0 {
        emit_sub_rsp_imm32(code, frame.frame_bytes);
    }
    // Save callee-saved GPRs the allocator reported as used. We
    // keep them at the bottom of the frame at sp + saved_fpr_bytes
    // (= 0 on x86_64 since the allocator's fp pool is xmm-only).
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = (i as i32) * 8;
        super::x86_64::emit_mov_mem_r(code, Reg::RSP, off, Reg(r));
    }
}

fn emit_inst(
    code: &mut Vec<u8>,
    inst: &Inst,
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    target: Target,
    fixups: &mut Vec<Fixup>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    data_fixups: &mut Vec<DataFixup>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    tls_total_size: usize,
    current_alloca_top: &mut u32,
) -> bool {
    match inst {
        Inst::AllocaInit(slot) => {
            // Slot 0: this function doesn't use alloca; emit
            // nothing (matches the pool path). Non-zero: the
            // bookkeeping slot lives at `[rbp - slot*8]`; the
            // matching `Op::Intrinsic(Alloca)` reads + writes it
            // to allocate from a per-frame arena. Initialise the
            // slot with its own address so `alloca(n)` lands at
            // `address - n`, the top of the arena `Op::Ent` already
            // reserved.
            if *slot == 0 {
                return true;
            }
            let top_offset = (*slot as u32) * 8;
            *current_alloca_top = top_offset;
            let disp = -(top_offset as i32);
            emit_lea_r_mem(code, SCRATCH_R10, Reg::RBP, disp);
            emit_mov_mem_r(code, SCRATCH_R10, 0, SCRATCH_R10);
            true
        }
        Inst::Imm(value) => {
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("Imm: dst not int reg / spill");
                return false;
            };
            emit_mov_r_imm64(code, rd, *value);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        Inst::LocalAddr(off) => {
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("LocalAddr: dst not int reg / spill");
                return false;
            };
            // c5 cdecl: param i (i >= 2) sits at [rbp + 16*(i-1)];
            // locals (i < 0) sit at [rbp + 8*i]. Compute the byte
            // offset and emit `lea rd, [rbp + disp]`. The 32-bit
            // signed `disp` covers any frame our compiler emits;
            // larger frames bail.
            let bytes = c5_slot_to_fp_offset(*off);
            let disp = match i32::try_from(bytes) {
                Ok(d) => d,
                Err(_) => {
                    bail_msg("LocalAddr: offset doesn't fit in disp32");
                    return false;
                }
            };
            emit_lea_r_mem(code, rd, Reg::RBP, disp);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        Inst::Load { addr, kind } => emit_load(code, dst, *addr, *kind, alloc, frame),
        Inst::Store { addr, value, kind } => {
            emit_store(code, dst, *addr, *value, *kind, alloc, frame)
        }
        Inst::LoadLocal { off, kind } => emit_load_local(code, dst, *off, *kind, frame),
        Inst::StoreLocal { off, value, kind } => {
            emit_store_local(code, dst, *off, *value, *kind, alloc, frame)
        }
        Inst::LoadIndexed {
            base,
            index,
            scale,
            kind,
        } => emit_load_indexed(code, dst, *base, *index, *scale, *kind, alloc, frame),
        Inst::StoreIndexed {
            base,
            index,
            scale,
            value,
            kind,
        } => emit_store_indexed(code, dst, *base, *index, *scale, *value, *kind, alloc, frame),
        Inst::Binop { op, lhs, rhs } => emit_binop(code, *op, dst, *lhs, *rhs, alloc, frame),
        Inst::BinopI { op, lhs, rhs_imm } => {
            emit_binop_imm(code, *op, dst, *lhs, *rhs_imm, alloc, frame)
        }
        Inst::Call { target_pc, args } => emit_call(
            code,
            dst,
            *target_pc,
            args,
            alloc,
            frame,
            abi,
            fixups,
            variadic_targets.contains(target_pc),
        ),
        Inst::CallExt {
            binding_idx,
            args,
            fp_arg_mask,
        } => emit_call_ext(
            code,
            dst,
            *binding_idx,
            args,
            *fp_arg_mask,
            alloc,
            frame,
            abi,
            target,
            plt_call_fixups,
            imports,
        ),
        Inst::ImmData(offset) => emit_imm_data(code, dst, *offset, data_fixups, frame),
        Inst::ImmCode(target_bc_pc) => {
            emit_imm_code(code, dst, *target_bc_pc, pending_func_fixups, frame)
        }
        Inst::VstackSpill { slot, value } => emit_vstack_spill(code, *slot, *value, alloc, frame),
        Inst::VstackReload { slot } => emit_vstack_reload(code, dst, *slot, frame),
        Inst::Mcpy {
            dst: d,
            src: s,
            size,
        } => emit_mcpy(code, dst, *d, *s, *size, alloc, frame),
        Inst::CallIndirect { target, args } => {
            emit_call_indirect(code, dst, *target, args, alloc, frame, abi)
        }
        Inst::Intrinsic { kind, args } => {
            emit_intrinsic(code, *kind, args, dst, alloc, frame, *current_alloca_top)
        }
        Inst::AccSpill { value } => {
            let value_place = alloc
                .places
                .get(*value as usize)
                .copied()
                .unwrap_or(Place::None);
            let sp_off = (frame.frame_bytes - frame.acc_slot_off) as i32;
            let rs = match value_place {
                Place::IntReg(r) => Reg(r),
                Place::Spill(_) => {
                    // Source already spilled. Load into SCRATCH_R10
                    // and then store to the acc slot.
                    let Some(r) = materialize_int(code, value_place, SCRATCH_R10, frame) else {
                        bail_msg("AccSpill: value materialize failed");
                        return false;
                    };
                    r
                }
                Place::FpReg(r) => {
                    // f64 bit pattern lives in xmm[r]; movq into the
                    // acc slot via SCRATCH_R10.
                    super::x86_64::emit_movq_r_xmm(code, SCRATCH_R10, Reg(r));
                    SCRATCH_R10
                }
                Place::None => {
                    bail_msg("AccSpill: value Place::None");
                    return false;
                }
            };
            emit_mov_mem_r(code, Reg::RSP, sp_off, rs);
            true
        }
        Inst::AccReload => {
            let sp_off = (frame.frame_bytes - frame.acc_slot_off) as i32;
            match dst {
                Place::IntReg(r) => {
                    emit_mov_r_mem(code, Reg(r), Reg::RSP, sp_off);
                    true
                }
                Place::Spill(_) => {
                    // Reload via SCRATCH_R10, then store to dst's
                    // spill slot.
                    emit_mov_r_mem(code, SCRATCH_R10, Reg::RSP, sp_off);
                    spill_dst_to_slot(code, dst, SCRATCH_R10, frame);
                    true
                }
                Place::FpReg(r) => {
                    // Acc slot holds an integer-encoded bit pattern;
                    // reinterpret into xmm[r] via movq.
                    emit_mov_r_mem(code, SCRATCH_R10, Reg::RSP, sp_off);
                    super::x86_64::emit_movq_xmm_r(code, Reg(r), SCRATCH_R10);
                    true
                }
                Place::None => true,
            }
        }
        Inst::Fneg(value) => emit_fneg(code, dst, *value, alloc, frame),
        Inst::FpCast { kind, value } => emit_fp_cast(code, dst, *kind, *value, alloc, frame),
        Inst::TlsAddr(offset) => emit_tls_addr(
            code,
            dst,
            *offset,
            target,
            tls_index_fixups,
            tls_total_size,
            frame,
        ),
        _ => {
            bail_msg("inst variant not yet covered");
            let _ = frame;
            false
        }
    }
}

/// `Op::TlsLea` lowering. Routes through the per-target TLS
/// access shape. Linux variant-2 layout: `var = fs:[0] - (tls_total
/// - offset)`. The Windows path mirrors the pool emit -- TEB
/// `gs:[0x58]` table indexed by `_tls_index` plus a final `lea` --
/// and pushes the writer fixup so the linker can patch the
/// `_tls_index` slot's RVA.
fn emit_tls_addr(
    code: &mut Vec<u8>,
    dst: Place,
    offset: i64,
    target: Target,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    tls_total_size: usize,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("TlsAddr: dst not int reg / spill");
        return false;
    };
    match target {
        Target::LinuxX64 => {
            let tpoff = (tls_total_size as i64) - offset;
            if !(0..=i32::MAX as i64).contains(&tpoff) {
                bail_msg("TlsAddr: tpoff out of i32 range");
                return false;
            }
            // mov rd, qword ptr fs:[0]
            //   FS prefix 64; REX.W=1, REX.R = (rd >= 8);
            //   opcode 8B; ModR/M mod=00 reg=rd.lo rm=100 (SIB);
            //   SIB scale=00 index=100 (none) base=101 (disp32);
            //   disp32 = 0.
            let rex = 0x48 | (((rd.0 >> 3) & 1) << 2);
            code.push(0x64);
            code.push(rex);
            code.push(0x8B);
            code.push(0x04 | ((rd.0 & 7) << 3));
            code.push(0x25);
            code.extend_from_slice(&0u32.to_le_bytes());
            // sub rd, imm32
            //   REX.W=1, REX.B = (rd >= 8);
            //   opcode 81 /5;
            //   ModR/M mod=11 reg=5 rm=rd.lo;
            //   imm32 = tpoff.
            let rex_sub = 0x48 | ((rd.0 >> 3) & 1);
            code.push(rex_sub);
            code.push(0x81);
            code.push(0xE8 | (rd.0 & 7));
            code.extend_from_slice(&(tpoff as i32).to_le_bytes());
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        Target::WindowsX64 => {
            if !(i32::MIN as i64..=i32::MAX as i64).contains(&offset) {
                bail_msg("TlsAddr: offset out of i32 range");
                return false;
            }
            // PE/x86_64 TLS reads gs:[0x58] (the TEB) for the TLS
            // array, indexes it by `_tls_index`, and adds the
            // per-variable offset. The SSA allocator's pool covers
            // rax + r11; the pool emitter's open-coded sequence
            // uses rax + rcx as scratches, both reachable for the
            // allocator. Use SCRATCH_R10 (r10, outside the pool)
            // for the TEB pointer and `rd` itself for the index
            // load -- the index is only live across one mov so
            // reusing the destination is safe.
            //
            // mov r10, gs:[0x58]           ; TEB
            // mov rd_w, [rip+disp32]       ; _tls_index slot
            //                              ;   (zero-extends to rd)
            // mov r10, [r10 + rd*8]        ; tls_array[idx]
            // lea rd, [r10 + offset]
            code.extend_from_slice(&[0x65, 0x4C, 0x8B, 0x14, 0x25, 0x58, 0, 0, 0]);
            // mov rd.lo_dword, [rip+disp32]:
            //   REX.R = (rd >= 8); opcode 8B;
            //   ModR/M mod=00 reg=rd.lo rm=101 (rip-relative);
            //   disp32 = 0 (patched).
            let rex_idx = if rd.0 >= 8 { 0x44 } else { 0x00 };
            if rex_idx != 0 {
                code.push(rex_idx);
            }
            // The writer's TLS-index fixup patches the 4-byte
            // displacement at `instr_offset + 2`. With a REX
            // prefix the disp32 lives at `instr_offset + 3` if
            // we anchor to the REX, so anchor to the opcode byte
            // instead -- `instr_offset + 2` then lands on the
            // disp32 regardless of whether a REX was emitted.
            let mov_idx_offset = code.len();
            code.push(0x8B);
            code.push(0x05 | ((rd.0 & 7) << 3));
            code.extend_from_slice(&0i32.to_le_bytes());
            tls_index_fixups.push(super::TlsIndexFixup {
                instr_offset: mov_idx_offset,
            });
            // mov r10, [r10 + rd*8]:
            //   REX = 0x4D | (rd.high ? 0x02 : 0)  (W=1, R=1 to
            //                                       reach r10 dest,
            //                                       X = rd>=8,
            //                                       B=1 for r10 base)
            //   opcode 8B; ModR/M mod=00 reg=010 (r10.lo)
            //                       rm=100 (SIB);
            //   SIB scale=11 (*8), index=rd.lo, base=010 (r10.lo).
            let rex_idx_sib = 0x4D | (if rd.0 >= 8 { 0x02 } else { 0 });
            code.push(rex_idx_sib);
            code.push(0x8B);
            code.push(0x14);
            code.push(0xC2 | ((rd.0 & 7) << 3));
            // lea rd, [r10 + offset]:
            //   REX.W=1, REX.R = (rd >= 8), REX.B=1 (r10 base);
            //   opcode 8D;
            //   ModR/M mod=10 (disp32), reg=rd.lo, rm=010 (r10).
            let rex_lea = 0x49 | (if rd.0 >= 8 { 0x04 } else { 0 });
            code.push(rex_lea);
            code.push(0x8D);
            code.push(0x82 | ((rd.0 & 7) << 3));
            code.extend_from_slice(&(offset as i32).to_le_bytes());
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        _ => {
            bail_msg("TlsAddr: target not x86_64");
            false
        }
    }
}

use super::ssa_emit_common::c5_slot_to_fp_offset;

/// Single-instruction rbp-relative load for the lift's fused
/// `Inst::LoadLocal`. The c5 slot offset folds into the load's
/// ModR/M disp directly, skipping the `LocalAddr`
/// materialisation the `LocalAddr` + `Load` pair would have
/// required. The lift only emits LoadLocal with `kind = I64`
/// (`Op::LdLocI`); other widths stay on the unfused
/// `LocalAddr` + `Load` path and never reach this helper.
fn emit_load_local(code: &mut Vec<u8>, dst: Place, off: i64, kind: LoadKind, frame: Frame) -> bool {
    let disp = match i32::try_from(c5_slot_to_fp_offset(off)) {
        Ok(v) => v,
        Err(_) => {
            bail_msg("LoadLocal: offset doesn't fit in disp32");
            return false;
        }
    };
    if matches!(kind, LoadKind::F32) {
        let dd = match fp_or_spill_dst(dst) {
            Some(r) => r,
            None => {
                bail_msg("LoadLocal F32: dst not fp reg / spill");
                return false;
            }
        };
        emit_movss_xmm_mem(code, dd, Reg::RBP, disp);
        emit_cvtss2sd(code, dd, dd);
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("LoadLocal: dst not int reg / spill");
        return false;
    };
    match kind {
        LoadKind::I64 => emit_mov_r_mem(code, rd, Reg::RBP, disp),
        LoadKind::I32 => emit_movsxd_r_mem(code, rd, Reg::RBP, disp),
        LoadKind::U32 => super::x86_64::emit_mov_r32_mem(code, rd, Reg::RBP, disp),
        LoadKind::I16 => emit_movsx_r_mem16(code, rd, Reg::RBP, disp),
        LoadKind::U16 => emit_movzx_r_mem16(code, rd, Reg::RBP, disp),
        LoadKind::I8 => super::x86_64::emit_movsx_r_mem8(code, rd, Reg::RBP, disp),
        LoadKind::U8 => super::x86_64::emit_movzx_r_mem8(code, rd, Reg::RBP, disp),
        LoadKind::F32 => unreachable!(),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Single-instruction rbp-relative store for the lift's fused
/// `Inst::StoreLocal`. Mirrors [`emit_load_local`]; the c5 store
/// ops leave the stored value in the accumulator, so the
/// destination `Place` receives a copy after the store lands.
fn emit_store_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if !matches!(kind, StoreKind::I64) {
        bail_msg("StoreLocal: only I64 supported");
        return false;
    }
    let disp = match i32::try_from(c5_slot_to_fp_offset(off)) {
        Ok(v) => v,
        Err(_) => {
            bail_msg("StoreLocal: offset doesn't fit in disp32");
            return false;
        }
    };
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    // c5 spills an FP-typed accumulator into a local temp via
    // `Op::StLocI` (the bit pattern fits 8 bytes either way), so
    // an FpReg value bridges through `movq r, xmm` into a GPR
    // before the store; otherwise it routes through the normal
    // int materialisation.
    let rv = if let Place::FpReg(xr) = value_place {
        super::x86_64::emit_movq_r_xmm(code, SCRATCH_R10, Reg(xr));
        SCRATCH_R10
    } else {
        match materialize_int(code, value_place, SCRATCH_R10, frame) {
            Some(r) => r,
            None => {
                bail_msg("StoreLocal: value not int reg / spill");
                return false;
            }
        }
    };
    emit_mov_mem_r(code, Reg::RBP, disp, rv);
    // Mirror the store value into the destination Place.
    if let Some(rd) = int_or_spill_dst(dst) {
        if rd.0 != rv.0 {
            emit_mov_rr(code, rd, rv);
        }
        spill_dst_to_slot(code, dst, rd, frame);
    }
    true
}

/// Lower `Inst::LoadIndexed`: `dst = *(kind*)(base + index * scale)`.
/// Emitted as a single MOVSXD/MOV/MOVSX/MOVZX with SIB-byte
/// addressing (`[base + index * scale]`). F32 indexed loads aren't a
/// shape the c5 lift produces today.
#[allow(clippy::too_many_arguments)]
fn emit_load_indexed(
    code: &mut Vec<u8>,
    dst: Place,
    base: u32,
    index: u32,
    scale: u8,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if matches!(kind, LoadKind::F32) {
        bail_msg("LoadIndexed: F32 not implemented");
        return false;
    }
    let expected_scale: u8 = match kind {
        LoadKind::I64 => 8,
        LoadKind::I32 | LoadKind::U32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::F32 => unreachable!(),
    };
    if scale != expected_scale {
        bail_msg("LoadIndexed: scale doesn't match access width");
        return false;
    }
    let base_place = alloc
        .places
        .get(base as usize)
        .copied()
        .unwrap_or(Place::None);
    let index_place = alloc
        .places
        .get(index as usize)
        .copied()
        .unwrap_or(Place::None);
    let rbase = match materialize_int(code, base_place, SCRATCH_R10, frame) {
        Some(r) => r,
        None => {
            bail_msg("LoadIndexed: base Place not int reg / spill");
            return false;
        }
    };
    let rindex = match materialize_int(code, index_place, SCRATCH_RCX, frame) {
        Some(r) => r,
        None => {
            bail_msg("LoadIndexed: index Place not int reg / spill");
            return false;
        }
    };
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("LoadIndexed: dst not int reg / spill");
        return false;
    };
    match kind {
        LoadKind::I64 => super::x86_64::emit_mov_r_sib(code, rd, rbase, rindex, scale),
        LoadKind::I32 => super::x86_64::emit_movsxd_r_sib(code, rd, rbase, rindex, scale),
        LoadKind::U32 => super::x86_64::emit_mov_r32_sib(code, rd, rbase, rindex, scale),
        LoadKind::I16 => super::x86_64::emit_movsx_r_sib16(code, rd, rbase, rindex, scale),
        LoadKind::U16 => super::x86_64::emit_movzx_r_sib16(code, rd, rbase, rindex, scale),
        LoadKind::I8 => super::x86_64::emit_movsx_r_sib8(code, rd, rbase, rindex, scale),
        LoadKind::U8 => super::x86_64::emit_movzx_r_sib8(code, rd, rbase, rindex, scale),
        LoadKind::F32 => unreachable!(),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Lower `Inst::StoreIndexed`: `*(kind*)(base + index * scale) = value`.
#[allow(clippy::too_many_arguments)]
fn emit_store_indexed(
    code: &mut Vec<u8>,
    dst: Place,
    base: u32,
    index: u32,
    scale: u8,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if matches!(kind, StoreKind::F32) {
        bail_msg("StoreIndexed: F32 not implemented");
        return false;
    }
    let expected_scale: u8 = match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F32 => unreachable!(),
    };
    if scale != expected_scale {
        bail_msg("StoreIndexed: scale doesn't match access width");
        return false;
    }
    let base_place = alloc
        .places
        .get(base as usize)
        .copied()
        .unwrap_or(Place::None);
    let index_place = alloc
        .places
        .get(index as usize)
        .copied()
        .unwrap_or(Place::None);
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let rbase = match materialize_int(code, base_place, SCRATCH_R10, frame) {
        Some(r) => r,
        None => {
            bail_msg("StoreIndexed: base Place not int reg / spill");
            return false;
        }
    };
    let rindex = match materialize_int(code, index_place, SCRATCH_RCX, frame) {
        Some(r) => r,
        None => {
            bail_msg("StoreIndexed: index Place not int reg / spill");
            return false;
        }
    };
    let rv = if let Place::FpReg(xr) = value_place
        && matches!(kind, StoreKind::I64)
    {
        super::x86_64::emit_movq_r_xmm(code, SCRATCH_RDX, Reg(xr));
        SCRATCH_RDX
    } else {
        match materialize_int(code, value_place, SCRATCH_RDX, frame) {
            Some(r) => r,
            None => {
                bail_msg("StoreIndexed: value Place not int reg / spill");
                return false;
            }
        }
    };
    match kind {
        StoreKind::I64 => super::x86_64::emit_mov_sib_r(code, rbase, rindex, scale, rv),
        StoreKind::I32 => super::x86_64::emit_mov_sib_r32(code, rbase, rindex, scale, rv),
        StoreKind::I16 => super::x86_64::emit_mov_sib_r16(code, rbase, rindex, scale, rv),
        StoreKind::I8 => super::x86_64::emit_mov_sib_r8(code, rbase, rindex, scale, rv),
        StoreKind::F32 => unreachable!(),
    }
    // c5 store-op leaves the value in the accumulator.
    if let Some(rd) = int_or_spill_dst(dst) {
        if rd.0 != rv.0 {
            emit_mov_rr(code, rd, rv);
        }
        spill_dst_to_slot(code, dst, rd, frame);
    }
    true
}

fn emit_load(
    code: &mut Vec<u8>,
    dst: Place,
    addr: u32,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let addr_place = alloc
        .places
        .get(addr as usize)
        .copied()
        .unwrap_or(Place::None);
    // Spill-tolerant base materialisation: load a spilled address
    // into r10 first, write into rd next, then spill rd to its
    // slot if the allocator wants it parked there. Matches the
    // aarch64 module's primary-scratch shape.
    let base = match materialize_int(code, addr_place, SCRATCH_R10, frame) {
        Some(r) => r,
        None => {
            bail_msg("Load: addr Place not int reg / spill");
            return false;
        }
    };
    if let LoadKind::F32 = kind {
        // `float` lvalue: load 4 bytes into the low dword of an
        // xmm and widen to f64. The result is an xmm; routes
        // through the FP dst Place.
        let dd = match fp_or_spill_dst(dst) {
            Some(r) => r,
            None => {
                bail_msg("Load F32: dst not fp reg / spill");
                return false;
            }
        };
        emit_movss_xmm_mem(code, dd, base, 0);
        emit_cvtss2sd(code, dd, dd);
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("Load: dst not int reg / spill");
        return false;
    };
    match kind {
        LoadKind::I64 => emit_mov_r_mem(code, rd, base, 0),
        LoadKind::I32 => emit_movsxd_r_mem(code, rd, base, 0),
        LoadKind::U32 => super::x86_64::emit_mov_r32_mem(code, rd, base, 0),
        LoadKind::I16 => emit_movsx_r_mem16(code, rd, base, 0),
        LoadKind::U16 => emit_movzx_r_mem16(code, rd, base, 0),
        LoadKind::I8 => super::x86_64::emit_movsx_r_mem8(code, rd, base, 0),
        LoadKind::U8 => super::x86_64::emit_movzx_r_mem8(code, rd, base, 0),
        LoadKind::F32 => unreachable!(),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

fn emit_store(
    code: &mut Vec<u8>,
    dst: Place,
    addr: u32,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let addr_place = alloc
        .places
        .get(addr as usize)
        .copied()
        .unwrap_or(Place::None);
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    // Spill-tolerant materialisation: addr goes into r10 (primary
    // scratch); value goes into rcx when addr already claimed r10
    // by a spill load, else also r10. rcx is excluded from the
    // SSA allocator's GPR pools on both SysV and Win64, so it
    // never clobbers an allocator-held value.
    let base = match materialize_int(code, addr_place, SCRATCH_R10, frame) {
        Some(r) => r,
        None => {
            bail_msg("Store: addr Place not int reg / spill");
            return false;
        }
    };
    if let StoreKind::F32 = kind {
        // `float` lvalue store: narrow the f64 in xmm to f32 and
        // write the low dword. The narrowed value also feeds dst
        // when the allocator parked the stored f64 result there.
        let dn = match materialize_fp(code, value_place, SCRATCH_XMM14, frame) {
            Some(r) => r,
            None => {
                bail_msg("Store F32: value not fp reg / spill / int reg");
                return false;
            }
        };
        // Narrow into SCRATCH_XMM15 so dn (which may be an
        // allocator-held xmm holding the wider f64 the result Place
        // expects) survives.
        emit_cvtsd2ss(code, SCRATCH_XMM15, dn);
        emit_movss_mem_xmm(code, base, 0, SCRATCH_XMM15);
        match dst {
            Place::FpReg(r) if r != dn.0 => emit_movapd_xmm_xmm(code, Reg(r), dn),
            Place::Spill(_) => fp_spill_dst_to_slot(code, dst, dn, frame),
            _ => {}
        }
        return true;
    }
    let value_scratch = if base.0 == SCRATCH_R10.0 {
        Reg::RCX
    } else {
        SCRATCH_R10
    };
    let Some(rs) = materialize_int(code, value_place, value_scratch, frame) else {
        bail_msg("Store: value Place not int reg / spill");
        return false;
    };
    match kind {
        StoreKind::I64 => emit_mov_mem_r(code, base, 0, rs),
        StoreKind::I32 => super::x86_64::emit_mov_mem32_r(code, base, 0, rs),
        StoreKind::I16 => super::x86_64::emit_mov_mem16_r(code, base, 0, rs),
        StoreKind::I8 => super::x86_64::emit_mov_mem8_r(code, base, 0, rs),
        StoreKind::F32 => unreachable!(),
    }
    // Stored value also feeds dst when the allocator wants it
    // parked (Store ops leave the written value in the
    // accumulator per the c5 stack-machine semantics).
    match dst {
        Place::IntReg(r) if r != rs.0 => emit_mov_rr(code, Reg(r), rs),
        Place::Spill(_) => spill_dst_to_slot(code, dst, rs, frame),
        _ => {}
    }
    true
}

/// `Inst::Fneg(v)` -- flip the IEEE 754 sign bit of an f64. The
/// pool path uses an `xorpd` against a sign-bit mask loaded into
/// xmm1; here we build the mask on the fly into `SCRATCH_XMM15`
/// (movq xmm, r10 after loading the 1 << 63 immediate into r10)
/// and xor in place.
fn emit_fneg(code: &mut Vec<u8>, dst: Place, value: u32, alloc: &Allocation, frame: Frame) -> bool {
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let dd = match fp_or_spill_dst(dst) {
        Some(r) => r,
        None => {
            bail_msg("Fneg: dst not fp reg / spill");
            return false;
        }
    };
    let dn = match materialize_fp(code, src_place, dd, frame) {
        Some(r) => r,
        None => {
            bail_msg("Fneg: value not fp reg / spill / int reg");
            return false;
        }
    };
    if dn.0 != dd.0 {
        emit_movapd_xmm_xmm(code, dd, dn);
    }
    // Build the sign-bit mask 0x8000_0000_0000_0000 in r10 and
    // transfer to SCRATCH_XMM15, then xorpd in place.
    emit_mov_r_imm64(code, SCRATCH_R10, i64::MIN);
    emit_movq_xmm_r(code, SCRATCH_XMM15, SCRATCH_R10);
    emit_xorpd(code, dd, SCRATCH_XMM15);
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// `Inst::FpCast { kind, value }` -- int <-> f64 conversion. For
/// `IntToFp`, `CVTSI2SD` widens a signed 64-bit GPR into an xmm.
/// For `FpToInt`, `CVTTSD2SI` rounds-to-zero an xmm into a 64-bit
/// signed int.
fn emit_fp_cast(
    code: &mut Vec<u8>,
    dst: Place,
    kind: FpCastKind,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    match kind {
        FpCastKind::IntToFp => {
            let rn = match materialize_int(code, src_place, SCRATCH_R10, frame) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast IntToFp: value not int reg / spill");
                    return false;
                }
            };
            let dd = match fp_or_spill_dst(dst) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast IntToFp: dst not fp reg / spill");
                    return false;
                }
            };
            emit_cvtsi2sd(code, dd, rn);
            fp_spill_dst_to_slot(code, dst, dd, frame);
            true
        }
        FpCastKind::FpToInt => {
            let dn = match materialize_fp(code, src_place, SCRATCH_XMM14, frame) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast FpToInt: value not fp reg / spill / int reg");
                    return false;
                }
            };
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("FpCast FpToInt: dst not int reg / spill");
                return false;
            };
            emit_cvttsd2si(code, rd, dn);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
    }
}

fn emit_binop(
    code: &mut Vec<u8>,
    op: BinOp,
    dst: Place,
    lhs: u32,
    rhs: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let lhs_place = alloc
        .places
        .get(lhs as usize)
        .copied()
        .unwrap_or(Place::None);
    let rhs_place = alloc
        .places
        .get(rhs as usize)
        .copied()
        .unwrap_or(Place::None);
    // FP arithmetic: scalar f64 in xmm. Stage lhs into dst, then
    // `op dst, rhs`. Both operands land via materialize_fp; rhs may
    // need a different scratch than lhs.
    if let Some(arith) = fp_arith_enc(op) {
        let dd = match fp_or_spill_dst(dst) {
            Some(r) => r,
            None => {
                bail_msg("Fbinop: dst not fp reg / spill");
                return false;
            }
        };
        let dn = match materialize_fp(code, lhs_place, dd, frame) {
            Some(r) => r,
            None => {
                bail_msg("Fbinop: lhs not fp reg / spill / int reg");
                return false;
            }
        };
        if dn.0 != dd.0 {
            emit_movapd_xmm_xmm(code, dd, dn);
        }
        let dm = match materialize_fp(code, rhs_place, SCRATCH_XMM15, frame) {
            Some(r) => r,
            None => {
                bail_msg("Fbinop: rhs not fp reg / spill / int reg");
                return false;
            }
        };
        arith(code, dd, dm);
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    // FP comparison: ucomisd + setcc + (optional parity-fix
    // setcc + AND/OR) on the result reg. `ucomisd` sets ZF / CF
    // / PF; PF=1 signals an unordered (NaN) compare. C99 6.5.9p3
    // / 6.5.8p6 require `==`, `<`, `<=` to yield 0 on NaN and
    // `!=` to yield 1, so the cc-only `setb` / `sete` / `setbe`
    // / `setne` paths get an explicit AND-with-`setnp` /
    // OR-with-`setp` fixup. Mirrors `emit_fp_cmp_ordered` /
    // `emit_fp_cmp_ne` in the pool path.
    if let Some((cc, nan_fix)) = fp_compare_cc(op) {
        let dn = match materialize_fp(code, lhs_place, SCRATCH_XMM14, frame) {
            Some(r) => r,
            None => {
                bail_msg("Fcmp: lhs not fp reg / spill / int reg");
                return false;
            }
        };
        let dm = match materialize_fp(code, rhs_place, SCRATCH_XMM15, frame) {
            Some(r) => r,
            None => {
                bail_msg("Fcmp: rhs not fp reg / spill / int reg");
                return false;
            }
        };
        emit_ucomisd(code, dn, dm);
        let Some(rd) = int_or_spill_dst(dst) else {
            bail_msg("Fcmp: dst not int reg / spill");
            return false;
        };
        emit_setcc_r8(code, cc, rd);
        emit_movzx_r_r8(code, rd, rd);
        match nan_fix {
            FpCmpNanFix::None => {}
            FpCmpNanFix::AndNotP | FpCmpNanFix::OrP => {
                // Need a 64-bit scratch distinct from `rd` for the
                // parity-fix setcc. SCRATCH_R10 is outside the pool;
                // pick rcx as a fallback when `rd` already aliases
                // SCRATCH_R10 (the Place::Spill case). rcx is the
                // 4th SysV int arg reg and the 1st Win64 one, but
                // we're not at a call site so no live arg can
                // occupy it.
                let scratch = if rd.0 == SCRATCH_R10.0 {
                    Reg(1)
                } else {
                    SCRATCH_R10
                };
                let fix_cc = if matches!(nan_fix, FpCmpNanFix::AndNotP) {
                    super::x86_64::Cc::Np
                } else {
                    super::x86_64::Cc::P
                };
                emit_setcc_r8(code, fix_cc, scratch);
                emit_movzx_r_r8(code, scratch, scratch);
                if matches!(nan_fix, FpCmpNanFix::AndNotP) {
                    emit_and_rr(code, rd, scratch);
                } else {
                    emit_or_rr(code, rd, scratch);
                }
            }
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("Binop: dst not int reg / spill");
        return false;
    };
    // Stage lhs into rd first, so the two-operand ops below can
    // `op rd, rm` and land the result in rd. When lhs is a spill,
    // load directly into rd to skip a redundant mov. When rhs is
    // a spill, materialise via SCRATCH_R10. The conflict case
    // (rd == r10 and rhs spilled) uses rcx as the rhs scratch.
    let rn = match lhs_place {
        Place::IntReg(r) => Reg(r),
        Place::Spill(slot) => {
            let sp_off = spill_slot_sp_offset(frame, slot);
            emit_mov_r_mem(code, rd, Reg::RSP, sp_off);
            rd
        }
        _ => {
            bail_msg("Binop: lhs not int reg / spill");
            return false;
        }
    };
    // Div / Mod hijack rax + rdx (SDM: IDIV's implicit operand
    // is rdx:rax and the result is rax (quot), rdx (rem)). They
    // need their own marshalling separate from the two-operand
    // path below.
    if matches!(op, BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu) {
        return emit_binop_divmod(code, op, dst, rd, rn, rhs_place, frame);
    }
    let rhs_scratch = if rd.0 == SCRATCH_R10.0 {
        Reg::RCX
    } else {
        SCRATCH_R10
    };
    let Some(rm) = materialize_int(code, rhs_place, rhs_scratch, frame) else {
        bail_msg("Binop: rhs not int reg / spill");
        return false;
    };
    // x86_64's two-operand ops mutate the destination, so stage
    // the LHS into rd first (preserves SSA semantics where the
    // result is `lhs OP rhs`).
    if rd.0 != rn.0 {
        emit_mov_rr(code, rd, rn);
    }
    match op {
        BinOp::Add => emit_add_rr(code, rd, rm),
        BinOp::Sub => emit_sub_rr(code, rd, rm),
        BinOp::Mul => emit_imul_rr(code, rd, rm),
        BinOp::And => emit_and_rr(code, rd, rm),
        BinOp::Or => emit_or_rr(code, rd, rm),
        BinOp::Xor => emit_xor_rr(code, rd, rm),
        BinOp::Eq | BinOp::Ne | BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge => {
            // cmp lhs, rhs ; setcc cl ; movzx rd, cl. The `mov rd,
            // rn` above clobbered rd to the lhs already; reverse
            // that into a cmp directly off rn.
            emit_cmp_rr(code, rn, rm);
            let cc = match op {
                BinOp::Eq => Cc::E,
                BinOp::Ne => Cc::Ne,
                BinOp::Lt => Cc::L,
                BinOp::Gt => Cc::G,
                BinOp::Le => Cc::Le,
                BinOp::Ge => Cc::Ge,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, Reg::RCX);
            emit_movzx_r_r8(code, rd, Reg::RCX);
        }
        BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge => {
            emit_cmp_rr(code, rn, rm);
            let cc = match op {
                BinOp::Ult => Cc::B,
                BinOp::Ugt => Cc::A,
                BinOp::Ule => Cc::Be,
                BinOp::Uge => Cc::Ae,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, Reg::RCX);
            emit_movzx_r_r8(code, rd, Reg::RCX);
        }
        BinOp::Shl | BinOp::Shr | BinOp::Shru => {
            // x86 shifts read the count from cl. Stage rhs into
            // rcx first; if rd is already rcx, swap to a different
            // dest -- skipped for now.
            if rd.0 == Reg::RCX.0 {
                bail_msg("Binop shift: dst aliases rcx");
                return false;
            }
            if rm.0 != Reg::RCX.0 {
                emit_mov_rr(code, Reg::RCX, rm);
            }
            match op {
                BinOp::Shl => emit_shl_r_cl(code, rd),
                BinOp::Shr => emit_sar_r_cl(code, rd),
                BinOp::Shru => emit_shr_r_cl(code, rd),
                _ => unreachable!(),
            }
        }
        _ => {
            bail_msg("Binop: variant not yet covered");
            return false;
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Lower `BinOp::{Div,Mod,Divu,Modu}` on x86_64. IDIV / DIV
/// require the dividend in rdx:rax (low half in rax) and write
/// the quotient back to rax and remainder to rdx, so the
/// surrounding allocator-chosen value in rax (if any) must be
/// preserved across the divide. The 8-byte preserve uses
/// `push %rax` / `pop %rax`; the temporary 8-byte misalignment
/// is fine -- IDIV doesn't read/write the stack, and SysV /
/// Win64 only require 16-byte alignment at `call` sites.
///
/// `rn` is the already-materialised dividend; `rhs_place` is the
/// divisor's place so we can route it directly into r10 (which
/// IDIV's reg/mem operand can name, and which is never in any
/// allocator pool).
fn emit_binop_divmod(
    code: &mut Vec<u8>,
    op: BinOp,
    dst: Place,
    rd: Reg,
    rn: Reg,
    rhs_place: Place,
    frame: Frame,
) -> bool {
    let want_remainder = matches!(op, BinOp::Mod | BinOp::Modu);
    let is_unsigned = matches!(op, BinOp::Divu | BinOp::Modu);

    // Materialise the divisor into r10. r10 is not in any
    // allocator pool and IDIV r/m64 can name it.
    let Some(div_src) = materialize_int(code, rhs_place, SCRATCH_R10, frame) else {
        bail_msg("Binop divmod: rhs not int reg / spill");
        return false;
    };
    if div_src.0 != SCRATCH_R10.0 {
        emit_mov_rr(code, SCRATCH_R10, div_src);
    }
    // Preserve rax: the allocator can park a live value there
    // that has to be intact after this op. If rd is rax we don't
    // need to preserve -- the result will land in rax anyway.
    let preserve_rax = rd.0 != Reg::RAX.0;
    if preserve_rax {
        emit_push_r(code, Reg::RAX);
    }
    // rax := dividend low half.
    if rn.0 != Reg::RAX.0 {
        emit_mov_rr(code, Reg::RAX, rn);
    }
    // rdx := dividend high half. Signed uses CQO to sign-extend
    // rax; unsigned zero-extends with `xor edx, edx`.
    if is_unsigned {
        emit_xor_rr(code, Reg::RDX, Reg::RDX);
        super::x86_64::emit_div_r(code, SCRATCH_R10);
    } else {
        super::x86_64::emit_cqo(code);
        super::x86_64::emit_idiv_r(code, SCRATCH_R10);
    }
    // Capture result into rd before restoring rax.
    let result_src = if want_remainder { Reg::RDX } else { Reg::RAX };
    if rd.0 != result_src.0 {
        emit_mov_rr(code, rd, result_src);
    }
    if preserve_rax {
        emit_pop_r(code, Reg::RAX);
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

fn emit_binop_imm(
    code: &mut Vec<u8>,
    op: BinOp,
    dst: Place,
    lhs: u32,
    rhs_imm: i64,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("BinopI: dst not int reg / spill");
        return false;
    };
    let lhs_place = alloc
        .places
        .get(lhs as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match lhs_place {
        Place::IntReg(r) => Reg(r),
        Place::Spill(slot) => {
            let sp_off = spill_slot_sp_offset(frame, slot);
            emit_mov_r_mem(code, rd, Reg::RSP, sp_off);
            rd
        }
        _ => {
            bail_msg("BinopI: lhs not int reg / spill");
            return false;
        }
    };
    // Per-op peepholes for immediate-form binops. These avoid
    // the 10-byte `mov rcx, imm64` materialisation when the
    // immediate fits a shorter form. Fall back to the rcx-scratch
    // path below for anything that doesn't.
    //
    //   * Mul by power of two -> shl rd, log2(imm).
    //   * Shl / Shr / Shru by 0..63 -> shl / sar / shr by imm8.
    //   * Add / Sub / And / Or / Xor with i32-fitting imm -> the
    //     existing immediate-form encoders (`emit_*_r_imm32`).
    let imm_fits_i32 = i32::try_from(rhs_imm).is_ok();
    let imm_is_pow2 = rhs_imm > 0 && (rhs_imm as u64).is_power_of_two();
    let shift_amount = if (0..64).contains(&rhs_imm) {
        Some(rhs_imm as u8)
    } else {
        None
    };
    let used_peephole = match op {
        BinOp::Mul if imm_is_pow2 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_shl_r_imm8(code, rd, (rhs_imm as u64).trailing_zeros() as u8);
            true
        }
        BinOp::Shl if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_shl_r_imm8(code, rd, shift_amount.unwrap());
            true
        }
        BinOp::Shr if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_sar_r_imm8(code, rd, shift_amount.unwrap());
            true
        }
        BinOp::Shru if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_shr_r_imm8(code, rd, shift_amount.unwrap());
            true
        }
        BinOp::Add if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_add_r_imm32(code, rd, rhs_imm as i32);
            true
        }
        BinOp::Sub if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_sub_r_imm32(code, rd, rhs_imm as i32);
            true
        }
        BinOp::And if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_and_r_imm32(code, rd, rhs_imm as i32);
            true
        }
        BinOp::Or if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_or_r_imm32(code, rd, rhs_imm as i32);
            true
        }
        _ => false,
    };
    if used_peephole {
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Materialise the immediate into rcx as a scratch. rcx is
    // caller-saved on every x86_64 ABI we target, and the SSA
    // allocator excludes it from the pool, so this can't clobber
    // a live value.
    super::x86_64::emit_mov_r_imm64(code, Reg::RCX, rhs_imm);
    // Stage rd = lhs first (x86's two-operand form).
    if rd.0 != rn.0 {
        emit_mov_rr(code, rd, rn);
    }
    match op {
        BinOp::Add => emit_add_rr(code, rd, Reg::RCX),
        BinOp::Sub => emit_sub_rr(code, rd, Reg::RCX),
        BinOp::Mul => emit_imul_rr(code, rd, Reg::RCX),
        BinOp::And => emit_and_rr(code, rd, Reg::RCX),
        BinOp::Or => emit_or_rr(code, rd, Reg::RCX),
        BinOp::Xor => emit_xor_rr(code, rd, Reg::RCX),
        BinOp::Eq | BinOp::Ne | BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge => {
            emit_cmp_rr(code, rn, Reg::RCX);
            let cc = match op {
                BinOp::Eq => Cc::E,
                BinOp::Ne => Cc::Ne,
                BinOp::Lt => Cc::L,
                BinOp::Gt => Cc::G,
                BinOp::Le => Cc::Le,
                BinOp::Ge => Cc::Ge,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, Reg::RCX);
            emit_movzx_r_r8(code, rd, Reg::RCX);
        }
        BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge => {
            emit_cmp_rr(code, rn, Reg::RCX);
            let cc = match op {
                BinOp::Ult => Cc::B,
                BinOp::Ugt => Cc::A,
                BinOp::Ule => Cc::Be,
                BinOp::Uge => Cc::Ae,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, Reg::RCX);
            emit_movzx_r_r8(code, rd, Reg::RCX);
        }
        BinOp::Shl | BinOp::Shr | BinOp::Shru => {
            // Shift count already in cl via the `mov rcx, imm` above.
            if rd.0 == Reg::RCX.0 {
                bail_msg("BinopI shift: dst aliases rcx");
                return false;
            }
            match op {
                BinOp::Shl => emit_shl_r_cl(code, rd),
                BinOp::Shr => emit_sar_r_cl(code, rd),
                BinOp::Shru => emit_shr_r_cl(code, rd),
                _ => unreachable!(),
            }
        }
        _ => {
            bail_msg("BinopI: variant not yet covered");
            return false;
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

fn emit_call(
    code: &mut Vec<u8>,
    dst: Place,
    target_pc: usize,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    callee_is_variadic: bool,
) -> bool {
    if callee_is_variadic {
        // c5's variadic ABI keeps the c5 stack: each arg is pushed
        // at a 16-byte stride matching `Op::Psh`. The callee's
        // prologue (`emit_prologue` with `entry_spill = 0`) skips
        // the host-arg-reg spill and reads its args through
        // `Op::Lea N` -> `[rbp + 16*(N-1)]`; `va_start` continues
        // the walk past the last named arg. Push args in reverse
        // so args[0] -- the first declared arg -- lands on top of
        // the stack at `[rbp + 16]`.
        for (i, &arg_id) in args.iter().rev().enumerate() {
            let arg_place = alloc
                .places
                .get(arg_id as usize)
                .copied()
                .unwrap_or(Place::None);
            // Each prior push moved rsp another 16 bytes down.
            let sp_shift = (i as u32) * 16;
            let src = match materialize_int_shifted(code, arg_place, SCRATCH_R10, frame, sp_shift) {
                Some(r) => r,
                None => {
                    bail_msg("Call (variadic): arg not in int reg / spill");
                    return false;
                }
            };
            emit_sub_rsp_imm32(code, 16);
            emit_mov_mem_r(code, Reg::RSP, 0, src);
        }
        let call_site = code.len();
        fixups.push(Fixup {
            native_offset: call_site,
            target_bytecode_pc: target_pc,
            kind: super::x86_64::BranchKind::Call,
        });
        super::x86_64::emit_call_rel32(code, 0);
        if !args.is_empty() {
            emit_add_rsp_imm32(code, (args.len() as u32) * 16);
        }
        if let Some(rd) = int_or_spill_dst(dst) {
            if rd.0 != Reg::RAX.0 {
                emit_mov_rr(code, rd, Reg::RAX);
            }
            spill_dst_to_slot(code, dst, rd, frame);
        }
        return true;
    }
    // c5-internal call convention: every argument rides an int
    // register (or stack slot), even for f64 -- the callee's
    // prologue (`emit_prologue`) spills `int_arg_regs[0..n_params]`
    // into the c5 cdecl slots without distinguishing FP / int
    // params, so an FP arg routed through xmm would land in an
    // uninitialised slot. The pool path follows the same shape at
    // `Op::Jsr` / `Op::Jsri`. `fp_arg_mask = 0` keeps
    // `plan_call_args` on the int-reg path.
    let plan = super::plan_call_args(args.len(), args.len(), 0, abi);
    if plan.scratch_bytes > 0 {
        emit_sub_rsp_imm32(code, plan.scratch_bytes);
    }
    for (i, &placement) in plan.placements.iter().enumerate() {
        let arg_id = args[i];
        let arg_place = alloc
            .places
            .get(arg_id as usize)
            .copied()
            .unwrap_or(Place::None);
        if !marshal_int_arg(
            code,
            arg_place,
            placement,
            frame,
            plan.scratch_bytes,
            "Call",
        ) {
            return false;
        }
    }
    // Record a fixup for the call's rel32 field. `emit_call_rel32`
    // emits opcode 0xE8 then 4 bytes of rel32; `target_bytecode_pc`
    // resolves to the function's native offset in the post-pass.
    let call_site = code.len();
    fixups.push(Fixup {
        native_offset: call_site,
        target_bytecode_pc: target_pc,
        kind: super::x86_64::BranchKind::Call,
    });
    super::x86_64::emit_call_rel32(code, 0);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    // c5 internal call return convention: the bit pattern lives
    // in rax (int-shaped dst reads rax); f64 returns additionally
    // live in xmm0 (FpReg-shaped dst reads xmm0). `emit_return`
    // mirrors xmm0 into rax for f64 returns so an int-shaped
    // caller reads it uniformly.
    match dst {
        Place::FpReg(r) => {
            if r != Reg::XMM0.0 {
                emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
            }
        }
        Place::IntReg(r) => {
            if r != Reg::RAX.0 {
                emit_mov_rr(code, Reg(r), Reg::RAX);
            }
        }
        Place::Spill(_) => {
            spill_dst_to_slot(code, dst, Reg::RAX, frame);
        }
        Place::None => {}
    }
    true
}

fn emit_call_ext(
    code: &mut Vec<u8>,
    dst: Place,
    binding_idx: i64,
    args: &[u32],
    fp_arg_mask: u32,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    target: Target,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    imports: &super::ResolvedImports,
) -> bool {
    let import_index = match imports.index_of_binding(binding_idx) {
        Some(i) => i,
        None => return false,
    };
    let imp = &imports.imports[import_index];
    let fixed = if imp.is_variadic {
        imp.fixed_args.min(args.len())
    } else {
        args.len()
    };
    let plan = super::plan_call_args(args.len(), fixed, fp_arg_mask, abi);
    let xmm_used = plan
        .placements
        .iter()
        .filter(|p| matches!(p, super::ArgPlacement::FpReg(_)))
        .count() as u8;
    if plan.scratch_bytes > 0 {
        emit_sub_rsp_imm32(code, plan.scratch_bytes);
    }
    for (i, &placement) in plan.placements.iter().enumerate() {
        let arg_id = args[i];
        let arg_place = alloc
            .places
            .get(arg_id as usize)
            .copied()
            .unwrap_or(Place::None);
        if !marshal_int_arg(
            code,
            arg_place,
            placement,
            frame,
            plan.scratch_bytes,
            "CallExt",
        ) {
            return false;
        }
    }
    // System V AMD64 ABI 3.2.3: when the callee is variadic, `al`
    // must hold the number of XMM argument registers used (printf
    // and friends consult `al` in their prologue to decide whether
    // to spill xmm0..xmm7 into the va-save area). Non-variadic
    // SysV callees treat `al` as don't-care; zero it to match the
    // pool path. Win64 has no such requirement and clears
    // `variadic_zero_xmm_count` in its `Abi`.
    if abi.variadic_zero_xmm_count {
        if imp.is_variadic {
            super::x86_64::emit_mov_al_imm8(code, xmm_used);
        } else {
            super::x86_64::emit_xor_eax_eax(code);
        }
    }
    let call_site = code.len();
    plt_call_fixups.push(PltCallFixup {
        instr_offset: call_site,
        import_index,
        is_tail: false,
    });
    super::x86_64::emit_call_rel32(code, 0);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    // Sub-word integer returns get the standard sign / zero
    // extension into rax. FP returns arrive in xmm0 (SysV 3.2.3,
    // Win64 returns scalars/SSE in xmm0); route into the
    // allocator's chosen Place, which may be an FpReg, an IntReg
    // (holding the f64 bit pattern -- c5's accumulator is one big
    // 8-byte slot), or a spill slot.
    //
    // SysV long-double sits in x87 st0 (binary128 mantissa
    // truncated to the x87 80-bit format). c5 stores long double
    // in an 8-byte slot, so emit `fstp QWORD PTR [rsp]` to round
    // st0 to f64 and route the f64 bit pattern through the same
    // dst dispatch.
    use crate::c5::compiler::types as ty_helpers;
    let return_type_tag = imp.return_type_tag;
    let bare = ty_helpers::strip_unsigned(return_type_tag);
    let returns_long_double = imp.returns_long_double;
    if returns_long_double && matches!(target, Target::LinuxX64) {
        emit_sub_rsp_imm32(code, 16);
        // fstp QWORD PTR [rsp] -- `DD /3`, mod=00, rm=100 (SIB
        // follows), SIB = 0x24 (base = rsp, no index).
        code.extend_from_slice(&[0xDD, 0x1C, 0x24]);
        let scratch = match dst {
            Place::IntReg(r) if r != Reg::RAX.0 => Reg(r),
            _ => SCRATCH_R10,
        };
        emit_mov_r_mem(code, scratch, Reg::RSP, 0);
        emit_add_rsp_imm32(code, 16);
        match dst {
            Place::IntReg(r) => {
                if Reg(r).0 != scratch.0 {
                    emit_mov_rr(code, Reg(r), scratch);
                }
            }
            Place::Spill(_) => {
                spill_dst_to_slot(code, dst, scratch, frame);
            }
            Place::FpReg(r) => {
                super::x86_64::emit_movq_xmm_r(code, Reg(r), scratch);
            }
            Place::None => {}
        }
        return true;
    }
    if ty_helpers::is_float_ty(bare) || ty_helpers::is_double_ty(bare) {
        match dst {
            Place::FpReg(r) => {
                if r != Reg::XMM0.0 {
                    emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
                }
            }
            Place::IntReg(r) => {
                super::x86_64::emit_movq_r_xmm(code, Reg(r), Reg::XMM0);
            }
            Place::Spill(_) => {
                fp_spill_dst_to_slot(code, dst, Reg::XMM0, frame);
            }
            Place::None => {}
        }
        return true;
    }
    let ext = super::return_extension(return_type_tag, target);
    super::x86_64::emit_extend_rax_for_return(code, ext);
    if let Some(rd) = int_or_spill_dst(dst) {
        if rd.0 != Reg::RAX.0 {
            emit_mov_rr(code, rd, Reg::RAX);
        }
        spill_dst_to_slot(code, dst, rd, frame);
    }
    true
}

fn emit_call_indirect(
    code: &mut Vec<u8>,
    dst: Place,
    target: u32,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) -> bool {
    let target_place = alloc
        .places
        .get(target as usize)
        .copied()
        .unwrap_or(Place::None);
    // Capture the target pointer into r11 before arg marshalling
    // can clobber it. r11 is caller-saved on every x86_64 ABI we
    // target; the SSA allocator's pool includes r11 (caller_gprs)
    // but the value held there can be no longer live than the
    // target itself since the SSA emit hijacks r11 for the call.
    let target_r = match materialize_int(code, target_place, Reg::R11, frame) {
        Some(r) => r,
        None => {
            bail_msg("CallIndirect: target not int reg / spill");
            return false;
        }
    };
    if target_r.0 != Reg::R11.0 {
        emit_mov_rr(code, Reg::R11, target_r);
    }
    let plan = super::plan_call_args(args.len(), args.len(), 0, abi);
    if plan.scratch_bytes > 0 {
        emit_sub_rsp_imm32(code, plan.scratch_bytes);
    }
    for (i, &placement) in plan.placements.iter().enumerate() {
        let arg_id = args[i];
        let arg_place = alloc
            .places
            .get(arg_id as usize)
            .copied()
            .unwrap_or(Place::None);
        if !marshal_int_arg(
            code,
            arg_place,
            placement,
            frame,
            plan.scratch_bytes,
            "CallIndirect",
        ) {
            return false;
        }
    }
    super::x86_64::emit_call_r(code, Reg::R11);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    match dst {
        Place::FpReg(r) => {
            if r != Reg::XMM0.0 {
                emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
            }
        }
        Place::IntReg(r) => {
            if r != Reg::RAX.0 {
                emit_mov_rr(code, Reg(r), Reg::RAX);
            }
        }
        Place::Spill(_) => {
            spill_dst_to_slot(code, dst, Reg::RAX, frame);
        }
        Place::None => {}
    }
    true
}

fn emit_intrinsic(
    code: &mut Vec<u8>,
    kind: i64,
    args: &[u32],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    current_alloca_top: u32,
) -> bool {
    use crate::c5::op::Intrinsic as I;
    let intrinsic = match I::from_i64(kind) {
        Some(i) => i,
        None => {
            bail_msg("intrinsic: unknown discriminant");
            return false;
        }
    };
    match intrinsic {
        I::VaStart => {
            // __builtin_va_start(&ap, &last). args[0] = &ap,
            // args[1] = &last. *ap = &last + 16 (next c5 slot,
            // 16-byte stride mirroring the aarch64 path).
            if args.len() != 2 {
                bail_msg("VaStart: expected 2 args");
                return false;
            }
            let ap = match alloc.places.get(args[0] as usize).copied() {
                Some(Place::IntReg(r)) => Reg(r),
                _ => {
                    bail_msg("VaStart: &ap not in int reg");
                    return false;
                }
            };
            let last = match alloc.places.get(args[1] as usize).copied() {
                Some(Place::IntReg(r)) => Reg(r),
                _ => {
                    bail_msg("VaStart: &last not in int reg");
                    return false;
                }
            };
            // r10 = &last + 16 ; mov [ap], r10. SCRATCH_R10 sits
            // outside the SSA allocator's gpr pool, so the
            // computed address survives even when the allocator
            // picked rax / r11 for ap or last.
            emit_lea_r_mem(code, SCRATCH_R10, last, 16);
            emit_mov_mem_r(code, ap, 0, SCRATCH_R10);
            true
        }
        I::VaArg => {
            // Returns *ap, advances *ap by 16. args[0] = &ap.
            if args.len() != 1 {
                bail_msg("VaArg: expected 1 arg");
                return false;
            }
            let Some(rd) = int_reg(dst) else {
                bail_msg("VaArg: dst not int reg");
                return false;
            };
            let ap = match alloc.places.get(args[0] as usize).copied() {
                Some(Place::IntReg(r)) => Reg(r),
                _ => {
                    bail_msg("VaArg: &ap not in int reg");
                    return false;
                }
            };
            // rd = *ap (old cursor) ; r10 = rd + 16 ; *ap = r10.
            // Use SCRATCH_R10 (outside the SSA allocator's gpr pool)
            // for the advance so the allocator picking rax / r11 /
            // any pool reg as rd doesn't get its old-cursor value
            // overwritten by the `lea` before the store.
            emit_mov_r_mem(code, rd, ap, 0);
            emit_lea_r_mem(code, SCRATCH_R10, rd, 16);
            emit_mov_mem_r(code, ap, 0, SCRATCH_R10);
            true
        }
        I::VaEnd => {
            // No teardown for the cursor model.
            true
        }
        I::VaCopy => {
            // __builtin_va_copy(&dst, &src). *dst = *src.
            if args.len() != 2 {
                bail_msg("VaCopy: expected 2 args");
                return false;
            }
            let dst_p = match alloc.places.get(args[0] as usize).copied() {
                Some(Place::IntReg(r)) => Reg(r),
                _ => {
                    bail_msg("VaCopy: &dst not in int reg");
                    return false;
                }
            };
            let src_p = match alloc.places.get(args[1] as usize).copied() {
                Some(Place::IntReg(r)) => Reg(r),
                _ => {
                    bail_msg("VaCopy: &src not in int reg");
                    return false;
                }
            };
            // SCRATCH_R10 is outside the SSA allocator's gpr pool
            // so neither dst_p nor src_p aliases it.
            emit_mov_r_mem(code, SCRATCH_R10, src_p, 0);
            emit_mov_mem_r(code, dst_p, 0, SCRATCH_R10);
            true
        }
        I::Alloca => {
            // alloca(n): bump the per-frame arena's top down by
            // `n` rounded up to 16 bytes. The bookkeeping slot
            // lives at `[rbp - current_alloca_top]` (initialised
            // by the matching `Inst::AllocaInit`); the new top is
            // returned in `dst`.
            if current_alloca_top == 0 {
                bail_msg("Alloca: AllocaInit didn't run for this function");
                return false;
            }
            if args.len() != 1 {
                bail_msg("Alloca: expected 1 arg");
                return false;
            }
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("Alloca: dst not int reg / spill");
                return false;
            };
            let size_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            // Stage the size into SCRATCH_R10 (outside the
            // allocator pool) and round up to a 16-byte multiple.
            let n = match materialize_int(code, size_place, SCRATCH_R10, frame) {
                Some(r) => r,
                None => {
                    bail_msg("Alloca: size not int reg / spill / fp");
                    return false;
                }
            };
            if n.0 != SCRATCH_R10.0 {
                emit_mov_rr(code, SCRATCH_R10, n);
            }
            super::x86_64::emit_add_r_imm32(code, SCRATCH_R10, 15);
            super::x86_64::emit_and_r_imm32(code, SCRATCH_R10, -16);
            // rcx = address of bookkeeping slot. rcx sits outside
            // the SSA allocator pool on both ABIs (it's
            // int_arg_regs[3]/int_arg_regs[0] but never in pool),
            // so reusing it as scratch can't clobber an allocator
            // value live across this op.
            let disp = -(current_alloca_top as i32);
            emit_lea_r_mem(code, Reg::RCX, Reg::RBP, disp);
            // rd_or_scratch = *bookkeeping_slot - n -- recompute the
            // arena top, write it back, and return it.
            let rd_phys = if matches!(dst, Place::Spill(_)) {
                SCRATCH_R10
            } else {
                rd
            };
            emit_mov_r_mem(code, rd_phys, Reg::RCX, 0);
            super::x86_64::emit_sub_rr(code, rd_phys, SCRATCH_R10);
            emit_mov_mem_r(code, Reg::RCX, 0, rd_phys);
            if rd_phys.0 != rd.0 && !matches!(dst, Place::Spill(_)) {
                emit_mov_rr(code, rd, rd_phys);
            }
            spill_dst_to_slot(code, dst, rd_phys, frame);
            true
        }
        I::SetjmpAArch64 | I::LongjmpAArch64 => {
            bail_msg("intrinsic: AArch64 setjmp / longjmp on non-AArch64 target");
            false
        }
    }
}

fn emit_imm_data(
    code: &mut Vec<u8>,
    dst: Place,
    offset: i64,
    data_fixups: &mut Vec<DataFixup>,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("ImmData: dst not int reg / spill");
        return false;
    };
    let instr_offset = code.len();
    data_fixups.push(DataFixup {
        adrp_offset: instr_offset,
        data_offset: offset as u64,
    });
    // `lea rd, [rip + 0]` placeholder; the writer patches the
    // disp32 once the data segment's runtime address is known.
    super::x86_64::emit_lea_r_rip32(code, rd, 0);
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

fn emit_imm_code(
    code: &mut Vec<u8>,
    dst: Place,
    target_bc_pc: usize,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("ImmCode: dst not int reg / spill");
        return false;
    };
    let instr_offset = code.len();
    pending_func_fixups.push((instr_offset, target_bc_pc));
    super::x86_64::emit_lea_r_rip32(code, rd, 0);
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

fn emit_vstack_spill(
    code: &mut Vec<u8>,
    slot: u32,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let sp_off = (frame.frame_bytes - frame.acc_slot_off + 8 + slot * 8) as i32;
    let rs = match value_place {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => {
            let Some(r) = materialize_int(code, value_place, SCRATCH_R10, frame) else {
                bail_msg("VstackSpill: materialize failed");
                return false;
            };
            r
        }
        Place::FpReg(r) => {
            super::x86_64::emit_movq_r_xmm(code, SCRATCH_R10, Reg(r));
            SCRATCH_R10
        }
        Place::None => {
            bail_msg("VstackSpill: value Place::None");
            return false;
        }
    };
    emit_mov_mem_r(code, Reg::RSP, sp_off, rs);
    true
}

fn emit_vstack_reload(code: &mut Vec<u8>, dst: Place, slot: u32, frame: Frame) -> bool {
    let sp_off = (frame.frame_bytes - frame.acc_slot_off + 8 + slot * 8) as i32;
    match dst {
        Place::IntReg(r) => {
            emit_mov_r_mem(code, Reg(r), Reg::RSP, sp_off);
            true
        }
        Place::Spill(_) => {
            emit_mov_r_mem(code, SCRATCH_R10, Reg::RSP, sp_off);
            spill_dst_to_slot(code, dst, SCRATCH_R10, frame);
            true
        }
        Place::FpReg(r) => {
            emit_mov_r_mem(code, SCRATCH_R10, Reg::RSP, sp_off);
            super::x86_64::emit_movq_xmm_r(code, Reg(r), SCRATCH_R10);
            true
        }
        Place::None => true,
    }
}

fn emit_mcpy(
    code: &mut Vec<u8>,
    dst_place: Place,
    dst_val: u32,
    src_val: u32,
    size: i64,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if size < 0 {
        bail_msg("Mcpy: negative size");
        return false;
    }
    let dst_in = alloc
        .places
        .get(dst_val as usize)
        .copied()
        .unwrap_or(Place::None);
    let src_in = alloc
        .places
        .get(src_val as usize)
        .copied()
        .unwrap_or(Place::None);
    // Materialise both bases. r10 / rcx are caller-saved scratch
    // regs outside the SSA allocator pool, so they can't clobber
    // anything live.
    let Some(dst_r) = materialize_int(code, dst_in, SCRATCH_R10, frame) else {
        bail_msg("Mcpy: dst base not int reg / spill");
        return false;
    };
    let src_scratch = if dst_r.0 == SCRATCH_R10.0 {
        Reg::RCX
    } else {
        SCRATCH_R10
    };
    let Some(src_r) = materialize_int(code, src_in, src_scratch, frame) else {
        bail_msg("Mcpy: src base not int reg / spill");
        return false;
    };
    // Pick a per-iteration temp distinct from both bases, then
    // save / restore it across the copy. The SSA allocator's
    // pool for LinuxX64 includes rax and r11; the prologue may
    // have parked a live value in either. A push/pop pair around
    // the loop preserves whatever the allocator stashed there.
    let temp = if dst_r.0 != Reg::RAX.0 && src_r.0 != Reg::RAX.0 {
        Reg::RAX
    } else if dst_r.0 != Reg::R11.0 && src_r.0 != Reg::R11.0 {
        Reg::R11
    } else if dst_r.0 != Reg::RCX.0 && src_r.0 != Reg::RCX.0 {
        Reg::RCX
    } else {
        // Both r10 (one of the bases here -- only happens when
        // either materialise loaded into r10) and rcx are taken.
        // Fall back to rdx, which is also outside every pool.
        Reg::RDX
    };
    emit_push_r(code, temp);
    let bytes = size as u32;
    let words = bytes / 8;
    for w in 0..words {
        // After push, [base + off] still resolves correctly
        // because the bases are register-typed (not sp-relative).
        let off = (w * 8) as i32;
        emit_mov_r_mem(code, temp, src_r, off);
        emit_mov_mem_r(code, dst_r, off, temp);
    }
    let tail_start = words * 8;
    for i in 0..(bytes - tail_start) {
        let off = (tail_start + i) as i32;
        super::x86_64::emit_movzx_r_mem8(code, temp, src_r, off);
        super::x86_64::emit_mov_mem8_r(code, dst_r, off, temp);
    }
    emit_pop_r(code, temp);
    // memcpy returns dst; propagate into the inst's dst.
    match dst_place {
        Place::IntReg(r) if r != dst_r.0 => emit_mov_rr(code, Reg(r), dst_r),
        Place::Spill(_) => spill_dst_to_slot(code, dst_place, dst_r, frame),
        _ => {}
    }
    true
}

fn emit_return(
    code: &mut Vec<u8>,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    func: &FunctionSsa,
) {
    // The SSA allocator's pool covers rax + r11 (SysV caller-
    // saved), so the prologue may have saved rax. Park the
    // return value in rcx (not in the pool) ahead of the
    // restore loop and copy rcx -> rax after; otherwise the
    // restore reloads rax with whatever the body parked there
    // and the return value is lost. The FP-return path skips
    // rax entirely: f64 returns ride xmm0, which the SSA
    // allocator's pool covers but the prologue does not save
    // (no callee-saved xmm on SysV).
    let return_place = if value != super::super::ir::NO_VALUE {
        alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None)
    } else {
        Place::None
    };
    let return_src = int_reg(return_place);
    let return_is_fp = matches!(return_place, Place::FpReg(_));
    if let Some(src) = return_src
        && src.0 != Reg::RCX.0
    {
        emit_mov_rr(code, Reg::RCX, src);
    }
    if return_is_fp {
        // Materialize the f64 into xmm0 ahead of the restore. The
        // restore loop only writes GPRs, so xmm0 survives it.
        // SCRATCH_XMM14 is outside the allocator's pool, so a
        // spilled f64 lands there without clobbering an
        // allocator-held xmm.
        if let Some(dn) = materialize_fp(code, return_place, SCRATCH_XMM14, frame)
            && dn.0 != Reg::XMM0.0
        {
            emit_movapd_xmm_xmm(code, Reg::XMM0, dn);
        }
    }
    // Restore callee-saved GPRs (mirror of the prologue's saves).
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = (i as i32) * 8;
        super::x86_64::emit_mov_r_mem(code, Reg(r), Reg::RSP, off);
    }
    if return_src.is_some() {
        emit_mov_rr(code, Reg::RAX, Reg::RCX);
    } else if return_is_fp {
        // Mirror the f64 bit pattern into rax so an int-shaped
        // caller dst (IntReg / Spill) can read rax uniformly. The
        // value still lives in xmm0 for FpReg-shaped callers and
        // for any host-ABI consumer that reads xmm0 directly.
        super::x86_64::emit_movq_r_xmm(code, Reg::RAX, Reg::XMM0);
    }
    if frame.frame_bytes > 0 {
        emit_add_rsp_imm32(code, frame.frame_bytes);
    }
    emit_pop_r(code, Reg::RBP);
    // Drop the host-arg-reg spill slots the prologue laid down.
    // Each param consumed a 16-byte slot (one push for the arg +
    // one 8-byte gap). Pop the ret address into r11, drop the
    // slots, push the ret address back. Skipped for variadic
    // functions whose prologue did no spilling.
    if !func.is_variadic && func.n_params > 0 {
        emit_pop_r(code, Reg::R11);
        let bytes = (16 * func.n_params) as u32;
        emit_add_rsp_imm32(code, bytes);
        emit_push_r(code, Reg::R11);
    }
    emit_ret(code);
}

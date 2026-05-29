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

use alloc::vec::Vec;

use super::super::ir::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
use super::DataFixup;
use super::Target;
use super::aarch64::{
    BranchKind, Cond, Fixup, JB_D8_OFF, JB_PC_OFF, JB_SP_OFF, JB_X19_OFF, JB_X29_OFF, PltCallFixup,
    Reg, emit, emit_add_sp_imm, emit_setjmp_aarch64, emit_sub_sp_imm, enc_add_imm, enc_add_reg,
    enc_adrp, enc_and_reg, enc_asrv, enc_b, enc_b_cond, enc_bl, enc_blr, enc_br, enc_cbnz, enc_cbz,
    enc_cinc, enc_cmp_reg, enc_cset, enc_eor_reg, enc_fadd_d, enc_fcmp_d, enc_fcvt_d_s,
    enc_fcvt_s_d, enc_fcvtzs_x_d, enc_fdiv_d, enc_fmov_d_to_x, enc_fmov_x_to_d, enc_fmul_d,
    enc_fneg_d, enc_fsub_d, enc_ldp_post, enc_ldr_d_imm, enc_ldr_imm, enc_ldr_post, enc_ldr_s_imm,
    enc_ldr32_imm, enc_ldrb_imm, enc_ldrh_imm, enc_ldrsb_imm, enc_ldrsh_imm, enc_ldrsw_imm,
    enc_lslv, enc_lsrv, enc_msub, enc_mul, enc_orr_reg, enc_ret, enc_scvtf_d_x,
    enc_sdiv, enc_stp_pre, enc_str_d_imm, enc_str_imm, enc_str_pre, enc_str_s_imm, enc_str32_imm,
    enc_strb_imm, enc_strh_imm, enc_sub_imm, enc_sub_reg, enc_subs_imm, enc_udiv, emit_mov_reg,
    load_imm64,
};
use super::ssa_alloc::{Allocation, Place};

/// Per-function frame layout. Bytes are 16-aligned at every
/// region boundary so AAPCS64's sp-at-call-site invariant holds.
#[derive(Debug, Clone, Copy)]
pub(super) struct Frame {
    /// Total frame size below fp, sub-spilled once at prologue
    /// entry. Includes locals, allocator spills, and saved
    /// callee-saved regs.
    pub frame_bytes: u32,
    /// Byte distance from fp down to the start of the
    /// allocator-managed spill region.
    pub alloc_spill_base: u32,
    /// Whether this function clobbers x19. x19 is callee-saved per
    /// AAPCS64 and is the scratch the writer's patch_adrp_add forces
    /// for address materialisation, so it is saved and restored only
    /// when the function actually uses it (see [`function_clobbers_x19`]).
    pub uses_x19: bool,
}

impl Frame {
    pub fn for_function(func: &FunctionSsa, alloc: &Allocation) -> Self {
        let locals_bytes = ((func.locals.max(0) as u32) * 8 + 15) & !15;
        let alloc_spill_bytes = (alloc.spill_count * 8 + 15) & !15;
        let saved_gpr_bytes = ((alloc.gpr_used.len() as u32) * 8 + 15) & !15;
        let saved_fpr_bytes = ((alloc.fp_used.len() as u32) * 8 + 15) & !15;
        // Reserve the x19 slot unconditionally so the offsets of the
        // allocator-saved regs, spills, and locals do not depend on
        // whether x19 is live; the prologue / epilogue skip the
        // actual store / load when the function never clobbers x19.
        let x19_save_bytes = 16u32;
        let frame_bytes =
            locals_bytes + alloc_spill_bytes + saved_gpr_bytes + saved_fpr_bytes + x19_save_bytes;
        Self {
            frame_bytes,
            alloc_spill_base: locals_bytes,
            uses_x19: function_clobbers_x19(func),
        }
    }
}

/// x19 is overwritten only by the lowerings that route through it:
/// the ImmData / ImmCode address-materialisation placeholders the
/// writer rewrites to x19, the indirect-call environment setup, the
/// setjmp / longjmp intrinsics, TLS address loads, and external call
/// thunks. A function touching none of these leaves x19 untouched, so
/// its prologue need not save the caller's value.
fn function_clobbers_x19(func: &FunctionSsa) -> bool {
    func.insts.iter().any(|inst| {
        matches!(
            inst,
            Inst::ImmData(_)
                | Inst::ImmCode(_)
                | Inst::TlsAddr(_)
                | Inst::CallIndirect { .. }
                | Inst::CallExt { .. }
                | Inst::Intrinsic { .. }
        )
    })
}

fn bail_msg(reason: &str) {
    super::ssa_emit_common::bail_msg("aarch64", reason);
}

fn bail(reason: &str, value: u32, place: Place) {
    #[cfg(feature = "std")]
    if std::env::var("BADC_DUMP_SSA").is_ok() {
        eprintln!(
            "ssa emit aarch64: bailed -- {reason} v{value} place={:?}",
            place
        );
    }
    let _ = (reason, value, place);
}

/// SP-relative byte offset of allocator spill `slot` in the
/// current function's frame. Thin wrapper over the cross-target
/// math helper so the per-call sites read as `spill_off(frame,
/// slot)` rather than the four-argument call.
fn spill_off(frame: Frame, slot: u32) -> u32 {
    super::ssa_emit_common::spill_slot_sp_offset(frame.frame_bytes, frame.alloc_spill_base, slot)
}

/// Branch placeholder recorded mid-walk; resolved once every
/// block's start offset is known.
#[derive(Debug, Clone, Copy)]
struct BranchFixup {
    /// Byte offset in `code` of the placeholder instruction.
    site: usize,
    /// Target block in the function's `blocks` table.
    target: BlockId,
    kind: LocalBranchKind,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum LocalBranchKind {
    /// Unconditional B; `imm26` field, +/-128 MiB reach.
    B,
    /// CBZ Xt, label.
    Cbz(Reg),
    /// CBNZ Xt, label.
    Cbnz(Reg),
    /// B.cond label.
    Bcc(Cond),
}

/// Public entry point. Returns `true` when every block + inst +
/// terminator was lowered. Returns `false` (and leaves `code`
/// unchanged) when the function contains an op outside the
/// implemented subset; the caller falls back or aborts per
/// policy.
///
/// `fixups` is the function-pointer / direct-call fixup table the
/// surrounding writer already maintains. The SSA emit appends one
/// `Fixup::Bl` per `Inst::Call`; the `apply_fixups` post-pass
/// resolves them once `pc_to_native` is final.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    code: &mut Vec<u8>,
    fixups: &mut Vec<Fixup>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    data_fixups: &mut Vec<DataFixup>,
    user_extern_data_refs: &mut Vec<super::UserExternDataRef>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    macho_tlv_fixups: &mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &mut Vec<super::MachoTlvDescriptor>,
    pc_to_native: &mut [usize],
    prologue_native: &mut alloc::collections::BTreeMap<usize, usize>,
    ssa_line_rows: &mut Vec<(usize, u32, u32)>,
) -> bool {
    let frame = Frame::for_function(func, alloc);
    let abi = target.abi();
    let scratch = ScratchPool::new();
    let snapshot = code.len();
    // Snapshot every fixup vector at function entry so a partial
    // emit can be rolled back cleanly. Without this, a bailed SSA
    // emit leaves queued fixups pointing into the truncated code
    // region and the caller's surrounding pass would patch later
    // code with the wrong offsets.
    let fixups_snapshot = fixups.len();
    let plt_call_fixups_snapshot = plt_call_fixups.len();
    let data_fixups_snapshot = data_fixups.len();
    let user_extern_data_refs_snapshot = user_extern_data_refs.len();
    let pending_func_fixups_snapshot = pending_func_fixups.len();
    let tls_index_fixups_snapshot = tls_index_fixups.len();
    let macho_tlv_fixups_snapshot = macho_tlv_fixups.len();
    let macho_tlv_descriptors_snapshot = macho_tlv_descriptors.len();

    emit_prologue(code, func, alloc, frame, abi);
    super::ssa_emit_common::record_post_prologue_pc(func, prologue_native, code.len());

    let mut block_offsets: Vec<usize> = alloc::vec![0; func.blocks.len()];
    let mut branch_fixups: Vec<BranchFixup> = Vec::new();
    // Per-function alloca bookkeeping. Set by `Inst::AllocaInit`
    // and read by `Inst::Intrinsic { kind: Alloca }`; zero
    // means the function doesn't use alloca.
    let mut current_alloca_top: u32 = 0;

    for (block_idx, block) in func.blocks.iter().enumerate() {
        block_offsets[block_idx] = code.len();
        super::ssa_emit_common::record_block_start_pc(
            block_idx,
            block.start_pc,
            pc_to_native,
            code.len(),
        );
        for v in block.inst_range.clone() {
            let inst = &func.insts[v as usize];
            let place = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
            // Skip pure insts whose value isn't consumed by any
            // other inst or terminator. Walker-side pattern folds
            // (LoadLocal, indexed-load) sometimes leave the
            // upstream `Add` / `BinopI` dead; the result
            // computation produces no machine code if no one
            // will read it.
            if super::ssa_emit_common::is_dead_pure(inst, v, alloc) {
                continue;
            }
            super::ssa_emit_common::record_inst_src(func, v, code.len(), ssa_line_rows);
            let data_fixups_pre_inst = data_fixups.len();
            if !emit_inst(
                code,
                inst,
                v,
                place,
                alloc,
                frame,
                &scratch,
                abi,
                target,
                fixups,
                plt_call_fixups,
                data_fixups,
                pending_func_fixups,
                imports,
                variadic_targets,
                tls_index_fixups,
                macho_tlv_fixups,
                macho_tlv_descriptors,
                &mut current_alloca_top,
            ) {
                #[cfg(feature = "std")]
                if std::env::var("BADC_DUMP_SSA").is_ok() {
                    eprintln!(
                        "ssa emit: bailed on inst v{v}: {:?} (place {:?})",
                        inst, place,
                    );
                }
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                tls_index_fixups.truncate(tls_index_fixups_snapshot);
                macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                return false;
            }
            // Convert the just-emitted ImmData's local `.data`
            // fixup into a named cross-TU reference when the
            // value-id appears in `extern_data_names`. The walker
            // emits `Inst::ImmData(0)` for every
            // `imm_data_extern`; this hop replaces the unit-local
            // `DataFixup` (which would lower to `.data section
            // symbol + 0`) with a `UserExternDataRef` carrying
            // the symbol name, so the ET_REL writer emits a
            // named undefined-data symbol + a reloc against it.
            if let Inst::ImmData(_) = inst
                && let Some(name) = extern_data_names.get(&v)
                && data_fixups.len() > data_fixups_pre_inst
            {
                let popped = data_fixups.pop().unwrap();
                user_extern_data_refs.push(super::UserExternDataRef {
                    instr_offset: popped.adrp_offset,
                    symbol_name: name.clone(),
                });
            }
        }
        match block.terminator {
            Terminator::Return(v) => emit_return(code, v, alloc, frame, &scratch, func, abi),
            Terminator::Jmp(t) => {
                branch_fixups.push(BranchFixup {
                    site: code.len(),
                    target: t,
                    kind: LocalBranchKind::B,
                });
                emit(code, enc_b(0));
            }
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => {
                if let Some(bcc) = fused_branch_cond(func, alloc, cond, /* negate */ true) {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target,
                        kind: LocalBranchKind::Bcc(bcc),
                    });
                    emit(code, enc_b_cond(bcc, 0));
                    if fall_through as usize != block_idx + 1 {
                        branch_fixups.push(BranchFixup {
                            site: code.len(),
                            target: fall_through,
                            kind: LocalBranchKind::B,
                        });
                        emit(code, enc_b(0));
                    }
                    continue;
                }
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                // The c5 conditional-branch ops treat the
                // accumulator as a 64-bit bit pattern: zero
                // branches Bz, anything else branches Bnz. An
                // FpReg-placed cond carries an f64 in d-reg
                // form; bridge it through `fmov x, d` so the
                // CBZ/CBNZ has an integer to compare on the
                // raw bit pattern.
                let rt = if let Place::FpReg(dr) = cond_place {
                    emit(code, enc_fmov_d_to_x(scratch.primary, dr));
                    scratch.primary
                } else {
                    match materialize_int(code, cond_place, scratch.primary, frame) {
                        Some(r) => r,
                        None => {
                            bail("Bz/Bnz: cond Place not int", cond, cond_place);
                            code.truncate(snapshot);
                            fixups.truncate(fixups_snapshot);
                            plt_call_fixups.truncate(plt_call_fixups_snapshot);
                            data_fixups.truncate(data_fixups_snapshot);
                            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                            pending_func_fixups.truncate(pending_func_fixups_snapshot);
                            tls_index_fixups.truncate(tls_index_fixups_snapshot);
                            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                            return false;
                        }
                    }
                };
                branch_fixups.push(BranchFixup {
                    site: code.len(),
                    target,
                    kind: LocalBranchKind::Cbz(rt),
                });
                emit(code, enc_cbz(rt, 0));
                if fall_through as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: fall_through,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => {
                if let Some(bcc) = fused_branch_cond(func, alloc, cond, /* negate */ false) {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target,
                        kind: LocalBranchKind::Bcc(bcc),
                    });
                    emit(code, enc_b_cond(bcc, 0));
                    if fall_through as usize != block_idx + 1 {
                        branch_fixups.push(BranchFixup {
                            site: code.len(),
                            target: fall_through,
                            kind: LocalBranchKind::B,
                        });
                        emit(code, enc_b(0));
                    }
                    continue;
                }
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                // The c5 conditional-branch ops treat the
                // accumulator as a 64-bit bit pattern: zero
                // branches Bz, anything else branches Bnz. An
                // FpReg-placed cond carries an f64 in d-reg
                // form; bridge it through `fmov x, d` so the
                // CBZ/CBNZ has an integer to compare on the
                // raw bit pattern.
                let rt = if let Place::FpReg(dr) = cond_place {
                    emit(code, enc_fmov_d_to_x(scratch.primary, dr));
                    scratch.primary
                } else {
                    match materialize_int(code, cond_place, scratch.primary, frame) {
                        Some(r) => r,
                        None => {
                            bail("Bz/Bnz: cond Place not int", cond, cond_place);
                            code.truncate(snapshot);
                            fixups.truncate(fixups_snapshot);
                            plt_call_fixups.truncate(plt_call_fixups_snapshot);
                            data_fixups.truncate(data_fixups_snapshot);
                            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                            pending_func_fixups.truncate(pending_func_fixups_snapshot);
                            tls_index_fixups.truncate(tls_index_fixups_snapshot);
                            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                            return false;
                        }
                    }
                };
                branch_fixups.push(BranchFixup {
                    site: code.len(),
                    target,
                    kind: LocalBranchKind::Cbnz(rt),
                });
                emit(code, enc_cbnz(rt, 0));
                if fall_through as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: fall_through,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::FallThrough(t) => {
                if t as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: t,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::TailExt(binding_idx) => {
                // Tail-jump through the GOT-patched trampoline:
                // `adrp x16, _ ; ldr x16, [x16, _] ; br x16`.
                // The writer fills the adrp / ldr immediates once
                // the trampoline target's RVA is final.
                let import_index = match imports.index_of_binding(binding_idx) {
                    Some(i) => i,
                    None => {
                        bail_msg("TailExt: no import slot for binding");
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        tls_index_fixups.truncate(tls_index_fixups_snapshot);
                        macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                        macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                        return false;
                    }
                };
                super::aarch64::emit_got_tail_jump(code, plt_call_fixups, import_index);
            }
        }
    }
    // Patch the recorded branches.
    for fx in &branch_fixups {
        let target_off = block_offsets[fx.target as usize];
        let rel = (target_off as i64) - (fx.site as i64);
        if rel % 4 != 0 {
            bail_msg("branch fixup: rel not 4-aligned");
            code.truncate(snapshot);
            fixups.truncate(fixups_snapshot);
            plt_call_fixups.truncate(plt_call_fixups_snapshot);
            data_fixups.truncate(data_fixups_snapshot);
            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
            pending_func_fixups.truncate(pending_func_fixups_snapshot);
            tls_index_fixups.truncate(tls_index_fixups_snapshot);
            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
            return false;
        }
        let imm = (rel / 4) as i32;
        let word = match fx.kind {
            LocalBranchKind::B => {
                if !(-(1 << 25)..(1 << 25)).contains(&imm) {
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_b(imm)
            }
            LocalBranchKind::Cbz(rt) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_cbz(rt, imm)
            }
            LocalBranchKind::Cbnz(rt) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_cbnz(rt, imm)
            }
            LocalBranchKind::Bcc(cond) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_b_cond(cond, imm)
            }
        };
        let bytes = word.to_le_bytes();
        code[fx.site..fx.site + 4].copy_from_slice(&bytes);
    }
    true
}

/// Per-function scratch register reservation. AAPCS64 calls x16
/// (IP0) and x17 (IP1) scratch; the SSA emit uses them for
/// reload / store sequences without recording them on the
/// allocator's `gpr_used` list.
struct ScratchPool {
    primary: Reg,
    secondary: Reg,
}

impl ScratchPool {
    fn new() -> Self {
        Self {
            primary: Reg(16),
            secondary: Reg(17),
        }
    }
}

/// Emit the function prologue.
fn emit_prologue(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) {
    // Host-arg-reg spill for non-variadic functions: spill each
    // declared int param into a 16-byte c5 cdecl slot above fp,
    // restripe any host-stack overflow into 16-byte slots.
    let entry_spill = if func.is_variadic { 0 } else { func.n_params };
    if entry_spill > 0 {
        let n_reg = entry_spill.min(abi.int_arg_regs.len());
        let n_stack = entry_spill - n_reg;
        if n_stack > 0 {
            let overflow_bytes = (n_stack as u32) * 16;
            emit_sub_sp_imm(code, overflow_bytes);
            for i in 0..n_stack {
                let host_off = (i as u32) * 8 + overflow_bytes;
                let c5_off = (i as u32) * 16;
                emit(code, enc_ldr_imm(Reg(16), Reg(31), host_off));
                emit(code, enc_str_imm(Reg(16), Reg(31), c5_off));
            }
        }
        for i in (0..n_reg).rev() {
            emit(code, enc_str_pre(Reg(abi.int_arg_regs[i]), Reg(31), -16));
        }
    }
    // Standard frame: stp fp/lr; mov fp, sp; sub sp, sp, frame_bytes.
    emit(code, enc_stp_pre(Reg(29), Reg(30), Reg(31), -16));
    emit(code, enc_add_imm(Reg(29), Reg(31), 0));
    if frame.frame_bytes > 0 {
        emit_sub_sp_imm(code, frame.frame_bytes);
    }
    // Save the allocator-reported callee-saved GPRs + FP regs at
    // the bottom of the frame. The saved-reg region sits just
    // above sp; addressing through sp with `enc_str_imm` keeps
    // the 12-bit scaled immediate (range 0..32760 in multiples
    // of 8) valid for any frame the compiler can produce. Using
    // `stur` off fp would silently truncate the 9-bit immediate
    // for frames larger than ~256 bytes.
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        let off = (i as u32) * 8;
        emit(code, enc_str_d_imm(r, Reg(31), off));
    }
    let saved_fpr_bytes = ((alloc.fp_used.len() as u32) * 8 + 15) & !15;
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = saved_fpr_bytes + (i as u32) * 8;
        emit(code, enc_str_imm(Reg(r), Reg(31), off));
    }
    // Save x19 just past the allocator-saved gprs, but only when the
    // function clobbers it. The slot is reserved either way so the
    // surrounding offsets stay fixed.
    if frame.uses_x19 {
        let saved_gpr_bytes = ((alloc.gpr_used.len() as u32) * 8 + 15) & !15;
        let x19_save_off = saved_fpr_bytes + saved_gpr_bytes;
        emit(code, enc_str_imm(Reg(19), Reg(31), x19_save_off));
    }
}

/// Byte offset (positive) from fp to the start of the saved-reg
/// region. The region is the lowest portion of the frame.
fn alloc_save_base(frame: Frame, alloc: &Allocation) -> u32 {
    let saved_gpr_bytes = ((alloc.gpr_used.len() as u32) * 8 + 15) & !15;
    let saved_fpr_bytes = ((alloc.fp_used.len() as u32) * 8 + 15) & !15;
    // fp is at frame top; the saved-reg region sits at the
    // bottom. Distance from fp = frame_bytes - saved-region size.
    frame
        .frame_bytes
        .saturating_sub(saved_gpr_bytes + saved_fpr_bytes)
}

/// Return the aarch64 condition code to use for a `B.cond` when
/// `cond` was flagged as branch-fused by the allocator. `negate`
/// is true for `Bz` (branch when comparison failed); false for
/// `Bnz`. Returns `None` when fusion doesn't apply (caller falls
/// back to the unfused `cbz` / `cbnz` path).
fn fused_branch_cond(
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    cond: super::super::ir::ValueId,
    negate: bool,
) -> Option<super::aarch64::Cond> {
    use super::aarch64::Cond;
    if !alloc
        .branch_fused
        .get(cond as usize)
        .copied()
        .unwrap_or(false)
    {
        return None;
    }
    let op = match func.insts.get(cond as usize)? {
        Inst::Binop { op, .. } | Inst::BinopI { op, .. } => *op,
        _ => return None,
    };
    let positive = match op {
        BinOp::Eq => Cond::Eq,
        BinOp::Ne => Cond::Ne,
        BinOp::Lt => Cond::Lt,
        BinOp::Gt => Cond::Gt,
        BinOp::Le => Cond::Le,
        BinOp::Ge => Cond::Ge,
        BinOp::Ult => Cond::Lo,
        BinOp::Ugt => Cond::Hi,
        BinOp::Ule => Cond::Ls,
        BinOp::Uge => Cond::Hs,
        _ => return None,
    };
    if !negate {
        return Some(positive);
    }
    Some(match positive {
        Cond::Eq => Cond::Ne,
        Cond::Ne => Cond::Eq,
        Cond::Lt => Cond::Ge,
        Cond::Gt => Cond::Le,
        Cond::Le => Cond::Gt,
        Cond::Ge => Cond::Lt,
        Cond::Lo => Cond::Hs,
        Cond::Hi => Cond::Ls,
        Cond::Ls => Cond::Hi,
        Cond::Hs => Cond::Lo,
        _ => return None,
    })
}

/// Emit one SSA instruction. Returns `false` for any op the thin
/// slice doesn't handle yet so the caller can fall back.
#[allow(clippy::too_many_arguments)]
fn emit_inst(
    code: &mut Vec<u8>,
    inst: &Inst,
    v: super::super::ir::ValueId,
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    abi: super::Abi,
    target: Target,
    fixups: &mut Vec<Fixup>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    data_fixups: &mut Vec<DataFixup>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    macho_tlv_fixups: &mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &mut Vec<super::MachoTlvDescriptor>,
    current_alloca_top: &mut u32,
) -> bool {
    match inst {
        Inst::AllocaInit(slot) => {
            // Slot 0: this function doesn't use alloca; emit
            // nothing (matches the pool path). Non-zero: the
            // bookkeeping slot lives at `[fp - slot*8]` and the
            // first alloca call subtracts from the value stored
            // there. Initialise the slot with its own address so
            // alloca(n) lands at `address - n`, the top of the
            // arena reserved by the prologue's local-slot count.
            if *slot == 0 {
                return true;
            }
            let top_offset = (*slot as u32) * 8;
            *current_alloca_top = top_offset;
            if top_offset < 4096 {
                emit(code, enc_sub_imm(Reg(16), Reg(29), top_offset));
            } else {
                let high = top_offset & !0xfff;
                let low = top_offset & 0xfff;
                emit(
                    code,
                    super::aarch64::enc_sub_imm_lsl12(Reg(16), Reg(29), high >> 12),
                );
                if low != 0 {
                    emit(code, enc_sub_imm(Reg(16), Reg(16), low));
                }
            }
            emit(code, enc_str_imm(Reg(16), Reg(16), 0));
            true
        }
        Inst::ParamRef { idx, kind } => {
            // Materialise the i-th AAPCS64 argument register into
            // the allocator's chosen `Place`, sign-extending the
            // low `kind` bytes per C99 6.3.1.3 so the value held
            // in the register is canonically 64-bit-sign-extended.
            // The prologue does not modify x0..x7, so the arg
            // value is still in its incoming register at this IR
            // position. Narrow-load promotion downstream can then
            // collapse `Inst::Extend(ParamRef, kind)` to a plain
            // copy when the kinds match.
            let Some(&arg_reg) = abi.int_arg_regs.get(*idx as usize) else {
                bail_msg("ParamRef: idx out of range for int_arg_regs");
                return false;
            };
            // The encoding to write `dst <- sign-extend(arg_reg)`.
            // For full-width kinds (I64), it is a plain mov.
            let sign_extend = |code: &mut Vec<u8>, rd: Reg| {
                let rn = Reg(arg_reg);
                match kind {
                    LoadKind::I8 => emit(code, super::aarch64::enc_sxtb(rd, rn)),
                    LoadKind::I16 => emit(code, super::aarch64::enc_sxth(rd, rn)),
                    LoadKind::I32 => emit(code, super::aarch64::enc_sxtw(rd, rn)),
                    _ => emit_mov_reg(code, rd, rn),
                }
            };
            match dst {
                Place::IntReg(r) => sign_extend(code, Reg(r)),
                Place::Spill(slot) => {
                    sign_extend(code, scratch.primary);
                    let sp_off = spill_off(frame, slot);
                    emit(code, enc_str_imm(scratch.primary, Reg(31), sp_off));
                }
                _ => {
                    bail_msg("ParamRef: dst not int reg / spill");
                    return false;
                }
            }
            true
        }
        Inst::Imm(value) => {
            let rd = match int_or_spill_scratch(dst, scratch) {
                Some(r) => r,
                None => return false,
            };
            load_imm64(code, rd, *value as u64);
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit(code, enc_str_imm(rd, Reg(31), sp_off));
            }
            true
        }
        Inst::ImmData(offset) => {
            let rd = match int_or_spill_scratch(dst, scratch) {
                Some(r) => r,
                None => return false,
            };
            // The writer's patch_adrp_add hardcodes x19 as the
            // adrp / add destination. Emit the placeholders with
            // x19, then move the materialised address into the
            // allocator's chosen register or spill slot.
            let adrp_offset = code.len();
            emit(code, enc_adrp(Reg(19), 0));
            emit(code, enc_add_imm(Reg(19), Reg(19), 0));
            data_fixups.push(DataFixup {
                adrp_offset,
                data_offset: *offset as u64,
            });
            emit_mov_reg(code, rd, Reg(19));
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit(code, enc_str_imm(rd, Reg(31), sp_off));
            }
            true
        }
        Inst::ImmCode(target_ent_pc) => {
            let rd = match int_or_spill_scratch(dst, scratch) {
                Some(r) => r,
                None => return false,
            };
            let adrp_offset = code.len();
            emit(code, enc_adrp(Reg(19), 0));
            emit(code, enc_add_imm(Reg(19), Reg(19), 0));
            pending_func_fixups.push((adrp_offset, *target_ent_pc));
            emit_mov_reg(code, rd, Reg(19));
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit(code, enc_str_imm(rd, Reg(31), sp_off));
            }
            true
        }
        Inst::LocalAddr(off) => emit_local_addr(code, dst, *off, frame),
        Inst::Load { addr, kind } => emit_load(code, dst, *addr, *kind, alloc, frame, scratch),
        Inst::Store { addr, value, kind } => {
            emit_store(code, dst, *addr, *value, *kind, alloc, frame, scratch)
        }
        Inst::LoadLocal { off, kind } => emit_load_local(code, dst, *off, *kind, frame, scratch),
        Inst::StoreLocal { off, value, kind } => {
            emit_store_local(code, dst, *off, *value, *kind, alloc, frame, scratch)
        }
        Inst::LoadIndexed {
            base,
            index,
            scale,
            kind,
        } => emit_load_indexed(
            code, dst, *base, *index, *scale, *kind, alloc, frame, scratch,
        ),
        Inst::StoreIndexed {
            base,
            index,
            scale,
            value,
            kind,
        } => emit_store_indexed(
            code, dst, *base, *index, *scale, *value, *kind, alloc, frame, scratch,
        ),
        Inst::Binop { op, lhs, rhs } => {
            emit_binop(code, *op, v, dst, *lhs, *rhs, alloc, frame, scratch)
        }
        Inst::BinopI { op, lhs, rhs_imm } => {
            emit_binop_imm(code, *op, v, dst, *lhs, *rhs_imm, alloc, frame, scratch)
        }
        Inst::Call { target_pc, args } => emit_call(
            code,
            dst,
            *target_pc,
            args,
            alloc,
            frame,
            scratch,
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
            scratch,
            abi,
            target,
            plt_call_fixups,
            imports,
        ),
        Inst::CallIndirect { target, args } => {
            emit_call_indirect(code, dst, *target, args, alloc, frame, scratch, abi)
        }
        Inst::Mcpy {
            dst: d,
            src: s,
            size,
        } => emit_mcpy(code, dst, *d, *s, *size, alloc, frame, scratch),
        Inst::Intrinsic { kind, args } => emit_intrinsic(
            code,
            *kind,
            args,
            dst,
            alloc,
            frame,
            scratch,
            *current_alloca_top,
        ),
        Inst::Fneg(v) => {
            let src_place = alloc
                .places
                .get(*v as usize)
                .copied()
                .unwrap_or(Place::None);
            let dn = match materialize_fp(code, src_place, 0, frame) {
                Some(r) => r,
                None => return false,
            };
            let dd = match dst {
                Place::FpReg(r) => r,
                Place::Spill(_) => 0u8,
                _ => return false,
            };
            emit(code, enc_fneg_d(dd, dn));
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit(code, enc_str_d_imm(dd, Reg(31), sp_off));
            }
            true
        }
        Inst::Extend { value, kind } => {
            emit_extend(code, dst, *value, *kind, alloc, frame, scratch)
        }
        Inst::FpCast { kind, value } => {
            use super::super::ir::FpCastKind;
            let src_place = alloc
                .places
                .get(*value as usize)
                .copied()
                .unwrap_or(Place::None);
            match kind {
                FpCastKind::IntToFp => {
                    let rn = match materialize_int(code, src_place, scratch.primary, frame) {
                        Some(r) => r,
                        None => return false,
                    };
                    let dd = match dst {
                        Place::FpReg(r) => r,
                        Place::Spill(_) => 0u8,
                        _ => return false,
                    };
                    emit(code, enc_scvtf_d_x(dd, rn));
                    if let Place::Spill(slot) = dst {
                        let sp_off = spill_off(frame, slot);
                        emit(code, enc_str_d_imm(dd, Reg(31), sp_off));
                    }
                    true
                }
                FpCastKind::FpToInt => {
                    let dn = match materialize_fp(code, src_place, 0, frame) {
                        Some(r) => r,
                        None => return false,
                    };
                    let rd = match dst {
                        Place::IntReg(r) => Reg(r),
                        Place::Spill(_) => scratch.primary,
                        _ => return false,
                    };
                    emit(code, enc_fcvtzs_x_d(rd, dn));
                    if let Place::Spill(slot) = dst {
                        let sp_off = spill_off(frame, slot);
                        emit(code, enc_str_imm(rd, Reg(31), sp_off));
                    }
                    true
                }
            }
        }
        Inst::TlsAddr(offset) => emit_tls_addr(
            code,
            dst,
            *offset,
            target,
            tls_index_fixups,
            macho_tlv_fixups,
            macho_tlv_descriptors,
        ),
        _ => false,
    }
}

/// `Inst::TlsAddr` lowering. Routes through the per-target TLS
/// access shape -- Linux variant 1 (TPIDR_EL0 + tcb + offset),
/// Windows TEB->TLS slot via `_tls_index` and the per-thread
/// pointer table at `[x18, #0x58]`, or Apple's TLV descriptor
/// table with the bootstrap getter. The 12-bit add immediate
/// limit on the per-variable offset matches the pool path; any
/// `_Thread_local` larger than 4080 bytes from `.tdata` falls
/// back to the pool path through the false return.
#[allow(clippy::too_many_arguments)]
fn emit_tls_addr(
    code: &mut Vec<u8>,
    dst: Place,
    offset: i64,
    target: Target,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    macho_tlv_fixups: &mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &mut Vec<super::MachoTlvDescriptor>,
) -> bool {
    use super::aarch64::{enc_blr, enc_ldr_reg_lsl3, enc_mrs_tpidr_el0};
    let Some(rd) = int_reg(dst) else {
        bail_msg("TlsAddr: dst not int reg");
        return false;
    };
    match target {
        Target::LinuxAarch64 => {
            let imm = (offset + 16) as u32;
            if imm >= 4096 {
                bail_msg("TlsAddr: offset exceeds 12-bit add immediate");
                return false;
            }
            emit(code, enc_mrs_tpidr_el0(rd));
            emit(code, enc_add_imm(rd, rd, imm));
            true
        }
        Target::WindowsAarch64 => {
            if offset >= 4096 {
                bail_msg("TlsAddr: offset exceeds 12-bit add immediate");
                return false;
            }
            // Windows/aarch64 TLS: x18 is the TEB pointer per the
            // platform ABI; TEB+0x58 holds the per-thread TLS
            // array. Index by `_tls_index` (loaded into x17) and
            // pick the slot for our module. x16 and x17 are
            // AAPCS64 scratches outside the SSA allocator pool
            // (callee=[20..27], caller=[9..15]).
            emit(code, enc_ldr_imm(Reg(16), Reg(18), 0x58));
            let pair_off = code.len();
            tls_index_fixups.push(super::TlsIndexFixup {
                instr_offset: pair_off,
            });
            emit(code, enc_adrp(Reg(17), 0));
            emit(code, enc_ldr32_imm(Reg(17), Reg(17), 0));
            emit(code, enc_ldr_reg_lsl3(Reg(16), Reg(16), Reg(17)));
            emit(code, enc_add_imm(rd, Reg(16), offset as u32));
            true
        }
        Target::MacOSAarch64 => {
            let descriptor_index = match macho_tlv_descriptors
                .iter()
                .position(|d| d.offset_in_block == offset as u64)
            {
                Some(i) => i,
                None => {
                    macho_tlv_descriptors.push(super::MachoTlvDescriptor {
                        offset_in_block: offset as u64,
                    });
                    macho_tlv_descriptors.len() - 1
                }
            };
            let adrp_off = code.len();
            macho_tlv_fixups.push(super::MachoTlvFixup {
                adrp_offset: adrp_off,
                descriptor_index,
            });
            emit(code, enc_adrp(Reg(0), 0));
            emit(code, enc_add_imm(Reg(0), Reg(0), 0));
            emit(code, enc_ldr_imm(Reg(16), Reg(0), 0));
            emit(code, enc_blr(Reg(16)));
            if rd.0 != 0 {
                emit_mov_reg(code, rd, Reg(0));
            }
            true
        }
        _ => {
            bail_msg("TlsAddr: target not aarch64");
            false
        }
    }
}

/// `Inst::Intrinsic` lowering. Each variant matches the pool
/// path's shape in [`super::aarch64::lower_op`] but pulls its
/// operands from the allocator's `Place`s rather than off the c5
/// stack / accumulator.
fn emit_intrinsic(
    code: &mut Vec<u8>,
    kind: i64,
    args: &[u32],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
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
            // args[1] = &last. Set *ap = &last + 16 (next c5 slot).
            if args.len() != 2 {
                bail_msg("VaStart: expected 2 args");
                return false;
            }
            let ap_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let last_place = alloc
                .places
                .get(args[1] as usize)
                .copied()
                .unwrap_or(Place::None);
            let ap_r = match materialize_int(code, ap_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            let last_r = match materialize_int(code, last_place, scratch.secondary, frame) {
                Some(r) => r,
                None => return false,
            };
            emit(code, enc_add_imm(scratch.secondary, last_r, 16));
            emit(code, enc_str_imm(scratch.secondary, ap_r, 0));
            true
        }
        I::VaArg => {
            // __builtin_va_arg(&ap) returns *ap and advances *ap
            // by 16 (one c5 slot in native layout). args[0] = &ap.
            if args.len() != 1 {
                bail_msg("VaArg: expected 1 arg");
                return false;
            }
            let Some(rd) = int_reg(dst) else {
                bail_msg("VaArg: dst not int reg");
                return false;
            };
            let ap_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let ap_r = match materialize_int(code, ap_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            // rd and ap_r can be the same register when the
            // allocator picks ap-value's freed slot for the
            // VaArg result. Route the load through a scratch
            // register so the cursor address survives the
            // writeback.
            if rd.0 == ap_r.0 {
                emit(code, enc_ldr_imm(scratch.secondary, ap_r, 0));
                emit(code, enc_add_imm(scratch.primary, scratch.secondary, 16));
                emit(code, enc_str_imm(scratch.primary, ap_r, 0));
                emit_mov_reg(code, rd, scratch.secondary);
            } else {
                emit(code, enc_ldr_imm(rd, ap_r, 0));
                emit(code, enc_add_imm(scratch.secondary, rd, 16));
                emit(code, enc_str_imm(scratch.secondary, ap_r, 0));
            }
            true
        }
        I::VaEnd => {
            // No teardown for the cursor model. args[0] is unused.
            true
        }
        I::VaCopy => {
            // __builtin_va_copy(&dst, &src). args[0] = &dst,
            // args[1] = &src. *dst = *src.
            if args.len() != 2 {
                bail_msg("VaCopy: expected 2 args");
                return false;
            }
            let dst_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let src_place = alloc
                .places
                .get(args[1] as usize)
                .copied()
                .unwrap_or(Place::None);
            let dst_r = match materialize_int(code, dst_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            let src_r = match materialize_int(code, src_place, scratch.secondary, frame) {
                Some(r) => r,
                None => return false,
            };
            emit(code, enc_ldr_imm(scratch.secondary, src_r, 0));
            emit(code, enc_str_imm(scratch.secondary, dst_r, 0));
            true
        }
        I::Alloca => {
            // alloca(n): round n up to 16-byte alignment, load
            // the current arena top from the bookkeeping slot
            // (initialised by `Inst::AllocaInit`), subtract n
            // to get the new top, write it back, return the new
            // top. `args[0]` carries the requested size; the
            // result of the intrinsic is the new top pointer.
            if current_alloca_top == 0 {
                bail_msg("Alloca: AllocaInit didn't run for this function");
                return false;
            }
            if args.len() != 1 {
                bail_msg("Alloca: expected 1 arg");
                return false;
            }
            let Some(rd) = int_reg(dst) else {
                bail_msg("Alloca: dst not int reg");
                return false;
            };
            let size_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let n = match materialize_int(code, size_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            // x17 = (n + 15) & ~15 -- the 16-byte-aligned size.
            emit(code, enc_add_imm(scratch.secondary, n, 15));
            emit(
                code,
                super::aarch64::enc_and_imm_neg16(scratch.secondary, scratch.secondary),
            );
            // x16 = &arena_top -- the bookkeeping slot's address.
            let top_offset = current_alloca_top;
            if top_offset < 4096 {
                emit(code, enc_sub_imm(scratch.primary, Reg(29), top_offset));
            } else {
                let high = top_offset & !0xfff;
                let low = top_offset & 0xfff;
                emit(
                    code,
                    super::aarch64::enc_sub_imm_lsl12(scratch.primary, Reg(29), high >> 12),
                );
                if low != 0 {
                    emit(code, enc_sub_imm(scratch.primary, scratch.primary, low));
                }
            }
            // *x16 -= aligned_size; rd = new top.
            emit(code, enc_ldr_imm(rd, scratch.primary, 0));
            emit(code, enc_sub_reg(rd, rd, scratch.secondary));
            emit(code, enc_str_imm(rd, scratch.primary, 0));
            true
        }
        I::SetjmpAArch64 => {
            // c5 binds <setjmp.h>'s setjmp() to this intrinsic on
            // Windows aarch64 because msvcrt's longjmp routes
            // through SEH and refuses a CRT-free `jmp_buf`. The
            // inline expansion mirrors the pool path: 25 AArch64
            // words that save x19-x28, x29, the resume PC, sp,
            // and d8-d15 into [env].
            if args.len() != 1 {
                bail_msg("Setjmp: expected 1 arg");
                return false;
            }
            let env_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let env_r = match materialize_int(code, env_place, scratch.primary, frame) {
                Some(r) => r,
                None => {
                    bail_msg("Setjmp: env not int reg / spill / fp");
                    return false;
                }
            };
            // The helper reads env from x19; route it there.
            if env_r.0 != 19 {
                emit_mov_reg(code, Reg(19), env_r);
            }
            emit_setjmp_aarch64(code);
            // After the helper, x19 holds 0 on the initial pass and
            // the longjmp val on a matching longjmp return. Route
            // x19 into dst (or spill to the dst slot) -- the
            // helper's saved-PC points past the helper's last
            // instruction, so the longjmp BR lands here.
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                bail_msg("Setjmp: dst not int reg / spill");
                return false;
            };
            if rd.0 != 19 {
                emit_mov_reg(code, rd, Reg(19));
            }
            spill_local_addr_to_dst(code, dst, rd, frame);
            true
        }
        I::LongjmpAArch64 => {
            // c5 binds <setjmp.h>'s longjmp() to this intrinsic on
            // Windows aarch64. args[0] = env, args[1] = val. The
            // helper restores the saved register set, materializes
            // x19 = (val != 0) ? val : 1 per C99 7.13.2.1p2, and
            // branches to the saved PC.
            if args.len() != 2 {
                bail_msg("Longjmp: expected 2 args");
                return false;
            }
            let env_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let val_place = alloc
                .places
                .get(args[1] as usize)
                .copied()
                .unwrap_or(Place::None);
            let env_r = match materialize_int(code, env_place, Reg(16), frame) {
                Some(r) => r,
                None => {
                    bail_msg("Longjmp: env not int reg / spill / fp");
                    return false;
                }
            };
            if env_r.0 != 16 {
                emit_mov_reg(code, Reg(16), env_r);
            }
            // Stash val in x17 (the secondary scratch in this
            // module) before the upcoming restores clobber x19.
            let val_r = match materialize_int(code, val_place, Reg(17), frame) {
                Some(r) => r,
                None => {
                    bail_msg("Longjmp: val not int reg / spill / fp");
                    return false;
                }
            };
            if val_r.0 != 17 {
                emit_mov_reg(code, Reg(17), val_r);
            }
            // Restore x19-x28 + x29 from [x16 + offset].
            for (i, off) in (JB_X19_OFF..JB_X29_OFF).step_by(8).enumerate() {
                emit(code, enc_ldr_imm(Reg(19 + i as u8), Reg(16), off));
            }
            emit(code, enc_ldr_imm(Reg(29), Reg(16), JB_X29_OFF));
            // Resume PC into x10, sp into x9. x10 is caller-saved
            // (setjmp's caller doesn't expect it preserved); x18
            // is the Windows TEB pointer and stays untouched.
            emit(code, enc_ldr_imm(Reg(10), Reg(16), JB_PC_OFF));
            emit(code, enc_ldr_imm(Reg(9), Reg(16), JB_SP_OFF));
            emit(code, enc_add_imm(Reg(31), Reg(9), 0));
            for (i, off) in (JB_D8_OFF..JB_D8_OFF + 64).step_by(8).enumerate() {
                emit(code, enc_ldr_d_imm(8 + i as u8, Reg(16), off));
            }
            // cmp val, #0 ; cinc x19, val, eq -- 0 becomes 1,
            // anything else passes through unchanged.
            emit(code, enc_subs_imm(Reg(31), Reg(17), 0));
            emit(code, enc_cinc(Reg(19), Reg(17), Cond::Eq));
            emit(code, enc_br(Reg(10)));
            true
        }
    }
}

/// External library call: arg marshalling identical to
/// `emit_call`, but the branch target is a PLT trampoline rather
/// than a c5 function. The trampoline gets a `PltCallFixup`
/// recorded; the writer's post-pass patches the BL displacement
/// once trampolines are laid out at the tail of the code blob.
#[allow(clippy::too_many_arguments)]
fn emit_call_ext(
    code: &mut Vec<u8>,
    dst: Place,
    binding_idx: i64,
    args: &[u32],
    fp_arg_mask: u32,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
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
    // Variadic calls feed `fixed_args` to the planner so it can
    // place the variadic tail per the host's variadic ABI
    // (macOS arm64: all on the stack; Win arm64 / Win64: int regs
    // first, then stack; Linux: standard register sequence). The
    // walker stamps the FP-arg bit mask from each `Expr::Call`'s
    // per-arg type so the planner routes FP args to d0..d7
    // instead of x0..x7.
    let fixed = if imp.is_variadic {
        imp.fixed_args.min(args.len())
    } else {
        args.len()
    };
    let plan = super::plan_call_args(args.len(), fixed, fp_arg_mask, abi);
    if plan.scratch_bytes > 0 {
        emit(code, enc_sub_imm(Reg(31), Reg(31), plan.scratch_bytes));
    }
    if !marshal_args(code, &plan, args, alloc, scratch, frame) {
        return false;
    }
    plt_call_fixups.push(PltCallFixup {
        instr_offset: code.len(),
        import_index,
        is_tail: false,
    });
    // BL: non-tail libc call -- the AAPCS64 return goes back
    // into main below for the result handling + `return`
    // epilogue. The apply_plt_call_fixups patcher only
    // rewrites imm26, so the placeholder opcode has to be BL
    // (`0x94000000`) not B (`0x14000000`); otherwise printf
    // ret's to main's caller and main's epilogue never runs.
    emit(code, enc_bl(0));
    // AAPCS64 returns `long double` (IEEE binary128) in v0 as a
    // single 128-bit Q register. c5 stores `long double` in an
    // 8-byte FP64 slot, so a `long double` libc return needs a
    // truncation pass before it becomes the c5 accumulator. The
    // libgcc helper `__trunctfdf2` takes binary128 in v0 and
    // returns FP64 in d0; the codegen pre-includes it on
    // LinuxAarch64. macOS / Windows AArch64 alias `long double`
    // to `double`, so v0 is already FP64 on those targets and
    // the truncation step is skipped.
    //
    // The follow-up must be `BL`, not `B`: the patcher only
    // rewrites imm26, so the placeholder opcode determines
    // whether LR gets set. With `B`, the trampoline's `ret`
    // reads the unchanged LR and jumps back to the same site.
    if imp.returns_long_double && target == Target::LinuxAarch64 {
        let trunc_idx = imports
            .imports
            .iter()
            .position(|i| i.local_name == "__trunctfdf2")
            .unwrap_or(usize::MAX);
        if trunc_idx == usize::MAX {
            bail_msg("CallExt: returns_long_double but __trunctfdf2 not in imports");
            return false;
        }
        plt_call_fixups.push(PltCallFixup {
            instr_offset: code.len(),
            import_index: trunc_idx,
            is_tail: false,
        });
        emit(code, enc_bl(0));
    }
    if plan.scratch_bytes > 0 {
        emit(code, enc_add_imm(Reg(31), Reg(31), plan.scratch_bytes));
    }
    // FP-returning libc fns hand the result back in d0 on
    // AAPCS64; bridge it into x0 so the rest of the c5 model
    // (which reads every return through the integer accumulator
    // chain) sees the bit pattern. Sub-word integer returns
    // receive the same signed / unsigned extension sequence on
    // x0 that the pool path applies.
    use crate::c5::compiler::types as ty_helpers;
    let return_type_tag = imp.return_type_tag;
    let bare = ty_helpers::strip_unsigned(return_type_tag);
    let returns_fp = ty_helpers::is_float_ty(bare) || ty_helpers::is_double_ty(bare);
    if returns_fp || imp.returns_long_double {
        emit(code, enc_fmov_d_to_x(Reg(0), 0));
    } else {
        let ext = super::return_extension(return_type_tag, target);
        emit_extend_x0_for_return(code, ext);
    }
    if let Some(rd) = int_reg(dst) {
        if rd.0 != 0 {
            emit_mov_reg(code, rd, Reg(0));
        }
    } else if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit(code, enc_str_imm(Reg(0), Reg(31), sp_off));
    }
    true
}

/// Emit the same sub-word sign / zero extension the pool path's
/// `emit_extend_x19_for_return` issues, but targeted at x0 since
/// the SSA emit's accumulator stays in x0 through the call's
/// dst-place propagation. `ReturnExt::None` is a no-op.
fn emit_extend_x0_for_return(code: &mut Vec<u8>, ext: super::ReturnExt) {
    use super::ReturnExt;
    // The four encodings below match the pool path's helper:
    //   sxtb x0, w0    -- sign-extend byte
    //   sxth x0, w0    -- sign-extend half
    //   sxtw x0, w0    -- sign-extend word
    //   uxtb w0, w0    -- zero-extend byte
    //   uxth w0, w0    -- zero-extend half
    //   mov  w0, w0    -- zero-extend word (clears upper bits)
    let word = match ext {
        ReturnExt::None => return,
        ReturnExt::Sign8 => 0x93401C00,
        ReturnExt::Sign16 => 0x93403C00,
        ReturnExt::Sign32 => 0x93407C00,
        ReturnExt::Zero8 => 0x53001C00,
        ReturnExt::Zero16 => 0x53003C00,
        ReturnExt::Zero32 => 0x2A0003E0,
    };
    emit(code, word);
}

/// Recover the codegen `Target` from the ABI struct so
/// `return_extension` can compute the per-target extension shape.
/// The ABI struct carries enough state to distinguish each
/// target's variadic / arg-placement rules; the host-arg-reg list
/// is what we discriminate on here because it's stable across
/// every target's `Abi::for_target`.
fn target_for_ext(abi: super::Abi) -> Target {
    // Same arg-reg signature differentiates AAPCS64 vs the x86_64
    // ABIs that share `Target` ids; the SSA emit only runs on
    // aarch64 today so this is enough to compute the extension.
    if abi.int_arg_regs.len() == 8 {
        Target::MacOSAarch64
    } else {
        Target::LinuxAarch64
    }
}

/// Direct call to a c5 user function at ent_pc `target_pc`.
/// Marshalls args into the host-ABI int arg registers (the FP
/// path isn't part of the thin slice yet -- bail out on any FP-
/// kind arg), copies overflow args onto the host stack, BL the
/// placeholder, and records a `Fixup::Bl` for the outer fixup
/// pass to resolve. Result lands in x0; the SSA emit moves it to
/// the inst's `dst` if needed.
fn emit_call(
    code: &mut Vec<u8>,
    dst: Place,
    target_pc: usize,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    callee_is_variadic: bool,
) -> bool {
    if callee_is_variadic {
        // The variadic c5 ABI keeps the c5 stack: every arg is
        // pushed at a 16-byte stride matching the accumulator
        // push. The callee's prologue (`emit_prologue` with
        // entry_spill=0) skips host-arg-reg spills and reads its
        // args through the address-of-local path at
        // `fp + 16*(N-1)`. `va_start` continues the walk past the
        // last named arg.
        //
        // Push args in cdecl order: args[N-1] first (deepest), so
        // args[0] -- the first declared arg -- lands on top of the
        // stack and the callee reads it through its first param
        // slot.
        for (i, &arg_id) in args.iter().rev().enumerate() {
            let arg_place = alloc
                .places
                .get(arg_id as usize)
                .copied()
                .unwrap_or(Place::None);
            let sp_shift = (i as u32) * 16;
            let src =
                match materialize_int_shifted(code, arg_place, scratch.primary, frame, sp_shift) {
                    Some(r) => r,
                    None => return false,
                };
            emit(code, enc_str_pre(src, Reg(31), -16));
        }
        fixups.push(Fixup {
            native_offset: code.len(),
            target_ent_pc: target_pc,
            kind: BranchKind::Bl,
        });
        emit(code, enc_bl(0));
        if !args.is_empty() {
            emit(
                code,
                enc_add_imm(Reg(31), Reg(31), (args.len() as u32) * 16),
            );
        }
        if let Some(rd) = int_reg(dst) {
            if rd.0 != 0 {
                emit_mov_reg(code, rd, Reg(0));
            }
        } else if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(Reg(0), Reg(31), sp_off));
        }
        return true;
    }
    // Non-variadic: marshal through the host ABI. Compute the
    // FP-arg mask from each value's Place -- the SSA model has
    // no separate type channel, but an FpReg-placed value is
    // necessarily f64. Feeding the mask to the planner routes
    // those args to d0..d7 instead of x0..x7.
    let fp_arg_mask = args.iter().enumerate().fold(0u32, |m, (i, &v)| {
        let p = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
        if matches!(p, Place::FpReg(_)) {
            m | (1u32 << i)
        } else {
            m
        }
    });
    let plan = super::plan_call_args(args.len(), args.len(), fp_arg_mask, abi);
    if plan.scratch_bytes > 0 {
        emit(code, enc_sub_imm(Reg(31), Reg(31), plan.scratch_bytes));
    }
    if !marshal_args(code, &plan, args, alloc, scratch, frame) {
        return false;
    }
    // Branch placeholder + fixup. The pool path's apply_fixups
    // resolves `target_ent_pc` -> `pc_to_native` once
    // the map is final.
    fixups.push(Fixup {
        native_offset: code.len(),
        target_ent_pc: target_pc,
        kind: BranchKind::Bl,
    });
    emit(code, enc_bl(0));
    if plan.scratch_bytes > 0 {
        emit(code, enc_add_imm(Reg(31), Reg(31), plan.scratch_bytes));
    }
    // Move the return value into the call's dst Place. AAPCS64
    // returns f64 in d0 and ints / pointers in x0. The dst's
    // Place tells which bank the SSA allocator wants the value
    // in.
    move_call_result(code, dst, frame);
    true
}

/// Common return-value bridge shared by `emit_call`,
/// `emit_call_ext`, and `emit_call_indirect`. Copies the AAPCS64
/// return register into the call's SSA dst place. Returns are in
/// d0 for f64, x0 otherwise; this routine handles both plus a
/// spill destination.
fn move_call_result(code: &mut Vec<u8>, dst: Place, frame: Frame) {
    match dst {
        Place::IntReg(r) => {
            if r != 0 {
                emit_mov_reg(code, Reg(r), Reg(0));
            }
        }
        Place::FpReg(r) => {
            if r != 0 {
                // d-reg copy via x16 since we have no fmov.d
                // direct.
                emit(code, enc_fmov_d_to_x(Reg(16), 0));
                emit(code, enc_fmov_x_to_d(r, Reg(16)));
            }
        }
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            // The allocator gives Spill the same 8-byte slot
            // regardless of result kind, so store the wide
            // pattern via x0 directly.
            emit(code, enc_str_imm(Reg(0), Reg(31), sp_off));
        }
        Place::None => {}
    }
}

/// Indirect call through a function-pointer value. Mirrors the
/// pool path's indirect-call lowering: marshal args per the host
/// ABI, capture the target into a callee-overwritable scratch
/// register that arg marshalling won't clobber, `blr`, recover
/// the return value.
/// FP args and variadic indirect callees aren't part of the thin
/// slice; either case returns false.
fn emit_call_indirect(
    code: &mut Vec<u8>,
    dst: Place,
    target: u32,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    abi: super::Abi,
) -> bool {
    let target_place = alloc
        .places
        .get(target as usize)
        .copied()
        .unwrap_or(Place::None);
    // Capture the function pointer into x9 before marshalling
    // touches any of x0..x7 or scratch.primary (x16). AAPCS64
    // doesn't assign x9 to int args, so the marshalling loop
    // can't overwrite it. x9 is caller-saved, but the blr happens
    // before the callee can do anything observable to x9, so the
    // value reaches the indirect branch intact.
    let target_r = match materialize_int(code, target_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    if target_r.0 != 9 {
        emit_mov_reg(code, Reg(9), target_r);
    }
    // Indirect calls keep the c5-stack push shape regardless of
    // whether the callee is variadic. Variadic c5 callees read
    // their args off the 16-byte-stride stack (their prologue
    // skips the host-arg-reg spill); non-variadic callees pull
    // their args from x0..x7 + host stack overflow, ignoring the
    // c5 stack pushes. Mirroring the pool path's indirect-call
    // shape -- push every arg first, then load the prefix into
    // host arg regs, then blr -- handles both at the indirect
    // call site without needing the callee's variadic flag.
    let fp_arg_mask = args.iter().enumerate().fold(0u32, |m, (i, &v)| {
        let p = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
        if matches!(p, Place::FpReg(_)) {
            m | (1u32 << i)
        } else {
            m
        }
    });
    for (i, &arg_id) in args.iter().rev().enumerate() {
        let arg_place = alloc
            .places
            .get(arg_id as usize)
            .copied()
            .unwrap_or(Place::None);
        let sp_shift = (i as u32) * 16;
        let src = if let Place::FpReg(_) = arg_place {
            // FP value: load into d-reg, then move bit pattern
            // into x16 for the 16-byte stride push.
            let dn = match materialize_fp_shifted(code, arg_place, 0, frame, sp_shift) {
                Some(r) => r,
                None => return false,
            };
            emit(code, enc_fmov_d_to_x(scratch.primary, dn));
            scratch.primary
        } else {
            match materialize_int_shifted(code, arg_place, scratch.primary, frame, sp_shift) {
                Some(r) => r,
                None => return false,
            }
        };
        emit(code, enc_str_pre(src, Reg(31), -16));
    }
    let pushed_bytes = (args.len() as u32) * 16;
    // Load the prefix into host arg regs from the c5-stride
    // stack we just laid down. Non-variadic callees expect this
    // shape; variadic callees ignore the host arg regs but read
    // the same slots through the address-of-local path. Stack
    // overflow (args
    // past 8) stays on the c5 stack at `[sp + i*16]`, which the
    // callee prologue's overflow restripe loop also reads from.
    let plan = super::plan_call_args(args.len(), args.len(), fp_arg_mask, abi);
    if plan.scratch_bytes > 0 {
        emit(code, enc_sub_imm(Reg(31), Reg(31), plan.scratch_bytes));
    }
    for (i, &placement) in plan.placements.iter().enumerate() {
        match placement {
            super::ArgPlacement::IntReg(r) => {
                let src_off = plan.scratch_bytes + (i as u32) * 16;
                emit(code, enc_ldr_imm(Reg(r), Reg(31), src_off));
            }
            super::ArgPlacement::FpReg(r) => {
                let src_off = plan.scratch_bytes + (i as u32) * 16;
                emit(code, enc_ldr_d_imm(r, Reg(31), src_off));
            }
            super::ArgPlacement::Stack(off) => {
                let src_off = plan.scratch_bytes + (i as u32) * 16;
                emit(code, enc_ldr_imm(scratch.primary, Reg(31), src_off));
                emit(code, enc_str_imm(scratch.primary, Reg(31), off));
            }
        }
    }
    emit(code, enc_blr(Reg(9)));
    if plan.scratch_bytes > 0 {
        emit(code, enc_add_imm(Reg(31), Reg(31), plan.scratch_bytes));
    }
    // Drop the 16-byte-stride argument pushes.
    if pushed_bytes > 0 {
        emit(code, enc_add_imm(Reg(31), Reg(31), pushed_bytes));
    }
    if let Some(rd) = int_reg(dst) {
        if rd.0 != 0 {
            emit_mov_reg(code, rd, Reg(0));
        }
    } else if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit(code, enc_str_imm(Reg(0), Reg(31), sp_off));
    }
    true
}

/// Compile-time-unrolled struct copy. `size` bytes from [src] to
/// [dst]; emits 8-byte ldr/str pairs for whole words and a
/// ldrb/strb tail for any sub-word remainder. The defined value
/// is `dst` -- mirrors C's `memcpy(dst, src, size)` return.
fn emit_mcpy(
    code: &mut Vec<u8>,
    dst_place: Place,
    dst_val: u32,
    src_val: u32,
    size: i64,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    if size < 0 {
        bail_msg("Mcpy: negative size");
        return false;
    }
    let dst_place_in = alloc
        .places
        .get(dst_val as usize)
        .copied()
        .unwrap_or(Place::None);
    let src_place_in = alloc
        .places
        .get(src_val as usize)
        .copied()
        .unwrap_or(Place::None);
    let dst_r = match materialize_int(code, dst_place_in, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let src_r = match materialize_int(code, src_place_in, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    // Mcpy needs a third register for each ldr/str pair. The
    // allocator pool covers x9..x15 + x20..x27 (target-dependent)
    // and may hold a live value in any of them; the SSA emit
    // sees only `Place`s, not liveness past this inst. Reserve
    // x10 unconditionally and save/restore it through one 16-byte
    // stack slot so it doesn't matter whether the allocator has
    // x10 in active use. The slot is dropped before the next
    // instruction sees sp.
    //
    // Pick a temp distinct from both bases. The save/restore
    // protects whatever the allocator parked in the chosen reg;
    // the aliasing check ensures we don't pick a temp that shares
    // a number with `dst_r` or `src_r`, which would corrupt the
    // base on the first ldr/str pair.
    let temp = if dst_r.0 != 10 && src_r.0 != 10 {
        Reg(10)
    } else if dst_r.0 != 11 && src_r.0 != 11 {
        Reg(11)
    } else {
        Reg(12)
    };
    let bytes = size as u32;
    emit(code, enc_str_pre(temp, Reg(31), -16));
    let words = bytes / 8;
    for w in 0..words {
        let off = w * 8;
        emit(code, enc_ldr_imm(temp, src_r, off));
        emit(code, enc_str_imm(temp, dst_r, off));
    }
    let tail_start = words * 8;
    for i in 0..(bytes - tail_start) {
        let off = tail_start + i;
        emit(code, enc_ldrb_imm(temp, src_r, off));
        emit(code, enc_strb_imm(temp, dst_r, off));
    }
    emit(code, enc_ldr_post(temp, Reg(31), 16));
    // memcpy returns dst -- propagate into the Inst's `dst_place`.
    if let Some(rd) = int_reg(dst_place) {
        if rd.0 != dst_r.0 {
            emit_mov_reg(code, rd, dst_r);
        }
    } else if let Place::Spill(slot) = dst_place {
        let sp_off = spill_off(frame, slot);
        emit(code, enc_str_imm(dst_r, Reg(31), sp_off));
    }
    true
}

/// Translate a c5-stack slot index (the operand of an
/// address-of-local emit) into a byte offset relative to fp.
/// Mirror of the pool path's
use super::ssa_emit_common::c5_slot_to_fp_offset;

fn emit_local_addr(code: &mut Vec<u8>, dst: Place, off: i64, frame: Frame) -> bool {
    // Materialise the address through scratch.primary when the
    // allocator chose a spill slot for this LocalAddr, then store
    // the computed value into the spill slot. Register places
    // address straight into the chosen reg.
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            bail_msg("LocalAddr: dst not int reg / spill");
            return false;
        }
    };
    let bytes = c5_slot_to_fp_offset(off);
    let abs = bytes.unsigned_abs();
    // Up to imm12 fits in a single add/sub-imm.
    if abs < 4096 {
        let imm = abs as u32;
        if bytes >= 0 {
            emit(code, enc_add_imm(rd, Reg(29), imm));
        } else {
            emit(code, enc_sub_imm(rd, Reg(29), imm));
        }
        spill_local_addr_to_dst(code, dst, rd, frame);
        return true;
    }
    // 24-bit reach via two add/sub-imm: shift-12 hi half + plain
    // lo half.
    if abs < (1u64 << 24) {
        let hi = abs & !0xfff;
        let lo = abs & 0xfff;
        if bytes >= 0 {
            if hi != 0 {
                emit(
                    code,
                    super::aarch64::enc_add_imm_lsl12(rd, Reg(29), (hi >> 12) as u32),
                );
            }
            if lo != 0 {
                let base = if hi != 0 { rd } else { Reg(29) };
                emit(code, enc_add_imm(rd, base, lo as u32));
            }
        } else {
            if hi != 0 {
                emit(
                    code,
                    super::aarch64::enc_sub_imm_lsl12(rd, Reg(29), (hi >> 12) as u32),
                );
            }
            if lo != 0 {
                let base = if hi != 0 { rd } else { Reg(29) };
                emit(code, enc_sub_imm(rd, base, lo as u32));
            }
        }
        spill_local_addr_to_dst(code, dst, rd, frame);
        return true;
    }
    bail_msg(&alloc::format!(
        "LocalAddr: offset {bytes} exceeds 24-bit reach"
    ));
    false
}

/// Pick the working register for a single-result int inst:
/// the allocator's chosen reg when it picked one, or
/// `scratch.primary` when the result will land in a spill slot.
/// FpReg / None destinations return `None` so the caller can
/// bail.
fn int_or_spill_scratch(dst: Place, scratch: &ScratchPool) -> Option<Reg> {
    match dst {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(scratch.primary),
        Place::FpReg(_) | Place::None => None,
    }
}

/// Persist the just-computed LocalAddr value into its spill slot
/// when the allocator placed it there. No-op for register places
/// (the address already landed in the chosen reg).
fn spill_local_addr_to_dst(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit(code, enc_str_imm(src, Reg(31), sp_off));
    }
}

/// `Inst::Extend { value, kind }` -- sign-extend the low bytes of a
/// GPR value to 64 bits via the `SXTB` / `SXTH` / `SXTW` aliases.
fn emit_extend(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, src_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rd = match int_or_spill_scratch(dst, scratch) {
        Some(r) => r,
        None => {
            bail_msg("Extend: dst not int reg / spill");
            return false;
        }
    };
    let enc = match kind {
        LoadKind::I8 => super::aarch64::enc_sxtb(rd, rn),
        LoadKind::I16 => super::aarch64::enc_sxth(rd, rn),
        LoadKind::I32 => super::aarch64::enc_sxtw(rd, rn),
        _ => {
            bail_msg("Extend: unsupported kind");
            return false;
        }
    };
    emit(code, enc);
    spill_local_addr_to_dst(code, dst, rd, frame);
    true
}

fn emit_load(
    code: &mut Vec<u8>,
    dst: Place,
    addr: u32,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let addr_place = alloc
        .places
        .get(addr as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, addr_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    // F32 loads land in a d-reg (widened to f64 via fcvt). All
    // other widths land in a GPR.
    if let LoadKind::F32 = kind {
        let dd = match dst {
            Place::FpReg(r) => r,
            // The allocator never spills f64 into a GPR slot;
            // bail and let the caller report.
            Place::Spill(_) => 0u8, // scratch d0
            _ => {
                bail_msg("Load F32: dst not fp reg / spill");
                return false;
            }
        };
        emit(code, enc_ldr_s_imm(dd, rn, 0));
        emit(code, enc_fcvt_d_s(dd, dd));
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_d_imm(dd, Reg(31), sp_off));
        }
        return true;
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return false,
    };
    match kind {
        LoadKind::I64 => emit(code, enc_ldr_imm(rd, rn, 0)),
        LoadKind::I32 => emit(code, enc_ldrsw_imm(rd, rn, 0)),
        LoadKind::U32 => emit(code, enc_ldr32_imm(rd, rn, 0)),
        LoadKind::I16 => emit(code, enc_ldrsh_imm(rd, rn, 0)),
        LoadKind::U16 => emit(code, enc_ldrh_imm(rd, rn, 0)),
        LoadKind::I8 => emit(code, enc_ldrsb_imm(rd, rn, 0)),
        LoadKind::U8 => emit(code, enc_ldrb_imm(rd, rn, 0)),
        LoadKind::F32 => unreachable!(),
    }
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit(code, enc_str_imm(rd, Reg(31), sp_off));
    }
    true
}

/// Single-instruction fp-relative load for `Inst::LoadLocal`.
/// The c5 slot offset converts to a signed byte displacement;
/// `ldur` covers the unscaled 9-bit field `[-256, 255]`
/// directly. Falls back to the general path when the
/// displacement doesn't fit.
fn emit_load_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    kind: LoadKind,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    // F32 lands in a d-reg via a 32-bit FP load + fcvt-to-f64.
    if matches!(kind, LoadKind::F32) {
        let dd = match dst {
            Place::FpReg(r) => r,
            Place::Spill(_) => 0u8,
            _ => {
                bail_msg("LoadLocal F32: dst not fp reg / spill");
                return false;
            }
        };
        let bytes = c5_slot_to_fp_offset(off);
        if let Ok(disp) = i32::try_from(bytes)
            && disp >= 0
            && (disp as u32).is_multiple_of(4)
            && (disp as u32) <= 16380
        {
            emit(
                code,
                super::aarch64::enc_ldr_s_imm(dd, Reg(29), disp as u32),
            );
        } else if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, frame) {
            return false;
        } else {
            emit(code, super::aarch64::enc_ldr_s_imm(dd, scratch.primary, 0));
        }
        emit(code, super::aarch64::enc_fcvt_d_s(dd, dd));
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit(code, super::aarch64::enc_str_d_imm(dd, Reg(31), sp_off));
        }
        return true;
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return false,
    };
    let bytes = c5_slot_to_fp_offset(off);
    if let Ok(disp) = i32::try_from(bytes)
        && (-256..256).contains(&disp)
    {
        // Fits the unscaled 9-bit signed field; load directly
        // with the kind-specific unscaled encoder.
        let word = match kind {
            LoadKind::I64 => super::aarch64::enc_ldur(rd, Reg(29), disp),
            LoadKind::I32 => super::aarch64::enc_ldursw(rd, Reg(29), disp),
            LoadKind::U32 => super::aarch64::enc_ldur32(rd, Reg(29), disp),
            LoadKind::I16 => super::aarch64::enc_ldursh(rd, Reg(29), disp),
            LoadKind::U16 => super::aarch64::enc_ldurh(rd, Reg(29), disp),
            LoadKind::I8 => super::aarch64::enc_ldursb(rd, Reg(29), disp),
            LoadKind::U8 => super::aarch64::enc_ldurb(rd, Reg(29), disp),
            LoadKind::F32 => unreachable!(),
        };
        emit(code, word);
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(rd, Reg(31), sp_off));
        }
        return true;
    }
    // Large displacement: materialise the address into a scratch
    // through the standard `LocalAddr` lowering, then load
    // through it. Same byte cost as the unfused path.
    if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, frame) {
        return false;
    }
    let word = match kind {
        LoadKind::I64 => super::aarch64::enc_ldr_imm(rd, scratch.primary, 0),
        LoadKind::I32 => super::aarch64::enc_ldrsw_imm(rd, scratch.primary, 0),
        LoadKind::U32 => super::aarch64::enc_ldr32_imm(rd, scratch.primary, 0),
        LoadKind::I16 => super::aarch64::enc_ldrsh_imm(rd, scratch.primary, 0),
        LoadKind::U16 => super::aarch64::enc_ldrh_imm(rd, scratch.primary, 0),
        LoadKind::I8 => super::aarch64::enc_ldrsb_imm(rd, scratch.primary, 0),
        LoadKind::U8 => super::aarch64::enc_ldrb_imm(rd, scratch.primary, 0),
        LoadKind::F32 => unreachable!(),
    };
    emit(code, word);
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit(code, enc_str_imm(rd, Reg(31), sp_off));
    }
    true
}

/// Single-instruction fp-relative store for `Inst::StoreLocal`.
/// Mirrors [`emit_load_local`].
fn emit_store_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    if matches!(kind, StoreKind::F32) {
        bail_msg("StoreLocal: F32 routes through LocalAddr + Store");
        return false;
    }
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    // Materialise the value first; the address path below picks a
    // scratch register based on whether the displacement fits the
    // unscaled 9-bit field. c5 spills an FP-typed accumulator into
    // a local temp through the store-local path (the bit pattern
    // fits 8 bytes
    // regardless of type), so an FpReg value bridges through
    // `fmov d -> x` into a GPR before the store; otherwise it
    // routes through the normal int materialisation.
    let rv = if let Place::FpReg(dr) = value_place {
        emit(code, super::aarch64::enc_fmov_d_to_x(scratch.primary, dr));
        scratch.primary
    } else {
        match materialize_int(code, value_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        }
    };
    let bytes = c5_slot_to_fp_offset(off);
    if let Ok(disp) = i32::try_from(bytes) {
        if (-256..256).contains(&disp) {
            // Store the low `kind`-width bytes; the accumulator below
            // keeps the full source value, matching the c5 rule that
            // an assignment expression yields the stored value before
            // any re-narrowing on read-back (C99 6.5.16p3).
            let enc = match kind {
                StoreKind::I64 => super::aarch64::enc_stur(rv, Reg(29), disp),
                StoreKind::I32 => super::aarch64::enc_stur32(rv, Reg(29), disp),
                StoreKind::I16 => super::aarch64::enc_sturh(rv, Reg(29), disp),
                StoreKind::I8 => super::aarch64::enc_sturb(rv, Reg(29), disp),
                StoreKind::F32 => unreachable!(),
            };
            emit(code, enc);
        } else if !emit_store_local_large_disp(code, off, rv, kind, scratch, frame) {
            return false;
        }
    } else if !emit_store_local_large_disp(code, off, rv, kind, scratch, frame) {
        return false;
    }
    // c5 store ops leave the stored value in the accumulator;
    // propagate to dst if the allocator parked it elsewhere.
    match dst {
        Place::IntReg(r) => {
            let rd = Reg(r);
            if rd.0 != rv.0 {
                emit_mov_reg(code, rd, rv);
            }
        }
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(rv, Reg(31), sp_off));
        }
        Place::None => {}
        Place::FpReg(_) => return false,
    }
    true
}

/// Address-via-scratch fallback for [`emit_store_local`] when the
/// fp displacement exceeds the unscaled 9-bit field.
fn emit_store_local_large_disp(
    code: &mut Vec<u8>,
    off: i64,
    rv: Reg,
    kind: StoreKind,
    scratch: &ScratchPool,
    frame: Frame,
) -> bool {
    if !emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, frame) {
        return false;
    }
    let enc = match kind {
        StoreKind::I64 => super::aarch64::enc_str_imm(rv, scratch.secondary, 0),
        StoreKind::I32 => super::aarch64::enc_str32_imm(rv, scratch.secondary, 0),
        StoreKind::I16 => super::aarch64::enc_strh_imm(rv, scratch.secondary, 0),
        StoreKind::I8 => super::aarch64::enc_strb_imm(rv, scratch.secondary, 0),
        StoreKind::F32 => unreachable!(),
    };
    emit(code, enc);
    true
}

/// Lower `Inst::LoadIndexed`: `dst = *(kind*)(base + index * scale)`.
/// Emitted as one scaled-indexed load (`ldr Xt, [Xn, Xm, lsl #N]`)
/// when `scale` matches the natural width of `kind`. F32 indexed
/// loads aren't a shape the walker produces today (no `float arr[]`
/// access path goes through the indexed fold yet); the FP variant
/// would need a separate `ldr St, [Xn, Xm, lsl #2]` + `fcvt d, s`.
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
    scratch: &ScratchPool,
) -> bool {
    if matches!(kind, LoadKind::F32) {
        bail_msg("LoadIndexed: F32 not implemented");
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
    let rn = match materialize_int(code, base_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rm = match materialize_int(code, index_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return false,
    };
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
    let word = match kind {
        LoadKind::I64 => super::aarch64::enc_ldr_reg_lsl3(rd, rn, rm),
        LoadKind::I32 => super::aarch64::enc_ldrsw_reg_lsl2(rd, rn, rm),
        LoadKind::U32 => super::aarch64::enc_ldr32_reg_lsl2(rd, rn, rm),
        LoadKind::I16 => super::aarch64::enc_ldrsh_reg_lsl1(rd, rn, rm),
        LoadKind::U16 => super::aarch64::enc_ldrh_reg_lsl1(rd, rn, rm),
        LoadKind::I8 => super::aarch64::enc_ldrsb_reg(rd, rn, rm),
        LoadKind::U8 => super::aarch64::enc_ldrb_reg(rd, rn, rm),
        LoadKind::F32 => unreachable!(),
    };
    emit(code, word);
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit(code, enc_str_imm(rd, Reg(31), sp_off));
    }
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
    scratch: &ScratchPool,
) -> bool {
    if matches!(kind, StoreKind::F32) {
        bail_msg("StoreIndexed: F32 not implemented");
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
    let rn = match materialize_int(code, base_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rm = match materialize_int(code, index_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    // The store value needs its own scratch; reuse the FP-bridge
    // path from `emit_store_local` for the I64-store-of-FpReg shape.
    let rv = if let StoreKind::I64 = kind
        && let Place::FpReg(dr) = value_place
    {
        emit(code, super::aarch64::enc_fmov_d_to_x(Reg(16), dr));
        Reg(16)
    } else {
        match materialize_int(code, value_place, Reg(16), frame) {
            Some(r) => r,
            None => return false,
        }
    };
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
    let word = match kind {
        StoreKind::I64 => super::aarch64::enc_str_reg_lsl3(rv, rn, rm),
        StoreKind::I32 => super::aarch64::enc_str32_reg_lsl2(rv, rn, rm),
        StoreKind::I16 => super::aarch64::enc_strh_reg_lsl1(rv, rn, rm),
        StoreKind::I8 => super::aarch64::enc_strb_reg(rv, rn, rm),
        StoreKind::F32 => unreachable!(),
    };
    emit(code, word);
    // c5 store-op leaves the stored value in the accumulator.
    match dst {
        Place::IntReg(r) => {
            let rd = Reg(r);
            if rd.0 != rv.0 {
                emit_mov_reg(code, rd, rv);
            }
        }
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(rv, Reg(31), sp_off));
        }
        Place::None => {}
        Place::FpReg(_) => return false,
    }
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
    scratch: &ScratchPool,
) -> bool {
    // The c5 store ops leave the stored value in the accumulator
    // afterward, so `dst` may be a register or spill slot the
    // allocator wants the value parked in. We compute the value
    // in a register, store it through the address, then copy to
    // dst if it isn't already there.
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
    let rn = match materialize_int(code, addr_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    if let StoreKind::F32 = kind {
        // Stage the value as a d-reg holding the f64 pattern.
        // For an FpReg source the materialise already gives us
        // that; for an IntReg / Spill the source register holds
        // the int-encoded f64 bit pattern (c5's Imm path), so
        // an fmov x->d reinterprets the bits as f64.
        let dn = match value_place {
            Place::FpReg(r) => r,
            Place::IntReg(_) | Place::Spill(_) => {
                let rs = match materialize_int(code, value_place, scratch.secondary, frame) {
                    Some(r) => r,
                    None => return false,
                };
                emit(code, enc_fmov_x_to_d(0, rs));
                0u8
            }
            Place::None => return false,
        };
        emit(code, enc_fcvt_s_d(0, dn));
        emit(code, enc_str_s_imm(0, rn, 0));
        if let Some(rd) = fp_reg(dst) {
            if rd != dn {
                emit(code, enc_fmov_d_to_x(scratch.primary, dn));
                emit(code, enc_fmov_x_to_d(rd, scratch.primary));
            }
        } else if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_d_imm(dn, Reg(31), sp_off));
        }
        return true;
    }
    // For an I64 store whose value lives in an FpReg (c5's f64
    // store path uses StoreKind::I64 to write 8 raw bytes), bridge
    // d-reg -> GPR via fmov. Lower-width stores from an FpReg
    // aren't a shape c5 emits.
    let rs = if let StoreKind::I64 = kind
        && let Place::FpReg(dr) = value_place
    {
        emit(code, enc_fmov_d_to_x(scratch.secondary, dr));
        scratch.secondary
    } else {
        match materialize_int(code, value_place, scratch.secondary, frame) {
            Some(r) => r,
            None => return false,
        }
    };
    match kind {
        StoreKind::I64 => emit(code, enc_str_imm(rs, rn, 0)),
        StoreKind::I32 => emit(code, enc_str32_imm(rs, rn, 0)),
        StoreKind::I16 => emit(code, enc_strh_imm(rs, rn, 0)),
        StoreKind::I8 => emit(code, enc_strb_imm(rs, rn, 0)),
        StoreKind::F32 => unreachable!("F32 store handled in the F32 branch above"),
    }
    if let Some(rd) = int_reg(dst) {
        if rd.0 != rs.0 {
            emit_mov_reg(code, rd, rs);
        }
    } else if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit(code, enc_str_imm(rs, Reg(31), sp_off));
    }
    true
}

#[allow(clippy::too_many_arguments)]
fn emit_binop(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    lhs: u32,
    rhs: u32,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
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
    // FP arithmetic + comparison branch. Both operands live in
    // d-regs; arithmetic produces a d-reg; comparisons produce a
    // GPR (cset). The scratch d-regs (d0 / d1) reload spilled
    // operands; the matching int scratch slots aren't disturbed
    // because no int materialisation runs in this branch.
    if let Some(arith) = fp_arith_enc(op) {
        let dn = match materialize_fp(code, lhs_place, 0, frame) {
            Some(r) => r,
            None => return false,
        };
        let dm = match materialize_fp(code, rhs_place, 1, frame) {
            Some(r) => r,
            None => return false,
        };
        let dd = match dst {
            Place::FpReg(r) => r,
            Place::Spill(_) => 0u8,
            _ => return false,
        };
        emit(code, arith(dd, dn, dm));
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_d_imm(dd, Reg(31), sp_off));
        }
        return true;
    }
    if let Some(cond) = fp_compare_cond(op) {
        let dn = match materialize_fp(code, lhs_place, 0, frame) {
            Some(r) => r,
            None => return false,
        };
        let dm = match materialize_fp(code, rhs_place, 1, frame) {
            Some(r) => r,
            None => return false,
        };
        let rd = match dst {
            Place::IntReg(r) => Reg(r),
            Place::Spill(_) => scratch.primary,
            _ => return false,
        };
        emit(code, enc_fcmp_d(dn, dm));
        emit(code, enc_cset(rd, cond));
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(rd, Reg(31), sp_off));
        }
        return true;
    }
    // Integer binop path. The result lands in a GPR; if the
    // allocator picked a spill slot, route through
    // `scratch.primary` and store afterwards. Using
    // scratch.primary as the rd is safe even when the lhs
    // materialise wrote it there: `add rd, rn, rm` reads rn
    // before writing rd, so a self-aliasing destination doesn't
    // corrupt the operand.
    let (rd, spill_to) = match dst {
        Place::IntReg(r) => (Reg(r), None),
        Place::Spill(slot) => (scratch.primary, Some(slot)),
        _ => return false,
    };
    // sxtw / sxth / sxtb fold for the walker-shape sign-narrow
    // pair `Binop(Shl, X, Imm(K)); Binop(Shr, _, Imm(K))`. The
    // allocator marked this Shr and stashed the K (32 / 48 / 56);
    // emit one sign-extend instead of two shifts.
    let sxtw_source = alloc
        .sxtw_source
        .get(v as usize)
        .copied()
        .unwrap_or(super::super::ir::NO_VALUE);
    if sxtw_source != super::super::ir::NO_VALUE {
        let src_place = alloc
            .places
            .get(sxtw_source as usize)
            .copied()
            .unwrap_or(Place::None);
        let rn = match materialize_int(code, src_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        };
        let k = alloc.sxtw_k.get(v as usize).copied().unwrap_or(0);
        let word = match k {
            32 => super::aarch64::enc_sxtw(rd, rn),
            48 => super::aarch64::enc_sxth(rd, rn),
            56 => super::aarch64::enc_sxtb(rd, rn),
            _ => return false,
        };
        emit(code, word);
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(rd, Reg(31), sp_off));
        }
        return true;
    }
    let rn = match materialize_int(code, lhs_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rm = match materialize_int(code, rhs_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    if let Some(cond) = compare_cond(op) {
        emit(code, enc_cmp_reg(rn, rm));
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        emit(code, enc_cset(rd, cond));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(rd, Reg(31), sp_off));
        }
        return true;
    }
    if matches!(op, BinOp::Mod | BinOp::Modu) {
        let divider = if matches!(op, BinOp::Mod) {
            enc_sdiv(scratch.secondary, rn, rm)
        } else {
            enc_udiv(scratch.secondary, rn, rm)
        };
        emit(code, divider);
        emit(code, enc_msub(rd, scratch.secondary, rm, rn));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(rd, Reg(31), sp_off));
        }
        return true;
    }
    let word = match op {
        BinOp::Add => enc_add_reg(rd, rn, rm),
        BinOp::Sub => enc_sub_reg(rd, rn, rm),
        BinOp::Mul => enc_mul(rd, rn, rm),
        BinOp::Div => enc_sdiv(rd, rn, rm),
        BinOp::Divu => enc_udiv(rd, rn, rm),
        BinOp::And => enc_and_reg(rd, rn, rm),
        BinOp::Or => enc_orr_reg(rd, rn, rm),
        BinOp::Xor => enc_eor_reg(rd, rn, rm),
        BinOp::Shl => enc_lslv(rd, rn, rm),
        BinOp::Shr => enc_asrv(rd, rn, rm),
        BinOp::Shru => enc_lsrv(rd, rn, rm),
        _ => return false,
    };
    emit(code, word);
    if let Some(slot) = spill_to {
        let sp_off = spill_off(frame, slot);
        emit(code, enc_str_imm(rd, Reg(31), sp_off));
    }
    true
}

/// Map an FP arithmetic binop to its d-reg encoder. Returns
/// `None` for non-arithmetic ops so the caller can try the
/// comparison or integer paths.
fn fp_arith_enc(op: BinOp) -> Option<fn(u8, u8, u8) -> u32> {
    Some(match op {
        BinOp::Fadd => enc_fadd_d,
        BinOp::Fsub => enc_fsub_d,
        BinOp::Fmul => enc_fmul_d,
        BinOp::Fdiv => enc_fdiv_d,
        _ => return None,
    })
}

/// Map an FP comparison binop to the AArch64 condition code the
/// matching fcmp + cset pair should use. Returns `None` for any
/// non-FP-compare op.
fn fp_compare_cond(op: BinOp) -> Option<Cond> {
    Some(match op {
        BinOp::Feq => Cond::Eq,
        BinOp::Fne => Cond::Ne,
        BinOp::Flt => Cond::Mi,
        BinOp::Fgt => Cond::Gt,
        BinOp::Fle => Cond::Ls,
        BinOp::Fge => Cond::Ge,
        _ => return None,
    })
}

/// Map a comparison binop to the matching `Cond` for the
/// cmp / cset pair.
fn compare_cond(op: BinOp) -> Option<Cond> {
    Some(match op {
        BinOp::Eq => Cond::Eq,
        BinOp::Ne => Cond::Ne,
        BinOp::Lt => Cond::Lt,
        BinOp::Gt => Cond::Gt,
        BinOp::Le => Cond::Le,
        BinOp::Ge => Cond::Ge,
        BinOp::Ult => Cond::Lo,
        BinOp::Ugt => Cond::Hi,
        BinOp::Ule => Cond::Ls,
        BinOp::Uge => Cond::Hs,
        _ => return None,
    })
}

#[allow(clippy::too_many_arguments)]
fn emit_binop_imm(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    lhs: u32,
    rhs_imm: i64,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let (rd, spill_to) = match dst {
        Place::IntReg(r) => (Reg(r), None),
        Place::Spill(slot) => (scratch.primary, Some(slot)),
        _ => return false,
    };
    let lhs_place = alloc
        .places
        .get(lhs as usize)
        .copied()
        .unwrap_or(Place::None);
    // sxtw / sxth / sxtb fold: the allocator pre-flagged this
    // `BinopI(Shr, _, K)` as the upper half of a sign-narrow pair
    // (`Shl K; Shr K`). The matching Shl was decremented to zero
    // uses and DCE'd; we emit a single sign-extend whose source is
    // the Shl's lhs (the original pre-narrow value).
    let sxtw_source = alloc
        .sxtw_source
        .get(v as usize)
        .copied()
        .unwrap_or(super::super::ir::NO_VALUE);
    if sxtw_source != super::super::ir::NO_VALUE {
        let src_place = alloc
            .places
            .get(sxtw_source as usize)
            .copied()
            .unwrap_or(Place::None);
        let rn = match materialize_int(code, src_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        };
        let word = match rhs_imm {
            32 => super::aarch64::enc_sxtw(rd, rn),
            48 => super::aarch64::enc_sxth(rd, rn),
            56 => super::aarch64::enc_sxtb(rd, rn),
            _ => unreachable!(),
        };
        emit(code, word);
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(rd, Reg(31), sp_off));
        }
        return true;
    }
    let rn = match materialize_int(code, lhs_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    // Per-op peepholes for immediate-form binops. Avoid the
    // `load_imm64 -> reg-form op` pair when the immediate fits a
    // direct encoding.
    //   * Shl / Shr / Shru by 0..63 -> single-op LSL / ASR / LSR
    //     by immediate (UBFM / SBFM aliases).
    //   * Mul by a power of two in 0..63 -> LSL by log2.
    //   * Add / Sub with 12-bit imm -> direct enc_add_imm /
    //     enc_sub_imm.
    let imm_u64 = rhs_imm as u64;
    let imm_pow2_shift = if rhs_imm > 0 && imm_u64.is_power_of_two() {
        let s = imm_u64.trailing_zeros();
        if s < 64 { Some(s as u8) } else { None }
    } else {
        None
    };
    let shift_amount = if (0..64).contains(&rhs_imm) {
        Some(rhs_imm as u8)
    } else {
        None
    };
    let imm12 = u32::try_from(rhs_imm).ok().filter(|v| *v < (1u32 << 12));
    let used_peephole = match op {
        BinOp::Shl => shift_amount.map(|s| super::aarch64::enc_lsl_imm(rd, rn, s)),
        BinOp::Shr => shift_amount.map(|s| super::aarch64::enc_asr_imm(rd, rn, s)),
        BinOp::Shru => shift_amount.map(|s| super::aarch64::enc_lsr_imm(rd, rn, s)),
        BinOp::Mul => imm_pow2_shift.map(|s| super::aarch64::enc_lsl_imm(rd, rn, s)),
        BinOp::Add => imm12.map(|v| enc_add_imm(rd, rn, v)),
        BinOp::Sub => imm12.map(|v| enc_sub_imm(rd, rn, v)),
        _ => None,
    };
    if let Some(word) = used_peephole {
        emit(code, word);
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(rd, Reg(31), sp_off));
        }
        return true;
    }
    // Compare-with-12-bit-immediate: emit `cmp Xn, #imm12`
    // (subs xzr, Xn, #imm12) and skip the imm-into-scratch load.
    // The 12-bit unsigned-immediate form covers 0..4095; outside
    // that range we fall through to the load-imm64 + cmp-reg path.
    if compare_cond(op).is_some()
        && let Some(imm) = imm12
    {
        emit(code, enc_subs_imm(Reg::SP, rn, imm));
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        let cond = compare_cond(op).unwrap();
        emit(code, enc_cset(rd, cond));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(rd, Reg(31), sp_off));
        }
        return true;
    }
    load_imm64(code, scratch.secondary, rhs_imm as u64);
    let rm = scratch.secondary;
    if compare_cond(op).is_some() {
        emit(code, enc_cmp_reg(rn, rm));
        // When the terminator's b.cond will consume the flags
        // directly, drop the cset materialisation -- the
        // comparison value is dead.
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        let cond = compare_cond(op).unwrap();
        emit(code, enc_cset(rd, cond));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit(code, enc_str_imm(rd, Reg(31), sp_off));
        }
        return true;
    }
    if matches!(op, BinOp::Mod | BinOp::Modu) {
        // Need a third scratch reg distinct from rn / rm; the
        // walker doesn't emit Mod / Modu under BinopI, so falling
        // back to the non-immediate path is safe.
        return false;
    }
    let word = match op {
        BinOp::Add => enc_add_reg(rd, rn, rm),
        BinOp::Sub => enc_sub_reg(rd, rn, rm),
        BinOp::Mul => enc_mul(rd, rn, rm),
        BinOp::Div => enc_sdiv(rd, rn, rm),
        BinOp::Divu => enc_udiv(rd, rn, rm),
        BinOp::And => enc_and_reg(rd, rn, rm),
        BinOp::Or => enc_orr_reg(rd, rn, rm),
        BinOp::Xor => enc_eor_reg(rd, rn, rm),
        BinOp::Shl => enc_lslv(rd, rn, rm),
        BinOp::Shr => enc_asrv(rd, rn, rm),
        BinOp::Shru => enc_lsrv(rd, rn, rm),
        _ => return false,
    };
    emit(code, word);
    if let Some(slot) = spill_to {
        let sp_off = spill_off(frame, slot);
        emit(code, enc_str_imm(rd, Reg(31), sp_off));
    }
    true
}

/// Materialise a value's `Place` into a register the lowering
/// can name in an instruction operand. Spills get loaded into
/// `scratch`; register places are returned as-is. Spill slots
/// are addressed through sp with the 12-bit scaled immediate;
/// fp-relative addressing through `ldur` would silently
/// truncate the 9-bit immediate for frames > 256 bytes and read
/// from the wrong slot. `sp_shift` is any amount the caller has
/// temporarily pushed sp down by (e.g. emit_call's outgoing-arg
/// scratch region) -- it gets added to the in-frame offset so the
/// load still hits the correct spill slot.
fn materialize_int(code: &mut Vec<u8>, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    materialize_int_shifted(code, place, scratch, frame, 0)
}

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
            let sp_off = spill_off(frame, slot) + sp_shift;
            emit(code, enc_ldr_imm(scratch, Reg(31), sp_off));
            Some(scratch)
        }
        Place::FpReg(_) | Place::None => None,
    }
}

/// Materialise a floating-point value's `Place` into a d-reg.
/// Spilled FP values land in the 8-byte spill region as 64-bit
/// patterns (the SSA model's only FP width is f64 since c5
/// widens every load through `fcvt`).
fn materialize_fp(code: &mut Vec<u8>, place: Place, scratch_d: u8, frame: Frame) -> Option<u8> {
    materialize_fp_shifted(code, place, scratch_d, frame, 0)
}

fn materialize_fp_shifted(
    code: &mut Vec<u8>,
    place: Place,
    scratch_d: u8,
    frame: Frame,
    sp_shift: u32,
) -> Option<u8> {
    match place {
        Place::FpReg(r) => Some(r),
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot) + sp_shift;
            emit(code, enc_ldr_d_imm(scratch_d, Reg(31), sp_off));
            Some(scratch_d)
        }
        // c5's constant-folder emits FP values as `Imm` of the
        // int-encoded f64 bit pattern; the allocator places those
        // in IntRegs. Reinterpret the bit pattern as an f64 via
        // `fmov d, x` and return the scratch d-reg.
        Place::IntReg(r) => {
            emit(code, enc_fmov_x_to_d(scratch_d, Reg(r)));
            Some(scratch_d)
        }
        Place::None => None,
    }
}

/// Extract the d-reg number from a `Place::FpReg`, or `None` for
/// any other place. The d-reg index is the same as the s-reg
/// index (single-precision uses the low 32 bits of the same
/// physical register).
fn fp_reg(place: Place) -> Option<u8> {
    place.fp_reg_u8()
}

/// Resolve a set of register-to-register copies `(src, tgt)` so
/// that no copy writes to a register still needed as the source
/// of another pending copy. Processed leaf-first (target not in
/// any source) until the worklist drains; cycles are broken by
/// routing one source through `scratch`. The caller must pass a
/// `scratch` that lives outside the allocator's bank so it cannot
/// collide with any pending source or target.
fn schedule_int_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch: Reg) {
    moves.retain(|(s, t)| s != t);
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            let tgt_still_a_source = moves.iter().any(|(other_s, _)| *other_s == t);
            if !tgt_still_a_source {
                emit_mov_reg(code, Reg(t), Reg(s));
                moves.swap_remove(i);
                progress = true;
            } else {
                i += 1;
            }
        }
        if !progress {
            // Worklist contains only cycle members. Save one source
            // into the scratch and redirect every move that read
            // from it; the redirected `(scratch, ...)` move now
            // breaks the cycle.
            let saved = moves[0].0;
            emit_mov_reg(code, scratch, Reg(saved));
            for m in moves.iter_mut() {
                if m.0 == saved {
                    m.0 = scratch.0;
                }
            }
        }
    }
}

/// Place every call argument into its AAPCS64 target slot in an
/// order that survives source / target overlaps. With the
/// allocator's caller-saved bank covering x0..x15, an argument's
/// value can sit in another argument's target arg register; a
/// naive sequential `mov tgt_i, src_i` would clobber a still-
/// needed source. Resolution uses the classical parallel-copy
/// algorithm: drain leaves (target not a source of any other
/// pending move) first; break the residual cycles with one
/// scratch-mediated copy. The permutation-safe order is:
///
///   * Stack slots first -- their sources are read into a scratch
///     and stored to the host-stack overflow region, preserving
///     any source register that a later pass touches.
///   * Integer reg-to-reg moves next, scheduled through
///     [`schedule_int_reg_moves`] so cycles drop to a single
///     scratch-mediated copy.
///   * Spill / Imm / FpReg sources for `IntReg` placements then
///     materialise directly into the target arg register
///     (`materialize_int_shifted` writes its load into the dst).
///   * FP arg-register moves last. d-reg cycles are extremely
///     rare in real code; today this still emits sequentially
///     via the encoder scratch and relies on the allocator not
///     producing a d-reg permutation.
fn marshal_args(
    code: &mut Vec<u8>,
    plan: &super::CallPlan,
    args: &[u32],
    alloc: &Allocation,
    scratch: &ScratchPool,
    frame: Frame,
) -> bool {
    let arg_place = |i: usize| -> Place {
        alloc
            .places
            .get(args[i] as usize)
            .copied()
            .unwrap_or(Place::None)
    };

    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::Stack(off) = placement {
            let ap = arg_place(i);
            if let Place::FpReg(_) = ap {
                let dn = match materialize_fp_shifted(code, ap, 0u8, frame, plan.scratch_bytes) {
                    Some(r) => r,
                    None => return false,
                };
                emit(code, enc_str_d_imm(dn, Reg(31), off));
            } else {
                let src =
                    match materialize_int_shifted(code, ap, scratch.primary, frame, plan.scratch_bytes) {
                        Some(r) => r,
                        None => return false,
                    };
                emit(code, enc_str_imm(src, Reg(31), off));
            }
        }
    }

    // FP args before int args: an FP value can sit in an integer
    // register as a raw bit pattern (`Inst::Imm` with the f64 bit
    // pattern, allocator places it in an IntReg). The int marshal
    // below may overwrite arg-target integer registers, including
    // the source register of such a value, so the FP fmov must
    // snapshot it into the destination d-reg first.
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::FpReg(r) = placement {
            let ap = arg_place(i);
            // Pass the target d-reg as the materialise scratch so
            // Spill / IntReg sources land directly in the target
            // and earlier FP args already sitting in d0..d_{r-1}
            // are not overwritten by a generic d-scratch reload.
            let src = match materialize_fp_shifted(code, ap, r, frame, plan.scratch_bytes) {
                Some(rr) => rr,
                None => return false,
            };
            if src != r {
                emit(code, enc_fmov_d_to_x(scratch.primary, src));
                emit(code, enc_fmov_x_to_d(r, scratch.primary));
            }
        }
    }

    let mut int_moves: Vec<(u8, u8)> = Vec::new();
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::IntReg(r) = placement
            && let Place::IntReg(s) = arg_place(i)
            && s != r
        {
            int_moves.push((s, r));
        }
    }
    schedule_int_reg_moves(code, &mut int_moves, scratch.primary);

    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::IntReg(r) = placement {
            let ap = arg_place(i);
            match ap {
                Place::IntReg(_) => {}
                Place::FpReg(dn) => {
                    emit(code, enc_fmov_d_to_x(Reg(r), dn));
                }
                Place::Spill(_) | Place::None => {
                    let src =
                        match materialize_int_shifted(code, ap, Reg(r), frame, plan.scratch_bytes) {
                            Some(rr) => rr,
                            None => return false,
                        };
                    if src.0 != r {
                        emit_mov_reg(code, Reg(r), src);
                    }
                }
            }
        }
    }

    true
}

/// Emit the function epilogue + `ret` for a Return terminator.
fn emit_return(
    code: &mut Vec<u8>,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    func: &FunctionSsa,
    abi: super::Abi,
) {
    // Move the return value into x0. c5's calling convention
    // ferries every return value (including f64 bit patterns)
    // through the int return register, matching the pool path's
    // `mov x0, x19` epilogue. FpReg-placed values reach x0 via
    // `fmov x, d`; int values flow through the standard
    // materialise + mov. NO_VALUE marks an implicit return with
    // no live accumulator -- harmless because c5 calls never
    // read the result of a void-returning function.
    if value != super::super::ir::NO_VALUE {
        let place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        if let Place::FpReg(r) = place {
            emit(code, enc_fmov_d_to_x(Reg(0), r));
        } else if let Some(src) = materialize_int(code, place, scratch.primary, frame)
            && src.0 != 0
        {
            emit_mov_reg(code, Reg(0), src);
        }
    }
    // Restore saved callee-saved GPRs + FP regs (mirror of
    // prologue). Addressing through sp uses `enc_ldr_imm`'s
    // 12-bit scaled immediate (range 0..32760 in multiples of
    // 8); the matching prologue uses `enc_str_imm` at the same
    // offsets.
    let saved_fpr_bytes = ((alloc.fp_used.len() as u32) * 8 + 15) & !15;
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = saved_fpr_bytes + (i as u32) * 8;
        emit(code, enc_ldr_imm(Reg(r), Reg(31), off));
    }
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        let off = (i as u32) * 8;
        emit(code, enc_ldr_d_imm(r, Reg(31), off));
    }
    // Restore x19 from the dedicated slot above the allocator saves;
    // mirror of the prologue's save, emitted only when the function
    // clobbers x19.
    if frame.uses_x19 {
        let saved_gpr_bytes = ((alloc.gpr_used.len() as u32) * 8 + 15) & !15;
        let x19_save_off = saved_fpr_bytes + saved_gpr_bytes;
        emit(code, enc_ldr_imm(Reg(19), Reg(31), x19_save_off));
    }
    // Tear down the frame.
    if frame.frame_bytes > 0 {
        emit_add_sp_imm(code, frame.frame_bytes);
    }
    emit(code, enc_ldp_post(Reg(29), Reg(30), Reg(31), 16));
    // Drop the host-arg-reg spill slots the prologue laid down
    // before the fp/lr stp. Both register-spilled and host-stack-
    // overflow params occupy 16 bytes apiece.
    if !func.is_variadic && func.n_params > 0 {
        let _ = abi;
        emit_add_sp_imm(code, (16 * func.n_params) as u32);
    }
    emit(code, enc_ret(Reg(30)));
}

/// Extract the int reg from a `Place`, or None if it's not an
/// int placement.
fn int_reg(p: Place) -> Option<Reg> {
    p.int_reg_u8().map(Reg)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::Compiler;

    fn lift_and_alloc(src: &str, target: Target) -> (crate::c5::ir::FunctionSsa, Allocation) {
        let program = Compiler::new(src.into()).compile().expect("compile");
        let funcs = crate::c5::codegen::ssa_shadow::produce_ssa_funcs(&program, target)
            .expect("produce_ssa_funcs");
        let main = funcs.into_iter().next().expect("at least one function");
        let alloc = super::super::ssa_alloc::allocate(&main, target);
        (main, alloc)
    }

    /// A `return 42;` function emits a small, well-formed
    /// aarch64 sequence: prologue, materialise 42, mov to x0,
    /// epilogue, ret. The exact length isn't load-bearing here
    /// -- the test exists to lock in that the thin slice
    /// completes without falling back.
    #[test]
    fn emit_return_42() {
        let (func, alloc) = lift_and_alloc("int main(void) { return 42; }", Target::MacOSAarch64);
        let mut code = Vec::new();
        let mut fx = Vec::new();
        let mut plt = Vec::new();
        let mut data_fx = Vec::new();
        let mut pf_fx = Vec::new();
        let imps = super::super::ResolvedImports::default();
        let variadic_targets: alloc::collections::BTreeSet<usize> =
            alloc::collections::BTreeSet::new();
        let mut tls_idx = Vec::new();
        let mut user_data_refs: Vec<super::super::UserExternDataRef> = Vec::new();
        let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
            alloc::collections::BTreeMap::new();
        let mut tlv_fx = Vec::new();
        let mut tlv_desc = Vec::new();
        let mut pc_to_native = alloc::vec![usize::MAX; func.end_pc + 1];
        let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();
        let mut prologue_native: alloc::collections::BTreeMap<usize, usize> =
            alloc::collections::BTreeMap::new();
        let ok = emit_function(
            &func,
            &alloc,
            Target::MacOSAarch64,
            &mut code,
            &mut fx,
            &mut plt,
            &mut data_fx,
            &mut user_data_refs,
            &extern_data_names,
            &mut pf_fx,
            &imps,
            &variadic_targets,
            &mut tls_idx,
            &mut tlv_fx,
            &mut tlv_desc,
            &mut pc_to_native,
            &mut prologue_native,
            &mut ssa_line_rows,
        );
        assert!(
            ok,
            "expected SSA emit to handle a single-return function; got fallback"
        );
        assert!(!code.is_empty(), "emit produced no bytes");
        // Every aarch64 instruction is 4 bytes -- a non-multiple
        // of 4 means we encoded a wrong-width op.
        assert_eq!(code.len() % 4, 0, "code length must be 4-aligned");
        // Last instruction must be `ret x30` (0xd65f03c0).
        let tail = &code[code.len() - 4..];
        assert_eq!(
            u32::from_le_bytes([tail[0], tail[1], tail[2], tail[3]]),
            0xd65f03c0,
            "function must end with `ret`",
        );
    }

    /// `return 1 + 2;` exercises the Binop + BinopI handlers
    /// (the walker emits `Imm 1; Psh; Imm 2; Add` plus the
    /// int-promotion shl/shr; the walker's BinopI imm-fold may
    /// rewrite the Add into BinopI directly).
    #[test]
    fn emit_return_one_plus_two() {
        let (func, alloc) =
            lift_and_alloc("int main(void) { return 1 + 2; }", Target::MacOSAarch64);
        let mut code = Vec::new();
        let mut fx = Vec::new();
        let mut plt = Vec::new();
        let mut data_fx = Vec::new();
        let mut pf_fx = Vec::new();
        let imps = super::super::ResolvedImports::default();
        let variadic_targets: alloc::collections::BTreeSet<usize> =
            alloc::collections::BTreeSet::new();
        let mut tls_idx = Vec::new();
        let mut user_data_refs: Vec<super::super::UserExternDataRef> = Vec::new();
        let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
            alloc::collections::BTreeMap::new();
        let mut tlv_fx = Vec::new();
        let mut tlv_desc = Vec::new();
        let mut pc_to_native = alloc::vec![usize::MAX; func.end_pc + 1];
        let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();
        let mut prologue_native: alloc::collections::BTreeMap<usize, usize> =
            alloc::collections::BTreeMap::new();
        let ok = emit_function(
            &func,
            &alloc,
            Target::MacOSAarch64,
            &mut code,
            &mut fx,
            &mut plt,
            &mut data_fx,
            &mut user_data_refs,
            &extern_data_names,
            &mut pf_fx,
            &imps,
            &variadic_targets,
            &mut tls_idx,
            &mut tlv_fx,
            &mut tlv_desc,
            &mut pc_to_native,
            &mut prologue_native,
            &mut ssa_line_rows,
        );
        assert!(ok, "binop handler should cover Add + Shl + Shr");
        assert_eq!(code.len() % 4, 0);
    }

    /// `if (x > 0) return 1; else return 0;` exercises the
    /// comparison binop path (cmp + cset), the branch terminator
    /// path (CBZ + fixup), and the multi-block walk.
    #[test]
    fn emit_if_else_returns() {
        let (func, alloc) = lift_and_alloc(
            "int test(int x) { if (x > 0) return 1; else return 0; } \
             int main(void) { return test(5); }",
            Target::MacOSAarch64,
        );
        // The first function is `test`; the walker order is
        // declaration order, but `Inst::Call` for main isn't in
        // the thin slice yet, so we only check that `test` emits
        // cleanly. main will fall back.
        let mut code = Vec::new();
        let mut fx = Vec::new();
        let mut plt = Vec::new();
        let mut data_fx = Vec::new();
        let mut pf_fx = Vec::new();
        let imps = super::super::ResolvedImports::default();
        let variadic_targets: alloc::collections::BTreeSet<usize> =
            alloc::collections::BTreeSet::new();
        let mut tls_idx = Vec::new();
        let mut user_data_refs: Vec<super::super::UserExternDataRef> = Vec::new();
        let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
            alloc::collections::BTreeMap::new();
        let mut tlv_fx = Vec::new();
        let mut tlv_desc = Vec::new();
        let mut pc_to_native = alloc::vec![usize::MAX; func.end_pc + 1];
        let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();
        let mut prologue_native: alloc::collections::BTreeMap<usize, usize> =
            alloc::collections::BTreeMap::new();
        let ok = emit_function(
            &func,
            &alloc,
            Target::MacOSAarch64,
            &mut code,
            &mut fx,
            &mut plt,
            &mut data_fx,
            &mut user_data_refs,
            &extern_data_names,
            &mut pf_fx,
            &imps,
            &variadic_targets,
            &mut tls_idx,
            &mut tlv_fx,
            &mut tlv_desc,
            &mut pc_to_native,
            &mut prologue_native,
            &mut ssa_line_rows,
        );
        assert!(
            ok,
            "`test` should emit via the thin slice (cmp + cset + cbz + ldr params)"
        );
    }
}

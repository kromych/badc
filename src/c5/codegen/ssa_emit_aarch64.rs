//! AArch64 native emit consuming the SSA lift + allocator output.
//! Active when `NativeOptions::regalloc = RegallocMode::Ssa` and
//! the env var `BADC_USE_SSA_EMIT` is set. The env-var gate keeps
//! the SSA path strictly opt-in while it grows handler coverage;
//! the pool path remains the default emit until parity is reached.
//!
//! ## Pass shape
//!
//! For each function:
//!
//! 1. Prologue: save fp / lr, set the frame pointer, reserve
//!    locals + vstack + allocator-spill bytes, save the
//!    callee-saved GPRs / FP regs the allocator reported as used,
//!    and spill the host-ABI argument registers into the c5
//!    cdecl slots the body's `LocalAddr(>=2)` references.
//! 2. Walk each block in source order. Emit `VstackReload`s at
//!    block start, per-`Inst` native code in `inst_range`, then
//!    `VstackSpill`s, then the terminator.
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
//!   vstack spill slots            [fp - locals_bytes - vstack_bytes .. fp - locals_bytes]
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
//! aborts the whole program on `false` under `BADC_USE_SSA_EMIT`
//! so half-emitted output never reaches the writers.

#![allow(dead_code, clippy::too_many_arguments)]

use alloc::vec::Vec;

use super::Target;
use super::DataFixup;
use super::aarch64::{
    BranchKind, Cond, Fixup, PltCallFixup, Reg, emit, emit_add_sp_imm, emit_sub_sp_imm,
    enc_add_imm, enc_add_reg, enc_adrp, enc_and_reg, enc_asrv, enc_b, enc_b_cond, enc_cbnz,
    enc_cbz, enc_cmp_reg, enc_cset, enc_eor_reg, enc_ldp_post, enc_ldr_imm, enc_ldr32_imm,
    enc_ldrb_imm, enc_ldrh_imm, enc_ldrsb_imm, enc_ldrsh_imm, enc_ldrsw_imm, enc_ldur,
    enc_lslv, enc_lsrv, enc_mov_reg, enc_msub, enc_mul, enc_orr_reg, enc_ret, enc_sdiv,
    enc_stp_pre, enc_str_imm, enc_str_pre, enc_str32_imm, enc_strb_imm, enc_strh_imm,
    enc_stur, enc_sub_imm, enc_sub_reg, enc_udiv, load_imm64,
};
use super::ssa::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
use super::ssa_alloc::{Allocation, Place};

/// Per-function frame layout. Bytes are 16-aligned at every
/// region boundary so AAPCS64's sp-at-call-site invariant holds.
#[derive(Debug, Clone, Copy)]
pub(super) struct Frame {
    /// Total frame size below fp, sub-spilled once at prologue
    /// entry. Includes locals, vstack region, allocator spills,
    /// and saved callee-saved regs.
    pub frame_bytes: u32,
    /// Byte distance from fp down to the dedicated cross-block
    /// accumulator slot. Single 8-byte slot, padded to 16 to
    /// keep the next region aligned.
    pub acc_slot_off: u32,
    /// Byte distance from fp down to the start of the
    /// allocator-managed spill region.
    pub alloc_spill_base: u32,
}

impl Frame {
    pub fn for_function(func: &FunctionSsa, alloc: &Allocation) -> Self {
        let locals_bytes = ((func.locals.max(0) as u32) * 8 + 15) & !15;
        let vstack_bytes = (func.vstack_slots * 8 + 15) & !15;
        let acc_bytes = 16u32;
        let alloc_spill_bytes = (alloc.spill_count * 8 + 15) & !15;
        let saved_gpr_bytes = ((alloc.gpr_used.len() as u32) * 8 + 15) & !15;
        let saved_fpr_bytes = ((alloc.fp_used.len() as u32) * 8 + 15) & !15;
        let frame_bytes = locals_bytes
            + vstack_bytes
            + acc_bytes
            + alloc_spill_bytes
            + saved_gpr_bytes
            + saved_fpr_bytes;
        Self {
            frame_bytes,
            acc_slot_off: locals_bytes + vstack_bytes + 8,
            alloc_spill_base: locals_bytes + vstack_bytes + acc_bytes,
        }
    }
}

/// Emit a diagnostic when the SSA path falls back. Active only
/// with `BADC_DUMP_SSA=1` so production builds stay quiet.
fn bail_msg(reason: &str) {
    #[cfg(feature = "std")]
    if std::env::var("BADC_DUMP_SSA").is_ok() {
        eprintln!("ssa emit: bailed -- {reason}");
    }
    let _ = reason;
}

fn bail(reason: &str, value: u32, place: Place) {
    #[cfg(feature = "std")]
    if std::env::var("BADC_DUMP_SSA").is_ok() {
        eprintln!("ssa emit: bailed -- {reason} v{value} place={:?}", place);
    }
    let _ = (reason, value, place);
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
/// `Fixup::Bl` per `Inst::Call`; the pool path's `apply_fixups`
/// post-pass resolves them once `bytecode_to_native` is final.
pub(super) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    code: &mut Vec<u8>,
    fixups: &mut Vec<Fixup>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    data_fixups: &mut Vec<DataFixup>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    imports: &super::ResolvedImports,
) -> bool {
    let frame = Frame::for_function(func, alloc);
    let abi = target.abi();
    let scratch = ScratchPool::new();
    let snapshot = code.len();

    emit_prologue(code, func, alloc, frame, abi);

    let mut block_offsets: Vec<usize> = alloc::vec![0; func.blocks.len()];
    let mut branch_fixups: Vec<BranchFixup> = Vec::new();

    for (block_idx, block) in func.blocks.iter().enumerate() {
        block_offsets[block_idx] = code.len();
        for v in block.inst_range.clone() {
            let inst = &func.insts[v as usize];
            let place = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
            if !emit_inst(
                code,
                inst,
                place,
                alloc,
                frame,
                &scratch,
                abi,
                fixups,
                plt_call_fixups,
                data_fixups,
                pending_func_fixups,
                imports,
            ) {
                #[cfg(feature = "std")]
                if std::env::var("BADC_DUMP_SSA").is_ok() {
                    eprintln!(
                        "ssa emit: bailed on inst v{v}: {:?} (place {:?})",
                        inst, place,
                    );
                }
                code.truncate(snapshot);
                return false;
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
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                let rt = match materialize_int(code, cond_place, scratch.primary, frame) {
                    Some(r) => r,
                    None => {
                        bail("Bz/Bnz: cond Place not int", cond, cond_place);
                        code.truncate(snapshot);
                        return false;
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
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                let rt = match materialize_int(code, cond_place, scratch.primary, frame) {
                    Some(r) => r,
                    None => {
                        bail("Bz/Bnz: cond Place not int", cond, cond_place);
                        code.truncate(snapshot);
                        return false;
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
            // TailExt isn't covered by the thin slice; fall back.
            Terminator::TailExt(b) => {
                bail_msg(&alloc::format!("TailExt({b}) terminator"));
                code.truncate(snapshot);
                return false;
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
            return false;
        }
        let imm = (rel / 4) as i32;
        let word = match fx.kind {
            LocalBranchKind::B => {
                if !(-(1 << 25)..(1 << 25)).contains(&imm) {
                    code.truncate(snapshot);
                    return false;
                }
                enc_b(imm)
            }
            LocalBranchKind::Cbz(rt) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
                    return false;
                }
                enc_cbz(rt, imm)
            }
            LocalBranchKind::Cbnz(rt) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
                    return false;
                }
                enc_cbnz(rt, imm)
            }
            LocalBranchKind::Bcc(cond) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
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
    // Host-arg-reg spill. Same shape as the pool path's
    // `emit_prologue` for non-variadic functions: spill each
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
    // Save the allocator-reported callee-saved GPRs at the
    // bottom of the frame. Each goes into its own 8-byte slot;
    // restore order in the epilogue mirrors this. stur takes a
    // signed 9-bit imm, sufficient for any save-region within
    // 256 bytes of fp. Larger save regions fall back to the
    // pool path through `emit_function`'s return-false escape.
    let save_base = alloc_save_base(frame, alloc);
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = -((save_base + (i as u32) * 8 + 8) as i32);
        emit(code, enc_stur(Reg(r), Reg(29), off));
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

/// Emit one SSA instruction. Returns `false` for any op the thin
/// slice doesn't handle yet so the caller can fall back.
fn emit_inst(
    code: &mut Vec<u8>,
    inst: &Inst,
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    data_fixups: &mut Vec<DataFixup>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    imports: &super::ResolvedImports,
) -> bool {
    match inst {
        Inst::AllocaInit(slot) => {
            // Slot 0 means "this function doesn't use alloca" --
            // pool path emits nothing. Non-zero requires the
            // alloca arena setup the thin slice doesn't model.
            *slot == 0
        }
        Inst::Imm(value) => {
            let Some(rd) = int_reg(dst) else {
                return false;
            };
            load_imm64(code, rd, *value as u64);
            true
        }
        Inst::ImmData(offset) => {
            let Some(rd) = int_reg(dst) else {
                return false;
            };
            // The writer's patch_adrp_add hardcodes x19 as the
            // adrp / add destination. Emit the placeholders with
            // x19, then move the materialised address into the
            // allocator's chosen register.
            let adrp_offset = code.len();
            emit(code, enc_adrp(Reg(19), 0));
            emit(code, enc_add_imm(Reg(19), Reg(19), 0));
            data_fixups.push(DataFixup {
                adrp_offset,
                data_offset: *offset as u64,
            });
            if rd.0 != 19 {
                emit(code, enc_mov_reg(rd, Reg(19)));
            }
            true
        }
        Inst::ImmCode(target_bc_pc) => {
            let Some(rd) = int_reg(dst) else {
                return false;
            };
            let adrp_offset = code.len();
            emit(code, enc_adrp(Reg(19), 0));
            emit(code, enc_add_imm(Reg(19), Reg(19), 0));
            pending_func_fixups.push((adrp_offset, *target_bc_pc));
            if rd.0 != 19 {
                emit(code, enc_mov_reg(rd, Reg(19)));
            }
            true
        }
        Inst::LocalAddr(off) => emit_local_addr(code, dst, *off),
        Inst::Load { addr, kind } => emit_load(code, dst, *addr, *kind, alloc, frame, scratch),
        Inst::Store { addr, value, kind } => {
            emit_store(code, dst, *addr, *value, *kind, alloc, frame, scratch)
        }
        Inst::Binop { op, lhs, rhs } => {
            emit_binop(code, *op, dst, *lhs, *rhs, alloc, frame, scratch)
        }
        Inst::BinopI { op, lhs, rhs_imm } => {
            emit_binop_imm(code, *op, dst, *lhs, *rhs_imm, alloc, frame, scratch)
        }
        Inst::Call { target_pc, args } => emit_call(
            code, dst, *target_pc, args, alloc, frame, scratch, abi, fixups,
        ),
        Inst::CallExt {
            binding_idx, args, ..
        } => emit_call_ext(
            code,
            dst,
            *binding_idx,
            args,
            alloc,
            frame,
            scratch,
            abi,
            plt_call_fixups,
            imports,
        ),
        Inst::AccSpill { value } => {
            let value_place = alloc
                .places
                .get(*value as usize)
                .copied()
                .unwrap_or(Place::None);
            let src = match materialize_int(code, value_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            emit(code, enc_stur(src, Reg(29), -(frame.acc_slot_off as i32)));
            true
        }
        Inst::AccReload => {
            let Some(rd) = int_reg(dst) else {
                bail_msg("AccReload: dst not int reg");
                return false;
            };
            emit(code, enc_ldur(rd, Reg(29), -(frame.acc_slot_off as i32)));
            true
        }
        Inst::VstackSpill { slot, value } => {
            let value_place = alloc
                .places
                .get(*value as usize)
                .copied()
                .unwrap_or(Place::None);
            let src = match materialize_int(code, value_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            // vstack slot N lives at -[(vstack_base - locals_bytes is 0) + (N+1) * 8] from fp.
            // Frame already accounts for the vstack region between
            // `locals_bytes` and `acc_slot_off - 8`. Compute the
            // exact byte offset:
            let off = -((frame.acc_slot_off as i32) - 8 - (*slot as i32) * 8);
            emit(code, enc_stur(src, Reg(29), off));
            true
        }
        Inst::VstackReload { slot } => {
            let Some(rd) = int_reg(dst) else {
                bail_msg("VstackReload: dst not int reg");
                return false;
            };
            let off = -((frame.acc_slot_off as i32) - 8 - (*slot as i32) * 8);
            emit(code, enc_ldur(rd, Reg(29), off));
            true
        }
        _ => false,
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
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    abi: super::Abi,
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
    // first, then stack; Linux: standard register sequence). FP
    // placements are still out of the thin slice -- emit_call_ext
    // bails on `FpReg` per-arg below.
    let fixed = if imp.is_variadic {
        imp.fixed_args.min(args.len())
    } else {
        args.len()
    };
    let plan = super::plan_call_args(args.len(), fixed, 0, abi);
    if plan.scratch_bytes > 0 {
        emit(code, enc_sub_imm(Reg(31), Reg(31), plan.scratch_bytes));
    }
    for (i, &placement) in plan.placements.iter().enumerate() {
        let arg_id = args[i];
        let arg_place = alloc
            .places
            .get(arg_id as usize)
            .copied()
            .unwrap_or(Place::None);
        let src = match materialize_int(code, arg_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        };
        match placement {
            super::ArgPlacement::IntReg(r) => {
                if src.0 != r {
                    emit(code, enc_mov_reg(Reg(r), src));
                }
            }
            super::ArgPlacement::Stack(off) => {
                emit(code, enc_str_imm(src, Reg(31), off));
            }
            super::ArgPlacement::FpReg(_) => return false,
        }
    }
    plt_call_fixups.push(PltCallFixup {
        instr_offset: code.len(),
        import_index,
        is_tail: false,
    });
    emit(code, enc_b(0));
    if plan.scratch_bytes > 0 {
        emit(code, enc_add_imm(Reg(31), Reg(31), plan.scratch_bytes));
    }
    if let Some(rd) = int_reg(dst) {
        if rd.0 != 0 {
            emit(code, enc_mov_reg(rd, Reg(0)));
        }
    } else if let Place::Spill(slot) = dst {
        let off = -((frame.alloc_spill_base + (slot + 1) * 8) as i32);
        emit(code, enc_stur(Reg(0), Reg(29), off));
    }
    true
}

/// Direct call to a c5 user function at bytecode pc `target_pc`.
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
) -> bool {
    // All-int args, no FP, no variadic: the planner returns
    // IntReg placements for the prefix and Stack placements for
    // the tail. The thin slice doesn't model FP-arg routing or
    // variadic callees yet.
    let plan = super::plan_call_args(args.len(), args.len(), 0, abi);
    if plan.scratch_bytes > 0 {
        emit(code, enc_sub_imm(Reg(31), Reg(31), plan.scratch_bytes));
    }
    // Stage each arg in the corresponding host arg reg / stack
    // slot. Reading a value through scratch keeps the case where
    // arg i's source is already in some other host arg reg
    // correct (the source may get clobbered by a later
    // arg's mov-into-host-reg).
    for (i, &placement) in plan.placements.iter().enumerate() {
        let arg_id = args[i];
        let arg_place = alloc
            .places
            .get(arg_id as usize)
            .copied()
            .unwrap_or(Place::None);
        // Load arg into scratch first, then move to its host
        // position. Always going through scratch keeps the
        // ordering correct without a parallel-copy analysis.
        let src = match materialize_int(code, arg_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        };
        match placement {
            super::ArgPlacement::IntReg(r) => {
                if src.0 != r {
                    emit(code, enc_mov_reg(Reg(r), src));
                }
            }
            super::ArgPlacement::Stack(off) => {
                emit(code, enc_str_imm(src, Reg(31), off));
            }
            super::ArgPlacement::FpReg(_) => return false,
        }
    }
    // Branch placeholder + fixup. The pool path's apply_fixups
    // resolves `target_bytecode_pc` -> `bytecode_to_native` once
    // the map is final.
    fixups.push(Fixup {
        native_offset: code.len(),
        target_bytecode_pc: target_pc,
        kind: BranchKind::Bl,
    });
    emit(code, enc_b(0));
    if plan.scratch_bytes > 0 {
        emit(code, enc_add_imm(Reg(31), Reg(31), plan.scratch_bytes));
    }
    // Move the return value from x0 into the call's dst Place.
    if let Some(rd) = int_reg(dst) {
        if rd.0 != 0 {
            emit(code, enc_mov_reg(rd, Reg(0)));
        }
    } else if let Place::Spill(slot) = dst {
        let off = -((frame.alloc_spill_base + (slot + 1) * 8) as i32);
        emit(code, enc_stur(Reg(0), Reg(29), off));
    }
    true
}

/// Translate a c5-stack slot index (`Op::Lea`'s operand) into a
/// byte offset relative to fp. Mirror of the pool path's
/// `lea_offset_bytes`: locals (off < 0) at off*8, params (off >=
/// 2) at (off-1)*16.
fn c5_slot_to_fp_offset(off: i64) -> i64 {
    if off >= 2 { (off - 1) * 16 } else { off * 8 }
}

fn emit_local_addr(code: &mut Vec<u8>, dst: Place, off: i64) -> bool {
    let Some(rd) = int_reg(dst) else {
        bail_msg("LocalAddr: dst not int reg");
        return false;
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
        return true;
    }
    bail_msg(&alloc::format!(
        "LocalAddr: offset {bytes} exceeds 24-bit reach"
    ));
    false
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
    let Some(rd) = int_reg(dst) else {
        return false;
    };
    let addr_place = alloc
        .places
        .get(addr as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, addr_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    match kind {
        LoadKind::I64 => emit(code, enc_ldr_imm(rd, rn, 0)),
        LoadKind::I32 => emit(code, enc_ldrsw_imm(rd, rn, 0)),
        LoadKind::U32 => emit(code, enc_ldr32_imm(rd, rn, 0)),
        LoadKind::I16 => emit(code, enc_ldrsh_imm(rd, rn, 0)),
        LoadKind::U16 => emit(code, enc_ldrh_imm(rd, rn, 0)),
        LoadKind::I8 => emit(code, enc_ldrsb_imm(rd, rn, 0)),
        LoadKind::U8 => emit(code, enc_ldrb_imm(rd, rn, 0)),
        // FP loads (4-byte float widened to f64) need the
        // fmov + fcvt sequence; route through the pool path.
        LoadKind::F32 => {
            bail_msg("Load: F32 not handled");
            return false;
        }
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
    let rs = match materialize_int(code, value_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    match kind {
        StoreKind::I64 => emit(code, enc_str_imm(rs, rn, 0)),
        StoreKind::I32 => emit(code, enc_str32_imm(rs, rn, 0)),
        StoreKind::I16 => emit(code, enc_strh_imm(rs, rn, 0)),
        StoreKind::I8 => emit(code, enc_strb_imm(rs, rn, 0)),
        StoreKind::F32 => {
            bail_msg("Store: F32 not handled");
            return false;
        }
    }
    if let Some(rd) = int_reg(dst) {
        if rd.0 != rs.0 {
            emit(code, enc_mov_reg(rd, rs));
        }
    } else if let Place::Spill(slot) = dst {
        let off = -((frame.alloc_spill_base + (slot + 1) * 8) as i32);
        emit(code, enc_stur(rs, Reg(29), off));
    }
    true
}

fn emit_binop(
    code: &mut Vec<u8>,
    op: BinOp,
    dst: Place,
    lhs: u32,
    rhs: u32,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let Some(rd) = int_reg(dst) else {
        return false;
    };
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
        emit(code, enc_cset(rd, cond));
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
    true
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

fn emit_binop_imm(
    code: &mut Vec<u8>,
    op: BinOp,
    dst: Place,
    lhs: u32,
    rhs_imm: i64,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let Some(rd) = int_reg(dst) else {
        return false;
    };
    let lhs_place = alloc
        .places
        .get(lhs as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, lhs_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    load_imm64(code, scratch.secondary, rhs_imm as u64);
    let rm = scratch.secondary;
    if let Some(cond) = compare_cond(op) {
        emit(code, enc_cmp_reg(rn, rm));
        emit(code, enc_cset(rd, cond));
        return true;
    }
    // Mod / Modu under BinopI doesn't naturally arise from the
    // bytecode optimizer (it only fuses Psh; Imm N; <op> into
    // <op>I N for a fixed whitelist), but handle them
    // defensively in case a future pass produces them.
    if matches!(op, BinOp::Mod | BinOp::Modu) {
        // Need a third scratch reg distinct from rn / rm.
        // x16 holds rn (the materialised lhs); x17 = scratch.secondary
        // holds the immediate. Use x18-equivalent isn't available
        // (reserved on Windows); fall back to the pool path.
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
    true
}

/// Materialise a value's `Place` into a register the lowering
/// can name in an instruction operand. Spills get loaded into
/// `scratch`; register places are returned as-is.
fn materialize_int(code: &mut Vec<u8>, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let off = -((frame.alloc_spill_base + (slot + 1) * 8) as i32);
            emit(code, enc_ldur(scratch, Reg(29), off));
            Some(scratch)
        }
        Place::FpReg(_) | Place::None => None,
    }
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
    // Move the return value into x0. NO_VALUE means the bytecode
    // emitter's trailing synthetic Lev with no live accumulator;
    // an undefined return value is harmless because c5 calls
    // never read the result of a void-returning function.
    if value != super::ssa::NO_VALUE {
        let place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        if let Some(src) = materialize_int(code, place, scratch.primary, frame)
            && src.0 != 0
        {
            emit(code, enc_mov_reg(Reg(0), src));
        }
    }
    // Restore saved callee-saved GPRs (mirror of prologue).
    let save_base = alloc_save_base(frame, alloc);
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = -((save_base + (i as u32) * 8 + 8) as i32);
        emit(code, enc_ldur(Reg(r), Reg(29), off));
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
    match p {
        Place::IntReg(r) => Some(Reg(r)),
        _ => None,
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::Compiler;

    fn lift_and_alloc(src: &str, target: Target) -> (super::super::ssa::FunctionSsa, Allocation) {
        let program = Compiler::new(src.into()).compile().expect("compile");
        let funcs = super::super::ssa::lift_program(&program).expect("lift");
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
        let ok = emit_function(
            &func,
            &alloc,
            Target::MacOSAarch64,
            &mut code,
            &mut fx,
            &mut plt,
            &mut data_fx,
            &mut pf_fx,
            &imps,
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
    /// (the c5 compiler emits `Imm 1; Psh; Imm 2; Add` plus the
    /// int-promotion shl/shr; the optimizer constant-folds it,
    /// but we run without -O here to keep the binop in play).
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
        let ok = emit_function(
            &func,
            &alloc,
            Target::MacOSAarch64,
            &mut code,
            &mut fx,
            &mut plt,
            &mut data_fx,
            &mut pf_fx,
            &imps,
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
        // The first function is `test`; the lift order is
        // declaration order, but `Inst::Call` for main isn't in
        // the thin slice yet, so we only check that `test` emits
        // cleanly. main will fall back.
        let mut code = Vec::new();
        let mut fx = Vec::new();
        let mut plt = Vec::new();
        let mut data_fx = Vec::new();
        let mut pf_fx = Vec::new();
        let imps = super::super::ResolvedImports::default();
        let ok = emit_function(
            &func,
            &alloc,
            Target::MacOSAarch64,
            &mut code,
            &mut fx,
            &mut plt,
            &mut data_fx,
            &mut pf_fx,
            &imps,
        );
        assert!(
            ok,
            "`test` should emit via the thin slice (cmp + cset + cbz + ldr params)"
        );
    }
}

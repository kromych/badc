//! x86_64 native emit consuming the SSA lift + allocator output.
//! Active when `NativeOptions::regalloc = RegallocMode::Ssa` and
//! the env var `BADC_USE_SSA_EMIT` is set. Mirrors the aarch64
//! counterpart's structure; the difference is the per-target
//! instruction encodings and the SysV / Win64 ABI shape applied
//! to argument and return placement.
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
//! outside the implemented subset. Under the default dispatch
//! the caller falls back to the pool path for that function;
//! setting `BADC_STRICT_SSA_EMIT=1` flips the policy to abort.

#![allow(dead_code, clippy::too_many_arguments)]

use alloc::vec::Vec;

use super::DataFixup;
use super::GotFixup;
use super::Target;
use super::ssa::{BinOp, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
use super::ssa_alloc::{Allocation, Place};
use super::x86_64::{
    Cc, Fixup, PltCallFixup, Reg, emit_add_rr, emit_add_rsp_imm32, emit_and_rr, emit_cmp_rr,
    emit_imul_rr, emit_lea_r_mem, emit_mov_mem_r, emit_mov_r_imm64, emit_mov_r_mem, emit_mov_rr,
    emit_movsx_r_mem16, emit_movsxd_r_mem, emit_movzx_r_mem16, emit_movzx_r_r8, emit_or_rr,
    emit_pop_r, emit_push_r, emit_ret, emit_sar_r_cl, emit_setcc_r8, emit_shl_r_cl, emit_shr_r_cl,
    emit_sub_rr, emit_sub_rsp_imm32, emit_xor_rr,
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
    #[cfg(feature = "std")]
    if std::env::var("BADC_DUMP_SSA").is_ok() {
        eprintln!("ssa emit x86_64: bailed -- {reason}");
    }
    let _ = reason;
}

/// Extract the int reg from a `Place`, or `None` if it's not an
/// integer register.
fn int_reg(place: Place) -> Option<Reg> {
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        _ => None,
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
    _tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
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

    let mut block_offsets: Vec<usize> = alloc::vec![0; func.blocks.len()];
    let mut branch_fixups: Vec<BranchFixup> = Vec::new();

    for (block_idx, block) in func.blocks.iter().enumerate() {
        block_offsets[block_idx] = code.len();
        if block_idx > 0 && block.start_pc < bytecode_to_native.len() {
            bytecode_to_native[block.start_pc] = code.len();
        }
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
                fixups,
                plt_call_fixups,
                data_fixups,
                pending_func_fixups,
                imports,
                variadic_targets,
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
                let Some(rc) = int_reg(cond_place) else {
                    bail_msg("Bz: cond Place not int reg");
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
                let Some(rc) = int_reg(cond_place) else {
                    bail_msg("Bnz: cond Place not int reg");
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
            Terminator::TailExt(_) => {
                bail_msg("TailExt terminator not yet handled");
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                return false;
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
    target: super::ssa::BlockId,
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
    fixups: &mut Vec<Fixup>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    data_fixups: &mut Vec<DataFixup>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
) -> bool {
    match inst {
        Inst::AllocaInit(slot) => {
            // Zero slot -> no alloca, emit nothing (matches the
            // pool path). Non-zero alloca isn't covered yet.
            *slot == 0
        }
        Inst::Imm(value) => {
            let Some(rd) = int_reg(dst) else {
                bail_msg("Imm: dst not int reg");
                return false;
            };
            emit_mov_r_imm64(code, rd, *value);
            true
        }
        Inst::LocalAddr(off) => {
            let Some(rd) = int_reg(dst) else {
                bail_msg("LocalAddr: dst not int reg");
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
            true
        }
        Inst::Load { addr, kind } => emit_load(code, dst, *addr, *kind, alloc),
        Inst::Store { addr, value, kind } => emit_store(code, dst, *addr, *value, *kind, alloc),
        Inst::Binop { op, lhs, rhs } => emit_binop(code, *op, dst, *lhs, *rhs, alloc),
        Inst::BinopI { op, lhs, rhs_imm } => emit_binop_imm(code, *op, dst, *lhs, *rhs_imm, alloc),
        Inst::Call { target_pc, args } => emit_call(
            code,
            dst,
            *target_pc,
            args,
            alloc,
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
            abi,
            plt_call_fixups,
            imports,
        ),
        Inst::ImmData(offset) => emit_imm_data(code, dst, *offset, data_fixups),
        Inst::ImmCode(target_bc_pc) => emit_imm_code(code, dst, *target_bc_pc, pending_func_fixups),
        Inst::VstackSpill { slot, value } => emit_vstack_spill(code, *slot, *value, alloc, frame),
        Inst::VstackReload { slot } => emit_vstack_reload(code, dst, *slot, frame),
        Inst::Mcpy {
            dst: d,
            src: s,
            size,
        } => emit_mcpy(code, dst, *d, *s, *size, alloc),
        Inst::CallIndirect { target, args } => {
            emit_call_indirect(code, dst, *target, args, alloc, abi)
        }
        Inst::Intrinsic { kind, args } => emit_intrinsic(code, *kind, args, dst, alloc),
        Inst::AccSpill { value } => {
            let value_place = alloc
                .places
                .get(*value as usize)
                .copied()
                .unwrap_or(Place::None);
            let Some(rs) = int_reg(value_place) else {
                bail_msg("AccSpill: value not in int reg");
                return false;
            };
            let sp_off = (frame.frame_bytes - frame.acc_slot_off) as i32;
            emit_mov_mem_r(code, Reg::RSP, sp_off, rs);
            true
        }
        Inst::AccReload => {
            let Some(rd) = int_reg(dst) else {
                bail_msg("AccReload: dst not int reg");
                return false;
            };
            let sp_off = (frame.frame_bytes - frame.acc_slot_off) as i32;
            emit_mov_r_mem(code, rd, Reg::RSP, sp_off);
            true
        }
        _ => {
            bail_msg("inst variant not yet covered");
            let _ = frame;
            false
        }
    }
}

/// Translate a c5-stack slot index (`Op::Lea`'s operand) into a
/// byte offset relative to rbp. Mirror of the aarch64 module's
/// helper: locals (`off < 0`) at `off*8`, params (`off >= 2`) at
/// `(off-1)*16`.
fn c5_slot_to_fp_offset(off: i64) -> i64 {
    if off >= 2 { (off - 1) * 16 } else { off * 8 }
}

fn emit_load(
    code: &mut Vec<u8>,
    dst: Place,
    addr: u32,
    kind: LoadKind,
    alloc: &Allocation,
) -> bool {
    let Some(rd) = int_reg(dst) else {
        bail_msg("Load: dst not int reg");
        return false;
    };
    let addr_place = alloc
        .places
        .get(addr as usize)
        .copied()
        .unwrap_or(Place::None);
    let Some(base) = int_reg(addr_place) else {
        bail_msg("Load: addr Place not int reg");
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
    let Some(base) = int_reg(addr_place) else {
        bail_msg("Store: addr Place not int reg");
        return false;
    };
    let Some(rs) = int_reg(value_place) else {
        bail_msg("Store: value Place not int reg");
        return false;
    };
    match kind {
        StoreKind::I64 => emit_mov_mem_r(code, base, 0, rs),
        StoreKind::I32 => super::x86_64::emit_mov_mem32_r(code, base, 0, rs),
        StoreKind::I16 => super::x86_64::emit_mov_mem16_r(code, base, 0, rs),
        StoreKind::I8 => super::x86_64::emit_mov_mem8_r(code, base, 0, rs),
        StoreKind::F32 => {
            bail_msg("Store: F32 not handled");
            return false;
        }
    }
    // The c5 store ops leave the stored value in the
    // accumulator. Propagate rs into dst (int reg only at this
    // stage).
    if let Some(rd) = int_reg(dst) {
        if rd.0 != rs.0 {
            emit_mov_rr(code, rd, rs);
        }
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
    let Some(rn) = int_reg(lhs_place) else {
        bail_msg("Binop: lhs not int reg");
        return false;
    };
    let Some(rm) = int_reg(rhs_place) else {
        bail_msg("Binop: rhs not int reg");
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
    true
}

fn emit_binop_imm(
    code: &mut Vec<u8>,
    op: BinOp,
    dst: Place,
    lhs: u32,
    rhs_imm: i64,
    alloc: &Allocation,
) -> bool {
    let Some(rd) = int_reg(dst) else {
        bail_msg("BinopI: dst not int reg");
        return false;
    };
    let lhs_place = alloc
        .places
        .get(lhs as usize)
        .copied()
        .unwrap_or(Place::None);
    let Some(rn) = int_reg(lhs_place) else {
        bail_msg("BinopI: lhs not int reg");
        return false;
    };
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
    true
}

fn emit_call(
    code: &mut Vec<u8>,
    dst: Place,
    target_pc: usize,
    args: &[u32],
    alloc: &Allocation,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    callee_is_variadic: bool,
) -> bool {
    if callee_is_variadic {
        bail_msg("Call: variadic target not yet handled");
        return false;
    }
    // Compute fp_arg_mask from value places. FpReg-placed args
    // are f64 and route through xmm regs.
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
        emit_sub_rsp_imm32(code, plan.scratch_bytes);
    }
    for (i, &placement) in plan.placements.iter().enumerate() {
        let arg_id = args[i];
        let arg_place = alloc
            .places
            .get(arg_id as usize)
            .copied()
            .unwrap_or(Place::None);
        match placement {
            super::ArgPlacement::IntReg(r) => {
                let Some(src) = int_reg(arg_place) else {
                    bail_msg("Call: int arg not in int reg");
                    return false;
                };
                if src.0 != r {
                    emit_mov_rr(code, Reg(r), src);
                }
            }
            super::ArgPlacement::Stack(off) => {
                let Some(src) = int_reg(arg_place) else {
                    bail_msg("Call: stack arg not in int reg");
                    return false;
                };
                emit_mov_mem_r(code, Reg::RSP, off as i32, src);
            }
            super::ArgPlacement::FpReg(_) => {
                bail_msg("Call: FpReg placement not yet handled");
                return false;
            }
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
    // Return value lands in rax. Propagate to dst.
    if let Some(rd) = int_reg(dst) {
        if rd.0 != 0 {
            emit_mov_rr(code, rd, Reg::RAX);
        }
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
    abi: super::Abi,
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
        match placement {
            super::ArgPlacement::IntReg(r) => {
                let Some(src) = int_reg(arg_place) else {
                    bail_msg("CallExt: int arg not in int reg");
                    return false;
                };
                if src.0 != r {
                    emit_mov_rr(code, Reg(r), src);
                }
            }
            super::ArgPlacement::Stack(off) => {
                let Some(src) = int_reg(arg_place) else {
                    bail_msg("CallExt: stack arg not in int reg");
                    return false;
                };
                emit_mov_mem_r(code, Reg::RSP, off as i32, src);
            }
            super::ArgPlacement::FpReg(_) => {
                bail_msg("CallExt: FpReg placement not yet handled");
                return false;
            }
        }
    }
    // SysV AMD64 (System V AMD64 ABI, 3.2.3): for variadic
    // callees `al` must hold the number of XMM argument
    // registers used; this emit path passes all args in GPRs,
    // so `al = 0`. Win64 has no such requirement and clears
    // `variadic_zero_xmm_count`.
    if abi.variadic_zero_xmm_count {
        super::x86_64::emit_xor_eax_eax(code);
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
    // extension into rax. FP returns arrive in xmm0; the SSA emit
    // doesn't yet bridge xmm0 -> rax here. Most c5 demos that
    // call libc only consume integer-shaped returns, so the
    // tighter bridge can wait.
    use crate::c5::compiler::types as ty_helpers;
    let return_type_tag = imp.return_type_tag;
    let bare = ty_helpers::strip_unsigned(return_type_tag);
    if ty_helpers::is_float_ty(bare) || ty_helpers::is_double_ty(bare) {
        bail_msg("CallExt: FP return not yet bridged to rax");
        return false;
    }
    let ext = super::return_extension(return_type_tag, super::Target::LinuxX64);
    super::x86_64::emit_extend_rax_for_return(code, ext);
    if let Some(rd) = int_reg(dst) {
        if rd.0 != 0 {
            emit_mov_rr(code, rd, Reg::RAX);
        }
    }
    true
}

fn emit_call_indirect(
    code: &mut Vec<u8>,
    dst: Place,
    target: u32,
    args: &[u32],
    alloc: &Allocation,
    abi: super::Abi,
) -> bool {
    let target_place = alloc
        .places
        .get(target as usize)
        .copied()
        .unwrap_or(Place::None);
    let Some(target_r) = int_reg(target_place) else {
        bail_msg("CallIndirect: target not in int reg");
        return false;
    };
    // Capture the target pointer into r11 before arg marshalling
    // can clobber it. r11 is caller-saved on every x86_64 ABI we
    // target and the SSA allocator excludes it from the pool.
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
        match placement {
            super::ArgPlacement::IntReg(r) => {
                let Some(src) = int_reg(arg_place) else {
                    bail_msg("CallIndirect: int arg not in int reg");
                    return false;
                };
                if src.0 != r {
                    emit_mov_rr(code, Reg(r), src);
                }
            }
            super::ArgPlacement::Stack(off) => {
                let Some(src) = int_reg(arg_place) else {
                    bail_msg("CallIndirect: stack arg not in int reg");
                    return false;
                };
                emit_mov_mem_r(code, Reg::RSP, off as i32, src);
            }
            super::ArgPlacement::FpReg(_) => {
                bail_msg("CallIndirect: FpReg placement not yet handled");
                return false;
            }
        }
    }
    super::x86_64::emit_call_r(code, Reg::R11);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    if let Some(rd) = int_reg(dst) {
        if rd.0 != 0 {
            emit_mov_rr(code, rd, Reg::RAX);
        }
    }
    true
}

fn emit_intrinsic(
    code: &mut Vec<u8>,
    kind: i64,
    args: &[u32],
    dst: Place,
    alloc: &Allocation,
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
            // rax = &last + 16 ; mov [ap], rax
            emit_lea_r_mem(code, Reg::RAX, last, 16);
            emit_mov_mem_r(code, ap, 0, Reg::RAX);
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
            // rd = *ap ; rax = rd + 16 ; *ap = rax
            emit_mov_r_mem(code, rd, ap, 0);
            emit_lea_r_mem(code, Reg::RAX, rd, 16);
            emit_mov_mem_r(code, ap, 0, Reg::RAX);
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
            emit_mov_r_mem(code, Reg::RAX, src_p, 0);
            emit_mov_mem_r(code, dst_p, 0, Reg::RAX);
            true
        }
        I::Alloca | I::SetjmpAArch64 | I::LongjmpAArch64 => {
            bail_msg("intrinsic: alloca / setjmp / longjmp not yet handled on x86_64");
            false
        }
    }
}

fn emit_imm_data(
    code: &mut Vec<u8>,
    dst: Place,
    offset: i64,
    data_fixups: &mut Vec<DataFixup>,
) -> bool {
    let Some(rd) = int_reg(dst) else {
        bail_msg("ImmData: dst not int reg");
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
    true
}

fn emit_imm_code(
    code: &mut Vec<u8>,
    dst: Place,
    target_bc_pc: usize,
    pending_func_fixups: &mut Vec<(usize, usize)>,
) -> bool {
    let Some(rd) = int_reg(dst) else {
        bail_msg("ImmCode: dst not int reg");
        return false;
    };
    let instr_offset = code.len();
    pending_func_fixups.push((instr_offset, target_bc_pc));
    super::x86_64::emit_lea_r_rip32(code, rd, 0);
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
    let Some(rs) = int_reg(value_place) else {
        bail_msg("VstackSpill: value not in int reg");
        return false;
    };
    let sp_off = (frame.frame_bytes - frame.acc_slot_off + 8 + slot * 8) as i32;
    emit_mov_mem_r(code, Reg::RSP, sp_off, rs);
    true
}

fn emit_vstack_reload(code: &mut Vec<u8>, dst: Place, slot: u32, frame: Frame) -> bool {
    let Some(rd) = int_reg(dst) else {
        bail_msg("VstackReload: dst not int reg");
        return false;
    };
    let sp_off = (frame.frame_bytes - frame.acc_slot_off + 8 + slot * 8) as i32;
    emit_mov_r_mem(code, rd, Reg::RSP, sp_off);
    true
}

fn emit_mcpy(
    code: &mut Vec<u8>,
    dst_place: Place,
    dst_val: u32,
    src_val: u32,
    size: i64,
    alloc: &Allocation,
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
    let Some(dst_r) = int_reg(dst_in) else {
        bail_msg("Mcpy: dst base not int reg");
        return false;
    };
    let Some(src_r) = int_reg(src_in) else {
        bail_msg("Mcpy: src base not int reg");
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
    } else {
        Reg::RCX
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
    if let Some(rd) = int_reg(dst_place) {
        if rd.0 != dst_r.0 {
            emit_mov_rr(code, rd, dst_r);
        }
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
    // and the return value is lost.
    let return_src = if value != super::ssa::NO_VALUE {
        let place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        int_reg(place)
    } else {
        None
    };
    if let Some(src) = return_src {
        if src.0 != Reg::RCX.0 {
            emit_mov_rr(code, Reg::RCX, src);
        }
    }
    // Restore callee-saved GPRs (mirror of the prologue's saves).
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = (i as i32) * 8;
        super::x86_64::emit_mov_r_mem(code, Reg(r), Reg::RSP, off);
    }
    if return_src.is_some() {
        emit_mov_rr(code, Reg::RAX, Reg::RCX);
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

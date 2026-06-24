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

use alloc::vec::Vec;

use super::super::ir::{BinOp, FpCastKind, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
use super::DataFixup;
use super::GotFixup;
use super::Target;
use super::ssa_alloc::{Allocation, Place};
use super::x86_64::{
    Cc, Fixup, PltCallFixup, Reg, emit_add_r_mem, emit_add_rr, emit_add_rsp_imm32, emit_addsd,
    emit_addss, emit_and_r_imm32, emit_and_r_mem, emit_and_rr, emit_cmp_r_mem, emit_cmp_rr,
    emit_cvtsd2ss, emit_cvtsi2sd, emit_cvtss2sd, emit_cvttsd2si, emit_divsd, emit_divss,
    emit_imul_r_mem, emit_imul_rr, emit_jcc_rel8, emit_jmp_rel8, emit_lea_r_mem,
    emit_lock_cmpxchg_mem_r, emit_lock_xadd_mem_r, emit_mov_mem_r, emit_mov_r_imm64,
    emit_mov_r_mem, emit_mov_rr, emit_movapd_xmm_xmm, emit_movq_xmm_r, emit_movsd_mem_xmm,
    emit_movsd_xmm_mem, emit_movss_mem_xmm, emit_movss_xmm_mem, emit_movsx_r_mem16,
    emit_movsxd_r_mem, emit_movups_mem_xmm, emit_movups_xmm_mem, emit_movzx_r_mem16,
    emit_movzx_r_r8, emit_mulsd, emit_mulss, emit_neg_r, emit_or_r_mem, emit_or_rr, emit_pop_r,
    emit_push_r, emit_ret, emit_sar_r_cl, emit_setcc_r8, emit_shl_r_cl, emit_shr_r_cl,
    emit_shr_r_imm8, emit_sub_r_mem, emit_sub_rr, emit_sub_rsp_imm32, emit_subsd, emit_subss,
    emit_test_rr, emit_ucomisd, emit_ucomiss, emit_vfmadd231sd, emit_vfmadd231ss, emit_vfmsub231sd,
    emit_vfmsub231ss, emit_vfnmadd231sd, emit_vfnmadd231ss, emit_vfnmsub231sd, emit_vfnmsub231ss,
    emit_xchg_mem_r, emit_xchg_rr, emit_xor_r_mem, emit_xor_rr, emit_xorpd,
};

/// Per-function frame layout. Bytes are 16-aligned at every
/// region boundary so SysV / Win64's sp-at-call invariant holds.
#[derive(Debug, Clone, Copy)]
pub(super) struct Frame {
    pub frame_bytes: u32,
    pub alloc_spill_base: u32,
    /// Total bytes the prologue allocates between the return
    /// address and the saved rbp for c5 cdecl parameter slots
    /// and host-stack overflow. The epilogue reads this directly
    /// so prologue and epilogue agree on one byte count regardless
    /// of which branch the prologue took.
    pub param_spill_bytes: u32,
    /// Byte stride between adjacent parameter cells in the callee
    /// frame. 16 today (the c5 cdecl cell width the prologue
    /// allocates and `va_arg` walks). Carried on the frame so a
    /// later phase can shrink non-variadic cells in one place;
    /// `c5_slot_to_fp_offset` and the prologue both read it.
    pub param_cell_stride: i64,
    /// Bytes of System V AMD64 register save area (3.5.7) reserved
    /// inside the frame for a System V variadic callee:
    /// `SYSV_REG_SAVE_BYTES` (176) for one, 0 otherwise.
    pub va_save_bytes: u32,
    /// rbp-relative byte offset (always negative) of the System V
    /// register save area's base -- the start of the gp area, with the
    /// fp area at `+48`. The area sits between the spill region above it
    /// (locals + allocator spills, addressed top-down from rbp) and the
    /// saved-callee-GPR region below it (addressed bottom-up from rsp),
    /// so both keep their existing offset formulas: `base =
    /// -(locals_bytes + alloc_spill_bytes + va_save_bytes)`. `va_start`
    /// stores it as `reg_save_area`; `va_arg` reads from it. 0 when the
    /// callee is not a System V variadic callee.
    pub va_reg_save_off: i32,
    /// Bytes reserved at the bottom of the frame (lowest addresses, just
    /// above rsp) for saved non-volatile xmm scratch registers: 16 per
    /// register in `alloc.fp_used`, 0 on System V (where every xmm is
    /// volatile). The saved-GPR region sits directly above it, so the
    /// GPR save/restore offsets shift up by this amount. The values are
    /// stored with `movups` (no alignment requirement).
    pub saved_fpr_bytes: u32,
}

impl Frame {
    pub fn for_function(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) -> Self {
        let declared_locals_bytes = super::ssa_emit_common::slots16(func.locals.max(0) as u32);
        // After mem2reg + dead-store elimination, every reference to
        // user-local slots (negative `off`) may be gone. The
        // surviving `func.insts` is the source of truth; when no
        // `LoadLocal` / `StoreLocal` / `LocalAddr` references a
        // negative slot the prologue need not allocate locals
        // storage (C99 6.2.4p2: a never-observed object needs no
        // storage). Param cells use non-negative `off` and are
        // sized by `param_spill_bytes`, so they are not affected.
        let any_local_access = func.insts.iter().any(|i| match i {
            Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => *off < 0,
            Inst::LocalAddr(off) => *off < 0,
            _ => false,
        });
        let locals_bytes = if any_local_access {
            declared_locals_bytes
        } else {
            0
        };
        let alloc_spill_bytes = super::ssa_emit_common::slots16(alloc.spill_count);
        let saved_gpr_bytes = super::ssa_emit_common::slots16(alloc.gpr_used.len() as u32);
        // System V variadic callees reserve the 176-byte register save
        // area (System V AMD64 3.5.7) at the bottom of the frame. It is
        // added to `frame_bytes` only; `alloc_spill_base` (and thus the
        // spill / locals offsets, which are measured from rbp down by
        // `alloc_spill_base`) is unchanged, so the existing regions keep
        // their rbp-relative positions and the save area takes the lowest
        // bytes.
        let va_save_bytes = if sysv_variadic_callee(func, abi) {
            SYSV_REG_SAVE_BYTES
        } else {
            0
        };
        // The save area sits above the saved-callee-GPR region
        // (addressed bottom-up from rsp) and below the locals / spill
        // region (addressed top-down from rbp), so neither region's
        // offset formula changes. Its base is the gp area start.
        let va_reg_save_off = if va_save_bytes > 0 {
            -((locals_bytes + alloc_spill_bytes + va_save_bytes) as i32)
        } else {
            0
        };
        // Saved non-volatile xmm scratch (Win64): 16 bytes per register,
        // placed at the bottom of the frame below the saved-GPR region.
        let saved_fpr_bytes = alloc.fp_used.len() as u32 * 16;
        let frame_bytes =
            locals_bytes + alloc_spill_bytes + saved_gpr_bytes + va_save_bytes + saved_fpr_bytes;
        let param_spill_bytes = prologue_param_spill_bytes(func, alloc, abi);
        // A Win64 variadic callee receives every argument (named and
        // variadic) in a contiguous 8-byte-per-argument region: the
        // first four in rcx/rdx/r8/r9 (spilled by the prologue into
        // the caller-reserved home area at `[rbp + 16 + i*8]`), the
        // rest on the incoming stack just above it. The body reads its
        // named parameters and `va_arg` walks the variadic tail with a
        // single 8-byte stride across that region, so the cell stride
        // is 8 rather than the 16-byte c5 cdecl cell width. Every other
        // callee keeps the 16-byte stride.
        let param_cell_stride = if win64_variadic_callee(func, abi) {
            8
        } else {
            16
        };
        Self {
            frame_bytes,
            alloc_spill_base: locals_bytes,
            param_spill_bytes,
            param_cell_stride,
            va_save_bytes,
            va_reg_save_off,
            saved_fpr_bytes,
        }
    }
}

/// True when the function is a variadic c5 callee compiled for the
/// Win64 host variadic ABI (Microsoft x64 calling convention). Win64
/// is the only x86_64 target whose `Abi` sets `position_indexed_args`
/// (the by-position rcx/rdx/r8/r9 placement); SysV x86_64 leaves it
/// clear, so this gate selects Win64 alone and leaves the SysV
/// variadic c5 path on its 16-byte cdecl stack-push shape byte for
/// byte. Under this ABI named arguments arrive in argument registers
/// and the variadic tail rides the incoming stack at 8-byte stride;
/// the prologue spills the named register arguments into the caller's
/// home area, `va_start` points at the first variadic 8-byte slot, and
/// `va_arg` advances 8.
fn win64_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
    debug_assert!(
        !abi.position_indexed_args || matches!(abi.arch, super::Arch::X86_64),
        "position_indexed_args is a Win64 x86_64 property"
    );
    func.is_variadic && abi.position_indexed_args
}

/// Bytes the System V AMD64 register save area occupies (ABI 3.5.7):
/// the six integer argument registers (rdi rsi rdx rcx r8 r9) at
/// `[base + 0 .. 48]` followed by the eight XMM argument registers
/// (xmm0..xmm7) at `[base + 48 .. 176]`. `va_start`'s gp_offset /
/// fp_offset and `va_arg`'s 48 / 176 bounds all derive from this
/// single layout.
const SYSV_GP_SAVE_BYTES: u32 = 6 * 8;
const SYSV_FP_SAVE_BYTES: u32 = 8 * 16;
const SYSV_REG_SAVE_BYTES: u32 = SYSV_GP_SAVE_BYTES + SYSV_FP_SAVE_BYTES;

/// True when the function is a variadic c5 callee compiled for the
/// System V AMD64 host variadic ABI (Linux x86_64). System V is the
/// x86_64 target with `shadow_space == 0`, no `position_indexed_args`
/// (the standard rdi/rsi/.../xmm bank placement), and
/// `variadic_zero_xmm_count` set (the caller passes the XMM-argument
/// count in `al`). Win64 (shadow_space 32, position_indexed_args,
/// no al) and every aarch64 target are excluded, so this gate selects
/// Linux x86_64 alone.
///
/// Under this ABI the named arguments arrive in the standard argument
/// registers (integer bank rdi.. + FP bank xmm0..), the variadic tail
/// rides the same banks then the incoming stack, the callee prologue
/// spills rdi..r9 + xmm0..xmm7 into a register save area (System V
/// AMD64 3.5.7), `va_start` initialises the `__va_list_tag` offsets and
/// pointers, and `va_arg` walks the gp area, fp area, then the overflow
/// area per `kind`.
fn sysv_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
    func.is_variadic
        && matches!(abi.arch, super::Arch::X86_64)
        && abi.shadow_space == 0
        && !abi.position_indexed_args
        && abi.variadic_zero_xmm_count
}

/// Registers that are caller-saved on both SysV AMD64 and Win64.
/// Candidate pool for `pick_caller_saved_scratch`, used to find an
/// *additional* scratch beyond the dedicated fixed scratch r10 / r11.
/// The intersection of the two ABIs' caller-saved sets is rax, rcx,
/// rdx, r8, r9, r10, r11; rsi and rdi are caller-saved on SysV but
/// callee-saved on Win64, so they are excluded. r10 / r11 are the
/// reserved fixed scratch (`SCRATCH_R10` / `SCRATCH_R11`) and are
/// excluded so a pick never aliases a register the caller already
/// committed as scratch. Order favours rax (rarely a call argument)
/// then the argument registers rcx / rdx / r8 / r9.
const CALLER_SAVED_INT_SCRATCHES: &[u8] = &[0, 1, 2, 8, 9];

/// Pick a caller-saved x86_64 GPR that is neither `rd` nor any
/// register in `operand_regs`. Returns `None` when every
/// candidate in `CALLER_SAVED_INT_SCRATCHES` is excluded -- callers
/// then bail the emit rather than silently fall through to a
/// callee-saved register (which would violate the System V /
/// Win64 callee-save contract and corrupt the caller's state on
/// return). Used by emit handlers that need an intra-instruction
/// scratch (BinopI immediate-materialise, VaArg staging, alloca
/// bookkeeping, ...).
fn pick_caller_saved_scratch(rd: Reg, operand_regs: &[Reg]) -> Option<Reg> {
    for cand in CALLER_SAVED_INT_SCRATCHES {
        if *cand == rd.0 {
            continue;
        }
        if operand_regs.iter().any(|r| r.0 == *cand) {
            continue;
        }
        return Some(Reg(*cand));
    }
    None
}

/// Same as `pick_caller_saved_scratch`, but additionally avoids
/// any register that carries an SSA value live across the current
/// instruction. `pc` is the current instruction's index; a value
/// `x` is live across `pc` when `x < pc < alloc.last_use[x]`. The
/// chosen scratch is then disjoint from `rd`, the operand list,
/// and every register the next instructions need to read.
fn pick_caller_saved_scratch_live_aware(
    rd: Reg,
    operand_regs: &[Reg],
    pc: u32,
    alloc: &Allocation,
) -> Option<Reg> {
    let mut live: alloc::vec::Vec<Reg> = alloc::vec::Vec::with_capacity(operand_regs.len() + 4);
    live.extend_from_slice(operand_regs);
    for (idx, place) in alloc.places.iter().enumerate() {
        let last = alloc.last_use.get(idx).copied().unwrap_or(0);
        let i = idx as u32;
        if i < pc
            && pc < last
            && let Place::IntReg(r) = place
        {
            live.push(Reg(*r));
        }
    }
    pick_caller_saved_scratch(rd, &live)
}

/// Total bytes the prologue allocates between the return
/// address and the saved rbp for c5 cdecl parameter slots plus
/// host-stack overflow. Mirrors the prologue's branch structure
/// exactly so prologue and epilogue agree on one value:
///
/// * Variadic callees: the caller pushes 16-byte cells onto the
///   bytecode stack; the callee allocates nothing.
/// * Non-variadic, n_params within `int_arg_regs.len()`:
///   `n_reg * 16`, or 0 when every register-passed parameter is
///   `ParamRef`-seeded with no address taken and no surviving
///   `Load/StoreLocal` -- in which case the entire register
///   stripe drops out and no `pop r10` / `push r10` sequence is
///   needed to preserve the return address.
/// * Non-variadic, host-stack overflow: full `n_params * 16`.
/// * Struct-returning callees: the walker excludes them from
///   `ParamRef` synthesis, so `seeded` is empty, the elision
///   check fails, and `n_params * 16` is returned.
/// A function that meets every condition to skip the standard
/// push rbp / mov rbp,rsp / pop rbp prologue triple: no callee
/// it must reserve frame for, no param spill, no callee-saved
/// GPR to spill. The caller-pushed return address sits at top of
/// stack untouched, so the function can ret directly with no
/// stack adjustment.
fn is_full_leaf(func: &FunctionSsa, frame: Frame, alloc: &Allocation, abi: super::Abi) -> bool {
    if frame.frame_bytes != 0 || frame.param_spill_bytes != 0 {
        return false;
    }
    // A Win64 variadic callee must establish rbp so the prologue can
    // spill its named register arguments into the caller's home area
    // and the body / `va_arg` can address that area through rbp; it is
    // never leaf-elided.
    if win64_variadic_callee(func, abi) {
        return false;
    }
    // A System V variadic callee must establish rbp and a frame for its
    // register save area (System V AMD64 3.5.7) and named-parameter
    // cells; it is never leaf-elided.
    if sysv_variadic_callee(func, abi) {
        return false;
    }
    if !alloc.gpr_used.is_empty() {
        return false;
    }
    // A saved non-volatile xmm scratch (Win64) needs a frame to hold it
    // and an epilogue to restore it.
    if !alloc.fp_used.is_empty() {
        return false;
    }
    !func.insts.iter().any(|inst| {
        matches!(
            inst,
            Inst::Call { .. }
                | Inst::CallIndirect { .. }
                | Inst::CallExt { .. }
                | Inst::TailExt(_)
                | Inst::Intrinsic { .. }
                | Inst::TlsAddr(_)
        )
    })
}

/// Per-parameter elidability scan. Returns the `(elidable, n_reg,
/// n_stack)` triple `emit_prologue` and `prologue_param_spill_bytes`
/// both consume. `elidable[i]` is true when parameter `i` has a
/// surviving `Inst::ParamRef`, no `LocalAddr`, and no live
/// `Load/StoreLocal` against its c5-cdecl arg slot -- i.e. the body
/// reads the value through the host arg register the SysV / Win64
/// ABI placed it in, and the cell that the cdecl prologue would
/// otherwise allocate at `[rbp + 16*(i+1)]` is unobserved.
///
/// Variadic and zero-parameter callees return an empty mask;
/// host-stack overflow parameters (idx >= int_arg_regs.len()) are
/// never elidable because the c5 emit always reads the cell.
/// Per-parameter incoming-register placement from `plan_call_args`.
/// Indexed by declared parameter position. Variadic and zero-param
/// callees yield an empty plan. Consumed by the prologue spill and
/// the `Inst::ParamRef` lowering to resolve each parameter's incoming
/// integer / FP register through the independent argument-register
/// banks.
fn param_placements(func: &FunctionSsa, abi: super::Abi) -> alloc::vec::Vec<super::ArgPlacement> {
    if func.is_variadic || func.n_params == 0 {
        return alloc::vec::Vec::new();
    }
    if func.param_aggs.iter().all(Option::is_none) {
        return super::plan_param_regs(func.n_params, func.param_fp_mask, abi).placements;
    }
    let aggs: Vec<Option<super::ArgAgg>> = func
        .param_aggs
        .iter()
        .map(|o| {
            o.map(|idx| {
                let d = &func.agg_descs[idx as usize];
                super::ArgAgg {
                    class: super::abi_classify::classify_aggregate(
                        d.size, d.align, &d.fields, abi, false,
                    ),
                    size: d.size,
                }
            })
        })
        .collect();
    super::plan_param_regs_aggs(func.n_params, func.param_fp_mask, abi, &aggs).placements
}

/// `(n_reg, n_stack)` split of the declared parameters: how many land
/// in argument registers (integer or FP) and how many overflow to the
/// host stack. The prologue's c5 cdecl cell layout requires the
/// register-passed parameters to form a contiguous prefix and the
/// stack-passed ones a contiguous suffix; that holds whenever neither
/// argument-register bank is exhausted before a later parameter of the
/// other bank is placed. TODO: a parameter list that exhausts the
/// integer bank before a trailing floating-point parameter would
/// interleave register and stack placements; such lists are not yet
/// lowered (the debug assertion fires).
fn param_reg_stack_split(func: &FunctionSsa, abi: super::Abi) -> (usize, usize) {
    let placements = param_placements(func, abi);
    // The count of register-passed (non-stack) placements and the count
    // of stack-passed ones. The entry-spill prologue fills each c5 cdecl
    // cell by its own placement, so the two need not form a contiguous
    // register prefix and stack suffix; a by-value aggregate consuming no
    // argument register (System V MEMORY class) or a Win64 aggregate
    // overflowing past the positional registers may interleave them.
    let n_reg = placements
        .iter()
        .filter(|p| !matches!(p, super::ArgPlacement::Stack(_)))
        .count();
    (n_reg, placements.len() - n_reg)
}

fn param_elidable_mask(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> (alloc::vec::Vec<bool>, usize, usize) {
    if func.is_variadic || func.n_params == 0 {
        return (alloc::vec::Vec::new(), 0, 0);
    }
    // Register-passed vs host-stack-overflow split comes from the
    // same `plan_call_args` the caller runs. Independent int / FP
    // argument-register banks (System V AMD64 3.2.3) mean the count
    // of register-passed parameters can exceed `int_arg_regs.len()`
    // (e.g. eight floating-point parameters in xmm0..xmm7 alongside
    // integer parameters), so the count is derived from the plan
    // rather than `n_params.min(int_arg_regs.len())`.
    let (n_reg, n_stack) = param_reg_stack_split(func, abi);
    let mut seeded: alloc::collections::BTreeSet<u32> = alloc::collections::BTreeSet::new();
    let mut addr_taken: alloc::collections::BTreeSet<i64> = alloc::collections::BTreeSet::new();
    let mut needed: alloc::collections::BTreeSet<i64> = alloc::collections::BTreeSet::new();
    for (idx, inst) in func.insts.iter().enumerate() {
        match inst {
            Inst::ParamRef { idx: i, .. } => {
                seeded.insert(*i);
            }
            Inst::LocalAddr(off) if *off >= 2 => {
                addr_taken.insert(*off);
            }
            Inst::LoadLocal { off, .. } if *off >= 2 => {
                let alive = alloc.use_counts.get(idx).copied().unwrap_or(0) > 0;
                if alive {
                    needed.insert(*off);
                }
            }
            Inst::StoreLocal { off, .. } if *off >= 2 => {
                needed.insert(*off);
            }
            _ => {}
        }
    }
    // A parameter whose incoming argument register the per-inst
    // `ParamRef` path clobbers before it is read must keep its c5 cdecl
    // home cell so it can read the value back from that cell rather than
    // from the clobbered register (see `compute_param_from_home`).
    // mem2reg may otherwise have promoted the parameter into a register
    // and left its slot unobserved, which would mark it elidable and
    // drop the home spill the per-inst read depends on.
    let clobbered = param_home_clobber_set(func, alloc, abi);
    let mut elidable = alloc::vec::Vec::with_capacity(n_reg);
    for i in 0..n_reg {
        let slot = (i as i64) + 2;
        let ok = seeded.contains(&(i as u32))
            && !addr_taken.contains(&slot)
            && !needed.contains(&slot)
            && !clobbered.get(i).copied().unwrap_or(false);
        elidable.push(ok);
    }
    (elidable, n_reg, n_stack)
}

/// A register parameter that the entry parallel copy
/// ([`emit_function`]'s prebatch) cannot place atomically and that the
/// per-inst `Inst::ParamRef` path therefore lowers with a register read
/// whose incoming argument register an earlier-emitted `ParamRef`'s
/// home write already clobbered.
///
/// The entry parallel copy avoids the hazard by placing every register
/// parameter from its (distinct) argument register at once. It runs only
/// when the parameter homes are pairwise distinct, the parallel-copy
/// precondition. When two homes coincide the batch is skipped and the
/// per-inst path runs; a parameter whose argument register is then
/// clobbered must read its prologue-spilled c5 cdecl home cell instead.
/// This returns the per-parameter mask of exactly those at-risk
/// parameters; it is empty whenever the batch runs (every parameter is
/// placed atomically, so none is at risk). The mask depends only on
/// `alloc.places` and `Inst::ParamRef` order, neither of which the
/// resulting home-cell spill changes, so the elidability scan and the
/// prologue both consult it without a fixpoint.
fn param_home_clobber_set(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    if func.is_variadic || func.n_params == 0 {
        return alloc::vec::Vec::new();
    }
    // The clobber set tracks the integer argument-register bank only.
    // Floating-point parameters arrive in the separate FP bank, so an
    // FP `ParamRef`'s write can never clobber an integer parameter's
    // incoming register (and vice versa). The mask spans the
    // register-passed parameters; FP entries stay `false`.
    let param_plan = param_placements(func, abi);
    let n_reg = param_plan
        .iter()
        .filter(|p| !matches!(p, super::ArgPlacement::Stack(_)))
        .count();
    let mut mask = alloc::vec![false; n_reg];
    if n_reg == 0 {
        return mask;
    }
    // Floating-point parameters are never placed by the integer entry
    // batch, so the per-inst `ParamRef` path always lowers them and the
    // same clobber hazard applies within the FP bank: an FP parameter
    // whose incoming xmm an earlier-emitted FP `ParamRef`'s destination
    // overwrites must read its prologue-spilled home cell. This pass is
    // independent of the integer `homes_distinct` gate below.
    {
        let mut written_fp: alloc::collections::BTreeSet<u8> = alloc::collections::BTreeSet::new();
        for (vid, inst) in func.insts.iter().enumerate() {
            let Inst::ParamRef { idx, kind } = inst else {
                continue;
            };
            if !matches!(kind, LoadKind::F32 | LoadKind::F64) {
                continue;
            }
            let i = *idx as usize;
            if i >= n_reg {
                continue;
            }
            if super::ssa_emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc) {
                continue;
            }
            let Some(super::ArgPlacement::FpReg(arg_reg)) = param_plan.get(i).copied() else {
                continue;
            };
            if written_fp.contains(&arg_reg) {
                mask[i] = true;
            }
            if let Some(Place::FpReg(r)) = alloc.places.get(vid).copied() {
                written_fp.insert(r);
            }
        }
    }
    // Mirror the prebatch eligibility and the `homes_distinct` gate in
    // `emit_function`: the entry parallel copy batches every register
    // parameter whose home is an integer register or a spill slot, and
    // runs only when those homes are pairwise distinct. When it runs no
    // parameter is at risk.
    let mut batch_homes: alloc::vec::Vec<Place> = alloc::vec::Vec::new();
    for (vid, inst) in func.insts.iter().enumerate() {
        let Inst::ParamRef { idx, .. } = inst else {
            continue;
        };
        if (*idx as usize) >= n_reg {
            continue;
        }
        if super::ssa_emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc) {
            continue;
        }
        let dst = alloc.places.get(vid).copied().unwrap_or(Place::None);
        if matches!(dst, Place::IntReg(_) | Place::Spill(_)) {
            batch_homes.push(dst);
        }
    }
    let homes_distinct = (0..batch_homes.len()).all(|a| {
        ((a + 1)..batch_homes.len()).all(|b| !place_same_loc(batch_homes[a], batch_homes[b]))
    });
    if !batch_homes.is_empty() && homes_distinct {
        return mask;
    }
    // Per-inst path: a later parameter whose argument register was
    // already written by an earlier `ParamRef`'s home placement is
    // clobbered before it can be read.
    let mut written: alloc::collections::BTreeSet<u8> = alloc::collections::BTreeSet::new();
    for (vid, inst) in func.insts.iter().enumerate() {
        let Inst::ParamRef { idx, .. } = inst else {
            continue;
        };
        let i = *idx as usize;
        if i >= n_reg {
            continue;
        }
        // Only integer parameters participate in the integer-bank
        // clobber tracking; an FP parameter's incoming xmm register is
        // disjoint from `int_arg_regs`.
        let Some(super::ArgPlacement::IntReg(arg_reg)) = param_plan.get(i).copied() else {
            continue;
        };
        if written.contains(&arg_reg) {
            mask[i] = true;
        }
        if let Some(Place::IntReg(r)) = alloc.places.get(vid).copied() {
            written.insert(r);
        }
    }
    mask
}

fn prologue_param_spill_bytes(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) -> u32 {
    let (elidable, n_reg, n_stack) = param_elidable_mask(func, alloc, abi);
    // The reg-stripe stays allocated when any single parameter
    // needs its cell (address-taken or LoadLocal-surviving), so the
    // c5 cdecl offsets `[rbp + 16*(i+1)]` remain stable for the
    // body. The mov store for each individually elidable parameter
    // is skipped at emit time. Stack-overflow parameters always
    // need their cell.
    let any_reg_needed = elidable.iter().any(|e| !e);
    let reg_bytes = if any_reg_needed || n_stack > 0 {
        (n_reg as u32) * 16
    } else {
        0
    };
    let overflow_bytes = (n_stack as u32) * 16;
    reg_bytes + overflow_bytes
}

/// Per-parameter mask: `mask[idx]` is true when the per-inst
/// `Inst::ParamRef` for register parameter `idx` must read its value
/// from the prologue-spilled c5 cdecl home cell rather than from the
/// incoming host argument register.
///
/// The hazard: the allocator can color several `ParamRef` values into
/// one register (sequentially-live parameters consumed by intervening
/// stores). When the destination register an earlier-emitted
/// `ParamRef` writes is a later parameter's incoming argument register,
/// the write clobbers that argument value before the later `ParamRef`
/// reads it. The home cell is immune because the prologue stored it
/// before any body instruction ran. The set is exactly the clobber set
/// from [`param_home_clobber_set`]: each at-risk parameter is forced
/// non-elidable by [`param_elidable_mask`], so its home cell exists. A
/// mem2reg-promoted parameter is at risk too -- the earlier
/// non-elidable-only gate left such a promoted parameter reading a
/// clobbered argument register.
fn compute_param_from_home(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    param_home_clobber_set(func, alloc, abi)
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

/// Scratch XMM registers for FP handlers. The SSA allocator's
/// caller_fprs pool covers `xmm0..xmm7` and callee_fprs is empty
/// on SysV (no callee-saved xmm), so any allocator-held FP value
/// lives in xmm0..xmm7. xmm14 / xmm15 sit outside both banks and
/// stay free as primary / secondary scratches.
const SCRATCH_XMM14: Reg = Reg(14);
const SCRATCH_XMM15: Reg = Reg(15);
/// Third FP scratch for the three-input fused multiply-add, holding a
/// spilled accumulator. xmm13 is outside the allocator's xmm0..xmm7
/// pool, like xmm14 / xmm15.
const SCRATCH_XMM13: Reg = Reg(13);

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

/// Map an FP arithmetic [`BinOp`] to its scalar SSE encoder. `is_f32`
/// selects the single-precision (`addss` / ...) vs double-precision
/// (`addsd` / ...) form per C99 6.3.1.8. Returns `None` for any
/// non-FP-arith op.
fn fp_arith_enc_for(op: BinOp, is_f32: bool) -> Option<fn(&mut Vec<u8>, Reg, Reg)> {
    Some(if is_f32 {
        match op {
            BinOp::Fadd => emit_addss,
            BinOp::Fsub => emit_subss,
            BinOp::Fmul => emit_mulss,
            BinOp::Fdiv => emit_divss,
            _ => return None,
        }
    } else {
        match op {
            BinOp::Fadd => emit_addsd,
            BinOp::Fsub => emit_subsd,
            BinOp::Fmul => emit_mulsd,
            BinOp::Fdiv => emit_divsd,
            _ => return None,
        }
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
/// op.
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

/// Resolve a set of register-to-register copies `(src, tgt)` so
/// no copy writes to a register still needed as the source of
/// another pending copy. Mirrors the AArch64 emit's scheduler:
/// drain leaves (target not a source of any other pending move)
/// first, then break cycles by routing one source through
/// `scratch`. The caller must pass a `scratch` whose register
/// lives outside the allocator's bank.
/// Emit the predecessor-exit moves for each `Inst::Phi` at the head
/// of every CFG successor of `self_block`. Mirrors the aarch64
/// helper: IntReg -> IntReg pairs schedule through the parallel-copy
/// helper, which breaks register cycles with `xchg` (no scratch) and
/// routes a spill-touching cycle through `hold`; Spill destinations
/// route through the materialise helper and a store against rsp.
///
/// TODO: extend to FpReg dst / src once a real fixture demands it;
/// the current promotion path admits only int-store slots
/// (`slot_stores_only_int`) so the FP case never arises today.
fn emit_phi_predecessor_moves(
    code: &mut Vec<u8>,
    self_block: super::super::ir::BlockId,
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    use super::super::ir::Terminator;
    let succs: Vec<super::super::ir::BlockId> = match func.blocks[self_block as usize].terminator {
        Terminator::Jmp(t) | Terminator::FallThrough(t) => alloc::vec![t],
        Terminator::Bz {
            target,
            fall_through,
            ..
        }
        | Terminator::Bnz {
            target,
            fall_through,
            ..
        } => alloc::vec![target, fall_through],
        Terminator::GotoIndirect { .. } => func.computed_goto_targets.clone(),
        Terminator::Return(_) | Terminator::TailExt(_) => alloc::vec![],
    };
    for succ in succs {
        let head = func.blocks[succ as usize].inst_range.start;
        let end = func.blocks[succ as usize].inst_range.end;
        // Collect every phi's predecessor-exit move as one
        // location-to-location parallel copy. A register reg-to-reg
        // move can overwrite a register that a pending spill store
        // still reads as its source, so register and stack-slot
        // operands must be scheduled together rather than in two
        // independent passes.
        let mut moves: Vec<(Place, Place)> = Vec::new();
        let mut fp_moves: Vec<(Place, Place)> = Vec::new();
        for id in head..end {
            let inst = &func.insts[id as usize];
            let super::super::ir::Inst::Phi { incoming, kind } = inst else {
                break;
            };
            let Some((_, src_v)) = incoming.iter().find(|(b, _)| *b == self_block) else {
                continue;
            };
            let dst_place = alloc
                .places
                .get(id as usize)
                .copied()
                .unwrap_or(Place::None);
            let src_place = alloc
                .places
                .get(*src_v as usize)
                .copied()
                .unwrap_or(Place::None);
            // A phi merges one value per predecessor into a single
            // location, so the predecessor-exit move must stay within
            // one register file. An FP phi (kind F32 / F64) has its
            // home and operands FP-classed; its move is scheduled over
            // the FP locations (xmm registers and spill slots). Every
            // other phi is integer-classed and scheduled over the
            // integer locations. The two files do not alias, so the
            // two parallel copies are independent.
            let phi_is_fp = matches!(
                kind,
                super::super::ir::LoadKind::F32 | super::super::ir::LoadKind::F64
            );
            if phi_is_fp {
                match (src_place, dst_place) {
                    (Place::None, _) | (_, Place::None) => {}
                    _ => fp_moves.push((src_place, dst_place)),
                }
            } else {
                match (src_place, dst_place) {
                    (Place::None, _) | (_, Place::None) => {}
                    _ => moves.push((src_place, dst_place)),
                }
            }
        }
        // `hold` carries one cycle source persistently; `stage`
        // carries a spill-to-spill value transiently. r10 / r11 are
        // reserved scratch -- never in the allocator's bank and never
        // an argument register, so they hold no SSA value live across
        // the terminator and cannot collide with any phi move source
        // or destination. Using them directly (rather than searching
        // the caller-saved pool) keeps the copy from bailing in a
        // high-pressure function where every caller-saved register is
        // live across the block exit.
        if !schedule_place_moves(code, &mut moves, frame, SCRATCH_R10, SCRATCH_R11) {
            return false;
        }
        // FP phi edges: xmm14 / xmm15 are reserved scratch outside the
        // allocator's xmm pool, so they hold no live FP value across
        // the terminator.
        schedule_fp_place_moves(code, &mut fp_moves, frame, SCRATCH_XMM15, SCRATCH_XMM14);
    }
    true
}

/// Compare two `Place`s by physical location identity. Distinct
/// `Place` variants never alias; same-variant places alias when their
/// register number or spill slot matches.
fn place_same_loc(a: Place, b: Place) -> bool {
    match (a, b) {
        (Place::IntReg(x), Place::IntReg(y)) => x == y,
        (Place::Spill(x), Place::Spill(y)) => x == y,
        (Place::FpReg(x), Place::FpReg(y)) => x == y,
        _ => false,
    }
}

/// Emit a single resolved location-to-location move. `stage` is a
/// scratch register used only for the spill-to-spill case (load then
/// store); it must lie outside the allocator's bank.
fn emit_place_move(code: &mut Vec<u8>, src: Place, dst: Place, frame: Frame, stage: Reg) {
    match (src, dst) {
        (Place::IntReg(s), Place::IntReg(t)) => emit_mov_rr(code, Reg(t), Reg(s)),
        (Place::IntReg(s), Place::Spill(slot)) => {
            emit_mov_mem_r(code, Reg::RSP, spill_slot_sp_offset(frame, slot), Reg(s));
        }
        (Place::Spill(slot), Place::IntReg(t)) => {
            emit_mov_r_mem(code, Reg(t), Reg::RSP, spill_slot_sp_offset(frame, slot));
        }
        (Place::Spill(ss), Place::Spill(ts)) => {
            emit_mov_r_mem(code, stage, Reg::RSP, spill_slot_sp_offset(frame, ss));
            emit_mov_mem_r(code, Reg::RSP, spill_slot_sp_offset(frame, ts), stage);
        }
        // FP and None locations are filtered by the caller.
        _ => {}
    }
}

/// Sequentialize a parallel copy over physical locations (integer
/// registers and stack spill slots). Leaves -- destinations that are
/// not the source of any other pending move -- are emitted first;
/// when only cycles remain, one cycle source is saved into the
/// persistent `hold` register and every move reading that location is
/// redirected to read `hold`, exposing a new leaf. `hold` and `stage`
/// must lie outside the allocator's bank so they cannot collide with
/// any pending source or destination. Returns false if any operand is
/// an FP or `None` location, which this path does not lower.
fn schedule_place_moves(
    code: &mut Vec<u8>,
    moves: &mut Vec<(Place, Place)>,
    frame: Frame,
    hold: Reg,
    stage: Reg,
) -> bool {
    moves.retain(|(s, t)| !place_same_loc(*s, *t));
    if moves.iter().any(|(s, t)| {
        matches!(s, Place::FpReg(_) | Place::None) || matches!(t, Place::FpReg(_) | Place::None)
    }) {
        return false;
    }
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            let tgt_still_a_source = moves.iter().any(|(os, _)| place_same_loc(*os, t));
            if !tgt_still_a_source {
                emit_place_move(code, s, t, frame, stage);
                moves.swap_remove(i);
                progress = true;
            } else {
                i += 1;
            }
        }
        if !progress {
            // Only cycle members remain. Break a register-register edge
            // with `xchg` (no scratch, and not locked for register
            // operands): exchanging the two endpoints satisfies that move
            // -- the target ends up holding the source's value -- and
            // leaves the source holding the target's old value for the
            // move that reads it. An edge touching a spill slot has no
            // register swap, so route one such source through `hold`
            // instead. A single cycle drains before the next break, so
            // one persistent `hold` suffices.
            if let Some(i) = moves
                .iter()
                .position(|(s, t)| matches!(s, Place::IntReg(_)) && matches!(t, Place::IntReg(_)))
            {
                let (s, t) = moves[i];
                let (Place::IntReg(sr), Place::IntReg(tr)) = (s, t) else {
                    unreachable!()
                };
                emit_xchg_rr(code, Reg(sr), Reg(tr));
                moves.swap_remove(i);
                for m in moves.iter_mut() {
                    if place_same_loc(m.0, t) {
                        m.0 = s;
                    }
                }
                moves.retain(|(s, t)| !place_same_loc(*s, *t));
            } else {
                // Copy the cycle source into `hold` (a spill reload).
                // `materialize_int` is unsuitable: for an `IntReg` source
                // it returns the register without emitting, leaving `hold`
                // unloaded.
                let cyc = moves
                    .iter()
                    .map(|(s, _)| *s)
                    .find(|s| !place_same_loc(*s, Place::IntReg(hold.0)))
                    .unwrap_or(moves[0].0);
                emit_place_move(code, cyc, Place::IntReg(hold.0), frame, stage);
                for m in moves.iter_mut() {
                    if place_same_loc(m.0, cyc) {
                        m.0 = Place::IntReg(hold.0);
                    }
                }
            }
        }
    }
    true
}

/// Sequentialize a parallel copy over xmm registers. Mirrors
/// [`schedule_int_reg_moves`] with `movapd` for the register copies:
/// drain leaves (a target that is not the source of any other
/// pending move) first; break a residual cycle by routing one cycle
/// source through `scratch`. `scratch` must lie outside the
/// allocator's xmm pool so it collides with no pending source or
/// target.
fn schedule_xmm_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch: Reg) {
    moves.retain(|(s, t)| s != t);
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            let tgt_still_a_source = moves.iter().any(|(other_s, _)| *other_s == t);
            if !tgt_still_a_source {
                emit_movapd_xmm_xmm(code, Reg(t), Reg(s));
                moves.swap_remove(i);
                progress = true;
            } else {
                i += 1;
            }
        }
        if !progress {
            let cycle_src = moves
                .iter()
                .map(|(s, _)| *s)
                .find(|&s| s != scratch.0)
                .unwrap_or(moves[0].0);
            emit_movapd_xmm_xmm(code, scratch, Reg(cycle_src));
            for m in moves.iter_mut() {
                if m.0 == cycle_src {
                    m.0 = scratch.0;
                }
            }
        }
    }
}

/// Emit a single resolved FP location-to-location move over `FpReg`
/// and `Spill` places. `stage` is the scratch xmm for the
/// spill-to-spill case (load then store); it must lie outside the
/// allocator's xmm pool. `IntReg` and `None` places never reach here
/// (an FP phi's home and its operands are FP-classed).
fn emit_fp_place_move(code: &mut Vec<u8>, src: Place, dst: Place, frame: Frame, stage: Reg) {
    match (src, dst) {
        (Place::FpReg(s), Place::FpReg(t)) => emit_movapd_xmm_xmm(code, Reg(t), Reg(s)),
        (Place::FpReg(s), Place::Spill(slot)) => {
            emit_movsd_mem_xmm(code, Reg::RSP, spill_slot_sp_offset(frame, slot), Reg(s));
        }
        (Place::Spill(slot), Place::FpReg(t)) => {
            emit_movsd_xmm_mem(code, Reg(t), Reg::RSP, spill_slot_sp_offset(frame, slot));
        }
        (Place::Spill(ss), Place::Spill(ts)) => {
            emit_movsd_xmm_mem(code, stage, Reg::RSP, spill_slot_sp_offset(frame, ss));
            emit_movsd_mem_xmm(code, Reg::RSP, spill_slot_sp_offset(frame, ts), stage);
        }
        // Integer and None locations never reach here: an FP phi edge
        // is FP-classed on both ends.
        _ => {}
    }
}

/// Sequentialize a parallel copy over FP locations (xmm registers and
/// stack spill slots) for FP-classed phi predecessor moves. Mirrors
/// [`schedule_place_moves`] with `movsd` / `movapd`: leaves first,
/// then break a residual cycle by holding one cycle source in `hold`.
/// `hold` and `stage` must lie outside the allocator's xmm pool so
/// they collide with no pending source or destination.
fn schedule_fp_place_moves(
    code: &mut Vec<u8>,
    moves: &mut Vec<(Place, Place)>,
    frame: Frame,
    hold: Reg,
    stage: Reg,
) {
    moves.retain(|(s, t)| !place_same_loc(*s, *t));
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            let tgt_still_a_source = moves.iter().any(|(os, _)| place_same_loc(*os, t));
            if !tgt_still_a_source {
                emit_fp_place_move(code, s, t, frame, stage);
                moves.swap_remove(i);
                progress = true;
            } else {
                i += 1;
            }
        }
        if !progress {
            // Only cycle members remain. Save one cycle source into
            // the `hold` xmm and redirect every move that reads it.
            let cyc = moves
                .iter()
                .map(|(s, _)| *s)
                .find(|s| !place_same_loc(*s, Place::FpReg(hold.0)))
                .unwrap_or(moves[0].0);
            // Copy the cycle source into `hold` (a register move or a
            // spill reload). `materialize_fp` is unsuitable: for an
            // `FpReg` source it returns the register without emitting,
            // leaving `hold` unloaded.
            emit_fp_place_move(code, cyc, Place::FpReg(hold.0), frame, stage);
            for m in moves.iter_mut() {
                if place_same_loc(m.0, cyc) {
                    m.0 = Place::FpReg(hold.0);
                }
            }
        }
    }
}

fn schedule_int_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>) {
    moves.retain(|(s, t)| s != t);
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            let tgt_still_a_source = moves.iter().any(|(other_s, _)| *other_s == t);
            if !tgt_still_a_source {
                emit_mov_rr(code, Reg(t), Reg(s));
                moves.swap_remove(i);
                progress = true;
            } else {
                i += 1;
            }
        }
        if !progress {
            // Only cycle members remain, all register to register, so
            // break a cycle with `xchg` (no scratch): the exchange
            // satisfies one move -- the target receives the source's
            // value -- and leaves the displaced value in the source for
            // the move that reads it.
            let (s, t) = moves[0];
            emit_xchg_rr(code, Reg(s), Reg(t));
            moves.swap_remove(0);
            for m in moves.iter_mut() {
                if m.0 == t {
                    m.0 = s;
                }
            }
            moves.retain(|(s, t)| s != t);
        }
    }
}

/// Place every argument into its System V / Win64 target slot in
/// an order that survives source / target overlaps. With the
/// allocator's caller-saved bank covering the arg registers
/// (rdi rsi rdx rcx r8 r9 / rcx rdx r8 r9), an argument's value
/// can sit in another argument's target arg register; a naive
/// sequential per-arg `mov target_i, src_i` would clobber a
/// still-needed source. Resolution uses the classical
/// parallel-copy algorithm: drain leaves (target not a source of
/// any other pending move) first; break the residual cycles with
/// an `xchg`. Pass ordering mirrors the AArch64 emit:
///
///   * Stack slots first -- their sources are read into
///     `SCRATCH_R10` and stored to the host-stack overflow
///     region, preserving any source register a later pass
///     touches.
///   * FP arg-register placements next. A value held in an
///     integer register as a raw f64 bit pattern (the constant-
///     folder emits `Inst::Imm` for f64 literals) is moved into
///     the target xmm before the int marshal can overwrite the
///     source.
///   * Integer reg-to-reg moves, scheduled through
///     [`schedule_int_reg_moves`], which breaks cycles with `xchg`
///     and so needs no scratch.
///   * Spill sources for `IntReg` placements then materialise
///     directly into the target arg register
///     (`materialize_int_shifted` writes its load into the dst).
/// Resolve a call's `arg_aggs` indices into the `ArgAgg` vector the
/// struct-aware planner consumes; empty when the call passes no
/// aggregate by value.
fn build_arg_aggs(
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    abi: super::Abi,
) -> Vec<Option<super::ArgAgg>> {
    if arg_aggs.iter().all(Option::is_none) {
        return Vec::new();
    }
    arg_aggs
        .iter()
        .map(|o| {
            o.map(|idx| {
                let d = &agg_descs[idx as usize];
                super::ArgAgg {
                    class: super::abi_classify::classify_aggregate(
                        d.size, d.align, &d.fields, abi, false,
                    ),
                    size: d.size,
                }
            })
        })
        .collect()
}

fn marshal_args(
    code: &mut Vec<u8>,
    plan: &super::CallPlan,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    site: &str,
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
            let src =
                match materialize_int_shifted(code, ap, SCRATCH_R10, frame, plan.scratch_bytes) {
                    Some(s) => s,
                    None => {
                        bail_msg(&alloc::format!("{site}: stack arg not in int reg / spill"));
                        return false;
                    }
                };
            emit_mov_mem_r(code, Reg::RSP, off as i32, src);
        }
    }

    // Aggregate arguments passed on the outgoing stack (System V AMD64
    // MEMORY class, > 16 bytes): copy the struct inline to [rsp + off].
    // The destination is memory and never serves as a move source, but
    // the struct's base address sits in an argument register that the
    // register-move phase below overwrites, so this copy runs first
    // while the base is still live (mirroring the scalar Stack arm).
    // The address rides SCRATCH_R10, the per-word temp SCRATCH_R11;
    // both lie outside the allocator pools.
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::StructStack { off, size } = placement {
            let src = match materialize_int_shifted(
                code,
                arg_place(i),
                SCRATCH_R10,
                frame,
                plan.scratch_bytes,
            ) {
                Some(s) => s,
                None => {
                    bail_msg(&alloc::format!(
                        "{site}: by-stack aggregate base not in int reg / spill"
                    ));
                    return false;
                }
            };
            if src.0 != SCRATCH_R10.0 {
                emit_mov_rr(code, SCRATCH_R10, src);
            }
            let words = size / 8;
            for w in 0..words {
                let o = (w * 8) as i32;
                emit_mov_r_mem(code, SCRATCH_R11, SCRATCH_R10, o);
                emit_mov_mem_r(code, Reg::RSP, off as i32 + o, SCRATCH_R11);
            }
            for b in (words * 8)..size {
                let o = b as i32;
                super::x86_64::emit_movzx_r_mem8(code, SCRATCH_R11, SCRATCH_R10, o);
                super::x86_64::emit_mov_mem8_r(code, Reg::RSP, off as i32 + o, SCRATCH_R11);
            }
        }
    }

    // FP arguments. A value already held in an xmm register may sit
    // in another FP argument's target xmm, so the xmm-to-xmm moves
    // form a parallel copy that a naive sequential emit would clobber
    // (System V passes successive FP args in xmm0, xmm1, ...).
    // Schedule the register-to-register moves first so every xmm
    // argument source is consumed before any Spill / IntReg source
    // materialises into its target xmm -- otherwise a Spill load into
    // xmmN would overwrite a value another argument still reads from
    // xmmN. SCRATCH_XMM15 breaks any cycle and lies outside the
    // allocator's xmm pool.
    let mut fp_moves: Vec<(u8, u8)> = Vec::new();
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::FpReg(r) = placement
            && let Place::FpReg(s) = arg_place(i)
            && s != r
        {
            fp_moves.push((s, r));
        }
    }
    schedule_xmm_reg_moves(code, &mut fp_moves, SCRATCH_XMM15);
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::FpReg(r) = placement {
            match arg_place(i) {
                // Register-to-register moves were scheduled above.
                Place::FpReg(_) => {}
                ap @ (Place::Spill(_) | Place::IntReg(_)) => {
                    let src =
                        match materialize_fp_shifted(code, ap, Reg(r), frame, plan.scratch_bytes) {
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
                }
                Place::None => {
                    bail_msg(&alloc::format!(
                        "{site}: fp arg not in fp reg / spill / int reg"
                    ));
                    return false;
                }
            }
        }
    }

    // System V FP-eightbyte aggregate arguments: any aggregate containing
    // an SSE eightbyte. regs[0] may be an xmm, so the regs[0]-as-base scheme
    // below cannot apply -- materialize the source address into a scratch
    // GPR and load each eightbyte into its register (movsd for SSE, mov for
    // INTEGER). Runs after the scalar-FP moves (their xmm sources consumed)
    // and before the integer marshal (the source address, in a GPR, not yet
    // overwritten); the eightbytes are memory loads, joining no xmm cycle.
    for (i, &placement) in plan.placements.iter().enumerate() {
        let super::ArgPlacement::StructRegs { regs, n } = placement else {
            continue;
        };
        if n == 0 || !regs.iter().take(n as usize).any(|c| c.is_fp) {
            continue;
        }
        let base = match materialize_int_shifted(
            code,
            arg_place(i),
            SCRATCH_R10,
            frame,
            plan.scratch_bytes,
        ) {
            Some(s) => s,
            None => {
                bail_msg(&alloc::format!(
                    "{site}: fp aggregate base not in int reg / spill"
                ));
                return false;
            }
        };
        // The source address must not share a register with an INTEGER
        // eightbyte's destination (an argument GPR): loading that eightbyte
        // would clobber the base before a later SSE eightbyte loads from it.
        // materialize_int_shifted may return the value's existing register
        // (an argument GPR), so stage it in SCRATCH_R10, never an argument
        // or aggregate destination.
        if base.0 != SCRATCH_R10.0 {
            emit_mov_rr(code, SCRATCH_R10, base);
        }
        let base = SCRATCH_R10;
        for (k, cr) in regs.iter().take(n as usize).enumerate() {
            let off = (k as i32) * 8;
            if cr.is_fp {
                emit_movsd_xmm_mem(code, Reg(cr.reg), base, off);
            } else {
                emit_mov_r_mem(code, Reg(cr.reg), base, off);
            }
        }
    }

    // Integer-register placements plus aggregate base addresses are one
    // parallel register move (System V AMD64 3.2.3). A scalar `IntReg`
    // arg moves src->target; a `StructRegs` arg positions its base
    // address into its own first eightbyte register `regs[0]`, from
    // which the eightbytes load below (the base register is overwritten
    // by its own eightbyte last). Routing the base through that per-
    // aggregate register -- never a shared scratch -- keeps one
    // aggregate's load from clobbering another's still-pending base.
    let mut int_moves: Vec<(u8, u8)> = Vec::new();
    for (i, &placement) in plan.placements.iter().enumerate() {
        match placement {
            super::ArgPlacement::IntReg(r) => {
                if let Place::IntReg(s) = arg_place(i)
                    && s != r
                {
                    int_moves.push((s, r));
                }
            }
            // FP-eightbyte aggregates (an SSE unit) loaded above.
            super::ArgPlacement::StructRegs { regs, n }
                if n > 0 && !regs.iter().take(n as usize).any(|c| c.is_fp) =>
            {
                let dst = regs[0].reg;
                if let Place::IntReg(s) = arg_place(i)
                    && s != dst
                {
                    int_moves.push((s, dst));
                }
            }
            _ => {}
        }
    }
    schedule_int_reg_moves(code, &mut int_moves);

    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::IntReg(r) = placement {
            let ap = arg_place(i);
            match ap {
                Place::IntReg(_) => {}
                Place::Spill(_) | Place::None => {
                    let src = match materialize_int_shifted(
                        code,
                        ap,
                        Reg(r),
                        frame,
                        plan.scratch_bytes,
                    ) {
                        Some(s) => s,
                        None => {
                            bail_msg(&alloc::format!("{site}: int arg not in int reg / spill"));
                            return false;
                        }
                    };
                    if src.0 != r {
                        emit_mov_rr(code, Reg(r), src);
                    }
                }
                Place::FpReg(s) => {
                    // Win64 mirrors variadic FP args into both the
                    // matching xmm register and the integer slot
                    // (rcx / rdx / r8 / r9), so the call-arg plan
                    // can name the integer placement with the value
                    // sitting in xmm.
                    super::x86_64::emit_movq_r_xmm(code, Reg(r), Reg(s));
                }
            }
        }
    }

    // Aggregate bases not already register-resident (spill / computed)
    // materialise into the aggregate's first eightbyte register, the
    // same destination the move loop used for the register-resident
    // case.
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::StructRegs { regs, n } = placement
            && n > 0
            && !regs.iter().take(n as usize).any(|c| c.is_fp)
            && !matches!(arg_place(i), Place::IntReg(_))
        {
            let dst = regs[0].reg;
            let src = match materialize_int_shifted(
                code,
                arg_place(i),
                Reg(dst),
                frame,
                plan.scratch_bytes,
            ) {
                Some(s) => s,
                None => {
                    bail_msg(&alloc::format!(
                        "{site}: aggregate base not in int reg / spill"
                    ));
                    return false;
                }
            };
            if src.0 != dst {
                emit_mov_rr(code, Reg(dst), src);
            }
        }
    }

    // Load each aggregate's eightbytes from the base now in `regs[0]`.
    // High eightbytes first; `regs[0]` (the base) is read last,
    // overwritten by its own eightbyte. Integer-only (homogeneous
    // floating-point aggregates excluded upstream).
    for &placement in plan.placements.iter() {
        // Integer-class aggregate: load eightbytes from the base in regs[0].
        // FP-eightbyte aggregates (an SSE unit) were loaded above.
        if let super::ArgPlacement::StructRegs { regs, n } = placement
            && !regs.iter().take(n as usize).any(|c| c.is_fp)
        {
            let base = regs[0].reg;
            for k in (1..n as usize).rev() {
                emit_mov_r_mem(code, Reg(regs[k].reg), Reg(base), (k as i32) * 8);
            }
            emit_mov_r_mem(code, Reg(base), Reg(base), 0);
        }
    }

    true
}

/// Public entry point. Returns `true` when every block + inst +
/// terminator was lowered. Returns `false` (with `code`
/// truncated back to the pre-attempt snapshot) when the function
/// contains an op outside the implemented subset. The handler
/// set is intentionally minimal at this stage; the aarch64 SSA
/// emit grew bottom-up from the same shape and the x86_64 path
/// follows that trajectory.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    code: &mut Vec<u8>,
    fixups: &mut Vec<Fixup>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    _got_fixups: &mut Vec<GotFixup>,
    data_fixups: &mut Vec<DataFixup>,
    user_extern_data_refs: &mut Vec<super::UserExternDataRef>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_tls_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    elf_tpoff_fixups: &mut Vec<super::ElfTpoffFixup>,
    tls_total_size: usize,
    pc_to_native: &mut [usize],
    prologue_native: &mut alloc::collections::BTreeMap<usize, usize>,
    ssa_line_rows: &mut Vec<(usize, u32, u32)>,
    fn_unwind: &mut Vec<super::FnUnwind>,
) -> bool {
    let snapshot = code.len();
    let fixups_snapshot = fixups.len();
    let plt_call_fixups_snapshot = plt_call_fixups.len();
    let data_fixups_snapshot = data_fixups.len();
    let user_extern_data_refs_snapshot = user_extern_data_refs.len();
    // A cross-unit `extern _Thread_local` access (`extern_tls_names` maps
    // the access value-id to the referenced symbol) and a same-unit one
    // both record an `ElfTpoffFixup` the linker resolves against the
    // merged TLS layout; see `emit_tls_addr`.
    let elf_tpoff_snapshot = elf_tpoff_fixups.len();
    let pending_func_fixups_snapshot = pending_func_fixups.len();
    let abi = target.abi();
    let frame = Frame::for_function(func, alloc, abi);

    // A per-inst `Inst::ParamRef` materialises its parameter from the
    // incoming host argument register. The allocator can pack several
    // sequentially-live parameters into one register, each consumed by
    // an intervening store before the next is produced, and the
    // destination register it picks for an earlier parameter may be a
    // later parameter's incoming argument register. The earlier
    // `ParamRef`'s write then overwrites that argument value before the
    // later `ParamRef` reads it. A non-elidable register parameter is
    // spilled by the prologue to its c5 cdecl home cell, which survives
    // the clobber; `param_from_home[i]` marks the parameters that must
    // read their home cell rather than the argument register. The flag
    // is set only for the parameters actually at risk -- a non-elidable
    // parameter whose argument register is the destination of an
    // earlier-emitted `ParamRef` -- so the common case stays a
    // register-to-register move.
    let param_from_home = compute_param_from_home(func, alloc, abi);
    // Per-parameter incoming-register plan; consumed by the per-inst
    // `Inst::ParamRef` lowering to source each FP parameter from its
    // xmm argument register.
    let param_plan = param_placements(func, abi);

    let mut uw = emit_prologue(code, func, alloc, frame, abi, snapshot);
    uw.begin = snapshot as u32;
    super::ssa_emit_common::record_post_prologue_pc(func, prologue_native, code.len());

    // Place the entry `Inst::ParamRef` values from their host argument
    // registers into the allocator's chosen locations. Emitting each
    // ParamRef independently in instruction order is unsound when one
    // parameter's destination register is a later parameter's source
    // argument register: the naive `mov dst, arg_reg` clobbers that
    // source before it is read (the allocator can swap two pointer
    // parameters between, say, rsi and rcx).
    //
    // The placement is a parallel copy from the (distinct) argument
    // registers to the parameter homes precisely when those homes are
    // distinct -- then `schedule_place_moves` sequentializes it and
    // breaks any cycle through a scratch register. When two ParamRef
    // values share a home (sequentially-live parameters the allocator
    // packed into one register) the move set is not a permutation, so
    // the batch is skipped and each ParamRef is placed in program order.
    // That per-inst path is safe only while no parameter's home is a
    // later parameter's incoming register; the allocator's ParamRef
    // self-home hint keeps it so. The `param-shuffle-clobber` check in
    // `verify_allocation` guards the invariant under `codegen_test`.
    let mut param_prebatched: Vec<bool> = alloc::vec![false; func.insts.len()];
    {
        // Each integer parameter's incoming register comes from the
        // plan, not `int_arg_regs[i]`: a floating-point parameter
        // earlier in the list consumes an FP register and does not
        // shift the integer bank, so the i-th declared parameter is not
        // the i-th integer register.
        let param_plan = param_placements(func, abi);
        let mut moves: Vec<(Place, Place)> = Vec::new();
        let mut exts: Vec<(Place, LoadKind)> = Vec::new();
        let mut vids: Vec<usize> = Vec::new();
        let mut homes: Vec<Place> = Vec::new();
        for (vid, inst) in func.insts.iter().enumerate() {
            let Inst::ParamRef { idx, kind } = inst else {
                continue;
            };
            let i = *idx as usize;
            // A ParamRef with no consumers is dropped by the per-inst
            // dead-code skip; placing it here would only risk bailing
            // the batch on an unused FP parameter. Only integer / spill
            // homes are scheduled as a parallel copy; an FP-register
            // home (a floating-point parameter) stays on the per-inst
            // path.
            if super::ssa_emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc) {
                continue;
            }
            let dst = alloc.places.get(vid).copied().unwrap_or(Place::None);
            if !matches!(dst, Place::IntReg(_) | Place::Spill(_)) {
                continue;
            }
            // An integer-dst ParamRef is always an integer parameter
            // (an FP scalar is FP-classed and never lands in an int
            // register). Read its source integer register from the
            // plan; a stack-passed integer parameter has no register
            // source and stays on the per-inst home-cell path.
            let Some(super::ArgPlacement::IntReg(src)) = param_plan.get(i).copied() else {
                continue;
            };
            moves.push((Place::IntReg(src), dst));
            vids.push(vid);
            homes.push(dst);
            // Sign-extend on entry only when a consumer reads the
            // parameter's upper bits; otherwise the low word already
            // holds the C99 6.5.2.2p4-converted value.
            if matches!(kind, LoadKind::I8 | LoadKind::I16 | LoadKind::I32)
                && alloc.high_observed.get(vid).copied().unwrap_or(true)
            {
                exts.push((dst, *kind));
            }
        }
        let homes_distinct = (0..homes.len())
            .all(|a| ((a + 1)..homes.len()).all(|b| !place_same_loc(homes[a], homes[b])));
        if !moves.is_empty() && homes_distinct {
            // r10 / r11 are reserved scratch (never an argument register
            // and never in the allocator's bank), so they cannot collide
            // with any pending parameter source or destination.
            if !schedule_place_moves(code, &mut moves, frame, SCRATCH_R10, SCRATCH_R11) {
                return false;
            }
            for (dst, kind) in exts {
                let ext = |code: &mut Vec<u8>, r: Reg| match kind {
                    LoadKind::I8 => super::x86_64::emit_movsx_r_r8(code, r, r),
                    LoadKind::I16 => super::x86_64::emit_movsx_r_r16(code, r, r),
                    LoadKind::I32 => super::x86_64::emit_movsxd_r_r(code, r, r),
                    _ => {}
                };
                match dst {
                    Place::IntReg(r) => ext(code, Reg(r)),
                    Place::Spill(slot) => {
                        let sp_off = spill_slot_sp_offset(frame, slot);
                        emit_mov_r_mem(code, SCRATCH_R10, Reg::RSP, sp_off);
                        ext(code, SCRATCH_R10);
                        emit_mov_mem_r(code, Reg::RSP, sp_off, SCRATCH_R10);
                    }
                    Place::None | Place::FpReg(_) => {}
                }
            }
            for vid in vids {
                param_prebatched[vid] = true;
            }
        }
    }

    let mut block_offsets: Vec<usize> = alloc::vec![0; func.blocks.len()];
    let mut branch_fixups: Vec<BranchFixup> = Vec::new();
    // GCC `&&label`: each `Inst::BlockAddr` emits a `lea rd, [rip+disp32]`
    // placeholder; `(lea_start, target_block)` is resolved against the
    // final `block_offsets` after the relaxation passes settle (only the
    // disp32 is patched, so the destination register need not be saved).
    let mut block_addr_fixups: Vec<(usize, u32)> = Vec::new();
    // Branch relaxation. The block loop runs once with every local
    // branch in the rel32 long form (`branch_short` empty), then, when
    // `relax_branches` finds shortenable branches, once more with the
    // rel8 form for those branches. The second pass re-records every
    // code-offset metadatum (relocations, line rows, pc map) against
    // the shortened layout, so no recorded offset needs remapping. The
    // snapshots mark the buffers' lengths after the prologue, where the
    // re-emitted body begins.
    let mut branch_short: Vec<bool> = Vec::new();
    let body_code = code.len();
    let body_fixups = fixups.len();
    let body_plt = plt_call_fixups.len();
    let body_data = data_fixups.len();
    let body_uext = user_extern_data_refs.len();
    let body_pending = pending_func_fixups.len();
    let body_tls = tls_index_fixups.len();
    let body_elf_tpoff = elf_tpoff_fixups.len();
    let body_line_rows = ssa_line_rows.len();

    'emit: loop {
        // Set by `Inst::AllocaInit` (slot != 0) and read by the
        // matching `Inst::Intrinsic(Alloca)`. Zero means the
        // function doesn't use alloca.
        let mut current_alloca_top: u32 = 0;
        // Re-collected each relaxation pass; resolved after the loop.
        block_addr_fixups.clear();

        for (block_idx, block) in func.blocks.iter().enumerate() {
            block_offsets[block_idx] = code.len();
            super::ssa_emit_common::record_block_start_pc(
                block_idx,
                block.start_pc,
                pc_to_native,
                code.len(),
            );
            // Tail-call opportunity: when the block's last instruction is
            // a direct `Inst::Call` whose result is the same block's
            // `Terminator::Return` value, lower the call as `marshal_args;
            // epilogue; jmp target` instead of `call target; capture;
            // epilogue; ret`. Saves one call+ret pair per recursion level
            // and removes the post-call rax-to-place mov. See
            // `detect_tail_call` for the safety preconditions.
            let tail_call = detect_tail_call(func, block, abi, variadic_targets);
            for v in block.inst_range.clone() {
                let inst = &func.insts[v as usize];
                let place = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
                if super::ssa_emit_common::is_dead_pure(inst, v, alloc) {
                    continue;
                }
                // ParamRef already placed by the entry parallel copy.
                if param_prebatched[v as usize] {
                    continue;
                }
                // The tail-call Call's args setup is folded into the
                // terminator emit; skip the per-inst emit so we don't
                // emit the `call` instruction and the post-call capture.
                if let Some((tail_pc, _, _)) = tail_call
                    && (v as usize) == tail_pc
                {
                    continue;
                }
                super::ssa_emit_common::record_inst_src(func, v, code.len(), ssa_line_rows);
                // GCC `&&label`: materialize the block's address with a
                // PC-relative lea. Handled here (not emit_inst) because the
                // disp32 resolves against this function's local
                // block_offsets once every block is laid out -- walker IR
                // leaves block.start_pc at 0, so the writer's pc_to_native
                // path can't be used.
                if let Inst::BlockAddr(tb) = inst {
                    let Some(rd) = int_or_spill_dst(place) else {
                        bail_msg("BlockAddr: dst not int reg / spill");
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                        return false;
                    };
                    let lea_start = code.len();
                    super::x86_64::emit_lea_r_rip32(code, rd, 0);
                    block_addr_fixups.push((lea_start, *tb));
                    spill_dst_to_slot(code, place, rd, frame);
                    continue;
                }
                let data_fixups_pre_inst = data_fixups.len();
                if !emit_inst(
                    code,
                    inst,
                    v,
                    place,
                    func,
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
                    elf_tpoff_fixups,
                    extern_tls_names,
                    tls_total_size,
                    &mut current_alloca_top,
                    &param_from_home,
                    &param_plan,
                ) {
                    #[cfg(feature = "codegen_test")]
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
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    return false;
                }
                // Convert the just-emitted ImmData's local `.data`
                // fixup into a named cross-TU reference when the
                // value-id appears in `extern_data_names`. See the
                // matching comment in ssa_emit_aarch64.
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
            // Predecessor-exit moves for any phi at every CFG
            // successor's head. A Return / TailExt block has no
            // successor; the helper is a no-op there.
            if !emit_phi_predecessor_moves(
                code,
                block_idx as super::super::ir::BlockId,
                func,
                alloc,
                frame,
            ) {
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                return false;
            }
            match block.terminator {
                Terminator::Return(v) => {
                    if let Some((tail_pc, target_pc, args)) = tail_call {
                        let fp_arg_mask = match &func.insts[tail_pc] {
                            Inst::Call { fp_arg_mask, .. } => *fp_arg_mask,
                            _ => 0,
                        };
                        if !emit_tail_call(
                            code,
                            target_pc,
                            args,
                            alloc,
                            frame,
                            abi,
                            fixups,
                            func,
                            fp_arg_mask,
                        ) {
                            code.truncate(snapshot);
                            fixups.truncate(fixups_snapshot);
                            plt_call_fixups.truncate(plt_call_fixups_snapshot);
                            data_fixups.truncate(data_fixups_snapshot);
                            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                            pending_func_fixups.truncate(pending_func_fixups_snapshot);
                            return false;
                        }
                    } else {
                        emit_return(code, v, alloc, frame, func, abi)
                    }
                }
                Terminator::Jmp(t) => {
                    // Fall through when the target is the next block in
                    // layout rather than emitting a jump to it.
                    if t as usize != block_idx + 1 {
                        emit_local_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            LocalBranchKind::Jmp,
                            t,
                        );
                    }
                }
                Terminator::Bz {
                    cond,
                    target,
                    fall_through,
                } => {
                    if let Some(cc) = fused_branch_cc(func, alloc, cond, /* negate */ true) {
                        emit_local_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            LocalBranchKind::Jcc(cc),
                            target,
                        );
                        if fall_through as usize != block_idx + 1 {
                            emit_local_branch(
                                code,
                                &mut branch_fixups,
                                &branch_short,
                                LocalBranchKind::Jmp,
                                fall_through,
                            );
                        }
                        continue;
                    }
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
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        return false;
                    };
                    // `test rc, rc` sets ZF=1 iff rc==0; je takes the
                    // branch on ZF=1. Shorter than `cmp rc, 0`.
                    super::x86_64::emit_test_rr(code, rc, rc);
                    emit_local_branch(
                        code,
                        &mut branch_fixups,
                        &branch_short,
                        LocalBranchKind::Jcc(Cc::E),
                        target,
                    );
                    if fall_through as usize != block_idx + 1 {
                        emit_local_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            LocalBranchKind::Jmp,
                            fall_through,
                        );
                    }
                }
                Terminator::Bnz {
                    cond,
                    target,
                    fall_through,
                } => {
                    if let Some(cc) = fused_branch_cc(func, alloc, cond, /* negate */ false) {
                        emit_local_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            LocalBranchKind::Jcc(cc),
                            target,
                        );
                        if fall_through as usize != block_idx + 1 {
                            emit_local_branch(
                                code,
                                &mut branch_fixups,
                                &branch_short,
                                LocalBranchKind::Jmp,
                                fall_through,
                            );
                        }
                        continue;
                    }
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
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        return false;
                    };
                    super::x86_64::emit_test_rr(code, rc, rc);
                    emit_local_branch(
                        code,
                        &mut branch_fixups,
                        &branch_short,
                        LocalBranchKind::Jcc(Cc::Ne),
                        target,
                    );
                    if fall_through as usize != block_idx + 1 {
                        emit_local_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            LocalBranchKind::Jmp,
                            fall_through,
                        );
                    }
                }
                Terminator::FallThrough(t) => {
                    if t as usize != block_idx + 1 {
                        emit_local_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            LocalBranchKind::Jmp,
                            t,
                        );
                    }
                }
                Terminator::GotoIndirect { target } => {
                    // GCC computed goto: branch to the code address in
                    // `target` (materialized by Inst::BlockAddr) via
                    // `jmp r64`.
                    let tplace = alloc
                        .places
                        .get(target as usize)
                        .copied()
                        .unwrap_or(Place::None);
                    let Some(rt) = materialize_int(code, tplace, SCRATCH_R10, frame) else {
                        bail_msg("GotoIndirect: target Place not int reg / spill");
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        return false;
                    };
                    super::x86_64::emit_jmp_r(code, rt);
                }
                Terminator::TailExt(binding_idx) => {
                    // The parser emits `Terminator::TailExt` for the
                    // sys-trampoline bodies: the matching indirect
                    // call already placed every arg in the host ABI's
                    // argument registers / shadow-space slots, so the
                    // emit just forwards control through the PLT
                    // trampoline and lets the libc fn's `ret` carry
                    // us back to the original caller.
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
                            return false;
                        }
                    };
                    plt_call_fixups.push(PltCallFixup {
                        instr_offset: code.len(),
                        import_index,
                        is_tail: true,
                        is_addr: false,
                    });
                    super::x86_64::emit_jmp_rel32(code, 0);
                }
            }
        }

        // First pass emitted every branch long; decide which can shrink and,
        // if any, reset the body-appended buffers and re-emit. A pass that
        // finds nothing to shorten produces the final layout.
        if branch_short.is_empty() {
            let branches: Vec<(usize, usize, usize)> = branch_fixups
                .iter()
                .map(|fx| {
                    let (opcode_start, long_size) = match fx.kind {
                        LocalBranchKind::Jmp => (fx.site - 1, 5),
                        LocalBranchKind::Jcc(_) => (fx.site - 2, 6),
                    };
                    (opcode_start, long_size, fx.target as usize)
                })
                .collect();
            branch_short = relax_branches(&branches, &block_offsets);
            if branch_short.iter().any(|&s| s) {
                // pc_to_native is index-keyed and overwritten in place by
                // the second pass, so it needs no reset.
                code.truncate(body_code);
                fixups.truncate(body_fixups);
                plt_call_fixups.truncate(body_plt);
                data_fixups.truncate(body_data);
                user_extern_data_refs.truncate(body_uext);
                pending_func_fixups.truncate(body_pending);
                tls_index_fixups.truncate(body_tls);
                elf_tpoff_fixups.truncate(body_elf_tpoff);
                ssa_line_rows.truncate(body_line_rows);
                for b in block_offsets.iter_mut() {
                    *b = 0;
                }
                branch_fixups.clear();
                continue 'emit;
            }
        }
        break 'emit;
    }

    // Patch each `&&label` lea against its block's final offset. The
    // disp32 sits 3 bytes into the 7-byte lea and is measured from the
    // byte after the instruction (`lea_start + LEA_RIP32_LEN`).
    for (lea_start, target_block) in &block_addr_fixups {
        let target_off = block_offsets[*target_block as usize] as i64;
        let rel = target_off - (*lea_start as i64 + super::x86_64::LEA_RIP32_LEN as i64);
        let imm = match i32::try_from(rel) {
            Ok(v) => v,
            Err(_) => {
                bail_msg("BlockAddr: lea disp32 out of range");
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                return false;
            }
        };
        code[*lea_start + 3..*lea_start + 7].copy_from_slice(&imm.to_le_bytes());
    }

    // Patch recorded branches. The displacement is measured from the
    // byte after the displacement field: `site + 1` for the rel8 short
    // form, `site + 4` for rel32. `relax_branches` guarantees a short
    // branch's target is within the signed 8-bit range.
    for fx in &branch_fixups {
        let target_off = block_offsets[fx.target as usize];
        if fx.short {
            let rel = (target_off as i64) - (fx.site as i64 + 1);
            let imm = match i8::try_from(rel) {
                Ok(v) => v,
                Err(_) => {
                    bail_msg("branch fixup: rel8 out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    return false;
                }
            };
            code[fx.site] = imm as u8;
        } else {
            let rel = (target_off as i64) - (fx.site as i64 + 4);
            let imm = match i32::try_from(rel) {
                Ok(v) => v,
                Err(_) => {
                    bail_msg("branch fixup: rel32 out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    return false;
                }
            };
            code[fx.site..fx.site + 4].copy_from_slice(&imm.to_le_bytes());
        }
    }

    // The function emitted end-to-end. Record its [begin, end) extent
    // for the PE writer's per-function unwind table now that no bail
    // can truncate `code`.
    uw.end = code.len() as u32;
    fn_unwind.push(uw);
    true
}

#[derive(Debug, Clone, Copy)]
struct BranchFixup {
    /// Byte offset of the displacement field in `code` (rel8 for a
    /// short branch, rel32 otherwise).
    site: usize,
    target: super::super::ir::BlockId,
    kind: LocalBranchKind,
    /// `true` when the branch was emitted in the 2-byte rel8 form.
    short: bool,
}

/// Emit a local branch to `target`, choosing the 2-byte rel8 short form
/// when `branch_short[idx]` is set (idx = this branch's emission index),
/// and record the fixup. `branch_short` is empty on the first all-long
/// emission pass and is populated by `relax_branches` for the second.
fn emit_local_branch(
    code: &mut alloc::vec::Vec<u8>,
    branch_fixups: &mut alloc::vec::Vec<BranchFixup>,
    branch_short: &[bool],
    kind: LocalBranchKind,
    target: super::super::ir::BlockId,
) {
    let idx = branch_fixups.len();
    let short = branch_short.get(idx).copied().unwrap_or(false);
    match kind {
        LocalBranchKind::Jmp => {
            // EB cb (rel8) / E9 cd (rel32): displacement follows the
            // 1-byte opcode in both forms.
            branch_fixups.push(BranchFixup {
                site: code.len() + 1,
                target,
                kind,
                short,
            });
            if short {
                super::x86_64::emit_jmp_rel8(code, 0);
            } else {
                super::x86_64::emit_jmp_rel32(code, 0);
            }
        }
        LocalBranchKind::Jcc(cc) => {
            // 7x cb (rel8): displacement at +1. 0F 8x cd (rel32): at +2.
            let site = if short {
                code.len() + 1
            } else {
                code.len() + 2
            };
            branch_fixups.push(BranchFixup {
                site,
                target,
                kind,
                short,
            });
            if short {
                super::x86_64::emit_jcc_rel8(code, cc, 0);
            } else {
                super::x86_64::emit_jcc_rel32(code, cc, 0);
            }
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum LocalBranchKind {
    Jmp,
    Jcc(Cc),
}

/// Decide, per local branch, whether its target is close enough to use
/// the 2-byte rel8 encoding (`EB`/`7x`) instead of the 5/6-byte rel32
/// form (`E9`/`0F 8x`).
///
/// Each entry of `branches` is `(opcode_start, long_size, target_block)`
/// in emission order, where `opcode_start` is the all-long byte offset
/// of the instruction's first byte, `long_size` is 5 (jmp) or 6 (jcc),
/// and `block_offsets` holds each block's all-long byte offset. Both
/// short forms are 2 bytes, so a shortened branch removes
/// `long_size - 2` bytes at its `opcode_start`.
///
/// Shortening one branch only reduces the magnitude of every other
/// branch's displacement, so the shortenable set is a monotone fixpoint:
/// start all-long and repeatedly mark a branch short once its
/// displacement -- recomputed against the bytes already removed by the
/// branches marked short so far -- fits a signed 8-bit field. The check
/// excludes a forward branch's own saving, so the estimate is never
/// optimistic: a branch marked short fits in the final layout.
fn relax_branches(
    branches: &[(usize, usize, usize)],
    block_offsets: &[usize],
) -> alloc::vec::Vec<bool> {
    let n = branches.len();
    let mut short = alloc::vec![false; n];
    loop {
        // prefix[k] = bytes removed by short branches among branches[0..k].
        // `opcode_start` is non-decreasing in emission order, so the bytes
        // removed before an offset are a prefix indexed by partition_point.
        let mut prefix = alloc::vec![0usize; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + if short[i] { branches[i].1 - 2 } else { 0 };
        }
        let saved_before =
            |off: usize| -> usize { prefix[branches.partition_point(|b| b.0 < off)] };
        let mut changed = false;
        for i in 0..n {
            if short[i] {
                continue;
            }
            let (opcode_start, _long, target) = branches[i];
            let instr_end = (opcode_start - saved_before(opcode_start)) + 2;
            let tgt = block_offsets[target] - saved_before(block_offsets[target]);
            let rel = tgt as i64 - instr_end as i64;
            if (-128..=127).contains(&rel) {
                short[i] = true;
                changed = true;
            }
        }
        if !changed {
            break;
        }
    }
    short
}

/// Spill the host-ABI argument registers into the c5 cdecl slots
/// the body references via address-of-local with slot index
/// `N >= 2`. c5 places the
/// first declared parameter at `[rbp + 16]`, the second at
/// `[rbp + 32]`, etc. AMD64 SysV / Win64 push the return address
/// before `call`, so the prologue needs to interleave the saved
/// rbp with the param slots: pop the return address into r11,
/// push each arg in caller order, push the return address back,
/// Lower a `sub rsp, bytes` frame allocation, inserting a page-walk
/// stack probe on Windows when the frame is at least one page.
///
/// The Win64 ABI (and the OS guard-page mechanism) requires the
/// prologue to touch every 4 KiB page it allocates, in descending
/// order, so the kernel's guard page commits the next page before the
/// frame reaches it. A single `sub rsp, bytes` that skips past the
/// guard page faults on the first access into an uncommitted page.
/// System V Linux grows the stack on demand and needs no probe.
///
/// The probe walks one page at a time, writing through `rsp` to fault
/// in (commit) each page, then subtracts the sub-page remainder. r11 is
/// caller-saved and carries no live value in the prologue, so it serves
/// as the running counter.
fn emit_stack_alloc(code: &mut Vec<u8>, bytes: u32, abi: super::Abi) {
    const PAGE: u32 = 4096;
    // SysV (shadow_space 0) and any sub-page Win64 frame allocate with a
    // single `sub rsp`. A guard page sits at most one page below rsp, so
    // a frame smaller than a page cannot skip it.
    if abi.shadow_space == 0 || bytes < PAGE {
        emit_sub_rsp_imm32(code, bytes);
        return;
    }
    // r11 = bytes remaining to allocate.
    super::x86_64::emit_mov_r_imm64(code, Reg::R11, bytes as i64);
    // loop: while r11 >= PAGE { sub rsp, PAGE; touch [rsp]; r11 -= PAGE }
    let loop_start = code.len();
    emit_sub_rsp_imm32(code, PAGE);
    // Touch the freshly-decremented page so the guard-page handler
    // commits it and relocates the guard one page lower.
    super::x86_64::emit_mov_mem_r(code, Reg::RSP, 0, Reg::R11);
    super::x86_64::emit_sub_r_imm32(code, Reg::R11, PAGE as i32);
    super::x86_64::emit_cmp_r_imm32(code, Reg::R11, PAGE as i32);
    // jae loop_start (unsigned: r11 still at least one page).
    let after_cmp = code.len();
    super::x86_64::emit_jcc_rel32(code, super::x86_64::Cc::Ae, 0);
    let rel = (loop_start as i64) - (code.len() as i64);
    let rel32 = rel as i32;
    let patch_at = code.len() - 4;
    code[patch_at..patch_at + 4].copy_from_slice(&rel32.to_le_bytes());
    let _ = after_cmp;
    // Sub-page remainder left in r11.
    emit_sub_rr(code, Reg::RSP, Reg::R11);
}

/// then save rbp and proceed.
///
/// `func_start` is `code.len()` at function entry; the returned
/// [`super::FnUnwind`] records every prologue instruction boundary
/// relative to it so the PE writer can build a Win64 `UNWIND_INFO`
/// for the frame. `begin` / `end` are filled by the caller.
fn emit_prologue(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    func_start: usize,
) -> super::FnUnwind {
    let mut uw = super::FnUnwind {
        param_spill_bytes: frame.param_spill_bytes,
        frame_bytes: frame.frame_bytes,
        ..super::FnUnwind::default()
    };
    let rel = |code: &Vec<u8>| (code.len() - func_start) as u32;
    // Host-arg-reg spill. `frame.param_spill_bytes` is the
    // single source of truth for how many bytes get allocated
    // here; the epilogue reads the same value to undo the same
    // bytes. Variadic callees, fully-Native callees with every
    // parameter `ParamRef`-seeded, and 0-param callees all
    // produce 0 and skip the entire `pop r10` / `push r10`
    // sequence (the return address stays at the top of the stack
    // where the caller pushed it).
    let entry_spill = if func.is_variadic { 0 } else { func.n_params };
    if entry_spill > 0 && frame.param_spill_bytes > 0 {
        emit_pop_r(code, Reg::R10);
        let (elidable, _n_reg, _n_stack) = param_elidable_mask(func, alloc, abi);
        let placements = param_placements(func, abi);
        // One contiguous c5 cdecl cell block, `n_params` 16-byte cells.
        // Parameter `i` reads its value through `LoadLocal { off: i+2 }`
        // from cell `[rsp + 16*i]` here (equivalently `[rbp + 16*(i+1)]`
        // after the frame is established). The incoming argument area --
        // the caller's outgoing stack, including any shadow space --
        // begins at `[rsp + cells]`; a stack-passed parameter sits at the
        // planner's byte offset within it. Filling each cell by its own
        // placement (rather than as a contiguous register prefix plus a
        // contiguous stack suffix) lets a register-passed parameter and a
        // stack-passed one interleave, which happens when a by-value
        // aggregate that consumes no argument register sits between
        // register parameters (System V MEMORY class), or when a Win64
        // aggregate overflows past the four positional registers.
        let cells = frame.param_spill_bytes;
        debug_assert_eq!(cells, (func.n_params as u32) * 16);
        emit_sub_rsp_imm32(code, cells);
        for i in 0..func.n_params {
            let cell = (i as i32) * 16;
            match placements.get(i).copied() {
                // A register parameter whose home cell is unobserved
                // (mem2reg promoted it, no LocalAddr / live LoadLocal)
                // has a dead store per C99 6.2.4p2; the cell stays
                // reserved so the other parameters keep their offsets.
                Some(super::ArgPlacement::IntReg(r)) => {
                    if !elidable.get(i).copied().unwrap_or(false) {
                        emit_mov_mem_r(code, Reg::RSP, cell, Reg(r));
                    }
                }
                Some(super::ArgPlacement::FpReg(x)) => {
                    if !elidable.get(i).copied().unwrap_or(false) {
                        emit_movsd_mem_xmm(code, Reg::RSP, cell, Reg(x));
                    }
                }
                // Stack-overflow scalar: restripe from the incoming stack
                // into the cell. `off` already includes any shadow space.
                Some(super::ArgPlacement::Stack(off)) => {
                    let src = (cells as i32) + off as i32;
                    emit_mov_r_mem(code, Reg::RAX, Reg::RSP, src);
                    emit_mov_mem_r(code, Reg::RSP, cell, Reg::RAX);
                }
                // Aggregate parameters keep a dead cell; their value is
                // placed later from the argument registers
                // (`emit_struct_param_scatter`) or copied from the
                // incoming stack (`emit_struct_stack_param_copy`).
                _ => {}
            }
        }
        emit_push_r(code, Reg::R10);
        // Net stack effect of the group is -M; the unwinder recovers
        // it as one UWOP_ALLOC at the end of the re-push.
        uw.arg_spill_end = rel(code);
    }

    // Leaf-function elision: a function that makes no calls
    // (the caller's return address stays at top of stack), has no
    // frame to allocate, spills no params, and saves no callee
    // regs has no work in the standard prologue. SysV / Win64 let
    // it ret directly off the caller-pushed return address with
    // rsp unchanged.
    if is_full_leaf(func, frame, alloc, abi) {
        uw.leaf = true;
        return uw;
    }
    // Standard frame: push rbp; mov rbp, rsp; sub rsp, frame_bytes.
    emit_push_r(code, Reg::RBP);
    uw.push_rbp_end = rel(code);
    emit_mov_rr(code, Reg::RBP, Reg::RSP);
    uw.set_fpreg_end = rel(code);
    // Win64 variadic callee home-area spill (Microsoft x64 calling
    // convention). The caller passes the first four arguments in
    // rcx/rdx/r8/r9 by position and reserves 32 bytes of home area
    // above the return address; the callee spills those registers into
    // the home slots at `[rbp + 16 + i*8]` so the named parameters are
    // readable through the body's c5 cdecl cell path (cell stride 8,
    // set on `Frame`) and the home area joins the incoming stack
    // overflow into one contiguous 8-byte-stride region the variadic
    // tail occupies. Arguments past the fourth already sit on the
    // incoming stack at `[rbp + 16 + i*8]`, so they need no spill. The
    // Win64 host variadic ABI (Microsoft x64 calling convention) routes
    // every argument (named and variadic) through the integer registers
    // as a raw 8-byte value (the caller widens floating-point arguments
    // to double and passes `fp_arg_mask = 0`), so the spill is uniformly
    // integer.
    //
    // Spill ALL four argument registers, not just the named ones: a
    // variadic argument that landed in a register (rdx/r8/r9 for the
    // second through fourth argument position) must reach the home area
    // for `va_arg` to read it, and the caller reserves the full 32-byte
    // home regardless of the argument count, so the stores never fall
    // outside it. The body reads only the named slots; the surplus
    // stores feed `va_arg`.
    if win64_variadic_callee(func, abi) {
        for (i, &reg) in abi.int_arg_regs.iter().enumerate() {
            let home_off = (16 + i * 8) as i32;
            emit_mov_mem_r(code, Reg::RBP, home_off, Reg(reg));
        }
    }
    if frame.frame_bytes > 0 {
        // A single `sub rsp,N` lowers to one instruction the unwinder
        // can describe with `UWOP_ALLOC`; a Win64 frame >= one page
        // lowers to a stack-probe loop with no single `sub` and is
        // left undescribed (SizeOfProlog still covers it, and the
        // frame-pointer rule recovers RSP exactly at any body fault,
        // which is where the unwinder samples). `frame_alloc_end == 0`
        // is the "no single sub" sentinel `build_unwind_codes` reads.
        let single_sub = abi.shadow_space == 0 || frame.frame_bytes < 4096;
        emit_stack_alloc(code, frame.frame_bytes, abi);
        if single_sub {
            uw.frame_alloc_end = rel(code);
        }
    }
    // System V variadic callee register save area (System V AMD64
    // 3.5.7). Spill the six integer argument registers rdi rsi rdx rcx
    // r8 r9 into the gp area at `[reg_save + 0 .. 48]` and the eight XMM
    // argument registers xmm0..xmm7 into the fp area at
    // `[reg_save + 48 .. 176]`. The named parameters read their values
    // from this area too (`local_slot_off` redirects positive c5 cdecl
    // slots here), and `va_start` / `va_arg` walk it for the variadic
    // tail. `reg_save` is `[rbp + va_reg_save_off]`; the spill writes
    // address it through rbp so it is independent of the rsp moves the
    // body makes for outgoing-call scratch.
    //
    // The XMM spill is guarded by the caller-passed XMM-register count
    // in `al` (System V AMD64 3.2.3): when the caller passed no
    // floating-point arguments (`al == 0`) the XMM save area is unused,
    // and skipping the eight `movsd` stores avoids touching xmm regs the
    // caller never set. The integer spill is unconditional -- the gp
    // area always holds the (named + variadic) integer arguments.
    if sysv_variadic_callee(func, abi) {
        let reg_save = frame.va_reg_save_off;
        for (i, &reg) in abi.int_arg_regs.iter().enumerate() {
            emit_mov_mem_r(code, Reg::RBP, reg_save + (i as i32) * 8, Reg(reg));
        }
        // test al, al ; je past_fp_save
        super::x86_64::emit_test_al_al(code);
        super::x86_64::emit_jcc_rel32(code, Cc::E, 0);
        // The rel32 operand occupies the four bytes just emitted; the
        // jump is relative to the end of the je instruction (which is
        // where the XMM stores begin).
        let rel32_at = code.len() - 4;
        let fp_save_start = code.len();
        for i in 0..8u32 {
            let off = reg_save + SYSV_GP_SAVE_BYTES as i32 + (i as i32) * 16;
            emit_movsd_mem_xmm(code, Reg::RBP, off, Reg(i as u8));
        }
        let rel = (code.len() - fp_save_start) as i32;
        code[rel32_at..rel32_at + 4].copy_from_slice(&rel.to_le_bytes());
    }
    // The allocator's FP register pool (`callee_fprs`) is empty for both
    // SysV and Win64, so it never assigns an SSA value to a non-volatile
    // xmm. The only non-volatile xmm exposure is the emit pass's fixed
    // FP scratch (xmm13/14/15), which the allocator lists in `fp_used`
    // for Win64 functions that perform FP work. Save those at the bottom
    // of the frame (lowest addresses) with the full 128-bit `movups`,
    // since the caller's value may occupy the upper lanes. SysV leaves
    // `fp_used` empty.
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        let off = (i as i32) * 16;
        emit_movups_mem_xmm(code, Reg::RSP, off, Reg(r));
    }
    // Save callee-saved GPRs the allocator reported as used, directly
    // above the saved-xmm region at sp + saved_fpr_bytes.
    let saved_fpr_bytes = frame.saved_fpr_bytes as i32;
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = saved_fpr_bytes + (i as i32) * 8;
        super::x86_64::emit_mov_mem_r(code, Reg::RSP, off, Reg(r));
    }
    emit_struct_param_scatter(code, func, frame, abi);
    emit_struct_stack_param_copy(code, func, frame, abi);
    uw
}

/// Copy each aggregate parameter the host ABI passes inline on the
/// stack (System V AMD64 MEMORY class with size > 16, or a Win64
/// aggregate that overflows past the four positional registers) into its
/// parser-reserved body local. The caller placed the struct in its
/// outgoing argument area, which sits above the return address at callee
/// entry; after the c5 cdecl entry spill (`n_params` 16-byte cells) it is
/// reachable at `[rbp + 16 + n_params*16 + off]`, where `off` is the
/// planner's byte offset of the parameter in the outgoing area. The dead
/// cell the entry spill reserves for the aggregate keeps the slot->cell
/// map positional; the body reads the struct from the synthetic body
/// local this copy fills. Runs after the frame is set up, so the
/// addresses are rbp-relative and SCRATCH_R10 is free.
fn emit_struct_stack_param_copy(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) {
    if func.param_aggs.iter().all(Option::is_none) {
        return;
    }
    let placements = param_placements(func, abi);
    if !placements
        .iter()
        .any(|p| matches!(p, super::ArgPlacement::StructStack { .. }))
    {
        return;
    }
    let base = 16 + (func.n_params as i64) * 16;
    for (i, &placement) in placements.iter().enumerate() {
        let super::ArgPlacement::StructStack { off, size } = placement else {
            continue;
        };
        let slot = func.param_local_slots.get(i).copied().unwrap_or(0);
        if slot >= 0 {
            continue;
        }
        let src_off = base + off as i64;
        let dst_off = local_slot_off(slot, func, frame, abi);
        let words = (size / 8) as i64;
        for w in 0..words {
            let o = w * 8;
            emit_mov_r_mem(code, SCRATCH_R10, Reg::RBP, (src_off + o) as i32);
            emit_mov_mem_r(code, Reg::RBP, (dst_off + o) as i32, SCRATCH_R10);
        }
        for b in (words * 8)..(size as i64) {
            super::x86_64::emit_movzx_r_mem8(code, SCRATCH_R10, Reg::RBP, (src_off + b) as i32);
            super::x86_64::emit_mov_mem8_r(code, Reg::RBP, (dst_off + b) as i32, SCRATCH_R10);
        }
    }
}

/// Store each register-passed aggregate parameter's incoming argument
/// registers into its parser-reserved body local (System V AMD64
/// 3.2.3). Runs after the frame is established; the argument registers
/// still hold the caller-supplied values, since nothing between entry
/// and here clobbers them. The body reads the aggregate from this
/// local, so the entry argument cell stays unused.
fn emit_struct_param_scatter(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) {
    if func.param_aggs.iter().all(Option::is_none) {
        return;
    }
    let placements = param_placements(func, abi);
    for (i, agg) in func.param_aggs.iter().enumerate() {
        if agg.is_none() {
            continue;
        }
        let Some(super::ArgPlacement::StructRegs { regs, n }) = placements.get(i) else {
            continue;
        };
        let slot = func.param_local_slots.get(i).copied().unwrap_or(0);
        if slot >= 0 {
            continue;
        }
        let base = local_slot_off(slot, func, frame, abi);
        for (k, cr) in regs.iter().take(*n as usize).enumerate() {
            let off = (base + (k as i64) * 8) as i32;
            if cr.is_fp {
                super::x86_64::emit_movsd_mem_xmm(code, Reg::RBP, off, Reg(cr.reg));
            } else {
                super::x86_64::emit_mov_mem_r(code, Reg::RBP, off, Reg(cr.reg));
            }
        }
    }
}

/// Return the x86_64 condition code to use for `Jcc` when the
/// terminator's cond was flagged as branch-fused by the allocator.
/// `negate` is true for `Bz` (branch when comparison failed).
fn fused_branch_cc(
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    cond: super::super::ir::ValueId,
    negate: bool,
) -> Option<Cc> {
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
        BinOp::Eq => Cc::E,
        BinOp::Ne => Cc::Ne,
        BinOp::Lt => Cc::L,
        BinOp::Gt => Cc::G,
        BinOp::Le => Cc::Le,
        BinOp::Ge => Cc::Ge,
        BinOp::Ult => Cc::B,
        BinOp::Ugt => Cc::A,
        BinOp::Ule => Cc::Be,
        BinOp::Uge => Cc::Ae,
        _ => return None,
    };
    if !negate {
        return Some(positive);
    }
    Some(match positive {
        Cc::E => Cc::Ne,
        Cc::Ne => Cc::E,
        Cc::L => Cc::Ge,
        Cc::G => Cc::Le,
        Cc::Le => Cc::G,
        Cc::Ge => Cc::L,
        Cc::B => Cc::Ae,
        Cc::A => Cc::Be,
        Cc::Be => Cc::A,
        Cc::Ae => Cc::B,
        _ => return None,
    })
}

#[allow(clippy::too_many_arguments)]
fn emit_inst(
    code: &mut Vec<u8>,
    inst: &Inst,
    v: super::super::ir::ValueId,
    dst: Place,
    func: &FunctionSsa,
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
    elf_tpoff_fixups: &mut Vec<super::ElfTpoffFixup>,
    extern_tls_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    tls_total_size: usize,
    current_alloca_top: &mut u32,
    param_from_home: &[bool],
    param_plan: &[super::ArgPlacement],
) -> bool {
    match inst {
        Inst::AllocaInit(slot) => {
            // Slot 0: this function doesn't use alloca; emit
            // nothing. Non-zero: the bookkeeping slot lives at
            // `[rbp - slot*8]`; the matching `Inst::Intrinsic`
            // (alloca) reads + writes it to allocate from a
            // per-frame arena. Initialise the slot with its own
            // address so `alloca(n)` lands at `address - n`, the
            // top of the arena reserved by the prologue's
            // local-slot count.
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
        Inst::ParamRef { idx, kind } => {
            // Materialise the i-th host-ABI argument into the
            // allocator's chosen `Place`, sign-extending the low
            // `kind` bytes per C99 6.3.1.3 so the value held in the
            // register is canonically 64-bit-sign-extended.
            //
            // The incoming argument register (rdi rsi rdx rcx r8 r9
            // on System V; rcx rdx r8 r9 on Win64) is not always
            // pristine at this IR position: when an earlier-emitted
            // `ParamRef` wrote to this parameter's argument register
            // (the allocator packed sequentially-live parameters into
            // one register), reading it would take the earlier
            // parameter's value. `param_from_home` marks those at-risk
            // parameters; they are non-elidable, so the prologue
            // spilled them to their c5 cdecl home cell at
            // `[rbp + (idx+1)*16]`, which survives the clobber. The
            // unmarked parameters read the argument register directly.
            // Narrow-load promotion downstream can then collapse
            // `Inst::Extend` to a plain copy when the kinds match.
            let i = *idx as usize;
            // Floating-point parameter (C99 6.2.5p10): its value arrives
            // in an FP argument register named by the plan. Read that
            // xmm register into the allocator's FP dst (FpReg or Spill).
            // A `float` (`LoadKind::F32`) occupies the low 32 bits of the
            // s-register; the body re-narrows it through the f32 store
            // the walker seeded. A scalar copy preserves the relevant
            // bits for either width.
            if matches!(kind, LoadKind::F32 | LoadKind::F64) {
                // An at-risk FP parameter (its incoming xmm overwritten by
                // an earlier FP `ParamRef`'s destination, per
                // `param_home_clobber_set`) reads its prologue-spilled c5
                // cdecl home cell instead of the clobbered register. The
                // prologue stored the cell from the pristine argument
                // register before any body instruction ran.
                if param_from_home.get(i).copied().unwrap_or(false) {
                    let home_off =
                        c5_slot_to_fp_offset(*idx as i64 + 2, frame.param_cell_stride) as i32;
                    let load = |code: &mut Vec<u8>, r: Reg| {
                        if matches!(kind, LoadKind::F32) {
                            emit_movss_xmm_mem(code, r, Reg::RBP, home_off);
                        } else {
                            emit_movsd_xmm_mem(code, r, Reg::RBP, home_off);
                        }
                    };
                    match dst {
                        Place::FpReg(r) => load(code, Reg(r)),
                        Place::Spill(_) => {
                            load(code, SCRATCH_XMM14);
                            fp_spill_dst_to_slot(code, dst, SCRATCH_XMM14, frame);
                        }
                        _ => {
                            bail_msg("ParamRef: FP param dst not fp reg / spill");
                            return false;
                        }
                    }
                    return true;
                }
                let Some(super::ArgPlacement::FpReg(x)) = param_plan.get(i).copied() else {
                    bail_msg("ParamRef: FP param not in an FP argument register");
                    return false;
                };
                let xmm = Reg(x);
                match dst {
                    Place::FpReg(r) => {
                        if r != x {
                            emit_movapd_xmm_xmm(code, Reg(r), xmm);
                        }
                    }
                    Place::Spill(_) => fp_spill_dst_to_slot(code, dst, xmm, frame),
                    _ => {
                        bail_msg("ParamRef: FP param dst not fp reg / spill");
                        return false;
                    }
                }
                return true;
            }
            let from_home = param_from_home.get(i).copied().unwrap_or(false);
            let home_off = c5_slot_to_fp_offset(*idx as i64 + 2, frame.param_cell_stride) as i32;
            // The incoming integer register comes from the plan, not the
            // absolute parameter index: a floating-point parameter
            // earlier in the list consumes an FP register and does not
            // shift the integer bank, so the i-th declared parameter is
            // not the i-th integer register. A stack-passed integer
            // parameter has no incoming register and is always read from
            // its prologue-filled home cell.
            let arg_reg = match param_plan.get(i).copied() {
                Some(super::ArgPlacement::IntReg(r)) => Reg(r),
                _ if from_home => Reg(0),
                _ => {
                    bail_msg("ParamRef: int param has no incoming integer register");
                    return false;
                }
            };
            // Skip the entry sign-extension when no consumer reads the
            // parameter's upper bits; the low word already holds it.
            let high_dead = !alloc.high_observed.get(v as usize).copied().unwrap_or(true);
            let materialize = |code: &mut Vec<u8>, rd: Reg| {
                if from_home {
                    match kind {
                        _ if high_dead => emit_mov_r_mem(code, rd, Reg::RBP, home_off),
                        LoadKind::I8 => {
                            super::x86_64::emit_movsx_r_mem8(code, rd, Reg::RBP, home_off)
                        }
                        LoadKind::I16 => {
                            super::x86_64::emit_movsx_r_mem16(code, rd, Reg::RBP, home_off)
                        }
                        LoadKind::I32 => {
                            super::x86_64::emit_movsxd_r_mem(code, rd, Reg::RBP, home_off)
                        }
                        _ => emit_mov_r_mem(code, rd, Reg::RBP, home_off),
                    }
                } else {
                    match kind {
                        _ if high_dead => emit_mov_rr(code, rd, arg_reg),
                        LoadKind::I8 => super::x86_64::emit_movsx_r_r8(code, rd, arg_reg),
                        LoadKind::I16 => super::x86_64::emit_movsx_r_r16(code, rd, arg_reg),
                        LoadKind::I32 => super::x86_64::emit_movsxd_r_r(code, rd, arg_reg),
                        _ => emit_mov_rr(code, rd, arg_reg),
                    }
                }
            };
            match dst {
                Place::IntReg(r) => materialize(code, Reg(r)),
                Place::Spill(_) => {
                    materialize(code, SCRATCH_R10);
                    spill_dst_to_slot(code, dst, SCRATCH_R10, frame);
                }
                _ => {
                    bail_msg("ParamRef: dst not int reg / spill");
                    return false;
                }
            }
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
            // locals (i < 0) sit at [rbp + 8*i]. A System V variadic
            // callee redirects named-parameter slots into the register
            // save area (see `local_slot_off`). Compute the byte offset
            // and emit `lea rd, [rbp + disp]`. The 32-bit signed `disp`
            // covers any frame our compiler emits; larger frames bail.
            let bytes = local_slot_off(*off, func, frame, abi);
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
        Inst::Load { addr, disp, kind } => emit_load(
            code,
            dst,
            *addr,
            *disp,
            *kind,
            alloc.is_f32(v),
            alloc,
            frame,
        ),
        Inst::Store {
            addr,
            disp,
            value,
            kind,
        } => emit_store(code, dst, v, *addr, *disp, *value, *kind, alloc, frame),
        Inst::LoadLocal { off, kind } => {
            emit_load_local(code, dst, *off, *kind, alloc.is_f32(v), frame, func, abi)
        }
        Inst::StoreLocal { off, value, kind } => {
            emit_store_local(code, dst, v, *off, *value, *kind, alloc, frame, func, abi)
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
        } => emit_store_indexed(
            code, dst, *base, *index, *scale, *value, *kind, alloc, frame,
        ),
        Inst::Binop { op, lhs, rhs } => emit_binop(code, *op, v, dst, *lhs, *rhs, alloc, frame),
        Inst::BinopI { op, lhs, rhs_imm } => {
            emit_binop_imm(code, *op, v, dst, *lhs, *rhs_imm, alloc, frame)
        }
        Inst::Call {
            target_pc,
            args,
            fixed_args,
            fp_return,
            fp_arg_mask,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => emit_call(
            code,
            dst,
            *target_pc,
            args,
            *fixed_args,
            alloc,
            frame,
            abi,
            fixups,
            variadic_targets.contains(target_pc),
            *fp_return,
            *fp_arg_mask,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
            func,
        ),
        Inst::CallExt {
            binding_idx,
            args,
            fp_arg_mask,
            arg_aggs,
            ..
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
            arg_aggs,
            &func.agg_descs,
        ),
        Inst::ImmData(offset) => emit_imm_data(code, dst, *offset, data_fixups, frame),
        Inst::ImmCode(target_ent_pc) => {
            emit_imm_code(code, dst, *target_ent_pc, pending_func_fixups, frame)
        }
        Inst::ImmExtCode(binding_idx) => {
            emit_imm_ext_code(code, dst, *binding_idx, plt_call_fixups, imports, frame)
        }
        // Inst::BlockAddr is handled in emit_function's block loop
        // (it needs the local block_offsets table for its PC-relative
        // lea fixup), so it never reaches emit_inst.
        Inst::Mcpy {
            dst: d,
            src: s,
            size,
        } => emit_mcpy(code, dst, *d, *s, *size, alloc, frame),
        Inst::AtomicRmw {
            op,
            addr,
            value,
            width,
        } => emit_atomic_rmw(code, dst, *op, *addr, *value, *width, alloc, frame),
        Inst::AtomicCas {
            addr,
            expected_addr,
            desired,
            width,
        } => emit_atomic_cas(
            code,
            dst,
            *addr,
            *expected_addr,
            *desired,
            *width,
            alloc,
            frame,
        ),
        Inst::CallIndirect {
            target,
            args,
            callee_variadic,
            fixed_args,
            fp_return,
            fp_arg_mask,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => emit_call_indirect(
            code,
            dst,
            *target,
            args,
            *callee_variadic,
            *fixed_args,
            alloc,
            frame,
            abi,
            *fp_return,
            *fp_arg_mask,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
            func,
        ),
        Inst::Intrinsic { kind, args } => emit_intrinsic(
            code,
            *kind,
            args,
            dst,
            v,
            func,
            alloc,
            frame,
            abi,
            *current_alloca_top,
        ),
        Inst::Fneg(value) => emit_fneg(code, dst, v, *value, alloc, frame),
        Inst::Fma {
            a,
            b,
            c,
            neg_product,
            neg_addend,
        } => emit_fma(
            code,
            dst,
            v,
            *a,
            *b,
            *c,
            *neg_product,
            *neg_addend,
            alloc,
            frame,
        ),
        Inst::Extend { value, kind } => emit_extend(code, dst, *value, *kind, alloc, frame),
        Inst::FpCast { kind, value } => emit_fp_cast(code, dst, *kind, *value, alloc, frame),
        Inst::TlsAddr(offset) => emit_tls_addr(
            code,
            dst,
            *offset,
            v,
            target,
            tls_index_fixups,
            elf_tpoff_fixups,
            extern_tls_names,
            tls_total_size,
            frame,
        ),
        Inst::Phi { .. } => {
            // The value is materialised by the predecessor-exit
            // moves emitted just before each branch terminator
            // that targets this block; at the IR position the
            // phi's allocated Place already holds the merged
            // value.
            true
        }
        other => {
            bail_msg(&alloc::format!(
                "inst variant not yet covered: {}",
                inst_variant_name(other)
            ));
            let _ = frame;
            false
        }
    }
}

/// Human-readable name of an `Inst` variant for bail diagnostics.
fn inst_variant_name(inst: &super::super::ir::Inst) -> &'static str {
    use super::super::ir::Inst;
    match inst {
        Inst::Imm(_) => "Imm",
        Inst::ImmData(_) => "ImmData",
        Inst::ImmCode(_) => "ImmCode",
        Inst::ImmExtCode(_) => "ImmExtCode",
        Inst::BlockAddr(_) => "BlockAddr",
        Inst::LocalAddr(_) => "LocalAddr",
        Inst::TlsAddr(_) => "TlsAddr",
        Inst::Load { .. } => "Load",
        Inst::Store { .. } => "Store",
        Inst::LoadLocal { .. } => "LoadLocal",
        Inst::StoreLocal { .. } => "StoreLocal",
        Inst::LoadIndexed { .. } => "LoadIndexed",
        Inst::StoreIndexed { .. } => "StoreIndexed",
        Inst::Binop { .. } => "Binop",
        Inst::BinopI { .. } => "BinopI",
        Inst::Fneg(_) => "Fneg",
        Inst::Fma { .. } => "Fma",
        Inst::Extend { .. } => "Extend",
        Inst::FpCast { .. } => "FpCast",
        Inst::Call { .. } => "Call",
        Inst::CallIndirect { .. } => "CallIndirect",
        Inst::CallExt { .. } => "CallExt",
        Inst::TailExt(_) => "TailExt",
        Inst::Mcpy { .. } => "Mcpy",
        Inst::AtomicRmw { .. } => "AtomicRmw",
        Inst::AtomicCas { .. } => "AtomicCas",
        Inst::Intrinsic { .. } => "Intrinsic",
        Inst::AllocaInit(_) => "AllocaInit",
        Inst::ParamRef { .. } => "ParamRef",
        Inst::Phi { .. } => "Phi",
    }
}

/// `Inst::TlsAddr` lowering. Routes through the per-target TLS
/// access shape. Linux variant-2 layout: `var = fs:[0] - (tls_total
/// - offset)`. The Windows path emits a TEB `gs:[0x58]` table
/// lookup indexed by `_tls_index` plus a final `lea`, and pushes
/// the writer fixup so the linker can patch the `_tls_index`
/// slot's RVA.
fn emit_tls_addr(
    code: &mut Vec<u8>,
    dst: Place,
    offset: i64,
    v: super::super::ir::ValueId,
    target: Target,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    elf_tpoff_fixups: &mut Vec<super::ElfTpoffFixup>,
    extern_tls_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    tls_total_size: usize,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("TlsAddr: dst not int reg / spill");
        return false;
    };
    match target {
        Target::LinuxX64 => {
            // A cross-unit `extern _Thread_local` carries the referenced
            // symbol in `extern_tls_names`; its TPOFF is unknown until
            // the link merges the TLS blocks, so emit a 0 placeholder and
            // record an extern fixup. A same-unit access bakes the
            // single-unit TPOFF (`tls_total_size - offset`, correct for an
            // in-memory or single-object emit) and also records a fixup so
            // the linker re-patches it against the merged layout when more
            // than one unit contributes TLS storage.
            let extern_sym = extern_tls_names.get(&v).cloned();
            let tpoff = if extern_sym.is_some() {
                0
            } else {
                let t = (tls_total_size as i64) - offset;
                if !(0..=i32::MAX as i64).contains(&t) {
                    bail_msg("TlsAddr: tpoff out of i32 range");
                    return false;
                }
                t
            };
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
            //   imm32 = tpoff (patched by the linker per the fixup).
            let rex_sub = 0x48 | ((rd.0 >> 3) & 1);
            code.push(rex_sub);
            code.push(0x81);
            code.push(0xE8 | (rd.0 & 7));
            let imm_offset = code.len();
            code.extend_from_slice(&(tpoff as i32).to_le_bytes());
            elf_tpoff_fixups.push(super::ElfTpoffFixup {
                imm_offset,
                target: match extern_sym {
                    Some(name) => super::ElfTpoffTarget::Extern(name),
                    None => super::ElfTpoffTarget::Local(offset as u64),
                },
            });
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
            // per-variable offset. The SSA allocator covers rax /
            // r11 / etc.; use SCRATCH_R10 (r10, outside the
            // allocator's pool) for the TEB pointer and `rd`
            // itself for the index load -- the index is only live
            // across one mov so reusing the destination is safe.
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
            // lea rd, [r10 + disp32]: r10 already holds the module's TLS
            // block base, so disp32 is the variable's offset within the
            // merged block with no thread-pointer bias. A cross-unit
            // `extern _Thread_local` offset is unknown until the link merges
            // the TLS blocks, so emit a 0 placeholder; a same-unit access
            // bakes its raw block offset. Both record an `elf_tpoff_fixups`
            // entry so the linker rebases the disp32 to the merged offset
            // (Local) or resolves it by symbol (Extern).
            //   REX.W=1, REX.R = (rd >= 8), REX.B=1 (r10 base);
            //   opcode 8D;
            //   ModR/M mod=10 (disp32), reg=rd.lo, rm=010 (r10).
            let extern_sym = extern_tls_names.get(&v).cloned();
            let disp: i64 = if extern_sym.is_some() { 0 } else { offset };
            let rex_lea = 0x49 | (if rd.0 >= 8 { 0x04 } else { 0 });
            code.push(rex_lea);
            code.push(0x8D);
            code.push(0x82 | ((rd.0 & 7) << 3));
            let imm_offset = code.len();
            code.extend_from_slice(&(disp as i32).to_le_bytes());
            elf_tpoff_fixups.push(super::ElfTpoffFixup {
                imm_offset,
                target: match extern_sym {
                    Some(name) => super::ElfTpoffTarget::Extern(name),
                    None => super::ElfTpoffTarget::Local(offset as u64),
                },
            });
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

/// rbp-relative byte offset of the c5 cdecl slot `off` for the
/// current callee, accounting for the System V variadic register
/// save area.
///
/// For a non-variadic callee (and every non-SysV target) this is the
/// plain `c5_slot_to_fp_offset`: positive c5 cdecl parameter cells at
/// `[rbp + 16 + (off-2)*stride]`, negative locals at `[rbp + off*8]`.
///
/// For a System V variadic callee (System V AMD64 3.5.7) the named
/// parameters are not pushed as positive cells -- they arrive in the
/// argument registers and the prologue spills them into the register
/// save area at the bottom of the frame. A named-parameter access
/// (`off >= 2`, parameter index `off - 2`) is therefore redirected to
/// that parameter's slot in the save area: an integer / pointer
/// parameter to `[reg_save + int_rank*8]` within the 48-byte gp area,
/// a floating-point parameter to `[reg_save + 48 + fp_rank*16]` within
/// the 128-byte fp area, where `reg_save = rbp - frame_bytes` and the
/// rank is the parameter's position within its argument-register bank
/// (the independent int / FP banks of System V AMD64 3.2.3). Locals
/// (`off < 0`) are unaffected.
fn local_slot_off(off: i64, func: &FunctionSsa, frame: Frame, abi: super::Abi) -> i64 {
    if off >= 2 && sysv_variadic_callee(func, abi) {
        let reg_save = frame.va_reg_save_off as i64;
        let p = (off - 2) as usize;
        // Named parameters arrive per the host ABI: the first six integer
        // and eight floating-point parameters in argument registers (the
        // prologue spills them into the register save area), the rest on
        // the incoming stack just above the return address. Use the shared
        // planner so the redirect lands on the same placement the caller
        // produced; the parameter's bank rank is the count of same-bank
        // register placements before it (an overflow parameter consumes no
        // register slot).
        let plan = super::plan_param_regs(func.n_params, func.param_fp_mask, abi);
        match plan.placements.get(p) {
            Some(super::ArgPlacement::Stack(soff)) => {
                // Overflow named parameter: the register save area does not
                // cover it. Read from the incoming stack at [rbp + 16 + soff],
                // matching the caller's stack-argument placement.
                16 + *soff as i64
            }
            Some(super::ArgPlacement::FpReg(_)) => {
                let fp_rank = plan.placements[..p]
                    .iter()
                    .filter(|q| matches!(q, super::ArgPlacement::FpReg(_)))
                    .count() as i64;
                reg_save + SYSV_GP_SAVE_BYTES as i64 + fp_rank * 16
            }
            _ => {
                let int_rank = plan.placements[..p]
                    .iter()
                    .filter(|q| matches!(q, super::ArgPlacement::IntReg(_)))
                    .count() as i64;
                reg_save + int_rank * 8
            }
        }
    } else {
        c5_slot_to_fp_offset(off, frame.param_cell_stride)
    }
}

/// Single-instruction rbp-relative load for `Inst::LoadLocal`.
/// The c5 slot offset folds into the load's ModR/M disp
/// directly, skipping the `LocalAddr` materialisation the
/// `LocalAddr` + `Load` pair would have required.
fn emit_load_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    kind: LoadKind,
    keep_f32: bool,
    frame: Frame,
    func: &FunctionSsa,
    abi: super::Abi,
) -> bool {
    let disp = match i32::try_from(local_slot_off(off, func, frame, abi)) {
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
        // `movss` reads the 4-byte storage into the low dword. A
        // single-precision value (C99 6.3.1.8) stays f32; the archive-
        // reload boundary leaves it untagged and widens via `cvtss2sd`.
        emit_movss_xmm_mem(code, dd, Reg::RBP, disp);
        if !keep_f32 {
            emit_cvtss2sd(code, dd, dd);
        }
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    if matches!(kind, LoadKind::F64) {
        // `double` lvalue: a single 8-byte FP move; no widen.
        let dd = match fp_or_spill_dst(dst) {
            Some(r) => r,
            None => {
                bail_msg("LoadLocal F64: dst not fp reg / spill");
                return false;
            }
        };
        emit_movsd_xmm_mem(code, dd, Reg::RBP, disp);
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
        LoadKind::F32 | LoadKind::F64 => unreachable!(),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Single-instruction rbp-relative store for `Inst::StoreLocal`.
/// Mirrors [`emit_load_local`]; the c5 store ops leave the
/// stored value in the accumulator, so the destination `Place`
/// receives a copy after the store lands.
fn emit_store_local(
    code: &mut Vec<u8>,
    dst: Place,
    _v: super::super::ir::ValueId,
    off: i64,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
    func: &FunctionSsa,
    abi: super::Abi,
) -> bool {
    let disp = match i32::try_from(local_slot_off(off, func, frame, abi)) {
        Ok(v) => v,
        Err(_) => {
            bail_msg("StoreLocal: offset doesn't fit in disp32");
            return false;
        }
    };
    if matches!(kind, StoreKind::F32) {
        // `float` local store. A single-precision value (C99 6.3.1.8)
        // writes directly via `movss`; a wider f64 value (a `double`
        // assigned to a `float` the walker didn't pre-narrow) narrows
        // via `cvtsd2ss` first. Mirrors the `Store` F32 path so a
        // mem2reg-promoted slot round-trips identically to the prior
        // address-taken `LocalAddr + Store` form.
        let value_place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        let Some(dn) = materialize_fp(code, value_place, SCRATCH_XMM14, frame) else {
            bail_msg("StoreLocal F32: value not fp reg / spill / int reg");
            return false;
        };
        if alloc.is_f32(value) {
            emit_movss_mem_xmm(code, Reg::RBP, disp, dn);
        } else {
            emit_cvtsd2ss(code, SCRATCH_XMM15, dn);
            emit_movss_mem_xmm(code, Reg::RBP, disp, SCRATCH_XMM15);
        }
        match dst {
            Place::FpReg(r) if r != dn.0 => emit_movapd_xmm_xmm(code, Reg(r), dn),
            Place::Spill(_) => fp_spill_dst_to_slot(code, dst, dn, frame),
            _ => {}
        }
        return true;
    }
    if matches!(kind, StoreKind::F64) {
        // `double` local store: a single 8-byte FP move; no narrow.
        // The accumulator (dst) keeps the same FP value per the c5
        // store-leaves-value rule (C99 6.5.16p3).
        let value_place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        let Some(dn) = materialize_fp(code, value_place, SCRATCH_XMM14, frame) else {
            bail_msg("StoreLocal F64: value not fp reg / spill / int reg");
            return false;
        };
        emit_movsd_mem_xmm(code, Reg::RBP, disp, dn);
        match dst {
            Place::FpReg(r) if r != dn.0 => emit_movapd_xmm_xmm(code, Reg(r), dn),
            Place::Spill(_) => fp_spill_dst_to_slot(code, dst, dn, frame),
            _ => {}
        }
        return true;
    }
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    // c5 spills an FP-typed accumulator into a local temp through
    // the store-local path (the bit pattern fits 8 bytes either
    // way), so an FpReg value bridges through `movq r, xmm` into
    // a GPR before the store; otherwise it routes through the
    // normal int materialisation.
    let rv = if let Place::FpReg(xr) = value_place {
        // The FP value bridges through a GPR for the integer store. r10
        // is reserved outside both allocator banks and holds nothing
        // live on this path (the store reads only `value`), so it is
        // always available -- a caller-saved pick can come up empty
        // under saturation.
        let scratch = SCRATCH_R10;
        super::x86_64::emit_movq_r_xmm(code, scratch, Reg(xr));
        scratch
    } else {
        match materialize_int(code, value_place, SCRATCH_R10, frame) {
            Some(r) => r,
            None => {
                bail_msg("StoreLocal: value not int reg / spill");
                return false;
            }
        }
    };
    // Store the low `kind`-width bytes; the accumulator below keeps
    // the full source value, matching the c5 rule that an
    // assignment expression yields the stored value before any
    // re-narrowing on read-back (C99 6.5.16p3).
    match kind {
        StoreKind::I64 => emit_mov_mem_r(code, Reg::RBP, disp, rv),
        StoreKind::I32 => super::x86_64::emit_mov_mem32_r(code, Reg::RBP, disp, rv),
        StoreKind::I16 => super::x86_64::emit_mov_mem16_r(code, Reg::RBP, disp, rv),
        StoreKind::I8 => super::x86_64::emit_mov_mem8_r(code, Reg::RBP, disp, rv),
        StoreKind::F32 | StoreKind::F64 => unreachable!(),
    }
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
/// addressing (`[base + index * scale]`). F32 indexed loads aren't
/// a shape the walker produces today.
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
    if matches!(kind, LoadKind::F32 | LoadKind::F64) {
        bail_msg("LoadIndexed: FP not implemented");
        return false;
    }
    let expected_scale: u8 = match kind {
        LoadKind::I64 => 8,
        LoadKind::I32 | LoadKind::U32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::F32 | LoadKind::F64 => unreachable!(),
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
    let regs = match materialize_int_operands_distinct(code, &[base_place, index_place], frame) {
        Some(r) => r,
        None => {
            bail_msg("LoadIndexed: base / index not int reg / spill");
            return false;
        }
    };
    let (rbase, rindex) = (regs[0], regs[1]);
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
        LoadKind::F32 | LoadKind::F64 => unreachable!(),
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
    if matches!(kind, StoreKind::F32 | StoreKind::F64) {
        bail_msg("StoreIndexed: FP not implemented");
        return false;
    }
    let expected_scale: u8 = match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F32 | StoreKind::F64 => unreachable!(),
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
    let regs = match materialize_int_operands_distinct(code, &[base_place, index_place], frame) {
        Some(r) => r,
        None => {
            bail_msg("StoreIndexed: base / index not int reg / spill");
            return false;
        }
    };
    let (rbase, rindex) = (regs[0], regs[1]);
    // The store also needs the value in a register distinct from the
    // base and index. r10 / r11 are the only reserved scratch; when both
    // already hold the spilled base and index there is none left, so the
    // effective address is precomputed into r10 (consuming the base and
    // index registers) and the freed r11 receives the value.
    let fp_value = matches!(value_place, Place::FpReg(_)) && matches!(kind, StoreKind::I64);
    let free = [SCRATCH_R10, SCRATCH_R11]
        .into_iter()
        .find(|s| s.0 != rbase.0 && s.0 != rindex.0);
    let mut precomputed_addr: Option<Reg> = None;
    let rv = if fp_value {
        let Place::FpReg(xr) = value_place else {
            unreachable!()
        };
        let target = match free {
            Some(s) => s,
            None => {
                super::x86_64::emit_lea_r_sib(code, SCRATCH_R10, rbase, rindex, scale);
                precomputed_addr = Some(SCRATCH_R10);
                SCRATCH_R11
            }
        };
        super::x86_64::emit_movq_r_xmm(code, target, Reg(xr));
        target
    } else if let Place::IntReg(r) = value_place {
        Reg(r)
    } else {
        match free {
            Some(s) => match materialize_int(code, value_place, s, frame) {
                Some(r) => r,
                None => {
                    bail_msg("StoreIndexed: value not int reg / spill");
                    return false;
                }
            },
            None => {
                super::x86_64::emit_lea_r_sib(code, SCRATCH_R10, rbase, rindex, scale);
                precomputed_addr = Some(SCRATCH_R10);
                match materialize_int(code, value_place, SCRATCH_R11, frame) {
                    Some(r) => r,
                    None => {
                        bail_msg("StoreIndexed: value not int reg / spill");
                        return false;
                    }
                }
            }
        }
    };
    match precomputed_addr {
        Some(addr) => match kind {
            StoreKind::I64 => super::x86_64::emit_mov_mem_r(code, addr, 0, rv),
            StoreKind::I32 => super::x86_64::emit_mov_mem_r32(code, addr, 0, rv),
            StoreKind::I16 => super::x86_64::emit_mov_mem_r16(code, addr, 0, rv),
            StoreKind::I8 => super::x86_64::emit_mov_mem_r8(code, addr, 0, rv),
            StoreKind::F32 | StoreKind::F64 => unreachable!(),
        },
        None => match kind {
            StoreKind::I64 => super::x86_64::emit_mov_sib_r(code, rbase, rindex, scale, rv),
            StoreKind::I32 => super::x86_64::emit_mov_sib_r32(code, rbase, rindex, scale, rv),
            StoreKind::I16 => super::x86_64::emit_mov_sib_r16(code, rbase, rindex, scale, rv),
            StoreKind::I8 => super::x86_64::emit_mov_sib_r8(code, rbase, rindex, scale, rv),
            StoreKind::F32 | StoreKind::F64 => unreachable!(),
        },
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
    disp: i32,
    kind: LoadKind,
    keep_f32: bool,
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
        // `float` lvalue: `movss` reads 4 bytes into the low dword. A
        // single-precision value (C99 6.3.1.8) stays f32; the archive-
        // reload boundary leaves it untagged and widens via `cvtss2sd`.
        let dd = match fp_or_spill_dst(dst) {
            Some(r) => r,
            None => {
                bail_msg("Load F32: dst not fp reg / spill");
                return false;
            }
        };
        emit_movss_xmm_mem(code, dd, base, disp);
        if !keep_f32 {
            emit_cvtss2sd(code, dd, dd);
        }
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    if let LoadKind::F64 = kind {
        // `double` lvalue: a single 8-byte FP move into an xmm.
        let dd = match fp_or_spill_dst(dst) {
            Some(r) => r,
            None => {
                bail_msg("Load F64: dst not fp reg / spill");
                return false;
            }
        };
        emit_movsd_xmm_mem(code, dd, base, disp);
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("Load: dst not int reg / spill");
        return false;
    };
    match kind {
        LoadKind::I64 => emit_mov_r_mem(code, rd, base, disp),
        LoadKind::I32 => emit_movsxd_r_mem(code, rd, base, disp),
        LoadKind::U32 => super::x86_64::emit_mov_r32_mem(code, rd, base, disp),
        LoadKind::I16 => emit_movsx_r_mem16(code, rd, base, disp),
        LoadKind::U16 => emit_movzx_r_mem16(code, rd, base, disp),
        LoadKind::I8 => super::x86_64::emit_movsx_r_mem8(code, rd, base, disp),
        LoadKind::U8 => super::x86_64::emit_movzx_r_mem8(code, rd, base, disp),
        LoadKind::F32 | LoadKind::F64 => unreachable!(),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

fn emit_store(
    code: &mut Vec<u8>,
    dst: Place,
    _v: super::super::ir::ValueId,
    addr: u32,
    disp: i32,
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
    // Scratch for the addr-Place spill load (the materialise helper
    // only writes to it when addr_place is a Spill; an IntReg place
    // returns the underlying reg directly). r10 is reserved outside
    // both allocator banks, so it never aliases the value's
    // allocator-chosen register and never holds a live SSA value the
    // spill load could clobber -- a caller-saved pick can come up
    // empty under saturation. The value-Place uses the separate
    // reserved r11 scratch below, disjoint from r10.
    let addr_scratch = SCRATCH_R10;
    let base = match materialize_int(code, addr_place, addr_scratch, frame) {
        Some(r) => r,
        None => {
            bail_msg("Store: addr Place not int reg / spill");
            return false;
        }
    };
    if let StoreKind::F32 = kind {
        // `float` lvalue store. A single-precision value (C99 6.3.1.8)
        // is already f32 in the low dword, so write it directly via
        // `movss`. A double value (the archive-reload boundary, or a
        // `double` assigned to a `float` the walker didn't pre-narrow)
        // is narrowed via `cvtsd2ss` first.
        let dn = match materialize_fp(code, value_place, SCRATCH_XMM14, frame) {
            Some(r) => r,
            None => {
                bail_msg("Store F32: value not fp reg / spill / int reg");
                return false;
            }
        };
        if alloc.is_f32(value) {
            emit_movss_mem_xmm(code, base, disp, dn);
            match dst {
                Place::FpReg(r) if r != dn.0 => emit_movapd_xmm_xmm(code, Reg(r), dn),
                Place::Spill(_) => fp_spill_dst_to_slot(code, dst, dn, frame),
                _ => {}
            }
            return true;
        }
        // Narrow into SCRATCH_XMM15 so dn (which may be an
        // allocator-held xmm holding the wider f64 the result Place
        // expects) survives.
        emit_cvtsd2ss(code, SCRATCH_XMM15, dn);
        emit_movss_mem_xmm(code, base, disp, SCRATCH_XMM15);
        match dst {
            Place::FpReg(r) if r != dn.0 => emit_movapd_xmm_xmm(code, Reg(r), dn),
            Place::Spill(_) => fp_spill_dst_to_slot(code, dst, dn, frame),
            _ => {}
        }
        return true;
    }
    if let StoreKind::F64 = kind {
        // `double` lvalue store: a single 8-byte FP move; no narrow.
        // The stored f64 also feeds dst per the c5 store-leaves-value
        // rule (C99 6.5.16p3).
        let Some(dn) = materialize_fp(code, value_place, SCRATCH_XMM14, frame) else {
            bail_msg("Store F64: value not fp reg / spill / int reg");
            return false;
        };
        emit_movsd_mem_xmm(code, base, disp, dn);
        match dst {
            Place::FpReg(r) if r != dn.0 => emit_movapd_xmm_xmm(code, Reg(r), dn),
            Place::Spill(_) => fp_spill_dst_to_slot(code, dst, dn, frame),
            _ => {}
        }
        return true;
    }
    // The value scratch must be disjoint from `base` and must not be a
    // register the allocator parked a value live across this Store in.
    // The earlier fixed `RCX` fallback (used when `base` landed in
    // SCRATCH_R10) clobbered a long-lived value the allocator had
    // placed in rcx -- e.g. a base pointer read by a later indexed
    // load -- because rcx carries SSA values once the bank flattening
    // lets the allocator use it. A spilled value materialised into rcx
    // then overwrote that live value before its last use. `base` is
    // either the addr register place or the live-aware addr scratch,
    // both inside the allocator's caller-saved bank; r11 is reserved
    // outside both allocator banks (see the `SCRATCH_R10` note) so it
    // can never be `base` and never holds a live allocator value, which
    // makes it a safe value scratch under any register pressure. A
    // value-Place already in an int register needs no scratch and
    // `materialize_int` returns it directly.
    let value_scratch = match value_place {
        Place::IntReg(r) => Reg(r),
        _ => SCRATCH_R11,
    };
    let Some(rs) = materialize_int(code, value_place, value_scratch, frame) else {
        bail_msg("Store: value Place not int reg / spill");
        return false;
    };
    match kind {
        StoreKind::I64 => emit_mov_mem_r(code, base, disp, rs),
        StoreKind::I32 => super::x86_64::emit_mov_mem32_r(code, base, disp, rs),
        StoreKind::I16 => super::x86_64::emit_mov_mem16_r(code, base, disp, rs),
        StoreKind::I8 => super::x86_64::emit_mov_mem8_r(code, base, disp, rs),
        StoreKind::F32 | StoreKind::F64 => unreachable!(),
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

/// `Inst::Extend { value, kind }` -- sign-extend the low bytes of a
/// GPR value to 64 bits via `MOVSX` / `MOVSXD`.
fn emit_extend(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let rd = match int_or_spill_dst(dst) {
        Some(r) => r,
        None => {
            bail_msg("Extend: dst not int reg / spill");
            return false;
        }
    };
    let rn = match materialize_int(code, src_place, rd, frame) {
        Some(r) => r,
        None => {
            bail_msg("Extend: value not int reg / spill");
            return false;
        }
    };
    match kind {
        LoadKind::I8 => super::x86_64::emit_movsx_r_r8(code, rd, rn),
        LoadKind::I16 => super::x86_64::emit_movsx_r_r16(code, rd, rn),
        LoadKind::I32 => super::x86_64::emit_movsxd_r_r(code, rd, rn),
        _ => {
            bail_msg("Extend: unsupported kind");
            return false;
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// `Inst::Fma { a, b, c, neg_product, neg_addend }` -- fused multiply
/// add `dst = (neg_product ? -(a*b) : a*b) + (neg_addend ? -c : c)`
/// with a single rounding (C99 6.5p8 / FP_CONTRACT). FMA3 (Haswell+)
/// is the assumed x86_64 baseline. The `231` form computes
/// `dst = a*b OP dst`, so the addend `c` is staged into `dst` first;
/// the two multiplicands are forced into the scratch xmms outside the
/// allocator pool so that staging `c` cannot clobber them.
fn emit_fma(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    a: u32,
    b: u32,
    c: u32,
    neg_product: bool,
    neg_addend: bool,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let is_f32 = alloc.is_f32(v);
    let a_place = alloc.places.get(a as usize).copied().unwrap_or(Place::None);
    let b_place = alloc.places.get(b as usize).copied().unwrap_or(Place::None);
    let c_place = alloc.places.get(c as usize).copied().unwrap_or(Place::None);
    let ra = match materialize_fp(code, a_place, SCRATCH_XMM14, frame) {
        Some(r) => r,
        None => {
            bail_msg("Fma: a not fp reg / spill / int reg");
            return false;
        }
    };
    if ra.0 != SCRATCH_XMM14.0 {
        emit_movapd_xmm_xmm(code, SCRATCH_XMM14, ra);
    }
    let rb = match materialize_fp(code, b_place, SCRATCH_XMM15, frame) {
        Some(r) => r,
        None => {
            bail_msg("Fma: b not fp reg / spill / int reg");
            return false;
        }
    };
    if rb.0 != SCRATCH_XMM15.0 {
        emit_movapd_xmm_xmm(code, SCRATCH_XMM15, rb);
    }
    // The destination also supplies the accumulator. A spilled result
    // routes through a third scratch outside the pool.
    let dd = match dst {
        Place::FpReg(r) => Reg(r),
        Place::Spill(_) => SCRATCH_XMM13,
        _ => {
            bail_msg("Fma: dst not fp reg / spill");
            return false;
        }
    };
    let rc = match materialize_fp(code, c_place, dd, frame) {
        Some(r) => r,
        None => {
            bail_msg("Fma: c not fp reg / spill / int reg");
            return false;
        }
    };
    if rc.0 != dd.0 {
        emit_movapd_xmm_xmm(code, dd, rc);
    }
    let (a14, b15) = (SCRATCH_XMM14, SCRATCH_XMM15);
    match (neg_product, neg_addend, is_f32) {
        (false, false, false) => emit_vfmadd231sd(code, dd, a14, b15),
        (false, true, false) => emit_vfmsub231sd(code, dd, a14, b15),
        (true, false, false) => emit_vfnmadd231sd(code, dd, a14, b15),
        (true, true, false) => emit_vfnmsub231sd(code, dd, a14, b15),
        (false, false, true) => emit_vfmadd231ss(code, dd, a14, b15),
        (false, true, true) => emit_vfmsub231ss(code, dd, a14, b15),
        (true, false, true) => emit_vfnmadd231ss(code, dd, a14, b15),
        (true, true, true) => emit_vfnmsub231ss(code, dd, a14, b15),
    }
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// `Inst::Fneg(v)` -- flip the IEEE 754 sign bit. For a `double`
/// the mask is `1 << 63`; for a single-precision value (C99 6.3.1.8)
/// the mask is `1 << 31`, flipping the sign bit of the f32 held in
/// the low dword. Builds the mask on the fly into `SCRATCH_XMM15`
/// (movq xmm, r10 after loading the immediate into r10) and xors in
/// place.
fn emit_fneg(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
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
    // Build the sign-bit mask in an integer scratch and transfer to
    // SCRATCH_XMM15, then xorpd in place. r10 is reserved outside both
    // allocator banks and holds nothing live on this path (Fneg reads
    // only its FP `value`), so the mask load clobbers no allocator
    // value.
    let scratch_int = SCRATCH_R10;
    let mask: i64 = if alloc.is_f32(v) {
        0x8000_0000
    } else {
        i64::MIN
    };
    emit_mov_r_imm64(code, scratch_int, mask);
    emit_movq_xmm_r(code, SCRATCH_XMM15, scratch_int);
    emit_xorpd(code, dd, SCRATCH_XMM15);
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// `sqrt` / `fabs` intrinsic -- a unary FP operation lowering to a
/// single hardware instruction. `sqrt` uses `SQRTSD` / `SQRTSS`; `fabs`
/// clears the IEEE 754 sign bit by AND-ing with the inverted-sign mask
/// (C99 7.12.7), built in an integer scratch and transferred to
/// SCRATCH_XMM15, mirroring `emit_fneg`.
fn emit_fp_unary(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    value: u32,
    kind: super::super::op::Intrinsic,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    use super::super::op::Intrinsic as I;
    use super::x86_64::{emit_andpd, emit_roundsd, emit_roundss, emit_sqrtsd, emit_sqrtss};
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let dd = match fp_or_spill_dst(dst) {
        Some(r) => r,
        None => {
            bail_msg("fp_unary: dst not fp reg / spill");
            return false;
        }
    };
    let dn = match materialize_fp(code, src_place, dd, frame) {
        Some(r) => r,
        None => {
            bail_msg("fp_unary: value not fp reg / spill / int reg");
            return false;
        }
    };
    let is_f32 = alloc.is_f32(v);
    match kind {
        I::Sqrt | I::Sqrtf => {
            if is_f32 {
                emit_sqrtss(code, dd, dn);
            } else {
                emit_sqrtsd(code, dd, dn);
            }
        }
        I::Fabs | I::Fabsf => {
            if dn.0 != dd.0 {
                emit_movapd_xmm_xmm(code, dd, dn);
            }
            let mask: i64 = if is_f32 { 0x7fff_ffff } else { i64::MAX };
            emit_mov_r_imm64(code, SCRATCH_R10, mask);
            emit_movq_xmm_r(code, SCRATCH_XMM15, SCRATCH_R10);
            emit_andpd(code, dd, SCRATCH_XMM15);
        }
        I::Floor | I::Floorf | I::Ceil | I::Ceilf | I::Trunc | I::Truncf => {
            // ROUNDSD/ROUNDSS rounding-mode immediate, with bit 3 set to
            // suppress the precision (inexact) exception: 0x09 floor
            // (toward -inf), 0x0A ceil (toward +inf), 0x0B trunc (toward
            // zero).
            let imm: u8 = match kind {
                I::Floor | I::Floorf => 0x09,
                I::Ceil | I::Ceilf => 0x0A,
                _ => 0x0B,
            };
            if is_f32 {
                emit_roundss(code, dd, dn, imm);
            } else {
                emit_roundsd(code, dd, dn, imm);
            }
        }
        _ => {
            bail_msg("fp_unary: not a unary FP intrinsic");
            return false;
        }
    }
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
        FpCastKind::UIntToFp => {
            // Unsigned 64-bit to double. SSE2 has no unsigned convert
            // before AVX512: when bit 63 is clear the signed convert is
            // exact; otherwise halve the value -- OR-ing the discarded
            // low bit back in as the sticky bit so the narrowing rounds
            // correctly -- convert, and double.
            let src = match materialize_int(code, src_place, SCRATCH_R10, frame) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast UIntToFp: value not int reg / spill");
                    return false;
                }
            };
            let dd = match fp_or_spill_dst(dst) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast UIntToFp: dst not fp reg / spill");
                    return false;
                }
            };
            // Modifiable scratch copies so a live source register is not
            // clobbered by the shift/and below.
            let rn = SCRATCH_R10;
            let t = SCRATCH_R11;
            emit_mov_rr(code, rn, src);
            emit_test_rr(code, rn, rn);
            emit_jcc_rel8(code, Cc::S, 0);
            let js_fixup = code.len() - 1;
            emit_cvtsi2sd(code, dd, rn);
            emit_jmp_rel8(code, 0);
            let jmp_fixup = code.len() - 1;
            let big = code.len();
            code[js_fixup] = (big - js_fixup - 1) as i8 as u8;
            emit_mov_rr(code, t, rn);
            emit_shr_r_imm8(code, t, 1);
            emit_and_r_imm32(code, rn, 1);
            emit_or_rr(code, t, rn);
            emit_cvtsi2sd(code, dd, t);
            emit_addsd(code, dd, dd);
            let done = code.len();
            code[jmp_fixup] = (done - jmp_fixup - 1) as i8 as u8;
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
        FpCastKind::UFpToInt => {
            // Double to unsigned 64-bit. SSE2 `cvttsd2si` is signed: a
            // value in [2^63, 2^64) saturates to the integer
            // indefinite. Compare with 2^63: below it the signed
            // truncate is exact; at or above, subtract 2^63, truncate
            // the in-range remainder, and set bit 63.
            let src_xmm = match materialize_fp(code, src_place, SCRATCH_XMM14, frame) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast UFpToInt: value not fp reg / spill / int reg");
                    return false;
                }
            };
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("FpCast UFpToInt: dst not int reg / spill");
                return false;
            };
            // Modifiable copy so the `subsd` below cannot clobber a
            // live source xmm.
            let dn = SCRATCH_XMM14;
            emit_movapd_xmm_xmm(code, dn, src_xmm);
            let two63 = SCRATCH_XMM15;
            emit_mov_r_imm64(code, SCRATCH_R11, 0x43E0000000000000u64 as i64);
            emit_movq_xmm_r(code, two63, SCRATCH_R11);
            emit_ucomisd(code, dn, two63);
            emit_jcc_rel8(code, Cc::Ae, 0);
            let jae_fixup = code.len() - 1;
            emit_cvttsd2si(code, rd, dn);
            emit_jmp_rel8(code, 0);
            let jmp_fixup = code.len() - 1;
            let big = code.len();
            code[jae_fixup] = (big - jae_fixup - 1) as i8 as u8;
            emit_subsd(code, dn, two63);
            emit_cvttsd2si(code, rd, dn);
            emit_mov_r_imm64(code, SCRATCH_R11, 0x8000000000000000u64 as i64);
            emit_or_rr(code, rd, SCRATCH_R11);
            let done = code.len();
            code[jmp_fixup] = (done - jmp_fixup - 1) as i8 as u8;
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        // C99 6.3.1.5: widen single to double (`cvtss2sd`) or narrow
        // double to single (`cvtsd2ss`). The single value lives in the
        // low dword of the xmm; `cvtss2sd` reads it, `cvtsd2ss` writes
        // it, so both are register-to-register with no separate move.
        FpCastKind::F32ToF64 => {
            let dn = match materialize_fp(code, src_place, SCRATCH_XMM14, frame) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast F32ToF64: value not fp reg / spill / int reg");
                    return false;
                }
            };
            let dd = match fp_or_spill_dst(dst) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast F32ToF64: dst not fp reg / spill");
                    return false;
                }
            };
            emit_cvtss2sd(code, dd, dn);
            fp_spill_dst_to_slot(code, dst, dd, frame);
            true
        }
        FpCastKind::F64ToF32 => {
            let dn = match materialize_fp(code, src_place, SCRATCH_XMM14, frame) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast F64ToF32: value not fp reg / spill / int reg");
                    return false;
                }
            };
            let dd = match fp_or_spill_dst(dst) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast F64ToF32: dst not fp reg / spill");
                    return false;
                }
            };
            emit_cvtsd2ss(code, dd, dn);
            fp_spill_dst_to_slot(code, dst, dd, frame);
            true
        }
    }
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
    // FP arithmetic: scalar f64 in xmm. `op dst, rhs` overwrites
    // dst, so rhs must be captured into a register distinct from
    // dst before lhs is staged into dst. The allocator can color
    // rhs to the same xmm as dst; `materialize_fp` returns an
    // `FpReg` source in place without copying, so staging lhs into
    // dst would then clobber rhs. Capture rhs first, forcing a copy
    // into `SCRATCH_XMM15` when it aliases dst.
    if let Some(arith) = fp_arith_enc_for(op, alloc.is_f32(v)) {
        let dd = match fp_or_spill_dst(dst) {
            Some(r) => r,
            None => {
                bail_msg("Fbinop: dst not fp reg / spill");
                return false;
            }
        };
        let dm = match rhs_place {
            Place::FpReg(r) if r == dd.0 => {
                emit_movapd_xmm_xmm(code, SCRATCH_XMM15, dd);
                SCRATCH_XMM15
            }
            _ => match materialize_fp(code, rhs_place, SCRATCH_XMM15, frame) {
                Some(r) => r,
                None => {
                    bail_msg("Fbinop: rhs not fp reg / spill / int reg");
                    return false;
                }
            },
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
    // OR-with-`setp` fixup.
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
        // The compare width follows the operands' precision (C99
        // 6.3.1.8): two f32 operands use `ucomiss`, else `ucomisd`.
        if alloc.is_f32(lhs) || alloc.is_f32(rhs) {
            emit_ucomiss(code, dn, dm);
        } else {
            emit_ucomisd(code, dn, dm);
        }
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
                // parity-fix setcc. r10 / r11 are reserved outside both
                // allocator banks and hold nothing live on the Fcmp
                // path (only the two FP operands, both in xmm), so one
                // of them is always disjoint from `rd` -- a caller-saved
                // pick can come up empty under saturation.
                let scratch = if rd.0 == SCRATCH_R10.0 {
                    SCRATCH_R11
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
    // sxtw / movsx fold for the walker-shape sign-narrow pair
    // `Binop(Shl, X, Imm(K)); Binop(Shr, _, Imm(K))`. The
    // allocator marked this Shr and stashed the K (32 / 48 / 56);
    // emit one movsxd / movsx instead of two shifts.
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
        let src_reg = match src_place {
            Place::IntReg(r) => Reg(r),
            Place::Spill(slot) => {
                let sp_off = spill_slot_sp_offset(frame, slot);
                emit_mov_r_mem(code, rd, Reg::RSP, sp_off);
                rd
            }
            _ => {
                bail_msg("Binop sxtw: src not int reg / spill");
                return false;
            }
        };
        let k = alloc.sxtw_k.get(v as usize).copied().unwrap_or(0);
        match k {
            32 => super::x86_64::emit_movsxd_r_r(code, rd, src_reg),
            48 => super::x86_64::emit_movsx_r_r16(code, rd, src_reg),
            56 => super::x86_64::emit_movsx_r_r8(code, rd, src_reg),
            _ => {
                bail_msg("Binop sxtw: unexpected K");
                return false;
            }
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // A spilled second operand is read in place through the op's
    // memory-source form, so it needs no scratch register. The prior
    // path staged a spilled rhs into a fixed scratch (rcx when rd was
    // r10), which clobbered a live lhs already resident in that
    // register under high pressure. Shifts are excluded: x86 reads the
    // shift count from cl, not from a memory operand.
    if let Place::Spill(rhs_slot) = rhs_place {
        let rhs_off = spill_slot_sp_offset(frame, rhs_slot);
        let cmp_cc = match op {
            BinOp::Eq => Some(Cc::E),
            BinOp::Ne => Some(Cc::Ne),
            BinOp::Lt => Some(Cc::L),
            BinOp::Gt => Some(Cc::G),
            BinOp::Le => Some(Cc::Le),
            BinOp::Ge => Some(Cc::Ge),
            BinOp::Ult => Some(Cc::B),
            BinOp::Ugt => Some(Cc::A),
            BinOp::Ule => Some(Cc::Be),
            BinOp::Uge => Some(Cc::Ae),
            _ => None,
        };
        let arith = matches!(
            op,
            BinOp::Add | BinOp::Sub | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor
        );
        if arith || cmp_cc.is_some() {
            let rn = match lhs_place {
                Place::IntReg(r) => Reg(r),
                Place::Spill(lhs_slot) => {
                    let sp_off = spill_slot_sp_offset(frame, lhs_slot);
                    emit_mov_r_mem(code, rd, Reg::RSP, sp_off);
                    rd
                }
                _ => {
                    bail_msg("Binop: lhs not int reg / spill");
                    return false;
                }
            };
            if let Some(cc) = cmp_cc {
                emit_cmp_r_mem(code, rn, Reg::RSP, rhs_off);
                if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
                    return true;
                }
                emit_setcc_r8(code, cc, rd);
                emit_movzx_r_r8(code, rd, rd);
            } else {
                if rd.0 != rn.0 {
                    emit_mov_rr(code, rd, rn);
                }
                match op {
                    BinOp::Add => emit_add_r_mem(code, rd, Reg::RSP, rhs_off),
                    BinOp::Sub => emit_sub_r_mem(code, rd, Reg::RSP, rhs_off),
                    BinOp::Mul => emit_imul_r_mem(code, rd, Reg::RSP, rhs_off),
                    BinOp::And => emit_and_r_mem(code, rd, Reg::RSP, rhs_off),
                    BinOp::Or => emit_or_r_mem(code, rd, Reg::RSP, rhs_off),
                    BinOp::Xor => emit_xor_r_mem(code, rd, Reg::RSP, rhs_off),
                    _ => unreachable!(),
                }
            }
            spill_dst_to_slot(code, dst, rd, frame);
            return true;
        }
    }

    // Stage lhs into rd first, so the two-operand ops below can
    // `op rd, rm` and land the result in rd. A spilled rhs for an
    // arithmetic or compare op was already handled in place above; the
    // remaining spilled-rhs case is a shift, whose count this scratch
    // carries. A register rhs needs the scratch only to preserve itself
    // when it aliases rd.
    //
    // The scratch must not be rcx for a shift: the shift count is moved
    // into rcx (cl) by the shift arm below, which preserves any live SSA
    // value the allocator parked in rcx with a push / pop around that
    // move. Materialising a spilled count straight into rcx here would
    // overwrite that live value before the push could save it. r11 is
    // reserved outside both allocator banks (see the `SCRATCH_R10`
    // note), so it is always a safe count scratch; the non-shift path
    // keeps the cheaper r10 / rcx choice.
    let is_shift = matches!(op, BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror);
    let rhs_scratch = if is_shift {
        if rd.0 == SCRATCH_R10.0 {
            SCRATCH_R11
        } else {
            SCRATCH_R10
        }
    } else if rd.0 == SCRATCH_R10.0 {
        Reg::RCX
    } else {
        SCRATCH_R10
    };
    let rhs_aliases_rd = matches!(rhs_place, Place::IntReg(r) if r == rd.0);
    // When the allocator places both rhs and dst in the same register
    // and lhs is spilled, the lhs spill-load below writes rd before
    // any rhs-staging mov runs, destroying the rhs value. Preserve
    // rhs into the scratch first so the downstream
    // rhs_aliases_rd / stage_rhs_to_scratch paths read the right
    // operand.
    let rhs_preserved_in_scratch = rhs_aliases_rd && matches!(lhs_place, Place::Spill(_));
    if rhs_preserved_in_scratch {
        emit_mov_rr(code, rhs_scratch, rd);
    }
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
        // When the divisor aliased rd and was saved into the scratch
        // above (because the spilled lhs load just overwrote rd), the
        // divisor now lives in that scratch register, not its original
        // place; reading the original place would take the lhs as the
        // divisor.
        let divisor_place = if rhs_preserved_in_scratch {
            Place::IntReg(rhs_scratch.0)
        } else {
            rhs_place
        };
        return emit_binop_divmod(code, op, dst, rd, rn, divisor_place, frame);
    }
    // x86_64's two-operand op `OP rd, rm` mutates rd. The standard
    // sequence below stages LHS into rd then emits `OP rd, rm`.
    // When rhs is an IntReg whose register is rd, materialize_int
    // would return rd as `rm`; the subsequent `mov rd, rn` would
    // then overwrite the rhs value, and the op would compute
    // `lhs OP lhs` instead of `lhs OP rhs`.
    //
    // For commutative ops (Add, Mul, And, Or, Xor) the work to fix
    // this is zero: rd already holds the value we want, so emit
    // `OP rd, rn` directly -- rd <- rhs OP lhs == lhs OP rhs.
    //
    // For non-commutative ops (Sub, Lt, Gt, ...) we must stage
    // rhs into the scratch before the `mov rd, rn` clobbers it.
    let commutative = matches!(
        op,
        BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor
    );
    let is_cmp = matches!(
        op,
        BinOp::Eq
            | BinOp::Ne
            | BinOp::Lt
            | BinOp::Gt
            | BinOp::Le
            | BinOp::Ge
            | BinOp::Ult
            | BinOp::Ugt
            | BinOp::Ule
            | BinOp::Uge
    );
    if rhs_aliases_rd && commutative {
        // When rhs was preserved into rhs_scratch above (lhs Spill case),
        // rd now holds lhs from the spill load and the second operand
        // is rhs_scratch; otherwise rd still holds rhs and rn holds lhs.
        let other = if rhs_preserved_in_scratch {
            rhs_scratch
        } else {
            rn
        };
        match op {
            BinOp::Add => emit_add_rr(code, rd, other),
            BinOp::Mul => emit_imul_rr(code, rd, other),
            BinOp::And => emit_and_rr(code, rd, other),
            BinOp::Or => emit_or_rr(code, rd, other),
            BinOp::Xor => emit_xor_rr(code, rd, other),
            _ => unreachable!(),
        }
        return true;
    }
    // Comparison ops read both operands, set flags, then setcc+
    // movzx writes the dst. The dst is not used as an input, so
    // the staging `mov rd, rn` below is unnecessary; the rhs may
    // even live in `rd` itself (rhs_aliases_rd), and `cmp rn, rm`
    // still reads it before any write touches rd. Skip the stage
    // and the scratch-mov for cmp ops.
    let stage_rhs_to_scratch = rhs_aliases_rd && !is_cmp;
    let Some(rm) = (if rhs_preserved_in_scratch {
        Some(rhs_scratch)
    } else if stage_rhs_to_scratch {
        emit_mov_rr(code, rhs_scratch, rd);
        Some(rhs_scratch)
    } else if let Place::IntReg(r) = rhs_place {
        Some(Reg(r))
    } else {
        materialize_int(code, rhs_place, rhs_scratch, frame)
    }) else {
        bail_msg("Binop: rhs not int reg / spill");
        return false;
    };
    // `lea rd, [rn + rm]` folds the staging mov and the add into one
    // address-unit op when the result lands in a different register
    // than the lhs. It reads both operands before writing rd (so it is
    // correct even were rd to alias rm) and sets no flags, which an
    // add-result consumer never reads. The rd == rn case is already a
    // single `add rd, rm`, so it stays on the path below.
    if matches!(op, BinOp::Add) && rd.0 != rn.0 {
        super::x86_64::emit_lea_r_sib(code, rd, rn, rm, 1);
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // x86_64's two-operand ops mutate the destination, so stage
    // the LHS into rd first (preserves SSA semantics where the
    // result is `lhs OP rhs`). Cmp ops skip this -- they read
    // rn / rm directly and write dst via setcc+movzx.
    if !is_cmp && rd.0 != rn.0 {
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
            // cmp lhs, rhs ; setcc rd_low ; movzx rd, rd_low. The
            // `mov rd, rn` above clobbered rd to the lhs already;
            // reverse that into a cmp directly off rn. Write setcc
            // into rd's own low byte (rather than cl) so a live SSA
            // value parked in rcx is not destroyed.
            emit_cmp_rr(code, rn, rm);
            if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
                return true;
            }
            let cc = match op {
                BinOp::Eq => Cc::E,
                BinOp::Ne => Cc::Ne,
                BinOp::Lt => Cc::L,
                BinOp::Gt => Cc::G,
                BinOp::Le => Cc::Le,
                BinOp::Ge => Cc::Ge,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, rd);
            emit_movzx_r_r8(code, rd, rd);
        }
        BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge => {
            emit_cmp_rr(code, rn, rm);
            if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
                return true;
            }
            let cc = match op {
                BinOp::Ult => Cc::B,
                BinOp::Ugt => Cc::A,
                BinOp::Ule => Cc::Be,
                BinOp::Uge => Cc::Ae,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, rd);
            emit_movzx_r_r8(code, rd, rd);
        }
        BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror => {
            // x86 shifts read the count from cl. The shared helper moves
            // the count (here a register, `rm`) into rcx and shifts rd,
            // preserving any live rcx, and stages through a reserved
            // scratch when rd is rcx. The `mov rd, rn` above left rd
            // holding the lhs to be shifted.
            return emit_shift_by_count_reg(
                code,
                op,
                v,
                dst,
                rd,
                ShiftCount::Reg(rm),
                alloc,
                frame,
            );
        }
        _ => {
            // Every representable integer binop is handled above. A new
            // op variant here is an IR producer/consumer mismatch, not a
            // register-pressure shape -- fail loudly rather than emit a
            // subset-bail that surfaces as an ICE downstream.
            panic!("Binop: unhandled integer op variant {op:?}");
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

    // Preserve rax / rdx: the allocator can park a live value in
    // either register and the divmod must not destroy it. rax
    // receives the dividend low half and the quotient; rdx
    // receives the dividend high half (cqo / xor edx,edx) and the
    // remainder. Skip the save when rd will overwrite the register
    // anyway, since the value living there is dead the moment rd
    // commits its result.
    let preserve_rax = rd.0 != Reg::RAX.0;
    let preserve_rdx = rd.0 != Reg::RDX.0;
    let pushed_bytes = (preserve_rax as i32 + preserve_rdx as i32) * 8;

    // Resolve the divisor operand. IDIV / DIV accept r/m64, so a
    // spilled divisor is named directly through its stack slot (its
    // rsp offset shifted by the rax/rdx preservation pushes below) and
    // a register divisor outside the implicit rdx:rax pair is used in
    // place -- neither needs a scratch register, which the surrounding
    // high-pressure allocation may not have free. A divisor that
    // aliases rax or rdx is copied into the dedicated scratch before
    // the dividend setup overwrites those registers; the scratch is
    // free unless it already holds the dividend (a spilled lhs).
    enum DivOperand {
        Reg(Reg),
        Mem(i32),
    }
    let div_operand = match rhs_place {
        Place::IntReg(r) if r != Reg::RAX.0 && r != Reg::RDX.0 => DivOperand::Reg(Reg(r)),
        Place::Spill(slot) => DivOperand::Mem(spill_slot_sp_offset(frame, slot) + pushed_bytes),
        Place::IntReg(r) => {
            // A divisor in rax / rdx must be copied out before the
            // dividend setup overwrites those registers. The copy
            // target must not collide with the staged dividend: a
            // spilled lhs is materialised into rd, which for a
            // spilled dst is SCRATCH_R10, so SCRATCH_R10 is not
            // always free here. SCRATCH_R11 is reserved outside both
            // allocator pools and never holds the dividend, so it is
            // always available for the divisor copy.
            let div_scratch = if rn.0 == SCRATCH_R10.0 {
                SCRATCH_R11
            } else {
                SCRATCH_R10
            };
            emit_mov_rr(code, div_scratch, Reg(r));
            DivOperand::Reg(div_scratch)
        }
        _ => {
            bail_msg("Binop divmod: rhs not int reg / spill");
            return false;
        }
    };

    if preserve_rax {
        emit_push_r(code, Reg::RAX);
    }
    if preserve_rdx {
        emit_push_r(code, Reg::RDX);
    }
    // rax := dividend low half.
    if rn.0 != Reg::RAX.0 {
        emit_mov_rr(code, Reg::RAX, rn);
    }
    // rdx := dividend high half. Signed uses CQO to sign-extend
    // rax; unsigned zero-extends with `xor edx, edx`.
    if is_unsigned {
        emit_xor_rr(code, Reg::RDX, Reg::RDX);
        match div_operand {
            DivOperand::Reg(r) => super::x86_64::emit_div_r(code, r),
            DivOperand::Mem(off) => super::x86_64::emit_div_m(code, Reg::RSP, off),
        }
    } else {
        super::x86_64::emit_cqo(code);
        match div_operand {
            DivOperand::Reg(r) => super::x86_64::emit_idiv_r(code, r),
            DivOperand::Mem(off) => super::x86_64::emit_idiv_m(code, Reg::RSP, off),
        }
    }
    // Capture result into rd before restoring rdx / rax.
    let result_src = if want_remainder { Reg::RDX } else { Reg::RAX };
    if rd.0 != result_src.0 {
        emit_mov_rr(code, rd, result_src);
    }
    if preserve_rdx {
        emit_pop_r(code, Reg::RDX);
    }
    if preserve_rax {
        emit_pop_r(code, Reg::RAX);
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Source of a variable shift count for `emit_shift_by_count_reg`.
enum ShiftCount {
    /// Count already resident in a register; moved into cl.
    Reg(Reg),
    /// Count is a compile-time immediate; loaded into cl. Reached
    /// only for an out-of-range `BinopI` shift (C99 6.5.7p3 makes
    /// such a count undefined), kept well-formed rather than bailed.
    Imm(i64),
}

/// Lower `rd = rd OP count` for a variable-count shift / rotate, with
/// the value to shift already staged in `rd`. x86 reads the count
/// from cl, so the count is moved into rcx and the shift issued
/// against rd. When the allocator parked a live SSA value in rcx
/// (rcx is in the caller-saved pool), it is preserved with push /
/// pop around the move; the body is register-to-register only, so
/// the transient 8-byte misalignment is irrelevant (no call site
/// intervenes). When `rd` itself is rcx the value to shift and the
/// count would both need rcx at once, so the shift is staged in a
/// reserved scratch and copied back.
#[allow(clippy::too_many_arguments)]
fn emit_shift_by_count_reg(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    rd: Reg,
    count: ShiftCount,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let count_reg = match count {
        ShiftCount::Reg(r) => Some(r),
        ShiftCount::Imm(_) => None,
    };
    let do_shift = |code: &mut Vec<u8>, target: Reg| match op {
        BinOp::Shl => emit_shl_r_cl(code, target),
        BinOp::Shr => emit_sar_r_cl(code, target),
        BinOp::Shru => emit_shr_r_cl(code, target),
        BinOp::Ror => super::x86_64::emit_ror_r_cl(code, target),
        _ => unreachable!("emit_shift_by_count_reg: non-shift op {op:?}"),
    };
    if rd.0 == Reg::RCX.0 {
        // Stage the value in a scratch disjoint from rcx and the count
        // register; r11 is reserved outside both allocator banks and
        // never aliases rd, the count, or any live value.
        let scratch = SCRATCH_R11;
        emit_mov_rr(code, scratch, rd);
        match count {
            ShiftCount::Reg(r) if r.0 != Reg::RCX.0 => emit_mov_rr(code, Reg::RCX, r),
            ShiftCount::Reg(_) => {}
            ShiftCount::Imm(imm) => super::x86_64::emit_mov_r_imm64(code, Reg::RCX, imm),
        }
        do_shift(code, scratch);
        emit_mov_rr(code, rd, scratch);
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    let rcx_holds_live = count_reg.map(|r| r.0).unwrap_or(u8::MAX) != Reg::RCX.0
        && alloc.places.iter().enumerate().any(|(idx, p)| {
            let i = idx as u32;
            let last = alloc.last_use.get(idx).copied().unwrap_or(0);
            matches!(p, Place::IntReg(r) if *r == Reg::RCX.0) && i < v && v < last
        });
    if rcx_holds_live {
        emit_push_r(code, Reg::RCX);
    }
    match count {
        ShiftCount::Reg(r) if r.0 != Reg::RCX.0 => emit_mov_rr(code, Reg::RCX, r),
        ShiftCount::Reg(_) => {}
        ShiftCount::Imm(imm) => super::x86_64::emit_mov_r_imm64(code, Reg::RCX, imm),
    }
    do_shift(code, rd);
    if rcx_holds_live {
        emit_pop_r(code, Reg::RCX);
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
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
    // sxtw fold via movsxd / movsx -- mirrors the aarch64 path.
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
        let src_reg = match src_place {
            Place::IntReg(r) => Reg(r),
            Place::Spill(slot) => {
                let sp_off = spill_slot_sp_offset(frame, slot);
                emit_mov_r_mem(code, rd, Reg::RSP, sp_off);
                rd
            }
            _ => {
                bail_msg("BinopI sxtw: src not int reg / spill");
                return false;
            }
        };
        match rhs_imm {
            32 => super::x86_64::emit_movsxd_r_r(code, rd, src_reg),
            48 => super::x86_64::emit_movsx_r_r16(code, rd, src_reg),
            56 => super::x86_64::emit_movsx_r_r8(code, rd, src_reg),
            _ => unreachable!(),
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
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
        // Multiply by 3 / 5 / 9 is one `lea rd, [rn + rn*2/4/8]`: a
        // single-cycle address-unit operation instead of the multi-cycle
        // `imul`. The base and index are both `rn`, so the result may
        // reuse `rn` (the effective address is read before the write).
        BinOp::Mul if matches!(rhs_imm, 3 | 5 | 9) => {
            super::x86_64::emit_lea_r_sib(code, rd, rn, rn, (rhs_imm - 1) as u8);
            true
        }
        // `imul rd, rn, imm32` reads `rn` and writes `rd` in one
        // instruction, so it needs neither a staging mov nor an
        // immediate-scratch register. This covers the multiply by a
        // non-power-of-two constant that the scratch path below cannot
        // lower when no caller-saved register is free.
        BinOp::Mul if imm_fits_i32 => {
            super::x86_64::emit_imul_r_r_imm32(code, rd, rn, rhs_imm as i32);
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
        BinOp::Ror if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_ror_r_imm8(code, rd, shift_amount.unwrap());
            true
        }
        // A step of one encodes as `inc` / `dec` (three bytes) rather
        // than `add` / `sub` with an immediate (seven). The flags differ
        // -- `inc` / `dec` leave the carry flag unchanged -- but the
        // result register is identical and no consumer reads the carry
        // of a `BinopI` result.
        BinOp::Add if rhs_imm == 1 || rhs_imm == -1 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            if rhs_imm == 1 {
                super::x86_64::emit_inc_r(code, rd);
            } else {
                super::x86_64::emit_dec_r(code, rd);
            }
            true
        }
        BinOp::Sub if rhs_imm == 1 || rhs_imm == -1 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            if rhs_imm == 1 {
                super::x86_64::emit_dec_r(code, rd);
            } else {
                super::x86_64::emit_inc_r(code, rd);
            }
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
        // `x & 0xffffffff` is a zero-extension of the low 32 bits. A
        // 32-bit `mov rd, rn` clears the upper half, materialising the
        // mask in one instruction with no immediate-scratch register.
        // The imm32 AND form cannot encode this value: `and r64, imm32`
        // sign-extends the immediate, so 0xffffffff would become
        // 0xffffffffffffffff and mask nothing.
        BinOp::And if rhs_imm == 0xffff_ffff => {
            super::x86_64::emit_mov_r32_r32(code, rd, rn);
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
        BinOp::Xor if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_xor_r_imm32(code, rd, rhs_imm as i32);
            true
        }
        _ => false,
    };
    if used_peephole {
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Compare-with-i32-immediate peephole: emit `cmp rn, imm32`
    // and skip the `mov rcx, imm64` materialisation. The shorter
    // imm32 form covers the operand range typical for `BinopI`
    // comparisons against small constants; outside that range we
    // fall through to the rcx-scratch path below.
    let is_signed_cmp = matches!(
        op,
        BinOp::Eq | BinOp::Ne | BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge
    );
    let is_unsigned_cmp = matches!(op, BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge);
    if (is_signed_cmp || is_unsigned_cmp) && imm_fits_i32 {
        // A compare against 0 is the shorter `test rn, rn`; ZF / SF /
        // CF / OF match `cmp rn, 0`, so the dependent setcc / jcc is
        // unchanged.
        if rhs_imm == 0 {
            super::x86_64::emit_test_rr(code, rn, rn);
        } else {
            super::x86_64::emit_cmp_r_imm32(code, rn, rhs_imm as i32);
        }
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        let cc = match op {
            BinOp::Eq => Cc::E,
            BinOp::Ne => Cc::Ne,
            BinOp::Lt => Cc::L,
            BinOp::Gt => Cc::G,
            BinOp::Le => Cc::Le,
            BinOp::Ge => Cc::Ge,
            BinOp::Ult => Cc::B,
            BinOp::Ugt => Cc::A,
            BinOp::Ule => Cc::Be,
            BinOp::Uge => Cc::Ae,
            _ => unreachable!(),
        };
        emit_setcc_r8(code, cc, rd);
        emit_movzx_r_r8(code, rd, rd);
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Commutative ops with `rd != rn` can fold the staging mov
    // into the immediate materialisation: `mov rd, imm; OP rd,
    // rn` is two instructions and produces `imm OP rn == lhs OP
    // imm` by commutativity. The non-commutative path below uses
    // r11 as a scratch (r11 sits outside both
    // `caller_gprs` and `callee_gprs` in `RegBanks::for_target`,
    // so the allocator never picks r11 for an SSA value).
    let commutative = matches!(
        op,
        BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor
    );
    if commutative && rd.0 != rn.0 {
        super::x86_64::emit_mov_r_imm64(code, rd, rhs_imm);
        match op {
            BinOp::Add => emit_add_rr(code, rd, rn),
            BinOp::Mul => emit_imul_rr(code, rd, rn),
            BinOp::And => emit_and_rr(code, rd, rn),
            BinOp::Or => emit_or_rr(code, rd, rn),
            BinOp::Xor => emit_xor_rr(code, rd, rn),
            _ => unreachable!(),
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // A shift by a count outside 0..63 is the only `BinopI` shift
    // shape that reaches here (the in-range case took the imm8
    // peephole above). C99 6.5.7p3 makes a count >= the operand
    // width undefined; route it through cl like the register-shift
    // path so the emit stays well-formed rather than bailing.
    if matches!(op, BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror) {
        if rd.0 != rn.0 {
            emit_mov_rr(code, rd, rn);
        }
        return emit_shift_by_count_reg(
            code,
            op,
            v,
            dst,
            rd,
            ShiftCount::Imm(rhs_imm),
            alloc,
            frame,
        );
    }
    // Materialise the immediate into the reserved r11 scratch, then
    // stage `rd = lhs` (when rd != rn) before the two-operand op. r11
    // sits outside both allocator banks (`RegBanks::for_target`), so
    // it never aliases `rd` or `rn` and is always free under any
    // register pressure -- unlike a caller-saved pick, which a
    // saturated allocation can leave with no candidate.
    let scratch = SCRATCH_R11;
    super::x86_64::emit_mov_r_imm64(code, scratch, rhs_imm);
    if rd.0 != rn.0 {
        emit_mov_rr(code, rd, rn);
    }
    match op {
        BinOp::Add => emit_add_rr(code, rd, scratch),
        BinOp::Sub => emit_sub_rr(code, rd, scratch),
        BinOp::Mul => emit_imul_rr(code, rd, scratch),
        BinOp::And => emit_and_rr(code, rd, scratch),
        BinOp::Or => emit_or_rr(code, rd, scratch),
        BinOp::Xor => emit_xor_rr(code, rd, scratch),
        BinOp::Eq | BinOp::Ne | BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge => {
            emit_cmp_rr(code, rn, scratch);
            if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
                return true;
            }
            let cc = match op {
                BinOp::Eq => Cc::E,
                BinOp::Ne => Cc::Ne,
                BinOp::Lt => Cc::L,
                BinOp::Gt => Cc::G,
                BinOp::Le => Cc::Le,
                BinOp::Ge => Cc::Ge,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, rd);
            emit_movzx_r_r8(code, rd, rd);
        }
        BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge => {
            emit_cmp_rr(code, rn, scratch);
            if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
                return true;
            }
            let cc = match op {
                BinOp::Ult => Cc::B,
                BinOp::Ugt => Cc::A,
                BinOp::Ule => Cc::Be,
                BinOp::Uge => Cc::Ae,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, rd);
            emit_movzx_r_r8(code, rd, rd);
        }
        _ => {
            // Every representable integer `BinopI` op is covered above.
            // A new op variant reaching here is a producer/consumer
            // mismatch, not a register-pressure shape -- fail loudly.
            panic!("BinopI: unhandled integer op variant {op:?}");
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

#[allow(clippy::too_many_arguments)]
fn emit_call(
    code: &mut Vec<u8>,
    dst: Place,
    target_pc: usize,
    args: &[u32],
    fixed_args: usize,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    callee_is_variadic: bool,
    fp_return: bool,
    fp_arg_mask: u32,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    ret_agg: Option<u32>,
    ret_slot_local: i64,
    func: &FunctionSsa,
) -> bool {
    // Resolve the call's struct arguments once. With no tagged
    // aggregate this is empty and `plan_call_args_aggs` reduces to the
    // scalar `plan_call_args` placement, so every branch can run the
    // aggregate planner uniformly.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    if callee_is_variadic && abi.position_indexed_args {
        // Win64 host variadic ABI (Microsoft x64 calling convention):
        // the first four arguments (named and variadic) ride
        // rcx/rdx/r8/r9 by position, the rest the incoming stack at
        // 8-byte stride above the 32-byte home area. The c5-internal
        // variadic convention carries every argument as a raw 8-byte
        // integer value, so the walker widened the variadic
        // floating-point arguments to double and passed `fp_arg_mask`
        // 0; `plan_call_args` then routes every argument through the
        // integer side (position-indexed int registers, then stack).
        // This is the same marshal `emit_call_ext` performs for a
        // libc variadic call; Win64 sets `variadic_zero_xmm_count`
        // false, so no `al` is emitted. A by-value aggregate argument
        // the classifier tagged rides through `plan_call_args_aggs`.
        let plan =
            super::plan_call_args_aggs(args.len(), fixed_args, fp_arg_mask, abi, &aggs, false);
        if plan.scratch_bytes > 0 {
            emit_sub_rsp_imm32(code, plan.scratch_bytes);
        }
        if !marshal_args(code, &plan, args, alloc, frame, "Call (Win64 variadic)") {
            return false;
        }
        let call_site = code.len();
        fixups.push(Fixup {
            native_offset: call_site,
            target_ent_pc: target_pc,
            kind: super::x86_64::BranchKind::Call,
        });
        super::x86_64::emit_call_rel32(code, 0);
        if plan.scratch_bytes > 0 {
            emit_add_rsp_imm32(code, plan.scratch_bytes);
        }
        // A variadic callee may still return a <=16-byte aggregate by
        // value in rax:rdx; store it into the caller's result temp, as
        // the non-variadic path below does. Without this the struct
        // result is dropped (the scalar bridge leaves the slot unwritten).
        if let Some(ai) = ret_agg {
            let size = agg_descs[ai as usize].size;
            let base = local_slot_off(ret_slot_local, func, frame, abi);
            emit_mov_mem_r(code, Reg::RBP, base as i32, Reg::RAX);
            if size > 8 {
                emit_mov_mem_r(code, Reg::RBP, (base + 8) as i32, Reg::RDX);
            }
            return true;
        }
        // c5 internal call return convention: an integer / pointer
        // result lives in rax, a floating-point result in xmm0 (C99
        // 6.2.5p10).
        if fp_return {
            match dst {
                Place::FpReg(r) => {
                    if r != Reg::XMM0.0 {
                        emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
                    }
                }
                Place::Spill(_) => fp_spill_dst_to_slot(code, dst, Reg::XMM0, frame),
                Place::IntReg(r) => super::x86_64::emit_movq_r_xmm(code, Reg(r), Reg::XMM0),
                Place::None => {}
            }
        } else if let Some(rd) = int_or_spill_dst(dst) {
            if rd.0 != Reg::RAX.0 {
                emit_mov_rr(code, rd, Reg::RAX);
            }
            spill_dst_to_slot(code, dst, rd, frame);
        }
        return true;
    }
    if callee_is_variadic && abi.variadic_zero_xmm_count && !abi.position_indexed_args {
        // System V AMD64 host variadic ABI (Linux x86_64). The named
        // and variadic arguments ride the standard argument-register
        // banks (integer rdi.. + FP xmm0..) then overflow to the stack,
        // exactly like a libc variadic call (System V AMD64 3.2.3). The
        // walker passes the real `fp_arg_mask` (FP varargs ride
        // xmm0..xmm7), so `plan_call_args` places floating-point
        // arguments in the FP bank. `al` carries the number of XMM
        // argument registers used so the callee prologue's guarded XMM
        // save runs only when needed. A by-value aggregate argument the
        // classifier tagged (a 9-16 byte variadic struct spans two
        // eightbytes, all-or-nothing) rides through `plan_call_args_aggs`.
        let plan =
            super::plan_call_args_aggs(args.len(), fixed_args, fp_arg_mask, abi, &aggs, false);
        let xmm_used = plan
            .placements
            .iter()
            .filter(|p| matches!(p, super::ArgPlacement::FpReg(_)))
            .count() as u8;
        if plan.scratch_bytes > 0 {
            emit_sub_rsp_imm32(code, plan.scratch_bytes);
        }
        if !marshal_args(code, &plan, args, alloc, frame, "Call (SysV variadic)") {
            return false;
        }
        super::x86_64::emit_mov_al_imm8(code, xmm_used);
        let call_site = code.len();
        fixups.push(Fixup {
            native_offset: call_site,
            target_ent_pc: target_pc,
            kind: super::x86_64::BranchKind::Call,
        });
        super::x86_64::emit_call_rel32(code, 0);
        if plan.scratch_bytes > 0 {
            emit_add_rsp_imm32(code, plan.scratch_bytes);
        }
        // A variadic callee may still return a <=16-byte aggregate by
        // value in rax:rdx; store it into the caller's result temp, as
        // the non-variadic path below does. Without this the struct
        // result is dropped (the scalar bridge leaves the slot unwritten).
        if let Some(ai) = ret_agg {
            let size = agg_descs[ai as usize].size;
            let base = local_slot_off(ret_slot_local, func, frame, abi);
            emit_mov_mem_r(code, Reg::RBP, base as i32, Reg::RAX);
            if size > 8 {
                emit_mov_mem_r(code, Reg::RBP, (base + 8) as i32, Reg::RDX);
            }
            return true;
        }
        // c5 internal call return convention: an integer / pointer
        // result lives in rax, a floating-point result in xmm0 (C99
        // 6.2.5p10).
        if fp_return {
            match dst {
                Place::FpReg(r) => {
                    if r != Reg::XMM0.0 {
                        emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
                    }
                }
                Place::Spill(_) => fp_spill_dst_to_slot(code, dst, Reg::XMM0, frame),
                Place::IntReg(r) => super::x86_64::emit_movq_r_xmm(code, Reg(r), Reg::XMM0),
                Place::None => {}
            }
        } else if let Some(rd) = int_or_spill_dst(dst) {
            if rd.0 != Reg::RAX.0 {
                emit_mov_rr(code, rd, Reg::RAX);
            }
            spill_dst_to_slot(code, dst, rd, frame);
        }
        return true;
    }
    // Every x86_64 variadic callee is marshaled by a host-ABI branch
    // above: Win64 (`position_indexed_args`) or System V AMD64
    // (`variadic_zero_xmm_count`, no `position_indexed_args`). A variadic
    // callee reaching this point would fall through to the non-variadic
    // path and be marshaled without the host variadic register protocol,
    // a silent miscompile; fail the emit instead.
    if callee_is_variadic {
        bail_msg("Call: variadic callee not matched by a host-ABI branch");
        return false;
    }
    // c5-internal call convention: integer / pointer arguments ride
    // the integer argument-register bank, floating-point scalars ride
    // the FP bank (System V AMD64 3.2.3). The callee's prologue spills
    // each incoming register into its 16-byte c5 cdecl cell using the
    // same `plan_call_args` placement, so the int and FP banks stay
    // independent on both ends. `fp_arg_mask` comes from the
    // argument types (set by the walker) rather than register
    // placement, since a floating-point constant rides an integer
    // register as its `Imm` bit pattern.
    let plan = super::plan_call_args_aggs(args.len(), args.len(), fp_arg_mask, abi, &aggs, false);
    if plan.scratch_bytes > 0 {
        emit_sub_rsp_imm32(code, plan.scratch_bytes);
    }
    if !marshal_args(code, &plan, args, alloc, frame, "Call") {
        return false;
    }
    // Record a fixup for the call's rel32 field. `emit_call_rel32`
    // emits opcode 0xE8 then 4 bytes of rel32; `target_ent_pc`
    // resolves to the function's native offset in the post-pass.
    let call_site = code.len();
    fixups.push(Fixup {
        native_offset: call_site,
        target_ent_pc: target_pc,
        kind: super::x86_64::BranchKind::Call,
    });
    super::x86_64::emit_call_rel32(code, 0);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    // Host-ABI aggregate return (System V AMD64 3.2.3): a <= 16-byte
    // aggregate arrives in rax:rdx; store it into the caller's result
    // temp. (> 16-byte returns keep the out-pointer convention and
    // never set `ret_agg`.)
    if let Some(ai) = ret_agg {
        let desc = &agg_descs[ai as usize];
        let base = local_slot_off(ret_slot_local, func, frame, abi);
        let eb_classes = match super::abi_classify::classify_aggregate(
            desc.size,
            desc.align,
            &desc.fields,
            abi,
            true,
        ) {
            super::abi_classify::AggClass::Regs(c) => c,
            _ => alloc::vec::Vec::new(),
        };
        // SSE eightbytes arrive in xmm0/xmm1, INTEGER in rax/rdx; store each
        // into the caller's result temp at its eightbyte offset.
        let int_ret = [Reg::RAX, Reg::RDX];
        let mut int_i = 0usize;
        let mut sse_i = 0u8;
        for (k, class) in eb_classes.iter().enumerate() {
            let disp = (base + (k as i64) * 8) as i32;
            if matches!(class, super::abi_classify::RegClass::Sse) {
                emit_movsd_mem_xmm(code, Reg::RBP, disp, Reg(Reg::XMM0.0 + sse_i));
                sse_i += 1;
            } else {
                emit_mov_mem_r(code, Reg::RBP, disp, int_ret[int_i]);
                int_i += 1;
            }
        }
        return true;
    }
    // c5 internal call return convention: an integer / pointer
    // result lives in rax; a floating-point result lives in xmm0
    // (the callee's `Return` places it there per C99 6.2.5p10 and
    // the SysV / Win64 scalar-FP-return rule). `fp_return` selects
    // which register the result is read from for every dst kind,
    // including a spill slot.
    if fp_return {
        match dst {
            Place::FpReg(r) => {
                if r != Reg::XMM0.0 {
                    emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
                }
            }
            Place::Spill(_) => fp_spill_dst_to_slot(code, dst, Reg::XMM0, frame),
            Place::IntReg(r) => super::x86_64::emit_movq_r_xmm(code, Reg(r), Reg::XMM0),
            Place::None => {}
        }
    } else {
        match dst {
            Place::IntReg(r) => {
                if r != Reg::RAX.0 {
                    emit_mov_rr(code, Reg(r), Reg::RAX);
                }
            }
            Place::Spill(_) => spill_dst_to_slot(code, dst, Reg::RAX, frame),
            Place::FpReg(r) => super::x86_64::emit_movq_xmm_r(code, Reg(r), Reg::RAX),
            Place::None => {}
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
    frame: Frame,
    abi: super::Abi,
    target: Target,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    imports: &super::ResolvedImports,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
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
    // With no by-value struct argument this reduces to the scalar
    // `plan_call_args` placement; a tagged aggregate rides through the
    // host-ABI argument-register packing instead.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    let plan = super::plan_call_args_aggs(args.len(), fixed, fp_arg_mask, abi, &aggs, false);
    let xmm_used = plan
        .placements
        .iter()
        .filter(|p| matches!(p, super::ArgPlacement::FpReg(_)))
        .count() as u8;
    if plan.scratch_bytes > 0 {
        emit_sub_rsp_imm32(code, plan.scratch_bytes);
    }
    if !marshal_args(code, &plan, args, alloc, frame, "CallExt") {
        return false;
    }
    // System V AMD64 ABI 3.2.3: when the callee is variadic, `al`
    // must hold the number of XMM argument registers used (printf
    // and friends consult `al` in their prologue to decide whether
    // to spill xmm0..xmm7 into the va-save area). Non-variadic
    // SysV callees treat `al` as don't-care; zero it for
    // determinism. Win64 has no such requirement and clears
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
        is_addr: false,
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
        // A float / double result is FP-classed (`Inst::CallExt::fp_return`).
        // An f32 result is the single in the low 32 bits of xmm0 -- the same
        // form `FpCast(F64ToF32)` produces and `StoreLocal F32` /
        // `FpCast(F32ToF64)` consume -- so route it without widening. (The
        // prior GPR-bridged path widened via cvtss2sd because the
        // integer-class convention carried the f64-widened bits.)
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

#[allow(clippy::too_many_arguments)]
fn emit_call_indirect(
    code: &mut Vec<u8>,
    dst: Place,
    target: u32,
    args: &[u32],
    callee_variadic: bool,
    fixed_args: usize,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    fp_return: bool,
    fp_arg_mask: u32,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    ret_agg: Option<u32>,
    ret_slot_local: i64,
    func: &super::super::ir::FunctionSsa,
) -> bool {
    let target_place = alloc
        .places
        .get(target as usize)
        .copied()
        .unwrap_or(Place::None);
    // Collect every register `marshal_args` reads or writes for
    // this call; the staged target must avoid all of them.
    //
    //   * Arg SOURCES: the marshal reads each argument from its
    //     allocator placement. Staging the target over an arg
    //     source corrupts that arg before the marshal copies it.
    //   * Arg DESTINATIONS (`abi.int_arg_regs[0..n]`, e.g.
    //     rcx/rdx/r8/r9 on Win64, rdi/rsi/rdx/rcx/r8/r9 on SysV):
    //     the marshal writes each argument into its target arg
    //     register. Staging the target into an arg-destination
    //     register lets the marshal overwrite it before the
    //     `call`, sending control to the first argument's value.
    //   * SCRATCH_R10: the marshal's parallel-register-move scratch
    //     (`schedule_int_reg_moves`) and spill/stack staging
    //     register; it is clobbered mid-marshal.
    // A Win64 variadic indirect call (the pointed-to prototype is
    // variadic and the target is Win64) splits the arguments into the
    // named prefix and the variadic tail: the planner places the named
    // prefix per Win64 position-indexing and the variadic tail at
    // 8-byte stride past the home area (Microsoft x64 calling
    // convention). The walker widened the variadic floating-point
    // arguments to double and passed `fp_arg_mask` 0, so every argument
    // rides the integer side. Every other dialect (SysV, or a
    // non-variadic Win64 callee) treats all arguments as fixed, which
    // leaves `fixed = args.len()` and the placement unchanged.
    let fixed = if callee_variadic && abi.position_indexed_args {
        fixed_args.min(args.len())
    } else {
        args.len()
    };
    // A by-value aggregate argument the classifier tagged rides through
    // `plan_call_args_aggs`, which lays its eightbytes into the argument
    // registers / stack (System V AMD64 3.2.3); with no tagged aggregate
    // this reduces to the scalar placement.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    let plan = super::plan_call_args_aggs(args.len(), fixed, fp_arg_mask, abi, &aggs, false);
    // Collect every register `marshal_args` reads or writes for this
    // call; the staged target pointer must avoid all of them.
    //   * Arg SOURCES: each argument is read from its allocator
    //     placement; staging the target over a source corrupts it.
    //   * Arg DESTINATIONS: every integer register the plan writes -- a
    //     scalar `IntReg`, a by-reference base, or an aggregate's
    //     integer eightbytes -- is overwritten before the `call`.
    //   * SCRATCH_R10: the marshal's parallel-move / staging scratch.
    let mut blocked: alloc::vec::Vec<Reg> =
        alloc::vec::Vec::with_capacity(args.len() + abi.int_arg_regs.len() + 2);
    for &a in args {
        if let Some(Place::IntReg(r)) = alloc.places.get(a as usize) {
            blocked.push(Reg(*r));
        }
    }
    for p in &plan.placements {
        match p {
            super::ArgPlacement::IntReg(r) | super::ArgPlacement::StructByRefReg(r) => {
                blocked.push(Reg(*r));
            }
            super::ArgPlacement::StructRegs { regs, n } => {
                for cr in &regs[..*n as usize] {
                    if !cr.is_fp {
                        blocked.push(Reg(cr.reg));
                    }
                }
            }
            _ => {}
        }
    }
    blocked.push(SCRATCH_R10);
    // A System V variadic indirect call sets `al` to the XMM-argument
    // count just before the `call` (System V AMD64 3.2.3). The target
    // pointer must not be staged in rax, or the `mov al, imm8` would
    // corrupt its low byte; block rax for the target scratch.
    let sysv_variadic_call = callee_variadic && abi.sysv_host_variadic();
    if sysv_variadic_call {
        blocked.push(Reg::RAX);
    }
    // Capture the target pointer into a caller-saved scratch before arg
    // marshalling can clobber it. rax is the usual pick: no ABI assigns
    // it to an argument slot, so it is blocked only on a System V
    // variadic call (where it carries the XMM count). The pool excludes
    // the marshal's reserved scratch r10 / r11, so a pick never aliases
    // it. When everything is blocked the `else` branch below spills the
    // target to the stack.
    let target_scratch = pick_caller_saved_scratch(Reg(0xff), &blocked);
    // System V AMD64 3.2.3: a variadic call passes the XMM-argument
    // count in `al`. Computed from the plan and emitted after the
    // marshal (which never writes rax, blocked above for the target).
    let xmm_used = plan
        .placements
        .iter()
        .filter(|p| matches!(p, super::ArgPlacement::FpReg(_)))
        .count() as u8;
    if let Some(target_scratch) = target_scratch {
        // A free caller-saved register is available: stage the
        // target there, then marshal. The marshal never writes
        // `target_scratch` (it is neither an arg source nor r10).
        let target_r = match materialize_int(code, target_place, target_scratch, frame) {
            Some(r) => r,
            None => {
                bail_msg("CallIndirect: target not int reg / spill");
                return false;
            }
        };
        if target_r.0 != target_scratch.0 {
            emit_mov_rr(code, target_scratch, target_r);
        }
        if plan.scratch_bytes > 0 {
            emit_sub_rsp_imm32(code, plan.scratch_bytes);
        }
        if !marshal_args(code, &plan, args, alloc, frame, "CallIndirect") {
            return false;
        }
        if sysv_variadic_call {
            super::x86_64::emit_mov_al_imm8(code, xmm_used);
        }
        super::x86_64::emit_call_r(code, target_scratch);
        if plan.scratch_bytes > 0 {
            emit_add_rsp_imm32(code, plan.scratch_bytes);
        }
    } else {
        // Every caller-saved register is an arg source (and r10 is
        // reserved for the marshal). No register survives the
        // marshal, so spill the target to a fresh 16-byte stack
        // slot above the marshal's scratch window, marshal, then
        // reload into SCRATCH_R10 for the `call`. The 16-byte slot
        // keeps the call-site sp 16-aligned (SysV / Win64 require
        // 16-byte alignment at `call`).
        let target_r = match materialize_int(code, target_place, SCRATCH_R10, frame) {
            Some(r) => r,
            None => {
                bail_msg("CallIndirect: target not int reg / spill");
                return false;
            }
        };
        let slot_bytes = 16u32;
        emit_sub_rsp_imm32(code, slot_bytes);
        emit_mov_mem_r(code, Reg::RSP, 0, target_r);
        if plan.scratch_bytes > 0 {
            emit_sub_rsp_imm32(code, plan.scratch_bytes);
        }
        if !marshal_args(code, &plan, args, alloc, frame, "CallIndirect") {
            return false;
        }
        // The target slot sits just above the marshal's scratch
        // window, at [rsp + scratch_bytes] after the second sub.
        emit_mov_r_mem(code, SCRATCH_R10, Reg::RSP, plan.scratch_bytes as i32);
        if sysv_variadic_call {
            super::x86_64::emit_mov_al_imm8(code, xmm_used);
        }
        super::x86_64::emit_call_r(code, SCRATCH_R10);
        if plan.scratch_bytes > 0 {
            emit_add_rsp_imm32(code, plan.scratch_bytes);
        }
        emit_add_rsp_imm32(code, slot_bytes);
    }
    // Host-ABI aggregate return through a function pointer (System V
    // AMD64 3.2.3): a <= 16-byte aggregate arrives in rax:rdx; store it
    // into the caller's result temp. The walker tags `ret_agg` only for
    // the register-returned class, so > 16-byte (out-pointer) returns do
    // not reach here.
    if let Some(ai) = ret_agg {
        let desc = &agg_descs[ai as usize];
        let base = local_slot_off(ret_slot_local, func, frame, abi);
        let eb_classes = match super::abi_classify::classify_aggregate(
            desc.size,
            desc.align,
            &desc.fields,
            abi,
            true,
        ) {
            super::abi_classify::AggClass::Regs(c) => c,
            _ => alloc::vec::Vec::new(),
        };
        // SSE eightbytes arrive in xmm0/xmm1, INTEGER in rax/rdx; store each
        // into the caller's result temp at its eightbyte offset.
        let int_ret = [Reg::RAX, Reg::RDX];
        let mut int_i = 0usize;
        let mut sse_i = 0u8;
        for (k, class) in eb_classes.iter().enumerate() {
            let disp = (base + (k as i64) * 8) as i32;
            if matches!(class, super::abi_classify::RegClass::Sse) {
                emit_movsd_mem_xmm(code, Reg::RBP, disp, Reg(Reg::XMM0.0 + sse_i));
                sse_i += 1;
            } else {
                emit_mov_mem_r(code, Reg::RBP, disp, int_ret[int_i]);
                int_i += 1;
            }
        }
        return true;
    }
    // A floating-point return rides xmm0 (C99 6.2.5p10); an integer
    // / pointer return rides rax. `fp_return` selects the source for
    // every dst kind.
    if fp_return {
        match dst {
            Place::FpReg(r) => {
                if r != Reg::XMM0.0 {
                    emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
                }
            }
            Place::Spill(_) => fp_spill_dst_to_slot(code, dst, Reg::XMM0, frame),
            Place::IntReg(r) => super::x86_64::emit_movq_r_xmm(code, Reg(r), Reg::XMM0),
            Place::None => {}
        }
    } else {
        match dst {
            Place::IntReg(r) => {
                if r != Reg::RAX.0 {
                    emit_mov_rr(code, Reg(r), Reg::RAX);
                }
            }
            Place::Spill(_) => spill_dst_to_slot(code, dst, Reg::RAX, frame),
            Place::FpReg(r) => super::x86_64::emit_movq_xmm_r(code, Reg(r), Reg::RAX),
            Place::None => {}
        }
    }
    true
}

/// System V AMD64 `va_arg` (ABI 3.5.7). `args[0]` is the
/// `__va_list_tag` pointer; `args[1]` is the packed
/// `(kind << 16) | size` descriptor the parser folded as an
/// `Inst::Imm`. The intrinsic returns the address of the slot holding
/// the next argument (the `<stdarg.h>` macro dereferences it as the
/// requested type) and advances the matching offset / pointer in the
/// struct.
///
/// Integer / pointer (kind 0): if `gp_offset < 48` the value sits in
/// the register save area at `reg_save_area + gp_offset` and
/// `gp_offset` advances by 8; otherwise it sits in the overflow area
/// at `overflow_arg_area`, which advances by 8.
///
/// Floating-point (kind 1): if `fp_offset < 176` the value sits at
/// `reg_save_area + fp_offset` and `fp_offset` advances by 16;
/// otherwise it sits at `overflow_arg_area`, which advances by 8.
///
/// Struct layout (matching `<stdarg.h>` / libc): gp_offset at +0,
/// fp_offset at +4, overflow_arg_area at +8, reg_save_area at +16.
fn emit_va_arg_sysv(
    code: &mut Vec<u8>,
    args: &[u32],
    dst: Place,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if args.len() != 2 {
        bail_msg("VaArg: expected 2 args (ap, descriptor)");
        return false;
    }
    // Recover the packed descriptor from the `Inst::Imm` the parser
    // folded for the type operand.
    let descriptor = match func.insts.get(args[1] as usize) {
        Some(Inst::Imm(d)) => *d,
        _ => {
            bail_msg("VaArg: descriptor operand is not a constant");
            return false;
        }
    };
    let kind = (descriptor >> 16) & 0xffff;
    let is_fp = kind == 1;
    // Cursor pointer (struct address) held in r11, outside the
    // allocator's banks. The result address is computed in r10; both
    // are disjoint from the allocator-chosen `dst`.
    let ap_place = match alloc.places.get(args[0] as usize).copied() {
        Some(p) => p,
        None => {
            bail_msg("VaArg: &ap value id out of range");
            return false;
        }
    };
    let Some(ap) = materialize_int(code, ap_place, SCRATCH_R11, frame) else {
        bail_msg("VaArg: &ap not in int reg / spill");
        return false;
    };
    // r11 must hold the struct pointer across the whole sequence; if
    // `materialize_int` returned an allocator register, move it into r11
    // so the offset writebacks don't clobber a live value.
    let ap = if ap.0 != SCRATCH_R11.0 {
        emit_mov_rr(code, SCRATCH_R11, ap);
        SCRATCH_R11
    } else {
        ap
    };
    // A by-value integer-class aggregate spans `ceil(size/8)` eightbytes
    // in consecutive gp save-area slots (System V AMD64 3.5.7); it rides
    // the register save area only if all its eightbytes fit
    // (`gp_offset + aligned <= 48`), else the whole aggregate sits in the
    // overflow area. A scalar's aligned size is 8, leaving the bound and
    // step at their single-eightbyte values. Floating-point arguments are
    // single doubles (the classifier declines HFAs), so they keep the
    // 16-byte fp-slot step and 176-byte bound.
    let aligned = (((descriptor & 0xffff) as i32 + 7) & !7).max(8);
    let (off_disp, bound, step): (i32, i32, i32) = if is_fp {
        (4, 176, 16)
    } else {
        (0, 48 - (aligned - 8), aligned)
    };
    // r10 = current offset (gp_offset or fp_offset, a u32 field; the
    // 32-bit load zero-extends into r10). The whole sequence touches
    // only r10 and r11 -- both reserved outside the allocator's banks --
    // plus the in-memory va_list fields, so it never clobbers a live
    // allocator value (the consuming `t += va_arg(...)` keeps `t` in an
    // allocator register that an earlier draft overwrote via rcx).
    super::x86_64::emit_mov_r32_mem(code, SCRATCH_R10, ap, off_disp);
    // cmp r10d, bound ; jae use_overflow
    super::x86_64::emit_cmp_r_imm32(code, SCRATCH_R10, bound);
    super::x86_64::emit_jcc_rel32(code, Cc::Ae, 0);
    let jae_rel32_at = code.len() - 4;
    // --- register-save path ---
    // r10 = offset + reg_save_area (at [ap + 16]) = the argument slot,
    // then bump the offset field in memory by step.
    super::x86_64::emit_add_r_mem(code, SCRATCH_R10, ap, 16);
    super::x86_64::emit_add_mem32_imm32(code, ap, off_disp, step);
    // jmp done
    super::x86_64::emit_jmp_rel32(code, 0);
    let jmp_rel32_at = code.len() - 4;
    // --- overflow path ---
    let overflow_start = code.len();
    let rel_to_overflow = (overflow_start - (jae_rel32_at + 4)) as i32;
    code[jae_rel32_at..jae_rel32_at + 4].copy_from_slice(&rel_to_overflow.to_le_bytes());
    // r10 = overflow_arg_area (at [ap + 8]) = the argument slot, then
    // bump it in memory by the argument's eightbyte span. System V AMD64
    // 3.5.7 rounds each overflow argument to an eightbyte; a scalar or a
    // `double` occupies one, a by-value aggregate `ceil(size/8)`.
    let ov_step = if is_fp { 8 } else { aligned };
    emit_mov_r_mem(code, SCRATCH_R10, ap, 8);
    super::x86_64::emit_add_mem64_imm32(code, ap, 8, ov_step);
    // --- done: r10 holds the argument address; deliver it to dst. ---
    let done = code.len();
    let rel_to_done = (done - (jmp_rel32_at + 4)) as i32;
    code[jmp_rel32_at..jmp_rel32_at + 4].copy_from_slice(&rel_to_done.to_le_bytes());
    match dst {
        Place::IntReg(r) => {
            if Reg(r).0 != SCRATCH_R10.0 {
                emit_mov_rr(code, Reg(r), SCRATCH_R10);
            }
        }
        Place::Spill(_) => spill_dst_to_slot(code, dst, SCRATCH_R10, frame),
        Place::FpReg(r) => super::x86_64::emit_movq_xmm_r(code, Reg(r), SCRATCH_R10),
        Place::None => {}
    }
    true
}

fn emit_intrinsic(
    code: &mut Vec<u8>,
    kind: i64,
    args: &[u32],
    dst: Place,
    v: super::super::ir::ValueId,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    current_alloca_top: u32,
) -> bool {
    use crate::c5::op::Intrinsic as I;
    // Byte stride between adjacent variadic arguments in the cursor
    // va_list. System V AMD64 routes its variadic intrinsics through the
    // register-save-area arms below (gated on `sysv_host_variadic`), so
    // the only x86_64 target reaching the cursor arms is Win64 (Microsoft
    // x64 calling convention), which packs the variadic tail at 8-byte
    // stride in the home area + incoming stack.
    let va_stride: i32 = 8;
    let intrinsic = match I::from_i64(kind) {
        Some(i) => i,
        None => {
            bail_msg("intrinsic: unknown discriminant");
            return false;
        }
    };
    match intrinsic {
        I::VaStart if sysv_variadic_callee(func, abi) => {
            // System V AMD64 `va_start` (ABI 3.5.7). args[0] = the
            // `__va_list_tag` pointer (the array-form `va_list` decayed
            // to `&ap[0]`), args[1] = &last (unused -- the named-argument
            // counts come from the prototype, not the last named
            // argument's address). Initialise the struct:
            //   gp_offset        = num_named_int * 8
            //   fp_offset        = 48 + num_named_fp * 16
            //   overflow_arg_area = first incoming stack argument
            //   reg_save_area     = base of the prologue-spilled area
            if args.len() != 2 {
                bail_msg("VaStart: expected 2 args");
                return false;
            }
            // Named integer / FP argument counts from the prototype:
            // `param_fp_mask` bit i set means named parameter i is
            // floating-point. The gp area skips the named integer
            // arguments (each 8 bytes); the fp area starts at offset 48
            // and skips the named FP arguments (each 16 bytes).
            let n = func.n_params;
            let mut named_int = 0u32;
            let mut named_fp = 0u32;
            for i in 0..n {
                if (func.param_fp_mask & (1u32 << i)) != 0 {
                    named_fp += 1;
                } else {
                    named_int += 1;
                }
            }
            // gp_offset / fp_offset index the next argument register the
            // save area holds; they saturate at the bank size (six GP, eight
            // FP) so a callee whose named parameters fill or overflow a bank
            // sends `va_arg` straight to the overflow area.
            let gp_offset = named_int.min(6) * 8;
            let fp_offset = SYSV_GP_SAVE_BYTES + named_fp.min(8) * 16;
            let ap_place = match alloc.places.get(args[0] as usize).copied() {
                Some(p) => p,
                None => {
                    bail_msg("VaStart: &ap value id out of range");
                    return false;
                }
            };
            let Some(ap) = materialize_int(code, ap_place, SCRATCH_R11, frame) else {
                bail_msg("VaStart: &ap not in int reg / spill");
                return false;
            };
            // gp_offset (u32) at [ap + 0], fp_offset (u32) at [ap + 4].
            super::x86_64::emit_mov_mem32_imm32(code, ap, 0, gp_offset as i32);
            super::x86_64::emit_mov_mem32_imm32(code, ap, 4, fp_offset as i32);
            // overflow_arg_area (ptr) at [ap + 8] = first variadic stack
            // argument. Incoming stack arguments sit just above the return
            // address at [rbp + 16]; the named parameters that overflowed
            // the argument registers occupy the low slots there, so the
            // variadic tail begins past them.
            let named_stack_bytes: i32 = super::plan_param_regs(n, func.param_fp_mask, abi)
                .placements
                .iter()
                .filter(|q| matches!(q, super::ArgPlacement::Stack(_)))
                .count() as i32
                * 8;
            emit_lea_r_mem(code, SCRATCH_R10, Reg::RBP, 16 + named_stack_bytes);
            emit_mov_mem_r(code, ap, 8, SCRATCH_R10);
            // reg_save_area (ptr) at [ap + 16] = base of the spilled gp
            // area.
            emit_lea_r_mem(code, SCRATCH_R10, Reg::RBP, frame.va_reg_save_off);
            emit_mov_mem_r(code, ap, 16, SCRATCH_R10);
            true
        }
        // The System V `va_list` is a `__va_list_tag` struct on this
        // target, so `va_arg` walks the gp/fp save areas regardless of
        // whether the current function is itself variadic: a non-
        // variadic forwarder (the `c5_v*printf` shims) receives a
        // forwarded `va_list` and must read it the same way. Gate on the
        // target ABI, not `func.is_variadic`.
        I::VaArg if abi.sysv_host_variadic() => {
            emit_va_arg_sysv(code, args, dst, func, alloc, frame)
        }
        I::VaCopy if abi.sysv_host_variadic() => {
            // System V `va_copy` is a 24-byte `__va_list_tag` struct copy
            // (ABI 3.5.7). args[0] = &dst struct, args[1] = &src struct.
            if args.len() != 2 {
                bail_msg("VaCopy: expected 2 args");
                return false;
            }
            let src_place = match alloc.places.get(args[1] as usize).copied() {
                Some(p) => p,
                None => {
                    bail_msg("VaCopy: &src value id out of range");
                    return false;
                }
            };
            let Some(src_p) = materialize_int(code, src_place, SCRATCH_R11, frame) else {
                bail_msg("VaCopy: &src not in int reg / spill");
                return false;
            };
            let dst_place = match alloc.places.get(args[0] as usize).copied() {
                Some(p) => p,
                None => {
                    bail_msg("VaCopy: &dst value id out of range");
                    return false;
                }
            };
            // Three distinct registers: src pointer in r11, dst pointer
            // in rcx, the copied word in r10 (all outside the allocator's
            // live values for this instruction). Copy the three 8-byte
            // words -- gp_offset + fp_offset packed in the first, then
            // overflow_arg_area and reg_save_area.
            let Some(dst_p) = materialize_int(code, dst_place, SCRATCH_RCX, frame) else {
                bail_msg("VaCopy: &dst not in int reg / spill");
                return false;
            };
            for off in [0i32, 8, 16] {
                emit_mov_r_mem(code, SCRATCH_R10, src_p, off);
                emit_mov_mem_r(code, dst_p, off, SCRATCH_R10);
            }
            true
        }
        I::VaStart => {
            // __builtin_va_start(&ap, &last). args[0] = &ap,
            // args[1] = &last. *ap = &last + va_stride, the address of
            // the first variadic slot one stride past the last named
            // parameter. System V routes its `va_start` through the
            // register-save-area arm above, so only the Win64 host
            // variadic ABI reaches here: it lays named and variadic
            // arguments at 8-byte stride (named register arguments
            // spilled by the prologue into the home area, the variadic
            // tail on the incoming stack). va_start runs only in the
            // variadic function itself, whose named parameters already
            // use `va_stride` (`Frame::param_cell_stride`), so
            // `&last + va_stride` lands on the first variadic argument.
            if args.len() != 2 {
                bail_msg("VaStart: expected 2 args");
                return false;
            }
            // Both pointer operands can land in spill slots under
            // register pressure, so materialize each into a reserved
            // scratch. r10 / r11 sit outside both allocator banks, so
            // they never alias an allocator-chosen `ap` / `last`. The
            // `last + va_stride` advance reuses the `last` register, so
            // the peak register need is two.
            let ap_place = match alloc.places.get(args[0] as usize).copied() {
                Some(p) => p,
                None => {
                    bail_msg("VaStart: &ap value id out of range");
                    return false;
                }
            };
            let last_place = match alloc.places.get(args[1] as usize).copied() {
                Some(p) => p,
                None => {
                    bail_msg("VaStart: &last value id out of range");
                    return false;
                }
            };
            let Some(ap) = materialize_int(code, ap_place, SCRATCH_R11, frame) else {
                bail_msg("VaStart: &ap not in int reg / spill");
                return false;
            };
            let Some(last) = materialize_int(code, last_place, SCRATCH_R10, frame) else {
                bail_msg("VaStart: &last not in int reg / spill");
                return false;
            };
            // advance = last + va_stride ; mov [ap], advance. When
            // `last` is an allocator register it may still be live after
            // VaStart, so the advance lands in r10 rather than
            // clobbering it; when `last` was spilled it already sits in
            // the throwaway r10 copy, which is reused. r10 is outside
            // both pools, so it never aliases `ap` or the
            // allocator-chosen `last`.
            let advance = SCRATCH_R10;
            emit_lea_r_mem(code, advance, last, va_stride);
            emit_mov_mem_r(code, ap, 0, advance);
            true
        }
        I::VaArg => {
            // Returns *ap, advances *ap by va_stride. args[0] = &ap.
            // args[1] (when present) is the packed type descriptor; the
            // Win64 / cursor single-region walk ignores the kind, so only
            // args[0] is read.
            if args.is_empty() {
                bail_msg("VaArg: expected at least the ap argument");
                return false;
            }
            // The cursor address `ap`, the loaded result, and the
            // advance temporary must each occupy a distinct register so
            // the writeback stores through the cursor rather than through
            // the just-loaded value. Both the `&ap` operand and the
            // result can land in spill slots under register pressure, and
            // the allocator may even pick the same physical register for
            // the result and `&ap`. r10 / r11 sit outside both allocator
            // banks, so they never alias an allocator-chosen place; the
            // cursor is held in r11 (forced there whenever it would
            // otherwise alias the work register), the value is loaded
            // into a work register, the advance into r10, and the value
            // is then delivered to the destination.
            let ap_place = match alloc.places.get(args[0] as usize).copied() {
                Some(p) => p,
                None => {
                    bail_msg("VaArg: &ap value id out of range");
                    return false;
                }
            };
            // Cursor address. A spilled `&ap` loads into r11; a register
            // operand is moved into r11 when it would alias the work
            // register so the load can't clobber it.
            let ap = match ap_place {
                Place::IntReg(r) => {
                    let work_aliases = match dst {
                        Place::IntReg(d) => d == r,
                        _ => false,
                    };
                    if work_aliases {
                        emit_mov_rr(code, SCRATCH_R11, Reg(r));
                        SCRATCH_R11
                    } else {
                        Reg(r)
                    }
                }
                Place::Spill(slot) => {
                    let sp_off = spill_slot_sp_offset(frame, slot);
                    emit_mov_r_mem(code, SCRATCH_R11, Reg::RSP, sp_off);
                    SCRATCH_R11
                }
                _ => {
                    bail_msg("VaArg: &ap not in int reg / spill");
                    return false;
                }
            };
            // Work register holding the loaded result: the destination
            // register when distinct from the cursor, otherwise r10. The
            // cursor was forced to r11 above whenever the destination
            // register aliased it, so `work` here never equals `ap`.
            let work = match dst {
                Place::IntReg(d) if Reg(d).0 != ap.0 => Reg(d),
                _ => SCRATCH_R10,
            };
            // work = *ap (old cursor) ; r10 = work + va_stride ; *ap =
            // r10. r10 is the advance temporary; it differs from `ap`
            // (r11 or an allocator reg) and from `work` (only r10 when
            // the dst is spilled, in which case `work` is dead after the
            // store back).
            emit_mov_r_mem(code, work, ap, 0);
            let advance = SCRATCH_R10;
            if advance.0 == work.0 {
                // Destination spilled: store the result before reusing
                // r10 for the advance.
                spill_dst_to_slot(code, dst, work, frame);
                emit_lea_r_mem(code, advance, work, va_stride);
                emit_mov_mem_r(code, ap, 0, advance);
            } else {
                emit_lea_r_mem(code, advance, work, va_stride);
                emit_mov_mem_r(code, ap, 0, advance);
                spill_dst_to_slot(code, dst, work, frame);
            }
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
            // Both pointer operands can land in spill slots under
            // register pressure. Load the source value into r10 before
            // materializing the destination pointer, so r11 can hold the
            // source pointer and then be reused for the destination
            // pointer -- the peak register need is two. r10 / r11 sit
            // outside both allocator banks, so they never alias an
            // allocator-chosen place.
            let dst_place = match alloc.places.get(args[0] as usize).copied() {
                Some(p) => p,
                None => {
                    bail_msg("VaCopy: &dst value id out of range");
                    return false;
                }
            };
            let src_place = match alloc.places.get(args[1] as usize).copied() {
                Some(p) => p,
                None => {
                    bail_msg("VaCopy: &src value id out of range");
                    return false;
                }
            };
            let Some(src_p) = materialize_int(code, src_place, SCRATCH_R11, frame) else {
                bail_msg("VaCopy: &src not in int reg / spill");
                return false;
            };
            let scratch = SCRATCH_R10;
            emit_mov_r_mem(code, scratch, src_p, 0);
            let Some(dst_p) = materialize_int(code, dst_place, SCRATCH_R11, frame) else {
                bail_msg("VaCopy: &dst not in int reg / spill");
                return false;
            };
            emit_mov_mem_r(code, dst_p, 0, scratch);
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
            // The op needs three working registers (size, bookkeeping
            // address, and the result it writes back) all distinct.
            // r11 carries the bookkeeping address and rd_phys carries
            // the result; both are reserved outside the allocator banks
            // (rd_phys is rd for a register dst, else r10 for a spill
            // dst). The size register must be disjoint from those two.
            // r10 covers the register-dst case; the spill-dst case
            // already used r10 for rd_phys, so the size lands in rcx,
            // preserved with push / pop (rcx is in the caller-saved
            // pool). The body issues no call, so the transient 8-byte
            // misalignment is irrelevant.
            let addr_reg = SCRATCH_R11;
            let rd_phys = if matches!(dst, Place::Spill(_)) {
                SCRATCH_R10
            } else {
                rd
            };
            let size_reg = if rd_phys.0 == SCRATCH_R10.0 {
                Reg::RCX
            } else {
                SCRATCH_R10
            };
            let preserve_size_reg = size_reg.0 == Reg::RCX.0;
            if preserve_size_reg {
                emit_push_r(code, size_reg);
            }
            // After a `push` the spill slots sit 8 bytes higher
            // relative to rsp, so a spilled size is read through the
            // shifted offset (mirrors the divmod `DivOperand::Mem`
            // adjustment); register / immediate sizes are unaffected.
            let n = match size_place {
                Place::Spill(slot) if preserve_size_reg => {
                    let off = spill_slot_sp_offset(frame, slot) + 8;
                    emit_mov_r_mem(code, size_reg, Reg::RSP, off);
                    size_reg
                }
                _ => match materialize_int(code, size_place, size_reg, frame) {
                    Some(r) => r,
                    None => {
                        bail_msg("Alloca: size not int reg / spill / fp");
                        return false;
                    }
                },
            };
            if n.0 != size_reg.0 {
                emit_mov_rr(code, size_reg, n);
            }
            super::x86_64::emit_add_r_imm32(code, size_reg, 15);
            super::x86_64::emit_and_r_imm32(code, size_reg, -16);
            let disp = -(current_alloca_top as i32);
            emit_lea_r_mem(code, addr_reg, Reg::RBP, disp);
            emit_mov_r_mem(code, rd_phys, addr_reg, 0);
            super::x86_64::emit_sub_rr(code, rd_phys, size_reg);
            // Trap on arena underflow: a bumped pointer below the
            // per-frame arena floor (addr_reg - ALLOCA_ARENA_SLOTS*8)
            // would scribble the saved-register area, so fault
            // deterministically rather than corrupt the stack. TODO:
            // lower alloca to a real SP decrement for unbounded sizes.
            let arena_bytes = (crate::c5::op::ALLOCA_ARENA_SLOTS * 8) as i32;
            emit_lea_r_mem(code, size_reg, addr_reg, -arena_bytes);
            super::x86_64::emit_cmp_rr(code, rd_phys, size_reg);
            super::x86_64::emit_jcc_rel8(code, super::x86_64::Cc::Ae, 2);
            code.push(0x0F);
            code.push(0x0B); // ud2
            emit_mov_mem_r(code, addr_reg, 0, rd_phys);
            if preserve_size_reg {
                emit_pop_r(code, size_reg);
            }
            spill_dst_to_slot(code, dst, rd_phys, frame);
            true
        }
        I::SetjmpAArch64 | I::LongjmpAArch64 => {
            bail_msg("intrinsic: AArch64 setjmp / longjmp on non-AArch64 target");
            false
        }
        // fma / fmaf lower to Inst::Fma at the call site, so they never
        // reach the Inst::Intrinsic dispatch.
        I::Fma | I::Fmaf => {
            bail_msg("intrinsic: fma / fmaf lower to Inst::Fma, not Inst::Intrinsic");
            false
        }
        I::Trap => {
            // `ud2` (0F 0B) raises #UD (illegal instruction). Execution
            // does not continue past it.
            code.push(0x0F);
            code.push(0x0B);
            true
        }
        I::CpuRelax => {
            // `pause` (F3 90), the x86-64 spin-loop hint.
            code.push(0xF3);
            code.push(0x90);
            true
        }
        I::X87StoreControlWord | I::X87LoadControlWord => {
            // `fnstcw m16` (D9 /7) stores the x87 control word, `fldcw m16`
            // (D9 /5) loads it. The single argument is the operand's
            // address; force it into r10 so the ModRM byte needs no
            // SIB / displacement (r10 = rm 010 under REX.B).
            if args.len() != 1 {
                bail_msg("x87 control word intrinsic expects 1 arg");
                return false;
            }
            let Some(place) = alloc.places.get(args[0] as usize).copied() else {
                bail_msg("x87 control word intrinsic: arg place missing");
                return false;
            };
            let Some(addr) = materialize_int(code, place, SCRATCH_R10, frame) else {
                bail_msg("x87 control word intrinsic: arg not an int register");
                return false;
            };
            if addr.0 != SCRATCH_R10.0 {
                super::x86_64::emit_mov_rr(code, SCRATCH_R10, addr);
            }
            let reg_field: u8 = if matches!(intrinsic, I::X87StoreControlWord) {
                7
            } else {
                5
            };
            code.push(0x41); // REX.B for r10
            code.push(0xD9);
            code.push((reg_field << 3) | 0x02); // mod=00, reg=field, rm=r10
            true
        }
        I::Sqrt
        | I::Sqrtf
        | I::Fabs
        | I::Fabsf
        | I::Floor
        | I::Floorf
        | I::Ceil
        | I::Ceilf
        | I::Trunc
        | I::Truncf => {
            if args.len() != 1 {
                bail_msg("unary FP intrinsic: expected 1 arg");
                return false;
            }
            emit_fp_unary(code, dst, v, args[0], intrinsic, alloc, frame)
        }
        I::FrameAddress => {
            // __builtin_frame_address(0): the current frame pointer (rbp).
            // The level argument is ignored; only level 0 is supported.
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("FrameAddress: dst not int reg / spill");
                return false;
            };
            emit_mov_rr(code, rd, Reg::RBP);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        I::Clz
        | I::Ctz
        | I::Popcount
        | I::Clzll
        | I::Ctzll
        | I::Popcountll
        | I::Bswap16
        | I::Bswap32
        | I::Bswap64 => {
            // The integer bit-count and byte-swap builtins are lowered to a
            // portable shift / mask sequence in the walker; they never reach
            // codegen as an `Inst::Intrinsic`.
            bail_msg("intrinsic: bit builtin reached codegen");
            false
        }
        I::AtomicLoad
        | I::AtomicStore
        | I::AtomicExchange
        | I::AtomicFetchAdd
        | I::AtomicFetchSub
        | I::AtomicFetchAnd
        | I::AtomicFetchOr
        | I::AtomicFetchXor
        | I::AtomicCompareExchangeStrong => {
            // C11 atomic operations are lowered to load / store /
            // read-modify-write at the call site; they never reach
            // codegen as an `Inst::Intrinsic`.
            bail_msg("intrinsic: atomic op reached codegen");
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
    target_ent_pc: usize,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("ImmCode: dst not int reg / spill");
        return false;
    };
    let instr_offset = code.len();
    pending_func_fixups.push((instr_offset, target_ent_pc));
    super::x86_64::emit_lea_r_rip32(code, rd, 0);
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// `Inst::ImmExtCode` -- `lea rd, [rip+disp32]` taking the
/// address of a dynamically-imported function. The disp32 resolves
/// to the import's shared stub (the same `jmp [GOT]` a call to the
/// import reaches), so `&strcmp` yields the stub address. Records an
/// `is_addr` PLT-call fixup at the `lea`'s instruction offset; the
/// disp32 sits three bytes in (REX + opcode + modrm).
fn emit_imm_ext_code(
    code: &mut Vec<u8>,
    dst: Place,
    binding_idx: i64,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    imports: &super::ResolvedImports,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("ImmExtCode: dst not int reg / spill");
        return false;
    };
    let import_index = match imports.index_of_binding(binding_idx) {
        Some(i) => i,
        None => {
            bail_msg("ImmExtCode: binding index has no resolved import");
            return false;
        }
    };
    plt_call_fixups.push(PltCallFixup {
        instr_offset: code.len(),
        import_index,
        is_tail: false,
        is_addr: true,
    });
    super::x86_64::emit_lea_r_rip32(code, rd, 0);
    spill_dst_to_slot(code, dst, rd, frame);
    true
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
    // Materialise both bases into reserved scratches. SCRATCH_R10 and
    // SCRATCH_R11 sit outside both allocator pools, so loading a base
    // into either cannot clobber a live SSA value. rcx must not be used
    // here: it is in the LinuxX64 `caller_gprs` pool, so under raised
    // register pressure the allocator parks SSA values there (e.g. a
    // `context` pointer threaded into a later call argument), and a
    // materialise into rcx would overwrite that value.
    let Some(dst_r) = materialize_int(code, dst_in, SCRATCH_R10, frame) else {
        bail_msg("Mcpy: dst base not int reg / spill");
        return false;
    };
    let src_scratch = if dst_r.0 == SCRATCH_R10.0 {
        SCRATCH_R11
    } else {
        SCRATCH_R10
    };
    let Some(src_r) = materialize_int(code, src_in, src_scratch, frame) else {
        bail_msg("Mcpy: src base not int reg / spill");
        return false;
    };
    // Pick a per-iteration temp distinct from both bases, then save /
    // restore it across the copy. rax, rcx and rdx are in the
    // allocator's caller_gprs pool, so the prologue may have parked a
    // live value in the chosen one; a push/pop pair around the loop
    // preserves it. (r10 / r11 are the bases' reserved scratch and are
    // not candidates here.)
    let temp = if dst_r.0 != Reg::RAX.0 && src_r.0 != Reg::RAX.0 {
        Reg::RAX
    } else if dst_r.0 != Reg::RCX.0 && src_r.0 != Reg::RCX.0 {
        Reg::RCX
    } else {
        // rax and rcx are taken by the bases (one of which may sit in
        // r10 / r11); fall back to rdx, also in the caller pool.
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

/// Write the result `src` of an atomic op into the inst's `dst`
/// `Place`. Runs after the borrowed registers are restored so the
/// spill slot's rsp offset is the unshifted one.
fn write_atomic_result(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    match dst {
        Place::IntReg(r) if r != src.0 => emit_mov_rr(code, Reg(r), src),
        Place::Spill(_) => spill_dst_to_slot(code, dst, src, frame),
        _ => {}
    }
}

/// Load the low `width` bytes of `[base]` into `dst`, zero-extended. A
/// width-sized access is required so the atomic object's footprint is
/// not over-read past its end (a 1/2/4-byte `_Atomic` may sit at a page
/// boundary) and so the prior value carries no high-byte residue.
fn emit_atomic_load(code: &mut Vec<u8>, dst: Reg, base: Reg, width: u8) {
    match width {
        1 => super::x86_64::emit_movzx_r_mem8(code, dst, base, 0),
        2 => super::x86_64::emit_movzx_r_mem16(code, dst, base, 0),
        4 => super::x86_64::emit_mov_r32_mem(code, dst, base, 0),
        _ => emit_mov_r_mem(code, dst, base, 0),
    }
}

/// Store the low `width` bytes of `src` to `[base]`; the companion to
/// [`emit_atomic_load`] for the compare-exchange expected-operand writeback.
fn emit_atomic_store(code: &mut Vec<u8>, base: Reg, src: Reg, width: u8) {
    match width {
        1 => super::x86_64::emit_mov_mem_r8(code, base, 0, src),
        2 => super::x86_64::emit_mov_mem_r16(code, base, 0, src),
        4 => super::x86_64::emit_mov_mem_r32(code, base, 0, src),
        _ => emit_mov_mem_r(code, base, 0, src),
    }
}

/// Force an operand's value into a designated scratch register. The
/// operand may already sit in its allocator register; `materialize`
/// returns that register, and we copy it into `scratch` so the
/// caller can clobber the source register afterwards. `sp_shift`
/// accounts for the borrowed registers already pushed.
fn operand_into(
    code: &mut Vec<u8>,
    value: super::super::ir::ValueId,
    scratch: Reg,
    frame: Frame,
    sp_shift: u32,
    alloc: &Allocation,
) -> Option<Reg> {
    let place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let r = materialize_int_shifted(code, place, scratch, frame, sp_shift)?;
    if r.0 != scratch.0 {
        emit_mov_rr(code, scratch, r);
    }
    Some(scratch)
}

/// C11 7.17.7.2-7.17.7.5 atomic read-modify-write. Lowers to a genuine
/// atomic instruction (Intel SDM Vol.2): `XCHG` for exchange, `LOCK
/// XADD` for add / sub (negating the operand for sub), and a `LOCK
/// CMPXCHG` retry loop for the bitwise operators (x86 has no
/// fetch-and-return-old form for AND / OR / XOR). The defined value is
/// the object's prior contents. The address rides SCRATCH_R11 and the
/// operand SCRATCH_R10, both outside the allocator's register banks;
/// RAX and a loop temp are borrowed via push / pop so a value the
/// allocator parked there survives.
#[allow(clippy::too_many_arguments)]
fn emit_atomic_rmw(
    code: &mut Vec<u8>,
    dst: Place,
    op: super::super::ir::AtomicRmwOp,
    addr: super::super::ir::ValueId,
    value: super::super::ir::ValueId,
    width: u8,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    use super::super::ir::AtomicRmwOp as Op;
    let a = SCRATCH_R11;
    let val = SCRATCH_R10;
    match op {
        Op::Xchg => {
            // No RAX involved: XCHG with a memory operand is implicitly
            // locked. Operands ride the reserved scratches; rsp stable.
            if operand_into(code, addr, a, frame, 0, alloc).is_none()
                || operand_into(code, value, val, frame, 0, alloc).is_none()
            {
                bail_msg("AtomicRmw: operand not int reg / spill");
                return false;
            }
            emit_xchg_mem_r(code, a, 0, val, width);
            write_atomic_result(code, dst, val, frame);
            true
        }
        Op::Add | Op::Sub => {
            emit_push_r(code, Reg::RAX);
            if operand_into(code, addr, a, frame, 8, alloc).is_none()
                || operand_into(code, value, val, frame, 8, alloc).is_none()
            {
                bail_msg("AtomicRmw: operand not int reg / spill");
                return false;
            }
            emit_mov_rr(code, Reg::RAX, val);
            if matches!(op, Op::Sub) {
                emit_neg_r(code, Reg::RAX);
            }
            emit_lock_xadd_mem_r(code, a, 0, Reg::RAX, width);
            // RAX now holds the prior contents; stash it before the pop.
            emit_mov_rr(code, val, Reg::RAX);
            emit_pop_r(code, Reg::RAX);
            write_atomic_result(code, dst, val, frame);
            true
        }
        Op::And | Op::Or | Op::Xor => {
            // CMPXCHG retry: load the current value into RAX, compute the
            // new value in a temp, and conditionally publish it; repeat
            // until the store succeeds (ZF set by CMPXCHG).
            let temp = Reg::RCX;
            emit_push_r(code, Reg::RAX);
            emit_push_r(code, temp);
            if operand_into(code, addr, a, frame, 16, alloc).is_none()
                || operand_into(code, value, val, frame, 16, alloc).is_none()
            {
                bail_msg("AtomicRmw: operand not int reg / spill");
                return false;
            }
            emit_atomic_load(code, Reg::RAX, a, width);
            let loop_start = code.len();
            emit_mov_rr(code, temp, Reg::RAX);
            match op {
                Op::And => emit_and_rr(code, temp, val),
                Op::Or => emit_or_rr(code, temp, val),
                Op::Xor => emit_xor_rr(code, temp, val),
                _ => unreachable!(),
            }
            emit_lock_cmpxchg_mem_r(code, a, 0, temp, width);
            // Branch back when the store lost the race (ZF == 0). The
            // rel8 field is measured from the byte after the 2-byte Jcc.
            let rel = (loop_start as i64) - (code.len() as i64 + 2);
            emit_jcc_rel8(code, Cc::Ne, rel as i8);
            emit_mov_rr(code, val, Reg::RAX);
            emit_pop_r(code, temp);
            emit_pop_r(code, Reg::RAX);
            write_atomic_result(code, dst, val, frame);
            true
        }
    }
}

/// C11 7.17.7.4 atomic compare-and-exchange. Lowers to `LOCK CMPXCHG`
/// (Intel SDM Vol.2): RAX is loaded with `*expected`; on a match the
/// store publishes `desired` and the result is 1, otherwise the
/// current contents are written back into `*expected` and the result
/// is 0. The success flag is read from the CMPXCHG ZF (a `mov` does
/// not disturb the flags, so the post-branch SETcc is correct).
#[allow(clippy::too_many_arguments)]
fn emit_atomic_cas(
    code: &mut Vec<u8>,
    dst: Place,
    addr: super::super::ir::ValueId,
    expected_addr: super::super::ir::ValueId,
    desired: super::super::ir::ValueId,
    width: u8,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let a = SCRATCH_R11;
    let des = SCRATCH_R10;
    let exp = Reg::RCX;
    emit_push_r(code, Reg::RAX);
    emit_push_r(code, exp);
    // Materialise addr / desired before clobbering RCX with the
    // expected pointer (their Places may name RCX).
    if operand_into(code, addr, a, frame, 16, alloc).is_none()
        || operand_into(code, desired, des, frame, 16, alloc).is_none()
        || operand_into(code, expected_addr, exp, frame, 16, alloc).is_none()
    {
        bail_msg("AtomicCas: operand not int reg / spill");
        return false;
    }
    emit_atomic_load(code, Reg::RAX, exp, width);
    emit_lock_cmpxchg_mem_r(code, a, 0, des, width);
    // On failure (ZF == 0) write the observed value back to *expected.
    // Build the conditional body separately to size the forward Jcc.
    let mut fail = Vec::new();
    emit_atomic_store(&mut fail, exp, Reg::RAX, width);
    emit_jcc_rel8(code, Cc::E, fail.len() as i8);
    code.extend_from_slice(&fail);
    // Result = ZF from the CMPXCHG. Reuse `a` (addr no longer needed).
    emit_setcc_r8(code, Cc::E, a);
    emit_movzx_r_r8(code, a, a);
    emit_pop_r(code, exp);
    emit_pop_r(code, Reg::RAX);
    write_atomic_result(code, dst, a, frame);
    true
}

/// Decide whether `block` ends in a tail-call shape: the block's
/// `Terminator::Return` value is the same block's last instruction,
/// and that instruction is a direct `Inst::Call` whose arguments
/// fit in the host integer-arg-register window. Returns
/// `Some((call_pc, target_pc, args))` when the shape matches and
/// every safety precondition holds.
///
/// Preconditions (in order):
///   * The terminator is `Return(v)` and `v` is the PC of the last
///     instruction in the block.
///   * That instruction is `Inst::Call { target_pc, args }`. Indirect
///     and external calls are out of scope for this pass.
///   * `args.len() <= abi.int_arg_regs.len()` -- no host-stack-overflow
///     argument; the epilogue would otherwise have to negotiate the
///     overflow stripe and the caller's stack at the same time.
///   * The callee isn't this function's variadic-marker call: c5's
///     internal cdecl-vs-variadic split is encoded by the callee's
///     own prologue, but the tail call site can't tell from here, so
///     keep the tail conversion off when *this* function is variadic
///     (its arg slots stay on the c5 stack rather than reg cells).
///   * The function has no `LocalAddr` to a negative slot: any such
///     address could have been passed to the callee in an earlier
///     call's argument, and tearing down our frame before the jmp
///     would invalidate it.
///   * The function records no callee-saved register use
///     (`alloc.gpr_used.is_empty()`): the epilogue would emit per-reg
///     restores between the arg marshal and the jmp, all of which
///     are callee-saved (rbx / r12 / r14 / r15 / rsi / rdi on Win64)
///     and so don't alias the caller-saved arg-register window the
///     tail call has just populated. Restricted on this first pass
///     for tractability; the more general path can drop this gate
///     once it is shown to be safe via an explicit save-before-marshal
///     sequence.
fn detect_tail_call<'a>(
    func: &'a FunctionSsa,
    block: &super::super::ir::Block,
    abi: super::Abi,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
) -> Option<(usize, usize, &'a [u32])> {
    let Terminator::Return(v) = block.terminator else {
        return None;
    };
    if v == super::super::ir::NO_VALUE {
        return None;
    }
    let inst_end = block.inst_range.end;
    if inst_end == 0 || v + 1 != inst_end {
        return None;
    }
    let (target_pc, args, arg_aggs) = match &func.insts[v as usize] {
        Inst::Call {
            target_pc,
            args,
            arg_aggs,
            ..
        } => (*target_pc, args.as_slice(), arg_aggs.as_slice()),
        _ => return None,
    };
    if args.len() > abi.int_arg_regs.len() {
        return None;
    }
    // A by-value aggregate argument is marshalled into one or two
    // argument registers loaded from its source address (System V AMD64
    // 3.2.3); the tail-call path plans with the scalar `plan_call_args`,
    // which would instead pass the address as a single pointer. Fall
    // back to the regular call-and-return path, which honours the
    // aggregate placement.
    if arg_aggs.iter().any(Option::is_some) {
        return None;
    }
    if func.is_variadic {
        return None;
    }
    // Variadic callees use a different call ABI (c5-stack 16-byte
    // pushes rather than the host int-arg-register window), so the
    // tail conversion's `marshal_args` would deliver garbage. The
    // regular `emit_call` path branches on this same flag.
    if variadic_targets.contains(&target_pc) {
        return None;
    }
    // Any `LocalAddr` -- whether to a user-local (negative `off`) or
    // a c5 cdecl param cell (positive `off >= 2`) -- could have been
    // passed as an argument to an earlier call or stored where the
    // callee will read it. Tearing down our frame before the `jmp`
    // would make that address dangle; the param cells in particular
    // get overwritten by the tail-callee's own prologue.
    if func.insts.iter().any(|i| matches!(i, Inst::LocalAddr(_))) {
        return None;
    }
    Some((v as usize, target_pc, args))
}

/// Emit a tail call as `marshal_args; epilogue; jmp target`.
/// `args` are placed into the host integer arg-register window using
/// the same planner the regular `Inst::Call` path uses; the epilogue
/// mirrors `emit_return`'s frame teardown (callee-saved restores +
/// `add rsp` + `pop rbp` + cdecl-cell drop) but skips the return
/// value staging and ends in `jmp rel32` instead of `ret`. The
/// callee's own `ret` instruction returns control to *our* caller.
#[allow(clippy::too_many_arguments)]
fn emit_tail_call(
    code: &mut Vec<u8>,
    target_pc: usize,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    func: &FunctionSsa,
    fp_arg_mask: u32,
) -> bool {
    // Marshal arguments into their ABI-prescribed registers. The
    // caller-saved arg-reg window is disjoint from `alloc.gpr_used`
    // (only callee-saved regs land there), so the epilogue's
    // restores below cannot clobber the marshalled values.
    let mut plan = super::plan_call_args(args.len(), args.len(), fp_arg_mask, abi);
    // `detect_tail_call` rejects arg counts above `int_arg_regs.len()`,
    // so no `Stack(offset)` placements ever reach here (FP args ride
    // the independent FP bank and never overflow with <= 6 total args).
    if plan
        .placements
        .iter()
        .any(|p| matches!(p, super::ArgPlacement::Stack(_)))
    {
        unreachable!(
            "ICE: tail-call planner returned a Stack arg placement; \
             detect_tail_call should have rejected arg_count > int_arg_regs"
        );
    }
    // marshal_args adds plan.scratch_bytes to every spill-slot rsp
    // offset because regular call sites do `sub rsp, scratch_bytes`
    // ahead of the marshal to set up the Win64 shadow-space window.
    // The tail-call path doesn't allocate that window (the callee
    // inherits the slot from our caller's frame), so rsp has not
    // moved -- any spill load must use the natural slot offset.
    // Clear scratch_bytes to suppress the marshal's sp_shift add.
    plan.scratch_bytes = 0;
    if !marshal_args(code, &plan, args, alloc, frame, "TailCall") {
        return false;
    }
    // Mirror emit_return's epilogue, omitting the return-value
    // staging (the callee's own `ret` carries the value back). The
    // marshalled args ride caller-saved arg registers, disjoint from the
    // callee-saved GPRs and the non-volatile xmm scratch restored here.
    let saved_fpr_bytes = frame.saved_fpr_bytes as i32;
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = saved_fpr_bytes + (i as i32) * 8;
        super::x86_64::emit_mov_r_mem(code, Reg(r), Reg::RSP, off);
    }
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        emit_movups_xmm_mem(code, Reg(r), Reg::RSP, (i as i32) * 16);
    }
    if !is_full_leaf(func, frame, alloc, abi) {
        if frame.frame_bytes > 0 {
            emit_add_rsp_imm32(code, frame.frame_bytes);
        }
        emit_pop_r(code, Reg::RBP);
        if frame.param_spill_bytes > 0 {
            emit_add_rsp_imm32(code, frame.param_spill_bytes);
        }
    }
    // Record a Call-kind fixup at the rel32 byte; the post-link pass
    // resolves `target_ent_pc` to its native byte offset like a
    // regular intra-unit call. The opcode emitted here is `jmp`
    // (E9 rel32), not `call`, so the callee's own `ret` returns to
    // our caller rather than to this instruction.
    let jmp_site = code.len();
    fixups.push(Fixup {
        native_offset: jmp_site,
        target_ent_pc: target_pc,
        kind: super::x86_64::BranchKind::Jmp,
    });
    super::x86_64::emit_jmp_rel32(code, 0);
    true
}

fn emit_return(
    code: &mut Vec<u8>,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    func: &FunctionSsa,
    abi: super::Abi,
) {
    // Staging through rcx is needed only when the return value
    // itself lives in a callee-saved register the epilogue is about
    // to restore (e.g. rbx, r12): the restore would overwrite the
    // source before it reaches rax. rcx is caller-saved and never in
    // `gpr_used`, so it survives the restore. In every other case --
    // the value already in rax, in a caller-saved register, or in a
    // spill slot the restore does not touch -- the epilogue restores
    // first, then places the value into rax directly (`mov rax, src`,
    // or nothing when src already lives in rax). FP returns ride xmm0
    // directly;
    // xmm0 is outside the GPR restore loop, but the integer
    // mirror into rax happens after the restore so the bit
    // pattern is available to int-shaped callers.
    let return_place = if value != super::super::ir::NO_VALUE {
        alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None)
    } else {
        Place::None
    };
    // Host-ABI aggregate return (System V AMD64 3.2.3): `value` is the
    // struct's address. A <= 16-byte integer aggregate returns its
    // eightbytes in rax:rdx (x86_64 has no x8 indirect-result path --
    // the > 16-byte case keeps the out-pointer convention, so `ret_agg`
    // is only ever set here for the register case). Stage the address
    // through rcx (caller-saved, untouched by the callee-saved restore)
    // before the restore, then load the eightbytes after it.
    if let Some(ai) = func.ret_agg {
        let desc = &func.agg_descs[ai as usize];
        let eb_classes = match super::abi_classify::classify_aggregate(
            desc.size,
            desc.align,
            &desc.fields,
            abi,
            true,
        ) {
            super::abi_classify::AggClass::Regs(c) => c,
            _ => alloc::vec::Vec::new(),
        };
        match return_place {
            Place::IntReg(r) => {
                if r != Reg::RCX.0 {
                    emit_mov_rr(code, Reg::RCX, Reg(r));
                }
            }
            Place::Spill(slot) => {
                let sp_off = spill_slot_sp_offset(frame, slot);
                super::x86_64::emit_mov_r_mem(code, Reg::RCX, Reg::RSP, sp_off);
            }
            _ => {}
        }
        // Restore callee-saved GPRs and saved non-volatile xmm scratch
        // (the prologue places xmm at the bottom, GPRs above by
        // saved_fpr_bytes). rcx already holds the struct address and is
        // caller-saved, so the restore does not disturb it; the return
        // eightbytes load into the volatile rax/rdx/xmm0/xmm1 below.
        let saved_fpr_bytes = frame.saved_fpr_bytes as i32;
        for (i, &r) in alloc.gpr_used.iter().enumerate() {
            super::x86_64::emit_mov_r_mem(code, Reg(r), Reg::RSP, saved_fpr_bytes + (i as i32) * 8);
        }
        for (i, &r) in alloc.fp_used.iter().enumerate() {
            emit_movups_xmm_mem(code, Reg(r), Reg::RSP, (i as i32) * 16);
        }
        // Place each eightbyte in its bank: System V returns SSE eightbytes
        // in xmm0/xmm1 and INTEGER eightbytes in rax/rdx, each in order.
        let int_ret = [Reg::RAX, Reg::RDX];
        let mut int_i = 0usize;
        let mut sse_i = 0u8;
        for (k, class) in eb_classes.iter().enumerate() {
            let off = (k as i32) * 8;
            if matches!(class, super::abi_classify::RegClass::Sse) {
                emit_movsd_xmm_mem(code, Reg(Reg::XMM0.0 + sse_i), Reg::RCX, off);
                sse_i += 1;
            } else {
                emit_mov_r_mem(code, int_ret[int_i], Reg::RCX, off);
                int_i += 1;
            }
        }
        if is_full_leaf(func, frame, alloc, abi) {
            emit_ret(code);
            return;
        }
        if frame.frame_bytes > 0 {
            emit_add_rsp_imm32(code, frame.frame_bytes);
        }
        emit_pop_r(code, Reg::RBP);
        if frame.param_spill_bytes > 0 {
            emit_pop_r(code, Reg::R11);
            emit_add_rsp_imm32(code, frame.param_spill_bytes);
            emit_push_r(code, Reg::R11);
        }
        emit_ret(code);
        return;
    }
    // A floating-point scalar return rides xmm0 (C99 6.2.5p10). The
    // declared return type is authoritative: a bare FP constant
    // materializes as an integer immediate in a GPR, and any value whose
    // producing instruction is integer-classed lands in a GPR, yet an
    // `fp_return` caller reads xmm0. `materialize_fp` reinterprets the
    // GPR / spill bit pattern into an xmm via `movq` / `movsd`.
    let return_is_fp = func.ret_is_fp
        || matches!(return_place, Place::FpReg(_))
        || (value != super::super::ir::NO_VALUE
            && (value as usize) < func.insts.len()
            && super::ssa_alloc::produces_fp_result(&func.insts[value as usize]));
    let needs_staging = matches!(return_place, Place::IntReg(r) if alloc.gpr_used.contains(&r));
    let staged_int = if needs_staging {
        match return_place {
            Place::IntReg(r) if r != Reg::RCX.0 => {
                emit_mov_rr(code, Reg::RCX, Reg(r));
                true
            }
            Place::IntReg(_) => true,
            Place::Spill(slot) => {
                let sp_off = spill_slot_sp_offset(frame, slot);
                super::x86_64::emit_mov_r_mem(code, Reg::RCX, Reg::RSP, sp_off);
                true
            }
            _ => false,
        }
    } else {
        false
    };
    if return_is_fp {
        // SCRATCH_XMM14 is outside the allocator's pool, so a
        // spilled f64 lands there without clobbering an
        // allocator-held xmm.
        if let Some(dn) = materialize_fp(code, return_place, SCRATCH_XMM14, frame)
            && dn.0 != Reg::XMM0.0
        {
            emit_movapd_xmm_xmm(code, Reg::XMM0, dn);
        }
    }
    // Restore callee-saved GPRs and saved non-volatile xmm scratch
    // (mirror of the prologue's saves: xmm at the bottom, GPRs above).
    let saved_fpr_bytes = frame.saved_fpr_bytes as i32;
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = saved_fpr_bytes + (i as i32) * 8;
        super::x86_64::emit_mov_r_mem(code, Reg(r), Reg::RSP, off);
    }
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        let off = (i as i32) * 16;
        emit_movups_xmm_mem(code, Reg(r), Reg::RSP, off);
    }
    if staged_int {
        emit_mov_rr(code, Reg::RAX, Reg::RCX);
    } else if !needs_staging {
        // No callee-saved restore to navigate around; place the
        // return value into rax directly. A source that already
        // lives in rax needs no instruction.
        match return_place {
            Place::IntReg(r) if r != Reg::RAX.0 => {
                emit_mov_rr(code, Reg::RAX, Reg(r));
            }
            Place::Spill(slot) => {
                let sp_off = spill_slot_sp_offset(frame, slot);
                super::x86_64::emit_mov_r_mem(code, Reg::RAX, Reg::RSP, sp_off);
            }
            _ => {}
        }
    }
    // A floating-point return value is delivered in xmm0 only (SysV
    // AMD64 / Win64: scalar floating returns in xmm0). The receiving
    // call site is FP-classed (`Inst::Call::fp_return`) and reads
    // xmm0, so no rax mirror is emitted.
    // Leaf-function elision: prologue emitted no save, so the
    // epilogue emits no matching restore. The function lowers to
    // the return-value materialization, then `ret`.
    if is_full_leaf(func, frame, alloc, abi) {
        emit_ret(code);
        return;
    }
    if frame.frame_bytes > 0 {
        emit_add_rsp_imm32(code, frame.frame_bytes);
    }
    emit_pop_r(code, Reg::RBP);
    // Drop whatever bytes the prologue allocated for c5 cdecl
    // parameter slots above the return address. The single
    // source of truth is `prologue_param_spill_bytes`, recorded
    // on `frame.param_spill_bytes`; both prologue and epilogue
    // read from there so the two sides agree across every
    // branch the prologue takes (variadic, host-stack overflow,
    // ParamRef-elided, n_params == 0). When 0, the `pop r11`
    // / `push r11` sequence is skipped entirely because the return
    // address is already on top of the stack.
    let _ = func;
    if frame.param_spill_bytes > 0 {
        emit_pop_r(code, Reg::R11);
        emit_add_rsp_imm32(code, frame.param_spill_bytes);
        emit_push_r(code, Reg::R11);
    }
    emit_ret(code);
}

#[cfg(test)]
mod scratch_picker_tests {
    use super::*;

    #[test]
    fn pick_returns_some_when_no_operands() {
        // rd = rdi (outside the pool) and no operands: the helper
        // returns the first preference (rax) per the
        // CALLER_SAVED_INT_SCRATCHES ordering [0, 1, 2, 8, 9].
        assert_eq!(pick_caller_saved_scratch(Reg(7), &[]), Some(Reg(0)));
    }

    #[test]
    fn pick_skips_rd() {
        // rd = rax forces the helper past the first preference;
        // the next entry (rcx) wins.
        assert_eq!(pick_caller_saved_scratch(Reg(0), &[]), Some(Reg(1)));
    }

    #[test]
    fn pick_skips_operand_regs() {
        // rd = rax, operands hold rcx (1) -> rdx (2) wins.
        assert_eq!(pick_caller_saved_scratch(Reg(0), &[Reg(1)]), Some(Reg(2)));
    }

    #[test]
    fn pick_returns_none_when_pool_exhausted() {
        // The candidate pool is CALLER_SAVED_INT_SCRATCHES = [0, 1, 2,
        // 8, 9]. Excluding all five via rd + 4 operands forces the
        // fallthrough. The helper must return None so callers bail
        // rather than fall through to a callee-saved or reserved
        // scratch register.
        let rd = Reg(0);
        let operands = [Reg(1), Reg(2), Reg(8), Reg(9)];
        assert_eq!(pick_caller_saved_scratch(rd, &operands), None);
    }

    #[test]
    fn pick_returns_none_when_every_candidate_in_operands() {
        // rd is outside the pool entirely (rdi = 7); every entry of
        // CALLER_SAVED_INT_SCRATCHES is in the operand list. Helper
        // must return None.
        let rd = Reg(7);
        let operands = [Reg(0), Reg(1), Reg(2), Reg(8), Reg(9)];
        assert_eq!(pick_caller_saved_scratch(rd, &operands), None);
    }
}

#[cfg(test)]
mod relax_branches_tests {
    use super::*;

    // jmp form: long_size 5; jcc form: long_size 6. Short form is 2
    // bytes; displacement is measured from the byte after the 2-byte
    // short instruction to the target offset.

    #[test]
    fn near_forward_branch_shortens() {
        // Single jmp at offset 0 to a block 100 bytes ahead: short rel
        // = 100 - 2 = 98, within i8.
        let short = relax_branches(&[(0, 5, 1)], &[0, 100]);
        assert_eq!(short, vec![true]);
    }

    #[test]
    fn far_forward_branch_stays_long() {
        // Target 200 bytes ahead: short rel = 198, out of i8 range.
        let short = relax_branches(&[(0, 5, 1)], &[0, 200]);
        assert_eq!(short, vec![false]);
    }

    #[test]
    fn backward_branch_shortens() {
        // jmp at offset 50 back to offset 0: short rel = 0 - 52 = -52.
        let short = relax_branches(&[(50, 5, 0)], &[0, 50]);
        assert_eq!(short, vec![true]);
    }

    #[test]
    fn forward_boundary_127_shortens_128_does_not() {
        // Short instr ends at offset 2; target 129 -> rel 127 (fits),
        // target 130 -> rel 128 (does not).
        assert_eq!(relax_branches(&[(0, 5, 1)], &[0, 129]), vec![true]);
        assert_eq!(relax_branches(&[(0, 5, 1)], &[0, 130]), vec![false]);
    }

    #[test]
    fn cascade_inner_shortening_brings_outer_into_range() {
        // branch0 (offset 0) targets block 2 at 132; branch1 (offset 5)
        // targets block 1 at 10 and shortens first (rel 3), removing 3
        // bytes before branch0's target. branch0's short rel then
        // becomes 132 - 3 - 2 = 127 -> fits. A single all-long pass
        // (rel 130) would have missed branch0.
        let short = relax_branches(&[(0, 5, 2), (5, 5, 1)], &[0, 10, 132]);
        assert_eq!(short, vec![true, true]);
        // One more byte of distance defeats the cascade for branch0.
        let short = relax_branches(&[(0, 5, 2), (5, 5, 1)], &[0, 10, 133]);
        assert_eq!(short, vec![false, true]);
    }

    #[test]
    fn jcc_long_size_six_removes_four_bytes() {
        // A shortened jcc removes 4 bytes (6 -> 2). Two jccs whose
        // combined 8-byte saving brings a third into range.
        // block layout: b0@0, b1@4, b2@8, b3@140.
        // branch0@0 -> b3(140): all-long rel 138; after the two inner
        // jccs shorten (save 8), rel = 140 - 8 - 2 = 130 -> still out.
        let short = relax_branches(&[(0, 6, 3), (8, 6, 1), (16, 6, 2)], &[0, 4, 8, 140]);
        assert!(short[1]);
        assert!(short[2]);
        assert!(!short[0]);
        // Pull the target in by 3 so the saving is enough: 134 - 8 - 2 = 124.
        let short = relax_branches(&[(0, 6, 3), (8, 6, 1), (16, 6, 2)], &[0, 4, 8, 134]);
        assert!(short[0]);
    }
}

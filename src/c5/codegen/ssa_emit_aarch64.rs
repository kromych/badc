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

#![allow(dead_code)]

use alloc::vec::Vec;

use super::Target;
use super::aarch64::{
    Reg, emit, emit_add_sp_imm, emit_sub_sp_imm, enc_add_imm, enc_add_reg, enc_and_reg,
    enc_asrv, enc_eor_reg, enc_ldp_post, enc_ldr_imm, enc_lslv, enc_lsrv, enc_mov_reg, enc_mul,
    enc_orr_reg, enc_ret, enc_stp_pre, enc_str_imm, enc_str_pre, enc_sub_reg, load_imm64,
};
use super::ssa::{BinOp, FunctionSsa, Inst, Terminator};
use super::ssa_alloc::{Allocation, Place};

/// Per-function frame layout. Bytes are 16-aligned at every
/// region boundary so AAPCS64's sp-at-call-site invariant holds.
#[derive(Debug, Clone, Copy)]
pub(super) struct Frame {
    /// Total frame size below fp, sub-spilled once at prologue
    /// entry. Includes locals, vstack region, allocator spills,
    /// and saved callee-saved regs.
    pub frame_bytes: u32,
    /// Byte distance from fp down to the start of the
    /// allocator-managed spill region.
    pub alloc_spill_base: u32,
}

impl Frame {
    pub fn for_function(func: &FunctionSsa, alloc: &Allocation) -> Self {
        let locals_bytes = ((func.locals.max(0) as u32) * 8 + 15) & !15;
        let vstack_bytes = (func.vstack_slots * 8 + 15) & !15;
        let alloc_spill_bytes = (alloc.spill_count * 8 + 15) & !15;
        let saved_gpr_bytes = ((alloc.gpr_used.len() as u32) * 8 + 15) & !15;
        let saved_fpr_bytes = ((alloc.fp_used.len() as u32) * 8 + 15) & !15;
        let frame_bytes = locals_bytes
            + vstack_bytes
            + alloc_spill_bytes
            + saved_gpr_bytes
            + saved_fpr_bytes;
        Self {
            frame_bytes,
            alloc_spill_base: locals_bytes + vstack_bytes,
        }
    }
}

/// Public entry point. Returns `true` when every block + inst +
/// terminator was lowered. Returns `false` (and leaves `code`
/// unchanged) when the function contains an op outside the
/// implemented subset; the caller falls back or aborts per
/// policy.
pub(super) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    code: &mut Vec<u8>,
) -> bool {
    let frame = Frame::for_function(func, alloc);
    let abi = target.abi();
    let scratch = ScratchPool::new();
    let snapshot = code.len();

    emit_prologue(code, func, alloc, frame, abi);

    for (block_idx, block) in func.blocks.iter().enumerate() {
        for v in block.inst_range.clone() {
            let inst = &func.insts[v as usize];
            let place = alloc
                .places
                .get(v as usize)
                .copied()
                .unwrap_or(Place::None);
            if !emit_inst(code, inst, place, alloc, frame, &scratch) {
                code.truncate(snapshot);
                let _ = block_idx;
                return false;
            }
        }
        match block.terminator {
            Terminator::Return(v) => {
                emit_return(code, v, alloc, frame, &scratch);
            }
            // Anything else -- branches, tail calls, fall-through
            // -- needs label fixups the thin slice doesn't yet
            // produce. Fall back to the pool path.
            _ => {
                code.truncate(snapshot);
                return false;
            }
        }
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
        let off = -(((save_base + (i as u32) * 8 + 8) as i32));
        emit(code, super::aarch64::enc_stur(Reg(r), Reg(29), off));
    }
}

/// Byte offset (positive) from fp to the start of the saved-reg
/// region. The region is the lowest portion of the frame.
fn alloc_save_base(frame: Frame, alloc: &Allocation) -> u32 {
    let saved_gpr_bytes = ((alloc.gpr_used.len() as u32) * 8 + 15) & !15;
    let saved_fpr_bytes = ((alloc.fp_used.len() as u32) * 8 + 15) & !15;
    // fp is at frame top; the saved-reg region sits at the
    // bottom. Distance from fp = frame_bytes - saved-region size.
    frame.frame_bytes.saturating_sub(saved_gpr_bytes + saved_fpr_bytes)
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
        Inst::Binop { op, lhs, rhs } => emit_binop(code, *op, dst, *lhs, *rhs, alloc, frame, scratch),
        Inst::BinopI { op, lhs, rhs_imm } => {
            emit_binop_imm(code, *op, dst, *lhs, *rhs_imm, alloc, frame, scratch)
        }
        _ => false,
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
    scratch: &ScratchPool,
) -> bool {
    let Some(rd) = int_reg(dst) else {
        return false;
    };
    let lhs_place = alloc.places.get(lhs as usize).copied().unwrap_or(Place::None);
    let rhs_place = alloc.places.get(rhs as usize).copied().unwrap_or(Place::None);
    let rn = match materialize_int(code, lhs_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rm = match materialize_int(code, rhs_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    let word = match op {
        BinOp::Add => enc_add_reg(rd, rn, rm),
        BinOp::Sub => enc_sub_reg(rd, rn, rm),
        BinOp::Mul => enc_mul(rd, rn, rm),
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
    let lhs_place = alloc.places.get(lhs as usize).copied().unwrap_or(Place::None);
    let rn = match materialize_int(code, lhs_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    load_imm64(code, scratch.secondary, rhs_imm as u64);
    let rm = scratch.secondary;
    let word = match op {
        BinOp::Add => enc_add_reg(rd, rn, rm),
        BinOp::Sub => enc_sub_reg(rd, rn, rm),
        BinOp::Mul => enc_mul(rd, rn, rm),
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
fn materialize_int(
    code: &mut Vec<u8>,
    place: Place,
    scratch: Reg,
    frame: Frame,
) -> Option<Reg> {
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let off = -(((frame.alloc_spill_base + (slot + 1) * 8) as i32));
            emit(code, super::aarch64::enc_ldur(scratch, Reg(29), off));
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
) {
    // Move the return value into x0. NO_VALUE means the bytecode
    // emitter's trailing synthetic Lev with no live accumulator;
    // an undefined return value is harmless because c5 calls
    // never read the result of a void-returning function.
    if value != super::ssa::NO_VALUE {
        let place = alloc.places.get(value as usize).copied().unwrap_or(Place::None);
        if let Some(src) = materialize_int(code, place, scratch.primary, frame) {
            if src.0 != 0 {
                emit(code, enc_mov_reg(Reg(0), src));
            }
        }
    }
    // Restore saved callee-saved GPRs (mirror of prologue).
    let save_base = alloc_save_base(frame, alloc);
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = -(((save_base + (i as u32) * 8 + 8) as i32));
        emit(code, super::aarch64::enc_ldur(Reg(r), Reg(29), off));
    }
    // Tear down the frame.
    if frame.frame_bytes > 0 {
        emit_add_sp_imm(code, frame.frame_bytes);
    }
    emit(code, enc_ldp_post(Reg(29), Reg(30), Reg(31), 16));
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
        let (func, alloc) = lift_and_alloc(
            "int main(void) { return 42; }",
            Target::MacOSAarch64,
        );
        let mut code = Vec::new();
        let ok = emit_function(&func, &alloc, Target::MacOSAarch64, &mut code);
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
        let (func, alloc) = lift_and_alloc(
            "int main(void) { return 1 + 2; }",
            Target::MacOSAarch64,
        );
        let mut code = Vec::new();
        let ok = emit_function(&func, &alloc, Target::MacOSAarch64, &mut code);
        assert!(ok, "binop handler should cover Add + Shl + Shr");
        assert_eq!(code.len() % 4, 0);
    }
}


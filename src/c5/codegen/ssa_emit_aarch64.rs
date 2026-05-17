//! AArch64 native emit consuming the SSA lift + allocator output.
//! Selected by `NativeOptions::regalloc = RegallocMode::Ssa` AND
//! the env var `BADC_USE_SSA_EMIT` -- the env-var gate keeps the
//! SSA path strictly opt-in while it's reaching parity with the
//! pool regalloc. With `BADC_USE_SSA_EMIT` unset, `--regalloc=ssa`
//! still runs the lift + allocator (for `BADC_DUMP_SSA`
//! observability) but lets the pool path emit the final bytes.
//!
//! ## Pass shape
//!
//! For each function:
//!
//! 1. Emit the prologue: save the allocator-reported callee-saved
//!    GPRs + FP regs, reserve a frame for the function's locals
//!    plus the allocator's spill slots plus the SSA pass's vstack
//!    slots. Spill host arg registers into the c5 cdecl 16-byte
//!    slots so the body's `LocalAddr(>=2)` reads land on the right
//!    parameter.
//! 2. Walk each block in source order. At block start emit any
//!    `VstackReload` insts. For each SSA value, dispatch on
//!    `Inst` and emit the corresponding native sequence using the
//!    allocator-assigned `Place` for inputs and the output.
//! 3. At block end emit `VstackSpill` insts, then the terminator
//!    (`Jmp` / conditional branch / `Return`).
//! 4. Emit the epilogue (matching restores).
//!
//! ## Frame layout (top -> bottom, growing down)
//!
//! ```text
//!   caller's args -- spilled into c5 cdecl slots
//!   saved fp, saved lr           [fp +  0]
//!   locals area                  [fp -  locals_bytes]
//!   vstack spill slots           [fp -  locals_bytes - vstack_bytes]
//!   allocator spill slots        [fp -  locals_bytes - vstack_bytes - alloc_spill_bytes]
//!   saved callee-saved GPRs
//!   saved callee-saved FP regs
//! ```
//!
//! Each `Place::Spill(N)` reads / writes the slot at
//! `[fp - locals_bytes - vstack_bytes - (N+1) * 8]`. The frame
//! pointer (x29) is the stable reference -- no rsp tracking
//! mid-function except across call sites.

#![allow(dead_code)]

use alloc::vec::Vec;

use super::Target;
use super::aarch64;
use super::ssa::FunctionSsa;
use super::ssa_alloc::Allocation;

/// Per-function frame layout the emit pass computes once after
/// the allocator runs. Bytes are 16-aligned where it matters.
#[derive(Debug, Clone, Copy)]
pub(super) struct Frame {
    /// Total frame size from caller's sp at function entry down
    /// to the lowest spill slot, rounded up to 16.
    pub frame_bytes: u32,
    /// Byte offset (positive) from `fp` to the start of the
    /// locals area. The c5 emitter's `Op::Lea N` for negative N
    /// reads at `fp + N*8`; for positive N >= 2 reads at
    /// `fp + (N-1)*16`. These offsets are unchanged from the
    /// pool path -- the prologue still spills host arg regs to
    /// 16-byte slots above fp.
    pub locals_base: u32,
    /// Byte offset (positive) from `fp` to the start of the
    /// vstack spill region.
    pub vstack_base: u32,
    /// Byte offset (positive) from `fp` to the start of the
    /// allocator-managed spill region.
    pub alloc_spill_base: u32,
}

impl Frame {
    /// Compute the frame layout for `func` given the allocator's
    /// spill count. AAPCS64 demands 16-aligned SP at every call;
    /// each region is rounded up to a 16-byte boundary so the
    /// boundaries themselves are aligned.
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
        // The frame is laid out below fp; `locals_base` is the
        // byte distance from fp down to the top of the locals
        // region (just below the saved fp/lr pair).
        Self {
            frame_bytes,
            locals_base: 0,
            vstack_base: locals_bytes,
            alloc_spill_base: locals_bytes + vstack_bytes,
        }
    }
}

/// Top-level entry point. Returns whether the SSA path emitted
/// the function (true) or whether the caller should fall back to
/// the pool path (false). The bytes / fixups produced when this
/// returns `true` are appended to `code` and the relevant fixup
/// vectors; the caller is responsible for stitching them into
/// the surrounding `Build`.
///
/// Today the function always returns `false` -- the per-Inst
/// emit handlers are stubbed pending the parity push. The
/// scaffolding compiles and exercises the SSA lift + allocator
/// regardless, which is the load-bearing path for
/// `BADC_DUMP_SSA` observability.
pub(super) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    _target: Target,
    _code: &mut Vec<u8>,
) -> bool {
    // Frame computation is exercised so a future emit can read
    // it back without re-derivation. Held behind `_frame` until
    // the per-Inst handlers consume it.
    let _frame = Frame::for_function(func, alloc);
    let _ = aarch64::POOL_SIZES;
    false
}

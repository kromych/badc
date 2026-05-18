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
//! 1. Prologue: save rbp, set the frame pointer, reserve locals +
//!    vstack + allocator-spill bytes, save the callee-saved GPRs
//!    the allocator reported as used, and spill the host-ABI
//!    argument registers into the c5 cdecl slots the body's
//!    `LocalAddr(>=2)` references.
//! 2. Walk each block in source order. Emit `VstackReload`s at
//!    block start, per-`Inst` native code in `inst_range`, then
//!    `VstackSpill`s, then the terminator.
//! 3. Epilogue lands inline at every `Terminator::Return`: load
//!    the return value into rax, restore saved regs, drop the
//!    frame, `ret`.
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
use super::ssa::FunctionSsa;
use super::ssa_alloc::Allocation;
use super::x86_64::{Fixup, PltCallFixup, Reg, emit_ret, emit_sub_rsp_imm32};

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

/// Public entry point. Returns `true` when every block + inst +
/// terminator was lowered. Returns `false` (with `code`
/// truncated back to the pre-attempt snapshot) when the function
/// contains an op outside the implemented subset. The handler
/// set is intentionally minimal at this stage; the aarch64 SSA
/// emit grew bottom-up from the same shape and the x86_64 path
/// follows that trajectory.
pub(super) fn emit_function(
    func: &FunctionSsa,
    _alloc: &Allocation,
    _target: Target,
    code: &mut Vec<u8>,
    _fixups: &mut Vec<Fixup>,
    _plt_call_fixups: &mut Vec<PltCallFixup>,
    _got_fixups: &mut Vec<GotFixup>,
    _data_fixups: &mut Vec<DataFixup>,
    _pending_func_fixups: &mut Vec<(usize, usize)>,
    _imports: &super::ResolvedImports,
    _variadic_targets: &alloc::collections::BTreeSet<usize>,
    _tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    _bytecode_to_native: &mut [usize],
) -> bool {
    // TODO: grow per-Inst handlers to parity with aarch64. Until
    // then bail on every function so the dispatch falls back to
    // the pool path. The `code.truncate(snapshot)` invariant lets
    // the caller resume the pool walk cleanly.
    let snapshot = code.len();
    let _ = func;
    bail_msg("x86_64 SSA emit not yet implemented");
    code.truncate(snapshot);
    let _ = emit_ret;
    let _ = emit_sub_rsp_imm32;
    let _: Reg;
    false
}

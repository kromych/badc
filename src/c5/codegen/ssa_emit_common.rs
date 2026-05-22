//! Cross-target helpers for the SSA emit backends. Holds the
//! pieces of the per-arch lowering that are pure math or pure
//! formatting -- the shape that doesn't depend on a particular
//! ABI or instruction encoding -- so the per-arch modules
//! (`ssa_emit_x86_64.rs`, `ssa_emit_aarch64.rs`) don't carry
//! parallel copies.

/// Hash map keyed by a small integer (bytecode PC, function id,
/// symbol index). Uses `FxHash` -- the hasher rustc itself uses
/// for its internal id-keyed maps -- so the codegen hot paths
/// avoid the std `SipHash` cost on the dominant `usize` /
/// `u32` key shape. Iteration order is not stable; only use
/// where order does not matter.
pub(super) type FxIntMap<K, V> = hashbrown::HashMap<K, V, rustc_hash::FxBuildHasher>;

/// Whether the `BADC_TIME_PASSES` environment variable is set.
/// Gates the wall-clock timer instrumentation in the codegen
/// pipeline so a default release build pays no per-pass
/// std::time::Instant cost.
#[cfg(feature = "std")]
pub(super) fn time_passes_enabled() -> bool {
    std::env::var("BADC_TIME_PASSES").is_ok()
}

/// Run `f`, measure wall-clock with `Instant::elapsed`, and
/// print one `pass: <label> -- <us>us` line on stderr when
/// `BADC_TIME_PASSES` is set. Returns whatever `f` returned so
/// the caller can wrap a value-producing closure in place.
/// No-op when the feature is off or the env var is unset
/// (the closure still runs).
#[cfg(feature = "std")]
pub(super) fn time_pass<R>(label: &str, f: impl FnOnce() -> R) -> R {
    if !time_passes_enabled() {
        return f();
    }
    let start = std::time::Instant::now();
    let r = f();
    let us = start.elapsed().as_micros();
    eprintln!("pass: {label} -- {us}us");
    r
}

#[cfg(not(feature = "std"))]
pub(super) fn time_pass<R>(_label: &str, f: impl FnOnce() -> R) -> R {
    f()
}

/// Diagnostic surface for a per-function SSA-emit fallback. The
/// per-arch emit paths call this when they hit a shape they
/// don't cover; the message lands on stderr only when
/// `BADC_DUMP_SSA` is set, so production builds stay quiet. The
/// caller passes its own backend tag (`"x86_64"`, `"aarch64"`)
/// so logs from a single run with both targets emit can be
/// disambiguated by source.
pub(super) fn bail_msg(backend: &str, reason: &str) {
    #[cfg(feature = "std")]
    if std::env::var("BADC_DUMP_SSA").is_ok() {
        eprintln!("ssa emit {backend}: bailed -- {reason}");
    }
    let _ = (backend, reason);
}

/// Translate a c5-stack slot index (`Op::Lea`'s operand) into a
/// byte offset relative to fp / rbp. Locals (`off < 0`) sit at
/// `off * 8`; parameters (`off >= 2`) sit at `(off - 1) * 16` to
/// reflect the 16-byte caller-push slots c5's cdecl uses.
pub(super) fn c5_slot_to_fp_offset(off: i64) -> i64 {
    if off >= 2 { (off - 1) * 16 } else { off * 8 }
}

/// SP-relative byte offset of an allocator spill slot. The
/// caller passes the frame's `frame_bytes` and `alloc_spill_base`
/// because the Frame struct shape differs slightly between
/// backends (aarch64 carries extra saved-FPR / saved-x19 fields).
/// Slot 0 sits 8 bytes below `alloc_spill_base`; slot N sits a
/// further `N * 8` bytes down. The fp + sp relationship
/// `sp = fp - frame_bytes` then yields the SP-relative offset.
pub(super) fn spill_slot_sp_offset(frame_bytes: u32, alloc_spill_base: u32, slot: u32) -> u32 {
    frame_bytes - alloc_spill_base - (slot + 1) * 8
}

/// Record the byte offset of the first post-prologue
/// instruction against the bytecode word that follows
/// `Op::Ent`. The DWARF CFI pass reads this to encode
/// `DW_CFA_advance_loc <prologue bytes>` so the post-prologue
/// CFA / saved-reg rule installs at the right PC.
pub(super) fn record_post_prologue_pc(
    func: &super::super::ir::FunctionSsa,
    bytecode_to_native: &mut [usize],
    code_len: usize,
) {
    let post_prologue_pc = func.ent_pc + crate::c5::op::Op::Ent.word_size();
    if post_prologue_pc < bytecode_to_native.len() {
        bytecode_to_native[post_prologue_pc] = code_len;
    }
}

/// True when an SSA inst can be skipped entirely because its
/// result has no consumers and the inst itself has no side effects.
/// Per-arch emit dispatch checks this before invoking `emit_inst`;
/// dead pure values produce no machine code. Side-effectful insts
/// (stores, calls, intrinsics, alloca init, vstack spills) are
/// always emitted regardless of use count.
pub(super) fn is_dead_pure(
    inst: &super::super::ir::Inst,
    v: super::super::ir::ValueId,
    alloc: &super::ssa_alloc::Allocation,
) -> bool {
    use super::super::ir::Inst::*;
    let pure = matches!(
        inst,
        Imm(_)
            | ImmData(_)
            | ImmCode(_)
            | LocalAddr(_)
            | TlsAddr(_)
            | Load { .. }
            | LoadLocal { .. }
            | LoadIndexed { .. }
            | Binop { .. }
            | BinopI { .. }
            | Fneg(_)
            | FpCast { .. }
            | VstackReload { .. }
            | AccReload
    );
    if !pure {
        return false;
    }
    let idx = v as usize;
    alloc.use_counts.get(idx).copied().unwrap_or(0) == 0
}

/// Record the native byte offset of a block's first
/// instruction against its bytecode PC. Skips the entry block
/// because the outer codegen walk already pinned the
/// function's `Op::Ent` PC to the prologue start; overwriting
/// it would redirect every `bl <function>` to land past the
/// prologue's setup.
pub(super) fn record_block_start_pc(
    block_idx: usize,
    block_start_pc: usize,
    bytecode_to_native: &mut [usize],
    code_len: usize,
) {
    if block_idx > 0 && block_start_pc < bytecode_to_native.len() {
        bytecode_to_native[block_start_pc] = code_len;
    }
}

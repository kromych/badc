//! Cross-target helpers for the SSA emit backends. Holds the
//! pieces of the per-arch lowering that are pure math or pure
//! formatting -- the shape that doesn't depend on a particular
//! ABI or instruction encoding -- so the per-arch modules
//! (`ssa_emit_x86_64.rs`, `ssa_emit_aarch64.rs`) don't carry
//! parallel copies.

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
    func: &super::ssa::FunctionSsa,
    bytecode_to_native: &mut [usize],
    code_len: usize,
) {
    let post_prologue_pc = func.ent_pc + crate::c5::op::Op::Ent.word_size();
    if post_prologue_pc < bytecode_to_native.len() {
        bytecode_to_native[post_prologue_pc] = code_len;
    }
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

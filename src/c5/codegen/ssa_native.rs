//! Direct compilation of a [`FunctionSsa`] to a stand-alone native
//! code blob on aarch64. Skips the `Program` / bytecode tier so a
//! producer that builds SSA directly (today: the SsaBuilder test
//! harness; future: the parser when it gains SSA emit) can validate
//! end-to-end against the existing allocator + per-arch emit.
//!
//! Scope: a single function on aarch64 with no external calls, no
//! data refs, no TLS, no Mcpy, no function-pointer literals.
//! Anything outside that surface needs the cross-function fixup
//! plumbing the full `emit_native` entry carries. Used for
//! testing the builder pipeline; production codegen still goes
//! through `emit_native`.
//!
//! x86_64 has a different `emit_function` signature (extra
//! got_fixups + tls_total_size, no macOS TLV vectors); wiring it
//! through this entry is a separate piece of work.
//!
//! Branch fixups inside the function are resolved by
//! `emit_function` itself; the outer fixup vectors stay empty for
//! the supported scope. A populated vector returned through them
//! is a shape we don't yet handle and surfaces as an error.

#![cfg(test)]

use alloc::collections::BTreeSet;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::super::ir::FunctionSsa;
use super::{ResolvedImports, Target};

/// Compile a single [`FunctionSsa`] to a flat code blob on
/// aarch64. Returns the raw bytes of the prologue + body +
/// epilogue. Restrictions surface as `Err`:
/// * the function references a foreign symbol (`CallExt` / `TailExt`),
/// * it touches the data segment (`ImmData`) or another function's
///   body (`ImmCode`),
/// * it uses TLS (`TlsAddr`) or macOS thread-local descriptors,
/// * the host target isn't an aarch64 variant.
///
/// The first call site is the [`super::ssa_build`] regression test
/// harness; the parser will pick this up once it emits SSA directly.
pub(crate) fn compile_function_to_bytes(
    func: &FunctionSsa,
    target: Target,
) -> Result<Vec<u8>, String> {
    use super::aarch64::{Fixup, PltCallFixup};
    if !matches!(
        target,
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64,
    ) {
        return Err(format!(
            "ssa_native: target {target:?} not supported (aarch64 only)"
        ));
    }
    let alloc = super::ssa_alloc::allocate(func, target);
    let mut code: Vec<u8> = Vec::new();
    let mut fixups: Vec<Fixup> = Vec::new();
    let mut plt_call_fixups: Vec<PltCallFixup> = Vec::new();
    let mut data_fixups: Vec<super::DataFixup> = Vec::new();
    let mut pending_func_fixups: Vec<(usize, usize)> = Vec::new();
    let imports = ResolvedImports::default();
    let variadic_targets: BTreeSet<usize> = BTreeSet::new();
    let mut tls_index_fixups: Vec<super::TlsIndexFixup> = Vec::new();
    let mut macho_tlv_fixups: Vec<super::MachoTlvFixup> = Vec::new();
    let mut macho_tlv_descriptors: Vec<super::MachoTlvDescriptor> = Vec::new();
    let post_prologue_pc = func.ent_pc + crate::c5::op::Op::Ent.word_size();
    let mut bytecode_to_native: Vec<usize> = alloc::vec![0usize; post_prologue_pc + 1];

    let ok = super::ssa_emit_aarch64::emit_function(
        func,
        &alloc,
        target,
        &mut code,
        &mut fixups,
        &mut plt_call_fixups,
        &mut data_fixups,
        &mut pending_func_fixups,
        &imports,
        &variadic_targets,
        &mut tls_index_fixups,
        &mut macho_tlv_fixups,
        &mut macho_tlv_descriptors,
        &mut bytecode_to_native,
    );
    if !ok {
        return Err("ssa_native: emit_function bailed".to_string());
    }
    let outer_fixups_total = fixups.len()
        + plt_call_fixups.len()
        + data_fixups.len()
        + pending_func_fixups.len()
        + tls_index_fixups.len()
        + macho_tlv_fixups.len()
        + macho_tlv_descriptors.len();
    if outer_fixups_total != 0 {
        return Err(format!(
            "ssa_native: function produces {} cross-function fixup(s); only self-contained functions are supported",
            outer_fixups_total,
        ));
    }
    Ok(code)
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{BinOp, LoadKind};
    use super::super::ssa_build::SsaBuilder;
    use super::*;

    /// Hand-build `long sum3(int a, int b, int c) { return a + b + c; }`
    /// via [`SsaBuilder`], compile to bytes on aarch64, confirm the
    /// blob is non-empty and starts with a prologue. End-to-end
    /// JIT execution lives outside this test -- mmap+exec brings
    /// in platform-specific signing rules.
    #[test]
    fn sum3_compiles_to_nonempty_bytes() {
        let mut b = SsaBuilder::new(0, 3, false);
        let va = b.load_local(2, LoadKind::I32);
        let vb = b.load_local(3, LoadKind::I32);
        let vc = b.load_local(4, LoadKind::I32);
        let ab = b.binop(BinOp::Add, va, vb);
        let abc = b.binop(BinOp::Add, ab, vc);
        b.return_(abc);
        let func = b.finish();
        let bytes = compile_function_to_bytes(&func, Target::LinuxAarch64)
            .unwrap_or_else(|e| panic!("sum3 compile: {e}"));
        assert!(!bytes.is_empty(), "sum3 produced zero bytes");
        // emit_prologue runs three c5 param-spill stores (one per
        // declared int param), then the AAPCS64 frame setup:
        // `stp x29, x30, [sp, #-0x10]!` = 0xa9bf7bfd. Verify that
        // sentinel appears somewhere in the first 32 bytes so the
        // prologue is recognisable without pinning every byte.
        let preamble_words = bytes.len().min(32) / 4;
        let mut found_stp = false;
        for w in 0..preamble_words {
            let off = w * 4;
            let word =
                u32::from_le_bytes([bytes[off], bytes[off + 1], bytes[off + 2], bytes[off + 3]]);
            if word == 0xa9bf7bfd {
                found_stp = true;
                break;
            }
        }
        assert!(
            found_stp,
            "sum3 prologue: stp x29/x30 not found in first 32 bytes"
        );
    }
}

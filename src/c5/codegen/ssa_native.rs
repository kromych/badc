//! Direct compilation of a [`FunctionSsa`] to a stand-alone native
//! code blob on the four supported targets. Skips the `Program` /
//! bytecode tier so a producer that builds SSA directly (today: the
//! `SsaBuilder` test harness; future: the parser when it gains SSA
//! emit) can validate end-to-end against the existing allocator +
//! per-arch emit.
//!
//! Scope: a single function with no external calls, no data refs,
//! no TLS, no Mcpy, no function-pointer literals. Anything outside
//! that surface needs the cross-function fixup plumbing the full
//! [`super::emit_native`] entry carries; populated outer fixup
//! vectors surface as an error so callers don't silently lose
//! relocations.
//!
//! Branch fixups inside the function are resolved by `emit_function`
//! itself, so single-function control flow (if/else, loops) is in
//! scope.

#![cfg(test)]

use alloc::collections::BTreeSet;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::super::ir::FunctionSsa;
use super::{ResolvedImports, Target};

/// Compile a single [`FunctionSsa`] to a flat code blob. Returns
/// the raw bytes of the prologue + body + epilogue. Restrictions
/// surface as `Err`:
/// * the function references a foreign symbol (`CallExt` / `TailExt`),
/// * it touches the data segment (`ImmData`) or another function's
///   body (`ImmCode`),
/// * it uses TLS (`TlsAddr`) or macOS thread-local descriptors,
/// * the host emit bails for any other reason (unsupported shape).
///
/// Used by the [`super::ssa_build::SsaBuilder`] regression tests and
/// by future parser-side SSA emit work; production codegen still
/// flows through [`super::emit_native`].
pub(crate) fn compile_function_to_bytes(
    func: &FunctionSsa,
    target: Target,
) -> Result<Vec<u8>, String> {
    let alloc = super::ssa_alloc::allocate(func, target);
    let imports = ResolvedImports::default();
    let variadic_targets: BTreeSet<usize> = BTreeSet::new();
    let post_prologue_pc = func.ent_pc + crate::c5::op::Op::Ent.word_size();
    let mut pc_to_native: Vec<usize> = alloc::vec![0usize; post_prologue_pc + 1];
    let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();

    match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
            use super::aarch64::{Fixup, PltCallFixup};
            let mut code: Vec<u8> = Vec::new();
            let mut fixups: Vec<Fixup> = Vec::new();
            let mut plt_call_fixups: Vec<PltCallFixup> = Vec::new();
            let mut data_fixups: Vec<super::DataFixup> = Vec::new();
            let mut user_extern_data_refs: Vec<super::UserExternDataRef> = Vec::new();
            let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
                alloc::collections::BTreeMap::new();
            let mut pending_func_fixups: Vec<(usize, usize)> = Vec::new();
            let mut tls_index_fixups: Vec<super::TlsIndexFixup> = Vec::new();
            let mut macho_tlv_fixups: Vec<super::MachoTlvFixup> = Vec::new();
            let mut macho_tlv_descriptors: Vec<super::MachoTlvDescriptor> = Vec::new();
            let ok = super::ssa_emit_aarch64::emit_function(
                func,
                &alloc,
                target,
                &mut code,
                &mut fixups,
                &mut plt_call_fixups,
                &mut data_fixups,
                &mut user_extern_data_refs,
                &extern_data_names,
                &mut pending_func_fixups,
                &imports,
                &variadic_targets,
                &mut tls_index_fixups,
                &mut macho_tlv_fixups,
                &mut macho_tlv_descriptors,
                &mut pc_to_native,
                &mut ssa_line_rows,
            );
            if !ok {
                return Err("ssa_native: emit_function bailed".to_string());
            }
            let outer = fixups.len()
                + plt_call_fixups.len()
                + data_fixups.len()
                + pending_func_fixups.len()
                + tls_index_fixups.len()
                + macho_tlv_fixups.len()
                + macho_tlv_descriptors.len();
            if outer != 0 {
                return Err(format!(
                    "ssa_native: function produces {outer} cross-function fixup(s); only self-contained functions are supported",
                ));
            }
            Ok(code)
        }
        Target::LinuxX64 | Target::WindowsX64 => {
            use super::x86_64::{Fixup, PltCallFixup};
            let mut code: Vec<u8> = Vec::new();
            let mut fixups: Vec<Fixup> = Vec::new();
            let mut plt_call_fixups: Vec<PltCallFixup> = Vec::new();
            let mut got_fixups: Vec<super::GotFixup> = Vec::new();
            let mut data_fixups: Vec<super::DataFixup> = Vec::new();
            let mut user_extern_data_refs: Vec<super::UserExternDataRef> = Vec::new();
            let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
                alloc::collections::BTreeMap::new();
            let mut pending_func_fixups: Vec<(usize, usize)> = Vec::new();
            let mut tls_index_fixups: Vec<super::TlsIndexFixup> = Vec::new();
            let ok = super::ssa_emit_x86_64::emit_function(
                func,
                &alloc,
                target,
                &mut code,
                &mut fixups,
                &mut plt_call_fixups,
                &mut got_fixups,
                &mut data_fixups,
                &mut user_extern_data_refs,
                &extern_data_names,
                &mut pending_func_fixups,
                &imports,
                &variadic_targets,
                &mut tls_index_fixups,
                0,
                &mut pc_to_native,
                &mut ssa_line_rows,
            );
            if !ok {
                return Err("ssa_native: emit_function bailed".to_string());
            }
            let outer = fixups.len()
                + plt_call_fixups.len()
                + got_fixups.len()
                + data_fixups.len()
                + pending_func_fixups.len()
                + tls_index_fixups.len();
            if outer != 0 {
                return Err(format!(
                    "ssa_native: function produces {outer} cross-function fixup(s); only self-contained functions are supported",
                ));
            }
            Ok(code)
        }
    }
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{BinOp, LoadKind};
    use super::super::ssa_build::SsaBuilder;
    use super::*;

    /// Hand-build `long sum3(int a, int b, int c) { return a + b + c; }`
    /// via [`SsaBuilder`], compile to bytes on aarch64, confirm the
    /// blob is non-empty and starts with a prologue. End-to-end JIT
    /// execution lives outside this test -- mmap+exec brings in
    /// platform-specific signing rules.
    #[test]
    fn sum3_compiles_to_nonempty_bytes_aarch64() {
        let mut b = SsaBuilder::new(0, 3, false);
        let va = b.load_local(2, LoadKind::I32);
        let vb = b.load_local(3, LoadKind::I32);
        let vc = b.load_local(4, LoadKind::I32);
        let ab = b.binop(BinOp::Add, va, vb);
        let abc = b.binop(BinOp::Add, ab, vc);
        b.return_(abc);
        let func = b.finish();
        let bytes = compile_function_to_bytes(&func, Target::LinuxAarch64)
            .unwrap_or_else(|e| panic!("sum3 aarch64: {e}"));
        assert!(!bytes.is_empty(), "sum3 produced zero bytes");
        // emit_prologue runs three c5 param-spill stores (one per
        // declared int param), then the AAPCS64 frame setup:
        // `stp x29, x30, [sp, #-0x10]!` = 0xa9bf7bfd. Verify the
        // sentinel appears in the first 32 bytes so the prologue
        // is recognisable without pinning every byte.
        let preamble_words = bytes.len().min(32) / 4;
        let found_stp = (0..preamble_words).any(|w| {
            let off = w * 4;
            u32::from_le_bytes([bytes[off], bytes[off + 1], bytes[off + 2], bytes[off + 3]])
                == 0xa9bf7bfd
        });
        assert!(
            found_stp,
            "sum3 prologue: stp x29/x30 not found in first 32 bytes"
        );
    }

    /// Same function on x86_64 Linux. Validates that the dispatch
    /// reaches the SysV emit path and produces a SysV prologue.
    /// The c5 x86_64 emit prepends REX-prefixed `push r9` / `push
    /// r8` / ... for caller-saved param spills, so the SysV
    /// `push rbp` (0x55) lands after them rather than at byte 0.
    /// Search the first 32 bytes for `push rbp` followed by
    /// `mov rbp, rsp` (0x48 0x89 0xe5).
    #[test]
    fn sum3_compiles_to_nonempty_bytes_x86_64() {
        let mut b = SsaBuilder::new(0, 3, false);
        let va = b.load_local(2, LoadKind::I32);
        let vb = b.load_local(3, LoadKind::I32);
        let vc = b.load_local(4, LoadKind::I32);
        let ab = b.binop(BinOp::Add, va, vb);
        let abc = b.binop(BinOp::Add, ab, vc);
        b.return_(abc);
        let func = b.finish();
        let bytes = compile_function_to_bytes(&func, Target::LinuxX64)
            .unwrap_or_else(|e| panic!("sum3 x86_64: {e}"));
        assert!(!bytes.is_empty(), "sum3 produced zero bytes");
        // c5 x86_64 prologue: `pop r10` (return addr), per-param
        // `sub rsp,16; mov [rsp],reg`, `push r10`, then the SysV
        // `push rbp; mov rbp, rsp; sub rsp, frame_bytes`. For three
        // i32 params the SysV `push rbp` lands ~32 bytes in.
        let head = &bytes[..bytes.len().min(64)];
        let push_rbp = head.iter().position(|&b| b == 0x55);
        let mov_rbp_rsp = head.windows(3).position(|w| w == [0x48, 0x89, 0xe5]);
        match (push_rbp, mov_rbp_rsp) {
            (Some(p), Some(m)) if m == p + 1 => {}
            _ => panic!(
                "sum3 x86_64: push rbp / mov rbp, rsp not adjacent in prologue head {head:02x?}"
            ),
        }
    }

    /// `int max2(int a, int b) { if (a > b) return a; return b; }`
    /// exercises an in-function branch: SsaBuilder allocates two
    /// blocks, the entry block emits a `branch_zero`, the second
    /// block returns the alternate value. Confirms the allocator's
    /// PC-based last-use spans branch fixups correctly on both
    /// targets.
    fn build_max2() -> super::super::super::ir::FunctionSsa {
        use super::super::super::ir::StoreKind;
        let mut b = SsaBuilder::new(0, 2, false);
        let a = b.load_local(2, LoadKind::I32);
        let b_param = b.load_local(3, LoadKind::I32);
        // `a > b` lowers as `gt` -> 0/1; branch on the bool.
        let cond = b.binop(BinOp::Gt, a, b_param);
        // Spare side effect to give the allocator a store to walk.
        let _ = b.store_local(-1, cond, StoreKind::I64);
        let then_blk = b.new_block();
        let else_blk = b.new_block();
        b.branch_zero(cond, else_blk, then_blk);
        b.switch_to(then_blk);
        b.return_(a);
        b.switch_to(else_blk);
        b.return_(b_param);
        b.finish()
    }

    #[test]
    fn max2_compiles_on_aarch64() {
        let func = build_max2();
        let bytes = compile_function_to_bytes(&func, Target::LinuxAarch64)
            .unwrap_or_else(|e| panic!("max2 aarch64: {e}"));
        // Two return blocks => at least two `ret` (0xd65f03c0) words.
        let ret_count = bytes
            .chunks_exact(4)
            .filter(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]) == 0xd65f03c0)
            .count();
        assert!(
            ret_count >= 2,
            "max2 aarch64: expected >=2 ret words, got {ret_count}"
        );
    }

    #[test]
    fn max2_compiles_on_x86_64() {
        let func = build_max2();
        let bytes = compile_function_to_bytes(&func, Target::LinuxX64)
            .unwrap_or_else(|e| panic!("max2 x86_64: {e}"));
        // Two return blocks => at least two `ret` (0xc3) bytes
        // (epilogue tail). Allow `c3` to appear as a displacement
        // byte by also requiring it to be the *last* byte.
        assert_eq!(*bytes.last().unwrap(), 0xc3, "max2 x86_64: tail isn't ret");
        let ret_count = bytes.iter().filter(|&&b| b == 0xc3).count();
        assert!(
            ret_count >= 2,
            "max2 x86_64: expected >=2 0xc3 bytes (ret), got {ret_count}"
        );
    }
}

//! Codegen tests: compile a fixture and inspect post-link metadata.

use super::compile_fixture_bare;

#[test]
fn entry_pc_points_at_main() {
    // `main` is the first (and only) function in this fixture, so its
    // ent_pc is 0.
    let program = compile_fixture_bare("ir_translation_simple.c");
    assert_eq!(program.entry_pc, 0);
}

/// Every emitted binary -- regardless of target -- carries the
/// `OUTPUT_MARKER` at the tail of the code section so a `strings`
/// scan reveals the badc version that produced it. The marker is
/// appended in `codegen::lower_for` after the per-arch `lower()`
/// returns; nothing references those bytes, so they're invisible
/// at runtime but easy to find on disk.
///
/// The marker carries the release version only. The git commit /
/// branch / remote that `--version` reports (`BUILD_INFO`) must
/// NOT appear in output: they vary with the build environment and
/// would make identical source/flags/target produce different
/// bytes depending on where badc was built. This test asserts
/// both the version marker is present and the git fields are
/// absent.
#[test]
fn output_marker_is_version_only_and_present_in_every_target() {
    use crate::{NativeOptions, Target};
    let program = super::compile_str("int main() { return 0; }");
    // `OUTPUT_MARKER` is `BADC\n\tv<version>` (see `src/lib.rs`).
    let needle = crate::OUTPUT_MARKER.as_bytes();
    // The git tail only ever appears in `BUILD_INFO`; its label
    // `\n\tcommit ` must not reach the output.
    let git_tail = b"\n\tcommit ";
    for target in [
        Target::MacOSAarch64,
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let bytes = crate::c5::codegen::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::default(),
        )
        .unwrap_or_else(|e| panic!("emit_native({target:?}): {e}"));
        let found = bytes.windows(needle.len()).any(|w| w == needle);
        assert!(
            found,
            "{target:?}: expected `OUTPUT_MARKER` in emitted binary"
        );
        let leaked = bytes.windows(git_tail.len()).any(|w| w == git_tail);
        assert!(
            !leaked,
            "{target:?}: git provenance leaked into output -- breaks reproducibility"
        );
    }
}

/// `-g` / `with_debug_info(true)` carries DWARF into the emitted
/// image; the default (off) strips it. The `debug_info` substring
/// shows up in the section-name tables of every format the writer
/// emits: ELF has `.debug_info` in `.shstrtab`, PE has `.debug_info`
/// in the COFF string table (the 8-char section-name field
/// overflows to the strtab), Mach-O has `__debug_info` in its
/// `Section64` table. Presence / absence is a single substring
/// scan per target.
#[test]
fn with_debug_info_false_strips_dwarf_for_every_target() {
    use crate::{NativeOptions, Target};
    let program = super::compile_str("int main() { return 0; }");
    let needle = b"debug_info";
    for target in [
        Target::MacOSAarch64,
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let on = crate::c5::codegen::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::new().with_debug_info(true),
        )
        .unwrap_or_else(|e| panic!("emit_native(on, {target:?}): {e}"));
        assert!(
            on.windows(needle.len()).any(|w| w == needle),
            "{target:?}: expected `debug_info` section name in the DWARF-on (`-g`) image"
        );
        let off = crate::c5::codegen::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::new().with_debug_info(false),
        )
        .unwrap_or_else(|e| panic!("emit_native(off, {target:?}): {e}"));
        assert!(
            !off.windows(needle.len()).any(|w| w == needle),
            "{target:?}: `debug_info` byte sequence leaked into the no-debug image \
             (DWARF section name should be gone)"
        );
        assert!(
            off.len() < on.len(),
            "{target:?}: no-debug image ({} bytes) should be strictly smaller than \
             default ({} bytes)",
            off.len(),
            on.len()
        );
    }
}

/// Every emitted target gets one PLT trampoline per import
/// plus a matching local-name symbol table entry. The
/// trampoline lets `gdb b malloc` resolve into the produced
/// binary instead of getting lost in the dynamic linker; the
/// local symbol gives the trampoline a real name (`nm` shows
/// it, `objdump -d` annotates calls with `malloc@plt`-style
/// labels).
///
/// Cross-target structural check: a tiny program that calls
/// `printf` emits a binary whose bytes contain the import name
/// at least twice -- once in the dynamic-import table and once
/// in the static symtab (PE COFF symtab / ELF `.symtab` /
/// Mach-O `__LINKEDIT` symbol entries).
#[test]
fn plt_trampoline_local_names_appear_in_every_target() {
    use crate::{NativeOptions, Target};
    // Call `printf` so the resolver pulls it in as an import on
    // every target (the test prelude `#include <stdio.h>` is
    // already wired up via `compile_str`). With the import in
    // hand, the assertions below check that the binary's bytes
    // contain the import name at least twice -- once in the
    // dynamic-import table and once in the static (PLT-trampoline)
    // symbol table the linker emits per target.
    let program = super::compile_str("int main() { printf(\"x\"); return 0; }");
    let needle = b"printf";
    for target in [
        Target::MacOSAarch64,
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let bytes = crate::c5::codegen::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::default(),
        )
        .unwrap_or_else(|e| panic!("emit_native({target:?}): {e}"));
        let occurrences = bytes.windows(needle.len()).filter(|w| *w == needle).count();
        assert!(
            occurrences >= 2,
            "{target:?}: expected `printf` byte sequence at least twice (dynamic \
             import + local PLT-trampoline symbol), found {occurrences}"
        );
    }
}

/// A profiler attributes a sample by `[st_value, st_value + st_size)`,
/// so every defined function must carry a non-zero `st_size` in the ELF
/// `.symtab` -- perf / `nm` / `gdb` otherwise cannot name the address.
/// The static `priv` exercises the merged-path local-symbol carry
/// (`link_native_objects` -> `local_funcs` -> synth `func_names`), which
/// a previous globals-only attempt missed; `pub` / `main` cover the
/// global path. Link the program and confirm all three appear as sized
/// `STT_FUNC` symbols.
#[test]
fn defined_functions_get_sized_symtab_entries() {
    use crate::{NativeOptions, Target};
    // Compile without the header prelude: the program needs no libc,
    // and pulling the prelude would drag a tentative `environ` into the
    // link alongside the runtime's definition.
    let program = super::compile_str_bare(
        "static int priv(int x){return x*x;} \
         int pub(int x){return priv(x)+1;} \
         int main(){return pub(7);}",
    );
    let bytes =
        super::link_executable_with_runtime(&program, Target::LinuxX64, NativeOptions::default())
            .expect("link LinuxX64");
    let funcs = elf_func_symbols(&bytes);
    for name in ["priv", "pub", "main"] {
        let size = funcs.iter().find(|(n, _)| n == name).map(|(_, s)| *s);
        assert!(
            matches!(size, Some(s) if s > 0),
            "function `{name}` must have a non-zero .symtab st_size; got {size:?} \
             (all FUNC symbols: {funcs:?})"
        );
    }
}

/// Walk an emitted ELF64 `.symtab` and return `(name, st_size)` for
/// every `STT_FUNC` entry. Minimal fixed-offset parse for the symbol-
/// size regression above.
fn elf_func_symbols(b: &[u8]) -> alloc::vec::Vec<(alloc::string::String, u64)> {
    let u16a = |o: usize| u16::from_le_bytes(b[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
    let u64a = |o: usize| u64::from_le_bytes(b[o..o + 8].try_into().unwrap());
    let shoff = u64a(0x28) as usize;
    let shentsize = u16a(0x3a) as usize;
    let shnum = u16a(0x3c) as usize;
    // SHT_SYMTAB == 2; its sh_link names the matching .strtab section.
    let mut symtab_sh = None;
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        if u32a(sh + 4) == 2 {
            symtab_sh = Some(sh);
            break;
        }
    }
    let Some(sh) = symtab_sh else {
        return alloc::vec::Vec::new();
    };
    let sym_off = u64a(sh + 0x18) as usize;
    let sym_len = u64a(sh + 0x20) as usize;
    let strsh = shoff + (u32a(sh + 0x28) as usize) * shentsize;
    let str_off = u64a(strsh + 0x18) as usize;
    let mut out = alloc::vec::Vec::new();
    let mut p = sym_off;
    while p + 24 <= sym_off + sym_len {
        let st_name = u32a(p) as usize;
        let st_info = b[p + 4];
        let st_size = u64a(p + 16);
        if st_info & 0xf == 2 {
            let s = str_off + st_name;
            let e = b[s..].iter().position(|&c| c == 0).map_or(s, |n| s + n);
            out.push((
                alloc::string::String::from_utf8_lossy(&b[s..e]).into_owned(),
                st_size,
            ));
        }
        p += 24;
    }
    out
}

/// A block whose unconditional `Jmp` targets the next block in layout
/// must fall through, not emit a jump to the immediately-following
/// instruction (`e9 00 00 00 00` -- `jmp rel32 = 0` -- on x86-64). Such
/// dead jumps inflate the dynamic branch count and code size. Compile a
/// branchy function and confirm the byte sequence is absent.
#[test]
fn jmp_to_next_block_falls_through() {
    use crate::{NativeOptions, Target};
    let program = super::compile_str_bare(
        "int f(int x){ int r; if(x>0){r=1;}else{r=2;} return r+x; } \
         int main(){ return f(3); }",
    );
    let bytes = crate::c5::codegen::emit_native_single_tu_for_test(
        &program,
        Target::LinuxX64,
        NativeOptions::new().with_optimize(),
    )
    .expect("emit LinuxX64");
    let dead = bytes
        .windows(5)
        .filter(|w| *w == [0xe9, 0x00, 0x00, 0x00, 0x00])
        .count();
    assert_eq!(
        dead, 0,
        "found {dead} `jmp +0` (dead fall-through jump) byte sequences"
    );
}

/// C99 6.3.1.8 + 6.5p5: the walker emits the post-binop
/// sign-narrow as `Binop(Shl, X, Imm(32)); Binop(Shr, _, Imm(32))`.
/// The aarch64 allocator's sxtw fold collapses that pair into a
/// single `SXTW Xd, Wn` (`SBFM Xd, Xn, #0, #31`); the x86_64
/// emit picks `movsxd r64, r32`. Verify the encoded byte
/// sequence shows up in the emitted text and the two-shift
/// pair does not.
#[test]
fn sxtw_fold_collapses_int_mul_sign_narrow() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str(
        "int product(int a, int b) { return a * b; } int main() { return product(7, 6); }",
    );
    let bytes_arm =
        emit_native_with_options(&program, Target::MacOSAarch64, NativeOptions::default())
            .expect("emit_native MacOSAarch64");
    // SXTW (SBFM with immr=0, imms=31) carries the fixed high bytes
    // 0x40 0x93 regardless of the rd / rn register fields. Scan for
    // that opcode signature so the assertion stays reg-agnostic.
    let any_sxtw = bytes_arm.windows(4).any(|w| w[2] == 0x40 && w[3] == 0x93);
    assert!(
        any_sxtw,
        "expected an SXTW byte pattern in aarch64 image (the sign-narrow Shl/Shr pair did not fold)",
    );
    // Pre-fold: the lsl #32 / asr #32 pair was materialised through a
    // `movz xN, #32` before the lsl. `#32` lives in bits 21..5 of the
    // movz word, so the encoded value 32 produces high bytes 0x80 0xd2
    // regardless of which N gets picked. Their absence confirms the
    // fold removed the shift pair.
    let any_movz_32 = bytes_arm
        .windows(4)
        .any(|w| w[2] == 0x80 && w[3] == 0xd2 && w[1] == 0x04);
    assert!(
        !any_movz_32,
        "expected the pre-fold `movz xN, #32` pattern to be absent post-fold",
    );

    let bytes_x64 = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit_native LinuxX64");
    // movsxd r, r: REX.W prefix (0x48..0x4f with W=1), opcode 0x63,
    // ModR/M with mod=11 (register direct). Scan for that shape so
    // the test does not depend on which register the allocator picks.
    let any_movsxd_r_r = bytes_x64.windows(3).any(|w| {
        let rex = w[0];
        (rex & 0xf0) == 0x40 && (rex & 0x08) != 0 && w[1] == 0x63 && (w[2] & 0xc0) == 0xc0
    });
    assert!(
        any_movsxd_r_r,
        "expected a `movslq` reg/reg byte pattern in x86_64 image",
    );
}

/// C99 6.6 constant-expression evaluation: both-IntLit operands
/// fold to a single SSA `Imm`. The walker's `Expr::Binary` arm
/// detects this and emits no binop at all. Run via the in-process
/// JIT so the fold is verified end-to-end.
#[test]
fn constant_fold_evaluates_binops_at_translation_time() {
    use crate::{Compiler, jit_run};
    // Each return value exercises one folded shape. The compile
    // succeeds only if the fold produces a valid `Imm`; the JIT
    // exit code confirms the value is correct.
    let src = "
        int add(void)   { return 7 + 3; }
        int sub(void)   { return 100 - 42; }
        int mul(void)   { return 4 * 6; }
        int and_op(void){ return 0xff & 0x0f; }
        int or_op(void) { return 0x10 | 0x01; }
        int xor_op(void){ return 0xff ^ 0x0f; }
        int shl(void)   { return 1 << 8; }
        int shr(void)   { return 0x100 >> 4; }
        int eq_lt(void) { return 5 < 9; }
        int main(void) {
            if (add()    != 10)   return 1;
            if (sub()    != 58)   return 2;
            if (mul()    != 24)   return 3;
            if (and_op() != 0x0f) return 4;
            if (or_op()  != 0x11) return 5;
            if (xor_op() != 0xf0) return 6;
            if (shl()    != 256)  return 7;
            if (shr()    != 0x10) return 8;
            if (eq_lt()  != 1)    return 9;
            return 0;
        }
    ";
    let program = Compiler::new(src.into())
        .compile()
        .expect("constant-fold fixture compiles");
    let exit = jit_run(&program, &["constant_fold".to_string()])
        .expect("constant-fold fixture runs under JIT");
    assert_eq!(
        exit, 0,
        "constant-fold values must match standard arithmetic"
    );
}

/// Algebraic peepholes inside `SsaBuilder::binop_imm`: identity
/// rhs values (`Add/Sub/Or/Xor/Shift` with 0, `Mul` with 1,
/// `And` with -1) return the lhs unchanged; zero-collapse rhs
/// values (`Mul/And` with 0) produce `Imm(0)`. The compiler
/// always reaches these through `binop_imm` so each shape lands
/// in the SSA stream as either the lhs or a single Imm, and
/// the JIT exit confirms the value matches standard arithmetic.
#[test]
fn ssa_build_binop_imm_identity_and_zero_collapse() {
    use crate::{Compiler, jit_run};
    let src = "
        int identity_add(int x) { return x + 0; }
        int identity_sub(int x) { return x - 0; }
        int identity_or(int x)  { return x | 0; }
        int identity_xor(int x) { return x ^ 0; }
        int identity_shl(int x) { return x << 0; }
        int identity_shr(int x) { return x >> 0; }
        int identity_mul(int x) { return x * 1; }
        int identity_and(int x) { return x & -1; }
        int collapse_mul(int x) { return x * 0; }
        int collapse_and(int x) { return x & 0; }
        int main(void) {
            if (identity_add(42)  != 42) return 1;
            if (identity_sub(42)  != 42) return 2;
            if (identity_or(42)   != 42) return 3;
            if (identity_xor(42)  != 42) return 4;
            if (identity_shl(42)  != 42) return 5;
            if (identity_shr(42)  != 42) return 6;
            if (identity_mul(42)  != 42) return 7;
            if (identity_and(42)  != 42) return 8;
            if (collapse_mul(42)  != 0)  return 9;
            if (collapse_and(42)  != 0)  return 10;
            return 0;
        }
    ";
    let program = Compiler::new(src.into())
        .compile()
        .expect("identity/collapse fixture compiles");
    let exit = jit_run(&program, &["identity_collapse".to_string()])
        .expect("identity/collapse fixture runs under JIT");
    assert_eq!(
        exit, 0,
        "binop_imm identity / zero-collapse folds must preserve C99 semantics"
    );
}

/// A non-variadic callee whose every register-passed parameter is
/// `Inst::ParamRef`-seeded, has no address taken, and whose c5
/// cdecl slots have no surviving `LoadLocal` or `StoreLocal` with
/// consumers compiles with `frame.param_spill_bytes == 0`. The
/// prologue then skips the host-arg-reg spill block entirely and
/// the epilogue skips the matching `add sp` / `pop+add+push`
/// sequence. The structural marker -- the absence of any sub-then-str
/// shape pinned to a 16-byte stride -- locks the elision in. A
/// regression that brings back the spill (e.g. by dropping the
/// `frame.param_spill_bytes > 0` gate) gets caught here before it
/// reaches the perf workloads.
#[test]
fn native_eligible_callee_skips_param_spill_in_prologue() {
    use crate::{Compiler, NativeOptions, Target, emit_native_with_options};
    // `fib` reads `n` four times after mem2reg promotion; with the
    // `ParamRef` seed plus the prologue helper the slot drops out.
    let src = "
        static long fib(int n) {
            if (n < 2) return (long)n;
            return fib(n - 1) + fib(n - 2);
        }
        int main(void) { return (int)(fib(10) - 55); }
    ";
    let program = Compiler::new(crate::c5::tests::with_prelude(src))
        .compile()
        .expect("compile");
    let bytes = emit_native_with_options(
        &program,
        Target::MacOSAarch64,
        NativeOptions::new().with_optimize(),
    )
    .expect("emit_native");
    // The prologue's elided shape begins with the combined
    // `stp x29, x30, [sp, -0x10]!` (encoded as
    // `0xa9_bf_7b_fd`). The unelided shape begins with the
    // host-arg-reg spill `str x_i, [sp, -0x10]!` (or its
    // `sub sp, sp, #16` skip variant) -- neither encodes to
    // `0xa9_bf_7b_fd` as the first word at any callee's entry.
    // Scan the .text section's bytes for the elided stp at
    // some 4-byte-aligned offset; absence is the regression
    // marker.
    let stp_word: [u8; 4] = 0xa9_bf_7b_fd_u32.to_le_bytes();
    let found = bytes.windows(4).any(|w| w == stp_word);
    assert!(
        found,
        "expected the Native-elided prologue's `stp x29, x30, [sp, -16]!` byte word \
         (0xa9bf7bfd) to appear in the emitted .text; if absent, the elision \
         regressed and every fully-Native callee paid the c5 cdecl spill"
    );
}

/// A function whose only user-local has every store killed by
/// mem2reg's write-only-slot pass and uses no callee-saved
/// registers should have its frame allocation skipped: no `sub sp`
/// for the local, no x19 reservation, no `add sp` in the epilogue.
/// Verified by inspecting the byte stream for the `sub sp, sp, #16`
/// and `sub sp, sp, #32` words that the prior frame layout emitted
/// for this shape.
///
/// Without this elision, `int foo(void) { int a = 1; a = 2; return
/// 1; }` lowered with -O paid eight extra bytes of frame plus the
/// matching `sub sp` / `add sp` pair on every call. With this
/// commit the function lowers to `stp fp,lr; mov fp,sp; mov w0,1;
/// ldp fp,lr; ret` -- five instructions, twenty bytes.
#[test]
fn dead_local_only_function_skips_frame_sub_sp() {
    use crate::{Compiler, NativeOptions, Target, emit_native_with_options};
    let src = "
        static int foo(void) {
            int a = 1;
            a = 2;
            return 1;
        }
        int main(void) { return foo(); }
    ";
    let program = Compiler::new(crate::c5::tests::with_prelude(src))
        .compile()
        .expect("compile");
    // This asserts an exact frame-elision shape, which holds only with
    // the full register file; pin the allocator to the full pool so the
    // codegen_test pressure knobs (BADC_MAX_GPR / BADC_MAX_FPR) do not
    // perturb it.
    let bytes =
        crate::c5::codegen::ssa_alloc::with_pool_size_override(usize::MAX, usize::MAX, || {
            emit_native_with_options(
                &program,
                Target::MacOSAarch64,
                NativeOptions::new().with_optimize(),
            )
        })
        .expect("emit_native");
    // Foo's fully-elided shape is exactly two consecutive words:
    //   movz x0, #1                   -> 0xd2800020
    //   ret                           -> 0xd65f03c0
    // The leaf-prologue elision plus the empty-frame elision means
    // foo has no stp / mov fp,sp / sub sp / ldp / add sp / any
    // saves. A regression that reinstates the stp prologue breaks
    // the two-word adjacency. Other functions in the binary (the
    // c5 runtime shims, the start stub) can legitimately emit
    // `movz x0, #1` followed by something else; this positive
    // pattern stays specific to foo because nothing else returns
    // 1 with zero prologue.
    let movz_x0_1 = 0xd2800020_u32.to_le_bytes();
    let ret_x30 = 0xd65f03c0_u32.to_le_bytes();
    let mut found = false;
    for w in bytes.windows(8) {
        if w[0..4] == movz_x0_1 && w[4..8] == ret_x30 {
            found = true;
            break;
        }
    }
    assert!(
        found,
        "expected foo's leaf+frame-elided two-word shape \
         (movz x0, #1; ret) consecutive in .text; the absence means \
         either the frame elision regressed (some `sub sp` or `stp` \
         word slipped in) or the leaf elision regressed (the standard \
         prologue's stp x29, x30 came back). foo should compile to \
         exactly two instructions under -O on AAPCS64"
    );
}

/// True when `needle` appears as a contiguous subslice of `hay`.
fn contains_bytes(hay: &[u8], needle: &[u8]) -> bool {
    hay.windows(needle.len()).any(|w| w == needle)
}

/// Microsoft ARM64 calling convention: a c5-internal variadic call on
/// Windows-on-ARM64 follows the host variadic ABI rather than the c5
/// cdecl 16-byte stack push. The callee spills all eight integer
/// argument registers x0..x7 into a 64-byte gr-save area above the
/// saved fp/lr, the named parameters and the variadic tail share an
/// 8-byte cell stride, and `va_arg` walks that stride. This locks the
/// byte-level signatures on the macOS host (which emits but cannot run
/// the PE) so a regression that reverts the call site to the 16-byte
/// push, drops the x7 spill, or restores the 16-byte `va_arg` stride is
/// caught without a Windows box.
#[test]
fn c5_internal_variadic_lowers_to_win_arm64_host_abi() {
    use crate::{Compiler, NativeOptions, Target};
    let src = r#"
        #include <stdarg.h>
        int vsum(int count, ...) {
            va_list ap;
            int total;
            int i;
            total = 0;
            va_start(ap, count);
            for (i = 0; i < count; i = i + 1)
                total = total + va_arg(ap, int);
            va_end(ap);
            return total;
        }
        int main(void) { return vsum(3, 10, 20, 30); }
    "#;
    let program = Compiler::with_target(super::with_prelude(src), Target::WindowsAarch64)
        .compile()
        .expect("compile");
    // Byte-exact assertions hold only with the full register file; pin
    // the allocator to the full pool so the codegen_test pressure knobs
    // (BADC_MAX_GPR / BADC_MAX_FPR) do not perturb the encoding.
    let bytes =
        crate::c5::codegen::ssa_alloc::with_pool_size_override(usize::MAX, usize::MAX, || {
            crate::c5::codegen::emit_native_single_tu_for_test(
                &program,
                Target::WindowsAarch64,
                NativeOptions::default(),
            )
            .expect("emit_native windows-arm64")
        });

    // Callee gr-save spill of x7: `str x7, [sp, #0x38]` (the eighth and
    // last 8-byte slot of the 64-byte gr-save area). A non-variadic
    // callee spills only its named parameters, so x7 is spilled here
    // only because the variadic callee homes the whole x0..x7 bank.
    // Encoding f9001fe7 (little-endian e7 1f 00 f9).
    let str_x7_sp_0x38 = 0xf9001fe7u32.to_le_bytes();
    assert!(
        contains_bytes(&bytes, &str_x7_sp_0x38),
        "win-arm64 variadic callee must spill x7 into the gr-save slot [sp+0x38]"
    );

    // va_start / va_arg advance the cursor by 8 (the Microsoft ARM64
    // va_list stride), not 16. The advance is `add x16, x17, #0x8`
    // (91002230); the Linux aarch64 c5 cdecl path would emit
    // `add x16, x17, #0x10` (91004230). Assert the 8-byte-stride form is
    // present and the 16-byte-stride form is absent for this shape.
    let add_stride8 = 0x91002230u32.to_le_bytes();
    let add_stride16 = 0x91004230u32.to_le_bytes();
    assert!(
        contains_bytes(&bytes, &add_stride8),
        "win-arm64 va_arg / va_start must advance the cursor by 8"
    );
    assert!(
        !contains_bytes(&bytes, &add_stride16),
        "win-arm64 must not emit the 16-byte c5 cdecl va_list stride for this function"
    );
}

/// A program defining its own `__c5_entry` links freestanding: the
/// embedded runtime is not linked (no `__c5_exit` / `environ`), the
/// image entry is `__c5_entry`, and the default `main` need not exist.
#[test]
fn user_defined_c5_entry_links_freestanding() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    let src = "\
        #pragma dylib(libc, \"libc.so.6\")\n\
        #pragma binding(libc::exit, \"exit\")\n\
        extern void exit(int);\n\
        void __c5_entry(void *sp, long off) { (void)sp; (void)off; exit(0); }\n";
    let program = Compiler::with_options(
        src.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    // Links without a `main` and without the embedded runtime.
    let bytes = super::link_freestanding(&program, Target::LinuxX64, NativeOptions::default())
        .expect("freestanding link must not require `main`");
    let has = |needle: &str| bytes.windows(needle.len()).any(|w| w == needle.as_bytes());
    assert!(
        !has("__c5_exit"),
        "freestanding image must not pull in the runtime __c5_exit"
    );
    assert!(
        !has("environ"),
        "freestanding image must not pull in the runtime environ"
    );
}

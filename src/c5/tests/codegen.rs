//! Codegen tests: compile a fixture and inspect `program.text` byte-for-byte.
//!
//! These tests assert exact instruction sequences, so they bypass the
//! standard `TEST_PRELUDE`. `<stdio.h>` carries a lazy-stream resolver
//! helper (see `headers/include/stdio.h`) -- pulling it in would prepend
//! that helper's bytecode to every program and shift every PC offset.

use super::{Op, compile_fixture_bare};

#[test]
fn simple_return() {
    let program = compile_fixture_bare("ir_translation_simple.c");
    // Every function header is `Ent <locals> AllocaInit <slot>`.
    // For a function that doesn't use alloca, AllocaInit's operand
    // is 0 and the native codegen treats it as a no-op.
    let expected = vec![
        Op::Ent as i64,
        0,
        Op::AllocaInit as i64,
        0,
        Op::Imm as i64,
        42,
        Op::Lev as i64,
        Op::Lev as i64,
    ];
    assert_eq!(program.text, expected);
}

#[test]
fn if_else() {
    let program = compile_fixture_bare("ir_translation_if.c");
    let bz_target = 13;
    let jmp_target = 16;
    let expected = vec![
        Op::Ent as i64,
        0,
        Op::AllocaInit as i64,
        0,
        Op::Imm as i64,
        1,
        Op::Bz as i64,
        bz_target,
        Op::Imm as i64,
        2,
        Op::Lev as i64,
        Op::Jmp as i64,
        jmp_target,
        Op::Imm as i64,
        3,
        Op::Lev as i64,
        Op::Lev as i64,
    ];
    assert_eq!(program.text, expected);
}

#[test]
fn while_loop() {
    let program = compile_fixture_bare("ir_translation_while.c");
    let bz_target = 13;
    let jmp_target = 4;
    let expected = vec![
        Op::Ent as i64,
        0,
        Op::AllocaInit as i64,
        0,
        Op::Imm as i64,
        0,
        Op::Bz as i64,
        bz_target,
        Op::Imm as i64,
        1,
        Op::Lev as i64,
        Op::Jmp as i64,
        jmp_target,
        Op::Lev as i64,
    ];
    assert_eq!(program.text, expected);
}

#[test]
fn entry_pc_points_at_main() {
    // `main` is the first (and only) function in this fixture, so its
    // bytecode starts at PC 0.
    let program = compile_fixture_bare("ir_translation_simple.c");
    assert_eq!(program.entry_pc, 0);
}

/// Every emitted binary -- regardless of target -- carries the
/// `BUILD_INFO` marker at the tail of the code section so a
/// `strings` scan reveals the badc revision that produced it.
/// The marker is appended in `codegen::lower_for` after the
/// per-arch `lower()` returns; nothing references those bytes,
/// so they're invisible at runtime but easy to find on disk.
#[test]
fn build_info_marker_appears_in_every_target() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str("int main() { return 0; }");
    let needle = b"PRODUCED BY BADC";
    for target in [
        Target::MacOSAarch64,
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let bytes = emit_native_with_options(&program, target, NativeOptions::default())
            .unwrap_or_else(|e| panic!("emit_native({target:?}): {e}"));
        let found = bytes.windows(needle.len()).any(|w| w == needle);
        assert!(
            found,
            "{target:?}: expected `PRODUCED BY BADC` marker in emitted binary"
        );
    }
}

/// `--no-debug` / `with_debug_info(false)` strips DWARF from
/// the emitted image. The `debug_info` substring shows up in
/// the section-name tables of every format the writer emits:
/// ELF has `.debug_info` in `.shstrtab`, PE has `.debug_info`
/// in the COFF string table (the 8-char section-name field
/// overflows to the strtab), Mach-O has `__debug_info` in its
/// `Section64` table. Presence / absence is a single substring
/// scan per target. Default options keep DWARF on; the toggle
/// drops every byte of it.
#[test]
fn with_debug_info_false_strips_dwarf_for_every_target() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str("int main() { return 0; }");
    let needle = b"debug_info";
    for target in [
        Target::MacOSAarch64,
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let on = emit_native_with_options(&program, target, NativeOptions::default())
            .unwrap_or_else(|e| panic!("emit_native(on, {target:?}): {e}"));
        assert!(
            on.windows(needle.len()).any(|w| w == needle),
            "{target:?}: expected `debug_info` section name in default (DWARF-on) image"
        );
        let off = emit_native_with_options(
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
    use crate::{NativeOptions, Target, emit_native_with_options};
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
        let bytes = emit_native_with_options(&program, target, NativeOptions::default())
            .unwrap_or_else(|e| panic!("emit_native({target:?}): {e}"));
        let occurrences = bytes.windows(needle.len()).filter(|w| *w == needle).count();
        assert!(
            occurrences >= 2,
            "{target:?}: expected `printf` byte sequence at least twice (dynamic \
             import + local PLT-trampoline symbol), found {occurrences}"
        );
    }
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
    // `SXTW X13, W13` = 0x93407dad. Encoded little-endian: ad 7d 40 93.
    let sxtw_x13_x13 = [0xadu8, 0x7d, 0x40, 0x93];
    assert!(
        bytes_arm.windows(4).any(|w| w == sxtw_x13_x13),
        "expected SXTW byte pattern in aarch64 image (the sign-narrow Shl/Shr pair did not fold)",
    );
    // Pre-fold pattern: `movz x14, #32` (0e 04 80 d2) immediately
    // before the lsl. If the fold misses, we expect this byte
    // pattern; if it fires, it should be gone for this function.
    let movz_x14_32 = [0x0eu8, 0x04, 0x80, 0xd2];
    assert!(
        !bytes_arm.windows(4).any(|w| w == movz_x14_32),
        "expected the pre-fold `movz x14, #32` pattern to be absent post-fold",
    );

    let bytes_x64 = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit_native LinuxX64");
    // `movslq %r15d, %r15` = 4d 63 ff. The fold's x86_64 variant
    // lands a 3-byte movsxd somewhere in `product`.
    let movsxd_r15_r15d = [0x4du8, 0x63, 0xff];
    assert!(
        bytes_x64.windows(3).any(|w| w == movsxd_r15_r15d),
        "expected `movslq %r15d, %r15` byte pattern in x86_64 image",
    );
}

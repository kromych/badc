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
    let expected = vec![
        Op::Ent as i64,
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
    let bz_target = 11;
    let jmp_target = 14;
    let expected = vec![
        Op::Ent as i64,
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
    let bz_target = 11;
    let jmp_target = 2;
    let expected = vec![
        Op::Ent as i64,
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

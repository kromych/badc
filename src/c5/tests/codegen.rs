//! Codegen tests: compile a fixture and inspect `program.text` byte-for-byte.

use super::{Op, compile_fixture};

#[test]
fn simple_return() {
    let program = compile_fixture("ir_translation_simple.c");
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
    let program = compile_fixture("ir_translation_if.c");
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
    let program = compile_fixture("ir_translation_while.c");
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
    let program = compile_fixture("ir_translation_simple.c");
    assert_eq!(program.entry_pc, 0);
}

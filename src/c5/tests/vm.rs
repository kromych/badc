//! Hand-built `Program` execution tests -- exercise the VM without going
//! through the compiler.

use super::{Op, Program, Vm};

fn run(text: Vec<i64>) -> i64 {
    let program = Program {
        text,
        data: vec![],
        entry_pc: 0,
        warnings: vec![],
        data_imm_positions: vec![],
        tls_data: vec![],
        tls_init_size: 0,
        call_fp_arg_masks: vec![],
        data_relocs: vec![],
        exports: vec![],
        dylibs: vec![],
        dllmain_pc: None,
    };
    Vm::new(program).run().unwrap()
}

#[test]
fn add_two_immediates() {
    let text = vec![
        Op::Ent as i64,
        0,
        Op::Imm as i64,
        5,
        Op::Psh as i64,
        Op::Imm as i64,
        10,
        Op::Add as i64,
        Op::Lev as i64,
    ];
    assert_eq!(run(text), 15);
}

#[test]
fn conditional_branch_taken() {
    // if (1) return 7 else return 0;  -- encoded directly.
    let text = vec![
        Op::Ent as i64,
        0,
        Op::Imm as i64,
        1, // a = 1 (truthy)
        Op::Bz as i64,
        9, // skip to else branch when a == 0
        Op::Imm as i64,
        7,
        Op::Lev as i64,
        Op::Imm as i64, // PC 9
        0,
        Op::Lev as i64,
    ];
    assert_eq!(run(text), 7);
}

#[test]
fn conditional_branch_not_taken() {
    // Same shape as above but with a 0 condition: takes the else branch.
    let text = vec![
        Op::Ent as i64,
        0,
        Op::Imm as i64,
        0,
        Op::Bz as i64,
        9,
        Op::Imm as i64,
        7,
        Op::Lev as i64,
        Op::Imm as i64,
        99,
        Op::Lev as i64,
    ];
    assert_eq!(run(text), 99);
}

#[test]
fn jsr_calls_subroutine_and_returns() {
    // main: ent 0; jsr 5; lev   -- subroutine returns 42.
    // PC: 0 Ent, 1 0, 2 Jsr, 3 5, 4 Lev,
    //     5 Ent, 6 0, 7 Imm, 8 42, 9 Lev
    let text = vec![
        Op::Ent as i64,
        0,
        Op::Jsr as i64,
        5,
        Op::Lev as i64,
        Op::Ent as i64,
        0,
        Op::Imm as i64,
        42,
        Op::Lev as i64,
    ];
    assert_eq!(run(text), 42);
}

#[test]
fn invalid_opcode_is_a_runtime_error() {
    // A garbage word in the instruction stream should produce a runtime
    // error rather than silently misbehaving.
    let program = Program {
        text: vec![Op::Ent as i64, 0, 0xdead_beef, Op::Lev as i64],
        data: vec![],
        entry_pc: 0,
        warnings: vec![],
        data_imm_positions: vec![],
        tls_data: vec![],
        tls_init_size: 0,
        call_fp_arg_masks: vec![],
        data_relocs: vec![],
        exports: vec![],
        dylibs: vec![],
        dllmain_pc: None,
    };
    let err = Vm::new(program).run().unwrap_err();
    assert!(
        err.to_string().contains("Invalid instruction"),
        "unexpected error: {err}"
    );
}

#[test]
fn empty_program_errors_cleanly() {
    let program = Program {
        text: vec![],
        data: vec![],
        entry_pc: 0,
        warnings: vec![],
        data_imm_positions: vec![],
        tls_data: vec![],
        tls_init_size: 0,
        call_fp_arg_masks: vec![],
        data_relocs: vec![],
        exports: vec![],
        dylibs: vec![],
        dllmain_pc: None,
    };
    let err = Vm::new(program).run().unwrap_err();
    assert!(
        err.to_string().contains("empty program"),
        "unexpected error: {err}"
    );
}

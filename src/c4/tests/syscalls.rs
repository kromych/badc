//! Tests for runtime services exposed to C: argv, environment variables,
//! and write to standard file descriptors.
//!
//! Environment-variable tests use process-unique names so they don't race
//! when cargo runs tests in parallel -- `set_var` is process-global state
//! (and `unsafe` to call in the 2024 edition).

use std::sync::Mutex;

use super::{run_fixture, run_fixture_with_args};

/// Serializes tests that read or write a shared environment variable so
/// they don't race with each other under cargo's parallel test runner.
static GETENV_VAR_LOCK: Mutex<()> = Mutex::new(());

// ---- argc / argv ----

#[test]
fn argc_with_no_extra_args_is_program_name_only() {
    assert_eq!(run_fixture_with_args("argc.c", ["prog"]), 1);
}

#[test]
fn argc_counts_all_arguments() {
    assert_eq!(run_fixture_with_args("argc.c", ["prog", "a", "b", "c"]), 4);
}

#[test]
fn argc_is_zero_when_no_args_passed() {
    assert_eq!(run_fixture("argc.c"), 0);
}

#[test]
fn argv_first_argument_is_readable() {
    // argv[1] = "Q..." -- the program returns its first byte (0x51).
    assert_eq!(
        run_fixture_with_args("argv_first_char.c", ["prog", "Q"]),
        'Q' as i64
    );
}

#[test]
fn argv_returns_zero_when_only_program_name_present() {
    assert_eq!(run_fixture_with_args("argv_first_char.c", ["prog"]), 0);
}

// ---- getenv / setenv ----

#[test]
fn getenv_reads_value_set_externally() {
    let _guard = GETENV_VAR_LOCK.lock().unwrap();
    // SAFETY: the lock above serializes all tests that touch this var.
    // The unsafe wrapper is required by the 2024 edition's process-global
    // env state model.
    unsafe { std::env::set_var("C4RS_TEST_GETENV", "M") };
    let result = run_fixture("getenv_value.c");
    unsafe { std::env::remove_var("C4RS_TEST_GETENV") };
    assert_eq!(result, 'M' as i64);
}

#[test]
fn getenv_returns_null_when_unset() {
    let _guard = GETENV_VAR_LOCK.lock().unwrap();
    unsafe { std::env::remove_var("C4RS_TEST_GETENV") };
    assert_eq!(run_fixture("getenv_value.c"), 1);
}

#[test]
fn setenv_then_getenv_roundtrip() {
    // Ensure clean slate, run the c program (which both sets and reads),
    // then clean up after ourselves.
    unsafe { std::env::remove_var("C4RS_TEST_SETENV") };
    let result = run_fixture("setenv_then_get.c");
    unsafe { std::env::remove_var("C4RS_TEST_SETENV") };
    assert_eq!(result, 'Z' as i64);
}

// ---- write to stdout ----

#[test]
fn write_to_stdout_runs_to_completion() {
    // Captures aren't easy without extra deps; this just exercises the code
    // path and asserts no runtime error.
    assert_eq!(run_fixture("write_stdout.c"), 0);
}

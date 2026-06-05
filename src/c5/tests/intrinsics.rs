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

// ---- runtime dynamic linking (dlopen / dlsym / dlclose) ----
//
// These VM-side tests rely on POSIX `dlopen(NULL, RTLD_NOW)`
// returning a handle whose symbol scope includes libc -- so
// `dlsym(h, "atoi")` finds something. Windows' GetModuleHandleA(NULL)
// only covers the main executable, not loaded DLLs, so the same
// shape doesn't yield a libc symbol there. Skip on Windows; the
// Host-trait Windows impl is exercised structurally by the build
// itself + native tests on Unix runners.

#[cfg(unix)]
#[test]
fn dlopen_returns_a_non_zero_handle_in_vm_mode() {
    // dlopen(NULL, RTLD_NOW) -- ask the host for the global symbol
    // table. StdHost forwards to libc::dlopen, which returns a real
    // handle (non-zero) on success. We just check that's reachable
    // through the VM's intrinsic layer.
    let src = r#"
        int main() {
            int *h;
            h = dlopen(0, 2);
            if (h == 0) return 1;
            dlclose(h);
            return 0;
        }
    "#;
    let p = crate::Compiler::new(super::with_prelude(src))
        .compile()
        .unwrap();
    let result = crate::Vm::new(p).run().unwrap();
    assert_eq!(result, 0);
}

#[cfg(unix)]
#[test]
fn dlsym_finds_a_real_libc_symbol_in_vm_mode() {
    // Look up libc atoi -- it's in every conforming libc, so the
    // returned address is non-zero on macOS, glibc, and musl. We
    // can't *call* it from the VM (no FFI), but seeing a non-zero
    // address back confirms the dlopen + dlsym round-trip works.
    let src = r#"
        int main() {
            int *h;
            int *fn;
            h = dlopen(0, 2);
            if (h == 0) return 1;
            fn = dlsym(h, "atoi");
            dlclose(h);
            if (fn == 0) return 2;
            return 0;
        }
    "#;
    let p = crate::Compiler::new(super::with_prelude(src))
        .compile()
        .unwrap();
    let result = crate::Vm::new(p).run().unwrap();
    assert_eq!(result, 0);
}

#[cfg(unix)]
#[test]
fn jsri_through_a_dlsym_pointer_is_rejected_in_vm_mode() {
    // VM mode has no FFI -- decode_pc only accepts CODE_BASE-biased
    // c5 PCs, so jumping through a real libc address must error. The
    // documented behaviour is "Runtime Error: jump to non-code
    // address ...".
    let src = r#"
        int main() {
            int *h;
            int *fn;
            h = dlopen(0, 2);
            fn = dlsym(h, "atoi");
            return fn("123");
        }
    "#;
    let p = crate::Compiler::new(super::with_prelude(src))
        .compile()
        .unwrap();
    let err = crate::Vm::new(p).run().unwrap_err();
    let msg = format!("{err}");
    // The forged-pointer diagnostic surfaces as a runtime error;
    // the jump target wasn't a recognised code address.
    assert!(
        msg.contains("non-code address")
            || msg.contains("is not a code pointer")
            || msg.contains("no function at ent_pc"),
        "expected non-code-pointer rejection, got: {msg}"
    );
}

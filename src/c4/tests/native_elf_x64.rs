//! End-to-end Linux/x86_64 ELF tests. Mirror of
//! [`super::native_elf`] (the Linux/aarch64 suite) for the x86_64
//! target.
//!
//! Gated to `linux + x86_64` because the produced binary is an ELF
//! that the host kernel must agree to load and execute. CI runs this
//! module on the `ubuntu-latest` runner (x86_64 by default); macOS
//! / arm64 / Windows lanes compile it out entirely.

#![cfg(all(target_os = "linux", target_arch = "x86_64"))]

use std::io::Write;
use std::path::Path;
use std::process::Command;

use crate::{Compiler, Target, emit_native};

#[derive(Debug)]
#[allow(dead_code)]
enum RunOutcome {
    Exit(i32),
    Signal(i32),
    BuildError(String),
}

impl RunOutcome {
    fn matches(&self, expected: i32) -> bool {
        matches!(self, RunOutcome::Exit(c) if *c == expected)
    }
}

fn build_and_run(src: &str, stem: &str) -> i32 {
    match build_and_run_outcome(src, stem) {
        RunOutcome::Exit(c) => c,
        other => panic!("expected normal exit, got {other:?}"),
    }
}

fn build_and_run_outcome(src: &str, stem: &str) -> RunOutcome {
    let program = match Compiler::new(src.to_string()).compile() {
        Ok(p) => p,
        Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
    };
    let bytes = match emit_native(&program, Target::LinuxX64) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let path = unique_temp_path("badc-elf64-test", stem);
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        // sync_all + retry-on-ETXTBUSY mirror the aarch64 module --
        // see [`super::native_elf::build_and_run_outcome`] for why.
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);

    let output = exec_with_retry(&path);
    let _ = std::fs::remove_file(&path);
    match output {
        Ok(o) => {
            if let Some(code) = o.status.code() {
                RunOutcome::Exit(code)
            } else {
                use std::os::unix::process::ExitStatusExt;
                let signal = o.status.signal().unwrap_or(0);
                RunOutcome::Signal(signal)
            }
        }
        Err(e) => panic!("could not exec the produced binary: {e}"),
    }
}

fn unique_temp_path(prefix: &str, stem: &str) -> std::path::PathBuf {
    use std::sync::atomic::{AtomicU64, Ordering};
    static COUNTER: AtomicU64 = AtomicU64::new(0);
    let n = COUNTER.fetch_add(1, Ordering::Relaxed);
    let pid = std::process::id();
    std::env::temp_dir().join(format!("{prefix}-{pid}-{n}-{stem}.bin"))
}

fn exec_with_retry(path: &Path) -> std::io::Result<std::process::Output> {
    for attempt in 0..10 {
        match Command::new(path).output() {
            Ok(o) => return Ok(o),
            Err(e) if e.raw_os_error() == Some(26) => {
                std::thread::sleep(std::time::Duration::from_millis(10 * (attempt + 1)));
            }
            Err(e) => return Err(e),
        }
    }
    Command::new(path).output()
}

fn set_executable(path: &Path) {
    use std::os::unix::fs::PermissionsExt;
    let meta = std::fs::metadata(path).unwrap();
    let mut perms = meta.permissions();
    perms.set_mode(perms.mode() | 0o111);
    std::fs::set_permissions(path, perms).unwrap();
}

// ---- Smoke tests -- mirror the aarch64 module's shapes. ----

#[test]
fn return_42() {
    assert_eq!(build_and_run("int main() { return 42; }", "ret42"), 42);
}

#[test]
fn return_zero() {
    assert_eq!(build_and_run("int main() { return 0; }", "ret0"), 0);
}

#[test]
fn return_value_truncates_to_byte() {
    assert_eq!(build_and_run("int main() { return 257; }", "ret257"), 1);
}

#[test]
fn arithmetic_and_locals() {
    let src = r#"
        int main() {
            int x;
            x = 41;
            x = x + 1;
            return x;
        }
    "#;
    assert_eq!(build_and_run(src, "locals"), 42);
}

#[test]
fn while_loop_terminates() {
    let src = r#"
        int main() {
            int i;
            int s;
            i = 0;
            s = 0;
            while (i < 10) {
                s = s + i;
                i = i + 1;
            }
            return s;
        }
    "#;
    assert_eq!(build_and_run(src, "while"), 45);
}

#[test]
fn function_call_returns_value() {
    let src = r#"
        int square(int n) { return n * n; }
        int main() { return square(6) + square(2); }
    "#;
    assert_eq!(build_and_run(src, "fncall"), 40);
}

#[test]
fn recursion_factorial() {
    let src = r#"
        int fact(int n) {
            if (n < 2) return 1;
            return n * fact(n - 1);
        }
        int main() { return fact(5); }
    "#;
    assert_eq!(build_and_run(src, "fact"), 120);
}

#[test]
fn printf_through_libc_got() {
    let src = r#"int main() { printf("%d\n", 42); return 0; }"#;
    assert_eq!(build_and_run(src, "printf"), 0);
}

#[test]
fn malloc_memset_memcmp_roundtrip() {
    let src = r#"
        int main() {
            int *a;
            int *b;
            a = malloc(16);
            b = malloc(16);
            memset(a, 7, 16);
            memset(b, 7, 16);
            if (memcmp(a, b, 16) == 0) {
                free(a);
                free(b);
                return 1;
            }
            return 0;
        }
    "#;
    assert_eq!(build_and_run(src, "malloc"), 1);
}

// ---- Fixture parity. Same table as the aarch64 module so a drift
//      in either backend shows up as an arch-specific failure. ----

fn build_and_run_fixture(name: &str) -> RunOutcome {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let stem = name.trim_end_matches(".c");
    build_and_run_outcome(&src, &format!("fixture-{stem}"))
}

const NATIVE_ELF_X64_FIXTURES: &[(&str, i32)] = &[
    ("arithmetic.c", 60),
    ("goto.c", 5),
    ("switch_statement.c", 25),
    ("switch_default_routing.c", 100),
    ("control_flow.c", 1),
    ("do_while.c", 5),
    ("break_continue.c", 4),
    ("for_loop.c", 10),
    ("recursion_factorial.c", 120),
    ("pointers.c", 200),
    ("pointer_arithmetic_scaling.c", 108),
    ("expression_precedence.c", 1),
    ("variable_shadowing.c", 10),
    ("pointer_arithmetic.c", 3),
    ("predefined_constants.c", 0),
    ("memset_mcmp.c", 42),
    ("memcpy_basic.c", 'A' as i32),
    ("struct_basic.c", 25),
    ("struct_linked_list.c", 10),
    ("struct_sizeof.c", 0),
    ("memory_ops.c", 0),
    ("linked_list.c", 10),
    ("double_pointers.c", 0),
    ("printf.c", 0),
    ("shebang.c", 7),
    ("adjacent_strings.c", 'f' as i32),
    ("sizeof_with_write.c", 24),
    ("function_pointers.c", 150),
    ("nested_function_calls.c", 100),
    ("quicksort.c", 0),
    ("binary_search_tree.c", 0),
    ("bst_free.c", 0),
    ("cast_to_struct_pointer.c", 42),
    ("argc.c", 1),
    ("argv_first_char.c", 0),
    ("sizeof_basic.c", 0),
    ("sizeof_expr.c", 0),
    ("write_stdout.c", 0),
    ("ir_translation_simple.c", 42),
    ("ir_translation_if.c", 2),
    ("ir_translation_while.c", 0),
    ("type_warning_int_to_ptr.c", 0),
    ("type_warning_silenced_by_cast.c", 0),
    ("type_warning_arity.c", 0),
    ("setenv_then_get.c", 'Z' as i32),
    ("dlopen_atoi.c", 123),
];

#[test]
fn fixture_parity() {
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_ELF_X64_FIXTURES {
        let outcome = build_and_run_fixture(name);
        if !outcome.matches(*expected) {
            failures.push(format!("{name}: expected exit {expected}, got {outcome:?}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} ELF fixtures regressed:\n  {}",
        failures.len(),
        NATIVE_ELF_X64_FIXTURES.len(),
        failures.join("\n  ")
    );
}

// ---- Standalone tests for fixtures that need argv / env / CWD
//      setup the parity harness can't provide. ----

#[test]
fn file_io_natively() {
    let dummy_path = std::env::temp_dir().join("test_dummy.txt");
    std::fs::write(&dummy_path, "1234567890").unwrap();

    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("fixtures");
    path.push("c");
    path.push("file_io.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src).compile().expect("compile file_io.c");
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let bin_path = std::env::temp_dir().join("badc-elf64-test-file_io.bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    let output = Command::new(&bin_path)
        .current_dir(std::env::temp_dir())
        .output()
        .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    let _ = std::fs::remove_file(&dummy_path);
    assert_eq!(output.status.code(), Some(0));
}

#[test]
fn getenv_value_natively() {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("fixtures");
    path.push("c");
    path.push("getenv_value.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src)
        .compile()
        .expect("compile getenv_value.c");
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let bin_path = std::env::temp_dir().join("badc-elf64-test-getenv.bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    let output = Command::new(&bin_path)
        .env("C4RS_TEST_GETENV", "Vox")
        .output()
        .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    assert_eq!(output.status.code(), Some('V' as i32));
}

#[test]
fn original_c4_compiles_and_runs_hello_natively() {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src).compile().expect("compile c4.c");
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let bin_path = std::env::temp_dir().join("badc-elf64-test-c4.bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    let output = Command::new(&bin_path)
        .arg(concat!(env!("CARGO_MANIFEST_DIR"), "/hello.c"))
        .output()
        .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "c4 self-host failed:\nSTDOUT:\n{}\nSTDERR:\n{}",
        String::from_utf8_lossy(&output.stdout),
        String::from_utf8_lossy(&output.stderr)
    );
}

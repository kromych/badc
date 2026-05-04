//! End-to-end Windows/AArch64 PE tests.
//!
//! Compile a c5 program to a PE32+ binary with `Machine =
//! IMAGE_FILE_MACHINE_ARM64`, drop it in `tmp`, and execute it.
//! Two host paths run the same surface:
//!
//! * On `windows-aarch64` the binary runs natively via
//!   `Command::new(path.exe)`.
//! * On `linux-aarch64` the binary runs through WINE 10's
//!   `aarch64-windows` DLL set, *but only when `BADC_RUN_WINE=1`
//!   is set in the environment*. The default `cargo test` skips
//!   the wine lane; CI sets `BADC_RUN_WINE=1` on the wine-installed
//!   `ubuntu-24.04-arm` job so the cross-check still runs.
//!
//! On the GitHub Actions matrix the `windows-11-arm` runner runs
//! the suite natively. WINE on Apple Silicon ships only the
//! `x86_64-windows` and `i386-windows` DLL sets, not
//! `aarch64-windows`, so macOS hosts only get the format-
//! validation check in [`super::super::codegen::pe::tests`].

#![cfg(any(
    all(target_os = "windows", target_arch = "aarch64"),
    all(target_os = "linux", target_arch = "aarch64"),
))]

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::Command;

use crate::{Compiler, Target, emit_native};

/// On Windows we run the binary directly; on Linux we go through
/// WINE if the environment opts in via `BADC_RUN_WINE`. Returns
/// `None` when wine execution isn't enabled (so the test skips
/// gracefully instead of panicking) or when the binary isn't on
/// disk.
fn run_pe(path: &Path, args: &[&str]) -> Option<std::io::Result<std::process::Output>> {
    #[cfg(target_os = "windows")]
    {
        Some(Command::new(path).args(args).output())
    }
    #[cfg(target_os = "linux")]
    {
        if !wine_enabled() {
            return None;
        }
        let wine = wine_binary()?;
        Some(Command::new(&wine).arg(path).args(args).output())
    }
}

/// True iff the user explicitly opted in to running PE binaries
/// through WINE for this `cargo test` invocation. Off by default
/// so a casual `cargo test` on a wine-installed Linux box doesn't
/// silently shell out to wine for half the suite.
#[cfg(target_os = "linux")]
fn wine_enabled() -> bool {
    matches!(std::env::var("BADC_RUN_WINE"), Ok(v) if !v.is_empty() && v != "0")
}

/// `which wine` on Linux. The Ubuntu wine 10 package puts it at
/// `/usr/bin/wine`; we also fall back to PATH.
#[cfg(target_os = "linux")]
fn wine_binary() -> Option<PathBuf> {
    let p = PathBuf::from("/usr/bin/wine");
    if p.exists() {
        return Some(p);
    }
    Command::new("which")
        .arg("wine")
        .output()
        .ok()
        .and_then(|o| {
            if o.status.success() {
                let s = String::from_utf8_lossy(&o.stdout).trim().to_string();
                if s.is_empty() {
                    None
                } else {
                    Some(PathBuf::from(s))
                }
            } else {
                None
            }
        })
}

/// True when this host can actually execute the produced PE
/// binary. On Windows the answer is always yes; on Linux it
/// depends on whether `BADC_RUN_WINE` is set *and* WINE is
/// installed.
fn host_can_run_pe() -> bool {
    #[cfg(target_os = "windows")]
    {
        true
    }
    #[cfg(target_os = "linux")]
    {
        wine_enabled() && wine_binary().is_some()
    }
}

#[derive(Debug)]
#[allow(dead_code)]
enum RunOutcome {
    Exit(i32),
    Signal(i32),
    BuildError(String),
    /// Host can't execute PE binaries (Linux without wine
    /// installed). The test should skip rather than fail.
    HostCannotRun,
}

impl RunOutcome {
    fn matches(&self, expected: i32) -> bool {
        matches!(self, RunOutcome::Exit(c) if *c == expected)
    }
}

fn build_and_run(src: &str, stem: &str, args: &[&str]) -> RunOutcome {
    // Compile with the same target the codegen will lower for, so
    // the per-target header (`headers/badc-windows-arm64.h`) is the
    // one whose `#pragma dylib` / `#pragma binding` directives end
    // up on `program.dylibs` and whose `#define __BADC_WINDOWS__` reaches
    // any conditional source. Using the default `Compiler::new` would
    // load the macOS header and silently feed the wrong bindings
    // to the codegen.
    let program =
        match Compiler::with_target(super::with_prelude(src), Target::WindowsAarch64).compile() {
            Ok(p) => p,
            Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
        };
    let bytes = match emit_native(&program, Target::WindowsAarch64) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let path = unique_temp_path("badc-pe-arm64-test", stem);
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }

    let output = match run_pe(&path, args) {
        Some(r) => r,
        None => {
            let _ = std::fs::remove_file(&path);
            return RunOutcome::HostCannotRun;
        }
    };
    let _ = std::fs::remove_file(&path);
    match output {
        Ok(o) => {
            if let Some(code) = o.status.code() {
                RunOutcome::Exit(code)
            } else {
                #[cfg(unix)]
                {
                    use std::os::unix::process::ExitStatusExt;
                    RunOutcome::Signal(o.status.signal().unwrap_or(0))
                }
                #[cfg(not(unix))]
                {
                    RunOutcome::Signal(0)
                }
            }
        }
        Err(e) => panic!("could not exec PE binary: {e}"),
    }
}

fn unique_temp_path(prefix: &str, stem: &str) -> PathBuf {
    use std::sync::atomic::{AtomicU64, Ordering};
    static COUNTER: AtomicU64 = AtomicU64::new(0);
    let n = COUNTER.fetch_add(1, Ordering::Relaxed);
    let pid = std::process::id();
    std::env::temp_dir().join(format!("{prefix}-{pid}-{n}-{stem}.exe"))
}

fn assert_exit(src: &str, stem: &str, args: &[&str], expected: i32) {
    match build_and_run(src, stem, args) {
        RunOutcome::Exit(c) => {
            assert_eq!(c, expected, "{stem}: exit {c} != expected {expected}");
        }
        RunOutcome::Signal(s) => panic!("{stem}: exited via signal {s}"),
        RunOutcome::BuildError(e) => panic!("{stem}: {e}"),
        RunOutcome::HostCannotRun => eprintln!("skip {stem}: no PE runner on this host"),
    }
}

// ---------------- smoke tests ----------------

#[test]
fn return_zero() {
    assert_exit("int main() { return 0; }", "ret0", &[], 0);
}

#[test]
fn return_42() {
    assert_exit("int main() { return 42; }", "ret42", &[], 42);
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
    assert_exit(src, "locals", &[], 42);
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
    assert_exit(src, "while", &[], 45);
}

#[test]
fn function_call_returns_value() {
    let src = r#"
        int square(int n) { return n * n; }
        int main() { return square(6) + square(2); }
    "#;
    assert_exit(src, "fncall", &[], 40);
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
    assert_exit(src, "fact", &[], 120);
}

#[test]
fn printf_through_iat() {
    // Exits with the byte count printf returned for "42\n" -- 3 on
    // Windows since msvcrt's printf returns the printed-char count.
    let src = r#"int main() { return printf("%d\n", 42); }"#;
    assert_exit(src, "printf", &[], 3);
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
    assert_exit(src, "malloc", &[], 1);
}

#[test]
fn argc_argv_round_trip_through_getmainargs() {
    let src = r#"int main(int argc, char **argv) { return argc; }"#;
    assert_exit(src, "argc", &["one", "two", "three"], 4);
}

// ---------------- fixture parity ----------------

fn build_and_run_fixture(name: &str) -> RunOutcome {
    let mut path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let stem = name.trim_end_matches(".c");
    build_and_run(&src, &format!("fixture-{stem}"), &[name])
}

/// Same fixture set as `native_pe_x64`, since the Windows-flavored
/// limitations (POSIX-only setenv shape, dlopen-against-libc-soname)
/// are arch-independent. mprotect goes through the in-text thunk
/// the same way, so `mprotect_allows_read.c` is included.
const NATIVE_PE_ARM64_FIXTURES: &[(&str, i32)] = &[
    ("arithmetic.c", 60),
    ("control_flow.c", 1),
    ("do_while.c", 5),
    ("break_continue.c", 4),
    ("for_loop.c", 10),
    ("goto.c", 5),
    ("recursion_factorial.c", 120),
    ("pointers.c", 200),
    ("pointer_arithmetic.c", 3),
    ("pointer_arithmetic_scaling.c", 108),
    ("expression_precedence.c", 1),
    ("variable_shadowing.c", 10),
    ("predefined_constants.c", 0),
    ("c99_qualifiers.c", 0),
    ("integer_suffixes.c", 0),
    ("predefined_macros.c", 0),
    ("macro_operators.c", 0),
    ("typedef_basic.c", 0),
    ("local_init_and_block_scope.c", 0),
    ("arrays_basic.c", 0),
    ("function_pointer_typedefs.c", 0),
    ("unions_basic.c", 0),
    ("array_initializers.c", 0),
    ("struct_initializers.c", 0),
    ("enum_tag_types.c", 0),
    ("bitfields.c", 0),
    ("static_locals.c", 0),
    ("memset_mcmp.c", 42),
    ("memcpy_basic.c", 'A' as i32),
    ("struct_basic.c", 25),
    ("struct_linked_list.c", 10),
    ("global_initializer_int.c", 141),
    ("global_initializer_pointer.c", 0),
    ("static_linked_list.c", 0),
    ("struct_sizeof.c", 0),
    ("memory_ops.c", 0),
    ("linked_list.c", 10),
    ("double_pointers.c", 0),
    ("function_pointers.c", 150),
    ("nested_function_calls.c", 100),
    ("quicksort.c", 0),
    ("binary_search_tree.c", 0),
    ("bst_free.c", 0),
    ("cast_to_struct_pointer.c", 42),
    ("ir_translation_simple.c", 42),
    ("ir_translation_if.c", 2),
    ("ir_translation_while.c", 0),
    ("sizeof_basic.c", 0),
    ("sizeof_expr.c", 0),
    ("type_warning_int_to_ptr.c", 0),
    ("type_warning_silenced_by_cast.c", 0),
    ("type_warning_arity.c", 0),
    // c5-side vprintf -- variadic walking happens in c5 source
    // and the only Win32 call is `_write`, so this fixture stays
    // in even when the libc-shape variadic-sprintf path doesn't.
    ("c5_vprintf.c", 0),
    // Float / double frontend deliverable.
    ("float_pointer_basics.c", 0),
    // Full FP arithmetic on Windows/AArch64 -- same NEON lowering
    // as the ELF arm64 / macOS arm64 paths.
    ("float_arithmetic.c", 0),
    // Struct-value locals + `.` field access.
    ("struct_value_basics.c", 0),
    // Whole-struct copy via Op::Mcpy.
    ("struct_value_copy.c", 0),
    // Struct-by-value parameter / return on Windows/AArch64.
    ("struct_by_value_param.c", 0),
    ("struct_by_value_return.c", 0),
    // _Thread_local on Windows/AArch64 -- same TLS directory +
    // _tls_index plumbing as the x64 PE; the lowering pulls
    // tls_array out of `[x18 + 0x58]` (TEB->ThreadLocalStoragePointer)
    // instead of gs:[0x58].
    ("thread_local_basic.c", 0),
    ("thread_local_initializer.c", 0),
];

#[test]
fn fixture_parity() {
    if !host_can_run_pe() {
        eprintln!("skip fixture_parity: no PE runner on this host");
        return;
    }
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_PE_ARM64_FIXTURES {
        let outcome = build_and_run_fixture(name);
        if !outcome.matches(*expected) {
            failures.push(format!("{name}: expected {expected}, got {outcome:?}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} PE/aarch64 fixtures regressed:\n  {}",
        failures.len(),
        NATIVE_PE_ARM64_FIXTURES.len(),
        failures.join("\n  ")
    );
}

#[test]
fn original_c4_compiles_and_runs_hello_pe() {
    if !host_can_run_pe() {
        eprintln!("skip c4 self-host: no PE runner on this host");
        return;
    }
    let mut path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).expect("read c4.c");
    let mut hello_path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    hello_path.push("hello.c");
    let outcome = build_and_run(
        &src,
        "c4-self-host",
        &[hello_path.to_str().expect("hello.c path is utf-8")],
    );
    match outcome {
        RunOutcome::Exit(c) => assert_eq!(c, 0, "c4 self-host PE-arm64 exited {c}"),
        RunOutcome::Signal(s) => panic!("c4 self-host PE-arm64 killed by signal {s}"),
        RunOutcome::BuildError(e) => panic!("c4 self-host PE-arm64 build error: {e}"),
        RunOutcome::HostCannotRun => {} // already logged above
    }
}

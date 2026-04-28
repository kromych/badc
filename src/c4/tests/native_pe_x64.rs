//! End-to-end Windows/x86_64 PE tests.
//!
//! Compile a c4 program to a PE32+ binary, drop it in `tmp`, and
//! execute it. Two host paths run the same surface:
//!
//! * On `windows-x86_64` the binary runs natively via
//!   `Command::new(path.exe)`.
//! * On `macos` the binary runs through WINE
//!   (`/opt/homebrew/bin/wine path.exe`). WINE on Apple Silicon
//!   uses Rosetta to translate the x86_64 instructions, so the
//!   runtime cost is non-trivial but works fine for tests. WINE
//!   isn't preinstalled on macOS CI, so each test gracefully
//!   skips when the binary is missing.
//!
//! Other host triples compile this module out; the CI matrix
//! covers Linux via [`super::native_elf_x64`] separately.

#![cfg(any(
    target_os = "macos",
    all(target_os = "windows", target_arch = "x86_64"),
))]

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::Command;

use crate::{Compiler, Target, emit_native};

/// On Windows we run the binary directly; on macOS we go through
/// WINE. This wrapper picks the right shape and returns `None` on
/// macOS hosts that don't have WINE installed (so the test can
/// skip gracefully instead of panicking).
fn run_pe(path: &Path, args: &[&str]) -> Option<std::io::Result<std::process::Output>> {
    #[cfg(target_os = "windows")]
    {
        Some(Command::new(path).args(args).output())
    }
    #[cfg(target_os = "macos")]
    {
        let wine = wine_binary()?;
        Some(Command::new(&wine).arg(path).args(args).output())
    }
}

/// Path resolution for `wine` on macOS. Homebrew installs to
/// `/opt/homebrew/bin/wine` on Apple Silicon and
/// `/usr/local/bin/wine` on Intel; PATH is the fallback.
#[cfg(target_os = "macos")]
fn wine_binary() -> Option<PathBuf> {
    for candidate in ["/opt/homebrew/bin/wine", "/usr/local/bin/wine"] {
        let p = PathBuf::from(candidate);
        if p.exists() {
            return Some(p);
        }
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
/// binary. On Windows the answer is always yes; on macOS it
/// depends on whether WINE is installed.
fn host_can_run_pe() -> bool {
    #[cfg(target_os = "windows")]
    {
        true
    }
    #[cfg(target_os = "macos")]
    {
        wine_binary().is_some()
    }
}

#[derive(Debug)]
#[allow(dead_code)]
enum RunOutcome {
    Exit(i32),
    Signal(i32),
    BuildError(String),
    /// Host can't execute PE binaries (macOS without WINE); the
    /// test should be treated as a no-op rather than a failure.
    HostCannotRun,
}

impl RunOutcome {
    fn matches(&self, expected: i32) -> bool {
        matches!(self, RunOutcome::Exit(c) if *c == expected)
    }
}

fn build_and_run(src: &str, stem: &str, args: &[&str]) -> RunOutcome {
    let program = match Compiler::new(src.to_string()).compile() {
        Ok(p) => p,
        Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
    };
    let bytes = match emit_native(&program, Target::WindowsX64) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let path = unique_temp_path("badc-pe64-test", stem);
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

/// Runs the build-and-run path, asserting on the expected exit
/// code. Skips silently when the host can't execute PE binaries
/// (macOS without WINE).
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
fn return_257_round_trips() {
    // Windows surfaces the full 32-bit DWORD that ExitProcess was
    // handed; WINE bridges it back through the host's POSIX exit
    // convention, which truncates to 8 bits (257 % 256 == 1). The
    // test accepts either, since both are correct on their host.
    let outcome = build_and_run("int main() { return 257; }", "ret257", &[]);
    match outcome {
        RunOutcome::Exit(c) => {
            assert!(
                c == 257 || c == 1,
                "expected 257 (Windows) or 1 (WINE-truncated), got {c}"
            );
        }
        RunOutcome::HostCannotRun => eprintln!("skip ret257: no PE runner on this host"),
        other => panic!("ret257: {other:?}"),
    }
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
    // Exits with the number of chars printf returned (4: "42\n" on
    // Linux / macOS, but Windows printf returns the byte count too,
    // including the LF, so 3). Compare against 3 to keep the test
    // platform-honest.
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
    // The PE entry stub pumps argc / argv out of msvcrt's
    // __getmainargs. Pass three extra args and verify the count
    // (argv[0] is the program path, plus the three).
    let src = r#"int main(int argc, char **argv) { return argc; }"#;
    assert_exit(src, "argc", &["one", "two", "three"], 4);
}

#[test]
fn mprotect_thunk_runs_through_virtualprotect() {
    // Sanity-check the in-text thunk that translates POSIX
    // mprotect into VirtualProtect: malloc a page, drop a sentinel
    // byte, set the region read-only via mprotect (PROT_READ = 1),
    // and read the byte back. The thunk should map prot=1 to
    // PAGE_READONLY and return 0 on success; the read-back must
    // see the original 'M'.
    let src = r#"
        int main() {
            char *p;
            int rc;
            p = malloc(16);
            p[0] = 'M';
            rc = mprotect(p, 16, 1);   // PROT_READ
            if (rc < 0) return 1;       // BOOL->int translation failed
            return p[0];                 // 'M' = 77
        }
    "#;
    assert_exit(src, "mprotect-thunk", &[], 'M' as i32);
}

#[test]
fn variadic_printf_with_six_args_uses_stack_slots() {
    // Win64 only passes the first 4 ints in registers; args 5 and
    // 6 land at [rsp+0x20] and [rsp+0x28]. This exercises that
    // copy path in emit_libc_call.
    let src = r#"
        int main() {
            return printf("%d %d %d %d %d\n", 1, 2, 3, 4, 5);
        }
    "#;
    // printf returns the number of printed chars: "1 2 3 4 5\n" = 10.
    assert_exit(src, "printf6", &[], 10);
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

/// Subset of the cross-arch fixture corpus that doesn't lean on
/// POSIX-only semantics. setenv (3-arg vs _putenv_s 2-arg), file
/// I/O against POSIX-flavoured paths, and dlopen-against-libc-soname
/// are intentionally skipped here -- the Windows analogues exist
/// but the c4 fixtures expect POSIX shapes the WINE path doesn't
/// reproduce. mprotect now works through the in-text thunk that
/// translates POSIX prot bits to PAGE_* and the BOOL return to
/// 0/-1, so `mprotect_allows_read.c` is in.
const NATIVE_PE_X64_FIXTURES: &[(&str, i32)] = &[
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
    ("memset_mcmp.c", 42),
    ("memcpy_basic.c", 'A' as i32),
    ("struct_basic.c", 25),
    ("struct_linked_list.c", 10),
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
    ("mprotect_allows_read.c", 'X' as i32),
];

#[test]
fn fixture_parity() {
    if !host_can_run_pe() {
        eprintln!("skip fixture_parity: no PE runner on this host");
        return;
    }
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_PE_X64_FIXTURES {
        let outcome = build_and_run_fixture(name);
        if !outcome.matches(*expected) {
            failures.push(format!("{name}: expected {expected}, got {outcome:?}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} PE/x86_64 fixtures regressed:\n  {}",
        failures.len(),
        NATIVE_PE_X64_FIXTURES.len(),
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
    // c4.c reads its first user argv entry as the source file to
    // compile-and-run. Hand it the canonical hello.c and expect
    // the c4-VM to print "Hello 123" and exit 0.
    let mut hello_path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    hello_path.push("hello.c");
    let outcome = build_and_run(
        &src,
        "c4-self-host",
        &[hello_path.to_str().expect("hello.c path is utf-8")],
    );
    match outcome {
        RunOutcome::Exit(c) => assert_eq!(c, 0, "c4 self-host PE exited {c}"),
        RunOutcome::Signal(s) => panic!("c4 self-host PE killed by signal {s}"),
        RunOutcome::BuildError(e) => panic!("c4 self-host PE build error: {e}"),
        RunOutcome::HostCannotRun => {} // already logged above
    }
}

fn _link_path(_path: &Path) {} // keep the Path import in use even on hosts that skip

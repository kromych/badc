//! End-to-end native-codegen tests: compile a C source, write a
//! Mach-O, ad-hoc-sign it, exec it, check the exit code.
//!
//! Gated to macOS because the produced binary is a Mach-O that links
//! libSystem -- nothing else can load it, and `codesign` only exists
//! on Darwin. CI on other OSes skips these.

#![cfg(target_os = "macos")]

use std::io::Write;
use std::path::Path;
use std::process::Command;

use crate::{Compiler, Target, emit_native};

/// Compile inline C source, emit native, sign, run. Returns the exit
/// code the OS reported (typically what `int main` returned, modulo
/// the 8-bit truncation that `wait()` does).
fn build_and_run(src: &str, stem: &str) -> i32 {
    let program = Compiler::new(src.to_string())
        .compile()
        .expect("compile failed");
    let bytes = emit_native(&program, Target::MacOSAarch64).expect("emit_native failed");

    let path = std::env::temp_dir().join(format!("badc-test-{stem}.bin"));
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
    }
    set_executable(&path);
    codesign(&path);

    let status = Command::new(&path)
        .status()
        .expect("could not exec the produced binary");
    let _ = std::fs::remove_file(&path);
    status.code().unwrap_or_else(|| {
        panic!("native binary terminated by signal: {status:?}");
    })
}

fn set_executable(path: &Path) {
    use std::os::unix::fs::PermissionsExt;
    let meta = std::fs::metadata(path).unwrap();
    let mut perms = meta.permissions();
    perms.set_mode(perms.mode() | 0o111);
    std::fs::set_permissions(path, perms).unwrap();
}

fn codesign(path: &Path) {
    let status = Command::new("/usr/bin/codesign")
        .args(["--sign", "-", "--force"])
        .arg(path)
        .status()
        .expect("codesign not available");
    assert!(status.success(), "codesign failed for {path:?}: {status:?}");
}

#[test]
fn return_42() {
    assert_eq!(build_and_run("int main() { return 42; }", "ret42"), 42);
}

#[test]
fn return_zero() {
    assert_eq!(build_and_run("int main() { return 0; }", "ret0"), 0);
}

#[test]
fn return_arbitrary_small_int() {
    // Pick a number unlikely to collide with a kernel signal exit
    // (which would surface as `status.code() == None` and trip the
    // panic in build_and_run).
    assert_eq!(build_and_run("int main() { return 7; }", "ret7"), 7);
}

#[test]
fn return_value_truncates_to_byte() {
    // `wait()` reports the low 8 bits of main's return. 256 -> 0,
    // 257 -> 1, 0xFF -> 255. We pick 0x101 (257) so a buggy codegen
    // that, say, only stored the low 16 bits would still pass the
    // 0/42 tests but flunk this one.
    assert_eq!(build_and_run("int main() { return 257; }", "ret257"), 1);
}

// ---- M1.6: every non-syscall op exercised end-to-end. ----

#[test]
fn add_subtract_multiply() {
    // 5 + 3 = 8, 10 - 4 = 6, 7 * 6 = 42 -- pick the last one.
    assert_eq!(build_and_run("int main() { return 7 * 6; }", "mul42"), 42);
    assert_eq!(build_and_run("int main() { return 5 + 3; }", "add"), 8);
    assert_eq!(build_and_run("int main() { return 100 - 58; }", "sub"), 42);
}

#[test]
fn integer_div_and_mod() {
    assert_eq!(build_and_run("int main() { return 84 / 2; }", "div"), 42);
    assert_eq!(build_and_run("int main() { return 100 % 9; }", "mod"), 1);
}

#[test]
fn comparison_returns_zero_or_one() {
    assert_eq!(build_and_run("int main() { return 5 < 7; }", "lt"), 1);
    assert_eq!(build_and_run("int main() { return 5 > 7; }", "gt"), 0);
    assert_eq!(build_and_run("int main() { return 5 == 5; }", "eq"), 1);
    assert_eq!(build_and_run("int main() { return 5 != 5; }", "ne"), 0);
}

#[test]
fn local_variable_round_trips() {
    let src = r#"
        int main() {
            int x;
            x = 41;
            x = x + 1;
            return x;
        }
    "#;
    assert_eq!(build_and_run(src, "local"), 42);
}

#[test]
fn if_else_routes_correctly() {
    let src = r#"
        int main() {
            int x;
            x = 10;
            if (x > 5) return 42;
            else return 7;
        }
    "#;
    assert_eq!(build_and_run(src, "ifelse"), 42);
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
    // 0+1+2+...+9 = 45
    assert_eq!(build_and_run(src, "while45"), 45);
}

#[test]
fn function_call_returns_value() {
    let src = r#"
        int square(int n) { return n * n; }
        int main() { return square(6) + square(2); }
    "#;
    // 6*6 + 2*2 = 40
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
    // 5! = 120
    assert_eq!(build_and_run(src, "fact"), 120);
}

// ---- M1.7: libc syscalls through the GOT. We can only exercise
//      syscalls that don't need string literals, since data-segment
//      support hasn't landed yet (the `Build.data` field is
//      explicitly noted as TODO in src/c4/codegen/mod.rs).

#[test]
fn exit_with_value() {
    // exit(N) compiles to the c4 `Op::Exit` op, which our codegen
    // routes through a libc call to _exit.
    assert_eq!(
        build_and_run("int main() { exit(7); return 0; }", "exit7"),
        7
    );
}

#[test]
fn malloc_returns_nonzero_pointer() {
    let src = r#"
        int main() {
            int *p;
            p = malloc(64);
            return p != 0;
        }
    "#;
    assert_eq!(build_and_run(src, "malloc-nonzero"), 1);
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
                return 42;
            }
            return 1;
        }
    "#;
    assert_eq!(build_and_run(src, "memset-cmp"), 42);
}

#[test]
fn argc_threads_through_main() {
    // No args passed -- argc should be 1 (just the binary path).
    let src = r#"
        int main(int argc, char **argv) { return argc; }
    "#;
    assert_eq!(build_and_run(src, "argc"), 1);
}

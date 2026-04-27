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

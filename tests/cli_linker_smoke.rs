//! End-to-end smoke tests for the multi-translation-unit
//! linker, exercised through the actual badc binary. Each
//! test writes two or more `.c` files to a per-test temp
//! directory, drives the binary through `-c` + native-emit
//! and through `--ar` + `-L`/`-l`, and confirms the produced
//! native executable runs and returns the expected exit
//! status.
//!
//! Skipped on non-host targets so we don't shell-out to a
//! binary that doesn't match the runner kernel.

use std::path::{Path, PathBuf};
use std::process::Command;

fn badc() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_badc"))
}

fn tempdir(name: &str) -> PathBuf {
    let mut p = std::env::temp_dir();
    p.push(format!("badc-linker-test-{name}-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&p);
    std::fs::create_dir_all(&p).expect("create temp dir");
    p
}

fn write_source(dir: &Path, name: &str, body: &str) -> PathBuf {
    let p = dir.join(name);
    std::fs::write(&p, body).expect("write source");
    p
}

fn run(cmd: &mut Command, what: &str) -> std::process::Output {
    let out = cmd.output().expect(what);
    if !out.status.success() {
        panic!(
            "{what} failed: status={} stdout={:?} stderr={:?}",
            out.status,
            String::from_utf8_lossy(&out.stdout),
            String::from_utf8_lossy(&out.stderr)
        );
    }
    out
}

#[test]
fn two_sources_compile_separately_then_link() {
    let dir = tempdir("two-sources");
    let a = write_source(&dir, "a.c", "int add(int x, int y) { return x + y; }\n");
    let b = write_source(
        &dir,
        "b.c",
        "extern int add(int, int);\nint main() { return add(20, 22); }\n",
    );
    // -c each separately, then link the two .o files.
    run(
        Command::new(badc()).arg("-c").arg(&a).current_dir(&dir),
        "compile a.c",
    );
    run(
        Command::new(badc()).arg("-c").arg(&b).current_dir(&dir),
        "compile b.c",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("b.o"))
            .arg(dir.join("a.o"))
            .current_dir(&dir),
        "link",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(out.status.code(), Some(42), "exit code mismatch");
}

#[test]
fn archive_resolves_via_minus_l_search() {
    let dir = tempdir("archive-l");
    write_source(
        &dir,
        "util.c",
        "int doubled(int n) { return n + n; }\nint trebled(int n) { return n * 3; }\n",
    );
    write_source(
        &dir,
        "main.c",
        "extern int doubled(int);\nextern int trebled(int);\nint main() { return doubled(7) + trebled(8); }\n",
    );
    // Bundle util.c into libutil.a via --ar.
    run(
        Command::new(badc())
            .arg("--ar")
            .arg("-o")
            .arg(dir.join("libutil.a"))
            .arg(dir.join("util.c"))
            .current_dir(&dir),
        "build archive",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("main.c"))
            .arg("-L")
            .arg(&dir)
            .arg("-l")
            .arg("util")
            .current_dir(&dir),
        "link via -l util",
    );
    let out = Command::new(&exe).output().expect("run prog");
    // 14 + 24 = 38.
    assert_eq!(out.status.code(), Some(38), "exit code mismatch");
}

#[test]
fn unresolved_extern_function_fails_link() {
    let dir = tempdir("unresolved");
    write_source(
        &dir,
        "only.c",
        "extern int missing(int);\nint main() { return missing(7); }\n",
    );
    let result = Command::new(badc())
        .arg("-o")
        .arg(dir.join("prog"))
        .arg(dir.join("only.c"))
        .current_dir(&dir)
        .output()
        .expect("invoke badc");
    assert!(
        !result.status.success(),
        "link should have failed: stderr={:?}",
        String::from_utf8_lossy(&result.stderr)
    );
    let stderr = String::from_utf8_lossy(&result.stderr);
    assert!(
        stderr.contains("undefined reference") && stderr.contains("missing"),
        "expected 'undefined reference to missing' in stderr, got: {stderr}"
    );
}

#[test]
fn compile_only_with_minus_o_writes_named_object() {
    let dir = tempdir("co-o");
    let src = write_source(&dir, "foo.c", "int seven() { return 7; }\n");
    let out = dir.join("bar.o");
    run(
        Command::new(badc())
            .arg("-c")
            .arg("-o")
            .arg(&out)
            .arg(&src)
            .current_dir(&dir),
        "compile-only with -o",
    );
    assert!(out.exists(), "expected {} to exist", out.display());
    // First bytes are the ELF magic.
    let bytes = std::fs::read(&out).expect("read .o");
    assert!(
        bytes.len() > 4 && &bytes[0..4] == b"\x7fELF",
        "expected ELF magic; got {:?}",
        &bytes.get(..16)
    );
}

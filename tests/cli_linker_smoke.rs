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
fn jit_links_and_runs_two_translation_units() {
    // Multi-TU through `--jit`: two `.c` files on the command
    // line, no intermediate `.o`, no native binary written. The
    // JIT path's exit code mirrors `main`'s return value, so a
    // mis-resolved cross-TU `Op::JsrPc` would surface as a wrong
    // exit code (or a crash) rather than the expected 42.
    let dir = tempdir("jit-multi-tu");
    let a = write_source(&dir, "a.c", "int add(int x, int y) { return x + y; }\n");
    let b = write_source(
        &dir,
        "b.c",
        "extern int add(int, int);\nint main() { return add(40, 2); }\n",
    );
    let out = Command::new(badc())
        .arg("--jit")
        .arg(&b)
        .arg(&a)
        .current_dir(&dir)
        .output()
        .expect("invoke badc --jit");
    assert_eq!(
        out.status.code(),
        Some(42),
        "JIT exit code mismatch: stdout={:?} stderr={:?}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
}

#[test]
fn duplicate_function_definition_fails_link() {
    // Two TUs each defining `foo` with conflicting bodies must
    // hard-fail at link time with a `multiple definition` error.
    // Pre-fix the linker silently kept whichever definition it
    // saw last; the produced binary returned 2 (from b.c) rather
    // than failing.
    let dir = tempdir("dup-fn");
    write_source(&dir, "a.c", "int foo(void) { return 1; }\n");
    write_source(
        &dir,
        "b.c",
        "int foo(void) { return 2; }\nint main() { return foo(); }\n",
    );
    let result = Command::new(badc())
        .arg("-o")
        .arg(dir.join("prog"))
        .arg(dir.join("a.c"))
        .arg(dir.join("b.c"))
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
        stderr.contains("multiple definition") && stderr.contains("foo"),
        "expected `multiple definition of foo` in stderr, got: {stderr}"
    );
    assert!(
        !stderr.contains("internal compiler error"),
        "duplicate-definition diagnostic must not be tagged as ICE: {stderr}"
    );
}

#[test]
fn static_inline_helper_in_shared_header_links_across_tus() {
    // C99 6.7.4 + 6.2.2: a `static inline` function at file scope
    // has internal linkage. A header that defines such a helper
    // and is included by two TUs creates a private copy of the
    // body in each TU's object; the linker must therefore see
    // two distinct internal-linkage symbols, not a duplicate
    // definition of the same external name.
    let dir = tempdir("static-inline-multi-tu");
    write_source(
        &dir,
        "h.h",
        "#ifndef _H\n#define _H\nstatic inline int helper(int x) { return x * 3 + 1; }\n#endif\n",
    );
    write_source(
        &dir,
        "a.c",
        "#include \"h.h\"\nint call_a(int x) { return helper(x); }\n",
    );
    write_source(
        &dir,
        "b.c",
        "#include \"h.h\"\nint call_b(int x) { return helper(x) + 100; }\n",
    );
    write_source(
        &dir,
        "main.c",
        "extern int call_a(int);\nextern int call_b(int);\n\
         int main(void) {\n\
         \tint a = call_a(2);\n\
         \tint b = call_b(2);\n\
         \treturn (a == 7 && b == 107) ? 0 : 1;\n\
         }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-I")
            .arg(&dir)
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("a.c"))
            .arg(dir.join("b.c"))
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link multi-TU with static inline header",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(0),
        "exit code mismatch: stdout={:?} stderr={:?}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
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

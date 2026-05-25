//! End-to-end smoke tests for the multi-translation-unit
//! linker, exercised through the actual badc binary. Each
//! test writes two or more `.c` files to a per-test temp
//! directory, drives the binary through `-c` and through
//! `--ar` + `-L`/`-l`, and confirms the produced native
//! executable runs and returns the expected exit status.
//!
//! Tests that exec the produced binary are gated on
//! `target_os = "linux"`: the native exec writer is ELF64-only
//! today, and the macOS host can't run a Linux binary even
//! when the writer succeeds.

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

// Gated on Linux: produces a Linux ELF that the test driver
// exec's directly, and the executable-link path through
// `link_native_objects` + `write_executable_elf64` is Linux-
// only today (the Mac / Windows backends consume bytecode `.o`
// shapes that `-c` no longer emits).
#[cfg(target_os = "linux")]
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

// Gated on Linux: same end-to-end exec + native-ELF-only
// constraint as `two_sources_compile_separately_then_link`.
#[cfg(target_os = "linux")]
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

// TODO: `link_native_objects` lets unresolved user-extern call
// sites slip through as PLT imports instead of erroring like
// `ld -e`. Re-enable once the linker distinguishes libc-import
// from user-extern references.
#[ignore]
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

// TODO: the native ELF writer emits every function as
// `STB_GLOBAL`; the per-TU `static inline` copies of `helper`
// then collide in the merger. Re-enable once linkage is
// threaded into `elf_reloc::write_relocatable`.
#[ignore]
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

// TODO: cross-TU data reloc miscalculation. Today the produced
// binary returns 1 (sum mismatch) instead of 0; the parked
// `R_X86_64_PC32` / `R_AARCH64_ADR_PREL_PG_HI21 + LO12_NC`
// pair lands on the wrong byte. Re-enable once the merge
// math is fixed.
#[ignore]
#[test]
fn extern_deferred_size_array_decays_in_other_tu() {
    // C99 6.7.5.2 + 6.2.2: `extern T x[];` declares an array of
    // unknown size; the defining declaration with the actual size
    // lives in another TU. The header form is the standard idiom
    // for cross-TU lookup tables. Within the consuming TU, every
    // use of `x` must decay to `T *` so `x[i]` and pointer
    // arithmetic resolve against the defining TU's storage at
    // link time.
    let dir = tempdir("extern-deferred-array");
    write_source(
        &dir,
        "table.c",
        "const unsigned char table[4] = { 10, 20, 30, 40 };\n",
    );
    write_source(
        &dir,
        "main.c",
        "extern const unsigned char table[];\n\
         int main(void) {\n\
         \tint sum = 0;\n\
         \tfor (int i = 0; i < 4; i++) sum += table[i];\n\
         \treturn sum == 100 ? 0 : 1;\n\
         }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("table.c"))
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link extern-deferred-array across TUs",
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
fn compile_only_writes_relocatable_elf() {
    let dir = tempdir("co-native");
    // `-c` flows through
    // `Compiler::with_options(.., no_entry_point=true)`, so a
    // standalone helper (no main / wmain / WinMain) compiles
    // cleanly into an ET_REL `.o` for the linker to pick the
    // entry point from later. Native ELF is the only `-c`
    // output today; the legacy badc-format `.o` writer has
    // retired.
    let src = write_source(&dir, "foo.c", "int seven(void) { return 7; }\n");
    let out = dir.join("foo-native.o");
    run(
        Command::new(badc())
            .arg("-c")
            .arg("-o")
            .arg(&out)
            .arg(&src)
            .current_dir(&dir),
        "compile-only",
    );
    assert!(out.exists(), "expected {} to exist", out.display());
    let bytes = std::fs::read(&out).expect("read .o");
    assert!(
        bytes.len() > 64 && &bytes[0..4] == b"\x7fELF",
        "expected ELF magic; got {:?}",
        &bytes.get(..16),
    );
    // ELF64 ET_REL (e_type = 1) at offset 0x10.
    let e_type = u16::from_le_bytes([bytes[16], bytes[17]]);
    assert_eq!(e_type, 1, "expected ET_REL (e_type=1), got {e_type}");
    // ELF class is 64-bit.
    assert_eq!(bytes[4], 2, "expected ELFCLASS64");
    // Little-endian.
    assert_eq!(bytes[5], 1, "expected ELFDATA2LSB");
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

/// Cross-TU end-to-end: compile two C sources separately via
/// `-c` (no shared `main`, no link-time gluing), then drive
/// both files through the public `parse_native_elf` +
/// `link_native_objects` API and assert the merger resolves
/// the cross-unit `helper` reference in place. Pins the
/// writer -> reader -> linker chain: a regression on either
/// side breaks here before the runtime SIGSEGVs.
#[cfg(target_os = "linux")]
#[test]
fn emit_native_then_link_native_resolves_cross_unit_call() {
    use badc::{NativeSymSection, link_native_objects, parse_native_elf};
    let dir = tempdir("emit-link-native");
    let a = write_source(
        &dir,
        "a.c",
        "int helper(void); int caller(void) { return helper() + 35; }\n",
    );
    let b = write_source(&dir, "b.c", "int helper(void) { return 7; }\n");
    let a_o = dir.join("a.o");
    let b_o = dir.join("b.o");
    run(
        Command::new(badc())
            .arg("-c")
            .arg("--target=linux-x64")
            .arg("-o")
            .arg(&a_o)
            .arg(&a)
            .current_dir(&dir),
        "compile a.c (-c)",
    );
    run(
        Command::new(badc())
            .arg("-c")
            .arg("--target=linux-x64")
            .arg("-o")
            .arg(&b_o)
            .arg(&b)
            .current_dir(&dir),
        "compile b.c (-c)",
    );
    let a_bytes = std::fs::read(&a_o).expect("read a.o");
    let b_bytes = std::fs::read(&b_o).expect("read b.o");
    let a_obj = parse_native_elf(&a_bytes).expect("parse a.o");
    let b_obj = parse_native_elf(&b_bytes).expect("parse b.o");
    // a.o has a cross-TU call to `helper` so its reloc list
    // carries an entry against an UNDEF symbol named "helper".
    let unresolved = a_obj
        .text_relocs
        .iter()
        .find(|r| {
            a_obj
                .symbols
                .get(r.sym_idx)
                .map(|s| s.name == "helper" && matches!(s.section, NativeSymSection::Undef))
                .unwrap_or(false)
        })
        .expect("a.o should carry an UNDEF `helper` reloc");
    let _ = unresolved;

    let merged = link_native_objects(&[a_obj, b_obj]).expect("link");
    let helper = merged
        .defined
        .get("helper")
        .expect("helper resolves in merged table");
    assert!(matches!(helper.section, NativeSymSection::Text));
    // The cross-TU CALL26 / PLT32 to `helper` is resolved in
    // place by the link pass; the import list must NOT carry
    // helper as a leftover.
    for p in &merged.pending_imports {
        let name = &merged.imports[p.import_index];
        assert_ne!(
            name, "helper",
            "expected helper reloc to resolve in place, but it parked as import",
        );
    }
}

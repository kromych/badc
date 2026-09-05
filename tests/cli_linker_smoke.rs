//! End-to-end smoke tests for the multi-translation-unit
//! linker, exercised through the actual badc binary. Each
//! test writes two or more `.c` files to a per-test temp
//! directory, drives the binary through `-c` and through
//! `--ar` + `-L`/`-l`, and confirms the produced native
//! executable runs and returns the expected exit status.
//!
//! Tests that exec the produced binary are gated on the host
//! target matching what's being emitted: linux-{aarch64,x86_64}
//! runs an ELF directly; macos-aarch64 runs a Mach-O directly;
//! windows-{aarch64,x86_64} runs natively on a matching Windows
//! host, and via wine on a matching Linux host when
//! `BADC_RUN_WINE=1` is set.

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

#[test]
fn weak_alias_strong_override_wins_at_link() {
    // A call through a weak alias keeps its relocation under -O, so a
    // strong definition of the alias name in another object replaces
    // the target's body at link time; with no override the weak alias
    // binds to its target.
    let dir = tempdir("weak-alias-override");
    let a = write_source(
        &dir,
        "a.c",
        "int real_fn(void) { return 41; }\n\
         int alias_fn(void) __attribute__((weak, alias(\"real_fn\")));\n\
         int caller(void) { return alias_fn() + 1; }\n",
    );
    let b = write_source(
        &dir,
        "b.c",
        "extern int caller(void);\n\
         int alias_fn(void) { return 7; }\n\
         int main(void) { return caller(); }\n",
    );
    let c = write_source(
        &dir,
        "c.c",
        "extern int caller(void);\nint main(void) { return caller(); }\n",
    );
    for s in [&a, &b, &c] {
        run(
            Command::new(badc())
                .arg("-O")
                .arg("-c")
                .arg(s)
                .current_dir(&dir),
            "compile unit",
        );
    }
    let strong = dir.join("strong");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&strong)
            .arg(dir.join("a.o"))
            .arg(dir.join("b.o"))
            .current_dir(&dir),
        "link with override",
    );
    let out = Command::new(&strong).output().expect("run strong");
    assert_eq!(
        out.status.code(),
        Some(8),
        "the strong alias_fn must override the weak alias"
    );
    let weak = dir.join("weak");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&weak)
            .arg(dir.join("a.o"))
            .arg(dir.join("c.o"))
            .current_dir(&dir),
        "link without override",
    );
    let out = Command::new(&weak).output().expect("run weak");
    assert_eq!(
        out.status.code(),
        Some(42),
        "with no override the weak alias binds to its target"
    );
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

#[test]
fn archive_members_are_pulled_on_demand() {
    // Archive semantics (SysV ar / ELF linker practice): a member
    // joins the link iff it defines a still-undefined symbol,
    // iterated to a fixpoint. An unreferenced member must stay out
    // even when it carries an unresolvable reference of its own or
    // defines a name the program also defines.
    let dir = tempdir("archive-on-demand");
    write_source(
        &dir,
        "m1.c",
        "extern int chain(void);\nint used(void) { return 11 + chain(); }\n",
    );
    // Pulled only through m1's reference (fixpoint).
    write_source(&dir, "m2.c", "int chain(void) { return 20; }\n");
    // Never referenced: its undefined `never_defined` must not fail
    // the link.
    write_source(
        &dir,
        "m3.c",
        "extern int never_defined(void);\nint unused_entry(void) { return never_defined(); }\n",
    );
    // Never referenced: its `helper` must not collide with main.c's.
    write_source(&dir, "m4.c", "int helper(void) { return 99; }\n");
    write_source(
        &dir,
        "main.c",
        "extern int used(void);\nint helper(void) { return 1; }\n\
         int main(void) { return used() + helper(); }\n",
    );
    run(
        Command::new(badc())
            .arg("--ar")
            .arg("-o")
            .arg(dir.join("libt.a"))
            .arg(dir.join("m1.c"))
            .arg(dir.join("m2.c"))
            .arg(dir.join("m3.c"))
            .arg(dir.join("m4.c"))
            .current_dir(&dir),
        "build archive",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("main.c"))
            .arg(dir.join("libt.a"))
            .current_dir(&dir),
        "link against the archive",
    );
    let out = Command::new(&exe).output().expect("run prog");
    // 11 + 20 + 1 = 32.
    assert_eq!(
        out.status.code(),
        Some(32),
        "exit code mismatch: stderr={:?}",
        String::from_utf8_lossy(&out.stderr)
    );
}

// The embedded on-demand sources join the member pool only when
// selection over the real archives stalls with a symbol still
// undefined. Host-independent: cross-links windows-x64 PEs, where
// the pool is never preprocessed away, and reads the `rtlib` phase
// of the BADC_LINK_STATS report -- present iff the pool compiled.
#[test]
fn on_demand_runtime_sources_compile_only_when_a_symbol_needs_them() {
    let dir = tempdir("lazy-rtlib");
    write_source(&dir, "plain.c", "int main(void) { return 0; }\n");
    // fnmatch has no msvcrt definition; the bundled pattern.c
    // supplies it, so this link stalls until the pool joins.
    write_source(
        &dir,
        "match.c",
        "#include <fnmatch.h>\nint main(void) { return fnmatch(\"a*\", \"abc\", 0); }\n",
    );
    let stats = |src: &str| -> String {
        let out = run(
            Command::new(badc())
                .env("BADC_LINK_STATS", "1")
                .arg("--target=windows-x64")
                .arg("-o")
                .arg(dir.join(src).with_extension("exe"))
                .arg(dir.join(src))
                .current_dir(&dir),
            "link windows-x64",
        );
        let err = String::from_utf8_lossy(&out.stderr).into_owned();
        assert!(err.contains("link stats"), "no stats line: {err}");
        err
    };
    let plain = stats("plain.c");
    assert!(
        !plain.contains(" rtlib="),
        "a fully resolved link compiled the on-demand sources: {plain}"
    );
    let matched = stats("match.c");
    assert!(
        matched.contains(" rtlib="),
        "the stalled link did not compile the on-demand sources: {matched}"
    );
}

// A cross link reads none of the host's libraries. The host's C
// library exports names the target's does not -- `fnmatch` is one
// glibc has and msvcrt lacks -- and resolving a reference against the
// host's would import a name the target's C library cannot supply,
// producing an image the loader rejects. The bundled sources define it
// instead, so the name stays out of the import table.
#[test]
fn a_cross_link_does_not_import_host_libc_names() {
    let dir = tempdir("cross-host-libc");
    let src = write_source(
        &dir,
        "match.c",
        "#include <fnmatch.h>\nint main(void) { return fnmatch(\"a*\", \"abc\", 0); }\n",
    );
    let exe = dir.join("match.exe");
    run(
        Command::new(badc())
            .arg("--target=windows-x64")
            .arg("-o")
            .arg(&exe)
            .arg(&src)
            .current_dir(&dir),
        "link windows-x64",
    );
    let image = std::fs::read(&exe).expect("read the image");
    // An import name is the only place a PE image spells a symbol.
    assert!(
        !image.windows(b"fnmatch".len()).any(|w| w == b"fnmatch"),
        "`fnmatch` reached the import table of {}",
        exe.display()
    );
}

// A shared library resolves a reference into a load-time import of the
// library the image depends on, so one in another container or for
// another architecture cannot supply it: the reference would bind to a
// library the image never loads (on PE, to the C library its bindings
// name). Both mismatches are a diagnostic, not an image.
#[test]
fn a_shared_library_for_another_target_is_refused() {
    let dir = tempdir("foreign-shared-lib");
    let lib_src = write_source(&dir, "ext.c", "int ext_fn(void) { return 3; }\n");
    let main_src = write_source(
        &dir,
        "main.c",
        "int ext_fn(void);\nint main(void) { return ext_fn(); }\n",
    );
    // An ELF shared object under each spelling a `-l` search accepts.
    for name in ["libext.dll", "libext.so"] {
        run(
            Command::new(badc())
                .arg("--target=linux-x64")
                .arg("--shared")
                .arg("-o")
                .arg(dir.join(name))
                .arg(&lib_src)
                .current_dir(&dir),
            "build the ELF shared library",
        );
    }
    let refused = |target: &str, want: &str| {
        let out = Command::new(badc())
            .arg(format!("--target={target}"))
            .arg("-o")
            .arg(dir.join("out"))
            .arg(&main_src)
            .arg(format!("-L{}", dir.display()))
            .arg("-lext")
            .current_dir(&dir)
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr).into_owned();
        assert!(
            !out.status.success() && err.contains(want),
            "{target}: expected a diagnostic naming {want}, got status={} stderr={err}",
            out.status
        );
    };
    // Container mismatch: an ELF library cannot back a PE import.
    refused("windows-x64", "PE/COFF");
    // Architecture mismatch, both sides ELF.
    refused("linux-aarch64", "arm64");
}

// An archive-only invocation is a valid link: the members supply the
// objects and `main` is pulled by the runtime's reference to it. The
// input-emptiness check must count archives, not just sources/objects.
#[cfg(target_os = "linux")]
#[test]
fn archive_only_invocation_links_and_pulls_main() {
    let dir = tempdir("archive-only");
    write_source(&dir, "prog.c", "int main(void) { return 7; }\n");
    run(
        Command::new(badc())
            .arg("--ar")
            .arg("-o")
            .arg(dir.join("libprog.a"))
            .arg(dir.join("prog.c"))
            .current_dir(&dir),
        "build archive",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("libprog.a"))
            .current_dir(&dir),
        "link archive-only",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(out.status.code(), Some(7), "exit code mismatch");
}

// A freestanding image's entry may live in a pre-compiled object; the
// defined-entry check must run after `.o` inputs are parsed, not before.
#[cfg(target_os = "linux")]
#[test]
fn freestanding_entry_defined_in_object_links() {
    let dir = tempdir("freestanding-obj");
    write_source(&dir, "fs.c", "void __c5_entry(void) { }\n");
    run(
        Command::new(badc())
            .arg("-c")
            .arg(dir.join("fs.c"))
            .arg("-o")
            .arg(dir.join("fs.o"))
            .current_dir(&dir),
        "compile -c",
    );
    let bin = dir.join("fs.bin");
    run(
        Command::new(badc())
            .arg("--freestanding")
            .arg(dir.join("fs.o"))
            .arg("-o")
            .arg(&bin)
            .current_dir(&dir),
        "freestanding link with entry in object",
    );
    assert!(bin.exists(), "freestanding image was not produced");
}

// The freestanding entry is a link root: an archive member that only
// defines the entry must be pulled so the image links.
#[cfg(target_os = "linux")]
#[test]
fn freestanding_entry_from_archive_is_pulled() {
    let dir = tempdir("freestanding-archive");
    write_source(&dir, "fs.c", "void __c5_entry(void) { }\n");
    run(
        Command::new(badc())
            .arg("--ar")
            .arg("-o")
            .arg(dir.join("libfs.a"))
            .arg(dir.join("fs.c"))
            .current_dir(&dir),
        "build archive",
    );
    let bin = dir.join("fs.bin");
    run(
        Command::new(badc())
            .arg("--freestanding")
            .arg(dir.join("libfs.a"))
            .arg("-o")
            .arg(&bin)
            .current_dir(&dir),
        "freestanding link with entry in archive",
    );
    assert!(bin.exists(), "freestanding image was not produced");
}

// `--entry=<sym>` / `--subsystem=<kind>` set the image entry and PE
// subsystem at the link step, so a link of precompiled `.o` inputs (which
// carry no `#pragma entrypoint` / `#pragma subsystem`) still stamps them.
// Host-independent: cross-compiles a windows-x64 PE and inspects its
// header. The link succeeding at all proves `--entry` was honoured -- the
// object defines only `my_efi_entry`, so a freestanding link that ignored
// the flag would fail on the missing default `__c5_entry`.
#[test]
fn cli_entry_and_subsystem_stamp_a_precompiled_object_link() {
    let dir = tempdir("cli-entry-subsystem");
    let src = write_source(
        &dir,
        "ent.c",
        "unsigned long long my_efi_entry(void *h, void *st) { (void)h; (void)st; return 0; }\n",
    );
    run(
        Command::new(badc())
            .arg("-c")
            .arg("--target=windows-x64")
            .arg(&src)
            .arg("-o")
            .arg(dir.join("ent.o"))
            .current_dir(&dir),
        "compile -c windows-x64",
    );
    let efi = dir.join("app.efi");
    run(
        Command::new(badc())
            .arg("--freestanding")
            .arg("--target=windows-x64")
            .arg("--entry=my_efi_entry")
            .arg("--subsystem=efi_application")
            .arg(dir.join("ent.o"))
            .arg("-o")
            .arg(&efi)
            .current_dir(&dir),
        "link .o with --entry/--subsystem",
    );
    let b = std::fs::read(&efi).expect("read app.efi");
    let pe = u32::from_le_bytes(b[0x3c..0x40].try_into().unwrap()) as usize;
    assert_eq!(&b[pe..pe + 4], b"PE\0\0", "not a PE image");
    let opt = pe + 24;
    let magic = u16::from_le_bytes(b[opt..opt + 2].try_into().unwrap());
    assert_eq!(magic, 0x020b, "expected PE32+ (0x20b), got {magic:#x}");
    let subsystem = u16::from_le_bytes(b[opt + 68..opt + 70].try_into().unwrap());
    assert_eq!(
        subsystem, 10,
        "expected IMAGE_SUBSYSTEM_EFI_APPLICATION (10)"
    );
    let entry_rva = u32::from_le_bytes(b[opt + 16..opt + 20].try_into().unwrap());
    assert_ne!(
        entry_rva, 0,
        "AddressOfEntryPoint must resolve `my_efi_entry`"
    );
}

#[test]
fn compile_only_warns_when_link_pragmas_are_dropped() {
    // `#pragma subsystem` / `#pragma entrypoint` ride the in-memory
    // program of the invocation that links; an ET_REL object carries
    // neither. `-c` must say so instead of silently emitting an
    // object that later links as a console / default-entry image.
    let dir = tempdir("compile-only-pragmas");
    write_source(
        &dir,
        "gui.c",
        "#pragma subsystem(windows)\nint main(void) { return 0; }\n",
    );
    write_source(
        &dir,
        "ep.c",
        "#pragma entrypoint(my_entry)\nint my_entry(void) { return 0; }\n",
    );
    write_source(&dir, "plain.c", "int main(void) { return 0; }\n");
    let compile = |name: &str| -> String {
        let out = run(
            Command::new(badc())
                .arg("--target=windows-x64")
                .arg("-c")
                .arg(dir.join(name))
                .arg("-o")
                .arg(dir.join(name).with_extension("o"))
                .current_dir(&dir),
            "compile -c",
        );
        String::from_utf8_lossy(&out.stderr).into_owned()
    };
    let gui = compile("gui.c");
    assert!(gui.contains("#pragma subsystem"), "stderr: {gui}");
    let ep = compile("ep.c");
    assert!(ep.contains("#pragma entrypoint"), "stderr: {ep}");
    let plain = compile("plain.c");
    assert!(!plain.contains("warning"), "stderr: {plain}");
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

/// A hard link error carries its catalogue code and no `-W` tail: the
/// row is not controllable, so no option moves it. `-Wno-dead-store`
/// stands for an accepted `-W` spelling here; the selector grammar
/// itself is the driver's to implement.
#[test]
fn a_hard_link_error_carries_its_code_and_no_option_moves_it() {
    let dir = tempdir("hard_link_error_code");
    write_source(
        &dir,
        "only.c",
        "extern int missing(int);\nint main() { return missing(7); }\n",
    );
    for extra in [&[][..], &["-Wno-dead-store"][..]] {
        let result = Command::new(badc())
            .args(extra)
            .arg("-o")
            .arg(dir.join("prog"))
            .arg(dir.join("only.c"))
            .current_dir(&dir)
            .output()
            .expect("invoke badc");
        let stderr = String::from_utf8_lossy(&result.stderr);
        assert!(
            !result.status.success(),
            "link should have failed: {stderr}"
        );
        assert!(
            stderr.contains("undefined reference to `missing`") && stderr.contains("[B6010]"),
            "expected the coded undefined-symbol error, got: {stderr}"
        );
        assert!(
            !stderr.contains("[-W"),
            "a hard row must not print an option tail: {stderr}"
        );
    }
}

#[test]
fn jit_runs_one_unit_and_passes_extra_inputs_as_argv() {
    // `--jit` / `--interp` compile a single translation unit; any
    // further command-line inputs are the hosted program's argv,
    // not additional units to link. The unit reports its own argc,
    // so passing two extra paths after the source must yield argc
    // == 3 (the unit path plus the two trailing tokens) and the
    // extra paths must never be opened or compiled.
    let dir = tempdir("jit-one-unit-argv");
    let main = write_source(
        &dir,
        "main.c",
        "int main(int argc, char **argv) { return argc; }\n",
    );
    let out = Command::new(badc())
        .arg("--jit")
        .arg(&main)
        .arg("first.c")
        .arg("second")
        .current_dir(&dir)
        .output()
        .expect("invoke badc --jit");
    assert_eq!(
        out.status.code(),
        Some(3),
        "argc mismatch: stdout={:?} stderr={:?}",
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

// C99 6.7.9p23: function-pointer initializers like
// `static const VTable v = { .fp = doubled };` must carry
// the target function's runtime VA. The ET_REL writer emits
// a `.rela.data` `R_X86_64_64` / `R_AARCH64_ABS64` against
// the `.text` section symbol with `r_addend = native offset
// of the target function`; the link / final-image writer
// pair patches the slot to `text_vaddr + offset`.
/// Regression: a function whose `return <int-literal>` statement
/// had its constant value live in a spill slot at allocation time
/// dropped the value on the floor at the epilogue. The x86_64 SSA
/// emit's return path only staged `Place::IntReg` returns into rcx
/// before the GPR restore, so spill-resident returns left rax with
/// whatever the body parked there (typically the last libc call's
/// `int` return). Surfaced as a module-registration function whose
/// `return 1` -- a result count the caller reads to know how many
/// values were produced -- reached the caller as zero, so the
/// registration saw an empty result and recorded nothing instead
/// of the intended table.
#[cfg(target_arch = "x86_64")]
#[test]
fn int_literal_return_survives_libc_call_in_body() {
    let dir = tempdir("ret-literal");
    let src = write_source(
        &dir,
        "main.c",
        "#include <stdio.h>\n\
         int returns_one(void) {\n\
             /* Push an external call between the body and the\n\
                return so the allocator parks the return value\n\
                in a spill slot; without the fix rax keeps the\n\
                libc int return (printf's char count) and the\n\
                caller observes the wrong value. */\n\
             printf(\"side effect\\n\");\n\
             return 1;\n\
         }\n\
         int main(void) {\n\
             int v = returns_one();\n\
             return v == 1 ? 42 : 7;\n\
         }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(&src)
            .current_dir(&dir),
        "compile",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(42),
        "expected return-1 to propagate through rax; got status={:?} stdout={:?}",
        out.status,
        String::from_utf8_lossy(&out.stdout),
    );
}

#[cfg(target_os = "linux")]
#[test]
fn function_pointer_initializer_resolves_at_link_time() {
    let dir = tempdir("fp-init");
    write_source(
        &dir,
        "lib.c",
        "int doubled(int n) { return n + n; }\n\
         typedef int (*fp_t)(int);\n\
         const fp_t vtable[] = { doubled };\n",
    );
    write_source(
        &dir,
        "main.c",
        "typedef int (*fp_t)(int);\n\
         extern const fp_t vtable[];\n\
         int main(void) { return vtable[0](21); }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("lib.c"))
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link function-pointer initializer across TUs",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(42),
        "exit code mismatch: stdout={:?} stderr={:?}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
}

// Cross-TU function-pointer argument: qsort in main.c gets a
// `cmp` defined in another TU. `Inst::ImmCode(target_bc_pc)`
// lowered to an adrp+add against a placeholder bc_pc with no
// `bytecode_to_native` entry; the codegen ICE'd until the
// fixup pass partitioned extern targets into the same
// named-symbol channel that data extern refs use.
#[cfg(target_os = "linux")]
#[test]
fn qsort_with_cross_tu_compare() {
    let dir = tempdir("qsort-xtu");
    write_source(
        &dir,
        "cmp.c",
        "int cmp(const void *a, const void *b) {\n\
         \treturn *(const int*)a - *(const int*)b;\n\
         }\n",
    );
    write_source(
        &dir,
        "main.c",
        "#include <stdlib.h>\n\
         extern int cmp(const void *, const void *);\n\
         int main(void) {\n\
         \tint a[] = { 5, 3, 8, 1, 9, 2, 7 };\n\
         \tqsort(a, 7, sizeof(int), cmp);\n\
         \treturn a[0] == 1 && a[6] == 9 ? 0 : 1;\n\
         }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("cmp.c"))
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link qsort cross-TU compare",
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

// stdio buffers were lost when the writer's `_start` stub
// called `exit_group` via syscall, bypassing libc's atexit
// chain. The embedded runtime (`libc/lib/runtime.c`) now exports
// `__c5_exit` which calls libc `exit`; the writer's stub
// routes the tail through it when the symbol is present.
// Redirecting stdout to a file forces full buffering, so the
// test would have surfaced an empty file under the bug.
#[cfg(target_os = "linux")]
#[test]
fn printf_output_survives_redirected_stdout() {
    let dir = tempdir("stdio-flush");
    write_source(
        &dir,
        "main.c",
        "#include <stdio.h>\n\
         int main(void) {\n\
         \tprintf(\"hello\\n\");\n\
         \treturn 0;\n\
         }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link stdio-flush program",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(0),
        "exit code mismatch: stderr={:?}",
        String::from_utf8_lossy(&out.stderr)
    );
    assert_eq!(
        String::from_utf8_lossy(&out.stdout).as_ref(),
        "hello\n",
        "stdout mismatch: stdout={:?}",
        String::from_utf8_lossy(&out.stdout)
    );
}

// AArch64 calling convention: a libc / dylib call must use
// `BL` (branch-with-link) so the callee's `RET` returns into
// the caller. The SSA emit's PLT call placeholder used `B`
// (unconditional branch); the apply_plt_call_fixups patcher
// only rewrote the imm26 and left the opcode as B. Result:
// the libc call became a tail jump, the callee `ret`'d to
// `_start`'s lr (post-`bl main`), and main's epilogue never
// ran -- the exit-group syscall picked up the libc call's
// return value as the program's exit code.
#[cfg(target_os = "linux")]
#[test]
fn libc_call_then_return_constant() {
    let dir = tempdir("libc-then-return");
    write_source(
        &dir,
        "main.c",
        "#include <stdio.h>\n\
         int main(void) {\n\
         \tint n = printf(\"hi\\n\");\n\
         \treturn n + 100;\n\
         }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link libc call + return",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(103),
        "exit code mismatch: stdout={:?} stderr={:?}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
}

// C99 7.16: a variadic function's prototype carries the
// trailing `...`. c5's variadic ABI is custom -- args go on
// the c5 stack at 16-byte stride, the callee skips the host-
// arg-reg spill step -- so caller and callee must agree on
// `is_variadic`. The per-arch lowerer's `variadic_targets`
// set used to ride on `FunctionSsa::is_variadic` only, which
// missed cross-TU extern callees (their bodies live in a
// sibling TU). Folding `Symbol::is_variadic` into the set
// closes the gap.
#[cfg(target_os = "linux")]
#[test]
fn variadic_call_resolves_across_tus() {
    let dir = tempdir("variadic-xtu");
    write_source(
        &dir,
        "vad.c",
        "#include <stdarg.h>\n\
         int va_test(int n, ...) {\n\
         \tva_list ap; va_start(ap, n);\n\
         \tint s = 0;\n\
         \tfor (int i = 0; i < n; i++) s += va_arg(ap, int);\n\
         \tva_end(ap);\n\
         \treturn s;\n\
         }\n",
    );
    write_source(
        &dir,
        "use.c",
        "extern int va_test(int, ...);\n\
         int main(void) {\n\
         \tint a = va_test(2, 10, 20);\n\
         \tint b = va_test(4, 1, 2, 3, 4);\n\
         \treturn a + b;\n\
         }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("vad.c"))
            .arg(dir.join("use.c"))
            .current_dir(&dir),
        "link variadic call cross-TU",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(40),
        "exit code mismatch: stdout={:?} stderr={:?}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
}

// C99 6.5.16: `fp = some_function;` reduces to taking the
// function's address. The aarch64 emitter lowers
// `&some_function` to an `adrp + add` pair whose
// `R_AARCH64_ADR_PREL_PG_HI21 + ADD_ABS_LO12_NC` immediates
// depend on the runtime VA of `.text`. The `.text` segment's
// vmaddr in a c5-produced ELF is `BASE + ELF header + 2
// program headers = 0x4000b0` -- non-page-aligned -- so the
// link step has to defer the patch to the final-image writer
// (which knows `text_vaddr`).
#[cfg(target_os = "linux")]
#[test]
fn function_pointer_runtime_assign_targets_local_function() {
    let dir = tempdir("fp-runtime-assign");
    write_source(
        &dir,
        "fns.c",
        "int alpha(int n) { return n + 1; }\n\
         int beta(int n) { return n * 2; }\n\
         typedef int (*fp_t)(int);\n\
         fp_t current = alpha;\n\
         void set_beta(void) { current = beta; }\n",
    );
    write_source(
        &dir,
        "use.c",
        "typedef int (*fp_t)(int);\n\
         extern fp_t current;\n\
         extern void set_beta(void);\n\
         int main(void) {\n\
         \tint a = current(5);\n\
         \tset_beta();\n\
         \tint b = current(5);\n\
         \treturn (a == 6 && b == 10) ? 0 : 1;\n\
         }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("fns.c"))
            .arg(dir.join("use.c"))
            .current_dir(&dir),
        "link function-pointer runtime assignment",
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

// C99 6.3.2.1p3: an array name in a non-lvalue context
// decays to a pointer to its first element. The global
// initializer parser used to reject bare-array RHS as
// `constant integer expected`; now it emits the same
// DataReloc as `&arr[0]` would.
#[cfg(target_os = "linux")]
#[test]
fn array_to_pointer_decay_in_global_initializer() {
    let dir = tempdir("array-decay");
    write_source(
        &dir,
        "lib.c",
        "int a = 1, b = 2, c = 3;\n\
         int *arr2[] = { &a, &b, &c };\n\
         int **pparr = arr2;\n",
    );
    write_source(
        &dir,
        "use.c",
        "extern int **pparr;\n\
         int main(void) { return (*pparr[0]) + (*pparr[1]) + (*pparr[2]); }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("lib.c"))
            .arg(dir.join("use.c"))
            .current_dir(&dir),
        "link array-decay-as-pointer global initializer",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(6),
        "exit code mismatch: stdout={:?} stderr={:?}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
}

// C99 6.2.2p2: an inline definition's identifier keeps external
// linkage, so `&f` denotes one function program-wide even though
// 6.7.4p6 lets the unit implement its own calls from the local body.
// The unit holding the inline definition and the unit holding the
// external definition must agree on the pointer, as they do under gcc
// and clang.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn inline_definition_address_is_the_same_across_tus() {
    for opt in ["", "-O"] {
        let dir = tempdir(&format!("inline-addr{}", opt.len()));
        write_source(
            &dir,
            "inl.c",
            "inline int f(int x) { return x + 1; }\n\
             int (*pa)(int) = f;\n\
             int ca(void) { return f(1); }\n",
        );
        write_source(
            &dir,
            "ext.c",
            "int f(int x) { return x + 1; }\n\
             int (*pb)(int) = f;\n",
        );
        write_source(
            &dir,
            "main.c",
            "extern int (*pa)(int);\n\
             extern int (*pb)(int);\n\
             extern int ca(void);\n\
             int main(void) { return (pa == pb) && ca() == 2 ? 42 : 1; }\n",
        );
        let exe = dir.join("prog");
        let mut cmd = Command::new(badc());
        if !opt.is_empty() {
            cmd.arg(opt);
        }
        run(
            cmd.arg("-o")
                .arg(&exe)
                .arg(dir.join("inl.c"))
                .arg(dir.join("ext.c"))
                .arg(dir.join("main.c"))
                .current_dir(&dir),
            "link inline definition + external definition",
        );
        let out = Command::new(&exe).output().expect("run prog");
        assert_eq!(
            out.status.code(),
            Some(42),
            "{opt}: the two units disagree on `&f`: stdout={:?} stderr={:?}",
            String::from_utf8_lossy(&out.stdout),
            String::from_utf8_lossy(&out.stderr)
        );
    }
}

// The address escaping as an external reference means a program that
// never defines the function fails to link, which is what gcc and clang
// report for the same source.
#[test]
fn inline_definition_address_without_an_external_definition_fails_link() {
    let dir = tempdir("inline-addr-undef");
    write_source(
        &dir,
        "only.c",
        "inline int f(int x) { return x + 1; }\n\
         int (*p)(int) = f;\n\
         int main(void) { return p(41); }\n",
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
        stderr.contains("undefined reference") && stderr.contains('f'),
        "expected an undefined reference to `f`, got: {stderr}"
    );
}

// C99 6.7.9p23 + 6.2.2: a function-pointer initializer whose
// target lives in another TU must resolve to the defining
// unit's `.text` offset. The native ET_REL writer emits the
// `.rela.data` row against the named UNDEF function symbol
// (not the `.text` section symbol); the link / final-image
// writer pair resolves the slot to `text_vaddr + target`.
#[cfg(target_os = "linux")]
#[test]
fn function_pointer_init_targets_extern_function() {
    let dir = tempdir("fp-init-extern");
    write_source(&dir, "def.c", "int add(int a, int b) { return a + b; }\n");
    write_source(
        &dir,
        "refer.c",
        "extern int add(int, int);\n\
         int (*const fp)(int,int) = add;\n\
         int main(void) { return fp(20, 22); }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("def.c"))
            .arg(dir.join("refer.c"))
            .current_dir(&dir),
        "link function-pointer init -> extern function",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(42),
        "exit code mismatch: stdout={:?} stderr={:?}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
}

// C99 6.7.9p23: a static-storage-duration object initialized
// with the address of another static-storage object resolves
// at translation-unit-load time. The native ET_REL writer
// emits a `.rela.data` `R_X86_64_64` / `R_AARCH64_ABS64`
// against the target's `.data` offset; the link / final-image
// writer pair patches the slot to hold the target's runtime
// VA before the executable runs.
#[cfg(target_os = "linux")]
#[test]
fn pointer_to_global_initializer_resolves_at_link_time() {
    let dir = tempdir("ptr-to-global");
    write_source(&dir, "ptr.c", "int storage = 42;\nint *gp = &storage;\n");
    write_source(
        &dir,
        "deref.c",
        "extern int *gp;\nint main(void) { return *gp; }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("ptr.c"))
            .arg(dir.join("deref.c"))
            .current_dir(&dir),
        "link pointer-to-global initializer across TUs",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(42),
        "exit code mismatch: stdout={:?} stderr={:?}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
}

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

/// Compile a two-function source and assert `.debug_line`
/// places a row at each function's entry PC, not just at the
/// first body instruction. Without the per-function-entry seed,
/// a breakpoint at low_pc has no covering line entry and lldb
/// shows no source -- the row coverage starts past the prologue.
#[test]
fn debug_line_covers_each_function_entry_pc() {
    use std::path::Path;
    let dir = tempdir("dwarf-line-entry");
    let src = write_source(
        &dir,
        "f.c",
        "int helper(int x) {\n    int y = x + 1;\n    return y;\n}\n\
         int main(void) {\n    return helper(41);\n}\n",
    );
    let out = dir.join("f");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(&src)
            .current_dir(&dir),
        "compile",
    );
    assert!(out.exists(), "expected {} to exist", out.display());
    // dwarfdump is part of every Xcode CLT install on macOS and
    // every binutils install on Linux. Skip the assertion if it
    // isn't on PATH so the test still runs in a stripped image;
    // the rest of the test surface (file emission, exit code)
    // still guards the underlying behaviour.
    let dd = Command::new("dwarfdump")
        .arg("--debug-line")
        .arg(&out)
        .output();
    // posix_spawnp on glibc returns Ok with exit 127 when the
    // binary is missing, so a missing-tool image lands here with
    // a non-zero status and empty stdout instead of an Err. Bail
    // on either signal so the test still runs on stripped images.
    let Ok(dd_out) = dd else {
        return;
    };
    if !dd_out.status.success() || dd_out.stdout.is_empty() {
        return;
    }
    let out_text = String::from_utf8_lossy(&dd_out.stdout).into_owned();
    // Extract every (Address, Line) pair from the table body.
    let mut rows: Vec<(u64, u32)> = Vec::new();
    for line in out_text.lines() {
        // Lines look like: "0x000000010000076c    4    0    1    0   ..."
        let trimmed = line.trim_start();
        if let Some(rest) = trimmed.strip_prefix("0x") {
            let mut parts = rest.split_ascii_whitespace();
            let addr_hex = parts.next().unwrap_or("");
            let line_str = parts.next().unwrap_or("");
            if let (Ok(addr), Ok(ln)) = (u64::from_str_radix(addr_hex, 16), line_str.parse::<u32>())
            {
                rows.push((addr, ln));
            }
        }
    }
    assert!(!rows.is_empty(), "expected at least one line row");
    // Use `nm` to recover each function's start address; the
    // assertion is that every function has a row at-or-before
    // its low_pc. `nm` is in the same toolchain as dwarfdump.
    let nm_out = Command::new("nm")
        .arg(&out)
        .output()
        .ok()
        .map(|o| String::from_utf8_lossy(&o.stdout).into_owned())
        .unwrap_or_default();
    let _ = Path::new("/usr/bin/nm");
    let mut func_pcs: Vec<u64> = Vec::new();
    for ln in nm_out.lines() {
        // nm format: "<hex> T _name" or "<hex> T name".
        let mut parts = ln.split_ascii_whitespace();
        let Some(addr) = parts.next() else { continue };
        let Some(kind) = parts.next() else { continue };
        let Some(name) = parts.next() else { continue };
        if kind != "T" && kind != "t" {
            continue;
        }
        let stripped_name = name.strip_prefix('_').unwrap_or(name);
        if stripped_name != "helper" && stripped_name != "main" {
            continue;
        }
        if let Ok(a) = u64::from_str_radix(addr, 16) {
            func_pcs.push(a);
        }
    }
    if func_pcs.is_empty() {
        return; // `nm` not in expected format; skip the strict assert.
    }
    for pc in func_pcs {
        let covered = rows.iter().any(|&(a, _)| a == pc);
        assert!(
            covered,
            "expected a .debug_line row at function entry {pc:#x}; rows = {rows:?}",
        );
    }
}

/// DWARF 4 section 6.2.5.3: the first row whose address is past
/// the prologue should carry the `prologue_end` flag so debuggers
/// land `break main` past the function prologue rather than at the
/// entry PC. Both the amalg and multi-TU paths set the flag on the
/// first real source row after each function-entry synthetic row.
#[test]
fn debug_line_flags_prologue_end_per_function() {
    let dir = tempdir("dwarf-line-prologue-end");
    let src = write_source(
        &dir,
        "f.c",
        "int helper(int x) {\n    int y = x + 1;\n    return y;\n}\n\
         int main(void) {\n    return helper(41);\n}\n",
    );
    let out = dir.join("f");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(&src)
            .current_dir(&dir),
        "compile",
    );
    let mut dd = Command::new("llvm-dwarfdump");
    dd.arg("--debug-line").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("dwarfdump")
                .arg("--debug-line")
                .arg("--verbose")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    let lower = out_text.to_ascii_lowercase();
    assert!(
        lower.contains("prologue_end"),
        "expected `prologue_end` flag in .debug_line for at least one row:\n{out_text}",
    );
}

/// Locks the multi-TU DWARF link path: each input unit's
/// compile-unit DIE should survive the merge with its own
/// `DW_AT_name`, its `Abbrev Offset` should advance into the
/// merged `.debug_abbrev`, `DW_AT_stmt_list` should index into
/// the merged `.debug_line`, and `DW_AT_low_pc` should point at
/// the function's actual runtime address. Regressions historically
/// surfaced as zeroed address slots or a stray null-DIE hiding
/// every CU past the first; both fall out of the assertions
/// below.
#[test]
fn multi_tu_link_preserves_per_unit_dwarf_cu() {
    let dir = tempdir("multi-tu-dwarf");
    write_source(&dir, "helper.c", "int helper(int x) { return x + 1; }\n");
    write_source(
        &dir,
        "main.c",
        "extern int helper(int);\nint main(void) { return helper(0); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    assert!(out.exists(), "expected {} to exist", out.display());
    // `dwarfdump` (BSD) / `llvm-dwarfdump` / GNU `objdump
    // --dwarf=info` all walk `.debug_info` by the CU header's
    // `unit_length`; pick whichever is on PATH first.
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    // Every source file the linker pulled in should surface as a
    // CU. Runtime helpers (`runtime.c`) get appended to the
    // input set; the user-source CUs are the strict subset the
    // assertion targets.
    for name in ["main.c", "helper.c"] {
        assert!(
            out_text.contains(name),
            "expected CU DIE for `{name}` in merged .debug_info:\n{out_text}",
        );
    }
    // Past the first CU the linker has to rebase the abbrev
    // offset; a zero here means the rebase pass silently
    // skipped the slot. `Abbrev Offset` is the column name
    // both dumpers use.
    let nonzero_abbrev_offsets = out_text
        .lines()
        .filter(|l| l.contains("Abbrev Offset:") || l.contains("abbr_offset ="))
        .filter(|l| !(l.contains(": 0x0\n") || l.ends_with(": 0")))
        .count();
    assert!(
        nonzero_abbrev_offsets >= 1,
        "expected at least one CU's Abbrev Offset to land past the first abbrev table:\n{out_text}",
    );
    // Each user CU should carry a DW_TAG_subprogram DIE naming
    // its defined function. Without the subprogram emit in
    // `dwarf_reloc.rs`, debuggers fall back to the static
    // symbol table for function names and can't drive
    // `frame variable` / `info locals` at non-line-row
    // breakpoints.
    let subprog_count = out_text.matches("DW_TAG_subprogram").count();
    assert!(
        subprog_count >= 2,
        "expected at least two DW_TAG_subprogram DIEs (helper + main) in merged .debug_info, \
         got {subprog_count}:\n{out_text}",
    );
    for name in ["\"helper\"", "\"main\""] {
        assert!(
            out_text.contains(name),
            "expected subprogram DW_AT_name {name} in merged .debug_info:\n{out_text}",
        );
    }
    // Helper takes `int x`, so its subprogram DIE should carry
    // a DW_TAG_formal_parameter child with a DW_OP_fbreg
    // location pointing at the first stack-arg slot. Without
    // DW_AT_frame_base + DW_TAG_formal_parameter / variable
    // DIEs, the debugger can't walk locals through `frame
    // variable`.
    assert!(
        out_text.contains("DW_TAG_formal_parameter"),
        "expected DW_TAG_formal_parameter DIE for `int x` in helper's subprogram:\n{out_text}",
    );
    assert!(
        out_text.contains("DW_AT_frame_base") && out_text.contains("DW_OP_reg"),
        "expected DW_AT_frame_base on subprograms with children:\n{out_text}",
    );
    assert!(
        out_text.contains("DW_OP_fbreg"),
        "expected formal_parameter DW_AT_location as DW_OP_fbreg:\n{out_text}",
    );
    // The type catalog (`DW_TAG_base_type` per distinct
    // leaf scalar type, plus pointer wrappers) lets the
    // debugger print typed values for parameters and locals.
    // Both fixture functions take `int` and the test runs the
    // helper through main, so an `int` base_type DIE must land
    // in each CU that names a function. Per-CU duplication is
    // fine (the type catalog isn't deduped across CUs).
    let base_type_count = out_text.matches("DW_TAG_base_type").count();
    assert!(
        base_type_count >= 2,
        "expected at least one DW_TAG_base_type per user CU (helper + main), \
         got {base_type_count}:\n{out_text}",
    );
    assert!(
        out_text.contains("DW_AT_type") && out_text.contains("DW_ATE_signed"),
        "expected DW_AT_type cross-refs + DW_ATE_signed encoding on int base_type:\n{out_text}",
    );
}

/// Aggregate types (`struct Point { int x; int y; }`) surface
/// as `DW_TAG_structure_type` DIEs with `DW_TAG_member` children
/// in the merged debug_info, with each member's `DW_AT_type`
/// pointing at the scalar catalog earlier in the same CU. The
/// regression watches for the dependency-emit-order bug that
/// surfaced when the catalog was first wired -- struct fields
/// must reach their type DIE through a backward `DW_FORM_ref4`.
#[test]
fn multi_tu_link_emits_struct_dies() {
    let dir = tempdir("multi-tu-struct-dies");
    write_source(
        &dir,
        "helper.c",
        "struct Point { int x; int y; };\n\
         int helper(struct Point p) { return p.x + p.y; }\n",
    );
    write_source(
        &dir,
        "main.c",
        "struct Point { int x; int y; };\n\
         extern int helper(struct Point);\n\
         int main(void) { struct Point p; p.x = 2; p.y = 3; return helper(p); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_TAG_structure_type"),
        "expected DW_TAG_structure_type DIE for `struct Point`:\n{out_text}",
    );
    assert!(
        out_text.contains("\"Point\""),
        "expected DW_AT_name `Point` on the structure_type:\n{out_text}",
    );
    let member_count = out_text.matches("DW_TAG_member").count();
    assert!(
        member_count >= 2,
        "expected at least two DW_TAG_member DIEs (x + y), got {member_count}:\n{out_text}",
    );
    for field in ["\"x\"", "\"y\""] {
        assert!(
            out_text.contains(field),
            "expected DW_AT_name {field} on a member:\n{out_text}",
        );
    }
    assert!(
        out_text.contains("DW_AT_data_member_location"),
        "expected DW_AT_data_member_location on struct members:\n{out_text}",
    );
}

/// Nested aggregate-as-field types (struct embedded inside
/// another struct) need the type catalog to emit the inner
/// struct before the outer one so the outer's
/// `DW_TAG_member` can DW_AT_type-reference the inner DIE's
/// CU-relative offset. The topological sort over the
/// aggregate-id dependency graph drives the emit order;
/// pointer-to-aggregate fields don't contribute edges (their
/// pointer_type wrappers forward-ref4 cleanly).
#[test]
fn multi_tu_link_emits_nested_struct_dies() {
    let dir = tempdir("multi-tu-nested-struct");
    write_source(
        &dir,
        "helper.c",
        "struct Inner { int x; int y; };\n\
         struct Outer { int tag; struct Inner inner; };\n\
         int helper(struct Outer o) { return o.tag + o.inner.x + o.inner.y; }\n",
    );
    write_source(
        &dir,
        "main.c",
        "struct Inner { int x; int y; };\n\
         struct Outer { int tag; struct Inner inner; };\n\
         extern int helper(struct Outer);\n\
         int main(void) {\n\
             struct Outer o; o.tag = 7; o.inner.x = 2; o.inner.y = 3;\n\
             return helper(o);\n\
         }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    for name in ["\"Inner\"", "\"Outer\""] {
        assert!(
            out_text.contains(name),
            "expected DW_AT_name {name} on a structure_type DIE:\n{out_text}",
        );
    }
    // The outer struct's `inner` member should DW_AT_type to
    // the inner struct's DIE -- evidence the topological sort
    // placed Inner ahead of Outer so the ref4 is a backward
    // reference.
    assert!(
        out_text.contains("\"inner\""),
        "expected nested `inner` member's DW_AT_name in merged debug_info:\n{out_text}",
    );
    let outer_member_inner = out_text
        .lines()
        .skip_while(|l| !l.contains("\"inner\""))
        .take(3)
        .collect::<Vec<_>>()
        .join("\n");
    assert!(
        outer_member_inner.contains("\"Inner\""),
        "expected `inner` member to DW_AT_type-reference the Inner struct DIE:\n{outer_member_inner}",
    );
}

/// Amalg dwarf.rs counterpart of the multi-TU enum DIE test.
/// Single-source compile must also emit DW_TAG_enumeration_type
/// for tagged enums; the amalg path keeps the names inline via
/// DW_FORM_string to avoid extending the sealed catalog string
/// table.
#[test]
fn amalg_compile_emits_enumeration_type_for_tagged_enum() {
    let dir = tempdir("amalg-enum-die");
    let src = write_source(
        &dir,
        "f.c",
        "enum Mode { Off, On = 7 };\n\
         int main(void) { return On; }\n",
    );
    let out = dir.join("f");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(&src)
            .current_dir(&dir),
        "compile",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_TAG_enumeration_type"),
        "expected DW_TAG_enumeration_type for `enum Mode` in amalg compile:\n{out_text}",
    );
    assert!(
        out_text.contains("\"Mode\""),
        "expected DW_AT_name `Mode`:\n{out_text}",
    );
    for cname in ["\"Off\"", "\"On\""] {
        assert!(
            out_text.contains(cname),
            "expected enumerator {cname}:\n{out_text}",
        );
    }
}

/// Tagged enums emit DW_TAG_enumeration_type with one
/// DW_TAG_enumerator per constant. C99 6.7.2.2 enums collapse to
/// `int` in c5's type system, so the DIE is standalone (no
/// variable references it via DW_AT_type) but `(gdb) ptype enum
/// Tag` still resolves the named constants. Anonymous enums
/// (no tag) skip emission.
#[test]
fn multi_tu_link_emits_enumeration_type_for_tagged_enum() {
    let dir = tempdir("multi-tu-enum-die");
    write_source(
        &dir,
        "helper.c",
        "enum Color { Red, Green = 10, Blue };\n\
         int helper(int c) { return c + Red + Green + Blue; }\n",
    );
    write_source(
        &dir,
        "main.c",
        "extern int helper(int);\nint main(void) { return helper(0); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_TAG_enumeration_type"),
        "expected DW_TAG_enumeration_type for `enum Color`:\n{out_text}",
    );
    assert!(
        out_text.contains("\"Color\""),
        "expected DW_AT_name `Color` on the enumeration_type:\n{out_text}",
    );
    for cname in ["\"Red\"", "\"Green\"", "\"Blue\""] {
        assert!(
            out_text.contains(cname),
            "expected enumerator {cname}:\n{out_text}",
        );
    }
}

/// DW_AT_decl_file on variable + formal_parameter DIEs lets the
/// debugger show the declaration's source file. Symbol::decl_file
/// is captured at parse time from the lexer's intern_source_file
/// index; the emit pass adds 1 to convert from c5's 0-indexed
/// table to DWARF's 1-indexed file_names slot.
#[test]
fn multi_tu_link_emits_decl_file_on_locals() {
    let dir = tempdir("multi-tu-decl-file");
    write_source(
        &dir,
        "helper.c",
        "int helper(int x) {\n    int y = x + 1;\n    return y;\n}\n",
    );
    write_source(
        &dir,
        "main.c",
        "extern int helper(int);\nint main(void) { return helper(0); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_AT_decl_file"),
        "expected DW_AT_decl_file on at least one variable / formal_parameter DIE:\n{out_text}",
    );
}

/// Every subprogram DIE carries DW_AT_calling_convention =
/// DW_CC_normal (1) per DWARF 4 section 3.3.1.1. SysV / Win64 /
/// AAPCS64 all fall under the C standard convention as far as
/// debuggers are concerned.
#[test]
fn multi_tu_link_emits_calling_convention_on_subprograms() {
    let dir = tempdir("multi-tu-calling-convention");
    write_source(&dir, "helper.c", "int helper(int x) { return x + 1; }\n");
    write_source(
        &dir,
        "main.c",
        "extern int helper(int);\nint main(void) { return helper(0); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_AT_calling_convention"),
        "expected DW_AT_calling_convention on at least one subprogram:\n{out_text}",
    );
    // DW_CC_normal renders as `DW_CC_normal` in llvm-dwarfdump's
    // verbose output and `(DW_CC_normal)` in macOS dwarfdump.
    assert!(
        out_text.contains("DW_CC_normal"),
        "expected DW_CC_normal value on at least one subprogram:\n{out_text}",
    );
}

/// Amalg dwarf.rs counterpart of
/// `multi_tu_link_emits_array_type_for_struct_field_arrays`.
/// Single-source compile through the amalg path also needs to
/// render struct fields declared as `int xs[N]` as `int [N]`.
#[test]
fn amalg_compile_emits_array_type_for_struct_field_arrays() {
    let dir = tempdir("amalg-struct-array");
    let src = write_source(
        &dir,
        "f.c",
        "struct Buf { int xs[8]; };\n\
         int main(void) { struct Buf b; b.xs[0] = 9; return b.xs[0]; }\n",
    );
    let out = dir.join("f");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(&src)
            .current_dir(&dir),
        "compile",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_TAG_array_type"),
        "expected DW_TAG_array_type for struct field `int xs[8]` in amalg compile:\n{out_text}",
    );
    assert!(
        out_text.contains("\"xs\""),
        "expected member DW_AT_name `xs`:\n{out_text}",
    );
}

/// Struct fields declared as fixed-size arrays (e.g.
/// `struct S { int xs[8]; }`) need to reference a
/// DW_TAG_array_type DIE rather than decaying to the element
/// type. Without it `(gdb) ptype struct S` shows `int xs;`
/// instead of `int xs[8]`.
#[test]
fn multi_tu_link_emits_array_type_for_struct_field_arrays() {
    let dir = tempdir("multi-tu-struct-array");
    write_source(
        &dir,
        "helper.c",
        "struct Buf { int xs[8]; };\n\
         int helper(struct Buf *b) { return b->xs[0]; }\n",
    );
    write_source(
        &dir,
        "main.c",
        "struct Buf { int xs[8]; };\n\
         extern int helper(struct Buf *);\n\
         int main(void) { struct Buf b; b.xs[0] = 9; return helper(&b); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    // The DW_TAG_array_type must exist and the `xs` member must
    // sit downstream of an array DIE (proxied by the presence of
    // both tags together).
    assert!(
        out_text.contains("DW_TAG_array_type"),
        "expected DW_TAG_array_type for struct field `int xs[8]`:\n{out_text}",
    );
    assert!(
        out_text.contains("\"xs\""),
        "expected member DW_AT_name `xs`:\n{out_text}",
    );
}

/// Single-source compile through the amalg dwarf.rs path emits
/// DW_TAG_array_type for true local arrays. Mirrors the multi-TU
/// coverage in `multi_tu_link_emits_array_type_for_local_arrays`.
#[test]
fn amalg_compile_emits_array_type_for_local_arrays() {
    let dir = tempdir("amalg-array-type");
    let src = write_source(
        &dir,
        "f.c",
        "int main(void) {\n    int xs[5];\n    xs[0] = 7;\n    return xs[0];\n}\n",
    );
    let out = dir.join("f");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(&src)
            .current_dir(&dir),
        "compile",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_TAG_array_type"),
        "expected DW_TAG_array_type for `int xs[5]` in amalg compile:\n{out_text}",
    );
    assert!(
        out_text.contains("DW_TAG_subrange_type"),
        "expected DW_TAG_subrange_type child:\n{out_text}",
    );
}

/// True local arrays (`int xs[N]`) get DW_TAG_array_type with a
/// DW_TAG_subrange_type child carrying DW_AT_upper_bound = N - 1
/// per DWARF 4 section 5.13. `ptype xs` in gdb then shows
/// `int [N]` rather than just `int`. Parameters decay to pointers
/// per C99 6.7.5.3p7 and keep their pointer-type DIE.
#[test]
fn multi_tu_link_emits_array_type_for_local_arrays() {
    let dir = tempdir("multi-tu-array-type");
    write_source(
        &dir,
        "helper.c",
        "int helper(void) {\n    int xs[5];\n    xs[0] = 7;\n    return xs[0];\n}\n",
    );
    write_source(
        &dir,
        "main.c",
        "extern int helper(void);\nint main(void) { return helper(); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_TAG_array_type"),
        "expected DW_TAG_array_type for `int xs[5]`:\n{out_text}",
    );
    assert!(
        out_text.contains("DW_TAG_subrange_type"),
        "expected DW_TAG_subrange_type child of the array_type DIE:\n{out_text}",
    );
    assert!(
        out_text.contains("DW_AT_upper_bound"),
        "expected DW_AT_upper_bound on the subrange_type DIE:\n{out_text}",
    );
}

/// Every c5-emitted subprogram has DW_AT_prototyped set per
/// DWARF 4 section 3.3.3.7 -- c5 rejects K&R-style identifier-
/// list declarators (C99 6.7.6.3p14) so every function is
/// prototyped at the source level. Debuggers rely on this flag
/// to know the formal-parameter list is authoritative.
#[test]
fn multi_tu_link_emits_prototyped_flag_on_subprograms() {
    let dir = tempdir("multi-tu-prototyped");
    write_source(&dir, "helper.c", "int helper(int x) { return x + 1; }\n");
    write_source(
        &dir,
        "main.c",
        "extern int helper(int);\nint main(void) { return helper(0); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_AT_prototyped"),
        "expected DW_AT_prototyped on at least one subprogram:\n{out_text}",
    );
}

/// DW_AT_decl_line on variable + formal_parameter DIEs lets the
/// debugger show the declaration's source line in `info args`
/// / `info locals`. Symbol::decl_line is captured at parse time
/// and threads through VariableInfo + SubprogVar to both DWARF
/// emitters.
#[test]
fn multi_tu_link_emits_decl_line_on_locals() {
    let dir = tempdir("multi-tu-decl-line");
    write_source(
        &dir,
        "helper.c",
        "int helper(int x) {\n    int y = x + 1;\n    return y;\n}\n",
    );
    write_source(
        &dir,
        "main.c",
        "extern int helper(int);\nint main(void) { return helper(0); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_AT_decl_line"),
        "expected DW_AT_decl_line on at least one variable / formal_parameter DIE:\n{out_text}",
    );
}

/// Multi-TU subprogram DIEs need DW_AT_external (DWARF 4
/// section 3.3.1) so debuggers honour cross-CU name resolution
/// for user-defined functions. Without it (gdb) call helper()
/// from main's frame may fail to find the helper symbol when
/// the two functions live in different translation units.
#[test]
fn multi_tu_link_emits_external_flag_on_subprograms() {
    let dir = tempdir("multi-tu-external-flag");
    write_source(&dir, "helper.c", "int helper(int x) { return x + 1; }\n");
    write_source(
        &dir,
        "main.c",
        "extern int helper(int);\nint main(void) { return helper(0); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_AT_external"),
        "expected DW_AT_external on at least one subprogram:\n{out_text}",
    );
}

/// A variadic function's subprogram DIE needs a trailing
/// DW_TAG_unspecified_parameters child (DWARF 4 section 3.4.2)
/// so debuggers render the `...` of the prototype. Without it
/// gdb / lldb show the function as taking only the fixed params,
/// which silently breaks vararg-aware frame inspection.
#[test]
fn multi_tu_link_emits_unspecified_parameters_for_variadic() {
    let dir = tempdir("multi-tu-variadic-die");
    write_source(&dir, "helper.c", "int sum_n(int n, ...) { return n; }\n");
    write_source(
        &dir,
        "main.c",
        "extern int sum_n(int, ...);\n\
         int main(void) { return sum_n(0); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-info").arg(&out);
    let out_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-info")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    assert!(
        out_text.contains("DW_TAG_unspecified_parameters"),
        "expected DW_TAG_unspecified_parameters under the variadic subprogram:\n{out_text}",
    );
}

/// Multi-TU links populate `.debug_frame` from the merged
/// Text-section symbol set: `synth_build.rs` walks every defined
/// symbol and surfaces its `(ent_pc, name)` to `dwarf::emit`,
/// which builds one FDE per function on top of the linker-merged
/// `.debug_info` / `.debug_line` streams. Without this, the
/// merged image carried an empty `.debug_frame` and unwinders
/// fell back to frame-pointer chasing.
#[test]
fn multi_tu_link_populates_debug_frame() {
    let dir = tempdir("multi-tu-frame");
    write_source(&dir, "helper.c", "int helper(int x) { return x + 1; }\n");
    write_source(
        &dir,
        "main.c",
        "extern int helper(int);\nint main(void) { return helper(0); }\n",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let out = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&out)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    // `dwarfdump --debug-frame` (BSD) and `llvm-dwarfdump
    // --debug-frame` both decode CIE + FDE entries from ELF and
    // Mach-O alike; pick whichever is on PATH. An FDE per
    // user-defined function lands as `00000000 ffffffff CIE`
    // followed by lines naming `helper` / `main` in the FDE
    // header. Skip when neither tool is available so the suite
    // still runs on bare Linux images.
    let mut dd = Command::new("dwarfdump");
    dd.arg("--debug-frame").arg(&out);
    let frame_text = match dd.output() {
        Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
        _ => {
            let alt = Command::new("llvm-dwarfdump")
                .arg("--debug-frame")
                .arg(&out)
                .output();
            match alt {
                Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout).into_owned(),
                _ => return,
            }
        }
    };
    // Both dumpers print the section as the second line of output
    // when populated and emit no FDE bodies when empty. `FDE`
    // tokens count both `FDE cie=` (BSD) and `FDE cie=0x...` (LLVM).
    let fde_count = frame_text.matches("FDE").count();
    assert!(
        fde_count >= 2,
        "expected at least two FDEs (helper + main) in merged .debug_frame, \
         got {fde_count}:\n{frame_text}",
    );
    // Each FDE should advance past the prologue before installing
    // the post-prologue CFA rule. Without the synthetic
    // prologue-end symbols, `prologue_size_for` returns 0 on the
    // merged path and the FDE installs the rule at the function's
    // first byte (wrong for the prologue range).
    let advance_loc_count = frame_text.matches("DW_CFA_advance_loc").count();
    assert!(
        advance_loc_count >= 2,
        "expected at least two DW_CFA_advance_loc opcodes \
         (one per user function's prologue) in merged .debug_frame, \
         got {advance_loc_count}:\n{frame_text}",
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
        bytes.get(..16),
    );
    // ELF64 ET_REL (e_type = 1) at offset 0x10.
    let e_type = u16::from_le_bytes([bytes[16], bytes[17]]);
    assert_eq!(e_type, 1, "expected ET_REL (e_type=1), got {e_type}");
    // ELF class is 64-bit.
    assert_eq!(bytes[4], 2, "expected ELFCLASS64");
    // Little-endian.
    assert_eq!(bytes[5], 1, "expected ELFDATA2LSB");
}

/// DWARF is off by default and opt-in via `-g` / `--debug`, matching
/// gcc / clang. A default build links a DWARF-free executable -- the
/// shipped binary stays small -- while `-g` carries the `.debug_*`
/// sections through. The `debug_abbrev` substring matches both the
/// ELF `.debug_abbrev` and the Mach-O `__debug_abbrev` section names.
#[test]
fn debug_info_is_off_by_default_and_enabled_by_g() {
    let dir = tempdir("dwarf-default-off");
    let src = write_source(&dir, "f.c", "int main(void) { int x = 1; return x; }\n");

    let plain = dir.join("plain");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&plain)
            .arg(&src)
            .current_dir(&dir),
        "build without -g",
    );
    let plain_bytes = std::fs::read(&plain).expect("read plain");
    assert!(
        !plain_bytes.windows(12).any(|w| w == b"debug_abbrev"),
        "a default build must link a DWARF-free executable",
    );

    let dbg = dir.join("dbg");
    run(
        Command::new(badc())
            .arg("-g")
            .arg("-o")
            .arg(&dbg)
            .arg(&src)
            .current_dir(&dir),
        "build with -g",
    );
    let dbg_bytes = std::fs::read(&dbg).expect("read dbg");
    assert!(
        dbg_bytes.windows(12).any(|w| w == b"debug_abbrev"),
        "`-g` must carry DWARF (.debug_abbrev) into the executable",
    );
    assert!(
        dbg_bytes.len() > plain_bytes.len(),
        "the `-g` executable ({}) should be larger than the default ({})",
        dbg_bytes.len(),
        plain_bytes.len(),
    );
}

/// `-c` must plumb `-D`, `-I`, and `-include` to the
/// preprocessor. A prior CLI build seeded the per-TU compile
/// with `CompileOptions::default()`, dropping every flag --
/// the preprocessor then never expanded `#include` directives
/// nor saw the user's `-D` macros, and a typedef chain like a
/// `sizeof(uint16_t) == 2 ? 1 : -1` array probe folded against
/// an undefined typedef. C99 6.10.2 requires
/// the include search path to be the implementation-defined
/// set the driver was invoked with.
#[test]
fn compile_only_propagates_preprocessor_flags() {
    let dir = tempdir("co-pp-flags");
    std::fs::create_dir_all(dir.join("inc")).expect("mkdir inc");
    std::fs::write(dir.join("inc").join("k.h"), "#define K 7\n").expect("write header");
    std::fs::write(dir.join("inc").join("forced.h"), "typedef int forced_t;\n")
        .expect("write force-include");
    let src = write_source(
        &dir,
        "u.c",
        "#include \"k.h\"\nforced_t pick(void) { return K + GATE; }\n",
    );
    let out = dir.join("u.o");
    run(
        Command::new(badc())
            .arg("-c")
            .arg("-DGATE=1")
            .arg("-Iinc")
            .arg("-include")
            .arg("forced.h")
            .arg("-o")
            .arg(&out)
            .arg(&src)
            .current_dir(&dir),
        "compile-only with -D/-I/-include",
    );
    assert!(out.exists(), "expected {} to exist", out.display());
    let bytes = std::fs::read(&out).expect("read .o");
    assert!(
        bytes.len() > 64 && &bytes[0..4] == b"\x7fELF",
        "expected ELF magic; got {:?}",
        bytes.get(..16),
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
        bytes.get(..16)
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

// macOS arm64 -.o link path through the synthesizer. Compiles
// two sources with `-c`, links the two .o into a Mach-O
// executable, and execs to verify the runtime behaviour round-
// trip works. The synth path auto-codesigns via
// `post_write_native`, so no manual codesign step is needed.
#[cfg(all(target_os = "macos", target_arch = "aarch64"))]
#[test]
fn macos_native_link_two_sources_with_libc() {
    let dir = tempdir("macos-native-link");
    write_source(&dir, "helper.c", "int helper(int x) { return x * 6; }\n");
    write_source(
        &dir,
        "main.c",
        "#include <stdio.h>\n\
         extern int helper(int);\n\
         int main(void) {\n\
             int r = helper(7);\n\
             printf(\"answer=%d\\n\", r);\n\
             return r - 42;\n\
         }\n",
    );
    run(
        Command::new(badc())
            .arg("-c")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-c")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(out.status.code(), Some(0), "exit status mismatch");
    let stdout = String::from_utf8_lossy(&out.stdout);
    assert!(stdout.contains("answer=42"), "unexpected stdout: {stdout}");
}

/// A universal (fat) static library and a fat `.o` archive member both
/// resolve to their arm64 slice on the macos target. The fixtures come
/// from the platform toolchain (`cc -arch` + `lipo` + `ar`), which is
/// what produces such archives in the wild; hosts without it skip.
#[cfg(all(target_os = "macos", target_arch = "aarch64"))]
#[test]
fn macos_universal_archive_and_fat_member_link() {
    let dir = tempdir("macos-fat-archive");
    write_source(&dir, "forty.c", "int forty(void) { return 40; }\n");
    write_source(
        &dir,
        "main.c",
        "extern int forty(void);\nint main(void) { return forty() + 2; }\n",
    );
    for (arch, obj) in [("arm64", "forty_arm64.o"), ("x86_64", "forty_x86.o")] {
        let ok = Command::new("cc")
            .args(["-c", "-arch", arch, "forty.c", "-o", obj])
            .current_dir(&dir)
            .output()
            .is_ok_and(|o| o.status.success());
        if !ok {
            return; // no multi-arch platform toolchain on this host
        }
    }
    // A fat archive: one thin archive per arch, joined by lipo.
    for (ar_name, obj) in [
        ("thin_arm64.a", "forty_arm64.o"),
        ("thin_x86.a", "forty_x86.o"),
    ] {
        run(
            Command::new("ar")
                .args(["rc", ar_name, obj])
                .current_dir(&dir),
            "ar per-arch archive",
        );
    }
    let ok = Command::new("lipo")
        .args([
            "-create",
            "thin_arm64.a",
            "thin_x86.a",
            "-output",
            "libuniv.a",
        ])
        .current_dir(&dir)
        .output()
        .is_ok_and(|o| o.status.success());
    if !ok {
        return; // lipo refuses archives on some toolchain versions
    }
    // An archive whose member is itself a fat object.
    run(
        Command::new("lipo")
            .args([
                "-create",
                "forty_arm64.o",
                "forty_x86.o",
                "-output",
                "forty_fat.o",
            ])
            .current_dir(&dir),
        "lipo fat member",
    );
    run(
        Command::new("ar")
            .args(["rc", "libfatmem.a", "forty_fat.o"])
            .current_dir(&dir),
        "ar fat-member archive",
    );
    for lib in ["univ", "fatmem"] {
        let exe = dir.join(format!("prog_{lib}"));
        run(
            Command::new(badc())
                .arg("-o")
                .arg(&exe)
                .args(["-L.", &format!("-l{lib}")])
                .arg(dir.join("main.c"))
                .current_dir(&dir),
            "link against the fat archive",
        );
        let out = Command::new(&exe).output().expect("run prog");
        assert_eq!(out.status.code(), Some(42), "-l{lib} exit status");
    }
}

// Windows arm64 PE .o link path through the synthesizer. Compiles
// two sources with `-c --target=windows-aarch64`, links into a PE
// executable, and execs (natively on Windows arm64, via wine on
// linux-aarch64 when `BADC_RUN_WINE=1`).
#[cfg(any(
    all(target_os = "windows", target_arch = "aarch64"),
    all(target_os = "linux", target_arch = "aarch64"),
))]
#[test]
fn windows_aarch64_native_link_two_sources_with_libc() {
    if cfg!(target_os = "linux")
        && !matches!(std::env::var("BADC_RUN_WINE"), Ok(v) if !v.is_empty() && v != "0")
    {
        eprintln!("skipping: BADC_RUN_WINE not set");
        return;
    }
    let dir = tempdir("windows-arm64-native-link");
    write_source(&dir, "helper.c", "int helper(int x) { return x * 6; }\n");
    write_source(
        &dir,
        "main.c",
        "#include <stdio.h>\n\
         extern int helper(int);\n\
         int main(void) {\n\
             int r = helper(7);\n\
             printf(\"answer=%d\\n\", r);\n\
             return r - 42;\n\
         }\n",
    );
    run(
        Command::new(badc())
            .arg("-c")
            .arg("--target=windows-aarch64")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-c")
            .arg("--target=windows-aarch64")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let exe = dir.join("prog.exe");
    run(
        Command::new(badc())
            .arg("--target=windows-aarch64")
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let out = {
        #[cfg(target_os = "windows")]
        {
            Command::new(&exe).output().expect("run prog")
        }
        #[cfg(target_os = "linux")]
        {
            Command::new("/usr/bin/wine")
                .arg(&exe)
                .env("WINEDEBUG", "-all")
                .output()
                .expect("run prog under wine")
        }
    };
    assert_eq!(out.status.code(), Some(0), "exit status mismatch");
    let stdout = String::from_utf8_lossy(&out.stdout);
    assert!(stdout.contains("answer=42"), "unexpected stdout: {stdout}");
}

// Windows x64 PE .o link path through the synthesizer. Mirror of
// the arm64 variant. Runs natively on Windows x86_64; on
// linux-x86_64 with `BADC_RUN_WINE=1` set, drives through wine.
// macOS hosts can't exercise this lane locally -- wine64 under
// Rosetta throws "rosetta error: invalid gdt selector index 5"
// before the user code starts; CI's windows-2022 (x86_64) runner
// is the canonical home for this test.
#[cfg(any(
    all(target_os = "windows", target_arch = "x86_64"),
    all(target_os = "linux", target_arch = "x86_64"),
))]
#[test]
fn windows_x64_native_link_two_sources_with_libc() {
    if cfg!(target_os = "linux")
        && !matches!(std::env::var("BADC_RUN_WINE"), Ok(v) if !v.is_empty() && v != "0")
    {
        eprintln!("skipping: BADC_RUN_WINE not set");
        return;
    }
    let dir = tempdir("windows-x64-native-link");
    write_source(&dir, "helper.c", "int helper(int x) { return x * 6; }\n");
    write_source(
        &dir,
        "main.c",
        "#include <stdio.h>\n\
         extern int helper(int);\n\
         int main(void) {\n\
             int r = helper(7);\n\
             printf(\"answer=%d\\n\", r);\n\
             return r - 42;\n\
         }\n",
    );
    run(
        Command::new(badc())
            .arg("-c")
            .arg("--target=windows-x64")
            .arg(dir.join("helper.c"))
            .current_dir(&dir),
        "compile helper.c",
    );
    run(
        Command::new(badc())
            .arg("-c")
            .arg("--target=windows-x64")
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "compile main.c",
    );
    let exe = dir.join("prog.exe");
    run(
        Command::new(badc())
            .arg("--target=windows-x64")
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("main.o"))
            .arg(dir.join("helper.o"))
            .current_dir(&dir),
        "link main.o helper.o",
    );
    let out = {
        #[cfg(target_os = "windows")]
        {
            Command::new(&exe).output().expect("run prog")
        }
        #[cfg(target_os = "linux")]
        {
            Command::new("/usr/bin/wine")
                .arg(&exe)
                .env("WINEDEBUG", "-all")
                .output()
                .expect("run prog under wine")
        }
    };
    assert_eq!(out.status.code(), Some(0), "exit status mismatch");
    let stdout = String::from_utf8_lossy(&out.stdout);
    assert!(stdout.contains("answer=42"), "unexpected stdout: {stdout}");
}

/// Returns the lowercased DLL names in a PE32+ image's import
/// directory (empty when the image imports nothing).
fn pe_import_dll_names(pe: &[u8]) -> Vec<String> {
    let pe_off = u32::from_le_bytes(pe[0x3c..0x40].try_into().unwrap()) as usize;
    let opt = pe_off + 24;
    let n_sec = u16::from_le_bytes(pe[pe_off + 6..pe_off + 8].try_into().unwrap()) as usize;
    let so_hdr = u16::from_le_bytes(pe[pe_off + 20..pe_off + 22].try_into().unwrap()) as usize;
    let sec = pe_off + 24 + so_hdr;
    let imp = opt + 112 + 8; // data directory entry 1 (Import)
    let imp_rva = u32::from_le_bytes(pe[imp..imp + 4].try_into().unwrap());
    if imp_rva == 0 {
        return Vec::new();
    }
    let rva2off = |rva: u32| -> Option<usize> {
        for i in 0..n_sec {
            let s = sec + i * 40;
            let va = u32::from_le_bytes(pe[s + 12..s + 16].try_into().unwrap());
            let vs = u32::from_le_bytes(pe[s + 8..s + 12].try_into().unwrap());
            let raw = u32::from_le_bytes(pe[s + 20..s + 24].try_into().unwrap());
            let rs = u32::from_le_bytes(pe[s + 16..s + 20].try_into().unwrap());
            let span = vs.max(rs);
            if rva >= va && rva < va + span {
                return Some((raw + (rva - va)) as usize);
            }
        }
        None
    };
    let mut off = rva2off(imp_rva).expect("import dir rva");
    let mut names = Vec::new();
    loop {
        let name_rva = u32::from_le_bytes(pe[off + 12..off + 16].try_into().unwrap());
        let chain = u32::from_le_bytes(pe[off..off + 4].try_into().unwrap());
        if name_rva == 0 && chain == 0 {
            break;
        }
        let no = rva2off(name_rva).expect("import name rva");
        let end = pe[no..].iter().position(|&b| b == 0).unwrap() + no;
        names.push(String::from_utf8_lossy(&pe[no..end]).to_lowercase());
        off += 20;
        if names.len() > 32 {
            break;
        }
    }
    names
}

// Build-only (cross-compiles a Windows PE from any host). A
// NATIVE-subsystem driver runs no `_start` CRT stub, so the
// libc-`exit` runtime wrapper is not linked and the image
// imports nothing from msvcrt -- a user-mode `exit` is
// unsatisfiable in kernel mode. A console executable still
// imports it (the stub flushes stdio through libc `exit`).
#[test]
fn native_driver_omits_msvcrt_console_exe_keeps_it() {
    let dir = tempdir("driver-no-msvcrt");
    let mut driver_src = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    driver_src.push("demos");
    driver_src.push("wdm_driver");
    driver_src.push("wdm_driver.c");
    let console = write_source(&dir, "console.c", "int main(void) { return 0; }\n");
    for target in ["windows-x64", "windows-arm64"] {
        let sys = dir.join(format!("wdm-{target}.sys"));
        run(
            Command::new(badc())
                .arg(format!("--target={target}"))
                .arg("-O")
                .arg(&driver_src)
                .arg("-o")
                .arg(&sys)
                .current_dir(&dir),
            "build driver",
        );
        let names = pe_import_dll_names(&std::fs::read(&sys).expect("read .sys"));
        assert!(
            !names.iter().any(|n| n == "msvcrt.dll"),
            "{target}: native driver must not import msvcrt.dll; imports: {names:?}"
        );

        let exe = dir.join(format!("console-{target}.exe"));
        run(
            Command::new(badc())
                .arg(format!("--target={target}"))
                .arg(&console)
                .arg("-o")
                .arg(&exe)
                .current_dir(&dir),
            "build console exe",
        );
        let names = pe_import_dll_names(&std::fs::read(&exe).expect("read .exe"));
        assert!(
            names.iter().any(|n| n == "msvcrt.dll"),
            "{target}: console exe must import msvcrt.dll (libc exit for stdio flush); imports: {names:?}"
        );
    }
}

// `--freestanding` produces an image without the embedded startup
// runtime: the program's own `__c5_entry` is the image entry and none
// of the runtime's startup symbols (`__c5_exit` / `environ`) are
// linked. Cross-compiles to linux-x64 so the test runs on any host
// (it inspects the bytes, it does not exec).
#[test]
fn freestanding_flag_drops_startup_runtime() {
    let dir = tempdir("freestanding-drops-runtime");
    let src = write_source(&dir, "free.c", "int __c5_entry(void) { return 7; }\n");
    let out = dir.join("free");
    run(
        Command::new(badc())
            .arg("--freestanding")
            .arg("--target=linux-x64")
            .arg(&src)
            .arg("-o")
            .arg(&out)
            .current_dir(&dir),
        "freestanding build",
    );
    let bytes = std::fs::read(&out).expect("read freestanding image");
    for sym in ["__c5_exit", "environ", "__c5_getmainargs"] {
        assert!(
            !bytes.windows(sym.len()).any(|w| w == sym.as_bytes()),
            "freestanding image must not link the startup runtime symbol `{sym}`"
        );
    }
    // The ELF entry (e_entry at offset 24) must be non-zero: the writer
    // resolved it to the program's `__c5_entry`, not left it unset.
    let e_entry = u64::from_le_bytes(bytes[24..32].try_into().unwrap());
    assert!(e_entry != 0, "freestanding image entry must be set");
}

// `--freestanding` without a program-defined entry is reported up front
// rather than as a bare undefined-symbol relocation.
#[test]
fn freestanding_without_entry_is_an_error() {
    let dir = tempdir("freestanding-no-entry");
    let src = write_source(&dir, "noentry.c", "int helper(void) { return 1; }\n");
    let out = dir.join("x");
    let result = Command::new(badc())
        .arg("--freestanding")
        .arg("--target=linux-x64")
        .arg(&src)
        .arg("-o")
        .arg(&out)
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        !result.status.success(),
        "--freestanding without __c5_entry must fail"
    );
    let stderr = String::from_utf8_lossy(&result.stderr);
    assert!(
        stderr.contains("__c5_entry") && stderr.contains("freestanding"),
        "diagnostic must name the missing entry; got: {stderr:?}"
    );
}

// A program that defines `__c5_entry` WITHOUT `--freestanding` keeps
// the startup runtime, so its definition collides with the runtime's
// `__c5_entry`. This must be a duplicate-symbol error, not a silent
// switch to a freestanding image: defining a function with that name
// by accident should not change the output kind.
#[test]
fn defining_c5_entry_without_flag_is_not_implicitly_freestanding() {
    let dir = tempdir("c5entry-no-flag");
    let src = write_source(&dir, "free.c", "int __c5_entry(void) { return 7; }\n");
    let out = dir.join("x");
    let result = Command::new(badc())
        .arg("--target=linux-x64")
        .arg(&src)
        .arg("-o")
        .arg(&out)
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        !result.status.success(),
        "defining __c5_entry without --freestanding must not silently build freestanding"
    );
    let stderr = String::from_utf8_lossy(&result.stderr);
    assert!(
        stderr.contains("multiple definition") && stderr.contains("__c5_entry"),
        "expected a duplicate-symbol error for __c5_entry; got: {stderr:?}"
    );
}

#[test]
fn link_defined_symbol_wins_over_auto_included_binding() {
    // C89 6.3.2.2 link semantics: an undeclared call binds to
    // whatever the link defines. When a sibling TU defines a name
    // that also exists as a bundled-header libc binding (getpid),
    // the auto-include retry must not override the user's
    // definition with the library import.
    let dir = tempdir("auto-include-preference");
    write_source(
        &dir,
        "caller.c",
        "int main(void) { return getpid() == 999 ? 0 : 1; }\n",
    );
    write_source(&dir, "impl.c", "int getpid(void) { return 999; }\n");
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("caller.c"))
            .arg(dir.join("impl.c"))
            .current_dir(&dir),
        "link with a user getpid",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(0),
        "the user's getpid must win: stderr={:?}",
        String::from_utf8_lossy(&out.stderr)
    );
    // The auto-include still serves calls nothing in the link
    // defines: an undeclared printf in a multi-TU build works.
    write_source(
        &dir,
        "p1.c",
        "int main(void) { printf(\"hi\\n\"); return 0; }\n",
    );
    write_source(&dir, "p2.c", "int unrelated(void) { return 0; }\n");
    let exe2 = dir.join("prog2");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe2)
            .arg(dir.join("p1.c"))
            .arg(dir.join("p2.c"))
            .current_dir(&dir),
        "link with auto-included printf",
    );
    let out = Command::new(&exe2).output().expect("run prog2");
    assert_eq!(out.status.code(), Some(0), "auto-included printf runs");
    // The Windows CRT translates `\n` to `\r\n` on stdout; strip CR so
    // the comparison holds on every host.
    assert_eq!(
        String::from_utf8_lossy(&out.stdout).replace('\r', ""),
        "hi\n"
    );
}

// A program calling the GCC aarch64 outline-atomics helpers, one per op
// family plus a 1-byte and a matching/non-matching compare-exchange.
// Used only by the two tests below; gate the const to their combined cfg so
// targets that compile neither (e.g. windows-x64) do not see it as dead code.
#[cfg(any(target_os = "linux", target_arch = "aarch64"))]
const OUTLINE_ATOMICS_SRC: &str = "\
typedef unsigned char u8; typedef unsigned int u32; typedef unsigned long long u64;\n\
extern u64 __aarch64_ldadd8_acq_rel(u64, u64*);\n\
extern u64 __aarch64_swp8_acq_rel(u64, u64*);\n\
extern u32 __aarch64_ldclr4_acq_rel(u32, u32*);\n\
extern u32 __aarch64_ldset4_acq_rel(u32, u32*);\n\
extern u32 __aarch64_ldeor4_acq_rel(u32, u32*);\n\
extern u32 __aarch64_swp4_acq_rel(u32, u32*);\n\
extern u32 __aarch64_cas4_acq_rel(u32, u32, u32*);\n\
extern u8  __aarch64_cas1_acq_rel(u8, u8, u8*);\n\
int main(void){\n\
    u64 a=0x1000000064ULL; if(__aarch64_ldadd8_acq_rel(7,&a)!=0x1000000064ULL||a!=0x100000006bULL) return 1;\n\
    u32 c=0xF0; if(__aarch64_ldclr4_acq_rel(0x30,&c)!=0xF0||c!=0xC0) return 2;\n\
    u32 s=0x01; if(__aarch64_ldset4_acq_rel(0x30,&s)!=0x01||s!=0x31) return 3;\n\
    u32 e=0xFF; if(__aarch64_ldeor4_acq_rel(0x0F,&e)!=0xFF||e!=0xF0) return 4;\n\
    u32 w=5;    if(__aarch64_swp4_acq_rel(9,&w)!=5||w!=9) return 5;\n\
    u32 k=5;    if(__aarch64_cas4_acq_rel(5,42,&k)!=5||k!=42) return 6;\n\
    u32 j=5;    if(__aarch64_cas4_acq_rel(9,42,&j)!=5||j!=5) return 7;\n\
    u8 b=3;     if(__aarch64_cas1_acq_rel(3,7,&b)!=3||b!=7) return 8;\n\
    u64 x=0x2000000000ULL;\n\
    if(__aarch64_swp8_acq_rel(0x3000000000ULL,&x)!=0x2000000000ULL||x!=0x3000000000ULL) return 9;\n\
    return 0;\n\
}\n";

// The aarch64 outline-atomics helpers are supplied on demand by the embedded
// compiler-rt object, so a program that calls them cross-links for
// linux-aarch64 with no external libgcc. badc reports an undefined reference
// otherwise, so a clean link is proof the helpers resolved.
#[cfg(target_os = "linux")]
#[test]
fn outline_atomics_resolve_on_demand() {
    let dir = tempdir("outline-atomics-link");
    let src = write_source(&dir, "m.c", OUTLINE_ATOMICS_SRC);
    let exe = dir.join("m");
    run(
        Command::new(badc())
            .arg("--target=linux-aarch64")
            .arg("-o")
            .arg(&exe)
            .arg(&src)
            .current_dir(&dir),
        "cross-link outline-atomics for linux-aarch64",
    );
    assert!(exe.exists(), "linked executable should exist");

    // A program that references none of the helpers must not pull the
    // compiler-rt object: its symbols stay out of the image.
    let plain = write_source(&dir, "p.c", "int main(void){return 0;}\n");
    let pexe = dir.join("p");
    run(
        Command::new(badc())
            .arg("--target=linux-aarch64")
            .arg("-o")
            .arg(&pexe)
            .arg(&plain)
            .current_dir(&dir),
        "cross-link plain program",
    );
    let bytes = std::fs::read(&pexe).expect("read plain exe");
    let needle = b"__aarch64_ldadd8_acq_rel";
    assert!(
        !bytes.windows(needle.len()).any(|w| w == needle),
        "plain program must not pull compiler-rt symbols"
    );
}

// On an aarch64 host the produced binary runs directly, checking the atomic
// semantics of every op family the helpers cover. The 8-byte cases carry a
// value in the upper half, so a helper built over a 4-byte operand fails.
#[cfg(target_arch = "aarch64")]
#[test]
fn outline_atomics_run_correct() {
    let dir = tempdir("outline-atomics-run");
    let src = write_source(&dir, "m.c", OUTLINE_ATOMICS_SRC);
    let exe = dir.join("m");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(&src)
            .current_dir(&dir),
        "link outline-atomics for host",
    );
    let out = Command::new(&exe).output().expect("run outline-atomics");
    assert_eq!(
        out.status.code(),
        Some(0),
        "outline-atomics semantics: stderr={:?}",
        String::from_utf8_lossy(&out.stderr)
    );
}

// A program using the glibc entry points that live only in the static
// libc_nonshared.a: atexit, at_quick_exit, pthread_atfork. The atexit handler
// prints a marker so a run confirms it was registered and invoked.
const GLIBC_NONSHARED_SRC: &str = "\
#include <stdio.h>\n\
extern int atexit(void (*)(void));\n\
extern int at_quick_exit(void (*)(void));\n\
extern int pthread_atfork(void (*)(void), void (*)(void), void (*)(void));\n\
static void bye(void) { puts(\"ATEXIT_RAN\"); }\n\
static void nop(void) {}\n\
int main(void) {\n\
    pthread_atfork(nop, nop, nop);\n\
    at_quick_exit(nop);\n\
    atexit(bye);\n\
    puts(\"MAIN\");\n\
    return 0;\n\
}\n";

// badc supplies these from compiler-rt (wrapping the shared-library entry
// points), so a glibc program links against libc.so alone -- no host
// libc_nonshared.a. Cross-linking both arches exercises the resolution
// without needing to run, on any host: the wrappers come from the
// embedded sources and the `<stdio.h>` call from the header's binding,
// so no library of the host's takes part.
#[test]
fn glibc_nonshared_wrappers_resolve() {
    for (tag, target) in [
        ("x64", "--target=linux-x64"),
        ("arm", "--target=linux-aarch64"),
    ] {
        let dir = tempdir(&format!("glibc-nonshared-{tag}"));
        let src = write_source(&dir, "m.c", GLIBC_NONSHARED_SRC);
        let exe = dir.join("m");
        run(
            Command::new(badc())
                .arg(target)
                .arg("-o")
                .arg(&exe)
                .arg(&src)
                .current_dir(&dir),
            "cross-link glibc-nonshared wrappers",
        );
        assert!(exe.exists(), "{tag}: linked executable should exist");
    }
}

// On a Linux host the produced binary runs: the atexit handler must fire.
#[cfg(target_os = "linux")]
#[test]
fn glibc_nonshared_atexit_runs() {
    let dir = tempdir("glibc-nonshared-run");
    let src = write_source(&dir, "m.c", GLIBC_NONSHARED_SRC);
    let exe = dir.join("m");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(&src)
            .current_dir(&dir),
        "link glibc-nonshared wrappers for host",
    );
    let out = Command::new(&exe).output().expect("run glibc-nonshared");
    let stdout = String::from_utf8_lossy(&out.stdout);
    assert_eq!(out.status.code(), Some(0), "program exits cleanly");
    assert!(
        stdout.contains("MAIN") && stdout.contains("ATEXIT_RAN"),
        "atexit handler must run: stdout={stdout:?}"
    );
}

// `--dump-ssa` reports the compilation of the inputs and the runtime.
// The on-demand pool is compiled only when symbol selection stalls,
// which turns on the libraries the host has installed and on how much
// of the target's C library the link reads, so its members must not
// reach the dump: the same source would otherwise dump a different set
// of functions on each host. This source references the entry points
// the pool defines, so the pool is offered on any host and target.
#[test]
fn dump_ssa_names_the_same_functions_on_every_target() {
    let dir = tempdir("dump-ssa-pool");
    let src = write_source(&dir, "m.c", GLIBC_NONSHARED_SRC);
    let mut first: Option<Vec<String>> = None;
    for (tag, target) in [
        ("x64", "--target=linux-x64"),
        ("arm", "--target=linux-aarch64"),
    ] {
        let out = run(
            Command::new(badc())
                .arg(target)
                .arg("--dump-ssa")
                .arg("-o")
                .arg(dir.join(format!("m-{tag}")))
                .arg(&src)
                .current_dir(&dir),
            "dump SSA for a hosted link",
        );
        let names: Vec<String> = String::from_utf8_lossy(&out.stderr)
            .lines()
            .filter_map(|l| l.strip_prefix("; name=").map(str::to_string))
            .collect();
        assert!(
            names.iter().any(|n| n == "main"),
            "{tag}: the input's own functions are dumped: {names:?}"
        );
        for pool in [
            "atexit",
            "at_quick_exit",
            "pthread_atfork",
            "__stack_chk_fail_local",
        ] {
            assert!(
                !names.iter().any(|n| n == pool),
                "{tag}: on-demand pool member `{pool}` reached the dump: {names:?}"
            );
        }
        match &first {
            None => first = Some(names),
            Some(prev) => assert_eq!(
                prev, &names,
                "{tag}: the dump names the same functions for every target"
            ),
        }
    }
}

// C99 7.1.4p2: a program may declare a library function itself instead
// of including its header. The call then reaches the link as a plain
// external reference carrying no `#pragma binding`, and the C library
// the link resolves it against has to be the target's -- the same one
// on every host. The names below are bound by the bundled headers for
// each of these targets, so each link must produce an image; only one
// of the targets is ever the host's.
const HEADER_LESS_LIBC_SRC: &str = "\
extern void *memmem(const void *, unsigned long, const void *, unsigned long);\n\
extern char *strdup(const char *);\n\
int main(void) {\n\
    return memmem(\"abc\", 3, \"b\", 1) && strdup(\"abc\") ? 0 : 1;\n\
}\n";

#[test]
fn header_less_libc_names_resolve_for_every_target() {
    let dir = tempdir("header-less-libc");
    let src = write_source(&dir, "m.c", HEADER_LESS_LIBC_SRC);
    for target in ["linux-x64", "linux-aarch64", "macos-aarch64"] {
        let exe = dir.join(format!("m-{target}"));
        run(
            Command::new(badc())
                .arg(format!("--target={target}"))
                .arg("-o")
                .arg(&exe)
                .arg(&src)
                .current_dir(&dir),
            &format!("link header-less libc names for {target}"),
        );
        assert!(exe.exists(), "{target}: linked executable should exist");
    }
}

// A name the bundled `<stdio.h>` declares for the Linux targets alone
// resolves against their C library from any host: `cuserid` is a glibc
// export that libSystem and msvcrt do not have.
#[test]
fn cuserid_resolves_for_the_linux_targets() {
    let dir = tempdir("cuserid-linux");
    let src = write_source(
        &dir,
        "m.c",
        "#include <stdio.h>\n\
         int main(void) { char who[L_cuserid]; return cuserid(who) == 0; }\n",
    );
    for target in ["linux-x64", "linux-aarch64"] {
        let exe = dir.join(format!("m-{target}"));
        run(
            Command::new(badc())
                .arg(format!("--target={target}"))
                .arg("-o")
                .arg(&exe)
                .arg(&src)
                .current_dir(&dir),
            &format!("link cuserid for {target}"),
        );
        assert!(exe.exists(), "{target}: linked executable should exist");
    }
}

// The other half of the same rule: a name no C library exports stays a
// link error. Resolving an undefined reference against the target's C
// library must not become a blanket admission of every undefined name.
#[test]
fn an_undeclared_non_libc_name_is_a_link_error_for_every_target() {
    let dir = tempdir("header-less-unknown");
    let src = write_source(
        &dir,
        "m.c",
        "extern int badc_no_such_libc_entry_point(void);\n\
         int main(void) { return badc_no_such_libc_entry_point(); }\n",
    );
    for target in ["linux-x64", "linux-aarch64", "macos-aarch64"] {
        let out = Command::new(badc())
            .arg(format!("--target={target}"))
            .arg("-o")
            .arg(dir.join(format!("m-{target}")))
            .arg(&src)
            .current_dir(&dir)
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr).into_owned();
        assert!(
            !out.status.success() && err.contains("badc_no_such_libc_entry_point"),
            "{target}: an unknown name must not resolve: status={} stderr={err}",
            out.status
        );
    }
}

// A hosted link must read no C library the command line did not name.
// The driver used to open the host's own `libc.so.6` / `libSystem.tbd`
// off the search path, so the image turned on which shared object the
// machine running the link happened to have -- and on anything ahead of
// it on that path. Both invocations below must write the same bytes.
#[test]
fn a_c_library_on_the_search_path_does_not_change_the_image() {
    let dir = tempdir("implicit-libc-path");
    let src = write_source(&dir, "m.c", HEADER_LESS_LIBC_SRC);
    let decoy = dir.join("decoy");
    std::fs::create_dir_all(&decoy).expect("create decoy dir");
    // The names the implicit read probed, in both target formats.
    for name in ["libc.so.6", "libc.so", "libSystem.tbd", "libSystem.B.dylib"] {
        std::fs::write(decoy.join(name), b"").expect("write decoy library");
    }
    let search = format!("-L{}", decoy.display());
    // Named targets rather than the host's: the implicit C library is
    // described by the target, and PE has no entry, so a Windows host
    // would otherwise link a header-less name it cannot resolve.
    for target in ["linux-x64", "linux-aarch64", "macos-aarch64"] {
        let mut images: Vec<Vec<u8>> = Vec::new();
        for (tag, extra) in [("plain", None), ("decoy", Some(search.as_str()))] {
            let out_dir = dir.join(format!("{tag}-{target}"));
            std::fs::create_dir_all(&out_dir).expect("create output dir");
            let exe = out_dir.join("m");
            let mut cmd = Command::new(badc());
            cmd.arg(format!("--target={target}"))
                .args(extra)
                .arg("-o")
                .arg(&exe)
                .arg(&src);
            run(
                &mut cmd,
                &format!("{target}: link with the {tag} search path"),
            );
            images.push(std::fs::read(&exe).expect("read image"));
        }
        assert_eq!(
            images[0], images[1],
            "{target}: a C library on the search path must not change the image"
        );
    }
}

// A load through an extern data symbol must not fold against this unit's
// own const image. The address instruction badc emits for an extern
// object is an `ImmData` whose payload is a link-time placeholder, so a
// member read lands at the member's byte offset -- an offset that names
// an unrelated object here. `pad` is sized so the read at offset 64 falls
// inside it; folding returns pad's bytes and `g.tag` reads non-zero.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn extern_data_load_is_not_folded_against_local_const_image() {
    let dir = tempdir("extern-const-fold");
    write_source(
        &dir,
        "defs.c",
        "struct Big { unsigned char head[64]; long tag; };\n\
         struct Big g;\n",
    );
    write_source(
        &dir,
        "main.c",
        "static const unsigned char pad[4096] = { [0 ... 4095] = 0x41 };\n\
         struct Big { unsigned char head[64]; long tag; };\n\
         extern struct Big g;\n\
         int main(void) {\n\
         \tif (pad[0] != 0x41) return 2;\n\
         \treturn g.tag == 0 ? 0 : 1;\n\
         }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-O")
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("defs.c"))
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link extern-const-fold",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(0),
        "extern member read folded against local const data: stdout={:?} stderr={:?}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
}

/// Section headers of an ELF64 image as `(name, sh_type, sh_flags)`.
fn elf_sections(bytes: &[u8]) -> Vec<(String, u32, u64)> {
    let rd16 = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let rd32 = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let rd64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let e_shoff = rd64(0x28) as usize;
    let e_shentsize = rd16(0x3a);
    let e_shnum = rd16(0x3c);
    let e_shstrndx = rd16(0x3e);
    let str_off = rd64(e_shoff + e_shstrndx * e_shentsize + 0x18) as usize;
    (0..e_shnum)
        .map(|i| {
            let sh = e_shoff + i * e_shentsize;
            let n = str_off + rd32(sh) as usize;
            let end = bytes[n..].iter().position(|&b| b == 0).unwrap() + n;
            (
                String::from_utf8_lossy(&bytes[n..end]).into_owned(),
                rd32(sh + 4),
                rd64(sh + 8),
            )
        })
        .collect()
}

/// `SHT_SYMTAB` entries of an ELF64 image as
/// `(name, st_value, st_size, st_shndx)`.
fn elf_symbols(bytes: &[u8]) -> Vec<(String, u64, u64, u16)> {
    let rd16 = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]);
    let rd32 = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let rd64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let e_shoff = rd64(0x28) as usize;
    let e_shentsize = rd16(0x3a) as usize;
    let e_shnum = rd16(0x3c) as usize;
    let sh = |i: usize| e_shoff + i * e_shentsize;
    let symtab = (0..e_shnum)
        .find(|&i| rd32(sh(i) + 4) == 2)
        .expect("no .symtab");
    let str_off = rd64(sh(rd32(sh(symtab) + 40) as usize) + 24) as usize;
    let off = rd64(sh(symtab) + 24) as usize;
    let count = rd64(sh(symtab) + 32) as usize / 24;
    (0..count)
        .map(|i| {
            let e = off + i * 24;
            let n = str_off + rd32(e) as usize;
            let end = bytes[n..].iter().position(|&b| b == 0).unwrap() + n;
            (
                String::from_utf8_lossy(&bytes[n..end]).into_owned(),
                rd64(e + 8),
                rd64(e + 16),
                rd16(e + 6),
            )
        })
        .collect()
}

/// Program headers of an ELF64 image as `(p_type, p_flags)`.
fn elf_segments(bytes: &[u8]) -> Vec<(u32, u32)> {
    let rd16 = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let rd32 = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let rd64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let e_phoff = rd64(0x20) as usize;
    let e_phentsize = rd16(0x36);
    let e_phnum = rd16(0x38);
    (0..e_phnum)
        .map(|i| {
            let ph = e_phoff + i * e_phentsize;
            (rd32(ph), rd32(ph + 4))
        })
        .collect()
}

/// Program headers of an ELF64 image as
/// `(p_type, p_flags, p_offset, p_filesz)`.
fn elf_segment_ranges(bytes: &[u8]) -> Vec<(u32, u32, usize, usize)> {
    let rd16 = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let rd32 = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let rd64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let e_phoff = rd64(0x20) as usize;
    let (e_phentsize, e_phnum) = (rd16(0x36), rd16(0x38));
    (0..e_phnum)
        .map(|i| {
            let ph = e_phoff + i * e_phentsize;
            (
                rd32(ph),
                rd32(ph + 4),
                rd64(ph + 0x08) as usize,
                rd64(ph + 0x20) as usize,
            )
        })
        .collect()
}

/// A `-c` object is laid out for a link that applies its relocations
/// after mapping, because this toolchain's own linker is the usual
/// consumer and every image it writes is `ET_DYN`. Only the `const`
/// object carrying the relocation reaches the relro region; the unit's
/// relocation-free `const` objects keep the read-only prefix.
///
/// Without that, a section being the atom of placement costs the whole
/// `.rodata` the prefix, and the demoted storage is only re-protected
/// once the loader has applied the fixups. `-fno-pic` states the
/// opposite -- a link that resolves the relocation statically -- and is
/// checked here too, since the kernel corpus builds under it.
#[test]
fn compile_only_object_keeps_the_read_only_prefix_when_linked() {
    const PT_GNU_RELRO: u32 = 0x6474_E552;
    const PF_R: u32 = 4;
    let dir = tempdir("c-object-read-only-prefix");
    let src = write_source(
        &dir,
        "ro.c",
        "const char pure_tab[16] = \"PURETABPURETAB\";\n\
         static int probe(void) { return 1; }\n\
         struct ops { int (*p)(void); char tag[8]; };\n\
         const struct ops mixer = { probe, \"MIXTAG\" };\n\
         int main(void) { return mixer.p() + pure_tab[0] + mixer.tag[0]; }\n",
    );
    let holds = |img: &[u8], off: usize, len: usize, needle: &[u8]| {
        img[off..off + len]
            .windows(needle.len())
            .any(|w| w == needle)
    };
    for target in ["linux-x64", "linux-aarch64"] {
        // `-c` with no PIC flag, then linked: the shape every
        // make-driven build produces.
        let obj = dir.join(format!("ro-{target}.o"));
        let img = dir.join(format!("ro-{target}.bin"));
        run(
            Command::new(badc())
                .args(["-c", &format!("--target={target}")])
                .arg(&src)
                .arg("-o")
                .arg(&obj),
            "compile -c",
        );
        run(
            Command::new(badc())
                .arg(format!("--target={target}"))
                .arg(&obj)
                .arg("-o")
                .arg(&img),
            "link the object",
        );
        let bytes = std::fs::read(&img).expect("read image");
        let segs = elf_segment_ranges(&bytes);
        assert!(
            segs.iter()
                .any(|&(_, f, o, l)| f == PF_R && holds(&bytes, o, l, b"PURETAB")),
            "{target}: relocation-free const outside every read-only load"
        );
        let (_, _, roff, rlen) = *segs
            .iter()
            .find(|&&(t, ..)| t == PT_GNU_RELRO)
            .expect("PT_GNU_RELRO");
        assert!(
            holds(&bytes, roff, rlen, b"MIXTAG"),
            "{target}: relocated const outside PT_GNU_RELRO"
        );
        assert!(
            !holds(&bytes, roff, rlen, b"PURETAB"),
            "{target}: relocation-free const demoted into PT_GNU_RELRO"
        );

        // `-fno-pic` keeps gcc's static-link assignment: both objects
        // in `.rodata`, so the link has the whole section to demote.
        let nobj = dir.join(format!("ro-nopic-{target}.o"));
        run(
            Command::new(badc())
                .args(["-c", "-fno-pic", &format!("--target={target}")])
                .arg(&src)
                .arg("-o")
                .arg(&nobj),
            "compile -c -fno-pic",
        );
        let nbytes = std::fs::read(&nobj).expect("read object");
        let names: Vec<String> = elf_sections(&nbytes).into_iter().map(|(n, ..)| n).collect();
        assert!(
            !names.iter().any(|n| n == ".data.rel.ro"),
            "{target}: -fno-pic must keep relocated const in .rodata"
        );
    }

    // The kernel code model names a static link at fixed addresses, so
    // it keeps the same assignment with no flag of its own.
    let kobj = dir.join("ro-kernel.o");
    run(
        Command::new(badc())
            .args(["-c", "-mcmodel=kernel", "--target=linux-x64"])
            .arg(&src)
            .arg("-o")
            .arg(&kobj),
        "compile -c -mcmodel=kernel",
    );
    let kbytes = std::fs::read(&kobj).expect("read object");
    let knames: Vec<String> = elf_sections(&kbytes).into_iter().map(|(n, ..)| n).collect();
    assert!(
        !knames.iter().any(|n| n == ".data.rel.ro"),
        "the kernel code model must keep relocated const in .rodata"
    );
    assert!(
        knames.iter().any(|n| n == ".rodata"),
        "kernel object .rodata"
    );
}

const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;

/// A named section carries `SHF_WRITE` only when some member of it is
/// writable: an all-`const` section is read-only, matching gcc and
/// clang. The flags of members sharing a name union, so one writable
/// member makes the whole section writable.
#[test]
fn named_section_flags_follow_member_constness() {
    let dir = tempdir("named-section-const");
    let src = write_source(
        &dir,
        "s.c",
        "__attribute__((section(\".ro.tab\"))) const int ro_only[4] = {1,2,3,4};\n\
         __attribute__((section(\".rw.tab\"))) int rw_tab[4] = {1,2,3,4};\n\
         __attribute__((section(\".mixed\"))) const int mixed_c[2] = {1,2};\n\
         __attribute__((section(\".mixed\"))) int mixed_w[2] = {3,4};\n\
         int main(void) { return ro_only[0] + rw_tab[0] + mixed_c[0] + mixed_w[0]; }\n",
    );
    let out = dir.join("s.o");
    run(
        Command::new(badc())
            .args(["-c", "--target=linux-x64", "-o"])
            .arg(&out)
            .arg(&src)
            .current_dir(&dir),
        "compile named sections",
    );
    let bytes = std::fs::read(&out).expect("read .o");
    let flags = |name: &str| -> u64 {
        elf_sections(&bytes)
            .into_iter()
            .find(|(n, ..)| n == name)
            .unwrap_or_else(|| panic!("section {name} missing"))
            .2
    };
    assert_eq!(
        flags(".ro.tab"),
        SHF_ALLOC,
        "all-const section is read-only"
    );
    assert_eq!(flags(".rw.tab"), SHF_ALLOC | SHF_WRITE);
    assert_eq!(
        flags(".mixed"),
        SHF_ALLOC | SHF_WRITE,
        "one writable member makes the section writable",
    );
}

/// `const`-qualified file-scope storage with no relocated slot lands
/// in a read-only `.rodata`, not in writable `.data`.
#[test]
fn const_globals_land_in_read_only_rodata() {
    let dir = tempdir("rodata-carve");
    let src = write_source(
        &dir,
        "r.c",
        "const int ctab[4] = {1,2,3,4};\n\
         int wtab[4] = {5,6,7,8};\n\
         int main(void) { return ctab[0] + wtab[0]; }\n",
    );
    let out = dir.join("r.o");
    run(
        Command::new(badc())
            .args(["-c", "--target=linux-x64", "-o"])
            .arg(&out)
            .arg(&src)
            .current_dir(&dir),
        "compile const globals",
    );
    let bytes = std::fs::read(&out).expect("read .o");
    let secs = elf_sections(&bytes);
    let ro = secs
        .iter()
        .find(|(n, ..)| n == ".rodata")
        .expect(".rodata section missing");
    assert_eq!(ro.2, SHF_ALLOC, ".rodata must not be writable");
    let data = secs
        .iter()
        .find(|(n, ..)| n == ".data")
        .expect(".data section missing");
    assert_eq!(data.2, SHF_ALLOC | SHF_WRITE);
}

/// A zero-length array (`T x[] = {}` and `T x[0]`, the GNU extension
/// C99 6.7.5.2 leaves out) occupies no storage: it reports `st_size` 0
/// and shares the address of the object that follows it, as gcc does.
/// Sizing it from its element width instead gave it a range that ran
/// into that object, which the `.rodata` carve rejects as an overlap.
#[test]
fn zero_length_arrays_occupy_no_storage() {
    let dir = tempdir("zero-len-array");
    let src = write_source(
        &dir,
        "z.c",
        "const unsigned empty_pins[] = {};\n\
         const unsigned zerodim[0] = {};\n\
         const unsigned filled_pins[] = { 1, 2, 3, 4, 5, 6 };\n",
    );
    for target in ["linux-x64", "linux-aarch64"] {
        let out = dir.join(format!("z-{target}.o"));
        run(
            Command::new(badc())
                .args(["-c", &format!("--target={target}"), "-o"])
                .arg(&out)
                .arg(&src)
                .current_dir(&dir),
            "compile zero-length arrays",
        );
        let bytes = std::fs::read(&out).expect("read .o");
        let syms = elf_symbols(&bytes);
        let get = |n: &str| {
            syms.iter()
                .find(|(s, ..)| s == n)
                .unwrap_or_else(|| panic!("{n} missing from {target}"))
        };
        let filled = get("filled_pins");
        assert_eq!(filled.2, 24, "{target}: sized array keeps its size");
        for n in ["empty_pins", "zerodim"] {
            let z = get(n);
            assert_eq!(z.2, 0, "{target}: {n} occupies no storage");
            assert_eq!(
                (z.1, z.3),
                (filled.1, filled.3),
                "{target}: {n} shares the address of the object after it",
            );
        }
        let secs = elf_sections(&bytes);
        assert_eq!(
            secs[filled.3 as usize].0, ".rodata",
            "{target}: const arrays are carved into .rodata",
        );
    }
}

/// A block-scope `static T x[] = {};` is the same zero-length array as
/// the file-scope form and reserves storage the same way. Sizing it from
/// its element width instead left several of them sharing one start
/// offset while each claimed an element's span, which the `.rodata` carve
/// rejects as an overlap. Both element kinds go through the deferred-size
/// path: an aggregate element and a scalar one.
#[test]
fn zero_length_block_scope_statics_do_not_overlap() {
    let dir = tempdir("zero-len-block-static");
    let src = write_source(
        &dir,
        "z.c",
        "struct e { const char *a; const char *b; const char *c; };\n\
         extern void sink(const void *p, unsigned long n);\n\
         static void f(void) { static const struct e t[] = {}; sink(t, sizeof t); }\n\
         static void g(void) { static const struct e t[] = {}; sink(t, sizeof t); }\n\
         static void h(void) { static const int t[] = {}; sink(t, sizeof t); }\n\
         static void i(void) { static const int t[] = {}; sink(t, sizeof t); }\n\
         static const long pad[64] = { 1 };\n\
         int main(void) { f(); g(); h(); i(); sink(pad, sizeof pad); return 0; }\n",
    );
    for target in ["linux-x64", "linux-aarch64"] {
        let out = dir.join(format!("z-{target}.o"));
        run(
            Command::new(badc())
                .args(["-c", &format!("--target={target}"), "-o"])
                .arg(&out)
                .arg(&src)
                .current_dir(&dir),
            "compile zero-length block-scope statics",
        );
    }
}

/// The linked image keeps the read-only payload out of the writable
/// load: `.rodata` is `SHF_ALLOC` without `SHF_WRITE` and gets a
/// `PT_LOAD` whose `p_flags` is `PF_R` alone -- neither writable nor
/// executable.
#[test]
fn linked_image_maps_rodata_read_only() {
    let dir = tempdir("rodata-image");
    write_source(
        &dir,
        "a.c",
        "extern int helper(void);\n\
         const int tab[8] = {1,2,3,4,5,6,7,8};\n\
         int rw[4] = {9,9,9,9};\n\
         int main(void) { return tab[3] + rw[0] + helper(); }\n",
    );
    write_source(
        &dir,
        "b.c",
        "const char note[] = \"helper\";\n\
         int helper(void) { return (int)note[0]; }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .args(["--target=linux-x64", "-o"])
            .arg(&exe)
            .arg(dir.join("a.c"))
            .arg(dir.join("b.c"))
            .current_dir(&dir),
        "link rodata image",
    );
    let bytes = std::fs::read(&exe).expect("read image");
    let ro = elf_sections(&bytes)
        .into_iter()
        .find(|(n, ..)| n == ".rodata")
        .expect(".rodata section missing from linked image");
    assert_eq!(ro.2, SHF_ALLOC, ".rodata must not be writable");
    // PT_LOAD = 1, PF_X = 1, PF_W = 2, PF_R = 4.
    let loads: Vec<u32> = elf_segments(&bytes)
        .into_iter()
        .filter(|&(t, _)| t == 1)
        .map(|(_, f)| f)
        .collect();
    assert!(
        loads.contains(&4),
        "expected a read-only PT_LOAD; got p_flags {loads:?}",
    );
}

/// An assembler section flag letter the object writer cannot
/// reproduce is a diagnostic, not a silent drop that would emit a
/// section with the wrong permissions.
#[test]
fn unknown_asm_section_flag_is_diagnosed() {
    let dir = tempdir("asm-section-flag");
    let src = write_source(
        &dir,
        "t.c",
        "__asm__(\".pushsection .tls.tab,\\\"awT\\\",@progbits\\n\"\n\
         \"       .long 1\\n\"\n\
         \"       .popsection\\n\");\n\
         int main(void) { return 0; }\n",
    );
    let out = Command::new(badc())
        .args(["-c", "--target=linux-x64", "-o"])
        .arg(dir.join("t.o"))
        .arg(&src)
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(!out.status.success(), "expected the T flag to be rejected");
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(
        err.contains("TLS") && err.contains(".tls.tab"),
        "diagnostic should name the section and the flag: {err}",
    );
}

/// An absolute 32-bit reference resolves to a fixed address, which a
/// position-independent image cannot promise. The `-c` object carries
/// the relocation (its shape is locked in the linker tests); linking it
/// into an executable names the constraint rather than reporting a
/// missing patcher. GNU ld and clang reject the same object with
/// "relocation R_X86_64_32S ... can not be used when making a PIE
/// object".
#[test]
fn absolute_text_reloc_is_rejected_for_a_pie() {
    let dir = tempdir("abs-text-reloc-pie");
    let src = PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("tests")
        .join("fixtures")
        .join("c")
        .join("file_scope_asm_sym_mem.c");
    run(
        Command::new(badc())
            .args(["-c", "--target=linux-x64", "-o"])
            .arg(dir.join("t.o"))
            .arg(&src)
            .current_dir(&dir),
        "compile to an object",
    );
    let out = Command::new(badc())
        .args(["--target=linux-x64", "-o"])
        .arg(dir.join("prog"))
        .arg(&src)
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        !out.status.success(),
        "expected the PIE link to be rejected"
    );
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(
        err.contains("R_X86_64_32S")
            && err.contains("per_slot_base")
            && err.contains("position-independent"),
        "diagnostic should name the relocation, the symbol and the constraint: {err}",
    );
    // Same constraint, different output kind: GNU ld says "shared
    // object" here, and the reason it gives is the reference's, not a
    // missing patcher's.
    let out = Command::new(badc())
        .args(["--target=linux-x64", "--shared", "-o"])
        .arg(dir.join("libt.so"))
        .arg(&src)
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        !out.status.success(),
        "expected the shared-object link to be rejected"
    );
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(
        err.contains("R_X86_64_32S")
            && err.contains("shared object")
            && !err.contains("unsupported"),
        "diagnostic should name the relocation and the output kind: {err}",
    );
}

/// The same relocation where the output format admits it: PE rebases
/// every section through `.reloc`, so an assembler `movabsq $sym, %reg`
/// links. The field takes the symbol's preferred VA and the image
/// carries an `IMAGE_REL_BASED_DIR64` entry for it, which is what the
/// Windows loader applies after sliding the image.
#[test]
fn absolute_text_reloc_links_and_rebases_in_a_pe() {
    let dir = tempdir("abs-text-reloc-pe");
    let asm = write_source(
        &dir,
        "gd.s",
        "\t.text\n\
         \t.globl get_gdata\n\
         get_gdata:\n\
         \tmovabsq $gdata, %rax\n\
         \tmovl (%rax), %eax\n\
         \tret\n\
         \t.data\n\
         \t.globl gdata\n\
         gdata:\n\
         \t.long 42\n",
    );
    let main = write_source(
        &dir,
        "m.c",
        "int get_gdata(void);\nint main(void) { return get_gdata(); }\n",
    );
    for src in [&asm, &main] {
        run(
            Command::new(badc())
                .args(["-c", "--target=windows-x64", "-o"])
                .arg(dir.join(src.with_extension("o").file_name().unwrap()))
                .arg(src)
                .current_dir(&dir),
            "compile to an object",
        );
    }
    let exe = dir.join("prog.exe");
    run(
        Command::new(badc())
            .args(["--target=windows-x64", "-o"])
            .arg(&exe)
            .arg(dir.join("m.o"))
            .arg(dir.join("gd.o"))
            .current_dir(&dir),
        "link the PE",
    );
    let image = std::fs::read(&exe).expect("read the PE");
    let u16le = |o: usize| u16::from_le_bytes(image[o..o + 2].try_into().unwrap()) as usize;
    let u32le = |o: usize| u32::from_le_bytes(image[o..o + 4].try_into().unwrap());
    let pe = u32le(0x3c) as usize;
    let opt = pe + 24;
    let image_base = u64::from_le_bytes(image[opt + 24..opt + 32].try_into().unwrap());
    let sect = opt + u16le(pe + 20);
    // (name, rva, raw offset, raw size) per section header.
    let secs: Vec<(String, u32, usize, usize)> = (0..u16le(pe + 6))
        .map(|i| {
            let o = sect + i * 40;
            let end = image[o..o + 8].iter().position(|&b| b == 0).unwrap_or(8);
            let name = String::from_utf8_lossy(&image[o..o + end]).into_owned();
            (
                name,
                u32le(o + 12),
                u32le(o + 20) as usize,
                u32le(o + 16) as usize,
            )
        })
        .collect();
    let find = |n: &str| secs.iter().find(|s| s.0 == n).expect("section");
    let (_, text_rva, text_off, text_size) = *find(".text");
    let (_, data_rva, data_off, data_size) = *find(".data");
    // The `movabsq` immediate is the eight bytes after its two-byte
    // REX + opcode prefix; the object defines nothing else absolute.
    let body = &image[text_off..text_off + text_size];
    let site = body
        .windows(2)
        .position(|w| w == [0x48, 0xb8])
        .expect("movabsq in .text")
        + 2;
    let value = u64::from_le_bytes(body[site..site + 8].try_into().unwrap());
    // The field must name `gdata` itself: its preferred VA lands
    // inside `.data` and the word there is the initializer.
    let target = (value - image_base) as usize;
    assert!(
        target >= data_rva as usize && target + 4 <= data_rva as usize + data_size,
        "the field must hold a `.data` VA, got {value:#x}"
    );
    let at = data_off + target - data_rva as usize;
    assert_eq!(u32le(at), 42, "the field must reach `gdata`");
    let (_, reloc_rva, reloc_off, _) = *find(".reloc");
    let reloc_size = u32le(opt + 112 + 5 * 8 + 4) as usize;
    assert_ne!(
        reloc_size, 0,
        "the image must carry a base-relocation table"
    );
    assert_eq!(u32le(opt + 112 + 5 * 8), reloc_rva, "reloc directory rva");
    let want = text_rva + site as u32;
    let mut found = false;
    let mut off = 0usize;
    while off + 8 <= reloc_size {
        let page = u32le(reloc_off + off);
        let size = u32le(reloc_off + off + 4) as usize;
        assert!(size >= 8, "malformed .reloc block");
        for j in 0..(size - 8) / 2 {
            let e = u16le(reloc_off + off + 8 + j * 2) as u16;
            // Type 10 is IMAGE_REL_BASED_DIR64.
            found |= e >> 12 == 10 && page + (e & 0xfff) as u32 == want;
        }
        off += size;
    }
    assert!(found, "no DIR64 base relocation covering rva {want:#x}");
}

// Gated on Linux: the read-only data page only exists on the native ELF
// link path, and the test exec's the produced binary.
//
// A `&&label` dispatch table is filled by stores the declaration emits,
// so the storage is written during execution however it is qualified. Any
// `const` spelling that put it on a read-only page faults on the first
// store. Runs both optimization levels because placement is independent
// of the pipeline.
#[cfg(target_os = "linux")]
#[test]
fn const_label_address_table_storage_is_writable() {
    let dir = tempdir("const-label-table");
    let src = write_source(
        &dir,
        "t.c",
        "static int p(const unsigned char *c) {\n\
         static const void *const t[] = {&&A, &&B, &&H};\n\
         int a = 0, i = 0;\n\
         goto *t[c[i++]];\n\
         A: a += c[i++]; goto *t[c[i++]];\n\
         B: a += a; goto *t[c[i++]];\n\
         H: return a; }\n\
         static int q(const unsigned char *c) {\n\
         static void *const t[] = {&&A, &&B, &&H};\n\
         int a = 0, i = 0;\n\
         goto *t[c[i++]];\n\
         A: a += c[i++]; goto *t[c[i++]];\n\
         B: a += a; goto *t[c[i++]];\n\
         H: return a; }\n\
         static int r(const unsigned char *c) {\n\
         static const long t[] = {(long)&&A, (long)&&B, (long)&&H};\n\
         int a = 0, i = 0;\n\
         goto *(void *)t[c[i++]];\n\
         A: a += c[i++]; goto *(void *)t[c[i++]];\n\
         B: a += a; goto *(void *)t[c[i++]];\n\
         H: return a; }\n\
         int main(void) {\n\
         static const unsigned char g[] = {0, 5, 1, 2};\n\
         if (p(g) != 10) return 1;\n\
         if (p(g) != 10) return 2;\n\
         if (q(g) != 10) return 3;\n\
         if (r(g) != 10) return 4;\n\
         return 42; }\n",
    );
    for (opt, stem) in [(None, "prog"), (Some("-O"), "prog-opt")] {
        let exe = dir.join(stem);
        let mut cmd = Command::new(badc());
        cmd.arg("-o").arg(&exe);
        if let Some(o) = opt {
            cmd.arg(o);
        }
        run(cmd.arg(&src).current_dir(&dir), "build label table");
        let out = Command::new(&exe).output().expect("run prog");
        assert_eq!(
            out.status.code(),
            Some(42),
            "{stem}: label-address table storage must be writable (status {})",
            out.status
        );
    }
}

// A pc-relative record in a pushed data section whose addend puts the
// target below the symbol it is measured from (`(sym - 8)(%rip)`). The
// merged data-byte offset then falls outside the image, and `.rodata` /
// `.data` / `.bss` map to non-contiguous runtime regions, so the writer
// has to resolve the anchor and apply the difference to the address.
// The program reads back the committed disp32 fields.
#[cfg(all(target_os = "linux", target_arch = "x86_64"))]
#[test]
fn data_pcrel_target_below_its_anchor_symbol() {
    let dir = tempdir("data-pcrel-below-anchor");
    let src = write_source(
        &dir,
        "t.c",
        "long counter[2] = {42, 7};\n\
         extern const unsigned char tmpl;\n\
         __asm__(\".pushsection .rodata\\n\"\n\
         \t\".globl tmpl\\n\"\n\
         \t\"tmpl:\\n\"\n\
         \t\"leaq (counter - 8)(%rip), %rdx\\n\"\n\
         \t\"movq counter(%rip), %rax\\n\"\n\
         \t\".popsection\\n\");\n\
         static long disp32(const unsigned char *p) {\n\
         \tunsigned int v = (unsigned int)p[0] | ((unsigned int)p[1] << 8) |\n\
         \t\t((unsigned int)p[2] << 16) | ((unsigned int)p[3] << 24);\n\
         \treturn (long)(int)v; }\n\
         int main(void) {\n\
         \tconst unsigned char *t = &tmpl;\n\
         \tif ((const char *)(t + 7) + disp32(t + 3) != (const char *)counter - 8)\n\
         \t\treturn 1;\n\
         \tif ((const char *)(t + 14) + disp32(t + 10) != (const char *)counter)\n\
         \t\treturn 2;\n\
         \treturn 42; }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(&src)
            .current_dir(&dir),
        "build data-pcrel below-anchor program",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(42),
        "committed disp32 does not reach the relocation target (status {})",
        out.status
    );
}

// A `dlopen`'d module resolves the host executable's symbols through
// its dynamic symbol table. Gated on POSIX (dlopen) and on a system C
// driver to build the module: the point is the cross-toolchain
// boundary an extension module actually crosses.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn dlopened_module_binds_host_data_and_bss_globals() {
    let cc = ["cc", "gcc", "clang"].into_iter().find(|c| {
        Command::new(c)
            .arg("--version")
            .output()
            .map(|o| o.status.success())
            .unwrap_or(false)
    });
    let Some(cc) = cc else {
        eprintln!("skipping dlopened_module_binds_host_data_and_bss_globals: no system C driver");
        return;
    };
    let dir = tempdir("dlopen-host-globals");
    let host = write_source(
        &dir,
        "host.c",
        "#include <dlfcn.h>\n\
         #include <stdio.h>\n\
         int host_initialized = 7;\n\
         int host_zero;\n\
         char host_empty[] = \"\";\n\
         int host_fn(void) { return 11; }\n\
         int main(int argc, char **argv) {\n\
             void *h; int (*probe)(void);\n\
             host_zero = 3;\n\
             h = dlopen(argv[1], RTLD_NOW);\n\
             if (!h) { printf(\"dlopen: %s\\n\", dlerror()); return 1; }\n\
             probe = (int (*)(void))dlsym(h, \"probe\");\n\
             if (!probe) { printf(\"dlsym: %s\\n\", dlerror()); return 2; }\n\
             (void)argc; return probe(); }\n",
    );
    let module = write_source(
        &dir,
        "module.c",
        "extern int host_initialized;\n\
         extern int host_zero;\n\
         extern char host_empty[];\n\
         extern int host_fn(void);\n\
         int probe(void) {\n\
             return host_initialized + host_zero + host_empty[0] + host_fn(); }\n",
    );
    let exe = dir.join("host");
    run(
        Command::new(badc())
            // The data half of the export set is what a zero-init
            // global needs; the code half resolves `host_fn`.
            .arg("--export-all")
            .arg("--export-data")
            .arg("-o")
            .arg(&exe)
            .arg(&host)
            .current_dir(&dir),
        "link host executable",
    );
    let so = dir.join(if cfg!(target_os = "macos") {
        "module.dylib"
    } else {
        "module.so"
    });
    let mut build = Command::new(cc);
    build.arg("-shared").arg("-fPIC").arg("-o").arg(&so);
    if cfg!(target_os = "macos") {
        build.arg("-undefined").arg("dynamic_lookup");
    }
    run(build.arg(&module).current_dir(&dir), "build module");

    let out = Command::new(&exe)
        .arg(&so)
        .output()
        .expect("run host executable");
    assert_eq!(
        out.status.code(),
        Some(21),
        "the module must bind the host's .data, .bss and .text globals \
         (stdout {:?})",
        String::from_utf8_lossy(&out.stdout)
    );
}

// `-Map=FILE` / `-Map FILE` / `-M` produce a GNU-ld-style link map.
// Emitting a Linux ELF needs no matching host, so these run anywhere.
#[test]
fn map_file_reports_sections_and_archive_members() {
    let dir = tempdir("map-file");
    write_source(
        &dir,
        "main.c",
        "extern int helper(int);\nextern int archfn(int);\nint g_global = 42;\n\
         int main() { return helper(1) + archfn(2) + g_global; }\n",
    );
    write_source(
        &dir,
        "helper.c",
        "int h_data = 5;\nint helper(int x) { return x + h_data; }\n",
    );
    write_source(&dir, "archmem.c", "int archfn(int x) { return x * 2; }\n");
    run(
        Command::new(badc())
            .arg("--ar")
            .arg("--target=linux-x64")
            .arg("-o")
            .arg(dir.join("libarch.a"))
            .arg(dir.join("archmem.c"))
            .current_dir(&dir),
        "build archive",
    );
    let map_path = dir.join("prog.map");
    run(
        Command::new(badc())
            .arg("--target=linux-x64")
            .arg("-o")
            .arg(dir.join("prog"))
            .arg(dir.join("main.c"))
            .arg(dir.join("helper.c"))
            .arg(dir.join("libarch.a"))
            .arg(format!("-Map={}", map_path.display()))
            .arg("-q")
            .current_dir(&dir),
        "link with -Map=",
    );
    let map = std::fs::read_to_string(&map_path).expect("read map file");
    assert!(
        map.contains("Archive member included to satisfy reference by file (symbol)"),
        "archive table missing:\n{map}"
    );
    assert!(
        map.contains("libarch.a(archmem.c.o)") || map.contains("libarch.a(archmem.o)"),
        "archive member label missing:\n{map}"
    );
    assert!(map.contains("(archfn)"), "pulling symbol missing:\n{map}");
    assert!(map.contains("Memory Configuration"), "missing:\n{map}");
    assert!(
        map.contains("Linker script and memory map"),
        "missing:\n{map}"
    );
    for row in ["\n.text ", "\n.data "] {
        assert!(map.contains(row), "missing {row:?}:\n{map}");
    }
    for source in ["main.c", "helper.c"] {
        assert!(
            map.lines()
                .any(|l| l.starts_with(" .text") && l.ends_with(source)),
            "no .text contribution from {source}:\n{map}"
        );
    }
    assert!(
        map.contains("OUTPUT(prog elf64-x86-64)"),
        "OUTPUT line missing:\n{map}"
    );

    // The two-arg `-Map FILE` form and `--print-map` (stdout) coexist.
    // `-M` is gcc's dependency-output flag, not the map.
    let map2 = dir.join("prog2.map");
    let out = run(
        Command::new(badc())
            .arg("--target=linux-x64")
            .arg("-o")
            .arg(dir.join("prog2"))
            .arg(dir.join("main.c"))
            .arg(dir.join("helper.c"))
            .arg(dir.join("libarch.a"))
            .arg("-Map")
            .arg(&map2)
            .arg("--print-map")
            .arg("-q")
            .current_dir(&dir),
        "link with -Map FILE and --print-map",
    );
    assert!(map2.is_file(), "-Map FILE (two-arg) must write the file");
    let stdout = String::from_utf8_lossy(&out.stdout);
    assert!(
        stdout.contains("Linker script and memory map"),
        "--print-map must print the map to stdout: {stdout:?}"
    );
}

#[test]
fn aarch64_low12_references_sharing_one_adrp_are_all_patched() {
    // The AArch64 ELF ABI relocates the page and in-page halves of an
    // address reference separately, and gcc/clang emit one `adrp`
    // serving several in-page references at -O2. Assembling and linking
    // the sequence through the driver must patch every in-page site.
    //
    // The instruction forms are GNU ld 2.46.1's for the same two objects
    // from GNU as 2.46.1, whose `.o` bytes badc's assembler reproduces.
    // Each field is checked against `gdata`'s own in-page offset, so a
    // site left unpatched fails whatever the data layout is.
    let dir = tempdir("a64-shared-adrp");
    // The image writer prepends its own entry stub, so the sequence is
    // located by the unrelocated trailer parked behind it.
    const MARKER: u64 = 0x6c6f_3132_6d61_726b;
    let refs = write_source(
        &dir,
        "ref.s",
        "\t.text\n\t.globl _start\n_start:\n\
         \tadrp\tx1, gdata\n\
         \tldr\tx2, [x1, #:lo12:gdata]\n\
         \tldr\tq3, [x1, #:lo12:gdata]\n\
         \tadd\tx4, x1, #:lo12:gdata\n\
         \tret\n\
         \t.quad\t0x6c6f31326d61726b\n",
    );
    let def = write_source(
        &dir,
        "def.s",
        "\t.data\n\t.balign 16\n\t.globl gdata\ngdata:\n\t.quad 0x1122334455667788\n\t.quad 0\n",
    );
    for src in [&refs, &def] {
        run(
            Command::new(badc())
                .arg("--target=linux-aarch64")
                .arg("-c")
                .arg(src)
                .current_dir(&dir),
            "assemble",
        );
    }
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("--target=linux-aarch64")
            .arg("--freestanding")
            .arg("--entry=_start")
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("ref.o"))
            .arg(dir.join("def.o"))
            .arg("-q")
            .current_dir(&dir),
        "link the shared-adrp objects",
    );
    let image = std::fs::read(&exe).expect("read the linked image");
    let words = words_before_marker(&image, MARKER, 5);
    // `add` carries the in-page offset unscaled, so it names what the two
    // loads must reach through their own scales. A site the linker leaves
    // unpatched keeps the assembler's zero field, so the assertion is that
    // all three agree on one non-zero offset.
    let off = words[3] >> 10 & 0xfff;
    assert_eq!(
        words[3] & !(0xfff << 10),
        0x9100_0024,
        "add x4, x1, #:lo12:gdata"
    );
    assert!(
        off != 0 && off.is_multiple_of(16),
        "`gdata` is `.balign 16` behind other data, so its in-page offset \
         is a non-zero multiple of 16; got {off:#x}"
    );
    assert_eq!(
        words[1],
        0xf940_0022 | (off / 8) << 10,
        "ldr x2, [x1, #{off}]"
    );
    assert_eq!(
        words[2],
        0x3dc0_0023 | (off / 16) << 10,
        "ldr q3, [x1, #{off}]"
    );
    assert_eq!(words[4], 0xd65f_03c0, "ret");
}

/// The `count` 4-byte words immediately preceding the sole occurrence
/// of `marker` in `image`.
fn words_before_marker(image: &[u8], marker: u64, count: usize) -> Vec<u32> {
    let pattern = marker.to_le_bytes();
    let hits: Vec<usize> = image
        .windows(8)
        .enumerate()
        .filter(|(_, w)| *w == pattern)
        .map(|(i, _)| i)
        .collect();
    assert_eq!(hits.len(), 1, "marker must occur once: {hits:?}");
    let start = hits[0] - count * 4;
    (0..count)
        .map(|i| u32::from_le_bytes(image[start + i * 4..start + i * 4 + 4].try_into().unwrap()))
        .collect()
}

#[test]
fn map_option_requires_a_link() {
    let dir = tempdir("map-requires-link");
    let src = write_source(&dir, "one.c", "int main() { return 0; }\n");
    let out = Command::new(badc())
        .arg("-c")
        .arg(&src)
        .arg("-Map=one.map")
        .current_dir(&dir)
        .output()
        .expect("run badc -c -Map");
    assert!(!out.status.success(), "-c with -Map must be rejected");
    let stderr = String::from_utf8_lossy(&out.stderr);
    assert!(
        stderr.contains("require a link"),
        "diagnostic must say the map needs a link: {stderr:?}"
    );
}

/// The archive reader's member names must agree with the platform
/// `ar`'s own view of the same file. Which variant that exercises
/// follows the host: `/usr/bin/ar` on macOS writes the BSD `#1/<len>`
/// inline-name form and a `__.SYMDEF` index, GNU `ar` on Linux writes
/// the `//` long-name table and a `/` index. The names straddle the
/// 16-byte header field so both the short and the spilled encoding
/// appear.
#[test]
fn platform_ar_member_names_match_ar_t() {
    let dir = tempdir("platform-ar");
    let names = [
        "a_very_long_member_name_over_sixteen.o",
        "short.o",
        "exactly_sixteen.o",
    ];
    // The members are built by the host C compiler, not by badc: macOS
    // `ar` drops a member whose container is not Mach-O, so only a
    // host-native object exercises the archiver at all. Only the names
    // and the verbatim bodies matter here.
    let mut objects: Vec<PathBuf> = Vec::new();
    for (i, name) in names.iter().enumerate() {
        let src = write_source(
            &dir,
            &format!("m{i}.c"),
            &format!("int m{i}(void) {{ return {i}; }}\n"),
        );
        let obj = dir.join(name);
        let built = Command::new("cc")
            .arg("-c")
            .arg(&src)
            .arg("-o")
            .arg(&obj)
            .current_dir(&dir)
            .output();
        match built {
            Ok(o) if o.status.success() => {}
            // No host C compiler; the byte-level encodings of both ar
            // variants are covered by the archive reader's own tests.
            _ => return,
        }
        objects.push(obj);
    }
    let lib = dir.join("libmix.a");
    let made = Command::new("ar")
        .arg("rcs")
        .arg(&lib)
        .args(&objects)
        .current_dir(&dir)
        .output();
    match made {
        Ok(o) if o.status.success() => {}
        _ => return, // no platform `ar` on this host
    }
    let listing = Command::new("ar")
        .arg("t")
        .arg(&lib)
        .current_dir(&dir)
        .output()
        .expect("run ar t");
    let expected: Vec<String> = String::from_utf8_lossy(&listing.stdout)
        .lines()
        .map(|l| l.trim().to_string())
        .filter(|l| !l.is_empty() && !l.starts_with("__.SYMDEF"))
        .collect();
    assert_eq!(expected.len(), names.len(), "ar t must list every member");

    let blob = std::fs::read(&lib).expect("read the archive");
    let members = badc::read_archive(&blob).expect("read the archive members");
    let got: Vec<String> = members.iter().map(|m| m.name.clone()).collect();
    assert_eq!(got, expected, "badc's member names must match `ar t`");
    for m in &members {
        let on_disk = std::fs::read(dir.join(&m.name)).expect("read the member's source object");
        assert_eq!(
            m.bytes, on_disk,
            "member `{}` body must be verbatim",
            m.name
        );
    }
}

/// A member whose container is not ELF is named by its resolved member
/// name and by its own format. badc's relocatable format is ELF on
/// every target, so a Mach-O member cannot be linked even where the
/// target's images are Mach-O; the diagnostic says that rather than
/// reporting the raw header field.
#[test]
fn foreign_format_archive_member_is_diagnosed_by_name_and_format() {
    let dir = tempdir("foreign-member");
    let src = write_source(&dir, "main.c", "int main(void) { return 0; }\n");
    // MH_CIGAM_64 leads a 64-bit Mach-O object; the rest is padding,
    // since the input is rejected on the container alone.
    let mut macho = vec![0xCFu8, 0xFA, 0xED, 0xFE];
    macho.extend_from_slice(&[0u8; 28]);
    let lib = dir.join("libforeign.a");
    let blob = badc::write_archive(
        &[badc::ArchiveMember {
            name: "a_very_long_member_name_over_sixteen.o".into(),
            bytes: macho,
        }],
        &[(0, vec!["_unused".into()])],
    );
    std::fs::write(&lib, &blob).expect("write the archive");

    for target in ["macos-aarch64", "linux-x64"] {
        let out = Command::new(badc())
            .arg(format!("--target={target}"))
            .args(["-o", "prog"])
            .arg(&lib)
            .arg(&src)
            .current_dir(&dir)
            .output()
            .expect("run badc");
        assert!(!out.status.success(), "a Mach-O member must be rejected");
        let err = String::from_utf8_lossy(&out.stderr);
        assert!(
            err.contains("a_very_long_member_name_over_sixteen.o") && err.contains("Mach-O"),
            "diagnostic must name the member and its format on {target}: {err}",
        );
        assert!(
            !err.contains("#1/"),
            "diagnostic must not surface a raw header field on {target}: {err}",
        );
    }
}

/// `-l<name>` looks for the shared spelling the target's container
/// format uses, and says so when nothing is found: `.so` for ELF,
/// `.dylib` for Mach-O, `.dll` for PE.
#[test]
fn library_search_spelling_follows_the_target_format() {
    let dir = tempdir("lib-spelling");
    let src = write_source(&dir, "main.c", "int main(void) { return 0; }\n");
    for (target, shared) in [
        ("linux-x64", "libnosuchlib.so"),
        ("macos-aarch64", "libnosuchlib.dylib"),
        ("windows-x64", "libnosuchlib.dll"),
    ] {
        let out = Command::new(badc())
            .arg(format!("--target={target}"))
            .args(["-o", "prog", "-lnosuchlib"])
            .arg(&src)
            .current_dir(&dir)
            .output()
            .expect("run badc");
        assert!(!out.status.success(), "the library does not exist");
        let err = String::from_utf8_lossy(&out.stderr);
        assert!(
            err.contains(shared) && err.contains("libnosuchlib.a"),
            "search must name the {target} spellings: {err}",
        );
    }
}

/// `-l` against a Mach-O dylib: the export trie resolves the
/// undefined reference, the dylib's install name becomes a load
/// command, and the binary runs. The dylib comes from the platform
/// toolchain; hosts without one skip.
#[cfg(all(target_os = "macos", target_arch = "aarch64"))]
#[test]
fn macos_dylib_resolves_an_undefined_reference() {
    let dir = tempdir("macos-dylib-link");
    write_source(&dir, "demo.c", "int forty_one(void) { return 41; }\n");
    write_source(
        &dir,
        "main.c",
        "extern int forty_one(void);\nint main(void) { return forty_one() + 1; }\n",
    );
    let dylib_path = dir.join("libdemo.dylib");
    let ok = Command::new("cc")
        .args([
            "-dynamiclib",
            "demo.c",
            "-o",
            "libdemo.dylib",
            "-install_name",
        ])
        .arg(&dylib_path)
        .current_dir(&dir)
        .output()
        .is_ok_and(|o| o.status.success());
    if !ok {
        return; // no platform toolchain on this host
    }
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .args(["-L.", "-ldemo"])
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link against the dylib",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(out.status.code(), Some(42), "exit status mismatch");
}

/// A `.tbd` text stub stands in for a dylib the way the SDK's stubs
/// stand in for the shared cache: the stub is found ahead of any
/// archive, its exports resolve the reference, and the recorded
/// install name loads the real dylib from its own location.
#[cfg(all(target_os = "macos", target_arch = "aarch64"))]
#[test]
fn macos_tbd_stub_resolves_via_the_real_dylib_install_name() {
    let dir = tempdir("macos-tbd-link");
    let impl_dir = dir.join("impl");
    std::fs::create_dir_all(&impl_dir).expect("create impl dir");
    write_source(&impl_dir, "demo.c", "int forty_two(void) { return 42; }\n");
    write_source(
        &dir,
        "main.c",
        "extern int forty_two(void);\nint main(void) { return forty_two(); }\n",
    );
    let dylib_path = impl_dir.join("libdemo.dylib");
    let ok = Command::new("cc")
        .args([
            "-dynamiclib",
            "demo.c",
            "-o",
            "libdemo.dylib",
            "-install_name",
        ])
        .arg(&dylib_path)
        .current_dir(&impl_dir)
        .output()
        .is_ok_and(|o| o.status.success());
    if !ok {
        return; // no platform toolchain on this host
    }
    // The link directory holds only the stub; the dylib stays in
    // `impl/`, reachable through the stub's install-name.
    let tbd = format!(
        "--- !tapi-tbd\n\
         tbd-version:     4\n\
         targets:         [ arm64-macos ]\n\
         install-name:    '{}'\n\
         exports:\n  \
         - targets:         [ arm64-macos ]\n    \
         symbols:         [ _forty_two ]\n\
         ...\n",
        dylib_path.display()
    );
    std::fs::write(dir.join("libdemo.tbd"), tbd).expect("write the stub");
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .args(["-L.", "-ldemo"])
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link against the tbd stub",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(out.status.code(), Some(42), "exit status mismatch");
}

/// A foreign archive member's libc references resolve through the
/// implicit libSystem the way a compiler driver's implicit `-lc` /
/// `-lSystem` resolves them, with no binding scaffolding in any input.
#[cfg(all(target_os = "macos", target_arch = "aarch64"))]
#[test]
fn macos_foreign_member_libc_references_resolve_implicitly() {
    let dir = tempdir("macos-foreign-libc");
    write_source(
        &dir,
        "lenof.c",
        "#include <string.h>\nint lenof(const char *s) { return (int)strlen(s); }\n",
    );
    write_source(
        &dir,
        "main.c",
        "extern int lenof(const char *);\nint main(void) { return lenof(\"forty-two!\"); }\n",
    );
    let ok = Command::new("cc")
        .args(["-c", "lenof.c", "-o", "lenof.o"])
        .current_dir(&dir)
        .output()
        .is_ok_and(|o| o.status.success());
    if !ok {
        return; // no platform toolchain on this host
    }
    run(
        Command::new("ar")
            .args(["rc", "libforeign.a", "lenof.o"])
            .current_dir(&dir),
        "archive the foreign member",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .args(["-L.", "-lforeign"])
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link the foreign member against the implicit libSystem",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(out.status.code(), Some(10), "strlen result mismatch");
}

/// A shared library in a container the linker cannot read is reported
/// as such. Without the check the bytes fall through to the linker-
/// script reader, which finds no GROUP / INPUT entries in them and
/// resolves the `-l` to nothing at all.
#[test]
fn foreign_format_shared_library_is_diagnosed() {
    let dir = tempdir("foreign-dylib");
    let src = write_source(&dir, "main.c", "int main(void) { return 0; }\n");
    let mut macho = vec![0xCFu8, 0xFA, 0xED, 0xFE];
    macho.extend_from_slice(&[0u8; 28]);
    std::fs::write(dir.join("libfake.dylib"), &macho).expect("write the dylib");
    let out = Command::new(badc())
        .args(["--target=macos-aarch64", "-o", "prog", "-L.", "-lfake"])
        .arg(&src)
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(!out.status.success(), "a Mach-O dylib must be rejected");
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(
        err.contains("libfake.dylib") && err.contains("Mach-O"),
        "diagnostic must name the file and its format: {err}",
    );
}

/// Append a member to a BSD-format archive: `#1/<len>` in the header
/// with the name NUL-padded at the head of the body, the size field
/// covering both. `/usr/bin/ar` pads the name to a multiple of eight.
fn push_bsd_ar_member(out: &mut Vec<u8>, name: &str, body: &[u8]) {
    let field = name.len().div_ceil(8) * 8;
    let size = field + body.len();
    let mut hdr = [b' '; 60];
    let name_field = format!("#1/{field}");
    hdr[..name_field.len()].copy_from_slice(name_field.as_bytes());
    for i in [16, 28, 34, 40] {
        hdr[i] = b'0';
    }
    let size_field = format!("{size}");
    hdr[48..48 + size_field.len()].copy_from_slice(size_field.as_bytes());
    hdr[58] = 0x60;
    hdr[59] = 0x0A;
    out.extend_from_slice(&hdr);
    out.extend_from_slice(name.as_bytes());
    out.extend(std::iter::repeat_n(0u8, field - name.len()));
    out.extend_from_slice(body);
    if !size.is_multiple_of(2) {
        out.push(b'\n');
    }
}

/// A BSD-format archive links like a GNU one: the archive variant is a
/// property of the producer, not of the target, so the reader has to
/// resolve `#1/<len>` names and skip the `__.SYMDEF` index whatever is
/// being linked. Members carry no symbol index here, which is legal --
/// the linker scans member symbol tables to decide inclusion.
#[test]
fn bsd_format_archive_links_on_the_host_target() {
    let dir = tempdir("bsd-archive-link");
    write_source(
        &dir,
        "util.c",
        "int doubled(int n) { return n + n; }\nint trebled(int n) { return n * 3; }\n",
    );
    write_source(&dir, "unused.c", "int unused_helper(void) { return 99; }\n");
    let main = write_source(
        &dir,
        "main.c",
        "extern int doubled(int);\nextern int trebled(int);\n\
         int main(void) { return doubled(7) + trebled(8); }\n",
    );
    let mut blob: Vec<u8> = b"!<arch>\n".to_vec();
    push_bsd_ar_member(&mut blob, "__.SYMDEF SORTED", &[0u8; 4]);
    for (src, member) in [
        ("util.c", "util_with_a_name_over_sixteen_bytes.o"),
        ("unused.c", "unused.o"),
    ] {
        let obj = dir.join(member);
        run(
            Command::new(badc())
                .args(["-c", "-q", "-o"])
                .arg(&obj)
                .arg(dir.join(src))
                .current_dir(&dir),
            "compile an archive member",
        );
        let bytes = std::fs::read(&obj).expect("read the member object");
        push_bsd_ar_member(&mut blob, member, &bytes);
    }
    let lib = dir.join("libbsd.a");
    std::fs::write(&lib, &blob).expect("write the archive");

    let members = badc::read_archive(&blob).expect("read the archive");
    let names: Vec<&str> = members.iter().map(|m| m.name.as_str()).collect();
    assert_eq!(names, ["util_with_a_name_over_sixteen_bytes.o", "unused.o"]);

    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .args(["-q", "-o"])
            .arg(&exe)
            .arg(&main)
            .arg("-L")
            .arg(&dir)
            .args(["-l", "bsd"])
            .current_dir(&dir),
        "link against a BSD-format archive",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(out.status.code(), Some(38), "14 + 24");
}

/// Feed a source on stdin and return the finished invocation.
fn run_with_stdin(cmd: &mut Command, src: &str, what: &str) -> std::process::Output {
    use std::io::Write;
    use std::process::Stdio;
    let mut child = cmd
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap_or_else(|e| panic!("{what}: spawn: {e}"));
    child
        .stdin
        .take()
        .expect("stdin")
        .write_all(src.as_bytes())
        .unwrap_or_else(|e| panic!("{what}: write: {e}"));
    let out = child
        .wait_with_output()
        .unwrap_or_else(|e| panic!("{what}: wait: {e}"));
    if !out.status.success() {
        panic!(
            "{what} failed: status={} stderr={:?}",
            out.status,
            String::from_utf8_lossy(&out.stderr)
        );
    }
    out
}

/// `-` names stdin for the object and archive modes as it does for the
/// link, so a generator's output can be piped straight into a build. gcc
/// and clang name the object after the input, giving `-.o`; `--ar` takes
/// the same name for the member.
#[test]
fn stdin_source_compiles_to_an_object_and_into_an_archive() {
    let dir = tempdir("stdin-object");
    let src = "int from_stdin(void) { return 41; }\n";

    // `-c -` without `-o` writes `-.o` beside the other objects.
    run_with_stdin(
        Command::new(badc())
            .args(["-q", "-c", "-"])
            .current_dir(&dir),
        src,
        "compile stdin to a default-named object",
    );
    let dashed = dir.join("-.o");
    assert!(dashed.is_file(), "`-c -` must write `-.o`");
    assert!(
        badc::parse_native_elf(&std::fs::read(&dashed).expect("read -.o")).is_ok(),
        "`-.o` must be a readable relocatable object"
    );

    // `-o` names the object explicitly, and it links like any other.
    let obj = dir.join("stdin.o");
    run_with_stdin(
        Command::new(badc())
            .args(["-q", "-c", "-", "-o"])
            .arg(&obj)
            .current_dir(&dir),
        src,
        "compile stdin to a named object",
    );
    let main = write_source(
        &dir,
        "main.c",
        "extern int from_stdin(void);\nint main(void) { return from_stdin(); }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .args(["-q", "-o"])
            .arg(&exe)
            .arg(&main)
            .arg(&obj)
            .current_dir(&dir),
        "link the object built from stdin",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(out.status.code(), Some(41), "the stdin unit's value");

    // `--ar -` bundles the same bytes under the same `-.o` member name.
    let lib = dir.join("libstdin.a");
    run_with_stdin(
        Command::new(badc())
            .args(["-q", "--ar", "-", "-o"])
            .arg(&lib)
            .current_dir(&dir),
        src,
        "archive a unit read from stdin",
    );
    let members =
        badc::read_archive(&std::fs::read(&lib).expect("read archive")).expect("read the archive");
    assert!(
        members.iter().any(|m| m.name == "-.o"),
        "member names: {:?}",
        members.iter().map(|m| &m.name).collect::<Vec<_>>()
    );
}

/// The gcc / clang link-time-table idiom: several units place data
/// under one C-identifier section name and walk it between
/// `__start_<name>` and `__stop_<name>`. Every unit's contribution has
/// to be contiguous and the bounds have to enclose exactly it.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn start_stop_bound_a_named_section_across_units() {
    let dir = tempdir("start-stop-table");
    write_source(
        &dir,
        "tab.h",
        "struct ent { long v; };\n\
         #define REG(n, val) static const struct ent e_##n \\\n\
           __attribute__((section(\"mytab\"), used, aligned(8))) = { val }\n\
         extern const struct ent __start_mytab[], __stop_mytab[];\n",
    );
    write_source(
        &dir,
        "a.c",
        "#include \"tab.h\"\nint pad_a[3] = { 1, 2, 3 };\nREG(alpha, 1);\nREG(beta, 2);\n",
    );
    write_source(
        &dir,
        "b.c",
        "#include \"tab.h\"\nconst char *rod_b = \"b\";\nREG(gamma, 4);\n",
    );
    write_source(
        &dir,
        "main.c",
        "#include \"tab.h\"\n\
         REG(delta, 8);\n\
         int main(void) {\n\
         \tif (__stop_mytab - __start_mytab != 4) return 1;\n\
         \tint sum = 0;\n\
         \tfor (const struct ent *p = __start_mytab; p < __stop_mytab; p++) sum += (int)p->v;\n\
         \treturn sum == 15 ? 0 : 2;\n\
         }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("a.c"))
            .arg(dir.join("b.c"))
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link a named-section table",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        out.status.code(),
        Some(0),
        "named-section bounds: stdout={:?} stderr={:?}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
}

/// Section-header names of an ELF64 image, in table order.
fn elf_section_names(bytes: &[u8]) -> Vec<String> {
    let u16at = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap()) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let u64at = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap()) as usize;
    let (shoff, shnum, shstrndx) = (u64at(40), u16at(60), u16at(62));
    assert!(shoff != 0 && shnum != 0, "image carries no section headers");
    let strtab = u64at(shoff + shstrndx * 64 + 24);
    (0..shnum)
        .map(|i| {
            let at = strtab + u32at(shoff + i * 64);
            let end = at + bytes[at..].iter().position(|&b| b == 0).unwrap_or(0);
            String::from_utf8_lossy(&bytes[at..end]).into_owned()
        })
        .collect()
}

/// The merged path gives a grouped named section its own ELF section
/// header, not just `__start_` / `__stop_` bounds over bytes folded
/// into the family blob. Read-only, writable and zero-initialised
/// placements each land in the family whose region holds them.
#[test]
fn named_sections_get_their_own_elf_section_header() {
    let dir = tempdir("named-section-header");
    write_source(
        &dir,
        "a.c",
        "static const long ro __attribute__((section(\"myro\"), used)) = 1;\n\
         static long rw __attribute__((section(\"myrw\"), used)) = 2;\n",
    );
    write_source(
        &dir,
        "main.c",
        "extern const long __start_myro[], __stop_myro[];\n\
         int main(void) { return __stop_myro - __start_myro == 1 ? 0 : 1; }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("--target=linux-x64")
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("a.c"))
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link named sections for ELF",
    );
    let names = elf_section_names(&std::fs::read(&exe).expect("read image"));
    for n in ["myro", "myrw"] {
        assert!(names.iter().any(|s| s == n), "`{n}` in {names:?}");
    }
    // The family headers stay, holding what was not grouped out.
    for n in [".rodata", ".data", ".text"] {
        assert!(names.iter().any(|s| s == n), "`{n}` in {names:?}");
    }
}

/// `(segment, section)` pairs of a Mach-O image, in declaration order.
fn macho_section_names(bytes: &[u8]) -> Vec<(String, String)> {
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let name = |at: usize| {
        let end = at
            + bytes[at..at + 16]
                .iter()
                .position(|&b| b == 0)
                .unwrap_or(16);
        String::from_utf8_lossy(&bytes[at..end]).into_owned()
    };
    let mut out = Vec::new();
    let mut lc = 32;
    for _ in 0..u32at(16) {
        if u32at(lc) == 0x19 {
            for s in 0..u32at(lc + 64) {
                let sh = lc + 72 + s * 80;
                out.push((name(sh + 16), name(sh)));
            }
        }
        lc += u32at(lc + 4);
    }
    out
}

/// Section names of a PE image, in section-table order, each with its
/// characteristics word.
fn pe_section_names(bytes: &[u8]) -> Vec<(String, u32)> {
    let u16at = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap()) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let pe = u32at(0x3C) as usize;
    let table = pe + 24 + u16at(pe + 20);
    (0..u16at(pe + 6))
        .map(|i| {
            let at = table + i * 40;
            let end = at + bytes[at..at + 8].iter().position(|&b| b == 0).unwrap_or(8);
            (
                String::from_utf8_lossy(&bytes[at..end]).into_owned(),
                u32at(at + 36),
            )
        })
        .collect()
}

/// Sources exercising one named section per storage class, plus a name
/// over the 16-byte Mach-O section-name limit.
fn write_named_section_sources(dir: &std::path::Path) {
    write_source(
        dir,
        "a.c",
        "static const long ro __attribute__((section(\"myro\"), used)) = 1;\n\
         static long rw __attribute__((section(\"myrw\"), used)) = 2;\n\
         static long over __attribute__((section(\"a_name_past_the_macho_limit\"), used)) = 3;\n",
    );
    write_source(
        dir,
        "main.c",
        "extern const long __start_myro[], __stop_myro[];\n\
         extern const long __start_a_name_past_the_macho_limit[];\n\
         extern const long __stop_a_name_past_the_macho_limit[];\n\
         int main(void) {\n\
         if (__stop_myro - __start_myro != 1) return 1;\n\
         return __stop_a_name_past_the_macho_limit\n\
         - __start_a_name_past_the_macho_limit == 1 ? 0 : 2; }\n",
    );
}

/// The merged path gives a grouped named section its own Mach-O
/// section inside the segment its family maps, and the family sections
/// stay for what was not grouped out. A name past the 16-byte section
/// name field keeps the folded placement its bounds already describe.
#[test]
fn named_sections_get_their_own_macho_section() {
    let dir = tempdir("named-section-macho");
    write_named_section_sources(&dir);
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("--target=macos-aarch64")
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("a.c"))
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link named sections for Mach-O",
    );
    let image = std::fs::read(&exe).expect("read image");
    let names = macho_section_names(&image);
    let find = |s: &str| names.iter().find(|(_, n)| n == s).map(|(g, _)| g.clone());
    assert_eq!(
        find("myro").as_deref(),
        Some("__TEXT"),
        "a read-only name maps in __TEXT: {names:?}"
    );
    assert_eq!(
        find("myrw").as_deref(),
        Some("__DATA"),
        "a writable name maps in __DATA: {names:?}"
    );
    assert!(
        find("a_name_past_the_macho_limit").is_none(),
        "a name past 16 bytes has no section of its own: {names:?}"
    );
    for (seg, sect) in [
        ("__TEXT", "__text"),
        ("__TEXT", "__const"),
        ("__DATA", "__data"),
    ] {
        assert!(
            names.iter().any(|(g, n)| g == seg && n == sect),
            "`{seg},{sect}` in {names:?}"
        );
    }
    // Sections are declared in address order within each segment.
    for (seg, _) in &names {
        let addrs: Vec<u64> = section_addrs(&image, seg);
        assert!(
            addrs.windows(2).all(|w| w[0] <= w[1]),
            "`{seg}` sections out of address order: {addrs:?}"
        );
    }
    #[cfg(target_os = "macos")]
    {
        let out = Command::new(&exe).output().expect("run the image");
        assert_eq!(out.status.code(), Some(0), "named-section bounds hold");
    }
}

/// Section `addr` fields of one Mach-O segment, in declaration order.
fn section_addrs(bytes: &[u8], seg: &str) -> Vec<u64> {
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let mut out = Vec::new();
    let mut lc = 32;
    for _ in 0..u32at(16) {
        if u32at(lc) == 0x19 && bytes[lc + 8..lc + 8 + seg.len()] == *seg.as_bytes() {
            for s in 0..u32at(lc + 64) {
                let sh = lc + 72 + s * 80;
                out.push(u64::from_le_bytes(
                    bytes[sh + 32..sh + 40].try_into().unwrap(),
                ));
            }
        }
        lc += u32at(lc + 4);
    }
    out
}

/// The PE writer gives a grouped named section a section header of
/// its own. A PE section RVA is SectionAlignment-aligned, so each
/// takes a slot past `.data`; the read-only families keep `.rdata`'s
/// characteristics and the writable ones `.data`'s, and the table
/// stays in ascending RVA order.
#[test]
fn named_sections_get_their_own_pe_section() {
    const CNT_INITIALIZED: u32 = 0x40;
    const MEM_READ: u32 = 0x4000_0000;
    const MEM_WRITE: u32 = 0x8000_0000;
    let dir = tempdir("named-section-pe");
    write_named_section_sources(&dir);
    let exe = dir.join("prog.exe");
    run(
        Command::new(badc())
            .arg("--target=windows-x64")
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("a.c"))
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link named sections for PE",
    );
    let image = std::fs::read(&exe).expect("read image");
    let names = pe_section_names(&image);
    let chars = |s: &str| names.iter().find(|(n, _)| n == s).map(|(_, c)| *c);
    assert_eq!(
        chars("myro"),
        Some(CNT_INITIALIZED | MEM_READ),
        "a read-only name maps without write permission: {names:?}"
    );
    assert_eq!(
        chars("myrw"),
        Some(CNT_INITIALIZED | MEM_READ | MEM_WRITE),
        "a writable name keeps .data's characteristics: {names:?}"
    );
    // A name past the 8-byte header field is truncated, as link.exe
    // truncates its own; the bytes still get a section.
    assert!(
        chars("a_name_p").is_some(),
        "a truncated name still gets a section: {names:?}"
    );
    for n in [".text", ".rdata", ".data"] {
        assert!(names.iter().any(|(s, _)| s == n), "`{n}` in {names:?}");
    }
    let rvas = pe_section_rvas(&image);
    assert!(
        rvas.windows(2).all(|w| w[0] < w[1]),
        "the section table must ascend by RVA: {rvas:?}"
    );
}

/// Section `VirtualAddress` fields of a PE image, in table order.
fn pe_section_rvas(bytes: &[u8]) -> Vec<u32> {
    let u16at = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap()) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let pe = u32at(0x3C) as usize;
    let table = pe + 24 + u16at(pe + 20);
    (0..u16at(pe + 6))
        .map(|i| u32at(table + i * 40 + 12))
        .collect()
}

/// A unit defining `__start_<name>` itself keeps that definition: bfd
/// synthesizes the pair only where nothing else does, and
/// `__start_tty` is an ordinary function in at least one real tree.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn an_object_definition_outranks_a_synthesized_section_bound() {
    let dir = tempdir("start-stop-conflict");
    write_source(
        &dir,
        "main.c",
        "static const int t __attribute__((section(\"tty\"), used)) = 5;\n\
         int __start_tty(void) { return 7; }\n\
         int main(void) { return __start_tty() == 7 && t == 5 ? 0 : 1; }\n",
    );
    let exe = dir.join("prog");
    run(
        Command::new(badc())
            .arg("-o")
            .arg(&exe)
            .arg(dir.join("main.c"))
            .current_dir(&dir),
        "link a unit defining __start_tty itself",
    );
    let out = Command::new(&exe).output().expect("run prog");
    assert_eq!(out.status.code(), Some(0), "the object's definition wins");
}

/// `--gc-sections` through the ld persona: an identifier-named section
/// nothing reaches is dropped, one bracketed by a referenced
/// `__start_` / `__stop_` pair is kept, and without the option both
/// survive.
#[cfg(target_os = "linux")]
#[test]
fn gc_sections_drops_unreachable_named_sections() {
    let dir = tempdir("gc-sections");
    let src = write_source(
        &dir,
        "gc.c",
        "static const int live[2] __attribute__((section(\"livetab\"), used)) = { 1, 2 };\n\
         static const int dead[8] __attribute__((section(\"deadtab\"), used)) = { 0 };\n\
         extern const int __start_livetab[], __stop_livetab[];\n\
         int main(void) { return __stop_livetab - __start_livetab; }\n",
    );
    let obj = dir.join("gc.o");
    run(
        Command::new(badc())
            .args(["-q", "-c"])
            .arg(&src)
            .arg("-o")
            .arg(&obj)
            .current_dir(&dir),
        "compile the gc unit",
    );
    let link = |out: &str, gc: bool| -> Vec<(String, u32, u64)> {
        let exe = dir.join(out);
        let mut c = Command::new(badc());
        c.arg("--ld");
        if gc {
            c.arg("--gc-sections");
        }
        run(
            c.args(["-e", "main", "-o"])
                .arg(&exe)
                .arg(&obj)
                .current_dir(&dir),
            "link the gc unit",
        );
        elf_sections(&std::fs::read(&exe).expect("read image"))
    };
    let kept = link("gc_off", false);
    assert!(kept.iter().any(|s| s.0 == "deadtab"), "{kept:?}");
    assert!(kept.iter().any(|s| s.0 == "livetab"), "{kept:?}");
    let swept = link("gc_on", true);
    assert!(!swept.iter().any(|s| s.0 == "deadtab"), "{swept:?}");
    assert!(swept.iter().any(|s| s.0 == "livetab"), "{swept:?}");
}

// AArch64 input-section alignment and the MOVW group relocations.
// Every golden here was measured against GNU as 2.46.1 + GNU ld
// 2.46.1 on linux-aarch64; the cross-target links run on any host.
mod aarch64_link {
    use super::{badc, run, tempdir};
    use std::path::{Path, PathBuf};
    use std::process::Command;

    fn write(dir: &Path, name: &str, body: &str) -> PathBuf {
        let p = dir.join(name);
        std::fs::write(&p, body).expect("write source");
        p
    }

    /// Write each source and assemble it for linux-aarch64.
    fn assemble_a64(dir: &Path, srcs: &[(&str, &str)]) -> Vec<PathBuf> {
        let mut objs: Vec<PathBuf> = Vec::new();
        for (name, body) in srcs {
            let src = write(dir, name, body);
            let obj = dir.join(format!("{}.o", name.trim_end_matches(".s")));
            run(
                Command::new(badc())
                    .args(["-q", "-c", "--target=linux-aarch64"])
                    .arg(&src)
                    .arg("-o")
                    .arg(&obj)
                    .current_dir(dir),
                "assemble for linux-aarch64",
            );
            objs.push(obj);
        }
        objs
    }

    /// Link the sources into a freestanding linux-aarch64 image and
    /// return `(image bytes, link map)`.
    fn link_a64(dir: &Path, srcs: &[(&str, &str)]) -> (Vec<u8>, String) {
        let objs = assemble_a64(dir, srcs);
        let exe = dir.join("prog");
        let map = dir.join("prog.map");
        let mut c = Command::new(badc());
        c.args(["-q", "--target=linux-aarch64", "--freestanding"]);
        run(
            c.args(&objs)
                .arg("-o")
                .arg(&exe)
                .arg(format!("-Map={}", map.display()))
                .current_dir(dir),
            "link for linux-aarch64",
        );
        (
            std::fs::read(&exe).expect("read image"),
            std::fs::read_to_string(&map).expect("read map"),
        )
    }

    /// Attempt the same link and return the driver's stderr on failure.
    fn link_a64_err(dir: &Path, srcs: &[(&str, &str)]) -> String {
        let objs = assemble_a64(dir, srcs);
        let out = Command::new(badc())
            .args(["-q", "--target=linux-aarch64", "--freestanding"])
            .args(&objs)
            .arg("-o")
            .arg(dir.join("prog"))
            .current_dir(dir)
            .output()
            .expect("run the link");
        assert!(!out.status.success(), "the link was expected to fail");
        String::from_utf8_lossy(&out.stderr).into_owned()
    }

    /// Runtime address a link map gives a global symbol.
    fn map_symbol(map: &str, name: &str) -> u64 {
        for line in map.lines() {
            let mut f = line.split_whitespace();
            let (Some(addr), Some(sym)) = (f.next(), f.next()) else {
                continue;
            };
            if sym == name
                && f.next().is_none()
                && let Some(hex) = addr.strip_prefix("0x")
            {
                return u64::from_str_radix(hex, 16).expect("map address");
            }
        }
        panic!("`{name}` not in the link map:\n{map}");
    }

    /// Little-endian word an ELF64 image holds at `vaddr`.
    fn word_at(bytes: &[u8], vaddr: u64) -> u32 {
        let rd16 = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
        let rd32 = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
        let rd64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
        let e_phoff = rd64(0x20) as usize;
        let e_phentsize = rd16(0x36);
        for i in 0..rd16(0x38) {
            let ph = e_phoff + i * e_phentsize;
            let (p_vaddr, p_offset, p_filesz) = (rd64(ph + 16), rd64(ph + 8), rd64(ph + 32));
            if rd32(ph) == 1 && (p_vaddr..p_vaddr + p_filesz).contains(&vaddr) {
                return rd32((p_offset + (vaddr - p_vaddr)) as usize);
            }
        }
        panic!("vaddr {vaddr:#x} is in no PT_LOAD");
    }

    const ISLANDS: &str = "	.text\n\
                           	nop\n\
                           	nop\n\
                           	nop\n\
                           	.balign 16\n\
                           	.globl isle16\n\
                           isle16:\n\
                           	.quad 0x1122334455667788\n\
                           	.quad 0x99aabbccddeeff00\n\
                           	nop\n\
                           	.section .text.k32,\"ax\",@progbits\n\
                           	.balign 32\n\
                           	.globl isle32\n\
                           isle32:\n\
                           	.quad 1\n\
                           	.quad 2\n\
                           	nop\n\
                           	.section .text.k64,\"ax\",@progbits\n\
                           	.balign 64\n\
                           	.globl isle64\n\
                           isle64:\n\
                           	.quad 5\n";

    /// Each input text section keeps the alignment it claims once the
    /// image is laid out, which is the guarantee GNU ld gives: with
    /// the same three islands `ld` places them at 16-, 32- and
    /// 64-aligned addresses, and `.text` reports the widest of them.
    #[test]
    fn merged_text_keeps_each_input_section_alignment() {
        let dir = tempdir("a64-text-align");
        let main = "	.text\n\
                    	.globl __c5_entry\n\
                    __c5_entry:\n\
                    	adrp	x0, isle16\n\
                    	ldr	q0, [x0, #:lo12:isle16]\n\
                    	ret\n";
        let (image, map) = link_a64(&dir, &[("m.s", main), ("i.s", ISLANDS)]);
        for (name, align) in [("isle16", 16u64), ("isle32", 32), ("isle64", 64)] {
            let at = map_symbol(&map, name);
            assert_eq!(at % align, 0, "{name} at {at:#x} is not {align}-aligned");
        }
        // `.text`'s own header has to agree with where it starts.
        let rd16 = |o: usize| u16::from_le_bytes([image[o], image[o + 1]]) as usize;
        let rd64 = |o: usize| u64::from_le_bytes(image[o..o + 8].try_into().unwrap());
        let e_shoff = rd64(0x28) as usize;
        let (esz, num, strndx) = (rd16(0x3a), rd16(0x3c), rd16(0x3e));
        let str_off = rd64(e_shoff + strndx * esz + 0x18) as usize;
        let mut seen = false;
        for i in 0..num {
            let sh = e_shoff + i * esz;
            let n = str_off + u32::from_le_bytes(image[sh..sh + 4].try_into().unwrap()) as usize;
            if image[n..n + 6] != *b".text\0" {
                continue;
            }
            let (addr, align) = (rd64(sh + 16), rd64(sh + 48));
            assert_eq!(align, 64, ".text should report the widest input alignment");
            assert_eq!(addr % align, 0, ".text at {addr:#x} is not {align}-aligned");
            seen = true;
        }
        assert!(seen, "no .text section header");
    }

    /// A 16-byte load reaching a 16-aligned island: the scaled imm12
    /// can only carry a multiple of the access size, so a dropped
    /// alignment stops the link.
    #[test]
    fn scaled_16_byte_load_reaches_an_aligned_text_island() {
        let dir = tempdir("a64-scaled-ldr");
        let main = "	.text\n\
                    	.globl __c5_entry\n\
                    __c5_entry:\n\
                    	adrp	x0, isle16\n\
                    	ldr	q0, [x0, #:lo12:isle16]\n\
                    	ret\n";
        let (image, map) = link_a64(&dir, &[("m.s", main), ("i.s", ISLANDS)]);
        let entry = map_symbol(&map, "__c5_entry");
        let isle = map_symbol(&map, "isle16");
        // `ldr q0, [x0, #imm12]`: imm12 at bits 21:10, scaled by 16.
        let ldr = word_at(&image, entry + 4);
        assert_eq!(
            u64::from((ldr >> 10) & 0xfff) * 16,
            isle & 0xfff,
            "the scaled offset must reach the island's in-page address"
        );
    }

    /// Every MOVW group relocation over a link-time constant, against
    /// the words GNU ld writes for the same input.
    #[test]
    fn movw_group_relocations_match_gnu_ld() {
        // (specifier, symbol value, the word `ld` produced)
        let cases: &[(&str, &str, u32)] = &[
            ("movz	x5, :abs_g3:K", "0xfedc89ab1234f0f0", 0xd2ff_db85),
            ("movz	x5, :abs_g2_nc:K", "0xfedc89ab1234f0f0", 0xd2d1_3565),
            ("movz	x5, :abs_g1_nc:K", "0xfedc89ab1234f0f0", 0xd2a2_4685),
            ("movz	x5, :abs_g0_nc:K", "0xfedc89ab1234f0f0", 0xd29e_1e05),
            ("movk	x5, :abs_g2_nc:K", "0xfedc89ab1234f0f0", 0xf2d1_3565),
            ("movk	x5, :abs_g1_nc:K", "0xfedc89ab1234f0f0", 0xf2a2_4685),
            ("movk	x5, :abs_g0_nc:K", "0xfedc89ab1234f0f0", 0xf29e_1e05),
            ("movz	x5, :abs_g0:K", "0xbeef", 0xd297_dde5),
            ("movz	x5, :abs_g1:K", "0xcafe0000", 0xd2b9_5fc5),
            ("movz	x5, :abs_g2:K", "0xdead00000000", 0xd2db_d5a5),
            ("movz	x5, :abs_g0_s:K", "0x7fff", 0xd28f_ffe5),
            ("movz	x5, :abs_g0_s:K", "-0x8000", 0x928f_ffe5),
            ("movz	x5, :abs_g1_s:K", "0x7fffffff", 0xd2af_ffe5),
            ("movz	x5, :abs_g1_s:K", "-0x80000000", 0x92af_ffe5),
            ("movz	x5, :abs_g2_s:K", "0x123456789abc", 0xd2c2_4685),
            ("movz	x5, :abs_g2_s:K", "-0x800", 0x92c0_0005),
            ("movz	w5, :abs_g0_nc:K", "0xbeef", 0x5297_dde5),
            ("movk	w5, :abs_g1_nc:K", "0xcafe0000", 0x72b9_5fc5),
        ];
        for (i, (insn, value, want)) in cases.iter().enumerate() {
            let dir = tempdir(&format!("a64-movw-{i}"));
            let main = format!("	.text\n	.globl __c5_entry\n__c5_entry:\n	{insn}\n	ret\n");
            let defs = format!("	.globl K\n	.set K, {value}\n");
            let (image, map) = link_a64(&dir, &[("m.s", &main), ("d.s", &defs)]);
            let got = word_at(&image, map_symbol(&map, "__c5_entry"));
            assert_eq!(
                got, *want,
                "`{insn}` over {value}: got {got:#010x}, ld writes {want:#010x}"
            );
        }
    }

    /// The checked groups refuse a value they cannot hold, as ld does
    /// rather than narrowing it. The `_NC` groups take the same values.
    #[test]
    fn movw_checked_groups_refuse_an_out_of_range_value() {
        for (i, (insn, value)) in [
            ("movz	x5, :abs_g0:K", "0x10000"),
            ("movz	x5, :abs_g1:K", "0x100000000"),
            ("movz	x5, :abs_g2:K", "0x1000000000000"),
            ("movz	x5, :abs_g0_s:K", "0x10000"),
            ("movz	x5, :abs_g1_s:K", "0x100000000"),
            ("movz	x5, :abs_g2_s:K", "0x1000000000000"),
        ]
        .iter()
        .enumerate()
        {
            let dir = tempdir(&format!("a64-movw-range-{i}"));
            let main = format!("	.text\n	.globl __c5_entry\n__c5_entry:\n	{insn}\n	ret\n");
            let defs = format!("	.globl K\n	.set K, {value}\n");
            let err = link_a64_err(&dir, &[("m.s", &main), ("d.s", &defs)]);
            assert!(
                err.contains("relocation truncated to fit"),
                "`{insn}` over {value} should be refused: {err}"
            );
        }
    }

    /// A MOVW group over a section-relative symbol holds part of a
    /// runtime address, and no dynamic form carries an instruction
    /// field, so an image the loader places refuses it -- the refusal
    /// GNU ld gives for the same input in a `-pie` / `-shared` link.
    #[test]
    fn movw_against_a_placed_symbol_is_refused_in_a_pie() {
        let dir = tempdir("a64-movw-pie");
        let main = "	.text\n\
                    	.globl __c5_entry\n\
                    __c5_entry:\n\
                    	movz	x5, :abs_g2_s:tgt\n\
                    	movk	x5, :abs_g1_nc:tgt\n\
                    	movk	x5, :abs_g0_nc:tgt\n\
                    	ret\n\
                    	.globl tgt\n\
                    tgt:\n\
                    	nop\n";
        let err = link_a64_err(&dir, &[("m.s", main)]);
        assert!(
            err.contains("R_AARCH64_MOVW_SABS_G2")
                && err.contains("can not be used when making a position-independent executable"),
            "{err}"
        );
        assert!(err.contains("m.o(.text+0x0)"), "the site is named: {err}");
    }

    /// Build a host-native image from one asm source plus a `main` that
    /// exits nonzero on the first check it fails, run it, and require 0.
    /// The `main` compiles for the host data model, which is LLP64 on
    /// Windows, so a 64-bit value the asm returns needs `long long`.
    #[cfg(target_arch = "aarch64")]
    fn run_host_image(tag: &str, asm: &str, main: &str) {
        let dir = tempdir(tag);
        let exe = dir.join("prog");
        run(
            Command::new(badc())
                .arg("-q")
                .arg(write(&dir, "unit.s", asm))
                .arg(write(&dir, "main.c", main))
                .arg("-o")
                .arg(&exe)
                .current_dir(&dir),
            "build the host-native image",
        );
        let out = Command::new(&exe).output().expect("run prog");
        assert_eq!(
            out.status.code(),
            Some(0),
            "stdout={:?} stderr={:?}",
            String::from_utf8_lossy(&out.stdout),
            String::from_utf8_lossy(&out.stderr)
        );
    }

    /// The alignment fix on the host: a 16-aligned island read through
    /// a scaled 16-byte load, in a Mach-O image on macOS, an ELF one on
    /// Linux and a PE one on Windows.
    #[cfg(target_arch = "aarch64")]
    #[test]
    fn aligned_text_island_runs_on_the_host() {
        let asm = "	.text\n\
                   	nop\n\
                   	nop\n\
                   	nop\n\
                   	.balign 16\n\
                   	.globl isle16\n\
                   isle16:\n\
                   	.quad 0x1122334455667788\n\
                   	.quad 0x99aabbccddeeff00\n\
                   	.globl load_isle\n\
                   load_isle:\n\
                   	adrp	x1, isle16\n\
                   	ldr	q0, [x1, #:lo12:isle16]\n\
                   	mov	x0, v0.d[0]\n\
                   	ret\n\
                   	.globl isle_addr\n\
                   isle_addr:\n\
                   	adrp	x0, isle16\n\
                   	add	x0, x0, #:lo12:isle16\n\
                   	ret\n";
        let main = "extern unsigned long long load_isle(void), isle_addr(void);\n\
                    int main(void) {\n\
                    	if (isle_addr() % 16) return 1;\n\
                    	if (load_isle() != 0x1122334455667788ULL) return 2;\n\
                    	return 0;\n\
                    }\n";
        run_host_image("a64-align-run", asm, main);
    }

    /// The MOVW groups on the host: a value assembled from four
    /// unsigned groups, one from the signed top group, and a negative
    /// one that turns the leading `movz` into a `movn`.
    #[cfg(target_arch = "aarch64")]
    #[test]
    fn movw_constants_run_on_the_host() {
        let asm = "	.globl KBIG\n\
                   	.globl KMID\n\
                   	.globl KNEG\n\
                   	.set KBIG, 0xfedc89ab1234f0f0\n\
                   	.set KMID, 0x123456789abc\n\
                   	.set KNEG, -0x800\n\
                   	.text\n\
                   	.globl get_kbig\n\
                   get_kbig:\n\
                   	movz	x0, :abs_g3:KBIG\n\
                   	movk	x0, :abs_g2_nc:KBIG\n\
                   	movk	x0, :abs_g1_nc:KBIG\n\
                   	movk	x0, :abs_g0_nc:KBIG\n\
                   	ret\n\
                   	.globl get_kmid\n\
                   get_kmid:\n\
                   	movz	x0, :abs_g2_s:KMID\n\
                   	movk	x0, :abs_g1_nc:KMID\n\
                   	movk	x0, :abs_g0_nc:KMID\n\
                   	ret\n\
                   	.globl get_kneg\n\
                   get_kneg:\n\
                   	movz	x0, :abs_g2_s:KNEG\n\
                   	movk	x0, :abs_g1_nc:KNEG\n\
                   	movk	x0, :abs_g0_nc:KNEG\n\
                   	ret\n";
        let main = "extern unsigned long long get_kbig(void), get_kmid(void), get_kneg(void);\n\
                    int main(void) {\n\
                    	if (get_kbig() != 0xfedc89ab1234f0f0ULL) return 1;\n\
                    	if (get_kmid() != 0x123456789abcULL) return 2;\n\
                    	if (get_kneg() != (unsigned long long)-0x800LL) return 3;\n\
                    	return 0;\n\
                    }\n";
        run_host_image("a64-movw-run", asm, main);
    }

    /// An `R_AARCH64_ABS64` data slot naming an absolute symbol takes
    /// the constant, with no load-time relocation behind it.
    #[test]
    fn abs64_data_slot_over_an_absolute_symbol_takes_the_constant() {
        let dir = tempdir("a64-abs64-const");
        let main = "	.text\n\
                    	.globl __c5_entry\n\
                    __c5_entry:\n\
                    	ret\n\
                    	.data\n\
                    	.globl slot\n\
                    slot:\n\
                    	.quad K\n";
        let defs = "	.globl K\n	.set K, 0x123456789abc\n";
        let (image, map) = link_a64(&dir, &[("m.s", main), ("d.s", defs)]);
        let at = map_symbol(&map, "slot");
        let lo = u64::from(word_at(&image, at));
        let hi = u64::from(word_at(&image, at + 4));
        assert_eq!(lo | (hi << 32), 0x1234_5678_9abc);
    }
}

// COMDAT groups reach the linker from C++ inline functions and from
// gcc's PIC thunks, and no compiler here emits one, so the inputs are
// written out directly. x86-64 only: the bodies are machine code.
#[cfg(all(target_os = "linux", target_arch = "x86_64"))]
mod comdat {
    use super::{badc, run, tempdir};
    use std::path::{Path, PathBuf};
    use std::process::Command;

    const SHT_PROGBITS: u32 = 1;
    const SHT_SYMTAB: u32 = 2;
    const SHT_STRTAB: u32 = 3;
    const SHT_RELA: u32 = 4;
    const SHT_GROUP: u32 = 17;
    const SHF_ALLOC: u64 = 0x2;
    const SHF_EXECINSTR: u64 = 0x4;
    const SHF_GROUP: u64 = 0x200;
    const GRP_COMDAT: u32 = 1;
    const R_X86_64_PLT32: u32 = 4;

    struct Sec<'a> {
        name: &'a str,
        flags: u64,
        body: &'a [u8],
        /// `(offset, symbol index, type, addend)`.
        relocs: &'a [(u64, u32, u32, i64)],
    }

    /// `(name, st_info, one-based section index)`.
    struct Sym<'a>(&'a str, u8, u16);

    /// Write an ELF64 x86-64 ET_REL object. `group`, where given, is
    /// `(flags, signature symbol index, zero-based member sections)`.
    fn write_object(
        path: &Path,
        secs: &[Sec<'_>],
        syms: &[Sym<'_>],
        group: Option<(u32, u32, &[u32])>,
    ) {
        let n = secs.len();
        let group_shndx = 1 + n as u32;
        let has_group = group.is_some();
        let symtab_shndx = group_shndx + u32::from(has_group);
        let mut shstr = vec![0u8];
        let name_of = |s: &str, tab: &mut Vec<u8>| -> u32 {
            let at = tab.len() as u32;
            tab.extend_from_slice(s.as_bytes());
            tab.push(0);
            at
        };
        let sec_names: Vec<u32> = secs.iter().map(|s| name_of(s.name, &mut shstr)).collect();
        let n_group = has_group.then(|| name_of(".group", &mut shstr));
        let n_symtab = name_of(".symtab", &mut shstr);
        let n_strtab = name_of(".strtab", &mut shstr);
        let rela_of: Vec<usize> = (0..n).filter(|&i| !secs[i].relocs.is_empty()).collect();
        let n_rela: Vec<u32> = rela_of
            .iter()
            .map(|&i| name_of(&format!(".rela{}", secs[i].name), &mut shstr))
            .collect();
        let n_shstr = name_of(".shstrtab", &mut shstr);

        let mut strtab = vec![0u8];
        let sym_names: Vec<u32> = syms.iter().map(|s| name_of(s.0, &mut strtab)).collect();
        let mut symtab = vec![0u8; 24];
        for (k, s) in syms.iter().enumerate() {
            let mut e = [0u8; 24];
            e[0..4].copy_from_slice(&sym_names[k].to_le_bytes());
            e[4] = s.1;
            e[6..8].copy_from_slice(&s.2.to_le_bytes());
            symtab.extend_from_slice(&e);
        }

        let mut out = vec![0u8; 64];
        let mut off = Vec::new();
        for s in secs {
            off.push(out.len());
            out.extend_from_slice(s.body);
            while !out.len().is_multiple_of(8) {
                out.push(0);
            }
        }
        let group_at = out.len();
        if let Some((flags, _, members)) = group {
            out.extend_from_slice(&flags.to_le_bytes());
            for &m in members {
                out.extend_from_slice(&(m + 1).to_le_bytes());
            }
        }
        let symtab_at = out.len();
        out.extend_from_slice(&symtab);
        let strtab_at = out.len();
        out.extend_from_slice(&strtab);
        let mut rela_at = Vec::new();
        for &i in &rela_of {
            rela_at.push(out.len());
            for &(o, sym, ty, add) in secs[i].relocs {
                out.extend_from_slice(&o.to_le_bytes());
                out.extend_from_slice(&(((sym as u64) << 32) | ty as u64).to_le_bytes());
                out.extend_from_slice(&(add as u64).to_le_bytes());
            }
        }
        let shstr_at = out.len();
        out.extend_from_slice(&shstr);
        while !out.len().is_multiple_of(8) {
            out.push(0);
        }
        let shoff = out.len();

        let mut hdr = |name: u32,
                       ty: u32,
                       flags: u64,
                       offset: usize,
                       size: usize,
                       link: u32,
                       info: u32,
                       align: u64,
                       entsize: u64| {
            let mut h = [0u8; 64];
            h[0..4].copy_from_slice(&name.to_le_bytes());
            h[4..8].copy_from_slice(&ty.to_le_bytes());
            h[8..16].copy_from_slice(&flags.to_le_bytes());
            h[24..32].copy_from_slice(&(offset as u64).to_le_bytes());
            h[32..40].copy_from_slice(&(size as u64).to_le_bytes());
            h[40..44].copy_from_slice(&link.to_le_bytes());
            h[44..48].copy_from_slice(&info.to_le_bytes());
            h[48..56].copy_from_slice(&align.to_le_bytes());
            h[56..64].copy_from_slice(&entsize.to_le_bytes());
            out.extend_from_slice(&h);
        };
        hdr(0, 0, 0, 0, 0, 0, 0, 0, 0);
        for (i, s) in secs.iter().enumerate() {
            hdr(
                sec_names[i],
                SHT_PROGBITS,
                s.flags,
                off[i],
                s.body.len(),
                0,
                0,
                1,
                0,
            );
        }
        if let Some((_, sig, members)) = group {
            hdr(
                n_group.unwrap(),
                SHT_GROUP,
                0,
                group_at,
                4 + 4 * members.len(),
                symtab_shndx,
                sig,
                4,
                4,
            );
        }
        hdr(
            n_symtab,
            SHT_SYMTAB,
            0,
            symtab_at,
            symtab.len(),
            symtab_shndx + 1,
            1,
            8,
            24,
        );
        hdr(n_strtab, SHT_STRTAB, 0, strtab_at, strtab.len(), 0, 0, 1, 0);
        for (k, &i) in rela_of.iter().enumerate() {
            hdr(
                n_rela[k],
                SHT_RELA,
                0,
                rela_at[k],
                secs[i].relocs.len() * 24,
                symtab_shndx,
                1 + i as u32,
                8,
                24,
            );
        }
        hdr(n_shstr, SHT_STRTAB, 0, shstr_at, shstr.len(), 0, 0, 1, 0);

        let shnum = 1 + n + usize::from(has_group) + 2 + rela_of.len() + 1;
        out[0..16].copy_from_slice(&[0x7f, b'E', b'L', b'F', 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        out[16..18].copy_from_slice(&1u16.to_le_bytes()); // ET_REL
        out[18..20].copy_from_slice(&62u16.to_le_bytes()); // EM_X86_64
        out[20..24].copy_from_slice(&1u32.to_le_bytes());
        out[40..48].copy_from_slice(&(shoff as u64).to_le_bytes());
        out[52..54].copy_from_slice(&64u16.to_le_bytes());
        out[58..60].copy_from_slice(&64u16.to_le_bytes());
        out[60..62].copy_from_slice(&(shnum as u16).to_le_bytes());
        out[62..64].copy_from_slice(&((shnum - 1) as u16).to_le_bytes());
        std::fs::write(path, out).expect("write object");
    }

    /// One translation unit's copy of an inline function: `scale`
    /// multiplies by `k` and sits in its own COMDAT group, and the
    /// unit's own entry tail-calls it with `arg`.
    fn unit(dir: &Path, name: &str, caller: &str, k: u8, arg: u8) -> PathBuf {
        let scale = [0x89, 0xf8, 0x6b, 0xc0, k, 0xc3];
        let call = [0xbf, arg, 0x00, 0x00, 0x00, 0xe9, 0, 0, 0, 0];
        let p = dir.join(name);
        write_object(
            &p,
            &[
                Sec {
                    name: ".text.scale",
                    flags: SHF_ALLOC | SHF_EXECINSTR | SHF_GROUP,
                    body: &scale,
                    relocs: &[],
                },
                Sec {
                    name: ".text.caller",
                    flags: SHF_ALLOC | SHF_EXECINSTR,
                    body: &call,
                    relocs: &[(6, 1, R_X86_64_PLT32, -4)],
                },
            ],
            &[Sym("scale", 0x22, 1), Sym(caller, 0x12, 2)],
            Some((GRP_COMDAT, 1, &[0])),
        );
        p
    }

    /// `_start` sums the two units' results and exits with the total.
    fn main_object(dir: &Path) -> PathBuf {
        let body = [
            0xe8, 0, 0, 0, 0, // call from_a
            0x89, 0xc3, // mov %eax,%ebx
            0xe8, 0, 0, 0, 0, // call from_b
            0x01, 0xd8, // add %ebx,%eax
            0x89, 0xc7, // mov %eax,%edi
            0xb8, 0x3c, 0x00, 0x00, 0x00, // mov $60,%eax
            0x0f, 0x05, // syscall
        ];
        let p = dir.join("m.o");
        write_object(
            &p,
            &[Sec {
                name: ".text",
                flags: SHF_ALLOC | SHF_EXECINSTR,
                body: &body,
                relocs: &[(1, 2, R_X86_64_PLT32, -4), (8, 3, R_X86_64_PLT32, -4)],
            }],
            &[
                Sym("_start", 0x12, 1),
                Sym("from_a", 0x12, 0),
                Sym("from_b", 0x12, 0),
            ],
            None,
        );
        p
    }

    /// Two objects carry the same inline function, each in its own
    /// COMDAT group, and the bodies differ so the exit status names
    /// the copy that survived. Without the dedup the link fails on the
    /// duplicate; with it, the first copy serves both call sites.
    #[test]
    fn one_copy_of_a_comdat_inline_function_serves_every_caller() {
        let dir = tempdir("comdat-inline");
        let m = main_object(&dir);
        let a = unit(&dir, "a.o", "from_a", 3, 10);
        let b = unit(&dir, "b.o", "from_b", 7, 20);
        let exe = dir.join("prog");
        run(
            Command::new(badc())
                .arg("--ld")
                .arg("-static")
                .arg("-e")
                .arg("_start")
                .args([&m, &a, &b])
                .arg("-o")
                .arg(&exe),
            "link with comdat groups",
        );
        let out = Command::new(&exe).output().expect("run prog");
        assert_eq!(
            out.status.code(),
            Some(90),
            "10*3 + 20*3: the first group's body serves both callers"
        );
        let swapped = dir.join("swapped");
        run(
            Command::new(badc())
                .arg("--ld")
                .arg("-static")
                .arg("-e")
                .arg("_start")
                .args([&m, &b, &a])
                .arg("-o")
                .arg(&swapped),
            "link with the groups in the other order",
        );
        let out = Command::new(&swapped).output().expect("run swapped");
        assert_eq!(
            out.status.code(),
            Some(210),
            "10*7 + 20*7: first in link order wins"
        );
    }
}

/// Every option value the ld driver refuses, named in the message it
/// prints. `LdArgs::parse` rejects the first four while reading the
/// command line; the emulation is resolved once parsing is done.
#[test]
fn ld_driver_names_the_option_value_it_refuses() {
    let cases: [(&[&str], &str); 6] = [
        (&["--hash-style=bogus"], "unknown hash style `bogus`"),
        (
            &["-z", "max-page-size=3"],
            "-z max-page-size requires a power of two",
        ),
        (
            &["--build-id=bogus"],
            "unsupported --build-id style `bogus`",
        ),
        (
            &["--orphan-handling=bogus"],
            "unknown --orphan-handling kind `bogus`",
        ),
        (&["--frobnicate"], "unrecognized option `--frobnicate`"),
        (&["-m", "bogus"], "unsupported emulation `bogus`"),
    ];
    for (args, want) in cases {
        let out = Command::new(badc())
            .arg("--ld")
            .args(args)
            .output()
            .expect("run the ld driver");
        assert!(!out.status.success(), "{args:?} should have been refused");
        let err = String::from_utf8_lossy(&out.stderr).into_owned();
        assert!(err.contains(want), "{args:?}: stderr {err}");
    }
}

/// A malformed input is reported as the user's, under the
/// malformed-input row, with no internal-compiler-error marker.
#[test]
fn a_malformed_archive_is_not_reported_as_an_internal_error() {
    let dir = tempdir("malformed-archive");
    std::fs::write(dir.join("bad.a"), b"!<arch>\ntruncated").expect("write archive");
    let result = Command::new(badc())
        .arg("-o")
        .arg(dir.join("x"))
        .arg(dir.join("bad.a"))
        .current_dir(&dir)
        .output()
        .expect("invoke badc");
    assert!(
        !result.status.success(),
        "a truncated archive fails the link"
    );
    let stderr = String::from_utf8_lossy(&result.stderr);
    assert!(
        stderr.contains("ar header truncated") && stderr.contains("[B6014] [malformed-input]"),
        "expected the malformed-input diagnostic: {stderr}"
    );
    assert!(
        !stderr.contains("internal compiler error"),
        "a malformed input is not badc's fault: {stderr}"
    );
}

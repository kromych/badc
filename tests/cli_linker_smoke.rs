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
/// `int` return). Surfaced as lua's `io` global being `nil` after
/// `luaL_openlibs`: `luaopen_io` runs to completion, but its
/// `return 1` -- the C-function-result count `lua_call` reads --
/// reached the caller as zero, so the registered module was
/// silently the empty stack tail (nil) instead of the `iolib`
/// table.
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
// chain. The embedded runtime (`lib/runtime.c`) now exports
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
/// nor saw the user's `-D` macros, and a typedef chain like
/// miniz's `sizeof(uint16_t) == 2 ? 1 : -1` array probe
/// folded against an undefined typedef. C99 6.10.2 requires
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
        &bytes.get(..16),
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

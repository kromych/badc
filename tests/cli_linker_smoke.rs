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

// C99 6.7.9p23: function-pointer initializers like
// `static const VTable v = { .fp = doubled };` must carry
// the target function's runtime VA. The ET_REL writer emits
// a `.rela.data` `R_X86_64_64` / `R_AARCH64_ABS64` against
// the `.text` section symbol with `r_addend = native offset
// of the target function`; the link / final-image writer
// pair patches the slot to `text_vaddr + offset`.
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

// macOS arm64 -.o link path through the synthesizer. Compiles
// two sources with `-c`, links the two .o into a Mach-O
// executable, and execs to verify the runtime behaviour round-
// trip works. The synth path auto-codesigns via
// `post_write_native`, so no manual codesign step is needed.
#[cfg(all(target_os = "macos", target_arch = "aarch64"))]
#[test]
fn macos_native_link_two_sources_with_libc() {
    let dir = tempdir("macos-native-link");
    write_source(
        &dir,
        "helper.c",
        "int helper(int x) { return x * 6; }\n",
    );
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
    assert!(
        stdout.contains("answer=42"),
        "unexpected stdout: {stdout}"
    );
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
    write_source(
        &dir,
        "helper.c",
        "int helper(int x) { return x * 6; }\n",
    );
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
    assert!(
        stdout.contains("answer=42"),
        "unexpected stdout: {stdout}"
    );
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
    write_source(
        &dir,
        "helper.c",
        "int helper(int x) { return x * 6; }\n",
    );
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
    assert!(
        stdout.contains("answer=42"),
        "unexpected stdout: {stdout}"
    );
}

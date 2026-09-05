//! End-to-end Linux/aarch64 ELF tests. Mirror of [`super::native`]
//! (the macOS Mach-O suite) for the Linux target.
//!
//! Gated to `linux + aarch64` because the produced binary is an ELF
//! that the host kernel must agree to load and execute. CI runs this
//! module on the `ubuntu-24.04-arm` runner; macOS / x86_64 / Windows
//! lanes compile it out entirely.

#![cfg(all(target_os = "linux", target_arch = "aarch64"))]

use std::io::Write;
use std::path::Path;
use std::process::Command;

use super::fixture_tables::NATIVE_ELF_FIXTURES;
use crate::{Compiler, NativeOptions, Target, emit_native, emit_native_with_options};

/// Outcome of compiling-and-running a native ELF binary. Mirrors
/// `super::native::RunOutcome` so failures can be diagnosed
/// per-fixture without panicking out of the suite.
#[derive(Debug)]
#[allow(dead_code)]
enum RunOutcome {
    Exit(i32),
    Signal(i32),
    BuildError(String),
}

impl RunOutcome {
    fn matches(&self, expected: i32) -> bool {
        matches!(self, RunOutcome::Exit(c) if *c == expected)
    }
}

fn build_and_run(src: &str, stem: &str) -> i32 {
    match build_and_run_outcome(src, stem) {
        RunOutcome::Exit(c) => c,
        other => panic!("expected normal exit, got {other:?}"),
    }
}

fn build_and_run_outcome(src: &str, stem: &str) -> RunOutcome {
    build_and_run_outcome_with_options(src, stem, NativeOptions::default())
}

fn build_and_run_outcome_with_options(src: &str, stem: &str, opts: NativeOptions) -> RunOutcome {
    let program = match Compiler::new(super::with_prelude(src)).compile() {
        Ok(p) => p,
        Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
    };
    let bytes = match emit_native_with_options(&program, Target::LinuxAarch64, opts) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let path = super::unique_temp_path("badc-elf-test", stem, ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        // sync_all so the page cache is flushed before exec --
        // otherwise the kernel can briefly hold a writable
        // reference and exec returns ETXTBUSY.
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);

    let output = exec_with_retry(&path);
    let _ = std::fs::remove_file(&path);
    match output {
        Ok(o) => {
            if let Some(code) = o.status.code() {
                RunOutcome::Exit(code)
            } else {
                use std::os::unix::process::ExitStatusExt;
                let signal = o.status.signal().unwrap_or(0);
                RunOutcome::Signal(signal)
            }
        }
        Err(e) => panic!("could not exec the produced binary: {e}"),
    }
}

/// Run the binary at `path`, retrying briefly on ETXTBUSY. Linux
/// occasionally returns this when an exec races with a still-being-
/// closed writable fd, even though `File` was already dropped --
/// the kernel's writeback isn't strictly synchronous and parallel
/// `cargo test` threads can amplify the window.
fn exec_with_retry(path: &Path) -> std::io::Result<std::process::Output> {
    exec_with_retry_envs::<&str, &str>(path, &[])
}

/// Same as [`exec_with_retry`] but with optional environment-variable
/// pairs forwarded to the spawned process. Lets `getenv_value` etc.
/// share the ETXTBUSY back-off without dropping their `.env(...)`
/// configuration; running on the ubuntu-24.04-arm GHA runner makes
/// the race tight enough that `Command::new(...).output()` straight
/// up faulted with code 26 mid-suite (pre-fix CI run 25561368984).
fn exec_with_retry_envs<K, V>(path: &Path, envs: &[(K, V)]) -> std::io::Result<std::process::Output>
where
    K: AsRef<std::ffi::OsStr>,
    V: AsRef<std::ffi::OsStr>,
{
    let build = || {
        let mut cmd = Command::new(path);
        for (k, v) in envs.iter() {
            cmd.env(k, v);
        }
        cmd
    };
    for attempt in 0..10 {
        match build().output() {
            Ok(o) => return Ok(o),
            Err(e) if e.raw_os_error() == Some(26) => {
                // ETXTBUSY -- back off and retry.
                std::thread::sleep(std::time::Duration::from_millis(10 * (attempt + 1)));
            }
            Err(e) => return Err(e),
        }
    }
    // One last attempt with a propagated error.
    build().output()
}

fn set_executable(path: &Path) {
    use std::os::unix::fs::PermissionsExt;
    let meta = std::fs::metadata(path).unwrap();
    let mut perms = meta.permissions();
    perms.set_mode(perms.mode() | 0o111);
    std::fs::set_permissions(path, perms).unwrap();
}

/// Build through the multi-object link path (ET_REL merge +
/// `write_native_image_from_merged`) and run the produced image.
/// Exercises the merged stream layout -- the direct
/// `emit_native` path above never produces a relro region.
#[cfg(feature = "full")]
fn link_and_run_outcome(src: &str, stem: &str) -> RunOutcome {
    let program = match Compiler::with_target(src.to_string(), Target::LinuxAarch64).compile() {
        Ok(p) => p,
        Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
    };
    let bytes = match super::link_executable_with_runtime(
        &program,
        Target::LinuxAarch64,
        NativeOptions::default(),
    ) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("link: {e}")),
    };
    let path = super::unique_temp_path("badc-elf-test", stem, ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path);
    let _ = std::fs::remove_file(&path);
    match output {
        Ok(o) => {
            if let Some(code) = o.status.code() {
                RunOutcome::Exit(code)
            } else {
                use std::os::unix::process::ExitStatusExt;
                RunOutcome::Signal(o.status.signal().unwrap_or(0))
            }
        }
        Err(e) => panic!("could not exec the produced binary: {e}"),
    }
}

/// A relocated `const` initializer routes its unit's read-only
/// content to the relro region; after the loader's fixups the pages
/// are re-protected (PT_GNU_RELRO), so a store faults while a
/// writable global stays writable.
#[test]
#[cfg(feature = "full")]
fn relro_const_store_faults() {
    let decls = "const unsigned char tab[2048] = {7, 7, 7, 7};\n\
                 const char *const cp = \"hello\";\n\
                 int wglobal = 5;\n";
    let read = format!("{decls}int main(void) {{ return cp[0] == 'h' && tab[3] == 7 ? 0 : 1; }}");
    match link_and_run_outcome(&read, "relro_read") {
        RunOutcome::Exit(0) => {}
        other => panic!("relocated-pointer read must exit 0, got {other:?}"),
    }
    let tab_store =
        format!("{decls}int main(void) {{ *(unsigned char *)&tab[5] = 9; return tab[5]; }}");
    match link_and_run_outcome(&tab_store, "relro_tab_store") {
        RunOutcome::Signal(_) => {}
        other => panic!("store to relro const table must fault, got {other:?}"),
    }
    let slot_store = format!(
        "{decls}int main(void) {{ *(const char **)&cp = (const char *)tab; return cp == 0; }}"
    );
    match link_and_run_outcome(&slot_store, "relro_slot_store") {
        RunOutcome::Signal(_) => {}
        other => panic!("store to the relocated pointer slot must fault, got {other:?}"),
    }
    let control = format!("{decls}int main(void) {{ wglobal = 6; return wglobal == 6 ? 0 : 2; }}");
    match link_and_run_outcome(&control, "relro_control") {
        RunOutcome::Exit(0) => {}
        other => panic!("writable global must stay writable, got {other:?}"),
    }
}

// ---- Smoke tests -- the same shapes as src/c5/tests/native.rs but
//      driving the Linux ELF writer end-to-end. ----

#[test]
fn return_42() {
    assert_eq!(build_and_run("int main() { return 42; }", "elf-ret42"), 42);
}

#[test]
fn return_zero() {
    assert_eq!(build_and_run("int main() { return 0; }", "elf-ret0"), 0);
}

/// aarch64 twin of `native_elf_x64::symbol_get_weak_hidden_undef_reads_null`.
/// The kernel `symbol_get(x)` idiom takes the address of a block-scope
/// `extern typeof(x) x __attribute__((weak, visibility("hidden")))`
/// redeclaration; undefined, it reads as null and the guard skips the call.
#[test]
fn symbol_get_weak_hidden_undef_reads_null() {
    let code = build_and_run(
        "extern void optional_hook(void);\n\
         #define symbol_get(x) \
         ({ extern typeof(x) x __attribute__((weak, visibility(\"hidden\"))); &(x); })\n\
         int main(void) {\n\
             void (*fn)(void) = symbol_get(optional_hook);\n\
             if (fn) {\n\
                 fn();\n\
                 return 1;\n\
             }\n\
             return 0;\n\
         }\n",
        "symbol_get_weak_hidden",
    );
    assert_eq!(code, 0, "weak hidden undefined address must read as null");
}

#[test]
fn return_value_truncates_to_byte() {
    // Linux exit ABI returns the low 8 bits of main's return; same as
    // macOS. 257 -> 1 confirms the intrinsic/libc-exit path doesn't
    // accidentally widen the value.
    assert_eq!(build_and_run("int main() { return 257; }", "elf-ret257"), 1);
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
    assert_eq!(build_and_run(src, "elf-locals"), 42);
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
    assert_eq!(build_and_run(src, "elf-while"), 45);
}

#[test]
fn function_call_returns_value() {
    let src = r#"
        int square(int n) { return n * n; }
        int main() { return square(6) + square(2); }
    "#;
    assert_eq!(build_and_run(src, "elf-fncall"), 40);
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
    assert_eq!(build_and_run(src, "elf-fact"), 120);
}

#[test]
fn printf_through_libc_got() {
    // printf needs the format string in __data
    // and the libc symbol resolved through .got. Linux follows
    // standard AAPCS64 so variadic args go in x1..x7 just like fixed
    // ones (no macOS-style stack packing).
    let src = r#"int main() { printf("%d\n", 42); return 0; }"#;
    assert_eq!(build_and_run(src, "elf-printf"), 0);
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
    assert_eq!(build_and_run(src, "elf-malloc"), 1);
}

/// The full-runtime startup publishes the process environment vector
/// through `environ` (POSIX 8.3): `__c5_entry` reads envp off the initial
/// stack (`&argv[argc + 1]`) and assigns it. Without that the global is
/// NULL and `environ[i]` faults. The self-contained `emit_native` stub
/// used by the fixture table does not link the runtime, so this links
/// through `link_executable_with_runtime` and runs.
#[test]
fn environ_populated_through_runtime() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    // `no_entry_point` matches the CLI's `-c` path so `extern char
    // **environ` stays an undefined reference resolved against the
    // runtime's definition, not a tentative definition that collides.
    let program = Compiler::with_options(
        "extern char **environ; \
         int main(void) { \
             if (environ == 0) { return 1; } \
             int n = 0; \
             for (char **e = environ; *e != 0; e++) { n++; } \
             return n > 0 ? 0 : 2; \
         }"
        .to_string(),
        Target::LinuxAarch64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile environ program");
    let bytes = super::link_executable_with_runtime(
        &program,
        Target::LinuxAarch64,
        NativeOptions::default(),
    )
    .expect("link LinuxAarch64 with runtime");
    let path = super::unique_temp_path("badc-environ", "env", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec environ binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "environ must be non-null and non-empty under the full runtime",
    );
}

/// A `static` constructor runs before `main`: it sets a global `main`
/// returns, so the exit code is non-zero only if the constructor ran
/// first. Exercises the full link path (runtime.c walks the linker's
/// `.init_array`), not the self-contained `emit_native` stub.
#[test]
fn constructor_runs_before_main() {
    use crate::{Compiler, NativeOptions, Target};
    let program = Compiler::new(super::with_prelude(
        "static int g;\n\
         __attribute__((constructor)) static void ctor(void) { g = 42; }\n\
         int main(void) { return g; }\n",
    ))
    .compile()
    .expect("compile constructor program");
    let bytes = super::link_executable_with_runtime(
        &program,
        Target::LinuxAarch64,
        NativeOptions::default(),
    )
    .expect("link with runtime");
    let path = super::unique_temp_path("badc-ctor", "run", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec constructor binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(42),
        "the constructor must run before main and set the global",
    );
}

/// Constructor priority ordering plus a destructor firing at exit.
/// Prioritized constructors run in ascending priority, unprioritized
/// last; the destructor runs on the atexit chain after main. The
/// stdout sequence pins the whole order.
#[test]
fn constructor_priority_and_destructor_order() {
    use crate::{Compiler, NativeOptions, Target};
    let program = Compiler::new(super::with_prelude(
        "#include <stdio.h>\n\
         __attribute__((constructor(102))) static void c2(void) { printf(\"c2\\n\"); }\n\
         __attribute__((constructor(101))) static void c1(void) { printf(\"c1\\n\"); }\n\
         __attribute__((constructor)) static void c3(void) { printf(\"c3\\n\"); }\n\
         __attribute__((destructor)) static void d1(void) { printf(\"d1\\n\"); }\n\
         int main(void) { printf(\"main\\n\"); return 0; }\n",
    ))
    .compile()
    .expect("compile ctor/dtor program");
    let bytes = super::link_executable_with_runtime(
        &program,
        Target::LinuxAarch64,
        NativeOptions::default(),
    )
    .expect("link with runtime");
    let path = super::unique_temp_path("badc-ctor-order", "run", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec ctor/dtor binary");
    let _ = std::fs::remove_file(&path);
    let stdout = String::from_utf8_lossy(&output.stdout);
    assert_eq!(
        stdout, "c1\nc2\nc3\nmain\nd1\n",
        "constructors run priority-ascending then unprioritized, main, then the destructor at exit",
    );
}

// ---- Fixture parity. Mirror of the `fixture_parity` test in
//      `super::native`, against the same fixture set so a drift in
//      either backend shows up as a Linux-specific failure. ----

fn build_and_run_fixture(name: &str) -> RunOutcome {
    build_and_run_fixture_with_options(name, NativeOptions::default(), "")
}

fn build_and_run_fixture_with_options(name: &str, opts: NativeOptions, suffix: &str) -> RunOutcome {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let stem = name.trim_end_matches(".c");
    build_and_run_outcome_with_options(&src, &format!("elf-fixture-{stem}{suffix}"), opts)
}

#[test]
fn fixture_parity() {
    let failures = super::parity_failures(NATIVE_ELF_FIXTURES, |name, expected| {
        let outcome = build_and_run_fixture(name);
        (!outcome.matches(*expected))
            .then(|| format!("{name}: expected exit {expected}, got {outcome:?}"))
    });
    assert!(
        failures.is_empty(),
        "{} of {} ELF fixtures regressed:\n  {}",
        failures.len(),
        NATIVE_ELF_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// Post-call sub-word extension on the libc return register.
/// See the matching test in `super::native::atoi_negative_sign_extends`.
/// ELF/glibc happens to leave the upper bits of the return
/// register zeroed today, but the c5-emitted `sxtw` is still
/// required per AAPCS64.
#[test]
fn atoi_negative_sign_extends() {
    let outcome = build_and_run_fixture("atoi_negative.c");
    assert!(
        matches!(outcome, RunOutcome::Exit(0)),
        "atoi('-17') should sign-extend to -1 in i64, got {outcome:?}"
    );
}

/// `-O` parity for the ELF backend: every fixture must produce the
/// same exit code with the optimizer enabled as without. Mirrors
/// `super::jit::fixture_parity_native_optimized` so any optimizer
/// regression specific to the ELF lowering (e.g. a peephole that
/// fires only when the ELF writer emits its prologue shape) shows
/// up here rather than only on macOS.
#[test]
fn fixture_parity_native_optimized() {
    let opts = NativeOptions::new().with_optimize();
    let failures = super::parity_failures(NATIVE_ELF_FIXTURES, |name, expected| {
        let outcome = build_and_run_fixture_with_options(name, opts, "-O");
        (!outcome.matches(*expected))
            .then(|| format!("{name} (-O): expected exit {expected}, got {outcome:?}"))
    });
    assert!(
        failures.is_empty(),
        "{} of {} ELF fixtures regressed under -O:\n  {}",
        failures.len(),
        NATIVE_ELF_FIXTURES.len(),
        failures.join("\n  ")
    );
}

// ---- Standalone tests for fixtures that need argv / env / CWD
//      setup the parity harness can't provide. ----

#[test]
fn file_io_natively() {
    // The fixture opens `test_dummy.txt` relative to the CWD, so the
    // binary runs in a per-process directory holding that file.
    let cwd = super::unique_temp_path("badc-elf-test", "file_io-cwd", "");
    std::fs::create_dir_all(&cwd).unwrap();
    std::fs::write(cwd.join("test_dummy.txt"), "1234567890").unwrap();

    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("file_io.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src).compile().expect("compile file_io.c");
    let bytes = emit_native(&program, Target::LinuxAarch64).expect("emit_native");
    let bin_path = super::unique_temp_path("badc-elf-test-file_io", "file_io", ".bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    // ETXTBUSY-tolerant exec; retry helper carries `current_dir`.
    let mut last: Option<std::io::Result<std::process::Output>> = None;
    for attempt in 0..10 {
        let mut cmd = Command::new(&bin_path);
        cmd.current_dir(&cwd);
        match cmd.output() {
            Ok(o) => {
                last = Some(Ok(o));
                break;
            }
            Err(e) if e.raw_os_error() == Some(26) => {
                std::thread::sleep(std::time::Duration::from_millis(10 * (attempt + 1)));
                last = Some(Err(e));
            }
            Err(e) => {
                last = Some(Err(e));
                break;
            }
        }
    }
    let output = last.unwrap().expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    let _ = std::fs::remove_dir_all(&cwd);
    assert_eq!(output.status.code(), Some(0));
}

#[test]
fn getenv_value_natively() {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("getenv_value.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src)
        .compile()
        .expect("compile getenv_value.c");
    let bytes = emit_native(&program, Target::LinuxAarch64).expect("emit_native");
    let bin_path = super::unique_temp_path("badc-elf-test-getenv", "getenv_value", ".bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    let output = exec_with_retry_envs(&bin_path, &[("C4RS_TEST_GETENV", "Vox")])
        .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    assert_eq!(output.status.code(), Some('V' as i32));
}

#[test]
fn original_c4_compiles_and_runs_hello_natively() {
    // Native ELF counterpart of the macOS `original_c4_compiles_and_runs_hello_natively`.
    // c4.c reads its first user argv entry as the source file to
    // compile-and-run; we hand it the c4-subset self-host fixture and
    // expect the resulting c4-VM run to print "Hello 123" and exit 0.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src).compile().expect("compile c4.c");
    let bytes = emit_native(&program, Target::LinuxAarch64).expect("emit_native");
    let bin_path = super::unique_temp_path("badc-elf-test-c4", "c4", ".bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    // ETXTBUSY-tolerant exec; retry helper carries the argv.
    let arg = concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/tests/fixtures/c/c4_selfhost_hello.c"
    );
    let mut last: Option<std::io::Result<std::process::Output>> = None;
    for attempt in 0..10 {
        match Command::new(&bin_path).arg(arg).output() {
            Ok(o) => {
                last = Some(Ok(o));
                break;
            }
            Err(e) if e.raw_os_error() == Some(26) => {
                std::thread::sleep(std::time::Duration::from_millis(10 * (attempt + 1)));
                last = Some(Err(e));
            }
            Err(e) => {
                last = Some(Err(e));
                break;
            }
        }
    }
    let output = last.unwrap().expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "c4 self-host failed:\nSTDOUT:\n{}\nSTDERR:\n{}",
        String::from_utf8_lossy(&output.stdout),
        String::from_utf8_lossy(&output.stderr)
    );
}

/// Plain `char` is unsigned on Linux/aarch64, so <limits.h> must give
/// CHAR_MAX == UCHAR_MAX (255) and CHAR_MIN == 0 (C99 5.2.4.2.1). The
/// fixture exits 0 only when the header agrees with the runtime signedness;
/// a signed CHAR_MAX (127) here is the bug that broke decimal locale
/// overrides (the `if CHAR_MAX == 127` branch fires on an unsigned target).
#[test]
fn char_limits_match_unsigned_char() {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("char_limits_consistency.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src)
        .compile()
        .expect("compile char_limits_consistency.c");
    let bytes = emit_native(&program, Target::LinuxAarch64).expect("emit_native");
    let bin_path = super::unique_temp_path("badc-elf-char-limits", "char_limits", ".bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);
    let output = exec_with_retry(&bin_path).expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "limits.h CHAR_MIN/CHAR_MAX disagree with unsigned plain char on aarch64 ELF"
    );
}

/// Two units with over-aligned thread-locals on Linux/aarch64: the images
/// are 24 and 80 bytes with 16- and 32-byte objects, so the second block
/// has to start on its alignment and the thread pointer offsets have to
/// take the block size rounded up to `p_align`. Both threads check the
/// addresses; `main` returns a bitmask of failures.
#[test]
fn over_aligned_thread_locals_across_units() {
    use crate::{CompileOptions, Program};

    const UNIT_MAIN: &str = "\
#include <dlfcn.h>\n\
typedef struct __attribute__((aligned(16))) { long a, b; } S16;\n\
_Thread_local S16 wa;\n\
_Thread_local char a;\n\
int check_other(void);\n\
static int check(void) {\n\
    int f = check_other();\n\
    if ((unsigned long)&wa & 15) f |= 1;\n\
    wa.a = 1; a = 2;\n\
    if (wa.a + a != 3) f |= 2;\n\
    return f;\n\
}\n\
static int *thread_main(int *arg) { return (int *)(long)check(); }\n\
int main(void) {\n\
    int *handle; int *create; int *join; long tid; int *retval;\n\
    int f = check();\n\
    handle = dlopen(0, 2);\n\
    create = dlsym(handle, \"pthread_create\");\n\
    join = dlsym(handle, \"pthread_join\");\n\
    create(&tid, 0, thread_main, 0);\n\
    join(tid, &retval);\n\
    return f | ((int)(long)retval << 4);\n\
}\n";

    const UNIT_OTHER: &str = "\
typedef struct __attribute__((aligned(32))) { long a, b, c, d; } S32;\n\
_Thread_local char b;\n\
_Thread_local S32 wb;\n\
_Thread_local char c;\n\
_Thread_local char d;\n\
int check_other(void) {\n\
    int f = 0;\n\
    if ((unsigned long)&wb & 31) f |= 4;\n\
    wb.a = 3; b = 1; c = 1; d = 1;\n\
    if (wb.a + b + c + d != 6) f |= 8;\n\
    return f;\n\
}\n";

    let compile = |src: &str| -> Program {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxAarch64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_main = compile(UNIT_MAIN);
    let prog_other = compile(UNIT_OTHER);
    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_main, &prog_other],
        Target::LinuxAarch64,
        NativeOptions::default(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = super::unique_temp_path("badc-elf-aarch64-tls-align", "over_aligned_tls", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec produced binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "over-aligned thread-locals across units: failure mask {:?}",
        output.status.code()
    );
}

/// Cross-unit `extern _Thread_local` on Linux/aarch64. Two translation
/// units each define TLS storage; `main` reads its own and the other
/// unit's thread-locals both directly (extern) and through the defining
/// unit's accessors (local), then mutates one and re-reads it. Exercises
/// the merged-TLS layout, the `NT_BADC_ELF_TPOFF` note round-trip, and
/// the linker's variant-1 `add` imm12 resolution (`TP + 16 +
/// merged_offset`). `main` returns a bitmask of failures, so exit 0
/// means every access resolved correctly.
#[test]
fn cross_unit_thread_local() {
    use crate::{CompileOptions, Program};

    const UNIT_A: &str = "\
_Thread_local int g_a = 11;\n\
_Thread_local int g_b = 22;\n\
int read_a(void) { return g_a; }\n\
int read_b(void) { return g_b; }\n\
void set_a(int v) { g_a = v; }\n";

    const UNIT_B: &str = "\
extern _Thread_local int g_a;\n\
extern _Thread_local int g_b;\n\
_Thread_local int g_c = 33;\n\
int read_a(void); int read_b(void); void set_a(int);\n\
int main(void) {\n\
    int f = 0;\n\
    if (g_a != 11) f |= 1;\n\
    if (g_b != 22) f |= 2;\n\
    if (g_c != 33) f |= 4;\n\
    if (read_a() != 11) f |= 8;\n\
    if (read_b() != 22) f |= 16;\n\
    set_a(99);\n\
    if (g_a != 99) f |= 32;\n\
    if (read_a() != 99) f |= 64;\n\
    return f;\n\
}\n";

    let compile = |src: &str| -> Program {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxAarch64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_b = compile(UNIT_B);
    let prog_a = compile(UNIT_A);

    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_b, &prog_a],
        Target::LinuxAarch64,
        NativeOptions::default(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = super::unique_temp_path("badc-elf-aarch64-tls2", "cross_unit_tls", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec produced binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "cross-unit thread-local mismatch (failure bitmask in exit code)"
    );
}

/// An inline candidate that returns the address of an extern (cross-TU)
/// data object must keep that symbol reference after the splice. The
/// optimizer inlines `get_shared` into `main`; the spliced `ImmData`
/// has to resolve to `shared_value`, not the caller's local data base.
/// Without carrying the callee's `extern_imm_data_refs`, the inlined
/// address points at the wrong section and the load reads garbage.
#[test]
fn cross_unit_inlined_extern_data_ref() {
    use crate::{CompileOptions, Program};

    const UNIT_A: &str = "long shared_value = 0x12345678;\n";

    const UNIT_B: &str = "\
extern long shared_value;\n\
static long *get_shared(void) { return &shared_value; }\n\
long read_shared(void) { long *p = get_shared(); return *p; }\n\
int main(void) { return (read_shared() == 0x12345678) ? 0 : 1; }\n";

    let compile = |src: &str| -> Program {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxAarch64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_b = compile(UNIT_B);
    let prog_a = compile(UNIT_A);

    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_b, &prog_a],
        Target::LinuxAarch64,
        NativeOptions::default().with_optimize(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = super::unique_temp_path(
        "badc-elf-aarch64-inl-extref",
        "cross_unit_inline_extref",
        ".bin",
    );
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec produced binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "inlined extern-data reference resolved to the wrong symbol under -O"
    );
}

/// Two distinct extern data symbols both lower to `Inst::ImmData(0)`.
/// The cross-block ImmData dedup must not coalesce them: each binds to a
/// different cross-TU symbol, so they hold different addresses. `sym_a`
/// is referenced in the entry block (the dedup canonical for the key)
/// and `sym_b` only in a later block; coalescing makes the later
/// reference read `sym_a`.
#[test]
fn cross_unit_dedup_imm_distinct_symbols() {
    use crate::{CompileOptions, Program};

    const UNIT_A: &str = "long sym_a = 100;\nlong sym_b = 7;\n";

    const UNIT_B: &str = "\
extern long sym_a;\n\
extern long sym_b;\n\
long combine(int c) { long r = sym_a; if (c) { r += sym_b; } return r; }\n\
int main(void) { return (combine(1) == 107) ? 0 : 1; }\n";

    let compile = |src: &str| -> Program {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxAarch64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_b = compile(UNIT_B);
    let prog_a = compile(UNIT_A);

    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_b, &prog_a],
        Target::LinuxAarch64,
        NativeOptions::default().with_optimize(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path =
        super::unique_temp_path("badc-elf-aarch64-dedup-imm", "cross_unit_dedup_imm", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec produced binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "distinct extern data symbols were coalesced by the ImmData dedup under -O"
    );
}

/// Static data DCE (C99 6.2.2 / 6.7.8) must keep an externally-visible
/// global's symbol value consistent with the compacted `.data` it names.
/// The defining unit carries dead static data -- the string literals of
/// two unused static functions -- ahead of a live `extern`-visible array;
/// the prune drops the strings and repacks, moving the array to a lower
/// offset. A second unit reads the array across the TU boundary, so a
/// stale symbol offset (the writer fed a pre-compaction symbol table)
/// would resolve to the wrong bytes.
#[test]
fn cross_unit_data_dce_keeps_extern_global_offset() {
    use crate::{CompileOptions, Program};

    const UNIT_A: &str = "\
static const char *dead_a(void) { return \"dead string A, unreferenced, must be stripped\"; }\n\
static const char *dead_b(void) { return \"dead string B, also unreferenced and stripped\"; }\n\
const long live_arr[3] = { 111, 222, 333 };\n";

    const UNIT_B: &str = "\
extern const long live_arr[3];\n\
long sum_arr(void) { return live_arr[0] + live_arr[1] + live_arr[2]; }\n\
int main(void) { return (sum_arr() == 666) ? 0 : 1; }\n";

    let compile = |src: &str| -> Program {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxAarch64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_b = compile(UNIT_B);
    let prog_a = compile(UNIT_A);

    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_b, &prog_a],
        Target::LinuxAarch64,
        NativeOptions::default(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = super::unique_temp_path("badc-elf-aarch64-data-dce", "cross_unit_data_dce", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec produced binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "extern global moved by data DCE but its symbol offset was not updated to match"
    );
}

/// The AAPCS64 variadic callee prologue spills q0..q7 into the vector
/// half of the register save area unconditionally (AAPCS64 has no
/// caller-passed vector count). A freestanding aarch64 environment runs
/// with CPACR_EL1.FPEN trapping, so each `str dN` raises a synchronous
/// exception before the kernel can report it. Under `no_fp_regs`
/// (`-mgeneral-regs-only`) the object must contain none of the eight
/// stores; the default object contains all eight. The area stays
/// reserved, so every offset above it is unchanged.
#[test]
fn variadic_prologue_no_fp_regs_omits_vector_save_aarch64() {
    use crate::{CompileOptions, OutputKind};

    const SRC: &str = "int sum(int n, ...) {\n\
         \t__builtin_va_list ap;\n\
         \t__builtin_va_start(ap, n);\n\
         \tint t = 0;\n\
         \tfor (int i = 0; i < n; i++) t += __builtin_va_arg(ap, int);\n\
         \t__builtin_va_end(ap);\n\
         \treturn t;\n\
         }\n";
    let emit = |no_fp_regs: bool| -> Vec<u8> {
        let prog = Compiler::with_options(
            SRC.to_string(),
            Target::LinuxAarch64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .unwrap_or_else(|e| panic!("compile variadic callee: {e}"));
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            no_fp_regs,
            ..NativeOptions::default()
        };
        emit_native_with_options(&prog, Target::LinuxAarch64, opts)
            .unwrap_or_else(|e| panic!("emit object (no_fp_regs={no_fp_regs}): {e}"))
    };
    // `str dN, [sp, #imm]` is 0xfd0000?? little-endian; count the eight
    // save-area stores by their encodings.
    let stores: Vec<[u8; 4]> = (0..8u32)
        .map(|i| {
            let imm12 = (64 + i * 16) / 8;
            let insn: u32 = 0xfd00_0000 | (imm12 << 10) | (31 << 5) | i;
            insn.to_le_bytes()
        })
        .collect();
    let count = |obj: &[u8]| -> usize {
        stores
            .iter()
            .filter(|s| obj.windows(4).any(|w| w == s.as_slice()))
            .count()
    };
    assert_eq!(
        count(&emit(false)),
        8,
        "default object lacks the vector save"
    );
    assert_eq!(
        count(&emit(true)),
        0,
        "no_fp_regs object still contains the vector save stores"
    );
}

/// Executed companion to the encoding check: the narrowed copy must
/// still move every byte. Runs the strict-align lowering over struct
/// alignments 8, 4, 2 and 1 -- one transfer width each -- plus a size
/// that leaves a sub-unit tail.
#[test]
fn strict_align_aggregate_copy_moves_every_byte_aarch64() {
    const SRC: &str = "struct A8 { long long a, b; };\n\
         struct A4 { int a, b, c; };\n\
         struct A2 { short a[5]; };\n\
         struct A1 { char a[13]; };\n\
         int check(void) {\n\
         \tstruct A8 s8 = {0x1122334455667788LL, 0x99aabbccddeeff00LL}, d8;\n\
         \tstruct A4 s4 = {0x11223344, 0x55667788, 0x99aabbcc}, d4;\n\
         \tstruct A2 s2 = {{1, 2, 3, 4, 5}}, d2;\n\
         \tstruct A1 s1 = {{1,2,3,4,5,6,7,8,9,10,11,12,13}}, d1;\n\
         \td8 = s8; d4 = s4; d2 = s2; d1 = s1;\n\
         \tconst char *p = (const char *)&s8, *q = (const char *)&d8;\n\
         \tfor (int i = 0; i < (int)sizeof s8; i++) if (p[i] != q[i]) return 1;\n\
         \tp = (const char *)&s4; q = (const char *)&d4;\n\
         \tfor (int i = 0; i < (int)sizeof s4; i++) if (p[i] != q[i]) return 2;\n\
         \tp = (const char *)&s2; q = (const char *)&d2;\n\
         \tfor (int i = 0; i < (int)sizeof s2; i++) if (p[i] != q[i]) return 3;\n\
         \tp = (const char *)&s1; q = (const char *)&d1;\n\
         \tfor (int i = 0; i < (int)sizeof s1; i++) if (p[i] != q[i]) return 4;\n\
         \treturn 42;\n\
         }\n\
         int main(void) { return check(); }\n";
    for optimize in [false, true] {
        let opts = NativeOptions {
            strict_align: true,
            optimize,
            ..NativeOptions::default()
        };
        let outcome = build_and_run_outcome_with_options(SRC, "strict-align-copy", opts);
        assert!(
            outcome.matches(42),
            "strict-align struct copy (optimize={optimize}): {outcome:?}"
        );
    }
}

/// A frame past the 24-bit reach of the immediate `ADD`/`SUB`, driven
/// through an `always_inline` helper (no size or frame budget applies to
/// one). The probed prologue, the register-form teardown and the
/// materialised slot addresses must all agree. The indices come from
/// `argc` so the buffer survives store forwarding. Runs under a raised
/// stack limit so the frame fits.
#[test]
fn frame_past_the_immediate_reach_runs() {
    const SIZE: usize = 20_000_000;
    let src = format!(
        "static __attribute__((always_inline)) inline long helper(char *p, long i, long j) {{\n\
             p[i] = 2;\n\
             p[j] = 3;\n\
             return (long)p[i] + (long)p[j];\n\
         }}\n\
         int main(int argc, char **argv) {{\n\
             char buf[{SIZE}];\n\
             long i;\n\
             long j;\n\
             (void)argv;\n\
             i = argc & 0xffff;\n\
             j = (long)sizeof buf - i;\n\
             return (int)helper(buf, i, j);\n\
         }}\n"
    );

    let program = Compiler::new(super::with_prelude(&src))
        .compile()
        .expect("compile");
    let bytes = emit_native_with_options(
        &program,
        Target::LinuxAarch64,
        NativeOptions::new().with_optimize(),
    )
    .expect("emit_native");
    // `add sp, sp, x16` -- the immediate forms top out at 16 MiB.
    assert!(
        bytes.windows(4).any(|w| w == 0x8B30_63FFu32.to_le_bytes()),
        "expected the register-form stack teardown"
    );

    let path = super::unique_temp_path("badc-elf-aarch64-frame", "large_frame", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = super::output_when_not_busy(|| {
        let mut c = Command::new("sh");
        c.arg("-c")
            .arg(format!("ulimit -s 65536 && exec {}", path.display()));
        c
    });
    let meta = std::fs::metadata(&path).map(|m| m.len());
    let _ = std::fs::remove_file(&path);
    // The shell's own failure codes are indistinguishable from the
    // program's without its stderr: 126 is "cannot execute" and 127 is
    // "not found", neither of which says anything about the frame this
    // test is about. Report what the shell said, and the image size, so a
    // failure names its own cause instead of only its exit code.
    assert_eq!(
        output.status.code(),
        Some(5),
        "a frame past the immediate stack-adjustment reach miscomputed; \
         image {meta:?} bytes, stderr {:?}",
        String::from_utf8_lossy(&output.stderr),
    );
}

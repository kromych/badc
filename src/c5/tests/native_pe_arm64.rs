//! End-to-end Windows/AArch64 PE tests.
//!
//! Compile a c5 program to a PE32+ binary with `Machine =
//! IMAGE_FILE_MACHINE_ARM64`, drop it in `tmp`, and execute it.
//! Two host paths run the same surface:
//!
//! * On `windows-aarch64` the binary runs natively via
//!   `Command::new(path.exe)`.
//! * On `linux-aarch64` the binary runs through WINE 10's
//!   `aarch64-windows` DLL set, *but only when `BADC_RUN_WINE=1`
//!   is set in the environment*. The default `cargo test` skips
//!   the wine lane; CI sets `BADC_RUN_WINE=1` on the wine-installed
//!   `ubuntu-24.04-arm` job so the cross-check still runs.
//!
//! On the GitHub Actions matrix the `windows-11-arm` runner runs
//! the suite natively. WINE on Apple Silicon ships only the
//! `x86_64-windows` and `i386-windows` DLL sets, not
//! `aarch64-windows`, so macOS hosts only get the format-
//! validation check in [`super::super::codegen::pe::tests`].

#![cfg(any(
    all(target_os = "windows", target_arch = "aarch64"),
    all(target_os = "linux", target_arch = "aarch64"),
))]

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::Command;

use super::fixture_tables::NATIVE_PE_ARM64_FIXTURES;
use crate::{Compiler, NativeOptions, Target};

/// On Windows we run the binary directly; on Linux we go through
/// WINE if the environment opts in via `BADC_RUN_WINE`. Returns
/// `None` when wine execution isn't enabled (so the test skips
/// gracefully instead of panicking) or when the binary isn't on
/// disk.
fn run_pe(path: &Path, args: &[&str]) -> Option<std::io::Result<std::process::Output>> {
    #[cfg(target_os = "windows")]
    {
        Some(Command::new(path).args(args).output())
    }
    #[cfg(target_os = "linux")]
    {
        if !wine_enabled() {
            return None;
        }
        let wine = wine_binary()?;
        Some(Command::new(&wine).arg(path).args(args).output())
    }
}

/// True iff the user explicitly opted in to running PE binaries
/// through WINE for this `cargo test` invocation. Off by default
/// so a casual `cargo test` on a wine-installed Linux box doesn't
/// silently shell out to wine for half the suite.
#[cfg(target_os = "linux")]
fn wine_enabled() -> bool {
    matches!(std::env::var("BADC_RUN_WINE"), Ok(v) if !v.is_empty() && v != "0")
}

/// `which wine` on Linux. The Ubuntu wine 10 package puts it at
/// `/usr/bin/wine`; we also fall back to PATH.
#[cfg(target_os = "linux")]
fn wine_binary() -> Option<PathBuf> {
    let p = PathBuf::from("/usr/bin/wine");
    if p.exists() {
        return Some(p);
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
/// binary. On Windows the answer is always yes; on Linux it
/// depends on whether `BADC_RUN_WINE` is set *and* WINE is
/// installed.
fn host_can_run_pe() -> bool {
    #[cfg(target_os = "windows")]
    {
        true
    }
    #[cfg(target_os = "linux")]
    {
        wine_enabled() && wine_binary().is_some()
    }
}

#[derive(Debug)]
#[allow(dead_code)]
enum RunOutcome {
    Exit(i32),
    Signal(i32),
    BuildError(String),
    /// Host can't execute PE binaries (Linux without wine
    /// installed). The test should skip rather than fail.
    HostCannotRun,
}

impl RunOutcome {
    fn matches(&self, expected: i32) -> bool {
        matches!(self, RunOutcome::Exit(c) if *c == expected)
    }
}

fn build_and_run(src: &str, stem: &str, args: &[&str]) -> RunOutcome {
    build_and_run_with_options(src, stem, args, NativeOptions::default())
}

fn build_and_run_with_options(
    src: &str,
    stem: &str,
    args: &[&str],
    opts: NativeOptions,
) -> RunOutcome {
    // Compile with the same target the codegen will lower for, so
    // the per-target header (`headers/badc-windows-arm64.h`) is the
    // one whose `#pragma dylib` / `#pragma binding` directives end
    // up on `program.dylibs` and whose `#define __BADC_WINDOWS__` reaches
    // any conditional source. Using the default `Compiler::new` would
    // load the macOS header and silently feed the wrong bindings
    // to the codegen.
    // Compile as a relocatable TU (no entry-point synthesis), matching
    // the CLI's user-source path, so `environ` stays an extern
    // reference resolved by the runtime rather than a tentative def
    // that collides with `runtime.c` at link time.
    let copts = crate::CompileOptions::default().with_no_entry_point(true);
    let program =
        match Compiler::with_options(super::with_prelude(src), Target::WindowsAarch64, copts)
            .compile()
        {
            Ok(p) => p,
            Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
        };
    let bytes = match super::link_executable_with_runtime(&program, Target::WindowsAarch64, opts) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let path = unique_temp_path("badc-pe-arm64-test", stem);
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
fn c5_internal_variadic_sum_runs() {
    // End-to-end correctness of the Windows-on-ARM64 host variadic ABI
    // (Microsoft ARM64 calling convention): a c5-internal variadic sum
    // over one named and three variadic integer arguments returns their
    // total. The caller places the arguments in x0..x7 by position, the
    // callee spills x0..x7 into its gr-save area, and va_arg walks the
    // 8-byte-stride region. Skips without a PE host (no wine); the
    // parent drives the Windows-on-ARM64 run.
    let src = r#"
        #include <stdarg.h>
        int vsum(int count, ...) {
            va_list ap;
            int total;
            int i;
            total = 0;
            va_start(ap, count);
            for (i = 0; i < count; i = i + 1)
                total = total + va_arg(ap, int);
            va_end(ap);
            return total;
        }
        int main(void) { return vsum(3, 10, 20, 30); }
    "#;
    assert_exit(src, "c5varsum", &[], 60);
}

#[test]
fn c5_internal_variadic_sum_crosses_stack_overflow_runs() {
    // The variadic tail spans the gr-save area and the incoming stack
    // overflow: with one named argument and ten variadic ones the first
    // seven variadic arguments ride x1..x7 (the gr-save area) and the
    // last three ride the incoming stack. A correct va_arg cursor walks
    // the gr-save area then crosses into the stack arguments with no gap
    // (the save-area top edge meets the incoming arguments). Sum of
    // 1..10 is 55.
    let src = r#"
        #include <stdarg.h>
        int vsum(int count, ...) {
            va_list ap;
            int total;
            int i;
            total = 0;
            va_start(ap, count);
            for (i = 0; i < count; i = i + 1)
                total = total + va_arg(ap, int);
            va_end(ap);
            return total;
        }
        int main(void) { return vsum(10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10); }
    "#;
    assert_exit(src, "c5varsum_overflow", &[], 55);
}

#[test]
fn printf_through_iat() {
    // Exits with the byte count printf returned for "42\n" -- 3 on
    // Windows since msvcrt's printf returns the printed-char count.
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
    let src = r#"int main(int argc, char **argv) { return argc; }"#;
    assert_exit(src, "argc", &["one", "two", "three"], 4);
}

/// Locate the `.text` section bytes in a PE32+ image by walking the
/// section table. Used to inspect the emitted TLS access sequence.
fn pe_text_section(bytes: &[u8]) -> &[u8] {
    let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
    let coff_off = pe_off + 4;
    let n_sections = u16::from_le_bytes([bytes[coff_off + 2], bytes[coff_off + 3]]) as usize;
    let optional_size = u16::from_le_bytes([bytes[coff_off + 16], bytes[coff_off + 17]]) as usize;
    let sections_off = coff_off + 20 + optional_size;
    for i in 0..n_sections {
        let h = sections_off + i * 40;
        if &bytes[h..h + 5] == b".text" {
            let v_size = u32::from_le_bytes(bytes[h + 8..h + 12].try_into().unwrap()) as usize;
            let raw_size = u32::from_le_bytes(bytes[h + 16..h + 20].try_into().unwrap()) as usize;
            let p_off = u32::from_le_bytes(bytes[h + 20..h + 24].try_into().unwrap()) as usize;
            let n = v_size.min(raw_size);
            return &bytes[p_off..p_off + n];
        }
    }
    panic!(".text section not found in PE image");
}

/// Cross-unit `extern _Thread_local` on Windows/AArch64. One unit
/// defines the thread-local storage; `main` in another reads it through
/// an `extern` declaration (the cross-unit access the codegen lowers to
/// a TEB-indexed sequence with a link-patched offset) and through the
/// defining unit's accessor (a unit-local access). The linker resolves
/// the extern access's `add` imm12 against the merged TLS layout. The
/// test asserts the link succeeds, that the emitted access reads the TEB
/// TLS array at `[x18, #0x58]` and ends in an `add x?, x16, #imm12` whose
/// immediate the linker filled to a non-zero value, and -- when a PE
/// runner is available -- that the program exits 0 (its exit code is a
/// failure bitmask over the checks).
#[test]
fn cross_unit_thread_local() {
    let copts = crate::CompileOptions::default().with_no_entry_point(true);
    let compile = |src: &str| -> crate::Program {
        Compiler::with_options(
            super::with_prelude(src),
            Target::WindowsAarch64,
            copts.clone(),
        )
        .compile()
        .unwrap_or_else(|e| panic!("compile: {e}"))
    };

    const UNIT_DEF: &str = "\
_Thread_local int g_a = 11;\n\
_Thread_local int g_b = 22;\n\
int read_a(void) { return g_a; }\n\
void set_a(int v) { g_a = v; }\n";

    const UNIT_MAIN: &str = "\
extern _Thread_local int g_a;\n\
extern _Thread_local int g_b;\n\
int read_a(void); void set_a(int);\n\
int main(void) {\n\
    int f = 0;\n\
    if (g_a != 11) f |= 1;\n\
    if (g_b != 22) f |= 2;\n\
    if (read_a() != 11) f |= 4;\n\
    set_a(99);\n\
    if (g_a != 99) f |= 8;\n\
    if (read_a() != 99) f |= 16;\n\
    return f;\n\
}\n";

    let prog_main = compile(UNIT_MAIN);
    let prog_def = compile(UNIT_DEF);

    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_main, &prog_def],
        Target::WindowsAarch64,
        NativeOptions::default(),
    )
    .unwrap_or_else(|e| panic!("link cross-unit TLS: {e}"));

    // The TEB-indexed access opens with `ldr x16, [x18, #0x58]` and ends
    // four words later in `add x?, x16, #imm12`. The extern access leaves
    // the imm12 at 0 for the linker to patch, so at least one such `add`
    // must carry a non-zero offset after the link.
    let text = pe_text_section(&bytes);
    const TEB_LOAD: u32 = 0xF940_2E50; // ldr x16, [x18, #0x58]
    let mut teb_loads = 0usize;
    let mut patched_add = false;
    let mut i = 0;
    while i + 4 <= text.len() {
        let w = u32::from_le_bytes(text[i..i + 4].try_into().unwrap());
        if w == TEB_LOAD {
            teb_loads += 1;
            // add x?, x16, #imm12 : opcode 0x91, rn (bits 5..10) == 16.
            let add_off = i + 16;
            if add_off + 4 <= text.len() {
                let a = u32::from_le_bytes(text[add_off..add_off + 4].try_into().unwrap());
                let is_add_imm = (a & 0xFF80_0000) == 0x9100_0000;
                let rn = (a >> 5) & 0x1F;
                let imm12 = (a >> 10) & 0xFFF;
                if is_add_imm && rn == 16 && imm12 != 0 {
                    patched_add = true;
                }
            }
        }
        i += 4;
    }
    assert!(
        teb_loads >= 1,
        "expected at least one TEB TLS-array load `ldr x16, [x18, #0x58]`"
    );
    assert!(
        patched_add,
        "expected a TEB-indexed `add x?, x16, #imm12` with a link-patched non-zero offset"
    );

    let path = unique_temp_path("badc-pe-arm64-test", "cross_unit_tls");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    let outcome = run_pe(&path, &[]);
    let _ = std::fs::remove_file(&path);
    match outcome {
        Some(Ok(o)) => assert_eq!(
            o.status.code(),
            Some(0),
            "cross-unit thread-local mismatch (failure bitmask in exit code); stderr: {}",
            String::from_utf8_lossy(&o.stderr)
        ),
        Some(Err(e)) => panic!("exec cross-unit TLS PE: {e}"),
        None => eprintln!("skip cross_unit_thread_local run: no PE runner on this host"),
    }
}

/// A `_Thread_local` defined in a TU that is not first in TLS layout must
/// have its LOCAL accesses (writes and reads within the defining TU)
/// resolve to the same merged offset as EXTERN accesses from other TUs. A
/// pad TU with its own TLS data forces the definer off TLS base 0; if the
/// local path baked the raw block offset while the extern path rebased to
/// the merged offset, a local write and an extern read hit different slots.
#[test]
fn cross_unit_thread_local_rebased() {
    let copts = crate::CompileOptions::default().with_no_entry_point(true);
    let compile = |src: &str| -> crate::Program {
        Compiler::with_options(
            super::with_prelude(src),
            Target::WindowsAarch64,
            copts.clone(),
        )
        .compile()
        .unwrap_or_else(|e| panic!("compile: {e}"))
    };

    const UNIT_PAD: &str = "\
_Thread_local long long pad0 = 0x100;\n\
_Thread_local long long pad1 = 0x200;\n\
long long read_pad(void) { return pad0 + pad1; }\n";

    const UNIT_DEF: &str = "\
_Thread_local int g_a = 11;\n\
_Thread_local int g_b = 22;\n\
int read_a(void) { return g_a; }\n\
void set_a(int v) { g_a = v; }\n";

    const UNIT_MAIN: &str = "\
extern _Thread_local int g_a;\n\
extern _Thread_local int g_b;\n\
int read_a(void); void set_a(int);\n\
long long read_pad(void);\n\
int main(void) {\n\
    int f = 0;\n\
    if (read_pad() != 0x300) f |= 32;\n\
    if (g_a != 11) f |= 1;\n\
    if (g_b != 22) f |= 2;\n\
    if (read_a() != 11) f |= 4;\n\
    set_a(99);\n\
    if (g_a != 99) f |= 8;\n\
    if (read_a() != 99) f |= 16;\n\
    return f;\n\
}\n";

    let prog_main = compile(UNIT_MAIN);
    let prog_pad = compile(UNIT_PAD);
    let prog_def = compile(UNIT_DEF);

    // Link order places the pad TU's TLS (16 bytes) before the definer's,
    // so the definer's block starts at merged offset 16.
    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_main, &prog_pad, &prog_def],
        Target::WindowsAarch64,
        NativeOptions::default(),
    )
    .unwrap_or_else(|e| panic!("link cross-unit TLS rebased: {e}"));

    // The pad pushes the definer's vars to offset >= 16, so at least one
    // TEB-indexed `add x?, x16, #imm12` must carry imm12 >= 16. The pad's
    // own accesses sit at offsets 0 and 8, so this is unique to the rebase.
    let text = pe_text_section(&bytes);
    const TEB_LOAD: u32 = 0xF940_2E50; // ldr x16, [x18, #0x58]
    let mut rebased_add = false;
    let mut i = 0;
    while i + 4 <= text.len() {
        let w = u32::from_le_bytes(text[i..i + 4].try_into().unwrap());
        if w == TEB_LOAD {
            let add_off = i + 16;
            if add_off + 4 <= text.len() {
                let a = u32::from_le_bytes(text[add_off..add_off + 4].try_into().unwrap());
                let is_add_imm = (a & 0xFF80_0000) == 0x9100_0000;
                let rn = (a >> 5) & 0x1F;
                let imm12 = (a >> 10) & 0xFFF;
                if is_add_imm && rn == 16 && imm12 >= 16 {
                    rebased_add = true;
                }
            }
        }
        i += 4;
    }
    assert!(
        rebased_add,
        "expected a TEB-indexed `add x?, x16, #imm12` with imm12 >= 16 (definer rebased past the pad)"
    );

    let path = unique_temp_path("badc-pe-arm64-test", "cross_unit_tls_rebased");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    let outcome = run_pe(&path, &[]);
    let _ = std::fs::remove_file(&path);
    match outcome {
        Some(Ok(o)) => assert_eq!(
            o.status.code(),
            Some(0),
            "rebased cross-unit thread-local mismatch (failure bitmask in exit code); stderr: {}",
            String::from_utf8_lossy(&o.stderr)
        ),
        Some(Err(e)) => panic!("exec rebased cross-unit TLS PE: {e}"),
        None => eprintln!("skip cross_unit_thread_local_rebased run: no PE runner on this host"),
    }
}

// ---------------- fixture parity ----------------

fn build_and_run_fixture(name: &str) -> RunOutcome {
    build_and_run_fixture_with_options(name, NativeOptions::default(), "")
}

fn build_and_run_fixture_with_options(name: &str, opts: NativeOptions, suffix: &str) -> RunOutcome {
    let mut path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let stem = name.trim_end_matches(".c");
    build_and_run_with_options(&src, &format!("fixture-{stem}{suffix}"), &[name], opts)
}

#[test]
fn fixture_parity() {
    if !host_can_run_pe() {
        eprintln!("skip fixture_parity: no PE runner on this host");
        return;
    }
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_PE_ARM64_FIXTURES {
        let outcome = build_and_run_fixture(name);
        if !outcome.matches(*expected) {
            failures.push(format!("{name}: expected {expected}, got {outcome:?}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} PE/aarch64 fixtures regressed:\n  {}",
        failures.len(),
        NATIVE_PE_ARM64_FIXTURES.len(),
        failures.join("\n  ")
    );
}

#[test]
fn fixture_parity_native_optimized() {
    if !host_can_run_pe() {
        eprintln!("skip fixture_parity_native_optimized: no PE runner on this host");
        return;
    }
    let opts = NativeOptions::new().with_optimize();
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_PE_ARM64_FIXTURES {
        let outcome = build_and_run_fixture_with_options(name, opts, "-O");
        if !outcome.matches(*expected) {
            failures.push(format!("{name} (-O): expected {expected}, got {outcome:?}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} PE/aarch64 fixtures regressed under -O:\n  {}",
        failures.len(),
        NATIVE_PE_ARM64_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// AAPCS64 / Win64 leave the upper bits of X0 (or RAX)
/// unspecified for sub-word libc returns; c5's 64-bit
/// accumulator needs the post-call `sxtw` / `movsxd` emitted by
/// `emit_extend_x19_for_return` so a downstream `acc != -17`
/// compare matches. The same fixture runs on every native lane
/// (Mach-O, ELF, PE); this is the PE/AArch64 instance.
#[test]
fn atoi_negative_sign_extends() {
    if !host_can_run_pe() {
        eprintln!("skip atoi_negative_sign_extends: no PE runner on this host");
        return;
    }
    let mut path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("atoi_negative.c");
    let src = std::fs::read_to_string(&path).expect("read fixture");
    let outcome = build_and_run(&src, "atoi-negative", &[]);
    match outcome {
        RunOutcome::Exit(c) => assert_eq!(c, 0, "atoi('-17') should sign-extend to -1 in i64"),
        RunOutcome::Signal(s) => panic!("atoi-negative killed by signal {s}"),
        RunOutcome::BuildError(e) => panic!("atoi-negative build error: {e}"),
        RunOutcome::HostCannotRun => {}
    }
}

#[test]
fn original_c4_compiles_and_runs_hello_pe() {
    if !host_can_run_pe() {
        eprintln!("skip c4 self-host: no PE runner on this host");
        return;
    }
    let mut path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).expect("read c4.c");
    let mut hello_path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    hello_path.push("tests");
    hello_path.push("fixtures");
    hello_path.push("c");
    hello_path.push("c4_selfhost_hello.c");
    let outcome = build_and_run(
        &src,
        "c4-self-host",
        &[hello_path.to_str().expect("hello.c path is utf-8")],
    );
    match outcome {
        RunOutcome::Exit(c) => assert_eq!(c, 0, "c4 self-host PE-arm64 exited {c}"),
        RunOutcome::Signal(s) => panic!("c4 self-host PE-arm64 killed by signal {s}"),
        RunOutcome::BuildError(e) => panic!("c4 self-host PE-arm64 build error: {e}"),
        RunOutcome::HostCannotRun => {} // already logged above
    }
}

#[test]
fn dll_export_load_unload_reload_cycle() {
    // A c5-built loader EXE resolves a c5-built DLL at runtime through
    // LoadLibraryA + GetProcAddress, calls the export, FreeLibrary's
    // it, then repeats the load / call / unload once more. Exercises
    // the PE export directory (GetProcAddress by name) and a clean
    // unload followed by a reload of a c5 shared library. The DLL sits
    // beside the loader in the temp directory and is loaded by bare
    // name, which the loader's application directory resolves.
    use std::sync::atomic::{AtomicU64, Ordering};
    static N: AtomicU64 = AtomicU64::new(0);
    let uniq = format!(
        "{}-{}",
        std::process::id(),
        N.fetch_add(1, Ordering::Relaxed)
    );

    let dll_src = "int answer(void) { return 42; }\n#pragma export(answer)\n";
    let dll_prog = Compiler::with_target(dll_src.to_string(), Target::WindowsAarch64)
        .compile()
        .expect("compile dll");
    let dll_name = format!("badc-pe-arm64-ansdll-{uniq}.dll");
    // Record the DLL's own name in its export directory, as the CLI
    // does from the `-o` basename. Native Windows validates the
    // export-directory Name pointer at load and rejects a DLL emitted
    // without one (ERROR_INVALID_PARAMETER); wine tolerates it.
    let dll_bytes = super::super::object::emit_native_with_options_named(
        &dll_prog,
        Target::WindowsAarch64,
        NativeOptions::new().with_shared_library(),
        Some(&dll_name),
    )
    .expect("emit dll");
    let dll_path = std::env::temp_dir().join(&dll_name);
    std::fs::write(&dll_path, &dll_bytes).expect("write dll");

    let loader_src = format!(
        r#"#include <windows.h>
typedef int (*answer_fn)(void);
int main(void) {{
    HANDLE h = LoadLibraryA("{dll}");
    if (!h) return 1;
    answer_fn f = (answer_fn)GetProcAddress(h, "answer");
    if (!f) {{ FreeLibrary(h); return 2; }}
    int r = f();
    if (!FreeLibrary(h)) return 3;
    HANDLE h2 = LoadLibraryA("{dll}");
    if (!h2) return 4;
    answer_fn f2 = (answer_fn)GetProcAddress(h2, "answer");
    if (!f2) {{ FreeLibrary(h2); return 5; }}
    r += f2();
    FreeLibrary(h2);
    return r;
}}
"#,
        dll = dll_name
    );
    let loader_prog = Compiler::with_options(
        loader_src,
        Target::WindowsAarch64,
        crate::CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile loader");
    let loader_bytes = super::link_executable_with_runtime(
        &loader_prog,
        Target::WindowsAarch64,
        NativeOptions::default(),
    )
    .expect("emit loader");
    let loader_path = std::env::temp_dir().join(format!("badc-pe-arm64-ansloader-{uniq}.exe"));
    std::fs::write(&loader_path, &loader_bytes).expect("write loader");

    let outcome = run_pe(&loader_path, &[]);
    let _ = std::fs::remove_file(&dll_path);
    let _ = std::fs::remove_file(&loader_path);
    match outcome {
        Some(Ok(o)) => {
            let code = o.status.code();
            assert_eq!(
                code,
                Some(84),
                "loader exit {:?} != 84 (42 + 42 over a load / unload / reload cycle); stderr: {}",
                code,
                String::from_utf8_lossy(&o.stderr)
            );
        }
        Some(Err(e)) => panic!("exec loader PE: {e}"),
        None => eprintln!("skip dll_export_load_unload_reload_cycle: no PE runner on this host"),
    }
}

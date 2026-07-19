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

/// Same fixture set as `native_pe_x64`, since the Windows-flavored
/// limitations (POSIX-only setenv shape, dlopen-against-libc-soname)
/// are arch-independent.
const NATIVE_PE_ARM64_FIXTURES: &[(&str, i32)] = &[
    ("vla_basic_sum.c", 0),
    ("vla_runtime_sizeof.c", 0),
    ("vla_size_from_arg.c", 0),
    ("vla_scope_reclaim_loop.c", 0),
    ("vla_param_decay.c", 0),
    ("arithmetic.c", 60),
    ("compound_literal_struct_field.c", 0),
    ("strtof_parses_float.c", 0),
    ("snprintf_truncation_c99.c", 0),
    // Runtime CRT shim: POSIX setenv overwrite semantics over msvcrt's
    // 2-parameter _putenv_s.
    ("setenv_overwrite.c", 0),
    ("control_flow.c", 1),
    ("do_while.c", 5),
    ("break_continue.c", 4),
    ("for_loop.c", 10),
    ("for_init_stmt_expr_nested_stmt.c", 6),
    ("layout_bottom_test_loop.c", 45),
    ("layout_nested_loops.c", 27),
    ("layout_goto_block_addr.c", 16),
    ("unroll_const_trip_copy.c", 0),
    ("unroll_trip_17_stays_rolled.c", 0),
    ("unroll_volatile_stays_rolled.c", 0),
    ("sroa_const_index_local_array.c", 0),
    ("sroa_runtime_index_stays_memory.c", 0),
    ("goto.c", 5),
    ("recursion_factorial.c", 120),
    ("pointers.c", 200),
    ("pointer_arithmetic.c", 3),
    ("pointer_arithmetic_scaling.c", 104), // sizeof(int) = 4
    ("expression_precedence.c", 1),
    ("variable_shadowing.c", 10),
    ("predefined_constants.c", 0),
    ("c99_qualifiers.c", 0),
    ("integer_suffixes.c", 0),
    ("predefined_macros.c", 0),
    ("macro_multiline_comment_body.c", 0),
    ("compound_literal_paren_init.c", 0),
    ("alignof_operator.c", 0),
    ("return_void_expression.c", 0),
    ("macro_operators.c", 0),
    ("typedef_basic.c", 0),
    ("ptr_to_array_typedef.c", 42),
    ("local_init_and_block_scope.c", 0),
    ("arrays_basic.c", 0),
    ("function_pointer_typedefs.c", 0),
    ("unions_basic.c", 0),
    ("array_initializers.c", 0),
    ("local_array_partial_init_zero.c", 0),
    ("ssa_call_result_spill.c", 0),
    ("struct_field_assign_from_call.c", 0),
    ("struct_byval_param_followed_by_ptr.c", 0),
    ("tail_call_no_address_escape.c", 0),
    ("fib.c", 0),
    ("tailrec_narrow_param.c", 0),
    ("tailrec_void_accumulate.c", 0),
    ("queens.c", 0),
    ("inline_keyword_uncaps.c", 0),
    ("ssa_bail_fixup_rollback.c", 0),
    ("ssa_fp_routing.c", 0),
    ("ssa_callee_saved_x19.c", 0),
    ("ssa_va_arg_loop.c", 0),
    ("ssa_variadic_fp_arg.c", 0),
    ("ssa_fp_compare_nan.c", 0),
    ("ssa_c5_internal_fp_arg.c", 0),
    ("struct_initializers.c", 0),
    ("enum_tag_types.c", 0),
    ("bitfields.c", 0),
    ("bound_import_arg_narrowing.c", 0),
    ("block_extern_shadows_local.c", 0),
    ("win64_xmm_scratch_callee_save.c", 0),
    ("variadic_fnptr_proto_erased.c", 0),
    ("union_bitfield_layout.c", 0),
    ("init_float_to_int.c", 0),
    ("global_init_midexpr_cast_narrow.c", 0),
    ("init_brace_intermediate_cast.c", 0),
    ("dead_local_load_frame_elide.c", 0),
    ("narrow_param_entry_extend.c", 0),
    ("qsort_scan_extend_dedup.c", 0),
    ("tailcall_return_extension.c", 0),
    ("fnptr_array_call.c", 0),
    ("call_arg_extend_drop.c", 0),
    ("indirect_call_narrow_scalar_args.c", 0),
    ("indirect_call_ten_scalar_args.c", 0),
    ("indirect_call_mixed_fp_int_args.c", 0),
    ("float_param_stack_overflow.c", 0),
    ("indirect_call_variadic_fp_control.c", 0),
    ("ternary_arith_conversion.c", 0),
    ("struct_layout.c", 0),
    ("const_expr_conditional.c", 27),
    ("comma_operator_in_loops.c", 3),
    ("size_t_via_stdio.c", 3),
    ("ndebug_optimize_predefine.c", 100),
    ("leading_dot_float_literal.c", 7),
    ("libc_fp_return_value.c", 11),
    ("libc_fp_classify.c", 0),
    ("libc_math_fdim_scalbn.c", 0),
    ("libc_fileno_isblank.c", 0),
    ("pragma_entrypoint.c", 23),
    ("struct_field_enum_type.c", 13),
    ("compound_assign_fp_int_rhs.c", 17),
    ("optimizer_fp_arg_mask_remap.c", 19),
    ("many_args_host_stack_overflow.c", 0),
    ("variadic_optimizer_survives.c", 0),
    ("struct_2d_array_field.c", 27),
    ("anonymous_aggregates.c", 0),
    ("static_locals.c", 0),
    ("large_stack_frame.c", 42),
    ("octal_literal.c", 42),
    ("short_types.c", 42),
    ("long_long_distinct.c", 0),
    ("signed_cast_extends.c", 0),
    ("fn_ptr_struct_return.c", 0),
    ("static_init_struct_fp_call.c", 0),
    ("libc_data_globals.c", 0),
    ("stdint_widths.c", 0),
    ("fd_set_macros.c", 0),
    ("fn_ptr_explicit_deref.c", 42),
    ("fn_ptr_decay_inside_block.c", 0),
    ("switch_nested_case_in_compound.c", 0),
    ("switch_jump_table_dense.c", 0),
    ("switch_jump_table_sparse_kept.c", 0),
    ("switch_jumptable_dead_branch_prune.c", 12),
    ("switch_jump_table_phi_join.c", 0),
    ("ternary_middle_comma.c", 0),
    ("local_init_int_to_float.c", 0),
    ("libc_basic.c", 0),
    ("static_init_cast_funcptr.c", 0),
    ("memset_mcmp.c", 42),
    ("memcpy_basic.c", 'A' as i32),
    ("struct_basic.c", 25),
    ("struct_linked_list.c", 10),
    ("global_initializer_int.c", 141),
    ("global_initializer_pointer.c", 0),
    ("static_linked_list.c", 0),
    ("struct_sizeof.c", 0),
    ("memory_ops.c", 0),
    ("linked_list.c", 10),
    ("double_pointers.c", 0),
    ("function_pointers.c", 150),
    ("nested_function_calls.c", 100),
    ("quicksort.c", 0),
    ("loop_iv_spill_priority.c", 40),
    ("binary_search_tree.c", 0),
    ("bst_free.c", 0),
    ("cast_to_struct_pointer.c", 42),
    ("ir_translation_simple.c", 42),
    ("ir_translation_if.c", 2),
    ("ir_translation_while.c", 0),
    ("sizeof_basic.c", 0),
    ("sizeof_expr.c", 0),
    ("type_warning_int_to_ptr.c", 0),
    ("type_warning_return.c", 0),
    ("type_warning_silenced_by_cast.c", 0),
    ("type_warning_arity.c", 0),
    // c5-side vprintf -- variadic walking happens in c5 source
    // and the only Win32 call is `_write`, so this fixture stays
    // in even when the libc-shape variadic-sprintf path doesn't.
    // Float / double frontend deliverable.
    ("float_pointer_basics.c", 0),
    // Full FP arithmetic on Windows/AArch64 -- same NEON lowering
    // as the ELF arm64 / macOS arm64 paths.
    ("float_arithmetic.c", 0),
    ("float_single_precision.c", 0),
    ("float_literal_f_suffix.c", 0),
    ("float_literal_arith_single_precision.c", 0),
    ("fp_direct_width_cast.c", 0),
    ("fp_const_fold_cast.c", 0),
    ("float_literal_variadic_printf.c", 0),
    ("fp_arg_passed_in_fp_reg.c", 0),
    ("float_arg_single_precision.c", 0),
    ("fp_return_value.c", 0),
    ("many_fp_args.c", 0),
    ("fp_param_after_int_overflow.c", 0),
    ("float_double_mix.c", 0),
    ("fma_contraction.c", 0),
    ("hex_float_literal.c", 0),
    ("bool_normalize_c99.c", 0),
    ("compound_literal_block.c", 0),
    ("struct_arg_in_registers.c", 0),
    ("struct_arg_by_stack.c", 0),
    ("wide_char_utf8.c", 0),
    ("local_aggregate_runtime_init.c", 0),
    ("aggregate_init_struct_member_copy.c", 0),
    ("computed_goto.c", 0),
    ("label_addr_array_init.c", 0),
    ("static_init_once_guard.c", 0),
    ("computed_goto_static_table.c", 0),
    ("sieve_of_eratosthenes.c", 0),
    ("static_neg_infinity_init.c", 0),
    ("sub_word_return_narrow.c", 0),
    ("fp_const_return.c", 0),
    ("struct_array_init_from_lvalue.c", 0),
    ("shift_result_type_signedness.c", 0),
    ("integer_negate_shift_overflow.c", 0),
    ("case_label_declaration.c", 0),
    ("char_constant_signedness.c", 0),
    ("func_name_in_initializer.c", 0),
    ("anon_union_braced_init.c", 0),
    ("array_2d_struct_init.c", 0),
    ("cast_abstract_fn_ptr.c", 0),
    ("decl_trailing_attribute.c", 0),
    ("winsock_netdb_protoent.c", 0),
    ("slot_coalesce_disjoint_temps.c", 0),
    ("alloca_alignment.c", 0),
    ("alloca_arena_in_bounds.c", 0),
    ("slot_coalesce_declared.c", 0),
    ("slot_coalesce_alloca.c", 0),
    ("fn_arg_decay_then_deref_assign.c", 0),
    ("array_range_designator.c", 0),
    ("bitfield_mixed_base_packing.c", 0),
    ("flex_array_member_sizing.c", 0),
    ("variadic_struct_return.c", 0),
    ("variadic_union_struct_return.c", 0),
    ("union_fp_member_regs_return.c", 0),
    ("fn_ptr_float_return.c", 0),
    ("fn_ptr_float_arg.c", 0),
    ("variadic_fn_ptr_init.c", 0),
    ("flexible_array_member.c", 0),
    ("flex_array_member_static_init.c", 0),
    ("attribute_cleanup.c", 0),
    ("array_compound_literal_static_init.c", 0),
    ("const_address_cast_and_arith.c", 0),
    ("const_conditional_address_init.c", 0),
    ("sizeof_array_type_and_binding.c", 0),
    ("sizeof_abstract_fn_ptr.c", 0),
    ("pragma_operator.c", 0),
    ("variadic_macro_named_rest.c", 0),
    ("stdatomic_c11.c", 0),
    ("atomic_rmw_ops.c", 0),
    ("fn_ptr_typedef_multi_declarator.c", 0),
    ("hfa_struct_return.c", 0),
    ("bitfield_assign_value.c", 0),
    ("struct_arg_indirect_subscript.c", 0),
    ("out_pointer_return_float_args.c", 0),
    ("compound_literal_tagged_address.c", 0),
    ("function_typed_parameter.c", 0),
    ("static_init_braced_scalar.c", 0),
    ("paren_string_char_array_init.c", 0),
    ("static_init_paren_relocation.c", 0),
    ("do_while_zero_returns.c", 0),
    ("self_referential_macro.c", 0),
    ("logical_not_float.c", 0),
    ("designator_override_and_braced_string.c", 0),
    ("multidim_array_init.c", 0),
    ("macro_paste_stringize_unexpanded.c", 0),
    ("line_directive.c", 0),
    ("float_global_init.c", 0),
    ("func_name_array.c", 0),
    ("unary_plus_init_and_param_shadow.c", 0),
    ("fn_ptr_multi_deref.c", 0),
    ("stringize_whitespace.c", 0),
    ("kr_old_style_def.c", 0),
    ("fn_ptr_return_type.c", 0),
    ("fn_returning_fn_ptr.c", 0),
    ("duff_switch_into_loop.c", 0),
    ("empty_macro_arg_and_string_rows.c", 0),
    ("inline_arg_count_mismatch.c", 0),
    ("block_scope_extern.c", 0),
    ("extern_incomplete_struct_completion.c", 0),
    ("const_member_address_init.c", 0),
    ("const_float_div_zero.c", 0),
    ("array_of_struct_brace_elision.c", 0),
    ("local_struct_array_runtime_init.c", 0),
    ("scanf_fscanf_binding.c", 0),
    ("builtin_bit_count.c", 0),
    ("builtin_bswap_expect.c", 0),
    ("builtin_frame_address.c", 0),
    ("zero_length_array.c", 0),
    ("nested_compound_literal.c", 0),
    ("indirect_struct_return.c", 0),
    ("indirect_struct_return_outptr.c", 0),
    ("bitfield_incdec.c", 0),
    ("c11_atomic_specifier.c", 0),
    ("c11_atomic_ops.c", 0),
    ("inline_asm_hint.c", 0),
    ("compound_assign_int_fp.c", 0),
    ("signal_sig_t.c", 0),
    ("math_classify.c", 0),
    ("switch_unsigned_negative_case.c", 0),
    ("enum_bitfield_unsigned.c", 0),
    ("addr_of_intrinsic_math.c", 0),
    ("posix_unix_headers.c", 0),
    ("socket_headers_abi.c", 0),
    ("posix_utime_errno_headers.c", 0),
    ("cast_fn_typedef_ptr_in_initializer.c", 0),
    ("global_init_paren_operand.c", 0),
    ("function_type_typedef_declaration.c", 0),
    ("float_increment_decrement.c", 0),
    ("compound_assign_float_register_resident.c", 0),
    ("addr_of_libm_import.c", 0),
    ("addr_of_libc_strcmp.c", 0),
    ("addr_of_intrinsic_math_float.c", 0),
    ("fn_ptr_float_arg_narrow.c", 0),
    ("struct_array_elided_runtime.c", 0),
    ("fn_type_typedef_field.c", 0),
    ("fn_type_typedef_local.c", 0),
    ("fn_type_typedef_cast.c", 0),
    ("nested_runtime_init.c", 0),
    ("anon_union_init.c", 0),
    ("packed_anon_union_layout.c", 0),
    ("packed_member_alignment.c", 0),
    ("builtin_trap.c", 0),
    ("struct_multi_byval.c", 0),
    ("struct_arg_two_eightbyte.c", 0),
    ("struct_return_by_value.c", 0),
    ("cast_fn_ptr_call.c", 0),
    ("fma_numeric_kernels.c", 0),
    ("fp_unary_intrinsic.c", 0),
    ("param_incoming_reg_clobber.c", 0),
    ("indexed_load_store.c", 0),
    ("struct_field_displacement.c", 0),
    ("indexed_swap_shared_addr.c", 0),
    ("store_to_load_forward.c", 0),
    ("inc_dec_step_one.c", 0),
    ("logical_op_normalize.c", 0),
    // Struct-value locals + `.` field access.
    ("struct_value_basics.c", 0),
    // Whole-struct copy via Inst::Mcpy.
    ("struct_value_copy.c", 0),
    // Struct-by-value parameter / return on Windows/AArch64.
    ("struct_by_value_param.c", 0),
    ("struct_by_value_return.c", 0),
    // _Thread_local on Windows/AArch64 -- same TLS directory +
    // _tls_index plumbing as the x64 PE; the lowering pulls
    // tls_array out of `[x18 + 0x58]` (TEB->ThreadLocalStoragePointer)
    // instead of gs:[0x58].
    ("thread_local_basic.c", 0),
    ("msvc_decl_decorators.c", 0),
    ("msvc_pragma_operator.c", 0),
    ("thread_local_gnu.c", 0),
    ("thread_local_initializer.c", 0),
    // Windows AArch64 routes setjmp / longjmp through the
    // `Intrinsic::SetjmpAArch64` / `Intrinsic::LongjmpAArch64`
    // inline expansions because msvcrt's `longjmp` requires SEH
    // unwind metadata c5 doesn't emit; the intrinsics save the
    // callee-saved registers + SP + a captured resume PC into
    // the user's `jmp_buf` and branch back from longjmp. The
    // round-trip fixture exercises both sides.
    ("setjmp_basic_stack.c", 0),
    ("setjmp_misaligned.c", 0),
    ("setjmp_longjmp_roundtrip.c", 0),
    ("packed_bitfield_repack.c", 0),
    ("nested_designator_string_member.c", 0),
    ("union_member_unbraced_init.c", 0),
    ("inline_multi_block_result_forward.c", 10),
    ("inline_multi_block_only_caller.c", 42),
    ("inline_nonleaf_const_switch.c", 0),
    ("inline_multi_block_phi_caller.c", 16),
    ("inline_const_array_field_nonnull.c", 43),
    ("inline_noreturn_branch_single_return.c", 42),
    ("sxtw_fold_source_liveness.c", 18),
    ("data_reloc_one_past_end.c", 10),
    ("variadic_libc_fnptr_static_init.c", 0),
    ("block_scope_typedef_variadic_fnptr.c", 0),
    ("atomic_operand_in_working_regs.c", 0),
    ("setjmp_value_live_across.c", 0),
    ("setjmp_spill_slots_unshared.c", 0),
    ("mixed_sse_int_aggregate_args.c", 0),
    ("variadic_agg_return_classes.c", 0),
    ("va_copy_under_pressure.c", 0),
    ("variable_shift_rcx_loop.c", 0),
    ("va_arg_composite_straddle.c", 0),
    ("variadic_hfa_struct_arg.c", 0),
    ("variadic_cast_fnptr_dispatch.c", 0),
];

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

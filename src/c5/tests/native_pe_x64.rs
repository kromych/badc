//! End-to-end Windows/x86_64 PE tests.
//!
//! Compile a c5 program to a PE32+ binary, drop it in `tmp`, and
//! execute it. Three host paths run the same surface:
//!
//! * On `windows-x86_64` the binary runs natively via
//!   `Command::new(path.exe)`.
//! * On `macos` and `linux-x86_64` the binary runs through WINE,
//!   *but only when `BADC_RUN_WINE=1` is set in the environment*.
//!   The default `cargo test` skips the wine lane so a routine
//!   developer-laptop run doesn't shell out to wine for every PE
//!   fixture. CI sets `BADC_RUN_WINE=1` on the wine-installed
//!   `ubuntu-latest` job (the `linux-x86_64` -> wine -> PE lane is
//!   a cross-check against the native `windows-latest` runner --
//!   both should accept the same PE).
//!
//! Other host triples compile this module out; the linux-x86_64
//! ELF backend is exercised separately by [`super::native_elf_x64`].

#![cfg(any(
    target_os = "macos",
    all(target_os = "windows", target_arch = "x86_64"),
    all(target_os = "linux", target_arch = "x86_64"),
))]

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::Command;

use crate::{Compiler, NativeOptions, Target, emit_native_with_options};

/// On Windows we run the binary directly; on macOS / Linux we go
/// through WINE if the environment opts in via `BADC_RUN_WINE`.
/// Returns `None` when wine execution isn't enabled (so the test
/// skips gracefully instead of panicking) or when the binary
/// isn't on disk.
fn run_pe(path: &Path, args: &[&str]) -> Option<std::io::Result<std::process::Output>> {
    #[cfg(target_os = "windows")]
    {
        Some(Command::new(path).args(args).output())
    }
    #[cfg(any(target_os = "macos", target_os = "linux"))]
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
/// so a casual `cargo test` on a wine-installed laptop doesn't
/// silently shell out to wine for half the suite.
#[cfg(any(target_os = "macos", target_os = "linux"))]
fn wine_enabled() -> bool {
    matches!(std::env::var("BADC_RUN_WINE"), Ok(v) if !v.is_empty() && v != "0")
}

/// Path resolution for `wine`. Homebrew puts it at
/// `/opt/homebrew/bin/wine` on Apple Silicon and
/// `/usr/local/bin/wine` on Intel macOS; the Ubuntu wine package
/// puts it at `/usr/bin/wine`. PATH is the final fallback.
#[cfg(any(target_os = "macos", target_os = "linux"))]
fn wine_binary() -> Option<PathBuf> {
    for candidate in [
        "/opt/homebrew/bin/wine",
        "/usr/local/bin/wine",
        "/usr/bin/wine",
    ] {
        let p = PathBuf::from(candidate);
        if p.exists() {
            return Some(p);
        }
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
/// binary. On Windows the answer is always yes; on macOS / Linux
/// it depends on whether `BADC_RUN_WINE` is set *and* WINE is
/// installed.
fn host_can_run_pe() -> bool {
    #[cfg(target_os = "windows")]
    {
        true
    }
    #[cfg(any(target_os = "macos", target_os = "linux"))]
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
    /// Host can't execute PE binaries (macOS without WINE); the
    /// test should be treated as a no-op rather than a failure.
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
    // the per-target header (`headers/badc-windows-x64.h`) is the
    // one whose `#pragma dylib` / `#pragma binding` directives end
    // up on `program.dylibs` and whose `#define __BADC_WINDOWS__` reaches
    // any conditional source.
    let program =
        match Compiler::with_target(super::with_prelude(src), Target::WindowsX64).compile() {
            Ok(p) => p,
            Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
        };
    let bytes = match emit_native_with_options(&program, Target::WindowsX64, opts) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let path = unique_temp_path("badc-pe64-test", stem);
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

/// Runs the build-and-run path, asserting on the expected exit
/// code. Skips silently when the host can't execute PE binaries
/// (macOS without WINE).
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
fn return_257_round_trips() {
    // Windows surfaces the full 32-bit DWORD that ExitProcess was
    // handed; WINE bridges it back through the host's POSIX exit
    // convention, which truncates to 8 bits (257 % 256 == 1). The
    // test accepts either, since both are correct on their host.
    let outcome = build_and_run("int main() { return 257; }", "ret257", &[]);
    match outcome {
        RunOutcome::Exit(c) => {
            assert!(
                c == 257 || c == 1,
                "expected 257 (Windows) or 1 (WINE-truncated), got {c}"
            );
        }
        RunOutcome::HostCannotRun => eprintln!("skip ret257: no PE runner on this host"),
        other => panic!("ret257: {other:?}"),
    }
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
fn indirect_call_through_fn_ptr_max_int_args() {
    // Win64 passes the first four integer arguments in rcx, rdx, r8,
    // r9 (x64 calling convention). An indirect call whose target
    // pointer competes with those argument registers used to stage
    // the target into either SCRATCH_R10 (the marshal's parallel-move
    // scratch) or an argument-destination register, both of which the
    // argument marshal overwrites before the `call`, sending control
    // to a clobbered pointer (access violation). The fix stages the
    // target into a register disjoint from every arg source, every
    // arg destination, and r10 -- spilling to the stack when none is
    // free. Four register arguments plus the live function pointer
    // exercises the tight-pressure path that surfaced the bug.
    let src = r#"
        long add4(long a, long b, long c, long d) { return a + b + c + d; }
        long call_it(long (*p)(long, long, long, long),
                     long a, long b, long c, long d) {
            return p(a, b, c, d);
        }
        int main() {
            long (*p)(long, long, long, long);
            p = add4;
            return (int)call_it(p, 10, 11, 12, 9);
        }
    "#;
    assert_exit(src, "icall4", &[], 42);
}

#[test]
fn printf_through_iat() {
    // Exits with the number of chars printf returned (4: "42\n" on
    // Linux / macOS, but Windows printf returns the byte count too,
    // including the LF, so 3). Compare against 3 to keep the test
    // platform-honest.
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
    // The PE entry stub pumps argc / argv out of msvcrt's
    // __getmainargs. Pass three extra args and verify the count
    // (argv[0] is the program path, plus the three).
    let src = r#"int main(int argc, char **argv) { return argc; }"#;
    assert_exit(src, "argc", &["one", "two", "three"], 4);
}

#[test]
fn variadic_printf_with_six_args_uses_stack_slots() {
    // Win64 only passes the first 4 ints in registers; args 5 and
    // 6 land at [rsp+0x20] and [rsp+0x28]. This exercises that
    // copy path in emit_libc_call.
    let src = r#"
        int main() {
            return printf("%d %d %d %d %d\n", 1, 2, 3, 4, 5);
        }
    "#;
    // printf returns the number of printed chars: "1 2 3 4 5\n" = 10.
    assert_exit(src, "printf6", &[], 10);
}

/// Emit a c5 program as a Win64 PE and return the raw bytes,
/// without running it. Lets a test assert on the emitted machine
/// code on any host (the run-based tests skip without WINE).
fn build_pe_bytes(src: &str) -> Vec<u8> {
    let program = Compiler::with_target(super::with_prelude(src), Target::WindowsX64)
        .compile()
        .expect("compile");
    // Byte-exact assertions hold only with the full register file; pin
    // the allocator to the full pool so the codegen_test pressure knobs
    // (BADC_MAX_GPR / BADC_MAX_FPR) do not perturb the encoding.
    crate::c5::codegen::ssa_alloc::with_pool_size_override(usize::MAX, usize::MAX, || {
        emit_native_with_options(&program, Target::WindowsX64, NativeOptions::default())
            .expect("emit_native")
    })
}

#[test]
fn c5_internal_variadic_lowers_to_win64_host_abi() {
    // A c5-internal variadic call on Win64 follows the Microsoft x64
    // calling convention rather than the c5 cdecl 16-byte stack push:
    // named and variadic arguments ride rcx/rdx/r8/r9 by position, the
    // callee spills the named register arguments into the caller's
    // home area, and the va_list is an 8-byte-stride cursor. This locks
    // the three byte-level signatures so a regression that reverts the
    // call site to the 16-byte push, drops the home spill, or restores
    // the 16-byte va_arg stride is caught on any host.
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
    let bytes = build_pe_bytes(src);

    // Callee prologue home spill: `mov [rbp+0x10], rcx` spills the
    // first named register argument into the caller-reserved home slot
    // at `[rbp + 16]`. Encoding: REX.W 89 4D 10.
    let home_spill = [0x48u8, 0x89, 0x4D, 0x10];
    assert!(
        contains(&bytes, &home_spill),
        "Win64 variadic callee must spill rcx into the home slot [rbp+16]"
    );

    // va_start / va_arg advance the cursor by 8 (the Win64 va_list
    // stride), not 16. `lea r10, [reg + 8]` with the c5 emit's reserved
    // r10 scratch encodes as REX.WR 8D 5x 08; the trailing 0x08
    // displacement is the stride. The c5-internal SysV path would use
    // 0x10 here. Assert the 8-byte-stride lea is present and the
    // 16-byte-stride one (`8D 5x 10`) is not produced for this
    // function shape.
    let va_stride8 = [0x4Cu8, 0x8D, 0x52, 0x08]; // lea r10, [rdx+8]
    assert!(
        contains(&bytes, &va_stride8),
        "Win64 va_arg / va_start must advance the cursor by 8"
    );
    let va_stride16 = [0x4Cu8, 0x8D, 0x52, 0x10]; // lea r10, [rdx+16]
    assert!(
        !contains(&bytes, &va_stride16),
        "Win64 must not emit the 16-byte c5 cdecl va_list stride"
    );
}

/// True when `needle` appears as a contiguous subslice of `hay`.
fn contains(hay: &[u8], needle: &[u8]) -> bool {
    hay.windows(needle.len()).any(|w| w == needle)
}

#[test]
fn c5_internal_variadic_sum_runs() {
    // End-to-end correctness of the Win64 host variadic ABI: a
    // c5-internal variadic sum over one named and three variadic
    // integer arguments returns their total. Skips without a PE host
    // (no WINE); the parent drives the Windows-box run.
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

/// Subset of the cross-arch fixture corpus that doesn't lean on
/// POSIX-only semantics. setenv (3-arg vs _putenv_s 2-arg), file
/// I/O against POSIX-flavoured paths, and dlopen-against-libc-soname
/// are intentionally skipped here -- the Windows analogues exist
/// but the c4 fixtures expect POSIX shapes the WINE path doesn't
/// reproduce. mprotect works through an in-text helper that
/// translates POSIX prot bits to PAGE_* and the BOOL return to
/// 0/-1, so `mprotect_allows_read.c` is in.
const NATIVE_PE_X64_FIXTURES: &[(&str, i32)] = &[
    ("arithmetic.c", 60),
    ("control_flow.c", 1),
    ("do_while.c", 5),
    ("break_continue.c", 4),
    ("for_loop.c", 10),
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
    ("macro_operators.c", 0),
    ("typedef_basic.c", 0),
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
    ("struct_layout.c", 0),
    ("const_expr_conditional.c", 27),
    ("comma_operator_in_loops.c", 3),
    ("size_t_via_stdio.c", 3),
    ("leading_dot_float_literal.c", 7),
    ("libc_fp_return_value.c", 11),
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
    // c5-side vprintf -- the variadic walk happens in c5 source,
    // so the call into msvcrt is just `_write`. No libc va_list
    // bridge involved, which is why this fixture is in even when
    // the libc-shape `variadic_sprintf` is not.
    // Float / double frontend deliverable.
    ("float_pointer_basics.c", 0),
    // Full FP arithmetic on Win64 -- same SSE2 lowering as the
    // ELF x64 path; the only thing that varies is the call site
    // ABI, which this fixture doesn't exercise (no FP libc calls).
    ("float_arithmetic.c", 0),
    ("float_single_precision.c", 0),
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
    ("flexible_array_member.c", 0),
    ("sizeof_array_type_and_binding.c", 0),
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
    ("const_member_address_init.c", 0),
    ("array_of_struct_brace_elision.c", 0),
    ("anon_union_init.c", 0),
    ("builtin_trap.c", 0),
    ("struct_multi_byval.c", 0),
    ("struct_arg_two_eightbyte.c", 0),
    ("struct_return_by_value.c", 0),
    ("cast_fn_ptr_call.c", 0),
    ("fma_numeric_kernels.c", 0),
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
    // Struct-by-value parameter / return on Win64.
    ("struct_by_value_param.c", 0),
    ("struct_by_value_return.c", 0),
    // _Thread_local on Win64 -- TLS directory + _tls_index slot
    // wired into .data; the loader writes _tls_index at module
    // init and the codegen pulls per-thread storage out of
    // gs:[0x58]. Per-thread isolation isn't tested here (we'd
    // need Win32 CreateThread bindings for that), but the basic
    // round-trip on the main thread is.
    ("thread_local_basic.c", 0),
    ("thread_local_initializer.c", 0),
    // Windows x86_64 alignment of `_setjmp`: the header's macro
    // wrapper must align the env pointer up to 16 bytes so the
    // `movdqa` saves of xmm6..xmm15 don't AV. The longjmp side
    // cannot round-trip yet -- msvcrt's `longjmp` walks frames via
    // `RtlUnwindEx`, which needs per-function `UNWIND_INFO`
    // matching the actual prologue. c5 currently emits a single
    // coarse trivial entry, so frames don't unwind correctly.
    // TODO: emit accurate per-function unwind data so
    // `setjmp_longjmp.c` can join this list.
    ("setjmp_basic_stack.c", 0),
    ("setjmp_misaligned.c", 0),
];

#[test]
fn fixture_parity() {
    if !host_can_run_pe() {
        eprintln!("skip fixture_parity: no PE runner on this host");
        return;
    }
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_PE_X64_FIXTURES {
        let outcome = build_and_run_fixture(name);
        if !outcome.matches(*expected) {
            failures.push(format!("{name}: expected {expected}, got {outcome:?}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} PE/x86_64 fixtures regressed:\n  {}",
        failures.len(),
        NATIVE_PE_X64_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// Post-call sub-word extension on the libc return register.
/// See the matching test in
/// `super::native::atoi_negative_sign_extends`. PE/x86_64
/// against msvcrt is the strictest variant: msvcrt leaves the
/// upper 32 bits of RAX unspecified for `int` returns, so
/// without the post-call `movsxd` the c5 accumulator sees
/// garbage above EAX.
#[test]
fn atoi_negative_sign_extends() {
    if !host_can_run_pe() {
        eprintln!("skip atoi_negative_sign_extends: no PE runner on this host");
        return;
    }
    let outcome = build_and_run_fixture("atoi_negative.c");
    assert!(
        matches!(outcome, RunOutcome::Exit(0)),
        "atoi('-17') should sign-extend to -1 in i64, got {outcome:?}"
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
    for (name, expected) in NATIVE_PE_X64_FIXTURES {
        let outcome = build_and_run_fixture_with_options(name, opts, "-O");
        if !outcome.matches(*expected) {
            failures.push(format!("{name} (-O): expected {expected}, got {outcome:?}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} PE/x86_64 fixtures regressed under -O:\n  {}",
        failures.len(),
        NATIVE_PE_X64_FIXTURES.len(),
        failures.join("\n  ")
    );
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
    // c4.c reads its first user argv entry as the source file to
    // compile-and-run. Hand it the c4-subset self-host fixture and
    // expect the c4-VM to print "Hello 123" and exit 0.
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
        RunOutcome::Exit(c) => assert_eq!(c, 0, "c4 self-host PE exited {c}"),
        RunOutcome::Signal(s) => panic!("c4 self-host PE killed by signal {s}"),
        RunOutcome::BuildError(e) => panic!("c4 self-host PE build error: {e}"),
        RunOutcome::HostCannotRun => {} // already logged above
    }
}

fn _link_path(_path: &Path) {} // keep the Path import in use even on hosts that skip

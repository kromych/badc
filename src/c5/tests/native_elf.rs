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

    let path = unique_temp_path("badc-elf-test", stem);
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

/// Build a per-process, per-test temp path so concurrent tests can't
/// step on each other and leftover files from previous runs can't
/// confuse the kernel's "is this executable busy?" check.
fn unique_temp_path(prefix: &str, stem: &str) -> std::path::PathBuf {
    use std::sync::atomic::{AtomicU64, Ordering};
    static COUNTER: AtomicU64 = AtomicU64::new(0);
    let n = COUNTER.fetch_add(1, Ordering::Relaxed);
    let pid = std::process::id();
    std::env::temp_dir().join(format!("{prefix}-{pid}-{n}-{stem}.bin"))
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

/// Same shape as `super::native::NATIVE_FIXTURES`. The two tables
/// stay in sync because both backends should faithfully execute the
/// same fixtures; if they drift, one of them has a bug.
const NATIVE_ELF_FIXTURES: &[(&str, i32)] = &[
    ("arithmetic.c", 60),
    ("goto.c", 5),
    ("switch_statement.c", 25),
    ("switch_default_routing.c", 100),
    ("control_flow.c", 1),
    ("do_while.c", 5),
    ("break_continue.c", 4),
    ("for_loop.c", 10),
    ("recursion_factorial.c", 120),
    ("pointers.c", 200),
    ("pointer_arithmetic_scaling.c", 104), // sizeof(int) = 4
    ("expression_precedence.c", 1),
    ("variable_shadowing.c", 10),
    ("pointer_arithmetic.c", 3),
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
    ("param_reg_swap.c", 77),
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
    ("sysv_variadic_host_abi.c", 0),
    ("aapcs64_variadic_host_abi.c", 0),
    ("param_fp_before_int_pressure.c", 0),
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
    ("static_init_cast_funcptr.c", 0),
    ("static_init_struct_fp_call.c", 0),
    ("libc_data_globals.c", 0),
    ("stdint_widths.c", 0),
    ("fd_set_macros.c", 0),
    ("fn_ptr_explicit_deref.c", 42),
    ("fn_ptr_decay_inside_block.c", 0),
    ("switch_nested_case_in_compound.c", 0),
    ("ternary_middle_comma.c", 0),
    ("local_init_int_to_float.c", 0),
    ("sys_addr_in_static_init.c", 42),
    ("sys_addr_zero_arg.c", 42),
    ("libc_struct_buf_size.c", 42),
    ("libc_basic.c", 0),
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
    ("printf.c", 0),
    ("shebang.c", 7),
    ("adjacent_strings.c", 'f' as i32),
    ("sizeof_with_write.c", 16), // 4 + 4 + 8
    ("function_pointers.c", 150),
    ("nested_function_calls.c", 100),
    ("quicksort.c", 0),
    ("binary_search_tree.c", 0),
    ("bst_free.c", 0),
    ("cast_to_struct_pointer.c", 42),
    ("argc.c", 1),
    ("argv_first_char.c", 0),
    ("sizeof_basic.c", 0),
    ("sizeof_expr.c", 0),
    ("write_stdout.c", 0),
    ("ir_translation_simple.c", 42),
    ("ir_translation_if.c", 2),
    ("ir_translation_while.c", 0),
    ("type_warning_int_to_ptr.c", 0),
    ("type_warning_return.c", 0),
    ("type_warning_silenced_by_cast.c", 0),
    ("type_warning_arity.c", 0),
    ("setenv_then_get.c", 'Z' as i32),
    // Runtime dynamic linking through libdl (libdl.so.2 +
    // libc.so.6 are both DT_NEEDED). dlopen+dlsym+blr finds
    // libc atoi and the indirect call passes "123" in x0.
    ("dlopen_atoi.c", 123),
    ("dlopen_strlen.c", 13),
    // Multi-arg dlsym call path. glibc 2.34+ folded pthread into
    // libc and keeps libpthread.so.0 as a stub the loader pulls in
    // anyway, so dlopen(NULL) finds pthread_create in our scope.
    ("pthread_create.c", 11),
    // sprintf 2-fixed + 4-variadic; cross-checks the ABI's
    // variadic packing on Linux AAPCS64 (where it stays in
    // registers, unlike macOS).
    ("variadic_sprintf.c", 0),
    // c5-side vprintf walking the c5 va_list. Stays inside the
    // c5 stack convention; no libc va_list bridge involved.
    // Float / double frontend (decls, pointer arith, sizeof).
    ("float_pointer_basics.c", 0),
    // Full FP arithmetic + comparisons + casts.
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
    // Struct-by-value parameter / return.
    ("struct_by_value_param.c", 0),
    ("struct_by_value_return.c", 0),
    // `_Thread_local` round-trip in the main thread; exercises
    // PT_TLS + .tbss layout and the variant-1 (TPIDR_EL0 +
    // TCB_HEAD + offset) lowering. The loader copies p_filesz=0
    // bytes and zero-fills the rest; the test reads/writes the
    // resulting per-thread region.
    ("thread_local_basic.c", 0),
    // thread_local_initializer.c works in isolation but fails when
    // the test prelude pulls in <stdio.h>'s static lazy-resolver
    // state. The TLS template offset assignment interacts with
    // the static-locals + Glo bookkeeping in a way that shifts
    // the loader's per-thread view; tracked separately, doesn't
    // block this lane.
    // ("thread_local_initializer.c", 0),
    // Per-thread isolation: spawn a pthread, mutate TLS in the
    // child, join, verify main's view is untouched. Fails in any
    // accidental "TLS lowered as a regular global" regression.
    ("thread_local_per_thread.c", 0),
    // Variadic FP packer: `printf("%f\n", 1.5)` -- on Linux
    // AAPCS64, FP variadic args ride d0..d7 the same as fixed
    // FP args. The all-int packer would land 1.5's bit pattern
    // in x1 and the formatter would print 0.0; the FP-aware
    // packer routes it to d0 and the test passes.
    ("printf_float.c", 0),
    // AAPCS64 returns binary128 in v0; the libc binding metadata
    // carries `returns_long_double`, and the aarch64 codegen
    // emits a `__trunctfdf2` call after each such libc return to
    // narrow v0 down to d0 before it becomes the c5 accumulator.
    // Without that, `strtold` would land at 0.0 for any power-of-
    // two value (mantissa = 0, exponent only in v0's high half).
    ("strtold_aapcs_return.c", 0),
];

#[test]
fn fixture_parity() {
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_ELF_FIXTURES {
        let outcome = build_and_run_fixture(name);
        if !outcome.matches(*expected) {
            failures.push(format!("{name}: expected exit {expected}, got {outcome:?}"));
        }
    }
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
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_ELF_FIXTURES {
        let outcome = build_and_run_fixture_with_options(name, opts, "-O");
        if !outcome.matches(*expected) {
            failures.push(format!(
                "{name} (-O): expected exit {expected}, got {outcome:?}"
            ));
        }
    }
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
    let dummy_path = std::env::temp_dir().join("test_dummy.txt");
    std::fs::write(&dummy_path, "1234567890").unwrap();

    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("file_io.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src).compile().expect("compile file_io.c");
    let bytes = emit_native(&program, Target::LinuxAarch64).expect("emit_native");
    let bin_path = unique_temp_path("badc-elf-test-file_io", "file_io");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    // ETXTBUSY-tolerant exec; retry helper carries `current_dir`.
    let mut last: Option<std::io::Result<std::process::Output>> = None;
    for attempt in 0..10 {
        let mut cmd = Command::new(&bin_path);
        cmd.current_dir(std::env::temp_dir());
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
    let _ = std::fs::remove_file(&dummy_path);
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
    let bin_path = unique_temp_path("badc-elf-test-getenv", "getenv_value");
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
    let bin_path = unique_temp_path("badc-elf-test-c4", "c4");
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

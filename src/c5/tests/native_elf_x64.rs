//! End-to-end Linux/x86_64 ELF tests. Mirror of
//! [`super::native_elf`] (the Linux/aarch64 suite) for the x86_64
//! target.
//!
//! Gated to `linux + x86_64` because the produced binary is an ELF
//! that the host kernel must agree to load and execute. CI runs this
//! module on the `ubuntu-latest` runner (x86_64 by default); macOS
//! / arm64 / Windows lanes compile it out entirely.

#![cfg(all(target_os = "linux", target_arch = "x86_64"))]

use std::io::Write;
use std::path::Path;
use std::process::Command;

use crate::{Compiler, NativeOptions, Target, emit_native, emit_native_with_options};

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
    let bytes = match emit_native_with_options(&program, Target::LinuxX64, opts) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let path = unique_temp_path("badc-elf64-test", stem);
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        // sync_all + retry-on-ETXTBUSY mirror the aarch64 module --
        // see [`super::native_elf::build_and_run_outcome`] for why.
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

fn unique_temp_path(prefix: &str, stem: &str) -> std::path::PathBuf {
    use std::sync::atomic::{AtomicU64, Ordering};
    static COUNTER: AtomicU64 = AtomicU64::new(0);
    let n = COUNTER.fetch_add(1, Ordering::Relaxed);
    let pid = std::process::id();
    std::env::temp_dir().join(format!("{prefix}-{pid}-{n}-{stem}.bin"))
}

fn exec_with_retry(path: &Path) -> std::io::Result<std::process::Output> {
    exec_with_retry_args(path, &[])
}

fn exec_with_retry_args(path: &Path, args: &[&str]) -> std::io::Result<std::process::Output> {
    for attempt in 0..10 {
        match Command::new(path).args(args).output() {
            Ok(o) => return Ok(o),
            Err(e) if e.raw_os_error() == Some(26) => {
                std::thread::sleep(std::time::Duration::from_millis(10 * (attempt + 1)));
            }
            Err(e) => return Err(e),
        }
    }
    Command::new(path).args(args).output()
}

fn set_executable(path: &Path) {
    use std::os::unix::fs::PermissionsExt;
    let meta = std::fs::metadata(path).unwrap();
    let mut perms = meta.permissions();
    perms.set_mode(perms.mode() | 0o111);
    std::fs::set_permissions(path, perms).unwrap();
}

// ---- Smoke tests -- mirror the aarch64 module's shapes. ----

#[test]
fn return_42() {
    assert_eq!(build_and_run("int main() { return 42; }", "ret42"), 42);
}

#[test]
fn return_zero() {
    assert_eq!(build_and_run("int main() { return 0; }", "ret0"), 0);
}

#[test]
fn return_value_truncates_to_byte() {
    assert_eq!(build_and_run("int main() { return 257; }", "ret257"), 1);
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
    assert_eq!(build_and_run(src, "locals"), 42);
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
    assert_eq!(build_and_run(src, "while"), 45);
}

#[test]
fn function_call_returns_value() {
    let src = r#"
        int square(int n) { return n * n; }
        int main() { return square(6) + square(2); }
    "#;
    assert_eq!(build_and_run(src, "fncall"), 40);
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
    assert_eq!(build_and_run(src, "fact"), 120);
}

#[test]
fn printf_through_libc_got() {
    let src = r#"int main() { printf("%d\n", 42); return 0; }"#;
    assert_eq!(build_and_run(src, "printf"), 0);
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
    assert_eq!(build_and_run(src, "malloc"), 1);
}

/// The full-runtime startup publishes the process environment vector
/// through `environ` (POSIX 8.3). `__c5_entry` reads envp off the initial
/// stack (`&argv[argc + 1]`) and assigns it; without that the global is
/// NULL and `environ[i]` faults. The self-contained `emit_native` stub
/// used by the fixture parity table does not link the runtime, so this is
/// linked through `link_executable_with_runtime` and run.
#[test]
fn environ_populated_through_runtime() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    // Compile for the exact link target with the driver's default
    // options (mirroring the CLI), no header prelude: the program's
    // `extern char **environ` resolves to the runtime's single
    // definition as a plain undefined reference.
    let program = Compiler::with_options(
        "extern char **environ; \
         int main(void) { \
             if (environ == 0) { return 1; } \
             int n = 0; \
             for (char **e = environ; *e != 0; e++) { n++; } \
             return n > 0 ? 0 : 2; \
         }"
        .to_string(),
        Target::LinuxX64,
        // `no_entry_point` matches the CLI's `-c` path: the program is a
        // relocatable unit, so `extern char **environ` stays an undefined
        // reference resolved at link against the runtime's definition,
        // rather than a tentative definition that would collide.
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile environ program");
    let bytes =
        super::link_executable_with_runtime(&program, Target::LinuxX64, NativeOptions::default())
            .expect("link LinuxX64 with runtime");
    let path = unique_temp_path("badc-environ", "env");
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

/// A `static` constructor runs before `main` (sets a global main
/// returns). Full link path: runtime.c walks the linker's `.init_array`.
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
    let bytes =
        super::link_executable_with_runtime(&program, Target::LinuxX64, NativeOptions::default())
            .expect("link with runtime");
    let path = unique_temp_path("badc-ctor", "run");
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

/// Constructor priority ordering plus a destructor firing at exit; the
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
    let bytes =
        super::link_executable_with_runtime(&program, Target::LinuxX64, NativeOptions::default())
            .expect("link with runtime");
    let path = unique_temp_path("badc-ctor-order", "run");
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

// ---- Fixture parity. Same table as the aarch64 module so a drift
//      in either backend shows up as an arch-specific failure. ----

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
    build_and_run_outcome_with_options(&src, &format!("fixture-{stem}{suffix}"), opts)
}

const NATIVE_ELF_X64_FIXTURES: &[(&str, i32)] = &[
    ("vla_basic_sum.c", 0),
    ("vla_runtime_sizeof.c", 0),
    ("vla_size_from_arg.c", 0),
    ("vla_scope_reclaim_loop.c", 0),
    ("vla_param_decay.c", 0),
    ("arithmetic.c", 60),
    ("inline_asm_x64_catalogue.c", 42),
    ("inline_asm_x64_setcc.c", 42),
    ("inline_asm_x64_cmov.c", 42),
    ("inline_asm_x64_cdqe.c", 42),
    ("inline_asm_x64_movnti.c", 42),
    ("compound_literal_struct_field.c", 0),
    ("goto.c", 5),
    ("switch_statement.c", 25),
    ("switch_binary_search.c", 0),
    ("switch_jump_table_dense.c", 0),
    ("switch_jump_table_sparse_kept.c", 0),
    ("switch_jumptable_dead_branch_prune.c", 12),
    ("switch_jump_table_phi_join.c", 0),
    ("branch_relaxation.c", 21),
    ("float_register_resident.c", 45),
    ("variadic_struct_arg.c", 18),
    ("variadic_struct_arg_16b.c", 51),
    ("libc_div.c", 0),
    ("strtof_parses_float.c", 0),
    ("snprintf_truncation_c99.c", 0),
    ("ioctl_fionread_pipe.c", 0),
    ("shm_open_mode_arg.c", 0),
    ("wide_string_literal_alignment.c", 0),
    ("va_arg_through_pointer.c", 0),
    ("pthread_key_once_width.c", 0),
    ("dev_t_width.c", 0),
    ("libc_int_arith.c", 0),
    ("switch_default_routing.c", 100),
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
    ("macro_multiline_comment_body.c", 0),
    ("compound_literal_paren_init.c", 0),
    ("alignof_operator.c", 0),
    ("return_void_expression.c", 0),
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
    ("tailrec_narrow_param.c", 0),
    ("tailrec_void_accumulate.c", 0),
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
    ("libc_math_minmax.c", 0),
    ("libc_math_round.c", 0),
    ("libc_math_libm.c", 0),
    ("libc_math_hyperbolic.c", 0),
    ("libc_math_special.c", 0),
    ("libc_math_nextafter.c", 0),
    ("pragma_entrypoint.c", 23),
    ("struct_field_enum_type.c", 13),
    ("compound_assign_fp_int_rhs.c", 17),
    ("optimizer_fp_arg_mask_remap.c", 19),
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
    ("loop_iv_spill_priority.c", 40),
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
    ("setenv_overwrite.c", 0),
    ("dlopen_atoi.c", 123),
    ("dlopen_strlen.c", 13),
    // Multi-arg dlsym call path. glibc 2.34+ folded pthread into
    // libc and keeps libpthread.so.0 as a stub the loader pulls in
    // anyway, so dlopen(NULL) finds pthread_create in our scope.
    ("pthread_create.c", 11),
    ("pthread_cond_timedwait.c", 0),
    ("posix_os_headers.c", 0),
    ("dirent_readdir.c", 0),
    ("ftw_walk.c", 0),
    ("stat_timespec.c", 0),
    ("malloc_size.c", 0),
    // sprintf 2-fixed + 4-variadic; SysV passes variadic in
    // registers but the call still needs `xor eax, eax` so AL
    // signals "no XMM regs used" -- the ABI plan's
    // variadic_zero_xmm_count flag drives that.
    ("variadic_sprintf.c", 0),
    // c5-side vprintf walking the c5 va_list (no libc va_list).
    // Float / double frontend deliverable.
    ("float_pointer_basics.c", 0),
    // Full FP arithmetic + comparisons + casts on Linux x86_64
    // (SysV). The x86_64 codegen lowers Fadd/.../Fcvtfi via SSE2
    // (movq xmm/gpr; addsd/subsd/mulsd/divsd; ucomisd; cvtsi2sd;
    // cvttsd2si).
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
    ("typeof_operator.c", 0),
    ("attribute_packed.c", 0),
    ("attribute_positions.c", 0),
    ("attribute_declspec.c", 0),
    ("attribute_c23.c", 0),
    ("static_assert_in_struct.c", 0),
    ("gnu_extension_keyword.c", 0),
    ("variadic_struct_by_value_arg.c", 0),
    ("fn_ptr_ternary_call_return.c", 0),
    ("float_condition_negative_zero.c", 0),
    ("tentative_array_definition.c", 0),
    ("tentative_array_use_before_init.c", 0),
    ("tentative_deferred_array_grows.c", 0),
    ("directive_in_macro_argument.c", 0),
    ("x87_control_word.c", 0),
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
    ("libc_struct_arg_by_value.c", 0),
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
    ("fts_and_fd_set_headers.c", 0),
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
    // Whole-struct copy via Inst::Mcpy. The x86_64 codegen
    // unrolls it into mov / mov word pairs.
    ("struct_value_copy.c", 0),
    // Struct-by-value parameter / return.
    ("struct_by_value_param.c", 0),
    ("struct_by_value_return.c", 0),
    // `_Thread_local` round-trip via the variant-2 (FS_BASE -
    // (tls_total - offset)) sequence on x86_64. Requires PT_TLS
    // + .tbss to exist in the ELF.
    ("thread_local_basic.c", 0),
    ("msvc_decl_decorators.c", 0),
    ("msvc_pragma_operator.c", 0),
    ("thread_local_gnu.c", 0),
    ("wmem_functions.c", 0),
    ("posix_module_headers.c", 0),
    ("mmap_anonymous.c", 0),
    ("struct_tm_tm_zone_offset.c", 0),
    ("for_init_multiple_declarators.c", 0),
    ("compound_literal_member_operand.c", 0),
    ("signal_nsig.c", 0),
    // See native_elf.rs for the prelude / TLS layout interaction
    // that disables thread_local_initializer on Linux ELF.
    // ("thread_local_initializer.c", 0),
    // Per-thread isolation via pthread_create.
    ("thread_local_per_thread.c", 0),
    // Variadic FP packer: `printf("%f\n", 1.5)`. SysV pulls FP
    // variadic args through xmm0..xmm7 with AL = XMM count; the
    // pre-packer code routed everything as 8-byte words via the
    // integer arg regs and the formatter printed 0.0.
    ("printf_float.c", 0),
    // SysV x86_64 returns `long double` in x87 st(0); c5 stores
    // it as FP64. The codegen emits an `fstp QWORD PTR [rsp]`
    // post-call to narrow st(0) to FP64. The fixture locks the
    // round-trip in -- regressions surface as `strtold` landing
    // on stale xmm0 garbage instead of the parsed value.
    ("strtold_aapcs_return.c", 0),
    // A dynamic import binds its library's default symbol version
    // (`.gnu.version_r`), not the oldest definition of the name. The
    // pthread_cond_init + CLOCK_MONOTONIC sequence returns EINVAL under
    // glibc's old @GLIBC_2.2.5 stub and 0 under the @@GLIBC_2.3.2
    // default.
    ("elf_symbol_version_default.c", 0),
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
    ("vfork_shared_stack_slot_reuse.c", 0),
    ("mixed_sse_int_aggregate_args.c", 0),
    ("variadic_agg_return_classes.c", 0),
    ("va_copy_under_pressure.c", 0),
    ("variable_shift_rcx_loop.c", 0),
    ("va_arg_composite_straddle.c", 0),
    ("variadic_cast_fnptr_dispatch.c", 0),
    ("fcntl_lock_via_cast_fnptr.c", 0),
    ("call_sp_adjust_imm12_overflow.c", 0),
    ("indirect_call_target_scratch_exhausted.c", 0),
    ("fp_load_folded_disp.c", 0),
];

#[test]
fn fixture_parity() {
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_ELF_X64_FIXTURES {
        let outcome = build_and_run_fixture(name);
        if !outcome.matches(*expected) {
            failures.push(format!("{name}: expected exit {expected}, got {outcome:?}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} ELF fixtures regressed:\n  {}",
        failures.len(),
        NATIVE_ELF_X64_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// When a dynamic import binds a versioned default symbol, the writer
/// wires DT_VERSYM / DT_VERNEED into `.dynamic` and must also give the
/// `.gnu.version` / `.gnu.version_r` payloads real section headers so
/// section-based tooling (readelf -V, objcopy) can find them. Ties the
/// expectation to DT_VERSYM so the check is non-vacuous only when the
/// host glibc actually resolves a versioned default.
#[test]
fn versioned_import_emits_gnu_version_section_headers() {
    const SHT_STRTAB: u32 = 3;
    const SHT_DYNAMIC: u32 = 6;
    const SHT_DYNSYM: u32 = 11;
    const SHT_GNU_VERNEED: u32 = 0x6fff_fffe;
    const SHT_GNU_VERSYM: u32 = 0x6fff_ffff;
    let src = super::load_fixture("elf_symbol_version_default.c");
    let program = Compiler::new(super::with_prelude(&src))
        .compile()
        .expect("compile");
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let rd_u16 = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap());
    let rd_u32 = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let rd_u64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let e_shoff = rd_u64(0x28) as usize;
    let e_shnum = rd_u16(0x3C) as usize;
    let e_shstrndx = rd_u16(0x3E) as usize;
    let shdr = |i: usize| e_shoff + i * 64;
    let sh_name = |i: usize| rd_u32(shdr(i));
    let sh_type = |i: usize| rd_u32(shdr(i) + 4);
    let sh_offset = |i: usize| rd_u64(shdr(i) + 24) as usize;
    let sh_size = |i: usize| rd_u64(shdr(i) + 32) as usize;
    let sh_link = |i: usize| rd_u32(shdr(i) + 40) as usize;
    let sh_entsize = |i: usize| rd_u64(shdr(i) + 56);
    let shstr_off = sh_offset(e_shstrndx);
    let name_at = |noff: u32| -> String {
        let start = shstr_off + noff as usize;
        let len = bytes[start..].iter().position(|&b| b == 0).unwrap();
        String::from_utf8_lossy(&bytes[start..start + len]).into_owned()
    };
    // Does `.dynamic` carry DT_VERSYM (0x6fff_fff0)? If so, the payloads
    // exist and their section headers are required.
    let mut has_dt_versym = false;
    if let Some(dyn_i) = (0..e_shnum).find(|&i| sh_type(i) == SHT_DYNAMIC) {
        let (off, size) = (sh_offset(dyn_i), sh_size(dyn_i));
        let mut p = off;
        while p + 16 <= off + size {
            let d_tag = rd_u64(p);
            if d_tag == 0x6fff_fff0 {
                has_dt_versym = true;
                break;
            }
            if d_tag == 0 {
                break;
            }
            p += 16;
        }
    }
    if !has_dt_versym {
        return; // no versioned import resolved on this host
    }
    let versym = (0..e_shnum)
        .find(|&i| sh_type(i) == SHT_GNU_VERSYM)
        .expect("DT_VERSYM present but no SHT_GNU_versym header");
    let verneed = (0..e_shnum)
        .find(|&i| sh_type(i) == SHT_GNU_VERNEED)
        .expect("DT_VERNEED present but no SHT_GNU_verneed header");
    assert_eq!(name_at(sh_name(versym)), ".gnu.version");
    assert_eq!(name_at(sh_name(verneed)), ".gnu.version_r");
    assert_eq!(sh_entsize(versym), 2);
    assert_eq!(
        sh_type(sh_link(versym)),
        SHT_DYNSYM,
        "versym.sh_link -> .dynsym"
    );
    assert_eq!(sh_type(sh_link(verneed)), SHT_STRTAB);
    assert_eq!(name_at(sh_name(sh_link(verneed))), ".dynstr");
    assert_eq!(e_shstrndx, e_shnum - 1, "shstrtab must be the last section");

    // The version sections shift .text's index; the PLT .symtab's
    // function symbols (e.g. `main`) must name the shifted .text index,
    // not the pre-shift one, or a debugger / objdump attributes them to
    // the wrong section.
    const SHT_SYMTAB: u32 = 2;
    let text_idx = (0..e_shnum)
        .find(|&i| sh_type(i) == 1 && name_at(sh_name(i)) == ".text") // SHT_PROGBITS
        .expect(".text section present") as u16;
    let symtab = (0..e_shnum)
        .find(|&i| sh_type(i) == SHT_SYMTAB)
        .expect(".symtab present when a versioned import resolves");
    let (sym_off, sym_size) = (sh_offset(symtab), sh_size(symtab));
    let str_off = sh_offset(sh_link(symtab));
    let sym_name = |noff: u32| -> String {
        let start = str_off + noff as usize;
        let len = bytes[start..].iter().position(|&b| b == 0).unwrap();
        String::from_utf8_lossy(&bytes[start..start + len]).into_owned()
    };
    let mut saw_main = false;
    let mut p = sym_off;
    while p + 24 <= sym_off + sym_size {
        let st_name = rd_u32(p);
        let st_shndx = rd_u16(p + 6);
        if sym_name(st_name) == "main" {
            saw_main = true;
            assert_eq!(st_shndx, text_idx, "`main` st_shndx must name .text");
        }
        p += 24;
    }
    assert!(saw_main, "`main` must appear in the PLT .symtab");
}

/// Post-call sub-word extension on the libc return register.
/// See the matching test in `super::native::atoi_negative_sign_extends`.
/// The x86_64 ELF backend uses `movsxd` for `Sign32`; glibc
/// happens to zero the upper bits today but the contract isn't
/// binding.
#[test]
fn atoi_negative_sign_extends() {
    let outcome = build_and_run_fixture("atoi_negative.c");
    assert!(
        matches!(outcome, RunOutcome::Exit(0)),
        "atoi('-17') should sign-extend to -1 in i64, got {outcome:?}"
    );
}

#[test]
fn fixture_parity_native_optimized() {
    let opts = NativeOptions::new().with_optimize();
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_ELF_X64_FIXTURES {
        let outcome = build_and_run_fixture_with_options(name, opts, "-O");
        if !outcome.matches(*expected) {
            failures.push(format!(
                "{name} (-O): expected exit {expected}, got {outcome:?}"
            ));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} ELF/x64 fixtures regressed under -O:\n  {}",
        failures.len(),
        NATIVE_ELF_X64_FIXTURES.len(),
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
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let bin_path = unique_temp_path("badc-elf64-test", "file_io");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    let output = (|| {
        for attempt in 0..10 {
            match Command::new(&bin_path)
                .current_dir(std::env::temp_dir())
                .output()
            {
                Ok(o) => return Ok(o),
                Err(e) if e.raw_os_error() == Some(26) => {
                    std::thread::sleep(std::time::Duration::from_millis(10 * (attempt + 1)));
                }
                Err(e) => return Err(e),
            }
        }
        Command::new(&bin_path)
            .current_dir(std::env::temp_dir())
            .output()
    })()
    .expect("exec native binary");
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
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let bin_path = unique_temp_path("badc-elf64-test", "getenv");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    let output = (|| {
        for attempt in 0..10 {
            match Command::new(&bin_path)
                .env("C4RS_TEST_GETENV", "Vox")
                .output()
            {
                Ok(o) => return Ok(o),
                Err(e) if e.raw_os_error() == Some(26) => {
                    std::thread::sleep(std::time::Duration::from_millis(10 * (attempt + 1)));
                }
                Err(e) => return Err(e),
            }
        }
        Command::new(&bin_path)
            .env("C4RS_TEST_GETENV", "Vox")
            .output()
    })()
    .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    assert_eq!(output.status.code(), Some('V' as i32));
}

#[test]
fn original_c4_compiles_and_runs_hello_natively() {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src).compile().expect("compile c4.c");
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let bin_path = unique_temp_path("badc-elf64-test", "c4");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    let output = exec_with_retry_args(
        &bin_path,
        &[concat!(
            env!("CARGO_MANIFEST_DIR"),
            "/tests/fixtures/c/c4_selfhost_hello.c"
        )],
    )
    .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "c4 self-host failed:\nSTDOUT:\n{}\nSTDERR:\n{}",
        String::from_utf8_lossy(&output.stdout),
        String::from_utf8_lossy(&output.stderr)
    );
}

/// Cross-unit `extern _Thread_local` on Linux/x86_64. Two translation
/// units each define TLS storage; `main` reads its own and the other
/// unit's thread-locals both directly (extern) and through the defining
/// unit's accessors (local), then mutates one and re-reads it. Exercises
/// the merged-TLS layout, the `NT_BADC_ELF_TPOFF` note round-trip, the
/// PT_TLS alignment, and the branch-relaxation fixup bookkeeping (a TLS
/// access gated by a prior conditional read). `main` returns a bitmask
/// of failures, so exit 0 means every access resolved correctly.
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

    // Both units compile as relocatable objects (`-c` semantics:
    // no entry-point synthesis); the runtime supplies startup and calls
    // `main` by name. `programs[0]` (UNIT_B) names the entry.
    let compile = |src: &str| -> Program {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_b = compile(UNIT_B);
    let prog_a = compile(UNIT_A);

    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_b, &prog_a],
        Target::LinuxX64,
        NativeOptions::default(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = unique_temp_path("badc-elf64-tls2", "cross_unit_tls");
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
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_b = compile(UNIT_B);
    let prog_a = compile(UNIT_A);

    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_b, &prog_a],
        Target::LinuxX64,
        NativeOptions::default().with_optimize(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = unique_temp_path("badc-elf64-inl-extref", "cross_unit_inline_extref");
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
/// different cross-TU symbol. `sym_a` is referenced in the entry block
/// (the dedup canonical for the key) and `sym_b` only in a later block;
/// coalescing makes the later reference read `sym_a`.
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
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_b = compile(UNIT_B);
    let prog_a = compile(UNIT_A);

    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_b, &prog_a],
        Target::LinuxX64,
        NativeOptions::default().with_optimize(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = unique_temp_path("badc-elf64-dedup-imm", "cross_unit_dedup_imm");
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

/// A foreign (system-cc) caller that keeps a live value in r13 across a
/// call into a badc-compiled callee must find it intact on return. r13
/// is callee-saved under System V AMD64. badc reserves r10 / r11 (both
/// caller-saved) as its fixed scratch, so r13 is an ordinary
/// callee-saved allocation target: the prologue / epilogue save and
/// restore it exactly when the allocator colors a value into it, via the
/// same callee-save loop that covers rbx / r12 / r14 / r15. The badc
/// callee here computes `x + <large immediate>`; whether r13 ends up
/// untouched or holding an allocated value, a miss in the save loop would
/// corrupt the caller's r13. The cc caller pins a sentinel in r13 across
/// the call via inline asm and checks it survives. Links a badc
/// relocatable object with a cc-compiled `main` through the system
/// driver, so it exercises the real ABI boundary the c5-to-c5 lanes
/// cannot.
#[test]
fn foreign_caller_r13_preserved() {
    use crate::{CompileOptions, OutputKind};

    // Locate a system C driver; without one the ABI boundary can't be
    // built, so skip rather than fail (the demo lanes cover it
    // where a compiler is present).
    let cc = ["cc", "gcc", "clang"].into_iter().find(|c| {
        Command::new(c)
            .arg("--version")
            .output()
            .map(|o| o.status.success())
            .unwrap_or(false)
    });
    let Some(cc) = cc else {
        eprintln!("skipping foreign_caller_r13_preserved: no system C driver (cc/gcc/clang)");
        return;
    };

    const CALLEE: &str = "long badc_cb(long x) { return x + 0x1234567890ABL; }\n";
    let prog = Compiler::with_options(
        CALLEE.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .unwrap_or_else(|e| panic!("compile callee: {e}"));
    let reloc = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..NativeOptions::default()
    };
    let obj = emit_native_with_options(&prog, Target::LinuxX64, reloc)
        .unwrap_or_else(|e| panic!("emit callee object: {e}"));

    let obj_path = unique_temp_path("badc-elf64-r13", "callee_obj");
    let main_path = unique_temp_path("badc-elf64-r13", "caller_main").with_extension("c");
    let exe_path = unique_temp_path("badc-elf64-r13", "r13_exe");
    std::fs::write(&obj_path, &obj).expect("write callee object");
    std::fs::write(
        &main_path,
        "extern long badc_cb(long);\n\
         int main(void) {\n\
         \tlong out;\n\
         \t__asm__ volatile(\"movq $0x1122334455667788, %%r13\" ::: \"r13\");\n\
         \tlong r = badc_cb(5);\n\
         \t__asm__ volatile(\"movq %%r13, %0\" : \"=r\"(out));\n\
         \treturn (out == 0x1122334455667788L && r == 5 + 0x1234567890ABL) ? 0 : 1;\n\
         }\n",
    )
    .expect("write caller main");

    let status = Command::new(cc)
        .arg(&main_path)
        .arg(&obj_path)
        .arg("-o")
        .arg(&exe_path)
        .status()
        .expect("invoke system C driver");
    assert!(
        status.success(),
        "system C driver failed to link badc object"
    );

    set_executable(&exe_path);
    let output = exec_with_retry(&exe_path).expect("run linked binary");
    let _ = std::fs::remove_file(&obj_path);
    let _ = std::fs::remove_file(&main_path);
    let _ = std::fs::remove_file(&exe_path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "foreign caller's r13 was clobbered by the badc callee (callee-save violation)"
    );
}

/// A badc caller into a foreign (cc-compiled) callee that returns a 24-byte
/// aggregate by value. System V AMD64 3.2.3 returns an aggregate larger than
/// 16 bytes (MEMORY class) through a hidden pointer the caller passes in the
/// first integer-argument register (rdi); the callee writes the result there
/// and returns the pointer in rax. badc must allocate the result buffer and
/// pass its address ahead of the declared arguments. Links a badc executable
/// against a cc-built shared object, exercising the real ABI boundary the
/// c5-to-c5 struct-return lanes cannot.
#[test]
fn badc_caller_oversize_struct_return_from_foreign() {
    use crate::CompileOptions;

    let cc = ["cc", "gcc", "clang"].into_iter().find(|c| {
        Command::new(c)
            .arg("--version")
            .output()
            .map(|o| o.status.success())
            .unwrap_or(false)
    });
    let Some(cc) = cc else {
        eprintln!(
            "skipping badc_caller_oversize_struct_return_from_foreign: no system C driver \
             (cc/gcc/clang)"
        );
        return;
    };

    let dir = unique_temp_path("badc-elf64-outptr", "dir");
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let callee_c = dir.join("callee.c");
    let so_path = dir.join("libbig24.so");
    std::fs::write(
        &callee_c,
        "typedef struct { long a; long b; long c; } Big24;\n\
         Big24 make_big24(long x) { Big24 r; r.a = x; r.b = x + 1; r.c = x + 2; return r; }\n",
    )
    .expect("write callee source");
    let st = Command::new(cc)
        .args(["-shared", "-fPIC", "-o"])
        .arg(&so_path)
        .arg(&callee_c)
        .status()
        .expect("invoke system C driver");
    assert!(st.success(), "cc failed to build the shared object");

    let caller_src = format!(
        "#pragma dylib(ext, \"{}\")\n\
         #pragma binding(ext::make_big24, \"make_big24\")\n\
         typedef struct {{ long a; long b; long c; }} Big24;\n\
         Big24 make_big24(long x);\n\
         int main(void) {{\n\
         \tBig24 r = make_big24(10);\n\
         \treturn (r.a == 10 && r.b == 11 && r.c == 12) ? 0 : 1;\n\
         }}\n",
        so_path.display()
    );
    let prog = Compiler::with_options(caller_src, Target::LinuxX64, CompileOptions::default())
        .compile()
        .unwrap_or_else(|e| panic!("compile caller: {e}"));
    let exe =
        emit_native(&prog, Target::LinuxX64).unwrap_or_else(|e| panic!("emit caller exe: {e}"));
    let exe_path = dir.join("caller_exe");
    std::fs::write(&exe_path, &exe).expect("write caller exe");
    set_executable(&exe_path);

    let output = Command::new(&exe_path)
        .env("LD_LIBRARY_PATH", &dir)
        .output()
        .expect("run linked binary");
    let _ = std::fs::remove_dir_all(&dir);
    assert_eq!(
        output.status.code(),
        Some(0),
        "badc mis-returned a > 16-byte aggregate from a foreign callee (System V sret ABI)"
    );
}

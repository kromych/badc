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
    ("arithmetic.c", 60),
    ("goto.c", 5),
    ("switch_statement.c", 25),
    ("switch_binary_search.c", 0),
    ("branch_relaxation.c", 21),
    ("float_register_resident.c", 45),
    ("variadic_struct_arg.c", 18),
    ("variadic_struct_arg_16b.c", 51),
    ("libc_div.c", 0),
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
    ("sieve_of_eratosthenes.c", 0),
    ("static_neg_infinity_init.c", 0),
    ("sub_word_return_narrow.c", 0),
    ("fp_const_return.c", 0),
    ("struct_array_init_from_lvalue.c", 0),
    ("shift_result_type_signedness.c", 0),
    ("integer_negate_shift_overflow.c", 0),
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
    ("array_compound_literal_static_init.c", 0),
    ("const_address_cast_and_arith.c", 0),
    ("const_conditional_address_init.c", 0),
    ("sizeof_array_type_and_binding.c", 0),
    ("sizeof_abstract_fn_ptr.c", 0),
    ("pragma_operator.c", 0),
    ("variadic_macro_named_rest.c", 0),
    ("stdatomic_c11.c", 0),
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

/// A foreign (system-cc) caller that keeps a live value in r13 across a
/// call into a badc-compiled callee must find it intact on return. r13
/// is callee-saved under System V AMD64; badc borrows it as its reserved
/// secondary scratch (`SCRATCH_R13`), so a callee that clobbers it must
/// save and restore the caller's value. The badc callee here computes
/// `x + <large immediate>`, which materialises the immediate through r13
/// (`emit_binop_imm`), so without the prologue/epilogue save it would
/// overwrite the caller's r13. The cc caller pins a sentinel in r13
/// across the call via inline asm and checks it survives. Links a badc
/// relocatable object with a cc-compiled `main` through the system
/// driver, so it exercises the real ABI boundary the c5-to-c5 lanes
/// cannot.
#[test]
fn foreign_caller_r13_preserved() {
    use crate::{CompileOptions, OutputKind};

    // Locate a system C driver; without one the ABI boundary can't be
    // built, so skip rather than fail (the demos / CPython lane cover it
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
    let mut reloc = NativeOptions::default();
    reloc.output_kind = OutputKind::Relocatable;
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

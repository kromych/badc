//! End-to-end JIT tests. The lowering and relocation paths are the
//! same as the AOT ELF backend (see [`super::native_elf`] /
//! [`super::native_elf_x64`]); the only thing that's different is
//! how the produced code is loaded -- mmap + mprotect + a transmuted
//! function pointer, instead of an ELF on disk + exec.
//!
//! Gated to the OS / arch combinations where `jit_run` is
//! implemented: Linux (aarch64 + x86_64) and macOS arm64. The
//! `host_target()` helper inside `jit.rs` picks the right backend
//! at runtime, so the test body is platform-agnostic.
//!
//! Output from the JIT'd program (printf, etc.) goes to the test
//! process's stdout. Tests assert only on the exit code, so the
//! interleaving with `cargo test`'s output is cosmetic.

#![cfg(any(
    all(
        target_os = "linux",
        any(target_arch = "aarch64", target_arch = "x86_64")
    ),
    all(target_os = "macos", target_arch = "aarch64"),
))]

use crate::{Compiler, NativeOptions, jit_run, jit_run_with_options};

/// Compile `src` and run it through the JIT with `args` as argv.
/// Panics on compile or JIT-load failure -- the call sites here
/// expect both phases to succeed.
fn jit_exit(src: &str, args: &[&str]) -> i32 {
    let program = Compiler::new(super::with_prelude(src))
        .compile()
        .expect("compile failed");
    let argv: Vec<String> = args.iter().map(|s| s.to_string()).collect();
    jit_run(&program, &argv).expect("jit_run failed")
}

/// JIT-run with the native optimizer on (the same pipeline that
/// `--optimize` / `-O` triggers from the CLI). Used to guard parity
/// between the default and optimized lowerings.
fn jit_exit_native_optimized(src: &str, args: &[&str]) -> i32 {
    let program = Compiler::new(super::with_prelude(src))
        .compile()
        .expect("compile failed");
    let argv: Vec<String> = args.iter().map(|s| s.to_string()).collect();
    let opts = NativeOptions::new().with_optimize();
    jit_run_with_options(&program, &argv, opts).expect("jit_run_with_options failed")
}

// ---- Smoke tests, same shapes as src/c5/tests/native_elf.rs but
//      driven through the JIT loader. ----

#[test]
fn return_42() {
    assert_eq!(jit_exit("int main() { return 42; }", &["jit-ret42"]), 42);
}

#[test]
fn return_zero() {
    assert_eq!(jit_exit("int main() { return 0; }", &["jit-ret0"]), 0);
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
    assert_eq!(jit_exit(src, &["jit-locals"]), 42);
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
    assert_eq!(jit_exit(src, &["jit-while"]), 45);
}

#[test]
fn function_call_returns_value() {
    let src = r#"
        int square(int n) { return n * n; }
        int main() { return square(6) + square(2); }
    "#;
    assert_eq!(jit_exit(src, &["jit-fncall"]), 40);
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
    assert_eq!(jit_exit(src, &["jit-fact"]), 120);
}

#[test]
fn printf_through_libc_got() {
    // printf's libc address is dlsym'd at JIT time and patched into
    // the fake GOT region; the codegen's adrp+ldr+blr (aarch64) or
    // call qword [rip+disp32] (x86_64) reads through it.
    let src = r#"int main() { printf("%d\n", 42); return 0; }"#;
    assert_eq!(jit_exit(src, &["jit-printf"]), 0);
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
    assert_eq!(jit_exit(src, &["jit-malloc"]), 1);
}

// ---- Fixture parity. Same fixture set as `super::native_elf`'s
//      NATIVE_ELF_FIXTURES; if either backend drifts, the failure
//      pinpoints which loader path broke. ----

fn jit_fixture(name: &str) -> i32 {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    jit_exit(&src, &[name])
}

const JIT_FIXTURES: &[(&str, i32)] = &[
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
    ("struct_initializers.c", 0),
    ("enum_tag_types.c", 0),
    ("bitfields.c", 0),
    ("struct_layout.c", 0),
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
    ("sys_addr_in_static_init.c", 42),
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
    ("type_warning_silenced_by_cast.c", 0),
    ("type_warning_arity.c", 0),
    // dlopen+dlsym+blr finds libc atoi and the indirect call passes
    // "123" in the System V argument register.
    ("dlopen_atoi.c", 123),
    ("dlopen_strlen.c", 13),
    // Multi-arg dlsym call path: pthread_create + pthread_join.
    // POSIX-only fixture; the JIT is gated to POSIX hosts already.
    ("pthread_create.c", 11),
    // sprintf 2-fixed + 4-variadic; the JIT shares the lowering
    // with the AOT backends so this guards both at once.
    ("variadic_sprintf.c", 0),
    // c5-side vprintf walking the c5 va_list -- exercises a
    // user-defined `my_printf` clone forwarding to <c5io.h>.
    // No libc vprintf bridge involved; the format pipeline runs
    // entirely in c5.
    ("c5_vprintf.c", 0),
    // Float / double scalars parse, sizeof reports 8, pointer
    // arithmetic and indexed loads/stores work.
    ("float_pointer_basics.c", 0),
    // Full FP arithmetic: add/sub/mul/div, comparisons, casts,
    // unary negation. Routes through Fadd/.../Fcvtfi opcodes the
    // VM and both codegens implement.
    ("float_arithmetic.c", 0),
    // Struct-value locals + `.` field access.
    ("struct_value_basics.c", 0),
    // Whole-struct copy via Op::Mcpy. The compiler emits the op
    // for `a = b` where both are struct values; the VM and both
    // codegens unroll the byte-level copy at compile time.
    ("struct_value_copy.c", 0),
    // Struct passed by value: callee's prologue copies the
    // struct out of the caller's slot into a local so callee
    // mutations don't leak.
    ("struct_by_value_param.c", 0),
    // Struct returned by value via the hidden out-pointer ABI.
    ("struct_by_value_return.c", 0),
    // Unsigned-integer comparisons: pin that comparing a u32 / u64 /
    // u8 against a value with the high bit set uses unsigned
    // semantics (the dialect emits Op::Ult/Ugt/Ule/Uge for those
    // operands and reaches them through every backend).
    ("unsigned_compare.c", 0),
    // `static const unsigned char arr[]` with 1-byte stride. The
    // size_of_type / pointee scaling helpers strip the unsigned bit
    // before classifying, so indexing scales by 1 not 8.
    ("unsigned_char_array.c", 0),
    // Compound assignment (`+=`, `-=`) on unsigned int / long /
    // char: must NOT scale the RHS by element size (the
    // `lhs_ty > Ty::Ptr` heuristic tripped on the unsigned bit).
    ("unsigned_compound_assign.c", 0),
    // Exhaustive coverage of integer ops across char/int/long
    // widths and signed/unsigned. Catches regressions in the
    // type-tag plumbing at one fixture.
    ("integer_ops_exhaustive.c", 0),
    // `thread_local_*.c` aren't here -- the JIT path's host is
    // macOS arm64 in this repo, where TLS lowering isn't
    // implemented yet (Mach-O __thread_data + dyld
    // __tlv_bootstrap is future work). The native_elf and
    // native_elf_x64 runners validate the Linux paths once the
    // built ELF lands on the orb VMs.
];

#[test]
fn fixture_parity() {
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in JIT_FIXTURES {
        let got = jit_fixture(name);
        if got != *expected {
            failures.push(format!("{name}: expected {expected}, got {got}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} JIT fixtures regressed:\n  {}",
        failures.len(),
        JIT_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// Parity for the native optimizer (the pipeline that `--optimize`
/// turns on): every fixture in the same table must produce the same
/// exit code with the optimizer enabled as without. Catches lowering
/// regressions in the register-eligible Psh path, the prologue /
/// epilogue save shape, the cmp+branch fusion peephole, or any
/// per-arch helper (binop_with_pop, cmp_with_pop, etc).
#[test]
fn fixture_parity_native_optimized() {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("fixtures");
    path.push("c");
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in JIT_FIXTURES {
        let mut p = path.clone();
        p.push(name);
        let src =
            std::fs::read_to_string(&p).unwrap_or_else(|e| panic!("read {}: {e}", p.display()));
        let got = jit_exit_native_optimized(&src, &[name]);
        if got != *expected {
            failures.push(format!(
                "{name} (native optimizer on): expected {expected}, got {got}"
            ));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} JIT fixtures regressed under the native optimizer:\n  {}",
        failures.len(),
        JIT_FIXTURES.len(),
        failures.join("\n  ")
    );
}

// ---- Standalone tests for fixtures that need argv setup the
//      parity harness can't provide. setenv / file_io are skipped:
//      they touch process-global state (env vars / cwd) and would
//      be flaky against parallel `cargo test` threads -- the
//      AOT-ELF suite covers them via per-test subprocesses. ----

#[test]
fn original_c4_compiles_and_runs_hello_jit() {
    // c4.c reads its first user argv entry as the source file to
    // compile-and-run; we hand it hello.c via JIT argv and expect
    // the resulting c4-VM run to print "Hello 123" and exit 0.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).expect("read c4.c");
    let hello = concat!(env!("CARGO_MANIFEST_DIR"), "/hello.c");
    let exit = jit_exit(&src, &["c4", hello]);
    assert_eq!(exit, 0, "c4 self-host JIT exited {exit}");
}

#[test]
fn original_c4_compiles_and_runs_hello_jit_native_optimized() {
    // Same as above but with the native optimizer on. c4.c is the
    // most complex program in the fixture set; if anything in the
    // register-pool lowering or cmp+branch fusion breaks under
    // heavy bytecode load, this is the test that catches it first.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).expect("read c4.c");
    let hello = concat!(env!("CARGO_MANIFEST_DIR"), "/hello.c");
    let exit = jit_exit_native_optimized(&src, &["c4", hello]);
    assert_eq!(
        exit, 0,
        "c4 self-host JIT (native optimizer on) exited {exit}"
    );
}

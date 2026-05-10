//! End-to-end native-codegen tests: compile a C source, write a
//! Mach-O, ad-hoc-sign it, exec it, check the exit code.
//!
//! Gated to macOS because the produced binary is a Mach-O that links
//! libSystem -- nothing else can load it, and `codesign` only exists
//! on Darwin. CI on other OSes skips these.

#![cfg(target_os = "macos")]

use std::io::Write;
use std::path::Path;
use std::process::Command;

use crate::{Compiler, NativeOptions, Target, emit_native, emit_native_with_options};

/// Outcome of compiling-and-running a native binary. The fine-grained
/// variants let the parity test report which kind of failure each
/// fixture hit instead of panicking at the first crash.
#[derive(Debug)]
#[allow(dead_code)] // payloads are read via the derived Debug fmt only
enum RunOutcome {
    /// Process exited normally with this code.
    Exit(i32),
    /// Process was killed by a signal -- typically SIGSEGV (11) when
    /// our codegen produces something the CPU rejects.
    Signal(i32),
    /// Compiling or emit_native returned an error.
    BuildError(String),
}

impl RunOutcome {
    fn matches(&self, expected: i32) -> bool {
        matches!(self, RunOutcome::Exit(c) if *c == expected)
    }
}

/// Convenience wrapper for tests that expect a normal `exit(N)`
/// result. Panics on anything else (signal, build error, ...).
fn build_and_run(src: &str, stem: &str) -> i32 {
    match build_and_run_outcome(src, stem) {
        RunOutcome::Exit(c) => c,
        other => panic!("expected normal exit, got {other:?}"),
    }
}

/// Compile inline C source, emit native, sign, run. Returns a
/// [`RunOutcome`] describing what happened.
fn build_and_run_outcome(src: &str, stem: &str) -> RunOutcome {
    build_and_run_outcome_with_options(src, stem, NativeOptions::default())
}

fn build_and_run_outcome_with_options(src: &str, stem: &str, opts: NativeOptions) -> RunOutcome {
    let program = match Compiler::new(super::with_prelude(src)).compile() {
        Ok(p) => p,
        Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
    };
    let bytes = match emit_native_with_options(&program, Target::MacOSAarch64, opts) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let path = std::env::temp_dir().join(format!("badc-test-{stem}.bin"));
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
    }
    set_executable(&path);
    codesign(&path);

    let output = Command::new(&path)
        .output()
        .expect("could not exec the produced binary");
    let _ = std::fs::remove_file(&path);
    if let Some(code) = output.status.code() {
        RunOutcome::Exit(code)
    } else {
        use std::os::unix::process::ExitStatusExt;
        let signal = output.status.signal().unwrap_or(0);
        RunOutcome::Signal(signal)
    }
}

fn set_executable(path: &Path) {
    use std::os::unix::fs::PermissionsExt;
    let meta = std::fs::metadata(path).unwrap();
    let mut perms = meta.permissions();
    perms.set_mode(perms.mode() | 0o111);
    std::fs::set_permissions(path, perms).unwrap();
}

fn codesign(path: &Path) {
    let status = Command::new("/usr/bin/codesign")
        .args(["--sign", "-", "--force"])
        .arg(path)
        .status()
        .expect("codesign not available");
    assert!(status.success(), "codesign failed for {path:?}: {status:?}");
}

#[test]
fn return_42() {
    assert_eq!(build_and_run("int main() { return 42; }", "ret42"), 42);
}

#[test]
fn return_zero() {
    assert_eq!(build_and_run("int main() { return 0; }", "ret0"), 0);
}

#[test]
fn return_arbitrary_small_int() {
    // Pick a number unlikely to collide with a kernel signal exit
    // (which would surface as `status.code() == None` and trip the
    // panic in build_and_run).
    assert_eq!(build_and_run("int main() { return 7; }", "ret7"), 7);
}

#[test]
fn return_value_truncates_to_byte() {
    // `wait()` reports the low 8 bits of main's return. 256 -> 0,
    // 257 -> 1, 0xFF -> 255. We pick 0x101 (257) so a buggy codegen
    // that, say, only stored the low 16 bits would still pass the
    // 0/42 tests but flunk this one.
    assert_eq!(build_and_run("int main() { return 257; }", "ret257"), 1);
}

// ---- Every non-intrinsic op exercised end-to-end. ----

#[test]
fn add_subtract_multiply() {
    // 5 + 3 = 8, 10 - 4 = 6, 7 * 6 = 42 -- pick the last one.
    assert_eq!(build_and_run("int main() { return 7 * 6; }", "mul42"), 42);
    assert_eq!(build_and_run("int main() { return 5 + 3; }", "add"), 8);
    assert_eq!(build_and_run("int main() { return 100 - 58; }", "sub"), 42);
}

#[test]
fn integer_div_and_mod() {
    assert_eq!(build_and_run("int main() { return 84 / 2; }", "div"), 42);
    assert_eq!(build_and_run("int main() { return 100 % 9; }", "mod"), 1);
}

#[test]
fn comparison_returns_zero_or_one() {
    assert_eq!(build_and_run("int main() { return 5 < 7; }", "lt"), 1);
    assert_eq!(build_and_run("int main() { return 5 > 7; }", "gt"), 0);
    assert_eq!(build_and_run("int main() { return 5 == 5; }", "eq"), 1);
    assert_eq!(build_and_run("int main() { return 5 != 5; }", "ne"), 0);
}

#[test]
fn local_variable_round_trips() {
    let src = r#"
        int main() {
            int x;
            x = 41;
            x = x + 1;
            return x;
        }
    "#;
    assert_eq!(build_and_run(src, "local"), 42);
}

#[test]
fn if_else_routes_correctly() {
    let src = r#"
        int main() {
            int x;
            x = 10;
            if (x > 5) return 42;
            else return 7;
        }
    "#;
    assert_eq!(build_and_run(src, "ifelse"), 42);
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
    // 0+1+2+...+9 = 45
    assert_eq!(build_and_run(src, "while45"), 45);
}

#[test]
fn function_call_returns_value() {
    let src = r#"
        int square(int n) { return n * n; }
        int main() { return square(6) + square(2); }
    "#;
    // 6*6 + 2*2 = 40
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
    // 5! = 120
    assert_eq!(build_and_run(src, "fact"), 120);
}

// ---- libc intrinsics through the GOT. The cases here avoid string
//      literals; the data-segment fixtures further down cover that
//      path.

#[test]
fn exit_with_value() {
    // exit(N) compiles to the c5 `Op::Exit` op, which our codegen
    // routes through a libc call to _exit.
    assert_eq!(
        build_and_run("int main() { exit(7); return 0; }", "exit7"),
        7
    );
}

#[test]
fn malloc_returns_nonzero_pointer() {
    let src = r#"
        int main() {
            int *p;
            p = malloc(64);
            return p != 0;
        }
    "#;
    assert_eq!(build_and_run(src, "malloc-nonzero"), 1);
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
                return 42;
            }
            return 1;
        }
    "#;
    assert_eq!(build_and_run(src, "memset-cmp"), 42);
}

#[test]
fn argc_threads_through_main() {
    // No args passed -- argc should be 1 (just the binary path).
    let src = r#"
        int main(int argc, char **argv) { return argc; }
    "#;
    assert_eq!(build_and_run(src, "argc"), 1);
}

// ---- Fixture parity. Compile each named fixture through the native
//      pipeline and confirm the exit code matches what the VM would
//      have produced. The suite spans the data segment (string
//      literals, globals), function pointers, libc calls, and
//      multi-arg variadic shapes.

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
    build_and_run_outcome_with_options(&src, &format!("{stem}{suffix}"), opts)
}

/// Native-runnable subset of the fixture suite. Each entry is the
/// fixture's filename plus the exit code it yields under the VM
/// (cross-checked in `tests::programs`).
///
/// Fixtures that need argv, a CWD-relative input file, or an env var
/// set by the harness are exercised by their own `*_natively` tests
/// (see `file_io_natively`, `getenv_value_natively`,
/// `original_c4_compiles_and_runs_hello_natively`). Everything else
/// that runs the same way on both backends lives in the table below.
///
/// The remaining excluded fixtures are the **safety-net checks**
/// (`oob_*`, `mprotect_blocks_*`, `forge_code_pointer`,
/// `use_after_free`, `double_free`, `negative_size_memset`,
/// `code_as_data`, `memcpy_oob_*`, `memset_oob`). The VM has dedicated
/// guards that exit -1 on a violation; the native binary either hits
/// the OS's protections (SIGSEGV / SIGABRT) or silently smashes
/// memory and exits 0, so the two backends genuinely diverge by
/// design.
///
/// String literals flow through __DATA via `DataFixup` and function
/// pointers resolve to native offsets via `FuncFixup`, so fixtures
/// that exercise those paths run end-to-end.
const NATIVE_FIXTURES: &[(&str, i32)] = &[
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
    ("const_expr_conditional.c", 27),
    ("comma_operator_in_loops.c", 3),
    ("size_t_via_stdio.c", 3),
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
    // Data segment + function-pointer translation. Both flow through
    // the `data_imm_positions` side channel + ADRP+ADD / RIP-relative
    // fixups. The fixtures below stress one or both.
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
    // argc/argv plumbing -- the _start stub spills the platform's
    // first two arg registers into the c5 stack slots `int main(int
    // argc, char **argv)` expects.
    ("argc.c", 1),
    ("argv_first_char.c", 0),
    ("sizeof_basic.c", 0),
    ("sizeof_expr.c", 0),
    ("write_stdout.c", 0),
    // Trivial fixtures that exit with the same code under both
    // backends. The type-warning fixtures emit warnings at compile
    // time but still run to a clean exit. `mprotect_allows_read`
    // exercises the success path (the VM-aborting "blocks_*" cases
    // intentionally diverge from native and live in the excluded set).
    ("ir_translation_simple.c", 42),
    ("ir_translation_if.c", 2),
    ("ir_translation_while.c", 0),
    ("type_warning_int_to_ptr.c", 0),
    ("type_warning_silenced_by_cast.c", 0),
    ("type_warning_arity.c", 0),
    ("setenv_then_get.c", 'Z' as i32),
    // Runtime dynamic linking. Opens the global symbol table,
    // resolves libc atoi via dlsym, calls it through Op::Jsri
    // (which loads args into x0..x7 in case the target is native),
    // exits with atoi("123") = 123.
    ("dlopen_atoi.c", 123),
    ("dlopen_strlen.c", 13),
    // Multi-arg dlsym call path: spawns a thread via pthread_create
    // (4 pointer-ish args), joins it, returns the thread's exit
    // status. macOS pthread is in libSystem so dlopen(NULL) finds it.
    ("pthread_create.c", 11),
    // sprintf with two fixed args + four variadic. macOS arm64
    // variadic ABI puts variadic args on the stack while fixed
    // args ride registers; this guards against the lowering
    // regressing back to the printf-shape (one fixed arg)
    // assumption.
    ("variadic_sprintf.c", 0),
    // c5-side vprintf walking the c5 va_list. macOS arm64 was
    // the worst-affected platform for the libc-bridged variant
    // (AAPCS64 variadic spills); this fixture sidesteps the
    // bridge and stays inside c5 stack semantics throughout.
    ("c5_vprintf.c", 0),
    // Float / double basics -- declarations, pointer arithmetic,
    // sizeof.
    ("float_pointer_basics.c", 0),
    // Full FP arithmetic + comparisons + casts on macOS arm64.
    // The aarch64 codegen lowers Fadd/.../Fcvtfi to FMOV +
    // FADD/FSUB/FMUL/FDIV/FCMP/FCVTZS/SCVTF; this fixture is the
    // host-platform smoke test for that pipeline.
    ("float_arithmetic.c", 0),
    // Variadic FP packer on macOS arm64. The Apple AAPCS64
    // quirk: variadic args spill to the stack regardless of
    // type, so `printf("%f\n", 1.5)` lands the double's bit
    // pattern in a stack slot rather than v0. Routes through
    // the macOS-specific variadic-on-stack path in
    // emit_libc_call.
    ("printf_float.c", 0),
    // _Thread_local round-trip on macOS arm64. Routes through
    // the Apple TLV (Thread-Local Variables) ABI:
    // __DATA,__thread_vars descriptors + __DATA,__thread_bss
    // storage, with the loader binding `__tlv_bootstrap` from
    // libSystem to descriptor slot 0. The codegen emits an
    // `adrp+add` that materialises the descriptor's address,
    // then `ldr x16, [x0]; blr x16` to call into the getter.
    ("thread_local_basic.c", 0),
    ("thread_local_initializer.c", 0),
    // Per-thread isolation -- spawns a pthread, has the child
    // mutate a TLS variable, joins, and verifies the main
    // thread's view is untouched. Apple's TLV implementation
    // ties the storage to a pthread key, so each thread sees
    // its own copy.
    ("thread_local_per_thread.c", 0),
    // Struct-value locals + `.` field access on macOS arm64.
    ("struct_value_basics.c", 0),
    // Whole-struct copy via Op::Mcpy on macOS arm64. The aarch64
    // codegen unrolls the copy into ldur/stur word pairs.
    ("struct_value_copy.c", 0),
    // Struct-by-value parameter / return. Both ride the existing
    // c5 calling convention (caller pushes addresses, callee
    // copies on entry; struct returns get a hidden out-pointer
    // at val=2).
    ("struct_by_value_param.c", 0),
    ("struct_by_value_return.c", 0),
    // Unsigned-integer comparisons across char / int / long widths.
    ("unsigned_compare.c", 0),
    // Static const unsigned char array indexed with 1-byte stride.
    ("unsigned_char_array.c", 0),
    // `+=` / `-=` on unsigned lvalues -- no pointer-style scaling.
    ("unsigned_compound_assign.c", 0),
    // Exhaustive integer ops across widths + signedness.
    ("integer_ops_exhaustive.c", 0),
];

/// Build a fixture, sign it, run it with the given args, and return
/// the outcome. Like [`build_and_run_fixture`] but exposes the binary
/// to a `main(argc, argv)` it can act on.
fn build_and_run_fixture_with_args<I, S>(name: &str, args: I) -> RunOutcome
where
    I: IntoIterator<Item = S>,
    S: AsRef<str>,
{
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let stem = name.trim_end_matches(".c");

    let program = match Compiler::new(src).compile() {
        Ok(p) => p,
        Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
    };
    let bytes = match emit_native(&program, Target::MacOSAarch64) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let bin_path = std::env::temp_dir().join(format!("badc-test-{stem}.bin"));
    {
        let mut f = std::fs::File::create(&bin_path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
    }
    set_executable(&bin_path);
    codesign(&bin_path);

    let output = Command::new(&bin_path)
        .args(args.into_iter().map(|s| s.as_ref().to_string()))
        .output()
        .expect("could not exec the produced binary");
    let _ = std::fs::remove_file(&bin_path);
    if let Some(code) = output.status.code() {
        RunOutcome::Exit(code)
    } else {
        use std::os::unix::process::ExitStatusExt;
        let signal = output.status.signal().unwrap_or(0);
        RunOutcome::Signal(signal)
    }
}

#[test]
fn file_io_natively() {
    // Native counterpart of `tests::programs::file_io`. Drops a
    // 10-byte test_dummy.txt next to where the binary will run, then
    // expects the fixture's open/read/close path to exit 0.
    // The fixture hard-codes the filename `test_dummy.txt`, so we
    // can't rename it -- instead we put it inside the temp dir we'll
    // use as the binary's CWD.
    let dummy_path = std::env::temp_dir().join("test_dummy.txt");
    std::fs::write(&dummy_path, "1234567890").unwrap();
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("file_io.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src).compile().expect("compile file_io.c");
    let bytes = emit_native(&program, Target::MacOSAarch64).expect("emit_native");
    let bin_path = std::env::temp_dir().join("badc-test-file_io.bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);
    codesign(&bin_path);

    let output = Command::new(&bin_path)
        .current_dir(std::env::temp_dir())
        .output()
        .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    let _ = std::fs::remove_file(&dummy_path);
    assert_eq!(output.status.code(), Some(0));
}

#[test]
fn getenv_value_natively() {
    // Set the env var the fixture reads, then exec. The binary
    // returns the first byte of the value, so 'V' (86) confirms the
    // libc getenv path threads through correctly.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("getenv_value.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src)
        .compile()
        .expect("compile getenv_value.c");
    let bytes = emit_native(&program, Target::MacOSAarch64).expect("emit_native");
    let bin_path = std::env::temp_dir().join("badc-test-getenv.bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);
    codesign(&bin_path);

    let output = Command::new(&bin_path)
        .env("C4RS_TEST_GETENV", "Vox")
        .output()
        .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    assert_eq!(output.status.code(), Some('V' as i32));
}

#[test]
fn original_c4_compiles_and_runs_hello_natively() {
    // Native counterpart of `tests::programs::original_c4_compiles_and_runs_hello`.
    // The native build of c4.c reads its first user argv entry as the
    // source file to compile-and-run; we hand it the absolute path to
    // hello.c and let c4.c (running natively) parse + execute it. The
    // expected output is "Hello 123" with exit 0.
    //
    // Unlike the VM-side test, the native binary's argv[0] is set by
    // `Command::new` to the binary path -- so we only need to pass
    // hello.c's absolute path; c4.c does `--argc; ++argv;` itself.
    let outcome =
        build_and_run_fixture_with_args("c4.c", [concat!(env!("CARGO_MANIFEST_DIR"), "/hello.c")]);
    assert!(
        matches!(outcome, RunOutcome::Exit(0)),
        "expected clean exit, got {outcome:?}"
    );
}

#[test]
fn fixture_parity() {
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_FIXTURES {
        let outcome = build_and_run_fixture(name);
        if !outcome.matches(*expected) {
            failures.push(format!("{name}: expected exit {expected}, got {outcome:?}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} native fixtures regressed:\n  {}",
        failures.len(),
        NATIVE_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// Regression marker (gh #48): `atoi("-17")` -- the libc return-
/// register sign-extension contract on AAPCS64 / Win64 leaves the
/// upper bits unspecified for sub-word returns. The fix
/// (`emit_extend_x19_for_return` / its x86_64 sibling) emits
/// `sxtw` / `movsxd` after every libc call. Run on every native
/// lane (Mach-O / ELF / PE) since each backend emits its own
/// post-call extension and the bug surfaces differently per
/// platform-libc combination.
#[test]
fn atoi_negative_sign_extends() {
    let outcome = build_and_run_fixture("atoi_negative.c");
    assert!(
        matches!(outcome, RunOutcome::Exit(0)),
        "atoi('-17') should sign-extend to -1 in i64, got {outcome:?}"
    );
}

/// `-O` parity for the macOS Mach-O backend: every fixture must
/// produce the same exit code with the optimizer enabled as
/// without. Mirrors `super::jit::fixture_parity_native_optimized`
/// so any optimizer regression specific to the Mach-O lowering
/// shows up here rather than only on the JIT lane.
#[test]
fn fixture_parity_native_optimized() {
    let opts = NativeOptions::new().with_optimize();
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_FIXTURES {
        let outcome = build_and_run_fixture_with_options(name, opts, "-O");
        if !outcome.matches(*expected) {
            failures.push(format!(
                "{name} (-O): expected exit {expected}, got {outcome:?}"
            ));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} native fixtures regressed under -O:\n  {}",
        failures.len(),
        NATIVE_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// End-to-end Mach-O dylib smoke test: compile a c5 source
/// that exports `answer()` returning 42 via `#pragma export`,
/// build it as a `.dylib` (MH_DYLIB + LC_ID_DYLIB + symbol-
/// table N_EXT|N_SECT entry), ad-hoc-sign it, then `dlopen`
/// + `dlsym` + call into it from the test process.
///
/// Verifies the entire shared-library pipeline -- including
/// that the Mach-O symbol-table entry's `n_value` is the
/// function's runtime VA, not its bytecode-PC offset.
#[test]
fn dylib_export_dlopen_call_returns_42() {
    use crate::{NativeOptions, emit_native_with_options};
    use std::ffi::CString;
    use std::os::raw::{c_int, c_void};

    let src = "
        int answer() { return 42; }
        #pragma export(answer)
        int main() { return 0; }
    ";
    let program = Compiler::with_target(super::with_prelude(src), Target::MacOSAarch64)
        .compile()
        .expect("compile");
    let bytes = emit_native_with_options(
        &program,
        Target::MacOSAarch64,
        NativeOptions::new().with_shared_library(),
    )
    .expect("emit_native dylib");

    let path = std::env::temp_dir().join("badc-dylib-export-test.dylib");
    std::fs::write(&path, &bytes).unwrap();
    // dyld refuses to load an unsigned dylib on Apple Silicon.
    let status = Command::new("/usr/bin/codesign")
        .args(["--sign", "-", "--force"])
        .arg(&path)
        .status()
        .expect("codesign not available");
    assert!(status.success(), "codesign failed: {status:?}");

    unsafe extern "C" {
        fn dlopen(filename: *const std::os::raw::c_char, flag: c_int) -> *mut c_void;
        fn dlsym(handle: *mut c_void, name: *const std::os::raw::c_char) -> *mut c_void;
        fn dlclose(handle: *mut c_void) -> c_int;
        fn dlerror() -> *const std::os::raw::c_char;
    }
    const RTLD_NOW: c_int = 2;

    let path_c = CString::new(path.to_str().unwrap()).unwrap();
    let answer_c = CString::new("answer").unwrap();
    let exit_code: c_int;
    unsafe {
        let handle = dlopen(path_c.as_ptr(), RTLD_NOW);
        if handle.is_null() {
            let err = dlerror();
            let msg = if err.is_null() {
                "(no message)".to_string()
            } else {
                std::ffi::CStr::from_ptr(err).to_string_lossy().into_owned()
            };
            let _ = std::fs::remove_file(&path);
            panic!("dlopen failed: {msg}");
        }
        let sym = dlsym(handle, answer_c.as_ptr());
        if sym.is_null() {
            let err = dlerror();
            let msg = if err.is_null() {
                "(no message)".to_string()
            } else {
                std::ffi::CStr::from_ptr(err).to_string_lossy().into_owned()
            };
            dlclose(handle);
            let _ = std::fs::remove_file(&path);
            panic!("dlsym(answer) failed: {msg}");
        }
        let answer: extern "C" fn() -> c_int = std::mem::transmute(sym);
        exit_code = answer();
        dlclose(handle);
    }
    let _ = std::fs::remove_file(&path);
    assert_eq!(exit_code, 42, "dylib export returned wrong value");
}

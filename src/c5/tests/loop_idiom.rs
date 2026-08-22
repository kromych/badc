//! Loop-idiom recognition: the counted copy / fill loops that become a
//! memory transfer, and the ones that must not.
//!
//! Each test compiles under `-O` (the transform's gate) and reads the
//! walker SSA. The sources call nothing of their own, so a call in the
//! result is the transform's library call and its absence means the
//! loop was left alone.

use crate::c5::ir::{FunctionSsa, Inst};
use crate::{CompileOptions, Compiler, Target};

fn ssa_with(src: &str, name: &str, opts: CompileOptions) -> FunctionSsa {
    ssa_of(
        &super::with_prelude(&format!("{src}\nint main(void) {{ return 0; }}\n")),
        name,
        opts,
    )
}

/// Compile without the standard prelude, so the unit can define a
/// library function of its own.
fn ssa_bare(src: &str, name: &str) -> FunctionSsa {
    ssa_of(
        &format!("{src}\nint main(void) {{ return 0; }}\n"),
        name,
        CompileOptions::default().with_optimize(true),
    )
}

fn ssa_of(src: &str, name: &str, opts: CompileOptions) -> FunctionSsa {
    use crate::c5::codegen::ssa::shadow::produce_ssa_funcs;
    let program = Compiler::with_options(src.to_string(), Target::host(), opts)
        .compile()
        .expect("compile");
    let funcs = produce_ssa_funcs(&program, Target::host(), true, true).expect("produce_ssa_funcs");
    funcs
        .into_iter()
        .find(|f| f.name == name)
        .unwrap_or_else(|| panic!("function `{name}` not found"))
}

fn ssa(src: &str, name: &str) -> FunctionSsa {
    ssa_with(src, name, CompileOptions::default().with_optimize(true))
}

fn calls(f: &FunctionSsa) -> usize {
    f.insts
        .iter()
        .filter(|i| {
            matches!(
                i,
                Inst::Call { .. } | Inst::CallExt { .. } | Inst::CallIndirect { .. }
            )
        })
        .count()
}

fn mcpys(f: &FunctionSsa) -> usize {
    f.insts
        .iter()
        .filter(|i| matches!(i, Inst::Mcpy { .. }))
        .count()
}

fn stores(f: &FunctionSsa) -> usize {
    f.insts
        .iter()
        .filter(|i| matches!(i, Inst::Store { .. } | Inst::StoreIndexed { .. }))
        .count()
}

/// `-O0` keeps every loop: the transform is an optimization.
#[test]
fn unoptimized_build_keeps_the_loop() {
    let f = ssa_with(
        "void f(char *p, int n) { for (int i = 0; i < n; i++) p[i] = 0; }",
        "f",
        CompileOptions::default(),
    );
    assert_eq!(calls(&f), 0, "no transform without -O: {:?}", f.insts);
}

#[test]
fn runtime_byte_fill_becomes_a_call() {
    let f = ssa(
        "void f(char *p, int n) { for (int i = 0; i < n; i++) p[i] = 0; }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memset call: {:?}", f.insts);
}

#[test]
fn runtime_word_fill_of_zero_becomes_a_call() {
    let f = ssa(
        "void f(int *p, int n) { for (int i = 0; i < n; i++) p[i] = 0; }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memset call: {:?}", f.insts);
}

/// A wider element only fills when every byte of the value agrees.
#[test]
fn runtime_word_fill_of_all_ones_becomes_a_call() {
    let f = ssa(
        "void f(int *p, int n) { for (int i = 0; i < n; i++) p[i] = -1; }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memset call: {:?}", f.insts);
}

#[test]
fn runtime_word_fill_of_a_mixed_pattern_is_left_alone() {
    let f = ssa(
        "void f(int *p, int n) { for (int i = 0; i < n; i++) p[i] = 0x1234; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// A constant count within the expansion cap expands inline instead of
/// calling.
#[test]
fn constant_fill_expands_inline() {
    let f = ssa(
        "void f(char *p) { for (int i = 0; i < 12; i++) p[i] = 0; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no call: {:?}", f.insts);
    assert_eq!(stores(&f), 12, "one store per byte: {:?}", f.insts);
}

/// A declared local array starts at a frame slot, so the expansion
/// stores 8 bytes at a time however narrow the element is.
#[test]
fn constant_fill_of_a_local_array_uses_slot_width_stores() {
    let f = ssa(
        "int f(void) { char a[32]; for (int i = 0; i < 32; i++) a[i] = 0; return a[3]; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no call: {:?}", f.insts);
    assert_eq!(stores(&f), 4, "four 8-byte stores: {:?}", f.insts);
}

#[test]
fn constant_copy_between_distinct_arrays_expands_inline() {
    let f = ssa(
        "static char a[32], b[32];\nvoid f(void) { for (int i = 0; i < 32; i++) a[i] = b[i]; }",
        "f",
    );
    assert_eq!(mcpys(&f), 1, "one Mcpy: {:?}", f.insts);
    assert_eq!(calls(&f), 0, "no call: {:?}", f.insts);
}

#[test]
fn runtime_copy_between_distinct_arrays_becomes_a_call() {
    let f = ssa(
        "static char a[32], b[32];\nvoid f(int n) { for (int i = 0; i < n; i++) a[i] = b[i]; }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memcpy call: {:?}", f.insts);
}

/// Pointers prove nothing about overlap, so the copy stays a loop --
/// an ascending element loop replicates where `memcpy` would not.
#[test]
fn copy_through_pointers_is_left_alone() {
    let f = ssa(
        "void f(char *d, const char *s, int n) { for (int i = 0; i < n; i++) d[i] = s[i]; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

#[test]
fn copy_within_one_array_is_left_alone() {
    let f = ssa(
        "static char a[64];\nvoid f(int n) { for (int i = 0; i < n; i++) a[i] = a[i]; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

#[test]
fn volatile_destination_is_left_alone() {
    let f = ssa(
        "void f(volatile char *p, int n) { for (int i = 0; i < n; i++) p[i] = 0; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

#[test]
fn volatile_source_is_left_alone() {
    let f = ssa(
        "static char a[32];\nstatic volatile char b[32];\n\
         void f(int n) { for (int i = 0; i < n; i++) a[i] = b[i]; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// A second effect in the body is not part of any transfer.
#[test]
fn extra_store_in_the_body_is_left_alone() {
    let f = ssa(
        "void f(char *p, char *q, int n) { for (int i = 0; i < n; i++) { p[i] = 0; q[i] = 1; } }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// A call in the body is an effect of its own, and its result is not a
/// fill value.
#[test]
fn call_in_the_body_is_left_alone() {
    let f = ssa(
        "char g(void);\nvoid f(char *p, int n) { for (int i = 0; i < n; i++) p[i] = g(); }",
        "f",
    );
    assert_eq!(
        calls(&f),
        1,
        "only the call the source wrote: {:?}",
        f.insts
    );
}

/// An exit out of the middle of the loop is not one transfer.
#[test]
fn early_exit_in_the_body_is_left_alone() {
    let f = ssa(
        "void f(char *p, int n, int stop) {\n\
         for (int i = 0; i < n; i++) { if (i == stop) break; p[i] = 0; } }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

#[test]
fn subscript_stride_past_the_element_is_left_alone() {
    let f = ssa(
        "void f(char *p, int n) { for (int i = 0; i < n; i++) p[2 * i] = 0; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

#[test]
fn step_past_one_element_is_left_alone() {
    let f = ssa(
        "void f(char *p, int n) { for (int i = 0; i < n; i += 2) p[i] = 0; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

#[test]
fn descending_loop_is_left_alone() {
    let f = ssa(
        "void f(char *p, int n) { for (int i = n; i > 0; i--) p[i] = 0; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// The stores could reach the limit through the taken address, which
/// would change the trip count mid-loop.
#[test]
fn address_taken_limit_is_left_alone() {
    let f = ssa(
        "void g(int *);\nvoid f(char *p) { int n = 8; g(&n); for (int i = 0; i < n; i++) p[i] = 0; }",
        "f",
    );
    assert_eq!(
        calls(&f),
        1,
        "only the call the source wrote: {:?}",
        f.insts
    );
}

/// A store confined to a declared array cannot reach a distinct object,
/// so the same shape transforms when the destination names an array.
#[test]
fn address_taken_limit_with_an_array_destination_transforms() {
    let f = ssa(
        "void g(int *);\nstatic char a[64];\n\
         void f(void) { int n = 8; g(&n); for (int i = 0; i < n; i++) a[i] = 0; }",
        "f",
    );
    assert_eq!(calls(&f), 2, "the source's call plus memset: {:?}", f.insts);
}

/// `-fno-builtin` bars the library spelling, so no call is synthesized.
#[test]
fn no_builtin_keeps_the_loop() {
    let f = ssa_with(
        "void f(char *p, int n) { for (int i = 0; i < n; i++) p[i] = 0; }",
        "f",
        CompileOptions::default()
            .with_optimize(true)
            .with_no_builtin(true),
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// The constant-count form needs no library and stays available.
#[test]
fn no_builtin_keeps_the_inline_expansion() {
    let f = ssa_with(
        "void f(char *p) { for (int i = 0; i < 12; i++) p[i] = 0; }",
        "f",
        CompileOptions::default()
            .with_optimize(true)
            .with_no_builtin(true),
    );
    assert_eq!(calls(&f), 0, "no call: {:?}", f.insts);
    assert_eq!(stores(&f), 12, "one store per byte: {:?}", f.insts);
}

/// A unit that defines the library function itself: the definition must
/// not call itself, while a fill elsewhere in the same unit still binds
/// to it.
const OWN_MEMSET: &str = "void *memset(void *d, int c, unsigned long n);\n\
     void *memset(void *d, int c, unsigned long n) {\n\
     unsigned char *p = d; for (unsigned long i = 0; i < n; i++) p[i] = (unsigned char)c;\n\
     return d; }\n\
     void wipe(char *p, unsigned long n) { for (unsigned long i = 0; i < n; i++) p[i] = 0; }\n";

#[test]
fn the_library_functions_own_body_is_left_alone() {
    let f = ssa_bare(OWN_MEMSET, "memset");
    assert_eq!(calls(&f), 0, "no self-call: {:?}", f.insts);
}

#[test]
fn a_unit_defined_library_function_still_takes_the_call() {
    let f = ssa_bare(OWN_MEMSET, "wipe");
    assert_eq!(calls(&f), 1, "one memset call: {:?}", f.insts);
}

/// The stored value moves with the loop, so it is no fill value.
#[test]
fn store_of_the_induction_variable_is_left_alone() {
    let f = ssa(
        "void f(char *p, int n) { for (int i = 0; i < n; i++) p[i] = (char)i; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// A volatile control value is read once per iteration; one transfer
/// would read it once (C99 5.1.2.3p2).
#[test]
fn volatile_limit_is_left_alone() {
    let f = ssa(
        "static volatile int n;\nvoid f(char *p) { for (int i = 0; i < n; i++) p[i] = 0; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

#[test]
fn volatile_fill_value_is_left_alone() {
    let f = ssa(
        "static volatile char v;\nvoid f(char *p, int n) { for (int i = 0; i < n; i++) p[i] = v; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// A floating element stores the converted value, whose representation
/// is a repeated byte only for zero.
#[test]
fn double_fill_of_zero_becomes_a_call() {
    let f = ssa(
        "void f(double *p, int n) { for (int i = 0; i < n; i++) p[i] = 0; }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memset call: {:?}", f.insts);
}

#[test]
fn double_fill_of_minus_one_is_left_alone() {
    let f = ssa(
        "void f(double *p, int n) { for (int i = 0; i < n; i++) p[i] = -1; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// A one-byte element takes a runtime fill value, but only an integer
/// one: a floating operand converts rather than truncates.
#[test]
fn byte_fill_of_a_runtime_value_becomes_a_call() {
    let f = ssa(
        "void f(char *p, int n, char v) { for (int i = 0; i < n; i++) p[i] = v; }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memset call: {:?}", f.insts);
}

#[test]
fn byte_fill_of_a_floating_value_is_left_alone() {
    let f = ssa(
        "void f(char *p, int n, double v) { for (int i = 0; i < n; i++) p[i] = (char)v; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// An array-shaped parameter is a pointer (C99 6.7.5.3p7), so two of
/// them may alias.
#[test]
fn copy_between_array_shaped_parameters_is_left_alone() {
    let f = ssa(
        "void f(char a[16], const char b[16], int n) { for (int i = 0; i < n; i++) a[i] = b[i]; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// The runnable fixtures, compiled the way the CLI's `-O` does -- the
/// front end transforms and the back end optimizes -- and executed.
#[cfg(any(
    all(
        target_os = "linux",
        any(target_arch = "aarch64", target_arch = "x86_64")
    ),
    all(target_os = "macos", target_arch = "aarch64"),
))]
mod run {
    use crate::{CompileOptions, Compiler, NativeOptions, Target, jit_run_with_options};

    fn fixture_exit(name: &str) -> i32 {
        let src = super::super::with_prelude(&super::super::load_fixture(name));
        let opts = CompileOptions::default().with_optimize(true);
        let program = Compiler::with_options(src, Target::host(), opts)
            .compile()
            .expect("compile");
        jit_run_with_options(&program, &[], NativeOptions::new().with_optimize()).expect("jit_run")
    }

    #[test]
    fn transfer_fixture_runs() {
        assert_eq!(fixture_exit("loop_idiom_transfer.c"), 0);
    }

    #[test]
    fn overlap_fixture_runs() {
        assert_eq!(fixture_exit("loop_idiom_overlap.c"), 0);
    }
}

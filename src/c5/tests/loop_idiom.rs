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

/// Pointers prove nothing about overlap, so the copy is versioned: the
/// transfer under a runtime disjointness test, the loop under its
/// negation.
#[test]
fn copy_through_pointers_versions_on_a_runtime_test() {
    let f = ssa(
        "void f(char *d, const char *s, int n) { for (int i = 0; i < n; i++) d[i] = s[i]; }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memmove call: {:?}", f.insts);
    assert!(stores(&f) > 0, "the loop is kept: {:?}", f.insts);
}

/// The version is a `memmove`: the single compare admits a destination
/// below an overlapping source, which `memcpy` does not take. A unit
/// that declares only the wrong one has no transfer to call.
const VERSIONED_COPY: &str =
    "void f(char *d, const char *s, int n) { for (int i = 0; i < n; i++) d[i] = s[i]; }\n";

#[test]
fn the_versioned_copy_binds_to_memmove() {
    let src =
        alloc::format!("void *memmove(void *, const void *, unsigned long);\n{VERSIONED_COPY}");
    assert_eq!(calls(&ssa_bare(&src, "f")), 1);
}

#[test]
fn the_versioned_copy_does_not_bind_to_memcpy() {
    let src =
        alloc::format!("void *memcpy(void *, const void *, unsigned long);\n{VERSIONED_COPY}");
    assert_eq!(calls(&ssa_bare(&src, "f")), 0);
}

/// One pointer read twice is not disjoint from itself at any distance.
#[test]
fn copy_through_one_pointer_is_left_alone() {
    let f = ssa(
        "void f(char *d, int n) { for (int i = 0; i < n; i++) d[i] = d[i]; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// A constant count is not worth a version: the loop it would keep is
/// what the unroller already reduces.
#[test]
fn constant_copy_through_pointers_is_left_alone() {
    let f = ssa(
        "void f(char *d, const char *s) { for (int i = 0; i < 8; i++) d[i] = s[i]; }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no call: {:?}", f.insts);
    assert!(mcpys(&f) == 0, "no inline transfer: {:?}", f.insts);
}

/// The same shape into a local array, where the transfer would also bar
/// the array's promotion.
#[test]
fn constant_copy_into_a_local_array_is_left_alone() {
    let f = ssa(
        "long f(const long *s) { long a[8]; for (int i = 0; i < 8; i++) a[i] = s[i]; return a[3]; }",
        "f",
    );
    assert_eq!(mcpys(&f), 0, "no inline transfer: {:?}", f.insts);
}

/// `-fno-builtin` bars the library spelling, and the versioned copy has
/// no inline form at a runtime count.
#[test]
fn no_builtin_keeps_the_versioned_copy_a_loop() {
    let f = ssa_with(
        "void f(char *d, const char *s, int n) { for (int i = 0; i < n; i++) d[i] = s[i]; }",
        "f",
        CompileOptions::default()
            .with_optimize(true)
            .with_no_builtin(true),
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
/// them may alias and the copy takes the runtime test.
#[test]
fn copy_between_array_shaped_parameters_versions() {
    let f = ssa(
        "void f(char a[16], const char b[16], int n) { for (int i = 0; i < n; i++) a[i] = b[i]; }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memmove call: {:?}", f.insts);
}

/// The pointer-walking loops: a block of `k` element copies, the two
/// pointers advanced by `k`, and the counter reduced by `k`.
#[test]
fn blocked_pointer_walk_becomes_a_call() {
    let f = ssa(
        "void f(char *d, const char *s, unsigned n) {\n\
         while (n > 2) { d[0] = s[0]; d[1] = s[1]; d[2] = s[2]; d += 3; s += 3; n -= 3; } }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memmove call: {:?}", f.insts);
}

#[test]
fn blocked_pointer_walk_takes_the_ge_spelling() {
    let f = ssa(
        "void f(int *d, const int *s, unsigned n) {\n\
         while (n >= 4) { d[0] = s[0]; d[1] = s[1]; d[2] = s[2]; d[3] = s[3];\n\
         d += 4; s += 4; n -= 4; } }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memmove call: {:?}", f.insts);
}

/// One element per iteration, through the dereference spelling.
#[test]
fn single_element_pointer_walk_becomes_a_call() {
    let f = ssa(
        "void f(char *d, const char *s, unsigned n) {\n\
         while (n > 0) { *d = *s; d++; s++; n--; } }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memmove call: {:?}", f.insts);
}

/// A `for` with neither init nor post is the same loop.
#[test]
fn pointer_walk_in_a_for_header_becomes_a_call() {
    let f = ssa(
        "void f(char *d, const char *s, unsigned n) {\n\
         for (; n > 1;) { d[0] = s[0]; d[1] = s[1]; d += 2; s += 2; n -= 2; } }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memmove call: {:?}", f.insts);
}

/// The three steps may come in any order after the copies.
#[test]
fn pointer_walk_steps_may_be_reordered() {
    let f = ssa(
        "void f(char *d, const char *s, unsigned n) {\n\
         while (n > 1) { d[0] = s[0]; d[1] = s[1]; n -= 2; s += 2; d += 2; } }",
        "f",
    );
    assert_eq!(calls(&f), 1, "one memmove call: {:?}", f.insts);
}

/// The block has to cover the range the steps advance past: a repeated
/// offset leaves an element the transfer would copy and the loop would
/// not.
#[test]
fn pointer_walk_with_a_repeated_offset_is_left_alone() {
    let f = ssa(
        "void f(char *d, const char *s, unsigned n) {\n\
         while (n > 2) { d[0] = s[0]; d[1] = s[1]; d[1] = s[1]; d += 3; s += 3; n -= 3; } }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

#[test]
fn pointer_walk_with_an_offset_past_the_block_is_left_alone() {
    let f = ssa(
        "void f(char *d, const char *s, unsigned n) {\n\
         while (n > 2) { d[0] = s[0]; d[1] = s[1]; d[3] = s[3]; d += 3; s += 3; n -= 3; } }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// A pointer step past the block leaves elements untouched.
#[test]
fn pointer_walk_with_a_mismatched_pointer_step_is_left_alone() {
    let f = ssa(
        "void f(char *d, const char *s, unsigned n) {\n\
         while (n > 2) { d[0] = s[0]; d[1] = s[1]; d[2] = s[2]; d += 4; s += 4; n -= 3; } }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// A counter step past the block changes the trip count.
#[test]
fn pointer_walk_with_a_mismatched_counter_step_is_left_alone() {
    let f = ssa(
        "void f(char *d, const char *s, unsigned n) {\n\
         while (n > 2) { d[0] = s[0]; d[1] = s[1]; d[2] = s[2]; d += 3; s += 3; n -= 2; } }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// The pointers must move together: a source left in place replicates.
#[test]
fn pointer_walk_without_a_source_step_is_left_alone() {
    let f = ssa(
        "void f(char *d, const char *s, unsigned n) {\n\
         while (n > 2) { d[0] = s[0]; d[1] = s[1]; d[2] = s[2]; d += 3; n -= 3; n -= 0; } }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

#[test]
fn pointer_walk_with_an_extra_statement_is_left_alone() {
    let f = ssa(
        "void f(char *d, const char *s, char *o, unsigned n) {\n\
         while (n > 1) { d[0] = s[0]; d[1] = s[1]; o[0] = 1; d += 2; s += 2; n -= 2; } }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// Unequal element types convert rather than move bytes.
#[test]
fn pointer_walk_over_unequal_element_types_is_left_alone() {
    let f = ssa(
        "void f(int *d, const char *s, unsigned n) {\n\
         while (n > 1) { d[0] = s[0]; d[1] = s[1]; d += 2; s += 2; n -= 2; } }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

#[test]
fn pointer_walk_over_a_volatile_element_is_left_alone() {
    let f = ssa(
        "void f(volatile char *d, const char *s, unsigned n) {\n\
         while (n > 1) { d[0] = s[0]; d[1] = s[1]; d += 2; s += 2; n -= 2; } }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// The transfer reads the counter once; a store the loop makes must not
/// be able to reach it.
#[test]
fn pointer_walk_with_an_address_taken_counter_is_left_alone() {
    let f = ssa(
        "void g(unsigned *);\n\
         void f(char *d, const char *s, unsigned n) { g(&n);\n\
         while (n > 1) { d[0] = s[0]; d[1] = s[1]; d += 2; s += 2; n -= 2; } }",
        "f",
    );
    assert_eq!(
        calls(&f),
        1,
        "only the call the source wrote: {:?}",
        f.insts
    );
}

#[test]
fn pointer_walk_with_an_address_taken_destination_is_left_alone() {
    let f = ssa(
        "void g(char **);\n\
         void f(char *d, const char *s, unsigned n) { g(&d);\n\
         while (n > 1) { d[0] = s[0]; d[1] = s[1]; d += 2; s += 2; n -= 2; } }",
        "f",
    );
    assert_eq!(
        calls(&f),
        1,
        "only the call the source wrote: {:?}",
        f.insts
    );
}

/// The counter's bound has to be a constant: nothing else fixes the
/// block size the body copies.
#[test]
fn pointer_walk_against_a_runtime_bound_is_left_alone() {
    let f = ssa(
        "void f(char *d, const char *s, unsigned n, unsigned m) {\n\
         while (n > m) { d[0] = s[0]; d[1] = s[1]; d += 2; s += 2; n -= 2; } }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// The body runs before the test, so the block is copied whether or not
/// the counter admits it.
#[test]
fn do_while_pointer_walk_is_left_alone() {
    let f = ssa(
        "void f(char *d, const char *s, unsigned n) {\n\
         do { d[0] = s[0]; d[1] = s[1]; d += 2; s += 2; n -= 2; } while (n > 1); }",
        "f",
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

#[test]
fn no_builtin_keeps_the_pointer_walk_a_loop() {
    let f = ssa_with(
        "void f(char *d, const char *s, unsigned n) {\n\
         while (n > 2) { d[0] = s[0]; d[1] = s[1]; d[2] = s[2]; d += 3; s += 3; n -= 3; } }",
        "f",
        CompileOptions::default()
            .with_optimize(true)
            .with_no_builtin(true),
    );
    assert_eq!(calls(&f), 0, "no transform: {:?}", f.insts);
}

/// The definition of `memmove` must not call itself.
#[test]
fn the_move_functions_own_body_is_left_alone() {
    let f = ssa_bare(
        "void *memmove(void *d, const void *s, unsigned long n) {\n\
         char *p = d; const char *q = s;\n\
         while (n > 0) { *p = *q; p++; q++; n--; }\n\
         return d; }",
        "memmove",
    );
    assert_eq!(calls(&f), 0, "no self-call: {:?}", f.insts);
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

    #[test]
    fn version_fixture_runs() {
        assert_eq!(fixture_exit("loop_idiom_version.c"), 0);
    }
}

//! Compile-error / diagnostic tests. Each case feeds a small malformed
//! snippet through the full compiler and asserts the error contains the
//! expected substring (so we don't pin exact wording of line numbers).

use super::Compiler;

fn expect_compile_error(src: &str, needle: &str) {
    match Compiler::new(src.to_string()).compile() {
        Err(e) => {
            let msg = e.to_string();
            assert!(
                msg.contains(needle),
                "expected error containing {:?}, got {:?}",
                needle,
                msg,
            );
        }
        Ok(_) => panic!(
            "expected compile error containing {:?}, but compile succeeded",
            needle
        ),
    }
}

#[test]
fn empty_source_has_no_main() {
    expect_compile_error("", "main() not defined");
}

#[test]
fn overaligned_automatic_beside_a_vla_is_diagnosed() {
    // The realigned region (alignment above 16) and a variable-length array
    // (C99 6.7.6.2) both move sp, so they cannot share a frame. The rejection
    // is a source-level diagnostic, not the walker's internal error.
    expect_compile_error(
        "int use(void *, void *);\n\
         int f(int n) { int v[n]; _Alignas(32) char c[32]; return use(v, c); }",
        "cannot share a function with `alloca` or a variable-length array",
    );
    // An alignment of exactly 16 is met at a static frame offset, so it
    // coexists with a VLA; a VLA whose own element needs 16 is met by the
    // 16-byte-rounded sp carve.
    Compiler::new(
        "int use(void *, void *);\n\
         int f(int n) { int v[n]; _Alignas(16) char c[16]; return use(v, c); }\n\
         int g(int n) { __int128 w[n]; w[0] = n; return (int)(long)w[0]; }\n\
         int main(void) { return g(1) - 1; }"
            .to_string(),
    )
    .compile()
    .expect("16-aligned automatic and VLA share a frame");
    // An over-aligned VLA itself has no fixed extent to place in the region.
    expect_compile_error(
        "int use(void *);\n\
         int f(int n) { _Alignas(32) char v[n]; return use(v); }",
        "over-aligned variable-length array",
    );
}

#[test]
fn overaligned_automatic_above_cap_is_rejected() {
    // An automatic object's alignment above the 8-byte frame slot is honored by
    // realigning the stack in the prologue (C11 6.7.5), up to a one-page cap. A
    // request past the cap must use static storage rather than a page-sized
    // frame slack.
    expect_compile_error(
        "int main(void) { int __attribute__((aligned(8192))) a; return (int)(long)&a; }",
        "exceeds the maximum for an automatic object",
    );
    // A non-power-of-two request is a diagnostic (C11 6.7.5 requires a power
    // of two).
    expect_compile_error(
        "int main(void) { int __attribute__((aligned(48))) a; return (int)(long)&a; }",
        "not a power of two",
    );
}

#[test]
fn overaligned_automatic_is_realigned() {
    use crate::c5::Target;
    // An over-aligned automatic object -- an explicit declarator request or
    // one inherited from an over-aligned type -- is now placed on its
    // boundary rather than rejected. Both shapes compile.
    Compiler::with_target(
        "int main(void) { int __attribute__((aligned(64))) a; a = 1; return (int)((long)&a & 63); }"
            .to_string(),
        Target::LinuxX64,
    )
    .compile()
    .expect("aligned(64) automatic compiles");
    Compiler::with_target(
        "struct __attribute__((aligned(64))) S { int x; };\n\
         int main(void) { struct S a; a.x = 1; return (int)((long)&a.x & 63); }"
            .to_string(),
        Target::LinuxAarch64,
    )
    .compile()
    .expect("over-aligned struct automatic compiles");
}

#[test]
fn source_with_only_a_global_has_no_main() {
    expect_compile_error("int x;", "main() not defined");
}

#[test]
fn bare_return_in_non_void_function_is_rejected() {
    // C23 6.8.6.4 + current toolchains: `return;` with no value in a
    // function returning non-void. C99 leaves the value indeterminate
    // (6.9.1p12).
    expect_compile_error(
        "int f(int x) { if (x) return x; return; } int main(void) { return f(0); }",
        "`return` with no value in a function returning non-void",
    );
}

#[test]
fn bare_return_in_void_function_is_allowed() {
    // The converse stays legal: `return;` in a `void` function.
    Compiler::new(
        "void g(int x) { if (x) return; } int main(void) { g(1); return 0; }".to_string(),
    )
    .compile()
    .expect("bare return in a void function must compile");
}

#[test]
fn block_scope_array_and_vector_typedef_keep_dimension() {
    // A block-scope array or vector typedef must keep its dimension across
    // several declarations. The dimension used to be dropped after the first
    // use: `A4 a = {..}` compiled but a following `A4 b = {..}` saw a scalar
    // (the file-scope path preserved it; the block-scope path did not).
    Compiler::new(
        "int main(void) { \
             typedef int A4[4]; A4 a = {1, 2, 3, 4}; A4 b = {5, 6, 7, 8}; \
             typedef int v4 __attribute__((vector_size(16))); \
             v4 x = {1, 2, 3, 4}; v4 y = {5, 6, 7, 8}; \
             return a[0] + b[0] + ((int *) &x)[0] + ((int *) &y)[0]; }"
            .to_string(),
    )
    .compile()
    .expect("block-scope array / vector typedefs must keep their dimension across decls");
}

/// Prefix declaring the vector typedefs the operand-rule tests operate on.
const VEC_DECLS: &str = "typedef __attribute__((vector_size(16))) unsigned char u8x16; \
     typedef __attribute__((vector_size(8))) unsigned char u8x8; \
     typedef __attribute__((vector_size(16))) unsigned int u32x4; \
     typedef __attribute__((vector_size(16))) int i32x4; \
     typedef __attribute__((vector_size(16))) float f32x4; \
     u8x16 a; u8x8 h; u32x4 u4; i32x4 i4; f32x4 e; int n;";

fn expect_vector_error(body: &str, needle: &str) {
    expect_compile_error(&alloc::format!("{VEC_DECLS} {body}"), needle);
}

#[test]
fn vector_relational_operators_are_rejected() {
    // The GCC vector extension defines the relational and equality operators
    // over vectors, yielding an integer vector of 0 / -1 per lane. That result
    // type is not lowered, so both spellings reject rather than operating on
    // the operand's address.
    expect_vector_error(
        "int main(void) { i32x4 r = i4 < i4; return r[0]; }",
        "invalid operands to binary operator (aggregate type)",
    );
    expect_vector_error(
        "int main(void) { i32x4 r = i4 == i4; return r[0]; }",
        "invalid operands to binary operator (aggregate type)",
    );
}

#[test]
fn vector_logical_operators_are_rejected() {
    // C99 6.5.3.3p1 / 6.5.13: `!`, `&&` and `||` need a scalar operand, and
    // the extension does not extend them to a vector. `!v` used to compare
    // the vector's address against zero.
    expect_vector_error(
        "int main(void) { return !a; }",
        "invalid operand to unary `!` (aggregate type)",
    );
    expect_vector_error(
        "int main(void) { return a && n; }",
        "invalid operands to binary operator (aggregate type)",
    );
}

#[test]
fn vector_operand_shape_mismatches_are_rejected() {
    // Two vector operands must agree on byte width and on element width and
    // kind; a pointer is not a broadcast scalar, and an integer-element
    // vector does not take a floating scalar.
    expect_vector_error(
        "int main(void) { u8x8 q = h; u8x16 r = a + q; return r[0]; }",
        "invalid operands to binary `+`",
    );
    expect_vector_error(
        "int main(void) { i32x4 r = i4 + e; return r[0]; }",
        "invalid operands to binary `+`",
    );
    expect_vector_error(
        "int main(void) { i32x4 r = i4 * 2.5; return r[0]; }",
        "invalid operands to binary `*`",
    );
    expect_vector_error(
        "int main(void) { char *p = 0; u8x16 r = a + p; return r[0]; }",
        "invalid operands to binary `+`",
    );
    expect_vector_error(
        "int main(void) { u8x16 v = a; v += h; return v[0]; }",
        "invalid operands to vector compound `+=`",
    );
    // Same byte width, different element width: the bitwise operators used
    // to admit this pair because the chunked lowering only needed the byte
    // count, but it is not a legal operand pair.
    expect_vector_error(
        "int main(void) { u8x16 r = a ^ u4; return r[0]; }",
        "invalid operands to binary `^`",
    );
}

#[test]
fn vector_of_float_rejects_the_integer_only_operators() {
    // `%`, the bitwise operators and the shifts are not defined on a
    // floating-element vector.
    expect_vector_error(
        "int main(void) { f32x4 r = e % e; return (int) r[0]; }",
        "invalid operands to binary `%`",
    );
    expect_vector_error(
        "int main(void) { f32x4 r = e & e; return (int) r[0]; }",
        "invalid operands to binary `&`",
    );
    expect_vector_error(
        "int main(void) { f32x4 r = e << 1; return (int) r[0]; }",
        "invalid operands to binary `<<`",
    );
    expect_vector_error(
        "int main(void) { f32x4 r = ~e; return (int) r[0]; }",
        "invalid operand to unary `~` (vector of float)",
    );
    expect_vector_error(
        "int main(void) { f32x4 v = e; v %= e; return (int) v[0]; }",
        "invalid operands to vector compound `%=`",
    );
}

#[test]
fn asm_memory_operand_rvalue_is_rejected() {
    // A memory (`"m"`) operand is reached through its address, so it must be an
    // lvalue. An rvalue (here a call result) is not directly addressable; the
    // compiler must reject it, not reach the address path as an internal error.
    expect_compile_error(
        "int g(void); \
         int main(void) { int r = 0; __asm__(\"mov %1, %0\" : \"=r\"(r) : \"m\"(g())); return r; }",
        "not directly addressable",
    );
}

#[test]
fn asm_output_operand_rvalue_is_rejected() {
    // An output operand names where the result is written, so an rvalue output
    // is likewise rejected with a diagnostic rather than an internal error.
    expect_compile_error(
        "int g(void); int main(void) { __asm__(\"mov %%eax, %0\" : \"=m\"(g())); return 0; }",
        "output operand must be an lvalue",
    );
}

#[test]
fn fall_off_end_of_non_void_function_warns() {
    // C99 6.9.1p12: control reaching the closing brace of a
    // value-returning function with no `return value;` leaves the value
    // indeterminate. This is undefined behavior if the result is used,
    // not a constraint violation, so it is a warning (matching gcc /
    // clang) and the codegen synthesizes a `return 0`.
    let prog = crate::c5::Compiler::new(
        "int f(int x) { if (x) return x; } int main(void) { return f(1); }".to_string(),
    )
    .compile()
    .expect("a fall-off-end non-void function compiles with a warning");
    assert!(
        prog.warnings
            .iter()
            .any(|w| w.contains("control reaches end of non-void function")),
        "expected a fall-off-end warning, got {:?}",
        prog.warnings,
    );
}

#[test]
fn fall_off_end_with_both_if_arms_returning_is_allowed() {
    // Every path returns, so control cannot reach the end.
    Compiler::new(
        "int f(int x) { if (x) return 1; else return 0; } \
         int main(void) { return f(1); }"
            .to_string(),
    )
    .compile()
    .expect("a function whose if/else both return must compile");
}

#[test]
fn fall_off_end_after_noreturn_call_is_allowed() {
    // A call to a `_Noreturn` function does not reach its continuation,
    // so a function whose last statement is such a call does not fall
    // off its end.
    Compiler::new(
        "_Noreturn void die(void); \
         int f(int x) { if (x) return x; die(); } \
         int main(void) { return f(1); }"
            .to_string(),
    )
    .compile()
    .expect("a function ending in a _Noreturn call must compile");
}

#[test]
fn fall_off_end_of_infinite_loop_is_allowed() {
    // `for (;;)` with no break never reaches the end.
    Compiler::new("int f(void) { for (;;) { } } int main(void) { f(); return 0; }".to_string())
        .compile()
        .expect("a function whose body is an infinite loop must compile");
}

#[test]
fn fall_off_end_of_main_is_allowed() {
    // C99 5.1.2.2.3: `main` returns 0 by default, so it is exempt.
    Compiler::new("int main(void) { }".to_string())
        .compile()
        .expect("main may fall off its end");
}

#[test]
fn missing_semicolon_after_statement() {
    expect_compile_error(
        "int main() { int a; a = 1 return a; }",
        "semicolon expected",
    );
}

#[test]
fn duplicate_global_definition() {
    // Two defining declarations -- both have an initializer -- must
    // fail. The tentative-definition merge (`int x; int x = 5;`) is
    // now allowed; only an actual redefinition with conflicting
    // initializers trips the duplicate check.
    expect_compile_error(
        "int x = 1; int x = 2; int main() { return 0; }",
        "duplicate global definition",
    );
}

#[test]
fn prototype_after_definition_at_pc_zero() {
    // A prototype following a function definition used to
    // clobber the symbol's val (= ent_pc) when val happened
    // to be 0 -- exactly the case for the *first* function in
    // the source. The reset would point every later call site
    // at the buffer's current pc, sending the call to a stale
    // address. Pin the fix.
    let src = "int foo_fn(int x) { return x + 1; } \
               int foo_fn(int x); \
               int main() { return foo_fn(41); }";
    let prog = crate::c5::Compiler::new(src.to_string()).compile().unwrap();
    let vm_result = crate::c5::Vm::new(prog).run().unwrap();
    assert_eq!(vm_result, 42);
}

#[test]
fn redeclaration_with_different_signature_warns() {
    // C99 6.7p4 requires redeclarations to be compatible. badc
    // doesn't refuse them (the codegen only sees one declaration
    // at a time), but it surfaces the disagreement as a single
    // warning that prints both shapes, so amalgamated multi-TU
    // builds don't silently end up with mismatched signatures
    // across the boundary. The shape is one line per redecl plus
    // two indented `previous:` / `now:` lines.
    // Plain `char`'s signedness is host-dependent (C99 6.2.5p15; see
    // `Target::plain_char_signed`), and `Compiler::new` compiles for
    // the host target. The return-type-mismatch case prints `char` on
    // signed-char hosts and `unsigned char` on aarch64-Linux.
    let char_now = if super::super::codegen::Target::default_target().plain_char_signed() {
        "now:      char (int)"
    } else {
        "now:      unsigned char (int)"
    };
    for (src, prev_needle, now_needle) in &[
        // Different return type.
        (
            "int f(int x) { return x; } char f(int x); int main() { return 0; }",
            "previous: int (int)",
            char_now,
        ),
        // Different parameter list.
        (
            "int f(int x); int f(int x, int y) { return x + y; } int main() { return 0; }",
            "previous: int (int)",
            "now:      int (int, int)",
        ),
        // Differs in variadicity.
        (
            "int f(int x); int f(int x, ...) { return x; } int main() { return 0; }",
            "previous: int (int)",
            "now:      int (int, ...)",
        ),
    ] {
        let prog = crate::c5::Compiler::new((*src).to_string())
            .compile()
            .unwrap();
        assert!(
            prog.warnings
                .iter()
                .any(|w| w.contains(prev_needle) && w.contains(now_needle)),
            "no warning containing `{prev_needle}` + `{now_needle}` for {src:?}; got {:?}",
            prog.warnings,
        );
    }
}

#[test]
fn fn_type_typedef_ptr_redeclaration_is_silent() {
    // C99 6.2.7 + 6.7.5.1p1: `F *` for a function-TYPE typedef `F` is
    // the same type as the spelled-out fn-pointer declarator. Mixed-
    // spelling prototype pairs -- both orders, unnamed, `F **`, the
    // `F (*p)` grouping, a pointer typedef of `F`, and the bare `F`
    // parameter (6.7.5.3p8) -- must merge silently.
    for src in &[
        "typedef int F(int); void f(int (*p)(int)); void f(F *p) { (void)p; } \
         int main() { return 0; }",
        "typedef int F(int); void f(F *p); void f(int (*p)(int)) { (void)p; } \
         int main() { return 0; }",
        "typedef int F(int); void f(int (*)(int)); void f(F *p) { (void)p; } \
         int main() { return 0; }",
        "typedef int F(int); void f(F *); void f(int (*p)(int)) { (void)p; } \
         int main() { return 0; }",
        "typedef int F(int); void f(int (**pp)(int)); void f(F **pp) { (void)pp; } \
         int main() { return 0; }",
        "typedef int F(int); void f(int (*p)(int)); void f(F (*p)) { (void)p; } \
         int main() { return 0; }",
        "typedef int F(int); typedef F *P; void f(int (*p)(int)); void f(P p) { (void)p; } \
         int main() { return 0; }",
        "typedef int F(int); void f(int (*p)(int)); void f(F p) { (void)p; } \
         int main() { return 0; }",
    ] {
        let prog = crate::c5::Compiler::new((*src).to_string())
            .compile()
            .unwrap();
        assert!(
            prog.warnings.is_empty(),
            "expected silence for {src:?}, got {:?}",
            prog.warnings,
        );
    }
}

#[test]
fn matching_redeclaration_is_silent() {
    // The amalgamator (scripts/amalgamate.py) glues TUs that
    // typically include the same prototype many times via shared
    // headers. Repeats with identical signatures must not
    // produce noise.
    let src = "int f(int x); int f(int x); int f(int x) { return x; } int main() { return f(7); }";
    let prog = crate::c5::Compiler::new(src.to_string()).compile().unwrap();
    assert!(
        prog.warnings.is_empty(),
        "matching redecl should be silent, got {:?}",
        prog.warnings,
    );
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 7);
}

#[test]
fn undeclared_identifier_in_initializer_errors() {
    // C99 6.5.1: an identifier must be declared before use. An undeclared
    // identifier as an initializer element (a missing header or a typo) is
    // rejected, not bound to a placeholder that resolves to a silent zero.
    let src = "typedef void (*fp)(void); fp t[] = { undeclared_xyz }; int main(void) { return 0; }";
    let err = crate::c5::Compiler::new(src.to_string()).compile();
    assert!(
        err.is_err(),
        "expected a compile error for the undeclared initializer element",
    );
    // A function declared by a prior prototype and defined later in the same
    // unit is a valid forward reference (C99 6.7p7) and compiles silently.
    let ok = "typedef int (*fp)(void); int fwd(void); fp t[] = { fwd }; \
              int fwd(void) { return 0; } int main(void) { return 0; }";
    let prog = crate::c5::Compiler::new(ok.to_string()).compile().unwrap();
    assert!(
        prog.warnings.is_empty(),
        "valid forward reference should be silent, got {:?}",
        prog.warnings,
    );
}

#[test]
fn tentative_definition_merge() {
    // `int x;` + `int x = 5;` -- the prior declaration is tentative
    // (no initializer); the second one supplies the initializer.
    // Allowed by C11 6.9.2; amalgamated translation units rely
    // on this when each `#include`-ed unit re-emits the same
    // tentative-then-defined globals.
    let src = "int x; int x = 5; int main() { return x; }";
    let prog = crate::c5::Compiler::new(src.to_string()).compile().unwrap();
    let vm_result = crate::c5::Vm::new(prog).run().unwrap();
    assert_eq!(vm_result, 5);
}

#[test]
fn duplicate_parameter_definition() {
    expect_compile_error(
        "int f(int a, int a) { return a; } int main() { return 0; }",
        "duplicate parameter definition",
    );
}

#[test]
fn undefined_variable_used_in_expression() {
    expect_compile_error(
        "int main() { return missing; }",
        "undefined variable missing",
    );
}

#[test]
fn sizeof_rejects_undeclared_identifier() {
    // C99 6.5.3.4 admits two operand shapes: a parenthesized
    // type-name and a unary-expression. The unary-expression path
    // folds back to 6.5.1p2, which requires every primary
    // identifier to be declared. Prior to the fix the bare-id
    // shortcut in `sizeof_expr.rs` read `Symbol::type_` directly
    // for any `Token::Id` operand, so an undeclared name silently
    // resolved to `Symbol::default()` (type_ = `Ty::Char` = 0) and
    // `sizeof(undeclared)` evaluated to 1 instead of erroring.
    expect_compile_error(
        "int main() { return sizeof(no_such_type); }",
        "undefined variable no_such_type",
    );
}

#[test]
fn sizeof_in_array_dim_rejects_undeclared_identifier() {
    // Same constraint surfacing through a constant-expression
    // `sizeof` (C99 6.6 + 6.7.6.2): the array-dimension parser
    // runs `parse_constant_int` -> `sizeof_operand_bytes`. An
    // undeclared operand must fail there, not silently fold to
    // the `Ty::Char` placeholder size and produce a positive
    // dimension or a confusing "array dimension must be positive"
    // downstream message.
    expect_compile_error(
        "int main() { char x[sizeof(no_such_type) == 1 ? 1 : -1]; return 0; }",
        "undefined variable no_such_type",
    );
}

#[test]
fn break_outside_loop() {
    expect_compile_error(
        "int main() { break; return 0; }",
        "break outside of loop or switch",
    );
}

#[test]
fn continue_outside_loop() {
    expect_compile_error(
        "int main() { continue; return 0; }",
        "continue outside of loop",
    );
}

#[test]
fn unresolved_goto_label() {
    expect_compile_error("int main() { goto nowhere; return 0; }", "unresolved label");
}

// GCC local labels (`__label__`). The accept/reject split below matches
// gcc; clang differs on one case, noted at that test.

#[test]
fn local_label_binds_within_its_block() {
    expect_compiles(
        "int main() { __label__ done; if (1) goto done; done: return 0; }",
        "a `__label__` defined in the declaring block",
    );
}

#[test]
fn local_label_same_name_in_sibling_blocks() {
    // The point of the extension: each block's `l` is a separate label,
    // so this is not a redefinition.
    expect_compiles(
        "int main() { { __label__ l; goto l; l: ; } { __label__ l; goto l; l: ; } return 0; }",
        "one name declared `__label__` by two sibling blocks",
    );
}

#[test]
fn local_label_declaration_shadows_outer_one() {
    expect_compiles(
        "int main() { __label__ l; { __label__ l; goto l; l: ; } goto l; l: return 0; }",
        "an inner `__label__` shadowing an outer one",
    );
}

#[test]
fn local_label_declaration_lists_several_names() {
    expect_compiles(
        "int main() { __label__ a, b; if (1) goto a; goto b; a: ; b: return 0; }",
        "several names in one `__label__` declaration",
    );
}

#[test]
fn consecutive_local_label_declarations() {
    expect_compiles(
        "int main() { __label__ a; __label__ b; goto a; a: ; goto b; b: return 0; }",
        "two `__label__` declarations leading one block",
    );
}

#[test]
fn local_label_reachable_from_nested_block() {
    expect_compiles(
        "int main() { __label__ l; { { goto l; } } l: return 0; }",
        "a `goto` in a nested block targeting an enclosing local label",
    );
}

#[test]
fn address_of_local_label() {
    expect_compiles(
        "int main() { __label__ l; void *p = &&l; if (p) goto *p; l: return 0; }",
        "`&&label` naming a local label",
    );
}

#[test]
fn local_label_declared_but_unused() {
    // gcc accepts a local label that is never referenced; clang rejects
    // it. Follow gcc: the declaration alone constrains nothing.
    expect_compiles(
        "int main() { __label__ l; return 0; }",
        "an unreferenced `__label__` declaration",
    );
}

#[test]
fn local_label_in_a_statement_expression() {
    // The motivating case: two expansions of one macro in a function,
    // each defining the label its own body declares.
    expect_compiles(
        "int main(void) { int a = ({ __label__ o; int r = 0; goto o; o: ; r; }); \
         int b = ({ __label__ o; int r = 1; goto o; o: ; r; }); return a + b - 1; }",
        "a `__label__` in each of two statement expressions",
    );
}

#[test]
fn local_label_declared_but_not_defined() {
    expect_compile_error(
        "int main() { __label__ done; if (1) goto done; return 0; }",
        "unresolved label: done",
    );
}

#[test]
fn goto_local_label_from_outside_its_block() {
    // The declaration's scope ended with the block, so the `goto` names
    // a function-scoped label that no statement defines.
    expect_compile_error(
        "int main() { { __label__ l; l: ; } goto l; return 0; }",
        "unresolved label: l",
    );
}

#[test]
fn local_label_defined_twice_within_its_scope() {
    expect_compile_error(
        "int main() { __label__ l; { l: ; } l: return 0; }",
        "redefinition of label `l`",
    );
}

#[test]
fn duplicate_local_label_declaration() {
    expect_compile_error(
        "int main() { __label__ l; __label__ l; goto l; l: return 0; }",
        "duplicate local label declaration `l`",
    );
}

#[test]
fn local_label_declaration_after_a_statement() {
    expect_compile_error(
        "int main() { int x = 0; __label__ l; goto l; l: return x; }",
        "`__label__` must appear at the start of its block",
    );
}

#[test]
fn local_label_declaration_after_a_nested_statement() {
    expect_compile_error(
        "int main() { { ; __label__ l; goto l; l: ; } return 0; }",
        "`__label__` must appear at the start of its block",
    );
}

#[test]
fn address_of_undefined_label() {
    // gcc and clang both reject taking the address of a label that no
    // statement defines.
    expect_compile_error(
        "int main() { void *p = &&nowhere; return p != 0; }",
        "unresolved label: nowhere",
    );
}

#[test]
fn missing_close_paren_in_if() {
    expect_compile_error("int main() { if (1 return 0; }", "close paren expected");
}

#[test]
fn missing_open_paren_after_while() {
    expect_compile_error("int main() { while 1) return 0; }", "open paren expected");
}

#[test]
fn bad_lvalue_in_assignment() {
    expect_compile_error(
        "int main() { 1 = 2; return 0; }",
        "bad lvalue in assignment",
    );
}

// Emits a native image for every target, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn thread_local_compiles_to_op_tlslea() {
    // `_Thread_local` lexes as Token::ThreadLocal, the parser
    // accepts it as a global storage-class prefix, the symbol
    // carries the flag, and reads/writes route through the TLS
    // segment rather than the regular data segment. The
    // contract surfaces through `Program::tls_data` (parser-side
    // slot allocation) and through the per-target codegen
    // accepting the lowered form below; a regression that
    // collapses the access onto the data segment trips one of
    // those gates.
    let src = "_Thread_local int counter;\n\
               int main() { counter = 42; return counter; }";
    // Every supported target now lowers `_Thread_local`. Linux
    // and Windows have full code paths; macOS arm64 routes
    // through the Mach-O `__thread_vars` + `__tlv_bootstrap`
    // pipeline, which needs libSystem in the dylib set -- so
    // compile per target rather than re-emitting a host-compiled
    // program whose dylib bindings are the host's.
    for target in [
        super::super::codegen::Target::LinuxAarch64,
        super::super::codegen::Target::LinuxX64,
        super::super::codegen::Target::WindowsX64,
        super::super::codegen::Target::WindowsAarch64,
        super::super::codegen::Target::MacOSAarch64,
    ] {
        let p = super::Compiler::with_target(super::with_prelude(src), target)
            .compile()
            .unwrap_or_else(|e| panic!("`{target:?}` compile failed: {e}"));
        assert_eq!(p.tls_data.len(), 8, "single 8-byte TLS slot for {target:?}");
        super::super::object::emit_native_single_tu_for_test(
            &p,
            target,
            super::super::NativeOptions::default(),
        )
        .unwrap_or_else(|e| panic!("`{target:?}` rejected `_Thread_local`: {e}"));
    }
}

#[test]
fn struct_to_struct_assignment_type_mismatch_rejected() {
    // Struct copy works for matching types, but the LHS and RHS
    // must agree -- you can't assign a `Bar` value to a `Foo`
    // local even if the field layouts happen to match.
    expect_compile_error(
        "struct Foo { int x; }; struct Bar { int x; }; \
         int main() { struct Foo a; struct Bar b; a = b; return 0; }",
        "struct types differ on either side of `=`",
    );
}

#[test]
fn forward_declared_struct_pointer_compiles() {
    // A `struct Foo *p` mention before any body is a forward
    // declaration -- the struct stays opaque (size 0, no fields)
    // but pointer types and typedefs can refer to it. This is
    // the C standard's behaviour and a hard requirement for
    // common `typedef struct Foo Foo;`-before-body shapes.
    use super::run_str;
    let exit = run_str("int main() { struct Forward *p; p = 0; return 7; }");
    assert_eq!(exit, 7);
}

#[test]
fn field_access_on_opaque_struct_is_rejected() {
    // The pointer mention above auto-forward-declares; touching
    // a field on the opaque value is still an error -- the
    // struct has no fields to look up. We don't pin the exact
    // wording, just that compilation fails.
    match Compiler::new("int main() { struct Forward *p; p = 0; return p->x; }".to_string())
        .compile()
    {
        Err(_) => {}
        Ok(_) => panic!("expected compile error on field access through opaque struct"),
    }
}

#[test]
fn extern_and_static_keywords_are_no_op_at_global_scope() {
    use super::run_str;
    // `static` (and the accepted `static extern` combination)
    // before the type prefix produce a tentative definition (C99
    // 6.9.2p2): the global lives in .data with zero init.
    let src = "
        static int b;
        static extern int c;
        int main() {
            b = 2; c = 3;
            return b + c;
        }
    ";
    assert_eq!(run_str(src), 5);
    // A file-scope `extern int a;` defines no storage (C99 6.2.2p4
    // / 6.9.2); with no defining TU anywhere, a program that uses
    // it fails with the linker's undefined-reference diagnosis
    // instead of reading phantom zeroed storage.
    let src = "
        extern int a;
        int main() { a = 1; return a; }
    ";
    let err = crate::Vm::new(super::compile_str(src))
        .run()
        .expect_err("undefined extern object must not run");
    assert!(
        err.to_string().contains("undefined reference to `a`"),
        "{err}"
    );
}

#[test]
fn extern_and_static_on_functions_compile() {
    let src = "
        static int helper(int n) { return n + 1; }
        extern int main() { return helper(41); }
    ";
    assert_eq!(super::run_str(&super::with_prelude(src)), 42);
}

#[test]
fn extern_and_static_on_locals_and_params_compile() {
    let src = "
        int f(static int n) {
            static int x;
            x = n;
            return x;
        }
        int main() { return f(42); }
    ";
    assert_eq!(super::run_str(&super::with_prelude(src)), 42);
}

#[test]
fn pragma_export_records_function_on_program() {
    // `#pragma export(<name>)` is the c5 directive that
    // marks a function as externally callable from another
    // image (dlsym / GetProcAddress). The preprocessor
    // recognises it, the compiler validates the name
    // resolves to a function defined here, and the result
    // lands on `Program::exports` for the per-format
    // shared-object writers to consume.
    let src = "
        int answer() { return 42; }
        int helper() { return 1; }
        #pragma export(answer)
        int main() { return 0; }
    ";
    let p = super::Compiler::new(super::with_prelude(src))
        .compile()
        .expect("compile");
    assert_eq!(p.exports.len(), 1, "expected one export");
    assert_eq!(p.exports[0].name, "answer");
    // The recorded PC must point at one of the finished
    // functions' entry positions; the export-resolution path
    // refuses any other value, so this asserts the same
    // invariant from the caller's side.
    assert!(
        p.finished_functions
            .iter()
            .any(|f| f.ent_pc == p.exports[0].ent_pc),
        "exported PC {} should match one of the finished functions' ent_pc values: {:?}",
        p.exports[0].ent_pc,
        p.finished_functions
            .iter()
            .map(|f| (&f.name, f.ent_pc))
            .collect::<alloc::vec::Vec<_>>(),
    );
}

#[test]
fn export_all_functions_exports_non_static() {
    // The `--export-all` driver flag sets `export_all_functions`, so
    // every non-static function defined in the unit is exported without
    // an explicit `#pragma export` -- a runtime `dlopen` consumer
    // resolves it by name. Applies to shared-library and executable
    // output on every native target. A `static` function keeps internal
    // linkage and is not exported.
    let src = "
        static int helper() { return 1; }
        int answer() { return 42 + helper(); }
        int entry() { return answer(); }
    ";
    let opts = crate::c5::compiler::CompileOptions::default()
        .with_export_all_functions(true)
        .with_no_entry_point(true);
    let target = super::super::codegen::Target::default_target();
    let p = super::Compiler::with_options(super::with_prelude(src), target, opts)
        .compile()
        .expect("compile");
    let names: alloc::vec::Vec<&str> = p.exports.iter().map(|e| e.name.as_str()).collect();
    assert!(
        names.contains(&"answer"),
        "non-static `answer` must export: {names:?}"
    );
    assert!(
        names.contains(&"entry"),
        "non-static `entry` must export: {names:?}"
    );
    assert!(
        !names.contains(&"helper"),
        "static `helper` must not export: {names:?}"
    );
}

#[test]
fn pragma_export_with_unknown_name_is_refused() {
    let src = "
        int main() { return 0; }
        #pragma export(missing)
    ";
    let res = super::Compiler::new(super::with_prelude(src)).compile();
    let err = res.expect_err("expected unknown-export to fail");
    let msg = err.to_string();
    assert!(
        msg.contains("no such symbol") || msg.contains("missing"),
        "expected unknown-symbol diagnostic, got: {msg}"
    );
}

#[test]
fn pragma_export_with_global_data_is_refused() {
    // `#pragma export(...)` only handles functions. Pointing it at a
    // global variable surfaces a clear "not a function" diagnostic.
    let src = "
        int counter;
        #pragma export(counter)
        int main() { return 0; }
    ";
    let res = super::Compiler::new(super::with_prelude(src)).compile();
    let err = res.expect_err("expected data-export to fail");
    let msg = err.to_string();
    assert!(
        msg.contains("expected a function"),
        "expected non-function diagnostic, got: {msg}"
    );
}

#[test]
fn libc_call_with_struct_arg_compiles() {
    // A struct passed by value to a Token::Sys (libc) call is packed into the
    // platform-ABI argument registers (SysV / AAPCS64), no longer refused. The
    // runtime ABI is locked in by libc_struct_arg_by_value.c.
    let mut src = super::with_prelude(
        "struct P { int x; int y; };\n\
         int main() {\n\
             struct P p;\n\
             p.x = 1; p.y = 2;\n\
             write(1, p, sizeof(p));\n\
             return 0;\n\
         }",
    );
    src.push('\0');
    assert!(
        Compiler::new(src).compile().is_ok(),
        "struct-by-value to a libc binding should compile"
    );
}

#[test]
fn libc_call_returning_struct_compiles() {
    // A Token::Sys binding declared to return a struct by value is
    // lowered through the native SSA path: the walker tags the CallExt
    // with `ret_agg` and the emitter gathers the result from the
    // platform-ABI return registers (HFA in v-regs, x0/x1 for a small
    // aggregate, or x8 indirect for > 16 bytes) into the result temp.
    // The binding's symbol need not resolve for the parse + codegen to
    // succeed.
    let src = "\
        #pragma dylib(libc, \"libc.so.6\")\n\
        #pragma binding(libc::make_pair, \"make_pair\")\n\
        struct Pair { int a; int b; };\n\
        struct Pair make_pair();\n\
        int main() { struct Pair p; p = make_pair(); return p.a; }\n";
    assert!(
        Compiler::new(src.to_string()).compile().is_ok(),
        "struct-return from a libc binding should compile"
    );
}

#[test]
fn float_modulo_rejected() {
    // `%` on floats is not legal C either; we surface our own error
    // so the message points at the operand rather than at the op.
    expect_compile_error(
        "int main() { float x; x = 1.0; x = x % 2; return 0; }",
        "`%` is not defined on floating-point operands",
    );
}

#[test]
fn float_increment_compiles() {
    // C99 6.5.3.1 / 6.5.2.4: `++` / `--` apply to any real floating type,
    // adding or subtracting 1. The lowering routes a floating lvalue
    // through the FP add path (runtime values pinned by the
    // float_increment_decrement fixture).
    assert!(
        Compiler::new("int main() { float x = 1.0f; x++; --x; return 0; }".to_string())
            .compile()
            .is_ok()
    );
}

#[test]
fn float_int_mixed_addition_auto_promotes() {
    // Mixed int / float operands now auto-promote -- the int side
    // is lifted to f64 (via int-to-float cast for the RHS-int
    // case, or via the spill-recover-cast sequence using a
    // store-local for the LHS-int case). `(double)i + 1.0` and
    // bare `i + 1.0` both compile and produce the same result.
    let src = "int main() { int i; double y; i = 3; y = i + 1.5; return (int)y; }";
    let prog = crate::c5::Compiler::new(src.to_string()).compile().unwrap();
    let vm_result = crate::c5::Vm::new(prog).run().unwrap();
    assert_eq!(vm_result, 4);
}

#[test]
fn duplicate_case_value_is_rejected() {
    // C99 6.8.4.2p3: case constant expressions in one switch must be
    // distinct. Pre-fix this deduped to one block and re-terminated it
    // (debug panic / release silent miscompile).
    expect_compile_error(
        "int main(){ switch(1){ case 1: return 1; case 1: return 2; } return 0; }",
        "duplicate case value",
    );
}

#[test]
fn duplicate_case_value_in_inner_switch_only() {
    // Distinct values across nested switches are fine; the duplicate is
    // detected per switch.
    let src = "int main(){ switch(1){ case 1: switch(2){ case 1: return 1; } return 2; \
               case 1: return 3; } return 0; }";
    expect_compile_error(src, "duplicate case value");
}

#[test]
fn multiple_default_labels_rejected() {
    // C99 6.8.4.2p3: at most one default per switch.
    expect_compile_error(
        "int main(){ switch(1){ default: return 1; default: return 2; } }",
        "multiple default labels",
    );
}

#[test]
fn redefined_goto_label_is_rejected() {
    // C99 6.8.1p3: a label name is unique within its function.
    expect_compile_error(
        "int main(){ goto a; a: a: return 0; }",
        "redefinition of label",
    );
}

#[test]
fn distinct_cases_default_and_per_function_labels_compile() {
    // No false positive: distinct case values, a single default, and the
    // same label name reused in separate functions are all valid.
    let src = "int f(int x){ if(x) goto a; b: return 1; a: goto b; }\n\
               int g(int x){ a: return x; }\n\
               int main(){ int x = 2;\n\
               switch(x){ case 1: return 1; case 2: return 2; default: return 9; }\n\
               return f(0) + g(0); }";
    let prog = crate::c5::Compiler::new(src.to_string()).compile().unwrap();
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 2);
}

#[test]
fn invalid_numeric_literal_with_embedded_underscore_is_rejected() {
    // C99 6.4.8: `1_000` is a single invalid preprocessing number, not a
    // number plus an identifier. Pre-fix it lexed as `1` followed by
    // `_000` and silently set the variable to 1.
    expect_compile_error(
        "int main(){ int a = 1_000; return a; }",
        "invalid numeric constant",
    );
    expect_compile_error(
        "int main(){ long long c = 0x1_0000_0005LL; return (int)c; }",
        "invalid numeric constant",
    );
    expect_compile_error(
        "int main(){ int b = 0b1_01; return b; }",
        "invalid numeric constant",
    );
    expect_compile_error(
        "int main(){ int a = 1abc; return a; }",
        "invalid numeric constant",
    );
}

#[test]
fn valid_numeric_literals_still_compile() {
    // No false positive: every well-formed integer / float form compiles.
    let src = "int main(){ int d=1000; unsigned u=0xFFu; long l=5L; long long e=1ULL;\n\
               int o=010; int b=0b101; double f=1.5e3; float g=2.5f; double h=0x1.8p1;\n\
               return (d==1000 && o==8 && b==5 && f==1500.0 && h==3.0 && u==255) ? 0 : 1; }";
    let prog = crate::c5::Compiler::new(src.to_string()).compile().unwrap();
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
}

#[test]
fn deeply_nested_if_expression_is_rejected_not_a_stack_overflow() {
    // A deeply nested `#if` controlling expression must yield a
    // diagnostic, not overflow the native stack (SIGABRT). The bound is
    // checked in parse_unary, the choke point of every recursive cycle.
    let deep = format!(
        "#if {}1{}\nint x;\n#endif\nint main(void){{ return 0; }}\n",
        "(".repeat(5000),
        ")".repeat(5000),
    );
    expect_compile_error(&deep, "nested too deeply");
    let deep_unary = format!(
        "#if {}1\nint x;\n#endif\nint main(void){{ return 0; }}\n",
        "!".repeat(5000),
    );
    expect_compile_error(&deep_unary, "nested too deeply");
}

#[test]
fn deeply_nested_macro_expansion_does_not_overflow_the_stack() {
    // A chain of macros each referencing the previous expands to a depth
    // proportional to the chain length. The substitution bound must keep
    // it from overflowing the stack; the result terminates (the
    // over-deep tail is left unexpanded) rather than aborting.
    let mut src = String::from("#define A0 1\n");
    for i in 1..3000 {
        src.push_str(&format!("#define A{i} (A{}+1)\n", i - 1));
    }
    src.push_str("int main(void){ return 0; }\n");
    // Must return (Ok or Err), not crash the test process.
    let _ = crate::c5::Compiler::new(src).compile();
}

// C99 6.6p4: a zero divisor in an evaluated constant expression is a
// compile error, not a silent fold to 0; a short-circuited or
// not-taken operand stays unevaluated and must compile.
#[test]
fn constant_expression_division_by_zero_is_diagnosed() {
    expect_compile_error(
        "int x[1/0];\nint main(void){ return 0; }",
        "division by zero in a constant expression",
    );
    expect_compile_error(
        "enum { A = 1 % 0 };\nint main(void){ return 0; }",
        "division by zero in a constant expression",
    );
    expect_compile_error(
        "static int g = 8 / (4 - 4);\nint main(void){ return 0; }",
        "division by zero in a constant expression",
    );
    crate::c5::Compiler::new(
        "int a[1 ? 2 : 1/0];\nint b[0 || 1 ? 2 : 5/0];\nenum { K = 0 && 1/0 };\n\
         int main(void){ return 0; }"
            .to_string(),
    )
    .compile()
    .expect("unevaluated zero divisors must compile");
}

// C99 6.5.5 with the both-operands-wrap model: LLONG_MIN / -1 and
// LLONG_MIN % -1 fold (wrapping) instead of aborting the compiler.
#[test]
fn constant_expression_llong_min_div_neg_one_folds() {
    crate::c5::Compiler::new(
        "static long long k = (-9223372036854775807LL - 1) / -1;\n\
         static long long r = (-9223372036854775807LL - 1) % -1;\n\
         int main(void){ return r == 0 && k != 0 ? 0 : 1; }"
            .to_string(),
    )
    .compile()
    .expect("LLONG_MIN / -1 must fold, not panic");
}

/// Run on a thread with the same explicit stack reservation the CLI
/// driver uses: deeply nested source costs more native stack in debug
/// builds than the default test-thread allotment provides.
fn on_big_stack(f: impl FnOnce() + Send + 'static) {
    std::thread::Builder::new()
        .stack_size(256 * 1024 * 1024)
        .spawn(f)
        .expect("spawn compile thread")
        .join()
        .expect("join compile thread");
}

fn expect_compile_error_on_big_stack(src: String, needle: &'static str) {
    on_big_stack(move || expect_compile_error(&src, needle));
}

#[test]
fn deep_expression_nesting_is_diagnosed() {
    let n = 2000;
    let src = format!(
        "int main(void) {{ return {}1{}; }}",
        "(".repeat(n),
        ")".repeat(n)
    );
    expect_compile_error_on_big_stack(src, "expression nesting too deep");
}

#[test]
fn deep_global_initializer_expression_nesting_is_diagnosed() {
    let n = 2000;
    let src = format!("int x = {}1{};", "(".repeat(n), ")".repeat(n));
    expect_compile_error_on_big_stack(src, "nesting too deep");
}

#[test]
fn deep_declarator_nesting_is_diagnosed() {
    let n = 2000;
    let src = format!("int {}x{};", "(".repeat(n), ")".repeat(n));
    expect_compile_error_on_big_stack(src, "declarator nesting too deep");
}

#[test]
fn deep_initializer_brace_nesting_is_diagnosed() {
    let n = 2000;
    let src = format!(
        "int main(void) {{ int q[1] = {}1{}; return q[0]; }}",
        "{".repeat(n),
        "}".repeat(n)
    );
    expect_compile_error_on_big_stack(src, "initializer nesting too deep");
}

#[test]
fn deep_statement_block_nesting_is_diagnosed() {
    let n = 2000;
    let src = format!(
        "int main(void) {{ {}{} return 0; }}",
        "{".repeat(n),
        "}".repeat(n)
    );
    expect_compile_error_on_big_stack(src, "statement nesting too deep");
}

#[test]
fn c99_minimum_expression_nesting_compiles() {
    // C99 5.2.4.1: 63 nesting levels of parenthesized expressions
    // must be accepted; the depth bound sits far above this.
    let n = 63;
    let src = format!(
        "int main(void) {{ return {}0{}; }}",
        "(".repeat(n),
        ")".repeat(n)
    );
    on_big_stack(move || assert_eq!(super::run_str(&src), 0));
}

#[test]
fn constructor_attribute_is_recorded() {
    // GNU `__attribute__((constructor))` in leading and trailing
    // position, with and without a priority, plus a destructor. Each
    // defined function lands in `Program::init_funcs`; a plain function
    // does not.
    let src = "
        __attribute__((constructor)) void a(void) {}
        void b(void) __attribute__((constructor(101))) {}
        __attribute__((destructor)) void c(void) {}
        void plain(void) {}
        int main(void) { return 0; }
    ";
    let prog = super::compile_str_bare(src);
    let by_name = |n: &str| prog.init_funcs.iter().find(|f| f.name == n);
    let a = by_name("a").expect("a is a constructor");
    assert!(!a.is_destructor && a.priority.is_none());
    let b = by_name("b").expect("b is a constructor");
    assert!(!b.is_destructor && b.priority == Some(101));
    let c = by_name("c").expect("c is a destructor");
    assert!(c.is_destructor && c.priority.is_none());
    assert!(
        by_name("plain").is_none(),
        "plain function is not an init func"
    );
    assert!(by_name("main").is_none(), "main is not an init func");
}

#[test]
fn constructor_attribute_on_prototype_reaches_definition() {
    // The attribute on a separate declaration merges onto the later
    // definition, as gcc's composite type does, for the bare, priority
    // and destructor forms. A repeat on both declarations registers
    // once, and a static prototype-form constructor is not unused.
    let src = "
        void a(void) __attribute__((constructor));
        void a(void) {}
        void b(void) __attribute__((constructor(101)));
        void b(void) {}
        void c(void) __attribute__((destructor));
        void c(void) {}
        void d(void) __attribute__((constructor));
        __attribute__((constructor)) void d(void) {}
        static void e(void) __attribute__((constructor));
        static void e(void) {}
        int main(void) { return 0; }
    ";
    let prog = super::compile_str_bare(src);
    let by_name = |n: &str| prog.init_funcs.iter().find(|f| f.name == n);
    let a = by_name("a").expect("a is a constructor");
    assert!(!a.is_destructor && a.priority.is_none());
    let b = by_name("b").expect("b is a constructor");
    assert!(!b.is_destructor && b.priority == Some(101));
    let c = by_name("c").expect("c is a destructor");
    assert!(c.is_destructor && c.priority.is_none());
    assert_eq!(
        prog.init_funcs.iter().filter(|f| f.name == "d").count(),
        1,
        "attribute on both declarations registers once"
    );
    assert!(by_name("e").is_some(), "e is a constructor");
    let warns = prog.warnings.join("\n");
    assert!(
        !warns.contains("unused function `e`"),
        "prototype-declared constructor must not be flagged unused; got:\n{warns}"
    );
}

#[test]
fn constructor_is_not_reported_unused() {
    // A `static` constructor / destructor has no in-source call site but
    // runs at startup / exit, so it must not draw the unused-function
    // diagnostic (gcc / clang never warn on it).
    let prog = super::compile_str_bare(
        "__attribute__((constructor)) static void a(void) {}\n\
         __attribute__((destructor)) static void b(void) {}\n\
         static void really_unused(void) {}\n\
         int main(void) { return 0; }\n",
    );
    let warns = prog.warnings.join("\n");
    assert!(
        !warns.contains("unused function `a`") && !warns.contains("unused function `b`"),
        "constructor/destructor must not be flagged unused; got:\n{warns}"
    );
    assert!(
        warns.contains("unused function `really_unused`"),
        "a genuinely unused static function should still be flagged; got:\n{warns}"
    );
}

#[test]
fn asm_goto_accepts_output_operands() {
    // GCC 11 `asm goto` outputs: valid on every exit path (the emitters
    // store outputs on the fall-through and each label trampoline).
    Compiler::new(
        "int f(int x) { int o; \
             __asm__ goto(\"nop\" : \"=r\"(o) : \"r\"(x) : : out); \
             return 1; out: return 2; } \
         int main(void) { return f(0); }"
            .to_string(),
    )
    .compile()
    .expect("asm goto with an output operand must compile");
}

#[test]
fn asm_goto_rejects_unknown_label_name() {
    expect_compile_error(
        "int f(int x) { \
             __asm__ goto(\"jmp %l[nope]\" : : \"r\"(x) : : out); \
             return 1; out: return 2; } \
         int main(void) { return f(0); }",
        "`%l[nope]` names no listed label",
    );
}

#[test]
fn asm_goto_rejects_label_number_out_of_range() {
    // One input operand: the only valid reference is `%l1`.
    expect_compile_error(
        "int f(int x) { \
             __asm__ goto(\"jmp %l5\" : : \"r\"(x) : : out); \
             return 1; out: return 2; } \
         int main(void) { return f(0); }",
        "`%l5` is out of range",
    );
}

#[test]
fn asm_goto_rejects_label_number_below_operand_count() {
    // `%l0` names operand 0, not a label (labels number after all
    // operands, so the first label is `%l1` here).
    expect_compile_error(
        "int f(int x) { \
             __asm__ goto(\"jmp %l0\" : : \"r\"(x) : : out); \
             return 1; out: return 2; } \
         int main(void) { return f(0); }",
        "`%l0` is out of range",
    );
}

#[test]
fn auto_type_constraints() {
    // GNU `__auto_type` requires a single plain-identifier declarator
    // with an expression initializer.
    expect_compile_error(
        "int main(void) { __auto_type x = 1, y = 2; return x + y; }",
        "single declarator",
    );
    expect_compile_error(
        "int main(void) { __auto_type *p = 0; return 0; }",
        "plain identifier declarator",
    );
    expect_compile_error(
        "int main(void) { __auto_type z; return 0; }",
        "requires an initializer",
    );
    expect_compile_error(
        "int main(void) { __auto_type b = { 1 }; return b; }",
        "single expression",
    );
}

#[test]
fn asm_goto_requires_a_label() {
    expect_compile_error(
        "int f(int x) { __asm__ goto(\"nop\" : : \"r\"(x) : :); return 1; } \
         int main(void) { return f(0); }",
        "at least one label is required",
    );
}

#[test]
fn asm_goto_undefined_label_is_diagnosed() {
    // A listed label with no matching `name:` in the function body
    // rides the same unresolved-goto check as `goto name;`.
    expect_compile_error(
        "int f(int x) { \
             __asm__ goto(\"jmp %l[nowhere]\" : : \"r\"(x) : : nowhere); \
             return 1; } \
         int main(void) { return f(0); }",
        "unresolved label: nowhere",
    );
}

#[test]
fn asm_goto_accepts_forward_and_backward_labels() {
    // Acceptance only (no native emit): both reference spellings and a
    // backward label parse and lower.
    super::compile_str_bare(
        "int f(int n) { int c = 0; \
         loop: c++; n--; \
             __asm__ goto(\"nop\" : : \"r\"(n) : : loop, done); \
             return c; \
         done: return c + 1; } \
         int main(void) { return f(1); }",
    );
}

#[test]
fn declarator_asm_label_renames_the_emitted_symbol() {
    // A GNU asm-label sets the assembler symbol name; the identifier keeps
    // its own identity, so it stays the lookup key and the only spelling the
    // source may use.
    super::compile_str_bare("int g asm(\"g\"); int main(void) { return g; }");
    let p = super::compile_str_bare("int g asm(\"real_g\"); int main(void) { return g; }");
    let g = p
        .symbols
        .iter()
        .find(|s| s.name == "g")
        .expect("identifier stays the symbol-table key");
    assert_eq!(g.link_name(), "real_g");
    // One identifier, one assembler name: restating it is fine, changing it
    // is not.
    super::compile_str_bare(
        "int f(void) asm(\"r\"); int f(void) asm(\"r\"); int f(void) { return 0; } \
         int main(void) { return f(); }",
    );
    expect_compile_error(
        "int f(void) asm(\"a\"); int f(void) asm(\"b\"); int main(void) { return 0; }",
        "conflicting assembler name `b` for `f`, already declared as `a`",
    );
}

#[test]
fn register_asm_binding_constraints() {
    // `register T name asm("reg")` requires the `register` storage
    // class, a bindable register for the target, automatic storage,
    // and (for the stack / frame pointer) read-only use.
    // Without `register` the suffix is an asm-label, which an automatic
    // object has no symbol to carry; gcc ignores it with a warning.
    super::compile_str_bare("int main(void) { long x asm(\"rax\"); return 0; }");
    expect_compile_error(
        "int main(void) { register long x asm(\"nosuch\"); return (int)x; }",
        "is not a bindable register",
    );
    expect_compile_error(
        "int main(void) { static register long x asm(\"rax\"); return 0; }",
        "cannot be `static` or `extern`",
    );
    #[cfg(target_arch = "x86_64")]
    {
        expect_compile_error(
            "int main(void) { register long x asm(\"rsp\"); x = 5; return 0; }",
            "cannot write register variable",
        );
    }
    #[cfg(target_arch = "aarch64")]
    {
        expect_compile_error(
            "int main(void) { register long x asm(\"sp\"); x = 5; return 0; }",
            "cannot write register variable",
        );
        expect_compile_error(
            "int main(void) { register long x asm(\"x16\"); return 0; }",
            "reserved and cannot hold a register variable",
        );
    }
}

#[test]
fn register_asm_binding_target_specific_registers() {
    use super::super::codegen::Target;
    // x86-64: every GPR is bindable, including r10 / r11 (the asm
    // emitter picks its staging scratch around bound operands; a
    // hypercall-style ABI names r10 for an argument).
    let bind = |reg: &str| {
        format!(
            "int main(void) {{ register long v asm(\"{reg}\") = 1; long o; __asm__(\"movq %1, %0\" : \"=r\"(o) : \"r\"(v)); return (int)o; }}"
        )
    };
    for reg in ["r10", "r11"] {
        assert!(
            compile_for_target(&bind(reg), Target::LinuxX64).is_ok(),
            "x86-64 `{reg}` must be bindable"
        );
    }

    // AArch64: GCC's `rN` spelling aliases `xN` (the SMCCC headers spell
    // hypercall operands `asm("r0")`); x16/x17 stay reserved either way.
    for reg in ["r0", "r7", "x0"] {
        assert!(
            compile_for_target(&bind(reg), Target::LinuxAarch64).is_ok(),
            "aarch64 `{reg}` must be bindable"
        );
    }
    for reg in ["r16", "x16"] {
        let e = compile_for_target(&bind(reg), Target::LinuxAarch64).unwrap_err();
        assert!(
            e.contains("reserved and cannot hold a register variable"),
            "{e}"
        );
    }
}

#[test]
fn register_asm_binding_concatenates_adjacent_literals() {
    // C99 5.1.1.2 phase 6: the register-name operand of a register-asm
    // declarator joins adjacent string literals before resolving the
    // register, matching gcc and clang. Macro-pasted headers spell the
    // name in pieces, e.g. `asm("%" "rdx")`.
    use super::super::codegen::Target;
    let x64 = Target::LinuxX64;
    let a64 = Target::LinuxAarch64;
    // Block-scope binding: `%`-prefixed and unprefixed splits, two and
    // three pieces, all equivalent to the single-literal spelling.
    for (form, target) in [
        ("\"%\" \"rdx\"", x64),
        ("\"r\" \"dx\"", x64),
        ("\"%\" \"r\" \"dx\"", x64),
        ("\"rd\" \"x\"", x64),
        ("\"x\" \"9\"", a64),
        ("\"x\" \"1\" \"9\"", a64),
    ] {
        let src =
            alloc::format!("int main(void){{ register long v asm({form}); return (int)v; }}\n");
        assert!(
            compile_for_target(&src, target).is_ok(),
            "split register name {form} should compile: {:?}",
            compile_for_target(&src, target).err()
        );
    }
    // File-scope stack-pointer binding uses the same suffix parser.
    assert!(
        compile_for_target(
            "register unsigned long sp asm(\"r\" \"sp\");\n\
             unsigned long f(void) { return sp; }\n\
             int main(void) { return 0; }\n",
            x64
        )
        .is_ok(),
        "file-scope split stack-pointer binding should compile"
    );
    // A split that joins to an unknown register is rejected, and the
    // diagnostic names the joined text rather than a partial piece.
    let err = compile_for_target(
        "int main(void) { register long v asm(\"no\" \"such\"); return (int)v; }\n",
        x64,
    )
    .expect_err("unknown joined register must be rejected");
    assert!(
        err.contains("nosuch") && err.contains("not a bindable register"),
        "diagnostic must name the joined register text: {err}"
    );
}

#[test]
fn file_scope_register_asm_binding() {
    // `register T name asm("reg")` at file scope: stack- / frame-pointer
    // bindings are accepted, repeatable, shadowable, and read-only; a
    // general-purpose register or a storage-class conflict is rejected.
    #[cfg(target_arch = "x86_64")]
    let (sp, fp, gp) = ("rsp", "rbp", "r12");
    #[cfg(target_arch = "aarch64")]
    let (sp, fp, gp) = ("sp", "x29", "x9");
    let ok = |src: &str| {
        Compiler::new(src.to_string())
            .compile()
            .unwrap_or_else(|e| panic!("expected accept, got {e}"))
    };
    // Repeat declaration (header re-inclusion), reads from several
    // functions, shadowing by a local and by a parameter.
    let prog = ok(&format!(
        "register unsigned long sp_reg asm(\"{sp}\");\n\
         register unsigned long sp_reg asm(\"{sp}\");\n\
         unsigned long f(void) {{ return sp_reg; }}\n\
         unsigned long g(int sp_reg) {{ return (unsigned long)sp_reg; }}\n\
         int main(void) {{ unsigned long v = sp_reg; {{ long sp_reg = 3; v += (unsigned long)sp_reg; }} return (int)(v == 0); }}\n"
    ));
    // No storage and no symbol: the binding is not a data global.
    assert!(
        !prog
            .symbols
            .iter()
            .any(|s| s.name == "sp_reg" && s.class == crate::c5::token::Token::Glo as i64),
        "file-scope register variable must not become a data global"
    );
    expect_compile_error(
        &format!("register long x asm(\"{gp}\"); int main(void) {{ return (int)x; }}"),
        "supported for the stack and frame pointer only",
    );
    expect_compile_error(
        &format!("static register long x asm(\"{sp}\"); int main(void) {{ return 0; }}"),
        "cannot be `static` or `extern`",
    );
    expect_compile_error(
        &format!("register long x asm(\"{sp}\") = 1; int main(void) {{ return 0; }}"),
        "cannot be initialized",
    );
    expect_compile_error(
        &format!("register long x asm(\"{sp}\"); int main(void) {{ x = 1; return 0; }}"),
        "cannot write register variable",
    );
    expect_compile_error(
        &format!(
            "register long x asm(\"{sp}\"); register long x asm(\"{fp}\"); int main(void) {{ return 0; }}"
        ),
        "conflicts with a prior declaration",
    );
    expect_compile_error(
        &format!("int x; register long x asm(\"{sp}\"); int main(void) {{ return 0; }}"),
        "conflicts with a prior declaration",
    );
    // Without `register` the declarator asm suffix is a GNU asm-label, which
    // renames the emitted symbol rather than binding a register.
    let p = super::compile_str_bare("long x asm(\"renamed\"); int main(void) { return 0; }");
    assert_eq!(
        p.symbols
            .iter()
            .find(|s| s.name == "x")
            .map(crate::c5::symbol::Symbol::link_name),
        Some("renamed")
    );
}

#[test]
fn two_identifiers_in_declarator_position_are_rejected() {
    // C99 6.7p1: the declarators of one declaration are comma-separated
    // and the list ends at `;`. A second identifier after a declarator is
    // a syntax error at both file and block scope; a bare identifier that
    // is not a recognized type qualifier must not be read as one.
    for src in [
        "int foo bar; int main(void) { return 0; }",
        "int a b c; int main(void) { return 0; }",
        "extern int foo bar; int main(void) { return 0; }",
        "static int foo bar; int main(void) { return 0; }",
        "int *p q; int main(void) { return 0; }",
        "int a = 1 b; int main(void) { return 0; }",
        "int main(void) { int foo bar; return 0; }",
        "int main(void) { int a = 1 b; return 0; }",
    ] {
        expect_compile_error(src, "expected `,` or `;` after declarator");
    }
}

#[test]
fn seg_address_space_qualifiers_parse_as_qualifiers() {
    // `__seg_gs` / `__seg_fs` are x86 named-address-space qualifiers, valid
    // wherever `const` / `volatile` are: on a base type, in a cast, and
    // trailing a `typeof` operand. None of these shapes access the segment
    // (address computation only), so they lower on any target.
    for src in [
        "int __seg_gs g; int main(void){ return 0; }",
        "int __seg_fs f; int main(void){ return 0; }",
        "void f(unsigned long *p){ unsigned long __seg_gs *q = \
         (unsigned long __seg_gs *)p; (void)q; } int main(void){ return 0; }",
        "extern unsigned long v; void g(void){ unsigned long __seg_gs *q = \
         (typeof(v) __seg_gs *)(__UINTPTR_TYPE__)&v; (void)q; } int main(void){ return 0; }",
    ] {
        Compiler::new(src.to_string())
            .compile()
            .unwrap_or_else(|e| panic!("expected `{src}` to compile, got {e}"));
    }
}

#[test]
fn seg_qualified_automatic_storage_is_rejected() {
    // TR 18037 5.1.2: an object in a named address space needs static
    // storage. A local or parameter object in `__seg_gs` is rejected; a
    // pointer *into* the space carries the qualifier on the pointee and
    // stays valid automatic storage (asserted by the accept cases above).
    for src in [
        "int f(void){ int __seg_gs x; x = 1; return x; } int main(void){ return 0; }",
        "int f(int __seg_gs x){ return x; } int main(void){ return 0; }",
    ] {
        let err = Compiler::new(src.to_string())
            .compile()
            .expect_err("seg-qualified automatic storage must be rejected")
            .to_string();
        assert!(
            err.contains("a named address space requires static storage"),
            "unexpected diagnostic for `{src}`: {err}"
        );
    }
}

// Reaches the SSA walk (via native emit), so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn direct_seg_access_lowers_on_x86_and_is_rejected_elsewhere() {
    use crate::{NativeOptions, Target};
    // A direct read / write through a `__seg_gs` / `__seg_fs` pointer lowers to
    // a segment-prefixed access on x86 (the encoding is asserted in the linker
    // tests). A target without segment registers has no lowering and rejects
    // rather than dropping the qualifier (a silent wrong-address access).
    let emit = |src: &str, target: Target| {
        let program = Compiler::with_target(src.to_string(), target)
            .compile()
            .expect("parse");
        crate::c5::object::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::default(),
        )
    };
    let read = "extern unsigned long v; unsigned long r(void){ \
         return *(unsigned long __seg_gs *)(__UINTPTR_TYPE__)&v; } int main(void){ return 0; }";
    let write = "extern unsigned long v; void w(unsigned long x){ \
         *(unsigned long __seg_gs *)(__UINTPTR_TYPE__)&v = x; } int main(void){ return 0; }";
    emit(read, Target::LinuxX64).expect("x86 seg read lowers");
    emit(write, Target::LinuxX64).expect("x86 seg write lowers");
    let read_err = emit(read, Target::LinuxAarch64)
        .expect_err("aarch64 rejects a direct seg read")
        .to_string();
    let write_err = emit(write, Target::LinuxAarch64)
        .expect_err("aarch64 rejects a direct seg write")
        .to_string();
    assert!(read_err.contains("__seg_gs/__seg_fs access (x86 only)"));
    assert!(write_err.contains("__seg_gs/__seg_fs access (x86 only)"));
}

#[test]
fn declaration_lists_still_parse() {
    // The separator check must not disturb the legitimate shapes: multiple
    // declarators, initializers, pointers, arrays and their designators,
    // prototypes, typedef and tag names, attributes and old-style
    // parameter declarations.
    let ok = |src: &str| {
        Compiler::new(src.to_string())
            .compile()
            .unwrap_or_else(|e| panic!("expected accept for {src:?}, got {e}"))
    };
    ok("int a, b; int main(void) { return a + b; }");
    ok("int *p, q = 3; int main(void) { return q; }");
    ok("int a[3] = {1, 2, 3}, b = 4; int main(void) { return a[0] + b; }");
    ok("int m[2][2] = {[0][1] = 3, [1][0] = 4}; int main(void) { return m[0][1]; }");
    ok(
        "struct P { int x, y; }; struct P a[2] = {{1, 2}, {3, 4}}, b = {5, 6}; \
        int main(void) { return a[0].x + b.x; }",
    );
    ok("int f(int), g(void); int main(void) { return g(); }");
    ok("typedef int mi; mi v; int main(void) { return v; }");
    ok("typedef int A, B; int main(void) { A a = 1; B b = 2; return a + b; }");
    ok("typedef int (*F)(int); F a, b; int main(void) { return a == b; }");
    ok("struct S { int m; }; struct S s; int main(void) { return s.m; }");
    ok("enum E { A, B }; enum E e; int main(void) { return e; }");
    ok("int x __attribute__((unused)); int main(void) { return 0; }");
    ok("extern int e; int main(void) { return e; }");
    ok("char *s = \"a\", *t = \"b\"; int main(void) { return s[0] + t[0]; }");
    // Old-style definition: the parameter declarations are their own
    // declarations, each ending at its `;`.
    ok("int f(a, b) int a; int b; { return a + b; } int main(void) { return f(1, 2); }");
    ok("int main(void) { int a = 1, *p = &a, c[2] = {1, 2}; return a + *p + c[0]; }");
    ok("int main(void) { typedef int T; T v = 1; return v; }");
    ok("int main(void) { static int s = 5; return s; }");
}

#[test]
fn asm_output_operand_lvalue_matrix() {
    // A stack- / frame-pointer register variable names a register, not an
    // object: it is a valid output operand even though it has no address.
    // Everything else keeps the lvalue requirement, including
    // `__builtin_frame_address`, which reads back as the same intrinsic a
    // frame-pointer register variable does but is not an lvalue.
    #[cfg(target_arch = "x86_64")]
    let (sp, fp, gp) = ("rsp", "rbp", "r12");
    #[cfg(target_arch = "aarch64")]
    let (sp, fp, gp) = ("sp", "x29", "x9");
    let ok = |src: &str| {
        Compiler::new(src.to_string())
            .compile()
            .unwrap_or_else(|e| panic!("expected accept for {src:?}, got {e}"))
    };
    // A stack- / frame-pointer operand binds on x86_64. AArch64's asm
    // surface is pattern-matched rather than constraint-driven, so it
    // diagnoses the operand instead of binding it.
    #[cfg(target_arch = "x86_64")]
    let sp_fp_operand = ok;
    #[cfg(target_arch = "aarch64")]
    let sp_fp_operand = |src: &str| {
        expect_compile_error(src, "register variable operand is not supported");
    };
    // File-scope binding used as a read-write output: a template that
    // perturbs the stack pointer declares it this way.
    sp_fp_operand(&format!(
        "register unsigned long sp_reg asm(\"{sp}\");\n\
         int main(void) {{ return 0; }} void f(void) {{ __asm__ __volatile__(\"\" : \"+r\"(sp_reg) : : \"memory\"); }}"
    ));
    // Block-scope bindings, write-only and read-write, stack and frame.
    sp_fp_operand(&format!(
        "int main(void) {{ return 0; }} void f(void) {{ register unsigned long s asm(\"{sp}\"); \
         __asm__ __volatile__(\"\" : \"=r\"(s) : : \"memory\"); }}"
    ));
    sp_fp_operand(&format!(
        "int main(void) {{ return 0; }} void f(void) {{ register unsigned long b asm(\"{fp}\"); \
         __asm__ __volatile__(\"\" : \"+r\"(b) : : \"memory\"); }}"
    ));
    // A general-purpose register variable and the ordinary lvalue forms
    // keep working as outputs.
    ok(&format!(
        "int main(void) {{ return 0; }} void f(void) {{ register long r asm(\"{gp}\"); \
         __asm__ __volatile__(\"\" : \"=r\"(r)); }}"
    ));
    ok("struct S { int m; }; \
        int main(void) { return 0; } void f(struct S *p, int *q, int a[2]) { int v; \
        __asm__(\"\" : \"=r\"(v)); __asm__(\"\" : \"=r\"(p->m)); \
        __asm__(\"\" : \"=r\"(*q)); __asm__(\"\" : \"=r\"(a[1])); }");
    // Genuine rvalues stay rejected: a call result, a cast, and the
    // frame-address intrinsic.
    expect_compile_error(
        "int g(void); int main(void) { return 0; } void f(void) { __asm__(\"\" : \"=r\"(g())); }",
        "output operand must be an lvalue",
    );
    expect_compile_error(
        "int main(void) { return 0; } void f(long a) { __asm__(\"\" : \"=r\"((int)a)); }",
        "output operand must be an lvalue",
    );
    expect_compile_error(
        "int main(void) { return 0; } void f(void) { __asm__(\"\" : \"=r\"(__builtin_frame_address(0))); }",
        "output operand must be an lvalue",
    );
    // A memory operand still needs an address.
    expect_compile_error(
        "int g(void); int main(void) { return 0; } void f(void) { int r; __asm__(\"\" : \"=r\"(r) : \"m\"(g())); }",
        "not directly addressable",
    );
}

#[test]
fn file_scope_asm_constraints() {
    // `asm("...")` between declarations accepts section data
    // directives (and an empty template); instructions, operands,
    // `goto`, and malformed section stacks are rejected.
    let ok = |src: &str| {
        Compiler::new(src.to_string())
            .compile()
            .unwrap_or_else(|e| panic!("expected accept, got {e}"));
    };
    ok("asm(\"\"); int main(void) { return 0; }");
    ok(
        "__asm__(\".pushsection .note.x,\\\"a\\\"\\n.long 1\\n.popsection\");\n\
        int main(void) { return 0; }",
    );
    ok(
        "asm volatile(\".section .modinfo,\\\"a\\\"\\n.asciz \\\"v=1\\\"\\n.previous\");\n\
        int main(void) { return 0; }",
    );
    // `.globl` / `.global` outside a section gives the named symbol
    // external linkage; a name this unit does not define has no effect.
    ok("static int f(void) { return 0; } asm(\".globl f\"); int main(void) { return f(); }");
    ok("static int v = 1; __asm__(\".global v\"); int main(void) { return v - 1; }");
    ok("asm(\".globl f\"); static int f(void) { return 0; } int main(void) { return f(); }");
    ok("asm(\".globl nosuchsymbol\"); int main(void) { return 0; }");
    ok("static int f(void) { return 0; }\n\
         asm(\".pushsection .a,\\\"a\\\"\\n.quad 1\\n.popsection\\n.globl f\");\n\
         int main(void) { return f(); }");
    // A bare instruction at file scope assembles into `.text`, as GNU as does
    // (`asm("nop")` emits a nop into the current section). File-scope
    // instruction assembly is x86-only, so pin the target rather than the host.
    Compiler::with_target(
        "asm(\"nop\"); int main(void) { return 0; }".to_string(),
        crate::c5::Target::LinuxX64,
    )
    .compile()
    .unwrap_or_else(|e| panic!("expected accept, got {e}"));
    // `.globl` with no operand is not a directive this accepts.
    expect_compile_error(
        "asm(\".globl\"); int main(void) { return 0; }",
        "bad `.globl` operand",
    );
    expect_compile_error(
        "asm(\".pushsection .a,\\\"a\\\"\\n.quad 1\\n.popsection\" : : \"r\"(1));\n\
         int main(void) { return 0; }",
        "operands are not supported at file scope",
    );
    expect_compile_error(
        "asm goto(\"x\"); int main(void) { return 0; }",
        "`asm goto` is not supported at file scope",
    );
    expect_compile_error(
        "asm(\".pushsection .a,\\\"a\\\"\\n.long %0\\n.popsection\");\n\
         int main(void) { return 0; }",
        "no operands at file scope",
    );
    expect_compile_error(
        "asm(\".pushsection .a,\\\"a\\\"\\n.popsection\\n.popsection\");\n\
         int main(void) { return 0; }",
        "`.popsection` without `.pushsection`",
    );
    expect_compile_error(
        "asm(\".pushsection .a,\\\"a\\\"\\n.unknowndir 1\\n.popsection\");\n\
         int main(void) { return 0; }",
        "unsupported directive",
    );
}

#[test]
fn section_and_alias_operand_constraints() {
    // `section` / `alias` take a string-literal operand; an alias
    // target must be defined somewhere in the unit (the definition may
    // follow the alias declarator).
    expect_compile_error(
        "__attribute__((section(data))) int x; int main(void) { return x; }",
        "must be a string literal",
    );
    expect_compile_error(
        "int aka(void) __attribute__((alias(\"missing\")));\n\
         int main(void) { return aka(); }",
        "not a function defined in this unit",
    );
    expect_compile_error(
        "int aka __attribute__((alias(\"missing_obj\")));\n\
         int main(void) { return aka; }",
        "not an object defined in this unit",
    );
}

fn expect_compiles(src: &str, what: &str) {
    assert!(
        Compiler::new(src.to_string()).compile().is_ok(),
        "{} should compile, got {:?}",
        what,
        Compiler::new(src.to_string()).compile().err(),
    );
}

#[test]
fn empty_declaration_accepted_where_gcc_accepts_it() {
    // A stray `;` declares nothing. gcc and clang accept an empty
    // declaration in a struct/union member list and at file scope
    // (diagnosed only under `-pedantic`).
    expect_compiles(
        "struct S { void *lock;; };\n\
         int main(void) { struct S s; s.lock = 0; return s.lock != 0; }",
        "a trailing `;` in a member list",
    );
    expect_compiles(
        "struct S { ; int x; };\n\
         int main(void) { struct S s; s.x = 0; return s.x; }",
        "a leading `;` in a member list",
    );
    expect_compiles(
        "struct S { ; };\n\
         int main(void) { struct S s; (void)s; return 0; }",
        "a member list holding only `;`",
    );
    expect_compiles(
        "union U { int a;;; long b; };\n\
         int main(void) { union U u; u.a = 0; return u.a; }",
        "repeated `;` in a union member list",
    );
    expect_compiles(
        "int a;;\n; int b;\n\
         int main(void) { a = 0; b = 0; return a + b; }",
        "an empty declaration at file scope",
    );
}

#[test]
fn empty_declaration_in_enum_list_rejected() {
    // gcc and clang both reject a `;` in an enumerator list ("expected
    // ',' or '}'"), so the member-list extension does not extend here.
    expect_compile_error(
        "enum E { A;, B };\n\
         int main(void) { return A; }",
        "bad enum identifier",
    );
}

#[test]
fn conditional_pointer_arm_result_type() {
    // C99 6.5.15p6, checked through `sizeof` of the dereferenced
    // result. A null pointer constant is a value, not a spelling:
    // `(void *)0` yields the other arm's type but `(void *)(x * 0)`
    // does not. Contrasted against gcc and clang.
    let cases: &[(&str, &str)] = &[
        (
            "void* vs int* yields void*",
            "sizeof(*(8 ? ((void *)((long)(g) * 0l)) : (int *)8)) == 1",
        ),
        (
            "arm order does not matter",
            "sizeof(*(8 ? (int *)8 : ((void *)((long)(g) * 0l)))) == 1",
        ),
        (
            "(void*)0 is a null pointer constant",
            "sizeof(*(8 ? (void *)0 : (int *)8)) == sizeof(int)",
        ),
        (
            "folded zero is a null pointer constant",
            "sizeof(*(8 ? (void *)((long)0 * 0l) : (int *)8)) == sizeof(int)",
        ),
        (
            "struct* survives a null pointer constant",
            "sizeof(*(g ? (struct s *)&g : (void *)0)) == 2 * sizeof(int)",
        ),
        (
            "struct* survives a plain 0",
            "sizeof(*(g ? (struct s *)&g : 0)) == 2 * sizeof(int)",
        ),
        (
            "void* beats struct*",
            "sizeof(*(g ? (void *)&g : (struct s *)&g)) == 1",
        ),
    ];
    for (what, cond) in cases {
        let src = alloc::format!(
            "struct s {{ int a; int b; }};\n\
             int g;\n\
             int main(void) {{ return !({cond}); }}\n"
        );
        expect_compiles(&src, what);
    }
}

#[test]
fn aggregate_with_no_named_member_is_zero_sized() {
    // gcc and clang give a struct with no named member size 0 in C
    // (C++ floors it at 1). The compile-time assertion idiom
    // `sizeof(struct { int:-!!(e); })` depends on the 0.
    expect_compiles(
        "int main(void) { return sizeof(struct {}) + sizeof(struct { int : 0; }); }",
        "a struct with no named member",
    );
}

#[test]
fn member_of_incomplete_aggregate_type_rejected() {
    // C99 6.7.2.1: a member must have complete type, and an array of an
    // incomplete type is itself incomplete. gcc and clang reject both.
    expect_compile_error(
        "struct fwd; struct s { struct fwd f; }; int main(void) { return 0; }",
        "incomplete type",
    );
    expect_compile_error(
        "struct fwd; struct s { struct fwd f[2]; }; int main(void) { return 0; }",
        "incomplete type",
    );
    // A complete but zero-sized member stays accepted.
    expect_compiles(
        "struct s { struct {} e; int x; };\n\
         int main(void) { struct s v; v.x = 0; return v.x; }",
        "an empty struct member",
    );
}

/// Compile `src` for `target`, returning the error text on failure.
fn compile_for_target(
    src: &str,
    target: super::super::codegen::Target,
) -> Result<(), alloc::string::String> {
    super::Compiler::with_target(alloc::string::String::from(src), target)
        .compile()
        .map(|_| ())
        .map_err(|e| e.to_string())
}

#[test]
fn typedef_aligned_type_attribute_layout_linux_x64() {
    // A GNU `aligned(N)` type attribute on a typedef sets the aliased
    // type's alignment. Pinned to LinuxX64 (LP64) so the exact ABI sizes
    // and offsets are locked: a reducing `aligned(4)` lowers an 8-byte
    // type's field to a 4-byte boundary; an increasing `aligned(16)`
    // raises it. Any layout drift fails the `_Static_assert`s below.
    let src = "\
        typedef unsigned long long __attribute__((aligned(4))) u64a4;\n\
        typedef int __attribute__((aligned(16))) i16;\n\
        struct SR { int a; u64a4 b; };\n\
        struct SI { char a; i16 b; };\n\
        _Static_assert(__alignof__(u64a4) == 4, \"reduce\");\n\
        _Static_assert(__alignof__(i16) == 16, \"increase\");\n\
        _Static_assert(sizeof(struct SR) == 12, \"SR size\");\n\
        _Static_assert(__builtin_offsetof(struct SR, b) == 4, \"SR off\");\n\
        _Static_assert(sizeof(struct SI) == 32, \"SI size\");\n\
        _Static_assert(__builtin_offsetof(struct SI, b) == 16, \"SI off\");\n\
        int main(void) {\n\
            typedef unsigned long long __attribute__((aligned(4))) lu64;\n\
            struct BR { int a; lu64 b; };\n\
            struct After { int a; unsigned long long b; };\n\
            _Static_assert(sizeof(struct BR) == 12, \"block reduce\");\n\
            _Static_assert(sizeof(struct After) == 16, \"no attribute leak\");\n\
            return 0;\n\
        }\n";
    assert!(
        compile_for_target(src, super::super::codegen::Target::LinuxX64).is_ok(),
        "aligned-typedef layout must match the LP64 ABI: {:?}",
        compile_for_target(src, super::super::codegen::Target::LinuxX64).err()
    );
}

#[test]
fn stack_pointer_register_variable_as_asm_operand() {
    // GCC binds an `r` operand naming a register variable to that
    // register. The stack and frame pointers have no storage behind
    // them, so such an operand transfers no value: `"+r"` marks the
    // block as reading and disturbing the register rather than
    // requesting a new one be installed.
    let x64 = super::super::codegen::Target::LinuxX64;
    let decl = "register unsigned long csp asm(\"rsp\");\n\
                register unsigned long cfp asm(\"rbp\");\n\
                void ext(void);\n";
    for (what, body) in [
        (
            "a read-write stack-pointer marker",
            "asm volatile(\"call ext\" : \"+r\"(csp) :: \"memory\");",
        ),
        (
            "a stack-pointer input",
            "unsigned long o; asm(\"movq %1, %0\" : \"=r\"(o) : \"r\"(csp)); (void)o;",
        ),
        (
            "a stack-pointer output",
            "asm volatile(\"nop\" : \"=r\"(csp));",
        ),
        (
            "a frame-pointer input",
            "unsigned long o; asm(\"movq %1, %0\" : \"=r\"(o) : \"r\"(cfp)); (void)o;",
        ),
        (
            "a non-bare stack-pointer expression",
            "unsigned long o; asm(\"movq %1, %0\" : \"=r\"(o) : \"r\"(csp + 8)); (void)o;",
        ),
    ] {
        let src = alloc::format!("{decl}int main(void) {{ {body} return 0; }}\n");
        assert!(
            compile_for_target(&src, x64).is_ok(),
            "{what} should compile: {:?}",
            compile_for_target(&src, x64).err(),
        );
    }

    // Assigning to a storage-less register variable stays rejected:
    // the frame layout owns the stack pointer, so badc will not emit a
    // write it cannot honor.
    let src = alloc::format!("{decl}int main(void) {{ csp = 0; return 0; }}\n");
    let err = compile_for_target(&src, x64).expect_err("assignment must be rejected");
    assert!(
        err.contains("cannot write register variable"),
        "unexpected error: {err}"
    );
}

#[test]
fn nested_block_declaration_diagnostics_match_the_function_body() {
    // A declaration inside a nested block goes through the same parser as
    // one at the function-body top level, so it is held to the same
    // constraints.

    // C99 6.7p3: an identifier with no linkage is declared once per scope.
    expect_compile_error(
        "int main(void) { { int a = 1; int a = 2; return a; } }",
        "duplicate local definition",
    );
    // A second identifier after a declarator ends the declaration; it is a
    // syntax error, not another declarator. This is how an unrecognized
    // type qualifier reads, so accepting it silently declares an extra
    // object of the base type.
    expect_compile_error(
        "int main(void) { { int a b; return 0; } }",
        "expected `,` or `;` after declarator",
    );
    // Redeclaring in an inner scope stays legal (C99 6.2.1p4).
    let shadowing = "int main(void) { int a = 1; { int a = 2; if (a != 2) return 1; } \
                     return a == 1 ? 0 : 2; }";
    assert!(
        Compiler::new(shadowing.to_string()).compile().is_ok(),
        "an inner-scope redeclaration must stay accepted"
    );
}

#[test]
fn enum_redeclaration_in_same_scope_is_diagnosed() {
    // C99 6.2.1p4: parameters share the function body's outermost scope,
    // and 6.7p3 allows one no-linkage declaration per scope, so an
    // enumerator there redeclares the parameter.
    expect_compile_error(
        "int f(int x) { enum { x = 3 }; return 0; } int main(void) { return f(1); }",
        "redeclaration of `x` in the same scope",
    );
    // Same constraint between two function-body declarations, in either
    // order, and inside one nested block.
    expect_compile_error(
        "int main(void) { int y = 1; enum { y }; return y; }",
        "redeclaration of `y` in the same scope",
    );
    expect_compile_error(
        "int main(void) { enum { y }; int y = 1; return y; }",
        "duplicate local definition",
    );
    expect_compile_error(
        "int main(void) { { int z = 1; enum { z }; return z; } }",
        "redeclaration of `z` in the same scope",
    );
}

#[test]
fn enum_constant_unbinds_at_scope_exit() {
    // C99 6.2.1p4: the enumerator shadows the file-scope object inside
    // its block and the object returns at block exit.
    let block = "int x = 7;\n\
                 int f(void) { { enum { x = 3 }; if (x != 3) return 1; } return x == 7 ? 0 : 2; }\n\
                 int main(void) { return f(); }";
    let prog = Compiler::new(block.to_string()).compile().unwrap();
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
    // Function-body scope: restored at function exit, so the next
    // function reads the file-scope object again.
    let body = "int x = 7;\n\
                int f(void) { enum { x = 3 }; return x; }\n\
                int g(void) { return x; }\n\
                int main(void) { return f() == 3 && g() == 7 ? 0 : 1; }";
    let prog = Compiler::new(body.to_string()).compile().unwrap();
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
}

#[test]
fn block_fn_declaration_unbinds_at_scope_exit() {
    // In scope, the declaration resolves the call against the later
    // definition (C99 6.2.2p4: one entity with external linkage).
    let ok = "int f(void) { int one8(void); return one8(); }\n\
              int one8(void) { return 8; }\n\
              int main(void) { return f() == 8 ? 0 : 1; }";
    let prog = Compiler::new(ok.to_string()).compile().unwrap();
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
    // Out of scope the name is undeclared again (C99 6.2.1p4).
    expect_compile_error(
        "void f(void) { { int q8(void); } } int main(void) { return q8 != 0; }",
        "undefined variable q8",
    );
    // A later declarator of the same name in the same scope is a
    // no-linkage redeclaration (C99 6.7p3).
    expect_compile_error(
        "int main(void) { int q9(void); int q9 = 1; return q9; }",
        "duplicate local definition",
    );
    // A bare-function-type declarator (`F g;`) binds the same way and
    // unbinds with its block.
    let td = "typedef int F(void);\n\
              int f(void) { F one9; return one9(); }\n\
              int one9(void) { return 9; }\n\
              int main(void) { return f() == 9 ? 0 : 1; }";
    let prog = Compiler::new(td.to_string()).compile().unwrap();
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
    expect_compile_error(
        "typedef int F(void); void f(void) { { F q10; } } int main(void) { return q10 != 0; }",
        "undefined variable q10",
    );
}

#[test]
fn block_typedef_redeclaration_rules() {
    // C11 6.7p3 admits a same-scope typedef redeclared as a typedef;
    // only the first save is kept, so the scope exit still restores
    // the outer binding once.
    let ok = "typedef char T;\n\
              int f(void) { typedef int T; typedef int T; T v = 3; return v; }\n\
              int main(void) { T w = 4; return f() == 3 && sizeof(w) == 1 ? 0 : 1; }";
    let prog = Compiler::new(ok.to_string()).compile().unwrap();
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
    // Any other same-scope binding is a redeclaration.
    expect_compile_error(
        "int main(void) { int T = 1; typedef int T; return T; }",
        "redeclaration of `T` in the same scope",
    );
}

#[test]
fn implicit_extern_fn_binding_unbinds_at_scope_exit() {
    let opts = || {
        crate::c5::compiler::CompileOptions::default()
            .with_implicit_extern_fns(alloc::vec!["impfn".to_string()])
    };
    let target = super::super::codegen::Target::default_target();
    // C89 6.3.2.2 puts the implicit declaration in the innermost block
    // containing the call. Each caller re-binds; the calls resolve to
    // the definition later in the unit.
    let ok = "int f(void) { return impfn(4); }\n\
              int h(void) { { return impfn(10); } }\n\
              int impfn(int x) { return x + 1; }\n\
              int main(void) { return f() + h() == 16 ? 0 : 1; }";
    let prog = Compiler::with_options(ok.to_string(), target, opts())
        .compile()
        .unwrap();
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
    // After the declaring function exits, the name is out of scope; a
    // non-call use in the next function does not see it.
    match Compiler::with_options(
        "int f(void) { return impfn(4); } int g(void) { return impfn; } \
         int impfn(int x) { return x + 1; } int main(void) { return 0; }"
            .to_string(),
        target,
        opts(),
    )
    .compile()
    {
        Err(e) => assert!(
            e.to_string().contains("undefined variable impfn"),
            "unexpected error: {e}"
        ),
        Ok(_) => panic!("an out-of-scope implicit binding must not resolve"),
    }
}

#[test]
fn object_of_incomplete_type_is_diagnosed() {
    // C99 6.7p7: an object with no linkage must have a complete type by
    // the end of its declarator.
    expect_compile_error(
        "struct never_defined;\n\
         int main(void) { struct never_defined local_obj; return (int)(long)&local_obj; }",
        "object `local_obj` has incomplete type",
    );
    // A block-scope `static` has no linkage either.
    expect_compile_error(
        "struct never_defined;\n\
         int main(void) { static struct never_defined s; return (int)(long)&s; }",
        "object `s` has incomplete type",
    );
    // C99 6.9.2p3: a file-scope definition the unit never completes.
    expect_compile_error(
        "struct never_defined;\n\
         static struct never_defined file_scope_obj;\n\
         int main(void) { return (int)(long)&file_scope_obj; }",
        "object `file_scope_obj` has incomplete type",
    );
    // An array of an incomplete element type is incomplete too.
    expect_compile_error(
        "struct never_defined;\n\
         struct never_defined arr[4];\n\
         int main(void) { return (int)(long)&arr; }",
        "object `arr` has incomplete type",
    );
    // A tentative definition the unit completes later stands, as do a
    // block-scope `extern` (it has linkage and defines nothing) and a
    // pointer to an incomplete tag.
    Compiler::new(
        "struct later;\n\
         struct later tentative;\n\
         struct later { int x; };\n\
         struct undef;\n\
         struct undef *p;\n\
         int main(void) { extern struct undef e; tentative.x = 1;\n\
         return tentative.x - 1 + (int)(long)(&p == 0) + (int)(long)(&e == 0); }"
            .to_string(),
    )
    .compile()
    .expect("a completed tentative definition, a block extern, and a pointer stay legal");
}

#[test]
fn sizeof_of_an_incomplete_type_is_diagnosed() {
    // C99 6.5.3.4p1 / C11 6.5.3.4p1: neither operator applies to an
    // incomplete type, whether the operand is a type name, an identifier,
    // or an expression.
    expect_compile_error(
        "struct Undef;\n\
         int a[sizeof(struct Undef)];\n\
         int main(void) { return a[0]; }",
        "`sizeof` applied to an incomplete type",
    );
    expect_compile_error(
        "union Undef;\n\
         int main(void) { return (int)sizeof(union Undef); }",
        "`sizeof` applied to an incomplete type",
    );
    // An array declared with an unspecified bound (C99 6.7.5.2p4).
    expect_compile_error(
        "extern int x[];\n\
         int main(void) { return (int)sizeof(x); }",
        "`sizeof` applied to an incomplete type",
    );
    // Through an expression operand.
    expect_compile_error(
        "struct Undef;\n\
         struct Undef *p;\n\
         int main(void) { return (int)sizeof(*p); }",
        "`sizeof` applied to an incomplete type",
    );
    expect_compile_error(
        "struct Undef;\n\
         int main(void) { return (int)_Alignof(struct Undef); }",
        "`_Alignof` applied to an incomplete type",
    );
    // A pointer to an incomplete type is complete, as is an array of a
    // complete tag and a tag completed before the operator is applied.
    Compiler::new(
        "struct Undef;\n\
         struct Later;\n\
         struct Later { int a; int b; };\n\
         extern int x[];\n\
         int main(void) { return (int)(sizeof(struct Undef *) + sizeof(x[0])\n\
         + sizeof(struct Later) + _Alignof(struct Undef *) + _Alignof(struct Later)) - 25; }"
            .to_string(),
    )
    .compile()
    .expect("pointers to an incomplete tag and completed tags stay legal");
}

#[test]
fn address_of_a_block_scope_compound_literal_is_not_constant() {
    // C99 6.5.2.5p5: a compound literal inside a function body has
    // automatic storage duration, so its address is not an address
    // constant (6.6p9) and cannot initialize a static-duration object.
    expect_compile_error(
        "struct s { int a; int b; };\n\
         int main(void) { static struct s *p = &(struct s){ 77, 88 }; return p->a - 77; }",
        "address of a compound literal with automatic storage duration",
    );
    // The array form decays to the same address.
    expect_compile_error(
        "int main(void) { static int *q = (int[]){ 3, 4 }; return *q - 3; }",
        "address of a compound literal with automatic storage duration",
    );
    // A member of the literal is part of the same automatic object.
    expect_compile_error(
        "struct s { int a; int b; };\n\
         int main(void) { static int *p = &((struct s){ 77, 88 }).b; return *p - 88; }",
        "address of a compound literal with automatic storage duration",
    );
    // A file-scope literal has static storage duration; an automatic
    // object's initializer need not be constant at all; and reading a
    // staged element back is a value, not an address.
    let prog = Compiler::new(
        "struct s { int a; int b; };\n\
         static struct s *fp = &(struct s){ 1, 2 };\n\
         int main(void) {\n\
             struct s *ap = &(struct s){ 3, 4 };\n\
             struct s arr[1] = { { .a = (int)(long)&(struct s){ 5, 6 }, .b = 7 } };\n\
             static int v = (int[]){ 8, 9 }[1];\n\
             return fp->a + ap->b + (arr[0].b - 7) + v - 14;\n\
         }"
        .to_string(),
    )
    .compile()
    .expect("static-duration and automatic-object compound literals stay legal");
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
}

#[test]
fn address_of_a_thread_local_is_not_a_constant_expression() {
    // C11 6.7.9p4: an object with static storage duration is initialized
    // by constant expressions, and a thread-local object's address is not
    // one -- it has no value until a thread's block is materialized, which
    // is after image relocation. gcc rejects each of these with
    // "initializer element is not constant".
    for src in [
        "__thread int tv = 7;\nint *p = &tv;",
        "__thread int tv = 7;\nint *p = &tv + 1;",
        "__thread int a_tls[4];\nint *p = &a_tls[2];",
        // The array name decays to the address of its first element.
        "__thread int a_tls[4];\nint *p = a_tls;",
        "struct s { int a; int b; };\n__thread struct s s_tls;\nint *p = &s_tls.b;",
        "extern __thread int tv;\nint *p = &tv;",
        "__thread int tv = 7;\nint *arr[2] = { &tv, 0 };",
        "struct s { int *q; };\n__thread int tv = 7;\nstruct s v = { .q = &tv };",
        // A compound literal at file scope has static storage duration.
        "struct s { int *q; };\n__thread int tv = 7;\nstruct s v = (struct s){ &tv };",
        "__thread int tv = 7;\nvoid f(void) { static int *p = &tv; (void)p; }",
        // The rule keys on the object whose address is taken, so a
        // thread-local slot is no exemption.
        "__thread int tv;\n__thread int *tp = &tv;",
    ] {
        expect_compile_error(src, "address of thread-local");
    }
    // The opposite direction is an address constant and stays accepted:
    // the thread-local is the object being initialized and the object
    // whose address is taken has static storage duration. An automatic
    // object's initializer need not be constant at all.
    let prog = Compiler::new(
        "int g = 3;\n\
         static int arr[4] = { 1, 2, 3, 4 };\n\
         __thread int *tp = &g;\n\
         __thread int *tq = &arr[2];\n\
         int main(void) {\n\
             int *ap = &g;\n\
             return (tp == &g ? 0 : 1) + (tq == &arr[2] ? 0 : 2) + (ap == &g ? 0 : 4);\n\
         }"
        .to_string(),
    )
    .compile()
    .expect("a thread-local initialized with an ordinary object's address stays legal");
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
}

#[test]
fn static_local_array_initializer_over_bound_rejected() {
    // C99 6.7.8p2: an initializer may not provide a value for an object
    // outside the entity being initialized. The static-local allocator
    // reserves storage from the declared bound, so a longer list was written
    // past it, over whatever the initializer's own parse had staged above the
    // reservation -- and off the end of `.data` when nothing had been, which
    // panicked on the write index. The file-scope, automatic and
    // compound-literal paths already rejected the same shapes.
    expect_compile_error(
        "int main(void) { static int a[1] = {1, 2, 3, 4}; return a[0]; }",
        "too many initializers for array `a` (4 > 1)",
    );
    expect_compile_error(
        "int main(void) { static char c[2] = \"abcdef\"; return c[0]; }",
        "too many initializers for array `c` (6 > 2)",
    );
    expect_compile_error(
        "int main(void) { static int a[1] = {1, 2}; static int b[2] = {3, 4};\n\
         return a[0] + b[0]; }",
        "too many initializers for array `a` (2 > 1)",
    );
    // The exactly-filling and short forms stay legal: 6.7.8p14 drops the
    // terminator on an exact fit, 6.7.8p21 zero-fills the tail.
    let prog = Compiler::new(
        "int main(void) { static int a[2] = {1, 2}; static char c[3] = \"abc\";\n\
         static char d[4] = \"ab\";\n\
         return a[1] + c[2] + d[2] + d[3] - 101; }"
            .to_string(),
    )
    .compile()
    .expect("an exactly-filling or short static-local initializer stays legal");
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
}

#[test]
fn wide_string_array_initializer_requires_matching_element_width() {
    // C99 6.7.8p15: a wide string literal initializes an array whose element
    // type is compatible with the literal's. A wider element stored one
    // decoded code point per element at the element's own width and ran past
    // the array; the struct-member sinks already applied the rule.
    for src in [
        "int main(void) { static long long a[1] = L\"abc\"; return (int)a[0]; }",
        "int main(void) { static long long a[] = L\"abc\"; return (int)a[0]; }",
        "int main(void) { static char a[] = L\"abc\"; return a[0]; }",
        "int main(void) { static char a[] = { L\"abc\" }; return a[0]; }",
        "int main(void) { static int a[4] = u\"abc\"; return a[0]; }",
    ] {
        expect_compile_error(
            src,
            "wide string initializer requires a wchar_t-width array",
        );
    }
    // The matching-width forms stay legal, bounded and unbounded alike.
    let prog = Compiler::new(
        "#include <stddef.h>\n\
         int main(void) { static wchar_t a[] = L\"ab\"; static wchar_t b[4] = L\"cd\";\n\
         static wchar_t c[2] = L\"ef\";\n\
         return (int)(a[2] + b[2] + b[3] + (c[0] - L'e')); }"
            .to_string(),
    )
    .compile()
    .expect("a wchar_t-width array takes a wide string literal");
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
}

#[test]
fn mixed_prefix_string_concatenation_is_rejected() {
    // C99 6.4.5p5 leaves a run carrying two encoding prefixes undefined.
    // The initializer sees one staged literal by then, so the width the
    // first part happens to match cannot hide the mismatch: the lexer
    // rejects the run while both prefixes are visible.
    expect_compile_error(
        "#include <stddef.h>\n\
         int main(void) { static wchar_t a[] = L\"ab\" u\"cd\"; return (int)a[0]; }",
        "different encoding prefixes",
    );
    expect_compile_error(
        "int main(void) { return sizeof(u\"a\" U\"b\"); }",
        "different encoding prefixes",
    );
    // An unprefixed part is defined and folds at the run's width.
    let prog = Compiler::new(
        "#include <stddef.h>\n\
         int main(void) { static wchar_t a[] = L\"ab\" \"cd\";\n\
         static wchar_t b[] = \"ab\" L\"cd\";\n\
         return (int)(a[2] - 'c') + (int)(b[3] - 'd')\n\
         + (int)(sizeof a - sizeof b); }"
            .to_string(),
    )
    .compile()
    .expect("an unprefixed part joins the run");
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
}

#[test]
fn utf8_prefix_concatenation_is_diagnosed() {
    // C11 6.4.5p5: `u8` is narrow, so it pairs only with itself and with
    // an unprefixed part; every wider pairing has no defined result.
    for src in [
        r#"int main(void) { return sizeof(u8"a" L"b"); }"#,
        r#"int main(void) { return sizeof(u8"a" u"b"); }"#,
        r#"int main(void) { return sizeof(u8"a" U"b"); }"#,
        r#"int main(void) { return sizeof(L"a" u8"b"); }"#,
        r#"int main(void) { return sizeof(u"a" u8"b"); }"#,
        r#"int main(void) { return sizeof(U"a" u8"b"); }"#,
    ] {
        expect_compile_error(src, "different encoding prefixes");
    }
    // The three cells 6.4.5p5 defines compile and run.
    let prog = Compiler::new(
        r#"int main(void) { static char a[] = u8"ab" u8"cd";
         static char b[] = u8"ab" "cd";
         static char c[] = "ab" u8"cd";
         return (int)(sizeof a - 5) + (int)(sizeof b - 5) + (int)(sizeof c - 5)
         + (a[3] - 'd') + (b[3] - 'd') + (c[3] - 'd'); }"#
            .to_string(),
    )
    .compile()
    .expect("u8 pairs with itself and with an unprefixed part");
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
}

#[test]
fn invalid_universal_character_names_are_diagnosed() {
    // C11 6.4.3p2 constrains the code points a universal character name
    // may denote, in a narrow, `u8` and wide literal alike.
    for src in [
        r#"char *s = "\uD800";"#,
        r#"char *s = u8"\uD800";"#,
        r#"char *s = (char *)L"\uDFFF";"#,
        r#"char *s = "\u0041";"#,
        r#"char *s = "\U00110000";"#,
        r#"char c = '\u009F';"#,
    ] {
        expect_compile_error(src, "not a valid universal character name");
    }
    // 6.4.3p1 fixes the digit count at four for `\u` and eight for `\U`.
    for src in [r#"char *s = "\u12";"#, r#"char *s = (char *)U"\U0001F60";"#] {
        expect_compile_error(src, "incomplete universal character name");
    }
    // A name inside the permitted set encodes as UTF-8 and runs.
    let prog = Compiler::new(
        r#"int main(void) { static char a[] = u8"\u00E9\U0001F600";
         return (int)(sizeof a - 7) + ((unsigned char)a[0] - 0xC3)
         + ((unsigned char)a[2] - 0xF0) + ((unsigned char)a[5] - 0x80); }"#
            .to_string(),
    )
    .compile()
    .expect("a permitted universal character name encodes as UTF-8");
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 0);
}

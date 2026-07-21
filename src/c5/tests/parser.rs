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
fn overaligned_automatic_is_rejected() {
    // Frame slots are 8 bytes and the prologue does not realign the
    // stack, so an automatic object cannot be placed on a boundary wider
    // than the 16 bytes the frame pointer guarantees. Rejecting is
    // preferable to handing back an under-aligned address; static storage
    // carries any supported alignment. Both an explicit request on the
    // declarator and one inherited from an over-aligned type are caught.
    expect_compile_error(
        "int main(void) { int __attribute__((aligned(64))) a; return (int)(long)&a; }",
        "not supported here",
    );
    expect_compile_error(
        "struct __attribute__((aligned(64))) S { int x; };\n\
         int main(void) { struct S a; return (int)(long)&a.x; }",
        "automatic object of a 64-byte-aligned type is not supported",
    );
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
fn declarator_asm_rejected_at_file_scope() {
    // TODO: file-scope renames and global register variables.
    expect_compile_error(
        "int g asm(\"r9\"); int main(void) { return g; }",
        "not supported at file scope",
    );
}

#[test]
fn register_asm_binding_constraints() {
    // `register T name asm("reg")` requires the `register` storage
    // class, a bindable register for the target, automatic storage,
    // and (for the stack / frame pointer) read-only use.
    expect_compile_error(
        "int main(void) { long x asm(\"rax\"); return 0; }",
        "requires the `register` storage class",
    );
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
        expect_compile_error(
            "int main(void) { register long x asm(\"r10\"); return 0; }",
            "reserved and cannot hold a register variable",
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
    // x86-64: r11 is bindable (a stack-switch idiom pins a scratch to
    // it); r10 stays the emitter's reserved asm-staging scratch.
    let bind = |reg: &str| {
        format!(
            "int main(void) {{ register long v asm(\"{reg}\") = 1; long o; __asm__(\"movq %1, %0\" : \"=r\"(o) : \"r\"(v)); return (int)o; }}"
        )
    };
    assert!(
        compile_for_target(&bind("r11"), Target::LinuxX64).is_ok(),
        "x86-64 `r11` must be bindable"
    );
    let e = compile_for_target(&bind("r10"), Target::LinuxX64).unwrap_err();
    assert!(
        e.contains("reserved and cannot hold a register variable"),
        "{e}"
    );

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
    // Without `register` the declarator asm suffix stays rejected
    // (linkage-name rename is TODO).
    expect_compile_error(
        "long x asm(\"renamed\"); int main(void) { return 0; }",
        "not supported at file scope",
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

// Reaches the SSA walk (via native emit), so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn direct_seg_access_is_rejected_pending_segment_load_store() {
    use crate::{NativeOptions, Target};
    // A direct read / write through a `__seg_gs` / `__seg_fs` pointer needs a
    // segment-prefixed load / store, which the plain access path does not yet
    // emit. It is rejected rather than lowered as a plain access that would
    // silently drop the segment; the qualifier is instead honored on inline-
    // asm memory operands. Both targets reject (no target has a plain
    // segment-prefixed access path yet).
    let emit_err = |src: &str, target: Target| -> String {
        let program = Compiler::with_target(src.to_string(), target)
            .compile()
            .expect("parse");
        crate::c5::object::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::default(),
        )
        .expect_err("expected emit to reject a direct segment access")
        .to_string()
    };
    let read = "extern unsigned long v; unsigned long r(void){ \
         return *(unsigned long __seg_gs *)(__UINTPTR_TYPE__)&v; } int main(void){ return 0; }";
    let write = "extern unsigned long v; void w(unsigned long x){ \
         *(unsigned long __seg_gs *)(__UINTPTR_TYPE__)&v = x; } int main(void){ return 0; }";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        assert!(emit_err(read, target).contains("direct __seg_gs/__seg_fs read"));
        assert!(emit_err(write, target).contains("direct __seg_gs/__seg_fs write"));
    }
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
    expect_compile_error(
        "asm(\"nop\"); int main(void) { return 0; }",
        "section data directives only",
    );
    // `.globl` with no operand is not a directive this accepts.
    expect_compile_error(
        "asm(\".globl\"); int main(void) { return 0; }",
        "section data directives only",
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

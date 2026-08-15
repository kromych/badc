//! Type-checking tests -- assignments and call sites should warn (not
//! error) on type mismatches, and a C-style cast should silence the
//! warning. Variadic functions skip type-check past the fixed prefix.

use super::{compile_fixture, compile_str, run_fixture};

/// C99 6.4.4.4p11: a wide character constant (`L'x'`) has type `wchar_t`,
/// whose width the target fixes -- 2 bytes on Windows (UTF-16) and 4 on
/// the Unix targets, matching the `<stddef.h>` typedef. A narrow
/// character constant keeps type `int` (6.4.4.4p10) on every target. The
/// SSA interpreter is target-independent, so a program compiled for any
/// target folds its `sizeof` against that target's widths.
#[test]
fn wide_char_constant_has_target_wchar_width() {
    use super::Vm;
    use crate::Compiler;
    use crate::Target;
    let run = |src: &str, t: Target| -> i64 {
        Vm::new(Compiler::with_target(src.to_string(), t).compile().unwrap())
            .run()
            .unwrap()
    };
    let wide = "int main(void){ return (int)sizeof(L'A'); }";
    assert_eq!(
        run(wide, Target::WindowsX64),
        2,
        "sizeof(L'A') is 2 on Windows"
    );
    assert_eq!(run(wide, Target::LinuxX64), 4, "sizeof(L'A') is 4 on Unix");
    let narrow = "int main(void){ return (int)sizeof('A'); }";
    assert_eq!(run(narrow, Target::WindowsX64), 4, "sizeof('A') is 4 (int)");
    // The value is unaffected: `L'A'` is 65 and promotes for arithmetic.
    let val = "int main(void){ return L'A' == 65 ? 7 : 0; }";
    assert_eq!(run(val, Target::WindowsX64), 7, "L'A' keeps its value");
}

#[test]
fn warn_int_to_pointer_assignment() {
    // `int *p; p = 5;` -- assigning a non-zero integer to a pointer.
    let p = compile_fixture("type_warning_int_to_ptr.c");
    assert!(
        p.warnings
            .iter()
            .any(|w| w.contains("integer assigned to pointer")),
        "expected int-to-ptr warning, got: {:?}",
        p.warnings
    );
}

#[test]
fn warn_return_type_mismatch() {
    // `return <expr>;` whose type doesn't match the function return
    // type warns like an assignment (C99 6.8.6.4p3).
    let p = compile_fixture("type_warning_return.c");
    let has = |needle: &str| p.warnings.iter().any(|w| w.contains(needle));
    assert!(
        has("pointer assigned to integer in return"),
        "expected ptr-returned-as-int warning, got: {:?}",
        p.warnings
    );
    assert!(
        has("integer assigned to pointer in return"),
        "expected int-returned-as-ptr warning, got: {:?}",
        p.warnings
    );
    // The NULL idiom and a matching return stay silent.
    assert!(
        !has("ret_null") && !has("ret_ok"),
        "unexpected warning on a well-typed return: {:?}",
        p.warnings
    );
}

#[test]
fn call_without_return_prototype_warns_implicit_int() {
    use crate::{Compiler, Target};
    // A `#pragma binding` seen without an accompanying prototype leaves
    // the callee's return type at the implicit `int` default. A call
    // warns once: the result truncates to 32 bits if the function really
    // returns a pointer or wider type. Target-fixed so the bound dylib
    // name (`libc`) is the same regardless of the host.
    let src = "#pragma dylib(libc, \"libc.so.6\")\n\
               #pragma binding(libc::mystery, \"getenv\")\n\
               int main(void) { return mystery(\"PATH\") ? 0 : 1; }\n";
    let p = Compiler::with_target(src.to_string(), Target::LinuxX64)
        .compile()
        .unwrap();
    assert!(
        p.warnings
            .iter()
            .any(|w| w.contains("mystery") && w.contains("without a return-type prototype")),
        "expected implicit-int warning, got: {:?}",
        p.warnings
    );
}

#[test]
fn call_with_return_prototype_is_silent() {
    use crate::{Compiler, Target};
    // Declaring the return type clears the implicit-`int` default, so
    // the same call produces no warning.
    let src = "#pragma dylib(libc, \"libc.so.6\")\n\
               #pragma binding(libc::mystery, \"getenv\")\n\
               char *mystery(char *name);\n\
               int main(void) { return mystery(\"PATH\") ? 0 : 1; }\n";
    let p = Compiler::with_target(src.to_string(), Target::LinuxX64)
        .compile()
        .unwrap();
    assert!(
        !p.warnings.iter().any(|w| w.contains("mystery")),
        "expected no warning for a prototyped binding, got: {:?}",
        p.warnings
    );
}

#[test]
fn shadowing_fnptr_param_does_not_clobber_signature() {
    // A prototype whose fn-ptr parameter reuses a bound library
    // function's name must not replace that function's recorded
    // signature: a later 1-arg `exit(0)` would otherwise be checked
    // against the parameter's own prototype (C99 6.2.1p4).
    let p = compile_str(
        "struct Obj { int x; };\n\
         void takes(void (*exit)(struct Obj *o, int code));\n\
         int main(void) { exit(0); }\n",
    );
    assert!(
        !p.warnings.iter().any(|w| w.contains("exit")),
        "shadowed `exit` signature leaked, got: {:?}",
        p.warnings
    );
}

#[test]
fn cast_silences_int_to_pointer_warning() {
    // Same shape, but with `p = (int *)5;` -- the cast tells the compiler
    // the conversion is intentional, so no warning.
    let p = compile_fixture("type_warning_silenced_by_cast.c");
    assert!(
        p.warnings.is_empty(),
        "expected no warnings, got: {:?}",
        p.warnings
    );
}

#[test]
fn warn_call_arity_mismatch() {
    // `int add(int, int);` called with 1 arg and with 4 args.
    let p = compile_fixture("type_warning_arity.c");
    assert!(
        p.warnings.iter().any(|w| w.contains("too few arguments")),
        "expected too-few warning, got: {:?}",
        p.warnings
    );
    assert!(
        p.warnings.iter().any(|w| w.contains("too many arguments")),
        "expected too-many warning, got: {:?}",
        p.warnings
    );
}

#[test]
fn redeclaration_without_parameters_keeps_the_prototype() {
    // C99 6.2.7p4: the composite type keeps the parameter type list a
    // prior declaration or definition established, so a call past it is
    // still checked after a redeclaration through the function's own
    // type or through the empty-list spelling.
    let p = compile_fixture("redecl_composite_arity_warning.c");
    for name in ["take_wrap", "add2"] {
        assert!(
            p.warnings
                .iter()
                .any(|w| w.contains("too many arguments") && w.contains(name)),
            "expected a too-many warning for `{name}`, got: {:?}",
            p.warnings
        );
    }
}

#[test]
fn unprototyped_declaration_supplies_no_parameters() {
    // C99 6.7.5.3p14: an empty list in a non-defining declarator supplies
    // no parameter information, and a redeclaration through that type
    // does not invent any -- calls stay unchecked.
    let p = compile_str(
        "extern unsigned f();\n\
         extern typeof(f) f;\n\
         unsigned use(void) { return f(1u, 2u, 3u); }\n\
         int main(void) { return 0; }\n",
    );
    assert!(
        !p.warnings.iter().any(|w| w.contains("arguments")),
        "unprototyped call must not be arity-checked, got: {:?}",
        p.warnings
    );
}

#[test]
fn typeof_redeclaration_merges_with_the_recorded_prototype() {
    // C99 6.2.7p4: the composite type of two compatible declarations keeps
    // the parameter type list, so a redeclaration through the function's
    // own type merges with the recorded prototype instead of replacing it.
    // The orderings differ in what the specifier reads: a definition alone,
    // a prototype the definition follows, and a block-scope redeclaration.
    let orderings = [
        "unsigned inner(kuid_t k) { return k.val; }\n\
         extern typeof(inner) inner;\n\
         unsigned use(kuid_t k) { return inner(k, 1, 2); }\n",
        "unsigned inner(kuid_t k);\n\
         extern typeof(inner) inner;\n\
         unsigned inner(kuid_t k) { return k.val; }\n\
         unsigned use(kuid_t k) { return inner(k, 1, 2); }\n",
        "unsigned inner(kuid_t k) { return k.val; }\n\
         unsigned use(kuid_t k) { extern typeof(inner) inner; return inner(k, 1, 2); }\n",
    ];
    for body in orderings {
        let src = alloc::format!(
            "typedef struct {{ int val; }} kuid_t;\n{body}int main(void) {{ return 0; }}\n"
        );
        let p = compile_str(&src);
        assert!(
            p.warnings
                .iter()
                .any(|w| w.contains("too many arguments") && w.contains("inner")),
            "expected an arity warning past the redeclaration, got: {:?}",
            p.warnings
        );
    }
}

/// C99 6.2.4 + 6.2.2: block-scope locals, function parameters,
/// and `static` file-scope functions that are never referenced
/// are dead. The compiler emits a `<file>:<line>: warning:
/// unused ...` line for each, in the same shape as the
/// type-mismatch warnings above. Names whose first character is
/// `_` are suppressed by convention.
#[test]
fn warn_unused_variable_parameter_function() {
    let p = compile_fixture("warn_unused_symbols.c");
    let names_warned: alloc::vec::Vec<&str> = p
        .warnings
        .iter()
        .filter_map(|w| {
            let backtick = w.find('`')?;
            let end = w[backtick + 1..].find('`')?;
            Some(&w[backtick + 1..backtick + 1 + end])
        })
        .collect();
    let expect = [
        "dead_static",
        "unused_arg",
        "unused_local",
        "main_unused",
        "main_unused_init",
        "inner_unused",
        "dead_assigned",
        "touched_then_overwritten",
    ];
    for name in expect {
        assert!(
            names_warned.contains(&name),
            "expected warning for `{name}`, got: {:?}",
            p.warnings
        );
    }
    let suppress = [
        "live_static",
        "x",
        "used_local",
        "_silenced_local",
        "_silenced",
        "used",
        "main",
        "inner_used",
    ];
    for name in suppress {
        assert!(
            !names_warned.contains(&name),
            "did not expect warning for `{name}`, got: {:?}",
            p.warnings
        );
    }
    let set_but_unused: alloc::vec::Vec<&String> = p
        .warnings
        .iter()
        .filter(|w| w.contains("set but never used"))
        .collect();
    assert!(
        set_but_unused.iter().any(|w| w.contains("`dead_assigned`")),
        "expected `set but never used` for dead_assigned, got: {:?}",
        p.warnings
    );
    assert!(
        set_but_unused
            .iter()
            .any(|w| w.contains("`touched_then_overwritten`")),
        "expected `set but never used` for touched_then_overwritten, got: {:?}",
        p.warnings
    );
}

/// Per-store dead-store analysis: when `-Wdead-store` is on, each
/// store whose value never reaches a read fires a `dead store:
/// value assigned to X is never read` diagnostic at the store's
/// source line. Off by default; the per-symbol `set but never
/// used` warning still fires unconditionally.
#[test]
fn warn_dead_store_per_store_when_enabled() {
    use crate::CompileOptions;
    use crate::Compiler;
    use crate::Target;
    let src = super::with_prelude(&super::load_fixture("warn_dead_store.c"));
    let opts = CompileOptions::default().with_warn_dead_store(true);
    let p = Compiler::with_options(src, Target::host(), opts)
        .compile()
        .unwrap();
    let dead: alloc::vec::Vec<&String> = p
        .warnings
        .iter()
        .filter(|w| w.contains("dead store:"))
        .collect();
    // `int a = 1; a = 2; return 1;` -> both stores dead.
    let a_warns: alloc::vec::Vec<&&String> = dead.iter().filter(|w| w.contains("`a`")).collect();
    assert_eq!(
        a_warns.len(),
        2,
        "expected two dead-store warnings on `a` (initializer + a = 2;), got: {:?}",
        dead
    );
    // No false positives: branch-straddling, self-referencing
    // RHS, and address-escape cases must not fire.
    for w in &dead {
        assert!(
            !w.contains("`b`") && !w.contains("`c`") && !w.contains("`d`"),
            "unexpected dead-store warning: {w}"
        );
    }
}

#[test]
fn warn_dead_store_off_by_default() {
    let p = compile_fixture("warn_dead_store.c");
    let dead: alloc::vec::Vec<&String> = p
        .warnings
        .iter()
        .filter(|w| w.contains("dead store:"))
        .collect();
    assert!(
        dead.is_empty(),
        "dead-store warnings should not fire without -Wdead-store: {:?}",
        dead
    );
}

/// `typedef HANDLE *PHANDLE;` with no prior `HANDLE` typedef
/// must error at the declaration site, not silently default
/// to `int *`.
#[test]
fn unknown_type_name_is_a_compile_error() {
    use crate::Compiler;
    let result = Compiler::new("typedef HANDLE *PHANDLE; int main(void) { return 0; }".to_string())
        .compile();
    let err = result.expect_err("expected an error for unknown `HANDLE`");
    let msg = format!("{err:?}");
    assert!(
        msg.contains("unknown type name `HANDLE`"),
        "expected `unknown type name`, got: {msg}"
    );
}

/// `HANDLE x;` at file scope must error rather than declare
/// `x` as `int`.
#[test]
fn unknown_base_type_in_global_decl_is_an_error() {
    use crate::Compiler;
    let result = Compiler::new("HANDLE x;".to_string()).compile();
    let err = result.expect_err("expected an error for unknown `HANDLE`");
    let msg = format!("{err:?}");
    assert!(
        msg.contains("unknown type name `HANDLE`"),
        "expected `unknown type name`, got: {msg}"
    );
}

#[test]
fn cast_to_struct_pointer_compiles_and_runs() {
    // `(struct Node *)malloc(...)` -- the cast operator must accept a
    // struct type expression, not only `int`/`char [*]`.
    assert_eq!(run_fixture("cast_to_struct_pointer.c"), 42);
    let p = compile_fixture("cast_to_struct_pointer.c");
    assert!(
        p.warnings.is_empty(),
        "cast should silence the malloc-returns-char* warning, got: {:?}",
        p.warnings
    );
}

/// Compile `src` with the standard prelude and return the diagnostic
/// text, asserting the compile failed. C99 5.1.1.3 requires a
/// constraint violation to be diagnosed; badc rejects outright rather
/// than recording on `Program::warnings`.
fn constraint_error(src: &str) -> String {
    use crate::Compiler;
    let err = Compiler::new(super::with_prelude(src))
        .compile()
        .expect_err("expected a constraint violation to be rejected");
    let msg = format!("{err:?}");
    assert!(
        msg.contains("error:"),
        "diagnostic must be an error, got: {msg}"
    );
    msg
}

#[test]
fn return_with_value_in_void_function_is_an_error() {
    // C99 6.8.6.4p1: a return statement with an expression shall not
    // appear in a function whose return type is void.
    let msg = constraint_error("void f(void) { return 1; }\nint main(void){return 0;}");
    assert!(
        msg.contains("`return` with a value of type `int` in a function returning `void`"),
        "got: {msg}"
    );
    // The operand's type is named so the reader sees what was returned.
    let msg =
        constraint_error("static int *g;\nvoid f(void) { return g; }\nint main(void){return 0;}");
    assert!(msg.contains("in a function returning `void`"), "got: {msg}");
}

#[test]
fn return_of_a_void_expression_stays_accepted() {
    // The void-typed operand is the established exception: gcc and clang
    // accept `return f();` and `return (void)x;` in a void function
    // outside -pedantic-errors, and real code relies on it.
    let p = compile_str(
        "void g(void) {}\n\
         void f(void) { return g(); }\n\
         void h(int x) { return (void)x; }\n\
         int main(void) { f(); h(1); return 0; }",
    );
    assert!(
        !p.warnings
            .iter()
            .any(|w| w.contains("`return` with a value")),
        "a void-typed return operand must stay silent, got: {:?}",
        p.warnings
    );
    // A bare `return;` is unaffected.
    compile_str("void f(void) { return; }\nint main(void){return 0;}");
}

#[test]
fn void_returning_callees_are_typed_void() {
    // The 6.8.6.4p1 check keys off the operand's type, so anything the
    // standard declares `void` must carry the void tag: otherwise
    // `return free(p);` -- valid C that gcc and clang accept -- would be
    // rejected. Covers the intrinsics and the bundled declarations.
    let p = compile_str(
        "void a(void *p) { return free(p); }\n\
         void b(void) { return abort(); }\n\
         void c(void) { return exit(0); }\n\
         void d(int n) { return srand(n); }\n\
         void e(char *b) { return qsort(b, 0, 0, 0); }\n\
         void f(void) { return perror(\"x\"); }\n\
         void g(void) { return __builtin_unreachable(); }\n\
         void h(void) { return __builtin_trap(); }\n\
         int main(void) { return 0; }",
    );
    assert!(
        !p.warnings.iter().any(|w| w.contains("error:")),
        "got: {:?}",
        p.warnings
    );
    // Indirect calls, statement expressions and the comma operator keep
    // the void tag through to the return.
    compile_str(
        "typedef void (*vfn)(void);\nvoid g(void);\n\
         void a(vfn p) { return p(); }\n\
         void b(void) { return ({ g(); }); }\n\
         void c(void) { return (g(), g()); }\n\
         void d(int x) { return x ? g() : g(); }\n\
         int main(void) { return 0; }",
    );
}

#[test]
fn struct_object_type_mismatch_is_an_error_in_every_assignment_context() {
    // C99 6.5.16.1p1 lists no conversion involving a structure or union
    // object, so a mismatch is a constraint violation wherever the
    // as-if-by-assignment rule applies: argument passing (6.5.2.2p2),
    // simple assignment, initialization (6.7.8p11) and return
    // (6.8.6.4p3).
    const DECLS: &str = "struct S { int a; };\nstruct T { int b; };\n";
    const MAIN: &str = "\nint main(void){return 0;}";

    // 6.5.2.2p2 -- a pointer where the parameter has struct type.
    let msg = constraint_error(&format!(
        "{DECLS}void f(struct S s);\nvoid c(void) {{ struct S s; f(&s); }}{MAIN}"
    ));
    assert!(
        msg.contains("incompatible struct types in argument 1 of `f`")
            && msg.contains("param=struct S")
            && msg.contains("arg=struct S*"),
        "got: {msg}"
    );

    // 6.5.2.2p2 -- an unrelated struct, and a struct for a scalar param.
    for (src, needle) in [
        (
            format!("{DECLS}void f(struct S s);\nvoid c(void) {{ struct T t; f(t); }}{MAIN}"),
            "arg=struct T",
        ),
        (
            format!("{DECLS}void f(int x);\nvoid c(void) {{ struct S s; f(s); }}{MAIN}"),
            "param=int",
        ),
    ] {
        let msg = constraint_error(&src);
        assert!(
            msg.contains("incompatible struct types in argument 1") && msg.contains(needle),
            "got: {msg}"
        );
    }

    // 6.5.16.1p1 -- simple assignment.
    let msg = constraint_error(&format!(
        "{DECLS}void c(void) {{ struct S s; int i; i = s; }}{MAIN}"
    ));
    assert!(
        msg.contains("incompatible struct types in assignment")
            && msg.contains("lhs=int")
            && msg.contains("rhs=struct S"),
        "got: {msg}"
    );

    // 6.7.8p11 -- initialization, in both directions.
    let msg = constraint_error(&format!(
        "{DECLS}void c(void) {{ int i = 0; struct S s = i; (void)s; }}{MAIN}"
    ));
    assert!(
        msg.contains("incompatible struct types in initializer")
            && msg.contains("declared=struct S")
            && msg.contains("init=int"),
        "got: {msg}"
    );
    let msg = constraint_error(&format!(
        "{DECLS}void c(void) {{ struct S s; int i = s; (void)i; }}{MAIN}"
    ));
    assert!(
        msg.contains("declared=int") && msg.contains("init=struct S"),
        "got: {msg}"
    );

    // 6.8.6.4p3 -- return, converted as if by assignment.
    let msg = constraint_error(&format!(
        "{DECLS}struct S f(struct T t) {{ return t; }}{MAIN}"
    ));
    assert!(
        msg.contains("incompatible struct types in return")
            && msg.contains("declared=struct S")
            && msg.contains("returned=struct T"),
        "got: {msg}"
    );
}

#[test]
fn well_typed_aggregates_are_untouched_by_the_constraint_check() {
    // Only mismatches with no conversion are rejected. Matching
    // aggregates, by-value round trips through calls, unions, vectors
    // and decayed arrays must keep compiling silently.
    let p = compile_str(
        "struct S { int a; };\nunion U { int i; float f; };\n\
         struct S id(struct S s) { return s; }\n\
         union U idu(union U u) { return u; }\n\
         void arr(int *p) { (void)p; }\n\
         int main(void) { struct S a; struct S b = id(a); union U u; u = idu(u); \
         int v[4]; int m[2][3]; arr(v); arr(m[0]); (void)b; return 0; }",
    );
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);
}

#[test]
fn union_target_does_not_raise_the_object_mismatch_constraint() {
    // A union parameter may carry GCC's `transparent_union`, under which
    // it accepts any member type directly. That attribute is not modelled,
    // so a union target keeps warning severity instead of rejecting a
    // call real code makes.
    let p = compile_str(
        "struct page;\nstruct folio;\n\
         typedef union { struct page **pages; struct folio **folios; } \
         arg_t __attribute__((__transparent_union__));\n\
         void release(arg_t a, int nr);\n\
         void f(struct page **p, struct folio **q) { release(p, 1); release(q, 1); }\n\
         int main(void) { return 0; }",
    );
    assert!(
        !p.warnings.iter().any(|w| w.contains("error:")),
        "a union parameter must not be rejected, got: {:?}",
        p.warnings
    );
}

/// All five targets: `long double` is laid out exactly as `double`
/// (C99 6.2.5p10 permits any FP type at least as wide as `double`), so
/// `sizeof` / `_Alignof` / struct offsets match `double`'s on every one.
/// Both Linux ABIs give the platform type 16 bytes at 16-byte alignment;
/// doc/std-conformance.md records that divergence.
#[test]
fn long_double_is_laid_out_as_double_on_every_target() {
    use super::Vm;
    use crate::Compiler;
    use crate::Target;
    let run = |src: &str, t: Target| -> i64 {
        Vm::new(Compiler::with_target(src.to_string(), t).compile().unwrap())
            .run()
            .unwrap()
    };
    let probe = "struct S { char c; long double l; };\n\
                 int main(void){ return (sizeof(long double)==8 && _Alignof(long double)==8\n\
                 && sizeof(long double)==sizeof(double)\n\
                 && sizeof(struct S)==16 && __builtin_offsetof(struct S, l)==8\n\
                 && sizeof(long double[3])==24) ? 7 : 0; }";
    for t in [
        Target::LinuxX64,
        Target::LinuxAarch64,
        Target::MacOSAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert_eq!(
            run(probe, t),
            7,
            "{t:?}: long double must be laid out as double"
        );
    }
}

/// `long double` keeps `double`'s 53-bit significand, so a value needing
/// more than 53 bits does not round-trip. The platform types on both
/// Linux targets do (x87 80-bit has 64, binary128 has 113), which is why
/// the layout divergence is observable and documented rather than silent.
#[test]
fn long_double_carries_only_the_binary64_significand() {
    let probe = "int main(void){ unsigned long long u = (1ULL<<53)+1ULL;\n\
                 long double l = (long double)u;\n\
                 return ((unsigned long long)l == u) ? 1 : 7; }";
    assert_eq!(super::run_str(probe), 7, "2^53+1 must not round-trip");
    let fits = "int main(void){ unsigned long long u = (1ULL<<53);\n\
                long double l = (long double)u;\n\
                return ((unsigned long long)l == u) ? 7 : 0; }";
    assert_eq!(
        super::run_str(fits),
        7,
        "2^53 is representable and must round-trip"
    );
}

/// A `long double` handed to a platform-libc import is read by the
/// callee in the target ABI's format. badc passes the binary64 it
/// stores, so on the two Linux targets the callee decodes a different
/// object; the mismatch is announced at compile time instead of
/// surfacing as a wrong value at run time. macOS/arm64 and Windows x64
/// define `long double` as binary64, so nothing is lost there.
#[test]
fn long_double_libc_argument_warns_where_the_platform_abi_is_wider() {
    use crate::Compiler;
    use crate::Target;
    let warns = |src: &str, t: Target| -> alloc::vec::Vec<alloc::string::String> {
        Compiler::with_target(super::with_prelude(src), t)
            .compile()
            .unwrap()
            .warnings
    };
    let src = "int main(void){ long double x = 1.0L; double d = 2.0;\n\
               printf(\"%Lf\\n\", x); printf(\"%f\\n\", d); return 0; }";
    let hit = |ws: &[alloc::string::String], needle: &str| {
        ws.iter()
            .any(|w| w.contains("`long double` argument") && w.contains(needle))
    };
    let x64 = warns(src, Target::LinuxX64);
    assert!(
        hit(&x64, "x87 80-bit"),
        "LinuxX64 must name the x87 format, got: {x64:?}"
    );
    let a64 = warns(src, Target::LinuxAarch64);
    assert!(
        hit(&a64, "IEEE binary128"),
        "LinuxAarch64 must name the binary128 format, got: {a64:?}"
    );
    for t in [
        Target::MacOSAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let ws = warns(src, t);
        assert!(
            !ws.iter().any(|w| w.contains("`long double` argument")),
            "{t:?} defines long double as binary64 and must not warn, got: {ws:?}"
        );
    }
    // Exactly one argument is at issue: the `double` call must stay quiet.
    assert_eq!(
        x64.iter()
            .filter(|w| w.contains("`long double` argument"))
            .count(),
        1,
        "only the `%Lf` argument may warn, got: {x64:?}"
    );
    // <math.h> binds the `l` entry points to their `double` counterparts, so
    // the argument is converted to a `double` parameter and reaches the callee
    // exactly. A declared parameter that is not `long double` must stay quiet.
    let prototyped = "#include <math.h>\n\
                      int main(void){ return (int)ldexpl((long double)1.0, 53); }";
    for t in [Target::LinuxX64, Target::LinuxAarch64] {
        let ws = warns(prototyped, t);
        assert!(
            !ws.iter().any(|w| w.contains("`long double` argument")),
            "{t:?}: a `double` parameter takes the value exactly and must not warn, got: {ws:?}"
        );
    }
}

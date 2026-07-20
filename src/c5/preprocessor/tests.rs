use super::include::include_parent_dir;
use super::text::ends_in_open_block_comment;
use super::*;

fn process(source: &str) -> String {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.process(source).expect("preprocessor failed")
}

fn process_err(source: &str) -> String {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    match pp.process(source) {
        Ok(out) => panic!("expected error, got: {out}"),
        Err(e) => format!("{e}"),
    }
}

#[test]
fn if_signed_right_shift_is_arithmetic() {
    for e in ["(-2 >> 1) == -1", "(-1 >> 1) == -1", "(-8 >> 2) == -2"] {
        let out = process(&format!("#if {e}\nTAKEN\n#else\nNOT\n#endif\n"));
        assert!(out.contains("TAKEN"), "{e}: {out}");
    }
    // Unsigned operands keep the logical (zero-fill) shift: an
    // over-i64 literal and a `u`-suffixed literal are both unsigned.
    let out = process("#if ((18446744073709551615 >> 31) >> 31) == 3\nY\n#else\nN\n#endif\n");
    assert!(out.contains('Y'), "{out}");
    let out = process("#if (0xFFFFFFFFFFFFFFFFu >> 63) == 1\nY\n#else\nN\n#endif\n");
    assert!(out.contains('Y'), "{out}");
}

#[test]
fn if_division_by_zero_is_error() {
    for src in [
        "#if 1/0\nX\n#endif\n",
        "#if 1%0\nX\n#endif\n",
        "#if 3/(2-2)\nX\n#endif\n",
    ] {
        assert!(
            process_err(src).contains("division by zero"),
            "expected division-by-zero error: {src}"
        );
    }
    // A short-circuited or not-taken zero divisor is unevaluated and
    // must not be diagnosed (gcc/clang accept these).
    for src in [
        "#if 1 ? 2 : 1/0\nX\n#endif\n",
        "#if 1 || 1/0\nX\n#endif\n",
        "#if 0 && 1/0\nZ\n#endif\n",
    ] {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        assert!(pp.process(src).is_ok(), "dead branch must not error: {src}");
    }
}

#[test]
fn if_string_literal_equality_extension() {
    // c5 extension over C99 6.10.1p4: string-literal `==` / `!=`.
    let out = process("#if __BADC_TARGET__ == \"macos-aarch64\"\nT\n#else\nF\n#endif\n");
    assert!(out.contains('T'), "{out}");
    let out = process("#if __BADC_VERSION__ == \"0.1.0\"\nT\n#else\nF\n#endif\n");
    assert!(out.contains('T'), "{out}");
    let out = process("#if __BADC_TARGET__ != \"win-x64\"\nT\n#else\nF\n#endif\n");
    assert!(out.contains('T'), "{out}");
}

#[test]
fn function_like_macro_arity_is_checked() {
    // C99 6.10.3p4: argument count must match parameter count.
    assert!(process_err("#define ID(x) (x)\nint a = ID(1, 2);\n").contains("ID"));
    assert!(process_err("#define ADD(a,b) ((a)+(b))\nint x = ADD(1);\n").contains("ADD"));
    assert!(process_err("#define FOO() 42\nint x = FOO(1);\n").contains("FOO"));
    // A fixed parameter with no argument is rejected even for a
    // variadic macro.
    assert!(process_err("#define F(a, b, ...) g(a, b)\nint x = F(1);\n").contains('F'));
    // Valid arities: zero-param called empty, variadic empty tail,
    // variadic surplus absorbed.
    assert!(process("#define FOO() 42\nint x = FOO();\n").contains("42"));
    let out =
        process("#define LOG(fmt, ...) f(fmt, __VA_ARGS__)\nLOG(\"a\");\nLOG(\"a\", 1, 2);\n");
    assert!(out.contains("f("), "{out}");
}

#[test]
fn predefined_macros_expand() {
    let out = process("char *t = __BADC_TARGET__;\nchar *v = __BADC_VERSION__;\n");
    assert!(out.contains("\"macos-aarch64\""));
    assert!(out.contains("\"0.1.0\""));
}

#[test]
fn sizeof_int128_is_predefined() {
    // Headers gate their own 128-bit typedefs on `__SIZEOF_INT128__`
    // rather than probing for the type, so it is predefined
    // unconditionally (not behind `--gnu`) and reads 16.
    let probe = "#ifdef __SIZEOF_INT128__\nyes __SIZEOF_INT128__\n#else\nno\n#endif\n";
    let out = process(probe);
    assert!(
        out.contains("yes 16"),
        "expected __SIZEOF_INT128__ predefined as 16, got: {out}"
    );
}

#[test]
fn gnu_identity_macros_are_opt_in() {
    // `__GNUC__` and `__STRICT_ANSI__` are undefined by default.
    let probe = "#ifdef __GNUC__\nG yes\n#else\nG no\n#endif\n\
                 #ifdef __STRICT_ANSI__\nS yes\n#else\nS no\n#endif\n";
    let out = process(probe);
    assert!(
        out.contains("G no") && out.contains("S no"),
        "default: {out}"
    );

    // `enable_gnu` (the `--gnu` flag) defines both.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.enable_gnu();
    let out = pp.process(probe).expect("preprocessor failed");
    assert!(
        out.contains("G yes") && out.contains("S yes"),
        "--gnu: {out}"
    );
}

#[test]
fn vendor_and_stdc_pragmas_are_silent() {
    // GCC/clang vendor pragmas and the C99 6.10.6 STDC pragmas carry
    // no directive c5 acts on, so they must not warn.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.process(
        "#pragma GCC diagnostic push\n\
         #pragma GCC diagnostic ignored \"-Wunused\"\n\
         #pragma GCC diagnostic pop\n\
         #pragma GCC optimize(\"O2\")\n\
         #pragma clang loop unroll(disable)\n\
         #pragma STDC FP_CONTRACT OFF\n\
         int x;\n",
    )
    .expect("preprocessor failed");
    assert!(
        pp.warnings.is_empty(),
        "unexpected warnings: {:?}",
        pp.warnings
    );

    // An unrecognised pragma still surfaces a warning.
    let mut pp2 = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp2.process("#pragma frobnicate widgets\nint y;\n")
        .expect("preprocessor failed");
    assert!(!pp2.warnings.is_empty(), "unknown pragma should warn");
}

#[test]
fn builtin_expect_is_predefined() {
    // `__builtin_expect(exp, c)` is available with no header and no
    // auto-include; the expansion is the first operand.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let out = pp
        .process("int f(int v) { return __builtin_expect(v > 1, 1); }\n")
        .expect("preprocessor failed");
    assert!(
        out.contains("(v > 1)") && !out.contains("__builtin_expect"),
        "expected the predefined expansion, got: {out}"
    );
}

#[test]
fn va_builtins_are_preregistered() {
    // The __builtin_va_* intrinsics are registered with no header, so
    // freestanding code reaches them directly; <stdarg.h>'s
    // `#pragma intrinsic` re-registration maps to the same ids.
    let pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    for name in [
        "__builtin_va_start",
        "__builtin_va_arg",
        "__builtin_va_end",
        "__builtin_va_copy",
    ] {
        assert!(pp.intrinsics.contains_key(name), "{name} not preregistered");
    }
}

#[test]
fn pragma_intrinsic_bare_and_quoted_forms() {
    // MSVC's `#pragma intrinsic(name, name, ...)` names bare identifiers
    // as an inlining hint; c5 registers the ones it lowers specially and
    // ignores the rest (like MSVC's C4163) so MSVC-shaped SDK headers
    // parse. The quoted single-name form stays strict.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.process("#pragma intrinsic(alloca, _rotl8, __ll_lshift)\nint x;\n")
        .expect("bare intrinsic list must parse");
    assert!(
        pp.intrinsics.contains_key("alloca"),
        "known bare intrinsic registers"
    );
    assert!(
        !pp.intrinsics.contains_key("_rotl8"),
        "unknown bare intrinsic is ignored, not registered"
    );

    let mut pq = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pq.process("#pragma intrinsic(\"alloca\")\nint x;\n")
        .expect("quoted known intrinsic must parse");
    assert!(pq.intrinsics.contains_key("alloca"));

    // The quoted form stays strict: an unknown name is a typo, not a
    // silent no-op.
    let mut pr = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    assert!(
        pr.process("#pragma intrinsic(\"bogus\")\nint x;\n")
            .is_err(),
        "quoted unknown intrinsic must error"
    );
}

#[test]
fn self_referential_function_macro_in_nested_arg() {
    // C99 6.10.3.4: a self-referential function-like macro
    // (`#define M(x) M(inner(x))`) expands once and the recurring `M`
    // is not re-expanded, while `inner` in an argument still expands.
    // The blue-paint carries the painted `M(` through a nested call.
    let out = process(
        "#define TO_CAST(t, e) ((t)(e))\n\
         #define OBJ_CAST(op) TO_CAST(void*, (op))\n\
         #define GET(m) GET(OBJ_CAST(m))\n\
         #define DECREF(o) DECREF(OBJ_CAST(o))\n\
         void f(void *self) { DECREF(GET(self)); }\n",
    );
    assert!(
        out.contains("DECREF(((void*)((GET(((void*)((self))))))))"),
        "self-referential macros expanded wrong: {out}"
    );
    assert!(!out.contains("OBJ_CAST"), "leftover macro: {out}");
}

#[test]
fn lp64_predefined_for_lp64_targets_only() {
    let src = "#ifdef __LP64__\nint lp64;\n#endif\n#ifdef _LP64\nint _lp64;\n#endif\n";
    for t in [Target::MacOSAarch64, Target::LinuxAarch64, Target::LinuxX64] {
        let mut pp = Preprocessor::new(t.id_str(), t, "0.1.0");
        let out = pp.process(src).expect("preprocessor failed");
        assert!(out.contains("int lp64;"), "{t:?} should define __LP64__");
        assert!(out.contains("int _lp64;"), "{t:?} should define _LP64");
    }
    // Windows is LLP64 (32-bit long), so neither macro is defined.
    for t in [Target::WindowsX64, Target::WindowsAarch64] {
        let mut pp = Preprocessor::new(t.id_str(), t, "0.1.0");
        let out = pp.process(src).expect("preprocessor failed");
        assert!(!out.contains("int lp64;"), "{t:?} must not define __LP64__");
    }
}

#[test]
fn glibc_predefined_for_linux_targets_only() {
    let probe = "#ifdef __GLIBC__\nint have;\n#endif\n\
                 #if defined(__GLIBC__) && __GLIBC__==2 && __GLIBC_MINOR__==17\n\
                 int baseline;\n#endif\n";
    for t in [Target::LinuxAarch64, Target::LinuxX64] {
        let mut pp = Preprocessor::new(t.id_str(), t, "0.1.0");
        let out = pp.process(probe).expect("preprocessor failed");
        assert!(out.contains("int have;"), "{t:?} should define __GLIBC__");
        assert!(
            out.contains("int baseline;"),
            "{t:?} should define __GLIBC__==2 / __GLIBC_MINOR__==17"
        );
    }
    // Not glibc: macOS is Darwin libc, Windows links the CRT.
    for t in [
        Target::MacOSAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let mut pp = Preprocessor::new(t.id_str(), t, "0.1.0");
        let out = pp.process(probe).expect("preprocessor failed");
        assert!(
            !out.contains("int have;"),
            "{t:?} must not define __GLIBC__"
        );
    }
}

#[test]
fn glibc_cli_define_and_undef_win() {
    // The CLI define/undef lists are applied after the target
    // predefines (compiler::configure_preprocessor), so an explicit
    // `-U __GLIBC__` removes the Linux baseline and `-D __GLIBC__=<v>`
    // overrides its value. This mirrors that exact ordering.
    let undef = "#ifdef __GLIBC__\nint present;\n#endif\n";
    let mut pp = Preprocessor::new(Target::LinuxX64.id_str(), Target::LinuxX64, "0.1.0");
    pp.undef("__GLIBC__");
    let out = pp.process(undef).expect("preprocessor failed");
    assert!(!out.contains("int present;"), "-U __GLIBC__ must remove it");

    let over = "#if __GLIBC__==9\nint nine;\n#endif\n";
    let mut pp = Preprocessor::new(Target::LinuxX64.id_str(), Target::LinuxX64, "0.1.0");
    pp.define("__GLIBC__", "9");
    let out = pp.process(over).expect("preprocessor failed");
    assert!(out.contains("int nine;"), "-D __GLIBC__=9 must override");
}

#[test]
fn define_substitutes_in_subsequent_lines() {
    let out = process("#define FOO 42\nint x = FOO;\n");
    assert!(out.contains("int x = 42;"));
}

#[test]
fn macro_body_block_comment_spanning_lines() {
    // A `\`-continued macro whose body holds a block comment that
    // spans a physical-line break, where the comment-opening line
    // carries no trailing `\`. The newline inside the comment must
    // not terminate the definition (C99 5.1.1.2). Before the fix the
    // body truncated at the comment and `b = 1;` leaked to file scope.
    let src = "#define M(x) \\\n    do { \\\n        /* one\n           two */ \\\n        x = 1; \\\n    } while (0)\nint after;\nM(after);\n";
    let out = process(src);
    // The whole body is one macro, so `do {` and `while (0)` land on
    // the expansion line together and `after` is the only file-scope
    // object before the expansion.
    assert!(out.contains("do {"), "macro body lost: {out:?}");
    assert!(out.contains("while (0)"), "macro tail leaked: {out:?}");
    assert!(out.contains("int after;"), "{out:?}");
}

#[test]
fn block_comment_open_detector() {
    assert!(ends_in_open_block_comment("foo /* bar"));
    assert!(!ends_in_open_block_comment("foo /* bar */ baz"));
    assert!(!ends_in_open_block_comment("foo // /* not open"));
    assert!(!ends_in_open_block_comment("s = \"/*\""));
    assert!(ends_in_open_block_comment("c = '/' ; /* open"));
}

#[test]
fn cli_empty_define_expands_to_nothing() {
    // `-D NAME` (no `=`) is `1`; `-D NAME=` (with `=`, empty) stays
    // empty and expands to nothing -- the cpp convention, e.g.
    // `-DPRIVATE=` so `PRIVATE void f();` is `void f();`.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.define("EMPTY", "");
    pp.define("ONE", "1");
    let out = pp
        .process("EMPTY void f(void);\nint x = ONE;\n")
        .expect("preprocessor failed");
    assert!(out.contains("void f(void);"), "got: {out:?}");
    assert!(
        !out.contains("1 void f"),
        "empty define leaked a 1: {out:?}"
    );
    assert!(out.contains("int x = 1;"));
}

#[test]
fn macro_to_macro_substitution_chains() {
    let out = process("#define A B\n#define B 5\nint x = A;\n");
    assert!(out.contains("int x = 5;"));
}

#[test]
fn pragma_operator_once_marks_file() {
    // C99 6.10.9: `_Pragma("once")` in the main file is handled like
    // `#pragma once` and leaves no tokens in the output.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let out = pp
        .process("_Pragma(\"once\")\nint x = 1;\n")
        .expect("preprocessor failed");
    assert!(!out.contains("_Pragma"), "operator leaked: {out:?}");
    assert!(out.contains("int x = 1;"));
}

#[test]
fn pragma_operator_via_macro_stringize() {
    // The operand can be produced by the `#x` stringize feeding the
    // operator (`_Pragma(#x)`), the common `DO_PRAGMA` idiom.
    let out = process("#define DO_PRAGMA(x) _Pragma(#x)\nDO_PRAGMA(once)\nint y = 2;\n");
    assert!(!out.contains("_Pragma"), "operator leaked: {out:?}");
    assert!(out.contains("int y = 2;"));
}

#[test]
fn pragma_operator_pack_emits_inline_directive() {
    // `pack` is position-sensitive, so the operator re-emits an
    // inline `#pragma pack` for the lexer to fold at this point.
    let out = process("_Pragma(\"pack(1)\")\nstruct S { char a; };\n");
    assert!(out.contains("#pragma pack(1)"), "no inline pack: {out:?}");
}

#[test]
fn pragma_operator_ignored_inside_string_literal() {
    // The operator name inside a string literal is ordinary text.
    let out = process("const char *s = \"_Pragma(\\\"once\\\")\";\n");
    assert!(out.contains("\"_Pragma(\\\"once\\\")\""), "got: {out:?}");
}

#[test]
fn msvc_pragma_operator_warning_leaves_no_tokens() {
    // MSVC `__pragma(tokens)` carries a `#pragma` directive with a raw
    // token operand; `warning(...)` is handled and contributes no tokens.
    let out = process("__pragma(warning(disable : 4201))\nint x = 1;\n");
    assert!(!out.contains("__pragma"), "operator leaked: {out:?}");
    assert!(out.contains("int x = 1;"));
}

#[test]
fn pragma_warning_tolerates_space_before_paren() {
    // MSVC allows a space between the keyword and its argument list:
    // `#pragma warning ( disable : N )`. That must dispatch like the
    // no-space form, not fall through to the unknown-pragma warning.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.process("#pragma warning ( disable : 4214 )\nint x = 1;\n")
        .expect("preprocessor failed");
    assert!(
        !pp.warnings.iter().any(|w| w.contains("unknown")),
        "spaced warning pragma warned as unknown: {:?}",
        pp.warnings
    );
}

#[test]
fn msvc_pragma_operator_pack_emits_inline_directive() {
    // `pack` via `__pragma` re-emits an inline `#pragma pack` like the
    // C99 `_Pragma` path, so the lexer folds it at this position.
    let out = process("__pragma(pack(1))\nstruct S { char a; };\n");
    assert!(out.contains("#pragma pack(1)"), "no inline pack: {out:?}");
}

#[test]
fn msvc_pragma_operator_ignored_inside_string_literal() {
    // The operator name inside a string literal is ordinary text.
    let out = process("const char *s = \"__pragma(warning(pop))\";\n");
    assert!(out.contains("\"__pragma(warning(pop))\""), "got: {out:?}");
}

#[test]
fn named_rest_variadic_macro_binds_tail() {
    // `#define foo(rest...)` reaches the trailing args through `rest`.
    let out = process("#define F(args...) g(args)\nF(1, 2, 3);\n");
    assert!(out.contains("g(1, 2, 3);"), "got: {out:?}");
}

#[test]
fn named_rest_variadic_macro_fixed_plus_tail() {
    let out = process("#define F(a, rest...) g(a, rest)\nF(1, 2, 3);\n");
    assert!(out.contains("g(1, 2, 3);"), "got: {out:?}");
}

#[test]
fn named_rest_variadic_macro_paste_elides_comma() {
    // `, ##rest` drops the comma when the tail is empty, matching the
    // `, ##__VA_ARGS__` GNU behaviour.
    let out = process("#define F(a, rest...) g(a, ##rest)\nF(1);\nF(1, 2);\n");
    assert!(out.contains("g(1);"), "empty tail not elided: {out:?}");
    assert!(out.contains("g(1, 2);"), "non-empty tail: {out:?}");
}

#[test]
fn named_rest_variadic_macro_stringize() {
    let out = process("#define S(rest...) #rest\nconst char *s = S(a, b);\n");
    assert!(out.contains("\"a, b\""), "got: {out:?}");
}

#[test]
fn function_like_macro_substitutes_params() {
    let out = process("#define ADD(a, b) ((a) + (b))\nint x = ADD(1, 2);\n");
    assert!(
        out.contains("int x = ((1) + (2));"),
        "fn-like macro should substitute both params:\n{out}"
    );
}

#[test]
fn function_like_macro_preserves_nested_call_args() {
    // Args with nested parens / calls shouldn't be split by the
    // top-level comma scanner.
    let out = process("#define WRAP(x) f(x)\nint y = WRAP(g(1, 2));\n");
    assert!(
        out.contains("int y = f(g(1, 2));"),
        "nested-paren args should round-trip:\n{out}"
    );
}

#[test]
fn function_like_macro_only_fires_when_followed_by_paren() {
    // `va_end` style: calling with parens expands; the bare name
    // (no parens) stays a plain identifier.
    let out = process("#define NOOP(x)\nNOOP(arg);\nint NOOP;\n");
    assert!(out.contains(";\nint NOOP;"));
}

#[test]
fn function_like_macro_fires_with_paren_on_next_line() {
    // C99 6.10.3: white space, including a newline, may separate a
    // function-like macro's name from the `(` that invokes it. A name at
    // the end of a line with its `(` on the following line is still a
    // call and must expand.
    let out = process("#define ADD(a, b) ((a) + (b))\nint x = ADD\n    (1, 2);\n");
    assert!(out.contains("((1) + (2))"), "got: {out:?}");
}

#[test]
fn guarded_mutual_include_is_not_cyclic() {
    // Two headers may include each other when an include guard breaks the
    // recursion: the second pass over a guarded header skips its body
    // (C99 6.10.1 / 6.10.2). The preprocessor must process the re-include
    // rather than reject it as a cycle on the bare observation that the
    // name is already on the include path.
    use std::io::Write;
    let dir = std::env::temp_dir().join(format!("badc_pp_guard_{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    std::fs::File::create(dir.join("a.h"))
        .unwrap()
        .write_all(b"#ifndef A_H\n#define A_H\n#include \"b.h\"\nint a_marker;\n#endif\n")
        .unwrap();
    std::fs::File::create(dir.join("b.h"))
        .unwrap()
        .write_all(b"#ifndef B_H\n#define B_H\n#include \"a.h\"\nint b_marker;\n#endif\n")
        .unwrap();
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_search_path(dir.to_str().unwrap());
    let out = pp
        .process("#include \"a.h\"\n")
        .expect("guarded mutual include must not be reported cyclic");
    std::fs::remove_dir_all(&dir).ok();
    assert_eq!(
        out.matches("a_marker").count(),
        1,
        "a body included once:\n{out}"
    );
    assert_eq!(
        out.matches("b_marker").count(),
        1,
        "b body included once:\n{out}"
    );
}

#[test]
fn stringify_operator_quotes_argument() {
    let out = process("#define STR(x) #x\nchar *s = STR(hello world);\n");
    assert!(
        out.contains("\"hello world\""),
        "stringification should produce a string literal:\n{out}"
    );
}

#[test]
fn stringify_escapes_quote_and_backslash() {
    // The arg is the string-literal token `"hi"` (a balanced-quoted
    // pair) -- macro_args parses it as one arg whose text is
    // literally `"hi"`. Stringification must wrap that in another
    // pair of quotes and escape the inner ones, yielding
    // `"\"hi\""`.
    let out = process("#define STR(x) #x\nchar *s = STR(\"hi\");\n");
    assert!(
        out.contains("\"\\\"hi\\\"\""),
        "stringification must escape `\"`:\n{out}"
    );
}

#[test]
fn token_paste_joins_tokens() {
    let out = process("#define PASTE(a, b) a ## b\nint PASTE(x, y) = 0;\n");
    assert!(
        out.contains("int xy = 0;"),
        "## should produce the joined identifier:\n{out}"
    );
}

#[test]
fn variadic_macro_expands_va_args() {
    let out = process("#define CALL(...) f(__VA_ARGS__)\nCALL(1, 2, 3);\n");
    assert!(
        out.contains("f(1, 2, 3);"),
        "__VA_ARGS__ should join the variadic args with `, `:\n{out}"
    );
}

#[test]
fn variadic_macro_with_fixed_param() {
    let out = process("#define LOG(level, ...) printf(level, __VA_ARGS__)\nLOG(\"x\", 1, 2);\n");
    assert!(
        out.contains("printf(\"x\", 1, 2);"),
        "fixed param + __VA_ARGS__ should both substitute:\n{out}"
    );
}

#[test]
fn fn_like_macro_recurses_through_other_macros() {
    // An object-like macro whose body contains a function-like
    // macro call should re-expand: TWICE -> INC(INC(0)) -> the
    // INC names disappear and a `+ 1` appears twice. The exact
    // paren shape depends on what each INC step adds, so the
    // test pins the structural facts rather than the literal
    // spelling.
    let out = process("#define INC(n) ((n) + 1)\n#define TWICE INC(INC(0))\nint x = TWICE;\n");
    assert!(!out.contains("INC"), "INC should be fully expanded:\n{out}");
    assert_eq!(
        out.matches("+ 1").count(),
        2,
        "two increments expected:\n{out}"
    );
}

#[test]
fn define_strips_trailing_line_comment() {
    // Without the strip, the substitution would expand to
    // `int x = 42 // a constant ;` and the lexer's `//` would
    // swallow the trailing `;`, breaking parsing entirely.
    let out = process("#define FOO 42 // a constant\nint x = FOO;\n");
    assert!(
        out.contains("int x = 42;"),
        "expected `int x = 42;` after macro expansion, got:\n{out}"
    );
    assert!(!out.contains("// a constant"));
}

#[test]
fn define_body_keeps_slashes_inside_string_literal() {
    // Comment removal happens in translation phase 3 (C99
    // 5.1.1.2), where a quoted string is opaque; `//` and `/*`
    // inside one are literal content, not comment openers.
    let out = process(
        "#define URL \"http://x.com/*y*/\"\n#define P 'a' // note\nconst char *u = URL;\nchar c = P;\n",
    );
    assert!(
        out.contains("const char *u = \"http://x.com/*y*/\";"),
        "string body truncated:\n{out}"
    );
    assert!(out.contains("char c = 'a';"), "{out}");
}

#[test]
fn if_string_comparison_keeps_slashes_inside_literal() {
    // The `#if` expression strip must also treat literals as
    // opaque; `//` inside a compared string is not a comment.
    let src = "#define U \"a//b\"\n#if U == \"a//b\"\nint yes;\n#else\nint no;\n#endif\n";
    let out = process(src);
    assert!(out.contains("int yes;"), "{out:?}");
    assert!(!out.contains("int no;"), "{out:?}");
}

#[test]
fn ifdef_keeps_active_branch() {
    let src = "#define FOO 1\n#ifdef FOO\nint a;\n#else\nint b;\n#endif\n";
    let out = process(src);
    assert!(out.contains("int a;"));
    assert!(!out.contains("int b;"));
}

#[test]
fn ifdef_sees_function_like_macro() {
    // C99 6.10.1: `#ifdef` / `#ifndef` test definedness for any
    // macro, including function-like ones (kept in a separate
    // table from object-like macros).
    let src = "#define F(x) ((x)+1)\n#ifdef F\nint a;\n#else\nint b;\n#endif\n";
    let out = process(src);
    assert!(out.contains("int a;"), "#ifdef should see fn-like macro F");
    assert!(!out.contains("int b;"));
    let src2 = "#define F(x) ((x)+1)\n#ifndef F\nint a;\n#else\nint b;\n#endif\n";
    let out2 = process(src2);
    assert!(
        out2.contains("int b;"),
        "#ifndef of a defined fn-like macro takes #else"
    );
    assert!(!out2.contains("int a;"));
}

#[test]
fn ifndef_keeps_inactive_branch() {
    let src = "#ifndef BAR\nint a;\n#else\nint b;\n#endif\n";
    let out = process(src);
    assert!(out.contains("int a;"));
    assert!(!out.contains("int b;"));
}

#[test]
fn if_equality_checks_macro_value() {
    let src = "#if __BADC_TARGET__ == \"macos-aarch64\"\nint mac;\n#else\nint other;\n#endif\n";
    let out = process(src);
    assert!(out.contains("int mac;"));
    assert!(!out.contains("int other;"));
}

#[test]
fn if_inequality_negates() {
    let src = "#if __BADC_TARGET__ != \"windows-x64\"\nint here;\n#endif\n";
    let out = process(src);
    assert!(out.contains("int here;"));
}

#[test]
fn nested_conditionals_respect_parent() {
    let src = "#ifdef ABSENT\n#ifdef __BADC_VERSION__\nint inner;\n#endif\n#endif\nint outer;\n";
    let out = process(src);
    assert!(!out.contains("int inner;"));
    assert!(out.contains("int outer;"));
}

#[test]
fn pragma_records_dylib() {
    let src = "\
#pragma dylib(libfoo, \"libfoo.so\")
#pragma dylib(bar, \"bar.dll\")
";
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.process(src).unwrap();
    let entries: Vec<(&str, &str)> = pp
        .dylibs
        .iter()
        .map(|d| (d.name.as_str(), d.path.as_str()))
        .collect();
    assert_eq!(entries, vec![("libfoo", "libfoo.so"), ("bar", "bar.dll")]);
}

#[test]
fn pragma_binding_attaches_to_named_dylib() {
    let src = "\
#pragma dylib(libfoo, \"libfoo.so\")
#pragma dylib(libbar, \"libbar.so\")
#pragma binding(libfoo::printf, \"_printf\")
#pragma binding(libbar::exit, \"ExitProcess\")
#pragma binding(libfoo::malloc, \"_malloc\")
";
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.process(src).unwrap();
    assert_eq!(pp.dylibs.len(), 2);
    assert_eq!(pp.dylibs[0].name, "libfoo");
    assert_eq!(pp.dylibs[0].bindings.len(), 2);
    assert_eq!(pp.dylibs[0].bindings[0].local_name, "printf");
    assert_eq!(pp.dylibs[0].bindings[0].real_symbol, "_printf");
    assert_eq!(pp.dylibs[0].bindings[1].local_name, "malloc");
    assert_eq!(pp.dylibs[1].name, "libbar");
    assert_eq!(pp.dylibs[1].bindings.len(), 1);
    assert_eq!(pp.dylibs[1].bindings[0].local_name, "exit");
    assert_eq!(pp.dylibs[1].bindings[0].real_symbol, "ExitProcess");
}

#[test]
fn pragma_binding_for_undeclared_dylib_errors() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let err = pp
        .process("#pragma binding(libnothing::printf, \"_printf\")\n")
        .unwrap_err();
    assert!(format!("{err}").contains("no `#pragma dylib(libnothing, ...)`"));
}

#[test]
fn pragma_binding_without_qualifier_errors() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let err = pp
        .process("#pragma dylib(libfoo, \"x\")\n#pragma binding(printf, \"p\")\n")
        .unwrap_err();
    assert!(format!("{err}").contains("LHS must be `dylib_name::local_name`"));
}

#[test]
fn pragma_dylib_duplicate_errors() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let err = pp
        .process("#pragma dylib(libfoo, \"x\")\n#pragma dylib(libfoo, \"y\")\n")
        .unwrap_err();
    assert!(format!("{err}").contains("already declared"));
}

#[test]
fn unmatched_endif_is_an_error() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let err = pp.process("#endif\n").unwrap_err();
    assert!(format!("{err}").contains("`#endif` with no matching `#if`"));
}

#[test]
fn unterminated_block_is_an_error() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let err = pp.process("#ifdef FOO\nint x;\n").unwrap_err();
    assert!(format!("{err}").contains("unterminated"));
}

#[test]
fn leading_marker_names_top_level_source() {
    // every preprocessed buffer opens with a GNU line
    // marker so the lexer attributes the first source line to
    // `(<source>, 1)` rather than letting its initial state
    // decide. Without this, an `#include` later in the buffer
    // would never have a "previous file" to return to.
    let out = process("int x;\n");
    assert!(out.starts_with("# 1 \"<source>\"\n"));
}

#[test]
fn line_directive_retargets_file_and_line() {
    // `#line N "file"` rewrites the lexer's
    // `(file, line)` state so the next source line is
    // attributed to `(file, N)`.
    let out = process("#line 100 \"fakegen.c\"\nint x;\n");
    // The `#line` line itself is consumed by the marker; the
    // next non-blank output should be a `# 100 "fakegen.c"`
    // marker followed (eventually) by `int x;`.
    assert!(out.contains("# 100 \"fakegen.c\""));
    assert!(out.contains("int x;"));
}

#[test]
fn line_directive_without_filename_keeps_current_file() {
    // C99 6.10.4: bare `#line N` retargets the line counter
    // but leaves the filename alone.
    let out = process("#line 50\nint x;\n");
    // The marker re-uses the current filename (`<source>`).
    assert!(out.contains("# 50 \"<source>\""));
}

#[test]
fn directives_become_blank_lines_for_line_alignment() {
    // The preprocessor prepends a `# 1 "<source>"\n` GNU line
    // marker so the lexer can attribute later tokens to a
    // specific (file, line). Skip it before counting.
    let src = "#define X 1\nint a = X;\n";
    let out = process(src);
    let lines: Vec<&str> = out.lines().skip_while(|l| l.starts_with('#')).collect();
    assert_eq!(lines.len(), 2);
    assert_eq!(lines[0], "");
    assert!(lines[1].contains("int a = 1;"));
}

#[test]
fn string_literals_are_not_substituted() {
    let src = "#define X 1\nchar *s = \"X is a letter\";\n";
    let out = process(src);
    assert!(out.contains("\"X is a letter\""));
}

#[test]
fn defined_form_works_in_if() {
    let src = "#if defined(__BADC_VERSION__)\nint a;\n#endif\n";
    let out = process(src);
    assert!(out.contains("int a;"));
}

#[test]
fn wide_char_constant_in_if() {
    // C11 6.4.4.4: a character constant in a `#if` controlling
    // expression may carry an `L` / `u` / `U` encoding prefix.
    let src = "#define SEP L'/'\n#if SEP == '/'\nint yes;\n#else\nint no;\n#endif\n";
    let out = process(src);
    assert!(out.contains("int yes;"), "{out:?}");
    assert!(!out.contains("int no;"), "{out:?}");
}

#[test]
fn has_include_operator_in_if() {
    // C23 6.10.1: `__has_include(<header>)` is 1 when the header
    // resolves, 0 otherwise; `defined(__has_include)` is the guard.
    let src = "#if defined(__has_include) && __has_include(<stdint.h>)\nint found;\n#endif\n\
               #if __has_include(<no_such_header_zz.h>)\nint bogus;\n#endif\n";
    let out = process(src);
    assert!(out.contains("int found;"), "{out:?}");
    assert!(!out.contains("int bogus;"), "{out:?}");
}

#[test]
fn unknown_include_is_a_hard_error() {
    // A header that resolves nowhere aborts the compile, as in
    // gcc/clang; continuing with an empty body would miscompile.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let err = pp
        .process("#include <not-a-real-header.h>\nint main() { return 0; }\n")
        .expect_err("missing include must fail");
    let C5Error::Compile(msg) = err else {
        panic!("expected a compile error");
    };
    assert!(msg.contains("not-a-real-header.h"), "{msg}");
    assert!(msg.contains("not found"), "{msg}");
}

#[test]
fn counter_monotonically_increases() {
    // Each `__COUNTER__` expansion advances the per-TU
    // counter, starting from 0. The `##` paste here mints
    // unique identifiers, the canonical use case. Three levels
    // of indirection are required: `##` operands use the
    // unexpanded argument (C99 6.10.3.1), so the extra `CAT`
    // layer forces `__COUNTER__` to expand before the paste.
    let src = "\
#define CAT_(a, b) a##b
#define CAT(a, b)  CAT_(a, b)
#define UNIQUE(prefix) CAT(prefix, __COUNTER__)
int UNIQUE(x_);
int UNIQUE(x_);
int x_2 = __COUNTER__;
";
    let out = process(src);
    assert!(out.contains("int x_0;"), "first counter use: {out}");
    assert!(out.contains("int x_1;"), "second counter use: {out}");
    assert!(out.contains("int x_2 = 2"), "third counter use: {out}");
}

#[test]
fn counter_resets_per_preprocessor_instance() {
    // Each fresh Preprocessor starts its counter at 0 -- two
    // separate translation units don't share state.
    let mut pp1 = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let out1 = pp1.process("int a = __COUNTER__;\n").unwrap();
    assert!(out1.contains("int a = 0"));
    let mut pp2 = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let out2 = pp2.process("int a = __COUNTER__;\n").unwrap();
    assert!(out2.contains("int a = 0"));
}

#[test]
fn pragma_warning_disable_records_ids() {
    // `#pragma warning(disable : N N N)`. Each ID lands in
    // `warning_disabled`.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp
        .process("#pragma warning(disable : 4054 4055 4100)\n")
        .expect("preprocessor failed");
    assert!(
        pp.warnings.is_empty(),
        "expected no warnings: {:?}",
        pp.warnings
    );
    assert_eq!(
        pp.warning_disabled.iter().copied().collect::<Vec<_>>(),
        vec![4054_u32, 4055, 4100]
    );
}

#[test]
fn pragma_warning_enable_clears_ids() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp
        .process(
            "#pragma warning(disable : 100 200 300)\n\
             #pragma warning(enable : 200)\n",
        )
        .unwrap();
    assert_eq!(
        pp.warning_disabled.iter().copied().collect::<Vec<_>>(),
        vec![100_u32, 300]
    );
}

#[test]
fn pragma_warning_push_pop_restores_state() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp
        .process(
            "#pragma warning(disable : 100)\n\
             #pragma warning(push)\n\
             #pragma warning(disable : 200)\n\
             #pragma warning(pop)\n",
        )
        .unwrap();
    assert!(pp.warning_disabled.contains(&100));
    assert!(!pp.warning_disabled.contains(&200));
}

#[test]
fn pragma_warning_pop_without_push_warns() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp.process("#pragma warning(pop)\n").unwrap();
    assert!(
        pp.warnings.iter().any(|w| w.contains("no matching push")),
        "expected unmatched-pop warning: {:?}",
        pp.warnings
    );
}

#[test]
fn pragma_warning_bad_action_warns() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp.process("#pragma warning(silence : 4267)\n").unwrap();
    assert!(
        pp.warnings.iter().any(|w| w.contains("silence")),
        "expected unrecognised-action warning: {:?}",
        pp.warnings
    );
}

#[test]
fn pragma_warning_bad_id_warns() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp.process("#pragma warning(disable : abc)\n").unwrap();
    assert!(
        pp.warnings
            .iter()
            .any(|w| w.contains("expected an integer")),
        "expected bad-ID warning: {:?}",
        pp.warnings
    );
}

#[test]
fn pragma_warning_push_with_level_accepted() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp
        .process(
            "#pragma warning(push, 3)\n\
             #pragma warning(disable : 100)\n\
             #pragma warning(pop)\n",
        )
        .unwrap();
    assert!(pp.warnings.is_empty(), "got warnings: {:?}", pp.warnings);
    assert!(pp.warning_disabled.is_empty());
}

#[test]
fn pragma_warn_disable_codes_recorded() {
    // Borland / Watcom form: `-<code>` per warning category
    // to silence. Multiple tokens per line are accepted.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp
        .process(
            "#pragma warn -rch\n\
             #pragma warn -aus -csu\n",
        )
        .unwrap();
    assert!(pp.warnings.is_empty(), "got warnings: {:?}", pp.warnings);
    let codes: Vec<&str> = pp.warn_disabled.iter().map(|s| s.as_str()).collect();
    assert_eq!(codes, vec!["aus", "csu", "rch"]);
}

#[test]
fn pragma_warn_plus_and_dot_clear() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp
        .process(
            "#pragma warn -rch -aus -csu\n\
             #pragma warn +aus\n\
             #pragma warn .csu\n",
        )
        .unwrap();
    let codes: Vec<&str> = pp.warn_disabled.iter().map(|s| s.as_str()).collect();
    assert_eq!(codes, vec!["rch"]);
}

#[test]
fn pragma_warn_bad_sign_warns() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp.process("#pragma warn rch\n").unwrap();
    assert!(
        pp.warnings.iter().any(|w| w.contains("leading")),
        "expected bad-sign warning: {:?}",
        pp.warnings
    );
}

#[test]
fn pragma_warn_empty_warns() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp.process("#pragma warn\n").unwrap();
    assert!(
        pp.warnings.iter().any(|w| w.contains("no payload")),
        "expected empty-payload warning: {:?}",
        pp.warnings
    );
}

#[test]
fn unknown_directive_warns() {
    // C99 6.10.6 reserves non-directive forms for the
    // implementation; gcc / clang warn rather than fail.
    // c5 follows that shape.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let _ = pp
        .process("#frobnicate args\nint main() { return 0; }\n")
        .expect("preprocessor failed");
    assert!(
        pp.warnings.iter().any(|w| w.contains("`#frobnicate`")),
        "expected a warning naming `#frobnicate`; got {:?}",
        pp.warnings
    );
}

#[test]
fn counted_by_predefined_empty() {
    // `__counted_by(m)` and its endian variants annotate a flexible array
    // member with its count field (a bounds hint, GCC 15 / Clang). badc
    // does not implement the attribute; the macros are predefined empty
    // (the kernel UAPI fallback for a compiler without it), so a header
    // reaching for them without its own guard still compiles.
    for macro_name in ["__counted_by", "__counted_by_le", "__counted_by_be"] {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let src = format!("struct s {{ unsigned n; int a[] {macro_name}(n); }};\n");
        let out = pp.process(&src).expect("preprocessor failed");
        assert!(out.contains("int a[]"), "{out}");
        assert!(
            !out.contains(macro_name),
            "{macro_name} should expand away: {out}"
        );
    }
}

#[test]
fn show_includes_records_resolution_trace() {
    // gcc `-H`-shape trace -- one line per `#include`, with
    // leading dots marking nesting depth. A missing header
    // emits a `! name (missing)` line in the same trace.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.set_show_includes(true);
    let _ = pp
        .process("#include <not-a-real-header.h>\nint main() { return 0; }\n")
        .expect_err("missing include must fail");
    assert!(
        pp.include_trace
            .iter()
            .any(|l| l.starts_with("!") && l.contains("not-a-real-header.h")),
        "trace should mark missing header: {:?}",
        pp.include_trace
    );
}

#[test]
fn quoted_include_form_is_recognised() {
    // `"foo.h"` resolves through the same search chain as
    // `<foo.h>` (C99 6.10.2p2/p3), so a search-path hit works
    // for both spellings.
    let base = std::env::temp_dir().join(format!("badc-quoted-inc-{}", std::process::id()));
    std::fs::create_dir_all(&base).unwrap();
    std::fs::write(base.join("foo.h"), "int from_quoted;\n").unwrap();
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_search_path(base.to_str().unwrap());
    let out = pp.process("#include \"foo.h\"\nint main() {}\n").unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert!(out.contains("from_quoted"), "{out}");
    assert!(out.contains("int main()"), "{out}");
}

#[test]
fn iquote_paths_apply_to_quoted_includes_only() {
    // gcc `-iquote` scope: probed for `#include "..."` (after the
    // including file's directory, before `-I`), never for `<...>`.
    let base = std::env::temp_dir().join(format!("badc-iquote-{}", std::process::id()));
    let qdir = base.join("q");
    let adir = base.join("a");
    std::fs::create_dir_all(&qdir).unwrap();
    std::fs::create_dir_all(&adir).unwrap();
    std::fs::write(qdir.join("pick.h"), "int from_quote_dir;\n").unwrap();
    std::fs::write(adir.join("pick.h"), "int from_angle_dir;\n").unwrap();
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_quote_path(qdir.to_str().unwrap());
    pp.add_search_path(adir.to_str().unwrap());
    // Quoted form: the -iquote dir wins over -I.
    let out = pp.process("#include \"pick.h\"\n").unwrap();
    assert!(out.contains("from_quote_dir"), "{out}");
    // Angle form: the -iquote dir is invisible.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_quote_path(qdir.to_str().unwrap());
    pp.add_search_path(adir.to_str().unwrap());
    let out = pp.process("#include <pick.h>\n").unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert!(out.contains("from_angle_dir"), "{out}");
}

#[test]
fn pp_number_is_one_token_in_substitution() {
    // C99 6.4.8: `2op` is a single pp-number; the `op` tail is not
    // a parameter reference, so pasting forms `T_2op`.
    let out = process(
        "#define GLUE(a,b) a##b\n\
         #define E3(op, arg) GLUE(T_, arg) GLUE(gen_, op)\n\
         #define E1(op) E3(op, 2op)\n\
         E1(FOO)\n",
    );
    let line = out.lines().rfind(|l| !l.trim().is_empty()).unwrap_or("");
    assert_eq!(line.trim(), "T_2op gen_FOO", "{out}");
    // An object-like macro name embedded in a pp-number stays put.
    let out = process("#define f 99\nx = 1.f;\n");
    let line = out.lines().rfind(|l| !l.trim().is_empty()).unwrap_or("");
    assert_eq!(line.trim(), "x = 1.f;", "{out}");
}

#[test]
fn expansion_seams_do_not_paste_tokens() {
    // Substituted text must not re-lex into its neighbors: `-x`
    // with `x` = `-22` keeps two `-` tokens (C99 6.10.3.3 reserves
    // gluing for `##`).
    let out = process("#define E 22\n#define M(x) (-x)\nint v = M(-E);\n");
    let line = out.lines().rfind(|l| !l.trim().is_empty()).unwrap_or("");
    assert_eq!(line.trim(), "int v = (- -22);", "{out}");
    // Object-like expansion head seam.
    let out = process("#define MINUS22 -22\nint w = 30 - MINUS22;\n");
    let line = out.lines().rfind(|l| !l.trim().is_empty()).unwrap_or("");
    assert_eq!(line.trim(), "int w = 30 - -22;", "{out}");
    // `##` still glues.
    let out = process("#define CAT(x,y) x##y\nint CAT(v,1) = 9;\n");
    let line = out.lines().rfind(|l| !l.trim().is_empty()).unwrap_or("");
    assert_eq!(line.trim(), "int v1 = 9;", "{out}");
}

#[test]
fn include_parent_dir_resolves_bare_filename_to_cwd() {
    // A bare source filename names a file in the current directory,
    // so a quoted include in it must search the cwd (empty dir,
    // joined cwd-relative by find_include), not be skipped.
    assert_eq!(include_parent_dir("src.c"), Some(String::new()));
    assert_eq!(include_parent_dir("dir/src.c"), Some("dir".to_string()));
    assert_eq!(
        include_parent_dir("/abs/dir/src.c"),
        Some("/abs/dir".to_string())
    );
    // The stdin label behaves like a bare filename: gcc resolves a
    // quoted include in piped source against the working directory.
    assert_eq!(include_parent_dir("-"), Some(String::new()));
}

#[test]
fn object_like_alias_chain_blue_paints_intermediates() {
    // C99 6.10.3.4p2: every name replaced on the way to the terminal
    // body stays painted for the rescan. Without that, the rescan of
    // `B x` re-fires B -> C -> `B x` and duplicates the tail.
    let out = process("#define A B\n#define B C\n#define C B x\nA\n");
    let line = out.lines().rfind(|l| !l.trim().is_empty()).unwrap_or("");
    assert_eq!(line.trim(), "B x", "{out}");
    // Mutual recursion through an alias stops at the painted name.
    let out = process("#define P Q\n#define Q P\nP\n");
    let line = out.lines().rfind(|l| !l.trim().is_empty()).unwrap_or("");
    assert_eq!(line.trim(), "P", "{out}");
}

#[test]
fn if_char_constant_decodes_hex_and_octal_escapes() {
    for e in [
        "'\\x41' == 65",
        "'\\101' == 65",
        // Signed plain char on this target: '\xff' sign-extends.
        "'\\xff' == -1",
        "'\\x7f' == 127",
        "'\\0' == 0",
        "'\\11' == 9",
        "'AB' == 0x4142",
    ] {
        let out = process(&format!("#if {e}\nTAKEN\n#else\nNOT\n#endif\n"));
        assert!(out.contains("TAKEN"), "{e}: {out}");
    }
}

#[test]
fn if_ternary_applies_usual_arithmetic_conversions() {
    // C99 6.5.15p5: the arms convert to a common type, so an
    // unsigned arm makes the picked signed arm's value unsigned.
    for e in ["(1 ? -1 : 0u) > 0", "(0 ? 0u : -1) > 0"] {
        let out = process(&format!("#if {e}\nTAKEN\n#else\nNOT\n#endif\n"));
        assert!(out.contains("TAKEN"), "{e}: {out}");
    }
    // Both arms signed: the value stays signed.
    let out = process("#if (1 ? -1 : 0) < 0\nTAKEN\n#endif\n");
    assert!(out.contains("TAKEN"), "{out}");
}

#[test]
fn macro_args_split_across_an_enclosing_conditional() {
    // An `#else` / `#endif` seen while joining macro-argument lines
    // with no locally opened frame belongs to the enclosing
    // conditional: the joiner must apply it to the outer stack, skip
    // the inactive branch's lines, and leave the block terminated.
    let src =
        "#define m(a,b) a+b\n#define A 1\n#if A\nint x = m(1,\n#else\nint x = m(2,\n#endif\n3);\n";
    let out = process(src);
    assert!(out.contains("1+3"), "{out}");
    assert!(!out.contains("2+"), "{out}");
    // The not-taken arm joins the other branch's argument line.
    let src = "#define m(a,b) a+b\n#if 0\nint x = m(1,\n#else\nint x = m(2,\n#endif\n3);\n";
    let out = process(src);
    assert!(out.contains("2+3"), "{out}");
}

#[test]
fn conditional_inside_macro_argument_list() {
    // C99 6.10.3p11 leaves directives inside an argument list
    // undefined; gcc and clang evaluate them and keep the surviving
    // tokens as argument text. Output checked against gcc -E.
    let src = "#define CALL(x,y) f(x,y)\nint g(void) { return CALL(1,\n#if 1\n2\n#else\n3\n#endif\n); }\n";
    let out = process(src);
    assert!(out.contains("f(1,2)") || out.contains("f(1, 2)"), "{out}");
    let src = "#define CALL(x,y) f(x,y)\nint g(void) { return CALL(1,\n#if 0\n2\n#else\n3\n#endif\n); }\n";
    let out = process(src);
    assert!(out.contains("f(1,3)") || out.contains("f(1, 3)"), "{out}");
}

#[test]
fn define_inside_macro_argument_list() {
    // gcc processes a `#define` between macro arguments; the new name
    // expands in the argument text. Output checked against gcc -E.
    let src = "#define CALL(x,y) f(x,y)\nint g(void) { return CALL(1,\n#define TWO 2\nTWO\n); }\n";
    let out = process(src);
    assert!(out.contains("f(1,2)") || out.contains("f(1, 2)"), "{out}");
    // The definition persists past the invocation.
    let src = "#define CALL(x,y) f(x,y)\nint g(void) { return CALL(1,\n#define TWO 2\nTWO\n); }\nint t = TWO;\n";
    let out = process(src);
    assert!(out.contains("int t = 2;"), "{out}");
}

#[test]
fn nested_conditionals_inside_macro_argument_list() {
    // Output checked against gcc -E.
    let src = "#define CALL(x,y) f(x,y)\nint g(void) { return CALL(CALL(1,\n#if 1\n9\n#endif\n),\n#if 1\n#if 0\n5\n#else\n2\n#endif\n#else\n3\n#endif\n); }\n";
    let out = process(src);
    assert!(
        out.contains("f(f(1,9),2)") || out.contains("f(f(1, 9), 2)"),
        "{out}"
    );
}

#[test]
fn macro_argument_list_closed_inside_conditional_arm() {
    // The call's `)` sits inside a conditional arm, so argument
    // collection ends while the `#if` is still open and the `#endif`
    // arrives after the invocation. The conditional stack is shared
    // with the top level, matching gcc; a private per-invocation
    // stack loses the open frame and misreports the trailing
    // `#endif` as unmatched. Output checked against gcc -E.
    for (cond, picked) in [("#ifdef ZZZ", "3"), ("#ifndef ZZZ", "2")] {
        let src = format!(
            "#define M(a) f(a)\nint g(int c) {{ return M(c ? 1 :\n{cond}\n2);\n#else\n3);\n#endif\n}}\n"
        );
        let out = process(&src);
        assert!(out.contains(&format!("f(c ? 1 : {picked})")), "{out}");
    }
}

#[test]
fn has_include_quoted_form_searches_the_including_dir() {
    // C99 6.10.2p2 via C23 6.10.1: the quoted `__has_include` form
    // probes the including file's directory exactly as the matching
    // `#include "h"` would.
    let base = std::env::temp_dir().join(format!("badc-hasinc-{}", std::process::id()));
    std::fs::create_dir_all(&base).unwrap();
    std::fs::write(base.join("inner.h"), "int inner;\n").unwrap();
    std::fs::write(
        base.join("probe.h"),
        "#if __has_include(\"inner.h\")\nint FOUND;\n#else\nint MISSING;\n#endif\n",
    )
    .unwrap();
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_search_path(base.to_str().unwrap());
    let out = pp.process("#include <probe.h>\n").unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert!(out.contains("FOUND"), "{out}");
}

#[test]
fn has_include_next_resumes_after_the_current_entry() {
    // `__has_include_next` must answer what `#include_next` would
    // resolve: found through a later search-path entry, not the
    // probing shim's own file.
    let base = std::env::temp_dir().join(format!("badc-hasincnext-{}", std::process::id()));
    let d1 = base.join("d1");
    let d2 = base.join("d2");
    std::fs::create_dir_all(&d1).unwrap();
    std::fs::create_dir_all(&d2).unwrap();
    std::fs::write(
        d1.join("foo.h"),
        "#if __has_include_next(<foo.h>)\nint NEXT_FOUND;\n#else\nint NEXT_MISSING;\n#endif\n",
    )
    .unwrap();
    std::fs::write(d2.join("foo.h"), "int real;\n").unwrap();

    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_search_path(d1.to_str().unwrap());
    pp.add_search_path(d2.to_str().unwrap());
    let out = pp.process("#include <foo.h>\n").unwrap();
    assert!(out.contains("NEXT_FOUND"), "{out}");

    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_search_path(d1.to_str().unwrap());
    let out = pp.process("#include <foo.h>\n").unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert!(out.contains("NEXT_MISSING"), "{out}");
}

#[test]
fn include_next_resumes_after_the_current_files_search_path() {
    // Two search paths each hold a `foo.h`. The first is a shim that
    // declares a symbol and forwards via `#include_next <foo.h>`; the
    // forward must resolve the second path's copy, not re-read itself.
    let base = std::env::temp_dir().join(format!("badc-incnext-{}", std::process::id()));
    let d1 = base.join("d1");
    let d2 = base.join("d2");
    std::fs::create_dir_all(&d1).unwrap();
    std::fs::create_dir_all(&d2).unwrap();
    std::fs::write(
        d1.join("foo.h"),
        "int from_shim(void);\n#include_next <foo.h>\n",
    )
    .unwrap();
    std::fs::write(d2.join("foo.h"), "int from_system(void);\n").unwrap();

    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_search_path(d1.to_str().unwrap());
    pp.add_search_path(d2.to_str().unwrap());
    let out = pp.process("#include <foo.h>\n").unwrap();
    std::fs::remove_dir_all(&base).ok();

    assert!(
        out.contains("from_shim") && out.contains("from_system"),
        "include_next must reach the next foo.h; got: {out}"
    );
    assert!(
        pp.warnings.is_empty(),
        "unexpected warnings: {:?}",
        pp.warnings
    );
}

#[test]
fn system_fallback_resolves_third_party_but_not_standard_headers() {
    // A system-fallback directory holds `zlib.h` (only there) and a
    // decoy `stdlib.h` that also exists in the embedded set. The
    // embedded standard header must win (it carries the binding
    // metadata); the third-party header resolves from the fallback.
    let base = std::env::temp_dir().join(format!("badc-sysfb-{}", std::process::id()));
    std::fs::create_dir_all(&base).unwrap();
    std::fs::write(base.join("zlib.h"), "int ZLIB_FROM_FALLBACK;\n").unwrap();
    std::fs::write(base.join("stdlib.h"), "int DECOY_STDLIB;\n").unwrap();

    let mut pp = Preprocessor::new("linux-aarch64", Target::LinuxAarch64, "0.1.0");
    pp.add_system_fallback_path(base.to_str().unwrap());
    let z = pp.process("#include <zlib.h>\n").unwrap();

    let mut pp2 = Preprocessor::new("linux-aarch64", Target::LinuxAarch64, "0.1.0");
    pp2.add_system_fallback_path(base.to_str().unwrap());
    let s = pp2.process("#include <stdlib.h>\n").unwrap();
    std::fs::remove_dir_all(&base).ok();

    assert!(
        z.contains("ZLIB_FROM_FALLBACK"),
        "third-party zlib.h should resolve from the system fallback: {z}"
    );
    assert!(
        !s.contains("DECOY_STDLIB"),
        "embedded stdlib.h must win over a system-fallback decoy"
    );
}

#[test]
fn include_next_skips_a_later_path_aliasing_the_current_dir() {
    // The shim directory is on the search path twice under different
    // strings (an explicit entry and an aliased duplicate, as the
    // relative `./include` overlay duplicates an absolute `-I` when badc
    // runs from a directory that has an `include/`). `#include_next` must
    // recognize the alias and not re-resolve the guarded shim through it,
    // which would yield an empty body and drop the next header.
    let base = std::env::temp_dir().join(format!("badc-incnext-alias-{}", std::process::id()));
    let d1 = base.join("d1");
    let d2 = base.join("d2");
    std::fs::create_dir_all(&d1).unwrap();
    std::fs::create_dir_all(&d2).unwrap();
    std::fs::write(
        d1.join("foo.h"),
        "#ifndef FOO_SHIM\n#define FOO_SHIM\nint from_shim(void);\n\
         #include_next <foo.h>\n#endif\n",
    )
    .unwrap();
    std::fs::write(d2.join("foo.h"), "int from_system(void);\n").unwrap();

    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_search_path(d1.to_str().unwrap());
    // Aliased duplicate of d1, ordered before d2: a canonical match must
    // skip it so the forward reaches d2 rather than the guarded shim.
    pp.add_search_path(&format!("{}/.", d1.to_str().unwrap()));
    pp.add_search_path(d2.to_str().unwrap());
    let out = pp.process("#include <foo.h>\n").unwrap();
    std::fs::remove_dir_all(&base).ok();

    assert!(
        out.contains("from_shim") && out.contains("from_system"),
        "include_next must skip the aliased dir and reach the next foo.h; got: {out}"
    );
}

#[test]
fn expansion_result_meets_source_parens() {
    // C99 6.10.3.4: the replacement joins the rest of the source, so
    // a trailing function-like name in a multi-token result takes the
    // following source `(...)` as its arguments (gcc/clang parity).
    let out = process("#define f(a) a*g\n#define g(a) f(a)\nint x = f(2)(9);\n");
    assert!(out.contains("2*9*g"), "{out}");
}

#[test]
fn expanded_arg_tail_meets_arg_parens() {
    // An argument's own pre-expansion is a single scan too: a name
    // produced at the tail of a nested expansion combines with the
    // parens that follow inside the same argument.
    let out = process("#define TAIL x F\n#define F(a) [a]\n#define M(y) y\nint q = M(TAIL (7));\n");
    assert!(out.contains("x [7]"), "{out}");
}

#[test]
fn cross_expansion_invocation_hideset_is_strict() {
    // A doubly-spliced argument juxtaposes one copy's trailing macro
    // name with the next copy's parens. What C99 6.10.3.4 hides for
    // that invocation is unspecified; the strict per-token reading
    // keeps the intersection of the name's and the paren's hidesets,
    // so the mutual partner stays painted (gcc/clang scope disabling
    // to each expansion buffer and re-fire it once more).
    let out = process(
        "#define TWICE(...) __VA_ARGS__ __VA_ARGS__\n#define R(a) a*S\n#define S(a) R(a)\nTWICE(R(()))\n",
    );
    assert!(out.contains("()*R()*S"), "{out}");
}

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

/// C11 6.4.4.4p2-p4: `u'c'` has type `char16_t` (`uint_least16_t`) and
/// `U'c'` has type `char32_t` (`uint_least32_t`). Both are unsigned and
/// keep their width on every target, so neither follows `wchar_t` --
/// which would make `u'c'` 4 bytes on the ELF and Mach-O targets and
/// `U'c'` 2 on Windows.
#[test]
fn prefixed_char_constant_takes_its_own_type() {
    use super::Vm;
    use crate::{Compiler, Target};
    let run = |src: &str, t: Target| -> i64 {
        Vm::new(Compiler::with_target(src.to_string(), t).compile().unwrap())
            .run()
            .unwrap()
    };
    // Width, then signedness: an unsigned type leaves `(T)-1` positive.
    let probe = "int main(void){ return (int)(sizeof(u'A') * 1000 + sizeof(U'A') * 100 \
                 + ((__typeof__(u'A'))-1 > 0) * 10 + ((__typeof__(U'A'))-1 > 0)); }";
    for t in [
        Target::LinuxX64,
        Target::LinuxAarch64,
        Target::MacOSAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert_eq!(
            run(probe, t),
            2411,
            "{t:?}: u'A' is 2-byte, U'A' 4, unsigned"
        );
    }
    // The prefix picks the type, so `L` stays on `wchar_t` and the two
    // do not coincide where `wchar_t` is 2 bytes.
    let wide = "int main(void){ return (int)(sizeof(L'A') * 10 + sizeof(u'A')); }";
    assert_eq!(run(wide, Target::WindowsX64), 22, "Windows wchar_t is 2");
    assert_eq!(run(wide, Target::LinuxX64), 42, "ELF wchar_t is 4");
    // Values are unaffected by the retyping.
    let val = "int main(void){ return u'A' == 65 && U'A' == 65 \
               && u'\\uFFFD' == 65533 && U'\\U0001F600' == 128512 ? 7 : 0; }";
    assert_eq!(run(val, Target::LinuxX64), 7, "code points preserved");
}

/// `-fshort-wchar` gives `wchar_t` an unsigned 16-bit type on every
/// target, as gcc 16.1.1 does: `sizeof(wchar_t)` and the element width
/// of `L"..."` / `L'...'` follow it, and a `wchar_t`-width array is then
/// the 2-byte one (C99 6.7.8p15). The Windows targets are already
/// 2-byte, so the flag is a no-op there and `-fno-short-wchar` does not
/// widen them.
#[test]
fn short_wchar_narrows_wchar_t_on_every_target() {
    use super::Vm;
    use crate::{CompileOptions, Compiler, Target};
    let run = |src: &str, t: Target, short: bool| -> i64 {
        let opts = CompileOptions::default().with_short_wchar(short);
        Vm::new(
            Compiler::with_options(src.to_string(), t, opts)
                .compile()
                .unwrap(),
        )
        .run()
        .unwrap()
    };
    // sizeof(wchar_t) through the bundled <stddef.h> typedef, the wide
    // literal's array size (3 elements including the terminator), and
    // the wide character constant's own width.
    let probe = "#include <stddef.h>\n\
                 int main(void){ return (int)(sizeof(wchar_t) * 100 \
                 + sizeof(L\"ab\") * 10 + sizeof(L'A')); }";
    for t in [
        Target::LinuxX64,
        Target::LinuxAarch64,
        Target::MacOSAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let wide = if t.is_windows() { 262 } else { 524 };
        assert_eq!(run(probe, t, false), wide, "{t:?} default wchar_t");
        assert_eq!(run(probe, t, true), 262, "{t:?} under -fshort-wchar");
    }
    // The staged elements are the code points at the selected width, not
    // a reinterpretation of 4-byte ones.
    let elems = "#include <stddef.h>\n\
                 int main(void){ const wchar_t *s = L\"ab\"; \
                 return s[0] == 'a' && s[1] == 'b' && s[2] == 0 ? 7 : 0; }";
    assert_eq!(run(elems, Target::LinuxX64, true), 7, "narrowed elements");
    // C99 6.7.8p15: the destination element must be wchar_t-wide, so the
    // flag is what lets a wide literal stage into an unsigned short array
    // (the shape the kernel's efi_char16_t arrays take).
    let u16_array = "unsigned short d[] = L\"ab\";\n\
                     int main(void){ return (int)sizeof(d); }";
    assert_eq!(
        run(u16_array, Target::LinuxX64, true),
        6,
        "u16 array staged"
    );
    let opts = CompileOptions::default();
    let err = Compiler::with_options(u16_array.to_string(), Target::LinuxX64, opts)
        .compile()
        .expect_err("a 4-byte wchar_t must refuse a 2-byte destination element");
    assert!(
        format!("{err:?}").contains("wchar_t-width array element"),
        "diagnostic must name the element width; got: {err:?}"
    );
}

/// Plain `char`'s signedness is the target ABI's (C99 6.2.5p15 leaves it
/// to the implementation): unsigned under AAPCS64, signed under the
/// Linux/x86-64 psABI, Apple's arm64 ABI and MSVC. `-fsigned-char` /
/// `-funsigned-char` override it on any target. Every dependent fact
/// moves together -- the `char` type tag, `<limits.h>`'s CHAR_MIN /
/// CHAR_MAX, the `__CHAR_UNSIGNED__` predefine, a `#if` character
/// constant and the promotion of a byte above 0x7F -- which is what
/// gcc 16.1.1 and clang 22.1.8 report on both Linux targets.
#[test]
fn plain_char_signedness_follows_the_target_abi_and_its_flags() {
    use super::Vm;
    use crate::{CompileOptions, Compiler, Target};
    let run = |t: Target, sel: Option<bool>| -> i64 {
        let opts = CompileOptions::default().with_char_signed(sel);
        Vm::new(
            Compiler::with_options(PROBE.to_string(), t, opts)
                .compile()
                .unwrap(),
        )
        .run()
        .unwrap()
    };
    const PROBE: &str = "#include <limits.h>\n\
         #ifdef __CHAR_UNSIGNED__\n#define PREDEF 1\n#else\n#define PREDEF 0\n#endif\n\
         #if '\\xFF' < 0\n#define IF_NEG 1\n#else\n#define IF_NEG 0\n#endif\n\
         int main(void){ return (int)(((char)-1 < 0) * 100000 \
         + (CHAR_MIN < 0) * 10000 + (CHAR_MAX == 127) * 1000 \
         + PREDEF * 100 + IF_NEG * 10 + ((int)(char)0x80 < 0)); }";
    // Signed leaves `__CHAR_UNSIGNED__` undefined and takes 0x80 to -128;
    // unsigned sets only the predefine and keeps 0x80 positive.
    const SIGNED: i64 = 111_011;
    const UNSIGNED: i64 = 100;
    for (t, dflt) in [
        (Target::LinuxX64, SIGNED),
        (Target::LinuxAarch64, UNSIGNED),
        (Target::MacOSAarch64, SIGNED),
        (Target::WindowsX64, SIGNED),
        (Target::WindowsAarch64, SIGNED),
    ] {
        assert_eq!(run(t, None), dflt, "{t:?} ABI default");
        assert_eq!(run(t, Some(true)), SIGNED, "{t:?} under -fsigned-char");
        assert_eq!(run(t, Some(false)), UNSIGNED, "{t:?} under -funsigned-char");
    }
}

/// `wchar_t`'s signedness comes from the target ABI, not from its width:
/// AAPCS64 makes the 4-byte type unsigned while the Linux/x86-64 psABI
/// and Apple's arm64 ABI make the same width signed, which is what
/// gcc 16.1.1 and clang 22.1.8 report on each. The `<stddef.h>` typedef,
/// the `__WCHAR_MAX__` / `__WCHAR_MIN__` bounds and the type C11
/// 6.4.4.4p2 gives `L'...'` all follow the one definition.
#[test]
fn wchar_t_signedness_follows_the_target_abi() {
    use super::Vm;
    use crate::{CompileOptions, Compiler, Target};
    let run = |src: &str, t: Target| -> i64 {
        Vm::new(
            Compiler::with_options(src.to_string(), t, CompileOptions::default())
                .compile()
                .unwrap(),
        )
        .run()
        .unwrap()
    };
    // Width, whether the typedef is unsigned, and whether both bounds
    // agree with it: an unsigned type has `(wchar_t)-1` as its maximum
    // and zero as its minimum.
    let probe = "#include <stddef.h>\n\
                 int main(void){ return (int)(sizeof(wchar_t) * 1000 \
                 + ((wchar_t)-1 > 0) * 100 \
                 + (__WCHAR_MAX__ == (wchar_t)-1) * 10 \
                 + (__WCHAR_MIN__ == 0)); }";
    for (t, want) in [
        (Target::LinuxX64, 4000),
        (Target::LinuxAarch64, 4111),
        (Target::MacOSAarch64, 4000),
        (Target::WindowsX64, 2111),
        (Target::WindowsAarch64, 2111),
    ] {
        assert_eq!(run(probe, t), want, "{t:?} wchar_t definition");
    }
    // C11 6.4.4.4p2 types `L'...'` as `wchar_t`, so the comparison is
    // unsigned exactly where the type is and the 2-byte type promotes to
    // `int` first (C99 6.3.1.1p2), making the comparison signed there.
    let promo = "int main(void){ return L'a' > -1 ? 1 : 0; }";
    for (t, want) in [
        (Target::LinuxX64, 1),
        (Target::LinuxAarch64, 0),
        (Target::MacOSAarch64, 1),
        (Target::WindowsX64, 1),
        (Target::WindowsAarch64, 1),
    ] {
        assert_eq!(run(promo, t), want, "{t:?} L'a' > -1");
    }
    // The `#if` evaluator takes its signedness from the same definition,
    // but C99 6.10.1p4 gives every unsigned operand `uintmax_t` with no
    // integer promotion first, so an unsigned `wchar_t` compares unsigned
    // at every width -- including the 2-byte one whose expression form
    // promotes to `int` above. gcc 16.1.1 and clang 22.1.8 both report
    // this split on x86_64 and on AArch64.
    let cond = "#if L'a' > -1\nint main(void){ return 1; }\n\
                #else\nint main(void){ return 0; }\n#endif\n";
    for (t, want) in [
        (Target::LinuxX64, 1),
        (Target::LinuxAarch64, 0),
        (Target::MacOSAarch64, 1),
        (Target::WindowsX64, 0),
        (Target::WindowsAarch64, 0),
    ] {
        assert_eq!(run(cond, t), want, "{t:?} #if L'a' > -1");
    }
}

#[test]
fn warn_int_to_pointer_assignment() {
    // `int *p; p = 5;` -- assigning a non-zero integer to a pointer.
    let p = compile_fixture("type_warning_int_to_ptr.c");
    assert!(
        p.warnings
            .iter()
            .any(|w| w.to_string().contains("integer assigned to pointer")),
        "expected int-to-ptr warning, got: {:?}",
        p.warnings
    );
}

/// A row whose level resolves to `ignore` is dropped at the sink, so
/// nothing reaches `Program.warnings` and no caller has to filter.
#[test]
fn an_ignored_row_leaves_no_diagnostic_behind() {
    use crate::{CompileOptions, Compiler, Target};
    let src = super::with_prelude(&super::load_fixture("type_warning_int_to_ptr.c"));
    let mut config = crate::diag::Config::new();
    config.set_level(
        crate::diag::Code::INT_CONVERSION,
        crate::diag::Level::Ignore,
    );
    let p = Compiler::with_options(
        src,
        Target::default_target(),
        CompileOptions::default().with_diag(config),
    )
    .compile()
    .unwrap();
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);
}

/// `-Werror` raises the level but does not unwind: the unit still
/// parses whole, so every diagnostic past the first one is reported and
/// the caller decides at the phase boundary.
#[test]
fn warnings_as_errors_do_not_stop_the_parse() {
    use crate::{CompileOptions, Compiler, Target};
    let mut config = crate::diag::Config::new();
    config.warnings_as_errors(true);
    let src = "int *p; int *q;\n\
               int main(void) { p = 1; q = 2; return 0; }\n";
    let p = Compiler::with_options(
        src.to_string(),
        Target::default_target(),
        CompileOptions::default().with_diag(config),
    )
    .compile()
    .expect("the unit parses whole under -Werror");
    let raised: alloc::vec::Vec<&crate::diag::Diagnostic> = p
        .warnings
        .iter()
        .filter(|d| d.level == crate::diag::Level::Error)
        .collect();
    assert_eq!(raised.len(), 2, "got: {:?}", p.warnings);
    // Both assignments are reported, so the second one was reached.
    assert!(
        raised[0].to_string().contains("error:") && raised[1].loc.as_ref().unwrap().line == 2,
        "got: {raised:?}"
    );
}

/// A diagnostic pragma governs the parser's diagnostics as well as the
/// preprocessor's: the events the preprocessor records are keyed on
/// byte offsets into the text the lexer then reads.
#[test]
fn a_pragma_silences_a_parser_diagnostic() {
    let src = "#pragma GCC diagnostic ignored \"-Wunused-variable\"\n\
               int main(void) { int n = 5; return 0; }\n";
    let p = super::compile_str_bare_with_diags(src, &["all"]);
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);
}

/// The pragma raises as well as it silences. The unit still parses
/// whole; the caller fails it at the phase boundary.
#[test]
fn a_pragma_raises_a_parser_diagnostic_to_an_error() {
    let src = "#pragma GCC diagnostic error \"-Wunused-variable\"\n\
               int main(void) { int n = 5; return 0; }\n";
    let p = super::compile_str_bare_with_diags(src, &["all"]);
    let levels: alloc::vec::Vec<crate::diag::Level> = p.warnings.iter().map(|d| d.level).collect();
    assert_eq!(levels, [crate::diag::Level::Error], "got: {:?}", p.warnings);
}

/// `push` / `pop` scope the level over a region: the declarations
/// outside the pair report, the one inside does not.
#[test]
fn push_and_pop_scope_a_parser_diagnostic() {
    let src = "int a(void) { int x = 1; return 0; }\n\
               #pragma GCC diagnostic push\n\
               #pragma GCC diagnostic ignored \"-Wunused-variable\"\n\
               int b(void) { int y = 1; return 0; }\n\
               #pragma GCC diagnostic pop\n\
               int main(void) { int z = 1; return 0; }\n";
    let p = super::compile_str_bare_with_diags(src, &["all"]);
    let lines: alloc::vec::Vec<u32> = p
        .warnings
        .iter()
        .filter_map(|d| d.loc.as_ref().map(|l| l.line))
        .collect();
    assert_eq!(lines, [1, 6], "got: {:?}", p.warnings);
}

/// Precedence at a position: the pragma decides where one covers it,
/// the command line where none does. `-Werror` raises the first
/// declaration; the pragma leaves the second a warning.
#[test]
fn a_pragma_overrides_werror_where_it_covers_the_position() {
    use crate::{CompileOptions, Compiler, Target};
    let mut config = super::diag_config(&["all"]);
    config.warnings_as_errors(true);
    let src = "int a(void) { int x = 1; return 0; }\n\
               #pragma GCC diagnostic warning \"-Wunused-variable\"\n\
               int b(void) { int y = 1; return 0; }\n\
               int main(void) { return a() + b(); }\n";
    let p = Compiler::with_options(
        src.to_string(),
        Target::default_target(),
        CompileOptions::default().with_diag(config),
    )
    .compile()
    .expect("the unit parses whole under -Werror");
    let levels: alloc::vec::Vec<crate::diag::Level> = p.warnings.iter().map(|d| d.level).collect();
    assert_eq!(
        levels,
        [crate::diag::Level::Error, crate::diag::Level::Warning],
        "got: {:?}",
        p.warnings
    );
}

/// The MSVC spelling reaches the same rows through the catalogue's
/// number aliases: 4101 is `unused-variable`, 4505 `unused-function`.
#[test]
fn the_msvc_pragma_reaches_a_parser_diagnostic() {
    let src = "#pragma warning(disable : 4101 4505)\n\
               static int helper(void) { return 1; }\n\
               int main(void) { int n = 5; return 0; }\n";
    let p = super::compile_str_bare_with_diags(src, &["all"]);
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);
}

#[test]
fn warn_return_type_mismatch() {
    // `return <expr>;` whose type doesn't match the function return
    // type warns like an assignment (C99 6.8.6.4p3).
    let p = compile_fixture("type_warning_return.c");
    let has = |needle: &str| p.warnings.iter().any(|w| w.to_string().contains(needle));
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
        p.warnings.iter().any(|w| w.to_string().contains("mystery")
            && w.to_string().contains("without a return-type prototype")),
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
        !p.warnings.iter().any(|w| w.to_string().contains("mystery")),
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
        !p.warnings.iter().any(|w| w.to_string().contains("exit")),
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
        p.warnings
            .iter()
            .any(|w| w.to_string().contains("too few arguments")),
        "expected too-few warning, got: {:?}",
        p.warnings
    );
    assert!(
        p.warnings
            .iter()
            .any(|w| w.to_string().contains("too many arguments")),
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
                .any(|w| w.to_string().contains("too many arguments")
                    && w.to_string().contains(name)),
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
        !p.warnings
            .iter()
            .any(|w| w.to_string().contains("arguments")),
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
                .any(|w| w.to_string().contains("too many arguments")
                    && w.to_string().contains("inner")),
            "expected an arity warning past the redeclaration, got: {:?}",
            p.warnings
        );
    }
}

/// C99 6.7.5.2p4, p6: `T (*p)[]` points to an array of unspecified bound,
/// compatible with a pointer to an array of `T` of any bound, and `*p`
/// still designates that array.
#[test]
fn pointer_to_array_of_unspecified_bound_keeps_the_bound_open() {
    let src = "int a[3] = {1, 2, 3};\n\
               int (*gp)[] = &a;\n\
               static int third(int (*p)[]) { return (*p)[2]; }\n\
               int main(void) {\n\
                   int b[2][4] = {{1, 2, 3, 4}, {5, 6, 7, 8}};\n\
                   int (*p)[] = &a;\n\
                   int (*q)[4] = b;\n\
                   if ((*p)[1] != 2 || (*gp)[2] != 3 || third(&a) != 3) return 1;\n\
                   if (q[1][3] != 8) return 2;\n\
                   if (!__builtin_types_compatible_p(__typeof__(p), int (*)[5])) return 3;\n\
                   if (__builtin_types_compatible_p(__typeof__(q), int (*)[5])) return 4;\n\
                   return 0;\n\
               }\n";
    assert_eq!(super::run_str(src), 0);
}

/// C99 6.2.4 + 6.2.2: block-scope locals, function parameters,
/// and `static` file-scope functions that are never referenced
/// are dead. The compiler emits a `<file>:<line>: warning:
/// unused ...` line for each, in the same shape as the
/// type-mismatch warnings above. Names whose first character is
/// `_` are suppressed by convention.
#[test]
fn warn_unused_variable_parameter_function() {
    // The unused-* rows sit under -Wall / -Wextra, as they do in gcc.
    let p = super::compile_fixture_with_diags("warn_unused_symbols.c", &["all", "extra"]);
    let names_warned: alloc::vec::Vec<&str> = p
        .warnings
        .iter()
        .filter_map(|w| {
            let backtick = w.text.find('`')?;
            let end = w.text[backtick + 1..].find('`')?;
            Some(&w.text[backtick + 1..backtick + 1 + end])
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
    let set_but_unused: alloc::vec::Vec<&str> = p
        .warnings
        .iter()
        .filter(|w| w.text.contains("set but never used"))
        .map(|w| w.text.as_str())
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
    let opts = CompileOptions::default().with_diag(super::diag_config(&["dead-store"]));
    let p = Compiler::with_options(src, Target::host(), opts)
        .compile()
        .unwrap();
    let dead: alloc::vec::Vec<&str> = p
        .warnings
        .iter()
        .filter(|w| w.text.contains("dead store:"))
        .map(|w| w.text.as_str())
        .collect();
    // `int a = 1; a = 2; return 1;` -> both stores dead.
    let a_warns: alloc::vec::Vec<&&str> = dead.iter().filter(|w| w.contains("`a`")).collect();
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
    let dead: alloc::vec::Vec<&str> = p
        .warnings
        .iter()
        .filter(|w| w.text.contains("dead store:"))
        .map(|w| w.text.as_str())
        .collect();
    assert!(
        dead.is_empty(),
        "dead-store warnings should not fire without -Wdead-store: {:?}",
        dead
    );
}

/// The bookkeeping behind the row is gated on the row reporting, so
/// the gate reads the pragmas as well as the command line: a pragma
/// turns the analysis on where no option did.
#[test]
fn a_pragma_enables_the_dead_store_analysis() {
    let src = "#pragma GCC diagnostic warning \"-Wdead-store\"\n\
               int main(void) { int n = 1; n = 2; return n; }\n";
    let p = super::compile_str_bare_with_diags(src, &[]);
    let dead: alloc::vec::Vec<&str> = p
        .warnings
        .iter()
        .filter(|w| w.text.contains("dead store:"))
        .map(|w| w.text.as_str())
        .collect();
    assert_eq!(dead.len(), 1, "got: {:?}", p.warnings);
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
    let msg = err.to_string();
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
            .any(|w| w.to_string().contains("`return` with a value")),
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
        !p.warnings.iter().any(|w| w.to_string().contains("error:")),
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
fn transparent_union_parameter_accepts_member_typed_arguments() {
    // GCC `transparent_union` (verified against gcc 16): a union
    // parameter honoring the attribute takes an argument compatible
    // with any member -- a null pointer constant and the union itself
    // included -- with no diagnostic.
    let p = compile_str(
        "struct page;\nstruct folio;\n\
         typedef union { struct page **pages; struct folio **folios; } \
         arg_t __attribute__((__transparent_union__));\n\
         void release(arg_t a, int nr);\n\
         void f(struct page **p, struct folio **q, void *v) { release(p, 1); \
         release(q, 1); release(0, 1); release(v, 1); arg_t a; a.pages = p; release(a, 1); }\n\
         int main(void) { return 0; }",
    );
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);
}

#[test]
fn transparent_union_attribute_binds_in_every_position() {
    // The spellings gcc accepts: trailing the typedef declarator,
    // between the keyword and the body, trailing a tagged body, and
    // before the tag of a definition.
    let p = compile_str(
        "struct page;\n\
         typedef union { struct page **p; } A __attribute__((transparent_union));\n\
         typedef union __attribute__((transparent_union)) { struct page **p; } B;\n\
         union C { struct page **p; } __attribute__((transparent_union));\n\
         union __attribute__((__transparent_union__)) D { struct page **p; };\n\
         void fa(A a);\nvoid fb(B b);\nvoid fc(union C c);\nvoid fd(union D d);\n\
         void use_(struct page **p) { fa(p); fb(p); fc(p); fd(p); }\n\
         int main(void) { return 0; }",
    );
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);
}

#[test]
fn transparent_union_parameter_still_warns_on_incompatible_arguments() {
    // Acceptance covers member-compatible arguments only, and only
    // through a union type honoring the attribute.
    let p = compile_str(
        "struct page;\n\
         typedef union { struct page **pages; } t_arg \
         __attribute__((transparent_union));\n\
         typedef union { struct page **pages; } plain_arg;\n\
         struct other { int x; };\n\
         void t(t_arg a);\nvoid pl(plain_arg a);\n\
         void f(int i, struct other o, struct page **p) { t(i); t(o); pl(p); }\n\
         int main(void) { return 0; }",
    );
    let has = |needle: &str| p.warnings.iter().any(|w| w.to_string().contains(needle));
    assert!(
        has("incompatible struct types in argument 1 of `t`")
            && has("incompatible struct types in argument 1 of `pl`")
            && p.warnings.len() == 3,
        "got: {:?}",
        p.warnings
    );
}

#[test]
fn transparent_union_attribute_is_ignored_without_a_covering_first_member() {
    // gcc 16 honors the attribute only when the union's machine mode is
    // the first member's ({int, long long} and a floating-first union get
    // "attribute ignored"); an ignored union then warns like any other.
    // `long long` is 64 bits on every target, so the three unions keep the
    // same mode relation whatever the host's `long` width is.
    let p = compile_str(
        "typedef union { int i; long long l; } m_arg __attribute__((transparent_union));\n\
         typedef union { double d; long long l; } f_arg __attribute__((transparent_union));\n\
         typedef union { long long l; double d; } ok_arg __attribute__((transparent_union));\n\
         void t(m_arg a);\nvoid u(ok_arg a);\n\
         void f(long long l) { t(l); u(l); }\n\
         int main(void) { return 0; }",
    );
    let ignored = p
        .warnings
        .iter()
        .filter(|w| {
            w.to_string()
                .contains("`transparent_union` attribute ignored")
        })
        .count();
    assert!(
        ignored == 2
            && p.warnings
                .iter()
                .any(|w| w.to_string().contains("in argument 1 of `t`"))
            && !p
                .warnings
                .iter()
                .any(|w| w.to_string().contains("in argument 1 of `u`")),
        "got: {:?}",
        p.warnings
    );
}

#[test]
fn transparent_union_honor_rule_follows_the_target_long_width() {
    use crate::Target;
    // The mode comparison reads the target's widths, so a union holding a
    // `long` changes verdict with the data model: {int, long} is 4/8 on
    // LP64 (ignored) and 4/4 on LLP64 (honored), while {long, double} is
    // 8/8 on LP64 (honored) and 4/8 on LLP64 (ignored). Either way two of
    // the three are ignored; which call keeps its argument warning is what
    // moves.
    let src = "typedef union { int i; long l; } m_arg __attribute__((transparent_union));\n\
               typedef union { double d; long l; } f_arg __attribute__((transparent_union));\n\
               typedef union { long l; double d; } ok_arg __attribute__((transparent_union));\n\
               void t(m_arg a);\nvoid u(ok_arg a);\n\
               void f(long l) { t(l); u(l); }\n\
               int main(void) { return 0; }";
    for (target, warns, honored) in [
        (
            Target::LinuxX64,
            "in argument 1 of `t`",
            "in argument 1 of `u`",
        ),
        (
            Target::WindowsX64,
            "in argument 1 of `u`",
            "in argument 1 of `t`",
        ),
    ] {
        let p = super::compile_str_bare_for(src, target);
        let ignored = p
            .warnings
            .iter()
            .filter(|w| {
                w.to_string()
                    .contains("`transparent_union` attribute ignored")
            })
            .count();
        assert!(
            ignored == 2
                && p.warnings.iter().any(|w| w.to_string().contains(warns))
                && !p.warnings.iter().any(|w| w.to_string().contains(honored)),
            "{target:?}: got: {:?}",
            p.warnings
        );
    }
}

#[test]
fn transparent_union_acceptance_is_argument_only() {
    // gcc rejects member-typed initializers, assignments and returns of
    // a transparent union; the acceptance must not reach past call
    // arguments, so the object mismatch stays rejected.
    let msg = constraint_error(
        "struct page;\n\
         typedef union { struct page **p; } T __attribute__((transparent_union));\n\
         T g(struct page **p) { T t = p; t = p; return t; }\n\
         int main(void) { return 0; }",
    );
    assert!(
        msg.contains("cannot assign non-struct value to a struct"),
        "got: {msg}"
    );
}

#[test]
fn bool_target_accepts_a_pointer_in_every_assignment_context() {
    // C99 6.5.16.1p1 lists "the left operand has type _Bool and the right
    // is a pointer" among the simple-assignment cases, and 6.3.1.2 makes
    // the conversion yield 0 or 1. The rule reaches every context the
    // as-if-by-assignment wording covers.
    let p = compile_str(
        "struct R { struct R *parent; };\n\
         _Bool assigned(struct R *r) { return r->parent; }\n\
         _Bool ints(unsigned int *p) { return p; }\n\
         void take(_Bool b);\n\
         void ctx(struct R *r) { _Bool a; a = r; _Bool i = r; take(r); (void)a; (void)i; }\n\
         int main(void) { return 0; }",
    );
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);

    // The reverse direction is still a mismatch: only `_Bool` on the left
    // is exempt, and `_Bool *` is a pointer, not the exempt scalar.
    let p = compile_str(
        "void f(_Bool b, _Bool *bp) { int *q; q = b; struct S { int a; } *s; s = bp; (void)q; \
         (void)s; }\n\
         int main(void) { return 0; }",
    );
    assert!(
        p.warnings.iter().any(|w| w
            .to_string()
            .contains("integer assigned to pointer in assignment"))
            && p.warnings.iter().any(|w| w
                .to_string()
                .contains("incompatible struct types in assignment")),
        "got: {:?}",
        p.warnings
    );
}

#[test]
fn pointer_converted_to_bool_yields_zero_or_one() {
    use super::Vm;
    use crate::Compiler;
    // The exemption above must not hide a conversion that keeps the
    // pointer's bits: 6.3.1.2 compares against 0.
    let src = "struct R { struct R *parent; };\n\
               static _Bool assigned(struct R *r) { return r->parent; }\n\
               static int take(_Bool b) { return (int)b; }\n\
               int main(void) { struct R a, b; a.parent = &b; b.parent = 0;\n\
               int acc = assigned(&a); acc = acc * 10 + assigned(&b);\n\
               acc = acc * 10 + take(&a); return acc * 10 + take(0); }";
    let got = Vm::new(Compiler::new(src.to_string()).compile().unwrap())
        .run()
        .unwrap();
    assert_eq!(got, 1010);
}

#[test]
fn a_named_address_space_on_the_object_does_not_change_compatibility() {
    use crate::{Compiler, Target};
    // C99 6.3.2.1p2 gives an lvalue's value the unqualified type, so a
    // named address space qualifying the object itself takes no part in
    // assignment compatibility -- the same rule `volatile` already gets.
    // Both spellings the x86 per-cpu accessors produce are covered: a
    // qualified pointer object, and a dereference of a pointer to one.
    let src = "struct mm_struct;\n\
               extern struct mm_struct *__seg_gs cur_mm;\n\
               extern struct mm_struct *pcpu_mm;\n\
               struct mm_struct *direct(void) { return cur_mm; }\n\
               struct mm_struct *through_cast(void) {\n\
                 return *(struct mm_struct *__seg_gs *)(__UINTPTR_TYPE__)&pcpu_mm; }\n\
               void assign(void) { struct mm_struct *m; m = cur_mm; (void)m; }\n\
               int main(void) { return 0; }";
    let p = Compiler::with_target(src.to_string(), Target::LinuxX64)
        .compile()
        .expect("a qualified object is compatible with its unqualified type");
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);
}

#[test]
fn a_named_address_space_on_the_pointee_is_named_in_the_diagnostic() {
    use crate::{Compiler, Target};
    // The qualifier below the outermost derivation is a real difference,
    // and no diagnostic may print two type texts that read alike.
    let src = "struct task_struct;\n\
               extern __seg_gs struct task_struct *cur;\n\
               struct task_struct *f(void) { return cur; }\n\
               int main(void) { return 0; }";
    let p = Compiler::with_target(src.to_string(), Target::LinuxX64)
        .compile()
        .unwrap();
    assert!(
        p.warnings.iter().any(|w| {
            w.to_string()
                .contains("incompatible struct types in return")
                && w.to_string().contains("declared=struct task_struct*")
                && w.to_string()
                    .contains("returned=struct task_struct __seg_gs *")
        }),
        "got: {:?}",
        p.warnings
    );
}

/// `long double`'s layout follows the target ABI: System V x86-64
/// gives it the x87 80-bit format in a 16-byte object at 16-byte
/// alignment and AAPCS64 ELF gives it IEEE binary128, also 16/16;
/// macOS/arm64 and both Windows targets define it as binary64.
#[test]
fn long_double_layout_follows_the_target_abi() {
    use super::Vm;
    use crate::Compiler;
    use crate::Target;
    let run = |src: &str, t: Target| -> i64 {
        Vm::new(Compiler::with_target(src.to_string(), t).compile().unwrap())
            .run()
            .unwrap()
    };
    // sizeof, _Alignof, the offset a preceding `char` pads to, the
    // whole-struct size, an array's stride, and the pointer stride.
    let probe = "struct S { char c; long double l; };\n\
                 int main(void){ long double a[3]; long double *p = &a[0];\n\
                 return sizeof(long double) + 100 * _Alignof(long double)\n\
                 + 10000 * __builtin_offsetof(struct S, l)\n\
                 + 1000000 * (sizeof(a) / 3) + 100000000 * (int)(&a[1] - &a[0])\n\
                 + 1000000000 * (int)(sizeof(struct S) / 16); }";
    for (t, width) in [
        (Target::LinuxX64, 16),
        (Target::LinuxAarch64, 16),
        (Target::MacOSAarch64, 8),
        (Target::WindowsX64, 8),
        (Target::WindowsAarch64, 8),
    ] {
        let want = width
            + 100 * width
            + 10000 * width
            + 1000000 * width
            + 100000000
            + 1000000000 * (if width == 16 { 2 } else { 1 });
        assert_eq!(run(probe, t), want, "{t:?}: long double layout");
    }
    // `long double *` is a pointer: 8 bytes on every target.
    let ptr = "int main(void){ return sizeof(long double *); }";
    for t in [Target::LinuxX64, Target::MacOSAarch64] {
        assert_eq!(run(ptr, t), 8, "{t:?}: pointer width");
    }
}

/// A `vector_size` type is aligned to its width up to the target's
/// ceiling: the x86-64 psABI gives a 32-byte vector 32, AAPCS64 keeps a
/// wider vector on the 16-byte boundary. The member offset, the struct
/// size and alignment, the array stride and the padded width of a
/// non-power-of-two vector follow, as gcc and clang lay them out.
#[test]
fn vector_type_alignment_follows_the_target_abi() {
    use super::Vm;
    use crate::Compiler;
    use crate::Target;
    let run = |src: &str, t: Target| -> i64 {
        Vm::new(Compiler::with_target(src.to_string(), t).compile().unwrap())
            .run()
            .unwrap()
    };
    let decls = "typedef int v4si __attribute__((vector_size(16)));\n\
                 typedef int v8si __attribute__((vector_size(32)));\n\
                 typedef int v3si __attribute__((vector_size(12)));\n\
                 struct S16 { char c; v4si v; };\n\
                 struct S32 { char c; v8si v; };\n\
                 struct N { char c; struct S32 s; };\n";
    // (expression, x86-64 value, AArch64 value)
    let cases: &[(&str, i64, i64)] = &[
        ("_Alignof(v4si)", 16, 16),
        ("sizeof(struct S16)", 32, 32),
        ("__builtin_offsetof(struct S16, v)", 16, 16),
        ("_Alignof(struct S16)", 16, 16),
        ("_Alignof(v8si)", 32, 16),
        ("sizeof(v8si)", 32, 32),
        ("__builtin_offsetof(struct S32, v)", 32, 16),
        ("sizeof(struct S32)", 64, 48),
        ("_Alignof(struct N)", 32, 16),
        ("__builtin_offsetof(struct N, s)", 32, 16),
        ("sizeof(v8si[3]) / 3", 32, 32),
        ("_Alignof(v3si)", 16, 16),
        ("sizeof(v3si)", 16, 16),
    ];
    for t in [
        Target::LinuxX64,
        Target::WindowsX64,
        Target::LinuxAarch64,
        Target::MacOSAarch64,
        Target::WindowsAarch64,
    ] {
        for &(expr, x64, aarch64) in cases {
            let src = alloc::format!("{decls}int main(void) {{ return (int)({expr}); }}");
            let want = if t.is_x86_64() { x64 } else { aarch64 };
            assert_eq!(run(&src, t), want, "{t:?}: {expr}");
        }
    }
}

/// The wide storage format round-trips through memory: a value stored
/// into a `long double` object and read back is unchanged, and the
/// object's bytes carry the platform's encoding rather than a binary64
/// in the low half (which every foreign reader would misdecode).
#[test]
fn long_double_storage_round_trips_through_its_abi_format() {
    use super::Vm;
    use crate::Compiler;
    use crate::Target;
    let run = |src: &str, t: Target| -> i64 {
        Vm::new(Compiler::with_target(src.to_string(), t).compile().unwrap())
            .run()
            .unwrap()
    };
    let round_trip = "int main(void){ long double x = 2.5L; double d = (double)x;\n\
                      long double y = (long double)(d + 1.0);\n\
                      return (d == 2.5 && (double)y == 3.5) ? 7 : 0; }";
    for t in [Target::LinuxX64, Target::LinuxAarch64, Target::MacOSAarch64] {
        assert_eq!(run(round_trip, t), 7, "{t:?}: round trip");
    }
    // x87 stores 1.0 as an explicit integer bit (0x8000...) with
    // exponent 0x3FFF; a binary64 in the low half would read 0 there.
    let image = "int main(void){ long double x = 1.0L;\n\
                 unsigned char *b = (unsigned char *)&x;\n\
                 return b[7] + b[8] + b[9]; }";
    assert_eq!(
        run(image, Target::LinuxX64),
        0x80 + 0xff + 0x3f,
        "linux-x64 stores the x87 encoding"
    );
    // A file-scope initializer lands in the same format.
    let global = "long double g = 1.0L;\n\
                  int main(void){ unsigned char *b = (unsigned char *)&g;\n\
                  return b[7] + b[8] + b[9]; }";
    assert_eq!(
        run(global, Target::LinuxX64),
        0x80 + 0xff + 0x3f,
        "a static initializer stores the x87 encoding"
    );
    // binary128 keeps the leading bit implicit, so 1.0 is exponent
    // 0x3fff over a zero significand: only the top two bytes are set.
    let image128 = "int main(void){ long double x = 1.0L;\n\
                    unsigned char *b = (unsigned char *)&x; int i, s = 0;\n\
                    for (i = 0; i < 14; i++) s += b[i];\n\
                    return s * 1000 + b[15] + b[14]; }";
    let global128 = "long double g = 1.0L;\n\
                     int main(void){ unsigned char *b = (unsigned char *)&g;\n\
                     int i, s = 0; for (i = 0; i < 14; i++) s += b[i];\n\
                     return s * 1000 + b[15] + b[14]; }";
    for (src, what) in [(image128, "an automatic"), (global128, "a static")] {
        assert_eq!(
            run(src, Target::LinuxAarch64),
            0x3f + 0xff,
            "linux-aarch64: {what} object stores the binary128 encoding"
        );
    }
    // 2^-1074 is subnormal in binary64 and normal in binary128, so the
    // widening normalizes it: exponent 16383 - 1074 = 0x3bcd.
    let sub = "int main(void){ double d = 5e-324; long double x = d;\n\
               unsigned char *b = (unsigned char *)&x; int i, s = 0;\n\
               for (i = 0; i < 14; i++) s += b[i];\n\
               return s * 100000 + b[15] * 256 + b[14]; }";
    assert_eq!(
        run(sub, Target::LinuxAarch64),
        0x3b * 256 + 0xcd,
        "linux-aarch64: a binary64 subnormal widens to a normal binary128"
    );
}

/// A `long double` parameter reads back what its caller passed on every
/// target, through a register, the stack or `va_arg`.
#[test]
fn long_double_parameters_read_back_what_the_caller_passed() {
    use super::Vm;
    use crate::{Compiler, Target};
    let src = super::load_fixture("long_double_parameter_shapes.c");
    for t in [Target::LinuxX64, Target::LinuxAarch64, Target::MacOSAarch64] {
        let program = Compiler::with_target(src.clone(), t).compile().unwrap();
        assert_eq!(Vm::new(program).run().unwrap(), 0, "{t:?}");
    }
}

/// An `L` constant, an arithmetic operation and a conditional with a
/// `long double` operand have type `long double` (C99 6.4.4.2p4,
/// 6.3.1.8p1, 6.5.15p5) on every target, as `_Generic` and `sizeof` see.
#[test]
fn long_double_operands_give_long_double_results() {
    use super::Vm;
    use crate::{Compiler, Target};
    let src = super::load_fixture("long_double_usual_conversions.c");
    for t in [
        Target::LinuxX64,
        Target::LinuxAarch64,
        Target::MacOSAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let program = Compiler::with_target(src.clone(), t).compile().unwrap();
        assert_eq!(Vm::new(program).run().unwrap(), 0, "{t:?}");
    }
}

/// A `long double` argument, result, variadic argument and aggregate member
/// crosses a call unchanged on every target, System V's x87 image in memory
/// and `st(0)` included.
#[test]
fn long_double_call_shapes_keep_their_values() {
    use super::Vm;
    use crate::{Compiler, Target};
    let src = super::load_fixture("long_double_call_shapes.c");
    for t in [Target::LinuxX64, Target::LinuxAarch64, Target::MacOSAarch64] {
        let program = Compiler::with_target(src.clone(), t).compile().unwrap();
        assert_eq!(Vm::new(program).run().unwrap(), 0, "{t:?}");
    }
}

/// `long double` keeps `double`'s 53-bit significand through the compute
/// path, so a value needing more than 53 bits does not round-trip even
/// where the stored object could hold it (x87 80-bit has 64 significand
/// bits, binary128 has 113). doc/std-conformance.md records the limit.
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

/// A failed unit's error carries the diagnostics reported before the
/// one that ended it, so a warning ahead of a syntax error is not lost
/// with the sink.
#[test]
fn a_warning_reported_before_a_hard_error_rides_with_it() {
    use crate::c5::diag::{Code, Level};
    let src = "#pragma frobnicate\nint main(void) { int x = ; return 0; }\n";
    let err = crate::c5::Compiler::new(src.to_string())
        .compile()
        .expect_err("`int x = ;` is a syntax error");
    let reported: Vec<(Code, Level)> = err
        .diagnostics()
        .iter()
        .map(|d| (d.code, d.level))
        .collect();
    let unknown_pragma = Code::from_selector("unknown-pragmas").expect("catalogued");
    assert_eq!(
        reported,
        [
            (unknown_pragma, Level::Warning),
            (Code::SYNTAX, Level::Error)
        ],
        "{err}"
    );
    let text = err.to_string();
    let warning = text
        .find("[-Wunknown-pragmas]")
        .expect("the warning prints");
    let error = text.find("[B2020] [syntax]").expect("the error prints");
    assert!(warning < error, "in the order reported: {text}");
}

/// A `return` that does not fit the function's return type is rejected
/// by C23 6.8.6.4 and every current toolchain; the row is an error the
/// user can lower, as gcc 14's `-Wreturn-mismatch` is. Lowered, a value
/// returned from a `void` function is evaluated and discarded, and a
/// bare `return` leaves the value indeterminate, as C99 6.9.1p12 does
/// for a closing brace.
#[test]
fn a_return_mismatch_is_an_error_the_user_can_lower() {
    use super::Vm;
    use crate::c5::diag::{Code, Config, Level};
    use crate::{CompileOptions, Compiler, Target};
    let with_level = |src: &str, level: Level| {
        let mut config = Config::new();
        config.set_level(Code::RETURN_MISMATCH, level);
        Compiler::with_options(
            src.to_string(),
            Target::default_target(),
            CompileOptions::default().with_diag(config),
        )
        .compile()
    };
    for src in [
        "void f(void) { return 1; }\nint main(void) { f(); return 0; }\n",
        "int g(int a) { if (a) return; return 2; }\nint main(void) { return g(0) - 2; }\n",
    ] {
        let err = Compiler::new(src.to_string())
            .compile()
            .expect_err("an error by default");
        assert!(
            err.to_string().contains("error:")
                && err.to_string().contains("[B3026] [-Wreturn-mismatch]"),
            "{err}"
        );
        let lowered = with_level(src, Level::Warning).expect("lowered to a warning");
        let reported: Vec<(Code, Level)> =
            lowered.warnings.iter().map(|d| (d.code, d.level)).collect();
        assert_eq!(reported, [(Code::RETURN_MISMATCH, Level::Warning)]);
        assert_eq!(Vm::new(lowered).run().unwrap(), 0, "the lowered unit runs");
        let silenced = with_level(src, Level::Ignore).expect("silenced");
        assert!(silenced.warnings.is_empty(), "{:?}", silenced.warnings);
    }
}

/// C99 6.3.2.2p1: a `void` expression has no value. Every context that
/// reads one rejects it with the same diagnostic: an argument with or
/// without a parameter type, an initializer, an assignment, a returned
/// value, an operand, a subscript, a cast to a non-`void` type, a
/// controlling expression and a constant expression.
#[test]
fn a_void_value_is_rejected_where_it_is_read() {
    use crate::Compiler;
    let decls = "void f(void);\nint g(int);\nint h();\nint v(int, ...);\n\
                 int (*fp)(int);\nint arr[2];\nstruct S { int a; int b : 3; };\n";
    for body in [
        "int t(void) { return g((void)0); }",
        "int t(void) { return h(f()); }",
        "int t(void) { return v(1, f()); }",
        "int t(void) { return fp(f()); }",
        "int t(void) { int x = f(); return x; }",
        "int t(void) { struct S s = { f() }; return s.a; }",
        "int t(void) { return (int){ f() }; }",
        "int x = (void)0;",
        "int t(void) { int x; x = f(); return x; }",
        "int t(void) { int x = 1; x += f(); return x; }",
        "int t(void) { struct S s; s.b = f(); return s.b; }",
        "int t(void) { return f(); }",
        "int t(int c) { return c ? f() : f(); }",
        "int t(int c) { return c ? f() : 1; }",
        "int t(void) { return (0, f()); }",
        "int t(void) { return ({ f(); }); }",
        "int t(void) { return f() + 1; }",
        "int t(void) { return 1 + f(); }",
        "int t(int c) { return c && f(); }",
        "int t(void) { return -f(); }",
        "int t(void) { return !f(); }",
        "int t(void) { return (long)f(); }",
        "int t(void) { return arr[f()]; }",
        "int t(void) { if (f()) return 1; return 0; }",
        "int t(void) { while (f()) return 1; return 0; }",
        "int t(void) { do {} while (f()); return 0; }",
        "int t(void) { for (; f();) return 1; return 0; }",
        "int t(void) { switch (f()) { default: return 1; } }",
        "int t(void) { return f() ? 1 : 2; }",
        "int t(void) { int a[f()]; return sizeof a; }",
        "int t(void) { return __builtin_expect(f(), 0); }",
        "enum { A = (void)0 };",
    ] {
        let src = format!("{decls}{body}\n");
        let err = Compiler::new(src.clone()).compile().expect_err(&src);
        let text = err.to_string();
        assert!(
            text.contains("error: `void` expression used as a value [B3027] [void-value]"),
            "{src}{text}"
        );
    }
}

/// A context that discards a `void` expression or passes it on unread
/// accepts one: an expression statement, the `?:` arms (one `void` arm
/// makes the result `void`, as in GNU C), both operands of `,`, a cast to
/// `void`, the first and third clauses of `for`, a `return` in a function
/// returning `void`, the operand of `&`, and the unevaluated operands of
/// `sizeof`, `__alignof__`, `typeof`, `_Generic` and the GNU builtins.
#[test]
fn a_void_expression_whose_value_is_not_read_is_accepted() {
    use super::Vm;
    use crate::Compiler;
    let src = "int n;\n\
               void f(void) { n++; }\n\
               void w(void) { return f(); }\n\
               int main(void) {\n\
               \tint c = 1;\n\
               \tf();\n\
               \tc ? f() : (void)0;\n\
               \tc ? f() : 5;\n\
               \t0 ? 5 : f();\n\
               \tf(), f();\n\
               \tint k = (f(), n);\n\
               \tw();\n\
               \t__typeof__(f()) *p = &*(void *)&n;\n\
               \tfor (f(); n < 20; f())\n\
               \t\t;\n\
               \treturn n * 3 + k + (p != 0);\n\
               }\n";
    let program = Compiler::new(src.to_string()).compile().expect(src);
    assert_eq!(Vm::new(program).run().unwrap(), 20 * 3 + 7 + 1, "{src}");
    for body in [
        "unsigned long t(void) { return sizeof(f()) + __alignof__(f()); }",
        "int t(void) { return _Generic((void)0, default: 1); }",
        "int t(void) { return __builtin_constant_p(f()); }",
        "void t(int x) { __builtin_choose_expr(1, (void)0, x); }",
        "void t(int c) { c && (f(), 1); }",
        "void t(int c) { (void)(c ? f() : 0); }",
    ] {
        let src = format!("void f(void);\n{body}\nint main(void) {{ return 0; }}\n");
        Compiler::new(src.clone()).compile().expect(&src);
    }
}

/// C99 names the operand categories statements and operators take: a scalar
/// controlling expression for `if`, `while`, `do`, `for` and the first
/// operand of `?:`, an integer one for `switch`, scalar operands for a cast
/// to a non-`void` type, an integer subscript, arithmetic operands for unary
/// `+` and `-`, integer ones for `~`, `%`, the shifts and the bitwise
/// operators, and the pointer forms of `+`, `-` and the comparisons.
#[test]
fn an_operand_outside_its_c99_category_is_rejected() {
    use crate::Compiler;
    let decls = "struct S { int a; };\nstruct S s;\ndouble d;\nint *p;\nint arr[2];\n\
                 typedef int v4 __attribute__((vector_size(16)));\nv4 vec;\n";
    let controlling = "[B3028] [controlling-expression]";
    let operands = "[B3020] [invalid-operands]";
    for (body, code, text) in [
        (
            "int t(void) { if (s) return 1; return 0; }",
            controlling,
            "controlling expression of `if` has type `struct S`, not a scalar type",
        ),
        (
            "int t(void) { while (s) return 1; return 0; }",
            controlling,
            "`while`",
        ),
        (
            "int t(void) { do {} while (s); return 0; }",
            controlling,
            "`do`",
        ),
        (
            "int t(void) { for (; s;) return 1; return 0; }",
            controlling,
            "`for`",
        ),
        (
            "int t(void) { if (vec) return 1; return 0; }",
            controlling,
            "not a scalar type",
        ),
        (
            "int t(void) { switch (d) { case 1: return 1; } return 0; }",
            controlling,
            "controlling expression of `switch` has type `double`, not an integer type",
        ),
        (
            "int t(void) { switch (p) { default: return 1; } }",
            controlling,
            "not an integer type",
        ),
        (
            "int t(void) { return s ? 1 : 0; }",
            operands,
            "first operand of `?:` has type `struct S`",
        ),
        (
            "int t(void) { return (int)s; }",
            operands,
            "invalid cast from `struct S` to `int`",
        ),
        (
            "int t(void) { return ((struct S)1).a; }",
            operands,
            "invalid cast from `int` to `struct S`",
        ),
        (
            "int t(void) { return (int *)d != 0; }",
            operands,
            "invalid cast from `double`",
        ),
        (
            "int t(void) { return arr[s]; }",
            operands,
            "array subscript has type `struct S`, not an integer type",
        ),
        (
            "int t(void) { return arr[d]; }",
            operands,
            "array subscript has type `double`",
        ),
        (
            "int t(void) { return -s; }",
            operands,
            "operand of unary `-` has type `struct S`, not an arithmetic type",
        ),
        (
            "long t(void) { return (long)+p; }",
            operands,
            "operand of unary `+`",
        ),
        (
            "int t(void) { return ~d; }",
            operands,
            "operand of unary `~` has type `double`, not an integer type",
        ),
        (
            "int t(void) { return !s; }",
            operands,
            "operand of unary `!`",
        ),
        (
            "int t(void) { return d << 1; }",
            operands,
            "invalid operands to binary `<<` (`double` and `int`)",
        ),
        (
            "long t(void) { return (long)(p * 2); }",
            operands,
            "invalid operands to binary `*`",
        ),
        (
            "long t(void) { return (long)(p + p); }",
            operands,
            "invalid operands to binary `+`",
        ),
        (
            "int t(void) { return p < d; }",
            operands,
            "invalid operands to binary `<`",
        ),
        (
            "int t(void) { return s && 1; }",
            operands,
            "invalid operands to binary `&&`",
        ),
        (
            "int t(void) { int i = 0; i += s; return i; }",
            operands,
            "invalid operands to `+=`",
        ),
        (
            "int t(void) { p *= 2; return 0; }",
            operands,
            "invalid operands to `*=`",
        ),
    ] {
        let src = format!("{decls}{body}\n");
        let err = Compiler::new(src.clone()).compile().expect_err(&src);
        let msg = err.to_string();
        assert!(msg.contains(code) && msg.contains(text), "{src}{msg}");
    }
}

/// The categories admit what C and the GNU extensions allow: pointers,
/// decayed arrays and function designators as conditions and `?:` operands,
/// enumerations, `_Bool`, character constants and `__int128` in `switch`,
/// pointer arithmetic and differences, a statement expression as a
/// condition, a cast to `void`, to the operand's own type or to a union from
/// a member's type, and the GNU vector operators.
#[test]
fn an_operand_inside_its_c99_category_is_accepted() {
    use super::Vm;
    use crate::Compiler;
    let src = "enum E { E0, E1 };\n\
               int f(void) { return 3; }\n\
               int main(void) {\n\
               \tint arr[4] = { 1, 2, 3, 4 }, m[2][3] = { { 0 } };\n\
               \tint *p = arr + 1;\n\
               \tenum E e = E1;\n\
               \t_Bool b = 1;\n\
               \tint n = 0;\n\
               \tif (p && arr && f && m) n += 1;\n\
               \tn += p ? 1 : 0;\n\
               \tswitch (e) { case E1: n += 1; }\n\
               \tswitch (b) { case 1: n += 1; }\n\
               \tswitch ('a') { case 'a': n += 1; }\n\
               \tn += (int)(p - arr) + (int)(&arr[3] - p) % 3;\n\
               \tif (({ int k = n; k; })) n += 1;\n\
               \treturn n;\n\
               }\n";
    let program = Compiler::new(src.to_string()).compile().expect(src);
    assert_eq!(Vm::new(program).run().unwrap(), 9, "{src}");
    for body in [
        "__int128 big; int t(void) { switch (big) { case 1: return 1; } return 0; }",
        "struct S { int a; }; struct S s; int t(void) { (void)s; return ((struct S)s).a; }",
        "union U { int a; double d; }; double t(double d) { return ((union U)d).d; }",
        "typedef int v4 __attribute__((vector_size(16))); v4 t(v4 v) { return -v + +v + ~v; }",
        "void *t(void *vp) { return vp + 1; }",
        "long t(int *x, int *y) { return (y - x) % 2 + ((y - x) >> 1); }",
        "int t(double d, int *p, int (*fp)(void)) { return d ? !p : fp != 0 && p > 0; }",
    ] {
        let src = format!("{body}\nint main(void) {{ return 0; }}\n");
        Compiler::new(src.clone()).compile().expect(&src);
    }
}

#[test]
fn the_address_of_a_function_designator_is_the_function_pointer() {
    // C99 6.5.3.2p3: `&` on an operand of function type yields a pointer
    // to that function -- the same type 6.3.2.1p4 gives the designator
    // itself, which c5's tag encoding already carries. Every
    // as-if-by-assignment context must take it silently.
    let p = compile_str(
        "struct T { int a; };\n\
         typedef struct T *sel_t(int, int);\n\
         struct T *impl(int a, int b) { (void)a; (void)b; return 0; }\n\
         struct C { sel_t *xlate; };\n\
         void take(sel_t *f);\n\
         void member(struct C *c) { c->xlate = &impl; }\n\
         void local(void) { sel_t *p; p = &impl; (void)p; }\n\
         void arg(void) { take(&impl); }\n\
         sel_t *ret(void) { return &impl; }\n\
         void deref(void) { sel_t *p; p = &*impl; (void)p; }\n\
         int main(void) { return 0; }",
    );
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);

    // The address of an OBJECT of function-pointer type still adds a
    // level, and assigning it where the pointer itself belongs is the
    // mismatch gcc and clang report.
    let p = compile_str(
        "struct T { int a; };\n\
         typedef struct T *sel_t(int, int);\n\
         void bad(sel_t *v) { sel_t *p; p = &v; (void)p; }\n\
         int main(void) { return 0; }",
    );
    assert!(
        p.warnings.iter().any(|w| {
            let s = w.to_string();
            s.contains("incompatible struct types in assignment")
                && s.contains("lhs=struct T**")
                && s.contains("rhs=struct T***")
        }),
        "got: {:?}",
        p.warnings
    );
}

#[test]
fn the_address_of_a_function_designator_calls_and_compares_as_the_function() {
    use super::Vm;
    use crate::Compiler;
    // The type rule above must not cost the value: `&f`, `f` and `*&f`
    // are the same pointer, and a call through any of them reaches `f`.
    let src = "struct T { int a; };\n\
               typedef struct T *sel_t(int, int);\n\
               static struct T v = { 7 };\n\
               static struct T *impl(int a, int b) { return a > b ? &v : 0; }\n\
               int main(void) {\n\
                 sel_t *p = &impl;\n\
                 int acc = (p == impl) ? 1 : 0;\n\
                 acc = acc * 10 + (((&impl)(2, 1) == &v) ? 1 : 0);\n\
                 acc = acc * 10 + (((*&impl)(2, 1) == &v) ? 1 : 0);\n\
                 sel_t **q = &p;\n\
                 return acc * 10 + ((*q == impl) ? 1 : 0); }";
    let got = Vm::new(Compiler::new(src.to_string()).compile().unwrap())
        .run()
        .unwrap();
    assert_eq!(got, 1111);
}

#[test]
fn typeof_a_dereferenced_function_pointer_names_the_function_type() {
    // C99 6.5.3.2p4: `*` on a pointer to a function designates the
    // function, so `typeof(*p)` is a function type and a `*` in a
    // declarator through the specifier forms the pointer to it rather
    // than adding a level -- the shape `rcu_dereference` and
    // `rcu_assign_pointer` expand to over a function-pointer field.
    let p = compile_str(
        "struct T { int a; };\n\
         typedef struct T *sel_t(int, int);\n\
         void one(sel_t *v, sel_t **slot) { *slot = (typeof(*(v)) *)(v); }\n\
         void two(sel_t **slot) { sel_t *l = (typeof(**slot) *)(*slot); (void)l; }\n\
         void decl(sel_t *v) { typeof(*v) *q = v; (void)q; }\n\
         int main(void) { return 0; }",
    );
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);

    // `typeof` of the pointer OBJECT keeps its own level, so the cast
    // below really is a pointer to a function pointer and the assignment
    // is the mismatch gcc and clang report.
    let p = compile_str(
        "struct T { int a; };\n\
         typedef struct T *sel_t(int, int);\n\
         void bad(sel_t *v, sel_t **slot) { *slot = (typeof(v) *)(v); }\n\
         int main(void) { return 0; }",
    );
    assert!(
        p.warnings.iter().any(|w| {
            let s = w.to_string();
            s.contains("incompatible struct types in assignment")
                && s.contains("lhs=struct T**")
                && s.contains("rhs=struct T***")
        }),
        "got: {:?}",
        p.warnings
    );
}

#[test]
fn a_pointer_initializer_folded_from_a_cast_is_not_read_as_an_integer() {
    // C99 6.3.2.3p5 leaves the integer-to-pointer conversion
    // implementation-defined and 6.6p10 lets an implementation accept
    // other forms of constant expression; gcc and clang take a cast
    // integer as a static pointer initializer. The check must see the
    // initializer's own type, not one synthesized from the folded value.
    let p = compile_str(
        "struct epitems_head { int x; };\n\
         static struct epitems_head *unactive = (void *) -1L;\n\
         static struct epitems_head *typed = (struct epitems_head *) -1L;\n\
         static char *bytes = (char *) -1L;\n\
         static void *nul = 0;\n\
         static struct epitems_head *nul2 = 0;\n\
         int main(void) { return unactive && typed && bytes && !nul && !nul2 ? 0 : 1; }",
    );
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);

    // A bare non-zero integer is still the 6.5.16.1p1 mismatch, in both
    // the struct-pointer and the scalar-pointer spelling.
    let p = compile_str(
        "struct S { int x; };\n\
         static struct S *bad1 = 5;\n\
         static int *bad2 = 7;\n\
         int main(void) { return 0; }",
    );
    let msgs: alloc::vec::Vec<alloc::string::String> =
        p.warnings.iter().map(|w| w.to_string()).collect();
    let struct_row = msgs.iter().any(|s| {
        s.contains("integer assigned to pointer in global initializer")
            && s.contains("var=struct S*")
    });
    let scalar_row = msgs.iter().any(|s| {
        s.contains("integer assigned to pointer in global initializer") && s.contains("var=int*")
    });
    assert!(struct_row && scalar_row, "got: {msgs:?}");
}

#[test]
fn a_pointer_against_a_scalar_reports_the_same_row_whatever_the_pointee() {
    // C99 6.5.16.1p1 lists one constraint for a pointer against an
    // integer, so the row does not depend on the pointee: the same code
    // and text in every context and direction, and the quiet cases -- a
    // null pointer constant, a `_Bool` target, the 128-bit integer --
    // quiet on both sides alike.
    use crate::diag::Code;
    let p = compile_str(
        "struct S { int x; };\n\
         static struct S *g1 = 5;\n\
         static int *g2 = 7;\n\
         static struct S *g3 = 1.5;\n\
         static int *g4 = 2.5;\n\
         void f(struct S *sp, int *ip, __int128 w) {\n\
           char c; signed char sc; unsigned char uc; int i; double d; _Bool b;\n\
           struct S *a1; int *a2;\n\
           c = sp; c = ip; sc = sp; sc = ip; uc = sp; uc = ip;\n\
           i = sp; i = ip; d = sp; d = ip; b = sp; b = ip;\n\
           a1 = 0; a2 = 0; a1 = 9; a2 = 9; a1 = 1.5; a2 = 1.5; a1 = w; a2 = w;\n\
           (void)c; (void)sc; (void)uc; (void)i; (void)d; (void)b; (void)a1; (void)a2;\n\
         }\n\
         int main(void) { return 0; }",
    );
    let rows: alloc::vec::Vec<(Code, alloc::string::String)> =
        p.warnings.iter().map(|w| (w.code, w.to_string())).collect();
    assert!(
        rows.iter().all(|(c, _)| *c == Code::INT_CONVERSION),
        "got: {rows:?}"
    );
    let count = |needle: &str| rows.iter().filter(|(_, s)| s.contains(needle)).count();
    assert_eq!(
        (
            count("integer assigned to pointer in global initializer"),
            count("integer assigned to pointer in assignment"),
            count("pointer assigned to integer in assignment"),
            rows.len(),
        ),
        (4, 4, 10, 18),
        "got: {rows:?}"
    );
}

#[test]
fn the_signedness_marker_is_not_part_of_an_aggregate_identity() {
    // `__int128` is modeled as an aggregate, so the signed and unsigned
    // spellings of a pointer to it differ only in the marker. C99
    // 6.3.1.3 makes that an integer conversion, and c5 reports pointee
    // signedness nowhere else, so it is not a struct mismatch.
    let p = compile_str(
        "typedef unsigned __int128 u128;\n\
         static u128 swap128(volatile u128 *p, u128 v) { u128 o = *p; *p = v; return o; }\n\
         static void set(__int128 *p, __int128 v) { swap128(p, v); }\n\
         struct dte { u128 data[2]; };\n\
         void w(struct dte *p) { set(&p->data[1], 0); }\n\
         int main(void) { return 0; }",
    );
    assert!(p.warnings.is_empty(), "got: {:?}", p.warnings);

    // Two different aggregates are still a mismatch at pointer depth.
    let p = compile_str(
        "struct A { int a; };\n\
         struct B { int b; };\n\
         void bad(struct A *a) { struct B *b; b = a; (void)b; }\n\
         int main(void) { return 0; }",
    );
    assert!(
        p.warnings.iter().any(|w| w
            .to_string()
            .contains("incompatible struct types in assignment")),
        "got: {:?}",
        p.warnings
    );
}

/// C99 6.5.2.1p1-2: either operand of `[]` may be the pointer, so `i[p]` is
/// `p[i]`. The integer-first order reads, stores and takes the address of
/// the same element, with an array decaying on either side, through the
/// rows of a multi-dimensional array and a pointer to an array, through an
/// array of function pointers, and in an address constant.
#[test]
fn a_subscript_takes_the_integer_on_either_side() {
    use super::Vm;
    use crate::Compiler;
    let src = "int m[2][3] = { { 1, 2, 3 }, { 4, 5, 6 } };\n\
               int *first = &0[m][0];\n\
               int *last = &1[m][2];\n\
               int one(int x) { return x + 1; }\n\
               int (*tab[1])(int) = { one };\n\
               int main(void) {\n\
               \tint a[3] = { 7, 8, 9 }, *p = a, i = 2, j = 1;\n\
               \tint (*pa)[3] = m;\n\
               \t2[a] += 1;\n\
               \tif (i[p] != p[i] || i[p] != 10 || 1[a] != 8 || &2[a] != &a[2]) return 1;\n\
               \tif (1[m][2] != 6 || j[m][i] != 6 || 1[pa][2] != 6) return 2;\n\
               \tif (sizeof 1[m] != sizeof m[1] || 1[\"xy\"] != 'y') return 3;\n\
               \tif (first != &m[0][0] || last != &m[1][2]) return 4;\n\
               \treturn 0[tab](41);\n\
               }\n";
    let program = Compiler::new(src.to_string()).compile().expect(src);
    assert_eq!(Vm::new(program).run().unwrap(), 42, "{src}");
    for (body, text) in [
        (
            "int t(int *p, int *q) { return q[p]; }",
            "array subscript has type",
        ),
        (
            "int t(int *p, double d) { return d[p]; }",
            "array subscript has type `double`",
        ),
        (
            "int t(int i, int j) { return i[j]; }",
            "subscripted value has type `int`, not a pointer or an array",
        ),
    ] {
        let src = format!("{body}\nint main(void) {{ return 0; }}\n");
        let err = Compiler::new(src.clone()).compile().expect_err(&src);
        let msg = err.to_string();
        assert!(
            msg.contains("[B3020] [invalid-operands]") && msg.contains(text),
            "{src}{msg}"
        );
    }
}

/// C99 6.5.2.1p1: the pointer operand of `[]` points to an object type. A
/// pointer to a function does not, however it is spelled, and a function
/// designator decays to one; the diagnostic names its type. An element of
/// an array of function pointers, of a pointer to one, or of an array
/// parameter, which C99 6.7.5.3p7 makes such a pointer, is an object.
#[test]
fn a_subscript_rejects_a_pointer_to_a_function() {
    use super::Vm;
    use crate::Compiler;
    let decls = "static double twice(double x) { return x * 2; }\n\
                 static double (*getfp(void))(double) { return twice; }\n\
                 struct s { double (*m)(double); double (*a[2])(double); };\n\
                 double (*(*lp)(void))(double) = getfp;\n\
                 static double elem(double (*const t[])(double)) { return t[1](3); }\n\
                 int main(void) {\n\
                 \tdouble (*fp)(double) = twice, (**pp)(double) = &fp;\n\
                 \tdouble (*arr[2])(double) = { twice, twice };\n\
                 \tstruct s s = { twice, { twice, twice } };\n";
    let fp = "`double (*)(double)`, a pointer to a function";
    for (expr, text) in [
        ("(&twice)[0](3)", fp),
        ("fp[0](3)", fp),
        ("0[fp](3)", fp),
        ("twice[0](3)", fp),
        ("(*fp)[0](3)", fp),
        ("(*pp)[0](3)", fp),
        ("s.m[0](3)", fp),
        ("getfp()[0](3)", fp),
        ("(fp + 1)[0](3)", fp),
        ("(0, fp)[0](3)", fp),
        ("(1 ? fp : twice)[0](3)", fp),
        ("((double (*)(double))0)[0](3)", fp),
        (
            "lp[0]()(3)",
            "`double (*(*)(void))(double)`, a pointer to a function",
        ),
    ] {
        let src = format!("{decls}\treturn {expr} == 6.0;\n}}\n");
        let err = Compiler::new(src.clone())
            .compile()
            .expect_err(&src)
            .to_string();
        assert!(
            err.contains(&format!("subscripted value has type {text} [B3020]")),
            "{src}{err}"
        );
    }
    let src =
        format!("{decls}\treturn pp[0](3) + arr[1](3) + s.a[1](3) + elem(arr) == 24.0;\n}}\n");
    let program = Compiler::new(src.clone()).compile().expect(&src);
    assert_eq!(Vm::new(program).run().unwrap(), 1, "{src}");
}

/// C99 6.5.2.1p1, 6.5.6p2: a subscript and the additive operators step by
/// the pointee's size, so a pointer to a struct or union without its body,
/// or to an array of unknown bound, is rejected with its type named. A
/// pointer to `void` steps by one byte as GNU C defines it, the element of
/// a pointer to an incomplete array is an object, and the comparisons take
/// any object pointer.
#[test]
fn pointer_arithmetic_rejects_an_incomplete_pointee() {
    use super::Vm;
    use crate::Compiler;
    let decls = "struct S; union U;\n\
                 long f(struct S *p, struct S *q, union U *u, int (*pa)[], void *vp) {\n";
    let s = "`struct S*`, a pointer to an incomplete type";
    for (body, text) in [
        (
            "return (long)&p[1];",
            format!("subscripted value has type {s}"),
        ),
        ("return (long)(p + 1);", format!("`+` operand has type {s}")),
        ("return (long)(1 + p);", format!("`+` operand has type {s}")),
        ("return p - q;", format!("`-` operand has type {s}")),
        ("p++; return 0;", format!("`++` operand has type {s}")),
        ("--p; return 0;", format!("`--` operand has type {s}")),
        ("p += 2; return 0;", format!("`+=` operand has type {s}")),
        ("p -= 2; return 0;", format!("`-=` operand has type {s}")),
        (
            "return (long)(u - 1);",
            "`-` operand has type `union U*`, a pointer to an incomplete type".into(),
        ),
        (
            "return (long)&pa[1];",
            "subscripted value has type `int (*)[]`, a pointer to an incomplete type".into(),
        ),
    ] {
        let src = format!("{decls}\t{body}\n}}\nint main(void) {{ return 0; }}\n");
        let err = Compiler::new(src.clone())
            .compile()
            .expect_err(&src)
            .to_string();
        assert!(err.contains(&format!("{text} [B3020]")), "{src}{err}");
    }
    let src = "struct S;\n\
               int f(struct S *p, struct S *q, int (*pa)[], void *vp) {\n\
               \treturn (p == q) + (*pa)[1] + (int)((char *)(vp + 3) - (char *)vp);\n\
               }\n\
               int main(void) { int a[2] = { 0, 4 }; return f(0, 0, &a, a); }\n";
    let program = Compiler::new(src.to_string()).compile().expect(src);
    assert_eq!(Vm::new(program).run().unwrap(), 8, "{src}");
}

/// C99 6.6p6: a context that requires an integer constant expression -- a
/// `case` label or range, an enumerator, an array size, a bit-field width,
/// a designator, `_Alignas` and the C11 `_Static_assert` -- rejects one
/// whose result has floating type. A floating constant cast to an integer
/// type, `sizeof` and `_Alignof`, enumeration and character constants and
/// the GNU constant builtins stay accepted, as does a floating constant
/// initializing an integer object.
#[test]
fn an_integer_constant_expression_rejects_a_floating_result() {
    use super::Vm;
    use crate::Compiler;
    for body in [
        "int t(int x) { switch (x) { case 1.5: return 1; } return 0; }",
        "int t(int x) { switch (x) { case 1 ... 2.5: return 1; } return 0; }",
        "enum { A = 1.5 };",
        "enum { A = 2.0 * 3 };",
        "int a[2.0];",
        "int t(void) { int a[2.5]; return sizeof a; }",
        "struct S { int b : 1.5; };",
        "_Static_assert(1.5, \"x\");",
        "int a[4] = { [1.5] = 1 };",
        "_Alignas(8.0) int al;",
    ] {
        let src = format!("{body}\nint main(void) {{ return 0; }}\n");
        let err = Compiler::new(src.clone()).compile().expect_err(&src);
        let msg = err.to_string();
        let want = "integer constant expression has floating type [B3021] [constant-expression]";
        assert!(msg.contains(want), "{src}{msg}");
    }
    let src = "#define ICE(x) (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))\n\
               enum { B = (int)2.5, C = 'a', D = __builtin_constant_p(1.5), E = __builtin_choose_expr(1, 3, 4.5) };\n\
               struct S { int b : (int)3.0; };\n\
               _Static_assert(ICE(3) && sizeof(double) == 8, \"x\");\n\
               int sizes[_Alignof(double) + sizeof(char)];\n\
               int x = 1.5, y = 1 + 1.5;\n\
               int main(void) {\n\
               \tswitch (C) { case (int)97.5: break; default: return 1; }\n\
               \treturn B + D + E + x + y + (int)(sizeof sizes / sizeof *sizes);\n\
               }\n";
    let program = Compiler::new(src.to_string()).compile().expect(src);
    assert_eq!(Vm::new(program).run().unwrap(), 18, "{src}");
}

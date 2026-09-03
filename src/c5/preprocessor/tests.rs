use super::include::include_parent_dir;
use super::text::{
    ends_in_open_block_comment_once, scan_steps_taken, strip_c_comments, strip_c_comments_ref,
    unfold_and_strip, unfold_line_continuations, unfold_ref,
};
use super::*;

fn process(source: &str) -> String {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.process(source).expect("preprocessor failed")
}

/// The gcc `-H` trace for what `pp` recorded.
fn trace_lines(pp: &Preprocessor) -> Vec<String> {
    pp.include_records
        .iter()
        .map(IncludeRecord::trace_line)
        .collect()
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
fn if_char_literal_takes_a_universal_character_name() {
    // C11 6.4.3: a universal character name in a `#if` character
    // constant means what it means outside one -- the UTF-8 bytes of its
    // code point, packed per C99 6.4.4.4p10 and read at the constant's
    // `int` type, so four of them give a negative value. Matches GCC.
    for e in [
        r"'\u0024' == 0x24",
        r"'\u00E9' == 0xC3A9",
        r"'\U0001F600' == -257976192",
        r"'a\u00E9' == 0x61C3A9",
    ] {
        let out = process(&format!("#if {e}\nTAKEN\n#else\nNOT\n#endif\n"));
        assert!(out.contains("TAKEN"), "{e}: {out}");
    }
    // 6.4.3p2 bars the surrogates, a value below 00A0 outside {0024,
    // 0040, 0060}, and anything past the code space; p1 fixes the digit
    // count. The evaluator rejects rather than folding a wrong value.
    for e in [
        r"'\uD800' == 0",
        r"'\u0041' == 0x41",
        r"'\U00110000' == 0",
        r"'\u12' == 0",
    ] {
        let err = process_err(&format!("#if {e}\nX\n#endif\n"));
        assert!(err.contains("universal character name"), "{e}: {err}");
    }
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
    pp.enable_gnu(false, true);
    let out = pp.process(probe).expect("preprocessor failed");
    assert!(
        out.contains("G yes") && out.contains("S yes"),
        "--gnu: {out}"
    );

    // `-std=gnu*` keeps `__GNUC__` and drops `__STRICT_ANSI__`, the
    // combination gcc and clang produce for a GNU dialect. A header that
    // gates a GNU declaration on the pair -- `<asm/xen/interface_64.h>`
    // gates the anonymous union naming both `rip` and `eip` on it --
    // then reaches the same declarations it gives gcc.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.enable_gnu(false, false);
    let out = pp.process(probe).expect("preprocessor failed");
    assert!(
        out.contains("G yes") && out.contains("S no"),
        "--gnu -std=gnu11: {out}"
    );
}

#[test]
fn gnu_predefine_set_is_locked() {
    // Every macro `--gnu` adds over the default set, with its value. A
    // capability macro here is a promise about what badc backs, so the
    // list is exact in both directions: adding one requires backing the
    // feature, dropping one requires removing the promise.
    let base = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    let mut gnu = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    gnu.enable_gnu(false, true);
    let mut added: Vec<(String, String)> = gnu
        .macros
        .iter()
        .filter(|(k, _)| !base.macros.contains_key(*k))
        .map(|(k, v)| (k.clone(), v.clone()))
        .collect();
    added.sort();
    let version = crate::GNU_COMPAT_VERSION;
    let mut want: Vec<(String, String)> = [
        ("__GCC_ASM_FLAG_OUTPUTS__", "1"),
        ("__GCC_ATOMIC_BOOL_LOCK_FREE", "2"),
        ("__GCC_ATOMIC_CHAR16_T_LOCK_FREE", "2"),
        ("__GCC_ATOMIC_CHAR32_T_LOCK_FREE", "2"),
        ("__GCC_ATOMIC_CHAR_LOCK_FREE", "2"),
        ("__GCC_ATOMIC_INT_LOCK_FREE", "2"),
        ("__GCC_ATOMIC_LLONG_LOCK_FREE", "2"),
        ("__GCC_ATOMIC_LONG_LOCK_FREE", "2"),
        ("__GCC_ATOMIC_POINTER_LOCK_FREE", "2"),
        ("__GCC_ATOMIC_SHORT_LOCK_FREE", "2"),
        ("__GCC_ATOMIC_TEST_AND_SET_TRUEVAL", "1"),
        ("__GCC_ATOMIC_WCHAR_T_LOCK_FREE", "2"),
        ("__GCC_HAVE_SYNC_COMPARE_AND_SWAP_1", "1"),
        ("__GCC_HAVE_SYNC_COMPARE_AND_SWAP_2", "1"),
        ("__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4", "1"),
        ("__GCC_HAVE_SYNC_COMPARE_AND_SWAP_8", "1"),
        ("__GNUC_STDC_INLINE__", "1"),
        ("__STRICT_ANSI__", "1"),
    ]
    .iter()
    .map(|(k, v)| ((*k).to_string(), (*v).to_string()))
    .collect();
    let mut claim = version.split('.');
    for name in ["__GNUC__", "__GNUC_MINOR__", "__GNUC_PATCHLEVEL__"] {
        want.push((name.to_string(), claim.next().expect("x.y.z").to_string()));
    }
    want.push((
        "__VERSION__".to_string(),
        format!(
            "\"{version} Compatible badc {}\"",
            env!("CARGO_PKG_VERSION")
        ),
    ));
    want.sort();
    assert_eq!(added, want, "the --gnu predefine set changed");
    // A 16-byte compare-exchange has no lowering, so the width the
    // `__sync_*` family does not cover stays unclaimed.
    assert!(
        !gnu.macros
            .contains_key("__GCC_HAVE_SYNC_COMPARE_AND_SWAP_16")
    );
    // `-std=gnu*` drops the ISO-conformance macro and nothing else.
    let mut gnu_dialect = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    gnu_dialect.enable_gnu(false, false);
    assert!(!gnu_dialect.macros.contains_key("__STRICT_ANSI__"));
    // The inline-model macro follows `gnu89_inline`; exactly one is set.
    let mut gnu89 = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    gnu89.enable_gnu(true, true);
    assert!(gnu89.macros.contains_key("__GNUC_GNU_INLINE__"));
    assert!(!gnu89.macros.contains_key("__GNUC_STDC_INLINE__"));
    // The asm flag-output macro is x86-only, as the feature is.
    let mut arm = Preprocessor::new("linux-aarch64", Target::LinuxAarch64, "0.1.0");
    arm.enable_gnu(false, true);
    assert!(!arm.macros.contains_key("__GCC_ASM_FLAG_OUTPUTS__"));
}

#[test]
fn segment_and_utf_capability_macros_track_the_feature() {
    // `__SEG_FS` / `__SEG_GS` report the x86 named address spaces, so
    // they follow the target rather than the dialect; the C11 UTF
    // encoding macros hold on every target.
    let probe = "#ifdef __SEG_GS\nGS yes\n#else\nGS no\n#endif\n\
                 #ifdef __SEG_FS\nFS yes\n#else\nFS no\n#endif\n\
                 U16 __STDC_UTF_16__\nU32 __STDC_UTF_32__\n";
    let mut x86 = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    let out = x86.process(probe).expect("preprocessor failed");
    assert!(out.contains("GS yes") && out.contains("FS yes"), "{out}");
    assert!(out.contains("U16 1") && out.contains("U32 1"), "{out}");
    let mut arm = Preprocessor::new("linux-aarch64", Target::LinuxAarch64, "0.1.0");
    let out = arm.process(probe).expect("preprocessor failed");
    assert!(out.contains("GS no") && out.contains("FS no"), "{out}");
    assert!(out.contains("U16 1") && out.contains("U32 1"), "{out}");
}

#[test]
fn gnu_identity_version_derives_from_the_shared_claim() {
    // The `__GNUC__` triple and `__VERSION__` must state
    // `GNU_COMPAT_VERSION` -- the same claim `--version` prints --
    // and `__VERSION__` must name badc as the producer, as clang
    // names itself in its "<dialect> Compatible <producer>" form.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.enable_gnu(false, true);
    let out = pp
        .process("maj __GNUC__\nmin __GNUC_MINOR__\npat __GNUC_PATCHLEVEL__\nver __VERSION__\n")
        .expect("preprocessor failed");
    let mut claim = crate::GNU_COMPAT_VERSION.split('.');
    for label in ["maj", "min", "pat"] {
        let want = format!("{label} {}", claim.next().expect("x.y.z"));
        assert!(
            out.contains(&want),
            "expected {want:?} (GNU_COMPAT_VERSION component): {out}"
        );
    }
    let want_ver = format!(
        "ver \"{} Compatible badc {}\"",
        crate::GNU_COMPAT_VERSION,
        env!("CARGO_PKG_VERSION")
    );
    assert!(
        out.contains(&want_ver),
        "__VERSION__ does not identify badc: {out}"
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

/// `set_unit_model` re-selects the whole data-model group, so an ILP32
/// unit carries no macro from the LP64 one and back again is exact.
/// Values are gcc 16.1.1's for `-m32` / `-m64` on `linux-x64`.
#[test]
fn elf_class_selects_the_data_model_predefines() {
    use crate::c5::{CodeModel, ElfClass};
    let probe = concat!(
        "#ifdef __x86_64__\nx86_64\n#endif\n#ifdef __amd64__\namd64\n#endif\n",
        "#ifdef __i386__\ni386\n#endif\n#ifdef __i386\ni386_bare\n#endif\n",
        "#ifdef __LP64__\nlp64\n#endif\n#ifdef __ILP32__\nilp32\n#endif\n",
        "#ifdef __SIZEOF_INT128__\nint128\n#endif\n",
        "#ifdef __code_model_32__\ncm32\n#endif\n",
        "#ifdef __code_model_small__\ncmsmall\n#endif\n",
        "sizes __SIZEOF_POINTER__ __SIZEOF_LONG__ __SIZEOF_SIZE_T__ __SIZEOF_PTRDIFF_T__\n",
        "types __SIZE_TYPE__ / __PTRDIFF_TYPE__\n",
        "wchar __WCHAR_TYPE__ .\n",
    );
    let names64 = ["x86_64", "amd64", "lp64", "int128", "cmsmall"];
    let names32 = ["i386", "i386_bare", "ilp32", "cm32"];
    let mut pp = Preprocessor::new(Target::LinuxX64.id_str(), Target::LinuxX64, "0.1.0");
    pp.set_unit_model(ElfClass::Elf32, CodeModel::Small, false);
    let out = pp.process(probe).expect("preprocessor failed");
    for n in names32 {
        assert!(out.contains(n), "ELFCLASS32 must define {n}: {out}");
    }
    for n in names64 {
        assert!(!out.contains(n), "ELFCLASS32 must not define {n}: {out}");
    }
    assert!(out.contains("sizes 4 4 4 4"), "ILP32 widths: {out}");
    assert!(
        out.contains("types unsigned int / int"),
        "ILP32 size_t / ptrdiff_t: {out}"
    );
    assert!(out.contains("wchar long int ."), "i386 wchar_t: {out}");
    // Back to ELFCLASS64: no i386 macro survives the round trip.
    let mut pp = Preprocessor::new(Target::LinuxX64.id_str(), Target::LinuxX64, "0.1.0");
    pp.set_unit_model(ElfClass::Elf32, CodeModel::Small, false);
    pp.set_unit_model(ElfClass::Elf64, CodeModel::Small, false);
    let out = pp.process(probe).expect("preprocessor failed");
    for n in names64 {
        assert!(out.contains(n), "ELFCLASS64 must define {n}: {out}");
    }
    for n in names32 {
        assert!(!out.contains(n), "ELFCLASS64 must not define {n}: {out}");
    }
    assert!(out.contains("sizes 8 8 8 8"), "LP64 widths: {out}");
    assert!(
        out.contains("types unsigned long / long"),
        "LP64 size_t / ptrdiff_t: {out}"
    );
    assert!(out.contains("wchar int ."), "LP64 wchar_t: {out}");
    // An ELFCLASS32 AArch64 object would be AArch32, which badc neither
    // encodes nor describes; the target's own model stands.
    let mut pp = Preprocessor::new(Target::LinuxAarch64.id_str(), Target::LinuxAarch64, "0.1.0");
    pp.set_unit_model(ElfClass::Elf32, CodeModel::Small, false);
    let out = pp.process(probe).expect("preprocessor failed");
    assert!(out.contains("lp64") && !out.contains("ilp32"), "{out}");
    assert!(out.contains("sizes 8 8 8 8"), "{out}");
}

/// The `__code_model_*__` name follows `-mcmodel` on the x86-64
/// targets, `-m16` / `-m32` override it to the 32-bit model, and the
/// aarch64 targets define none, all as gcc 16.1.1 does.
#[test]
fn the_code_model_predefine_names_the_selected_model() {
    use crate::c5::{CodeModel, ElfClass};
    let probe = concat!(
        "#ifdef __code_model_32__\ncm32\n#endif\n",
        "#ifdef __code_model_small__\ncmsmall\n#endif\n",
        "#ifdef __code_model_kernel__\ncmkernel\n#endif\n",
    );
    let cases = [
        (ElfClass::Elf64, CodeModel::Small, "cmsmall"),
        (ElfClass::Elf64, CodeModel::Kernel, "cmkernel"),
        (ElfClass::Elf32, CodeModel::Small, "cm32"),
    ];
    for (class, model, want) in cases {
        for t in [Target::LinuxX64, Target::WindowsX64] {
            let mut pp = Preprocessor::new(t.id_str(), t, "0.1.0");
            pp.set_unit_model(class, model, false);
            let out = pp.process(probe).expect("preprocessor failed");
            for n in ["cm32", "cmsmall", "cmkernel"] {
                assert_eq!(
                    out.contains(n),
                    n == want,
                    "{t:?} {class:?} {model:?}: {out}"
                );
            }
        }
    }
    for t in [
        Target::LinuxAarch64,
        Target::MacOSAarch64,
        Target::WindowsAarch64,
    ] {
        let mut pp = Preprocessor::new(t.id_str(), t, "0.1.0");
        let out = pp.process(probe).expect("preprocessor failed");
        assert!(
            !out.contains("cm"),
            "{t:?} must define no code-model macro: {out}"
        );
    }
}

/// Sizes and underlying types the layout engine fixes across targets:
/// `long double` takes the target ABI's storage size (16 on both Linux
/// targets, 8 elsewhere; no `__float80` / `__float128` exists to
/// describe), `wint_t` is the bundled <wchar.h>'s `int`, a bare
/// `__attribute__((aligned))` resolves to 16, and `__WCHAR_TYPE__`
/// agrees with `__SIZEOF_WCHAR_T__` on every target.
/// `__CHAR16_TYPE__` / `__CHAR32_TYPE__` name the types C11
/// 6.4.4.4p3-p4 give `u'c'` and `U'c'`; neither tracks `wchar_t`, so
/// both hold on every target.
#[test]
fn type_size_predefines_match_the_layout_engine() {
    let probe = concat!(
        "ld __SIZEOF_LONG_DOUBLE__ wint __SIZEOF_WINT_T__ ",
        "align __BIGGEST_ALIGNMENT__ .\n",
        "winttype __WINT_TYPE__ .\n",
        "wchar __WCHAR_TYPE__ = __SIZEOF_WCHAR_T__ .\n",
        "c16 __CHAR16_TYPE__ c32 __CHAR32_TYPE__ .\n",
        "#if defined(__SIZEOF_FLOAT80__) || defined(__SIZEOF_FLOAT128__)\n",
        "phantom-float\n#endif\n",
    );
    for (t, wchar, ld) in [
        (Target::LinuxX64, "int = 4", 16),
        (Target::LinuxAarch64, "unsigned int = 4", 16),
        (Target::MacOSAarch64, "int = 4", 8),
        (Target::WindowsX64, "unsigned short = 2", 8),
        (Target::WindowsAarch64, "unsigned short = 2", 8),
    ] {
        let mut pp = Preprocessor::new(t.id_str(), t, "0.1.0");
        let out = pp.process(probe).expect("preprocessor failed");
        assert!(
            out.contains(&format!("ld {ld} wint 4 align 16 .")),
            "{t:?}: {out}"
        );
        assert!(out.contains("winttype int ."), "{t:?}: {out}");
        assert!(out.contains(&format!("wchar {wchar} .")), "{t:?}: {out}");
        assert!(
            out.contains("c16 unsigned short c32 unsigned int ."),
            "{t:?}: {out}"
        );
        assert!(!out.contains("phantom-float"), "{t:?}: {out}");
    }
}

/// `-fshort-wchar` moves `__SIZEOF_WCHAR_T__` and `__WCHAR_TYPE__`
/// together on every target: 2 and an unsigned 16-bit spelling, which
/// is what gcc 16.1.1 reports (`short unsigned int`, the same type).
/// The Windows targets are already there, so the flag leaves them and
/// its absence does not widen them. `<stddef.h>` keys its typedef on
/// `__SIZEOF_WCHAR_T__`, so the pair is the type the unit sees.
#[test]
fn short_wchar_moves_the_wchar_predefines() {
    use crate::c5::{CodeModel, ElfClass};
    let probe = "wchar __WCHAR_TYPE__ = __SIZEOF_WCHAR_T__ .\n";
    for (t, wide) in [
        (Target::LinuxX64, "int = 4"),
        (Target::LinuxAarch64, "unsigned int = 4"),
        (Target::MacOSAarch64, "int = 4"),
        (Target::WindowsX64, "unsigned short = 2"),
        (Target::WindowsAarch64, "unsigned short = 2"),
    ] {
        for (short_wchar, want) in [(false, wide), (true, "unsigned short = 2")] {
            let mut pp = Preprocessor::new(t.id_str(), t, "0.1.0");
            pp.set_unit_model(ElfClass::Elf64, CodeModel::Small, short_wchar);
            let out = pp.process(probe).expect("preprocessor failed");
            assert!(
                out.contains(&format!("wchar {want} .")),
                "{t:?} short_wchar={short_wchar}: {out}"
            );
        }
    }
    // The i386 spelling is gcc's `long int` at the default width; the
    // narrowed one wins over it, as the width does.
    let mut pp = Preprocessor::new(Target::LinuxX64.id_str(), Target::LinuxX64, "0.1.0");
    pp.set_unit_model(ElfClass::Elf32, CodeModel::Small, true);
    let out = pp.process(probe).expect("preprocessor failed");
    assert!(out.contains("wchar unsigned short = 2 ."), "ILP32: {out}");
}

/// C99 5.2.4.2.2 characteristics, in the `__FLT_*` / `__DBL_*` /
/// `__LDBL_*` spellings third-party headers test directly. `float` is
/// binary32 and `double` binary64 everywhere; the LDBL row describes
/// the storage format badc gives the type per target: x87 80-bit on
/// linux-x64 and IEEE binary128 on linux-aarch64, matching gcc on
/// both, and binary64 on the targets whose ABI defines it that way.
/// `__DECIMAL_DIG__` follows the widest format (5.2.4.2.2p11).
#[test]
fn float_characteristic_predefines_describe_the_target_formats() {
    let probe = concat!(
        "flt __FLT_MANT_DIG__ __FLT_DIG__ __FLT_DECIMAL_DIG__ .\n",
        "dbl __DBL_MANT_DIG__ __DBL_DIG__ __DBL_MAX_EXP__ .\n",
        "ldbl __LDBL_MANT_DIG__ __LDBL_DIG__ __LDBL_MAX_EXP__ .\n",
        "radix __FLT_RADIX__ decimal __DECIMAL_DIG__ .\n",
        "#if __LDBL_MANT_DIG__ == __DBL_MANT_DIG__\n",
        "ldbl-is-dbl\n#endif\n",
        "traits __FLT_HAS_DENORM__ __DBL_HAS_INFINITY__ __LDBL_HAS_QUIET_NAN__ .\n",
    );
    for (t, ldbl, decimal, is_dbl) in [
        (Target::LinuxX64, "ldbl 64 18 16384 .", 21, false),
        (Target::LinuxAarch64, "ldbl 113 33 16384 .", 36, false),
        (Target::MacOSAarch64, "ldbl 53 15 1024 .", 17, true),
        (Target::WindowsX64, "ldbl 53 15 1024 .", 17, true),
        (Target::WindowsAarch64, "ldbl 53 15 1024 .", 17, true),
    ] {
        let mut pp = Preprocessor::new(t.id_str(), t, "0.1.0");
        let out = pp.process(probe).expect("preprocessor failed");
        assert!(out.contains("flt 24 6 9 ."), "{t:?}: {out}");
        assert!(out.contains("dbl 53 15 1024 ."), "{t:?}: {out}");
        assert!(out.contains(ldbl), "{t:?}: {out}");
        assert!(
            out.contains(&format!("radix 2 decimal {decimal} .")),
            "{t:?}: {out}"
        );
        assert_eq!(out.contains("ldbl-is-dbl"), is_dbl, "{t:?}: {out}");
        assert!(out.contains("traits 1 1 1 ."), "{t:?}: {out}");
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
    assert!(ends_in_open_block_comment_once("foo /* bar"));
    assert!(!ends_in_open_block_comment_once("foo /* bar */ baz"));
    assert!(!ends_in_open_block_comment_once("foo // /* not open"));
    assert!(!ends_in_open_block_comment_once("s = \"/*\""));
    assert!(ends_in_open_block_comment_once("c = '/' ; /* open"));
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
fn variadic_stringize_keeps_the_source_spacing() {
    // C99 6.10.3.2p2: the stringized spelling keeps the argument tokens
    // as written -- a space only where the source had one. gcc 16:
    // S(kvm-amd,kvm-intel) is "kvm-amd,kvm-intel", S1(one, two ,three)
    // is "one, two ,three".
    let out = process(
        "#define S1(x...) #x\n#define S(x...) S1(x)\n\
         const char *a = S(kvm-amd,kvm-intel);\n\
         const char *b = S1(one, two ,three);\n",
    );
    assert!(out.contains("\"kvm-amd,kvm-intel\""), "{out}");
    assert!(out.contains("\"one, two ,three\""), "{out}");
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
fn a_file_name_is_escaped_wherever_it_becomes_a_string_literal() {
    // A Windows path is what reaches this: `\U` opens a universal
    // character name, so `__FILE__` naming `...\UefiApp\...` failed to
    // lex once the lexer diagnosed an incomplete one. gcc and clang
    // escape `\` and `"` in both positions.
    let name = "R:\\src\\UefiApp\\a\"b.c";
    let want = "\"R:\\\\src\\\\UefiApp\\\\a\\\"b.c\"";
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.set_source_label(name);
    let out = pp.process("__FILE__\n").expect("preprocessor failed");
    assert!(
        out.contains(want),
        "__FILE__ must expand to a valid string literal:\n{out}"
    );
    // The line marker names the same file, and the two escaped
    // independently -- only the marker did. Assert they agree so a
    // third copy cannot drift from either.
    assert_eq!(
        super::directive::format_line_marker(1, name),
        alloc::format!("# 1 {want}\n")
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

// C99 6.10.3.3p2 applies `##` to both macro forms, so the object-like
// replacement list pastes exactly as the function-like one does.
#[test]
fn token_paste_in_object_like_body() {
    let out = process("#define CAT a ## b\n#define PRE NV ## 907D\nint CAT; int PRE;\n");
    assert!(
        out.contains("int ab; int NV907D;"),
        "object-like ## should paste:\n{out}"
    );
}

#[test]
fn token_paste_chain_in_object_like_body() {
    let out = process("#define CHAIN a ## b ## c\nint CHAIN;\n");
    assert!(
        out.contains("int abc;"),
        "several ## in one list paste left to right:\n{out}"
    );
}

// The paste result is not rescanned as part of the paste, but the
// ordinary C99 6.10.3.4 rescan of the replacement list expands it.
#[test]
fn object_like_paste_result_is_rescanned() {
    let out = process("#define FOO 42\n#define MK F ## OO\nint x = MK;\n");
    assert!(
        out.contains("int x = 42;"),
        "a pasted macro name expands on rescan:\n{out}"
    );
}

#[test]
fn object_like_paste_through_function_like_argument() {
    let src = "#define OBJ x ## y\n#define ID(a) a\n#define STR(a) #a\n#define XSTR(a) STR(a)\n\
               int p = ID(OBJ); const char *s = XSTR(OBJ); const char *t = STR(OBJ);\n";
    let out = process(src);
    assert!(
        out.contains("int p = xy;") && out.contains("\"xy\"") && out.contains("\"OBJ\""),
        "object-like paste must survive argument expansion and stringizing:\n{out}"
    );
}

// C99 6.10.3.2 gives `#` meaning only in a function-like replacement
// list; in an object-like one it stays an ordinary punctuator.
#[test]
fn hash_is_not_stringize_in_object_like_body() {
    let out = process("#define TWOHASH a # b\nint v = TWOHASH;\n");
    assert!(
        out.contains("int v = a # b;"),
        "object-like # is literal:\n{out}"
    );
}

// C99 6.10.3.3p1 constraint, stated for either form of definition.
#[test]
fn paste_at_replacement_list_end_is_an_error() {
    for src in [
        "#define LEAD ## b\n",
        "#define TRAIL a ##\n",
        "#define FL(a) ## a\n",
        "#define FT(a) a ##\n",
    ] {
        let e = process_err(src);
        assert!(
            e.contains("`##` cannot appear at either end"),
            "{src:?} must be diagnosed, got: {e}"
        );
    }
}

// `##` between the comma and the variadic tail is mid-list, so the
// constraint above must not fire on it.
#[test]
fn paste_before_variadic_tail_is_accepted() {
    let out = process("#define P(f, ...) pr(f, ## __VA_ARGS__)\nP(\"x\");\nP(\"x\", 1);\n");
    assert!(
        out.contains("pr(\"x\");") && out.contains("pr(\"x\", 1);"),
        "mid-list ## stays legal:\n{out}"
    );
}

// The variadic tail after `, ##` is a paste operand, so it substitutes
// unexpanded (C99 6.10.3.1p1). A macro name in it must survive to the
// rescan, where a further `##` operand keeps it and a plain position
// expands it.
#[test]
fn comma_paste_tail_substitutes_unexpanded() {
    let src = "#define FALSE (1 == 0)\n#define P(a, b) a ## _ ## b\n\
               #define Q(A...) P(x, ##A)\n#define R(A...) f(0, ##A)\n\
               int v = Q(FALSE); int w = R(FALSE);\n";
    let out = process(src);
    assert!(
        out.contains("int v = x_FALSE;"),
        "a ## operand must reach the paste unexpanded:\n{out}"
    );
    assert!(
        out.contains("(1 == 0)"),
        "a plain position still expands on rescan:\n{out}"
    );
}

// Each `, ##` use substitutes the tail afresh, so a tail whose
// expansion is not idempotent yields a separate result per use.
#[test]
fn comma_paste_tail_expands_once_per_use() {
    let src = "#define P(a,b) a##b\n#define Q(a,b) P(a,b)\n#define U(p) Q(Q(id_, p), __COUNTER__)\n\
               #define TWICE(f, ...) do { g(f, ##__VA_ARGS__); h(f, ##__VA_ARGS__); } while (0)\n\
               TWICE(\"m\", U(x_));\n";
    let out = process(src);
    assert!(
        out.contains("g(\"m\", id_x_0)") && out.contains("h(\"m\", id_x_1)"),
        "each use must draw its own __COUNTER__:\n{out}"
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

/// C99 6.4.4.4 and 6.4.5: a character constant or string literal is
/// bounded by its line. Phase 3 used to scan an unterminated quote to
/// the next matching quote or to end of file, so an apostrophe in an
/// assembly `#` comment left every following comment unstripped and
/// carried it into macro bodies.
#[test]
fn unterminated_quote_stops_at_end_of_line() {
    let src = "# Don't do it\n\
               #define XLF_KERNEL_64 (1<<0)\n\
               # define XLF0 XLF_KERNEL_64\t/* 64-bit kernel */\n\
               \t.word XLF0\n";
    let out = process(src);
    let last = out
        .lines()
        .rfind(|l| !l.trim().is_empty())
        .expect("output has a content line");
    assert_eq!(last, "\t.word (1<<0)", "{out}");
    assert!(!out.contains("64-bit kernel"), "comment leaked: {out}");
}

/// The bound applies to the primitive: text after an unterminated quote
/// is line-local, so the next line's comment is stripped as usual.
#[test]
fn strip_c_comments_bounds_literals_at_the_line() {
    assert_eq!(strip_c_comments("a 'b\n/* c */ d\n"), "a 'b\n  d\n");
    assert_eq!(strip_c_comments("a \"b\n// c\nd\n"), "a \"b\n \nd\n");
    // A `\` at end of line escapes nothing; phase 2 already spliced
    // every continuation away.
    assert_eq!(strip_c_comments("'a\\\n/* c */ b\n"), "'a\\\n  b\n");
}

/// An unterminated quote runs to end of line and its text passes
/// through verbatim: comments are not opened and macro names are not
/// expanded behind it. Matches `gcc -E -x assembler-with-cpp`.
#[test]
fn unterminated_quote_shields_the_rest_of_its_line() {
    let out = process("#define ONE (1<<0)\n\t.byte 'a /* c */ ONE\n\t.byte ONE\n");
    assert!(out.contains("\t.byte 'a /* c */ ONE"), "{out}");
    assert!(out.contains("\t.byte (1<<0)"), "{out}");
}

/// Terminated literals keep working in assembly text: a character
/// constant in a macro body expands as one, and an apostrophe inside a
/// string is literal content.
#[test]
fn char_constants_still_lex_in_assembly_text() {
    let src = "#define STR 'q'\n\
               #define ONE 1\n\
               \t.byte 'a'\n\
               \t.byte STR\n\
               \t.ascii \"it's fine\"\n\
               \t.byte ONE\n";
    let out = process(src);
    assert!(out.contains("\t.byte 'a'"), "{out}");
    assert!(out.contains("\t.byte 'q'"), "{out}");
    assert!(out.contains("\t.ascii \"it's fine\""), "{out}");
    assert!(out.contains("\t.byte 1"), "{out}");
}

/// C sources are unaffected: a literal spliced across a `\`-newline is
/// still one literal after phase 2, and an unterminated quote still
/// reaches the lexer, which is what diagnoses it.
#[test]
fn c_literals_are_unaffected_by_the_line_bound() {
    let out = process("#define S \"ab\\\ncd\"\nconst char *s = S;\n");
    assert!(out.contains("const char *s = \"abcd\";"), "{out}");
    let out = process("char c = 'a;\nint x = 1; /* note */\n");
    assert!(out.contains("char c = 'a;"), "{out}");
    assert!(out.contains("int x = 1;"), "{out}");
    assert!(!out.contains("note"), "comment leaked: {out}");
}

fn process_asm(source: &str) -> String {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.set_asm_source(true);
    pp.process(source).expect("preprocessor failed")
}

/// Assembler-with-cpp: a `#` line naming no directive is text, passed
/// through with the surrounding phase-3 rules intact, as GNU cpp emits
/// it for assembler input. The kernel's `arch/x86/boot/header.S`
/// reduces to this shape: an apostrophe in such a line, then a comment
/// in a `# define` body.
#[test]
fn asm_hash_comment_line_passes_through() {
    let src = "#define CONFIG_X86_64 1\n\
               #define XLF_KERNEL_64 (1<<0)\n\
               \t\t\t\t\t# with loadlin-1.5 (header v1.5). Don't\n\
               #ifdef CONFIG_X86_64\n\
               # define XLF0 XLF_KERNEL_64\t\t\t/* 64-bit kernel */\n\
               #else\n\
               # define XLF0 0\n\
               #endif\n\
               \t\t\t.word XLF0 | XLF1\n";
    let out = process_asm(src);
    assert!(
        out.contains("# with loadlin-1.5 (header v1.5). Don't"),
        "{out}"
    );
    assert!(out.contains("\t\t\t.word (1<<0) | XLF1"), "{out}");
    assert!(!out.contains("64-bit kernel"), "comment leaked: {out}");
}

/// The passed-through line's tail is macro-expanded and its comments
/// are stripped (`gcc -E -x assembler-with-cpp` produces `# hello 1`);
/// an inactive branch still drops the line; C input still diagnoses
/// and drops an unknown directive instead of passing it through.
#[test]
fn asm_hash_line_tail_is_macro_expanded() {
    let out = process_asm("#define BAR 1\n# hello BAR /* gone */\n");
    assert!(out.contains("# hello 1"), "{out}");
    assert!(!out.contains("gone"), "{out}");
    let out = process_asm("#if 0\n# hidden\n#endif\n\t.word 1\n");
    assert!(!out.contains("hidden"), "{out}");
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let out = pp.process("# hello\nint x;\n").expect("preprocess");
    assert!(!out.contains("# hello"), "{out}");
    assert!(
        pp.warnings.iter().any(|w| w.contains("`#hello`")),
        "{:?}",
        pp.warnings
    );
}

/// A keyword-less line marker is text in assembler input and a directive
/// in C. `#` opens a comment for several assemblers, so GNU cpp and clang
/// pass every `# <n> ...` line through unchanged there -- flag digits and
/// the file-less form included -- and honor only `#line`; consuming one
/// re-homes the unit's diagnostics onto a file it never read and drops the
/// line's own text.
#[test]
fn asm_keeps_line_markers_as_text() {
    let src = "nop1\n# 42 \"injected.h\"\nnop2\n# 7 \"flagged.h\" 1\n\
               nop3\n# 99\nnop4\n#line 55 \"real.h\"\nnop5\n";
    let out = process_asm(src);
    for text in ["# 42 \"injected.h\"", "# 7 \"flagged.h\" 1", "# 99"] {
        assert!(out.contains(text), "{text} not passed through: {out}");
    }
    // `#line` is a directive in both languages, and renders as a marker.
    assert!(out.contains("# 55 \"real.h\""), "{out}");
    assert!(!out.contains("#line"), "{out}");

    // C input keeps the GNU spelling, which generated sources rely on: the
    // marker is consumed and re-rendered from the tracked position, so the
    // flag digit goes and a file-less form acquires the current file.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let out = pp
        .process("# 7 \"flagged.h\" 1\nint x;\n# 99\nint y;\n")
        .expect("preprocess");
    assert!(
        out.contains("# 7 \"flagged.h\"") && !out.contains(" 1\n"),
        "{out}"
    );
    assert!(out.contains("# 99 \"flagged.h\""), "{out}");
    assert!(pp.warnings.is_empty(), "{:?}", pp.warnings);
}

/// C99 6.10p9: `#` with nothing after it is the null directive,
/// consumed without effect and without diagnostic in either language.
#[test]
fn null_directive_is_silent() {
    for asm in [false, true] {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.set_asm_source(asm);
        let out = pp.process("#\nline1\n").expect("preprocess");
        assert!(out.contains("line1"), "{out}");
        assert!(pp.warnings.is_empty(), "{:?}", pp.warnings);
    }
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

/// C99 6.10.1p4 evaluates `#if` in `intmax_t`, but a character constant
/// enters that evaluation at the type 6.4.4.4p10 gives it -- `int` -- so
/// bytes that fill the width read as a negative value. gcc-16 agrees on
/// every row.
#[test]
fn if_character_constant_narrows_to_int() {
    for (e, want) in [
        (r"'a' == 97", true),
        (r"'ab' == 24930", true),
        (r"'abc' == 6382179", true),
        (r"'abcd' == 1633837924", true),
        (r"'\xF0\x9F\x98\x80' < 0", true),
        (r"'\xF0\x9F\x98\x80' == -257976192", true),
        (r"'\xF0\x9F\x98\x80' == 4036991104", false),
        (r"'\x7F\xFF\xFF\xFF' == 2147483647", true),
        (r"'\x80\x00\x00\x00' == -2147483648", true),
        // Fewer than four bytes cannot reach the sign bit.
        (r"'\xF0\x9F' == 61599", true),
        (r"'\xF0\x9F\x98' == 15769496", true),
    ] {
        let out = process(&format!("#if {e}\nTAKEN\n#else\nNOT\n#endif\n"));
        assert_eq!(out.contains("TAKEN"), want, "{e}: {out}");
    }
}

/// A prefixed character constant holds one code point at the `wchar_t` /
/// `char16_t` / `char32_t` width (C99 6.4.4.4p11), not the UTF-8 bytes an
/// unprefixed one packs. `#if` must read it the way the lexer does
/// outside one, so the same constant cannot mean two things.
#[test]
fn if_prefixed_character_constant_holds_a_code_point() {
    for e in [
        // A hex escape is not truncated to a byte at these widths.
        r"L'\xFFFF' == 65535",
        r"U'\U0001F600' == 128512",
        // Written as a universal character name and as the source's own
        // UTF-8, which both name U+00E9.
        r"L'\U000000E9' == 233",
        r"u'\U000000E9' == 233",
        "L'\u{e9}' == 233",
        // Unprefixed, the same code point packs its UTF-8 bytes.
        "'\u{e9}' == 0xC3A9",
    ] {
        let out = process(&format!("#if {e}\nTAKEN\n#else\nNOT\n#endif\n"));
        assert!(out.contains("TAKEN"), "{e}: {out}");
    }
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
    pp.set_track_includes(true);
    let _ = pp
        .process("#include <not-a-real-header.h>\nint main() { return 0; }\n")
        .expect_err("missing include must fail");
    let trace = trace_lines(&pp);
    assert!(
        trace
            .iter()
            .any(|l| l.starts_with("!") && l.contains("not-a-real-header.h")),
        "trace should mark missing header: {trace:?}"
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
fn foreign_header_sharing_a_bundled_name_keeps_search_path_order() {
    // An OS source tree carries its own `linux/cdrom.h` and
    // `linux/fs.h`, names the embedded registry also has. The tree's
    // cdrom.h is not part of the compiler's own header set, so its
    // `#include <linux/fs.h>` must resolve through `-I` to the tree's
    // fs.h, not be pulled into the embedded set by the closed-set
    // rule. Classification is by the including file's provenance;
    // a spelling collision with a bundled name must not reclassify it.
    let base = std::env::temp_dir().join(format!("badc-ostree-{}", std::process::id()));
    let lnx = base.join("linux");
    std::fs::create_dir_all(&lnx).unwrap();
    std::fs::write(
        lnx.join("cdrom.h"),
        "#ifndef _OS_CDROM_H\n#define _OS_CDROM_H\n#include <linux/fs.h>\n\
         int os_tree_cdrom_marker;\n#endif\n",
    )
    .unwrap();
    std::fs::write(
        lnx.join("fs.h"),
        "#ifndef _OS_FS_H\n#define _OS_FS_H\nint os_tree_fs_marker;\n#endif\n",
    )
    .unwrap();
    let mut pp = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    pp.add_search_path(base.to_str().unwrap());
    let out = pp.process("#include <linux/cdrom.h>\n").unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert!(out.contains("os_tree_cdrom_marker"), "{out}");
    assert!(
        out.contains("os_tree_fs_marker"),
        "the tree's cdrom.h must reach the tree's fs.h:\n{out}"
    );
    assert!(
        !out.contains("file_clone_range"),
        "the embedded linux/fs.h must stay out of a foreign tree's chain:\n{out}"
    );
}

#[test]
fn bundled_header_resolves_bundled_includes_over_search_paths() {
    // The closed-set rule itself: a header served from the embedded
    // set resolves the bundled names it includes within the set, even
    // when a `-I` directory shadows one of them. The embedded
    // `linux/fs.h` includes `<linux/ioctl.h>`; a poisoned copy on the
    // search path must not be spliced into it. The direct include of a
    // name the search path does not carry falls through to the
    // embedded set as before.
    let base = std::env::temp_dir().join(format!("badc-poison-{}", std::process::id()));
    let lnx = base.join("linux");
    std::fs::create_dir_all(&lnx).unwrap();
    std::fs::write(lnx.join("ioctl.h"), "#error poisoned ioctl.h\n").unwrap();
    let mut pp = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    pp.add_search_path(base.to_str().unwrap());
    let out = pp
        .process("#include <linux/fs.h>\n")
        .expect("the embedded fs.h must keep its own ioctl.h");
    std::fs::remove_dir_all(&base).ok();
    assert!(out.contains("file_clone_range"), "{out}");
}

#[test]
fn nostdinc_withdraws_the_bundled_headers_but_keeps_the_compiler_owned_ones() {
    // `-nostdinc` takes the standard library headers off the search, so a
    // name only the bundled set carries stops resolving; a `-I` directory
    // that carries it still does. The compiler's own headers stay
    // reachable, since the flag withdraws the library, not the builtins.
    let base = std::env::temp_dir().join(format!("badc-nostdinc-{}", std::process::id()));
    let sys = base.join("sys");
    std::fs::create_dir_all(&sys).unwrap();
    std::fs::write(sys.join("types.h"), "int tree_types_marker;\n").unwrap();

    let mut off = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    off.process("#include <sys/types.h>\n")
        .expect("the bundled sys/types.h resolves without the flag");

    let mut on = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    on.set_nostdinc(true);
    let err = on
        .process("#include <sys/types.h>\n")
        .expect_err("under -nostdinc no search path carries the name");
    assert!(format!("{err:?}").contains("not found"), "{err:?}");

    let mut named = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    named.set_nostdinc(true);
    named.add_search_path(base.to_str().unwrap());
    let out = named
        .process("#include <sys/types.h>\n")
        .expect("a -I directory still resolves the name");
    assert!(out.contains("tree_types_marker"), "{out}");

    let mut owned = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    owned.set_nostdinc(true);
    let out = owned
        .process("#include <_builtins.h>\nint f(int x) { return __builtin_expect(x, 1); }\n")
        .expect("the __builtin_* thunk header stays reachable");
    std::fs::remove_dir_all(&base).ok();
    assert!(out.contains("return (x);"), "{out}");
}

/// The computed-include macro chain of the tests below: the header
/// name is assembled from a parameter inside `<dir/n.h>`, so a
/// digit-leading argument substitutes as the tokens `1x` `.` `h`.
const COMPUTED_ANGLE: &str = "#define NAME_D 1x\n#define NAME_A ab\n\
                              #define ANGLE_(n) <ev/n.h>\n#define ANGLE(n) ANGLE_(n)\n";

fn computed_include_dir(tag: &str) -> std::path::PathBuf {
    let base = std::env::temp_dir().join(format!("badc-{tag}-{}", std::process::id()));
    let ev = base.join("ev");
    std::fs::create_dir_all(&ev).unwrap();
    std::fs::write(ev.join("1x.h"), "int marker_1x;\n").unwrap();
    std::fs::write(ev.join("ab.h"), "int marker_ab;\n").unwrap();
    base
}

#[test]
fn computed_include_combines_pp_number_spelling() {
    // C99 6.10.2p4: the expanded operand is reparsed as a header
    // name built from the token spellings, a space only where the
    // source had white space. `1x` followed by `.h` must reassemble
    // as `ev/1x.h` (gcc parity); a re-lex separator would misname
    // the file.
    let base = computed_include_dir("cinc");
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_search_path(base.to_str().unwrap());
    let src = format!("{COMPUTED_ANGLE}#include ANGLE(NAME_A)\n#include ANGLE(NAME_D)\n");
    let out = pp.process(&src).unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert!(out.contains("marker_ab"), "{out}");
    assert!(out.contains("marker_1x"), "{out}");
}

#[test]
fn computed_has_include_combines_pp_number_spelling() {
    // C23 6.10.1: a pp-token `__has_include` operand expands and
    // reparses as a header name under the same spelling rule as the
    // computed `#include`.
    let base = computed_include_dir("chas");
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_search_path(base.to_str().unwrap());
    let src = format!(
        "{COMPUTED_ANGLE}#if __has_include(ANGLE(NAME_D))\nint FOUND;\n#else\nint MISSING;\n#endif\n"
    );
    let out = pp.process(&src).unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert!(out.contains("FOUND"), "{out}");
}

#[test]
fn stringize_and_expansion_spacing_around_pp_numbers() {
    // gcc -E parity. `1x.h` is one pp-number (C99 6.4.8), so `#`
    // spells it whole; the substitution-created `1x` `.` `h`
    // adjacency stringizes with no space (C99 6.10.3.2 inserts one
    // only where the argument had white space). Plain expanded text
    // keeps the re-lex separator: `ND.h` prints as `1x .h`, which
    // lexes back to the same three tokens.
    let src = "#define STR_(x) #x\n#define STR(x) STR_(x)\n#define ND 1x\n\
               STR_(1x.h)\nSTR(ND.h)\nSTR_(1x .h)\nSTR(tr/ND.h)\nND.h\n";
    let out = process(src);
    let lines: Vec<&str> = out
        .lines()
        .filter(|l| !l.trim().is_empty() && !l.starts_with('#'))
        .collect();
    assert_eq!(
        lines,
        ["\"1x.h\"", "\"1x.h\"", "\"1x .h\"", "\"tr/1x.h\"", "1x .h"],
        "{out}"
    );
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

/// Recursively collect files under `dir` whose extension is in `exts`.
fn collect_sources(dir: &std::path::Path, exts: &[&str], out: &mut Vec<std::path::PathBuf>) {
    let Ok(entries) = std::fs::read_dir(dir) else {
        return;
    };
    for entry in entries.flatten() {
        let path = entry.path();
        if path.is_dir() {
            collect_sources(&path, exts, out);
        } else if path
            .extension()
            .and_then(|e| e.to_str())
            .is_some_and(|e| exts.contains(&e))
        {
            out.push(path);
        }
    }
}

/// The incremental line-continuation collapse must match the full-rescan
/// reference byte for byte on every C source and header in the tree.
#[test]
fn unfold_matches_reference_on_repo_sources() {
    let root = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    let mut files = Vec::new();
    collect_sources(&root.join("tests/fixtures/c"), &["c"], &mut files);
    collect_sources(&root.join("libc/include"), &["h"], &mut files);
    let mut checked = 0usize;
    for path in &files {
        let Ok(bytes) = std::fs::read(path) else {
            continue;
        };
        // unfold operates on &str; skip any file that is not UTF-8, as
        // the preprocessor requires UTF-8 input in any case.
        let Ok(src) = String::from_utf8(bytes) else {
            continue;
        };
        assert_eq!(
            unfold_line_continuations(&src),
            unfold_ref(&src),
            "unfold mismatch on {}",
            path.display()
        );
        checked += 1;
    }
    assert!(checked > 900, "expected many sources, checked {checked}");
}

/// Differential fuzz: the incremental collapse must match the full-rescan
/// reference on random inputs built from the tokens the scanner tracks
/// (comment openers/closers, quotes, escapes, and CR/LF line endings)
/// plus curated edge cases.
#[test]
fn unfold_matches_reference_fuzz() {
    const CHUNKS: &[&[u8]] = &[
        b"/", b"*", b"\"", b"'", b"\\", b"\n", b"\r", b"\r\n", b" ", b"a", b"b", b"x", b"/*",
        b"*/", b"//", b"\\\n", b"\\\r\n", b"\"\\", b"'\\", b"**", b"*/*", b";",
    ];
    let curated: &[&str] = &[
        "code\\",
        "/* open",
        "/* a\nb\n*/ c",
        "\"str \\\nmore\"",
        "'c' /* x */ y",
        "a // /* \\\nnot open",
        "\"\\\"/*\" real /* open",
        "line1\\\r\nline2 /* c\r\n*/ end",
        "x /*",
        "*/",
        "\\\n\\\n\\\n",
        "/*/",
    ];
    for &c in curated {
        assert_eq!(
            unfold_line_continuations(c),
            unfold_ref(c),
            "unfold mismatch on curated case {c:?}"
        );
    }
    // Deterministic xorshift64; fixed seed keeps failures reproducible.
    let mut state: u64 = 0x9E37_79B9_7F4A_7C15;
    let mut next = || {
        state ^= state << 13;
        state ^= state >> 7;
        state ^= state << 17;
        state
    };
    let cases = 6000;
    for _ in 0..cases {
        let len = (next() % 48) as usize + 1;
        let mut bytes = Vec::new();
        for _ in 0..len {
            bytes.extend_from_slice(CHUNKS[(next() as usize) % CHUNKS.len()]);
        }
        // Every chunk is ASCII, so the join is valid UTF-8.
        let src = String::from_utf8(bytes).unwrap();
        assert_eq!(
            unfold_line_continuations(&src),
            unfold_ref(&src),
            "unfold mismatch on fuzz case {src:?}"
        );
    }
}

/// Scanner work must grow linearly with the size of a multi-line block
/// comment. Contrast the incremental scanner (each byte visited once)
/// with the full-rescan reference (quadratic) via the step counter, so
/// the assertion is exact and cannot flake on timing.
#[test]
fn unfold_block_comment_scan_is_linear() {
    let mk = |lines: usize| {
        let mut s = String::from("/*\n");
        for _ in 0..lines {
            s.push_str("x comment line\n");
        }
        s.push_str("*/\ncode;\n");
        s
    };
    let small = mk(1500);
    let big = mk(3000);

    assert_eq!(unfold_line_continuations(&small), unfold_ref(&small));
    assert_eq!(unfold_line_continuations(&big), unfold_ref(&big));

    let _ = scan_steps_taken();
    unfold_line_continuations(&small);
    let new_small = scan_steps_taken();
    unfold_line_continuations(&big);
    let new_big = scan_steps_taken();
    // Doubling the comment doubles the work, not quadruples it.
    assert!(
        new_big < new_small * 3,
        "incremental scan not linear: {new_small} -> {new_big}"
    );

    unfold_ref(&small);
    let ref_small = scan_steps_taken();
    unfold_ref(&big);
    let ref_big = scan_steps_taken();
    // The reference re-reads the growing buffer on each join, so doubling
    // the comment quadruples its work: the quadratic being removed.
    assert!(
        ref_big > ref_small * 3,
        "reference expected quadratic: {ref_small} -> {ref_big}"
    );
}

/// A single very large block comment must collapse quickly. The
/// pre-incremental full rescan did not finish this in minutes; the
/// incremental scan handles it in milliseconds. The ceiling is generous
/// so a slow machine does not flake while a return to quadratic still
/// trips it.
#[test]
fn unfold_80k_line_block_comment_is_fast() {
    let mut s = String::from("/*\n");
    for _ in 0..80_000 {
        s.push_str("comment\n");
    }
    s.push_str("*/\ncode;\n");
    let start = std::time::Instant::now();
    let out = unfold_line_continuations(&s);
    let elapsed = start.elapsed();
    assert!(elapsed.as_secs() < 20, "unfold too slow: {elapsed:?}");
    // Total line count is preserved by blank padding, and the code past
    // the comment survives.
    assert_eq!(out.matches('\n').count(), s.lines().count());
    assert!(out.contains("code;"));
    // The fused pass walks the same comment once as well.
    let start = std::time::Instant::now();
    let fused = unfold_and_strip(&s);
    let elapsed = start.elapsed();
    assert!(elapsed.as_secs() < 20, "fused pass too slow: {elapsed:?}");
    assert_eq!(fused, strip_c_comments(&out));
}

/// Deterministic pseudo-random source generator for the phase-2 /
/// phase-3 differential tests: emits the byte classes that drive the
/// scanners (quotes, escapes, slashes, stars, newlines, backslash
/// continuations, non-ASCII) at rates high enough to hit every state
/// transition.
fn fuzz_source(seed: u64, len: usize) -> String {
    const ALPHABET: [&str; 20] = [
        "a", " ", "\n", "/", "*", "\"", "'", "\\", "x", "\t", "/*", "*/", "//", "\\\n", ";", "#",
        "define", "(", ")", "\u{e9}",
    ];
    let mut state = seed.wrapping_mul(0x9e37_79b9_7f4a_7c15) | 1;
    let mut s = String::with_capacity(len * 2);
    while s.len() < len {
        state ^= state << 13;
        state ^= state >> 7;
        state ^= state << 17;
        s.push_str(ALPHABET[(state % ALPHABET.len() as u64) as usize]);
    }
    s
}

/// The span-copying `strip_c_comments` must agree byte for byte with
/// the byte-at-a-time reference over every embedded libc header and
/// over 6000 generated sources.
#[test]
fn strip_c_comments_matches_reference_over_corpus_and_fuzz() {
    for (name, body) in crate::c5::headers::embedded_headers() {
        assert_eq!(
            strip_c_comments(body),
            strip_c_comments_ref(body),
            "strip_c_comments diverged on embedded header `{name}`"
        );
    }
    for seed in 0..6000u64 {
        let src = fuzz_source(seed, 200);
        assert_eq!(
            strip_c_comments(&src),
            strip_c_comments_ref(&src),
            "strip_c_comments diverged on seed {seed}: {src:?}"
        );
    }
}

/// `unfold_line_continuations` short-circuits lines that neither
/// continue nor open a block comment; it must still agree with the
/// full-rescan reference over the same corpus and generated sources.
#[test]
fn unfold_matches_reference_over_corpus_and_fuzz() {
    for (name, body) in crate::c5::headers::embedded_headers() {
        assert_eq!(
            unfold_line_continuations(body),
            unfold_ref(body),
            "unfold diverged on embedded header `{name}`"
        );
    }
    for seed in 0..6000u64 {
        let src = fuzz_source(seed, 200);
        assert_eq!(
            unfold_line_continuations(&src),
            unfold_ref(&src),
            "unfold diverged on seed {seed}: {src:?}"
        );
    }
}

/// The fused phase-2 / phase-3 pass must agree byte for byte with the
/// two-pass composition over the header corpus, the fuzz generator, and
/// CR-bearing variants (the generator's alphabet has no `\r`, so CRLF
/// terminators and lone CRs are grafted onto every fuzzed source).
#[test]
fn unfold_and_strip_matches_composition_over_corpus_and_fuzz() {
    let reference = |s: &str| strip_c_comments(&unfold_line_continuations(s));
    for (name, body) in crate::c5::headers::embedded_headers() {
        assert_eq!(
            unfold_and_strip(body),
            reference(body),
            "fused pass diverged on embedded header `{name}`"
        );
    }
    for seed in 0..6000u64 {
        let src = fuzz_source(seed, 200);
        assert_eq!(
            unfold_and_strip(&src),
            reference(&src),
            "fused pass diverged on seed {seed}: {src:?}"
        );
        let crlf = src.replace('\n', "\r\n");
        assert_eq!(
            unfold_and_strip(&crlf),
            reference(&crlf),
            "fused pass diverged on CRLF seed {seed}: {crlf:?}"
        );
        let lone_cr = src.replace('*', "\r");
        assert_eq!(
            unfold_and_strip(&lone_cr),
            reference(&lone_cr),
            "fused pass diverged on lone-CR seed {seed}: {lone_cr:?}"
        );
    }
}

/// Edges the fusion has to get right, locked against literal expected
/// bytes rather than only the reference composition.
#[test]
fn unfold_and_strip_edge_cases() {
    let cases: &[(&str, &str)] = &[
        // A `\`-run followed by empty lines: phase 2 pops one trailing
        // backslash per joined line, reaching back through the run.
        ("x\\\\\n\ny\n", "xy\n\n\n"),
        ("\"ab\\\\\n\nz\n", "\"abz\n\n\n"),
        ("a;\\\\\\\\\n\n\n\nb\n", "a;b\n\n\n\n\n"),
        // A line of backslashes only merges into the deferred run.
        ("x\\\\\n\\\n\ny\n", "xy\n\n\n\n"),
        // Comment openers and closers split across a splice.
        ("a /\\\n* c *\\\n/ b\n", "a   b\n\n\n"),
        ("a /\\\n/ c\nb\n", "a  \n\nb\n"),
        ("/*x*\\\n/y\n", " y\n\n"),
        // A pending `/` whose splice pops the following backslash but
        // no comment forms.
        ("x/\\\nay\n", "x/ay\n\n"),
        ("x/\\\n\nz\n", "x/\n\nz\n"),
        ("x/\\\\\ny\n", "x/\\y\n\n"),
        // Escapes rebuilt across a splice inside a literal.
        ("\"a\\\n\\\"b\"c\n", "\"a\\\"b\"c\n\n"),
        // Unterminated literal ends at its line; the next line's
        // comment is stripped.
        (
            "char *s = \"abc\nint x; /* c */ int y;\n",
            "char *s = \"abc\nint x;   int y;\n",
        ),
        // EOF while joining.
        ("xyz\\", "xyz\n\n"),
        ("x/\\\\", "x/\\\n\n"),
        ("a /* x", "a \n\n "),
        ("a /* x\n", "a \n\n "),
        ("a // x\\", "a  \n\n"),
        ("int a; // t", "int a;  \n"),
        // CRLF: the CR joins the newline in the splice and the line
        // terminator, and survives when no LF follows.
        ("#define M \\\r\n 1\r\nM\r\n", "#define M  1\n\nM\n"),
        ("a\rb\n", "a\rb\n"),
        ("abc\r", "abc\r\n"),
        ("x\\\r", "x\\\r\n"),
        // Degenerate inputs.
        ("", ""),
        ("\n", "\n"),
        ("\\\n", "\n\n"),
        ("\\", "\n\n"),
    ];
    for (src, expect) in cases {
        assert_eq!(unfold_and_strip(src), *expect, "fused output for {src:?}");
        assert_eq!(
            strip_c_comments(&unfold_line_continuations(src)),
            *expect,
            "reference composition disagrees with the expectation for {src:?}"
        );
    }
}

/// Phase 3 must not re-encode source bytes. A non-ASCII byte outside a
/// string or char literal used to be widened from Latin-1 to UTF-8, so
/// the identifier reaching the lexer no longer matched its definition.
#[test]
fn strip_c_comments_preserves_non_ascii_outside_literals() {
    let src = "int \u{e9}v = 1; /* c */ char *s = \"\u{e9}k\";";
    let out = strip_c_comments(src);
    assert!(out.contains('\u{e9}'), "non-ASCII must survive: {out:?}");
    assert_eq!(
        out.matches('\u{e9}').count(),
        2,
        "both occurrences pass through unchanged: {out:?}"
    );
    assert_eq!(process(src).matches('\u{e9}').count(), 2);
}

/// C99 6.10: a directive name is one preprocessing token, so a
/// keyword run together with what follows names no directive. Before
/// the shared word-boundary check only `if`, `elif`, `else`, `endif`,
/// `error` and `warning` enforced it, so `#undefX` silently undefined
/// `X` and `#definex FOO 1` defined a macro named `x`.
#[test]
fn directive_keyword_requires_a_word_boundary() {
    let out = process("#define X 1\n#undefX\nint a = X;\n");
    assert!(
        out.contains("int a = 1;"),
        "`#undefX` must not undefine `X`: {out}"
    );
    let out = process("#definex FOO 1\nint b = x;\n");
    assert!(
        out.contains("int b = x;"),
        "`#definex` must not define `x`: {out}"
    );
    // The boundary rule admits every operand form that is not an
    // identifier continuation.
    assert!(process("#define Y 2\n#if(Y)\nok\n#endif\n").contains("ok"));
    assert!(process("#include<stddef.h>\n").contains("size_t"));
    // And the real spellings still parse.
    let out = process("#define Z 3\n#undef Z\nint c = Z;\n");
    assert!(out.contains("int c = Z;"), "`#undef Z` must work: {out}");
}

/// One builtin table answers all three questions. The three predicates
/// used to be separate hardcoded lists and disagreed: `#pragma
/// intrinsic("__builtin_bswap64")` rejected a name badc lowers, and
/// `__has_builtin(__builtin_trap)` reported 1 for a name that was
/// unusable without <assert.h>. C23 6.10.1 makes `__has_builtin` 1 when
/// the builtin is supported, so the no-header groups below report 1 --
/// as gcc-16 and clang do for the same names -- and the library group,
/// which badc supplies only through its header, reports 0.
#[test]
fn builtin_table_answers_all_three_roles() {
    use super::builtins;
    let pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    // Registry entries usable with no header are seeded, answer 1 to
    // `__has_builtin`, and are accepted by `#pragma intrinsic`.
    for name in [
        "__builtin_clz",
        "__builtin_clzl",
        "__builtin_bswap16",
        "__builtin_bswap32",
        "__builtin_bswap64",
        "__builtin_unreachable",
        "__builtin_trap",
        "__builtin_alloca",
        "__builtin_frame_address",
        "__builtin_va_start",
    ] {
        assert!(pp.intrinsics.contains_key(name), "`{name}` must be seeded");
        assert!(
            builtins::has_builtin(name),
            "__has_builtin({name}) must be 1"
        );
        assert!(
            builtins::intrinsic_id(name, Target::MacOSAarch64).is_some(),
            "`#pragma intrinsic(\"{name}\")` must resolve"
        );
    }
    // Builtins the parser handles have no registry id, yet `#pragma
    // intrinsic` accepts them and `__has_builtin` reports 1.
    for name in [
        "__builtin_constant_p",
        "__builtin_choose_expr",
        "__builtin_types_compatible_p",
        "__builtin_object_size",
        "__builtin_add_overflow",
        "__builtin_expect",
        "__builtin_prefetch",
    ] {
        assert!(
            builtins::has_builtin(name),
            "__has_builtin({name}) must be 1"
        );
        assert!(
            builtins::is_builtin(name),
            "`{name}` must be a known builtin"
        );
        assert!(
            builtins::intrinsic_id(name, Target::MacOSAarch64).is_none(),
            "`{name}` has no registry id"
        );
    }
    // Builtins equivalent to a library function: no registry id, and
    // `__has_builtin` reports 1 as it does in gcc and clang. The
    // library name they bind to is derived from the builtin spelling.
    for (name, fn_name) in [
        ("__builtin_strlen", "strlen"),
        ("__builtin_memcmp", "memcmp"),
        ("__builtin_abs", "abs"),
        ("__builtin_malloc", "malloc"),
    ] {
        assert!(
            builtins::has_builtin(name),
            "__has_builtin({name}) must be 1"
        );
        assert_eq!(
            builtins::library_alias(name),
            Some(fn_name),
            "`{name}` must bind to `{fn_name}`"
        );
        assert!(
            builtins::intrinsic_id(name, Target::MacOSAarch64).is_none(),
            "`{name}` has no registry id"
        );
        assert!(
            !pp.intrinsics.contains_key(name),
            "`{name}` must not be seeded into the registry"
        );
    }
    assert_eq!(builtins::library_alias("__builtin_clz"), None);
    assert_eq!(builtins::library_alias("strlen"), None);
    // Library names a header binds: not seeded and not reported by
    // `__has_builtin`, but `#pragma intrinsic` registers them.
    for name in [
        "alloca",
        "sqrt",
        "fma",
        "atomic_load",
        "__c5_aarch64_setjmp",
    ] {
        assert!(
            !pp.intrinsics.contains_key(name),
            "`{name}` must need its header"
        );
        assert!(
            !builtins::has_builtin(name),
            "__has_builtin({name}) must be 0"
        );
        assert!(
            builtins::intrinsic_id(name, Target::MacOSAarch64).is_some(),
            "`#pragma intrinsic(\"{name}\")` must resolve"
        );
    }
    assert!(!builtins::is_builtin("__builtin_bitreverse32"));
    assert!(!builtins::has_builtin("__builtin_bswap128"));
}

/// The `l`-suffixed bit builtins follow the target's `long` width, and
/// the seeded id matches what `#pragma intrinsic` would record.
#[test]
fn long_width_builtins_track_the_target() {
    use super::builtins;
    use crate::c5::op::Intrinsic;
    for (target, spec, want) in [
        (Target::MacOSAarch64, "macos-aarch64", Intrinsic::Clzll),
        (Target::WindowsX64, "windows-x64", Intrinsic::Clz),
    ] {
        let pp = Preprocessor::new(spec, target, "0.1.0");
        assert_eq!(pp.intrinsics.get("__builtin_clzl"), Some(&(want as i64)));
        assert_eq!(
            builtins::intrinsic_id("__builtin_clzl", target),
            Some(want as i64)
        );
    }
}

/// `#pragma intrinsic` accepts every name in the builtin table. The
/// quoted form used to reject names badc lowers unconditionally.
#[test]
fn pragma_intrinsic_accepts_every_table_name() {
    for name in [
        "__builtin_bswap64",
        "__builtin_unreachable",
        "__builtin_clz",
        "__builtin_expect",
        "__builtin_object_size",
    ] {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.process(&format!("#pragma intrinsic(\"{name}\")\nint x;\n"))
            .unwrap_or_else(|e| panic!("`#pragma intrinsic(\"{name}\")` rejected: {e}"));
    }
    // A name badc does not provide is still a hard error, so a typo is
    // not a silent no-op.
    let err = process_err("#pragma intrinsic(\"__builtin_nope\")\n");
    assert!(err.contains("not a builtin"), "unexpected message: {err}");
}

/// `#ifdef X` and `defined(X)` answer the same question for every name,
/// including the feature-test operators and function-like macros.
#[test]
fn ifdef_and_defined_agree_on_every_name() {
    for name in [
        "__has_include",
        "__has_include_next",
        "__has_builtin",
        "__has_attribute",
        "__builtin_expect",
        "OBJ",
        "FN",
        "NOPE",
    ] {
        let src = format!(
            "#define OBJ 1\n#define FN(a) a\n\
             #ifdef {name}\nifdef_yes\n#endif\n\
             #if defined({name})\ndefined_yes\n#endif\n"
        );
        let out = process(&src);
        assert_eq!(
            out.contains("ifdef_yes"),
            out.contains("defined_yes"),
            "`#ifdef {name}` and `defined({name})` disagree: {out}"
        );
    }
}

/// The `__has_*` and `defined` operand scanners are one scanner, so
/// every spelling of the operand parses the same way.
#[test]
fn operator_operands_accept_the_same_spellings() {
    for form in [
        "__has_attribute(packed)",
        "__has_attribute ( packed )",
        "__has_attribute\t(packed)",
    ] {
        let out = process(&format!("#if {form}\nyes\n#endif\n"));
        assert!(out.contains("yes"), "`{form}` must resolve to 1: {out}");
    }
    // A word-boundary violation is not the operator: the glued name is
    // an ordinary undefined identifier, so the operand is left unparsed.
    let err = process_err("#if x__has_attribute_y(packed)\nyes\n#endif\n");
    assert!(err.contains("(packed)"), "glued name must not match: {err}");
    // Reached through a macro alias, the operator still resolves --
    // that path runs the same scanner after substitution.
    let out = process("#define ALIAS __has_attribute\n#if ALIAS(packed)\nyes\n#endif\n");
    assert!(out.contains("yes"), "alias must resolve: {out}");
}

/// C99 6.10.1p4: `#if` operands are integer constants. The token extent
/// comes from `pp_number_len`, so a pp-number that is not one is
/// diagnosed whole instead of splitting into a number and an identifier.
#[test]
fn if_rejects_non_integer_pp_numbers() {
    for src in [
        "#if 1.5\n#endif\n",
        "#if 1e5\n#endif\n",
        "#if 0x1p+3\n#endif\n",
    ] {
        let err = process_err(src);
        assert!(
            err.contains("not an integer constant") || err.contains("malformed integer"),
            "unexpected diagnostic for {src:?}: {err}"
        );
    }
    // `0x1e+5` is one pp-number, not `0x1e` `+` `5`; gcc-16 and clang
    // both reject it ("invalid suffix `+5` on integer constant") rather
    // than folding it to 35.
    let err = process_err("#if 0x1e+5 == 35\nyes\n#endif\n");
    assert!(err.contains("0x1e+5"), "unexpected diagnostic: {err}");
    // Through a macro the operand is already three tokens, so the sum
    // folds, as it does in both references.
    assert!(process("#define M 0x1e\n#if M+5 == 35\nyes\n#endif\n").contains("yes"));
    // The integer forms still parse, including the suffixes and the
    // widest-unsigned case.
    assert!(process("#if 0x10ULL == 16\nyes\n#endif\n").contains("yes"));
    assert!(process("#if 18446744073709551615U > 0\nyes\n#endif\n").contains("yes"));
    assert!(process("#if 1 << 4 == 16\nyes\n#endif\n").contains("yes"));
}

/// The serializer's adjacency test must cover every two-byte punctuator
/// `punct_len` lexes; a punctuator added to the table without one used
/// to paste silently across an expansion seam.
#[test]
fn merge_test_covers_every_punctuator_pair() {
    use super::expand::pp_tokens_would_merge;
    for a in 0u8..=255 {
        for b in 0u8..=255 {
            if super::expand::punct_len(&[a, b], 0) == 2 {
                assert!(
                    pp_tokens_would_merge(super::expand::TokKind::Punct, &[a], b),
                    "punctuator {:?} is not separated by the serializer",
                    core::str::from_utf8(&[a, b]).unwrap_or("<non-utf8>")
                );
            }
        }
    }
}

/// A pp-number must not absorb what follows it across an expansion seam:
/// `0x10` then `...` re-lexes as one pp-number (C99 6.4.8) unless the
/// serializer separates them. gcc-16 and clang both emit the space.
/// An identifier ending in the same bytes needs no separation.
#[test]
fn serializer_separates_only_real_pastes() {
    let out = process("#define LO 0x10\n#define HI 0x20\nint x[] = { LO...HI };\n");
    assert!(
        out.contains("0x10 ..."),
        "a pp-number must not absorb `...`: {out}"
    );
    let out = process("#define P p\n#define E e\nint y = P->a + E->b + P++ + E++;\n");
    assert!(
        out.contains("p->a + e->b + p++ + e++"),
        "identifiers need no separation before `-`/`+`: {out}"
    );
    // The paste-preventing spaces the byte-level rules do call for.
    let out = process("#define PLUS +\nint z = PLUS+1;\n");
    assert!(out.contains("+ +1"), "`+` `+` must not paste: {out}");
}

/// An encoding prefix and a following literal are two tokens unless `##`
/// joins them (C99 6.10.3.2, 6.10.3.3), so the serializer separates them
/// however the adjacency arises: a literal prefix written before `#param`
/// in the replacement list, or a parameter substituting to the prefix
/// before a literal. gcc-16 emits the same separators.
#[test]
fn serializer_separates_an_encoding_prefix_from_a_literal() {
    for (prefix, sep) in [("L", " "), ("u", " "), ("U", " "), ("u8", " ")] {
        let out = process(&format!("#define S(x) {prefix}#x\nchar *s = S(hi);\n"));
        assert!(
            out.contains(&format!("{prefix}{sep}\"hi\"")),
            "`{prefix}#x` must stay two tokens: {out}"
        );
        let out = process(&format!("#define A(x) x\"s\"\nchar *s = A({prefix});\n"));
        assert!(
            out.contains(&format!("{prefix}{sep}\"s\"")),
            "`{prefix}` before a string literal must stay two tokens: {out}"
        );
    }
    // 6.4.4.4p2 has no `u8` character constant, so `u8` and `'c'` are
    // already two tokens and need no separator.
    for (prefix, sep) in [("L", " "), ("u", " "), ("U", " "), ("u8", "")] {
        let out = process(&format!("#define C(x) x'c'\nchar c = C({prefix});\n"));
        assert!(
            out.contains(&format!("{prefix}{sep}'c'")),
            "`{prefix}` before a character constant: {out}"
        );
    }
    // An identifier that is not an encoding prefix cannot absorb a quote,
    // so no separator is inserted there.
    let out = process("#define S(x) foo#x\nchar *s = S(hi);\n");
    assert!(out.contains("foo\"hi\""), "no gratuitous separator: {out}");
    // `##` is the operator that does join them (6.10.3.3p3).
    let out = process("#define P(a, b) a##b\nchar *s = P(u8, \"hi\");\n");
    assert!(out.contains("u8\"hi\""), "`##` must still paste: {out}");
}

/// `__has_include` resolves through the same code path as `#include`,
/// so the operator cannot answer differently from what the directive
/// would find. The quoted form probes the including file's directory
/// (C99 6.10.2p2); the angle form does not.
#[test]
fn has_include_matches_what_include_resolves() {
    let base = std::env::temp_dir().join(format!("badc-hasincl-{}", std::process::id()));
    let sub = base.join("sub");
    std::fs::create_dir_all(&sub).unwrap();
    std::fs::write(sub.join("beside.h"), "int beside;\n").unwrap();
    std::fs::write(
        sub.join("probe.h"),
        "#if __has_include(\"beside.h\")\n#include \"beside.h\"\n#endif\n\
         #if __has_include(<beside.h>)\nangle_found\n#endif\n",
    )
    .unwrap();
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_search_path(base.to_str().unwrap());
    let out = pp.process("#include <sub/probe.h>\n").unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert!(
        out.contains("int beside;"),
        "quoted `__has_include` must agree with `#include \"...\"`: {out}"
    );
    assert!(
        !out.contains("angle_found"),
        "the angle form must not search the including file's directory: {out}"
    );
}

#[test]
fn compiler_owned_header_resolves_embedded_before_search_paths() {
    // A compiler-owned intrinsic header (arm_neon.h) resolves to the
    // embedded copy even when a `-I` directory holds a same-named file (a
    // foreign toolchain's private include directory folded onto the search
    // path). An ordinary embedded name (stdarg.h) keeps `-I`-shadows-
    // embedded, as gcc and clang do.
    use std::io::Write;
    let dir = std::env::temp_dir().join(format!("badc-owned-hdr-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    std::fs::File::create(dir.join("arm_neon.h"))
        .unwrap()
        .write_all(b"int foreign_neon_marker;\n")
        .unwrap();
    std::fs::File::create(dir.join("stdarg.h"))
        .unwrap()
        .write_all(b"int shadow_stdarg_marker;\n")
        .unwrap();
    let mut pp = Preprocessor::new("linux-aarch64", Target::LinuxAarch64, "0.1.0");
    pp.add_search_path(dir.to_str().unwrap());
    let out = pp
        .process("#include <arm_neon.h>\n#include <stdarg.h>\n")
        .expect("owned + shadowed includes resolve");
    std::fs::remove_dir_all(&dir).ok();
    assert!(
        !out.contains("foreign_neon_marker"),
        "arm_neon.h must resolve to the embedded copy: {out}"
    );
    assert!(
        out.contains("vld1q_u8"),
        "embedded arm_neon.h body expected: {}",
        &out[..out.len().min(400)]
    );
    assert!(
        out.contains("shadow_stdarg_marker"),
        "a -I shadow of stdarg.h must win, as in gcc/clang"
    );
}

/// Scratch directory holding the given (name, body) headers, on the
/// search path of a fresh preprocessor. The caller removes it.
fn pp_with_headers(tag: &str, files: &[(&str, &str)]) -> (Preprocessor, std::path::PathBuf) {
    let base = std::env::temp_dir().join(format!(
        "badc-{tag}-{}-{:?}",
        std::process::id(),
        std::thread::current().id()
    ));
    std::fs::create_dir_all(&base).unwrap();
    for (name, body) in files {
        std::fs::write(base.join(name), body).unwrap();
    }
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.add_search_path(base.to_str().unwrap());
    (pp, base)
}

/// A header wholly wrapped in `#ifndef G` / `#endif` contributes nothing
/// on re-inclusion while `G` is defined, so the repeat `#include` is
/// dropped without reading the file.
#[test]
fn guarded_header_is_included_once() {
    let (mut pp, base) = pp_with_headers(
        "mi-once",
        &[("g.h", "#ifndef G_H\n#define G_H\nint g;\n#endif\n")],
    );
    let out = pp
        .process("#include <g.h>\n#include <g.h>\nint main() {}\n")
        .unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert_eq!(out.matches("int g;").count(), 1, "{out}");
    assert!(out.contains("int main()"), "{out}");
}

/// `#undef` of the controlling macro puts the body back in play: the
/// drop tracks whether the macro is defined, not whether the file has
/// been seen.
#[test]
fn undefining_the_guard_reinstates_the_header() {
    let (mut pp, base) = pp_with_headers(
        "mi-undef",
        &[("g.h", "#ifndef G_H\n#define G_H\nint g;\n#endif\n")],
    );
    let out = pp
        .process("#include <g.h>\n#undef G_H\n#include <g.h>\nint main() {}\n")
        .unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert_eq!(out.matches("int g;").count(), 2, "{out}");
}

/// Anything outside the guard would be lost by dropping the file, so
/// only a wholly wrapped header qualifies.
#[test]
fn partially_guarded_headers_are_reprocessed() {
    for (tag, body, marker, want) in [
        (
            "pre",
            "int lead;\n#ifndef G\n#define G\nint g;\n#endif\n",
            "int lead;",
            2,
        ),
        (
            "post",
            "#ifndef G\n#define G\nint g;\n#endif\nint tail;\n",
            "int tail;",
            2,
        ),
        // Two sibling conditionals: neither wraps the file, and the
        // second never defines `H`, so its body emits on every pass.
        (
            "two",
            "#ifndef G\n#define G\n#endif\n#ifndef H\nint h;\n#endif\n",
            "int h;",
            2,
        ),
    ] {
        let (mut pp, base) = pp_with_headers(&format!("mi-{tag}"), &[("g.h", body)]);
        let out = pp.process("#include <g.h>\n#include <g.h>\n").unwrap();
        std::fs::remove_dir_all(&base).ok();
        assert_eq!(out.matches(marker).count(), want, "{tag}: {out}");
    }
}

/// The guard's own `#else` / `#elif` arm is what runs once the macro is
/// defined, so such a file is not silent on re-inclusion.
#[test]
fn guard_with_an_else_arm_is_reprocessed() {
    for (tag, body) in [
        (
            "else",
            "#ifndef G\n#define G\nint g;\n#else\nint other;\n#endif\n",
        ),
        (
            "elif",
            "#ifndef G\n#define G\nint g;\n#elif 1\nint other;\n#endif\n",
        ),
    ] {
        let (mut pp, base) = pp_with_headers(&format!("mi-{tag}"), &[("g.h", body)]);
        let out = pp.process("#include <g.h>\n#include <g.h>\n").unwrap();
        std::fs::remove_dir_all(&base).ok();
        assert_eq!(out.matches("int g;").count(), 1, "{tag}: {out}");
        assert_eq!(out.matches("int other;").count(), 1, "{tag}: {out}");
    }
    // A nested `#else` inside the guarded body is not the guard's own
    // arm and leaves the file skippable.
    let (mut pp, base) = pp_with_headers(
        "mi-nested-else",
        &[(
            "g.h",
            "#ifndef G\n#define G\n#if 0\nint a;\n#else\nint b;\n#endif\n#endif\n",
        )],
    );
    let out = pp.process("#include <g.h>\n#include <g.h>\n").unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert_eq!(out.matches("int b;").count(), 1, "{out}");
}

/// A `#define` after the guard's `#endif` is a side effect the second
/// inclusion still performs.
#[test]
fn trailing_directive_disqualifies_the_guard() {
    let (mut pp, base) = pp_with_headers(
        "mi-trail",
        &[(
            "g.h",
            "#ifndef G\n#define G\n#endif\n#define N N_BODY\n#undef N\n",
        )],
    );
    let out = pp.process("#include <g.h>\n#include <g.h>\nN\n").unwrap();
    std::fs::remove_dir_all(&base).ok();
    assert!(out.contains("N"), "{out}");
}

/// `#if !defined(G)` is the other spelling of the same test.
#[test]
fn if_not_defined_guard_form_is_recognised() {
    for open in [
        "#if !defined(G_H)",
        "#if !defined G_H",
        "#if ! defined ( G_H )",
        // A trailing comment becomes trailing white space in phase 3.
        "#if !defined(G_H) /* guard */",
    ] {
        let (mut pp, base) = pp_with_headers(
            "mi-ifnd",
            &[("g.h", &format!("{open}\n#define G_H\nint g;\n#endif\n"))],
        );
        let out = pp.process("#include <g.h>\n#include <g.h>\n").unwrap();
        std::fs::remove_dir_all(&base).ok();
        assert_eq!(out.matches("int g;").count(), 1, "{open}: {out}");
    }
    // Operands that are not the plain absence test must not be taken for
    // a guard: the file is processed on every inclusion.
    for open in ["#if !defined(A) && !defined(G_H)", "#if !G_H", "#ifdef G_H"] {
        let (mut pp, base) = pp_with_headers(
            "mi-ifnd-no",
            &[(
                "g.h",
                &format!("{open}\n#define G_H 1\n#else\nint other;\n#endif\n"),
            )],
        );
        let out = pp.process("#include <g.h>\n#include <g.h>\n").unwrap();
        std::fs::remove_dir_all(&base).ok();
        assert!(out.contains("int other;"), "{open}: {out}");
    }
}

/// The cost of a unit that includes one guarded header n times must not
/// scale with the header's size: the repeats are dropped rather than
/// read and scanned. Counted off the include trace, which marks a
/// dropped inclusion `(cached)`, so the claim holds exactly rather than
/// to within timer noise: whatever n is, the body is read once.
#[test]
fn repeat_inclusion_cost_is_independent_of_header_size() {
    let mut body = String::from("#ifndef BIG_H\n#define BIG_H\n");
    for i in 0..500 {
        body.push_str(&format!("int f{i}(void); /* decl {i} */\n"));
    }
    body.push_str("#endif\n");
    let (_, base) = pp_with_headers("mi-cost", &[("big.h", &body)]);
    let dir = base.to_str().unwrap().to_string();
    let once = |n: usize| -> (usize, usize) {
        let src = "#include <big.h>\n".repeat(n);
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.add_search_path(&dir);
        pp.set_track_includes(true);
        pp.process(&src).unwrap();
        let trace = trace_lines(&pp);
        let dropped = trace.iter().filter(|l| l.ends_with("(cached)")).count();
        (trace.len() - dropped, dropped)
    };
    let small = once(4);
    let large = once(16);
    std::fs::remove_dir_all(&base).ok();
    assert_eq!(
        (small, large),
        ((1, 3), (1, 15)),
        "(read, dropped) inclusions: the repeats must be dropped, not \
         re-read and re-scanned",
    );
}

/// C23 6.10.5.2 `__VA_OPT__`: the content survives when the variable arguments
/// hold at least one token and is a placemarker otherwise, including as a `##`
/// operand and under `#`. Every expansion here matches gcc's, which accepts the
/// construct in every language mode.
#[test]
fn va_opt_expands_on_a_non_empty_variadic_tail() {
    let cases: &[(&str, &str, &str)] = &[
        // (definition, invocation, expected tokens)
        (
            "#define TAIL(a, ...) f(a __VA_OPT__(,) __VA_ARGS__)",
            "TAIL(1)",
            "f(1)",
        ),
        (
            "#define TAIL(a, ...) f(a __VA_OPT__(,) __VA_ARGS__)",
            "TAIL(1, 2)",
            "f(1 , 2)",
        ),
        // Present but holding no token: a placemarker, as when omitted.
        (
            "#define TAIL(a, ...) f(a __VA_OPT__(,) __VA_ARGS__)",
            "TAIL(1, )",
            "f(1)",
        ),
        ("#define LEAD(...) __VA_OPT__(x) y", "LEAD()", "y"),
        ("#define LEAD(...) __VA_OPT__(x) y", "LEAD(1)", "x y"),
        // A placemarker on either side of `##` leaves the other operand.
        ("#define PL(a, ...) a##__VA_OPT__(b)", "PL(1)", "1"),
        ("#define PL(a, ...) a##__VA_OPT__(b)", "PL(1, 2)", "1b"),
        ("#define PR(a, ...) __VA_OPT__(b)##a", "PR(1)", "1"),
        ("#define PR(a, ...) __VA_OPT__(b)##a", "PR(1, 2)", "b1"),
        // `#` stringizes the content after argument substitution.
        ("#define STR(...) #__VA_OPT__(a b)", "STR()", "\"\""),
        ("#define STR(...) #__VA_OPT__(a b)", "STR(1)", "\"a b\""),
        ("#define SA(...) #__VA_OPT__(__VA_ARGS__)", "SA()", "\"\""),
        (
            "#define SA(...) #__VA_OPT__(__VA_ARGS__)",
            "SA(1 + 2)",
            "\"1 + 2\"",
        ),
        // Parentheses inside the content are content, not the terminator.
        ("#define PN(...) __VA_OPT__((a, b)) z", "PN()", "z"),
        ("#define PN(...) __VA_OPT__((a, b)) z", "PN(9)", "(a, b) z"),
        // The GNU named-rest spelling reaches the same tail.
        ("#define NR(a, rest...) a __VA_OPT__(,) rest", "NR(1)", "1"),
        (
            "#define NR(a, rest...) a __VA_OPT__(,) rest",
            "NR(1, 2, 3)",
            "1 , 2, 3",
        ),
        (
            "#define IN(...) __VA_OPT__(__VA_ARGS__ ,) end",
            "IN()",
            "end",
        ),
        (
            "#define IN(...) __VA_OPT__(__VA_ARGS__ ,) end",
            "IN(7, 8)",
            "7, 8 , end",
        ),
        // Only special in a variadic replacement list.
        ("#define PLAIN(a) a __VA_OPT__", "PLAIN(1)", "1 __VA_OPT__"),
    ];
    for (def, call, want) in cases {
        let out = process(&format!("{def}\nMARK {call}\n"));
        let got = out
            .lines()
            .find_map(|l| l.trim().strip_prefix("MARK"))
            .unwrap_or_else(|| panic!("no expansion line for {call}: {out}"))
            .trim();
        assert_eq!(got, *want, "{def} / {call}");
    }
}

/// A fresh preprocessor of the fixed test target.
fn reuse_pp() -> Preprocessor {
    Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0")
}

#[test]
fn retry_reuses_the_source_pass_when_the_extension_is_disjoint() {
    // The source's observations (its macros, conditionals, an embedded
    // include, dylib/binding/export pragmas) share nothing with what
    // <string.h> installs, so a re-run that only appends that
    // force-include must reuse the recorded pass -- and match a full
    // re-run in text and side outputs exactly.
    let src = "#include <stdbool.h>\n\
               #define W 3\n\
               #ifdef W\n\
               int picked = W;\n\
               #endif\n\
               #pragma dylib(mylib, \"libmy.so\")\n\
               #pragma binding(mylib::hook, \"hook_impl\")\n\
               #pragma export(picked_up)\n\
               #pragma intrinsic(\"alloca\")\n\
               bool flag = true;\n\
               int untouched_name;\n";
    let (_, cache) = reuse_pp()
        .process_recording(src)
        .expect("recording run succeeds");

    let mut reused = reuse_pp();
    reused.add_force_include("string.h");
    let out_reused = reused
        .process_reusing(&cache)
        .expect("a disjoint extension reuses the pass");

    let mut full = reuse_pp();
    full.add_force_include("string.h");
    let out_full = full.process(src).expect("full run succeeds");

    assert_eq!(out_reused, out_full, "spliced text differs from a full run");
    assert_eq!(reused.warnings, full.warnings);
    assert_eq!(format!("{:?}", reused.dylibs), format!("{:?}", full.dylibs));
    assert_eq!(reused.exports, full.exports);
    assert_eq!(reused.intrinsics, full.intrinsics);
    assert_eq!(reused.entrypoint, full.entrypoint);
    assert_eq!(reused.subsystem, full.subsystem);
}

#[test]
fn retry_reuse_declines_when_the_extension_defines_an_observed_name() {
    // The recorded pass expanded the conditional with `NULL` undefined;
    // <string.h> defines it, so the pass is not reusable.
    let src = "#ifndef NULL\n#define NULL 0\n#endif\nchar *p = NULL;\n";
    let (_, cache) = reuse_pp()
        .process_recording(src)
        .expect("recording run succeeds");
    let mut reused = reuse_pp();
    reused.add_force_include("string.h");
    assert!(
        reused.process_reusing(&cache).is_none(),
        "an observed-name redefinition must fall back to a full run"
    );
}

#[test]
fn retry_reuse_declines_when_the_extension_covers_a_source_include() {
    // The extension once-registers (and pre-defines) what the source's
    // own `#include` supplied, flipping that include from open to skip.
    let src = "#include <stdbool.h>\nbool ok = true;\n";
    let (_, cache) = reuse_pp()
        .process_recording(src)
        .expect("recording run succeeds");
    let mut reused = reuse_pp();
    reused.add_force_include("stdbool.h");
    assert!(
        reused.process_reusing(&cache).is_none(),
        "overlap with the source's own reading must fall back"
    );
}

#[test]
fn retry_reuse_follows_the_counter_position() {
    // A preamble that consumes `__COUNTER__` values shifts every later
    // expansion: reuse must decline for a source that used the counter
    // and engage for one that did not.
    let dir = std::env::temp_dir().join(format!("badc_pp_reuse_{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let hdr = dir.join("ctr.h");
    std::fs::write(&hdr, "int consumed = __COUNTER__;\n").unwrap();

    for (src, engages) in [
        ("int uses = __COUNTER__;\n", false),
        ("int plain = 1;\n", true),
    ] {
        let (_, cache) = reuse_pp()
            .process_recording(src)
            .expect("recording run succeeds");
        let mut reused = reuse_pp();
        reused.add_search_path(dir.to_str().unwrap());
        reused.add_force_include("ctr.h");
        let got = reused.process_reusing(&cache);
        if engages {
            let mut full = reuse_pp();
            full.add_search_path(dir.to_str().unwrap());
            full.add_force_include("ctr.h");
            let out_full = full.process(src).expect("full run succeeds");
            assert_eq!(got.expect("counter unused: pass reusable"), out_full);
        } else {
            assert!(
                got.is_none(),
                "a shifted counter the source read must fall back"
            );
        }
    }
    std::fs::remove_file(&hdr).ok();
    std::fs::remove_dir(&dir).ok();
}

/// C99 6.10 makes the directive name one preprocessing token: a longer
/// identifier names no directive, and a punctuator ends the name the way
/// white space does. gcc and clang reject `#elseelse`, read `#else(x)`
/// as `#else`, and report `#error(x)` as the diagnostic `(x)`.
#[test]
fn a_directive_name_is_one_preprocessing_token() {
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let out = pp
        .process("#if 1\nA\n#elseelse\nB\n#endif\n")
        .expect("preprocess");
    assert!(out.contains('A') && out.contains('B'), "{out}");
    assert!(
        pp.warnings.iter().any(|w| w.contains("`#elseelse`")),
        "{:?}",
        pp.warnings
    );

    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let err = pp
        .process("#if 1\nA\n#endifendif\n")
        .expect_err("the conditional stays open");
    assert!(format!("{err}").contains("unterminated"), "{err}");

    // A punctuator after the name leaves the directive with an operand.
    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    let out = pp
        .process("#if 0\nA\n#else(x)\nB\n#endif(y)\n")
        .expect("preprocess");
    assert!(!out.contains('A') && out.contains('B'), "{out}");
    assert!(pp.warnings.is_empty(), "{:?}", pp.warnings);

    let err = process_err("#error(x)\n");
    assert!(err.contains("#error (x)"), "{err}");

    let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
    pp.process("#warning(x)\nint v;\n").expect("preprocess");
    assert!(
        pp.warnings.iter().any(|w| w.contains("#warning (x)")),
        "{:?}",
        pp.warnings
    );
}

/// The directive a `#` line names, as a stable label.
fn directive_kind(line: &str) -> &'static str {
    match parse_directive(line, false) {
        Directive::Define(..) => "define",
        Directive::DefineFn(..) => "define-fn",
        Directive::Undef(_) => "undef",
        Directive::Ifdef(_) => "ifdef",
        Directive::Ifndef(_) => "ifndef",
        Directive::If(_) => "if",
        Directive::Elif(_) => "elif",
        Directive::Else => "else",
        Directive::Endif => "endif",
        Directive::Pragma(_) => "pragma",
        Directive::Include { .. } => "include",
        Directive::IncludeNext { .. } => "include_next",
        Directive::IncludeMacro(_) => "include-macro",
        Directive::Line { .. } => "line",
        Directive::LineMacro(_) => "line-macro",
        Directive::Error(_) => "error",
        Directive::Warning(_) => "warning",
        Directive::Shebang => "shebang",
        Directive::Other => "other",
    }
}

/// Directive recognition, including the spellings that share a prefix
/// with another directive. The whole name decides, so the answer cannot
/// depend on the order the names are tried in.
#[test]
fn directives_are_recognised_by_their_whole_name() {
    for (line, want) in [
        ("define A 1", "define"),
        ("define A(x) x", "define-fn"),
        ("defined A", "other"),
        ("undef A", "undef"),
        ("undefine A", "other"),
        ("if 1", "if"),
        ("ifdef A", "ifdef"),
        ("ifndef A", "ifndef"),
        ("ifdefined(A)", "other"),
        ("elif 1", "elif"),
        // C23 spells a `defined` conditional this way; badc has no such
        // directive, and `elif` must not swallow the name.
        ("elifdef A", "other"),
        ("else", "else"),
        ("elseelse", "other"),
        ("endif", "endif"),
        ("endif GUARD", "endif"),
        ("endifendif", "other"),
        ("pragma once", "pragma"),
        ("pragmatic", "other"),
        ("include <stdio.h>", "include"),
        ("include \"a.h\"", "include"),
        ("include HEADER", "include-macro"),
        ("include_next <stdio.h>", "include_next"),
        ("include_nextx <stdio.h>", "other"),
        ("includex <stdio.h>", "other"),
        ("line 5", "line"),
        ("line 5 \"a.c\"", "line"),
        ("line LINENO", "line-macro"),
        ("linear 5", "other"),
        ("error boom", "error"),
        ("errors boom", "other"),
        ("warning careful", "warning"),
        ("warnings careful", "other"),
        ("1 \"a.c\"", "line"),
        ("!/usr/bin/env badc", "shebang"),
        ("", "other"),
    ] {
        assert_eq!(directive_kind(line), want, "#{line}");
    }
}

/// C99 6.10.3.1p1: a parameter next to `#` or `##` substitutes its
/// argument unexpanded, every other position substitutes it expanded.
/// `subst` decides that twice -- once to count the plain uses whose
/// memoized expansion can be moved rather than cloned, once while
/// substituting -- and the two must agree.
#[test]
fn a_parameter_position_reads_the_same_argument_twice() {
    let out = process("#define V 7\n#define M(a) #a | a | a ## Z | a | Q ## a\nM(V)\n");
    let line = out.lines().last().expect("output");
    assert_eq!(line.replace(' ', ""), "\"V\"|7|VZ|7|QV", "{out}");
}

/// `#pragma export` and `#pragma dylib` keep declaration order and
/// admit each name once; the export tables and the import records are
/// written in that order.
#[test]
fn export_and_dylib_declarations_are_ordered_and_unique() {
    let mut pp = Preprocessor::new("linux-x64", Target::LinuxX64, "0.1.0");
    pp.process(
        "#pragma export(beta)\n#pragma export(alpha)\n#pragma export(beta)\n\
         #pragma dylib(libb, \"libb.so\")\n#pragma dylib(liba, \"liba.so\")\n\
         #pragma dylib(libb, \"libb.so\")\n#pragma binding(liba::f, \"f_impl\")\n",
    )
    .expect("preprocess");
    assert_eq!(pp.exports, ["beta", "alpha"]);
    let names: Vec<&str> = pp.dylibs.iter().map(|d| d.name.as_str()).collect();
    assert_eq!(names, ["libb", "liba"]);
    assert_eq!(pp.dylibs[1].bindings.len(), 1);
    assert!(pp.dylibs[0].bindings.is_empty());
}

/// The lexed-body cache is keyed by macro name; a redefinition must
/// re-lex even when the new body is the same length as the old.
#[test]
fn a_redefinition_replaces_the_cached_body() {
    let out = process("#define X 111\nX\n#define X 222\nX\n");
    assert!(out.contains("111") && out.contains("222"), "{out}");
    let out = process("#define M(a) (a + 1)\nM(9)\n#undef M\n#define M(a) (a - 1)\nM(9)\n");
    assert!(out.contains("(9 + 1)") && out.contains("(9 - 1)"), "{out}");
}

const PREDEFINE_TARGETS: [(&str, Target); 5] = [
    ("linux-x64", Target::LinuxX64),
    ("linux-aarch64", Target::LinuxAarch64),
    ("macos-aarch64", Target::MacOSAarch64),
    ("windows-x64", Target::WindowsX64),
    ("windows-aarch64", Target::WindowsAarch64),
];

/// `Preprocessor::new` installs exactly the predefine rows covering the
/// unit's target, and no row it does not cover unless another row of the
/// same name does.
#[test]
fn the_predefine_table_drives_every_target() {
    for (spec, target) in PREDEFINE_TARGETS {
        let pp = Preprocessor::new(spec, target, "0.1.0");
        for (on, rows) in PREDEFINES {
            for (name, body) in *rows {
                if on.covers(target) {
                    assert_eq!(
                        pp.macros.get(*name).map(String::as_str),
                        Some(*body),
                        "{spec} {name}"
                    );
                } else if !PREDEFINES
                    .iter()
                    .any(|(o, r)| o.covers(target) && r.iter().any(|(n, _)| n == name))
                {
                    assert!(!pp.macros.contains_key(*name), "{spec} defines {name}");
                }
            }
        }
    }
}

/// The target-keyed predefines, per target, in both directions: a name
/// its target defines with that body and no other target defines at all.
/// Adding one here is a promise about that target's surface.
#[test]
fn target_predefines_are_locked() {
    const AARCH64: &[(&str, &str)] = &[
        ("__aarch64__", "1"),
        ("__arm64__", "1"),
        ("__AARCH64EL__", "1"),
    ];
    const X86_64: &[(&str, &str)] = &[("__SEG_FS", "1"), ("__SEG_GS", "1")];
    const MACOS: &[(&str, &str)] = &[
        ("__APPLE__", "1"),
        ("__MACH__", "1"),
        ("__ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__", "110000"),
    ];
    const LINUX: &[(&str, &str)] = &[
        ("__linux__", "1"),
        ("__unix__", "1"),
        ("__GLIBC__", "2"),
        ("__GLIBC_MINOR__", "17"),
        ("_DEFAULT_SOURCE", "1"),
        ("_POSIX_SOURCE", "1"),
        ("_POSIX_C_SOURCE", "200809L"),
    ];
    const WINDOWS: &[(&str, &str)] = &[
        ("_WIN32", "1"),
        ("_WIN64", "1"),
        ("__BADC_WINDOWS__", "1"),
        ("__int8", "char"),
        ("__int16", "short"),
        ("__int32", "int"),
        ("__int64", "long long"),
    ];
    let every: Vec<(&str, &str)> = AARCH64
        .iter()
        .chain(X86_64)
        .chain(MACOS)
        .chain(LINUX)
        .chain(WINDOWS)
        .copied()
        .collect();
    for (spec, target) in PREDEFINE_TARGETS {
        let want: Vec<(&str, &str)> = match target {
            Target::LinuxX64 => X86_64.iter().chain(LINUX).copied().collect(),
            Target::LinuxAarch64 => AARCH64.iter().chain(LINUX).copied().collect(),
            Target::MacOSAarch64 => AARCH64.iter().chain(MACOS).copied().collect(),
            Target::WindowsX64 => X86_64.iter().chain(WINDOWS).copied().collect(),
            Target::WindowsAarch64 => AARCH64.iter().chain(WINDOWS).copied().collect(),
        };
        let pp = Preprocessor::new(spec, target, "0.1.0");
        for (name, _) in &every {
            let got = pp.macros.get(*name).map(String::as_str);
            let expect = want.iter().find(|(n, _)| n == name).map(|(_, b)| *b);
            assert_eq!(got, expect, "{spec} {name}");
        }
        // Plain `char`'s signedness and `long double`'s storage size
        // follow the target ABI, so their predefines do too.
        assert_eq!(
            pp.macros.contains_key("__CHAR_UNSIGNED__"),
            !target.plain_char_signed(),
            "{spec} __CHAR_UNSIGNED__"
        );
        assert_eq!(
            pp.macros.get("__SIZEOF_LONG_DOUBLE__").map(String::as_str),
            Some(target.long_double().size().to_string().as_str()),
            "{spec} __SIZEOF_LONG_DOUBLE__"
        );
    }
}

//! The two inline linkage models, over the full declaration matrix.
//!
//! C99 6.7.4p6-p7: if every file-scope declaration of a function
//! includes `inline` and none includes `extern`, the definition in that
//! translation unit is an inline definition and provides no external
//! definition; otherwise it provides one.
//!
//! GNU89 (`__attribute__((gnu_inline))`, `-fgnu89-inline`): `extern
//! inline` is inline-only and provides no external definition; a plain
//! `inline` provides one. A declaration spelling `inline` without
//! `extern` cancels the inline-only form back to a standalone
//! definition.
//!
//! The two rules are inverted, so every cell below is spelled out. Each
//! case asserts what the emitted object holds for the name: an external
//! definition, a unit-local definition, or nothing.
//!
//! Where badc emits [`Sym::Local`] gcc emits an undefined reference:
//! badc materialises the inline definition it already holds rather than
//! leaving a reference that only links when the program supplies an
//! out-of-line copy. C99 6.7.4p6 permits that outright ("an alternative
//! to an external definition, which a translator may use to implement
//! any call to the function in the same translation unit"); it also
//! keeps a call the inliner declined from becoming an undefined symbol.
//! The name is never externally visible in either model, which is the
//! property the link depends on.

use crate::c5::compiler::CompileOptions;
use crate::c5::linker::{NativeSymSection, parse_native_elf};
use crate::c5::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};

/// What the object holds for the probed name.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Sym {
    /// `STB_GLOBAL` definition -- an external definition.
    External,
    /// `STB_LOCAL` definition -- no external definition.
    Local,
    /// No entry at all.
    Absent,
}

/// Unit default inline model.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Model {
    C99,
    /// `-fgnu89-inline`.
    Gnu89,
}

/// Compile `src` for linux-x64 as a relocatable object and report what
/// it holds for `f`.
fn probe(src: &str, model: Model, optimize: bool) -> Sym {
    let copts = CompileOptions {
        no_entry_point: true,
        gnu: true,
        gnu89_inline: model == Model::Gnu89,
        optimize,
        ..Default::default()
    };
    let program = Compiler::with_options(src.to_string(), Target::LinuxX64, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        optimize,
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    const STB_LOCAL: u8 = 0;
    match obj
        .symbols
        .iter()
        .find(|s| s.name == "f" && s.section != NativeSymSection::Undef)
    {
        Some(s) if s.binding == STB_LOCAL => Sym::Local,
        Some(_) => Sym::External,
        None => Sym::Absent,
    }
}

/// `__attribute__((gnu_inline))` spelling injected into a definition's
/// declaration specifiers for the per-function selector column.
const GNU_ATTR: &str = "__attribute__((__gnu_inline__)) ";

/// Declaration shapes, `{A}` standing for the per-function `gnu_inline`
/// selector.
const SHAPES: &[(&str, &str)] = &[
    ("inline", "{A}inline int f(int x) { return x + 1; }\n"),
    (
        "extern inline",
        "extern {A}inline int f(int x) { return x + 1; }\n",
    ),
    (
        "static inline",
        "static {A}inline int f(int x) { return x + 1; }\n",
    ),
    (
        "inline def + non-inline decl",
        "{A}inline int f(int x) { return x + 1; }\nint f(int x);\n",
    ),
    (
        "inline def + extern decl",
        "{A}inline int f(int x) { return x + 1; }\nextern int f(int x);\n",
    ),
    (
        "extern decl + inline def",
        "extern int f(int x);\n{A}inline int f(int x) { return x + 1; }\n",
    ),
    (
        "extern inline decl + inline def",
        "extern {A}inline int f(int);\n{A}inline int f(int x) { return x + 1; }\n",
    ),
    (
        "inline decl + extern inline def",
        "{A}inline int f(int);\nextern {A}inline int f(int x) { return x + 1; }\n",
    ),
    (
        "extern inline def + inline decl",
        "extern {A}inline int f(int x) { return x + 1; }\n{A}inline int f(int);\n",
    ),
    (
        "extern inline def + non-inline decl",
        "extern {A}inline int f(int x) { return x + 1; }\nint f(int);\n",
    ),
];

/// Reference use of the name, appended to the shape.
const USES: &[(&str, &str)] = &[
    ("called", "int g(int x) { return f(x); }\n"),
    ("address taken", "int (*p)(int) = f;\n"),
    ("neither", ""),
];

/// Expected `(called, address taken, neither)` per shape, in `SHAPES`
/// order, for each of the three ways of selecting a model.
const C99_DEFAULT: &[(Sym, Sym, Sym)] = &[
    (Sym::Local, Sym::Local, Sym::Absent),
    (Sym::External, Sym::External, Sym::External),
    (Sym::Local, Sym::Local, Sym::Absent),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
];

const GNU89: &[(Sym, Sym, Sym)] = &[
    (Sym::External, Sym::External, Sym::External),
    (Sym::Local, Sym::Local, Sym::Absent),
    (Sym::Local, Sym::Local, Sym::Absent),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::Local, Sym::Local, Sym::Absent),
];

fn check_matrix(label: &str, attr: &str, model: Model, expect: &[(Sym, Sym, Sym)]) {
    assert_eq!(SHAPES.len(), expect.len(), "{label}: expectation length");
    for (shape_idx, (shape_name, shape)) in SHAPES.iter().enumerate() {
        let row = expect[shape_idx];
        let want = [row.0, row.1, row.2];
        for (use_idx, (use_name, use_src)) in USES.iter().enumerate() {
            let src = shape.replace("{A}", attr) + use_src;
            let got = probe(&src, model, false);
            assert_eq!(
                got, want[use_idx],
                "{label} / {shape_name} / {use_name}\n{src}"
            );
        }
    }
}

#[test]
fn c99_inline_model_is_the_default() {
    check_matrix("C99 default", "", Model::C99, C99_DEFAULT);
}

#[test]
fn gnu_inline_attribute_selects_the_gnu89_model_per_function() {
    check_matrix("gnu_inline attribute", GNU_ATTR, Model::C99, GNU89);
}

#[test]
fn fgnu89_inline_selects_the_gnu89_model_for_the_unit() {
    check_matrix("-fgnu89-inline", "", Model::Gnu89, GNU89);
}

#[test]
fn gnu_inline_attribute_is_a_no_op_under_fgnu89_inline() {
    check_matrix("-fgnu89-inline + attribute", GNU_ATTR, Model::Gnu89, GNU89);
}

#[test]
fn static_inline_is_internal_in_both_models() {
    // The third `SHAPES` row, pinned on its own: `static` decides
    // linkage before either inline model is consulted.
    let src = "static inline int f(int x) { return x + 1; }\nint g(int x) { return f(x); }\n";
    assert_eq!(probe(src, Model::C99, false), Sym::Local);
    assert_eq!(probe(src, Model::Gnu89, false), Sym::Local);
}

#[test]
fn always_inline_alone_does_not_make_a_definition_inline() {
    // `always_inline` is a request to the inliner, not the `inline`
    // function specifier: the definition still provides the external
    // definition under either model.
    let src = "__attribute__((always_inline)) int f(int x) { return x + 1; }\n\
               int g(int x) { return f(x); }\n";
    assert_eq!(probe(src, Model::C99, false), Sym::External);
    assert_eq!(probe(src, Model::Gnu89, false), Sym::External);
}

#[test]
fn gnu_inline_attribute_on_any_declaration_selects_the_model() {
    // The attribute is a property of the function, not of the
    // declaration carrying it, so either placement decides.
    let on_decl = "extern __attribute__((__gnu_inline__)) inline int f(int);\n\
                   extern inline int f(int x) { return x + 1; }\n\
                   int g(int x) { return f(x); }\n";
    let on_def = "extern inline int f(int);\n\
                  extern __attribute__((__gnu_inline__)) inline int f(int x) { return x + 1; }\n\
                  int g(int x) { return f(x); }\n";
    let trailing = "extern inline int f(int x) __attribute__((__gnu_inline__));\n\
                    extern inline int f(int x) { return x + 1; }\n\
                    int g(int x) { return f(x); }\n";
    for src in [on_decl, on_def, trailing] {
        assert_eq!(probe(src, Model::C99, false), Sym::Local, "{src}");
    }
}

#[test]
fn an_inline_only_body_is_still_available_to_the_inliner() {
    // The out-of-line copy is dropped once every call is absorbed, and
    // an `always_inline` request is honored even though the definition
    // provides no external definition.
    let src = "extern __attribute__((__gnu_inline__)) inline \
               __attribute__((always_inline)) int f(int x) { return x + 1; }\n\
               int g(int x) { return f(x); }\n";
    assert_eq!(probe(src, Model::C99, true), Sym::Absent);
}

#[test]
fn used_keeps_an_inline_only_body_without_exporting_it() {
    // `used` keeps the definition in the object; the inline model still
    // decides whether the name is externally visible, so the kept copy
    // is unit-local.
    let src = "extern __attribute__((__gnu_inline__)) inline __attribute__((used)) \
               int f(int x) { return x + 1; }\n";
    assert_eq!(probe(src, Model::C99, false), Sym::Local);
}

#[test]
fn an_inline_only_definition_does_not_collide_with_an_out_of_line_copy() {
    // The header shape a GNU89 inline-only definition exists for: an
    // `extern inline` prototype, an `extern inline` body carrying the
    // mandatory-inline request, and the real out-of-line definition
    // somewhere else in the program. No unit that includes the header
    // may emit an external definition of the name.
    let src = "#define __gnu_inline __attribute__((__gnu_inline__))\n\
               #define inline inline __gnu_inline\n\
               #define __always_inline inline __attribute__((__always_inline__))\n\
               extern inline unsigned long read_flags(void);\n\
               extern __always_inline unsigned long read_flags(void)\n\
               { unsigned long v; __asm__ volatile(\"pushf ; pop %0\"\n\
                 : \"=rm\"(v) : : \"memory\"); return v; }\n\
               int probe(void) { return (int)read_flags(); }\n";
    for optimize in [false, true] {
        let copts = CompileOptions {
            no_entry_point: true,
            gnu: true,
            optimize,
            ..Default::default()
        };
        let program = Compiler::with_options(src.to_string(), Target::LinuxX64, copts)
            .compile()
            .expect("compile");
        let opts = NativeOptions {
            optimize,
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        const STB_LOCAL: u8 = 0;
        assert!(
            obj.symbols.iter().all(|s| s.name != "read_flags"
                || s.binding == STB_LOCAL
                || s.section == NativeSymSection::Undef),
            "optimize={optimize}: the inline-only body must not be an external definition"
        );
    }
}

#[test]
fn an_uninlined_inline_only_call_binds_to_the_unit_local_body() {
    // A call the inliner does not absorb resolves against the copy the
    // unit already holds rather than an undefined symbol.
    let src = "extern __attribute__((__gnu_inline__)) inline int f(int x) { return x + 1; }\n\
               int (*p)(int) = f;\n";
    assert_eq!(probe(src, Model::C99, true), Sym::Local);
}

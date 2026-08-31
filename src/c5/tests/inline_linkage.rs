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
//! case asserts what the emitted object holds for the name against two
//! tables: badc's answer, and the one gcc 16.1.1 and clang 21 both give
//! for the same source on linux-x64 `-c`.
//!
//! The tables differ under one rule. For a *called* inline definition
//! badc emits a unit-local body where those two leave an undefined
//! reference; every other cell agrees, including every absent one. C99
//! 6.7.4p6 permits it ("an alternative to an external definition, which
//! a translator may use to implement any call to the function in the
//! same translation unit"), and badc's code generation relies on it:
//! the inliner runs only under `-O`, and `always_inline` is a warning
//! rather than an error when the candidate filter declines it, so
//! dropping the body would leave undefined the calls gcc resolves by
//! inlining them unconditionally.
//!
//! That licence covers calls, not the address: `f` keeps external
//! linkage, so C99 6.2.2p2 requires `&f` to denote one function across
//! the program. The body is therefore emitted under the private name
//! `f.inline`, which no C identifier can spell, and the identifier
//! stays an undefined external reference that every address site
//! relocates against. The address cells consequently agree with gcc and
//! clang, and a program that takes the address without defining the
//! function anywhere fails to link, as it does under both.

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
    /// An undefined reference, to be satisfied by another unit.
    Undef,
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

/// Private name an inline definition of `f` emits its body under.
const BODY: &str = "f.inline";

/// Compile `src` for linux-x64 as a relocatable object and report what
/// it holds for `f`. An inline definition splits the two: the body binds
/// [`BODY`] and the identifier carries only the cross-unit reference, so
/// the identifier's own entry is reported when it has one and the body
/// fills in the row when nothing references the identifier.
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
    // A definition outranks an undefined entry for the same name.
    let defined = |name: &str| {
        obj.symbols
            .iter()
            .find(|s| s.name == name && s.section != NativeSymSection::Undef)
    };
    if let Some(s) = defined("f") {
        return if s.binding == STB_LOCAL {
            Sym::Local
        } else {
            Sym::External
        };
    }
    if obj.symbols.iter().any(|s| s.name == "f") {
        return Sym::Undef;
    }
    if defined(BODY).is_some() {
        return Sym::Local;
    }
    Sym::Absent
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
    (Sym::Local, Sym::Undef, Sym::Absent),
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
    (Sym::Local, Sym::Undef, Sym::Absent),
    (Sym::Local, Sym::Local, Sym::Absent),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::Local, Sym::Undef, Sym::Absent),
];

/// gcc 16.1.1 and clang 21 on the same shapes, `-std=gnu99 -O0 -c`.
/// Both give these, so one table stands for the pair.
const C99_REFERENCE: &[(Sym, Sym, Sym)] = &[
    (Sym::Undef, Sym::Undef, Sym::Absent),
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

/// The same pair under `-fgnu89-inline`, and under the per-function
/// attribute, which agree cell for cell.
const GNU89_REFERENCE: &[(Sym, Sym, Sym)] = &[
    (Sym::External, Sym::External, Sym::External),
    (Sym::Undef, Sym::Undef, Sym::Absent),
    (Sym::Local, Sym::Local, Sym::Absent),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::External, Sym::External, Sym::External),
    (Sym::Undef, Sym::Undef, Sym::Absent),
];

/// Assert badc's cell, and that it stands in the one permitted relation
/// to the reference: equal, or badc's unit-local body implementing a
/// call against their undefined reference. Returns the number of cells
/// in the latter. An address cell must agree outright -- C99 6.2.2p2
/// leaves no licence there.
fn check_matrix(
    label: &str,
    attr: &str,
    model: Model,
    expect: &[(Sym, Sym, Sym)],
    reference: &[(Sym, Sym, Sym)],
) -> usize {
    assert_eq!(SHAPES.len(), expect.len(), "{label}: expectation length");
    assert_eq!(SHAPES.len(), reference.len(), "{label}: reference length");
    let mut diverged = 0;
    for (shape_idx, (shape_name, shape)) in SHAPES.iter().enumerate() {
        let row = expect[shape_idx];
        let want = [row.0, row.1, row.2];
        let refrow = reference[shape_idx];
        let refs = [refrow.0, refrow.1, refrow.2];
        for (use_idx, (use_name, use_src)) in USES.iter().enumerate() {
            let src = shape.replace("{A}", attr) + use_src;
            let got = probe(&src, model, false);
            assert_eq!(
                got, want[use_idx],
                "{label} / {shape_name} / {use_name}\n{src}"
            );
            let want_ref = refs[use_idx];
            if got == want_ref {
                continue;
            }
            assert!(
                got == Sym::Local && want_ref == Sym::Undef && *use_name == "called",
                "{label} / {shape_name} / {use_name}: badc {got:?} against \
                 gcc/clang {want_ref:?} is not the documented divergence\n{src}"
            );
            diverged += 1;
        }
    }
    diverged
}

#[test]
fn c99_inline_model_is_the_default() {
    // Only the inline definition's called cell diverges.
    let n = check_matrix("C99 default", "", Model::C99, C99_DEFAULT, C99_REFERENCE);
    assert_eq!(n, 1);
}

#[test]
fn ordinary_definition_after_an_extern_inline_body_is_the_external_one() {
    // gcc's gnu_inline contract: the extern-inline body serves only
    // inlining, and the same unit may provide the ordinary definition,
    // which is what the kernel's fortified string helpers do -- an
    // extern gnu_inline wrapper in the header, the real definition in
    // the unit. The identifier must bind an external definition.
    let src = "extern __attribute__((__gnu_inline__)) inline int f(int x) { return x + 1; }\n\
               int f(int x) { return x + 2; }\n\
               int g(int x) { return f(x); }\n";
    for model in [Model::C99, Model::Gnu89] {
        for optimize in [false, true] {
            assert_eq!(
                probe(src, model, optimize),
                Sym::External,
                "{model:?} -O={optimize}"
            );
        }
    }
}

#[test]
fn gnu_inline_attribute_selects_the_gnu89_model_per_function() {
    let n = check_matrix(
        "gnu_inline attribute",
        GNU_ATTR,
        Model::C99,
        GNU89,
        GNU89_REFERENCE,
    );
    assert_eq!(n, 2);
}

#[test]
fn fgnu89_inline_selects_the_gnu89_model_for_the_unit() {
    let n = check_matrix("-fgnu89-inline", "", Model::Gnu89, GNU89, GNU89_REFERENCE);
    assert_eq!(n, 2);
}

#[test]
fn gnu_inline_attribute_is_a_no_op_under_fgnu89_inline() {
    let n = check_matrix(
        "-fgnu89-inline + attribute",
        GNU_ATTR,
        Model::Gnu89,
        GNU89,
        GNU89_REFERENCE,
    );
    assert_eq!(n, 2);
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
    // provides no external definition. Without `-O` the inliner does not
    // run, so the body stays and the call binds to it -- the cell that
    // would leave a call undefined under gcc's linkage rule.
    let src = "extern __attribute__((__gnu_inline__)) inline \
               __attribute__((always_inline)) int f(int x) { return x + 1; }\n\
               int g(int x) { return f(x); }\n";
    assert_eq!(probe(src, Model::C99, true), Sym::Absent);
    assert_eq!(probe(src, Model::C99, false), Sym::Local);
}

#[test]
fn used_keeps_an_inline_only_body_without_exporting_it() {
    // `used` keeps the definition in the object; the inline model still
    // decides whether the name is externally visible, so the kept copy
    // is unit-local. gcc and clang leave the reference undefined under
    // both models, `used` or not.
    let src = "extern __attribute__((__gnu_inline__)) inline __attribute__((used)) \
               int f(int x) { return x + 1; }\n";
    assert_eq!(probe(src, Model::C99, false), Sym::Local);
    let c99_called = "inline __attribute__((used)) int f(int x) { return x + 1; }\n\
                      int g(int x) { return f(x); }\n";
    assert_eq!(probe(c99_called, Model::C99, false), Sym::Local);
    let gnu89_called = "extern inline __attribute__((used)) int f(int x) { return x + 1; }\n\
                        int g(int x) { return f(x); }\n";
    assert_eq!(probe(gnu89_called, Model::Gnu89, false), Sym::Local);
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
            obj.symbols.iter().all(
                |s| (s.name != "read_flags" && s.name != "read_flags.inline")
                    || s.binding == STB_LOCAL
                    || s.section == NativeSymSection::Undef
            ),
            "optimize={optimize}: the inline-only body must not be an external definition"
        );
    }
}

#[test]
fn an_uninlined_inline_only_call_binds_to_the_unit_local_body() {
    // A call the inliner does not absorb resolves against the copy the
    // unit already holds rather than an undefined symbol. The body is
    // recursive so the candidate filter declines it under `-O`.
    let src = "extern __attribute__((__gnu_inline__)) inline int f(int x)\n\
               { return x <= 0 ? 0 : f(x - 1) + 1; }\n\
               int g(int x) { return f(x); }\n";
    assert_eq!(probe(src, Model::C99, true), Sym::Local);
}

#[test]
fn an_inline_only_definitions_address_is_the_external_definition() {
    // C99 6.2.2p2: the identifier keeps external linkage, so the pointer
    // denotes the program's one definition of it. The address leaves an
    // undefined reference for the linker to satisfy from another unit,
    // as it does under gcc and clang, in both models and at either
    // optimization level.
    let c99 = "inline int f(int x) { return x + 1; }\nint (*p)(int) = f;\n";
    let gnu89 = "extern inline int f(int x) { return x + 1; }\nint (*p)(int) = f;\n";
    for optimize in [false, true] {
        assert_eq!(probe(c99, Model::C99, optimize), Sym::Undef);
        assert_eq!(probe(gnu89, Model::Gnu89, optimize), Sym::Undef);
    }
}

#[test]
fn an_inline_only_definition_splits_its_body_from_its_identifier() {
    // The body stays available to a call in the same unit under the
    // private name while the identifier carries the address reference:
    // one undefined `f`, one local definition of `f.inline`, and the
    // data slot relocated against `f`.
    let src = "inline int f(int x) { return x + 1; }\n\
               int (*p)(int) = f;\n\
               int g(int x) { return f(x); }\n";
    let copts = CompileOptions {
        no_entry_point: true,
        gnu: true,
        ..Default::default()
    };
    let program = Compiler::with_options(src.to_string(), Target::LinuxX64, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    const STB_LOCAL: u8 = 0;
    let ident: Vec<_> = obj.symbols.iter().filter(|s| s.name == "f").collect();
    assert!(
        !ident.is_empty() && ident.iter().all(|s| s.section == NativeSymSection::Undef),
        "the identifier must be an undefined reference, got {ident:?}"
    );
    let body = obj
        .symbols
        .iter()
        .find(|s| s.name == BODY)
        .expect("private body symbol");
    assert_eq!(body.binding, STB_LOCAL, "the body must not be exported");
    assert_ne!(body.section, NativeSymSection::Undef, "the body is defined");
}

/// Sources shaped like `<linux/fortify-string.h>`: an inline definition
/// of a library function whose body calls the builtin of the same name
/// to reach the unfortified one, plus a caller that keeps the body
/// live. Each row is `(name, definition, caller)`.
const FORTIFY_WRAPPERS: &[(&str, &str, &str)] = &[
    (
        "memcmp",
        "int memcmp(const void *p, const void *q, unsigned long n)\
         { return __builtin_memcmp(p, q, n); }\n",
        "int probe(const void *a, const void *b, unsigned long n)\
         { return memcmp(a, b, n); }\n",
    ),
    (
        "strcpy",
        "char *strcpy(char *p, const char *q) { return __builtin_strcpy(p, q); }\n",
        "char *probe(char *a, const char *b) { return strcpy(a, b); }\n",
    ),
    (
        "memchr",
        "void *memchr(const void *p, int c, unsigned long n)\
         { return __builtin_memchr(p, c, n); }\n",
        "void *probe(const void *a, int c, unsigned long n) { return memchr(a, c, n); }\n",
    ),
    (
        "strncat",
        "char *strncat(char *p, const char *q, unsigned long n)\
         { return __builtin_strncat(p, q, n); }\n",
        "char *probe(char *a, const char *b, unsigned long n) { return strncat(a, b, n); }\n",
    ),
    // The memory transfers take the other route to a library call: the
    // count is not an integer constant expression, so the inline
    // expansion declines and falls back to the named function.
    (
        "memcpy",
        "void *memcpy(void *p, const void *q, unsigned long n)\
         { return __builtin_memcpy(p, q, n); }\n",
        "void *probe(void *a, const void *b, unsigned long n) { return memcpy(a, b, n); }\n",
    ),
];

/// A builtin equivalent to a library function reaches that function's
/// external definition, never a unit-local inline definition of the
/// same name.
///
/// An inline definition provides no external definition (C99 6.7.4p6),
/// so it is not what `__builtin_<fn>` names, and the body badc emits
/// for it calls the builtin in turn. Binding the builtin to that body
/// closes the loop: every `<linux/fortify-string.h>` wrapper the
/// inliner declined became a body that called itself, and the kernel's
/// first fortified compare ran the boot stack off its guard page.
#[test]
fn builtin_alias_reaches_the_external_definition() {
    for (name, def, caller) in FORTIFY_WRAPPERS {
        for model in [Model::C99, Model::Gnu89] {
            // `extern inline` is the inline-only spelling under GNU89;
            // a plain `inline` is the C99 one.
            let src = match model {
                Model::Gnu89 => alloc::format!("extern __inline__ {def}{caller}"),
                Model::C99 => alloc::format!("inline {def}{caller}"),
            };
            let copts = CompileOptions {
                no_entry_point: true,
                gnu: true,
                gnu89_inline: model == Model::Gnu89,
                ..Default::default()
            };
            let program = Compiler::with_options(src.clone(), Target::LinuxX64, copts)
                .compile()
                .unwrap_or_else(|e| panic!("compile {name} under {model:?}: {e:?}"));
            let opts = NativeOptions {
                output_kind: OutputKind::Relocatable,
                ..Default::default()
            };
            let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
            let obj = parse_native_elf(&bytes).expect("parse ET_REL");
            // The body is emitted, and privately: that is what makes the
            // call inside it a call, rather than an inlined expansion.
            let body = alloc::format!("{name}.inline");
            assert!(
                obj.symbols
                    .iter()
                    .any(|s| s.name == body && s.section != NativeSymSection::Undef),
                "{name} under {model:?}: expected the private body {body}"
            );
            // The builtin's call relocates against the library name,
            // which this unit does not define. Binding it to the body
            // instead leaves no reference and no relocation at all.
            let undef: Vec<usize> = obj
                .symbols
                .iter()
                .enumerate()
                .filter(|(_, s)| s.name == *name && s.section == NativeSymSection::Undef)
                .map(|(i, _)| i)
                .collect();
            assert!(
                !undef.is_empty(),
                "{name} under {model:?}: expected an undefined reference to {name}, got {:?}",
                obj.symbols.iter().map(|s| &s.name).collect::<Vec<_>>()
            );
            assert!(
                obj.text_relocs.iter().any(|r| undef.contains(&r.sym_idx)),
                "{name} under {model:?}: the body must call {name}, not itself"
            );
        }
    }
}

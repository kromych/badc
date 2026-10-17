//! Redeclarations of an identifier with linkage (C99 6.7p4, 6.2.7, 6.9p3):
//! conflicts are errors, the GNU forms GCC accepts warn, the rest compose.

use super::{Compiler, Vm};
use crate::c5::diag::Code;

/// The rows compile for x86-64 Linux; the PE targets give enums the same
/// types, which `an_enum_takes_the_type_gcc_gives_on_the_pe_targets` checks.
fn expect_conflict(src: &str, needles: &[&str]) {
    let msg = match Compiler::with_target(src.to_string(), crate::Target::LinuxX64).compile() {
        Err(e) => e.to_string(),
        Ok(_) => panic!("expected a compile error for {src:?}"),
    };
    for needle in needles {
        assert!(msg.contains(needle), "{src:?}: no {needle:?} in {msg:?}");
    }
}

fn run_without_warnings(src: &str) -> i64 {
    let prog = Compiler::with_target(src.to_string(), crate::Target::LinuxX64)
        .compile()
        .unwrap_or_else(|e| panic!("{src:?}: {e}"));
    assert!(prog.warnings.is_empty(), "{src:?}: {:?}", prog.warnings);
    Vm::new(prog).run().unwrap()
}

/// C99 6.2.2p4: the object a block-scope `extern` names in a block-scope
/// static's initializer is the unit's own when the unit defines it later,
/// by its name or by an asm label past a typedef of the name.
#[test]
fn a_block_scope_extern_objects_address_binds_a_later_definition() {
    for src in [
        "long f(void) { extern long cell; static long *p = &cell; return *p; }\n\
         long cell = 77;\nint main(void) { return f(); }\n",
        "long storage __asm__(\"cell\") = 77;\ntypedef short cell;\n\
         long f(void) { extern long cell; static long *p = &cell; return *p; }\n\
         int main(void) { cell c = 0; return f() + c; }\n",
    ] {
        assert_eq!(run_without_warnings(src), 77, "{src:?}");
    }
}

/// gcc's rule, which mingw-w64's gcc and clang for the windows-gnu triples
/// follow on the PE targets, makes an enum with no negative enumerator
/// compatible with `unsigned int` (C99 6.7.2.2p4), and a `mode` attribute
/// narrows that unsigned type.
#[test]
fn an_enum_takes_the_type_gcc_gives_on_the_pe_targets() {
    for target in [crate::Target::WindowsX64, crate::Target::WindowsAarch64] {
        let compile = |src: &str| Compiler::with_target(src.to_string(), target).compile();
        let src = "enum E { A = 5 };\nint f(enum E);\nint f(unsigned int v) { return (int)v; }\n\
                   int main(void) { return f(A); }\n";
        assert_eq!(
            Vm::new(compile(src).unwrap()).run().unwrap(),
            5,
            "{target:?}"
        );
        for (src, needles) in [
            (
                "enum E { A = 5 };\nint f(enum E);\nint f(int v) { return v; }\n",
                ["previous: int (enum E)", "now:      int (int)"],
            ),
            (
                "enum E;\nextern enum E x;\nenum E { A } __attribute__((__mode__(__byte__)));\n\
                 unsigned int x;\n",
                ["previous: enum E", "now:      unsigned int"],
            ),
        ] {
            let src = alloc::format!("{src}int main(void) {{ return 0; }}\n");
            let msg = compile(&src).map(|_| ()).unwrap_err().to_string();
            for needle in needles {
                assert!(
                    msg.contains(needle),
                    "{target:?} {src:?}: no {needle:?} in {msg:?}"
                );
            }
        }
    }
}

#[test]
fn a_second_definition_of_another_type_is_rejected() {
    expect_conflict(
        "static int pick(int a) { return a + 1; }\n\
         int first(void) { return pick(1); }\n\
         static int pick(int a, int b) { return a * b + 100; }\n\
         int second(void) { return pick(2, 3); }\n\
         int main(void) { return first() * 1000 + second(); }\n",
        &[
            "conflicting types for `pick`",
            "previous: int (int)",
            "now:      int (int, int)",
        ],
    );
}

#[test]
fn function_redeclarations_of_another_type_are_rejected() {
    for (decls, needle) in [
        (
            "int f(int x) { return x; }\nlong f(int x);\n",
            "now:      long (int)",
        ),
        // C99 6.7.5.3p7: an array parameter is a pointer to its element,
        // the row for two bounds, which a pointer to the scalar is not.
        (
            "int f(int a[2][3]);\nint f(int *a) { return *a; }\n",
            "previous: int (int (*)[3])",
        ),
        (
            "int f(int x);\nint f(int x, int y) { return x + y; }\n",
            "now:      int (int, int)",
        ),
        (
            "int f(int x);\nint f(int x, ...) { return x; }\n",
            "now:      int (int, ...)",
        ),
        (
            "int f(void);\nint f(int x) { return x; }\n",
            "now:      int (int)",
        ),
        (
            "int f(const int *s);\nint f(int *s) { return *s; }\n",
            "now:      int (int*)",
        ),
        (
            "struct S;\nstruct T;\nint f(struct S *);\nint f(struct T *);\n",
            "now:      int (struct T*)",
        ),
        // C99 6.7.5.3p15: beside a declaration without parameter information,
        // a parameter type the default argument promotions change conflicts.
        (
            "int f();\nint f(float x) { return (int)x; }\n",
            "now:      int (float)",
        ),
        ("int f(char c);\nint f();\n", "now:      int ()"),
        // GCC and clang take a type before its promotion from a prototype
        // ahead of an old-style definition only.
        (
            "int f(c) short c; { return c; }\nint f(short);\n",
            "now:      int (short)",
        ),
        (
            "int f() { return 0; }\nint f(int);\n",
            "now:      int (int)",
        ),
        (
            "typedef int F(int);\nF f;\nint f(int a, int b) { return a + b; }\n",
            "now:      int (int, int)",
        ),
        // A typedef or `typeof` names its type's parameter form.
        (
            "typedef int F(void);\nF f;\nint f(int x) { return x; }\n",
            "previous: int (void)",
        ),
        (
            "typedef int F();\nF f;\nint f(char c) { return c; }\n",
            "now:      int (char)",
        ),
        ("typedef int F(char);\nF f;\nint f();\n", "now:      int ()"),
        (
            "int f();\nextern __typeof__(f) f;\nint f(char c) { return c; }\n",
            "now:      int (char)",
        ),
        // C99 6.7.2.2p4: two enumerated types of one integer type differ.
        (
            "enum A { A1 };\nenum B { B1 };\nint f(enum A);\nint f(enum B b) { return b; }\n",
            "now:      int (enum B)",
        ),
        // C99 6.7.3: `volatile` below a parameter's own level takes part.
        (
            "int f(volatile int **);\nint f(int *volatile *p) { return p != 0; }\n",
            "now:      int (int* volatile *)",
        ),
        // The tag's definition fixes the type the earlier use names.
        (
            "enum E;\nint f(enum E);\nenum E { A } __attribute__((__mode__(__byte__)));\n\
             int f(int x) { return x; }\n",
            "previous: int (enum E)",
        ),
        (
            "typedef enum E T;\nint f(T);\nenum E { A = 3 } __attribute__((packed));\n\
             int f(int v) { return v; }\n",
            "previous: int (enum E)",
        ),
    ] {
        let src = alloc::format!("{decls}int main(void) {{ return 0; }}\n");
        expect_conflict(&src, &["conflicting types for `f`", needle]);
    }
}

#[test]
fn object_redeclarations_of_another_type_are_rejected() {
    for (decls, needle) in [
        ("int x;\nlong x;\n", "now:      long"),
        ("int x;\nunsigned x;\n", "now:      unsigned int"),
        ("int *x;\nconst int *x;\n", "now:      const int*"),
        ("int x;\nconst int x;\n", "now:      const int"),
        ("extern int x[3];\nint x[4];\n", "now:      int [4]"),
        // C99 6.7.8p22: the initializer completes the bound.
        (
            "int x[] = {1, 2, 3};\nextern int x[4];\n",
            "previous: int [3]",
        ),
        ("int x[2][3];\nextern int x[][4];\n", "now:      int [][4]"),
        (
            "extern int (*x)[4];\nint (*x)[3];\n",
            "now:      int (*)[3]",
        ),
        (
            "enum E;\nextern enum E x;\nenum E { A } __attribute__((__mode__(__byte__)));\nint x;\n",
            "previous: enum E",
        ),
        (
            "enum A { A1 };\nenum B { B1 };\nextern enum A x;\nenum B x;\n",
            "now:      enum B",
        ),
        // C99 6.7.3: `volatile` takes part at the level it qualifies.
        (
            "extern volatile int **x;\nint *volatile *x;\n",
            "now:      int* volatile *",
        ),
        ("int x;\nvolatile int x;\n", "now:      volatile int"),
    ] {
        let src = alloc::format!("{decls}int main(void) {{ return 0; }}\n");
        expect_conflict(&src, &["conflicting types for `x`", needle]);
    }
}

#[test]
fn declarations_with_linkage_meet_past_a_binding_without_one() {
    // C99 6.2.2p2, p4: every declaration of an identifier with linkage
    // denotes one entity, so a function and an object declared at block
    // scope meet across a typedef or enumerator of the name, in any order,
    // as gcc and clang diagnose; a GNU global register variable takes the
    // name too.
    let kind = "`big` redeclared as a different kind of symbol";
    for src in [
        "long a(void) { long big(int); return big(5); }\ntypedef short big;\n\
         long b(void) { extern long big; return big; }\n",
        "long a(void) { extern long big; return big; }\ntypedef short big;\n\
         long b(void) { long big(int); return big(5); }\n",
        "typedef short big;\nlong a(void) { extern long big; return big; }\n\
         long b(void) { long big(int); return big(5); }\n",
        "long a(void) { long big(int); return big(1); }\ntypedef short big;\n\
         long b(void) { extern long (*big)(int); return big(2); }\n",
        "long a(void) { long big(int); return big(5); }\nenum { big = 1 };\n\
         long b(void) { extern long big; return big; }\n",
        "long a(void) { long big(int); return big(5); }\n\
         long b(void) { extern long big; return big; }\n",
    ] {
        expect_conflict(
            &alloc::format!("{src}int main(void) {{ return 0; }}\n"),
            &[kind],
        );
    }
    for (src, needle) in [
        (
            "long a(void) { long rg(int); return rg(5); }\n\
             register unsigned long rg __asm__(\"rsp\");\n",
            "`rg` conflicts with a prior declaration",
        ),
        (
            "register unsigned long rg __asm__(\"rsp\");\n\
             long a(void) { long rg(int); return rg(5); }\n",
            "`rg` redeclared as a function",
        ),
    ] {
        expect_conflict(
            &alloc::format!("{src}int main(void) {{ return 0; }}\n"),
            &[needle],
        );
    }
}

#[test]
fn block_scope_declarations_meet_the_other_declarations() {
    // C99 6.2.2p4: a block-scope `extern` or function declaration names the
    // entity every other declaration of the identifier names.
    for src in [
        "double x;\nint main(void) { extern int x; return x; }\n",
        "int main(void) { extern int x; return x; }\ndouble x;\n",
        "int g(int a, int b) { return a + b; }\nint main(void) { int g(int); return g(1); }\n",
        "int main(void) { int g(int); return g(1); }\nint g(int a, int b) { return a + b; }\n",
        "void a(void) { extern int x; }\nvoid b(void) { extern long x; }\nint main(void) { return 0; }\n",
        "typedef int F(int);\nint g(int a, int b) { return a + b; }\n\
         int main(void) { F g; return g(1); }\n",
        "typedef int F(void);\nint g(int a) { return a; }\n\
         int main(void) { F g; return g(1); }\n",
        // A typedef of the name between or before them hides neither.
        "long f(void) { long g(int); return g(1); }\ntypedef short g;\n\
         long h(void) { double g(int); return g(1); }\nint main(void) { return 0; }\n",
        "enum { g = 1 };\nlong f(void) { long g(int); return g(1); }\n\
         long h(void) { double g(int); return g(1); }\nint main(void) { return 0; }\n",
    ] {
        expect_conflict(src, &["conflicting types for `"]);
    }
}

#[test]
fn a_function_keeps_one_calling_convention() {
    // The calling convention is part of a function's type, as gcc and clang
    // take it: the first declaration's, in whatever scope it is, which a
    // later declaration names again or leaves unnamed; naming another, the
    // target's own included, through an attribute, a typedef or typeof, is
    // rejected (C99 6.2.7p2). `F` names the convention foreign to the
    // target and `N` the target's own; every call and the definition of `f`
    // follow the convention a row accepts.
    use crate::c5::codegen::CallConv;
    use crate::c5::ir::Inst;
    #[derive(Clone, Copy)]
    enum Outcome {
        Foreign,
        Own,
        DeclaredForeign,
        DeclaredOwn,
    }
    use Outcome::*;
    const ROWS: &[(&str, Outcome)] = &[
        (
            "F int f(int); int g(void) { int f(int); return f(1); }",
            Foreign,
        ),
        (
            "void g(void) { F int f(int); } int f(int x) { return x; }",
            Foreign,
        ),
        (
            "int g(void) { F int f(int); return f(1); } int h(void) { int f(int); return f(2); }",
            Foreign,
        ),
        (
            "F int f(int); int g(void) { int f = 1; { int f(int); return f(1) + 0; } }",
            Foreign,
        ),
        (
            "void g(void) { F int f(int); } F int f(int x) { return x; }",
            Foreign,
        ),
        (
            "int g(void) { extern F int f(int); return f(1); } int f(int);",
            Foreign,
        ),
        (
            "int g(void) { F int f(int); { int f(int); return f(1); } }",
            Foreign,
        ),
        (
            "typedef int Pt(int); F int f(int); int g(void) { Pt f; return f(1); }",
            Foreign,
        ),
        (
            "F int n(int); void g(void) { __typeof__(n) f; } int f(int x) { return x; }",
            Foreign,
        ),
        (
            "F int f(int); int f(int); int g(void) { return f(1); }",
            Foreign,
        ),
        ("F int f(int); F int f(int x) { return x; }", Foreign),
        ("F int f(int); int f(int x) { return x; }", Foreign),
        ("F int f(); int f(a) int a; { return a; }", Foreign),
        ("F int f(a) int a; { return a; } int f(int);", Foreign),
        (
            "static F int f(int); static int f(int x) { return x; } int g(void) { return f(1); }",
            Foreign,
        ),
        ("extern F int f(int); int f(int x) { return x; }", Foreign),
        (
            "static F int f(int); extern int f(int); static int f(int x) { return x; }\n\
             int g(void) { return f(1); }",
            Foreign,
        ),
        (
            "typedef int Ft(int) F; Ft f; int f(int x) { return x; }",
            Foreign,
        ),
        (
            "typedef F int Ft(int); Ft f; int f(int x) { return x; }",
            Foreign,
        ),
        (
            "typedef int Pt(int); F int f(int); Pt f; int g(void) { return f(1); }",
            Foreign,
        ),
        (
            "F int f(int); typedef int Pt(int); Pt f; int f(int x) { return x; }",
            Foreign,
        ),
        (
            "typedef int Pt(int); typedef F int Ft(int); Ft f; Pt f; int g(void) { return f(1); }",
            Foreign,
        ),
        (
            "F int n(int); __typeof__(n) f; int f(int x) { return x; }",
            Foreign,
        ),
        (
            "int n(int); F int f(int); __typeof__(n) f; int g(void) { return f(1); }",
            Foreign,
        ),
        ("N int f(int); int f(int x) { return x; }", Own),
        ("int f(int); N int f(int x) { return x; }", Own),
        ("int f(int); void g(void) { F int f(int); }", DeclaredOwn),
        ("int f(int); void g(void) { int f(int) F; }", DeclaredOwn),
        (
            "typedef int Ft(int) F; int f(int); void g(void) { Ft f; }",
            DeclaredOwn,
        ),
        (
            "void g(void) { N int f(int); } F int f(int x) { return x; }",
            DeclaredOwn,
        ),
        (
            "int g(void) { int f(int); return f(1); } F int f(int x) { return x; }",
            DeclaredOwn,
        ),
        ("int f(int); F int f(int);", DeclaredOwn),
        ("int f(int); F int f(int x) { return x; }", DeclaredOwn),
        ("int f(); F int f(a) int a; { return a; }", DeclaredOwn),
        ("int f(a) int a; { return a; } F int f(int);", DeclaredOwn),
        (
            "static int f(int); static F int f(int x) { return x; } int g(void) { return f(1); }",
            DeclaredOwn,
        ),
        ("extern int f(int); extern F int f(int);", DeclaredOwn),
        ("typedef int Ft(int) F; int f(int); Ft f;", DeclaredOwn),
        ("F int n(int); int f(int); __typeof__(n) f;", DeclaredOwn),
        (
            "int g(void) { F int f(int); return f(1); } int h(void) { N int f(int); return f(2); }",
            DeclaredForeign,
        ),
        (
            "F int f(int); int g(void) { int f = 1; { N int f(int); return f(1) + 0; } }",
            DeclaredForeign,
        ),
        (
            "void g(void) { F int f(int); } N int f(int x) { return x; }",
            DeclaredForeign,
        ),
        (
            "int g(void) { F int f(int); { N int f(int); return f(1); } }",
            DeclaredForeign,
        ),
        ("F int f(int); N int f(int);", DeclaredForeign),
        (
            "F int f(a) int a; { return a; } N int f(int);",
            DeclaredForeign,
        ),
        (
            "typedef int Ft(int) F; Ft f; N int f(int x) { return x; }",
            DeclaredForeign,
        ),
        (
            "F int n(int); __typeof__(n) f; N int f(int x) { return x; }",
            DeclaredForeign,
        ),
        (
            "F int f(int); typedef N int Nt(int); Nt f;",
            DeclaredForeign,
        ),
        (
            "N int n(int); F int f(int); __typeof__(n) f;",
            DeclaredForeign,
        ),
        // gcc: a convention a later declaration named stays on the type.
        (
            "F int f(int); int n(int); N int n(int); int n(int); __typeof__(n) f;",
            DeclaredForeign,
        ),
    ];
    for target in [crate::Target::LinuxX64, crate::Target::WindowsX64] {
        let (f, n, foreign) = match target {
            crate::Target::WindowsX64 => ("sysv_abi", "ms_abi", CallConv::SysV),
            _ => ("ms_abi", "sysv_abi", CallConv::Ms),
        };
        for &(decls, outcome) in ROWS {
            let src = alloc::format!(
                "#define F __attribute__(({f}))\n#define N __attribute__(({n}))\n\
                 {decls}\nint main(void) {{ return 0; }}\n"
            );
            let compiled = Compiler::with_target(src, target).compile();
            let want = match outcome {
                Foreign => foreign,
                Own => CallConv::Target,
                DeclaredForeign | DeclaredOwn => {
                    let (was, now) = match outcome {
                        DeclaredForeign => (f, n),
                        _ => (n, f),
                    };
                    let msg = compiled.err().map(|e| e.to_string()).unwrap_or_default();
                    let needle = alloc::format!("for `f`: declared `{was}`, now `{now}`");
                    assert!(msg.contains(&needle), "{target:?} {decls}: {msg:?}");
                    continue;
                }
            };
            let prog = compiled.unwrap_or_else(|e| panic!("{target:?} {decls}: {e}"));
            if let Some(def) = prog.finished_functions.iter().find(|d| d.name == "f") {
                assert_eq!(def.conv, want, "{target:?} {decls}: the definition");
            }
            let funcs =
                crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&prog, target, false, true)
                    .expect("ssa");
            for (func, inst) in funcs
                .iter()
                .flat_map(|u| u.insts.iter().map(move |i| (u, i)))
            {
                if matches!(inst, Inst::Call { .. } | Inst::CallIndirect { .. }) {
                    let at = &func.name;
                    assert_eq!(inst.call_conv(), Some(want), "{target:?} {decls}: in {at}");
                }
            }
        }
    }
}

#[test]
fn a_function_type_names_one_calling_convention() {
    // gcc rejects a function type naming two calling conventions: in one
    // attribute list, the specifiers and the declarator, a declarator's
    // group, or over a function or pointer typedef or typeof that names
    // one. `F` names the convention foreign to the target, `N` its own.
    let rejected = [
        "F N int f(int);",
        "__attribute__((ms_abi, sysv_abi)) int f(int);",
        "F int f(int) N;",
        "F int f(int x) N { return x; }",
        "F int f(a) N int a; { return a; }",
        "int (F N *p)(int);",
        "int (F *p)(int) N;",
        "N int (F *p)(int);",
        "typedef int F Ft(int); N Ft f;",
        "typedef int F Ft(int); Ft f N;",
        "typedef int F Ft(int); void g(void) { N Ft f; }",
        "int n(int) F; N __typeof__(n) f;",
        "typedef int (F *Fp)(int); N Fp p;",
        "long g(void) { return sizeof(N int (F *)(int)); }",
        "int (*q)(int) = (N int (F *)(int))0;",
        "int z(void) { static int (*q)(int) = (N int (F *)(int))0; return q != 0; }",
    ];
    let accepted = [
        "F F int f(int);",
        "F int (*N g(int))(int);",
        "typedef int (*Pp)(int); F Pp p;",
    ];
    for target in [crate::Target::LinuxX64, crate::Target::WindowsX64] {
        let (f, n) = match target {
            crate::Target::WindowsX64 => ("sysv_abi", "ms_abi"),
            _ => ("ms_abi", "sysv_abi"),
        };
        let src = |decls: &str| {
            alloc::format!(
                "#define F __attribute__(({f}))\n#define N __attribute__(({n}))\n\
                 {decls}\nint main(void) {{ return 0; }}\n"
            )
        };
        for decls in rejected {
            let compiled = Compiler::with_target(src(decls), target).compile();
            let msg = compiled.err().map(|e| e.to_string()).unwrap_or_default();
            let needle = "`ms_abi` and `sysv_abi` attributes are not compatible";
            assert!(msg.contains(needle), "{target:?} {decls}: {msg:?}");
        }
        for decls in accepted {
            let compiled = Compiler::with_target(src(decls), target).compile();
            assert!(compiled.is_ok(), "{target:?} {decls}: {:?}", compiled.err());
        }
    }
}

#[test]
fn a_second_body_is_rejected() {
    for decls in [
        "int f(void) { return 1; }\nint f(void) { return 2; }\n",
        "static int f(void) { return 1; }\nstatic int f(void) { return 2; }\n",
        // A GNU `extern inline` body is replaceable once, by a body that is not.
        "extern inline __attribute__((gnu_inline)) int f(void) { return 1; }\n\
         extern inline __attribute__((gnu_inline)) int f(void) { return 1; }\n",
    ] {
        let src = alloc::format!("{decls}int main(void) {{ return f(); }}\n");
        expect_conflict(&src, &["redefinition of `f`", "previous definition"]);
    }
}

#[test]
fn compatible_redeclarations_compose() {
    for (src, want) in [
        // C17 6.7.6.3p5: a function returns the unqualified version of its
        // declared type, so the return type's own qualifiers do not count.
        (
            "const int f(void);\nint f(void) { return 8; }\nvolatile int f(void);\n\
          const char *const k(void);\nconst char *k(void) { return \"\"; }\n\
          int main(void) { return f() + *k(); }\n",
            8,
        ),
        // C99 6.7.5.3p15: no parameter information beside a prototype or an
        // old-style definition that agrees with it.
        (
            "int f();\nint f(int a) { return a; }\nint f();\nint main(void) { return f(3); }\n",
            3,
        ),
        (
            "int k(int);\nint k(c) int c; { return c + 1; }\nint main(void) { return k(4); }\n",
            5,
        ),
        (
            "int v(void);\nint v() { return 6; }\nint main(void) { return v(); }\n",
            6,
        ),
        (
            "double h(double);\ndouble h(x) float x; { return x; }\n\
          int main(void) { return (int)h(7.0); }\n",
            7,
        ),
        // C99 6.2.7p3: the composite takes the bound any declaration states.
        (
            "extern int a[];\nint a[3] = {1, 2, 3};\nextern int a[3];\nextern int a[];\n\
          int main(void) { return a[2] + (int)(sizeof a / sizeof a[0]); }\n",
            6,
        ),
        (
            "int b[] = {4, 5};\nextern int b[2];\nint main(void) { return b[1]; }\n",
            5,
        ),
        (
            "extern int m[][3];\nint m[2][3] = {{1, 2, 3}, {4, 5, 6}};\n\
          int main(void) { return m[1][2]; }\n",
            6,
        ),
        (
            "int g(int (*)[]);\nint g(int (*p)[3]) { return (*p)[1]; }\n\
          int main(void) { int a[3] = {1, 2, 3}; return g(&a); }\n",
            2,
        ),
        (
            "int r(int a[][3]);\nint r(int (*a)[3]) { return a[1][2]; }\n\
          int main(void) { int m[2][3] = {{0, 1, 2}, {3, 4, 5}}; return r(m); }\n",
            5,
        ),
        // GNU: the `extern inline` body serves inlining; the later one defines.
        (
            "extern inline __attribute__((gnu_inline)) int e(void) { return 7; }\n\
          int e(void) { return 7; }\nint main(void) { return e(); }\n",
            7,
        ),
        // Attributes, storage classes and a parameter's own qualifiers are
        // not part of the type.
        (
            "int k(void) __attribute__((noinline));\nint k(void) { return 5; }\n\
          __attribute__((used)) int k(void);\nint main(void) { return k(); }\n",
            5,
        ),
        (
            "static int s(void);\nextern int s(void);\nstatic int s(void) { return 4; }\n\
          int main(void) { return s(); }\n",
            4,
        ),
        (
            "int q(const int x);\nint q(int x) { return x; }\nint main(void) { return q(9); }\n",
            9,
        ),
        (
            "int t();\nextern __typeof__(t) t;\nint t(int v) { return v; }\n\
          int main(void) { return t(8); }\n",
            8,
        ),
        (
            "int k(a) int a; { return a + 1; }\nextern __typeof__(k) k;\n\
          int main(void) { return k(4); }\n",
            5,
        ),
        (
            "typedef int F();\nF f;\nint f(int a) { return a; }\nint main(void) { return f(3); }\n",
            3,
        ),
        (
            "typedef int F(void);\nF v;\nint v(void) { return 6; }\nint main(void) { return v(); }\n",
            6,
        ),
        // C99 6.7.2.3p1: a tag declared before its definition names the type
        // the definition completes, at whatever width it then takes.
        (
            "enum E;\nenum E f(void);\nenum E { A, B };\nenum E f(void) { return B; }\n\
          int main(void) { return f(); }\n",
            1,
        ),
        (
            "enum E;\nint f(enum E);\nenum E { A, B } __attribute__((__mode__(__byte__)));\n\
          int f(enum E e) { return e + (int)sizeof(e); }\nint main(void) { return f(B); }\n",
            2,
        ),
        (
            "enum E;\nenum E *p(enum E *);\nenum E { A = 1 };\nenum E *p(enum E *q) { return q; }\n\
          int main(void) { enum E e = A; return *p(&e); }\n",
            1,
        ),
        (
            "enum E;\nextern enum E x;\nenum E { A = 4 } __attribute__((__mode__(__byte__)));\n\
          enum E x = A;\nint main(void) { return x + (int)sizeof x; }\n",
            5,
        ),
        (
            "typedef enum E T;\nint f(T);\nenum E { A = 3 };\nint f(unsigned int v) { return (int)v; }\n\
          int main(void) { T t = A; return f(t) + (int)sizeof(T) - 4; }\n",
            3,
        ),
        (
            "int main(void) { typedef enum E T; int f(T); enum E { A = 3 } __attribute__((packed));\n\
          T t = A; return f(t) + (int)sizeof t; }\nint f(unsigned char v) { return v; }\n",
            4,
        ),
        // C99 6.7.2.2p4: an enum is compatible with the integer type chosen
        // for it.
        (
            "enum E { A = 5 };\nint f(enum E);\nint f(unsigned int v) { return (int)v; }\n\
          int main(void) { return f(A); }\n",
            5,
        ),
        (
            "enum N { M = -1, P = 6 };\nint g(int);\nint g(enum N v) { return v; }\n\
          int main(void) { return g(P); }\n",
            6,
        ),
        (
            "extern volatile int v;\nvolatile int v = 3;\nint main(void) { return v; }\n",
            3,
        ),
        // C99 6.7.5.3p15: a parameter's own qualifier takes no part.
        (
            "int h(volatile int);\nint h(int a) { return a; }\nint main(void) { return h(4); }\n",
            4,
        ),
        (
            "typedef const int CI;\nextern CI c;\nconst int c = 2;\nint main(void) { return c; }\n",
            2,
        ),
        (
            "int x = 9;\nint main(void) { extern int x; return x; }\n",
            9,
        ),
        (
            "int g(int a) { return a + 1; }\nint main(void) { int g(int); return g(1); }\n",
            2,
        ),
        (
            "typedef int F(int);\nint g(int a) { return a + 2; }\n\
          int main(void) { F g; return g(1); }\n",
            3,
        ),
        (
            "typedef int F();\nint g(int a) { return a + 2; }\n\
          int main(void) { F g; return g(1); }\n",
            3,
        ),
    ] {
        assert_eq!(run_without_warnings(src), want, "{src}");
    }
}

#[test]
fn gnu_redeclarations_warn() {
    for (src, now) in [
        // GCC keeps `void` for an implicit `int` definition of a function
        // declared `void`, once the implicit `int` is lowered to a warning.
        (
            "#pragma GCC diagnostic warning \"-Wimplicit-int\"\n\
             void f(void);\nf(void) { }\nint main(void) { f(); return 0; }\n",
            "now:      int (void)",
        ),
        // GCC lets the prototype's `char` stand for the promoted `int` of an
        // old-style definition.
        (
            "int f(char);\nint f(c) char c; { return c - 1; }\nint main(void) { return f(1); }\n",
            "old-style definition",
        ),
    ] {
        let prog = Compiler::new(src.to_string())
            .compile()
            .unwrap_or_else(|e| panic!("{src:?}: {e}"));
        let redecl: alloc::vec::Vec<_> = prog
            .warnings
            .iter()
            .filter(|w| w.code == Code::REDECLARATION_MISMATCH)
            .collect();
        assert!(
            redecl.len() == 1 && redecl[0].text.contains(now),
            "{src:?}: {:?}",
            prog.warnings
        );
        assert_eq!(Vm::new(prog).run().unwrap(), 0, "{src}");
    }
}

#[test]
fn fn_type_typedef_ptr_redeclaration_is_silent() {
    // C99 6.2.7, 6.7.5.1p1, 6.7.5.3p8: `F *` for a function type `F` is the
    // spelled-out function pointer, in every spelling and order.
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
        let prog = Compiler::new((*src).to_string()).compile().unwrap();
        assert!(
            prog.warnings.is_empty(),
            "expected silence for {src:?}, got {:?}",
            prog.warnings,
        );
    }
}

#[test]
fn matching_redeclaration_is_silent() {
    // Identical repeats, as shared headers produce, are silent.
    let src = "int f(int x); int f(int x); int f(int x) { return x; } int main() { return f(7); }";
    let prog = Compiler::new(src.to_string()).compile().unwrap();
    assert!(
        prog.warnings.is_empty(),
        "matching redecl should be silent, got {:?}",
        prog.warnings,
    );
    assert_eq!(Vm::new(prog).run().unwrap(), 7);
}

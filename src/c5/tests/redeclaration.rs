//! Redeclarations of an identifier with linkage (C99 6.7p4, 6.2.7, 6.9p3):
//! conflicts are errors, the GNU forms GCC accepts warn, the rest compose.

use super::{Compiler, Vm};
use crate::c5::diag::Code;

fn expect_conflict(src: &str, needles: &[&str]) {
    let msg = match Compiler::new(src.to_string()).compile() {
        Err(e) => e.to_string(),
        Ok(_) => panic!("expected a compile error for {src:?}"),
    };
    for needle in needles {
        assert!(msg.contains(needle), "{src:?}: no {needle:?} in {msg:?}");
    }
}

fn run_without_warnings(src: &str) -> i64 {
    let prog = Compiler::new(src.to_string())
        .compile()
        .unwrap_or_else(|e| panic!("{src:?}: {e}"));
    assert!(prog.warnings.is_empty(), "{src:?}: {:?}", prog.warnings);
    Vm::new(prog).run().unwrap()
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
        // The tag's definition fixes the type the earlier use names.
        (
            "enum E;\nint f(enum E);\nenum E { A } __attribute__((__mode__(__byte__)));\n\
             int f(int x) { return x; }\n",
            "previous: int (unsigned char)",
        ),
        (
            "typedef enum E T;\nint f(T);\nenum E { A = 3 } __attribute__((packed));\n\
             int f(int v) { return v; }\n",
            "previous: int (unsigned char)",
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
            "previous: unsigned char",
        ),
    ] {
        let src = alloc::format!("{decls}int main(void) {{ return 0; }}\n");
        expect_conflict(&src, &["conflicting types for `x`", needle]);
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
    ] {
        expect_conflict(src, &["conflicting types for `"]);
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
        // declared `void`.
        (
            "void f(void);\nf(void) { }\nint main(void) { f(); return 0; }\n",
            "now:      int (void)",
        ),
        // C11 6.7.6.3p5 drops a return type's qualifiers; C99 6.7.3p9 does not.
        (
            "const int f(void);\nint f(void) { return 0; }\nint main(void) { return f(); }\n",
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

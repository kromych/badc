//! Microsoft structured exception handling in the front end: `__try`,
//! `__except`, `__finally` and `__leave` are keywords on the PE targets
//! and identifiers elsewhere, as clang treats them, and each placement
//! rule cl enforces (C2703, C2705, C2707, C2184) is an error, as are the
//! jumps out of a `__finally` block cl warns about (C4532).

use super::Compiler;
use crate::Target;

const WINDOWS: [Target; 2] = [Target::WindowsX64, Target::WindowsAarch64];

fn unit(body: &str) -> alloc::string::String {
    alloc::format!(
        "#include <windows.h>\nint g;\nint ext(void);\n{body}\nint main(void) {{ return 0; }}\n"
    )
}

/// Each row: a function and the error it draws on both PE targets.
const REFUSED: &[(&str, &str)] = &[
    (
        "void f(void) { __leave; }",
        "`__leave` outside a `__try` block",
    ),
    (
        "void f(void) { __try { g = ext(); } __except (1) { __leave; } }",
        "`__leave` outside a `__try` block",
    ),
    (
        "unsigned long f(void) { return GetExceptionCode(); }",
        "`_exception_code` is only allowed in an `__except` filter or an `__except` block",
    ),
    (
        "void *f(void) { return GetExceptionInformation(); }",
        "`_exception_info` is only allowed in an `__except` filter",
    ),
    (
        "void f(void) { void *p; __try { g = ext(); } __except (1) { p = GetExceptionInformation(); } }",
        "`_exception_info` is only allowed in an `__except` filter",
    ),
    (
        "int f(void) { return AbnormalTermination(); }",
        "`_abnormal_termination` is only allowed in a `__finally` block",
    ),
    (
        "void f(void) { goto in; __try { in: g = ext(); } __except (1) { g = 2; } }",
        "`goto` jumps into a `__try` block",
    ),
    (
        "void f(void) { goto in; __try { g = ext(); } __except (1) { in: g = 2; } }",
        "`goto` jumps into an `__except` block",
    ),
    (
        "void f(void) { goto in; __try { g = ext(); } __finally { in: g = 2; } }",
        "`goto` jumps into a `__finally` block",
    ),
    (
        "void f(int x) { switch (x) { case 0: __try { case 1: g = ext(); } __finally { g = 2; } } }",
        "`switch` jumps into a `__try` block",
    ),
    (
        "void f(void) { __try { g = ext(); } __finally { goto out; } out: g = 3; }",
        "`goto` jumps out of a `__finally` block",
    ),
    (
        "void f(void) { for (;;) { __try { g = ext(); } __finally { break; } } }",
        "`break` jumps out of a `__finally` block",
    ),
    (
        "void f(void) { for (int n = 0; n < 2; n++) { __try { g = ext(); } __finally { continue; } } }",
        "`continue` jumps out of a `__finally` block",
    ),
    (
        "int f(void) { __try { g = ext(); } __finally { return 2; } return 0; }",
        "`return` jumps out of a `__finally` block",
    ),
    (
        "void f(void) { __try { __try { g = ext(); } __finally { __leave; } } __finally { g = 4; } }",
        "`__leave` jumps out of a `__finally` block",
    ),
    (
        "void f(void) { __try { g = ext(); } __except (f()) { g = 2; } }",
        "`void` expression used as a value",
    ),
    (
        "void f(int *p) { __try { g = ext(); } __except (p) { g = 2; } }",
        "filter expression of `__except` has type `int*`, not an integer type",
    ),
    (
        "void f(void) { __try { g = ext(); } }",
        "`__except` or `__finally` expected after a `__try` block",
    ),
    (
        "void f(void) { __finally { g = 1; } }",
        "`__finally` without a `__try` block",
    ),
];

/// Placements both cl and clang accept: the intrinsics anywhere inside the
/// part that supplies them, `__leave` inside any enclosing `__try` body, a
/// jump out of a `__try` body, and jumps that stay inside a `__finally`.
const ACCEPTED: &[&str] = &[
    "void f(void) { __try { g = ext(); } __except (1) { __try { g = (int)GetExceptionCode(); } __finally { g = 3; } } }",
    "void f(void) { __try { g = ext(); } __except (1) { __try { g = 1; } __finally { g = (int)GetExceptionCode(); } } }",
    "void f(void) { __try { g = ext(); } __finally { __try { __leave; } __except (1) { g = 3; } } }",
    "void f(void) { __try { __try { g = ext(); } __except (1) { __leave; } } __finally { g = 4; } }",
    "void f(void) { __try { g = ext(); } __finally { __try { g = AbnormalTermination(); } __except (1) { g = 3; } } }",
    "int f(void) { __try { return ext(); } __finally { g = 1; } }",
    "void f(void) { __try { g = ext(); } __except (GetExceptionInformation() != 0 && GetExceptionCode() == 5) { g = 2; } }",
    "void f(void) { __try { for (;;) { if (ext()) __leave; } } __finally { g = 1; } }",
    "void f(void) { __try { if (ext()) goto out; } __finally { for (;;) { if (ext()) break; } if (g) goto in; in: g = 2; } out: g = 3; }",
    "void f(int n) { int v[n]; __try { v[0] = ext(); } __except (EXCEPTION_EXECUTE_HANDLER) { g = v[0]; } }",
];

#[test]
fn each_placement_rule_is_an_error_on_both_pe_targets() {
    for target in WINDOWS {
        for (body, needle) in REFUSED {
            let src = unit(body);
            match Compiler::with_target(src.clone(), target).compile() {
                Err(e) => {
                    let msg = e.to_string();
                    assert!(
                        msg.contains(needle),
                        "{target:?} {body}: expected {needle:?}, got {msg:?}"
                    );
                }
                Ok(_) => panic!("{target:?}: {body} compiled"),
            }
        }
    }
}

#[test]
fn the_placements_cl_and_clang_accept_compile() {
    for target in WINDOWS {
        for body in ACCEPTED {
            if let Err(e) = Compiler::with_target(unit(body), target).compile() {
                panic!("{target:?} {body}: {e}");
            }
        }
    }
}

/// Off the PE targets the four words are ordinary identifiers.
#[test]
fn off_windows_the_seh_words_are_identifiers() {
    let src = "int __try = 1, __except = 2, __finally = 3;\n\
               int __leave(void) { return __try + __except + __finally; }\n\
               int main(void) { return __leave() - 6; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64, Target::MacOSAarch64] {
        if let Err(e) = Compiler::with_target(src.into(), target).compile() {
            panic!("{target:?}: {e}");
        }
    }
    assert!(
        Compiler::with_target(src.into(), Target::WindowsX64)
            .compile()
            .is_err()
    );
}

/// A unit the front end accepts reaches the walker, which refuses it with a
/// diagnostic rather than a crash.
#[cfg(feature = "full")]
#[test]
fn lowering_refuses_a_try_statement() {
    let src = unit(
        "int f(void) { int r = 0; __try { r = ext(); } __except (1) { r = (int)GetExceptionCode(); } return r; }",
    );
    for target in WINDOWS {
        let program = Compiler::with_target(src.clone(), target)
            .compile()
            .expect("front end");
        let err = crate::emit_native_with_options(&program, target, crate::NativeOptions::new())
            .expect_err("lowered a `__try` statement");
        let msg = err.to_string();
        assert!(
            msg.contains("SEH lowering not implemented yet"),
            "{target:?}: {msg}"
        );
        assert!(
            !msg.contains("internal compiler error"),
            "{target:?}: {msg}"
        );
    }
}

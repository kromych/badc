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

const CAUGHT: &str = "int f(void) { int r = 0; __try { r = ext(); } __except (1) { r = (int)GetExceptionCode(); } return r; }";

/// A program whose `main` calls [`CAUGHT`]'s function.
#[cfg(feature = "full")]
const PROGRAM: &str = "#include <windows.h>\nint g;\nint ext(void) { return g + 5; }\n\
    int f(void) { int r = 0; __try { r = ext(); } __except (1) { r = (int)GetExceptionCode(); } return r; }\n\
    int main(void) { return f(); }\n";

/// The emit error for `body` as a relocatable object, else `None`.
#[cfg(feature = "full")]
fn object_error(body: &str, target: Target) -> Option<alloc::string::String> {
    let program = Compiler::with_target(unit(body), target)
        .compile()
        .expect("front end");
    let opts = crate::NativeOptions {
        output_kind: crate::OutputKind::Relocatable,
        ..crate::NativeOptions::new()
    };
    crate::emit_native_with_options(&program, target, opts)
        .err()
        .map(|e| e.to_string())
}

/// What the walker does not lower yet is a diagnostic, not a crash.
#[cfg(feature = "full")]
#[test]
fn the_forms_later_steps_lower_are_refused() {
    let rows = [
        (
            "void f(void) { __try { g = ext(); } __finally { g = 1; } }",
            "SEH `__finally` lowering not implemented yet",
        ),
        (
            "void f(void) { __try { g = ext(); } __except (g) { g = 2; } }",
            "SEH non-constant filter not implemented yet",
        ),
        (
            "void f(void) { __try { g = ext(); } __except (EXCEPTION_CONTINUE_EXECUTION) { g = 2; } }",
            "SEH filter other than EXCEPTION_EXECUTE_HANDLER",
        ),
    ];
    for target in WINDOWS {
        assert_eq!(object_error(CAUGHT, target), None, "{target:?}");
        for (body, needle) in rows {
            let msg = object_error(body, target).expect("refused");
            assert!(msg.contains(needle), "{target:?} {body}: {msg}");
            assert!(
                !msg.contains("internal compiler error"),
                "{target:?}: {msg}"
            );
        }
    }
}

/// An image written in one step has no stub for the language handler, and
/// the interpreter has no exception dispatch: both refuse a region.
#[cfg(feature = "full")]
#[test]
fn an_unlinked_image_and_the_interpreter_refuse_a_region() {
    for target in WINDOWS {
        let program = Compiler::with_target(PROGRAM.into(), target)
            .compile()
            .expect("front end");
        let msg = crate::emit_native_with_options(&program, target, crate::NativeOptions::new())
            .expect_err("wrote an image")
            .to_string();
        assert!(
            msg.contains("compile with -c and link the object"),
            "{target:?}: {msg}"
        );
        let msg = crate::Vm::new(program)
            .run()
            .expect_err("interpreted")
            .to_string();
        assert!(
            msg.contains("SEH under the interpreter not implemented yet"),
            "{target:?}: {msg}"
        );
    }
}

/// A linked image's unwind record for a function with a region names the
/// language handler (x64 UNW_FLAG_EHANDLER, arm64 X bit) through a stub
/// that jumps through its import slot, and a scope table whose rows give
/// the constant filter 1 and a handler inside the function.
#[cfg(feature = "full")]
#[test]
fn a_linked_image_carries_the_scope_table() {
    for target in WINDOWS {
        let program = Compiler::with_target(PROGRAM.into(), target)
            .compile()
            .expect("front end");
        let pe = super::link_executable_with_runtime(&program, target, crate::NativeOptions::new())
            .expect("link");
        let tables = pe_scope_tables(&pe, target == Target::WindowsX64);
        assert_eq!(tables.len(), 1, "{target:?}: {tables:?}");
        let (begin, end, rows) = &tables[0];
        assert_eq!(rows.len(), 1, "{target:?}: {rows:?}");
        let [lo, hi, filter, jump] = rows[0];
        assert!(
            begin <= &lo && lo < hi && hi <= *end,
            "{target:?}: {rows:?} in {begin:#x}..{end:#x}"
        );
        assert_eq!(filter, 1, "{target:?}");
        assert!(
            (*begin..*end).contains(&jump) && !(lo..hi).contains(&jump),
            "{target:?}: {rows:?}"
        );
    }
}

/// Per function whose unwind record carries a language handler: its
/// begin and end RVAs and its scope-table rows.
#[cfg(feature = "full")]
fn pe_scope_tables(pe: &[u8], x64: bool) -> alloc::vec::Vec<(u32, u32, alloc::vec::Vec<[u32; 4]>)> {
    let word = |at: usize| u32::from_le_bytes(pe[at..at + 4].try_into().unwrap());
    let pe_off = word(0x3c) as usize;
    let n_sec = u16::from_le_bytes(pe[pe_off + 6..pe_off + 8].try_into().unwrap()) as usize;
    let opt = pe_off + 24;
    let so_hdr = u16::from_le_bytes(pe[pe_off + 20..pe_off + 22].try_into().unwrap()) as usize;
    let rva_off = |rva: u32| {
        (0..n_sec).find_map(|i| {
            let s = opt + so_hdr + i * 40;
            let (va, span, raw) = (word(s + 12), word(s + 8).max(word(s + 16)), word(s + 20));
            (rva >= va && rva < va + span).then(|| (raw + rva - va) as usize)
        })
    };
    // Data directory 3: the exception table.
    let (dir, size) = (word(opt + 112 + 24), word(opt + 112 + 28));
    let start = rva_off(dir).expect("exception directory");
    let entry = if x64 { 12 } else { 8 };
    let mut out = alloc::vec::Vec::new();
    for e in (0..size as usize / entry).map(|i| start + i * entry) {
        let begin = word(e);
        let info = if x64 { word(e + 8) } else { word(e + 4) };
        if !x64 && info & 3 != 0 {
            continue;
        }
        let at = rva_off(info).expect("unwind record");
        let (end, data) = if x64 {
            if pe[at] >> 3 & 1 == 0 {
                continue;
            }
            let codes = (usize::from(pe[at + 2]) + 1) & !1;
            (word(e + 4), at + 4 + 2 * codes)
        } else {
            let header = word(at);
            if header >> 20 & 1 == 0 {
                continue;
            }
            let (words, epilogs) = (header >> 27, header >> 22 & 31);
            let (code_words, epilogs, ext) = if words == 0 && epilogs == 0 {
                let x = word(at + 4);
                (x >> 16 & 0xFF, x & 0xFFFF, 4)
            } else {
                (words, if header >> 21 & 1 == 1 { 0 } else { epilogs }, 0)
            };
            let data = at + 4 + ext + 4 * (epilogs + code_words) as usize;
            (begin + 4 * (header & 0x3_FFFF), data)
        };
        let count = word(data + 4) as usize;
        let rows = (0..count)
            .map(|i| core::array::from_fn(|k| word(data + 8 + 16 * i + 4 * k)))
            .collect();
        out.push((begin, end, rows));
    }
    out
}

//! Microsoft structured exception handling in the front end: `__try`,
//! `__except`, `__finally` and `__leave` are keywords on the PE targets
//! and identifiers elsewhere, and each placement rule cl enforces (C2703,
//! C2705, C2707, C2184) is an error, as are the jumps out of a `__finally`
//! block cl warns about (C4532) and out of an `__except` filter, which is
//! a function of its own.

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
        "void f(void) { for (;;) { __try { g = ext(); } __except (({ break; 1; })) { g = 2; } } }",
        "`break` jumps out of an `__except` filter",
    ),
    (
        "int f(void) { __try { g = ext(); } __except (({ return 2; 1; })) { g = 2; } return 0; }",
        "`return` jumps out of an `__except` filter",
    ),
    (
        "void f(void) { __try { __try { g = ext(); } __except (({ __leave; 1; })) { g = 2; } } __except (1) { g = 3; } }",
        "`__leave` jumps out of an `__except` filter",
    ),
    (
        "void f(void) { __try { g = ext(); } __except (({ goto out; 1; })) { g = 2; } out: g = 3; }",
        "`goto` in an `__except` filter",
    ),
    (
        "void f(void) { __try { g = ext(); } __except (({ __try { g = 1; } __except (1) { g = 2; } 1; })) { g = 3; } }",
        "a `__try` statement in an `__except` filter",
    ),
    (
        "void f(int n) { __try { g = ext(); } __except (((char *)__builtin_alloca(n))[0] = 1) { g = 2; } }",
        "`_alloca` or a variable-length array cannot be used in a filter expression",
    ),
    (
        "void f(int n) { __try { g = ext(); } __except (({ char v[n]; v[0] = 1; })) { g = 2; } }",
        "`_alloca` or a variable-length array cannot be used in a filter expression",
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
    "void f(void) { __try { g = ext(); } __except (({ int n = 0; for (;;) { if (++n > 2) break; } n == 3; })) { g = 2; } }",
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

/// Funclets inside a `__finally` block, and a `__finally` block that
/// allocates on its stack, lower to objects on both PE targets.
#[cfg(feature = "full")]
#[test]
fn nested_and_allocating_funclets_compile() {
    let rows = [
        "void f(void) { __try { g = ext(); } __finally { __try { g = 1; } __finally { g = 2; } } }",
        "void f(void) { __try { g = ext(); } __finally { __try { g = 1; } __except (g) { g = 2; } } }",
        "void f(int n) { __try { g = ext(); } __finally { char v[n]; v[0] = 1; g = v[0]; } }",
        "void f(int n) { __try { g = ext(); } __finally { g = ((char *)__builtin_alloca(n))[0] = 1; } }",
    ];
    for target in WINDOWS {
        assert_eq!(object_error(CAUGHT, target), None, "{target:?}");
        for body in rows {
            assert_eq!(object_error(body, target), None, "{target:?} {body}");
        }
    }
}

/// A `__try` statement inside a `__finally` block gives the block's funclet
/// a scope table of its own, whose row names a filter funclet of its own;
/// on x64 the function's record carries UNW_FLAG_UHANDLER and the funclet's
/// UNW_FLAG_EHANDLER.
#[cfg(feature = "full")]
#[test]
fn a_try_inside_a_finally_block_gives_its_funclet_a_scope_table() {
    let src = "#include <windows.h>\nint g;\nint ext(void) { return g + 5; }\n\
        int f(int n) { int r = 0; __try { r = ext(); } __finally { char v[n]; v[0] = (char)r; \
        __try { g = ext() + v[0]; } __except (g == r) { g = 2; } } return r; }\n\
        int main(void) { return f(3); }\n";
    for target in WINDOWS {
        let program = Compiler::with_target(src.into(), target)
            .compile()
            .expect("front end");
        let pe = super::link_executable_with_runtime(&program, target, crate::NativeOptions::new())
            .expect("link");
        let x64 = target == Target::WindowsX64;
        let tables = pe_scope_tables(&pe, x64);
        let starts = pe_function_starts(&pe, x64);
        assert_eq!(tables.len(), 2, "{target:?}: {tables:?}");
        let fin = (tables.iter())
            .find_map(|(_, _, rows)| (rows[0][3] == 0).then_some(rows[0][2]))
            .expect("finally row");
        let (_, _, rows) = (tables.iter())
            .find(|(begin, _, _)| *begin == fin)
            .expect("the funclet's scope table");
        let [_, _, filter, jump] = rows[0];
        assert!(
            starts.contains(&filter) && filter != fin && jump != 0,
            "{target:?}: {tables:?}"
        );
        if x64 {
            let mut flags = pe_handler_flags(&pe);
            flags.sort();
            assert_eq!(flags, [0x09, 0x11], "{target:?}");
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

/// A filter other than the constant EXCEPTION_EXECUTE_HANDLER, the constant
/// EXCEPTION_CONTINUE_SEARCH included, is a funclet of its own, as cl
/// compiles it: the row's HandlerAddress is the start of a function with
/// its own unwind entry, outside the function the region lies in.
#[cfg(feature = "full")]
#[test]
fn a_filter_is_a_funclet_the_scope_table_names() {
    let src = "#include <windows.h>\nint g;\nint ext(void) { return g + 5; }\n\
        int f(void) { int r = 0; __try { r = ext(); } __except (r == 0) { r = 1; } return r; }\n\
        int h(void) { __try { g = ext(); } __except (EXCEPTION_CONTINUE_SEARCH) { g = 2; } return g; }\n\
        int main(void) { return f() + h(); }\n";
    for target in WINDOWS {
        let program = Compiler::with_target(src.into(), target)
            .compile()
            .expect("front end");
        let pe = super::link_executable_with_runtime(&program, target, crate::NativeOptions::new())
            .expect("link");
        let x64 = target == Target::WindowsX64;
        let tables = pe_scope_tables(&pe, x64);
        let starts = pe_function_starts(&pe, x64);
        assert_eq!(tables.len(), 2, "{target:?}: {tables:?}");
        for (begin, end, rows) in &tables {
            assert_eq!(rows.len(), 1, "{target:?}: {rows:?}");
            let [_, _, filter, _] = rows[0];
            assert!(
                filter != 1 && !(*begin..*end).contains(&filter) && starts.contains(&filter),
                "{target:?}: {filter:#x} for {begin:#x}..{end:#x} among {starts:x?}"
            );
        }
    }
}

/// A `__finally` region's row names its funclet as HandlerAddress, with
/// JumpTarget 0, and an x64 unwind record carries UNW_FLAG_UHANDLER for it,
/// with UNW_FLAG_EHANDLER too where an `__except` region shares the
/// function: 0x11 and 0x19 in the header byte, as cl writes them.
#[cfg(feature = "full")]
#[test]
fn a_finally_row_names_its_funclet_and_no_target() {
    let src = "#include <windows.h>\nint g;\nint ext(void) { return g + 5; }\n\
        int f(void) { __try { g = ext(); } __finally { g = 1; } return g; }\n\
        int h(void) { __try { __try { g = ext(); } __finally { g = 1; } } __except (1) { g = 2; } return g; }\n\
        int main(void) { return f() + h(); }\n";
    for target in WINDOWS {
        let program = Compiler::with_target(src.into(), target)
            .compile()
            .expect("front end");
        let pe = super::link_executable_with_runtime(&program, target, crate::NativeOptions::new())
            .expect("link");
        let x64 = target == Target::WindowsX64;
        let tables = pe_scope_tables(&pe, x64);
        let starts = pe_function_starts(&pe, x64);
        assert_eq!(tables.len(), 2, "{target:?}: {tables:?}");
        let mut row_counts: alloc::vec::Vec<usize> = tables.iter().map(|t| t.2.len()).collect();
        row_counts.sort();
        assert_eq!(row_counts, [1, 2], "{target:?}: {tables:?}");
        for (_, _, rows) in &tables {
            let [_, _, handler, jump] = rows[0];
            assert!(
                jump == 0 && starts.contains(&handler),
                "{target:?}: {rows:?}"
            );
        }
        if x64 {
            let mut flags = pe_handler_flags(&pe);
            flags.sort();
            assert_eq!(flags, [0x11, 0x19], "{target:?}");
        }
    }
}

/// `.pdata` holds the RUNTIME_FUNCTION array alone, the extent the exception
/// directory gives, and every unwind record an entry points to lies in
/// `.rdata`, where link.exe and lld-link place `.xdata`: a reader that takes
/// the section as the array, as llvm-readobj does, reads each entry.
#[cfg(feature = "full")]
#[test]
fn pdata_holds_the_array_alone_and_the_unwind_records_lie_in_rdata() {
    let src = "#include <windows.h>\nint g;\nint ext(void) { return g + 5; }\n\
        int f(void) { int r = 0; __try { r = ext(); } __except (r == 0) { r = 1; } return r; }\n\
        int h(int n) { int s = 0; for (int i = 0; i < n; i++) s += ext() * i; return s; }\n\
        int main(void) { return f() + h(3); }\n";
    let word = |pe: &[u8], at: usize| u32::from_le_bytes(pe[at..at + 4].try_into().unwrap());
    let section = |pe: &[u8], name: &[u8]| {
        let pe_off = word(pe, 0x3c) as usize;
        let n = u16::from_le_bytes(pe[pe_off + 6..pe_off + 8].try_into().unwrap()) as usize;
        let opt = u16::from_le_bytes(pe[pe_off + 20..pe_off + 22].try_into().unwrap()) as usize;
        (0..n)
            .map(|i| pe_off + 24 + opt + i * 40)
            .find(|&s| pe[s..s + 8].starts_with(name))
            .map(|s| (word(pe, s + 12), word(pe, s + 8)))
            .expect("section")
    };
    for target in WINDOWS {
        let program = Compiler::with_target(src.into(), target)
            .compile()
            .expect("front end");
        let pe = super::link_executable_with_runtime(&program, target, crate::NativeOptions::new())
            .expect("link");
        let x64 = target == Target::WindowsX64;
        let opt = word(&pe, 0x3c) as usize + 24;
        let directory = (word(&pe, opt + 112 + 24), word(&pe, opt + 112 + 28));
        assert_eq!(directory, section(&pe, b".pdata\0"), "{target:?}");
        let (rdata, rdata_size) = section(&pe, b".rdata\0");
        let (start, count, entry) = exception_table(&pe, x64);
        let mut records = 0;
        for e in (0..count).map(|i| start + i * entry) {
            let info = word(&pe, e + if x64 { 8 } else { 4 });
            // An arm64 entry whose low bits are set packs its unwind data.
            if !x64 && info & 3 != 0 {
                continue;
            }
            assert!(
                (rdata..rdata + rdata_size).contains(&info),
                "{target:?}: the entry at {:#x} points to {info:#x}",
                word(&pe, e)
            );
            records += 1;
        }
        assert!(records >= 3, "{target:?}: {records} records");
    }
}

/// In a linked Windows on ARM64 image, every `ret` of a function with an
/// `.xdata` record ends an epilog scope as the unwinder locates it: one in
/// the header (E bit) ends the function, one in the list starts at its
/// offset, and either spans its codes up to `end` plus the `ret`. Folded,
/// top-block, frame-only, large, dynamic and variadic frames, with one exit
/// and several, at -O0 and -O, with and without `-mbranch-protection`.
#[cfg(feature = "full")]
#[test]
fn every_arm64_return_ends_an_epilog_scope() {
    let src = "long ext(long);\n\
        long several(long a, long b) { if (a > b) return ext(a) * 2; if (a < 0) return ext(b) - a; return a + b; }\n\
        long saves(long a) { long b = a * 3, c = b ^ 7; long r = ext(a); return r + b + c; }\n\
        long wide(long a) { volatile char buf[600]; buf[a & 7] = 1; return ext(buf[a & 3]) + a; }\n\
        long huge(long a) { volatile char buf[70000]; buf[a & 7] = 1; return ext(buf[a & 3]); }\n\
        long vla(long n) { char buf[(n & 15) + 8]; buf[n & 7] = 1; return ext(buf[n & 3]) + n; }\n\
        long sum(int n, ...) { __builtin_va_list ap; __builtin_va_start(ap, n); long s = 0;\n\
            for (int i = 0; i < n; i++) s += __builtin_va_arg(ap, long);\n\
            __builtin_va_end(ap); return ext(s) + s; }\n\
        long ext(long a) { return a + 1; }\n\
        int main(int argc, char **argv) { (void)argv; return (int)(several(argc, 2) + saves(argc)\n\
            + wide(argc) + huge(argc) + vla(argc) + sum(2, 1L, 2L)); }\n";
    const RET: u32 = 0xD65F_03C0;
    let program = Compiler::with_target(src.into(), Target::WindowsAarch64)
        .compile()
        .expect("front end");
    let mut listed = 0;
    let signed = crate::Hardening {
        bti: true,
        pac_ret: true,
        ..crate::Hardening::NONE
    };
    for (hardening, optimize) in [
        (crate::Hardening::NONE, false),
        (crate::Hardening::NONE, true),
        (signed, false),
        (signed, true),
    ] {
        let opts = crate::NativeOptions {
            hardening,
            optimize,
            ..crate::NativeOptions::new()
        };
        let pe = super::link_executable_with_runtime(&program, Target::WindowsAarch64, opts)
            .expect("link");
        let word = |at: usize| u32::from_le_bytes(pe[at..at + 4].try_into().unwrap());
        let (start, count, entry) = exception_table(&pe, false);
        let mut header = 0;
        for e in (0..count).map(|i| start + i * entry) {
            let (begin, info) = (word(e), word(e + 4));
            if info & 3 != 0 {
                continue;
            }
            let at = pe_rva_offset(&pe, info).expect("record");
            let (len, scopes) = arm64_epilog_scopes(&pe[at..]);
            let text = pe_rva_offset(&pe, begin).expect("function");
            let rets: alloc::vec::Vec<u32> = (0..len)
                .step_by(4)
                .filter(|&r| word(text + r as usize) == RET)
                .collect();
            let ends: alloc::vec::Vec<u32> = scopes.iter().map(|&(s, size)| s + size - 4).collect();
            assert_eq!(
                rets, ends,
                "{hardening:?} -O={optimize}: {begin:#x} {scopes:x?}"
            );
            let packed = word(at) & 1 << 21 != 0;
            header += usize::from(packed);
            listed += usize::from(!packed && scopes.len() >= 2);
        }
        assert!(
            header >= 2,
            "{hardening:?} -O={optimize}: {header} in the header"
        );
    }
    assert!(listed >= 2, "{listed} lists of several scopes");
}

/// The function length of the ARM64 `.xdata` record at the start of `x`,
/// and each epilog scope's offset and size in bytes, its `ret` included,
/// as the unwinder computes them from the codes.
#[cfg(feature = "full")]
fn arm64_epilog_scopes(x: &[u8]) -> (u32, alloc::vec::Vec<(u32, u32)>) {
    let word = |at: usize| u32::from_le_bytes(x[at..at + 4].try_into().unwrap());
    let h = word(0);
    let (len, packed) = ((h & 0x3FFFF) * 4, h & 1 << 21 != 0);
    let (mut count, mut words, mut at) = ((h >> 22) & 31, h >> 27, 4);
    if count == 0 && words == 0 {
        (count, words, at) = (word(4) & 0xFFFF, (word(4) >> 16) & 0xFF, 8);
    }
    let list = if packed { 0 } else { count as usize };
    let codes = &x[at + 4 * list..at + 4 * list + 4 * words as usize];
    // The instructions from `index`: one per code up to `end`, then the `ret`.
    let size = |mut index: usize| {
        let mut n = 1;
        while codes[index] & 0xFE != 0xE4 {
            index += match codes[index] {
                0x00..=0xBF | 0xE1 | 0xE3 | 0xE6 | 0xFC => 1,
                0xC0..=0xDF | 0xE2 => 2,
                0xE0 => 4,
                c => panic!("unwind code {c:#x}"),
            };
            n += 1;
        }
        4 * n
    };
    if packed {
        let s = size(count as usize);
        return (len, alloc::vec![(len - s, s)]);
    }
    let scopes = (0..list)
        .map(|i| word(at + 4 * i))
        .map(|w| ((w & 0x3FFFF) * 4, size((w >> 22) as usize)))
        .collect();
    (len, scopes)
}

/// The header byte of each x64 unwind record with a handler flag.
#[cfg(feature = "full")]
fn pe_handler_flags(pe: &[u8]) -> alloc::vec::Vec<u8> {
    let (start, count, entry) = exception_table(pe, true);
    let word = |at: usize| u32::from_le_bytes(pe[at..at + 4].try_into().unwrap());
    (0..count)
        .filter_map(|i| pe_rva_offset(pe, word(start + i * entry + 8)))
        .map(|at| pe[at])
        .filter(|&b| b >> 3 & 3 != 0)
        .collect()
}

/// The begin RVA of each entry of the exception table.
#[cfg(feature = "full")]
fn pe_function_starts(pe: &[u8], x64: bool) -> alloc::vec::Vec<u32> {
    let (start, count, entry) = exception_table(pe, x64);
    let word = |at: usize| u32::from_le_bytes(pe[at..at + 4].try_into().unwrap());
    (0..count).map(|i| word(start + i * entry)).collect()
}

/// The file offset of the exception table, its entry count and entry size.
#[cfg(feature = "full")]
fn exception_table(pe: &[u8], x64: bool) -> (usize, usize, usize) {
    let word = |at: usize| u32::from_le_bytes(pe[at..at + 4].try_into().unwrap());
    let pe_off = word(0x3c) as usize;
    let opt = pe_off + 24;
    let (dir, size) = (word(opt + 112 + 24), word(opt + 112 + 28));
    let start = pe_rva_offset(pe, dir).expect("exception directory");
    let entry = if x64 { 12 } else { 8 };
    (start, size as usize / entry, entry)
}

/// The file offset of `rva`.
#[cfg(feature = "full")]
fn pe_rva_offset(pe: &[u8], rva: u32) -> Option<usize> {
    let word = |at: usize| u32::from_le_bytes(pe[at..at + 4].try_into().unwrap());
    let pe_off = word(0x3c) as usize;
    let n_sec = u16::from_le_bytes(pe[pe_off + 6..pe_off + 8].try_into().unwrap()) as usize;
    let so_hdr = u16::from_le_bytes(pe[pe_off + 20..pe_off + 22].try_into().unwrap()) as usize;
    (0..n_sec).find_map(|i| {
        let s = pe_off + 24 + so_hdr + i * 40;
        let (va, span, raw) = (word(s + 12), word(s + 8).max(word(s + 16)), word(s + 20));
        (rva >= va && rva < va + span).then(|| (raw + rva - va) as usize)
    })
}

/// Per function whose unwind record carries a language handler: its
/// begin and end RVAs and its scope-table rows.
#[cfg(feature = "full")]
fn pe_scope_tables(pe: &[u8], x64: bool) -> alloc::vec::Vec<(u32, u32, alloc::vec::Vec<[u32; 4]>)> {
    let word = |at: usize| u32::from_le_bytes(pe[at..at + 4].try_into().unwrap());
    // Data directory 3: the exception table.
    let (start, count, entry) = exception_table(pe, x64);
    let mut out = alloc::vec::Vec::new();
    for e in (0..count).map(|i| start + i * entry) {
        let begin = word(e);
        let info = if x64 { word(e + 8) } else { word(e + 4) };
        if !x64 && info & 3 != 0 {
            continue;
        }
        let at = pe_rva_offset(pe, info).expect("unwind record");
        let (end, data) = if x64 {
            // UNW_FLAG_EHANDLER or UNW_FLAG_UHANDLER.
            if pe[at] >> 3 & 3 == 0 {
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

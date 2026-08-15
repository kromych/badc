//! End-to-end native-codegen tests: compile a C source, write a
//! Mach-O, ad-hoc-sign it, exec it, check the exit code.
//!
//! Gated to macOS because the produced binary is a Mach-O that links
//! libSystem -- nothing else can load it, and `codesign` only exists
//! on Darwin. CI on other OSes skips these.

#![cfg(target_os = "macos")]

use std::io::Write;
use std::path::Path;
use std::process::Command;

use super::fixture_tables::NATIVE_FIXTURES;
use crate::{Compiler, NativeOptions, Target, emit_native, emit_native_with_options};

/// Outcome of compiling-and-running a native binary. The fine-grained
/// variants let the parity test report which kind of failure each
/// fixture hit instead of panicking at the first crash.
#[derive(Debug)]
#[allow(dead_code)] // payloads are read via the derived Debug fmt only
enum RunOutcome {
    /// Process exited normally with this code.
    Exit(i32),
    /// Process was killed by a signal -- typically SIGSEGV (11) when
    /// our codegen produces something the CPU rejects.
    Signal(i32),
    /// Compiling or emit_native returned an error.
    BuildError(String),
}

impl RunOutcome {
    fn matches(&self, expected: i32) -> bool {
        matches!(self, RunOutcome::Exit(c) if *c == expected)
    }
}

/// Convenience wrapper for tests that expect a normal `exit(N)`
/// result. Panics on anything else (signal, build error, ...).
fn build_and_run(src: &str, stem: &str) -> i32 {
    match build_and_run_outcome(src, stem) {
        RunOutcome::Exit(c) => c,
        other => panic!("expected normal exit, got {other:?}"),
    }
}

/// Compile inline C source, emit native, sign, run. Returns a
/// [`RunOutcome`] describing what happened.
fn build_and_run_outcome(src: &str, stem: &str) -> RunOutcome {
    build_and_run_outcome_with_options(src, stem, NativeOptions::default())
}

fn build_and_run_outcome_with_options(src: &str, stem: &str, opts: NativeOptions) -> RunOutcome {
    let program = match Compiler::new(super::with_prelude(src)).compile() {
        Ok(p) => p,
        Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
    };
    emit_sign_run(&program, stem, opts)
}

/// [`build_and_run_outcome`] without [`super::TEST_PRELUDE`], for
/// sources whose binding scope is part of what the test asserts.
fn build_and_run_outcome_bare(src: &str, stem: &str) -> RunOutcome {
    let program = match Compiler::new(src.to_string()).compile() {
        Ok(p) => p,
        Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
    };
    emit_sign_run(&program, stem, NativeOptions::default())
}

/// Emit `program` for macOS arm64, write, ad-hoc-sign, exec, classify.
fn emit_sign_run(program: &crate::c5::Program, stem: &str, opts: NativeOptions) -> RunOutcome {
    let bytes = match emit_native_with_options(program, Target::MacOSAarch64, opts) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let path = super::unique_temp_path("badc-test", stem, ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
    }
    set_executable(&path);
    codesign(&path);

    let output = Command::new(&path)
        .output()
        .expect("could not exec the produced binary");
    let _ = std::fs::remove_file(&path);
    if let Some(code) = output.status.code() {
        RunOutcome::Exit(code)
    } else {
        use std::os::unix::process::ExitStatusExt;
        let signal = output.status.signal().unwrap_or(0);
        RunOutcome::Signal(signal)
    }
}

fn set_executable(path: &Path) {
    use std::os::unix::fs::PermissionsExt;
    let meta = std::fs::metadata(path).unwrap();
    let mut perms = meta.permissions();
    perms.set_mode(perms.mode() | 0o111);
    std::fs::set_permissions(path, perms).unwrap();
}

fn codesign(path: &Path) {
    let status = Command::new("/usr/bin/codesign")
        .args(["--sign", "-", "--force"])
        .arg(path)
        .status()
        .expect("codesign not available");
    assert!(status.success(), "codesign failed for {path:?}: {status:?}");
}

#[test]
fn return_42() {
    assert_eq!(build_and_run("int main() { return 42; }", "ret42"), 42);
}

/// Link + run a source through the startup runtime (`__c5_entry`),
/// signing before exec. Mirrors `build_and_run` but takes the full
/// link path so `__attribute__((constructor))` functions run: dyld
/// enters `__c5_entry` via `LC_MAIN`, which walks the linker's
/// `.init_array`. Returns (exit code, stdout).
fn link_run_capture(src: &str, stem: &str) -> (i32, String) {
    use crate::{Compiler, NativeOptions, Target};
    let program = Compiler::new(super::with_prelude(src))
        .compile()
        .expect("compile");
    let bytes = super::link_executable_with_runtime(
        &program,
        Target::MacOSAarch64,
        NativeOptions::default(),
    )
    .expect("link with runtime");
    let path = super::unique_temp_path("badc-test", stem, ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
    }
    set_executable(&path);
    codesign(&path);
    let output = Command::new(&path).output().expect("exec produced binary");
    let _ = std::fs::remove_file(&path);
    let code = output.status.code().unwrap_or(-1);
    (code, String::from_utf8_lossy(&output.stdout).into_owned())
}

#[test]
fn constructor_runs_before_main() {
    // A `static` constructor sets a global `main` returns; a non-zero
    // exit proves it ran first, through `LC_MAIN` -> `__c5_entry` ->
    // `.init_array`.
    let (code, _) = link_run_capture(
        "static int g;\n\
         __attribute__((constructor)) static void ctor(void) { g = 42; }\n\
         int main(void) { return g; }\n",
        "mac-ctor",
    );
    assert_eq!(code, 42, "constructor must run before main");
}

#[test]
fn constructor_priority_and_destructor_order() {
    // Prioritized constructors run ascending, unprioritized last, then
    // main, then the destructor via the atexit chain at exit.
    let (_, stdout) = link_run_capture(
        "#include <stdio.h>\n\
         __attribute__((constructor(102))) static void c2(void) { printf(\"c2\\n\"); }\n\
         __attribute__((constructor(101))) static void c1(void) { printf(\"c1\\n\"); }\n\
         __attribute__((constructor)) static void c3(void) { printf(\"c3\\n\"); }\n\
         __attribute__((destructor)) static void d1(void) { printf(\"d1\\n\"); }\n\
         int main(void) { printf(\"main\\n\"); return 0; }\n",
        "mac-ctor-order",
    );
    assert_eq!(stdout, "c1\nc2\nc3\nmain\nd1\n");
}

#[test]
fn constructor_on_prototype_runs_before_main() {
    // The attribute sits on a separate prototype and the definition is
    // bare; the declaration's attributes merge onto the definition, so
    // the `.init_array` entry is still emitted.
    let (code, _) = link_run_capture(
        "static int g;\n\
         static void ctor(void) __attribute__((constructor));\n\
         static void ctor(void) { g = 42; }\n\
         int main(void) { return g; }\n",
        "mac-ctor-proto",
    );
    assert_eq!(
        code, 42,
        "prototype-declared constructor must run before main"
    );
}

#[test]
fn constructor_prototype_priority_and_destructor_order() {
    // Priority and destructor forms declared on prototypes, defined
    // bare: prioritized constructors ascending, unprioritized last,
    // main, then the destructor at exit.
    let (_, stdout) = link_run_capture(
        "#include <stdio.h>\n\
         static void c2(void) __attribute__((constructor(102)));\n\
         static void c2(void) { printf(\"c2\\n\"); }\n\
         static void c1(void) __attribute__((constructor(101)));\n\
         static void c1(void) { printf(\"c1\\n\"); }\n\
         static void c3(void) __attribute__((constructor));\n\
         static void c3(void) { printf(\"c3\\n\"); }\n\
         static void d1(void) __attribute__((destructor));\n\
         static void d1(void) { printf(\"d1\\n\"); }\n\
         int main(void) { printf(\"main\\n\"); return 0; }\n",
        "mac-ctor-proto-order",
    );
    assert_eq!(stdout, "c1\nc2\nc3\nmain\nd1\n");
}

#[test]
fn return_zero() {
    assert_eq!(build_and_run("int main() { return 0; }", "ret0"), 0);
}

#[test]
fn return_arbitrary_small_int() {
    // Pick a number unlikely to collide with a kernel signal exit
    // (which would surface as `status.code() == None` and trip the
    // panic in build_and_run).
    assert_eq!(build_and_run("int main() { return 7; }", "ret7"), 7);
}

#[test]
fn return_value_truncates_to_byte() {
    // `wait()` reports the low 8 bits of main's return. 256 -> 0,
    // 257 -> 1, 0xFF -> 255. We pick 0x101 (257) so a buggy codegen
    // that, say, only stored the low 16 bits would still pass the
    // 0/42 tests but flunk this one.
    assert_eq!(build_and_run("int main() { return 257; }", "ret257"), 1);
}

#[test]
fn string_literal_store_faults() {
    // C99 6.4.5p6 leaves the store undefined; the literal lives in
    // `__TEXT,__const`, so the write hits a non-writable mapping.
    let src = "int main(void) { char *p = \"immutable\"; p[0] = 'X'; return 0; }";
    match build_and_run_outcome(src, "lit_store") {
        RunOutcome::Signal(_) => {}
        other => panic!("store through a string literal must fault, got {other:?}"),
    }
    // Writable storage a literal initializes stays writable: the
    // array is the object, the literal is only its initializer image.
    let src = "char buf[] = \"abc\"; \
               int main(void) { buf[0] = 'X'; return buf[0] == 'X' ? 0 : 1; }";
    assert_eq!(build_and_run(src, "lit_copy_store"), 0);
    // Reading a literal through a relocated const pointer crosses
    // from the writable slot into the read-only region.
    let src = "const char *const cp = \"readback\"; \
               int main(void) { return cp[0] == 'r' ? 0 : 1; }";
    assert_eq!(build_and_run(src, "lit_readback"), 0);
    // The multi-TU link path (object merge -> Mach-O) enforces the
    // same mapping; a signal surfaces as a `None` exit code here.
    let (code, _) = link_run_capture(
        "int main(void) { char *p = \"immutable\"; p[0] = 'X'; return 0; }",
        "lit_store_linked",
    );
    assert_eq!(code, -1, "linked-image literal store must die on a signal");
}

#[test]
fn bss_segregation_maps_and_zero_fills() {
    // With segregation on, wholly-zero globals leave `__data` for the
    // `__DATA` segment's `vmsize > filesize` zero-fill tail. The array
    // is larger than the page padding, so without the vmsize tail its
    // trailing reads fault; the pointer initializer must also resolve
    // to the global's runtime address in the tail.
    let opts = NativeOptions {
        bss_segregate: true,
        ..NativeOptions::default()
    };
    let src = "static long zeros[4096]; long *const p = &zeros[3000]; \
               int main(void){ int ok = 1; \
               for (int i = 0; i < 4096; i++) ok &= (zeros[i] == 0); \
               zeros[3000] = 99; ok &= (zeros[3000] == 99); \
               ok &= (p == &zeros[3000]); ok &= (*p == 99); \
               return ok ? 0 : 1; }";
    match build_and_run_outcome_with_options(src, "bss_segregate", opts) {
        RunOutcome::Exit(0) => {}
        other => panic!("segregated .bss program must exit 0, got {other:?}"),
    }
}

/// Executed companion to the `-mstrict-align` marshalling encoding
/// checks: composing an eightbyte or HFA member from narrower accesses
/// must reproduce the value the whole-width load would have read. Every
/// aggregate here has alignment 1 and sits at an odd address, so each
/// access the marshalling emits is under-aligned at its natural width.
/// Covers the caller-side argument gather (direct and indirect calls,
/// integer eightbytes, HFA members, System V SSE eightbytes), the
/// by-value return gather, and the oversize by-stack / indirect-result
/// transfers.
#[test]
fn strict_align_marshals_an_under_aligned_aggregate() {
    const SRC: &str = "struct __attribute__((packed)) P9 { char c; int a, b; };\n\
         struct __attribute__((packed)) H2 { float a, b; };\n\
         struct __attribute__((packed)) P25 { char c; long a, b, d; };\n\
         static int sum_of(const char *p, int n) {\n\
         \tint s = 0;\n\
         \tfor (int i = 0; i < n; i++) s += (int)(unsigned char)p[i];\n\
         \treturn s;\n\
         }\n\
         static int bytes_equal(const char *x, const char *y, int n) {\n\
         \tfor (int i = 0; i < n; i++) if (x[i] != y[i]) return 0;\n\
         \treturn 1;\n\
         }\n\
         int sink_p(struct P9 v) { return sum_of((const char *)&v, (int)sizeof v); }\n\
         int sink_h(struct H2 v) { return sum_of((const char *)&v, (int)sizeof v); }\n\
         int sink_big(struct P25 v) { return sum_of((const char *)&v, (int)sizeof v); }\n\
         struct P9 fetch_p(struct P9 *q) { return *q; }\n\
         struct H2 fetch_h(struct H2 *q) { return *q; }\n\
         struct P25 fetch_big(struct P25 *q) { return *q; }\n\
         int (*volatile vp)(struct P9) = sink_p;\n\
         int (*volatile vh)(struct H2) = sink_h;\n\
         int main(void) {\n\
         \tchar buf[80];\n\
         \tchar *raw = buf + 1;\n\
         \tfor (int i = 0; i < 79; i++) raw[i] = (char)(i * 7 + 3);\n\
         \tstruct P9 *p = (struct P9 *)raw;\n\
         \tstruct H2 *h = (struct H2 *)(raw + 32);\n\
         \tstruct P25 *b = (struct P25 *)(raw + 40);\n\
         \tif (sink_p(*p) != sum_of(raw, (int)sizeof *p)) return 1;\n\
         \tif (sink_h(*h) != sum_of(raw + 32, (int)sizeof *h)) return 2;\n\
         \tif (sink_big(*b) != sum_of(raw + 40, (int)sizeof *b)) return 3;\n\
         \tif (vp(*p) != sum_of(raw, (int)sizeof *p)) return 4;\n\
         \tif (vh(*h) != sum_of(raw + 32, (int)sizeof *h)) return 5;\n\
         \tstruct P9 rp = fetch_p(p);\n\
         \tstruct H2 rh = fetch_h(h);\n\
         \tstruct P25 rb = fetch_big(b);\n\
         \tif (!bytes_equal((const char *)&rp, raw, (int)sizeof rp)) return 6;\n\
         \tif (!bytes_equal((const char *)&rh, raw + 32, (int)sizeof rh)) return 7;\n\
         \tif (!bytes_equal((const char *)&rb, raw + 40, (int)sizeof rb)) return 8;\n\
         \treturn 42;\n\
         }\n";
    for optimize in [false, true] {
        let opts = NativeOptions {
            strict_align: true,
            optimize,
            ..NativeOptions::default()
        };
        match build_and_run_outcome_with_options(SRC, "strict_align_marshal", opts) {
            RunOutcome::Exit(42) => {}
            other => panic!("strict-align marshalling (optimize={optimize}): {other:?}"),
        }
    }
}

/// Executed companion to the under-aligned member-access encoding
/// check: composing a member, a bitfield storage unit or a float from
/// narrower accesses must reproduce the value the whole-width access
/// would have moved, in both directions. The object sits at an odd
/// address, so every access the lowering emits is under-aligned at its
/// natural width.
#[test]
fn strict_align_round_trips_an_under_aligned_member() {
    const SRC: &str = "struct __attribute__((packed)) P {\n\
         \tchar c;\n\
         \tint a;\n\
         \tlong b;\n\
         \tfloat f;\n\
         \tdouble d;\n\
         };\n\
         struct __attribute__((packed)) B { char c; unsigned x : 24; int y : 20; };\n\
         typedef long __attribute__((aligned(4))) l4;\n\
         struct R { int a; l4 b; };\n\
         int main(void) {\n\
         \tchar buf[96];\n\
         \tstruct P *p = (struct P *)(buf + 1);\n\
         \tstruct B *q = (struct B *)(buf + 33);\n\
         \tstruct R *r = (struct R *)(buf + 49);\n\
         \tfor (int i = 0; i < 95; i++) buf[i + 1] = (char)(i * 5 + 1);\n\
         \tp->a = -123456789;\n\
         \tp->b = -1234567890123456789L;\n\
         \tp->f = 12.5f;\n\
         \tp->d = -1e300;\n\
         \tif (p->a != -123456789) return 1;\n\
         \tif (p->b != -1234567890123456789L) return 2;\n\
         \tif (p->f != 12.5f) return 3;\n\
         \tif (p->d != -1e300) return 4;\n\
         \tp->a += 1;\n\
         \tif (p->a != -123456788) return 5;\n\
         \tq->c = 3;\n\
         \tq->x = 0xabcdef;\n\
         \tq->y = -12345;\n\
         \tif (q->c != 3 || q->x != 0xabcdefu || q->y != -12345) return 6;\n\
         \tq->x += 1;\n\
         \tif (q->x != 0xabcdf0u) return 7;\n\
         \tr->b = 0x1122334455667788L;\n\
         \tif (r->b != 0x1122334455667788L) return 8;\n\
         \t/* a too-wide store would reach the preceding member */\n\
         \tp->c = 0x5a;\n\
         \tp->a = 7;\n\
         \tif (p->c != 0x5a || p->a != 7) return 9;\n\
         \treturn 42;\n\
         }\n";
    for optimize in [false, true] {
        let opts = NativeOptions {
            strict_align: true,
            optimize,
            ..NativeOptions::default()
        };
        match build_and_run_outcome_with_options(SRC, "strict_align_member", opts) {
            RunOutcome::Exit(42) => {}
            other => panic!("strict-align member access (optimize={optimize}): {other:?}"),
        }
    }
}

/// The AAPCS64 indirect-result copy addresses both endpoints through
/// scaled immediates, whose reach is 4095 bytes for the byte form and
/// 32760 for the eightbyte one. An aggregate past the narrower reach
/// must advance the base pointers instead of encoding an out-of-range
/// offset, and still return the caller's original buffer pointer.
/// Independent of `-mstrict-align`, which only lowers the unit width.
#[test]
fn oversize_by_value_return_advances_its_bases() {
    const SRC: &str = "struct Big { char x[8003]; };\n\
         struct Big fetch(struct Big *p) { return *p; }\n\
         int main(void) {\n\
         \tstatic struct Big src, out;\n\
         \tfor (int i = 0; i < 8003; i++) src.x[i] = (char)(i * 3 + 1);\n\
         \tout = fetch(&src);\n\
         \tfor (int i = 0; i < 8003; i++) if (out.x[i] != (char)(i * 3 + 1)) return 1;\n\
         \treturn 42;\n\
         }\n";
    for strict_align in [false, true] {
        let opts = NativeOptions {
            strict_align,
            ..NativeOptions::default()
        };
        match build_and_run_outcome_with_options(SRC, "oversize_ret", opts) {
            RunOutcome::Exit(42) => {}
            other => panic!("oversize by-value return (strict_align={strict_align}): {other:?}"),
        }
    }
}

#[test]
fn bss_segregation_coexists_with_thread_local() {
    // Zero-fill must be the segment's tail. `__thread_bss`/thread storage
    // already sits past `__data`, so regular bss is laid out past the
    // thread storage and addressed through `data_off_to_vaddr`. The second
    // `_Thread_local` has a non-zero block offset: the `.data` compaction
    // must not remap a TLS symbol's tls-image offset, or the TLV
    // descriptor points past the per-thread block and dyld aborts.
    let opts = NativeOptions {
        bss_segregate: true,
        ..NativeOptions::default()
    };
    let src = "_Thread_local int t0; _Thread_local int t1; \
               static long zeros[4096]; long *const p = &zeros[3000]; \
               int main(void){ int ok = 1; \
               for (int i = 0; i < 4096; i++) ok &= (zeros[i] == 0); \
               t0 = 5; t1 = 6; zeros[3000] = 9; \
               ok &= (t0 == 5); ok &= (t1 == 6); ok &= (zeros[3000] == 9); \
               ok &= (p == &zeros[3000]); ok &= (*p == 9); \
               return ok ? 0 : 1; }";
    match build_and_run_outcome_with_options(src, "bss_tls", opts) {
        RunOutcome::Exit(0) => {}
        other => panic!("segregated .bss with _Thread_local must exit 0, got {other:?}"),
    }
}

#[test]
fn thread_local_without_exit_binding_in_scope() {
    // `_Thread_local` with only `<stdio.h>` included: libSystem is
    // resolved through the `printf` import and no `exit` binding
    // exists. The TLV libSystem anchor must ride the dylib list, not
    // a forced `exit` import.
    let src = "#include <stdio.h>\n\
               _Thread_local int t = 5;\n\
               int main(void) { printf(\"%d\\n\", t); return t + 37; }\n";
    match build_and_run_outcome_bare(src, "tls_no_exit") {
        RunOutcome::Exit(42) => {}
        other => panic!("TLS without an `exit` binding must run, got {other:?}"),
    }
}

#[test]
fn thread_local_headerless_pulls_libsystem() {
    // No headers at all: no import resolves any dylib, so the TLV
    // anchor must add libSystem itself or dyld cannot bind
    // `__tlv_bootstrap` for the descriptors.
    let src = "_Thread_local int t = 5;\n\
               int main(void) { t = t + 37; return t; }\n";
    match build_and_run_outcome_bare(src, "tls_headerless") {
        RunOutcome::Exit(42) => {}
        other => panic!("header-free TLS must run, got {other:?}"),
    }
}

// ---- Every non-intrinsic op exercised end-to-end. ----

#[test]
fn add_subtract_multiply() {
    // 5 + 3 = 8, 10 - 4 = 6, 7 * 6 = 42 -- pick the last one.
    assert_eq!(build_and_run("int main() { return 7 * 6; }", "mul42"), 42);
    assert_eq!(build_and_run("int main() { return 5 + 3; }", "add"), 8);
    assert_eq!(build_and_run("int main() { return 100 - 58; }", "sub"), 42);
}

#[test]
fn integer_div_and_mod() {
    assert_eq!(build_and_run("int main() { return 84 / 2; }", "div"), 42);
    assert_eq!(build_and_run("int main() { return 100 % 9; }", "mod"), 1);
}

#[test]
fn comparison_returns_zero_or_one() {
    assert_eq!(build_and_run("int main() { return 5 < 7; }", "lt"), 1);
    assert_eq!(build_and_run("int main() { return 5 > 7; }", "gt"), 0);
    assert_eq!(build_and_run("int main() { return 5 == 5; }", "eq"), 1);
    assert_eq!(build_and_run("int main() { return 5 != 5; }", "ne"), 0);
}

#[test]
fn local_variable_round_trips() {
    let src = r#"
        int main() {
            int x;
            x = 41;
            x = x + 1;
            return x;
        }
    "#;
    assert_eq!(build_and_run(src, "local"), 42);
}

#[test]
fn if_else_routes_correctly() {
    let src = r#"
        int main() {
            int x;
            x = 10;
            if (x > 5) return 42;
            else return 7;
        }
    "#;
    assert_eq!(build_and_run(src, "ifelse"), 42);
}

#[test]
fn while_loop_terminates() {
    let src = r#"
        int main() {
            int i;
            int s;
            i = 0;
            s = 0;
            while (i < 10) {
                s = s + i;
                i = i + 1;
            }
            return s;
        }
    "#;
    // 0+1+2+...+9 = 45
    assert_eq!(build_and_run(src, "while45"), 45);
}

#[test]
fn function_call_returns_value() {
    let src = r#"
        int square(int n) { return n * n; }
        int main() { return square(6) + square(2); }
    "#;
    // 6*6 + 2*2 = 40
    assert_eq!(build_and_run(src, "fncall"), 40);
}

#[test]
fn recursion_factorial() {
    let src = r#"
        int fact(int n) {
            if (n < 2) return 1;
            return n * fact(n - 1);
        }
        int main() { return fact(5); }
    "#;
    // 5! = 120
    assert_eq!(build_and_run(src, "fact"), 120);
}

// ---- libc intrinsics through the GOT. The cases here avoid string
//      literals; the data-segment fixtures further down cover that
//      path.

#[test]
fn exit_with_value() {
    // exit(N) lowers to a libc `_exit` call.
    assert_eq!(
        build_and_run("int main() { exit(7); return 0; }", "exit7"),
        7
    );
}

#[test]
fn malloc_returns_nonzero_pointer() {
    let src = r#"
        int main() {
            int *p;
            p = malloc(64);
            return p != 0;
        }
    "#;
    assert_eq!(build_and_run(src, "malloc-nonzero"), 1);
}

#[test]
fn malloc_memset_memcmp_roundtrip() {
    let src = r#"
        int main() {
            int *a;
            int *b;
            a = malloc(16);
            b = malloc(16);
            memset(a, 7, 16);
            memset(b, 7, 16);
            if (memcmp(a, b, 16) == 0) {
                free(a);
                free(b);
                return 42;
            }
            return 1;
        }
    "#;
    assert_eq!(build_and_run(src, "memset-cmp"), 42);
}

#[test]
fn argc_threads_through_main() {
    // No args passed -- argc should be 1 (just the binary path).
    let src = r#"
        int main(int argc, char **argv) { return argc; }
    "#;
    assert_eq!(build_and_run(src, "argc"), 1);
}

// ---- Fixture parity. Compile each named fixture through the native
//      pipeline and confirm the exit code matches what the VM would
//      have produced. The suite spans the data segment (string
//      literals, globals), function pointers, libc calls, and
//      multi-arg variadic shapes.

fn build_and_run_fixture(name: &str) -> RunOutcome {
    build_and_run_fixture_with_options(name, NativeOptions::default(), "")
}

fn build_and_run_fixture_with_options(name: &str, opts: NativeOptions, suffix: &str) -> RunOutcome {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let stem = name.trim_end_matches(".c");
    build_and_run_outcome_with_options(&src, &format!("{stem}{suffix}"), opts)
}

/// Build a fixture, sign it, run it with the given args, and return
/// the outcome. Like [`build_and_run_fixture`] but exposes the binary
/// to a `main(argc, argv)` it can act on.
fn build_and_run_fixture_with_args<I, S>(name: &str, args: I) -> RunOutcome
where
    I: IntoIterator<Item = S>,
    S: AsRef<str>,
{
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let stem = name.trim_end_matches(".c");

    let program = match Compiler::new(src).compile() {
        Ok(p) => p,
        Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
    };
    let bytes = match emit_native(&program, Target::MacOSAarch64) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let bin_path = super::unique_temp_path("badc-test", stem, ".bin");
    {
        let mut f = std::fs::File::create(&bin_path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
    }
    set_executable(&bin_path);
    codesign(&bin_path);

    let output = Command::new(&bin_path)
        .args(args.into_iter().map(|s| s.as_ref().to_string()))
        .output()
        .expect("could not exec the produced binary");
    let _ = std::fs::remove_file(&bin_path);
    if let Some(code) = output.status.code() {
        RunOutcome::Exit(code)
    } else {
        use std::os::unix::process::ExitStatusExt;
        let signal = output.status.signal().unwrap_or(0);
        RunOutcome::Signal(signal)
    }
}

#[test]
fn file_io_natively() {
    // Native counterpart of `tests::programs::file_io`. The fixture
    // hard-codes the filename `test_dummy.txt`, resolved against the
    // CWD, so the binary runs in a per-process directory holding it.
    let cwd = super::unique_temp_path("badc-test", "file_io-cwd", "");
    std::fs::create_dir_all(&cwd).unwrap();
    std::fs::write(cwd.join("test_dummy.txt"), "1234567890").unwrap();
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("file_io.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src).compile().expect("compile file_io.c");
    let bytes = emit_native(&program, Target::MacOSAarch64).expect("emit_native");
    let bin_path = super::unique_temp_path("badc-test", "file_io", ".bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);
    codesign(&bin_path);

    let output = Command::new(&bin_path)
        .current_dir(&cwd)
        .output()
        .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    let _ = std::fs::remove_dir_all(&cwd);
    assert_eq!(output.status.code(), Some(0));
}

#[test]
fn getenv_value_natively() {
    // Set the env var the fixture reads, then exec. The binary
    // returns the first byte of the value, so 'V' (86) confirms the
    // libc getenv path threads through correctly.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("getenv_value.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src)
        .compile()
        .expect("compile getenv_value.c");
    let bytes = emit_native(&program, Target::MacOSAarch64).expect("emit_native");
    let bin_path = super::unique_temp_path("badc-test", "getenv", ".bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);
    codesign(&bin_path);

    let output = Command::new(&bin_path)
        .env("C4RS_TEST_GETENV", "Vox")
        .output()
        .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    assert_eq!(output.status.code(), Some('V' as i32));
}

#[test]
fn original_c4_compiles_and_runs_hello_natively() {
    // Native counterpart of `tests::programs::original_c4_compiles_and_runs_hello`.
    // The native build of c4.c reads its first user argv entry as the
    // source file to compile-and-run; we hand it the absolute path to
    // the c4-subset self-host fixture and let c4.c (running natively)
    // parse + execute it. The expected output is "Hello 123" with
    // exit 0.
    //
    // Unlike the VM-side test, the native binary's argv[0] is set by
    // `Command::new` to the binary path -- so we only need to pass
    // the fixture's absolute path; c4.c does `--argc; ++argv;` itself.
    let outcome = build_and_run_fixture_with_args(
        "c4.c",
        [concat!(
            env!("CARGO_MANIFEST_DIR"),
            "/tests/fixtures/c/c4_selfhost_hello.c"
        )],
    );
    assert!(
        matches!(outcome, RunOutcome::Exit(0)),
        "expected clean exit, got {outcome:?}"
    );
}

/// libSystem exports no `strchrnul` / `memrchr` / `explicit_bzero`, so a
/// macOS image takes them from `libc/lib/string_ext.c`, which joins the
/// link only because the fixture leaves them undefined. `fixture_parity`
/// emits one object and never links, so it cannot reach that path; this
/// builds the fixture through the object-then-link writer instead.
#[test]
fn string_extensions_join_the_macos_link() {
    let program = super::compile_str_bare_for(
        &super::load_fixture("string_gnu_ext.c"),
        Target::MacOSAarch64,
    );
    let bytes = super::link_executable_with_runtime(
        &program,
        Target::MacOSAarch64,
        NativeOptions::default(),
    )
    .expect("link the fixture for MacOSAarch64");

    let path = super::unique_temp_path("badc-test", "string-ext-link", ".bin");
    std::fs::write(&path, &bytes).expect("write temp file");
    set_executable(&path);
    codesign(&path);
    let output = Command::new(&path).output().expect("exec native binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "string_gnu_ext.c must exit 0 once the bundled source is joined"
    );
}

/// `copy_file_range` is a Linux system call with no libSystem export,
/// so a macOS image takes the emulation from `libc/lib/unistd_ext.c`,
/// which joins the link only because the fixture leaves the symbol
/// undefined. Same reasoning as `string_extensions_join_the_macos_link`:
/// `fixture_parity` emits one object and never links.
#[test]
fn unistd_extensions_join_the_macos_link() {
    let program = super::compile_str_bare_for(
        &super::load_fixture("copy_file_range_posix.c"),
        Target::MacOSAarch64,
    );
    let bytes = super::link_executable_with_runtime(
        &program,
        Target::MacOSAarch64,
        NativeOptions::default(),
    )
    .expect("link the fixture for MacOSAarch64");

    let path = super::unique_temp_path("badc-test", "unistd-ext-link", ".bin");
    std::fs::write(&path, &bytes).expect("write temp file");
    set_executable(&path);
    codesign(&path);
    let output = Command::new(&path).output().expect("exec native binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "copy_file_range_posix.c must exit 0 once the bundled source is joined"
    );
}

#[test]
fn fixture_parity() {
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_FIXTURES {
        let outcome = build_and_run_fixture(name);
        if !outcome.matches(*expected) {
            failures.push(format!("{name}: expected exit {expected}, got {outcome:?}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} native fixtures regressed:\n  {}",
        failures.len(),
        NATIVE_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// AAPCS64 / Win64: the libc return-register sign-extension
/// contract leaves the upper bits unspecified for sub-word
/// returns. `emit_extend_x19_for_return` / its x86_64 sibling
/// emit `sxtw` / `movsxd` after every libc call so an
/// `int`-returning libc fn (`atoi("-17")`) widens to i64
/// correctly. Run on every native lane (Mach-O / ELF / PE)
/// since each backend emits its own post-call extension and
/// the failure manifests differently per platform-libc pair.
#[test]
fn atoi_negative_sign_extends() {
    let outcome = build_and_run_fixture("atoi_negative.c");
    assert!(
        matches!(outcome, RunOutcome::Exit(0)),
        "atoi('-17') should sign-extend to -1 in i64, got {outcome:?}"
    );
}

/// `-O` parity for the macOS Mach-O backend: every fixture must
/// produce the same exit code with the optimizer enabled as
/// without. Mirrors `super::jit::fixture_parity_native_optimized`
/// so any optimizer regression specific to the Mach-O lowering
/// shows up here rather than only on the JIT lane.
#[test]
fn fixture_parity_native_optimized() {
    let opts = NativeOptions::new().with_optimize();
    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in NATIVE_FIXTURES {
        let outcome = build_and_run_fixture_with_options(name, opts, "-O");
        if !outcome.matches(*expected) {
            failures.push(format!(
                "{name} (-O): expected exit {expected}, got {outcome:?}"
            ));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} native fixtures regressed under -O:\n  {}",
        failures.len(),
        NATIVE_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// A `static __always_inline` `asm goto` whose `"i"` operand is a
/// parameter compiles only once inlined: out of line the operand is not
/// a link-time constant, so the section-data emit rejects it. -O inlines
/// it at the constant-argument call site, folding the operand, and routes
/// the two returns through a join-block phi. This is the kernel
/// `arch_static_branch` shape; it is verified only at -O since the
/// out-of-line body is (correctly) unencodable at -O0.
#[test]
fn param_operand_asm_goto_inlines_at_opt() {
    let src = r#"
        static inline __attribute__((always_inline)) int
        branch(const int key) {
        #if defined(__x86_64__)
            __asm__ goto("jmp %l[yes]\n"
                         ".pushsection .discard.b,\"a\"\n"
                         ".long %c0\n"
                         ".popsection\n" : : "i"(key) : : yes);
        #elif defined(__aarch64__)
            __asm__ goto("b %l[yes]\n"
                         ".pushsection .discard.b,\"a\"\n"
                         ".long %c0\n"
                         ".popsection\n" : : "i"(key) : : yes);
        #else
            goto yes;
        #endif
            return 1;
        yes:
            return 2;
        }
        int main(void) { return branch(40) == 2 ? 42 : 0; }
    "#;
    let opts = NativeOptions::new().with_optimize();
    let outcome = build_and_run_outcome_with_options(src, "param_asm_goto", opts);
    assert!(
        outcome.matches(42),
        "param-operand asm-goto callee must inline and fold at -O, got {outcome:?}"
    );
}

/// A caller that owns an `asm goto` (so it carries a `jump_table`) must
/// still absorb a multi-block `always_inline` callee. The callee is itself
/// an `asm goto` whose `%c0` section operand is a constant argument, so it
/// only folds to a link-time value when inlined into the caller; left out
/// of line the operand is a parameter and the section value is
/// non-constant, so the unit fails to encode. The multi-block splice
/// shifts the caller's own asm-goto `jump_table` row across the block-id
/// shift, so entering it for a caller that already holds one is safe.
#[test]
fn asm_goto_callee_inlines_into_asm_goto_caller() {
    let src = r#"
        static inline __attribute__((always_inline)) int
        branch(const int key) {
        #if defined(__x86_64__)
            __asm__ goto("jmp %l[yes]\n"
                         ".pushsection .discard.b,\"a\"\n"
                         ".long %c0\n"
                         ".popsection\n" : : "i"(key) : : yes);
        #elif defined(__aarch64__)
            __asm__ goto("b %l[yes]\n"
                         ".pushsection .discard.b,\"a\"\n"
                         ".long %c0\n"
                         ".popsection\n" : : "i"(key) : : yes);
        #else
            goto yes;
        #endif
            return 1;
        yes:
            return 2;
        }
        int caller_owns_asm_goto(int a) {
            int r = 0;
        #if defined(__x86_64__)
            __asm__ goto("test %0,%0\n\t"
                         "jnz %l[nz]" : : "r"(a) : : nz);
        #elif defined(__aarch64__)
            __asm__ goto("cbnz %w0, %l[nz]" : : "r"(a) : : nz);
        #else
            if (a) goto nz;
        #endif
            r = 10;
        nz:
            r += branch(40);
            return r;
        }
        int main(void) {
            return (caller_owns_asm_goto(0) == 12
                    && caller_owns_asm_goto(1) == 2) ? 42 : 0;
        }
    "#;
    let opts = NativeOptions::new().with_optimize();
    let outcome = build_and_run_outcome_with_options(src, "asm_goto_caller", opts);
    assert!(
        outcome.matches(42),
        "asm-goto callee must inline into an asm-goto caller and fold at -O, got {outcome:?}"
    );
}

/// End-to-end Mach-O dylib smoke test: compile a c5 source
/// that exports `answer()` returning 42 via `#pragma export`,
/// build it as a `.dylib` (MH_DYLIB + LC_ID_DYLIB + symbol-
/// table N_EXT|N_SECT entry), ad-hoc-sign it, then `dlopen`
/// + `dlsym` + call into it from the test process.
///
/// Verifies the entire shared-library pipeline -- including
/// that the Mach-O symbol-table entry's `n_value` is the
/// function's runtime VA, not its ent_pc identifier.
#[test]
fn dylib_export_dlopen_call_returns_42() {
    use crate::{NativeOptions, emit_native_with_options};
    use std::ffi::CString;
    use std::os::raw::{c_int, c_void};

    let src = "
        int answer() { return 42; }
        #pragma export(answer)
        int main() { return 0; }
    ";
    let program = Compiler::with_target(super::with_prelude(src), Target::MacOSAarch64)
        .compile()
        .expect("compile");
    let bytes = emit_native_with_options(
        &program,
        Target::MacOSAarch64,
        NativeOptions::new().with_shared_library(),
    )
    .expect("emit_native dylib");

    let path = super::unique_temp_path("badc-dylib", "export", ".dylib");
    std::fs::write(&path, &bytes).unwrap();
    // dyld refuses to load an unsigned dylib on Apple Silicon.
    let status = Command::new("/usr/bin/codesign")
        .args(["--sign", "-", "--force"])
        .arg(&path)
        .status()
        .expect("codesign not available");
    assert!(status.success(), "codesign failed: {status:?}");

    unsafe extern "C" {
        fn dlopen(filename: *const std::os::raw::c_char, flag: c_int) -> *mut c_void;
        fn dlsym(handle: *mut c_void, name: *const std::os::raw::c_char) -> *mut c_void;
        fn dlclose(handle: *mut c_void) -> c_int;
        fn dlerror() -> *const std::os::raw::c_char;
    }
    const RTLD_NOW: c_int = 2;

    let path_c = CString::new(path.to_str().unwrap()).unwrap();
    let answer_c = CString::new("answer").unwrap();
    let exit_code: c_int;
    unsafe {
        let handle = dlopen(path_c.as_ptr(), RTLD_NOW);
        if handle.is_null() {
            let err = dlerror();
            let msg = if err.is_null() {
                "(no message)".to_string()
            } else {
                std::ffi::CStr::from_ptr(err).to_string_lossy().into_owned()
            };
            let _ = std::fs::remove_file(&path);
            panic!("dlopen failed: {msg}");
        }
        let sym = dlsym(handle, answer_c.as_ptr());
        if sym.is_null() {
            let err = dlerror();
            let msg = if err.is_null() {
                "(no message)".to_string()
            } else {
                std::ffi::CStr::from_ptr(err).to_string_lossy().into_owned()
            };
            dlclose(handle);
            let _ = std::fs::remove_file(&path);
            panic!("dlsym(answer) failed: {msg}");
        }
        let answer: extern "C" fn() -> c_int = std::mem::transmute(sym);
        exit_code = answer();
        dlclose(handle);
    }
    let _ = std::fs::remove_file(&path);
    assert_eq!(exit_code, 42, "dylib export returned wrong value");
}

/// The symbols this process publishes for the shared library below to
/// bind against. `#[used]` keeps each in the executable's export table
/// -- the scope a flat-namespace bind resolves against -- past the
/// linker's dead-strip; a function needs a `#[used]` reference of its
/// own since the attribute applies to statics.
#[used]
#[unsafe(no_mangle)]
pub static badc_host_var: std::os::raw::c_int = 0x5eed;

#[unsafe(no_mangle)]
pub extern "C" fn badc_host_fn() -> std::os::raw::c_int {
    0xbeef
}

#[used]
static BADC_HOST_FN_KEEP: extern "C" fn() -> std::os::raw::c_int = badc_host_fn;

/// A shared library reads a data symbol only the host defines. The read
/// has to reach the host's object; binding it to the library's own call
/// stub returns the stub's instruction bytes instead, which no
/// diagnostic catches -- the load succeeds and the value is wrong. The
/// paired call proves the stub path still works.
#[test]
fn dylib_reads_host_data_symbol_through_its_import_slot() {
    use crate::NativeOptions;
    use std::ffi::CString;
    use std::os::raw::{c_int, c_void};

    let src = "
        extern int badc_host_var;
        extern int badc_host_fn(void);
        #pragma export(read_host_var)
        int read_host_var(void) { return badc_host_var; }
        #pragma export(call_host_fn)
        int call_host_fn(void) { return badc_host_fn(); }
    ";
    let program = Compiler::with_target(src.to_string(), Target::MacOSAarch64)
        .compile()
        .expect("compile");
    let bytes =
        super::link_shared_library(&program, Target::MacOSAarch64, NativeOptions::default())
            .expect("link shared library");

    let path = super::unique_temp_path("badc-dylib", "host-data", ".dylib");
    std::fs::write(&path, &bytes).unwrap();
    codesign(&path);

    unsafe extern "C" {
        fn dlopen(filename: *const std::os::raw::c_char, flag: c_int) -> *mut c_void;
        fn dlsym(handle: *mut c_void, name: *const std::os::raw::c_char) -> *mut c_void;
        fn dlclose(handle: *mut c_void) -> c_int;
        fn dlerror() -> *const std::os::raw::c_char;
    }
    // RTLD_NOW | RTLD_GLOBAL: bind every reference up front so a
    // misrouted one shows up here rather than at first use.
    const RTLD_NOW_GLOBAL: c_int = 2 | 8;

    let path_c = CString::new(path.to_str().unwrap()).unwrap();
    let fail = |what: &str| -> String {
        let err = unsafe { dlerror() };
        let msg = if err.is_null() {
            "(no message)".to_string()
        } else {
            unsafe { std::ffi::CStr::from_ptr(err) }
                .to_string_lossy()
                .into_owned()
        };
        format!("{what}: {msg}")
    };
    let (read_var, call_fn);
    unsafe {
        let handle = dlopen(path_c.as_ptr(), RTLD_NOW_GLOBAL);
        if handle.is_null() {
            let msg = fail("dlopen");
            let _ = std::fs::remove_file(&path);
            panic!("{msg}");
        }
        let r = dlsym(handle, c"read_host_var".as_ptr());
        let c = dlsym(handle, c"call_host_fn".as_ptr());
        if r.is_null() || c.is_null() {
            let msg = fail("dlsym");
            dlclose(handle);
            let _ = std::fs::remove_file(&path);
            panic!("{msg}");
        }
        let rf: extern "C" fn() -> c_int = std::mem::transmute(r);
        let cf: extern "C" fn() -> c_int = std::mem::transmute(c);
        read_var = rf();
        call_fn = cf();
        dlclose(handle);
    }
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        read_var, badc_host_var,
        "the data import read {read_var:#x} instead of the host's object",
    );
    assert_eq!(call_fn, 0xbeef, "the call import returned {call_fn:#x}");
}

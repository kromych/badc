//! The runtime checks `-fsanitize=` inserts, run on the host: each failed
//! check reports once, as clang's runtime words it at the operator's line
//! and column, and the program goes on; `-fsanitize-trap` stops it at the
//! failed check without a report; `-fno-sanitize-recover` reports and
//! aborts. The expected lines are clang 21's for the same source.

use std::path::Path;
use std::process::{Command, Output};

mod common;
use common::TempDir;

const OVERFLOW: &str = "#include <limits.h>
#include <stdio.h>
__attribute__((noinline)) int add(int a, int b) { return a + b; }
__attribute__((noinline)) long long mul(long long a, long long b) { return a * b; }
__attribute__((noinline)) int sub(int a, int b) { return a - b; }
int main(int argc, char **argv) {
    (void)argv;
    printf(\"%d %lld %d\\n\", add(40, 2), mul(1LL << 31, 4), sub(2, 3));
    for (int k = 0; k < 2; k++) {
        if (argc > 1) printf(\"%d\\n\", add(INT_MAX, argc - 1));
        if (argc > 2) printf(\"%lld\\n\", mul(LLONG_MAX / 2, argc));
        if (argc > 3) printf(\"%d\\n\", sub(INT_MIN, argc - 3));
    }
    return 0;
}
";

fn build(dir: &Path, flags: &[&str], opt: &str) -> std::path::PathBuf {
    let src = dir.join("overflow.c");
    std::fs::write(&src, OVERFLOW).unwrap();
    let out = dir.join(format!("overflow{}{opt}", flags.join("").replace('=', "_")));
    let built = Command::new(env!("CARGO_BIN_EXE_badc"))
        .args(["-q", opt])
        .args(flags)
        .arg("-o")
        .arg(&out)
        .arg(&src)
        .output()
        .expect("run badc");
    assert!(
        built.status.success(),
        "{}",
        String::from_utf8_lossy(&built.stderr)
    );
    out
}

fn run(exe: &Path, args: &[&str]) -> Output {
    Command::new(exe)
        .args(args)
        .output()
        .expect("run the program")
}

/// The report lines, with the source path before `:<line>:` dropped. Each
/// is followed by the summary line clang's runtime closes a report with,
/// naming the same position.
fn reports(o: &Output) -> Vec<String> {
    let text = String::from_utf8_lossy(&o.stderr);
    let lines: Vec<&str> = text.lines().collect();
    let mut out = Vec::new();
    for (i, line) in lines.iter().enumerate() {
        let Some((_, report)) = line.split_once("overflow.c:") else {
            continue;
        };
        let Some((at, _)) = report.split_once(": runtime error: ") else {
            continue;
        };
        // A note on what the report rests on may come between it and its
        // summary.
        let summary = (lines[i + 1..].iter())
            .find(|l| !l.contains(": note: "))
            .copied()
            .unwrap_or_default();
        assert!(
            summary.starts_with("SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ")
                && summary.ends_with(&format!("overflow.c:{at} ")),
            "{text}"
        );
        out.push(report.to_string());
    }
    out
}

#[test]
fn a_failed_overflow_check_reports_once_and_the_program_goes_on() {
    let dir = TempDir::new("badc-sanitize-recover");
    for opt in ["-O0", "-O"] {
        let exe = build(&dir, &["-fsanitize=signed-integer-overflow"], opt);
        let quiet = run(&exe, &[]);
        assert!(
            quiet.status.success() && quiet.stderr.is_empty(),
            "{opt}: {quiet:?}"
        );
        assert_eq!(
            String::from_utf8_lossy(&quiet.stdout).replace("\r\n", "\n"),
            "42 8589934592 -1\n"
        );
        let o = run(&exe, &["a", "b", "c"]);
        assert!(o.status.success(), "{opt}: {o:?}");
        assert_eq!(
            reports(&o),
            [
                "3:60: runtime error: signed integer overflow: 2147483647 + 3 cannot be \
                 represented in type 'int'",
                "4:78: runtime error: signed integer overflow: 4611686018427387903 * 4 cannot \
                 be represented in type 'long long'",
                "5:60: runtime error: signed integer overflow: -2147483648 - 1 cannot be \
                 represented in type 'int'",
            ],
            "{opt}"
        );
    }
}

#[test]
fn a_trapping_check_stops_the_program_without_a_report() {
    let dir = TempDir::new("badc-sanitize-trap");
    for opt in ["-O0", "-O"] {
        let exe = build(
            &dir,
            &["-fsanitize=signed-integer-overflow", "-fsanitize-trap"],
            opt,
        );
        assert!(run(&exe, &[]).status.success(), "{opt}");
        let o = run(&exe, &["a"]);
        assert!(
            !o.status.success() && reports(&o).is_empty(),
            "{opt}: {o:?}"
        );
    }
}

#[test]
fn a_check_that_does_not_recover_reports_and_aborts() {
    let dir = TempDir::new("badc-sanitize-abort");
    let exe = build(
        &dir,
        &["-fsanitize=undefined", "-fno-sanitize-recover=all"],
        "-O0",
    );
    let o = run(&exe, &["a"]);
    assert!(!o.status.success(), "{o:?}");
    assert_eq!(reports(&o).len(), 1, "{o:?}");
}

#[test]
fn a_check_badc_does_not_implement_is_refused() {
    let o = Command::new(env!("CARGO_BIN_EXE_badc"))
        .args(["-fsanitize=address", "-c", "x.c"])
        .output()
        .expect("run badc");
    let err = String::from_utf8_lossy(&o.stderr);
    assert!(
        !o.status.success()
            && err.contains("error: -fsanitize=address: `address` is neither a check nor a group")
            && err.contains("signed-integer-overflow")
            && err.contains("groups: undefined"),
        "{err}"
    );
}

const FORMS: &str = "#include <limits.h>
#include <stdio.h>
int main(int argc, char **argv) {
    (void)argv;
    int a = INT_MAX - 1 + argc;
    a += argc;
    int b = INT_MAX;
    b++;
    int c = INT_MIN + argc - 1;
    c = -c;
    long long d = LLONG_MIN + argc - 1;
    d--;
    int e = INT_MAX / 2 + argc;
    e *= 2;
    printf(\"%d %d %d %lld %d\\n\", a, b, c, d, e);
    return 0;
}
";

/// A compound assignment, `++`, `--` and unary `-` are checked as the
/// binary operators are, each at its operator.
#[test]
fn compound_assignment_increment_and_negation_are_checked() {
    let dir = TempDir::new("badc-sanitize-forms");
    let src = dir.join("overflow.c");
    std::fs::write(&src, FORMS).unwrap();
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("forms{opt}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", opt, "-fsanitize=signed-integer-overflow", "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let o = run(&exe, &[]);
        assert!(o.status.success(), "{opt}: {o:?}");
        assert_eq!(
            reports(&o),
            [
                "6:7: runtime error: signed integer overflow: 2147483647 + 1 cannot be \
                 represented in type 'int'",
                "8:6: runtime error: signed integer overflow: 2147483647 + 1 cannot be \
                 represented in type 'int'",
                "10:9: runtime error: negation of -2147483648 cannot be represented in type \
                 'int'; cast to an unsigned type to negate this value to itself",
                "12:6: runtime error: signed integer overflow: -9223372036854775808 - 1 cannot \
                 be represented in type 'long long'",
                "14:7: runtime error: signed integer overflow: 1073741824 * 2 cannot be \
                 represented in type 'int'",
            ],
            "{opt}"
        );
    }
}

const UNSIGNED: &str = "#include <limits.h>
#include <stdio.h>
int main(int argc, char **argv) {
    (void)argv;
    unsigned z = argc - 1;
    unsigned a = z - 1;
    unsigned b = UINT_MAX - 1 + argc;
    b += argc;
    unsigned c = z + 1;
    c = -c;
    unsigned long long d = ULLONG_MAX / 2 + argc;
    d *= 2;
    unsigned e = UINT_MAX - 1 + argc;
    e++;
    unsigned short s = USHRT_MAX - 1 + argc;
    s++;
    printf(\"%u %u %u %llu %u %u\\n\", a, b, c, d, e, s);
    return 0;
}
";

/// clang's `unsigned-integer-overflow` reports an unsigned `+`, `-`, `*`,
/// negation, compound assignment and `++` whose value wraps, defined as it is
/// (C17 6.2.5p9), at its operator, and nothing for a step an `unsigned short`
/// takes in `int`. `integer` names it, with the truncation of that step, and
/// `undefined` does not.
#[test]
fn unsigned_wraps_are_checked_under_unsigned_integer_overflow() {
    let dir = TempDir::new("badc-sanitize-unsigned");
    let src = dir.join("overflow.c");
    std::fs::write(&src, UNSIGNED).unwrap();
    let all = [
        "6:20: runtime error: unsigned integer overflow: 0 - 1 cannot be represented in type \
         'unsigned int'",
        "8:7: runtime error: unsigned integer overflow: 4294967295 + 1 cannot be represented \
         in type 'unsigned int'",
        "10:9: runtime error: negation of 1 cannot be represented in type 'unsigned int'",
        "12:7: runtime error: unsigned integer overflow: 9223372036854775808 * 2 cannot be \
         represented in type 'unsigned long long'",
        "14:6: runtime error: unsigned integer overflow: 4294967295 + 1 cannot be represented \
         in type 'unsigned int'",
        "16:6: runtime error: implicit conversion from type 'int' of value 65536 (32-bit, \
         signed) to type 'unsigned short' changed the value to 0 (16-bit, unsigned)",
    ];
    for (flag, want) in [
        ("-fsanitize=unsigned-integer-overflow", &all[..5]),
        ("-fsanitize=integer", &all[..]),
        ("-fsanitize=undefined", &[][..]),
    ] {
        for opt in ["-O0", "-O"] {
            let exe = dir.join(format!("unsigned{}{opt}", flag.replace('=', "_")));
            let built = Command::new(env!("CARGO_BIN_EXE_badc"))
                .args(["-q", opt, flag, "-o"])
                .arg(&exe)
                .arg(&src)
                .output()
                .expect("run badc");
            assert!(
                built.status.success(),
                "{}",
                String::from_utf8_lossy(&built.stderr)
            );
            let o = run(&exe, &[]);
            assert!(o.status.success(), "{flag} {opt}: {o:?}");
            assert_eq!(reports(&o), want, "{flag} {opt}");
        }
    }
}

const UNREACHABLE: &str = "#include <stdio.h>
int f(int x) { if (x > 0) return 1; __builtin_unreachable(); }
int g(int x) { if (x > 0) return 2; }
int main(int argc, char **argv) { (void)argv; printf(\"%d\\n\", g(argc)); fflush(stdout); return f(argc - 1); }
";

/// `__builtin_unreachable()` reached reports at the call under
/// `-fsanitize=unreachable` and ends the program, whatever the recovery: its
/// handler has no form that returns. `return` is accepted and checks
/// nothing in C: flowing off a function's end is undefined only where the
/// value is used (C17 6.9.1p12). Trapped, the call reports nothing and
/// still ends the program.
#[test]
fn a_reached_unreachable_is_reported_and_ends_the_program() {
    let dir = TempDir::new("badc-sanitize-unreachable");
    let src = dir.join("overflow.c");
    std::fs::write(&src, UNREACHABLE).unwrap();
    let report = "2:37: runtime error: execution reached an unreachable program point";
    for (flags, want) in [
        (&["-fsanitize=unreachable,return"][..], &[report][..]),
        (
            &["-fsanitize=unreachable", "-fno-sanitize-recover"][..],
            &[report][..],
        ),
        (&["-fsanitize=unreachable", "-fsanitize-trap"][..], &[][..]),
    ] {
        for opt in ["-O0", "-O"] {
            let exe = dir.join(format!(
                "unreachable{}{opt}",
                flags.join("").replace('=', "_")
            ));
            let built = Command::new(env!("CARGO_BIN_EXE_badc"))
                .args(["-q", "-w", opt, "-fno-crash-report"])
                .args(flags)
                .arg("-o")
                .arg(&exe)
                .arg(&src)
                .output()
                .expect("run badc");
            assert!(
                built.status.success(),
                "{}",
                String::from_utf8_lossy(&built.stderr)
            );
            let o = run(&exe, &[]);
            assert!(!o.status.success(), "{flags:?} {opt}: {o:?}");
            let out = String::from_utf8_lossy(&o.stdout).replace("\r\n", "\n");
            assert_eq!(out, "2\n", "{flags:?} {opt}");
            assert_eq!(reports(&o), want, "{flags:?} {opt}");
        }
    }
}

const BUILTIN: &str = "#include <stdio.h>
int a(unsigned x) { return __builtin_clz(x); }
int b(unsigned x) { return __builtin_ctz( x - 1); }
int c(unsigned long long x) { return __builtin_clzll(x) + __builtin_ctzll(x); }
int main(int argc, char **argv) {
    (void)argv;
    printf(\"%d\\n\", a(16) + b(2) + c(4));
    fflush(stdout);
    a(argc - 1);
    b(argc);
    return c(argc - 1) * 0;
}
";

/// `__builtin_clz` / `__builtin_ctz` and their wider forms of 0 report under
/// `-fsanitize=builtin` at the operand, an operation's operator, naming
/// the narrow builtin; a nonzero operand reports nothing.
#[test]
fn a_zero_count_operand_is_reported() {
    let dir = TempDir::new("badc-sanitize-builtin");
    let src = dir.join("overflow.c");
    std::fs::write(&src, BUILTIN).unwrap();
    let zero = |at: &str, name: &str| {
        format!(
            "{at}: runtime error: passing zero to __builtin_{name}(), which is not a valid argument"
        )
    };
    let want = [
        zero("2:42", "clz"),
        zero("3:45", "ctz"),
        zero("4:54", "clz"),
        zero("4:75", "ctz"),
    ];
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("builtin{opt}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", "-w", opt, "-fsanitize=undefined", "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let o = run(&exe, &[]);
        assert!(o.status.success(), "{opt}: {o:?}");
        let out = String::from_utf8_lossy(&o.stdout).replace("\r\n", "\n");
        assert_eq!(out, "90\n", "{opt}");
        assert_eq!(reports(&o), want, "{opt}");
    }
}

/// A report past comments that hold a multi-byte character -- a header's
/// leading comment over many lines and one in front of the operator -- names
/// the source line and its byte column.
#[test]
fn a_report_past_multibyte_comments_names_its_line_and_column() {
    let dir = TempDir::new("badc-sanitize-multibyte");
    let lead: String = (0..20)
        .map(|k| format!(" * line {k} \u{a9} text\n"))
        .collect();
    let header = format!(
        "/*\n * Copyright \u{a9} 2011\n{lead} */\n\
         static int add(int a, int b) {{ /* \u{a9} */ return a + b; }}\n"
    );
    std::fs::write(dir.join("h.h"), header).unwrap();
    let src = dir.join("main.c");
    std::fs::write(
        &src,
        "#include \"h.h\"\nint main(int argc, char **argv) {\n    (void)argv;\n    \
         return add(2147483647, argc) != 0 ? 0 : 1;\n}\n",
    )
    .unwrap();
    let exe = dir.join("multibyte");
    let built = Command::new(env!("CARGO_BIN_EXE_badc"))
        .args(["-q", "-fsanitize=signed-integer-overflow", "-o"])
        .arg(&exe)
        .arg(&src)
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        built.status.success(),
        "{}",
        String::from_utf8_lossy(&built.stderr)
    );
    let o = run(&exe, &[]);
    let err = String::from_utf8_lossy(&o.stderr);
    assert!(
        err.contains("h.h:24:50: runtime error: signed integer overflow"),
        "{err}"
    );
}

const OBJECT_SIZE: &str = "#include <stdio.h>
int main(void) {
    char c[2] = {1, 2};
    int fits = *(short *)&c[0];
    long long v = *(long long *)&c[1];
    int buf[2];
    *(long long *)&buf[1] = 5;
    printf(\"%d %lld\\n\", fits, v & 0);
    return 0;
}
";

/// A dereference of an object's address with fewer bytes left than the
/// access reads or writes is reported under `-fsanitize=object-size`, at its
/// `*`; an access that fits is not. Under `alignment` the same dereferences,
/// a cast having given them a wider type than the named object's, are
/// misaligned.
#[test]
fn an_access_past_its_object_or_misaligned_through_a_cast_is_reported() {
    let dir = TempDir::new("badc-sanitize-object-size");
    let src = dir.join("overflow.c");
    std::fs::write(&src, OBJECT_SIZE).unwrap();
    let space = |at: &str, kind: &str, ty: &str| {
        format!(
            "{at}: runtime error: {kind} address with insufficient space for an object of type '{ty}'"
        )
    };
    let misaligned = |at: &str, kind: &str, ty: &str| {
        format!(
            "{at}: runtime error: {kind} misaligned address for type '{ty}', which requires 8 byte alignment"
        )
    };
    let cases = [
        (
            "object-size",
            [
                space("5:19", "load of", "long long"),
                space("7:5", "store to", "long long"),
            ],
        ),
        (
            "alignment",
            [
                misaligned("5:19", "load of", "long long"),
                misaligned("7:5", "store to", "long long"),
            ],
        ),
    ];
    for (check, want) in cases {
        for opt in ["-O0", "-O"] {
            let exe = dir.join(format!("object-size-{check}{opt}"));
            let built = Command::new(env!("CARGO_BIN_EXE_badc"))
                .args(["-q", "-w", opt, &format!("-fsanitize={check}"), "-o"])
                .arg(&exe)
                .arg(&src)
                .output()
                .expect("run badc");
            assert!(
                built.status.success(),
                "{}",
                String::from_utf8_lossy(&built.stderr)
            );
            let o = run(&exe, &[]);
            assert!(o.status.success(), "{check} {opt}: {o:?}");
            let got: Vec<String> = reports(&o).iter().map(|r| without_address(r)).collect();
            assert_eq!(got, want, "{check} {opt}");
        }
    }
}

/// `r` without the address it names, `0x` and the hexadecimal digits.
fn without_address(r: &str) -> String {
    match r.split_once(" 0x") {
        Some((head, tail)) => {
            let rest = tail.trim_start_matches(|c: char| c.is_ascii_hexdigit());
            format!("{head}{rest}")
        }
        None => r.to_string(),
    }
}

const NONNULL: &str =
    "__attribute__((nonnull(2))) int f(int a, int *p, int *q) { return p ? *p : a; }
__attribute__((nonnull)) int g(int *p, int *q) { return (p != 0) + (q != 0); }
int h(int *p __attribute__((nonnull))) { return p != 0; }
__attribute__((returns_nonnull)) int *r(int *p) {
    return p;
}
int k(int *p, int *q);
__attribute__((nonnull(1))) int k(int *p, int *q);
int k(int *p, int *q) { return (p != 0) + (q != 0); }
int main(void) {
    int x = 1;
    int s = f(0, (int *)0, (int *)0) + g(&x, (int *)0) + h((int *)0);
    s += k((int *)0, &x) + (int)sizeof(f(0, (int *)0, 0));
    return s + (r((int *)0) == 0) + (r(&x) == &x);
}
";

/// A null argument to a parameter `nonnull` names -- a function's numbered
/// list, its bare form naming every pointer parameter, a parameter's own,
/// and one an earlier declaration states -- and a null a `returns_nonnull`
/// function returns report under `-fsanitize=nonnull-attribute` and
/// `returns-nonnull-attribute` at the argument or the `return`, with the
/// attribute's site as the note. An argument `sizeof` does not evaluate is
/// not checked.
#[test]
fn a_null_argument_or_return_against_nonnull_is_reported() {
    let dir = TempDir::new("badc-sanitize-nonnull");
    let src = dir.join("overflow.c");
    std::fs::write(&src, NONNULL).unwrap();
    let arg = |at: &str, n: u32| {
        format!(
            "{at}: runtime error: null pointer passed as argument {n}, which is declared to never be null"
        )
    };
    let want = [
        arg("12:18", 2),
        arg("12:46", 2),
        arg("12:60", 1),
        arg("13:12", 1),
        String::from(
            "5:5: runtime error: null pointer returned from function declared to never return null",
        ),
    ];
    let notes = ["1:16", "2:16", "3:29", "8:16", "4:16"];
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("nonnull{opt}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", "-w", opt, "-fsanitize=undefined", "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let o = run(&exe, &[]);
        assert_eq!(o.status.code(), Some(8), "{opt}: {o:?}");
        assert_eq!(reports(&o), want, "{opt}");
        let err = String::from_utf8_lossy(&o.stderr);
        let got: Vec<&str> = (err.lines())
            .filter_map(|l| {
                l.split_once("overflow.c:")?
                    .1
                    .split_once(": note: ")
                    .map(|(at, _)| at)
            })
            .collect();
        assert_eq!(got, notes, "{opt}");
    }
}

const FUNCTION: &str = "enum color { RED, GREEN };
typedef int (*binop)(int, int);
int add(int a, int b) { return a + b; }
long wide(long a, long b) { return a + b; }
int paint(enum color c, const int x) { return (int)c + x; }
int sum(int n, int a[]) { return n ? a[0] : 0; }
void show(const char *s) { (void)s; }
binop pick(int k) { return k ? add : 0; }
int old(a, b) int a, b; { return a - b; }
int main(void) {
    binop f = add, bad = (binop)wide;
    int (*g)(unsigned, int) = (int (*)(unsigned, int))paint;
    int (*h)(int, int *) = sum, a[1] = {4};
    int (*o)(int, int) = (int (*)(int, int))old;
    void (*v)(char *) = (void (*)(char *))show;
    struct { binop op; } box = { (binop)wide };
    int s = f(2, 3) + g(1, 2) + h(1, a) + pick(1)(1, 1) + o(5, 1);
    s += bad(4, 5) + box.op(1, 2);
    v(\"x\");
    return s != 30;
}
";

/// A call through a pointer to a function type incompatible with the
/// called function's reports under `-fsanitize=function` at the callee,
/// naming the pointer's type, whether the pointer is a variable or a
/// member, natively, under the JIT and in the interpreter. A compatible
/// call is not reported: an enumerated type for its integer type, a
/// parameter's own qualifier, an array parameter for its pointer, nor a
/// call to an old-style definition, which carries no prototype.
#[test]
fn a_call_through_an_incompatible_function_type_is_reported() {
    let dir = TempDir::new("badc-sanitize-function");
    let src = dir.join("overflow.c");
    std::fs::write(&src, FUNCTION).unwrap();
    let mismatch = |at: &str, ty: &str| {
        format!(
            "{at}: runtime error: call to function at ADDR through pointer to incorrect function type '{ty}'"
        )
    };
    let want = [
        mismatch("18:10", "int (*)(int, int)"),
        mismatch("18:22", "int (*)(int, int)"),
        mismatch("19:5", "void (*)(char *)"),
    ];
    let badc = || {
        let mut c = Command::new(env!("CARGO_BIN_EXE_badc"));
        c.args(["-q", "-w", "-fsanitize=function"]);
        c
    };
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("function{opt}"));
        let built = badc().arg(opt).arg("-o").arg(&exe).arg(&src).output();
        let built = built.expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let o = run(&exe, &[]);
        assert!(o.status.success(), "{opt}: {o:?}");
        assert_eq!(without_addresses(&o), want, "{opt}");
    }
    for mode in ["--jit", "--interp"] {
        let o = badc().arg(mode).arg(&src).output().expect("run badc");
        assert!(o.status.success(), "{mode}: {o:?}");
        assert_eq!(without_addresses(&o), want, "{mode}");
    }
}

const PLACED: &str = "#include <stddef.h>
#include <limits.h>
#include \"h.h\"
#define ADD(a, b) ((a) + (b))
#define TWICE(x) ADD(x, x)
__attribute__((nonnull)) int g(int *p, int *q) { return (p != 0) + (q != 0); }
int f1(int a, int b) { return /* a long comment here */ a + b; }
int f2(int a) { return INT_MAX - 0 + a; }
int f3(int a, int b) { return ADD(a, b); }
int f4(int a) { return TWICE(a); }
int f5(int a, int b) { /* first */ int c = 0; /* second
 spans lines */ return a + b + c; }
int f6(int a, int b) { return a \\
   + b; }
int main(void) {
    int x = 1, m = INT_MAX;
    int s = g(NULL, &x) + g(&x, NULL) + hh(&x, NULL);
    s += f1(m, 1) + f2(1) + f3(m, 1) + f4(m) + f5(m, 1) + f6(m, 1);
    return s != 0;
}
";

const PLACED_HEADER: &str = "#define __nonnull(params) __attribute__ ((__nonnull__ params))
extern int hh (int *__p, int *__q) __nonnull ((1, 2));
int hh(int *p, int *q) { return p == q; }
";

/// A report's column is the source's (the expected values are clang 21's
/// for the same program): after a
/// comment, a multi-line one and a line splice; inside an object-like and
/// a function-like expansion, at its use, a macro argument at its own
/// spelling, and a nested one's at the outermost use; and a note's, at the
/// use of a macro that spells the attribute in a header.
#[test]
fn a_report_names_the_source_column_past_comments_and_expansions() {
    let dir = TempDir::new("badc-sanitize-placed");
    let src = dir.join("overflow.c");
    std::fs::write(&src, PLACED).unwrap();
    std::fs::write(dir.join("h.h"), PLACED_HEADER).unwrap();
    let at = |r: &str| {
        r.split_once(": runtime error")
            .map(|(a, _)| String::from(a))
            .unwrap()
    };
    let want = [
        "17:15", "17:33", "17:48", "7:59", "8:36", "18:19", "9:31", "10:24", "18:38", "12:26",
        "14:4", "18:57", "18:7",
    ];
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("placed{opt}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", "-w", opt, "-fsanitize=undefined", "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let o = run(&exe, &[]);
        let got: Vec<String> = reports(&o).iter().map(|r| at(r)).collect();
        assert_eq!(got, want, "{opt}");
        let err = String::from_utf8_lossy(&o.stderr);
        assert!(
            err.contains("h.h:2:36: note: nonnull attribute specified here"),
            "{opt}: {err}"
        );
    }
}

const VLA: &str = "#include <stdio.h>
int main(int argc, char **argv) {
    (void)argv;
    int n = argc - 1;
    int vla[n];
    int m = -argc;
    char vla2[m + 3];
    long k = -argc;
    int (*p)[k + 1] = 0;
    unsigned u = argc - 1u;
    short s[2][u];
    printf(\"%zu %zu %zu %zu\\n\", sizeof vla, sizeof vla2, sizeof *p, sizeof s);
    return 0;
}
";

/// A variable-length array bound that is not positive reports at the bound
/// under `-fsanitize=vla-bound` (C17 6.7.6.2p5): an object's outermost and
/// inner bounds, an unsigned one at 0, and a pointer's to such an array.
#[test]
fn a_non_positive_vla_bound_is_reported() {
    let dir = TempDir::new("badc-sanitize-vla");
    let src = dir.join("overflow.c");
    std::fs::write(&src, VLA).unwrap();
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("vla{opt}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", "-w", opt, "-fsanitize=vla-bound", "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let o = run(&exe, &[]);
        assert!(o.status.success(), "{opt}: {o:?}");
        assert_eq!(
            reports(&o),
            [
                "5:13: runtime error: variable length array bound evaluates to non-positive \
                 value 0",
                "9:14: runtime error: variable length array bound evaluates to non-positive \
                 value 0",
                "11:16: runtime error: variable length array bound evaluates to non-positive \
                 value 0",
            ],
            "{opt}"
        );
    }
}

const FLOAT_CAST: &str = "#include <math.h>
#include <stdio.h>
volatile double big = 1e10;
int take(int x) { return x; }
int back(void) { return big; }
int main(int argc, char **argv) {
    (void)argv;
    int a = (int)big;
    int b = 0;
    b += big;
    int c = take(big);
    int d = back();
    int e;
    e = big * argc;
    unsigned char f = (unsigned char)(big + 1);
    volatile float nf = NAN, sf = -0.5f;
    unsigned g = sf;
    long long h = nf;
    printf(\"%d %d %d %d %d %d %u %lld\\n\", a, b, c, d, e, f, g, h);
    return 0;
}
";

/// A floating value converted to an integer type it lies outside the range
/// of reports under `-fsanitize=float-cast-overflow` (C17 6.3.1.4p1): an
/// explicit cast at its `(`, an implicit conversion of an initializer, an
/// assignment, an argument or a returned value at the value,
/// a compound assignment at its operator; a NaN and a `float` too. A value
/// whose discarded fraction leaves it in range, -0.5 to `unsigned`, does not.
#[test]
fn a_floating_value_out_of_an_integer_range_is_reported() {
    let dir = TempDir::new("badc-sanitize-float-cast");
    let src = dir.join("overflow.c");
    std::fs::write(&src, FLOAT_CAST).unwrap();
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("float{opt}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", "-w", opt, "-fsanitize=float-cast-overflow", "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let o = run(&exe, &[]);
        assert!(o.status.success(), "{opt}: {o:?}");
        let int = "is outside the range of representable values of type 'int'";
        assert_eq!(
            reports(&o),
            [
                format!("8:13: runtime error: 1e+10 {int}"),
                format!("10:7: runtime error: 1e+10 {int}"),
                format!("11:18: runtime error: 1e+10 {int}"),
                format!("5:25: runtime error: 1e+10 {int}"),
                format!("14:9: runtime error: 1e+10 {int}"),
                "15:23: runtime error: 1e+10 is outside the range of representable values of \
                 type 'unsigned char'"
                    .to_string(),
                "18:19: runtime error: nan is outside the range of representable values of type \
                 'long long'"
                    .to_string(),
            ],
            "{opt}"
        );
    }
}

const ACCESSES: &str = "#include <stdint.h>
#include <stdio.h>
struct S { int a; long long b; };
struct __attribute__((packed)) P { char c; int i; };
volatile int sink;
int main(int argc, char **argv) {
    char k = argc > 1 ? argv[1][0] : 'z';
    struct S *s = 0;
    int *p = 0;
    int **pp = 0;
    int (**pf)(int) = 0;
    char buf[32] = {0};
    uintptr_t at8 = ((uintptr_t)buf + 7) & ~(uintptr_t)7;
    int *m = (int *)(at8 + 1);
    struct S *ms = (struct S *)(at8 + 4);
    struct P *pk = (struct P *)buf;
    if (k == 'z') {
        sink = *m;
        *m = 1;
        sink = ms->a;
        sink = pk->i;
        sink = *(volatile int *)m;
        sink = *(char *)m;
    }
    if (k == 'a') sink = *p;
    if (k == 'b') *p = 1;
    if (k == 'c') p[0] += 1;
    if (k == 'd') sink = s->a;
    if (k == 'e') s->b = 2;
    if (k == 'f') sink = (*s).a;
    if (k == 'g') sink = &s->a != 0;
    if (k == 'h') sink = &*p == &p[0];
    if (k == 'i') sink = **pp;
    if (k == 'j') sink = pf[0] != 0;
    if (k == 'k') sink = &((struct S *)0)->b != 0;
    if (k == 'l') sink = ((struct S *)0)->a;
    printf(\"done\\n\");
    return 0;
}
";

/// The reports with each address the runtime prints replaced by `ADDR`.
fn without_addresses(o: &Output) -> Vec<String> {
    let strip = |r: String| {
        let mut out = String::new();
        let mut rest = r.as_str();
        while let Some(i) = rest.find("0x") {
            out.push_str(&rest[..i]);
            out.push_str("ADDR");
            rest = rest[i + 2..].trim_start_matches(|c: char| c.is_ascii_hexdigit());
        }
        out + rest
    };
    reports(o).into_iter().map(strip).collect()
}

/// An access through a null or misaligned address reports under
/// `-fsanitize=null` and `alignment`: the load or store at the `*`, the
/// pointer operand of a subscript or the member name, a
/// member access through the structure's address first, with the alignment
/// the structure's and the offset's give. `&` accesses nothing (C17
/// 6.5.3.2p3); a volatile access, a character access, a packed member and
/// a structure address that is a constant are not checked.
#[test]
fn null_and_misaligned_accesses_are_reported() {
    let dir = TempDir::new("badc-sanitize-access");
    let src = dir.join("overflow.c");
    std::fs::write(&src, ACCESSES).unwrap();
    let int = "null pointer of type 'int'";
    let cases: [(&str, &[&str]); 13] = [
        (
            "",
            &[
                "18:16: runtime error: load of misaligned address ADDR for type 'int', which \
                 requires 4 byte alignment",
                "19:9: runtime error: store to misaligned address ADDR for type 'int', which \
                 requires 4 byte alignment",
                "20:20: runtime error: member access within misaligned address ADDR for type \
                 'struct S', which requires 8 byte alignment",
                "20:20: runtime error: load of misaligned address ADDR for type 'int', which \
                 requires 8 byte alignment",
            ],
        ),
        ("a", &[&format!("25:26: runtime error: load of {int}")]),
        ("b", &[&format!("26:19: runtime error: store to {int}")]),
        ("c", &[&format!("27:19: runtime error: store to {int}")]),
        (
            "d",
            &[
                "28:29: runtime error: member access within null pointer of type 'struct S'",
                &format!("28:29: runtime error: load of {int}"),
            ],
        ),
        (
            "e",
            &["29:22: runtime error: member access within null pointer of type 'struct S'"],
        ),
        (
            "f",
            &[
                "30:26: runtime error: member access within null pointer of type 'struct S'",
                &format!("30:31: runtime error: load of {int}"),
            ],
        ),
        (
            "g",
            &["31:30: runtime error: member access within null pointer of type 'struct S'"],
        ),
        ("h", &[]),
        (
            "i",
            &["33:27: runtime error: load of null pointer of type 'int *'"],
        ),
        (
            "j",
            &["34:26: runtime error: load of null pointer of type 'int (*)(int)'"],
        ),
        ("k", &[]),
        ("l", &[&format!("36:43: runtime error: load of {int}")]),
    ];
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("access{opt}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args([
                "-q",
                "-w",
                opt,
                "-fno-crash-report",
                "-fsanitize=null,alignment",
                "-o",
            ])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        for (arg, want) in cases {
            let args: &[&str] = if arg.is_empty() { &[] } else { &[arg] };
            let o = run(&exe, args);
            assert_eq!(without_addresses(&o), want, "{opt} {arg}: {o:?}");
            // Those that access no null address go on.
            if matches!(arg, "" | "g" | "h" | "k") {
                assert!(o.status.success(), "{opt} {arg}: {o:?}");
            }
        }
    }
}

const STEPS: &str = "#include <stddef.h>
#include <stdint.h>
struct T { int t[3]; long long l; };
volatile int sink;
volatile uintptr_t sinkp;
int main(int argc, char **argv) {
    char k = argc > 1 ? argv[1][0] : '0';
    int *n = 0;
    char *top = (char *)UINTPTR_MAX - 2;
    long i = argc + 1;
    long long big = INT64_MAX / 2;
    if (k == 'a') sinkp = (uintptr_t)(n + i);
    if (k == 'b') sinkp = (uintptr_t)(n + 0);
    if (k == 'c') sinkp = (uintptr_t)(top + i * 4);
    if (k == 'd') sinkp = (uintptr_t)(top - (-i));
    if (k == 'e') sinkp = (uintptr_t)&n[i];
    if (k == 'f') { int *q = n; q++; sinkp = (uintptr_t)q; }
    if (k == 'g') { int *q = n; q += i; sinkp = (uintptr_t)q; }
    if (k == 'h') sinkp = (uintptr_t)((int *)8 - 2);
    if (k == 'i') { int *q = (int *)16; sinkp = (uintptr_t)(q + big); }
    if (k == 'k') sinkp = (uintptr_t)(i + n);
    if (k == 'l') sinkp = (uintptr_t)(n - i);
    if (k == 'm') { int *q = (int *)(uintptr_t)(4 * argc); sinkp = (uintptr_t)(q - argc); }
    if (k == 'n') { int *q = n; --q; sinkp = (uintptr_t)q; }
    if (k == 'o') sinkp = offsetof(struct T, t[1]) + offsetof(struct T, t[argc]);
    if (k == 'p') sinkp = (uintptr_t)&((struct T *)0)->t[1];
    if (k == 'q') { int *q = &n[0]; sinkp = (uintptr_t)(q + (size_t)-1); }
    if (k == 'r') { int *q = (int *)64; sinkp = (uintptr_t)(q + (size_t)-1); }
    if (k == 's') { int *q = (int *)64; sinkp = (uintptr_t)(q + (i - 3)); }
    return 0;
}
";

/// Pointer arithmetic that `-fsanitize=pointer-overflow` finds undefined
/// (C17 6.5.6p8) reports in C: a step from or to a null pointer, a result
/// on the wrong side of the base for the offset's
/// sign or, for an unsigned index, past it, and an index whose scaling to
/// bytes overflows -- `+`, `-`, a subscript, `+=`, `++` and `--`, at the
/// operator or the subscript's pointer operand. A zero literal offset
/// folds away, and `offsetof` steps from no pointer.
#[test]
fn undefined_pointer_steps_are_reported() {
    let dir = TempDir::new("badc-sanitize-steps");
    let src = dir.join("overflow.c");
    std::fs::write(&src, STEPS).unwrap();
    let null = |at: &str, n: u64| {
        format!("{at}: runtime error: applying non-zero offset {n} to null pointer")
    };
    let to_null = |at: &str, p: &str| {
        format!(
            "{at}: runtime error: applying non-zero offset to non-null pointer {p} produced null pointer"
        )
    };
    let cases: [(&str, Vec<String>); 19] = [
        ("0", vec![]),
        ("a", vec![null("12:41", 12)]),
        ("b", vec![]),
        (
            "c",
            vec![
                "14:43: runtime error: pointer index expression with base 0xfffffffffffffffd \
                  overflowed to 0x000000000009"
                    .to_string(),
            ],
        ),
        ("d", vec![to_null("15:43", "0xfffffffffffffffd")]),
        ("e", vec![null("16:39", 12)]),
        ("f", vec![null("17:34", 4)]),
        ("g", vec![null("18:35", 12)]),
        ("h", vec![to_null("19:48", "0x000000000008")]),
        (
            "i",
            vec![
                "20:63: runtime error: addition of unsigned offset to 0x000000000010 overflowed \
                  to 0x00000000000c"
                    .to_string(),
            ],
        ),
        ("k", vec![null("21:41", 12)]),
        ("l", vec![null("22:41", 18446744073709551604)]),
        ("m", vec![to_null("23:82", "0x000000000008")]),
        ("n", vec![null("24:33", 18446744073709551612)]),
        ("o", vec![]),
        ("p", vec![null("26:39", 4)]),
        ("q", vec![null("27:59", 18446744073709551612)]),
        (
            "r",
            vec![
                "28:63: runtime error: addition of unsigned offset to 0x000000000040 overflowed \
                  to 0x00000000003c"
                    .to_string(),
            ],
        ),
        ("s", vec![]),
    ];
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("steps{opt}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", "-w", opt, "-fsanitize=pointer-overflow", "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        for (arg, want) in &cases {
            let o = run(&exe, &[arg]);
            assert!(o.status.success(), "{opt} {arg}: {o:?}");
            assert_eq!(&reports(&o), want, "{opt} {arg}");
        }
    }
}

const SHIFTS: &str = "#include <limits.h>
#include <stdio.h>
__attribute__((noinline)) int big(int a, int b) { return a << b; }
__attribute__((noinline)) int neg(int a, int b) { return a >> b; }
__attribute__((noinline)) int base(int a, int b) { return a << b; }
__attribute__((noinline)) int lost(int a, int b) { return a << b; }
__attribute__((noinline)) long long wide(long long a, int b) { return a << b; }
__attribute__((noinline)) unsigned ushl(unsigned a, int b) { return a << b; }
__attribute__((noinline)) int dv(int a, int b) { return a / b; }
__attribute__((noinline)) long long md(long long a, long long b) { return a % b; }
__attribute__((noinline)) unsigned udv(unsigned a, unsigned b) { return a / b; }
int main(int argc, char **argv) {
    int k = argc - (argc > 1);
    char site = argc > 1 ? argv[1][0] : 's';
    if (site == 's') {
        printf(\"%u\\n\", ushl(3u, 30 + k));
        big(1, 31 + k);
        neg(1, -k);
        base(-k, 1);
        lost(3, 30 + k);
        wide(1, 63 + k);
    }
    if (site == 'd')
        dv(INT_MIN, -k);
    if (site == 'm')
        md(5, k - 1);
    if (site == 'u')
        udv(5u, k - 1u);
    return 0;
}
";

/// Whether the run ended in the target's integer-division fault: SIGFPE,
/// or STATUS_INTEGER_DIVIDE_BY_ZERO / STATUS_INTEGER_OVERFLOW.
fn division_faulted(o: &Output) -> bool {
    #[cfg(unix)]
    {
        use std::os::unix::process::ExitStatusExt;
        o.status.signal() == Some(8)
    }
    #[cfg(windows)]
    {
        matches!(
            o.status.code().map(|c| c as u32),
            Some(0xC000_0094 | 0xC000_0095)
        )
    }
}

/// Each site of a shift and a division reports its failure:
/// the amount negative or past the width, a negative or overflowing base
/// of a signed left shift (an unsigned one has none), `INT_MIN / -1`, and
/// a zero divisor, signed or unsigned. The division still executes after
/// the report, so each division site ends a run of its own: a zero divisor
/// faults on x86-64 and on Windows arm64, and `INT_MIN / -1` may on x86-64.
#[test]
fn shifts_and_divisions_are_checked() {
    let dir = TempDir::new("badc-sanitize-shifts");
    let src = dir.join("overflow.c");
    std::fs::write(&src, SHIFTS).unwrap();
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("shifts{opt}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", opt, "-fsanitize=undefined", "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let o = run(&exe, &[]);
        assert!(o.status.success(), "{opt}: {o:?}");
        assert_eq!(
            reports(&o),
            [
                "3:60: runtime error: shift exponent 32 is too large for 32-bit type 'int'",
                "4:60: runtime error: shift exponent -1 is negative",
                "5:61: runtime error: left shift of negative value -1",
                "6:61: runtime error: left shift of 3 by 31 places cannot be represented in \
                 type 'int'",
                "7:73: runtime error: shift exponent 64 is too large for 64-bit type 'long long'",
            ],
            "{opt}"
        );
        let zero_faults = cfg!(target_arch = "x86_64") || cfg!(windows);
        for (site, report, may_fault, must_fault) in [
            (
                "d",
                "9:59: runtime error: division of -2147483648 by -1 cannot be represented in \
                 type 'int'",
                cfg!(target_arch = "x86_64"),
                false,
            ),
            (
                "m",
                "10:77: runtime error: division by zero",
                zero_faults,
                zero_faults,
            ),
            (
                "u",
                "11:75: runtime error: division by zero",
                zero_faults,
                zero_faults,
            ),
        ] {
            let o = run(&exe, &[site]);
            assert_eq!(reports(&o), [report], "{opt} {site}: {o:?}");
            let faulted = division_faulted(&o);
            assert!(
                (o.status.success() && !must_fault) || (faulted && may_fault),
                "{opt} {site}: {o:?}"
            );
        }
    }
}

const COMPOUND: &str = "#include <limits.h>
#include <stdio.h>
int main(int argc, char **argv) {
    int k = argc - (argc > 1);
    char site = argc > 1 ? argv[1][0] : 's';
    int a = 1, b = -1, c = 3;
    long long w = 1;
    unsigned u = 1;
    if (site == 's') {
        a <<= 31 + k;
        b <<= k;
        c <<= 30 + k;
        w <<= 63 + k;
        u <<= 31 + k;
        a >>= -k;
        printf(\"%d %d %d %lld %u\\n\", a, b, c, w, u);
    }
    int d = INT_MIN;
    long long m = 5;
    unsigned q = 9;
    if (site == 'd')
        d /= -k;
    if (site == 'm')
        m %= k - 1;
    if (site == 'u')
        q /= k - 1u;
    printf(\"%d %lld %u\\n\", d, m, q);
    return 0;
}
";

/// The compound assignments `<<=`, `>>=`, `/=` and `%=` are checked as
/// the binary operators are, in the type the operation is performed in,
/// each at its operator; each division site ends a run of its own.
#[test]
fn compound_shifts_and_divisions_are_checked() {
    let dir = TempDir::new("badc-sanitize-compound");
    let src = dir.join("overflow.c");
    std::fs::write(&src, COMPOUND).unwrap();
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("compound{opt}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", opt, "-fsanitize=undefined", "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let o = run(&exe, &[]);
        assert!(o.status.success(), "{opt}: {o:?}");
        assert_eq!(
            reports(&o),
            [
                "10:11: runtime error: shift exponent 32 is too large for 32-bit type 'int'",
                "11:11: runtime error: left shift of negative value -1",
                "12:11: runtime error: left shift of 3 by 31 places cannot be represented in \
                 type 'int'",
                "13:11: runtime error: shift exponent 64 is too large for 64-bit type 'long long'",
                "14:11: runtime error: shift exponent 32 is too large for 32-bit type \
                 'unsigned int'",
                "15:11: runtime error: shift exponent -1 is negative",
            ],
            "{opt}"
        );
        let zero_faults = cfg!(target_arch = "x86_64") || cfg!(windows);
        for (site, report, may_fault, must_fault) in [
            (
                "d",
                "22:11: runtime error: division of -2147483648 by -1 cannot be represented in \
                 type 'int'",
                cfg!(target_arch = "x86_64"),
                false,
            ),
            (
                "m",
                "24:11: runtime error: division by zero",
                zero_faults,
                zero_faults,
            ),
            (
                "u",
                "26:11: runtime error: division by zero",
                zero_faults,
                zero_faults,
            ),
        ] {
            let o = run(&exe, &[site]);
            assert_eq!(reports(&o), [report], "{opt} {site}: {o:?}");
            let faulted = division_faulted(&o);
            assert!(
                (o.status.success() && !must_fault) || (faulted && may_fault),
                "{opt} {site}: {o:?}"
            );
        }
    }
}

/// `-fsanitize=enum` is taken and inserts nothing: a C enumeration holds
/// every value of its compatible integer type (C17 6.7.2.2p4), so a load
/// of one is never out of range.
#[test]
fn the_enum_check_inserts_nothing_in_c() {
    let dir = TempDir::new("badc-sanitize-enum");
    let src = dir.join("overflow.c");
    std::fs::write(
        &src,
        "enum e { A, B };\nint main(int argc, char **argv) {\n    (void)argv;\n    \
         enum e v = (enum e)(argc + 6);\n    return v == 7 ? 0 : 1;\n}\n",
    )
    .unwrap();
    let exe = dir.join("enum");
    let built = Command::new(env!("CARGO_BIN_EXE_badc"))
        .args(["-q", "-fsanitize=enum", "-fsanitize-trap=enum", "-o"])
        .arg(&exe)
        .arg(&src)
        .output()
        .expect("run badc");
    assert!(
        built.status.success(),
        "{}",
        String::from_utf8_lossy(&built.stderr)
    );
    let o = run(&exe, &[]);
    assert!(o.status.success() && o.stderr.is_empty(), "{o:?}");
}

const BOUNDS: &str = "#include <stdio.h>
struct t { int n; int tail[2]; };
int main(int argc, char **argv) {
    (void)argv;
    int a[4] = {0}, m[3][5] = {0};
    struct t box = {0}, *p = &box;
    unsigned u = argc + 3;
    signed char c = -argc;
    int r = a[u];
    r += a[c];
    r += m[argc + 1][2];
    r += m[argc][argc + 4];
    r += (argc + 3)[a];
    r += p->tail[argc + 1];
    int *end = &a[argc + 3];
    printf(\"%d %d\\n\", r, end == a + 4);
    return 0;
}
";

/// A subscript of an array of known bound is held to it under
/// `-fsanitize=bounds`, reported where its array operand begins: an
/// unsigned or negative index, the inner bound of a row, the order `i[a]`;
/// the address one past the end is in bounds. A trailing member reached
/// through a pointer is left alone, and `bounds-strict` checks it too.
#[test]
fn subscripts_are_held_to_the_array_bound() {
    let dir = TempDir::new("badc-sanitize-bounds");
    let src = dir.join("overflow.c");
    std::fs::write(&src, BOUNDS).unwrap();
    let common = [
        "9:13: runtime error: index 4 out of bounds for type 'int[4]'",
        "10:10: runtime error: index -1 out of bounds for type 'int[4]'",
        "12:10: runtime error: index 5 out of bounds for type 'int[5]'",
        "13:21: runtime error: index 4 out of bounds for type 'int[4]'",
    ];
    for (check, trailing) in [("bounds", false), ("bounds-strict", true)] {
        let mut want: Vec<&str> = common.to_vec();
        if trailing {
            want.push("14:10: runtime error: index 2 out of bounds for type 'int[2]'");
        }
        for opt in ["-O0", "-O"] {
            let exe = dir.join(format!("{check}{opt}"));
            let built = Command::new(env!("CARGO_BIN_EXE_badc"))
                .args(["-q", opt, &format!("-fsanitize={check}"), "-o"])
                .arg(&exe)
                .arg(&src)
                .output()
                .expect("run badc");
            assert!(
                built.status.success(),
                "{}",
                String::from_utf8_lossy(&built.stderr)
            );
            let o = run(&exe, &[]);
            assert!(o.status.success(), "{check} {opt}: {o:?}");
            assert_eq!(reports(&o), want, "{check} {opt}");
            assert!(
                String::from_utf8_lossy(&o.stdout)
                    .trim_end()
                    .ends_with(" 1"),
                "{o:?}"
            );
        }
    }
}

/// gcc's `bounds-strict` is `bounds` reaching the trailing members too, so
/// its checks trap, stop recovering, and turn off wherever `bounds` does:
/// by either name and by the group `undefined`, which names `bounds`.
#[test]
fn bounds_strict_traps_recovers_and_turns_off_as_bounds_does() {
    let dir = TempDir::new("badc-sanitize-strict");
    let src = dir.join("overflow.c");
    std::fs::write(&src, BOUNDS).unwrap();
    let handlers = |flags: [&str; 2]| {
        let listing = dir.join("overflow.s");
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", "-O0", "-S"])
            .args(flags)
            .arg("-o")
            .arg(&listing)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{flags:?}: {}",
            String::from_utf8_lossy(&built.stderr)
        );
        let text = std::fs::read_to_string(&listing).unwrap();
        let all = text.matches("__ubsan_handle_out_of_bounds").count();
        let aborting = text.matches("__ubsan_handle_out_of_bounds_abort").count();
        (all - aborting, aborting)
    };
    let strict = "-fsanitize=bounds-strict";
    let (returning, aborting) = handlers([strict, "-fsanitize-recover=all"]);
    assert!(returning > 0 && aborting == 0, "{returning} {aborting}");
    for name in ["undefined", "bounds", "bounds-strict"] {
        let trap = format!("-fsanitize-trap={name}");
        assert_eq!(handlers([&trap, strict]), (0, 0), "{trap}");
        let abort = format!("-fno-sanitize-recover={name}");
        assert_eq!(handlers([strict, &abort]), (0, returning), "{abort}");
        let off = format!("-fno-sanitize={name}");
        assert_eq!(handlers([strict, &off]), (0, 0), "{off}");
    }
    let off = handlers(["-fsanitize=bounds", "-fno-sanitize=bounds-strict"]);
    assert_eq!(off, (0, 0));
}

const BOOLS: &str = "#include <stdio.h>
#include <string.h>
struct in { int v[2]; };
struct s { _Bool flag; struct in in; int arr[3]; };
int main(int argc, char **argv) {
    (void)argv;
    struct s st, *sp = &st;
    memset(&st, 3, sizeof st);
    _Bool bs[2], *bp = &bs[1];
    memset(bs, 4, sizeof bs);
    int r = st.flag;
    r += sp->flag;
    r += *bp;
    r += bs[0];
    _Bool ok = argc > 0;
    r += ok;
    printf(\"%d\\n\", r);
    return 0;
}
";

/// A `_Bool` loaded whose byte is neither 0 nor 1 is reported under
/// `-fsanitize=bool`, at the lvalue's designator: the member name, the `*`,
/// the array operand; a pointer to `_Bool` and a `_Bool` holding 1 are not.
#[test]
fn a_bool_load_holds_0_or_1() {
    let dir = TempDir::new("badc-sanitize-bool");
    let src = dir.join("overflow.c");
    std::fs::write(&src, BOOLS).unwrap();
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("bool{opt}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", opt, "-fsanitize=bool", "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        let o = run(&exe, &[]);
        assert!(o.status.success(), "{opt}: {o:?}");
        assert_eq!(
            reports(&o),
            [
                "11:16: runtime error: load of value 3, which is not a valid value for type '_Bool'",
                "12:14: runtime error: load of value 3, which is not a valid value for type '_Bool'",
                "13:10: runtime error: load of value 4, which is not a valid value for type '_Bool'",
                "14:10: runtime error: load of value 4, which is not a valid value for type '_Bool'",
            ],
            "{opt}"
        );
    }
}

const TRUNCATIONS: &str = "#include <stdio.h>
unsigned char ret(int v) { return v; }
void take(unsigned char c) { printf(\"%d\\n\", c); }
int main(int argc, char **argv) {
    (void)argv;
    int big = 300 + argc, neg = -argc;
    unsigned ubig = 70000u + (unsigned)argc;
    unsigned char a = big;
    a = big;
    a += big;
    unsigned short s = 65535; ++s;
    unsigned short t = 65535; t++;
    take(big);
    a = ret(big);
    signed char sc = 200 + argc;
    unsigned short us = ubig;
    unsigned short us2 = 7; us2 += ubig;
    unsigned char k = 300;
    unsigned char e = (unsigned char)big;
    unsigned char n = neg;
    long long w = big; int narrow = w;
    printf(\"%d %d %d %d %d %d %d %d %d %d\\n\", a, s, t, sc, us, us2, k, e, n, narrow);
    return 0;
}
";

/// clang's implicit truncation checks: an initializer, an assignment, a
/// compound assignment and an increment computed in the promoted type, an
/// argument, a returned value and a constant, each reported once with
/// clang 21's text, at the converted expression or the compound operator.
/// An explicit cast and a value that fits report nothing; `undefined`
/// leaves the checks out.
#[test]
fn implicit_truncations_report_as_clang_does() {
    let dir = TempDir::new("badc-sanitize-truncation");
    let src = dir.join("overflow.c");
    std::fs::write(&src, TRUNCATIONS).unwrap();
    let build = |flag: &str, opt: &str| {
        let exe = dir.join(format!("t{}{opt}", flag.len()));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", "-w", opt, flag, "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        exe
    };
    let int_to = |at: &str, v: &str, to: &str, kept: &str, bits: u32| {
        format!(
            "{at}: runtime error: implicit conversion from type 'int' of value {v} (32-bit, \
             signed) to type '{to}' changed the value to {kept} ({bits}-bit, unsigned)"
        )
    };
    let unsigned_to = |at: &str, v: &str, kept: &str| {
        format!(
            "{at}: runtime error: implicit conversion from type 'unsigned int' of value {v} \
             (32-bit, unsigned) to type 'unsigned short' changed the value to {kept} (16-bit, \
             unsigned)"
        )
    };
    let want = [
        int_to("8:23", "301", "unsigned char", "45", 8),
        int_to("9:9", "301", "unsigned char", "45", 8),
        int_to("10:7", "346", "unsigned char", "90", 8),
        int_to("11:31", "65536", "unsigned short", "0", 16),
        int_to("12:32", "65536", "unsigned short", "0", 16),
        int_to("13:10", "301", "unsigned char", "45", 8),
        int_to("2:35", "301", "unsigned char", "45", 8),
        "15:22: runtime error: implicit conversion from type 'int' of value 201 (32-bit, signed) \
         to type 'signed char' changed the value to -55 (8-bit, signed)"
            .to_string(),
        unsigned_to("16:25", "70001", "4465"),
        unsigned_to("17:33", "70008", "4472"),
        int_to("18:23", "300", "unsigned char", "44", 8),
        int_to("20:23", "-1", "unsigned char", "255", 8),
    ];
    for opt in ["-O0", "-O"] {
        let o = run(&build("-fsanitize=implicit-integer-truncation", opt), &[]);
        assert!(o.status.success(), "{opt}: {o:?}");
        assert_eq!(reports(&o), want, "{opt}");
        assert_eq!(
            String::from_utf8_lossy(&o.stdout).lines().last(),
            Some("45 0 0 -55 4465 4472 44 45 255 301"),
            "{opt}"
        );
        let o = run(&build("-fsanitize=undefined", opt), &[]);
        assert!(o.status.success() && reports(&o).is_empty(), "{opt}: {o:?}");
    }
}

const CRASH: &str = "#include <stdio.h>
static __attribute__((noinline)) int deep(int *p) { return *p + 1; }
__attribute__((noinline)) int middle(int *p) { return deep(p) * 2; }
int main(int argc, char **argv) {
    (void)argv;
    printf(\"%d\\n\", middle(argc > 1 ? 0 : &argc));
    return 0;
}
";

fn crashed(o: &Output) -> bool {
    #[cfg(unix)]
    {
        use std::os::unix::process::ExitStatusExt;
        matches!(o.status.signal(), Some(10 | 11))
    }
    #[cfg(windows)]
    {
        o.status.code().map(|c| c as u32) == Some(0xC000_0005)
    }
}

/// Under -fcrash-report, on by default with a -fsanitize check, a fault
/// reports the signal, the registers and the frames, the program's own
/// named by the symbol table or, on Windows, by a -g build's PDB, a static
/// function's included; the program then ends by the same signal.
#[test]
fn a_fault_is_reported_with_the_frames_that_led_to_it() {
    let dir = TempDir::new("badc-crash-report");
    let src = dir.join("crash.c");
    std::fs::write(&src, CRASH).unwrap();
    let cases: [(&[&str], &str, bool); 5] = [
        (&["-fcrash-report"], "-O0", true),
        (&["-fcrash-report"], "-O", true),
        (&["-fsanitize=undefined"], "-O0", true),
        (&["-fsanitize=undefined", "-fno-crash-report"], "-O0", false),
        (&[], "-O0", false),
    ];
    for (k, (flags, opt, reported)) in cases.into_iter().enumerate() {
        let exe = dir.join(format!("crash{k}"));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", "-g", opt])
            .args(flags)
            .arg("-o")
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{}",
            String::from_utf8_lossy(&built.stderr)
        );
        assert!(run(&exe, &[]).status.success(), "{flags:?} {opt}");
        let o = run(&exe, &["a"]);
        let text = String::from_utf8_lossy(&o.stderr);
        assert!(crashed(&o), "{flags:?} {opt}: {o:?}");
        assert_eq!(
            text.contains("badc: the program took"),
            reported,
            "{flags:?} {opt}: {text}"
        );
        if !reported {
            continue;
        }
        let signal = match cfg!(windows) {
            true => "EXCEPTION_ACCESS_VIOLATION (0xc0000005) at address 0x0",
            false => "SIG",
        };
        assert!(text.contains(signal), "{text}");
        let frames: Vec<&str> = (text.lines())
            .skip_while(|l| *l != "frames:")
            .skip(1)
            .collect();
        // The unwinder reaches a frameless `deep`'s caller, which no frame
        // record holds.
        for (at, name) in ["deep", "middle", "main"].iter().enumerate() {
            let frame = frames.get(at).copied().unwrap_or_default();
            assert!(
                frame.starts_with(&format!("  #{at} 0x"))
                    && frame.contains(&format!(" in {name}+0x")),
                "{flags:?} {opt}: frame {at} is not {name}: {text}"
            );
        }
        assert!(
            frames.iter().any(|f| f.contains(" in main+0x")),
            "{flags:?} {opt}: {text}"
        );
    }
}

/// Each `FIELD` and `FITS` shifts by a constant below the width, and `pack`
/// holds a call no unit defines behind `__builtin_constant_p` tests, as
/// `main` does behind a comparison of two equal calls: the program links
/// only where every one of them folds, which takes `pack` inlined.
const DECIDED: &str = "#define BITS(h, l) ((~0ULL << (l)) & (~0ULL >> (63 - (h))))
#define FITS(v, h, l) (((unsigned long long)(v) & ~(BITS(h, l) >> (l))) == 0)
#define FIELD(v, h, l) (((unsigned long long)(v) << (l)) & BITS(h, l))
void never_defined(void);
static inline unsigned long long pack(unsigned char a, unsigned char b) {
    if (__builtin_constant_p(a) &&
        !(FITS(a, 7, 0) && FITS(a, 23, 16) && FITS(a, 39, 32) && FITS(a, 55, 48))) {
        never_defined();
    }
    if (__builtin_constant_p(b) &&
        !(FITS(b, 15, 8) && FITS(b, 31, 24) && FITS(b, 47, 40) && FITS(b, 63, 56))) {
        never_defined();
    }
    return FIELD(a, 7, 0) | FIELD(b, 15, 8) | FIELD(a, 23, 16) | FIELD(b, 31, 24) |
           FIELD(a, 39, 32) | FIELD(b, 47, 40) | FIELD(a, 55, 48) | FIELD(b, 63, 56);
}
int main(void) {
    if (pack(22, 2) != pack(22, 2)) {
        never_defined();
    }
    return pack(1, 2) == 0x0201020102010201ULL ? 0 : 1;
}
";

/// C17 6.6: a check whose operands are constants that pass it is decided
/// at translation time and inserts nothing, so a function keeps the size
/// it has without the checks and is inlined where it was. With a branch
/// and a report at each of its 48 constant shifts `pack` stayed out of
/// line, and the calls behind the comparisons it decides did not link.
#[test]
fn a_check_decided_at_translation_time_inserts_nothing() {
    let dir = TempDir::new("badc-sanitize-decided");
    let src = dir.join("decided.c");
    std::fs::write(&src, DECIDED).unwrap();
    for flag in ["-fsanitize=shift", "-fsanitize=undefined"] {
        let exe = dir.join(format!("decided{}", flag.replace('=', "_")));
        let built = Command::new(env!("CARGO_BIN_EXE_badc"))
            .args(["-q", "-O", flag, "-o"])
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{flag}: {}",
            String::from_utf8_lossy(&built.stderr)
        );
        let o = run(&exe, &[]);
        assert!(o.status.success() && o.stderr.is_empty(), "{flag}: {o:?}");
    }
    // At -O0 the listing names a handler for the shift by a variable
    // alone.
    let shifts = dir.join("shifts.c");
    std::fs::write(
        &shifts,
        "unsigned long by_three(unsigned long v) { return v << 3; }\n\
         int high_bit(void) { return 1 << 30; }\n\
         int by_n(int v, int n) { return v << n; }\n",
    )
    .unwrap();
    let listing = dir.join("shifts.s");
    let built = Command::new(env!("CARGO_BIN_EXE_badc"))
        .args(["-q", "-O0", "-fsanitize=shift", "-S", "-o"])
        .arg(&listing)
        .arg(&shifts)
        .output()
        .expect("run badc");
    assert!(
        built.status.success(),
        "{}",
        String::from_utf8_lossy(&built.stderr)
    );
    let text = std::fs::read_to_string(&listing).unwrap();
    let calls = text.matches("__ubsan_handle_shift_out_of_bounds").count();
    assert_eq!(calls, 1, "{text}");
}

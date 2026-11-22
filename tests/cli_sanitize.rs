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
        let summary = lines.get(i + 1).copied().unwrap_or_default();
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
        !o.status.success() && err.contains("signed-integer-overflow"),
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
/// handler has no form that returns. `return` is accepted and, as gcc's and
/// clang's in C, checks nothing: flowing off a function's end is undefined
/// only where the value is used (C17 6.9.1p12). Trapped, the call reports
/// nothing and still ends the program.
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
/// inner bounds, an unsigned one at 0, and a pointer's to such an array, as
/// clang evaluates its type.
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
/// of reports under `-fsanitize=float-cast-overflow` (C17 6.3.1.4p1), as
/// clang words it: an explicit cast at its `(`, an implicit conversion of an
/// initializer, an assignment, an argument or a returned value at the value,
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
/// `-fsanitize=null` and `alignment` as clang reports it: the load or store
/// at the `*`, the pointer operand of a subscript or the member name, a
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

/// Each site of a shift and a division reports what clang's runtime does:
/// the amount negative or past the width, a negative or overflowing base
/// of a signed left shift (an unsigned one has none), `INT_MIN / -1`, and
/// a zero divisor, signed or unsigned. The division still executes after
/// the report, as gcc's and clang's instrumentation lets it, so each
/// division site ends a run of its own: a zero divisor faults on x86-64
/// and on Windows arm64, and `INT_MIN / -1` may on x86-64.
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
/// of one is never out of range, as gcc and clang have it in C.
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
/// `-fsanitize=bounds`, reported where its array operand begins as clang's
/// `array-bounds` reports it: an unsigned or negative index, the inner
/// bound of a row, the order `i[a]`; the address one past the end is in
/// bounds. A trailing member reached through a pointer is left alone, as
/// gcc leaves it, and `bounds-strict` checks it too, as clang does under
/// -fstrict-flex-arrays=3.
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
/// `-fsanitize=bool`, at the lvalue's designator as clang reports it: the
/// member name, the `*`, the array operand; a pointer to `_Bool` and a
/// `_Bool` holding 1 are not.
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
/// leaves the checks out, as clang's does.
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

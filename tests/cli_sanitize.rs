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

/// The report lines, with the source path before `:<line>:` dropped.
fn reports(o: &Output) -> Vec<String> {
    (String::from_utf8_lossy(&o.stderr).lines())
        .filter_map(|l| l.split_once("overflow.c:").map(|(_, r)| r.to_string()))
        .collect()
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

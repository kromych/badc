//! The integer constants of the bundled headers against the values the
//! reference toolchains measured: `libc/header-constants/<target>.txt`,
//! written by `scripts/measure_header_constants.py`. Each header's unit is
//! the one the script measured; every listed constant is evaluated as a
//! `long long` object, whose bytes give badc's value.

use crate::{CompileOptions, Compiler, Target};

/// `FEATURES` and the base headers of `scripts/measure_header_targets.py`.
const FEATURES: &str =
    "#define _GNU_SOURCE 1\n#define _XOPEN_SOURCE 700\n#define _DARWIN_C_SOURCE 1\n";
const BASE: &str = "#include <sys/types.h>\n#include <sys/socket.h>\n\
                    #include <netinet/in.h>\n#include <stdint.h>\n#include <stddef.h>\n";
/// `PREREQS["windows"]`.
const WINDOWS_BASE: &str = "#include <winsock2.h>\n#include <windows.h>\n";

/// Per header: its name, whether its unit includes the base headers, and
/// its constants.
type Header<'a> = (&'a str, bool, Vec<(&'a str, i64)>);

fn parse(table: &str) -> Vec<Header<'_>> {
    let mut headers: Vec<Header> = Vec::new();
    for line in table
        .lines()
        .filter(|l| !l.is_empty() && !l.starts_with('#'))
    {
        let (a, b) = line.split_once(' ').expect("two fields");
        if a.contains('.') {
            headers.push((a, b == "p", Vec::new()));
        } else {
            let value = b.parse().expect("value");
            headers.last_mut().expect("header").2.push((a, value));
        }
    }
    headers
}

const MACOS_11: &str = "the images load on macOS 11; the measuring SDK targets itself";

const WINDOWS: &[Target] = &[Target::WindowsX64, Target::WindowsAarch64];

/// The constants badc gives another value than the reference on purpose.
/// Each must still differ, or the list is stale.
const DEPARTURES: &[(&[Target], &str, &str)] = &[
    (
        &[Target::MacOSAarch64],
        "MAC_OS_X_VERSION_MIN_REQUIRED",
        MACOS_11,
    ),
    (
        &[Target::MacOSAarch64],
        "MAC_OS_X_VERSION_MAX_ALLOWED",
        MACOS_11,
    ),
    (&[Target::MacOSAarch64], "AIO_LISTIO_MAX", MACOS_11),
    (WINDOWS, "INT_FAST16_MIN", FAST16),
    (WINDOWS, "INT_FAST16_MAX", FAST16),
    (WINDOWS, "UINT_FAST16_MAX", FAST16),
    (&[Target::WindowsX64], "DECIMAL_DIG", LONG_DOUBLE),
    (&[Target::WindowsX64], "LDBL_DECIMAL_DIG", LONG_DOUBLE),
    (&[Target::WindowsX64], "LDBL_DIG", LONG_DOUBLE),
    (&[Target::WindowsX64], "LDBL_MANT_DIG", LONG_DOUBLE),
    (&[Target::WindowsX64], "LDBL_MAX_10_EXP", LONG_DOUBLE),
    (&[Target::WindowsX64], "LDBL_MAX_EXP", LONG_DOUBLE),
    (&[Target::WindowsX64], "LDBL_MIN_10_EXP", LONG_DOUBLE),
    (&[Target::WindowsX64], "LDBL_MIN_EXP", LONG_DOUBLE),
    (WINDOWS, "WINVER", WINDOWS_10),
    (WINDOWS, "NTDDI_VERSION", WINDOWS_10),
    (WINDOWS, "WINAPI_PARTITION_APP", WINDOWS_10),
    (WINDOWS, "WINAPI_PARTITION_PC_APP", WINDOWS_10),
    (WINDOWS, "WINAPI_PARTITION_PHONE_APP", WINDOWS_10),
    (WINDOWS, "WINAPI_PARTITION_SYSTEM", WINDOWS_10),
    (WINDOWS, "REG_LEGAL_OPTION", CURRENT_SDK),
];

const FAST16: &str = "the 16-bit fast types are MSVC's int";
const LONG_DOUBLE: &str = "long double is MSVC's 8-byte double, mingw-w64 gcc's the x87 type";
const WINDOWS_10: &str = "the headers target Windows 10; mingw-w64 defaults to an earlier version";
const CURRENT_SDK: &str = "the current SDK's value, which mingw-w64 lags";

/// Constants badc defines as something other than an integer on purpose,
/// left out of the unit that evaluates the rest.
const NOT_INTEGERS: &[(&[Target], &str, &str)] = &[
    (WINDOWS, "PTHREAD_MUTEX_INITIALIZER", PTHREAD),
    (WINDOWS, "PTHREAD_RECURSIVE_MUTEX_INITIALIZER", PTHREAD),
    (WINDOWS, "PTHREAD_ERRORCHECK_MUTEX_INITIALIZER", PTHREAD),
    (WINDOWS, "PTHREAD_COND_INITIALIZER", PTHREAD),
];

const PTHREAD: &str = "libc/lib/pthread_ext.c keeps the lock inline, winpthreads a handle";

/// glibc 2.42 numbered the termios speeds by their baud rates, with new
/// symbol versions of the speed functions; badc binds the earlier versions,
/// which take the codes the speed constants had before.
fn termios_speed(target: Target, name: &str) -> bool {
    let baud = name
        .strip_prefix('B')
        .is_some_and(|d| !d.is_empty() && d.bytes().all(|b| b.is_ascii_digit()));
    matches!(target, Target::LinuxX64 | Target::LinuxAarch64)
        && (baud || name == "EXTA" || name == "EXTB")
}

fn check(target: Target, table: &str) {
    let mut failures = Vec::new();
    let departs = |name: &str| {
        DEPARTURES
            .iter()
            .any(|&(t, n, _)| t.contains(&target) && n == name)
    };
    let evaluated = |&&(name, _): &&(&str, i64)| {
        !NOT_INTEGERS
            .iter()
            .any(|&(t, n, _)| t.contains(&target) && n == name)
    };
    for (header, base, constants) in parse(table) {
        let constants: Vec<(&str, i64)> = constants.iter().filter(evaluated).copied().collect();
        let base = match (base, target.is_windows()) {
            (false, _) => "",
            (true, false) => BASE,
            (true, true) => WINDOWS_BASE,
        };
        let mut src = format!("{FEATURES}{base}#include <{header}>\n");
        for (i, (name, _)) in constants.iter().enumerate() {
            src += &format!("long long __badc_v{i} = (long long)({name});\n");
        }
        let opts = CompileOptions::default().with_no_entry_point(true);
        let program = match Compiler::with_options(src, target, opts).compile() {
            Ok(p) => p,
            Err(e) => {
                failures.push(format!("{header}: {e}"));
                continue;
            }
        };
        for (i, (name, want)) in constants.iter().enumerate() {
            let slot = format!("__badc_v{i}");
            let sym = program
                .symbols
                .iter()
                .find(|s| s.name == slot)
                .expect("slot");
            let at = sym.val as usize;
            let got = i64::from_le_bytes(program.data[at..at + 8].try_into().unwrap());
            if termios_speed(target, name) {
                continue;
            }
            match (got != *want, departs(name)) {
                (true, false) => {
                    failures.push(format!("{header}: {name} is {got}, the reference's {want}"))
                }
                (false, true) => {
                    failures.push(format!("{header}: {name} is a departure that matches"))
                }
                _ => {}
            }
        }
    }
    assert!(
        failures.is_empty(),
        "{target:?}: {} constant(s) differ from the reference:\n  {}",
        failures.len(),
        failures.join("\n  ")
    );
}

#[test]
fn macos_aarch64_constants_are_the_sdks() {
    check(
        Target::MacOSAarch64,
        include_str!("../../../libc/header-constants/macos-aarch64.txt"),
    );
}

#[test]
fn linux_x64_constants_are_glibcs() {
    check(
        Target::LinuxX64,
        include_str!("../../../libc/header-constants/linux-x64.txt"),
    );
}

#[test]
fn linux_aarch64_constants_are_glibcs() {
    check(
        Target::LinuxAarch64,
        include_str!("../../../libc/header-constants/linux-aarch64.txt"),
    );
}

#[test]
fn windows_x64_constants_are_mingw_w64s() {
    check(
        Target::WindowsX64,
        include_str!("../../../libc/header-constants/windows-x64.txt"),
    );
}

#[test]
fn windows_arm64_constants_are_mingw_w64s() {
    check(
        Target::WindowsAarch64,
        include_str!("../../../libc/header-constants/windows-arm64.txt"),
    );
}

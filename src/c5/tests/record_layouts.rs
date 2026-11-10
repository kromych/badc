//! The records and typedef names of the bundled headers against the layouts
//! the reference toolchains measured: `libc/record-layouts/<target>.txt`, written
//! by `scripts/measure_record_layouts.py`. Each header's unit is the one the
//! script measured: the feature-test macros, the base headers for a header
//! marked `p`, then the header.

use crate::{CompileOptions, Compiler, Target};

/// `FEATURES` and `PREREQS["posix"]` of `scripts/measure_header_targets.py`.
const FEATURES: &str =
    "#define _GNU_SOURCE 1\n#define _XOPEN_SOURCE 700\n#define _DARWIN_C_SOURCE 1\n";
const BASE: &str = "#include <sys/types.h>\n#include <sys/socket.h>\n\
                    #include <netinet/in.h>\n#include <stdint.h>\n#include <stddef.h>\n";
/// `PREREQS["windows"]`.
const WINDOWS_BASE: &str = "#include <winsock2.h>\n#include <windows.h>\n";

/// One measured member: its byte offset, or a bit-field's first bit and width.
enum Member {
    At(usize),
    Bits(usize, u32),
}

struct Record<'a> {
    /// `struct`, `union`, or `typedef` for a record named by a typedef.
    kind: &'a str,
    tag: &'a str,
    size: usize,
    align: usize,
    /// Whether an integer type a typedef names is signed.
    signed: Option<bool>,
    members: Vec<(&'a str, Member)>,
}

/// Per header: its name, whether its unit includes the base headers, and
/// its records.
type Header<'a> = (&'a str, bool, Vec<Record<'a>>);

fn parse(table: &str) -> Vec<Header<'_>> {
    let mut headers: Vec<Header> = Vec::new();
    for line in table
        .lines()
        .filter(|l| !l.is_empty() && !l.starts_with('#'))
    {
        let f: Vec<&str> = line.split_whitespace().collect();
        let num = |i: usize| f[i].parse::<usize>().expect("number");
        if !line.starts_with(' ') && f.len() == 2 {
            headers.push((f[0], f[1] == "p", Vec::new()));
        } else if !line.starts_with(' ') {
            let records = &mut headers.last_mut().expect("header").2;
            records.push(Record {
                kind: f[0],
                tag: f[1],
                size: num(2),
                align: num(3),
                signed: f.get(4).map(|s| *s == "signed"),
                members: Vec::new(),
            });
        } else {
            let records = &mut headers.last_mut().expect("header").2;
            let member = if f[1] == "bit" {
                Member::Bits(num(2), num(3) as u32)
            } else {
                Member::At(num(1))
            };
            records
                .last_mut()
                .expect("record")
                .members
                .push((f[0], member));
        }
    }
    headers
}

const LONG_DOUBLE: &str = "long double is MSVC's 8-byte double, mingw-w64 gcc's the x87 type";
const FAST16: &str = "the 16-bit fast types are MSVC's int";
const PTHREAD: &str = "libc/lib/pthread_ext.c keeps the lock inline, winpthreads a handle";
const NLS: &str = "the Windows SDK's since Windows 8; mingw-w64 has the three-member form";

/// The entries badc lays out differently from the reference on purpose.
/// Each must still differ, or the list is stale.
const DEPARTURES: &[(Target, &str, &str)] = &[
    (Target::WindowsX64, "typedef max_align_t", LONG_DOUBLE),
    (Target::WindowsX64, "typedef _LONGDOUBLE", LONG_DOUBLE),
    (Target::WindowsX64, "typedef int_fast16_t", FAST16),
    (Target::WindowsX64, "typedef uint_fast16_t", FAST16),
    (Target::WindowsX64, "typedef atomic_int_fast16_t", FAST16),
    (Target::WindowsX64, "typedef atomic_uint_fast16_t", FAST16),
    (
        Target::WindowsX64,
        "typedef mbstate_t",
        "it carries the <uchar.h> conversion state msvcrt lacks",
    ),
    (
        Target::WindowsX64,
        "typedef off_t",
        "64-bit, as mingw-w64 makes it under _FILE_OFFSET_BITS=64",
    ),
    (
        Target::WindowsX64,
        "typedef pid_t",
        "msvcrt's _getpid returns int",
    ),
    (Target::WindowsX64, "typedef pthread_mutex_t", PTHREAD),
    (Target::WindowsX64, "typedef pthread_cond_t", PTHREAD),
    (
        Target::WindowsX64,
        "typedef EXCEPTION_DISPOSITION",
        "the SDK's enum, where mingw-w64 spells it as int",
    ),
    (Target::WindowsX64, "struct _nlsversioninfo", NLS),
    (Target::WindowsX64, "typedef NLSVERSIONINFO", NLS),
];

fn check(target: Target, table: &str) {
    let mut failures = Vec::new();
    let departs = |entry: &str| {
        DEPARTURES
            .iter()
            .any(|&(t, e, _)| t == target && e == entry)
    };
    for (header, base, records) in parse(table) {
        let base = match (base, target.is_windows()) {
            (false, _) => "",
            (true, false) => BASE,
            (true, true) => WINDOWS_BASE,
        };
        let src = format!("{FEATURES}{base}#include <{header}>\n");
        let opts = CompileOptions::default().with_no_entry_point(true);
        let program = match Compiler::with_options(src, target, opts).compile() {
            Ok(p) => p,
            Err(e) => {
                failures.push(format!("{header}: {e}"));
                continue;
            }
        };
        for r in records {
            let kind = r.kind;
            let entry = format!("{kind} {}", r.tag);
            let before = failures.len();
            // (size, align, the record's members if it names one)
            let found = if kind == "typedef" {
                (program.typedefs.iter())
                    .find(|t| t.name == r.tag)
                    .map(|t| {
                        (
                            t.size,
                            t.align,
                            t.record.map(|id| &program.structs[id].fields),
                            t.signed,
                        )
                    })
            } else {
                (program.structs.iter())
                    .find(|s| {
                        s.is_complete
                            && !s.is_anonymous
                            && s.is_union == (kind == "union")
                            && s.name == r.tag
                    })
                    .map(|s| (s.size, s.align, Some(&s.fields), None))
            };
            let Some((size, align, fields, signed)) = found else {
                failures.push(format!("{header}: {kind} {} is not defined", r.tag));
                continue;
            };
            if r.signed.is_some() && signed != r.signed {
                let s = |v: Option<bool>| {
                    if v == Some(true) {
                        "signed"
                    } else {
                        "not signed"
                    }
                };
                failures.push(format!(
                    "{header}: {kind} {} is {}, the reference's {}",
                    r.tag,
                    s(signed),
                    s(r.signed)
                ));
            }
            if (size, align) != (r.size, r.align) {
                failures.push(format!(
                    "{header}: {kind} {}: size {size} align {align}, the reference's {} {}",
                    r.tag, r.size, r.align
                ));
            }
            let fields = fields.map_or(&[][..], |f| &f[..]);
            for (name, want) in &r.members {
                let field = fields.iter().find(|f| f.name == *name);
                let got = field.map(|f| match f.bit_width {
                    0 => Member::At(f.offset),
                    w => Member::Bits(f.offset * 8 + f.bit_offset as usize, w),
                });
                let same = match (&got, want) {
                    (Some(Member::At(a)), Member::At(b)) => a == b,
                    (Some(Member::Bits(a, w)), Member::Bits(b, v)) => a == b && w == v,
                    _ => false,
                };
                if !same {
                    failures.push(format!(
                        "{header}: {kind} {}.{name} is not where the reference has it",
                        r.tag
                    ));
                }
            }
            if departs(&entry) {
                if failures.len() == before {
                    failures.push(format!("{header}: {entry} is a departure that matches"));
                }
                failures.truncate(before);
            }
        }
    }
    assert!(
        failures.is_empty(),
        "{target:?}: {} record layout(s) differ from the reference:\n  {}",
        failures.len(),
        failures.join("\n  ")
    );
}

#[test]
fn linux_x64_records_are_glibcs() {
    check(
        Target::LinuxX64,
        include_str!("../../../libc/record-layouts/linux-x64.txt"),
    );
}

#[test]
fn linux_aarch64_records_are_glibcs() {
    check(
        Target::LinuxAarch64,
        include_str!("../../../libc/record-layouts/linux-aarch64.txt"),
    );
}

#[test]
fn macos_aarch64_records_are_the_sdks() {
    check(
        Target::MacOSAarch64,
        include_str!("../../../libc/record-layouts/macos-aarch64.txt"),
    );
}

#[test]
fn windows_x64_records_are_mingw_w64s() {
    check(
        Target::WindowsX64,
        include_str!("../../../libc/record-layouts/windows-x64.txt"),
    );
}

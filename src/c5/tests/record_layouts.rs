//! The tagged records of the bundled headers against the layouts the
//! reference toolchains measured: `libc/record-layouts/<target>.txt`, written
//! by `scripts/measure_record_layouts.py`. Each header's unit is the one the
//! script measured: the feature-test macros, the base headers for a header
//! marked `p`, then the header.

use crate::{CompileOptions, Compiler, Target};

/// `FEATURES` and `PREREQS["posix"]` of `scripts/measure_header_targets.py`.
const FEATURES: &str =
    "#define _GNU_SOURCE 1\n#define _XOPEN_SOURCE 700\n#define _DARWIN_C_SOURCE 1\n";
const BASE: &str = "#include <sys/types.h>\n#include <sys/socket.h>\n\
                    #include <netinet/in.h>\n#include <stdint.h>\n#include <stddef.h>\n";

/// One measured member: its byte offset, or a bit-field's first bit and width.
enum Member {
    At(usize),
    Bits(usize, u32),
}

struct Record<'a> {
    is_union: bool,
    tag: &'a str,
    size: usize,
    align: usize,
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
                is_union: f[0] == "union",
                tag: f[1],
                size: num(2),
                align: num(3),
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

fn check(target: Target, table: &str) {
    let mut failures = Vec::new();
    for (header, base, records) in parse(table) {
        let base = if base { BASE } else { "" };
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
            let kind = if r.is_union { "union" } else { "struct" };
            let Some(def) = (program.structs.iter()).find(|s| {
                s.is_complete && !s.is_anonymous && s.is_union == r.is_union && s.name == r.tag
            }) else {
                failures.push(format!("{header}: {kind} {} is not defined", r.tag));
                continue;
            };
            if (def.size, def.align) != (r.size, r.align) {
                failures.push(format!(
                    "{header}: {kind} {}: size {} align {}, the reference's {} {}",
                    r.tag, def.size, def.align, r.size, r.align
                ));
            }
            for (name, want) in &r.members {
                let field = def.fields.iter().find(|f| f.name == *name);
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

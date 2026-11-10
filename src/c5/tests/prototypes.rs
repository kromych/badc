//! The function declarations of the bundled headers against those the
//! reference toolchains found compatible with their own:
//! `libc/prototypes/<target>.txt`, written by `scripts/measure_prototypes.py`.
//! Each listed function must keep the type the measurement checked; a
//! change is remeasured against the reference.

use crate::{CompileOptions, Compiler, Target};

/// `FEATURES` and `PREREQS` of `scripts/measure_header_targets.py`.
const FEATURES: &str =
    "#define _GNU_SOURCE 1\n#define _XOPEN_SOURCE 700\n#define _DARWIN_C_SOURCE 1\n";
const BASE: &str = "#include <sys/types.h>\n#include <sys/socket.h>\n\
                    #include <netinet/in.h>\n#include <stdint.h>\n#include <stddef.h>\n";
const WINDOWS_BASE: &str = "#include <winsock2.h>\n#include <windows.h>\n";

/// Per header: its name, whether its unit includes the base headers, and
/// its functions with their checked types.
type Header<'a> = (&'a str, bool, Vec<(&'a str, &'a str)>);

fn parse(table: &str) -> Vec<Header<'_>> {
    let mut headers: Vec<Header> = Vec::new();
    for line in table
        .lines()
        .filter(|l| !l.is_empty() && !l.starts_with('#'))
    {
        match line.split_once('\t') {
            Some((name, ty)) => headers.last_mut().expect("header").2.push((name, ty)),
            None => {
                let (h, cell) = line.split_once(' ').expect("header line");
                headers.push((h, cell == "p", Vec::new()));
            }
        }
    }
    headers
}

fn check(target: Target, table: &str) {
    let mut failures = Vec::new();
    for (header, base, functions) in parse(table) {
        let base = match (base, target.is_windows()) {
            (false, _) => "",
            (true, false) => BASE,
            (true, true) => WINDOWS_BASE,
        };
        let src = format!("{FEATURES}{base}#include <{header}>\n");
        let opts = CompileOptions::default()
            .with_no_entry_point(true)
            .with_prototypes(true);
        let program = match Compiler::with_options(src, target, opts).compile() {
            Ok(p) => p,
            Err(e) => {
                failures.push(format!("{header}: {e}"));
                continue;
            }
        };
        for (name, want) in functions {
            match program.prototypes.iter().find(|(n, _)| n == name) {
                None => failures.push(format!("{header}: {name} is not declared")),
                Some((_, got)) if got != want => {
                    failures.push(format!("{header}: {name} is {got}, checked as {want}"))
                }
                Some(_) => {}
            }
        }
    }
    assert!(
        failures.is_empty(),
        "{target:?}: {} declaration(s) differ from the checked ones:\n  {}",
        failures.len(),
        failures.join("\n  ")
    );
}

#[test]
fn macos_aarch64_declarations_are_the_sdks() {
    check(
        Target::MacOSAarch64,
        include_str!("../../../libc/prototypes/macos-aarch64.txt"),
    );
}

#[test]
fn linux_x64_declarations_are_glibcs() {
    check(
        Target::LinuxX64,
        include_str!("../../../libc/prototypes/linux-x64.txt"),
    );
}

#[test]
fn linux_aarch64_declarations_are_glibcs() {
    check(
        Target::LinuxAarch64,
        include_str!("../../../libc/prototypes/linux-aarch64.txt"),
    );
}

#[test]
fn windows_x64_declarations_are_mingw_w64s() {
    check(
        Target::WindowsX64,
        include_str!("../../../libc/prototypes/windows-x64.txt"),
    );
}

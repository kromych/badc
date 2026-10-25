//! The `ar` and `ranlib` personas (argv[0] `ar`, `*-ar`, `ranlib`, `*-ranlib`,
//! or `badc --ar <key>`): POSIX ar's `d p q r t x` with `c s S u v`, always in
//! GNU ar's deterministic `D` mode. The index lists the members' global
//! definitions.

use std::io::Write;

use super::inputs::native_defined_globals;

/// The operation letters; a key names at most one. `s` is the operation
/// when the key names no other and the index modifier beside one.
const OPERATIONS: &str = "dmpqrtx";
/// The modifiers applied or taken: with no member dates `u` replaces as `r`
/// does, as under GNU ar's default `D`.
const MODIFIERS: &str = "cDsSuv";

/// Whether `argv0` names the ar or ranlib persona, or `first` is `--ar`
/// followed by a key rather than the `--ar -o <archive>` driver form.
pub(crate) fn persona(argv0: &str, first: Option<&str>, second: Option<&str>) -> Option<bool> {
    let base = std::path::Path::new(argv0)
        .file_stem()
        .and_then(|s| s.to_str())
        .unwrap_or("");
    if base == "ranlib" || base.ends_with("-ranlib") {
        return Some(true);
    }
    if base == "ar" || base.ends_with("-ar") {
        return Some(false);
    }
    (first == Some("--ar") && second.is_some_and(is_key)).then_some(false)
}

/// A POSIX ar key: letters after at most one `-`, naming one operation
/// or `s` alone.
fn is_key(arg: &str) -> bool {
    let letters = arg.strip_prefix('-').unwrap_or(arg);
    let ops = letters.chars().filter(|&c| OPERATIONS.contains(c)).count();
    letters.chars().all(|c| c.is_ascii_alphabetic())
        && (ops == 1 || ops == 0 && letters.contains('s'))
}

fn fail(msg: impl core::fmt::Display) -> ! {
    eprintln!("badc: error: {msg}");
    std::process::exit(1);
}

/// The member name a path takes: its base name, as POSIX ar stores it.
fn member_name(path: &str) -> String {
    std::path::Path::new(path)
        .file_name()
        .map(|n| n.to_string_lossy().into_owned())
        .unwrap_or_else(|| path.to_string())
}

fn read_members(path: &str) -> Vec<badc::ArchiveMember> {
    let bytes = std::fs::read(path).unwrap_or_else(|e| fail(format!("cannot read `{path}`: {e}")));
    badc::read_archive(&bytes).unwrap_or_else(|e| fail(format!("`{path}`: {e}")))
}

/// Write `members` to `path` with a symbol index when `index` holds.
fn write_members(path: &str, members: &[badc::ArchiveMember], index: bool) {
    let symbols: Vec<(usize, Vec<String>)> = if index {
        (members.iter().enumerate())
            .filter(|(_, m)| badc::is_native_object(&m.bytes))
            .filter_map(|(i, m)| Some((i, native_defined_globals(&m.bytes, &m.name).ok()?)))
            .collect()
    } else {
        Vec::new()
    };
    let blob = badc::write_archive(members, &symbols);
    std::fs::write(path, blob).unwrap_or_else(|e| fail(format!("cannot write `{path}`: {e}")));
}

/// Run the persona over the arguments after the program name; the exit status.
pub(crate) fn run(ranlib: bool, args: &[String]) -> i32 {
    if ranlib {
        // `-D` (deterministic) and `-t` (stamp the index) state what every
        // archive written here already is.
        if let Some(opt) = args
            .iter()
            .find(|a| a.starts_with('-') && *a != "-D" && *a != "-t")
        {
            fail(format!("ranlib: option `{opt}` is not supported"));
        }
        let archives: Vec<&String> = args.iter().filter(|a| !a.starts_with('-')).collect();
        if archives.is_empty() {
            fail("ranlib: no archive named");
        }
        for path in archives {
            write_members(path, &read_members(path), true);
        }
        return 0;
    }
    let (Some(key), Some(archive)) = (args.first(), args.get(1)) else {
        fail("ar: usage: ar key archive [file...]");
    };
    if !is_key(key) {
        fail(format!(
            "ar: `{key}` is not a key: one of `{OPERATIONS}s` with modifiers"
        ));
    }
    let letters = key.strip_prefix('-').unwrap_or(key);
    if let Some(c) = letters
        .chars()
        .find(|&c| !OPERATIONS.contains(c) && !MODIFIERS.contains(c))
    {
        fail(format!("ar: modifier `{c}` is not supported"));
    }
    let has = |c: char| letters.contains(c);
    let op = letters
        .chars()
        .find(|&c| OPERATIONS.contains(c))
        .unwrap_or('s');
    let files = &args[2..];
    let exists = std::path::Path::new(archive).exists();
    let mut members = if exists {
        read_members(archive)
    } else {
        Vec::new()
    };
    let verbose = has('v');
    let mut out = std::io::stdout().lock();
    let selected = |m: &badc::ArchiveMember| {
        files.is_empty() || files.iter().any(|f| member_name(f) == m.name)
    };
    match op {
        'q' | 'r' => {
            if !exists && !has('c') {
                eprintln!("badc: creating {archive}");
            }
            for f in files {
                let bytes =
                    std::fs::read(f).unwrap_or_else(|e| fail(format!("cannot read `{f}`: {e}")));
                let name = member_name(f);
                let at = (op == 'r')
                    .then(|| members.iter().position(|m| m.name == name))
                    .flatten();
                if verbose {
                    let _ = writeln!(out, "{} - {f}", if at.is_some() { 'r' } else { 'a' });
                }
                match at {
                    Some(i) => members[i].bytes = bytes,
                    None => members.push(badc::ArchiveMember { name, bytes }),
                }
            }
            write_members(archive, &members, !has('S'));
        }
        's' => write_members(archive, &members, true),
        'd' => {
            members.retain(|m| {
                let drop = files.iter().any(|f| member_name(f) == m.name);
                if drop && verbose {
                    let _ = writeln!(out, "d - {}", m.name);
                }
                !drop
            });
            write_members(archive, &members, !has('S'));
        }
        't' | 'p' | 'x' if !exists => fail(format!("cannot read `{archive}`: no such archive")),
        't' => {
            // GNU ar's `tv` line for a member of a deterministic archive.
            for m in members.iter().filter(|m| selected(m)) {
                let _ = if verbose {
                    writeln!(
                        out,
                        "rw-r--r-- 0/0 {:>6} Jan  1 00:00 1970 {}",
                        m.bytes.len(),
                        m.name
                    )
                } else {
                    writeln!(out, "{}", m.name)
                };
            }
        }
        'p' => {
            for m in members.iter().filter(|m| selected(m)) {
                let _ = out.write_all(&m.bytes);
            }
        }
        'x' => {
            for m in members.iter().filter(|m| selected(m)) {
                if verbose {
                    let _ = writeln!(out, "x - {}", m.name);
                }
                std::fs::write(&m.name, &m.bytes)
                    .unwrap_or_else(|e| fail(format!("cannot write `{}`: {e}", m.name)));
            }
        }
        _ => fail(format!("ar: operation `{op}` is not supported")),
    }
    0
}

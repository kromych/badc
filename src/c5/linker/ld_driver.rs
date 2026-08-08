//! GNU-ld-compatible driver. Entered when badc is invoked as `ld`
//! (argv[0] basename `ld` / `ld.badc` / `*-ld`) or with a leading
//! `--ld`, so a build system can set `LD=badc` unchanged.
//!
//! Supported today: relocatable links (`-r`), including the option
//! surface a kernel build passes. Final links dispatch to the
//! script-driven engine. TODO: route final links here once the
//! SECTIONS/PHDRS layout engine lands.

#![cfg(feature = "std")]

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;
use hashbrown::HashSet;
use std::path::{Path, PathBuf};

use super::archive;
use super::relocatable::{
    EM_AARCH64, EM_X86_64, EtRel, LdScript, RelinkOptions, link_relocatable, parse_et_rel,
    parse_module_script,
};

/// How positional inputs and archive state were ordered on the
/// command line.
enum InputItem {
    File(PathBuf),
    Lib(String),
    WholeArchiveOn,
    WholeArchiveOff,
    GroupStart,
    GroupEnd,
}

#[derive(PartialEq, Eq, Clone, Copy)]
enum BuildId {
    None,
    Sha1,
}

struct LdArgs {
    relocatable: bool,
    output: PathBuf,
    emulation: Option<String>,
    script: Option<PathBuf>,
    inputs: Vec<InputItem>,
    lib_paths: Vec<PathBuf>,
    build_id: BuildId,
    fatal_warnings: bool,
    emit_relocs: bool,
    no_undefined: bool,
    discard_locals: bool,
    strip_debug: bool,
    orphan_handling: Option<String>,
    /// `-z noexecstack` / `-z execstack`.
    gnu_stack: Option<bool>,
    print_version: bool,
}

fn ld_err(msg: impl core::fmt::Display) -> i32 {
    eprintln!("badc-ld: error: {msg}");
    1
}

/// True when this invocation should take the ld driver: the program
/// was installed/aliased as `ld`, or the first argument is `--ld`.
pub fn is_ld_invocation(argv0: &str, first_arg: Option<&str>) -> bool {
    if first_arg == Some("--ld") {
        return true;
    }
    let base = Path::new(argv0)
        .file_stem()
        .and_then(|s| s.to_str())
        .unwrap_or("");
    base == "ld" || base == "ld.badc" || base.ends_with("-ld")
}

/// Run the ld driver over `args` (program name and any `--ld` marker
/// already stripped). Returns the process exit code.
pub fn run_ld(args: &[String]) -> i32 {
    let mut a = LdArgs {
        relocatable: false,
        output: PathBuf::from("a.out"),
        emulation: None,
        script: None,
        inputs: Vec::new(),
        lib_paths: Vec::new(),
        build_id: BuildId::None,
        fatal_warnings: false,
        emit_relocs: false,
        no_undefined: false,
        discard_locals: false,
        strip_debug: false,
        orphan_handling: None,
        gnu_stack: None,
        print_version: false,
    };
    let mut it = args.iter().map(String::as_str);
    let next_of = |it: &mut dyn Iterator<Item = &str>, flag: &str| -> Result<String, i32> {
        it.next()
            .map(str::to_string)
            .ok_or_else(|| ld_err(format!("{flag} requires an argument")))
    };
    while let Some(arg) = it.next() {
        match arg {
            "-r" | "--relocatable" | "-i" => a.relocatable = true,
            "-o" => match next_of(&mut it, "-o") {
                Ok(p) => a.output = PathBuf::from(p),
                Err(c) => return c,
            },
            "-m" => match next_of(&mut it, "-m") {
                Ok(e) => a.emulation = Some(e),
                Err(c) => return c,
            },
            s if s.starts_with("-m") && s.len() > 2 => {
                a.emulation = Some(s[2..].to_string());
            }
            "-T" | "--script" => match next_of(&mut it, "-T") {
                Ok(p) => a.script = Some(PathBuf::from(p)),
                Err(c) => return c,
            },
            s if s.starts_with("--script=") => {
                a.script = Some(PathBuf::from(&s["--script=".len()..]));
            }
            s if s.starts_with("-T") && s.len() > 2 => {
                a.script = Some(PathBuf::from(&s[2..]));
            }
            "--whole-archive" => a.inputs.push(InputItem::WholeArchiveOn),
            "--no-whole-archive" => a.inputs.push(InputItem::WholeArchiveOff),
            "--start-group" | "-(" => a.inputs.push(InputItem::GroupStart),
            "--end-group" | "-)" => a.inputs.push(InputItem::GroupEnd),
            "-L" => match next_of(&mut it, "-L") {
                Ok(p) => a.lib_paths.push(PathBuf::from(p)),
                Err(c) => return c,
            },
            s if s.starts_with("-L") && s.len() > 2 => {
                a.lib_paths.push(PathBuf::from(&s[2..]));
            }
            "-l" => match next_of(&mut it, "-l") {
                Ok(n) => a.inputs.push(InputItem::Lib(n)),
                Err(c) => return c,
            },
            s if s.starts_with("-l") && s.len() > 2 => {
                a.inputs.push(InputItem::Lib(s[2..].to_string()));
            }
            "--fatal-warnings" => a.fatal_warnings = true,
            "--no-fatal-warnings" => a.fatal_warnings = false,
            // Accepted with GNU semantics for ET_REL output: these
            // keywords shape final images only and change nothing
            // about a relocatable link.
            "-z" => match next_of(&mut it, "-z") {
                Ok(kw) => {
                    match kw.as_str() {
                        "noexecstack" => a.gnu_stack = Some(false),
                        "execstack" => a.gnu_stack = Some(true),
                        _ => {}
                    }
                    if let Some(code) = check_z_keyword(&kw) {
                        return code;
                    }
                }
                Err(c) => return c,
            },
            "--build-id" => a.build_id = BuildId::Sha1,
            s if s.starts_with("--build-id=") => {
                a.build_id = match &s["--build-id=".len()..] {
                    "sha1" | "fast" | "tree" => BuildId::Sha1,
                    "none" => BuildId::None,
                    other => {
                        return ld_err(format!("unsupported --build-id style `{other}`"));
                    }
                };
            }
            "--emit-relocs" | "-q" => a.emit_relocs = true,
            "--no-undefined" => a.no_undefined = true,
            "-X" | "--discard-locals" => a.discard_locals = true,
            "-x" | "--discard-all" => a.discard_locals = true,
            "--discard-none" => a.discard_locals = false,
            "--strip-debug" | "-S" => a.strip_debug = true,
            "-EL" => {} // little-endian, the only byte order supported
            "-EB" => return ld_err("big-endian output is not supported"),
            "--no-warn-rwx-segments" | "--warn-rwx-segments" => {}
            "--as-needed" | "--no-as-needed" => {}
            "--gc-sections" | "--no-gc-sections" => {}
            s if s.starts_with("--orphan-handling=") => {
                let kind = &s["--orphan-handling=".len()..];
                if !matches!(kind, "place" | "warn" | "error" | "discard") {
                    return ld_err(format!("unknown --orphan-handling kind `{kind}`"));
                }
                a.orphan_handling = Some(kind.to_string());
            }
            "-v" | "--version" | "-V" => a.print_version = true,
            "--help" => {
                println!(
                    "usage: badc --ld [options] file...\n\
                     GNU-ld-compatible driver; see ld(1) for option semantics.\n\
                     Supported: -r, -o, -m EMU, -T SCRIPT, --whole-archive, \
                     --start-group, -L/-l, -z KEYWORD, --build-id[=sha1|none], \
                     --emit-relocs, --fatal-warnings, -X, --strip-debug, -EL, \
                     --orphan-handling=KIND, --no-undefined"
                );
                return 0;
            }
            s if s.starts_with('-') => {
                return ld_err(format!("unrecognized option `{s}`"));
            }
            path => a.inputs.push(InputItem::File(PathBuf::from(path))),
        }
    }
    if a.print_version {
        // The "GNU" token keeps ld-version probes in build systems
        // working; the feature surface is what run_ld implements.
        println!("badc ld (GNU compatible) {}", crate::BUILD_INFO);
        return 0;
    }

    let machine = match a.emulation.as_deref() {
        None => None,
        Some("elf_x86_64") => Some(EM_X86_64),
        Some("aarch64linux" | "aarch64elf") => Some(EM_AARCH64),
        Some(other) => return ld_err(format!("unsupported emulation `{other}`")),
    };

    if !a.relocatable {
        // TODO: dispatch final links to the script-driven layout
        // engine once it lands.
        return ld_err(
            "only relocatable links (-r) are supported in ld mode; \
             final links are handled by the badc driver",
        );
    }
    if a.emit_relocs {
        // GNU ld ignores --emit-relocs under -r (every relocation
        // survives a relocatable link anyway).
    }

    let mut script = match &a.script {
        None => None,
        Some(path) => {
            let text = match std::fs::read_to_string(path) {
                Ok(t) => t,
                Err(e) => return ld_err(format!("cannot read script `{}`: {e}", path.display())),
            };
            match parse_module_script(&text) {
                Ok(s) => Some(s),
                Err(e) => return ld_err(e),
            }
        }
    };

    let objs = match collect_inputs(&a, machine) {
        Ok(o) => o,
        Err(code) => return code,
    };
    if objs.is_empty() {
        return ld_err("no input files");
    }
    if let (Some(kind), Some(script)) = (a.orphan_handling.as_deref(), script.as_mut()) {
        match kind {
            "discard" => {
                // Orphans (sections no script rule names) drop: add
                // each orphan's literal name to the discard list.
                for name in orphan_names(script, &objs) {
                    script.discard.push(name);
                }
            }
            _ => {
                if let Some(code) = report_orphans(kind, script, &objs, a.fatal_warnings) {
                    return code;
                }
            }
        }
    }

    let opts = RelinkOptions {
        script,
        discard_locals: a.discard_locals,
        strip_debug: a.strip_debug,
        build_id_sha1: a.build_id == BuildId::Sha1,
        gnu_stack: a.gnu_stack,
        expect_machine: machine,
    };
    let bytes = match link_relocatable(&objs, &opts) {
        Ok(b) => b,
        Err(e) => return ld_err(e),
    };
    if let Err(e) = std::fs::write(&a.output, &bytes) {
        return ld_err(format!("cannot write `{}`: {e}", a.output.display()));
    }
    0
}

/// `-z` keywords ld accepts. Unknown ones are errors, matching GNU
/// ld's `-z <kw> ignored` warning turned strict.
fn check_z_keyword(kw: &str) -> Option<i32> {
    let known = matches!(
        kw,
        "noexecstack"
            | "execstack"
            | "relro"
            | "norelro"
            | "now"
            | "lazy"
            | "text"
            | "notext"
            | "defs"
            | "undefs"
            | "muldefs"
            | "pack-relative-relocs"
            | "nopack-relative-relocs"
            | "noseparate-code"
            | "separate-code"
    ) || kw.starts_with("max-page-size=")
        || kw.starts_with("common-page-size=");
    if known {
        None
    } else {
        Some(ld_err(format!("unsupported -z keyword `{kw}`")))
    }
}

/// Walk the positional inputs, expanding archives. `--whole-archive`
/// spans include every member; other archives contribute members that
/// resolve undefined references, rescanning to a fixpoint across a
/// `--start-group` span (a lone archive rescans itself the same way).
fn collect_inputs(a: &LdArgs, machine: Option<u16>) -> Result<Vec<EtRel>, i32> {
    struct PendingArchive {
        members: Vec<(String, Vec<u8>)>,
        taken: Vec<bool>,
    }
    let mut objs: Vec<EtRel> = Vec::new();
    let mut undef: HashSet<String> = HashSet::new();
    let mut defined: HashSet<String> = HashSet::new();
    let mut whole = false;
    let mut group: Option<Vec<PendingArchive>> = None;
    let note = |objs: &mut Vec<EtRel>,
                undef: &mut HashSet<String>,
                defined: &mut HashSet<String>,
                o: EtRel| {
        for d in o.defined_globals() {
            defined.insert(d.to_string());
            undef.remove(d);
        }
        for u in o.strong_undefs() {
            if !defined.contains(u) {
                undef.insert(u.to_string());
            }
        }
        objs.push(o);
    };
    let resolve_span = |objs: &mut Vec<EtRel>,
                        undef: &mut HashSet<String>,
                        defined: &mut HashSet<String>,
                        span: &mut [PendingArchive]|
     -> Result<(), i32> {
        loop {
            let mut changed = false;
            for ar in span.iter_mut() {
                for (i, (name, bytes)) in ar.members.iter().enumerate() {
                    if ar.taken[i] {
                        continue;
                    }
                    let o = match parse_et_rel(bytes, name) {
                        Ok(o) => o,
                        Err(e) => return Err(ld_err(e)),
                    };
                    if o.defined_globals().any(|d| undef.contains(d)) {
                        ar.taken[i] = true;
                        note(objs, undef, defined, o);
                        changed = true;
                    }
                }
            }
            if !changed {
                return Ok(());
            }
        }
    };
    let load_archive = |path: &Path| -> Result<Vec<(String, Vec<u8>)>, i32> {
        let blob = std::fs::read(path)
            .map_err(|e| ld_err(format!("cannot read `{}`: {e}", path.display())))?;
        let members = archive::read_archive_at(&blob, path.parent())
            .map_err(|e| ld_err(format!("`{}`: {e}", path.display())))?;
        Ok(members.into_iter().map(|m| (m.name, m.bytes)).collect())
    };
    let find_lib = |name: &str| -> Result<PathBuf, i32> {
        for dir in &a.lib_paths {
            let p = dir.join(format!("lib{name}.a"));
            if p.is_file() {
                return Ok(p);
            }
        }
        Err(ld_err(format!("cannot find -l{name}")))
    };
    for item in &a.inputs {
        let path_owned;
        let path: &Path = match item {
            InputItem::WholeArchiveOn => {
                whole = true;
                continue;
            }
            InputItem::WholeArchiveOff => {
                whole = false;
                continue;
            }
            InputItem::GroupStart => {
                if group.is_some() {
                    return Err(ld_err("--start-group may not be nested"));
                }
                group = Some(Vec::new());
                continue;
            }
            InputItem::GroupEnd => {
                let Some(mut span) = group.take() else {
                    return Err(ld_err("--end-group without --start-group"));
                };
                resolve_span(&mut objs, &mut undef, &mut defined, &mut span)?;
                continue;
            }
            InputItem::Lib(name) => {
                path_owned = find_lib(name)?;
                &path_owned
            }
            InputItem::File(p) => p,
        };
        let head = std::fs::File::open(path)
            .and_then(|f| {
                use std::io::Read;
                let mut buf = [0u8; 8];
                let n = std::io::Read::take(f, 8).read(&mut buf)?;
                Ok(buf[..n].to_vec())
            })
            .map_err(|e| ld_err(format!("cannot read `{}`: {e}", path.display())))?;
        let is_archive = head.starts_with(b"!<arch>\n") || head.starts_with(b"!<thin>\n");
        if is_archive {
            let members = load_archive(path)?;
            if whole {
                for (name, bytes) in members {
                    let label = format!("{}({})", path.display(), name);
                    match parse_et_rel(&bytes, &label) {
                        Ok(o) => note(&mut objs, &mut undef, &mut defined, o),
                        Err(e) => return Err(ld_err(e)),
                    }
                }
            } else {
                let taken = alloc::vec![false; members.len()];
                let mut ar = PendingArchive { members, taken };
                match group.as_mut() {
                    Some(span) => span.push(ar),
                    None => {
                        resolve_span(
                            &mut objs,
                            &mut undef,
                            &mut defined,
                            core::slice::from_mut(&mut ar),
                        )?;
                    }
                }
            }
        } else {
            let bytes = std::fs::read(path)
                .map_err(|e| ld_err(format!("cannot read `{}`: {e}", path.display())))?;
            match parse_et_rel(&bytes, &path.display().to_string()) {
                Ok(o) => note(&mut objs, &mut undef, &mut defined, o),
                Err(e) => return Err(ld_err(e)),
            }
        }
    }
    if group.is_some() {
        return Err(ld_err("--start-group without --end-group"));
    }
    if let Some(m) = machine {
        for o in &objs {
            if o.machine != m {
                return Err(ld_err(format!(
                    "{}: machine {} is incompatible with the requested emulation",
                    o.source, o.machine
                )));
            }
        }
    }
    Ok(objs)
}

/// Sections no script rule names. `--orphan-handling` reporting and
/// `discard` both derive from this list.
/// TODO: move enforcement into the script-driven placement engine.
fn orphan_names(script: &LdScript, objs: &[EtRel]) -> Vec<String> {
    use super::relocatable::{SecStmt, glob_match};
    let mut orphans: Vec<String> = Vec::new();
    for o in objs {
        for s in &o.sections {
            let discarded = script.discard.iter().any(|p| glob_match(p, &s.name));
            let gathered = script.outsecs.iter().any(|r| {
                r.stmts.iter().any(|st| match st {
                    SecStmt::Gather(g) => g.patterns.iter().any(|p| glob_match(p, &s.name)),
                    _ => false,
                })
            });
            if !discarded && !gathered && !orphans.iter().any(|n| n == &s.name) {
                orphans.push(s.name.clone());
            }
        }
    }
    orphans
}

fn report_orphans(
    kind: &str,
    script: &LdScript,
    objs: &[EtRel],
    fatal_warnings: bool,
) -> Option<i32> {
    if kind == "place" {
        return None;
    }
    let orphans = orphan_names(script, objs);
    if orphans.is_empty() {
        return None;
    }
    match kind {
        "warn" => {
            for n in &orphans {
                eprintln!("badc-ld: warning: orphan section `{n}' placed by name");
            }
            fatal_warnings.then_some(1)
        }
        "error" => {
            for n in &orphans {
                eprintln!("badc-ld: error: orphan section `{n}'");
            }
            Some(1)
        }
        _ => None,
    }
}

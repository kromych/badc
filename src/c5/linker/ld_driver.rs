//! GNU-ld-compatible driver. Entered when badc is invoked as `ld`
//! (argv[0] basename `ld` / `ld.badc` / `*-ld`) or with a leading
//! `--ld`, so a build system can set `LD=badc` unchanged.
//!
//! Two link kinds share one option surface and one input resolver:
//! `-r` merges to ET_REL ([`super::relocatable`]), and a final link
//! runs the script-driven layout engine ([`super::lds_link`]) under
//! the script named by `-T`/`--script` or, absent one, the built-in
//! default ([`super::default_script`]).

#![cfg(feature = "std")]

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;
use hashbrown::HashSet;
use std::path::{Path, PathBuf};

use super::archive;
use super::default_script::default_script;
use super::dynamic::HashStyle;
use super::lds::parse_linker_script;
use super::lds_link::{
    LdsEmit, LdsObject, LdsOptions, OrphanHandling, SharedInput, parse_lds_object,
};
use super::object::parse_shared_library;
use super::relocatable::{
    DiscardLocals, EM_386, EM_AARCH64, EM_X86_64, EtRel, LdScript, RelinkOptions, link_relocatable,
    link_relocatable_with_map, parse_et_rel, parse_module_script,
};

/// How positional inputs and archive state were ordered on the
/// command line.
#[derive(Clone)]
enum InputItem {
    File(PathBuf),
    Lib(String),
    WholeArchiveOn,
    WholeArchiveOff,
    GroupStart,
    GroupEnd,
    /// `-Bstatic` / `-Bdynamic`: what `-l` may find from here on.
    SearchShared(bool),
    /// A linker script's `AS_NEEDED` span: a library inside one takes a
    /// dependency record only where the link binds to it.
    AsNeeded(bool),
}

#[derive(PartialEq, Eq, Clone, Copy)]
enum BuildId {
    None,
    Sha1,
}

/// Binutils compatibility level reported by `--version`. Raise it only
/// alongside the behaviour a consumer gates on that version.
///
/// 2.33.1 is where `arch/arm64/Kconfig` enables
/// `ARM64_PTR_AUTH_KERNEL`, which compiles the kernel with
/// `-mbranch-protection=pac-ret`. Both halves that gate names are in
/// place: the compiler emits the signing pair and the
/// `.note.gnu.property` PAC note, and the linker merges those notes.
const LD_COMPAT_VERSION: &str = "2.33.1";

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
    discard_locals: DiscardLocals,
    /// `--discard-none`: keep every local symbol.
    discard_none: bool,
    strip_debug: bool,
    orphan_handling: Option<String>,
    /// `-z noexecstack` / `-z execstack`.
    gnu_stack: Option<bool>,
    print_version: bool,
    // Final-link options; ignored under `-r`, which has no layout.
    /// `-shared` / `-pie`: ET_DYN output.
    shared: bool,
    /// `-shared` alone: a shared object rather than a
    /// position-independent executable.
    shared_object: bool,
    entry: Option<String>,
    map_path: Option<PathBuf>,
    print_map: bool,
    max_page_size: Option<u64>,
    pack_relative_relocs: bool,
    apply_dynamic_relocs: bool,
    /// `-u SYM`: symbols forced undefined before the archive scan.
    undefined: Vec<String>,
    /// `--gc-sections`: drop input sections no kept section reaches.
    gc_sections: bool,
    /// `-soname NAME`: recorded as `DT_SONAME`.
    soname: Option<String>,
    /// `--hash-style`.
    hash_style: HashStyle,
    /// `-Bsymbolic`.
    symbolic: bool,
    /// `-n` / `--nmagic`: no page alignment between segments.
    nmagic: bool,
    /// `--eh-frame-hdr`.
    eh_frame_hdr: bool,
    /// `--dynamic-linker PATH`: the `PT_INTERP` program interpreter.
    interp: Option<String>,
    /// `-rpath` / `-R` directories, in command order.
    rpath: Vec<String>,
    /// `DT_RUNPATH` rather than `DT_RPATH`, which is what the
    /// reference `ld` is configured to emit; `--disable-new-dtags`
    /// selects the older tag.
    new_dtags: bool,
    /// `-Bstatic` / `-Bdynamic`: whether `-l` may resolve to a shared
    /// library. GNU ld starts dynamic and `-static` turns it off.
    search_shared: bool,
    /// `--fix-cortex-a53-843419`: erratum workaround on final links.
    fix_cortex_a53_843419: bool,
}

fn ld_err(msg: impl core::fmt::Display) -> i32 {
    let text = alloc::string::ToString::to_string(&msg);
    eprintln!(
        "badc-ld: error: {}",
        text.strip_prefix("error: ").unwrap_or(&text)
    );
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

/// Split a response file's contents the way libiberty's `buildargv`
/// does: whitespace separates arguments, single and double quotes group
/// them, and a backslash escapes the next character.
fn split_response(text: &str) -> Vec<String> {
    split_response_on(text, cfg!(windows))
}

/// `split_response` with the host rule stated, so both behaviours are
/// testable from either host. With `path_sep_backslash`, a backslash is
/// a path separator -- `C:\dir\file.o` is what the native toolchains
/// write into a response file -- and escapes only a double quote, as
/// `CommandLineToArgvW` reads it. Otherwise it escapes unconditionally.
fn split_response_on(text: &str, path_sep_backslash: bool) -> Vec<String> {
    let mut out: Vec<String> = Vec::new();
    let mut cur = String::new();
    let (mut started, mut squote, mut dquote, mut escape) = (false, false, false, false);
    let mut it = text.chars().peekable();
    while let Some(c) = it.next() {
        if !started && !squote && !dquote && !escape && c.is_whitespace() {
            continue;
        }
        started = true;
        let escapes_next = c == '\\' && (!path_sep_backslash || it.peek() == Some(&'"'));
        if escape {
            cur.push(c);
            escape = false;
        } else if escapes_next {
            escape = true;
        } else if squote {
            squote = c != '\'';
            if squote {
                cur.push(c);
            }
        } else if dquote {
            dquote = c != '"';
            if dquote {
                cur.push(c);
            }
        } else if c == '\'' {
            squote = true;
        } else if c == '"' {
            dquote = true;
        } else if c.is_whitespace() {
            out.push(core::mem::take(&mut cur));
            started = false;
        } else {
            cur.push(c);
        }
    }
    if started {
        out.push(cur);
    }
    out
}

/// Replace each `@file` with the arguments the file holds, recursively.
/// GNU ld leaves a `@file` it cannot read literal, so an input whose
/// name starts with `@` still reaches the link. `seen` breaks a cycle
/// between files that name each other.
fn expand_response_files(args: &[String]) -> Vec<String> {
    fn walk(args: &[String], out: &mut Vec<String>, seen: &mut Vec<PathBuf>) {
        for a in args {
            let Some(name) = a.strip_prefix('@') else {
                out.push(a.clone());
                continue;
            };
            let path = PathBuf::from(name);
            let text = (!seen.contains(&path))
                .then(|| std::fs::read_to_string(&path).ok())
                .flatten();
            match text {
                Some(text) => {
                    seen.push(path);
                    walk(&split_response(&text), out, seen);
                    seen.pop();
                }
                None => out.push(a.clone()),
            }
        }
    }
    let mut out = Vec::with_capacity(args.len());
    walk(args, &mut out, &mut Vec::new());
    out
}

/// Run the ld driver over `args` (program name and any `--ld` marker
/// already stripped). Returns the process exit code.
pub fn run_ld(args: &[String]) -> i32 {
    let a = match LdArgs::parse(&expand_response_files(args)) {
        Ok(a) => a,
        Err(code) => return code,
    };
    if a.print_version {
        print_ld_version();
        return 0;
    }
    let machine = match a.emulation.as_deref() {
        None => None,
        Some("elf_x86_64") => Some(EM_X86_64),
        Some("elf_i386") => Some(EM_386),
        Some("aarch64linux" | "aarch64elf") => Some(EM_AARCH64),
        Some(other) => return ld_err(format!("unsupported emulation `{other}`")),
    };
    if a.relocatable {
        run_relocatable_link(&a, machine)
    } else {
        run_final_link(&a, machine)
    }
}

/// GNU ld's identification shape with badc named as the package:
/// build systems parse the first and last fields and show the middle,
/// so this reports what runs without claiming to be binutils. Feature
/// questions are answered by rejecting options `run_ld` does not
/// implement, not by the version. The provenance tail is absent when
/// badc was built outside a checkout, so it is appended rather than
/// printed as its own line: an empty tail must not leave a blank one.
fn print_ld_version() {
    let git_tail = crate::BUILD_INFO
        .split_once('\n')
        .map(|(_, tail)| tail)
        .unwrap_or("");
    println!(
        "GNU ld (badc {}) {LD_COMPAT_VERSION}",
        env!("CARGO_PKG_VERSION")
    );
    if !git_tail.is_empty() {
        println!("{git_tail}");
    }
}

impl LdArgs {
    /// The command line as GNU ld reads it. `Err` carries the exit
    /// code: 1 for a rejected option, 0 after `--help`.
    fn parse(args: &[String]) -> Result<LdArgs, i32> {
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
            discard_locals: DiscardLocals::None,
            discard_none: false,
            strip_debug: false,
            orphan_handling: None,
            gnu_stack: None,
            print_version: false,
            shared: false,
            shared_object: false,
            entry: None,
            map_path: None,
            print_map: false,
            max_page_size: None,
            pack_relative_relocs: false,
            apply_dynamic_relocs: true,
            undefined: Vec::new(),
            gc_sections: false,
            soname: None,
            hash_style: HashStyle::default(),
            symbolic: false,
            nmagic: false,
            eh_frame_hdr: false,
            interp: None,
            rpath: Vec::new(),
            new_dtags: true,
            search_shared: true,
            fix_cortex_a53_843419: false,
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
                "-o" => a.output = PathBuf::from(next_of(&mut it, "-o")?),
                "-m" => a.emulation = Some(next_of(&mut it, "-m")?),
                s if s.starts_with("-m") && s.len() > 2 => {
                    a.emulation = Some(s[2..].to_string());
                }
                "-T" | "--script" => a.script = Some(PathBuf::from(next_of(&mut it, "-T")?)),
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
                "-L" => a.lib_paths.push(PathBuf::from(next_of(&mut it, "-L")?)),
                s if s.starts_with("-L") && s.len() > 2 => {
                    a.lib_paths.push(PathBuf::from(&s[2..]));
                }
                "-l" => a.inputs.push(InputItem::Lib(next_of(&mut it, "-l")?)),
                s if s.starts_with("-l") && s.len() > 2 => {
                    a.inputs.push(InputItem::Lib(s[2..].to_string()));
                }
                "--fatal-warnings" => a.fatal_warnings = true,
                "--no-fatal-warnings" => a.fatal_warnings = false,
                "-shared" => {
                    a.shared = true;
                    a.shared_object = true;
                }
                "-pie" | "--pic-executable" => a.shared = true,
                "-e" | "--entry" => a.entry = Some(next_of(&mut it, "-e")?),
                s if s.starts_with("--entry=") => a.entry = Some(s["--entry=".len()..].to_string()),
                "-u" | "--undefined" => a.undefined.push(next_of(&mut it, "-u")?),
                s if s.starts_with("--undefined=") => {
                    a.undefined.push(s["--undefined=".len()..].to_string());
                }
                s if s.starts_with("-u") && s.len() > 2 => a.undefined.push(s[2..].to_string()),
                "-M" | "--print-map" => a.print_map = true,
                "-Map" => a.map_path = Some(PathBuf::from(next_of(&mut it, "-Map")?)),
                s if s.starts_with("-Map=") => {
                    a.map_path = Some(PathBuf::from(&s["-Map=".len()..]))
                }
                "--pack-dyn-relocs=relr" => a.pack_relative_relocs = true,
                "--pack-dyn-relocs=none" => a.pack_relative_relocs = false,
                "--apply-dynamic-relocs" => a.apply_dynamic_relocs = true,
                "--no-apply-dynamic-relocs" => a.apply_dynamic_relocs = false,
                // Accepted with no effect on the emitted image: badc emits
                // no interpreter, no ld-generated unwind tables, and
                // resolves every branch in range without veneers.
                "--no-dynamic-linker" | "--pic-veneer" | "--no-ld-generated-unwind-info" => {}
                "--eh-frame-hdr" => a.eh_frame_hdr = true,
                "--no-eh-frame-hdr" => a.eh_frame_hdr = false,
                // `-n`: a segment aligns to its sections, not to a page.
                "-n" | "--nmagic" => a.nmagic = true,
                "-Bsymbolic" | "-Bsymbolic-functions" => a.symbolic = true,
                "-soname" | "-h" => a.soname = Some(next_of(&mut it, arg)?),
                s if s.starts_with("-soname=") || s.starts_with("--soname=") => {
                    a.soname = Some(s.split_once('=').map(|(_, v)| v).unwrap_or("").to_string());
                }
                "--hash-style" => {
                    let v = next_of(&mut it, arg)?;
                    a.hash_style = HashStyle::parse(&v)
                        .ok_or_else(|| ld_err(format!("unknown hash style `{v}`")))?;
                }
                s if s.starts_with("--hash-style=") => {
                    let v = &s["--hash-style=".len()..];
                    a.hash_style = HashStyle::parse(v)
                        .ok_or_else(|| ld_err(format!("unknown hash style `{v}`")))?;
                }
                "--dynamic-linker" | "-dynamic-linker" | "-I" => {
                    a.interp = Some(next_of(&mut it, arg)?);
                }
                s if s.starts_with("--dynamic-linker=") => {
                    a.interp = Some(s["--dynamic-linker=".len()..].to_string());
                }
                "-rpath" | "-R" | "--rpath" => a.rpath.push(next_of(&mut it, arg)?),
                s if s.starts_with("-rpath=") || s.starts_with("--rpath=") => {
                    a.rpath
                        .push(s.split_once('=').map(|(_, v)| v).unwrap_or("").to_string());
                }
                // `-rpath-link` steers the link-time search for a shared
                // library's own dependencies, which badc does not follow.
                "-rpath-link" | "--rpath-link" => {
                    let _ = next_of(&mut it, arg);
                }
                s if s.starts_with("-rpath-link=") || s.starts_with("--rpath-link=") => {}
                "--enable-new-dtags" => a.new_dtags = true,
                "--disable-new-dtags" => a.new_dtags = false,
                "-Bstatic" | "-dn" | "-non_shared" | "-static" => {
                    a.inputs.push(InputItem::SearchShared(false));
                    a.search_shared = false;
                }
                "-Bdynamic" | "-dy" | "-call_shared" => {
                    a.inputs.push(InputItem::SearchShared(true));
                    a.search_shared = true;
                }
                // The LTO plugin has nothing to load: badc reads no IR.
                "-plugin" => {
                    let _ = next_of(&mut it, arg);
                }
                s if s.starts_with("-plugin-opt") => {}
                "--fix-cortex-a53-843419" => a.fix_cortex_a53_843419 = true,
                "-z" => {
                    let kw = next_of(&mut it, "-z")?;
                    if let Some(code) = a.apply_z_keyword(&kw) {
                        return Err(code);
                    }
                }
                "--build-id" => a.build_id = BuildId::Sha1,
                s if s.starts_with("--build-id=") => {
                    a.build_id = match &s["--build-id=".len()..] {
                        "sha1" | "fast" | "tree" => BuildId::Sha1,
                        "none" => BuildId::None,
                        other => {
                            return Err(ld_err(format!("unsupported --build-id style `{other}`")));
                        }
                    };
                }
                "--emit-relocs" | "-q" => a.emit_relocs = true,
                "--no-undefined" => a.no_undefined = true,
                "-X" | "--discard-locals" => {
                    a.discard_locals = DiscardLocals::Temporaries;
                    a.discard_none = false;
                }
                "-x" | "--discard-all" => {
                    a.discard_locals = DiscardLocals::All;
                    a.discard_none = false;
                }
                "--discard-none" => {
                    a.discard_locals = DiscardLocals::None;
                    a.discard_none = true;
                }
                "--strip-debug" | "-S" => a.strip_debug = true,
                "-EL" => {} // little-endian, the only byte order supported
                "-EB" => return Err(ld_err("big-endian output is not supported")),
                "--no-warn-rwx-segments" | "--warn-rwx-segments" => {}
                // badc records a DT_NEEDED for every shared library named
                // on the command line, so neither keyword changes the tags.
                "--as-needed" | "--no-as-needed" | "--add-needed" | "--no-add-needed" => {}
                "--gc-sections" => a.gc_sections = true,
                "--no-gc-sections" => a.gc_sections = false,
                s if s.starts_with("--orphan-handling=") => {
                    let kind = &s["--orphan-handling=".len()..];
                    if !matches!(kind, "place" | "warn" | "error" | "discard") {
                        return Err(ld_err(format!("unknown --orphan-handling kind `{kind}`")));
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
                         --orphan-handling=KIND, --no-undefined, --gc-sections"
                    );
                    return Err(0);
                }
                s if s.starts_with('-') => {
                    return Err(ld_err(format!("unrecognized option `{s}`")));
                }
                path => a.inputs.push(InputItem::File(PathBuf::from(path))),
            }
        }
        Ok(a)
    }

    /// One `-z` keyword, with GNU semantics for ET_REL output: these
    /// keywords shape final images only and change nothing about a
    /// relocatable link. Returns the exit code of a rejected one.
    fn apply_z_keyword(&mut self, kw: &str) -> Option<i32> {
        match kw {
            "noexecstack" => self.gnu_stack = Some(false),
            "execstack" => self.gnu_stack = Some(true),
            "pack-relative-relocs" => self.pack_relative_relocs = true,
            "nopack-relative-relocs" => self.pack_relative_relocs = false,
            s if s.starts_with("max-page-size=") => {
                match parse_page_size(&s["max-page-size=".len()..]) {
                    Some(n) => self.max_page_size = Some(n),
                    None => {
                        return Some(ld_err("-z max-page-size requires a power of two"));
                    }
                }
            }
            _ => {}
        }
        check_z_keyword(kw)
    }
}

/// `-r`: a relocatable link. GNU ld ignores --emit-relocs under -r,
/// since every relocation survives a relocatable link anyway.
fn run_relocatable_link(a: &LdArgs, machine: Option<u16>) -> i32 {
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

    let objs: Vec<EtRel> = match collect_inputs(a, machine) {
        // A relocatable link records no dependency, so a shared library
        // named on its command line contributes nothing.
        Ok((o, _)) => o,
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
    // ld writes a map for a relocatable link too, and kbuild's
    // `modules.builtin.ranges` step reads `vmlinux.o.map`.
    let want_map = a.map_path.is_some() || a.print_map;
    let (bytes, map) = if want_map {
        match link_relocatable_with_map(&objs, &opts, &a.output.display().to_string()) {
            Ok(v) => v,
            Err(e) => return ld_err(e),
        }
    } else {
        match link_relocatable(&objs, &opts) {
            Ok(b) => (b, String::new()),
            Err(e) => return ld_err(e),
        }
    };
    if let Err(e) = std::fs::write(&a.output, &bytes) {
        return ld_err(format!("cannot write `{}`: {e}", a.output.display()));
    }
    if let Some(p) = &a.map_path
        && let Err(e) = std::fs::write(p, &map)
    {
        return ld_err(format!("cannot write map file `{}`: {e}", p.display()));
    }
    if a.print_map {
        print!("{map}");
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
            // Dynamic-loader policy recorded in DT_FLAGS_1. The kernel
            // passes them on links that produce no dynamic segment, so
            // there is nothing to record and nothing to warn about.
            | "nodefaultlib"
            | "nodelete"
            | "nodlopen"
            | "nodump"
            | "origin"
            | "global"
            | "initfirst"
            | "interpose"
            | "loadfltr"
    ) || kw.starts_with("max-page-size=")
        || kw.starts_with("common-page-size=");
    if known {
        None
    } else {
        Some(ld_err(format!("unsupported -z keyword `{kw}`")))
    }
}

/// What the input resolver needs from a parsed object. Archive member
/// selection is the same walk for both link kinds, so the two object
/// representations differ only in these four operations.
trait InputObject: Sized {
    fn parse(source: &str, bytes: Vec<u8>) -> Result<Self, String>;
    fn machine(&self) -> u16;
    fn source(&self) -> &str;
    /// Global (or weak) names this object defines.
    fn defined(&self) -> Vec<&str>;
    /// Names it references strongly; weak references never pull a
    /// member.
    fn strong_undef(&self) -> Vec<&str>;
}

impl InputObject for EtRel {
    fn parse(source: &str, bytes: Vec<u8>) -> Result<Self, String> {
        parse_et_rel(&bytes, source).map_err(|e| format!("{e}"))
    }
    fn machine(&self) -> u16 {
        self.machine
    }
    fn source(&self) -> &str {
        &self.source
    }
    fn defined(&self) -> Vec<&str> {
        EtRel::defined_globals(self).collect()
    }
    fn strong_undef(&self) -> Vec<&str> {
        EtRel::strong_undefs(self).collect()
    }
}

impl InputObject for LdsObject {
    fn parse(source: &str, bytes: Vec<u8>) -> Result<Self, String> {
        parse_lds_object(source, bytes).map_err(|e| format!("{e}"))
    }
    fn machine(&self) -> u16 {
        self.machine
    }
    fn source(&self) -> &str {
        &self.source
    }
    fn defined(&self) -> Vec<&str> {
        self.symbols
            .iter()
            .filter(|s| (s.info >> 4) != 0 && s.shndx != 0 && !s.name.is_empty())
            .map(|s| s.name.as_str())
            .collect()
    }
    fn strong_undef(&self) -> Vec<&str> {
        self.symbols
            .iter()
            .filter(|s| (s.info >> 4) == 1 && s.shndx == 0 && !s.name.is_empty())
            .map(|s| s.name.as_str())
            .collect()
    }
}

/// Walk the positional inputs, expanding archives. `--whole-archive`
/// spans include every member; other archives contribute members that
/// resolve undefined references, rescanning to a fixpoint across a
/// `--start-group` span (a lone archive rescans itself the same way).
fn collect_inputs<T: InputObject>(
    a: &LdArgs,
    machine: Option<u16>,
) -> Result<(Vec<T>, Vec<SharedInput>), i32> {
    struct PendingArchive {
        members: Vec<(String, Vec<u8>)>,
        taken: Vec<bool>,
    }
    let mut objs: Vec<T> = Vec::new();
    let mut libs: Vec<SharedInput> = Vec::new();
    let mut search_shared = true;
    let mut as_needed = false;
    // `-u SYM` forces a reference before any input is read, so a
    // member defining it is pulled even though nothing else names it.
    let mut undef: HashSet<String> = a.undefined.iter().cloned().collect();
    let mut defined: HashSet<String> = HashSet::new();
    let mut whole = false;
    let mut group: Option<Vec<PendingArchive>> = None;
    let note =
        |objs: &mut Vec<T>, undef: &mut HashSet<String>, defined: &mut HashSet<String>, o: T| {
            for d in o.defined() {
                defined.insert(d.to_string());
                undef.remove(d);
            }
            for u in o.strong_undef() {
                if !defined.contains(u) {
                    undef.insert(u.to_string());
                }
            }
            objs.push(o);
        };
    let resolve_span = |objs: &mut Vec<T>,
                        undef: &mut HashSet<String>,
                        defined: &mut HashSet<String>,
                        span: &mut [PendingArchive]|
     -> Result<(), i32> {
        loop {
            let mut changed = false;
            for ar in span.iter_mut() {
                for i in 0..ar.members.len() {
                    if ar.taken[i] {
                        continue;
                    }
                    let (name, bytes) = &ar.members[i];
                    let o = match T::parse(name, bytes.clone()) {
                        Ok(o) => o,
                        Err(e) => return Err(ld_err(e)),
                    };
                    if o.defined().iter().any(|d| undef.contains(*d)) {
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
    // GNU ld takes the first directory holding either spelling, and
    // prefers the shared one there unless the search is static.
    let find_lib = |name: &str, shared: bool| -> Result<PathBuf, i32> {
        for dir in &a.lib_paths {
            let so = dir.join(format!("lib{name}.so"));
            if shared && so.is_file() {
                return Ok(so);
            }
            let ar = dir.join(format!("lib{name}.a"));
            if ar.is_file() {
                return Ok(ar);
            }
        }
        Err(ld_err(format!("cannot find -l{name}")))
    };
    let mut queue: Vec<InputItem> = a.inputs.clone();
    queue.reverse();
    while let Some(item) = queue.pop() {
        let path_owned;
        let path: &Path = match &item {
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
            InputItem::SearchShared(on) => {
                search_shared = *on;
                continue;
            }
            InputItem::AsNeeded(on) => {
                as_needed = *on;
                continue;
            }
            InputItem::Lib(name) => {
                path_owned = find_lib(name, search_shared)?;
                &path_owned
            }
            // A name a linker script gave without a directory is
            // searched the way `-l` is.
            InputItem::File(p) if !p.is_file() && p.is_relative() => {
                path_owned = a
                    .lib_paths
                    .iter()
                    .map(|d| d.join(p))
                    .find(|c| c.is_file())
                    .unwrap_or_else(|| p.clone());
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
                    match T::parse(&label, bytes) {
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
            if is_shared_object(&bytes) {
                let mut lib = parse_shared_library(&bytes)
                    .map_err(|e| ld_err(format!("`{}`: {e}", path.display())))?;
                if lib.soname.is_empty() {
                    lib.soname = path
                        .file_name()
                        .map(|n| n.to_string_lossy().into_owned())
                        .unwrap_or_default();
                }
                libs.push(SharedInput { lib, as_needed });
                continue;
            }
            // A non-ELF input is a linker script naming further ones,
            // which is how a system libc reaches its parts.
            if !bytes.starts_with(b"\x7fELF") {
                let text = String::from_utf8_lossy(&bytes);
                let items = ld_script_inputs(&text);
                if items.is_empty() {
                    return Err(ld_err(format!(
                        "`{}`: neither an object nor a linker script naming inputs",
                        path.display()
                    )));
                }
                queue.extend(items.into_iter().rev());
                continue;
            }
            match T::parse(&path.display().to_string(), bytes) {
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
            if o.machine() != m {
                return Err(ld_err(format!(
                    "{}: machine {} is incompatible with the requested emulation",
                    o.source(),
                    o.machine()
                )));
            }
        }
    }
    Ok((objs, libs))
}

/// Script words: parentheses stand alone, everything else runs to the
/// next separator.
fn tokenize_script(text: &str) -> Vec<&str> {
    let mut out: Vec<&str> = Vec::new();
    let mut start: Option<usize> = None;
    for (i, c) in text.char_indices() {
        if !(c.is_whitespace() || c == ',' || c == ';' || c == '(' || c == ')') {
            start.get_or_insert(i);
            continue;
        }
        if let Some(s) = start.take() {
            out.push(&text[s..i]);
        }
        if c == '(' || c == ')' {
            out.push(&text[i..i + 1]);
        }
    }
    if let Some(s) = start {
        out.push(&text[s..]);
    }
    out
}

/// Inputs an `INPUT` / `GROUP` command names, in order. A `GROUP` is
/// bracketed by the group markers, which is what its archive-rescan
/// semantics amount to, and an `AS_NEEDED` span by the markers that
/// hold its dependency records back. Any other command is not an input
/// list and contributes nothing.
fn ld_script_inputs(text: &str) -> Vec<InputItem> {
    let text = strip_comments(text);
    let mut out: Vec<InputItem> = Vec::new();
    let mut depth = 0usize;
    // Nesting depths that are input lists, and the ones a `GROUP` and
    // an `AS_NEEDED` opened.
    let mut listing: Vec<usize> = Vec::new();
    let (mut group_at, mut as_needed_at) = (None, None);
    let mut pending: Option<&str> = None;
    for t in tokenize_script(&text) {
        match t {
            "(" => {
                depth += 1;
                match pending.take() {
                    Some("INPUT") => listing.push(depth),
                    Some("GROUP") => {
                        listing.push(depth);
                        group_at = Some(depth);
                        out.push(InputItem::GroupStart);
                    }
                    Some("AS_NEEDED") if !listing.is_empty() => {
                        listing.push(depth);
                        as_needed_at = Some(depth);
                        out.push(InputItem::AsNeeded(true));
                    }
                    _ => {}
                }
            }
            ")" => {
                if as_needed_at == Some(depth) {
                    out.push(InputItem::AsNeeded(false));
                    as_needed_at = None;
                }
                if group_at == Some(depth) {
                    out.push(InputItem::GroupEnd);
                    group_at = None;
                }
                if listing.last() == Some(&depth) {
                    listing.pop();
                }
                depth = depth.saturating_sub(1);
            }
            "INPUT" | "GROUP" | "AS_NEEDED" => pending = Some(t),
            _ if listing.contains(&depth) => match t.strip_prefix("-l") {
                Some(name) => out.push(InputItem::Lib(name.to_string())),
                None => out.push(InputItem::File(PathBuf::from(t))),
            },
            _ => {}
        }
    }
    out
}

fn strip_comments(text: &str) -> String {
    let mut out = String::with_capacity(text.len());
    let mut rest = text;
    while let Some(k) = rest.find("/*") {
        out.push_str(&rest[..k]);
        match rest[k..].find("*/") {
            Some(e) => rest = &rest[k + e + 2..],
            None => return out,
        }
    }
    out.push_str(rest);
    out
}

/// True when the bytes are an ELF shared object.
fn is_shared_object(bytes: &[u8]) -> bool {
    const ET_DYN: u16 = 3;
    bytes.len() >= 18
        && bytes.starts_with(b"\x7fELF")
        && u16::from_le_bytes([bytes[16], bytes[17]]) == ET_DYN
}

/// `-z max-page-size=` / GNU ld's size syntax: decimal or `0x` hex,
/// power of two.
fn parse_page_size(body: &str) -> Option<u64> {
    let n = match body.strip_prefix("0x").or_else(|| body.strip_prefix("0X")) {
        Some(hex) => u64::from_str_radix(hex, 16).ok()?,
        None => body.parse::<u64>().ok()?,
    };
    n.is_power_of_two().then_some(n)
}

/// Final (non-`-r`) link: lay the inputs out under the script and
/// write the image. With no `-T`/`--script` the built-in default
/// script runs, as GNU ld's does.
fn run_final_link(a: &LdArgs, machine: Option<u16>) -> i32 {
    let text = match &a.script {
        Some(spath) => match std::fs::read_to_string(spath) {
            Ok(t) => t,
            Err(e) => return ld_err(format!("cannot read script `{}`: {e}", spath.display())),
        },
        None => default_script(a.shared),
    };
    let script = match parse_linker_script(&text) {
        Ok(s) => s,
        Err(e) => return ld_err(format!("{e}")),
    };
    let (objs, libs): (Vec<LdsObject>, Vec<SharedInput>) = match collect_inputs(a, machine) {
        Ok(o) => o,
        Err(code) => return code,
    };
    if objs.is_empty() {
        return ld_err("no input files");
    }
    let m = machine.unwrap_or(objs[0].machine);
    let opts = LdsOptions {
        emit: if a.shared {
            LdsEmit::Dyn
        } else {
            LdsEmit::Exec
        },
        shared: a.shared_object,
        entry_override: a.entry.clone(),
        gc_sections: a.gc_sections,
        undefined: a.undefined.clone(),
        // GNU ld defaults: 2 MiB on x86-64, 64 KiB on aarch64, 4 KiB
        // on i386.
        max_page_size: a.max_page_size.unwrap_or(match m {
            EM_AARCH64 => 0x10000,
            EM_386 => 0x1000,
            _ => 0x200000,
        }),
        orphan_handling: match a.orphan_handling.as_deref() {
            Some("warn") => OrphanHandling::Warn,
            Some("error") => OrphanHandling::Error,
            Some("discard") => OrphanHandling::Discard,
            _ => OrphanHandling::Place,
        },
        build_id_sha1: a.build_id == BuildId::Sha1,
        strip_debug: a.strip_debug,
        discard_locals: a.discard_locals != DiscardLocals::None,
        discard_none: a.discard_none,
        pack_relative_relocs: a.pack_relative_relocs,
        apply_dynamic_relocs: a.apply_dynamic_relocs,
        emit_relocs: a.emit_relocs,
        emit_warnings: true,
        soname: a.soname.clone(),
        output_name: a
            .output
            .file_name()
            .and_then(|s| s.to_str())
            .unwrap_or_default()
            .to_string(),
        hash_style: a.hash_style,
        symbolic: a.symbolic,
        nmagic: a.nmagic,
        eh_frame_hdr: a.eh_frame_hdr,
        interp: a.interp.clone(),
        shared_libs: libs,
        rpath: a.rpath.clone(),
        new_dtags: a.new_dtags,
        fix_cortex_a53_843419: a.fix_cortex_a53_843419,
    };
    let res = match super::lds_link::link_with_script(&script, objs, &opts) {
        Ok(r) => r,
        Err(e) => return ld_err(format!("{e}")),
    };
    for w in &res.warnings {
        eprintln!(
            "badc-ld: warning: {}",
            w.strip_prefix("warning: ").unwrap_or(w)
        );
    }
    if a.fatal_warnings && !res.warnings.is_empty() {
        return ld_err(format!(
            "{} warning(s) treated as errors (--fatal-warnings)",
            res.warnings.len()
        ));
    }
    if let Err(e) = std::fs::write(&a.output, &res.image) {
        return ld_err(format!("cannot write `{}`: {e}", a.output.display()));
    }
    set_executable(&a.output);
    if let Some(p) = &a.map_path
        && let Err(e) = std::fs::write(p, &res.map)
    {
        return ld_err(format!("cannot write map file `{}`: {e}", p.display()));
    }
    if a.print_map {
        print!("{}", res.map);
    }
    0
}

#[cfg(unix)]
fn set_executable(path: &Path) {
    use std::os::unix::fs::PermissionsExt;
    if let Ok(md) = std::fs::metadata(path) {
        let mut perms = md.permissions();
        perms.set_mode(perms.mode() | 0o111);
        let _ = std::fs::set_permissions(path, perms);
    }
}

#[cfg(not(unix))]
fn set_executable(_path: &Path) {}

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

#[cfg(test)]
mod tests {
    /// The kernel links its kexec purgatory with dynamic-loader policy
    /// keywords that a relocatable link cannot act on. Accepting them is
    /// not the same as accepting anything: a keyword ld does not define
    /// still has to be refused.
    #[test]
    fn loader_policy_z_keywords_are_accepted_and_unknown_ones_are_not() {
        for kw in [
            "nodefaultlib",
            "nodelete",
            "nodlopen",
            "nodump",
            "origin",
            "global",
            "initfirst",
            "interpose",
            "loadfltr",
        ] {
            assert!(check_z_keyword(kw).is_none(), "{kw} must link");
        }
        for kw in ["noexecstack", "relro", "now", "max-page-size=4096"] {
            assert!(check_z_keyword(kw).is_none(), "{kw} regressed");
        }
        for kw in ["bogus-keyword", "nodefaultlibs", ""] {
            assert!(check_z_keyword(kw).is_some(), "{kw} must be refused");
        }
    }

    use super::*;
    use alloc::vec;

    /// A system `libc.so` is a script naming the parts of the library,
    /// with the loader itself only where something needs it.
    #[test]
    fn a_linker_script_input_names_a_group_and_its_as_needed_span() {
        let items = ld_script_inputs(
            "/* GNU ld script */\nOUTPUT_FORMAT(elf64-x86-64)\n\
             GROUP ( /lib64/libc.so.6 /usr/lib64/libc_nonshared.a \
             AS_NEEDED ( /lib64/ld-linux-x86-64.so.2 -lgcc_s ) )",
        );
        let shape: Vec<String> = items
            .iter()
            .map(|i| match i {
                InputItem::GroupStart => String::from("{"),
                InputItem::GroupEnd => String::from("}"),
                InputItem::AsNeeded(on) => alloc::format!("as-needed={on}"),
                InputItem::File(p) => p.display().to_string(),
                InputItem::Lib(n) => alloc::format!("-l{n}"),
                _ => String::from("?"),
            })
            .collect();
        assert_eq!(
            shape,
            vec![
                "{",
                "/lib64/libc.so.6",
                "/usr/lib64/libc_nonshared.a",
                "as-needed=true",
                "/lib64/ld-linux-x86-64.so.2",
                "-lgcc_s",
                "as-needed=false",
                "}",
            ]
        );
        assert!(
            ld_script_inputs("OUTPUT_FORMAT(elf64-x86-64)").is_empty(),
            "a script naming no inputs contributes none"
        );
    }

    /// `scripts/ld-version.sh`: `10000*major + 100*minor + patch`, with a
    /// missing field zero and anything past the third ignored.
    fn ld_canonical_version(v: &str) -> u32 {
        let mut it = v.split('.');
        let f = |x: Option<&str>| x.and_then(|s| s.parse::<u32>().ok()).unwrap_or(0);
        10_000 * f(it.next()) + 100 * f(it.next()) + f(it.next())
    }

    #[test]
    fn reported_version_covers_the_ptr_auth_kernel_gate() {
        // `arch/arm64/Kconfig` enables `ARM64_PTR_AUTH_KERNEL` at
        // `LD_VERSION >= 23301`, and compiles the kernel with
        // `-mbranch-protection=pac-ret` on the strength of it. Both the
        // signing pair and the property note it names are emitted, so
        // the claim is honest; dropping either has to drop this too.
        assert!(ld_canonical_version(LD_COMPAT_VERSION) >= 23301);
        assert_eq!(ld_canonical_version("2.33.1"), 23301);
        assert_eq!(ld_canonical_version("2.30"), 23000);
    }

    #[test]
    fn response_file_splitting_follows_buildargv() {
        // buildargv's own rule, named rather than taken from the host:
        // the escape case below reads differently where a backslash is a
        // path separator, and that is covered by the test after this one.
        let split = |t: &str| split_response_on(t, false);
        assert_eq!(split("a.o\nb.o\n"), vec!["a.o", "b.o"]);
        assert_eq!(split("  a.o \t b.o  "), vec!["a.o", "b.o"]);
        assert_eq!(
            split("'one two' \"three four\""),
            vec!["one two", "three four"]
        );
        assert_eq!(split(r"a\ b c"), vec!["a b", "c"]);
        // A quote closes the group without ending the argument.
        assert_eq!(split("-o'out name'.o"), vec!["-oout name.o"]);
        // An empty quoted argument is still an argument.
        assert_eq!(split("'' x"), vec!["", "x"]);
        assert_eq!(split("   \n\t "), Vec::<String>::new());
    }

    #[test]
    fn response_file_path_keeps_its_separators() {
        // A Windows response file carries `C:\dir\file.o` unquoted, and
        // the separators must survive; a POSIX host keeps buildargv's
        // unconditional escape. Both rules are checked from either host.
        let win = |t: &str| split_response_on(t, true);
        let posix = |t: &str| split_response_on(t, false);

        assert_eq!(win(r"C:\dir\file.o"), alloc::vec!["C:\\dir\\file.o"]);
        assert_eq!(win(r#""C:\dir\file.o""#), alloc::vec!["C:\\dir\\file.o"]);
        // A backslash still escapes a quote, so a quoted argument can
        // contain one.
        assert_eq!(win(r#""a\"b""#), alloc::vec!["a\"b"]);
        // The POSIX rule is unchanged: the separator escapes its successor.
        assert_eq!(posix(r"a\b"), alloc::vec!["ab"]);
        assert_eq!(posix(r"a\ b"), alloc::vec!["a b"]);
    }

    #[test]
    fn response_files_expand_in_place_and_nest() {
        let dir = std::env::temp_dir().join(alloc::format!("badc-rsp-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&dir);
        std::fs::create_dir_all(&dir).expect("temp dir");
        let inner = dir.join("inner.rsp");
        let outer = dir.join("outer.rsp");
        std::fs::write(&inner, "c.o d.o\n").expect("write");
        std::fs::write(&outer, alloc::format!("a.o\n@{}\nb.o\n", inner.display())).expect("write");
        let args = vec![
            "-r".to_string(),
            alloc::format!("@{}", outer.display()),
            "-o".to_string(),
            "out.o".to_string(),
        ];
        assert_eq!(
            expand_response_files(&args),
            vec!["-r", "a.o", "c.o", "d.o", "b.o", "-o", "out.o"]
        );
        // GNU ld leaves an unreadable `@file` literal, so an input
        // whose name starts with `@` still reaches the link.
        let missing = alloc::format!("@{}", dir.join("absent.rsp").display());
        assert_eq!(
            expand_response_files(std::slice::from_ref(&missing)),
            vec![missing.clone()]
        );
        // A file naming itself expands once and then stays literal.
        let loop_file = dir.join("loop.rsp");
        std::fs::write(&loop_file, alloc::format!("x.o @{}", loop_file.display())).expect("write");
        let self_ref = alloc::format!("@{}", loop_file.display());
        assert_eq!(
            expand_response_files(std::slice::from_ref(&self_ref)),
            vec!["x.o".to_string(), self_ref]
        );
        let _ = std::fs::remove_dir_all(&dir);
    }
}

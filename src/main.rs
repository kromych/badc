use std::io::{IsTerminal, Read, Write};
use std::path::PathBuf;

use badc::{
    Compiler, NativeOptions, PredefinedKind, Target, Vm, dump_native_listing_with_options,
    emit_native_with_options, jit_run_with_options, optimize, predefined_symbols,
};

const USAGE: &str = "\
usage: badc [options] <input...> [program-args...]
       badc [options] -    [program-args...]   (read source from stdin)
       cat foo.c | badc [options]              (same -- stdin auto-detected
                                                when not a terminal)

Inputs are positional and may mix `.c` sources, c5 `.o` objects,
and `.a` archives. A single `.c` input compiles and emits a
binary directly; two or more inputs (or any `-l` / `-L` / `-c`
flag) run through the cross-TU linker.

Output mode -- pick at most one (defaults to a native binary):
  --interp                 Run under the bytecode VM.
  --jit                    Lower in-process and call main() directly.
  --shared                 Produce a shared library (.dylib / .so /
                           .dll) exporting every #pragma export(name)
                           function.
  --dump-asm               Print the lowered native listing and exit.
  --list-symbols           Print built-in keywords / library calls /
                           constants and exit.
  --dump-headers           Print every bundled header to stdout and
                           exit. Useful for extracting a header into
                           `./include` to override it locally.
  --dump-pp, -E            Run the preprocessor on the input and
                           print the expanded source to stdout.
                           Mirrors gcc / clang `-E`.

Multi-TU knobs:
  -c, --compile-only       Emit a c5 `.o` per source instead of
                           linking. Output is `-o`'s path when a
                           single source is named, otherwise
                           `<stem>.o` next to each input. The `.o`
                           is target-independent; `--target=` is
                           decided at link time.
  -L <dir>                 Archive search path for `-l<name>`.
                           Repeatable; probed in declared order.
  -l <name>                Pull `lib<name>.a` in as a static
                           library. Members are pulled in on demand.

Compile knobs:
  -O, --optimize           Enable the bytecode optimizer + native
                           regalloc.
  --no-debug, -g0          Skip DWARF emission. Shrinks
                           the output by ~10-30%.
  --target=<spec>          Pick the binary format (one of
                           macos-aarch64, linux-aarch64, linux-x64,
                           windows-x64, windows-arm64). Defaults to
                           the host. Ignored under --interp / --jit
                           (those always target the host).
  -o <path>                Output path. Default depends on output
                           mode and target (.exe / .dylib / .so /
                           .dll suffixes added as appropriate).
                           Pass `-` (or omit -o when stdout is a
                           pipe) to write the binary to stdout.
  -D NAME[=VALUE]          Predefine an object-like macro
                           (`-D X` <=> `-D X=1`).
  -U NAME                  Drop a predefine, including any
                           default predefine.
  -I path                  Add a header search path, probed before
                           the bundled headers on #include.
                           Repeatable. `./include` and
                           `./headers/include` are auto-added when
                           present, so a local copy of a bundled
                           header overrides the embedded one.
  -include FILE            Splice the named header in front of the
                           source as if `#include \"FILE\"` opened
                           the translation unit. Repeatable; later
                           flags expand after earlier ones.
  -H, --show-includes      Print every #include's resolved path to
                           stderr (gcc -H shape; leading dots mark
                           nesting depth; missing headers print as
                           `! <name> (missing)`).
  -q, --quiet              Suppress `info:` chatter on stderr (the
                           per-source `info: compiling <path>`
                           progress line in multi-TU mode and the
                           `info: wrote file <path>` line emitted
                           after each output write). Errors and
                           warnings are unaffected.

VM-only knobs (require --interp):
  --track-pointers         Allocation tracking + use-after-free guard.
  --trace                  Per-instruction stdout trace (noisy).

Mutually exclusive: --interp / --jit / --shared / --dump-asm /
--list-symbols / --dump-headers all pick the output mode; only one
applies. --track-pointers and --trace require --interp. -o has no
effect under --interp / --list-symbols / --dump-headers.";

/// Where the AOT codesign tool lives on every macOS install. Hardcoded
/// so we don't accidentally pick up a homebrew shim that signs differently.
#[cfg(target_os = "macos")]
const CODESIGN: &str = "/usr/bin/codesign";

/// Top-level mode picked from the argv flag set. Mutual
/// exclusion is enforced once during arg parsing so the rest
/// of `main` can match on a single `Mode`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Mode {
    /// Default -- lower to a native executable on disk.
    NativeExecutable,
    /// `--shared` -- lower to a native shared library on
    /// disk. Same writer pipeline as `NativeExecutable` plus
    /// `OutputKind::SharedLibrary`.
    SharedLibrary,
    /// `--interp` -- run under the bytecode VM.
    Interp,
    /// `--jit` -- lower in-process and call main directly.
    Jit,
    /// `--dump-asm` -- print the native listing and exit.
    DumpAsm,
    /// `--list-symbols` -- print the pre-defined symbol table
    /// and exit. Takes no source file.
    ListSymbols,
    /// `--dump-headers` -- print every bundled header (with
    /// file separators) to stdout and exit. Takes no source.
    DumpHeaders,
    /// `--dump-pp` -- run the preprocessor on the input and
    /// print the expanded source to stdout. Mirrors gcc / clang
    /// `-E` for inspecting macro expansion and include
    /// resolution.
    DumpPp,
    /// `--ar` -- bundle every input (compiled `.c` plus any
    /// `.o`) into a single `.a` archive named by `-o`. No
    /// linking; the archive is meant to be passed back as
    /// input to a future link.
    BuildArchive,
}

impl Mode {
    fn flag_name(self) -> &'static str {
        match self {
            Mode::NativeExecutable => "(default)",
            Mode::SharedLibrary => "--shared",
            Mode::Interp => "--interp",
            Mode::Jit => "--jit",
            Mode::DumpAsm => "--dump-asm",
            Mode::ListSymbols => "--list-symbols",
            Mode::DumpHeaders => "--dump-headers",
            Mode::DumpPp => "--dump-pp",
            Mode::BuildArchive => "--ar",
        }
    }
}

fn main() {
    let raw: Vec<String> = std::env::args().collect();

    // Mode selection: at most one of the mode-picking flags
    // may appear. We track the *first* seen so an error
    // message can name both flags.
    let mut mode: Option<(Mode, &'static str)> = None;
    let mut track_pointers = false;
    let mut trace = false;
    let mut optimize_flag = false;
    // SSA-lift + linear-scan emit is the default; `--regalloc=pool`
    // opts back into the original pool emitter, `--regalloc=o0`
    // forces single-bank pool allocation. The CI pool lane sets
    // `BADC_DEFAULT_REGALLOC=pool` to flip the default without
    // touching every smoke script's argv.
    let mut regalloc_mode: badc::RegallocMode =
        match std::env::var("BADC_DEFAULT_REGALLOC").ok().as_deref() {
            Some("pool") => badc::RegallocMode::Pool,
            Some("o0") => badc::RegallocMode::O0,
            _ => badc::RegallocMode::Ssa,
        };
    let mut dump_ssa = false;
    let mut emit_debug_info = true;
    let mut output_path: Option<PathBuf> = None;
    let mut target_spec: Option<String> = None;
    let mut defines: Vec<(String, String)> = Vec::new();
    let mut undefines: Vec<String> = Vec::new();
    let mut include_paths: Vec<String> = Vec::new();
    let mut force_includes: Vec<String> = Vec::new();
    // gcc `-H`-shape include tracing. When on, the preprocessor
    // records one line per `#include` resolve (with leading-dot
    // depth) and the CLI flushes the list to stderr after
    // compilation. Useful for diagnosing "why did this header land
    // here" or "why didn't this header resolve" without poking the
    // amalgamated `__BADC_DUMP_PP` output.
    let mut show_includes = false;
    // `-q` / `--quiet` suppresses `info:` chatter on stderr. The
    // per-source `info: compiling <path>` progress line in
    // multi-TU mode and the `info: wrote file <path>` lines that
    // follow each output write are both gated on this flag.
    // Errors and warnings still print; only informational lines
    // are quieted.
    let mut quiet = false;
    // Multi-translation-unit linker plumbing. Bytecode `.o`
    // inputs accumulate alongside C sources; `.a` archives
    // arrive either positionally or through `-l<name>` after a
    // search through `-L<dir>` paths. `compile_only` switches
    // off the link step entirely and writes one `.o` per
    // source so the bytes can be fed back through another
    // badc invocation.
    let mut compile_only = false;
    let mut lib_names: Vec<String> = Vec::new();
    let mut library_paths: Vec<String> = Vec::new();

    let mut iter = raw.into_iter();
    let prog0 = iter.next().unwrap_or_default();
    let mut args: Vec<String> = vec![prog0];
    while let Some(arg) = iter.next() {
        let claim = |slot: &mut Option<(Mode, &'static str)>, picked: Mode| {
            let flag = picked.flag_name();
            if let Some((existing, existing_flag)) = *slot {
                eprintln!(
                    "badc: {flag} can't be combined with {existing_flag} -- both pick an \
                     output mode (Mode::{:?} vs Mode::{:?}). See --help.",
                    picked, existing
                );
                std::process::exit(1);
            }
            *slot = Some((picked, flag));
        };
        match arg.as_str() {
            "--interp" => claim(&mut mode, Mode::Interp),
            "--track-pointers" => track_pointers = true,
            "--trace" => trace = true,
            "--list-symbols" => claim(&mut mode, Mode::ListSymbols),
            "--dump-headers" => claim(&mut mode, Mode::DumpHeaders),
            "--dump-pp" | "-E" => claim(&mut mode, Mode::DumpPp),
            "--optimize" | "-O" => optimize_flag = true,
            arg if arg.starts_with("--regalloc=") => {
                let value = &arg["--regalloc=".len()..];
                regalloc_mode = match value {
                    "pool" => badc::RegallocMode::Pool,
                    "o0" => badc::RegallocMode::O0,
                    "ssa" => badc::RegallocMode::Ssa,
                    other => {
                        eprintln!(
                            "badc: --regalloc={other} not recognised (expected pool / o0 / ssa)"
                        );
                        std::process::exit(1);
                    }
                };
                // --regalloc=ssa (default) runs the SSA lift +
                // linear-scan allocator on every function and emits
                // native bytes through `ssa_emit_*`. A per-function
                // bail is a hard error. --regalloc=pool forces the
                // pool emitter for the whole program;
                // --regalloc=o0 forces the single-bank pool shape.
                // `--dump-ssa` prints the IR + allocation for each
                // function.
            }
            "--dump-ssa" => dump_ssa = true,
            "--no-debug" | "-g0" => emit_debug_info = false,
            "--dump-asm" => claim(&mut mode, Mode::DumpAsm),
            "--jit" => claim(&mut mode, Mode::Jit),
            "--shared" => claim(&mut mode, Mode::SharedLibrary),
            "--ar" | "--archive" => claim(&mut mode, Mode::BuildArchive),
            "-h" | "--help" => {
                println!("{USAGE}");
                return;
            }
            "-o" => match iter.next() {
                Some(p) => output_path = Some(PathBuf::from(p)),
                None => {
                    eprint_diagnostic("badc: error: -o requires a path argument");
                    std::process::exit(1);
                }
            },
            "-D" => match iter.next() {
                Some(s) => match s.split_once('=') {
                    Some((name, body)) => defines.push((name.to_string(), body.to_string())),
                    None => defines.push((s, String::from("1"))),
                },
                None => {
                    eprint_diagnostic("badc: error: -D requires NAME[=VALUE]");
                    std::process::exit(1);
                }
            },
            s if s.starts_with("-D") && s.len() > 2 => {
                let body = &s[2..];
                match body.split_once('=') {
                    Some((name, body)) => defines.push((name.to_string(), body.to_string())),
                    None => defines.push((body.to_string(), String::from("1"))),
                }
            }
            "-U" => match iter.next() {
                Some(s) => undefines.push(s),
                None => {
                    eprint_diagnostic("badc: error: -U requires a NAME");
                    std::process::exit(1);
                }
            },
            s if s.starts_with("-U") && s.len() > 2 => {
                undefines.push(s[2..].to_string());
            }
            "-I" => match iter.next() {
                Some(p) => include_paths.push(p),
                None => {
                    eprint_diagnostic("badc: error: -I requires a path argument");
                    std::process::exit(1);
                }
            },
            s if s.starts_with("-I") && s.len() > 2 => {
                include_paths.push(s[2..].to_string());
            }
            // gcc / clang -include FILE: splice the named header
            // in front of the source as if `#include "FILE"` had
            // been written at the top of the translation unit.
            // Repeatable; later flags expand top-to-bottom in the
            // order given. The header is resolved through the
            // same -I / embedded-registry chain as a normal
            // `#include`, so a build driver can drop a checked-in
            // copy into `./include/` to override the bundled one.
            "-include" => match iter.next() {
                Some(name) => force_includes.push(name),
                None => {
                    eprint_diagnostic("badc: error: -include requires a header name");
                    std::process::exit(1);
                }
            },
            // gcc / clang `-H` -- print the resolved include path
            // for every `#include` directive, with leading dots
            // marking nesting depth. `--show-includes` is the
            // descriptive long form (also matches MSVC's spelling).
            "-H" | "--show-includes" => show_includes = true,
            // Quiet mode -- silence informational output (per-source
            // progress, `info: wrote file <path>` lines). Errors
            // and warnings remain on stderr unchanged.
            "-q" | "--quiet" => quiet = true,
            // `-c` / `--compile-only` -- emit a c5 object file
            // (`.o`) per source instead of linking through to a
            // native binary. The output goes to either the
            // explicit -o path (when one source is named) or
            // `<stem>.o` next to each input.
            "-c" | "--compile-only" => compile_only = true,
            "-l" => match iter.next() {
                Some(name) => lib_names.push(name),
                None => {
                    eprint_diagnostic("badc: error: -l requires a library name");
                    std::process::exit(1);
                }
            },
            s if s.starts_with("-l") && s.len() > 2 => {
                lib_names.push(s[2..].to_string());
            }
            "-L" => match iter.next() {
                Some(path) => library_paths.push(path),
                None => {
                    eprint_diagnostic("badc: error: -L requires a directory");
                    std::process::exit(1);
                }
            },
            s if s.starts_with("-L") && s.len() > 2 => {
                library_paths.push(s[2..].to_string());
            }
            s if s.starts_with("--target=") => {
                target_spec = Some(s["--target=".len()..].to_string());
            }
            _ => args.push(arg),
        }
    }

    // Auto-add common header overlays so a developer iterating on
    // the bundled headers can edit `./include/...` (or
    // `./headers/include/...` from the repo root) and have the
    // change take effect without rebuilding badc. User-supplied
    // -I paths still win because they were pushed earlier in the
    // search order.
    for default in ["./include", "./headers/include"] {
        if std::path::Path::new(default).is_dir() && !include_paths.iter().any(|p| p == default) {
            include_paths.push(default.to_string());
        }
    }

    let mode = mode.map(|(m, _)| m).unwrap_or(Mode::NativeExecutable);

    let target = match Target::parse(target_spec.as_deref()) {
        Ok(t) => t,
        Err(e) => {
            eprint_diagnostic(e);
            std::process::exit(1);
        }
    };

    // VM-only flags.
    if (track_pointers || trace) && mode != Mode::Interp {
        eprintln!(
            "badc: --track-pointers / --trace require --interp \
             (current mode is {})",
            mode.flag_name()
        );
        std::process::exit(1);
    }

    // -o makes no sense for modes that don't write to disk.
    if output_path.is_some()
        && matches!(
            mode,
            Mode::Interp | Mode::ListSymbols | Mode::DumpHeaders | Mode::Jit
        )
    {
        eprintln!(
            "badc: -o is only meaningful for native compilation \
             (current mode is {})",
            mode.flag_name()
        );
        std::process::exit(1);
    }

    if mode == Mode::ListSymbols {
        print_predefined_symbols();
        return;
    }

    if mode == Mode::DumpHeaders {
        dump_bundled_headers();
        return;
    }

    // Classify every positional input by extension:
    //   * `.c`      -- a C source file to compile.
    //   * `.o`      -- a c5 object file, mmap'd straight in.
    //   * `.a`      -- a static archive, parsed lazily for
    //                  pull-in.
    //   * `-`       -- stdin source (single occurrence allowed).
    //   * (no ext)  -- treated as a C source path so a `badc foo`
    //                  invocation with no extension still works.
    //                  Same fallback the previous single-input
    //                  mode used.
    // Unrecognised entries past the first non-input become the
    // program's argv for VM / JIT modes.
    let mut sources: Vec<String> = Vec::new();
    let mut objects: Vec<String> = Vec::new();
    let mut archives: Vec<String> = Vec::new();
    let mut stdin_was_input = false;
    let mut prog_args_start: usize = args.len();
    for (i, a) in args.iter().enumerate().skip(1) {
        if a == "-" {
            sources.push(a.clone());
            stdin_was_input = true;
            continue;
        }
        let ext = std::path::Path::new(a)
            .extension()
            .and_then(|s| s.to_str())
            .unwrap_or("");
        match ext {
            "c" | "" => sources.push(a.clone()),
            "o" => objects.push(a.clone()),
            "a" => archives.push(a.clone()),
            _ => {
                // First unrecognised entry marks the boundary;
                // everything from here on is the C program's
                // argv (so `badc foo.c arg1 arg2` still works).
                prog_args_start = i;
                break;
            }
        }
    }

    // Resolve `-l<name>` against `-L<dir>` paths -- each lib
    // becomes a positional archive in declared order.
    for name in &lib_names {
        let candidate = format!("lib{name}.a");
        let mut found: Option<String> = None;
        for dir in &library_paths {
            let p = std::path::Path::new(dir).join(&candidate);
            if p.exists() {
                found = Some(p.to_string_lossy().into_owned());
                break;
            }
        }
        match found {
            Some(p) => archives.push(p),
            None => {
                eprintln!(
                    "badc: cannot find `lib{name}.a` on any -L search path \
                     ({} probed)",
                    library_paths.len()
                );
                std::process::exit(1);
            }
        }
    }

    // Fall back to stdin when no positional source was given
    // and stdin isn't a terminal -- the legacy
    // `cat foo.c | badc` pipeline.
    if sources.is_empty()
        && objects.is_empty()
        && archives.is_empty()
        && !std::io::stdin().is_terminal()
    {
        sources.push("-".to_string());
        stdin_was_input = true;
    }
    if sources.is_empty() && objects.is_empty() {
        eprintln!("{USAGE}");
        std::process::exit(1);
    }

    let read_stdin_source = || -> String {
        let mut s = String::new();
        if let Err(e) = std::io::stdin().read_to_string(&mut s) {
            eprint_diagnostic(format!("badc: error: error reading stdin: {e}"));
            std::process::exit(1);
        }
        s
    };

    // Compile sources to LinkUnits.
    let mut units: Vec<badc::LinkUnit> = Vec::with_capacity(sources.len() + objects.len());
    let mut unit_source_paths: Vec<String> = Vec::with_capacity(sources.len());
    let mut accumulated_warnings: Vec<String> = Vec::new();
    let mut accumulated_include_trace: Vec<String> = Vec::new();
    let multi_tu = sources.len() > 1;
    for src_path in &sources {
        let (label, contents) = if src_path == "-" {
            ("-".to_string(), read_stdin_source())
        } else {
            let mut file = match std::fs::File::open(src_path) {
                Ok(f) => f,
                Err(e) => {
                    eprint_diagnostic(format!("badc: error: cannot open `{src_path}`: {e}"));
                    std::process::exit(1);
                }
            };
            let mut s = String::new();
            if let Err(e) = Read::read_to_string(&mut file, &mut s) {
                eprint_diagnostic(format!("badc: error: error reading `{src_path}`: {e}"));
                std::process::exit(1);
            }
            (src_path.clone(), s)
        };
        // Multi-TU progress: one line per source on stderr so a long
        // batch makes its current position visible. Single-source
        // compiles stay silent so `badc file.c` does not gain extra
        // chatter.
        if multi_tu && mode != Mode::DumpPp && !quiet {
            eprint_diagnostic(format!("info: compiling {label}"));
        }
        if mode == Mode::DumpPp {
            let opts = badc::CompileOptions::default()
                .with_defines(defines.clone())
                .with_undefines(undefines.clone())
                .with_include_paths(include_paths.clone())
                .with_force_includes(force_includes.clone())
                .with_source_label(label.clone());
            match Compiler::preprocess(contents, target, opts) {
                Ok(s) => {
                    // File separator on stderr so a multi-source
                    // dump remains parseable while the actual
                    // preprocessed bytes stay clean on stdout.
                    if multi_tu {
                        eprintln!("--- {label} ---");
                    }
                    print!("{s}");
                }
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            }
            continue;
        }
        let mut compiler = Compiler::with_options(
            contents,
            target,
            badc::CompileOptions::default()
                .with_defines(defines.clone())
                .with_undefines(undefines.clone())
                .with_include_paths(include_paths.clone())
                .with_force_includes(force_includes.clone())
                .with_source_label(label.clone())
                .with_show_includes(show_includes),
        );
        if show_includes {
            accumulated_include_trace.extend(compiler.take_include_trace());
        }
        let mut unit = match compiler.compile_to_link_unit() {
            Ok(u) => u,
            Err(e) => {
                eprint_diagnostic(e);
                std::process::exit(1);
            }
        };
        unit.source_path = label.clone();
        accumulated_warnings.extend(unit.warnings.iter().cloned());
        unit_source_paths.push(label);
        units.push(unit);
    }

    // --dump-pp is a per-source dump; nothing downstream of the
    // per-source loop applies (no link, no codegen, no output
    // file). Return now so the rest of the driver doesn't trip on
    // the empty unit list.
    if mode == Mode::DumpPp {
        return;
    }

    // Load each `.o` input through mmap-shaped read.
    for obj_path in &objects {
        let bytes = match std::fs::read(obj_path) {
            Ok(b) => b,
            Err(e) => {
                eprint_diagnostic(format!("badc: error: cannot read `{obj_path}`: {e}"));
                std::process::exit(1);
            }
        };
        match badc::read_object(&bytes) {
            Ok(u) => units.push(u),
            Err(e) => {
                eprint_diagnostic(format!("badc: error: failed to parse `{obj_path}`: {e}"));
                std::process::exit(1);
            }
        }
    }

    if show_includes {
        for line in &accumulated_include_trace {
            eprintln!("{line}");
        }
    }

    // `-c` / `--compile-only`: write each compiled source's
    // LinkUnit to disk as a `.o` and exit. Archives / `-l`
    // inputs aren't meaningful here -- the caller is asking
    // for the per-source object emit, not a link.
    if compile_only {
        if !archives.is_empty() || !lib_names.is_empty() {
            eprintln!(
                "badc: -c is incompatible with archive inputs / -l flags \
                 (object emit doesn't involve linking)"
            );
            std::process::exit(1);
        }
        if units.is_empty() {
            eprint_diagnostic("badc: error: -c requires at least one source input");
            std::process::exit(1);
        }
        // Source-derived units come first in `units`; objects
        // would only appear if the user mixed them in, which is
        // already an error path above.
        let source_count = sources.len();
        if let Some(out) = output_path.as_deref() {
            if source_count != 1 {
                eprintln!(
                    "badc: `-o <path>` together with `-c` requires exactly one \
                     `.c` input ({} given)",
                    source_count
                );
                std::process::exit(1);
            }
            let bytes = badc::write_object(&units[0]);
            write_output(out, &bytes, quiet);
        } else {
            for (i, unit) in units.iter().take(source_count).enumerate() {
                let src = &unit_source_paths[i];
                let p = std::path::Path::new(src);
                let out = p.with_extension("o");
                let bytes = badc::write_object(unit);
                write_output(&out, &bytes, quiet);
            }
        }
        return;
    }

    // `--ar` mode: bundle every input unit (compiled `.c`
    // plus any `.o`) into a single archive named by `-o`.
    // Each member is the unit's `.o` bytes; the SysV symbol
    // index lists every externally-linkable defined name so
    // pull-in works without re-parsing each member.
    if mode == Mode::BuildArchive {
        if !archives.is_empty() || !lib_names.is_empty() {
            eprintln!(
                "badc: --ar can't be combined with archive inputs / -l flags \
                 (the archive is an output, not a link target)"
            );
            std::process::exit(1);
        }
        let Some(out_path) = output_path.clone() else {
            eprint_diagnostic("badc: error: --ar requires -o <archive>.a");
            std::process::exit(1);
        };
        if units.is_empty() {
            eprint_diagnostic("badc: error: --ar requires at least one input");
            std::process::exit(1);
        }
        let mut members: Vec<badc::ArchiveMember> = Vec::with_capacity(units.len());
        let mut sym_index: Vec<(usize, Vec<String>)> = Vec::with_capacity(units.len());
        // Member name comes from the source / object path's
        // file stem with a `.o` suffix -- mirrors how a regular
        // `-c` invocation would name the per-source output.
        let source_count = sources.len();
        for (i, unit) in units.iter().enumerate() {
            let base = if i < source_count {
                std::path::Path::new(&unit_source_paths[i])
                    .file_stem()
                    .map(|s| s.to_string_lossy().into_owned())
                    .unwrap_or_else(|| format!("tu{i}"))
            } else {
                std::path::Path::new(&objects[i - source_count])
                    .file_stem()
                    .map(|s| s.to_string_lossy().into_owned())
                    .unwrap_or_else(|| format!("tu{i}"))
            };
            let bytes = badc::write_object(unit);
            let defined: Vec<String> = unit
                .symbols
                .iter()
                .filter(|s| {
                    !matches!(s.kind, badc::SymbolKind::Undefined)
                        && !matches!(s.linkage, badc::Linkage::Internal | badc::Linkage::None)
                })
                .map(|s| s.name.clone())
                .collect();
            members.push(badc::ArchiveMember {
                name: format!("{base}.o"),
                bytes,
            });
            sym_index.push((i, defined));
        }
        let blob = badc::write_archive(&members, &sym_index);
        write_output(&out_path, &blob, quiet);
        return;
    }

    // Parse positional + resolved archives. The order matches
    // command-line order so a later `-l` overrides an earlier
    // one's symbol resolution (gcc / ld convention).
    let mut link_archives: Vec<badc::LinkArchive> = Vec::with_capacity(archives.len());
    for a in &archives {
        let bytes = match std::fs::read(a) {
            Ok(b) => b,
            Err(e) => {
                eprint_diagnostic(format!("badc: error: cannot read `{a}`: {e}"));
                std::process::exit(1);
            }
        };
        match badc::LinkArchive::parse(a.clone(), &bytes) {
            Ok(la) => link_archives.push(la),
            Err(e) => {
                eprint_diagnostic(format!("badc: error: failed to parse `{a}`: {e}"));
                std::process::exit(1);
            }
        }
    }

    // Drive the link step. `program` ends up the same shape
    // a single-TU `Compiler::compile()` would have produced.
    let path = unit_source_paths
        .first()
        .cloned()
        .unwrap_or_else(|| objects.first().cloned().unwrap_or_else(|| "-".to_string()));
    let mut program = match badc::link_units(units, &link_archives, badc::LinkOptions::default()) {
        Ok(p) => p,
        Err(e) => {
            eprint_diagnostic(e);
            std::process::exit(1);
        }
    };
    program.warnings.extend(accumulated_warnings);
    let _ = stdin_was_input;
    if program.source_path.is_empty() {
        program.source_path = path.clone();
    }

    let program = if optimize_flag && std::env::var("BADC_BC_OPT_OFF").is_err() {
        match optimize(program) {
            Ok(p) => p,
            Err(e) => {
                eprint_diagnostic(e);
                std::process::exit(1);
            }
        }
    } else {
        program
    };

    // Type-mismatch / arity / signature-redecl warnings (if any) --
    // print once, before the program runs. They never fail the
    // compile, but they go to stderr so a `2>/dev/null` user can
    // suppress. Each warning arrives in gcc / clang shape
    // (`<file>:<line>: warning: <message>`); when stderr is a TTY
    // we color the severity word so they pop out of build logs.
    let stderr_is_tty = std::io::stderr().is_terminal();
    for w in &program.warnings {
        eprintln!("{}", colorize_diagnostic(w, stderr_is_tty));
    }

    // `--optimize` / `-O` enables both the bytecode optimizer (above)
    // and the native peephole + register allocator. The two halves are
    // independent -- the native pass is correct on either pre- or
    // post-bytecode-optimizer input -- but turning them on together
    // produces the fastest emitted code.
    let mut native_opts = if optimize_flag {
        NativeOptions::new().with_optimize()
    } else {
        NativeOptions::new()
    };
    native_opts = native_opts.with_regalloc(regalloc_mode);
    native_opts = native_opts.with_debug_info(emit_debug_info);
    if dump_ssa {
        native_opts = native_opts.with_dump_ssa();
    }
    if mode == Mode::SharedLibrary {
        native_opts = native_opts.with_shared_library();
    }

    match mode {
        Mode::DumpAsm => match dump_native_listing_with_options(&program, target, native_opts) {
            Ok(s) => print!("{s}"),
            Err(e) => {
                eprint_diagnostic(e);
                std::process::exit(1);
            }
        },
        Mode::Jit => {
            // The JIT loader picks the host arch on its own; --target is
            // ignored (the JIT can't cross-compile, and the lowering it
            // does is determined by the host).
            // argv[0] = first source path so the hosted program sees a
            // sensible name; argv[1..] = whatever followed the inputs
            // on the command line.
            let mut c_args: Vec<String> = Vec::new();
            c_args.push(path.clone());
            if prog_args_start < args.len() {
                c_args.extend(args[prog_args_start..].iter().cloned());
            }
            match jit_run_with_options(&program, &c_args, native_opts) {
                Ok(code) => std::process::exit(code),
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            }
        }
        Mode::Interp => {
            // Pass everything from argv[1] onward to the C program -- argv[0]
            // of the hosted program is the source file name, argv[1..] are
            // its own args.
            let mut c_args: Vec<String> = Vec::new();
            c_args.push(path.clone());
            if prog_args_start < args.len() {
                c_args.extend(args[prog_args_start..].iter().cloned());
            }
            let mut vm = Vm::new(program).with_args(c_args);
            if track_pointers {
                vm = vm.with_pointer_tracking();
            }
            if trace {
                vm = vm.with_trace();
            }
            match vm.run() {
                Ok(res) => println!("exit({})", res),
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            }
        }
        Mode::NativeExecutable | Mode::SharedLibrary => {
            // Default: lower to a native binary, write it, mark
            // it executable, and (on macOS hosts emitting Mach-O)
            // ad-hoc codesign so dyld accepts it.
            //
            // gh #28 piped-output: if the user passed `-o -` or
            // didn't specify -o and stdout is a pipe (= we're in
            // the middle of a shell pipeline like
            // `... | badc | run-on-target`), write the bytes
            // straight to stdout instead of disk. The
            // mark-executable + codesign + per-target nag messages
            // are skipped -- the caller knows what they're doing.
            let pipe_to_stdout = match output_path.as_deref() {
                Some(p) => p == std::path::Path::new("-"),
                None => !std::io::stdout().is_terminal(),
            };
            if pipe_to_stdout {
                emit_native_binary_to_stdout(&program, target, native_opts);
            } else {
                let out = output_path.unwrap_or_else(|| default_output_path(&path, target, mode));
                emit_native_binary(&program, &out, target, native_opts, mode, quiet);
            }
        }
        Mode::ListSymbols => unreachable!("handled above"),
        Mode::DumpHeaders => unreachable!("handled above"),
        Mode::DumpPp => unreachable!("handled above"),
        Mode::BuildArchive => unreachable!("handled above"),
    }
}

/// Print `msg` to stderr through `colorize_diagnostic`, deciding
/// once whether stderr is a TTY. Use for any user-visible error or
/// warning the CLI emits -- it's a no-op for messages that don't
/// look like a diagnostic, so plain "badc: file not found" lines
/// pass through unchanged.
fn eprint_diagnostic(msg: impl core::fmt::Display) {
    let stderr_is_tty = std::io::stderr().is_terminal();
    let s = msg.to_string();
    eprintln!("{}", colorize_diagnostic(&s, stderr_is_tty));
}

/// Add ANSI color around the severity word (`warning:`, `error:`,
/// `info:` / `note:`) inside a diagnostic line. We accept either
/// the gcc shape `<file>:<line>: warning: <msg>` or any line
/// whose severity word is followed by a colon and a space; the
/// rest of the message stays untouched. Falls through unchanged
/// when stderr isn't a TTY so build logs stay greppable.
fn colorize_diagnostic(line: &str, is_tty: bool) -> std::borrow::Cow<'_, str> {
    if !is_tty {
        return std::borrow::Cow::Borrowed(line);
    }
    // Find the first ` <severity>: ` -- after the `<file>:<line>: `
    // anchor in gcc-shape lines, or at the front for severity-first
    // lines (legacy / future-style). Severity words are matched
    // case-insensitively against a small allow-list so a
    // user-supplied identifier accidentally containing `:` doesn't
    // get re-colored.
    const SEVERITIES: &[(&str, &str)] = &[
        ("error", "\x1b[1;31m"), // bold red
        ("Error", "\x1b[1;31m"),
        ("warning", "\x1b[1;33m"), // bold yellow
        ("Warning", "\x1b[1;33m"),
        ("info", "\x1b[1;32m"), // bold green
        ("Info", "\x1b[1;32m"),
        ("note", "\x1b[1;36m"), // bold cyan
        ("Note", "\x1b[1;36m"),
    ];
    const RESET: &str = "\x1b[0m";
    for (word, color) in SEVERITIES {
        let needle = format!(" {word}: ");
        if let Some(pos) = line.find(&needle) {
            let prefix = &line[..pos + 1];
            let rest = &line[pos + needle.len()..];
            return std::borrow::Cow::Owned(format!("{prefix}{color}{word}:{RESET} {rest}"));
        }
        // Severity at the very start of the line.
        let head = format!("{word}: ");
        if line.starts_with(&head) {
            let rest = &line[head.len()..];
            return std::borrow::Cow::Owned(format!("{color}{word}:{RESET} {rest}"));
        }
    }
    std::borrow::Cow::Borrowed(line)
}

/// Default `-o` value for native compilation. Picks an
/// extension matching the (target, mode) pair so the produced
/// file is loader-recognisable on the destination OS:
///
/// | mode     | target            | extension |
/// |----------|-------------------|-----------|
/// | exe      | windows-*         | `.exe`    |
/// | exe      | macos / linux     | (drop ext) / `.bin` |
/// | shared   | macos-aarch64     | `.dylib`  |
/// | shared   | linux-*           | `.so`     |
/// | shared   | windows-*         | `.dll`    |
fn default_output_path(source: &str, target: Target, mode: Mode) -> PathBuf {
    let p = PathBuf::from(source);
    let is_windows = matches!(target, Target::WindowsX64 | Target::WindowsAarch64);
    let is_macos = matches!(target, Target::MacOSAarch64);
    if mode == Mode::SharedLibrary {
        let ext = if is_windows {
            "dll"
        } else if is_macos {
            "dylib"
        } else {
            "so"
        };
        return p.with_extension(ext);
    }
    if is_windows {
        return p.with_extension("exe");
    }
    match p.extension() {
        Some(_) => p.with_extension(""),
        None => p.with_extension("bin"),
    }
}

/// Lower the program to a native binary, write it, mark it executable,
/// and -- when the produced format is Mach-O on a macOS host -- shell
/// out to `codesign --sign -` so the loader will accept it. ELF
/// binaries don't need signing; cross-format combinations print an
/// advisory line and skip the signing step.
/// Lower the program to a native binary and write it to stdout
/// rather than a file on disk. Used by gh #28's pipe-mode (the
/// caller redirected stdout, or asked for `-o -`). No
/// mark-executable / codesign / per-target reminder -- the
/// downstream of the pipe gets to handle those.
fn emit_native_binary_to_stdout(program: &badc::Program, target: Target, options: NativeOptions) {
    let bytes = match emit_native_with_options(program, target, options) {
        Ok(b) => b,
        Err(e) => {
            eprint_diagnostic(e);
            std::process::exit(1);
        }
    };
    if let Err(e) = std::io::stdout().write_all(&bytes) {
        eprint_diagnostic(format!(
            "badc: error: failed to write binary to stdout: {e}"
        ));
        std::process::exit(1);
    }
    let _ = std::io::stdout().flush();
}

/// Write `bytes` to `out`, exit on failure, log
/// `info: wrote file <path>` on success unless `quiet` is set.
/// Used by every output path -- object emit, archive emit, JIT
/// binary emit, native-binary emit -- so the chatter is uniform.
/// Routes the info line through `eprint_diagnostic` so the
/// severity word picks up the green TTY color.
fn write_output(out: &std::path::Path, bytes: &[u8], quiet: bool) {
    if let Err(e) = std::fs::write(out, bytes) {
        eprint_diagnostic(format!(
            "badc: error: failed to write {}: {e}",
            out.display()
        ));
        std::process::exit(1);
    }
    if !quiet {
        eprint_diagnostic(format!("info: wrote file {}", out.display()));
    }
}

fn emit_native_binary(
    program: &badc::Program,
    out: &std::path::Path,
    target: Target,
    options: NativeOptions,
    mode: Mode,
    quiet: bool,
) {
    let bytes = match emit_native_with_options(program, target, options) {
        Ok(b) => b,
        Err(e) => {
            eprint_diagnostic(e);
            std::process::exit(1);
        }
    };
    write_output(out, &bytes, quiet);
    if mode == Mode::NativeExecutable {
        set_executable(out);
    }
    match target {
        Target::MacOSAarch64 => {
            #[cfg(target_os = "macos")]
            codesign(out);
            #[cfg(not(target_os = "macos"))]
            eprintln!(
                "badc: produced a Mach-O on a non-macOS host; copy to macOS \
                 and `codesign --sign - <path>` before running."
            );
        }
        Target::LinuxAarch64 => {
            // ELF binaries don't need signing. If the host isn't
            // Linux/aarch64, the user has to ship the result there.
            #[cfg(not(all(target_os = "linux", target_arch = "aarch64")))]
            eprintln!(
                "badc: produced a Linux/aarch64 ELF on a different host; \
                 run it on a Linux/arm64 box, or via Docker `--platform linux/arm64`."
            );
        }
        Target::LinuxX64 => {
            #[cfg(not(all(target_os = "linux", target_arch = "x86_64")))]
            eprintln!(
                "badc: produced a Linux/x86_64 ELF on a different host; \
                 run it on a Linux/x64 box, or via Docker `--platform linux/amd64`."
            );
        }
        Target::WindowsX64 => {
            #[cfg(not(all(target_os = "windows", target_arch = "x86_64")))]
            eprintln!(
                "badc: produced a Windows/x86_64 PE on a non-Windows host; \
                 run it on Windows or under WINE (`wine path.exe`)."
            );
        }
        Target::WindowsAarch64 => {
            #[cfg(not(all(target_os = "windows", target_arch = "aarch64")))]
            eprintln!(
                "badc: produced a Windows/AArch64 PE on a different host; \
                 run it on a Windows-on-ARM box. WINE on macOS doesn't \
                 ship the aarch64-windows DLL set, so local execution \
                 isn't supported there yet."
            );
        }
    }
}

#[cfg(unix)]
fn set_executable(path: &std::path::Path) {
    use std::os::unix::fs::PermissionsExt;
    if let Ok(meta) = std::fs::metadata(path) {
        let mut perms = meta.permissions();
        perms.set_mode(perms.mode() | 0o111);
        let _ = std::fs::set_permissions(path, perms);
    }
}

#[cfg(not(unix))]
fn set_executable(_path: &std::path::Path) {
    // Windows treats `.exe` extension as the executable signal; nothing to do.
}

#[cfg(target_os = "macos")]
fn codesign(path: &std::path::Path) {
    let status = std::process::Command::new(CODESIGN)
        .args(["--sign", "-", "--force"])
        .arg(path)
        .status();
    match status {
        Ok(s) if s.success() => {}
        Ok(s) => {
            eprint_diagnostic(format!(
                "badc: warning: codesign exited with status {s}; the binary may not run"
            ));
        }
        Err(e) => {
            eprint_diagnostic(format!("badc: error: failed to invoke {CODESIGN}: {e}"));
        }
    }
}

/// Print every name the compiler pre-binds before parsing -- keywords,
/// library functions, and integer constants -- grouped by kind. Useful
/// for scripting (`badc --list-symbols | grep PROT_`) and for spotting
/// what's available without `#include`.
/// `--dump-headers` writer. Prints every bundled header to stdout
/// with a one-line `// ===== <name> =====` separator before each
/// body, suitable for piping through `awk` to extract a subset
/// or for redirecting the whole stream to a directory tree (see
/// the `--help` blurb -- the conventional shape is to redirect
/// into `./include` and let `-I.` plus future filesystem search
/// override the embedded copy).
fn dump_bundled_headers() {
    for (name, body) in badc::embedded_headers() {
        println!("// ===== {name} =====");
        // Bodies already end with `\n`; `print!` rather than
        // `println!` so we don't add a stray blank line between
        // the last byte and the next separator.
        print!("{body}");
        if !body.ends_with('\n') {
            println!();
        }
    }
}

fn print_predefined_symbols() {
    let symbols = predefined_symbols();

    let mut names: Vec<&str> = symbols
        .iter()
        .filter(|s| s.kind == PredefinedKind::Keyword)
        .map(|s| s.name)
        .collect();
    names.sort_unstable();
    println!("Keywords:");
    for name in names {
        println!("  {name}");
    }

    let mut names: Vec<&str> = symbols
        .iter()
        .filter(|s| s.kind == PredefinedKind::Intrinsic)
        .map(|s| s.name)
        .collect();
    names.sort_unstable();
    println!("\nLibrary calls:");
    for name in names {
        println!("  {name}");
    }

    let mut consts: Vec<(&str, i64)> = symbols
        .iter()
        .filter(|s| s.kind == PredefinedKind::Constant)
        .map(|s| (s.name, s.value))
        .collect();
    consts.sort_unstable_by_key(|(n, _)| *n);
    let max_name_width = consts.iter().map(|(n, _)| n.len()).max().unwrap_or(0);
    println!("\nConstants:");
    for (name, value) in consts {
        println!("  {name:<max_name_width$} = {value}");
    }
}

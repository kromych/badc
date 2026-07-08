use std::io::{IsTerminal, Read};
use std::path::PathBuf;

use badc::{
    Compiler, NativeOptions, PredefinedKind, Target, Vm, jit_run_with_options, predefined_symbols,
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
  --interp                 Run under the SSA interpreter.
  --jit                    Lower in-process and call main() directly.
  --shared                 Produce a shared library (.dylib / .so /
                           .dll) exporting every #pragma export(name)
                           function.
  --list-symbols           Print built-in keywords / library calls /
                           constants and exit.
  --dump-headers           Print every bundled header to stdout and
                           exit. Useful for extracting a header into
                           `./include` to override it locally.
  --install [<dir>]        Write every embedded header and the runtime
                           source under <dir> (default ~/.badc, or
                           $BADC_HOME), recreating the include/ + lib/
                           hierarchy, then exit. Later runs prefer the
                           installed copies: ~/.badc/include is searched
                           before the embedded headers and
                           ~/.badc/lib/runtime.c overrides the embedded
                           runtime, so editing an installed file changes
                           the build without rebuilding badc.
  --dump-pp, -E            Run the preprocessor on the input and
                           print the expanded source to stdout.
                           Mirrors gcc / clang `-E`.

Multi-TU knobs:
  -c, --compile-only       Emit a c5 `.o` per source instead of
                           linking. Output is `-o`'s path when a
                           single source is named, otherwise
                           `<stem>.o` next to each input. The
                           output is a standard ELF64 ET_REL
                           object (machine code + symbol table +
                           relocs) linkable by `ld` / `lld`.
                           Target pins at compile time.
  -L <dir>                 Archive search path for `-l<name>`.
                           Repeatable; probed in declared order.
  -l <name>                Pull `lib<name>.a` in as a static
                           library. Members are pulled in on demand.

Compile knobs:
  -O, --optimize           Run the SSA optimization passes (mem2reg,
                           inlining, rotate and branch const-fold,
                           immediate dedup) and predefine `NDEBUG=1`
                           and `__OPTIMIZE__=1` (override with `-D` /
                           `-U`). Off by default. The
                           `-O1`/`-O2`/`-O3`/`-Os`/`-Oz`/`-Ofast`/`-Og`
                           forms all select this single level; `-O0`
                           disables it.
  -g, --debug              Emit DWARF debug info. Off by default;
                           adds ~10-30% to the output size.
  -g0, --no-debug          Skip DWARF emission (the default).
  --freestanding           Do not link the embedded startup runtime.
                           The image enters at the program's own entry
                           (`__c5_entry` by default, or the
                           `#pragma entrypoint` symbol), which the
                           program must define.
  --target=<spec>          Pick the binary format (one of
                           macos-aarch64, linux-aarch64, linux-x64,
                           windows-x64, windows-arm64). Defaults to
                           the host. Ignored under --interp / --jit
                           (those always target the host).
  -o <path>                Output path. Default depends on output
                           mode and target (.exe / .dylib / .so /
                           .dll suffixes added as appropriate). A
                           stdin source defaults to `a.bin`
                           (`a.exe` on Windows targets).
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
  --export-all             Export every non-static function in native
                           output (Mach-O / ELF / PE) so a runtime
                           dlopen consumer can dlsym it without a
                           #pragma export. Applies to --shared and
                           executable output.
  --export-data            Export every non-static data global from an
                           ELF executable into .dynsym (STT_OBJECT) so a
                           dlopen'd module resolves it, the data half of
                           the toolchain's -rdynamic. Pair with
                           --export-all for full coverage.
  --gnu                    Define the GCC identity macros (__GNUC__,
                           __VERSION__, __extension__, ...). Off by
                           default: badc implements most but not all of
                           the GNU C surface, so code gating a feature
                           badc lacks (__int128) on __GNUC__ keeps
                           compiling unless this is requested.

VM-only knobs (require --interp):
  --track-pointers         Allocation tracking + use-after-free guard.
  --trace                  Per-instruction stdout trace (noisy).

Mutually exclusive: --interp / --jit / --shared /
--list-symbols / --dump-headers / --install all pick the output
mode; only one applies. --track-pointers and --trace require
--interp. -o has no effect under --interp / --list-symbols /
--dump-headers / --install.";

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
    /// `--interp` -- run under the SSA interpreter (`vm::ssa`),
    /// walking `FunctionSsa` directly via `produce_ssa_funcs`.
    Interp,
    /// `--jit` -- lower in-process and call main directly.
    Jit,
    /// `--list-symbols` -- print the pre-defined symbol table
    /// and exit. Takes no source file.
    ListSymbols,
    /// `--dump-headers` -- print every bundled header (with
    /// file separators) to stdout and exit. Takes no source.
    DumpHeaders,
    /// `--install [<dir>]` -- write every embedded header and the
    /// runtime source under `<dir>` (default `~/.badc`), recreating
    /// the `include/` + `lib/` hierarchy, and exit. A later run prefers
    /// those on-disk copies over the embedded ones.
    Install,
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
    /// `--dump-native-link` -- parse a list of native ELF
    /// `.o` files (produced by `-c`), merge them via
    /// `link_native_objects`, and print a summary of the
    /// resulting `MergedNative`: per-section sizes, defined
    /// symbols, and pending import resolutions. No output
    /// file; diagnostic only.
    DumpNativeLink,
}

impl Mode {
    fn flag_name(self) -> &'static str {
        match self {
            Mode::NativeExecutable => "(default)",
            Mode::SharedLibrary => "--shared",
            Mode::Interp => "--interp",
            Mode::Jit => "--jit",
            Mode::ListSymbols => "--list-symbols",
            Mode::DumpHeaders => "--dump-headers",
            Mode::Install => "--install",
            Mode::DumpPp => "--dump-pp",
            Mode::BuildArchive => "--ar",
            Mode::DumpNativeLink => "--dump-native-link",
        }
    }
}

fn main() {
    // The recursive-descent parser bounds its nesting depth with a
    // diagnostic, but debug builds spend tens of KiB of native stack
    // per level, more than the platform default provides at the
    // bound. Run the driver on a thread with an explicit reservation
    // so the diagnostic always fires before the stack runs out.
    let driver = std::thread::Builder::new()
        .stack_size(256 * 1024 * 1024)
        .spawn(run)
        .expect("spawn driver thread");
    if let Err(e) = driver.join() {
        std::panic::resume_unwind(e);
    }
}

fn run() {
    let raw: Vec<String> = std::env::args().collect();

    // Mode selection: at most one of the mode-picking flags
    // may appear. We track the *first* seen so an error
    // message can name both flags.
    let mut mode: Option<(Mode, &'static str)> = None;
    let mut track_pointers = false;
    let mut trace = false;
    let mut optimize_flag = false;
    let mut dump_ssa = false;
    let mut inline_cap: u32 = 64;
    let mut emit_debug_info = false;
    // Produce a freestanding image: do not link the embedded startup
    // runtime, and make the program's own entry the image entry
    // (`__c5_entry` by default, or `#pragma entrypoint`), which the
    // program must define. Requested only by this flag.
    let mut freestanding = false;
    // `--entry=<sym>` / `--subsystem=<kind>` set the image entry symbol
    // and PE subsystem from the command line, so a link of precompiled
    // `.o` inputs (which carry no source-level `#pragma entrypoint` /
    // `#pragma subsystem`) can still name its entry and subsystem. When
    // set they take precedence over any per-TU pragma.
    let mut cli_entry: Option<String> = None;
    let mut cli_subsystem: Option<badc::Subsystem> = None;
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
    // `-Wdead-store` opts into the per-store dead-store
    // diagnostic. Off by default; the per-symbol
    // `unused variable` / `set but never used` warnings still
    // fire regardless.
    let mut warn_dead_store = false;
    // `-q` / `--quiet` suppresses `info:` chatter on stderr. The
    // per-source `info: compiling <path>` progress line in
    // multi-TU mode and the `info: wrote file <path>` lines that
    // follow each output write are both gated on this flag.
    // Errors and warnings still print; only informational lines
    // are quieted.
    let mut quiet = false;
    // `--export-all` exports every non-static function in the dynamic
    // symbol table / export trie of native output, so a runtime
    // `dlopen` consumer can `dlsym` it without a source-level `#pragma
    // export`. Applies to shared-library and executable output on every
    // native target (Mach-O / ELF / PE); a host executable that loads
    // plugin modules sets it so the modules resolve the host's symbols.
    let mut export_all = false;
    // `--export-data` -- add every defined non-static global (function
    // and data) to the dynamic symbol table of a native executable, so a
    // `dlopen`'d module resolves the host's symbols (a Python C extension
    // binding the interpreter's `Py*` API, including the `PyTypeObject`
    // data globals). ELF only; macOS already exports executable globals,
    // Windows has no analogue.
    let mut export_data = false;
    // `--gnu` -- define the GCC identity macros (`__GNUC__` etc.).
    let mut gnu = false;
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
            // `--install [<dir>]`: the optional destination is the first
            // positional token (it falls through to `args`); a bare
            // `--install` defaults to ~/.badc. Dispatched after parsing.
            "--install" => claim(&mut mode, Mode::Install),
            "--dump-pp" | "-E" => claim(&mut mode, Mode::DumpPp),
            // The optimizer has a single level; every `-O<n>` form maps
            // onto it, matching gcc/clang where a build system may pass
            // any of them. `-O0` explicitly disables it (and overrides an
            // earlier `-O` on the same command line).
            "--optimize" | "-O" | "-O1" | "-O2" | "-O3" | "-Os" | "-Oz" | "-Ofast" | "-Og" => {
                optimize_flag = true
            }
            "-O0" => optimize_flag = false,
            "--dump-ssa" => dump_ssa = true,
            s if s.starts_with("--inline-cap=") => {
                let body = &s["--inline-cap=".len()..];
                match body.parse::<u32>() {
                    Ok(n) => inline_cap = n,
                    Err(_) => {
                        eprint_diagnostic(
                            "badc: error: --inline-cap=N requires a non-negative integer",
                        );
                        std::process::exit(1);
                    }
                }
            }
            // Register-allocator pressure caps, gated behind the
            // `codegen_test` feature. Each truncates one allocator
            // bank to N entries so the allocator spills as if the
            // target had fewer registers. The value is published
            // through the same `BADC_MAX_GPR` / `BADC_MAX_FPR`
            // environment variables the allocator reads. Setting an
            // environment variable is sound here: it runs during
            // argument parsing before any worker thread starts.
            #[cfg(feature = "codegen_test")]
            s if s.starts_with("--max-gpr=") || s.starts_with("--max-fpr=") => {
                let (flag, var) = if s.starts_with("--max-gpr=") {
                    ("--max-gpr=", "BADC_MAX_GPR")
                } else {
                    ("--max-fpr=", "BADC_MAX_FPR")
                };
                let body = &s[flag.len()..];
                match body.parse::<usize>() {
                    Ok(n) if n >= 1 => unsafe { std::env::set_var(var, n.to_string()) },
                    _ => {
                        eprint_diagnostic(format!("badc: error: {flag}N requires an integer >= 1"));
                        std::process::exit(1);
                    }
                }
            }
            "--debug" | "-g" => emit_debug_info = true,
            "--no-debug" | "-g0" => emit_debug_info = false,
            "--freestanding" => freestanding = true,
            "--jit" => claim(&mut mode, Mode::Jit),
            "--shared" => claim(&mut mode, Mode::SharedLibrary),
            "--ar" | "--archive" => claim(&mut mode, Mode::BuildArchive),
            "--dump-native-link" => claim(&mut mode, Mode::DumpNativeLink),
            "-h" | "--help" => {
                println!("{USAGE}");
                return;
            }
            "-v" | "--version" => {
                println!("{}", badc::BUILD_INFO);
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
            // gcc-shape `-Wdead-store` -- enable the per-store
            // dead-store diagnostic. `-Wno-dead-store` is the
            // opt-out spelling.
            "-Wdead-store" => warn_dead_store = true,
            "-Wno-dead-store" => warn_dead_store = false,
            // Quiet mode -- silence informational output (per-source
            // progress, `info: wrote file <path>` lines). Errors
            // and warnings remain on stderr unchanged.
            "-q" | "--quiet" => quiet = true,
            // Export every non-static function (dlopen/dlsym visibility).
            "--export-all" => export_all = true,
            // Export every defined non-static global (function and data)
            // into the executable's dynamic symbol table for `dlopen`
            // resolution.
            "--export-data" => export_data = true,
            // Define the GCC identity macros (`__GNUC__`, `__VERSION__`,
            // `__extension__`, ...). Off by default: badc implements
            // most but not all of the GNU C surface, so code that gates
            // a feature badc lacks (`__int128`) on `__GNUC__` keeps
            // compiling unless this is requested.
            "--gnu" => gnu = true,
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
            // `--entry=<sym>` fixes the image entry symbol at the link
            // step, so precompiled `.o` inputs need no `#pragma entrypoint`
            // stub. Mirrors the pragma but wins over it.
            s if s.starts_with("--entry=") => {
                cli_entry = Some(s["--entry=".len()..].to_string());
            }
            // `--subsystem=<kind>` selects the PE subsystem; kinds match
            // `#pragma subsystem(<kind>)`. Needed to stamp EFI application
            // / boot-service-driver / runtime-driver images built from
            // precompiled objects.
            s if s.starts_with("--subsystem=") => {
                let kind = &s["--subsystem=".len()..];
                cli_subsystem = Some(match kind {
                    "console" | "cui" => badc::Subsystem::Console,
                    "windows" | "gui" => badc::Subsystem::Windows,
                    "native" | "nt" | "driver" => badc::Subsystem::Native,
                    "efi_application" | "efi-application" => badc::Subsystem::EfiApplication,
                    "efi_boot_service_driver" | "efi-boot-service-driver" => {
                        badc::Subsystem::EfiBootServiceDriver
                    }
                    "efi_runtime_driver" | "efi-runtime-driver" => {
                        badc::Subsystem::EfiRuntimeDriver
                    }
                    "efi_rom" | "efi-rom" => badc::Subsystem::EfiRom,
                    _ => {
                        eprint_diagnostic(format!(
                            "badc: error: --subsystem=<kind>: unknown kind `{kind}`; expected \
                             one of console, windows, native, efi_application, \
                             efi_boot_service_driver, efi_runtime_driver, efi_rom"
                        ));
                        std::process::exit(1);
                    }
                });
            }
            // An unrecognised dash-prefixed token is an unknown option, not
            // a source file. Without this guard it falls through to `args`
            // and is classified by extension, becoming a phantom input path
            // (a misleading `cannot read` error, or -- worse -- silently
            // compiled if its text names an existing file). `-` alone is
            // the stdin source and is handled above.
            s if s.starts_with('-') && s != "-" => {
                eprint_diagnostic(format!("badc: error: unknown option `{s}`"));
                std::process::exit(1);
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
    // The `badc --install` overlay under ~/.badc (or $BADC_HOME) sits
    // between the repo-local overlays and the embedded headers: a user
    // without the source tree edits ~/.badc/include/<h> to override a
    // bundled header, and ~/.badc/lib joins the `-l` archive search.
    // Appended last so explicit -I / -L and the repo-local dirs win.
    if let Some(home) = badc_home() {
        for (sub, paths) in [("include", &mut include_paths), ("lib", &mut library_paths)] {
            let dir = home.join(sub);
            if dir.is_dir() {
                let s = dir.to_string_lossy().into_owned();
                if !paths.contains(&s) {
                    paths.push(s);
                }
            }
        }
    }

    let mode = mode.map(|(m, _)| m).unwrap_or(Mode::NativeExecutable);

    // `--install [<dir>]` copies the embedded headers + runtime source
    // to disk and exits. The destination is the first positional token
    // (`args[1]`), else ~/.badc. Dispatched before the compile paths:
    // it takes no source input.
    if mode == Mode::Install {
        let dir = match args.get(1).map(PathBuf::from).or_else(badc_home) {
            Some(d) => d,
            None => {
                eprint_diagnostic(
                    "badc: error: --install: no home directory -- set HOME / USERPROFILE / \
                     BADC_HOME or pass an explicit <dir>",
                );
                std::process::exit(1);
            }
        };
        match install_embedded(&dir) {
            Ok((headers, runtime)) => {
                if !quiet {
                    eprint_diagnostic(format!(
                        "info: installed {headers} header(s) + {runtime} runtime source(s) under {}",
                        dir.display()
                    ));
                }
            }
            Err(e) => {
                eprint_diagnostic(format!("badc: error: --install to {}: {e}", dir.display()));
                std::process::exit(1);
            }
        }
        return;
    }

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
            Mode::Interp | Mode::ListSymbols | Mode::DumpHeaders | Mode::Jit | Mode::DumpNativeLink
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

    if mode == Mode::DumpNativeLink {
        dump_native_link(&args[1..]);
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
    let mut prog_args_start: usize = args.len();
    // Program argv is consumed only by --jit / --interp; every other
    // mode links or preprocesses its inputs and has no argv tail.
    let takes_prog_args = matches!(mode, Mode::Jit | Mode::Interp);
    for (i, a) in args.iter().enumerate().skip(1) {
        if a == "-" {
            sources.push(a.clone());
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
                // In --jit / --interp the first unrecognised entry marks
                // the boundary; everything after it is the program's argv
                // (so `badc --jit foo.c arg1 arg2` still works). Every
                // other mode links or preprocesses its inputs and has no
                // argv, so an unrecognised extension is a mistyped or
                // unsupported input and is reported rather than silently
                // dropped along with every input after it.
                if takes_prog_args {
                    prog_args_start = i;
                    break;
                }
                eprint_diagnostic(format!(
                    "badc: error: unrecognized input file extension: `{a}` \
                     (expected a `.c` source, `.o` object, or `.a` archive)"
                ));
                std::process::exit(1);
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
    // and stdin isn't a terminal -- the `cat foo.c | badc`
    // pipeline.
    if sources.is_empty()
        && objects.is_empty()
        && archives.is_empty()
        && !std::io::stdin().is_terminal()
    {
        sources.push("-".to_string());
    }
    if sources.is_empty() && objects.is_empty() && archives.is_empty() {
        eprint_diagnostic("badc: error: no files");
        std::process::exit(1);
    }

    // Stdin is consumed exactly once. The `--dump-pp`, JIT / interp,
    // and native-link paths can each call `read_stdin_source()`;
    // cache the bytes in an Option so a second call sees the same
    // source instead of reading an empty stream off the drained pipe.
    let stdin_cache: std::cell::RefCell<Option<String>> = std::cell::RefCell::new(None);
    let read_stdin_source = || -> String {
        if let Some(s) = stdin_cache.borrow().as_ref() {
            return s.clone();
        }
        let mut s = String::new();
        if let Err(e) = std::io::stdin().read_to_string(&mut s) {
            eprint_diagnostic(format!("badc: error: error reading stdin: {e}"));
            std::process::exit(1);
        }
        *stdin_cache.borrow_mut() = Some(s.clone());
        s
    };

    // `--jit` / `--interp` run one translation unit in-process. There
    // is no link step: the first `.c` is the unit and must define
    // `main` and resolve every symbol it references on its own.
    if mode == Mode::Jit || mode == Mode::Interp {
        if !objects.is_empty() || !archives.is_empty() {
            eprint_diagnostic(format!(
                "badc: error: {} runs a single `.c` source and does not link \
                 object / archive inputs",
                mode.flag_name()
            ));
            std::process::exit(1);
        }
        let src_path = sources[0].clone();
        let contents = if src_path == "-" {
            read_stdin_source()
        } else {
            match std::fs::read_to_string(&src_path) {
                Ok(s) => s,
                Err(e) => {
                    eprint_diagnostic(format!("badc: error: cannot read `{src_path}`: {e}"));
                    std::process::exit(1);
                }
            }
        };
        let copts = badc::CompileOptions::default()
            .with_gnu(gnu)
            .with_optimize(optimize_flag)
            .with_defines(defines.clone())
            .with_undefines(undefines.clone())
            .with_include_paths(include_paths.clone())
            .with_force_includes(force_includes.clone())
            .with_source_label(src_path.clone())
            .with_show_includes(show_includes)
            .with_warn_dead_store(warn_dead_store);
        let mut compiler = Compiler::with_options(contents, target, copts);
        if show_includes {
            for line in compiler.take_include_trace() {
                eprintln!("{line}");
            }
        }
        let program = match compiler.compile() {
            Ok(p) => p,
            Err(e) => {
                eprint_diagnostic(e);
                std::process::exit(1);
            }
        };
        let stderr_is_tty = std::io::stderr().is_terminal();
        for w in &program.warnings {
            eprintln!("{}", colorize_diagnostic(w, stderr_is_tty));
        }
        // argv[0] is the unit path; argv[1..] are every following
        // input (extra `.c` paths the hosted program opens itself)
        // plus any trailing non-input tokens.
        let mut c_args: Vec<String> = sources.clone();
        if prog_args_start < args.len() {
            c_args.extend(args[prog_args_start..].iter().cloned());
        }
        if mode == Mode::Jit {
            // The JIT lowers for the host; --target plays no part.
            let mut jit_opts = NativeOptions::new().with_inline_cap(inline_cap);
            if optimize_flag {
                jit_opts = jit_opts.with_optimize();
            }
            match jit_run_with_options(&program, &c_args, jit_opts) {
                Ok(code) => std::process::exit(code),
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            }
        }
        let mut vm = Vm::new(program).with_args(c_args);
        if track_pointers {
            vm = vm.with_pointer_tracking();
        }
        if trace {
            vm = vm.with_trace();
        }
        match vm.run() {
            Ok(res) => {
                println!("exit({res})");
                std::process::exit(0);
            }
            Err(e) => {
                eprint_diagnostic(e);
                std::process::exit(1);
            }
        }
    }

    // `--dump-pp` / `-E` preprocesses each source to stdout and
    // exits: no link, no codegen, no output file. A multi-source
    // dump prefixes each unit with a `--- <label> ---` marker on
    // stderr so the preprocessed bytes on stdout stay parseable.
    if mode == Mode::DumpPp {
        let multi_tu = sources.len() > 1;
        for src_path in &sources {
            let (label, contents) = if src_path == "-" {
                ("-".to_string(), read_stdin_source())
            } else {
                match std::fs::read_to_string(src_path) {
                    Ok(s) => (src_path.clone(), s),
                    Err(e) => {
                        eprint_diagnostic(format!("badc: error: cannot read `{src_path}`: {e}"));
                        std::process::exit(1);
                    }
                }
            };
            let opts = badc::CompileOptions::default()
                .with_gnu(gnu)
                .with_optimize(optimize_flag)
                .with_defines(defines.clone())
                .with_undefines(undefines.clone())
                .with_include_paths(include_paths.clone())
                .with_force_includes(force_includes.clone())
                .with_source_label(label.clone());
            match Compiler::preprocess(contents, target, opts) {
                Ok(s) => {
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
        }
        return;
    }

    // The native-link path produces every executable and shared
    // library on every target: ELF for Linux, the MergedNative-to-
    // Build synthesizer for Mach-O / PE.
    //   .c sources -> Compiler::compile() -> ET_REL bytes
    //                                     -> parse_native_elf
    //   .o inputs  -> parse_native_elf
    //   .a inputs  -> read_archive -> per-member parse_native_elf
    // All collected NativeObjects feed link_native_objects, the
    // per-arch PLT pass, and write_native_image_from_merged. The
    // image carries DWARF (subprogram + variable + type DIEs ride
    // the merged per-`.o` `.debug_info`; `.debug_frame` regenerates),
    // variadic libc imports, `#pragma` exports, and `_Thread_local`
    // storage in each format's native shape: ELF PT_TLS, the PE TLS
    // directory + `_tls_index`, the Mach-O TLV descriptors. Mach-O
    // auto-codesigning lives in `post_write_native`. Only `--jit` /
    // `--interp` (handled above) and `-c` / `--ar` (below) stay out
    // of this path.
    if (mode == Mode::NativeExecutable || mode == Mode::SharedLibrary) && !compile_only {
        use badc::{Compiler, OutputKind};
        let mut native_objs: Vec<badc::NativeObject> =
            Vec::with_capacity(sources.len() + objects.len() + archives.len());

        let mut reloc_opts = badc::NativeOptions::new()
            .with_debug_info(emit_debug_info)
            .with_inline_cap(inline_cap);
        if optimize_flag {
            reloc_opts = reloc_opts.with_optimize();
        }
        if dump_ssa {
            reloc_opts = reloc_opts.with_dump_ssa();
        }
        reloc_opts.output_kind = OutputKind::Relocatable;
        // Per-source progress and diagnostics match the JIT / interp
        // paths: a multi-source build prints `info: compiling <path>`
        // per unit, the resolved `#include` trace under `-H`, and the
        // compiler's warnings (parser type-mismatch, AST validator,
        // dead-store) to stderr.
        let stderr_is_tty = std::io::stderr().is_terminal();
        let multi_tu = sources.len() > 1;
        // `.c` -> in-memory native ELF64 ET_REL: the source compiles
        // straight to ET_REL bytes that `parse_native_elf` reads back,
        // so no intermediate `.o` is written to disk.
        type CompiledUnit = (
            Vec<u8>,
            Option<String>,
            Option<badc::Subsystem>,
            Vec<String>,
        );
        let compile_one = |src_path: &str, implicit_externs: &[String]| -> CompiledUnit {
            if multi_tu && !quiet && implicit_externs.is_empty() {
                eprint_diagnostic(format!("info: compiling {src_path}"));
            }
            let src_bytes = if src_path == "-" {
                read_stdin_source()
            } else {
                match std::fs::read_to_string(src_path) {
                    Ok(b) => b,
                    Err(e) => {
                        eprint_diagnostic(format!("badc: error: cannot read `{src_path}`: {e}"));
                        std::process::exit(1);
                    }
                }
            };
            let copts = badc::CompileOptions::default()
                .with_gnu(gnu)
                .with_defines(defines.clone())
                .with_undefines(undefines.clone())
                .with_include_paths(include_paths.clone())
                .with_force_includes(force_includes.clone())
                .with_source_label(src_path.to_string())
                .with_show_includes(show_includes)
                .with_warn_dead_store(warn_dead_store)
                .with_optimize(optimize_flag)
                .with_export_all_functions(export_all)
                .with_implicit_extern_fns(implicit_externs.to_vec())
                .with_no_entry_point(true);
            let mut compiler = Compiler::with_options(src_bytes, target, copts);
            if show_includes {
                for line in compiler.take_include_trace() {
                    eprintln!("{line}");
                }
            }
            let program = match compiler.compile() {
                Ok(p) => p,
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            };
            for w in &program.warnings {
                eprintln!("{}", colorize_diagnostic(w, stderr_is_tty));
            }
            // Prefer the literal `#pragma entrypoint(<name>)` over the
            // in-TU-resolved `entry_name`: in a multi-TU freestanding link
            // the named entry symbol is often defined in a different TU
            // than the one carrying the pragma, so `entry_name` is `None`
            // here while the pragma still fixes the image entry. The
            // freestanding defined-symbol check below verifies the symbol
            // exists across all inputs at link time.
            let entry = program
                .entry_pragma
                .clone()
                .or_else(|| program.entry_name.clone());
            let subsystem = program.subsystem;
            let auto_includes = program.auto_includes.clone();
            match badc::emit_native_with_options(&program, target, reloc_opts) {
                Ok(b) => (b, entry, subsystem, auto_includes),
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            }
        };
        // In-memory variant for the embedded runtime sources
        // below: same compile + emit chain, no filesystem read.
        let compile_in_memory = |label: &str, src: String, extra: &[(&str, &str)]| -> Vec<u8> {
            // The embedded runtime gates its sections on macros the
            // driver sets per image: `__BADC_C5_CRT__` (the image may
            // import the user-mode C library), `__BADC_C5_START__`
            // (an entry stub is emitted), `__BADC_WIN_WINMAIN__`
            // (WinMain-shaped entry), `__BADC_WIN_WIDE__` (wide
            // `wmain` / `wWinMain` entry).
            let mut copts_defines = defines.clone();
            for (k, v) in extra {
                copts_defines.push((k.to_string(), v.to_string()));
            }
            let copts = badc::CompileOptions::default()
                .with_gnu(gnu)
                .with_optimize(optimize_flag)
                .with_defines(copts_defines)
                .with_undefines(undefines.clone())
                .with_include_paths(include_paths.clone())
                .with_force_includes(force_includes.clone())
                .with_source_label(label.to_string())
                .with_no_entry_point(true);
            let program = match Compiler::with_options(src, target, copts).compile() {
                Ok(p) => p,
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            };
            match badc::emit_native_with_options(&program, target, reloc_opts) {
                Ok(b) => b,
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            }
        };
        // `#pragma entrypoint(<name>)` overrides the default
        // `main`. The pragma is per-TU; the first TU that
        // surfaces a non-default entry wins. C99 leaves the
        // hosted-environment entry-point name to implementations
        // (5.1.2.2.1), so the standard doesn't pick between
        // multi-TU pragmas.
        // A CLI `--entry=` / `--subsystem=` seeds the override and wins
        // over any per-TU pragma (the loop below only fills a `None`).
        // This is also the sole source of an entry / subsystem when the
        // inputs are precompiled `.o` files with no source pragma.
        let mut entry_override: Option<String> = cli_entry.clone();
        // `#pragma subsystem(<kind>)` selects the Windows PE subsystem.
        // Like the entry pragma it is per-TU; the first TU that names
        // one wins. Captured here from the compiled `Program` because
        // the ET_REL round-trip the native path takes does not carry
        // it (the source-level pragma rides the in-memory `Program`,
        // not a section), then threaded to the PE writer.
        let mut subsystem_override: Option<badc::Subsystem> = cli_subsystem;
        let mut source_auto_includes: Vec<Vec<String>> = Vec::with_capacity(sources.len());
        for src_path in &sources {
            let (bytes, entry, subsystem, auto_includes) = compile_one(src_path, &[]);
            if entry_override.is_none() {
                entry_override = entry;
            }
            if subsystem_override.is_none() {
                subsystem_override = subsystem;
            }
            source_auto_includes.push(auto_includes);
            match badc::parse_native_elf(&bytes) {
                Ok(o) => native_objs.push(o),
                Err(e) => {
                    eprint_diagnostic(format!("badc: {src_path}: {e}"));
                    std::process::exit(1);
                }
            }
        }
        // `--freestanding` drops the embedded startup runtime: the
        // program's own entry becomes the image entry and the entry
        // adapter resolves to it. A freestanding build is requested only
        // by the flag. A program that merely defines `__c5_entry`
        // without the flag keeps the runtime, so its definition collides
        // with the runtime's `__c5_entry` -- a duplicate-symbol link
        // error rather than a silent switch to a freestanding image.
        //
        // Without an explicit `#pragma entrypoint`, a freestanding image
        // enters at `__c5_entry` (the default `main` need not exist).
        if freestanding && entry_override.is_none() {
            entry_override = Some("__c5_entry".to_string());
        }
        // A freestanding image must supply its own entry symbol; the
        // embedded runtime that would otherwise define `__c5_entry` is
        // not linked. The entry may come from any input -- a compiled
        // source, a `.o`, or an archive member -- so the defined-entry
        // check runs below, after objects and archive members are
        // parsed, rather than as a bare undefined-symbol relocation at
        // link time.
        let freestanding_entry = freestanding.then(|| {
            entry_override
                .as_deref()
                .unwrap_or("__c5_entry")
                .to_string()
        });
        // The runtime's CRT section (the C99 snprintf / vsnprintf
        // definitions on Windows) links into any image that may
        // import the user-mode C library -- hosted executables and
        // shared libraries, but not passthrough-entry subsystems
        // (native / EFI) or freestanding images.
        let links_crt = !freestanding
            && !matches!(
                subsystem_override,
                Some(
                    badc::Subsystem::Native
                        | badc::Subsystem::EfiApplication
                        | badc::Subsystem::EfiBootServiceDriver
                        | badc::Subsystem::EfiRuntimeDriver
                        | badc::Subsystem::EfiRom
                )
            );
        // The startup section (`__c5_entry`, `__c5_exit`, `environ`)
        // links only when the writer emits an entry stub -- not into
        // shared libraries.
        let emits_start_stub = mode != Mode::SharedLibrary && links_crt;
        // The single runtime source compiles to nothing unless a gate
        // macro is set; the GUI / wide-entry macros select the
        // matching `__c5_entry` body on Windows.
        let mut runtime_defines: Vec<(&str, &str)> = Vec::new();
        if links_crt {
            runtime_defines.push(("__BADC_C5_CRT__", "1"));
        }
        if emits_start_stub {
            runtime_defines.push(("__BADC_C5_START__", "1"));
            // `__c5_entry` calls this symbol; default `main`,
            // overridden by `#pragma entrypoint`.
            runtime_defines.push((
                "__BADC_ENTRY__",
                entry_override.as_deref().unwrap_or("main"),
            ));
            // The entry shape follows the entry symbol, not the PE
            // subsystem (set separately on the optional header): a
            // GUI-subsystem program with a plain `main` still receives
            // argc/argv. WinMain / wWinMain take the (hInstance, prev,
            // cmdline, nShow) shape; wmain / wWinMain take the wide form.
            match entry_override.as_deref() {
                Some("WinMain") => runtime_defines.push(("__BADC_WIN_WINMAIN__", "1")),
                Some("wWinMain") => {
                    runtime_defines.push(("__BADC_WIN_WINMAIN__", "1"));
                    runtime_defines.push(("__BADC_WIN_WIDE__", "1"));
                }
                Some("wmain") => runtime_defines.push(("__BADC_WIN_WIDE__", "1")),
                _ => {}
            }
        }
        // Prefer an installed runtime source (~/.badc/lib/<name>) over the
        // embedded copy, mirroring the header overlay: `badc --install`
        // writes it there and editing it overrides the built-in runtime.
        let runtime_dir = badc_home().map(|h| h.join("lib"));
        for (name, body) in badc::embedded_runtime().iter() {
            let (label, src) = match runtime_dir.as_ref().map(|d| d.join(name)) {
                Some(p) if p.is_file() => match std::fs::read_to_string(&p) {
                    Ok(s) => (p.display().to_string(), s),
                    Err(e) => {
                        eprint_diagnostic(format!(
                            "badc: error: cannot read installed runtime {}: {e}",
                            p.display()
                        ));
                        std::process::exit(1);
                    }
                },
                _ => (format!("<runtime/{name}>"), body.to_string()),
            };
            let bytes = compile_in_memory(&label, src, &runtime_defines);
            match badc::parse_native_elf(&bytes) {
                Ok(o) => native_objs.push(o),
                Err(e) => {
                    eprint_diagnostic(format!("badc: {label}: {e}"));
                    std::process::exit(1);
                }
            }
        }
        for obj_path in &objects {
            let bytes = match std::fs::read(obj_path) {
                Ok(b) => b,
                Err(e) => {
                    eprint_diagnostic(format!("badc: error: cannot read `{obj_path}`: {e}"));
                    std::process::exit(1);
                }
            };
            if !badc::is_elf_object(&bytes) {
                eprint_diagnostic(format!(
                    "badc: error: `{obj_path}` is not a native ELF object; \
                     only the ELF format is supported"
                ));
                std::process::exit(1);
            }
            match badc::parse_native_elf(&bytes) {
                Ok(o) => native_objs.push(o),
                Err(e) => {
                    eprint_diagnostic(format!("badc: {obj_path}: {e}"));
                    std::process::exit(1);
                }
            }
        }
        // Archive members join the link on demand: a member is
        // included iff it defines a symbol some already-included
        // object still leaves undefined, iterated to a fixpoint so a
        // pulled member's own references can pull further members
        // (from any archive). Unreferenced members stay out, so their
        // unrelated undefined or duplicate symbols cannot fail a
        // valid link.
        let mut pending: Vec<(String, badc::NativeObject)> = Vec::new();
        for a_path in &archives {
            let bytes = match std::fs::read(a_path) {
                Ok(b) => b,
                Err(e) => {
                    eprint_diagnostic(format!("badc: error: cannot read `{a_path}`: {e}"));
                    std::process::exit(1);
                }
            };
            let members = match badc::read_archive(&bytes) {
                Ok(m) => m,
                Err(e) => {
                    eprint_diagnostic(format!("badc: {a_path}: {e}"));
                    std::process::exit(1);
                }
            };
            for m in members {
                if !badc::is_elf_object(&m.bytes) {
                    eprint_diagnostic(format!(
                        "badc: error: archive `{a_path}` member `{}` is not a native ELF object",
                        m.name
                    ));
                    std::process::exit(1);
                }
                match badc::parse_native_elf(&m.bytes) {
                    Ok(o) => pending.push((format!("{a_path}({})", m.name), o)),
                    Err(e) => {
                        eprint_diagnostic(format!("badc: {a_path}({}): {e}", m.name));
                        std::process::exit(1);
                    }
                }
            }
        }
        // C89 6.3.2.2 link semantics: a definition anywhere in the
        // link set satisfies an implicitly declared call, so a name
        // the auto-include retry bound to a header's library binding
        // is recompiled as an implicit extern when an input defines
        // it -- the user's definition wins over the binding.
        if source_auto_includes.iter().any(|a| !a.is_empty()) {
            let mut defined_fns = std::collections::HashSet::<String>::new();
            for o in native_objs.iter().chain(pending.iter().map(|(_, o)| o)) {
                for s in &o.symbols {
                    // STB_GLOBAL STT_FUNC section-resident definitions.
                    if s.binding == 1
                        && s.kind == 2
                        && !matches!(
                            s.section,
                            badc::NativeSymSection::Undef | badc::NativeSymSection::Abs
                        )
                    {
                        defined_fns.insert(s.name.clone());
                    }
                }
            }
            for (i, autos) in source_auto_includes.iter().enumerate() {
                let redirect: Vec<String> = autos
                    .iter()
                    .filter(|n| defined_fns.contains(n.as_str()))
                    .cloned()
                    .collect();
                if redirect.is_empty() {
                    continue;
                }
                if !quiet {
                    for n in &redirect {
                        eprint_diagnostic(format!(
                            "info: the link defines `{n}`; rebinding the call in {} to it",
                            sources[i]
                        ));
                    }
                }
                let (bytes, _, _, _) = compile_one(&sources[i], &redirect);
                match badc::parse_native_elf(&bytes) {
                    Ok(o) => native_objs[i] = o,
                    Err(e) => {
                        eprint_diagnostic(format!("badc: {}: {e}", sources[i]));
                        std::process::exit(1);
                    }
                }
            }
        }
        if !pending.is_empty() {
            let mut defined = std::collections::HashSet::<String>::new();
            let mut undefined = std::collections::HashSet::<String>::new();
            // A global or weak definition satisfies references; only a
            // strong (STB_GLOBAL) undefined reference pulls a member,
            // matching ELF archive practice (a weak reference left
            // unresolved does not extract members).
            let account =
                |o: &badc::NativeObject,
                 defined: &mut std::collections::HashSet<String>,
                 undefined: &mut std::collections::HashSet<String>| {
                    for s in &o.symbols {
                        if s.binding == 0 {
                            continue;
                        }
                        if s.section == badc::NativeSymSection::Undef {
                            if s.binding == 1 && !defined.contains(&s.name) {
                                undefined.insert(s.name.clone());
                            }
                        } else {
                            defined.insert(s.name.clone());
                            undefined.remove(&s.name);
                        }
                    }
                };
            for o in &native_objs {
                account(o, &mut defined, &mut undefined);
            }
            // A freestanding entry is a link root: seed it as undefined
            // so an archive member that only defines the entry is pulled.
            if let Some(entry) = &freestanding_entry
                && !defined.contains(entry)
            {
                undefined.insert(entry.clone());
            }
            // The archive symbol index lists strong section-resident
            // definitions; a member is pulled on exactly those.
            let mut progress = true;
            while progress {
                progress = false;
                let mut i = 0;
                while i < pending.len() {
                    let wanted = pending[i].1.symbols.iter().any(|s| {
                        s.binding == 1
                            && !matches!(
                                s.section,
                                badc::NativeSymSection::Undef | badc::NativeSymSection::Abs
                            )
                            && undefined.contains(&s.name)
                    });
                    if wanted {
                        let (_, o) = pending.remove(i);
                        account(&o, &mut defined, &mut undefined);
                        native_objs.push(o);
                        progress = true;
                    } else {
                        i += 1;
                    }
                }
            }
        }
        if native_objs.is_empty() {
            eprint_diagnostic("badc: error: no inputs");
            std::process::exit(1);
        }
        // With every source, object, and pulled archive member now
        // parsed, a freestanding image's entry must be defined.
        if let Some(entry) = &freestanding_entry {
            let defined = native_objs.iter().any(|o| {
                o.symbols
                    .iter()
                    .any(|s| s.name == *entry && s.section == badc::NativeSymSection::Text)
            });
            if !defined {
                eprint_diagnostic(format!(
                    "badc: error: --freestanding: image entry `{entry}` is not defined; \
                     a freestanding image must provide its own entry point"
                ));
                std::process::exit(1);
            }
        }
        // Every supported target lays out `_Thread_local` storage
        // through the native path: ELF PT_TLS, the PE TLS directory +
        // `_tls_index` note, and the Mach-O TLV descriptors + fixups
        // note.
        // A shared library may reference symbols the host executable
        // supplies at `dlopen` time; let an unresolved global become a
        // load-time import instead of a link error.
        let allow_undefined = mode == Mode::SharedLibrary;
        let mut merged = match badc::link_native_objects_with_options(&native_objs, allow_undefined)
        {
            Ok(m) => m,
            Err(e) => {
                eprint_diagnostic(format!("badc: {e}"));
                std::process::exit(1);
            }
        };
        let plt = match merged.machine {
            badc::NativeMachine::X86_64 => badc::emit_x86_64_plt(&mut merged),
            badc::NativeMachine::Aarch64 => badc::emit_aarch64_plt(&mut merged),
        };
        let plt = match plt {
            Ok(p) => p,
            Err(e) => {
                eprint_diagnostic(format!("badc: {e}"));
                std::process::exit(1);
            }
        };
        let entry_name = entry_override.as_deref().unwrap_or("main");
        let native_output_kind = if mode == Mode::SharedLibrary {
            OutputKind::SharedLibrary
        } else {
            OutputKind::Executable
        };
        // A shared library records its own name so a consumer that links
        // against it by name (PE export-directory Name, Mach-O
        // LC_ID_DYLIB install name) references the file it loads at
        // runtime. Use the `-o` basename, or the default output name when
        // `-o` is absent.
        let shared_default_path;
        let shared_lib_name: Option<&str> = if native_output_kind == OutputKind::SharedLibrary {
            let path: &std::path::Path = match output_path.as_deref() {
                Some(o) => o,
                None => {
                    shared_default_path = default_output_path(
                        sources.first().map(|s| s.as_str()).unwrap_or("a"),
                        target,
                        mode,
                    );
                    &shared_default_path
                }
            };
            path.file_name().and_then(|n| n.to_str())
        } else {
            None
        };
        let write_result = badc::write_native_image_from_merged_ex(
            &merged,
            &plt,
            entry_name,
            subsystem_override,
            native_output_kind,
            target,
            shared_lib_name,
            export_all,
            export_data,
        );
        let bytes = match write_result {
            Ok(b) => b,
            Err(e) => {
                eprint_diagnostic(format!("badc: {e}"));
                std::process::exit(1);
            }
        };
        let default_path;
        let out: &std::path::Path = match output_path.as_deref() {
            Some(o) => o,
            None => {
                default_path = default_output_path(
                    sources.first().map(|s| s.as_str()).unwrap_or("a"),
                    target,
                    mode,
                );
                &default_path
            }
        };
        write_output(out, &bytes, target, quiet);
        set_executable(out);
        post_write_native(out, target);
        return;
    }

    // `-c` / `--compile-only`: compile each `.c` source to a native
    // ELF64 ET_REL object on disk and exit. Archive / `-l` inputs
    // aren't meaningful here -- the caller is asking for the per-
    // source object emit, not a link.
    if compile_only {
        if !archives.is_empty() || !lib_names.is_empty() {
            eprintln!(
                "badc: -c is incompatible with archive inputs / -l flags \
                 (object emit doesn't involve linking)"
            );
            std::process::exit(1);
        }
        if sources.is_empty() {
            eprint_diagnostic("badc: error: -c requires at least one source input");
            std::process::exit(1);
        }
        let source_count = sources.len();
        // Relocatable `-c` builds do not require `main`; the linker
        // picks the entry once it merges every TU.
        use badc::{Compiler, OutputKind};
        let mut reloc_opts = badc::NativeOptions::new()
            .with_debug_info(emit_debug_info)
            .with_inline_cap(inline_cap);
        if optimize_flag {
            reloc_opts = reloc_opts.with_optimize();
        }
        if dump_ssa {
            reloc_opts = reloc_opts.with_dump_ssa();
        }
        reloc_opts.output_kind = OutputKind::Relocatable;
        let stderr_is_tty = std::io::stderr().is_terminal();
        let multi_tu = source_count > 1;
        let compile_one = |src_path: &str| -> Vec<u8> {
            if multi_tu && !quiet {
                eprint_diagnostic(format!("info: compiling {src_path}"));
            }
            let src_bytes = match std::fs::read_to_string(src_path) {
                Ok(b) => b,
                Err(e) => {
                    eprint_diagnostic(format!("badc: error: cannot read `{src_path}`: {e}"));
                    std::process::exit(1);
                }
            };
            let copts = badc::CompileOptions::default()
                .with_gnu(gnu)
                .with_defines(defines.clone())
                .with_undefines(undefines.clone())
                .with_include_paths(include_paths.clone())
                .with_force_includes(force_includes.clone())
                .with_source_label(src_path.to_string())
                .with_show_includes(show_includes)
                .with_warn_dead_store(warn_dead_store)
                .with_optimize(optimize_flag)
                .with_no_entry_point(true);
            let mut compiler = Compiler::with_options(src_bytes, target, copts);
            if show_includes {
                for line in compiler.take_include_trace() {
                    eprintln!("{line}");
                }
            }
            let program = match compiler.compile() {
                Ok(p) => p,
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            };
            for w in &program.warnings {
                eprintln!("{}", colorize_diagnostic(w, stderr_is_tty));
            }
            warn_dropped_link_pragmas(&program, src_path);
            match badc::emit_native_with_options(&program, target, reloc_opts) {
                Ok(b) => b,
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            }
        };
        if let Some(out) = output_path.as_deref() {
            if source_count != 1 {
                eprintln!(
                    "badc: `-o <path>` together with `-c` requires exactly one \
                     `.c` input ({} given)",
                    source_count
                );
                std::process::exit(1);
            }
            let bytes = compile_one(&sources[0]);
            write_output(out, &bytes, target, quiet);
        } else {
            for src_path in sources.iter().take(source_count) {
                let p = std::path::Path::new(src_path);
                let out = p.with_extension("o");
                let bytes = compile_one(src_path);
                write_output(&out, &bytes, target, quiet);
            }
        }
        return;
    }

    // `--ar` mode: bundle each `.c` input (compiled to native
    // ELF64 ET_REL) plus any passed-in `.o` into a single
    // SysV `ar` archive named by `-o`. Member bytes are the
    // exact same blob `-c` would have written to disk; the
    // SysV symbol index lists every `STB_GLOBAL`-defined name
    // so the linker's archive pull-in can resolve undefined
    // references without re-parsing each member.
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
        let total_inputs = sources.len() + objects.len();
        if total_inputs == 0 {
            eprint_diagnostic("badc: error: --ar requires at least one input");
            std::process::exit(1);
        }
        use badc::{Compiler, OutputKind};
        let mut reloc_opts = badc::NativeOptions::new()
            .with_debug_info(emit_debug_info)
            .with_inline_cap(inline_cap);
        if optimize_flag {
            reloc_opts = reloc_opts.with_optimize();
        }
        if dump_ssa {
            reloc_opts = reloc_opts.with_dump_ssa();
        }
        reloc_opts.output_kind = OutputKind::Relocatable;
        let stderr_is_tty = std::io::stderr().is_terminal();
        let multi_tu = sources.len() > 1;
        let compile_one = |src_path: &str| -> Vec<u8> {
            if multi_tu && !quiet {
                eprint_diagnostic(format!("info: compiling {src_path}"));
            }
            let src_bytes = match std::fs::read_to_string(src_path) {
                Ok(b) => b,
                Err(e) => {
                    eprint_diagnostic(format!("badc: error: cannot read `{src_path}`: {e}"));
                    std::process::exit(1);
                }
            };
            let copts = badc::CompileOptions::default()
                .with_gnu(gnu)
                .with_defines(defines.clone())
                .with_undefines(undefines.clone())
                .with_include_paths(include_paths.clone())
                .with_force_includes(force_includes.clone())
                .with_source_label(src_path.to_string())
                .with_show_includes(show_includes)
                .with_warn_dead_store(warn_dead_store)
                .with_optimize(optimize_flag)
                .with_no_entry_point(true);
            let mut compiler = Compiler::with_options(src_bytes, target, copts);
            if show_includes {
                for line in compiler.take_include_trace() {
                    eprintln!("{line}");
                }
            }
            let program = match compiler.compile() {
                Ok(p) => p,
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            };
            for w in &program.warnings {
                eprintln!("{}", colorize_diagnostic(w, stderr_is_tty));
            }
            warn_dropped_link_pragmas(&program, src_path);
            match badc::emit_native_with_options(&program, target, reloc_opts) {
                Ok(b) => b,
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            }
        };
        let mut members: Vec<badc::ArchiveMember> = Vec::with_capacity(total_inputs);
        let mut sym_index: Vec<(usize, Vec<String>)> = Vec::with_capacity(total_inputs);
        // Member name comes from the input path's file stem
        // with a `.o` suffix -- mirrors how a regular `-c`
        // invocation would name the per-source output.
        for (i, src_path) in sources.iter().enumerate() {
            let base = std::path::Path::new(src_path)
                .file_stem()
                .map(|s| s.to_string_lossy().into_owned())
                .unwrap_or_else(|| format!("tu{i}"));
            let bytes = compile_one(src_path);
            let defined = native_defined_globals(&bytes, src_path);
            sym_index.push((members.len(), defined));
            members.push(badc::ArchiveMember {
                name: format!("{base}.o"),
                bytes,
            });
        }
        for (i, obj_path) in objects.iter().enumerate() {
            let base = std::path::Path::new(obj_path)
                .file_stem()
                .map(|s| s.to_string_lossy().into_owned())
                .unwrap_or_else(|| format!("obj{i}"));
            let bytes = match std::fs::read(obj_path) {
                Ok(b) => b,
                Err(e) => {
                    eprint_diagnostic(format!("badc: error: cannot read `{obj_path}`: {e}"));
                    std::process::exit(1);
                }
            };
            if !badc::is_elf_object(&bytes) {
                eprint_diagnostic(format!(
                    "badc: error: `{obj_path}` is not a native ELF object; \
                     only the ELF format is supported"
                ));
                std::process::exit(1);
            }
            let defined = native_defined_globals(&bytes, obj_path);
            sym_index.push((members.len(), defined));
            members.push(badc::ArchiveMember {
                name: format!("{base}.o"),
                bytes,
            });
        }
        let blob = badc::write_archive(&members, &sym_index);
        write_output(&out_path, &blob, target, quiet);
        return;
    }

    // Every CLI mode is dispatched and returns above: --jit / --interp,
    // --list-symbols / --dump-headers / --dump-native-link, --dump-pp,
    // the native-link path (executable / shared library), `-c`, and
    // `--ar`. Reaching here means a mode was added without a handler.
    unreachable!("every CLI mode is handled and returns above");
}

/// Print `msg` to stderr through `colorize_diagnostic`, deciding
/// once whether stderr is a TTY. Use for any user-visible error or
/// warning the CLI emits -- it's a no-op for messages that don't
/// look like a diagnostic, so plain "badc: file not found" lines
/// pass through unchanged.
/// Enumerate the `STB_GLOBAL`-defined symbol names from a
/// native ELF64 ET_REL blob. Used to populate the SysV `ar`
/// symbol index when `--ar` bundles native objects: any name
/// listed here resolves -- via the archive's `/` member -- to
/// the containing member's file offset, which is how the
/// linker's archive pull-in decides which members to load.
fn native_defined_globals(bytes: &[u8], path: &str) -> Vec<String> {
    let obj = match badc::parse_native_elf(bytes) {
        Ok(o) => o,
        Err(e) => {
            eprint_diagnostic(format!("badc: {path}: {e}"));
            std::process::exit(1);
        }
    };
    obj.symbols
        .into_iter()
        .filter(|s| {
            // STB_GLOBAL = 1; only section-resident defs are
            // visible at archive-pull-in time.
            s.binding == 1
                && !matches!(
                    s.section,
                    badc::NativeSymSection::Undef | badc::NativeSymSection::Abs
                )
        })
        .map(|s| s.name)
        .collect()
}

/// `#pragma entrypoint` / `#pragma subsystem` ride the in-memory
/// `Program` of the invocation that links; an ET_REL object carries
/// neither. Warn when a relocatable emit drops them so the TU is
/// recompiled in the link invocation instead of silently producing a
/// console-subsystem / default-entry image.
fn warn_dropped_link_pragmas(program: &badc::Program, src_path: &str) {
    let mut dropped: Vec<&str> = Vec::new();
    if program.entry_pragma.is_some() {
        dropped.push("entrypoint");
    }
    if program.subsystem.is_some() {
        dropped.push("subsystem");
    }
    for p in dropped {
        eprint_diagnostic(format!(
            "{src_path}: warning: `#pragma {p}(...)` is not carried by an object \
             file; compile this source in the link invocation for it to take effect"
        ));
    }
}

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
    // A stdin source ("-") has no usable base name; a literal `-.bin`
    // both reads as a leading-dash path to downstream tools (codesign)
    // and is opaque, so fall back to the conventional `a` base.
    let source = if source == "-" { "a" } else { source };
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
/// Write `bytes` to `out`, exit on failure, log
/// `info: wrote file <path>` on success unless `quiet` is set.
/// Used by every output path -- object emit, archive emit, JIT
/// binary emit, native-binary emit -- so the chatter is uniform.
/// Routes the info line through `eprint_diagnostic` so the
/// severity word picks up the green TTY color.
fn write_output(out: &std::path::Path, bytes: &[u8], target: Target, quiet: bool) {
    if let Err(e) = std::fs::write(out, bytes) {
        eprint_diagnostic(format!(
            "badc: error: failed to write {}: {e}",
            out.display()
        ));
        std::process::exit(1);
    }
    if !quiet {
        eprint_diagnostic(format!(
            "info: wrote file {} for target {}",
            out.display(),
            target.id_str()
        ));
    }
}

/// Post-write hooks for the native image: codesign Mach-O on macOS
/// hosts so dyld accepts the binary, and surface a per-target
/// reminder when the produced image's target doesn't match the
/// running host.
fn post_write_native(out: &std::path::Path, target: Target) {
    match target {
        Target::MacOSAarch64 => {
            #[cfg(target_os = "macos")]
            codesign(out);
            #[cfg(not(target_os = "macos"))]
            {
                let _ = out;
                eprint_diagnostic(
                    "info: produced a Mach-O on a non-macOS host; copy to macOS \
                     and `codesign --sign - <path>` before running.",
                );
            }
        }
        Target::LinuxAarch64 => {
            let _ = out;
            #[cfg(not(all(target_os = "linux", target_arch = "aarch64")))]
            eprint_diagnostic(
                "info: produced a Linux/aarch64 ELF on a different host. It won't run here",
            );
        }
        Target::LinuxX64 => {
            let _ = out;
            #[cfg(not(all(target_os = "linux", target_arch = "x86_64")))]
            eprint_diagnostic(
                "info: produced a Linux/x86_64 ELF on a different host. It won't run here",
            );
        }
        Target::WindowsX64 => {
            let _ = out;
            #[cfg(not(all(target_os = "windows", target_arch = "x86_64")))]
            eprint_diagnostic(
                "info: produced a Windows/x86_64 PE on a different host. It won't run here",
            );
        }
        Target::WindowsAarch64 => {
            let _ = out;
            #[cfg(not(all(target_os = "windows", target_arch = "aarch64")))]
            eprint_diagnostic(
                "info: produced a Windows/AArch64 PE on a different host. It won't run here",
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
    // `--` terminates option parsing so an output path that begins with
    // `-` is treated as a path, not a flag. A signing failure is fatal:
    // an unsigned Mach-O is rejected by dyld, so reporting success would
    // hand back an unrunnable binary.
    let status = std::process::Command::new(CODESIGN)
        .args(["--sign", "-", "--force", "--"])
        .arg(path)
        .status();
    match status {
        Ok(s) if s.success() => {}
        Ok(s) => {
            eprint_diagnostic(format!(
                "badc: error: codesign exited with status {s}; the macOS binary won't run"
            ));
            std::process::exit(1);
        }
        Err(e) => {
            eprint_diagnostic(format!("badc: error: failed to invoke {CODESIGN}: {e}"));
            std::process::exit(1);
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
/// `--dump-native-link`: parse a list of native ELF `.o` files
/// produced by `-c`, merge them via
/// `link_native_objects`, and print a summary. Useful for
/// validating the relocatable .o pipeline end-to-end before the
/// ET_EXEC writer for `MergedNative` lands. Args are taken
/// verbatim from the command line minus the leading executable
/// name; non-flag positional args are treated as `.o` paths.
fn dump_native_link(rest: &[String]) {
    let paths: Vec<&str> = rest
        .iter()
        .filter(|a| !a.starts_with("--") && *a != "--dump-native-link")
        .map(|s| s.as_str())
        .collect();
    if paths.is_empty() {
        eprintln!("badc: --dump-native-link requires one or more `.o` paths");
        std::process::exit(1);
    }
    let mut objs: Vec<badc::NativeObject> = Vec::with_capacity(paths.len());
    for p in &paths {
        let bytes = match std::fs::read(p) {
            Ok(b) => b,
            Err(e) => {
                eprintln!("badc: --dump-native-link: cannot read `{p}`: {e}");
                std::process::exit(1);
            }
        };
        if !badc::is_elf_object(&bytes) {
            eprintln!("badc: --dump-native-link: `{p}` is not an ELF object");
            std::process::exit(1);
        }
        match badc::parse_native_elf(&bytes) {
            Ok(o) => objs.push(o),
            Err(e) => {
                eprintln!("badc: --dump-native-link: {p}: {e}");
                std::process::exit(1);
            }
        }
    }
    let mut merged = match badc::link_native_objects(&objs) {
        Ok(m) => m,
        Err(e) => {
            eprintln!("badc: --dump-native-link: {e}");
            std::process::exit(1);
        }
    };
    println!("MergedNative:");
    println!("  machine     = {:?}", merged.machine);
    println!("  .text size  = {}", merged.text.len());
    println!("  .data size  = {}", merged.data.len());
    println!("  .bss size   = {}", merged.bss_size);
    println!("  defined     = {}", merged.defined.len());
    for (name, sym) in &merged.defined {
        println!(
            "    {name} @ {:?} +{:#x} size={:#x}",
            sym.section, sym.value, sym.size
        );
    }
    println!("  imports     = {}", merged.imports.len());
    for (i, name) in merged.imports.iter().enumerate() {
        println!("    [{i}] {name}");
    }
    println!("  pending     = {} reloc(s)", merged.pending_imports.len());
    for r in &merged.pending_imports {
        let name = if r.import_index == usize::MAX {
            "<data-ref>"
        } else {
            merged.imports[r.import_index].as_str()
        };
        println!(
            "    text[{:#x}] -> {name} (rtype={:#x}, addend={})",
            r.text_offset, r.rtype, r.addend
        );
    }
    // Per-arch PLT lowering pass. The trampoline shape differs
    // between targets (six-byte JMP rip-rel on x86_64, twelve-
    // byte adrp+ldr+br on aarch64), but the link-side
    // contract is identical: append one trampoline per unique
    // import, patch each call-site to reach it.
    let plt_result = match merged.machine {
        badc::NativeMachine::X86_64 => badc::emit_x86_64_plt(&mut merged),
        badc::NativeMachine::Aarch64 => badc::emit_aarch64_plt(&mut merged),
    };
    match plt_result {
        Ok(tramps) => {
            println!("  PLT tramps  = {} entry(ies)", tramps.len());
            for t in &tramps {
                let name = &merged.imports[t.import_index];
                println!("    text[{:#x}] -> {name}", t.text_offset);
            }
            println!("  post-PLT .text size = {}", merged.text.len());
        }
        Err(e) => {
            eprintln!("badc: --dump-native-link: PLT lowering failed: {e}");
        }
    }
}

/// The badc home directory: `$BADC_HOME` if set, else `~/.badc`
/// (`$HOME` on Unix, `%USERPROFILE%` on Windows). `None` when none of
/// those is set. Drives both the `--install` default destination and
/// the on-disk header / runtime overlay the compile paths consult.
fn badc_home() -> Option<PathBuf> {
    if let Some(h) = std::env::var_os("BADC_HOME") {
        return Some(PathBuf::from(h));
    }
    let home = std::env::var_os("HOME").or_else(|| std::env::var_os("USERPROFILE"))?;
    Some(PathBuf::from(home).join(".badc"))
}

/// Write every embedded header under `dir/include` and every embedded
/// runtime source under `dir/lib`, recreating the source hierarchy
/// (e.g. `dir/include/sys/socket.h`). Returns the (headers, runtime)
/// counts. Existing files are overwritten so a re-install refreshes a
/// stale tree.
fn install_embedded(dir: &std::path::Path) -> std::io::Result<(usize, usize)> {
    fn write_tree<'a>(
        root: &std::path::Path,
        entries: impl Iterator<Item = &'a (&'a str, &'a str)>,
    ) -> std::io::Result<usize> {
        let mut n = 0;
        for (name, body) in entries {
            let dest = root.join(name);
            if let Some(parent) = dest.parent() {
                std::fs::create_dir_all(parent)?;
            }
            std::fs::write(&dest, body)?;
            n += 1;
        }
        Ok(n)
    }
    let headers = write_tree(&dir.join("include"), badc::embedded_headers().iter())?;
    let runtime = write_tree(&dir.join("lib"), badc::embedded_runtime().iter())?;
    Ok((headers, runtime))
}

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

#[cfg(test)]
mod output_path_tests {
    use super::{Mode, Target, default_output_path};
    use std::path::PathBuf;

    // A stdin source ("-") must not produce a leading-dash output path
    // (e.g. "-.bin"): codesign reads it as a flag and it is opaque.
    #[test]
    fn stdin_source_falls_back_to_a_base() {
        assert_eq!(
            default_output_path("-", Target::MacOSAarch64, Mode::NativeExecutable),
            PathBuf::from("a.bin")
        );
        assert_eq!(
            default_output_path("-", Target::LinuxX64, Mode::NativeExecutable),
            PathBuf::from("a.bin")
        );
        assert_eq!(
            default_output_path("-", Target::WindowsX64, Mode::NativeExecutable),
            PathBuf::from("a.exe")
        );
    }
}

use std::io::{IsTerminal, Read, Write};
use std::path::PathBuf;

use badc::{
    Compiler, NativeOptions, PredefinedKind, Target, Vm, dump_native_listing_with_options,
    emit_native_with_options, jit_run_with_options, optimize, predefined_symbols,
};

const USAGE: &str = "\
usage: badc [options] <source.c> [program-args...]
       badc [options] -    [program-args...]   (read source from stdin)
       cat foo.c | badc [options]              (same -- stdin auto-detected
                                                when not a terminal)

Output mode -- pick at most one (defaults to \"compile to native binary\"):
  --interp                 Run under the bytecode VM (with optional safety net).
  --jit                    Lower in-process and call main() directly.
  --shared                 Produce a shared library (Mach-O .dylib /
                           ELF .so / PE .dll) exposing every #pragma
                           export(name) function.
  --dump-asm               Print the lowered native listing and exit.
                           No source is executed.
  --list-symbols           Print pre-defined keywords / library calls /
                           constants and exit. Takes no source.
  --dump-headers           Print every bundled header (with file
                           separators) to stdout and exit. Useful
                           for extracting them into `./include` so
                           you can override one without rebuilding
                           badc.

Compile knobs:
  -O, --optimize           Enable the bytecode optimizer + native
                           regalloc.
  --target=<spec>          Pick the binary format (one of
                           macos-aarch64, linux-aarch64, linux-x64,
                           windows-x64, windows-arm64). Defaults to
                           the host. Ignored under --interp / --jit;
                           the JIT can only target the host arch.
  -o <path>                Output path. Default depends on output
                           mode and target (.exe / .dylib / .so /
                           .dll suffixes added as appropriate).
                           Pass `-` (or omit -o entirely when
                           stdout is a pipe) to write the binary
                           bytes to stdout for shell-pipeline use.
  -D NAME[=VALUE]          Predefine an object-like macro (`-D X`
                           is equivalent to `-D X=1`). Source-level
                           `#define` / `#undef` still apply on top.
  -U NAME                  Drop a predefine before the source
                           runs, including any default predefine.
  -I path                  Add a filesystem header search path
                           probed before the bundled in-binary
                           headers on #include. Repeatable. The
                           current directory's `./include` and
                           `./headers/include` are auto-added if
                           they exist, so a user-edited copy of
                           a bundled header can override the
                           one shipped in the badc binary.
  -include FILE            Splice the named header in front of
                           the source as if `#include \"FILE\"` had
                           been written at the top of the
                           translation unit. Resolved through
                           the same -I / embedded-registry chain
                           as a normal #include. Repeatable;
                           order matters (later flags expand
                           after earlier ones). Used to opt
                           translation units into the MSVC-
                           shape predefines via
                           `-include msvc_compat.h` when
                           targeting Windows.

VM-only knobs (require --interp):
  --track-pointers         Allocation tracking + use-after-free guard.
  --trace                  Per-instruction stdout trace (noisy).

Mutually exclusive: --interp / --jit / --shared / --dump-asm /
--list-symbols / --dump-headers all pick the output mode; you can
only pick one. --track-pointers and --trace require --interp. -o
makes no sense under --interp / --list-symbols / --dump-headers.";

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
    let mut output_path: Option<PathBuf> = None;
    let mut target_spec: Option<String> = None;
    let mut defines: Vec<(String, String)> = Vec::new();
    let mut undefines: Vec<String> = Vec::new();
    let mut include_paths: Vec<String> = Vec::new();
    let mut force_includes: Vec<String> = Vec::new();

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
            "--optimize" | "-O" => optimize_flag = true,
            "--dump-asm" => claim(&mut mode, Mode::DumpAsm),
            "--jit" => claim(&mut mode, Mode::Jit),
            "--shared" => claim(&mut mode, Mode::SharedLibrary),
            "-h" | "--help" => {
                println!("{USAGE}");
                return;
            }
            "-o" => match iter.next() {
                Some(p) => output_path = Some(PathBuf::from(p)),
                None => {
                    eprintln!("badc: -o requires a path argument");
                    std::process::exit(1);
                }
            },
            "-D" => match iter.next() {
                Some(s) => match s.split_once('=') {
                    Some((name, body)) => defines.push((name.to_string(), body.to_string())),
                    None => defines.push((s, String::from("1"))),
                },
                None => {
                    eprintln!("badc: -D requires NAME[=VALUE]");
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
                    eprintln!("badc: -U requires a NAME");
                    std::process::exit(1);
                }
            },
            s if s.starts_with("-U") && s.len() > 2 => {
                undefines.push(s[2..].to_string());
            }
            "-I" => match iter.next() {
                Some(p) => include_paths.push(p),
                None => {
                    eprintln!("badc: -I requires a path argument");
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
                    eprintln!("badc: -include requires a header name");
                    std::process::exit(1);
                }
            },
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
            eprintln!("{e}");
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

    // Source resolution. Three shapes are accepted:
    //   * `badc <path>` -- positional source file. (Existing
    //     default path -- unchanged.)
    //   * `badc -`      -- read source from stdin explicitly.
    //   * `cat foo.c | badc` -- no positional, stdin is a pipe;
    //     auto-detect and read from stdin. Falls back to the
    //     usage error when stdin is a terminal (= the user
    //     forgot the source file).
    // `path` keeps a synthetic value (`"-"` or `"<stdin>"`) when
    // the source came from stdin so default_output_path /
    // jit_run / VM `argv[0]` reads still get a sensible name.
    let read_stdin_source = || -> String {
        let mut s = String::new();
        std::io::stdin()
            .read_to_string(&mut s)
            .expect("Could not read stdin");
        s
    };
    let (path, contents): (String, String) = if args.len() >= 2 && args[1] != "-" {
        let p = args[1].clone();
        let mut file = std::fs::File::open(&p).expect("Could not open file");
        let mut s = String::new();
        Read::read_to_string(&mut file, &mut s).expect("Could not read file");
        (p, s)
    } else if (args.len() >= 2 && args[1] == "-") || !std::io::stdin().is_terminal() {
        // Reserve `-` in argv[0]'s slot so VM-mode `argv[0]` gets
        // something readable rather than the empty string.
        ("-".to_string(), read_stdin_source())
    } else {
        eprintln!("{USAGE}");
        std::process::exit(1);
    };

    // Thread the user's `--target` choice plus any `-D` / `-U`
    // predefines into the compiler. The bytecode itself is target-
    // independent; only the resolved binding map and the
    // preprocessor predefines vary.
    let mut program = match Compiler::with_full_options(
        contents,
        target,
        &defines,
        &undefines,
        &include_paths,
        &force_includes,
    )
    .compile()
    {
        Ok(p) => p,
        Err(e) => {
            eprintln!("{}", e);
            std::process::exit(1);
        }
    };
    // The compiler doesn't see the user's filesystem path; thread
    // it onto the Program so the DWARF emitter (gh #44) can put a
    // real `DW_AT_name` on the compilation-unit DIE. lldb / gdb
    // then show `foo.c:N` instead of `<unknown>:N` next to every
    // resolved address.
    program.source_path = path.clone();

    let program = if optimize_flag && std::env::var("BADC_BC_OPT_OFF").is_err() {
        match optimize(program) {
            Ok(p) => p,
            Err(e) => {
                eprintln!("{}", e);
                std::process::exit(1);
            }
        }
    } else {
        program
    };

    // Type-mismatch and arity warnings (if any) -- print once, before
    // the program runs. They never fail the compile, but they do go to
    // stderr so a `2>/dev/null` user can suppress.
    for w in &program.warnings {
        eprintln!("{w}");
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
    if mode == Mode::SharedLibrary {
        native_opts = native_opts.with_shared_library();
    }

    match mode {
        Mode::DumpAsm => match dump_native_listing_with_options(&program, target, native_opts) {
            Ok(s) => print!("{s}"),
            Err(e) => {
                eprintln!("{e}");
                std::process::exit(1);
            }
        },
        Mode::Jit => {
            // The JIT loader picks the host arch on its own; --target is
            // ignored (the JIT can't cross-compile, and the lowering it
            // does is determined by the host).
            let c_args: Vec<String> = args[1..].to_vec();
            match jit_run_with_options(&program, &c_args, native_opts) {
                Ok(code) => std::process::exit(code),
                Err(e) => {
                    eprintln!("{e}");
                    std::process::exit(1);
                }
            }
        }
        Mode::Interp => {
            // Pass everything from argv[1] onward to the C program -- argv[0]
            // of the hosted program is the source file name, argv[1..] are
            // its own args.
            let c_args: Vec<String> = args[1..].to_vec();
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
                    eprintln!("{}", e);
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
                emit_native_binary(&program, &out, target, native_opts, mode);
            }
        }
        Mode::ListSymbols => unreachable!("handled above"),
        Mode::DumpHeaders => unreachable!("handled above"),
    }
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
            eprintln!("{e}");
            std::process::exit(1);
        }
    };
    if let Err(e) = std::io::stdout().write_all(&bytes) {
        eprintln!("badc: failed to write binary to stdout: {e}");
        std::process::exit(1);
    }
    let _ = std::io::stdout().flush();
}

fn emit_native_binary(
    program: &badc::Program,
    out: &std::path::Path,
    target: Target,
    options: NativeOptions,
    mode: Mode,
) {
    let bytes = match emit_native_with_options(program, target, options) {
        Ok(b) => b,
        Err(e) => {
            eprintln!("{e}");
            std::process::exit(1);
        }
    };
    if let Err(e) = std::fs::write(out, &bytes) {
        eprintln!("badc: failed to write {}: {e}", out.display());
        std::process::exit(1);
    }
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
            eprintln!("badc: codesign exited with status {s} -- binary may not run");
        }
        Err(e) => {
            eprintln!("badc: failed to invoke {CODESIGN}: {e}");
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

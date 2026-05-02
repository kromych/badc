use std::path::PathBuf;

use badc::{
    Compiler, NativeOptions, PredefinedKind, Target, Vm, dump_native_listing_with_options,
    emit_native_with_options, jit_run_with_options, optimize, predefined_symbols,
};

const USAGE: &str = "\
usage: badc [options] <source.c> [program-args...]

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

VM-only knobs (require --interp):
  --track-pointers         Allocation tracking + use-after-free guard.
  --trace                  Per-instruction stdout trace (noisy).

Mutually exclusive: --interp / --jit / --shared / --dump-asm /
--list-symbols all pick the output mode; you can only pick one.
--track-pointers and --trace require --interp. -o makes no sense
under --interp / --list-symbols.";

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
            s if s.starts_with("--target=") => {
                target_spec = Some(s["--target=".len()..].to_string());
            }
            _ => args.push(arg),
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
    if output_path.is_some() && matches!(mode, Mode::Interp | Mode::ListSymbols | Mode::Jit) {
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

    if args.len() < 2 {
        eprintln!("{USAGE}");
        std::process::exit(1);
    }

    let path = &args[1];
    let mut file = std::fs::File::open(path).expect("Could not open file");
    let mut contents = String::new();
    std::io::Read::read_to_string(&mut file, &mut contents).expect("Could not read file");

    // Thread the user's `--target` choice into the compiler so the
    // preprocessor pulls in `headers/badc-{target}.h` rather than the
    // default. The bytecode itself is target-independent; only the
    // auto-prepended header and the resolved import map vary.
    let program = match Compiler::with_target(contents, target).compile() {
        Ok(p) => p,
        Err(e) => {
            eprintln!("{}", e);
            std::process::exit(1);
        }
    };

    let program = if optimize_flag {
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
            // Default: lower to a native binary, write it,
            // mark it executable, and (on macOS hosts emitting
            // Mach-O) ad-hoc codesign so dyld accepts it.
            let out = output_path.unwrap_or_else(|| default_output_path(path, target, mode));
            emit_native_binary(&program, &out, target, native_opts, mode);
        }
        Mode::ListSymbols => unreachable!("handled above"),
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

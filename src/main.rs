use std::path::PathBuf;

use badc::{
    Compiler, NativeOptions, PredefinedKind, Target, Vm, dump_native_listing_with_options,
    emit_native_with_options, jit_run_with_options, optimize, predefined_symbols,
};

const USAGE: &str = "usage: badc [--track-pointers] [--trace] [--list-symbols] [--optimize|-O] \
                     [--emit-native [--target=<spec>] [-o <out>]] [--dump-asm] [--jit] \
                     <file> [args...]";

/// Where the AOT codesign tool lives on every macOS install. Hardcoded
/// so we don't accidentally pick up a homebrew shim that signs differently.
#[cfg(target_os = "macos")]
const CODESIGN: &str = "/usr/bin/codesign";

fn main() {
    let raw: Vec<String> = std::env::args().collect();

    // Strip flags off `raw` and stash a normalised positional list in
    // `args`. The two-arg form (`-o <path>`) needs a peeking iterator,
    // which is why this isn't a simple `.filter()` like before.
    let mut track_pointers = false;
    let mut trace = false;
    let mut list_symbols = false;
    let mut optimize_flag = false;
    let mut emit_native_flag = false;
    let mut output_path: Option<PathBuf> = None;
    let mut target_spec: Option<String> = None;
    let mut dump_asm = false;
    let mut jit = false;

    let mut iter = raw.into_iter();
    let prog0 = iter.next().unwrap_or_default();
    let mut args: Vec<String> = vec![prog0];
    while let Some(arg) = iter.next() {
        match arg.as_str() {
            "--track-pointers" => track_pointers = true,
            "--trace" => trace = true,
            "--list-symbols" => list_symbols = true,
            "--optimize" | "-O" => optimize_flag = true,
            "--emit-native" => emit_native_flag = true,
            "--dump-asm" => dump_asm = true,
            "--jit" => jit = true,
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

    let target = match Target::parse(target_spec.as_deref()) {
        Ok(t) => t,
        Err(e) => {
            eprintln!("{e}");
            std::process::exit(1);
        }
    };

    if list_symbols {
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

    let program = match Compiler::new(contents).compile() {
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
    let native_opts = if optimize_flag {
        NativeOptions::new().with_optimize()
    } else {
        NativeOptions::new()
    };

    if dump_asm {
        match dump_native_listing_with_options(&program, target, native_opts) {
            Ok(s) => print!("{s}"),
            Err(e) => {
                eprintln!("{e}");
                std::process::exit(1);
            }
        }
        return;
    }

    if jit {
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

    if emit_native_flag {
        let out = output_path.unwrap_or_else(|| default_output_path(path));
        emit_native_binary(&program, &out, target, native_opts);
        return;
    }

    if output_path.is_some() {
        eprintln!("badc: -o is only meaningful with --emit-native");
        std::process::exit(1);
    }

    // Pass everything from argv[1] onward to the C program -- argv[0] of the
    // hosted program is the source file name, argv[1..] are its own args.
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

/// Default `-o` value when the user passes `--emit-native` without one:
/// drop the extension off the source path. `foo/bar.c` -> `foo/bar`,
/// `script` -> `script.bin` (don't overwrite the source itself when
/// there's no extension to strip).
fn default_output_path(source: &str) -> PathBuf {
    let p = PathBuf::from(source);
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
    set_executable(out);
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
        .filter(|s| s.kind == PredefinedKind::Syscall)
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

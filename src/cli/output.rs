use badc::Target;

use super::diag::eprint_diagnostic;

/// Where the AOT codesign tool lives on every macOS install. Hardcoded
/// so we don't accidentally pick up a homebrew shim that signs differently.
#[cfg(target_os = "macos")]
const CODESIGN: &str = "/usr/bin/codesign";

/// Write to standard output for [`out!`] / [`outln!`]. A closed pipe ends
/// the run with a failure status and no message; any other write error is
/// reported.
pub(crate) fn write_stdout(args: core::fmt::Arguments) {
    use std::io::Write;
    if let Err(e) = std::io::stdout().lock().write_fmt(args) {
        if e.kind() != std::io::ErrorKind::BrokenPipe {
            eprint_diagnostic(format!("badc: error: failed to write standard output: {e}"));
        }
        std::process::exit(1);
    }
}

/// Write `bytes` to `out`, exit on failure, log
/// `info: wrote file <path>` on success unless `quiet` is set.
/// Used by every output path -- object emit, archive emit, JIT
/// binary emit, native-binary emit -- so the chatter is uniform.
/// Routes the info line through `eprint_diagnostic` so the
/// severity word picks up the green TTY color.
pub(crate) fn write_output(
    out: &std::path::Path,
    bytes: &[u8],
    target: Target,
    quiet: bool,
    executable: bool,
) {
    if let Err(e) = badc::write_output_file(out, bytes, executable) {
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

/// Post-write hooks for the native image: codesign Mach-O on macOS hosts
/// so dyld accepts the binary, and report B7009 when the image's target is
/// not the running host. `-q`, `-w` and `-Wno-cross-target-output` drop
/// the report.
pub(crate) fn post_write_native(
    out: &std::path::Path,
    target: Target,
    diag: &badc::diag::Config,
    quiet: bool,
) {
    #[cfg(target_os = "macos")]
    if target == Target::MacOSAarch64 {
        codesign(out);
    }
    let _ = out;
    let elsewhere = match target {
        Target::MacOSAarch64 if !cfg!(target_os = "macos") => Some(
            "a Mach-O on a non-macOS host; copy it to macOS and `codesign --sign - <path>` \
             before running it",
        ),
        Target::LinuxAarch64 if !cfg!(all(target_os = "linux", target_arch = "aarch64")) => {
            Some("a Linux/aarch64 ELF on a different host; it won't run here")
        }
        Target::LinuxX64 if !cfg!(all(target_os = "linux", target_arch = "x86_64")) => {
            Some("a Linux/x86_64 ELF on a different host; it won't run here")
        }
        Target::WindowsX64 if !cfg!(all(target_os = "windows", target_arch = "x86_64")) => {
            Some("a Windows/x86_64 PE on a different host; it won't run here")
        }
        Target::WindowsAarch64 if !cfg!(all(target_os = "windows", target_arch = "aarch64")) => {
            Some("a Windows/AArch64 PE on a different host; it won't run here")
        }
        _ => None,
    };
    let Some(what) = elsewhere.filter(|_| !quiet) else {
        return;
    };
    let mut sink = badc::diag::Sink::new(diag.clone(), Default::default());
    sink.emit(
        badc::diag::Code::CROSS_TARGET_OUTPUT,
        None,
        format!("produced {what}"),
    );
    let tty = std::io::IsTerminal::is_terminal(&std::io::stderr());
    for d in sink.diagnostics() {
        eprintln!("{}", super::diag::rendered(d, tty));
    }
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

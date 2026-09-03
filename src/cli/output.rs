use badc::Target;

use super::diag::eprint_diagnostic;

/// Where the AOT codesign tool lives on every macOS install. Hardcoded
/// so we don't accidentally pick up a homebrew shim that signs differently.
#[cfg(target_os = "macos")]
const CODESIGN: &str = "/usr/bin/codesign";

/// Write `bytes` to `out`, exit on failure, log
/// `info: wrote file <path>` on success unless `quiet` is set.
/// Used by every output path -- object emit, archive emit, JIT
/// binary emit, native-binary emit -- so the chatter is uniform.
/// Routes the info line through `eprint_diagnostic` so the
/// severity word picks up the green TTY color.
pub(crate) fn write_output(out: &std::path::Path, bytes: &[u8], target: Target, quiet: bool) {
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
pub(crate) fn post_write_native(out: &std::path::Path, target: Target) {
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
pub(crate) fn set_executable(path: &std::path::Path) {
    use std::os::unix::fs::PermissionsExt;
    if let Ok(meta) = std::fs::metadata(path) {
        let mut perms = meta.permissions();
        perms.set_mode(perms.mode() | 0o111);
        let _ = std::fs::set_permissions(path, perms);
    }
}

#[cfg(not(unix))]
pub(crate) fn set_executable(_path: &std::path::Path) {
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

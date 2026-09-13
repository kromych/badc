use std::path::{Path, PathBuf};

use badc::Target;

use super::options::Mode;

/// The installed tree a build reads its bundled headers and runtime
/// sources from: `--badc-home=<dir>`, else `$BADC_HOME`, else none. An
/// empty `--badc-home=` withdraws the environment's choice. Only these
/// two declarations name a tree: a build never reads `~/.badc` or the
/// executable's neighbourhood on its own, so the image does not depend
/// on what the machine happens to carry.
pub(crate) fn declared_home(flag: Option<&Path>) -> Option<PathBuf> {
    match flag {
        Some(dir) if dir.as_os_str().is_empty() => None,
        Some(dir) => Some(dir.to_path_buf()),
        None => std::env::var_os("BADC_HOME").map(PathBuf::from),
    }
}

/// Where `--install` writes without an operand: `$BADC_HOME` if set,
/// else `~/.badc` (`$HOME` on Unix, `%USERPROFILE%` on Windows).
pub(crate) fn install_dir() -> Option<PathBuf> {
    if let Some(h) = std::env::var_os("BADC_HOME") {
        return Some(PathBuf::from(h));
    }
    let home = std::env::var_os("HOME").or_else(|| std::env::var_os("USERPROFILE"))?;
    Some(PathBuf::from(home).join(".badc"))
}

/// The root the target's own headers and libraries are read from:
/// `--sysroot=<dir>`, else `$SDKROOT` for a Mach-O target (the
/// platform's own declaration of its SDK), else none. An empty
/// `--sysroot=` withdraws the variable. No other root is assumed: a
/// native link reads the host's `/usr/lib` and `/usr/include` only
/// when the command names them, so one command emits one image on
/// every host.
pub(crate) fn declared_sysroot(flag: Option<&Path>, target: Target) -> Option<PathBuf> {
    match flag {
        Some(dir) if dir.as_os_str().is_empty() => None,
        Some(dir) => Some(dir.to_path_buf()),
        None if target.binary_format() == badc::BinaryFormat::MachO => {
            std::env::var_os("SDKROOT").map(PathBuf::from)
        }
        None => None,
    }
}

/// The standard library directories under `sysroot` for the target's
/// format, in search order, kept to those that exist: the FHS pair
/// with its 64-bit and multiarch variants on ELF, ld64's `usr/lib` and
/// `usr/local/lib` on Mach-O, the `lib` / `usr/lib` pair on PE.
pub(crate) fn sysroot_library_paths(target: Target, sysroot: &Path) -> Vec<String> {
    let multiarch = format!("{}-linux-gnu", target_arch_name(target));
    let dirs: &[String] = &match target.binary_format() {
        badc::BinaryFormat::Elf => vec![
            "usr/lib64".to_string(),
            "lib64".to_string(),
            "usr/lib".to_string(),
            "lib".to_string(),
            format!("usr/lib/{multiarch}"),
            format!("lib/{multiarch}"),
        ],
        badc::BinaryFormat::MachO => vec!["usr/lib".to_string(), "usr/local/lib".to_string()],
        badc::BinaryFormat::Pe => vec!["lib".to_string(), "usr/lib".to_string()],
    };
    existing_dirs(sysroot, dirs)
}

/// The standard header directories under `sysroot`, probed after the
/// bundled headers so only a header the embedded set lacks reaches
/// them (see `Preprocessor::add_system_fallback_path`).
pub(crate) fn sysroot_include_paths(target: Target, sysroot: &Path) -> Vec<String> {
    let dirs: &[String] = &match target.binary_format() {
        badc::BinaryFormat::Elf => vec![
            "usr/local/include".to_string(),
            format!("usr/include/{}-linux-gnu", target_arch_name(target)),
            "usr/include".to_string(),
        ],
        badc::BinaryFormat::MachO => {
            vec!["usr/local/include".to_string(), "usr/include".to_string()]
        }
        badc::BinaryFormat::Pe => vec!["include".to_string(), "usr/include".to_string()],
    };
    existing_dirs(sysroot, dirs)
}

fn target_arch_name(target: Target) -> &'static str {
    if target.is_x86_64() {
        "x86_64"
    } else {
        "aarch64"
    }
}

fn existing_dirs(root: &Path, dirs: &[String]) -> Vec<String> {
    dirs.iter()
        .map(|d| root.join(d))
        .filter(|p| p.is_dir())
        .map(|p| p.to_string_lossy().into_owned())
        .collect()
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
pub(crate) fn default_output_path(source: &str, target: Target, mode: Mode) -> PathBuf {
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

/// Write every embedded header under `dir/include` and every embedded
/// runtime source under `dir/lib`, recreating the source hierarchy
/// (e.g. `dir/include/sys/socket.h`). Returns the (headers, runtime)
/// counts. Existing files are overwritten so a re-install refreshes a
/// stale tree.
pub(crate) fn install_embedded(dir: &std::path::Path) -> std::io::Result<(usize, usize)> {
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

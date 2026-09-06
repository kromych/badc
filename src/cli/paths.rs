use std::path::PathBuf;

use badc::Target;

use super::options::Mode;

/// The badc home directory: `$BADC_HOME` if set, else `~/.badc`
/// (`$HOME` on Unix, `%USERPROFILE%` on Windows). `None` when none of
/// those is set. Drives both the `--install` default destination and
/// the on-disk header / runtime overlay the compile paths consult.
pub(crate) fn badc_home() -> Option<PathBuf> {
    if let Some(h) = std::env::var_os("BADC_HOME") {
        return Some(PathBuf::from(h));
    }
    let home = std::env::var_os("HOME").or_else(|| std::env::var_os("USERPROFILE"))?;
    Some(PathBuf::from(home).join(".badc"))
}

/// `libc/include` of the source tree this badc was built from, found by
/// walking up from the executable to the crate root (`target/<profile>/`
/// or `target/<triple>/<profile>/`). `None` for an installed binary,
/// which has no source tree.
pub(crate) fn source_tree_include() -> Option<PathBuf> {
    let exe = std::env::current_exe().ok()?;
    let mut dir = exe.parent()?;
    for _ in 0..4 {
        let inc = dir.join("libc").join("include");
        if dir.join("Cargo.toml").is_file() && inc.is_dir() {
            return Some(inc);
        }
        dir = dir.parent()?;
    }
    None
}

/// The host's default system header directories, probed after the
/// bundled headers (a compiler driver's implicit system include path).
/// Non-empty only for a hosted native build: the host's `/usr/include`
/// is the target's only when compiling for the host platform, so a
/// cross or `--freestanding` build returns empty and relies on `-I`.
/// Standard headers still resolve to the embedded copies (searched
/// first); only a header the embedded set lacks reaches these.
pub(crate) fn default_system_include_paths(
    target: badc::Target,
    freestanding: bool,
) -> Vec<String> {
    if freestanding {
        return Vec::new();
    }
    let native = cfg!(target_os = "linux") && target == badc::Target::host();
    if !native {
        return Vec::new();
    }
    [
        "/usr/local/include",
        "/usr/include/aarch64-linux-gnu",
        "/usr/include/x86_64-linux-gnu",
        "/usr/include",
    ]
    .iter()
    .filter(|d| std::path::Path::new(d).is_dir())
    .map(|s| (*s).to_string())
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

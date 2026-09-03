use badc::Target;

use super::diag::{TuLog, eprint_diagnostic};

/// The relocation machine `target`'s objects use, for selecting a
/// universal (fat) Mach-O container's slice.
pub(crate) fn target_machine(target: Target) -> badc::NativeMachine {
    match target {
        badc::Target::LinuxX64 | badc::Target::WindowsX64 => badc::NativeMachine::X86_64,
        _ => badc::NativeMachine::Aarch64,
    }
}

pub(crate) fn machine_label(machine: badc::NativeMachine) -> &'static str {
    match machine {
        badc::NativeMachine::X86_64 => "x86_64",
        badc::NativeMachine::Aarch64 => "arm64",
    }
}

/// The `usr/lib` stub directory of the macOS SDK, resolved the way the
/// platform toolchain resolves the SDK: `SDKROOT` when it names a
/// directory, then `xcrun --show-sdk-path`, then the Command Line
/// Tools' fixed location. `None` on hosts without an SDK, where only
/// explicit `-L` paths can supply Mach-O system libraries.
pub(crate) fn macos_sdk_lib_dir() -> Option<String> {
    let lib = |root: &str| {
        let p = std::path::Path::new(root).join("usr/lib");
        p.is_dir().then(|| p.to_string_lossy().into_owned())
    };
    if let Ok(root) = std::env::var("SDKROOT")
        && let Some(d) = lib(&root)
    {
        return Some(d);
    }
    if let Ok(out) = std::process::Command::new("xcrun")
        .args(["--show-sdk-path"])
        .output()
        && out.status.success()
        && let Some(d) = lib(String::from_utf8_lossy(&out.stdout).trim())
    {
        return Some(d);
    }
    lib("/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk")
}

/// The platform half of a `.tbd` `<arch>-<platform>` target.
pub(crate) fn target_platform(target: Target) -> &'static str {
    match target {
        badc::Target::MacOSAarch64 => "macos",
        badc::Target::LinuxAarch64 | badc::Target::LinuxX64 => "linux",
        badc::Target::WindowsAarch64 | badc::Target::WindowsX64 => "windows",
    }
}

/// Substitute a universal (fat) Mach-O container by its slice for
/// `target`; anything else passes through unchanged. The caller's
/// format checks then see the slice, so a wrapped archive, object or
/// dylib is handled as if it had been thin.
pub(crate) fn fat_slice_for_target(bytes: Vec<u8>, target: Target) -> Vec<u8> {
    match badc::mach_o_fat_slice(&bytes, target_machine(target)) {
        Some(s) => s.to_vec(),
        None => bytes,
    }
}

/// Why the linker cannot read `bytes` as an input object, phrased in
/// the detected format's own terms. badc's relocatable format is ELF
/// on every target -- the target's container appears only in the final
/// image -- so a foreign object is named by what it is.
pub(crate) fn unreadable_object_reason(bytes: &[u8], target: Target) -> String {
    let reads = "badc links ELF relocatable objects on every target, \
                 and arm64 Mach-O relocatable objects";
    // The call sites substitute a fat container by its slice first, so
    // a fat container reaching this point has no slice for the target.
    if badc::is_mach_o_fat(bytes) {
        return format!(
            "is a universal (fat) Mach-O with no {} slice; {reads}",
            machine_label(target_machine(target)),
        );
    }
    match badc::detect_binary_format(bytes) {
        Some(badc::BinaryFormat::Elf) => format!("malformed ELF object; {reads}"),
        Some(badc::BinaryFormat::MachO) => format!("is a Mach-O file but not MH_OBJECT; {reads}"),
        Some(f) => {
            let image = target.binary_format();
            let mut s = format!("is a {} object; {reads}", f.name());
            if image != badc::BinaryFormat::Elf {
                s.push_str(&format!(
                    " -- --target={} writes a {} image from ELF inputs",
                    target.id_str(),
                    image.name()
                ));
            }
            s
        }
        None => format!("is not an object file in any format badc recognises; {reads}"),
    }
}

/// The file names `-l<name>` looks for on `target`, in `ld`'s order:
/// the unversioned shared library first, then the static archive. The
/// shared spelling follows the target's container format -- `.so` for
/// ELF, `.dylib` for Mach-O, `.dll` for PE.
pub(crate) fn library_spellings(name: &str, target: Target) -> [String; 2] {
    let ext = target.binary_format().shared_lib_ext();
    [format!("lib{name}.{ext}"), format!("lib{name}.a")]
}

/// Locate a `-l<name>` library on the search path. Prefers the
/// unversioned shared library, then a versioned one (shortest match --
/// the bare SONAME version), then the static archive. ELF spells the
/// version after the extension (`libfoo.so.3`), Mach-O and PE before
/// it (`libfoo.3.dylib`). On Mach-O a `.tbd` text stub stands in for
/// the dylib and is preferred over one, as ld64 prefers it: the SDK
/// ships only the stub, and where both exist they describe the same
/// library.
pub(crate) fn find_library(name: &str, search_paths: &[String], target: Target) -> Option<String> {
    let fmt = target.binary_format();
    let [shared, archive] = library_spellings(name, target);
    for dir in search_paths {
        if fmt == badc::BinaryFormat::MachO {
            let tbd = std::path::Path::new(dir).join(format!("lib{name}.tbd"));
            if tbd.exists() {
                return Some(tbd.to_string_lossy().into_owned());
            }
        }
        let so = std::path::Path::new(dir).join(&shared);
        if so.exists() {
            return Some(so.to_string_lossy().into_owned());
        }
        if let Ok(rd) = std::fs::read_dir(dir) {
            let (prefix, suffix) = if fmt.version_before_ext() {
                (format!("lib{name}."), format!(".{}", fmt.shared_lib_ext()))
            } else {
                (format!("{shared}."), String::new())
            };
            let mut best: Option<String> = None;
            for ent in rd.flatten() {
                let fname = ent.file_name().to_string_lossy().into_owned();
                // A versioned name carries at least one character
                // between the prefix and the suffix; `starts_with`
                // alone would also match the unversioned spelling.
                if fname.len() <= prefix.len() + suffix.len()
                    || !fname.starts_with(&prefix)
                    || !fname.ends_with(&suffix)
                {
                    continue;
                }
                if best.as_ref().is_none_or(|b| fname.len() < b.len()) {
                    best = Some(fname);
                }
            }
            if let Some(b) = best {
                return Some(
                    std::path::Path::new(dir)
                        .join(b)
                        .to_string_lossy()
                        .into_owned(),
                );
            }
        }
        let a = std::path::Path::new(dir).join(&archive);
        if a.exists() {
            return Some(a.to_string_lossy().into_owned());
        }
    }
    None
}

/// Extract the file entries of a GNU ld script's GROUP / INPUT /
/// AS_NEEDED directives. After stripping `/* ... */` comments, an
/// entry is any `/absolute` path or `-l<name>` token; the directive
/// keywords and the `OUTPUT_FORMAT` argument carry neither form.
pub(crate) fn parse_ld_script_inputs(bytes: &[u8]) -> Vec<String> {
    let text = String::from_utf8_lossy(bytes);
    let mut cleaned = String::new();
    let mut rest: &str = text.as_ref();
    while let Some(start) = rest.find("/*") {
        cleaned.push_str(&rest[..start]);
        match rest[start + 2..].find("*/") {
            Some(end) => rest = &rest[start + 2 + end + 2..],
            None => {
                rest = "";
                break;
            }
        }
    }
    cleaned.push_str(rest);
    cleaned
        .split(|c: char| c.is_whitespace() || c == '(' || c == ')' || c == ',')
        .filter(|t| t.starts_with('/') || t.starts_with("-l"))
        .map(|t| t.to_string())
        .collect()
}

/// Ingest one resolved `-l` / positional linker input, following GNU
/// ld scripts. A static archive (`!<arch>` / `!<thin>`) is recorded
/// positionally; an ELF shared object, a Mach-O dylib, and a `.tbd`
/// text stub are parsed for their canonical name + exports; a binary
/// in another container is rejected by name, since the fallthrough
/// would read it as a linker script and resolve to no inputs at all;
/// anything else is treated as a linker script whose GROUP / INPUT /
/// AS_NEEDED file list is resolved recursively.
pub(crate) fn ingest_linker_input(
    path: &str,
    search_paths: &[String],
    target: Target,
    shared_libs: &mut Vec<badc::SharedLibrary>,
    archives: &mut Vec<String>,
    depth: usize,
) -> Result<(), String> {
    if depth > 16 {
        return Err(format!("linker-script nesting too deep at `{path}`"));
    }
    let bytes = std::fs::read(path).map_err(|e| format!("cannot read `{path}`: {e}"))?;
    // A universal (fat) container is classified by its slice for the
    // target. Only the path is recorded for an archive, so the archive
    // reader re-selects the slice when it reads the path.
    let bytes: &[u8] = match badc::mach_o_fat_slice(&bytes, target_machine(target)) {
        Some(s) => s,
        None => &bytes,
    };
    // Substitute an empty canonical name by the file's base name, the
    // way `ld` falls back for a `.so` with no `DT_SONAME`.
    let named = |mut lib: badc::SharedLibrary| -> badc::SharedLibrary {
        if lib.soname.is_empty() {
            lib.soname = std::path::Path::new(path)
                .file_name()
                .map(|s| s.to_string_lossy().into_owned())
                .unwrap_or_else(|| path.to_string());
        }
        lib
    };
    // A shared library resolves a reference into a load-time import of
    // the library the image names as a dependency, which the loader can
    // only satisfy when the library is the target's own container and
    // architecture. Admitting a foreign one would bind the reference to
    // a library the image never loads.
    let compatible = |lib: badc::SharedLibrary, fmt: badc::BinaryFormat| -> Result<_, String> {
        if fmt != target.binary_format() {
            return Err(format!(
                "`{path}` is a shared library in the {} container; a {} link cannot import from it",
                fmt.name(),
                target.binary_format().name(),
            ));
        }
        if lib.machine != target_machine(target) {
            return Err(format!(
                "`{path}` is a shared library for {}; the link targets {}",
                machine_label(lib.machine),
                machine_label(target_machine(target)),
            ));
        }
        Ok(named(lib))
    };
    if bytes.starts_with(b"!<arch>\n") || bytes.starts_with(b"!<thin>\n") {
        archives.push(path.to_string());
    } else if bytes.starts_with(b"\x7fELF") {
        let lib = badc::parse_shared_library(bytes)
            .map_err(|e| format!("reading `{path}` as a shared library: {e}"))?;
        shared_libs.push(compatible(lib, badc::BinaryFormat::Elf)?);
    } else if badc::is_mach_o_dylib(bytes) {
        let lib = badc::parse_mach_o_dylib(bytes)
            .map_err(|e| format!("reading `{path}` as a dylib: {e}"))?;
        shared_libs.push(compatible(lib, badc::BinaryFormat::MachO)?);
    } else if badc::is_tbd(bytes) {
        let text =
            core::str::from_utf8(bytes).map_err(|_| format!("`{path}` is not UTF-8 text"))?;
        let lib = badc::parse_tbd(
            text,
            machine_label(target_machine(target)),
            target_platform(target),
        )
        .map_err(|e| format!("reading `{path}` as a text stub: {e}"))?;
        shared_libs.push(compatible(lib, badc::BinaryFormat::MachO)?);
    } else if let Some(f) = badc::detect_binary_format(bytes) {
        return Err(format!(
            "`{path}` is a {} binary badc cannot link against; the shared-library inputs \
             badc reads are ELF shared objects, Mach-O dylibs and .tbd text stubs, \
             plus static archives",
            f.name()
        ));
    } else {
        for entry in parse_ld_script_inputs(bytes) {
            let resolved = match entry.strip_prefix("-l") {
                Some(n) => find_library(n, search_paths, target)
                    .ok_or_else(|| format!("linker script `{path}`: cannot find `-l{n}`"))?,
                None => entry,
            };
            ingest_linker_input(
                &resolved,
                search_paths,
                target,
                shared_libs,
                archives,
                depth + 1,
            )?;
        }
    }
    Ok(())
}

/// Enumerate the `STB_GLOBAL`-defined symbol names from a
/// native ELF64 ET_REL blob. Used to populate the SysV `ar`
/// symbol index when `--ar` bundles native objects: any name
/// listed here resolves -- via the archive's `/` member -- to
/// the containing member's file offset, which is how the
/// linker's archive pull-in decides which members to load.
pub(crate) fn native_defined_globals(bytes: &[u8], path: &str) -> Vec<String> {
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

/// Like [`native_defined_globals`] but records a parse error in `log`
/// and returns `Err` instead of exiting, for the `--ar` compile
/// workers. STB_GLOBAL section-resident names only (archive-pull-in
/// visibility).
pub(crate) fn native_defined_globals_logged(
    bytes: &[u8],
    path: &str,
    log: &mut TuLog,
    tty: bool,
) -> Result<Vec<String>, ()> {
    match badc::parse_native_elf(bytes) {
        Ok(obj) => Ok(obj
            .symbols
            .into_iter()
            .filter(|s| {
                s.binding == 1
                    && !matches!(
                        s.section,
                        badc::NativeSymSection::Undef | badc::NativeSymSection::Abs
                    )
            })
            .map(|s| s.name)
            .collect()),
        Err(e) => {
            log.diag(tty, format!("badc: {path}: {e}"));
            Err(())
        }
    }
}

#[cfg(test)]
mod ld_script_tests {
    use super::parse_ld_script_inputs;

    #[test]
    fn parses_group_and_as_needed_file_entries() {
        // The glibc `libc.so` shape: comment, OUTPUT_FORMAT (whose
        // argument is not a path), and a GROUP with an AS_NEEDED clause.
        let script = b"/* GNU ld script */\n\
            OUTPUT_FORMAT(elf64-littleaarch64)\n\
            GROUP ( /lib64/libc.so.6 /usr/lib64/libc_nonshared.a \
            AS_NEEDED ( /lib/ld-linux-aarch64.so.1 ) )\n";
        let entries = parse_ld_script_inputs(script);
        assert_eq!(
            entries,
            vec![
                "/lib64/libc.so.6".to_string(),
                "/usr/lib64/libc_nonshared.a".to_string(),
                "/lib/ld-linux-aarch64.so.1".to_string(),
            ],
            "OUTPUT_FORMAT argument and keywords must not appear as file entries",
        );
    }
}

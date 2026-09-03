use super::diag::eprint_diagnostic;

/// Top-level mode picked from the argv flag set. Mutual
/// exclusion is enforced once during arg parsing so the rest
/// of `main` can match on a single `Mode`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Mode {
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
    pub(crate) fn flag_name(self) -> &'static str {
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

/// The language a positional input's suffix selects, following gcc's
/// suffix table. `.S` and `.sx` are assembler with the preprocessor run
/// first; `.s` is assembler taken verbatim.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum SourceKind {
    C,
    Asm { preprocess: bool },
}

impl SourceKind {
    pub(crate) fn of(path: &str) -> Self {
        match std::path::Path::new(path)
            .extension()
            .and_then(|s| s.to_str())
            .unwrap_or("")
        {
            "s" => SourceKind::Asm { preprocess: false },
            "S" | "sx" => SourceKind::Asm { preprocess: true },
            _ => SourceKind::C,
        }
    }

    pub(crate) fn is_asm(self) -> bool {
        matches!(self, SourceKind::Asm { .. })
    }
}

/// What one accepted `-Wa,` / `-Xassembler` option asks for.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum AssemblerOption {
    /// Selects nothing badc's assembler does differently.
    NoEffect,
    /// `-L` / `--keep-locals`.
    KeepLocals,
}

/// Check one `-Wa,` / `-Xassembler` option against what badc's assembler
/// implements. The accepted set is what its behavior already matches:
///
/// * `--fatal-warnings` -- every construct badc's assembler declines is
///   already an error, so warnings never downgrade a failure.
/// * `-mrelax-relocations=` -- selects the relaxable x86-64 GOT relocation
///   forms, which an assembled unit never produces.
/// * `--noexecstack` / `--no-warn-rwx-segments` -- `.text` is the only
///   executable section an assembled unit gets, and no `PT_GNU_STACK`
///   program header rides a relocatable object.
/// * `-march=` -- a ceiling on the instructions the assembler admits, not
///   a change to how one assembles. badc implements a fixed set and admits
///   each member unconditionally, so a ceiling at or above that set selects
///   nothing. It does not reject an instruction above a lower ceiling, which
///   is the one direction this diverges from gas.
/// * `-L` / `--keep-locals` -- keeps the local-label temporaries in the
///   object's `.symtab`; see [`badc::NativeOptions::keep_local_labels`].
///
/// Anything else is refused: passing it on is not an option, and accepting
/// it would claim behavior badc does not have.
pub(crate) fn accept_assembler_option(opt: &str) -> Result<AssemblerOption, String> {
    let name = opt.split_once('=').map_or(opt, |(n, _)| n);
    match name {
        "-L" | "--keep-locals" => Ok(AssemblerOption::KeepLocals),
        "--fatal-warnings"
        | "-mrelax-relocations"
        | "--noexecstack"
        | "--no-warn-rwx-segments"
        | "-march" => Ok(AssemblerOption::NoEffect),
        _ => Err(format!("badc: error: unsupported assembler option `{opt}`")),
    }
}

/// Parse a `--jobs` / `-j` value: a positive integer. Exits with a
/// diagnostic on a non-integer or non-positive value.
pub(crate) fn parse_jobs(s: &str) -> usize {
    match s.parse::<usize>() {
        Ok(n) if n >= 1 => n,
        _ => {
            eprint_diagnostic(format!(
                "badc: error: --jobs (-j) requires a positive integer, got `{s}`"
            ));
            std::process::exit(1);
        }
    }
}

/// Parse an option operand written as a C integer: optional sign, then
/// decimal or `0x`-prefixed hexadecimal.
pub(crate) fn parse_c_integer(spec: &str) -> Option<i32> {
    let (neg, body) = match spec.strip_prefix('-') {
        Some(rest) => (true, rest),
        None => (false, spec.strip_prefix('+').unwrap_or(spec)),
    };
    let magnitude = match body.strip_prefix("0x").or_else(|| body.strip_prefix("0X")) {
        Some(hex) => i64::from_str_radix(hex, 16).ok()?,
        None => body.parse::<i64>().ok()?,
    };
    i32::try_from(if neg { -magnitude } else { magnitude }).ok()
}

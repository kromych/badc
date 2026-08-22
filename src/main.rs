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

Inputs are positional and may mix `.c` sources, `.s` / `.S`
assembly sources, c5 `.o` objects, and `.a` archives. A single
`.c` input compiles and emits a binary directly; two or more
inputs (or any `-l` / `-L` / `-c` flag) run through the cross-TU
linker. `.S` (and `.sx`) run through the preprocessor with
`__ASSEMBLER__` predefined before being assembled; `.s` is
assembled verbatim, as in gcc's suffix table.

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
                           write the expanded source to `-o`'s path,
                           or to stdout when `-o` is absent or names
                           `-`. Mirrors gcc / clang `-E`.

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
  -Map=<file>, -Map <file> Write a GNU-ld-style link map (output
                           sections, per-input-section placement,
                           symbol addresses) to <file>. ELF output
                           only.
  --print-map              Print the link map to stdout.
  --jobs N, -jN            Compile independent `.c` sources
                           concurrently in up to 2*N worker threads
                           (capped at the source count). Output is
                           byte-identical to a sequential build and
                           diagnostics stay grouped per source in
                           source order. Defaults to the host's
                           available parallelism.

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
                           Repeatable. A badc built from its own
                           source tree also searches that tree's
                           `libc/include`, so an edited bundled
                           header overrides the embedded one.
  -iquote path             Add a search path for #include \"...\" only,
                           probed after the including file's directory
                           and before the -I paths. Repeatable.
  -fno-builtin[-<name>]    Treat a call spelled with a library
  -ffreestanding           function's own name as an ordinary call the
                           compiler may not fold, and drop the C99
                           7.1.4p2 recovery that declares an undeclared
                           library function by auto-including its
                           header. The `__builtin_` spellings keep
                           folding. -fbuiltin / -fhosted restore the
                           default.
  -nostdinc                Drop the bundled standard headers and the
                           system directories from the #include search,
                           leaving only -I, -iquote and the including
                           file's own directory. A name none of those
                           carries is an error instead of resolving to
                           badc's libc, and the auto-include retry is
                           off. The compiler's own headers
                           (`_builtins.h`, `arm_neon.h`) stay, as gcc's
                           builtins do.
  -include FILE            Splice the named header in front of the
                           source as if `#include \"FILE\"` opened
                           the translation unit. Repeatable; later
                           flags expand after earlier ones.
  -H, --show-includes      Print every #include's resolved path to
                           stderr (gcc -H shape; leading dots mark
                           nesting depth; missing headers print as
                           `! <name> (missing)`).
  -M                       Write a make dependency rule naming the
                           source and every header it opened, and
                           compile nothing. Goes to stdout unless
                           -MF (or -o) names a file.
  -MM                      As -M, but omit system headers: the
                           compiler's own header set and anything
                           resolved from a system fallback
                           directory. Headers from -I, -iquote or
                           the including file's directory are user
                           headers and stay.
  -MD                      Write the rule to a file and compile as
                           usual. The file is -MF, else the -o
                           object with its suffix replaced by `.d`,
                           else the source's base name + `.d`.
  -MMD                     As -MD with -MM's header filter. This is
                           the form kbuild uses.
  -MF file                 Write the dependency rule to `file`.
  -MT target               Name the rule's target, used verbatim.
                           Repeatable; replaces the default name.
  -MQ target               As -MT, but quote the name for make.
  -MP                      Add an empty rule for each prerequisite
                           so a deleted header does not stop make.
  -Wa,<opt>[,<opt>]        Hand an option to the assembler. badc's
  -Xassembler <opt>        assembler is built in, so each option is
                           checked against what it implements rather
                           than passed on; an option it does not
                           implement is refused by name.
  -m16 / -m32 / -m64       Code model, x86 targets only. `-m16` and
                           `-m32` preprocess the unit as i386 (`__i386__`
                           defined, `__x86_64__` not, ILP32 widths) and
                           put its object out as ELFCLASS32 / EM_386, as
                           gcc's `as --32` does; `.code16` / `.code32`
                           in the source select the encoding. badc
                           generates no i386 machine code, so a `.c`
                           source under either is refused unless -E.
  -Wp,-MD,file             The preprocessor spellings of -MD / -MMD,
  -Wp,-MMD,file            which take the output path as an operand.
                           kbuild passes dependency generation this
                           way. As in gcc, the rule keeps the
                           source-derived name; -o does not name it.
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
  -std=<dialect>           Language dialect. badc compiles C99 with the
                           GNU extensions always available, so the name
                           selects only whether __STRICT_ANSI__ is
                           defined under --gnu: `gnu*` clears it, `c*` /
                           `iso*` set it, as gcc and clang do. Without
                           the flag --gnu reports strict conformance.
  -fgnu89-inline           Use the GNU89 inline linkage model: `extern
                           inline` provides no external definition and a
                           plain `inline` does. The default is C99
                           6.7.4p6, which is the inverse. Per function,
                           __attribute__((gnu_inline)) selects GNU89
                           whatever the default is. With --gnu the model
                           is reported as __GNUC_GNU_INLINE__ /
                           __GNUC_STDC_INLINE__.
  -fno-jump-tables         Dispatch every switch through the compare
                           tree, never a jump table, so no switch takes
                           an indirect branch. -fjump-tables restores
                           the default.
  -fPIC, -fpic             Emit a position-independent `-c` object: a
  -fPIE, -fpie             switch table takes the label-difference form,
                           so no absolute relocation reaches the object.
                           Final images are position-independent either
                           way.
  -fno-pic, -fno-pie       Compile the `-c` object for a link that
                           resolves its relocations statically, keeping
                           a relocation-carrying `const` in .rodata.
                           Without it such storage goes to .data.rel.ro,
                           so the unit's remaining `const` objects keep
                           the image's read-only prefix. Implied by
                           -mcmodel=kernel.
  -fmin-function-alignment=N
                           Start every function at a multiple of N
                           bytes (a power of two), filling the gap with
                           NOPs and raising the code section's own
                           alignment to match. The default 1 packs each
                           function against its predecessor. A symbol's
                           size covers its instructions only; the fill
                           belongs to no function.
  -fshort-wchar            Give wchar_t an unsigned 16-bit type instead
                           of the target's default, narrowing the
                           elements of L-prefixed string and character
                           literals and the __SIZEOF_WCHAR_T__ /
                           __WCHAR_TYPE__ predefines with it.
                           -fno-short-wchar restores the default, which
                           is already 16-bit on Windows.
  -fsigned-char            Make plain char signed, whatever the target
                           ABI selects. -fno-unsigned-char is a synonym.
  -funsigned-char          Make plain char unsigned, and predefine
                           __CHAR_UNSIGNED__ so <limits.h> CHAR_MIN /
                           CHAR_MAX follow. -fno-signed-char is a
                           synonym. Without either flag the target ABI
                           decides: unsigned on AArch64 ELF, signed
                           elsewhere.

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

/// The language a positional input's suffix selects, following gcc's
/// suffix table. `.S` and `.sx` are assembler with the preprocessor run
/// first; `.s` is assembler taken verbatim.
#[derive(Clone, Copy, PartialEq, Eq)]
enum SourceKind {
    C,
    Asm { preprocess: bool },
}

impl SourceKind {
    fn of(path: &str) -> Self {
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

    fn is_asm(self) -> bool {
        matches!(self, SourceKind::Asm { .. })
    }
}

/// What the `-M` flag family asked the driver to produce.
#[derive(Clone, Copy, PartialEq, Eq)]
enum DepKind {
    /// `-M` / `-MM`: write the dependency rule and compile nothing.
    Only,
    /// `-MD` / `-MMD`: write the rule alongside the normal output.
    WithOutput,
}

/// A dependency-output request assembled from the `-M` flag family.
struct DepOptions {
    kind: DepKind,
    /// `-M` / `-MD` list system headers; `-MM` / `-MMD` omit them.
    /// badc's system set is the compiler's own headers plus anything
    /// resolved from a system fallback directory; a header from `-I`,
    /// `-iquote` or the including file's directory is a user header.
    system: bool,
    /// `-MF`, or the path carried by `-Wp,-M[M]D,<path>`.
    file: Option<String>,
    /// `-MT` (verbatim) and `-MQ` (make-quoted) rule targets, in
    /// command-line order. Empty means the default naming applies.
    targets: Vec<String>,
    /// `-MP`: give every prerequisite an empty rule of its own.
    phony: bool,
    /// Set by the `-MD` / `-MMD` spellings, where gcc's driver names
    /// the rule after `-o`.
    target_from_output: bool,
}

impl DepOptions {
    /// The file to write for `src`, or `None` to write to stdout
    /// (which only `-M` / `-MM` without `-MF` do).
    fn output_path(&self, output: Option<&std::path::Path>, src: &str) -> Option<PathBuf> {
        if let Some(f) = &self.file {
            return Some(PathBuf::from(f));
        }
        match self.kind {
            // `-M` / `-MM` write to `-o` when it is given, else stdout.
            DepKind::Only => output.map(PathBuf::from),
            // `-MD` / `-MMD` name the file after the object, else after
            // the source basename in the current directory. The suffix
            // swap applies to the file name only, so a dot in a
            // directory component does not count.
            DepKind::WithOutput => Some(match output {
                Some(o) => o.with_extension("d"),
                None => PathBuf::from(source_basename(src)).with_extension("d"),
            }),
        }
    }

    /// The rule's target names for `src`.
    fn rule_targets(&self, output: Option<&std::path::Path>, src: &str) -> Vec<String> {
        if !self.targets.is_empty() {
            return self.targets.clone();
        }
        if self.target_from_output
            && let Some(o) = output
        {
            return vec![badc::dep_escape(&o.to_string_lossy())];
        }
        // gcc's default: the source's base name with its suffix
        // replaced by `.o`, directory components dropped.
        let base = source_basename(src);
        let stem = match base.rfind('.') {
            Some(i) if i > 0 => &base[..i],
            _ => &base[..],
        };
        vec![badc::dep_escape(&format!("{stem}.o"))]
    }
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
///
/// Anything else is refused: passing it on is not an option, and accepting
/// it would claim behavior badc does not have.
fn accept_assembler_option(opt: &str) -> Result<(), String> {
    let name = opt.split_once('=').map_or(opt, |(n, _)| n);
    match name {
        "--fatal-warnings"
        | "-mrelax-relocations"
        | "--noexecstack"
        | "--no-warn-rwx-segments"
        | "-march" => Ok(()),
        _ => Err(format!("badc: error: unsupported assembler option `{opt}`")),
    }
}

/// The `-D` list one translation unit preprocesses under. gcc predefines
/// `__ASSEMBLER__` for a `.S`, and kernel headers gate their C-only content
/// on it. It goes ahead of the command-line list so `-U__ASSEMBLER__` and an
/// explicit `-D__ASSEMBLER__=<v>` both still win.
fn tu_defines(src_path: &str, defines: &[(String, String)]) -> Vec<(String, String)> {
    if !SourceKind::of(src_path).is_asm() {
        return defines.to_vec();
    }
    let mut out = Vec::with_capacity(defines.len() + 1);
    out.push(("__ASSEMBLER__".to_string(), "1".to_string()));
    out.extend_from_slice(defines);
    out
}

/// The file-name component of a source path, or the whole path when it
/// has no directory component.
fn source_basename(src: &str) -> String {
    std::path::Path::new(src)
        .file_name()
        .map(|s| s.to_string_lossy().into_owned())
        .unwrap_or_else(|| src.to_string())
}

/// Render and write one translation unit's dependency rule. Returns
/// `Err` after logging when the file cannot be written -- gcc treats a
/// dependency file it cannot open as fatal, and a build system that
/// asked for one and silently got none rebuilds wrongly forever.
fn emit_deps(
    src: &str,
    records: &[badc::IncludeRecord],
    deps: &DepOptions,
    output: Option<&std::path::Path>,
    log: &mut TuLog,
    tty: bool,
) -> Result<(), ()> {
    let prereqs = badc::dep_prerequisites(src, records, deps.system);
    let text = badc::dep_render(&deps.rule_targets(output, src), &prereqs, deps.phony);
    match deps.output_path(output, src) {
        Some(path) => std::fs::write(&path, text).map_err(|e| {
            log.diag(
                tty,
                format!(
                    "badc: error: opening dependency file {}: {e}",
                    path.display()
                ),
            );
        }),
        None => {
            print!("{text}");
            Ok(())
        }
    }
}

/// Native-stack reservation shared by the driver thread and every
/// `--jobs` compile worker. The parser caps nesting at `MAX_NEST_DEPTH`
/// (512); at a measured ~33 KiB/level a debug build's deepest
/// diagnosable unit needs ~24 MiB, so 64 MiB holds a cross-ISA margin.
/// A worker must match the driver, else a deep unit overflows only
/// under `--jobs`; the reservation is lazily committed, so resident
/// stack stays at what the compile touches.
const DRIVER_STACK_SIZE: usize = 64 * 1024 * 1024;

fn main() {
    // Run the driver on a thread with an explicit stack reservation:
    // the parser bounds nesting with a diagnostic, but a debug build
    // would overflow the platform-default stack before reaching the
    // bound.
    let driver = std::thread::Builder::new()
        .stack_size(DRIVER_STACK_SIZE)
        .spawn(run)
        .expect("spawn driver thread");
    if let Err(e) = driver.join() {
        std::panic::resume_unwind(e);
    }
}

fn run() {
    let raw: Vec<String> = std::env::args().collect();

    // Linker-driver dispatch: invoked as `ld` (argv[0]) or with a
    // leading `--ld`, the remaining arguments follow GNU ld's
    // surface so a build system can set `LD=badc --ld` or symlink
    // `ld` to badc.
    if badc::is_ld_invocation(
        raw.first().map(String::as_str).unwrap_or(""),
        raw.get(1).map(String::as_str),
    ) {
        let skip = if raw.get(1).map(String::as_str) == Some("--ld") {
            2
        } else {
            1
        };
        std::process::exit(badc::run_ld(&raw[skip..]));
    }

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
    // `-Map=FILE` / `-Map FILE` write a GNU-ld-style link map;
    // `-M` / `--print-map` print it to stdout. Both may be given.
    let mut map_path: Option<PathBuf> = None;
    let mut print_map = false;
    let mut target_spec: Option<String> = None;
    let mut defines: Vec<(String, String)> = Vec::new();
    let mut undefines: Vec<String> = Vec::new();
    let mut include_paths: Vec<String> = Vec::new();
    let mut quote_include_paths: Vec<String> = Vec::new();
    let mut force_includes: Vec<String> = Vec::new();
    // gcc `-H`-shape include tracing. When on, the preprocessor
    // records one line per `#include` resolve (with leading-dot
    // depth) and the CLI flushes the list to stderr after
    // compilation. Useful for diagnosing "why did this header land
    // here" or "why didn't this header resolve" without poking the
    // amalgamated `__BADC_DUMP_PP` output.
    let mut show_includes = false;
    // gcc `-M` flag family: make-syntax dependency output. See
    // `DepOptions`; assembled after parsing.
    let mut dep_kind: Option<DepKind> = None;
    let mut dep_system = true;
    let mut dep_file: Option<String> = None;
    let mut dep_targets: Vec<String> = Vec::new();
    let mut dep_phony = false;
    let mut dep_target_from_output = false;
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
    // `-m16` / `-m32` as the user spelled it. Its presence selects
    // ELFCLASS32 for a `-c` object; the spelling is what the
    // diagnostic for a `.c` source under it names.
    let mut code_model_flag: Option<String> = None;
    let mut mno_fp_regs = false;
    let mut mstrict_align = false;
    let mut fpic = false;
    // `-fno-pic` / `-fno-pie`, tracked apart from `fpic` because the
    // absence of any PIC flag and an explicit opt-out choose different
    // `const` placements in a `-c` object; see `NativeOptions::pic_link`.
    let mut fno_pic = false;
    let mut jump_tables = true;
    let mut min_function_alignment: u32 = 1;
    let mut code_model = badc::CodeModel::Small;
    let mut code_model_tiny = false;
    let mut hardening = badc::Hardening::NONE;
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
    // `--emit-relocs` -- keep the resolved relocations in the final
    // ELF image as `.rela.*` sections (GNU ld -q), for consumers that
    // relocate the image wholesale (the x86 KASLR relocs tool).
    let mut emit_relocs = false;
    // `--gnu` -- define the GCC identity macros (`__GNUC__` etc.).
    let mut gnu = false;
    // `-std=` -- a `gnu` dialect suppresses `__STRICT_ANSI__`, an `iso` /
    // `c` dialect defines it, as in gcc and clang. Without the flag the
    // conservative default stands: `--gnu` reports strict conformance so a
    // header takes its standard-C path for the GNU features badc lacks.
    let mut gnu_dialect = false;
    let mut gnu89_inline = false;
    // `-fshort-wchar` -- narrow `wchar_t` to an unsigned 16-bit type.
    let mut short_wchar = false;
    // `-fsigned-char` / `-funsigned-char`; `None` keeps the target ABI's
    // own plain-`char` signedness.
    let mut char_signed: Option<bool> = None;
    let mut nostdinc = false;
    let mut no_builtin = false;
    let mut no_builtin_fns: Vec<String> = Vec::new();
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
    // Linker-script link (`-T` / `--script`) and the GNU ld options
    // that shape it. A script switches the link to the per-input-
    // section engine in `lds_link`; without one the default family
    // layout stays byte-identical.
    let mut script_path: Option<PathBuf> = None;
    let mut orphan_handling = badc::OrphanHandling::Place;
    let mut build_id_sha1 = false;
    let mut max_page_size: Option<u64> = None;
    let mut pack_relative_relocs = false;
    let mut apply_dynamic_relocs = true;
    let mut ld_strip_debug = false;
    let mut discard_locals = false;
    let mut discard_none = false;
    // `--whole-archive` spans, as half-open ranges over the positional
    // input indexes (`args` grows one entry per positional).
    let mut wa_ranges: Vec<(usize, usize)> = Vec::new();
    let mut wa_open: Option<usize> = None;
    // `--jobs N` / `-jN` sets the compile-parallelism factor N: the
    // driver compiles independent `.c` sources in up to 2*N worker
    // threads (capped at the source count). `None` leaves N at the host
    // parallelism default, resolved once the source count is known.
    let mut jobs: Option<usize> = None;

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
            "-Map" => match iter.next() {
                Some(p) => map_path = Some(PathBuf::from(p)),
                None => {
                    eprint_diagnostic("badc: error: -Map requires a file argument");
                    std::process::exit(1);
                }
            },
            s if s.starts_with("-Map=") => {
                map_path = Some(PathBuf::from(&s["-Map=".len()..]));
            }
            // `-M` is gcc's dependency-output flag, handled below. The
            // link map keeps the long spelling; GNU ld's `-M` belongs
            // to the linker persona, which parses separately.
            "--print-map" => print_map = true,
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
            // gcc / clang -iquote DIR: a search path for `#include "..."`
            // only, probed after the including file's directory and
            // before the -I paths.
            "-iquote" => match iter.next() {
                Some(p) => quote_include_paths.push(p),
                None => {
                    eprint_diagnostic("badc: error: -iquote requires a path argument");
                    std::process::exit(1);
                }
            },
            s if s.starts_with("-iquote") && s.len() > 7 => {
                quote_include_paths.push(s[7..].to_string());
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
            // gcc `-M` family -- make-syntax dependency output. `-M` /
            // `-MM` write the rule and compile nothing; `-MD` / `-MMD`
            // write it beside the normal output. The `MM` spellings
            // drop system headers. Later flags win, as with gcc.
            "-M" | "-MM" | "-MD" | "-MMD" => {
                dep_kind = Some(if arg == "-M" || arg == "-MM" {
                    DepKind::Only
                } else {
                    DepKind::WithOutput
                });
                dep_system = arg == "-M" || arg == "-MD";
                // gcc's driver names the rule after `-o` for the
                // compile-too spellings by injecting `-MQ <object>`.
                dep_target_from_output = matches!(arg.as_str(), "-MD" | "-MMD");
            }
            "-MP" => dep_phony = true,
            "-MF" | "-MT" | "-MQ" => match iter.next() {
                Some(v) => match arg.as_str() {
                    "-MF" => dep_file = Some(v),
                    // `-MT` takes the target verbatim; `-MQ` quotes it
                    // for make.
                    "-MT" => dep_targets.push(v),
                    _ => dep_targets.push(badc::dep_escape(&v)),
                },
                None => {
                    eprint_diagnostic(format!("badc: error: {arg} requires an argument"));
                    std::process::exit(1);
                }
            },
            // gcc hands a `-Wp,` payload's comma-separated pieces to the
            // preprocessor. There `-MD` / `-MMD` take the output path as
            // an operand, which is how kbuild requests dependency files
            // (`-Wp,-MMD,<path>`). Reaching the preprocessor directly
            // means no `-o`-derived rule name applies, so the rule keeps
            // the source-derived default -- gcc behaves the same, and
            // the kernel's `fixdep` discards the rule name regardless.
            s if s.starts_with("-Wp,") => {
                let mut parts = s["-Wp,".len()..].split(',');
                while let Some(p) = parts.next() {
                    match p {
                        "-MD" | "-MMD" => match parts.next() {
                            Some(path) => {
                                dep_kind = Some(DepKind::WithOutput);
                                dep_system = p == "-MD";
                                dep_file = Some(path.to_string());
                                dep_target_from_output = false;
                            }
                            None => {
                                eprint_diagnostic(format!(
                                    "badc: error: `-Wp,{p}` requires a file operand"
                                ));
                                std::process::exit(1);
                            }
                        },
                        "-MP" => dep_phony = true,
                        _ => {
                            eprint_diagnostic(format!(
                                "badc: error: unsupported preprocessor option `{p}` in `{s}`"
                            ));
                            std::process::exit(1);
                        }
                    }
                }
            }
            // `-Wa,<opt>[,<opt>...]` and `-Xassembler <opt>`: gcc's two
            // spellings for handing an option to the assembler. badc's
            // assembler is built in, so each option is checked against what
            // it implements rather than passed on.
            s if s.starts_with("-Wa,") => {
                for opt in s["-Wa,".len()..].split(',') {
                    if let Err(e) = accept_assembler_option(opt) {
                        eprint_diagnostic(e);
                        std::process::exit(1);
                    }
                }
            }
            "-Xassembler" => match iter.next() {
                Some(opt) => {
                    if let Err(e) = accept_assembler_option(&opt) {
                        eprint_diagnostic(e);
                        std::process::exit(1);
                    }
                }
                None => {
                    eprint_diagnostic("badc: error: -Xassembler requires an option");
                    std::process::exit(1);
                }
            },
            // gcc's x86 code-mode selectors. `-m16` and `-m32` both put
            // the object out as ELFCLASS32 / EM_386, matching the
            // `as --32` gcc hands its assembler for either; the encoding
            // mode itself comes from `.code16` / `.code32` in the source.
            // `-m31` (s390) and `-mx32` name ABIs badc has no encoder or
            // container for.
            "-m64" => {}
            s @ ("-m16" | "-m32") => code_model_flag = Some(s.to_string()),
            s @ ("-m31" | "-mx32") => {
                eprint_diagnostic(format!(
                    "badc: error: `{s}` selects an ABI badc does not emit"
                ));
                std::process::exit(1);
            }
            // gcc-shape `-Wdead-store` -- enable the per-store
            // dead-store diagnostic. `-Wno-dead-store` is the
            // opt-out spelling.
            "-Wdead-store" => warn_dead_store = true,
            "-Wno-dead-store" => warn_dead_store = false,
            // Quiet mode -- silence informational output (per-source
            // progress, `info: wrote file <path>` lines). Errors
            // and warnings remain on stderr unchanged.
            "-q" | "--quiet" => quiet = true,
            // Keep compiler-generated code off the floating-point /
            // SIMD register file: gcc spells it `-mno-sse` on x86_64 and
            // `-mgeneral-regs-only` on aarch64. Freestanding environments
            // (OS kernels) run with that register file trapped, so any
            // access faults; see `NativeOptions::no_fp_regs`.
            "-mno-sse" | "-mgeneral-regs-only" => mno_fp_regs = true,
            // Keep every compiler-generated memory access naturally
            // aligned for its width. Code that runs with the MMU off
            // sees Device-typed memory, where an unaligned access
            // raises an alignment fault instead of being fixed up;
            // see `NativeOptions::strict_align`.
            "-mstrict-align" => mstrict_align = true,
            "-mno-strict-align" => mstrict_align = false,
            // Speculative-execution mitigations, in gcc's spellings. An
            // argument that is not implemented is rejected rather than
            // ignored: a hardening flag that compiles but does nothing
            // leaves the caller believing the output is mitigated.
            // The `thunk` kind wants a comdat thunk body in the object,
            // which badc does not produce.
            s if s.starts_with("-mindirect-branch=") => match &s["-mindirect-branch=".len()..] {
                "keep" => hardening.indirect_branch = badc::IndirectBranch::Keep,
                "thunk-extern" => hardening.indirect_branch = badc::IndirectBranch::ThunkExtern,
                "thunk-inline" => hardening.indirect_branch = badc::IndirectBranch::ThunkInline,
                other => {
                    eprint_diagnostic(format!(
                        "badc: error: unsupported argument `{other}` to `-mindirect-branch=` \
                             (supported: keep, thunk-extern, thunk-inline)"
                    ));
                    std::process::exit(1);
                }
            },
            s if s.starts_with("-mfunction-return=") => match &s["-mfunction-return=".len()..] {
                "keep" => hardening.function_return_thunk = false,
                "thunk-extern" => hardening.function_return_thunk = true,
                other => {
                    eprint_diagnostic(format!(
                        "badc: error: unsupported argument `{other}` to `-mfunction-return=` \
                             (supported: keep, thunk-extern)"
                    ));
                    std::process::exit(1);
                }
            },
            // Already unconditional: every compiler-generated indirect
            // branch takes its target from a register. The CS prefix is
            // gcc's for the generated-thunk kinds only, none for
            // `thunk-extern`.
            "-mindirect-branch-register" | "-mindirect-branch-cs-prefix" => {}
            s if s.starts_with("-mharden-sls=") => {
                for kind in s["-mharden-sls=".len()..].split(',') {
                    match kind {
                        "none" => {
                            hardening.sls_return = false;
                            hardening.sls_indirect_jmp = false;
                        }
                        "return" => hardening.sls_return = true,
                        "indirect-jmp" => hardening.sls_indirect_jmp = true,
                        "all" => {
                            hardening.sls_return = true;
                            hardening.sls_indirect_jmp = true;
                        }
                        other => {
                            eprint_diagnostic(format!(
                                "badc: error: unsupported argument `{other}` to `-mharden-sls=` \
                                 (supported: none, return, indirect-jmp, all)"
                            ));
                            std::process::exit(1);
                        }
                    }
                }
            }
            // `-fcf-protection=<kind>`: x86 control-flow enforcement.
            // `branch` is indirect-branch tracking, the `endbr64` landing
            // pads. `return` and `full` add the shadow stack, which needs
            // a return path badc does not emit.
            s if s.starts_with("-fcf-protection=") => match &s["-fcf-protection=".len()..] {
                "none" => hardening.cf_protection_branch = false,
                "branch" => hardening.cf_protection_branch = true,
                other => {
                    eprint_diagnostic(format!(
                        "badc: error: unsupported argument `{other}` to `-fcf-protection=` \
                             (supported: none, branch)"
                    ));
                    std::process::exit(1);
                }
            },
            // A `+`-joined AArch64 feature list. `standard` is gcc's
            // alias for `bti+pac-ret`. The `leaf` and `b-key` modifiers
            // of `pac-ret`, and `gcs`, are rejected: an accepted-but-
            // ignored spelling would build an object that claims a
            // protection it does not carry.
            s if s.starts_with("-mbranch-protection=") => {
                for feature in s["-mbranch-protection=".len()..].split('+') {
                    match feature {
                        "none" => {
                            hardening.bti = false;
                            hardening.pac_ret = false;
                        }
                        "bti" => hardening.bti = true,
                        "pac-ret" => hardening.pac_ret = true,
                        "standard" => {
                            hardening.bti = true;
                            hardening.pac_ret = true;
                        }
                        other => {
                            eprint_diagnostic(format!(
                                "badc: error: unsupported feature `{other}` in \
                                 `-mbranch-protection=` (supported: none, bti, \
                                 pac-ret, standard)"
                            ));
                            std::process::exit(1);
                        }
                    }
                }
            }
            // Position-independent relocatable output: no absolute
            // relocation reaches the object, so a consumer that
            // relocates it wholesale at load (or forbids absolute
            // references outright) can take it; see
            // `NativeOptions::pic`. badc's final images are always
            // position-independent, so the flag only chooses the
            // `-c` object's relocation shapes.
            "-fPIC" | "-fpic" | "-fPIE" | "-fpie" => {
                fpic = true;
                fno_pic = false;
            }
            "-fno-pic" | "-fno-PIC" | "-fno-pie" | "-fno-PIE" => {
                fpic = false;
                fno_pic = true;
            }
            // gcc / clang `-fno-jump-tables`: a switch never dispatches
            // through a table, only through the compare tree. Kernels
            // built with retpoline or indirect-branch tracking pass it
            // because a table dispatch is an indirect branch those
            // configurations must not take.
            "-fjump-tables" => jump_tables = true,
            "-fno-jump-tables" => jump_tables = false,
            // gcc `-fmin-function-alignment=N`: every function entry lands
            // on a multiple of N, which is how a kernel states
            // CONFIG_FUNCTION_ALIGNMENT. Unlike `-falign-functions` gcc
            // never skips a large gap under it, and badc never does either.
            s if s.starts_with("-fmin-function-alignment=") => {
                let spec = &s["-fmin-function-alignment=".len()..];
                match spec.parse::<u32>() {
                    Ok(n) if n.is_power_of_two() => min_function_alignment = n,
                    _ => {
                        eprint_diagnostic(format!(
                            "badc: error: `-fmin-function-alignment=` takes a \
                             power of two, got `{spec}`"
                        ));
                        std::process::exit(1);
                    }
                }
            }
            // Code model for `-c` objects; see `CodeModel`. `small` is
            // the default; `kernel` switches external-address
            // materialization to the sign-extended 32-bit absolute form
            // and is validated against the target below. The remaining
            // psABI models are not implemented.
            s if s.starts_with("-mcmodel=") => {
                code_model = match &s["-mcmodel=".len()..] {
                    "small" => badc::CodeModel::Small,
                    "kernel" => badc::CodeModel::Kernel,
                    // aarch64 `tiny` narrows the layout contract to
                    // +/-1MiB; the small-model form stays valid under it,
                    // so it lowers as small. Validated against the
                    // target below.
                    "tiny" => {
                        code_model_tiny = true;
                        badc::CodeModel::Small
                    }
                    other => {
                        eprint_diagnostic(format!(
                            "badc: error: unsupported code model `{other}` in \
                             `-mcmodel=` (supported: small, kernel; \
                             aarch64 also: tiny)"
                        ));
                        std::process::exit(1);
                    }
                };
            }
            // Keep resolved relocations in the final ELF image (ld -q).
            "--emit-relocs" => emit_relocs = true,
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
            // gcc / clang `-fgnu89-inline`: make the GNU89 inline
            // linkage model the unit default in place of C99's.
            "-fgnu89-inline" => gnu89_inline = true,
            "-fno-gnu89-inline" => gnu89_inline = false,
            // gcc / clang `-fshort-wchar`: `wchar_t` becomes an unsigned
            // 16-bit type on every target. It changes the layout of every
            // object holding a `wchar_t` or a wide literal, so it has to
            // reach the front end rather than be dropped as a no-op.
            "-fshort-wchar" => short_wchar = true,
            "-fno-short-wchar" => short_wchar = false,
            // gcc / clang `-fsigned-char` / `-funsigned-char`: C99
            // 6.2.5p15 leaves plain `char`'s signedness to the
            // implementation, and each selects one over the target
            // default. It changes every `char`-to-`int` conversion, so
            // it reaches the front end rather than being dropped.
            "-fsigned-char" | "-fno-unsigned-char" => char_signed = Some(true),
            "-funsigned-char" | "-fno-signed-char" => char_signed = Some(false),
            // gcc / clang `-fno-builtin` and `-ffreestanding`: a call
            // spelled with a library function's own name is an ordinary
            // call the compiler may not fold. `-ffreestanding` also drops
            // the hosted assumption that such a name is declarable, which
            // is the auto-include retry. The `__builtin_` spellings are
            // unaffected, as under gcc.
            "-fno-builtin" | "-ffreestanding" => no_builtin = true,
            "-fbuiltin" | "-fhosted" => no_builtin = false,
            s if s.starts_with("-fno-builtin-") => {
                no_builtin_fns.push(s["-fno-builtin-".len()..].to_string());
            }
            // gcc / clang `-nostdinc`: the standard headers leave the
            // `#include` search, so a name no `-I` / `-iquote` path carries
            // is an error rather than a bind to badc's bundled libc. A
            // freestanding tree that supplies its own headers passes it.
            "-nostdinc" => nostdinc = true,
            // gcc / clang `-std=<dialect>`: the language the unit is
            // written in. badc compiles C99 with the GNU extensions
            // always available, so the dialect selects only whether
            // `__STRICT_ANSI__` is defined -- the macro headers read as
            // "the user asked for ISO C".
            _ if arg.starts_with("-std=") => {
                // The C dialect families gcc names: `cNN` / `gnuNN` and the
                // `iso9899:` spellings, which are strict ISO. A name outside
                // them is rejected rather than read as strict ISO, since a
                // caller that misspells the dialect gets the other one.
                let dialect = &arg["-std=".len()..];
                let known = dialect.starts_with("gnu")
                    || dialect.starts_with("iso9899:")
                    || (dialect.starts_with('c')
                        && dialect[1..].chars().all(|c| c.is_ascii_digit())
                        && dialect.len() > 1);
                if !known {
                    eprintln!("badc: error: unknown C dialect `{dialect}` (-std=)");
                    std::process::exit(1);
                }
                gnu_dialect = dialect.starts_with("gnu");
            }
            // `-c` / `--compile-only` -- emit a c5 object file
            // (`.o`) per source instead of linking through to a
            // native binary. The output goes to either the
            // explicit -o path (when one source is named) or
            // `<stem>.o` next to each input.
            "-c" | "--compile-only" => compile_only = true,
            // Build parallelism. `--jobs N` / `--jobs=N` / `-j N` /
            // `-jN` set N; the driver runs up to 2*N compile workers.
            // The attached `-jN` form only matches an all-digit suffix
            // so an unknown `-jXXX` flag still reports as unknown below.
            "--jobs" | "-j" => match iter.next() {
                Some(n) => jobs = Some(parse_jobs(&n)),
                None => {
                    eprint_diagnostic("badc: error: --jobs (-j) requires a positive integer N");
                    std::process::exit(1);
                }
            },
            s if s.starts_with("--jobs=") => jobs = Some(parse_jobs(&s["--jobs=".len()..])),
            s if s.starts_with("-j")
                && s.len() > 2
                && s[2..].bytes().all(|b| b.is_ascii_digit()) =>
            {
                jobs = Some(parse_jobs(&s[2..]));
            }
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
            // GNU ld surface for script-driven links. `-T FILE` /
            // `--script=FILE` select the script; the rest mirror the
            // options the Linux kernel build passes to `ld`.
            "-T" | "--script" => match iter.next() {
                Some(p) => script_path = Some(PathBuf::from(p)),
                None => {
                    eprint_diagnostic("badc: error: -T/--script requires a file argument");
                    std::process::exit(1);
                }
            },
            s if s.starts_with("--script=") => {
                script_path = Some(PathBuf::from(&s["--script=".len()..]));
            }
            s if s.starts_with("-T") && s.len() > 2 => {
                script_path = Some(PathBuf::from(&s[2..]));
            }
            s if s.starts_with("--orphan-handling=") => {
                orphan_handling = match &s["--orphan-handling=".len()..] {
                    "place" => badc::OrphanHandling::Place,
                    "warn" => badc::OrphanHandling::Warn,
                    "error" => badc::OrphanHandling::Error,
                    "discard" => badc::OrphanHandling::Discard,
                    other => {
                        eprint_diagnostic(format!(
                            "badc: error: --orphan-handling=`{other}`: expected \
                             place, warn, error, or discard"
                        ));
                        std::process::exit(1);
                    }
                };
            }
            "--build-id" => build_id_sha1 = true,
            s if s.starts_with("--build-id=") => match &s["--build-id=".len()..] {
                "sha1" => build_id_sha1 = true,
                "none" => build_id_sha1 = false,
                other => {
                    eprint_diagnostic(format!(
                        "badc: error: --build-id=`{other}` is not supported (sha1, none)"
                    ));
                    std::process::exit(1);
                }
            },
            // `-z keyword`: page-size and packing keywords take
            // effect; the hardening keywords the kernel passes
            // describe states this linker already emits.
            "-z" => match iter.next() {
                Some(kw) => match kw.as_str() {
                    s if s.starts_with("max-page-size=") => {
                        let body = &s["max-page-size=".len()..];
                        let parsed = if let Some(hex) = body.strip_prefix("0x") {
                            u64::from_str_radix(hex, 16).ok()
                        } else {
                            body.parse::<u64>().ok()
                        };
                        match parsed {
                            Some(n) if n.is_power_of_two() => max_page_size = Some(n),
                            _ => {
                                eprint_diagnostic(
                                    "badc: error: -z max-page-size requires a power of two",
                                );
                                std::process::exit(1);
                            }
                        }
                    }
                    "pack-relative-relocs" => pack_relative_relocs = true,
                    "nopack-relative-relocs" => pack_relative_relocs = false,
                    "noexecstack" | "execstack" | "norelro" | "relro" | "notext" | "text"
                    | "now" | "lazy" | "defs" | "nodefault" | "muldefs" => {}
                    other => {
                        eprint_diagnostic(format!("badc: error: unknown -z keyword `{other}`"));
                        std::process::exit(1);
                    }
                },
                None => {
                    eprint_diagnostic("badc: error: -z requires a keyword");
                    std::process::exit(1);
                }
            },
            "--strip-debug" | "-S" => ld_strip_debug = true,
            "-X" | "--discard-locals" => discard_locals = true,
            "--discard-none" => discard_none = true,
            "--no-apply-dynamic-relocs" => apply_dynamic_relocs = false,
            // Accepted with no effect on output: diagnostics-shaping
            // and emulation flags from ld command lines.
            "--fatal-warnings"
            | "--no-warn-rwx-segments"
            | "--no-undefined"
            | "-EL"
            | "--pic-veneer"
            | "-Bsymbolic"
            | "--no-ld-generated-unwind-info" => {}
            "--fix-cortex-a53-843419" => {
                // Erratum veneer generation is not implemented; the
                // sequences the workaround rewrites must be absent.
                // TODO: scan for adrp-at-0xff8/0xffc patterns and
                // materialise veneers.
                eprintln!(
                    "badc: note: --fix-cortex-a53-843419 accepted; erratum veneers are not \
                     generated"
                );
            }
            // ld accepts the emulation joined (`-maarch64linux`) or
            // separate (`-m aarch64linux`).
            s @ ("-melf_x86_64" | "-maarch64linux" | "-maarch64elf") => {
                let spec = if s == "-melf_x86_64" {
                    "linux-x64"
                } else {
                    "linux-aarch64"
                };
                if target_spec.is_none() {
                    target_spec = Some(spec.to_string());
                }
            }
            "-m" => match iter.next() {
                Some(emu) => {
                    let spec = match emu.as_str() {
                        "elf_x86_64" => Some("linux-x64"),
                        "aarch64linux" | "aarch64elf" => Some("linux-aarch64"),
                        _ => None,
                    };
                    match spec {
                        Some(t) if target_spec.is_none() => target_spec = Some(t.to_string()),
                        Some(_) => {}
                        None => {
                            eprint_diagnostic(format!("badc: error: unknown emulation `{emu}`"));
                            std::process::exit(1);
                        }
                    }
                }
                None => {
                    eprint_diagnostic("badc: error: -m requires an emulation name");
                    std::process::exit(1);
                }
            },
            "-shared" => claim(&mut mode, Mode::SharedLibrary),
            "--whole-archive" => wa_open = Some(args.len()),
            "--no-whole-archive" => {
                if let Some(start) = wa_open.take() {
                    wa_ranges.push((start, args.len()));
                }
            }
            // Group markers: the script-link archive loop already
            // rescans every archive to a fixed point.
            "--start-group" | "--end-group" => {}
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

    // On-disk copies of the bundled headers, consulted by name in place
    // of the in-binary body: the source tree this badc was built from,
    // then the `badc --install` overlay under ~/.badc (or $BADC_HOME).
    // Editing either takes effect without rebuilding badc. Anchored on
    // the executable and on $HOME, never on the working directory: the
    // include search path must not depend on where badc is invoked from.
    // An explicit -I still shadows a bundled name, as in every other
    // compiler; only a bundled header's own includes stay inside the set.
    // An explicitly set $BADC_HOME is a deliberate choice and outranks the
    // source tree; the implicit ~/.badc does not, so a stale `--install`
    // there cannot shadow the tree a developer is editing.
    let home_include = badc_home()
        .map(|h| h.join("include"))
        .filter(|d| d.is_dir());
    let mut own_header_roots: Vec<String> = Vec::new();
    let mut add = |d: Option<PathBuf>| {
        if let Some(d) = d {
            let s = d.to_string_lossy().into_owned();
            if !own_header_roots.contains(&s) {
                own_header_roots.push(s);
            }
        }
    };
    if std::env::var_os("BADC_HOME").is_some() {
        add(home_include);
        add(source_tree_include());
    } else {
        add(source_tree_include());
        add(home_include);
    }
    // `~/.badc/lib` joins the `-l` archive search, after explicit -L.
    if let Some(home) = badc_home() {
        let dir = home.join("lib");
        if dir.is_dir() {
            let s = dir.to_string_lossy().into_owned();
            if !library_paths.contains(&s) {
                library_paths.push(s);
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

    // The host's implicit system include path, probed after the bundled
    // headers so a hosted native build resolves third-party headers
    // (`zlib.h`, `libfdt.h`) without shadowing the embedded standard set.
    let system_include_paths = default_system_include_paths(target, freestanding);

    // The kernel model rewrites external addresses into sign-extended
    // 32-bit absolutes, defined by the x86-64 psABI for images linked in
    // the top 2GB. It shapes relocatable output only: badc's own images
    // are position-independent and cannot carry an absolute text
    // reference, and `-fPIC` contradicts it the same way (gcc rejects
    // the combination).
    // `tiny` is an aarch64 model (gcc: tiny/small/large there,
    // small/kernel/medium/large on x86-64).
    if code_model_tiny && target != badc::Target::LinuxAarch64 {
        eprint_diagnostic(
            "badc: error: `-mcmodel=tiny` requires an aarch64 ELF target \
             (--target=linux-aarch64)",
        );
        std::process::exit(1);
    }
    if code_model == badc::CodeModel::Kernel {
        if target != badc::Target::LinuxX64 {
            eprint_diagnostic(
                "badc: error: `-mcmodel=kernel` requires an x86-64 ELF target \
                 (--target=linux-x64)",
            );
            std::process::exit(1);
        }
        if fpic {
            eprint_diagnostic(
                "badc: error: code model `kernel` does not support \
                 position-independent output (-fPIC/-fPIE)",
            );
            std::process::exit(1);
        }
        // Modes that emit no native code (`-E`, --list-symbols, ...)
        // leave the flag inert, as gcc does.
        let emits_native = matches!(
            mode,
            Mode::NativeExecutable | Mode::SharedLibrary | Mode::Jit | Mode::Interp
        );
        if emits_native && !compile_only {
            eprint_diagnostic(
                "badc: error: `-mcmodel=kernel` shapes relocatable objects; \
                 it requires `-c` or `--ar`",
            );
            std::process::exit(1);
        }
    }

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

    // The link map describes a completed link.
    if (map_path.is_some() || print_map)
        && (compile_only || !matches!(mode, Mode::NativeExecutable | Mode::SharedLibrary))
    {
        eprintln!(
            "badc: -Map / --print-map require a link (current mode is {})",
            if compile_only { "-c" } else { mode.flag_name() }
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
    if let Some(start) = wa_open.take() {
        wa_ranges.push((start, args.len()));
    }
    let mut sources: Vec<String> = Vec::new();
    let mut objects: Vec<String> = Vec::new();
    let mut archives: Vec<String> = Vec::new();
    // Parallel to `archives`: inside a `--whole-archive` span.
    let mut archives_whole: Vec<bool> = Vec::new();
    // Objects and archives in command-line order for the script link.
    let mut link_inputs: Vec<LinkInputCli> = Vec::new();
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
            "c" | "" | "s" | "S" | "sx" => sources.push(a.clone()),
            "o" => {
                objects.push(a.clone());
                link_inputs.push(LinkInputCli::Object(a.clone()));
            }
            "a" => {
                let whole = wa_ranges.iter().any(|&(s, e)| s <= i && i < e);
                archives.push(a.clone());
                archives_whole.push(whole);
                link_inputs.push(LinkInputCli::Archive {
                    path: a.clone(),
                    whole,
                });
            }
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
                     (expected a `.c` / `.s` / `.S` source, `.o` object, or \
                     `.a` archive)"
                ));
                std::process::exit(1);
            }
        }
    }

    // A linker script switches to the script-driven link engine:
    // object/archive inputs only, laid out exactly as the script
    // directs. The default (scriptless) path below is untouched.
    if let Some(spath) = &script_path {
        if !matches!(mode, Mode::NativeExecutable | Mode::SharedLibrary) {
            eprint_diagnostic(format!(
                "badc: error: -T/--script requires a native link (current mode is {})",
                mode.flag_name()
            ));
            std::process::exit(1);
        }
        if !sources.is_empty() {
            eprint_diagnostic(
                "badc: error: -T/--script links take .o/.a inputs; compile sources with -c first",
            );
            std::process::exit(1);
        }
        let opts = ScriptLinkCli {
            script_path: spath.clone(),
            inputs: link_inputs,
            output_path,
            map_path,
            print_map,
            entry_override: cli_entry,
            shared: mode == Mode::SharedLibrary,
            orphan_handling,
            build_id_sha1,
            max_page_size,
            pack_relative_relocs,
            apply_dynamic_relocs,
            strip_debug: ld_strip_debug,
            discard_locals,
            discard_none,
            emit_relocs,
            quiet,
        };
        run_script_link(opts);
        return;
    }

    // Resolve `-l<name>` against the `-L<dir>` paths, then the standard
    // system directories. A shared object (`lib<name>.so`) is preferred
    // over a static archive (`lib<name>.a`), matching `ld`'s default
    // search order: the `.so` becomes a DT_NEEDED dependency whose
    // exports resolve otherwise-undefined references, the `.a` a
    // positional archive whose members are pulled on demand.
    let mut shared_libs: Vec<badc::SharedLibrary> = Vec::new();
    let mut search_paths: Vec<String> = library_paths.clone();
    for d in [
        "/usr/lib64",
        "/lib64",
        "/usr/lib",
        "/lib",
        "/usr/lib/x86_64-linux-gnu",
        "/usr/lib/aarch64-linux-gnu",
    ] {
        search_paths.push(d.to_string());
    }
    for name in &lib_names {
        match find_library(name, &search_paths, target) {
            Some(p) => {
                if let Err(e) = ingest_linker_input(
                    &p,
                    &search_paths,
                    target,
                    &mut shared_libs,
                    &mut archives,
                    0,
                ) {
                    eprintln!("badc: error: {e}");
                    std::process::exit(1);
                }
            }
            None => {
                let [shared, archive] = library_spellings(name, target);
                eprintln!(
                    "badc: cannot find `{shared}` or `{archive}` on any search path \
                     ({} probed)",
                    search_paths.len()
                );
                std::process::exit(1);
            }
        }
    }

    // A hosted executable link resolves undefined references against the
    // C library implicitly, the way a compiler driver's implicit `-lc`
    // does. libc is already a DT_NEEDED dependency; parsing its exports
    // lets a reference from a foreign object -- or a compiler-emitted
    // `memset` / `memcpy` -- resolve as a load-time import rather than a
    // link error. Only the real shared object is read (not the `libc.so`
    // linker script), so no extra DT_NEEDED entry is introduced.
    if mode == Mode::NativeExecutable && !freestanding {
        for cand in ["libc.so.6", "libc.so"] {
            if let Some(p) = search_paths
                .iter()
                .map(|d| std::path::Path::new(d).join(cand))
                .find(|p| p.exists())
            {
                let p = p.to_string_lossy().into_owned();
                let _ = ingest_linker_input(
                    &p,
                    &search_paths,
                    target,
                    &mut shared_libs,
                    &mut archives,
                    0,
                );
                break;
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

    // The VM has no assembler: it walks SSA and never sees an assembled
    // section, so an asm unit would run as an empty program. Refuse it
    // rather than run nothing.
    if matches!(mode, Mode::Jit | Mode::Interp)
        && let Some(src) = sources.iter().find(|s| SourceKind::of(s).is_asm())
    {
        eprint_diagnostic(format!(
            "badc: error: {} does not run assembly (`{src}`); assemble it with \
             -c and link the object",
            mode.flag_name()
        ));
        std::process::exit(1);
    }

    // badc generates no i386 machine code, so `-m16` / `-m32` reach
    // only the assembler, whose encoder already follows `.code16` /
    // `.code32`. A C source under either is refused by name rather
    // than compiled as x86-64 into an EM_386 container. The
    // preprocess-only modes are exempt from both restrictions, as they
    // are in gcc: they emit no code, and their output is a function of
    // the predefine set the flag selects.
    if let Some(flag) = &code_model_flag {
        // The flags name an x86 code model. gcc's AArch64 driver has no
        // `-m32`, and badc has no AArch32 encoder or predefine set.
        if !target.is_x86_64() {
            eprint_diagnostic(format!(
                "badc: error: `{flag}` selects an x86 code model; target is `{}`",
                target.id_str()
            ));
            std::process::exit(1);
        }
        let preprocess_only =
            mode == Mode::DumpPp || dep_kind == Some(DepKind::Only) && !compile_only;
        if !preprocess_only {
            if let Some(src) = sources.iter().find(|s| !SourceKind::of(s).is_asm()) {
                eprint_diagnostic(format!(
                    "badc: error: `{flag}` applies to assembly units only; `{src}` is a C source \
                     and badc emits no 32-bit code"
                ));
                std::process::exit(1);
            }
            // The class reaches the `-c` object only: badc writes no
            // 32-bit image, and its own linker reads ELFCLASS64 objects.
            if !compile_only && mode != Mode::BuildArchive {
                eprint_diagnostic(format!(
                    "badc: error: `{flag}` applies to `-c` output; badc links no 32-bit image"
                ));
                std::process::exit(1);
            }
        }
    }
    let object_elf_class = match code_model_flag {
        Some(_) => badc::ElfClass::Elf32,
        None => badc::ElfClass::Elf64,
    };

    let deps = dep_kind.map(|kind| DepOptions {
        kind,
        system: dep_system,
        file: dep_file,
        targets: dep_targets,
        phony: dep_phony,
        // Under `-E` the `-o` operand names the preprocessed text, not an
        // object, so the rule keeps gcc's default target -- the source stem
        // with `.o` -- rather than naming a file no rule builds.
        target_from_output: dep_target_from_output && mode != Mode::DumpPp,
    });
    // One dependency file cannot describe several translation units.
    // gcc truncates it per unit, leaving only the last; badc compiles
    // units in parallel, where that would race, so it is refused.
    if let Some(d) = &deps
        && d.file.is_some()
        && sources.len() > 1
    {
        eprint_diagnostic(format!(
            "badc: error: a single dependency file cannot describe {} translation \
             units (drop -MF / -Wp,-M[M]D or compile one source at a time)",
            sources.len()
        ));
        std::process::exit(1);
    }
    // `-MD` / `-MMD` describe a translation unit the run processes, which
    // `-c`, the executable / shared-library link and `-E` all do. Refuse the
    // other modes rather than accept the flag and write nothing.
    if let Some(d) = &deps
        && d.kind == DepKind::WithOutput
        && !compile_only
        && !matches!(
            mode,
            Mode::NativeExecutable | Mode::SharedLibrary | Mode::DumpPp
        )
    {
        eprint_diagnostic(format!(
            "badc: error: {} produces no translation-unit output to describe, \
             so -MD / -MMD would write nothing (use -M / -MM for a rule \
             without compiling)",
            mode.flag_name()
        ));
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
    // The pre-read every mode that resolves `-` through `read_tu_source`
    // shares, so a `--jobs` worker never touches the process stream.
    let stdin_src_of = |srcs: &[String]| -> Option<String> {
        srcs.iter().any(|s| s == "-").then(&read_stdin_source)
    };

    // `-M` / `-MM` preprocess only: emit the rule and produce no
    // object, as gcc does.
    if let Some(d) = &deps
        && d.kind == DepKind::Only
    {
        let stderr_is_tty = std::io::stderr().is_terminal();
        let mut failed = false;
        for src in &sources {
            let contents = if src == "-" {
                read_stdin_source()
            } else {
                match std::fs::read_to_string(src) {
                    Ok(s) => s,
                    Err(e) => {
                        eprint_diagnostic(format!("badc: error: cannot read `{src}`: {e}"));
                        std::process::exit(1);
                    }
                }
            };
            let copts = badc::CompileOptions::default()
                .with_gnu(gnu)
                .with_gnu89_inline(gnu89_inline)
                .with_short_wchar(short_wchar)
                .with_char_signed(char_signed)
                .with_nostdinc(nostdinc)
                .with_no_builtin(no_builtin)
                .with_no_builtin_fns(no_builtin_fns.clone())
                .with_gnu_dialect(gnu_dialect)
                .with_asm_source(SourceKind::of(src).is_asm())
                .with_defines(tu_defines(src, &defines))
                .with_undefines(undefines.clone())
                .with_include_paths(include_paths.clone())
                .with_quote_include_paths(quote_include_paths.clone())
                .with_system_include_paths(system_include_paths.clone())
                .with_own_header_roots(own_header_roots.clone())
                .with_force_includes(force_includes.clone())
                .with_source_label(src.clone())
                .with_track_includes(true)
                .with_elf_class(object_elf_class)
                .with_code_model(code_model);
            let compiler = badc::Compiler::with_options(contents, target, copts);
            let mut log = TuLog::default();
            if show_includes {
                for line in compiler.include_trace() {
                    log.raw(line);
                }
            }
            for w in compiler.preprocess_warnings() {
                log.diag(stderr_is_tty, w);
            }
            // An unresolved `#include` leaves the prerequisite list
            // incomplete, so report it and write nothing, as gcc does.
            let res = match compiler.preprocess_error() {
                Some(e) => {
                    log.diag(stderr_is_tty, e);
                    Err(())
                }
                None => emit_deps(
                    src,
                    compiler.include_records(),
                    d,
                    output_path.as_deref(),
                    &mut log,
                    stderr_is_tty,
                ),
            };
            log.flush();
            failed |= res.is_err();
        }
        if failed {
            std::process::exit(1);
        }
        return;
    }

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
            .with_gnu89_inline(gnu89_inline)
            .with_short_wchar(short_wchar)
            .with_char_signed(char_signed)
            .with_nostdinc(nostdinc)
            .with_no_builtin(no_builtin)
            .with_no_builtin_fns(no_builtin_fns.clone())
            .with_gnu_dialect(gnu_dialect)
            .with_optimize(optimize_flag)
            .with_defines(defines.clone())
            .with_undefines(undefines.clone())
            .with_include_paths(include_paths.clone())
            .with_quote_include_paths(quote_include_paths.clone())
            .with_system_include_paths(system_include_paths.clone())
            .with_own_header_roots(own_header_roots.clone())
            .with_force_includes(force_includes.clone())
            .with_source_label(src_path.clone())
            .with_track_includes(show_includes)
            .with_warn_dead_store(warn_dead_store);
        let compiler = Compiler::with_options(contents, target, copts);
        if show_includes {
            for line in compiler.include_trace() {
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

    // `--dump-pp` / `-E` preprocesses each source and exits: no link,
    // no codegen. `-o <path>` names the file the expansion goes to and
    // `-o -` names stdout, as in gcc and clang; without `-o` it goes to
    // stdout. A multi-source dump prefixes each unit with a
    // `--- <label> ---` marker on stderr so the preprocessed bytes on
    // stdout stay parseable, and takes no `-o`: one output stream
    // cannot hold several expansions, which is why gcc and clang refuse
    // the combination too.
    if mode == Mode::DumpPp {
        let multi_tu = sources.len() > 1;
        if output_path.is_some() && multi_tu {
            eprintln!(
                "badc: `-o <path>` together with `-E` requires exactly one \
                 source input ({} given)",
                sources.len()
            );
            std::process::exit(1);
        }
        let pp_output = output_path.as_deref().filter(|p| p.as_os_str() != "-");
        // `-MD` / `-MMD` alongside `-E`: gcc preprocesses and writes the
        // rule, naming the file from `-MF` / `-Wp,-M[M]D,<path>` / `-o` as
        // it does for a compile.
        let dump_deps = deps.as_ref().filter(|d| d.kind == DepKind::WithOutput);
        let stderr_is_tty = std::io::stderr().is_terminal();
        let mut dep_failed = false;
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
                .with_gnu89_inline(gnu89_inline)
                .with_short_wchar(short_wchar)
                .with_char_signed(char_signed)
                .with_nostdinc(nostdinc)
                .with_no_builtin(no_builtin)
                .with_no_builtin_fns(no_builtin_fns.clone())
                .with_gnu_dialect(gnu_dialect)
                .with_optimize(optimize_flag)
                .with_asm_source(SourceKind::of(src_path).is_asm())
                .with_defines(tu_defines(src_path, &defines))
                .with_undefines(undefines.clone())
                .with_include_paths(include_paths.clone())
                .with_quote_include_paths(quote_include_paths.clone())
                .with_system_include_paths(system_include_paths.clone())
                .with_own_header_roots(own_header_roots.clone())
                .with_force_includes(force_includes.clone())
                .with_source_label(label.clone())
                .with_track_includes(dump_deps.is_some())
                .with_elf_class(object_elf_class)
                .with_code_model(code_model);
            match Compiler::preprocess_tracked(contents, target, opts) {
                Ok((s, records)) => {
                    if multi_tu {
                        eprintln!("--- {label} ---");
                    }
                    match pp_output {
                        Some(p) => {
                            if let Err(e) = std::fs::write(p, &s) {
                                eprint_diagnostic(format!(
                                    "badc: error: failed to write {}: {e}",
                                    p.display()
                                ));
                                std::process::exit(1);
                            }
                        }
                        None => print!("{s}"),
                    }
                    if let Some(d) = dump_deps {
                        let mut log = TuLog::default();
                        let res = emit_deps(
                            src_path,
                            &records,
                            d,
                            output_path.as_deref(),
                            &mut log,
                            stderr_is_tty,
                        );
                        log.flush();
                        dep_failed |= res.is_err();
                    }
                }
                Err(e) => {
                    eprint_diagnostic(e);
                    std::process::exit(1);
                }
            }
        }
        if dep_failed {
            std::process::exit(1);
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
        let mut stats = LinkStats::new();
        let mut native_objs: Vec<badc::NativeObject> =
            Vec::with_capacity(sources.len() + objects.len() + archives.len());

        let mut reloc_opts = badc::NativeOptions::new()
            .with_debug_info(emit_debug_info)
            .with_inline_cap(inline_cap);
        reloc_opts.no_fp_regs = mno_fp_regs;
        reloc_opts.strict_align = mstrict_align;
        reloc_opts.jump_tables = jump_tables;
        reloc_opts.min_function_alignment = min_function_alignment;
        reloc_opts.pic = fpic;
        // These objects are linked into an image below, and every image
        // this toolchain writes takes its data relocations at load time
        // (ELF ET_DYN, PE base relocations, Mach-O dyld rebases), so a
        // relocated `const` cannot ride the read-only prefix and must
        // not cost the unit's pure `const` objects their place in it.
        reloc_opts.pic_link = true;
        reloc_opts.code_model = code_model;
        reloc_opts.hardening = hardening;
        reloc_opts.elf_class = object_elf_class;
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
        // `.c` -> in-memory native ELF64 ET_REL: each source compiles
        // straight to ET_REL bytes that `parse_native_elf` reads back,
        // so no intermediate `.o` is written to disk.
        let stdin_src = stdin_src_of(&sources);
        let cfg = CompileCfg {
            target,
            reloc_opts,
            gnu,
            gnu_dialect,
            gnu89_inline,
            short_wchar,
            char_signed,
            nostdinc,
            no_builtin,
            no_builtin_fns: &no_builtin_fns,
            optimize_flag,
            export_all,
            show_includes,
            warn_dead_store,
            multi_tu,
            quiet,
            stderr_is_tty,
            defines: &defines,
            undefines: &undefines,
            include_paths: &include_paths,
            quote_include_paths: &quote_include_paths,
            system_include_paths: &system_include_paths,
            own_header_roots: &own_header_roots,
            force_includes: &force_includes,
            deps: deps.as_ref(),
            dep_output: output_path.as_deref(),
            stdin_src: stdin_src.as_deref(),
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
                .with_gnu89_inline(gnu89_inline)
                .with_short_wchar(short_wchar)
                .with_char_signed(char_signed)
                .with_nostdinc(nostdinc)
                .with_no_builtin(no_builtin)
                .with_no_builtin_fns(no_builtin_fns.clone())
                .with_gnu_dialect(gnu_dialect)
                .with_optimize(optimize_flag)
                .with_defines(copts_defines)
                .with_undefines(undefines.clone())
                .with_include_paths(include_paths.clone())
                .with_system_include_paths(system_include_paths.clone())
                .with_own_header_roots(own_header_roots.clone())
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
        // Compile every source (concurrently under `--jobs`), then fold
        // the per-unit facts in source order so entry / subsystem
        // resolution and object order stay scheduling-independent.
        let workers = worker_count(jobs, sources.len());
        let tus = compile_units(&sources, workers, |_, src| {
            compile_native_tu(src, &[], &cfg)
        });
        for (i, mut tu) in tus.into_iter().enumerate() {
            if entry_override.is_none() {
                entry_override = tu.entry;
            }
            if subsystem_override.is_none() {
                subsystem_override = tu.subsystem;
            }
            source_auto_includes.push(tu.auto_includes);
            tu.obj.source = sources[i].clone();
            native_objs.push(tu.obj);
        }
        stats.mark("compile");
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
        // An installed runtime source (`$BADC_HOME/lib/<name>`) replaces the
        // embedded copy on the header overlay's terms: an explicit
        // $BADC_HOME outranks the built-in, the implicit ~/.badc does not,
        // so a stale `--install` cannot shadow the tree a source build
        // carries.
        let runtime_dir = badc_home()
            .filter(|_| std::env::var_os("BADC_HOME").is_some() || source_tree_include().is_none())
            .map(|h| h.join("lib"));
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
                Ok(mut o) => {
                    o.source = label.clone();
                    native_objs.push(o);
                }
                Err(e) => {
                    eprint_diagnostic(format!("badc: {label}: {e}"));
                    std::process::exit(1);
                }
            }
        }
        stats.mark("runtime");
        for obj_path in &objects {
            let bytes = match std::fs::read(obj_path) {
                Ok(b) => b,
                Err(e) => {
                    eprint_diagnostic(format!("badc: error: cannot read `{obj_path}`: {e}"));
                    std::process::exit(1);
                }
            };
            if !badc::is_native_object(&bytes) {
                eprint_diagnostic(format!(
                    "badc: error: `{obj_path}`: {}",
                    unreadable_object_reason(&bytes, target)
                ));
                std::process::exit(1);
            }
            match badc::parse_native_object(&bytes) {
                Ok(mut o) => {
                    o.source = obj_path.clone();
                    native_objs.push(o);
                }
                Err(e) => {
                    eprint_diagnostic(format!("badc: {obj_path}: {e}"));
                    std::process::exit(1);
                }
            }
        }
        stats.mark("parse");
        // Archive members join the link on demand: a member is
        // included iff it defines a symbol some already-included
        // object still leaves undefined, iterated to a fixpoint so a
        // pulled member's own references can pull further members
        // (from any archive). Unreferenced members stay out, so their
        // unrelated undefined or duplicate symbols cannot fail a
        // valid link.
        let mut pending: Vec<Option<badc::NativeObject>> = Vec::new();
        for a_path in &archives {
            let bytes = match std::fs::read(a_path) {
                Ok(b) => b,
                Err(e) => {
                    eprint_diagnostic(format!("badc: error: cannot read `{a_path}`: {e}"));
                    std::process::exit(1);
                }
            };
            // A GNU thin archive stores only member paths; resolve them
            // against the archive's own directory.
            let base_dir = std::path::Path::new(a_path).parent();
            let members = match badc::read_archive_at(&bytes, base_dir) {
                Ok(m) => m,
                Err(e) => {
                    eprint_diagnostic(format!("badc: {a_path}: {e}"));
                    std::process::exit(1);
                }
            };
            for m in members {
                if !badc::is_native_object(&m.bytes) {
                    eprint_diagnostic(format!(
                        "badc: error: archive `{a_path}` member `{}`: {}",
                        m.name,
                        unreadable_object_reason(&m.bytes, target)
                    ));
                    std::process::exit(1);
                }
                match badc::parse_native_object(&m.bytes) {
                    Ok(mut o) => {
                        o.source = format!("{a_path}({})", m.name);
                        pending.push(Some(o));
                    }
                    Err(e) => {
                        eprint_diagnostic(format!("badc: {a_path}({}): {e}", m.name));
                        std::process::exit(1);
                    }
                }
            }
        }
        stats.mark("archives");
        // Compiler-runtime helpers (a libgcc / compiler-rt subset) and the
        // bundled C-library sources join the pool on demand, after the
        // user's archives so a real libgcc on the link line wins.
        // Source-level target gating leaves the object empty for a target
        // that references none of them, so it is never pulled. They are
        // compiled only when the selection over the real archives stalls
        // with symbols still undefined (or when the rebinding scan below
        // needs the pool's definitions), so a link that resolves
        // everything compiles none of them.
        let mut on_demand_loaded = false;
        let load_on_demand = |pending: &mut Vec<Option<badc::NativeObject>>,
                              stats: &mut LinkStats| {
            let on_demand = badc::embedded_compiler_rt()
                .iter()
                .map(|e| ("compiler-rt", e))
                .chain(badc::embedded_libc().iter().map(|e| ("libc", e)));
            for (dir, (name, body)) in on_demand {
                let label = format!("<{dir}/{name}>");
                let bytes = compile_in_memory(&label, body.to_string(), &[]);
                match badc::parse_native_elf(&bytes) {
                    Ok(mut o) => {
                        o.source = label;
                        pending.push(Some(o));
                    }
                    Err(e) => {
                        eprint_diagnostic(format!("badc: {label}: {e}"));
                        std::process::exit(1);
                    }
                }
            }
            stats.mark("rtlib");
        };
        // C89 6.3.2.2 link semantics: a definition anywhere in the
        // link set satisfies an implicitly declared call, so a name
        // the auto-include retry bound to a header's library binding
        // is recompiled as an implicit extern when an input defines
        // it -- the user's definition wins over the binding.
        if source_auto_includes.iter().any(|a| !a.is_empty()) {
            // The scan folds unpulled pool members into `defined_fns`, so
            // the on-demand sources must be in the pool here.
            if !on_demand_loaded {
                on_demand_loaded = true;
                load_on_demand(&mut pending, &mut stats);
            }
            let mut defined_fns = std::collections::HashSet::<String>::new();
            for o in native_objs.iter().chain(pending.iter().flatten()) {
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
                // The retry is sequential (rare, and only for sources
                // the link redefines); flush its log inline.
                let (log, res) = compile_native_tu(&sources[i], &redirect, &cfg);
                log.flush();
                match res {
                    Ok(mut tu) => {
                        tu.obj.source = sources[i].clone();
                        native_objs[i] = tu.obj;
                    }
                    Err(()) => std::process::exit(1),
                }
            }
        }
        let mut archive_inclusions: Vec<badc::ArchiveInclusion> = Vec::new();
        if !pending.is_empty() || !on_demand_loaded {
            let mut defined = hashbrown::HashSet::<String>::new();
            // Unresolved strong references, each keyed to the first
            // input that made it (the link map's "referenced by" file).
            let mut undefined = hashbrown::HashMap::<String, String>::new();
            // A global or weak definition satisfies references; only a
            // strong (STB_GLOBAL) undefined reference pulls a member,
            // matching ELF archive practice (a weak reference left
            // unresolved does not extract members).
            let account =
                |o: &badc::NativeObject,
                 defined: &mut hashbrown::HashSet<String>,
                 undefined: &mut hashbrown::HashMap<String, String>| {
                    for s in &o.symbols {
                        if s.binding == 0 {
                            continue;
                        }
                        if s.section == badc::NativeSymSection::Undef {
                            if s.binding == 1 && !defined.contains(&s.name) {
                                undefined
                                    .entry(s.name.clone())
                                    .or_insert_with(|| o.source.clone());
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
                undefined
                    .entry(entry.clone())
                    .or_insert_with(|| "<command line>".to_string());
            }
            // The archive symbol index lists strong section-resident
            // definitions; a member is pulled on exactly those. A pulled
            // member is taken out of its slot rather than removed from
            // the pool: an object is large, and compacting the pool per
            // pull would move every later member's record again.
            let mut progress = true;
            loop {
                while progress {
                    progress = false;
                    for slot in pending.iter_mut() {
                        let wanted = slot.as_ref().and_then(|o| {
                            o.symbols.iter().find_map(|s| {
                                (s.binding == 1
                                    && !matches!(
                                        s.section,
                                        badc::NativeSymSection::Undef | badc::NativeSymSection::Abs
                                    )
                                    && undefined.contains_key(&s.name))
                                .then(|| s.name.clone())
                            })
                        });
                        if let Some(symbol) = wanted {
                            let o = slot.take().expect("a wanted slot is occupied");
                            archive_inclusions.push(badc::ArchiveInclusion {
                                member: o.source.clone(),
                                referenced_by: undefined.get(&symbol).cloned().unwrap_or_default(),
                                symbol,
                            });
                            account(&o, &mut defined, &mut undefined);
                            native_objs.push(o);
                            progress = true;
                        }
                    }
                }
                // The real archives stalled; offer the on-demand
                // sources once and resume.
                if on_demand_loaded || undefined.keys().all(|n| badc::link_synthesized_symbol(n)) {
                    break;
                }
                on_demand_loaded = true;
                load_on_demand(&mut pending, &mut stats);
                progress = true;
            }
        }
        stats.mark("select");
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
        let mut merged = match badc::link_native_objects_with_shared_libs(
            &native_objs,
            allow_undefined,
            &shared_libs,
        ) {
            Ok(m) => m,
            Err(e) => {
                eprint_diagnostic(format!("badc: {e}"));
                std::process::exit(1);
            }
        };
        stats.mark("merge");
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
        stats.mark("plt");
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
            emit_relocs,
        );
        let bytes = match write_result {
            Ok(b) => b,
            Err(e) => {
                eprint_diagnostic(format!("badc: {e}"));
                std::process::exit(1);
            }
        };
        stats.mark("image");
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
        if map_path.is_some() || print_map {
            let out_name = out.file_name().and_then(|n| n.to_str()).unwrap_or("a.out");
            let map = match badc::render_link_map(&merged, &bytes, &archive_inclusions, out_name) {
                Ok(m) => m,
                Err(e) => {
                    eprint_diagnostic(format!("badc: {e}"));
                    std::process::exit(1);
                }
            };
            if let Some(p) = &map_path
                && let Err(e) = std::fs::write(p, &map)
            {
                eprint_diagnostic(format!(
                    "badc: error: cannot write map file `{}`: {e}",
                    p.display()
                ));
                std::process::exit(1);
            }
            if print_map {
                print!("{map}");
            }
        }
        stats.mark("write");
        stats.report(native_objs.len());
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
        let stdin_src = stdin_src_of(&sources);
        // Relocatable `-c` builds do not require `main`; the linker
        // picks the entry once it merges every TU.
        use badc::OutputKind;
        let mut reloc_opts = badc::NativeOptions::new()
            .with_debug_info(emit_debug_info)
            .with_inline_cap(inline_cap);
        reloc_opts.no_fp_regs = mno_fp_regs;
        reloc_opts.strict_align = mstrict_align;
        reloc_opts.jump_tables = jump_tables;
        reloc_opts.min_function_alignment = min_function_alignment;
        reloc_opts.pic = fpic;
        reloc_opts.pic_link = pic_link_default(fno_pic, code_model);
        reloc_opts.code_model = code_model;
        reloc_opts.hardening = hardening;
        reloc_opts.elf_class = object_elf_class;
        if optimize_flag {
            reloc_opts = reloc_opts.with_optimize();
        }
        if dump_ssa {
            reloc_opts = reloc_opts.with_dump_ssa();
        }
        reloc_opts.output_kind = OutputKind::Relocatable;
        let stderr_is_tty = std::io::stderr().is_terminal();
        let multi_tu = source_count > 1;
        let cfg = CompileCfg {
            target,
            reloc_opts,
            gnu,
            gnu_dialect,
            gnu89_inline,
            short_wchar,
            char_signed,
            nostdinc,
            no_builtin,
            no_builtin_fns: &no_builtin_fns,
            optimize_flag,
            export_all: false,
            show_includes,
            warn_dead_store,
            multi_tu,
            quiet,
            stderr_is_tty,
            defines: &defines,
            undefines: &undefines,
            include_paths: &include_paths,
            quote_include_paths: &quote_include_paths,
            system_include_paths: &system_include_paths,
            own_header_roots: &own_header_roots,
            force_includes: &force_includes,
            deps: deps.as_ref(),
            dep_output: output_path.as_deref(),
            stdin_src: stdin_src.as_deref(),
        };
        if let Some(out) = output_path.as_deref() {
            if source_count != 1 {
                eprintln!(
                    "badc: `-o <path>` together with `-c` requires exactly one \
                     source input ({} given)",
                    source_count
                );
                std::process::exit(1);
            }
            let (log, res) = compile_object_tu(&sources[0], &cfg);
            log.flush();
            let bytes = match res {
                Ok(b) => b,
                Err(()) => std::process::exit(1),
            };
            write_output(out, &bytes, target, quiet);
        } else {
            // Each worker writes its own `<stem>.o`, so write I/O runs in
            // the pool and each `info: wrote file` line stays grouped
            // with its source's diagnostics.
            let workers = worker_count(jobs, source_count);
            compile_units(&sources, workers, |_, src| {
                let (mut log, res) = compile_object_tu(src, &cfg);
                let bytes = match res {
                    Ok(b) => b,
                    Err(()) => return (log, Err(())),
                };
                // `-c` without `-o` names the object after the source in
                // the current directory, as the other C compilers do; a
                // makefile links `foo.o` from wherever it ran the compile.
                let out = std::path::Path::new(src)
                    .with_extension("o")
                    .file_name()
                    .map(std::path::PathBuf::from)
                    .unwrap_or_else(|| std::path::Path::new(src).with_extension("o"));
                match std::fs::write(&out, &bytes) {
                    Ok(()) => {
                        if !cfg.quiet {
                            log.diag(
                                cfg.stderr_is_tty,
                                format!(
                                    "info: wrote file {} for target {}",
                                    out.display(),
                                    cfg.target.id_str()
                                ),
                            );
                        }
                        (log, Ok(()))
                    }
                    Err(e) => {
                        log.diag(
                            cfg.stderr_is_tty,
                            format!("badc: error: failed to write {}: {e}", out.display()),
                        );
                        (log, Err(()))
                    }
                }
            });
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
        use badc::OutputKind;
        let mut reloc_opts = badc::NativeOptions::new()
            .with_debug_info(emit_debug_info)
            .with_inline_cap(inline_cap);
        reloc_opts.no_fp_regs = mno_fp_regs;
        reloc_opts.strict_align = mstrict_align;
        reloc_opts.jump_tables = jump_tables;
        reloc_opts.min_function_alignment = min_function_alignment;
        reloc_opts.pic = fpic;
        reloc_opts.pic_link = pic_link_default(fno_pic, code_model);
        reloc_opts.code_model = code_model;
        reloc_opts.hardening = hardening;
        reloc_opts.elf_class = object_elf_class;
        if optimize_flag {
            reloc_opts = reloc_opts.with_optimize();
        }
        if dump_ssa {
            reloc_opts = reloc_opts.with_dump_ssa();
        }
        reloc_opts.output_kind = OutputKind::Relocatable;
        let stderr_is_tty = std::io::stderr().is_terminal();
        let multi_tu = sources.len() > 1;
        let stdin_src = stdin_src_of(&sources);
        let cfg = CompileCfg {
            target,
            reloc_opts,
            gnu,
            gnu_dialect,
            gnu89_inline,
            short_wchar,
            char_signed,
            nostdinc,
            no_builtin,
            no_builtin_fns: &no_builtin_fns,
            optimize_flag,
            export_all: false,
            show_includes,
            warn_dead_store,
            multi_tu,
            quiet,
            stderr_is_tty,
            defines: &defines,
            undefines: &undefines,
            include_paths: &include_paths,
            quote_include_paths: &quote_include_paths,
            system_include_paths: &system_include_paths,
            own_header_roots: &own_header_roots,
            force_includes: &force_includes,
            // `--ar` bundles objects; gcc has no dependency-output
            // analogue for archive assembly.
            deps: None,
            dep_output: None,
            stdin_src: stdin_src.as_deref(),
        };
        let mut members: Vec<badc::ArchiveMember> = Vec::with_capacity(total_inputs);
        let mut sym_index: Vec<(usize, Vec<String>)> = Vec::with_capacity(total_inputs);
        // Compile every source (concurrently under `--jobs`), folding the
        // member bytes + defined-symbol index in source order. The member
        // name is the input's file stem with a `.o` suffix, matching a
        // plain `-c` per-source output.
        let workers = worker_count(jobs, sources.len());
        let compiled = compile_units(&sources, workers, |_, src| {
            let (mut log, res) = compile_object_tu(src, &cfg);
            match res {
                Ok(bytes) => {
                    match native_defined_globals_logged(&bytes, src, &mut log, cfg.stderr_is_tty) {
                        Ok(defined) => (log, Ok((bytes, defined))),
                        Err(()) => (log, Err(())),
                    }
                }
                Err(()) => (log, Err(())),
            }
        });
        for (i, (bytes, defined)) in compiled.into_iter().enumerate() {
            let base = std::path::Path::new(&sources[i])
                .file_stem()
                .map(|s| s.to_string_lossy().into_owned())
                .unwrap_or_else(|| format!("tu{i}"));
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
                    "badc: error: `{obj_path}`: {}",
                    unreadable_object_reason(&bytes, target)
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

/// Whether a `-c` / `--ar` object is laid out for a link that applies
/// its relocations after mapping; see [`badc::NativeOptions::pic_link`].
///
/// The default is that it is: this toolchain's own linker is the usual
/// consumer and every image it writes is `ET_DYN`, so a `const` object
/// carrying a relocation cannot ride the read-only prefix and would
/// otherwise cost its whole `.rodata` that placement. gcc reaches the
/// same layout wherever it is configured default-PIE.
///
/// Two inputs state the opposite -- a link that resolves the relocation
/// statically -- and keep such storage in `.rodata`: an explicit
/// `-fno-pic` / `-fno-pie`, and the kernel code model, which by
/// definition names a static link at fixed addresses.
fn pic_link_default(fno_pic: bool, code_model: badc::CodeModel) -> bool {
    !fno_pic && code_model != badc::CodeModel::Kernel
}

/// The host's default system header directories, probed after the
/// bundled headers (a compiler driver's implicit system include path).
/// Non-empty only for a hosted native build: the host's `/usr/include`
/// is the target's only when compiling for the host platform, so a
/// cross or `--freestanding` build returns empty and relies on `-I`.
/// Standard headers still resolve to the embedded copies (searched
/// first); only a header the embedded set lacks reaches these.
fn default_system_include_paths(target: badc::Target, freestanding: bool) -> Vec<String> {
    if freestanding {
        return Vec::new();
    }
    let native = cfg!(target_os = "linux")
        && ((cfg!(target_arch = "x86_64") && matches!(target, badc::Target::LinuxX64))
            || (cfg!(target_arch = "aarch64") && matches!(target, badc::Target::LinuxAarch64)));
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

/// Why the linker cannot read `bytes` as an input object, phrased in
/// the detected format's own terms. badc's relocatable format is ELF
/// on every target -- the target's container appears only in the final
/// image -- so a foreign object is named by what it is.
fn unreadable_object_reason(bytes: &[u8], target: Target) -> String {
    let reads = "badc links ELF relocatable objects on every target, \
                 and arm64 Mach-O relocatable objects";
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
fn library_spellings(name: &str, target: Target) -> [String; 2] {
    let ext = target.binary_format().shared_lib_ext();
    [format!("lib{name}.{ext}"), format!("lib{name}.a")]
}

/// Locate a `-l<name>` library on the search path. Prefers the
/// unversioned shared library, then a versioned one (shortest match --
/// the bare SONAME version), then the static archive. ELF spells the
/// version after the extension (`libfoo.so.3`), Mach-O and PE before
/// it (`libfoo.3.dylib`).
fn find_library(name: &str, search_paths: &[String], target: Target) -> Option<String> {
    let fmt = target.binary_format();
    let [shared, archive] = library_spellings(name, target);
    for dir in search_paths {
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
fn parse_ld_script_inputs(bytes: &[u8]) -> Vec<String> {
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
/// positionally; an ELF shared object is parsed for its SONAME +
/// exports; a binary in another container is rejected by name, since
/// the fallthrough would read it as a linker script and resolve to no
/// inputs at all; anything else is treated as a linker script whose
/// GROUP / INPUT / AS_NEEDED file list is resolved recursively.
fn ingest_linker_input(
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
    if bytes.starts_with(b"!<arch>\n") || bytes.starts_with(b"!<thin>\n") {
        archives.push(path.to_string());
    } else if bytes.starts_with(b"\x7fELF") {
        let mut lib = badc::parse_shared_library(&bytes)
            .map_err(|e| format!("reading `{path}` as a shared library: {e}"))?;
        if lib.soname.is_empty() {
            lib.soname = std::path::Path::new(path)
                .file_name()
                .map(|s| s.to_string_lossy().into_owned())
                .unwrap_or_else(|| path.to_string());
        }
        shared_libs.push(lib);
    } else if let Some(f) = badc::detect_binary_format(&bytes) {
        return Err(format!(
            "`{path}` is a {} binary; badc links ELF objects and ELF shared objects, \
             and static archives",
            f.name()
        ));
    } else {
        for entry in parse_ld_script_inputs(&bytes) {
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

/// Parse a `--jobs` / `-j` value: a positive integer. Exits with a
/// diagnostic on a non-integer or non-positive value.
fn parse_jobs(s: &str) -> usize {
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

/// Worker-thread count for `count` independent units: `2*N` capped at
/// the unit count, where N is `--jobs` or, absent it, the host's
/// available parallelism. C99 leaves build parallelism to the
/// implementation.
/// Per-phase wall clock for the native link, reported to stderr when
/// `BADC_LINK_STATS` is set. Off by default: `mark` is a load and a
/// branch, so an unset environment pays nothing measurable.
struct LinkStats {
    on: bool,
    marks: Vec<(&'static str, core::time::Duration)>,
    last: std::time::Instant,
}

impl LinkStats {
    fn new() -> Self {
        Self {
            on: std::env::var_os("BADC_LINK_STATS").is_some(),
            marks: Vec::new(),
            last: std::time::Instant::now(),
        }
    }

    /// Close the phase that ended here and name it.
    fn mark(&mut self, phase: &'static str) {
        if !self.on {
            return;
        }
        let now = std::time::Instant::now();
        self.marks.push((phase, now - self.last));
        self.last = now;
    }

    fn report(&self, inputs: usize) {
        if !self.on {
            return;
        }
        let mut line = format!("badc: link stats: inputs={inputs}");
        let mut total = 0.0;
        for (phase, d) in &self.marks {
            let ms = d.as_secs_f64() * 1e3;
            total += ms;
            line.push_str(&format!(" {phase}={ms:.0}ms"));
        }
        eprintln!("{line} total={total:.0}ms");
    }
}

fn worker_count(jobs: Option<usize>, count: usize) -> usize {
    let n = jobs.unwrap_or_else(|| {
        std::thread::available_parallelism()
            .map(|p| p.get())
            .unwrap_or(1)
    });
    n.saturating_mul(2).min(count).max(1)
}

/// Per-translation-unit diagnostic buffer. Under `--jobs` workers
/// finish out of order, so each records its `info:` / warning / error
/// lines here and the driver replays them in source order: stderr stays
/// grouped per source and byte-identical to a sequential build. Lines
/// are stored pre-formatted (colorized where the sequential path
/// colorized) and replayed verbatim.
#[derive(Default)]
struct TuLog {
    lines: Vec<String>,
}

impl TuLog {
    /// Record a diagnostic line, colorized for a TTY exactly as
    /// `eprint_diagnostic` prints it.
    fn diag(&mut self, tty: bool, msg: impl core::fmt::Display) {
        self.lines
            .push(colorize_diagnostic(&msg.to_string(), tty).into_owned());
    }
    /// Record a line verbatim (the include trace prints uncolored).
    fn raw(&mut self, line: String) {
        self.lines.push(line);
    }
    /// Replay every recorded line to stderr.
    fn flush(&self) {
        for l in &self.lines {
            eprintln!("{l}");
        }
    }
}

/// Read-only per-invocation compile inputs shared across `--jobs`
/// workers by reference. Every field is fixed during argument parsing
/// and never mutated during compilation.
struct CompileCfg<'a> {
    target: Target,
    reloc_opts: NativeOptions,
    gnu: bool,
    gnu_dialect: bool,
    gnu89_inline: bool,
    short_wchar: bool,
    char_signed: Option<bool>,
    nostdinc: bool,
    no_builtin: bool,
    no_builtin_fns: &'a [String],
    optimize_flag: bool,
    export_all: bool,
    show_includes: bool,
    warn_dead_store: bool,
    multi_tu: bool,
    quiet: bool,
    stderr_is_tty: bool,
    defines: &'a [(String, String)],
    undefines: &'a [String],
    include_paths: &'a [String],
    quote_include_paths: &'a [String],
    system_include_paths: &'a [String],
    own_header_roots: &'a [String],
    force_includes: &'a [String],
    /// `-MD` / `-MMD` request, `None` when no dependency output was
    /// asked for. Each unit writes its own file.
    deps: Option<&'a DepOptions>,
    /// `-o`, which names the dependency file and its rule target.
    dep_output: Option<&'a std::path::Path>,
    /// Pre-read stdin bytes for a `-` source; `None` when no input is
    /// stdin. Keeps a worker off the process stdin stream.
    stdin_src: Option<&'a str>,
}

/// One compiled native-link translation unit: the parsed object plus
/// the entry / subsystem / auto-include facts the driver folds across
/// units in source order.
struct NativeTu {
    obj: badc::NativeObject,
    entry: Option<String>,
    subsystem: Option<badc::Subsystem>,
    auto_includes: Vec<String>,
}

/// Compile `units` and return each payload in unit order. `compile`
/// yields a per-unit log and either a payload or an error marker (its
/// message already in the log). `workers <= 1` runs inline and stops at
/// the first failing unit, matching the sequential driver exactly.
/// `workers > 1` runs a bounded pool -- each worker on the driver's
/// stack reservation -- pulling units off a shared cursor and replaying
/// logs in unit order, so the first failure in source order fails the
/// build with identical stderr regardless of scheduling.
fn compile_units<U, P>(
    units: &[U],
    workers: usize,
    compile: impl Fn(usize, &U) -> (TuLog, Result<P, ()>) + Sync,
) -> Vec<P>
where
    U: Sync,
    P: Send,
{
    if workers <= 1 {
        let mut out = Vec::with_capacity(units.len());
        for (i, u) in units.iter().enumerate() {
            let (log, res) = compile(i, u);
            log.flush();
            match res {
                Ok(p) => out.push(p),
                Err(()) => std::process::exit(1),
            }
        }
        return out;
    }
    use std::sync::atomic::{AtomicBool, AtomicUsize, Ordering};
    // Workers pull units off a monotonic cursor. `failed` stops new
    // pickups once any unit errors so a doomed build stops early; the
    // cursor guarantees a filled slot implies every lower slot was
    // handed out (and thus fills), so the first error in source order is
    // still the one reported.
    let next = AtomicUsize::new(0);
    let failed = AtomicBool::new(false);
    let (tx, rx) = std::sync::mpsc::channel::<(usize, TuLog, Result<P, ()>)>();
    let mut slots: Vec<Option<(TuLog, Result<P, ()>)>> = (0..units.len()).map(|_| None).collect();
    std::thread::scope(|scope| {
        for _ in 0..workers {
            let tx = tx.clone();
            let next = &next;
            let failed = &failed;
            let compile = &compile;
            std::thread::Builder::new()
                .stack_size(DRIVER_STACK_SIZE)
                .spawn_scoped(scope, move || {
                    while !failed.load(Ordering::Relaxed) {
                        let i = next.fetch_add(1, Ordering::Relaxed);
                        if i >= units.len() {
                            break;
                        }
                        let (log, res) = compile(i, &units[i]);
                        let is_err = res.is_err();
                        if tx.send((i, log, res)).is_err() {
                            break;
                        }
                        if is_err {
                            failed.store(true, Ordering::Relaxed);
                        }
                    }
                })
                .expect("spawn compile worker");
        }
        drop(tx);
        for (i, log, res) in rx {
            slots[i] = Some((log, res));
        }
    });
    // Replay logs in source order; exit at the first failing unit. A
    // `None` occurs only past that unit (workers stopped early), so it
    // is never reached before the exit.
    let mut out = Vec::with_capacity(units.len());
    for slot in slots {
        match slot {
            Some((log, res)) => {
                log.flush();
                match res {
                    Ok(p) => out.push(p),
                    Err(()) => std::process::exit(1),
                }
            }
            None => break,
        }
    }
    out
}

/// Read a translation unit's source: the pre-read stdin bytes for `-`,
/// else the file. Records a read error in `log`.
fn read_tu_source(src_path: &str, cfg: &CompileCfg, log: &mut TuLog) -> Result<String, ()> {
    if src_path == "-" {
        return match cfg.stdin_src {
            Some(s) => Ok(s.to_string()),
            None => {
                log.diag(cfg.stderr_is_tty, "badc: error: cannot read `-`: no stdin");
                Err(())
            }
        };
    }
    match std::fs::read_to_string(src_path) {
        Ok(b) => Ok(b),
        Err(e) => {
            log.diag(
                cfg.stderr_is_tty,
                format!("badc: error: cannot read `{src_path}`: {e}"),
            );
            Err(())
        }
    }
}

/// Compile one `.c` source to an in-memory relocatable object for the
/// native-link path, capturing every diagnostic in the returned log.
/// `implicit_externs` is empty on the first pass; the auto-include
/// retry passes the names to rebind (and stays quiet about "compiling").
/// The front-end options one translation unit compiles (or preprocesses)
/// under. `implicit_externs` applies to the C front end only.
fn tu_compile_options(
    src_path: &str,
    implicit_externs: &[String],
    cfg: &CompileCfg,
) -> badc::CompileOptions {
    badc::CompileOptions::default()
        .with_gnu(cfg.gnu)
        .with_gnu89_inline(cfg.gnu89_inline)
        .with_short_wchar(cfg.short_wchar)
        .with_char_signed(cfg.char_signed)
        .with_nostdinc(cfg.nostdinc)
        .with_no_builtin(cfg.no_builtin)
        .with_no_builtin_fns(cfg.no_builtin_fns.to_vec())
        .with_gnu_dialect(cfg.gnu_dialect)
        .with_asm_source(SourceKind::of(src_path).is_asm())
        .with_defines(tu_defines(src_path, cfg.defines))
        .with_undefines(cfg.undefines.to_vec())
        .with_include_paths(cfg.include_paths.to_vec())
        .with_quote_include_paths(cfg.quote_include_paths.to_vec())
        .with_system_include_paths(cfg.system_include_paths.to_vec())
        .with_own_header_roots(cfg.own_header_roots.to_vec())
        .with_force_includes(cfg.force_includes.to_vec())
        .with_source_label(src_path.to_string())
        .with_track_includes(cfg.show_includes || cfg.deps.is_some())
        .with_warn_dead_store(cfg.warn_dead_store)
        .with_optimize(cfg.optimize_flag)
        .with_export_all_functions(cfg.export_all)
        .with_implicit_extern_fns(implicit_externs.to_vec())
        .with_no_entry_point(true)
        .with_elf_class(cfg.reloc_opts.elf_class)
        .with_code_model(cfg.reloc_opts.code_model)
}

/// GNU line markers (`# <line> "<file>" [flags]`) blanked in place. gas reads
/// them as line directives rather than as content, and on AArch64 `#` is not
/// a comment introducer, so they cannot be left for the comment stripper.
/// Blanking rather than deleting keeps every statement's line number.
fn blank_line_markers(text: &str) -> String {
    let mut out = String::with_capacity(text.len());
    for (i, line) in text.split('\n').enumerate() {
        if i > 0 {
            out.push('\n');
        }
        let t = line.trim_start();
        let is_marker = t.strip_prefix('#').is_some_and(|r| {
            let r = r.trim_start();
            r.starts_with(|c: char| c.is_ascii_digit())
                || r.strip_prefix("line")
                    .is_some_and(|r| r.starts_with(char::is_whitespace))
        });
        if !is_marker {
            out.push_str(line);
        }
    }
    out
}

/// Assemble one `.s` / `.S` source to a `Program` the object writers consume,
/// writing its dependency rule on the way. `.S` runs through the preprocessor
/// first, as gcc's driver does; `.s` is taken verbatim.
fn assemble_tu(src_path: &str, cfg: &CompileCfg, log: &mut TuLog) -> Result<badc::Program, ()> {
    let src_bytes = read_tu_source(src_path, cfg, log)?;
    let copts = tu_compile_options(src_path, &[], cfg);
    let text = if SourceKind::of(src_path) == (SourceKind::Asm { preprocess: true }) {
        let (text, records) =
            match badc::Compiler::preprocess_tracked(src_bytes, cfg.target, copts.clone()) {
                Ok(r) => r,
                Err(e) => {
                    log.diag(cfg.stderr_is_tty, e);
                    return Err(());
                }
            };
        if let Some(d) = cfg.deps
            && emit_deps(
                src_path,
                &records,
                d,
                cfg.dep_output,
                log,
                cfg.stderr_is_tty,
            )
            .is_err()
        {
            return Err(());
        }
        blank_line_markers(&text)
    } else {
        // A `.s` unit opens no header, so its rule names only the source.
        if let Some(d) = cfg.deps
            && emit_deps(src_path, &[], d, cfg.dep_output, log, cfg.stderr_is_tty).is_err()
        {
            return Err(());
        }
        src_bytes
    };
    badc::Compiler::assemble(&text, cfg.target, copts).map_err(|e| {
        log.diag(cfg.stderr_is_tty, e);
    })
}

/// Produce one translation unit's `Program` and write its dependency rule:
/// a `.c` source through the C front end, a `.s` / `.S` source through the
/// assembler.
fn translate_tu(
    src_path: &str,
    implicit_externs: &[String],
    cfg: &CompileCfg,
    log: &mut TuLog,
) -> Result<badc::Program, ()> {
    if SourceKind::of(src_path).is_asm() {
        return assemble_tu(src_path, cfg, log);
    }
    let src_bytes = read_tu_source(src_path, cfg, log)?;
    let copts = tu_compile_options(src_path, implicit_externs, cfg);
    let compiler = badc::Compiler::with_options(src_bytes, cfg.target, copts);
    if cfg.show_includes {
        for line in compiler.include_trace() {
            log.raw(line);
        }
    }
    if let Some(d) = cfg.deps
        && compiler.preprocess_error().is_none()
        && emit_deps(
            src_path,
            compiler.include_records(),
            d,
            cfg.dep_output,
            log,
            cfg.stderr_is_tty,
        )
        .is_err()
    {
        return Err(());
    }
    let program = match compiler.compile() {
        Ok(p) => p,
        Err(e) => {
            log.diag(cfg.stderr_is_tty, e);
            return Err(());
        }
    };
    for w in &program.warnings {
        log.diag(cfg.stderr_is_tty, w);
    }
    Ok(program)
}

fn compile_native_tu(
    src_path: &str,
    implicit_externs: &[String],
    cfg: &CompileCfg,
) -> (TuLog, Result<NativeTu, ()>) {
    let mut log = TuLog::default();
    if cfg.multi_tu && !cfg.quiet && implicit_externs.is_empty() {
        log.diag(cfg.stderr_is_tty, format!("info: compiling {src_path}"));
    }
    let program = match translate_tu(src_path, implicit_externs, cfg, &mut log) {
        Ok(p) => p,
        Err(()) => return (log, Err(())),
    };
    // Prefer the literal `#pragma entrypoint(<name>)` over the
    // in-TU-resolved `entry_name`: in a multi-TU freestanding link the
    // named entry is often defined in a different TU, so `entry_name` is
    // `None` here while the pragma still fixes the image entry.
    let entry = program
        .entry_pragma
        .clone()
        .or_else(|| program.entry_name.clone());
    let subsystem = program.subsystem;
    let auto_includes = program.auto_includes.clone();
    match badc::emit_native_with_options(&program, cfg.target, cfg.reloc_opts) {
        Ok(bytes) => match badc::parse_native_elf(&bytes) {
            Ok(obj) => (
                log,
                Ok(NativeTu {
                    obj,
                    entry,
                    subsystem,
                    auto_includes,
                }),
            ),
            Err(e) => {
                log.diag(cfg.stderr_is_tty, format!("badc: {src_path}: {e}"));
                (log, Err(()))
            }
        },
        Err(e) => {
            log.diag(cfg.stderr_is_tty, e);
            (log, Err(()))
        }
    }
}

/// Translate one source to relocatable object bytes for the `-c` /
/// `--ar` paths, capturing every diagnostic in the returned log.
fn compile_object_tu(src_path: &str, cfg: &CompileCfg) -> (TuLog, Result<Vec<u8>, ()>) {
    let mut log = TuLog::default();
    if cfg.multi_tu && !cfg.quiet {
        log.diag(cfg.stderr_is_tty, format!("info: compiling {src_path}"));
    }
    let program = match translate_tu(src_path, &[], cfg, &mut log) {
        Ok(p) => p,
        Err(()) => return (log, Err(())),
    };
    warn_dropped_link_pragmas(&program, src_path, &mut log, cfg.stderr_is_tty);
    match badc::emit_native_with_options(&program, cfg.target, cfg.reloc_opts) {
        Ok(bytes) => (log, Ok(bytes)),
        Err(e) => {
            log.diag(cfg.stderr_is_tty, e);
            (log, Err(()))
        }
    }
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
fn warn_dropped_link_pragmas(program: &badc::Program, src_path: &str, log: &mut TuLog, tty: bool) {
    let mut dropped: Vec<&str> = Vec::new();
    if program.entry_pragma.is_some() {
        dropped.push("entrypoint");
    }
    if program.subsystem.is_some() {
        dropped.push("subsystem");
    }
    for p in dropped {
        log.diag(
            tty,
            format!(
                "{src_path}: warning: `#pragma {p}(...)` is not carried by an object \
                 file; compile this source in the link invocation for it to take effect"
            ),
        );
    }
}

/// Like [`native_defined_globals`] but records a parse error in `log`
/// and returns `Err` instead of exiting, for the `--ar` compile
/// workers. STB_GLOBAL section-resident names only (archive-pull-in
/// visibility).
fn native_defined_globals_logged(
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

/// One link input in command-line position: placement follows the
/// order files are loaded, so archives keep their place in the line.
enum LinkInputCli {
    Object(String),
    Archive { path: String, whole: bool },
}

/// Inputs and options for a `-T/--script` link, gathered by the CLI.
struct ScriptLinkCli {
    script_path: std::path::PathBuf,
    inputs: Vec<LinkInputCli>,
    output_path: Option<std::path::PathBuf>,
    map_path: Option<std::path::PathBuf>,
    print_map: bool,
    entry_override: Option<String>,
    shared: bool,
    orphan_handling: badc::OrphanHandling,
    build_id_sha1: bool,
    max_page_size: Option<u64>,
    pack_relative_relocs: bool,
    apply_dynamic_relocs: bool,
    strip_debug: bool,
    discard_locals: bool,
    discard_none: bool,
    emit_relocs: bool,
    quiet: bool,
}

/// Script-driven link: parse the script, read every object (pulling
/// archive members on demand, or wholly under `--whole-archive`), and
/// hand the set to the `lds_link` engine.
fn run_script_link(cli: ScriptLinkCli) {
    let fail = |msg: String| -> ! {
        eprint_diagnostic(format!("badc: {msg}"));
        std::process::exit(1);
    };
    let script_text = match std::fs::read_to_string(&cli.script_path) {
        Ok(t) => t,
        Err(e) => fail(format!(
            "error: cannot read script {}: {e}",
            cli.script_path.display()
        )),
    };
    let script = match badc::parse_linker_script(&script_text) {
        Ok(s) => s,
        Err(e) => fail(format!("{e}")),
    };
    // Load inputs in command-line order: input-section placement
    // follows load order, so an archive's members belong at the
    // archive's position. `--whole-archive` includes every member;
    // other members are pulled while they define a still-undefined
    // symbol, rescanning to a fixed point (group semantics), and land
    // at their archive's slot in pull order.
    enum Slot {
        Ready(Vec<badc::LdsObject>),
        Lazy {
            members: Vec<Option<badc::LdsObject>>,
            pulled: Vec<badc::LdsObject>,
        },
    }
    let mut slots: Vec<Slot> = Vec::new();
    let mut have_lazy = false;
    for input in &cli.inputs {
        match input {
            LinkInputCli::Object(path) => {
                let bytes = match std::fs::read(path) {
                    Ok(b) => b,
                    Err(e) => fail(format!("error: cannot read {path}: {e}")),
                };
                match badc::parse_lds_object(path, bytes) {
                    Ok(o) => slots.push(Slot::Ready(vec![o])),
                    Err(e) => fail(format!("{e}")),
                }
            }
            LinkInputCli::Archive { path, whole } => {
                let blob = match std::fs::read(path) {
                    Ok(b) => b,
                    Err(e) => fail(format!("error: cannot read {path}: {e}")),
                };
                // Thin archive members resolve against the archive's
                // directory.
                let members =
                    match badc::read_archive_at(&blob, std::path::Path::new(path).parent()) {
                        Ok(m) => m,
                        Err(e) => fail(format!("error: {path}: {e}")),
                    };
                let mut objs = Vec::new();
                for m in members {
                    let label = format!("{path}({})", m.name);
                    match badc::parse_lds_object(&label, m.bytes) {
                        Ok(o) => objs.push(o),
                        Err(e) => fail(format!("{e}")),
                    }
                }
                if *whole {
                    slots.push(Slot::Ready(objs));
                } else {
                    have_lazy = true;
                    slots.push(Slot::Lazy {
                        members: objs.into_iter().map(Some).collect(),
                        pulled: Vec::new(),
                    });
                }
            }
        }
    }
    if have_lazy {
        let defined_names = |o: &badc::LdsObject| -> Vec<String> {
            o.symbols
                .iter()
                .filter(|s| (s.info >> 4) != 0 && s.shndx != 0 && !s.name.is_empty())
                .map(|s| s.name.clone())
                .collect()
        };
        let mut defined: std::collections::HashSet<String> = std::collections::HashSet::new();
        let mut undefined: std::collections::HashSet<String> = std::collections::HashSet::new();
        let account = |o: &badc::LdsObject,
                       defined: &mut std::collections::HashSet<String>,
                       undefined: &mut std::collections::HashSet<String>| {
            for s in &o.symbols {
                if s.name.is_empty() || (s.info >> 4) == 0 {
                    continue;
                }
                if s.shndx == 0 {
                    if !defined.contains(&s.name) {
                        undefined.insert(s.name.clone());
                    }
                } else {
                    undefined.remove(&s.name);
                    defined.insert(s.name.clone());
                }
            }
        };
        for slot in &slots {
            if let Slot::Ready(objs) = slot {
                for o in objs {
                    account(o, &mut defined, &mut undefined);
                }
            }
        }
        loop {
            let mut progress = false;
            for slot in slots.iter_mut() {
                let Slot::Lazy { members, pulled } = slot else {
                    continue;
                };
                for m in members.iter_mut() {
                    let wanted = m
                        .as_ref()
                        .is_some_and(|o| defined_names(o).iter().any(|n| undefined.contains(n)));
                    if wanted {
                        let o = m.take().expect("wanted member is occupied");
                        account(&o, &mut defined, &mut undefined);
                        pulled.push(o);
                        progress = true;
                    }
                }
            }
            if !progress {
                break;
            }
        }
    }
    let mut inputs: Vec<badc::LdsObject> = Vec::new();
    for slot in slots {
        match slot {
            Slot::Ready(objs) => inputs.extend(objs),
            Slot::Lazy { pulled, .. } => inputs.extend(pulled),
        }
    }
    if inputs.is_empty() {
        fail("error: no input objects".to_string());
    }
    let machine = inputs[0].machine;
    let opts = badc::LdsOptions {
        emit: if cli.shared {
            badc::LdsEmit::Dyn
        } else {
            badc::LdsEmit::Exec
        },
        shared: cli.shared,
        entry_override: cli.entry_override,
        // GNU ld defaults: 2 MiB on x86-64, 64 KiB on aarch64, 4 KiB
        // on i386.
        max_page_size: cli.max_page_size.unwrap_or(match machine {
            183 => 0x10000,
            3 => 0x1000,
            _ => 0x200000,
        }),
        orphan_handling: cli.orphan_handling,
        build_id_sha1: cli.build_id_sha1,
        strip_debug: cli.strip_debug,
        discard_locals: cli.discard_locals,
        discard_none: cli.discard_none,
        pack_relative_relocs: cli.pack_relative_relocs,
        apply_dynamic_relocs: cli.apply_dynamic_relocs,
        emit_relocs: cli.emit_relocs,
        emit_warnings: !cli.quiet,
        ..Default::default()
    };
    let res = match badc::link_with_script(&script, inputs, &opts) {
        Ok(r) => r,
        Err(e) => fail(format!("{e}")),
    };
    for w in &res.warnings {
        eprintln!("badc: {w}");
    }
    let out = cli
        .output_path
        .unwrap_or_else(|| std::path::PathBuf::from("a.out"));
    if let Err(e) = std::fs::write(&out, &res.image) {
        fail(format!("error: failed to write {}: {e}", out.display()));
    }
    set_executable(&out);
    if !cli.quiet {
        eprint_diagnostic(format!("info: wrote file {}", out.display()));
    }
    if let Some(p) = &cli.map_path
        && let Err(e) = std::fs::write(p, &res.map)
    {
        fail(format!("error: cannot write map file {}: {e}", p.display()));
    }
    if cli.print_map {
        print!("{}", res.map);
    }
}

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
        if !badc::is_native_object(&bytes) {
            eprintln!("badc: --dump-native-link: `{p}` is not a relocatable object");
            std::process::exit(1);
        }
        match badc::parse_native_object(&bytes) {
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

/// `libc/include` of the source tree this badc was built from, found by
/// walking up from the executable to the crate root (`target/<profile>/`
/// or `target/<triple>/<profile>/`). `None` for an installed binary,
/// which has no source tree.
fn source_tree_include() -> Option<PathBuf> {
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

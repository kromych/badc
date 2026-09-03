use std::path::PathBuf;

use badc::Target;

use super::compile::tu_defines;
use super::deps::{DepKind, DepOptions};
use super::diag::eprint_diagnostic;
use super::options::{AssemblerOption, Mode, accept_assembler_option, parse_c_integer};
use super::usage::USAGE;

/// A rejected command line. `styled` routes the text through the
/// severity colorizer; the spellings that print it raw keep it clear.
#[derive(Debug, PartialEq, Eq)]
pub(crate) struct ParseError {
    pub(crate) message: String,
    pub(crate) styled: bool,
}

impl ParseError {
    /// Status every rejected command line exits with.
    pub(crate) const STATUS: i32 = 1;

    fn diag(message: impl core::fmt::Display) -> Self {
        Self {
            message: message.to_string(),
            styled: true,
        }
    }

    fn plain(message: impl core::fmt::Display) -> Self {
        Self {
            message: message.to_string(),
            styled: false,
        }
    }

    /// Print the diagnostic and exit.
    pub(crate) fn report(self) -> ! {
        if self.styled {
            eprint_diagnostic(self.message);
        } else {
            eprintln!("{}", self.message);
        }
        std::process::exit(Self::STATUS)
    }
}

/// What the argument vector asked for.
pub(crate) enum Parsed {
    /// Options to compile, link or run with.
    Run(Box<Cli>),
    /// `-h` / `-v`: text for stdout, then exit 0.
    Print(&'static str),
    /// `--install [<dir>]` writes the embedded header and runtime tree
    /// and reads no target, so it is decided before target resolution.
    Install { dir: Option<PathBuf>, quiet: bool },
}

/// Front-end options every translation unit preprocesses and compiles
/// under. The two path lists the driver fills after parsing are noted.
#[derive(Default, Clone)]
pub(crate) struct FrontEnd {
    pub(crate) gnu: bool,
    pub(crate) gnu_dialect: bool,
    pub(crate) gnu89_inline: bool,
    pub(crate) strict_flex_arrays: u8,
    pub(crate) short_wchar: bool,
    pub(crate) char_signed: Option<bool>,
    pub(crate) auto_var_init: badc::AutoVarInit,
    pub(crate) nostdinc: bool,
    pub(crate) no_builtin: bool,
    pub(crate) no_builtin_fns: Vec<String>,
    pub(crate) defines: Vec<(String, String)>,
    pub(crate) undefines: Vec<String>,
    pub(crate) include_paths: Vec<String>,
    pub(crate) quote_include_paths: Vec<String>,
    pub(crate) force_includes: Vec<String>,
    /// `-H` / `--show-includes`: print the resolved path of every
    /// `#include`, with leading dots marking nesting depth.
    pub(crate) show_includes: bool,
    pub(crate) warn_dead_store: bool,
    pub(crate) optimize: bool,
    /// The host's implicit system header directories, resolved against
    /// the target after parsing.
    pub(crate) system_include_paths: Vec<String>,
    /// On-disk copies of the bundled headers, resolved after parsing.
    pub(crate) own_header_roots: Vec<String>,
}

/// Code-generation options for the native emitters.
#[derive(Clone)]
pub(crate) struct Codegen {
    pub(crate) emit_debug_info: bool,
    pub(crate) inline_cap: u32,
    pub(crate) dump_ssa: bool,
    pub(crate) no_fp_regs: bool,
    pub(crate) strict_align: bool,
    pub(crate) jump_tables: bool,
    pub(crate) keep_local_labels: bool,
    pub(crate) min_function_alignment: u32,
    pub(crate) patchable_function_entry: badc::PatchableEntry,
    pub(crate) profiling: badc::Profiling,
    pub(crate) fpic: bool,
    /// `-fno-pic` / `-fno-pie`, tracked apart from `fpic` because the
    /// absence of any PIC flag and an explicit opt-out choose different
    /// `const` placements in a `-c` object.
    pub(crate) fno_pic: bool,
    pub(crate) code_model: badc::CodeModel,
    pub(crate) hardening: badc::Hardening,
    pub(crate) stack_protect: badc::StackProtect,
    pub(crate) fixed_regs: badc::FixedRegs,
    pub(crate) elf_class: badc::ElfClass,
    /// `-m16` / `-m32` as the user spelled it. Its presence selects
    /// ELFCLASS32 for a `-c` object; the spelling is what the
    /// diagnostic for a `.c` source under it names.
    pub(crate) code_mode_flag: Option<String>,
}

impl Default for Codegen {
    fn default() -> Self {
        Self {
            emit_debug_info: false,
            inline_cap: 64,
            dump_ssa: false,
            no_fp_regs: false,
            strict_align: false,
            jump_tables: true,
            keep_local_labels: false,
            min_function_alignment: 1,
            patchable_function_entry: badc::PatchableEntry::NONE,
            profiling: badc::Profiling::OFF,
            fpic: false,
            fno_pic: false,
            code_model: badc::CodeModel::Small,
            hardening: badc::Hardening::NONE,
            stack_protect: badc::StackProtect::OFF,
            fixed_regs: badc::FixedRegs::NONE,
            elf_class: badc::ElfClass::Elf64,
            code_mode_flag: None,
        }
    }
}

/// Options that shape a link.
#[derive(Clone)]
pub(crate) struct Link {
    pub(crate) lib_names: Vec<String>,
    pub(crate) library_paths: Vec<String>,
    /// `-T` / `--script`: switches to the per-input-section engine.
    pub(crate) script_path: Option<PathBuf>,
    pub(crate) orphan_handling: badc::OrphanHandling,
    pub(crate) build_id_sha1: bool,
    pub(crate) max_page_size: Option<u64>,
    pub(crate) pack_relative_relocs: bool,
    pub(crate) apply_dynamic_relocs: bool,
    pub(crate) strip_debug: bool,
    pub(crate) discard_locals: bool,
    pub(crate) discard_none: bool,
    pub(crate) fix_cortex_a53_843419: bool,
    /// `--emit-relocs`: keep the resolved relocations in the image.
    pub(crate) emit_relocs: bool,
    /// `--export-all`: every non-static function joins the dynamic
    /// symbol table of native output.
    pub(crate) export_all: bool,
    /// `--export-data`: every defined non-static global joins an ELF
    /// executable's dynamic symbol table.
    pub(crate) export_data: bool,
    /// `--entry=<sym>` / `--subsystem=<kind>` fix the image entry and
    /// the PE subsystem for a link of precompiled objects, and win over
    /// any per-translation-unit pragma.
    pub(crate) entry: Option<String>,
    pub(crate) subsystem: Option<badc::Subsystem>,
    pub(crate) map_path: Option<PathBuf>,
    pub(crate) print_map: bool,
    /// `--whole-archive` spans, as half-open ranges over the positional
    /// input indexes.
    pub(crate) whole_archive: Vec<(usize, usize)>,
}

impl Default for Link {
    fn default() -> Self {
        Self {
            lib_names: Vec::new(),
            library_paths: Vec::new(),
            script_path: None,
            orphan_handling: badc::OrphanHandling::Place,
            build_id_sha1: false,
            max_page_size: None,
            pack_relative_relocs: false,
            apply_dynamic_relocs: true,
            strip_debug: false,
            discard_locals: false,
            discard_none: false,
            fix_cortex_a53_843419: false,
            emit_relocs: false,
            export_all: false,
            export_data: false,
            entry: None,
            subsystem: None,
            map_path: None,
            print_map: false,
            whole_archive: Vec::new(),
        }
    }
}

/// The command line, parsed and checked against the target.
pub(crate) struct Cli {
    pub(crate) mode: Mode,
    pub(crate) target: Target,
    pub(crate) output_path: Option<PathBuf>,
    pub(crate) compile_only: bool,
    /// `--freestanding`: no embedded startup runtime, and the program's
    /// own entry becomes the image entry.
    pub(crate) freestanding: bool,
    pub(crate) quiet: bool,
    /// `--jobs N` / `-jN`; `None` leaves the host parallelism default.
    pub(crate) jobs: Option<usize>,
    pub(crate) track_pointers: bool,
    pub(crate) trace: bool,
    pub(crate) deps: Option<DepOptions>,
    pub(crate) front: FrontEnd,
    pub(crate) codegen: Codegen,
    pub(crate) link: Link,
    /// Positional tokens in command-line order, `argv[0]` first.
    pub(crate) positional: Vec<String>,
    /// `--max-gpr=` / `--max-fpr=` as (variable, value): the allocator
    /// reads them from the environment, which the driver sets before
    /// any compile starts.
    #[cfg(feature = "codegen_test")]
    pub(crate) pressure_caps: Vec<(&'static str, String)>,
}

/// The `-M` flag family's operands, assembled into [`DepOptions`] once
/// the output mode is known.
#[derive(Default)]
struct DepFlags {
    kind: Option<DepKind>,
    system: bool,
    file: Option<String>,
    targets: Vec<String>,
    phony: bool,
    target_from_output: bool,
}

/// Argument-vector state while the option loop runs. The fields only
/// the post-loop checks read stay here rather than in [`Cli`].
#[derive(Default)]
struct Parser {
    front: FrontEnd,
    codegen: Codegen,
    link: Link,
    output_path: Option<PathBuf>,
    compile_only: bool,
    freestanding: bool,
    quiet: bool,
    jobs: Option<usize>,
    track_pointers: bool,
    trace: bool,
    positional: Vec<String>,
    /// The mode-picking flag seen, with its spelling for the
    /// mutual-exclusion diagnostic.
    mode: Option<(Mode, &'static str)>,
    /// `-h` / `-v` stop the loop with text for stdout.
    print: Option<&'static str>,
    target_spec: Option<String>,
    mcpu: Option<String>,
    dep: DepFlags,
    /// `-mcmodel=tiny`, which lowers as `small` and is checked against
    /// the target below.
    code_model_tiny: bool,
    fixed_reg_names: Vec<String>,
    /// The `-pg` modifiers seen, x86-64 options gcc's aarch64 rejects.
    mcount_modifiers: Vec<String>,
    ssp_guard_kind: Option<&'static str>,
    ssp_guard_reg: Option<String>,
    ssp_guard_offset: Option<i32>,
    whole_archive_open: Option<usize>,
    #[cfg(feature = "codegen_test")]
    pressure_caps: Vec<(&'static str, String)>,
}

type Args = dyn Iterator<Item = String>;

/// The operand of an option that takes a separate argument.
fn operand(iter: &mut Args, missing: &str) -> Result<String, ParseError> {
    iter.next().ok_or_else(|| ParseError::diag(missing))
}

/// Read the argument vector. Reads the environment and nothing else:
/// every diagnostic is returned rather than printed, so the caller
/// decides what to write and what to exit with.
pub(crate) fn parse_args(argv: Vec<String>) -> Result<Parsed, ParseError> {
    let mut p = Parser::default();
    let mut iter = argv.into_iter();
    p.positional.push(iter.next().unwrap_or_default());
    while let Some(arg) = iter.next() {
        if p.option(&arg, &mut iter)? {
            if let Some(text) = p.print {
                return Ok(Parsed::Print(text));
            }
            continue;
        }
        // An unrecognised dash-prefixed token is an unknown option, not
        // a source file. Without this guard it falls through to the
        // positionals and is classified by extension, becoming a phantom
        // input path. `-` alone is the stdin source.
        if arg.starts_with('-') && arg != "-" {
            return Err(ParseError::diag(format!(
                "badc: error: unknown option `{arg}`"
            )));
        }
        p.positional.push(arg);
    }
    p.finish()
}

impl Parser {
    /// Handle one argument, or report that it is a positional. The
    /// families are consulted in the order the spellings were written
    /// in: no family's prefix match covers a spelling a later family
    /// takes exactly.
    fn option(&mut self, arg: &str, iter: &mut Args) -> Result<bool, ParseError> {
        Ok(self.mode_option(arg, iter)?
            || self.preprocess_option(arg, iter)?
            || self.assembler_option(arg, iter)?
            || self.codegen_option(arg, iter)?
            || self.link_option(arg, iter)?)
    }

    /// Claim the output mode. At most one mode-picking flag may appear;
    /// the diagnostic names both.
    fn claim(&mut self, picked: Mode) -> Result<(), ParseError> {
        let flag = picked.flag_name();
        if let Some((existing, existing_flag)) = self.mode {
            return Err(ParseError::plain(format!(
                "badc: {flag} can't be combined with {existing_flag} -- both pick an \
                 output mode (Mode::{picked:?} vs Mode::{existing:?}). See --help."
            )));
        }
        self.mode = Some((picked, flag));
        Ok(())
    }

    /// Output mode, driver behavior, and the flags that shape the whole
    /// run rather than one phase.
    fn mode_option(&mut self, arg: &str, iter: &mut Args) -> Result<bool, ParseError> {
        match arg {
            "--interp" => self.claim(Mode::Interp)?,
            "--track-pointers" => self.track_pointers = true,
            "--trace" => self.trace = true,
            "--list-symbols" => self.claim(Mode::ListSymbols)?,
            "--dump-headers" => self.claim(Mode::DumpHeaders)?,
            // `--install [<dir>]`: the optional destination is the first
            // positional token; a bare `--install` defaults to ~/.badc.
            "--install" => self.claim(Mode::Install)?,
            "--dump-pp" | "-E" => self.claim(Mode::DumpPp)?,
            "--jit" => self.claim(Mode::Jit)?,
            "--shared" | "-shared" => self.claim(Mode::SharedLibrary)?,
            "--ar" | "--archive" => self.claim(Mode::BuildArchive)?,
            "--dump-native-link" => self.claim(Mode::DumpNativeLink)?,
            // `-c` emits one relocatable object per source instead of
            // linking through to a native binary.
            "-c" | "--compile-only" => self.compile_only = true,
            "--freestanding" => self.freestanding = true,
            "--debug" | "-g" => self.codegen.emit_debug_info = true,
            "--no-debug" | "-g0" => self.codegen.emit_debug_info = false,
            "--dump-ssa" => self.codegen.dump_ssa = true,
            // Silence informational output; errors and warnings stay.
            "-q" | "--quiet" => self.quiet = true,
            "-h" | "--help" => self.print = Some(USAGE),
            "-v" | "--version" => self.print = Some(badc::BUILD_INFO),
            "-o" => {
                self.output_path = Some(PathBuf::from(operand(
                    iter,
                    "badc: error: -o requires a path argument",
                )?));
            }
            s if s.starts_with("--inline-cap=") => {
                let body = &s["--inline-cap=".len()..];
                self.codegen.inline_cap = body.parse::<u32>().map_err(|_| {
                    ParseError::diag("badc: error: --inline-cap=N requires a non-negative integer")
                })?;
            }
            // Build parallelism. `--jobs N` / `--jobs=N` / `-j N` / `-jN`
            // set N; the driver runs up to 2*N compile workers. The
            // attached `-jN` form only matches an all-digit suffix so an
            // unknown `-jXXX` flag still reports as unknown.
            "--jobs" | "-j" => {
                let n = operand(
                    iter,
                    "badc: error: --jobs (-j) requires a positive integer N",
                )?;
                self.jobs = Some(parse_jobs(&n)?);
            }
            s if s.starts_with("--jobs=") => {
                self.jobs = Some(parse_jobs(&s["--jobs=".len()..])?);
            }
            s if s.starts_with("-j")
                && s.len() > 2
                && s[2..].bytes().all(|b| b.is_ascii_digit()) =>
            {
                self.jobs = Some(parse_jobs(&s[2..])?);
            }
            // Register-allocator pressure caps, gated behind the
            // `codegen_test` feature. Each truncates one allocator bank
            // to N entries. The value reaches the allocator through the
            // environment variable it reads.
            #[cfg(feature = "codegen_test")]
            s if s.starts_with("--max-gpr=") || s.starts_with("--max-fpr=") => {
                let (flag, var) = if s.starts_with("--max-gpr=") {
                    ("--max-gpr=", "BADC_MAX_GPR")
                } else {
                    ("--max-fpr=", "BADC_MAX_FPR")
                };
                match s[flag.len()..].parse::<usize>() {
                    Ok(n) if n >= 1 => self.pressure_caps.push((var, n.to_string())),
                    _ => {
                        return Err(ParseError::diag(format!(
                            "badc: error: {flag}N requires an integer >= 1"
                        )));
                    }
                }
            }
            _ => return Ok(false),
        }
        Ok(true)
    }

    /// Preprocessor and language-dialect options.
    fn preprocess_option(&mut self, arg: &str, iter: &mut Args) -> Result<bool, ParseError> {
        let front = &mut self.front;
        match arg {
            "-D" => {
                let s = operand(iter, "badc: error: -D requires NAME[=VALUE]")?;
                match s.split_once('=') {
                    Some((name, body)) => front.defines.push((name.to_string(), body.to_string())),
                    None => front.defines.push((s, String::from("1"))),
                }
            }
            s if s.starts_with("-D") && s.len() > 2 => {
                let body = &s[2..];
                match body.split_once('=') {
                    Some((name, body)) => front.defines.push((name.to_string(), body.to_string())),
                    None => front.defines.push((body.to_string(), String::from("1"))),
                }
            }
            "-U" => front
                .undefines
                .push(operand(iter, "badc: error: -U requires a NAME")?),
            s if s.starts_with("-U") && s.len() > 2 => front.undefines.push(s[2..].to_string()),
            "-I" => front
                .include_paths
                .push(operand(iter, "badc: error: -I requires a path argument")?),
            s if s.starts_with("-I") && s.len() > 2 => {
                front.include_paths.push(s[2..].to_string());
            }
            // gcc / clang -iquote DIR: a search path for `#include "..."`
            // only, probed after the including file's directory and
            // before the -I paths.
            "-iquote" => front.quote_include_paths.push(operand(
                iter,
                "badc: error: -iquote requires a path argument",
            )?),
            s if s.starts_with("-iquote") && s.len() > 7 => {
                front.quote_include_paths.push(s[7..].to_string());
            }
            // gcc / clang -include FILE: splice the named header in front
            // of the source. Repeatable; later flags expand top-to-bottom.
            "-include" => front.force_includes.push(operand(
                iter,
                "badc: error: -include requires a header name",
            )?),
            "-H" | "--show-includes" => front.show_includes = true,
            // gcc `-M` family -- make-syntax dependency output. `-M` /
            // `-MM` write the rule and compile nothing; `-MD` / `-MMD`
            // write it beside the normal output. The `MM` spellings drop
            // system headers. Later flags win, as with gcc.
            "-M" | "-MM" | "-MD" | "-MMD" => {
                self.dep.kind = Some(if arg == "-M" || arg == "-MM" {
                    DepKind::Only
                } else {
                    DepKind::WithOutput
                });
                self.dep.system = arg == "-M" || arg == "-MD";
                // gcc's driver names the rule after `-o` for the
                // compile-too spellings by injecting `-MQ <object>`.
                self.dep.target_from_output = matches!(arg, "-MD" | "-MMD");
            }
            "-MP" => self.dep.phony = true,
            "-MF" | "-MT" | "-MQ" => {
                let v = operand(iter, &format!("badc: error: {arg} requires an argument"))?;
                match arg {
                    "-MF" => self.dep.file = Some(v),
                    // `-MT` takes the target verbatim; `-MQ` quotes it
                    // for make.
                    "-MT" => self.dep.targets.push(v),
                    _ => self.dep.targets.push(badc::dep_escape(&v)),
                }
            }
            // gcc hands a `-Wp,` payload's comma-separated pieces to the
            // preprocessor. There `-MD` / `-MMD` take the output path as
            // an operand, which is how kbuild requests dependency files.
            // Reaching the preprocessor directly means no `-o`-derived
            // rule name applies, so the rule keeps the source-derived
            // default -- gcc behaves the same.
            s if s.starts_with("-Wp,") => {
                let mut parts = s["-Wp,".len()..].split(',');
                while let Some(part) = parts.next() {
                    match part {
                        "-MD" | "-MMD" => match parts.next() {
                            Some(path) => {
                                self.dep.kind = Some(DepKind::WithOutput);
                                self.dep.system = part == "-MD";
                                self.dep.file = Some(path.to_string());
                                self.dep.target_from_output = false;
                            }
                            None => {
                                return Err(ParseError::diag(format!(
                                    "badc: error: `-Wp,{part}` requires a file operand"
                                )));
                            }
                        },
                        "-MP" => self.dep.phony = true,
                        _ => {
                            return Err(ParseError::diag(format!(
                                "badc: error: unsupported preprocessor option `{part}` in `{s}`"
                            )));
                        }
                    }
                }
            }
            // gcc-shape `-Wdead-store` -- enable the per-store dead-store
            // diagnostic. `-Wno-dead-store` is the opt-out spelling.
            "-Wdead-store" => front.warn_dead_store = true,
            "-Wno-dead-store" => front.warn_dead_store = false,
            // Define the GCC identity macros (`__GNUC__`, `__VERSION__`,
            // `__extension__`, ...). Off by default: badc implements most
            // but not all of the GNU C surface, so code that gates a
            // feature badc lacks on `__GNUC__` keeps compiling unless
            // this is requested.
            "--gnu" => front.gnu = true,
            // gcc / clang `-fgnu89-inline`: make the GNU89 inline linkage
            // model the unit default in place of C99's.
            "-fgnu89-inline" => front.gnu89_inline = true,
            "-fno-gnu89-inline" => front.gnu89_inline = false,
            // gcc `-fstrict-flex-arrays[=N]`: which trailing array members
            // `__builtin_object_size` treats as unbounded. The bare form
            // is level 3, as in gcc.
            "-fstrict-flex-arrays" => front.strict_flex_arrays = 3,
            s if s.starts_with("-fstrict-flex-arrays=") => {
                let spec = &s["-fstrict-flex-arrays=".len()..];
                front.strict_flex_arrays = match spec.parse::<u8>() {
                    Ok(n) if n <= 3 => n,
                    _ => {
                        return Err(ParseError::diag(format!(
                            "badc: error: `-fstrict-flex-arrays=` takes a level \
                             0..=3, got `{spec}`"
                        )));
                    }
                };
            }
            // gcc / clang `-fshort-wchar`: `wchar_t` becomes an unsigned
            // 16-bit type on every target. It changes the layout of every
            // object holding a `wchar_t` or a wide literal, so it reaches
            // the front end rather than being dropped as a no-op.
            "-fshort-wchar" => front.short_wchar = true,
            "-fno-short-wchar" => front.short_wchar = false,
            // gcc `-ftrivial-auto-var-init=`: the front end supplies the
            // initializer, so every output mode carries it.
            s if s.starts_with("-ftrivial-auto-var-init=") => {
                let spec = &s["-ftrivial-auto-var-init=".len()..];
                front.auto_var_init = match spec {
                    "uninitialized" => badc::AutoVarInit::Uninitialized,
                    "zero" => badc::AutoVarInit::Zero,
                    "pattern" => badc::AutoVarInit::Pattern,
                    _ => {
                        return Err(ParseError::diag(format!(
                            "badc: error: unsupported argument `{spec}` to \
                             `-ftrivial-auto-var-init=` (supported: uninitialized, \
                             zero, pattern)"
                        )));
                    }
                };
            }
            // gcc `-fzero-init-padding-bits=`: measured on all three
            // targets at both optimization levels, a partially initialized
            // automatic struct or union has zero padding whichever value
            // is named, since the whole object is zero-filled before its
            // members are stored. The argument is checked and nothing
            // changes.
            s if s.starts_with("-fzero-init-padding-bits=") => {
                let spec = &s["-fzero-init-padding-bits=".len()..];
                if !matches!(spec, "standard" | "unions" | "all") {
                    return Err(ParseError::diag(format!(
                        "badc: error: unsupported argument `{spec}` to \
                         `-fzero-init-padding-bits=` (supported: standard, unions, all)"
                    )));
                }
            }
            // gcc / clang `-fsigned-char` / `-funsigned-char`: C99
            // 6.2.5p15 leaves plain `char`'s signedness to the
            // implementation, and each selects one over the target
            // default. It changes every `char`-to-`int` conversion, so it
            // reaches the front end rather than being dropped.
            "-fsigned-char" | "-fno-unsigned-char" => front.char_signed = Some(true),
            "-funsigned-char" | "-fno-signed-char" => front.char_signed = Some(false),
            // gcc / clang `-fno-builtin` and `-ffreestanding`: a call
            // spelled with a library function's own name is an ordinary
            // call the compiler may not fold. `-ffreestanding` also drops
            // the hosted assumption that such a name is declarable, which
            // is the auto-include retry. The `__builtin_` spellings are
            // unaffected, as under gcc.
            "-fno-builtin" | "-ffreestanding" => front.no_builtin = true,
            "-fbuiltin" | "-fhosted" => front.no_builtin = false,
            s if s.starts_with("-fno-builtin-") => {
                front
                    .no_builtin_fns
                    .push(s["-fno-builtin-".len()..].to_string());
            }
            // gcc / clang `-nostdinc`: the standard headers leave the
            // `#include` search, so a name no `-I` / `-iquote` path
            // carries is an error rather than a bind to badc's bundled
            // libc.
            "-nostdinc" => front.nostdinc = true,
            // gcc / clang `-std=<dialect>`: badc compiles C99 with the
            // GNU extensions always available, so the dialect selects
            // only whether `__STRICT_ANSI__` is defined.
            s if s.starts_with("-std=") => {
                // The C dialect families gcc names: `cNN` / `gnuNN` and
                // the `iso9899:` spellings, which are strict ISO. A name
                // outside them is rejected rather than read as strict
                // ISO, since a caller that misspells the dialect gets the
                // other one.
                let dialect = &s["-std=".len()..];
                let known = dialect.starts_with("gnu")
                    || dialect.starts_with("iso9899:")
                    || (dialect.starts_with('c')
                        && dialect[1..].chars().all(|c| c.is_ascii_digit())
                        && dialect.len() > 1);
                if !known {
                    return Err(ParseError::plain(format!(
                        "badc: error: unknown C dialect `{dialect}` (-std=)"
                    )));
                }
                front.gnu_dialect = dialect.starts_with("gnu");
            }
            _ => return Ok(false),
        }
        Ok(true)
    }

    /// `-Wa,<opt>[,<opt>...]` and `-Xassembler <opt>`: gcc's two
    /// spellings for handing an option to the assembler. badc's
    /// assembler is built in, so each option is checked against what it
    /// implements rather than passed on.
    fn assembler_option(&mut self, arg: &str, iter: &mut Args) -> Result<bool, ParseError> {
        let opts: Vec<String> = match arg {
            s if s.starts_with("-Wa,") => s["-Wa,".len()..].split(',').map(String::from).collect(),
            "-Xassembler" => vec![operand(
                iter,
                "badc: error: -Xassembler requires an option",
            )?],
            _ => return Ok(false),
        };
        for opt in &opts {
            let accepted = accept_assembler_option(opt).map_err(ParseError::diag)?;
            self.codegen.keep_local_labels |= accepted == AssemblerOption::KeepLocals;
        }
        Ok(true)
    }

    /// Optimization, machine and hardening options.
    fn codegen_option(&mut self, arg: &str, iter: &mut Args) -> Result<bool, ParseError> {
        let code = &mut self.codegen;
        match arg {
            // The optimizer has a single level; every `-O<n>` form maps
            // onto it, matching gcc/clang where a build system may pass
            // any of them. `-O0` explicitly disables it (and overrides an
            // earlier `-O` on the same command line).
            "--optimize" | "-O" | "-O1" | "-O2" | "-O3" | "-Os" | "-Oz" | "-Ofast" | "-Og" => {
                self.front.optimize = true;
            }
            "-O0" => self.front.optimize = false,
            s if s.starts_with("--target=") => {
                self.target_spec = Some(s["--target=".len()..].to_string());
            }
            // gcc's x86 code-mode selectors. `-m16` and `-m32` both put
            // the object out as ELFCLASS32 / EM_386, matching the
            // `as --32` gcc hands its assembler for either; the encoding
            // mode itself comes from `.code16` / `.code32` in the source.
            // `-m31` (s390) and `-mx32` name ABIs badc has no encoder or
            // container for.
            "-m64" => {}
            "-m16" | "-m32" => code.code_mode_flag = Some(arg.to_string()),
            "-m31" | "-mx32" => {
                return Err(ParseError::diag(format!(
                    "badc: error: `{arg}` selects an ABI badc does not emit"
                )));
            }
            // Keep compiler-generated code off the floating-point / SIMD
            // register file: gcc spells it `-mno-sse` on x86_64 and
            // `-mgeneral-regs-only` on aarch64. Freestanding environments
            // run with that register file trapped, so any access faults.
            "-mno-sse" | "-mgeneral-regs-only" => code.no_fp_regs = true,
            // Keep a register out of the allocator.
            s if s.starts_with("-ffixed-") => {
                let name = &s["-ffixed-".len()..];
                if name.is_empty() {
                    return Err(ParseError::diag(
                        "badc: error: `-ffixed-` requires a register name",
                    ));
                }
                self.fixed_reg_names.push(name.to_string());
            }
            // AArch64 CPU selection. The base name picks a scheduling
            // model badc does not differentiate; the extensions decide
            // the feature macros, resolved once the target is known.
            s if s.starts_with("-mcpu=") => self.mcpu = Some(s["-mcpu=".len()..].to_string()),
            // Keep every compiler-generated memory access naturally
            // aligned for its width. Code that runs with the MMU off
            // sees Device-typed memory, where an unaligned access raises
            // an alignment fault instead of being fixed up.
            "-mstrict-align" => code.strict_align = true,
            "-mno-strict-align" => code.strict_align = false,
            // Speculative-execution mitigations, in gcc's spellings. An
            // argument that is not implemented is rejected rather than
            // ignored: a hardening flag that compiles but does nothing
            // leaves the caller believing the output is mitigated. The
            // `thunk` kind wants a comdat thunk body in the object, which
            // badc does not produce.
            s if s.starts_with("-mindirect-branch=") => {
                code.hardening.indirect_branch = match &s["-mindirect-branch=".len()..] {
                    "keep" => badc::IndirectBranch::Keep,
                    "thunk-extern" => badc::IndirectBranch::ThunkExtern,
                    "thunk-inline" => badc::IndirectBranch::ThunkInline,
                    other => {
                        return Err(ParseError::diag(format!(
                            "badc: error: unsupported argument `{other}` to `-mindirect-branch=` \
                             (supported: keep, thunk-extern, thunk-inline)"
                        )));
                    }
                };
            }
            s if s.starts_with("-mfunction-return=") => {
                code.hardening.function_return_thunk = match &s["-mfunction-return=".len()..] {
                    "keep" => false,
                    "thunk-extern" => true,
                    other => {
                        return Err(ParseError::diag(format!(
                            "badc: error: unsupported argument `{other}` to `-mfunction-return=` \
                             (supported: keep, thunk-extern)"
                        )));
                    }
                };
            }
            // Already unconditional: every compiler-generated indirect
            // branch takes its target from a register. The CS prefix is
            // gcc's for the generated-thunk kinds only, none for
            // `thunk-extern`.
            "-mindirect-branch-register" | "-mindirect-branch-cs-prefix" => {}
            s if s.starts_with("-mharden-sls=") => {
                for kind in s["-mharden-sls=".len()..].split(',') {
                    match kind {
                        "none" => {
                            code.hardening.sls_return = false;
                            code.hardening.sls_indirect_jmp = false;
                        }
                        "return" => code.hardening.sls_return = true,
                        "indirect-jmp" => code.hardening.sls_indirect_jmp = true,
                        "all" => {
                            code.hardening.sls_return = true;
                            code.hardening.sls_indirect_jmp = true;
                        }
                        other => {
                            return Err(ParseError::diag(format!(
                                "badc: error: unsupported argument `{other}` to `-mharden-sls=` \
                                 (supported: none, return, indirect-jmp, all)"
                            )));
                        }
                    }
                }
            }
            // `-fcf-protection=<kind>`: x86 control-flow enforcement.
            // `branch` is indirect-branch tracking, the `endbr64` landing
            // pads. `return` and `full` add the shadow stack, which needs
            // a return path badc does not emit.
            s if s.starts_with("-fcf-protection=") => {
                code.hardening.cf_protection_branch = match &s["-fcf-protection=".len()..] {
                    "none" => false,
                    "branch" => true,
                    other => {
                        return Err(ParseError::diag(format!(
                            "badc: error: unsupported argument `{other}` to `-fcf-protection=` \
                             (supported: none, branch)"
                        )));
                    }
                };
            }
            // A `+`-joined AArch64 feature list. `standard` is gcc's
            // alias for `bti+pac-ret`. The `leaf` and `b-key` modifiers
            // of `pac-ret`, and `gcs`, are rejected: an accepted-but-
            // ignored spelling would build an object that claims a
            // protection it does not carry.
            s if s.starts_with("-mbranch-protection=") => {
                for feature in s["-mbranch-protection=".len()..].split('+') {
                    match feature {
                        "none" => {
                            code.hardening.bti = false;
                            code.hardening.pac_ret = false;
                        }
                        "bti" => code.hardening.bti = true,
                        "pac-ret" => code.hardening.pac_ret = true,
                        "standard" => {
                            code.hardening.bti = true;
                            code.hardening.pac_ret = true;
                        }
                        other => {
                            return Err(ParseError::diag(format!(
                                "badc: error: unsupported feature `{other}` in \
                                 `-mbranch-protection=` (supported: none, bti, \
                                 pac-ret, standard)"
                            )));
                        }
                    }
                }
            }
            // Position-independent relocatable output: no absolute
            // relocation reaches the object, so a consumer that relocates
            // it wholesale at load can take it. badc's final images are
            // always position-independent, so the flag only chooses the
            // `-c` object's relocation shapes.
            "-fPIC" | "-fpic" | "-fPIE" | "-fpie" => {
                code.fpic = true;
                code.fno_pic = false;
            }
            "-fno-pic" | "-fno-PIC" | "-fno-pie" | "-fno-PIE" => {
                code.fpic = false;
                code.fno_pic = true;
            }
            // gcc / clang `-fno-jump-tables`: a switch never dispatches
            // through a table, only through the compare tree. Kernels
            // built with retpoline or indirect-branch tracking pass it
            // because a table dispatch is an indirect branch those
            // configurations must not take.
            "-fjump-tables" => code.jump_tables = true,
            "-fno-jump-tables" => code.jump_tables = false,
            // gcc `-fstack-protector*`: which functions carry a stack
            // canary. The per-function rule is gcc's, applied to the
            // declared automatic objects.
            "-fno-stack-protector" => code.stack_protect.mode = badc::StackProtector::Off,
            "-fstack-protector" => code.stack_protect.mode = badc::StackProtector::Basic,
            "-fstack-protector-strong" => code.stack_protect.mode = badc::StackProtector::Strong,
            "-fstack-protector-all" => code.stack_protect.mode = badc::StackProtector::All,
            // gcc `--param <name>=<value>`, in both the separate-argument
            // and joined spellings. `ssp-buffer-size` is the only name
            // with an effect here; an unrecognized one is rejected rather
            // than dropped, so a tuning request cannot pass silently.
            s if s == "--param" || s.starts_with("--param=") => {
                let spec = if s == "--param" {
                    operand(iter, "badc: error: `--param` takes an argument")?
                } else {
                    s["--param=".len()..].to_string()
                };
                let Some((name, value)) = spec.split_once('=') else {
                    return Err(ParseError::diag(format!(
                        "badc: error: `--param` takes `<name>=<value>`, got `{spec}`"
                    )));
                };
                if name != "ssp-buffer-size" {
                    return Err(ParseError::diag(format!(
                        "badc: error: unsupported `--param` name `{name}` \
                         (supported: ssp-buffer-size)"
                    )));
                }
                code.stack_protect.buffer_size = match value.parse::<u32>() {
                    Ok(n) if n > 0 => n,
                    _ => {
                        return Err(ParseError::diag(format!(
                            "badc: error: `ssp-buffer-size` takes a positive \
                             integer, got `{value}`"
                        )));
                    }
                };
            }
            // gcc `-mstack-protector-guard=`: where the guard value lives.
            // `tls` is the x86-64 segment-relative form, `sysreg` the
            // aarch64 system-register form, `global` the
            // `__stack_chk_guard` object. Validated against the target
            // once the loop ends.
            s if s.starts_with("-mstack-protector-guard=") => {
                self.ssp_guard_kind = Some(match &s["-mstack-protector-guard=".len()..] {
                    "global" => "global",
                    "tls" => "tls",
                    "sysreg" => "sysreg",
                    other => {
                        return Err(ParseError::diag(format!(
                            "badc: error: unsupported argument `{other}` to \
                             `-mstack-protector-guard=` (supported: global, tls, sysreg)"
                        )));
                    }
                });
            }
            s if s.starts_with("-mstack-protector-guard-reg=") => {
                self.ssp_guard_reg = Some(s["-mstack-protector-guard-reg=".len()..].to_string());
            }
            s if s.starts_with("-mstack-protector-guard-offset=") => {
                let spec = &s["-mstack-protector-guard-offset=".len()..];
                self.ssp_guard_offset = Some(parse_c_integer(spec).ok_or_else(|| {
                    ParseError::diag(format!(
                        "badc: error: `-mstack-protector-guard-offset=` takes \
                         an integer, got `{spec}`"
                    ))
                })?);
            }
            s if s.starts_with("-mstack-protector-guard-symbol=") => {
                let spec = &s["-mstack-protector-guard-symbol=".len()..];
                code.stack_protect.guard_symbol =
                    badc::GuardSymbol::new(spec).ok_or_else(|| {
                        ParseError::diag(format!(
                            "badc: error: `-mstack-protector-guard-symbol=` takes \
                             a symbol name of 1 to {} bytes, got `{spec}`",
                            badc::GuardSymbol::CAP
                        ))
                    })?;
            }
            // gcc `-fmin-function-alignment=N`: every function entry
            // lands on a multiple of N, which is how a kernel states
            // CONFIG_FUNCTION_ALIGNMENT. Unlike `-falign-functions` gcc
            // never skips a large gap under it, and badc never does
            // either.
            s if s.starts_with("-fmin-function-alignment=") => {
                let spec = &s["-fmin-function-alignment=".len()..];
                code.min_function_alignment = match spec.parse::<u32>() {
                    Ok(n) if n.is_power_of_two() => n,
                    _ => {
                        return Err(ParseError::diag(format!(
                            "badc: error: `-fmin-function-alignment=` takes a \
                             power of two, got `{spec}`"
                        )));
                    }
                };
            }
            // gcc `-fpatchable-function-entry=N[,M]`: N NOPs at every
            // function entry, M of them ahead of the symbol, recorded per
            // function in `__patchable_function_entries`.
            s if s.starts_with("-fpatchable-function-entry=") => {
                let spec = &s["-fpatchable-function-entry=".len()..];
                let (n, m) = spec.split_once(',').unwrap_or((spec, "0"));
                code.patchable_function_entry = match (n.parse::<u32>(), m.parse::<u32>()) {
                    (Ok(nops), Ok(before)) if before <= nops => {
                        badc::PatchableEntry { nops, before }
                    }
                    _ => {
                        return Err(ParseError::diag(format!(
                            "badc: error: `-fpatchable-function-entry=` takes `N[,M]` \
                             with M <= N, got `{spec}`"
                        )));
                    }
                };
            }
            "-pg" => code.profiling.enabled = true,
            "-mfentry" | "-mno-fentry" => {
                code.profiling.fentry = arg == "-mfentry";
                self.mcount_modifiers.push(arg.to_string());
            }
            "-mrecord-mcount" | "-mno-record-mcount" => {
                code.profiling.record_mcount = arg == "-mrecord-mcount";
                self.mcount_modifiers.push(arg.to_string());
            }
            "-mnop-mcount" | "-mno-nop-mcount" => {
                code.profiling.nop_mcount = arg == "-mnop-mcount";
                self.mcount_modifiers.push(arg.to_string());
            }
            // Code model for `-c` objects. `small` is the default;
            // `kernel` switches external-address materialization to the
            // sign-extended 32-bit absolute form and is validated against
            // the target below. The remaining psABI models are not
            // implemented.
            s if s.starts_with("-mcmodel=") => {
                code.code_model = match &s["-mcmodel=".len()..] {
                    "small" => badc::CodeModel::Small,
                    "kernel" => badc::CodeModel::Kernel,
                    // aarch64 `tiny` narrows the layout contract to
                    // +/-1MiB; the small-model form stays valid under it,
                    // so it lowers as small. Validated against the target
                    // below.
                    "tiny" => {
                        self.code_model_tiny = true;
                        badc::CodeModel::Small
                    }
                    other => {
                        return Err(ParseError::diag(format!(
                            "badc: error: unsupported code model `{other}` in \
                             `-mcmodel=` (supported: small, kernel; \
                             aarch64 also: tiny)"
                        )));
                    }
                };
            }
            _ => return Ok(false),
        }
        Ok(true)
    }

    /// Options that shape a link, including the GNU ld surface a build
    /// system passes through the compiler driver.
    fn link_option(&mut self, arg: &str, iter: &mut Args) -> Result<bool, ParseError> {
        let link = &mut self.link;
        match arg {
            "-Map" => {
                link.map_path = Some(PathBuf::from(operand(
                    iter,
                    "badc: error: -Map requires a file argument",
                )?));
            }
            s if s.starts_with("-Map=") => {
                link.map_path = Some(PathBuf::from(&s["-Map=".len()..]));
            }
            // `-M` is gcc's dependency-output flag, handled by the
            // preprocessor family. The link map keeps the long spelling;
            // GNU ld's `-M` belongs to the linker persona, which parses
            // separately.
            "--print-map" => link.print_map = true,
            "-l" => link
                .lib_names
                .push(operand(iter, "badc: error: -l requires a library name")?),
            s if s.starts_with("-l") && s.len() > 2 => link.lib_names.push(s[2..].to_string()),
            "-L" => link
                .library_paths
                .push(operand(iter, "badc: error: -L requires a directory")?),
            s if s.starts_with("-L") && s.len() > 2 => link.library_paths.push(s[2..].to_string()),
            // `--entry=<sym>` fixes the image entry symbol at the link
            // step, so precompiled `.o` inputs need no `#pragma
            // entrypoint` stub. Mirrors the pragma but wins over it.
            s if s.starts_with("--entry=") => {
                link.entry = Some(s["--entry=".len()..].to_string());
            }
            // `--subsystem=<kind>` selects the PE subsystem; kinds match
            // `#pragma subsystem(<kind>)`. Needed to stamp EFI
            // application / boot-service-driver / runtime-driver images
            // built from precompiled objects.
            s if s.starts_with("--subsystem=") => {
                let kind = &s["--subsystem=".len()..];
                link.subsystem = Some(match kind {
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
                        return Err(ParseError::diag(format!(
                            "badc: error: --subsystem=<kind>: unknown kind `{kind}`; expected \
                             one of console, windows, native, efi_application, \
                             efi_boot_service_driver, efi_runtime_driver, efi_rom"
                        )));
                    }
                });
            }
            // GNU ld surface for script-driven links. `-T FILE` /
            // `--script=FILE` select the script; the rest mirror the
            // options the Linux kernel build passes to `ld`.
            "-T" | "--script" => {
                link.script_path = Some(PathBuf::from(operand(
                    iter,
                    "badc: error: -T/--script requires a file argument",
                )?));
            }
            s if s.starts_with("--script=") => {
                link.script_path = Some(PathBuf::from(&s["--script=".len()..]));
            }
            s if s.starts_with("-T") && s.len() > 2 => {
                link.script_path = Some(PathBuf::from(&s[2..]));
            }
            s if s.starts_with("--orphan-handling=") => {
                link.orphan_handling = match &s["--orphan-handling=".len()..] {
                    "place" => badc::OrphanHandling::Place,
                    "warn" => badc::OrphanHandling::Warn,
                    "error" => badc::OrphanHandling::Error,
                    "discard" => badc::OrphanHandling::Discard,
                    other => {
                        return Err(ParseError::diag(format!(
                            "badc: error: --orphan-handling=`{other}`: expected \
                             place, warn, error, or discard"
                        )));
                    }
                };
            }
            "--build-id" => link.build_id_sha1 = true,
            s if s.starts_with("--build-id=") => {
                link.build_id_sha1 = match &s["--build-id=".len()..] {
                    "sha1" => true,
                    "none" => false,
                    other => {
                        return Err(ParseError::diag(format!(
                            "badc: error: --build-id=`{other}` is not supported (sha1, none)"
                        )));
                    }
                };
            }
            // `-z keyword`: page-size and packing keywords take effect;
            // the hardening keywords the kernel passes describe states
            // this linker already emits.
            "-z" => {
                let kw = operand(iter, "badc: error: -z requires a keyword")?;
                match kw.as_str() {
                    s if s.starts_with("max-page-size=") => {
                        let body = &s["max-page-size=".len()..];
                        let parsed = if let Some(hex) = body.strip_prefix("0x") {
                            u64::from_str_radix(hex, 16).ok()
                        } else {
                            body.parse::<u64>().ok()
                        };
                        match parsed {
                            Some(n) if n.is_power_of_two() => link.max_page_size = Some(n),
                            _ => {
                                return Err(ParseError::diag(
                                    "badc: error: -z max-page-size requires a power of two",
                                ));
                            }
                        }
                    }
                    "pack-relative-relocs" => link.pack_relative_relocs = true,
                    "nopack-relative-relocs" => link.pack_relative_relocs = false,
                    "noexecstack" | "execstack" | "norelro" | "relro" | "notext" | "text"
                    | "now" | "lazy" | "defs" | "nodefault" | "muldefs" => {}
                    other => {
                        return Err(ParseError::diag(format!(
                            "badc: error: unknown -z keyword `{other}`"
                        )));
                    }
                }
            }
            "--emit-relocs" => link.emit_relocs = true,
            "--export-all" => link.export_all = true,
            "--export-data" => link.export_data = true,
            "--strip-debug" | "-S" => link.strip_debug = true,
            "-X" | "--discard-locals" => link.discard_locals = true,
            "--discard-none" => link.discard_none = true,
            "--no-apply-dynamic-relocs" => link.apply_dynamic_relocs = false,
            // Accepted with no effect on output: diagnostics-shaping and
            // emulation flags from ld command lines.
            "--fatal-warnings"
            | "--no-warn-rwx-segments"
            | "--no-undefined"
            | "-EL"
            | "--pic-veneer"
            | "-Bsymbolic"
            | "--no-ld-generated-unwind-info" => {}
            "--fix-cortex-a53-843419" => link.fix_cortex_a53_843419 = true,
            // ld accepts the emulation joined (`-maarch64linux`) or
            // separate (`-m aarch64linux`).
            "-melf_x86_64" | "-maarch64linux" | "-maarch64elf" => {
                let spec = if arg == "-melf_x86_64" {
                    "linux-x64"
                } else {
                    "linux-aarch64"
                };
                if self.target_spec.is_none() {
                    self.target_spec = Some(spec.to_string());
                }
            }
            "-m" => {
                let emu = operand(iter, "badc: error: -m requires an emulation name")?;
                let spec = match emu.as_str() {
                    "elf_x86_64" => Some("linux-x64"),
                    "aarch64linux" | "aarch64elf" => Some("linux-aarch64"),
                    _ => None,
                };
                match spec {
                    Some(t) if self.target_spec.is_none() => {
                        self.target_spec = Some(t.to_string());
                    }
                    Some(_) => {}
                    None => {
                        return Err(ParseError::diag(format!(
                            "badc: error: unknown emulation `{emu}`"
                        )));
                    }
                }
            }
            "--whole-archive" => self.whole_archive_open = Some(self.positional.len()),
            "--no-whole-archive" => {
                if let Some(start) = self.whole_archive_open.take() {
                    link.whole_archive.push((start, self.positional.len()));
                }
            }
            // Group markers: the script-link archive loop already
            // rescans every archive to a fixed point.
            "--start-group" | "--end-group" => {}
            _ => return Ok(false),
        }
        Ok(true)
    }

    /// Resolve the target, check every flag combination the argument
    /// vector alone decides, and hand back the parsed command line.
    fn finish(mut self) -> Result<Parsed, ParseError> {
        let mode = self.mode.map(|(m, _)| m).unwrap_or(Mode::NativeExecutable);
        if mode == Mode::Install {
            return Ok(Parsed::Install {
                dir: self.positional.get(1).map(PathBuf::from),
                quiet: self.quiet,
            });
        }
        let target = Target::parse(self.target_spec.as_deref()).map_err(ParseError::diag)?;
        for name in &self.fixed_reg_names {
            match badc::fixed_register(target, name) {
                Ok(reg) => self.codegen.fixed_regs.insert(reg),
                Err(e) => return Err(ParseError::diag(format!("badc: error: {e}"))),
            }
        }
        self.check_profiling_and_protection(mode, target)?;
        self.resolve_stack_guard(target)?;
        self.apply_mcpu(target)?;
        self.check_code_model(mode, target)?;
        // VM-only flags.
        if (self.track_pointers || self.trace) && mode != Mode::Interp {
            return Err(ParseError::plain(format!(
                "badc: --track-pointers / --trace require --interp \
                 (current mode is {})",
                mode.flag_name()
            )));
        }
        // -o makes no sense for modes that don't write to disk.
        if self.output_path.is_some()
            && matches!(
                mode,
                Mode::Interp
                    | Mode::ListSymbols
                    | Mode::DumpHeaders
                    | Mode::Jit
                    | Mode::DumpNativeLink
            )
        {
            return Err(ParseError::plain(format!(
                "badc: -o is only meaningful for native compilation \
                 (current mode is {})",
                mode.flag_name()
            )));
        }
        // The link map describes a completed link.
        if (self.link.map_path.is_some() || self.link.print_map)
            && (self.compile_only || !matches!(mode, Mode::NativeExecutable | Mode::SharedLibrary))
        {
            return Err(ParseError::plain(format!(
                "badc: -Map / --print-map require a link (current mode is {})",
                if self.compile_only {
                    "-c"
                } else {
                    mode.flag_name()
                }
            )));
        }
        // A `-c` object under `-m16` / `-m32` is ELFCLASS32; the flag's
        // remaining restrictions need the classified inputs and are
        // checked once those are known.
        self.codegen.elf_class = match self.codegen.code_mode_flag {
            Some(_) => badc::ElfClass::Elf32,
            None => badc::ElfClass::Elf64,
        };
        if let Some(start) = self.whole_archive_open.take() {
            self.link.whole_archive.push((start, self.positional.len()));
        }
        let deps = self.dep.kind.map(|kind| DepOptions {
            kind,
            system: self.dep.system,
            file: self.dep.file,
            targets: self.dep.targets,
            phony: self.dep.phony,
            // Under `-E` the `-o` operand names the preprocessed text,
            // not an object, so the rule keeps gcc's default target --
            // the source stem with `.o` -- rather than naming a file no
            // rule builds.
            target_from_output: self.dep.target_from_output && mode != Mode::DumpPp,
        });
        Ok(Parsed::Run(Box::new(Cli {
            mode,
            target,
            output_path: self.output_path,
            compile_only: self.compile_only,
            freestanding: self.freestanding,
            quiet: self.quiet,
            jobs: self.jobs,
            track_pointers: self.track_pointers,
            trace: self.trace,
            deps,
            front: self.front,
            codegen: self.codegen,
            link: self.link,
            positional: self.positional,
            #[cfg(feature = "codegen_test")]
            pressure_caps: self.pressure_caps,
        })))
    }

    /// `-pg`, `-fpatchable-function-entry=` and `-fstack-protector*`
    /// name object-level contracts, so each is checked against the
    /// output mode and the target.
    fn check_profiling_and_protection(&self, mode: Mode, target: Target) -> Result<(), ParseError> {
        // `--jit` and `--interp` execute in this process: the JIT
        // resolves no undefined symbol and the interpreter has no
        // machine frame at all, so neither can carry a canary.
        if self.codegen.stack_protect.mode != badc::StackProtector::Off
            && matches!(mode, Mode::Jit | Mode::Interp)
        {
            return Err(ParseError::diag(
                "badc: error: `-fstack-protector*` needs a compiled output: \
                 `--jit` and `--interp` execute in this process and reach no \
                 `__stack_chk_fail`",
            ));
        }
        // The profiling call and the patchable-entry records are ELF
        // object contracts: the call names `__fentry__` / `mcount` for
        // the link and the records are sections of the object.
        // TODO: the aarch64 `-pg` form and the PE / Mach-O records.
        let is_elf_target = matches!(target, Target::LinuxX64 | Target::LinuxAarch64);
        if self.codegen.profiling.enabled && matches!(mode, Mode::Jit | Mode::Interp) {
            return Err(ParseError::diag(
                "badc: error: `-pg` needs a compiled output: `--jit` and `--interp` \
                 execute in this process and reach no `__fentry__`",
            ));
        }
        if self.codegen.profiling.enabled && (!is_elf_target || target.is_aarch64()) {
            return Err(ParseError::diag(format!(
                "badc: error: `-pg` is not implemented for {}",
                target.id_str()
            )));
        }
        if let Some(flag) = self.mcount_modifiers.first()
            && target.is_aarch64()
        {
            return Err(ParseError::diag(format!(
                "badc: error: `{flag}` is an x86-64 option; gcc's aarch64 has none"
            )));
        }
        if self.codegen.patchable_function_entry != badc::PatchableEntry::NONE && !is_elf_target {
            return Err(ParseError::diag(format!(
                "badc: error: `-fpatchable-function-entry=` is not implemented for {}",
                target.id_str()
            )));
        }
        // The canary sequences name the System V handler and guard
        // object. Windows targets link against msvcrt, which exports
        // neither (the Microsoft scheme is `__security_cookie` /
        // `__security_check_cookie`, which badc does not emit), so an
        // object built here would reference symbols nothing defines.
        // TODO: emit the Microsoft cookie sequence for Windows targets.
        if self.codegen.stack_protect.mode != badc::StackProtector::Off && target.is_windows() {
            return Err(ParseError::diag(
                "badc: error: `-fstack-protector*` is not implemented for the Windows \
                 targets: their C library exports neither `__stack_chk_guard` nor \
                 `__stack_chk_fail`",
            ));
        }
        Ok(())
    }

    /// `-mstack-protector-guard*`: the operands only make sense together
    /// and only on the architecture whose form they name, so the
    /// combination is checked once the target is known. An unusable one
    /// is an error rather than a default, since a guard read from the
    /// wrong place would leave the image claiming a protection it does
    /// not have.
    fn resolve_stack_guard(&mut self, target: Target) -> Result<(), ParseError> {
        // gcc's x86 default for `-mstack-protector-guard=` is `tls`, so
        // the kernel names only the register and the symbol on SMP
        // builds.
        let kind = self.ssp_guard_kind.or_else(|| {
            let named = self.ssp_guard_reg.is_some() || self.ssp_guard_offset.is_some();
            (named && target.is_x86_64()).then_some("tls")
        });
        if let Some(kind) = kind {
            self.codegen.stack_protect.guard = match kind {
                "global" => badc::StackGuard::Global,
                "tls" => {
                    if !target.is_x86_64() {
                        return Err(ParseError::diag(
                            "badc: error: `-mstack-protector-guard=tls` is an x86-64 form; \
                             use `global` or `sysreg`",
                        ));
                    }
                    let seg = match self.ssp_guard_reg.as_deref() {
                        None | Some("fs") => badc::GuardSeg::Fs,
                        Some("gs") => badc::GuardSeg::Gs,
                        Some(other) => {
                            return Err(ParseError::diag(format!(
                                "badc: error: unsupported argument `{other}` to \
                                 `-mstack-protector-guard-reg=` under `=tls` (supported: fs, gs)"
                            )));
                        }
                    };
                    badc::StackGuard::Tls {
                        seg,
                        offset: self.ssp_guard_offset.unwrap_or(badc::SYSV_TLS_GUARD_OFFSET),
                    }
                }
                _ => {
                    if !target.is_aarch64() {
                        return Err(ParseError::diag(
                            "badc: error: `-mstack-protector-guard=sysreg` is an aarch64 form; \
                             use `global` or `tls`",
                        ));
                    }
                    let (Some(reg), Some(offset)) =
                        (self.ssp_guard_reg.as_deref(), self.ssp_guard_offset)
                    else {
                        return Err(ParseError::diag(
                            "badc: error: `-mstack-protector-guard=sysreg` needs both \
                             `-mstack-protector-guard-reg=` and `-mstack-protector-guard-offset=`",
                        ));
                    };
                    let Some(sysreg) = badc::stack_guard_sysreg(reg) else {
                        return Err(ParseError::diag(format!(
                            "badc: error: `-mstack-protector-guard-reg={reg}` names no \
                             AArch64 system register"
                        )));
                    };
                    badc::StackGuard::Sysreg { sysreg, offset }
                }
            };
        } else if self.ssp_guard_reg.is_some() || self.ssp_guard_offset.is_some() {
            return Err(ParseError::diag(
                "badc: error: `-mstack-protector-guard-reg=` / \
                 `-mstack-protector-guard-offset=` need `-mstack-protector-guard=`",
            ));
        }
        if !self.codegen.stack_protect.guard_symbol.is_empty() && self.ssp_guard_offset.is_some() {
            return Err(ParseError::diag(
                "badc: error: `-mstack-protector-guard-symbol=` and \
                 `-mstack-protector-guard-offset=` are mutually exclusive",
            ));
        }
        if !self.codegen.stack_protect.guard_symbol.is_empty()
            && !matches!(
                self.codegen.stack_protect.guard,
                badc::StackGuard::Global | badc::StackGuard::Tls { .. }
            )
        {
            return Err(ParseError::diag(
                "badc: error: `-mstack-protector-guard-symbol=` applies to the \
                 `global` and `tls` guard forms only",
            ));
        }
        Ok(())
    }

    /// `-mcpu=<name>[+<ext>...]`: an AArch64 CPU and its extensions,
    /// which predefine the feature macros. gcc's model, measured:
    /// `+crypto` is `+aes+sha2`, `no<ext>` subtracts, and
    /// `__ARM_FEATURE_CRYPTO` holds only while both do. The AES and
    /// SHA-2 encodings are always in badc's tables; any other modifier
    /// is refused rather than accepted inertly.
    fn apply_mcpu(&mut self, target: Target) -> Result<(), ParseError> {
        let Some(spec) = &self.mcpu else {
            return Ok(());
        };
        if !matches!(
            target,
            Target::LinuxAarch64 | Target::MacOSAarch64 | Target::WindowsAarch64
        ) {
            return Err(ParseError::diag(
                "badc: error: `-mcpu=` names an AArch64 CPU; the x86-64 targets take none",
            ));
        }
        let mut parts = spec.split('+');
        if parts.next().unwrap_or("").is_empty() {
            return Err(ParseError::diag(format!(
                "badc: error: `-mcpu={spec}` names no CPU"
            )));
        }
        let (mut aes, mut sha2) = (false, false);
        for ext in parts {
            match ext {
                "crypto" => (aes, sha2) = (true, true),
                "nocrypto" => (aes, sha2) = (false, false),
                "aes" => aes = true,
                "noaes" => aes = false,
                "sha2" => sha2 = true,
                "nosha2" => sha2 = false,
                other => {
                    return Err(ParseError::diag(format!(
                        "badc: error: `-mcpu=` extension `{other}` is not \
                         implemented; badc implements `crypto`, `aes`, \
                         `sha2` and their `no` forms"
                    )));
                }
            }
        }
        for (name, on) in [
            ("__ARM_FEATURE_AES", aes),
            ("__ARM_FEATURE_SHA2", sha2),
            ("__ARM_FEATURE_CRYPTO", aes && sha2),
        ] {
            if on && !self.front.defines.iter().any(|(n, _)| n == name) {
                self.front
                    .defines
                    .push((name.to_string(), String::from("1")));
            }
        }
        Ok(())
    }

    /// The kernel model rewrites external addresses into sign-extended
    /// 32-bit absolutes, defined by the x86-64 psABI for images linked
    /// in the top 2GB. It shapes relocatable output only: badc's own
    /// images are position-independent and cannot carry an absolute text
    /// reference, and `-fPIC` contradicts it the same way (gcc rejects
    /// the combination). `tiny` is an aarch64 model.
    fn check_code_model(&self, mode: Mode, target: Target) -> Result<(), ParseError> {
        if self.code_model_tiny && target != Target::LinuxAarch64 {
            return Err(ParseError::diag(
                "badc: error: `-mcmodel=tiny` requires an aarch64 ELF target \
                 (--target=linux-aarch64)",
            ));
        }
        if self.codegen.code_model != badc::CodeModel::Kernel {
            return Ok(());
        }
        if target != Target::LinuxX64 {
            return Err(ParseError::diag(
                "badc: error: `-mcmodel=kernel` requires an x86-64 ELF target \
                 (--target=linux-x64)",
            ));
        }
        if self.codegen.fpic {
            return Err(ParseError::diag(
                "badc: error: code model `kernel` does not support \
                 position-independent output (-fPIC/-fPIE)",
            ));
        }
        // Modes that emit no native code (`-E`, --list-symbols, ...)
        // leave the flag inert, as gcc does.
        let emits_native = matches!(
            mode,
            Mode::NativeExecutable | Mode::SharedLibrary | Mode::Jit | Mode::Interp
        );
        if emits_native && !self.compile_only {
            return Err(ParseError::diag(
                "badc: error: `-mcmodel=kernel` shapes relocatable objects; \
                 it requires `-c` or `--ar`",
            ));
        }
        Ok(())
    }
}

/// A `--jobs` / `-j` value: a positive integer.
fn parse_jobs(s: &str) -> Result<usize, ParseError> {
    match s.parse::<usize>() {
        Ok(n) if n >= 1 => Ok(n),
        _ => Err(ParseError::diag(format!(
            "badc: error: --jobs (-j) requires a positive integer, got `{s}`"
        ))),
    }
}

impl FrontEnd {
    /// The language and search-path options one unit preprocesses and
    /// compiles under. Each phase adds what it decides on top:
    /// optimization, include tracking, the assembler flag, and the ELF
    /// class and code model a relocatable emit carries.
    pub(crate) fn compile_options(&self, label: &str) -> badc::CompileOptions {
        badc::CompileOptions::default()
            .with_gnu(self.gnu)
            .with_gnu89_inline(self.gnu89_inline)
            .with_strict_flex_arrays(self.strict_flex_arrays)
            .with_short_wchar(self.short_wchar)
            .with_char_signed(self.char_signed)
            .with_auto_var_init(self.auto_var_init)
            .with_nostdinc(self.nostdinc)
            .with_no_builtin(self.no_builtin)
            .with_no_builtin_fns(self.no_builtin_fns.clone())
            .with_gnu_dialect(self.gnu_dialect)
            .with_defines(tu_defines(label, &self.defines))
            .with_undefines(self.undefines.clone())
            .with_include_paths(self.include_paths.clone())
            .with_quote_include_paths(self.quote_include_paths.clone())
            .with_system_include_paths(self.system_include_paths.clone())
            .with_own_header_roots(self.own_header_roots.clone())
            .with_force_includes(self.force_includes.clone())
            .with_source_label(label.to_string())
    }
}

impl Codegen {
    /// The emitter options for a relocatable object. `pic_link` states
    /// whether the consuming link applies data relocations after
    /// mapping; see [`badc::NativeOptions::pic_link`].
    pub(crate) fn relocatable_options(
        &self,
        optimize: bool,
        pic_link: bool,
    ) -> badc::NativeOptions {
        let mut opts = badc::NativeOptions::new()
            .with_debug_info(self.emit_debug_info)
            .with_inline_cap(self.inline_cap);
        opts.no_fp_regs = self.no_fp_regs;
        opts.strict_align = self.strict_align;
        opts.jump_tables = self.jump_tables;
        opts.min_function_alignment = self.min_function_alignment;
        opts.patchable_function_entry = self.patchable_function_entry;
        opts.profiling = self.profiling;
        opts.pic = self.fpic;
        opts.pic_link = pic_link;
        opts.code_model = self.code_model;
        opts.hardening = self.hardening;
        opts.stack_protect = self.stack_protect;
        opts.fixed_regs = self.fixed_regs;
        opts.elf_class = self.elf_class;
        opts.keep_local_labels = self.keep_local_labels;
        if optimize {
            opts = opts.with_optimize();
        }
        if self.dump_ssa {
            opts = opts.with_dump_ssa();
        }
        opts.output_kind = badc::OutputKind::Relocatable;
        opts
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn argv(args: &[&str]) -> Vec<String> {
        core::iter::once("badc")
            .chain(args.iter().copied())
            .map(String::from)
            .collect()
    }

    /// The options `args` parses to. Panics on any other outcome.
    fn parse(args: &[&str]) -> Cli {
        match parse_args(argv(args)) {
            Ok(Parsed::Run(cli)) => *cli,
            other => panic!("{args:?}: expected a run, got {}", outcome(&other)),
        }
    }

    /// The diagnostic and the status the driver exits with for a
    /// rejected command line.
    fn reject(args: &[&str]) -> (String, i32) {
        match parse_args(argv(args)) {
            Err(e) => (e.message, ParseError::STATUS),
            other => panic!("{args:?}: expected a rejection, got {}", outcome(&other)),
        }
    }

    fn outcome(o: &Result<Parsed, ParseError>) -> String {
        match o {
            Ok(Parsed::Run(_)) => "a run".to_string(),
            Ok(Parsed::Print(_)) => "printed text".to_string(),
            Ok(Parsed::Install { .. }) => "an install".to_string(),
            Err(e) => format!("a rejection: {}", e.message),
        }
    }

    /// Targets every lane resolves the same way, so the checks that
    /// depend on one do not follow the build host.
    const X64: &str = "--target=linux-x64";
    const A64: &str = "--target=linux-aarch64";

    #[test]
    fn output_path_takes_a_separate_operand() {
        assert_eq!(
            parse(&["-o", "out.bin", "a.c"]).output_path.unwrap(),
            PathBuf::from("out.bin")
        );
        assert_eq!(
            reject(&["-o"]),
            ("badc: error: -o requires a path argument".to_string(), 1)
        );
    }

    #[test]
    fn compile_only_has_two_spellings() {
        assert!(parse(&["-c", "a.c"]).compile_only);
        assert!(parse(&["--compile-only", "a.c"]).compile_only);
        assert!(!parse(&["a.c"]).compile_only);
    }

    #[test]
    fn defines_and_undefines_take_both_spellings() {
        let cli = parse(&["-DA", "-DB=2", "-D", "C=3", "-UD", "-U", "E", "a.c"]);
        assert_eq!(
            cli.front.defines,
            vec![
                ("A".to_string(), "1".to_string()),
                ("B".to_string(), "2".to_string()),
                ("C".to_string(), "3".to_string()),
            ]
        );
        assert_eq!(cli.front.undefines, vec!["D".to_string(), "E".to_string()]);
        assert_eq!(
            reject(&["-D"]),
            ("badc: error: -D requires NAME[=VALUE]".to_string(), 1)
        );
        assert_eq!(
            reject(&["-U"]),
            ("badc: error: -U requires a NAME".to_string(), 1)
        );
    }

    #[test]
    fn include_paths_keep_the_two_scopes_apart() {
        let cli = parse(&["-Iinc", "-I", "inc2", "-iquoteq", "-iquote", "q2", "a.c"]);
        assert_eq!(
            cli.front.include_paths,
            vec!["inc".to_string(), "inc2".to_string()]
        );
        assert_eq!(
            cli.front.quote_include_paths,
            vec!["q".to_string(), "q2".to_string()]
        );
        assert_eq!(
            reject(&["-I"]),
            ("badc: error: -I requires a path argument".to_string(), 1)
        );
        assert_eq!(
            reject(&["-iquote"]),
            (
                "badc: error: -iquote requires a path argument".to_string(),
                1
            )
        );
        assert_eq!(
            reject(&["-include"]),
            (
                "badc: error: -include requires a header name".to_string(),
                1
            )
        );
    }

    #[test]
    fn libraries_take_both_spellings() {
        let cli = parse(&["-Ldir", "-L", "dir2", "-lm", "-l", "c", "a.c"]);
        assert_eq!(
            cli.link.library_paths,
            vec!["dir".to_string(), "dir2".to_string()]
        );
        assert_eq!(cli.link.lib_names, vec!["m".to_string(), "c".to_string()]);
        assert_eq!(
            reject(&["-L"]),
            ("badc: error: -L requires a directory".to_string(), 1)
        );
        assert_eq!(
            reject(&["-l"]),
            ("badc: error: -l requires a library name".to_string(), 1)
        );
    }

    #[test]
    fn every_optimization_level_selects_the_one_optimizer() {
        for flag in [
            "-O",
            "-O1",
            "-O2",
            "-O3",
            "-Os",
            "-Oz",
            "-Ofast",
            "-Og",
            "--optimize",
        ] {
            assert!(parse(&[flag, "a.c"]).front.optimize, "{flag}");
        }
        assert!(!parse(&["-O2", "-O0", "a.c"]).front.optimize);
        assert!(parse(&["-O0", "-O2", "a.c"]).front.optimize);
    }

    #[test]
    fn debug_info_is_last_flag_wins() {
        assert!(parse(&["-g", "a.c"]).codegen.emit_debug_info);
        assert!(parse(&["--debug", "a.c"]).codegen.emit_debug_info);
        assert!(!parse(&["-g", "-g0", "a.c"]).codegen.emit_debug_info);
        assert!(parse(&["-g0", "-g", "a.c"]).codegen.emit_debug_info);
    }

    #[test]
    fn target_selects_the_image_format() {
        assert_eq!(parse(&[X64, "a.c"]).target, Target::LinuxX64);
        assert_eq!(parse(&[A64, "a.c"]).target, Target::LinuxAarch64);
        assert_eq!(
            parse(&["--target=windows-x64", "a.c"]).target,
            Target::WindowsX64
        );
        assert!(reject(&["--target=nope", "a.c"]).0.contains("nope"));
    }

    #[test]
    fn dead_store_warning_is_opt_in() {
        assert!(!parse(&["a.c"]).front.warn_dead_store);
        assert!(parse(&["-Wdead-store", "a.c"]).front.warn_dead_store);
        assert!(
            !parse(&["-Wdead-store", "-Wno-dead-store", "a.c"])
                .front
                .warn_dead_store
        );
    }

    #[test]
    fn preprocessor_payload_carries_the_dependency_request() {
        let cli = parse(&["-Wp,-MMD,dep.d", "-Wp,-MP", "-c", "a.c"]);
        let deps = cli.deps.unwrap();
        assert_eq!(deps.kind, DepKind::WithOutput);
        assert!(!deps.system);
        assert_eq!(deps.file.as_deref(), Some("dep.d"));
        assert!(deps.phony);
        assert!(!deps.target_from_output);
        assert_eq!(
            reject(&["-Wp,-MD", "a.c"]),
            (
                "badc: error: `-Wp,-MD` requires a file operand".to_string(),
                1
            )
        );
        assert_eq!(
            reject(&["-Wp,-nope", "a.c"]),
            (
                "badc: error: unsupported preprocessor option `-nope` in `-Wp,-nope`".to_string(),
                1
            )
        );
    }

    #[test]
    fn assembler_options_are_checked_against_what_the_assembler_does() {
        assert!(parse(&["-Wa,-L", "a.c"]).codegen.keep_local_labels);
        assert!(
            parse(&["-Xassembler", "--keep-locals", "a.c"])
                .codegen
                .keep_local_labels
        );
        assert!(
            !parse(&["-Wa,--fatal-warnings,-march=x86-64", "a.c"])
                .codegen
                .keep_local_labels
        );
        assert_eq!(
            reject(&["-Wa,--nope", "a.c"]),
            (
                "badc: error: unsupported assembler option `--nope`".to_string(),
                1
            )
        );
        assert_eq!(
            reject(&["-Xassembler"]),
            ("badc: error: -Xassembler requires an option".to_string(), 1)
        );
    }

    #[test]
    fn dependency_family_picks_kind_and_system_headers() {
        for (flag, kind, system, from_output) in [
            ("-M", DepKind::Only, true, false),
            ("-MM", DepKind::Only, false, false),
            ("-MD", DepKind::WithOutput, true, true),
            ("-MMD", DepKind::WithOutput, false, true),
        ] {
            let cli = parse(&[flag, "-c", "a.c"]);
            let deps = cli.deps.unwrap();
            assert_eq!(deps.kind, kind, "{flag}");
            assert_eq!(deps.system, system, "{flag}");
            assert_eq!(deps.target_from_output, from_output, "{flag}");
        }
        let cli = parse(&["-M", "-MF", "d.mk", "-MT", "t", "-MQ", "q$x", "-MP", "a.c"]);
        let deps = cli.deps.unwrap();
        assert_eq!(deps.file.as_deref(), Some("d.mk"));
        assert_eq!(deps.targets, vec!["t".to_string(), badc::dep_escape("q$x")]);
        assert!(deps.phony);
        assert_eq!(
            reject(&["-MF"]),
            ("badc: error: -MF requires an argument".to_string(), 1)
        );
        // Under `-E` the `-o` operand names the preprocessed text, so
        // the rule keeps the source-derived default.
        assert!(
            !parse(&["-MD", "-E", "a.c"])
                .deps
                .unwrap()
                .target_from_output
        );
    }

    #[test]
    fn jobs_takes_every_spelling_and_rejects_zero() {
        for args in [
            &["--jobs", "4"][..],
            &["--jobs=4"][..],
            &["-j", "4"][..],
            &["-j4"][..],
        ] {
            let mut v = args.to_vec();
            v.push("a.c");
            assert_eq!(parse(&v).jobs, Some(4), "{args:?}");
        }
        assert_eq!(parse(&["a.c"]).jobs, None);
        assert_eq!(
            reject(&["--jobs", "0", "a.c"]),
            (
                "badc: error: --jobs (-j) requires a positive integer, got `0`".to_string(),
                1
            )
        );
        assert_eq!(
            reject(&["-j"]),
            (
                "badc: error: --jobs (-j) requires a positive integer N".to_string(),
                1
            )
        );
        // A non-digit suffix is an unknown option, not a job count.
        assert_eq!(
            reject(&["-jx", "a.c"]),
            ("badc: error: unknown option `-jx`".to_string(), 1)
        );
    }

    #[test]
    fn f_family_reaches_the_front_end_and_the_emitter() {
        let cli = parse(&[
            "-fPIC",
            "-fno-jump-tables",
            "-fsigned-char",
            "-fshort-wchar",
            "-fstrict-flex-arrays=2",
            "-ftrivial-auto-var-init=zero",
            "-fgnu89-inline",
            "-fno-builtin-memcpy",
            "-ffreestanding",
            "-fmin-function-alignment=16",
            "a.c",
        ]);
        assert!(cli.codegen.fpic && !cli.codegen.fno_pic);
        assert!(!cli.codegen.jump_tables);
        assert_eq!(cli.front.char_signed, Some(true));
        assert!(cli.front.short_wchar);
        assert_eq!(cli.front.strict_flex_arrays, 2);
        assert_eq!(cli.front.auto_var_init, badc::AutoVarInit::Zero);
        assert!(cli.front.gnu89_inline);
        assert_eq!(cli.front.no_builtin_fns, vec!["memcpy".to_string()]);
        assert!(cli.front.no_builtin);
        assert_eq!(cli.codegen.min_function_alignment, 16);
        assert!(parse(&["-fno-pic", "a.c"]).codegen.fno_pic);
        assert_eq!(
            reject(&["-fstrict-flex-arrays=9", "a.c"]).0,
            "badc: error: `-fstrict-flex-arrays=` takes a level 0..=3, got `9`"
        );
        assert_eq!(
            reject(&["-fmin-function-alignment=3", "a.c"]).0,
            "badc: error: `-fmin-function-alignment=` takes a power of two, got `3`"
        );
        assert_eq!(
            reject(&["-ffixed-", "a.c"]),
            (
                "badc: error: `-ffixed-` requires a register name".to_string(),
                1
            )
        );
    }

    #[test]
    fn m_family_is_checked_against_the_target() {
        let cli = parse(&[X64, "-m32", "-mno-sse", "-mcmodel=kernel", "-c", "a.c"]);
        assert_eq!(cli.codegen.code_mode_flag.as_deref(), Some("-m32"));
        assert!(cli.codegen.no_fp_regs);
        assert_eq!(cli.codegen.code_model, badc::CodeModel::Kernel);
        assert_eq!(cli.codegen.elf_class, badc::ElfClass::Elf32);
        assert_eq!(
            parse(&[X64, "a.c"]).codegen.elf_class,
            badc::ElfClass::Elf64
        );
        assert_eq!(
            reject(&["-m31", "a.c"]),
            (
                "badc: error: `-m31` selects an ABI badc does not emit".to_string(),
                1
            )
        );
        assert_eq!(
            reject(&[X64, "-mcpu=generic", "a.c"]),
            (
                "badc: error: `-mcpu=` names an AArch64 CPU; the x86-64 targets take none"
                    .to_string(),
                1
            )
        );
        // `+crypto` predefines both feature macros.
        let cli = parse(&[A64, "-mcpu=generic+crypto", "-c", "a.c"]);
        for name in [
            "__ARM_FEATURE_AES",
            "__ARM_FEATURE_SHA2",
            "__ARM_FEATURE_CRYPTO",
        ] {
            assert!(cli.front.defines.iter().any(|(n, _)| n == name), "{name}");
        }
        assert_eq!(
            reject(&[A64, "-mcpu=generic+nope", "-c", "a.c"]).0,
            "badc: error: `-mcpu=` extension `nope` is not implemented; badc implements \
             `crypto`, `aes`, `sha2` and their `no` forms"
        );
        assert_eq!(
            reject(&[X64, "-mcmodel=tiny", "-c", "a.c"]).0,
            "badc: error: `-mcmodel=tiny` requires an aarch64 ELF target (--target=linux-aarch64)"
        );
        // The kernel model shapes relocatable objects only.
        assert_eq!(
            reject(&[X64, "-mcmodel=kernel", "a.c"]).0,
            "badc: error: `-mcmodel=kernel` shapes relocatable objects; it requires `-c` or `--ar`"
        );
    }

    #[test]
    fn hardening_flags_reject_what_is_not_emitted() {
        let cli = parse(&[
            X64,
            "-mharden-sls=all",
            "-fcf-protection=branch",
            "-c",
            "a.c",
        ]);
        assert!(cli.codegen.hardening.sls_return && cli.codegen.hardening.sls_indirect_jmp);
        assert!(cli.codegen.hardening.cf_protection_branch);
        assert_eq!(
            reject(&["-fcf-protection=full", "a.c"]).0,
            "badc: error: unsupported argument `full` to `-fcf-protection=` \
             (supported: none, branch)"
        );
        assert_eq!(
            reject(&["-mbranch-protection=gcs", "a.c"]).0,
            "badc: error: unsupported feature `gcs` in `-mbranch-protection=` \
             (supported: none, bti, pac-ret, standard)"
        );
    }

    #[test]
    fn stack_protector_needs_a_compiled_output_and_a_reachable_guard() {
        let cli = parse(&[
            X64,
            "-fstack-protector-strong",
            "--param",
            "ssp-buffer-size=4",
            "-c",
            "a.c",
        ]);
        assert_eq!(cli.codegen.stack_protect.mode, badc::StackProtector::Strong);
        assert_eq!(cli.codegen.stack_protect.buffer_size, 4);
        assert_eq!(
            reject(&["-fstack-protector", "--jit", "a.c"]).0,
            "badc: error: `-fstack-protector*` needs a compiled output: \
             `--jit` and `--interp` execute in this process and reach no \
             `__stack_chk_fail`"
        );
        // On x86-64 a named register implies gcc's `tls` default.
        assert_eq!(
            reject(&[X64, "-mstack-protector-guard-reg=r15", "a.c"]).0,
            "badc: error: unsupported argument `r15` to \
             `-mstack-protector-guard-reg=` under `=tls` (supported: fs, gs)"
        );
        // Elsewhere the operands only make sense with the form flag.
        assert_eq!(
            reject(&[A64, "-mstack-protector-guard-reg=sp_el0", "a.c"]).0,
            "badc: error: `-mstack-protector-guard-reg=` / \
             `-mstack-protector-guard-offset=` need `-mstack-protector-guard=`"
        );
        assert_eq!(
            reject(&["--param", "nope=1", "a.c"]).0,
            "badc: error: unsupported `--param` name `nope` (supported: ssp-buffer-size)"
        );
    }

    #[test]
    fn freestanding_and_shared_pick_the_image_shape() {
        assert!(parse(&["--freestanding", "a.c"]).freestanding);
        assert_eq!(parse(&["--shared", "a.c"]).mode, Mode::SharedLibrary);
        assert_eq!(parse(&["-shared", "a.c"]).mode, Mode::SharedLibrary);
        assert_eq!(parse(&["a.c"]).mode, Mode::NativeExecutable);
    }

    #[test]
    fn install_is_decided_before_the_target() {
        match parse_args(argv(&["--install", "/tmp/dest"])) {
            Ok(Parsed::Install { dir, quiet }) => {
                assert_eq!(dir.unwrap(), PathBuf::from("/tmp/dest"));
                assert!(!quiet);
            }
            other => panic!("expected an install, got {}", outcome(&other)),
        }
        match parse_args(argv(&["--install", "-q"])) {
            Ok(Parsed::Install { dir, quiet }) => {
                assert!(dir.is_none());
                assert!(quiet);
            }
            other => panic!("expected an install, got {}", outcome(&other)),
        }
    }

    #[test]
    fn vm_modes_take_their_own_flags() {
        let cli = parse(&["--interp", "--track-pointers", "--trace", "a.c"]);
        assert_eq!(cli.mode, Mode::Interp);
        assert!(cli.track_pointers && cli.trace);
        assert_eq!(parse(&["--jit", "a.c"]).mode, Mode::Jit);
        assert_eq!(
            reject(&["--track-pointers", "a.c"]).0,
            "badc: --track-pointers / --trace require --interp (current mode is (default))"
        );
        assert_eq!(
            reject(&["--jit", "-o", "x", "a.c"]).0,
            "badc: -o is only meaningful for native compilation (current mode is --jit)"
        );
    }

    #[test]
    fn preprocess_only_has_two_spellings() {
        assert_eq!(parse(&["-E", "a.c"]).mode, Mode::DumpPp);
        assert_eq!(parse(&["--dump-pp", "a.c"]).mode, Mode::DumpPp);
    }

    #[test]
    fn link_map_takes_both_spellings_and_requires_a_link() {
        assert_eq!(
            parse(&["-Map=link.map", "a.c"]).link.map_path.unwrap(),
            PathBuf::from("link.map")
        );
        assert_eq!(
            parse(&["-Map", "link.map", "a.c"]).link.map_path.unwrap(),
            PathBuf::from("link.map")
        );
        assert!(parse(&["--print-map", "a.c"]).link.print_map);
        assert_eq!(
            reject(&["-Map"]),
            ("badc: error: -Map requires a file argument".to_string(), 1)
        );
        assert_eq!(
            reject(&["-c", "-Map=x.map", "a.c"]).0,
            "badc: -Map / --print-map require a link (current mode is -c)"
        );
    }

    #[test]
    fn at_most_one_mode_flag_applies() {
        assert_eq!(
            reject(&["--jit", "--interp", "a.c"]).0,
            "badc: --interp can't be combined with --jit -- both pick an \
             output mode (Mode::Interp vs Mode::Jit). See --help."
        );
    }

    #[test]
    fn help_and_version_stop_reading_the_rest() {
        for flag in ["-h", "--help"] {
            match parse_args(argv(&[flag, "--no-such-option"])) {
                Ok(Parsed::Print(text)) => assert!(text.starts_with("usage: badc")),
                other => panic!("{flag}: expected the usage, got {}", outcome(&other)),
            }
        }
        for flag in ["-v", "--version"] {
            match parse_args(argv(&[flag, "--no-such-option"])) {
                Ok(Parsed::Print(text)) => assert_eq!(text, badc::BUILD_INFO),
                other => panic!("{flag}: expected the build info, got {}", outcome(&other)),
            }
        }
    }

    #[test]
    fn an_unknown_dash_token_is_an_option_not_an_input() {
        assert_eq!(
            reject(&["--no-such-option", "a.c"]),
            (
                "badc: error: unknown option `--no-such-option`".to_string(),
                1
            )
        );
        // `-` alone is the stdin source and stays a positional.
        assert_eq!(
            parse(&["-c", "-"]).positional,
            vec!["badc".to_string(), "-".to_string()]
        );
    }

    #[test]
    fn the_ld_option_surface_reaches_the_link_options() {
        let cli = parse(&[
            "-T",
            "link.ld",
            "--orphan-handling=warn",
            "--build-id=sha1",
            "-z",
            "max-page-size=0x1000",
            "-z",
            "pack-relative-relocs",
            "--emit-relocs",
            "--export-all",
            "--export-data",
            "-X",
            "--discard-none",
            "--no-apply-dynamic-relocs",
            "--strip-debug",
            "--fix-cortex-a53-843419",
            "a.o",
        ]);
        assert_eq!(cli.link.script_path.unwrap(), PathBuf::from("link.ld"));
        assert_eq!(cli.link.orphan_handling, badc::OrphanHandling::Warn);
        assert!(cli.link.build_id_sha1);
        assert_eq!(cli.link.max_page_size, Some(0x1000));
        assert!(cli.link.pack_relative_relocs);
        assert!(cli.link.emit_relocs && cli.link.export_all && cli.link.export_data);
        assert!(cli.link.discard_locals && cli.link.discard_none);
        assert!(!cli.link.apply_dynamic_relocs);
        assert!(cli.link.strip_debug && cli.link.fix_cortex_a53_843419);
        assert_eq!(
            parse(&["--script=x.ld", "a.o"]).link.script_path.unwrap(),
            PathBuf::from("x.ld")
        );
        assert_eq!(
            parse(&["-Tx.ld", "a.o"]).link.script_path.unwrap(),
            PathBuf::from("x.ld")
        );
        assert_eq!(
            reject(&["-z", "nope", "a.o"]),
            ("badc: error: unknown -z keyword `nope`".to_string(), 1)
        );
        assert_eq!(
            reject(&["-z", "max-page-size=3", "a.o"]),
            (
                "badc: error: -z max-page-size requires a power of two".to_string(),
                1
            )
        );
        assert_eq!(
            reject(&["-T"]),
            (
                "badc: error: -T/--script requires a file argument".to_string(),
                1
            )
        );
    }

    #[test]
    fn ld_emulation_names_a_target_only_when_none_was_given() {
        assert_eq!(parse(&["-melf_x86_64", "a.c"]).target, Target::LinuxX64);
        assert_eq!(
            parse(&["-m", "aarch64linux", "a.c"]).target,
            Target::LinuxAarch64
        );
        assert_eq!(
            parse(&[X64, "-maarch64linux", "a.c"]).target,
            Target::LinuxX64
        );
        assert_eq!(
            reject(&["-m", "nope", "a.c"]),
            ("badc: error: unknown emulation `nope`".to_string(), 1)
        );
        assert_eq!(
            reject(&["-m"]),
            ("badc: error: -m requires an emulation name".to_string(), 1)
        );
    }

    #[test]
    fn whole_archive_spans_the_positionals_it_encloses() {
        // `positional[0]` is argv[0], so the span covers `b.a` alone.
        let cli = parse(&["a.o", "--whole-archive", "b.a", "--no-whole-archive", "c.a"]);
        assert_eq!(cli.link.whole_archive, vec![(2, 3)]);
        // An unclosed span runs to the end of the command line.
        let cli = parse(&["a.o", "--whole-archive", "b.a", "c.a"]);
        assert_eq!(cli.link.whole_archive, vec![(2, 4)]);
    }

    #[test]
    fn entry_and_subsystem_override_the_source_pragmas() {
        let cli = parse(&["--entry=start", "--subsystem=efi_application", "a.o"]);
        assert_eq!(cli.link.entry.as_deref(), Some("start"));
        assert_eq!(cli.link.subsystem, Some(badc::Subsystem::EfiApplication));
        assert!(
            reject(&["--subsystem=nope", "a.o"])
                .0
                .contains("unknown kind `nope`")
        );
    }

    #[test]
    fn dialect_selects_only_strict_conformance() {
        assert!(parse(&["-std=gnu11", "a.c"]).front.gnu_dialect);
        assert!(!parse(&["-std=c99", "a.c"]).front.gnu_dialect);
        assert!(!parse(&["-std=iso9899:1999", "a.c"]).front.gnu_dialect);
        assert!(parse(&["--gnu", "a.c"]).front.gnu);
        assert!(parse(&["-nostdinc", "a.c"]).front.nostdinc);
        assert_eq!(
            reject(&["-std=fortran", "a.c"]),
            (
                "badc: error: unknown C dialect `fortran` (-std=)".to_string(),
                1
            )
        );
    }

    #[test]
    fn quiet_and_include_tracing_are_flags_of_the_run() {
        assert!(parse(&["-q", "a.c"]).quiet);
        assert!(parse(&["--quiet", "a.c"]).quiet);
        assert!(parse(&["-H", "a.c"]).front.show_includes);
        assert!(parse(&["--show-includes", "a.c"]).front.show_includes);
        assert_eq!(parse(&["--inline-cap=7", "a.c"]).codegen.inline_cap, 7);
        assert_eq!(
            reject(&["--inline-cap=x", "a.c"]),
            (
                "badc: error: --inline-cap=N requires a non-negative integer".to_string(),
                1
            )
        );
    }
}

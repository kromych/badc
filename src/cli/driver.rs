use std::io::{IsTerminal, Read};
use std::path::PathBuf;

use badc::{Compiler, NativeOptions, Target, Vm, jit_run_with_options};

use super::compile::{
    CompileCfg, compile_native_tu, compile_object_tu, compile_units, tu_defines, worker_count,
};
use super::deps::{DepKind, DepOptions, emit_deps};
use super::diag::{TuLog, colorize_diagnostic, eprint_diagnostic};
use super::dump::{dump_bundled_headers, dump_native_link, print_predefined_symbols};
use super::inputs::{
    fat_slice_for_target, find_library, ingest_linker_input, library_spellings, machine_label,
    macos_sdk_lib_dir, native_defined_globals, native_defined_globals_logged, target_machine,
    unreadable_object_reason,
};
use super::options::{
    AssemblerOption, Mode, SourceKind, accept_assembler_option, parse_c_integer, parse_jobs,
};
use super::output::{post_write_native, set_executable, write_output};
use super::paths::{
    badc_home, default_output_path, default_system_include_paths, install_embedded,
    source_tree_include,
};
use super::script_link::{LinkInputCli, ScriptLinkCli, run_script_link};
use super::stats::LinkStats;
use super::usage::USAGE;

pub(crate) fn run() {
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
    let mut mcpu: Option<String> = None;
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
    // `-ffixed-REG` operands, resolved against the target once it is known.
    let mut fixed_reg_names: Vec<String> = Vec::new();
    let mut mstrict_align = false;
    let mut fpic = false;
    // `-fno-pic` / `-fno-pie`, tracked apart from `fpic` because the
    // absence of any PIC flag and an explicit opt-out choose different
    // `const` placements in a `-c` object; see `NativeOptions::pic_link`.
    let mut fno_pic = false;
    let mut jump_tables = true;
    // `-Wa,-L` / `-Wa,--keep-locals`.
    let mut keep_local_labels = false;
    let mut min_function_alignment: u32 = 1;
    let mut patchable_function_entry = badc::PatchableEntry::NONE;
    let mut profiling = badc::Profiling::OFF;
    // The `-pg` modifiers seen, x86-64 options gcc's aarch64 rejects.
    let mut mcount_modifiers: Vec<String> = Vec::new();
    let mut code_model = badc::CodeModel::Small;
    let mut code_model_tiny = false;
    let mut hardening = badc::Hardening::NONE;
    let mut stack_protect = badc::StackProtect::OFF;
    // `-mstack-protector-guard-reg=` on aarch64 names a system register the
    // guard offset applies to; the `sysreg` form needs both, so the operands
    // are collected as they arrive and combined once the loop ends.
    let mut ssp_guard_kind: Option<&'static str> = None;
    let mut ssp_guard_reg: Option<String> = None;
    let mut ssp_guard_offset: Option<i32> = None;
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
    let mut strict_flex_arrays: u8 = 0;
    // `-fshort-wchar` -- narrow `wchar_t` to an unsigned 16-bit type.
    let mut short_wchar = false;
    // `-ftrivial-auto-var-init=` -- what an automatic object declared
    // without an initializer holds; see `AutoVarInit`.
    let mut auto_var_init = badc::AutoVarInit::Uninitialized;
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
    let mut fix_cortex_a53_843419 = false;
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
                    match accept_assembler_option(opt) {
                        Ok(o) => keep_local_labels |= o == AssemblerOption::KeepLocals,
                        Err(e) => {
                            eprint_diagnostic(e);
                            std::process::exit(1);
                        }
                    }
                }
            }
            "-Xassembler" => match iter.next() {
                Some(opt) => match accept_assembler_option(&opt) {
                    Ok(o) => keep_local_labels |= o == AssemblerOption::KeepLocals,
                    Err(e) => {
                        eprint_diagnostic(e);
                        std::process::exit(1);
                    }
                },
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
            // Keep a register out of the allocator; see `NativeOptions::fixed_regs`.
            s if s.starts_with("-ffixed-") => {
                let name = &s["-ffixed-".len()..];
                if name.is_empty() {
                    eprint_diagnostic("badc: error: `-ffixed-` requires a register name");
                    std::process::exit(1);
                }
                fixed_reg_names.push(name.to_string());
            }
            // Keep every compiler-generated memory access naturally
            // aligned for its width. Code that runs with the MMU off
            // sees Device-typed memory, where an unaligned access
            // raises an alignment fault instead of being fixed up;
            // see `NativeOptions::strict_align`.
            // AArch64 CPU selection. The base name picks a scheduling
            // model badc does not differentiate; the extensions decide
            // the feature macros, resolved once the target is known.
            s if s.starts_with("-mcpu=") => mcpu = Some(s["-mcpu=".len()..].to_string()),
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
            // gcc `-fstack-protector*`: which functions carry a stack
            // canary. The per-function rule is gcc's, applied to the
            // declared automatic objects; see `StackProtector`.
            "-fno-stack-protector" => stack_protect.mode = badc::StackProtector::Off,
            "-fstack-protector" => stack_protect.mode = badc::StackProtector::Basic,
            "-fstack-protector-strong" => stack_protect.mode = badc::StackProtector::Strong,
            "-fstack-protector-all" => stack_protect.mode = badc::StackProtector::All,
            // gcc `--param <name>=<value>`, in both the separate-argument
            // and joined spellings. `ssp-buffer-size` is the only name with
            // an effect here; an unrecognized one is rejected rather than
            // dropped, so a tuning request cannot pass silently.
            s if s == "--param" || s.starts_with("--param=") => {
                let spec = if s == "--param" {
                    match iter.next() {
                        Some(v) => v,
                        None => {
                            eprint_diagnostic("badc: error: `--param` takes an argument");
                            std::process::exit(1);
                        }
                    }
                } else {
                    s["--param=".len()..].to_string()
                };
                let (name, value) = match spec.split_once('=') {
                    Some(p) => p,
                    None => {
                        eprint_diagnostic(format!(
                            "badc: error: `--param` takes `<name>=<value>`, got `{spec}`"
                        ));
                        std::process::exit(1);
                    }
                };
                if name != "ssp-buffer-size" {
                    eprint_diagnostic(format!(
                        "badc: error: unsupported `--param` name `{name}` \
                         (supported: ssp-buffer-size)"
                    ));
                    std::process::exit(1);
                }
                match value.parse::<u32>() {
                    Ok(n) if n > 0 => stack_protect.buffer_size = n,
                    _ => {
                        eprint_diagnostic(format!(
                            "badc: error: `ssp-buffer-size` takes a positive \
                             integer, got `{value}`"
                        ));
                        std::process::exit(1);
                    }
                }
            }
            // gcc `-mstack-protector-guard=`: where the guard value lives.
            // `tls` is the x86-64 segment-relative form, `sysreg` the
            // aarch64 system-register form, `global` the `__stack_chk_guard`
            // object. Validated against the target once the loop ends.
            s if s.starts_with("-mstack-protector-guard=") => {
                ssp_guard_kind = match &s["-mstack-protector-guard=".len()..] {
                    "global" => Some("global"),
                    "tls" => Some("tls"),
                    "sysreg" => Some("sysreg"),
                    other => {
                        eprint_diagnostic(format!(
                            "badc: error: unsupported argument `{other}` to \
                             `-mstack-protector-guard=` (supported: global, tls, sysreg)"
                        ));
                        std::process::exit(1);
                    }
                };
            }
            s if s.starts_with("-mstack-protector-guard-reg=") => {
                ssp_guard_reg = Some(s["-mstack-protector-guard-reg=".len()..].to_string());
            }
            s if s.starts_with("-mstack-protector-guard-offset=") => {
                let spec = &s["-mstack-protector-guard-offset=".len()..];
                match parse_c_integer(spec) {
                    Some(n) => ssp_guard_offset = Some(n),
                    None => {
                        eprint_diagnostic(format!(
                            "badc: error: `-mstack-protector-guard-offset=` takes \
                             an integer, got `{spec}`"
                        ));
                        std::process::exit(1);
                    }
                }
            }
            s if s.starts_with("-mstack-protector-guard-symbol=") => {
                let spec = &s["-mstack-protector-guard-symbol=".len()..];
                match badc::GuardSymbol::new(spec) {
                    Some(g) => stack_protect.guard_symbol = g,
                    None => {
                        eprint_diagnostic(format!(
                            "badc: error: `-mstack-protector-guard-symbol=` takes \
                             a symbol name of 1 to {} bytes, got `{spec}`",
                            badc::GuardSymbol::CAP
                        ));
                        std::process::exit(1);
                    }
                }
            }
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
            // gcc `-fpatchable-function-entry=N[,M]`: N NOPs at every
            // function entry, M of them ahead of the symbol, recorded per
            // function in `__patchable_function_entries`.
            s if s.starts_with("-fpatchable-function-entry=") => {
                let spec = &s["-fpatchable-function-entry=".len()..];
                let (n, m) = spec.split_once(',').unwrap_or((spec, "0"));
                match (n.parse::<u32>(), m.parse::<u32>()) {
                    (Ok(nops), Ok(before)) if before <= nops => {
                        patchable_function_entry = badc::PatchableEntry { nops, before };
                    }
                    _ => {
                        eprint_diagnostic(format!(
                            "badc: error: `-fpatchable-function-entry=` takes `N[,M]` \
                             with M <= N, got `{spec}`"
                        ));
                        std::process::exit(1);
                    }
                }
            }
            "-pg" => profiling.enabled = true,
            "-mfentry" | "-mno-fentry" => {
                profiling.fentry = arg == "-mfentry";
                mcount_modifiers.push(arg.clone());
            }
            "-mrecord-mcount" | "-mno-record-mcount" => {
                profiling.record_mcount = arg == "-mrecord-mcount";
                mcount_modifiers.push(arg.clone());
            }
            "-mnop-mcount" | "-mno-nop-mcount" => {
                profiling.nop_mcount = arg == "-mnop-mcount";
                mcount_modifiers.push(arg.clone());
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
            // gcc `-fstrict-flex-arrays[=N]`: which trailing array members
            // `__builtin_object_size` treats as unbounded. The bare form
            // is level 3, as in gcc.
            "-fstrict-flex-arrays" => strict_flex_arrays = 3,
            s if s.starts_with("-fstrict-flex-arrays=") => {
                let spec = &s["-fstrict-flex-arrays=".len()..];
                match spec.parse::<u8>() {
                    Ok(n) if n <= 3 => strict_flex_arrays = n,
                    _ => {
                        eprint_diagnostic(format!(
                            "badc: error: `-fstrict-flex-arrays=` takes a level \
                             0..=3, got `{spec}`"
                        ));
                        std::process::exit(1);
                    }
                }
            }
            // gcc / clang `-fshort-wchar`: `wchar_t` becomes an unsigned
            // 16-bit type on every target. It changes the layout of every
            // object holding a `wchar_t` or a wide literal, so it has to
            // reach the front end rather than be dropped as a no-op.
            "-fshort-wchar" => short_wchar = true,
            "-fno-short-wchar" => short_wchar = false,
            // gcc `-ftrivial-auto-var-init=`: the front end supplies the
            // initializer, so every output mode carries it.
            s if s.starts_with("-ftrivial-auto-var-init=") => {
                let spec = &s["-ftrivial-auto-var-init=".len()..];
                auto_var_init = match spec {
                    "uninitialized" => badc::AutoVarInit::Uninitialized,
                    "zero" => badc::AutoVarInit::Zero,
                    "pattern" => badc::AutoVarInit::Pattern,
                    _ => {
                        eprint_diagnostic(format!(
                            "badc: error: unsupported argument `{spec}` to \
                             `-ftrivial-auto-var-init=` (supported: uninitialized, \
                             zero, pattern)"
                        ));
                        std::process::exit(1);
                    }
                };
            }
            // gcc `-fzero-init-padding-bits=`: measured on all three
            // targets at both optimization levels, a partially initialized
            // automatic struct or union has zero padding whichever value is
            // named, since the whole object is zero-filled before its
            // members are stored. The argument is checked and nothing
            // changes.
            s if s.starts_with("-fzero-init-padding-bits=") => {
                let spec = &s["-fzero-init-padding-bits=".len()..];
                if !matches!(spec, "standard" | "unions" | "all") {
                    eprint_diagnostic(format!(
                        "badc: error: unsupported argument `{spec}` to \
                         `-fzero-init-padding-bits=` (supported: standard, unions, all)"
                    ));
                    std::process::exit(1);
                }
            }
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
            "--fix-cortex-a53-843419" => fix_cortex_a53_843419 = true,
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

    let mut fixed_regs = badc::FixedRegs::NONE;
    for name in &fixed_reg_names {
        match badc::fixed_register(target, name) {
            Ok(reg) => fixed_regs.insert(reg),
            Err(e) => {
                eprint_diagnostic(format!("badc: error: {e}"));
                std::process::exit(1);
            }
        }
    }

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
    // `--jit` and `--interp` execute in this process: the JIT resolves no
    // undefined symbol and the interpreter has no machine frame at all, so
    // neither can carry a canary.
    if stack_protect.mode != badc::StackProtector::Off && matches!(mode, Mode::Jit | Mode::Interp) {
        eprint_diagnostic(
            "badc: error: `-fstack-protector*` needs a compiled output: \
             `--jit` and `--interp` execute in this process and reach no \
             `__stack_chk_fail`",
        );
        std::process::exit(1);
    }
    // The profiling call and the patchable-entry records are ELF object
    // contracts: the call names `__fentry__` / `mcount` for the link and
    // the records are sections of the object.
    // TODO: the aarch64 `-pg` form and the PE / Mach-O records.
    let is_elf_target = matches!(target, badc::Target::LinuxX64 | badc::Target::LinuxAarch64);
    if profiling.enabled && matches!(mode, Mode::Jit | Mode::Interp) {
        eprint_diagnostic(
            "badc: error: `-pg` needs a compiled output: `--jit` and `--interp` \
             execute in this process and reach no `__fentry__`",
        );
        std::process::exit(1);
    }
    if profiling.enabled && (!is_elf_target || target.is_aarch64()) {
        eprint_diagnostic(format!(
            "badc: error: `-pg` is not implemented for {}",
            target.id_str()
        ));
        std::process::exit(1);
    }
    if let Some(flag) = mcount_modifiers.first()
        && target.is_aarch64()
    {
        eprint_diagnostic(format!(
            "badc: error: `{flag}` is an x86-64 option; gcc's aarch64 has none"
        ));
        std::process::exit(1);
    }
    if patchable_function_entry != badc::PatchableEntry::NONE && !is_elf_target {
        eprint_diagnostic(format!(
            "badc: error: `-fpatchable-function-entry=` is not implemented for {}",
            target.id_str()
        ));
        std::process::exit(1);
    }
    // The canary sequences name the System V handler and guard object.
    // Windows targets link against msvcrt, which exports neither (the
    // Microsoft scheme is `__security_cookie` / `__security_check_cookie`,
    // which badc does not emit), so an object built here would reference
    // symbols nothing defines.
    // TODO: emit the Microsoft cookie sequence for the Windows targets.
    if stack_protect.mode != badc::StackProtector::Off && target.is_windows() {
        eprint_diagnostic(
            "badc: error: `-fstack-protector*` is not implemented for the Windows \
             targets: their C library exports neither `__stack_chk_guard` nor \
             `__stack_chk_fail`",
        );
        std::process::exit(1);
    }
    // `-mstack-protector-guard*`: the operands only make sense together and
    // only on the architecture whose form they name, so the combination is
    // checked once the target is known. An unusable one is an error rather
    // than a default, since a guard read from the wrong place would leave
    // the image claiming a protection it does not have.
    // gcc's x86 default for `-mstack-protector-guard=` is `tls`, so the
    // kernel names only the register and the symbol on SMP builds.
    let ssp_guard_kind = ssp_guard_kind.or_else(|| {
        let named = ssp_guard_reg.is_some() || ssp_guard_offset.is_some();
        (named && target.is_x86_64()).then_some("tls")
    });
    if let Some(kind) = ssp_guard_kind {
        stack_protect.guard = match kind {
            "global" => badc::StackGuard::Global,
            "tls" => {
                if !target.is_x86_64() {
                    eprint_diagnostic(
                        "badc: error: `-mstack-protector-guard=tls` is an x86-64 form; \
                         use `global` or `sysreg`",
                    );
                    std::process::exit(1);
                }
                let seg = match ssp_guard_reg.as_deref() {
                    None | Some("fs") => badc::GuardSeg::Fs,
                    Some("gs") => badc::GuardSeg::Gs,
                    Some(other) => {
                        eprint_diagnostic(format!(
                            "badc: error: unsupported argument `{other}` to \
                             `-mstack-protector-guard-reg=` under `=tls` (supported: fs, gs)"
                        ));
                        std::process::exit(1);
                    }
                };
                badc::StackGuard::Tls {
                    seg,
                    offset: ssp_guard_offset.unwrap_or(badc::SYSV_TLS_GUARD_OFFSET),
                }
            }
            _ => {
                if !target.is_aarch64() {
                    eprint_diagnostic(
                        "badc: error: `-mstack-protector-guard=sysreg` is an aarch64 form; \
                         use `global` or `tls`",
                    );
                    std::process::exit(1);
                }
                let (Some(reg), Some(offset)) = (ssp_guard_reg.as_deref(), ssp_guard_offset) else {
                    eprint_diagnostic(
                        "badc: error: `-mstack-protector-guard=sysreg` needs both \
                         `-mstack-protector-guard-reg=` and `-mstack-protector-guard-offset=`",
                    );
                    std::process::exit(1);
                };
                let Some(sysreg) = badc::stack_guard_sysreg(reg) else {
                    eprint_diagnostic(format!(
                        "badc: error: `-mstack-protector-guard-reg={reg}` names no \
                         AArch64 system register"
                    ));
                    std::process::exit(1);
                };
                badc::StackGuard::Sysreg { sysreg, offset }
            }
        };
    } else if ssp_guard_reg.is_some() || ssp_guard_offset.is_some() {
        eprint_diagnostic(
            "badc: error: `-mstack-protector-guard-reg=` / \
             `-mstack-protector-guard-offset=` need `-mstack-protector-guard=`",
        );
        std::process::exit(1);
    }
    if !stack_protect.guard_symbol.is_empty() && ssp_guard_offset.is_some() {
        eprint_diagnostic(
            "badc: error: `-mstack-protector-guard-symbol=` and \
             `-mstack-protector-guard-offset=` are mutually exclusive",
        );
        std::process::exit(1);
    }
    if !stack_protect.guard_symbol.is_empty()
        && !matches!(
            stack_protect.guard,
            badc::StackGuard::Global | badc::StackGuard::Tls { .. }
        )
    {
        eprint_diagnostic(
            "badc: error: `-mstack-protector-guard-symbol=` applies to the \
             `global` and `tls` guard forms only",
        );
        std::process::exit(1);
    }
    if let Some(spec) = &mcpu {
        if !matches!(
            target,
            badc::Target::LinuxAarch64 | badc::Target::MacOSAarch64 | badc::Target::WindowsAarch64
        ) {
            eprint_diagnostic(
                "badc: error: `-mcpu=` names an AArch64 CPU; the x86-64 targets take none",
            );
            std::process::exit(1);
        }
        // gcc's model, measured: `+crypto` is `+aes+sha2`, `no<ext>`
        // subtracts, and __ARM_FEATURE_CRYPTO holds only while both do.
        // The AES and SHA-2 encodings are always in badc's tables; any
        // other modifier is refused rather than accepted inertly.
        let mut parts = spec.split('+');
        if parts.next().unwrap_or("").is_empty() {
            eprint_diagnostic(format!("badc: error: `-mcpu={spec}` names no CPU"));
            std::process::exit(1);
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
                    eprint_diagnostic(format!(
                        "badc: error: `-mcpu=` extension `{other}` is not \
                         implemented; badc implements `crypto`, `aes`, \
                         `sha2` and their `no` forms"
                    ));
                    std::process::exit(1);
                }
            }
        }
        for (name, on) in [
            ("__ARM_FEATURE_AES", aes),
            ("__ARM_FEATURE_SHA2", sha2),
            ("__ARM_FEATURE_CRYPTO", aes && sha2),
        ] {
            if on && !defines.iter().any(|(n, _)| n == name) {
                defines.push((name.to_string(), String::from("1")));
            }
        }
    }
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
            fix_cortex_a53_843419,
        };
        run_script_link(opts);
        return;
    }
    if fix_cortex_a53_843419 {
        // Implemented by the script-driven engine only.
        // TODO: scan for the erratum sequences on the scriptless path.
        eprintln!(
            "badc: note: --fix-cortex-a53-843419 accepted; erratum veneers are not \
             generated without -T/--script"
        );
    }

    // Resolve `-l<name>` against the `-L<dir>` paths, then the standard
    // system directories for the target's format. A shared library
    // (`lib<name>.so` / `.dylib` / `.tbd`) is preferred over a static
    // archive (`lib<name>.a`), matching `ld`'s default search order:
    // the shared library becomes a load-time dependency whose exports
    // resolve otherwise-undefined references, the `.a` a positional
    // archive whose members are pulled on demand.
    let mut shared_libs: Vec<badc::SharedLibrary> = Vec::new();
    let mut search_paths: Vec<String> = library_paths.clone();
    // The host's library directories hold this platform's libraries, so
    // they are the target's only when linking for the host platform --
    // the rule the system include path already follows. A cross link
    // names its own sysroot through `-L`.
    let native_link = target == badc::Target::host();
    if native_link {
        if target.binary_format() == badc::BinaryFormat::MachO {
            // ld64's defaults. The runtime dylibs live in the dyld shared
            // cache, not on disk, so the SDK's stub directory is the one
            // that resolves the system libraries.
            for d in ["/usr/local/lib", "/usr/lib"] {
                search_paths.push(d.to_string());
            }
            if let Some(sdk_lib) = macos_sdk_lib_dir() {
                search_paths.push(sdk_lib);
            }
        } else {
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
        }
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
    // (or ld64's `-lSystem`) does: a reference from a foreign object, or
    // one C99 7.1.4p2 let the source declare without its header, becomes
    // a load-time import rather than a link error. The library is the
    // target's, described by the bundled headers' binding set rather
    // than read off the link host (see `TargetCLibrary`), so the image
    // is a function of the sources, the flags and the target alone. The
    // set is materialized during symbol selection below, once the
    // undefined names are known.
    let mut target_libc = (mode == Mode::NativeExecutable && !freestanding)
        .then(|| badc::TargetCLibrary::new(target))
        .flatten();

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
                .with_strict_flex_arrays(strict_flex_arrays)
                .with_short_wchar(short_wchar)
                .with_char_signed(char_signed)
                .with_auto_var_init(auto_var_init)
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
            .with_strict_flex_arrays(strict_flex_arrays)
            .with_short_wchar(short_wchar)
            .with_char_signed(char_signed)
            .with_auto_var_init(auto_var_init)
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
            jit_opts.fixed_regs = fixed_regs;
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
                .with_strict_flex_arrays(strict_flex_arrays)
                .with_short_wchar(short_wchar)
                .with_char_signed(char_signed)
                .with_auto_var_init(auto_var_init)
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
        reloc_opts.patchable_function_entry = patchable_function_entry;
        reloc_opts.profiling = profiling;
        reloc_opts.pic = fpic;
        // These objects are linked into an image below, and every image
        // this toolchain writes takes its data relocations at load time
        // (ELF ET_DYN, PE base relocations, Mach-O dyld rebases), so a
        // relocated `const` cannot ride the read-only prefix and must
        // not cost the unit's pure `const` objects their place in it.
        reloc_opts.pic_link = true;
        reloc_opts.code_model = code_model;
        reloc_opts.hardening = hardening;
        reloc_opts.stack_protect = stack_protect;
        reloc_opts.fixed_regs = fixed_regs;
        reloc_opts.elf_class = object_elf_class;
        reloc_opts.keep_local_labels = keep_local_labels;
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
            strict_flex_arrays,
            short_wchar,
            char_signed,
            auto_var_init,
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
        // `dump` clears `--dump-ssa` for a speculative compile.
        let compile_in_memory = |label: &str, src: String, extra: &[(&str, &str)], dump: bool| {
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
                .with_strict_flex_arrays(strict_flex_arrays)
                .with_short_wchar(short_wchar)
                .with_char_signed(char_signed)
                .with_auto_var_init(auto_var_init)
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
            let mut opts = reloc_opts;
            opts.dump_ssa &= dump;
            // The runtime and the on-demand pool carry the stack-protector
            // handler and the entry stub the canary check would otherwise
            // guard; every toolchain builds them unprotected, and a canary
            // inside the handler would recurse on a real check failure.
            opts.stack_protect = badc::StackProtect::OFF;
            // Nor the user's `-pg` call or patchable entries: the crt objects
            // a toolchain links are built without them.
            opts.profiling = badc::Profiling::OFF;
            opts.patchable_function_entry = badc::PatchableEntry::NONE;
            match badc::emit_native_with_options_owned(program, target, opts) {
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
            let bytes = compile_in_memory(&label, src, &runtime_defines, true);
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
            let bytes = fat_slice_for_target(bytes, target);
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
            // A universal (fat) archive wraps one archive per
            // architecture; read the slice matching the target.
            if badc::is_mach_o_fat(&bytes)
                && badc::mach_o_fat_slice(&bytes, target_machine(target)).is_none()
            {
                eprint_diagnostic(format!(
                    "badc: error: `{a_path}` is a universal (fat) container with no {} slice",
                    machine_label(target_machine(target)),
                ));
                std::process::exit(1);
            }
            let bytes = fat_slice_for_target(bytes, target);
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
                // A member may itself be a fat object (`lipo` output
                // archived as-is).
                let member_bytes = fat_slice_for_target(m.bytes, target);
                if !badc::is_native_object(&member_bytes) {
                    eprint_diagnostic(format!(
                        "badc: error: archive `{a_path}` member `{}`: {}",
                        m.name,
                        unreadable_object_reason(&member_bytes, target)
                    ));
                    std::process::exit(1);
                }
                match badc::parse_native_object(&member_bytes) {
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
        // everything compiles none of them. Whether it stalls turns on
        // the link's inputs, the host's C library among them, so this
        // compile stays out of the `--dump-ssa` output.
        let mut on_demand_loaded = false;
        let load_on_demand = |pending: &mut Vec<Option<badc::NativeObject>>,
                              stats: &mut LinkStats| {
            let on_demand = badc::embedded_compiler_rt()
                .iter()
                .map(|e| ("compiler-rt", e))
                .chain(badc::embedded_libc().iter().map(|e| ("libc", e)));
            for (dir, (name, body)) in on_demand {
                let label = format!("<{dir}/{name}>");
                let bytes = compile_in_memory(&label, body.to_string(), &[], false);
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
        let mut defined = hashbrown::HashSet::<String>::new();
        // Unresolved strong references, each keyed to the first
        // input that made it (the link map's "referenced by" file).
        let mut undefined = hashbrown::HashMap::<String, String>::new();
        {
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
                // sources once and resume. A name a `-l` shared
                // library or the target's C library exports resolves as
                // a load-time import, so it does not call for the pool
                // -- matching a system linker, where the implicit C
                // library sits after the archives on the line.
                if on_demand_loaded
                    || undefined.keys().all(|n| {
                        badc::link_synthesized_symbol(n)
                            || shared_libs.iter().any(|l| l.exports.contains(n))
                            || target_libc.as_mut().is_some_and(|l| l.admit(n))
                    })
                {
                    break;
                }
                on_demand_loaded = true;
                load_on_demand(&mut pending, &mut stats);
                progress = true;
            }
        }
        // Whatever the selection left undefined is what the target's C
        // library has to cover for the link to resolve it as an import.
        // Weak references count: a system linker binds one the implicit
        // C library defines rather than resolving it to zero.
        if let Some(lib) = &mut target_libc {
            for o in &native_objs {
                for s in &o.symbols {
                    if s.binding != 0
                        && s.section == badc::NativeSymSection::Undef
                        && !defined.contains(&s.name)
                    {
                        lib.admit(&s.name);
                    }
                }
            }
            if !lib.library().exports.is_empty() {
                shared_libs.push(lib.library().clone());
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
        reloc_opts.patchable_function_entry = patchable_function_entry;
        reloc_opts.profiling = profiling;
        reloc_opts.pic = fpic;
        reloc_opts.pic_link = pic_link_default(fno_pic, code_model);
        reloc_opts.code_model = code_model;
        reloc_opts.hardening = hardening;
        reloc_opts.stack_protect = stack_protect;
        reloc_opts.fixed_regs = fixed_regs;
        reloc_opts.elf_class = object_elf_class;
        reloc_opts.keep_local_labels = keep_local_labels;
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
            strict_flex_arrays,
            short_wchar,
            char_signed,
            auto_var_init,
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
        reloc_opts.patchable_function_entry = patchable_function_entry;
        reloc_opts.profiling = profiling;
        reloc_opts.pic = fpic;
        reloc_opts.pic_link = pic_link_default(fno_pic, code_model);
        reloc_opts.code_model = code_model;
        reloc_opts.hardening = hardening;
        reloc_opts.stack_protect = stack_protect;
        reloc_opts.fixed_regs = fixed_regs;
        reloc_opts.elf_class = object_elf_class;
        reloc_opts.keep_local_labels = keep_local_labels;
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
            strict_flex_arrays,
            short_wchar,
            char_signed,
            auto_var_init,
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
pub(crate) fn pic_link_default(fno_pic: bool, code_model: badc::CodeModel) -> bool {
    !fno_pic && code_model != badc::CodeModel::Kernel
}

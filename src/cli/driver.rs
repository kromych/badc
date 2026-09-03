use std::io::{IsTerminal, Read};
use std::path::PathBuf;

use badc::{Compiler, NativeOptions, Vm, jit_run_with_options};

use super::args::{Cli, Parsed, parse_args};
use super::compile::{
    CompileCfg, compile_native_tu, compile_object_tu, compile_units, tu_defines, worker_count,
};
use super::deps::{DepKind, emit_deps};
use super::diag::{TuLog, colorize_diagnostic, eprint_diagnostic};
use super::dump::{dump_bundled_headers, dump_native_link, print_predefined_symbols};
use super::inputs::{
    fat_slice_for_target, find_library, ingest_linker_input, library_spellings, machine_label,
    macos_sdk_lib_dir, native_defined_globals, native_defined_globals_logged, target_machine,
    unreadable_object_reason,
};
use super::options::{Mode, SourceKind};
use super::output::{post_write_native, set_executable, write_output};
use super::paths::{
    badc_home, default_output_path, default_system_include_paths, install_embedded,
    source_tree_include,
};
use super::script_link::{LinkInputCli, ScriptLinkCli, run_script_link};
use super::stats::LinkStats;

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

    let mut cli = match parse_args(raw) {
        Ok(Parsed::Run(cli)) => cli,
        Ok(Parsed::Print(text)) => {
            println!("{text}");
            return;
        }
        Ok(Parsed::Install { dir, quiet }) => return install(dir, quiet),
        Err(e) => e.report(),
    };
    // The allocator reads the pressure caps from the environment, so
    // they are published before any compile worker starts.
    #[cfg(feature = "codegen_test")]
    for (var, value) in &cli.pressure_caps {
        unsafe { std::env::set_var(var, value) };
    }
    resolve_search_paths(&mut cli);
    dispatch(*cli);
}

/// `--install [<dir>]` copies the embedded headers and runtime sources
/// to disk. The destination is the first positional token, else ~/.badc.
fn install(dir: Option<PathBuf>, quiet: bool) {
    let Some(dir) = dir.or_else(badc_home) else {
        eprint_diagnostic(
            "badc: error: --install: no home directory -- set HOME / USERPROFILE / \
             BADC_HOME or pass an explicit <dir>",
        );
        std::process::exit(1);
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
}

/// Fill the search paths the command line does not name: the on-disk
/// copies of the bundled headers, the `-l` fallback under
/// `$BADC_HOME/lib`, and the host's implicit system include path.
///
/// A bundled header found on disk replaces the in-binary body: first the
/// source tree this badc was built from, then the `badc --install`
/// overlay under ~/.badc (or $BADC_HOME). Editing either takes effect
/// without rebuilding badc. Anchored on the executable and on $HOME,
/// never on the working directory: the include search path must not
/// depend on where badc is invoked from. An explicit -I still shadows a
/// bundled name, as in every other compiler; only a bundled header's own
/// includes stay inside the set. An explicitly set $BADC_HOME is a
/// deliberate choice and outranks the source tree; the implicit ~/.badc
/// does not, so a stale `--install` there cannot shadow the tree a
/// developer is editing.
fn resolve_search_paths(cli: &mut Cli) {
    let home_include = badc_home()
        .map(|h| h.join("include"))
        .filter(|d| d.is_dir());
    let add = |roots: &mut Vec<String>, d: Option<PathBuf>| {
        if let Some(d) = d {
            let s = d.to_string_lossy().into_owned();
            if !roots.contains(&s) {
                roots.push(s);
            }
        }
    };
    let roots = &mut cli.front.own_header_roots;
    if std::env::var_os("BADC_HOME").is_some() {
        add(roots, home_include);
        add(roots, source_tree_include());
    } else {
        add(roots, source_tree_include());
        add(roots, home_include);
    }
    // `~/.badc/lib` joins the `-l` archive search, after explicit -L.
    if let Some(home) = badc_home() {
        let dir = home.join("lib");
        if dir.is_dir() {
            let s = dir.to_string_lossy().into_owned();
            if !cli.link.library_paths.contains(&s) {
                cli.link.library_paths.push(s);
            }
        }
    }
    cli.front.system_include_paths = default_system_include_paths(cli.target, cli.freestanding);
}

/// Run the output mode the command line selected.
fn dispatch(cli: Cli) {
    if cli.mode == Mode::ListSymbols {
        print_predefined_symbols();
        return;
    }

    if cli.mode == Mode::DumpHeaders {
        dump_bundled_headers();
        return;
    }

    if cli.mode == Mode::DumpNativeLink {
        dump_native_link(&cli.positional[1..]);
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
    let mut sources: Vec<String> = Vec::new();
    let mut objects: Vec<String> = Vec::new();
    let mut archives: Vec<String> = Vec::new();
    // Parallel to `archives`: inside a `--whole-archive` span.
    let mut archives_whole: Vec<bool> = Vec::new();
    // Objects and archives in command-line order for the script link.
    let mut link_inputs: Vec<LinkInputCli> = Vec::new();
    let mut prog_args_start: usize = cli.positional.len();
    // Program argv is consumed only by --jit / --interp; every other
    // mode links or preprocesses its inputs and has no argv tail.
    let takes_prog_args = matches!(cli.mode, Mode::Jit | Mode::Interp);
    for (i, a) in cli.positional.iter().enumerate().skip(1) {
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
                let whole = cli.link.whole_archive.iter().any(|&(s, e)| s <= i && i < e);
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
    if let Some(spath) = &cli.link.script_path {
        if !matches!(cli.mode, Mode::NativeExecutable | Mode::SharedLibrary) {
            eprint_diagnostic(format!(
                "badc: error: -T/--script requires a native link (current mode is {})",
                cli.mode.flag_name()
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
            output_path: cli.output_path,
            map_path: cli.link.map_path,
            print_map: cli.link.print_map,
            entry_override: cli.link.entry,
            shared: cli.mode == Mode::SharedLibrary,
            orphan_handling: cli.link.orphan_handling,
            build_id_sha1: cli.link.build_id_sha1,
            max_page_size: cli.link.max_page_size,
            pack_relative_relocs: cli.link.pack_relative_relocs,
            apply_dynamic_relocs: cli.link.apply_dynamic_relocs,
            strip_debug: cli.link.strip_debug,
            discard_locals: cli.link.discard_locals,
            discard_none: cli.link.discard_none,
            emit_relocs: cli.link.emit_relocs,
            quiet: cli.quiet,
            fix_cortex_a53_843419: cli.link.fix_cortex_a53_843419,
        };
        run_script_link(opts);
        return;
    }
    if cli.link.fix_cortex_a53_843419 {
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
    let mut search_paths: Vec<String> = cli.link.library_paths.clone();
    // The host's library directories hold this platform's libraries, so
    // they are the target's only when linking for the host platform --
    // the rule the system include path already follows. A cross link
    // names its own sysroot through `-L`.
    let native_link = cli.target == badc::Target::host();
    if native_link {
        if cli.target.binary_format() == badc::BinaryFormat::MachO {
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
    for name in &cli.link.lib_names {
        match find_library(name, &search_paths, cli.target) {
            Some(p) => {
                if let Err(e) = ingest_linker_input(
                    &p,
                    &search_paths,
                    cli.target,
                    &mut shared_libs,
                    &mut archives,
                    0,
                ) {
                    eprintln!("badc: error: {e}");
                    std::process::exit(1);
                }
            }
            None => {
                let [shared, archive] = library_spellings(name, cli.target);
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
    let mut target_libc = (cli.mode == Mode::NativeExecutable && !cli.freestanding)
        .then(|| badc::TargetCLibrary::new(cli.target))
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
    if matches!(cli.mode, Mode::Jit | Mode::Interp)
        && let Some(src) = sources.iter().find(|s| SourceKind::of(s).is_asm())
    {
        eprint_diagnostic(format!(
            "badc: error: {} does not run assembly (`{src}`); assemble it with \
             -c and link the object",
            cli.mode.flag_name()
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
    if let Some(flag) = &cli.codegen.code_mode_flag {
        // The flags name an x86 code model. gcc's AArch64 driver has no
        // `-m32`, and badc has no AArch32 encoder or predefine set.
        if !cli.target.is_x86_64() {
            eprint_diagnostic(format!(
                "badc: error: `{flag}` selects an x86 code model; target is `{}`",
                cli.target.id_str()
            ));
            std::process::exit(1);
        }
        let preprocess_only = cli.mode == Mode::DumpPp
            || cli.deps.as_ref().map(|d| d.kind) == Some(DepKind::Only) && !cli.compile_only;
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
            if !cli.compile_only && cli.mode != Mode::BuildArchive {
                eprint_diagnostic(format!(
                    "badc: error: `{flag}` applies to `-c` output; badc links no 32-bit image"
                ));
                std::process::exit(1);
            }
        }
    }
    // One dependency file cannot describe several translation units.
    // gcc truncates it per unit, leaving only the last; badc compiles
    // units in parallel, where that would race, so it is refused.
    if let Some(d) = &cli.deps
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
    if let Some(d) = &cli.deps
        && d.kind == DepKind::WithOutput
        && !cli.compile_only
        && !matches!(
            cli.mode,
            Mode::NativeExecutable | Mode::SharedLibrary | Mode::DumpPp
        )
    {
        eprint_diagnostic(format!(
            "badc: error: {} produces no translation-unit output to describe, \
             so -MD / -MMD would write nothing (use -M / -MM for a rule \
             without compiling)",
            cli.mode.flag_name()
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
    if let Some(d) = &cli.deps
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
                .with_gnu(cli.front.gnu)
                .with_gnu89_inline(cli.front.gnu89_inline)
                .with_strict_flex_arrays(cli.front.strict_flex_arrays)
                .with_short_wchar(cli.front.short_wchar)
                .with_char_signed(cli.front.char_signed)
                .with_auto_var_init(cli.front.auto_var_init)
                .with_nostdinc(cli.front.nostdinc)
                .with_no_builtin(cli.front.no_builtin)
                .with_no_builtin_fns(cli.front.no_builtin_fns.clone())
                .with_gnu_dialect(cli.front.gnu_dialect)
                .with_asm_source(SourceKind::of(src).is_asm())
                .with_defines(tu_defines(src, &cli.front.defines))
                .with_undefines(cli.front.undefines.clone())
                .with_include_paths(cli.front.include_paths.clone())
                .with_quote_include_paths(cli.front.quote_include_paths.clone())
                .with_system_include_paths(cli.front.system_include_paths.clone())
                .with_own_header_roots(cli.front.own_header_roots.clone())
                .with_force_includes(cli.front.force_includes.clone())
                .with_source_label(src.clone())
                .with_track_includes(true)
                .with_elf_class(cli.codegen.elf_class)
                .with_code_model(cli.codegen.code_model);
            let compiler = badc::Compiler::with_options(contents, cli.target, copts);
            let mut log = TuLog::default();
            if cli.front.show_includes {
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
                    cli.output_path.as_deref(),
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
    if cli.mode == Mode::Jit || cli.mode == Mode::Interp {
        if !objects.is_empty() || !archives.is_empty() {
            eprint_diagnostic(format!(
                "badc: error: {} runs a single `.c` source and does not link \
                 object / archive inputs",
                cli.mode.flag_name()
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
            .with_gnu(cli.front.gnu)
            .with_gnu89_inline(cli.front.gnu89_inline)
            .with_strict_flex_arrays(cli.front.strict_flex_arrays)
            .with_short_wchar(cli.front.short_wchar)
            .with_char_signed(cli.front.char_signed)
            .with_auto_var_init(cli.front.auto_var_init)
            .with_nostdinc(cli.front.nostdinc)
            .with_no_builtin(cli.front.no_builtin)
            .with_no_builtin_fns(cli.front.no_builtin_fns.clone())
            .with_gnu_dialect(cli.front.gnu_dialect)
            .with_optimize(cli.front.optimize)
            .with_defines(cli.front.defines.clone())
            .with_undefines(cli.front.undefines.clone())
            .with_include_paths(cli.front.include_paths.clone())
            .with_quote_include_paths(cli.front.quote_include_paths.clone())
            .with_system_include_paths(cli.front.system_include_paths.clone())
            .with_own_header_roots(cli.front.own_header_roots.clone())
            .with_force_includes(cli.front.force_includes.clone())
            .with_source_label(src_path.clone())
            .with_track_includes(cli.front.show_includes)
            .with_warn_dead_store(cli.front.warn_dead_store);
        let compiler = Compiler::with_options(contents, cli.target, copts);
        if cli.front.show_includes {
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
        if prog_args_start < cli.positional.len() {
            c_args.extend(cli.positional[prog_args_start..].iter().cloned());
        }
        if cli.mode == Mode::Jit {
            // The JIT lowers for the host; --target plays no part.
            let mut jit_opts = NativeOptions::new().with_inline_cap(cli.codegen.inline_cap);
            jit_opts.fixed_regs = cli.codegen.fixed_regs;
            if cli.front.optimize {
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
        if cli.track_pointers {
            vm = vm.with_pointer_tracking();
        }
        if cli.trace {
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
    if cli.mode == Mode::DumpPp {
        let multi_tu = sources.len() > 1;
        if cli.output_path.is_some() && multi_tu {
            eprintln!(
                "badc: `-o <path>` together with `-E` requires exactly one \
                 source input ({} given)",
                sources.len()
            );
            std::process::exit(1);
        }
        let pp_output = cli.output_path.as_deref().filter(|p| p.as_os_str() != "-");
        // `-MD` / `-MMD` alongside `-E`: gcc preprocesses and writes the
        // rule, naming the file from `-MF` / `-Wp,-M[M]D,<path>` / `-o` as
        // it does for a compile.
        let dump_deps = cli.deps.as_ref().filter(|d| d.kind == DepKind::WithOutput);
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
                .with_gnu(cli.front.gnu)
                .with_gnu89_inline(cli.front.gnu89_inline)
                .with_strict_flex_arrays(cli.front.strict_flex_arrays)
                .with_short_wchar(cli.front.short_wchar)
                .with_char_signed(cli.front.char_signed)
                .with_auto_var_init(cli.front.auto_var_init)
                .with_nostdinc(cli.front.nostdinc)
                .with_no_builtin(cli.front.no_builtin)
                .with_no_builtin_fns(cli.front.no_builtin_fns.clone())
                .with_gnu_dialect(cli.front.gnu_dialect)
                .with_optimize(cli.front.optimize)
                .with_asm_source(SourceKind::of(src_path).is_asm())
                .with_defines(tu_defines(src_path, &cli.front.defines))
                .with_undefines(cli.front.undefines.clone())
                .with_include_paths(cli.front.include_paths.clone())
                .with_quote_include_paths(cli.front.quote_include_paths.clone())
                .with_system_include_paths(cli.front.system_include_paths.clone())
                .with_own_header_roots(cli.front.own_header_roots.clone())
                .with_force_includes(cli.front.force_includes.clone())
                .with_source_label(label.clone())
                .with_track_includes(dump_deps.is_some())
                .with_elf_class(cli.codegen.elf_class)
                .with_code_model(cli.codegen.code_model);
            match Compiler::preprocess_tracked(contents, cli.target, opts) {
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
                            cli.output_path.as_deref(),
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
    if (cli.mode == Mode::NativeExecutable || cli.mode == Mode::SharedLibrary) && !cli.compile_only
    {
        use badc::{Compiler, OutputKind};
        let mut stats = LinkStats::new();
        let mut native_objs: Vec<badc::NativeObject> =
            Vec::with_capacity(sources.len() + objects.len() + archives.len());

        let mut reloc_opts = badc::NativeOptions::new()
            .with_debug_info(cli.codegen.emit_debug_info)
            .with_inline_cap(cli.codegen.inline_cap);
        reloc_opts.no_fp_regs = cli.codegen.no_fp_regs;
        reloc_opts.strict_align = cli.codegen.strict_align;
        reloc_opts.jump_tables = cli.codegen.jump_tables;
        reloc_opts.min_function_alignment = cli.codegen.min_function_alignment;
        reloc_opts.patchable_function_entry = cli.codegen.patchable_function_entry;
        reloc_opts.profiling = cli.codegen.profiling;
        reloc_opts.pic = cli.codegen.fpic;
        // These objects are linked into an image below, and every image
        // this toolchain writes takes its data relocations at load time
        // (ELF ET_DYN, PE base relocations, Mach-O dyld rebases), so a
        // relocated `const` cannot ride the read-only prefix and must
        // not cost the unit's pure `const` objects their place in it.
        reloc_opts.pic_link = true;
        reloc_opts.code_model = cli.codegen.code_model;
        reloc_opts.hardening = cli.codegen.hardening;
        reloc_opts.stack_protect = cli.codegen.stack_protect;
        reloc_opts.fixed_regs = cli.codegen.fixed_regs;
        reloc_opts.elf_class = cli.codegen.elf_class;
        reloc_opts.keep_local_labels = cli.codegen.keep_local_labels;
        if cli.front.optimize {
            reloc_opts = reloc_opts.with_optimize();
        }
        if cli.codegen.dump_ssa {
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
            target: cli.target,
            reloc_opts,
            gnu: cli.front.gnu,
            gnu_dialect: cli.front.gnu_dialect,
            gnu89_inline: cli.front.gnu89_inline,
            strict_flex_arrays: cli.front.strict_flex_arrays,
            short_wchar: cli.front.short_wchar,
            char_signed: cli.front.char_signed,
            auto_var_init: cli.front.auto_var_init,
            nostdinc: cli.front.nostdinc,
            no_builtin: cli.front.no_builtin,
            no_builtin_fns: &cli.front.no_builtin_fns,
            optimize_flag: cli.front.optimize,
            export_all: cli.link.export_all,
            show_includes: cli.front.show_includes,
            warn_dead_store: cli.front.warn_dead_store,
            multi_tu,
            quiet: cli.quiet,
            stderr_is_tty,
            defines: &cli.front.defines,
            undefines: &cli.front.undefines,
            include_paths: &cli.front.include_paths,
            quote_include_paths: &cli.front.quote_include_paths,
            system_include_paths: &cli.front.system_include_paths,
            own_header_roots: &cli.front.own_header_roots,
            force_includes: &cli.front.force_includes,
            deps: cli.deps.as_ref(),
            dep_output: cli.output_path.as_deref(),
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
            let mut copts_defines = cli.front.defines.clone();
            for (k, v) in extra {
                copts_defines.push((k.to_string(), v.to_string()));
            }
            let copts = badc::CompileOptions::default()
                .with_gnu(cli.front.gnu)
                .with_gnu89_inline(cli.front.gnu89_inline)
                .with_strict_flex_arrays(cli.front.strict_flex_arrays)
                .with_short_wchar(cli.front.short_wchar)
                .with_char_signed(cli.front.char_signed)
                .with_auto_var_init(cli.front.auto_var_init)
                .with_nostdinc(cli.front.nostdinc)
                .with_no_builtin(cli.front.no_builtin)
                .with_no_builtin_fns(cli.front.no_builtin_fns.clone())
                .with_gnu_dialect(cli.front.gnu_dialect)
                .with_optimize(cli.front.optimize)
                .with_defines(copts_defines)
                .with_undefines(cli.front.undefines.clone())
                .with_include_paths(cli.front.include_paths.clone())
                .with_system_include_paths(cli.front.system_include_paths.clone())
                .with_own_header_roots(cli.front.own_header_roots.clone())
                .with_force_includes(cli.front.force_includes.clone())
                .with_source_label(label.to_string())
                .with_no_entry_point(true);
            let program = match Compiler::with_options(src, cli.target, copts).compile() {
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
            match badc::emit_native_with_options_owned(program, cli.target, opts) {
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
        let mut entry_override: Option<String> = cli.link.entry.clone();
        // `#pragma subsystem(<kind>)` selects the Windows PE subsystem.
        // Like the entry pragma it is per-TU; the first TU that names
        // one wins. Captured here from the compiled `Program` because
        // the ET_REL round-trip the native path takes does not carry
        // it (the source-level pragma rides the in-memory `Program`,
        // not a section), then threaded to the PE writer.
        let mut subsystem_override: Option<badc::Subsystem> = cli.link.subsystem;
        let mut source_auto_includes: Vec<Vec<String>> = Vec::with_capacity(sources.len());
        // Compile every source (concurrently under `--jobs`), then fold
        // the per-unit facts in source order so entry / subsystem
        // resolution and object order stay scheduling-independent.
        let workers = worker_count(cli.jobs, sources.len());
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
        if cli.freestanding && entry_override.is_none() {
            entry_override = Some("__c5_entry".to_string());
        }
        // A freestanding image must supply its own entry symbol; the
        // embedded runtime that would otherwise define `__c5_entry` is
        // not linked. The entry may come from any input -- a compiled
        // source, a `.o`, or an archive member -- so the defined-entry
        // check runs below, after objects and archive members are
        // parsed, rather than as a bare undefined-symbol relocation at
        // link time.
        let freestanding_entry = cli.freestanding.then(|| {
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
        let links_crt = !cli.freestanding
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
        let emits_start_stub = cli.mode != Mode::SharedLibrary && links_crt;
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
            let bytes = fat_slice_for_target(bytes, cli.target);
            if !badc::is_native_object(&bytes) {
                eprint_diagnostic(format!(
                    "badc: error: `{obj_path}`: {}",
                    unreadable_object_reason(&bytes, cli.target)
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
                && badc::mach_o_fat_slice(&bytes, target_machine(cli.target)).is_none()
            {
                eprint_diagnostic(format!(
                    "badc: error: `{a_path}` is a universal (fat) container with no {} slice",
                    machine_label(target_machine(cli.target)),
                ));
                std::process::exit(1);
            }
            let bytes = fat_slice_for_target(bytes, cli.target);
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
                let member_bytes = fat_slice_for_target(m.bytes, cli.target);
                if !badc::is_native_object(&member_bytes) {
                    eprint_diagnostic(format!(
                        "badc: error: archive `{a_path}` member `{}`: {}",
                        m.name,
                        unreadable_object_reason(&member_bytes, cli.target)
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
                if !cli.quiet {
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
        let allow_undefined = cli.mode == Mode::SharedLibrary;
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
        let native_output_kind = if cli.mode == Mode::SharedLibrary {
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
            let path: &std::path::Path = match cli.output_path.as_deref() {
                Some(o) => o,
                None => {
                    shared_default_path = default_output_path(
                        sources.first().map(|s| s.as_str()).unwrap_or("a"),
                        cli.target,
                        cli.mode,
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
            cli.target,
            shared_lib_name,
            cli.link.export_all,
            cli.link.export_data,
            cli.link.emit_relocs,
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
        let out: &std::path::Path = match cli.output_path.as_deref() {
            Some(o) => o,
            None => {
                default_path = default_output_path(
                    sources.first().map(|s| s.as_str()).unwrap_or("a"),
                    cli.target,
                    cli.mode,
                );
                &default_path
            }
        };
        write_output(out, &bytes, cli.target, cli.quiet);
        set_executable(out);
        post_write_native(out, cli.target);
        if cli.link.map_path.is_some() || cli.link.print_map {
            let out_name = out.file_name().and_then(|n| n.to_str()).unwrap_or("a.out");
            let map = match badc::render_link_map(&merged, &bytes, &archive_inclusions, out_name) {
                Ok(m) => m,
                Err(e) => {
                    eprint_diagnostic(format!("badc: {e}"));
                    std::process::exit(1);
                }
            };
            if let Some(p) = &cli.link.map_path
                && let Err(e) = std::fs::write(p, &map)
            {
                eprint_diagnostic(format!(
                    "badc: error: cannot write map file `{}`: {e}",
                    p.display()
                ));
                std::process::exit(1);
            }
            if cli.link.print_map {
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
    if cli.compile_only {
        if !archives.is_empty() || !cli.link.lib_names.is_empty() {
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
            .with_debug_info(cli.codegen.emit_debug_info)
            .with_inline_cap(cli.codegen.inline_cap);
        reloc_opts.no_fp_regs = cli.codegen.no_fp_regs;
        reloc_opts.strict_align = cli.codegen.strict_align;
        reloc_opts.jump_tables = cli.codegen.jump_tables;
        reloc_opts.min_function_alignment = cli.codegen.min_function_alignment;
        reloc_opts.patchable_function_entry = cli.codegen.patchable_function_entry;
        reloc_opts.profiling = cli.codegen.profiling;
        reloc_opts.pic = cli.codegen.fpic;
        reloc_opts.pic_link = pic_link_default(cli.codegen.fno_pic, cli.codegen.code_model);
        reloc_opts.code_model = cli.codegen.code_model;
        reloc_opts.hardening = cli.codegen.hardening;
        reloc_opts.stack_protect = cli.codegen.stack_protect;
        reloc_opts.fixed_regs = cli.codegen.fixed_regs;
        reloc_opts.elf_class = cli.codegen.elf_class;
        reloc_opts.keep_local_labels = cli.codegen.keep_local_labels;
        if cli.front.optimize {
            reloc_opts = reloc_opts.with_optimize();
        }
        if cli.codegen.dump_ssa {
            reloc_opts = reloc_opts.with_dump_ssa();
        }
        reloc_opts.output_kind = OutputKind::Relocatable;
        let stderr_is_tty = std::io::stderr().is_terminal();
        let multi_tu = source_count > 1;
        let cfg = CompileCfg {
            target: cli.target,
            reloc_opts,
            gnu: cli.front.gnu,
            gnu_dialect: cli.front.gnu_dialect,
            gnu89_inline: cli.front.gnu89_inline,
            strict_flex_arrays: cli.front.strict_flex_arrays,
            short_wchar: cli.front.short_wchar,
            char_signed: cli.front.char_signed,
            auto_var_init: cli.front.auto_var_init,
            nostdinc: cli.front.nostdinc,
            no_builtin: cli.front.no_builtin,
            no_builtin_fns: &cli.front.no_builtin_fns,
            optimize_flag: cli.front.optimize,
            export_all: false,
            show_includes: cli.front.show_includes,
            warn_dead_store: cli.front.warn_dead_store,
            multi_tu,
            quiet: cli.quiet,
            stderr_is_tty,
            defines: &cli.front.defines,
            undefines: &cli.front.undefines,
            include_paths: &cli.front.include_paths,
            quote_include_paths: &cli.front.quote_include_paths,
            system_include_paths: &cli.front.system_include_paths,
            own_header_roots: &cli.front.own_header_roots,
            force_includes: &cli.front.force_includes,
            deps: cli.deps.as_ref(),
            dep_output: cli.output_path.as_deref(),
            stdin_src: stdin_src.as_deref(),
        };
        if let Some(out) = cli.output_path.as_deref() {
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
            write_output(out, &bytes, cli.target, cli.quiet);
        } else {
            // Each worker writes its own `<stem>.o`, so write I/O runs in
            // the pool and each `info: wrote file` line stays grouped
            // with its source's diagnostics.
            let workers = worker_count(cli.jobs, source_count);
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
    if cli.mode == Mode::BuildArchive {
        if !archives.is_empty() || !cli.link.lib_names.is_empty() {
            eprintln!(
                "badc: --ar can't be combined with archive inputs / -l flags \
                 (the archive is an output, not a link target)"
            );
            std::process::exit(1);
        }
        let Some(out_path) = cli.output_path.clone() else {
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
            .with_debug_info(cli.codegen.emit_debug_info)
            .with_inline_cap(cli.codegen.inline_cap);
        reloc_opts.no_fp_regs = cli.codegen.no_fp_regs;
        reloc_opts.strict_align = cli.codegen.strict_align;
        reloc_opts.jump_tables = cli.codegen.jump_tables;
        reloc_opts.min_function_alignment = cli.codegen.min_function_alignment;
        reloc_opts.patchable_function_entry = cli.codegen.patchable_function_entry;
        reloc_opts.profiling = cli.codegen.profiling;
        reloc_opts.pic = cli.codegen.fpic;
        reloc_opts.pic_link = pic_link_default(cli.codegen.fno_pic, cli.codegen.code_model);
        reloc_opts.code_model = cli.codegen.code_model;
        reloc_opts.hardening = cli.codegen.hardening;
        reloc_opts.stack_protect = cli.codegen.stack_protect;
        reloc_opts.fixed_regs = cli.codegen.fixed_regs;
        reloc_opts.elf_class = cli.codegen.elf_class;
        reloc_opts.keep_local_labels = cli.codegen.keep_local_labels;
        if cli.front.optimize {
            reloc_opts = reloc_opts.with_optimize();
        }
        if cli.codegen.dump_ssa {
            reloc_opts = reloc_opts.with_dump_ssa();
        }
        reloc_opts.output_kind = OutputKind::Relocatable;
        let stderr_is_tty = std::io::stderr().is_terminal();
        let multi_tu = sources.len() > 1;
        let stdin_src = stdin_src_of(&sources);
        let cfg = CompileCfg {
            target: cli.target,
            reloc_opts,
            gnu: cli.front.gnu,
            gnu_dialect: cli.front.gnu_dialect,
            gnu89_inline: cli.front.gnu89_inline,
            strict_flex_arrays: cli.front.strict_flex_arrays,
            short_wchar: cli.front.short_wchar,
            char_signed: cli.front.char_signed,
            auto_var_init: cli.front.auto_var_init,
            nostdinc: cli.front.nostdinc,
            no_builtin: cli.front.no_builtin,
            no_builtin_fns: &cli.front.no_builtin_fns,
            optimize_flag: cli.front.optimize,
            export_all: false,
            show_includes: cli.front.show_includes,
            warn_dead_store: cli.front.warn_dead_store,
            multi_tu,
            quiet: cli.quiet,
            stderr_is_tty,
            defines: &cli.front.defines,
            undefines: &cli.front.undefines,
            include_paths: &cli.front.include_paths,
            quote_include_paths: &cli.front.quote_include_paths,
            system_include_paths: &cli.front.system_include_paths,
            own_header_roots: &cli.front.own_header_roots,
            force_includes: &cli.front.force_includes,
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
        let workers = worker_count(cli.jobs, sources.len());
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
                    unreadable_object_reason(&bytes, cli.target)
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
        write_output(&out_path, &blob, cli.target, cli.quiet);
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

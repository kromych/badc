use std::path::PathBuf;

use super::args::{Cli, Parsed, parse_args};
use super::deps::DepKind;
use super::diag::eprint_diagnostic;
use super::dump::{dump_bundled_headers, dump_native_link, print_predefined_symbols};
use super::inputs::{Inputs, StdinSource};
use super::native_link::link_image;
use super::objects::{build_archive, compile_objects};
use super::options::{Mode, SourceKind};
use super::paths::{
    badc_home, default_system_include_paths, install_embedded, source_tree_include,
};
use super::preprocess::{dump_dependencies, preprocess};
use super::script_link::run_script_link;
use super::vm::run_in_process;

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
    let mut inputs = Inputs::classify(&cli);

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
        if !inputs.sources.is_empty() {
            eprint_diagnostic(
                "badc: error: -T/--script links take .o/.a inputs; compile sources with -c first",
            );
            std::process::exit(1);
        }
        run_script_link(&cli, spath, inputs.link_inputs);
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
    inputs.resolve_libraries(&cli);
    inputs.fall_back_to_stdin();
    // The VM has no assembler: it walks SSA and never sees an assembled
    // section, so an asm unit would run as an empty program. Refuse it
    // rather than run nothing.
    if matches!(cli.mode, Mode::Jit | Mode::Interp)
        && let Some(src) = inputs.sources.iter().find(|s| SourceKind::of(s).is_asm())
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
            if let Some(src) = inputs.sources.iter().find(|s| !SourceKind::of(s).is_asm()) {
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
        && inputs.sources.len() > 1
    {
        eprint_diagnostic(format!(
            "badc: error: a single dependency file cannot describe {} translation \
             units (drop -MF / -Wp,-M[M]D or compile one source at a time)",
            inputs.sources.len()
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

    let stdin = StdinSource::default();

    if let Some(d) = &cli.deps
        && d.kind == DepKind::Only
    {
        return dump_dependencies(&cli, &inputs, &stdin, d);
    }
    if matches!(cli.mode, Mode::Jit | Mode::Interp) {
        run_in_process(&cli, &inputs, &stdin);
    }
    if cli.mode == Mode::DumpPp {
        return preprocess(&cli, &inputs, &stdin);
    }
    if (cli.mode == Mode::NativeExecutable || cli.mode == Mode::SharedLibrary) && !cli.compile_only
    {
        return link_image(&cli, inputs, &stdin);
    }
    if cli.compile_only {
        return compile_objects(&cli, &inputs, &stdin);
    }
    if cli.mode == Mode::BuildArchive {
        return build_archive(&cli, &inputs, &stdin);
    }

    // Every CLI mode is dispatched and returns above: --jit / --interp,
    // --list-symbols / --dump-headers / --dump-native-link, --dump-pp,
    // the native-link path (executable / shared library), `-c`, and
    // `--ar`. Reaching here means a mode was added without a handler.
    unreachable!("every CLI mode is handled and returns above");
}

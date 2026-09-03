use std::io::IsTerminal;

use badc::Compiler;

use super::args::Cli;
use super::deps::{DepKind, DepOptions, emit_deps};
use super::diag::{TuLog, eprint_diagnostic};
use super::inputs::{Inputs, StdinSource};
use super::options::SourceKind;

/// `-M` / `-MM` preprocess only: emit the rule and produce no
/// object, as gcc does.
pub(crate) fn dump_dependencies(
    cli: &Cli,
    inputs: &Inputs,
    stdin: &StdinSource,
    deps: &DepOptions,
) {
    let sources = &inputs.sources;
    let stderr_is_tty = std::io::stderr().is_terminal();
    let mut failed = false;
    for src in sources {
        let contents = if src == "-" {
            stdin.read()
        } else {
            match std::fs::read_to_string(src) {
                Ok(s) => s,
                Err(e) => {
                    eprint_diagnostic(format!("badc: error: cannot read `{src}`: {e}"));
                    std::process::exit(1);
                }
            }
        };
        let copts = cli
            .front
            .compile_options(src)
            .with_asm_source(SourceKind::of(src).is_asm())
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
                deps,
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
}

/// `--dump-pp` / `-E` preprocesses each source and exits: no link,
/// no codegen. `-o <path>` names the file the expansion goes to and
/// `-o -` names stdout, as in gcc and clang; without `-o` it goes to
/// stdout. A multi-source dump prefixes each unit with a
/// `--- <label> ---` marker on stderr so the preprocessed bytes on
/// stdout stay parseable, and takes no `-o`: one output stream
/// cannot hold several expansions, which is why gcc and clang refuse
/// the combination too.
pub(crate) fn preprocess(cli: &Cli, inputs: &Inputs, stdin: &StdinSource) {
    let sources = &inputs.sources;
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
    for src_path in sources {
        let (label, contents) = if src_path == "-" {
            ("-".to_string(), stdin.read())
        } else {
            match std::fs::read_to_string(src_path) {
                Ok(s) => (src_path.clone(), s),
                Err(e) => {
                    eprint_diagnostic(format!("badc: error: cannot read `{src_path}`: {e}"));
                    std::process::exit(1);
                }
            }
        };
        let opts = cli
            .front
            .compile_options(&label)
            .with_optimize(cli.front.optimize)
            .with_asm_source(SourceKind::of(src_path).is_asm())
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
}

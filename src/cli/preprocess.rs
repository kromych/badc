use std::io::IsTerminal;

use badc::Compiler;

use super::args::Cli;
use super::deps::{DepKind, DepOptions, emit_deps};
use super::diag::{TuLog, eprint_diagnostic, rendered, report_diagnostics};
use super::inputs::{Inputs, StdinSource};

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
            .with_asm_source(cli.front.source_kind(src).is_asm())
            .with_track_includes(true)
            .with_elf_class(cli.codegen.elf_class)
            .with_no_fp_regs(cli.codegen.no_fp_regs)
            .with_x86_features(cli.codegen.x86_features)
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
        // A failed pass's error carries the diagnostics reported before it,
        // which the compiler's own list holds as well.
        if compiler.preprocess_error().is_none() {
            for d in compiler.diagnostics() {
                log.raw(rendered(d, stderr_is_tty));
            }
        }
        // An unresolved `#include` leaves the prerequisite list
        // incomplete, so report it and write nothing, as gcc does. Any
        // other error (`#error`) leaves the list whole: gcc and clang write
        // it and fail.
        let unresolved = |r: &badc::IncludeRecord| r.status == badc::IncludeStatus::Missing;
        let missing = compiler.include_records().iter().any(unresolved);
        let res = match compiler.preprocess_error() {
            Some(e) if missing => {
                log.error(stderr_is_tty, "", e);
                Err(())
            }
            Some(e) => {
                log.error(stderr_is_tty, "", e);
                let written = emit_deps(
                    src,
                    compiler.include_records(),
                    deps,
                    cli.output_path.as_deref(),
                    &mut log,
                    stderr_is_tty,
                );
                written.and(Err(()))
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
/// `text` without its GNU line markers (`# N "file" [flags]`), as gcc's
/// `-E -P` prints it.
fn without_line_markers(text: &str) -> String {
    let is_marker = |line: &str| {
        let Some(rest) = line.strip_prefix("# ") else {
            return false;
        };
        let digits = rest.bytes().take_while(u8::is_ascii_digit).count();
        digits > 0 && rest[digits..].starts_with(" \"")
    };
    text.split_inclusive('\n')
        .filter(|l| !is_marker(l))
        .collect()
}

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
    let mut failed = false;
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
            .with_asm_source(cli.front.source_kind(src_path).is_asm())
            .with_track_includes(dump_deps.is_some() || cli.front.show_includes)
            .with_keep_pragmas(true)
            .with_elf_class(cli.codegen.elf_class)
            .with_no_fp_regs(cli.codegen.no_fp_regs)
            .with_x86_features(cli.codegen.x86_features)
            .with_code_model(cli.codegen.code_model);
        let dump_macros = cli.front.dump_macros;
        let preprocessed = Compiler::preprocess_unit(contents, cli.target, opts, dump_macros);
        match preprocessed {
            Ok(unit) => {
                if multi_tu {
                    eprintln!("--- {label} ---");
                }
                // The diagnostics go to stderr as a compile prints them, and
                // one at the error level fails the run once the text is out.
                let mut log = TuLog::default();
                failed |= report_diagnostics(&mut log, stderr_is_tty, &unit.diagnostics).is_err();
                // gcc's `-H` trace, as a compile prints it.
                if cli.front.show_includes {
                    let opened = unit.include_records.iter();
                    for r in opened.filter(|r| r.status != badc::IncludeStatus::Embedded) {
                        log.raw(r.trace_line());
                    }
                }
                log.flush();
                let (s, records) = if dump_macros {
                    let lines = unit.macros.iter().map(|l| format!("{l}\n"));
                    (lines.collect(), Vec::new())
                } else {
                    (unit.text, unit.include_records)
                };
                let s = if cli.front.no_line_markers {
                    without_line_markers(&s)
                } else {
                    s
                };
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
                    None => out!("{s}"),
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
                    failed |= res.is_err();
                }
            }
            Err(e) => {
                eprint_diagnostic(e);
                std::process::exit(1);
            }
        }
    }
    if failed {
        std::process::exit(1);
    }
}

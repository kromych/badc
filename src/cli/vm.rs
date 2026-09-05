use std::io::IsTerminal;

use badc::{Compiler, NativeOptions, Vm, jit_run_with_options};

use super::args::Cli;
use super::diag::{colorize_diagnostic, eprint_diagnostic, eprint_error, rendered};
use super::inputs::{Inputs, StdinSource};
use super::options::Mode;

/// `--jit` / `--interp` run one translation unit in-process. There
/// is no link step: the first `.c` is the unit and must define
/// `main` and resolve every symbol it references on its own.
pub(crate) fn run_in_process(cli: &Cli, inputs: &Inputs, stdin: &StdinSource) -> ! {
    let Inputs {
        sources,
        objects,
        archives,
        prog_args_start,
        ..
    } = inputs;
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
        stdin.read()
    } else {
        match std::fs::read_to_string(&src_path) {
            Ok(s) => s,
            Err(e) => {
                eprint_diagnostic(format!("badc: error: cannot read `{src_path}`: {e}"));
                std::process::exit(1);
            }
        }
    };
    let copts = cli
        .front
        .compile_options(&src_path)
        .with_optimize(cli.front.optimize)
        .with_track_includes(cli.front.show_includes);
    let compiler = Compiler::with_options(contents, cli.target, copts);
    if cli.front.show_includes {
        for line in compiler.include_trace() {
            eprintln!("{line}");
        }
    }
    let program = match compiler.compile() {
        Ok(p) => p,
        Err(e) => {
            eprint_error("", &e);
            std::process::exit(1);
        }
    };
    let stderr_is_tty = std::io::stderr().is_terminal();
    for line in &program.notes {
        eprintln!("{}", colorize_diagnostic(line, stderr_is_tty));
    }
    for d in &program.warnings {
        eprintln!("{}", rendered(d, stderr_is_tty));
    }
    if program
        .warnings
        .iter()
        .any(|d| d.level == badc::diag::Level::Error)
    {
        eprint_diagnostic("badc: error: warnings treated as errors");
        std::process::exit(1);
    }
    // argv[0] is the unit path; argv[1..] are every following
    // input (extra `.c` paths the hosted program opens itself)
    // plus any trailing non-input tokens.
    let mut c_args: Vec<String> = sources.clone();
    if *prog_args_start < cli.positional.len() {
        c_args.extend(cli.positional[*prog_args_start..].iter().cloned());
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

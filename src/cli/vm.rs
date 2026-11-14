use std::io::IsTerminal;

use badc::{Compiler, NativeOptions, OnDemandSources, Vm, jit_run_with_sources};

use super::args::Cli;
use super::diag::{colorize_diagnostic, eprint_diagnostic, eprint_error, rendered};
use super::inputs::{Inputs, StdinSource};
use super::options::Mode;

/// `__BADC_JIT__` / `__BADC_INTERP__`, defined to 1 for every unit the run
/// compiles; ahead of the `-D` list, so `-D` and `-U` override it.
fn with_run_macro(cli: &Cli, opts: badc::CompileOptions) -> badc::CompileOptions {
    let name = match cli.mode {
        Mode::Jit => "__BADC_JIT__",
        _ => "__BADC_INTERP__",
    };
    let mut defines = vec![(name.to_string(), "1".to_string())];
    defines.extend(opts.defines.iter().cloned());
    opts.with_defines(defines)
}

/// `--jit` / `--interp` run one translation unit in-process: the first
/// `.c` is the unit and must define `main`; both join the on-demand
/// sources to it. Either exits with the program's status.
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
    let copts = with_run_macro(cli, cli.front.compile_options(&src_path))
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
        // The JIT lowers for the host, which the parser holds `cli.target`
        // to.
        let mut jit_opts = NativeOptions::new()
            .with_inline_cap(cli.codegen.inline_cap)
            .with_diag(cli.front.diag.clone());
        jit_opts.fixed_regs = cli.codegen.fixed_regs;
        jit_opts.frame_larger_than = cli.codegen.frame_larger_than;
        if cli.front.optimize {
            jit_opts = jit_opts.with_optimize();
        }
        let mut report = |d: &badc::diag::Diagnostic| {
            eprintln!("{}", rendered(d, stderr_is_tty));
        };
        let front = with_run_macro(
            cli,
            super::native_link::embedded_compile_options(cli, "on-demand.c"),
        );
        let sources = OnDemandSources::new(badc::Target::host(), front);
        match jit_run_with_sources(&program, &c_args, jit_opts, &sources, &mut report) {
            Ok(code) => std::process::exit(code),
            Err(e) => {
                eprint_diagnostic(e);
                std::process::exit(1);
            }
        }
    }
    let front = with_run_macro(
        cli,
        super::native_link::embedded_compile_options(cli, "on-demand.c"),
    );
    let sources = OnDemandSources::new(program.target, front);
    let mut vm = Vm::with_sources(program, badc::StdHost::default(), &sources).with_args(c_args);
    if cli.track_pointers {
        vm = vm.with_pointer_tracking();
    }
    if cli.trace {
        vm = vm.with_trace();
    }
    match vm.run() {
        Ok(res) => {
            // The program's status is the process's, as a native image's
            // is; its output is what it wrote, flushed before the exit.
            use std::io::Write;
            let _ = std::io::stdout().flush();
            let _ = std::io::stderr().flush();
            std::process::exit(res as i32);
        }
        Err(e) => {
            eprint_diagnostic(e);
            std::process::exit(1);
        }
    }
}

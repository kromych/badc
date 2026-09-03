use std::io::IsTerminal;

use badc::{Compiler, NativeOptions, Vm, jit_run_with_options};

use super::args::Cli;
use super::diag::{colorize_diagnostic, eprint_diagnostic};
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

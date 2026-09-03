use std::io::IsTerminal;

use super::args::Cli;
use super::compile::{CompileCfg, compile_object_tu, compile_units, worker_count};
use super::diag::eprint_diagnostic;
use super::inputs::{
    Inputs, StdinSource, native_defined_globals, native_defined_globals_logged,
    unreadable_object_reason,
};
use super::output::write_output;

/// `-c` / `--compile-only`: compile each `.c` source to a native
/// ELF64 ET_REL object on disk and exit. Archive / `-l` inputs
/// aren't meaningful here -- the caller is asking for the per-
/// source object emit, not a link.
pub(crate) fn compile_objects(cli: &Cli, inputs: &Inputs, stdin: &StdinSource) {
    let Inputs {
        sources, archives, ..
    } = inputs;
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
    let stdin_src = stdin.for_sources(sources);
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
        compile_units(sources, workers, |_, src| {
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
}

/// `--ar` mode: bundle each `.c` input (compiled to native
/// ELF64 ET_REL) plus any passed-in `.o` into a single
/// SysV `ar` archive named by `-o`. Member bytes are the
/// exact same blob `-c` would have written to disk; the
/// SysV symbol index lists every `STB_GLOBAL`-defined name
/// so the linker's archive pull-in can resolve undefined
/// references without re-parsing each member.
pub(crate) fn build_archive(cli: &Cli, inputs: &Inputs, stdin: &StdinSource) {
    let Inputs {
        sources,
        objects,
        archives,
        ..
    } = inputs;
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
    let stdin_src = stdin.for_sources(sources);
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
    let compiled = compile_units(sources, workers, |_, src| {
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

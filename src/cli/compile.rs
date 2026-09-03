use badc::{NativeOptions, Target};

use super::deps::{DepOptions, emit_deps};
use super::diag::TuLog;
use super::options::SourceKind;

/// Native-stack reservation shared by the driver thread and every
/// `--jobs` compile worker. The parser caps nesting at `MAX_NEST_DEPTH`
/// (512); at a measured ~33 KiB/level a debug build's deepest
/// diagnosable unit needs ~24 MiB, so 64 MiB holds a cross-ISA margin.
/// A worker must match the driver, else a deep unit overflows only
/// under `--jobs`; the reservation is lazily committed, so resident
/// stack stays at what the compile touches.
pub(crate) const DRIVER_STACK_SIZE: usize = 64 * 1024 * 1024;

/// The `-D` list one translation unit preprocesses under. gcc predefines
/// `__ASSEMBLER__` for a `.S`, and kernel headers gate their C-only content
/// on it. It goes ahead of the command-line list so `-U__ASSEMBLER__` and an
/// explicit `-D__ASSEMBLER__=<v>` both still win.
pub(crate) fn tu_defines(src_path: &str, defines: &[(String, String)]) -> Vec<(String, String)> {
    if !SourceKind::of(src_path).is_asm() {
        return defines.to_vec();
    }
    let mut out = Vec::with_capacity(defines.len() + 1);
    out.push(("__ASSEMBLER__".to_string(), "1".to_string()));
    out.extend_from_slice(defines);
    out
}

/// Worker-thread count for `count` independent units: `2*N` capped at
/// the unit count, where N is `--jobs` or, absent it, the host's
/// available parallelism. C99 leaves build parallelism to the
/// implementation.
pub(crate) fn worker_count(jobs: Option<usize>, count: usize) -> usize {
    let n = jobs.unwrap_or_else(|| {
        std::thread::available_parallelism()
            .map(|p| p.get())
            .unwrap_or(1)
    });
    n.saturating_mul(2).min(count).max(1)
}

/// Read-only per-invocation compile inputs shared across `--jobs`
/// workers by reference. Every field is fixed during argument parsing
/// and never mutated during compilation.
pub(crate) struct CompileCfg<'a> {
    pub(crate) target: Target,
    pub(crate) reloc_opts: NativeOptions,
    pub(crate) gnu: bool,
    pub(crate) gnu_dialect: bool,
    pub(crate) gnu89_inline: bool,
    pub(crate) strict_flex_arrays: u8,
    pub(crate) short_wchar: bool,
    pub(crate) char_signed: Option<bool>,
    pub(crate) auto_var_init: badc::AutoVarInit,
    pub(crate) nostdinc: bool,
    pub(crate) no_builtin: bool,
    pub(crate) no_builtin_fns: &'a [String],
    pub(crate) optimize_flag: bool,
    pub(crate) export_all: bool,
    pub(crate) show_includes: bool,
    pub(crate) warn_dead_store: bool,
    pub(crate) multi_tu: bool,
    pub(crate) quiet: bool,
    pub(crate) stderr_is_tty: bool,
    pub(crate) defines: &'a [(String, String)],
    pub(crate) undefines: &'a [String],
    pub(crate) include_paths: &'a [String],
    pub(crate) quote_include_paths: &'a [String],
    pub(crate) system_include_paths: &'a [String],
    pub(crate) own_header_roots: &'a [String],
    pub(crate) force_includes: &'a [String],
    /// `-MD` / `-MMD` request, `None` when no dependency output was
    /// asked for. Each unit writes its own file.
    pub(crate) deps: Option<&'a DepOptions>,
    /// `-o`, which names the dependency file and its rule target.
    pub(crate) dep_output: Option<&'a std::path::Path>,
    /// Pre-read stdin bytes for a `-` source; `None` when no input is
    /// stdin. Keeps a worker off the process stdin stream.
    pub(crate) stdin_src: Option<&'a str>,
}

/// One compiled native-link translation unit: the parsed object plus
/// the entry / subsystem / auto-include facts the driver folds across
/// units in source order.
pub(crate) struct NativeTu {
    pub(crate) obj: badc::NativeObject,
    pub(crate) entry: Option<String>,
    pub(crate) subsystem: Option<badc::Subsystem>,
    pub(crate) auto_includes: Vec<String>,
}

/// Compile `units` and return each payload in unit order. `compile`
/// yields a per-unit log and either a payload or an error marker (its
/// message already in the log). `workers <= 1` runs inline and stops at
/// the first failing unit, matching the sequential driver exactly.
/// `workers > 1` runs a bounded pool -- each worker on the driver's
/// stack reservation -- pulling units off a shared cursor and replaying
/// logs in unit order, so the first failure in source order fails the
/// build with identical stderr regardless of scheduling.
pub(crate) fn compile_units<U, P>(
    units: &[U],
    workers: usize,
    compile: impl Fn(usize, &U) -> (TuLog, Result<P, ()>) + Sync,
) -> Vec<P>
where
    U: Sync,
    P: Send,
{
    if workers <= 1 {
        let mut out = Vec::with_capacity(units.len());
        for (i, u) in units.iter().enumerate() {
            let (log, res) = compile(i, u);
            log.flush();
            match res {
                Ok(p) => out.push(p),
                Err(()) => std::process::exit(1),
            }
        }
        return out;
    }
    use std::sync::atomic::{AtomicBool, AtomicUsize, Ordering};
    // Workers pull units off a monotonic cursor. `failed` stops new
    // pickups once any unit errors so a doomed build stops early; the
    // cursor guarantees a filled slot implies every lower slot was
    // handed out (and thus fills), so the first error in source order is
    // still the one reported.
    let next = AtomicUsize::new(0);
    let failed = AtomicBool::new(false);
    let (tx, rx) = std::sync::mpsc::channel::<(usize, TuLog, Result<P, ()>)>();
    let mut slots: Vec<Option<(TuLog, Result<P, ()>)>> = (0..units.len()).map(|_| None).collect();
    std::thread::scope(|scope| {
        for _ in 0..workers {
            let tx = tx.clone();
            let next = &next;
            let failed = &failed;
            let compile = &compile;
            std::thread::Builder::new()
                .stack_size(DRIVER_STACK_SIZE)
                .spawn_scoped(scope, move || {
                    while !failed.load(Ordering::Relaxed) {
                        let i = next.fetch_add(1, Ordering::Relaxed);
                        if i >= units.len() {
                            break;
                        }
                        let (log, res) = compile(i, &units[i]);
                        let is_err = res.is_err();
                        if tx.send((i, log, res)).is_err() {
                            break;
                        }
                        if is_err {
                            failed.store(true, Ordering::Relaxed);
                        }
                    }
                })
                .expect("spawn compile worker");
        }
        drop(tx);
        for (i, log, res) in rx {
            slots[i] = Some((log, res));
        }
    });
    // Replay logs in source order; exit at the first failing unit. A
    // `None` occurs only past that unit (workers stopped early), so it
    // is never reached before the exit.
    let mut out = Vec::with_capacity(units.len());
    for slot in slots {
        match slot {
            Some((log, res)) => {
                log.flush();
                match res {
                    Ok(p) => out.push(p),
                    Err(()) => std::process::exit(1),
                }
            }
            None => break,
        }
    }
    out
}

/// Read a translation unit's source: the pre-read stdin bytes for `-`,
/// else the file. Records a read error in `log`.
pub(crate) fn read_tu_source(
    src_path: &str,
    cfg: &CompileCfg,
    log: &mut TuLog,
) -> Result<String, ()> {
    if src_path == "-" {
        return match cfg.stdin_src {
            Some(s) => Ok(s.to_string()),
            None => {
                log.diag(cfg.stderr_is_tty, "badc: error: cannot read `-`: no stdin");
                Err(())
            }
        };
    }
    match std::fs::read_to_string(src_path) {
        Ok(b) => Ok(b),
        Err(e) => {
            log.diag(
                cfg.stderr_is_tty,
                format!("badc: error: cannot read `{src_path}`: {e}"),
            );
            Err(())
        }
    }
}

/// The front-end options one translation unit compiles (or preprocesses)
/// under. `implicit_externs` applies to the C front end only.
pub(crate) fn tu_compile_options(
    src_path: &str,
    implicit_externs: &[String],
    cfg: &CompileCfg,
) -> badc::CompileOptions {
    badc::CompileOptions::default()
        .with_gnu(cfg.gnu)
        .with_gnu89_inline(cfg.gnu89_inline)
        .with_strict_flex_arrays(cfg.strict_flex_arrays)
        .with_short_wchar(cfg.short_wchar)
        .with_char_signed(cfg.char_signed)
        .with_auto_var_init(cfg.auto_var_init)
        .with_nostdinc(cfg.nostdinc)
        .with_no_builtin(cfg.no_builtin)
        .with_no_builtin_fns(cfg.no_builtin_fns.to_vec())
        .with_gnu_dialect(cfg.gnu_dialect)
        .with_asm_source(SourceKind::of(src_path).is_asm())
        .with_defines(tu_defines(src_path, cfg.defines))
        .with_undefines(cfg.undefines.to_vec())
        .with_include_paths(cfg.include_paths.to_vec())
        .with_quote_include_paths(cfg.quote_include_paths.to_vec())
        .with_system_include_paths(cfg.system_include_paths.to_vec())
        .with_own_header_roots(cfg.own_header_roots.to_vec())
        .with_force_includes(cfg.force_includes.to_vec())
        .with_source_label(src_path.to_string())
        .with_track_includes(cfg.show_includes || cfg.deps.is_some())
        .with_warn_dead_store(cfg.warn_dead_store)
        .with_optimize(cfg.optimize_flag)
        .with_export_all_functions(cfg.export_all)
        .with_implicit_extern_fns(implicit_externs.to_vec())
        .with_no_entry_point(true)
        .with_elf_class(cfg.reloc_opts.elf_class)
        .with_code_model(cfg.reloc_opts.code_model)
}

/// GNU line markers (`# <line> "<file>" [flags]`) blanked in place. gas reads
/// them as line directives rather than as content, and on AArch64 `#` is not
/// a comment introducer, so they cannot be left for the comment stripper.
/// Blanking rather than deleting keeps every statement's line number.
pub(crate) fn blank_line_markers(text: &str) -> String {
    let mut out = String::with_capacity(text.len());
    for (i, line) in text.split('\n').enumerate() {
        if i > 0 {
            out.push('\n');
        }
        let t = line.trim_start();
        let is_marker = t.strip_prefix('#').is_some_and(|r| {
            let r = r.trim_start();
            r.starts_with(|c: char| c.is_ascii_digit())
                || r.strip_prefix("line")
                    .is_some_and(|r| r.starts_with(char::is_whitespace))
        });
        if !is_marker {
            out.push_str(line);
        }
    }
    out
}

/// Assemble one `.s` / `.S` source to a `Program` the object writers consume,
/// writing its dependency rule on the way. `.S` runs through the preprocessor
/// first, as gcc's driver does; `.s` is taken verbatim.
pub(crate) fn assemble_tu(
    src_path: &str,
    cfg: &CompileCfg,
    log: &mut TuLog,
) -> Result<badc::Program, ()> {
    let src_bytes = read_tu_source(src_path, cfg, log)?;
    let copts = tu_compile_options(src_path, &[], cfg);
    let text = if SourceKind::of(src_path) == (SourceKind::Asm { preprocess: true }) {
        let (text, records) =
            match badc::Compiler::preprocess_tracked(src_bytes, cfg.target, copts.clone()) {
                Ok(r) => r,
                Err(e) => {
                    log.diag(cfg.stderr_is_tty, e);
                    return Err(());
                }
            };
        if let Some(d) = cfg.deps
            && emit_deps(
                src_path,
                &records,
                d,
                cfg.dep_output,
                log,
                cfg.stderr_is_tty,
            )
            .is_err()
        {
            return Err(());
        }
        blank_line_markers(&text)
    } else {
        // A `.s` unit opens no header, so its rule names only the source.
        if let Some(d) = cfg.deps
            && emit_deps(src_path, &[], d, cfg.dep_output, log, cfg.stderr_is_tty).is_err()
        {
            return Err(());
        }
        src_bytes
    };
    badc::Compiler::assemble(&text, cfg.target, copts).map_err(|e| {
        log.diag(cfg.stderr_is_tty, e);
    })
}

/// Produce one translation unit's `Program` and write its dependency rule:
/// a `.c` source through the C front end, a `.s` / `.S` source through the
/// assembler.
pub(crate) fn translate_tu(
    src_path: &str,
    implicit_externs: &[String],
    cfg: &CompileCfg,
    log: &mut TuLog,
) -> Result<badc::Program, ()> {
    if SourceKind::of(src_path).is_asm() {
        return assemble_tu(src_path, cfg, log);
    }
    let src_bytes = read_tu_source(src_path, cfg, log)?;
    let copts = tu_compile_options(src_path, implicit_externs, cfg);
    let compiler = badc::Compiler::with_options(src_bytes, cfg.target, copts);
    if cfg.show_includes {
        for line in compiler.include_trace() {
            log.raw(line);
        }
    }
    if let Some(d) = cfg.deps
        && compiler.preprocess_error().is_none()
        && emit_deps(
            src_path,
            compiler.include_records(),
            d,
            cfg.dep_output,
            log,
            cfg.stderr_is_tty,
        )
        .is_err()
    {
        return Err(());
    }
    let program = match compiler.compile() {
        Ok(p) => p,
        Err(e) => {
            log.diag(cfg.stderr_is_tty, e);
            return Err(());
        }
    };
    for w in &program.warnings {
        log.diag(cfg.stderr_is_tty, w);
    }
    Ok(program)
}

/// Compile one `.c` source to an in-memory relocatable object for the
/// native-link path, capturing every diagnostic in the returned log.
/// `implicit_externs` is empty on the first pass; the auto-include
/// retry passes the names to rebind (and stays quiet about "compiling").
pub(crate) fn compile_native_tu(
    src_path: &str,
    implicit_externs: &[String],
    cfg: &CompileCfg,
) -> (TuLog, Result<NativeTu, ()>) {
    let mut log = TuLog::default();
    if cfg.multi_tu && !cfg.quiet && implicit_externs.is_empty() {
        log.diag(cfg.stderr_is_tty, format!("info: compiling {src_path}"));
    }
    let program = match translate_tu(src_path, implicit_externs, cfg, &mut log) {
        Ok(p) => p,
        Err(()) => return (log, Err(())),
    };
    // Prefer the literal `#pragma entrypoint(<name>)` over the
    // in-TU-resolved `entry_name`: in a multi-TU freestanding link the
    // named entry is often defined in a different TU, so `entry_name` is
    // `None` here while the pragma still fixes the image entry.
    let entry = program
        .entry_pragma
        .clone()
        .or_else(|| program.entry_name.clone());
    let subsystem = program.subsystem;
    let auto_includes = program.auto_includes.clone();
    match badc::emit_native_with_options_owned(program, cfg.target, cfg.reloc_opts) {
        Ok(bytes) => match badc::parse_native_elf(&bytes) {
            Ok(obj) => (
                log,
                Ok(NativeTu {
                    obj,
                    entry,
                    subsystem,
                    auto_includes,
                }),
            ),
            Err(e) => {
                log.diag(cfg.stderr_is_tty, format!("badc: {src_path}: {e}"));
                (log, Err(()))
            }
        },
        Err(e) => {
            log.diag(cfg.stderr_is_tty, e);
            (log, Err(()))
        }
    }
}

/// Translate one source to relocatable object bytes for the `-c` /
/// `--ar` paths, capturing every diagnostic in the returned log.
pub(crate) fn compile_object_tu(src_path: &str, cfg: &CompileCfg) -> (TuLog, Result<Vec<u8>, ()>) {
    let mut log = TuLog::default();
    if cfg.multi_tu && !cfg.quiet {
        log.diag(cfg.stderr_is_tty, format!("info: compiling {src_path}"));
    }
    let program = match translate_tu(src_path, &[], cfg, &mut log) {
        Ok(p) => p,
        Err(()) => return (log, Err(())),
    };
    warn_dropped_link_pragmas(&program, src_path, &mut log, cfg.stderr_is_tty);
    match badc::emit_native_with_options_owned(program, cfg.target, cfg.reloc_opts) {
        Ok(bytes) => (log, Ok(bytes)),
        Err(e) => {
            log.diag(cfg.stderr_is_tty, e);
            (log, Err(()))
        }
    }
}

/// `#pragma entrypoint` / `#pragma subsystem` ride the in-memory
/// `Program` of the invocation that links; an ET_REL object carries
/// neither. Warn when a relocatable emit drops them so the TU is
/// recompiled in the link invocation instead of silently producing a
/// console-subsystem / default-entry image.
pub(crate) fn warn_dropped_link_pragmas(
    program: &badc::Program,
    src_path: &str,
    log: &mut TuLog,
    tty: bool,
) {
    let mut dropped: Vec<&str> = Vec::new();
    if program.entry_pragma.is_some() {
        dropped.push("entrypoint");
    }
    if program.subsystem.is_some() {
        dropped.push("subsystem");
    }
    for p in dropped {
        log.diag(
            tty,
            format!(
                "{src_path}: warning: `#pragma {p}(...)` is not carried by an object \
                 file; compile this source in the link invocation for it to take effect"
            ),
        );
    }
}

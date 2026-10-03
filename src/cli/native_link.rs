use std::io::IsTerminal;

use badc::{Compiler, OutputKind};

use super::args::Cli;
use super::compile::{CompileCfg, compile_native_tu, compile_units, worker_count};
use super::diag::{eprint_diagnostic, eprint_error, rendered};

use super::inputs::{
    Inputs, LinkInput, StdinSource, fat_slice_for_target, machine_label, target_machine,
    unreadable_object_reason,
};
use super::options::Mode;
use super::output::{post_write_native, write_output};
use super::paths::default_output_path;
use super::stats::LinkStats;

/// The native-link path produces every executable and shared
/// library on every target: ELF for Linux, the MergedNative-to-
/// Build synthesizer for Mach-O / PE.
///   .c sources -> Compiler::compile() -> ET_REL bytes
///                                     -> parse_native_elf
///   .o inputs  -> parse_native_elf
///   .a inputs  -> read_archive -> per-member parse_native_elf
/// All collected NativeObjects feed link_native_objects, the
/// per-arch PLT pass, and write_native_image_from_merged. The
/// image carries DWARF (subprogram + variable + type DIEs ride
/// the merged per-`.o` `.debug_info`; `.debug_frame` regenerates),
/// every input's `.eh_frame` as one table under `PT_GNU_EH_FRAME`,
/// variadic libc imports, `#pragma` exports, and `_Thread_local`
/// storage in each format's native shape: ELF PT_TLS, the PE TLS
/// directory + `_tls_index`, the Mach-O TLV descriptors. Mach-O
/// auto-codesigning lives in `post_write_native`. `--jit` / `--interp`
/// and `-c` / `--ar` take their own paths.
pub(crate) fn link_image(cli: &Cli, inputs: Inputs, stdin: &StdinSource) {
    let Inputs {
        sources,
        ordered,
        mut shared_libs,
        mut target_libc,
        ..
    } = inputs;
    super::driver::refuse_link_options(cli, false);
    let mut stats = LinkStats::new();

    // These objects are linked into an image below. A position-
    // independent one takes its data relocations at load time (ELF
    // ET_DYN, PE base relocations, Mach-O dyld rebases), so a relocated
    // `const` cannot ride the read-only prefix and must not cost the
    // unit's pure `const` objects their place in it. A placed ELF image
    // resolves every address at link time, so its sources compile as a
    // static link's `-fno-pic -c` objects do.
    let placed = cli.mode == Mode::NativeExecutable
        && cli.exec_form().placed()
        && cli.target.binary_format() == badc::BinaryFormat::Elf;
    let reloc_opts = cli
        .codegen
        .relocatable_options(cli.front.optimize, !placed, &cli.front.diag);
    // `.c` -> in-memory native ELF64 ET_REL: each source compiles
    // straight to ET_REL bytes that `parse_native_elf` reads back, so no
    // intermediate `.o` is written to disk.
    let stdin_src = stdin.for_sources(&sources);
    let cfg = CompileCfg::new(cli, reloc_opts.clone(), &sources, stdin_src.as_deref());
    let mut embedded = EmbeddedSources {
        cli,
        reloc_opts,
        pool_loaded: false,
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
    // resolution and object order stay scheduling-independent. A
    // multi-source build prints `info: compiling <path>` per unit, the
    // resolved `#include` trace under `-H`, and the compiler's warnings
    // to stderr, as the JIT / interp paths do.
    let workers = worker_count(cli.jobs, sources.len());
    let tus = compile_units(&sources, workers, |_, src| {
        compile_native_tu(src, &[], &cfg)
    });
    let mut source_objs: Vec<Option<badc::NativeObject>> = Vec::with_capacity(sources.len());
    for (i, mut tu) in tus.into_iter().enumerate() {
        if entry_override.is_none() {
            entry_override = tu.entry;
        }
        if subsystem_override.is_none() {
            subsystem_override = tu.subsystem;
        }
        source_auto_includes.push(tu.auto_includes);
        tu.obj.source = sources[i].clone();
        source_objs.push(Some(tu.obj));
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
    // gcc's order: the startup runtime where crt1.o stands, then the
    // inputs as the command line gives them.
    let mut runtime = Vec::new();
    embedded.push_runtime(entry_override.as_deref(), subsystem_override, &mut runtime);
    let mut slots = vec![Slot::Fixed(runtime)];
    stats.mark("runtime");
    let mut source_slots = vec![0; sources.len()];
    for input in ordered {
        slots.push(match input {
            LinkInput::Source(i) => {
                source_slots[i] = slots.len();
                Slot::Fixed(source_objs[i].take().into_iter().collect())
            }
            LinkInput::Object(path) => Slot::Fixed(vec![read_object_input(&path, cli.target)]),
            LinkInput::Archive { path, whole } => {
                let members = read_archive_members(&path, cli.target);
                if whole {
                    Slot::Fixed(members)
                } else {
                    Slot::lazy(members)
                }
            }
            LinkInput::Shared(i) => Slot::Shared(i),
            LinkInput::Group(open) => Slot::Group(open),
        });
    }
    stats.mark("parse");
    rebind_auto_includes(
        &cfg,
        &mut embedded,
        &mut slots,
        &source_slots,
        &source_auto_includes,
        &sources,
        &mut stats,
    );
    let (native_objs, archive_inclusions) = select_archive_members(
        &mut embedded,
        slots,
        &mut shared_libs,
        &mut target_libc,
        freestanding_entry.as_deref(),
        &mut stats,
    );
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
    emit_image(
        cli,
        ImageInputs {
            objs: &native_objs,
            shared_libs: &shared_libs,
            inclusions: &archive_inclusions,
            entry: entry_override.as_deref(),
            subsystem: subsystem_override,
            first_source: sources.first().map(|s| s.as_str()).unwrap_or("a"),
        },
        &mut stats,
    );
}

/// The sources the driver compiles itself: the startup runtime, and the
/// compiler-runtime + libc pool a link pulls only when its own inputs
/// leave symbols undefined.
struct EmbeddedSources<'a> {
    cli: &'a Cli,
    reloc_opts: badc::NativeOptions,
    /// The pool is compiled at most once per link.
    pool_loaded: bool,
}

impl EmbeddedSources<'_> {
    /// Compile one embedded source to relocatable bytes: the same
    /// compile and emit chain as a file, with no filesystem read.
    /// `dump` clears `--dump-ssa` for a speculative compile.
    fn compile(
        &self,
        label: &str,
        src: String,
        extra: &[(&str, &str)],
        dump: bool,
    ) -> Result<Vec<u8>, badc::C5Error> {
        let cli = self.cli;
        let reloc_opts = self.reloc_opts.clone();
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
        let mut copts = cli
            .front
            .compile_options(label)
            .with_defines(copts_defines)
            .with_no_entry_point(true);
        // A bundled source resolves `#include "..."` inside the bundled
        // set, not through the user's `-iquote` paths.
        copts.quote_include_paths.clear();
        let program = Compiler::with_options(src, cli.target, copts).compile()?;
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
        // Nor the `-W` family: these sources are badc's own, so a
        // report about one names no code the user wrote. The front
        // end's warnings on them are dropped for the same reason.
        opts.diag = badc::diag::Config::new();
        badc::emit_native_with_options_owned(program, cli.target, opts)
    }

    /// Compile the startup runtime for this image and append its
    /// objects. The runtime source compiles to nothing unless one of
    /// the gate macros below is set.
    fn push_runtime(
        &self,
        entry_override: Option<&str>,
        subsystem_override: Option<badc::Subsystem>,
        objs: &mut Vec<badc::NativeObject>,
    ) {
        // The runtime's CRT section (the C99 snprintf / vsnprintf
        // definitions on Windows) links into any image that may
        // import the user-mode C library -- hosted executables and
        // shared libraries, but not passthrough-entry subsystems
        // (native / EFI) or freestanding images.
        let links_crt = !self.cli.freestanding
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
        let emits_start_stub = self.cli.mode != Mode::SharedLibrary && links_crt;
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
            runtime_defines.push(("__BADC_ENTRY__", entry_override.unwrap_or("main")));
            // The entry shape follows the entry symbol, not the PE
            // subsystem (set separately on the optional header): a
            // GUI-subsystem program with a plain `main` still receives
            // argc/argv. WinMain / wWinMain take the (hInstance, prev,
            // cmdline, nShow) shape; wmain / wWinMain take the wide form.
            match entry_override {
                Some("WinMain") => runtime_defines.push(("__BADC_WIN_WINMAIN__", "1")),
                Some("wWinMain") => {
                    runtime_defines.push(("__BADC_WIN_WINMAIN__", "1"));
                    runtime_defines.push(("__BADC_WIN_WIDE__", "1"));
                }
                Some("wmain") => runtime_defines.push(("__BADC_WIN_WIDE__", "1")),
                _ => {}
            }
        }
        // An installed runtime source (`<badc-home>/lib/<name>`) replaces
        // the embedded body on the header overlay's terms: the unit keeps
        // the bare `<runtime/<name>>` label, so the DWARF unit name, the
        // line table and the link map carry no path of the build machine.
        let runtime_dir = self.cli.badc_home.as_ref().map(|h| h.join("lib"));
        for (name, body) in badc::embedded_runtime().iter() {
            let label = format!("<runtime/{name}>");
            let installed = runtime_dir.as_ref().map(|d| d.join(name));
            let src = match &installed {
                Some(p) if p.is_file() => match std::fs::read_to_string(p) {
                    Ok(s) => s,
                    Err(e) => {
                        eprint_diagnostic(format!(
                            "badc: error: cannot read installed runtime {}: {e}",
                            p.display()
                        ));
                        std::process::exit(1);
                    }
                },
                _ => body.to_string(),
            };
            let bytes = self
                .compile(&label, src, &runtime_defines, true)
                .unwrap_or_else(|e| {
                    eprint_error("", &e);
                    if let Some(p) = installed.filter(|p| p.is_file()) {
                        eprint_diagnostic(format!(
                            "badc: note: {label} was read from {}",
                            p.display()
                        ));
                    }
                    std::process::exit(1);
                });
            match badc::parse_native_elf(&bytes) {
                Ok(mut o) => {
                    o.source = label.clone();
                    objs.push(o);
                }
                Err(e) => {
                    eprint_diagnostic(format!("badc: {label}: {e}"));
                    std::process::exit(1);
                }
            }
        }
    }

    /// Compiler-runtime helpers (a libgcc / compiler-rt subset) and the
    /// bundled C-library sources join the pool on demand, after the
    /// user's archives so a real libgcc on the link line wins.
    /// Source-level target gating leaves the object empty for a target
    /// that references none of them, so it is never pulled. Whether the
    /// selection stalls turns on the link's inputs, the host's C library
    /// among them, so this compile stays out of the `--dump-ssa` output.
    fn load_pool(&mut self, stats: &mut LinkStats) -> Slot {
        self.pool_loaded = true;
        let mut members = Vec::new();
        let on_demand = badc::embedded_compiler_rt()
            .iter()
            .map(|e| ("compiler-rt", e))
            .chain(badc::embedded_libc().iter().map(|e| ("libc", e)));
        for (dir, (name, body)) in on_demand {
            let label = format!("<{dir}/{name}>");
            let bytes = self
                .compile(&label, body.to_string(), &[], false)
                .unwrap_or_else(|e| {
                    eprint_error("", &e);
                    std::process::exit(1);
                });
            match badc::parse_native_elf(&bytes) {
                Ok(mut o) => {
                    o.source = label;
                    members.push(o);
                }
                Err(e) => {
                    eprint_diagnostic(format!("badc: {label}: {e}"));
                    std::process::exit(1);
                }
            }
        }
        stats.mark("rtlib");
        Slot::lazy(members)
    }
}

/// Read and parse a `.o` input.
fn read_object_input(obj_path: &str, target: badc::Target) -> badc::NativeObject {
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
            o.source = obj_path.to_string();
            o
        }
        Err(e) => {
            eprint_diagnostic(format!("badc: {obj_path}: {e}"));
            std::process::exit(1);
        }
    }
}

/// Read and parse an `.a` input's members.
fn read_archive_members(a_path: &str, target: badc::Target) -> Vec<badc::NativeObject> {
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
    let mut out = Vec::with_capacity(members.len());
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
                out.push(o);
            }
            Err(e) => {
                eprint_diagnostic(format!("badc: {a_path}({}): {e}", m.name));
                std::process::exit(1);
            }
        }
    }
    out
}

/// One link input in command-line order, read.
enum Slot {
    /// Objects the link includes whole: the startup runtime, a source's,
    /// a `.o`, a `--whole-archive` archive's members.
    Fixed(Vec<badc::NativeObject>),
    /// An archive's members, each moved to `pulled` when the link needs it.
    Lazy {
        members: Vec<Option<badc::NativeObject>>,
        pulled: Vec<badc::NativeObject>,
    },
    /// `shared_libs[i]`.
    Shared(usize),
    /// A group opens (true) or closes.
    Group(bool),
}

impl Slot {
    fn lazy(members: Vec<badc::NativeObject>) -> Self {
        Slot::Lazy {
            members: members.into_iter().map(Some).collect(),
            pulled: Vec::new(),
        }
    }
}

/// C89 6.3.2.2 link semantics: a definition anywhere in the link set
/// satisfies an implicitly declared call, so a name the auto-include
/// retry bound to a header's library binding is recompiled as an
/// implicit extern when an input defines it -- the user's definition
/// wins over the binding.
fn rebind_auto_includes(
    cfg: &CompileCfg,
    embedded: &mut EmbeddedSources,
    slots: &mut Vec<Slot>,
    source_slots: &[usize],
    source_auto_includes: &[Vec<String>],
    sources: &[String],
    stats: &mut LinkStats,
) {
    if source_auto_includes.iter().all(|a| a.is_empty()) {
        return;
    }
    // The scan folds unpulled pool members into `defined_fns`, so the
    // on-demand sources join the link here, as its last archive.
    if !embedded.pool_loaded {
        let pool = embedded.load_pool(stats);
        slots.push(pool);
    }
    let mut defined_fns = std::collections::HashSet::<String>::new();
    for slot in slots.iter() {
        let objs: Vec<&badc::NativeObject> = match slot {
            Slot::Fixed(objs) => objs.iter().collect(),
            Slot::Lazy { members, .. } => members.iter().flatten().collect(),
            Slot::Shared(_) | Slot::Group(_) => Vec::new(),
        };
        for o in objs {
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
        if !cfg.quiet {
            for n in &redirect {
                eprint_diagnostic(format!(
                    "info: the link defines `{n}`; rebinding the call in {} to it",
                    sources[i]
                ));
            }
        }
        // The retry is sequential (rare, and only for sources
        // the link redefines); flush its log inline.
        let (log, res) = compile_native_tu(&sources[i], &redirect, cfg);
        log.flush();
        match res {
            Ok(mut tu) => {
                tu.obj.source = sources[i].clone();
                slots[source_slots[i]] = Slot::Fixed(vec![tu.obj]);
            }
            Err(()) => std::process::exit(1),
        }
    }
}

/// What archive selection knows as it walks the inputs: names defined so
/// far, strong references still unresolved (each keyed to the first
/// input that made it, the link map's "referenced by" file), and the
/// names a shared library earlier on the line exports.
#[derive(Default)]
struct Selection {
    defined: hashbrown::HashSet<String>,
    undefined: hashbrown::HashMap<String, String>,
    shared: hashbrown::HashSet<String>,
    inclusions: Vec<badc::ArchiveInclusion>,
}

impl Selection {
    /// A global or weak definition satisfies references; only a strong
    /// (STB_GLOBAL) undefined reference pulls a member, matching ELF
    /// archive practice.
    fn account(&mut self, o: &badc::NativeObject) {
        for s in &o.symbols {
            if s.binding == 0 {
                continue;
            }
            if s.section != badc::NativeSymSection::Undef {
                self.defined.insert(s.name.clone());
                self.undefined.remove(&s.name);
            } else if s.binding == 1
                && !self.defined.contains(&s.name)
                && !self.shared.contains(&s.name)
            {
                self.undefined
                    .entry(s.name.clone())
                    .or_insert_with(|| o.source.clone());
            }
        }
    }

    /// Pull the members of the archives at `span` that define a name
    /// still undefined, until a pass over all of them pulls none. The
    /// archive symbol index lists strong section-resident definitions; a
    /// member is pulled on exactly those.
    fn pull(&mut self, slots: &mut [Slot], span: &[usize]) {
        loop {
            let mut progress = false;
            for &k in span {
                let Slot::Lazy { members, pulled } = &mut slots[k] else {
                    continue;
                };
                for member in members.iter_mut() {
                    let wanted = member.as_ref().and_then(|o| {
                        o.symbols.iter().find_map(|s| {
                            (s.binding == 1
                                && !matches!(
                                    s.section,
                                    badc::NativeSymSection::Undef | badc::NativeSymSection::Abs
                                )
                                && self.undefined.contains_key(&s.name))
                            .then(|| s.name.clone())
                        })
                    });
                    if let Some(symbol) = wanted {
                        let o = member.take().expect("a wanted member is present");
                        self.inclusions.push(badc::ArchiveInclusion {
                            member: o.source.clone(),
                            referenced_by: self.undefined.get(&symbol).cloned().unwrap_or_default(),
                            symbol,
                        });
                        self.account(&o);
                        pulled.push(o);
                        progress = true;
                    }
                }
            }
            if !progress {
                return;
            }
        }
    }
}

/// Pull the archive members the link needs and materialize the target C
/// library over whatever stays undefined; the included objects come back
/// in link order, each archive's members at its place in pull order. An
/// ELF link resolves as GNU ld does: an archive answers the references
/// made before it, rescanning itself (a group, its archives together)
/// until it pulls nothing, and a shared library the names it exports
/// from its place on. Mach-O and PE links search every archive until
/// nothing changes, as ld64 and link.exe do.
fn select_archive_members(
    embedded: &mut EmbeddedSources,
    mut slots: Vec<Slot>,
    shared_libs: &mut Vec<badc::SharedLibrary>,
    target_libc: &mut Option<badc::TargetCLibrary>,
    freestanding_entry: Option<&str>,
    stats: &mut LinkStats,
) -> (Vec<badc::NativeObject>, Vec<badc::ArchiveInclusion>) {
    let in_order = embedded.cli.target.binary_format() == badc::BinaryFormat::Elf;
    let mut sel = Selection::default();
    // A freestanding entry is a link root: seed it as undefined so an
    // archive member that only defines the entry is pulled.
    if let Some(entry) = freestanding_entry {
        sel.undefined
            .insert(entry.to_string(), "<command line>".to_string());
    }
    let (mut depth, mut group) = (0usize, Vec::new());
    for k in 0..slots.len() {
        match &slots[k] {
            Slot::Fixed(objs) => objs.iter().for_each(|o| sel.account(o)),
            Slot::Lazy { .. } if !in_order => {}
            Slot::Lazy { .. } if depth > 0 => group.push(k),
            Slot::Lazy { .. } => sel.pull(&mut slots, &[k]),
            Slot::Shared(i) if in_order => {
                for name in &shared_libs[*i].exports {
                    sel.undefined.remove(name);
                    sel.shared.insert(name.clone());
                }
            }
            Slot::Shared(_) => {}
            // The bounds pair up; a script's group joins the one it is in.
            Slot::Group(true) => depth += 1,
            Slot::Group(false) => {
                depth -= 1;
                if depth == 0 {
                    sel.pull(&mut slots, &core::mem::take(&mut group));
                }
            }
        }
    }
    let all_lazy = |slots: &[Slot]| -> Vec<usize> {
        (0..slots.len())
            .filter(|&k| matches!(slots[k], Slot::Lazy { .. }))
            .collect()
    };
    if !in_order {
        let span = all_lazy(&slots);
        sel.pull(&mut slots, &span);
    }
    // The inputs stalled; offer the on-demand sources once, as the last
    // archive. A name a `-l` shared library or the target's C library
    // exports resolves as a load-time import, so it does not call for
    // them -- matching a system linker, where the implicit C library
    // sits after the archives on the line.
    if !embedded.pool_loaded
        && !sel.undefined.keys().all(|n| {
            badc::link_resolves_symbol(n)
                || shared_libs.iter().any(|l| l.exports.contains(n))
                || target_libc.as_mut().is_some_and(|l| l.admit(n))
        })
    {
        slots.push(embedded.load_pool(stats));
        let span = if in_order {
            vec![slots.len() - 1]
        } else {
            all_lazy(&slots)
        };
        sel.pull(&mut slots, &span);
    }
    let mut native_objs: Vec<badc::NativeObject> = Vec::new();
    for slot in slots {
        match slot {
            Slot::Fixed(objs) => native_objs.extend(objs),
            Slot::Lazy { pulled, .. } => native_objs.extend(pulled),
            Slot::Shared(_) | Slot::Group(_) => {}
        }
    }
    // Whatever the selection left undefined is what the target's C
    // library has to cover for the link to resolve it as an import.
    // Weak references count: a system linker binds one the implicit
    // C library defines rather than resolving it to zero.
    if let Some(lib) = target_libc.as_mut() {
        for o in native_objs.iter() {
            for s in &o.symbols {
                if s.binding != 0
                    && s.section == badc::NativeSymSection::Undef
                    && !sel.defined.contains(&s.name)
                {
                    lib.admit(&s.name);
                }
            }
        }
        // An object from another compiler reads a C library data object
        // directly, so the image holds a copy of it, defined with the
        // type the header declares.
        let wanted = badc::copy_candidates(&native_objs, core::slice::from_ref(lib.library()));
        if let Some(src) = lib.copy_definitions(&wanted) {
            let label = "<copies>";
            let object = embedded
                .compile(label, src, &[], false)
                .and_then(|bytes| badc::parse_native_elf(&bytes));
            match object {
                Ok(mut o) => {
                    o.source = label.to_string();
                    native_objs.push(o);
                }
                Err(e) => {
                    eprint_error("", &e);
                    std::process::exit(1);
                }
            }
        }
        if !lib.library().exports.is_empty() {
            shared_libs.push(lib.library().clone());
        }
    }
    (native_objs, sel.inclusions)
}

/// What the image writer needs once member selection is done.
struct ImageInputs<'a> {
    objs: &'a [badc::NativeObject],
    shared_libs: &'a [badc::SharedLibrary],
    inclusions: &'a [badc::ArchiveInclusion],
    entry: Option<&'a str>,
    subsystem: Option<badc::Subsystem>,
    /// Names the default output path when `-o` is absent.
    first_source: &'a str,
}

/// A freestanding Linux image runs without the dynamic loader unless it
/// binds a shared-library symbol; report what it binds, since the image
/// then needs the loader the program was built to do without.
fn warn_freestanding_imports(cli: &Cli, merged: &badc::MergedNative) {
    if !cli.freestanding
        || cli.mode == Mode::SharedLibrary
        || merged.imports.is_empty()
        || !matches!(
            cli.target,
            badc::Target::LinuxAarch64 | badc::Target::LinuxX64
        )
    {
        return;
    }
    let mut by_library: Vec<(String, Vec<String>)> = Vec::new();
    for name in &merged.imports {
        let library = merged
            .import_dylib_map
            .get(name)
            .and_then(|&i| merged.dylibs.get(i as usize))
            .map_or_else(|| "a shared library".to_string(), |lib| format!("`{lib}`"));
        match by_library.iter_mut().find(|(l, _)| *l == library) {
            Some((_, names)) => names.push(format!("`{name}`")),
            None => by_library.push((library, vec![format!("`{name}`")])),
        }
    }
    let warnings = by_library.into_iter().map(|(library, names)| {
        let verb = if names.len() == 1 { "binds" } else { "bind" };
        let message = format!(
            "--freestanding: {} {verb} to {library}, so the image runs through the dynamic loader",
            names.join(", ")
        );
        (badc::diag::Code::FREESTANDING_IMPORT, message)
    });
    emit_link_warnings(cli, warnings);
}

/// Report link warnings at the levels the command line set; under
/// `--fatal-warnings` or `-Werror` one fails the link.
fn emit_link_warnings(cli: &Cli, warnings: impl IntoIterator<Item = (badc::diag::Code, String)>) {
    let mut config = cli.front.diag.clone();
    if cli.link.fatal_warnings {
        config.warnings_as_errors(true);
    }
    let mut sink = badc::diag::Sink::new(config, Default::default());
    for (code, message) in warnings {
        sink.emit(code, None, message);
    }
    let tty = std::io::stderr().is_terminal();
    for d in sink.diagnostics() {
        eprintln!("{}", rendered(d, tty));
    }
    if sink.has_errors() {
        eprint_diagnostic("badc: error: warnings treated as errors");
        std::process::exit(1);
    }
}

/// Merge the selected objects, lower the PLT, and write the image.
fn emit_image(cli: &Cli, image: ImageInputs, stats: &mut LinkStats) {
    // A shared library may reference symbols the host executable
    // supplies at `dlopen` time; let an unresolved global become a
    // load-time import instead of a link error, unless `--no-undefined`.
    let allow_undefined = cli.mode == Mode::SharedLibrary && cli.link.z.defs() != Some(true);
    let mut merged = match badc::link_native_objects_with_shared_libs(
        image.objs,
        allow_undefined,
        image.shared_libs,
    ) {
        Ok(m) => m,
        Err(e) => {
            eprint_diagnostic(format!("badc: {e}"));
            std::process::exit(1);
        }
    };
    stats.mark("merge");
    warn_freestanding_imports(cli, &merged);
    let (exec_stack, stack_warning) = badc::resolve_exec_stack(
        cli.link.z.exec_stack(),
        merged.exec_stack_input.as_deref(),
        cli.link.warn_execstack,
    );
    emit_link_warnings(
        cli,
        stack_warning.map(|w| (badc::diag::Code::EXEC_STACK, w)),
    );
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
    let entry_name = image.entry.unwrap_or("main");
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
                shared_default_path = default_output_path(image.first_source, cli.target, cli.mode);
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
        image.subsystem,
        native_output_kind,
        cli.target,
        shared_lib_name,
        &cli.image_options(exec_stack),
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
            default_path = default_output_path(image.first_source, cli.target, cli.mode);
            &default_path
        }
    };
    write_output(out, &bytes, cli.target, cli.quiet, true);
    post_write_native(out, cli.target);
    if cli.link.map_path.is_some() || cli.link.print_map {
        let out_name = out.file_name().and_then(|n| n.to_str()).unwrap_or("a.out");
        let map = match badc::render_link_map(&merged, &bytes, image.inclusions, out_name) {
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
    stats.report(image.objs.len());
}

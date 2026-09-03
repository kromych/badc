use super::diag::eprint_diagnostic;
use super::output::set_executable;

/// One link input in command-line position: placement follows the
/// order files are loaded, so archives keep their place in the line.
pub(crate) enum LinkInputCli {
    Object(String),
    Archive { path: String, whole: bool },
}

/// Inputs and options for a `-T/--script` link, gathered by the CLI.
pub(crate) struct ScriptLinkCli {
    pub(crate) script_path: std::path::PathBuf,
    pub(crate) inputs: Vec<LinkInputCli>,
    pub(crate) output_path: Option<std::path::PathBuf>,
    pub(crate) map_path: Option<std::path::PathBuf>,
    pub(crate) print_map: bool,
    pub(crate) entry_override: Option<String>,
    pub(crate) shared: bool,
    pub(crate) orphan_handling: badc::OrphanHandling,
    pub(crate) build_id_sha1: bool,
    pub(crate) max_page_size: Option<u64>,
    pub(crate) pack_relative_relocs: bool,
    pub(crate) apply_dynamic_relocs: bool,
    pub(crate) strip_debug: bool,
    pub(crate) discard_locals: bool,
    pub(crate) discard_none: bool,
    pub(crate) emit_relocs: bool,
    pub(crate) quiet: bool,
    pub(crate) fix_cortex_a53_843419: bool,
}

/// Script-driven link: parse the script, read every object (pulling
/// archive members on demand, or wholly under `--whole-archive`), and
/// hand the set to the `lds_link` engine.
pub(crate) fn run_script_link(cli: ScriptLinkCli) {
    let fail = |msg: String| -> ! {
        eprint_diagnostic(format!("badc: {msg}"));
        std::process::exit(1);
    };
    let script_text = match std::fs::read_to_string(&cli.script_path) {
        Ok(t) => t,
        Err(e) => fail(format!(
            "error: cannot read script {}: {e}",
            cli.script_path.display()
        )),
    };
    let script = match badc::parse_linker_script(&script_text) {
        Ok(s) => s,
        Err(e) => fail(format!("{e}")),
    };
    // Load inputs in command-line order: input-section placement
    // follows load order, so an archive's members belong at the
    // archive's position. `--whole-archive` includes every member;
    // other members are pulled while they define a still-undefined
    // symbol, rescanning to a fixed point (group semantics), and land
    // at their archive's slot in pull order.
    enum Slot {
        Ready(Vec<badc::LdsObject>),
        Lazy {
            members: Vec<Option<badc::LdsObject>>,
            pulled: Vec<badc::LdsObject>,
        },
    }
    let mut slots: Vec<Slot> = Vec::new();
    let mut have_lazy = false;
    for input in &cli.inputs {
        match input {
            LinkInputCli::Object(path) => {
                let bytes = match std::fs::read(path) {
                    Ok(b) => b,
                    Err(e) => fail(format!("error: cannot read {path}: {e}")),
                };
                match badc::parse_lds_object(path, bytes) {
                    Ok(o) => slots.push(Slot::Ready(vec![o])),
                    Err(e) => fail(format!("{e}")),
                }
            }
            LinkInputCli::Archive { path, whole } => {
                let blob = match std::fs::read(path) {
                    Ok(b) => b,
                    Err(e) => fail(format!("error: cannot read {path}: {e}")),
                };
                // Thin archive members resolve against the archive's
                // directory.
                let members =
                    match badc::read_archive_at(&blob, std::path::Path::new(path).parent()) {
                        Ok(m) => m,
                        Err(e) => fail(format!("error: {path}: {e}")),
                    };
                let mut objs = Vec::new();
                for m in members {
                    let label = format!("{path}({})", m.name);
                    match badc::parse_lds_object(&label, m.bytes) {
                        Ok(o) => objs.push(o),
                        Err(e) => fail(format!("{e}")),
                    }
                }
                if *whole {
                    slots.push(Slot::Ready(objs));
                } else {
                    have_lazy = true;
                    slots.push(Slot::Lazy {
                        members: objs.into_iter().map(Some).collect(),
                        pulled: Vec::new(),
                    });
                }
            }
        }
    }
    if have_lazy {
        let defined_names = |o: &badc::LdsObject| -> Vec<String> {
            o.symbols
                .iter()
                .filter(|s| (s.info >> 4) != 0 && s.shndx != 0 && !s.name.is_empty())
                .map(|s| s.name.clone())
                .collect()
        };
        let mut defined: std::collections::HashSet<String> = std::collections::HashSet::new();
        let mut undefined: std::collections::HashSet<String> = std::collections::HashSet::new();
        let account = |o: &badc::LdsObject,
                       defined: &mut std::collections::HashSet<String>,
                       undefined: &mut std::collections::HashSet<String>| {
            for s in &o.symbols {
                if s.name.is_empty() || (s.info >> 4) == 0 {
                    continue;
                }
                if s.shndx == 0 {
                    if !defined.contains(&s.name) {
                        undefined.insert(s.name.clone());
                    }
                } else {
                    undefined.remove(&s.name);
                    defined.insert(s.name.clone());
                }
            }
        };
        for slot in &slots {
            if let Slot::Ready(objs) = slot {
                for o in objs {
                    account(o, &mut defined, &mut undefined);
                }
            }
        }
        loop {
            let mut progress = false;
            for slot in slots.iter_mut() {
                let Slot::Lazy { members, pulled } = slot else {
                    continue;
                };
                for m in members.iter_mut() {
                    let wanted = m
                        .as_ref()
                        .is_some_and(|o| defined_names(o).iter().any(|n| undefined.contains(n)));
                    if wanted {
                        let o = m.take().expect("wanted member is occupied");
                        account(&o, &mut defined, &mut undefined);
                        pulled.push(o);
                        progress = true;
                    }
                }
            }
            if !progress {
                break;
            }
        }
    }
    let mut inputs: Vec<badc::LdsObject> = Vec::new();
    for slot in slots {
        match slot {
            Slot::Ready(objs) => inputs.extend(objs),
            Slot::Lazy { pulled, .. } => inputs.extend(pulled),
        }
    }
    if inputs.is_empty() {
        fail("error: no input objects".to_string());
    }
    let machine = inputs[0].machine;
    let opts = badc::LdsOptions {
        emit: if cli.shared {
            badc::LdsEmit::Dyn
        } else {
            badc::LdsEmit::Exec
        },
        shared: cli.shared,
        entry_override: cli.entry_override,
        // GNU ld defaults: 2 MiB on x86-64, 64 KiB on aarch64, 4 KiB
        // on i386.
        max_page_size: cli.max_page_size.unwrap_or(match machine {
            183 => 0x10000,
            3 => 0x1000,
            _ => 0x200000,
        }),
        orphan_handling: cli.orphan_handling,
        build_id_sha1: cli.build_id_sha1,
        strip_debug: cli.strip_debug,
        discard_locals: cli.discard_locals,
        discard_none: cli.discard_none,
        pack_relative_relocs: cli.pack_relative_relocs,
        apply_dynamic_relocs: cli.apply_dynamic_relocs,
        emit_relocs: cli.emit_relocs,
        emit_warnings: !cli.quiet,
        fix_cortex_a53_843419: cli.fix_cortex_a53_843419,
        ..Default::default()
    };
    let res = match badc::link_with_script(&script, inputs, &opts) {
        Ok(r) => r,
        Err(e) => fail(format!("{e}")),
    };
    for w in &res.warnings {
        eprintln!("badc: {w}");
    }
    let out = cli
        .output_path
        .unwrap_or_else(|| std::path::PathBuf::from("a.out"));
    if let Err(e) = std::fs::write(&out, &res.image) {
        fail(format!("error: failed to write {}: {e}", out.display()));
    }
    set_executable(&out);
    if !cli.quiet {
        eprint_diagnostic(format!("info: wrote file {}", out.display()));
    }
    if let Some(p) = &cli.map_path
        && let Err(e) = std::fs::write(p, &res.map)
    {
        fail(format!("error: cannot write map file {}: {e}", p.display()));
    }
    if cli.print_map {
        print!("{}", res.map);
    }
}

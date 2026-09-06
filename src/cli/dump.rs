use badc::{PredefinedKind, predefined_symbols};

/// `--dump-native-link`: parse a list of native ELF `.o` files
/// produced by `-c`, merge them via
/// `link_native_objects`, and print a summary. Useful for
/// validating the relocatable .o pipeline end-to-end before the
/// ET_EXEC writer for `MergedNative` lands. Args are taken
/// verbatim from the command line minus the leading executable
/// name; non-flag positional args are treated as `.o` paths.
pub(crate) fn dump_native_link(rest: &[String]) {
    let paths: Vec<&str> = rest
        .iter()
        .filter(|a| !a.starts_with("--") && *a != "--dump-native-link")
        .map(|s| s.as_str())
        .collect();
    if paths.is_empty() {
        eprintln!("badc: --dump-native-link requires one or more `.o` paths");
        std::process::exit(1);
    }
    let mut objs: Vec<badc::NativeObject> = Vec::with_capacity(paths.len());
    for p in &paths {
        let bytes = match std::fs::read(p) {
            Ok(b) => b,
            Err(e) => {
                eprintln!("badc: --dump-native-link: cannot read `{p}`: {e}");
                std::process::exit(1);
            }
        };
        if !badc::is_native_object(&bytes) {
            eprintln!("badc: --dump-native-link: `{p}` is not a relocatable object");
            std::process::exit(1);
        }
        match badc::parse_native_object(&bytes) {
            Ok(o) => objs.push(o),
            Err(e) => {
                eprintln!("badc: --dump-native-link: {p}: {e}");
                std::process::exit(1);
            }
        }
    }
    let mut merged = match badc::link_native_objects(&objs) {
        Ok(m) => m,
        Err(e) => {
            eprintln!("badc: --dump-native-link: {e}");
            std::process::exit(1);
        }
    };
    println!("MergedNative:");
    println!("  machine     = {:?}", merged.machine);
    println!("  .text size  = {}", merged.text.len());
    println!("  .data size  = {}", merged.data.len());
    println!("  .bss size   = {}", merged.bss_size);
    println!("  defined     = {}", merged.defined.len());
    for (name, sym) in &merged.defined {
        println!(
            "    {name} @ {:?} +{:#x} size={:#x}",
            sym.section, sym.value, sym.size
        );
    }
    println!("  imports     = {}", merged.imports.len());
    for (i, name) in merged.imports.iter().enumerate() {
        println!("    [{i}] {name}");
    }
    println!("  pending     = {} reloc(s)", merged.pending_imports.len());
    for r in &merged.pending_imports {
        let name = if r.import_index == usize::MAX {
            "<data-ref>"
        } else {
            merged.imports[r.import_index].as_str()
        };
        println!(
            "    text[{:#x}] -> {name} (rtype={:#x}, addend={})",
            r.text_offset, r.rtype, r.addend
        );
    }
    // Per-arch PLT lowering pass. The trampoline shape differs
    // between targets (six-byte JMP rip-rel on x86_64, twelve-
    // byte adrp+ldr+br on aarch64), but the link-side
    // contract is identical: append one trampoline per unique
    // import, patch each call-site to reach it.
    let plt_result = match merged.machine {
        badc::NativeMachine::X86_64 => badc::emit_x86_64_plt(&mut merged),
        badc::NativeMachine::Aarch64 => badc::emit_aarch64_plt(&mut merged),
    };
    match plt_result {
        Ok(tramps) => {
            println!("  PLT tramps  = {} entry(ies)", tramps.len());
            for t in &tramps {
                let name = &merged.imports[t.import_index];
                println!("    text[{:#x}] -> {name}", t.text_offset);
            }
            println!("  post-PLT .text size = {}", merged.text.len());
        }
        Err(e) => {
            eprintln!("badc: --dump-native-link: PLT lowering failed: {e}");
        }
    }
}

/// `--dump-headers` writer. Prints every bundled header to stdout
/// with a one-line `// ===== <name> =====` separator before each
/// body, suitable for piping through `awk` to extract a subset
/// or for redirecting the whole stream to a directory tree (see
/// the `--help` blurb -- the conventional shape is to redirect
/// into `./include` and let `-I.` plus future filesystem search
/// override the embedded copy).
pub(crate) fn dump_bundled_headers() {
    for (name, body) in badc::embedded_headers() {
        println!("// ===== {name} =====");
        // Bodies already end with `\n`; `print!` rather than
        // `println!` so we don't add a stray blank line between
        // the last byte and the next separator.
        print!("{body}");
        if !body.ends_with('\n') {
            println!();
        }
    }
}

/// Print every name the compiler pre-binds before parsing -- keywords,
/// library functions, and integer constants -- grouped by kind. Useful
/// for scripting (`badc --list-symbols | grep PROT_`) and for spotting
/// what's available without `#include`.
pub(crate) fn print_predefined_symbols() {
    let symbols = predefined_symbols();

    let mut names: Vec<&str> = symbols
        .iter()
        .filter(|s| s.kind == PredefinedKind::Keyword)
        .map(|s| s.name)
        .collect();
    names.sort_unstable();
    println!("Keywords:");
    for name in names {
        println!("  {name}");
    }

    let mut names: Vec<&str> = symbols
        .iter()
        .filter(|s| s.kind == PredefinedKind::Intrinsic)
        .map(|s| s.name)
        .collect();
    names.sort_unstable();
    println!("\nLibrary calls:");
    for name in names {
        println!("  {name}");
    }

    let mut consts: Vec<(&str, i64)> = symbols
        .iter()
        .filter(|s| s.kind == PredefinedKind::Constant)
        .map(|s| (s.name, s.value))
        .collect();
    consts.sort_unstable_by_key(|(n, _)| *n);
    let max_name_width = consts.iter().map(|(n, _)| n.len()).max().unwrap_or(0);
    println!("\nConstants:");
    for (name, value) in consts {
        println!("  {name:<max_name_width$} = {value}");
    }
}

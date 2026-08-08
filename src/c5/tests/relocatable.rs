//! Relocatable-link (`ld -r`) merge tests: parse ET_REL objects the
//! compiler emits, merge them with `link_relocatable`, and assert on
//! the round-tripped output (section extents, symbol resolution,
//! relocation rewriting, script handling).

use crate::c5::linker::relocatable::{
    EtRel, EtSymRef, RelinkOptions, glob_match, link_relocatable, parse_et_rel,
    parse_module_script,
};
use crate::c5::{
    CompileOptions, Compiler, NativeOptions, OutputKind, Target, emit_native_with_options,
};

fn compile_obj(src: &str, name: &str) -> EtRel {
    let copts = CompileOptions {
        no_entry_point: true,
        ..Default::default()
    };
    let program = Compiler::with_options(src.to_string(), Target::LinuxX64, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    parse_et_rel(&bytes, name).expect("parse")
}

fn merge(objs: &[EtRel], opts: &RelinkOptions) -> EtRel {
    let bytes = link_relocatable(objs, opts).expect("merge");
    parse_et_rel(&bytes, "merged").expect("round-trip parse")
}

#[test]
fn merges_sections_symbols_and_relocs() {
    let a = compile_obj(
        "extern int shared_counter;\n\
         int bump(int n) { return shared_counter + n; }\n",
        "a.o",
    );
    let b = compile_obj(
        "int shared_counter = 7;\n\
         int bump(int n);\n\
         int twice(int n) { return bump(n) + bump(n); }\n",
        "b.o",
    );
    let merged = merge(&[a.clone(), b.clone()], &RelinkOptions::default());

    // Same-name sections concatenate: merged .text spans both inputs.
    let text_in = |o: &EtRel| {
        o.sections
            .iter()
            .find(|s| s.name == ".text")
            .expect("input .text")
            .size()
    };
    let text_out = merged
        .sections
        .iter()
        .find(|s| s.name == ".text")
        .expect("merged .text");
    assert!(text_out.size() >= text_in(&a) + text_in(&b));

    // Undef + def resolves without leaving a duplicate entry.
    let counters: Vec<_> = merged
        .symbols
        .iter()
        .filter(|s| s.name == "shared_counter")
        .collect();
    assert_eq!(counters.len(), 1);
    assert!(matches!(counters[0].sec, EtSymRef::Section(_)));
    let bumps: Vec<_> = merged.symbols.iter().filter(|s| s.name == "bump").collect();
    assert_eq!(bumps.len(), 1);
    assert!(matches!(bumps[0].sec, EtSymRef::Section(_)));

    // Every relocation survives (none resolved) and lands inside the
    // merged section with a valid symbol index.
    let in_relocs: usize = [&a, &b]
        .iter()
        .flat_map(|o| o.sections.iter())
        .map(|s| s.relocs.len())
        .sum();
    let out_relocs: usize = merged.sections.iter().map(|s| s.relocs.len()).sum();
    assert_eq!(in_relocs, out_relocs);
    for s in &merged.sections {
        for r in &s.relocs {
            assert!(r.offset < s.size().max(1), "reloc offset inside section");
            assert!((r.sym as usize) < merged.symbols.len());
        }
    }

    // b.o's `twice` calls `bump`; after the merge the reloc must
    // reference the merged `bump` entry.
    let bump_idx = merged
        .symbols
        .iter()
        .position(|s| s.name == "bump")
        .unwrap() as u32;
    let text = merged
        .sections
        .iter()
        .find(|s| s.name == ".text")
        .unwrap();
    assert!(
        text.relocs.iter().any(|r| r.sym == bump_idx),
        "call reloc re-indexed to the merged symbol"
    );
}

#[test]
fn undefined_globals_stay_undefined() {
    let a = compile_obj(
        "int helper(int);\n\
         int entry(int n) { return helper(n); }\n",
        "a.o",
    );
    let merged = merge(&[a], &RelinkOptions::default());
    let helper = merged
        .symbols
        .iter()
        .find(|s| s.name == "helper")
        .expect("undef kept");
    assert_eq!(helper.sec, EtSymRef::Undef);
}

#[test]
fn duplicate_strong_definitions_are_rejected() {
    let a = compile_obj("int dup_val = 1;\n", "a.o");
    let b = compile_obj("int dup_val = 2;\n", "b.o");
    let e = link_relocatable(&[a, b], &RelinkOptions::default()).unwrap_err();
    assert!(format!("{e:?}").contains("multiple definition"));
}

#[test]
fn locals_kept_per_object() {
    let a = compile_obj(
        "static int secret_a = 5;\n\
         int geta(void) { return secret_a; }\n",
        "a.o",
    );
    let b = compile_obj(
        "static int secret_b = 6;\n\
         int getb(void) { return secret_b; }\n",
        "b.o",
    );
    let merged = merge(&[a, b], &RelinkOptions::default());
    assert!(merged.symbols.iter().any(|s| s.name == "secret_a"));
    assert!(merged.symbols.iter().any(|s| s.name == "secret_b"));
    // ELF ordering: every local precedes every global.
    let last_local = merged
        .symbols
        .iter()
        .rposition(|s| s.binding == 0)
        .unwrap();
    let first_global = merged
        .symbols
        .iter()
        .position(|s| s.binding != 0)
        .unwrap();
    assert!(last_local < first_global);
}

#[test]
fn module_script_discard_and_gather() {
    let script_text = "\
        SECTIONS {\n\
         /DISCARD/ : { *(.discard) *(.discard.*) *(.export_symbol) }\n\
         __ksymtab 0 : { *(SORT(___ksymtab+*)) }\n\
         .data : {\n\
          . = ALIGN(8); __start_alloc_tags = .; KEEP(*(alloc_tags)) __stop_alloc_tags = .;\n\
         }\n\
        }\n";
    let script = parse_module_script(script_text).expect("parse script");
    assert_eq!(
        script.discard,
        ["\u{2e}discard", ".discard.*", ".export_symbol"].map(str::to_string)
    );
    assert_eq!(script.outsecs.len(), 2);
    assert_eq!(script.outsecs[0].name, "__ksymtab");

    let a = compile_obj("int probe(void) { return 1; }\n int gd = 3;\n", "a.o");
    let merged = merge(
        &[a],
        &RelinkOptions {
            script: Some(script),
            ..Default::default()
        },
    );
    // The .data rule defines the bracketing symbols even with no
    // alloc_tags input, and they are globals in .data.
    for name in ["__start_alloc_tags", "__stop_alloc_tags"] {
        let s = merged
            .symbols
            .iter()
            .find(|s| s.name == name)
            .unwrap_or_else(|| panic!("{name} defined"));
        assert!(matches!(s.sec, EtSymRef::Section(_)), "{name} in a section");
        assert!(s.binding != 0, "{name} global");
    }
}

#[test]
fn glob_match_shapes() {
    assert!(glob_match(".discard.*", ".discard.retpoline"));
    assert!(glob_match("___ksymtab+*", "___ksymtab+printk"));
    assert!(!glob_match("___ksymtab+*", "___ksymtab_gpl+printk"));
    assert!(glob_match("*", ".anything"));
    assert!(glob_match(".text", ".text"));
    assert!(!glob_match(".text", ".text.hot"));
    // Character classes, as the kernel's module.lds spells them.
    assert!(glob_match(".text.[0-9a-zA-Z_]*", ".text.unlikely"));
    assert!(glob_match(".data.[0-9a-zA-Z_]*", ".data.once"));
    assert!(!glob_match(".bss.[0-9a-zA-Z_]*", ".bss..L0"));
    assert!(glob_match(".bss..L*", ".bss..L0"));
    assert!(glob_match("a[!x]c", "abc"));
    assert!(!glob_match("a[!x]c", "axc"));
    assert!(glob_match(".rodata.[0-9a-zA-Z_]*", ".rodata.jump_tables"));
}

#[test]
fn module_script_arch_tail_and_byte() {
    // The kernel appends an arch SECTIONS block; `.plt`-style
    // placeholders carry one literal byte the module loader resizes.
    let text = "\
        SECTIONS {\n\
         .text 0 : { *(.text .text.[0-9a-zA-Z_]*) }\n\
        }\n\
        SECTIONS {\n\
         .plt 0 : { BYTE(0) }\n\
         .init.plt 0 : { BYTE(0) }\n\
        }\n";
    let script = parse_module_script(text).expect("parse");
    assert_eq!(script.outsecs.len(), 3);
    let a = compile_obj("int f(void) { return 3; }\n", "a.o");
    let merged = merge(
        &[a],
        &RelinkOptions {
            script: Some(script),
            ..Default::default()
        },
    );
    for name in [".plt", ".init.plt"] {
        let s = merged
            .sections
            .iter()
            .find(|s| s.name == name)
            .unwrap_or_else(|| panic!("{name} kept"));
        assert_eq!(s.size(), 1, "{name} carries the BYTE(0) placeholder");
    }
}

#[test]
fn build_id_note_is_emitted_and_stable() {
    let a = compile_obj("int v(void) { return 2; }\n", "a.o");
    let opts = RelinkOptions {
        build_id_sha1: true,
        ..Default::default()
    };
    let one = link_relocatable(&[a.clone()], &opts).expect("merge");
    let two = link_relocatable(&[a], &opts).expect("merge");
    assert_eq!(one, two, "deterministic output");
    let merged = parse_et_rel(&one, "merged").expect("parse");
    let note = merged
        .sections
        .iter()
        .find(|s| s.name == ".note.gnu.build-id")
        .expect("build-id note");
    // nhdr(12) + "GNU\0" + 20-byte SHA-1 digest.
    assert_eq!(note.bytes.len(), 36);
    assert_eq!(&note.bytes[12..16], b"GNU\0");
    assert!(note.bytes[16..36].iter().any(|&b| b != 0));
}

#[test]
fn ld_invocation_detection() {
    use crate::c5::linker::ld_driver::is_ld_invocation;
    assert!(is_ld_invocation("/usr/bin/ld", None));
    assert!(is_ld_invocation("ld", Some("-r")));
    assert!(is_ld_invocation("aarch64-linux-gnu-ld", None));
    assert!(is_ld_invocation("badc", Some("--ld")));
    assert!(!is_ld_invocation("badc", Some("-r")));
    assert!(!is_ld_invocation("/usr/bin/badc", None));
}

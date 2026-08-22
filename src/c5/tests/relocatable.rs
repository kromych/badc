//! Relocatable-link (`ld -r`) merge tests: parse ET_REL objects the
//! compiler emits, merge them with `link_relocatable`, and assert on
//! the round-tripped output (section extents, symbol resolution,
//! relocation rewriting, script handling).

use crate::c5::linker::relocatable::{
    EM_AARCH64, EtGroup, EtRel, EtReloc, EtSection, EtSym, EtSymRef, RelinkOptions, glob_match,
    link_relocatable, parse_et_rel, parse_module_script,
};
use crate::c5::{
    CompileOptions, Compiler, NativeOptions, OutputKind, Target, emit_native_with_options,
};

fn compile_bytes(src: &str, target: Target) -> Vec<u8> {
    let copts = CompileOptions {
        no_entry_point: true,
        ..Default::default()
    };
    let program = Compiler::with_options(src.to_string(), target, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    emit_native_with_options(&program, target, opts).expect("emit")
}

fn compile_obj(src: &str, name: &str) -> EtRel {
    parse_et_rel(&compile_bytes(src, Target::LinuxX64), name).expect("parse")
}

fn compile_obj_aarch64(src: &str, name: &str) -> EtRel {
    parse_et_rel(&compile_bytes(src, Target::LinuxAarch64), name).expect("parse")
}

fn compile_obj_with_debug_info(src: &str, name: &str) -> EtRel {
    let copts = CompileOptions {
        no_entry_point: true,
        ..Default::default()
    };
    let program = Compiler::with_options(src.to_string(), Target::LinuxX64, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        debug_info: true,
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
    let text = merged.sections.iter().find(|s| s.name == ".text").unwrap();
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
fn asm_label_renames_every_emitted_symbol() {
    // A GNU asm-label is the assembler name of the entity: definitions,
    // undefined references and the relocations against them all carry it,
    // and the identifier reaches the object nowhere.
    const STB_LOCAL: u8 = 0;
    const STB_WEAK: u8 = 2;
    const STV_HIDDEN: u8 = 2;
    let a = compile_obj(
        "int fn(void) __asm__(\"real_fn\");\n\
         int fn(void) { return 1; }\n\
         static int stat_fn(void) __asm__(\"real_stat\");\n\
         static int stat_fn(void) { return 2; }\n\
         int weak_fn(void) __asm__(\"real_weak\") __attribute__((weak));\n\
         int weak_fn(void) { return 3; }\n\
         int hid_fn(void) __asm__(\"real_hid\") __attribute__((visibility(\"hidden\")));\n\
         int hid_fn(void) { return 4; }\n\
         int sect_fn(void) __asm__(\"real_sect\") __attribute__((section(\".text.r\")));\n\
         int sect_fn(void) { return 6; }\n\
         int blk(void) { static int q __asm__(\"real_blk_q\") = 7; return q; }\n\
         int obj __asm__(\"real_obj\") = 5;\n\
         extern int ext_fn(void) __asm__(\"real_ext\");\n\
         extern int ext_obj __asm__(\"real_ext_obj\");\n\
         int *p __asm__(\"real_p\") = &ext_obj;\n\
         int use(void) { return fn() + stat_fn() + weak_fn() + hid_fn() + obj + ext_fn(); }\n",
        "a.o",
    );
    let sym = |n: &str| {
        a.symbols
            .iter()
            .find(|s| s.name == n)
            .unwrap_or_else(|| panic!("`{n}` missing from the symbol table"))
    };
    for name in [
        "real_fn",
        "real_stat",
        "real_weak",
        "real_hid",
        "real_obj",
        "real_ext",
        "real_ext_obj",
        "real_p",
        "real_sect",
        "real_blk_q",
    ] {
        sym(name);
    }
    // The identifier names nothing in the object.
    for ident in [
        "fn", "stat_fn", "weak_fn", "hid_fn", "obj", "ext_fn", "ext_obj", "p", "sect_fn", "q",
        "q.0",
    ] {
        assert!(
            !a.symbols.iter().any(|s| s.name == ident),
            "identifier `{ident}` must not reach the object"
        );
    }
    // The rename composes with, rather than replaces, the linkage and
    // visibility the declaration asked for.
    assert_eq!(sym("real_stat").binding, STB_LOCAL);
    assert_eq!(sym("real_weak").binding, STB_WEAK);
    assert_eq!(sym("real_hid").other & 0x3, STV_HIDDEN);
    assert!(matches!(sym("real_ext").sec, EtSymRef::Undef));
    // `section` places the renamed definition, and a block-scope static's
    // record takes the label outright instead of the `name.N` form.
    let sect = match sym("real_sect").sec {
        EtSymRef::Section(i) => a.sections[i].name.as_str(),
        _ => panic!("`real_sect` is not section-relative"),
    };
    assert_eq!(sect, ".text.r");
    assert_eq!(sym("real_blk_q").binding, STB_LOCAL);
    assert!(matches!(sym("real_ext_obj").sec, EtSymRef::Undef));
    // Every relocation resolves through the renamed symbol.
    let named: alloc::vec::Vec<&str> = a
        .sections
        .iter()
        .flat_map(|sec| sec.relocs.iter())
        .map(|r| a.symbols[r.sym as usize].name.as_str())
        .collect();
    assert!(named.contains(&"real_ext"), "call reloc names the label");
    assert!(
        named.contains(&"real_ext_obj"),
        "data reloc names the label"
    );
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
    let last_local = merged.symbols.iter().rposition(|s| s.binding == 0).unwrap();
    let first_global = merged.symbols.iter().position(|s| s.binding != 0).unwrap();
    assert!(last_local < first_global);
}

#[test]
fn discard_all_converts_local_relocs_to_section_relative() {
    use crate::c5::linker::relocatable::DiscardLocals;
    let a = compile_obj(
        "static int hidden = 9;\n\
         int reach(void) { return hidden; }\n",
        "a.o",
    );
    let merged = merge(
        &[a],
        &RelinkOptions {
            discard_locals: DiscardLocals::All,
            ..Default::default()
        },
    );
    assert!(
        !merged.symbols.iter().any(|s| s.name == "hidden"),
        "-x drops named locals"
    );
    // Every surviving relocation must reference a live symbol; the
    // one against `hidden` now goes through its section's symbol.
    for s in &merged.sections {
        for r in &s.relocs {
            let sym = &merged.symbols[r.sym as usize];
            assert!(
                sym.kind == 3 || !sym.name.is_empty(),
                "reloc target is a section symbol or a named symbol"
            );
        }
    }
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

/// A `.debug_info` reference to an object the script discarded
/// resolves to null instead of failing the link: the section describes
/// the image rather than taking part in it, which is how GNU ld treats
/// the same reference. The kernel's `__ADDRESSABLE` objects live in
/// `.discard.addressable` and every module link hits this.
#[test]
fn debug_reference_to_a_discarded_object_resolves_to_null() {
    let script = parse_module_script("SECTIONS {\n /DISCARD/ : { *(.discard) *(.discard.*) }\n}\n")
        .expect("parse script");
    let a = compile_obj_with_debug_info(
        "int target = 5;\n\
         static void *addressable __attribute__((used, section(\".discard.addressable\")))\n\
             = (void *)&target;\n\
         int probe(void) { return target; }\n",
        "a.o",
    );
    assert!(
        a.sections.iter().any(|s| s.name == ".discard.addressable"),
        "the object carries the section the script discards"
    );
    let merged = merge(
        &[a],
        &RelinkOptions {
            script: Some(script),
            ..Default::default()
        },
    );
    assert!(
        !merged
            .sections
            .iter()
            .any(|s| s.name == ".discard.addressable"),
        "the section is discarded"
    );
    let info = merged
        .sections
        .iter()
        .find(|s| s.name == ".debug_info")
        .expect("merged .debug_info");
    // Every surviving reference names a real symbol; the discarded one
    // became the null entry with a zero addend.
    for r in &info.relocs {
        if r.sym == 0 {
            assert_eq!(r.addend, 0, "a null reference carries no addend");
        }
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

/// Object-attribute sections hold one attribute set. Concatenating the
/// inputs' copies produces a section BFD rejects ("bad subsection
/// length"), so only the first is kept.
#[test]
fn object_attributes_are_kept_once_not_concatenated() {
    let attrs: Vec<u8> = {
        let mut v = alloc::vec![b'A'];
        let body = b"\x01\x00\x00\x00gnu\x00";
        v.extend_from_slice(&((body.len() + 4) as u32).to_le_bytes());
        v.extend_from_slice(body);
        v
    };
    let obj = |fname: &str, src: &str| -> EtRel {
        let mut o = compile_obj(&alloc::format!("int {fname}(void) {{ return 1; }}\n"), src);
        o.sections.push(EtSection {
            name: ".ARM.attributes".to_string(),
            sh_type: 0x7000_0003,
            flags: 0,
            addralign: 1,
            entsize: 0,
            bytes: attrs.clone(),
            nobits_size: 0,
            link_target: None,
            relocs: Vec::new(),
            group: None,
        });
        o
    };
    let bytes = link_relocatable(
        &[obj("f", "a.o"), obj("g", "b.o")],
        &RelinkOptions::default(),
    )
    .expect("link");
    let merged = parse_et_rel(&bytes, "merged").expect("parse merged");
    let sec = merged
        .sections
        .iter()
        .find(|s| s.name == ".ARM.attributes")
        .expect("attributes kept");
    assert_eq!(sec.bytes, attrs, "one attribute set, not two");
}

/// AArch64 build attributes merge per tag: `aeabi_feature_and_bits`
/// AND-s its tags across the inputs, and an input carrying no
/// attribute section withholds every bit. The expected bytes are what
/// `ld -r` (binutils 2.46) writes for the same inputs.
#[test]
fn aarch64_feature_bits_merge_per_tag_across_a_relocatable_link() {
    // 'A', subsection length, "aeabi_feature_and_bits\0", optional,
    // ULEB128, then Tag_Feature_BTI/PAC/GCS values.
    let attrs = |bti: u8, pac: u8, gcs: u8| -> Vec<u8> {
        let mut v = alloc::vec![b'A', 0x23, 0, 0, 0];
        v.extend_from_slice(b"aeabi_feature_and_bits\0\x01\x00");
        v.extend_from_slice(&[0, bti, 1, pac, 2, gcs]);
        v
    };
    let obj = |fname: &str, src: &str, body: Option<Vec<u8>>| -> EtRel {
        let mut o =
            compile_obj_aarch64(&alloc::format!("int {fname}(void) {{ return 1; }}\n"), src);
        if let Some(bytes) = body {
            o.sections.push(EtSection {
                name: ".ARM.attributes".to_string(),
                sh_type: 0x7000_0003,
                flags: 0,
                addralign: 1,
                entsize: 0,
                bytes,
                nobits_size: 0,
                link_target: None,
                relocs: Vec::new(),
                group: None,
            });
        }
        o
    };
    let opts = RelinkOptions {
        expect_machine: Some(EM_AARCH64),
        ..Default::default()
    };
    let merged_attrs = |objs: &[EtRel]| -> Vec<u8> {
        let bytes = link_relocatable(objs, &opts).expect("link");
        let merged = parse_et_rel(&bytes, "merged").expect("parse merged");
        merged
            .sections
            .iter()
            .find(|s| s.name == ".ARM.attributes")
            .expect("attributes kept")
            .bytes
            .clone()
    };
    assert_eq!(
        merged_attrs(&[
            obj("f", "a.o", Some(attrs(1, 1, 0))),
            obj("g", "b.o", Some(attrs(1, 0, 1))),
        ]),
        attrs(1, 0, 0),
        "each tag is AND-ed, not the first input's set kept"
    );
    assert_eq!(
        merged_attrs(&[obj("f", "a.o", Some(attrs(1, 1, 1))), obj("g", "b.o", None),]),
        attrs(0, 0, 0),
        "an input with no attribute section claims nothing"
    );
}

/// `ld -r` merges the inputs' property notes into one, the same way a
/// final link does: intersecting the feature bits and dropping what an
/// input withholds, rather than concatenating the notes.
#[test]
fn property_notes_merge_across_a_relocatable_link() {
    use crate::c5::linker::gnu_property::{self, Property};
    const AARCH64_FEATURE_1_AND: u32 = 0xc000_0000;
    const STACK_SIZE: u32 = 1;
    let note = |props: &[(u32, usize, u64)]| {
        gnu_property::encode(
            &props
                .iter()
                .map(|&(ty, datasz, value)| Property::number(ty, datasz, value))
                .collect::<Vec<_>>(),
            8,
        )
    };
    let obj = |fname: &str, src: &str, body: Vec<u8>| -> EtRel {
        let mut o = compile_obj(&alloc::format!("int {fname}(void) {{ return 1; }}\n"), src);
        o.sections.push(EtSection {
            name: ".note.gnu.property".to_string(),
            sh_type: 7,
            flags: 2,
            addralign: 8,
            entsize: 0,
            bytes: body,
            nobits_size: 0,
            link_target: None,
            relocs: Vec::new(),
            group: None,
        });
        o
    };
    // BTI|PAC against BTI, and a stack size the larger of which wins.
    // The unrecognized type leads, so a walk that stopped at it would
    // lose both properties behind it.
    let a = note(&[
        (0x10, 4, 0xaabb_ccdd),
        (STACK_SIZE, 8, 0x1000),
        (AARCH64_FEATURE_1_AND, 4, 0x3),
    ]);
    let b = note(&[(STACK_SIZE, 8, 0x2000), (AARCH64_FEATURE_1_AND, 4, 0x1)]);
    let bytes = link_relocatable(
        &[obj("f", "a.o", a), obj("g", "b.o", b)],
        &RelinkOptions::default(),
    )
    .expect("link");
    let merged = parse_et_rel(&bytes, "merged").expect("parse merged");
    let sec = merged
        .sections
        .iter()
        .find(|s| s.name == ".note.gnu.property")
        .expect("the merged note is emitted");
    assert_eq!(
        sec.bytes,
        note(&[(STACK_SIZE, 8, 0x2000), (AARCH64_FEATURE_1_AND, 4, 0x1)]),
        "one note holding the merge, not the inputs' concatenation"
    );
}

/// The compiler claims the branch protections it emitted, and only
/// those: the merge is an intersection, so a bit set by an object that
/// does not carry the instructions would disarm the whole image.
#[test]
fn a_hardened_object_carries_the_matching_property_note() {
    use crate::c5::linker::gnu_property::{self, Property};
    const AARCH64_FEATURE_1_AND: u32 = 0xc000_0000;
    const SRC: &str = "extern int g(int);\nint f(int x) { return g(x) + 1; }\n";
    let obj = |hardening: crate::Hardening| -> EtRel {
        let copts = CompileOptions {
            no_entry_point: true,
            ..Default::default()
        };
        let program = Compiler::with_options(SRC.to_string(), Target::LinuxAarch64, copts)
            .compile()
            .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            hardening,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
        parse_et_rel(&bytes, "o.o").expect("parse")
    };
    let note = |o: &EtRel| -> Option<Vec<u8>> {
        o.sections
            .iter()
            .find(|s| s.name == ".note.gnu.property")
            .map(|s| s.bytes.clone())
    };
    assert_eq!(
        note(&obj(crate::Hardening::NONE)),
        None,
        "an unhardened object claims nothing"
    );
    for (hardening, bits) in [
        (
            crate::Hardening {
                bti: true,
                ..crate::Hardening::NONE
            },
            1u64,
        ),
        (
            crate::Hardening {
                pac_ret: true,
                ..crate::Hardening::NONE
            },
            2,
        ),
        (
            crate::Hardening {
                bti: true,
                pac_ret: true,
                ..crate::Hardening::NONE
            },
            3,
        ),
    ] {
        let o = obj(hardening);
        assert_eq!(
            note(&o).as_deref(),
            Some(
                gnu_property::encode(&[Property::number(AARCH64_FEATURE_1_AND, 4, bits)], 8)
                    .as_slice()
            ),
            "the note the linker's own encoder would produce for {bits:#x}"
        );
        let sec = o
            .sections
            .iter()
            .find(|s| s.name == ".note.gnu.property")
            .expect("note section");
        assert_eq!(sec.sh_type, 7, "SHT_NOTE");
        assert_eq!(sec.flags & 2, 2, "SHF_ALLOC");
        assert_eq!(sec.addralign, 8, "ELF64 note alignment");
    }
}

#[test]
fn build_id_note_is_emitted_and_stable() {
    let a = compile_obj("int v(void) { return 2; }\n", "a.o");
    let opts = RelinkOptions {
        build_id_sha1: true,
        ..Default::default()
    };
    let one = link_relocatable(std::slice::from_ref(&a), &opts).expect("merge");
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
fn emit_relocs_survive_into_final_elf() {
    use crate::c5::linker::link::link_native_objects;
    use crate::c5::linker::object::parse_native_elf;
    use crate::c5::linker::{emit_x86_64_plt, write_native_image_from_merged_ex};

    let compile = |src: &str, no_entry: bool| {
        let copts = CompileOptions {
            no_entry_point: no_entry,
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
        parse_native_elf(&bytes).expect("parse")
    };
    let a = compile(
        "int helper(int n);\nint main(void) { return helper(3); }\n",
        false,
    );
    let b = compile(
        "int gval = 7;\nint helper(int n) { return n + gval; }\n",
        true,
    );
    let mut merged = link_native_objects(&[a, b]).expect("link");
    assert!(
        !merged.applied_text_relocs.is_empty(),
        "merge records the applied text relocations"
    );
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let image = |emit: bool| {
        write_native_image_from_merged_ex(
            &merged,
            &plt,
            "main",
            None,
            OutputKind::Executable,
            Target::LinuxX64,
            None,
            false,
            false,
            emit,
        )
        .expect("write")
    };
    let with = image(true);
    let without = image(false);
    let names = |b: &[u8]| {
        (
            b.windows(10).any(|w| w == b".rela.text"),
            b.windows(7).any(|w| w == b".symtab"),
        )
    };
    assert_eq!(names(&with), (true, true));
    assert!(!names(&without).0, "off by default");
    // The emitted .rela.text carries every applied entry; count the
    // SHT_RELA sections' entries whose sh_flags carry SHF_INFO_LINK
    // (the .rela.dyn dynamic section is SHF_ALLOC instead).
    use crate::c5::linker::object::{Elf64Ehdr, Elf64Shdr, read_struct};
    let ehdr: Elf64Ehdr = read_struct(&with, 0).unwrap();
    let mut emitted = 0usize;
    for i in 0..ehdr.e_shnum as usize {
        let sh: Elf64Shdr =
            read_struct(&with, ehdr.e_shoff as usize + i * ehdr.e_shentsize as usize).unwrap();
        if sh.sh_type == 4 && sh.sh_flags & 0x40 != 0 {
            emitted += (sh.sh_size / 24) as usize;
        }
    }
    assert!(
        emitted >= merged.applied_text_relocs.len(),
        "every applied reloc re-emitted ({emitted} entries)"
    );
}

/// Every relocatable ELF object carries the producer identification
/// in `.comment`, shaped as gcc and clang shape theirs: one
/// NUL-terminated line, SHF_MERGE | SHF_STRINGS with a byte entsize,
/// so a linker folds the identical line from many badc objects into
/// one copy in the linked image (a kernel keeps `.comment` in
/// vmlinux and module objects).
#[test]
fn comment_section_is_a_mergeable_single_line_identification() {
    use crate::c5::linker::object::{Elf64Ehdr, Elf64Shdr, read_struct};
    let copts = CompileOptions {
        no_entry_point: true,
        ..Default::default()
    };
    let program = Compiler::with_options("int f(void){return 1;}".into(), Target::LinuxX64, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let ehdr: Elf64Ehdr = read_struct(&bytes, 0).unwrap();
    let shstr: Elf64Shdr = read_struct(
        &bytes,
        ehdr.e_shoff as usize + ehdr.e_shstrndx as usize * ehdr.e_shentsize as usize,
    )
    .unwrap();
    let name_at = |off: usize| {
        let base = shstr.sh_offset as usize + off;
        let end = bytes[base..].iter().position(|&b| b == 0).unwrap() + base;
        core::str::from_utf8(&bytes[base..end]).unwrap()
    };
    let mut found = false;
    for i in 0..ehdr.e_shnum as usize {
        let sh: Elf64Shdr = read_struct(
            &bytes,
            ehdr.e_shoff as usize + i * ehdr.e_shentsize as usize,
        )
        .unwrap();
        if name_at(sh.sh_name as usize) != ".comment" {
            continue;
        }
        found = true;
        assert_eq!(sh.sh_type, 1, ".comment is SHT_PROGBITS");
        assert_eq!(sh.sh_flags, 0x30, ".comment is SHF_MERGE | SHF_STRINGS");
        assert_eq!(sh.sh_entsize, 1, ".comment merges byte strings");
        let content = &bytes[sh.sh_offset as usize..(sh.sh_offset + sh.sh_size) as usize];
        let mut want = alloc::vec![0u8];
        want.extend_from_slice(crate::OUTPUT_MARKER.as_bytes());
        want.push(0);
        assert_eq!(
            content, want,
            ".comment is the version line in GNU as string-pool shape"
        );
        assert!(
            !content.contains(&b'\n'),
            ".comment holds a single line, as `readelf -p` renders it"
        );
    }
    assert!(found, "no .comment section in the relocatable object");
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

// ---------------------------------------------- COMDAT / linkonce

/// One ET_REL input built section by section, for the group rules.
fn group_obj(source: &str, secs: &[(&str, u64, &[u8])]) -> EtRel {
    EtRel {
        source: source.to_string(),
        machine: 62,
        osabi: 0,
        abiversion: 0,
        eflags: 0,
        sections: secs
            .iter()
            .map(|(name, flags, bytes)| EtSection {
                name: name.to_string(),
                sh_type: 1,
                flags: *flags,
                addralign: 4,
                entsize: 0,
                bytes: bytes.to_vec(),
                nobits_size: 0,
                link_target: None,
                relocs: Vec::new(),
                group: None,
            })
            .collect(),
        symbols: Vec::new(),
        groups: Vec::new(),
    }
}

fn sym(name: &str, binding: u8, sec: usize, value: u64) -> EtSym {
    EtSym {
        name: name.to_string(),
        binding,
        kind: 2,
        other: 0,
        sec: EtSymRef::Section(sec),
        value,
        size: 0,
    }
}

const SHF_A: u64 = 0x2;
const SHF_AX: u64 = 0x6;
const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const R_X86_64_64: u32 = 1;

/// The relocatable merge deduplicates COMDAT groups on the signature
/// symbol's name, as a final link does: the later group loses every
/// member and the symbols it defined go with it.
#[test]
fn a_comdat_group_survives_a_relocatable_merge_once() {
    let unit = |source: &str, fill: u8, only: &str| {
        let mut o = group_obj(source, &[(".text.f", SHF_AX, &[fill; 8])]);
        o.symbols.push(sym("f", STB_GLOBAL, 0, 0));
        o.symbols.push(sym(only, STB_GLOBAL, 0, 4));
        o.groups.push(EtGroup {
            flags: 1,
            signature: "f".to_string(),
            members: alloc::vec![0],
        });
        o.sections[0].group = Some(0);
        o
    };
    let bytes = link_relocatable(
        &[unit("a.o", 0xa1, "aonly"), unit("b.o", 0xb1, "bonly")],
        &RelinkOptions::default(),
    )
    .expect("link");
    let merged = parse_et_rel(&bytes, "merged").expect("parse merged");
    let text = merged
        .sections
        .iter()
        .find(|s| s.name == ".text.f")
        .expect(".text.f");
    assert_eq!(text.bytes, alloc::vec![0xa1u8; 8], "the first copy stays");
    let names: Vec<&str> = merged.symbols.iter().map(|s| s.name.as_str()).collect();
    assert!(names.contains(&"aonly"), "{names:?}");
    assert!(
        !names.contains(&"bonly"),
        "a dropped member defines nothing"
    );
}

/// `.gnu.linkonce.*` deduplicates by section name here too. GNU ld's
/// `-r` keeps the first copy and drops the later one whole.
#[test]
fn gnu_linkonce_deduplicates_in_a_relocatable_merge() {
    let unit = |source: &str, fill: u8, only: &str| {
        let mut o = group_obj(source, &[(".gnu.linkonce.t.foo", SHF_AX, &[fill; 4])]);
        o.symbols.push(sym("foo", STB_GLOBAL, 0, 0));
        o.symbols.push(sym(only, STB_GLOBAL, 0, 2));
        o
    };
    let bytes = link_relocatable(
        &[unit("a.o", 0xa1, "aonly"), unit("b.o", 0xb1, "bonly")],
        &RelinkOptions::default(),
    )
    .expect("link");
    let merged = parse_et_rel(&bytes, "merged").expect("parse merged");
    let sec = merged
        .sections
        .iter()
        .find(|s| s.name == ".gnu.linkonce.t.foo")
        .expect("kept once");
    assert_eq!(sec.bytes, alloc::vec![0xa1u8; 4]);
    let names: Vec<&str> = merged.symbols.iter().map(|s| s.name.as_str()).collect();
    assert!(
        names.contains(&"aonly") && !names.contains(&"bonly"),
        "{names:?}"
    );
}

/// A local reference into a dropped member is reported rather than
/// redirected onto the surviving copy, which is what GNU ld's `-r`
/// does; the surviving group's contents need bear no relation to the
/// dropped one's.
#[test]
fn a_local_reference_into_a_dropped_group_fails_the_merge() {
    let unit = |source: &str, fill: u8, refs: bool| {
        let mut o = group_obj(
            source,
            &[
                (".text.f", SHF_AX, &[fill; 8]),
                (".data.b", SHF_A, &[0u8; 8]),
            ],
        );
        o.symbols.push(sym("f", STB_GLOBAL, 0, 0));
        o.symbols.push(sym("bloc", STB_LOCAL, 0, 4));
        o.groups.push(EtGroup {
            flags: 1,
            signature: "f".to_string(),
            members: alloc::vec![0],
        });
        o.sections[0].group = Some(0);
        if refs {
            o.sections[1].relocs.push(EtReloc {
                offset: 0,
                sym: 1,
                rtype: R_X86_64_64,
                addend: 0,
            });
        }
        o
    };
    let e = link_relocatable(
        &[unit("a.o", 0xa1, false), unit("b.o", 0xb1, true)],
        &RelinkOptions::default(),
    )
    .expect_err("the reference has nowhere to land");
    assert!(format!("{e}").contains("discarded local `bloc'"), "{e}");
}

// ------------------------------------------- raw ET_REL inspection

/// Section-header view over a written ET_REL image.
struct Img<'a> {
    b: &'a [u8],
}

impl<'a> Img<'a> {
    fn u16(&self, at: usize) -> u16 {
        u16::from_le_bytes(self.b[at..at + 2].try_into().unwrap())
    }
    fn u32(&self, at: usize) -> u32 {
        u32::from_le_bytes(self.b[at..at + 4].try_into().unwrap())
    }
    fn u64(&self, at: usize) -> u64 {
        u64::from_le_bytes(self.b[at..at + 8].try_into().unwrap())
    }
    fn shdr(&self, i: usize) -> usize {
        self.u64(40) as usize + i * self.u16(58) as usize
    }
    fn shnum(&self) -> usize {
        self.u16(60) as usize
    }
    fn body(&self, i: usize) -> &'a [u8] {
        let (off, size) = (
            self.u64(self.shdr(i) + 24) as usize,
            self.u64(self.shdr(i) + 32) as usize,
        );
        &self.b[off..off + size]
    }
}

/// Rewrite every `SHT_RELA` table into `SHT_REL` form: the addend
/// moves into the field the entry relocates, which is where a REL
/// producer keeps it. Bodies shrink in place, so the file keeps its
/// layout.
fn to_rel_form(bytes: &[u8]) -> Vec<u8> {
    use crate::c5::linker::object::elf_reloc_field_width;
    let mut out = bytes.to_vec();
    let img = Img { b: bytes };
    let machine = img.u16(18);
    for i in 1..img.shnum() {
        let sh = img.shdr(i);
        if img.u32(sh + 4) != 4 {
            continue; // not SHT_RELA
        }
        let target = img.shdr(img.u32(sh + 44) as usize);
        let (tgt_off, tgt_nobits) = (img.u64(target + 24) as usize, img.u32(target + 4) == 8);
        let body = img.body(i).to_vec();
        let mut rel: Vec<u8> = Vec::new();
        for e in body.as_chunks::<24>().0 {
            let r_offset = u64::from_le_bytes(e[0..8].try_into().unwrap());
            let r_info = u64::from_le_bytes(e[8..16].try_into().unwrap());
            let addend = i64::from_le_bytes(e[16..24].try_into().unwrap());
            let width = elf_reloc_field_width(machine, (r_info & 0xffff_ffff) as u32);
            if let Some(w) = width
                && !tgt_nobits
            {
                let at = tgt_off + r_offset as usize;
                out[at..at + w as usize].copy_from_slice(&addend.to_le_bytes()[..w as usize]);
            }
            rel.extend_from_slice(&r_offset.to_le_bytes());
            rel.extend_from_slice(&r_info.to_le_bytes());
        }
        let off = img.u64(sh + 24) as usize;
        out[off..off + rel.len()].copy_from_slice(&rel);
        out[sh + 4..sh + 8].copy_from_slice(&9u32.to_le_bytes()); // SHT_REL
        out[sh + 32..sh + 40].copy_from_slice(&(rel.len() as u64).to_le_bytes());
        out[sh + 56..sh + 64].copy_from_slice(&16u64.to_le_bytes());
    }
    out
}

/// A `SHT_REL` input reads the same as the `SHT_RELA` object it was
/// made from: every entry keeps its offset, symbol and type, and the
/// addend comes back out of the relocated field.
#[test]
fn sht_rel_inputs_take_their_addend_from_the_relocated_field() {
    let rela_bytes = compile_bytes(
        "extern int table[8];\n\
         int helper(int);\n\
         int pick(int n) { return table[n] + helper(n) + table[3]; }\n",
        Target::LinuxX64,
    );
    let rel_bytes = to_rel_form(&rela_bytes);
    let img = Img { b: &rel_bytes };
    assert!(
        (1..img.shnum()).any(|i| img.u32(img.shdr(i) + 4) == 9),
        "the input carries SHT_REL tables"
    );
    assert!(
        !(1..img.shnum()).any(|i| img.u32(img.shdr(i) + 4) == 4),
        "and no SHT_RELA table is left"
    );

    let rela = parse_et_rel(&rela_bytes, "a.o").expect("parse RELA");
    let rel = parse_et_rel(&rel_bytes, "a.o").expect("parse REL");
    let entries = |o: &EtRel| -> Vec<(String, u64, u32, u32, i64)> {
        o.sections
            .iter()
            .flat_map(|s| {
                s.relocs
                    .iter()
                    .map(move |r| (s.name.clone(), r.offset, r.sym, r.rtype, r.addend))
            })
            .collect()
    };
    assert!(entries(&rela).iter().any(|e| e.4 != 0), "addends to recover");
    assert_eq!(entries(&rela), entries(&rel));

    // Both forms merge to the same tables: the output is RELA
    // whatever the input carried. Only the relocated fields differ,
    // and a RELA consumer overwrites those.
    let opts = RelinkOptions::default();
    let merge_of = |o: EtRel| {
        let bytes = link_relocatable(&[o], &opts).expect("link");
        parse_et_rel(&bytes, "merged").expect("parse merged")
    };
    let (ma, mb) = (merge_of(rela), merge_of(rel));
    assert_eq!(entries(&ma), entries(&mb));
    let names = |o: &EtRel| -> Vec<String> { o.symbols.iter().map(|s| s.name.clone()).collect() };
    assert_eq!(names(&ma), names(&mb));
}

/// An aarch64 instruction relocation splits its value across an
/// encoding, so a `SHT_REL` entry has no field to read an addend from.
/// The input is declined by name rather than reported as a badc bug.
#[test]
fn an_aarch64_instruction_relocation_has_no_implicit_addend() {
    let bytes = compile_bytes(
        "int helper(int);\nint entry(int n) { return helper(n); }\n",
        Target::LinuxAarch64,
    );
    let e = parse_et_rel(&to_rel_form(&bytes), "a.o").expect_err("no field to read");
    let msg = alloc::format!("{e}");
    assert!(msg.contains("has no implicit-addend field"), "{msg}");
    assert!(msg.contains("R_AARCH64_"), "{msg}");
    assert!(!msg.contains("internal compiler error"), "{msg}");
}

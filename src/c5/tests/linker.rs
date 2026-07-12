//! Native-path linker tests.
//!
//! Each test compiles one or more inline sources to ELF64 ET_REL
//! through `emit_native_with_options`, recovers them with
//! `parse_native_elf`, and merges them with `link_native_objects`,
//! asserting on the resulting `MergedNative` (dead-code elimination,
//! `_Thread_local` layout, `#pragma export` / dylib routing) or on
//! the final image written by `write_native_image_from_merged`.

use super::TEST_PRELUDE;
use crate::c5::Compiler;

#[test]
fn transitively_dead_static_chain_is_dropped_from_object() {
    // A static helper `a` that calls another static `b`. Nothing
    // in the TU references `a`, so `a`, `b`, and everything else
    // reachable only from `a` should drop. The parser's lexical
    // `was_referenced` flag would keep `b` alive (its callee
    // reference is set when `a`'s body is parsed); the codegen's
    // transitive reachability pass over `Inst::Call` /
    // `Inst::ImmCode` recovers the dead status.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "\
         static int dead_leaf(int x) { return x + 1; }\n\
         static int dead_caller(int x) { return dead_leaf(x) * 2; }\n\
         int main(void) { return 0; }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let has_leaf = bytes.windows(9).any(|w| w == b"dead_leaf");
    let has_caller = bytes.windows(11).any(|w| w == b"dead_caller");
    assert!(!has_leaf, "transitively-dead leaf must drop");
    assert!(!has_caller, "lexically-dead caller must drop");
}

#[test]
fn address_taken_static_survives_dce() {
    // A static function whose address is stored in a global
    // function-pointer table must survive DCE: the table entry
    // becomes a `program.code_relocs` root. Mirrors the vtable
    // pattern (`static const VTable v = { .fp = doubled };`).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "\
         static int doubled(int n) { return n + n; }\n\
         typedef int (*fp_t)(int);\n\
         const fp_t vtable[] = { doubled };\n\
         int main(void) { return vtable[0](21); }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let has_doubled = bytes.windows(7).any(|w| w == b"doubled");
    assert!(
        has_doubled,
        "address-taken static must survive DCE via code_relocs root"
    );
}

#[test]
fn block_scope_externs_emit_distinct_undef_symbols() {
    // C99 6.2.2p4: a block-scope `extern` declaration has external
    // linkage and refers to the file-scope object of the same name in
    // another unit. Taking the address of several such declarations must
    // produce a distinct named relocation per object. The bug was that
    // the block-scope path set `class=Glo` + `is_extern_decl` but not
    // `linkage=External`, so `live_glo_addr` fell back to the tentative
    // `val` (0) and every `&name` collapsed onto the same `.data` base.
    // Each distinct extern must surface as its own undefined symbol.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        "void use3(char *a, char *b, char *c);\n\
         int main(void) {\n\
         extern int g1;\n\
         extern int g2;\n\
         extern int g3;\n\
         use3((char *)&g1, (char *)&g2, (char *)&g3);\n\
         return 0;\n\
         }\n"
        .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    use crate::c5::linker::object::NativeSymSection;
    for name in ["g1", "g2", "g3"] {
        let found = obj
            .symbols
            .iter()
            .any(|s| s.name == name && matches!(s.section, NativeSymSection::Undef));
        assert!(
            found,
            "block-scope extern `{name}` must emit its own undefined data symbol"
        );
    }
}

#[test]
fn nested_block_externs_emit_distinct_undef_symbols() {
    // Same as the body-top case, but the `extern` declarations sit in a
    // nested `{ }`. That path consumed `extern` as a no-op and allocated
    // a local for the declarator; it must instead register an external
    // reference so the address resolves to the defining unit's object.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        "void use3(char *a, char *b, char *c);\n\
         int main(void) {\n\
         {\n\
         extern int n1;\n\
         extern int n2;\n\
         extern int n3;\n\
         use3((char *)&n1, (char *)&n2, (char *)&n3);\n\
         }\n\
         return 0;\n\
         }\n"
        .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    for name in ["n1", "n2", "n3"] {
        let found = obj
            .symbols
            .iter()
            .any(|s| s.name == name && matches!(s.section, NativeSymSection::Undef));
        assert!(
            found,
            "nested-block extern `{name}` must emit its own undefined data symbol"
        );
    }
}

#[test]
fn cross_tu_thread_local_resolves_by_symbol() {
    // A `_Thread_local` defined in one unit and accessed in another via
    // `extern _Thread_local` resolves by symbol against the merged TLS
    // block. The accessor must not reserve its own TLS storage (a phantom
    // per-unit copy), and its Mach-O TLV descriptor must be keyed by the
    // variable name so the linker fills the per-thread offset from the
    // defining unit. macOS arm64 uses the TLV descriptor model.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let unit = |src: &str| {
        let prog = Compiler::with_options(
            src.to_string(),
            Target::MacOSAarch64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let bytes = emit_native_with_options(&prog, Target::MacOSAarch64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse")
    };

    // Definer: `other` sits at TLS offset 4 (after `counter` at 0).
    let def = unit(
        "#include <stdlib.h>\n\
         _Thread_local int counter = 7;\n\
         _Thread_local int other = 3;\n\
         int read_other(void) { return other; }\n",
    );
    let off_other = def
        .tls_symbols
        .iter()
        .find(|(n, _, _)| n == "other")
        .map(|(_, off, _)| *off)
        .expect("definer exports `other` as a TLS symbol");
    assert_eq!(
        off_other, 8,
        "`other` follows the 8-byte-aligned `counter` slot"
    );

    // Accessor: references `other` but defines no TLS storage.
    let acc = unit(
        "#include <stdlib.h>\n\
         extern _Thread_local int other;\n\
         int get_other(void) { return other; }\n",
    );
    assert!(
        acc.tls_data.is_empty() && acc.tls_bss_size == 0,
        "an extern _Thread_local reference must not reserve storage"
    );
    assert!(
        acc.macho_tlv_descriptor_syms
            .iter()
            .any(|(_, name)| name == "other"),
        "the cross-unit access must be a symbol-keyed TLV descriptor"
    );

    // The link resolves the accessor's descriptor to `other`'s merged
    // offset (4): the definer is the only TLS contributor, base 0.
    let merged = link_native_objects(&[def, acc]).expect("link resolves cross-unit TLS");
    assert!(
        merged.macho_tlv_descriptors.contains(&8),
        "the accessor's `other` descriptor must resolve to offset 8, got {:?}",
        merged.macho_tlv_descriptors,
    );
}

#[test]
fn cross_tu_thread_local_resolves_by_symbol_windows_aarch64() {
    // The Windows/aarch64 analogue of the cross-unit TLS resolve. The
    // access reaches the variable through the TEB's TLS array
    // (`ldr x16, [x18, #0x58]`, index by `_tls_index`), so the accessor
    // records both a `_tls_index` fixup and an extern TLS-offset fixup
    // (reusing the `elf_tpoff_fixups` channel) keyed by the variable name.
    // The linker fills the `add x?, x16, #imm12` with the variable's raw
    // offset in the merged TLS block -- no thread-pointer bias, unlike the
    // variant-1 ELF path's `+16` -- so the patched immediate equals the
    // merged offset directly.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::object::ElfTpoffTarget;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let unit = |src: &str| {
        let prog = Compiler::with_options(
            src.to_string(),
            Target::WindowsAarch64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let bytes = emit_native_with_options(&prog, Target::WindowsAarch64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse")
    };

    let def = unit(
        "#include <stdlib.h>\n\
         _Thread_local int counter = 7;\n\
         _Thread_local int other = 3;\n\
         int read_other(void) { return other; }\n",
    );
    let off_other = def
        .tls_symbols
        .iter()
        .find(|(n, _, _)| n == "other")
        .map(|(_, off, _)| *off)
        .expect("definer exports `other` as a TLS symbol");
    assert_eq!(off_other, 8, "`other` follows the 8-byte-aligned `counter`");

    let acc = unit(
        "#include <stdlib.h>\n\
         extern _Thread_local int other;\n\
         int get_other(void) { return other; }\n",
    );
    assert!(
        acc.tls_data.is_empty() && acc.tls_bss_size == 0,
        "an extern _Thread_local reference must not reserve storage"
    );
    assert!(
        !acc.tls_index_fixups.is_empty(),
        "the Windows TEB access must record a `_tls_index` fixup"
    );
    assert!(
        acc.elf_tpoff_fixups
            .iter()
            .any(|(_, t)| matches!(t, ElfTpoffTarget::Extern(name) if name == "other")),
        "the cross-unit access must record an extern TLS-offset fixup for `other`"
    );

    let merged = link_native_objects(&[acc, def]).expect("link resolves cross-unit Windows TLS");

    // Scan the merged `.text` for the TEB sequence and confirm its closing
    // `add x?, x16, #imm12` was patched to `other`'s merged offset (8): the
    // definer is the only TLS contributor (base 0) and `counter` precedes
    // it. The raw offset (not `8 + 16`) proves the Windows bias.
    const TEB_LOAD: u32 = 0xF940_2E50; // ldr x16, [x18, #0x58]
    let text = &merged.text;
    let mut patched = None;
    let mut i = 0;
    while i + 20 <= text.len() {
        let w = u32::from_le_bytes(text[i..i + 4].try_into().unwrap());
        if w == TEB_LOAD {
            let a = u32::from_le_bytes(text[i + 16..i + 20].try_into().unwrap());
            if (a & 0xFF80_0000) == 0x9100_0000 && (a >> 5) & 0x1F == 16 {
                patched = Some((a >> 10) & 0xFFF);
                break;
            }
        }
        i += 4;
    }
    assert_eq!(
        patched,
        Some(off_other as u32),
        "the TEB `add x?, x16, #imm12` must hold the raw merged offset {off_other} (no +16 bias)"
    );
}

#[test]
fn pointer_to_extern_data_resolves_cross_tu() {
    // `int *p = &g;` / `int *p = arr;` where the target is defined in
    // another unit must emit a `.rela.data` reloc against the named
    // undefined data symbol, not against this unit's `.data` section, so
    // the link resolves it to the defining unit's storage. Before the
    // fix the slot held this unit's `.data` base.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let prog_a = Compiler::with_options(
        "extern int g;\nextern int arr[];\nint *ps = &g;\nint *pa = &arr[1];\nint *pd = arr;\n"
            .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile a");
    let bytes_a = emit_native_with_options(&prog_a, Target::LinuxX64, opts).expect("emit a");
    let obj_a = parse_native_elf(&bytes_a).expect("parse a");

    // `g` and `arr` are undefined data symbols, and every `.rela.data`
    // entry targets one of them by name rather than the `.data` section.
    for name in ["g", "arr"] {
        assert!(
            obj_a
                .symbols
                .iter()
                .any(|s| s.name == name && matches!(s.section, NativeSymSection::Undef)),
            "`{name}` must be an undefined data symbol"
        );
    }
    assert_eq!(
        obj_a.data_relocs.len(),
        3,
        "three pointer-to-extern-data slots must each emit a reloc"
    );
    for r in &obj_a.data_relocs {
        let target = &obj_a.symbols[r.sym_idx].name;
        assert!(
            target == "g" || target == "arr",
            "extern-data reloc must target the named symbol, got `{target}`"
        );
    }

    // The defining unit links cleanly against the references.
    let prog_b = Compiler::with_options(
        "int g = 77;\nint arr[3] = {11, 22, 33};\n".to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile b");
    let bytes_b = emit_native_with_options(&prog_b, Target::LinuxX64, opts).expect("emit b");
    let obj_b = parse_native_elf(&bytes_b).expect("parse b");
    link_native_objects(&[obj_a, obj_b]).expect("link resolves the extern-data references");
}

#[test]
fn extern_data_address_in_struct_initializer_resolves_cross_tu() {
    // `&g` for a cross-unit `extern` target inside a brace-list / struct
    // initializer must emit a named relocation against the undefined
    // symbol, the same as the scalar `T *p = &g;` path. Before the fix
    // it resolved against this unit's `.data` section + the extern's
    // permissive local fallback offset, pointing into the wrong unit.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let prog_a = Compiler::with_options(
        "struct Obj { long refcnt; struct Obj *type; };\n\
         extern struct Obj TheType;\n\
         struct Obj inst = { 1, &TheType };\n"
            .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile a");
    let bytes_a = emit_native_with_options(&prog_a, Target::LinuxX64, opts).expect("emit a");
    let obj_a = parse_native_elf(&bytes_a).expect("parse a");

    assert!(
        obj_a
            .symbols
            .iter()
            .any(|s| s.name == "TheType" && matches!(s.section, NativeSymSection::Undef)),
        "`TheType` must be an undefined data symbol, not a local fallback"
    );
    assert!(
        obj_a
            .data_relocs
            .iter()
            .any(|r| obj_a.symbols[r.sym_idx].name == "TheType"),
        "the struct-initializer `&TheType` must emit a named reloc against `TheType`"
    );

    let prog_b = Compiler::with_options(
        "struct Obj { long refcnt; struct Obj *type; };\n\
         struct Obj TheType = { 9, 0 };\n"
            .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile b");
    let bytes_b = emit_native_with_options(&prog_b, Target::LinuxX64, opts).expect("emit b");
    let obj_b = parse_native_elf(&bytes_b).expect("parse b");
    link_native_objects(&[obj_a, obj_b]).expect("link resolves the struct-init extern reference");
}

#[test]
fn libc_address_trampoline_is_per_tu_local() {
    // Two translation units that each take the address of the same
    // libc function in a `.data` function-pointer table both emit a
    // synthetic `__c5_sys_exp` forwarding trampoline. The trampoline
    // is referenced only within its own unit (via a `.text`-section
    // reloc carrying its byte offset, not by name), so it must have
    // internal linkage; binding it STB_GLOBAL would make the merge
    // reject the second definition. Verifies the per-TU local
    // classification in `elf_reloc::write_relocatable`.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let unit = |table: &str, extra: &str| {
        let program = Compiler::with_options(
            alloc::format!(
                "#include <math.h>\n\
                 typedef double (*mathfn)(double);\n\
                 const mathfn {table}[] = {{ exp, log }};\n\
                 {extra}"
            ),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse ET_REL")
    };
    let a = unit(
        "a_tbl",
        "double call_a(int i, double x) { return a_tbl[i](x); }\n",
    );
    let b = unit(
        "b_tbl",
        "double call_a(int i, double x);\n\
         int main(void) { return call_a(0, 0.0) == 1.0 ? 0 : 1; }\n",
    );
    // The merge must not reject the duplicate `__c5_sys_exp` /
    // `__c5_sys_log` trampolines.
    let merged = link_native_objects(&[a, b]).expect("link must not collide on libc trampolines");
    // Each unit kept its own local copy: the merged static-function
    // list carries the trampoline name from both units.
    let exp_copies = merged
        .local_funcs
        .iter()
        .filter(|(n, _)| n == "__c5_sys_exp")
        .count();
    assert!(
        exp_copies >= 2,
        "each TU must keep its own local __c5_sys_exp trampoline, got {exp_copies}"
    );
}

#[test]
fn unreferenced_static_function_is_dropped_from_object() {
    // C99 6.2.2p3: a file-scope `static` function has internal
    // linkage and is reachable only from the current TU. The
    // parser already emits a `warn_unused_static_functions`
    // diagnostic when no in-TU call site references it; the
    // codegen also drops the body so the resulting object
    // doesn't carry dead code. Verifies the
    // `function_is_unreachable_static` gate in `walk_program`.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         static int unused_helper(int x) {{ return x * 2; }}\n\
         static int used_helper(int x) {{ return x + 1; }}\n\
         int main(void) {{ return used_helper(41); }}\n"
    ))
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    // Walk for the function names by byte-substring lookup; the
    // strtab carries them as NUL-terminated entries among the
    // section header / symbol-table bytes.
    let has_used = bytes.windows(11).any(|w| w == b"used_helper");
    let has_unused = bytes.windows(13).any(|w| w == b"unused_helper");
    assert!(
        has_used,
        "reachable static helper must survive into the object"
    );
    assert!(
        !has_unused,
        "unreachable static helper must not appear in the object"
    );
}

#[test]
fn thread_local_storage_round_trips_through_et_rel() {
    // `_Thread_local` storage now rides the native ET_REL object:
    // elf_reloc emits `.tdata` (initialised slice) + `.tbss`
    // (zero-fill remainder), and `parse_native_elf` concatenates
    // them back into `tls_data` / `tls_bss_size`. Verifies the
    // bytes survive the write -> parse round-trip; the link-time
    // PT_TLS layout is guarded separately until it lands.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         _Thread_local int counter = 7;\n\
         int main(void) {{ counter += 1; return counter; }}\n"
    ))
    .compile()
    .expect("compile");
    assert!(
        !program.tls_data.is_empty(),
        "source declares `_Thread_local`, so tls_data must be non-empty"
    );
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    assert!(
        bytes.windows(6).any(|w| w == b".tdata"),
        "ET_REL must carry a `.tdata` section header name"
    );
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let total = obj.tls_data.len() + obj.tls_bss_size;
    assert_eq!(
        total,
        program.tls_data.len(),
        "round-tripped TLS size (tdata + tbss) must match the source's tls_data",
    );
    // `counter = 7` is a 4-byte initialised int; its little-endian
    // image leads the `.tdata` bytes.
    assert!(
        obj.tls_data.starts_with(&7i32.to_le_bytes()),
        "initialised TLS byte image must round-trip; got {:?}",
        obj.tls_data,
    );
}

#[test]
fn thread_local_storage_links_into_pt_tls_executable() {
    // A single `_Thread_local`-bearing object links through the
    // native path into an executable with a PT_TLS segment. The
    // local-exec tpoff baked into `.text` stays valid because the
    // merged TLS block keeps the source's size: `link_native_objects`
    // carries the single unit's `tls_data` / `tls_init_size` forward
    // and `write_native_image_from_merged` lays out PT_TLS from them.
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         _Thread_local int counter = 7;\n\
         int main(void) {{ counter += 1; return counter; }}\n"
    ))
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    assert_eq!(
        merged.tls_init_size, program.tls_init_size,
        "merged tls_init_size must match the source's"
    );
    assert_eq!(
        merged.tls_data.len(),
        program.tls_data.len(),
        "merged tls_data length must match the source's total TLS size"
    );
    assert!(
        merged.tls_data.starts_with(&7i32.to_le_bytes()),
        "initialised TLS image must survive the merge"
    );
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let exe = write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        OutputKind::Executable,
        Target::LinuxX64,
        None,
    )
    .expect("write executable");
    // ELF64: e_phoff @ 0x20 (u64), e_phentsize @ 0x36 (u16),
    // e_phnum @ 0x38 (u16). Scan the program header table for a
    // PT_TLS (p_type == 7) whose p_filesz covers the 4-byte int.
    let phoff = u64::from_le_bytes(exe[0x20..0x28].try_into().unwrap()) as usize;
    let phentsize = u16::from_le_bytes(exe[0x36..0x38].try_into().unwrap()) as usize;
    let phnum = u16::from_le_bytes(exe[0x38..0x3a].try_into().unwrap()) as usize;
    const PT_TLS: u32 = 7;
    let pt_tls = (0..phnum).find_map(|i| {
        let base = phoff + i * phentsize;
        let p_type = u32::from_le_bytes(exe[base..base + 4].try_into().unwrap());
        if p_type == PT_TLS {
            // p_filesz @ +0x20, p_memsz @ +0x28 within the phdr.
            let p_filesz = u64::from_le_bytes(exe[base + 0x20..base + 0x28].try_into().unwrap());
            let p_memsz = u64::from_le_bytes(exe[base + 0x28..base + 0x30].try_into().unwrap());
            Some((p_filesz, p_memsz))
        } else {
            None
        }
    });
    let (p_filesz, p_memsz) = pt_tls.expect("executable must carry a PT_TLS segment");
    assert_eq!(
        p_filesz, program.tls_init_size as u64,
        "PT_TLS p_filesz must equal the initialised TLS image size"
    );
    assert_eq!(
        p_memsz,
        program.tls_data.len() as u64,
        "PT_TLS p_memsz must cover the full per-thread TLS block"
    );
}

#[test]
fn macho_tlv_descriptors_round_trip_through_et_rel() {
    // A macOS `_Thread_local` access lowers to a TLV-descriptor call
    // whose descriptor offset + adrp fixup ride the ET_REL
    // `.note.badc` NT_BADC_MACHO_TLV_DESC / NT_BADC_MACHO_TLV_FIXUP
    // records. parse_native_elf recovers them and link_native_objects
    // rebases the fixups into the merged `.text`, so the Mach-O writer
    // materialises the `__thread_vars` descriptors.
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        alloc::format!(
            "{TEST_PRELUDE}\
             _Thread_local int counter = 7;\n\
             int main(void) {{ counter += 1; return counter; }}\n"
        ),
        Target::MacOSAarch64,
        crate::c5::CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        !obj.macho_tlv_descriptors.is_empty(),
        "the macOS `_Thread_local` variable must surface a TLV descriptor via the note"
    );
    assert!(
        !obj.macho_tlv_fixups.is_empty(),
        "the macOS `_Thread_local` access must surface a TLV fixup via the note"
    );
    let nd = obj.macho_tlv_descriptors.len();
    let nf = obj.macho_tlv_fixups.len();
    let merged = link_native_objects(&[obj]).expect("link");
    assert_eq!(merged.macho_tlv_descriptors.len(), nd);
    assert_eq!(merged.macho_tlv_fixups.len(), nf);
}

#[test]
fn win64_tls_index_fixups_round_trip_through_et_rel() {
    // A Windows `_Thread_local` access lowers to a `_tls_index` TEB
    // lookup whose fixup site rides the ET_REL `.note.badc`
    // NT_BADC_TLS_INDEX record. parse_native_elf recovers the byte
    // offsets and link_native_objects rebases them into the merged
    // `.text`, so the PE writer can patch each site.
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        alloc::format!(
            "{TEST_PRELUDE}\
             _Thread_local int counter = 7;\n\
             int main(void) {{ counter += 1; return counter; }}\n"
        ),
        Target::WindowsAarch64,
        crate::c5::CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::WindowsAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        !obj.tls_index_fixups.is_empty(),
        "the Windows `_Thread_local` access must surface a tls_index fixup via the note"
    );
    let n = obj.tls_index_fixups.len();
    let merged = link_native_objects(&[obj]).expect("link");
    assert_eq!(
        merged.tls_index_fixups.len(),
        n,
        "the linker must carry every tls_index fixup into the merged image"
    );
}

#[test]
fn pragma_export_round_trips_into_shared_library() {
    // `#pragma export(<name>)` rides the ET_REL `.note.badc`
    // NT_BADC_EXPORTS record: `parse_native_elf` recovers the name,
    // `link_native_objects` unions it, and the shared-library writer
    // promotes only the exported name. A symbol not named by the
    // pragma stays private.
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         #pragma export(exported_fn)\n\
         int exported_fn(int x) {{ return x + 1; }}\n\
         int internal_fn(int x) {{ return x + 2; }}\n\
         int main(void) {{ return exported_fn(1) + internal_fn(1); }}\n"
    ))
    .compile()
    .expect("compile");
    assert!(
        program.exports.iter().any(|e| e.name == "exported_fn"),
        "compiler must record the `#pragma export` name"
    );
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        obj.exports.contains(&"exported_fn".to_string()),
        "export name must round-trip through the `.note.badc` record"
    );
    assert!(
        !obj.exports.contains(&"internal_fn".to_string()),
        "a symbol not named by `#pragma export` must not appear in the note"
    );
    let mut merged = link_native_objects(&[obj]).expect("link");
    assert_eq!(
        merged.exports,
        alloc::vec!["exported_fn".to_string()],
        "linker unions only the exported names"
    );
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let so = write_native_image_from_merged(
        &merged,
        &plt,
        "",
        None,
        OutputKind::SharedLibrary,
        Target::LinuxX64,
        None,
    )
    .expect("write shared library");
    // e_type @ 0x10: ET_DYN (3) for a shared object.
    assert_eq!(
        u16::from_le_bytes(so[0x10..0x12].try_into().unwrap()),
        3,
        "shared library must be ET_DYN"
    );
}

#[test]
fn export_all_executable_exposes_dynamic_symbols() {
    // The same exports go into an executable's `.dynsym` (the
    // `-rdynamic` behavior) so a `dlopen`'d module resolves the host's
    // symbols from the global scope. An `--export-all` executable is
    // ET_EXEC and carries its exported symbol name; an ordinary
    // executable does not export it.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let build_exe = |export_all: bool| -> alloc::vec::Vec<u8> {
        let copts = CompileOptions::default().with_export_all_functions(export_all);
        let program = Compiler::with_options(
            alloc::format!(
                "{TEST_PRELUDE}\
                 int host_api(int x) {{ return x + 1; }}\n\
                 int main(void) {{ return host_api(0); }}\n"
            ),
            Target::LinuxX64,
            copts,
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        let mut merged = link_native_objects(&[obj]).expect("link");
        let plt = emit_x86_64_plt(&mut merged).expect("plt");
        write_native_image_from_merged(
            &merged,
            &plt,
            "main",
            None,
            OutputKind::Executable,
            Target::LinuxX64,
            None,
        )
        .expect("write executable")
    };
    // `.symtab` carries `host_api` in every executable; only a
    // `.dynsym` entry is visible to a `dlopen`'d module, so read the
    // dynamic table through the linker's ELF record reader.
    use crate::c5::linker::object::{read_dynamic_symbol_names, read_elf_header};
    let exported = build_exe(true);
    assert_eq!(
        read_elf_header(&exported).expect("read header").e_type,
        3,
        "executable must be ET_DYN (PIE)"
    );
    assert!(
        read_dynamic_symbol_names(&exported)
            .expect("parse .dynsym")
            .iter()
            .any(|n| n == "host_api"),
        "an --export-all executable must export host_api in .dynsym"
    );
    assert!(
        !read_dynamic_symbol_names(&build_exe(false))
            .expect("parse .dynsym")
            .iter()
            .any(|n| n == "host_api"),
        "an ordinary executable must not export host_api dynamically"
    );
}

#[test]
fn export_data_exposes_data_globals_in_dynsym() {
    // `--export-data` adds an executable's defined data globals to
    // `.dynsym` (as STT_OBJECT) so a `dlopen`'d module resolves them --
    // the data half of `-rdynamic`, which `--export-all` (functions
    // only) cannot reach. An exported data-object global is the motivating
    // case. An executable without the flag exports no data symbol.
    use crate::c5::linker::object::read_dynamic_symbol_names;
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged_ex,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let build_exe = |export_data: bool| -> alloc::vec::Vec<u8> {
        let program = Compiler::new(alloc::format!(
            "{TEST_PRELUDE}\
             int host_data = 7;\n\
             int main(void) {{ return host_data; }}\n"
        ))
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        let mut merged = link_native_objects(&[obj]).expect("link");
        let plt = emit_x86_64_plt(&mut merged).expect("plt");
        write_native_image_from_merged_ex(
            &merged,
            &plt,
            "main",
            None,
            OutputKind::Executable,
            Target::LinuxX64,
            None,
            false,
            export_data,
        )
        .expect("write executable")
    };
    assert!(
        read_dynamic_symbol_names(&build_exe(true))
            .expect("parse .dynsym")
            .iter()
            .any(|n| n == "host_data"),
        "an --export-data executable must export host_data in .dynsym"
    );
    assert!(
        !read_dynamic_symbol_names(&build_exe(false))
            .expect("parse .dynsym")
            .iter()
            .any(|n| n == "host_data"),
        "an executable without --export-data must not export host_data"
    );
}

#[test]
fn macho_executable_exports_globals_through_dyld_info_trie() {
    // macOS publishes every global of an executable so a dlopen'd module
    // resolves them against the host. dyld resolves an image carrying
    // LC_DYLD_INFO exclusively through the export trie -- a symtab-only
    // entry is invisible to it -- so a text and a data global must both
    // resolve through the trie at their symtab addresses.
    use crate::c5::linker::{
        emit_aarch64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        alloc::format!(
            "{TEST_PRELUDE}\
             int host_data = 7;\n\
             int host_api(int x) {{ return x + host_data; }}\n\
             int main(void) {{ return host_api(0); }}\n"
        ),
        Target::MacOSAarch64,
        CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_aarch64_plt(&mut merged).expect("plt");
    let exe = write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        OutputKind::Executable,
        Target::MacOSAarch64,
        None,
    )
    .expect("write executable");

    fn uleb(buf: &[u8], p: &mut usize) -> u64 {
        let (mut v, mut shift) = (0u64, 0);
        loop {
            let b = buf[*p];
            *p += 1;
            v |= ((b & 0x7F) as u64) << shift;
            if b & 0x80 == 0 {
                return v;
            }
            shift += 7;
        }
    }
    fn trie_lookup(trie: &[u8], name: &str) -> Option<u64> {
        let bytes = name.as_bytes();
        let (mut node, mut pos) = (0usize, 0usize);
        loop {
            let mut p = node;
            let term_size = uleb(trie, &mut p) as usize;
            if pos == bytes.len() {
                if term_size == 0 {
                    return None;
                }
                let _flags = uleb(trie, &mut p);
                return Some(uleb(trie, &mut p));
            }
            p += term_size;
            let child_count = trie[p];
            p += 1;
            let mut next = None;
            for _ in 0..child_count {
                let start = p;
                while trie[p] != 0 {
                    p += 1;
                }
                let label = &trie[start..p];
                p += 1;
                let child = uleb(trie, &mut p) as usize;
                if bytes[pos..].starts_with(label) {
                    next = Some((label.len(), child));
                    break;
                }
            }
            match next {
                Some((len, child)) => {
                    pos += len;
                    node = child;
                }
                None => return None,
            }
        }
    }

    let read_u32 = |off: usize| u32::from_le_bytes(exe[off..off + 4].try_into().unwrap());
    let read_u64 = |off: usize| u64::from_le_bytes(exe[off..off + 8].try_into().unwrap());
    assert_eq!(read_u32(0), 0xfeed_facf, "executable must be MH_MAGIC_64");
    // Walk the load commands for LC_DYLD_INFO_ONLY (export_off/size at
    // +40/+44), LC_SYMTAB (symoff/nsyms/stroff at +8/+12/+16), and the
    // __TEXT segment vmaddr (image base; trie addresses are relative to it).
    let sizeofcmds = read_u32(20) as usize;
    let (mut export_range, mut symtab_loc, mut image_base) = (None, None, None);
    let mut p = 32usize;
    while p < 32 + sizeofcmds {
        match read_u32(p) {
            0x8000_0022 => {
                export_range = Some((read_u32(p + 40) as usize, read_u32(p + 44) as usize));
            }
            0x2 => {
                symtab_loc = Some((
                    read_u32(p + 8) as usize,
                    read_u32(p + 12) as usize,
                    read_u32(p + 16) as usize,
                ));
            }
            0x19 if exe[p + 8..p + 15] == *b"__TEXT\0" => {
                image_base = Some(read_u64(p + 24));
            }
            _ => {}
        }
        p += read_u32(p + 4) as usize;
    }
    let (export_off, export_size) = export_range.expect("LC_DYLD_INFO_ONLY must be present");
    let trie = &exe[export_off..export_off + export_size];
    let (symoff, nsyms, stroff) = symtab_loc.expect("LC_SYMTAB must be present");
    let image_base = image_base.expect("__TEXT segment must be present");
    let n_value_of = |name: &str| -> u64 {
        (0..nsyms)
            .find_map(|i| {
                let base = symoff + i * 16;
                let s = &exe[stroff + read_u32(base) as usize..];
                let end = s.iter().position(|&b| b == 0).unwrap();
                (&s[..end] == name.as_bytes()).then(|| read_u64(base + 8))
            })
            .unwrap_or_else(|| panic!("symtab must carry {name}"))
    };
    for name in ["_host_api", "_host_data"] {
        assert_eq!(
            trie_lookup(trie, name),
            Some(n_value_of(name) - image_base),
            "{name} must resolve through the export trie at its symtab address"
        );
    }
}

#[test]
fn thread_local_in_elf_shared_library_is_a_link_error() {
    // The emitted `_Thread_local` sequences use the local-exec TLS
    // model, whose TP-relative offsets are valid only in the
    // executable's static TLS block; baked into ET_DYN they address
    // another module's TLS. The writer must reject the combination
    // until the general-dynamic model is implemented.
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        "_Thread_local int counter = 7;\n\
         int bump(void) { counter += 1; return counter; }\n"
            .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    assert!(
        !merged.tls_data.is_empty(),
        "the merged unit must carry TLS data"
    );
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let err = write_native_image_from_merged(
        &merged,
        &plt,
        "",
        None,
        OutputKind::SharedLibrary,
        Target::LinuxX64,
        None,
    )
    .expect_err("a _Thread_local shared library must be rejected");
    assert!(
        err.to_string()
            .contains("_Thread_local data is not supported in ELF shared-library output"),
        "unexpected diagnostic: {err}"
    );
}

#[test]
fn shared_object_relocates_internal_data_pointers() {
    // A function / data pointer baked into a shared object's static data
    // must carry an R_*_RELATIVE relocation so it tracks the runtime load
    // base (C: a `static const` table of pointers in a dlopen'd module);
    // an executable maps at a fixed base and needs none. Without it the
    // table holds link-time addresses and dereferences garbage at load.
    use crate::c5::linker::object::count_dynamic_relocs_of_type;
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const R_X86_64_RELATIVE: u32 = 8;
    let program = Compiler::with_target(
        alloc::format!(
            "{TEST_PRELUDE}\
             static int f1(void) {{ return 1; }}\n\
             static int f2(void) {{ return 2; }}\n\
             typedef int (*fn_t)(void);\n\
             static const fn_t tab[2] = {{ f1, f2 }};\n\
             int use_tab(int i) {{ return tab[i](); }}\n\
             int main(void) {{ return use_tab(0) + use_tab(1); }}\n"
        ),
        Target::LinuxX64,
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let so = write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        OutputKind::SharedLibrary,
        Target::LinuxX64,
        None,
    )
    .expect("write shared library");
    let so_rel = count_dynamic_relocs_of_type(&so, R_X86_64_RELATIVE).expect("count so relocs");
    assert!(
        so_rel >= 2,
        "shared object must relocate the two internal function pointers, got {so_rel}"
    );
    let plt2 = emit_x86_64_plt(&mut merged).expect("plt");
    let exe = write_native_image_from_merged(
        &merged,
        &plt2,
        "main",
        None,
        OutputKind::Executable,
        Target::LinuxX64,
        None,
    )
    .expect("write executable");
    let exe_rel = count_dynamic_relocs_of_type(&exe, R_X86_64_RELATIVE).expect("count exe relocs");
    assert!(
        exe_rel >= 2,
        "a PIE executable relocates its internal function pointers like the shared \
         object, got {exe_rel}"
    );
}

#[test]
fn export_all_round_trips_into_shared_library() {
    // `--export-all` (`CompileOptions::export_all_functions`) exports
    // every non-static function without a `#pragma export`. The names
    // ride the same `.note.badc` NT_BADC_EXPORTS record through emit ->
    // parse -> link and the shared-library writer promotes them; a
    // `static` function keeps internal linkage and is omitted.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let copts = CompileOptions::default().with_export_all_functions(true);
    let program = Compiler::with_options(
        alloc::format!(
            "{TEST_PRELUDE}\
             static int internal_fn(int x) {{ return x + 2; }}\n\
             int api_one(int x) {{ return x + 1; }}\n\
             int api_two(int x) {{ return api_one(x) + internal_fn(x); }}\n\
             int main(void) {{ return api_two(1); }}\n"
        ),
        Target::LinuxX64,
        copts,
    )
    .compile()
    .expect("compile");
    let names: alloc::vec::Vec<&str> = program.exports.iter().map(|e| e.name.as_str()).collect();
    assert!(
        names.contains(&"api_one") && names.contains(&"api_two"),
        "both non-static functions must auto-export: {names:?}"
    );
    assert!(
        !names.contains(&"internal_fn"),
        "a static function must not export: {names:?}"
    );
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        obj.exports.contains(&"api_one".to_string())
            && obj.exports.contains(&"api_two".to_string()),
        "auto-exports must round-trip through the `.note.badc` record"
    );
    assert!(
        !obj.exports.contains(&"internal_fn".to_string()),
        "a static function must not round-trip"
    );
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let so = write_native_image_from_merged(
        &merged,
        &plt,
        "",
        None,
        OutputKind::SharedLibrary,
        Target::LinuxX64,
        None,
    )
    .expect("write shared library");
    assert_eq!(
        u16::from_le_bytes(so[0x10..0x12].try_into().unwrap()),
        3,
        "shared library must be ET_DYN"
    );
}

#[test]
fn win64_dll_records_requested_name() {
    // A Win64 DLL records its own name in the export directory so a
    // consumer linking against it by name references the file it loads
    // at runtime; the name comes from the requested `-o` basename, not a
    // fixed default. (The runtime's `exit` binding resolving through
    // msvcrt.dll rather than ucrtbase.dll is exercised by the Windows
    // demos, which link the embedded runtime.) No prelude: the host's
    // headers would carry host-OS data bindings into this PE-target
    // link, which the linker rejects as binding/definition collisions.
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "#pragma export(api_fn)\n\
         int api_fn(int x) { return x + 1; }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::WindowsX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let dll = write_native_image_from_merged(
        &merged,
        &plt,
        "",
        None,
        OutputKind::SharedLibrary,
        Target::WindowsX64,
        Some("requested_name.dll"),
    )
    .expect("write DLL");
    let contains = |needle: &str| dll.windows(needle.len()).any(|w| w == needle.as_bytes());
    assert!(
        contains("requested_name.dll"),
        "export directory must carry the requested DLL name"
    );
    assert!(
        !contains("c5-output.dll"),
        "the fixed default name must not leak into the image"
    );
}

#[test]
fn win64_dll_without_imports_leaves_import_and_iat_dirs_empty() {
    // A DLL whose code calls nothing external has no imported DLLs.
    // The import-descriptor block is then a lone zero terminator and
    // the IAT is empty. Pointing the Import data directory at that
    // descriptor with a zero-size IAT directory is rejected by the
    // Windows loader (ERROR_INVALID_PARAMETER) at LoadLibrary time,
    // though wine tolerates it. The writer must leave both directories
    // empty (RVA = 0, size = 0) in that case.
    use crate::c5::object::emit_native_with_options_named;
    use crate::c5::{NativeOptions, Target};
    let src = "#pragma export(answer)\nint answer(void) { return 42; }\n";
    for target in [Target::WindowsX64, Target::WindowsAarch64] {
        // Compile for the same target the writer lowers for, so the
        // per-target bindings are in scope (a host-default compile
        // would feed the wrong `#pragma binding` set).
        let program = Compiler::with_target(src.to_string(), target)
            .compile()
            .expect("compile");
        let dll = emit_native_with_options_named(
            &program,
            target,
            NativeOptions::new().with_shared_library(),
            Some("noimports.dll"),
        )
        .expect("emit DLL");
        let pe = u32::from_le_bytes(dll[0x3c..0x40].try_into().unwrap()) as usize;
        let opt = pe + 24;
        // PE32+ data directories start at optional-header offset 112;
        // entry 1 is Import, entry 12 is IAT (8 bytes each: RVA, size).
        let dir = |i: usize| {
            let o = opt + 112 + i * 8;
            let rva = u32::from_le_bytes(dll[o..o + 4].try_into().unwrap());
            let size = u32::from_le_bytes(dll[o + 4..o + 8].try_into().unwrap());
            (rva, size)
        };
        assert_eq!(dir(1), (0, 0), "{target:?}: import directory must be empty");
        assert_eq!(dir(12), (0, 0), "{target:?}: IAT directory must be empty");
        // The export directory (entry 0) still carries `answer`.
        let (exp_rva, exp_size) = dir(0);
        assert!(
            exp_rva != 0 && exp_size != 0,
            "{target:?}: export directory must be present"
        );
    }
}

#[test]
fn windows_hypotf_imports_underscored_ucrtbase_export() {
    // ucrtbase.dll exports the float hypot only under the legacy
    // underscored `_hypotf`; the C99 `hypotf` spelling is a header inline
    // there, with no exported symbol. Binding the call to the bare
    // `hypotf` leaves an unresolved import that fails the Windows loader
    // at process start (STATUS_ENTRYPOINT_NOT_FOUND, 0xc0000139). The
    // import-name string in the PE must therefore be `_hypotf` on both
    // Windows targets.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "#include <math.h>\n\
               #pragma export(use_hypotf)\n\
               float use_hypotf(float a, float b) { return hypotf(a, b); }\n";
    for target in [Target::WindowsX64, Target::WindowsAarch64] {
        let program = Compiler::with_target(src.to_string(), target)
            .compile()
            .expect("compile hypotf TU");
        let obj = emit_native_with_options(
            &program,
            target,
            NativeOptions {
                output_kind: OutputKind::Relocatable,
                ..Default::default()
            },
        )
        .expect("emit object");
        // The import symbol is the null-delimited `_hypotf`; matching the
        // bare substring would also hit the `use_hypotf` definition.
        let contains = |needle: &[u8]| obj.windows(needle.len()).any(|w| w == needle);
        assert!(
            contains(b"\0_hypotf\0"),
            "{target:?}: the float hypot call must bind to the exported `_hypotf`"
        );
        assert!(
            !contains(b"\0hypotf\0"),
            "{target:?}: the unexported bare `hypotf` must not be imported"
        );
    }
}

#[test]
fn wdm_driver_demo_builds_as_native_subsystem_pe() {
    // The WDM driver skeleton carries `#pragma subsystem(driver)`
    // (an alias for the native subsystem) and `#pragma
    // entrypoint(DriverEntry)`. The PE optional-header Subsystem must
    // be IMAGE_SUBSYSTEM_NATIVE (1) for both Windows targets; the
    // kernel's PE loader refuses a CUI/GUI subsystem.
    //
    // A NATIVE-subsystem image runs no `_start` CRT stub, so the
    // libc-`exit` runtime wrapper is not linked and the image carries
    // no user-mode `exit` import -- `msvcrt!exit` is unsatisfiable in
    // kernel mode. The skeleton imports nothing, so the import data
    // directory is empty.
    use crate::c5::{NativeOptions, Target, emit_native_with_options};
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("demos");
    path.push("wdm_driver");
    path.push("wdm_driver.c");
    let src = std::fs::read_to_string(&path).expect("read wdm_driver.c");
    for target in [Target::WindowsX64, Target::WindowsAarch64] {
        let program = Compiler::with_target(src.clone(), target)
            .compile()
            .expect("compile wdm_driver.c");
        let pe = emit_native_with_options(&program, target, NativeOptions::default())
            .expect("emit driver PE");
        let pe_off = u32::from_le_bytes(pe[0x3c..0x40].try_into().unwrap()) as usize;
        let opt = pe_off + 24;
        // Subsystem sits at optional-header offset 68 in PE32+.
        let subsystem = u16::from_le_bytes(pe[opt + 68..opt + 70].try_into().unwrap());
        assert_eq!(
            subsystem, 1,
            "{target:?}: wdm_driver must be IMAGE_SUBSYSTEM_NATIVE"
        );
        // Import data directory (entry 1) must be empty.
        let imp = opt + 112 + 8;
        let imp_rva = u32::from_le_bytes(pe[imp..imp + 4].try_into().unwrap());
        let imp_size = u32::from_le_bytes(pe[imp + 4..imp + 8].try_into().unwrap());
        assert_eq!(
            (imp_rva, imp_size),
            (0, 0),
            "{target:?}: a native driver must carry no imports"
        );
        assert!(
            !pe.windows(10)
                .any(|w| w.eq_ignore_ascii_case(b"msvcrt.dll")),
            "{target:?}: a native driver must not reference msvcrt.dll"
        );
    }
}

#[test]
fn cross_tu_call_into_secondary_dylib_keeps_routing() {
    // Cross-TU import routing through the native merge. The parser
    // records each `#pragma binding` import against its `#pragma
    // dylib`; `parse_native_elf` recovers the per-object (import ->
    // dylib) map and the merge in `link.rs` remaps it into the
    // deduped dylib order. Unit A binds a symbol in a second dylib
    // (libutil); unit B references only the shared first dylib
    // (libc). The merge must keep A's libutil import routed to
    // libutil even though B contributes no libutil entry.
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let compile_rel = |src: &str| {
        let program = Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse ET_REL")
    };

    let unit_a = compile_rel(
        "
        #pragma dylib(libc, \"libc.so.6\")
        #pragma binding(libc::printf, \"printf\")
        #pragma dylib(libutil, \"libutil.so.1\")
        #pragma binding(libutil::do_work, \"do_work\")
        int printf(const char *, ...);
        int do_work(void);
        int lib_call(void) { printf(\"x\"); return do_work(); }
        ",
    );
    let unit_b = compile_rel(
        "
        #pragma dylib(libc, \"libc.so.6\")
        #pragma binding(libc::printf, \"printf\")
        #pragma binding(libc::fputs, \"fputs\")
        int printf(const char *, ...);
        int fputs(const char *, void *);
        extern int lib_call(void);
        int main(void) { fputs(\"y\", 0); printf(\"z\"); return lib_call(); }
        ",
    );

    // Unit B first: a single-pass merge that appended B's libc
    // bindings before resolving A's routing would shift libutil.
    let merged = link_native_objects(&[unit_b, unit_a]).expect("link");

    let libutil_idx = merged
        .dylibs
        .iter()
        .position(|d| d.as_str() == "libutil.so.1")
        .expect("merged dylibs should include libutil.so.1") as u32;
    let libc_idx = merged
        .dylibs
        .iter()
        .position(|d| d.as_str() == "libc.so.6")
        .expect("merged dylibs should include libc.so.6") as u32;
    assert_eq!(
        merged.import_dylib_map.get("do_work"),
        Some(&libutil_idx),
        "secondary-dylib import `do_work` must stay routed to libutil after the merge"
    );
    assert_eq!(
        merged.import_dylib_map.get("printf"),
        Some(&libc_idx),
        "shared-dylib import `printf` must route to libc"
    );
}

#[test]
fn out_of_range_text_reloc_offset_is_diagnostic_not_panic() {
    // .o / .a files are untrusted linker input read from disk. A corrupt
    // r_offset must yield a diagnostic, not a slice-index panic. x86_64
    // PC32/PLT32 is the path whose only prior guard was the displacement
    // fit check, which an out-of-bounds offset passes.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let reloc = || NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let compile = |src: &str| {
        Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile")
    };
    let caller = compile("extern int f(void);\nint main(void){ return f(); }\n");
    let callee = compile("int f(void){ return 7; }\n");
    let a_bytes = emit_native_with_options(&caller, Target::LinuxX64, reloc()).expect("emit a");
    let b_bytes = emit_native_with_options(&callee, Target::LinuxX64, reloc()).expect("emit b");
    let mut a = parse_native_elf(&a_bytes).expect("parse a");
    let b = parse_native_elf(&b_bytes).expect("parse b");
    assert!(!a.text_relocs.is_empty(), "caller must carry a text reloc");
    // Past the end of the merged text (well beyond any object's size).
    for r in &mut a.text_relocs {
        r.offset = 0x4000_0000;
    }
    assert!(
        link_native_objects(&[a, b]).is_err(),
        "out-of-range text reloc offset must be a diagnostic, not a panic"
    );
}

#[test]
fn wrapping_section_size_is_diagnostic_not_panic() {
    // A malformed object whose section sh_offset + sh_size wraps must be
    // rejected, not abort the linker on the slice bound.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new("int g = 5;\nint main(void){ return g; }\n".to_string())
        .compile()
        .expect("compile");
    let mut bytes = emit_native_with_options(
        &program,
        Target::LinuxX64,
        NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        },
    )
    .expect("emit");
    // Elf64_Ehdr: e_shoff @40, e_shentsize @58, e_shnum @60.
    let e_shoff = u64::from_le_bytes(bytes[40..48].try_into().unwrap()) as usize;
    let e_shentsize = u16::from_le_bytes(bytes[58..60].try_into().unwrap()) as usize;
    let e_shnum = u16::from_le_bytes(bytes[60..62].try_into().unwrap()) as usize;
    assert!(
        e_shoff != 0 && e_shnum > 1,
        "expected a section header table"
    );
    // Set the first SHT_PROGBITS section's sh_size (Elf64_Shdr @32) to the
    // max so section_slice's off + size wraps when it reads that section.
    let mut patched = false;
    for i in 1..e_shnum {
        let shdr = e_shoff + i * e_shentsize;
        let sh_type = u32::from_le_bytes(bytes[shdr + 4..shdr + 8].try_into().unwrap());
        if sh_type == 1 {
            let at = shdr + 32;
            bytes[at..at + 8].copy_from_slice(&u64::MAX.to_le_bytes());
            patched = true;
            break;
        }
    }
    assert!(patched, "expected a SHT_PROGBITS section to corrupt");
    assert!(
        parse_native_elf(&bytes).is_err(),
        "a wrapping sh_offset + sh_size must be a diagnostic, not a panic"
    );
}

#[test]
fn inline_linkage_follows_c99_6_7_4p7() {
    // C99 6.7.4p7: a function all of whose file-scope declarations are
    // `inline` without `extern` provides no external definition in the
    // unit -- its out-of-line copy must be local so the same inline
    // function compiled into another unit does not collide at link time.
    // A single non-inline declaration (a prototype) or `extern inline`
    // makes the definition external, so a unit that only references the
    // function resolves against it.
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const STB_LOCAL: u8 = 0;
    const STB_GLOBAL: u8 = 1;

    fn binding_of(src: &str, name: &str) -> u8 {
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        let sym = obj
            .symbols
            .iter()
            .find(|s| s.name == name && !matches!(s.section, NativeSymSection::Undef))
            .unwrap_or_else(|| panic!("`{name}` must be a defined symbol"));
        sym.binding
    }

    // Plain `inline`, no other declaration: internal linkage (local).
    assert_eq!(
        binding_of(
            "inline int f(int x) { return x + 1; }\n\
             int main(void) { return f(41) == 42 ? 0 : 1; }\n",
            "f",
        ),
        STB_LOCAL,
        "plain inline-only definition must be local"
    );
    // A non-inline prototype precedes the inline definition: external.
    assert_eq!(
        binding_of(
            "int g(int);\n\
             inline int g(int x) { return x + 1; }\n\
             int main(void) { return g(41) == 42 ? 0 : 1; }\n",
            "g",
        ),
        STB_GLOBAL,
        "a non-inline declaration makes the inline definition external"
    );
    // `extern inline` provides the one external definition.
    assert_eq!(
        binding_of(
            "extern inline int h(int x) { return x + 1; }\n\
             int main(void) { return h(41) == 42 ? 0 : 1; }\n",
            "h",
        ),
        STB_GLOBAL,
        "extern inline must be external"
    );
    // `static inline` is internal.
    assert_eq!(
        binding_of(
            "static inline int s(int x) { return x + 1; }\n\
             int main(void) { return s(41) == 42 ? 0 : 1; }\n",
            "s",
        ),
        STB_LOCAL,
        "static inline must be local"
    );
    // An inline prototype (no body) must not mark the following,
    // unrelated definition inline: `pb` is a plain external function.
    assert_eq!(
        binding_of(
            "inline int pa(int);\n\
             int pb(int x) { return x + 1; }\n\
             int main(void) { return pb(41) == 42 ? 0 : 1; }\n",
            "pb",
        ),
        STB_GLOBAL,
        "an inline prototype must not leak `inline` onto the next definition"
    );
}

#[test]
fn cpuid_xgetbv_asm_emit_for_x86_64() {
    // The GCC `cpuid` / `xgetbv` inline-asm forms (a common CPU feature
    // probe) lower to dedicated intrinsics on x86_64: the `cpuid` (0F A2)
    // and `xgetbv` (0F 01 D0) opcodes appear, bracketed by a save of the
    // fixed registers they clobber (push rbx = 0x53, ebx being callee-saved).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "static void cpuid(unsigned f, unsigned s, unsigned o[4]) {\n\
         __asm__ __volatile__(\"cpuid\" : \"=a\"(o[0]),\"=b\"(o[1]),\"=c\"(o[2]),\"=d\"(o[3]) : \"a\"(f),\"c\"(s));\n\
         }\n\
         static unsigned long long xgetbv(unsigned r) {\n\
         unsigned lo, hi;\n\
         __asm__ __volatile__(\"xgetbv\" : \"=a\"(lo),\"=d\"(hi) : \"c\"(r));\n\
         return ((unsigned long long)hi << 32) | lo;\n\
         }\n\
         unsigned long long use_both(unsigned o[4]) { cpuid(1,0,o); return xgetbv(0); }\n\
         int main(void){ unsigned o[4]; return (int)use_both(o); }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    assert!(
        bytes.windows(2).any(|w| w == [0x0F, 0xA2]),
        "cpuid opcode (0F A2) must be emitted"
    );
    assert!(
        bytes.windows(3).any(|w| w == [0x0F, 0x01, 0xD0]),
        "xgetbv opcode (0F 01 D0) must be emitted"
    );
    assert!(
        bytes.contains(&0x53),
        "push rbx (callee-saved, clobbered by cpuid) must be saved"
    );
}

#[test]
fn cpuid_matching_constraint_x86_64() {
    // A common `host_cpuid` shape ties the eax input to output operand 0
    // with the matching constraint `"0"(function)` rather than `"a"(function)`.
    // The digit constraint resolves to that output's register (eax) and
    // lowers to the same `cpuid` (0F A2) intrinsic.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "void host_cpuid(unsigned function, unsigned count,\n\
         unsigned *eax, unsigned *ebx, unsigned *ecx, unsigned *edx) {\n\
         unsigned vec[4];\n\
         __asm__ __volatile__(\"cpuid\"\n\
         : \"=a\"(vec[0]),\"=b\"(vec[1]),\"=c\"(vec[2]),\"=d\"(vec[3])\n\
         : \"0\"(function),\"c\"(count) : \"cc\");\n\
         if (eax) *eax = vec[0]; if (ebx) *ebx = vec[1];\n\
         if (ecx) *ecx = vec[2]; if (edx) *edx = vec[3];\n\
         }\n\
         int main(void){ unsigned a,b,c,d; host_cpuid(0,0,&a,&b,&c,&d); return (int)a; }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    assert!(
        bytes.windows(2).any(|w| w == [0x0F, 0xA2]),
        "cpuid opcode (0F A2) must be emitted for the `\"0\"` matching constraint"
    );
}

#[test]
fn same_named_statics_keep_their_own_prologue_anchor() {
    // The post-prologue anchor map is keyed by the function's merged
    // entry offset. Name-keying handed a later unit's same-named
    // static the first unit's anchor, describing a framed function as
    // frameless in the Win-x64 .pdata / DWARF CFA output.
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let compile = |src: &str| {
        let program = Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse ET_REL")
    };
    let a = compile(
        "static int helper(int x) { int buf[16]; buf[0] = x; return buf[0] + 1; }\n\
         int call_a(int x) { return helper(x); }\n",
    );
    let b = compile(
        "static int helper(int x) { int buf[32]; buf[1] = x; return buf[1] + 2; }\n\
         int call_b(int x) { return helper(x); }\n",
    );
    let merged = link_native_objects(&[a, b]).expect("link");
    let helpers: alloc::vec::Vec<u64> = merged
        .local_funcs
        .iter()
        .filter(|(n, _)| n == "helper")
        .map(|(_, off)| *off)
        .collect();
    assert_eq!(helpers.len(), 2, "both statics survive: {helpers:?}");
    let mut posts = alloc::vec::Vec::new();
    for entry in &helpers {
        let post = merged
            .prologue_ends
            .get(entry)
            .unwrap_or_else(|| panic!("anchor for helper at 0x{entry:x} missing"));
        assert!(
            post > entry,
            "post-prologue 0x{post:x} must lie past the entry 0x{entry:x}"
        );
        posts.push(*post);
    }
    assert_ne!(posts[0], posts[1], "each static keeps its own anchor");
}

#[test]
fn unrouted_weak_undef_resolves_to_zero() {
    // ELF behavior: a weak reference nothing on the link line
    // satisfies resolves to address 0 -- not a required import
    // against the first dylib. The call becomes a no-op, the
    // address-of reads null, and a pointer initializer slot holds 0.
    use crate::c5::linker::object::{NativeReloc, NativeSymbol};
    use crate::c5::linker::{NativeMachine, NativeSymSection, link_native_objects};
    let null_sym = || NativeSymbol {
        name: String::new(),
        section: NativeSymSection::Undef,
        value: 0,
        size: 0,
        binding: 0,
        kind: 0,
    };
    let weak_undef = || NativeSymbol {
        name: "hook".to_string(),
        section: NativeSymSection::Undef,
        value: 0,
        size: 0,
        binding: 2, // STB_WEAK
        kind: 0,
    };
    let mk = |machine: NativeMachine,
              text: alloc::vec::Vec<u8>,
              data: alloc::vec::Vec<u8>,
              text_relocs: alloc::vec::Vec<NativeReloc>,
              data_relocs: alloc::vec::Vec<NativeReloc>| {
        crate::c5::linker::NativeObject {
            machine,
            text,
            data,
            data_align: 8,
            bss_size: 0,
            tls_data: alloc::vec::Vec::new(),
            tls_bss_size: 0,
            symbols: alloc::vec![null_sym(), weak_undef()],
            text_relocs,
            data_relocs,
            init_funcs: alloc::vec::Vec::new(),
            dylibs: alloc::vec::Vec::new(),
            import_dylib_map: alloc::vec::Vec::new(),
            exports: alloc::vec::Vec::new(),
            tls_index_fixups: alloc::vec::Vec::new(),
            macho_tlv_descriptors: alloc::vec::Vec::new(),
            macho_tlv_fixups: alloc::vec::Vec::new(),
            tls_symbols: alloc::vec::Vec::new(),
            macho_tlv_descriptor_syms: alloc::vec::Vec::new(),
            elf_tpoff_fixups: alloc::vec::Vec::new(),
            copy_relocs: alloc::vec::Vec::new(),
            debug_info: alloc::vec::Vec::new(),
            debug_abbrev: alloc::vec::Vec::new(),
            debug_line: alloc::vec::Vec::new(),
            debug_str: alloc::vec::Vec::new(),
            debug_info_relocs: alloc::vec::Vec::new(),
            debug_line_relocs: alloc::vec::Vec::new(),
        }
    };

    // x86_64: `lea rax, [rip+hook]` (R_X86_64_PC32) then `call hook`
    // (R_X86_64_PLT32), plus a `.data` pointer slot (R_X86_64_64).
    let x64 = mk(
        NativeMachine::X86_64,
        alloc::vec![
            0x48, 0x8D, 0x05, 0, 0, 0, 0, // lea rax, [rip+0]
            0xE8, 0, 0, 0, 0, // call rel32
        ],
        alloc::vec![0u8; 8],
        alloc::vec![
            NativeReloc {
                offset: 3,
                sym_idx: 1,
                rtype: 2, // R_X86_64_PC32
                addend: -4,
            },
            NativeReloc {
                offset: 8,
                sym_idx: 1,
                rtype: 4, // R_X86_64_PLT32
                addend: -4,
            },
        ],
        alloc::vec![NativeReloc {
            offset: 0,
            sym_idx: 1,
            rtype: 1, // R_X86_64_64
            addend: 0,
        }],
    );
    let merged = link_native_objects(&[x64]).expect("weak undef links");
    assert!(
        merged.imports.is_empty(),
        "no import for an unresolved weak ref: {:?}",
        merged.imports
    );
    assert_eq!(
        &merged.text[0..7],
        &[0x48, 0xC7, 0xC0, 0, 0, 0, 0],
        "lea rewritten to mov rax, 0"
    );
    assert_eq!(
        &merged.text[7..12],
        &[0x0F, 0x1F, 0x44, 0x00, 0x00],
        "call rewritten to a 5-byte nop"
    );
    assert_eq!(&merged.data[0..8], &[0u8; 8], "pointer slot holds null");

    // aarch64: `adrp x0, hook` + `add x0, x0, :lo12:hook` + `bl hook`.
    let a64 = mk(
        NativeMachine::Aarch64,
        alloc::vec![
            0x00, 0x00, 0x00, 0x90, // adrp x0, 0
            0x00, 0x00, 0x00, 0x91, // add x0, x0, #0
            0x00, 0x00, 0x00, 0x94, // bl 0
        ],
        alloc::vec::Vec::new(),
        alloc::vec![
            NativeReloc {
                offset: 0,
                sym_idx: 1,
                rtype: 275, // R_AARCH64_ADR_PREL_PG_HI21
                addend: 0,
            },
            NativeReloc {
                offset: 4,
                sym_idx: 1,
                rtype: 277, // R_AARCH64_ADD_ABS_LO12_NC
                addend: 0,
            },
            NativeReloc {
                offset: 8,
                sym_idx: 1,
                rtype: 283, // R_AARCH64_CALL26
                addend: 0,
            },
        ],
        alloc::vec::Vec::new(),
    );
    let merged = link_native_objects(&[a64]).expect("weak undef links");
    assert!(merged.imports.is_empty(), "{:?}", merged.imports);
    let word = |i: usize| u32::from_le_bytes(merged.text[i..i + 4].try_into().unwrap());
    assert_eq!(word(0), 0xd280_0000, "adrp rewritten to movz x0, #0");
    assert_eq!(word(4), 0xd503_201f, "add pair half becomes a nop");
    assert_eq!(word(8), 0xd503_201f, "bl becomes a nop");
}

#[test]
fn elf_section_offsets_respect_their_claimed_alignment() {
    // gABI: `sh_addr` (and the file offset for SHF_ALLOC sections)
    // must be congruent to 0 modulo `sh_addralign`. Version-name
    // strings appended to `.dynstr` after its pad used to leave
    // `.hash` / `.gnu.version` misaligned; the check runs over every
    // section so any future layout drift is caught. Version sections
    // only appear when the build host's libc yields versioned imports.
    use crate::c5::linker::{
        emit_aarch64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         int main(void) {{ printf(\"x\"); return 0; }}\n"
    ))
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_aarch64_plt(&mut merged).expect("plt");
    let exe = write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        OutputKind::Executable,
        Target::LinuxAarch64,
        None,
    )
    .expect("write executable");
    let shoff = u64::from_le_bytes(exe[0x28..0x30].try_into().unwrap()) as usize;
    let shentsize = u16::from_le_bytes(exe[0x3a..0x3c].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(exe[0x3c..0x3e].try_into().unwrap()) as usize;
    assert!(shnum > 0, "executable must carry section headers");
    const SHT_NOBITS: u32 = 8;
    for i in 0..shnum {
        let base = shoff + i * shentsize;
        let sh_type = u32::from_le_bytes(exe[base + 4..base + 8].try_into().unwrap());
        let sh_addr = u64::from_le_bytes(exe[base + 16..base + 24].try_into().unwrap());
        let sh_offset = u64::from_le_bytes(exe[base + 24..base + 32].try_into().unwrap());
        let sh_addralign = u64::from_le_bytes(exe[base + 48..base + 56].try_into().unwrap());
        if sh_addralign <= 1 {
            continue;
        }
        assert_eq!(
            sh_addr % sh_addralign,
            0,
            "section {i} sh_addr 0x{sh_addr:x} violates sh_addralign {sh_addralign}"
        );
        if sh_type != SHT_NOBITS {
            assert_eq!(
                sh_offset % sh_addralign,
                0,
                "section {i} sh_offset 0x{sh_offset:x} violates sh_addralign {sh_addralign}"
            );
        }
    }
}

#[test]
fn extern_redeclaration_keeps_the_tentative_definition() {
    // C99 6.2.2p4 + 6.9.2p2: `int x; extern int x;` retains the
    // tentative definition (the extern redeclaration refers to the
    // same object), so the TU's object defines `x`. The same holds
    // for the array form and for an initialized definition.
    use crate::c5::linker::{NativeSymSection, parse_native_elf};
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let defined_sections = |src: &str, names: &[&str]| -> alloc::vec::Vec<bool> {
        let program = Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        names
            .iter()
            .map(|n| {
                obj.symbols
                    .iter()
                    .any(|s| &s.name == n && s.section != NativeSymSection::Undef)
            })
            .collect()
    };
    let defined = defined_sections(
        "int x;\nextern int x;\n\
         int a[4];\nextern int a[];\n\
         int y = 5;\nextern int y;\n\
         int use_all(void) { return x + a[0] + y; }\n",
        &["x", "a", "y"],
    );
    assert_eq!(
        defined,
        alloc::vec![true, true, true],
        "the definitions must survive the extern redeclarations (x, a, y)"
    );
    // A genuinely extern-only declaration still emits an UNDEF.
    let defined = defined_sections("extern int z;\nint use_z(void) { return z; }\n", &["z"]);
    assert_eq!(defined, alloc::vec![false], "extern-only stays undefined");
}

#[test]
fn alignas_places_objects_at_requested_alignment() {
    // C11 6.7.5: an alignment request on a file-scope object is honored --
    // the object's section offset is aligned through compaction and the
    // unit records `data_align` so the linker and image writers keep the
    // base congruent. Static objects honor power-of-two requests up to a
    // page; automatic objects and non-power-of-two requests are diagnostics.
    use crate::c5::linker::{NativeSymSection, link_native_objects, parse_native_elf};
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let compile = |src: &str| {
        let program = Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse ET_REL")
    };
    let aligned_unit = "\
        _Alignas(16) unsigned char pool[24];\n\
        char skew[3] = \"ab\";\n\
        __attribute__((aligned(16))) unsigned char pool2[8];\n\
        int use_all(void) { return pool[0] + skew[0] + pool2[0]; }\n";
    let obj = compile(aligned_unit);
    assert_eq!(obj.data_align, 16, "unit must claim 16-byte data alignment");
    for name in ["pool", "pool2"] {
        let sym = obj
            .symbols
            .iter()
            .find(|s| s.name == name)
            .unwrap_or_else(|| panic!("{name} missing"));
        assert!(
            sym.section != NativeSymSection::Undef && sym.value.is_multiple_of(16),
            "{name} at {:?}+0x{:x} must be 16-aligned",
            sym.section,
            sym.value
        );
    }
    // Linked after a unit with an odd-sized data tail, the offsets
    // stay 16-congruent (the unit base honors the claimed alignment)
    // and the file image is padded so bss offsets keep their residue.
    let odd = compile("char tail[5] = \"abcd\";\nint use_tail(void) { return tail[0]; }\n");
    let merged = link_native_objects(&[odd, compile(aligned_unit)]).expect("link");
    assert_eq!(merged.data_align, 16);
    if merged.bss_size > 0 {
        assert!(merged.data.len().is_multiple_of(16));
    }
    for name in ["pool", "pool2"] {
        let sym = merged.defined.get(name).unwrap_or_else(|| panic!("{name}"));
        assert!(
            sym.value.is_multiple_of(16),
            "{name} merged offset 0x{:x} must stay 16-aligned",
            sym.value
        );
    }
    // A static object over-aligns past 16: `aligned(64)` places it at 64
    // and raises the unit's data alignment to match.
    let over = compile(
        "__attribute__((aligned(64))) unsigned char big[64] = { 1 };\n\
         int use_big(void) { return big[0]; }\n",
    );
    assert_eq!(
        over.data_align, 64,
        "aligned(64) must raise unit data alignment to 64"
    );
    let big = over
        .symbols
        .iter()
        .find(|s| s.name == "big")
        .expect("big missing");
    assert!(
        big.section != NativeSymSection::Undef && big.value.is_multiple_of(64),
        "big at {:?}+0x{:x} must be 64-aligned",
        big.section,
        big.value
    );
    // Diagnostics: automatic objects above 8, and non-power-of-two requests.
    for src in [
        "int main(void) { _Alignas(16) char buf[8]; return buf[0]; }\n",
        "__attribute__((aligned(24))) static char weird[8];\nint main(void) { return 0; }\n",
    ] {
        assert!(
            Compiler::new(src.to_string()).compile().is_err(),
            "must be diagnosed: {src}"
        );
    }
    // A struct member's 16-byte alignment is honored, not diagnosed (the
    // member and the aggregate both align to 16; the aligned_member fixture
    // checks the resulting layout against gcc/clang).
    assert!(
        Compiler::new(
            "struct S { _Alignas(16) int f; };\nint main(void) { struct S s; s.f = 0; return s.f; }\n"
                .to_string()
        )
        .compile()
        .is_ok(),
        "a struct member's aligned(16) request must be honored"
    );
}

#[test]
fn windows_x64_tz_globals_bind_to_msvcrt_data_exports() {
    // msvcrt's `_tzset` writes the DLL's own `_tzname` / `_timezone` /
    // `_daylight`; the x64 image must import them as data (the
    // `environ` treatment) instead of resolving the externs to local
    // zero-filled slots `_tzset` never writes.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "#include <time.h>\n\
               #include <stdio.h>\n\
               #pragma export(use_tz)\n\
               long use_tz(void) { tzset(); return timezone + daylight + (tzname[0] != 0); }\n";
    let program = Compiler::with_target(src.to_string(), Target::WindowsX64)
        .compile()
        .expect("compile tz TU");
    let obj = emit_native_with_options(
        &program,
        Target::WindowsX64,
        NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        },
    )
    .expect("emit object");
    let contains = |needle: &[u8]| obj.windows(needle.len()).any(|w| w == needle);
    for sym in [
        &b"\0_tzname\0"[..],
        &b"\0_timezone\0"[..],
        &b"\0_daylight\0"[..],
    ] {
        assert!(
            contains(sym),
            "x64 tz output {:?} must be a data import",
            core::str::from_utf8(sym)
        );
    }
}

#[test]
fn dead_libc_bindings_fail_at_build_not_at_load() {
    // libSystem exports none of these (dlsym-verified); the header must
    // leave them unbound so a use fails the build loudly instead of
    // producing an image that aborts at load with a dyld error.
    let cases = [
        (
            "#include <time.h>\nint main(void) { struct timespec t; t.tv_sec = 0; t.tv_nsec = 0; return clock_nanosleep(0, 0, &t, 0); }\n",
            "clock_nanosleep",
        ),
        (
            "#include <sys/mman.h>\nint main(void) { return mremap((void *)0, 0, 0, 0) != 0; }\n",
            "mremap",
        ),
        (
            "#include <sched.h>\nint main(void) { return sched_getscheduler(0); }\n",
            "sched_getscheduler",
        ),
        (
            "#include <unistd.h>\nint main(void) { return fexecve(0, 0, 0); }\n",
            "fexecve",
        ),
    ];
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let link_one = |src: &str| {
        let program = Compiler::with_options(
            src.to_string(),
            Target::MacOSAarch64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::MacOSAarch64, opts).expect("emit");
        link_native_objects(&[parse_native_elf(&bytes).expect("parse")])
    };
    for (src, name) in cases {
        let err = link_one(src)
            .err()
            .unwrap_or_else(|| panic!("{name}: use of an unexported symbol must not link"));
        assert!(
            format!("{err}").contains(name),
            "{name}: diagnostic must name the symbol: {err}"
        );
    }
    // The bound neighbors still link.
    for src in [
        "#include <time.h>\nint main(void) { struct timespec t; return clock_gettime(0, &t); }\n",
        "#include <sched.h>\nint main(void) { return sched_yield(); }\n",
    ] {
        link_one(src).expect("bound libc call must link");
    }
}

#[test]
fn macho_data_import_gets_no_bogus_local_text_symbol() {
    // A Mach-O data import (`environ`, bound through the GOT) carries no
    // PLT trampoline. The symtab previously fabricated a local text
    // symbol for it at code offset 0 -- the first function's address --
    // mislabeling backtraces and breakpoints. Only imports that actually
    // have a trampoline get a local text symbol; a data import keeps just
    // its undefined entry.
    use crate::c5::linker::{
        emit_aarch64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        "#include <unistd.h>\n\
         #include <string.h>\n\
         int main(void) { return environ != 0 ? (int)strlen(\"x\") : 0; }\n"
            .to_string(),
        Target::MacOSAarch64,
        CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_aarch64_plt(&mut merged).expect("plt");
    let exe = write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        OutputKind::Executable,
        Target::MacOSAarch64,
        None,
    )
    .expect("write executable");

    // Walk LC_SYMTAB collecting (name, n_type). N_STAB=0xe0, N_TYPE=0x0e,
    // N_SECT=0x0e, N_EXT=0x01.
    const LC_SYMTAB: u32 = 2;
    let ncmds = u32::from_le_bytes(exe[16..20].try_into().unwrap());
    let mut p = 32usize;
    let mut names: alloc::vec::Vec<(String, u8)> = alloc::vec::Vec::new();
    for _ in 0..ncmds {
        let cmd = u32::from_le_bytes(exe[p..p + 4].try_into().unwrap());
        let cmdsize = u32::from_le_bytes(exe[p + 4..p + 8].try_into().unwrap()) as usize;
        if cmd == LC_SYMTAB {
            let symoff = u32::from_le_bytes(exe[p + 8..p + 12].try_into().unwrap()) as usize;
            let nsyms = u32::from_le_bytes(exe[p + 12..p + 16].try_into().unwrap()) as usize;
            let stroff = u32::from_le_bytes(exe[p + 16..p + 20].try_into().unwrap()) as usize;
            for k in 0..nsyms {
                let e = symoff + k * 16;
                let n_strx = u32::from_le_bytes(exe[e..e + 4].try_into().unwrap()) as usize;
                let n_type = exe[e + 4];
                let s = stroff + n_strx;
                let len = exe[s..].iter().position(|&b| b == 0).unwrap();
                names.push((
                    String::from_utf8_lossy(&exe[s..s + len]).into_owned(),
                    n_type,
                ));
            }
            break;
        }
        p += cmdsize;
    }
    // No local (N_SECT set, N_EXT clear) symbol named `environ`.
    assert!(
        !names
            .iter()
            .any(|(n, t)| n == "environ" && t & 0x0e == 0x0e && t & 0x01 == 0),
        "data import `environ` must not get a bogus local text symbol: {names:?}"
    );
    // Its undefined import entry (`_environ`, N_SECT clear) survives.
    assert!(
        names.iter().any(|(n, t)| n == "_environ" && t & 0x0e == 0),
        "data import must keep its undefined `_environ` entry: {names:?}"
    );
    // A real function import (`_strlen`) still gets its local text symbol.
    assert!(
        names
            .iter()
            .any(|(n, t)| n == "_strlen" && t & 0x0e == 0x0e && t & 0x01 == 0),
        "a trampolined import must keep its local text symbol: {names:?}"
    );
}

#[test]
fn init_array_round_trips_through_object() {
    // A constructor and a prioritized destructor emit `.init_array` /
    // `.fini_array.NNNNN` sections in the ET_REL object; `parse_native_elf`
    // recovers them as `NativeObject::init_funcs`, each resolved to the
    // target function's `.text` offset. Static (internal-linkage) init
    // functions -- what `type_init`-style macros generate -- must resolve
    // too, so use `static`.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(
            "static int g;\n\
             __attribute__((constructor)) static void ctor(void) { g = 1; }\n\
             __attribute__((destructor(101))) static void dtor(void) { g = 0; }\n\
             int main(void) { return g; }\n"
                .to_string(),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        let ctors: alloc::vec::Vec<_> =
            obj.init_funcs.iter().filter(|f| !f.is_destructor).collect();
        let dtors: alloc::vec::Vec<_> = obj.init_funcs.iter().filter(|f| f.is_destructor).collect();
        assert_eq!(ctors.len(), 1, "{target:?}: one constructor");
        assert_eq!(dtors.len(), 1, "{target:?}: one destructor");
        assert!(ctors[0].priority.is_none(), "{target:?}: bare ctor");
        assert_eq!(dtors[0].priority, Some(101), "{target:?}: dtor priority");
        // Each entry resolves to a real function body inside `.text`.
        assert!((ctors[0].unit_text_offset as usize) < obj.text.len());
        assert!((dtors[0].unit_text_offset as usize) < obj.text.len());
    }
}

#[test]
fn constructor_links_into_executable_with_runtime() {
    // The full CLI link path: a program with a `static` constructor plus
    // the startup runtime. runtime.c references the linker-defined
    // `__init_array_*` boundary symbols; before they were provided this
    // link failed with "undefined reference to __init_array_start".
    // Producing a well-formed image proves the boundary symbols resolve
    // and the init array is laid out. Execution is covered by the
    // native_elf / native_elf_x64 suites on Linux.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::{NativeOptions, Target};
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::with_options(
            "static int g;\n\
             __attribute__((constructor)) static void ctor(void) { g = 7; }\n\
             __attribute__((destructor)) static void dtor(void) { g = 0; }\n\
             int main(void) { return g; }\n"
                .to_string(),
            target,
            CompileOptions::default(),
        )
        .compile()
        .expect("compile");
        let bytes = super::link_executable_with_runtime(&program, target, NativeOptions::default())
            .unwrap_or_else(|e| panic!("{target:?}: link with runtime: {e}"));
        assert!(
            bytes.len() > 64 && &bytes[0..4] == b"\x7fELF",
            "{target:?}: produced a valid ELF image"
        );
    }
}

#[test]
fn dead_arm_switch_and_noreturn_tail_drop_their_callees() {
    // Two shapes the constant-branch elimination must cover so an
    // undefined fallback symbol is never referenced from the object:
    //   * an `if (0)` arm containing a whole `switch` (its case labels
    //     are owned by the dropped dispatch, so they don't pin it);
    //   * the tail behind a statement-level call to a `noreturn`
    //     function (C11 6.7.4p8), in each accepted spelling.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         __attribute__((noreturn)) extern void die_attr(void);\n\
         _Noreturn void die_kw(void);\n\
         static int sw_helper(int x) {{ return x * 2; }}\n\
         static int nr_helper_a(int x) {{ return x + 1; }}\n\
         static int nr_helper_k(int x) {{ return x + 2; }}\n\
         int probe(int v, int s) {{\n\
             if (0) {{\n\
                 int x;\n\
                 switch (s) {{\n\
                 case 1 ... 7: x = sw_helper(s); break;\n\
                 default: x = 0;\n\
                 }}\n\
                 return x;\n\
             }}\n\
             if (v == 1) {{ die_attr(); return nr_helper_a(v); }}\n\
             if (v == 2) {{ die_kw(); return nr_helper_k(v); }}\n\
             return 9;\n\
         }}\n\
         int main(void) {{ return probe(0, 0) - 9; }}\n"
    ))
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let has = |name: &[u8]| bytes.windows(name.len()).any(|w| w == name);
    assert!(has(b"probe"), "the reachable function must survive");
    assert!(
        !has(b"sw_helper"),
        "a helper only the dead switch arm names must not be emitted"
    );
    assert!(
        !has(b"nr_helper_a"),
        "a helper behind an attribute-noreturn call must not be emitted"
    );
    assert!(
        !has(b"nr_helper_k"),
        "a helper behind a _Noreturn call must not be emitted"
    );
}

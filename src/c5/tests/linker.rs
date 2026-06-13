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
        2,
        "executable must be ET_EXEC"
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
    // demos, which link the embedded runtime.)
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         #pragma export(api_fn)\n\
         int api_fn(int x) {{ return x + 1; }}\n"
    ))
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
    use crate::c5::codegen::emit_native_with_options_named;
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

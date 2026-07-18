//! Codegen tests: compile a fixture and inspect post-link metadata.

use super::compile_fixture_bare;

#[test]
fn entry_pc_points_at_main() {
    // `main` is the first (and only) function in this fixture, so its
    // ent_pc is 0.
    let program = compile_fixture_bare("ir_translation_simple.c");
    assert_eq!(program.entry_pc, 0);
}

/// Every emitted binary -- regardless of target -- carries the
/// `OUTPUT_MARKER` at the tail of the code section so a `strings`
/// scan reveals the badc version that produced it. The marker is
/// appended in `codegen::lower_for` after the per-arch `lower()`
/// returns; nothing references those bytes, so they're invisible
/// at runtime but easy to find on disk.
///
/// The marker carries the release version only. The git commit /
/// branch / remote that `--version` reports (`BUILD_INFO`) must
/// NOT appear in output: they vary with the build environment and
/// would make identical source/flags/target produce different
/// bytes depending on where badc was built. This test asserts
/// both the version marker is present and the git fields are
/// absent.
#[test]
fn output_marker_is_version_only_and_present_in_every_target() {
    use crate::{NativeOptions, Target};
    let program = super::compile_str("int main() { return 0; }");
    // `OUTPUT_MARKER` is `BADC\n\tv<version>` (see `src/lib.rs`).
    let needle = crate::OUTPUT_MARKER.as_bytes();
    // The git tail only ever appears in `BUILD_INFO`; its label
    // `\n\tcommit ` must not reach the output.
    let git_tail = b"\n\tcommit ";
    for target in [
        Target::MacOSAarch64,
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let bytes = crate::c5::object::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::default(),
        )
        .unwrap_or_else(|e| panic!("emit_native({target:?}): {e}"));
        let found = bytes.windows(needle.len()).any(|w| w == needle);
        assert!(
            found,
            "{target:?}: expected `OUTPUT_MARKER` in emitted binary"
        );
        let leaked = bytes.windows(git_tail.len()).any(|w| w == git_tail);
        assert!(
            !leaked,
            "{target:?}: git provenance leaked into output -- breaks reproducibility"
        );
    }
}

/// `-g` / `with_debug_info(true)` carries DWARF into the emitted
/// image; the default (off) strips it. The `debug_info` substring
/// shows up in the section-name tables of every format the writer
/// emits: ELF has `.debug_info` in `.shstrtab`, PE has `.debug_info`
/// in the COFF string table (the 8-char section-name field
/// overflows to the strtab), Mach-O has `__debug_info` in its
/// `Section64` table. Presence / absence is a single substring
/// scan per target.
#[test]
fn with_debug_info_false_strips_dwarf_for_every_target() {
    use crate::{NativeOptions, Target};
    let program = super::compile_str("int main() { return 0; }");
    let needle = b"debug_info";
    for target in [
        Target::MacOSAarch64,
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let on = crate::c5::object::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::new().with_debug_info(true),
        )
        .unwrap_or_else(|e| panic!("emit_native(on, {target:?}): {e}"));
        assert!(
            on.windows(needle.len()).any(|w| w == needle),
            "{target:?}: expected `debug_info` section name in the DWARF-on (`-g`) image"
        );
        let off = crate::c5::object::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::new().with_debug_info(false),
        )
        .unwrap_or_else(|e| panic!("emit_native(off, {target:?}): {e}"));
        assert!(
            !off.windows(needle.len()).any(|w| w == needle),
            "{target:?}: `debug_info` byte sequence leaked into the no-debug image \
             (DWARF section name should be gone)"
        );
        assert!(
            off.len() < on.len(),
            "{target:?}: no-debug image ({} bytes) should be strictly smaller than \
             default ({} bytes)",
            off.len(),
            on.len()
        );
    }
}

/// Every emitted target gets one PLT trampoline per import
/// plus a matching local-name symbol table entry. The
/// trampoline lets `gdb b malloc` resolve into the produced
/// binary instead of getting lost in the dynamic linker; the
/// local symbol gives the trampoline a real name (`nm` shows
/// it, `objdump -d` annotates calls with `malloc@plt`-style
/// labels).
///
/// Cross-target structural check: a tiny program that calls
/// `printf` emits a binary whose bytes contain the import name
/// at least twice -- once in the dynamic-import table and once
/// in the static symtab (PE COFF symtab / ELF `.symtab` /
/// Mach-O `__LINKEDIT` symbol entries).
#[test]
fn plt_trampoline_local_names_appear_in_every_target() {
    use crate::{NativeOptions, Target};
    // Call `printf` so the resolver pulls it in as an import on
    // every target (the test prelude `#include <stdio.h>` is
    // already wired up via `compile_str`). With the import in
    // hand, the assertions below check that the binary's bytes
    // contain the import name at least twice -- once in the
    // dynamic-import table and once in the static (PLT-trampoline)
    // symbol table the linker emits per target.
    let program = super::compile_str("int main() { printf(\"x\"); return 0; }");
    let needle = b"printf";
    for target in [
        Target::MacOSAarch64,
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let bytes = crate::c5::object::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::default(),
        )
        .unwrap_or_else(|e| panic!("emit_native({target:?}): {e}"));
        let occurrences = bytes.windows(needle.len()).filter(|w| *w == needle).count();
        assert!(
            occurrences >= 2,
            "{target:?}: expected `printf` byte sequence at least twice (dynamic \
             import + local PLT-trampoline symbol), found {occurrences}"
        );
    }
}

/// A profiler attributes a sample by `[st_value, st_value + st_size)`,
/// so every defined function must carry a non-zero `st_size` in the ELF
/// `.symtab` -- perf / `nm` / `gdb` otherwise cannot name the address.
/// The static `priv` exercises the merged-path local-symbol carry
/// (`link_native_objects` -> `local_funcs` -> synth `func_names`), which
/// a previous globals-only attempt missed; `pub` / `main` cover the
/// global path. Link the program and confirm all three appear as sized
/// `STT_FUNC` symbols.
#[test]
fn defined_functions_get_sized_symtab_entries() {
    use crate::{NativeOptions, Target};
    // Compile without the header prelude: the program needs no libc,
    // and pulling the prelude would drag a tentative `environ` into the
    // link alongside the runtime's definition.
    let program = super::compile_str_bare(
        "static int priv(int x){return x*x;} \
         int pub(int x){return priv(x)+1;} \
         int main(){return pub(7);}",
    );
    let bytes =
        super::link_executable_with_runtime(&program, Target::LinuxX64, NativeOptions::default())
            .expect("link LinuxX64");
    let funcs = elf_func_symbols(&bytes);
    for name in ["priv", "pub", "main"] {
        let size = funcs.iter().find(|(n, _)| n == name).map(|(_, s)| *s);
        assert!(
            matches!(size, Some(s) if s > 0),
            "function `{name}` must have a non-zero .symtab st_size; got {size:?} \
             (all FUNC symbols: {funcs:?})"
        );
    }
}

/// `#pragma binding(data libc::environ, "__environ")` (in `<unistd.h>`,
/// `__linux__`) records a data-import copy relocation in the object's
/// `.note.badc`, mapping the local `environ` to the host's `__environ`.
/// The linker turns it into an `R_*_COPY` against runtime.c's environ
/// slot (verified end to end by the native demos); here the object-level
/// contract is locked: the host symbol name reaches the relocatable
/// object, and a program with no environ binding carries none.
#[test]
fn environ_data_binding_records_copy_relocation() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    let emit_obj = |src: &str| -> alloc::vec::Vec<u8> {
        // The binding is `__linux__`-gated, so compile for a Linux
        // target; the host may be macOS, where environ takes a different
        // form.
        let program = Compiler::with_target(src.to_string(), Target::LinuxX64)
            .compile()
            .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::default()
        };
        emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit")
    };
    let has_host_symbol = |bytes: &[u8]| {
        let needle = b"__environ";
        bytes.windows(needle.len()).any(|w| w == needle)
    };

    let with_env = emit_obj("#include <unistd.h>\nint main(void){ return environ != 0; }");
    assert!(
        has_host_symbol(&with_env),
        "a program referencing environ must record the __environ copy relocation"
    );

    let without_env = emit_obj("int main(void){ return 0; }");
    assert!(
        !has_host_symbol(&without_env),
        "a program with no environ binding must not record __environ"
    );
}

/// POSIX `setenv` carries a third `overwrite` argument that msvcrt's
/// 2-parameter `_putenv_s` lacks, so `<stdlib.h>` defines `setenv` as
/// an inline wrapper that probes `getenv` before calling `_putenv_s`,
/// honoring the flag. The wrapper compiles in place -- the object
/// imports `_putenv_s` and carries no undefined `setenv` symbol -- and
/// the same definition serves the interpreter and JIT paths.
#[test]
fn setenv_inline_wrapper_imports_putenv_s_on_windows() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_target(
        "#include <stdlib.h>\nint main(void){ setenv(\"K\", \"V\", 0); return 0; }".to_string(),
        Target::WindowsX64,
    )
    .compile()
    .expect("compile setenv TU for WindowsX64");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..NativeOptions::default()
    };
    let obj = emit_native_with_options(&program, Target::WindowsX64, opts).expect("emit");
    let contains = |needle: &[u8]| obj.windows(needle.len()).any(|w| w == needle);
    assert!(
        contains(b"_putenv_s"),
        "the inline setenv wrapper must import _putenv_s"
    );
}

/// A `#pragma binding(data lib::sym, ...)` import on the Windows
/// x86-64 PE target must lower the data reference as a load of the
/// import's IAT slot, not as the address of a `jmp [IAT]` call
/// trampoline. The msvcrt `_sys_errlist` array is the bundled
/// `<stdlib.h>` example (`extern char *_sys_errlist[]` bound to
/// `msvcrt::_sys_errlist` under `_WIN32`); the binding is declared
/// inline here so the TU pulls in only the data import under test.
/// Compile a TU
/// that indexes the array, link a complete PE, locate the import's
/// IAT slot via the standard import-table walk, and confirm the
/// referencing `.text` instruction is a RIP-relative `mov`
/// (`48 8B`, an IAT-slot load) rather than `lea` (`48 8D`, an
/// address-of), and that no `jmp [rip]` thunk (`FF 25`) stands in
/// for the data symbol.
#[test]
fn data_import_lowers_as_iat_load_not_thunk_on_windows_x64() {
    use crate::{Compiler, NativeOptions, Target};
    // The msvcrt data binding is `_WIN32`-gated in the bundled
    // header; declare it directly and compile for the Windows target
    // so the binding is in scope regardless of the build host.
    let program = Compiler::with_target(
        "#pragma dylib(msvcrt, \"msvcrt.dll\")\n\
         #pragma binding(data msvcrt::_sys_errlist, \"_sys_errlist\")\n\
         extern char *_sys_errlist[];\n\
         char *f(int i){return _sys_errlist[i];}\n\
         int main(void){return f(1)!=0;}\n"
            .to_string(),
        Target::WindowsX64,
    )
    .compile()
    .expect("compile _sys_errlist TU for WindowsX64");
    let image =
        super::link_executable_with_runtime(&program, Target::WindowsX64, NativeOptions::default())
            .expect("link WindowsX64 executable");

    let slot_rva = pe_iat_slot_rva(&image, "_sys_errlist")
        .expect("_sys_errlist must appear as a named IAT import");
    let (text_rva, text) = pe_text_section(&image).expect("PE must carry a .text section");

    // Scan .text for every RIP-relative instruction whose computed
    // target equals the IAT slot RVA. `lea`/`mov reg, [rip+disp32]`
    // share the 7-byte REX.W + modrm 0x05 + disp32 layout, differing
    // only in the opcode (0x8D vs 0x8B); the `jmp [rip+disp32]` thunk
    // is `FF 25` + disp32 over 6 bytes.
    let mut lea_to_slot = 0usize; // 48 8D 05 (address-of -- the bug)
    let mut mov_to_slot = 0usize; // 48 8B 05 (IAT-slot load -- the fix)
    let mut thunk_to_slot = 0usize; // FF 25     (call trampoline standing in for data)
    let mut i = 0usize;
    while i + 7 <= text.len() {
        if text[i] == 0x48 && text[i + 2] == 0x05 && (text[i + 1] == 0x8D || text[i + 1] == 0x8B) {
            let disp = i32::from_le_bytes(text[i + 3..i + 7].try_into().unwrap());
            let instr_rva = text_rva + i as u32;
            let target = (instr_rva as i64 + 7 + disp as i64) as u32;
            if target == slot_rva {
                if text[i + 1] == 0x8D {
                    lea_to_slot += 1;
                } else {
                    mov_to_slot += 1;
                }
            }
        }
        if text[i] == 0xFF && text[i + 1] == 0x25 {
            let disp = i32::from_le_bytes(text[i + 2..i + 6].try_into().unwrap());
            let instr_rva = text_rva + i as u32;
            let target = (instr_rva as i64 + 6 + disp as i64) as u32;
            if target == slot_rva {
                thunk_to_slot += 1;
            }
        }
        i += 1;
    }

    assert_eq!(
        thunk_to_slot, 0,
        "data import _sys_errlist must not get a `jmp [IAT]` (FF 25) call trampoline; \
         found {thunk_to_slot} targeting its IAT slot"
    );
    assert_eq!(
        lea_to_slot, 0,
        "data import _sys_errlist reference must not be `lea` (48 8D, address-of a thunk); \
         found {lea_to_slot} targeting its IAT slot"
    );
    assert!(
        mov_to_slot >= 1,
        "data import _sys_errlist reference must be a RIP-relative `mov` (48 8B, IAT-slot load); \
         found none targeting its IAT slot"
    );
}

/// PE has no COPY-relocation semantics: a symbol both bound as a data
/// import and defined in the image would resolve to the local slot and
/// silently drop the binding, so the link must reject the collision.
/// (On ELF the same dual is the design: the local definition is the
/// COPY destination.)
#[test]
fn data_binding_with_local_definition_is_a_link_error_on_windows_x64() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    let program = Compiler::with_options(
        "#pragma dylib(msvcrt, \"msvcrt.dll\")\n\
         #pragma binding(data msvcrt::__badc_env_alias, \"_environ\")\n\
         char **__badc_env_alias;\n\
         int main(void){return __badc_env_alias == 0;}\n"
            .to_string(),
        Target::WindowsX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile colliding data-binding TU for WindowsX64");
    let err =
        super::link_executable_with_runtime(&program, Target::WindowsX64, NativeOptions::default())
            .expect_err("a data binding shadowed by a local definition must fail the link");
    assert!(
        err.contains("bound as a data import"),
        "diagnostic must name the collision; got: {err}"
    );
}

/// A data binding whose local name differs from the host symbol must
/// put the HOST name in the import table: the loader resolves the
/// import-by-name entry against the DLL's export table, and msvcrt
/// exports `_environ`, not the local alias. Emitting the local name
/// loads with STATUS_ENTRYPOINT_NOT_FOUND (0xC0000139).
#[test]
fn data_import_renamed_binding_uses_export_name_on_windows_x64() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    // Mirror the CLI: user TUs compile with `no_entry_point` so an
    // `extern` data declaration stays UNDEF instead of taking a
    // tentative local slot, letting the link admit the data import.
    let program = Compiler::with_options(
        "#pragma dylib(msvcrt, \"msvcrt.dll\")\n\
         #pragma binding(data msvcrt::__badc_env_alias, \"_environ\")\n\
         extern char **__badc_env_alias;\n\
         int main(void){return __badc_env_alias == 0;}\n"
            .to_string(),
        Target::WindowsX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile renamed data-binding TU for WindowsX64");
    let image =
        super::link_executable_with_runtime(&program, Target::WindowsX64, NativeOptions::default())
            .expect("link WindowsX64 executable");
    assert!(
        pe_iat_slot_rva(&image, "_environ").is_some(),
        "renamed data binding must import the host symbol `_environ`"
    );
    assert!(
        pe_iat_slot_rva(&image, "__badc_env_alias").is_none(),
        "the local alias must not appear in the import table"
    );
}

/// The bundled `<stdlib.h>` binds the Windows/x64 environment vectors
/// as msvcrt data imports: `_environ` / `_wenviron` under their export
/// names and POSIX `environ` aliased to the `_environ` export. No unit
/// (the runtime included) may define them locally -- a local slot
/// shadows the import and reads NULL, which upstream surfaced as an
/// empty environment in every spawned child process.
#[test]
fn windows_x64_environ_family_resolves_to_msvcrt_data_imports() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    let program = Compiler::with_options(
        "#include <stdlib.h>\n\
         int main(void){return (environ != 0) + (_environ != 0) + (_wenviron != 0);}\n"
            .to_string(),
        Target::WindowsX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile environ TU for WindowsX64");
    let image =
        super::link_executable_with_runtime(&program, Target::WindowsX64, NativeOptions::default())
            .expect("link WindowsX64 executable");
    assert_eq!(
        pe_import_dll_of(&image, "_environ").as_deref(),
        Some("msvcrt.dll"),
        "`_environ` must be a msvcrt data import"
    );
    assert_eq!(
        pe_import_dll_of(&image, "_wenviron").as_deref(),
        Some("msvcrt.dll"),
        "`_wenviron` must be a msvcrt data import"
    );
    assert!(
        pe_iat_slot_rva(&image, "environ").is_none(),
        "POSIX `environ` must alias the `_environ` export, not import a bare `environ`"
    );
}

/// On Windows/arm64 msvcrt.dll exports no environment data symbols, so
/// `<stdlib.h>` maps the family to msvcrt's `_get_environ` /
/// `_get_wenviron` accessor functions. ucrtbase's `__p__*` accessors
/// must not appear: they read UCRT's separate environment copy, which
/// msvcrt's getenv / _putenv / _wgetenv never update.
#[test]
fn windows_arm64_environ_family_lowers_via_msvcrt_accessors() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    let program = Compiler::with_options(
        "#include <stdlib.h>\n\
         int main(void){return (environ != 0) + (_environ != 0) + (_wenviron != 0);}\n"
            .to_string(),
        Target::WindowsAarch64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile environ TU for WindowsAarch64");
    let image = super::link_executable_with_runtime(
        &program,
        Target::WindowsAarch64,
        NativeOptions::default(),
    )
    .expect("link WindowsAarch64 executable");
    for accessor in ["_get_environ", "_get_wenviron"] {
        assert_eq!(
            pe_import_dll_of(&image, accessor).as_deref(),
            Some("msvcrt.dll"),
            "`{accessor}` must be imported from msvcrt.dll"
        );
    }
    for absent in [
        "environ",
        "_environ",
        "_wenviron",
        "__p__wenviron",
        "__p__environ",
    ] {
        assert!(
            pe_iat_slot_rva(&image, absent).is_none(),
            "`{absent}` must not appear in the arm64 import table"
        );
    }
}

/// A data binding must route to its declaring dylib's import
/// descriptor. Data imports carry no call site, so their routing rides
/// the `.note.badc` binding map; without an entry the import falls
/// back to descriptor 0, which here is kernel32.dll -- a DLL that does
/// not export `_environ`, so the image would fail to load.
#[test]
fn data_import_routes_to_declaring_dylib_on_windows_x64() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    let program = Compiler::with_options(
        "#pragma dylib(kernel32, \"kernel32.dll\")\n\
         #pragma binding(kernel32::GetCurrentProcess, \"GetCurrentProcess\")\n\
         void *GetCurrentProcess(void);\n\
         #pragma dylib(msvcrt, \"msvcrt.dll\")\n\
         #pragma binding(data msvcrt::__badc_env_alias, \"_environ\")\n\
         extern char **__badc_env_alias;\n\
         int main(void){return GetCurrentProcess() != 0 && __badc_env_alias == 0;}\n"
            .to_string(),
        Target::WindowsX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile dylib-routing TU for WindowsX64");
    let image =
        super::link_executable_with_runtime(&program, Target::WindowsX64, NativeOptions::default())
            .expect("link WindowsX64 executable");
    assert_eq!(
        pe_import_dll_of(&image, "_environ").as_deref(),
        Some("msvcrt.dll"),
        "`_environ` must sit under msvcrt.dll's import descriptor"
    );
}

/// C99 7.19.6.5p3 / 7.19.6.12p3: snprintf / vsnprintf return the
/// untruncated length and NUL-terminate a nonempty buffer; msvcrt's
/// `_snprintf` / `_vsnprintf` return -1 and omit the NUL. The standard
/// spellings therefore carry no msvcrt binding on Windows: they resolve
/// against the runtime's conforming definitions, which wrap
/// `_vsnprintf` + `_vscprintf`.
#[test]
fn windows_snprintf_resolves_to_the_runtime_definition() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    for target in [Target::WindowsX64, Target::WindowsAarch64] {
        let program = Compiler::with_options(
            "#include <stdio.h>\n\
             int main(void){char b[4]; return snprintf(b, 4, \"%d\", 123456);}\n"
                .to_string(),
            target,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile snprintf TU");
        let image = super::link_executable_with_runtime(&program, target, NativeOptions::default())
            .expect("link Windows executable");
        for imported in ["_vscprintf", "_vsnprintf"] {
            assert_eq!(
                pe_import_dll_of(&image, imported).as_deref(),
                Some("msvcrt.dll"),
                "{target:?}: the runtime definition must import `{imported}`"
            );
        }
        for absent in ["_snprintf", "snprintf", "vsnprintf"] {
            assert!(
                pe_iat_slot_rva(&image, absent).is_none(),
                "{target:?}: `{absent}` must not appear in the import table"
            );
        }
    }
}

/// A shared library compiles the runtime with `__BADC_C5_CRT__` but
/// without the startup gate; the CRT section alone must still define
/// the C99 snprintf / vsnprintf so a DLL's calls resolve locally.
#[test]
fn windows_runtime_crt_section_defines_snprintf_without_start_gate() {
    use crate::{
        CompileOptions, Compiler, NativeOptions, OutputKind, Target, embedded_runtime,
        link_native_objects, parse_native_elf,
    };
    let target = Target::WindowsX64;
    let reloc = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let mut objs = Vec::new();
    for (name, body) in embedded_runtime() {
        let copts = CompileOptions::default()
            .with_no_entry_point(true)
            .with_defines(vec![("__BADC_C5_CRT__".to_string(), "1".to_string())]);
        let rt = Compiler::with_options(body.to_string(), target, copts)
            .compile()
            .unwrap_or_else(|e| panic!("compile runtime {name}: {e}"));
        let bytes = crate::emit_native_with_options(&rt, target, reloc)
            .unwrap_or_else(|e| panic!("emit runtime {name}: {e}"));
        objs.push(parse_native_elf(&bytes).expect("parse runtime object"));
    }
    let merged = link_native_objects(&objs).expect("link CRT-only runtime");
    for def in ["snprintf", "vsnprintf"] {
        assert!(
            merged.defined.contains_key(def),
            "the CRT section must define `{def}`"
        );
    }
    assert!(
        !merged.defined.contains_key("__c5_entry"),
        "the startup section must stay gated out"
    );
}

/// Return the `(VirtualAddress, raw bytes)` of the PE `.text`
/// section. RVA-relative byte scans use the VirtualAddress; the raw
/// bytes are the section's file image.
fn pe_text_section(image: &[u8]) -> Option<(u32, &[u8])> {
    let u16a = |o: usize| u16::from_le_bytes(image[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(image[o..o + 4].try_into().unwrap());
    let pe = u32a(0x3c) as usize;
    let num_sections = u16a(pe + 6) as usize;
    let opt_size = u16a(pe + 20) as usize;
    let sec_table = pe + 24 + opt_size;
    for s in 0..num_sections {
        let sh = sec_table + s * 40;
        if &image[sh..sh + 5] == b".text" {
            let va = u32a(sh + 12);
            let raw_off = u32a(sh + 20) as usize;
            let raw_size = u32a(sh + 16) as usize;
            return Some((va, &image[raw_off..raw_off + raw_size]));
        }
    }
    None
}

/// `(virtual_size, virtual_address, size_of_raw_data)` of the named PE
/// section (an 8-byte NUL-padded name).
fn pe_section_dims(image: &[u8], name: &[u8; 8]) -> Option<(u32, u32, u32)> {
    let u16a = |o: usize| u16::from_le_bytes(image[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(image[o..o + 4].try_into().unwrap());
    let pe = u32a(0x3c) as usize;
    let num_sections = u16a(pe + 6) as usize;
    let opt_size = u16a(pe + 20) as usize;
    let sec_table = pe + 24 + opt_size;
    (0..num_sections)
        .map(|s| sec_table + s * 40)
        .find(|&sh| &image[sh..sh + 8] == name)
        .map(|sh| (u32a(sh + 8), u32a(sh + 12), u32a(sh + 16)))
}

/// Under segregation a wholly-zero global enlarges `.data`'s VirtualSize
/// past its SizeOfRawData -- the loader zero-fills the tail and the
/// bytes never reach disk. Every other section's RVA must clear the
/// enlarged `.data` extent so the bss tail does not overlap it.
#[test]
fn bss_segregation_extends_pe_data_virtual_size() {
    use crate::{NativeOptions, Target};
    let opts = NativeOptions {
        bss_segregate: true,
        ..NativeOptions::new()
    };
    let program = super::compile_str_bare(
        "static long zeros[4096]; long *const p = &zeros[3000]; \
         int main(void){ return (p == &zeros[3000]) ? 0 : 1; }",
    );
    let bytes = super::link_executable_with_runtime(&program, Target::WindowsX64, opts)
        .expect("link WindowsX64");
    let (vsize, va, raw) = pe_section_dims(&bytes, b".data\0\0\0").expect(".data section");
    assert!(
        vsize > raw,
        ".data VirtualSize {vsize:#x} must exceed SizeOfRawData {raw:#x} for the bss tail"
    );
    // No section starts inside `.data`'s [va, va + vsize) virtual extent.
    let u16a = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let pe = u32a(0x3c) as usize;
    let sec_table = pe + 24 + u16a(pe + 20) as usize;
    for s in 0..u16a(pe + 6) as usize {
        let other_va = u32a(sec_table + s * 40 + 12);
        assert!(
            other_va <= va || other_va >= va + vsize,
            "section at RVA {other_va:#x} overlaps the .data bss extent [{va:#x}, {:#x})",
            va + vsize
        );
    }
}

/// Walk a PE32+ import table and return the DLL name whose descriptor
/// carries the named import. Same walk as [`pe_iat_slot_rva`], reading
/// each descriptor's Name field instead of the IAT slot.
fn pe_import_dll_of(image: &[u8], want: &str) -> Option<String> {
    let u16a = |o: usize| u16::from_le_bytes(image[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(image[o..o + 4].try_into().unwrap());
    let u64a = |o: usize| u64::from_le_bytes(image[o..o + 8].try_into().unwrap());
    let pe = u32a(0x3c) as usize;
    let opt = pe + 24;
    let import_dir_rva = u32a(opt + 112 + 8);
    if import_dir_rva == 0 {
        return None;
    }
    let num_sections = u16a(pe + 6) as usize;
    let opt_size = u16a(pe + 20) as usize;
    let sec_table = pe + 24 + opt_size;
    let rva_to_off = |rva: u32| -> Option<usize> {
        for s in 0..num_sections {
            let sh = sec_table + s * 40;
            let va = u32a(sh + 12);
            let vsize = u32a(sh + 8);
            let raw_off = u32a(sh + 20);
            if rva >= va && rva < va + vsize {
                return Some((raw_off + (rva - va)) as usize);
            }
        }
        None
    };
    let cstr_at = |off: usize| -> String {
        let end = image[off..]
            .iter()
            .position(|&c| c == 0)
            .map_or(off, |n| off + n);
        String::from_utf8_lossy(&image[off..end]).into_owned()
    };
    let import_dir_off = rva_to_off(import_dir_rva)?;
    let mut d = import_dir_off;
    loop {
        let ilt_rva = u32a(d);
        let name_rva = u32a(d + 12);
        if ilt_rva == 0 && name_rva == 0 && u32a(d + 16) == 0 {
            break;
        }
        let ilt_off = rva_to_off(ilt_rva)?;
        let mut k = 0usize;
        loop {
            let entry = u64a(ilt_off + k * 8);
            if entry == 0 {
                break;
            }
            if entry & (1u64 << 63) == 0 {
                let name_off = rva_to_off(entry as u32)? + 2;
                if cstr_at(name_off) == want {
                    return Some(cstr_at(rva_to_off(name_rva)?));
                }
            }
            k += 1;
        }
        d += 20;
    }
    None
}

/// Walk a PE32+ import table and return the RVA of the IAT slot for
/// the named import. Follows the format: data directory 1 -> import
/// descriptors; each descriptor's OriginalFirstThunk (ILT) entries
/// reference an `IMAGE_IMPORT_BY_NAME` (u16 hint + NUL name); the
/// parallel FirstThunk (IAT) entry at the same index is the slot.
fn pe_iat_slot_rva(image: &[u8], want: &str) -> Option<u32> {
    let u16a = |o: usize| u16::from_le_bytes(image[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(image[o..o + 4].try_into().unwrap());
    let u64a = |o: usize| u64::from_le_bytes(image[o..o + 8].try_into().unwrap());
    let pe = u32a(0x3c) as usize;
    let opt = pe + 24;
    // PE32+ data directories start at optional-header offset 112;
    // entry 1 is the Import Directory (8 bytes: RVA, size).
    let import_dir_rva = u32a(opt + 112 + 8);
    if import_dir_rva == 0 {
        return None;
    }
    // Section table maps RVAs to file offsets.
    let num_sections = u16a(pe + 6) as usize;
    let opt_size = u16a(pe + 20) as usize;
    let sec_table = pe + 24 + opt_size;
    let rva_to_off = |rva: u32| -> Option<usize> {
        for s in 0..num_sections {
            let sh = sec_table + s * 40;
            let va = u32a(sh + 12);
            let vsize = u32a(sh + 8);
            let raw_off = u32a(sh + 20);
            if rva >= va && rva < va + vsize {
                return Some((raw_off + (rva - va)) as usize);
            }
        }
        None
    };
    let import_dir_off = rva_to_off(import_dir_rva)?;
    // 20-byte descriptors terminated by an all-zero entry.
    let mut d = import_dir_off;
    loop {
        let ilt_rva = u32a(d); // OriginalFirstThunk
        let iat_rva = u32a(d + 16); // FirstThunk
        if ilt_rva == 0 && iat_rva == 0 && u32a(d + 12) == 0 {
            break;
        }
        let ilt_off = rva_to_off(ilt_rva)?;
        let mut k = 0usize;
        loop {
            let entry = u64a(ilt_off + k * 8);
            if entry == 0 {
                break;
            }
            // High bit set selects ordinal import; named imports
            // store the hint/name RVA in the low bits.
            if entry & (1u64 << 63) == 0 {
                let name_off = rva_to_off(entry as u32)? + 2; // skip u16 hint
                let end = image[name_off..]
                    .iter()
                    .position(|&c| c == 0)
                    .map_or(name_off, |n| name_off + n);
                if &image[name_off..end] == want.as_bytes() {
                    return Some(iat_rva + (k * 8) as u32);
                }
            }
            k += 1;
        }
        d += 20;
    }
    None
}

/// Walk an emitted ELF64 `.symtab` and return `(name, st_size)` for
/// every `STT_FUNC` entry. Minimal fixed-offset parse for the symbol-
/// size regression above.
fn elf_func_symbols(b: &[u8]) -> alloc::vec::Vec<(alloc::string::String, u64)> {
    let u16a = |o: usize| u16::from_le_bytes(b[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
    let u64a = |o: usize| u64::from_le_bytes(b[o..o + 8].try_into().unwrap());
    let shoff = u64a(0x28) as usize;
    let shentsize = u16a(0x3a) as usize;
    let shnum = u16a(0x3c) as usize;
    // SHT_SYMTAB == 2; its sh_link names the matching .strtab section.
    let mut symtab_sh = None;
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        if u32a(sh + 4) == 2 {
            symtab_sh = Some(sh);
            break;
        }
    }
    let Some(sh) = symtab_sh else {
        return alloc::vec::Vec::new();
    };
    let sym_off = u64a(sh + 0x18) as usize;
    let sym_len = u64a(sh + 0x20) as usize;
    let strsh = shoff + (u32a(sh + 0x28) as usize) * shentsize;
    let str_off = u64a(strsh + 0x18) as usize;
    let mut out = alloc::vec::Vec::new();
    let mut p = sym_off;
    while p + 24 <= sym_off + sym_len {
        let st_name = u32a(p) as usize;
        let st_info = b[p + 4];
        let st_size = u64a(p + 16);
        if st_info & 0xf == 2 {
            let s = str_off + st_name;
            let e = b[s..].iter().position(|&c| c == 0).map_or(s, |n| s + n);
            out.push((
                alloc::string::String::from_utf8_lossy(&b[s..e]).into_owned(),
                st_size,
            ));
        }
        p += 24;
    }
    out
}

/// `st_value` of the named FUNC symbol. In a relocatable object `.text`
/// starts at vaddr 0, so this is the function's byte offset within the
/// `.text` section bytes returned by [`elf64_section`].
fn elf_func_value(b: &[u8], name: &str) -> Option<u64> {
    let u16a = |o: usize| u16::from_le_bytes(b[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
    let u64a = |o: usize| u64::from_le_bytes(b[o..o + 8].try_into().unwrap());
    let shoff = u64a(0x28) as usize;
    let shentsize = u16a(0x3a) as usize;
    let shnum = u16a(0x3c) as usize;
    let mut symtab_sh = None;
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        if u32a(sh + 4) == 2 {
            symtab_sh = Some(sh);
            break;
        }
    }
    let sh = symtab_sh?;
    let sym_off = u64a(sh + 0x18) as usize;
    let sym_len = u64a(sh + 0x20) as usize;
    let strsh = shoff + (u32a(sh + 0x28) as usize) * shentsize;
    let str_off = u64a(strsh + 0x18) as usize;
    let mut p = sym_off;
    while p + 24 <= sym_off + sym_len {
        let st_name = u32a(p) as usize;
        let st_info = b[p + 4];
        let st_value = u64a(p + 8);
        if st_info & 0xf == 2 {
            let s = str_off + st_name;
            let e = b[s..].iter().position(|&c| c == 0).map_or(s, |n| s + n);
            if b[s..e] == *name.as_bytes() {
                return Some(st_value);
            }
        }
        p += 24;
    }
    None
}

/// A block whose unconditional `Jmp` targets the next block in layout
/// must fall through, not emit a jump to the immediately-following
/// instruction (`e9 00 00 00 00` -- `jmp rel32 = 0` -- on x86-64). Such
/// dead jumps inflate the dynamic branch count and code size. Compile a
/// branchy function and confirm the byte sequence is absent.
#[test]
fn jmp_to_next_block_falls_through() {
    use crate::{NativeOptions, Target};
    let program = super::compile_str_bare(
        "int f(int x){ int r; if(x>0){r=1;}else{r=2;} return r+x; } \
         int main(){ return f(3); }",
    );
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxX64,
        NativeOptions::new().with_optimize(),
    )
    .expect("emit LinuxX64");
    let dead = bytes
        .windows(5)
        .filter(|w| *w == [0xe9, 0x00, 0x00, 0x00, 0x00])
        .count();
    assert_eq!(
        dead, 0,
        "found {dead} `jmp +0` (dead fall-through jump) byte sequences"
    );
}

/// Switch lowering: a dense case set (>= 8 cases, span < 2 * cases)
/// dispatches through `Terminator::JumpTable` behind an unsigned
/// bounds check to default; a hole's table slot routes to default.
/// A small or sparse set keeps the balanced compare tree.
#[test]
fn dense_switch_lowers_to_jump_table_sparse_keeps_tree() {
    use crate::Target;
    use crate::c5::ir::{FunctionSsa, Terminator};
    let program = super::compile_str_bare(
        "int dense8(int x) { switch (x) { \
             case 3: return 1; case 4: return 2; case 5: return 3; \
             case 6: return 4; case 8: return 5; case 9: return 6; \
             case 10: return 7; case 11: return 8; default: return 0; } } \
         int dense7(int x) { switch (x) { \
             case 0: return 1; case 1: return 2; case 2: return 3; \
             case 3: return 4; case 4: return 5; case 5: return 6; \
             case 6: return 7; default: return 0; } } \
         int half8(int x) { switch (x) { \
             case 0: return 1; case 2: return 2; case 4: return 3; \
             case 6: return 4; case 8: return 5; case 10: return 6; \
             case 12: return 7; case 14: return 8; default: return 0; } } \
         int sparse8(int x) { switch (x) { \
             case 0: return 1; case 3: return 2; case 6: return 3; \
             case 9: return 4; case 12: return 5; case 15: return 6; \
             case 18: return 7; case 21: return 8; default: return 0; } } \
         int main(void) { return dense8(3) + dense7(0) + half8(0) + sparse8(0); }",
    );
    let funcs = crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, Target::host())
        .expect("produce_ssa_funcs");
    let table_of = |name: &str| -> Option<(u32, u32)> {
        let f: &FunctionSsa = funcs.iter().find(|f| f.name == name).unwrap();
        f.blocks.iter().enumerate().find_map(|(b, blk)| {
            if let Terminator::JumpTable { table, .. } = blk.terminator {
                Some((b as u32, table))
            } else {
                None
            }
        })
    };
    // dense8: cases 3..11 with a hole at 7 -> a 9-entry table whose
    // hole slot names the same block the bounds check defaults to.
    let (dispatch, table) = table_of("dense8").expect("dense8 uses a jump table");
    let dense8: &FunctionSsa = funcs.iter().find(|f| f.name == "dense8").unwrap();
    assert_eq!(dense8.jump_tables[table as usize].len(), 9);
    let deflt = dense8
        .blocks
        .iter()
        .find_map(|blk| match blk.terminator {
            Terminator::Bz {
                target,
                fall_through,
                ..
            } if fall_through == dispatch => Some(target),
            _ => None,
        })
        .expect("bounds check branches to default ahead of the table");
    assert_eq!(dense8.jump_tables[table as usize][4], deflt);
    // half8: span 14 with 8 cases passes the 50% density gate.
    assert!(table_of("half8").is_some(), "half-dense set uses a table");
    // dense7 is below the case minimum; sparse8 fails the density gate.
    assert!(table_of("dense7").is_none(), "7 cases keep the tree");
    assert!(table_of("sparse8").is_none(), "sparse set keeps the tree");
}

/// C99 6.3.1.8 + 6.5p5: the post-binop sign-narrow that renormalizes an
/// `int` result is built as `Inst::Extend { kind: I32 }`, which the
/// aarch64 emit lowers to `SXTW Xd, Wn` (`SBFM Xd, Xn, #0, #31`) and the
/// x86_64 emit to `movsxd r64, r32`. The product feeds a return, whose
/// upper bits are observed, so the extension is kept. Verify the encoded
/// byte sequence shows up and the pre-canonicalization shift pair (a
/// `movz xN, #32` feeding an `lsl`) does not.
#[test]
fn sxtw_fold_collapses_int_mul_sign_narrow() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str(
        "int product(int a, int b) { return a * b; } int main() { return product(7, 6); }",
    );
    let bytes_arm =
        emit_native_with_options(&program, Target::MacOSAarch64, NativeOptions::default())
            .expect("emit_native MacOSAarch64");
    // SXTW (SBFM with immr=0, imms=31) carries the fixed high bytes
    // 0x40 0x93 regardless of the rd / rn register fields. Scan for
    // that opcode signature so the assertion stays reg-agnostic.
    let any_sxtw = bytes_arm.windows(4).any(|w| w[2] == 0x40 && w[3] == 0x93);
    assert!(
        any_sxtw,
        "expected an SXTW byte pattern in aarch64 image (the sign-narrow Shl/Shr pair did not fold)",
    );
    // Pre-fold: the lsl #32 / asr #32 pair was materialised through a
    // `movz xN, #32` before the lsl. `#32` lives in bits 21..5 of the
    // movz word, so the encoded value 32 produces high bytes 0x80 0xd2
    // regardless of which N gets picked. Their absence confirms the
    // fold removed the shift pair.
    let any_movz_32 = bytes_arm
        .windows(4)
        .any(|w| w[2] == 0x80 && w[3] == 0xd2 && w[1] == 0x04);
    assert!(
        !any_movz_32,
        "expected the pre-fold `movz xN, #32` pattern to be absent post-fold",
    );

    let bytes_x64 = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit_native LinuxX64");
    // movsxd r, r: REX.W prefix (0x48..0x4f with W=1), opcode 0x63,
    // ModR/M with mod=11 (register direct). Scan for that shape so
    // the test does not depend on which register the allocator picks.
    let any_movsxd_r_r = bytes_x64.windows(3).any(|w| {
        let rex = w[0];
        (rex & 0xf0) == 0x40 && (rex & 0x08) != 0 && w[1] == 0x63 && (w[2] & 0xc0) == 0xc0
    });
    assert!(
        any_movsxd_r_r,
        "expected a `movslq` reg/reg byte pattern in x86_64 image",
    );
}

/// C99 6.6 constant-expression evaluation: both-IntLit operands
/// fold to a single SSA `Imm`. The walker's `Expr::Binary` arm
/// detects this and emits no binop at all. Run via the in-process
/// JIT so the fold is verified end-to-end.
#[test]
fn constant_fold_evaluates_binops_at_translation_time() {
    use crate::{Compiler, jit_run};
    // Each return value exercises one folded shape. The compile
    // succeeds only if the fold produces a valid `Imm`; the JIT
    // exit code confirms the value is correct.
    let src = "
        int add(void)   { return 7 + 3; }
        int sub(void)   { return 100 - 42; }
        int mul(void)   { return 4 * 6; }
        int and_op(void){ return 0xff & 0x0f; }
        int or_op(void) { return 0x10 | 0x01; }
        int xor_op(void){ return 0xff ^ 0x0f; }
        int shl(void)   { return 1 << 8; }
        int shr(void)   { return 0x100 >> 4; }
        int eq_lt(void) { return 5 < 9; }
        int main(void) {
            if (add()    != 10)   return 1;
            if (sub()    != 58)   return 2;
            if (mul()    != 24)   return 3;
            if (and_op() != 0x0f) return 4;
            if (or_op()  != 0x11) return 5;
            if (xor_op() != 0xf0) return 6;
            if (shl()    != 256)  return 7;
            if (shr()    != 0x10) return 8;
            if (eq_lt()  != 1)    return 9;
            return 0;
        }
    ";
    let program = Compiler::new(src.into())
        .compile()
        .expect("constant-fold fixture compiles");
    let exit = jit_run(&program, &["constant_fold".to_string()])
        .expect("constant-fold fixture runs under JIT");
    assert_eq!(
        exit, 0,
        "constant-fold values must match standard arithmetic"
    );
}

/// Algebraic peepholes inside `SsaBuilder::binop_imm`: identity
/// rhs values (`Add/Sub/Or/Xor/Shift` with 0, `Mul` with 1,
/// `And` with -1) return the lhs unchanged; zero-collapse rhs
/// values (`Mul/And` with 0) produce `Imm(0)`. The compiler
/// always reaches these through `binop_imm` so each shape lands
/// in the SSA stream as either the lhs or a single Imm, and
/// the JIT exit confirms the value matches standard arithmetic.
#[test]
fn ssa_build_binop_imm_identity_and_zero_collapse() {
    use crate::{Compiler, jit_run};
    let src = "
        int identity_add(int x) { return x + 0; }
        int identity_sub(int x) { return x - 0; }
        int identity_or(int x)  { return x | 0; }
        int identity_xor(int x) { return x ^ 0; }
        int identity_shl(int x) { return x << 0; }
        int identity_shr(int x) { return x >> 0; }
        int identity_mul(int x) { return x * 1; }
        int identity_and(int x) { return x & -1; }
        int collapse_mul(int x) { return x * 0; }
        int collapse_and(int x) { return x & 0; }
        int main(void) {
            if (identity_add(42)  != 42) return 1;
            if (identity_sub(42)  != 42) return 2;
            if (identity_or(42)   != 42) return 3;
            if (identity_xor(42)  != 42) return 4;
            if (identity_shl(42)  != 42) return 5;
            if (identity_shr(42)  != 42) return 6;
            if (identity_mul(42)  != 42) return 7;
            if (identity_and(42)  != 42) return 8;
            if (collapse_mul(42)  != 0)  return 9;
            if (collapse_and(42)  != 0)  return 10;
            return 0;
        }
    ";
    let program = Compiler::new(src.into())
        .compile()
        .expect("identity/collapse fixture compiles");
    let exit = jit_run(&program, &["identity_collapse".to_string()])
        .expect("identity/collapse fixture runs under JIT");
    assert_eq!(
        exit, 0,
        "binop_imm identity / zero-collapse folds must preserve C99 semantics"
    );
}

/// A non-variadic callee whose every register-passed parameter is
/// `Inst::ParamRef`-seeded, has no address taken, and whose c5
/// cdecl slots have no surviving `LoadLocal` or `StoreLocal` with
/// consumers compiles with `frame.param_spill_bytes == 0`. The
/// prologue then skips the host-arg-reg spill block entirely and
/// the epilogue skips the matching `add sp` / `pop+add+push`
/// sequence. The structural marker -- the absence of any sub-then-str
/// shape pinned to a 16-byte stride -- locks the elision in. A
/// regression that brings back the spill (e.g. by dropping the
/// `frame.param_spill_bytes > 0` gate) gets caught here before it
/// reaches the perf workloads.
#[test]
fn native_eligible_callee_skips_param_spill_in_prologue() {
    use crate::{Compiler, NativeOptions, Target, emit_native_with_options};
    // `fib` reads `n` four times after mem2reg promotion; with the
    // `ParamRef` seed plus the prologue helper the slot drops out.
    let src = "
        static long fib(int n) {
            if (n < 2) return (long)n;
            return fib(n - 1) + fib(n - 2);
        }
        int main(void) { return (int)(fib(10) - 55); }
    ";
    let program = Compiler::new(crate::c5::tests::with_prelude(src))
        .compile()
        .expect("compile");
    let bytes = emit_native_with_options(
        &program,
        Target::MacOSAarch64,
        NativeOptions::new().with_optimize(),
    )
    .expect("emit_native");
    // The prologue's elided shape begins with the combined
    // `stp x29, x30, [sp, -0x10]!` (encoded as
    // `0xa9_bf_7b_fd`). The unelided shape begins with the
    // host-arg-reg spill `str x_i, [sp, -0x10]!` (or its
    // `sub sp, sp, #16` skip variant) -- neither encodes to
    // `0xa9_bf_7b_fd` as the first word at any callee's entry.
    // Scan the .text section's bytes for the elided stp at
    // some 4-byte-aligned offset; absence is the regression
    // marker.
    let stp_word: [u8; 4] = 0xa9_bf_7b_fd_u32.to_le_bytes();
    let found = bytes.windows(4).any(|w| w == stp_word);
    assert!(
        found,
        "expected the Native-elided prologue's `stp x29, x30, [sp, -16]!` byte word \
         (0xa9bf7bfd) to appear in the emitted .text; if absent, the elision \
         regressed and every fully-Native callee paid the c5 cdecl spill"
    );
}

/// A function whose only user-local has every store killed by
/// mem2reg's write-only-slot pass and uses no callee-saved
/// registers should have its frame allocation skipped: no `sub sp`
/// for the local, no x19 reservation, no `add sp` in the epilogue.
/// Verified by inspecting the byte stream for the `sub sp, sp, #16`
/// and `sub sp, sp, #32` words that the prior frame layout emitted
/// for this shape.
///
/// Without this elision, `int foo(void) { int a = 1; a = 2; return
/// 1; }` lowered with -O paid eight extra bytes of frame plus the
/// matching `sub sp` / `add sp` pair on every call. With this
/// commit the function lowers to `stp fp,lr; mov fp,sp; mov w0,1;
/// ldp fp,lr; ret` -- five instructions, twenty bytes.
#[test]
fn dead_local_only_function_skips_frame_sub_sp() {
    use crate::{Compiler, NativeOptions, Target, emit_native_with_options};
    let src = "
        static int foo(void) {
            int a = 1;
            a = 2;
            return 1;
        }
        int main(void) { return foo(); }
    ";
    let program = Compiler::new(crate::c5::tests::with_prelude(src))
        .compile()
        .expect("compile");
    // This asserts an exact frame-elision shape, which holds only with
    // the full register file; pin the allocator to the full pool so the
    // codegen_test pressure knobs (BADC_MAX_GPR / BADC_MAX_FPR) do not
    // perturb it.
    let bytes =
        crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(usize::MAX, usize::MAX, || {
            emit_native_with_options(
                &program,
                Target::MacOSAarch64,
                NativeOptions::new().with_optimize(),
            )
        })
        .expect("emit_native");
    // Foo's fully-elided shape is exactly two consecutive words:
    //   movz x0, #1                   -> 0xd2800020
    //   ret                           -> 0xd65f03c0
    // The leaf-prologue elision plus the empty-frame elision means
    // foo has no stp / mov fp,sp / sub sp / ldp / add sp / any
    // saves. A regression that reinstates the stp prologue breaks
    // the two-word adjacency. Other functions in the binary (the
    // c5 runtime shims, the start stub) can legitimately emit
    // `movz x0, #1` followed by something else; this positive
    // pattern stays specific to foo because nothing else returns
    // 1 with zero prologue.
    let movz_x0_1 = 0xd2800020_u32.to_le_bytes();
    let ret_x30 = 0xd65f03c0_u32.to_le_bytes();
    let mut found = false;
    for w in bytes.windows(8) {
        if w[0..4] == movz_x0_1 && w[4..8] == ret_x30 {
            found = true;
            break;
        }
    }
    assert!(
        found,
        "expected foo's leaf+frame-elided two-word shape \
         (movz x0, #1; ret) consecutive in .text; the absence means \
         either the frame elision regressed (some `sub sp` or `stp` \
         word slipped in) or the leaf elision regressed (the standard \
         prologue's stp x29, x30 came back). foo should compile to \
         exactly two instructions under -O on AAPCS64"
    );
}

/// True when `needle` appears as a contiguous subslice of `hay`.
fn contains_bytes(hay: &[u8], needle: &[u8]) -> bool {
    hay.windows(needle.len()).any(|w| w == needle)
}

/// x86_64 parallel-move cycle breaking uses `xchg`. A call that permutes
/// its caller's argument registers -- `other(b, a)` from `swap_call(a,
/// b)` -- forms a register cycle (rdi holds a but the call needs b there,
/// rsi the reverse). The argument marshaller resolves it with a single
/// `xchg rdi, rsi` (REX.W 87, bytes 48 87) rather than a three-move
/// shuffle through a scratch register.
#[test]
fn x64_arg_permutation_cycle_uses_xchg() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_target(
        "int other(int a, int b); \
         int swap_call(int a, int b) { return other(b, a); } \
         int main(void) { return swap_call(1, 2); }"
            .to_string(),
        Target::LinuxX64,
    )
    .compile()
    .expect("compile");
    let obj =
        crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(usize::MAX, usize::MAX, || {
            emit_native_with_options(
                &program,
                Target::LinuxX64,
                NativeOptions {
                    output_kind: OutputKind::Relocatable,
                    ..NativeOptions::new().with_optimize()
                },
            )
        })
        .expect("emit relocatable");
    let text = elf64_section(&obj, ".text").expect(".text");
    let entry = elf_func_value(&obj, "swap_call").expect("swap_call symbol") as usize;
    let end = (entry + 96).min(text.len());
    assert!(
        contains_bytes(&text[entry..end], &[0x48, 0x87]),
        "swap_call must break the rdi<->rsi argument cycle with `xchg` (REX.W 87 = 48 87); \
         bytes={:02x?}",
        &text[entry..end]
    );
}

/// x86_64 leaf-frame elision. A spill-free function that calls nothing
/// and needs no callee-saved register must emit no prologue: no `push
/// %rbp`, no `sub %rsp`, and no save of a scratch register. The emit
/// reserves r10 / r11 as its fixed scratch pair; both are caller-saved,
/// so a body that only uses scratch touches no callee-saved register and
/// `gpr_used` stays empty, letting `is_full_leaf` fire. (Before, the
/// secondary scratch was the callee-saved r13, saved unconditionally,
/// which forced a frame on every function and elided none.) The body
/// adds three arguments, so it exercises the `Binop` path that the old
/// over-broad save predicate always flagged.
#[test]
fn x64_spillfree_leaf_elides_frame_and_scratch_save() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_target(
        "long leaf_add(long a, long b, long c) { return a + b + c; } \
         int main(void) { return (int)leaf_add(1, 2, 3); }"
            .to_string(),
        Target::LinuxX64,
    )
    .compile()
    .expect("compile");
    // Pin the full register file so the codegen_test pressure knobs do
    // not spill the body and reintroduce a frame.
    let obj =
        crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(usize::MAX, usize::MAX, || {
            emit_native_with_options(
                &program,
                Target::LinuxX64,
                NativeOptions {
                    output_kind: OutputKind::Relocatable,
                    ..NativeOptions::new().with_optimize()
                },
            )
        })
        .expect("emit relocatable");
    let text = elf64_section(&obj, ".text").expect(".text");
    let entry = elf_func_value(&obj, "leaf_add").expect("leaf_add symbol") as usize;
    // A frame prologue opens with `push %rbp` (0x55). A frameless leaf
    // starts straight into the address arithmetic (lea / mov / add).
    assert_ne!(
        text[entry],
        0x55,
        "leaf_add must not push %rbp: a spill-free, call-free leaf elides its frame. \
         text[entry..]={:02x?}",
        &text[entry..(entry + 16).min(text.len())]
    );
    // It must also not save the secondary scratch r13 to the stack
    // (`movq %r13, (%rsp)` = 4c 89 2c 24); r13 is now an ordinary
    // callee-saved allocation target, saved only when it holds a value,
    // and this leaf holds none there.
    assert!(
        !contains_bytes(text, &[0x4c, 0x89, 0x2c, 0x24]),
        "leaf_add must not save r13; the scratch pair is the caller-saved r10/r11"
    );
}

/// Microsoft ARM64 calling convention: a c5-internal variadic call on
/// Windows-on-ARM64 follows the host variadic ABI rather than the c5
/// cdecl 16-byte stack push. The callee spills all eight integer
/// argument registers x0..x7 into a 64-byte gr-save area above the
/// saved fp/lr, the named parameters and the variadic tail share an
/// 8-byte cell stride, and `va_arg` walks that stride. This locks the
/// byte-level signatures on the macOS host (which emits but cannot run
/// the PE) so a regression that reverts the call site to the 16-byte
/// push, drops the x7 spill, or restores the 16-byte `va_arg` stride is
/// caught without a Windows box.
#[test]
fn c5_internal_variadic_lowers_to_win_arm64_host_abi() {
    use crate::{Compiler, NativeOptions, Target};
    let src = r#"
        #include <stdarg.h>
        int vsum(int count, ...) {
            va_list ap;
            int total;
            int i;
            total = 0;
            va_start(ap, count);
            for (i = 0; i < count; i = i + 1)
                total = total + va_arg(ap, int);
            va_end(ap);
            return total;
        }
        int main(void) { return vsum(3, 10, 20, 30); }
    "#;
    let program = Compiler::with_target(super::with_prelude(src), Target::WindowsAarch64)
        .compile()
        .expect("compile");
    // Byte-exact assertions hold only with the full register file; pin
    // the allocator to the full pool so the codegen_test pressure knobs
    // (BADC_MAX_GPR / BADC_MAX_FPR) do not perturb the encoding.
    let bytes =
        crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(usize::MAX, usize::MAX, || {
            crate::c5::object::emit_native_single_tu_for_test(
                &program,
                Target::WindowsAarch64,
                NativeOptions::default(),
            )
            .expect("emit_native windows-arm64")
        });

    // Callee gr-save spill of x7: `str x7, [sp, #0x38]` (the eighth and
    // last 8-byte slot of the 64-byte gr-save area). A non-variadic
    // callee spills only its named parameters, so x7 is spilled here
    // only because the variadic callee homes the whole x0..x7 bank.
    // Encoding f9001fe7 (little-endian e7 1f 00 f9).
    let str_x7_sp_0x38 = 0xf9001fe7u32.to_le_bytes();
    assert!(
        contains_bytes(&bytes, &str_x7_sp_0x38),
        "win-arm64 variadic callee must spill x7 into the gr-save slot [sp+0x38]"
    );

    // va_start / va_arg advance the cursor by 8 (the Microsoft ARM64
    // va_list stride), not 16. The advance is `add x16, x17, #0x8`
    // (91002230); the Linux aarch64 c5 cdecl path would emit
    // `add x16, x17, #0x10` (91004230). Assert the 8-byte-stride form is
    // present and the 16-byte-stride form is absent for this shape.
    let add_stride8 = 0x91002230u32.to_le_bytes();
    let add_stride16 = 0x91004230u32.to_le_bytes();
    assert!(
        contains_bytes(&bytes, &add_stride8),
        "win-arm64 va_arg / va_start must advance the cursor by 8"
    );
    assert!(
        !contains_bytes(&bytes, &add_stride16),
        "win-arm64 must not emit the 16-byte c5 cdecl va_list stride for this function"
    );
}

/// A program defining its own `__c5_entry` links freestanding: the
/// embedded runtime is not linked (no `__c5_exit` / `environ`), the
/// image entry is `__c5_entry`, and the default `main` need not exist.
#[test]
fn user_defined_c5_entry_links_freestanding() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    let src = "\
        #pragma dylib(libc, \"libc.so.6\")\n\
        #pragma binding(libc::exit, \"exit\")\n\
        extern void exit(int);\n\
        void __c5_entry(void *sp, long off) { (void)sp; (void)off; exit(0); }\n";
    let program = Compiler::with_options(
        src.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    // Links without a `main` and without the embedded runtime.
    let bytes = super::link_freestanding(&program, Target::LinuxX64, NativeOptions::default())
        .expect("freestanding link must not require `main`");
    let has = |needle: &str| bytes.windows(needle.len()).any(|w| w == needle.as_bytes());
    assert!(
        !has("__c5_exit"),
        "freestanding image must not pull in the runtime __c5_exit"
    );
    assert!(
        !has("environ"),
        "freestanding image must not pull in the runtime environ"
    );
}

/// C11 7.17.7.2 + Intel SDM Vol.2: `atomic_fetch_add` must lower to a
/// genuine `LOCK XADD`, not a plain load-op-store. Confirm the emitted
/// x86_64 image carries the `F0` LOCK prefix immediately followed by
/// the XADD opcode `0F C1` (the 64-bit add form).
#[test]
fn atomic_fetch_add_emits_lock_xadd_x86_64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare(
        "#include <stdatomic.h>\n\
         long f(long *p){ return atomic_fetch_add((_Atomic long *)p, 1); } \
         int main(){ long x = 0; return (int)f(&x); }",
    );
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit LinuxX64");
    let found = bytes
        .windows(4)
        .any(|w| w == [0xF0, 0x48, 0x0F, 0xC1] || (w[0] == 0xF0 && w[2] == 0x0F && w[3] == 0xC1));
    assert!(
        found,
        "expected a `LOCK XADD` (F0 .. 0F C1) byte sequence in the x86_64 image",
    );
}

/// C11 7.17.7.4 + Intel SDM Vol.2: `atomic_compare_exchange_strong`
/// must lower to a `LOCK CMPXCHG`. Confirm the emitted x86_64 image
/// carries the CMPXCHG opcode `0F B1`.
#[test]
fn atomic_compare_exchange_emits_cmpxchg_x86_64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare(
        "#include <stdatomic.h>\n\
         int f(int *p, int *e, int d){ \
             return atomic_compare_exchange_strong((_Atomic int *)p, e, d); } \
         int main(){ int x = 0, e = 0; return f(&x, &e, 1); }",
    );
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit LinuxX64");
    let found = bytes.windows(2).any(|w| w == [0x0F, 0xB1]);
    assert!(
        found,
        "expected a `CMPXCHG` (0F B1) byte sequence in the x86_64 image",
    );
}

/// A 128-bit `__int128` atomic compare-exchange has no single-instruction
/// lock form in the current emit. The SSA walk must reject it, not lower
/// the zero-width access `type_size_bytes` yields for the struct-backed
/// __int128 (which faults / miscompiles at run time; clang gets it right).
/// TODO: lower 16-byte objects via cmpxchg16b / ldxp-stxp.
#[test]
fn atomic128_compare_exchange_is_rejected_not_miscompiled() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare(
        "int f(unsigned __int128 *p, unsigned __int128 *e, unsigned __int128 n){ \
             return __atomic_compare_exchange_n(p, e, n, 0, 5, 5); } \
         int main(){ return 0; }",
    );
    let err = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect_err("128-bit atomic compare-exchange must be rejected, not miscompiled");
    assert!(
        err.to_string().contains("1/2/4/8-byte scalar object"),
        "expected the wide-atomic rejection, got: {err}",
    );
}

/// A 128-bit `__int128` `__builtin_*_overflow` has no wrapped-value /
/// overflow-flag form in the current emit -- the formulas assume a
/// 1/2/4/8-byte scalar in a 64-bit register. The SSA walk must reject it,
/// not lower the narrow-path formulas that yield a wrong flag / value for
/// the struct-backed __int128 (which `type_size_bytes` sizes 0; clang
/// compiles it correctly). TODO: 128-bit overflow.
#[test]
fn builtin_overflow_on_128bit_operand_is_rejected() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare(
        "int f(unsigned __int128 a, unsigned __int128 b, unsigned __int128 *r){ \
             return __builtin_add_overflow(a, b, r); } \
         int main(){ return 0; }",
    );
    let err = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect_err("128-bit __builtin_add_overflow must be rejected, not miscompiled");
    assert!(
        err.to_string().contains("1/2/4/8-byte scalar type"),
        "expected the wide-overflow rejection, got: {err}",
    );
}

/// `__int128` <-> scalar conversions run correctly. An integer initializer,
/// cast, or assignment to `__int128` widens into the 16-byte object (low
/// half = value, high half = sign); a cast to a narrower integer loads the
/// low bytes. Before, the initializer copied 16 bytes from the scalar
/// treated as an address (fault), the narrowing cast returned the object's
/// address instead of its value, and the assignment was rejected at parse.
#[test]
fn int128_scalar_conversions_run_correctly() {
    use crate::jit_run;
    let program = super::compile_str_bare(
        "typedef unsigned __int128 u128; typedef signed __int128 s128;\n\
         typedef union { u128 v; unsigned long long h[2]; } U;\n\
         typedef union { s128 v; unsigned long long h[2]; } S;\n\
         static int uok(u128 x, unsigned long long hi, unsigned long long lo){ U u; u.v=x; return u.h[0]==lo&&u.h[1]==hi; }\n\
         static int sok(s128 x, unsigned long long hi, unsigned long long lo){ S u; u.v=x; return u.h[0]==lo&&u.h[1]==hi; }\n\
         int main(void){\n\
           int n=-5; s128 a=n; if(!sok(a,0xFFFFFFFFFFFFFFFFull,0xFFFFFFFFFFFFFFFBull))return 1;\n\
           unsigned un=5u; u128 b=un; if(!uok(b,0,5))return 2;\n\
           u128 c=(u128)0xABCDu; if(!uok(c,0,0xABCD))return 3;\n\
           U g; g.h[0]=0xDEADBEEFull; g.h[1]=0x1111ull;\n\
           if((unsigned long long)g.v!=0xDEADBEEFull)return 4;\n\
           if((unsigned)g.v!=0xDEADBEEFu)return 5;\n\
           u128 d; unsigned e=9u; d=e; if(!uok(d,0,9))return 6;\n\
           s128 h; int m=-3; h=m; if(!sok(h,0xFFFFFFFFFFFFFFFFull,0xFFFFFFFFFFFFFFFDull))return 7;\n\
           return 0; }",
    );
    let exit = jit_run(&program, &["int128_conv".to_string()])
        .expect("int128 conversion fixture runs under JIT");
    assert_eq!(
        exit, 0,
        "int128 scalar conversion produced a wrong value or fault: exit {exit}",
    );
}

/// ARM ARM C6.2: the aarch64 atomic read-modify-write lowering uses an
/// LDAXR / STLXR exclusive-monitor retry loop. Confirm both opcodes are
/// present by their fixed bit patterns, independent of register fields:
/// LDAXR is `_x011000_010_11111_1_11111 Rn Rt` and STLXR is
/// `_x011000_000 Rs 1_11111 Rn Rt`.
#[test]
fn atomic_rmw_emits_ldaxr_stlxr_aarch64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare(
        "#include <stdatomic.h>\n\
         long f(long *p){ return atomic_fetch_add((_Atomic long *)p, 1); } \
         int main(){ long x = 0; return (int)f(&x); }",
    );
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, NativeOptions::default())
        .expect("emit MacOSAarch64");
    // Match the 32-bit little-endian instruction words by the fixed bits
    // that do not depend on the chosen registers (size / L / o0 / Rt2 and
    // the LDAXR all-ones Rs).
    let words = || {
        bytes
            .windows(4)
            .map(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]))
    };
    let any_ldaxr = words().any(|w| (w & 0x3FFF_FC00) == (0x085F_FC00 & 0x3FFF_FC00));
    let any_stlxr = words().any(|w| (w & 0x3FE0_FC00) == (0x0800_FC00 & 0x3FE0_FC00));
    assert!(
        any_ldaxr,
        "expected an LDAXR opcode word in the aarch64 image",
    );
    assert!(
        any_stlxr,
        "expected an STLXR opcode word in the aarch64 image",
    );
}

/// The 128-bit atomic asm shape lowers to an LDAXP / STLXP exclusive-pair
/// loop. Match the opcode words by the fixed bits independent of the
/// register fields: LDAXP is `11001000_0111_1111_1_Rt2_Rn_Rt` and STLXP is
/// `11001000_001_Rs_1_Rt2_Rn_Rt`.
#[test]
fn atomic128_emits_ldaxp_stlxp_aarch64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare(
        "typedef struct { unsigned long long lo, hi; } u128;\n\
         void x(u128 *p, unsigned long long nl, unsigned long long nh,\n\
                unsigned long long *ol, unsigned long long *oh){\n\
           unsigned long long rl, rh; unsigned t;\n\
           __asm__(\"0: ldaxp %[oldl], %[oldh], %[mem]\\n\\t\"\n\
                   \"stlxp %w[tmp], %[newl], %[newh], %[mem]\\n\\t\"\n\
                   \"cbnz %w[tmp], 0b\"\n\
                   : [mem] \"+m\"(*p), [tmp] \"=&r\"(t), [oldl] \"=&r\"(rl), [oldh] \"=&r\"(rh)\n\
                   : [newl] \"r\"(nl), [newh] \"r\"(nh) : \"memory\");\n\
           *ol = rl; *oh = rh; }\n\
         int main(){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, NativeOptions::default())
        .expect("emit MacOSAarch64");
    let words = || {
        bytes
            .windows(4)
            .map(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]))
    };
    let any_ldaxp = words().any(|w| (w & 0xFFFF_8000) == 0xC87F_8000);
    let any_stlxp = words().any(|w| (w & 0xFFE0_8000) == 0xC820_8000);
    assert!(
        any_ldaxp,
        "expected an LDAXP opcode word in the aarch64 image"
    );
    assert!(
        any_stlxp,
        "expected an STLXP opcode word in the aarch64 image"
    );
}

/// The 128-bit atomic load / store shapes lower to plain LDP / STP and
/// exclusive-pair LDXP / STXP. LDXP / STXP are matched by their fixed bits
/// (bit 15, the acquire/release `o0`, is 0, distinguishing them from
/// LDAXP / STLXP); the plain LDP / STP are matched by the exact
/// register-specific words the lowering emits (x10/x11 or x12/x13 over
/// base x9), which the frame-save LDP/STP pairs (base x31/sp) never alias.
#[test]
fn atomic128_emits_ldp_stp_ldxp_stxp_aarch64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare(
        "typedef struct { unsigned long long lo, hi; } u128;\n\
         void ld(const u128 *p, unsigned long long *ol, unsigned long long *oh){\n\
           unsigned long long l, h;\n\
           __asm__(\"ldp %[l], %[h], %[mem]\"\n\
                   : [l] \"=r\"(l), [h] \"=r\"(h) : [mem] \"m\"(*p));\n\
           *ol = l; *oh = h; }\n\
         void st(u128 *p, unsigned long long l, unsigned long long h){\n\
           __asm__(\"stp %[l], %[h], %[mem]\"\n\
                   : [mem] \"=m\"(*p) : [l] \"r\"(l), [h] \"r\"(h)); }\n\
         void ldx(u128 *p, unsigned long long *ol, unsigned long long *oh){\n\
           unsigned long long l, h; unsigned t;\n\
           __asm__(\"0: ldxp %[l], %[h], %[mem]\\n\\t\"\n\
                   \"stxp %w[tmp], %[l], %[h], %[mem]\\n\\t\"\n\
                   \"cbnz %w[tmp], 0b\"\n\
                   : [mem] \"+m\"(*p), [tmp] \"=&r\"(t), [l] \"=&r\"(l), [h] \"=&r\"(h)\n\
                   :: \"memory\");\n\
           *ol = l; *oh = h; }\n\
         void stx(u128 *p, unsigned long long l, unsigned long long h){\n\
           unsigned long long a, b;\n\
           __asm__(\"0: ldxp %[t1], %[t2], %[mem]\\n\\t\"\n\
                   \"stxp %w[t1], %[l], %[h], %[mem]\\n\\t\"\n\
                   \"cbnz %w[t1], 0b\"\n\
                   : [mem] \"+m\"(*p), [t1] \"=&r\"(a), [t2] \"=&r\"(b)\n\
                   : [l] \"r\"(l), [h] \"r\"(h) : \"memory\"); }\n\
         int main(){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, NativeOptions::default())
        .expect("emit MacOSAarch64");
    let words = || {
        bytes
            .windows(4)
            .map(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]))
    };
    let any_ldxp = words().any(|w| (w & 0xFFFF_8000) == 0xC87F_0000);
    let any_stxp = words().any(|w| (w & 0xFFE0_8000) == 0xC820_0000);
    // enc_ldp_off(x10,x11,x9,0) and enc_stp_off(x12,x13,x9,0).
    let any_ldp = words().any(|w| w == 0xA940_2D2A);
    let any_stp = words().any(|w| w == 0xA900_352C);
    assert!(
        any_ldxp,
        "expected an LDXP opcode word in the aarch64 image"
    );
    assert!(
        any_stxp,
        "expected an STXP opcode word in the aarch64 image"
    );
    assert!(
        any_ldp,
        "expected the plain 128-bit-load LDP opcode word in the aarch64 image"
    );
    assert!(
        any_stp,
        "expected the plain 128-bit-store STP opcode word in the aarch64 image"
    );
}

#[test]
fn atomic128_positional_ldp_load_pair_aarch64() {
    // The aligned 128-bit load-extract idiom writes its `ldp` with positional
    // operands (`%0, %1, %2`) and an unnamed `"m"` memory input, unlike the
    // named-operand `ldp %[l], %[h], %[mem]` shape. Both lower to the same
    // plain LDP register pair.
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare(
        "typedef struct { unsigned long long lo, hi; } u128;\n\
         void ld(const u128 *p, unsigned long long *ol, unsigned long long *oh){\n\
           unsigned long long l, h;\n\
           __asm__(\"ldp %0, %1, %2\" : \"=r\"(l), \"=r\"(h) : \"m\"(*p));\n\
           *ol = l; *oh = h; }\n\
         int main(){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, NativeOptions::default())
        .expect("emit MacOSAarch64");
    // enc_ldp_off(x10, x11, x9, 0).
    let any_ldp = bytes
        .windows(4)
        .map(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]))
        .any(|w| w == 0xA940_2D2A);
    assert!(
        any_ldp,
        "positional ldp load-extract must lower to the plain LDP register pair"
    );
}

#[test]
fn atomic128_store_insert_aarch64() {
    // The masked 128-bit store-insert `*mem = (*mem & ~msk) | val` lowers to
    // an LDXP / BIC / BIC / ORR / ORR / STXP exclusive retry loop. The `[l]`,
    // `[h]`, `[f]` operands are asm scratch (no C output), and the value /
    // mask halves are inputs.
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare(
        "typedef struct { unsigned long long lo, hi; } u128;\n\
         void si(u128 *ps, unsigned long long vl, unsigned long long vh,\n\
                 unsigned long long ml, unsigned long long mh){\n\
           unsigned long long tl, th; unsigned f;\n\
           __asm__(\"0: ldxp %[l], %[h], %[mem]\\n\\t\"\n\
                   \"bic %[l], %[l], %[ml]\\n\\t\"\n\
                   \"bic %[h], %[h], %[mh]\\n\\t\"\n\
                   \"orr %[l], %[l], %[vl]\\n\\t\"\n\
                   \"orr %[h], %[h], %[vh]\\n\\t\"\n\
                   \"stxp %w[f], %[l], %[h], %[mem]\\n\\t\"\n\
                   \"cbnz %w[f], 0b\\n\"\n\
                   : [mem]\"+Q\"(*ps), [f]\"=&r\"(f), [l]\"=&r\"(tl), [h]\"=&r\"(th)\n\
                   : [vl]\"r\"(vl), [vh]\"r\"(vh), [ml]\"r\"(ml), [mh]\"r\"(mh)); }\n\
         int main(){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, NativeOptions::default())
        .expect("emit MacOSAarch64");
    let words = || {
        bytes
            .windows(4)
            .map(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]))
    };
    let any_ldxp = words().any(|w| (w & 0xFFFF_8000) == 0xC87F_0000);
    let any_stxp = words().any(|w| (w & 0xFFE0_8000) == 0xC820_0000);
    // BIC (logical shifted-register AND with N=1): base 0x8A20_0000.
    let any_bic = words().any(|w| (w & 0xFFE0_0000) == 0x8A20_0000);
    assert!(any_ldxp, "store-insert must emit an LDXP");
    assert!(any_stxp, "store-insert must emit an STXP");
    assert!(any_bic, "store-insert must emit a BIC (mask clear)");
}

/// Bytes of the section named `name` in an ELF64 little-endian
/// object, or `None` when absent. Reads only the section header
/// table and the section-name string table.
fn elf64_section<'a>(obj: &'a [u8], name: &str) -> Option<&'a [u8]> {
    let rd_u16 = |off: usize| u16::from_le_bytes(obj[off..off + 2].try_into().unwrap()) as usize;
    let rd_u32 = |off: usize| u32::from_le_bytes(obj[off..off + 4].try_into().unwrap()) as usize;
    let rd_u64 = |off: usize| u64::from_le_bytes(obj[off..off + 8].try_into().unwrap()) as usize;
    let e_shoff = rd_u64(0x28);
    let e_shentsize = rd_u16(0x3a);
    let e_shnum = rd_u16(0x3c);
    let e_shstrndx = rd_u16(0x3e);
    let sh = |i: usize| e_shoff + i * e_shentsize;
    let shstr_off = rd_u64(sh(e_shstrndx) + 0x18);
    let sh_name_str = |hdr: usize| {
        let n = rd_u32(hdr); // sh_name at +0x00
        let start = shstr_off + n;
        let end = start + obj[start..].iter().position(|&b| b == 0).unwrap();
        &obj[start..end]
    };
    (0..e_shnum)
        .map(sh)
        .find(|&hdr| sh_name_str(hdr) == name.as_bytes())
        .map(|hdr| {
            let off = rd_u64(hdr + 0x18);
            let size = rd_u64(hdr + 0x20);
            &obj[off..off + size]
        })
}

/// `(sh_addr, sh_size)` of the named section. Unlike [`elf64_section`]
/// this works for `SHT_NOBITS` (`.bss`), which carries an address and
/// size but no file bytes.
fn elf64_section_addr_size(obj: &[u8], name: &str) -> Option<(u64, u64)> {
    let rd_u16 = |off: usize| u16::from_le_bytes(obj[off..off + 2].try_into().unwrap()) as usize;
    let rd_u32 = |off: usize| u32::from_le_bytes(obj[off..off + 4].try_into().unwrap()) as usize;
    let rd_u64 = |off: usize| u64::from_le_bytes(obj[off..off + 8].try_into().unwrap());
    let e_shoff = rd_u64(0x28) as usize;
    let e_shentsize = rd_u16(0x3a);
    let e_shnum = rd_u16(0x3c);
    let e_shstrndx = rd_u16(0x3e);
    let sh = |i: usize| e_shoff + i * e_shentsize;
    let shstr_off = rd_u64(sh(e_shstrndx) + 0x18) as usize;
    let sh_name_str = |hdr: usize| {
        let n = rd_u32(hdr);
        let start = shstr_off + n;
        let end = start + obj[start..].iter().position(|&b| b == 0).unwrap();
        &obj[start..end]
    };
    (0..e_shnum)
        .map(sh)
        .find(|&hdr| sh_name_str(hdr) == name.as_bytes())
        .map(|hdr| (rd_u64(hdr + 0x10), rd_u64(hdr + 0x20)))
}

/// A wholly-zero global moved to `.bss` under segregation, plus a
/// pointer initializer into it, must resolve to the global's `.bss`
/// address through a full link. Locks the synth + ELF-writer bss path
/// and the `.bss` section header in a linked executable.
#[test]
fn bss_segregation_resolves_data_pointer_into_bss() {
    use crate::{NativeOptions, Target};
    let opts = NativeOptions {
        bss_segregate: true,
        ..NativeOptions::new()
    };
    let program = super::compile_str_bare(
        "long g[8]; long *const gp = &g[3]; \
         int main(void){ return gp == &g[3] ? 0 : 1; }",
    );
    let bytes = super::link_executable_with_runtime(&program, Target::LinuxX64, opts)
        .expect("link LinuxX64");
    let (bss_addr, bss_size) =
        elf64_section_addr_size(&bytes, ".bss").expect(".bss section must be present");
    assert!(bss_size > 0, ".bss must be non-empty");
    let data = elf64_section(&bytes, ".data").expect(".data bytes");
    // Some 8-byte data word holds `gp = &g[3]`, a pointer into `.bss`.
    // Before the fix it pointed into `.data` and nothing reached `.bss`.
    let into_bss = data
        .chunks_exact(8)
        .map(|c| u64::from_le_bytes(c.try_into().unwrap()))
        .any(|v| v >= bss_addr && v < bss_addr + bss_size);
    assert!(
        into_bss,
        ".data must hold a pointer into .bss [{bss_addr:#x}, {:#x})",
        bss_addr + bss_size
    );
}

/// `-g` must not change emitted machine code: DWARF tables are
/// appended to the image, never woven into `.text`. The function's
/// disjoint-lifetime locals exercise slot coalescing -- the pass
/// whose debug gate was the only -g/codegen coupling. Emit with
/// debug info on and off for each ELF target and require
/// byte-identical `.text`.
#[test]
fn debug_info_does_not_change_codegen() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str(
        r#"
            int coalesce_me(int n) {
                int a = n + 1, b = n + 2; int s1 = a + b;
                int c = n + 3, d = n + 4; int s2 = c + d;
                int e = n + 5, g = n + 6; int s3 = e + g;
                return s1 + s2 + s3;
            }
            int main() { return coalesce_me(7); }
        "#,
    );
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let emit = |debug: bool| {
            emit_native_with_options(
                &program,
                target,
                NativeOptions::new().with_debug_info(debug),
            )
            .unwrap_or_else(|e| panic!("emit_native({target:?}, debug={debug}): {e}"))
        };
        let with_g = emit(true);
        let without_g = emit(false);
        let text_g = elf64_section(&with_g, ".text").expect(".text in -g image");
        let text_no_g = elf64_section(&without_g, ".text").expect(".text in no-g image");
        assert!(!text_g.is_empty(), ".text must be non-empty");
        assert_eq!(
            text_g,
            text_no_g,
            "-g changed .text for {target:?} ({} vs {} bytes)",
            text_g.len(),
            text_no_g.len()
        );
    }
}

/// PE/COFF orders the export name pointer table lexically: the loader's
/// import binding and GetProcAddress binary-search it, so a table in
/// declaration order resolves names data-dependently (a miss surfaces as
/// STATUS_ENTRYPOINT_NOT_FOUND). Export in non-alphabetical declaration
/// order and byte-walk the emitted directory: the name table must come
/// out sorted with each name's ordinal still selecting its own
/// function's AddressOfFunctions slot.
#[test]
fn pe_export_name_table_is_lexically_sorted() {
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::{
        CompileOptions, Compiler, NativeOptions, OutputKind, Target, emit_native_with_options,
    };
    // Each function carries a unique imm32 marker so the export's
    // resolved address can be tied back to the right body.
    let program = Compiler::with_options(
        "#pragma export(zeta)\n\
         #pragma export(mike)\n\
         #pragma export(alpha)\n\
         int zeta(void) { return 0x5a17aa01; }\n\
         int mike(void) { return 0x5a17aa02; }\n\
         int alpha(void) { return 0x5a17aa03; }\n"
            .to_string(),
        Target::WindowsX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile export TU");
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
        Some("exp.dll"),
    )
    .expect("write DLL");

    let u16a = |o: usize| u16::from_le_bytes(dll[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(dll[o..o + 4].try_into().unwrap());
    let pe = u32a(0x3c) as usize;
    let opt = pe + 24;
    // Section table maps RVAs to file offsets.
    let num_sections = u16a(pe + 6) as usize;
    let opt_size = u16a(pe + 20) as usize;
    let sec_table = pe + 24 + opt_size;
    let rva_to_off = |rva: u32| -> usize {
        for s in 0..num_sections {
            let sh = sec_table + s * 40;
            let va = u32a(sh + 12);
            let vsize = u32a(sh + 8);
            let raw_off = u32a(sh + 20);
            if rva >= va && rva < va + vsize {
                return (raw_off + (rva - va)) as usize;
            }
        }
        panic!("rva {rva:#x} outside every section");
    };
    let cstr_at = |off: usize| -> alloc::string::String {
        let end = dll[off..]
            .iter()
            .position(|&c| c == 0)
            .map_or(off, |n| off + n);
        alloc::string::String::from_utf8_lossy(&dll[off..end]).into_owned()
    };
    // Data directory 0 is the Export Directory (PE32+: opt + 112).
    let edata_rva = u32a(opt + 112);
    assert_ne!(edata_rva, 0, "DLL must carry an export directory");
    let ed = rva_to_off(edata_rva);
    let n_names = u32a(ed + 24) as usize;
    assert_eq!(n_names, 3);
    let funcs_off = rva_to_off(u32a(ed + 28));
    let names_off = rva_to_off(u32a(ed + 32));
    let ords_off = rva_to_off(u32a(ed + 36));

    let names: alloc::vec::Vec<alloc::string::String> = (0..n_names)
        .map(|i| cstr_at(rva_to_off(u32a(names_off + 4 * i))))
        .collect();
    assert_eq!(
        names,
        ["alpha", "mike", "zeta"],
        "name pointer table must be lexically sorted"
    );
    // Ground truth per function: the file offset of its unique marker.
    let marker_off = |imm: u32| -> usize {
        let needle = imm.to_le_bytes();
        let hits: alloc::vec::Vec<usize> = dll
            .windows(4)
            .enumerate()
            .filter(|(_, w)| *w == needle)
            .map(|(i, _)| i)
            .collect();
        assert_eq!(hits.len(), 1, "marker {imm:#x} must be unique");
        hits[0]
    };
    let markers = [
        ("zeta", marker_off(0x5a17aa01)),
        ("mike", marker_off(0x5a17aa02)),
        ("alpha", marker_off(0x5a17aa03)),
    ];
    for (i, name) in names.iter().enumerate() {
        let ordinal = u16a(ords_off + 2 * i) as usize;
        let fn_off = rva_to_off(u32a(funcs_off + 4 * ordinal));
        // The nearest marker at or past the function's entry must be
        // this export's own -- the ordinal table maps name -> body.
        let (owner, _) = markers
            .iter()
            .filter(|&&(_, m)| m >= fn_off)
            .min_by_key(|&&(_, m)| m)
            .expect("a marker must follow the entry");
        assert_eq!(
            owner, name,
            "export `{name}` (ordinal {ordinal}) must resolve to its own body"
        );
    }
}

/// Minimal foreign ET_REL mirroring clang -O2's SSE constant pool: a
/// 4-byte `.rodata` (align 4) followed by `.rodata.cst16` (align 16)
/// holding `mask`, with a global object symbol `c16_mask` on it.
fn foreign_et_rel_with_cst16(mask: &[u8; 16]) -> alloc::vec::Vec<u8> {
    let rodata: [u8; 4] = [1, 2, 3, 4];
    let strtab = b"\0c16_mask\0";
    let shstrtab = b"\0.rodata\0.rodata.cst16\0.symtab\0.strtab\0.shstrtab\0";
    let rodata_off = 64usize;
    let cst16_off = rodata_off + rodata.len();
    let symtab_off = cst16_off + mask.len();
    // Elf64Sym pair: the null symbol, then GLOBAL OBJECT `c16_mask`
    // at offset 0 of section 2 (`.rodata.cst16`).
    let mut symtab = alloc::vec![0u8; 24];
    symtab.extend_from_slice(&1u32.to_le_bytes());
    symtab.push(0x11); // (STB_GLOBAL << 4) | STT_OBJECT
    symtab.push(0);
    symtab.extend_from_slice(&2u16.to_le_bytes());
    symtab.extend_from_slice(&0u64.to_le_bytes());
    symtab.extend_from_slice(&16u64.to_le_bytes());
    let strtab_off = symtab_off + symtab.len();
    let shstr_off = strtab_off + strtab.len();
    let shoff = (shstr_off + shstrtab.len()).next_multiple_of(8);

    let mut out = alloc::vec![0u8; 64];
    out[0..4].copy_from_slice(b"\x7fELF");
    out[4] = 2; // ELFCLASS64
    out[5] = 1; // ELFDATA2LSB
    out[6] = 1; // EV_CURRENT
    out[16..18].copy_from_slice(&1u16.to_le_bytes()); // ET_REL
    out[18..20].copy_from_slice(&62u16.to_le_bytes()); // EM_X86_64
    out[20..24].copy_from_slice(&1u32.to_le_bytes()); // e_version
    out[40..48].copy_from_slice(&(shoff as u64).to_le_bytes());
    out[52..54].copy_from_slice(&64u16.to_le_bytes()); // e_ehsize
    out[58..60].copy_from_slice(&64u16.to_le_bytes()); // e_shentsize
    out[60..62].copy_from_slice(&6u16.to_le_bytes()); // e_shnum
    out[62..64].copy_from_slice(&5u16.to_le_bytes()); // e_shstrndx
    out.extend_from_slice(&rodata);
    out.extend_from_slice(mask);
    out.extend_from_slice(&symtab);
    out.extend_from_slice(strtab);
    out.extend_from_slice(shstrtab);
    out.resize(shoff, 0);
    let mut shdr = |name: u32,
                    ty: u32,
                    flags: u64,
                    off: usize,
                    size: usize,
                    link: u32,
                    info: u32,
                    align: u64,
                    entsize: u64| {
        out.extend_from_slice(&name.to_le_bytes());
        out.extend_from_slice(&ty.to_le_bytes());
        out.extend_from_slice(&flags.to_le_bytes());
        out.extend_from_slice(&0u64.to_le_bytes()); // sh_addr
        out.extend_from_slice(&(off as u64).to_le_bytes());
        out.extend_from_slice(&(size as u64).to_le_bytes());
        out.extend_from_slice(&link.to_le_bytes());
        out.extend_from_slice(&info.to_le_bytes());
        out.extend_from_slice(&align.to_le_bytes());
        out.extend_from_slice(&entsize.to_le_bytes());
    };
    shdr(0, 0, 0, 0, 0, 0, 0, 0, 0);
    shdr(1, 1, 2, rodata_off, rodata.len(), 0, 0, 4, 0); // .rodata
    shdr(9, 1, 2, cst16_off, mask.len(), 0, 0, 16, 0); // .rodata.cst16
    shdr(23, 2, 0, symtab_off, symtab.len(), 4, 1, 8, 24); // .symtab
    shdr(31, 3, 0, strtab_off, strtab.len(), 0, 0, 1, 0); // .strtab
    shdr(39, 3, 0, shstr_off, shstrtab.len(), 0, 0, 1, 0); // .shstrtab
    out
}

/// `(sh_addr, sh_offset)` of the named section in an ELF64 image.
fn elf64_shdr_addr_off(b: &[u8], want: &str) -> Option<(u64, u64)> {
    let u16a = |o: usize| u16::from_le_bytes(b[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
    let u64a = |o: usize| u64::from_le_bytes(b[o..o + 8].try_into().unwrap());
    let shoff = u64a(0x28) as usize;
    let shentsize = u16a(0x3a) as usize;
    let shnum = u16a(0x3c) as usize;
    let shstrndx = u16a(0x3e) as usize;
    let str_off = u64a(shoff + shstrndx * shentsize + 0x18) as usize;
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        let name_off = str_off + u32a(sh) as usize;
        let end = b[name_off..]
            .iter()
            .position(|&c| c == 0)
            .map_or(name_off, |n| name_off + n);
        if &b[name_off..end] == want.as_bytes() {
            return Some((u64a(sh + 0x10), u64a(sh + 0x18)));
        }
    }
    None
}

/// A foreign object's `.rodata.cst16`-style section (sh_addralign 16 --
/// clang/gcc -O2 SSE constant pools) must keep its alignment through the
/// family concatenation, the unit merge, and the final image placement:
/// legacy-SSE aligned loads (`xorps`/`movaps`) fault on a misaligned
/// operand. Link the foreign object after a badc unit and check the
/// constant's final vaddr.
#[test]
fn foreign_cst16_section_lands_sixteen_aligned_in_image() {
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let mask: [u8; 16] = [
        0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae,
        0xaf,
    ];
    let foreign = parse_native_elf(&foreign_et_rel_with_cst16(&mask)).expect("parse foreign");
    assert_eq!(foreign.data_align, 16, "sh_addralign must be recorded");
    // Intra-object: the 4-byte `.rodata` ahead forces 12 bytes of pad.
    assert_eq!(&foreign.data[16..32], &mask);

    // A badc unit with an import so the image carries `.dynamic` and a
    // non-empty `.got` ahead of `.data` (the placement the alignment
    // rounding must correct).
    let program = super::compile_str_bare(
        "#pragma dylib(libc, \"libc.so.6\")\n\
         #pragma binding(libc::puts, \"puts\")\n\
         int puts(const char *s); \
         int main(void) { return puts(\"x\"); }",
    );
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let tu = parse_native_elf(&bytes).expect("parse TU");
    let mut merged = link_native_objects(&[tu, foreign]).expect("link");
    assert_eq!(merged.data_align, 16, "merge must carry the max alignment");
    let sym_value = merged
        .defined
        .get("c16_mask")
        .expect("foreign data symbol must survive the merge")
        .value;
    assert_eq!(sym_value % 16, 0, "merged .data offset must stay aligned");
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
    let (data_addr, data_off) = elf64_shdr_addr_off(&exe, ".data").expect(".data section header");
    assert_eq!(
        (data_addr + sym_value) % 16,
        0,
        "the 16-byte constant's runtime address must be 16-aligned"
    );
    let at = (data_off + sym_value) as usize;
    assert_eq!(
        &exe[at..at + 16],
        &mask,
        "the constant's bytes must land at the placed offset"
    );
}

/// A constant controlling expression in a `?:` or `if` selects one
/// arm at translation time (C99 6.5.15 / 6.8.4.1); the walker emits
/// only that arm, so a dead arm's call -- and the undefined-symbol
/// reference it would carry into the object -- never reaches the SSA.
/// gcc performs this front-end fold even at -O0. A non-constant
/// condition must still emit both arms.
#[test]
fn constant_condition_drops_dead_branch_call() {
    use crate::c5::ir::Inst;
    use crate::{Compiler, Target};
    let target = Target::LinuxAarch64;
    let program = Compiler::with_target(
        "extern int dead_sink(int); \
         int t_false(int x){ return 0 ? dead_sink(x) : x + 1; } \
         int t_true(int x){ return 1 ? x + 2 : dead_sink(x); } \
         int if_zero(int x){ if (0) { dead_sink(x); } return x + 3; } \
         int if_else(int x){ if (0) return dead_sink(x); else return x + 4; } \
         int short_circuit(int x){ return (1 && 0) ? dead_sink(x) : x + 5; } \
         int cast_zero(int x){ return (char)256 ? dead_sink(x) : x + 6; } \
         int runtime_cond(int c, int x){ return c ? dead_sink(x) : x + 7; } \
         int main(void){ return 0; }"
            .to_string(),
        target,
    )
    .compile()
    .expect("compile");
    let funcs = crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target).expect("ssa");
    let has_call = |name: &str| -> bool {
        let f = funcs
            .iter()
            .find(|f| f.name == name)
            .unwrap_or_else(|| panic!("function `{name}` not produced"));
        f.insts.iter().any(|i| {
            matches!(
                i,
                Inst::Call { .. } | Inst::CallExt { .. } | Inst::CallIndirect { .. }
            )
        })
    };
    for name in [
        "t_false",
        "t_true",
        "if_zero",
        "if_else",
        "short_circuit",
        "cast_zero",
    ] {
        assert!(
            !has_call(name),
            "{name}: constant-condition fold must not emit the dead-branch call"
        );
    }
    // The fold fires only on compile-time constants: a runtime
    // condition still evaluates and calls into its selected arm.
    assert!(
        has_call("runtime_cond"),
        "runtime_cond: a non-constant condition must still emit the call"
    );
}

/// A constant struct-field offset folds into the displacement of a
/// floating-point load and store, and the AArch64 emit carries that
/// displacement into the immediate-offset encoding. The load side used
/// to hard-code offset 0 while the store side honored it, masked only
/// by the fold declining FP kinds.
#[test]
fn aarch64_fp_access_folds_constant_displacement() {
    use crate::c5::ir::{Inst, LoadKind, StoreKind};
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    let target = Target::LinuxAarch64;
    let program = Compiler::with_target(
        "struct s { long tag; float f; double d; }; \
         float rf(struct s *p) { return p->f; } \
         double rd(struct s *p) { return p->d; } \
         void wd(struct s *p) { p->d = p->d + 0.5; } \
         int main(void) { return 0; }"
            .to_string(),
        target,
    )
    .compile()
    .expect("compile");
    let mut funcs =
        crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target).expect("ssa");
    crate::c5::codegen::passes::index_fold::run(&mut funcs);
    let mut f32_load = false;
    let mut f64_load = false;
    let mut f64_store = false;
    for inst in funcs.iter().flat_map(|f| f.insts.iter()) {
        match inst {
            Inst::Load {
                disp: 8,
                kind: LoadKind::F32,
                ..
            } => f32_load = true,
            Inst::Load {
                disp: 16,
                kind: LoadKind::F64,
                ..
            } => f64_load = true,
            Inst::Store {
                disp: 16,
                kind: StoreKind::F64,
                ..
            } => f64_store = true,
            _ => {}
        }
    }
    assert!(f32_load, "p->f must fold to Load {{ disp: 8, F32 }}");
    assert!(f64_load, "p->d must fold to Load {{ disp: 16, F64 }}");
    assert!(
        f64_store,
        "p->d = ... must fold to Store {{ disp: 16, F64 }}"
    );
    let obj = emit_native_with_options(
        &program,
        target,
        NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::new().with_optimize()
        },
    )
    .expect("emit relocatable");
    let text = elf64_section(&obj, ".text").expect(".text");
    let words = || {
        text.chunks_exact(4)
            .map(|c| u32::from_le_bytes([c[0], c[1], c[2], c[3]]))
    };
    // Unsigned-offset FP loads/stores scale the immediate by the access
    // width, so #8 (F32) and #16 (F64) both encode imm12 = 2. Register
    // fields are masked out.
    let imm2 = |w: u32, class: u32| (w & 0xFFC0_0000) == class && (w >> 10) & 0xFFF == 2;
    assert!(
        words().any(|w| imm2(w, 0xBD40_0000)),
        "expected `ldr s, [xN, #8]` for the folded F32 load"
    );
    assert!(
        words().any(|w| imm2(w, 0xFD40_0000)),
        "expected `ldr d, [xN, #16]` for the folded F64 load"
    );
    assert!(
        words().any(|w| imm2(w, 0xFD00_0000)),
        "expected `str d, [xN, #16]` for the folded F64 store"
    );
}

/// A call whose outgoing-argument area exceeds the 12-bit add/sub
/// immediate must split the call-site SP adjustment into the
/// shifted-12 + remainder pair, as the prologue path does. 261
/// by-value 16-byte structs leave 257 on the AAPCS64 stack: 257 * 16 =
/// 4112 = 4096 + 16 bytes. The raw encoder used to fold 4112 into the
/// `lsl #12` bit and adjust SP by 65536 instead.
#[test]
fn aarch64_call_sp_adjust_covers_wide_outgoing_area() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    let mut src = String::from("struct pair { long a; long b; };\nstatic struct pair g[261];\n");
    src.push_str("long take(");
    for i in 0..261 {
        src.push_str(&format!("struct pair p{i}"));
        src.push_str(if i < 260 { ", " } else { ");\n" });
    }
    src.push_str("long caller(void) { return take(");
    for i in 0..261 {
        src.push_str(&format!("g[{i}]"));
        src.push_str(if i < 260 { ", " } else { "); }\n" });
    }
    src.push_str("int main(void) { return (int)caller(); }\n");
    let program = Compiler::with_target(src, Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let obj = emit_native_with_options(
        &program,
        Target::LinuxAarch64,
        NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::new()
        },
    )
    .expect("emit relocatable");
    let text = elf64_section(&obj, ".text").expect(".text");
    let entry = elf_func_value(&obj, "caller").expect("caller symbol") as usize;
    let size = elf_func_symbols(&obj)
        .into_iter()
        .find(|(n, _)| n == "caller")
        .map(|(_, s)| s as usize)
        .expect("caller size");
    let body = &text[entry..(entry + size).min(text.len())];
    let words: alloc::vec::Vec<u32> = body
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes([c[0], c[1], c[2], c[3]]))
        .collect();
    // 4112 bytes split as `sub sp, sp, #1, lsl #12` + `sub sp, sp, #16`
    // and restore with the matching adds. The caller's own frame stays
    // below 4096, so only the call site produces the shifted forms.
    for (word, what) in [
        (0xD140_07FFu32, "sub sp, sp, #1, lsl #12"),
        (0xD100_43FF, "sub sp, sp, #16"),
        (0x9140_07FF, "add sp, sp, #1, lsl #12"),
        (0x9100_43FF, "add sp, sp, #16"),
    ] {
        assert!(
            words.contains(&word),
            "caller must contain `{what}` ({word:#010x}) for the 4112-byte outgoing area"
        );
    }
    // The raw-encoder overflow artifact: 4112 << 10 sets the shift bit
    // and leaves imm12 = 16, i.e. a 65536-byte adjustment.
    for word in [0xD140_43FFu32, 0x9140_43FF] {
        assert!(
            !words.contains(&word),
            "caller must not adjust SP by 65536 (mis-encoded 4112): {word:#010x}"
        );
    }
}

/// Build the walker SSA for `src` (a `main` is appended so it links)
/// and return the named function.
fn ssa_func_named(src: &str, name: &str) -> crate::c5::ir::FunctionSsa {
    use crate::Target;
    use crate::c5::codegen::ssa::shadow::produce_ssa_funcs;
    let src = format!("{src}\nint main(void) {{ return 0; }}\n");
    let program = crate::Compiler::new(super::with_prelude(&src))
        .compile()
        .expect("compile");
    let funcs = produce_ssa_funcs(&program, Target::host()).expect("produce_ssa_funcs");
    funcs
        .into_iter()
        .find(|f| f.name == name)
        .unwrap_or_else(|| panic!("function `{name}` not found"))
}

/// C99 6.3.1.4: `(float)n` converts the integer directly to single
/// precision. The walker emits a single `FpCast(IntToFp)` whose result
/// is f32-marked -- no `IntToFp`-to-double followed by an `F64ToF32`
/// narrowing (the double-then-narrow pair the direct path removes).
#[test]
fn int_to_float_lowers_to_single_precision_fpcast() {
    use crate::c5::ir::{FpCastKind, Inst};
    let f = ssa_func_named("float f(int n) { return (float)n; }", "f");
    let mut int_to_fp = None;
    for (i, inst) in f.insts.iter().enumerate() {
        if let Inst::FpCast { kind, .. } = inst {
            assert!(
                !matches!(kind, FpCastKind::F32ToF64 | FpCastKind::F64ToF32),
                "unexpected float<->double hop in a direct int->float cast"
            );
            assert!(int_to_fp.is_none(), "expected exactly one FpCast");
            int_to_fp = Some(i);
        }
    }
    let idx = int_to_fp.expect("an IntToFp cast");
    assert!(
        matches!(
            f.insts[idx],
            Inst::FpCast {
                kind: FpCastKind::IntToFp,
                ..
            }
        ),
        "the cast is IntToFp"
    );
    assert_eq!(
        f.f32_values.get(idx),
        Some(&true),
        "the IntToFp result is single-precision so emit picks scvtf s / cvtsi2ss"
    );
}

/// C99 6.3.1.4: `(int)f` on a `float` truncates directly. The walker
/// emits a single `FpCast(FpToInt)` reading the f32-marked source -- no
/// `F32ToF64` widen bracketing the conversion.
#[test]
fn float_to_int_lowers_to_direct_fpcast() {
    use crate::c5::ir::{FpCastKind, Inst};
    let f = ssa_func_named("int g(float x) { return (int)x; }", "g");
    let mut fp_to_int = None;
    for (i, inst) in f.insts.iter().enumerate() {
        if let Inst::FpCast { kind, value } = inst {
            assert!(
                !matches!(kind, FpCastKind::F32ToF64 | FpCastKind::F64ToF32),
                "unexpected float<->double hop in a direct float->int cast"
            );
            assert!(matches!(kind, FpCastKind::FpToInt), "the cast is FpToInt");
            assert_eq!(
                f.f32_values.get(*value as usize),
                Some(&true),
                "the source is single-precision so emit picks fcvtzs s / cvttss2si"
            );
            fp_to_int = Some(i);
        }
    }
    assert!(fp_to_int.is_some(), "expected an FpToInt cast");
}

/// C99 6.6: `(float)K` / `(double)K` of an integer literal folds to the
/// converted floating constant at build time -- no runtime `FpCast`,
/// so no int-register-to-FP conversion is materialised.
#[test]
fn int_const_cast_to_float_folds_to_imm() {
    use crate::c5::ir::Inst;
    for (src, name, want_f32) in [
        ("float h(void) { return (float)6; }", "h", true),
        ("double d(void) { return (double)6; }", "d", false),
    ] {
        let f = ssa_func_named(src, name);
        assert!(
            !f.insts.iter().any(|i| matches!(i, Inst::FpCast { .. })),
            "{name}: a constant cast must not leave a runtime FpCast"
        );
        // The returned value is an f32-marked (float) / plain (double)
        // Imm carrying the converted bit pattern.
        let found = f.insts.iter().enumerate().any(|(i, inst)| {
            matches!(inst, Inst::Imm(_)) && f.f32_values.get(i) == Some(&want_f32)
        });
        assert!(found, "{name}: expected a folded floating Imm constant");
    }
}

/// x86_64: an int->float convert emits an `xorps` of the destination
/// (dependency break) before `cvtsi2ss`, and the direct single-precision
/// convert means no `cvtss2sd` / `cvtsd2ss` (opcode `0F 5A`) double hop.
#[test]
fn x64_int_to_float_breaks_dep_and_avoids_double_hop() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_target(
        String::from("float f(int n) { return (float)n; }\nint main(void){return 0;}"),
        Target::LinuxX64,
    )
    .compile()
    .expect("compile");
    let obj = emit_native_with_options(
        &program,
        Target::LinuxX64,
        NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::new()
        },
    )
    .expect("emit relocatable");
    let text = elf64_section(&obj, ".text").expect(".text");
    let entry = elf_func_value(&obj, "f").expect("f symbol") as usize;
    let size = elf_func_symbols(&obj)
        .into_iter()
        .find(|(n, _)| n == "f")
        .map(|(_, s)| s as usize)
        .expect("f size");
    let body = &text[entry..(entry + size).min(text.len())];
    // `xorps xmm0, xmm0` = 0F 57 C0 (dependency break).
    let has_xorps = body.windows(3).any(|w| w == [0x0F, 0x57, 0xC0]);
    assert!(
        has_xorps,
        "expected an xorps dep-break before cvtsi2ss: {body:02x?}"
    );
    // `cvtsi2ss xmm, r64` = F3 REX.W 0F 2A (direct single convert).
    let has_cvtsi2ss = body
        .windows(4)
        .any(|w| w[0] == 0xF3 && w[1] & 0xF8 == 0x48 && w[2] == 0x0F && w[3] == 0x2A);
    assert!(
        has_cvtsi2ss,
        "expected cvtsi2ss (direct int->single): {body:02x?}"
    );
    // `0F 5A` is cvtss2sd / cvtsd2ss -- the double-then-narrow hop that
    // the direct path removes.
    let has_hop = body.windows(2).any(|w| w == [0x0F, 0x5A]);
    assert!(
        !has_hop,
        "unexpected float<->double convert (double hop): {body:02x?}"
    );
}

/// A relocatable Linux unit surfaces its `_Thread_local` layout to an
/// external linker: STT_TLS symbols for the defined globals (UNDEF for
/// the externs) and standard local-exec relocations at each access
/// site, so several units' TLS blocks merge with per-symbol offsets.
/// Without them every unit's baked single-unit offsets alias onto the
/// merged block's first slots and the units clobber each other.
#[test]
fn relocatable_elf_carries_tls_symbols_and_le_relocs() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    for (target, want_types) in [
        (Target::LinuxAarch64, &[549u32, 551][..]),
        (Target::LinuxX64, &[23u32][..]),
    ] {
        let src = "_Thread_local long counter = 7;\n\
                   extern _Thread_local long other;\n\
                   long bump(void) { counter += other; return counter; }\n\
                   int main(void) { return (int)bump(); }\n";
        let program = Compiler::with_target(src.to_string(), target)
            .compile()
            .unwrap();
        let obj = emit_native_with_options(
            &program,
            target,
            NativeOptions {
                output_kind: OutputKind::Relocatable,
                ..NativeOptions::new()
            },
        )
        .expect("emit relocatable");
        let rela = elf64_section(&obj, ".rela.text").expect(".rela.text");
        let mut types = std::collections::BTreeSet::new();
        for e in rela.chunks_exact(24) {
            let r_info = u64::from_le_bytes(e[8..16].try_into().unwrap());
            types.insert((r_info & 0xffff_ffff) as u32);
        }
        for want in want_types {
            assert!(
                types.contains(want),
                "{target:?}: expected TLS reloc type {want} in .rela.text, got {types:?}"
            );
        }
        let symtab = elf64_section(&obj, ".symtab").expect(".symtab");
        let strtab = elf64_section(&obj, ".strtab").expect(".strtab");
        let name_at = |off: usize| {
            let end = strtab[off..].iter().position(|b| *b == 0).unwrap() + off;
            core::str::from_utf8(&strtab[off..end]).unwrap()
        };
        let (mut saw_counter, mut saw_other_undef) = (false, false);
        for e in symtab.chunks_exact(24) {
            let st_name = u32::from_le_bytes(e[0..4].try_into().unwrap()) as usize;
            let st_info = e[4];
            let st_shndx = u16::from_le_bytes(e[6..8].try_into().unwrap());
            if st_info & 0xf != 6 {
                continue;
            }
            match name_at(st_name) {
                "counter" => {
                    assert_ne!(st_shndx, 0, "{target:?}: `counter` must be defined STT_TLS");
                    saw_counter = true;
                }
                "other" => {
                    assert_eq!(st_shndx, 0, "{target:?}: `other` must be UNDEF STT_TLS");
                    saw_other_undef = true;
                }
                _ => {}
            }
        }
        assert!(
            saw_counter && saw_other_undef,
            "{target:?}: missing STT_TLS symtab entries (counter={saw_counter}, other={saw_other_undef})"
        );
    }
}

/// A `_Bool` returned by a callee defined in another unit is only
/// defined in the low byte per the psABI; a caller that tests the full
/// return register (`!f()` / `if (f())`) must mask to the low byte
/// first, or garbage high bits (e.g. a gcc `sete %al` with no
/// zero-extend) make the branch go the wrong way. Regression for a
/// cross-unit `_Bool`-returning call whose `!f()` test took the wrong
/// branch on garbage high bits.
#[test]
fn external_bool_return_is_masked_before_branch() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "int _Bool_ext(void);\n\
               extern _Bool other(void);\n\
               int main(void) { return other() ? 7 : 3; }\n";
    let program = Compiler::with_target(src.to_string(), Target::LinuxX64)
        .compile()
        .unwrap();
    let obj = emit_native_with_options(
        &program,
        Target::LinuxX64,
        NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::new()
        },
    )
    .expect("emit relocatable");
    let text = elf64_section(&obj, ".text").expect(".text");
    // The bool return must be reduced to its low byte before the conditional
    // branch. `and $0xff, %rax` is the accumulator form 48 25 ff 00 00 00 --
    // the catalogue's shortest encoding for rax; 48 81 e0 ff 00 00 00 is the
    // equivalent 81 /4 form a non-accumulator register would take.
    let masks = text
        .windows(6)
        .any(|w| w == [0x48, 0x25, 0xff, 0x00, 0x00, 0x00])
        || text
            .windows(7)
            .any(|w| w == [0x48, 0x81, 0xe0, 0xff, 0x00, 0x00, 0x00]);
    assert!(
        masks,
        "expected the external _Bool return to be masked to its low byte before use"
    );
}

#[test]
fn naked_function_emits_body_only() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    // A `__attribute__((naked))` function's machine code is exactly its
    // inline-asm body -- no prologue (push rbp), no epilogue, no synthetic
    // return -- so an interrupt service routine can end in `iretq`.
    let src = "__attribute__((naked)) void isr(void){ __asm__ volatile(\"hlt\\n\\tiretq\"); }\n\
               int main(void){ return 0; }\n";
    let program = Compiler::with_target(src.to_string(), Target::LinuxX64)
        .compile()
        .unwrap();
    let obj = emit_native_with_options(
        &program,
        Target::LinuxX64,
        NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::new()
        },
    )
    .expect("emit relocatable");
    let text = elf64_section(&obj, ".text").expect(".text");
    let off = elf_func_value(&obj, "isr").expect("isr symbol value") as usize;
    let size = elf_func_symbols(&obj)
        .into_iter()
        .find(|(n, _)| n == "isr")
        .expect("isr symbol")
        .1 as usize;
    // hlt = F4, iretq = 48 CF. Body-only: exactly these three bytes, with no
    // prologue byte (55 = push rbp) and no trailing return (C3 / xor+ret).
    assert_eq!(
        &text[off..off + size],
        &[0xF4, 0x48, 0xCF],
        "naked function must emit its inline-asm body verbatim"
    );
}

#[test]
fn explicit_register_inline_asm_x64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    // Basic (operand-less) asm names hardware registers with a single `%`,
    // as an ISR's context-save does. The parser resolves `%rax`/`%r15` to the
    // register directly rather than treating `%` as an operand reference.
    let program = super::compile_str_bare(
        "void isr(void){ __asm__ volatile(\"mov %rax, %rbx\\n\\tpush %r15\\n\\tpop %r15\"); }\n\
         int main(void){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit LinuxX64");
    let has = |w: &[u8]| bytes.windows(w.len()).any(|c| c == w);
    assert!(has(&[0x48, 0x89, 0xc3]), "mov %rax,%rbx = 48 89 c3");
    assert!(has(&[0x41, 0x57]), "push %r15 = 41 57");
    assert!(has(&[0x41, 0x5f]), "pop %r15 = 41 5f");
}

#[test]
fn inline_asm_call_symbol_x64() {
    use crate::{Compiler, NativeOptions, Target, emit_native_with_options};
    // A naked ISR's `call <symbol>` resolves to the target function through a
    // relocation (E8 + rel32), patched by the same fixup pass as a normal
    // call. Compilation succeeding proves the symbol resolved -- an unknown
    // target bails -- and the naked body's `iretq` (48 cf) survives intact.
    let src = "void schedule(void){ }\n\
               __attribute__((naked)) void isr(void){ __asm__ volatile(\"call schedule\\n\\tiretq\"); }\n\
               int main(void){ return 0; }\n";
    let program = Compiler::with_target(src.to_string(), Target::LinuxX64)
        .compile()
        .unwrap();
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("naked call-symbol must emit -- the target must resolve");
    assert!(
        bytes.windows(2).any(|w| w == [0x48, 0xcf]),
        "the naked ISR body (iretq) must be present"
    );
}

#[test]
fn in_out_port_forms_inline_asm_x64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    // The variable-port form uses dx (EC/ED/EE/EF); the immediate-port form
    // uses E4/E5/E6/E7 + an imm8 (dropping the immediate would be a silent
    // miscompile). Word width adds the 0x66 prefix.
    let program = super::compile_str_bare(
        "void io(void){ __asm__ volatile(\n\
           \"inb %dx, %al\\n\\toutb %al, %dx\\n\\tinb $0x20, %al\\n\\t\
            outb %al, $0x20\\n\\tinw $0x60, %ax\\n\\toutl %eax, $0x70\"); }\n\
         int main(void){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit LinuxX64");
    let has = |w: &[u8]| bytes.windows(w.len()).any(|c| c == w);
    assert!(has(&[0xec]) && has(&[0xee]), "dx forms inb/outb = ec/ee");
    assert!(has(&[0xe4, 0x20]), "inb $0x20 = e4 20");
    assert!(has(&[0xe6, 0x20]), "outb $0x20 = e6 20");
    assert!(has(&[0x66, 0xe5, 0x60]), "inw $0x60 = 66 e5 60");
    assert!(has(&[0xe7, 0x70]), "outl $0x70 = e7 70");
}

#[test]
fn fxsave_fxrstor_inline_asm_x64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    // edk2's BaseLib reaches x87/SSE state save/restore through
    // `asm("fxsave %0")` / `asm("fxrstor %0")`; the x86_64 emit lowers
    // them to `fxsave m` (0F AE /0) and `fxrstor m` (0F AE /1).
    let program = super::compile_str_bare(
        "typedef struct { unsigned char b[512]; } FXBUF;\n\
         void save(FXBUF *p){ __asm__ __volatile__(\"fxsave %0\":\"=m\"(*p)); }\n\
         void restore(FXBUF *p){ __asm__ __volatile__(\"fxrstor %0\"::\"m\"(*p)); }\n\
         int main(){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit LinuxX64");
    // fxsave m: 0F AE with ModRM reg field 0 (mod=00); fxrstor: reg field 1.
    let has = |reg: u8| {
        bytes
            .windows(3)
            .any(|w| w[0] == 0x0F && w[1] == 0xAE && (w[2] >> 3) & 7 == reg && w[2] >> 6 == 0)
    };
    assert!(has(0), "expected an `fxsave m` (0F AE /0) encoding");
    assert!(has(1), "expected an `fxrstor m` (0F AE /1) encoding");
}

#[test]
fn movd_mmx_inline_asm_x64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    // edk2's BaseLib reads/writes the MMX registers through
    // `asm("movd %%mm0, %0")` / `asm("movd %0, %%mm3")`; the x86_64 emit
    // lowers them to `movd r/m32, mm` (0F 7E /r) and `movd mm, r/m32`
    // (0F 6E /r) with the mm index in ModRM.reg and no 0x66 prefix.
    let program = super::compile_str_bare(
        "typedef unsigned long long U64;\n\
         U64 rd(void){ U64 d; __asm__ __volatile__(\"movd %%mm0, %0\":\"=r\"(d)); return d; }\n\
         void wr(U64 v){ __asm__ __volatile__(\"movd %0, %%mm3\"::\"r\"(v)); }\n\
         int main(){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit LinuxX64");
    let has = |op: u8| bytes.windows(2).any(|w| w[0] == 0x0F && w[1] == op);
    assert!(has(0x7E), "expected a `movd r/m32, mm` (0F 7E) encoding");
    assert!(has(0x6E), "expected a `movd mm, r/m32` (0F 6E) encoding");
    // The XMM form (0x66 0F 6E/7E) must NOT be emitted for MMX movd.
    let has_66 = bytes
        .windows(3)
        .any(|w| w[0] == 0x66 && w[1] == 0x0F && (w[2] == 0x6E || w[2] == 0x7E));
    assert!(!has_66, "MMX movd must not carry the 0x66 (XMM) prefix");
}

#[test]
fn operandless_privileged_inline_asm_x64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    // edk2's BaseLib reaches the operandless privileged instructions through
    // bare `asm("sti")` / `asm("cli")` / etc. The general x86_64 asm path
    // encodes each from its mnemonic with no operands.
    let program = super::compile_str_bare(
        "void e_sti(void){ __asm__ __volatile__(\"sti\":::\"memory\"); }\n\
         void e_cli(void){ __asm__ __volatile__(\"cli\":::\"memory\"); }\n\
         void e_wbinvd(void){ __asm__ __volatile__(\"wbinvd\":::\"memory\"); }\n\
         void e_invd(void){ __asm__ __volatile__(\"invd\":::\"memory\"); }\n\
         unsigned long long e_rdmsr(unsigned int i){ unsigned int lo,hi;\
           __asm__ __volatile__(\"rdmsr\":\"=a\"(lo),\"=d\"(hi):\"c\"(i));\
           return ((unsigned long long)hi<<32)|lo; }\n\
         void e_wrmsr(unsigned int i,unsigned int lo,unsigned int hi){\
           __asm__ __volatile__(\"wrmsr\"::\"c\"(i),\"a\"(lo),\"d\"(hi)); }\n\
         void e_monitor(void*p,unsigned int e,unsigned int h){\
           __asm__ __volatile__(\"monitor\"::\"a\"(p),\"c\"(e),\"d\"(h)); }\n\
         void e_mwait(unsigned int e,unsigned int h){\
           __asm__ __volatile__(\"mwait\"::\"a\"(e),\"c\"(h)); }\n\
         int main(){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit LinuxX64");
    let has1 = |op: u8| bytes.contains(&op);
    let has2 = |a: u8, b: u8| bytes.windows(2).any(|w| w[0] == a && w[1] == b);
    let has3 = |a: u8, b: u8, c: u8| {
        bytes
            .windows(3)
            .any(|w| w[0] == a && w[1] == b && w[2] == c)
    };
    assert!(has1(0xFB), "expected `sti` (FB)");
    assert!(has1(0xFA), "expected `cli` (FA)");
    assert!(has2(0x0F, 0x09), "expected `wbinvd` (0F 09)");
    assert!(has2(0x0F, 0x08), "expected `invd` (0F 08)");
    assert!(has2(0x0F, 0x32), "expected `rdmsr` (0F 32)");
    assert!(has2(0x0F, 0x30), "expected `wrmsr` (0F 30)");
    assert!(has3(0x0F, 0x01, 0xC8), "expected `monitor` (0F 01 C8)");
    assert!(has3(0x0F, 0x01, 0xC9), "expected `mwait` (0F 01 C9)");
}

#[test]
fn descriptor_table_inline_asm_x64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    // edk2's BaseLib reads/writes the descriptor-table registers and flushes
    // cache lines through single-memory-operand asm. The x86_64 emit forces
    // the operand address into r10 and selects the form by opcode + ModRM.reg:
    //   sgdt/sidt = 0F 01 /0,/1 ; lgdt/lidt = 0F 01 /2,/3 ;
    //   sldt/str  = 0F 00 /0,/1 ; clflush   = 0F AE /7.
    let program = super::compile_str_bare(
        "typedef struct { unsigned short limit; unsigned long base; } DESC;\n\
         void sgdt(DESC*g){ __asm__ __volatile__(\"sgdt %0\":\"=m\"(*g)); }\n\
         void lgdt(DESC*g){ __asm__ __volatile__(\"lgdt %0\"::\"m\"(*g)); }\n\
         void sidt(DESC*g){ __asm__ __volatile__(\"sidt  %0\":\"=m\"(*g)); }\n\
         void lidt(DESC*g){ __asm__ __volatile__(\"lidt %0\"::\"m\"(*g)); }\n\
         unsigned short str_(void){ unsigned short d;\
           __asm__ __volatile__(\"str  %0\":\"=r\"(d)); return d; }\n\
         unsigned short sldt(void){ unsigned short d;\
           __asm__ __volatile__(\"sldt  %0\":\"=g\"(d)); return d; }\n\
         void lldt(unsigned short v){ __asm__ __volatile__(\"lldtw  %0\"::\"g\"(v)); }\n\
         void* clflush(void*p){ __asm__ __volatile__(\"clflush (%0)\"::\"r\"(p):\"memory\");\
           return p; }\n\
         int main(){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit LinuxX64");
    // REX.B(0x41) 0F <op2> ModRM(reg=field, rm=010): a memory operand in r10.
    let modrm = |field: u8| (field << 3) | 0x02;
    let has = |op2: u8, field: u8| {
        bytes
            .windows(4)
            .any(|w| w[0] == 0x41 && w[1] == 0x0F && w[2] == op2 && w[3] == modrm(field))
    };
    assert!(has(0x01, 0), "expected `sgdt m` (0F 01 /0)");
    assert!(has(0x01, 2), "expected `lgdt m` (0F 01 /2)");
    assert!(has(0x01, 1), "expected `sidt m` (0F 01 /1)");
    assert!(has(0x01, 3), "expected `lidt m` (0F 01 /3)");
    assert!(has(0x00, 1), "expected `str m` (0F 00 /1)");
    assert!(has(0x00, 0), "expected `sldt m` (0F 00 /0)");
    assert!(has(0x00, 2), "expected `lldt m` (0F 00 /2)");
    assert!(has(0xAE, 7), "expected `clflush m` (0F AE /7)");
}

#[test]
fn control_debug_segment_mov_inline_asm_x64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    // edk2's BaseLib reads/writes the control (cr0..cr4) and debug (dr0..dr7)
    // registers and reads the segment registers through `mov` with a special
    // register named in the template. The x86_64 emit selects:
    //   read  cr/dr -> gpr : 0F 20 / 0F 21 ; write gpr -> cr/dr : 0F 22 / 0F 23
    //   read  seg   -> gpr : 8C.
    let program = super::compile_str_bare(
        "typedef unsigned long UN;\n\
         UN rcr0(void){ UN d; __asm__ __volatile__(\"mov  %%cr0,%0\":\"=r\"(d)); return d; }\n\
         UN rcr3(void){ UN d; __asm__ __volatile__(\"mov  %%cr3,  %0\":\"=r\"(d)); return d; }\n\
         void wcr0(UN v){ __asm__ __volatile__(\"mov  %0, %%cr0\"::\"r\"(v)); }\n\
         void wcr4(UN v){ __asm__ __volatile__(\"mov  %0, %%cr4\"::\"r\"(v)); }\n\
         UN rdr0(void){ UN d; __asm__ __volatile__(\"mov  %%dr0, %0\":\"=r\"(d)); return d; }\n\
         UN rdr7(void){ UN d; __asm__ __volatile__(\"mov  %%dr7, %0\":\"=r\"(d)); return d; }\n\
         void wdr0(UN v){ __asm__ __volatile__(\"mov  %0, %%dr0\"::\"r\"(v)); }\n\
         void wdr7(UN v){ __asm__ __volatile__(\"mov  %0, %%dr7\"::\"r\"(v)); }\n\
         unsigned short rcs(void){ unsigned short d;\
           __asm__ __volatile__(\"mov   %%cs, %0\":\"=a\"(d)); return d; }\n\
         int main(){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit LinuxX64");
    // 0F <op2> ModRM(mod=11, reg=cr/dr index, rm=gpr). Match by opcode + the
    // ModRM.reg field so a specific register index is asserted.
    let has_special = |op2: u8, reg: u8| {
        bytes
            .windows(3)
            .any(|w| w[0] == 0x0F && w[1] == op2 && w[2] >> 6 == 3 && (w[2] >> 3) & 7 == reg)
    };
    assert!(has_special(0x20, 0), "expected `mov cr0, r` (0F 20 reg=0)");
    assert!(has_special(0x20, 3), "expected `mov cr3, r` (0F 20 reg=3)");
    assert!(has_special(0x22, 0), "expected `mov r, cr0` (0F 22 reg=0)");
    assert!(has_special(0x22, 4), "expected `mov r, cr4` (0F 22 reg=4)");
    assert!(has_special(0x21, 0), "expected `mov dr0, r` (0F 21 reg=0)");
    assert!(has_special(0x21, 7), "expected `mov dr7, r` (0F 21 reg=7)");
    assert!(has_special(0x23, 0), "expected `mov r, dr0` (0F 23 reg=0)");
    assert!(has_special(0x23, 7), "expected `mov r, dr7` (0F 23 reg=7)");
    // Segment read: 8C /r with ModRM.reg = the Sreg code (cs = 1).
    let has_seg = bytes
        .windows(2)
        .any(|w| w[0] == 0x8C && w[1] >> 6 == 3 && (w[1] >> 3) & 7 == 1);
    assert!(has_seg, "expected `mov cs, r` (8C reg=1)");
}

#[test]
fn interlocked_and_halt_inline_asm_x64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    // edk2's BaseSynchronizationLib / BaseCpuLib reach the atomic primitives
    // and the halt through `lock`-prefixed multi-line asm blocks. The general
    // asm path encodes each line: lock = F0, xadd = 0F C1, cmpxchg = 0F B1,
    // inc/dec = FF /0,/1, hlt = F4. The `"+m"` destinations are memory
    // references (`(%reg)`, ModRM mod != 11); a `lock` prefix on a register
    // destination is an invalid encoding that faults at runtime (#UD).
    let program = super::compile_str_bare(
        "typedef unsigned int U32;\n\
         void sleep(void){ __asm__ __volatile__(\"hlt\":::\"memory\"); }\n\
         U32 inc(U32 *v){ U32 r; __asm__ __volatile__(\
           \"movl $1, %%eax \\n\\t\" \"lock \\n\\t\" \"xadd %%eax, %1 \\n\\t\" \"inc %%eax \\n\\t\"\
           : \"=&a\"(r), \"+m\"(*v) : : \"memory\",\"cc\"); return r; }\n\
         U32 dec(U32 *v){ U32 r; __asm__ __volatile__(\
           \"movl $-1, %%eax \\n\\t\" \"lock \\n\\t\" \"xadd %%eax, %1 \\n\\t\" \"dec %%eax \\n\\t\"\
           : \"=&a\"(r), \"+m\"(*v) : : \"memory\",\"cc\"); return r; }\n\
         U32 cx(U32 *v,U32 c,U32 x){ U32 r; __asm__ __volatile__(\
           \"lock \\n\\t\" \"cmpxchgl %2, %1 \\n\\t\"\
           : \"=a\"(r),\"+m\"(*v) : \"q\"(x),\"0\"(c) : \"memory\",\"cc\"); return r; }\n\
         int main(){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit LinuxX64");
    assert!(bytes.contains(&0xF4), "expected `hlt` (F4)");
    assert!(bytes.contains(&0xF0), "expected the `lock` prefix (F0)");
    // xadd / cmpxchg to a `"+m"` destination: 0F C1 / 0F B1 with ModRM.mod
    // != 11 (a memory reference), so the preceding `lock` is a valid form.
    let has_mem = |a: u8, b: u8| {
        bytes
            .windows(3)
            .any(|w| w[0] == a && w[1] == b && w[2] >> 6 != 3)
    };
    assert!(has_mem(0x0F, 0xC1), "expected `xadd r, m` (0F C1, memory)");
    assert!(
        has_mem(0x0F, 0xB1),
        "expected `cmpxchg r, m` (0F B1, memory)"
    );
    // inc/dec r/m32: FF /0 and FF /1, register form.
    let has_ff = |field: u8| {
        bytes
            .windows(2)
            .any(|w| w[0] == 0xFF && w[1] >> 6 == 3 && (w[1] >> 3) & 7 == field)
    };
    assert!(has_ff(0), "expected `inc r/m` (FF /0)");
    assert!(has_ff(1), "expected `dec r/m` (FF /1)");
}

//! Codegen tests: compile a fixture and inspect post-link metadata.

use super::compile_fixture_bare;

#[test]
fn entry_pc_points_at_main() {
    // `main` is the first (and only) function in this fixture, so its
    // ent_pc is 0.
    let program = compile_fixture_bare("ir_translation_simple.c");
    assert_eq!(program.entry_pc, 0);
}

#[test]
fn unsupported_inline_asm_reports_the_specific_form() {
    use crate::{NativeOptions, Target};
    // An inline-asm form the encoder cannot handle must report the specific
    // reason, not the generic "op outside the implemented subset" fallback that
    // reads like an internal compiler error. `add` with too many registers has
    // no encoding -- a stable trigger, since no `add` form ever takes five.
    let program = super::compile_str(
        "int main(void){ __asm__ volatile(\"add x0, x1, x2, x3, x5\" ::: \"x0\"); return 0; }",
    );
    let err = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxAarch64,
        NativeOptions::default(),
    )
    .expect_err("add with five registers is not encodable");
    let msg = format!("{err}");
    assert!(msg.contains("no A64 encoding"), "specific reason: {msg}");
    assert!(
        !msg.contains("implemented subset"),
        "not the generic fallback: {msg}"
    );
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

/// `(sh_addr, contents)` of the named section of a linked ELF image.
#[cfg(feature = "full")]
fn elf_section_addr_bytes(b: &[u8], want: &[u8]) -> Option<(u64, alloc::vec::Vec<u8>)> {
    let u16a = |o: usize| u16::from_le_bytes(b[o..o + 2].try_into().unwrap()) as usize;
    let u32a = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap()) as usize;
    let u64a = |o: usize| u64::from_le_bytes(b[o..o + 8].try_into().unwrap()) as usize;
    let shoff = u64a(0x28);
    let shentsize = u16a(0x3a);
    let shnum = u16a(0x3c);
    let stroff = u64a(shoff + u16a(0x3e) * shentsize + 0x18);
    (0..shnum).map(|i| shoff + i * shentsize).find_map(|sh| {
        let name = stroff + u32a(sh);
        let end = name + b[name..].iter().position(|&c| c == 0)?;
        if &b[name..end] != want {
            return None;
        }
        let off = u64a(sh + 0x18);
        let size = u64a(sh + 0x20);
        Some((u64a(sh + 0x10) as u64, b[off..off + size].to_vec()))
    })
}

/// `(addr, contents)` of the named section of a linked Mach-O image.
#[cfg(feature = "full")]
fn macho_section_addr_bytes(b: &[u8], want: &[u8]) -> Option<(u64, alloc::vec::Vec<u8>)> {
    let u32a = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap()) as usize;
    let u64a = |o: usize| u64::from_le_bytes(b[o..o + 8].try_into().unwrap());
    let ncmds = u32a(16);
    let mut lc = 32;
    for _ in 0..ncmds {
        // LC_SEGMENT_64 = 0x19; sections follow the 72-byte command.
        if u32a(lc) == 0x19 {
            let nsects = u32a(lc + 64);
            for s in 0..nsects {
                let sh = lc + 72 + s * 80;
                let end = sh + b[sh..sh + 16].iter().position(|&c| c == 0).unwrap_or(16);
                if &b[sh..end] == want {
                    let off = u32a(sh + 48);
                    let size = u64a(sh + 40) as usize;
                    return Some((u64a(sh + 32), b[off..off + size].to_vec()));
                }
            }
        }
        lc += u32a(lc + 4);
    }
    None
}

/// `(code address, code bytes, address range of the import slots)` of a
/// linked image: the IAT entry named by `pe_import` for a PE, the `.got`
/// / `__got` region for the other two formats.
#[cfg(feature = "full")]
fn import_slot_layout(
    image: &[u8],
    target: crate::Target,
    pe_import: &str,
) -> Option<(u64, alloc::vec::Vec<u8>, core::ops::Range<u64>)> {
    use crate::Target;
    match target {
        Target::WindowsX64 | Target::WindowsAarch64 => {
            let (text_rva, text) = pe_text_section(image)?;
            let slot = pe_iat_slot_rva(image, pe_import)? as u64;
            Some((text_rva as u64, text.to_vec(), slot..slot + 8))
        }
        Target::LinuxX64 | Target::LinuxAarch64 => {
            let (text_addr, text) = elf_section_addr_bytes(image, b".text")?;
            let (got_addr, got) = elf_section_addr_bytes(image, b".got")?;
            Some((text_addr, text, got_addr..got_addr + got.len() as u64))
        }
        Target::MacOSAarch64 => {
            let (text_addr, text) = macho_section_addr_bytes(image, b"__text")?;
            let (got_addr, got) = macho_section_addr_bytes(image, b"__got")?;
            Some((text_addr, text, got_addr..got_addr + got.len() as u64))
        }
    }
}

/// Count the references into `slots` that read through a slot and the
/// ones that materialise a slot's own address. Scans `code` for the
/// two page-relative forms each machine uses; the resolved target has
/// to land in `slots`, so an unaligned scan start cannot contribute.
#[cfg(feature = "full")]
fn count_slot_references(
    target: crate::Target,
    code_va: u64,
    code: &[u8],
    slots: &core::ops::Range<u64>,
) -> (usize, usize) {
    use crate::Target;
    let (mut through, mut addressed) = (0usize, 0usize);
    match target {
        Target::LinuxX64 | Target::WindowsX64 => {
            // `REX.W 8B /r` loads and `REX.W 8D /r` takes the address;
            // both are 7 bytes with a RIP-relative modrm (mod 00, rm 101).
            for i in 0..code.len().saturating_sub(7) {
                if code[i] & 0xF8 != 0x48 || code[i + 2] & 0xC7 != 0x05 {
                    continue;
                }
                let disp = i32::from_le_bytes(code[i + 3..i + 7].try_into().unwrap()) as i64;
                let hit = slots.contains(&((code_va + i as u64 + 7).wrapping_add(disp as u64)));
                match code[i + 1] {
                    0x8B if hit => through += 1,
                    0x8D if hit => addressed += 1,
                    _ => {}
                }
            }
        }
        Target::LinuxAarch64 | Target::WindowsAarch64 | Target::MacOSAarch64 => {
            let word = |i: usize| u32::from_le_bytes(code[i..i + 4].try_into().unwrap());
            for i in (0..code.len().saturating_sub(7)).step_by(4) {
                let adrp = word(i);
                if adrp & 0x9F00_0000 != 0x9000_0000 {
                    continue;
                }
                let imm21 = ((adrp >> 29) & 3) | (((adrp >> 5) & 0x7_FFFF) << 2);
                let pages = (((imm21 << 11) as i32) >> 11) as i64;
                let page = (((code_va + i as u64) & !0xFFF) as i64 + (pages << 12)) as u64;
                let next = word(i + 4);
                if (next >> 5) & 0x1F != adrp & 0x1F {
                    continue;
                }
                let imm12 = ((next >> 10) & 0xFFF) as u64;
                if next & 0x7F80_0000 == 0x1100_0000 {
                    addressed += slots.contains(&page.wrapping_add(imm12)) as usize;
                } else if next & 0x3B00_0000 == 0x3900_0000 {
                    let scale = 1u64 << (next >> 30);
                    through += slots.contains(&page.wrapping_add(imm12 * scale)) as usize;
                }
            }
        }
    }
    (through, addressed)
}

/// A reference to an imported data object reaches the object through the
/// slot the loader fills, so the emitted sequence has to read that slot.
/// Materialising the slot's address instead hands the object's address
/// to code expecting its value, and every later dereference is off by
/// one indirection. Each of the three image writers patches the site
/// with its own helper, so the property is checked on every target.
#[cfg(feature = "full")]
#[test]
fn an_import_slot_reference_reads_the_slot_on_every_target() {
    use crate::{Compiler, NativeOptions, Target};
    const SRC: &str = "#include <stdio.h>\n#include <time.h>\n\
                       void *fp(void) { return (void *)&puts; }\n\
                       long tz(void) { return timezone; }\n\
                       int main(void) { return fp() != 0 && tz() == 0; }\n";
    let targets = [
        Target::LinuxX64,
        Target::LinuxAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
        Target::MacOSAarch64,
    ];
    // An ELF x86_64 image resolves the bound data object by copy
    // relocation, so `timezone` reads no slot there; `&puts` still does,
    // so every target ends up reading one.
    let mut reading = 0usize;
    for target in targets {
        let program = Compiler::with_target(SRC.to_string(), target)
            .compile()
            .unwrap_or_else(|e| panic!("{target:?}: compile: {e:?}"));
        let image = super::link_executable_with_runtime(&program, target, NativeOptions::default())
            .unwrap_or_else(|e| panic!("{target:?}: link: {e}"));
        let (code_va, code, slots) = import_slot_layout(&image, target, "_timezone")
            .unwrap_or_else(|| panic!("{target:?}: image carries no import-slot region"));
        let (through, addressed) = count_slot_references(target, code_va, &code, &slots);
        assert_eq!(
            addressed, 0,
            "{target:?}: {addressed} reference(s) materialise an import slot's address \
             instead of reading it"
        );
        reading += usize::from(through > 0);
    }
    assert_eq!(
        reading,
        targets.len(),
        "the scan proves nothing unless the images actually read their import slots"
    );
}

/// A shared library's reference to an undefined data symbol reaches the
/// object through the import slot the loader fills. Routing it to a call
/// stub instead leaves the reference pointing at code, so every read
/// returns instruction bytes -- with no diagnostic at link or load. The
/// source materialises no other in-code address, so a page-relative
/// address landing inside the code section is that misrouting.
#[cfg(feature = "full")]
#[test]
fn a_shared_library_data_import_reads_its_slot_on_every_target() {
    use crate::{Compiler, NativeOptions, Target};
    const SRC: &str = "extern int host_var;\nextern int host_fn(void);\n\
                       #pragma export(read_var)\nint read_var(void) { return host_var; }\n\
                       #pragma export(call_fn)\nint call_fn(void) { return host_fn(); }\n";
    for target in [
        Target::LinuxX64,
        Target::LinuxAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
        Target::MacOSAarch64,
    ] {
        let program = Compiler::with_target(SRC.to_string(), target)
            .compile()
            .unwrap_or_else(|e| panic!("{target:?}: compile: {e:?}"));
        let image = super::link_shared_library(&program, target, NativeOptions::default())
            .unwrap_or_else(|e| panic!("{target:?}: link: {e}"));
        let (code_va, code, slots) = import_slot_layout(&image, target, "host_var")
            .unwrap_or_else(|| panic!("{target:?}: image carries no import-slot region"));
        let (through, addressed) = count_slot_references(target, code_va, &code, &slots);
        assert_eq!(
            addressed, 0,
            "{target:?}: a data import's slot is read, never addressed"
        );
        assert!(
            through > 0,
            "{target:?}: the data reference must read the import slot"
        );
        let text = code_va..code_va + code.len() as u64;
        let (_, into_text) = count_slot_references(target, code_va, &code, &text);
        assert_eq!(
            into_text, 0,
            "{target:?}: {into_text} reference(s) materialise an address inside the code \
             section -- a data import bound to a call stub"
        );
    }
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
    let funcs = crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, Target::host(), false)
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

/// The PE entry stub direct-calls `__c5_entry`, which a bare single-TU
/// image has no runtime to supply. The resulting failure is a problem
/// with the link inputs, so it must be reported in the `error: <message>`
/// form every diagnostic reader keys on rather than as a bare sentence a
/// log scraper cannot find.
#[test]
fn pe_entry_stub_without_runtime_reports_a_link_error() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare("int main(void) { return 0; }");
    let err = emit_native_with_options(&program, Target::WindowsX64, NativeOptions::default())
        .expect_err("a PE image with no linked runtime has no `__c5_entry` to call");
    let msg = format!("{err}");
    assert!(
        msg.starts_with("error: ") && msg.contains("__c5_entry"),
        "the missing-runtime failure is not a well-formed diagnostic: {msg:?}"
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

/// No atomic form on a 16-byte object lowers: the paired
/// compare-exchange (x86-64 `cmpxchg16b`, aarch64 `casp` / `ldxp`-`stxp`)
/// is not emitted, and two 8-byte accesses would tear. Every form must
/// be rejected with that diagnostic rather than lowered through the
/// zero-width access `type_size_bytes` yields for the struct-backed
/// __int128. `__atomic_is_lock_free` reports the same limit, so a
/// caller can test for it (`atomic_lock_free_widths.c`).
/// TODO: lower 16-byte objects via the paired compare-exchange.
#[test]
fn atomic128_is_rejected_not_miscompiled() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let bodies = [
        "return __atomic_compare_exchange_n(p, e, n, 0, 5, 5);",
        "__atomic_store_n(p, n, 5); return 0;",
        "return (int)__atomic_load_n(p, 5);",
        "return (int)__atomic_fetch_add(p, n, 5);",
        "__atomic_load(p, e, 5); return 0;",
        "__atomic_store(p, e, 5); return 0;",
    ];
    for body in bodies {
        let src = alloc::format!(
            "int f(unsigned __int128 *p, unsigned __int128 *e, unsigned __int128 n){{ {body} }} \
             int main(){{ return 0; }}"
        );
        let program = super::compile_str_bare(&src);
        let err = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
            .unwrap_err();
        assert!(
            err.to_string().contains("16-byte atomic object"),
            "expected the wide-atomic rejection for `{body}`, got: {err}",
        );
    }
}

/// `__builtin_*_overflow` with a 128-bit operand or result lowers over
/// the two halves on every target: the walk must produce the wrapped
/// value and the flag inline, with no call to a runtime helper. The
/// values are checked against gcc / clang by
/// `int128_overflow_builtin.c`.
#[test]
fn builtin_overflow_on_128bit_operand_lowers_inline() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare(
        "int f(unsigned __int128 a, unsigned __int128 b, unsigned __int128 *r){ \
             return __builtin_add_overflow(a, b, r); } \
         int g(__int128 a, long long b, int *r){ \
             return __builtin_mul_overflow(a, b, r); } \
         int main(){ return 0; }",
    );
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        emit_native_with_options(&program, target, NativeOptions::default())
            .expect("128-bit __builtin_*_overflow must lower");
    }
}

/// The x86 `x` (xmm) inline-asm operand path moves a full 128-bit value
/// (movups), so it requires a 16-byte `__m128i`. A scalar float / double `x`
/// operand must be rejected at parse rather than over-reading / over-writing
/// its 4/8-byte storage. TODO: scalar `x` via movss / movsd.
#[test]
fn scalar_x_inline_asm_operand_is_rejected() {
    use crate::{Compiler, Target};
    let err = Compiler::with_target(
        "double f(double a){ double r; __asm__(\"movsd %1, %0\" : \"=x\"(r) : \"x\"(a)); \
             return r; } int main(void){ return (int) f(1.0); }"
            .to_string(),
        Target::LinuxX64,
    )
    .compile()
    .expect_err("a scalar `x` operand must be rejected, not over-moved");
    assert!(
        err.to_string().contains("16-byte (__m128i) `x` operands"),
        "expected the scalar-`x` rejection, got: {err}",
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

/// 128-bit compare-and-swap through the pre-LSE `ldxp`/`stxp` exclusive pair,
/// the kernel `__ll_sc__cmpxchg128` shape. Unlike the recognized load/store
/// idioms this is not lowered to an intrinsic: `prfm`, `ldxp`, `cmp`, `ccmp`,
/// `b.ne`, `stxp`/`stlxp` and `cbnz` each go through the per-instruction
/// inline-asm encoder. Before `ldxp` gained a catalogue row this failed to
/// encode; the test locks the generic encoding and the plain / release forms.
#[test]
fn atomic128_cmpxchg_llsc_generic_encoder_aarch64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    let program = super::compile_str_bare_for(
        "typedef unsigned long long u64;\n\
         typedef unsigned __int128 u128;\n\
         int cx(volatile u128 *p, u64 ol, u64 oh, u64 nl, u64 nh){\n\
           u64 rl, rh; unsigned t;\n\
           __asm__ volatile(\"prfm pstl1strm, %[v]\\n\\t\"\n\
             \"1: ldxp %[rl], %[rh], %[v]\\n\\t\"\n\
             \"cmp %[rl], %[ol]\\n\\t\"\n\
             \"ccmp %[rh], %[oh], 0, eq\\n\\t\"\n\
             \"b.ne 2f\\n\\t\"\n\
             \"stxp %w[t], %[nl], %[nh], %[v]\\n\\t\"\n\
             \"cbnz %w[t], 1b\\n2:\"\n\
             : [v]\"+Q\"(*p), [rl]\"=&r\"(rl), [rh]\"=&r\"(rh), [t]\"=&r\"(t)\n\
             : [ol]\"r\"(ol), [oh]\"r\"(oh), [nl]\"r\"(nl), [nh]\"r\"(nh)\n\
             : \"cc\", \"memory\"); return rl==ol && rh==oh; }\n\
         int cxm(volatile u128 *p, u64 ol, u64 oh, u64 nl, u64 nh){\n\
           u64 rl, rh; unsigned t;\n\
           __asm__ volatile(\"prfm pstl1strm, %[v]\\n\\t\"\n\
             \"1: ldxp %[rl], %[rh], %[v]\\n\\t\"\n\
             \"cmp %[rl], %[ol]\\n\\t\"\n\
             \"ccmp %[rh], %[oh], 0, eq\\n\\t\"\n\
             \"b.ne 2f\\n\\t\"\n\
             \"stlxp %w[t], %[nl], %[nh], %[v]\\n\\t\"\n\
             \"cbnz %w[t], 1b\\n\\tdmb ish\\n2:\"\n\
             : [v]\"+Q\"(*p), [rl]\"=&r\"(rl), [rh]\"=&r\"(rh), [t]\"=&r\"(t)\n\
             : [ol]\"r\"(ol), [oh]\"r\"(oh), [nl]\"r\"(nl), [nh]\"r\"(nh)\n\
             : \"cc\", \"memory\"); return rl==ol && rh==oh; }\n\
         int main(void){ return 0; }",
        Target::LinuxAarch64,
    );
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, NativeOptions::default())
        .expect("emit MacOSAarch64");
    let words = || {
        bytes
            .windows(4)
            .map(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]))
    };
    // LDXP Xt1, Xt2, [Xn] (acquire bit 15 clear), verified against clang.
    let any_ldxp = words().any(|w| (w & 0xFFFF_8000) == 0xC87F_0000);
    // STXP Ws, Xt1, Xt2, [Xn] and its release sibling STLXP (bit 15 set).
    let any_stxp = words().any(|w| (w & 0xFFE0_8000) == 0xC820_0000);
    let any_stlxp = words().any(|w| (w & 0xFFE0_8000) == 0xC820_8000);
    // PRFM (immediate), unsigned-offset form.
    let any_prfm = words().any(|w| (w & 0xFFC0_0000) == 0xF980_0000);
    assert!(any_ldxp, "cmpxchg128 must emit a generic-path LDXP");
    assert!(any_stxp, "cmpxchg128 must emit an STXP");
    assert!(any_stlxp, "cmpxchg128 (release) must emit an STLXP");
    assert!(any_prfm, "cmpxchg128 must emit the PRFM prefetch");
}

/// The AArch64 `Q` constraint: a memory operand whose address is a single
/// base register, substituted as `[xN]`. Operand registers assign in pool
/// order (x0, x1, ...), so the expected words are exact; each is verified
/// against `clang -target aarch64-linux-gnu`.
#[test]
fn q_constraint_acquire_release_aarch64() {
    use crate::{Compiler, NativeOptions, Target, emit_native_with_options};
    let program = Compiler::with_target(
        "long la(long *p){ long v;\n\
           __asm__ volatile(\"ldar %0, %1\" : \"=r\"(v) : \"Q\"(*p) : \"memory\");\n\
           return v; }\n\
         void sr(long *p, long v){\n\
           __asm__ volatile(\"stlr %1, %0\" : \"=Q\"(*p) : \"r\"(v) : \"memory\"); }\n\
         int main(){ return 0; }"
            .to_string(),
        Target::LinuxAarch64,
    )
    .compile()
    .expect("compile");
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, NativeOptions::default())
        .expect("emit LinuxAarch64");
    let words = || {
        bytes
            .windows(4)
            .map(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]))
    };
    // `=r` -> x0, `Q` -> x1; `=Q` -> x0, `r` -> x1.
    assert!(words().any(|w| w == 0xC8DF_FC20), "ldar x0, [x1]");
    assert!(words().any(|w| w == 0xC89F_FC01), "stlr x1, [x0]");
}

/// The `+Q` read-write form in an LL/SC retry loop: one `%2` reference
/// feeds both exclusive instructions, and the `%w` modifiers on the other
/// operands are unaffected. The four words must be contiguous; each is
/// verified against `clang -target aarch64-linux-gnu`.
#[test]
fn q_constraint_llsc_loop_aarch64() {
    use crate::{Compiler, NativeOptions, Target, emit_native_with_options};
    let program = Compiler::with_target(
        "unsigned fa(unsigned *p, unsigned inc){ unsigned res, tmp;\n\
           __asm__ volatile(\"1: ldxr %w0, %2\\n\\t\"\n\
                            \"add %w0, %w0, %w3\\n\\t\"\n\
                            \"stxr %w1, %w0, %2\\n\\t\"\n\
                            \"cbnz %w1, 1b\"\n\
                            : \"=&r\"(res), \"=&r\"(tmp), \"+Q\"(*p)\n\
                            : \"r\"(inc) : \"memory\");\n\
           return res; }\n\
         int main(){ return 0; }"
            .to_string(),
        Target::LinuxAarch64,
    )
    .compile()
    .expect("compile");
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, NativeOptions::default())
        .expect("emit LinuxAarch64");
    // res -> x0, tmp -> x1, `+Q` -> x2 (address), inc -> x3.
    let expected: [u32; 4] = [
        0x885F_7C40, // ldxr w0, [x2]
        0x0B03_0000, // add w0, w0, w3
        0x8801_7C40, // stxr w1, w0, [x2]
        0x35FF_FFA1, // cbnz w1, 1b (-12)
    ];
    let found = bytes.windows(16).any(|w| {
        (0..4).all(|i| u32::from_le_bytes(w[i * 4..i * 4 + 4].try_into().unwrap()) == expected[i])
    });
    assert!(found, "expected the contiguous ldxr/add/stxr/cbnz loop");
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
    // Both sections are read-only, so they join the rodata stream.
    assert_eq!(foreign.rodata_align, 16, "sh_addralign must be recorded");
    // Intra-object: the 4-byte `.rodata` ahead forces 12 bytes of pad.
    assert_eq!(&foreign.rodata[16..32], &mask);

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
    // The constant is read-only, so the image places it in `.rodata`;
    // `sym_value` is its offset in the merged data-byte space, whose
    // read-only prefix starts at that section.
    let (ro_addr, ro_off) = elf64_shdr_addr_off(&exe, ".rodata").expect(".rodata section header");
    assert_eq!(
        (ro_addr + sym_value) % 16,
        0,
        "the 16-byte constant's runtime address must be 16-aligned"
    );
    let at = (ro_off + sym_value) as usize;
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
    let funcs =
        crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false).expect("ssa");
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
        crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false).expect("ssa");
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
    let funcs = produce_ssa_funcs(&program, Target::host(), false).expect("produce_ssa_funcs");
    funcs
        .into_iter()
        .find(|f| f.name == name)
        .unwrap_or_else(|| panic!("function `{name}` not found"))
}

/// A by-value aggregate argument is the address of the caller's copy
/// while the callee's parameter list is in scope; with no list the walker
/// falls back to loading the object's single eightbyte into a machine
/// word. A redeclaration through the function's own type keeps the list
/// (C99 6.2.7p4), so the site stays in address form.
#[test]
fn redeclared_callee_keeps_aggregate_argument_in_address_form() {
    use crate::c5::ir::Inst;
    let f = ssa_func_named(
        "typedef struct { unsigned val; } wrap;\n\
         unsigned take(wrap w);\n\
         unsigned take(wrap w) { return w.val; }\n\
         extern typeof(take) take;\n\
         unsigned caller(wrap w) { return take(w); }\n",
        "caller",
    );
    let args = f
        .insts
        .iter()
        .find_map(|i| match i {
            Inst::Call { args, .. } => Some(args.clone()),
            _ => None,
        })
        .expect("a call in `caller`");
    assert_eq!(args.len(), 1, "one argument: {args:?}");
    let operand = &f.insts[args[0] as usize];
    assert!(
        matches!(operand, Inst::LocalAddr(_)),
        "aggregate argument must be the copy's address, got {operand:?}"
    );
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
fn local_label_jump_inline_asm_x64() {
    use crate::{NativeOptions, Target, emit_native_with_options};
    // Numeric local labels resolve within the block: `Nb` branches backward to
    // the nearest prior `N:`, `Nf` forward to the next. badc emits the rel32
    // form and patches the displacement against the label offset. The windows
    // below are self-relative, so they hold regardless of the block's position.
    let program = super::compile_str_bare(
        "void f(void){ __asm__ volatile(\n\
           \"1:\\n\\tnop\\n\\tjmp 1b\\n\\t\
            jmp 2f\\n\\tnop\\n\\t2:\\n\\t\
            3:\\n\\tjne 3b\"); }\n\
         int main(void){ return 0; }",
    );
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("emit LinuxX64");
    let has = |w: &[u8]| bytes.windows(w.len()).any(|c| c == w);
    // `1: nop; jmp 1b` -> nop (90) then E9 with rel32 = -6.
    assert!(
        has(&[0x90, 0xe9, 0xfa, 0xff, 0xff, 0xff]),
        "backward jmp 1b"
    );
    // `jmp 2f; nop; 2:` -> E9 with rel32 = +1 (skips the nop 90).
    assert!(has(&[0xe9, 0x01, 0x00, 0x00, 0x00, 0x90]), "forward jmp 2f");
    // `3: jne 3b` -> 0F 85 with rel32 = -6.
    assert!(
        has(&[0x0f, 0x85, 0xfa, 0xff, 0xff, 0xff]),
        "backward jne 3b"
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

/// A `register T v asm("reg")` local used as an `r` operand must be
/// carried in exactly the named register: the template instruction's
/// encoding fixes both source registers, so the bytes prove the pin.
#[test]
fn register_asm_variable_pins_the_named_register() {
    use crate::{Compiler, NativeOptions, Target};
    // x86-64: `movq %r9, %rax` (4C 89 C8) then `addq %r12, %rax`
    // (4C 01 E0) -- %0 is rax (first pool register), %1 = r9, %2 = r12.
    let src_x64 = "int main(void) { \
        register long a asm(\"r9\") = 30; \
        register long b asm(\"r12\") = 10; \
        long out; \
        __asm__(\"movq %1, %0; addq %2, %0\" : \"=r\"(out) : \"r\"(a), \"r\"(b)); \
        return (int)out - 40; }";
    let program = Compiler::with_target(src_x64.to_string(), Target::LinuxX64)
        .compile()
        .expect("register-asm x64 source compiles");
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxX64,
        NativeOptions::default(),
    )
    .expect("emit_native(LinuxX64)");
    let has = |pat: &[u8]| bytes.windows(pat.len()).any(|w| w == pat);
    assert!(has(&[0x4C, 0x89, 0xC8]), "expected `movq %r9, %rax`");
    assert!(has(&[0x4C, 0x01, 0xE0]), "expected `addq %r12, %rax`");

    // AArch64: `add x0, x9, x12` = 0x8B0C0120 little-endian.
    let src_a64 = "int main(void) { \
        register long a asm(\"x9\") = 30; \
        register long b asm(\"x12\") = 10; \
        long out; \
        __asm__(\"add %0, %1, %2\" : \"=r\"(out) : \"r\"(a), \"r\"(b)); \
        return (int)out - 40; }";
    let program = Compiler::with_target(src_a64.to_string(), Target::LinuxAarch64)
        .compile()
        .expect("register-asm a64 source compiles");
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxAarch64,
        NativeOptions::default(),
    )
    .expect("emit_native(LinuxAarch64)");
    let word = 0x8B0C0120u32.to_le_bytes();
    assert!(
        bytes.windows(4).any(|w| w == word),
        "expected `add x0, x9, x12`"
    );
}

/// The registers the emitters would otherwise reserve as asm-staging
/// scratch are still bindable where honoring the pin is guaranteed:
/// x86-64 r11 (r10 stays the scratch) and AArch64 r0 via GCC's `rN`
/// spelling. A `+r` output round-trips through the named register, and
/// the staging never uses it as scratch, so the template bytes fix it.
#[test]
fn register_asm_variable_binds_scratch_neighbor_and_r_spelling() {
    use crate::{Compiler, NativeOptions, Target};
    // x86-64: `addq %rax, %r11` (49 01 C3) -- %0 = r11 (the bound `+r`
    // output), %1 = rax (first pool register for the input).
    let src_x64 = "int main(void) { \
        register long v asm(\"r11\") = 30; \
        long b = 12; \
        __asm__(\"addq %1, %0\" : \"+r\"(v) : \"r\"(b) : \"cc\"); \
        return (int)v - 42; }";
    let program = Compiler::with_target(src_x64.to_string(), Target::LinuxX64)
        .compile()
        .expect("register-asm r11 source compiles");
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxX64,
        NativeOptions::default(),
    )
    .expect("emit_native(LinuxX64)");
    assert!(
        bytes.windows(3).any(|w| w == [0x49, 0x01, 0xC3]),
        "expected `addq %rax, %r11`"
    );

    // AArch64: `add x2, x0, x1` = 0x8B010002 -- %1 = r0 (=x0), %2 = r1
    // (=x1), both via the `rN` spelling; %0 = out (next free pool reg).
    let src_a64 = "int main(void) { \
        register long a asm(\"r0\") = 30; \
        register long b asm(\"r1\") = 10; \
        long out; \
        __asm__(\"add %0, %1, %2\" : \"=r\"(out) : \"r\"(a), \"r\"(b)); \
        return (int)out - 40; }";
    let program = Compiler::with_target(src_a64.to_string(), Target::LinuxAarch64)
        .compile()
        .expect("register-asm r0 source compiles");
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxAarch64,
        NativeOptions::default(),
    )
    .expect("emit_native(LinuxAarch64)");
    assert!(
        bytes.windows(4).any(|w| w == 0x8B010002u32.to_le_bytes()),
        "expected `add x2, x0, x1`"
    );
}

/// `asm goto` lowers on both targets at -O0 and -O: the label branch
/// leaves through a restore trampoline patched to the label's block.
#[test]
fn asm_goto_emits_for_both_targets() {
    use crate::{Compiler, NativeOptions, Target};
    let cases = [
        (
            Target::LinuxX64,
            "int f(int v) { \
                 __asm__ goto(\"testl %0, %0; jnz %l[out]\" : : \"r\"(v) : : out); \
                 return 1; out: return 2; } \
             int main(void) { return f(1) + f(0); }",
        ),
        (
            Target::LinuxAarch64,
            "int f(int v) { \
                 __asm__ goto(\"cbnz %w0, %l[out]\" : : \"r\"(v) : : out); \
                 return 1; out: return 2; } \
             int main(void) { return f(1) + f(0); }",
        ),
    ];
    for (target, src) in cases {
        for optimize in [false, true] {
            let program = Compiler::with_target(src.to_string(), target)
                .compile()
                .unwrap_or_else(|e| panic!("asm goto compiles for {target:?}: {e}"));
            let opts = if optimize {
                NativeOptions::new().with_optimize()
            } else {
                NativeOptions::default()
            };
            crate::c5::object::emit_native_single_tu_for_test(&program, target, opts)
                .unwrap_or_else(|e| panic!("emit_native({target:?}, -O={optimize}): {e}"));
        }
    }
}

/// Every symbol name in an ELF64 `.symtab`, paired with `st_shndx`
/// (`0` == SHN_UNDEF). Complements [`elf_func_symbols`], which reports
/// only defined `STT_FUNC` entries.
fn elf_symbol_shndx(b: &[u8]) -> alloc::vec::Vec<(alloc::string::String, u16)> {
    let u16a = |o: usize| u16::from_le_bytes(b[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
    let u64a = |o: usize| u64::from_le_bytes(b[o..o + 8].try_into().unwrap());
    let shoff = u64a(0x28) as usize;
    let shentsize = u16a(0x3a) as usize;
    let shnum = u16a(0x3c) as usize;
    let Some(sh) = (0..shnum)
        .map(|i| shoff + i * shentsize)
        .find(|&sh| u32a(sh + 4) == 2)
    else {
        return alloc::vec::Vec::new();
    };
    let sym_off = u64a(sh + 0x18) as usize;
    let sym_len = u64a(sh + 0x20) as usize;
    let strsh = shoff + (u32a(sh + 0x28) as usize) * shentsize;
    let str_off = u64a(strsh + 0x18) as usize;
    let mut out = alloc::vec::Vec::new();
    let mut p = sym_off;
    while p + 24 <= sym_off + sym_len {
        let s = str_off + u32a(p) as usize;
        let e = b[s..].iter().position(|&c| c == 0).map_or(s, |n| s + n);
        out.push((
            alloc::string::String::from_utf8_lossy(&b[s..e]).into_owned(),
            u16a(p + 6),
        ));
        p += 24;
    }
    out
}

/// C99 6.2.2: a static object nothing reachable references is
/// unobservable. `.data` is packed before lowering, from the pre-inline
/// call graph, so an object whose last reference the inliner removes --
/// here the table passed to a stub that ignores its parameter -- is only
/// dead once the -O pipeline has run. Without the post-inline re-run it
/// stays in the image and its relocations pull in the functions it names,
/// leaving those functions' undefined references in the object.
///
/// Locks: the orphaned table and its `.rela.data` entries are gone, so is
/// every function reachable only through them and the extern they alone
/// called, while the sibling global that is still referenced survives at
/// an offset its `.text` relocation follows.
#[test]
fn post_inline_orphaned_static_and_its_relocations_drop() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    const SRC: &str = "\
        struct dev; \
        struct dev_ops { long long (*read)(struct dev *); long long (*write)(struct dev *); }; \
        extern long long dev_private(struct dev *d); \
        static long long ops_read(struct dev *d) { return dev_private(d); } \
        static long long ops_write(struct dev *d) { return dev_private(d) + 1; } \
        static const struct dev_ops dead_ops = { ops_read, ops_write }; \
        const char kept_tag[8] = \"kept\"; \
        static struct dev *alloc_dev(void *priv, const struct dev_ops *ops) \
            { (void)ops; return (struct dev *)priv; } \
        struct dev *make_dev(void *p) { return alloc_dev(p, &dead_ops); } \
        const char *tag(void) { return kept_tag; }";

    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::with_options(
            SRC.to_string(),
            target,
            crate::CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .unwrap_or_else(|e| panic!("compile ({target:?}): {e}"));
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::new().with_optimize()
        };
        let obj = emit_native_with_options(&program, target, opts)
            .unwrap_or_else(|e| panic!("emit object ({target:?}): {e}"));

        let syms = elf_symbol_shndx(&obj);
        let named = |n: &str| syms.iter().any(|(s, _)| s == n);
        for gone in ["dev_private", "ops_read", "ops_write"] {
            assert!(
                !named(gone),
                "{target:?}: `{gone}` survives after the orphaned ops table is dropped \
                 (symbols: {syms:?})"
            );
        }
        assert!(
            named("kept_tag") && named("make_dev") && named("tag"),
            "{target:?}: a still-referenced definition was dropped (symbols: {syms:?})"
        );
        let rela_data = elf64_section(&obj, ".rela.data").unwrap_or(&[]);
        assert!(
            rela_data.is_empty(),
            "{target:?}: the dropped table's function-pointer relocations survive \
             ({} bytes of .rela.data)",
            rela_data.len()
        );

        // The survivor kept its bytes, and the code that names it points
        // at where the repack put it. `kept_tag` is `const` and holds no
        // relocated slot, so it is carved into `.rodata` and `.data`
        // keeps only the 8-byte NULL guard.
        let data = elf64_section(&obj, ".data").expect("no .data section");
        let rodata = elf64_section(&obj, ".rodata").expect("no .rodata section");
        let (value, size) =
            elf_data_symbol_value_size(&obj, "kept_tag").expect("kept_tag symtab entry");
        assert_eq!(
            size, 8,
            "{target:?}: `kept_tag` lost its st_size across the repack"
        );
        assert_eq!(
            data.len(),
            8,
            "{target:?}: .data should hold only the NULL guard"
        );
        assert_eq!(
            value, 0,
            "{target:?}: `kept_tag` moved to an unexpected offset"
        );
        assert_eq!(
            &rodata[value as usize..value as usize + 5],
            b"kept\0",
            "{target:?}: `kept_tag` bytes did not move with its symbol"
        );
        let text_target = elf_first_data_reloc_target(&obj, target);
        assert_eq!(
            text_target,
            Some(value),
            "{target:?}: the `.text` reference to `kept_tag` does not follow the repack"
        );
    }
}

/// Section header table of an ELF64 object as
/// `(name, sh_type, sh_size, sh_link, sh_info)`.
fn elf64_section_table(obj: &[u8]) -> alloc::vec::Vec<(alloc::string::String, u32, u64, u32, u32)> {
    let u16a = |o: usize| u16::from_le_bytes(obj[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(obj[o..o + 4].try_into().unwrap());
    let u64a = |o: usize| u64::from_le_bytes(obj[o..o + 8].try_into().unwrap());
    let shoff = u64a(0x28) as usize;
    let shentsize = u16a(0x3a) as usize;
    let shnum = u16a(0x3c) as usize;
    let hdr = |i: usize| shoff + i * shentsize;
    let str_off = u64a(hdr(u16a(0x3e) as usize) + 0x18) as usize;
    (0..shnum)
        .map(|i| {
            let h = hdr(i);
            let s = str_off + u32a(h) as usize;
            let e = obj[s..].iter().position(|&c| c == 0).map_or(s, |n| s + n);
            (
                alloc::string::String::from_utf8_lossy(&obj[s..e]).into_owned(),
                u32a(h + 4),
                u64a(h + 0x20),
                u32a(h + 0x28),
                u32a(h + 0x2c),
            )
        })
        .collect()
}

/// A relocation section with no entries describes nothing, and a
/// consumer that reaches one through its target's `sh_info` link has no
/// entry to read. Emitting one is also outside what any other producer
/// does, so the writer drops it and compacts the section numbering; the
/// checks below cover both halves.
#[test]
fn relocatable_objects_carry_no_empty_relocation_sections() {
    use crate::{CompileOptions, Compiler, NativeOptions, OutputKind, Target};
    const SHT_RELA: u32 = 4;
    const SHT_SYMTAB: u32 = 2;
    const SHN_LORESERVE: u16 = 0xff00;
    // Each source leaves a different subset of the fixed relocation
    // tables empty: no relocations at all, code-only, data-only, and
    // both.
    const CASES: &[&str] = &[
        "int f(int x){return x+1;}",
        "int g=3; int f(void){return g;}",
        "extern int e; int *p=&e;",
        "extern int e; int *p=&e; int f(void){return *p;}",
        "_Thread_local int t; int f(void){return t;}",
        "__attribute__((section(\"placed\"))) int s=7; int f(void){return s;}",
    ];
    for src in CASES {
        for debug in [false, true] {
            for target in [Target::LinuxX64, Target::LinuxAarch64] {
                let program = Compiler::with_options(
                    src.to_string(),
                    target,
                    CompileOptions::default().with_no_entry_point(true),
                )
                .compile()
                .unwrap_or_else(|e| panic!("compile ({src}, {target:?}): {e}"));
                let opts = NativeOptions {
                    output_kind: OutputKind::Relocatable,
                    ..NativeOptions::new().with_debug_info(debug)
                };
                let obj = crate::emit_native_with_options(&program, target, opts)
                    .unwrap_or_else(|e| panic!("emit ({src}, {target:?}): {e}"));
                let secs = elf64_section_table(&obj);
                let ctx = alloc::format!("{src} [{target:?}, debug={debug}]");
                for (name, ty, size, link, info) in &secs {
                    if *ty != SHT_RELA {
                        continue;
                    }
                    assert!(*size != 0, "{ctx}: `{name}` has no entries");
                    assert_eq!(
                        secs.get(*link as usize).map(|s| s.1),
                        Some(SHT_SYMTAB),
                        "{ctx}: `{name}` sh_link does not name the symbol table"
                    );
                    let base = name.strip_prefix(".rela").expect("relocation section name");
                    assert_eq!(
                        secs.get(*info as usize).map(|s| s.0.as_str()),
                        Some(base),
                        "{ctx}: `{name}` sh_info does not name `{base}`"
                    );
                }
                // Every section index recorded in the symbol table still
                // names a section after the numbering was compacted.
                for (sym, shndx) in elf_symbol_shndx(&obj) {
                    assert!(
                        shndx >= SHN_LORESERVE || (shndx as usize) < secs.len(),
                        "{ctx}: symbol `{sym}` names section {shndx} of {}",
                        secs.len()
                    );
                }
                // A defined data object lands in a content section, not
                // in a relocation or string table.
                for (sym, shndx) in elf_symbol_shndx(&obj) {
                    if sym != "g" && sym != "p" && sym != "s" {
                        continue;
                    }
                    let sec = &secs[shndx as usize];
                    assert_ne!(sec.1, SHT_RELA, "{ctx}: `{sym}` resolves to `{}`", sec.0);
                }
            }
        }
    }
}

/// The post-inline recompaction lowers prebuilt bodies, so the import
/// table has to come from those bodies rather than from the ASTs. An
/// import whose only source reference is a static helper the inliner
/// consumed survives only in the caller's inlined copy: resolving from
/// the (now function-pruned) ASTs left the binding unresolved and the
/// `Inst::ImmExtCode` emit with no import to relocate against.
#[test]
fn post_inline_recompaction_keeps_inlined_import() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    const SRC: &str = "\
        #include <string.h> \n\
        struct dev; struct dev_ops { long long (*read)(struct dev *); }; \
        extern long long dev_private(struct dev *d); \
        static long long ops_read(struct dev *d) { return dev_private(d); } \
        static const struct dev_ops dead_ops = { ops_read }; \
        static unsigned long apply(const char *s, unsigned long (*fn)(const char *)) \
            { return fn(s); } \
        static unsigned long measure(const char *s) { return apply(s, strlen); } \
        static struct dev *alloc_dev(void *p, const struct dev_ops *o) \
            { (void)o; return (struct dev *)p; } \
        unsigned long span(const char *s, void *p) \
            { return measure(s) + (alloc_dev(p, &dead_ops) != 0); }";

    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::with_options(
            SRC.to_string(),
            target,
            crate::CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .unwrap_or_else(|e| panic!("compile ({target:?}): {e}"));
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::new().with_optimize()
        };
        let obj = emit_native_with_options(&program, target, opts)
            .unwrap_or_else(|e| panic!("emit object ({target:?}): {e}"));
        let syms = elf_symbol_shndx(&obj);
        assert!(
            syms.iter().any(|(n, _)| n == "strlen"),
            "{target:?}: the inlined import lost its symbol (symbols: {syms:?})"
        );
        assert!(
            !syms
                .iter()
                .any(|(n, _)| n == "ops_read" || n == "dev_private"),
            "{target:?}: the orphaned table's function survived (symbols: {syms:?})"
        );
    }
}

/// A data-liveness probe stops as soon as it has a report, so its
/// `Build` carries no image -- not even the `output_kind` the writer
/// routes on. Stopping only pays off when the caller holds a compaction
/// plan to replay the report against. A unit with no function to walk
/// gets no plan, yet the -O pipeline still reports its unreferenced
/// objects, so the probe must run to completion instead of handing the
/// writer an empty `Build`: PE routed that to the executable writer and
/// failed on the entry stub, ELF wrote a linked image where an object
/// was asked for.
///
/// Locks: `-O` relocatable output for a data-only unit is an `ET_REL`
/// object that still defines its externally visible data.
#[test]
fn data_only_unit_at_o_emits_relocatable_object() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    const SRC: &str = "static const char dead_tag[8] = \"dead\"; \
                       const char kept_tag[8] = \"kept\";";

    for target in [
        Target::MacOSAarch64,
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        let program = Compiler::with_options(
            SRC.to_string(),
            target,
            crate::CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .unwrap_or_else(|e| panic!("compile ({target:?}): {e}"));
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::new().with_optimize()
        };
        let obj = emit_native_with_options(&program, target, opts)
            .unwrap_or_else(|e| panic!("emit object ({target:?}): {e}"));
        assert_eq!(
            u16::from_le_bytes(obj[16..18].try_into().unwrap()),
            1,
            "{target:?}: relocatable output is not ET_REL"
        );
        let syms = elf_symbol_shndx(&obj);
        assert!(
            syms.iter().any(|(n, _)| n == "kept_tag"),
            "{target:?}: the unit's data symbol is missing (symbols: {syms:?})"
        );
    }
}

/// `(st_value, st_size)` of the named `STT_OBJECT` symbol.
fn elf_data_symbol_value_size(b: &[u8], name: &str) -> Option<(u64, u64)> {
    let u16a = |o: usize| u16::from_le_bytes(b[o..o + 2].try_into().unwrap());
    let u32a = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
    let u64a = |o: usize| u64::from_le_bytes(b[o..o + 8].try_into().unwrap());
    let shoff = u64a(0x28) as usize;
    let shentsize = u16a(0x3a) as usize;
    let shnum = u16a(0x3c) as usize;
    let sh = (0..shnum)
        .map(|i| shoff + i * shentsize)
        .find(|&sh| u32a(sh + 4) == 2)?;
    let sym_off = u64a(sh + 0x18) as usize;
    let sym_len = u64a(sh + 0x20) as usize;
    let strsh = shoff + (u32a(sh + 0x28) as usize) * shentsize;
    let str_off = u64a(strsh + 0x18) as usize;
    let mut p = sym_off;
    while p + 24 <= sym_off + sym_len {
        let s = str_off + u32a(p) as usize;
        let e = b[s..].iter().position(|&c| c == 0).map_or(s, |n| s + n);
        if b[s..e] == *name.as_bytes() && b[p + 4] & 0xf == 1 {
            return Some((u64a(p + 8), u64a(p + 16)));
        }
        p += 24;
    }
    None
}

/// `.data`-relative byte the object's single `.rela.text` entry names.
/// x86-64 uses a PC-relative `lea` whose addend carries the -4 the
/// instruction end contributes; aarch64's `adrp` / `add` pair addends
/// are the target offset itself.
fn elf_first_data_reloc_target(b: &[u8], target: crate::Target) -> Option<u64> {
    let rela = elf64_section(b, ".rela.text")?;
    if rela.len() < 24 {
        return None;
    }
    let addend = i64::from_le_bytes(rela[16..24].try_into().unwrap());
    Some(match target {
        crate::Target::LinuxX64 => (addend + 4) as u64,
        _ => addend as u64,
    })
}

/// `-mstrict-align` (`NativeOptions::strict_align`): an aggregate copy
/// must not transfer in units wider than the copied type's alignment.
/// Code that runs with the MMU off sees Device-typed memory, where an
/// unaligned access raises an alignment fault rather than being fixed
/// up, so an 8-byte load against a 4-aligned `struct { int x, y; }`
/// faults there.
#[test]
fn strict_align_narrows_the_aggregate_copy_transfer_width() {
    use crate::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};

    const SRC: &str = "struct T { int x, y; };\n\
         void copy_t(struct T *d, struct T *s) { *d = *s; }\n";
    let emit = |target: Target, strict_align: bool| -> Vec<u8> {
        let prog = crate::Compiler::with_options(
            SRC.to_string(),
            target,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .unwrap_or_else(|e| panic!("compile struct copy: {e}"));
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            strict_align,
            ..NativeOptions::default()
        };
        emit_native_with_options(&prog, target, opts)
            .unwrap_or_else(|e| panic!("emit object (strict_align={strict_align}): {e}"))
    };

    // aarch64: count LDR/STR <Xt>, [<Xn>, #imm] (unsigned offset,
    // size=11) off a base that is neither `sp` nor `fp`. The frame is
    // 16-aligned by construction; every other base in this fixture is
    // one of the two 4-aligned struct pointers.
    let a64_wide = |obj: &[u8]| -> usize {
        elf_text(obj)
            .chunks_exact(4)
            .map(|w| u32::from_le_bytes(w.try_into().unwrap()))
            .filter(|insn| {
                let ldst64 = insn & 0xFFC0_0000 == 0xF940_0000 || insn & 0xFFC0_0000 == 0xF900_0000;
                let base = (insn >> 5) & 31;
                ldst64 && base != 29 && base != 31
            })
            .count()
    };
    assert_eq!(
        a64_wide(&emit(Target::LinuxAarch64, false)),
        2,
        "aarch64 default should copy the 8-byte struct with one ldr/str pair"
    );
    assert_eq!(
        a64_wide(&emit(Target::LinuxAarch64, true)),
        0,
        "aarch64 strict_align still copies through 64-bit accesses"
    );

    // x86_64: the copy's 8-byte `mov` carries a REX.W prefix; the
    // narrowed form drops it. Count `REX.W 8B /r` (load) and
    // `REX.W 89 /r` (store) with a register base and no SIB.
    let x64_wide = |obj: &[u8]| -> usize {
        elf_text(obj)
            .windows(3)
            .filter(|w| w[0] & 0xF8 == 0x48 && (w[1] == 0x8B || w[1] == 0x89) && w[2] >> 6 != 3)
            .count()
    };
    let x64_before = x64_wide(&emit(Target::LinuxX64, false));
    assert!(
        x64_before >= 2,
        "x86_64 default should copy the 8-byte struct through 64-bit movs, saw {x64_before}"
    );
    assert!(
        x64_wide(&emit(Target::LinuxX64, true)) < x64_before,
        "x86_64 strict_align did not narrow the copy"
    );
}

/// Minimal ELF64 section walk returning the `.text` bytes.
fn elf_text(bytes: &[u8]) -> alloc::vec::Vec<u8> {
    let u16le = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap()) as usize;
    let u32le = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let u64le = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap()) as usize;
    let shoff = u64le(0x28);
    let shentsize = u16le(0x3A);
    let shnum = u16le(0x3C);
    let shstrndx = u16le(0x3E);
    let stroff = u64le(shoff + shstrndx * shentsize + 0x18);
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        let name_off = stroff + u32le(sh);
        let end = bytes[name_off..].iter().position(|&c| c == 0).unwrap();
        if &bytes[name_off..name_off + end] == b".text" {
            let off = u64le(sh + 0x18);
            let size = u64le(sh + 0x20);
            return bytes[off..off + size].to_vec();
        }
    }
    alloc::vec::Vec::new()
}

/// The staged brace-list template an `Inst::Mcpy` copies into a frame
/// local is 8-aligned, so that copy keeps its 8-byte transfer unit even
/// under `-mstrict-align`. A template landing 1- or 2-aligned made the
/// copy read 8 bytes from an under-aligned address.
#[test]
fn staged_aggregate_template_is_eight_aligned() {
    use crate::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};

    // The odd-sized array ahead of the compound literals leaves the data
    // cursor unaligned unless the staging site realigns it.
    const SRC: &str = "typedef struct { unsigned long v; } w_t;\n\
         void take(w_t);\n\
         char msg[5] = \"abcd\";\n\
         void f(void) { take((w_t){ 0x1122334455667788UL }); }\n\
         void g(void) { take((w_t){ 0x99aabbccddeeff00UL }); }\n";
    let prog = crate::Compiler::with_options(
        SRC.to_string(),
        Target::LinuxAarch64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile staged aggregate");
    let obj = emit_native_with_options(
        &prog,
        Target::LinuxAarch64,
        NativeOptions {
            output_kind: OutputKind::Relocatable,
            strict_align: true,
            ..NativeOptions::default()
        },
    )
    .expect("emit object");
    // One `ldr x` / `str x` pair per staged copy. A narrowed copy shows
    // `ldrb` / `strb` (0x39400000 / 0x39000000) or `ldrh` / `strh`
    // (0x79400000 / 0x79000000); the fixture emits no other subword
    // access, so any is a narrowed template copy.
    let count = |want: u32| -> usize {
        elf_text(&obj)
            .chunks_exact(4)
            .map(|w| u32::from_le_bytes(w.try_into().unwrap()))
            .filter(|insn| insn & 0xFFC0_0000 == want)
            .count()
    };
    let narrow: usize = [0x3940_0000, 0x3900_0000, 0x7940_0000, 0x7900_0000]
        .into_iter()
        .map(count)
        .sum();
    assert_eq!(
        narrow, 0,
        "a staged template copy narrowed, so its data offset was under-aligned"
    );
    assert!(
        count(0xF940_0000) >= 2,
        "expected one 8-byte load per staged aggregate copy"
    );
}

/// A speculative initializer parse may stage a C99 6.5.2.5 compound
/// literal and then be rolled back. The data segment is truncated, so
/// those offsets go back to later objects; the synthetic symbol
/// anchoring the literal has to go with them. The data-object model
/// identifies an object by its start offset -- static DCE intervals,
/// the section carve, and the object symbol table all read it -- so a
/// symbol left behind claims storage another object owns.
#[test]
fn rolled_back_compound_literal_leaves_no_symbol_behind() {
    use crate::{CompileOptions, Compiler, Target};

    // The scalar's initializer folds to an integer, so the address path
    // stages both literals and then restores its checkpoint; the table
    // that follows is allocated over the reclaimed bytes.
    const SRC: &str = "struct s { int a; int b; };\n\
         struct e { const char *n; const struct s *p; };\n\
         static const long delta =\n\
         (long)&((struct s){ 1, 2 }).b - (long)&((struct s){ 1, 2 }).a;\n\
         static const struct e tab[] = {\n\
         { \"a\", &(struct s){ .a = 1 } },\n\
         { \"b\", &(struct s){ .a = 2 } },\n\
         };\n\
         const struct e *get(void) { return tab; }\n\
         long get_delta(void) { return delta; }\n";
    let prog = Compiler::with_options(
        SRC.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");

    // Every defined data object starts at an offset of its own: one
    // symbol per anchor, and no compound literal on top of a named
    // object's storage.
    let defined: alloc::vec::Vec<(i64, &str)> = prog
        .symbols
        .iter()
        .filter(|s| {
            s.class == crate::c5::token::Token::Glo as i64
                && s.defined_here
                && !s.is_alias
                && !s.is_thread_local
                && (0..prog.data.len() as i64).contains(&s.val)
        })
        .map(|s| (s.val, s.name.as_str()))
        .collect();
    let mut anchors: alloc::vec::Vec<i64> = defined.iter().map(|&(v, _)| v).collect();
    anchors.sort_unstable();
    anchors.dedup();
    assert_eq!(
        anchors.len(),
        defined.len(),
        "two data objects anchor one offset: {defined:?}"
    );
    assert!(
        prog.symbols
            .iter()
            .filter(|s| s.is_compound_literal)
            .all(|s| (0..prog.data.len() as i64).contains(&s.val)),
        "a compound-literal symbol anchors reclaimed storage"
    );
    // Every pointer member of the table keeps its relocation: two
    // strings and two literal addresses.
    let tab = prog
        .symbols
        .iter()
        .find(|s| s.name == "tab")
        .expect("tab defined");
    let slots = prog
        .data_relocs
        .iter()
        .filter(|r| {
            let off = r.data_offset as i64;
            off >= tab.val && off < tab.val + 32
        })
        .count();
    assert_eq!(slots, 4, "a table pointer slot lost its relocation");
}

/// C99 6.5.2.5p3: a compound literal is an unnamed object with storage of
/// its own. An empty element list (`(T[]){ }`, accepted as an extension)
/// still needs a slot -- without one its symbol anchors the next
/// definition's start, and the data-object model identifies an object by
/// that start.
#[test]
fn empty_array_compound_literal_owns_its_storage() {
    use crate::{CompileOptions, Compiler, Target};

    const SRC: &str = "struct list { const int *p; unsigned char n; };\n\
         struct desc { const struct list *l; int v; };\n\
         static const struct list empty = { .p = (const int[]){ }, .n = 0 };\n\
         static const struct desc table[] = { { &empty, 1 } };\n\
         const struct desc *get(void) { return table; }\n";
    let prog = Compiler::with_options(
        SRC.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");

    let anchor = |name: &str| -> i64 {
        prog.symbols
            .iter()
            .find(|s| s.name == name)
            .unwrap_or_else(|| panic!("{name} defined"))
            .val
    };
    let literal = prog
        .symbols
        .iter()
        .find(|s| s.is_compound_literal)
        .expect("compound literal symbol")
        .val;
    for named in ["empty", "table"] {
        assert_ne!(
            literal,
            anchor(named),
            "the empty array literal shares `{named}`'s storage"
        );
    }
}

/// Every function's name is looked for in the inline-asm templates, to
/// decide which bodies escape the call graph. The search reads the
/// distinct identifier runs rather than the templates themselves, which
/// is the same test over far fewer bytes.
///
/// Both sizes below are measured in bytes read, against the bytes a
/// rescan of every template per name would read, so the bound holds
/// whatever the machine is doing. The search is still names x haystack
/// bytes -- the runs shrink the haystack by a constant, they do not
/// change the shape -- so the ratio, not its growth, is what is bounded,
/// and it is checked at both sizes to catch a narrowing that decays as
/// the unit grows.
#[test]
fn escape_analysis_reads_identifier_runs_not_whole_templates() {
    use crate::{
        CompileOptions, Compiler, NativeOptions, OutputKind, Target, emit_native_with_options,
    };
    fn unit(n: usize) -> alloc::string::String {
        let mut s = alloc::string::String::new();
        for i in 0..n {
            s.push_str(&alloc::format!(
                "static int h{i}(int a) {{ return a + {i}; }}\n\
                 static int u{i}(int a) {{\n\
                   int r;\n\
                   __asm__ volatile (\"nop /* pad{i} aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa \
                    bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb cccccccccccccccccccccccccccccccc */\"\n\
                     : \"=r\"(r) : : \"memory\");\n\
                   return r + h{i}(a);\n\
                 }}\n"
            ));
        }
        s.push_str("int main(void) { int t = 0;\n");
        for i in 0..n {
            s.push_str(&alloc::format!("t += u{i}(1);\n"));
        }
        s.push_str("return t; }\n");
        s
    }
    let once = |src: &str| -> (usize, usize) {
        let program = Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_optimize(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            optimize: true,
            ..NativeOptions::default()
        };
        crate::c5::codegen::passes::ipa_const_param::ASM_NAME_SEARCH.with(|c| c.set((0, 0)));
        emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        crate::c5::codegen::passes::ipa_const_param::ASM_NAME_SEARCH.with(|c| c.get())
    };
    for n in [150usize, 600] {
        let (read, rescan) = once(&unit(n));
        assert!(read > 0, "n={n}: the asm-name search did not run");
        assert!(
            read * 8 <= rescan,
            "n={n}: the search read {read} bytes against the {rescan} a \
             per-name template rescan would read, under the 8x narrowing \
             the identifier runs give",
        );
    }
}

/// The `__builtin_*` library thunks are in scope from the start, so a
/// unit that uses one and has the library name declared compiles in one
/// front-end pass with nothing recovered.
#[test]
fn builtin_thunks_need_no_auto_include_retry() {
    use crate::{CompileOptions, Compiler, Target};
    let src = "
        int memcmp(const void *a, const void *b, unsigned long n);
        int strcmp(const char *a, const char *b);
        int probe(const void *a, const void *b, unsigned long n)
        {
            return __builtin_memcmp(a, b, n) + __builtin_strcmp(a, b);
        }
        int main(void) { return 0; }
    ";
    let prog = Compiler::with_options(src.into(), Target::LinuxX64, CompileOptions::default())
        .compile()
        .expect("the thunks resolve without a retry");
    assert!(
        prog.auto_includes.is_empty(),
        "no retry should be needed, got {:?}",
        prog.auto_includes
    );
}

/// The absolute-value builtins fold in a constant expression whether or
/// not the unit pulled in other builtin thunks: a thunk macro defined up
/// front would replace the spelling before the constant evaluator saw
/// it, which is why they are not in the always-included header.
#[test]
fn absolute_value_builtins_fold_alongside_the_thunks() {
    use crate::{CompileOptions, Compiler, Target};
    let src = "
        int memcmp(const void *a, const void *b, unsigned long n);
        static const int ai = __builtin_abs(-6);
        enum { EA = __builtin_labs(-3L) };
        static int arr[__builtin_llabs(-4LL)];
        int probe(const void *a, const void *b) { return __builtin_memcmp(a, b, 2); }
        int main(void) { return ai + EA + (int) (sizeof(arr) / sizeof(arr[0])); }
    ";
    Compiler::with_options(src.into(), Target::LinuxX64, CompileOptions::default())
        .compile()
        .expect("the absolute-value builtins still fold");
}

/// A driver `-include` file may hold a translation unit's body rather than
/// declarations, so the `__builtin_*` thunk header has to precede the whole
/// forced-include list, not follow it. gcc and clang make the builtins visible
/// before any input is read.
#[test]
#[cfg(feature = "full")]
fn builtin_thunks_precede_the_forced_include_list() {
    use crate::{CompileOptions, Compiler, Target};
    let dir = std::env::temp_dir().join(format!("badc-force-include-{}", std::process::id()));
    std::fs::create_dir_all(&dir).expect("scratch dir");
    let body = dir.join("forced_body.c");
    std::fs::write(
        &body,
        "unsigned long forced_probe(const unsigned long *p)\n\
         {\n\
         \tunsigned long v;\n\
         \t__builtin_memcpy(&v, p, sizeof(v));\n\
         \treturn v;\n\
         }\n",
    )
    .expect("write forced body");
    let opts = CompileOptions::default()
        .with_include_paths(alloc::vec![dir.display().to_string()])
        .with_force_includes(alloc::vec!["forced_body.c".to_string()]);
    let prog = Compiler::with_options(
        "int main(void) { return 42; }".to_string(),
        Target::LinuxX64,
        opts,
    )
    .compile();
    std::fs::remove_file(&body).ok();
    std::fs::remove_dir(&dir).ok();
    prog.expect("the thunk header is visible to a forced-include body");
}

#[test]
#[cfg(feature = "full")]
fn auto_include_retry_emits_what_the_force_include_would() {
    // C99 7.1.4p2: a standard library function may be used without a
    // visible declaration. The driver recovers by re-running the compile
    // with the declaring header force-included, so the retry's object
    // must equal the one a caller gets by naming that header up front.
    use crate::{
        CompileOptions, Compiler, NativeOptions, OutputKind, Target, emit_native_with_options,
    };
    let src = "
        int probe(const void *a, const void *b, unsigned long n)
        {
            return __builtin_memcmp(a, b, n);
        }
        int main(void)
        {
            char x[2];
            x[0] = 1;
            x[1] = 2;
            return probe(x, x, 2);
        }
    ";
    let target = Target::LinuxX64;
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };

    let retried = Compiler::with_options(src.to_string(), target, CompileOptions::default())
        .compile()
        .expect("auto-include retry recovers the undeclared builtin");
    // `__builtin_memcmp` needs no retry -- its thunk is in scope from
    // the start -- so what the retry recovers is the library name the
    // thunk forwards to.
    assert!(
        retried.auto_includes.iter().any(|n| n == "memcmp"),
        "expected the retry to record the recovered name, got {:?}",
        retried.auto_includes
    );

    let headers: Vec<String> = retried
        .auto_includes
        .iter()
        .map(|n| {
            crate::c5::headers::header_declaring(n)
                .expect("the recovered name names a header")
                .to_string()
        })
        .collect();
    let forced = CompileOptions::default().with_force_includes(headers);
    let direct = Compiler::with_options(src.to_string(), target, forced)
        .compile()
        .expect("the same unit compiles with the header named up front");
    assert!(direct.auto_includes.is_empty(), "no retry was needed");

    let a = emit_native_with_options(&retried, target, opts).expect("emit retried object");
    let b = emit_native_with_options(&direct, target, opts).expect("emit direct object");
    assert_eq!(
        a, b,
        "the retry's object differs from the force-included one"
    );
}

/// A dense case set lowers to a table dispatch whose table must stay
/// out of the code section: unwind-metadata generators decode `.text`
/// as a pure instruction stream and reject embedded data. The
/// relocatable object places the tables in an anonymous read-only
/// section under the `.rodata` name prefix, one `R_*_64` relocation
/// per 8-byte entry against the `.text` section symbol with the
/// target's offset as the addend -- the shape jump-table discovery in
/// unwind tooling keys on -- and relocates the dispatch's base
/// materialization against that section's STT_SECTION symbol.
#[test]
fn switch_table_lands_in_rodata_section_of_object() {
    use crate::{
        CompileOptions, Compiler, NativeOptions, OutputKind, Target, emit_native_with_options,
    };

    const SRC: &str = "int pick(int x) {\n\
         \tswitch (x) {\n\
         \tcase 0: return 10;\n\
         \tcase 1: return 11;\n\
         \tcase 2: return 12;\n\
         \tcase 3: return 13;\n\
         \tcase 4: return 14;\n\
         \tcase 5: return 15;\n\
         \tcase 6: return 16;\n\
         \tcase 7: return 17;\n\
         \tcase 8: return 18;\n\
         \tcase 9: return 19;\n\
         \tdefault: return -1;\n\
         \t}\n\
         }\n";
    let prog = Compiler::with_options(
        SRC.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .unwrap_or_else(|e| panic!("compile dense switch: {e}"));
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..NativeOptions::default()
    };
    let bytes = emit_native_with_options(&prog, Target::LinuxX64, opts)
        .unwrap_or_else(|e| panic!("emit object: {e}"));

    let rd_u16 = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap());
    let rd_u32 = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let rd_u64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let e_shoff = rd_u64(0x28) as usize;
    let e_shnum = rd_u16(0x3C) as usize;
    let e_shstrndx = rd_u16(0x3E) as usize;
    let shdr = |i: usize| e_shoff + i * 64;
    let sh_name = |i: usize| rd_u32(shdr(i));
    let sh_type = |i: usize| rd_u32(shdr(i) + 4);
    let sh_flags = |i: usize| rd_u64(shdr(i) + 8);
    let sh_offset = |i: usize| rd_u64(shdr(i) + 24) as usize;
    let sh_size = |i: usize| rd_u64(shdr(i) + 32) as usize;
    let sh_info = |i: usize| rd_u32(shdr(i) + 44) as usize;
    let shstr_off = sh_offset(e_shstrndx);
    let name_at = |noff: u32| -> String {
        let start = shstr_off + noff as usize;
        let len = bytes[start..].iter().position(|&b| b == 0).unwrap();
        String::from_utf8_lossy(&bytes[start..start + len]).into_owned()
    };
    let find = |name: &str| (0..e_shnum).find(|&i| name_at(sh_name(i)) == name);

    // The table section: allocated, read-only, non-executable, and a
    // whole number of 8-byte entries covering the 10-case span.
    let tbl = find(".rodata.jump_tables").expect("object lacks the table section");
    const SHF_ALLOC: u64 = 0x2;
    assert_eq!(sh_type(tbl), 1, "table section must be SHT_PROGBITS");
    assert_eq!(sh_flags(tbl), SHF_ALLOC, "table must be alloc, read-only");
    let tbl_size = sh_size(tbl);
    assert!(
        tbl_size >= 10 * 8 && tbl_size % 8 == 0,
        "table size {tbl_size} does not cover 10 dense cases in 8-byte entries"
    );

    // Its relocation companion: one R_X86_64_64 per entry, 8-byte
    // stride, every one against the `.text` section symbol with an
    // in-bounds target offset as the addend.
    let rela = find(".rela.rodata.jump_tables").expect("object lacks the table relocations");
    assert_eq!(sh_type(rela), 4, "table relocations must be SHT_RELA");
    assert_eq!(sh_info(rela), tbl, "sh_info must name the table section");
    let (roff, rsize) = (sh_offset(rela), sh_size(rela));
    assert_eq!(rsize % 24, 0);
    assert_eq!(rsize / 24, tbl_size / 8, "one relocation per table entry");
    let symtab = find(".symtab").expect("object lacks .symtab");
    let (sym_off, sym_size) = (sh_offset(symtab), sh_size(symtab));
    let text = find(".text").expect("object lacks .text");
    let text_size = sh_size(text) as u64;
    let sym_shndx = |s: usize| rd_u16(sym_off + s * 24 + 6) as usize;
    let sym_info = |s: usize| bytes[sym_off + s * 24 + 4];
    const R_X86_64_64: u32 = 1;
    for k in 0..rsize / 24 {
        let p = roff + k * 24;
        assert_eq!(rd_u64(p), (k * 8) as u64, "entry {k} offset stride");
        let info = rd_u64(p + 8);
        assert_eq!((info & 0xffff_ffff) as u32, R_X86_64_64);
        let s = (info >> 32) as usize;
        assert_eq!(
            sym_info(s) & 0xf,
            3,
            "entry {k} must target a section symbol"
        );
        assert_eq!(sym_shndx(s), text, "entry {k} must target `.text`");
        let addend = rd_u64(p + 16);
        assert!(
            addend < text_size,
            "entry {k} addend {addend:#x} must name a `.text` byte"
        );
    }

    // The dispatch's base materialization: a pc-relative text
    // relocation against the table section's own STT_SECTION symbol.
    const R_X86_64_PC32: u32 = 2;
    let rela_text = find(".rela.text").expect("object lacks .rela.text");
    let (toff, tsize) = (sh_offset(rela_text), sh_size(rela_text));
    let lea_rows = (0..tsize / 24)
        .filter(|k| {
            let info = rd_u64(toff + k * 24 + 8);
            let s = (info >> 32) as usize;
            (info & 0xffff_ffff) as u32 == R_X86_64_PC32
                && sym_info(s) & 0xf == 3
                && sym_shndx(s) == tbl
        })
        .count();
    assert_eq!(lea_rows, 1, "one base materialization for one table");

    // Anonymity: no named symbol covers the tables, only the section
    // symbol addresses them (consumers that discover compiler jump
    // tables require the region symbol-free).
    for s in 0..sym_size / 24 {
        assert!(
            sym_shndx(s) != tbl || sym_info(s) & 0xf == 3,
            "symbol {s} covers the table section"
        );
    }
}

/// `-fPIC` (`NativeOptions::pic`): the relocatable object's switch
/// tables take the label-difference form -- 4-byte pc-relative slots
/// -- so no absolute relocation reaches the object and a consumer
/// that forbids absolute references (a wholesale-relocated
/// position-independent island) can take it.
#[test]
fn switch_table_pic_object_uses_pcrel_entries() {
    use crate::{
        CompileOptions, Compiler, NativeOptions, OutputKind, Target, emit_native_with_options,
    };

    const SRC: &str = "int pick(int x) {\n\
         \tswitch (x) {\n\
         \tcase 0: return 10;\n\
         \tcase 1: return 11;\n\
         \tcase 2: return 12;\n\
         \tcase 3: return 13;\n\
         \tcase 4: return 14;\n\
         \tcase 5: return 15;\n\
         \tcase 6: return 16;\n\
         \tcase 7: return 17;\n\
         \tcase 8: return 18;\n\
         \tcase 9: return 19;\n\
         \tdefault: return -1;\n\
         \t}\n\
         }\n";
    let prog = Compiler::with_options(
        SRC.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .unwrap_or_else(|e| panic!("compile dense switch: {e}"));
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        pic: true,
        ..NativeOptions::default()
    };
    let bytes = emit_native_with_options(&prog, Target::LinuxX64, opts)
        .unwrap_or_else(|e| panic!("emit pic object: {e}"));

    let rd_u16 = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap());
    let rd_u32 = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let rd_u64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let e_shoff = rd_u64(0x28) as usize;
    let e_shnum = rd_u16(0x3C) as usize;
    let e_shstrndx = rd_u16(0x3E) as usize;
    let shdr = |i: usize| e_shoff + i * 64;
    let sh_name = |i: usize| rd_u32(shdr(i));
    let sh_type = |i: usize| rd_u32(shdr(i) + 4);
    let sh_offset = |i: usize| rd_u64(shdr(i) + 24) as usize;
    let sh_size = |i: usize| rd_u64(shdr(i) + 32) as usize;
    let shstr_off = sh_offset(e_shstrndx);
    let name_at = |noff: u32| -> String {
        let start = shstr_off + noff as usize;
        let len = bytes[start..].iter().position(|&b| b == 0).unwrap();
        String::from_utf8_lossy(&bytes[start..start + len]).into_owned()
    };

    // No absolute relocation anywhere in the object.
    const R_X86_64_64: u32 = 1;
    const R_X86_64_PC32: u32 = 2;
    const SHT_RELA: u32 = 4;
    for i in 0..e_shnum {
        if sh_type(i) != SHT_RELA {
            continue;
        }
        let (off, size) = (sh_offset(i), sh_size(i));
        for k in 0..size / 24 {
            let rtype = (rd_u64(off + k * 24 + 8) & 0xffff_ffff) as u32;
            assert_ne!(
                rtype,
                R_X86_64_64,
                "absolute relocation in {} row {k}",
                name_at(sh_name(i))
            );
        }
    }

    // The table's rows are 4-byte-stride pc-relative entries.
    let rela = (0..e_shnum)
        .find(|&i| name_at(sh_name(i)) == ".rela.rodata.jump_tables")
        .expect("pic object lacks the table relocations");
    let (roff, rsize) = (sh_offset(rela), sh_size(rela));
    assert!(rsize / 24 >= 10, "table must cover the 10 dense cases");
    for k in 0..rsize / 24 {
        let p = roff + k * 24;
        assert_eq!(rd_u64(p), (k * 4) as u64, "entry {k} offset stride");
        let rtype = (rd_u64(p + 8) & 0xffff_ffff) as u32;
        assert_eq!(rtype, R_X86_64_PC32, "entry {k} relocation kind");
    }
}

/// A declaration in a `for` initializer has the whole for statement as
/// its scope (C99 6.8.5.3), so it is a function local like any other:
/// it belongs in the DWARF variable list, and an aggregate among them
/// belongs in `FinishedFunction::multi_cell_slots`, which is what
/// reserves the interior cells against slot coalescing and what the
/// scalar promotion reads as its candidate set. The for-statement
/// parser restored its bindings without recording them, so both lists
/// missed it while the equivalent nested-block declaration was kept.
#[test]
fn for_init_declaration_is_recorded_as_a_function_local() {
    let program = crate::Compiler::with_options(
        "struct pair { long a; long b; }; \
         extern void sink(struct pair *); \
         long f(long n) { \
             long r = 0; \
             for (struct pair p = { 1, 2 }; p.a < n; p.a++) { sink(&p); r += p.b; } \
             { struct pair q = { 3, 4 }; sink(&q); r += q.a; } \
             return r; \
         }"
        .to_string(),
        crate::Target::LinuxX64,
        crate::CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let names: alloc::vec::Vec<&str> = program.variables.iter().map(|v| v.name.as_str()).collect();
    for name in ["p", "q", "r"] {
        assert!(
            names.contains(&name),
            "local `{name}` missing from the variable list ({names:?})"
        );
    }
    let cells = |name: &str| -> i64 {
        let slot = program
            .variables
            .iter()
            .find(|v| v.name == name)
            .expect("declared local")
            .fp_slot;
        program
            .finished_functions
            .iter()
            .flat_map(|f| f.multi_cell_slots.iter())
            .find(|&&(base, _)| base == slot)
            .map(|&(_, cells)| cells)
            .unwrap_or(0)
    };
    assert_eq!(cells("p"), 2, "the for-init aggregate reserves two cells");
    assert_eq!(
        cells("q"),
        2,
        "the block-scope aggregate reserves two cells"
    );
}

/// A state machine over an address-taken automatic aggregate. The loop
/// condition already excludes the state the stepper's first case
/// handles, so that case is unreachable and the build-time-assert call
/// in it must not reach the object. The exclusion is visible only once
/// `passes::sroa` lifts the state member out of memory: in the memory
/// form the stepper's own store to the member runs between the header's
/// read and the next iteration's, so no dominator-scoped fact survives;
/// once the member is a phi, the header's branch narrows the same
/// expression the stepper compares. The second canary is guarded by a
/// runtime load and must survive, or the check proves nothing.
#[test]
fn address_taken_aggregate_state_fold_drops_unreachable_call() {
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
    const SRC: &str = "\
        enum st { st_done = 0, st_run, st_wait }; \
        struct walk { enum st state; unsigned long data; long *back; }; \
        extern void assert_canary(void); \
        extern void runtime_canary(void); \
        extern long gate; \
        static __attribute__((always_inline)) void step(struct walk *w, long n) { \
            switch (w->state) { \
            case st_done: assert_canary(); return; \
            case st_run: w->data += (unsigned long)n; w->state = st_wait; return; \
            case st_wait: w->state = st_done; return; \
            } \
        } \
        long walk_all(long n) { \
            long acc = 0; \
            for (struct walk w = { .state = st_run, .data = 5 }; \
                 w.state != st_done; step(&w, n)) \
                acc += (long)w.data; \
            if (gate == 77) runtime_canary(); \
            return acc; \
        }";

    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::with_options(
            SRC.to_string(),
            target,
            crate::CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .unwrap_or_else(|e| panic!("compile ({target:?}): {e}"));
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::new().with_optimize()
        };
        let obj = emit_native_with_options(&program, target, opts)
            .unwrap_or_else(|e| panic!("emit object ({target:?}): {e}"));
        let syms = elf_symbol_shndx(&obj);
        let named = |n: &str| syms.iter().any(|(s, _)| s == n);
        assert!(
            !named("assert_canary"),
            "{target:?}: the unreachable state's call survives (symbols: {syms:?})"
        );
        assert!(
            named("runtime_canary"),
            "{target:?}: the runtime-guarded call was dropped, so the check is vacuous \
             (symbols: {syms:?})"
        );
    }
}

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

/// A `#pragma binding(data lib::sym, ...)` import on the Windows
/// x86-64 PE target must lower the data reference as a load of the
/// import's IAT slot, not as the address of a `jmp [IAT]` call
/// trampoline. The msvcrt `_sys_errlist` array is the bundled
/// `<stdlib.h>` example (`extern char *_sys_errlist[]` bound to
/// `msvcrt::_sys_errlist` under `_WIN32`); the binding is declared
/// inline here so the TU pulls in only the data import under test
/// and not the header's `environ` / `_environ` block, whose
/// PE-local-slot lowering still collides with the runtime's
/// `environ` definition (a separate, pre-existing gap). Compile a TU
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

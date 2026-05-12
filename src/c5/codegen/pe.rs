//! Windows PE32+ writer for x86_64 executables.
//!
//! Takes a [`Build`] from the x86_64 lowering and packages it as a
//! console-subsystem PE binary that runs on Windows (and under WINE
//! on macOS / Linux). Sibling of `elf.rs` (Linux) and `mach_o.rs`
//! (macOS): the lowering is platform-agnostic, only the writer
//! differs.
//!
//! ## Layout
//!
//! ```text
//!   file                                                   memory (RVA from ImageBase)
//!   ----------------------------------------------------------------------------------
//!   0x000   DOS header (64 bytes)                          0x000   (headers)
//!           DOS stub (zero-padded, 64 bytes)
//!   0x080   PE signature "PE\0\0" (4 bytes)
//!   0x084   COFF header (20 bytes)
//!   0x098   Optional64 header + 16 data directories (240)
//!   0x188   Section table: 3 * 40 bytes
//!   0x200   .text: entry stub + build.text                 0x1000  (R-X)
//!           .idata: import descriptors + IAT + names       0x?000  (RW-)
//!           .data: build.data                              0x?000  (RW-)
//! ```
//!
//! ## Imports
//!
//! Two DLLs: `msvcrt.dll` (libc shapes) and `kernel32.dll`
//! (`VirtualProtect` for `mprotect`, `LoadLibraryA` / `GetProcAddress`
//! / `FreeLibrary` for `dlopen` / `dlsym` / `dlclose`, plus the
//! entry stub's `ExitProcess`). The codegen's `call qword
//! ptr [rip+disp32]` shape is unchanged from the Linux backend --
//! the writer just patches `disp32` to point at an IAT slot rather
//! than a `.got` slot.
//!
//! ## Entry stub
//!
//! Windows hands control to the entry point with `rsp` 16-aligned
//! and the OS-pushed return address on top, so the stub looks like
//! a normal function prologue. We fetch argc / argv via msvcrt's
//! `__p___argc` / `__p___argv` (each returns a pointer to its
//! respective global), call the program's `main` with those values
//! in `rcx` / `rdx`, then route the result through `ExitProcess`
//! so the CRT atexit chain runs (without it printf to a pipe loses
//! its tail line because msvcrt block-buffers non-tty stdout).
//!
//! ## Op-to-DLL binding
//!
//! Most c4 ops map straight onto a msvcrt or kernel32 export. Two
//! corners worth flagging:
//!
//! * `Op::Senv` (POSIX `setenv(name, value, overwrite)`) binds to
//!   msvcrt's `_putenv_s(name, value)`. The 3rd arg lands in `r8`
//!   per Win64 calling convention; `_putenv_s` ignores it. The
//!   semantics differ when `overwrite == 0`, but most c5 callers
//!   pass `overwrite = 1` and don't notice.
//! * `Op::Dler` (POSIX `dlerror()`) binds to kernel32's
//!   `GetLastError`. Both return zero when there's no pending
//!   error; a c5 program that *prints* `dlerror()` would see
//!   garbage on Windows, but the common `if (dlerror()) { ... }`
//!   shape works.
//! * `Op::Mpro` (POSIX `mprotect(addr, len, prot)`) is not
//!   currently supported on Windows; the binding goes to
//!   `VirtualProtect`, but the calling convention mismatch (Windows
//!   takes a 4th `OldProt` out-pointer the c5 program doesn't
//!   provide) makes it unsafe to invoke. Programs that don't call
//!   `mprotect` are unaffected.

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::aarch64;
use super::dwarf;
use super::x86_64;
use super::{Build, Machine};
use crate::c5::program::Program;

// ----------------------------------------------------------------
// PE constants. Names mirror `winnt.h` so cross-checking is easy.
// ----------------------------------------------------------------

const IMAGE_BASE: u64 = 0x1_4000_0000;
const SECTION_ALIGNMENT: u32 = 0x1000;
const FILE_ALIGNMENT: u32 = 0x200;

const IMAGE_FILE_MACHINE_AMD64: u16 = 0x8664;
const IMAGE_FILE_MACHINE_ARM64: u16 = 0xAA64;
const IMAGE_FILE_EXECUTABLE_IMAGE: u16 = 0x0002;
/// `IMAGE_FILE_DLL` -- the COFF characteristic that tells
/// Windows the image is a dynamic-link library, not an
/// executable. Set when `OutputKind::SharedLibrary` is in
/// effect; combined with the `Export Directory` data
/// directory entry, this is enough for `LoadLibraryA` /
/// `GetProcAddress` to resolve `#pragma export(<name>)`
/// symbols.
const IMAGE_FILE_DLL: u16 = 0x2000;
const IMAGE_FILE_LARGE_ADDRESS_AWARE: u16 = 0x0020;

const PE32_PLUS_MAGIC: u16 = 0x20B;
const IMAGE_SUBSYSTEM_WINDOWS_CUI: u16 = 3;
const IMAGE_SUBSYSTEM_WINDOWS_GUI: u16 = 2;
const IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA: u16 = 0x0020;
const IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE: u16 = 0x0040;
const IMAGE_DLLCHARACTERISTICS_NX_COMPAT: u16 = 0x0100;
const IMAGE_DLLCHARACTERISTICS_NO_SEH: u16 = 0x0400;

/// COFF storage classes (`IMAGE_SYMBOL.StorageClass`).
/// uses `IMAGE_SYM_CLASS_EXTERNAL` for the per-trampoline names
/// so debuggers (`gdb`, `lldb`, `windbg`) resolve `b malloc`
/// against the local trampoline rather than chasing it through
/// msvcrt's dispatcher tables. `IMAGE_SYM_CLASS_STATIC` would
/// be the file-local equivalent but tools tend to filter it out
/// of name lookups.
const IMAGE_SYM_CLASS_EXTERNAL: u8 = 2;
/// Function-typed symbol -- `IMAGE_SYMBOL.Type` high byte set to
/// `DT_FUNCTION` (0x20). Tells consumers the value is a code
/// address.
const IMAGE_SYM_TYPE_FUNCTION: u16 = 0x20;
/// Each `IMAGE_SYMBOL` is exactly 18 bytes (8-byte name + 4-byte
/// value + 2-byte section number + 2-byte type + 1-byte storage
/// class + 1-byte aux count). Hard-coded as a const so callers
/// can pre-size the symbol-table buffer.
const IMAGE_SYMBOL_SIZE: u32 = 18;

const IMAGE_SCN_CNT_CODE: u32 = 0x0000_0020;
const IMAGE_SCN_CNT_INITIALIZED_DATA: u32 = 0x0000_0040;
/// `IMAGE_SCN_MEM_DISCARDABLE` -- the loader may unmap the
/// section after consuming its contents. Used for `.reloc`,
/// which the loader walks once at load time and never reads
/// again.
const IMAGE_SCN_MEM_DISCARDABLE: u32 = 0x0200_0000;
const IMAGE_SCN_MEM_EXECUTE: u32 = 0x2000_0000;
const IMAGE_SCN_MEM_READ: u32 = 0x4000_0000;
const IMAGE_SCN_MEM_WRITE: u32 = 0x8000_0000;

/// `IMAGE_REL_BASED_DIR64` -- 64-bit absolute address relocation
/// type, encoded in the high 4 bits of each `.reloc` u16 entry.
/// The loader subtracts `ImageBase`, adds the actual load
/// address, and writes the result back. Used for the three
/// absolute VAs in `IMAGE_TLS_DIRECTORY64`
/// (`StartAddressOfRawData`, `EndAddressOfRawData`,
/// `AddressOfIndex`) so DYNAMIC_BASE / HIGH_ENTROPY_VA can stay
/// on for TLS-using images.
const IMAGE_REL_BASED_DIR64: u16 = 10 << 12;
/// `IMAGE_REL_BASED_ABSOLUTE` (type = 0). A no-op entry whose
/// only purpose is to pad each `.reloc` block to a 4-byte
/// boundary, since `SizeOfBlock` must be a multiple of 4.
const IMAGE_REL_BASED_ABSOLUTE: u16 = 0;

const NUM_DATA_DIRS: u32 = 16;

/// Section layout: every 64-bit Windows PE always carries
/// `.text`, `.pdata`, and `.idata`. The optional `.data` only
/// appears when the c5 program has initialized data -- string
/// literals, globals, or `_Thread_local` storage -- because
/// real Windows kernels reject images that list a zero-sized
/// section. The optional `.reloc` only appears when the
/// program declares any `_Thread_local` global; that's the
/// only path that puts absolute VAs into the image (the three
/// pointer fields of `IMAGE_TLS_DIRECTORY64`), which the
/// ASLR-aware loader needs to fix up after sliding.
///
/// `.pdata` is the Exception Directory, mandatory under the
/// 64-bit Windows ABI: the loader looks up `RUNTIME_FUNCTION`
/// entries there to handle stack unwinding, and wine refuses
/// to load AArch64 PEs that omit it. x86_64 doesn't fail to
/// load without one, but the spec requires it and stricter
/// hosts can reject a missing entry, so we emit it on both
/// arches.
///
/// `.reloc` is omitted for TLS-free images because every
/// cross-section reference the codegen emits is RIP-relative
/// (x86_64) or PC-relative (aarch64 ADRP+ADD), so the
/// DYNAMIC_BASE-flagged image can be slid to any address
/// without touching any absolute pointer in the file. The
/// only absolute pointers we ever emit live inside the TLS
/// directory, which is why `.reloc` follows TLS presence.
fn num_sections(
    data_section_present: bool,
    reloc_section_present: bool,
    edata_section_present: bool,
    dwarf_section_present: bool,
) -> usize {
    let mut n = 3; // .text, .pdata, .idata
    if data_section_present {
        n += 1;
    }
    if reloc_section_present {
        n += 1;
    }
    if edata_section_present {
        n += 1;
    }
    if dwarf_section_present {
        // Five `__debug_*` sections (info / abbrev /
        // line / str / frame). PE caps section names at 8 chars,
        // so the leading dot is dropped (mingw-w64 convention) --
        // dwarfdump / lldb / gdb all recognise the truncated
        // names since they walk by content, not literal name.
        n += 5;
    }
    n
}

const DOS_HEADER_AND_STUB: usize = 128; // 64 byte DOS header + 64 byte stub
const PE_SIG_SIZE: usize = 4;
const COFF_HEADER_SIZE: usize = 20;
const OPTIONAL64_HEADER_SIZE: usize = 240;
const SECTION_HEADER_SIZE: usize = 40;

/// Raw on-disk size of the PE headers (DOS + PE sig + COFF +
/// Optional + section table), rounded up to FILE_ALIGNMENT.
/// 3 sections fit in 0x200; 4 sections need 0x400.
fn headers_raw_size(
    data_section_present: bool,
    reloc_section_present: bool,
    edata_section_present: bool,
    dwarf_section_present: bool,
) -> usize {
    let unaligned = DOS_HEADER_AND_STUB
        + PE_SIG_SIZE
        + COFF_HEADER_SIZE
        + OPTIONAL64_HEADER_SIZE
        + SECTION_HEADER_SIZE
            * num_sections(
                data_section_present,
                reloc_section_present,
                edata_section_present,
                dwarf_section_present,
            );
    (unaligned + FILE_ALIGNMENT as usize - 1) & !(FILE_ALIGNMENT as usize - 1)
}

const IMAGE_IMPORT_DESCRIPTOR_SIZE: usize = 20;
const IAT_ENTRY_SIZE: usize = 8;

/// Export Directory (data directory entry 0) -- the
/// `IMAGE_EXPORT_DIRECTORY` describing each `#pragma export`
/// function. `LoadLibraryA` / `GetProcAddress` walks this to
/// resolve external names.
const DATA_DIRECTORY_EXPORT: usize = 0;
const DATA_DIRECTORY_IMPORT: usize = 1;
const DATA_DIRECTORY_EXCEPTION: usize = 3;
const DATA_DIRECTORY_BASERELOC: usize = 5;
/// TLS Directory (entry 9) -- the loader walks this to allocate
/// per-thread TLS at thread creation, copy `.tdata`, zero-fill
/// `.tbss`, and write the chosen index back into the
/// `_tls_index` slot. The directory itself is a 40-byte
/// `IMAGE_TLS_DIRECTORY64` we put inside `.data`.
const DATA_DIRECTORY_TLS: usize = 9;
const DATA_DIRECTORY_IAT: usize = 12;

/// Size of `IMAGE_TLS_DIRECTORY64` in bytes (PE32+ form).
/// Layout: 4 u64 VAs + 2 u32 fields = 32 + 8 = 40 bytes.
const IMAGE_TLS_DIRECTORY64_SIZE: u32 = 40;

/// AArch64 RUNTIME_FUNCTION packed-unwind format limit: the
/// FunctionLength field is 11 bits (units = 4-byte instructions),
/// so a single packed entry covers at most 2048 instructions
/// = 8192 bytes. Larger `.text` sections need multiple entries.
const ARM64_PACKED_FUNCTION_MAX_BYTES: u32 = 2048 * 4;

// ----------------------------------------------------------------
// Stub-only imports the entry-stub always needs, on top of the
// resolved program imports.
//
// Console-subsystem stub:
//   * msvcrt!__getmainargs -- canonical way to populate argc/argv
//     on a Windows host: it fills out the int / char** out-pointers
//     we hand it. WINE's msvcrt doesn't export the alternative
//     `__p___argc` / `__p___argv` thunks, so this is the portable
//     shape.
//   * msvcrt!exit -- routes the program's return value through the
//     CRT atexit chain (and flushes stdout/stderr). Using raw
//     `kernel32!ExitProcess` loses a program's tail output when
//     stdout is a pipe because msvcrt block-buffers stdout.
//
// GUI-subsystem stub (`#pragma subsystem(windows)`) supplies a
// Win32-shaped argv to the entry point instead of argc/argv:
//   * kernel32!GetModuleHandleA -- to supply `HINSTANCE hInstance`.
//   * kernel32!GetCommandLineA  -- to supply `LPSTR lpCmdLine`.
//   * msvcrt!exit               -- same as console; routes the
//     entry's return value.
//
// `hPrevInstance` is always `NULL` (16-bit legacy) and `nShowCmd`
// is `SW_SHOWDEFAULT` (10), which is the value the Win32 loader
// would pass to a real CRT-supplied `WinMainCRTStartup`.
//
// These ride alongside whatever the program asked for via
// `#pragma binding(...)`. They have no c5-side name, so they live
// outside `ResolvedImports` and the lowering never references them
// directly -- only the entry stub does.
// ----------------------------------------------------------------

const STUB_IMPORT_GETMAINARGS: (&str, &str) = ("__getmainargs", "msvcrt.dll");
const STUB_IMPORT_EXIT: (&str, &str) = ("exit", "msvcrt.dll");
const STUB_IMPORT_GETMODULEHANDLEA: (&str, &str) = ("GetModuleHandleA", "kernel32.dll");
const STUB_IMPORT_GETCOMMANDLINEA: (&str, &str) = ("GetCommandLineA", "kernel32.dll");

/// `SW_SHOWDEFAULT` -- the `nShowCmd` value the Win32 loader would
/// pass to `WinMainCRTStartup`. Hardcoded into the GUI entry stub
/// so windows actually appear when `ShowWindow(hwnd, nShowCmd)` is
/// called.
const SW_SHOWDEFAULT: u32 = 10;

// ----------------------------------------------------------------
// Top-level writer.
// ----------------------------------------------------------------

pub(super) fn write(
    program: &Program,
    build: &Build,
    machine: Machine,
    target: super::Target,
) -> Result<Vec<u8>, C5Error> {
    let is_dll = build.output_kind == super::OutputKind::SharedLibrary;
    // PE optional-header Subsystem -- determined here once so the
    // entry-stub builder and the optional-header writer agree on
    // the shape (`Subsystem::Windows` -> WinMain-shaped stub).
    let subsystem = match program.subsystem {
        Some(crate::c5::preprocessor::Subsystem::Windows) => IMAGE_SUBSYSTEM_WINDOWS_GUI,
        _ => IMAGE_SUBSYSTEM_WINDOWS_CUI,
    };

    // 1) Build the entry stub before laying out the imports. The
    //    stub declares the imports *it* needs (msvcrt!__getmainargs
    //    + msvcrt!exit for console; kernel32!GetModuleHandleA +
    //    kernel32!GetCommandLineA + msvcrt!exit for GUI; nothing
    //    for the DllMain case), which we splice onto the user's
    //    `#pragma binding(...)` imports below.
    //
    //    POSIX-only intrinsics (mprotect, ...) aren't auto-
    //    translated to the Windows equivalent; cross-platform
    //    sources gate those on `#if __BADC_TARGET__` and call the
    //    target-native API (`VirtualProtect`, etc.) directly.
    //
    //    For `--shared` output with a user-defined `DllMain` we
    //    skip the stub entirely: `AddressOfEntryPoint` will point
    //    at the user's body inside `build.text`, and emitting the
    //    boilerplate `mov eax, 1; ret` ahead of it would just
    //    shift every fixup by 6-8 bytes for code the loader never
    //    branches to.
    let user_dllmain = is_dll && build.dllmain_pc.is_some();
    let stub = if user_dllmain {
        EntryStub::empty()
    } else {
        build_entry_stub(machine, is_dll, subsystem)
    };

    // 2) Combined imports list. Index N becomes IAT slot N. The
    //    program's resolved imports occupy `0..n_program_imports`;
    //    the entry stub's additional imports follow, at offsets
    //    `stub_imports_base + stub_import_idx`.
    //
    //    `(symbol_name, dll_name)` -- the symbol name is whatever
    //    the dylib actually exports (`printf`, `_open`, etc.); the
    //    dll_name is the resolved dylib path (`msvcrt.dll`,
    //    `kernel32.dll`).
    let n_program_imports = build.imports.imports.len();
    let mut imports: Vec<(String, String)> =
        Vec::with_capacity(n_program_imports + stub.stub_imports.len());
    for imp in &build.imports.imports {
        let dll = build.imports.dylibs[imp.dylib_index].path.clone();
        imports.push((imp.real_symbol.clone(), dll));
    }
    let stub_imports_base = imports.len();
    for &(sym, dll) in &stub.stub_imports {
        imports.push((sym.to_string(), dll.to_string()));
    }

    // 3) Group imports by DLL while preserving each one's IAT index.
    //    `dlls` holds (dll_name, [import_index, ...]); the IAT is
    //    laid out DLL-by-DLL so we keep the per-DLL slot offsets to
    //    recover the global IAT slot of each import.
    let dlls = group_imports_by_dll(&imports);

    // 4) Compute layout. Combined .text is `entry stub |
    //    build.text`; the program's `Op::Mpro` calls go through
    //    the regular IAT lookup just like every other libc op.
    let stub_len = stub.bytes.len() as u32;
    let text_prologue_len = stub_len;

    // The `.data` section is present when the c5 program has
    // initialized data OR any `_Thread_local` globals (the TLS
    // directory + `_tls_index` slot live at the tail of `.data`).
    // The `.reloc` section is present when the program declares
    // any `_Thread_local` global -- those are the only absolute
    // VAs the writer emits (inside `IMAGE_TLS_DIRECTORY64`), and
    // the ASLR-aware loader uses `.reloc` to fix them up after
    // sliding the image.
    let data_section_present = !build.data.is_empty() || !build.tls_data.is_empty();
    // `.reloc` is needed when the image carries any absolute
    // pointer the loader has to fix up after sliding -- today
    // that's the three TLS-directory VAs (when TLS is
    // present) plus one entry per `int *p = &x;`-style data
    // reloc.
    let reloc_section_present = !build.tls_data.is_empty()
        || !build.data_relocs.is_empty()
        || !build.code_relocs.is_empty();
    let edata_section_present = is_dll && !build.exports.is_empty();
    // Emit DWARF debug sections in PE images so lldb /
    // gdb can resolve user-function names + types in PE
    // backtraces. Suppressed when the user passed `--no-debug` /
    // `-g0` -- the section headers + payload + COFF
    // string table are all skipped, `pointer_to_symbol_table`
    // returns to 0, and `SizeOfImage` shrinks accordingly.
    let dwarf_section_present = build.debug_info;
    let headers_size = headers_raw_size(
        data_section_present,
        reloc_section_present,
        edata_section_present,
        dwarf_section_present,
    ) as u32;

    let text_rva: u32 = SECTION_ALIGNMENT;
    let text_file_off: u32 = headers_size;
    let text_size: u32 = text_prologue_len + build.text.len() as u32;
    let text_raw_size: u32 = round_up(text_size, FILE_ALIGNMENT);

    // 64-bit Windows requires a `.pdata` Exception Directory
    // between `.text` and `.idata` on both x86_64 and AArch64. The
    // builder dispatches on machine: AArch64 uses packed-unwind
    // RUNTIME_FUNCTIONs; x86_64 uses begin/end/UNWIND_INFO triples
    // with a co-located UNWIND_INFO blob in the same section.
    //
    // The Exception Directory entry in the data directories must
    // span exactly the RUNTIME_FUNCTION array -- the loader divides
    // `Size / sizeof(RUNTIME_FUNCTION)` to count entries, so any
    // trailing bytes (e.g. an x86_64 UNWIND_INFO blob) live inside
    // the section but outside the directory range. The builder
    // returns both numbers so we wire the section header and the
    // data directory entry up separately.
    let pdata_rva: u32 = round_up(text_rva + text_size, SECTION_ALIGNMENT);
    let pdata_file_off: u32 = text_file_off + text_raw_size;
    let pdata = build_pdata(machine, text_rva, text_size, pdata_rva);
    let pdata_bytes = pdata.bytes;
    let pdata_size: u32 = pdata_bytes.len() as u32;
    let pdata_directory_size: u32 = pdata.directory_size;
    let pdata_raw_size: u32 = round_up(pdata_size, FILE_ALIGNMENT);

    let idata_rva: u32 = round_up(pdata_rva + pdata_size, SECTION_ALIGNMENT);
    let idata_file_off: u32 = pdata_file_off + pdata_raw_size;

    let idata_layout = plan_idata(&dlls, &imports, idata_rva);
    let idata_bytes = idata_layout.bytes;
    let idata_size: u32 = idata_bytes.len() as u32;
    let idata_raw_size: u32 = round_up(idata_size, FILE_ALIGNMENT);

    // The `.data` section only appears when the c5 program has at
    // least one byte of initialized data (string literals or
    // globals) OR any `_Thread_local` storage. An empty section
    // is a real-Windows-kernel reject reason: CreateProcess
    // returns ERROR_BAD_EXE_FORMAT for any image that lists a
    // zero-sized section. wine is more tolerant, which is how
    // this slipped past the local test lanes for so long.
    //
    // TLS layout (when `build.tls_data` is non-empty) appends
    // three blobs after `build.data` inside the same `.data`
    // section: (1) a 4-byte `_tls_index` slot the loader fills
    // in at module-init time, (2) the 40-byte
    // IMAGE_TLS_DIRECTORY64, and (3) the initialised TLS image
    // (the first `build.tls_init_size` bytes of
    // `build.tls_data`). The zero-fill TLS bytes
    // (`build.tls_data.len() - build.tls_init_size`) live only
    // in `IMAGE_TLS_DIRECTORY64.SizeOfZeroFill`; the loader
    // zero-fills them per-thread.
    let tls_layout = compute_tls_layout(build);
    let data_size: u32 = build.data.len() as u32 + tls_layout.tls_blob_size;
    let data_rva: u32 = round_up(idata_rva + idata_size, SECTION_ALIGNMENT);
    let data_file_off: u32 = idata_file_off + idata_raw_size;
    let data_raw_size: u32 = if data_section_present {
        round_up(data_size, FILE_ALIGNMENT)
    } else {
        0
    };

    // `.reloc` carries one IMAGE_BASE_RELOCATION block with
    // three IMAGE_REL_BASED_DIR64 entries -- one per absolute
    // VA in the TLS directory. The block is fixed-size (16
    // bytes: 8-byte header + 4 entries * 2 bytes, last entry a
    // zero-pad ABSOLUTE so the block ends on a 4-byte boundary
    // as required by `SizeOfBlock`). The bytes are computed
    // here so we can size the file image; the actual on-disk
    // emission happens after `.data`.
    let reloc_rva: u32 = if reloc_section_present {
        round_up(data_rva + data_size, SECTION_ALIGNMENT)
    } else {
        0
    };
    let reloc_file_off: u32 = if reloc_section_present {
        data_file_off + data_raw_size
    } else {
        0
    };
    let reloc_bytes: Vec<u8> = if reloc_section_present {
        build_reloc_section(
            data_rva,
            &tls_layout,
            !build.tls_data.is_empty(),
            &build.data_relocs,
            &build.code_relocs,
        )
    } else {
        Vec::new()
    };
    let reloc_size: u32 = reloc_bytes.len() as u32;
    let reloc_raw_size: u32 = if reloc_section_present {
        round_up(reloc_size, FILE_ALIGNMENT)
    } else {
        0
    };

    // `.edata` holds the IMAGE_EXPORT_DIRECTORY plus the
    // arrays it references -- function RVAs, name RVAs,
    // ordinals, plus the DLL name and each export name.
    // Only present in shared-library output with at least one
    // `#pragma export` symbol. (`edata_section_present` was
    // already computed above so the headers-size pass knew
    // about it.)
    let edata_rva: u32 = if edata_section_present {
        round_up(
            if reloc_section_present {
                reloc_rva + reloc_size
            } else if data_section_present {
                data_rva + data_size
            } else {
                idata_rva + idata_size
            },
            SECTION_ALIGNMENT,
        )
    } else {
        0
    };
    let edata_file_off: u32 = if edata_section_present {
        if reloc_section_present {
            reloc_file_off + reloc_raw_size
        } else if data_section_present {
            data_file_off + data_raw_size
        } else {
            idata_file_off + idata_raw_size
        }
    } else {
        0
    };
    let edata_bytes: Vec<u8> = if edata_section_present {
        build_export_directory(
            edata_rva,
            text_rva + text_prologue_len,
            &build.exports,
            &build.bytecode_to_native,
        )?
    } else {
        Vec::new()
    };
    let edata_size: u32 = edata_bytes.len() as u32;
    let edata_raw_size: u32 = if edata_section_present {
        round_up(edata_size, FILE_ALIGNMENT)
    } else {
        0
    };

    // Compute the end of the last loaded / pre-DWARF section
    // -- where DWARF sections start. The chain falls through
    // from `.edata` -> `.reloc` -> `.data` -> `.idata` to the
    // first one present.
    let pre_dwarf_end_file_off: u32 = if edata_section_present {
        edata_file_off + edata_raw_size
    } else if reloc_section_present {
        reloc_file_off + reloc_raw_size
    } else if data_section_present {
        data_file_off + data_raw_size
    } else {
        idata_file_off + idata_raw_size
    };
    let pre_dwarf_end_rva: u32 = if edata_section_present {
        edata_rva + edata_size
    } else if reloc_section_present {
        reloc_rva + reloc_size
    } else if data_section_present {
        data_rva + data_size
    } else {
        idata_rva + idata_size
    };

    // Lay out the five DWARF debug sections after the
    // existing ones. The mingw-w64 PE convention drops the leading
    // dot to fit each name in PE's 8-char limit; lldb / gdb / `llvm-
    // dwarfdump` all walk by section content rather than literal
    // name and pick them up.
    //
    // Each section is `IMAGE_SCN_MEM_DISCARDABLE`, so the loader
    // skips them at runtime even though they occupy RVA range --
    // they only matter to the debugger walking the file image.
    let dwarf_sections = if dwarf_section_present {
        // PE has its own entry stub, but the symptom
        // (gdb's "Cannot find bounds of current function" after
        // stepping past `return 0;` in main) was only verified
        // on linux/aarch64. Pass `None` here -- the ELF writer
        // wires up the stub range; PE can opt in when the
        // symptom surfaces under windbg.
        dwarf::emit(
            program,
            build,
            target,
            IMAGE_BASE + (text_rva + text_prologue_len) as u64,
            &program.source_path,
            None,
        )
    } else {
        dwarf::DwarfSections {
            debug_info: Vec::new(),
            debug_abbrev: Vec::new(),
            debug_line: Vec::new(),
            debug_str: Vec::new(),
            debug_frame: Vec::new(),
        }
    };
    /// One entry of the PE DWARF layout: section name (`/<offset>`
    /// indirection into the COFF string table for the full
    /// `.debug_*` name), the section's RVA + file offset, and the
    /// raw byte payload.
    struct DwarfPeSlot {
        name: [u8; 8],
        rva: u32,
        file_off: u32,
        bytes: Vec<u8>,
    }
    // PE/COFF caps section names at 8 bytes, so full DWARF
    // section names (".debug_info" = 11 chars, ".debug_abbrev"
    // = 13, etc.) don't fit literally. The standard PE
    // workaround is `/N` indirection: the section's name field
    // holds an ASCII slash followed by the byte offset (in
    // decimal) of the real name in the COFF string table. The
    // COFF string table begins at `CoffHeader.pointer_to_symbol_table`
    // (with `number_of_symbols = 0` so consumers don't try to
    // parse symbols ahead of the strings) and is laid out as a
    // 4-byte size header followed by NUL-terminated names.
    //
    // mingw-w64's `x86_64-w64-mingw32-gcc -g` produces the same
    // shape, which is why `llvm-dwarfdump` and `lldb` accept it.
    const DWARF_LONG_NAMES: [&str; 5] = [
        ".debug_info",
        ".debug_abbrev",
        ".debug_line",
        ".debug_str",
        ".debug_frame",
    ];
    let mut coff_strtab: Vec<u8> = Vec::new();
    let mut dwarf_section_names: Vec<[u8; 8]> = Vec::with_capacity(5);
    // Build a per-trampoline COFF symbol table so a
    // debugger's `b malloc` resolves to the local PLT trampoline
    // rather than getting lost in msvcrt's macro expansions. The
    // symbol table sits at `pointer_to_symbol_table` (= start of
    // the post-DWARF area); the COFF string table follows
    // immediately after, exactly the layout consumers expect
    // (`strtab_off = pointer_to_symbol_table + n_symbols * 18`).
    //
    // We emit when there are trampolines, even on `--no-debug`
    // builds, so the COFF strtab may now be present without DWARF.
    // The 4-byte size prefix is reserved up-front and patched at
    // the end.
    let emit_plt_coff_symbols = !build.plt_trampoline_offsets.is_empty();
    let need_coff_strtab = dwarf_section_present || emit_plt_coff_symbols;
    if need_coff_strtab {
        // 4-byte size header, patched at the end.
        coff_strtab.extend_from_slice(&0u32.to_le_bytes());
    }
    if dwarf_section_present {
        for long_name in DWARF_LONG_NAMES {
            let strtab_offset = coff_strtab.len() as u32;
            coff_strtab.extend_from_slice(long_name.as_bytes());
            coff_strtab.push(0);
            // Format `/N` padded to 8 bytes.
            let mut name_field = [0u8; 8];
            let formatted = format!("/{strtab_offset}");
            let n = formatted.len().min(8);
            name_field[..n].copy_from_slice(&formatted.as_bytes()[..n]);
            dwarf_section_names.push(name_field);
        }
    }
    let mut dwarf_pe_sections: Vec<DwarfPeSlot> = Vec::new();
    if dwarf_section_present {
        let blobs: [Vec<u8>; 5] = [
            dwarf_sections.debug_info.clone(),
            dwarf_sections.debug_abbrev.clone(),
            dwarf_sections.debug_line.clone(),
            dwarf_sections.debug_str.clone(),
            dwarf_sections.debug_frame.clone(),
        ];
        let mut next_rva = round_up(pre_dwarf_end_rva, SECTION_ALIGNMENT);
        let mut next_file_off = pre_dwarf_end_file_off;
        for (i, bytes) in blobs.into_iter().enumerate() {
            let raw_size = round_up(bytes.len() as u32, FILE_ALIGNMENT);
            dwarf_pe_sections.push(DwarfPeSlot {
                name: dwarf_section_names[i],
                rva: next_rva,
                file_off: next_file_off,
                bytes,
            });
            next_rva = round_up(next_rva + raw_size, SECTION_ALIGNMENT);
            next_file_off += raw_size;
        }
    }
    let dwarf_end_file_off = dwarf_pe_sections
        .last()
        .map(|s| s.file_off + round_up(s.bytes.len() as u32, FILE_ALIGNMENT))
        .unwrap_or(pre_dwarf_end_file_off);
    let dwarf_end_rva = dwarf_pe_sections
        .last()
        .map(|s| round_up(s.rva + s.bytes.len() as u32, SECTION_ALIGNMENT))
        .unwrap_or(pre_dwarf_end_rva);

    // Build the COFF symbol-table payload now that the
    // long-name strtab offsets are stable. Each trampoline gets
    // one IMAGE_SYMBOL whose Value is the trampoline's RVA and
    // whose SectionNumber is 1 (.text). Names <= 8 bytes inline
    // into the ShortName field; longer ones land in the strtab
    // and the symbol references them by 4-byte zero + offset.
    //
    // Using `IMAGE_SYM_CLASS_EXTERNAL` keeps the names visible to
    // gdb / lldb / windbg name-lookup; STATIC gets filtered out
    // of `b malloc` resolution by some tool versions.
    let mut coff_symbols: Vec<u8> = Vec::new();
    if emit_plt_coff_symbols {
        for (i, imp) in build.imports.imports.iter().enumerate() {
            let trampoline_rva =
                text_rva + text_prologue_len + build.plt_trampoline_offsets[i] as u32;
            let mut name_field = [0u8; 8];
            let name_bytes = imp.local_name.as_bytes();
            if name_bytes.len() <= 8 {
                name_field[..name_bytes.len()].copy_from_slice(name_bytes);
            } else {
                // Long-name form: 4-byte zero + 4-byte strtab offset.
                let strtab_offset = coff_strtab.len() as u32;
                coff_strtab.extend_from_slice(name_bytes);
                coff_strtab.push(0);
                name_field[0..4].copy_from_slice(&0u32.to_le_bytes());
                name_field[4..8].copy_from_slice(&strtab_offset.to_le_bytes());
            }
            // 18 bytes: name(8) + value(4) + sectnum(2) + type(2)
            //         + class(1) + naux(1).
            coff_symbols.extend_from_slice(&name_field);
            coff_symbols.extend_from_slice(&trampoline_rva.to_le_bytes());
            coff_symbols.extend_from_slice(&1u16.to_le_bytes()); // .text = section 1
            coff_symbols.extend_from_slice(&IMAGE_SYM_TYPE_FUNCTION.to_le_bytes());
            coff_symbols.push(IMAGE_SYM_CLASS_EXTERNAL);
            coff_symbols.push(0); // no aux entries
        }
    }
    let n_coff_symbols = (coff_symbols.len() as u32) / IMAGE_SYMBOL_SIZE;

    // Patch the COFF strtab's leading 4-byte size (it's the total
    // strtab length including the size header itself).
    if need_coff_strtab {
        let strtab_size = coff_strtab.len() as u32;
        coff_strtab[..4].copy_from_slice(&strtab_size.to_le_bytes());
    }

    // The COFF symbol table + string table sit at the very end
    // of the file (after the DWARF section payloads). Consumers
    // read `pointer_to_symbol_table` to find symbols, then
    // `pointer_to_symbol_table + n_symbols * 18` to find the
    // string table.
    let coff_symtab_file_off = if need_coff_strtab {
        dwarf_end_file_off
    } else {
        0
    };
    let coff_strtab_file_off = if need_coff_strtab {
        coff_symtab_file_off + coff_symbols.len() as u32
    } else {
        0
    };
    let total_file_size =
        (dwarf_end_file_off + coff_symbols.len() as u32 + coff_strtab.len() as u32) as usize;
    let image_size = if dwarf_section_present {
        dwarf_end_rva
    } else if edata_section_present {
        round_up(edata_rva + edata_size, SECTION_ALIGNMENT)
    } else if reloc_section_present {
        round_up(reloc_rva + reloc_size, SECTION_ALIGNMENT)
    } else if data_section_present {
        round_up(data_rva + data_size, SECTION_ALIGNMENT)
    } else {
        round_up(idata_rva + idata_size, SECTION_ALIGNMENT)
    };

    // 5) Stitch the .text bytes together and patch every fixup
    //    that references something outside the section.
    let mut text_bytes: Vec<u8> = Vec::with_capacity(text_size as usize);
    text_bytes.extend_from_slice(&stub.bytes);
    text_bytes.extend_from_slice(&build.text);

    // Stub-internal fixup: the direct call to main. Only
    // present in executable output; the DLL stub
    // (`mov eax, 1; ret`) has no call-main step.
    if let Some(call_off) = stub.direct_call_main_offset {
        patch_direct_call(
            machine,
            &mut text_bytes,
            call_off,
            text_prologue_len + build.entry_offset as u32,
        )?;
    }

    // Stub-emitted IAT calls. Empty for the DllMain stub (which
    // is a self-contained `mov eax, 1; ret`); two patches for the
    // console stub (`__getmainargs`, `exit`); three for the
    // GUI stub (`GetModuleHandleA`, `GetCommandLineA`, `exit`).
    for patch in &stub.iat_patches {
        let global_idx = stub_imports_base + patch.stub_import_idx;
        patch_iat_lookup(
            machine,
            &mut text_bytes,
            patch.byte_offset,
            text_rva,
            idata_layout.iat_rva_for_import[global_idx],
        )?;
    }

    // Program-side fixups land inside build.text, which is offset
    // by text_prologue_len in the combined .text. All libc ops --
    // including `Op::Mpro` -- now go through the regular IAT slot;
    // the per-target header's `#pragma binding` decides whether
    // mprotect resolves at all (POSIX targets bind it, Windows
    // doesn't, sources gate the call on `__BADC_WINDOWS__`).
    for f in &build.got_fixups {
        let instr_off = (f.adrp_offset as u32) + text_prologue_len;
        let target_rva = idata_layout.iat_rva_for_import[f.import_index];
        patch_iat_lookup(machine, &mut text_bytes, instr_off, text_rva, target_rva)?;
    }
    for f in &build.data_fixups {
        let instr_off = (f.adrp_offset as u32) + text_prologue_len;
        patch_addr_load(
            machine,
            &mut text_bytes,
            instr_off,
            text_rva,
            data_rva + f.data_offset as u32,
        )?;
    }
    for f in &build.func_fixups {
        let instr_off = (f.adrp_offset as u32) + text_prologue_len;
        // Function-pointer literals point at offsets within
        // build.text -- shift by text_prologue_len to land in the
        // combined .text past the entry stub.
        let target_rva = text_rva + text_prologue_len + f.target_native_offset as u32;
        patch_addr_load(machine, &mut text_bytes, instr_off, text_rva, target_rva)?;
    }

    // TLS-index fixups. Every `Op::TlsLea` recorded a code site
    // that needs the address of the `_tls_index` DWORD slot the
    // loader fills in. The slot lives at the tail of `.data` (see
    // `tls_layout` and the data emission below). Each per-arch
    // patcher rewrites the disp/imm fields with the offset to the
    // slot.
    if !build.tls_index_fixups.is_empty() {
        let tls_index_rva = data_rva + tls_layout.tls_index_offset_in_data;
        for f in &build.tls_index_fixups {
            let instr_off = (f.instr_offset as u32) + text_prologue_len;
            patch_tls_index_lookup(machine, &mut text_bytes, instr_off, text_rva, tls_index_rva)?;
        }
    }

    // 6) Assemble the final image.
    let mut out: Vec<u8> = Vec::with_capacity(total_file_size);
    write_dos_header_and_stub(&mut out);
    write_pe_signature(&mut out);
    write_coff_header(
        &mut out,
        OPTIONAL64_HEADER_SIZE,
        machine,
        data_section_present,
        reloc_section_present,
        edata_section_present,
        dwarf_section_present,
        coff_symtab_file_off,
        n_coff_symbols,
        coff_strtab_file_off,
        is_dll,
    );
    let tls_present = !build.tls_data.is_empty();
    let (tls_table_rva, tls_table_size) = if tls_present {
        (
            data_rva + tls_layout.directory_offset_in_data,
            IMAGE_TLS_DIRECTORY64_SIZE,
        )
    } else {
        (0, 0)
    };
    // Entry point: the boilerplate stub sits at the start of
    // `.text` (covers both executables and the default DLL
    // case), so `text_rva` is right unless the user provided
    // their own `DllMain` -- in which case we resolve its
    // bytecode PC to the matching native offset and target the
    // user's body directly. `bytecode_to_native[pc]` is a byte
    // offset within `build.text`; `text_prologue_len` is 0 in
    // the user-DllMain branch above, so adding it is a no-op
    // there but keeps the formula symmetric with the other
    // text-relative computations in this writer.
    let entry_rva = match build.dllmain_pc {
        Some(pc) if is_dll => {
            let off = build.bytecode_to_native.get(pc).copied().ok_or_else(|| {
                C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                    "PE writer: user-defined DllMain at bytecode PC {pc} \
                         has no entry in bytecode_to_native -- the lowering \
                         dropped the function?"
                )))
            })?;
            text_rva + text_prologue_len + off as u32
        }
        _ => text_rva,
    };
    write_optional_header(
        &mut out,
        OptionalHeaderInputs {
            entry_rva,
            base_of_code: text_rva,
            size_of_code: text_size,
            size_of_initialized_data: idata_size + data_size + reloc_size,
            size_of_image: image_size,
            size_of_headers: headers_size,
            import_table_rva: idata_layout.import_directory_rva,
            import_table_size: idata_layout.import_directory_size,
            exception_table_rva: pdata_rva,
            exception_table_size: pdata_directory_size,
            base_reloc_rva: reloc_rva,
            base_reloc_size: reloc_size,
            iat_rva: idata_layout.iat_rva_base,
            iat_size: idata_layout.iat_size,
            tls_table_rva,
            tls_table_size,
            export_table_rva: edata_rva,
            export_table_size: edata_size,
            // Source-driven subsystem flag. Default
            // (`None`) keeps the historical console-subsystem
            // PE; `windows` opts in to GUI mode for `WinMain`-
            // shaped programs (the loader skips the auto-
            // attach-to-console step).
            subsystem: match program.subsystem {
                Some(crate::c5::preprocessor::Subsystem::Windows) => IMAGE_SUBSYSTEM_WINDOWS_GUI,
                _ => IMAGE_SUBSYSTEM_WINDOWS_CUI,
            },
        },
    );
    let mut sections: Vec<SectionHeader> = Vec::with_capacity(num_sections(
        data_section_present,
        reloc_section_present,
        edata_section_present,
        dwarf_section_present,
    ));
    sections.push(SectionHeader {
        name: *b".text\0\0\0",
        virtual_size: text_size,
        virtual_address: text_rva,
        size_of_raw_data: text_raw_size,
        pointer_to_raw_data: text_file_off,
        characteristics: IMAGE_SCN_CNT_CODE | IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_MEM_READ,
    });
    sections.push(SectionHeader {
        name: *b".pdata\0\0",
        virtual_size: pdata_size,
        virtual_address: pdata_rva,
        size_of_raw_data: pdata_raw_size,
        pointer_to_raw_data: pdata_file_off,
        characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA | IMAGE_SCN_MEM_READ,
    });
    sections.push(SectionHeader {
        name: *b".idata\0\0",
        virtual_size: idata_size,
        virtual_address: idata_rva,
        size_of_raw_data: idata_raw_size,
        pointer_to_raw_data: idata_file_off,
        characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA | IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_WRITE,
    });
    if data_section_present {
        sections.push(SectionHeader {
            name: *b".data\0\0\0",
            virtual_size: data_size,
            virtual_address: data_rva,
            size_of_raw_data: data_raw_size,
            pointer_to_raw_data: data_file_off,
            characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA
                | IMAGE_SCN_MEM_READ
                | IMAGE_SCN_MEM_WRITE,
        });
    }
    if reloc_section_present {
        sections.push(SectionHeader {
            name: *b".reloc\0\0",
            virtual_size: reloc_size,
            virtual_address: reloc_rva,
            size_of_raw_data: reloc_raw_size,
            pointer_to_raw_data: reloc_file_off,
            characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA
                | IMAGE_SCN_MEM_READ
                | IMAGE_SCN_MEM_DISCARDABLE,
        });
    }
    if edata_section_present {
        sections.push(SectionHeader {
            name: *b".edata\0\0",
            virtual_size: edata_size,
            virtual_address: edata_rva,
            size_of_raw_data: edata_raw_size,
            pointer_to_raw_data: edata_file_off,
            characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA | IMAGE_SCN_MEM_READ,
        });
    }
    // DWARF debug sections. DISCARDABLE so the loader
    // skips them at runtime; lldb / gdb / llvm-dwarfdump read
    // them from the file image.
    for slot in &dwarf_pe_sections {
        let raw_size = round_up(slot.bytes.len() as u32, FILE_ALIGNMENT);
        sections.push(SectionHeader {
            name: slot.name,
            virtual_size: slot.bytes.len() as u32,
            virtual_address: slot.rva,
            size_of_raw_data: raw_size,
            pointer_to_raw_data: slot.file_off,
            characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA
                | IMAGE_SCN_MEM_READ
                | IMAGE_SCN_MEM_DISCARDABLE,
        });
    }
    write_section_headers(&mut out, &sections);
    pad_to(&mut out, text_file_off as usize);
    out.extend_from_slice(&text_bytes);
    pad_to(&mut out, (text_file_off + text_raw_size) as usize);
    out.extend_from_slice(&pdata_bytes);
    pad_to(&mut out, (pdata_file_off + pdata_raw_size) as usize);
    out.extend_from_slice(&idata_bytes);
    pad_to(&mut out, (idata_file_off + idata_raw_size) as usize);
    if data_section_present {
        // Apply pointer-to-global initializers in `.data`:
        // each `int *p = &x;` slot holds the preferred VA
        // (ImageBase + data_rva + target_offset). The
        // `.reloc` block lists each slot so the loader adds
        // the slide delta after mapping.
        let mut data_with_relocs = build.data.clone();
        for r in &build.data_relocs {
            let preferred_va = IMAGE_BASE + (data_rva + r.target_offset as u32) as u64;
            let off = r.data_offset as usize;
            if off + 8 > data_with_relocs.len() {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!(
                        "PE: data reloc offset {off:#x} past end of .data ({})",
                        data_with_relocs.len()
                    ),
                )));
            }
            data_with_relocs[off..off + 8].copy_from_slice(&preferred_va.to_le_bytes());
        }
        // Function-pointer initializers: pre-fill the slot with the
        // preferred VA (ImageBase + text_prologue_rva + native code
        // offset). text_prologue_rva accounts for the entry stub
        // sitting at the start of the .text section -- build.text
        // begins after it. The `.reloc` block below lists the slot
        // so the Windows loader adds the slide delta when ASLR
        // moves the image.
        for r in &build.code_relocs {
            let bc_pc = r.target_bc_pc as usize;
            // Prefer the per-function arg-shuffling thunk: Win64
            // Jsri allocates 32 bytes of shadow space before the
            // call, so a bare-body landing point would have its
            // `[rbp+16]` reads pointing into the shadow region
            // instead of the c5-stack args. The thunk re-spills
            // the host-ABI register args back onto the c5 stack
            // before falling into the body. Functions with zero
            // params don't have a thunk -- they don't read args
            // anyway -- so fall back to the bare body.
            let native_off = build
                .func_thunk_offsets
                .get(&bc_pc)
                .copied()
                .or_else(|| build.bytecode_to_native.get(bc_pc).copied())
                .unwrap_or(usize::MAX);
            if native_off == usize::MAX {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!("PE: code reloc references missing bytecode pc {bc_pc}"),
                )));
            }
            let preferred_va =
                IMAGE_BASE + (text_rva + text_prologue_len + native_off as u32) as u64;
            let off = r.data_offset as usize;
            if off + 8 > data_with_relocs.len() {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!(
                        "PE: code reloc offset {off:#x} past end of .data ({})",
                        data_with_relocs.len()
                    ),
                )));
            }
            data_with_relocs[off..off + 8].copy_from_slice(&preferred_va.to_le_bytes());
        }
        out.extend_from_slice(&data_with_relocs);
        if !build.tls_data.is_empty() {
            // Pad to where the `_tls_index` slot starts (4-byte
            // alignment).
            pad_to(
                &mut out,
                (data_file_off + tls_layout.tls_index_offset_in_data) as usize,
            );
            // `_tls_index` -- 4-byte slot, zero-initialised; the
            // Windows loader writes the chosen slot index here at
            // module-init time.
            out.extend_from_slice(&[0u8; 4]);
            // Pad to where IMAGE_TLS_DIRECTORY64 starts (8-byte
            // alignment).
            pad_to(
                &mut out,
                (data_file_off + tls_layout.directory_offset_in_data) as usize,
            );
            // IMAGE_TLS_DIRECTORY64. Layout:
            //   StartAddressOfRawData : u64  -- VA of init data start
            //   EndAddressOfRawData   : u64  -- VA of init data end
            //   AddressOfIndex        : u64  -- VA of `_tls_index`
            //   AddressOfCallBacks    : u64  -- VA of callback array (NULL)
            //   SizeOfZeroFill        : u32  -- bytes after End to zero
            //   Characteristics       : u32  -- 0
            // VAs are absolute addresses (ImageBase + RVA); the
            // `.reloc` block we emit fixes them up after any
            // ASLR slide.
            //
            // We deliberately emit the entire `tls_data` as
            // template bytes (init data) rather than splitting
            // it into a `tls_init_size`-byte template plus a
            // `(tls_data.len() - tls_init_size)`-byte
            // SizeOfZeroFill tail. Reason: at least one
            // Windows ARM64 loader path skips processing a TLS
            // directory whose template is empty
            // (Start == End), leaving `_tls_index` at zero. A
            // subsequent `tls_array[0] + offset` then lands
            // inside another module's per-thread storage and
            // reads non-zero data, which trips
            // `thread_local_basic.c`'s "counter != 0" check.
            // The c5 frontend never produces non-zero TLS init
            // bytes today (no `_Thread_local int x = 5;`
            // syntax), so emitting the whole block as zero
            // template bytes is byte-for-byte identical to the
            // SizeOfZeroFill scheme but sidesteps the loader
            // edge case.
            let tls_init_start_va =
                IMAGE_BASE + (data_rva + tls_layout.tls_init_offset_in_data) as u64;
            let tls_init_end_va = tls_init_start_va + build.tls_data.len() as u64;
            let tls_index_va = IMAGE_BASE + (data_rva + tls_layout.tls_index_offset_in_data) as u64;
            let zero_fill: u32 = 0;
            out.extend_from_slice(&tls_init_start_va.to_le_bytes());
            out.extend_from_slice(&tls_init_end_va.to_le_bytes());
            out.extend_from_slice(&tls_index_va.to_le_bytes());
            out.extend_from_slice(&0u64.to_le_bytes()); // AddressOfCallBacks
            out.extend_from_slice(&zero_fill.to_le_bytes());
            out.extend_from_slice(&0u32.to_le_bytes()); // Characteristics
            // TLS template -- copied verbatim into each
            // thread's per-thread region by the loader. The c5
            // frontend zero-initialises every TLS variable
            // today, so this is effectively N bytes of zeros.
            out.extend_from_slice(&build.tls_data);
        }
    }
    if reloc_section_present {
        pad_to(&mut out, reloc_file_off as usize);
        out.extend_from_slice(&reloc_bytes);
    }
    if edata_section_present {
        pad_to(&mut out, edata_file_off as usize);
        out.extend_from_slice(&edata_bytes);
    }
    // DWARF debug sections come last in the file image
    // (before the COFF string table that names them).
    for slot in &dwarf_pe_sections {
        pad_to(&mut out, slot.file_off as usize);
        out.extend_from_slice(&slot.bytes);
    }
    // COFF symbol table immediately before its string
    // table. Both live at the file tail (post-DWARF). Emitted
    // when there are PLT trampolines; absent otherwise.
    if !coff_symbols.is_empty() {
        pad_to(&mut out, coff_symtab_file_off as usize);
        out.extend_from_slice(&coff_symbols);
    }
    if !coff_strtab.is_empty() {
        pad_to(&mut out, coff_strtab_file_off as usize);
        out.extend_from_slice(&coff_strtab);
    }
    pad_to(&mut out, total_file_size);
    debug_assert_eq!(out.len(), total_file_size, "file size mismatch");
    Ok(out)
}

/// Build the `.reloc` section bytes. Emits one
/// `IMAGE_BASE_RELOCATION` block per 4 KiB page that contains
/// any absolute pointer the loader needs to fix up after a
/// slide. Sources of absolute pointers we care about today:
///
/// * The three VAs in `IMAGE_TLS_DIRECTORY64`
///   (`StartAddressOfRawData`, `EndAddressOfRawData`,
///   `AddressOfIndex`) -- emitted only when TLS is present.
/// * Each `int *p = &x;`-style entry in `Build::data_relocs`
///   -- the data slot's bytes hold the preferred VA of the
///   target global, and the loader patches in the slide.
///
/// Block layout:
///
/// ```text
///   u32 VirtualAddress  -- page RVA (the 4 KiB-aligned RVA covering the entries)
///   u32 SizeOfBlock     -- total block bytes (header + entries), multiple of 4
///   u16 entry[N]        -- high 4 bits: type, low 12 bits: offset within page
/// ```
///
/// `SizeOfBlock` must be 4-byte aligned, so blocks with an
/// odd entry count get one trailing `IMAGE_REL_BASED_ABSOLUTE`
/// pad entry.
///
/// (`build_reloc_section` follows.)
///
/// On-disk shape of `IMAGE_EXPORT_DIRECTORY`. Same field
/// order, sizes, and meaning as `winnt.h`'s definition --
/// the writer fills one of these in and `write_struct`s it
/// to the section's head, then appends the
/// AddressOfFunctions / AddressOfNames / AddressOfNameOrdinals
/// arrays plus the trailing string blob.
#[repr(C)]
#[derive(Copy, Clone)]
struct ImageExportDirectory {
    characteristics: u32,
    time_date_stamp: u32,
    major_version: u16,
    minor_version: u16,
    /// RVA of a NUL-terminated DLL name.
    name_rva: u32,
    /// Lowest valid ordinal. Conventionally 1; `dlsym`-style
    /// lookups never reach for ordinals so the value matters
    /// little, but tooling cross-checks it.
    ordinal_base: u32,
    number_of_functions: u32,
    number_of_names: u32,
    /// RVA of an array of `u32` function RVAs.
    address_of_functions: u32,
    /// RVA of an array of `u32` name-string RVAs.
    address_of_names: u32,
    /// RVA of an array of `u16` ordinals (zero-based indices
    /// into the function table).
    address_of_name_ordinals: u32,
}

const IMAGE_EXPORT_DIRECTORY_SIZE: usize = 40;
const _: () = assert!(core::mem::size_of::<ImageExportDirectory>() == IMAGE_EXPORT_DIRECTORY_SIZE);

/// Build the `.edata` section bytes for a DLL with exports.
/// Layout: `IMAGE_EXPORT_DIRECTORY` followed by
/// AddressOfFunctions / AddressOfNames /
/// AddressOfNameOrdinals arrays, then the DLL-name and
/// per-export-name strings (NUL-terminated).
///
/// All RVAs in the directory are image-relative; the
/// `text_prologue_rva` is `text_rva + stub_len`, the byte
/// where `build.text` starts. Each export's runtime RVA is
/// `text_prologue_rva + bytecode_to_native[bytecode_pc]`.
fn build_export_directory(
    edata_rva: u32,
    text_prologue_rva: u32,
    exports: &[crate::c5::program::ExportedFunction],
    bytecode_to_native: &[usize],
) -> Result<Vec<u8>, C5Error> {
    let n = exports.len() as u32;
    // Layout offsets within the section.
    let header_size = IMAGE_EXPORT_DIRECTORY_SIZE as u32;
    let funcs_off = header_size;
    let names_off = funcs_off + 4 * n;
    let ordinals_off = names_off + 4 * n;
    let strings_off = ordinals_off + 2 * n;

    // The DLL-name string heads the string blob; per-export
    // names follow, each NUL-terminated. We compute their
    // RVAs as we go so the AddressOfNames entries match.
    let dll_name = "c5-output.dll";
    let strings_rva = edata_rva + strings_off;
    let dll_name_rva = strings_rva;

    let mut out = Vec::with_capacity(strings_off as usize + dll_name.len() + 1);

    // Header (filled out, not patched after).
    write_struct(
        &mut out,
        &ImageExportDirectory {
            characteristics: 0,
            time_date_stamp: 0,
            major_version: 0,
            minor_version: 0,
            name_rva: dll_name_rva,
            ordinal_base: 1,
            number_of_functions: n,
            number_of_names: n,
            address_of_functions: edata_rva + funcs_off,
            address_of_names: edata_rva + names_off,
            address_of_name_ordinals: edata_rva + ordinals_off,
        },
    );

    // AddressOfFunctions -- RVA of each function.
    for exp in exports {
        let native_off = bytecode_to_native
            .get(exp.bytecode_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if native_off == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "PE: exported function `{}` (bc PC {}) doesn't \
                 align with any native instruction",
                    exp.name, exp.bytecode_pc
                ),
            )));
        }
        let rva = text_prologue_rva + native_off as u32;
        out.extend_from_slice(&rva.to_le_bytes());
    }

    // AddressOfNames -- RVA of each export's name string.
    let mut cur = strings_rva + dll_name.len() as u32 + 1;
    for exp in exports {
        out.extend_from_slice(&cur.to_le_bytes());
        cur += exp.name.len() as u32 + 1;
    }

    // AddressOfNameOrdinals -- u16 ordinal per export.
    for i in 0..n {
        out.extend_from_slice(&(i as u16).to_le_bytes());
    }

    // String blob: DLL name first, then each export name.
    out.extend_from_slice(dll_name.as_bytes());
    out.push(0);
    for exp in exports {
        out.extend_from_slice(exp.name.as_bytes());
        out.push(0);
    }

    Ok(out)
}

fn build_reloc_section(
    data_rva: u32,
    tls_layout: &TlsLayout,
    tls_present: bool,
    data_relocs: &[crate::c5::program::DataReloc],
    code_relocs: &[crate::c5::program::CodeReloc],
) -> Vec<u8> {
    // Bucket every relocation target by the 4 KiB page it
    // lives in. Per-page entries within a bucket get one
    // shared `IMAGE_BASE_RELOCATION` header.
    use alloc::collections::BTreeMap;
    let mut by_page: BTreeMap<u32, Vec<u32>> = BTreeMap::new(); // page_rva -> [in-page offsets]
    if tls_present {
        let dir_rva = data_rva + tls_layout.directory_offset_in_data;
        // Sanity: the directory's three pointer fields must
        // share a page. The directory is 40 bytes, far smaller
        // than 4 KiB, so this holds on any reasonable layout.
        debug_assert_eq!(dir_rva & !0xFFF, (dir_rva + 16) & !0xFFF);
        let page = dir_rva & !0xFFF;
        let bucket = by_page.entry(page).or_default();
        bucket.push(dir_rva & 0xFFF); // StartAddressOfRawData
        bucket.push((dir_rva + 8) & 0xFFF); // EndAddressOfRawData
        bucket.push((dir_rva + 16) & 0xFFF); // AddressOfIndex
    }
    for r in data_relocs {
        let target_rva = data_rva + r.data_offset as u32;
        let page = target_rva & !0xFFF;
        by_page.entry(page).or_default().push(target_rva & 0xFFF);
    }
    // Code relocations live in the data segment too -- the slot
    // sits at `data_rva + r.data_offset`, the loader just adds
    // the slide. The kind of pointer (data vs code) doesn't
    // matter to PE's `.reloc`, so we use the same DIR64 entry.
    for r in code_relocs {
        let target_rva = data_rva + r.data_offset as u32;
        let page = target_rva & !0xFFF;
        by_page.entry(page).or_default().push(target_rva & 0xFFF);
    }

    let mut out = Vec::new();
    for (page_rva, mut offsets) in by_page {
        offsets.sort_unstable();
        // Each entry is u16; SizeOfBlock must be 4-byte
        // aligned. Pad with a no-op ABSOLUTE entry when the
        // entry count is odd.
        let needs_pad = !offsets.len().is_multiple_of(2);
        let total_entries = offsets.len() + if needs_pad { 1 } else { 0 };
        let size_of_block = 8 + total_entries as u32 * 2;
        out.extend_from_slice(&page_rva.to_le_bytes());
        out.extend_from_slice(&size_of_block.to_le_bytes());
        for off in offsets {
            let entry = IMAGE_REL_BASED_DIR64 | off as u16;
            out.extend_from_slice(&entry.to_le_bytes());
        }
        if needs_pad {
            out.extend_from_slice(&IMAGE_REL_BASED_ABSOLUTE.to_le_bytes());
        }
    }
    out
}

/// Per-`.data` offsets for the trio of TLS support structures
/// (the `_tls_index` slot, the `IMAGE_TLS_DIRECTORY64`, and the
/// initialised TLS image). Computed once up-front so the layout
/// pass and the writer agree on byte offsets without
/// recomputing.
///
/// All offsets are *within* the `.data` section, after
/// `build.data` (the user-side initialised data). When
/// `build.tls_data` is empty, every field is zero and
/// `tls_blob_size` is zero.
struct TlsLayout {
    /// Total bytes appended to `.data` for TLS support
    /// (excluding the zero-fill, which the loader handles).
    /// Adds to `data_size` to size the `.data` section.
    tls_blob_size: u32,
    /// Byte offset within `.data` of the 4-byte `_tls_index`
    /// slot. The loader writes the chosen slot index here at
    /// module-init time.
    tls_index_offset_in_data: u32,
    /// Byte offset within `.data` of the 40-byte
    /// `IMAGE_TLS_DIRECTORY64`. The Optional Header's
    /// DataDirectory[9] (TLS) points at it.
    directory_offset_in_data: u32,
    /// Byte offset within `.data` of the initialised TLS image
    /// (`.tdata`). `IMAGE_TLS_DIRECTORY64.StartAddressOfRawData`
    /// points at it.
    tls_init_offset_in_data: u32,
}

fn compute_tls_layout(build: &Build) -> TlsLayout {
    if build.tls_data.is_empty() {
        return TlsLayout {
            tls_blob_size: 0,
            tls_index_offset_in_data: 0,
            directory_offset_in_data: 0,
            tls_init_offset_in_data: 0,
        };
    }
    let user_data_end = build.data.len() as u32;
    // 4-byte align the _tls_index slot (DWORD).
    let tls_index_offset = round_up(user_data_end, 4);
    // 8-byte align IMAGE_TLS_DIRECTORY64 (it carries u64s).
    let directory_offset = round_up(tls_index_offset + 4, 8);
    let tls_init_offset = directory_offset + IMAGE_TLS_DIRECTORY64_SIZE;
    // We emit the entire `tls_data` as the template (see the
    // long comment in `write` next to the
    // IMAGE_TLS_DIRECTORY64 emission), so the .data tail
    // contributed by TLS is `tls_data.len()` bytes regardless
    // of `tls_init_size`.
    let total = tls_init_offset + build.tls_data.len() as u32;
    TlsLayout {
        tls_blob_size: total - user_data_end,
        tls_index_offset_in_data: tls_index_offset,
        directory_offset_in_data: directory_offset,
        tls_init_offset_in_data: tls_init_offset,
    }
}

/// Patch the TLS-index lookup at `instr_offset`. The encoding
/// shape varies by architecture:
///
/// * x86_64: a 6-byte `mov ecx, [rip+disp32]`. The disp32 sits
///   at +2 within the instruction; RIP is at +6.
/// * aarch64: an `adrp x17, _; ldr w17, [x17, #_]` pair (the
///   same encoding `patch_aarch64_adrp_ldr` understands, with a
///   `ldr w` instead of `ldr x` -- the in-page byte offset must
///   be 4-aligned for the 32-bit form).
fn patch_tls_index_lookup(
    machine: Machine,
    text: &mut [u8],
    instr_offset_in_text: u32,
    text_section_rva: u32,
    target_rva: u32,
) -> Result<(), C5Error> {
    let instr_rva = text_section_rva + instr_offset_in_text;
    match machine {
        Machine::X86_64 => {
            // `mov ecx, [rip+disp32]` is 6 bytes; disp32 at +2,
            // RIP at +6.
            let after_rva = instr_rva + 6;
            patch_x86_64_disp32(
                text,
                (instr_offset_in_text + 2) as usize,
                after_rva,
                target_rva,
            )
        }
        Machine::Aarch64 => {
            patch_aarch64_adrp_ldr32(text, instr_offset_in_text, instr_rva, target_rva)
        }
    }
}

/// AArch64 `adrp xd, _; ldr wd, [xd, #_]` patcher -- mirrors
/// [`patch_aarch64_adrp_ldr`] but for the 32-bit (`ldr w`) load
/// form used by the TLS-index lookup. The in-page offset must be
/// 4-aligned (the 32-bit form's imm12 is scaled by 4).
fn patch_aarch64_adrp_ldr32(
    text: &mut [u8],
    adrp_offset_in_text: u32,
    adrp_rva: u32,
    target_rva: u32,
) -> Result<(), C5Error> {
    let adrp_page = (adrp_rva as u64) & !0xFFF;
    let target_page = (target_rva as u64) & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("PE: aarch64 TLS-index adrp page diff {page_diff} not 4 KiB aligned"),
        )));
    }
    let imm21 = (page_diff >> 12) as i32;
    let in_page = target_rva & 0xFFF;
    if !in_page.is_multiple_of(4) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("PE: aarch64 TLS-index ldr offset {in_page:#x} not 4-aligned"),
        )));
    }
    let off = adrp_offset_in_text as usize;
    let adrp_word = u32::from_le_bytes([text[off], text[off + 1], text[off + 2], text[off + 3]]);
    let ldr_word = u32::from_le_bytes([text[off + 4], text[off + 5], text[off + 6], text[off + 7]]);
    let rd = (adrp_word & 0x1F) as u8;
    let ldr_rt = (ldr_word & 0x1F) as u8;
    let ldr_rn = ((ldr_word >> 5) & 0x1F) as u8;
    let new_adrp = aarch64::enc_adrp(aarch64::Reg(rd), imm21);
    let new_ldr = aarch64::enc_ldr32_imm(aarch64::Reg(ldr_rt), aarch64::Reg(ldr_rn), in_page);
    text[off..off + 4].copy_from_slice(&new_adrp.to_le_bytes());
    text[off + 4..off + 8].copy_from_slice(&new_ldr.to_le_bytes());
    Ok(())
}

// ----------------------------------------------------------------
// Header writers.
// ----------------------------------------------------------------

/// On-disk shape of the DOS header + 64-byte stub. The modern PE
/// loader only reads `e_magic` (`"MZ"`) and `e_lfanew` (the file
/// offset of the PE signature); everything else can stay zero.
/// The struct fields document the standard layout so a
/// refactor that grew a real DOS stub doesn't have to rederive the
/// offsets.
#[repr(C)]
#[derive(Copy, Clone)]
struct DosHeader {
    e_magic: [u8; 2],             // "MZ"
    _padding_to_lfanew: [u8; 58], // bytes 2..60 left zero
    e_lfanew: u32,                // file offset of the PE signature (== 128)
    _stub: [u8; 64],              // 64-byte real-mode stub, all zeros
}

const _: () = assert!(core::mem::size_of::<DosHeader>() == DOS_HEADER_AND_STUB);

/// COFF File Header (NT-style). Sits right after the 4-byte
/// `"PE\0\0"` signature.
#[repr(C)]
#[derive(Copy, Clone)]
struct CoffHeader {
    machine: u16,
    number_of_sections: u16,
    time_date_stamp: u32,
    pointer_to_symbol_table: u32,
    number_of_symbols: u32,
    size_of_optional_header: u16,
    characteristics: u16,
}

const _: () = assert!(core::mem::size_of::<CoffHeader>() == COFF_HEADER_SIZE);

/// One slot of the Optional Header's Data Directories array (16
/// fixed slots: Export, Import, Resource, Exception, ..., IAT,
/// ...). Both fields are RVAs / sizes.
#[repr(C)]
#[derive(Copy, Clone)]
struct DataDirectoryEntry {
    rva: u32,
    size: u32,
}

/// PE32+ Optional Header (240 bytes). All fields are explicit so
/// the reader can map field name to offset without consulting the
/// PE/COFF spec.
#[repr(C)]
#[derive(Copy, Clone)]
struct OptionalHeader64 {
    magic: u16,
    major_linker_version: u8,
    minor_linker_version: u8,
    size_of_code: u32,
    size_of_initialized_data: u32,
    size_of_uninitialized_data: u32,
    address_of_entry_point: u32,
    base_of_code: u32,
    image_base: u64,
    section_alignment: u32,
    file_alignment: u32,
    major_operating_system_version: u16,
    minor_operating_system_version: u16,
    major_image_version: u16,
    minor_image_version: u16,
    major_subsystem_version: u16,
    minor_subsystem_version: u16,
    win32_version_value: u32,
    size_of_image: u32,
    size_of_headers: u32,
    checksum: u32,
    subsystem: u16,
    dll_characteristics: u16,
    size_of_stack_reserve: u64,
    size_of_stack_commit: u64,
    size_of_heap_reserve: u64,
    size_of_heap_commit: u64,
    loader_flags: u32,
    number_of_rva_and_sizes: u32,
    data_directory: [DataDirectoryEntry; NUM_DATA_DIRS as usize],
}

const _: () = assert!(core::mem::size_of::<OptionalHeader64>() == OPTIONAL64_HEADER_SIZE);

/// One section table entry (40 bytes). Repeated
/// [`CoffHeader::number_of_sections`] times immediately after the
/// Optional Header.
#[repr(C)]
#[derive(Copy, Clone)]
struct SectionHeaderRaw {
    name: [u8; 8],
    virtual_size: u32,
    virtual_address: u32,
    size_of_raw_data: u32,
    pointer_to_raw_data: u32,
    pointer_to_relocations: u32,
    pointer_to_line_numbers: u32,
    number_of_relocations: u16,
    number_of_line_numbers: u16,
    characteristics: u32,
}

const _: () = assert!(core::mem::size_of::<SectionHeaderRaw>() == SECTION_HEADER_SIZE);

/// Append a `#[repr(C)]` struct's raw bytes to `out`.
///
/// PE32+ is a little-endian byte format, and our hosts (x86_64 and
/// AArch64) and targets are all little-endian, so a memcpy of the
/// in-memory struct produces the right wire format. The structs in
/// this module are explicit about field order and have const-asserted
/// sizes that match the PE/COFF spec, so the only thing that could
/// surprise is the host endianness -- and a const-time check guards
/// that.
fn write_struct<T: Copy>(out: &mut Vec<u8>, value: &T) {
    const _: () = assert!(
        cfg!(target_endian = "little"),
        "PE writer assumes a little-endian host; emit bytes manually if you need to cross-build from big-endian"
    );
    let bytes = unsafe {
        core::slice::from_raw_parts((value as *const T) as *const u8, core::mem::size_of::<T>())
    };
    out.extend_from_slice(bytes);
}

fn write_dos_header_and_stub(out: &mut Vec<u8>) {
    write_struct(
        out,
        &DosHeader {
            e_magic: *b"MZ",
            _padding_to_lfanew: [0; 58],
            e_lfanew: DOS_HEADER_AND_STUB as u32,
            _stub: [0; 64],
        },
    );
}

fn write_pe_signature(out: &mut Vec<u8>) {
    out.extend_from_slice(b"PE\0\0");
}

#[allow(clippy::too_many_arguments)]
fn write_coff_header(
    out: &mut Vec<u8>,
    optional_header_size: usize,
    machine: Machine,
    data_section_present: bool,
    reloc_section_present: bool,
    edata_section_present: bool,
    dwarf_section_present: bool,
    coff_symtab_file_off: u32,
    n_coff_symbols: u32,
    coff_strtab_file_off: u32,
    is_dll: bool,
) {
    let _ = coff_strtab_file_off;
    let machine_id = match machine {
        Machine::X86_64 => IMAGE_FILE_MACHINE_AMD64,
        Machine::Aarch64 => IMAGE_FILE_MACHINE_ARM64,
    };
    let mut characteristics = IMAGE_FILE_EXECUTABLE_IMAGE | IMAGE_FILE_LARGE_ADDRESS_AWARE;
    if is_dll {
        characteristics |= IMAGE_FILE_DLL;
    }
    write_struct(
        out,
        &CoffHeader {
            machine: machine_id,
            number_of_sections: num_sections(
                data_section_present,
                reloc_section_present,
                edata_section_present,
                dwarf_section_present,
            ) as u16,
            time_date_stamp: 0,
            // PE images carry a COFF strtab at the file
            // tail so the long DWARF section names ("/<offset>")
            // resolve. With PLT trampolines we now also
            // emit a real COFF symbol table -- one local-name
            // entry per import -- right before the strtab.
            //
            // Layout: `pointer_to_symbol_table` -> symbols, then
            // strtab at `pointer_to_symbol_table + n_symbols * 18`.
            // Pre-#61 default with no trampolines: the symbol
            // count is 0 and the pointer lands directly on the
            // strtab.
            pointer_to_symbol_table: coff_symtab_file_off,
            number_of_symbols: n_coff_symbols,
            size_of_optional_header: optional_header_size as u16,
            characteristics,
        },
    );
}

struct OptionalHeaderInputs {
    entry_rva: u32,
    base_of_code: u32,
    size_of_code: u32,
    size_of_initialized_data: u32,
    size_of_image: u32,
    size_of_headers: u32,
    import_table_rva: u32,
    import_table_size: u32,
    /// Exception Directory (data directory entry 3) -- the
    /// `.pdata` section's RUNTIME_FUNCTION array (the array only,
    /// excluding any trailing UNWIND_INFO blob in the same section).
    exception_table_rva: u32,
    exception_table_size: u32,
    /// Base Relocation Directory (data directory entry 5) -- the
    /// `.reloc` section's RVA / size.
    base_reloc_rva: u32,
    base_reloc_size: u32,
    iat_rva: u32,
    iat_size: u32,
    /// TLS Directory (data directory entry 9). RVA and size of
    /// `IMAGE_TLS_DIRECTORY64` (which lives inside `.data`).
    /// Both zero when the program has no `_Thread_local`
    /// globals.
    tls_table_rva: u32,
    tls_table_size: u32,
    /// Export Directory (data directory entry 0). RVA / size
    /// of `.edata` -- the `IMAGE_EXPORT_DIRECTORY` plus its
    /// trailing function-RVA / name-RVA / ordinal arrays
    /// and string blob. Both zero for executables and for
    /// DLLs that don't declare any `#pragma export`.
    export_table_rva: u32,
    export_table_size: u32,
    /// PE optional-header `Subsystem` field. Driven by
    /// `#pragma subsystem(<kind>)` -- `console` ->
    /// `IMAGE_SUBSYSTEM_WINDOWS_CUI` (3, default), `windows`
    /// -> `IMAGE_SUBSYSTEM_WINDOWS_GUI` (2). The console
    /// shape is what every existing demo / fixture builds
    /// against; the GUI shape skips the loader's auto-attach
    /// to a console window so a `WinMain`-shaped program
    /// doesn't show a console.
    subsystem: u16,
}

fn write_optional_header(out: &mut Vec<u8>, inp: OptionalHeaderInputs) {
    // OS version 4.0, Subsystem 5.2: copied from mingw's minimal
    // exe. These are the most permissive values that still mark the
    // image as a 64-bit console app the modern Windows loader
    // accepts. Bumping to 10.0 (which we tried first) caused
    // CreateProcess to reject our images with ERROR_BAD_EXE_FORMAT
    // on real Windows, even though wine on Linux tolerated it.
    //
    // DllCharacteristics: copy what mingw's minimal exe ships
    // with -- DYNAMIC_BASE | HIGH_ENTROPY_VA | NX_COMPAT |
    // NO_SEH. ASLR stays on for every image we emit:
    // TLS-free images have no absolute pointers to fix up, so
    // the loader can slide them freely without consulting a
    // `.reloc` section; TLS-using images carry an actual
    // `.reloc` block targeting the three absolute VAs in
    // `IMAGE_TLS_DIRECTORY64` (StartAddressOfRawData,
    // EndAddressOfRawData, AddressOfIndex) so the slide-aware
    // loader fixes them up before walking the directory.
    let dll_chars = IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE
        | IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA
        | IMAGE_DLLCHARACTERISTICS_NX_COMPAT
        | IMAGE_DLLCHARACTERISTICS_NO_SEH;

    let mut data_directory = [DataDirectoryEntry { rva: 0, size: 0 }; NUM_DATA_DIRS as usize];
    data_directory[DATA_DIRECTORY_IMPORT] = DataDirectoryEntry {
        rva: inp.import_table_rva,
        size: inp.import_table_size,
    };
    data_directory[DATA_DIRECTORY_EXPORT] = DataDirectoryEntry {
        rva: inp.export_table_rva,
        size: inp.export_table_size,
    };
    data_directory[DATA_DIRECTORY_EXCEPTION] = DataDirectoryEntry {
        rva: inp.exception_table_rva,
        size: inp.exception_table_size,
    };
    data_directory[DATA_DIRECTORY_BASERELOC] = DataDirectoryEntry {
        rva: inp.base_reloc_rva,
        size: inp.base_reloc_size,
    };
    data_directory[DATA_DIRECTORY_TLS] = DataDirectoryEntry {
        rva: inp.tls_table_rva,
        size: inp.tls_table_size,
    };
    data_directory[DATA_DIRECTORY_IAT] = DataDirectoryEntry {
        rva: inp.iat_rva,
        size: inp.iat_size,
    };

    write_struct(
        out,
        &OptionalHeader64 {
            magic: PE32_PLUS_MAGIC,
            major_linker_version: 14,
            minor_linker_version: 0,
            size_of_code: inp.size_of_code,
            size_of_initialized_data: inp.size_of_initialized_data,
            size_of_uninitialized_data: 0,
            address_of_entry_point: inp.entry_rva,
            base_of_code: inp.base_of_code,
            image_base: IMAGE_BASE,
            section_alignment: SECTION_ALIGNMENT,
            file_alignment: FILE_ALIGNMENT,
            major_operating_system_version: 4,
            minor_operating_system_version: 0,
            major_image_version: 0,
            minor_image_version: 0,
            major_subsystem_version: 5,
            minor_subsystem_version: 2,
            win32_version_value: 0,
            size_of_image: inp.size_of_image,
            size_of_headers: inp.size_of_headers,
            checksum: 0,
            subsystem: inp.subsystem,
            dll_characteristics: dll_chars,
            size_of_stack_reserve: 0x10_0000, // 1 MiB
            size_of_stack_commit: 0x1000,
            size_of_heap_reserve: 0x10_0000,
            size_of_heap_commit: 0x1000,
            loader_flags: 0,
            number_of_rva_and_sizes: NUM_DATA_DIRS,
            data_directory,
        },
    );
}

/// Caller-side view of a section the writer is about to emit.
/// Only the fields that vary between sections live here -- the
/// per-section relocation / line-number counters are zero for
/// every section we produce, so the on-disk
/// [`SectionHeaderRaw`] fills them in unconditionally.
struct SectionHeader {
    name: [u8; 8],
    virtual_size: u32,
    virtual_address: u32,
    size_of_raw_data: u32,
    pointer_to_raw_data: u32,
    characteristics: u32,
}

fn write_section_headers(out: &mut Vec<u8>, sections: &[SectionHeader]) {
    for sec in sections {
        write_struct(
            out,
            &SectionHeaderRaw {
                name: sec.name,
                virtual_size: sec.virtual_size,
                virtual_address: sec.virtual_address,
                size_of_raw_data: sec.size_of_raw_data,
                pointer_to_raw_data: sec.pointer_to_raw_data,
                pointer_to_relocations: 0,
                pointer_to_line_numbers: 0,
                number_of_relocations: 0,
                number_of_line_numbers: 0,
                characteristics: sec.characteristics,
            },
        );
    }
}

// ----------------------------------------------------------------
// Imports + IAT layout.
// ----------------------------------------------------------------

struct DllGroup {
    dll_name: String,
    /// Indices into the global imports list (== IAT slot indices).
    members: Vec<usize>,
}

fn group_imports_by_dll(imports: &[(String, String)]) -> Vec<DllGroup> {
    // Preserve the order DLLs first appear in. Most programs hit
    // two DLLs (msvcrt + kernel32) but the structure scales --
    // anything declared via `#pragma dylib` shows up here.
    let mut groups: Vec<DllGroup> = Vec::new();
    for (idx, (_, dll)) in imports.iter().enumerate() {
        if let Some(g) = groups.iter_mut().find(|g| g.dll_name == *dll) {
            g.members.push(idx);
        } else {
            groups.push(DllGroup {
                dll_name: dll.clone(),
                members: vec![idx],
            });
        }
    }
    groups
}

struct IDataLayout {
    bytes: Vec<u8>,
    import_directory_rva: u32,
    import_directory_size: u32,
    /// RVA of the start of the unified IAT region. The contents are
    /// laid out DLL-by-DLL (each DLL's run terminated by a zero
    /// entry), so the position of import N in the IAT does *not*
    /// match its position in the global imports list -- look up
    /// [`Self::iat_rva_for_import`] instead.
    iat_rva_base: u32,
    /// Total IAT size, including the per-DLL terminator entries.
    iat_size: u32,
    /// `iat_rva_for_import[N]` is the RVA of the IAT slot for
    /// import index N in the global list. Indexed straight by
    /// `GotFixup::import_index` and by the entry stub's stub-only
    /// indices.
    iat_rva_for_import: Vec<u32>,
}

fn plan_idata(dlls: &[DllGroup], imports: &[(String, String)], base_rva: u32) -> IDataLayout {
    // Fixed-size pieces: import descriptors (one per DLL plus a
    // zero-terminator) and the IATs / ILTs (each per-DLL section
    // plus a zero terminator).
    let n_dlls = dlls.len();
    let n_imports = imports.len();

    let import_dir_off: usize = 0;
    let import_dir_size = (n_dlls + 1) * IMAGE_IMPORT_DESCRIPTOR_SIZE;

    // The IAT entries are 8-byte u64s, and the aarch64 LDR
    // immediate is scaled by 8 (so the in-page byte offset must be
    // 8-aligned). The import-descriptor block is 4-aligned by its
    // shape (each descriptor is 20 bytes), so a 2-DLL setup ends
    // at offset 60 -- not 8-aligned. Pad here so the IAT starts at
    // an 8-byte boundary regardless of how many DLLs we have.
    let iat_off = round_up_usize(import_dir_off + import_dir_size, 8);
    // IAT layout: per-DLL block of (n_members + 1) u64 entries (the
    // final entry per DLL is a NULL terminator).
    let iat_size = dlls
        .iter()
        .map(|g| (g.members.len() + 1) * IAT_ENTRY_SIZE)
        .sum::<usize>();

    let ilt_off = iat_off + iat_size;
    let ilt_size = iat_size; // mirror of IAT

    // Hint/Name table starts after the ILT. Each import gets:
    //   IMAGE_IMPORT_BY_NAME { Hint: u16, Name: NUL-terminated bytes }
    // We round each entry up to 2 bytes to keep the next entry's
    // u16 hint aligned (the spec is lenient, but the typical
    // toolchain output rounds).
    let hint_table_off = ilt_off + ilt_size;
    let mut hint_table_size = 0usize;
    let mut hint_offsets: Vec<usize> = Vec::with_capacity(n_imports);
    for (sym, _) in imports {
        hint_offsets.push(hint_table_off + hint_table_size);
        hint_table_size += 2 + sym.len() + 1;
        if hint_table_size & 1 != 0 {
            hint_table_size += 1; // align to 2
        }
    }

    // DLL name strings come after the hint table.
    let dll_strings_off = hint_table_off + hint_table_size;
    let mut dll_strings_size = 0usize;
    let mut dll_name_offsets: Vec<usize> = Vec::with_capacity(n_dlls);
    for g in dlls {
        dll_name_offsets.push(dll_strings_off + dll_strings_size);
        dll_strings_size += g.dll_name.len() + 1;
    }

    let total = dll_strings_off + dll_strings_size;
    let mut bytes = vec![0u8; total];

    // Per-DLL IAT base offsets within the IAT region (each member
    // of group g sits at iat_off + group_iat_offsets[g_idx] +
    // member_pos * 8).
    let mut group_iat_offsets: Vec<usize> = Vec::with_capacity(n_dlls);
    let mut group_ilt_offsets: Vec<usize> = Vec::with_capacity(n_dlls);
    {
        let mut iat_cur = 0usize;
        let mut ilt_cur = 0usize;
        for g in dlls {
            group_iat_offsets.push(iat_cur);
            group_ilt_offsets.push(ilt_cur);
            iat_cur += (g.members.len() + 1) * IAT_ENTRY_SIZE;
            ilt_cur += (g.members.len() + 1) * IAT_ENTRY_SIZE;
        }
    }

    // ---- Write import descriptors (one per DLL + zero terminator).
    for (g_idx, group) in dlls.iter().enumerate() {
        let _ = group; // descriptor just needs the indexed offsets below
        let off = import_dir_off + g_idx * IMAGE_IMPORT_DESCRIPTOR_SIZE;
        let ilt_rva = base_rva + (ilt_off + group_ilt_offsets[g_idx]) as u32;
        let iat_rva = base_rva + (iat_off + group_iat_offsets[g_idx]) as u32;
        let name_rva = base_rva + dll_name_offsets[g_idx] as u32;
        bytes[off..off + 4].copy_from_slice(&ilt_rva.to_le_bytes()); // OriginalFirstThunk
        bytes[off + 4..off + 8].copy_from_slice(&0u32.to_le_bytes()); // TimeDateStamp
        bytes[off + 8..off + 12].copy_from_slice(&0u32.to_le_bytes()); // ForwarderChain
        bytes[off + 12..off + 16].copy_from_slice(&name_rva.to_le_bytes()); // Name
        bytes[off + 16..off + 20].copy_from_slice(&iat_rva.to_le_bytes()); // FirstThunk
    }
    // The terminating descriptor is already zeroed.

    // ---- Write IAT and ILT entries. We layout the IAT so that
    // import_index N (in the global list) lives in slot
    // [iat_off + offset_to_global_index(N)], where the offset is
    // chosen so the global ordering is preserved (program imports
    // first, then stub-only imports). To make that work we compute
    // each global index's IAT offset directly.
    let mut iat_slot_for_global_index: Vec<usize> = vec![0; n_imports];
    for (g_idx, g) in dlls.iter().enumerate() {
        for (member_pos, &global_idx) in g.members.iter().enumerate() {
            iat_slot_for_global_index[global_idx] =
                iat_off + group_iat_offsets[g_idx] + member_pos * IAT_ENTRY_SIZE;
        }
    }
    for (g_idx, group) in dlls.iter().enumerate() {
        for (member_pos, &global_idx) in group.members.iter().enumerate() {
            let entry_value = base_rva + hint_offsets[global_idx] as u32; // RVA -> hint/name
            let entry = entry_value as u64; // high bit clear -> name import
            let iat_slot = iat_off + group_iat_offsets[g_idx] + member_pos * IAT_ENTRY_SIZE;
            let ilt_slot = ilt_off + group_ilt_offsets[g_idx] + member_pos * IAT_ENTRY_SIZE;
            bytes[iat_slot..iat_slot + IAT_ENTRY_SIZE].copy_from_slice(&entry.to_le_bytes());
            bytes[ilt_slot..ilt_slot + IAT_ENTRY_SIZE].copy_from_slice(&entry.to_le_bytes());
        }
        // Terminator zero entry per DLL: already zeroed.
    }

    // ---- Write hint/name table.
    for (i, (sym, _)) in imports.iter().enumerate() {
        let off = hint_offsets[i];
        // Hint = 0 (we don't pre-resolve ordinals).
        bytes[off..off + 2].copy_from_slice(&0u16.to_le_bytes());
        bytes[off + 2..off + 2 + sym.len()].copy_from_slice(sym.as_bytes());
        // The trailing NUL is already in place from vec![0; total].
    }

    // ---- Write DLL name strings.
    for (g_idx, g) in dlls.iter().enumerate() {
        let off = dll_name_offsets[g_idx];
        bytes[off..off + g.dll_name.len()].copy_from_slice(g.dll_name.as_bytes());
    }

    let iat_rva_for_import: Vec<u32> = iat_slot_for_global_index
        .iter()
        .map(|off| base_rva + *off as u32)
        .collect();

    IDataLayout {
        bytes,
        import_directory_rva: base_rva + import_dir_off as u32,
        import_directory_size: import_dir_size as u32,
        iat_rva_base: base_rva + iat_off as u32,
        iat_size: iat_size as u32,
        iat_rva_for_import,
    }
}

// ----------------------------------------------------------------
// Entry stub.
//
// The stub bridges what the PE loader hands us at
// `AddressOfEntryPoint` (an entry with no parameters) and the
// signature the user wrote in source. The shape branches on the
// PE optional-header `Subsystem`:
//
//   * Console (`IMAGE_SUBSYSTEM_WINDOWS_CUI`, default): the stub
//     calls `__getmainargs` to populate argc/argv, then `bl main`
//     (or `call main`), then `exit`. The user's entry is treated
//     as `int main(int argc, char **argv)`.
//
//   * Windows GUI (`IMAGE_SUBSYSTEM_WINDOWS_GUI`, opt-in via
//     `#pragma subsystem(windows)`): the stub calls
//     `GetModuleHandleA(NULL)` and `GetCommandLineA()`, loads
//     `SW_SHOWDEFAULT` into the 4th-arg register, then `call
//     WinMain` and `exit`. The user's entry is treated as
//     `int WinMain(HINSTANCE, HINSTANCE, LPSTR, int)` -- the
//     canonical Win32 GUI signature.
//
// The stub layout differs per arch in instruction selection but
// the import set + patch shape is uniform: `EntryStub` carries an
// arch-neutral list of (byte-offset, stub-import-index) IAT
// patches, plus the direct-call-main offset, back to the writer.
// The writer appends `stub_imports` to the global import table and
// resolves each patch's IAT slot from the resulting layout.
// ----------------------------------------------------------------

/// A single IAT-lookup patch site in the entry stub. `byte_offset`
/// is the offset within `EntryStub::bytes` of the first byte of
/// the `call qword [rip+disp32]` (x86_64) or the `adrp` of the
/// `adrp; ldr; blr` triple (aarch64). `stub_import_idx` indexes
/// into `EntryStub::stub_imports` -- the writer turns that into
/// a global import-table index by adding the base offset at which
/// it splices `stub_imports` onto the program's resolved imports.
struct StubIatPatch {
    byte_offset: u32,
    stub_import_idx: usize,
}

struct EntryStub {
    bytes: Vec<u8>,
    /// `(symbol, dll)` pairs the stub references via IAT lookups.
    /// Empty for the DLL stub (which is a self-contained `mov eax,
    /// 1; ret`). The writer appends these onto the global imports
    /// table after the user's `#pragma binding(...)` imports.
    stub_imports: Vec<(&'static str, &'static str)>,
    /// IAT-lookup patch sites -- one per `call qword [rip+...]` /
    /// `adrp;ldr;blr` triple the stub emits.
    iat_patches: Vec<StubIatPatch>,
    /// Offset of the direct `bl main` / `call main`
    /// instruction. `None` for DLL output -- DllMain is
    /// invoked directly by the loader, not from the stub.
    direct_call_main_offset: Option<u32>,
}

impl EntryStub {
    fn empty() -> Self {
        Self {
            bytes: Vec::new(),
            stub_imports: Vec::new(),
            iat_patches: Vec::new(),
            direct_call_main_offset: None,
        }
    }
}

fn build_entry_stub(machine: Machine, is_dll: bool, subsystem: u16) -> EntryStub {
    if is_dll {
        return build_dllmain_stub(machine);
    }
    let gui = subsystem == IMAGE_SUBSYSTEM_WINDOWS_GUI;
    match machine {
        Machine::X86_64 if gui => build_x86_64_winmain_stub(),
        Machine::X86_64 => build_x86_64_entry_stub(),
        Machine::Aarch64 if gui => build_aarch64_winmain_stub(),
        Machine::Aarch64 => build_aarch64_entry_stub(),
    }
}

/// Minimal `DllMain` for shared-library output. The Windows
/// loader calls this on `DLL_PROCESS_ATTACH`,
/// `DLL_THREAD_ATTACH`, etc. with the standard
/// `(HINSTANCE, DWORD reason, LPVOID reserved)` signature
/// and expects a `BOOL` return; we return `TRUE` (1) to
/// signal "module is happy to load", which is all the
/// runtime semantics c5 has to offer today (no global
/// constructors, no thread-attach hooks).
///
/// * x86_64 (Win64 ABI): `mov eax, 1; ret` -- 6 bytes.
/// * aarch64 (Windows AAPCS64): `mov w0, #1; ret` -- 8 bytes.
fn build_dllmain_stub(machine: Machine) -> EntryStub {
    let bytes = match machine {
        // mov eax, 1 (B8 01 00 00 00); ret (C3).
        Machine::X86_64 => vec![0xB8, 0x01, 0x00, 0x00, 0x00, 0xC3],
        // mov w0, #1 (52800020) ; ret (D65F03C0). Both are
        // 4-byte little-endian instruction words.
        Machine::Aarch64 => {
            let mov = aarch64::enc_movz(aarch64::Reg::X0, 1, 0);
            let ret_word = aarch64::enc_ret(aarch64::Reg::X30);
            let mut b = Vec::with_capacity(8);
            b.extend_from_slice(&mov.to_le_bytes());
            b.extend_from_slice(&ret_word.to_le_bytes());
            b
        }
    };
    EntryStub {
        bytes,
        stub_imports: Vec::new(),
        iat_patches: Vec::new(),
        direct_call_main_offset: None,
    }
}

fn build_x86_64_entry_stub() -> EntryStub {
    // Stack frame for the call to `__getmainargs(int* pargc,
    // char*** pargv, char*** penvp, int doWildcardExpand,
    // _startupinfo* sinfo)`. Win64 passes the first four args in
    // rcx/rdx/r8/r9 and the fifth on the stack at [rsp + 0x20]
    // (right above the 32-byte shadow space).
    //
    // We carve 0x48 bytes from rsp for:
    //   [rsp + 0x00..0x20]  shadow space for our callees
    //   [rsp + 0x20..0x28]  fifth arg slot (pointer to _startupinfo)
    //   [rsp + 0x28..0x30]  argc out (int, but the slot is 8 bytes
    //                        so it stays aligned for the next thing)
    //   [rsp + 0x30..0x38]  argv out (char**)
    //   [rsp + 0x38..0x40]  envp out (char**), unused
    //   [rsp + 0x40..0x48]  _startupinfo struct (`int newmode`,
    //                        zero-initialised) plus 4 bytes pad
    //
    // 0x48 is 8 mod 16, so subtracting it from the entry rsp (also
    // 8 mod 16, since the OS-pushed return address sits on top)
    // leaves rsp 16-aligned for the call.
    let mut bytes: Vec<u8> = Vec::with_capacity(80);

    // sub rsp, 0x48                    (4 bytes)
    bytes.extend_from_slice(&[0x48, 0x83, 0xEC, 0x48]);

    // Zero the _startupinfo struct (4 bytes is enough).
    // xor eax, eax                      (2 bytes)
    bytes.extend_from_slice(&[0x31, 0xC0]);
    // mov [rsp+0x40], eax              (4 bytes)
    bytes.extend_from_slice(&[0x89, 0x44, 0x24, 0x40]);

    // 5th arg: pointer to _startupinfo, stored at [rsp+0x20].
    // lea rax, [rsp+0x40]              (5 bytes)
    bytes.extend_from_slice(&[0x48, 0x8D, 0x44, 0x24, 0x40]);
    // mov [rsp+0x20], rax              (5 bytes)
    bytes.extend_from_slice(&[0x48, 0x89, 0x44, 0x24, 0x20]);

    // arg1 = &argc -> &[rsp+0x28].   lea rcx, [rsp+0x28]  (5 bytes)
    bytes.extend_from_slice(&[0x48, 0x8D, 0x4C, 0x24, 0x28]);
    // arg2 = &argv -> &[rsp+0x30].   lea rdx, [rsp+0x30]  (5 bytes)
    bytes.extend_from_slice(&[0x48, 0x8D, 0x54, 0x24, 0x30]);
    // arg3 = &envp -> &[rsp+0x38].   lea r8, [rsp+0x38]   (5 bytes)
    bytes.extend_from_slice(&[0x4C, 0x8D, 0x44, 0x24, 0x38]);
    // arg4 = 0 (no wildcard expansion).   xor r9d, r9d   (3 bytes)
    bytes.extend_from_slice(&[0x45, 0x31, 0xC9]);

    // call qword [rip + 0]  __getmainargs   (6 bytes)
    let call_gma_off = bytes.len() as u32;
    bytes.extend_from_slice(&[0xFF, 0x15, 0, 0, 0, 0]);

    // mov rcx, [rsp+0x28]             (5 bytes)  -- argc
    bytes.extend_from_slice(&[0x48, 0x8B, 0x4C, 0x24, 0x28]);
    // mov rdx, [rsp+0x30]             (5 bytes)  -- argv
    bytes.extend_from_slice(&[0x48, 0x8B, 0x54, 0x24, 0x30]);

    // call main rel32 (placeholder, 5 bytes)
    let call_main_off = bytes.len() as u32;
    bytes.extend_from_slice(&[0xE8, 0, 0, 0, 0]);

    // mov rcx, rax                    (3 bytes)  -- main return value
    bytes.extend_from_slice(&[0x48, 0x89, 0xC1]);

    // call qword [rip + 0]  ExitProcess  (6 bytes)
    let call_exit_off = bytes.len() as u32;
    bytes.extend_from_slice(&[0xFF, 0x15, 0, 0, 0, 0]);

    // Stub-only imports, in patch order: __getmainargs first, exit
    // second. The IAT-lookup is the start of the `call qword`
    // instruction itself (not the disp32 byte); the patcher
    // computes `disp32 = target - (call + 6)` from this offset.
    EntryStub {
        bytes,
        stub_imports: vec![STUB_IMPORT_GETMAINARGS, STUB_IMPORT_EXIT],
        iat_patches: vec![
            StubIatPatch {
                byte_offset: call_gma_off,
                stub_import_idx: 0,
            },
            StubIatPatch {
                byte_offset: call_exit_off,
                stub_import_idx: 1,
            },
        ],
        direct_call_main_offset: Some(call_main_off),
    }
}

/// x86_64 GUI-subsystem entry stub. Bridges the no-arg
/// `AddressOfEntryPoint` calling convention to the canonical Win32
/// `int WinMain(HINSTANCE, HINSTANCE, LPSTR, int)` shape:
///
///   rcx = GetModuleHandleA(NULL)   -- hInstance
///   rdx = 0                        -- hPrevInstance
///   r8  = GetCommandLineA()        -- lpCmdLine
///   r9  = SW_SHOWDEFAULT (10)      -- nShowCmd
///   call WinMain
///   mov  ecx, eax
///   call exit
fn build_x86_64_winmain_stub() -> EntryStub {
    // Stack frame: we need a 32-byte shadow area for our callees
    // (Win64 ABI) plus an 8-byte spill slot for `hInstance` across
    // the `GetCommandLineA` call. Pick `sub rsp, 0x28` (40 bytes)
    // so post-sub `rsp` is 16-aligned for the calls below:
    //   * entry rsp is 8 mod 16 (OS pushed the return address)
    //   * subtract 0x28 (40) -> 16N - 48 = 16M  -> 16-aligned
    //
    // Frame layout after the SUB:
    //   [rsp + 0x00..0x08]  spill: hInstance saved across
    //                                GetCommandLineA
    //   [rsp + 0x08..0x20]  unused (part of shadow space)
    //   [rsp + 0x20..0x28]  return-addr (pushed by the OS); not
    //                                touched by us
    let mut bytes: Vec<u8> = Vec::with_capacity(64);

    // sub rsp, 0x28                          (4 bytes)
    bytes.extend_from_slice(&[0x48, 0x83, 0xEC, 0x28]);

    // xor ecx, ecx                           (2 bytes) -- arg1 = NULL
    bytes.extend_from_slice(&[0x31, 0xC9]);
    // call qword [rip+0]  GetModuleHandleA   (6 bytes)
    let call_gmh_off = bytes.len() as u32;
    bytes.extend_from_slice(&[0xFF, 0x15, 0, 0, 0, 0]);
    // mov [rsp], rax                         (4 bytes) -- spill hInstance
    bytes.extend_from_slice(&[0x48, 0x89, 0x04, 0x24]);

    // call qword [rip+0]  GetCommandLineA    (6 bytes)
    let call_gcl_off = bytes.len() as u32;
    bytes.extend_from_slice(&[0xFF, 0x15, 0, 0, 0, 0]);

    // mov r8, rax                            (3 bytes) -- arg3 = lpCmdLine
    bytes.extend_from_slice(&[0x49, 0x89, 0xC0]);
    // mov rcx, [rsp]                         (4 bytes) -- arg1 = hInstance
    bytes.extend_from_slice(&[0x48, 0x8B, 0x0C, 0x24]);
    // xor edx, edx                           (2 bytes) -- arg2 = NULL
    bytes.extend_from_slice(&[0x31, 0xD2]);
    // mov r9d, SW_SHOWDEFAULT                (6 bytes) -- arg4 = 10
    bytes.push(0x41);
    bytes.push(0xB9);
    bytes.extend_from_slice(&SW_SHOWDEFAULT.to_le_bytes());

    // call WinMain rel32 (placeholder, 5 bytes)
    let call_main_off = bytes.len() as u32;
    bytes.extend_from_slice(&[0xE8, 0, 0, 0, 0]);

    // mov ecx, eax                           (2 bytes) -- exit code
    bytes.extend_from_slice(&[0x89, 0xC1]);
    // call qword [rip+0]  exit               (6 bytes)
    let call_exit_off = bytes.len() as u32;
    bytes.extend_from_slice(&[0xFF, 0x15, 0, 0, 0, 0]);

    EntryStub {
        bytes,
        stub_imports: vec![
            STUB_IMPORT_GETMODULEHANDLEA,
            STUB_IMPORT_GETCOMMANDLINEA,
            STUB_IMPORT_EXIT,
        ],
        iat_patches: vec![
            StubIatPatch {
                byte_offset: call_gmh_off,
                stub_import_idx: 0,
            },
            StubIatPatch {
                byte_offset: call_gcl_off,
                stub_import_idx: 1,
            },
            StubIatPatch {
                byte_offset: call_exit_off,
                stub_import_idx: 2,
            },
        ],
        direct_call_main_offset: Some(call_main_off),
    }
}

/// AArch64 entry stub. Same flow as the x86_64 one: prologue, lay
/// out a small frame for argc/argv/envp/_startupinfo, call
/// `__getmainargs` via IAT, hand argc/argv to `main`, then call
/// `ExitProcess` via IAT. AAPCS64 calling convention -- args are
/// in x0..x7, no shadow space.
fn build_aarch64_entry_stub() -> EntryStub {
    use super::aarch64 as a;
    let mut bytes: Vec<u8> = Vec::with_capacity(80);

    // Frame layout after `sub sp, sp, #0x40` (carved below the
    // saved fp/lr pair):
    //   [sp + 0x00..0x08]  argc out (low 32 bits used; we zero the
    //                        slot before the call and load 64 bits
    //                        afterwards so the upper bits are 0)
    //   [sp + 0x08..0x10]  argv out (char**)
    //   [sp + 0x10..0x18]  envp out (char***), unused after
    //   [sp + 0x18..0x20]  _startupinfo (`int newmode`, zeroed)
    //   [sp + 0x20..0x40]  padding (kept around to give us room
    //                        for nested call's spill slots if the
    //                        callee wanted them; AAPCS64 doesn't
    //                        require shadow space, so this is just
    //                        slack)

    // stp x29, x30, [sp, #-16]!         (save fp, lr; pre-decrement)
    a::emit(
        &mut bytes,
        a::enc_stp_pre(a::Reg::X29, a::Reg::X30, a::Reg::SP, -16),
    );
    // mov x29, sp                        (= add x29, sp, #0)
    a::emit(&mut bytes, a::enc_add_imm(a::Reg::X29, a::Reg::SP, 0));
    // sub sp, sp, #0x40
    a::emit(&mut bytes, a::enc_sub_imm(a::Reg::SP, a::Reg::SP, 0x40));

    // Zero argc and _startupinfo slots so the post-call ldr x0
    // gets a clean zero-extended argc and __getmainargs sees a
    // zeroed _startupinfo struct.
    // str xzr, [sp, #0x00]
    a::emit(&mut bytes, a::enc_str_imm(a::Reg(31), a::Reg::SP, 0x00));
    // str xzr, [sp, #0x18]
    a::emit(&mut bytes, a::enc_str_imm(a::Reg(31), a::Reg::SP, 0x18));

    // Set up __getmainargs args:
    //   x0 = &argc, x1 = &argv, x2 = &envp,
    //   x3 = doWildcardExpansion (0), x4 = &_startupinfo
    a::emit(&mut bytes, a::enc_add_imm(a::Reg::X0, a::Reg::SP, 0x00));
    a::emit(&mut bytes, a::enc_add_imm(a::Reg::X1, a::Reg::SP, 0x08));
    a::emit(&mut bytes, a::enc_add_imm(a::Reg::X2, a::Reg::SP, 0x10));
    a::emit(&mut bytes, a::enc_movz(a::Reg(3), 0, 0));
    a::emit(&mut bytes, a::enc_add_imm(a::Reg(4), a::Reg::SP, 0x18));

    // adrp x16, IAT_PAGE; ldr x16, [x16, #IAT_OFF]; blr x16
    let iat_gma_off = bytes.len() as u32;
    a::emit(&mut bytes, a::enc_adrp(a::Reg::X16, 0)); // placeholder
    a::emit(&mut bytes, a::enc_ldr_imm(a::Reg::X16, a::Reg::X16, 0)); // placeholder
    a::emit(&mut bytes, a::enc_blr(a::Reg::X16));

    // Load argc into x0 (low 32 bits = int value, high 32 = zero
    // since we zeroed the slot first). Load argv into x1.
    a::emit(&mut bytes, a::enc_ldr_imm(a::Reg::X0, a::Reg::SP, 0x00));
    a::emit(&mut bytes, a::enc_ldr_imm(a::Reg::X1, a::Reg::SP, 0x08));

    // bl main (rel26 placeholder).
    let bl_main_off = bytes.len() as u32;
    a::emit(&mut bytes, a::enc_bl(0));

    // main's return value is in w0 / x0 already (AAPCS64), so it's
    // the first arg for ExitProcess. Just call through the IAT.
    let iat_exit_off = bytes.len() as u32;
    a::emit(&mut bytes, a::enc_adrp(a::Reg::X16, 0));
    a::emit(&mut bytes, a::enc_ldr_imm(a::Reg::X16, a::Reg::X16, 0));
    a::emit(&mut bytes, a::enc_blr(a::Reg::X16));

    EntryStub {
        bytes,
        stub_imports: vec![STUB_IMPORT_GETMAINARGS, STUB_IMPORT_EXIT],
        iat_patches: vec![
            StubIatPatch {
                byte_offset: iat_gma_off,
                stub_import_idx: 0,
            },
            StubIatPatch {
                byte_offset: iat_exit_off,
                stub_import_idx: 1,
            },
        ],
        direct_call_main_offset: Some(bl_main_off),
    }
}

/// AArch64 GUI-subsystem entry stub. Bridges the no-arg
/// `AddressOfEntryPoint` calling convention to the Win32
/// `int WinMain(HINSTANCE, HINSTANCE, LPSTR, int)` shape, using
/// AAPCS64 (Windows on ARM) register-passing:
///
///   x0 = GetModuleHandleA(NULL)   -- hInstance
///   x1 = 0                        -- hPrevInstance
///   x2 = GetCommandLineA()        -- lpCmdLine
///   w3 = SW_SHOWDEFAULT (10)      -- nShowCmd
///   bl WinMain
///   bl exit
fn build_aarch64_winmain_stub() -> EntryStub {
    use super::aarch64 as a;
    let mut bytes: Vec<u8> = Vec::with_capacity(64);

    // Save fp/lr and carve 16 bytes for the hInstance spill.
    // Total stack delta = 32 bytes; sp stays 16-aligned.
    // stp x29, x30, [sp, #-16]!
    a::emit(
        &mut bytes,
        a::enc_stp_pre(a::Reg::X29, a::Reg::X30, a::Reg::SP, -16),
    );
    a::emit(&mut bytes, a::enc_add_imm(a::Reg::X29, a::Reg::SP, 0));
    // sub sp, sp, #0x10  -- 1 spill slot, kept 16-aligned
    a::emit(&mut bytes, a::enc_sub_imm(a::Reg::SP, a::Reg::SP, 0x10));

    // mov w0, #0  -- arg1 (NULL) to GetModuleHandleA
    a::emit(&mut bytes, a::enc_movz(a::Reg::X0, 0, 0));

    // adrp x16, IAT_PAGE; ldr x16, [x16, #IAT_OFF]; blr x16
    let iat_gmh_off = bytes.len() as u32;
    a::emit(&mut bytes, a::enc_adrp(a::Reg::X16, 0));
    a::emit(&mut bytes, a::enc_ldr_imm(a::Reg::X16, a::Reg::X16, 0));
    a::emit(&mut bytes, a::enc_blr(a::Reg::X16));

    // str x0, [sp]  -- spill hInstance across the next call
    a::emit(&mut bytes, a::enc_str_imm(a::Reg::X0, a::Reg::SP, 0x00));

    // adrp x16, IAT_PAGE; ldr x16, [x16, #IAT_OFF]; blr x16
    let iat_gcl_off = bytes.len() as u32;
    a::emit(&mut bytes, a::enc_adrp(a::Reg::X16, 0));
    a::emit(&mut bytes, a::enc_ldr_imm(a::Reg::X16, a::Reg::X16, 0));
    a::emit(&mut bytes, a::enc_blr(a::Reg::X16));

    // Set up WinMain args. lpCmdLine is currently in x0 from
    // GetCommandLineA -- park it in x2 before reloading x0.
    // mov x2, x0
    a::emit(&mut bytes, a::enc_mov_reg(a::Reg::X2, a::Reg::X0));
    // ldr x0, [sp]   -- reload hInstance
    a::emit(&mut bytes, a::enc_ldr_imm(a::Reg::X0, a::Reg::SP, 0x00));
    // mov x1, #0
    a::emit(&mut bytes, a::enc_movz(a::Reg::X1, 0, 0));
    // mov w3, #SW_SHOWDEFAULT (10) -- a 16-bit imm fits in one movz.
    a::emit(&mut bytes, a::enc_movz(a::Reg(3), SW_SHOWDEFAULT as u16, 0));

    // bl WinMain (rel26 placeholder)
    let bl_main_off = bytes.len() as u32;
    a::emit(&mut bytes, a::enc_bl(0));

    // WinMain's return is in w0/x0 -- first arg to exit. Tail-call
    // via the IAT; exit() doesn't return so no epilogue needed.
    let iat_exit_off = bytes.len() as u32;
    a::emit(&mut bytes, a::enc_adrp(a::Reg::X16, 0));
    a::emit(&mut bytes, a::enc_ldr_imm(a::Reg::X16, a::Reg::X16, 0));
    a::emit(&mut bytes, a::enc_blr(a::Reg::X16));

    EntryStub {
        bytes,
        stub_imports: vec![
            STUB_IMPORT_GETMODULEHANDLEA,
            STUB_IMPORT_GETCOMMANDLINEA,
            STUB_IMPORT_EXIT,
        ],
        iat_patches: vec![
            StubIatPatch {
                byte_offset: iat_gmh_off,
                stub_import_idx: 0,
            },
            StubIatPatch {
                byte_offset: iat_gcl_off,
                stub_import_idx: 1,
            },
            StubIatPatch {
                byte_offset: iat_exit_off,
                stub_import_idx: 2,
            },
        ],
        direct_call_main_offset: Some(bl_main_off),
    }
}

/// `.pdata` builder result. `bytes` is the full section payload
/// (RUNTIME_FUNCTIONs + any trailing UNWIND_INFO blobs). `directory_size`
/// is just the RUNTIME_FUNCTION array size and is what gets wired into
/// the Optional Header's Exception Directory entry. The two are equal
/// for AArch64 (no trailing data) and differ for x86_64.
struct Pdata {
    bytes: Vec<u8>,
    directory_size: u32,
}

/// `.pdata` Exception Directory dispatcher.
///
/// Both x86_64 and aarch64 are covered. The two formats are
/// different on the wire -- x86_64 uses 12-byte
/// (begin/end/UnwindInfoAddress) entries plus a co-located
/// `UNWIND_INFO` blob; aarch64 uses 8-byte entries with packed
/// unwind info inline -- so we dispatch and let each builder lay
/// out its own bytes.
fn build_pdata(machine: Machine, text_rva: u32, text_size: u32, pdata_rva: u32) -> Pdata {
    match machine {
        Machine::X86_64 => build_x86_64_pdata(text_rva, text_size, pdata_rva),
        Machine::Aarch64 => build_aarch64_pdata(text_rva, text_size),
    }
}

/// x86_64 `.pdata` builder.
///
/// The x86_64 Windows ABI requires every non-leaf function to have
/// a `RUNTIME_FUNCTION` entry pointing at an `UNWIND_INFO` struct;
/// the OS loader and `RtlLookupFunctionEntry` consult these for
/// SEH unwinding. Older Windows revisions tolerated a missing
/// Exception Directory, but the spec has always required it on
/// 64-bit targets and stricter loaders / verifiers reject without
/// one.
///
/// We emit a single coarse entry covering the entire `.text`
/// region, paired with a minimal `UNWIND_INFO` (version=1,
/// flags=0, no prolog, no codes). The unwinder would treat every
/// address as a leaf with no frame -- a lie, but the c5 program
/// never raises a Windows exception, and the loader doesn't
/// validate the unwind codes against the actual prolog. This
/// mirrors the coarse approach the AArch64 builder uses.
///
/// Layout: [12 bytes: RUNTIME_FUNCTION][4 bytes: UNWIND_INFO].
/// The UNWIND_INFO sits immediately after the RUNTIME_FUNCTION in
/// the same section, which keeps everything in one place and
/// honors the 4-byte alignment requirement. The Exception
/// Directory only spans the RUNTIME_FUNCTION (the loader uses
/// `Size / sizeof(RUNTIME_FUNCTION)` to count entries, so the
/// trailing UNWIND_INFO must not be counted).
fn build_x86_64_pdata(text_rva: u32, text_size: u32, pdata_rva: u32) -> Pdata {
    const RUNTIME_FUNCTION_SIZE: u32 = 12;
    let mut bytes = Vec::with_capacity(16);
    let unwind_info_rva = pdata_rva + RUNTIME_FUNCTION_SIZE;
    // RUNTIME_FUNCTION { BeginAddress, EndAddress, UnwindInfoAddress }
    bytes.extend_from_slice(&text_rva.to_le_bytes());
    bytes.extend_from_slice(&(text_rva + text_size).to_le_bytes());
    bytes.extend_from_slice(&unwind_info_rva.to_le_bytes());
    // UNWIND_INFO:
    //   byte 0: Version (3 bits) | Flags (5 bits) -- v1, no flags
    //   byte 1: SizeOfProlog                       -- 0
    //   byte 2: CountOfCodes                       -- 0
    //   byte 3: FrameRegister (4) | FrameOffset(4) -- 0
    bytes.extend_from_slice(&[0x01, 0x00, 0x00, 0x00]);
    Pdata {
        bytes,
        directory_size: RUNTIME_FUNCTION_SIZE,
    }
}

/// AArch64 `.pdata` builder.
///
/// The AArch64 Windows ABI requires every executable code region
/// to be covered by a `RUNTIME_FUNCTION` entry in the Exception
/// Directory; the OS loader looks these up to handle stack
/// unwinding for SEH-style exceptions. wine on Linux/arm64 follows
/// the same rule and refuses to load PEs that omit `.pdata`.
///
/// Each `RUNTIME_FUNCTION` is two `u32`s: `BeginAddress` (RVA of
/// the first instruction) and `UnwindData`. The `UnwindData` can
/// either point to an `.xdata` blob or carry packed unwind info
/// inline -- packed format has `Flag != 0` in its low two bits and
/// is sufficient for our purposes since the c5 program never
/// raises a Windows-style exception. We use `Flag = 1` ("packed
/// unwind, canonical -- complete function") with all other fields
/// zero, which claims "no saves, no frame, no chained context, no
/// LR home". The Microsoft compiler emits this exact pattern for
/// frameless leaf functions. The unwinder would interpret every
/// address as a frameless leaf, which is a lie, but the loader
/// only validates structural properties (begin within image, no
/// overlap, ranges sorted) and never runs the unwinder against
/// our binary. We previously used `Flag = 2` (fragment) here;
/// real Windows ARM rejected those binaries with
/// `STATUS_INVALID_IMAGE_FORMAT` even though wine on Linux/arm64
/// accepted them, so we picked the canonical encoding.
///
/// One catch: the `FunctionLength` field is 11 bits (instruction
/// count), so a single packed entry covers at most 8192 bytes of
/// code. We split larger `.text` into 8 KiB chunks, one packed
/// entry per chunk.
fn build_aarch64_pdata(text_rva: u32, text_size: u32) -> Pdata {
    let mut bytes = Vec::new();
    let mut covered = 0u32;
    while covered < text_size {
        let remaining = text_size - covered;
        let chunk = remaining.min(ARM64_PACKED_FUNCTION_MAX_BYTES);
        // Round chunk down to a multiple of 4 (instruction size).
        // Any tail (non-multiple-of-4) shouldn't appear in our
        // codegen, but guard against it just in case.
        let chunk_words = chunk / 4;
        let function_length = chunk_words & 0x7FF; // 11 bits
        let unwind_data: u32 = (function_length << 2) | 0b01; // Flag=1
        let begin_address = text_rva + covered;
        bytes.extend_from_slice(&begin_address.to_le_bytes());
        bytes.extend_from_slice(&unwind_data.to_le_bytes());
        covered += chunk;
    }
    let directory_size = bytes.len() as u32;
    Pdata {
        bytes,
        directory_size,
    }
}

// ----------------------------------------------------------------
// Fixup helpers.
//
// Three patch shapes per arch (six total). The writer threads RVAs
// (relative to ImageBase) and offsets within the combined `.text`,
// and these helpers do the per-arch arithmetic to land the right
// bits in the right slots.
// ----------------------------------------------------------------

/// Patch an IAT-lookup sequence: `call qword [rip+disp32]` on
/// x86_64, or `adrp x16, _; ldr x16, [x16, #_]` on aarch64. The
/// caller passes the offset of the first instruction within the
/// combined `.text`, the section's RVA, and the IAT slot's RVA.
fn patch_iat_lookup(
    machine: Machine,
    text: &mut [u8],
    instr_offset_in_text: u32,
    text_section_rva: u32,
    target_rva: u32,
) -> Result<(), C5Error> {
    let instr_rva = text_section_rva + instr_offset_in_text;
    match machine {
        Machine::X86_64 => {
            // `call qword [rip+disp32]`: 6 bytes. disp32 at +2;
            // RIP at the after-byte (+6).
            let after_rva = instr_rva + 6;
            patch_x86_64_disp32(
                text,
                (instr_offset_in_text + 2) as usize,
                after_rva,
                target_rva,
            )
        }
        Machine::Aarch64 => {
            patch_aarch64_adrp_ldr(text, instr_offset_in_text, instr_rva, target_rva)
        }
    }
}

/// Patch an absolute-address materialization: `lea rd, [rip+disp32]`
/// on x86_64 or `adrp xd, _; add xd, xd, #_` on aarch64. The
/// codegen records these for data-segment references and
/// function-pointer literals.
fn patch_addr_load(
    machine: Machine,
    text: &mut [u8],
    instr_offset_in_text: u32,
    text_section_rva: u32,
    target_rva: u32,
) -> Result<(), C5Error> {
    let instr_rva = text_section_rva + instr_offset_in_text;
    match machine {
        Machine::X86_64 => {
            // `lea r13, [rip+disp32]`: 7 bytes. disp32 at +3, RIP
            // at +7 (LEA_RIP32_LEN).
            let after_rva = instr_rva + (x86_64::LEA_RIP32_LEN as u32);
            patch_x86_64_disp32(
                text,
                (instr_offset_in_text + 3) as usize,
                after_rva,
                target_rva,
            )
        }
        Machine::Aarch64 => {
            patch_aarch64_adrp_add(text, instr_offset_in_text, instr_rva, target_rva)
        }
    }
}

/// Patch a direct call to a target within the same `.text`:
/// `call rel32` on x86_64 (5 bytes) or `bl rel26` on aarch64
/// (4 bytes). Both offsets are in the combined `.text`, so the
/// helper doesn't need section RVAs.
fn patch_direct_call(
    machine: Machine,
    text: &mut [u8],
    call_offset_in_text: u32,
    target_offset_in_text: u32,
) -> Result<(), C5Error> {
    match machine {
        Machine::X86_64 => {
            // rel32 = target - (call+5). The 5-byte call form ends
            // at `call_offset + 5`; rel32 fills bytes [+1..+5].
            let after = call_offset_in_text + 5;
            let delta = target_offset_in_text as i64 - after as i64;
            if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!("PE: rel32 displacement {delta} doesn't fit in 32 bits"),
                )));
            }
            let disp32 = delta as i32;
            let off = (call_offset_in_text + 1) as usize;
            text[off..off + 4].copy_from_slice(&disp32.to_le_bytes());
            Ok(())
        }
        Machine::Aarch64 => {
            // bl rel26: signed 26-bit offset measured in
            // instructions, relative to the bl instruction itself.
            let delta_bytes = target_offset_in_text as i64 - call_offset_in_text as i64;
            if delta_bytes & 3 != 0 {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!("PE: aarch64 bl delta {delta_bytes} not 4-byte aligned"),
                )));
            }
            let delta_insns = delta_bytes / 4;
            if !(-(1i64 << 25)..(1i64 << 25)).contains(&delta_insns) {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!("PE: aarch64 bl delta {delta_insns} insns out of 26-bit range"),
                )));
            }
            let word = aarch64::enc_bl(delta_insns as i32);
            let off = call_offset_in_text as usize;
            text[off..off + 4].copy_from_slice(&word.to_le_bytes());
            Ok(())
        }
    }
}

/// Write a 32-bit signed displacement at `disp32_off` so that
/// `target_rva = after_rva + disp32`. Used by the x86_64 patches.
fn patch_x86_64_disp32(
    text: &mut [u8],
    disp32_off: usize,
    after_rva: u32,
    target_rva: u32,
) -> Result<(), C5Error> {
    let delta = target_rva as i64 - after_rva as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("PE: disp32 {delta} doesn't fit in 32 bits"),
        )));
    }
    let disp32 = delta as i32;
    text[disp32_off..disp32_off + 4].copy_from_slice(&disp32.to_le_bytes());
    Ok(())
}

/// Patch an aarch64 `adrp xd, _; ldr xd, [xd, #_]` pair to load
/// the 64-bit value at `target_rva` into `xd`. The adrp's imm21
/// is the diff between the target's page and the adrp's page,
/// scaled by 4 KiB; the ldr's imm12 is the in-page byte offset
/// (scaled by 8 for a 64-bit load).
fn patch_aarch64_adrp_ldr(
    text: &mut [u8],
    adrp_offset_in_text: u32,
    adrp_rva: u32,
    target_rva: u32,
) -> Result<(), C5Error> {
    let adrp_page = (adrp_rva as u64) & !0xFFF;
    let target_page = (target_rva as u64) & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("PE: aarch64 adrp page diff {page_diff} not 4 KiB aligned"),
        )));
    }
    let imm21 = (page_diff >> 12) as i32;
    let in_page = target_rva & 0xFFF;
    if !in_page.is_multiple_of(8) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("PE: aarch64 ldr offset {in_page:#x} not 8-aligned"),
        )));
    }
    let off = adrp_offset_in_text as usize;
    let adrp_word = u32::from_le_bytes([text[off], text[off + 1], text[off + 2], text[off + 3]]);
    let ldr_word = u32::from_le_bytes([text[off + 4], text[off + 5], text[off + 6], text[off + 7]]);
    let rd = (adrp_word & 0x1F) as u8;
    let ldr_rt = (ldr_word & 0x1F) as u8;
    let ldr_rn = ((ldr_word >> 5) & 0x1F) as u8;
    let new_adrp = aarch64::enc_adrp(aarch64::Reg(rd), imm21);
    let new_ldr = aarch64::enc_ldr_imm(aarch64::Reg(ldr_rt), aarch64::Reg(ldr_rn), in_page);
    text[off..off + 4].copy_from_slice(&new_adrp.to_le_bytes());
    text[off + 4..off + 8].copy_from_slice(&new_ldr.to_le_bytes());
    Ok(())
}

/// Patch an aarch64 `adrp xd, _; add xd, xd, #_` pair so the final
/// xd holds the absolute-address-mod-image-base equivalent of
/// `target_rva` (resolved by the loader at fixed image base since
/// we don't ship base relocations).
fn patch_aarch64_adrp_add(
    text: &mut [u8],
    adrp_offset_in_text: u32,
    adrp_rva: u32,
    target_rva: u32,
) -> Result<(), C5Error> {
    let adrp_page = (adrp_rva as u64) & !0xFFF;
    let target_page = (target_rva as u64) & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("PE: aarch64 adrp page diff {page_diff} not 4 KiB aligned"),
        )));
    }
    let imm21 = (page_diff >> 12) as i32;
    let in_page = target_rva & 0xFFF;
    let off = adrp_offset_in_text as usize;
    let adrp_word = u32::from_le_bytes([text[off], text[off + 1], text[off + 2], text[off + 3]]);
    let add_word = u32::from_le_bytes([text[off + 4], text[off + 5], text[off + 6], text[off + 7]]);
    let rd = (adrp_word & 0x1F) as u8;
    let add_rd = (add_word & 0x1F) as u8;
    let add_rn = ((add_word >> 5) & 0x1F) as u8;
    let new_adrp = aarch64::enc_adrp(aarch64::Reg(rd), imm21);
    let new_add = aarch64::enc_add_imm(aarch64::Reg(add_rd), aarch64::Reg(add_rn), in_page);
    text[off..off + 4].copy_from_slice(&new_adrp.to_le_bytes());
    text[off + 4..off + 8].copy_from_slice(&new_add.to_le_bytes());
    Ok(())
}

// ----------------------------------------------------------------
// Misc.
// ----------------------------------------------------------------

fn round_up(value: u32, align: u32) -> u32 {
    (value + align - 1) & !(align - 1)
}

fn round_up_usize(value: usize, align: usize) -> usize {
    (value + align - 1) & !(align - 1)
}

fn pad_to(out: &mut Vec<u8>, target_len: usize) {
    if out.len() < target_len {
        out.resize(target_len, 0);
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn round_up_aligns_correctly() {
        assert_eq!(round_up(0, 0x200), 0);
        assert_eq!(round_up(1, 0x200), 0x200);
        assert_eq!(round_up(0x200, 0x200), 0x200);
        assert_eq!(round_up(0x201, 0x200), 0x400);
    }

    #[test]
    fn x86_64_console_entry_stub_layout_matches_expected_size() {
        let s = build_entry_stub(Machine::X86_64, false, IMAGE_SUBSYSTEM_WINDOWS_CUI);
        // 4 + 2 + 4 + 5 + 5 + 5 + 5 + 5 + 3 + 6 + 5 + 5 + 5 + 3 + 6 = 68 bytes.
        assert_eq!(s.bytes.len(), 68);
        // The stub has three patch sites: two IAT lookups (start of
        // the `call qword [rip+disp32]` instructions) and one
        // direct call to main.
        assert_eq!(s.stub_imports, vec![STUB_IMPORT_GETMAINARGS, STUB_IMPORT_EXIT]);
        assert_eq!(s.iat_patches.len(), 2);
        // __getmainargs is the first patch, exit is the second.
        assert_eq!(s.iat_patches[0].byte_offset, 38);
        assert_eq!(s.iat_patches[0].stub_import_idx, 0);
        assert_eq!(s.iat_patches[1].byte_offset, 62);
        assert_eq!(s.iat_patches[1].stub_import_idx, 1);
        assert_eq!(s.direct_call_main_offset, Some(54));
    }

    #[test]
    fn aarch64_console_entry_stub_is_one_word_per_instruction() {
        let s = build_entry_stub(Machine::Aarch64, false, IMAGE_SUBSYSTEM_WINDOWS_CUI);
        // 19 instructions * 4 bytes = 76 bytes.
        assert_eq!(s.bytes.len(), 76);
        // Patch sites point at adrp instructions / the bl. Each is
        // 4 bytes.
        assert_eq!(s.stub_imports, vec![STUB_IMPORT_GETMAINARGS, STUB_IMPORT_EXIT]);
        assert_eq!(s.iat_patches.len(), 2);
        let gma = s.iat_patches[0].byte_offset;
        let exit = s.iat_patches[1].byte_offset;
        let main = s.direct_call_main_offset.unwrap();
        assert!(gma.is_multiple_of(4));
        assert!(exit.is_multiple_of(4));
        assert!(main.is_multiple_of(4));
        // Order in the stub: __getmainargs (mid), bl main
        // (later), exit (last).
        assert!(gma < main);
        assert!(main < exit);
    }

    #[test]
    fn x86_64_gui_entry_stub_pulls_in_kernel32_imports() {
        let s = build_entry_stub(Machine::X86_64, false, IMAGE_SUBSYSTEM_WINDOWS_GUI);
        // Three IAT lookups + one direct bl WinMain. No
        // `__getmainargs` -- the GUI stub doesn't synthesize argv.
        assert_eq!(
            s.stub_imports,
            vec![
                STUB_IMPORT_GETMODULEHANDLEA,
                STUB_IMPORT_GETCOMMANDLINEA,
                STUB_IMPORT_EXIT,
            ]
        );
        assert_eq!(s.iat_patches.len(), 3);
        // Patches are in source-order: GetModuleHandleA, then
        // GetCommandLineA, then exit. The direct call to WinMain
        // sits between GetCommandLineA and exit.
        let gmh = s.iat_patches[0].byte_offset;
        let gcl = s.iat_patches[1].byte_offset;
        let main = s.direct_call_main_offset.unwrap();
        let exit = s.iat_patches[2].byte_offset;
        assert_eq!(s.iat_patches[0].stub_import_idx, 0);
        assert_eq!(s.iat_patches[1].stub_import_idx, 1);
        assert_eq!(s.iat_patches[2].stub_import_idx, 2);
        assert!(gmh < gcl);
        assert!(gcl < main);
        assert!(main < exit);
        // SW_SHOWDEFAULT immediate must land in the stub bytes -- a
        // simple search verifies the `mov r9d, 10` instruction is
        // present (41 B9 0A 00 00 00).
        let needle: &[u8] = &[0x41, 0xB9, 0x0A, 0x00, 0x00, 0x00];
        assert!(
            s.bytes.windows(needle.len()).any(|w| w == needle),
            "GUI stub missing `mov r9d, SW_SHOWDEFAULT`: bytes = {:02X?}",
            s.bytes
        );
    }

    #[test]
    fn aarch64_gui_entry_stub_pulls_in_kernel32_imports() {
        let s = build_entry_stub(Machine::Aarch64, false, IMAGE_SUBSYSTEM_WINDOWS_GUI);
        assert_eq!(
            s.stub_imports,
            vec![
                STUB_IMPORT_GETMODULEHANDLEA,
                STUB_IMPORT_GETCOMMANDLINEA,
                STUB_IMPORT_EXIT,
            ]
        );
        assert_eq!(s.iat_patches.len(), 3);
        // Stub is one instruction word per emitted op -- every
        // patch site must be 4-byte aligned (adrp / bl alignment).
        for p in &s.iat_patches {
            assert!(p.byte_offset.is_multiple_of(4));
        }
        assert!(s.direct_call_main_offset.unwrap().is_multiple_of(4));
        // Source order survives: GetModuleHandleA (0), then
        // GetCommandLineA (1), then exit (2). bl WinMain falls
        // between (1) and (2).
        let gmh = s.iat_patches[0].byte_offset;
        let gcl = s.iat_patches[1].byte_offset;
        let main = s.direct_call_main_offset.unwrap();
        let exit = s.iat_patches[2].byte_offset;
        assert!(gmh < gcl);
        assert!(gcl < main);
        assert!(main < exit);
    }

    /// Offset within the Optional Header at which DataDirectory[i]
    /// begins. The fixed-size prefix of OptionalHeader64 ends with
    /// `number_of_rva_and_sizes` (4 bytes); the array starts
    /// immediately after.
    fn data_directory_offset(optional_off: usize, idx: usize) -> usize {
        // NumberOfRvaAndSizes is at offset 108 from the start of
        // OptionalHeader64 in PE32+ (see <winnt.h>); the
        // DataDirectory array starts at offset 112.
        optional_off + 112 + idx * core::mem::size_of::<DataDirectoryEntry>()
    }

    /// Walk the Optional Header and read DataDirectory[idx]'s
    /// (rva, size) tuple.
    fn read_data_directory(bytes: &[u8], idx: usize) -> (u32, u32) {
        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let optional_off = pe_off + 4 + COFF_HEADER_SIZE;
        let entry_off = data_directory_offset(optional_off, idx);
        let rva = u32::from_le_bytes(bytes[entry_off..entry_off + 4].try_into().unwrap());
        let size = u32::from_le_bytes(bytes[entry_off + 4..entry_off + 8].try_into().unwrap());
        (rva, size)
    }

    /// PE without `_Thread_local`: TLS directory entry must be
    /// zero so the loader knows there's nothing to allocate
    /// per-thread.
    #[test]
    fn no_tls_means_zero_tls_data_directory() {
        use crate::Compiler;
        let program = Compiler::new("int main() { return 0; }".to_string())
            .compile()
            .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let (rva, size) = read_data_directory(&bytes, DATA_DIRECTORY_TLS);
        assert_eq!(rva, 0, "TLS RVA must be 0 when no TLS present");
        assert_eq!(size, 0, "TLS size must be 0 when no TLS present");
    }

    /// PE with `_Thread_local`: TLS directory entry must point
    /// at a non-empty IMAGE_TLS_DIRECTORY64 of size 40, and the
    /// directory's contents must reference plausible RVAs (well
    /// past the header, inside the .data section).
    #[test]
    fn thread_local_emits_well_formed_tls_directory_x64() {
        use crate::Compiler;
        let src = "_Thread_local int counter; int main() { counter = 42; return counter; }";
        let program = Compiler::new(super::super::super::tests::with_prelude(src))
            .compile()
            .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let (tls_rva, tls_size) = read_data_directory(&bytes, DATA_DIRECTORY_TLS);
        assert_ne!(tls_rva, 0, "expected non-zero TLS directory RVA");
        assert_eq!(
            tls_size, IMAGE_TLS_DIRECTORY64_SIZE,
            "TLS directory size must equal IMAGE_TLS_DIRECTORY64 size"
        );

        // Find the section that contains the TLS directory and
        // resolve `tls_rva` to a file offset to inspect the
        // bytes.
        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let coff_off = pe_off + 4;
        let n_sections = u16::from_le_bytes([bytes[coff_off + 2], bytes[coff_off + 3]]) as usize;
        let optional_off = coff_off + COFF_HEADER_SIZE;
        let optional_size =
            u16::from_le_bytes([bytes[coff_off + 16], bytes[coff_off + 17]]) as usize;
        let sections_off = optional_off + optional_size;
        let mut tls_file_off: Option<usize> = None;
        for i in 0..n_sections {
            let h = sections_off + i * SECTION_HEADER_SIZE;
            let v_addr = u32::from_le_bytes(bytes[h + 12..h + 16].try_into().unwrap());
            let v_size = u32::from_le_bytes(bytes[h + 8..h + 12].try_into().unwrap());
            let p_off = u32::from_le_bytes(bytes[h + 20..h + 24].try_into().unwrap());
            if tls_rva >= v_addr && tls_rva < v_addr + v_size {
                tls_file_off = Some((p_off + (tls_rva - v_addr)) as usize);
                break;
            }
        }
        let tls_file_off = tls_file_off.expect("TLS directory must lie inside a section");

        // Read the four VAs + two u32s. They must be monotonic
        // (Start <= End), Start/End within the image's address
        // range (>= ImageBase), and SizeOfZeroFill non-negative.
        let start_va =
            u64::from_le_bytes(bytes[tls_file_off..tls_file_off + 8].try_into().unwrap());
        let end_va = u64::from_le_bytes(
            bytes[tls_file_off + 8..tls_file_off + 16]
                .try_into()
                .unwrap(),
        );
        let index_va = u64::from_le_bytes(
            bytes[tls_file_off + 16..tls_file_off + 24]
                .try_into()
                .unwrap(),
        );
        let cb_va = u64::from_le_bytes(
            bytes[tls_file_off + 24..tls_file_off + 32]
                .try_into()
                .unwrap(),
        );
        let zero_fill = u32::from_le_bytes(
            bytes[tls_file_off + 32..tls_file_off + 36]
                .try_into()
                .unwrap(),
        );
        let characteristics = u32::from_le_bytes(
            bytes[tls_file_off + 36..tls_file_off + 40]
                .try_into()
                .unwrap(),
        );
        assert!(start_va >= IMAGE_BASE, "Start VA below ImageBase");
        assert!(end_va >= start_va, "End VA before Start VA");
        assert!(index_va >= IMAGE_BASE, "AddressOfIndex below ImageBase");
        assert_eq!(cb_va, 0, "AddressOfCallBacks should be NULL");
        assert_eq!(characteristics, 0, "Characteristics must be 0");
        // The single `_Thread_local int counter` is 8 bytes
        // (c5 globals are word-sized). We emit the whole TLS
        // block as init template (zeros) rather than as
        // SizeOfZeroFill, so a Windows ARM64 loader path that
        // skips empty-template directories still processes us.
        // See the long comment next to the
        // IMAGE_TLS_DIRECTORY64 emission in `write`.
        assert_eq!(
            end_va - start_va,
            8,
            "expected 8 bytes of init template (one TLS int slot)"
        );
        assert_eq!(
            zero_fill, 0,
            "expected SizeOfZeroFill = 0 (whole-data template)"
        );
    }

    /// AArch64 mirror of the x64 TLS-directory check. The
    /// per-arch lowering and the writer share the same TLS
    /// scaffolding, but the patcher walks an `adrp + ldr` pair
    /// instead of a `mov ecx, [rip+disp32]`, so it's worth
    /// confirming the directory is built the same way.
    #[test]
    fn thread_local_emits_well_formed_tls_directory_arm64() {
        use crate::Compiler;
        let src = "_Thread_local int counter; int main() { counter = 42; return counter; }";
        let program = Compiler::new(super::super::super::tests::with_prelude(src))
            .compile()
            .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::WindowsAarch64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::Aarch64,
            super::super::Target::WindowsAarch64,
        )
        .expect("write PE");
        let (tls_rva, tls_size) = read_data_directory(&bytes, DATA_DIRECTORY_TLS);
        assert_ne!(tls_rva, 0, "expected non-zero TLS directory RVA");
        assert_eq!(tls_size, IMAGE_TLS_DIRECTORY64_SIZE);
    }

    /// Read OptionalHeader.DllCharacteristics. Sits at fixed
    /// offset 70 within the PE32+ Optional Header.
    fn read_dll_characteristics(bytes: &[u8]) -> u16 {
        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let optional_off = pe_off + 4 + COFF_HEADER_SIZE;
        u16::from_le_bytes(
            bytes[optional_off + 70..optional_off + 72]
                .try_into()
                .unwrap(),
        )
    }

    /// `DYNAMIC_BASE` / `HIGH_ENTROPY_VA` stay on for every
    /// image we emit, including TLS-using ones. TLS-free
    /// images have no absolute pointers in the file (every
    /// cross-section reference is RIP-relative or PC-relative)
    /// so the loader can slide them freely without consulting
    /// any relocation table. TLS-using images carry a real
    /// `.reloc` section listing the three absolute VAs in
    /// `IMAGE_TLS_DIRECTORY64`, so the loader fixes those up
    /// after the slide too. The previous "drop DYNAMIC_BASE
    /// for TLS images" workaround is gone -- this regression
    /// test guards against re-introducing it.
    #[test]
    fn dll_characteristics_keep_aslr_flags_with_and_without_tls() {
        use crate::Compiler;
        for src in [
            "int main() { return 0; }",
            "_Thread_local int counter; int main() { counter = 1; return counter; }",
        ] {
            for target in [
                super::super::Target::WindowsX64,
                super::super::Target::WindowsAarch64,
            ] {
                let program = Compiler::new(super::super::super::tests::with_prelude(src))
                    .compile()
                    .expect("compile");
                let build = super::super::lower_for(
                    &program,
                    target,
                    super::super::NativeOptions::default(),
                )
                .expect("lower");
                let machine = match target {
                    super::super::Target::WindowsX64 => Machine::X86_64,
                    super::super::Target::WindowsAarch64 => Machine::Aarch64,
                    _ => unreachable!(),
                };
                let bytes = write(&program, &build, machine, target).expect("write PE");
                let dll_chars = read_dll_characteristics(&bytes);
                assert_ne!(
                    dll_chars & IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE,
                    0,
                    "{target:?}: DYNAMIC_BASE must always be set"
                );
                assert_ne!(
                    dll_chars & IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA,
                    0,
                    "{target:?}: HIGH_ENTROPY_VA must always be set"
                );
                assert_ne!(
                    dll_chars & IMAGE_DLLCHARACTERISTICS_NX_COMPAT,
                    0,
                    "{target:?}: NX_COMPAT must always be set"
                );
            }
        }
    }

    /// TLS-using images must carry a `.reloc` section
    /// covering the three absolute VAs inside the TLS
    /// directory; otherwise the ASLR-aware loader would write
    /// the chosen `_tls_index` to a stale address and the
    /// process would crash with STATUS_ACCESS_VIOLATION on
    /// real Windows. Confirms `DataDirectory[5]` (Base
    /// Relocation) is non-empty and the `.reloc` block has
    /// the expected three `IMAGE_REL_BASED_DIR64` entries.
    #[test]
    fn thread_local_emits_reloc_section() {
        use crate::Compiler;
        let src = "_Thread_local int counter; int main() { counter = 1; return counter; }";
        for target in [
            super::super::Target::WindowsX64,
            super::super::Target::WindowsAarch64,
        ] {
            let program = Compiler::new(super::super::super::tests::with_prelude(src))
                .compile()
                .expect("compile");
            let build =
                super::super::lower_for(&program, target, super::super::NativeOptions::default())
                    .expect("lower");
            let machine = match target {
                super::super::Target::WindowsX64 => Machine::X86_64,
                super::super::Target::WindowsAarch64 => Machine::Aarch64,
                _ => unreachable!(),
            };
            let bytes = write(&program, &build, machine, target).expect("write PE");

            // DataDirectory[5] (BaseRelocation) must point at a
            // non-empty block.
            let (reloc_rva, reloc_dir_size) = read_data_directory(&bytes, DATA_DIRECTORY_BASERELOC);
            assert_ne!(reloc_rva, 0, "{target:?}: missing .reloc directory");
            assert_eq!(
                reloc_dir_size, 16,
                "{target:?}: expected 16-byte .reloc block"
            );

            // Resolve the .reloc bytes inside the file image.
            let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
            let coff_off = pe_off + 4;
            let n_sections =
                u16::from_le_bytes([bytes[coff_off + 2], bytes[coff_off + 3]]) as usize;
            let optional_off = coff_off + COFF_HEADER_SIZE;
            let optional_size =
                u16::from_le_bytes([bytes[coff_off + 16], bytes[coff_off + 17]]) as usize;
            let sections_off = optional_off + optional_size;
            let mut reloc_file_off: Option<usize> = None;
            for i in 0..n_sections {
                let h = sections_off + i * SECTION_HEADER_SIZE;
                let v_addr = u32::from_le_bytes(bytes[h + 12..h + 16].try_into().unwrap());
                let v_size = u32::from_le_bytes(bytes[h + 8..h + 12].try_into().unwrap());
                let p_off = u32::from_le_bytes(bytes[h + 20..h + 24].try_into().unwrap());
                if reloc_rva >= v_addr && reloc_rva < v_addr + v_size {
                    reloc_file_off = Some((p_off + (reloc_rva - v_addr)) as usize);
                    break;
                }
            }
            let reloc_file_off = reloc_file_off.expect(".reloc must lie inside a section");

            // Header: VirtualAddress (page RVA), SizeOfBlock = 16.
            let size_of_block = u32::from_le_bytes(
                bytes[reloc_file_off + 4..reloc_file_off + 8]
                    .try_into()
                    .unwrap(),
            );
            assert_eq!(size_of_block, 16, "{target:?}: SizeOfBlock should be 16");
            // Three IMAGE_REL_BASED_DIR64 entries (type=10) at
            // u16 positions 4..16. The fourth slot is a no-op
            // ABSOLUTE pad.
            for slot in 0..3 {
                let off = reloc_file_off + 8 + slot * 2;
                let entry = u16::from_le_bytes([bytes[off], bytes[off + 1]]);
                let entry_type = (entry >> 12) & 0xF;
                assert_eq!(
                    entry_type, 10,
                    "{target:?}: entry {slot} must be IMAGE_REL_BASED_DIR64"
                );
            }
            let pad_off = reloc_file_off + 8 + 3 * 2;
            let pad = u16::from_le_bytes([bytes[pad_off], bytes[pad_off + 1]]);
            assert_eq!(pad, 0, "{target:?}: trailing pad entry must be ABSOLUTE");
        }
    }

    /// TLS-free images must NOT carry a `.reloc` section --
    /// they have no absolute pointers, so a `.reloc` would be
    /// dead weight.
    #[test]
    fn no_tls_means_no_reloc_section() {
        use crate::Compiler;
        let program = Compiler::new("int main() { return 0; }".to_string())
            .compile()
            .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let (rva, size) = read_data_directory(&bytes, DATA_DIRECTORY_BASERELOC);
        assert_eq!(rva, 0, "TLS-free image must not advertise .reloc RVA");
        assert_eq!(size, 0, "TLS-free image must not advertise .reloc size");
    }

    /// Read COFF Characteristics from the binary.
    fn read_coff_characteristics(bytes: &[u8]) -> u16 {
        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        u16::from_le_bytes(bytes[pe_off + 22..pe_off + 24].try_into().unwrap())
    }

    /// Shared-library output (`OutputKind::SharedLibrary`)
    /// flips the `IMAGE_FILE_DLL` characteristic and adds an
    /// `IMAGE_EXPORT_DIRECTORY` for each `#pragma export`
    /// symbol. Verify both: the characteristic bit, the
    /// non-empty data-directory entry, and a well-formed
    /// directory header (NumberOfFunctions / NumberOfNames
    /// match the source's export count).
    #[test]
    fn dll_output_emits_export_directory_and_dll_flag() {
        use crate::Compiler;
        let src = "
            int answer() { return 42; }
            #pragma export(answer)
            int main() { return 0; }
        ";
        for (machine, target) in [
            (Machine::X86_64, super::super::Target::WindowsX64),
            (Machine::Aarch64, super::super::Target::WindowsAarch64),
        ] {
            let program =
                Compiler::with_target(super::super::super::tests::with_prelude(src), target)
                    .compile()
                    .expect("compile");
            let build = super::super::lower_for(
                &program,
                target,
                super::super::NativeOptions::new().with_shared_library(),
            )
            .expect("lower");
            let bytes = write(&program, &build, machine, target).expect("write PE");

            let chars = read_coff_characteristics(&bytes);
            assert_ne!(
                chars & IMAGE_FILE_DLL,
                0,
                "{machine:?}: IMAGE_FILE_DLL must be set for shared-library output"
            );

            let (export_rva, export_size) = read_data_directory(&bytes, DATA_DIRECTORY_EXPORT);
            assert_ne!(export_rva, 0, "{machine:?}: missing Export Directory");
            assert!(
                export_size >= 40,
                "{machine:?}: Export Directory must be at least 40 bytes (the IMAGE_EXPORT_DIRECTORY header)"
            );

            // Resolve `.edata` to a file offset and read the
            // header's NumberOfFunctions / NumberOfNames.
            let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
            let coff_off = pe_off + 4;
            let n_sections =
                u16::from_le_bytes([bytes[coff_off + 2], bytes[coff_off + 3]]) as usize;
            let optional_off = coff_off + COFF_HEADER_SIZE;
            let optional_size =
                u16::from_le_bytes([bytes[coff_off + 16], bytes[coff_off + 17]]) as usize;
            let sections_off = optional_off + optional_size;
            let mut edata_file_off: Option<usize> = None;
            for i in 0..n_sections {
                let h = sections_off + i * SECTION_HEADER_SIZE;
                let v_addr = u32::from_le_bytes(bytes[h + 12..h + 16].try_into().unwrap());
                let v_size = u32::from_le_bytes(bytes[h + 8..h + 12].try_into().unwrap());
                let p_off = u32::from_le_bytes(bytes[h + 20..h + 24].try_into().unwrap());
                if export_rva >= v_addr && export_rva < v_addr + v_size {
                    edata_file_off = Some((p_off + (export_rva - v_addr)) as usize);
                    break;
                }
            }
            let edata_file_off = edata_file_off.expect(".edata must lie inside a section");
            let n_funcs = u32::from_le_bytes(
                bytes[edata_file_off + 20..edata_file_off + 24]
                    .try_into()
                    .unwrap(),
            );
            let n_names = u32::from_le_bytes(
                bytes[edata_file_off + 24..edata_file_off + 28]
                    .try_into()
                    .unwrap(),
            );
            assert_eq!(
                n_funcs, 1,
                "{machine:?}: NumberOfFunctions must equal the export count"
            );
            assert_eq!(
                n_names, 1,
                "{machine:?}: NumberOfNames must equal the export count"
            );
        }
    }

    /// DllMain stubs returning TRUE: x86_64 is
    /// `mov eax, 1; ret` (`B8 01 00 00 00 C3`); aarch64 is
    /// `mov w0, #1; ret` (4-byte `enc_movz` + 4-byte
    /// `enc_ret(x30)`). Without this stub the loader's
    /// `DLL_PROCESS_ATTACH` callback would jump into
    /// arbitrary `build.text` bytes; verify each architecture
    /// produces the right shape.
    #[test]
    fn dllmain_stub_returns_true() {
        // DLL stubs don't depend on subsystem -- they're consumed
        // by the loader's `DllMain` entry path, not `WinMain` /
        // `main`. Pass console as the canonical default.
        let s_x64 = build_entry_stub(Machine::X86_64, true, IMAGE_SUBSYSTEM_WINDOWS_CUI);
        assert_eq!(
            s_x64.bytes,
            vec![0xB8, 0x01, 0x00, 0x00, 0x00, 0xC3],
            "x64 DllMain must be `mov eax, 1; ret`"
        );
        assert!(s_x64.stub_imports.is_empty());
        assert!(s_x64.iat_patches.is_empty());
        assert!(s_x64.direct_call_main_offset.is_none());

        let s_arm = build_entry_stub(Machine::Aarch64, true, IMAGE_SUBSYSTEM_WINDOWS_CUI);
        // 2 instructions x 4 bytes.
        assert_eq!(s_arm.bytes.len(), 8);
        // First word: movz w0, #1 => 0x52800020 (movz is the
        // 32-bit form because Rd is x0 / w0 with sf=0; we
        // emit the 64-bit movz with imm=1, low lane, which
        // also clears the upper lanes -- semantically the
        // same single bit).
        let first = u32::from_le_bytes([
            s_arm.bytes[0],
            s_arm.bytes[1],
            s_arm.bytes[2],
            s_arm.bytes[3],
        ]);
        let second = u32::from_le_bytes([
            s_arm.bytes[4],
            s_arm.bytes[5],
            s_arm.bytes[6],
            s_arm.bytes[7],
        ]);
        // `enc_movz(x0, 1, 0)` lower bits: rd=0, imm16=1,
        // hw=0 => 0xD2800020.
        assert_eq!(first, 0xD280_0020, "expected `movz x0, #1`");
        // `enc_ret(x30)` => 0xD65F03C0.
        assert_eq!(second, 0xD65F_03C0, "expected `ret` against x30");
    }

    /// `AddressOfEntryPoint` lives at Optional Header offset
    /// 16; `BaseOfCode` at offset 20. PE32+ keeps both as
    /// 4-byte unsigned RVAs.
    fn read_entry_point_and_base_of_code(bytes: &[u8]) -> (u32, u32) {
        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let optional_off = pe_off + 4 + COFF_HEADER_SIZE;
        let entry = u32::from_le_bytes(
            bytes[optional_off + 16..optional_off + 20]
                .try_into()
                .unwrap(),
        );
        let base = u32::from_le_bytes(
            bytes[optional_off + 20..optional_off + 24]
                .try_into()
                .unwrap(),
        );
        (entry, base)
    }

    /// Default `--shared` build (no user `DllMain`):
    /// `AddressOfEntryPoint` must equal `BaseOfCode` because
    /// the boilerplate `mov eax, 1; ret` stub sits at the
    /// start of `.text` and is what the loader calls on
    /// `DLL_PROCESS_ATTACH`.
    #[test]
    fn dll_without_user_dllmain_uses_stub_at_base_of_code() {
        use crate::Compiler;
        let src = "
            int answer() { return 42; }
            #pragma export(answer)
        ";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::new().with_shared_library(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let (entry, base) = read_entry_point_and_base_of_code(&bytes);
        assert_eq!(
            entry, base,
            "without a user DllMain the stub sits at the start of .text \
             and AddressOfEntryPoint == BaseOfCode"
        );
    }

    /// User-defined `DllMain` overrides the stub: the writer
    /// must point `AddressOfEntryPoint` at the user's body
    /// inside `build.text` rather than at the start of
    /// `.text`. With the stub suppressed, `build.text` lands
    /// at offset 0 of `.text`, so the expected entry is
    /// `BaseOfCode + bytecode_to_native[dllmain_pc]`. A
    /// secondary `dummy` function before `DllMain` guarantees
    /// `bytecode_to_native[dllmain_pc] > 0` so the assertion
    /// is genuinely distinguishing the user-DllMain branch
    /// from the no-user-DllMain branch.
    #[test]
    fn dll_with_user_dllmain_skips_stub() {
        use crate::Compiler;
        let src = "
            int dummy(int x) { return x; }
            int DllMain(int hinst, int reason, int reserved) {
                return dummy(1);
            }
        ";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let dllmain_pc = program
            .dllmain_pc
            .expect("compiler must record dllmain_pc when source defines DllMain");
        let build = super::super::lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::new().with_shared_library(),
        )
        .expect("lower");
        let dllmain_native_off = build.bytecode_to_native[dllmain_pc] as u32;
        assert!(
            dllmain_native_off > 0,
            "with `dummy` defined before DllMain, the lowering \
             should leave DllMain past offset 0 in build.text \
             (got {dllmain_native_off:#x})"
        );
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let (entry, base) = read_entry_point_and_base_of_code(&bytes);
        assert_eq!(
            entry,
            base + dllmain_native_off,
            "AddressOfEntryPoint must target the user's DllMain at \
             BaseOfCode + bytecode_to_native[dllmain_pc]"
        );
    }

    /// `#pragma subsystem(windows)` flips the optional-header
    /// Subsystem field to `IMAGE_SUBSYSTEM_WINDOWS_GUI` *and*
    /// routes the entry through the WinMain-shaped stub, so the
    /// import table must carry `kernel32!GetModuleHandleA` +
    /// `kernel32!GetCommandLineA` even though the user source
    /// doesn't `#pragma binding` either of them. Without this
    /// path the demo at `demos/gui_hello/hello_win32.c` would
    /// receive `nShowCmd = 0` (SW_HIDE) -- the bug this commit
    /// fixes -- because the console stub leaves `r9` zeroed
    /// across the call to the entry function.
    #[test]
    fn gui_subsystem_emits_winmain_stub_imports() {
        use crate::Compiler;
        let src = "
            #pragma subsystem(windows)
            #pragma entrypoint(WinMain)
            int WinMain(long hinst, long prev, char *cmd, int show) {
                (void)hinst; (void)prev; (void)cmd;
                return show;
            }
        ";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");

        // 1) Subsystem field. OptionalHeader64.Subsystem lives at
        //    offset 68 within the optional header.
        let pe_off = u32::from_le_bytes(bytes[60..64].try_into().unwrap()) as usize;
        let optional_off = pe_off + 4 + COFF_HEADER_SIZE;
        let subsystem = u16::from_le_bytes([bytes[optional_off + 68], bytes[optional_off + 69]]);
        assert_eq!(
            subsystem, IMAGE_SUBSYSTEM_WINDOWS_GUI,
            "`#pragma subsystem(windows)` must set Subsystem to WINDOWS_GUI"
        );

        // 2) GUI-stub imports must appear as ASCII strings in the
        //    image (the import-name table writes them verbatim).
        //    msvcrt!__getmainargs must not appear -- the GUI stub
        //    doesn't synthesize argv.
        let contains = |needle: &str| -> bool {
            bytes
                .windows(needle.len())
                .any(|w| w == needle.as_bytes())
        };
        assert!(
            contains("GetModuleHandleA"),
            "GUI subsystem must import kernel32!GetModuleHandleA"
        );
        assert!(
            contains("GetCommandLineA"),
            "GUI subsystem must import kernel32!GetCommandLineA"
        );
        assert!(
            !contains("__getmainargs"),
            "GUI subsystem must NOT pull in msvcrt!__getmainargs (no argc/argv needed)"
        );
    }

    /// Executables keep `IMAGE_FILE_DLL` cleared and have no
    /// Export Directory. Mirrors the TLS / DYNAMIC_BASE
    /// guards.
    #[test]
    fn executable_output_keeps_dll_flag_clear() {
        use crate::Compiler;
        let program = Compiler::new("int main() { return 0; }".to_string())
            .compile()
            .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::WindowsX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::X86_64,
            super::super::Target::WindowsX64,
        )
        .expect("write PE");
        let chars = read_coff_characteristics(&bytes);
        assert_eq!(
            chars & IMAGE_FILE_DLL,
            0,
            "executables must not advertise IMAGE_FILE_DLL"
        );
        let (rva, size) = read_data_directory(&bytes, DATA_DIRECTORY_EXPORT);
        assert_eq!(rva, 0, "executables must not advertise an Export Directory");
        assert_eq!(size, 0);
    }

    /// End-to-end format check: build an aarch64 Windows PE for a
    /// trivial program and verify the on-disk byte layout claims
    /// the right architecture. Doesn't execute the binary; the
    /// runtime tests that need an aarch64 Windows host live in
    /// `c5::tests::native_pe_arm64`.
    #[test]
    fn aarch64_pe_format_is_well_formed() {
        use crate::Compiler;
        let program = Compiler::new("int main() { return 42; }".to_string())
            .compile()
            .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::WindowsAarch64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(
            &program,
            &build,
            Machine::Aarch64,
            super::super::Target::WindowsAarch64,
        )
        .expect("write PE");

        // DOS magic.
        assert_eq!(&bytes[0..2], b"MZ");
        // PE offset stored at byte 60.
        let pe_off = u32::from_le_bytes([bytes[60], bytes[61], bytes[62], bytes[63]]) as usize;
        assert_eq!(&bytes[pe_off..pe_off + 4], b"PE\0\0");
        // COFF Machine field is right after the PE signature.
        let machine_field = u16::from_le_bytes([bytes[pe_off + 4], bytes[pe_off + 5]]);
        assert_eq!(machine_field, IMAGE_FILE_MACHINE_ARM64);
        // Optional header magic confirms PE32+.
        let optional_off = pe_off + 4 + COFF_HEADER_SIZE;
        let optional_magic = u16::from_le_bytes([bytes[optional_off], bytes[optional_off + 1]]);
        assert_eq!(optional_magic, PE32_PLUS_MAGIC);
    }
}

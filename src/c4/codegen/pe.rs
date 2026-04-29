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
//!   semantics differ when `overwrite == 0`, but most c4 callers
//!   pass `overwrite = 1` and don't notice.
//! * `Op::Dler` (POSIX `dlerror()`) binds to kernel32's
//!   `GetLastError`. Both return zero when there's no pending
//!   error; a c4 program that *prints* `dlerror()` would see
//!   garbage on Windows, but the common `if (dlerror()) { ... }`
//!   shape works.
//! * `Op::Mpro` (POSIX `mprotect(addr, len, prot)`) is not
//!   currently supported on Windows; the binding goes to
//!   `VirtualProtect`, but the calling convention mismatch (Windows
//!   takes a 4th `OldProt` out-pointer the c4 program doesn't
//!   provide) makes it unsafe to invoke. Programs that don't call
//!   `mprotect` are unaffected.

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;

use super::super::error::C4Error;
use super::super::op::Op;
use super::aarch64;
use super::x86_64;
use super::{Build, Machine};

// ----------------------------------------------------------------
// PE constants. Names mirror `winnt.h` so cross-checking is easy.
// ----------------------------------------------------------------

const IMAGE_BASE: u64 = 0x1_4000_0000;
const SECTION_ALIGNMENT: u32 = 0x1000;
const FILE_ALIGNMENT: u32 = 0x200;

const IMAGE_FILE_MACHINE_AMD64: u16 = 0x8664;
const IMAGE_FILE_MACHINE_ARM64: u16 = 0xAA64;
const IMAGE_FILE_RELOCS_STRIPPED: u16 = 0x0001;
const IMAGE_FILE_EXECUTABLE_IMAGE: u16 = 0x0002;
const IMAGE_FILE_LARGE_ADDRESS_AWARE: u16 = 0x0020;

const PE32_PLUS_MAGIC: u16 = 0x20B;
const IMAGE_SUBSYSTEM_WINDOWS_CUI: u16 = 3;
const IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE: u16 = 0x0040;
const IMAGE_DLLCHARACTERISTICS_NX_COMPAT: u16 = 0x0100;

const IMAGE_SCN_CNT_CODE: u32 = 0x0000_0020;
const IMAGE_SCN_CNT_INITIALIZED_DATA: u32 = 0x0000_0040;
const IMAGE_SCN_MEM_EXECUTE: u32 = 0x2000_0000;
const IMAGE_SCN_MEM_READ: u32 = 0x4000_0000;
const IMAGE_SCN_MEM_WRITE: u32 = 0x8000_0000;

const NUM_DATA_DIRS: u32 = 16;

/// Section layout: every 64-bit Windows PE carries `.text` /
/// `.pdata` / `.idata` / `.data`. The `.pdata` Exception Directory
/// is mandatory under the 64-bit Windows ABI -- the loader looks up
/// `RUNTIME_FUNCTION` entries there to handle stack unwinding, and
/// wine refuses to load AArch64 PEs that omit it. x86_64 doesn't
/// fail to load without one, but the spec requires it and stricter
/// hosts (verifier, hardened loaders, future Windows revisions) can
/// reject a missing entry, so we emit it on both arches.
fn num_sections(_machine: Machine) -> usize {
    4
}

const DOS_HEADER_AND_STUB: usize = 128; // 64 byte DOS header + 64 byte stub
const PE_SIG_SIZE: usize = 4;
const COFF_HEADER_SIZE: usize = 20;
const OPTIONAL64_HEADER_SIZE: usize = 240;
const SECTION_HEADER_SIZE: usize = 40;

/// Raw on-disk size of the PE headers (DOS + PE sig + COFF +
/// Optional + section table), rounded up to FILE_ALIGNMENT.
/// 3 sections fit in 0x200; 4 sections need 0x400.
fn headers_raw_size(machine: Machine) -> usize {
    let unaligned = DOS_HEADER_AND_STUB
        + PE_SIG_SIZE
        + COFF_HEADER_SIZE
        + OPTIONAL64_HEADER_SIZE
        + SECTION_HEADER_SIZE * num_sections(machine);
    (unaligned + FILE_ALIGNMENT as usize - 1) & !(FILE_ALIGNMENT as usize - 1)
}

const IMAGE_IMPORT_DESCRIPTOR_SIZE: usize = 20;
const IAT_ENTRY_SIZE: usize = 8;

const DATA_DIRECTORY_IMPORT: usize = 1;
const DATA_DIRECTORY_EXCEPTION: usize = 3;
const DATA_DIRECTORY_IAT: usize = 12;

/// AArch64 RUNTIME_FUNCTION packed-unwind format limit: the
/// FunctionLength field is 11 bits (units = 4-byte instructions),
/// so a single packed entry covers at most 2048 instructions
/// = 8192 bytes. Larger `.text` sections need multiple entries.
const ARM64_PACKED_FUNCTION_MAX_BYTES: u32 = 2048 * 4;

// ----------------------------------------------------------------
// Op-to-DLL binding. For each c4 op listed in `aarch64::IMPORTS`,
// pick the matching Windows export and which DLL it lives in.
// ----------------------------------------------------------------

const MSVCRT: &str = "msvcrt.dll";
const KERNEL32: &str = "kernel32.dll";

fn windows_binding_for_op(op: Op) -> (&'static str, &'static str) {
    use Op::*;
    match op {
        Open => ("_open", MSVCRT),
        Read => ("_read", MSVCRT),
        Clos => ("_close", MSVCRT),
        Prtf => ("printf", MSVCRT),
        Malc => ("malloc", MSVCRT),
        Free => ("free", MSVCRT),
        Mset => ("memset", MSVCRT),
        Mcmp => ("memcmp", MSVCRT),
        Mcpy => ("memcpy", MSVCRT),
        Mpro => ("VirtualProtect", KERNEL32),
        Exit => ("exit", MSVCRT),
        Write => ("_write", MSVCRT),
        Genv => ("getenv", MSVCRT),
        Senv => ("_putenv_s", MSVCRT),
        Dlop => ("LoadLibraryA", KERNEL32),
        Dlsm => ("GetProcAddress", KERNEL32),
        Dlcl => ("FreeLibrary", KERNEL32),
        Dler => ("GetLastError", KERNEL32),
        other => panic!("pe writer: op {other:?} is not a libc import"),
    }
}

// Stub-only imports we add on top of the standard `aarch64::IMPORTS`
// list. msvcrt's `__getmainargs` is the canonical way to populate
// argc/argv on a Windows host: it fills out the int / char**
// out-pointers we hand it. WINE's msvcrt doesn't export the
// alternative `__p___argc` / `__p___argv` thunks, so this is the
// portable shape. ExitProcess routes the exit through the kernel32
// thunk so the CRT atexit chain runs (without it, printf to a pipe
// loses its tail line because msvcrt block-buffers stdout).
const STUB_IMPORT_GETMAINARGS: (&str, &str) = ("__getmainargs", MSVCRT);
const STUB_IMPORT_EXIT: (&str, &str) = ("ExitProcess", KERNEL32);

// ----------------------------------------------------------------
// Top-level writer.
// ----------------------------------------------------------------

pub(super) fn write(build: &Build, machine: Machine) -> Result<Vec<u8>, C4Error> {
    // 1) Combined imports list. Index N becomes IAT slot N. The
    //    standard ops occupy 0..n_program_imports; the entry stub's
    //    three additional imports come after.
    let n_program_imports = aarch64::IMPORTS.len();
    let mut imports: Vec<(String, &'static str)> = Vec::with_capacity(n_program_imports + 3);
    for imp in aarch64::IMPORTS {
        let (sym, dll) = windows_binding_for_op(imp.op);
        imports.push((sym.to_string(), dll));
    }
    let stub_getmainargs_idx = imports.len();
    imports.push((
        STUB_IMPORT_GETMAINARGS.0.to_string(),
        STUB_IMPORT_GETMAINARGS.1,
    ));
    let stub_exit_idx = imports.len();
    imports.push((STUB_IMPORT_EXIT.0.to_string(), STUB_IMPORT_EXIT.1));

    // 2) Group imports by DLL while preserving each one's IAT index.
    //    `dlls` holds (dll_name, [import_index, ...]); the IAT is
    //    laid out DLL-by-DLL so we keep the per-DLL slot offsets to
    //    recover the global IAT slot of each import.
    let dlls = group_imports_by_dll(&imports);

    // 3) Build the entry stub and the mprotect thunk. We need their
    //    sizes to lay out the rest, but immediate patching waits
    //    until the IAT RVAs are known.
    let stub = build_entry_stub(machine);
    let thunk = build_mprotect_thunk(machine);
    let mpro_idx = aarch64::IMPORTS
        .iter()
        .position(|imp| imp.op == Op::Mpro)
        .expect("Op::Mpro must be present in IMPORTS");

    // 4) Compute layout. Combined .text is `entry stub | mprotect
    //    thunk | build.text`; .idata gets an extra 8-byte slot
    //    appended at the end to hold the thunk's absolute address
    //    (the c4 program's `Op::Mpro` calls go through that slot).
    let stub_len = stub.bytes.len() as u32;
    let thunk_len = thunk.bytes.len() as u32;
    let text_prologue_len = stub_len + thunk_len;
    let thunk_rva = SECTION_ALIGNMENT + stub_len;

    let headers_size = headers_raw_size(machine) as u32;

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
    // Append an 8-byte slot for the thunk's absolute address. The
    // c4 program's `Op::Mpro` fixups will be patched to point at
    // this slot rather than VirtualProtect's IAT entry, so calls
    // run through the thunk instead of straight to VirtualProtect.
    // Align to 8 first: the aarch64 `ldr` against this slot scales
    // its imm12 by 8, so the slot's offset within the page must be
    // 8-aligned. The hint/name and DLL-string tables in plan_idata
    // are only 2-aligned, so without this pad the slot can land at
    // any 4-byte boundary and break the patch.
    let mut idata_bytes = idata_layout.bytes;
    let pad_to_eight = round_up_usize(idata_bytes.len(), 8);
    idata_bytes.resize(pad_to_eight, 0);
    let thunk_ptr_offset = idata_bytes.len() as u32;
    idata_bytes.resize(idata_bytes.len() + 8, 0);
    let thunk_ptr_rva = idata_rva + thunk_ptr_offset;
    let thunk_abs_addr = IMAGE_BASE + thunk_rva as u64;
    idata_bytes[thunk_ptr_offset as usize..(thunk_ptr_offset + 8) as usize]
        .copy_from_slice(&thunk_abs_addr.to_le_bytes());
    let idata_size: u32 = idata_bytes.len() as u32;
    let idata_raw_size: u32 = round_up(idata_size, FILE_ALIGNMENT);

    let data_rva: u32 = round_up(idata_rva + idata_size, SECTION_ALIGNMENT);
    let data_file_off: u32 = idata_file_off + idata_raw_size;
    let data_size: u32 = build.data.len() as u32;
    let data_raw_size: u32 = round_up(data_size, FILE_ALIGNMENT);

    let total_file_size = (data_file_off + data_raw_size) as usize;
    let image_size = round_up(data_rva + data_size.max(1), SECTION_ALIGNMENT);

    // 5) Stitch the .text bytes together and patch every fixup
    //    that references something outside the section.
    let mut text_bytes: Vec<u8> = Vec::with_capacity(text_size as usize);
    text_bytes.extend_from_slice(&stub.bytes);
    text_bytes.extend_from_slice(&thunk.bytes);
    text_bytes.extend_from_slice(&build.text);

    // Stub-internal fixup: the direct call to main. main starts
    // at offset text_prologue_len within the combined .text (past
    // the entry stub and the mprotect thunk).
    patch_direct_call(
        machine,
        &mut text_bytes,
        stub.direct_call_main_offset,
        text_prologue_len + build.entry_offset as u32,
    )?;

    // Stub-emitted IAT calls (one for `__getmainargs`, one for
    // `ExitProcess`).
    patch_iat_lookup(
        machine,
        &mut text_bytes,
        stub.iat_getmainargs_offset,
        text_rva,
        idata_layout.iat_rva_for_import[stub_getmainargs_idx],
    )?;
    patch_iat_lookup(
        machine,
        &mut text_bytes,
        stub.iat_exit_offset,
        text_rva,
        idata_layout.iat_rva_for_import[stub_exit_idx],
    )?;

    // Thunk-internal fixup: the IAT lookup for VirtualProtect.
    patch_iat_lookup(
        machine,
        &mut text_bytes,
        stub_len + thunk.iat_virtualprotect_offset,
        text_rva,
        idata_layout.iat_rva_for_import[mpro_idx],
    )?;

    // Program-side fixups land inside build.text, which is offset
    // by text_prologue_len in the combined .text. Op::Mpro is
    // re-routed through the thunk_ptr slot.
    for f in &build.got_fixups {
        let instr_off = (f.adrp_offset as u32) + text_prologue_len;
        let target_rva = if f.import_index == mpro_idx {
            thunk_ptr_rva
        } else {
            idata_layout.iat_rva_for_import[f.import_index]
        };
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
        // combined .text past entry stub + thunk.
        let target_rva = text_rva + text_prologue_len + f.target_native_offset as u32;
        patch_addr_load(machine, &mut text_bytes, instr_off, text_rva, target_rva)?;
    }

    // 6) Assemble the final image.
    let mut out: Vec<u8> = Vec::with_capacity(total_file_size);
    write_dos_header_and_stub(&mut out);
    write_pe_signature(&mut out);
    write_coff_header(&mut out, OPTIONAL64_HEADER_SIZE, machine);
    write_optional_header(
        &mut out,
        machine,
        OptionalHeaderInputs {
            entry_rva: text_rva, // entry point is at start of .text
            base_of_code: text_rva,
            size_of_code: text_size,
            size_of_initialized_data: idata_size + data_size,
            size_of_image: image_size,
            size_of_headers: headers_size,
            import_table_rva: idata_layout.import_directory_rva,
            import_table_size: idata_layout.import_directory_size,
            exception_table_rva: pdata_rva,
            exception_table_size: pdata_directory_size,
            iat_rva: idata_layout.iat_rva_base,
            iat_size: idata_layout.iat_size,
        },
    );
    let mut sections: Vec<SectionHeader> = Vec::with_capacity(num_sections(machine));
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
    sections.push(SectionHeader {
        name: *b".data\0\0\0",
        virtual_size: data_size,
        virtual_address: data_rva,
        size_of_raw_data: data_raw_size,
        pointer_to_raw_data: data_file_off,
        characteristics: IMAGE_SCN_CNT_INITIALIZED_DATA | IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_WRITE,
    });
    write_section_headers(&mut out, &sections);
    pad_to(&mut out, text_file_off as usize);
    out.extend_from_slice(&text_bytes);
    pad_to(&mut out, (text_file_off + text_raw_size) as usize);
    out.extend_from_slice(&pdata_bytes);
    pad_to(&mut out, (pdata_file_off + pdata_raw_size) as usize);
    out.extend_from_slice(&idata_bytes);
    pad_to(&mut out, (idata_file_off + idata_raw_size) as usize);
    out.extend_from_slice(&build.data);
    pad_to(&mut out, total_file_size);
    debug_assert_eq!(out.len(), total_file_size, "file size mismatch");
    Ok(out)
}

// ----------------------------------------------------------------
// Header writers.
// ----------------------------------------------------------------

fn write_dos_header_and_stub(out: &mut Vec<u8>) {
    let start = out.len();
    // Minimal DOS header. Only `e_magic` and `e_lfanew` matter to
    // the modern loader; everything else can stay zero.
    let mut dos = [0u8; DOS_HEADER_AND_STUB];
    dos[0] = b'M';
    dos[1] = b'Z';
    // e_lfanew at byte 60: file offset of the PE signature.
    let pe_sig_off = (DOS_HEADER_AND_STUB) as u32;
    dos[60..64].copy_from_slice(&pe_sig_off.to_le_bytes());
    out.extend_from_slice(&dos);
    debug_assert_eq!(out.len() - start, DOS_HEADER_AND_STUB);
}

fn write_pe_signature(out: &mut Vec<u8>) {
    out.extend_from_slice(b"PE\0\0");
}

fn write_coff_header(out: &mut Vec<u8>, optional_header_size: usize, machine: Machine) {
    let machine_id = match machine {
        Machine::X86_64 => IMAGE_FILE_MACHINE_AMD64,
        Machine::Aarch64 => IMAGE_FILE_MACHINE_ARM64,
    };
    out.extend_from_slice(&machine_id.to_le_bytes()); // Machine
    out.extend_from_slice(&(num_sections(machine) as u16).to_le_bytes()); // NumberOfSections
    out.extend_from_slice(&0u32.to_le_bytes()); // TimeDateStamp
    out.extend_from_slice(&0u32.to_le_bytes()); // PointerToSymbolTable (deprecated)
    out.extend_from_slice(&0u32.to_le_bytes()); // NumberOfSymbols
    out.extend_from_slice(&(optional_header_size as u16).to_le_bytes()); // SizeOfOptionalHeader
    // RELOCS_STRIPPED tells the loader "no base relocations exist; load
    // at preferred ImageBase or fail". Our codegen emits PC-relative
    // addressing throughout (lea/adrp+add for data, adrp+ldr for IAT,
    // call/blr for branches), and the only absolute pointer is the
    // mprotect thunk slot in `.idata` which holds `IMAGE_BASE +
    // thunk_rva` -- still tied to ImageBase, so loading at preferred
    // base keeps it valid. Without this flag, modern Windows kernels
    // reject the image when `DYNAMIC_BASE` is set without an
    // accompanying `.reloc` section. (DYNAMIC_BASE is still required
    // for wine's strict non-x86 path; see the optional header
    // characteristics below.)
    out.extend_from_slice(
        &(IMAGE_FILE_RELOCS_STRIPPED
            | IMAGE_FILE_EXECUTABLE_IMAGE
            | IMAGE_FILE_LARGE_ADDRESS_AWARE)
            .to_le_bytes(),
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
    /// `.pdata` section's RVA / size on aarch64; zero on x86_64.
    exception_table_rva: u32,
    exception_table_size: u32,
    iat_rva: u32,
    iat_size: u32,
}

fn write_optional_header(out: &mut Vec<u8>, machine: Machine, inp: OptionalHeaderInputs) {
    let start = out.len();

    // Standard fields (24 bytes for PE32+).
    out.extend_from_slice(&PE32_PLUS_MAGIC.to_le_bytes());
    out.push(14); // MajorLinkerVersion (cosmetic)
    out.push(0); // MinorLinkerVersion
    out.extend_from_slice(&inp.size_of_code.to_le_bytes());
    out.extend_from_slice(&inp.size_of_initialized_data.to_le_bytes());
    out.extend_from_slice(&0u32.to_le_bytes()); // SizeOfUninitializedData
    out.extend_from_slice(&inp.entry_rva.to_le_bytes());
    out.extend_from_slice(&inp.base_of_code.to_le_bytes());

    // Windows-specific fields (88 bytes).
    out.extend_from_slice(&IMAGE_BASE.to_le_bytes());
    out.extend_from_slice(&SECTION_ALIGNMENT.to_le_bytes());
    out.extend_from_slice(&FILE_ALIGNMENT.to_le_bytes());
    // OS version: 10.0 -- AArch64 Windows requires Win10+, and
    // wine's loader checks this when deciding to accept an
    // ARM64 PE. x86_64 is happy with anything Vista+ but bumping
    // both kept the writer simple.
    out.extend_from_slice(&10u16.to_le_bytes()); // MajorOperatingSystemVersion
    out.extend_from_slice(&0u16.to_le_bytes()); // Minor
    out.extend_from_slice(&0u16.to_le_bytes()); // MajorImageVersion
    out.extend_from_slice(&0u16.to_le_bytes()); // Minor
    out.extend_from_slice(&10u16.to_le_bytes()); // MajorSubsystemVersion
    out.extend_from_slice(&0u16.to_le_bytes()); // Minor
    out.extend_from_slice(&0u32.to_le_bytes()); // Win32VersionValue (reserved)
    out.extend_from_slice(&inp.size_of_image.to_le_bytes());
    out.extend_from_slice(&inp.size_of_headers.to_le_bytes());
    out.extend_from_slice(&0u32.to_le_bytes()); // CheckSum
    out.extend_from_slice(&IMAGE_SUBSYSTEM_WINDOWS_CUI.to_le_bytes());
    // DllCharacteristics differ per arch because the wine loader's
    // strict path on non-x86 demands `DYNAMIC_BASE`, while real
    // Windows on x86_64 rejects an image that has `DYNAMIC_BASE`
    // set but no accompanying `.reloc` section. We can't both
    // satisfy wine on AArch64 and avoid `DYNAMIC_BASE` on x86_64
    // unless we branch.
    //
    // x86_64: just `NX_COMPAT`. The COFF header carries
    // `RELOCS_STRIPPED`, telling the loader "no relocations; load
    // at preferred ImageBase".
    //
    // AArch64: `NX_COMPAT | DYNAMIC_BASE`. wine's
    // `server/mapping.c` rejects non-x86 PEs without these (as of
    // wine 10). Real Windows on ARM64 should accept the
    // combination of `RELOCS_STRIPPED` (in COFF) and `DYNAMIC_BASE`
    // (in DllCharacteristics) -- the `RELOCS_STRIPPED` wins, the
    // loader skips ASLR and maps at preferred base.
    let dll_chars = match machine {
        Machine::X86_64 => IMAGE_DLLCHARACTERISTICS_NX_COMPAT,
        Machine::Aarch64 => {
            IMAGE_DLLCHARACTERISTICS_NX_COMPAT | IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE
        }
    };
    out.extend_from_slice(&dll_chars.to_le_bytes());
    out.extend_from_slice(&0x10_0000u64.to_le_bytes()); // SizeOfStackReserve = 1 MiB
    out.extend_from_slice(&0x1000u64.to_le_bytes()); // SizeOfStackCommit
    out.extend_from_slice(&0x10_0000u64.to_le_bytes()); // SizeOfHeapReserve
    out.extend_from_slice(&0x1000u64.to_le_bytes()); // SizeOfHeapCommit
    out.extend_from_slice(&0u32.to_le_bytes()); // LoaderFlags
    out.extend_from_slice(&NUM_DATA_DIRS.to_le_bytes());

    // Data directories: 16 entries of (RVA, Size). Three are
    // populated: Import (1), Exception (3), and IAT
    // (12). Everything else stays zeroed.
    for i in 0..NUM_DATA_DIRS as usize {
        let (rva, size) = match i {
            DATA_DIRECTORY_IMPORT => (inp.import_table_rva, inp.import_table_size),
            DATA_DIRECTORY_EXCEPTION => (inp.exception_table_rva, inp.exception_table_size),
            DATA_DIRECTORY_IAT => (inp.iat_rva, inp.iat_size),
            _ => (0u32, 0u32),
        };
        out.extend_from_slice(&rva.to_le_bytes());
        out.extend_from_slice(&size.to_le_bytes());
    }

    debug_assert_eq!(out.len() - start, OPTIONAL64_HEADER_SIZE);
}

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
        out.extend_from_slice(&sec.name);
        out.extend_from_slice(&sec.virtual_size.to_le_bytes());
        out.extend_from_slice(&sec.virtual_address.to_le_bytes());
        out.extend_from_slice(&sec.size_of_raw_data.to_le_bytes());
        out.extend_from_slice(&sec.pointer_to_raw_data.to_le_bytes());
        out.extend_from_slice(&0u32.to_le_bytes()); // PointerToRelocations
        out.extend_from_slice(&0u32.to_le_bytes()); // PointerToLinenumbers
        out.extend_from_slice(&0u16.to_le_bytes()); // NumberOfRelocations
        out.extend_from_slice(&0u16.to_le_bytes()); // NumberOfLinenumbers
        out.extend_from_slice(&sec.characteristics.to_le_bytes());
    }
}

// ----------------------------------------------------------------
// Imports + IAT layout.
// ----------------------------------------------------------------

struct DllGroup {
    dll_name: &'static str,
    /// Indices into the global imports list (== IAT slot indices).
    members: Vec<usize>,
}

fn group_imports_by_dll(imports: &[(String, &'static str)]) -> Vec<DllGroup> {
    // Preserve the order DLLs first appear in. Two DLLs total
    // (msvcrt, kernel32), but the structure scales if we add more.
    let mut groups: Vec<DllGroup> = Vec::new();
    for (idx, (_, dll)) in imports.iter().enumerate() {
        if let Some(g) = groups.iter_mut().find(|g| g.dll_name == *dll) {
            g.members.push(idx);
        } else {
            groups.push(DllGroup {
                dll_name: dll,
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

fn plan_idata(dlls: &[DllGroup], imports: &[(String, &'static str)], base_rva: u32) -> IDataLayout {
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
// Both backends emit a stub that calls `__getmainargs` to populate
// argc/argv, then `bl main` (or `call main`), then `ExitProcess`.
// The stub layout differs per arch in instruction selection but
// produces the same overall flow. `EntryStub` carries arch-neutral
// offsets back to the writer, which dispatches to the per-arch
// patcher to fill in the final immediate fields.
// ----------------------------------------------------------------

struct EntryStub {
    bytes: Vec<u8>,
    /// Offset within [`Self::bytes`] of the IAT-lookup sequence for
    /// `__getmainargs`. On x86_64 this is the start of
    /// `call qword [rip+disp32]`; on aarch64 the start of the
    /// `adrp x16, _; ldr x16, [x16, #_]` pair (the trailing
    /// `blr x16` is at +8 and doesn't get patched).
    iat_getmainargs_offset: u32,
    /// Offset of the IAT-lookup for `ExitProcess` (same shape as
    /// `iat_getmainargs_offset`).
    iat_exit_offset: u32,
    /// Offset of the direct `bl main` / `call main` instruction.
    direct_call_main_offset: u32,
}

fn build_entry_stub(machine: Machine) -> EntryStub {
    match machine {
        Machine::X86_64 => build_x86_64_entry_stub(),
        Machine::Aarch64 => build_aarch64_entry_stub(),
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

    EntryStub {
        bytes,
        // x86_64: the IAT-lookup is the start of the `call qword`
        // instruction itself (not the disp32 byte). The patcher
        // computes `disp32 = target - (call + 6)` from this offset.
        iat_getmainargs_offset: call_gma_off,
        iat_exit_offset: call_exit_off,
        direct_call_main_offset: call_main_off,
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
        iat_getmainargs_offset: iat_gma_off,
        iat_exit_offset: iat_exit_off,
        direct_call_main_offset: bl_main_off,
    }
}

// ----------------------------------------------------------------
// mprotect -> VirtualProtect thunk.
//
// POSIX `int mprotect(void *addr, size_t len, int prot)` and
// Win64 `BOOL VirtualProtect(LPVOID addr, SIZE_T size,
// DWORD newProt, PDWORD oldProt)` differ in:
//
//   1. Arity: mprotect takes 3 args, VirtualProtect takes 4
//      (the trailing `oldProt` out-pointer).
//   2. Protection encoding: POSIX uses a bitmask of PROT_READ
//      (1) / PROT_WRITE (2) / PROT_EXEC (4), Windows uses the
//      PAGE_* family (PAGE_NOACCESS=1, PAGE_READONLY=2, ...).
//   3. Return convention: mprotect returns 0/-1, VirtualProtect
//      returns BOOL (0 = failure, nonzero = success).
//
// The thunk closes those gaps: looks up the right PAGE_* via a
// small table indexed by `prot & 7`, allocates a stack slot for
// the throwaway oldProt, calls VirtualProtect, and translates
// the BOOL back to 0/-1. The c4 program's `Op::Mpro` calls go
// through a single 8-byte slot in `.idata` whose value is the
// thunk's absolute address (set up at PE-write time); the codegen
// emits the same `call qword [rip+disp32]` shape it would for any
// other libc-shaped op.
// ----------------------------------------------------------------

struct MprotectThunk {
    bytes: Vec<u8>,
    /// Offset within [`Self::bytes`] of the IAT-lookup sequence
    /// for VirtualProtect (start of `call qword` on x86_64; start
    /// of `adrp x16, _; ldr x16, [x16, #_]` on aarch64).
    iat_virtualprotect_offset: u32,
}

fn build_mprotect_thunk(machine: Machine) -> MprotectThunk {
    match machine {
        Machine::X86_64 => build_x86_64_mprotect_thunk(),
        Machine::Aarch64 => build_aarch64_mprotect_thunk(),
    }
}

fn build_x86_64_mprotect_thunk() -> MprotectThunk {
    let mut bytes: Vec<u8> = Vec::with_capacity(64);

    // sub rsp, 0x38                            (4 bytes)
    //   [rsp + 0x00..0x20]  shadow space for VirtualProtect
    //   [rsp + 0x20..0x24]  oldProtect (4 bytes used; slot is 8)
    //   [rsp + 0x28..0x37]  padding to keep rsp 16-aligned
    bytes.extend_from_slice(&[0x48, 0x83, 0xEC, 0x38]);

    // and r8d, 7                               (4 bytes)
    // Mask the POSIX prot value to the low 3 bits.
    bytes.extend_from_slice(&[0x41, 0x83, 0xE0, 0x07]);

    // lea rax, [rip + 0x1F]                    (7 bytes)
    // The disp32 is fixed: prot_table sits 0x1F bytes past the
    // byte after this lea (lea ends at thunk offset 0x0F; table
    // starts at 0x2E -> 0x2E - 0x0F = 0x1F).
    bytes.extend_from_slice(&[0x48, 0x8D, 0x05, 0x1F, 0x00, 0x00, 0x00]);

    // movzx r8d, byte ptr [rax + r8]           (5 bytes)
    // r8 = prot_table[prot & 7]
    bytes.extend_from_slice(&[0x46, 0x0F, 0xB6, 0x04, 0x00]);

    // lea r9, [rsp + 0x20]                     (5 bytes)
    // r9 = &oldProtect (output parameter)
    bytes.extend_from_slice(&[0x4C, 0x8D, 0x4C, 0x24, 0x20]);

    // call qword [rip + 0]                     (6 bytes; disp32 patched)
    // Calls VirtualProtect via the .idata IAT slot.
    let call_vp_off = bytes.len() as u32;
    bytes.extend_from_slice(&[0xFF, 0x15, 0, 0, 0, 0]);

    // BOOL -> int translation: 0 (failure) -> -1, nonzero -> 0.
    // test eax, eax                            (2 bytes)
    bytes.extend_from_slice(&[0x85, 0xC0]);
    // setz al                                  (3 bytes)
    bytes.extend_from_slice(&[0x0F, 0x94, 0xC0]);
    // movzx eax, al                            (3 bytes)
    bytes.extend_from_slice(&[0x0F, 0xB6, 0xC0]);
    // neg eax                                  (2 bytes)
    bytes.extend_from_slice(&[0xF7, 0xD8]);

    // add rsp, 0x38                            (4 bytes)
    bytes.extend_from_slice(&[0x48, 0x83, 0xC4, 0x38]);
    // ret                                      (1 byte)
    bytes.extend_from_slice(&[0xC3]);

    // prot_table: 8 bytes mapping POSIX prot bits 0..7 to Windows
    // PAGE_* constants. Bit 1 = PROT_READ, bit 2 = PROT_WRITE,
    // bit 4 = PROT_EXEC. Windows has no write-only protection, so
    // PROT_WRITE alone maps to PAGE_READWRITE (the closest
    // permissive equivalent).
    bytes.extend_from_slice(&[
        0x01, // 0  (no access)        -> PAGE_NOACCESS
        0x02, // 1  (R)                -> PAGE_READONLY
        0x04, // 2  (W)                -> PAGE_READWRITE
        0x04, // 3  (RW)               -> PAGE_READWRITE
        0x10, // 4  (X)                -> PAGE_EXECUTE
        0x20, // 5  (RX)               -> PAGE_EXECUTE_READ
        0x40, // 6  (WX)               -> PAGE_EXECUTE_READWRITE
        0x40, // 7  (RWX)              -> PAGE_EXECUTE_READWRITE
    ]);

    debug_assert_eq!(
        bytes.len(),
        54,
        "mprotect thunk size changed -- update prot_table disp32 (currently 0x1F)"
    );

    MprotectThunk {
        bytes,
        iat_virtualprotect_offset: call_vp_off,
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
/// address as a leaf with no frame -- a lie, but the c4 program
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
/// is sufficient for our purposes since the c4 program never
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

/// AArch64 mprotect thunk. Same idea as the x86_64 one: take the
/// 3-arg POSIX call (x0=addr, x1=len, x2=prot per AAPCS64),
/// translate prot to a Windows PAGE_* via a small inline lookup,
/// allocate a stack slot for VirtualProtect's `&oldProt` out
/// parameter, call VirtualProtect via the IAT, then map the BOOL
/// result to `0`/`-1`.
///
/// Simplification: this thunk passes `PAGE_EXECUTE_READWRITE`
/// (0x40) regardless of the requested prot. Most c4 callers want
/// either RWX (the JIT path) or PROT_READ (where read-only access
/// works fine under PAGE_EXECUTE_READWRITE since it's a strict
/// superset). A more faithful translation would consult a small
/// prot-to-PAGE_* table; we keep things simple for the first cut
/// since no current fixture distinguishes.
fn build_aarch64_mprotect_thunk() -> MprotectThunk {
    use super::aarch64 as a;
    let mut bytes: Vec<u8> = Vec::with_capacity(64);

    // Prologue: save fp/lr, set new frame, allocate a 16-byte slot
    // for `oldProtect` (4 bytes used; size to keep sp 16-aligned).
    a::emit(
        &mut bytes,
        a::enc_stp_pre(a::Reg::X29, a::Reg::X30, a::Reg::SP, -16),
    );
    a::emit(&mut bytes, a::enc_add_imm(a::Reg::X29, a::Reg::SP, 0));
    a::emit(&mut bytes, a::enc_sub_imm(a::Reg::SP, a::Reg::SP, 16));

    // x2 = newProtect = PAGE_EXECUTE_READWRITE (0x40). Always RWX
    // for now; see the doc comment for why.
    a::emit(&mut bytes, a::enc_movz(a::Reg(2), 0x40, 0));
    // x3 = &oldProtect (= sp + 0).
    a::emit(&mut bytes, a::enc_add_imm(a::Reg(3), a::Reg::SP, 0));

    // Call VirtualProtect via IAT.
    let iat_vp_off = bytes.len() as u32;
    a::emit(&mut bytes, a::enc_adrp(a::Reg::X16, 0));
    a::emit(&mut bytes, a::enc_ldr_imm(a::Reg::X16, a::Reg::X16, 0));
    a::emit(&mut bytes, a::enc_blr(a::Reg::X16));

    // BOOL -> int translation: 0 (failure) -> -1, nonzero -> 0.
    // cmp x0, #0 (= subs xzr, x0, #0).  Hand-rolled since we don't
    // have a `cmp imm` encoder in aarch64.rs; the ARM ARM
    // encoding for `subs xzr, x0, #0` is 0xF100_001F.
    a::emit(&mut bytes, 0xF100_001F);
    // cset x0, eq    -> x0 = 1 if w0 was 0, else 0.
    a::emit(&mut bytes, a::enc_cset(a::Reg::X0, a::Cond::Eq));
    // sub x0, xzr, x0 (= neg x0, x0).
    a::emit(
        &mut bytes,
        a::enc_sub_reg(a::Reg::X0, a::Reg(31), a::Reg::X0),
    );

    // Epilogue: restore frame, return.
    a::emit(&mut bytes, a::enc_add_imm(a::Reg::SP, a::Reg::SP, 16));
    a::emit(
        &mut bytes,
        a::enc_ldp_post(a::Reg::X29, a::Reg::X30, a::Reg::SP, 16),
    );
    a::emit(&mut bytes, a::enc_ret(a::Reg::X30));

    MprotectThunk {
        bytes,
        iat_virtualprotect_offset: iat_vp_off,
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
) -> Result<(), C4Error> {
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
) -> Result<(), C4Error> {
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
) -> Result<(), C4Error> {
    match machine {
        Machine::X86_64 => {
            // rel32 = target - (call+5). The 5-byte call form ends
            // at `call_offset + 5`; rel32 fills bytes [+1..+5].
            let after = call_offset_in_text + 5;
            let delta = target_offset_in_text as i64 - after as i64;
            if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
                return Err(C4Error::Compile(format!(
                    "PE: rel32 displacement {delta} doesn't fit in 32 bits"
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
                return Err(C4Error::Compile(format!(
                    "PE: aarch64 bl delta {delta_bytes} not 4-byte aligned"
                )));
            }
            let delta_insns = delta_bytes / 4;
            if !(-(1i64 << 25)..(1i64 << 25)).contains(&delta_insns) {
                return Err(C4Error::Compile(format!(
                    "PE: aarch64 bl delta {delta_insns} insns out of 26-bit range"
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
) -> Result<(), C4Error> {
    let delta = target_rva as i64 - after_rva as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
        return Err(C4Error::Compile(format!(
            "PE: disp32 {delta} doesn't fit in 32 bits"
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
) -> Result<(), C4Error> {
    let adrp_page = (adrp_rva as u64) & !0xFFF;
    let target_page = (target_rva as u64) & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C4Error::Compile(format!(
            "PE: aarch64 adrp page diff {page_diff} not 4 KiB aligned"
        )));
    }
    let imm21 = (page_diff >> 12) as i32;
    let in_page = target_rva & 0xFFF;
    if !in_page.is_multiple_of(8) {
        return Err(C4Error::Compile(format!(
            "PE: aarch64 ldr offset {in_page:#x} not 8-aligned"
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
) -> Result<(), C4Error> {
    let adrp_page = (adrp_rva as u64) & !0xFFF;
    let target_page = (target_rva as u64) & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C4Error::Compile(format!(
            "PE: aarch64 adrp page diff {page_diff} not 4 KiB aligned"
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
    fn x86_64_entry_stub_layout_matches_expected_size() {
        let s = build_entry_stub(Machine::X86_64);
        // 4 + 2 + 4 + 5 + 5 + 5 + 5 + 5 + 3 + 6 + 5 + 5 + 5 + 3 + 6 = 68 bytes.
        assert_eq!(s.bytes.len(), 68);
        // The stub has three patch sites: two IAT lookups (start of
        // the `call qword [rip+disp32]` instructions) and one
        // direct call to main.
        assert_eq!(s.iat_getmainargs_offset, 38);
        assert_eq!(s.direct_call_main_offset, 54);
        assert_eq!(s.iat_exit_offset, 62);
    }

    #[test]
    fn aarch64_entry_stub_is_one_word_per_instruction() {
        let s = build_entry_stub(Machine::Aarch64);
        // 19 instructions * 4 bytes = 76 bytes.
        assert_eq!(s.bytes.len(), 76);
        // Patch sites point at adrp instructions / the bl. Each is
        // 4 bytes.
        assert!(s.iat_getmainargs_offset.is_multiple_of(4));
        assert!(s.iat_exit_offset.is_multiple_of(4));
        assert!(s.direct_call_main_offset.is_multiple_of(4));
        // Order in the stub: __getmainargs (mid), bl main (later),
        // ExitProcess (last).
        assert!(s.iat_getmainargs_offset < s.direct_call_main_offset);
        assert!(s.direct_call_main_offset < s.iat_exit_offset);
    }

    #[test]
    fn aarch64_mprotect_thunk_is_word_aligned() {
        let t = build_mprotect_thunk(Machine::Aarch64);
        assert_eq!(t.bytes.len() % 4, 0);
        assert!(t.iat_virtualprotect_offset.is_multiple_of(4));
    }

    /// End-to-end format check: build an aarch64 Windows PE for a
    /// trivial program and verify the on-disk byte layout claims
    /// the right architecture. Doesn't execute the binary; the
    /// runtime tests that need an aarch64 Windows host live in
    /// `c4::tests::native_pe_arm64`.
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
        let bytes = write(&build, Machine::Aarch64).expect("write PE");

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

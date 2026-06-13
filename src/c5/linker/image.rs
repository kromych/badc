//! Final-image writer for a [`MergedNative`].
//!
//! Consumes the merged sections produced by
//! [`super::link::link_native_objects`] (plus per-arch
//! PLT trampolines from `emit_*_plt`) and emits a runnable
//! ELF64 file for Linux. Two paths:
//!
//!   * Static: `merged.imports` is empty. The writer drops two
//!     PT_LOAD segments (R+X .text, R+W .data) and a per-arch
//!     `_start` stub appended after `.text` that calls the
//!     named entry function and invokes `exit_group` via
//!     syscall.
//!
//!   * Dynamic: `merged.imports` is non-empty. The writer adds
//!     a PT_INTERP (`/lib64/ld-linux-x86-64.so.2` /
//!     `/lib/ld-linux-aarch64.so.1`), a `.dynstr` / `.dynsym` /
//!     `.rela.plt` triple for the imports, a `.got.plt` of one
//!     slot per import (DT_BIND_NOW eager resolution -- the
//!     dynamic linker writes the resolved address into each
//!     slot at startup, no PLT0 stub needed), and a PT_DYNAMIC
//!     directing the linker at the binding tables. PLT
//!     trampolines emitted by `emit_*_plt` are patched to
//!     dereference their `.got.plt` slot.
//!
//! Output is little-endian; both supported architectures
//! (x86_64, aarch64) are LE on Linux.

#![cfg(feature = "std")]

use alloc::format;
use alloc::vec::Vec;

use crate::c5::error::C5Error;

use super::link::MergedNative;
use super::object::{NativeMachine, NativeSymSection};

const ELF_MAGIC: [u8; 4] = [0x7f, b'E', b'L', b'F'];
const EI_CLASS_64: u8 = 2;
const EI_DATA_LSB: u8 = 1;
const EI_VERSION_CURRENT: u8 = 1;
const EI_OSABI_SYSV: u8 = 0;

const ET_EXEC: u16 = 2;
const EM_X86_64: u16 = 62;
const EM_AARCH64: u16 = 183;
const EV_CURRENT: u32 = 1;

const PT_LOAD: u32 = 1;
const PT_DYNAMIC: u32 = 2;
const PT_INTERP: u32 = 3;
const PT_PHDR: u32 = 6;

const PF_X: u32 = 1;
const PF_W: u32 = 2;
const PF_R: u32 = 4;

// Dynamic-section tags (Elf64_Dyn::d_tag).
const DT_NULL: u64 = 0;
const DT_NEEDED: u64 = 1;
const DT_PLTRELSZ: u64 = 2;
const DT_PLTGOT: u64 = 3;
const DT_STRTAB: u64 = 5;
const DT_SYMTAB: u64 = 6;
const DT_STRSZ: u64 = 10;
const DT_SYMENT: u64 = 11;
const DT_BIND_NOW: u64 = 24;
const DT_PLTREL: u64 = 20;
const DT_JMPREL: u64 = 23;
const DT_FLAGS: u64 = 30;

const DF_BIND_NOW: u64 = 0x8;

// Reloc kinds the dynamic linker resolves at startup.
const R_X86_64_JUMP_SLOT: u32 = 7;
const R_AARCH64_JUMP_SLOT: u32 = 1026;

// Symbol-table bookkeeping for `.dynsym`.
const STB_GLOBAL: u8 = 1;
const STT_FUNC: u8 = 2;
const SHN_UNDEF: u16 = 0;

const ELF64_SYM_SIZE: u64 = 24;
const ELF64_RELA_SIZE: u64 = 24;
const ELF64_DYN_SIZE: u64 = 16;

const ELF_HEADER_SIZE: u16 = 64;
const PROGRAM_HEADER_SIZE: u16 = 56;

/// Standard Linux executable load base. `ld -no-pie` plants
/// the program here by default; matching it keeps `objdump -d`
/// addresses recognisable next to a `gcc -static` reference.
const BASE_ADDR: u64 = 0x400000;
const PAGE_SIZE: u64 = 0x1000;

/// Emit an ELF64 ET_EXEC executable for `merged`. Dispatches
/// to the static or dynamic writer depending on whether the
/// merged image carries libc / libdl / ... imports.
pub fn write_executable_elf64(merged: &MergedNative, entry_name: &str) -> Result<Vec<u8>, C5Error> {
    if merged.imports.is_empty() {
        write_static_elf64(merged, entry_name)
    } else {
        write_dynamic_elf64(merged, entry_name)
    }
}

fn write_static_elf64(merged: &MergedNative, entry_name: &str) -> Result<Vec<u8>, C5Error> {
    // Resolve the entry function's text-segment offset.
    let entry_sym = merged.defined.get(entry_name).ok_or_else(|| {
        link_err(&format!(
            "entry symbol `{entry_name}` not defined in any input object"
        ))
    })?;
    if !matches!(entry_sym.section, NativeSymSection::Text) {
        return Err(link_err(&format!(
            "entry symbol `{entry_name}` is not in .text (found {:?})",
            entry_sym.section
        )));
    }
    let entry_text_offset = entry_sym.value as usize;

    // The start stub lands at the tail of the text segment;
    // the writer's job is to call `entry_name` and then exit
    // via `exit_group(rax)`. Both the call placeholder and
    // the syscall sequence are per-arch.
    //
    // aarch64 requires every instruction fetch to be 4-byte
    // aligned, and the kernel raises SIGBUS BUS_ADRALN on the
    // first fetch if the entry point isn't. `merged.text` ends
    // after BUILD_INFO bytes the codegen appends and may sit
    // at any offset, so align before recording the stub's
    // entry point. 4 bytes is also the right alignment for
    // x86_64's `xor ebp, ebp; ...` start stub.
    // If the embedded runtime defined `__c5_exit`, route the
    // stub's tail through it (and through libc's `exit`)
    // instead of the raw `exit_group` syscall. libc's `exit`
    // runs the atexit chain (stdio fflush etc.) before the
    // kernel reaps the process.
    let exit_text_offset = merged.defined.get("__c5_exit").and_then(|sym| {
        matches!(sym.section, NativeSymSection::Text).then_some(sym.value as usize)
    });

    let mut text = merged.text.clone();
    while text.len() & 3 != 0 {
        text.push(0);
    }
    let stub_text_offset = text.len();
    let stub_bytes = start_stub_bytes(
        merged.machine,
        stub_text_offset,
        entry_text_offset,
        exit_text_offset,
    );
    text.extend_from_slice(&stub_bytes);

    let machine = match merged.machine {
        NativeMachine::X86_64 => EM_X86_64,
        NativeMachine::Aarch64 => EM_AARCH64,
    };

    // Layout: every load segment lands on its own page; the
    // ELF header + program headers sit at the start of the
    // first PT_LOAD so the kernel's mmap covers them too.
    let phnum: u16 = 2;
    let phoff: u64 = ELF_HEADER_SIZE as u64;
    let headers_size: u64 = phoff + (PROGRAM_HEADER_SIZE as u64) * (phnum as u64);

    let text_file_off: u64 = headers_size;
    let text_file_size: u64 = text.len() as u64;
    let text_vaddr: u64 = BASE_ADDR + text_file_off;
    let entry_vaddr: u64 = BASE_ADDR + headers_size + stub_text_offset as u64;

    // Place the data segment on the next page boundary. The
    // segment's file offset uses the same page-aligned bump so
    // `p_vaddr & (PAGE_SIZE - 1) == p_offset & (PAGE_SIZE - 1)`
    // -- the kernel requires that congruence for executable
    // mmap.
    let data_file_off: u64 = page_align(text_file_off + text_file_size);
    let data_vaddr: u64 = page_align(text_vaddr + text_file_size) + PAGE_SIZE;
    let data_file_size: u64 = merged.data.len() as u64;
    let data_mem_size: u64 = data_file_size + merged.bss_size as u64;

    // Resolve every parked data-ref reloc against the now-
    // known runtime data vmaddr. PLT-bound entries should not
    // appear in the static path (we already errored on
    // non-empty `imports` above), so only data sentinels
    // remain.
    patch_data_refs(
        &mut text,
        text_vaddr,
        data_vaddr,
        &merged.pending_imports,
        merged.machine,
    )?;

    // Apply absolute data-segment relocations. `int *gp =
    // &storage;` records a slot at `slot_offset` in `.data`
    // that needs `data_vaddr + target_offset` written into it.
    // Function-pointer initializers (`static const VTable v =
    // { .fp = my_close };`) carry `target_section == Text` and
    // resolve against `text_vaddr` instead.
    let mut data = merged.data.clone();
    patch_data_abs_relocs(&mut data, text_vaddr, data_vaddr, &merged.data_abs_relocs)?;

    let mut out: Vec<u8> = Vec::with_capacity(
        headers_size as usize + text.len() + merged.data.len() + PAGE_SIZE as usize,
    );

    // ELF identification.
    out.extend_from_slice(&ELF_MAGIC);
    out.push(EI_CLASS_64);
    out.push(EI_DATA_LSB);
    out.push(EI_VERSION_CURRENT);
    out.push(EI_OSABI_SYSV);
    out.push(0); // EI_ABIVERSION
    out.extend_from_slice(&[0u8; 7]); // EI_PAD

    // ELF header (e_type onwards).
    write_u16(&mut out, ET_EXEC);
    write_u16(&mut out, machine);
    write_u32(&mut out, EV_CURRENT);
    write_u64(&mut out, entry_vaddr);
    write_u64(&mut out, phoff);
    write_u64(&mut out, 0); // e_shoff -- no section headers
    write_u32(&mut out, 0); // e_flags
    write_u16(&mut out, ELF_HEADER_SIZE);
    write_u16(&mut out, PROGRAM_HEADER_SIZE);
    write_u16(&mut out, phnum);
    write_u16(&mut out, 0); // e_shentsize
    write_u16(&mut out, 0); // e_shnum
    write_u16(&mut out, 0); // e_shstrndx
    debug_assert_eq!(out.len() as u64, phoff);

    // PT_LOAD .text (R+X). The first page also covers the ELF
    // header + program headers, so map the segment from file
    // offset 0; the kernel maps the full page anyway.
    write_phdr(
        &mut out,
        PT_LOAD,
        PF_R | PF_X,
        0,
        BASE_ADDR,
        BASE_ADDR,
        text_file_off + text_file_size,
        text_file_off + text_file_size,
        PAGE_SIZE,
    );

    // PT_LOAD .data (R+W). filesz = data only; memsz adds bss.
    write_phdr(
        &mut out,
        PT_LOAD,
        PF_R | PF_W,
        data_file_off,
        data_vaddr,
        data_vaddr,
        data_file_size,
        data_mem_size,
        PAGE_SIZE,
    );

    // .text bytes -- already placed at `text_file_off` by the
    // header sequence above (the header counted forward to
    // exactly that point).
    debug_assert_eq!(out.len() as u64, text_file_off);
    out.extend_from_slice(&text);

    // Pad to the data segment's file offset, then the data
    // bytes themselves. The padding zeros are mapped read-only
    // by the kernel as part of the text PT_LOAD's filesz, but
    // they will never be reached at runtime (entry is `_start`
    // which jumps into the user body).
    while (out.len() as u64) < data_file_off {
        out.push(0);
    }
    out.extend_from_slice(&data);

    Ok(out)
}

/// Apply each `R_*_64` data-segment relocation to `data` in
/// place. The slot at `slot_offset` is overwritten with the
/// little-endian u64 `base + target_offset`, picking
/// `text_vaddr` or `data_vaddr` per the reloc's
/// `target_section`. Bss targets sit past `.data` at runtime,
/// hence the `data.len()` shift.
fn patch_data_abs_relocs(
    data: &mut [u8],
    text_vaddr: u64,
    data_vaddr: u64,
    relocs: &[super::link::DataAbsReloc],
) -> Result<(), C5Error> {
    use crate::c5::linker::object::NativeSymSection;
    for r in relocs {
        let slot = r.slot_offset as usize;
        if slot + 8 > data.len() {
            return Err(err(&format!(
                "data abs reloc at slot 0x{:x} extends past .data (len 0x{:x})",
                slot,
                data.len()
            )));
        }
        let value = match r.target_section {
            NativeSymSection::Data => data_vaddr + r.target_offset,
            NativeSymSection::Text => text_vaddr + r.target_offset,
            NativeSymSection::Bss => data_vaddr + data.len() as u64 + r.target_offset,
            other => {
                return Err(err(&format!(
                    "data abs reloc at slot 0x{:x} has unsupported target section {:?}",
                    slot, other,
                )));
            }
        };
        data[slot..slot + 8].copy_from_slice(&value.to_le_bytes());
    }
    Ok(())
}

/// Page-align `n` up to the next multiple of [`PAGE_SIZE`].
fn page_align(n: u64) -> u64 {
    (n + (PAGE_SIZE - 1)) & !(PAGE_SIZE - 1)
}

fn write_u16(out: &mut Vec<u8>, v: u16) {
    out.extend_from_slice(&v.to_le_bytes());
}

fn write_u32(out: &mut Vec<u8>, v: u32) {
    out.extend_from_slice(&v.to_le_bytes());
}

fn write_u64(out: &mut Vec<u8>, v: u64) {
    out.extend_from_slice(&v.to_le_bytes());
}

#[allow(clippy::too_many_arguments)]
fn write_phdr(
    out: &mut Vec<u8>,
    p_type: u32,
    p_flags: u32,
    p_offset: u64,
    p_vaddr: u64,
    p_paddr: u64,
    p_filesz: u64,
    p_memsz: u64,
    p_align: u64,
) {
    write_u32(out, p_type);
    write_u32(out, p_flags);
    write_u64(out, p_offset);
    write_u64(out, p_vaddr);
    write_u64(out, p_paddr);
    write_u64(out, p_filesz);
    write_u64(out, p_memsz);
    write_u64(out, p_align);
}

/// Emit the `_start` body for `machine`. The stub lands at
/// `stub_text_offset` within the merged text and reaches the
/// user entry symbol at `entry_text_offset`. Linux argc /
/// argv conventions: `argc` is at `[rsp]`, `argv` at
/// `[rsp + 8]`. The stub picks up both, calls the entry, and
/// invokes `exit_group(rax)` via syscall.
fn start_stub_bytes(
    machine: NativeMachine,
    stub_text_offset: usize,
    entry_text_offset: usize,
    exit_text_offset: Option<usize>,
) -> Vec<u8> {
    match machine {
        NativeMachine::X86_64 => {
            x86_64_start_stub(stub_text_offset, entry_text_offset, exit_text_offset)
        }
        NativeMachine::Aarch64 => {
            aarch64_start_stub(stub_text_offset, entry_text_offset, exit_text_offset)
        }
    }
}

fn x86_64_start_stub(
    stub_text_offset: usize,
    entry_text_offset: usize,
    exit_text_offset: Option<usize>,
) -> Vec<u8> {
    // xor    ebp, ebp                                ; clear frame ptr
    // mov    rdi, [rsp]                              ; argc
    // lea    rsi, [rsp + 8]                          ; argv
    // call   <entry>                                 ; rel32
    // mov    rdi, rax                                ; exit code
    // -- if `__c5_exit` is in the merged image --
    //   call <__c5_exit>                             ; rel32 -> libc exit via lib helper
    //   ud2                                          ; unreachable
    // -- otherwise (no libc; static path) --
    //   mov  eax, 0xe7                               ; sys_exit_group = 231
    //   syscall
    //
    // AMD64 SysV ABI 3.4.1 requires `(%rsp + 8) % 16 == 0` at the
    // callee entry point, i.e. rsp must be 16-aligned at the
    // moment of `call`. The kernel hands `_start` an rsp that is
    // already 16-aligned, so reading argc / argv via memory loads
    // (rather than the rsp-shifting `pop rdi`) leaves the
    // alignment intact for the `call entry` below. Without this
    // contract any SSE-aligned spill inside main's libc calls
    // (movaps / movdqa / ...) faults on real Intel hardware
    // (QEMU emulation tolerates the misalignment).
    let mut buf: Vec<u8> = Vec::with_capacity(28);
    buf.extend_from_slice(&[0x31, 0xed]); // xor ebp, ebp
    buf.extend_from_slice(&[0x48, 0x8b, 0x3c, 0x24]); // mov rdi, [rsp]
    buf.extend_from_slice(&[0x48, 0x8d, 0x74, 0x24, 0x08]); // lea rsi, [rsp + 8]
    let call_entry_start = stub_text_offset + buf.len();
    let call_entry_end = call_entry_start + 5;
    let rel_entry = (entry_text_offset as i64) - (call_entry_end as i64);
    buf.push(0xe8);
    buf.extend_from_slice(&(rel_entry as i32).to_le_bytes());
    buf.extend_from_slice(&[0x48, 0x89, 0xc7]); // mov rdi, rax
    if let Some(exit_off) = exit_text_offset {
        let call_exit_start = stub_text_offset + buf.len();
        let call_exit_end = call_exit_start + 5;
        let rel_exit = (exit_off as i64) - (call_exit_end as i64);
        buf.push(0xe8);
        buf.extend_from_slice(&(rel_exit as i32).to_le_bytes());
        buf.extend_from_slice(&[0x0f, 0x0b]); // ud2 -- unreachable
    } else {
        buf.extend_from_slice(&[0xb8, 0xe7, 0x00, 0x00, 0x00]); // mov eax, 231
        buf.extend_from_slice(&[0x0f, 0x05]); // syscall
    }
    buf
}

fn aarch64_start_stub(
    stub_text_offset: usize,
    entry_text_offset: usize,
    exit_text_offset: Option<usize>,
) -> Vec<u8> {
    // ldr    x0, [sp]                                ; argc
    // add    x1, sp, #8                              ; argv
    // bl     <entry>                                 ; imm26
    // -- if `__c5_exit` is in the merged image --
    //   bl    <__c5_exit>                            ; libc exit via lib helper
    //   brk   #1                                     ; unreachable
    // -- otherwise (static path, no libc) --
    //   mov   x8, #94                                ; sys_exit_group
    //   svc   #0
    let mut buf: Vec<u8> = Vec::with_capacity(24);
    let ldr_x0_sp: u32 = 0xF9400000 | (31 << 5);
    buf.extend_from_slice(&ldr_x0_sp.to_le_bytes());
    let add_x1_sp_8: u32 = 0x91000000 | (8 << 10) | (31 << 5) | 1;
    buf.extend_from_slice(&add_x1_sp_8.to_le_bytes());
    let bl_entry_offset = stub_text_offset + buf.len();
    let bl_entry_imm = (entry_text_offset as i64 - bl_entry_offset as i64) / 4;
    let bl_entry_word: u32 = 0x94000000 | ((bl_entry_imm as u32) & 0x03ff_ffff);
    buf.extend_from_slice(&bl_entry_word.to_le_bytes());
    if let Some(exit_off) = exit_text_offset {
        let bl_exit_offset = stub_text_offset + buf.len();
        let bl_exit_imm = (exit_off as i64 - bl_exit_offset as i64) / 4;
        let bl_exit_word: u32 = 0x94000000 | ((bl_exit_imm as u32) & 0x03ff_ffff);
        buf.extend_from_slice(&bl_exit_word.to_le_bytes());
        // brk #1 -- catches the case where __c5_exit somehow
        // returns. 0xD4200020 = brk #1.
        buf.extend_from_slice(&0xD4200020u32.to_le_bytes());
    } else {
        let movz_x8_94: u32 = 0xD2800000 | (94 << 5) | 8;
        buf.extend_from_slice(&movz_x8_94.to_le_bytes());
        let svc_0: u32 = 0xD4000001;
        buf.extend_from_slice(&svc_0.to_le_bytes());
    }
    buf
}

fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(msg))
}

fn link_err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_link_err(msg))
}

/// Emit a dynamically-linked ELF64 ET_EXEC for `merged` whose
/// imports are resolved against libc.so.6 at startup by the
/// system dynamic linker (DT_BIND_NOW eager binding).
///
/// Image layout:
///
/// ```text
///   page 0 (R+X):
///     ELF header (64 bytes)
///     PHDR table (5 entries)
///     .interp ("/lib64/ld-linux-x86-64.so.2\0" or aarch64 form)
///     .dynstr (libc.so.6 + every import name, NUL-separated)
///     .dynsym (null entry + one Elf64_Sym per import)
///     .rela.plt (one Elf64_Rela per import)
///     .text + start stub + PLT trampolines
///   page 1 (R+W):
///     .got.plt (one i64 slot per import; dynamic linker fills
///               in resolved addresses at startup)
///     .data + .bss
///     .dynamic
/// ```
///
/// Both supported architectures route through the same layout;
/// only the interp string, the JUMP_SLOT reloc kind, and the
/// PLT-trampoline patch shape differ.
fn write_dynamic_elf64(merged: &MergedNative, entry_name: &str) -> Result<Vec<u8>, C5Error> {
    let entry_sym = merged.defined.get(entry_name).ok_or_else(|| {
        link_err(&format!(
            "entry symbol `{entry_name}` not defined in any input object"
        ))
    })?;
    if !matches!(entry_sym.section, NativeSymSection::Text) {
        return Err(link_err(&format!(
            "entry symbol `{entry_name}` is not in .text (found {:?})",
            entry_sym.section
        )));
    }
    let entry_text_offset = entry_sym.value as usize;
    let n_imports = merged.imports.len();

    let (machine_em, interp_path, jump_slot_rtype) = match merged.machine {
        NativeMachine::X86_64 => (EM_X86_64, "/lib64/ld-linux-x86-64.so.2", R_X86_64_JUMP_SLOT),
        NativeMachine::Aarch64 => (
            EM_AARCH64,
            "/lib/ld-linux-aarch64.so.1",
            R_AARCH64_JUMP_SLOT,
        ),
    };
    let interp_bytes: Vec<u8> = {
        let mut v = interp_path.as_bytes().to_vec();
        v.push(0);
        v
    };

    // Append the entry-call stub to the merged text. The
    // trampolines already produced by `emit_*_plt` are part of
    // `merged.text`; the stub lands past them. Pad to 4 bytes
    // first so the entry point is instruction-aligned on
    // aarch64 (matching the static path).
    let exit_text_offset = merged.defined.get("__c5_exit").and_then(|sym| {
        matches!(sym.section, NativeSymSection::Text).then_some(sym.value as usize)
    });
    let mut text = merged.text.clone();
    while text.len() & 3 != 0 {
        text.push(0);
    }
    let stub_text_offset = text.len();
    let stub_bytes = start_stub_bytes(
        merged.machine,
        stub_text_offset,
        entry_text_offset,
        exit_text_offset,
    );
    text.extend_from_slice(&stub_bytes);

    // .dynstr layout: a leading "\0", then one NUL-terminated
    // entry per DT_NEEDED dylib path collected from each unit's
    // `#pragma dylib` declarations, then every import name
    // NUL-terminated. A merge with no recorded dylibs falls back
    // to "libc.so.6" -- that matches the historical single-libc
    // ELF write path and keeps cross-TU smokes runnable when an
    // upstream .o was produced before the `.badc.dylibs` section
    // landed.
    let mut dynstr: Vec<u8> = Vec::new();
    dynstr.push(0);
    let dylib_paths: alloc::vec::Vec<&str> = if merged.dylibs.is_empty() {
        alloc::vec!["libc.so.6"]
    } else {
        merged.dylibs.iter().map(|s| s.as_str()).collect()
    };
    let mut dylib_name_off: alloc::vec::Vec<u32> =
        alloc::vec::Vec::with_capacity(dylib_paths.len());
    for path in &dylib_paths {
        dylib_name_off.push(dynstr.len() as u32);
        dynstr.extend_from_slice(path.as_bytes());
        dynstr.push(0);
    }
    let mut import_name_off: Vec<u32> = Vec::with_capacity(n_imports);
    for name in &merged.imports {
        import_name_off.push(dynstr.len() as u32);
        dynstr.extend_from_slice(name.as_bytes());
        dynstr.push(0);
    }

    // .dynsym layout: null symbol + one STT_FUNC per import.
    let mut dynsym: Vec<u8> = Vec::with_capacity((n_imports + 1) * ELF64_SYM_SIZE as usize);
    write_elf64_sym(&mut dynsym, 0, 0, 0, SHN_UNDEF, 0, 0);
    for off in &import_name_off {
        let st_info = (STB_GLOBAL << 4) | STT_FUNC;
        write_elf64_sym(&mut dynsym, *off, st_info, 0, SHN_UNDEF, 0, 0);
    }

    // Lay out the file. The header offsets need the final
    // addresses to compute reloc offsets, so first walk
    // forward picking offsets, then write the bytes.
    let phnum: u16 = 5;
    let phoff: u64 = ELF_HEADER_SIZE as u64;
    let headers_size: u64 = phoff + (PROGRAM_HEADER_SIZE as u64) * (phnum as u64);

    let interp_off = headers_size;
    let interp_size = interp_bytes.len() as u64;
    let dynstr_off = interp_off + interp_size;
    let dynstr_size = dynstr.len() as u64;
    let dynsym_off = dynstr_off + dynstr_size;
    let dynsym_size = dynsym.len() as u64;
    let rela_plt_off = dynsym_off + dynsym_size;
    let rela_plt_size = (n_imports as u64) * ELF64_RELA_SIZE;
    // 4-align so `text_vaddr = BASE_ADDR + text_off` and every
    // instruction landing in `.text` is 4-byte aligned for
    // aarch64.
    let text_off = (rela_plt_off + rela_plt_size + 3) & !3;
    let text_size = text.len() as u64;

    // Second PT_LOAD starts on the next page after the text
    // segment. Page-align both the file offset and the load
    // vaddr; the kernel's mmap requires
    // `vaddr % PAGE_SIZE == offset % PAGE_SIZE`.
    let data_seg_file_off = page_align(text_off + text_size);
    let data_seg_vaddr = page_align(BASE_ADDR + text_off + text_size) + PAGE_SIZE;
    let got_plt_off = data_seg_file_off;
    let got_plt_size: u64 = (n_imports as u64) * 8;
    let data_off = got_plt_off + got_plt_size;
    let data_size = merged.data.len() as u64;
    let dynamic_off = data_off + data_size;
    let dynamic_size: u64 = {
        // Tag list: one NEEDED per merged dylib, then STRTAB,
        // SYMTAB, STRSZ, SYMENT, PLTGOT, PLTREL, JMPREL,
        // PLTRELSZ, FLAGS, BIND_NOW, NULL.
        let n_tags: u64 = dylib_name_off.len() as u64 + 11;
        n_tags * ELF64_DYN_SIZE
    };

    // Compute VA addresses now that file offsets are fixed.
    let interp_vaddr = BASE_ADDR + interp_off;
    let dynstr_vaddr = BASE_ADDR + dynstr_off;
    let dynsym_vaddr = BASE_ADDR + dynsym_off;
    let rela_plt_vaddr = BASE_ADDR + rela_plt_off;
    let text_vaddr = BASE_ADDR + text_off;
    let got_plt_vaddr = data_seg_vaddr;
    let dynamic_vaddr = data_seg_vaddr + (dynamic_off - data_seg_file_off);
    let entry_vaddr = text_vaddr + stub_text_offset as u64;

    // Patch the PLT trampolines to dereference their .got.plt
    // slot. The codegen left `0` placeholders; we know each
    // trampoline's text offset because `emit_*_plt` placed them
    // contiguously past the user .text.
    let user_text_end = merged.text.len() - n_imports * plt_trampoline_size(merged.machine);
    for (i, _name) in merged.imports.iter().enumerate() {
        let tramp_offset = user_text_end + i * plt_trampoline_size(merged.machine);
        let slot_vaddr = got_plt_vaddr + (i as u64) * 8;
        patch_plt_trampoline(
            &mut text,
            tramp_offset,
            text_vaddr + tramp_offset as u64,
            slot_vaddr,
            merged.machine,
        )?;
    }

    // Resolve every parked data-ref reloc against the now-
    // known runtime `.data` vmaddr. The dynamic-section layout
    // puts `.data` after the `.got.plt` slots; the addend on
    // each parked reloc is the byte offset within `merged.data`
    // (set by `link_native_objects`).
    let data_vaddr = got_plt_vaddr + got_plt_size;
    patch_data_refs(
        &mut text,
        text_vaddr,
        data_vaddr,
        &merged.pending_imports,
        merged.machine,
    )?;

    // Apply absolute data-segment relocations the same way as
    // in the static path.
    let mut data = merged.data.clone();
    patch_data_abs_relocs(&mut data, text_vaddr, data_vaddr, &merged.data_abs_relocs)?;

    let mut out: Vec<u8> =
        Vec::with_capacity((dynamic_off + dynamic_size + PAGE_SIZE) as usize + merged.data.len());

    // ELF identification.
    out.extend_from_slice(&ELF_MAGIC);
    out.push(EI_CLASS_64);
    out.push(EI_DATA_LSB);
    out.push(EI_VERSION_CURRENT);
    out.push(EI_OSABI_SYSV);
    out.push(0);
    out.extend_from_slice(&[0u8; 7]);

    // ELF header (e_type onwards).
    write_u16(&mut out, ET_EXEC);
    write_u16(&mut out, machine_em);
    write_u32(&mut out, EV_CURRENT);
    write_u64(&mut out, entry_vaddr);
    write_u64(&mut out, phoff);
    write_u64(&mut out, 0);
    write_u32(&mut out, 0);
    write_u16(&mut out, ELF_HEADER_SIZE);
    write_u16(&mut out, PROGRAM_HEADER_SIZE);
    write_u16(&mut out, phnum);
    write_u16(&mut out, 0);
    write_u16(&mut out, 0);
    write_u16(&mut out, 0);
    debug_assert_eq!(out.len() as u64, phoff);

    // Program headers.
    write_phdr(
        &mut out,
        PT_PHDR,
        PF_R,
        phoff,
        BASE_ADDR + phoff,
        BASE_ADDR + phoff,
        (PROGRAM_HEADER_SIZE as u64) * (phnum as u64),
        (PROGRAM_HEADER_SIZE as u64) * (phnum as u64),
        8,
    );
    write_phdr(
        &mut out,
        PT_INTERP,
        PF_R,
        interp_off,
        interp_vaddr,
        interp_vaddr,
        interp_size,
        interp_size,
        1,
    );
    let text_seg_file_size = text_off + text_size;
    write_phdr(
        &mut out,
        PT_LOAD,
        PF_R | PF_X,
        0,
        BASE_ADDR,
        BASE_ADDR,
        text_seg_file_size,
        text_seg_file_size,
        PAGE_SIZE,
    );
    let data_seg_file_size = (dynamic_off + dynamic_size) - data_seg_file_off;
    let data_seg_mem_size = data_seg_file_size + merged.bss_size as u64;
    write_phdr(
        &mut out,
        PT_LOAD,
        PF_R | PF_W,
        data_seg_file_off,
        data_seg_vaddr,
        data_seg_vaddr,
        data_seg_file_size,
        data_seg_mem_size,
        PAGE_SIZE,
    );
    write_phdr(
        &mut out,
        PT_DYNAMIC,
        PF_R | PF_W,
        dynamic_off,
        dynamic_vaddr,
        dynamic_vaddr,
        dynamic_size,
        dynamic_size,
        8,
    );

    // .interp / .dynstr / .dynsym
    debug_assert_eq!(out.len() as u64, interp_off);
    out.extend_from_slice(&interp_bytes);
    debug_assert_eq!(out.len() as u64, dynstr_off);
    out.extend_from_slice(&dynstr);
    debug_assert_eq!(out.len() as u64, dynsym_off);
    out.extend_from_slice(&dynsym);

    // .rela.plt -- one Elf64_Rela per import. r_offset points
    // at the import's .got.plt slot; r_info encodes the dynsym
    // index (1-based; the null entry sits at 0) and the
    // JUMP_SLOT reloc type. r_addend stays 0.
    debug_assert_eq!(out.len() as u64, rela_plt_off);
    for (i, _name) in merged.imports.iter().enumerate() {
        let slot_vaddr = got_plt_vaddr + (i as u64) * 8;
        let sym_idx = (i + 1) as u64;
        let r_info = (sym_idx << 32) | jump_slot_rtype as u64;
        write_u64(&mut out, slot_vaddr);
        write_u64(&mut out, r_info);
        write_u64(&mut out, 0);
    }

    // .text (with PLT trampolines patched + start stub).
    // Pad any gap left by 4-aligning `text_off`.
    while (out.len() as u64) < text_off {
        out.push(0);
    }
    debug_assert_eq!(out.len() as u64, text_off);
    out.extend_from_slice(&text);

    // Pad to next page for the data segment.
    while (out.len() as u64) < data_seg_file_off {
        out.push(0);
    }

    // .got.plt -- one i64 zero per import (dynamic linker will
    // overwrite at startup).
    debug_assert_eq!(out.len() as u64, got_plt_off);
    for _ in 0..n_imports {
        write_u64(&mut out, 0);
    }

    // .data
    debug_assert_eq!(out.len() as u64, data_off);
    out.extend_from_slice(&data);

    // .dynamic
    debug_assert_eq!(out.len() as u64, dynamic_off);
    for off in &dylib_name_off {
        write_dyn(&mut out, DT_NEEDED, *off as u64);
    }
    write_dyn(&mut out, DT_STRTAB, dynstr_vaddr);
    write_dyn(&mut out, DT_SYMTAB, dynsym_vaddr);
    write_dyn(&mut out, DT_STRSZ, dynstr_size);
    write_dyn(&mut out, DT_SYMENT, ELF64_SYM_SIZE);
    write_dyn(&mut out, DT_PLTGOT, got_plt_vaddr);
    write_dyn(&mut out, DT_PLTREL, 7); // 7 = DT_RELA
    write_dyn(&mut out, DT_JMPREL, rela_plt_vaddr);
    write_dyn(&mut out, DT_PLTRELSZ, rela_plt_size);
    write_dyn(&mut out, DT_FLAGS, DF_BIND_NOW);
    write_dyn(&mut out, DT_BIND_NOW, 0);
    write_dyn(&mut out, DT_NULL, 0);

    Ok(out)
}

/// Walk `pending` for parked data / bss references
/// (`import_index == usize::MAX`) and patch the matching
/// text site with the runtime PC-relative displacement to the
/// resolved data byte. The link step stored the target's data
/// byte offset in the reloc's addend.
fn patch_data_refs(
    text: &mut [u8],
    text_vaddr: u64,
    data_vaddr: u64,
    pending: &[super::link::PendingImportReloc],
    machine: NativeMachine,
) -> Result<(), C5Error> {
    use super::link::PendingImportReloc;
    const R_X86_64_PC32: u32 = 2;
    const R_X86_64_PLT32: u32 = 4;
    const R_AARCH64_ADR_PREL_PG_HI21: u32 = 275;
    const R_AARCH64_ADD_ABS_LO12_NC: u32 = 277;

    for r in pending {
        let r: &PendingImportReloc = r;
        if r.import_index != usize::MAX {
            continue;
        }
        let site_vaddr = text_vaddr + r.text_offset;
        let target_base = match r.target_section {
            NativeSymSection::Text => text_vaddr as i64,
            NativeSymSection::Data => data_vaddr as i64,
            NativeSymSection::Bss => data_vaddr as i64,
            NativeSymSection::Undef
            | NativeSymSection::Abs
            | NativeSymSection::Common
            | NativeSymSection::Tls
            | NativeSymSection::DebugAbbrev
            | NativeSymSection::DebugLine
            | NativeSymSection::DebugStr => {
                return Err(err(&format!(
                    "parked reloc at text[{:#x}] has unexpected target section {:?}",
                    r.text_offset, r.target_section,
                )));
            }
        };
        let target_vaddr = target_base + r.addend;
        let site = r.text_offset as usize;
        match (machine, r.rtype) {
            (NativeMachine::X86_64, R_X86_64_PC32) | (NativeMachine::X86_64, R_X86_64_PLT32) => {
                let disp = target_vaddr - site_vaddr as i64;
                let disp32 = i32::try_from(disp).map_err(|_| {
                    err(&format!(
                        "data-ref reloc at text[{site:#x}]: PC32 displacement {disp:#x} out of \
                         range"
                    ))
                })?;
                text[site..site + 4].copy_from_slice(&disp32.to_le_bytes());
            }
            (NativeMachine::Aarch64, R_AARCH64_ADR_PREL_PG_HI21) => {
                let adrp_pc = site_vaddr;
                let page_disp =
                    ((target_vaddr & !0xfff) - (adrp_pc as i64 & !0xfff)) / PAGE_SIZE as i64;
                let page_disp_u = (page_disp as u32) & 0x1fffff;
                let immlo = page_disp_u & 0x3;
                let immhi = (page_disp_u >> 2) & 0x7ffff;
                let mut w = u32::from_le_bytes(text[site..site + 4].try_into().unwrap());
                // Clear the old immlo/immhi bits before OR'ing
                // in the resolved page displacement.
                w &= !((0x3 << 29) | (0x7ffff << 5));
                w |= (immlo << 29) | (immhi << 5);
                text[site..site + 4].copy_from_slice(&w.to_le_bytes());
            }
            (NativeMachine::Aarch64, R_AARCH64_ADD_ABS_LO12_NC) => {
                let lo12 = (target_vaddr as u32) & 0xfff;
                let mut w = u32::from_le_bytes(text[site..site + 4].try_into().unwrap());
                w &= !(0xfff << 10);
                w |= lo12 << 10;
                text[site..site + 4].copy_from_slice(&w.to_le_bytes());
            }
            _ => {
                return Err(err(&format!(
                    "data-ref reloc at text[{site:#x}]: unsupported (machine={:?}, rtype={})",
                    machine, r.rtype
                )));
            }
        }
    }
    Ok(())
}

fn plt_trampoline_size(machine: NativeMachine) -> usize {
    match machine {
        // `jmp [rip + disp32]`
        NativeMachine::X86_64 => 6,
        // `adrp x16, pg; ldr x16, [x16, off]; br x16`
        NativeMachine::Aarch64 => 12,
    }
}

/// Patch the per-arch PLT trampoline starting at `text[tramp_offset]`
/// to fetch its target through `slot_vaddr` (a `.got.plt` slot).
/// `tramp_vaddr` is the runtime VA of the trampoline's first
/// byte; the calling convention each emitter uses is a
/// RIP-relative (x86_64) or PC-relative (aarch64) load.
fn patch_plt_trampoline(
    text: &mut [u8],
    tramp_offset: usize,
    tramp_vaddr: u64,
    slot_vaddr: u64,
    machine: NativeMachine,
) -> Result<(), C5Error> {
    match machine {
        NativeMachine::X86_64 => {
            // `jmp [rip+disp32]` -- disp32 sits at offset 2 of
            // the 6-byte trampoline; rip is at `tramp_vaddr + 6`.
            let rip = tramp_vaddr + 6;
            let disp = (slot_vaddr as i64) - (rip as i64);
            let disp32 = i32::try_from(disp).map_err(|_| {
                err(&format!(
                    "PLT trampoline at {tramp_offset:#x}: GOT slot disp32 out of range \
                     ({disp:#x})"
                ))
            })?;
            text[tramp_offset + 2..tramp_offset + 6].copy_from_slice(&disp32.to_le_bytes());
            Ok(())
        }
        NativeMachine::Aarch64 => {
            // adrp imm: page-of(slot) - page-of(tramp). Each
            // page is PAGE_SIZE (0x1000) bytes. The adrp's
            // displacement counts pages, encoded across immlo
            // (bits 30:29) and immhi (bits 23:5). The ldr's
            // imm12 carries the slot's offset within its page,
            // scaled by 8 (the load is 64-bit).
            let adrp_pc = tramp_vaddr;
            let page_disp =
                ((slot_vaddr & !0xfff) as i64 - (adrp_pc & !0xfff) as i64) / PAGE_SIZE as i64;
            let page_disp_u = (page_disp as u32) & 0x1fffff; // 21 bits
            let immlo = page_disp_u & 0x3;
            let immhi = (page_disp_u >> 2) & 0x7ffff;
            let mut adrp_word =
                u32::from_le_bytes(text[tramp_offset..tramp_offset + 4].try_into().unwrap());
            adrp_word |= (immlo << 29) | (immhi << 5);
            text[tramp_offset..tramp_offset + 4].copy_from_slice(&adrp_word.to_le_bytes());
            let page_off = (slot_vaddr & 0xfff) as u32;
            if !page_off.is_multiple_of(8) {
                return Err(err(&format!(
                    "PLT trampoline at {tramp_offset:#x}: GOT slot offset {page_off} is not \
                     8-byte aligned"
                )));
            }
            let imm12 = (page_off >> 3) & 0xfff;
            let mut ldr_word =
                u32::from_le_bytes(text[tramp_offset + 4..tramp_offset + 8].try_into().unwrap());
            ldr_word |= imm12 << 10;
            text[tramp_offset + 4..tramp_offset + 8].copy_from_slice(&ldr_word.to_le_bytes());
            Ok(())
        }
    }
}

#[allow(clippy::too_many_arguments)]
fn write_elf64_sym(
    out: &mut Vec<u8>,
    st_name: u32,
    st_info: u8,
    st_other: u8,
    st_shndx: u16,
    st_value: u64,
    st_size: u64,
) {
    write_u32(out, st_name);
    out.push(st_info);
    out.push(st_other);
    write_u16(out, st_shndx);
    write_u64(out, st_value);
    write_u64(out, st_size);
}

fn write_dyn(out: &mut Vec<u8>, d_tag: u64, d_val: u64) {
    write_u64(out, d_tag);
    write_u64(out, d_val);
}

#[cfg(test)]
mod tests {
    use super::*;

    fn text_then_data_image() -> MergedNative {
        let mut defined = alloc::collections::BTreeMap::new();
        defined.insert(
            "main".to_string(),
            super::super::link::MergedSymbol {
                section: NativeSymSection::Text,
                value: 0,
                size: 8,
            },
        );
        MergedNative {
            // x86_64: `mov eax, 42; ret` -- minimal main body.
            text: alloc::vec![0xb8, 0x2a, 0x00, 0x00, 0x00, 0xc3],
            data: alloc::vec![],
            bss_size: 0,
            defined,
            imports: alloc::vec![],
            pending_imports: alloc::vec![],
            data_abs_relocs: alloc::vec![],
            machine: NativeMachine::X86_64,
            dylibs: alloc::vec![],
            import_dylib_map: alloc::collections::BTreeMap::new(),
            exports: alloc::vec![],
            tls_index_fixups: alloc::vec![],
            macho_tlv_descriptors: alloc::vec![],
            macho_tlv_fixups: alloc::vec![],
            debug_info: alloc::vec![],
            debug_abbrev: alloc::vec![],
            debug_line: alloc::vec![],
            debug_str: alloc::vec![],
            debug_info_bases: alloc::vec![],
            debug_abbrev_bases: alloc::vec![],
            debug_line_bases: alloc::vec![],
            debug_str_bases: alloc::vec![],
            debug_info_relocs: alloc::vec![],
            debug_line_relocs: alloc::vec![],
            unit_for_debug_info_reloc: alloc::vec![],
            unit_for_debug_line_reloc: alloc::vec![],
            debug_info_text_relocs: alloc::vec![],
            debug_line_text_relocs: alloc::vec![],
            prologue_ends: alloc::collections::BTreeMap::new(),
            local_funcs: alloc::vec::Vec::new(),
            tls_data: alloc::vec![],
            tls_init_size: 0,
        }
    }

    #[test]
    fn header_carries_elf_magic_and_x86_64_machine() {
        let merged = text_then_data_image();
        let bytes = write_executable_elf64(&merged, "main").expect("write");
        assert_eq!(&bytes[..4], &ELF_MAGIC);
        assert_eq!(bytes[4], EI_CLASS_64);
        // e_type at offset 16, e_machine at offset 18.
        let e_type = u16::from_le_bytes(bytes[16..18].try_into().unwrap());
        let e_machine = u16::from_le_bytes(bytes[18..20].try_into().unwrap());
        assert_eq!(e_type, ET_EXEC);
        assert_eq!(e_machine, EM_X86_64);
    }

    #[test]
    fn dynamic_path_writes_pt_interp_and_pt_dynamic_when_imports_present() {
        let mut merged = text_then_data_image();
        merged.imports = alloc::vec!["printf".to_string()];
        let bytes = write_executable_elf64(&merged, "main").expect("dynamic write");
        // Verify the header reports five program headers (PT_PHDR,
        // PT_INTERP, two PT_LOADs, PT_DYNAMIC).
        let e_phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap());
        assert_eq!(e_phnum, 5, "dynamic image must carry five program headers");
        // The interp string lands right after the PHDR table.
        let interp_off = 64 + 5 * 56;
        let mut end = interp_off;
        while bytes[end] != 0 {
            end += 1;
        }
        let interp = core::str::from_utf8(&bytes[interp_off..end]).unwrap();
        assert!(
            interp.contains("ld-linux"),
            "interp path looks wrong: {interp}",
        );
    }

    #[test]
    fn x86_64_start_stub_preserves_kernel_rsp_alignment() {
        // AMD64 SysV ABI 3.4.1: the call instruction must land main
        // with `(rsp + 8) % 16 == 0`. The kernel hands `_start` an
        // rsp that is already 16-aligned, so reading argc / argv via
        // memory (not `pop rdi`, which shifts rsp by 8) keeps rsp
        // 16-aligned for the upcoming `call`. The byte sequence
        // below is the contract the linker stub must continue to
        // honour; the syscall-tail variant is exercised by passing
        // `None` for `exit_text_offset`.
        let stub = x86_64_start_stub(0, 0x100, Some(0x200));
        // xor ebp, ebp
        assert_eq!(&stub[0..2], &[0x31, 0xed]);
        // mov rdi, [rsp]
        assert_eq!(&stub[2..6], &[0x48, 0x8b, 0x3c, 0x24]);
        // lea rsi, [rsp + 8]
        assert_eq!(&stub[6..11], &[0x48, 0x8d, 0x74, 0x24, 0x08]);
        // Stub must not push, pop, or sub rsp between the kernel
        // entry and `call entry`; any of those would unbalance the
        // call-site alignment contract.
        assert!(
            !stub[..11].contains(&0x5f), // pop rdi
            "stub adjusts rsp before `call entry`; breaks SysV 3.4.1"
        );
        assert!(
            !stub[..11].windows(3).any(|w| w == [0x48, 0x81, 0xec]),
            "stub `sub rsp` before `call entry`; breaks SysV 3.4.1"
        );
        // call entry rel32 follows immediately.
        assert_eq!(stub[11], 0xe8);
    }

    #[test]
    fn refuses_to_emit_when_entry_missing() {
        let mut merged = text_then_data_image();
        merged.defined.clear();
        let err = write_executable_elf64(&merged, "main").expect_err("missing entry rejects");
        let msg = alloc::format!("{}", err);
        assert!(msg.contains("entry symbol"), "unexpected error: {msg}");
    }
}

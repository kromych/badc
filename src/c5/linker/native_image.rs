//! Final-image writer for a [`MergedNative`].
//!
//! Consumes the merged sections produced by
//! [`super::native_link::link_native_objects`] (plus per-arch
//! PLT trampolines from `emit_*_plt`) and emits a runnable
//! ELF64 file. Today's scope is statically-linked Linux
//! executables: every cross-unit reference has been resolved
//! by the link step, and `MergedNative::imports` must be empty
//! -- libc / libdl imports need a dynamic-section pass that
//! lives in a follow-up commit.
//!
//! Layout (matches the conventional `ld -static -no-pie`
//! output close enough that `readelf -l` / `objdump -d` work):
//!
//!   * Page 0 starting at `BASE_ADDR`: ELF header + program
//!     headers + `.text` bytes. R+X mapping.
//!   * Next page: `.data` bytes + `.bss` (memsz beyond filesz).
//!     R+W mapping.
//!
//! A tiny per-arch `_start` stub is appended after `.text` to
//! call the named entry symbol and exit via the kernel's
//! `exit_group` syscall. The stub is the executable's entry
//! point; the entry symbol is invoked as a normal C function
//! taking `(argc, argv)`.
//!
//! Output is little-endian; both supported architectures
//! (x86_64, aarch64) are LE on Linux.

#![cfg(feature = "std")]

use alloc::format;
use alloc::vec::Vec;

use crate::c5::error::C5Error;

use super::native_link::MergedNative;
use super::native_object::{NativeMachine, NativeSymSection};

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

const PF_X: u32 = 1;
const PF_W: u32 = 2;
const PF_R: u32 = 4;

const ELF_HEADER_SIZE: u16 = 64;
const PROGRAM_HEADER_SIZE: u16 = 56;

/// Standard Linux executable load base. `ld -no-pie` plants
/// the program here by default; matching it keeps `objdump -d`
/// addresses recognisable next to a `gcc -static` reference.
const BASE_ADDR: u64 = 0x400000;
const PAGE_SIZE: u64 = 0x1000;

/// Emit a static ELF64 ET_EXEC executable for `merged`.
///
/// `entry_name` names the user-level entry function; today
/// that is `main`, which the start stub calls with the kernel
/// argc / argv on the stack. Errors out when
/// `merged.imports` is non-empty -- the dynamic-linker
/// scaffolding (PT_INTERP / PT_DYNAMIC / `.dynsym` / `.rela.plt`)
/// is not implemented yet.
pub fn write_executable_elf64(merged: &MergedNative, entry_name: &str) -> Result<Vec<u8>, C5Error> {
    if !merged.imports.is_empty() {
        return Err(err(&format!(
            "native ELF executable writer: {} unresolved import(s) (first: {:?}); \
             dynamic-linker section emission is not yet implemented",
            merged.imports.len(),
            merged.imports.first(),
        )));
    }

    // Resolve the entry function's text-segment offset.
    let entry_sym = merged.defined.get(entry_name).ok_or_else(|| {
        err(&format!(
            "native ELF executable writer: entry symbol `{entry_name}` not defined \
             in any input object"
        ))
    })?;
    if !matches!(entry_sym.section, NativeSymSection::Text) {
        return Err(err(&format!(
            "native ELF executable writer: entry symbol `{entry_name}` is not in .text \
             (found {:?})",
            entry_sym.section
        )));
    }
    let entry_text_offset = entry_sym.value as usize;

    // The start stub lands at the tail of the text segment;
    // the writer's job is to call `entry_name` and then exit
    // via `exit_group(rax)`. Both the call placeholder and
    // the syscall sequence are per-arch.
    let mut text = merged.text.clone();
    let stub_text_offset = text.len();
    let stub_bytes = start_stub_bytes(merged.machine, stub_text_offset, entry_text_offset);
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
    out.extend_from_slice(&merged.data);

    Ok(out)
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
) -> Vec<u8> {
    match machine {
        NativeMachine::X86_64 => x86_64_start_stub(stub_text_offset, entry_text_offset),
        NativeMachine::Aarch64 => aarch64_start_stub(stub_text_offset, entry_text_offset),
    }
}

fn x86_64_start_stub(stub_text_offset: usize, entry_text_offset: usize) -> Vec<u8> {
    // xor    ebp, ebp                                ; clear frame ptr
    // pop    rdi                                     ; argc
    // mov    rsi, rsp                                ; argv
    // call   <entry>                                 ; rel32
    // mov    rdi, rax                                ; exit code
    // mov    eax, 0xe7                               ; sys_exit_group = 231
    // syscall
    let mut buf: Vec<u8> = Vec::with_capacity(20);
    buf.extend_from_slice(&[0x31, 0xed]); // xor ebp, ebp
    buf.push(0x5f); // pop rdi
    buf.extend_from_slice(&[0x48, 0x89, 0xe6]); // mov rsi, rsp
    // call rel32 -- rel = entry - (call_end). The call's
    // opcode is 1 byte (0xe8); end-of-call sits 5 bytes after
    // the call's start.
    let call_start = stub_text_offset + buf.len();
    let call_end = call_start + 5;
    let rel = (entry_text_offset as i64) - (call_end as i64);
    buf.push(0xe8);
    buf.extend_from_slice(&(rel as i32).to_le_bytes());
    buf.extend_from_slice(&[0x48, 0x89, 0xc7]); // mov rdi, rax
    buf.extend_from_slice(&[0xb8, 0xe7, 0x00, 0x00, 0x00]); // mov eax, 231
    buf.extend_from_slice(&[0x0f, 0x05]); // syscall
    buf
}

fn aarch64_start_stub(stub_text_offset: usize, entry_text_offset: usize) -> Vec<u8> {
    // ldr    x0, [sp]                                ; argc
    // add    x1, sp, #8                              ; argv
    // bl     <entry>                                 ; imm26
    // mov    x8, #94                                 ; sys_exit_group
    // svc    #0
    let mut buf: Vec<u8> = Vec::with_capacity(20);
    // ldr x0, [sp]  -- LDR (immediate, unsigned offset),
    // 64-bit: 0xF9400000 | (imm12 << 10) | (Rn << 5) | Rt.
    // imm12 = 0, Rn = sp (31), Rt = x0.
    let ldr_x0_sp: u32 = 0xF9400000 | (31 << 5);
    buf.extend_from_slice(&ldr_x0_sp.to_le_bytes());
    // add x1, sp, #8 -- ADD (immediate), 64-bit:
    // 0x91000000 | (imm12 << 10) | (Rn << 5) | Rd.
    let add_x1_sp_8: u32 = 0x91000000 | (8 << 10) | (31 << 5) | 1;
    buf.extend_from_slice(&add_x1_sp_8.to_le_bytes());
    // bl <imm26> -- 0x94000000 | (imm26 & 0x03ffffff).
    // imm26 counts 4-byte instructions, signed.
    let bl_offset = stub_text_offset + buf.len();
    let bl_target = entry_text_offset as i64;
    let bl_imm: i64 = (bl_target - bl_offset as i64) / 4;
    let bl_imm26 = (bl_imm as u32) & 0x03ff_ffff;
    let bl_word: u32 = 0x94000000 | bl_imm26;
    buf.extend_from_slice(&bl_word.to_le_bytes());
    // mov x8, #94 -- MOVZ (imm16, lsl#0) into x8.
    // 0xD2800000 | (imm16 << 5) | Rd.
    let movz_x8_94: u32 = 0xD2800000 | (94 << 5) | 8;
    buf.extend_from_slice(&movz_x8_94.to_le_bytes());
    // svc #0 -- 0xD4000001.
    let svc_0: u32 = 0xD4000001;
    buf.extend_from_slice(&svc_0.to_le_bytes());
    buf
}

fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(msg))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn text_then_data_image() -> MergedNative {
        let mut defined = alloc::collections::BTreeMap::new();
        defined.insert(
            "main".to_string(),
            super::super::native_link::MergedSymbol {
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
            machine: NativeMachine::X86_64,
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
    fn refuses_to_emit_when_imports_unresolved() {
        let mut merged = text_then_data_image();
        merged.imports = alloc::vec!["printf".to_string()];
        let err = write_executable_elf64(&merged, "main").expect_err("imports must reject");
        let msg = alloc::format!("{}", err);
        assert!(msg.contains("unresolved import"), "unexpected error: {msg}",);
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

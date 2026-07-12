//! ELF (64-bit) writer for Linux/aarch64 executables.
//!
//! ## Layout
//!
//! ```text
//!   file                                                segment / contents
//!   ----------------------------------------------------------------------
//!   0x0000   ELF header (64 bytes)                       \
//!            Program headers (6 * 56 = 336 bytes)        |
//!            .interp ("/lib/ld-linux-aarch64.so.1\0")    |
//!            .dynsym (Elf64_Sym per import + sentinel)   | r-x PT_LOAD
//!            .dynstr (NUL-separated symbol names)        |
//!            .hash (DT_HASH bucket/chain table)          |
//!            .rela.dyn (R_AARCH64_GLOB_DAT entries)      |
//!            <pad to 16>                                 |
//!            _start stub + build.text                    |
//!            <pad to page>                               /
//!   0x1000   .dynamic (DT_* entries terminated DT_NULL)  \
//!            .got (8 bytes per import, zero-filled)      | rw  PT_LOAD
//!            build.data (program's static data segment)  |
//!            <pad to page>                               /
//! ```
//!
//! Six program headers describe the above:
//!   * PT_PHDR       -- the phdr table self-locating itself
//!   * PT_INTERP     -- "/lib/ld-linux-aarch64.so.1"
//!   * PT_LOAD r-x   -- header through code
//!   * PT_LOAD rw    -- .dynamic, .got, .data
//!   * PT_DYNAMIC    -- mirrors the .dynamic location
//!   * PT_GNU_STACK  -- non-exec stack marker
//!
//! ## Dynamic linking
//!
//! ET_DYN (PIE) + PT_INTERP. The loader (ld-linux-aarch64.so.1) maps both
//! PT_LOAD segments at a random slide, applies the .rela.dyn R_*_RELATIVE
//! entries to fix up internal absolute pointers by the load bias, then
//! walks .dynamic, finds DT_NEEDED `libc.so.6`, loads it, and uses
//! .rela.dyn to populate each .got slot with the resolved libc symbol
//! address (R_AARCH64_GLOB_DAT). DT_BIND_NOW forces eager binding so
//! the slots are filled before `_start` runs.
//!
//! The codegen's `adrp + ldr + blr` calls already point at the .got;
//! the writer just patches the immediates with the page-relative
//! offset of the matching GOT slot. Same scheme as the macOS Mach-O
//! writer (the codegen is platform-agnostic; only the writer differs).

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::program::Program;
use super::{Abi, Build, Machine};
use super::{aarch64, dwarf, x86_64};

// ------------------------------------------------------------------
// ELF constants. Names mirror `<elf.h>` so cross-checking is mechanical.
// ------------------------------------------------------------------

const EI_NIDENT: usize = 16;

const ELFMAG: [u8; 4] = [0x7F, b'E', b'L', b'F'];
const ELFCLASS64: u8 = 2;
const ELFDATA2LSB: u8 = 1;
const EV_CURRENT: u8 = 1;
const ELFOSABI_SYSV: u8 = 0;

const ET_EXEC: u16 = 2;
/// `ET_DYN` -- shared object / position-independent
/// executable. Used when `OutputKind::SharedLibrary` is in
/// effect; the loader (`dlopen`) maps the image at any
/// address and adds the runtime base to every absolute VA.
const ET_DYN: u16 = 3;

const EM_AARCH64: u16 = 183;
const EM_X86_64: u16 = 62;

const PT_LOAD: u32 = 1;
const PT_DYNAMIC: u32 = 2;
const PT_INTERP: u32 = 3;
const PT_PHDR: u32 = 6;
const PT_TLS: u32 = 7;
const PT_GNU_STACK: u32 = 0x6474_E551;
// PT_TLS alignment. The thread-pointer-relative offsets the codegen
// bakes / the linker patches assume an 8-byte-aligned TLS block, which
// also satisfies the ELF gABI `p_vaddr % p_align == 0` rule.
const TLS_SEGMENT_ALIGN: u64 = 8;

const PF_X: u32 = 1;
const PF_W: u32 = 2;
const PF_R: u32 = 4;

// .dynamic tag types we use.
const DT_NULL: u64 = 0;
const DT_NEEDED: u64 = 1;
const DT_HASH: u64 = 4;
const DT_STRTAB: u64 = 5;
const DT_SYMTAB: u64 = 6;
const DT_RELA: u64 = 7;
const DT_RELASZ: u64 = 8;
const DT_RELAENT: u64 = 9;
const DT_STRSZ: u64 = 10;
const DT_SYMENT: u64 = 11;
const DT_BIND_NOW: u64 = 24;
const DT_FLAGS: u64 = 30;
const DT_VERSYM: u64 = 0x6fff_fff0;
const DT_VERNEED: u64 = 0x6fff_fffe;
const DT_VERNEEDNUM: u64 = 0x6fff_ffff;

const DF_BIND_NOW: u64 = 0x8;

// `.gnu.version` index for a global, unversioned symbol (0 = local).
// Real version requirements emitted into `.gnu.version_r` start at 2.
const VER_NDX_GLOBAL: u16 = 1;
const VER_NDX_FIRST: u16 = 2;

// nlist / Elf64_Sym fields.
/// `STB_LOCAL` -- file-local binding. Used by the
/// per-PLT-trampoline static symbols so they don't shadow
/// `.dynsym`'s loader-visible globals.
const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
/// `STT_FUNC` symbol type -- `st_info` low nibble for both
/// imported and exported functions. Imports use it so debuggers
/// (`gdb`, `lldb`) treat the dynamic-symbol entry as a callable
/// breakpoint target; exports use it so `dlsym` surfaces them as
/// code (dlsym only resolves `STT_FUNC` / `STT_NOTYPE`-non-undef
/// entries).
const STT_FUNC: u8 = 2;
/// `STT_OBJECT` symbol type -- a data object. Used for the defined
/// data symbols a COPY relocation binds to the host's object.
const STT_OBJECT: u8 = 1;
const SHN_UNDEF: u16 = 0;

// Relocation types we emit.
const R_AARCH64_GLOB_DAT: u64 = 1025;
const R_X86_64_GLOB_DAT: u64 = 6;
// `R_*_RELATIVE`: the loader writes `load_bias + r_addend` into the slot.
// Used in a shared object for an internal absolute pointer (a function /
// data pointer baked into static data) so it tracks the runtime load base.
const R_AARCH64_RELATIVE: u64 = 1027;
const R_X86_64_RELATIVE: u64 = 8;
// `R_*_COPY`: the loader copies the named symbol's object from the
// defining shared library into the slot at `r_offset` and binds the
// symbol to that slot. Used for a data import (`extern char **environ`)
// so the program and libc share one storage cell.
const R_AARCH64_COPY: u64 = 1024;
const R_X86_64_COPY: u64 = 5;

/// `PT_LOAD` segment alignment. The kernel enforces segment
/// permissions at page granularity, so the R+E and RW segments must
/// land on separate pages; the alignment also drives `p_vaddr ==
/// p_offset (mod align)`, the gap the ET_EXEC file pays once between
/// the two segments. x86_64 is always 4K. AArch64 Linux kernels run
/// 4K or 16K pages, and a 16K-aligned segment is also 4K-aligned, so
/// 16K covers both; 64K-page AArch64 kernels are out of scope (they
/// would cost a 64K hole per binary).
fn seg_align(machine: Machine) -> u64 {
    match machine {
        Machine::Aarch64 => 0x4000,
        Machine::X86_64 => 0x1000,
    }
}

/// Default load address for non-PIE ET_EXEC binaries on Linux/aarch64.
/// The kernel maps the binary at exactly this vmaddr (no slide); all
/// our .got slot addresses, e_entry, etc. are absolute and burned in.
const TEXT_VMADDR_BASE: u64 = 0x40_0000;

const ELF_HEADER_SIZE: u64 = 64;
const PROGRAM_HEADER_SIZE: u64 = 56;
/// Without TLS in the program. Programs that declare a
/// `_Thread_local` global add one more PT_TLS header (so a total of
/// 7).
const N_BASE_PROGRAM_HEADERS: u64 = 6;

const ELF64_SYM_SIZE: u64 = 24;
const ELF64_RELA_SIZE: u64 = 24;
const ELF64_DYN_SIZE: u64 = 16;
const ELF64_SHDR_SIZE: u64 = 64;

// Section header types we emit (Elf64_Shdr.sh_type).
const SHT_NULL: u32 = 0;
const SHT_PROGBITS: u32 = 1;
/// Static symbol table -- the file-only `.symtab` paired with
/// `.strtab`. Distinct from `SHT_DYNSYM` (the loader-side dynamic
/// symbol table). One local STT_FUNC per import is emitted via
/// this section so debuggers (`gdb`, `lldb`) and `nm` resolve
/// PLT trampoline addresses to a real name.
const SHT_SYMTAB: u32 = 2;
const SHT_STRTAB: u32 = 3;
const SHT_RELA: u32 = 4;
const SHT_HASH: u32 = 5;
const SHT_DYNAMIC: u32 = 6;
const SHT_DYNSYM: u32 = 11;
const SHT_GNU_VERNEED: u32 = 0x6fff_fffe;
const SHT_GNU_VERSYM: u32 = 0x6fff_ffff;

// Section header flags (Elf64_Shdr.sh_flags).
const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;

// ------------------------------------------------------------------
// On-disk shapes. `#[repr(C)]` with explicit fields plus a
// const-time `assert_eq!` on `size_of::<T>()` against the matching
// `ELF*_SIZE` constant; written via the same memcpy helper the PE
// writer uses. ELF is little-endian on all our targets, so a bare
// memcpy of the in-memory struct gives the right wire format.
// ------------------------------------------------------------------

/// Elf64_Ehdr -- the file header at offset 0.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Ehdr {
    e_ident: [u8; EI_NIDENT],
    e_type: u16,
    e_machine: u16,
    e_version: u32,
    e_entry: u64,
    e_phoff: u64,
    e_shoff: u64,
    e_flags: u32,
    e_ehsize: u16,
    e_phentsize: u16,
    e_phnum: u16,
    e_shentsize: u16,
    e_shnum: u16,
    e_shstrndx: u16,
}

const _: () = assert!(core::mem::size_of::<Elf64Ehdr>() == ELF_HEADER_SIZE as usize);

/// Elf64_Phdr -- one program-header table entry.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Phdr {
    p_type: u32,
    p_flags: u32,
    p_offset: u64,
    p_vaddr: u64,
    p_paddr: u64,
    p_filesz: u64,
    p_memsz: u64,
    p_align: u64,
}

const _: () = assert!(core::mem::size_of::<Elf64Phdr>() == PROGRAM_HEADER_SIZE as usize);

/// Elf64_Sym -- one entry in `.dynsym`.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Sym {
    st_name: u32,
    st_info: u8,
    st_other: u8,
    st_shndx: u16,
    st_value: u64,
    st_size: u64,
}

const _: () = assert!(core::mem::size_of::<Elf64Sym>() == ELF64_SYM_SIZE as usize);

/// Elf64_Rela -- one entry in `.rela.dyn`. Addend-bearing form of
/// the relocation record; we don't use the older addend-less
/// `Elf64_Rel`.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Rela {
    r_offset: u64,
    r_info: u64,
    r_addend: i64,
}

const _: () = assert!(core::mem::size_of::<Elf64Rela>() == ELF64_RELA_SIZE as usize);

/// Elf64_Dyn -- one entry in the `.dynamic` table. The tag field
/// names what the value means (`DT_NEEDED`, `DT_HASH`, ...); the
/// union shape from the C ABI is just two `u64`s on the wire.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Dyn {
    d_tag: u64,
    d_val: u64,
}

const _: () = assert!(core::mem::size_of::<Elf64Dyn>() == ELF64_DYN_SIZE as usize);

/// Elf64_Shdr -- one entry in the section header table. We emit
/// only enough to expose the four DWARF debug sections plus the
/// `.shstrtab` to lldb / gdb; the dynamic loader doesn't
/// need section headers, and `objdump -h` falls back to the
/// program-header view when none are present.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Shdr {
    sh_name: u32,
    sh_type: u32,
    sh_flags: u64,
    sh_addr: u64,
    sh_offset: u64,
    sh_size: u64,
    sh_link: u32,
    sh_info: u32,
    sh_addralign: u64,
    sh_entsize: u64,
}

const _: () = assert!(core::mem::size_of::<Elf64Shdr>() == ELF64_SHDR_SIZE as usize);

/// Append a `#[repr(C)]` struct's raw bytes to `out`. Same shape
/// the PE writer uses; see that module for the safety argument.
fn write_struct<T: Copy>(out: &mut Vec<u8>, value: &T) {
    const _: () = assert!(
        cfg!(target_endian = "little"),
        "ELF writer assumes a little-endian host; emit bytes manually if you need to cross-build from big-endian"
    );
    let bytes = unsafe {
        core::slice::from_raw_parts((value as *const T) as *const u8, core::mem::size_of::<T>())
    };
    out.extend_from_slice(bytes);
}

/// Dynamic linker path. Selected per machine: `aarch64` lives at
/// `/lib/`, x86_64 at `/lib64/`. Mirrors what the host distro
/// expects.
fn interp_path(machine: Machine) -> &'static str {
    match machine {
        Machine::Aarch64 => "/lib/ld-linux-aarch64.so.1",
        Machine::X86_64 => "/lib64/ld-linux-x86-64.so.2",
    }
}

/// `e_machine` field in the ELF header.
fn e_machine(machine: Machine) -> u16 {
    match machine {
        Machine::Aarch64 => EM_AARCH64,
        Machine::X86_64 => EM_X86_64,
    }
}

/// `R_*_GLOB_DAT` relocation type: stores the symbol's resolved
/// address into the GOT slot. Different value on each arch.
fn r_glob_dat(machine: Machine) -> u64 {
    match machine {
        Machine::Aarch64 => R_AARCH64_GLOB_DAT,
        Machine::X86_64 => R_X86_64_GLOB_DAT,
    }
}

/// `R_*_RELATIVE` relocation type. Different value on each arch.
fn r_relative(machine: Machine) -> u64 {
    match machine {
        Machine::Aarch64 => R_AARCH64_RELATIVE,
        Machine::X86_64 => R_X86_64_RELATIVE,
    }
}

// `DT_NEEDED` entries come from `build.imports.dylibs` -- whatever
// the program's resolved `#pragma binding`s pull in. Empty when the
// program calls no libc.

// ------------------------------------------------------------------
// Tiny serialization helpers.
// ------------------------------------------------------------------

fn put_u32(out: &mut Vec<u8>, v: u32) {
    out.extend_from_slice(&v.to_le_bytes());
}

fn round_up(n: u64, align: u64) -> u64 {
    (n + align - 1) & !(align - 1)
}

// ------------------------------------------------------------------
// `_start` prologue. Linux/aarch64 process startup hands control to
// e_entry with sp pointing at argc.
//
// Per-arch variants live in `aarch64::emit_start_stub_elf` and
// `x86_64::emit_start_stub`. Both route exit through libc so
// glibc gets a chance to flush stdio.
// ------------------------------------------------------------------

/// Stub byte length per machine. Used for layout calculations.
///
/// `use_libc_exit` selects the longer (libc-routed) tail when the
/// program has a libc `exit` binding in scope; the syscall tail
/// is shorter on aarch64 and one byte longer on x86_64.
fn start_stub_len(machine: Machine, use_libc_exit: bool) -> u64 {
    match (machine, use_libc_exit) {
        // aarch64 libc tail: adrp + ldr + blr = 3 instructions.
        // aarch64 syscall tail: movz w8, #94 + svc #0 = 2
        // instructions. Saves 4 bytes.
        (Machine::Aarch64, true) => 6 * 4,
        (Machine::Aarch64, false) => 5 * 4,
        // x86_64 libc tail: mov rdi, rax (3) + call qword
        //   [rip+disp32] (6) = 9 bytes after the 14-byte prefix.
        // x86_64 syscall tail: mov rdi, rax (3) + mov eax, imm32
        //   (5) + syscall (2) = 10 bytes after the prefix --
        //   one byte longer.
        (Machine::X86_64, true) => x86_64::START_STUB_LEN,
        (Machine::X86_64, false) => x86_64::START_STUB_LEN_SYSCALL,
    }
}

/// Emit the `_start` prologue for the given machine. When
/// `use_libc_exit` is `true` the stub tail is `adrp/ldr/blr`
/// (aarch64) / `call qword [rip+disp32]` (x86_64) through the
/// libc `exit` GOT slot, and we return `Some(byte_offset)` so
/// the caller can register a `GotFixup` against it. When
/// `false`, the stub direct-syscalls
/// `sys_exit_group` so the resulting binary has no libc
/// dependency, and we return `None`. Routing through libc is
/// preferred when available because glibc's `exit` flushes
/// stdio buffers; the syscall tail is for binaries that
/// neither include `<stdlib.h>` nor use stdio at all.
fn emit_start_stub(
    machine: Machine,
    abi: Abi,
    code: &mut Vec<u8>,
    main_offset_in_code: u64,
    use_libc_exit: bool,
) -> Option<usize> {
    match machine {
        Machine::Aarch64 => emit_start_stub_aarch64(abi, code, main_offset_in_code, use_libc_exit),
        Machine::X86_64 => x86_64::emit_start_stub(code, abi, main_offset_in_code, use_libc_exit),
    }
}

/// AArch64 `_start`: ldr argc; add argv; bl main; then either
/// `adrp/ldr/blr libc::exit` or `mov w8, #94; svc #0`.
fn emit_start_stub_aarch64(
    abi: Abi,
    code: &mut Vec<u8>,
    main_offset_in_code: u64,
    use_libc_exit: bool,
) -> Option<usize> {
    use aarch64::Reg;
    let stub_len = start_stub_len(Machine::Aarch64, use_libc_exit);

    // argc / argv land in the first two of the ABI's
    // int-arg-passing registers. AAPCS64's order is x0..x7 so
    // these come out as x0, x1; pulling from `abi.int_arg_regs`
    // keeps the stub honest if a future arm64 ABI variant
    // shuffles the bank.
    let argc_reg = Reg(abi.int_arg_regs[0]);
    let argv_reg = Reg(abi.int_arg_regs[1]);
    aarch64::emit(code, aarch64::enc_ldr_imm(argc_reg, Reg::SP, 0));
    aarch64::emit(code, aarch64::enc_add_imm(argv_reg, Reg::SP, 8));

    let bl_pc = 8i64;
    let main_pc = stub_len as i64 + main_offset_in_code as i64;
    let delta_insns = ((main_pc - bl_pc) / 4) as i32;
    aarch64::emit(code, aarch64::enc_bl(delta_insns));

    let result = if use_libc_exit {
        // Placeholder adrp + ldr + blr through the libc exit GOT
        // slot. The caller appends a GotFixup with adrp_offset =
        // current code length so the writer fills in imm21/imm12
        // once the GOT vmaddr is known.
        let exit_adrp_offset = code.len();
        aarch64::emit(code, aarch64::enc_adrp(Reg::X16, 0));
        aarch64::emit(code, aarch64::enc_ldr_imm(Reg::X16, Reg::X16, 0));
        aarch64::emit(code, aarch64::enc_blr(Reg::X16));
        Some(exit_adrp_offset)
    } else {
        // direct `sys_exit_group` (Linux aarch64 syscall
        // 94). main's int return value is already in x0/w0, which
        // is the syscall's first arg. svc #0 transfers control to
        // the kernel and never returns.
        // movz w8, #94 -- Linux aarch64 sys_exit_group number.
        // The 16-bit shift amount (`hw`) is 0 since 94 fits in
        // the low 16 bits.
        aarch64::emit(code, aarch64::enc_movz(Reg::X8, 94, 0));
        aarch64::emit(code, aarch64::enc_svc(0));
        None
    };

    debug_assert_eq!(code.len() as u64, stub_len);
    result
}

/// Native offset within `build.text` of a function the entry adapter
/// targets, resolved through the merged symbol tables (`func_names` ->
/// `func_ent_pcs` -> `pc_to_native`). `None` when the symbol is absent
/// -- no startup runtime linked (single-TU or freestanding output) --
/// which selects the self-contained `_start` instead.
fn symbol_text_offset(build: &Build, name: &str) -> Option<u64> {
    let idx = build.func_names.iter().position(|n| n == name)?;
    let ent_pc = build.func_ent_pcs[idx];
    Some(build.pc_to_native[ent_pc] as u64)
}

/// Byte length of the entry adapter -- the minimal shim that loads the
/// initial stack pointer and the image-base offset into the first two
/// argument registers and calls `__c5_entry`.
fn entry_adapter_len(machine: Machine) -> u64 {
    match machine {
        Machine::X86_64 => 17,
        Machine::Aarch64 => 24,
    }
}

/// Emit the entry adapter at the head of the code blob. `entry_off` is
/// `__c5_entry`'s offset within `build.text` (which follows the adapter
/// at `entry_adapter_len`); `image_off` is the adapter's own offset
/// from the image base, passed in the second argument register so a
/// freestanding entry can recover the base. The adapter does not
/// return -- `__c5_entry` ends in `exit`.
fn emit_entry_adapter(
    machine: Machine,
    abi: Abi,
    code: &mut Vec<u8>,
    entry_off: u64,
    image_off: u64,
) {
    let stub_len = entry_adapter_len(machine);
    match machine {
        Machine::X86_64 => {
            // xor ebp, ebp -- outermost frame marker.
            code.extend_from_slice(&[0x31, 0xed]);
            // mov rdi, rsp -- arg0 = initial stack pointer.
            code.extend_from_slice(&[0x48, 0x89, 0xe7]);
            // mov esi, image_off -- arg1 (zero-extended into rsi).
            code.push(0xbe);
            code.extend_from_slice(&(image_off as u32).to_le_bytes());
            // call __c5_entry (rel32). The kernel hands `_start` a
            // 16-aligned rsp; `call` pushes 8 so `__c5_entry` sees the
            // SysV-required `(rsp + 8) % 16 == 0`.
            let call_end = code.len() as u64 + 5;
            let target = stub_len + entry_off;
            let rel = target as i64 - call_end as i64;
            code.push(0xe8);
            code.extend_from_slice(&(rel as i32).to_le_bytes());
            // ud2 -- unreachable.
            code.extend_from_slice(&[0x0f, 0x0b]);
        }
        Machine::Aarch64 => {
            use aarch64::Reg;
            let arg0 = Reg(abi.int_arg_regs[0]);
            let arg1 = Reg(abi.int_arg_regs[1]);
            // mov x29, #0 -- clear the frame pointer.
            aarch64::emit(code, aarch64::enc_movz(Reg(29), 0, 0));
            // mov arg0, sp -- arg0 = initial stack pointer.
            aarch64::emit(code, aarch64::enc_add_imm(arg0, Reg::SP, 0));
            // arg1 = image_off (32-bit, via movz + movk).
            aarch64::emit(
                code,
                aarch64::enc_movz(arg1, (image_off & 0xffff) as u16, 0),
            );
            aarch64::emit(
                code,
                aarch64::enc_movk(arg1, ((image_off >> 16) & 0xffff) as u16, 1),
            );
            // b __c5_entry -- tail call. AAPCS64 keeps sp 16-aligned
            // and `b` doesn't disturb it; `__c5_entry` ends in `exit`,
            // so no return address is needed.
            let b_pc = code.len() as u64;
            let target = stub_len + entry_off;
            let rel_insns = ((target as i64 - b_pc as i64) / 4) as i32;
            aarch64::emit(code, aarch64::enc_b(rel_insns));
            // brk #1 -- unreachable.
            aarch64::emit(code, 0xd420_0020);
        }
    }
    debug_assert_eq!(code.len() as u64, stub_len);
}

// ------------------------------------------------------------------
// Dynamic-linking metadata.
//
// Section ordering inside the r-x segment:
//   .interp .dynsym .dynstr .hash .rela.dyn
// All naturally 8-byte aligned.
// ------------------------------------------------------------------

/// Build .dynstr -- the dynamic string table. Returns
/// `(bytes, import_name_offsets, lib_offsets, export_name_offsets)`
/// where each offsets vec lists the byte offset within the
/// table for the corresponding name. Exports come from
/// `Build::exports`; their names are exposed externally so
/// `dlsym` can find them.
///
/// `(dynstr_bytes, import_offsets, lib_offsets, export_offsets,
/// copy_offsets)`.
type DynstrTables = (Vec<u8>, Vec<u32>, Vec<u32>, Vec<u32>, Vec<u32>);

fn build_dynstr(
    imports: &super::ResolvedImports,
    export_names: &[&str],
    copy_relocs: &[super::CopyRelocReq],
) -> DynstrTables {
    let mut bytes = Vec::new();
    bytes.push(0); // index 0 is conventionally the empty string

    let mut name_offsets = Vec::with_capacity(imports.imports.len());
    for imp in &imports.imports {
        name_offsets.push(bytes.len() as u32);
        bytes.extend_from_slice(imp.real_symbol.as_bytes());
        bytes.push(0);
    }

    let mut lib_offsets = Vec::with_capacity(imports.dylibs.len());
    for d in &imports.dylibs {
        lib_offsets.push(bytes.len() as u32);
        bytes.extend_from_slice(d.path.as_bytes());
        bytes.push(0);
    }

    let mut export_offsets = Vec::with_capacity(export_names.len());
    for name in export_names {
        export_offsets.push(bytes.len() as u32);
        bytes.extend_from_slice(name.as_bytes());
        bytes.push(0);
    }

    let mut copy_offsets = Vec::with_capacity(copy_relocs.len());
    for cr in copy_relocs {
        copy_offsets.push(bytes.len() as u32);
        bytes.extend_from_slice(cr.host_symbol.as_bytes());
        bytes.push(0);
    }

    // Pad to 8 so the next section starts aligned.
    while !bytes.len().is_multiple_of(8) {
        bytes.push(0);
    }

    (
        bytes,
        name_offsets,
        lib_offsets,
        export_offsets,
        copy_offsets,
    )
}

/// Build the static `.symtab` + `.strtab`: the SHT_SYMTAB sentinel at
/// index 0, one local `STT_FUNC` per import trampoline, then one local
/// `STT_FUNC` per defined function (named, with its address and length)
/// so the output is profilable without DWARF. Returns
/// `(symtab_bytes, strtab_bytes)`. All symbols are local, so the
/// section header's `sh_info` stays at the symbol count.
///
/// `text_vmaddr` is the runtime vmaddr of `build.text[0]` (i.e.
/// `code_vmaddr + stub_len`), so each symbol's `st_value` resolves
/// to the actual instruction address.
fn build_plt_symtab(
    build: &super::Build,
    text_vmaddr: u64,
    trampoline_size: u64,
    text_shndx: u16,
) -> (Vec<u8>, Vec<u8>) {
    let imports = &build.imports.imports;
    debug_assert_eq!(
        imports.len(),
        build.plt_trampoline_offsets.len(),
        "trampoline-offset count must match import count"
    );
    // A data import (bound through the GOT) has no trampoline
    // (`None` slot); a text symbol for it would mislabel whatever
    // code sits at the fabricated address.
    let plt_locals: Vec<(&str, usize)> = imports
        .iter()
        .zip(build.plt_trampoline_offsets.iter())
        .filter_map(|(imp, off)| off.map(|o| (imp.local_name.as_str(), o)))
        .collect();

    // .strtab: leading NUL (st_name=0 -> empty string sentinel)
    // followed by NUL-separated import names.
    let mut strtab = alloc::vec![0u8];
    let mut name_offsets: Vec<u32> = Vec::with_capacity(plt_locals.len());
    for &(name, _) in &plt_locals {
        name_offsets.push(strtab.len() as u32);
        strtab.extend_from_slice(name.as_bytes());
        strtab.push(0);
    }

    // .symtab: SHT_SYMTAB sentinel at index 0, then one local
    // STT_FUNC per trampoline. Local symbols come first by spec
    // (the .symtab section header's `sh_info` field points one
    // past the last local entry).
    let mut symtab: Vec<u8> = Vec::with_capacity((1 + plt_locals.len()) * ELF64_SYM_SIZE as usize);
    write_struct(
        &mut symtab,
        &Elf64Sym {
            st_name: 0,
            st_info: 0,
            st_other: 0,
            st_shndx: 0,
            st_value: 0,
            st_size: 0,
        },
    );
    for (i, &(_, tramp_offset)) in plt_locals.iter().enumerate() {
        let st_value = text_vmaddr + tramp_offset as u64;
        write_struct(
            &mut symtab,
            &Elf64Sym {
                st_name: name_offsets[i],
                // Local + STT_FUNC. Locals come before globals in
                // the table; with no globals, the section header's
                // `sh_info` is `n_locals + 1` -- past the last
                // local (the SHT_SYMTAB rule).
                st_info: (STB_LOCAL << 4) | STT_FUNC,
                st_other: 0,
                // .text section index. Shifts by two when the version
                // sections precede .rela.dyn (has_versions), so it is
                // passed in rather than hard-coded.
                st_shndx: text_shndx,
                st_value,
                st_size: trampoline_size,
            },
        );
    }
    // One local STT_FUNC per defined function so a profiler / `nm` /
    // `gdb` can attribute an address to a function and its length
    // without DWARF (perf maps a sample by `[st_value, st_value +
    // st_size)`, so a zero size leaves the function unattributable).
    // `func_names` covers global and static functions on the merged
    // path. The size is the span to the next function or trampoline
    // start, capped at the text length; collecting all of them as
    // boundaries handles any code layout.
    let text_len = build.text.len() as u64;
    let mut boundaries: Vec<u64> = build
        .func_ent_pcs
        .iter()
        .map(|&pc| build.pc_to_native[pc] as u64)
        .collect();
    boundaries.extend(
        build
            .plt_trampoline_offsets
            .iter()
            .flatten()
            .map(|&o| o as u64),
    );
    boundaries.push(text_len);
    boundaries.sort_unstable();
    for (i, name) in build.func_names.iter().enumerate() {
        let start = build.pc_to_native[build.func_ent_pcs[i]] as u64;
        let end = boundaries
            .iter()
            .copied()
            .find(|&b| b > start)
            .unwrap_or(text_len);
        let st_name = strtab.len() as u32;
        strtab.extend_from_slice(name.as_bytes());
        strtab.push(0);
        write_struct(
            &mut symtab,
            &Elf64Sym {
                st_name,
                st_info: (STB_LOCAL << 4) | STT_FUNC,
                st_other: 0,
                st_shndx: text_shndx,
                st_value: text_vmaddr + start,
                st_size: end.saturating_sub(start),
            },
        );
    }
    (symtab, strtab)
}

/// Build .dynsym. Layout:
///
/// * Index 0: zero sentinel (required by ELF).
/// * `[1, 1+n_imports)`: undefined imports (`STB_GLOBAL |
///   STT_NOTYPE`, `st_shndx = SHN_UNDEF`). Loader resolves
///   these via `.rela.dyn`.
/// * `[1+n_imports, 1+n_imports+n_exports)`: defined exports
///   (`STB_GLOBAL | STT_FUNC`, `st_shndx = 1` -- a placeholder
///   non-zero index since we don't emit section headers, but
///   `dlsym` only checks `SHN_UNDEF` to gate a name as
///   resolvable). `st_value` is the runtime VA of the
///   function.
#[allow(clippy::too_many_arguments)]
fn build_dynsym(
    import_name_offsets: &[u32],
    export_name_offsets: &[u32],
    export_addrs: &[u64],
    export_is_data: &[bool],
    copy_name_offsets: &[u32],
    copy_addrs: &[u64],
    copy_sizes: &[u64],
    copy_is_bss: &[bool],
    // Section-header indices a defined symbol resides in, so `nm` /
    // `readelf -s` attribute each export to its real section.
    text_shndx: u16,
    data_shndx: u16,
    bss_shndx: u16,
) -> Vec<u8> {
    debug_assert_eq!(export_name_offsets.len(), export_addrs.len());
    debug_assert_eq!(export_name_offsets.len(), export_is_data.len());
    debug_assert_eq!(copy_name_offsets.len(), copy_addrs.len());
    debug_assert_eq!(copy_name_offsets.len(), copy_sizes.len());
    let n_total =
        1 + import_name_offsets.len() + export_name_offsets.len() + copy_name_offsets.len();
    let mut out = Vec::with_capacity(n_total * ELF64_SYM_SIZE as usize);

    // Sentinel at index 0 -- all zero. Required by ELF.
    write_struct(
        &mut out,
        &Elf64Sym {
            st_name: 0,
            st_info: 0,
            st_other: 0,
            st_shndx: 0,
            st_value: 0,
            st_size: 0,
        },
    );

    for &name_off in import_name_offsets {
        write_struct(
            &mut out,
            &Elf64Sym {
                st_name: name_off,
                // c5's only dynamic-import mechanism today is
                // `#pragma binding(<lib>::<name>, "<sym>")`, and
                // every binding is reached via `Inst::CallExt`
                // (a call site) -- there's no path that imports a
                // data symbol. So tagging every import `STT_FUNC`
                // is correct in practice and gives `gdb` / `nm`
                // the right hint about callability. If we ever
                // grow an `extern int errno;`-style data import,
                // `ResolvedImport` would need an `is_function`
                // discriminator and this branch would pick
                // `STT_OBJECT` for the data case. The dynamic
                // linker doesn't care either way -- it resolves
                // by name -- so the worst case for a future
                // mis-tag is a confused debugger, not a broken
                // load.
                st_info: (STB_GLOBAL << 4) | STT_FUNC,
                st_other: 0, // STV_DEFAULT
                st_shndx: SHN_UNDEF,
                st_value: 0,
                st_size: 0,
            },
        );
    }

    for ((&name_off, &addr), &is_data) in export_name_offsets
        .iter()
        .zip(export_addrs.iter())
        .zip(export_is_data.iter())
    {
        // A code export is STT_FUNC; a data global (`--export-data`,
        // e.g. a `PyTypeObject`) is STT_OBJECT so `nm` / a debugger
        // classify it correctly. The dynamic linker resolves by name
        // and ignores the type, so a `dlsym` lookup works either way.
        let st_type = if is_data { STT_OBJECT } else { STT_FUNC };
        write_struct(
            &mut out,
            &Elf64Sym {
                st_name: name_off,
                st_info: (STB_GLOBAL << 4) | st_type,
                st_other: 0,
                // The export resides in .data (a data global) or .text
                // (a code export). dlsym resolves by name regardless,
                // but section-attributing consumers need the real index.
                st_shndx: if is_data { data_shndx } else { text_shndx },
                st_value: addr,
                st_size: 0,
            },
        );
    }
    // Copy-relocation targets: a defined `STT_OBJECT` per data import.
    // The loader resolves the matching `R_*_COPY` by copying the host
    // object's initial value here and binding the host symbol to this
    // address, so every other module's reference reaches this slot.
    for (((&name_off, &addr), &size), &is_bss) in copy_name_offsets
        .iter()
        .zip(copy_addrs.iter())
        .zip(copy_sizes.iter())
        .zip(copy_is_bss.iter())
    {
        write_struct(
            &mut out,
            &Elf64Sym {
                st_name: name_off,
                st_info: (STB_GLOBAL << 4) | STT_OBJECT,
                st_other: 0,
                // The target slot is in .bss (zero-fill tail) or .data.
                st_shndx: if is_bss { bss_shndx } else { data_shndx },
                st_value: addr,
                st_size: size,
            },
        );
    }
    debug_assert_eq!(out.len() as u64, n_total as u64 * ELF64_SYM_SIZE);
    out
}

/// SysV ELF hash function -- the one DT_HASH wants.
fn elf_hash(name: &[u8]) -> u32 {
    let mut h: u32 = 0;
    for &b in name {
        h = (h << 4).wrapping_add(b as u32);
        let g = h & 0xF000_0000;
        if g != 0 {
            h ^= g >> 24;
        }
        h &= !g;
    }
    h
}

/// Build the DT_HASH table over `.dynsym`. Layout:
///   nbucket (u32), nchain (u32), bucket[nbucket], chain[nchain]
/// nchain == nsyms (the number of dynsym entries, counting the
/// sentinel). Each bucket holds the index of a sym, or 0 if empty;
/// chain[i] holds the next sym in the chain after sym `i`, or 0 to
/// terminate.
fn build_hash(name_offsets: &[u32], dynstr: &[u8]) -> Vec<u8> {
    let nsyms = (1 + name_offsets.len()) as u32;
    // Pick a small odd bucket count; doesn't have to be tuned.
    let nbucket = 7u32.min(nsyms.max(1));
    let mut buckets = vec![0u32; nbucket as usize];
    let mut chain = vec![0u32; nsyms as usize];

    for (i, &name_off) in name_offsets.iter().enumerate() {
        let sym_idx = (i + 1) as u32; // sentinel is index 0
        let name = name_bytes(dynstr, name_off as usize);
        let bkt = (elf_hash(name) % nbucket) as usize;
        // Insert at the head of the bucket's chain.
        chain[sym_idx as usize] = buckets[bkt];
        buckets[bkt] = sym_idx;
    }

    let mut out = Vec::with_capacity((2 + nbucket as usize + nsyms as usize) * 4);
    put_u32(&mut out, nbucket);
    put_u32(&mut out, nsyms);
    for b in &buckets {
        put_u32(&mut out, *b);
    }
    for c in &chain {
        put_u32(&mut out, *c);
    }
    while !out.len().is_multiple_of(8) {
        out.push(0);
    }
    out
}

/// Slice a NUL-terminated name out of a string table at `offset`.
fn name_bytes(strtab: &[u8], offset: usize) -> &[u8] {
    let end = strtab[offset..]
        .iter()
        .position(|&b| b == 0)
        .map(|p| offset + p)
        .unwrap_or(strtab.len());
    &strtab[offset..end]
}

/// Build .rela.dyn -- one `R_*_GLOB_DAT` relocation per import.
/// `got_vmaddr` is the runtime address of the start of the .got
/// section so `r_offset` can name the correct slot. The relocation
/// type varies by machine.
fn build_rela_dyn(got_vmaddr: u64, n_imports: usize, machine: Machine) -> Vec<u8> {
    let r_type = r_glob_dat(machine);
    let mut out = Vec::with_capacity(n_imports * ELF64_RELA_SIZE as usize);
    for i in 0..n_imports {
        // r_addend is ignored for GLOB_DAT; sym index is +1 to skip
        // the sentinel at dynsym[0].
        let sym_idx = (i as u64) + 1;
        write_struct(
            &mut out,
            &Elf64Rela {
                r_offset: got_vmaddr + (i as u64) * 8,
                r_info: (sym_idx << 32) | r_type,
                r_addend: 0,
            },
        );
    }
    out
}

/// Build .dynamic -- the table the loader walks to find every other
/// section. Each entry is `(d_tag, d_un)` 16 bytes. One DT_NEEDED
/// per [`NEEDED_LIBS`] entry, then the standard pointer-and-size
/// tags for the symbol / string / hash / rela sections.
fn build_dynamic(lib_strtab_offsets: &[u32], info: DynamicInfo) -> Vec<u8> {
    let mut out = Vec::with_capacity((lib_strtab_offsets.len() + 11) * ELF64_DYN_SIZE as usize);
    for &off in lib_strtab_offsets {
        write_struct(
            &mut out,
            &Elf64Dyn {
                d_tag: DT_NEEDED,
                d_val: off as u64,
            },
        );
    }
    let mut entries: Vec<(u64, u64)> = alloc::vec![
        (DT_HASH, info.hash_vmaddr),
        (DT_STRTAB, info.strtab_vmaddr),
        (DT_SYMTAB, info.symtab_vmaddr),
        (DT_STRSZ, info.strtab_size),
        (DT_SYMENT, ELF64_SYM_SIZE),
        (DT_RELA, info.rela_vmaddr),
        (DT_RELASZ, info.rela_size),
        (DT_RELAENT, ELF64_RELA_SIZE),
        (DT_BIND_NOW, 0),
        (DT_FLAGS, DF_BIND_NOW),
    ];
    // Version tags precede DT_NULL. The dynamic linker reads DT_VERSYM /
    // DT_VERNEED to bind each import to its required symbol version.
    if let Some(v) = info.versions {
        entries.push((DT_VERSYM, v.versym_vmaddr));
        entries.push((DT_VERNEED, v.verneed_vmaddr));
        entries.push((DT_VERNEEDNUM, v.verneed_num));
    }
    entries.push((DT_NULL, 0));
    for (d_tag, d_val) in entries {
        write_struct(&mut out, &Elf64Dyn { d_tag, d_val });
    }
    out
}

/// Group of vmaddr/size values [`build_dynamic`] consumes. Only
/// exists to keep the signature short -- the writer computes them
/// all in one pass.
#[derive(Debug, Clone, Copy)]
struct DynamicInfo {
    hash_vmaddr: u64,
    strtab_vmaddr: u64,
    symtab_vmaddr: u64,
    rela_vmaddr: u64,
    rela_size: u64,
    strtab_size: u64,
    versions: Option<VersionInfo>,
}

/// A defined dynamic-symbol export for the ELF writer. `offset` is a
/// byte offset within `build.text` (`section == Text`) or `build.data`
/// (`section == Data`); the writer adds the matching runtime base and
/// picks STT_FUNC or STT_OBJECT.
struct ElfExport {
    name: String,
    section: super::DynamicExportSection,
    offset: u64,
}

/// One `.gnu.version_r` Vernaux: `(version dynstr offset, elf_hash,
/// assigned version index)`.
type Vernaux = (u32, u32, u16);
/// One `.gnu.version_r` Verneed: `(soname dynstr offset, its Vernaux
/// list)`.
type VerneedGroup = (u32, Vec<Vernaux>);

/// `.gnu.version` / `.gnu.version_r` placement for [`build_dynamic`].
#[derive(Debug, Clone, Copy)]
struct VersionInfo {
    versym_vmaddr: u64,
    verneed_vmaddr: u64,
    verneed_num: u64,
}

// ------------------------------------------------------------------
// Adrp/ldr/add fixup patching. The codegen records GotFixup,
// DataFixup, and FuncFixup entries against `Build::text` byte offsets;
// we shift those by `START_STUB_LEN` (since the stub sits in front of
// build.text in the final code blob) and patch the immediates the
// same way the Mach-O writer does.
// ------------------------------------------------------------------

/// Patch an `adrp Xd, page; ldr Xd, [Xd, #imm12]` pair so it loads
/// the value at `target_vmaddr` -- here the address of a libc symbol
/// that the loader has written into .got.
fn patch_adrp_ldr(
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    adrp_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    let adrp_file_off = (code_base_in_file + adrp_offset_in_code) as usize;
    let ldr_file_off = adrp_file_off + 4;
    let adrp_vmaddr = code_vmaddr_base + adrp_offset_in_code;

    let adrp_page = adrp_vmaddr & !0xFFF;
    let target_page = target_vmaddr & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("ELF: {label} page diff {page_diff} not 4 KiB aligned"),
        )));
    }
    let imm21 = (page_diff >> 12) as i32;
    let in_page = (target_vmaddr & 0xFFF) as u32;
    if !in_page.is_multiple_of(8) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("ELF: {label} slot offset {in_page:#x} not 8-aligned"),
        )));
    }

    let adrp_word = aarch64::enc_adrp(aarch64::Reg::X16, imm21);
    let ldr_word = aarch64::enc_ldr_imm(aarch64::Reg::X16, aarch64::Reg::X16, in_page);
    out[adrp_file_off..adrp_file_off + 4].copy_from_slice(&adrp_word.to_le_bytes());
    out[ldr_file_off..ldr_file_off + 4].copy_from_slice(&ldr_word.to_le_bytes());
    Ok(())
}

/// Per-machine dispatch for "load an absolute address into the
/// accumulator". aarch64 uses an `adrp + add` pair; x86_64 uses a
/// single `lea r13, [rip + disp32]`. The codegen records the
/// instruction's start offset under the same field name; the
/// per-arch patcher knows the encoding.
fn patch_addr_load(
    machine: Machine,
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    match machine {
        Machine::Aarch64 => patch_adrp_add(
            out,
            code_base_in_file,
            code_vmaddr_base,
            instr_offset_in_code,
            target_vmaddr,
            label,
        ),
        Machine::X86_64 => patch_lea_rip32(
            out,
            code_base_in_file,
            code_vmaddr_base,
            instr_offset_in_code,
            target_vmaddr,
            label,
        ),
    }
}

/// Per-machine dispatch for "call a libc function whose address
/// lives in the GOT". aarch64 emits adrp+ldr+blr -- patch the
/// adrp+ldr immediates. x86_64 emits `call qword [rip + disp32]` --
/// patch the disp32.
fn patch_got_call(
    machine: Machine,
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    match machine {
        Machine::Aarch64 => patch_adrp_ldr(
            out,
            code_base_in_file,
            code_vmaddr_base,
            instr_offset_in_code,
            target_vmaddr,
            label,
        ),
        Machine::X86_64 => patch_call_qword_rip32(
            out,
            code_base_in_file,
            code_vmaddr_base,
            instr_offset_in_code,
            target_vmaddr,
            label,
        ),
    }
}

/// Patch the disp32 field of `call qword [rip + disp32]` so the
/// loaded pointer is at `target_vmaddr`. The `disp32` is measured
/// from the byte *after* the call (i.e. from
/// `instr_vmaddr + CALL_QWORD_RIP32_LEN`).
fn patch_call_qword_rip32(
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    let call_len = x86_64::CALL_QWORD_RIP32_LEN as u64;
    let instr_vmaddr = code_vmaddr_base + instr_offset_in_code;
    let after = instr_vmaddr + call_len;
    let delta = target_vmaddr as i64 - after as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("ELF: {label} disp {delta} doesn't fit in 32 bits"),
        )));
    }
    let disp32 = delta as i32;
    // disp32 is the last 4 bytes of `FF 15 dd dd dd dd`.
    let disp_file_off = (code_base_in_file + instr_offset_in_code + call_len - 4) as usize;
    out[disp_file_off..disp_file_off + 4].copy_from_slice(&disp32.to_le_bytes());
    Ok(())
}

/// Patch the disp32 field of `lea r64, [rip + disp32]` so the
/// instruction computes `target_vmaddr` into its destination. The
/// `disp32` is measured from the byte *after* the lea (i.e. from
/// `instr_vmaddr + LEA_RIP32_LEN`). 32-bit signed range, ~+/-2 GiB.
fn patch_lea_rip32(
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    let lea_len = x86_64::LEA_RIP32_LEN as u64;
    let instr_vmaddr = code_vmaddr_base + instr_offset_in_code;
    let after = instr_vmaddr + lea_len;
    let delta = target_vmaddr as i64 - after as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("ELF: {label} disp {delta} doesn't fit in 32 bits"),
        )));
    }
    let disp32 = delta as i32;
    // disp32 is the last 4 bytes of a 7-byte LEA encoding:
    //   REX.W + 0x8D + ModR/M + 4*disp
    let disp_file_off = (code_base_in_file + instr_offset_in_code + lea_len - 4) as usize;
    out[disp_file_off..disp_file_off + 4].copy_from_slice(&disp32.to_le_bytes());
    Ok(())
}

/// Patch an `adrp Xd, page; add Xd, Xd, #imm12` pair so the result
/// equals `target_vmaddr`. Used for data-segment references and
/// function-pointer literals; both are absolute-address materializations.
fn patch_adrp_add(
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    adrp_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    let adrp_file_off = (code_base_in_file + adrp_offset_in_code) as usize;
    let add_file_off = adrp_file_off + 4;
    let adrp_vmaddr = code_vmaddr_base + adrp_offset_in_code;

    let adrp_page = adrp_vmaddr & !0xFFF;
    let target_page = target_vmaddr & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("ELF: {label} page diff {page_diff} not 4 KiB aligned"),
        )));
    }
    let imm21 = (page_diff >> 12) as i32;
    let in_page = (target_vmaddr & 0xFFF) as u32;

    // Recover the destination register encoded by the codegen at the
    // placeholder site. adrp/add carry the rd in the low 5 bits; the
    // add additionally carries rn in bits 5..10. Both registers match
    // by construction (`adrp rd; add rd, rd, #imm`).
    let prev_adrp = u32::from_le_bytes([
        out[adrp_file_off],
        out[adrp_file_off + 1],
        out[adrp_file_off + 2],
        out[adrp_file_off + 3],
    ]);
    let prev_add = u32::from_le_bytes([
        out[add_file_off],
        out[add_file_off + 1],
        out[add_file_off + 2],
        out[add_file_off + 3],
    ]);
    let rd = (prev_adrp & 0x1F) as u8;
    let add_rd = (prev_add & 0x1F) as u8;
    let add_rn = ((prev_add >> 5) & 0x1F) as u8;
    let adrp_word = aarch64::enc_adrp(aarch64::Reg(rd), imm21);
    let add_word = aarch64::enc_add_imm(aarch64::Reg(add_rd), aarch64::Reg(add_rn), in_page);
    out[adrp_file_off..adrp_file_off + 4].copy_from_slice(&adrp_word.to_le_bytes());
    out[add_file_off..add_file_off + 4].copy_from_slice(&add_word.to_le_bytes());
    Ok(())
}

// ------------------------------------------------------------------
// Top-level writer.
// ------------------------------------------------------------------

/// Resolve each import's default library version from the host
/// libraries, parallel to `imports.imports`. Flat-namespace imports
/// (host symbols a shared library resolves at load) are left
/// unversioned. Empty under `no_std`, which emits no native images.
#[cfg(feature = "std")]
fn resolve_import_version_reqs(
    imports: &super::ResolvedImports,
    machine: super::Machine,
) -> Vec<Option<(String, String)>> {
    use alloc::collections::BTreeMap;
    let names: Vec<String> = imports
        .imports
        .iter()
        .map(|i| i.real_symbol.clone())
        .collect();
    let dylibs: Vec<String> = imports.dylibs.iter().map(|d| d.path.clone()).collect();
    let mut map: BTreeMap<String, u32> = BTreeMap::new();
    for imp in &imports.imports {
        map.entry(imp.real_symbol.clone())
            .or_insert(imp.dylib_index as u32);
    }
    let mut reqs = super::so_versions::resolve_import_versions(&names, &dylibs, &map, machine);
    for (req, imp) in reqs.iter_mut().zip(imports.imports.iter()) {
        if imp.flat_lookup {
            *req = None;
        }
    }
    reqs
}

#[cfg(not(feature = "std"))]
fn resolve_import_version_reqs(
    imports: &super::ResolvedImports,
    _machine: super::Machine,
) -> Vec<Option<(String, String)>> {
    alloc::vec![None; imports.imports.len()]
}

pub(super) fn write(
    program: &Program,
    build: &Build,
    machine: Machine,
) -> Result<Vec<u8>, C5Error> {
    let is_shared = build.output_kind == super::OutputKind::SharedLibrary;
    // ELF executables are position-independent (ET_DYN / PIE), matching the
    // Mach-O output and the modern default: the loader slides the image at a
    // random base and the `.rela.dyn` R_*_RELATIVE entries fix up every
    // internal absolute pointer in static data. Shared libraries are already
    // ET_DYN. `emit_dyn` therefore holds for every ELF image the writer emits;
    // the entry stub and `e_entry` stay gated on `!is_shared`.
    let emit_dyn = true;
    // Both backends lower `_Thread_local` access with the local-exec
    // model, whose TP-relative offsets are valid only in the
    // executable's static TLS block; baked into ET_DYN they address
    // another module's TLS. TODO: implement the general-dynamic TLS
    // model for ELF shared-library output.
    if is_shared && !build.tls_data.is_empty() {
        return Err(C5Error::Compile(crate::c5::error::fmt_link_err(
            "_Thread_local data is not supported in ELF shared-library output: \
             only the executable-model (local-exec) TLS sequence is implemented",
        )));
    }
    let n_imports = build.imports.imports.len();
    // Pick the libc-exit tail when the user has any
    // libc `exit` import (typically through `<stdlib.h>`),
    // otherwise emit a direct sys_exit_group syscall and avoid
    // pulling libc in just to terminate. Stays opt-in to libc so
    // programs that print via stdio still get glibc's
    // end-of-process flush.
    let use_libc_exit = build.imports.imports.iter().any(|i| i.local_name == "exit");
    // When the startup runtime is linked it defines `__c5_entry`; the
    // image entry is then a minimal adapter that hands the stack
    // pointer + image-base offset to it and `__c5_entry` runs the
    // process startup. Without it (single-TU or freestanding output)
    // the self-contained `_start` reads argc/argv and exits directly.
    let c5_entry_offset = if is_shared {
        None
    } else {
        symbol_text_offset(build, "__c5_entry")
    };
    // Shared libraries don't have a `_start` stub -- dyld
    // never jumps into them, callers reach exports via
    // `dlsym`.
    let stub_len = if is_shared {
        0
    } else if c5_entry_offset.is_some() {
        entry_adapter_len(machine)
    } else {
        start_stub_len(machine, use_libc_exit)
    };
    // Defined `.dynsym` export entries. A shared library always exports;
    // an executable exports under `--export-all` (functions, via
    // `Build::exports`) and `--export-data` (every global, function and
    // data, via `Build::dynamic_exports`) -- the `-rdynamic` behaviour
    // that lets a `dlopen`'d module resolve the host's symbols from the
    // global scope. Each entry carries the section it lives in so the
    // dynsym picks STT_FUNC (`.text`) or STT_OBJECT (`.data`); the offset
    // is a byte offset within `build.text` / `build.data`. An ordinary
    // executable has no exports, so the tables are unchanged.
    let mut elf_exports: Vec<ElfExport> = Vec::new();
    for exp in &build.exports {
        let native_off = build
            .pc_to_native
            .get(exp.ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if native_off == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "ELF: exported function `{}` (bc PC {}) doesn't \
                 align with any native instruction",
                    exp.name, exp.ent_pc
                ),
            )));
        }
        elf_exports.push(ElfExport {
            name: exp.name.clone(),
            section: super::DynamicExportSection::Text,
            offset: native_off as u64,
        });
    }
    for d in &build.dynamic_exports {
        if !elf_exports.iter().any(|e| e.name == d.name) {
            elf_exports.push(ElfExport {
                name: d.name.clone(),
                section: d.section,
                offset: d.offset,
            });
        }
    }
    let export_names: Vec<&str> = elf_exports.iter().map(|e| e.name.as_str()).collect();
    let export_is_data: Vec<bool> = elf_exports
        .iter()
        .map(|e| e.section == super::DynamicExportSection::Data)
        .collect();

    // ---- Build the dynamic-linking metadata up front so we know the
    //      sizes for layout calculations. ----
    let (mut dynstr, name_offsets, lib_strtab_offsets, export_name_offsets, copy_name_offsets) =
        build_dynstr(&build.imports, &export_names, &build.copy_relocs);
    let copy_sizes: Vec<u64> = build.copy_relocs.iter().map(|cr| cr.size).collect();
    let copy_is_bss: Vec<bool> = build.copy_relocs.iter().map(|cr| cr.is_bss).collect();
    let n_copy = build.copy_relocs.len();
    // Compute each export's and copy target's runtime VA. We fill in the
    // real values after layout is fixed and `code_vmaddr` is known; here
    // we just reserve the slots.
    let export_addrs_placeholder: Vec<u64> = vec![0; elf_exports.len()];
    let copy_addrs_placeholder: Vec<u64> = vec![0; n_copy];
    // Size-only placeholder build (zero addresses); the section indices
    // here are irrelevant because only the final build below is written.
    let dynsym = build_dynsym(
        &name_offsets,
        &export_name_offsets,
        &export_addrs_placeholder,
        &export_is_data,
        &copy_name_offsets,
        &copy_addrs_placeholder,
        &copy_sizes,
        &copy_is_bss,
        0,
        0,
        0,
    );
    // The hash table must cover every `.dynsym` entry, in dynsym
    // order: imports occupy indices [1, 1+n_imports), exports the
    // range after, then the copy-relocation targets. Hashing only the
    // imports leaves `dlsym` (and the loader's COPY-reloc lookup)
    // unable to resolve a symbol whose name never lands in a bucket
    // chain. Executables without exports or copy relocs hash the import
    // list alone.
    let mut hash_name_offsets: Vec<u32> = Vec::with_capacity(
        name_offsets.len() + export_name_offsets.len() + copy_name_offsets.len(),
    );
    hash_name_offsets.extend_from_slice(&name_offsets);
    hash_name_offsets.extend_from_slice(&export_name_offsets);
    hash_name_offsets.extend_from_slice(&copy_name_offsets);
    let hash = build_hash(&hash_name_offsets, &dynstr);
    // .rela.dyn is built later -- it needs got_vmaddr.

    // GNU symbol-version requirements. Each import the driver bound to
    // a default library version gets a `.gnu.version` index referencing
    // a `.gnu.version_r` Vernaux; the rest stay VER_NDX_GLOBAL. The
    // version-name strings are appended to `.dynstr` (after the symbol
    // and library names, which keeps their offsets fixed); the Verneed
    // records group versions by providing library. `.gnu.version` holds
    // one entry per `.dynsym` symbol, so its length tracks the import +
    // export + copy-relocation symbol count.
    let total_dynsym = 1 + name_offsets.len() + export_name_offsets.len() + copy_name_offsets.len();
    // Resolve each import's default library version from the host
    // libraries. Done at this single convergence point (every native
    // ELF link reaches `elf::write`); no requirement is recorded when a
    // library can't be read (cross-links), leaving the import
    // unversioned. Empty under `no_std`, which emits no native images.
    let import_version_reqs = resolve_import_version_reqs(&build.imports, machine);
    let mut import_versym: Vec<u16> = alloc::vec![VER_NDX_GLOBAL; n_imports];
    let mut verneed_groups: Vec<VerneedGroup> = Vec::new();
    let mut version_str_off: alloc::collections::BTreeMap<String, u32> =
        alloc::collections::BTreeMap::new();
    let mut next_ver_index: u16 = VER_NDX_FIRST;
    for (i, req) in import_version_reqs.iter().enumerate() {
        let Some((soname, version)) = req else {
            continue;
        };
        // Group the requirement under the library that exports the
        // default version, which the resolver recorded. It may differ
        // from the import's nominal dylib.
        let Some(dyl_idx) = build.imports.dylibs.iter().position(|d| &d.path == soname) else {
            continue;
        };
        let Some(&soname_off) = lib_strtab_offsets.get(dyl_idx) else {
            continue;
        };
        let ver_off = *version_str_off.entry(version.clone()).or_insert_with(|| {
            let off = dynstr.len() as u32;
            dynstr.extend_from_slice(version.as_bytes());
            dynstr.push(0);
            off
        });
        let group = match verneed_groups.iter_mut().find(|(s, _)| *s == soname_off) {
            Some(g) => g,
            None => {
                verneed_groups.push((soname_off, Vec::new()));
                verneed_groups.last_mut().unwrap()
            }
        };
        let idx = match group.1.iter().find(|(o, _, _)| *o == ver_off) {
            Some((_, _, idx)) => *idx,
            None => {
                let idx = next_ver_index;
                next_ver_index += 1;
                group.1.push((ver_off, elf_hash(version.as_bytes()), idx));
                idx
            }
        };
        import_versym[i] = idx;
    }
    // Version names extend `.dynstr` past `build_dynstr`'s pad; re-pad
    // so the sections laid out from `dynstr.len()` (`.hash`,
    // `.gnu.version`) stay congruent with their claimed sh_addralign.
    while !dynstr.len().is_multiple_of(8) {
        dynstr.push(0);
    }
    let has_versions = !verneed_groups.is_empty();
    // Two extra allocated sections (.gnu.version / .gnu.version_r) precede
    // .rela.dyn when has_versions, shifting .text onward by two. Symbols
    // whose st_shndx names .text must use this shifted index.
    let ver_shdrs: u16 = if has_versions { 2 } else { 0 };
    let text_shndx: u16 = 6 + ver_shdrs;
    let (gnu_version, gnu_version_r): (Vec<u8>, Vec<u8>) = if has_versions {
        let mut versym: Vec<u8> = Vec::with_capacity(total_dynsym * 2);
        versym.extend_from_slice(&0u16.to_le_bytes()); // null symbol
        for v in &import_versym {
            versym.extend_from_slice(&v.to_le_bytes());
        }
        // Exports and copy targets are defined and unversioned.
        for _ in 0..(total_dynsym - 1 - n_imports) {
            versym.extend_from_slice(&VER_NDX_GLOBAL.to_le_bytes());
        }
        let mut verneed: Vec<u8> = Vec::new();
        for (gi, (soname_off, auxes)) in verneed_groups.iter().enumerate() {
            let vn_next: u32 = if gi + 1 == verneed_groups.len() {
                0
            } else {
                (16 + auxes.len() * 16) as u32
            };
            verneed.extend_from_slice(&1u16.to_le_bytes()); // vn_version
            verneed.extend_from_slice(&(auxes.len() as u16).to_le_bytes()); // vn_cnt
            verneed.extend_from_slice(&soname_off.to_le_bytes()); // vn_file
            verneed.extend_from_slice(&16u32.to_le_bytes()); // vn_aux
            verneed.extend_from_slice(&vn_next.to_le_bytes()); // vn_next
            for (ai, (ver_off, hash, ver_index)) in auxes.iter().enumerate() {
                let vna_next: u32 = if ai + 1 == auxes.len() { 0 } else { 16 };
                verneed.extend_from_slice(&hash.to_le_bytes()); // vna_hash
                verneed.extend_from_slice(&0u16.to_le_bytes()); // vna_flags
                verneed.extend_from_slice(&ver_index.to_le_bytes()); // vna_other
                verneed.extend_from_slice(&ver_off.to_le_bytes()); // vna_name
                verneed.extend_from_slice(&vna_next.to_le_bytes()); // vna_next
            }
        }
        (versym, verneed)
    } else {
        (Vec::new(), Vec::new())
    };

    let interp_path_str = interp_path(machine);

    // .interp string (NUL-terminated). Round up to 8 so the next
    // section starts aligned.
    let mut interp = interp_path_str.as_bytes().to_vec();
    interp.push(0);
    while !interp.len().is_multiple_of(8) {
        interp.push(0);
    }

    // ---- Layout pass 1: compute file offsets in r-x segment. ----
    //
    // PT_TLS is added when the program has any `_Thread_local`
    // globals; the loader (`ld-linux-aarch64.so.1` /
    // `ld-linux-x86-64.so.2`) uses it to size per-thread TLS at
    // thread creation. `.tdata` (initialised TLS image) is the
    // first `tls_init_size` bytes of `build.tls_data`; `.tbss`
    // (zero-fill TLS) covers the remainder. We emit `.tdata` into
    // file storage immediately after `.data`; `.tbss` is
    // zero-filled (no file storage) and accounted for via PT_TLS's
    // `p_memsz - p_filesz` only.
    let has_tls = !build.tls_data.is_empty();
    let n_program_headers = N_BASE_PROGRAM_HEADERS + if has_tls { 1 } else { 0 };
    let phoff = ELF_HEADER_SIZE;
    let phsize = n_program_headers * PROGRAM_HEADER_SIZE;

    let interp_off = phoff + phsize;
    let dynsym_off = interp_off + interp.len() as u64;
    let dynstr_off = dynsym_off + dynsym.len() as u64;
    let hash_off = dynstr_off + dynstr.len() as u64;
    // `.gnu.version` / `.gnu.version_r` sit between `.hash` and
    // `.rela.dyn` when any import carries a version requirement. With
    // none, both are empty and the layout is byte-identical.
    let after_hash = hash_off + hash.len() as u64;
    let gnu_version_off = after_hash;
    let gnu_version_r_off = if has_versions {
        round_up(gnu_version_off + gnu_version.len() as u64, 8)
    } else {
        after_hash
    };
    let rela_off = if has_versions {
        round_up(gnu_version_r_off + gnu_version_r.len() as u64, 8)
    } else {
        after_hash
    };
    // A shared object turns each internal absolute pointer in static data
    // (a function / data pointer initializer) into an R_*_RELATIVE
    // relocation so it tracks the runtime load base; an executable maps at
    // its link-time vmaddr, so the baked bytes are final and need none.
    let n_relative = if emit_dyn {
        build.data_relocs.len() + build.code_relocs.len()
    } else {
        0
    };
    let rela_size = (n_imports as u64 + n_relative as u64 + n_copy as u64) * ELF64_RELA_SIZE;
    let code_off = round_up(rela_off + rela_size, 16);

    // Build the code blob: _start stub + build.text (with shifted
    // fixup offsets at write time). For shared-library output
    // we skip the stub entirely; dyld won't run it (no entry
    // point), and emitting one would force a libc-exit
    // import that isn't otherwise needed.
    let mut code: Vec<u8> = Vec::with_capacity(stub_len as usize + build.text.len());
    // `Some(byte_offset)` for the libc-exit GOT placeholder, or
    // `None` when the stub direct-syscalls / for shared
    // libraries that emit no stub at all. `None` short-circuits
    // the writer's later GOT-fixup patch.
    let exit_adrp_offset = if is_shared {
        None
    } else if let Some(entry_off) = c5_entry_offset {
        // The adapter reaches `__c5_entry` (in `build.text`, past the
        // adapter) with a relative call and exits through it, so there
        // is no libc-exit GOT slot to patch here.
        emit_entry_adapter(machine, build.abi, &mut code, entry_off, code_off);
        None
    } else {
        emit_start_stub(
            machine,
            build.abi,
            &mut code,
            build.entry_offset as u64,
            use_libc_exit,
        )
    };
    code.extend_from_slice(&build.text);
    let code_size = code.len() as u64;

    let segment1_filesize = code_off + code_size;
    let seg = seg_align(machine);
    let segment1_end = round_up(segment1_filesize, seg);

    // ---- Layout pass 2: rw segment (.dynamic, .got, build.data,
    //      .tdata, .tbss). ----
    let segment2_off = segment1_end;
    let dynamic_off = segment2_off;
    // `build_dynamic` emits one DT_NEEDED per resolved dylib plus
    // 11 fixed tags (DT_HASH, DT_STRTAB, ..., DT_NULL terminator).
    let version_dyn_tags: u64 = if has_versions { 3 } else { 0 };
    let dynamic_size = (build.imports.dylibs.len() as u64 + 11 + version_dyn_tags) * ELF64_DYN_SIZE;
    let got_off = dynamic_off + dynamic_size;
    let got_size = (n_imports as u64) * 8;
    // `.data`'s base alignment: p_vaddr == p_offset within the RW
    // segment, so aligning the file offset aligns the vaddr.
    let data_align = build.data_align.max(8) as u64;
    let data_off = round_up(got_off + got_size, data_align);
    let data_size = build.data.len() as u64;
    // PT_TLS requires `p_vaddr % p_align == 0` (ELF gABI), and glibc
    // computes a `_Thread_local`'s address as `tp - roundup(p_memsz,
    // p_align) + var_offset`. A misaligned TLS image makes the loader
    // place the block at an offset the linker's TPOFFs don't account
    // for, so reads land off the variable. `tdata_vmaddr` tracks
    // `tdata_off` (the base is page-aligned), so aligning the file
    // offset aligns the vaddr.
    let tdata_off = if has_tls {
        round_up(data_off + data_size, TLS_SEGMENT_ALIGN)
    } else {
        data_off + data_size
    };
    let tdata_size = build.tls_init_size as u64;
    let tbss_size = build.tls_data.len() as u64 - tdata_size;
    let segment2_filesize = tdata_off + tdata_size - segment2_off;
    // Regular zero-init data (`.bss`) sits at the very end of the RW
    // segment, past `.data` / `.tdata` / `.tbss`, with no file backing.
    // A data offset at or past `data_size` names a byte here, at
    // `bss_vmaddr + (offset - data_size)`, which the loader zero-fills
    // through `p_memsz > p_filesz`.
    let bss_vmaddr = TEXT_VMADDR_BASE + segment2_off + segment2_filesize + tbss_size;
    // The PT_LOAD's p_memsz must cover `.tbss` and `.bss` even though
    // neither has file backing -- the loader zero-fills the difference.
    let segment2_memsize = segment2_filesize + tbss_size + build.bss_size as u64;
    let segment2_end = round_up(segment2_off + segment2_filesize, seg);

    // ---- VM addresses (ET_EXEC, no slide). ----
    let interp_vmaddr = TEXT_VMADDR_BASE + interp_off;
    let dynsym_vmaddr = TEXT_VMADDR_BASE + dynsym_off;
    let dynstr_vmaddr = TEXT_VMADDR_BASE + dynstr_off;
    let hash_vmaddr = TEXT_VMADDR_BASE + hash_off;
    let gnu_version_vmaddr = TEXT_VMADDR_BASE + gnu_version_off;
    let gnu_version_r_vmaddr = TEXT_VMADDR_BASE + gnu_version_r_off;
    let rela_vmaddr = TEXT_VMADDR_BASE + rela_off;
    let code_vmaddr = TEXT_VMADDR_BASE + code_off;
    let dynamic_vmaddr = TEXT_VMADDR_BASE + dynamic_off;
    let got_vmaddr = TEXT_VMADDR_BASE + got_off;
    let data_vmaddr = TEXT_VMADDR_BASE + data_off;
    let tdata_vmaddr = TEXT_VMADDR_BASE + tdata_off;

    // Runtime VA of a data-segment byte: `.data` for an offset within the
    // file image, otherwise the zero-fill `.bss` tail past it.
    let data_off_to_vaddr = |off: u64| -> u64 {
        if off < data_size {
            data_vmaddr + off
        } else {
            bss_vmaddr + (off - data_size)
        }
    };

    // ---- Layout pass 3: DWARF + section header table ----
    //
    // The DWARF debug sections aren't loaded (no PT_LOAD covers
    // them, no SHF_ALLOC) -- they're metadata that lldb / gdb
    // pick up by walking the section header table. We append:
    //
    //   <segment2_end aligned to seg>
    //   .debug_info | .debug_abbrev | .debug_line | .debug_str
    //   .shstrtab (the section name string table)
    //   <pad to 8>
    //   section header table (6 * 64 bytes)
    //
    // The CU's `low_pc` references address into the loaded
    // text segment, so dwarf::emit needs the runtime vmaddr of
    // `build.text[0]` -- which is `code_vmaddr + stub_len` (the
    // _start stub sits ahead of build.text in the code blob;
    // shared libraries skip the stub so stub_len = 0 there).
    let dwarf_text_vmaddr = code_vmaddr + stub_len;
    let elf_target = match machine {
        super::Machine::Aarch64 => super::Target::LinuxAarch64,
        super::Machine::X86_64 => super::Target::LinuxX64,
    };
    // Skip the type-catalog walk + line program entirely
    // when the user passed `--no-debug`. Empty sections collapse
    // every `dwarf_*_off` into `dwarf_off` (= `segment2_end`) and
    // `shstrtab_off` lands right after, so the file body is
    // self-consistent without per-write conditionals.
    let emit_dwarf = build.debug_info;
    // Tell the DWARF emitter where the `_start` stub
    // lives so it can give it a `DW_TAG_subprogram` + a
    // CFI-terminating FDE. The stub sits at
    // `[code_vmaddr, code_vmaddr + stub_len)` -- ahead of
    // `build.text` -- so its range is independent of any
    // codegen-relative offset. Shared libraries skip the stub
    // (`stub_len = 0`); pass `None` there.
    let start_stub_range = if stub_len > 0 {
        Some((code_vmaddr, code_vmaddr + stub_len))
    } else {
        None
    };
    let dwarf_sections = if let Some(md) = &build.merged_dwarf {
        // Multi-TU link: drop pre-baked linker-merged DWARF
        // bytes into `.debug_info` / `.debug_abbrev` / `.debug_line`
        // / `.debug_str`. `.debug_frame` regenerates from the
        // synth-Build's per-function metadata (which `synth_build`
        // populates from every Text-section defined symbol) so
        // backtraces unwind cleanly through merged-image code.
        //
        // Text-targeting placeholders the linker couldn't apply
        // (DW_AT_low_pc / DW_AT_high_pc / line-program addresses
        // need `text_vaddr + merged_text_offset`) get rewritten
        // here now that the writer knows the committed text vmaddr.
        let mut debug_info = md.debug_info.clone();
        let mut debug_line = md.debug_line.clone();
        for r in &md.debug_info_text_relocs {
            super::apply_merged_dwarf_text_reloc(&mut debug_info, r, dwarf_text_vmaddr)?;
        }
        for r in &md.debug_line_text_relocs {
            super::apply_merged_dwarf_text_reloc(&mut debug_line, r, dwarf_text_vmaddr)?;
        }
        let fresh = dwarf::emit(
            program,
            build,
            elf_target,
            dwarf_text_vmaddr,
            &program.source_path,
            start_stub_range,
        );
        dwarf::DwarfSections {
            debug_info,
            debug_abbrev: md.debug_abbrev.clone(),
            debug_line,
            debug_str: md.debug_str.clone(),
            debug_frame: fresh.debug_frame,
        }
    } else if emit_dwarf {
        dwarf::emit(
            program,
            build,
            elf_target,
            dwarf_text_vmaddr,
            &program.source_path,
            start_stub_range,
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
    let dwarf_off = segment2_end;
    let dwarf_info_off = dwarf_off;
    let dwarf_abbrev_off = dwarf_info_off + dwarf_sections.debug_info.len() as u64;
    let dwarf_line_off = dwarf_abbrev_off + dwarf_sections.debug_abbrev.len() as u64;
    let dwarf_str_off = dwarf_line_off + dwarf_sections.debug_line.len() as u64;
    let dwarf_frame_off = dwarf_str_off + dwarf_sections.debug_str.len() as u64;

    // Build the static `.symtab` + `.strtab` listing one
    // local STT_FUNC per PLT trampoline. The trampolines live
    // inside `.text` at `code_vmaddr + stub_len + tramp_off`; a
    // debugger's `b malloc` on the produced binary now resolves
    // to the trampoline rather than getting lost in the dynamic
    // linker's macro-expansion sites.
    //
    // Empty when the program has no imports (a `void main(){}`
    // that never calls libc -- rare). The two sections still get
    // their headers in that case for layout symmetry, but their
    // payloads degenerate to the SHT_SYMTAB sentinel + the empty
    // string.
    let emit_plt_symtab = !build.plt_trampoline_offsets.is_empty();
    let trampoline_size: u64 = match machine {
        super::Machine::Aarch64 => 12, // adrp + ldr + br
        super::Machine::X86_64 => 6,   // jmp qword ptr [rip+disp32]
    };
    let (plt_symtab_bytes, plt_strtab_bytes) = if emit_plt_symtab {
        build_plt_symtab(build, dwarf_text_vmaddr, trampoline_size, text_shndx)
    } else {
        (Vec::new(), alloc::vec![0u8])
    };
    let post_dwarf_off = dwarf_frame_off + dwarf_sections.debug_frame.len() as u64;
    let (symtab_off, strtab_off, shstrtab_off) = if emit_plt_symtab {
        // .symtab requires 8-byte alignment (each Elf64_Sym is 24
        // bytes). The file body pads to `symtab_off` before
        // emitting the bytes; .strtab and .shstrtab sit immediately
        // after with no further padding.
        let s = round_up(post_dwarf_off, 8);
        let st = s + plt_symtab_bytes.len() as u64;
        let sh = st + plt_strtab_bytes.len() as u64;
        (s, st, sh)
    } else {
        // No PLT symtab -> .shstrtab abuts DWARF directly,
        // matching the pre-#61 layout.
        (post_dwarf_off, post_dwarf_off, post_dwarf_off)
    };
    // .shstrtab content: NUL + section names. The empty name at the
    // front backs the SHT_NULL sentinel (sh_name=0). The catalog lists
    // every name a section header may carry; a name is present whether
    // or not its section is emitted. Section-header writers resolve
    // names through `name_off` (below) rather than by position, so an
    // optional section (.tdata/.data/.tbss/.bss/DWARF) being absent --
    // or a new name being inserted -- shifts no other lookup.
    let mut shstrtab_names: Vec<&str> = Vec::with_capacity(19);
    shstrtab_names.extend_from_slice(&[
        "",
        ".interp",
        ".dynsym",
        ".dynstr",
        ".hash",
        ".gnu.version",
        ".gnu.version_r",
        ".rela.dyn",
        ".text",
        ".tdata",
        ".dynamic",
        ".got",
        ".data",
        ".tbss",
        ".bss",
    ]);
    if emit_dwarf {
        shstrtab_names.extend_from_slice(&[
            ".debug_info",
            ".debug_abbrev",
            ".debug_line",
            ".debug_str",
            ".debug_frame",
        ]);
    }
    // `.symtab` + `.strtab` for the PLT-trampoline pool.
    // Always paired -- a SHT_SYMTAB section's `sh_link` must
    // reference a real strtab. Only emitted when there are
    // trampolines to name.
    let plt_symtab_name_idx_in_shstrtab = if emit_plt_symtab {
        shstrtab_names.push(".symtab");
        shstrtab_names.push(".strtab");
        Some(shstrtab_names.len() - 2)
    } else {
        None
    };
    let shstrtab_idx_self = shstrtab_names.len();
    shstrtab_names.push(".shstrtab");
    let mut shstrtab: Vec<u8> = Vec::new();
    let mut shstrtab_offsets: Vec<u32> = Vec::with_capacity(shstrtab_names.len());
    for s in &shstrtab_names {
        shstrtab_offsets.push(shstrtab.len() as u32);
        shstrtab.extend_from_slice(s.as_bytes());
        shstrtab.push(0);
    }
    let shstrtab_size = shstrtab.len() as u64;
    let shdr_off = round_up(shstrtab_off + shstrtab_size, 8);
    // Resolve a section name to its `.shstrtab` byte offset by catalog
    // position; keeps the header writers independent of catalog order.
    let name_off = |name: &str| -> u32 {
        let i = shstrtab_names
            .iter()
            .position(|&s| s == name)
            .expect("section name in catalog");
        shstrtab_offsets[i]
    };
    // Section count: 1 NULL + .interp + .dynsym + .dynstr +
    // .hash + .rela.dyn + .text + (optional .tdata) +
    // .dynamic + .got + (optional .data) + (optional .tbss) +
    // (optional .bss) + 5 .debug_* + .shstrtab. Counted dynamically.
    let has_data = !build.data.is_empty();
    let has_tdata = has_tls && tdata_size > 0;
    let has_tbss = has_tls && tbss_size > 0;
    let has_bss = build.bss_size > 0;
    // Section-header indices of the allocated sections, in the order
    // emitted below: .text=6, then optional .tdata, .dynamic, .got, then
    // optional .data, .tbss, .bss. Used to attribute each .dynsym export
    // to its real section. `ver_shdrs` / `text_shndx` are computed near
    // `has_versions` above so the PLT symtab can share the shifted index.
    let data_shndx: u16 = 9 + ver_shdrs + has_tdata as u16;
    let bss_shndx: u16 = 9 + ver_shdrs + has_tdata as u16 + has_data as u16 + has_tbss as u16;
    let n_section_headers: u64 = 1 // NULL
        + 1 // .interp
        + 1 // .dynsym
        + 1 // .dynstr
        + 1 // .hash
        + ver_shdrs as u64 // .gnu.version + .gnu.version_r
        + 1 // .rela.dyn
        + 1 // .text
        + (if has_tdata { 1 } else { 0 }) // .tdata
        + 1 // .dynamic
        + 1 // .got
        + (if has_data { 1 } else { 0 }) // .data
        + (if has_tbss { 1 } else { 0 }) // .tbss
        + (if has_bss { 1 } else { 0 }) // .bss
        + (if emit_dwarf { 5 } else { 0 }) // .debug_* x 5 (info, abbrev, line, str, frame);
        + (if emit_plt_symtab { 2 } else { 0 }) // .symtab + .strtab; 
        + 1; // .shstrtab
    let total_filesize = shdr_off + n_section_headers * ELF64_SHDR_SIZE;
    // shstrtab is the last section in the table; its index is
    // n_section_headers - 1.
    let shstrtab_idx: u16 = (n_section_headers - 1) as u16;

    // ---- Build the bytes. ----
    let mut out: Vec<u8> = Vec::with_capacity(total_filesize as usize);

    // ELF header.
    let mut e_ident = [0u8; EI_NIDENT];
    e_ident[0..4].copy_from_slice(&ELFMAG);
    e_ident[4] = ELFCLASS64;
    e_ident[5] = ELFDATA2LSB;
    e_ident[6] = EV_CURRENT;
    e_ident[7] = ELFOSABI_SYSV;
    write_struct(
        &mut out,
        &Elf64Ehdr {
            e_ident,
            e_type: if emit_dyn { ET_DYN } else { ET_EXEC },
            e_machine: e_machine(machine),
            e_version: EV_CURRENT as u32,
            // For executables: start of `_start`. For shared
            // libraries: zero -- the loader doesn't transfer
            // control to a dlopen'd image, and an explicit
            // `_init` constructor isn't needed for the cases
            // c5 currently produces.
            e_entry: if is_shared { 0 } else { code_vmaddr },
            e_phoff: phoff,
            e_shoff: shdr_off,
            e_flags: 0,
            e_ehsize: ELF_HEADER_SIZE as u16,
            e_phentsize: PROGRAM_HEADER_SIZE as u16,
            e_phnum: n_program_headers as u16,
            // The dynamic linker doesn't read section headers
            // (it walks PT_DYNAMIC); the only consumers are
            // lldb / gdb, which use them to locate the
            // `.debug_*` payload. Six entries: SHT_NULL
            // sentinel, four DWARF sections, .shstrtab.
            e_shentsize: ELF64_SHDR_SIZE as u16,
            e_shnum: n_section_headers as u16,
            e_shstrndx: shstrtab_idx,
        },
    );
    debug_assert_eq!(out.len() as u64, ELF_HEADER_SIZE);

    // PT_PHDR -- self-locate.
    write_phdr(
        &mut out,
        PT_PHDR,
        PF_R,
        phoff,
        TEXT_VMADDR_BASE + phoff,
        phsize,
        phsize,
        8,
    );

    // PT_INTERP -- per-machine path (aarch64 vs x86_64).
    write_phdr(
        &mut out,
        PT_INTERP,
        PF_R,
        interp_off,
        interp_vmaddr,
        interp_path_str.len() as u64 + 1,
        interp_path_str.len() as u64 + 1,
        1,
    );

    // PT_LOAD r-x -- ELF header + phdrs + interp + dynsym + dynstr +
    // hash + rela + code, all in one segment.
    write_phdr(
        &mut out,
        PT_LOAD,
        PF_R | PF_X,
        0,
        TEXT_VMADDR_BASE,
        segment1_filesize,
        segment1_filesize,
        seg,
    );

    // PT_LOAD rw -- .dynamic, .got, .data, .tdata, [.tbss memsz].
    write_phdr(
        &mut out,
        PT_LOAD,
        PF_R | PF_W,
        segment2_off,
        TEXT_VMADDR_BASE + segment2_off,
        segment2_filesize,
        segment2_memsize,
        seg,
    );

    // PT_DYNAMIC -- mirror of the .dynamic section.
    write_phdr(
        &mut out,
        PT_DYNAMIC,
        PF_R | PF_W,
        dynamic_off,
        dynamic_vmaddr,
        dynamic_size,
        dynamic_size,
        8,
    );

    // PT_TLS -- describes the per-thread TLS image. Only emitted
    // when the program declares any `_Thread_local` global; the
    // dynamic linker uses this to allocate per-thread TLS at
    // pthread_create time, copying `p_filesz` bytes from `.tdata`
    // and zero-filling the remainder up to `p_memsz` (.tbss).
    if has_tls {
        write_phdr(
            &mut out,
            PT_TLS,
            PF_R,
            tdata_off,
            tdata_vmaddr,
            tdata_size,
            tdata_size + tbss_size,
            TLS_SEGMENT_ALIGN,
        );
    }

    // PT_GNU_STACK rw- (no x).
    write_phdr(&mut out, PT_GNU_STACK, PF_R | PF_W, 0, 0, 0, 0, 16);

    debug_assert_eq!(out.len() as u64, phoff + phsize);

    // .interp
    out.extend_from_slice(&interp);
    debug_assert_eq!(out.len() as u64, dynsym_off);

    // .dynsym -- rebuild now that we know `code_vmaddr` so
    // each export's `st_value` is its runtime VA. The
    // placeholder we built up front (with `st_value = 0`)
    // had the right byte count for layout; the real values
    // go in here.
    let export_addrs: Vec<u64> = elf_exports
        .iter()
        .map(|e| match e.section {
            // Code blob layout is `[stub_len bytes of _start][build.text]`;
            // shared-library output has stub_len=0 so the shift is a
            // no-op there. A data export's offset is within `build.data`.
            super::DynamicExportSection::Text => code_vmaddr + stub_len + e.offset,
            super::DynamicExportSection::Data => data_off_to_vaddr(e.offset),
        })
        .collect();
    // Copy-relocation targets sit in the static data segment: a `.data`
    // symbol at `data_vmaddr + offset`, or a `.bss` symbol in the
    // zero-fill tail at `bss_vmaddr + offset`.
    let copy_addrs: Vec<u64> = build
        .copy_relocs
        .iter()
        .map(|cr| {
            if cr.is_bss {
                bss_vmaddr + cr.local_offset
            } else {
                data_vmaddr + cr.local_offset
            }
        })
        .collect();
    let final_dynsym = build_dynsym(
        &name_offsets,
        &export_name_offsets,
        &export_addrs,
        &export_is_data,
        &copy_name_offsets,
        &copy_addrs,
        &copy_sizes,
        &copy_is_bss,
        text_shndx,
        data_shndx,
        bss_shndx,
    );
    debug_assert_eq!(final_dynsym.len(), dynsym.len());
    out.extend_from_slice(&final_dynsym);
    debug_assert_eq!(out.len() as u64, dynstr_off);

    // .dynstr
    out.extend_from_slice(&dynstr);
    debug_assert_eq!(out.len() as u64, hash_off);

    // .hash
    out.extend_from_slice(&hash);

    // .gnu.version / .gnu.version_r (present only when an import carries
    // a version requirement).
    if has_versions {
        debug_assert_eq!(out.len() as u64, gnu_version_off);
        out.extend_from_slice(&gnu_version);
        while (out.len() as u64) < gnu_version_r_off {
            out.push(0);
        }
        out.extend_from_slice(&gnu_version_r);
        while (out.len() as u64) < rela_off {
            out.push(0);
        }
    }
    debug_assert_eq!(out.len() as u64, rela_off);

    // .rela.dyn -- GLOB_DAT for imports, then (shared object only) one
    // R_*_RELATIVE per internal absolute pointer in static data so it
    // tracks the runtime load base. The slot keeps its baked link-time
    // value; a RELA loader overwrites it with `load_bias + r_addend`,
    // where the addend is that same link-time target address.
    let mut rela = build_rela_dyn(got_vmaddr, n_imports, machine);
    if emit_dyn {
        let r_type = r_relative(machine);
        for r in &build.data_relocs {
            let addend = data_off_to_vaddr(r.target_offset);
            write_struct(
                &mut rela,
                &Elf64Rela {
                    r_offset: data_vmaddr + r.data_offset,
                    r_info: r_type,
                    r_addend: addend as i64,
                },
            );
        }
        for r in &build.code_relocs {
            let native_off = build
                .pc_to_native
                .get(r.target_ent_pc as usize)
                .copied()
                .unwrap_or(0);
            let addend = code_vmaddr + stub_len + native_off as u64;
            write_struct(
                &mut rela,
                &Elf64Rela {
                    r_offset: data_vmaddr + r.data_offset,
                    r_info: r_type,
                    r_addend: addend as i64,
                },
            );
        }
    }
    // COPY relocations for data imports. The dynsym index of copy target
    // `i` is `1 + n_imports + n_exports + i` (sentinel, imports, exports,
    // then the copy group). `r_offset` is the target's runtime address.
    let r_copy = match machine {
        Machine::Aarch64 => R_AARCH64_COPY,
        Machine::X86_64 => R_X86_64_COPY,
    };
    let copy_dynsym_base = (1 + n_imports + elf_exports.len()) as u64;
    for (i, &addr) in copy_addrs.iter().enumerate() {
        let sym_idx = copy_dynsym_base + i as u64;
        write_struct(
            &mut rela,
            &Elf64Rela {
                r_offset: addr,
                r_info: (sym_idx << 32) | r_copy,
                r_addend: 0,
            },
        );
    }
    debug_assert_eq!(rela.len() as u64, rela_size);
    out.extend_from_slice(&rela);

    // Pad to code_off.
    while (out.len() as u64) < code_off {
        out.push(0);
    }
    debug_assert_eq!(out.len() as u64, code_off);

    // _start stub + build.text.
    let code_file_offset = out.len() as u64;
    out.extend_from_slice(&code);
    debug_assert_eq!(out.len() as u64, segment1_filesize);

    // Pad to end of segment 1 (page-aligned).
    while (out.len() as u64) < segment1_end {
        out.push(0);
    }

    // .dynamic
    let dynamic = build_dynamic(
        &lib_strtab_offsets,
        DynamicInfo {
            hash_vmaddr,
            strtab_vmaddr: dynstr_vmaddr,
            symtab_vmaddr: dynsym_vmaddr,
            rela_vmaddr,
            rela_size,
            strtab_size: dynstr.len() as u64,
            versions: if has_versions {
                Some(VersionInfo {
                    versym_vmaddr: gnu_version_vmaddr,
                    verneed_vmaddr: gnu_version_r_vmaddr,
                    verneed_num: verneed_groups.len() as u64,
                })
            } else {
                None
            },
        },
    );
    debug_assert_eq!(dynamic.len() as u64, dynamic_size);
    out.extend_from_slice(&dynamic);

    // .got -- one zero-filled u64 per import. Loader fills these in
    // via .rela.dyn / R_AARCH64_GLOB_DAT before _start runs.
    out.extend(vec![0u8; got_size as usize]);
    // Pad to the aligned `data_off` (see the layout).
    while (out.len() as u64) < data_off {
        out.push(0);
    }
    debug_assert_eq!(out.len() as u64, data_off);

    // build.data -- the program's static data segment, with
    // pointer-to-global initializers resolved to their link-time absolute
    // VAs. The image is ET_DYN (PIE), so each such slot also gets a
    // `.rela.dyn` R_*_RELATIVE entry (built above) whose addend is this same
    // VA; the RELA loader overwrites the slot with `load_bias + addend`. The
    // baked value is the pre-slide initializer.
    let mut data_with_relocs = build.data.clone();
    for r in &build.data_relocs {
        let absolute = data_off_to_vaddr(r.target_offset);
        let off = r.data_offset as usize;
        if off + 8 > data_with_relocs.len() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "ELF: data reloc offset {off:#x} past end of .data ({})",
                    data_with_relocs.len()
                ),
            )));
        }
        data_with_relocs[off..off + 8].copy_from_slice(&absolute.to_le_bytes());
    }
    // Function-pointer initializers in the data segment: translate
    // each ent_pc to a native code-segment offset (skipping
    // the prologue stub at the start of the code blob), add the
    // text vmaddr, and write the link-time absolute code address. As with
    // data pointers, a matching `.rela.dyn` R_*_RELATIVE entry slides it at
    // load time.
    for r in &build.code_relocs {
        let ent_pc = r.target_ent_pc as usize;
        let native_off = build
            .pc_to_native
            .get(ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if native_off == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("ELF: code reloc references missing ent_pc {ent_pc}"),
            )));
        }
        let absolute = code_vmaddr + stub_len + native_off as u64;
        let off = r.data_offset as usize;
        if off + 8 > data_with_relocs.len() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "ELF: code reloc offset {off:#x} past end of .data ({})",
                    data_with_relocs.len()
                ),
            )));
        }
        data_with_relocs[off..off + 8].copy_from_slice(&absolute.to_le_bytes());
    }
    out.extend_from_slice(&data_with_relocs);

    // .tdata -- initialised TLS image. The first `tls_init_size`
    // bytes of `build.tls_data`. The loader copies these into each
    // thread's TLS region at thread creation. .tbss has no file
    // backing -- it lives only in PT_TLS's `p_memsz - p_filesz`
    // and gets zero-filled by the loader, so we emit nothing for
    // it here. Pad to the aligned `tdata_off` first (see the layout).
    while (out.len() as u64) < tdata_off {
        out.push(0);
    }
    debug_assert_eq!(out.len() as u64, tdata_off);
    out.extend_from_slice(&build.tls_data[..build.tls_init_size]);

    // Pad to end of segment 2 (page-aligned).
    while (out.len() as u64) < segment2_end {
        out.push(0);
    }
    debug_assert_eq!(out.len() as u64, dwarf_off);

    // ---- DWARF debug sections ----
    out.extend_from_slice(&dwarf_sections.debug_info);
    out.extend_from_slice(&dwarf_sections.debug_abbrev);
    out.extend_from_slice(&dwarf_sections.debug_line);
    out.extend_from_slice(&dwarf_sections.debug_str);
    out.extend_from_slice(&dwarf_sections.debug_frame);

    // ---- PLT-trampoline static symbol table. ----
    if emit_plt_symtab {
        // Pad to 8 so each Elf64_Sym lands aligned.
        while (out.len() as u64) < symtab_off {
            out.push(0);
        }
        debug_assert_eq!(out.len() as u64, symtab_off);
        out.extend_from_slice(&plt_symtab_bytes);
        debug_assert_eq!(out.len() as u64, strtab_off);
        out.extend_from_slice(&plt_strtab_bytes);
    }
    debug_assert_eq!(out.len() as u64, shstrtab_off);

    // .shstrtab
    out.extend_from_slice(&shstrtab);

    // Pad to 8 so the section header table starts aligned.
    while (out.len() as u64) < shdr_off {
        out.push(0);
    }
    debug_assert_eq!(out.len() as u64, shdr_off);

    // Section header table: a full table covering loaded
    // segments (NULL sentinel, .interp, .dynsym, .dynstr, .hash,
    // .rela.dyn, .text, optional .tdata, .dynamic, .got, optional
    // .data, optional .tbss) plus the four DWARF sections and
    // .shstrtab.
    //
    // Without entries for the loaded segments, gdb segfaults on
    // `b main` (no section contains main's vmaddr) and `strip`
    // collapses the binary to ~488 bytes (it interprets the
    // missing section table as "no real content"). lldb on
    // Linux similarly mis-resolves names. The bytes the headers
    // describe are already on disk; we just describe them.
    // Section indices are computed as we emit; .dynsym /
    // .dynstr / .dynamic / etc. need to reference each other by
    // index in `sh_link`, so capture each one's slot before
    // emitting the next.
    let null_shdr_idx: u16 = 0;
    let _ = null_shdr_idx;
    let interp_shdr_idx: u16 = 1;
    let _ = interp_shdr_idx;
    let dynsym_shdr_idx: u16 = 2;
    let dynstr_shdr_idx: u16 = 3;
    let _hash_shdr_idx: u16 = 4;
    let _rela_shdr_idx: u16 = 5 + ver_shdrs;
    let _ = (dynsym_shdr_idx, dynstr_shdr_idx);

    // [0] NULL sentinel.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: name_off(""),
            sh_type: SHT_NULL,
            sh_flags: 0,
            sh_addr: 0,
            sh_offset: 0,
            sh_size: 0,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 0,
            sh_entsize: 0,
        },
    );

    // [1] .interp -- the dynamic linker path string.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: name_off(".interp"),
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_ALLOC,
            sh_addr: interp_vmaddr,
            sh_offset: interp_off,
            sh_size: interp_path_str.len() as u64 + 1,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 1,
            sh_entsize: 0,
        },
    );

    // [2] .dynsym -- dynamic symbol table. sh_link = .dynstr,
    // sh_info = index of first non-local symbol (we have only
    // a NULL sentinel + globals, so 1).
    let dynsym_link_pending: u16 = dynstr_shdr_idx;
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: name_off(".dynsym"),
            sh_type: SHT_DYNSYM,
            sh_flags: SHF_ALLOC,
            sh_addr: dynsym_vmaddr,
            sh_offset: dynsym_off,
            sh_size: dynsym.len() as u64,
            sh_link: dynsym_link_pending as u32,
            sh_info: 1,
            sh_addralign: 8,
            sh_entsize: ELF64_SYM_SIZE,
        },
    );

    // [3] .dynstr -- string table for .dynsym.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: name_off(".dynstr"),
            sh_type: SHT_STRTAB,
            sh_flags: SHF_ALLOC,
            sh_addr: dynstr_vmaddr,
            sh_offset: dynstr_off,
            sh_size: dynstr.len() as u64,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 1,
            sh_entsize: 0,
        },
    );

    // [4] .hash -- DT_HASH bucket / chain table.
    let dynsym_idx_for_hash = dynsym_shdr_idx;
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: name_off(".hash"),
            sh_type: SHT_HASH,
            sh_flags: SHF_ALLOC,
            sh_addr: hash_vmaddr,
            sh_offset: hash_off,
            sh_size: hash.len() as u64,
            sh_link: dynsym_idx_for_hash as u32,
            sh_info: 0,
            sh_addralign: 8,
            sh_entsize: 4,
        },
    );

    // [optional] .gnu.version / .gnu.version_r -- symbol-version tables
    // (SHT_GNU_versym / SHT_GNU_verneed). Emitted between .hash and
    // .rela.dyn so the section-header order tracks the file/address
    // order; present only when an import carries a version requirement.
    if has_versions {
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: name_off(".gnu.version"),
                sh_type: SHT_GNU_VERSYM,
                sh_flags: SHF_ALLOC,
                sh_addr: gnu_version_vmaddr,
                sh_offset: gnu_version_off,
                sh_size: gnu_version.len() as u64,
                sh_link: dynsym_shdr_idx as u32,
                sh_info: 0,
                sh_addralign: 2,
                sh_entsize: 2,
            },
        );
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: name_off(".gnu.version_r"),
                sh_type: SHT_GNU_VERNEED,
                sh_flags: SHF_ALLOC,
                sh_addr: gnu_version_r_vmaddr,
                sh_offset: gnu_version_r_off,
                sh_size: gnu_version_r.len() as u64,
                sh_link: dynstr_shdr_idx as u32,
                sh_info: verneed_groups.len() as u32,
                sh_addralign: 8,
                sh_entsize: 0,
            },
        );
    }

    // [5] .rela.dyn -- relocations resolved at load time.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: name_off(".rela.dyn"),
            sh_type: SHT_RELA,
            sh_flags: SHF_ALLOC,
            sh_addr: rela_vmaddr,
            sh_offset: rela_off,
            sh_size: rela_size,
            sh_link: dynsym_idx_for_hash as u32,
            sh_info: 0,
            sh_addralign: 8,
            sh_entsize: ELF64_RELA_SIZE,
        },
    );

    // [6] .text -- the executable code segment. The size covers
    // the entry stub + build.text; the address is `code_vmaddr`.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: name_off(".text"),
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_ALLOC | SHF_EXECINSTR,
            sh_addr: code_vmaddr,
            sh_offset: code_off,
            sh_size: code_size,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 16,
            sh_entsize: 0,
        },
    );

    // [optional] .tdata -- TLS image template (when has_tdata).
    if has_tdata {
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: name_off(".tdata"),
                sh_type: SHT_PROGBITS,
                sh_flags: SHF_ALLOC | SHF_WRITE | 0x400, // SHF_TLS
                sh_addr: tdata_vmaddr,
                sh_offset: tdata_off,
                sh_size: tdata_size,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 8,
                sh_entsize: 0,
            },
        );
    }

    // [N] .dynamic -- dynamic linking info table.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: name_off(".dynamic"),
            sh_type: SHT_DYNAMIC,
            sh_flags: SHF_ALLOC | SHF_WRITE,
            sh_addr: dynamic_vmaddr,
            sh_offset: dynamic_off,
            sh_size: dynamic_size,
            sh_link: dynstr_shdr_idx as u32,
            sh_info: 0,
            sh_addralign: 8,
            sh_entsize: ELF64_DYN_SIZE,
        },
    );

    // [N+1] .got -- global offset table (one slot per import).
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: name_off(".got"),
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_ALLOC | SHF_WRITE,
            sh_addr: got_vmaddr,
            sh_offset: got_off,
            sh_size: got_size,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 8,
            sh_entsize: 8,
        },
    );

    // [optional] .data -- the initialised data segment.
    if has_data {
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: name_off(".data"),
                sh_type: SHT_PROGBITS,
                sh_flags: SHF_ALLOC | SHF_WRITE,
                sh_addr: data_vmaddr,
                sh_offset: data_off,
                sh_size: data_size,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: data_align,
                sh_entsize: 0,
            },
        );
    }

    // [optional] .tbss -- TLS zero-fill (no file backing).
    if has_tbss {
        // .tbss has no file-resident bytes; sh_offset still
        // points where the loader-zeroed region would conceptually
        // start so tools can compute its boundaries.
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: name_off(".tbss"),
                sh_type: 8,                              // SHT_NOBITS
                sh_flags: SHF_ALLOC | SHF_WRITE | 0x400, // SHF_TLS
                sh_addr: tdata_vmaddr + tdata_size,
                sh_offset: tdata_off + tdata_size,
                sh_size: tbss_size,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 8,
                sh_entsize: 0,
            },
        );
    }

    // [optional] .bss -- regular zero-init data (no file backing). The
    // PT_LOAD p_memsz tail reserves these bytes; the header lets size /
    // llvm-size attribute them to bss rather than reading zero.
    if has_bss {
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: name_off(".bss"),
                sh_type: 8, // SHT_NOBITS
                sh_flags: SHF_ALLOC | SHF_WRITE,
                sh_addr: bss_vmaddr,
                sh_offset: bss_vmaddr - TEXT_VMADDR_BASE,
                sh_size: build.bss_size as u64,
                sh_link: 0,
                sh_info: 0,
                // Report bss_vmaddr's own 2-adic alignment (<=16) so
                // sh_addr stays congruent to sh_addralign.
                sh_addralign: 1u64 << bss_vmaddr.trailing_zeros().min(4),
                sh_entsize: 0,
            },
        );
    }

    // [N+2..N+6] DWARF debug sections (file-only metadata, no
    // SHF_ALLOC so the loader skips them). `.debug_frame`
    // carries the CFI a debugger / unwinder reads to walk
    // through optimised frames without prologue heuristics.
    // Suppressed when `--no-debug` was passed -- the section
    // table omits these five entries; nothing else in the file
    // image references them.
    if emit_dwarf {
        let dwarf_section_specs: &[(u32, u64, u64)] = &[
            (
                name_off(".debug_info"),
                dwarf_info_off,
                dwarf_sections.debug_info.len() as u64,
            ),
            (
                name_off(".debug_abbrev"),
                dwarf_abbrev_off,
                dwarf_sections.debug_abbrev.len() as u64,
            ),
            (
                name_off(".debug_line"),
                dwarf_line_off,
                dwarf_sections.debug_line.len() as u64,
            ),
            (
                name_off(".debug_str"),
                dwarf_str_off,
                dwarf_sections.debug_str.len() as u64,
            ),
            (
                name_off(".debug_frame"),
                dwarf_frame_off,
                dwarf_sections.debug_frame.len() as u64,
            ),
        ];
        for &(name_offset, off, sz) in dwarf_section_specs {
            write_struct(
                &mut out,
                &Elf64Shdr {
                    sh_name: name_offset,
                    sh_type: SHT_PROGBITS,
                    sh_flags: 0,
                    sh_addr: 0,
                    sh_offset: off,
                    sh_size: sz,
                    sh_link: 0,
                    sh_info: 0,
                    sh_addralign: 1,
                    sh_entsize: 0,
                },
            );
        }
    }

    // PLT-trampoline static symbol table. `.symtab`'s
    // `sh_info` field must point one past the last LOCAL symbol;
    // we only emit locals, so it's `n_symbols` (sentinel + one
    // per import). `sh_link` references the matching `.strtab`.
    if let Some(name_idx) = plt_symtab_name_idx_in_shstrtab {
        // Section-header indices for `.symtab` / `.strtab`. They
        // sit just before `.shstrtab` (which is always at
        // `n_section_headers - 1`), so they're at -3 / -2 from
        // the end. These are independent of `shstrtab_names`
        // ordering -- the names list and the shdr table use
        // different indexing schemes (the former includes only
        // names; the latter includes optional sections like
        // `.tdata` / `.data` / `.tbss` whose names are at fixed
        // shstrtab slots).
        let symtab_shdr_idx = (n_section_headers - 3) as u32;
        let strtab_shdr_idx = (n_section_headers - 2) as u32;
        let _ = symtab_shdr_idx;
        let n_sym = (plt_symtab_bytes.len() as u64) / ELF64_SYM_SIZE;
        // [N] .symtab
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: shstrtab_offsets[name_idx],
                sh_type: SHT_SYMTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: symtab_off,
                sh_size: plt_symtab_bytes.len() as u64,
                sh_link: strtab_shdr_idx,
                sh_info: n_sym as u32, // one past last local
                sh_addralign: 8,
                sh_entsize: ELF64_SYM_SIZE,
            },
        );
        // [N+1] .strtab
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: shstrtab_offsets[name_idx + 1],
                sh_type: SHT_STRTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: strtab_off,
                sh_size: plt_strtab_bytes.len() as u64,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 1,
                sh_entsize: 0,
            },
        );
    }

    // [last] .shstrtab.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: shstrtab_offsets[shstrtab_idx_self],
            sh_type: SHT_STRTAB,
            sh_flags: 0,
            sh_addr: 0,
            sh_offset: shstrtab_off,
            sh_size: shstrtab_size,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 1,
            sh_entsize: 0,
        },
    );

    debug_assert_eq!(out.len() as u64, total_filesize);

    // ---- Patch fixups. ----
    // The code blob layout is [_start stub][build.text]. The codegen's
    // adrp_offset is relative to build.text, so we shift by stub len.
    // Shared libraries have no `_start` and skip this patch
    // entirely; the stub-len shift below collapses to zero
    // and the libc-exit GOT lookup never gets emitted in
    // the first place.
    if let Some(exit_off) = exit_adrp_offset {
        let exit_idx = build
            .imports
            .imports
            .iter()
            .position(|i| i.local_name == "exit")
            .ok_or_else(|| {
                C5Error::Compile(crate::c5::error::fmt_internal_err(
                    "ELF writer: _start stub asked for the libc-exit tail but `exit` \
                     isn't in the import set -- the codegen lower-pass and the writer \
                     disagree on whether libc is in scope.",
                ))
            })?;
        patch_got_call(
            machine,
            &mut out,
            code_file_offset,
            code_vmaddr,
            exit_off as u64,
            got_vmaddr + (exit_idx as u64) * 8,
            "_start exit fixup",
        )?;
    }
    // The syscall tail (`exit_adrp_offset == None`) needs
    // no patch -- the `mov rax, 231; syscall` (x86_64) /
    // `movz x8, #94; svc #0` (aarch64) bytes are absolute and
    // self-contained.

    // GOT fixups for libc calls inside build.text. Same per-arch
    // dispatch as the _start exit call.
    for fx in &build.got_fixups {
        patch_got_call(
            machine,
            &mut out,
            code_file_offset,
            code_vmaddr,
            stub_len + fx.adrp_offset as u64,
            got_vmaddr + (fx.import_index as u64) * 8,
            "GOT fixup",
        )?;
    }

    // Data-segment references (string literals / globals). Per-arch
    // patch shape: aarch64 uses adrp+add, x86_64 uses lea + RIP-rel.
    for fx in &build.data_fixups {
        patch_addr_load(
            machine,
            &mut out,
            code_file_offset,
            code_vmaddr,
            stub_len + fx.adrp_offset as u64,
            data_off_to_vaddr(fx.data_offset),
            "data fixup",
        )?;
    }

    // Function-pointer literals.
    for fx in &build.func_fixups {
        // Targets are byte offsets within build.text -- shift by
        // stub len.
        patch_addr_load(
            machine,
            &mut out,
            code_file_offset,
            code_vmaddr,
            stub_len + fx.adrp_offset as u64,
            code_vmaddr + stub_len + fx.target_native_offset as u64,
            "func fixup",
        )?;
    }

    Ok(out)
}

#[allow(clippy::too_many_arguments)]
fn write_phdr(
    out: &mut Vec<u8>,
    p_type: u32,
    p_flags: u32,
    p_offset: u64,
    p_vaddr: u64,
    p_filesz: u64,
    p_memsz: u64,
    p_align: u64,
) {
    write_struct(
        out,
        &Elf64Phdr {
            p_type,
            p_flags,
            p_offset,
            p_vaddr,
            // p_paddr mirrors p_vaddr -- our targets don't have a
            // separate physical-address space.
            p_paddr: p_vaddr,
            p_filesz,
            p_memsz,
            p_align,
        },
    );
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Smallest plausible Build that exercises the writer end to end.
    /// 8 bytes of code (movz x0, #42; ret), no fixups.
    ///
    /// Carries a fake `exit` import: the aarch64 `_start` stub
    /// always calls libc's `exit` after main returns, so ELF
    /// writes without that entry would error out before producing
    /// any bytes for the structural assertions to inspect. This
    /// mirrors what real programs get from `<stdlib.h>`.
    /// Empty `Program` paired with `tiny_build`. The DWARF
    /// emitter walks the program for function entries; an empty
    /// vec produces an empty subprogram list and trivial section
    /// bytes, which is enough for the structural invariants the
    /// tests check.
    fn tiny_program() -> Program {
        Program {
            data: Vec::new(),
            data_object_starts: Vec::new(),
            entry_pc: 0,
            warnings: Vec::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            data_relocs: Vec::new(),
            extern_data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            exports: Vec::new(),
            dylibs: Vec::new(),
            dllmain_pc: None,
            source_files: Vec::new(),
            source_path: String::new(),
            variables: Vec::new(),
            structs: Vec::new(),
            enums: Vec::new(),
            entry_name: None,
            entry_pragma: None,
            auto_includes: Vec::new(),
            data_align: 8,
            subsystem: None,
            finished_functions: alloc::vec::Vec::new(),
            symbols: alloc::vec::Vec::new(),
            synthetic_ssa_funcs: alloc::vec::Vec::new(),
            user_ssa_funcs: alloc::vec::Vec::new(),
            extern_function_imports: alloc::vec::Vec::new(),
            init_funcs: alloc::vec::Vec::new(),
        }
    }

    fn tiny_build() -> Build {
        use super::super::{ResolvedImport, ResolvedImports};
        use crate::c5::codegen::ResolvedDylib;
        Build {
            copy_relocs: Default::default(),
            text: vec![0x40, 0x05, 0x80, 0xD2, 0xC0, 0x03, 0x5F, 0xD6],
            data: Vec::new(),
            data_align: 8,
            bss_size: 0,
            entry_offset: 0,
            got_fixups: Vec::new(),
            data_fixups: Vec::new(),
            func_fixups: Vec::new(),
            pc_to_native: Vec::new(),
            func_ent_pcs: Vec::new(),
            func_names: Vec::new(),
            func_prologue_native: alloc::collections::BTreeMap::new(),
            promoted_local_slots: alloc::collections::BTreeMap::new(),
            coalesced_slot_remap: alloc::collections::BTreeMap::new(),
            fn_unwind: Vec::new(),
            reloc_call_sites: Vec::new(),
            user_extern_call_sites: Vec::new(),
            user_extern_data_refs: Vec::new(),
            ssa_line_rows: Vec::new(),
            imports: ResolvedImports {
                data_bindings: Default::default(),
                imports: vec![ResolvedImport {
                    binding_idx: 0,
                    local_name: "exit".into(),
                    real_symbol: "exit".into(),
                    dylib_index: 0,
                    flat_lookup: false,
                    is_variadic: false,
                    fixed_args: 1,
                    return_type_tag: 0,
                    returns_long_double: false,
                    param_types: Vec::new(),
                }],
                dylibs: vec![ResolvedDylib {
                    name: "libc".into(),
                    path: "libc.so.6".into(),
                }],
            },
            abi: super::super::Target::LinuxAarch64.abi(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            tls_index_fixups: Vec::new(),
            elf_tpoff_fixups: Vec::new(),
            data_relocs: Vec::new(),
            extern_data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            exports: Vec::new(),
            dynamic_exports: Vec::new(),
            output_kind: super::super::OutputKind::Executable,
            shared_lib_name: None,
            dllmain_pc: None,
            macho_tlv_fixups: Vec::new(),
            macho_tlv_descriptors: Vec::new(),
            debug_info: true,
            merged_dwarf: None,
            plt_trampoline_offsets: Vec::new(),
        }
    }

    fn read_u32(buf: &[u8], off: usize) -> u32 {
        u32::from_le_bytes(buf[off..off + 4].try_into().unwrap())
    }
    fn read_u64(buf: &[u8], off: usize) -> u64 {
        u64::from_le_bytes(buf[off..off + 8].try_into().unwrap())
    }
    /// Read a `#[repr(C)]` record back from the emitted image, the
    /// inverse of `write_struct`, so a test reads named fields instead of
    /// hand-computed byte offsets.
    fn read_struct<T: Copy>(buf: &[u8], off: usize) -> T {
        assert!(off + core::mem::size_of::<T>() <= buf.len());
        // SAFETY: `T` is `Copy + #[repr(C)]` at every call site, the
        // bound is checked above, and the little-endian field order
        // matches the host (asserted in `write_struct`).
        unsafe { core::ptr::read_unaligned(buf.as_ptr().add(off) as *const T) }
    }

    #[test]
    fn writes_elf_magic() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        assert_eq!(&bytes[0..4], &ELFMAG);
    }

    #[test]
    fn class_is_64_bit_le() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        assert_eq!(bytes[4], ELFCLASS64);
        assert_eq!(bytes[5], ELFDATA2LSB);
    }

    #[test]
    fn machine_is_aarch64() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let e_machine = u16::from_le_bytes(bytes[18..20].try_into().unwrap());
        assert_eq!(e_machine, EM_AARCH64);
    }

    /// An export whose ent_pc misses `pc_to_native` must fail the write
    /// with a diagnostic; it was previously dropped from `.dynsym`
    /// silently, shipping a shared library without the symbol.
    #[test]
    fn export_with_unmapped_ent_pc_errors() {
        let mut build = tiny_build();
        build.output_kind = super::super::OutputKind::SharedLibrary;
        build.exports = vec![crate::c5::program::ExportedFunction {
            name: "ghost".into(),
            ent_pc: 999,
        }];
        let err = write(&tiny_program(), &build, Machine::Aarch64).unwrap_err();
        assert!(
            err.to_string().contains("ghost"),
            "error must name the export: {err}"
        );
    }

    #[test]
    fn program_header_table_self_describes() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let phoff = read_u64(&bytes, 32);
        let phentsize = u16::from_le_bytes(bytes[54..56].try_into().unwrap()) as u64;
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;

        let mut found = false;
        for i in 0..phnum {
            let off = (phoff + i * phentsize) as usize;
            let p_type = read_u32(&bytes, off);
            if p_type == PT_PHDR {
                let p_offset = read_u64(&bytes, off + 8);
                let p_filesz = read_u64(&bytes, off + 32);
                assert_eq!(p_offset, phoff);
                assert_eq!(p_filesz, phnum * phentsize);
                found = true;
                break;
            }
        }
        assert!(found, "PT_PHDR entry not found");
    }

    #[test]
    fn pt_load_covers_entry_point() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let e_entry = read_u64(&bytes, 24);
        let phoff = read_u64(&bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;

        let mut covered = false;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            let p_type = read_u32(&bytes, off);
            if p_type != PT_LOAD {
                continue;
            }
            let p_flags = read_u32(&bytes, off + 4);
            if p_flags & PF_X == 0 {
                continue;
            }
            let p_vaddr = read_u64(&bytes, off + 16);
            let p_memsz = read_u64(&bytes, off + 40);
            if e_entry >= p_vaddr && e_entry < p_vaddr + p_memsz {
                covered = true;
                break;
            }
        }
        assert!(covered, "no executable PT_LOAD covers e_entry {e_entry:#x}");
    }

    #[test]
    fn interp_string_is_correct() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let phoff = read_u64(&bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            if read_u32(&bytes, off) != PT_INTERP {
                continue;
            }
            let p_offset = read_u64(&bytes, off + 8) as usize;
            let p_filesz = read_u64(&bytes, off + 32) as usize;
            let s = &bytes[p_offset..p_offset + p_filesz - 1]; // drop NUL
            assert_eq!(s, interp_path(Machine::Aarch64).as_bytes());
            return;
        }
        panic!("PT_INTERP not found");
    }

    #[test]
    fn dynamic_section_present_and_terminated() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let phoff = read_u64(&bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
        let mut dyn_off = 0u64;
        let mut dyn_sz = 0u64;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            if read_u32(&bytes, off) == PT_DYNAMIC {
                dyn_off = read_u64(&bytes, off + 8);
                dyn_sz = read_u64(&bytes, off + 32);
                break;
            }
        }
        assert!(dyn_off > 0 && dyn_sz > 0, "PT_DYNAMIC missing");
        // Last entry must be DT_NULL.
        let last = (dyn_off + dyn_sz - ELF64_DYN_SIZE) as usize;
        assert_eq!(read_u64(&bytes, last), DT_NULL);
    }

    #[test]
    fn elf_hash_matches_known_values() {
        // Cross-check with the canonical SysV ELF hash function.
        // Values verified by hand-tracing the algorithm; if these
        // change, the loader will look in the wrong bucket and
        // every libc symbol will silently miss.
        assert_eq!(elf_hash(b""), 0);
        assert_eq!(elf_hash(b"printf"), 0x077905a6);
        assert_eq!(elf_hash(b"malloc"), 0x07383353);
        assert_eq!(elf_hash(b"exit"), 0x0006cf04);
    }

    #[test]
    fn rela_dyn_targets_got_slots() {
        // Each .rela.dyn entry must target a valid GOT slot. Walk
        // PT_DYNAMIC for DT_RELA / DT_RELASZ, then verify each entry's
        // r_offset lies inside the rw PT_LOAD segment.
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let phoff = read_u64(&bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;

        let mut dyn_off = 0u64;
        let mut dyn_sz = 0u64;
        let mut rw_lo = u64::MAX;
        let mut rw_hi = 0u64;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            let p_type = read_u32(&bytes, off);
            if p_type == PT_DYNAMIC {
                dyn_off = read_u64(&bytes, off + 8);
                dyn_sz = read_u64(&bytes, off + 32);
            }
            if p_type == PT_LOAD {
                let p_flags = read_u32(&bytes, off + 4);
                if p_flags & PF_W != 0 {
                    rw_lo = read_u64(&bytes, off + 16);
                    rw_hi = rw_lo + read_u64(&bytes, off + 40);
                }
            }
        }

        // Walk dynamic to find DT_RELA / DT_RELASZ.
        let mut rela_vmaddr = 0u64;
        let mut rela_size = 0u64;
        let mut p = dyn_off as usize;
        while (p as u64) < dyn_off + dyn_sz {
            let tag = read_u64(&bytes, p);
            let val = read_u64(&bytes, p + 8);
            if tag == DT_RELA {
                rela_vmaddr = val;
            }
            if tag == DT_RELASZ {
                rela_size = val;
            }
            p += ELF64_DYN_SIZE as usize;
        }
        assert!(rela_vmaddr > 0 && rela_size > 0);
        // Translate vmaddr to file offset (ET_EXEC, no slide).
        let rela_file_off = (rela_vmaddr - TEXT_VMADDR_BASE) as usize;
        let n = (rela_size / ELF64_RELA_SIZE) as usize;
        for i in 0..n {
            let r_offset = read_u64(&bytes, rela_file_off + i * ELF64_RELA_SIZE as usize);
            assert!(
                r_offset >= rw_lo && r_offset < rw_hi,
                "rela {i} r_offset {r_offset:#x} not inside rw PT_LOAD [{rw_lo:#x}, {rw_hi:#x})"
            );
        }
    }

    /// Walk the program-header table for the first phdr matching
    /// `p_type`. Returns `None` if no such phdr exists. Used by
    /// the TLS structural tests to assert presence / absence of
    /// `PT_TLS`.
    fn find_phdr(bytes: &[u8], p_type: u32) -> Option<usize> {
        let phoff = read_u64(bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            if read_u32(bytes, off) == p_type {
                return Some(off);
            }
        }
        None
    }

    /// `_Thread_local`-free programs must NOT carry a `PT_TLS`
    /// program header. The dynamic loader uses `PT_TLS` to size
    /// per-thread storage at thread creation; emitting one for a
    /// program with no TLS image would make glibc allocate empty
    /// per-thread regions on every clone, masking the bug behind
    /// a small but nonzero overhead.
    #[test]
    fn no_thread_local_means_no_pt_tls() {
        // The x86_64 `_start` stub picks argc/argv registers
        // out of `abi.int_arg_regs`, and its hard-coded
        // `START_STUB_LEN = 23` assumes the SysV ABI's RDI/RSI.
        // `tiny_build()`'s default `abi` is `LinuxAarch64`'s,
        // whose `int_arg_regs[0]` is byte 0 -- which collides
        // with RAX in x86_64 land and turns the post-call
        // `mov argc_reg, rax` into a self-mov the elision pass
        // drops, shortening the stub by 3 bytes. Build with the
        // matching target so each path sees its own ABI.
        for (machine, target) in [
            (Machine::Aarch64, super::super::Target::LinuxAarch64),
            (Machine::X86_64, super::super::Target::LinuxX64),
        ] {
            let mut b = tiny_build();
            b.abi = target.abi();
            let bytes = write(&tiny_program(), &b, machine).unwrap();
            assert!(
                find_phdr(&bytes, PT_TLS).is_none(),
                "{machine:?}: unexpected PT_TLS phdr in TLS-free image"
            );
        }
    }

    /// Compile a `_Thread_local`-using program for Linux/aarch64,
    /// confirm a `PT_TLS` phdr is emitted, and check its
    /// `p_filesz` / `p_memsz` match `tls_init_size` / total TLS
    /// size. Mirrors the structural check in
    /// `c5::codegen::pe::tests::thread_local_emits_well_formed_tls_directory_x64`.
    #[test]
    fn thread_local_emits_well_formed_pt_tls_aarch64() {
        use crate::Compiler;
        // Two distinct TLS variables: 16 bytes of .tbss total,
        // 0 bytes of .tdata (no initialiser syntax yet).
        let src = "_Thread_local int counter; _Thread_local int marker; \
             int main() { counter = 1; marker = 2; return counter + marker; }";
        let program = Compiler::with_target(
            super::super::super::tests::with_prelude(src),
            super::super::Target::LinuxAarch64,
        )
        .compile()
        .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::LinuxAarch64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(&tiny_program(), &build, Machine::Aarch64).expect("write ELF");

        let phdr_off = find_phdr(&bytes, PT_TLS).expect("expected PT_TLS phdr");
        let p_flags = read_u32(&bytes, phdr_off + 4);
        let p_offset = read_u64(&bytes, phdr_off + 8);
        let p_filesz = read_u64(&bytes, phdr_off + 32);
        let p_memsz = read_u64(&bytes, phdr_off + 40);
        let p_align = read_u64(&bytes, phdr_off + 48);

        // PT_TLS is read-only metadata as far as the loader is
        // concerned; PF_R is the canonical setting, matching what
        // ld.so emits for static-exec TLS.
        assert_eq!(p_flags, PF_R, "PT_TLS flags should be PF_R");
        // `p_filesz` covers .tdata only; `p_memsz` covers .tdata
        // plus .tbss. With no initialiser syntax in c5, the c5
        // frontend produces tls_init_size = 0, so p_filesz is 0
        // and p_memsz equals the full TLS block size.
        assert_eq!(
            p_filesz, build.tls_init_size as u64,
            "PT_TLS p_filesz must equal .tdata size"
        );
        assert_eq!(
            p_memsz,
            build.tls_data.len() as u64,
            "PT_TLS p_memsz must equal .tdata + .tbss size"
        );
        assert_eq!(p_memsz, 16, "two int TLS vars => 16 bytes per thread");
        // Alignment 8 matches glibc's TLS image alignment for
        // word-sized variables.
        assert_eq!(p_align, 8);
        // The TLS image must lie inside an rw PT_LOAD so the
        // loader can read .tdata as the per-thread initial image.
        let phoff = read_u64(&bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
        let mut covered = false;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            if read_u32(&bytes, off) != PT_LOAD {
                continue;
            }
            let p_off = read_u64(&bytes, off + 8);
            let p_fsz = read_u64(&bytes, off + 32);
            if p_offset >= p_off && p_offset + p_filesz <= p_off + p_fsz {
                covered = true;
                break;
            }
        }
        assert!(
            covered || p_filesz == 0,
            "PT_TLS image not covered by any PT_LOAD"
        );
    }

    /// x86_64 mirror of the aarch64 PT_TLS structural test. The
    /// per-arch lowering encodes the TLS access differently
    /// (variant-2 `mov r13, fs:[0]; sub r13, tpoff` vs aarch64's
    /// variant-1 `mrs ... tpidr_el0`), but the writer side --
    /// PT_TLS phdr + .tdata layout -- is shared.
    #[test]
    fn thread_local_emits_well_formed_pt_tls_x86_64() {
        use crate::Compiler;
        let src = "_Thread_local int counter; \
             int main() { counter = 7; return counter; }";
        let program = Compiler::with_target(
            super::super::super::tests::with_prelude(src),
            super::super::Target::LinuxX64,
        )
        .compile()
        .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::LinuxX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(&tiny_program(), &build, Machine::X86_64).expect("write ELF");

        let phdr_off = find_phdr(&bytes, PT_TLS).expect("expected PT_TLS phdr");
        let p_filesz = read_u64(&bytes, phdr_off + 32);
        let p_memsz = read_u64(&bytes, phdr_off + 40);
        assert_eq!(
            p_filesz, build.tls_init_size as u64,
            "PT_TLS p_filesz must equal .tdata size"
        );
        assert_eq!(
            p_memsz,
            build.tls_data.len() as u64,
            "PT_TLS p_memsz must equal .tdata + .tbss size"
        );
        assert_eq!(p_memsz, 8, "single int TLS var => 8 bytes per thread");
    }

    /// The R+E and RW `PT_LOAD` segments are packed at the per-arch page
    /// size (4K x86_64, 16K aarch64), so an executable's file size tracks
    /// its loaded content. A blanket 64K segment alignment forced a ~64K
    /// inter-segment hole, ballooning a trivial program to ~130K of mostly
    /// zero padding.
    #[test]
    fn executable_file_size_tracks_content_not_max_page() {
        use crate::Compiler;
        let src = "const char *g_msg = \"data-segment string literal for size accounting\"; \
             int main() { return g_msg[0]; }";
        for (machine, target, max_bytes) in [
            (
                Machine::X86_64,
                super::super::Target::LinuxX64,
                32 * 1024usize,
            ),
            (
                Machine::Aarch64,
                super::super::Target::LinuxAarch64,
                64 * 1024usize,
            ),
        ] {
            let program =
                Compiler::with_target(super::super::super::tests::with_prelude(src), target)
                    .compile()
                    .expect("compile");
            let build =
                super::super::lower_for(&program, target, super::super::NativeOptions::default())
                    .expect("lower");
            let bytes = write(&tiny_program(), &build, machine).expect("write ELF");
            assert!(
                bytes.len() < max_bytes,
                "{machine:?} executable is {} bytes; per-arch page packing must keep it under {max_bytes} \
                 (a 64K-aligned layout would push it past ~130K)",
                bytes.len(),
            );
        }
    }

    /// Shared-library output (`OutputKind::SharedLibrary`)
    /// flips `e_type` to `ET_DYN` and adds the
    /// `#pragma export(<name>)` symbols to `.dynsym` as
    /// `STB_GLOBAL | STT_FUNC` defined entries. This test
    /// covers the structural side: e_type is right, the
    /// export string lives in `.dynstr`, and the `.dynsym`
    /// entry has `st_value` set to a non-zero VA pointing
    /// inside the code segment. End-to-end runtime tests
    /// (dlopen / dlsym / call) live on the Linux orb VMs in
    /// CI -- macOS hosts can't load Linux ELFs directly.
    #[test]
    fn shared_library_output_emits_et_dyn_with_exports() {
        use crate::Compiler;
        let src = "
            int answer() { return 42; }
            #pragma export(answer)
            int main() { return 0; }
        ";
        for (machine, target) in [
            (Machine::Aarch64, super::super::Target::LinuxAarch64),
            (Machine::X86_64, super::super::Target::LinuxX64),
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
            let bytes = write(&tiny_program(), &build, machine).expect("write ELF");

            // e_type = ET_DYN.
            let e_type = u16::from_le_bytes(bytes[16..18].try_into().unwrap());
            assert_eq!(e_type, ET_DYN, "{machine:?}: expected ET_DYN");

            // .dynstr contains "answer".
            let phoff = read_u64(&bytes, 32);
            let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
            let mut dynsym_vmaddr = 0u64;
            let mut dynstr_vmaddr = 0u64;
            let mut load_min = u64::MAX;
            for i in 0..phnum {
                let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
                if read_u32(&bytes, off) == PT_LOAD {
                    load_min = load_min.min(read_u64(&bytes, off + 16));
                }
                if read_u32(&bytes, off) == PT_DYNAMIC {
                    let dyn_off = read_u64(&bytes, off + 8);
                    let dyn_sz = read_u64(&bytes, off + 32);
                    let mut p = dyn_off as usize;
                    while (p as u64) < dyn_off + dyn_sz {
                        let tag = read_u64(&bytes, p);
                        let val = read_u64(&bytes, p + 8);
                        if tag == DT_SYMTAB {
                            dynsym_vmaddr = val;
                        }
                        if tag == DT_STRTAB {
                            dynstr_vmaddr = val;
                        }
                        p += ELF64_DYN_SIZE as usize;
                    }
                }
            }
            assert!(dynsym_vmaddr > 0 && dynstr_vmaddr > 0);
            // Translate vmaddr to file offset via the rw
            // PT_LOAD's vmaddr base. .dynsym + .dynstr both
            // live inside the rx PT_LOAD which is mapped at
            // TEXT_VMADDR_BASE.
            let dynstr_file_off = (dynstr_vmaddr - load_min) as usize;
            let dynstr_slice = &bytes[dynstr_file_off..];
            let mut found_export = false;
            for off in 0..dynstr_slice.len().saturating_sub(7) {
                if &dynstr_slice[off..off + 7] == b"answer\0" {
                    found_export = true;
                    break;
                }
            }
            assert!(found_export, "{machine:?}: `answer` missing from .dynstr");

            // .dynsym last entry is the export -- check
            // st_info encodes STB_GLOBAL | STT_FUNC and
            // st_value is non-zero.
            let dynsym_file_off = (dynsym_vmaddr - load_min) as usize;
            let last_sym_off =
                dynsym_file_off + (1 + build.imports.imports.len()) * ELF64_SYM_SIZE as usize;
            let sym: super::Elf64Sym = read_struct(&bytes, last_sym_off);
            assert_eq!(
                sym.st_info,
                (STB_GLOBAL << 4) | STT_FUNC,
                "{machine:?}: export symbol must be STB_GLOBAL | STT_FUNC"
            );
            assert!(
                sym.st_value > 0,
                "{machine:?}: export st_value must be the function VA"
            );
            // A code export must name its real section (.text), not the
            // .interp placeholder, so section-attributing tools classify
            // it correctly. Resolve st_shndx through the section-header
            // string table.
            let eh: super::Elf64Ehdr = read_struct(&bytes, 0);
            let shdr_at = |idx: u16| eh.e_shoff as usize + idx as usize * eh.e_shentsize as usize;
            let shstrtab: super::Elf64Shdr = read_struct(&bytes, shdr_at(eh.e_shstrndx));
            let sec: super::Elf64Shdr = read_struct(&bytes, shdr_at(sym.st_shndx));
            let name_start = shstrtab.sh_offset as usize + sec.sh_name as usize;
            let name_len = bytes[name_start..].iter().position(|&b| b == 0).unwrap();
            let sec_name = core::str::from_utf8(&bytes[name_start..name_start + name_len]).unwrap();
            assert_eq!(
                sec_name, ".text",
                "{machine:?}: code export st_shndx must name .text, got `{sec_name}`"
            );
        }
    }

    // Returns (sh_type, sh_flags, sh_addr, sh_size, sh_addralign) of the
    // first section header named `want`, resolving names through the
    // section-header string table (e_shstrndx).
    fn find_section(bytes: &[u8], want: &str) -> Option<(u32, u64, u64, u64, u64)> {
        let eh: super::Elf64Ehdr = read_struct(bytes, 0);
        let shdr_at = |idx: u64| eh.e_shoff as usize + idx as usize * eh.e_shentsize as usize;
        let strtab: super::Elf64Shdr = read_struct(bytes, shdr_at(eh.e_shstrndx as u64));
        for i in 0..eh.e_shnum as u64 {
            let sh: super::Elf64Shdr = read_struct(bytes, shdr_at(i));
            let name_start = strtab.sh_offset as usize + sh.sh_name as usize;
            let len = bytes[name_start..].iter().position(|&b| b == 0).unwrap();
            if core::str::from_utf8(&bytes[name_start..name_start + len]).unwrap() == want {
                return Some((
                    sh.sh_type,
                    sh.sh_flags,
                    sh.sh_addr,
                    sh.sh_size,
                    sh.sh_addralign,
                ));
            }
        }
        None
    }

    // The `.bss` writer path is arch-independent; tiny_build carries
    // an aarch64 text fixture, so the structural assertions run on
    // aarch64 like the other tiny_build writer tests.
    #[test]
    fn bss_section_header_present_and_memsz_reserved() {
        const SHT_NOBITS: u32 = 8;
        let mut build = tiny_build();
        build.data = vec![1u8, 2, 3, 4, 5, 6, 7, 8];
        build.bss_size = 4096;
        let bytes = write(&tiny_program(), &build, Machine::Aarch64).unwrap();
        let (sh_type, sh_flags, sh_addr, sh_size, sh_align) =
            find_section(&bytes, ".bss").expect("`.bss` section header");
        assert_eq!(sh_type, SHT_NOBITS, ".bss must be SHT_NOBITS");
        assert_eq!(sh_flags & SHF_ALLOC, SHF_ALLOC, ".bss SHF_ALLOC");
        assert_eq!(sh_flags & SHF_WRITE, SHF_WRITE, ".bss SHF_WRITE");
        assert_eq!(sh_size, build.bss_size as u64, ".bss sh_size");
        assert!(
            sh_align > 0 && sh_addr % sh_align == 0,
            ".bss sh_addr {sh_addr:#x} not congruent to align {sh_align}"
        );

        // The rw PT_LOAD reserves the bss bytes past its file image
        // (p_memsz > p_filesz); no TLS here, so the tail equals bss.
        let phoff = read_u64(&bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
        let mut reserved = None;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            if read_u32(&bytes, off) == PT_LOAD && read_u32(&bytes, off + 4) & PF_W != 0 {
                reserved = Some(read_u64(&bytes, off + 40) - read_u64(&bytes, off + 32));
            }
        }
        assert_eq!(
            reserved,
            Some(build.bss_size as u64),
            "rw PT_LOAD memsz tail must equal bss_size"
        );
    }

    #[test]
    fn no_bss_section_header_when_bss_empty() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        assert!(
            find_section(&bytes, ".bss").is_none(),
            "no .bss section header when bss_size == 0"
        );
    }
}

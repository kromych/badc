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
//! ET_EXEC + PT_INTERP. The loader (ld-linux-aarch64.so.1) maps both
//! PT_LOAD segments at their fixed vmaddrs (no slide -- ET_EXEC), then
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

use super::super::error::C4Error;
use super::{Build, Machine};
use super::{aarch64, x86_64};

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

const EM_AARCH64: u16 = 183;
const EM_X86_64: u16 = 62;

const PT_LOAD: u32 = 1;
const PT_DYNAMIC: u32 = 2;
const PT_INTERP: u32 = 3;
const PT_PHDR: u32 = 6;
const PT_GNU_STACK: u32 = 0x6474_E551;

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

const DF_BIND_NOW: u64 = 0x8;

// nlist / Elf64_Sym fields.
const STB_GLOBAL: u8 = 1;
const STT_NOTYPE: u8 = 0;
const SHN_UNDEF: u16 = 0;

// Relocation types we emit.
const R_AARCH64_GLOB_DAT: u64 = 1025;
const R_X86_64_GLOB_DAT: u64 = 6;

/// 4 KiB page alignment is the AArch64 minimum and what most Linuxes
/// expect for ELF segment alignment. (Kernel page size on arm64 is
/// configurable -- 4K, 16K, or 64K -- but ELF p_align of 0x1000 works
/// across the board because the loader rounds up.)
const PAGE_SIZE: u64 = 0x1000;

/// Default load address for non-PIE ET_EXEC binaries on Linux/aarch64.
/// The kernel maps the binary at exactly this vmaddr (no slide); all
/// our .got slot addresses, e_entry, etc. are absolute and burned in.
const TEXT_VMADDR_BASE: u64 = 0x40_0000;

const ELF_HEADER_SIZE: u64 = 64;
const PROGRAM_HEADER_SIZE: u64 = 56;
const N_PROGRAM_HEADERS: u64 = 6;

const ELF64_SYM_SIZE: u64 = 24;
const ELF64_RELA_SIZE: u64 = 24;
const ELF64_DYN_SIZE: u64 = 16;

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

/// Libraries the binary declares as `DT_NEEDED`. The order is
/// cosmetic; the loader pulls in everything reachable from the set
/// regardless of order.
///
/// `libdl.so.2` is included unconditionally for `dlopen` / `dlsym` /
/// `dlclose` / `dlerror` support. On glibc 2.34+ this is a stub that
/// re-exports from libc.so.6; on older systems it carries the actual
/// implementation. Listing it always means the same binary runs on
/// both.
const NEEDED_LIBS: &[&str] = &["libc.so.6", "libdl.so.2"];

// ------------------------------------------------------------------
// Tiny serialization helpers.
// ------------------------------------------------------------------

fn put_u16(out: &mut Vec<u8>, v: u16) {
    out.extend_from_slice(&v.to_le_bytes());
}
fn put_u32(out: &mut Vec<u8>, v: u32) {
    out.extend_from_slice(&v.to_le_bytes());
}
fn put_u64(out: &mut Vec<u8>, v: u64) {
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
// `x86_64::emit_start_stub`. aarch64 routes its exit through libc
// (so glibc flushes stdio); x86_64 currently uses a raw `SYS_exit`
// syscall (M3.4 will switch it to libc exit through the GOT).
// ------------------------------------------------------------------

/// Stub byte length per machine. Used for layout calculations.
fn start_stub_len(machine: Machine) -> u64 {
    match machine {
        Machine::Aarch64 => 6 * 4, // 6 aarch64 instructions
        Machine::X86_64 => x86_64::START_STUB_LEN,
    }
}

/// Emit the `_start` prologue for the given machine. Returns the
/// byte offset of the libc-exit GOT call placeholder so the caller
/// can register a `GotFixup` for it. Both arches now route exit
/// through libc -- x86_64 used to do a raw syscall (M3.1) but
/// switched in M3.4 so glibc flushes stdio.
fn emit_start_stub(machine: Machine, code: &mut Vec<u8>, main_offset_in_code: u64) -> usize {
    match machine {
        Machine::Aarch64 => emit_start_stub_aarch64(code, main_offset_in_code),
        Machine::X86_64 => x86_64::emit_start_stub(code, main_offset_in_code),
    }
}

/// AArch64 `_start`: ldr argc; add argv; bl main; adrp/ldr/blr libc
/// exit.
fn emit_start_stub_aarch64(code: &mut Vec<u8>, main_offset_in_code: u64) -> usize {
    use aarch64::Reg;
    let stub_len = 6 * 4;

    aarch64::emit(code, aarch64::enc_ldr_imm(Reg::X0, Reg::SP, 0));
    aarch64::emit(code, aarch64::enc_add_imm(Reg::X1, Reg::SP, 8));

    let bl_pc = 8i64;
    let main_pc = stub_len as i64 + main_offset_in_code as i64;
    let delta_insns = ((main_pc - bl_pc) / 4) as i32;
    aarch64::emit(code, aarch64::enc_bl(delta_insns));

    // Placeholder adrp + ldr + blr through the libc exit GOT slot.
    // The caller appends a GotFixup with adrp_offset = current code
    // length so the writer fills in imm21/imm12 once the GOT vmaddr
    // is known.
    let exit_adrp_offset = code.len();
    aarch64::emit(code, aarch64::enc_adrp(Reg::X16, 0));
    aarch64::emit(code, aarch64::enc_ldr_imm(Reg::X16, Reg::X16, 0));
    aarch64::emit(code, aarch64::enc_blr(Reg::X16));

    debug_assert_eq!(code.len() as u64, stub_len);
    exit_adrp_offset
}

// ------------------------------------------------------------------
// Dynamic-linking metadata.
//
// Section ordering inside the r-x segment:
//   .interp .dynsym .dynstr .hash .rela.dyn
// All naturally 8-byte aligned.
// ------------------------------------------------------------------

/// Build .dynstr -- the dynamic string table. Returns
/// `(bytes, name_offsets, lib_offsets)` where `name_offsets[i]` is
/// the byte offset of `IMPORTS[i].linux_symbol` inside the table and
/// `lib_offsets[i]` is the offset of `NEEDED_LIBS[i]`.
fn build_dynstr() -> (Vec<u8>, Vec<u32>, Vec<u32>) {
    let mut bytes = Vec::new();
    bytes.push(0); // index 0 is conventionally the empty string

    let mut name_offsets = Vec::with_capacity(aarch64::IMPORTS.len());
    for imp in aarch64::IMPORTS {
        name_offsets.push(bytes.len() as u32);
        bytes.extend_from_slice(imp.linux_symbol.as_bytes());
        bytes.push(0);
    }

    let mut lib_offsets = Vec::with_capacity(NEEDED_LIBS.len());
    for lib in NEEDED_LIBS {
        lib_offsets.push(bytes.len() as u32);
        bytes.extend_from_slice(lib.as_bytes());
        bytes.push(0);
    }

    // Pad to 8 so the next section starts aligned.
    while !bytes.len().is_multiple_of(8) {
        bytes.push(0);
    }

    (bytes, name_offsets, lib_offsets)
}

/// Build .dynsym -- one Elf64_Sym per import plus a leading sentinel.
fn build_dynsym(name_offsets: &[u32]) -> Vec<u8> {
    let mut out = Vec::with_capacity((1 + name_offsets.len()) * ELF64_SYM_SIZE as usize);

    // Sentinel at index 0 -- all zero. Required by ELF.
    out.resize(ELF64_SYM_SIZE as usize, 0);

    for &name_off in name_offsets {
        // Elf64_Sym layout:
        //   uint32_t st_name
        //   uint8_t  st_info       ((bind << 4) | type)
        //   uint8_t  st_other      (visibility)
        //   uint16_t st_shndx
        //   uint64_t st_value
        //   uint64_t st_size
        put_u32(&mut out, name_off);
        out.push((STB_GLOBAL << 4) | STT_NOTYPE);
        out.push(0); // STV_DEFAULT
        put_u16(&mut out, SHN_UNDEF);
        put_u64(&mut out, 0);
        put_u64(&mut out, 0);
    }
    debug_assert_eq!(
        out.len() as u64,
        (1 + name_offsets.len() as u64) * ELF64_SYM_SIZE
    );
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
        // Elf64_Rela:
        //   uint64_t r_offset    -- where to write
        //   uint64_t r_info      -- (sym << 32) | type
        //   int64_t  r_addend    -- ignored for GLOB_DAT
        let sym_idx = (i as u64) + 1; // +1 for sentinel
        put_u64(&mut out, got_vmaddr + (i as u64) * 8);
        put_u64(&mut out, (sym_idx << 32) | r_type);
        put_u64(&mut out, 0);
    }
    out
}

/// Build .dynamic -- the table the loader walks to find every other
/// section. Each entry is `(d_tag, d_un)` 16 bytes. One DT_NEEDED
/// per [`NEEDED_LIBS`] entry, then the standard pointer-and-size
/// tags for the symbol / string / hash / rela sections.
fn build_dynamic(lib_strtab_offsets: &[u32], info: DynamicInfo) -> Vec<u8> {
    let mut out = Vec::with_capacity((NEEDED_LIBS.len() + 11) * ELF64_DYN_SIZE as usize);
    for &off in lib_strtab_offsets {
        put_u64(&mut out, DT_NEEDED);
        put_u64(&mut out, off as u64);
    }
    let entries: &[(u64, u64)] = &[
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
        (DT_NULL, 0),
    ];
    for (tag, val) in entries {
        put_u64(&mut out, *tag);
        put_u64(&mut out, *val);
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
) -> Result<(), C4Error> {
    let adrp_file_off = (code_base_in_file + adrp_offset_in_code) as usize;
    let ldr_file_off = adrp_file_off + 4;
    let adrp_vmaddr = code_vmaddr_base + adrp_offset_in_code;

    let adrp_page = adrp_vmaddr & !0xFFF;
    let target_page = target_vmaddr & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C4Error::Compile(format!(
            "ELF: {label} page diff {page_diff} not 4 KiB aligned"
        )));
    }
    let imm21 = (page_diff >> 12) as i32;
    let in_page = (target_vmaddr & 0xFFF) as u32;
    if !in_page.is_multiple_of(8) {
        return Err(C4Error::Compile(format!(
            "ELF: {label} slot offset {in_page:#x} not 8-aligned"
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
) -> Result<(), C4Error> {
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
) -> Result<(), C4Error> {
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
) -> Result<(), C4Error> {
    let call_len = x86_64::CALL_QWORD_RIP32_LEN as u64;
    let instr_vmaddr = code_vmaddr_base + instr_offset_in_code;
    let after = instr_vmaddr + call_len;
    let delta = target_vmaddr as i64 - after as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
        return Err(C4Error::Compile(format!(
            "ELF: {label} disp {delta} doesn't fit in 32 bits"
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
) -> Result<(), C4Error> {
    let lea_len = x86_64::LEA_RIP32_LEN as u64;
    let instr_vmaddr = code_vmaddr_base + instr_offset_in_code;
    let after = instr_vmaddr + lea_len;
    let delta = target_vmaddr as i64 - after as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
        return Err(C4Error::Compile(format!(
            "ELF: {label} disp {delta} doesn't fit in 32 bits"
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
) -> Result<(), C4Error> {
    let adrp_file_off = (code_base_in_file + adrp_offset_in_code) as usize;
    let add_file_off = adrp_file_off + 4;
    let adrp_vmaddr = code_vmaddr_base + adrp_offset_in_code;

    let adrp_page = adrp_vmaddr & !0xFFF;
    let target_page = target_vmaddr & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C4Error::Compile(format!(
            "ELF: {label} page diff {page_diff} not 4 KiB aligned"
        )));
    }
    let imm21 = (page_diff >> 12) as i32;
    let in_page = (target_vmaddr & 0xFFF) as u32;

    let adrp_word = aarch64::enc_adrp(aarch64::Reg::X19, imm21);
    let add_word = aarch64::enc_add_imm(aarch64::Reg::X19, aarch64::Reg::X19, in_page);
    out[adrp_file_off..adrp_file_off + 4].copy_from_slice(&adrp_word.to_le_bytes());
    out[add_file_off..add_file_off + 4].copy_from_slice(&add_word.to_le_bytes());
    Ok(())
}

// ------------------------------------------------------------------
// Top-level writer.
// ------------------------------------------------------------------

pub(super) fn write(build: &Build, machine: Machine) -> Result<Vec<u8>, C4Error> {
    let n_imports = aarch64::IMPORTS.len();
    let stub_len = start_stub_len(machine);

    // ---- Build the dynamic-linking metadata up front so we know the
    //      sizes for layout calculations. ----
    let (dynstr, name_offsets, lib_strtab_offsets) = build_dynstr();
    let dynsym = build_dynsym(&name_offsets);
    let hash = build_hash(&name_offsets, &dynstr);
    // .rela.dyn is built later -- it needs got_vmaddr.

    let interp_path_str = interp_path(machine);

    // .interp string (NUL-terminated). Round up to 8 so the next
    // section starts aligned.
    let mut interp = interp_path_str.as_bytes().to_vec();
    interp.push(0);
    while !interp.len().is_multiple_of(8) {
        interp.push(0);
    }

    // ---- Layout pass 1: compute file offsets in r-x segment. ----
    let phoff = ELF_HEADER_SIZE;
    let phsize = N_PROGRAM_HEADERS * PROGRAM_HEADER_SIZE;

    let interp_off = phoff + phsize;
    let dynsym_off = interp_off + interp.len() as u64;
    let dynstr_off = dynsym_off + dynsym.len() as u64;
    let hash_off = dynstr_off + dynstr.len() as u64;
    let rela_off = hash_off + hash.len() as u64;
    let rela_size = (n_imports as u64) * ELF64_RELA_SIZE;
    let code_off = round_up(rela_off + rela_size, 16);

    // Build the code blob: _start stub + build.text (with shifted
    // fixup offsets at write time). The stub may or may not register
    // a libc-exit GOT fixup depending on the machine.
    let mut code: Vec<u8> = Vec::with_capacity(stub_len as usize + build.text.len());
    let exit_adrp_offset = emit_start_stub(machine, &mut code, build.entry_offset as u64);
    code.extend_from_slice(&build.text);
    let code_size = code.len() as u64;

    let segment1_filesize = code_off + code_size;
    let segment1_end = round_up(segment1_filesize, PAGE_SIZE);

    // ---- Layout pass 2: rw segment (.dynamic, .got, build.data). ----
    let segment2_off = segment1_end;
    let dynamic_off = segment2_off;
    // `build_dynamic` emits one entry per NEEDED_LIBS plus 11 fixed
    // tags (DT_HASH, DT_STRTAB, ..., DT_NULL terminator).
    let dynamic_size = (NEEDED_LIBS.len() as u64 + 11) * ELF64_DYN_SIZE;
    let got_off = dynamic_off + dynamic_size;
    let got_size = (n_imports as u64) * 8;
    let data_off = got_off + got_size;
    let data_size = build.data.len() as u64;
    let segment2_filesize = data_off + data_size - segment2_off;
    let segment2_end = round_up(segment2_off + segment2_filesize, PAGE_SIZE);

    // ---- VM addresses (ET_EXEC, no slide). ----
    let interp_vmaddr = TEXT_VMADDR_BASE + interp_off;
    let dynsym_vmaddr = TEXT_VMADDR_BASE + dynsym_off;
    let dynstr_vmaddr = TEXT_VMADDR_BASE + dynstr_off;
    let hash_vmaddr = TEXT_VMADDR_BASE + hash_off;
    let rela_vmaddr = TEXT_VMADDR_BASE + rela_off;
    let code_vmaddr = TEXT_VMADDR_BASE + code_off;
    let dynamic_vmaddr = TEXT_VMADDR_BASE + dynamic_off;
    let got_vmaddr = TEXT_VMADDR_BASE + got_off;
    let data_vmaddr = TEXT_VMADDR_BASE + data_off;

    // ---- Build the bytes. ----
    let total_filesize = segment2_end;
    let mut out: Vec<u8> = Vec::with_capacity(total_filesize as usize);

    // ELF header.
    let mut e_ident = [0u8; EI_NIDENT];
    e_ident[0..4].copy_from_slice(&ELFMAG);
    e_ident[4] = ELFCLASS64;
    e_ident[5] = ELFDATA2LSB;
    e_ident[6] = EV_CURRENT;
    e_ident[7] = ELFOSABI_SYSV;
    out.extend_from_slice(&e_ident);

    put_u16(&mut out, ET_EXEC);
    put_u16(&mut out, e_machine(machine));
    put_u32(&mut out, EV_CURRENT as u32);
    put_u64(&mut out, code_vmaddr); // e_entry -- start of _start stub
    put_u64(&mut out, phoff);
    put_u64(&mut out, 0); // e_shoff
    put_u32(&mut out, 0); // e_flags
    put_u16(&mut out, ELF_HEADER_SIZE as u16);
    put_u16(&mut out, PROGRAM_HEADER_SIZE as u16);
    put_u16(&mut out, N_PROGRAM_HEADERS as u16);
    put_u16(&mut out, 0); // e_shentsize
    put_u16(&mut out, 0); // e_shnum
    put_u16(&mut out, 0); // e_shstrndx
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
        PAGE_SIZE,
    );

    // PT_LOAD rw -- .dynamic, .got, .data.
    write_phdr(
        &mut out,
        PT_LOAD,
        PF_R | PF_W,
        segment2_off,
        TEXT_VMADDR_BASE + segment2_off,
        segment2_filesize,
        segment2_filesize,
        PAGE_SIZE,
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

    // PT_GNU_STACK rw- (no x).
    write_phdr(&mut out, PT_GNU_STACK, PF_R | PF_W, 0, 0, 0, 0, 16);

    debug_assert_eq!(out.len() as u64, phoff + phsize);

    // .interp
    out.extend_from_slice(&interp);
    debug_assert_eq!(out.len() as u64, dynsym_off);

    // .dynsym
    out.extend_from_slice(&dynsym);
    debug_assert_eq!(out.len() as u64, dynstr_off);

    // .dynstr
    out.extend_from_slice(&dynstr);
    debug_assert_eq!(out.len() as u64, hash_off);

    // .hash
    out.extend_from_slice(&hash);
    debug_assert_eq!(out.len() as u64, rela_off);

    // .rela.dyn
    let rela = build_rela_dyn(got_vmaddr, n_imports, machine);
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
        },
    );
    debug_assert_eq!(dynamic.len() as u64, dynamic_size);
    out.extend_from_slice(&dynamic);

    // .got -- one zero-filled u64 per import. Loader fills these in
    // via .rela.dyn / R_AARCH64_GLOB_DAT before _start runs.
    out.extend(vec![0u8; got_size as usize]);

    // build.data -- the program's static data segment.
    out.extend_from_slice(&build.data);

    // Pad to end of segment 2 (page-aligned).
    while (out.len() as u64) < segment2_end {
        out.push(0);
    }
    debug_assert_eq!(out.len() as u64, total_filesize);

    // ---- Patch fixups. ----
    // The code blob layout is [_start stub][build.text]. The codegen's
    // adrp_offset is relative to build.text, so we shift by stub len.
    // The exit-call from _start: aarch64's `_start` ends with an
    // adrp+ldr+blr through the libc-exit GOT slot; x86_64's ends
    // with `call qword [rip + disp32]` against the same slot. The
    // per-arch GOT-call patcher knows which encoding to write.
    let exit_idx = exit_import_index();
    patch_got_call(
        machine,
        &mut out,
        code_file_offset,
        code_vmaddr,
        exit_adrp_offset as u64,
        got_vmaddr + (exit_idx as u64) * 8,
        "_start exit fixup",
    )?;

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
            data_vmaddr + fx.data_offset,
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
    put_u32(out, p_type);
    put_u32(out, p_flags);
    put_u64(out, p_offset);
    put_u64(out, p_vaddr);
    put_u64(out, p_vaddr); // p_paddr -- mirror of p_vaddr on systems
    // without separate physical/virtual mappings.
    put_u64(out, p_filesz);
    put_u64(out, p_memsz);
    put_u64(out, p_align);
}

fn exit_import_index() -> usize {
    aarch64::IMPORTS
        .iter()
        .position(|imp| matches!(imp.op, super::super::op::Op::Exit))
        .expect("Op::Exit must be in IMPORTS")
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Smallest plausible Build that exercises the writer end to end.
    /// 8 bytes of code (movz x0, #42; ret), no fixups.
    fn tiny_build() -> Build {
        Build {
            text: vec![0x40, 0x05, 0x80, 0xD2, 0xC0, 0x03, 0x5F, 0xD6],
            data: Vec::new(),
            entry_offset: 0,
            got_fixups: Vec::new(),
            data_fixups: Vec::new(),
            func_fixups: Vec::new(),
            bytecode_to_native: Vec::new(),
        }
    }

    fn read_u32(buf: &[u8], off: usize) -> u32 {
        u32::from_le_bytes(buf[off..off + 4].try_into().unwrap())
    }
    fn read_u64(buf: &[u8], off: usize) -> u64 {
        u64::from_le_bytes(buf[off..off + 8].try_into().unwrap())
    }

    #[test]
    fn writes_elf_magic() {
        let bytes = write(&tiny_build(), Machine::Aarch64).unwrap();
        assert_eq!(&bytes[0..4], &ELFMAG);
    }

    #[test]
    fn class_is_64_bit_le() {
        let bytes = write(&tiny_build(), Machine::Aarch64).unwrap();
        assert_eq!(bytes[4], ELFCLASS64);
        assert_eq!(bytes[5], ELFDATA2LSB);
    }

    #[test]
    fn machine_is_aarch64() {
        let bytes = write(&tiny_build(), Machine::Aarch64).unwrap();
        let e_machine = u16::from_le_bytes(bytes[18..20].try_into().unwrap());
        assert_eq!(e_machine, EM_AARCH64);
    }

    #[test]
    fn program_header_table_self_describes() {
        let bytes = write(&tiny_build(), Machine::Aarch64).unwrap();
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
        let bytes = write(&tiny_build(), Machine::Aarch64).unwrap();
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
        let bytes = write(&tiny_build(), Machine::Aarch64).unwrap();
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
        let bytes = write(&tiny_build(), Machine::Aarch64).unwrap();
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
        let bytes = write(&tiny_build(), Machine::Aarch64).unwrap();
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
}

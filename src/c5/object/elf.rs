//! ELF64 image writer: a PIE (`ET_DYN`) or shared object for Linux
//! aarch64 and x86_64, carrying `PT_INTERP` and the dynamic tables the
//! loader binds through, or no interpreter when nothing is imported.

use crate::c5::diag::Code;
use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::program::Program;
use super::elf_reloc_types::{
    R_AARCH64_COPY, R_AARCH64_GLOB_DAT, R_AARCH64_RELATIVE, R_X86_64_COPY, R_X86_64_GLOB_DAT,
    R_X86_64_RELATIVE,
};
use super::{Abi, AddrPart, Build, DataRegion, Machine, data_region_addr};
use super::{aarch64, dwarf, image, x86_64};
use crate::c5::layout::{round_up, write_struct};

const EI_NIDENT: usize = 16;

const ELFMAG: [u8; 4] = [0x7F, b'E', b'L', b'F'];
const ELFCLASS64: u8 = 2;
const ELFDATA2LSB: u8 = 1;
const EV_CURRENT: u8 = 1;
const ELFOSABI_SYSV: u8 = 0;

const ET_EXEC: u16 = 2;
const ET_DYN: u16 = 3;

const EM_AARCH64: u16 = 183;
const EM_X86_64: u16 = 62;

const PT_LOAD: u32 = 1;
const PT_DYNAMIC: u32 = 2;
const PT_INTERP: u32 = 3;
const PT_PHDR: u32 = 6;
const PT_TLS: u32 = 7;
const PT_GNU_STACK: u32 = 0x6474_E551;
const PT_GNU_RELRO: u32 = 0x6474_E552;
const TLS_SEGMENT_ALIGN: u64 = 8;

const PF_X: u32 = 1;
const PF_W: u32 = 2;
const PF_R: u32 = 4;

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
const DT_INIT_ARRAY: u64 = 25;
const DT_FINI_ARRAY: u64 = 26;
const DT_INIT_ARRAYSZ: u64 = 27;
const DT_FINI_ARRAYSZ: u64 = 28;
const DT_BIND_NOW: u64 = 24;
const DT_FLAGS: u64 = 30;
const DT_VERSYM: u64 = 0x6fff_fff0;
const DT_VERNEED: u64 = 0x6fff_fffe;
const DT_VERNEEDNUM: u64 = 0x6fff_ffff;

const DF_BIND_NOW: u64 = 0x8;

const VER_NDX_GLOBAL: u16 = 1;
const VER_NDX_FIRST: u16 = 2;

const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STB_WEAK: u8 = 2;
const STT_FUNC: u8 = 2;
const STT_OBJECT: u8 = 1;
const STT_SECTION: u8 = 3;
const SHF_INFO_LINK: u64 = 0x40;
const SHN_UNDEF: u16 = 0;

/// `PT_LOAD` segment alignment.
fn seg_align(machine: Machine) -> u64 {
    match machine {
        Machine::Aarch64 => 0x1_0000,
        Machine::X86_64 => 0x1000,
    }
}

const FILE_TAIL_ALIGN: u64 = 0x1000;

const TEXT_VMADDR_BASE: u64 = 0x40_0000;

const ELF_HEADER_SIZE: u64 = 64;
const PROGRAM_HEADER_SIZE: u64 = 56;
const N_BASE_PROGRAM_HEADERS: u64 = 7;

const RELRO_EMPTY_END_ALIGN: u64 = 0x1000;

const ELF64_SYM_SIZE: u64 = 24;
const ELF64_RELA_SIZE: u64 = 24;
const ELF64_DYN_SIZE: u64 = 16;
const ELF64_SHDR_SIZE: u64 = 64;

const SHT_NULL: u32 = 0;
const SHT_PROGBITS: u32 = 1;
const SHT_SYMTAB: u32 = 2;
const SHT_STRTAB: u32 = 3;
const SHT_RELA: u32 = 4;
const SHT_HASH: u32 = 5;
const SHT_DYNAMIC: u32 = 6;
const SHT_DYNSYM: u32 = 11;
const SHT_GNU_VERNEED: u32 = 0x6fff_fffe;
const SHT_GNU_VERSYM: u32 = 0x6fff_ffff;

const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;
const SHF_MERGE: u64 = 0x10;
const SHF_STRINGS: u64 = 0x20;
const SHF_TLS: u64 = 0x400;
const SHT_NOBITS: u32 = 8;

// On-disk shapes. ELF is little-endian on all our targets, so a bare memcpy
// of the in-memory struct gives the right wire format.

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

/// Elf64_Rela -- one entry in `.rela.dyn`.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Rela {
    r_offset: u64,
    r_info: u64,
    r_addend: i64,
}

const _: () = assert!(core::mem::size_of::<Elf64Rela>() == ELF64_RELA_SIZE as usize);

/// Elf64_Dyn -- one entry in the `.dynamic` table.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Dyn {
    d_tag: u64,
    d_val: u64,
}

const _: () = assert!(core::mem::size_of::<Elf64Dyn>() == ELF64_DYN_SIZE as usize);

/// Elf64_Shdr -- one entry in the section header table.
#[repr(C)]
#[derive(Copy, Clone, Default)]
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

/// Section-header table layout.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Sec {
    Null,
    Interp,
    Dynsym,
    Dynstr,
    Hash,
    GnuVersion,
    GnuVersionR,
    RelaDyn,
    Text,
    RoData,
    Tdata,
    Dynamic,
    Got,
    RelRo,
    Data,
    Tbss,
    Bss,
    Debug,
    RelaText,
    RelaData,
    Comment,
    Symtab,
    Strtab,
    Shstrtab,
}

const SECTION_ORDER: [Sec; 24] = [
    Sec::Null,
    Sec::Interp,
    Sec::Dynsym,
    Sec::Dynstr,
    Sec::Hash,
    Sec::GnuVersion,
    Sec::GnuVersionR,
    Sec::RelaDyn,
    Sec::Text,
    Sec::RoData,
    Sec::Tdata,
    Sec::Dynamic,
    Sec::Got,
    Sec::RelRo,
    Sec::Data,
    Sec::Tbss,
    Sec::Bss,
    Sec::Debug,
    Sec::RelaText,
    Sec::RelaData,
    Sec::Comment,
    Sec::Symtab,
    Sec::Strtab,
    Sec::Shstrtab,
];

#[derive(Default)]
struct SectionPlan {
    counts: [usize; 24],
}

/// A named section placed in the image: the merge grouped its bytes
/// contiguously at the end of `slot`'s region, so it takes a header of its
/// own and the family header stops where the first one begins.
struct NamedOut<'a> {
    name: &'a str,
    slot: Sec,
    addr: u64,
    off: u64,
    size: u64,
    align: u64,
    bss: bool,
    write: bool,
}

/// Which optional sections an image carries.
#[derive(Clone, Copy, Default)]
struct SectionsPresent {
    versions: bool,
    rodata: bool,
    tdata: bool,
    relro: bool,
    data: bool,
    tbss: bool,
    bss: bool,
    dwarf: usize,
    rela_text: bool,
    rela_data: bool,
    plt_symtab: bool,
    named_rodata: usize,
    named_relro: usize,
    named_data: usize,
    named_bss: usize,
}

impl SectionPlan {
    fn new(p: SectionsPresent) -> Self {
        let mut counts = [1usize; 24];
        let mut set =
            |s: Sec, n: usize| counts[SECTION_ORDER.iter().position(|&x| x == s).unwrap()] = n;
        set(Sec::GnuVersion, p.versions as usize);
        set(Sec::GnuVersionR, p.versions as usize);
        set(Sec::RoData, p.rodata as usize + p.named_rodata);
        set(Sec::Tdata, p.tdata as usize);
        set(Sec::RelRo, p.relro as usize + p.named_relro);
        set(Sec::Data, p.data as usize + p.named_data);
        set(Sec::Tbss, p.tbss as usize);
        set(Sec::Bss, p.bss as usize + p.named_bss);
        set(Sec::Debug, p.dwarf);
        set(Sec::RelaText, p.rela_text as usize);
        set(Sec::RelaData, p.rela_data as usize);
        set(Sec::Symtab, p.plt_symtab as usize);
        set(Sec::Strtab, p.plt_symtab as usize);
        Self { counts }
    }

    /// Plan carrying only the sections that precede `.text`, for the early
    /// `text_shndx` the symbol tables need.
    fn prefix(has_versions: bool) -> Self {
        Self::new(SectionsPresent {
            versions: has_versions,
            ..Default::default()
        })
    }

    fn len(&self) -> usize {
        self.counts.iter().sum()
    }

    /// Section-header index of `s`, or of the slot it would occupy.
    fn index_of(&self, s: Sec) -> u16 {
        let at = SECTION_ORDER.iter().position(|&x| x == s).unwrap();
        self.counts[..at].iter().sum::<usize>() as u16
    }

    /// Which slot the header at index `i` belongs to.
    fn at(&self, i: usize) -> Sec {
        let mut seen = 0;
        for (slot, &n) in self.counts.iter().enumerate() {
            seen += n;
            if i < seen {
                return SECTION_ORDER[slot];
            }
        }
        panic!("section index {i} past the plan");
    }
}

/// Dynamic linker path.
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

/// `R_*_GLOB_DAT` relocation type: stores the symbol's resolved address
/// into the GOT slot.
fn r_glob_dat(machine: Machine) -> u64 {
    match machine {
        Machine::Aarch64 => R_AARCH64_GLOB_DAT.into(),
        Machine::X86_64 => R_X86_64_GLOB_DAT.into(),
    }
}

/// `R_*_RELATIVE` relocation type: the loader writes `load_bias + r_addend`
/// into the slot.
fn r_relative(machine: Machine) -> u64 {
    match machine {
        Machine::Aarch64 => R_AARCH64_RELATIVE.into(),
        Machine::X86_64 => R_X86_64_RELATIVE.into(),
    }
}

fn put_u32(out: &mut Vec<u8>, v: u32) {
    out.extend_from_slice(&v.to_le_bytes());
}

/// Stub byte length per machine.
fn start_stub_len(machine: Machine, use_libc_exit: bool) -> u64 {
    match (machine, use_libc_exit) {
        (Machine::Aarch64, true) => 6 * 4,
        (Machine::Aarch64, false) => 5 * 4,
        (Machine::X86_64, true) => x86_64::START_STUB_LEN,
        (Machine::X86_64, false) => x86_64::START_STUB_LEN_SYSCALL,
    }
}

/// Emit the `_start` prologue for the given machine.
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

/// AArch64 `_start`: ldr argc; add argv; bl main; then either `adrp/ldr/blr
/// libc::exit` or `mov w8, #94; svc #0`.
fn emit_start_stub_aarch64(
    abi: Abi,
    code: &mut Vec<u8>,
    main_offset_in_code: u64,
    use_libc_exit: bool,
) -> Option<usize> {
    use aarch64::Reg;
    let stub_len = start_stub_len(Machine::Aarch64, use_libc_exit);

    // argc / argv land in the first two of the ABI's int-arg-passing
    // registers. AAPCS64's order is x0..x7 so these come out as x0, x1;
    // pulling from `abi.int_arg_regs` keeps the stub honest if a future
    // arm64 ABI variant shuffles the bank.
    let argc_reg = Reg(abi.int_arg_regs[0]);
    let argv_reg = Reg(abi.int_arg_regs[1]);
    aarch64::emit(code, aarch64::enc_ldr_imm(argc_reg, Reg::SP, 0));
    aarch64::emit(code, aarch64::enc_add_imm(argv_reg, Reg::SP, 8));

    let bl_pc = 8i64;
    let main_pc = stub_len as i64 + main_offset_in_code as i64;
    let delta_insns = ((main_pc - bl_pc) / 4) as i32;
    aarch64::emit(code, aarch64::enc_bl(delta_insns));

    let result = if use_libc_exit {
        // Placeholder adrp + ldr + blr through the libc exit GOT slot. The
        // caller patches it at the current code length so the writer fills
        // in imm21/imm12 once the GOT vmaddr is known.
        let exit_adrp_offset = code.len();
        aarch64::emit(code, aarch64::enc_adrp(Reg::X16, 0));
        aarch64::emit(code, aarch64::enc_ldr_imm(Reg::X16, Reg::X16, 0));
        aarch64::emit(code, aarch64::enc_blr(Reg::X16));
        Some(exit_adrp_offset)
    } else {
        // direct `sys_exit_group` (Linux aarch64 syscall 94). main's int
        // return value is already in x0/w0, which is the syscall's first
        // arg. svc #0 transfers control to the kernel and never returns.
        // movz w8, #94 -- Linux aarch64 sys_exit_group number.
        aarch64::emit(code, aarch64::enc_movz(Reg::X8, 94, 0));
        aarch64::emit(code, aarch64::enc_svc(0));
        None
    };

    debug_assert_eq!(code.len() as u64, stub_len);
    result
}

/// Native offset within `build.text` of a function the entry adapter
/// targets, resolved through the merged symbol tables (`func_names` ->
/// `func_ent_pcs` -> `pc_to_native`).
fn symbol_text_offset(build: &Build, name: &str) -> Option<u64> {
    let idx = build.func_names.iter().position(|n| n == name)?;
    let ent_pc = build.func_ent_pcs[idx];
    Some(build.pc_to_native[ent_pc] as u64)
}

/// Extend `code` to `len` with `int3` / `brk #1`.
fn pad_with_traps(machine: Machine, code: &mut Vec<u8>, len: usize) {
    if code.len() >= len {
        return;
    }
    match machine {
        Machine::X86_64 => code.resize(len, 0xCC),
        Machine::Aarch64 => {
            while code.len() + 4 <= len {
                aarch64::emit(code, 0xd420_0020);
            }
            code.resize(len, 0);
        }
    }
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

/// Emit the entry adapter at the head of the code blob.
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
            code.extend_from_slice(&[0x31, 0xed]);
            code.extend_from_slice(&[0x48, 0x89, 0xe7]);
            code.push(0xbe);
            code.extend_from_slice(&(image_off as u32).to_le_bytes());
            let call_end = code.len() as u64 + 5;
            let target = stub_len + entry_off;
            let rel = target as i64 - call_end as i64;
            code.push(0xe8);
            code.extend_from_slice(&(rel as i32).to_le_bytes());
            code.extend_from_slice(&[0x0f, 0x0b]);
        }
        Machine::Aarch64 => {
            use aarch64::Reg;
            let arg0 = Reg(abi.int_arg_regs[0]);
            let arg1 = Reg(abi.int_arg_regs[1]);
            aarch64::emit(code, aarch64::enc_movz(Reg(29), 0, 0));
            aarch64::emit(code, aarch64::enc_add_imm(arg0, Reg::SP, 0));
            aarch64::emit(
                code,
                aarch64::enc_movz(arg1, (image_off & 0xffff) as u16, 0),
            );
            aarch64::emit(
                code,
                aarch64::enc_movk(arg1, ((image_off >> 16) & 0xffff) as u16, 1),
            );
            // b __c5_entry -- tail call. AAPCS64 keeps sp 16-aligned and
            // `b` doesn't disturb it; `__c5_entry` ends in `exit`, so no
            // return address is needed.
            let b_pc = code.len() as u64;
            let target = stub_len + entry_off;
            let rel_insns = ((target as i64 - b_pc as i64) / 4) as i32;
            aarch64::emit(code, aarch64::enc_b(rel_insns));
            aarch64::emit(code, 0xd420_0020);
        }
    }
    debug_assert_eq!(code.len() as u64, stub_len);
}

/// Build .dynstr -- the dynamic string table.
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

/// Build the static `.symtab` + `.strtab`: the SHT_SYMTAB sentinel at index
/// 0, one local `STT_FUNC` per import trampoline, then one local `STT_FUNC`
/// per defined function (named, with its address and length) so the output
/// is profilable without DWARF.
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
    // A data import (bound through the GOT) has no trampoline (`None`
    // slot); a text symbol for it would mislabel whatever code sits at the
    // fabricated address.
    let plt_locals: Vec<(&str, usize)> = imports
        .iter()
        .zip(build.plt_trampoline_offsets.iter())
        .filter_map(|(imp, off)| off.map(|o| (imp.local_name.as_str(), o)))
        .collect();

    let mut strtab = alloc::vec![0u8];
    let mut name_offsets: Vec<u32> = Vec::with_capacity(plt_locals.len());
    for &(name, _) in &plt_locals {
        name_offsets.push(strtab.len() as u32);
        strtab.extend_from_slice(name.as_bytes());
        strtab.push(0);
    }

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
    // One local STT_FUNC per defined function so a profiler / `nm` / `gdb`
    // can attribute an address to a function and its length without DWARF
    // (perf maps a sample by `[st_value, st_value + st_size)`, so a zero
    // size leaves the function unattributable).
    let boundaries = text_boundaries(build);
    for (i, name) in build.func_names.iter().enumerate() {
        let start = build.pc_to_native[build.func_ent_pcs[i]] as u64;
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
                st_size: text_body_len(&boundaries, start),
            },
        );
    }
    (symtab, strtab)
}

/// Sorted native `.text` offsets that end a function body: every defined
/// function entry, every import trampoline, and the end of `.text`.
fn text_boundaries(build: &super::Build) -> Vec<u64> {
    let mut boundaries: Vec<u64> = build
        .func_ent_pcs
        .iter()
        .filter_map(|&pc| build.pc_to_native.get(pc).map(|&o| o as u64))
        .collect();
    boundaries.extend(
        build
            .plt_trampoline_offsets
            .iter()
            .flatten()
            .map(|&o| o as u64),
    );
    boundaries.push(build.text.len() as u64);
    boundaries.sort_unstable();
    boundaries.dedup();
    boundaries
}

/// Byte length of the body starting at `start`: the span to the next
/// boundary past it.
fn text_body_len(boundaries: &[u64], start: u64) -> u64 {
    boundaries
        .get(boundaries.partition_point(|&b| b <= start))
        .copied()
        .unwrap_or_else(|| boundaries.last().copied().unwrap_or(start))
        .saturating_sub(start)
}

/// Build .dynsym.
fn build_dynsym(
    import_name_offsets: &[u32],
    import_is_object: &[bool],
    exports: &[DynsymExport],
    copies: &DynsymCopyTargets<'_>,
) -> Vec<u8> {
    let DynsymCopyTargets {
        name_offsets: copy_name_offsets,
        addrs: copy_addrs,
        sizes: copy_sizes,
        is_bss: copy_is_bss,
        data_shndx,
        bss_shndx,
    } = *copies;
    debug_assert_eq!(copy_name_offsets.len(), copy_addrs.len());
    debug_assert_eq!(copy_name_offsets.len(), copy_sizes.len());
    let n_total = 1 + import_name_offsets.len() + exports.len() + copy_name_offsets.len();
    let mut out = Vec::with_capacity(n_total * ELF64_SYM_SIZE as usize);

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

    debug_assert_eq!(import_name_offsets.len(), import_is_object.len());
    for (i, &name_off) in import_name_offsets.iter().enumerate() {
        write_struct(
            &mut out,
            &Elf64Sym {
                st_name: name_off,
                st_info: (STB_GLOBAL << 4)
                    | if import_is_object[i] {
                        STT_OBJECT
                    } else {
                        STT_FUNC
                    },
                st_other: 0, // STV_DEFAULT
                st_shndx: SHN_UNDEF,
                st_value: 0,
                st_size: 0,
            },
        );
    }

    for e in exports {
        write_struct(
            &mut out,
            &Elf64Sym {
                st_name: e.name_off,
                st_info: e.st_info,
                st_other: 0, // STV_DEFAULT -- restricted visibility never exports
                st_shndx: e.shndx,
                st_value: e.addr,
                st_size: e.size,
            },
        );
    }
    // Copy-relocation targets: a defined `STT_OBJECT` per data import. The
    // loader resolves the matching `R_*_COPY` by copying the host object's
    // initial value here and binding the host symbol to this address, so
    // every other module's reference reaches this slot.
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

/// Build the DT_HASH table over `.dynsym`.
fn build_hash(name_offsets: &[u32], dynstr: &[u8]) -> Vec<u8> {
    let nsyms = (1 + name_offsets.len()) as u32;
    let nbucket = 7u32.min(nsyms.max(1));
    let mut buckets = vec![0u32; nbucket as usize];
    let mut chain = vec![0u32; nsyms as usize];

    for (i, &name_off) in name_offsets.iter().enumerate() {
        let sym_idx = (i + 1) as u32; // sentinel is index 0
        let name = name_bytes(dynstr, name_off as usize);
        let bkt = (elf_hash(name) % nbucket) as usize;
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
fn build_rela_dyn(got_vmaddr: u64, n_imports: usize, machine: Machine) -> Vec<u8> {
    let r_type = r_glob_dat(machine);
    let mut out = Vec::with_capacity(n_imports * ELF64_RELA_SIZE as usize);
    for i in 0..n_imports {
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
/// section.
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
    // Constructor / destructor arrays the loader runs around the program.
    // Emitted only when present so a program with no constructors keeps the
    // same dynamic section it had before.
    if let Some((vmaddr, size)) = info.init_array {
        entries.push((DT_INIT_ARRAY, vmaddr));
        entries.push((DT_INIT_ARRAYSZ, size));
    }
    if let Some((vmaddr, size)) = info.fini_array {
        entries.push((DT_FINI_ARRAY, vmaddr));
        entries.push((DT_FINI_ARRAYSZ, size));
    }
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

/// Group of vmaddr/size values [`build_dynamic`] consumes.
#[derive(Debug, Clone, Copy)]
struct DynamicInfo {
    hash_vmaddr: u64,
    strtab_vmaddr: u64,
    symtab_vmaddr: u64,
    rela_vmaddr: u64,
    rela_size: u64,
    strtab_size: u64,
    versions: Option<VersionInfo>,
    init_array: Option<(u64, u64)>,
    fini_array: Option<(u64, u64)>,
}

/// A defined dynamic-symbol export for the ELF writer.
struct ElfExport {
    name: String,
    section: super::DynamicExportSection,
    offset: u64,
    size: u64,
    is_object: bool,
    weak: bool,
}

/// The copy-relocation targets `.dynsym` publishes: one defined
/// `STT_OBJECT` per data binding, in `Build::copy_relocs` order.
#[derive(Clone, Copy)]
struct DynsymCopyTargets<'a> {
    name_offsets: &'a [u32],
    addrs: &'a [u64],
    sizes: &'a [u64],
    is_bss: &'a [bool],
    data_shndx: u16,
    bss_shndx: u16,
}

/// An `ElfExport` resolved against the final layout, ready to write.
struct DynsymExport {
    name_off: u32,
    addr: u64,
    size: u64,
    st_info: u8,
    shndx: u16,
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

/// Where the written code blob sits: its byte offset in the image and the
/// runtime address of that same byte.
#[derive(Clone, Copy)]
struct CodePlacement {
    file_off: u64,
    vmaddr: u64,
}

impl CodePlacement {
    fn file_at(self, offset_in_code: u64) -> usize {
        (self.file_off + offset_in_code) as usize
    }

    fn vmaddr_at(self, offset_in_code: u64) -> u64 {
        self.vmaddr + offset_in_code
    }
}

// Adrp/ldr/add fixup patching. The codegen records GotFixup, DataFixup, and
// FuncFixup entries against `Build::text` byte offsets; we shift those by
// `START_STUB_LEN` (since the stub sits in front of build.text in the final
// code blob) and patch the immediates the same way the Mach-O writer does.

/// Patch an `adrp Xd, page; ldr Xd, [Xd, #imm12]` pair so it loads the
/// value at `target_vmaddr` -- here the address of a libc symbol that the
/// loader has written into .got.
fn patch_adrp_ldr(
    out: &mut [u8],
    code: CodePlacement,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    part: AddrPart,
    label: &str,
) -> Result<(), C5Error> {
    aarch64::patch::patch_slot(
        out,
        code.file_at(instr_offset_in_code),
        code.vmaddr_at(instr_offset_in_code) as i64,
        target_vmaddr as i64,
        aarch64::patch::SlotWidth::W64,
        part,
    )
    .map_err(|e| {
        C5Error::Compile(crate::c5::error::fmt_internal_diag(
            Code::INTERNAL,
            &e.describe(&format!("ELF: {label}")),
        ))
    })
}

/// Per-machine dispatch for "load an absolute address into the
/// accumulator". aarch64 uses an `adrp + add` pair; x86_64 uses a single
/// `lea r13, [rip + disp32]`.
fn patch_addr_load(
    machine: Machine,
    out: &mut [u8],
    code: CodePlacement,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    part: AddrPart,
    label: &str,
) -> Result<(), C5Error> {
    match machine {
        Machine::Aarch64 => {
            patch_adrp_add(out, code, instr_offset_in_code, target_vmaddr, part, label)
        }
        Machine::X86_64 => {
            crate::c5::codegen::require_whole_addr(part, label)?;
            patch_lea_rip32(out, code, instr_offset_in_code, target_vmaddr, label)
        }
    }
}

/// Per-machine dispatch for "call a libc function whose address lives in
/// the GOT". aarch64 emits adrp+ldr+blr -- patch the adrp+ldr immediates.
/// x86_64 emits `call qword [rip + disp32]` -- patch the disp32.
fn patch_got_call(
    machine: Machine,
    out: &mut [u8],
    code: CodePlacement,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    part: AddrPart,
    label: &str,
) -> Result<(), C5Error> {
    match machine {
        Machine::Aarch64 => {
            patch_adrp_ldr(out, code, instr_offset_in_code, target_vmaddr, part, label)
        }
        Machine::X86_64 => {
            crate::c5::codegen::require_whole_addr(part, label)?;
            patch_call_qword_rip32(out, code, instr_offset_in_code, target_vmaddr, label)
        }
    }
}

/// Patch the disp32 field of `call qword [rip + disp32]` so the loaded
/// pointer is at `target_vmaddr`.
fn patch_call_qword_rip32(
    out: &mut [u8],
    code: CodePlacement,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    let call_len = x86_64::CALL_QWORD_RIP32_LEN as u64;
    let instr_vmaddr = code.vmaddr_at(instr_offset_in_code);
    let after = instr_vmaddr + call_len;
    let delta = target_vmaddr as i64 - after as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_diag(
            Code::INTERNAL,
            &format!("ELF: {label} disp {delta} doesn't fit in 32 bits"),
        )));
    }
    let disp32 = delta as i32;
    let disp_file_off = code.file_at(instr_offset_in_code + call_len - 4);
    out[disp_file_off..disp_file_off + 4].copy_from_slice(&disp32.to_le_bytes());
    Ok(())
}

/// Patch the disp32 field of `lea r64, [rip + disp32]` so the instruction
/// computes `target_vmaddr` into its destination.
fn patch_lea_rip32(
    out: &mut [u8],
    code: CodePlacement,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    let lea_len = x86_64::LEA_RIP32_LEN as u64;
    let instr_vmaddr = code.vmaddr_at(instr_offset_in_code);
    let after = instr_vmaddr + lea_len;
    let delta = target_vmaddr as i64 - after as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_diag(
            Code::INTERNAL,
            &format!("ELF: {label} disp {delta} doesn't fit in 32 bits"),
        )));
    }
    let disp32 = delta as i32;
    let disp_file_off = code.file_at(instr_offset_in_code + lea_len - 4);
    out[disp_file_off..disp_file_off + 4].copy_from_slice(&disp32.to_le_bytes());
    Ok(())
}

/// Patch a data-import GOT reference so it loads the import's address from
/// its GOT slot at `slot_vmaddr`.
fn patch_got_data_load(
    out: &mut [u8],
    code: CodePlacement,
    instr_offset_in_code: u64,
    slot_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    let opcode_off = code.file_at(instr_offset_in_code + 1);
    if out[opcode_off] != 0x8D && out[opcode_off] != 0x8B {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_diag(
            Code::INTERNAL,
            &format!(
                "ELF: {label} expected lea 0x8D or mov 0x8B at file+{opcode_off:#x}, found {:#04x}",
                out[opcode_off],
            ),
        )));
    }
    out[opcode_off] = 0x8B;
    patch_lea_rip32(out, code, instr_offset_in_code, slot_vmaddr, label)
}

/// Patch the fields `part` names so the reference computes `target_vmaddr`.
fn patch_adrp_add(
    out: &mut [u8],
    code: CodePlacement,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    part: AddrPart,
    label: &str,
) -> Result<(), C5Error> {
    aarch64::patch::patch_addr(
        out,
        code.file_at(instr_offset_in_code),
        code.vmaddr_at(instr_offset_in_code) as i64,
        target_vmaddr as i64,
        part,
    )
    .map_err(|e| {
        C5Error::Compile(crate::c5::error::fmt_internal_diag(
            Code::INTERNAL,
            &e.describe(&format!("ELF: {label}")),
        ))
    })
}

/// Resolve each import's default library version from the host libraries,
/// parallel to `imports.imports`.
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

/// The dynamic-linking tables, built up front so the layout knows their
/// sizes.
#[derive(Default)]
struct DynTables {
    dynstr: Vec<u8>,
    name_offsets: Vec<u32>,
    lib_strtab_offsets: Vec<u32>,
    export_name_offsets: Vec<u32>,
    copy_name_offsets: Vec<u32>,
    import_is_object: Vec<bool>,
    copy_sizes: Vec<u64>,
    copy_is_bss: Vec<bool>,
    dynsym: Vec<u8>,
    hash: Vec<u8>,
    import_versym: Vec<u16>,
    verneed_groups: Vec<VerneedGroup>,
    has_versions: bool,
    text_shndx: u16,
    gnu_version: Vec<u8>,
    gnu_version_r: Vec<u8>,
    interp: Vec<u8>,
}

/// File offsets and sizes of the loaded segments.
#[derive(Default)]
struct Segments {
    has_tls: bool,
    ro_len: u64,
    relro_total: u64,
    relro_size: u64,
    jt_len: u64,
    jt_off: u64,
    ro_total: u64,
    has_rodata: bool,
    n_program_headers: u64,
    phoff: u64,
    phsize: u64,
    interp_off: u64,
    dynsym_off: u64,
    dynstr_off: u64,
    hash_off: u64,
    gnu_version_off: u64,
    gnu_version_r_off: u64,
    rela_off: u64,
    rela_size: u64,
    code_off: u64,
    code: Vec<u8>,
    exit_adrp_offset: Option<usize>,
    segment1_filesize: u64,
    align: u64,
    segment1_end: u64,
    rodata_off: u64,
    rodata_end: u64,
    segment2_off: u64,
    dynamic_off: u64,
    dynamic_size: u64,
    got_off: u64,
    got_size: u64,
    data_align: u64,
    relro_off: u64,
    relro_end: u64,
    data_off: u64,
    data_size: u64,
    rw_seg_align: u64,
    tdata_off: u64,
    tdata_size: u64,
    tbss_size: u64,
    segment2_filesize: u64,
    bss_vmaddr: u64,
    file_data_len: u64,
    segment2_memsize: u64,
    segment2_end: u64,
}

/// The non-loaded tail: DWARF, the emitted relocation tables, the static
/// symbol table and the section-header string table, with the section plan
/// that numbers every header.
#[derive(Default)]
struct Tail<'a> {
    emit_dwarf: bool,
    start_stub_range: Option<(u64, u64)>,
    dwarf: dwarf::DwarfSections,
    dwarf_off: u64,
    dwarf_abbrev_off: u64,
    dwarf_line_off: u64,
    dwarf_str_off: u64,
    dwarf_frame_off: u64,
    emit_symtab: bool,
    er_text: Vec<&'a crate::c5::codegen::EmittedFinalReloc>,
    er_data: Vec<&'a crate::c5::codegen::EmittedFinalReloc>,
    has_relro: bool,
    has_data: bool,
    has_tdata: bool,
    has_tbss: bool,
    has_bss: bool,
    named_out: Vec<NamedOut<'a>>,
    plan: SectionPlan,
    sec_syms: Vec<(Sec, u64)>,
    rela_text: Vec<u8>,
    rela_data: Vec<u8>,
    symtab: Vec<u8>,
    strtab: Vec<u8>,
    rela_text_off: u64,
    rela_data_off: u64,
    comment: Vec<u8>,
    comment_off: u64,
    symtab_off: u64,
    strtab_off: u64,
    shstrtab_off: u64,
    shstrtab_names: Vec<&'a str>,
    shstrtab: Vec<u8>,
    shstrtab_offsets: Vec<u32>,
    symtab_name_idx: Option<usize>,
    shstrtab_name_idx: usize,
    shdr_off: u64,
    total_filesize: u64,
}

/// One ELF image's writer. [`write`] runs the phases in order.
struct ElfImageWriter<'a> {
    program: &'a Program,
    build: &'a Build,
    machine: Machine,
    is_shared: bool,
    /// Every image is ET_DYN: executables are position-independent,
    /// matching the Mach-O output, so a `.rela.dyn` R_*_RELATIVE entry
    /// fixes up every internal absolute pointer in static data.
    emit_dyn: bool,
    n_imports: usize,
    use_libc_exit: bool,
    c5_entry_offset: Option<u64>,
    text_align: u64,
    stub_len: u64,
    text_gap: u64,
    exports: Vec<ElfExport>,
    dynamic: DynTables,
    seg: Segments,
    tail: Tail<'a>,
    out: Vec<u8>,
    shdr_cursor: usize,
}

pub(super) fn write(
    program: &Program,
    build: &Build,
    machine: Machine,
) -> Result<Vec<u8>, C5Error> {
    let mut w = ElfImageWriter::new(program, build, machine)?;
    w.collect_exports()?;
    w.build_dynamic_tables();
    w.build_version_tables();
    w.layout_text_segment();
    w.layout_data_segments();
    w.build_dwarf()?;
    w.plan_section_table();
    w.build_static_symtab();
    w.layout_tail();
    w.emit_file_headers();
    w.emit_dynamic_sections()?;
    w.emit_code_and_rodata()?;
    w.emit_rw_segment()?;
    w.emit_tail();
    w.emit_dynamic_headers();
    w.emit_segment_headers();
    w.emit_tail_headers();
    w.patch_fixups()?;
    Ok(w.out)
}

impl<'a> ElfImageWriter<'a> {
    fn new(program: &'a Program, build: &'a Build, machine: Machine) -> Result<Self, C5Error> {
        let is_shared = build.output_kind == super::OutputKind::SharedLibrary;
        // Both backends lower `_Thread_local` access with the local-exec
        // model, whose TP-relative offsets are valid only in the
        // executable's static TLS block. TODO: the general-dynamic model
        // for shared-library output.
        if is_shared && !build.tls_data.is_empty() {
            return Err(C5Error::Compile(crate::c5::error::fmt_link_diag(
                Code::OBJECT_FORMAT,
                "_Thread_local data is not supported in ELF shared-library output: \
                 only the executable-model (local-exec) TLS sequence is implemented",
            )));
        }
        // The libc-exit tail is picked when any libc `exit` import is in
        // scope (glibc's `exit` flushes stdio); otherwise the stub exits
        // through `sys_exit_group` and pulls no libc in.
        let use_libc_exit = build.imports.imports.iter().any(|i| i.local_name == "exit");
        let c5_entry_offset = if is_shared {
            None
        } else {
            symbol_text_offset(build, "__c5_entry")
        };
        let stub_body_len = if is_shared {
            0
        } else if c5_entry_offset.is_some() {
            entry_adapter_len(machine)
        } else {
            start_stub_len(machine, use_libc_exit)
        };
        let text_align = build.text_align.max(16) as u64;
        let stub_len = round_up(stub_body_len, text_align);
        Ok(ElfImageWriter {
            program,
            build,
            machine,
            is_shared,
            emit_dyn: true,
            n_imports: build.imports.imports.len(),
            use_libc_exit,
            c5_entry_offset,
            text_align,
            stub_len,
            text_gap: stub_len - stub_body_len,
            exports: Vec::new(),
            dynamic: DynTables::default(),
            seg: Segments::default(),
            tail: Tail::default(),
            out: Vec::new(),
            shdr_cursor: 0,
        })
    }

    fn internal(msg: String) -> C5Error {
        C5Error::Compile(crate::c5::error::fmt_internal_diag(Code::INTERNAL, &msg))
    }

    /// Runtime address of a file offset in a loaded segment.
    fn va(&self, off: u64) -> u64 {
        TEXT_VMADDR_BASE + off
    }

    /// Runtime address of `build.text[0]`.
    fn text_vmaddr(&self) -> u64 {
        self.va(self.seg.code_off) + self.stub_len
    }

    /// The defined `.dynsym` entries.
    fn collect_exports(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let mut exports: Vec<ElfExport> = build
            .dynamic_exports
            .iter()
            .map(|d| ElfExport {
                name: d.name.clone(),
                section: d.section,
                offset: d.offset,
                size: d.size,
                is_object: d.is_object,
                weak: d.weak,
            })
            .collect();
        let exported_names: alloc::collections::BTreeSet<String> =
            exports.iter().map(|e| e.name.clone()).collect();
        let text_bounds = text_boundaries(build);
        for exp in &build.exports {
            if exported_names.contains(exp.name.as_str()) {
                continue;
            }
            let native_off = build
                .pc_to_native
                .get(exp.ent_pc)
                .copied()
                .unwrap_or(usize::MAX);
            if native_off == usize::MAX {
                return Err(Self::internal(format!(
                    "ELF: exported function `{}` (bc PC {}) doesn't \
                 align with any native instruction",
                    exp.name, exp.ent_pc
                )));
            }
            exports.push(ElfExport {
                name: exp.name.clone(),
                section: super::DynamicExportSection::Text,
                offset: native_off as u64,
                size: text_body_len(&text_bounds, native_off as u64),
                is_object: false,
                weak: false,
            });
        }
        self.exports = exports;
        Ok(())
    }

    /// `.dynstr`, the placeholder `.dynsym` (the byte count is what the
    /// layout needs; addresses and section indices are filled in at
    /// emission) and `.hash`, which covers every `.dynsym` entry in table
    /// order: imports, then exports, then the copy-relocation targets, or
    /// `dlsym` and the loader's COPY lookup miss the names past the
    /// imports.
    fn build_dynamic_tables(&mut self) {
        let build = self.build;
        let export_names: Vec<&str> = self.exports.iter().map(|e| e.name.as_str()).collect();
        let (dynstr, name_offsets, lib_strtab_offsets, export_name_offsets, copy_name_offsets) =
            build_dynstr(&build.imports, &export_names, &build.copy_relocs);
        let import_is_object: Vec<bool> =
            build.imports.imports.iter().map(|i| i.is_object).collect();
        let copy_sizes: Vec<u64> = build.copy_relocs.iter().map(|cr| cr.size).collect();
        let copy_is_bss: Vec<bool> = build.copy_relocs.iter().map(|cr| cr.is_bss).collect();
        let copy_addrs_placeholder: Vec<u64> = vec![0; build.copy_relocs.len()];
        let exports_placeholder: Vec<DynsymExport> = export_name_offsets
            .iter()
            .map(|&name_off| DynsymExport {
                name_off,
                addr: 0,
                size: 0,
                st_info: 0,
                shndx: 0,
            })
            .collect();
        let dynsym = build_dynsym(
            &name_offsets,
            &import_is_object,
            &exports_placeholder,
            &DynsymCopyTargets {
                name_offsets: &copy_name_offsets,
                addrs: &copy_addrs_placeholder,
                sizes: &copy_sizes,
                is_bss: &copy_is_bss,
                data_shndx: 0,
                bss_shndx: 0,
            },
        );
        let mut hash_name_offsets: Vec<u32> = Vec::with_capacity(
            name_offsets.len() + export_name_offsets.len() + copy_name_offsets.len(),
        );
        hash_name_offsets.extend_from_slice(&name_offsets);
        hash_name_offsets.extend_from_slice(&export_name_offsets);
        hash_name_offsets.extend_from_slice(&copy_name_offsets);
        let hash = build_hash(&hash_name_offsets, &dynstr);
        self.dynamic = DynTables {
            dynstr,
            name_offsets,
            lib_strtab_offsets,
            export_name_offsets,
            copy_name_offsets,
            import_is_object,
            copy_sizes,
            copy_is_bss,
            dynsym,
            hash,
            ..DynTables::default()
        };
    }

    /// GNU symbol-version requirements.
    fn build_version_tables(&mut self) {
        let build = self.build;
        let dynamic = &mut self.dynamic;
        let import_version_reqs = resolve_import_version_reqs(&build.imports, self.machine);
        let mut import_versym: Vec<u16> = alloc::vec![VER_NDX_GLOBAL; self.n_imports];
        let mut verneed_groups: Vec<VerneedGroup> = Vec::new();
        let mut version_str_off: alloc::collections::BTreeMap<String, u32> =
            alloc::collections::BTreeMap::new();
        let mut next_ver_index: u16 = VER_NDX_FIRST;
        for (i, req) in import_version_reqs.iter().enumerate() {
            let Some((soname, version)) = req else {
                continue;
            };
            let Some(dyl_idx) = build.imports.dylibs.iter().position(|d| &d.path == soname) else {
                continue;
            };
            let Some(&soname_off) = dynamic.lib_strtab_offsets.get(dyl_idx) else {
                continue;
            };
            let dynstr = &mut dynamic.dynstr;
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
        // Re-pad `.dynstr` so the sections laid out from its length stay
        // congruent with their claimed alignment.
        while !dynamic.dynstr.len().is_multiple_of(8) {
            dynamic.dynstr.push(0);
        }
        let has_versions = !verneed_groups.is_empty();
        dynamic.text_shndx = SectionPlan::prefix(has_versions).index_of(Sec::Text);
        if has_versions {
            let total_dynsym = 1
                + dynamic.name_offsets.len()
                + dynamic.export_name_offsets.len()
                + dynamic.copy_name_offsets.len();
            let mut versym: Vec<u8> = Vec::with_capacity(total_dynsym * 2);
            versym.extend_from_slice(&0u16.to_le_bytes());
            for v in &import_versym {
                versym.extend_from_slice(&v.to_le_bytes());
            }
            for _ in 0..(total_dynsym - 1 - self.n_imports) {
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
            dynamic.gnu_version = versym;
            dynamic.gnu_version_r = verneed;
        }
        dynamic.import_versym = import_versym;
        dynamic.verneed_groups = verneed_groups;
        dynamic.has_versions = has_versions;
        let mut interp = interp_path(self.machine).as_bytes().to_vec();
        interp.push(0);
        while !interp.len().is_multiple_of(8) {
            interp.push(0);
        }
        dynamic.interp = interp;
    }

    /// The r-x segment: header, program headers, `.interp`, `.dynsym`,
    /// `.dynstr`, `.hash`, the version sections when any import carries a
    /// requirement, `.rela.dyn`, then the code blob (`_start` stub,
    /// alignment pad, `build.text`) at the alignment its input sections
    /// claim.
    fn layout_text_segment(&mut self) {
        let build = self.build;
        let machine = self.machine;
        let dynamic = &self.dynamic;
        let seg = &mut self.seg;
        seg.has_tls = !build.tls_data.is_empty();
        seg.ro_len = build.data_ro_len.min(build.data.len()) as u64;
        seg.relro_total = build
            .data_relro_len
            .clamp(build.data_ro_len, build.data.len()) as u64;
        seg.relro_size = seg.relro_total - seg.ro_len;
        seg.jt_len = build.rodata.bytes.len() as u64;
        seg.jt_off = if seg.jt_len > 0 {
            round_up(seg.ro_len, 8)
        } else {
            seg.ro_len
        };
        seg.ro_total = seg.jt_off + seg.jt_len;
        seg.has_rodata = seg.ro_total > 0;
        seg.n_program_headers = N_BASE_PROGRAM_HEADERS
            + if seg.has_tls { 1 } else { 0 }
            + if seg.has_rodata { 1 } else { 0 };
        seg.phoff = ELF_HEADER_SIZE;
        seg.phsize = seg.n_program_headers * PROGRAM_HEADER_SIZE;
        seg.interp_off = seg.phoff + seg.phsize;
        seg.dynsym_off = seg.interp_off + dynamic.interp.len() as u64;
        seg.dynstr_off = seg.dynsym_off + dynamic.dynsym.len() as u64;
        seg.hash_off = seg.dynstr_off + dynamic.dynstr.len() as u64;
        let after_hash = seg.hash_off + dynamic.hash.len() as u64;
        seg.gnu_version_off = after_hash;
        seg.gnu_version_r_off = if dynamic.has_versions {
            round_up(seg.gnu_version_off + dynamic.gnu_version.len() as u64, 8)
        } else {
            after_hash
        };
        seg.rela_off = if dynamic.has_versions {
            round_up(
                seg.gnu_version_r_off + dynamic.gnu_version_r.len() as u64,
                8,
            )
        } else {
            after_hash
        };
        // A shared object turns each internal absolute pointer in static
        // data into an R_*_RELATIVE relocation so it tracks the runtime
        // load base.
        let n_relative = if self.emit_dyn {
            build.data_relocs.len()
                + build.code_relocs.len()
                + build.label_relocs.len()
                + build.tls_data_relocs.len()
                + build.tls_code_relocs.len()
        } else {
            0
        };
        seg.rela_size =
            (self.n_imports as u64 + n_relative as u64 + build.copy_relocs.len() as u64)
                * ELF64_RELA_SIZE;
        seg.code_off = round_up(seg.rela_off + seg.rela_size, self.text_align);
        let mut code: Vec<u8> = Vec::with_capacity(self.stub_len as usize + build.text.len());
        seg.exit_adrp_offset = if self.is_shared {
            None
        } else if let Some(entry_off) = self.c5_entry_offset {
            emit_entry_adapter(
                machine,
                build.abi,
                &mut code,
                entry_off + self.text_gap,
                seg.code_off,
            );
            None
        } else {
            emit_start_stub(
                machine,
                build.abi,
                &mut code,
                build.entry_offset as u64 + self.text_gap,
                self.use_libc_exit,
            )
        };
        pad_with_traps(machine, &mut code, self.stub_len as usize);
        code.extend_from_slice(&build.text);
        seg.segment1_filesize = seg.code_off + code.len() as u64;
        seg.code = code;
        seg.align = seg_align(machine);
        seg.segment1_end = round_up(seg.segment1_filesize, seg.align);
    }

    /// The read-only load (`build.data[..data_ro_len]`, which holds no
    /// relocated slot, plus the switch tables at an 8-aligned tail: its own
    /// segment keeps it non-executable as well as non-writable), then the
    /// rw segment: `.dynamic`, `.got`, the relro region under
    /// `PT_GNU_RELRO`, `.data` at its base alignment, `.tdata`, and the
    /// zero-fill `.tbss` and `.bss` tail the loader reserves through
    /// `p_memsz > p_filesz`.
    fn layout_data_segments(&mut self) {
        let build = self.build;
        let seg = &mut self.seg;
        seg.rodata_off = seg.segment1_end;
        seg.rodata_end = if seg.ro_total > 0 {
            round_up(seg.rodata_off + seg.ro_total, seg.align)
        } else {
            seg.rodata_off
        };
        seg.segment2_off = seg.rodata_end;
        seg.dynamic_off = seg.segment2_off;
        let version_dyn_tags: u64 = if self.dynamic.has_versions { 3 } else { 0 };
        let init_fini_dyn_tags: u64 = 2
            * (build.init_fini_arrays.init.is_some() as u64
                + build.init_fini_arrays.fini.is_some() as u64);
        seg.dynamic_size =
            (build.imports.dylibs.len() as u64 + 11 + version_dyn_tags + init_fini_dyn_tags)
                * ELF64_DYN_SIZE;
        seg.got_off = seg.dynamic_off + seg.dynamic_size;
        seg.got_size = (self.n_imports as u64) * 8;
        seg.data_align = crate::c5::layout::data_image_align(build.data_align) as u64;
        seg.relro_off = if seg.relro_size > 0 {
            round_up(seg.got_off + seg.got_size, seg.data_align)
        } else {
            seg.got_off + seg.got_size
        };
        let relro_end_align = if seg.relro_size > 0 {
            seg.align
        } else {
            RELRO_EMPTY_END_ALIGN
        };
        seg.relro_end = round_up(seg.relro_off + seg.relro_size, relro_end_align);
        seg.data_off = round_up(seg.relro_end, seg.data_align);
        seg.data_size = build.data.len() as u64 - seg.relro_total;
        // An object wider than the page needs the RW segment's p_align
        // raised to it: the loader aligns the load bias down to the maximum
        // PT_LOAD p_align. TEXT_VMADDR_BASE is a multiple of every
        // alignment up to itself, so the congruence holds.
        seg.rw_seg_align = seg.align.max(seg.data_align.next_power_of_two());
        seg.tdata_off = if seg.has_tls {
            round_up(seg.data_off + seg.data_size, TLS_SEGMENT_ALIGN)
        } else {
            seg.data_off + seg.data_size
        };
        seg.tdata_size = build.tls_init_size as u64;
        seg.tbss_size = build.tls_data.len() as u64 - seg.tdata_size;
        seg.segment2_filesize = seg.tdata_off + seg.tdata_size - seg.segment2_off;
        seg.bss_vmaddr =
            TEXT_VMADDR_BASE + seg.segment2_off + seg.segment2_filesize + seg.tbss_size;
        seg.file_data_len = build.data.len() as u64;
        seg.segment2_memsize = seg.segment2_filesize + seg.tbss_size + build.bss_size as u64;
        // The DWARF / section-header tail past here carries no PT_LOAD, so
        // it needs only the file alignment, not the 64K one that would pad
        // every aarch64 binary with a second hole.
        seg.segment2_end = round_up(seg.segment2_off + seg.segment2_filesize, FILE_TAIL_ALIGN);
    }

    /// The data stream's regions at their runtime addresses: the read-only
    /// prefix, the relro region, `.data`, `.bss`.
    fn data_regions(&self) -> [DataRegion; 4] {
        let seg = &self.seg;
        let open = |start, base| DataRegion {
            start,
            base,
            len: u64::MAX,
        };
        [
            open(0, self.va(seg.rodata_off)),
            open(seg.ro_len, self.va(seg.relro_off)),
            open(seg.relro_total, self.va(seg.data_off)),
            open(seg.file_data_len, seg.bss_vmaddr),
        ]
    }

    fn data_off_to_vaddr(&self, off: u64) -> u64 {
        data_region_addr(&self.data_regions(), off)
    }

    /// The section a data-stream byte falls in.
    fn data_slot(&self, off: u64) -> Sec {
        let seg = &self.seg;
        if off < seg.ro_len {
            Sec::RoData
        } else if off < seg.relro_total {
            Sec::RelRo
        } else if off < seg.file_data_len {
            Sec::Data
        } else {
            Sec::Bss
        }
    }

    /// The DWARF sections.
    fn build_dwarf(&mut self) -> Result<(), C5Error> {
        let (program, build) = (self.program, self.build);
        let text_vmaddr = self.text_vmaddr();
        let elf_target = match self.machine {
            Machine::Aarch64 => super::Target::LinuxAarch64,
            Machine::X86_64 => super::Target::LinuxX64,
        };
        let emit_dwarf = build.debug_info;
        let start_stub_range = if self.stub_len > 0 {
            Some((
                self.va(self.seg.code_off),
                self.va(self.seg.code_off) + self.stub_len,
            ))
        } else {
            None
        };
        let dwarf = image::image_dwarf(
            program,
            build,
            elf_target,
            text_vmaddr,
            start_stub_range,
            Some(&|off| self.data_off_to_vaddr(off)),
        )?;
        let tail = &mut self.tail;
        tail.emit_dwarf = emit_dwarf;
        tail.start_stub_range = start_stub_range;
        tail.dwarf_off = self.seg.segment2_end;
        tail.dwarf_abbrev_off = tail.dwarf_off + dwarf.debug_info.len() as u64;
        tail.dwarf_line_off = tail.dwarf_abbrev_off + dwarf.debug_abbrev.len() as u64;
        tail.dwarf_str_off = tail.dwarf_line_off + dwarf.debug_line.len() as u64;
        tail.dwarf_frame_off = tail.dwarf_str_off + dwarf.debug_str.len() as u64;
        tail.dwarf = dwarf;
        Ok(())
    }

    /// Which optional sections the image carries, where each named section
    /// lands (the family whose region holds its bytes; a bss name's offset
    /// is already relative to the zero-fill region), the plan that numbers
    /// every header, and the section symbols the `--emit-relocs` payloads
    /// reference.
    fn plan_section_table(&mut self) {
        let build = self.build;
        let seg = &self.seg;
        let tail = &mut self.tail;
        tail.er_text = build
            .emitted_relocs
            .iter()
            .filter(|r| matches!(r.site, crate::c5::codegen::EmitStream::Text))
            .collect();
        tail.er_data = build
            .emitted_relocs
            .iter()
            .filter(|r| matches!(r.site, crate::c5::codegen::EmitStream::Data))
            .collect();
        let has_rela_text = !tail.er_text.is_empty();
        let has_rela_data = !tail.er_data.is_empty();
        tail.emit_symtab =
            !build.plt_trampoline_offsets.is_empty() || has_rela_text || has_rela_data;
        tail.has_relro = seg.relro_size > 0;
        tail.has_data = seg.data_size > 0;
        tail.has_tdata = seg.has_tls && seg.tdata_size > 0;
        tail.has_tbss = seg.has_tls && seg.tbss_size > 0;
        tail.has_bss = build.bss_size > 0;
        let mut named_out: Vec<NamedOut> = build
            .named_sections
            .iter()
            .map(|n| {
                let (slot, addr, off) = if n.bss {
                    let a = seg.bss_vmaddr + n.offset;
                    (Sec::Bss, a, a - TEXT_VMADDR_BASE)
                } else if n.offset < seg.ro_len {
                    (
                        Sec::RoData,
                        TEXT_VMADDR_BASE + seg.rodata_off + n.offset,
                        seg.rodata_off + n.offset,
                    )
                } else if n.offset < seg.relro_total {
                    let d = n.offset - seg.ro_len;
                    (
                        Sec::RelRo,
                        TEXT_VMADDR_BASE + seg.relro_off + d,
                        seg.relro_off + d,
                    )
                } else {
                    let d = n.offset - seg.relro_total;
                    (
                        Sec::Data,
                        TEXT_VMADDR_BASE + seg.data_off + d,
                        seg.data_off + d,
                    )
                };
                NamedOut {
                    name: &n.name,
                    slot,
                    addr,
                    off,
                    size: n.size,
                    align: n.align.max(1),
                    bss: n.bss,
                    write: n.write,
                }
            })
            .collect();
        named_out.sort_by_key(|n| n.addr);
        let named_in = |slot: Sec| named_out.iter().filter(move |n| n.slot == slot).count();
        tail.plan = SectionPlan::new(SectionsPresent {
            versions: self.dynamic.has_versions,
            rodata: seg.has_rodata,
            tdata: tail.has_tdata,
            relro: tail.has_relro,
            data: tail.has_data,
            tbss: tail.has_tbss,
            bss: tail.has_bss,
            dwarf: if tail.emit_dwarf { 5 } else { 0 },
            rela_text: has_rela_text,
            rela_data: has_rela_data,
            plt_symtab: tail.emit_symtab,
            named_rodata: named_in(Sec::RoData),
            named_relro: named_in(Sec::RelRo),
            named_data: named_in(Sec::Data),
            named_bss: named_in(Sec::Bss),
        });
        tail.named_out = named_out;
        tail.sec_syms = if has_rela_text || has_rela_data {
            let mut v = alloc::vec![(Sec::Text, TEXT_VMADDR_BASE + seg.code_off)];
            if seg.has_rodata {
                v.push((Sec::RoData, TEXT_VMADDR_BASE + seg.rodata_off));
            }
            if tail.has_relro {
                v.push((Sec::RelRo, TEXT_VMADDR_BASE + seg.relro_off));
            }
            if tail.has_data {
                v.push((Sec::Data, TEXT_VMADDR_BASE + seg.data_off));
            }
            if tail.has_bss {
                v.push((Sec::Bss, seg.bss_vmaddr));
            }
            v
        } else {
            Vec::new()
        };
    }

    fn named_in(&self, slot: Sec) -> impl Iterator<Item = &NamedOut<'a>> {
        self.tail.named_out.iter().filter(move |n| n.slot == slot)
    }

    /// The family header stops where its first named section begins; the
    /// alignment padding behind the last one is a gap, as between any two
    /// sections.
    fn family_size(&self, slot: Sec, full: u64, base: u64) -> u64 {
        match self.named_in(slot).map(|n| n.addr).min() {
            Some(first) => first - base,
            None => full,
        }
    }

    /// Symbol index of a target stream's section symbol.
    fn sec_sym_idx(&self, sec: Sec) -> u64 {
        1 + self
            .tail
            .sec_syms
            .iter()
            .position(|&(s, _)| s == sec)
            .unwrap() as u64
    }

    /// Section and section-relative offset of a data-stream byte: read-only
    /// prefix, relro, `.data`, then the zero-fill region.
    fn map_data_off(&self, d: u64) -> (Sec, u64) {
        let seg = &self.seg;
        match self.data_slot(d) {
            Sec::RoData => (Sec::RoData, d),
            Sec::RelRo => (Sec::RelRo, d - seg.ro_len),
            Sec::Data => (Sec::Data, d - seg.relro_total),
            _ => (Sec::Bss, d - seg.file_data_len),
        }
    }

    /// An `--emit-relocs` table: each resolved relocation re-emitted
    /// against the section symbol of its target stream, with the addend
    /// rebased into that section.
    fn build_rela(&self, list: &[&crate::c5::codegen::EmittedFinalReloc]) -> Vec<u8> {
        use crate::c5::codegen::EmitStream;
        let mut b = Vec::with_capacity(list.len() * ELF64_RELA_SIZE as usize);
        for r in list {
            let site_vaddr = match r.site {
                EmitStream::Text => self.text_vmaddr() + r.site_offset,
                EmitStream::Data => {
                    let (sec, off) = self.map_data_off(r.site_offset);
                    let base = self
                        .tail
                        .sec_syms
                        .iter()
                        .find(|&&(s, _)| s == sec)
                        .map(|&(_, v)| v)
                        .unwrap_or(0);
                    base + off
                }
            };
            let (sym, addend) = match r.target {
                EmitStream::Text => (self.sec_sym_idx(Sec::Text), self.stub_len as i64 + r.addend),
                EmitStream::Data => {
                    let (sec, off) = self.map_data_off(r.addend as u64);
                    (self.sec_sym_idx(sec), off as i64)
                }
            };
            b.extend_from_slice(&site_vaddr.to_le_bytes());
            b.extend_from_slice(&((sym << 32) | r.rtype as u64).to_le_bytes());
            b.extend_from_slice(&addend.to_le_bytes());
        }
        b
    }

    /// The `--emit-relocs` tables and the static `.symtab` + `.strtab`: one
    /// local `STT_FUNC` per PLT trampoline (so a debugger's `b malloc`
    /// resolves to the trampoline) and per defined function, the section
    /// symbols the relocation tables reference right after the sentinel,
    /// and `_GLOBAL_OFFSET_TABLE_` as bfd defines it.
    fn build_static_symtab(&mut self) {
        let build = self.build;
        let rela_text = self.build_rela(&self.tail.er_text);
        let rela_data = self.build_rela(&self.tail.er_data);
        let trampoline_size: u64 = match self.machine {
            Machine::Aarch64 => 12, // adrp + ldr + br
            Machine::X86_64 => 6,   // jmp qword ptr [rip+disp32]
        };
        let text_vmaddr = self.text_vmaddr();
        let text_shndx = self.dynamic.text_shndx;
        let tail = &mut self.tail;
        let (mut symtab, mut strtab) = if !build.plt_trampoline_offsets.is_empty() {
            build_plt_symtab(build, text_vmaddr, trampoline_size, text_shndx)
        } else if tail.emit_symtab {
            let mut st = Vec::with_capacity(ELF64_SYM_SIZE as usize);
            write_struct(
                &mut st,
                &Elf64Sym {
                    st_name: 0,
                    st_info: 0,
                    st_other: 0,
                    st_shndx: 0,
                    st_value: 0,
                    st_size: 0,
                },
            );
            (st, alloc::vec![0u8])
        } else {
            (Vec::new(), alloc::vec![0u8])
        };
        if tail.emit_symtab && !tail.sec_syms.is_empty() {
            let mut prefix: Vec<u8> =
                Vec::with_capacity(tail.sec_syms.len() * ELF64_SYM_SIZE as usize);
            for &(sec, vaddr) in &tail.sec_syms {
                write_struct(
                    &mut prefix,
                    &Elf64Sym {
                        st_name: 0,
                        st_info: STT_SECTION,
                        st_other: 0,
                        st_shndx: tail.plan.index_of(sec),
                        st_value: vaddr,
                        st_size: 0,
                    },
                );
            }
            let at = ELF64_SYM_SIZE as usize;
            symtab.splice(at..at, prefix);
        }
        if !symtab.is_empty() && self.seg.got_size > 0 {
            let st_name = strtab.len() as u32;
            strtab.extend_from_slice(b"_GLOBAL_OFFSET_TABLE_\0");
            write_struct(
                &mut symtab,
                &Elf64Sym {
                    st_name,
                    st_info: STT_OBJECT,
                    st_other: 0,
                    st_shndx: tail.plan.index_of(Sec::Got),
                    st_value: TEXT_VMADDR_BASE + self.seg.got_off,
                    st_size: 0,
                },
            );
        }
        tail.rela_text = rela_text;
        tail.rela_data = rela_data;
        tail.symtab = symtab;
        tail.strtab = strtab;
    }

    /// File offsets of everything past the DWARF, and `.shstrtab`.
    fn layout_tail(&mut self) {
        let tail = &mut self.tail;
        let post_dwarf_off = tail.dwarf_frame_off + tail.dwarf.debug_frame.len() as u64;
        let has_rela = !tail.rela_text.is_empty() || !tail.rela_data.is_empty();
        let post_rela_off = if has_rela {
            tail.rela_text_off = round_up(post_dwarf_off, 8);
            tail.rela_data_off = tail.rela_text_off + tail.rela_text.len() as u64;
            tail.rela_data_off + tail.rela_data.len() as u64
        } else {
            tail.rela_text_off = post_dwarf_off;
            tail.rela_data_off = post_dwarf_off;
            post_dwarf_off
        };
        // The producer fingerprint in gcc's ident form, past the loaded
        // image so `.text` stays instruction-pure.
        tail.comment = super::provenance_comment();
        tail.comment_off = post_rela_off;
        let post_comment_off = tail.comment_off + tail.comment.len() as u64;
        if tail.emit_symtab {
            tail.symtab_off = round_up(post_comment_off, 8);
            tail.strtab_off = tail.symtab_off + tail.symtab.len() as u64;
            tail.shstrtab_off = tail.strtab_off + tail.strtab.len() as u64;
        } else {
            tail.symtab_off = post_comment_off;
            tail.strtab_off = post_comment_off;
            tail.shstrtab_off = post_comment_off;
        }
        let mut names: Vec<&'a str> = Vec::with_capacity(19);
        names.extend_from_slice(&[
            "",
            ".interp",
            ".dynsym",
            ".dynstr",
            ".hash",
            ".gnu.version",
            ".gnu.version_r",
            ".rela.dyn",
            ".text",
            ".rodata",
            ".tdata",
            ".dynamic",
            ".got",
            ".data.rel.ro",
            ".data",
            ".tbss",
            ".bss",
            ".comment",
        ]);
        for n in &tail.named_out {
            names.push(n.name);
        }
        if tail.emit_dwarf {
            names.extend_from_slice(&[
                ".debug_info",
                ".debug_abbrev",
                ".debug_line",
                ".debug_str",
                ".debug_frame",
            ]);
        }
        if !tail.rela_text.is_empty() {
            names.push(".rela.text");
        }
        if !tail.rela_data.is_empty() {
            names.push(".rela.data");
        }
        tail.symtab_name_idx = if tail.emit_symtab {
            names.push(".symtab");
            names.push(".strtab");
            Some(names.len() - 2)
        } else {
            None
        };
        tail.shstrtab_name_idx = names.len();
        names.push(".shstrtab");
        let mut shstrtab: Vec<u8> = Vec::new();
        let mut offsets: Vec<u32> = Vec::with_capacity(names.len());
        for s in &names {
            offsets.push(shstrtab.len() as u32);
            shstrtab.extend_from_slice(s.as_bytes());
            shstrtab.push(0);
        }
        tail.shdr_off = round_up(tail.shstrtab_off + shstrtab.len() as u64, 8);
        tail.total_filesize = tail.shdr_off + tail.plan.len() as u64 * ELF64_SHDR_SIZE;
        tail.shstrtab_names = names;
        tail.shstrtab = shstrtab;
        tail.shstrtab_offsets = offsets;
    }

    /// A section name's `.shstrtab` offset, by catalog position.
    fn name_off(&self, name: &str) -> u32 {
        let i = self
            .tail
            .shstrtab_names
            .iter()
            .position(|&s| s == name)
            .expect("section name in catalog");
        self.tail.shstrtab_offsets[i]
    }

    /// Header index for a data-stream byte: the named section holding it,
    /// else the family whose region it falls in.
    fn data_addr_shndx(&self, addr: u64, off: u64) -> u16 {
        let slot = self.data_slot(off);
        let base = self.tail.plan.index_of(slot);
        match self
            .named_in(slot)
            .position(|n| addr >= n.addr && addr < n.addr + n.size)
        {
            Some(k) => base + 1 + k as u16,
            None => base,
        }
    }

    fn pad_to(&mut self, off: u64) {
        while (self.out.len() as u64) < off {
            self.out.push(0);
        }
    }

    /// The ELF header and the program headers: `PT_PHDR`, `PT_INTERP`, the
    /// r-x load, the read-only load when the data image has a read-only
    /// prefix, the rw load, `PT_DYNAMIC`, `PT_TLS` when the program has
    /// `_Thread_local` globals, `PT_GNU_STACK` and `PT_GNU_RELRO` over
    /// `.dynamic`, `.got` and the relro region.
    fn emit_file_headers(&mut self) {
        let seg = &self.seg;
        let tail = &self.tail;
        let mut out: Vec<u8> = Vec::with_capacity(tail.total_filesize as usize);
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
                e_type: if self.emit_dyn { ET_DYN } else { ET_EXEC },
                e_machine: e_machine(self.machine),
                e_version: EV_CURRENT as u32,
                e_entry: if self.is_shared {
                    0
                } else {
                    self.va(seg.code_off)
                },
                e_phoff: seg.phoff,
                e_shoff: tail.shdr_off,
                e_flags: 0,
                e_ehsize: ELF_HEADER_SIZE as u16,
                e_phentsize: PROGRAM_HEADER_SIZE as u16,
                e_phnum: seg.n_program_headers as u16,
                e_shentsize: ELF64_SHDR_SIZE as u16,
                e_shnum: tail.plan.len() as u16,
                e_shstrndx: tail.plan.index_of(Sec::Shstrtab),
            },
        );
        debug_assert_eq!(out.len() as u64, ELF_HEADER_SIZE);
        write_phdr(
            &mut out,
            PT_PHDR,
            PF_R,
            seg.phoff,
            self.va(seg.phoff),
            seg.phsize,
            seg.phsize,
            8,
        );
        let interp_len = interp_path(self.machine).len() as u64 + 1;
        write_phdr(
            &mut out,
            PT_INTERP,
            PF_R,
            seg.interp_off,
            self.va(seg.interp_off),
            interp_len,
            interp_len,
            1,
        );
        write_phdr(
            &mut out,
            PT_LOAD,
            PF_R | PF_X,
            0,
            TEXT_VMADDR_BASE,
            seg.segment1_filesize,
            seg.segment1_filesize,
            seg.align,
        );
        if seg.has_rodata {
            write_phdr(
                &mut out,
                PT_LOAD,
                PF_R,
                seg.rodata_off,
                self.va(seg.rodata_off),
                seg.ro_total,
                seg.ro_total,
                seg.align,
            );
        }
        write_phdr(
            &mut out,
            PT_LOAD,
            PF_R | PF_W,
            seg.segment2_off,
            self.va(seg.segment2_off),
            seg.segment2_filesize,
            seg.segment2_memsize,
            seg.rw_seg_align,
        );
        write_phdr(
            &mut out,
            PT_DYNAMIC,
            PF_R | PF_W,
            seg.dynamic_off,
            self.va(seg.dynamic_off),
            seg.dynamic_size,
            seg.dynamic_size,
            8,
        );
        if seg.has_tls {
            write_phdr(
                &mut out,
                PT_TLS,
                PF_R,
                seg.tdata_off,
                self.va(seg.tdata_off),
                seg.tdata_size,
                seg.tdata_size + seg.tbss_size,
                TLS_SEGMENT_ALIGN,
            );
        }
        write_phdr(&mut out, PT_GNU_STACK, PF_R | PF_W, 0, 0, 0, 0, 16);
        write_phdr(
            &mut out,
            PT_GNU_RELRO,
            PF_R,
            seg.segment2_off,
            self.va(seg.segment2_off),
            seg.relro_end - seg.segment2_off,
            seg.relro_end - seg.segment2_off,
            1,
        );
        debug_assert_eq!(out.len() as u64, seg.phoff + seg.phsize);
        self.out = out;
    }

    /// `.interp`, the final `.dynsym` (each export's `st_value` is its
    /// runtime address now that the layout is fixed, the placeholder having
    /// had the same byte count), `.dynstr`, `.hash`, the version sections,
    /// and `.rela.dyn`: `GLOB_DAT` for the imports, one `R_*_RELATIVE` per
    /// internal absolute pointer in static data and in the TLS template
    /// (the slot keeps its baked link-time value; the loader overwrites it
    /// with `load_bias + r_addend`), and the `COPY` relocations that bind
    /// each data import's host object to the local slot so the program and
    /// libc share one storage cell.
    fn emit_dynamic_sections(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let machine = self.machine;
        let (seg, dynamic, tail) = (&self.seg, &self.dynamic, &self.tail);
        let text_shndx = dynamic.text_shndx;
        let (data_shndx, bss_shndx) = (tail.plan.index_of(Sec::Data), tail.plan.index_of(Sec::Bss));
        let final_exports: Vec<DynsymExport> = self
            .exports
            .iter()
            .zip(dynamic.export_name_offsets.iter())
            .map(|(e, &name_off)| {
                let (addr, shndx) = match e.section {
                    super::DynamicExportSection::Text => {
                        (self.text_vmaddr() + e.offset, text_shndx)
                    }
                    super::DynamicExportSection::Data => {
                        let addr = self.data_off_to_vaddr(e.offset);
                        (addr, self.data_addr_shndx(addr, e.offset))
                    }
                };
                let binding = if e.weak { STB_WEAK } else { STB_GLOBAL };
                let st_type = if e.is_object { STT_OBJECT } else { STT_FUNC };
                DynsymExport {
                    name_off,
                    addr,
                    size: e.size,
                    st_info: (binding << 4) | st_type,
                    shndx,
                }
            })
            .collect();
        let copy_addrs: Vec<u64> = build
            .copy_relocs
            .iter()
            .map(|cr| {
                if cr.is_bss {
                    seg.bss_vmaddr + cr.local_offset
                } else {
                    self.data_off_to_vaddr(cr.local_offset)
                }
            })
            .collect();
        let final_dynsym = build_dynsym(
            &dynamic.name_offsets,
            &dynamic.import_is_object,
            &final_exports,
            &DynsymCopyTargets {
                name_offsets: &dynamic.copy_name_offsets,
                addrs: &copy_addrs,
                sizes: &dynamic.copy_sizes,
                is_bss: &dynamic.copy_is_bss,
                data_shndx,
                bss_shndx,
            },
        );
        debug_assert_eq!(final_dynsym.len(), dynamic.dynsym.len());
        let mut rela = build_rela_dyn(self.va(seg.got_off), self.n_imports, machine);
        if self.emit_dyn {
            let r_type = r_relative(machine);
            let mut relative = |r_offset: u64, addend: u64| {
                write_struct(
                    &mut rela,
                    &Elf64Rela {
                        r_offset,
                        r_info: r_type,
                        r_addend: addend as i64,
                    },
                );
            };
            for r in &build.data_relocs {
                let addend = self
                    .data_off_to_vaddr(r.target_anchor)
                    .wrapping_add(r.target_offset.wrapping_sub(r.target_anchor));
                relative(self.data_off_to_vaddr(r.data_offset), addend);
            }
            for r in &build.code_relocs {
                let native_off = build
                    .pc_to_native
                    .get(r.target_ent_pc as usize)
                    .copied()
                    .unwrap_or(0);
                relative(
                    self.data_off_to_vaddr(r.data_offset),
                    self.text_vmaddr() + native_off as u64,
                );
            }
            for r in &build.label_relocs {
                relative(
                    self.data_off_to_vaddr(r.data_offset),
                    self.text_vmaddr() + r.text_offset,
                );
            }
            // Sited at the template's own address, so the loader relocates
            // the image bytes the per-thread copies are made from.
            let tdata_vmaddr = self.va(seg.tdata_off);
            for (off, absolute) in self.tls_reloc_sites()? {
                relative(tdata_vmaddr + off as u64, absolute);
            }
        }
        let r_copy: u64 = match machine {
            Machine::Aarch64 => R_AARCH64_COPY.into(),
            Machine::X86_64 => R_X86_64_COPY.into(),
        };
        let copy_dynsym_base = (1 + self.n_imports + self.exports.len()) as u64;
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
        debug_assert_eq!(rela.len() as u64, seg.rela_size);
        let out = &mut self.out;
        out.extend_from_slice(&dynamic.interp);
        debug_assert_eq!(out.len() as u64, seg.dynsym_off);
        out.extend_from_slice(&final_dynsym);
        debug_assert_eq!(out.len() as u64, seg.dynstr_off);
        out.extend_from_slice(&dynamic.dynstr);
        debug_assert_eq!(out.len() as u64, seg.hash_off);
        out.extend_from_slice(&dynamic.hash);
        if dynamic.has_versions {
            debug_assert_eq!(out.len() as u64, seg.gnu_version_off);
            out.extend_from_slice(&dynamic.gnu_version);
            out.resize(seg.gnu_version_r_off as usize, 0);
            out.extend_from_slice(&dynamic.gnu_version_r);
            out.resize(seg.rela_off as usize, 0);
        }
        debug_assert_eq!(out.len() as u64, seg.rela_off);
        out.extend_from_slice(&rela);
        self.pad_to(self.seg.code_off);
        debug_assert_eq!(self.out.len() as u64, self.seg.code_off);
        Ok(())
    }

    /// Address-constant initializers of `_Thread_local` objects, as
    /// `(offset within the TLS template, link-time absolute target)`.
    fn tls_reloc_sites(&self) -> Result<Vec<(usize, u64)>, C5Error> {
        image::tls_reloc_sites(
            "ELF",
            self.build,
            &|off| self.data_off_to_vaddr(off),
            self.text_vmaddr(),
        )
    }

    /// The code blob, then the read-only load: the data image's read-only
    /// prefix verbatim (no slot in it is relocated) and the switch-table
    /// blob, each table slot baked as `target - table_base`, which slides
    /// with the image and needs no `.rela.dyn` entry.
    fn emit_code_and_rodata(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let seg = &self.seg;
        let jt_vmaddr = self.va(seg.rodata_off) + seg.jt_off;
        let text_vmaddr = self.text_vmaddr();
        let out = &mut self.out;
        out.extend_from_slice(&seg.code);
        debug_assert_eq!(out.len() as u64, seg.segment1_filesize);
        out.resize(seg.segment1_end as usize, 0);
        debug_assert_eq!(out.len() as u64, seg.rodata_off);
        out.extend_from_slice(&build.data[..seg.ro_len as usize]);
        if seg.jt_len > 0 {
            if !build.rodata.abs64.is_empty() {
                return Err(Self::internal(String::from(
                    "ELF image: absolute table slots reached a final-image build",
                )));
            }
            out.resize((seg.rodata_off + seg.jt_off) as usize, 0);
            out.extend_from_slice(&build.rodata.bytes);
            let jt_start = (seg.rodata_off + seg.jt_off) as usize;
            image::patch_jump_table(
                "ELF",
                "table",
                &mut out[jt_start..],
                text_vmaddr,
                jt_vmaddr,
                &build.rodata.rel32,
            )?;
        }
        out.resize(seg.rodata_end as usize, 0);
        Ok(())
    }

    /// The rw segment: `.dynamic`, the zero-filled `.got` the loader fills
    /// through `.rela.dyn`, then the data image with every pointer
    /// initializer resolved to its link-time address (the matching
    /// `R_*_RELATIVE` entry slides it at load time) and every object-linked
    /// pc-relative slot holding `target - slot` at its width, split at the
    /// relro boundary; then the TLS template with its address constants
    /// resolved the same way.
    fn emit_rw_segment(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let seg = &self.seg;
        let dynamic = build_dynamic(
            &self.dynamic.lib_strtab_offsets,
            DynamicInfo {
                hash_vmaddr: self.va(seg.hash_off),
                strtab_vmaddr: self.va(seg.dynstr_off),
                symtab_vmaddr: self.va(seg.dynsym_off),
                rela_vmaddr: self.va(seg.rela_off),
                rela_size: seg.rela_size,
                strtab_size: self.dynamic.dynstr.len() as u64,
                versions: if self.dynamic.has_versions {
                    Some(VersionInfo {
                        versym_vmaddr: self.va(seg.gnu_version_off),
                        verneed_vmaddr: self.va(seg.gnu_version_r_off),
                        verneed_num: self.dynamic.verneed_groups.len() as u64,
                    })
                } else {
                    None
                },
                init_array: build
                    .init_fini_arrays
                    .init
                    .map(|(off, len)| (self.data_off_to_vaddr(off), len)),
                fini_array: build
                    .init_fini_arrays
                    .fini
                    .map(|(off, len)| (self.data_off_to_vaddr(off), len)),
            },
        );
        debug_assert_eq!(dynamic.len() as u64, seg.dynamic_size);
        let ro_len = seg.ro_len;
        let data =
            image::bake_data_relocs("ELF", ".data", build, ro_len, self.text_vmaddr(), &|off| {
                self.data_off_to_vaddr(off)
            })?;
        let tdata = image::bake_tls_template(
            "ELF",
            ".tdata",
            &build.tls_data[..build.tls_init_size],
            &self.tls_reloc_sites()?,
        )?;
        let out = &mut self.out;
        out.extend_from_slice(&dynamic);
        out.extend(vec![0u8; seg.got_size as usize]);
        out.resize(seg.relro_off as usize, 0);
        debug_assert_eq!(out.len() as u64, seg.relro_off);
        out.extend_from_slice(&data[..seg.relro_size as usize]);
        out.resize(seg.data_off as usize, 0);
        debug_assert_eq!(out.len() as u64, seg.data_off);
        out.extend_from_slice(&data[seg.relro_size as usize..]);
        out.resize(seg.tdata_off as usize, 0);
        debug_assert_eq!(out.len() as u64, seg.tdata_off);
        out.extend_from_slice(&tdata);
        out.resize(seg.segment2_end as usize, 0);
        debug_assert_eq!(out.len() as u64, self.tail.dwarf_off);
        Ok(())
    }

    /// The DWARF sections, the `--emit-relocs` tables, `.comment`, the
    /// static symbol table and `.shstrtab`, padded to the section header
    /// table.
    fn emit_tail(&mut self) {
        let tail = &self.tail;
        let out = &mut self.out;
        out.extend_from_slice(&tail.dwarf.debug_info);
        out.extend_from_slice(&tail.dwarf.debug_abbrev);
        out.extend_from_slice(&tail.dwarf.debug_line);
        out.extend_from_slice(&tail.dwarf.debug_str);
        out.extend_from_slice(&tail.dwarf.debug_frame);
        if !tail.rela_text.is_empty() || !tail.rela_data.is_empty() {
            out.resize(tail.rela_text_off as usize, 0);
            out.extend_from_slice(&tail.rela_text);
            debug_assert_eq!(out.len() as u64, tail.rela_data_off);
            out.extend_from_slice(&tail.rela_data);
        }
        debug_assert_eq!(out.len() as u64, tail.comment_off);
        out.extend_from_slice(&tail.comment);
        if tail.emit_symtab {
            out.resize(tail.symtab_off as usize, 0);
            debug_assert_eq!(out.len() as u64, tail.symtab_off);
            out.extend_from_slice(&tail.symtab);
            debug_assert_eq!(out.len() as u64, tail.strtab_off);
            out.extend_from_slice(&tail.strtab);
        }
        debug_assert_eq!(out.len() as u64, tail.shstrtab_off);
        out.extend_from_slice(&tail.shstrtab);
        out.resize(tail.shdr_off as usize, 0);
        debug_assert_eq!(out.len() as u64, tail.shdr_off);
    }

    /// Append one section header, checking it lands where the plan says.
    fn shdr(&mut self, kind: Sec, shdr: Elf64Shdr) {
        assert_eq!(
            self.tail.plan.at(self.shdr_cursor),
            kind,
            "section header {} emitted out of plan order",
            self.shdr_cursor
        );
        self.shdr_cursor += 1;
        write_struct(&mut self.out, &shdr);
    }

    /// The headers of `slot`'s named sections, which follow its family
    /// header.
    fn named_shdrs(&mut self, slot: Sec) {
        let named: Vec<Elf64Shdr> = self
            .named_in(slot)
            .map(|n| Elf64Shdr {
                sh_name: self.name_off(n.name),
                sh_type: if n.bss { SHT_NOBITS } else { SHT_PROGBITS },
                sh_flags: SHF_ALLOC | if n.write { SHF_WRITE } else { 0 },
                sh_addr: n.addr,
                sh_offset: n.off,
                sh_size: n.size,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: n.align,
                sh_entsize: 0,
            })
            .collect();
        for shdr in named {
            self.shdr(slot, shdr);
        }
    }

    /// The null sentinel and the dynamic-linking sections up to
    /// `.rela.dyn`.
    fn emit_dynamic_headers(&mut self) {
        let seg = &self.seg;
        let dynamic = &self.dynamic;
        let dynsym_shdr_idx: u32 = 2;
        let dynstr_shdr_idx: u32 = 3;
        let interp_len = interp_path(self.machine).len() as u64 + 1;
        let mut headers: Vec<(Sec, Elf64Shdr)> = alloc::vec![
            (
                Sec::Null,
                Elf64Shdr {
                    sh_name: self.name_off(""),
                    sh_type: SHT_NULL,
                    ..Default::default()
                },
            ),
            (
                Sec::Interp,
                Elf64Shdr {
                    sh_name: self.name_off(".interp"),
                    sh_type: SHT_PROGBITS,
                    sh_flags: SHF_ALLOC,
                    sh_addr: self.va(seg.interp_off),
                    sh_offset: seg.interp_off,
                    sh_size: interp_len,
                    sh_addralign: 1,
                    ..Default::default()
                },
            ),
            (
                Sec::Dynsym,
                Elf64Shdr {
                    sh_name: self.name_off(".dynsym"),
                    sh_type: SHT_DYNSYM,
                    sh_flags: SHF_ALLOC,
                    sh_addr: self.va(seg.dynsym_off),
                    sh_offset: seg.dynsym_off,
                    sh_size: dynamic.dynsym.len() as u64,
                    sh_link: dynstr_shdr_idx,
                    sh_info: 1,
                    sh_addralign: 8,
                    sh_entsize: ELF64_SYM_SIZE,
                },
            ),
            (
                Sec::Dynstr,
                Elf64Shdr {
                    sh_name: self.name_off(".dynstr"),
                    sh_type: SHT_STRTAB,
                    sh_flags: SHF_ALLOC,
                    sh_addr: self.va(seg.dynstr_off),
                    sh_offset: seg.dynstr_off,
                    sh_size: dynamic.dynstr.len() as u64,
                    sh_addralign: 1,
                    ..Default::default()
                },
            ),
            (
                Sec::Hash,
                Elf64Shdr {
                    sh_name: self.name_off(".hash"),
                    sh_type: SHT_HASH,
                    sh_flags: SHF_ALLOC,
                    sh_addr: self.va(seg.hash_off),
                    sh_offset: seg.hash_off,
                    sh_size: dynamic.hash.len() as u64,
                    sh_link: dynsym_shdr_idx,
                    sh_addralign: 8,
                    sh_entsize: 4,
                    ..Default::default()
                },
            ),
        ];
        if dynamic.has_versions {
            headers.push((
                Sec::GnuVersion,
                Elf64Shdr {
                    sh_name: self.name_off(".gnu.version"),
                    sh_type: SHT_GNU_VERSYM,
                    sh_flags: SHF_ALLOC,
                    sh_addr: self.va(seg.gnu_version_off),
                    sh_offset: seg.gnu_version_off,
                    sh_size: dynamic.gnu_version.len() as u64,
                    sh_link: dynsym_shdr_idx,
                    sh_addralign: 2,
                    sh_entsize: 2,
                    ..Default::default()
                },
            ));
            headers.push((
                Sec::GnuVersionR,
                Elf64Shdr {
                    sh_name: self.name_off(".gnu.version_r"),
                    sh_type: SHT_GNU_VERNEED,
                    sh_flags: SHF_ALLOC,
                    sh_addr: self.va(seg.gnu_version_r_off),
                    sh_offset: seg.gnu_version_r_off,
                    sh_size: dynamic.gnu_version_r.len() as u64,
                    sh_link: dynstr_shdr_idx,
                    sh_info: dynamic.verneed_groups.len() as u32,
                    sh_addralign: 8,
                    ..Default::default()
                },
            ));
        }
        headers.push((
            Sec::RelaDyn,
            Elf64Shdr {
                sh_name: self.name_off(".rela.dyn"),
                sh_type: SHT_RELA,
                sh_flags: SHF_ALLOC,
                sh_addr: self.va(seg.rela_off),
                sh_offset: seg.rela_off,
                sh_size: seg.rela_size,
                sh_link: dynsym_shdr_idx,
                sh_addralign: 8,
                sh_entsize: ELF64_RELA_SIZE,
                ..Default::default()
            },
        ));
        for (kind, shdr) in headers {
            self.shdr(kind, shdr);
        }
    }

    /// The loaded sections in address order: `.text`, `.rodata`, `.tdata`,
    /// `.dynamic`, `.got`, `.data.rel.ro` (`SHF_WRITE` like ld's: writable
    /// until the loader re-protects it), `.data`, `.tbss` and `.bss`
    /// (`SHT_NOBITS`; the rw load's `p_memsz` tail reserves the bytes, the
    /// header lets `size` attribute them), each family followed by its
    /// named sections.
    fn emit_segment_headers(&mut self) {
        let build = self.build;
        let seg = &self.seg;
        let tail = &self.tail;
        let dynstr_shdr_idx: u32 = 3;
        let alloc_shdr =
            |name: &str, sh_type: u32, sh_flags: u64, off: u64, size: u64, align: u64| Elf64Shdr {
                sh_name: self.name_off(name),
                sh_type,
                sh_flags,
                sh_addr: TEXT_VMADDR_BASE + off,
                sh_offset: off,
                sh_size: size,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: align,
                sh_entsize: 0,
            };
        let mut headers: Vec<(Sec, Elf64Shdr)> = alloc::vec![(
            Sec::Text,
            alloc_shdr(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                seg.code_off,
                seg.code.len() as u64,
                self.text_align,
            ),
        )];
        if seg.has_rodata {
            headers.push((
                Sec::RoData,
                alloc_shdr(
                    ".rodata",
                    SHT_PROGBITS,
                    SHF_ALLOC,
                    seg.rodata_off,
                    self.family_size(Sec::RoData, seg.ro_total, self.va(seg.rodata_off)),
                    build.data_align.max(8) as u64,
                ),
            ));
        }
        if tail.has_tdata {
            headers.push((
                Sec::Tdata,
                alloc_shdr(
                    ".tdata",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_WRITE | SHF_TLS,
                    seg.tdata_off,
                    seg.tdata_size,
                    8,
                ),
            ));
        }
        headers.push((
            Sec::Dynamic,
            Elf64Shdr {
                sh_link: dynstr_shdr_idx,
                sh_entsize: ELF64_DYN_SIZE,
                ..alloc_shdr(
                    ".dynamic",
                    SHT_DYNAMIC,
                    SHF_ALLOC | SHF_WRITE,
                    seg.dynamic_off,
                    seg.dynamic_size,
                    8,
                )
            },
        ));
        headers.push((
            Sec::Got,
            Elf64Shdr {
                sh_entsize: 8,
                ..alloc_shdr(
                    ".got",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_WRITE,
                    seg.got_off,
                    seg.got_size,
                    8,
                )
            },
        ));
        if tail.has_relro {
            headers.push((
                Sec::RelRo,
                alloc_shdr(
                    ".data.rel.ro",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_WRITE,
                    seg.relro_off,
                    self.family_size(Sec::RelRo, seg.relro_size, self.va(seg.relro_off)),
                    seg.data_align,
                ),
            ));
        }
        if tail.has_data {
            headers.push((
                Sec::Data,
                alloc_shdr(
                    ".data",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_WRITE,
                    seg.data_off,
                    self.family_size(Sec::Data, seg.data_size, self.va(seg.data_off)),
                    seg.data_align,
                ),
            ));
        }
        if tail.has_tbss {
            headers.push((
                Sec::Tbss,
                alloc_shdr(
                    ".tbss",
                    SHT_NOBITS,
                    SHF_ALLOC | SHF_WRITE | SHF_TLS,
                    seg.tdata_off + seg.tdata_size,
                    seg.tbss_size,
                    8,
                ),
            ));
        }
        if tail.has_bss {
            headers.push((
                Sec::Bss,
                alloc_shdr(
                    ".bss",
                    SHT_NOBITS,
                    SHF_ALLOC | SHF_WRITE,
                    seg.bss_vmaddr - TEXT_VMADDR_BASE,
                    self.family_size(Sec::Bss, build.bss_size as u64, seg.bss_vmaddr),
                    // `sh_addr` stays congruent to its own 2-adic alignment
                    // (<= 16).
                    1u64 << seg.bss_vmaddr.trailing_zeros().min(4),
                ),
            ));
        }
        for (kind, shdr) in headers {
            self.shdr(kind, shdr);
            if matches!(kind, Sec::RoData | Sec::RelRo | Sec::Data | Sec::Bss) {
                self.named_shdrs(kind);
            }
        }
    }

    /// The non-loaded tail: the five `.debug_*` sections under `-g`
    /// (`.debug_frame` carries the CFI an unwinder reads through optimised
    /// frames), the `--emit-relocs` tables against the static symtab's
    /// section symbols, `.comment`, the static symbol table (`sh_info` one
    /// past the last LOCAL, which is every entry), and `.shstrtab` last.
    fn emit_tail_headers(&mut self) {
        let tail = &self.tail;
        let unloaded =
            |name: u32, sh_type: u32, sh_flags: u64, off: u64, size: u64, align: u64| Elf64Shdr {
                sh_name: name,
                sh_type,
                sh_flags,
                sh_addr: 0,
                sh_offset: off,
                sh_size: size,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: align,
                sh_entsize: 0,
            };
        let mut headers: Vec<(Sec, Elf64Shdr)> = Vec::new();
        if tail.emit_dwarf {
            let d = &tail.dwarf;
            for (name, off, bytes) in [
                (".debug_info", tail.dwarf_off, &d.debug_info),
                (".debug_abbrev", tail.dwarf_abbrev_off, &d.debug_abbrev),
                (".debug_line", tail.dwarf_line_off, &d.debug_line),
                (".debug_str", tail.dwarf_str_off, &d.debug_str),
                (".debug_frame", tail.dwarf_frame_off, &d.debug_frame),
            ] {
                headers.push((
                    Sec::Debug,
                    unloaded(
                        self.name_off(name),
                        SHT_PROGBITS,
                        0,
                        off,
                        bytes.len() as u64,
                        1,
                    ),
                ));
            }
        }
        let symtab_shdr_idx = tail.plan.index_of(Sec::Symtab) as u32;
        for (kind, name, off, bytes, target) in [
            (
                Sec::RelaText,
                ".rela.text",
                tail.rela_text_off,
                &tail.rela_text,
                Sec::Text,
            ),
            (
                Sec::RelaData,
                ".rela.data",
                tail.rela_data_off,
                &tail.rela_data,
                Sec::Data,
            ),
        ] {
            if bytes.is_empty() {
                continue;
            }
            headers.push((
                kind,
                Elf64Shdr {
                    sh_link: symtab_shdr_idx,
                    sh_info: tail.plan.index_of(target) as u32,
                    sh_entsize: ELF64_RELA_SIZE,
                    ..unloaded(
                        self.name_off(name),
                        SHT_RELA,
                        SHF_INFO_LINK,
                        off,
                        bytes.len() as u64,
                        8,
                    )
                },
            ));
        }
        headers.push((
            Sec::Comment,
            Elf64Shdr {
                sh_entsize: 1,
                ..unloaded(
                    self.name_off(".comment"),
                    SHT_PROGBITS,
                    SHF_MERGE | SHF_STRINGS,
                    tail.comment_off,
                    tail.comment.len() as u64,
                    1,
                )
            },
        ));
        if let Some(name_idx) = tail.symtab_name_idx {
            let n_sym = (tail.symtab.len() as u64) / ELF64_SYM_SIZE;
            headers.push((
                Sec::Symtab,
                Elf64Shdr {
                    sh_link: tail.plan.index_of(Sec::Strtab) as u32,
                    sh_info: n_sym as u32,
                    sh_entsize: ELF64_SYM_SIZE,
                    ..unloaded(
                        tail.shstrtab_offsets[name_idx],
                        SHT_SYMTAB,
                        0,
                        tail.symtab_off,
                        tail.symtab.len() as u64,
                        8,
                    )
                },
            ));
            headers.push((
                Sec::Strtab,
                unloaded(
                    tail.shstrtab_offsets[name_idx + 1],
                    SHT_STRTAB,
                    0,
                    tail.strtab_off,
                    tail.strtab.len() as u64,
                    1,
                ),
            ));
        }
        headers.push((
            Sec::Shstrtab,
            unloaded(
                tail.shstrtab_offsets[tail.shstrtab_name_idx],
                SHT_STRTAB,
                0,
                tail.shstrtab_off,
                tail.shstrtab.len() as u64,
                1,
            ),
        ));
        for (kind, shdr) in headers {
            self.shdr(kind, shdr);
        }
        assert_eq!(
            self.shdr_cursor,
            self.tail.plan.len(),
            "section table length differs from the plan"
        );
        debug_assert_eq!(self.out.len() as u64, self.tail.total_filesize);
    }

    /// The code blob is `[_start stub][build.text]`, so every fixup's
    /// `instr_offset` shifts by the stub length.
    fn patch_fixups(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let machine = self.machine;
        let stub_len = self.stub_len;
        let code = CodePlacement {
            file_off: self.seg.code_off,
            vmaddr: self.va(self.seg.code_off),
        };
        let got_vmaddr = self.va(self.seg.got_off);
        let jt_vmaddr = self.va(self.seg.rodata_off) + self.seg.jt_off;
        let text_vmaddr = self.text_vmaddr();
        if let Some(exit_off) = self.seg.exit_adrp_offset {
            let exit_idx = build
                .imports
                .imports
                .iter()
                .position(|i| i.local_name == "exit")
                .ok_or_else(|| {
                    Self::internal(String::from(
                        "ELF writer: _start stub asked for the libc-exit tail but `exit` \
                         isn't in the import set -- the codegen lower-pass and the writer \
                         disagree on whether libc is in scope.",
                    ))
                })?;
            patch_got_call(
                machine,
                &mut self.out,
                code,
                exit_off as u64,
                got_vmaddr + (exit_idx as u64) * 8,
                AddrPart::Whole,
                "_start exit fixup",
            )?;
        }
        for fx in &build.got_fixups {
            let instr_off = stub_len + fx.instr_offset as u64;
            let slot_vmaddr = got_vmaddr + (fx.import_index as u64) * 8;
            if fx.is_data_load && machine == Machine::X86_64 {
                crate::c5::codegen::require_whole_addr(fx.part, "GOT data-load fixup")?;
                patch_got_data_load(
                    &mut self.out,
                    code,
                    instr_off,
                    slot_vmaddr,
                    "GOT data-load fixup",
                )?;
            } else {
                patch_got_call(
                    machine,
                    &mut self.out,
                    code,
                    instr_off,
                    slot_vmaddr,
                    fx.part,
                    "GOT fixup",
                )?;
            }
        }
        for fx in &build.data_fixups {
            let target = self.data_off_to_vaddr(fx.data_offset);
            patch_addr_load(
                machine,
                &mut self.out,
                code,
                stub_len + fx.instr_offset as u64,
                target,
                fx.part,
                "data fixup",
            )?;
        }
        for fx in &build.got_base_fixups {
            patch_addr_load(
                machine,
                &mut self.out,
                code,
                stub_len + fx.instr_offset as u64,
                got_vmaddr.wrapping_add(fx.got_offset as u64),
                fx.part,
                "GOT base fixup",
            )?;
        }
        for fx in &build.func_fixups {
            patch_addr_load(
                machine,
                &mut self.out,
                code,
                stub_len + fx.instr_offset as u64,
                text_vmaddr + fx.target_native_offset as u64,
                fx.part,
                "func fixup",
            )?;
        }
        for r in &build.text_pcrel_relocs {
            let site_vmaddr = text_vmaddr + r.site_text_offset;
            let value = self.data_off_to_vaddr(r.target_data_offset) as i64 - site_vmaddr as i64;
            let file_off = code.file_at(stub_len + r.site_text_offset);
            let width = r.width as usize;
            if file_off + width > self.out.len() {
                return Err(Self::internal(format!(
                    "ELF: text pcrel field {file_off:#x} past end of image ({})",
                    self.out.len()
                )));
            }
            if width == 8 {
                self.out[file_off..file_off + 8].copy_from_slice(&value.to_le_bytes());
                continue;
            }
            let Ok(v) = i32::try_from(value) else {
                return Err(Self::internal(format!(
                    "ELF: text pcrel field {file_off:#x}: displacement {value:#x} exceeds 32 bits"
                )));
            };
            self.out[file_off..file_off + 4].copy_from_slice(&v.to_le_bytes());
        }
        if !build.text_abs_relocs.is_empty() {
            return Err(Self::internal(String::from(
                "ELF: an absolute text field cannot be written into a position-independent image",
            )));
        }
        for fx in &build.rodata.addr_fixups {
            patch_addr_load(
                machine,
                &mut self.out,
                code,
                stub_len + fx.code_offset as u64,
                jt_vmaddr + fx.rodata_offset,
                AddrPart::Whole,
                "table fixup",
            )?;
        }
        Ok(())
    }
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

    fn tiny_program() -> Program {
        super::super::test_support::empty_program()
    }

    /// One imported function and one dylib, over a `movz x0, #42; ret`.
    fn tiny_build() -> Build {
        use super::super::{ResolvedImport, ResolvedImports};
        use crate::c5::codegen::ResolvedDylib;
        let mut build = super::super::test_support::empty_build();
        build.text = vec![0x40, 0x05, 0x80, 0xD2, 0xC0, 0x03, 0x5F, 0xD6];
        build.imports = ResolvedImports {
            data_bindings: Default::default(),
            imports: vec![ResolvedImport {
                binding_idx: 0,
                local_name: "exit".into(),
                real_symbol: "exit".into(),
                dylib_index: 0,
                flat_lookup: false,
                is_object: false,
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
        };
        build.abi = super::super::Target::LinuxAarch64.abi();
        build.output_kind = super::super::OutputKind::Executable;
        build.debug_info = true;
        build
    }

    const PLACE_1000: CodePlacement = CodePlacement {
        file_off: 0,
        vmaddr: 0x1000,
    };

    #[test]
    fn patch_adrp_add_scales_load_store_imm12() {
        // `adrp x0, page ; ldrh w0, [x0, #:lo12:sym]`: the ldrh keeps its
        // opcode and gets imm12 = low-12 offset scaled by the 2-byte
        // access.
        let ldrh: u32 = 0x7940_0000; // ldrh w0, [x0]
        let mut out = aarch64::enc_adrp(aarch64::Reg(0), 0).to_le_bytes().to_vec();
        out.extend_from_slice(&ldrh.to_le_bytes());
        patch_adrp_add(&mut out, PLACE_1000, 0, 0x2008, AddrPart::Whole, "test").unwrap();
        let ldst = u32::from_le_bytes([out[4], out[5], out[6], out[7]]);
        assert_eq!(
            ldst & !(0xFFF << 10),
            ldrh & !(0xFFF << 10),
            "load/store opcode and registers preserved"
        );
        assert_eq!((ldst >> 10) & 0xFFF, 4, "imm12 = 8 / 2");

        let addi = aarch64::enc_add_imm(aarch64::Reg(0), aarch64::Reg(0), 0);
        let mut out2 = aarch64::enc_adrp(aarch64::Reg(0), 0).to_le_bytes().to_vec();
        out2.extend_from_slice(&addi.to_le_bytes());
        patch_adrp_add(&mut out2, PLACE_1000, 0, 0x2008, AddrPart::Whole, "test").unwrap();
        let add = u32::from_le_bytes([out2[4], out2[5], out2[6], out2[7]]);
        assert_eq!((add >> 10) & 0xFFF, 8, "add imm12 unscaled");
    }

    /// Smallest plausible Build that exercises the writer end to end.
    #[test]
    fn section_indices_resolve_to_their_own_section() {
        for bits in 0u16..256 {
            let plan = SectionPlan::new(SectionsPresent {
                versions: bits & 1 != 0,
                rodata: bits & 64 != 0,
                tdata: bits & 2 != 0,
                relro: bits & 128 != 0,
                data: bits & 4 != 0,
                tbss: bits & 8 != 0,
                bss: bits & 16 != 0,
                dwarf: if bits & 32 != 0 { 5 } else { 0 },
                rela_text: bits & 64 != 0,
                rela_data: bits & 2 != 0,
                plt_symtab: bits & 1 != 0,
                // Named sections ride in their family's slot, so the
                // indices past it have to move by their count.
                named_rodata: (bits & 64 != 0) as usize * 2,
                named_relro: (bits & 128 != 0) as usize,
                named_data: (bits & 4 != 0) as usize * 3,
                named_bss: (bits & 16 != 0) as usize,
            });
            let mut expected = 11;
            expected += 2 * (bits & 1 != 0) as usize; // .gnu.version{,_r}
            expected += (bits & 64 != 0) as usize * 3; // .rodata + 2 named
            expected += (bits & 2 != 0) as usize; // .tdata
            expected += (bits & 128 != 0) as usize * 2; // .data.rel.ro + 1
            expected += (bits & 4 != 0) as usize * 4; // .data + 3 named
            expected += (bits & 8 != 0) as usize; // .tbss
            expected += (bits & 16 != 0) as usize * 2; // .bss + 1 named
            expected += if bits & 32 != 0 { 5 } else { 0 }; // .debug_*
            expected += (bits & 64 != 0) as usize; // .rela.text
            expected += (bits & 2 != 0) as usize; // .rela.data
            expected += 2 * (bits & 1 != 0) as usize; // .symtab + .strtab
            assert_eq!(plan.len(), expected, "bits={bits}");
            for s in [Sec::Null, Sec::Text, Sec::Dynamic, Sec::Got, Sec::Shstrtab] {
                assert_eq!(plan.at(plan.index_of(s) as usize), s, "bits={bits} {s:?}");
            }
            assert_eq!(plan.index_of(Sec::Shstrtab) as usize, plan.len() - 1);
        }
    }

    fn read_u32(buf: &[u8], off: usize) -> u32 {
        u32::from_le_bytes(buf[off..off + 4].try_into().unwrap())
    }
    fn read_u64(buf: &[u8], off: usize) -> u64 {
        u64::from_le_bytes(buf[off..off + 8].try_into().unwrap())
    }
    /// Read a `#[repr(C)]` record back from the emitted image, the inverse
    /// of `write_struct`, so a test reads named fields instead of
    /// hand-computed byte offsets.
    fn read_struct<T: Copy>(buf: &[u8], off: usize) -> T {
        assert!(off + core::mem::size_of::<T>() <= buf.len());
        // SAFETY: `T` is `Copy + #[repr(C)]` at every call site, the bound
        // is checked above, and the little-endian field order matches the
        // host (asserted in `write_struct`).
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

    fn dynamic_entries(bytes: &[u8]) -> Vec<(u64, u64)> {
        let phoff = read_u64(bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
        let (mut off, mut sz) = (0u64, 0u64);
        for i in 0..phnum {
            let p = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            if read_u32(bytes, p) == PT_DYNAMIC {
                off = read_u64(bytes, p + 8);
                sz = read_u64(bytes, p + 32);
                break;
            }
        }
        let mut out = Vec::new();
        let mut e = off as usize;
        while (e as u64) < off + sz {
            out.push((read_u64(bytes, e), read_u64(bytes, e + 8)));
            e += ELF64_DYN_SIZE as usize;
        }
        out
    }

    #[test]
    fn dynamic_section_emits_init_fini_array_when_present() {
        // A program with constructors / destructors must carry
        // DT_INIT_ARRAY / DT_FINI_ARRAY (plus the size tags) so the dynamic
        // loader runs the pointer arrays; without them the constructors
        // never fire on the self-linked path.
        let mut build = tiny_build();
        build.data = alloc::vec![0u8; 16];
        build.init_fini_arrays = crate::c5::codegen::InitFiniArrays {
            init: Some((0, 8)),
            fini: Some((8, 8)),
        };
        let bytes = write(&tiny_program(), &build, Machine::Aarch64).unwrap();
        let dyn_ = dynamic_entries(&bytes);
        let val = |tag| dyn_.iter().find(|(t, _)| *t == tag).map(|(_, v)| *v);
        assert_eq!(val(DT_INIT_ARRAYSZ), Some(8), "DT_INIT_ARRAYSZ");
        assert_eq!(val(DT_FINI_ARRAYSZ), Some(8), "DT_FINI_ARRAYSZ");
        assert!(val(DT_INIT_ARRAY).is_some(), "DT_INIT_ARRAY present");
        assert!(val(DT_FINI_ARRAY).is_some(), "DT_FINI_ARRAY present");

        let plain = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let pd = dynamic_entries(&plain);
        assert!(!pd.iter().any(|(t, _)| *t == DT_INIT_ARRAY));
        assert!(!pd.iter().any(|(t, _)| *t == DT_FINI_ARRAY));
    }

    #[test]
    fn patch_adrp_ldr_preserves_destination_register() {
        // A GOT load `adrp xD; ldr xD, [xD, #off]` must keep xD after
        // patching.
        for rd in [0u8, 5, 16] {
            let mut out = Vec::new();
            out.extend_from_slice(&aarch64::enc_adrp(aarch64::Reg(rd), 0).to_le_bytes());
            out.extend_from_slice(
                &aarch64::enc_ldr_imm(aarch64::Reg(rd), aarch64::Reg(rd), 0).to_le_bytes(),
            );
            patch_adrp_ldr(&mut out, PLACE_1000, 0, 0x5008, AddrPart::Whole, "test").unwrap();
            let adrp = u32::from_le_bytes(out[0..4].try_into().unwrap());
            let ldr = u32::from_le_bytes(out[4..8].try_into().unwrap());
            assert_eq!(adrp & 0x1f, rd as u32, "adrp Rd preserved (rd={rd})");
            assert_eq!(ldr & 0x1f, rd as u32, "ldr Rt preserved (rd={rd})");
            assert_eq!((ldr >> 5) & 0x1f, rd as u32, "ldr Rn preserved (rd={rd})");
            assert_eq!(adrp & 0x9f00_0000, 0x9000_0000, "still an ADRP (rd={rd})");
        }
    }

    #[test]
    fn elf_hash_matches_known_values() {
        assert_eq!(elf_hash(b""), 0);
        assert_eq!(elf_hash(b"printf"), 0x077905a6);
        assert_eq!(elf_hash(b"malloc"), 0x07383353);
        assert_eq!(elf_hash(b"exit"), 0x0006cf04);
    }

    #[test]
    fn got_data_load_rewrites_lea_to_mov_against_slot() {
        // A data import (a shared-library data object, STT_OBJECT) is
        // referenced as a load of its address from the GOT slot. GOT
        // relaxation leaves a `lea rax, [rip+disp32]` (48 8D 05 ..); the
        // writer must flip it to `mov rax, [rip+disp32]` (48 8B 05 ..)
        // loading the slot, preserving the ModRM.
        let mut out = vec![0x48, 0x8D, 0x05, 0x00, 0x00, 0x00, 0x00, 0xC3];
        patch_got_data_load(&mut out, PLACE_1000, 0, 0x2000, "test").unwrap();
        assert_eq!(out[0], 0x48, "REX.W preserved");
        assert_eq!(out[1], 0x8B, "lea (0x8D) flipped to mov (0x8B)");
        assert_eq!(out[2], 0x05, "ModRM preserved (rax, RIP-relative)");
        assert_ne!(out[2], 0x8A, "ModRM not clobbered by the call-form patcher");
        let disp = i32::from_le_bytes(out[3..7].try_into().unwrap());
        assert_eq!(disp, 0x2000 - (0x1000 + 7), "RIP-relative disp to GOT slot");
    }

    #[test]
    fn rela_dyn_targets_got_slots() {
        // Each .rela.dyn entry must target a valid GOT slot.
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

    /// Walk the program-header table for the first phdr matching `p_type`.
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

    /// `_Thread_local`-free programs must NOT carry a `PT_TLS` program
    /// header.
    #[test]
    fn no_thread_local_means_no_pt_tls() {
        // The x86_64 `_start` stub picks argc/argv registers out of
        // `abi.int_arg_regs`, and its hard-coded `START_STUB_LEN = 23`
        // assumes the SysV ABI's RDI/RSI. `tiny_build()`'s default `abi` is
        // `LinuxAarch64`'s, whose `int_arg_regs[0]` is byte 0 -- which
        // collides with RAX in x86_64 land and turns the post-call `mov
        // argc_reg, rax` into a self-mov the elision pass drops, shortening
        // the stub by 3 bytes.
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

    /// Compile a `_Thread_local`-using program for Linux/aarch64, confirm a
    /// `PT_TLS` phdr is emitted, and check its `p_filesz` / `p_memsz` match
    /// `tls_init_size` / total TLS size.
    #[test]
    fn thread_local_emits_well_formed_pt_tls_aarch64() {
        use crate::Compiler;
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

        assert_eq!(p_flags, PF_R, "PT_TLS flags should be PF_R");
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
        // Alignment 8 matches glibc's TLS image alignment for word-sized
        // variables.
        assert_eq!(p_align, 8);
        // The TLS image must lie inside an rw PT_LOAD so the loader can
        // read .tdata as the per-thread initial image.
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

    /// x86_64 mirror of the aarch64 PT_TLS structural test.
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

    /// The R+E and RW `PT_LOAD` segments must fall on separate
    /// max-page-size pages (4K x86_64, 64K aarch64) so the loader can set
    /// their permissions independently -- one unavoidable page at that
    /// boundary.
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
                96 * 1024usize,
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
                "{machine:?} executable is {} bytes; a single page at the R+E/RW boundary plus a compact \
                 tail must keep it under {max_bytes} (rounding the file to the segment alignment twice \
                 would push it past ~130K)",
                bytes.len(),
            );
        }
    }

    /// Every `PT_LOAD` must advertise `p_align` equal to the arch
    /// max-page-size: 64K on aarch64, 4K on x86_64.
    #[test]
    fn pt_load_alignment_matches_max_page_size() {
        use crate::Compiler;
        let src = "int main() { return 0; }";
        let le16 = |b: &[u8], o: usize| u16::from_le_bytes([b[o], b[o + 1]]);
        let le32 = |b: &[u8], o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
        let le64 = |b: &[u8], o: usize| u64::from_le_bytes(b[o..o + 8].try_into().unwrap());
        for (machine, target, want_align) in [
            (
                Machine::Aarch64,
                super::super::Target::LinuxAarch64,
                0x1_0000u64,
            ),
            (Machine::X86_64, super::super::Target::LinuxX64, 0x1000u64),
        ] {
            let program =
                Compiler::with_target(super::super::super::tests::with_prelude(src), target)
                    .compile()
                    .expect("compile");
            let build =
                super::super::lower_for(&program, target, super::super::NativeOptions::default())
                    .expect("lower");
            let b = write(&tiny_program(), &build, machine).expect("write ELF");
            let (phoff, phentsize, phnum) = (
                le64(&b, 0x20) as usize,
                le16(&b, 0x36) as usize,
                le16(&b, 0x38) as usize,
            );
            let mut loads = 0;
            for i in 0..phnum {
                let ph = phoff + i * phentsize;
                if le32(&b, ph) == PT_LOAD {
                    loads += 1;
                    assert_eq!(
                        le64(&b, ph + 48),
                        want_align,
                        "{machine:?} PT_LOAD p_align must be the {want_align:#x} max-page-size",
                    );
                }
            }
            assert!(
                loads >= 2,
                "{machine:?}: expected R+E and RW PT_LOADs, saw {loads}"
            );
        }
    }

    /// Shared-library output (`OutputKind::SharedLibrary`) flips `e_type`
    /// to `ET_DYN` and adds the `#pragma export(<name>)` symbols to
    /// `.dynsym` as `STB_GLOBAL | STT_FUNC` defined entries.
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

            let e_type = u16::from_le_bytes(bytes[16..18].try_into().unwrap());
            assert_eq!(e_type, ET_DYN, "{machine:?}: expected ET_DYN");

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
            // .interp placeholder, so section-attributing tools classify it
            // correctly.
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

    // The `.bss` writer path is arch-independent; tiny_build carries an
    // aarch64 text fixture, so the structural assertions run on aarch64
    // like the other tiny_build writer tests.
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

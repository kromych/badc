//! ELF64 ET_REL writer -- emits a standard relocatable object from a per-TU
//! [`Build`].

#![cfg(feature = "std")]

use crate::c5::diag::Code;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use core::ops::Range;

use super::super::codegen::map_syms::{self, MapClass, MapMark};
use super::super::error::C5Error;
use super::super::program::{ExportedFunction, Program, SymVisibility};
use super::Machine;
use super::dwarf_reloc::{self, DwarfReloc, DwarfRelocTarget};
use super::elf_class::{
    Elf64Ehdr, Elf64Rela, Elf64Shdr, Elf64Sym, ElfClass, write_ehdr, write_shdr, write_sym,
};
use super::strtab::build_string_table;
use super::{AddrPart, Build};
use crate::c5::CodeModel;
use crate::c5::asm::{AsmSymDecl, AsmSymValue};
use crate::c5::layout::{round_up, write_struct};
// Relocation types this writer emits. `R_AARCH64_ADR_GOT_PAGE` /
// `R_AARCH64_LD64_GOT_LO12_NC` take a dylib-routed import's address through
// the GOT, because the symbol binds against a shared object at load time; a
// direct page relocation would force a copy relocation or a canonical PLT
// entry for a symbol that always lives in a shared library.
use super::elf_reloc_types::{
    R_386_8, R_386_16, R_386_32, R_386_PC8, R_386_PC16, R_386_PC32, R_386_PLT32, R_AARCH64_ABS32,
    R_AARCH64_ABS64, R_AARCH64_ADD_ABS_LO12_NC, R_AARCH64_ADR_GOT_PAGE, R_AARCH64_ADR_PREL_LO21,
    R_AARCH64_ADR_PREL_PG_HI21, R_AARCH64_CALL26, R_AARCH64_CONDBR19, R_AARCH64_JUMP26,
    R_AARCH64_LD_PREL_LO19, R_AARCH64_LD64_GOT_LO12_NC, R_AARCH64_LDST8_ABS_LO12_NC,
    R_AARCH64_LDST16_ABS_LO12_NC, R_AARCH64_LDST32_ABS_LO12_NC, R_AARCH64_LDST64_ABS_LO12_NC,
    R_AARCH64_LDST128_ABS_LO12_NC, R_AARCH64_MOVW_SABS_G0, R_AARCH64_MOVW_SABS_G1,
    R_AARCH64_MOVW_SABS_G2, R_AARCH64_MOVW_UABS_G0, R_AARCH64_MOVW_UABS_G0_NC,
    R_AARCH64_MOVW_UABS_G1, R_AARCH64_MOVW_UABS_G1_NC, R_AARCH64_MOVW_UABS_G2,
    R_AARCH64_MOVW_UABS_G2_NC, R_AARCH64_MOVW_UABS_G3, R_AARCH64_PREL32, R_AARCH64_PREL64,
    R_AARCH64_TLS_DTPREL64, R_AARCH64_TLSLE_ADD_TPREL_HI12, R_AARCH64_TLSLE_ADD_TPREL_LO12_NC,
    R_AARCH64_TSTBR14, R_X86_64_8, R_X86_64_16, R_X86_64_32, R_X86_64_32S, R_X86_64_64,
    R_X86_64_DTPOFF64, R_X86_64_PC8, R_X86_64_PC16, R_X86_64_PC32, R_X86_64_PC64, R_X86_64_PLT32,
    R_X86_64_REX_GOTPCRELX, R_X86_64_TPOFF32, i386_field_width, i386_reloc_desc,
};

const ELF_DATA_LSB: u8 = 1;
const ELF_VERSION_CURRENT: u8 = 1;
const ET_REL: u16 = 1;
const EM_386: u16 = 3;
const EM_X86_64: u16 = 62;
const EM_AARCH64: u16 = 183;
const SHT_PROGBITS: u32 = 1;
const SHT_SYMTAB: u32 = 2;
const SHT_STRTAB: u32 = 3;
const SHT_RELA: u32 = 4;
const SHT_REL: u32 = 9;
const SHT_NOTE: u32 = 7;
const SHT_NOBITS: u32 = 8;
const SHT_INIT_ARRAY: u32 = 14;
const SHT_FINI_ARRAY: u32 = 15;
const SHT_PREINIT_ARRAY: u32 = 16;

// `.note.badc` record types and the `desc` each one carries. The linker
// parses them back; a record with an empty payload is not emitted.
//   DYLIBS              NUL-separated dylib paths.
//   BINDING_MAP         (u32 dylib_index, NUL local name) per import.
//   EXPORTS             NUL-separated `#pragma export` names.
//   TLS_INDEX           u64 `.text` offsets of the Win64 `_tls_index` sites.
//   MACHO_TLV_DESC      u64 offset_in_block per thread-local variable.
//   MACHO_TLV_FIXUP     (u64 adrp offset, u64 descriptor index) pairs.
//   COPY_RELOC          (NUL local, NUL host) pairs from `#pragma binding`.
//   TLS_SYM             (u64 tls_offset, u64 size, NUL name) per defined
//                       thread-local variable.
//   MACHO_TLV_DESC_SYM  (u64 descriptor index, NUL name) per descriptor
//                       whose variable another unit defines.
//   ELF_TPOFF           (u64 imm offset, u8 kind, u64 local offset | NUL
//                       name) per Linux x86_64 TLS access site.
//   PROLOGUE_END        (u64 entry, u64 post-prologue) `.text` offsets.
//   EXTERN_DATA         NUL-separated names this unit takes the address of
//                       through an undefined symbol; every undefined
//                       reference is typed STT_NOTYPE, as gcc types its own.
const NT_BADC_DYLIBS: u32 = 1;
const NT_BADC_BINDING_MAP: u32 = 2;
const NT_BADC_EXPORTS: u32 = 3;
const NT_BADC_TLS_INDEX: u32 = 4;
const NT_BADC_MACHO_TLV_DESC: u32 = 5;
const NT_BADC_MACHO_TLV_FIXUP: u32 = 6;
const NT_BADC_COPY_RELOC: u32 = 7;
const NT_BADC_TLS_SYM: u32 = 8;
const NT_BADC_MACHO_TLV_DESC_SYM: u32 = 9;
const NT_BADC_ELF_TPOFF: u32 = 10;
const NT_BADC_PROLOGUE_END: u32 = 11;
const NT_BADC_EXTERN_DATA: u32 = 12;
const RODATA_SECTION: &str = ".rodata";
const DATA_REL_RO_SECTION: &str = ".data.rel.ro";

/// `.bss` and `.bss.*` name zero-fill storage by convention (the
/// assembler's default section attributes, mirrored by the linker's family
/// classifier): such a section is `SHT_NOBITS` and admits only
/// zero-initialized members.
fn is_bss_family(name: &str) -> bool {
    name == ".bss" || name.starts_with(".bss.")
}

/// Data-segment byte offsets that carry a relocated pointer slot.
fn relocated_data_offsets(
    program: &Program,
    label_relocs: &[crate::c5::codegen::LabelReloc],
) -> alloc::collections::BTreeSet<u64> {
    let mut out = alloc::collections::BTreeSet::new();
    for off in program
        .data_relocs
        .iter()
        .map(|r| r.data_offset)
        .chain(program.code_relocs.iter().map(|r| r.data_offset))
        .chain(program.extern_data_relocs.iter().map(|r| r.data_offset))
        .chain(label_relocs.iter().map(|r| r.data_offset))
    {
        out.insert(off);
    }
    out
}

/// Diagnostic for an assembler `.section` / `.pushsection` argument the
/// relocatable writer cannot reproduce faithfully.
fn asm_section_err(name: &str, what: &str) -> C5Error {
    C5Error::hard(
        Code::OBJECT_FORMAT,
        alloc::format!(
            "inline asm: section `{name}` requests {what}, which the object writer does not emit"
        ),
    )
}

const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;
const SHF_MERGE: u64 = 0x10;
const SHF_STRINGS: u64 = 0x20;
const SHF_INFO_LINK: u64 = 0x40;
const SHF_LINK_ORDER: u64 = 0x80;
const SHF_TLS: u64 = 0x400;

const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STB_WEAK: u8 = 2;
const STV_DEFAULT: u8 = 0;
const STT_NOTYPE: u8 = 0;
const STT_OBJECT: u8 = 1;
const STT_FUNC: u8 = 2;
const STT_FILE: u8 = 4;
const STT_SECTION: u8 = 3;
const STT_TLS: u8 = 6;
const SHN_UNDEF: u16 = 0;
const SHN_LORESERVE: u16 = 0xff00;
const SHN_ABS: u16 = 0xfff1;

const ELF64_RELA_SIZE: usize = 24;

/// psABI whose relocation numbers an object carries.
#[derive(Clone, Copy, PartialEq, Eq)]
enum RelocAbi {
    X86_64,
    I386,
    Aarch64,
}

impl RelocAbi {
    fn of(machine: Machine, class: ElfClass) -> RelocAbi {
        match (machine, class.is32()) {
            (Machine::X86_64, false) => RelocAbi::X86_64,
            (Machine::X86_64, true) => RelocAbi::I386,
            (Machine::Aarch64, _) => RelocAbi::Aarch64,
        }
    }

    /// Absolute relocation reading a `width`-byte field, or `None` when the
    /// psABI defines none: i386 has no 8-byte relocation.
    fn abs(self, width: u32) -> Option<u32> {
        Some(match (self, width) {
            (RelocAbi::X86_64, 8) => R_X86_64_64,
            (RelocAbi::X86_64, 4) => R_X86_64_32,
            (RelocAbi::I386, 4) => R_386_32,
            (RelocAbi::Aarch64, 8) => R_AARCH64_ABS64,
            (RelocAbi::Aarch64, 4) => R_AARCH64_ABS32,
            _ => return None,
        })
    }
}

fn e_machine_for(abi: RelocAbi) -> u16 {
    match abi {
        RelocAbi::X86_64 => EM_X86_64,
        RelocAbi::I386 => EM_386,
        RelocAbi::Aarch64 => EM_AARCH64,
    }
}

/// Section type a relocation table takes in this class. i386 is the only
/// psABI badc emits that uses `SHT_REL`, whose records carry no addend
/// field.
fn reloc_sht(class: ElfClass) -> u32 {
    if class.is32() { SHT_REL } else { SHT_RELA }
}

/// On-disk size of one relocation record, matching [`reloc_sht`].
fn reloc_entsize(class: ElfClass) -> u64 {
    if class.is32() {
        class.rel_size()
    } else {
        class.rela_size()
    }
}

/// Section-name prefix matching [`reloc_sht`].
fn reloc_prefix(class: ElfClass) -> &'static str {
    if class.is32() { ".rel" } else { ".rela" }
}

/// Write each entry's addend into the field it relocates, at the width its
/// type reads.
fn fold_rel_addends(class: ElfClass, table: &[u8], body: &mut [u8]) -> Result<(), C5Error> {
    if !class.is32() {
        return Ok(());
    }
    for row in table.as_chunks::<ELF64_RELA_SIZE>().0.iter() {
        let off = u64::from_le_bytes(row[0..8].try_into().unwrap()) as usize;
        let rtype = u64::from_le_bytes(row[8..16].try_into().unwrap()) as u32;
        let addend = i64::from_le_bytes(row[16..24].try_into().unwrap());
        let Some(width) = i386_field_width(rtype) else {
            return Err(C5Error::internal(alloc::format!(
                "elf_reloc: {} carries no field for an implicit addend",
                i386_reloc_desc(rtype)
            )));
        };
        let end = off + width as usize;
        if end > body.len() {
            return Err(C5Error::internal(alloc::format!(
                "elf_reloc: {} at 0x{off:x} (width {width}) past section end (length {})",
                i386_reloc_desc(rtype),
                body.len()
            )));
        }
        body[off..end].copy_from_slice(&addend.to_le_bytes()[..width as usize]);
    }
    Ok(())
}

/// Encode an ELF64-shaped relocation table at the class's width,
/// re-splitting `r_info` for the class.
fn encode_reloc_table(class: ElfClass, table: &[u8]) -> Vec<u8> {
    if !class.is32() {
        return table.to_vec();
    }
    let mut out = Vec::with_capacity(table.len() / ELF64_RELA_SIZE * 8);
    for row in table.as_chunks::<ELF64_RELA_SIZE>().0.iter() {
        let r_offset = u64::from_le_bytes(row[0..8].try_into().unwrap());
        let r_info = u64::from_le_bytes(row[8..16].try_into().unwrap());
        let info = class.reloc_info((r_info >> 32) as u32, r_info as u32);
        out.extend_from_slice(&(r_offset as u32).to_le_bytes());
        out.extend_from_slice(&(info as u32).to_le_bytes());
    }
    out
}

/// A section appended after the fixed and named sets, with its `.rela`
/// companion: an `.init_array` / `.fini_array` group, one function's
/// `__patchable_function_entries`, or `__mcount_loc`.
struct TailSection {
    name: String,
    sh_type: u32,
    flags: u64,
    align: u64,
    entsize: u64,
    link: u16,
    count: usize,
    rela: Vec<u8>,
}

/// Group `init_funcs` by (destructor?, priority) into `.init_array` /
/// `.fini_array` sections, building each group's `.rela` payload that binds
/// slot `i` to its function symbol.
fn build_init_array_sections(
    init_funcs: &[crate::c5::program::InitFunc],
    func_symidx_by_name: &alloc::collections::BTreeMap<String, u32>,
    rtype_abs64: u32,
) -> Result<Vec<TailSection>, C5Error> {
    if init_funcs.is_empty() {
        return Ok(Vec::new());
    }
    let mut groups: alloc::collections::BTreeMap<(bool, bool, u32), Vec<u32>> =
        alloc::collections::BTreeMap::new();
    for f in init_funcs {
        let sym_idx = *func_symidx_by_name.get(&f.name).ok_or_else(|| {
            C5Error::internal(format!(
                "elf_reloc: init/fini function `{}` has no .symtab entry",
                f.name
            ))
        })?;
        let key = (
            f.is_destructor,
            f.priority.is_none(),
            f.priority.unwrap_or(0),
        );
        groups.entry(key).or_default().push(sym_idx);
    }
    let mut out = Vec::with_capacity(groups.len());
    for ((is_dtor, no_prio, prio), sym_idxs) in groups {
        let base = if is_dtor {
            ".fini_array"
        } else {
            ".init_array"
        };
        let name = if no_prio {
            base.to_string()
        } else {
            format!("{base}.{prio:05}")
        };
        let mut rela = Vec::with_capacity(sym_idxs.len() * ELF64_RELA_SIZE);
        for (i, sym_idx) in sym_idxs.iter().enumerate() {
            write_struct(
                &mut rela,
                &Elf64Rela {
                    r_offset: (i * 8) as u64,
                    r_info: ((*sym_idx as u64) << 32) | rtype_abs64 as u64,
                    r_addend: 0,
                },
            );
        }
        out.push(TailSection {
            name,
            sh_type: if is_dtor {
                SHT_FINI_ARRAY
            } else {
                SHT_INIT_ARRAY
            },
            flags: SHF_ALLOC | SHF_WRITE,
            align: 8,
            entsize: 8,
            link: 0,
            count: sym_idxs.len(),
            rela,
        });
    }
    Ok(out)
}

/// One slot's binding: `R_*_64` against the text section holding
/// `text_off`, the offset carried as the addend, and that section's nominal
/// index.
fn text_slot_rela(
    slot: usize,
    text_off: usize,
    carve: &CarvePlan,
    text_sym_idx: u64,
    text_shndx: u16,
    rtype_abs64: u32,
) -> (Elf64Rela, u16) {
    let (sym, addend, shndx) = match carve.map_text(text_off as u64) {
        Some((e, new_off)) => (carve.sym_idx[e], new_off as i64, carve.shndx[e]),
        None => (text_sym_idx, text_off as i64, text_shndx),
    };
    (
        Elf64Rela {
            r_offset: (slot * 8) as u64,
            r_info: (sym << 32) | rtype_abs64 as u64,
            r_addend: addend,
        },
        shndx,
    )
}

/// `-fpatchable-function-entry`'s record per function: one 8-byte slot in a
/// `__patchable_function_entries` section of its own, `SHF_LINK_ORDER` on
/// the text section holding the function and relocated to the NOP area's
/// first byte, so a linker dropping the function drops the record with it.
/// gcc emits the same shape: writable, allocated, 8-aligned, one section
/// per function.
fn build_patchable_entry_sections(
    build: &Build,
    carve: &CarvePlan,
    text_sym_idx: u64,
    text_shndx: u16,
    rtype_abs64: u32,
) -> Vec<TailSection> {
    build
        .patchable_entries
        .iter()
        .map(|area| {
            let (rela, link) =
                text_slot_rela(0, area.start, carve, text_sym_idx, text_shndx, rtype_abs64);
            let mut bytes = Vec::with_capacity(ELF64_RELA_SIZE);
            write_struct(&mut bytes, &rela);
            TailSection {
                name: String::from("__patchable_function_entries"),
                sh_type: SHT_PROGBITS,
                flags: SHF_ALLOC | SHF_WRITE | SHF_LINK_ORDER,
                align: 8,
                entsize: 0,
                link,
                count: 1,
                rela: bytes,
            }
        })
        .collect()
}

/// `-mrecord-mcount`'s `__mcount_loc`: one 8-byte slot per profiling call
/// site, relocated to the call.
fn build_mcount_loc_section(
    build: &Build,
    carve: &CarvePlan,
    text_sym_idx: u64,
    text_shndx: u16,
    rtype_abs64: u32,
) -> Option<TailSection> {
    if build.mcount_sites.is_empty() {
        return None;
    }
    let mut rela = Vec::with_capacity(build.mcount_sites.len() * ELF64_RELA_SIZE);
    for (slot, &site) in build.mcount_sites.iter().enumerate() {
        let (r, _) = text_slot_rela(slot, site, carve, text_sym_idx, text_shndx, rtype_abs64);
        write_struct(&mut rela, &r);
    }
    Some(TailSection {
        name: String::from("__mcount_loc"),
        sh_type: SHT_PROGBITS,
        flags: SHF_ALLOC,
        align: 1,
        entsize: 0,
        link: 0,
        count: build.mcount_sites.len(),
        rela,
    })
}

/// One byte range moving from `.text` / `.data` / `.bss` into a named
/// section: `[old_lo, old_hi)` in the pre-carve offset space lands at
/// `new_base` within `table.entries[entry]`.
#[derive(Debug, Clone, Copy)]
struct CarveRange {
    old_lo: u64,
    old_hi: u64,
    new_base: u64,
    entry: usize,
}

/// The `__attribute__((section("name")))` placement plan: the named
/// sections plus the maps that retarget symbols and relocations from the
/// default sections into them.
#[derive(Debug, Clone, Default)]
struct CarvePlan {
    table: super::section_table::SectionTable,
    text_ranges: Vec<CarveRange>,
    /// `.text` prefix length that stays in place.
    text_keep_len: usize,
    shndx: Vec<u16>,
    sym_idx: Vec<u64>,
}

impl CarvePlan {
    /// New (entry, offset) for a pre-carve `.text` offset, when moved.
    fn map_text(&self, off: u64) -> Option<(usize, u64)> {
        let i = self.text_ranges.partition_point(|r| r.old_lo <= off);
        if i == 0 {
            return None;
        }
        let r = &self.text_ranges[i - 1];
        if off < r.old_hi {
            Some((r.entry, r.new_base + (off - r.old_lo)))
        } else {
            None
        }
    }
}

/// Placement of a unified data offset in the relocatable output.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum DataHome {
    /// `.data`, section-relative.
    Data(u64),
    /// `.bss`, section-relative.
    Bss(u64),
    /// Named section (table entry index), section-relative.
    Named(usize, u64),
}

impl DataHome {
    /// `delta` is a two's-complement byte displacement: a negative addend
    /// arrives as a wrapped `u64` and the section-relative offset goes
    /// negative through the same wrap (`home_sym` reads it back as `i64`).
    fn add(self, delta: u64) -> DataHome {
        match self {
            DataHome::Data(b) => DataHome::Data(b.wrapping_add(delta)),
            DataHome::Bss(b) => DataHome::Bss(b.wrapping_add(delta)),
            DataHome::Named(e, b) => DataHome::Named(e, b.wrapping_add(delta)),
        }
    }
}

/// One span of the unified `.data`-then-`.bss` offset space and the output
/// position of its first byte.
#[derive(Debug, Clone, Copy)]
struct DataSpan {
    old_lo: u64,
    old_hi: u64,
    home: DataHome,
    pad: bool,
}

/// Data layout of the relocatable object.
#[derive(Default)]
struct DataPlan {
    spans: Vec<DataSpan>,
    data_file_len: u64,
    data_len: u64,
    bss_len: u64,
    data_align: u64,
    bss_align: u64,
}

/// Home of a unified data offset before any named-section carve.
fn unified_home(off: u64, data_file_len: u64) -> DataHome {
    if off < data_file_len {
        DataHome::Data(off)
    } else {
        DataHome::Bss(off - data_file_len)
    }
}

impl DataPlan {
    fn identity(data_file_len: u64, bss_size: u64, data_align: u64) -> Self {
        DataPlan {
            spans: Vec::new(),
            data_file_len,
            data_len: data_file_len,
            bss_len: bss_size,
            data_align: crate::c5::layout::data_image_align(data_align as usize) as u64,
            bss_align: crate::c5::layout::bss_image_align(data_align as usize) as u64,
        }
    }

    fn map(&self, off: u64) -> DataHome {
        if self.spans.is_empty() {
            return unified_home(off, self.data_file_len);
        }
        let i = self.spans.partition_point(|s| s.old_lo <= off);
        if i == 0 {
            return DataHome::Data(0);
        }
        let s = &self.spans[i - 1];
        let delta = if s.pad {
            0
        } else {
            (off - s.old_lo).min(s.old_hi - s.old_lo)
        };
        s.home.add(delta)
    }

    /// Map a data reference through its object anchor: the anchor picks the
    /// span, the signed displacement `target - anchor` rides as the addend.
    fn map_ref(&self, target: u64, anchor: u64) -> DataHome {
        self.map(anchor).add(target.wrapping_sub(anchor))
    }
}

/// Partition the serialized `.rela.text` payload: a text-section addend
/// moved by the carve is retargeted (data-section addends were built
/// through the plan already), and a row whose `r_offset` sits in a carved
/// text range is drained into the owning named section's relocation list
/// with a rebased offset.
fn carve_partition_relas(bytes: &mut Vec<u8>, carve: &mut CarvePlan, text_sym: u64) {
    if carve.table.is_empty() || bytes.is_empty() {
        return;
    }
    let mut kept: Vec<u8> = Vec::with_capacity(bytes.len());
    for row in bytes.as_chunks::<ELF64_RELA_SIZE>().0.iter() {
        let r_offset = u64::from_le_bytes(row[0..8].try_into().unwrap());
        let mut r_info = u64::from_le_bytes(row[8..16].try_into().unwrap());
        let mut r_addend = i64::from_le_bytes(row[16..24].try_into().unwrap());
        let sym = r_info >> 32;
        let rtype = r_info & 0xffff_ffff;
        // `R_X86_64_PC32` rows store the target offset skewed by the
        // pc-relative correction; every other section-relative row stores
        // it directly. (The aarch64 types all sit above 0x100, so the
        // numeric check cannot misfire.)
        let skew: i64 = if rtype == R_X86_64_PC32 as u64 { -4 } else { 0 };
        let real = (r_addend - skew) as u64;
        if sym == text_sym
            && let Some((e, new_off)) = carve.map_text(real)
        {
            r_info = (carve.sym_idx[e] << 32) | rtype;
            r_addend = new_off as i64 + skew;
        }
        if let Some((e, new_off)) = carve.map_text(r_offset) {
            carve.table.entries[e]
                .relas
                .push(super::section_table::SectionRela {
                    offset: new_off,
                    sym: r_info >> 32,
                    rtype: (r_info & 0xffff_ffff) as u32,
                    addend: r_addend,
                });
            continue;
        }
        kept.extend_from_slice(&r_offset.to_le_bytes());
        kept.extend_from_slice(&r_info.to_le_bytes());
        kept.extend_from_slice(&r_addend.to_le_bytes());
    }
    *bytes = kept;
}

/// A section-attributed data object: unified offset, its own byte size
/// (`copy`), its unified storage extent including the 8-byte-slot rounding
/// (`extent`), placement alignment, and section-table entry.
#[derive(Debug, Clone, Copy)]
struct NamedDataObj {
    val: u64,
    copy: u64,
    extent: u64,
    align: u64,
    entry: usize,
}

/// Carve the anonymous immutable spans -- string literals, `__func__`
/// arrays, Mcpy templates -- out of the writable `.data` image into
/// `.rodata`.
fn carve_anonymous_const_data(
    program: &crate::c5::program::Program,
    build: &crate::c5::codegen::Build,
    reloc_slots: &alloc::collections::BTreeSet<u64>,
    carve: &mut CarvePlan,
    named_objs: &mut Vec<NamedDataObj>,
) -> Result<(), C5Error> {
    let data_file_len = build.data.len() as u64;
    let spans: Vec<(u64, u64)> = program
        .const_data_ranges
        .iter()
        .filter(|&&(lo, hi)| lo >= 0 && hi > lo)
        .map(|&(lo, hi)| (lo as u64, hi as u64))
        .filter(|&(_, hi)| hi <= data_file_len)
        .collect();
    if spans.is_empty() {
        return Ok(());
    }
    let merge = |mut v: Vec<(u64, u64)>| -> Vec<(u64, u64)> {
        v.sort_unstable();
        let mut out: Vec<(u64, u64)> = Vec::with_capacity(v.len());
        for (lo, hi) in v {
            match out.last_mut() {
                Some(last) if lo <= last.1 => last.1 = last.1.max(hi),
                _ => out.push((lo, hi)),
            }
        }
        out
    };
    let taken = merge(
        named_objs
            .iter()
            .map(|o| (o.val, o.val + o.extent))
            .collect(),
    );
    // Disqualify per recorded span, before merging: merging first would let
    // one span's relocation or named overlap withdraw its neighbours, which
    // are separate objects.
    let carvable: Vec<(u64, u64)> = spans
        .into_iter()
        .filter(|&(lo, hi)| {
            // `taken` is disjoint and sorted, so the only candidate is the
            // last span starting before `hi`.
            let overlaps_named = taken[..taken.partition_point(|&(start, _)| start < hi)]
                .last()
                .is_some_and(|&(_, end)| end > lo);
            // A relocated slot inside the span would need the span's
            // section to take the relocation; literals carry none, so an
            // overlap means the span is not the immutable image it claims.
            !overlaps_named && reloc_slots.range(lo..hi).next().is_none()
        })
        .collect();
    for (lo, hi) in merge(carvable) {
        let align = 1u64 << lo.trailing_zeros().min(3);
        let e = carve
            .table
            .get_or_insert(RODATA_SECTION, SHT_PROGBITS, SHF_ALLOC, align)
            .map_err(|m| C5Error::internal(&m))?;
        named_objs.push(NamedDataObj {
            val: lo,
            copy: hi - lo,
            extent: hi - lo,
            align,
            entry: e,
        });
    }
    Ok(())
}

/// Build the data placement plan.
fn plan_data_layout(
    program: &Program,
    build: &Build,
    named_objs: &[NamedDataObj],
    sizes: &mut Vec<u64>,
    internal: impl Fn(alloc::string::String) -> C5Error,
) -> Result<DataPlan, C5Error> {
    use crate::c5::symbol::Linkage;
    use crate::c5::token::Token;
    let data_file_len = build.data.len() as u64;
    let bss_size = build.bss_size.max(0) as u64;
    let base_align = build.data_align.max(1) as u64;
    if named_objs.is_empty() {
        return Ok(DataPlan::identity(data_file_len, bss_size, base_align));
    }
    let unified_len = data_file_len + bss_size;

    // Recorded placement alignment per object start: kept content splits at
    // these offsets so every object repacks at its own alignment.
    let mut split_align: alloc::collections::BTreeMap<u64, u64> =
        alloc::collections::BTreeMap::new();
    for sym in &program.symbols {
        if sym.class == Token::Glo as i64
            && sym.defined_here
            && !sym.is_alias
            && !sym.is_thread_local
            && matches!(sym.linkage, Linkage::External | Linkage::Internal)
            && (sym.val as u64) < unified_len
        {
            let a = sym.data_align.max(1) as u64;
            let e = split_align.entry(sym.val as u64).or_insert(a);
            *e = (*e).max(a);
        }
    }
    for &(off, a) in &program.data_align_marks {
        if (0..unified_len as i64).contains(&off) && a > 0 {
            let e = split_align.entry(off as u64).or_insert(a as u64);
            *e = (*e).max(a as u64);
        }
    }

    // In-section base per named object, packed in declaration order at the
    // member's alignment. Removal ranges leave the default sections: the
    // object bytes, the slot-rounding slack past them, and the recorded
    // alignment padding (`entry == usize::MAX` marks dropped padding).
    let mut named_home: alloc::collections::BTreeMap<u64, (usize, u64)> =
        alloc::collections::BTreeMap::new();
    let mut removals: Vec<(u64, u64, usize)> = Vec::new();
    for o in named_objs {
        if sizes.len() <= o.entry {
            sizes.resize(o.entry + 1, 0);
        }
        let base = round_up(sizes[o.entry], o.align.max(1));
        sizes[o.entry] = base + o.copy;
        named_home.insert(o.val, (o.entry, base));
        removals.push((o.val, o.val + o.copy, o.entry));
        if o.extent > o.copy {
            removals.push((o.val + o.copy, o.val + o.extent, usize::MAX));
        }
    }
    for &(lo, hi) in &program.data_pad_ranges {
        let lo = (lo.max(0) as u64).min(unified_len);
        let hi = (hi.max(0) as u64).min(unified_len);
        if lo < hi {
            removals.push((lo, hi, usize::MAX));
        }
    }
    removals.sort_by_key(|&(lo, ..)| lo);
    for w in removals.windows(2) {
        if w[0].1 > w[1].0 {
            return Err(internal(alloc::format!(
                "named-section data ranges and padding overlap at offset {}",
                w[1].0
            )));
        }
    }

    let mut spans: Vec<DataSpan> = Vec::new();
    let mut cursor_data: u64 = 0;
    let mut cursor_bss: u64 = 0;
    let mut data_align: u64 = crate::c5::layout::DATA_ALIGN_MIN as u64;
    let mut bss_align: u64 = crate::c5::layout::BSS_ALIGN_MIN as u64;
    // One past the previously placed content; padding offsets map here so a
    // one-past-the-end address stays adjacent to its object.
    let mut last_end = DataHome::Data(0);
    let mut pos: u64 = 0;
    let mut ri = 0usize;
    while pos < unified_len {
        if ri < removals.len() && removals[ri].0 == pos {
            let (lo, hi, e) = removals[ri];
            ri += 1;
            if e == usize::MAX {
                spans.push(DataSpan {
                    old_lo: lo,
                    old_hi: hi,
                    home: last_end,
                    pad: true,
                });
            } else {
                let &(entry, base) = named_home
                    .get(&lo)
                    .expect("named removal range has a planned base");
                spans.push(DataSpan {
                    old_lo: lo,
                    old_hi: hi,
                    home: DataHome::Named(entry, base),
                    pad: false,
                });
                last_end = DataHome::Named(entry, base + (hi - lo));
            }
            pos = hi;
            continue;
        }
        let next_removal = removals.get(ri).map(|r| r.0).unwrap_or(unified_len);
        let mut hi = next_removal.max(pos + 1);
        if pos < data_file_len && hi > data_file_len {
            hi = data_file_len;
        }
        if let Some((&s, _)) = split_align.range((pos + 1)..hi).next() {
            hi = s;
        }
        let in_file = matches!(unified_home(pos, data_file_len), DataHome::Data(_));
        let cursor = if in_file {
            &mut cursor_data
        } else {
            &mut cursor_bss
        };
        let base = if let Some(&a) = split_align.get(&pos) {
            let a = crate::c5::layout::data_image_align(a as usize) as u64;
            if in_file {
                data_align = data_align.max(a);
            } else {
                bss_align = bss_align.max(a);
            }
            round_up(*cursor, a)
        } else {
            // Anonymous content keeps its 8-byte residue.
            *cursor + (pos as i64 - *cursor as i64).rem_euclid(8) as u64
        };
        let home = if in_file {
            DataHome::Data(base)
        } else {
            DataHome::Bss(base)
        };
        spans.push(DataSpan {
            old_lo: pos,
            old_hi: hi,
            home,
            pad: false,
        });
        *cursor = base + (hi - pos);
        last_end = home.add(hi - pos);
        pos = hi;
    }
    #[cfg(feature = "std")]
    if std::env::var("BADC_DEBUG_DATA_PLAN").is_ok() {
        for s in &spans {
            std::eprintln!(
                "span [{:#x},{:#x}) pad={} home={:?}",
                s.old_lo,
                s.old_hi,
                s.pad,
                s.home
            );
        }
        std::eprintln!("data_len={cursor_data:#x} bss_len={cursor_bss:#x}");
    }
    Ok(DataPlan {
        spans,
        data_file_len,
        data_len: cursor_data,
        bss_len: cursor_bss,
        data_align,
        bss_align,
    })
}

const SHIDX_TEXT: u16 = 1;
const SHIDX_RELA_TEXT: u16 = 2;
const SHIDX_DATA: u16 = 3;
const SHIDX_BSS: u16 = 4;
const SHIDX_SYMTAB: u16 = 5;
const SHIDX_STRTAB: u16 = 6;
const SHIDX_SHSTRTAB: u16 = 7;
const SHIDX_RELA_DATA: u16 = 8;
const SHIDX_NOTE_BADC: u16 = 9;
const SHIDX_DEBUG_INFO: u16 = 10;
const SHIDX_RELA_DEBUG_INFO: u16 = 11;
const SHIDX_DEBUG_ABBREV: u16 = 12;
const SHIDX_DEBUG_LINE: u16 = 13;
const SHIDX_RELA_DEBUG_LINE: u16 = 14;
const SHIDX_DEBUG_STR: u16 = 15;
const SHIDX_TDATA: u16 = 16;
const SHIDX_TBSS: u16 = 17;
const SHIDX_RELA_TDATA: u16 = 18;
const FIXED_SECTION_COUNT: usize = 16;

/// A label defined inside an inline-asm named section.
struct AsmLabelSym<'a> {
    name: &'a str,
    shndx: u16,
    sec_sym: u64,
    value: u64,
    global: bool,
    weak: bool,
    st_type: u8,
    st_size: u64,
    merge: bool,
}

/// A named label an inline-asm template defined in the main code stream.
struct AsmTextLabelSym<'a> {
    name: &'a str,
    offset: usize,
    bind: u8,
    st_type: u8,
    st_size: u64,
}

/// Where the object's content lands: the named-section carve, the data
/// plan, and the placement of every payload the writer appends to a table
/// entry.
#[derive(Default)]
struct Layout {
    carve: CarvePlan,
    plan: DataPlan,
    sizes: Vec<u64>,
    attr_sizes: Vec<u64>,
    asm_placements: Vec<(usize, u64)>,
    gnu_property_note: Option<(usize, u64, Vec<u8>)>,
    jt_placement: Option<(usize, u64)>,
    /// A default section the unit leaves empty while a named entry claims
    /// its name is dropped, so the name is carried once.
    text_shadowed: bool,
    data_shadowed: bool,
    bss_shadowed: bool,
}

/// Positions in the `.strtab` name list, one per symbol class.
#[derive(Default)]
struct NameStarts {
    funcs: usize,
    imports: usize,
    user_extern: usize,
    data_locals: usize,
    data_globals: usize,
    user_extern_data: usize,
    asm_extern: usize,
    asm_global_undef: usize,
    tls_globals: usize,
    tls_locals: usize,
    extern_tls: usize,
    aliases: usize,
    asm_labels: usize,
    asm_text_labels: usize,
    asm_decl_set: usize,
    asm_decl_undef: usize,
    map: usize,
}

/// The unit's names, classified by how each reaches the symbol table.
#[derive(Default)]
struct Names<'a> {
    file_names: Vec<&'a str>,
    weak_names: BTreeSet<&'a str>,
    visibility: BTreeMap<&'a str, SymVisibility>,
    local_func_idxs: Vec<usize>,
    global_func_idxs: Vec<usize>,
    func_strs: Vec<String>,
    prologue_end_entries: Vec<(usize, usize)>,
    defined_fn_names: BTreeSet<&'a str>,
    asm_label_names: BTreeSet<&'a str>,
    asm_set_defs: Vec<(&'a str, AsmSymValue)>,
    asm_defined_labels: BTreeSet<&'a str>,
    defined_obj_by_name: BTreeMap<&'a str, (i64, u64, bool)>,
    undef_alias_end: BTreeMap<&'a str, (&'a str, i64)>,
    user_extern_names: Vec<&'a str>,
    extern_fn_by_pc: BTreeMap<usize, &'a str>,
    defined_data_globals: Vec<(&'a str, i64, u64)>,
    defined_data_locals: Vec<(&'a str, i64, u64)>,
    defined_tls_globals: Vec<(&'a str, i64, u64)>,
    defined_tls_locals: Vec<(&'a str, i64, u64)>,
    user_extern_data_names: Vec<&'a str>,
    asm_extern_names: Vec<&'a str>,
    asm_global_undef: Vec<&'a str>,
    extern_tls_names: Vec<&'a str>,
    asm_labels: Vec<AsmLabelSym<'a>>,
    asm_text_label_syms: Vec<AsmTextLabelSym<'a>>,
    asm_decl_set: Vec<(&'a str, AsmSymValue)>,
    asm_decl_undef: Vec<&'a AsmSymDecl>,
    /// Names a GOT-addressed reference reaches; the slot is per symbol, so
    /// such a label keeps its own entry.
    got_ref_names: BTreeSet<&'a str>,
    strtab: Vec<u8>,
    name_offs: Vec<u32>,
    at: NameStarts,
}

/// The symbol table under construction, with the indices the relocation
/// channels resolve against.
#[derive(Default)]
struct Symtab<'a> {
    symbols: Vec<Elf64Sym>,
    text_sym_idx: u64,
    data_sym_idx: u64,
    bss_sym_idx: u64,
    debug_line_sym_idx: u64,
    debug_abbrev_sym_idx: u64,
    debug_str_sym_idx: u64,
    fixed_section_syms: Range<u64>,
    tdata_sec_sym: u64,
    tbss_sec_sym: u64,
    first_global: u32,
    func_symidx_by_name: BTreeMap<String, u32>,
    asm_label_symidx: BTreeMap<&'a str, u32>,
    prologue_end_pairs: Vec<(u64, u64)>,
    alias_syms: Vec<Option<(u8, Elf64Sym)>>,
    defined_data_local_symidx: BTreeMap<&'a str, u64>,
    defined_tls_symidx: BTreeMap<&'a str, u64>,
    import_sym_indices: Vec<usize>,
    user_extern_sym_idx: Vec<usize>,
    asm_label_secref: BTreeMap<&'a str, (u64, i64)>,
    defined_data_symidx: BTreeMap<&'a str, u64>,
    user_extern_data_sym_idx: Vec<usize>,
    asm_extern_sym_idx: Vec<usize>,
    extern_tls_sym_idx: Vec<usize>,
    extern_symidx_by_name: BTreeMap<&'a str, usize>,
}

impl Symtab<'_> {
    fn push(&mut self, sym: Elf64Sym) -> u64 {
        let idx = self.symbols.len() as u64;
        self.symbols.push(sym);
        idx
    }
}

/// The relocation tables, ELF64-shaped until the class narrows them.
#[derive(Default)]
struct RelocTables {
    text: Vec<u8>,
    data: Vec<u8>,
    tdata: Vec<u8>,
    tail_sections: Vec<TailSection>,
    dwarf: dwarf_reloc::DwarfRelocatable,
    debug_info: Vec<u8>,
    debug_line: Vec<u8>,
}

/// Renumbering of the nominal section indices over the sections that
/// survive: a fixed section that is dropped shifts every index past it, and
/// the named and tail groups after the fixed set shift by the total.
#[derive(Clone, Copy, Default)]
struct ShndxMap {
    fixed_dropped: [(u16, bool); 13],
    base_sections: u16,
    dropped_sections: u16,
}

impl ShndxMap {
    fn dropped_below(&self, n: u16) -> u16 {
        self.fixed_dropped
            .iter()
            .filter(|&&(idx, dropped)| dropped && idx < n)
            .count() as u16
    }

    fn map(&self, n: u16) -> u16 {
        if n == 0 || n >= SHN_LORESERVE {
            n
        } else if n >= self.base_sections {
            n - self.dropped_sections
        } else {
            n - self.dropped_below(n)
        }
    }

    fn is_dropped(&self, nominal: u16) -> bool {
        self.fixed_dropped
            .iter()
            .any(|&(idx, dropped)| dropped && idx == nominal)
    }
}

/// The output being assembled: section headers, name table, and the file
/// bytes.
#[derive(Default)]
struct Output {
    note: Vec<u8>,
    shndx: ShndxMap,
    comment: Option<Vec<u8>>,
    count: usize,
    shstrtab: Vec<u8>,
    shstrtab_offs: Vec<u32>,
    named_names_start: usize,
    named_rela_names_start: usize,
    named_rela_pos: Vec<usize>,
    tail_name_idx: Vec<(usize, usize)>,
    comment_name_idx: usize,
    bytes: Vec<u8>,
    sh: Vec<Elf64Shdr>,
}

/// One relocatable object's writer. [`write_relocatable`] runs the phases
/// in order; each method reads what the earlier ones settled.
struct RelocWriter<'a> {
    program: &'a Program,
    build: &'a Build,
    machine: Machine,
    target: super::Target,
    class: ElfClass,
    abi: RelocAbi,
    kernel_abs: bool,
    has_tls: bool,
    elf_tls_interop: bool,
    base_sections: usize,
    layout: Layout,
    names: Names<'a>,
    syms: Symtab<'a>,
    relocs: RelocTables,
    out: Output,
}

/// Emit a relocatable ELF object holding the contents of `build`,
/// consumable by `ld` / `lld` and by badc's own linker.
pub(super) fn write_relocatable(
    program: &Program,
    build: &Build,
    machine: Machine,
    target: super::Target,
) -> Result<Vec<u8>, C5Error> {
    let mut w = RelocWriter::new(program, build, machine, target);
    w.plan_text_carve()?;
    let named_objs = w.plan_named_data()?;
    w.plan_data(&named_objs)?;
    w.place_asm_sections()?;
    w.place_writer_payloads()?;
    w.emit_section_symbols();
    w.classify_functions();
    w.collect_defined_names();
    w.collect_undefined_names();
    w.collect_asm_symbols();
    w.build_strtab();
    w.emit_local_function_symbols()?;
    w.emit_local_asm_symbols()?;
    w.resolve_alias_symbols()?;
    w.emit_alias_symbols(true);
    w.emit_local_data_symbols();
    w.emit_mapping_symbols();
    w.syms.first_global = w.syms.symbols.len() as u32;
    w.emit_global_asm_symbols()?;
    w.emit_global_function_symbols()?;
    w.emit_alias_symbols(false);
    w.emit_import_symbols();
    w.build_asm_label_refs();
    w.emit_data_symbols();
    w.emit_undefined_symbols();
    w.emit_call_relocs()?;
    w.emit_data_ref_relocs()?;
    w.emit_extern_ref_relocs()?;
    w.emit_asm_operand_relocs()?;
    w.emit_asm_section_relocs()?;
    w.emit_data_relocs()?;
    w.emit_tdata_relocs()?;
    w.build_tail_sections()?;
    w.emit_debug_relocs()?;
    w.drop_unreferenced_section_symbols()?;
    w.plan_sections();
    w.build_shstrtab();
    w.emit_text_section()?;
    w.emit_data_sections()?;
    w.emit_table_sections();
    w.emit_note_and_debug_sections();
    w.emit_tls_sections();
    w.emit_named_sections()?;
    w.emit_tail_sections();
    w.emit_comment_section();
    w.finish()
}

impl<'a> RelocWriter<'a> {
    fn new(
        program: &'a Program,
        build: &'a Build,
        machine: Machine,
        target: super::Target,
    ) -> Self {
        let class = build.elf_class;
        let has_tls = !program.tls_data.is_empty();
        let has_tls_relocs = !build.tls_data_relocs.is_empty()
            || !build.tls_extern_data_relocs.is_empty()
            || !build.tls_code_relocs.is_empty();
        RelocWriter {
            program,
            build,
            machine,
            target,
            class,
            abi: RelocAbi::of(machine, class),
            kernel_abs: machine == Machine::X86_64 && build.code_model == CodeModel::Kernel,
            has_tls,
            elf_tls_interop: matches!(
                target,
                super::Target::LinuxX64 | super::Target::LinuxAarch64
            ),
            base_sections: FIXED_SECTION_COUNT
                + if has_tls { 2 } else { 0 }
                + usize::from(has_tls_relocs),
            layout: Layout::default(),
            names: Names::default(),
            syms: Symtab::default(),
            relocs: RelocTables::default(),
            out: Output::default(),
        }
    }

    fn internal(msg: String) -> C5Error {
        C5Error::internal(&msg)
    }

    /// Reserve a table entry's `base` for `len` bytes at `align`.
    fn place_in_entry(&mut self, e: usize, align: u64, len: u64) -> u64 {
        let sizes = &mut self.layout.sizes;
        if sizes.len() <= e {
            sizes.resize(e + 1, 0);
        }
        let base = round_up(sizes[e], align);
        sizes[e] = base + len;
        base
    }

    /// Functions with a section attribute were grouped at the `.text`
    /// tail by the emission-order pass; each group's byte range moves
    /// into its named section, and `.text` keeps only the default
    /// prefix (plus the trailing version marker).
    /// TODO: `.debug_info` / `.debug_line` still describe carved
    /// functions at their pre-carve `.text` offsets.
    fn plan_text_carve(&mut self) -> Result<(), C5Error> {
        use crate::c5::token::Token;
        let (program, build) = (self.program, self.build);
        let fn_section: BTreeMap<&str, &str> = program
            .symbols
            .iter()
            .filter(|s| s.class == Token::Fun as i64 && s.defined_here && s.section_name.is_some())
            .map(|s| (s.link_name(), s.section_name.as_deref().unwrap_or("")))
            .collect();
        // The emitted code ends at the last recorded native offset; the
        // version marker sits past it and stays in `.text`.
        let code_end = build
            .pc_to_native
            .last()
            .copied()
            .unwrap_or(build.text.len());
        let mut text_groups: BTreeMap<&str, (usize, usize)> = BTreeMap::new();
        let area_start: BTreeMap<usize, usize> = build
            .patchable_entries
            .iter()
            .map(|a| (a.func, a.start))
            .collect();
        let func_start = |i: usize| -> Option<usize> {
            if let Some(&start) = area_start.get(&i) {
                return Some(start);
            }
            build
                .func_ent_pcs
                .get(i)
                .and_then(|&pc| build.pc_to_native.get(pc).copied())
                .filter(|&off| off != usize::MAX)
        };
        for i in 0..build.func_ent_pcs.len() {
            let Some(name) = build.func_names.get(i) else {
                continue;
            };
            let Some(sec) = fn_section.get(name.as_str()) else {
                continue;
            };
            let lo = func_start(i).unwrap_or(usize::MAX);
            let hi = func_start(i + 1).unwrap_or(code_end).min(code_end);
            if lo == usize::MAX || lo >= hi {
                continue;
            }
            let g = text_groups.entry(sec).or_insert((lo, hi));
            g.0 = g.0.min(lo);
            g.1 = g.1.max(hi);
        }
        let carve = &mut self.layout.carve;
        let text_align = build.text_align.max(16) as u64;
        for (sec, (lo, hi)) in &text_groups {
            let e = carve
                .table
                .get_or_insert(sec, SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, text_align)
                .map_err(Self::internal)?;
            carve.text_ranges.push(CarveRange {
                old_lo: *lo as u64,
                old_hi: *hi as u64,
                new_base: 0,
                entry: e,
            });
        }
        carve.text_ranges.sort_by_key(|r| r.old_lo);
        // The groups must tile the `.text` tail: every carved byte sits
        // past every default-section function, and no two groups
        // interleave.
        if let Some(first) = carve.text_ranges.first() {
            carve.text_keep_len = first.old_lo as usize;
            let mut prev_hi = first.old_lo;
            for r in &carve.text_ranges {
                if r.old_lo != prev_hi {
                    return Err(Self::internal(format!(
                        "named-section text groups are not contiguous at offset {}",
                        r.old_lo
                    )));
                }
                prev_hi = r.old_hi;
            }
            if prev_hi as usize != code_end {
                return Err(Self::internal(format!(
                    "named-section text groups do not end at the code tail ({prev_hi} vs {code_end})"
                )));
            }
        } else {
            carve.text_keep_len = build.text.len();
        }
        Ok(())
    }

    /// Data objects, in declaration order so the in-section packing matches
    /// the emission order a toolchain assembler produces.
    fn plan_named_data(&mut self) -> Result<Vec<NamedDataObj>, C5Error> {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
        let (program, build) = (self.program, self.build);
        let reloc_slots = relocated_data_offsets(program, &build.label_relocs);
        let data_file_len = build.data.len() as u64;
        let carve = &mut self.layout.carve;
        let mut named_objs: Vec<NamedDataObj> = Vec::new();
        for sym in &program.symbols {
            if sym.class != Token::Glo as i64
                || !sym.defined_here
                || sym.is_alias
                || sym.is_thread_local
                || !matches!(sym.linkage, Linkage::External | Linkage::Internal)
            {
                continue;
            }
            let Some(size) = crate::c5::layout::data_object_extent(sym) else {
                continue;
            };
            let val = sym.val as u64;
            let read_only = sym.storage_is_const && !sym.runtime_initialized;
            let (sec, flags) = match sym.section_name.as_deref() {
                Some(name) => (
                    name,
                    if read_only {
                        SHF_ALLOC
                    } else {
                        SHF_ALLOC | SHF_WRITE
                    },
                ),
                None => {
                    if !read_only || val + size.extent > data_file_len {
                        continue;
                    }
                    let holds_reloc = reloc_slots
                        .range(val..val.saturating_add(size.extent))
                        .next()
                        .is_some();
                    if holds_reloc && build.pic_link {
                        (DATA_REL_RO_SECTION, SHF_ALLOC | SHF_WRITE)
                    } else {
                        (RODATA_SECTION, SHF_ALLOC)
                    }
                }
            };
            let align = sym.data_align.max(1) as u64;
            let sh_type = if is_bss_family(sec) {
                if val < data_file_len {
                    let hi = ((val + size.copy).min(data_file_len)) as usize;
                    if build.data[val as usize..hi].iter().any(|&b| b != 0)
                        || reloc_slots
                            .range(val..val.saturating_add(size.extent))
                            .next()
                            .is_some()
                    {
                        return Err(C5Error::hard(
                            Code::OBJECT_FORMAT,
                            alloc::format!(
                                "only zero initializers are allowed in section `{sec}` (object `{}`)",
                                sym.name
                            ),
                        ));
                    }
                }
                SHT_NOBITS
            } else {
                SHT_PROGBITS
            };
            let e = carve
                .table
                .get_or_insert(sec, sh_type, flags, align)
                .map_err(Self::internal)?;
            named_objs.push(NamedDataObj {
                val,
                copy: size.copy,
                extent: size.extent,
                align,
                entry: e,
            });
        }
        carve_anonymous_const_data(program, build, &reloc_slots, carve, &mut named_objs)?;
        let mut by_val: Vec<(u64, u64)> = named_objs.iter().map(|o| (o.val, o.extent)).collect();
        by_val.sort_unstable();
        for w in by_val.windows(2) {
            if w[0].0 + w[0].1 > w[1].0 {
                let at = |off: u64| {
                    let names: Vec<&str> = program
                        .symbols
                        .iter()
                        .filter(|s| {
                            s.class == Token::Glo as i64
                                && s.val as u64 == off
                                && s.defined_here
                                && !s.is_alias
                                && !s.is_thread_local
                                && !s.name.is_empty()
                        })
                        .map(|s| s.name.as_str())
                        .collect();
                    if names.is_empty() {
                        String::from("<unnamed>")
                    } else {
                        names.join("/")
                    }
                };
                return Err(Self::internal(format!(
                    "named-section data ranges overlap: {} at offset {} runs {} bytes into {} at offset {}",
                    at(w[0].0),
                    w[0].0,
                    w[0].0 + w[0].1 - w[1].0,
                    at(w[1].0),
                    w[1].0
                )));
            }
        }
        Ok(named_objs)
    }

    /// Text groups keep their internal layout wholesale, 8-aligned within
    /// their entry; the data objects pack through [`plan_data_layout`].
    fn plan_data(&mut self, named_objs: &[NamedDataObj]) -> Result<(), C5Error> {
        let layout = &mut self.layout;
        layout.sizes.resize(layout.carve.table.entries.len(), 0);
        for r in layout.carve.text_ranges.iter_mut() {
            let base = (layout.sizes[r.entry] + 7) & !7;
            r.new_base = base;
            layout.sizes[r.entry] = base + (r.old_hi - r.old_lo);
        }
        layout.plan = plan_data_layout(
            self.program,
            self.build,
            named_objs,
            &mut layout.sizes,
            Self::internal,
        )?;
        layout.attr_sizes = layout.sizes.clone();
        Ok(())
    }

    /// Inline-asm `.pushsection` payloads join the same table.
    fn place_asm_sections(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        for s in &build.asm_sections {
            let mut flags: u64 = 0;
            for c in s.flags.bytes() {
                match c {
                    b'a' => flags |= SHF_ALLOC,
                    b'w' => flags |= SHF_WRITE,
                    b'x' => flags |= SHF_EXECINSTR,
                    b'M' => flags |= SHF_MERGE,
                    b'S' => flags |= SHF_STRINGS,
                    b'o' => flags |= SHF_LINK_ORDER,
                    b'G' => {}
                    b'T' => {
                        return Err(asm_section_err(&s.name, "the `T` (TLS) section flag"));
                    }
                    _ => {
                        return Err(asm_section_err(
                            &s.name,
                            &alloc::format!("section flag `{}`", c as char),
                        ));
                    }
                }
            }
            let sh_type = match s.sh_type.as_deref() {
                None if is_bss_family(&s.name) => SHT_NOBITS,
                None | Some("progbits") => SHT_PROGBITS,
                Some("nobits") => SHT_NOBITS,
                Some("note") => SHT_NOTE,
                Some("init_array") => SHT_INIT_ARRAY,
                Some("fini_array") => SHT_FINI_ARRAY,
                Some("preinit_array") => SHT_PREINIT_ARRAY,
                Some(other) => {
                    return Err(asm_section_err(
                        &s.name,
                        &alloc::format!("section type `@{other}`"),
                    ));
                }
            };
            let align = s.align.max(1) as u64;
            let e = self
                .layout
                .carve
                .table
                .get_or_insert(&s.name, sh_type, flags, align)
                .map_err(Self::internal)?;
            // The first block to give an entry size or an ordering section
            // sets it, as GNU as keeps a section's first attributes.
            let ent = &mut self.layout.carve.table.entries[e];
            if ent.entsize == 0 {
                ent.entsize = s.entsize as u64;
            }
            if ent.link.is_none() {
                ent.link = s.link.clone();
            }
            let base = self.place_in_entry(e, align, s.bytes.len() as u64);
            self.layout.asm_placements.push((e, base));
        }
        Ok(())
    }

    /// `.note.gnu.property` (the AArch64 feature word the branch
    /// protections claim; the consumer AND-merges it across inputs) and the
    /// switch dispatch tables, which take a read-only entry of their own:
    /// the name keeps the `.rodata` prefix consumers that discover compiler
    /// jump tables key on, and stays apart from the carved `.rodata` so its
    /// pc-relative entry relocations do not pull that section's const
    /// objects into the relro stream on re-ingestion.
    fn place_writer_payloads(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let gnu_property_align: u64 = match self.class {
            ElfClass::Elf32 => 4,
            ElfClass::Elf64 => 8,
        };
        if let Some(body) =
            build_gnu_property_note(self.machine, build, gnu_property_align as usize)
        {
            let e = self
                .layout
                .carve
                .table
                .get_or_insert(
                    ".note.gnu.property",
                    SHT_NOTE,
                    SHF_ALLOC,
                    gnu_property_align,
                )
                .map_err(Self::internal)?;
            let base = self.place_in_entry(e, gnu_property_align, body.len() as u64);
            self.layout.gnu_property_note = Some((e, base, body));
        }
        if !build.rodata.bytes.is_empty() {
            let e = self
                .layout
                .carve
                .table
                .get_or_insert(".rodata.jump_tables", SHT_PROGBITS, SHF_ALLOC, 8)
                .map_err(Self::internal)?;
            let base = self.place_in_entry(e, 8, build.rodata.bytes.len() as u64);
            self.layout.jt_placement = Some((e, base));
        }
        let layout = &mut self.layout;
        for k in 0..layout.carve.table.entries.len() {
            layout.carve.shndx.push((self.base_sections + k) as u16);
            layout.carve.sym_idx.push(0);
        }
        let shadowed = |name: &str, empty: bool| -> bool {
            empty && layout.carve.table.entries.iter().any(|e| e.name == name)
        };
        layout.text_shadowed = shadowed(".text", build.text.is_empty());
        layout.data_shadowed =
            shadowed(".data", build.data.is_empty() && layout.plan.data_len == 0);
        layout.bss_shadowed = shadowed(".bss", layout.plan.bss_len == 0);
        Ok(())
    }

    /// The null entry, one `STT_FILE` per source file, one `STT_SECTION`
    /// per fixed section (the `.debug_*` ones under `-g` only, since the
    /// sections are not written otherwise), the local `STT_TLS` anchors the
    /// local-exec relocations of `static _Thread_local` accesses bind
    /// against, and one `STT_SECTION` per named entry.
    fn emit_section_symbols(&mut self) {
        let (program, build) = (self.program, self.build);
        let file_basename = program
            .source_path
            .rsplit('/')
            .next()
            .unwrap_or("<unknown>");
        self.names.file_names = if program.asm_unit {
            program.asm_file_names.iter().map(|s| s.as_str()).collect()
        } else {
            alloc::vec![file_basename]
        };
        let syms = &mut self.syms;
        syms.push(Elf64Sym::default());
        for _ in &self.names.file_names {
            syms.push(Elf64Sym {
                st_name: 0,
                st_info: pack_sym_info(STB_LOCAL, STT_FILE),
                st_shndx: SHN_ABS,
                ..Default::default()
            });
        }
        syms.text_sym_idx = syms.symbols.len() as u64;
        syms.data_sym_idx = syms.text_sym_idx + 1;
        syms.bss_sym_idx = syms.text_sym_idx + 2;
        syms.debug_line_sym_idx = syms.text_sym_idx + 3;
        syms.debug_abbrev_sym_idx = syms.text_sym_idx + 4;
        syms.debug_str_sym_idx = syms.text_sym_idx + 5;
        let mut fixed_section_shndx = alloc::vec![SHIDX_TEXT, SHIDX_DATA, SHIDX_BSS];
        if build.debug_info {
            fixed_section_shndx.push(SHIDX_DEBUG_LINE);
            fixed_section_shndx.push(SHIDX_DEBUG_ABBREV);
            fixed_section_shndx.push(SHIDX_DEBUG_STR);
        }
        syms.fixed_section_syms =
            syms.text_sym_idx..syms.text_sym_idx + fixed_section_shndx.len() as u64;
        for shndx in fixed_section_shndx {
            syms.push(Elf64Sym {
                st_info: pack_sym_info(STB_LOCAL, STT_SECTION),
                st_shndx: shndx,
                ..Default::default()
            });
        }
        if self.has_tls {
            for shndx in [SHIDX_TDATA, SHIDX_TBSS] {
                let idx = syms.push(Elf64Sym {
                    st_info: pack_sym_info(STB_LOCAL, STT_TLS),
                    st_shndx: shndx,
                    ..Default::default()
                });
                if shndx == SHIDX_TDATA {
                    syms.tdata_sec_sym = idx;
                } else {
                    syms.tbss_sec_sym = idx;
                }
            }
        }
        let layout = &mut self.layout;
        let carve = &mut layout.carve;
        for k in 0..carve.table.entries.len() {
            let inherited = [
                (".text", layout.text_shadowed, syms.text_sym_idx),
                (".data", layout.data_shadowed, syms.data_sym_idx),
                (".bss", layout.bss_shadowed, syms.bss_sym_idx),
            ]
            .into_iter()
            .find(|&(name, dropped, _)| dropped && carve.table.entries[k].name == name)
            .map(|(_, _, sym)| sym);
            if let Some(sym) = inherited {
                carve.sym_idx[k] = sym;
                syms.symbols[sym as usize].st_shndx = carve.shndx[k];
                continue;
            }
            carve.sym_idx[k] = syms.push(Elf64Sym {
                st_info: pack_sym_info(STB_LOCAL, STT_SECTION),
                st_shndx: carve.shndx[k],
                ..Default::default()
            });
        }
    }

    /// Function symbols, split by linkage since ELF requires every LOCAL
    /// symbol to precede every GLOBAL one.
    fn classify_functions(&mut self) {
        use crate::c5::asm::AsmSymBind;
        use crate::c5::token::Token;
        let (program, build) = (self.program, self.build);
        let names = &mut self.names;
        let func_linkage_by_pc: BTreeMap<usize, crate::c5::symbol::Linkage> = program
            .symbols
            .iter()
            .filter(|s| s.class == Token::Fun as i64 && s.defined_here && !s.is_alias)
            .map(|s| (s.val as usize, s.linkage))
            .collect();
        names.weak_names = program
            .symbols
            .iter()
            .filter(|s| {
                s.is_weak
                    && (s.is_fun_entity() || s.class == Token::Glo as i64)
                    && !s.name.is_empty()
            })
            .map(|s| s.link_name())
            .chain(program.asm_weak_names.iter().map(|s| s.as_str()))
            .chain(
                build
                    .asm_sym_decls
                    .iter()
                    .filter(|d| d.bind == AsmSymBind::Weak)
                    .map(|d| d.name.as_str()),
            )
            .collect();
        // An asm directive on a name the front end also marked wins: it
        // names the visibility explicitly.
        names.visibility = program
            .symbols
            .iter()
            .filter(|s| {
                s.is_hidden
                    && (s.is_fun_entity() || s.class == Token::Glo as i64)
                    && !s.name.is_empty()
            })
            .map(|s| (s.link_name(), SymVisibility::Hidden))
            .chain(program.asm_visibility.iter().map(|(n, v)| (n.as_str(), *v)))
            .collect();
        names.func_strs.reserve(build.func_ent_pcs.len());
        for (i, &ent_pc) in build.func_ent_pcs.iter().enumerate() {
            let name = build
                .func_names
                .get(i)
                .filter(|s| !s.is_empty())
                .cloned()
                .unwrap_or_else(|| format!("fn_{ent_pc}"));
            if let Some(&post_native) = build.func_prologue_native.get(&ent_pc) {
                names.prologue_end_entries.push((i, post_native));
            }
            let is_sys_trampoline = name.starts_with("__c5_sys_");
            names.func_strs.push(name);
            match func_linkage_by_pc.get(&ent_pc) {
                _ if is_sys_trampoline => names.local_func_idxs.push(i),
                Some(crate::c5::symbol::Linkage::Internal) => names.local_func_idxs.push(i),
                _ => names.global_func_idxs.push(i),
            }
        }
    }

    /// Binding of a name that surfaces as a definition or an UNDEF.
    fn bind_for(&self, name: &str) -> u8 {
        if self.names.weak_names.contains(name) {
            STB_WEAK
        } else {
            STB_GLOBAL
        }
    }

    fn vis_for(&self, name: &str) -> u8 {
        self.names
            .visibility
            .get(name)
            .map_or(STV_DEFAULT, |v| v.stv())
    }

    /// A hidden name is not preemptible, so the direct page-relative pair
    /// is correct and keeps the GOT empty.
    fn extern_addr_form(&self, name: &str) -> ExternAddrForm {
        if self
            .names
            .visibility
            .get(name)
            .is_some_and(|v| v.is_local_to_component())
        {
            return ExternAddrForm::Direct;
        }
        match self.machine {
            Machine::X86_64 if self.kernel_abs => ExternAddrForm::Abs32,
            Machine::X86_64 => ExternAddrForm::Got,
            Machine::Aarch64 if self.names.weak_names.contains(name) => ExternAddrForm::Got,
            Machine::Aarch64 => ExternAddrForm::Direct,
        }
    }

    /// The names this unit defines: functions, assembler labels, `.set`
    /// assignments that reach a definition, data objects by linkage, and
    /// the aliases whose chain ends undefined.
    fn collect_defined_names(&mut self) {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
        let (program, build) = (self.program, self.build);
        let names = &mut self.names;
        names.defined_fn_names = build.func_names.iter().map(|s| s.as_str()).collect();
        names.asm_label_names = build
            .asm_sections
            .iter()
            .flat_map(|s| s.labels.iter().map(|l| l.name.as_str()))
            .chain(build.asm_text_labels.iter().map(|l| l.name.as_str()))
            .collect();
        let value_of = |n: &str| {
            build
                .asm_sym_decls
                .iter()
                .find(|d| d.name == n)
                .and_then(|d| d.value.as_ref())
        };
        names.asm_set_defs = build
            .asm_sym_decls
            .iter()
            .filter_map(|d| {
                let mut v = d.value.as_ref()?;
                let mut off = 0i64;
                for _ in 0..build.asm_sym_decls.len() {
                    let AsmSymValue::Sym(t, k) = v else { break };
                    match value_of(t.as_str()) {
                        Some(next) => {
                            off += k;
                            v = next;
                        }
                        None => break,
                    }
                }
                match v {
                    AsmSymValue::Abs(n) => Some((d.name.as_str(), AsmSymValue::Abs(n + off))),
                    AsmSymValue::Sym(t, k) => (names.asm_label_names.contains(t.as_str())
                        || names.defined_fn_names.contains(t.as_str()))
                    .then(|| (d.name.as_str(), AsmSymValue::Sym(t.clone(), off + k))),
                }
            })
            .collect();
        names.asm_defined_labels = names
            .asm_label_names
            .iter()
            .copied()
            .chain(names.asm_set_defs.iter().map(|&(n, _)| n))
            .collect();
        names.defined_obj_by_name = program
            .symbols
            .iter()
            .filter(|s| {
                s.class == Token::Glo as i64
                    && s.defined_here
                    && !s.name.is_empty()
                    && matches!(s.linkage, Linkage::External | Linkage::Internal)
            })
            .map(|s| {
                let size = crate::c5::layout::data_object_byte_size(s);
                (s.link_name(), (s.val, size, s.is_thread_local))
            })
            .collect();
        names.undef_alias_end = program
            .function_aliases
            .iter()
            .filter_map(|a| {
                let (end, off) = alias_chain_end(&program.function_aliases, a);
                (!names.asm_defined_labels.contains(end)
                    && !names.defined_fn_names.contains(end)
                    && !names.defined_obj_by_name.contains_key(end)
                    && names.func_strs.iter().all(|n| n != end))
                .then_some((a.name.as_str(), (end, off)))
            })
            .collect();
        for site in &build.user_extern_call_sites {
            let s = site.symbol_name.as_str();
            if !names.defined_fn_names.contains(s)
                && !program.function_aliases.iter().any(|a| a.name == s)
                && !names.asm_defined_labels.contains(s)
                && !names.user_extern_names.contains(&s)
            {
                names.user_extern_names.push(s);
            }
        }
        names.extern_fn_by_pc = program
            .extern_function_imports
            .iter()
            .map(|(pc, name)| (*pc, name.as_str()))
            .collect();
        for r in &build.code_relocs {
            if let Some(&name) = names.extern_fn_by_pc.get(&(r.target_ent_pc as usize))
                && !program.function_aliases.iter().any(|a| a.name == name)
                && !names.asm_defined_labels.contains(name)
                && !names.user_extern_names.contains(&name)
            {
                names.user_extern_names.push(name);
            }
        }
        // Defined data objects by linkage (C99 6.2.2 + 6.9.2). A
        // thread-local's value is a TLS-block offset, not a `.data` offset,
        // so it keeps its own list.
        for sym in &program.symbols {
            if sym.class != Token::Glo as i64 || !sym.defined_here || sym.name.is_empty() {
                continue;
            }
            let size = crate::c5::layout::data_object_byte_size(sym);
            let rec = (sym.link_name(), sym.val, size);
            match (sym.linkage, sym.is_thread_local) {
                (Linkage::External, true) => names.defined_tls_globals.push(rec),
                (Linkage::External, false) => names.defined_data_globals.push(rec),
                (Linkage::Internal, true) => names.defined_tls_locals.push(rec),
                (Linkage::Internal, false) => names.defined_data_locals.push(rec),
                _ => {}
            }
        }
        // One name can reach the object twice: a block-scope static shares
        // its source name with a file-scope object, and an inline-asm label
        // may already carry it. The first record wins.
        let mut seen: BTreeSet<&str> = names
            .defined_data_globals
            .iter()
            .map(|(n, _, _)| *n)
            .chain(names.asm_defined_labels.iter().copied())
            .collect();
        names.defined_data_locals.retain(|(n, _, _)| seen.insert(n));
        let mut seen_tls: BTreeSet<&str> = names
            .defined_tls_globals
            .iter()
            .map(|(n, _, _)| *n)
            .collect();
        names
            .defined_tls_locals
            .retain(|(n, _, _)| seen_tls.insert(n));
    }

    /// The non-thread-local defined object's unified `.data` offset.
    fn defined_data_by_name(&self, n: &str) -> Option<i64> {
        self.names
            .defined_obj_by_name
            .get(n)
            .filter(|&&(_, _, tls)| !tls)
            .map(|&(val, _, _)| val)
    }

    /// Whether an alias emits a symbol of its own; one whose chain ends
    /// undefined does not.
    fn defines_alias(&self, n: &str) -> bool {
        self.program.function_aliases.iter().any(|a| a.name == n)
            && !self.names.undef_alias_end.contains_key(n)
    }

    fn unit_defines(&self, n: &str) -> bool {
        self.names.defined_fn_names.contains(n) || self.defined_data_by_name(n).is_some()
    }

    /// Whether `n` reaches no definition of this unit and no UNDEF entry
    /// collected so far.
    fn is_unreached(&self, n: &str) -> bool {
        let names = &self.names;
        !names.defined_fn_names.contains(n)
            && !self.program.function_aliases.iter().any(|a| a.name == n)
            && self.defined_data_by_name(n).is_none()
            && !names.asm_defined_labels.contains(n)
            && !names.user_extern_names.contains(&n)
            && !names.user_extern_data_names.contains(&n)
            && !names.asm_extern_names.contains(&n)
    }

    /// Cross-TU data names (code references and pointer-to-extern-data
    /// initializers resolve against the same UNDEF), the inline-asm operand
    /// and section-reloc names no other table covers, and the `.globl`
    /// names that surface nowhere else.
    fn collect_undefined_names(&mut self) {
        use crate::c5::asm::AsmSectionTarget;
        let (program, build) = (self.program, self.build);
        for r in &build.user_extern_data_refs {
            let s = r.symbol_name.as_str();
            if !self.names.asm_defined_labels.contains(s)
                && !program.function_aliases.iter().any(|a| a.name == s)
                && !self.unit_defines(s)
                && !self.names.user_extern_data_names.contains(&s)
            {
                self.names.user_extern_data_names.push(s);
            }
        }
        for r in build
            .extern_data_relocs
            .iter()
            .chain(&build.tls_extern_data_relocs)
        {
            let s = r.symbol_name.as_str();
            if !self.names.asm_defined_labels.contains(s)
                && !self.defines_alias(s)
                && !self.unit_defines(s)
                && !self.names.user_extern_data_names.contains(&s)
            {
                self.names.user_extern_data_names.push(s);
            }
        }
        // A reference through a dropped alias resolves against its chain's
        // end; the ends of all dropped aliases follow, since GNU as emits
        // the undefined entry for an unreferenced `.set` target too.
        let section_syms = build
            .asm_sections
            .iter()
            .flat_map(|s| &s.relocs)
            .map(|r| &r.target);
        let operand_syms = build.asm_sym_fixups.iter().map(|r| &r.target);
        let referenced: Vec<&'a str> = section_syms
            .chain(operand_syms)
            .filter_map(|t| match t {
                AsmSectionTarget::Symbol(name) => Some(name.as_str()),
                _ => None,
            })
            .chain(self.names.undef_alias_end.values().map(|&(n, _)| n))
            .collect();
        for name in referenced {
            let n = self
                .names
                .undef_alias_end
                .get(name)
                .map_or(name, |&(n, _)| n);
            if self.is_unreached(n) {
                self.names.asm_extern_names.push(n);
            }
        }
        for n in program.asm_visibility.iter().map(|(n, _)| n.as_str()) {
            if self.is_unreached(n) {
                self.names.asm_extern_names.push(n);
            }
        }
        let asm_global_undef: Vec<&'a str> = program
            .asm_global_names
            .iter()
            .map(|s| s.as_str())
            .filter(|&n| self.is_unreached(n) && !program.asm_weak_names.iter().any(|w| w == n))
            .collect();
        self.names.asm_global_undef = asm_global_undef;
    }

    /// A unit-level symbol directive an asm template carried outside any
    /// section.
    fn sym_decl(&self, n: &str) -> Option<&'a AsmSymDecl> {
        self.build.asm_sym_decls.iter().find(|d| d.name == n)
    }

    /// The labels defined inside inline-asm named sections and in the main
    /// code stream, the assignments outside any section, and the `.globl`
    /// declarations naming nothing the unit defines.
    fn collect_asm_symbols(&mut self) {
        use crate::c5::asm::{AsmSymBind, AsmSymType};
        let build = self.build;
        if self.elf_tls_interop {
            for f in &build.elf_tpoff_fixups {
                if let super::ElfTpoffTarget::Extern(name) = &f.target
                    && !self.names.extern_tls_names.contains(&name.as_str())
                {
                    self.names.extern_tls_names.push(name.as_str());
                }
            }
        }
        let this: &RelocWriter<'a> = self;
        let carve = &this.layout.carve;
        let weak_names = &this.names.weak_names;
        let asm_labels: Vec<AsmLabelSym<'a>> = this
            .layout
            .asm_placements
            .iter()
            .zip(build.asm_sections.iter())
            .flat_map(|(&(e, base), s)| {
                let shndx = carve.shndx[e];
                let sec_sym = carve.sym_idx[e];
                let merge = carve.table.entries[e].flags & SHF_MERGE != 0;
                s.labels.iter().map(move |l| {
                    let d = this.sym_decl(l.name.as_str());
                    AsmLabelSym {
                        name: l.name.as_str(),
                        shndx: if l.absolute.is_some() { SHN_ABS } else { shndx },
                        sec_sym,
                        value: match l.absolute {
                            Some(v) => v as u64,
                            None => base + l.offset as u64,
                        },
                        global: match d.map(|d| d.bind) {
                            Some(AsmSymBind::Global) => true,
                            Some(AsmSymBind::Local) => false,
                            _ => l.global,
                        },
                        weak: l.weak || weak_names.contains(l.name.as_str()),
                        st_type: st_type_of(match l.sym_type {
                            AsmSymType::NoType => d.map_or(AsmSymType::NoType, |d| d.sym_type),
                            t => t,
                        }),
                        st_size: l.size.or(d.and_then(|d| d.size)).unwrap_or(0),
                        merge,
                    }
                })
            })
            .collect();
        let mut asm_text_label_syms: Vec<AsmTextLabelSym<'a>> = Vec::new();
        for l in &build.asm_text_labels {
            let n = l.name.as_str();
            if asm_labels.iter().any(|a| a.name == n)
                || asm_text_label_syms.iter().any(|s| s.name == n)
            {
                continue;
            }
            let d = this.sym_decl(n);
            asm_text_label_syms.push(AsmTextLabelSym {
                name: n,
                offset: l.text_offset,
                bind: match d.map(|d| d.bind) {
                    Some(AsmSymBind::Global) => STB_GLOBAL,
                    Some(AsmSymBind::Weak) => STB_WEAK,
                    _ if weak_names.contains(n) => STB_WEAK,
                    _ => STB_LOCAL,
                },
                st_type: st_type_of(d.map_or(AsmSymType::NoType, |d| d.sym_type)),
                st_size: d.and_then(|d| d.size).unwrap_or(0),
            });
        }
        let asm_decl_set: Vec<(&'a str, AsmSymValue)> = this
            .names
            .asm_set_defs
            .iter()
            .filter(|(n, _)| !this.names.asm_label_names.contains(n))
            .cloned()
            .collect();
        let asm_decl_undef: Vec<&'a AsmSymDecl> = build
            .asm_sym_decls
            .iter()
            .filter(|d| {
                d.bind == AsmSymBind::Global
                    && d.value.is_none()
                    && this.is_unreached(d.name.as_str())
                    && !this.names.asm_global_undef.contains(&d.name.as_str())
            })
            .collect();
        let names = &mut self.names;
        names.asm_labels = asm_labels;
        names.asm_text_label_syms = asm_text_label_syms;
        names.asm_decl_set = asm_decl_set;
        names.asm_decl_undef = asm_decl_undef;
    }

    /// The string table over every name, in symbol-class order.
    fn build_strtab(&mut self) {
        let (program, build) = (self.program, self.build);
        let names = &mut self.names;
        let mut all: Vec<&str> = Vec::new();
        all.extend(names.file_names.iter().copied());
        names.at.funcs = all.len();
        all.extend(names.func_strs.iter().map(|s| s.as_str()));
        names.at.imports = all.len();
        all.extend(build.imports.imports.iter().map(|i| i.real_symbol.as_str()));
        names.at.user_extern = all.len();
        all.extend(names.user_extern_names.iter().copied());
        names.at.data_locals = all.len();
        all.extend(names.defined_data_locals.iter().map(|(n, _, _)| *n));
        names.at.data_globals = all.len();
        all.extend(names.defined_data_globals.iter().map(|(n, _, _)| *n));
        names.at.user_extern_data = all.len();
        all.extend(names.user_extern_data_names.iter().copied());
        names.at.asm_extern = all.len();
        all.extend(names.asm_extern_names.iter().copied());
        names.at.asm_global_undef = all.len();
        all.extend(names.asm_global_undef.iter().copied());
        names.at.tls_globals = all.len();
        if self.elf_tls_interop {
            all.extend(names.defined_tls_globals.iter().map(|(n, _, _)| *n));
        }
        names.at.tls_locals = all.len();
        if self.elf_tls_interop {
            all.extend(names.defined_tls_locals.iter().map(|(n, _, _)| *n));
        }
        names.at.extern_tls = all.len();
        all.extend(names.extern_tls_names.iter().copied());
        names.at.aliases = all.len();
        all.extend(program.function_aliases.iter().map(|a| a.name.as_str()));
        names.at.asm_labels = all.len();
        all.extend(names.asm_labels.iter().map(|l| l.name));
        names.at.asm_text_labels = all.len();
        all.extend(names.asm_text_label_syms.iter().map(|s| s.name));
        names.at.asm_decl_set = all.len();
        all.extend(names.asm_decl_set.iter().map(|(n, _)| *n));
        names.at.asm_decl_undef = all.len();
        all.extend(names.asm_decl_undef.iter().map(|d| d.name.as_str()));
        names.at.map = all.len();
        if self.machine == Machine::Aarch64 {
            all.push(MapClass::Code.symbol_name());
            all.push(MapClass::Data.symbol_name());
        }
        let (strtab, name_offs) = build_string_table(&all);
        names.strtab = strtab;
        names.name_offs = name_offs;
        for i in 0..names.file_names.len() {
            self.syms.symbols[1 + i].st_name = names.name_offs[i];
        }
    }

    fn func_extent(&self, i: usize) -> Result<(usize, usize), C5Error> {
        let build = self.build;
        let ent_pc = build.func_ent_pcs[i];
        let lo = build
            .pc_to_native
            .get(ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if lo == usize::MAX {
            return Err(Self::internal(format!(
                "elf_reloc: function ent_pc {ent_pc} has no native offset in pc_to_native",
            )));
        }
        Ok((lo, build.func_code_end(i)))
    }

    /// Where a `.text` offset ends up: the named section's index and
    /// rebased offset for a carved range, `.text` itself otherwise.
    fn text_place(&self, off: u64) -> (u16, u64) {
        let carve = &self.layout.carve;
        match carve.map_text(off) {
            Some((e, new_off)) => (carve.shndx[e], new_off),
            None => (SHIDX_TEXT, off),
        }
    }

    /// The relocation (symbol, addend) for a `.text` offset.
    fn text_ref(&self, off: u64) -> (u64, i64) {
        let carve = &self.layout.carve;
        match carve.map_text(off) {
            Some((e, new_off)) => (carve.sym_idx[e], new_off as i64),
            None => (self.syms.text_sym_idx, off as i64),
        }
    }

    /// The unit's TLS block is `.tdata` bytes then `.tbss` zero fill.
    fn tls_init_len(&self) -> i64 {
        self.program.tls_init_size.min(self.program.tls_data.len()) as i64
    }

    fn tls_home(&self, off: i64) -> (u16, i64) {
        let init = self.tls_init_len();
        if off >= init {
            (SHIDX_TBSS, off - init)
        } else {
            (SHIDX_TDATA, off)
        }
    }

    /// Section index and section-relative value of a unified data offset.
    fn data_place(&self, val: i64) -> (u16, u64) {
        match self.layout.plan.map(val.max(0) as u64) {
            DataHome::Data(o) => (SHIDX_DATA, o),
            DataHome::Bss(o) => (SHIDX_BSS, o),
            DataHome::Named(e, o) => (self.layout.carve.shndx[e], o),
        }
    }

    /// Where a name this unit defines lands: section index, value, symbol
    /// type and size.
    fn defined_place(&self, t: &str) -> Result<Option<(u16, u64, u8, u64)>, C5Error> {
        let names = &self.names;
        if let Some(l) = names.asm_labels.iter().find(|l| l.name == t) {
            return Ok(Some((l.shndx, l.value, l.st_type, l.st_size)));
        }
        if let Some(s) = names.asm_text_label_syms.iter().find(|s| s.name == t) {
            let (shndx, value) = self.text_place(s.offset as u64);
            return Ok(Some((shndx, value, s.st_type, s.st_size)));
        }
        if let Some(i) = names.func_strs.iter().position(|n| n == t) {
            let (lo, hi) = self.func_extent(i)?;
            let (shndx, value) = self.text_place(lo as u64);
            return Ok(Some((shndx, value, STT_FUNC, hi.saturating_sub(lo) as u64)));
        }
        let Some(&(val, size, tls)) = names.defined_obj_by_name.get(t) else {
            return Ok(None);
        };
        if tls {
            let (shndx, value) = self.tls_home(val);
            return Ok(Some((shndx, value as u64, STT_TLS, size)));
        }
        let (shndx, value) = self.data_place(val);
        Ok(Some((shndx, value, STT_OBJECT, size)))
    }

    /// Where an assignment's value lands: a constant is SHN_ABS, an
    /// assignment to another name takes that name's placement, which the
    /// chain resolution narrowed to a definition of this unit.
    fn set_place(&self, v: &AsmSymValue) -> Result<(u16, u64, u8, u64), C5Error> {
        let (t, off) = match v {
            AsmSymValue::Abs(n) => return Ok((SHN_ABS, *n as u64, STT_NOTYPE, 0)),
            AsmSymValue::Sym(t, k) => (t.as_str(), *k),
        };
        let (shndx, value, st_type, st_size) = self.defined_place(t)?.ok_or_else(|| {
            Self::internal(format!("elf_reloc: `.set` target `{t}` has no definition"))
        })?;
        Ok((shndx, value.wrapping_add_signed(off), st_type, st_size))
    }

    /// Binding of an assigned name: local unless a directive of the unit
    /// declared it global or weak, through either channel a directive
    /// arrives by.
    fn set_bind(&self, n: &str) -> u8 {
        use crate::c5::asm::AsmSymBind;
        let declared = self.program.asm_global_names.iter().any(|g| g == n)
            || self.names.weak_names.contains(n)
            || matches!(
                self.sym_decl(n).map(|d| d.bind),
                Some(AsmSymBind::Global | AsmSymBind::Weak)
            );
        if declared {
            self.bind_for(n)
        } else {
            STB_LOCAL
        }
    }

    /// A `.set` assignment follows the unit's directives, a declarator's
    /// own linkage its attributes.
    fn alias_bind(&self, a: &crate::c5::program::FunctionAlias) -> u8 {
        use crate::c5::program::AliasBind;
        match a.bind {
            AliasBind::Weak => STB_WEAK,
            AliasBind::Local => STB_LOCAL,
            AliasBind::Global => self.bind_for(&a.name),
            AliasBind::Assigned => self.set_bind(&a.name),
        }
    }

    /// A local label GNU as treats as an assembler temporary: references
    /// reduce to its section plus an addend whatever `.type` and `.size`
    /// say.
    fn asm_local_temp(&self, l: &AsmLabelSym) -> bool {
        !l.global
            && !l.weak
            && crate::c5::asm::is_local_label(l.name)
            && !l.merge
            && !self.names.got_ref_names.contains(l.name)
    }

    /// A name an inline-asm statement defined: the folded (section symbol,
    /// offset) for a local label, else its own symbol with a zero base.
    fn asm_label_ref(&self, name: &str) -> Option<(u64, i64)> {
        if let Some(&(sym, base)) = self.syms.asm_label_secref.get(name) {
            return Some((sym, base));
        }
        self.syms.asm_label_symidx.get(name).map(|&i| (i as u64, 0))
    }

    fn home_sym(&self, h: DataHome) -> (u64, i64) {
        match h {
            DataHome::Data(o) => (self.syms.data_sym_idx, o as i64),
            DataHome::Bss(o) => (self.syms.bss_sym_idx, o as i64),
            DataHome::Named(e, o) => (self.layout.carve.sym_idx[e], o as i64),
        }
    }

    fn data_section_ref(&self, off: i64) -> (u64, i64) {
        self.home_sym(self.layout.plan.map(off.max(0) as u64))
    }

    /// A named data reference whose name this unit defines: a function, an
    /// external-linkage object (its own symbol, so its binding reaches the
    /// linker) or an internal-linkage object (section + offset).
    fn defined_data_ref(&self, name: &str, got: bool) -> Option<(u64, i64)> {
        if let Some(&idx) = self.syms.func_symidx_by_name.get(name) {
            return Some((idx as u64, 0));
        }
        if let Some(&idx) = self.syms.defined_data_symidx.get(name) {
            return Some((idx, 0));
        }
        if got {
            return self
                .syms
                .defined_data_local_symidx
                .get(name)
                .map(|&i| (i, 0));
        }
        self.defined_data_by_name(name)
            .map(|v| self.data_section_ref(v))
    }

    /// `STB_LOCAL` function symbols, and the post-prologue anchors of every
    /// function that stays in `.text` (the merge pass keys them on merged
    /// `.text` addresses).
    fn emit_local_function_symbols(&mut self) -> Result<(), C5Error> {
        for k in 0..self.names.local_func_idxs.len() {
            let i = self.names.local_func_idxs[k];
            let (lo, hi) = self.func_extent(i)?;
            let (shndx, value) = self.text_place(lo as u64);
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.funcs + i],
                st_info: pack_sym_info(STB_LOCAL, STT_FUNC),
                st_shndx: shndx,
                st_value: value,
                st_size: hi.saturating_sub(lo) as u64,
                ..Default::default()
            };
            let idx = self.syms.push(sym);
            self.syms
                .func_symidx_by_name
                .insert(self.names.func_strs[i].clone(), idx as u32);
        }
        for k in 0..self.names.prologue_end_entries.len() {
            let (i, post_native) = self.names.prologue_end_entries[k];
            let (lo, _) = self.func_extent(i)?;
            let (fn_shndx, fn_off) = self.text_place(lo as u64);
            let (post_shndx, post_off) = self.text_place(post_native as u64);
            if fn_shndx == SHIDX_TEXT && post_shndx == SHIDX_TEXT {
                self.syms.prologue_end_pairs.push((fn_off, post_off));
            }
        }
        Ok(())
    }

    /// Local inline-asm section labels (`--keep-locals` holds the
    /// temporaries, as `as -L` does; the stand-ins for numeric labels stay
    /// out, as gas's unnamed ones do), main-stream labels a directive left
    /// local, and assignments no directive bound global or weak.
    fn emit_local_asm_symbols(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let got_ref_names: BTreeSet<&'a str> = build
            .user_extern_data_refs
            .iter()
            .map(|r| r.symbol_name.as_str())
            .filter(|n| self.extern_addr_form(n) == ExternAddrForm::Got)
            .collect();
        self.names.got_ref_names = got_ref_names;
        for j in 0..self.names.asm_labels.len() {
            let l = &self.names.asm_labels[j];
            if l.global || l.weak {
                continue;
            }
            let keep = build.keep_local_labels && !crate::c5::asm::is_generated_local_label(l.name);
            if self.asm_local_temp(l) && !keep {
                continue;
            }
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.asm_labels + j],
                st_info: pack_sym_info(STB_LOCAL, l.st_type),
                st_other: self.vis_for(l.name),
                st_shndx: l.shndx,
                st_value: l.value,
                st_size: l.st_size,
            };
            let name = l.name;
            let idx = self.syms.push(sym);
            self.syms.asm_label_symidx.insert(name, idx as u32);
        }
        for j in 0..self.names.asm_text_label_syms.len() {
            let l = &self.names.asm_text_label_syms[j];
            if l.bind != STB_LOCAL {
                continue;
            }
            let (shndx, value) = self.text_place(l.offset as u64);
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.asm_text_labels + j],
                st_info: pack_sym_info(STB_LOCAL, l.st_type),
                st_shndx: shndx,
                st_value: value,
                st_size: l.st_size,
                ..Default::default()
            };
            let name = l.name;
            let idx = self.syms.push(sym);
            self.syms.asm_label_symidx.insert(name, idx as u32);
        }
        for i in 0..self.names.asm_decl_set.len() {
            let (n, v) = &self.names.asm_decl_set[i];
            if self.set_bind(n) != STB_LOCAL {
                continue;
            }
            let (shndx, value, st_type, st_size) = self.set_place(v)?;
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.asm_decl_set + i],
                st_info: pack_sym_info(STB_LOCAL, st_type),
                st_other: self.vis_for(n),
                st_shndx: shndx,
                st_value: value,
                st_size,
            };
            let name = *n;
            let idx = self.syms.push(sym);
            self.syms.asm_label_symidx.insert(name, idx as u32);
        }
        Ok(())
    }

    /// `alias("target")` symbols: an additional name at the target's
    /// extent, following a chain of aliases to its defined end.
    fn resolve_alias_symbols(&mut self) -> Result<(), C5Error> {
        use crate::c5::asm::AsmSymType;
        let program = self.program;
        let mut alias_syms: Vec<Option<(u8, Elf64Sym)>> =
            Vec::with_capacity(program.function_aliases.len());
        for (i, a) in program.function_aliases.iter().enumerate() {
            if self.names.undef_alias_end.contains_key(a.name.as_str())
                || self.names.asm_label_names.contains(a.name.as_str())
            {
                alias_syms.push(None);
                continue;
            }
            let (target, off) = alias_chain_end(&program.function_aliases, a);
            let bind = self.alias_bind(a);
            let Some((shndx, value, st_type, st_size)) = self.defined_place(target)? else {
                return Err(Self::internal(format!(
                    "alias `{}`: target `{target}` has no definition",
                    a.name
                )));
            };
            // A `.type` / `.size` naming the alias states its own attributes,
            // as in GNU as; without one it takes the target's.
            let d = self.sym_decl(a.name.as_str());
            let st_size = d.and_then(|d| d.size).unwrap_or(st_size);
            let st_type = match d.map_or(AsmSymType::NoType, |d| d.sym_type) {
                AsmSymType::NoType => st_type,
                t => st_type_of(t),
            };
            alias_syms.push(Some((
                bind,
                Elf64Sym {
                    st_name: self.names.name_offs[self.names.at.aliases + i],
                    st_info: pack_sym_info(bind, st_type),
                    st_other: self.vis_for(&a.name),
                    st_shndx: shndx,
                    st_value: value.wrapping_add_signed(off),
                    st_size,
                },
            )));
        }
        self.syms.alias_syms = alias_syms;
        Ok(())
    }

    /// The resolved aliases of one binding class.
    fn emit_alias_symbols(&mut self, local: bool) {
        for i in 0..self.syms.alias_syms.len() {
            let Some((bind, sym)) = self.syms.alias_syms[i] else {
                continue;
            };
            if (bind == STB_LOCAL) != local {
                continue;
            }
            let idx = self.syms.push(sym);
            self.syms
                .func_symidx_by_name
                .insert(self.program.function_aliases[i].name.clone(), idx as u32);
        }
    }

    /// Internal-linkage data objects as `STB_LOCAL` + `STT_OBJECT` through
    /// the same layout plan the external ones use, and `_Thread_local`
    /// locals as `STT_TLS` against `.tdata` / `.tbss` with a
    /// section-relative value.
    fn emit_local_data_symbols(&mut self) {
        for i in 0..self.names.defined_data_locals.len() {
            let (name, val, size) = self.names.defined_data_locals[i];
            let (shndx, value) = self.data_place(val);
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.data_locals + i],
                st_info: pack_sym_info(STB_LOCAL, STT_OBJECT),
                st_other: STV_DEFAULT,
                st_shndx: shndx,
                st_value: value,
                st_size: size,
            };
            let idx = self.syms.push(sym);
            self.syms.defined_data_local_symidx.insert(name, idx);
        }
        if !self.elf_tls_interop {
            return;
        }
        for i in 0..self.names.defined_tls_locals.len() {
            let (name, off, size) = self.names.defined_tls_locals[i];
            let (shndx, value) = self.tls_home(off);
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.tls_locals + i],
                st_info: pack_sym_info(STB_LOCAL, STT_TLS),
                st_shndx: shndx,
                st_value: value as u64,
                st_size: size,
                ..Default::default()
            };
            let idx = self.syms.push(sym);
            self.syms.defined_tls_symidx.insert(name, idx);
        }
    }

    /// AArch64 mapping symbols.
    fn emit_mapping_symbols(&mut self) {
        if self.machine != Machine::Aarch64 {
            return;
        }
        let build = self.build;
        let layout = &self.layout;
        let carve = &layout.carve;
        let mut marks: Vec<(u16, MapMark)> = Vec::new();
        let mut sec_shape: BTreeMap<u16, (u64, bool)> = BTreeMap::new();
        sec_shape.insert(SHIDX_TEXT, (carve.text_keep_len as u64, true));
        sec_shape.insert(SHIDX_DATA, (layout.plan.data_len, false));
        sec_shape.insert(SHIDX_BSS, (layout.plan.bss_len, false));
        for (k, e) in carve.table.entries.iter().enumerate() {
            sec_shape.insert(
                carve.shndx[k],
                (
                    layout.sizes.get(k).copied().unwrap_or(0),
                    e.flags & SHF_EXECINSTR != 0,
                ),
            );
        }
        for m in map_syms::code_stream_marks(build.text.len(), &build.text_data_ranges) {
            let (mut lo, hi) = (u64::from(m.at), u64::from(m.at + m.len));
            while lo < hi {
                let end = carve
                    .text_ranges
                    .iter()
                    .find_map(|r| match () {
                        _ if lo < r.old_lo => Some(r.old_lo),
                        _ if lo < r.old_hi => Some(r.old_hi),
                        _ => None,
                    })
                    .map_or(hi, |b| b.min(hi));
                let (shndx, value) = self.text_place(lo);
                marks.push((
                    shndx,
                    MapMark {
                        at: value as u32,
                        len: (end - lo) as u32,
                        class: m.class,
                        opens: false,
                    },
                ));
                lo = end;
            }
        }
        let mut data_start = |shndx: u16, at: u64, len: u64| {
            if len > 0 {
                marks.push((
                    shndx,
                    MapMark {
                        at: at as u32,
                        len: 0,
                        class: MapClass::Data,
                        opens: true,
                    },
                ));
            }
        };
        data_start(SHIDX_DATA, 0, layout.plan.data_len);
        data_start(SHIDX_BSS, 0, layout.plan.bss_len);
        for k in 0..carve.table.entries.len() {
            let text_end = carve
                .text_ranges
                .iter()
                .filter(|r| r.entry == k)
                .map(|r| r.new_base + (r.old_hi - r.old_lo))
                .max()
                .unwrap_or(0);
            let attr = layout.attr_sizes.get(k).copied().unwrap_or(0);
            data_start(carve.shndx[k], text_end, attr.saturating_sub(text_end));
        }
        if let Some((e, base)) = layout.jt_placement {
            data_start(carve.shndx[e], base, build.rodata.bytes.len() as u64);
        }
        for (&(e, base), s) in layout.asm_placements.iter().zip(build.asm_sections.iter()) {
            marks.extend(s.map.shifted(base as u32).map(|m| (carve.shndx[e], m)));
        }
        marks.sort_by_key(|&(shndx, _)| shndx);
        let mut i = 0;
        while i < marks.len() {
            let shndx = marks[i].0;
            let j = i + marks[i..].partition_point(|&(s, _)| s == shndx);
            let mut group: Vec<MapMark> = marks[i..j].iter().map(|&(_, m)| m).collect();
            let (len, exec) = sec_shape.get(&shndx).copied().unwrap_or((0, false));
            for (at, class) in map_syms::fold(&mut group, len as usize, exec) {
                self.syms.push(Elf64Sym {
                    st_name: self.names.name_offs
                        [self.names.at.map + usize::from(class == MapClass::Data)],
                    st_info: pack_sym_info(STB_LOCAL, STT_NOTYPE),
                    st_shndx: shndx,
                    st_value: u64::from(at),
                    ..Default::default()
                });
            }
            i = j;
        }
    }

    /// Global (`.globl`) and weak (`.weak`) inline-asm section labels,
    /// main-stream labels a directive rebound, and assignments a directive
    /// of the unit bound.
    fn emit_global_asm_symbols(&mut self) -> Result<(), C5Error> {
        for j in 0..self.names.asm_labels.len() {
            let l = &self.names.asm_labels[j];
            if !(l.global || l.weak) {
                continue;
            }
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.asm_labels + j],
                st_info: pack_sym_info(if l.weak { STB_WEAK } else { STB_GLOBAL }, l.st_type),
                st_other: self.vis_for(l.name),
                st_shndx: l.shndx,
                st_value: l.value,
                st_size: l.st_size,
            };
            let name = l.name;
            let idx = self.syms.push(sym);
            self.syms.asm_label_symidx.insert(name, idx as u32);
        }
        for j in 0..self.names.asm_text_label_syms.len() {
            let l = &self.names.asm_text_label_syms[j];
            if l.bind == STB_LOCAL {
                continue;
            }
            let (shndx, value) = self.text_place(l.offset as u64);
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.asm_text_labels + j],
                st_info: pack_sym_info(l.bind, l.st_type),
                st_shndx: shndx,
                st_value: value,
                st_size: l.st_size,
                ..Default::default()
            };
            let name = l.name;
            let idx = self.syms.push(sym);
            self.syms.asm_label_symidx.insert(name, idx as u32);
        }
        for i in 0..self.names.asm_decl_set.len() {
            let (n, v) = &self.names.asm_decl_set[i];
            let bind = self.set_bind(n);
            if bind == STB_LOCAL {
                continue;
            }
            let (shndx, value, st_type, st_size) = self.set_place(v)?;
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.asm_decl_set + i],
                st_info: pack_sym_info(bind, st_type),
                st_other: self.vis_for(n),
                st_shndx: shndx,
                st_value: value,
                st_size,
            };
            let name = *n;
            let idx = self.syms.push(sym);
            self.syms.asm_label_symidx.insert(name, idx as u32);
        }
        Ok(())
    }

    /// `STB_GLOBAL` (or, for `__attribute__((weak))` definitions,
    /// `STB_WEAK`) function symbols.
    fn emit_global_function_symbols(&mut self) -> Result<(), C5Error> {
        for k in 0..self.names.global_func_idxs.len() {
            let i = self.names.global_func_idxs[k];
            let (lo, hi) = self.func_extent(i)?;
            let (shndx, value) = self.text_place(lo as u64);
            let name = &self.names.func_strs[i];
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.funcs + i],
                st_info: pack_sym_info(self.bind_for(name), STT_FUNC),
                st_other: self.vis_for(name),
                st_shndx: shndx,
                st_value: value,
                st_size: hi.saturating_sub(lo) as u64,
            };
            let idx = self.syms.push(sym);
            self.syms
                .func_symidx_by_name
                .insert(self.names.func_strs[i].clone(), idx as u32);
        }
        Ok(())
    }

    /// Import symbols: `STB_WEAK` + `STT_NOTYPE` + `SHN_UNDEF`, since the
    /// dynamic linker resolves them at load time and an unresolved entry at
    /// static-link time is not an error.
    fn emit_import_symbols(&mut self) {
        let build = self.build;
        for i in 0..build.imports.imports.len() {
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.imports + i],
                st_info: pack_sym_info(STB_WEAK, STT_NOTYPE),
                st_shndx: SHN_UNDEF,
                ..Default::default()
            };
            let idx = self.syms.push(sym);
            self.syms.import_sym_indices.push(idx as usize);
        }
        for i in 0..self.names.user_extern_names.len() {
            let name = self.names.user_extern_names[i];
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.user_extern + i],
                st_info: pack_sym_info(self.bind_for(name), STT_NOTYPE),
                st_other: self.vis_for(name),
                st_shndx: SHN_UNDEF,
                ..Default::default()
            };
            let idx = self.syms.push(sym);
            self.syms.user_extern_sym_idx.push(idx as usize);
        }
    }

    /// A reference to an assembler-local label resolves to the label's
    /// section plus its offset, not to the label symbol: gas reduces a
    /// relocation against a local non-function/object symbol that way, and
    /// readers of an object's metadata sections require the section+addend
    /// form.
    fn build_asm_label_refs(&mut self) {
        let mut secref: BTreeMap<&'a str, (u64, i64)> = BTreeMap::new();
        for l in &self.names.asm_labels {
            if l.global || l.weak || l.shndx == SHN_ABS || l.merge {
                continue;
            }
            if l.st_type != STT_NOTYPE && !self.asm_local_temp(l) {
                continue;
            }
            secref.insert(l.name, (l.sec_sym, l.value as i64));
        }
        for l in &self.names.asm_text_label_syms {
            if l.bind != STB_LOCAL || l.st_type != STT_NOTYPE {
                continue;
            }
            secref.insert(l.name, self.text_ref(l.offset as u64));
        }
        self.syms.asm_label_secref = secref;
    }

    /// Defined data globals as `STB_GLOBAL` + `STT_OBJECT` in `.data`, in
    /// `.bss` for a wholly-zero object, or in the named section the plan
    /// moved them to (C99 6.2.2: external-linkage objects surface by name).
    fn emit_data_symbols(&mut self) {
        for i in 0..self.names.defined_data_globals.len() {
            let (name, val, size) = self.names.defined_data_globals[i];
            let (shndx, value) = self.data_place(val);
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.data_globals + i],
                st_info: pack_sym_info(self.bind_for(name), STT_OBJECT),
                st_other: self.vis_for(name),
                st_shndx: shndx,
                st_value: value,
                st_size: size,
            };
            let idx = self.syms.push(sym);
            self.syms.defined_data_symidx.insert(name, idx);
        }
        for i in 0..self.names.user_extern_data_names.len() {
            let name = self.names.user_extern_data_names[i];
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.user_extern_data + i],
                st_info: pack_sym_info(self.bind_for(name), STT_NOTYPE),
                st_other: self.vis_for(name),
                st_shndx: SHN_UNDEF,
                ..Default::default()
            };
            let idx = self.syms.push(sym);
            self.syms.user_extern_data_sym_idx.push(idx as usize);
        }
    }

    /// Undefined symbols for inline-asm reloc targets no other table
    /// covers, for `.globl` names that surface nowhere else, for the
    /// unit-level `.globl` declarations naming nothing the unit defines,
    /// then the defined `_Thread_local` globals and the cross-unit `extern
    /// _Thread_local` imports as `STT_TLS`.
    fn emit_undefined_symbols(&mut self) {
        for i in 0..self.names.asm_extern_names.len() {
            let name = self.names.asm_extern_names[i];
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.asm_extern + i],
                st_info: pack_sym_info(self.bind_for(name), STT_NOTYPE),
                st_other: self.vis_for(name),
                st_shndx: SHN_UNDEF,
                ..Default::default()
            };
            let idx = self.syms.push(sym);
            self.syms.asm_extern_sym_idx.push(idx as usize);
        }
        for i in 0..self.names.asm_global_undef.len() {
            let name = self.names.asm_global_undef[i];
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.asm_global_undef + i],
                st_info: pack_sym_info(STB_GLOBAL, STT_NOTYPE),
                st_other: self.vis_for(name),
                st_shndx: SHN_UNDEF,
                ..Default::default()
            };
            self.syms.push(sym);
        }
        for i in 0..self.names.asm_decl_undef.len() {
            let d = self.names.asm_decl_undef[i];
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.asm_decl_undef + i],
                st_info: pack_sym_info(self.bind_for(&d.name), st_type_of(d.sym_type)),
                st_shndx: SHN_UNDEF,
                st_size: d.size.unwrap_or(0),
                ..Default::default()
            };
            self.syms.push(sym);
        }
        if self.elf_tls_interop {
            for i in 0..self.names.defined_tls_globals.len() {
                let (name, off, size) = self.names.defined_tls_globals[i];
                let (shndx, value) = self.tls_home(off);
                let sym = Elf64Sym {
                    st_name: self.names.name_offs[self.names.at.tls_globals + i],
                    st_info: pack_sym_info(STB_GLOBAL, STT_TLS),
                    st_shndx: shndx,
                    st_value: value as u64,
                    st_size: size,
                    ..Default::default()
                };
                let idx = self.syms.push(sym);
                self.syms.defined_tls_symidx.insert(name, idx);
            }
        }
        for i in 0..self.names.extern_tls_names.len() {
            let sym = Elf64Sym {
                st_name: self.names.name_offs[self.names.at.extern_tls + i],
                st_info: pack_sym_info(STB_GLOBAL, STT_TLS),
                st_shndx: SHN_UNDEF,
                ..Default::default()
            };
            let idx = self.syms.push(sym);
            self.syms.extern_tls_sym_idx.push(idx as usize);
        }
    }

    fn rtype_abs64(&self) -> u32 {
        match self.machine {
            Machine::X86_64 => R_X86_64_64,
            Machine::Aarch64 => R_AARCH64_ABS64,
        }
    }

    fn push_rela(table: &mut Vec<u8>, r_offset: u64, sym: u64, rtype: u32, r_addend: i64) {
        write_struct(
            table,
            &Elf64Rela {
                r_offset,
                r_info: (sym << 32) | rtype as u64,
                r_addend,
            },
        );
    }

    /// The symbol a cross-TU function name resolves against: a callee
    /// defined in this unit (a cross-named-section call) or an alias takes
    /// its defined symbol, an assembler label its own, and every other name
    /// the UNDEF entry.
    fn extern_fn_ref(&self, name: &str) -> (u64, i64) {
        match self.syms.func_symidx_by_name.get(name) {
            Some(&i) => (i as u64, 0),
            None => match self.asm_label_ref(name) {
                Some(pair) => pair,
                None => {
                    let pos = self
                        .names
                        .user_extern_names
                        .iter()
                        .position(|n| *n == name)
                        .expect("user_extern_names contains every extern callee");
                    (self.syms.user_extern_sym_idx[pos] as u64, 0)
                }
            },
        }
    }

    /// The UNDEF entry of a cross-TU data name.
    fn user_extern_data_sym(&self, name: &str) -> (u64, i64) {
        let pos = self
            .names
            .user_extern_data_names
            .iter()
            .position(|n| *n == name)
            .expect("user_extern_data_names contains every extern data name");
        (self.syms.user_extern_data_sym_idx[pos] as u64, 0)
    }

    /// `.rela.text` call sites.
    fn emit_call_relocs(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let machine = self.machine;
        let mut table: Vec<u8> = Vec::with_capacity(
            (build.reloc_call_sites.len()
                + build.user_extern_call_sites.len()
                + build.data_fixups.len() * 2
                + build.func_fixups.len() * 2)
                * ELF64_RELA_SIZE,
        );
        for site in &build.user_extern_call_sites {
            let (sym_idx, base) = self.extern_fn_ref(site.symbol_name.as_str());
            let (rtype, r_offset, r_addend) = match machine {
                Machine::X86_64 => (R_X86_64_PLT32, site.instr_offset as u64 + 1, base - 4),
                Machine::Aarch64 if site.is_tail => {
                    (R_AARCH64_JUMP26, site.instr_offset as u64, base)
                }
                Machine::Aarch64 => (R_AARCH64_CALL26, site.instr_offset as u64, base),
            };
            Self::push_rela(&mut table, r_offset, sym_idx, rtype, r_addend);
        }
        for site in &build.reloc_call_sites {
            let sym_idx = match self.syms.import_sym_indices.get(site.import_index) {
                Some(&i) => i as u64,
                None => {
                    return Err(Self::internal(format!(
                        "elf_reloc: reloc_call_sites[..].import_index {} out of range",
                        site.import_index,
                    )));
                }
            };
            if site.is_addr {
                if self.kernel_abs {
                    emit_abs32_ref_reloc(&mut table, site.instr_offset as u64, sym_idx, 0);
                } else {
                    emit_got_ref_relocs(machine, &mut table, site.instr_offset as u64, sym_idx);
                }
                continue;
            }
            let (rtype, r_offset, r_addend) = match machine {
                Machine::X86_64 => (R_X86_64_PLT32, site.instr_offset as u64 + 1, -4i64),
                Machine::Aarch64 if site.is_tail => (R_AARCH64_JUMP26, site.instr_offset as u64, 0),
                Machine::Aarch64 => (R_AARCH64_CALL26, site.instr_offset as u64, 0),
            };
            Self::push_rela(&mut table, r_offset, sym_idx, rtype, r_addend);
        }
        if self.elf_tls_interop {
            let tls_init_len = self.tls_init_len();
            for f in &build.elf_tpoff_fixups {
                let (sym_idx, r_addend) = match &f.target {
                    super::ElfTpoffTarget::Extern(name) => {
                        let pos = self
                            .names
                            .extern_tls_names
                            .iter()
                            .position(|n| *n == name.as_str())
                            .expect("extern_tls_names contains every fixup's symbol name");
                        (self.syms.extern_tls_sym_idx[pos] as u64, 0i64)
                    }
                    super::ElfTpoffTarget::Local(off) => {
                        let off = *off as i64;
                        if off >= tls_init_len {
                            (self.syms.tbss_sec_sym, off - tls_init_len)
                        } else {
                            (self.syms.tdata_sec_sym, off)
                        }
                    }
                };
                let at = f.imm_offset as u64;
                match machine {
                    Machine::X86_64 => {
                        Self::push_rela(&mut table, at, sym_idx, R_X86_64_TPOFF32, r_addend);
                    }
                    Machine::Aarch64 => {
                        Self::push_rela(
                            &mut table,
                            at,
                            sym_idx,
                            R_AARCH64_TLSLE_ADD_TPREL_HI12,
                            r_addend,
                        );
                        Self::push_rela(
                            &mut table,
                            at + 4,
                            sym_idx,
                            R_AARCH64_TLSLE_ADD_TPREL_LO12_NC,
                            r_addend,
                        );
                    }
                }
            }
        }
        self.relocs.text = table;
        Ok(())
    }

    /// Data-segment references (the codegen's `adrp + add` pair or `lea
    /// rip-rel disp32`) against the section symbol their home resolves to;
    /// switch-table base materializations against the table entry's section
    /// symbol; and the table's entry slots, one relocation per slot against
    /// `.text` (or a carved function's own section).
    fn emit_data_ref_relocs(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let machine = self.machine;
        let mut table = core::mem::take(&mut self.relocs.text);
        for fx in &build.data_fixups {
            let (sym, addend) = self.data_section_ref(fx.data_offset as i64);
            emit_addr_fixup_relocs(
                machine,
                &mut table,
                fx.instr_offset as u64,
                sym,
                addend,
                fx.part,
            )?;
        }
        for fx in &build.rodata.addr_fixups {
            let (e, base) = self.layout.jt_placement.ok_or_else(|| {
                Self::internal(String::from(
                    "elf_reloc: table fixup recorded without table bytes",
                ))
            })?;
            emit_addr_fixup_relocs(
                machine,
                &mut table,
                fx.code_offset as u64,
                self.layout.carve.sym_idx[e],
                base as i64 + fx.rodata_offset as i64,
                AddrPart::Whole,
            )?;
        }
        self.relocs.text = table;
        if let Some((e, base)) = self.layout.jt_placement {
            let (rtype_pcrel32, rtype_jt_abs64) = match machine {
                Machine::X86_64 => (R_X86_64_PC32, R_X86_64_64),
                Machine::Aarch64 => (R_AARCH64_PREL32, R_AARCH64_ABS64),
            };
            let rel32: Vec<(u64, i64, i64)> = build
                .rodata
                .rel32
                .iter()
                .map(|r| {
                    let (sym, target) = self.text_ref(r.text_offset);
                    let skew = r.slot_offset as i64 - r.base_offset as i64;
                    (sym, r.slot_offset as i64, target + skew)
                })
                .collect();
            let abs64: Vec<(u64, i64, i64)> = build
                .rodata
                .abs64
                .iter()
                .map(|r| {
                    let (sym, target) = self.text_ref(r.text_offset);
                    (sym, r.slot_offset as i64, target)
                })
                .collect();
            let ent = &mut self.layout.carve.table.entries[e];
            for (rtype, rows) in [(rtype_pcrel32, rel32), (rtype_jt_abs64, abs64)] {
                for (sym, slot, addend) in rows {
                    ent.relas.push(super::section_table::SectionRela {
                        offset: base + slot as u64,
                        sym,
                        rtype,
                        addend,
                    });
                }
            }
        }
        Ok(())
    }

    /// Cross-TU data references, per [`Self::extern_addr_form`]: a name
    /// this unit's assembly defines binds to that definition, as gas binds
    /// a reference within one unit, except that a GOT reference keeps the
    /// symbol (the slot is per symbol).
    fn emit_extern_ref_relocs(&mut self) -> Result<(), C5Error> {
        let (program, build) = (self.program, self.build);
        let machine = self.machine;
        let mut table = core::mem::take(&mut self.relocs.text);
        for r in &build.user_extern_data_refs {
            let name = r.symbol_name.as_str();
            let form = self.extern_addr_form(name);
            // An alias name resolves against its defined (weak) symbol; the
            // reference form stays symbolic so the linker's binding decides
            // which definition the address names.
            let alias_sym = program
                .function_aliases
                .iter()
                .any(|a| a.name == name)
                .then(|| self.syms.func_symidx_by_name.get(name).copied())
                .flatten();
            let (sym_idx, base) = match alias_sym {
                Some(i) => (i as u64, 0),
                None => match self.asm_label_ref(name) {
                    Some(_) if form == ExternAddrForm::Got => (
                        *self
                            .syms
                            .asm_label_symidx
                            .get(name)
                            .expect("a resolved asm label has a symbol")
                            as u64,
                        0,
                    ),
                    Some(pair) => pair,
                    None => match self.defined_data_ref(
                        name,
                        form == ExternAddrForm::Got && r.direct_pcrel.is_none(),
                    ) {
                        Some(pair) => pair,
                        None => self.user_extern_data_sym(name),
                    },
                },
            };
            if let Some(addend) = r.direct_pcrel {
                Self::push_rela(
                    &mut table,
                    r.instr_offset as u64 + 3,
                    sym_idx,
                    R_X86_64_PC32,
                    addend + base,
                );
                continue;
            }
            match form {
                ExternAddrForm::Got => {
                    emit_got_ref_relocs(machine, &mut table, r.instr_offset as u64, sym_idx)
                }
                ExternAddrForm::Abs32 => {
                    emit_abs32_ref_reloc(&mut table, r.instr_offset as u64, sym_idx, base)
                }
                ExternAddrForm::Direct => emit_addr_fixup_relocs(
                    machine,
                    &mut table,
                    r.instr_offset as u64,
                    sym_idx,
                    base,
                    AddrPart::Whole,
                )?,
            }
        }
        for fx in &build.func_fixups {
            emit_addr_fixup_relocs(
                machine,
                &mut table,
                fx.instr_offset as u64,
                self.syms.text_sym_idx,
                fx.target_native_offset as i64,
                fx.part,
            )?;
        }
        for r in &build.asm_section_text_refs {
            let (e, base) = self.layout.asm_placements[r.section_index];
            let sym = self.layout.carve.sym_idx[e];
            let addend = base as i64 + r.section_offset as i64 + r.addend;
            let rtype = match r.kind {
                crate::c5::asm::AsmRelocKind::Data => match machine {
                    Machine::X86_64 if r.absolute => R_X86_64_32S,
                    Machine::X86_64 => R_X86_64_PC32,
                    Machine::Aarch64 => R_AARCH64_PREL32,
                },
                kind => {
                    a64_insn_reloc_type(kind).expect("every instruction-field kind maps to a type")
                }
            };
            Self::push_rela(&mut table, r.instr_offset as u64, sym, rtype, addend);
        }
        for r in &build.asm_text_abs_refs {
            Self::push_rela(
                &mut table,
                r.field_offset as u64,
                self.syms.text_sym_idx,
                R_X86_64_32S,
                r.target_offset as i64,
            );
        }
        self.relocs.text = table;
        Ok(())
    }

    /// Where a name an inline-asm operand or section field references
    /// resolves: a dropped alias against its chain's end (its distance
    /// riding in the addend), else an asm label, a defined function, an
    /// external-linkage object's own symbol, an internal-linkage object as
    /// section + offset, or an undefined symbol.
    fn asm_symbol_ref(&self, what: &str, name: &str, addend: i64) -> Result<(u64, i64), C5Error> {
        let (name, alias_off) = self
            .names
            .undef_alias_end
            .get(name)
            .copied()
            .unwrap_or((name, 0));
        let (sym, base) = if let Some(pair) = self.asm_label_ref(name) {
            pair
        } else if let Some(&idx) = self.syms.func_symidx_by_name.get(name) {
            (idx as u64, 0)
        } else if let Some(&idx) = self.syms.defined_data_symidx.get(name) {
            (idx, 0)
        } else if let Some(val) = self.defined_data_by_name(name) {
            self.data_section_ref(val)
        } else if let Some(&idx) = self.syms.extern_symidx_by_name.get(name) {
            (idx as u64, 0)
        } else {
            return Err(Self::internal(alloc::format!(
                "elf_reloc: {what} names `{name}`, which reached no defined or undefined symbol"
            )));
        };
        Ok((sym, base + addend + alias_off))
    }

    /// Function-body inline-asm symbol-operand sites: one row per record at
    /// the instruction word, typed by the field kind.
    fn emit_asm_operand_relocs(&mut self) -> Result<(), C5Error> {
        use crate::c5::asm::AsmSectionTarget;
        let build = self.build;
        let names = &self.names;
        let syms = &mut self.syms;
        for (list, idx) in [
            (&names.user_extern_names, &syms.user_extern_sym_idx),
            (
                &names.user_extern_data_names,
                &syms.user_extern_data_sym_idx,
            ),
            (&names.asm_extern_names, &syms.asm_extern_sym_idx),
        ] {
            for (k, &n) in list.iter().enumerate() {
                syms.extern_symidx_by_name.insert(n, idx[k]);
            }
        }
        let mut table = core::mem::take(&mut self.relocs.text);
        for r in &build.asm_sym_fixups {
            let (sym_idx, addend) = match &r.target {
                AsmSectionTarget::Data(off) => self.home_sym(
                    self.layout
                        .plan
                        .map_ref(off.wrapping_add_signed(r.addend), *off),
                ),
                AsmSectionTarget::Symbol(name) => {
                    self.asm_symbol_ref("asm operand relocation", name, r.addend)?
                }
                other => {
                    return Err(Self::internal(alloc::format!(
                        "elf_reloc: asm operand relocation target {other:?} is not a \
                         data offset or symbol"
                    )));
                }
            };
            let x86_jump = matches!(r.kind, crate::c5::asm::AsmRelocKind::JumpRel)
                && self.machine == Machine::X86_64;
            let rtype = match a64_insn_reloc_type(r.kind) {
                Some(t) => t,
                None if x86_jump
                    && r.addend == -4
                    && !self.syms.fixed_section_syms.contains(&sym_idx)
                    && !self.layout.carve.sym_idx.contains(&sym_idx) =>
                {
                    R_X86_64_PLT32
                }
                None if x86_jump => R_X86_64_PC32,
                None => {
                    return Err(Self::internal(alloc::format!(
                        "elf_reloc: asm operand relocation kind {:?} names no field type",
                        r.kind
                    )));
                }
            };
            Self::push_rela(&mut table, r.instr_offset as u64, sym_idx, rtype, addend);
        }
        carve_partition_relas(&mut table, &mut self.layout.carve, self.syms.text_sym_idx);
        self.relocs.text = table;
        Ok(())
    }

    /// The relocation type of an inline-asm section data field.
    fn asm_data_reloc_type(
        &self,
        r: &crate::c5::asm::AsmSectionReloc,
        section_sym: bool,
        section_name: &str,
    ) -> Result<u32, C5Error> {
        Ok(match (self.abi, r.pcrel, r.width) {
            (RelocAbi::X86_64, true, 4)
                if r.branch && !section_sym && r.addend == -(r.width as i64) =>
            {
                R_X86_64_PLT32
            }
            (RelocAbi::X86_64, false, 8) => R_X86_64_64,
            (RelocAbi::X86_64, false, 4) if r.signed => R_X86_64_32S,
            (RelocAbi::X86_64, false, 2) => R_X86_64_16,
            (RelocAbi::X86_64, false, 1) => R_X86_64_8,
            (RelocAbi::X86_64, false, _) => R_X86_64_32,
            (RelocAbi::X86_64, true, 8) => R_X86_64_PC64,
            (RelocAbi::X86_64, true, 2) => R_X86_64_PC16,
            (RelocAbi::X86_64, true, 1) => R_X86_64_PC8,
            (RelocAbi::X86_64, true, _) => R_X86_64_PC32,
            (RelocAbi::I386, _, 8) => {
                return Err(asm_section_err(
                    section_name,
                    "needs an 8-byte relocation, which the i386 psABI has none of",
                ));
            }
            (RelocAbi::I386, true, 4) if r.branch => R_386_PLT32,
            (RelocAbi::I386, false, 2) => R_386_16,
            (RelocAbi::I386, false, 1) => R_386_8,
            (RelocAbi::I386, false, _) => R_386_32,
            (RelocAbi::I386, true, 2) => R_386_PC16,
            (RelocAbi::I386, true, 1) => R_386_PC8,
            (RelocAbi::I386, true, _) => R_386_PC32,
            (RelocAbi::Aarch64, false, 8) => R_AARCH64_ABS64,
            (RelocAbi::Aarch64, false, _) => R_AARCH64_ABS32,
            (RelocAbi::Aarch64, true, 8) => R_AARCH64_PREL64,
            (RelocAbi::Aarch64, true, _) => R_AARCH64_PREL32,
        })
    }

    /// Inline-asm section relocations join the owning table entry, offset
    /// by the block's placement base.
    fn emit_asm_section_relocs(&mut self) -> Result<(), C5Error> {
        use crate::c5::asm::{AsmRelocKind as RK, AsmSectionTarget};
        let build = self.build;
        // The STT_SECTION symbols a reduction can land on; a branch against
        // one names no function, so no PLT slot can carry it.
        let section_syms: BTreeSet<u64> = self
            .syms
            .fixed_section_syms
            .clone()
            .chain(self.layout.carve.sym_idx.iter().copied())
            .collect();
        for i in 0..self.layout.asm_placements.len() {
            let (e, base) = self.layout.asm_placements[i];
            let s = &build.asm_sections[i];
            for r in &s.relocs {
                let (sym_idx, addend) = match &r.target {
                    AsmSectionTarget::Text(off) => {
                        let (sym, off) = self.text_ref(*off as u64);
                        (sym, off + r.addend)
                    }
                    AsmSectionTarget::Data(off) => {
                        let (sym, o) = self.home_sym(self.layout.plan.map(*off));
                        (sym, o + r.addend)
                    }
                    AsmSectionTarget::OwnSection(off) => (
                        self.layout.carve.sym_idx[e],
                        base as i64 + *off as i64 + r.addend,
                    ),
                    AsmSectionTarget::SectionStart(key) => {
                        let at = build
                            .asm_sections
                            .iter()
                            .position(|s| crate::c5::asm::section_key_of(s) == *key)
                            .ok_or_else(|| {
                                Self::internal(alloc::format!(
                                    "elf_reloc: asm relocation names section `{key}`, \
                                     which the unit does not define"
                                ))
                            })?;
                        let (te, tbase) = self.layout.asm_placements[at];
                        (self.layout.carve.sym_idx[te], tbase as i64 + r.addend)
                    }
                    AsmSectionTarget::TextBlock(_) => {
                        return Err(Self::internal(String::from(
                            "elf_reloc: unresolved asm-goto section relocation",
                        )));
                    }
                    AsmSectionTarget::DeferredText { .. } => {
                        return Err(Self::internal(String::from(
                            "elf_reloc: unresolved deferred-replacement section relocation",
                        )));
                    }
                    AsmSectionTarget::Expr(_) => {
                        return Err(Self::internal(String::from(
                            "elf_reloc: unresolved operand-expression section relocation",
                        )));
                    }
                    AsmSectionTarget::Symbol(name) => {
                        self.asm_symbol_ref("asm relocation", name, r.addend)?
                    }
                };
                let rtype = match r.kind {
                    RK::Data | RK::JumpRel => self.asm_data_reloc_type(
                        r,
                        section_syms.contains(&sym_idx),
                        self.layout.carve.table.entries[e].name.as_str(),
                    )?,
                    kind => a64_insn_reloc_type(kind)
                        .expect("every instruction-field kind maps to a type"),
                };
                self.layout.carve.table.entries[e]
                    .relas
                    .push(super::section_table::SectionRela {
                        offset: base + r.offset as u64,
                        sym: sym_idx,
                        rtype,
                        addend,
                    });
            }
        }
        Ok(())
    }

    /// A `.rela.data` row, or the named section's own list when the plan
    /// moved the slot there.
    fn push_data_row(&mut self, slot: u64, sym: u64, addend: i64) {
        let rtype = self.rtype_abs64();
        match self.layout.plan.map(slot) {
            DataHome::Named(e, off) => {
                self.layout.carve.table.entries[e]
                    .relas
                    .push(super::section_table::SectionRela {
                        offset: off,
                        sym,
                        rtype,
                        addend,
                    });
            }
            home => {
                let r_offset = match home {
                    DataHome::Data(o) => o,
                    _ => slot,
                };
                Self::push_rela(&mut self.relocs.data, r_offset, sym, rtype, addend);
            }
        }
    }

    /// `.rela.data`: absolute 64-bit relocations for pointer-to-global
    /// initializers against the section symbol the target's home resolves
    /// to (the target maps through its object anchor so a one-past-the-end
    /// address follows its object); pointer-to-extern-data initializers
    /// against the named undefined-data symbol with the byte offset as
    /// addend; label-address and function-pointer initializers against
    /// `.text` (or the named section the carve moved the function to), the
    /// addend being the target's offset within the section.
    fn emit_data_relocs(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        self.relocs.data = Vec::with_capacity(
            (build.data_relocs.len() + build.code_relocs.len()) * ELF64_RELA_SIZE,
        );
        for r in &build.data_relocs {
            let (sym, addend) =
                self.home_sym(self.layout.plan.map_ref(r.target_offset, r.target_anchor));
            self.push_data_row(r.data_offset, sym, addend);
        }
        for r in &build.extern_data_relocs {
            let name = r.symbol_name.as_str();
            let (sym_idx, base) = self.extern_data_ref(name);
            self.push_data_row(r.data_offset, sym_idx, base + r.addend);
        }
        for r in &build.label_relocs {
            let (sym, addend) = self.text_ref(r.text_offset);
            self.push_data_row(r.data_offset, sym, addend);
        }
        for r in &build.code_relocs {
            let (sym, addend) = self.code_reloc_ref(r.target_ent_pc as usize)?;
            self.push_data_row(r.data_offset, sym, addend);
        }
        Ok(())
    }

    /// A pointer-to-extern-data initializer's symbol: an assembler label of
    /// the unit, an alias's own symbol (as a call through one does), a
    /// defined object, else the UNDEF.
    fn extern_data_ref(&self, name: &str) -> (u64, i64) {
        let alias_sym = self
            .defines_alias(name)
            .then(|| self.syms.func_symidx_by_name.get(name).copied())
            .flatten();
        match (self.asm_label_ref(name), alias_sym) {
            (Some(pair), _) => pair,
            (None, Some(idx)) => (idx as u64, 0),
            (None, None) => match self.defined_data_ref(name, false) {
                Some(pair) => pair,
                None => self.user_extern_data_sym(name),
            },
        }
    }

    /// A function-pointer initializer's target: a cross-TU function
    /// (placeholder `ent_pc` past `text.len()`) resolves by name with a
    /// zero addend, a function of the unit by its native offset.
    fn code_reloc_ref(&self, ent_pc: usize) -> Result<(u64, i64), C5Error> {
        if let Some(&name) = self.names.extern_fn_by_pc.get(&ent_pc) {
            return Ok(self.extern_fn_ref(name));
        }
        let native_off = self
            .build
            .pc_to_native
            .get(ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if native_off == usize::MAX {
            return Err(Self::internal(format!(
                "elf_reloc: code reloc references missing ent_pc {ent_pc}",
            )));
        }
        Ok(self.text_ref(native_off as u64))
    }

    /// `.rela.tdata`: address-constant initializers of `_Thread_local`
    /// objects, the `.rela.data` shape over a `.tdata` slot, which the
    /// named-section carve never claims.
    fn emit_tdata_relocs(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let rtype = self.rtype_abs64();
        let mut table: Vec<u8> = Vec::new();
        for r in &build.tls_data_relocs {
            let (sym, addend) =
                self.home_sym(self.layout.plan.map_ref(r.target_offset, r.target_anchor));
            Self::push_rela(&mut table, r.data_offset, sym, rtype, addend);
        }
        for r in &build.tls_extern_data_relocs {
            let name = r.symbol_name.as_str();
            let (sym_idx, base) = match self.asm_label_ref(name) {
                Some(pair) => pair,
                None => match self.defined_data_ref(name, false) {
                    Some(pair) => pair,
                    None => self.user_extern_data_sym(name),
                },
            };
            Self::push_rela(&mut table, r.data_offset, sym_idx, rtype, base + r.addend);
        }
        for r in &build.tls_code_relocs {
            let ent_pc = r.target_ent_pc as usize;
            let (sym, addend) = if let Some(&name) = self.names.extern_fn_by_pc.get(&ent_pc) {
                self.extern_fn_ref(name)
            } else {
                let Some(&native_off) = build.pc_to_native.get(ent_pc) else {
                    return Err(Self::internal(format!(
                        "elf_reloc: TLS code reloc references missing ent_pc {ent_pc}"
                    )));
                };
                self.text_ref(native_off as u64)
            };
            Self::push_rela(&mut table, r.data_offset, sym, rtype, addend);
        }
        self.relocs.tdata = table;
        Ok(())
    }

    /// `.init_array` / `.fini_array` groups (GNU practice: each
    /// `__attribute__((constructor))` becomes an `SHT_INIT_ARRAY` pointer,
    /// a priority riding in the section name so a system linker's
    /// `SORT_BY_INIT_PRIORITY` orders across units), the per-function
    /// `__patchable_function_entries`, and `__mcount_loc`.
    fn build_tail_sections(&mut self) -> Result<(), C5Error> {
        let rtype = self.rtype_abs64();
        let mut tail = build_init_array_sections(
            &self.program.init_funcs,
            &self.syms.func_symidx_by_name,
            rtype,
        )?;
        tail.extend(build_patchable_entry_sections(
            self.build,
            &self.layout.carve,
            self.syms.text_sym_idx,
            SHIDX_TEXT,
            rtype,
        ));
        tail.extend(build_mcount_loc_section(
            self.build,
            &self.layout.carve,
            self.syms.text_sym_idx,
            SHIDX_TEXT,
            rtype,
        ));
        self.relocs.tail_sections = tail;
        Ok(())
    }

    /// `DW_OP_addr` in a variable's location names the object by its link
    /// name; both linkage classes carry a symbol-table entry, and an
    /// inline-asm label may have claimed the name first.
    fn dwarf_obj_sym_idx(&self, name: &str) -> Option<u64> {
        let syms = &self.syms;
        syms.defined_data_symidx
            .get(name)
            .copied()
            .or_else(|| syms.defined_data_local_symidx.get(name).copied())
            .or_else(|| syms.asm_label_symidx.get(name).map(|&i| i as u64))
            .or_else(|| syms.defined_tls_symidx.get(name).copied())
    }

    /// The DWARF triple, whose address slots are placeholders paired with
    /// `DwarfReloc` records translated here into the `.rela.debug_*`
    /// tables.
    fn emit_debug_relocs(&mut self) -> Result<(), C5Error> {
        let (program, build) = (self.program, self.build);
        let dwarf = if build.debug_info {
            dwarf_reloc::emit(
                program,
                build,
                program.source_path.as_str(),
                self.machine,
                self.target,
            )
        } else {
            dwarf_reloc::DwarfRelocatable::default()
        };
        let section_syms = DwarfSectionSyms {
            text: self.syms.text_sym_idx,
            line: self.syms.debug_line_sym_idx,
            abbrev: self.syms.debug_abbrev_sym_idx,
            strs: self.syms.debug_str_sym_idx,
        };
        let obj_sym = |name: &str| self.dwarf_obj_sym_idx(name);
        let mut tables: [Vec<u8>; 2] = [Vec::new(), Vec::new()];
        for (relocs, table) in [&dwarf.info_relocs, &dwarf.line_relocs]
            .into_iter()
            .zip(tables.iter_mut())
        {
            table.reserve(relocs.len() * ELF64_RELA_SIZE);
            for r in relocs {
                if let Some(rela) = dwarf_reloc_to_elf_rela(
                    r,
                    self.abi,
                    section_syms,
                    &dwarf.reloc_symbols,
                    &obj_sym,
                )? {
                    write_struct(table, &rela);
                }
            }
        }
        let [debug_info, debug_line] = tables;
        self.relocs.dwarf = dwarf;
        self.relocs.debug_info = debug_info;
        self.relocs.debug_line = debug_line;
        Ok(())
    }

    /// The code generator's tables name x86-64 / aarch64 instructions, and
    /// the driver admits only assembled units to ELFCLASS32; an entry there
    /// means an i386 code generator arrived without the numbering
    /// (`R_X86_64_64` and `R_386_32` share the number 1).
    fn drop_unreferenced_section_symbols(&mut self) -> Result<(), C5Error> {
        let relocs = &mut self.relocs;
        if self.class.is32()
            && !(relocs.text.is_empty()
                && relocs.data.is_empty()
                && relocs.tail_sections.is_empty())
        {
            return Err(C5Error::hard(
                Code::OBJECT_FORMAT,
                "badc generates no 32-bit machine code; an ELFCLASS32 object carries \
                 assembled sections and debug info only",
            ));
        }
        if !matches!(self.abi, RelocAbi::X86_64 | RelocAbi::I386) {
            return Ok(());
        }
        let syms = &mut self.syms;
        let carve = &mut self.layout.carve;
        let mut used = alloc::vec![false; syms.symbols.len()];
        let mark = |used: &mut Vec<bool>, table: &[u8]| {
            for rec in table.as_chunks::<ELF64_RELA_SIZE>().0.iter() {
                let info = u64::from_le_bytes(rec[8..16].try_into().unwrap());
                if let Some(u) = used.get_mut((info >> 32) as usize) {
                    *u = true;
                }
            }
        };
        for table in [
            &relocs.text,
            &relocs.data,
            &relocs.debug_info,
            &relocs.debug_line,
            &relocs.tdata,
        ] {
            mark(&mut used, table);
        }
        for s in &relocs.tail_sections {
            mark(&mut used, &s.rela);
        }
        for e in &carve.table.entries {
            for r in &e.relas {
                if let Some(u) = used.get_mut(r.sym as usize) {
                    *u = true;
                }
            }
        }
        let mut remap: Vec<u64> = Vec::with_capacity(syms.symbols.len());
        let mut kept: Vec<Elf64Sym> = Vec::with_capacity(syms.symbols.len());
        for (i, s) in syms.symbols.iter().enumerate() {
            remap.push(kept.len() as u64);
            if s.st_info & 0xf != STT_SECTION || used[i] {
                kept.push(*s);
            }
        }
        if kept.len() == syms.symbols.len() {
            return Ok(());
        }
        syms.first_global -= (syms.symbols.len() - kept.len()) as u32;
        syms.symbols = kept;
        let rewrite = |table: &mut [u8]| {
            for rec in table.as_chunks_mut::<ELF64_RELA_SIZE>().0.iter_mut() {
                let info = u64::from_le_bytes(rec[8..16].try_into().unwrap());
                let ns = remap[(info >> 32) as usize];
                rec[8..16].copy_from_slice(&((ns << 32) | (info & 0xffff_ffff)).to_le_bytes());
            }
        };
        for table in [
            &mut relocs.text,
            &mut relocs.data,
            &mut relocs.debug_info,
            &mut relocs.debug_line,
            &mut relocs.tdata,
        ] {
            rewrite(table);
        }
        for s in &mut relocs.tail_sections {
            rewrite(&mut s.rela);
        }
        for e in &mut carve.table.entries {
            for r in &mut e.relas {
                r.sym = remap[r.sym as usize];
            }
        }
        Ok(())
    }

    /// Every relocation table of the fixed set is final here.
    fn plan_sections(&mut self) {
        let (program, build) = (self.program, self.build);
        let no_dwarf = !build.debug_info;
        // Built ahead of the section count: an empty body drops the
        // section, which the note parser reads as it does a foreign object
        // carrying none.
        let note = build_badc_note(
            &build.imports,
            &program.exports,
            &build.tls_index_fixups,
            &build.macho_tlv_descriptors,
            &build.macho_tlv_fixups,
            &self.names.defined_tls_globals,
            &build.elf_tpoff_fixups,
            &self.syms.prologue_end_pairs,
            &self.names.user_extern_data_names,
        );
        let (layout, relocs) = (&self.layout, &self.relocs);
        let mut shndx = ShndxMap {
            fixed_dropped: [
                (SHIDX_TEXT, layout.text_shadowed),
                (SHIDX_RELA_TEXT, relocs.text.is_empty()),
                (SHIDX_DATA, layout.data_shadowed),
                (SHIDX_BSS, layout.bss_shadowed),
                (SHIDX_RELA_DATA, relocs.data.is_empty()),
                (SHIDX_NOTE_BADC, note.is_empty()),
                (SHIDX_DEBUG_INFO, no_dwarf),
                (SHIDX_RELA_DEBUG_INFO, relocs.debug_info.is_empty()),
                (SHIDX_DEBUG_ABBREV, no_dwarf),
                (SHIDX_DEBUG_LINE, no_dwarf),
                (SHIDX_RELA_DEBUG_LINE, relocs.debug_line.is_empty()),
                (SHIDX_DEBUG_STR, no_dwarf),
                (SHIDX_RELA_TDATA, relocs.tdata.is_empty()),
            ],
            base_sections: self.base_sections as u16,
            dropped_sections: 0,
        };
        shndx.dropped_sections = shndx.dropped_below(self.base_sections as u16);
        for s in &mut self.syms.symbols {
            s.st_shndx = shndx.map(s.st_shndx);
        }
        for x in &mut self.layout.carve.shndx {
            *x = shndx.map(*x);
        }
        let mut strings: Vec<&str> = Vec::new();
        if !program.asm_unit {
            strings.push(crate::OUTPUT_MARKER);
        }
        strings.extend(program.asm_idents.iter().map(|s| s.as_str()));
        let comment = (!strings.is_empty()).then(|| {
            let mut body: Vec<u8> = alloc::vec![0];
            for s in &strings {
                body.extend_from_slice(s.as_bytes());
                body.push(0);
            }
            body
        });
        let named_rela_count = self
            .layout
            .carve
            .table
            .entries
            .iter()
            .filter(|e| !e.relas.is_empty())
            .count();
        let out = &mut self.out;
        out.count = self.base_sections - shndx.dropped_sections as usize
            + self.layout.carve.table.entries.len()
            + named_rela_count
            + 2 * self.relocs.tail_sections.len()
            + usize::from(comment.is_some());
        out.note = note;
        out.shndx = shndx;
        out.comment = comment;
        out.bytes = alloc::vec![0u8; self.class.ehdr_size() as usize];
        out.sh.push(Elf64Shdr::default());
    }

    /// The section name table: one entry per non-null section in section
    /// order, so the name of section `n` sits at `shndx.map(n) - 1`.
    fn build_shstrtab(&mut self) {
        let rp = reloc_prefix(self.class);
        let fixed_names: [String; 15] = [
            ".text".to_string(),
            format!("{rp}.text"),
            ".data".to_string(),
            ".bss".to_string(),
            ".symtab".to_string(),
            ".strtab".to_string(),
            ".shstrtab".to_string(),
            format!("{rp}.data"),
            ".note.badc".to_string(),
            ".debug_info".to_string(),
            format!("{rp}.debug_info"),
            ".debug_abbrev".to_string(),
            ".debug_line".to_string(),
            format!("{rp}.debug_line"),
            ".debug_str".to_string(),
        ];
        let out = &mut self.out;
        let mut names: Vec<String> = Vec::with_capacity(out.count);
        for (i, name) in fixed_names.iter().enumerate() {
            if !out.shndx.is_dropped(i as u16 + 1) {
                names.push(name.clone());
            }
        }
        if self.has_tls {
            names.push(".tdata".to_string());
            names.push(".tbss".to_string());
        }
        if !self.relocs.tdata.is_empty() {
            names.push(format!("{rp}.tdata"));
        }
        let entries = &self.layout.carve.table.entries;
        out.named_names_start = names.len();
        names.extend(entries.iter().map(|e| e.name.clone()));
        out.named_rela_names_start = names.len();
        out.named_rela_pos = Vec::with_capacity(entries.len());
        for e in entries {
            out.named_rela_pos
                .push(names.len() - out.named_rela_names_start);
            if !e.relas.is_empty() {
                names.push(format!("{rp}{}", e.name));
            }
        }
        let mut seen: BTreeMap<String, usize> = BTreeMap::new();
        for s in &self.relocs.tail_sections {
            let mut idx_of = |name: String| -> usize {
                *seen.entry(name.clone()).or_insert_with(|| {
                    names.push(name);
                    names.len() - 1
                })
            };
            let name_idx = idx_of(s.name.clone());
            let rela_idx = idx_of(format!("{rp}{}", s.name));
            out.tail_name_idx.push((name_idx, rela_idx));
        }
        out.comment_name_idx = names.len();
        if out.comment.is_some() {
            names.push(".comment".to_string());
        }
        let refs: Vec<&str> = names.iter().map(|n| n.as_str()).collect();
        let (bytes, offs) = build_string_table(&refs);
        out.shstrtab = bytes;
        out.shstrtab_offs = offs;
    }

    /// `.text`, with the extern materializations rewritten to match the
    /// relocations emitted for them (GOT loads, or `mov reg, $sym` under
    /// the x86-64 kernel model; a `direct_pcrel` reference is already a
    /// `mov` / `op sym(%rip)`), the named-section function groups carved
    /// out of the tail, and `.rela.text`.
    fn emit_text_section(&mut self) -> Result<(), C5Error> {
        let build = self.build;
        let mut got_sites: Vec<usize> = Vec::new();
        let mut abs_sites: Vec<usize> = Vec::new();
        for r in &build.user_extern_data_refs {
            if r.direct_pcrel.is_some() {
                continue;
            }
            match self.extern_addr_form(r.symbol_name.as_str()) {
                ExternAddrForm::Got => got_sites.push(r.instr_offset),
                ExternAddrForm::Abs32 => abs_sites.push(r.instr_offset),
                ExternAddrForm::Direct => {}
            }
        }
        for s in build.reloc_call_sites.iter().filter(|s| s.is_addr) {
            if self.kernel_abs {
                abs_sites.push(s.instr_offset);
            } else {
                got_sites.push(s.instr_offset);
            }
        }
        let mut text_body =
            rewrite_extern_addr_loads_to_got(self.machine, &build.text, &got_sites)?;
        rewrite_extern_addr_loads_to_abs32(&mut text_body, &abs_sites);
        let carve = &mut self.layout.carve;
        if !carve.text_ranges.is_empty() {
            for r in &carve.text_ranges {
                let ent = &mut carve.table.entries[r.entry];
                if (ent.bytes.len() as u64) < r.new_base {
                    ent.bytes.resize(r.new_base as usize, 0);
                }
                ent.bytes
                    .extend_from_slice(&text_body[r.old_lo as usize..r.old_hi as usize]);
            }
            let carve_hi = carve
                .text_ranges
                .last()
                .map(|r| r.old_hi as usize)
                .unwrap_or(0);
            text_body.drain(carve.text_keep_len..carve_hi);
        }
        fold_rel_addends(self.class, &self.relocs.text, &mut text_body)?;
        if !self.layout.text_shadowed {
            // An empty section constrains nothing; GNU as leaves the
            // default sections it creates at alignment 1.
            let text_align = if text_body.is_empty() {
                1
            } else {
                build.text_align.max(16) as u64
            };
            let shdr = Elf64Shdr {
                sh_name: self.out.fixed_name(SHIDX_TEXT),
                sh_type: SHT_PROGBITS,
                sh_flags: SHF_ALLOC | SHF_EXECINSTR,
                sh_addralign: text_align,
                ..Default::default()
            };
            self.out.place(shdr, &text_body);
        }
        if !self.relocs.text.is_empty() {
            let name = self.out.fixed_name(SHIDX_RELA_TEXT);
            let info = self.out.shndx.map(SHIDX_TEXT) as u32;
            self.out
                .place_rela(self.class, name, &self.relocs.text, info);
        }
        Ok(())
    }

    /// `.data` and `.bss`, plus the bytes of every table entry the data
    /// plan and the writer's placements feed.
    fn emit_data_sections(&mut self) -> Result<(), C5Error> {
        let (program, build) = (self.program, self.build);
        let mut data_src = build.data.clone();
        for off in relocated_data_offsets(program, &build.label_relocs) {
            let off = off as usize;
            let Some(slot) = data_src.get_mut(off..off + 8) else {
                return Err(Self::internal(format!(
                    "elf_reloc: relocated slot {off:#x} past end of .data ({})",
                    build.data.len(),
                )));
            };
            slot.fill(0);
        }
        let layout = &mut self.layout;
        let plan = &layout.plan;
        let carve = &mut layout.carve;
        let data_body: Vec<u8> = if plan.spans.is_empty() {
            data_src
        } else {
            let mut body = alloc::vec![0u8; plan.data_len as usize];
            for s in &plan.spans {
                if s.pad {
                    continue;
                }
                let file_lo = (s.old_lo as usize).min(data_src.len());
                let file_hi = (s.old_hi as usize).min(data_src.len());
                match s.home {
                    DataHome::Data(b) => {
                        let b = b as usize;
                        body[b..b + (file_hi - file_lo)]
                            .copy_from_slice(&data_src[file_lo..file_hi]);
                    }
                    DataHome::Named(e, b) => {
                        let ent = &mut carve.table.entries[e];
                        let b = b as usize;
                        let size = (s.old_hi - s.old_lo) as usize;
                        if ent.bytes.len() < b + size {
                            ent.bytes.resize(b + size, 0);
                        }
                        ent.bytes[b..b + (file_hi - file_lo)]
                            .copy_from_slice(&data_src[file_lo..file_hi]);
                    }
                    DataHome::Bss(_) => {}
                }
            }
            body
        };
        let append_at = |ent: &mut super::section_table::SectionSpec, base: u64, bytes: &[u8]| {
            if (ent.bytes.len() as u64) < base {
                ent.bytes.resize(base as usize, 0);
            }
            ent.bytes.extend_from_slice(bytes);
        };
        for (&(e, base), s) in layout.asm_placements.iter().zip(build.asm_sections.iter()) {
            append_at(&mut carve.table.entries[e], base, &s.bytes);
        }
        if let Some((e, base, body)) = &layout.gnu_property_note {
            append_at(&mut carve.table.entries[*e], *base, body);
        }
        // The table slots stay zero; the entry's relocations carry the
        // values.
        if let Some((e, base)) = layout.jt_placement {
            append_at(&mut carve.table.entries[e], base, &build.rodata.bytes);
        }
        if !layout.data_shadowed {
            let data_align = if data_body.is_empty() {
                1
            } else {
                plan.data_align
            };
            let shdr = Elf64Shdr {
                sh_name: self.out.fixed_name(SHIDX_DATA),
                sh_type: SHT_PROGBITS,
                sh_flags: SHF_ALLOC | SHF_WRITE,
                sh_addralign: data_align,
                ..Default::default()
            };
            self.out.place(shdr, &data_body);
        }
        // The linker zero-fills `.bss`; its alignment covers the zero-init
        // objects the plan keeps in it.
        if !layout.bss_shadowed {
            let shdr = Elf64Shdr {
                sh_name: self.out.fixed_name(SHIDX_BSS),
                sh_type: SHT_NOBITS,
                sh_flags: SHF_ALLOC | SHF_WRITE,
                sh_addralign: if plan.bss_len == 0 { 1 } else { plan.bss_align },
                ..Default::default()
            };
            self.out.place_nobits(shdr, plan.bss_len);
        }
        Ok(())
    }

    /// `.symtab` (serialized last of all, so every `st_shndx` is
    /// compacted), `.strtab`, `.shstrtab` and `.rela.data`.
    fn emit_table_sections(&mut self) {
        let class = self.class;
        let mut symtab: Vec<u8> =
            Vec::with_capacity(self.syms.symbols.len() * class.sym_size() as usize);
        for s in &self.syms.symbols {
            write_sym(class, s, &mut symtab);
        }
        let out = &mut self.out;
        out.place(
            Elf64Shdr {
                sh_name: out.fixed_name(SHIDX_SYMTAB),
                sh_type: SHT_SYMTAB,
                sh_link: out.shndx.map(SHIDX_STRTAB) as u32,
                sh_info: self.syms.first_global,
                sh_addralign: 8,
                sh_entsize: class.sym_size(),
                ..Default::default()
            },
            &symtab,
        );
        out.place(
            Elf64Shdr {
                sh_name: out.fixed_name(SHIDX_STRTAB),
                sh_type: SHT_STRTAB,
                sh_addralign: 1,
                ..Default::default()
            },
            &self.names.strtab,
        );
        let shstrtab = core::mem::take(&mut out.shstrtab);
        out.place(
            Elf64Shdr {
                sh_name: out.fixed_name(SHIDX_SHSTRTAB),
                sh_type: SHT_STRTAB,
                sh_addralign: 1,
                ..Default::default()
            },
            &shstrtab,
        );
        if !self.relocs.data.is_empty() {
            let name = out.fixed_name(SHIDX_RELA_DATA);
            let info = out.shndx.map(SHIDX_DATA) as u32;
            out.place_rela(class, name, &self.relocs.data, info);
        }
    }

    /// `.note.badc` (standard ELF tooling ignores unknown note types; the
    /// badc reader picks the records up by name + type) and, under `-g`,
    /// the DWARF sections with their relocation tables.
    fn emit_note_and_debug_sections(&mut self) {
        let class = self.class;
        let out = &mut self.out;
        if !out.note.is_empty() {
            let note = core::mem::take(&mut out.note);
            out.place(
                Elf64Shdr {
                    sh_name: out.fixed_name(SHIDX_NOTE_BADC),
                    sh_type: SHT_NOTE,
                    sh_addralign: 4,
                    ..Default::default()
                },
                &note,
            );
        }
        let dwarf = &self.relocs.dwarf;
        let progbits = |sh_name: u32| Elf64Shdr {
            sh_name,
            sh_type: SHT_PROGBITS,
            sh_addralign: 1,
            ..Default::default()
        };
        let emit_dwarf = self.build.debug_info;
        if emit_dwarf {
            out.place(
                progbits(out.fixed_name(SHIDX_DEBUG_INFO)),
                &dwarf.debug_info,
            );
        }
        if !self.relocs.debug_info.is_empty() {
            let name = out.fixed_name(SHIDX_RELA_DEBUG_INFO);
            let info = out.shndx.map(SHIDX_DEBUG_INFO) as u32;
            out.place_rela(class, name, &self.relocs.debug_info, info);
        }
        if emit_dwarf {
            out.place(
                progbits(out.fixed_name(SHIDX_DEBUG_ABBREV)),
                &dwarf.debug_abbrev,
            );
            out.place(
                progbits(out.fixed_name(SHIDX_DEBUG_LINE)),
                &dwarf.debug_line,
            );
        }
        if !self.relocs.debug_line.is_empty() {
            let name = out.fixed_name(SHIDX_RELA_DEBUG_LINE);
            let info = out.shndx.map(SHIDX_DEBUG_LINE) as u32;
            out.place_rela(class, name, &self.relocs.debug_line, info);
        }
        if emit_dwarf {
            out.place(
                Elf64Shdr {
                    sh_flags: SHF_MERGE | SHF_STRINGS,
                    sh_entsize: 1,
                    ..progbits(out.fixed_name(SHIDX_DEBUG_STR))
                },
                &dwarf.debug_str,
            );
        }
    }

    /// `.tdata` holds the initialised slice of the TLS template and `.tbss`
    /// the zero-fill remainder, both `SHF_TLS` so the linker groups them
    /// into `PT_TLS`; `.rela.tdata` follows `.tbss` so the fixed indices
    /// below it stay put.
    fn emit_tls_sections(&mut self) {
        let program = self.program;
        let class = self.class;
        let out = &mut self.out;
        if self.has_tls {
            let tls_init_size = program.tls_init_size.min(program.tls_data.len());
            let tls = |sh_name: u32, sh_type: u32| Elf64Shdr {
                sh_name,
                sh_type,
                sh_flags: SHF_ALLOC | SHF_WRITE | SHF_TLS,
                sh_addralign: crate::c5::layout::tls_image_align(program.tls_align) as u64,
                ..Default::default()
            };
            out.place(
                tls(out.fixed_name(SHIDX_TDATA), SHT_PROGBITS),
                &program.tls_data[..tls_init_size],
            );
            out.place_nobits(
                tls(out.fixed_name(SHIDX_TBSS), SHT_NOBITS),
                (program.tls_data.len() - tls_init_size) as u64,
            );
        }
        if !self.relocs.tdata.is_empty() {
            let name = out.fixed_name(SHIDX_RELA_TDATA);
            let info = out.shndx.map(SHIDX_TDATA) as u32;
            out.place_rela(class, name, &self.relocs.tdata, info);
        }
    }

    /// The named sections at the indices planned right after the fixed set,
    /// then their `.rela` companions for the entries carrying relocations.
    fn emit_named_sections(&mut self) -> Result<(), C5Error> {
        let class = self.class;
        for e in self.layout.carve.table.entries.iter_mut() {
            let mut table: Vec<u8> = Vec::with_capacity(e.relas.len() * ELF64_RELA_SIZE);
            for r in &e.relas {
                Self::push_rela(&mut table, r.offset, r.sym, r.rtype, r.addend);
            }
            let mut bytes = core::mem::take(&mut e.bytes);
            fold_rel_addends(class, &table, &mut bytes)?;
            e.bytes = bytes;
        }
        let carve = &self.layout.carve;
        let [text, data, bss] =
            [SHIDX_TEXT, SHIDX_DATA, SHIDX_BSS].map(|n| self.out.shndx.map(n) as u32);
        let out = &mut self.out;
        let section_index_by_name = |name: &str| -> Option<u32> {
            if let Some(k) = carve.table.entries.iter().position(|e| e.name == name) {
                return Some(carve.shndx[k] as u32);
            }
            match name {
                ".text" => Some(text),
                ".data" => Some(data),
                ".bss" => Some(bss),
                _ => None,
            }
        };
        for (k, e) in carve.table.entries.iter().enumerate() {
            debug_assert_eq!(out.sh.len(), carve.shndx[k] as usize);
            let sh_link = match e.link.as_deref() {
                None => 0,
                Some(l) => section_index_by_name(l).ok_or_else(|| {
                    C5Error::hard(Code::OBJECT_FORMAT, format!(
                        "inline asm: section `{}` is ordered after `{l}`, which the object does not define",
                        e.name
                    ))
                })?,
            };
            let shdr = Elf64Shdr {
                sh_name: out.shstrtab_offs[out.named_names_start + k],
                sh_type: e.sh_type,
                sh_flags: e.flags,
                sh_link,
                sh_addralign: e.align,
                sh_entsize: e.entsize,
                ..Default::default()
            };
            if e.sh_type == SHT_NOBITS {
                out.place_nobits(shdr, e.bytes.len() as u64);
            } else {
                out.place(shdr, &e.bytes);
            }
        }
        for (k, e) in carve.table.entries.iter().enumerate() {
            if e.relas.is_empty() {
                continue;
            }
            let mut table: Vec<u8> = Vec::with_capacity(e.relas.len() * ELF64_RELA_SIZE);
            for r in &e.relas {
                Self::push_rela(&mut table, r.offset, r.sym, r.rtype, r.addend);
            }
            let name = out.shstrtab_offs[out.named_rela_names_start + out.named_rela_pos[k]];
            out.place_rela(class, name, &table, carve.shndx[k] as u32);
        }
        Ok(())
    }

    /// The tail sections, each a zero-filled array of 8-byte slots followed
    /// by the `.rela` that binds them, whose `sh_info` names the array.
    fn emit_tail_sections(&mut self) {
        let class = self.class;
        let out = &mut self.out;
        for (k, s) in self.relocs.tail_sections.iter().enumerate() {
            let array_shndx = out.sh.len() as u32;
            let sh_link = if s.link == 0 {
                0
            } else {
                out.shndx.map(s.link) as u32
            };
            out.place(
                Elf64Shdr {
                    sh_name: out.shstrtab_offs[out.tail_name_idx[k].0],
                    sh_type: s.sh_type,
                    sh_flags: s.flags,
                    sh_link,
                    sh_addralign: s.align,
                    sh_entsize: s.entsize,
                    ..Default::default()
                },
                &alloc::vec![0u8; s.count * 8],
            );
            let name = out.shstrtab_offs[out.tail_name_idx[k].1];
            out.place_rela(class, name, &s.rela, array_shndx);
        }
    }

    /// `.comment`: non-alloc, `SHF_MERGE | SHF_STRINGS` with a byte entsize
    /// as gcc and clang flag theirs, so a linker merging many badc objects
    /// folds identical lines into one copy.
    fn emit_comment_section(&mut self) {
        let out = &mut self.out;
        if let Some(body) = out.comment.take() {
            out.place(
                Elf64Shdr {
                    sh_name: out.shstrtab_offs[out.comment_name_idx],
                    sh_type: SHT_PROGBITS,
                    sh_flags: SHF_MERGE | SHF_STRINGS,
                    sh_addralign: 1,
                    sh_entsize: 1,
                    ..Default::default()
                },
                &body,
            );
        }
    }

    /// The section header table at the tail, then the file header over the
    /// placeholder reserved for it.
    fn finish(self) -> Result<Vec<u8>, C5Error> {
        let class = self.class;
        let Output {
            shndx,
            count,
            mut bytes,
            sh,
            ..
        } = self.out;
        debug_assert_eq!(sh.len(), count);
        let shoff = round_up(bytes.len() as u64, class.addr_size());
        bytes.resize(shoff as usize, 0);
        for entry in &sh {
            write_shdr(class, entry, &mut bytes);
        }
        let mut e_ident = [0u8; 16];
        e_ident[0..4].copy_from_slice(b"\x7fELF");
        e_ident[4] = class.ei_class();
        e_ident[5] = ELF_DATA_LSB;
        e_ident[6] = ELF_VERSION_CURRENT;
        let ehdr = Elf64Ehdr {
            e_ident,
            e_type: ET_REL,
            e_machine: e_machine_for(self.abi),
            e_version: ELF_VERSION_CURRENT as u32,
            e_entry: 0,
            e_phoff: 0,
            e_shoff: shoff,
            e_flags: 0,
            e_ehsize: class.ehdr_size() as u16,
            e_phentsize: 0,
            e_phnum: 0,
            e_shentsize: class.shdr_size() as u16,
            e_shnum: count as u16,
            e_shstrndx: shndx.map(SHIDX_SHSTRTAB),
        };
        let mut hdr_bytes: Vec<u8> = Vec::with_capacity(class.ehdr_size() as usize);
        write_ehdr(class, &ehdr, &mut hdr_bytes);
        bytes[..hdr_bytes.len()].copy_from_slice(&hdr_bytes);
        Ok(bytes)
    }
}

impl Output {
    /// Name offset of a fixed section, addressed by its nominal index.
    fn fixed_name(&self, nominal: u16) -> u32 {
        self.shstrtab_offs[self.shndx.map(nominal) as usize - 1]
    }

    /// Append `bytes` at the header's alignment and record the header with
    /// its file placement.
    fn place(&mut self, mut shdr: Elf64Shdr, bytes: &[u8]) {
        let off = round_up(self.bytes.len() as u64, shdr.sh_addralign);
        self.bytes.resize(off as usize, 0);
        self.bytes.extend_from_slice(bytes);
        shdr.sh_offset = off;
        shdr.sh_size = bytes.len() as u64;
        self.sh.push(shdr);
    }

    /// A `SHT_NOBITS` section contributes no file bytes and needs no
    /// padding; its `sh_offset` is conventional.
    fn place_nobits(&mut self, mut shdr: Elf64Shdr, size: u64) {
        shdr.sh_offset = self.bytes.len() as u64;
        shdr.sh_size = size;
        self.sh.push(shdr);
    }

    /// A relocation table at the class's width; `sh_info` names the section
    /// it patches.
    fn place_rela(&mut self, class: ElfClass, sh_name: u32, table: &[u8], sh_info: u32) {
        let table = encode_reloc_table(class, table);
        let sh_link = self.shndx.map(SHIDX_SYMTAB) as u32;
        self.place(
            Elf64Shdr {
                sh_name,
                sh_type: reloc_sht(class),
                sh_flags: SHF_INFO_LINK,
                sh_link,
                sh_info,
                sh_addralign: class.addr_size(),
                sh_entsize: reloc_entsize(class),
                ..Default::default()
            },
            &table,
        );
    }
}

/// The end of an alias's `.set` chain and the offsets accumulated along it.
fn alias_chain_end<'p>(
    aliases: &'p [crate::c5::program::FunctionAlias],
    a: &'p crate::c5::program::FunctionAlias,
) -> (&'p str, i64) {
    let mut target = a.target.as_str();
    let mut off = a.addend;
    for _ in 0..aliases.len() {
        match aliases.iter().find(|x| x.name == target) {
            Some(next) => {
                target = next.target.as_str();
                off += next.addend;
            }
            None => break,
        }
    }
    (target, off)
}

fn st_type_of(t: crate::c5::asm::AsmSymType) -> u8 {
    use crate::c5::asm::AsmSymType;
    match t {
        AsmSymType::Func => STT_FUNC,
        AsmSymType::Object => STT_OBJECT,
        AsmSymType::NoType => STT_NOTYPE,
    }
}

fn pack_sym_info(bind: u8, ty: u8) -> u8 {
    (bind << 4) | (ty & 0xf)
}

const NT_GNU_PROPERTY_TYPE_0: u32 = 5;
const GNU_PROPERTY_AARCH64_FEATURE_1_AND: u32 = 0xc000_0000;
const GNU_PROPERTY_AARCH64_FEATURE_1_BTI: u32 = 1 << 0;
const GNU_PROPERTY_AARCH64_FEATURE_1_PAC: u32 = 1 << 1;

/// The `.note.gnu.property` body claiming the branch protections the
/// emitted code carries, or `None` when it claims none.
fn build_gnu_property_note(machine: Machine, build: &Build, align: usize) -> Option<Vec<u8>> {
    let h = build.abi.hardening;
    let (ty, bits) = match RelocAbi::of(machine, build.elf_class) {
        RelocAbi::Aarch64 => (
            GNU_PROPERTY_AARCH64_FEATURE_1_AND,
            (u32::from(h.bti) * GNU_PROPERTY_AARCH64_FEATURE_1_BTI)
                | (u32::from(h.pac_ret) * GNU_PROPERTY_AARCH64_FEATURE_1_PAC),
        ),
        _ => return None,
    };
    if bits == 0 {
        return None;
    }
    let mut desc: Vec<u8> = Vec::new();
    desc.extend_from_slice(&ty.to_le_bytes());
    desc.extend_from_slice(&4u32.to_le_bytes());
    desc.extend_from_slice(&bits.to_le_bytes());
    while !desc.len().is_multiple_of(align) {
        desc.push(0);
    }
    let mut body: Vec<u8> = Vec::new();
    body.extend_from_slice(&4u32.to_le_bytes());
    body.extend_from_slice(&(desc.len() as u32).to_le_bytes());
    body.extend_from_slice(&NT_GNU_PROPERTY_TYPE_0.to_le_bytes());
    body.extend_from_slice(b"GNU\0");
    body.extend_from_slice(&desc);
    Some(body)
}

/// One `.note.badc` record: the header naming `badc`, then `desc`, each
/// padded to 4 bytes.
fn push_note_record(out: &mut Vec<u8>, ntype: u32, desc: &[u8]) {
    let name = b"badc\0";
    out.extend_from_slice(&(name.len() as u32).to_le_bytes());
    out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
    out.extend_from_slice(&ntype.to_le_bytes());
    out.extend_from_slice(name);
    crate::c5::layout::pad_to_align(out, 4);
    out.extend_from_slice(desc);
    crate::c5::layout::pad_to_align(out, 4);
}

#[allow(clippy::too_many_arguments)]
fn build_badc_note(
    imports: &super::ResolvedImports,
    exports: &[ExportedFunction],
    tls_index_fixups: &[super::TlsIndexFixup],
    macho_tlv_descriptors: &[super::MachoTlvDescriptor],
    macho_tlv_fixups: &[super::MachoTlvFixup],
    tls_symbols: &[(&str, i64, u64)],
    elf_tpoff_fixups: &[super::ElfTpoffFixup],
    prologue_ends: &[(u64, u64)],
    extern_data_names: &[&str],
) -> Vec<u8> {
    let mut out: Vec<u8> = Vec::new();

    // Record 1: dylib paths. Skipped when there are none, like every other
    // record, so a unit using no note channel builds an empty body and the
    // writer drops the section.
    if !imports.dylibs.is_empty() {
        let mut dylibs_desc: Vec<u8> = Vec::new();
        for d in &imports.dylibs {
            dylibs_desc.extend_from_slice(d.path.as_bytes());
            dylibs_desc.push(0);
        }
        push_note_record(&mut out, NT_BADC_DYLIBS, &dylibs_desc);
    }

    // Record 2: per-import dylib map. Skip when there are no imports -- the
    // parser tolerates a missing record so the older shape (dylibs note
    // only) still round-trips.
    if !imports.imports.is_empty() || !imports.data_bindings.is_empty() {
        let mut bm_desc: Vec<u8> = Vec::new();
        for imp in &imports.imports {
            let idx = imp.dylib_index as u32;
            bm_desc.extend_from_slice(&idx.to_le_bytes());
            bm_desc.extend_from_slice(imp.real_symbol.as_bytes());
            bm_desc.push(0);
        }
        for (local, _host, dylib_index) in &imports.data_bindings {
            let idx = *dylib_index as u32;
            bm_desc.extend_from_slice(&idx.to_le_bytes());
            bm_desc.extend_from_slice(local.as_bytes());
            bm_desc.push(0);
        }
        push_note_record(&mut out, NT_BADC_BINDING_MAP, &bm_desc);
    }

    if !exports.is_empty() {
        let mut ex_desc: Vec<u8> = Vec::new();
        for e in exports {
            ex_desc.extend_from_slice(e.name.as_bytes());
            ex_desc.push(0);
        }
        push_note_record(&mut out, NT_BADC_EXPORTS, &ex_desc);
    }

    if !tls_index_fixups.is_empty() {
        let mut tls_desc: Vec<u8> = Vec::new();
        for f in tls_index_fixups {
            tls_desc.extend_from_slice(&(f.instr_offset as u64).to_le_bytes());
        }
        push_note_record(&mut out, NT_BADC_TLS_INDEX, &tls_desc);
    }

    if !macho_tlv_descriptors.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for d in macho_tlv_descriptors {
            desc.extend_from_slice(&d.offset_in_block.to_le_bytes());
        }
        push_note_record(&mut out, NT_BADC_MACHO_TLV_DESC, &desc);
    }

    if !macho_tlv_fixups.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for f in macho_tlv_fixups {
            desc.extend_from_slice(&(f.adrp_offset as u64).to_le_bytes());
            desc.extend_from_slice(&(f.descriptor_index as u64).to_le_bytes());
        }
        push_note_record(&mut out, NT_BADC_MACHO_TLV_FIXUP, &desc);
    }

    if !tls_symbols.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for (sym_name, off, size) in tls_symbols {
            desc.extend_from_slice(&(*off as u64).to_le_bytes());
            desc.extend_from_slice(&size.to_le_bytes());
            desc.extend_from_slice(sym_name.as_bytes());
            desc.push(0);
        }
        push_note_record(&mut out, NT_BADC_TLS_SYM, &desc);
    }

    let tlv_desc_syms: Vec<(usize, &str)> = macho_tlv_descriptors
        .iter()
        .enumerate()
        .filter_map(|(i, d)| d.symbol.as_deref().map(|s| (i, s)))
        .collect();
    if !tlv_desc_syms.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for (idx, sym_name) in &tlv_desc_syms {
            desc.extend_from_slice(&(*idx as u64).to_le_bytes());
            desc.extend_from_slice(sym_name.as_bytes());
            desc.push(0);
        }
        push_note_record(&mut out, NT_BADC_MACHO_TLV_DESC_SYM, &desc);
    }

    if !elf_tpoff_fixups.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for f in elf_tpoff_fixups {
            desc.extend_from_slice(&(f.imm_offset as u64).to_le_bytes());
            match &f.target {
                super::ElfTpoffTarget::Local(off) => {
                    desc.push(0);
                    desc.extend_from_slice(&off.to_le_bytes());
                }
                super::ElfTpoffTarget::Extern(sym_name) => {
                    desc.push(1);
                    desc.extend_from_slice(sym_name.as_bytes());
                    desc.push(0);
                }
            }
        }
        push_note_record(&mut out, NT_BADC_ELF_TPOFF, &desc);
    }

    if !prologue_ends.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for (entry, post) in prologue_ends {
            desc.extend_from_slice(&entry.to_le_bytes());
            desc.extend_from_slice(&post.to_le_bytes());
        }
        push_note_record(&mut out, NT_BADC_PROLOGUE_END, &desc);
    }

    if !imports.data_bindings.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for (local, host, _dylib_index) in &imports.data_bindings {
            desc.extend_from_slice(local.as_bytes());
            desc.push(0);
            desc.extend_from_slice(host.as_bytes());
            desc.push(0);
        }
        push_note_record(&mut out, NT_BADC_COPY_RELOC, &desc);
    }

    // Record 12: names whose address this unit materialises through an
    // undefined symbol, NUL-separated. Typed STT_NOTYPE in the symbol table
    // like every other undefined reference, so the distinction lives only
    // here.
    if !extern_data_names.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for n in extern_data_names {
            desc.extend_from_slice(n.as_bytes());
            desc.push(0);
        }
        push_note_record(&mut out, NT_BADC_EXTERN_DATA, &desc);
    }
    out
}

/// Symtab indices of the `STT_SECTION` entries a DWARF relocation resolves
/// against.
#[derive(Clone, Copy)]
struct DwarfSectionSyms {
    text: u64,
    line: u64,
    abbrev: u64,
    strs: u64,
}

/// Translate a `DwarfReloc` (target = section kind + width) into an
/// `Elf64Rela`.
fn dwarf_reloc_to_elf_rela(
    r: &DwarfReloc,
    abi: RelocAbi,
    syms: DwarfSectionSyms,
    reloc_symbols: &[String],
    obj_sym_idx: &dyn Fn(&str) -> Option<u64>,
) -> Result<Option<Elf64Rela>, C5Error> {
    let named = |i: u32| obj_sym_idx(reloc_symbols.get(i as usize).map(|s| s.as_str())?);
    let sym_idx = match r.target {
        DwarfRelocTarget::Text => syms.text,
        DwarfRelocTarget::DebugLine => syms.line,
        DwarfRelocTarget::DebugAbbrev => syms.abbrev,
        DwarfRelocTarget::DebugStr => syms.strs,
        DwarfRelocTarget::Symbol(i) | DwarfRelocTarget::ThreadLocalSymbol(i) => match named(i) {
            Some(idx) => idx,
            None => return Ok(None),
        },
    };
    let tls = matches!(r.target, DwarfRelocTarget::ThreadLocalSymbol(_));
    let rtype = if tls {
        match abi {
            RelocAbi::X86_64 => Some(R_X86_64_DTPOFF64),
            RelocAbi::Aarch64 => Some(R_AARCH64_TLS_DTPREL64),
            RelocAbi::I386 => None,
        }
    } else {
        abi.abs(r.width.bytes() as u32)
    };
    let rtype = rtype.ok_or_else(|| {
        C5Error::internal(alloc::format!(
            "elf_reloc: debug info holds a {}-byte {} slot, which this psABI \
             has no relocation for",
            r.width.bytes(),
            if tls {
                "thread-local offset"
            } else {
                "address"
            }
        ))
    })?;
    Ok(Some(Elf64Rela {
        r_offset: r.offset,
        r_info: (sym_idx << 32) | (rtype as u64),
        r_addend: r.addend,
    }))
}

/// Emit the relocs the per-arch lowering left behind for an address-load
/// pair (`adrp + add` on aarch64, `lea rip-rel disp32` on x86_64).
fn a64_insn_reloc_type(kind: crate::c5::asm::AsmRelocKind) -> Option<u32> {
    use crate::c5::asm::AsmRelocKind as RK;
    Some(match kind {
        RK::Data | RK::JumpRel => return None,
        RK::A64Branch26 { link: true } => R_AARCH64_CALL26,
        RK::A64Branch26 { link: false } => R_AARCH64_JUMP26,
        RK::A64Condbr19 => R_AARCH64_CONDBR19,
        RK::A64Tstbr14 => R_AARCH64_TSTBR14,
        RK::A64Adr21 => R_AARCH64_ADR_PREL_LO21,
        RK::A64AdrpPage21 => R_AARCH64_ADR_PREL_PG_HI21,
        RK::A64AddLo12 => R_AARCH64_ADD_ABS_LO12_NC,
        RK::A64LdrLit19 => R_AARCH64_LD_PREL_LO19,
        RK::Explicit(t) => t,
        RK::A64LdstLo12(sz) => match sz {
            1 => R_AARCH64_LDST8_ABS_LO12_NC,
            2 => R_AARCH64_LDST16_ABS_LO12_NC,
            4 => R_AARCH64_LDST32_ABS_LO12_NC,
            8 => R_AARCH64_LDST64_ABS_LO12_NC,
            _ => R_AARCH64_LDST128_ABS_LO12_NC,
        },
        RK::A64MovwAbs {
            group,
            signed,
            check,
        } => match (group, signed, check.is_some()) {
            (0, false, true) => R_AARCH64_MOVW_UABS_G0,
            (1, false, true) => R_AARCH64_MOVW_UABS_G1,
            (2, false, true) => R_AARCH64_MOVW_UABS_G2,
            (0, false, false) => R_AARCH64_MOVW_UABS_G0_NC,
            (1, false, false) => R_AARCH64_MOVW_UABS_G1_NC,
            (2, false, false) => R_AARCH64_MOVW_UABS_G2_NC,
            (0, true, _) => R_AARCH64_MOVW_SABS_G0,
            (1, true, _) => R_AARCH64_MOVW_SABS_G1,
            (2, true, _) => R_AARCH64_MOVW_SABS_G2,
            _ => R_AARCH64_MOVW_UABS_G3,
        },
    })
}

fn emit_addr_fixup_relocs(
    machine: Machine,
    out: &mut Vec<u8>,
    instr_offset: u64,
    sym_idx: u64,
    addend: i64,
    part: AddrPart,
) -> Result<(), C5Error> {
    match machine {
        Machine::Aarch64 => {
            let rela = |off: u64, rtype: u32| Elf64Rela {
                r_offset: off,
                r_info: (sym_idx << 32) | rtype as u64,
                r_addend: addend,
            };
            match part {
                AddrPart::Whole => {
                    write_struct(out, &rela(instr_offset, R_AARCH64_ADR_PREL_PG_HI21));
                    write_struct(out, &rela(instr_offset + 4, R_AARCH64_ADD_ABS_LO12_NC));
                }
                AddrPart::Page => {
                    write_struct(out, &rela(instr_offset, R_AARCH64_ADR_PREL_PG_HI21))
                }
                // The record names a site but not which of the low-12 forms
                // it holds, and the type decides how the linker scales the
                // immediate. The codegen emits only whole references, so no
                // caller reaches this.
                AddrPart::InPage => {
                    return Err(C5Error::internal(format!(
                        "elf_reloc: in-page-only fixup at text+{instr_offset:#x} has no \
                             relocation type"
                    )));
                }
            }
        }
        Machine::X86_64 => {
            crate::c5::codegen::require_whole_addr(part, "elf_reloc: address fixup")?;
            let rela = Elf64Rela {
                r_offset: instr_offset + 3,
                r_info: (sym_idx << 32) | R_X86_64_PC32 as u64,
                r_addend: addend - 4,
            };
            write_struct(out, &rela);
        }
    }
    Ok(())
}

/// Addressing form of a cross-TU address materialization in a relocatable
/// object; chosen per symbol by [`RelocWriter::extern_addr_form`].
#[derive(Clone, Copy, PartialEq, Eq)]
enum ExternAddrForm {
    /// The codegen's direct page-relative / RIP-relative pair, kept as-is;
    /// relocs from [`emit_addr_fixup_relocs`].
    Direct,
    /// GOT slot load; text rewritten by
    /// [`rewrite_extern_addr_loads_to_got`], relocs from
    /// [`emit_got_ref_relocs`].
    Got,
    /// Sign-extended 32-bit absolute (x86-64 kernel model); text rewritten
    /// by [`rewrite_extern_addr_loads_to_abs32`], reloc from
    /// [`emit_abs32_ref_reloc`].
    Abs32,
}

/// Emit the GOT-indirect relocs for address-taking a dylib-routed import:
/// `R_AARCH64_ADR_GOT_PAGE` at the `adrp` and `R_AARCH64_LD64_GOT_LO12_NC`
/// at the paired `ldr` on aarch64; `R_X86_64_REX_GOTPCRELX` at the disp32
/// of the rewritten `mov` on x86_64.
fn emit_got_ref_relocs(machine: Machine, out: &mut Vec<u8>, instr_offset: u64, sym_idx: u64) {
    match machine {
        Machine::Aarch64 => {
            let page = Elf64Rela {
                r_offset: instr_offset,
                r_info: (sym_idx << 32) | R_AARCH64_ADR_GOT_PAGE as u64,
                r_addend: 0,
            };
            let lo12 = Elf64Rela {
                r_offset: instr_offset + 4,
                r_info: (sym_idx << 32) | R_AARCH64_LD64_GOT_LO12_NC as u64,
                r_addend: 0,
            };
            write_struct(out, &page);
            write_struct(out, &lo12);
        }
        Machine::X86_64 => {
            let rela = Elf64Rela {
                r_offset: instr_offset + 3,
                r_info: (sym_idx << 32) | R_X86_64_REX_GOTPCRELX as u64,
                r_addend: -4,
            };
            write_struct(out, &rela);
        }
    }
}

/// Emit the kernel-model reloc for an external-address materialization:
/// `R_X86_64_32S` at the imm32 of the `mov reg, imm32` produced by
/// [`rewrite_extern_addr_loads_to_abs32`] (REX + opcode + modrm precede
/// it).
fn emit_abs32_ref_reloc(out: &mut Vec<u8>, instr_offset: u64, sym_idx: u64, addend: i64) {
    let rela = Elf64Rela {
        r_offset: instr_offset + 3,
        r_info: (sym_idx << 32) | R_X86_64_32S as u64,
        r_addend: addend,
    };
    write_struct(out, &rela);
}

/// Rewrite each external-address materialization into the GOT-load form
/// (paired with the relocs from [`emit_got_ref_relocs`]): the `add` half of
/// an aarch64 `adrp + add` becomes `ldr`, and an x86_64 rip-relative `lea`
/// becomes `mov` (opcode 0x8d -> 0x8b, same REX/modrm/disp32).
fn rewrite_extern_addr_loads_to_got(
    machine: Machine,
    text: &[u8],
    instr_offsets: &[usize],
) -> Result<alloc::vec::Vec<u8>, C5Error> {
    let mut body = text.to_vec();
    match machine {
        Machine::Aarch64 => {
            // The codegen emits both halves in one lowering, so the in-page
            // word of its own reference sits at +4.
            for &instr_offset in instr_offsets {
                let off = instr_offset + 4;
                if off + 4 > body.len() {
                    continue;
                }
                let word =
                    u32::from_le_bytes([body[off], body[off + 1], body[off + 2], body[off + 3]]);
                let ldr = super::aarch64::patch::slot_load_form(
                    word,
                    super::aarch64::patch::SlotWidth::W64,
                )
                .map_err(|e| C5Error::internal(e.describe("ELF: GOT reference")))?;
                body[off..off + 4].copy_from_slice(&ldr.to_le_bytes());
            }
        }
        Machine::X86_64 => {
            for &lea_offset in instr_offsets {
                let op = lea_offset + 1; // REX prefix, then the opcode byte
                if op < body.len() && body[op] == 0x8d {
                    body[op] = 0x8b;
                }
            }
        }
    }
    Ok(body)
}

/// Rewrite each x86-64 external-address `lea reg, [rip+disp32]` (`REX.W 8D`
/// modrm mod=00 rm=101) into `mov reg, imm32` (`REX.W C7 /0` modrm mod=11):
/// the destination moves from modrm.reg to modrm.rm and REX.R to REX.B, and
/// the imm32 occupies the bytes the disp32 did, so the instruction length
/// is unchanged.
fn rewrite_extern_addr_loads_to_abs32(body: &mut [u8], instr_offsets: &[usize]) {
    for &lea_offset in instr_offsets {
        if lea_offset + 3 > body.len() || body[lea_offset + 1] != 0x8d {
            continue;
        }
        let rex = body[lea_offset];
        let modrm = body[lea_offset + 2];
        body[lea_offset] = 0x48 | ((rex >> 2) & 1);
        body[lea_offset + 1] = 0xc7;
        body[lea_offset + 2] = 0xc0 | ((modrm >> 3) & 0x07);
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn empty_program(path: &str) -> Program {
        let mut program = super::super::test_support::empty_program();
        program.source_path = path.into();
        program
    }

    fn empty_build_for(_machine: Machine) -> Build {
        super::super::test_support::empty_build()
    }

    /// Sanity: an empty Build produces a valid ELF header that `readelf -h`
    /// would accept.
    #[test]
    fn empty_build_produces_valid_header() {
        let build = empty_build_for(Machine::X86_64);
        let program = empty_program("test.c");
        let bytes = write_relocatable(
            &program,
            &build,
            Machine::X86_64,
            crate::c5::Target::LinuxX64,
        )
        .expect("write");
        assert!(bytes.len() >= ElfClass::Elf64.ehdr_size() as usize);
        assert_eq!(&bytes[0..4], b"\x7fELF");
        assert_eq!(bytes[4], ElfClass::Elf64.ei_class());
        assert_eq!(bytes[5], ELF_DATA_LSB);
        let e_type = u16::from_le_bytes([bytes[16], bytes[17]]);
        assert_eq!(e_type, ET_REL);
        let e_machine = u16::from_le_bytes([bytes[18], bytes[19]]);
        assert_eq!(e_machine, EM_X86_64);
    }

    /// An ELFCLASS32 x86 object is an i386 object: EM_386, and every
    /// on-disk record at the 32-bit width.
    #[test]
    fn elf32_build_produces_an_i386_header() {
        let mut build = empty_build_for(Machine::X86_64);
        build.elf_class = ElfClass::Elf32;
        let program = empty_program("test.s");
        let bytes = write_relocatable(
            &program,
            &build,
            Machine::X86_64,
            crate::c5::Target::LinuxX64,
        )
        .expect("write");
        assert_eq!(bytes[4], ElfClass::Elf32.ei_class());
        assert_eq!(u16::from_le_bytes([bytes[16], bytes[17]]), ET_REL);
        assert_eq!(u16::from_le_bytes([bytes[18], bytes[19]]), EM_386);
        assert_eq!(u16::from_le_bytes([bytes[40], bytes[41]]), 52);
        assert_eq!(u16::from_le_bytes([bytes[46], bytes[47]]), 40);
    }

    /// `-g` on an ELFCLASS32 unit: the DWARF an i386 object carries is
    /// 4-byte-address DWARF, and its relocations are `R_386_32` in
    /// `SHT_REL` records like every other relocation in the object.
    #[test]
    fn elf32_debug_info_is_i386_dwarf() {
        let mut build = empty_build_for(Machine::X86_64);
        build.elf_class = ElfClass::Elf32;
        build.debug_info = true;
        // A function so the CU carries a subprogram DIE: its `DW_AT_low_pc`
        // is a second address site, reached only when `.text` holds code.
        build.text = alloc::vec![0x90; 4];
        build.func_ent_pcs = alloc::vec![0];
        build.pc_to_native = alloc::vec![0];
        build.func_names = alloc::vec![alloc::string::String::from("f")];
        let program = empty_program("test.s");
        let bytes = write_relocatable(
            &program,
            &build,
            Machine::X86_64,
            crate::c5::Target::LinuxX64,
        )
        .expect("write");
        let secs = elf32_sections(&bytes);
        let (info_off, _) = secs[".debug_info"];
        assert_eq!(bytes[info_off + 10], 4, "CU address_size");
        for name in [".rel.debug_info", ".rel.debug_line"] {
            let (off, size) = secs[name];
            assert!(size > 0 && size % 8 == 0, "{name} holds Elf32_Rel records");
            for row in bytes[off..off + size].as_chunks::<8>().0.iter() {
                let info = u32::from_le_bytes(row[4..8].try_into().unwrap());
                assert_eq!(info & 0xff, R_386_32, "{name} entry type");
            }
        }
        // A `.rela.debug_*` companion would mean the writer kept the 64-bit
        // form for the debug tables alone.
        assert!(!secs.contains_key(".rela.debug_info"));
        assert!(!secs.contains_key(".rela.debug_line"));
    }

    /// The driver's `-m16 -g -c <unit>.s` end to end: assemble a real unit
    /// and write it as an i386 object.
    #[test]
    fn elf32_assembled_unit_with_debug_info_writes() {
        use crate::c5::{CompileOptions, Compiler, NativeOptions, OutputKind, Target};
        let program = Compiler::assemble(
            "\t.code16\n\t.text\n\t.globl memcpy\nmemcpy:\n\tpushw %si\n\tretl\n",
            Target::LinuxX64,
            CompileOptions {
                no_entry_point: true,
                ..Default::default()
            },
        )
        .expect("assemble");
        let bytes = crate::c5::emit_native_with_options(
            &program,
            Target::LinuxX64,
            NativeOptions {
                output_kind: OutputKind::Relocatable,
                elf_class: ElfClass::Elf32,
                debug_info: true,
                ..Default::default()
            },
        )
        .expect("emit");
        assert_eq!(bytes[4], ElfClass::Elf32.ei_class());
        assert_eq!(u16::from_le_bytes([bytes[18], bytes[19]]), EM_386);
        let secs = elf32_sections(&bytes);
        assert_eq!(bytes[secs[".debug_info"].0 + 10], 4, "CU address_size");
        assert!(secs.contains_key(".rel.debug_info"));
        assert!(secs.contains_key(".rel.debug_line"));
    }

    /// Section names of an ELF64 object, in header order.
    fn elf64_section_names(bytes: &[u8]) -> Vec<String> {
        let u16a = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap()) as usize;
        let u32a = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
        let u64a = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap()) as usize;
        let (shoff, shentsize, shnum) = (u64a(0x28), u16a(0x3a), u16a(0x3c));
        let strtab = u64a(shoff + u16a(0x3e) * shentsize + 0x18);
        (0..shnum)
            .map(|i| {
                let at = strtab + u32a(shoff + i * shentsize);
                let end = at + bytes[at..].iter().position(|&b| b == 0).expect("name ends");
                String::from_utf8_lossy(&bytes[at..end]).into_owned()
            })
            .collect()
    }

    /// An object names each section once, and carries `.debug_*` only under
    /// `-g`.
    #[test]
    fn an_object_names_each_section_once_and_carries_dwarf_only_under_g() {
        use crate::c5::{CompileOptions, Compiler, NativeOptions, OutputKind, Target};
        const ASM: &str = "\t.text\n\t.globl f\nf:\n\t.byte 0\n\
                           \t.data\n\t.globl d\nd:\n\t.long 1\n\
                           \t.section .rodata\nr:\n\t.long 2\n\
                           \t.bss\nb:\n\t.zero 4\n";
        const C: &str = "int g = 3; int f(void) { return g; }";
        for target in [Target::LinuxX64, Target::LinuxAarch64] {
            for debug in [false, true] {
                for (label, program) in [
                    (
                        "asm",
                        Compiler::assemble(
                            ASM,
                            target,
                            CompileOptions {
                                no_entry_point: true,
                                ..Default::default()
                            },
                        ),
                    ),
                    (
                        "c",
                        Compiler::with_options(
                            String::from(C),
                            target,
                            CompileOptions::default().with_no_entry_point(true),
                        )
                        .compile(),
                    ),
                ] {
                    let ctx = alloc::format!("{label} [{target:?}, debug={debug}]");
                    let program = program.unwrap_or_else(|e| panic!("{ctx}: {e}"));
                    let bytes = crate::c5::emit_native_with_options(
                        &program,
                        target,
                        NativeOptions {
                            output_kind: OutputKind::Relocatable,
                            ..NativeOptions::new().with_debug_info(debug)
                        },
                    )
                    .unwrap_or_else(|e| panic!("{ctx}: {e}"));
                    let names = elf64_section_names(&bytes);
                    for want in [".text", ".data", ".bss"] {
                        assert_eq!(
                            names.iter().filter(|n| n.as_str() == want).count(),
                            1,
                            "{ctx}: `{want}` is not named exactly once in {names:?}"
                        );
                    }
                    assert_eq!(
                        names.iter().any(|n| n.starts_with(".debug")),
                        debug,
                        "{ctx}: debug sections in {names:?}"
                    );
                }
            }
        }
    }

    /// `(offset, size)` of each named section of an ELFCLASS32 object.
    fn elf32_sections(
        bytes: &[u8],
    ) -> alloc::collections::BTreeMap<alloc::string::String, (usize, usize)> {
        let shoff = u32::from_le_bytes(bytes[0x20..0x24].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(bytes[0x30..0x32].try_into().unwrap()) as usize;
        let shstrndx = u16::from_le_bytes(bytes[0x32..0x34].try_into().unwrap()) as usize;
        let field = |i: usize, n: usize| {
            let o = shoff + i * 40 + n * 4;
            u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize
        };
        let strtab = field(shstrndx, 4);
        let mut out = alloc::collections::BTreeMap::new();
        for i in 0..shnum {
            let at = strtab + field(i, 0);
            let end = at + bytes[at..].iter().position(|&b| b == 0).expect("name ends");
            let name = alloc::string::String::from_utf8_lossy(&bytes[at..end]).into_owned();
            out.insert(name, (field(i, 4), field(i, 5)));
        }
        out
    }

    /// `SHT_REL` has no addend field, so the addend is written into the
    /// field the relocation patches, at the width its type reads.
    #[test]
    fn rel_addends_fold_into_the_relocated_field() {
        let mut table = Vec::new();
        for (off, rtype, addend) in [
            (0u64, R_386_32, 0x1234i64),
            (8, R_386_8, -3),
            (12, R_386_16, 5),
        ] {
            write_struct(
                &mut table,
                &Elf64Rela {
                    r_offset: off,
                    r_info: (7u64 << 32) | rtype as u64,
                    r_addend: addend,
                },
            );
        }
        let mut body = alloc::vec![0u8; 16];
        fold_rel_addends(ElfClass::Elf32, &table, &mut body).expect("folds");
        assert_eq!(&body[0..4], &0x1234u32.to_le_bytes());
        assert_eq!(body[8], (-3i8) as u8);
        assert_eq!(&body[12..14], &5u16.to_le_bytes());
        let mut body64 = alloc::vec![0u8; 16];
        fold_rel_addends(ElfClass::Elf64, &table, &mut body64).expect("no-op");
        assert!(body64.iter().all(|&b| b == 0));
        let rel = encode_reloc_table(ElfClass::Elf32, &table);
        assert_eq!(rel.len(), 3 * 8);
        assert_eq!(
            u32::from_le_bytes(rel[4..8].try_into().unwrap()),
            (7 << 8) | R_386_32
        );
    }

    /// The kernel-model rewrite moves the destination from the lea's
    /// modrm.reg (REX.R) to the mov's modrm.rm (REX.B) for every register,
    /// including r8-r15.
    #[test]
    fn abs32_rewrite_moves_the_destination_register() {
        let cases: [([u8; 3], [u8; 3]); 4] = [
            ([0x48, 0x8d, 0x05], [0x48, 0xc7, 0xc0]),
            ([0x48, 0x8d, 0x3d], [0x48, 0xc7, 0xc7]),
            ([0x4c, 0x8d, 0x05], [0x49, 0xc7, 0xc0]),
            ([0x4c, 0x8d, 0x25], [0x49, 0xc7, 0xc4]),
        ];
        for (lea, mov) in cases {
            let mut body = alloc::vec::Vec::from(lea);
            body.extend_from_slice(&[0, 0, 0, 0]);
            rewrite_extern_addr_loads_to_abs32(&mut body, &[0]);
            assert_eq!(&body[..3], &mov, "lea {lea:02x?}");
            assert_eq!(&body[3..], &[0, 0, 0, 0], "imm32 slot untouched");
        }
    }
}

//! ELF64 ET_REL writer -- emits a standard relocatable object
//! from a per-TU [`Build`]. Consumable by `ld` / `lld`:
//! `.text` carries the per-function machine code,
//! `.data` / `.bss` carry the static segment, `.symtab` /
//! `.strtab` list function and global names, and `.rela.text`
//! records cross-TU and libc-import references the linker
//! resolves at link time.
//!
//! Sections emitted: `.text`, `.data`, `.bss`, `.rela.text`,
//! `.symtab`, `.strtab`, `.shstrtab`, `.rela.data`, `.note.badc`
//! (vendor note carrying `#pragma dylib` paths), `.debug_info`,
//! `.rela.debug_info`, `.debug_abbrev`, `.debug_line`,
//! `.rela.debug_line` plus the null section.
//! `.symtab` carries: file symbol, the three section symbols,
//! one `STT_FUNC STB_LOCAL` per `static`-linkage function and
//! one `STT_FUNC STB_GLOBAL` per externally-linked function,
//! libc imports as `STT_NOTYPE STB_WEAK` (the dynamic linker
//! resolves them at load time), cross-TU function and data
//! UNDEFs as `STB_GLOBAL` (the linker rejects unresolved
//! `STB_GLOBAL` UNDEF as `undefined reference to <name>`),
//! and defined data objects as `STT_OBJECT`, `STB_GLOBAL` for
//! external linkage and `STB_LOCAL` for internal.
//!
//! Distinct from `codegen/elf.rs`, which writes ET_EXEC /
//! ET_DYN load-time images.

#![cfg(feature = "std")]

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
use crate::c5::layout::{round_up, write_struct};
// Relocation types this writer emits. `R_X86_64_TPOFF32` and the
// `R_AARCH64_TLSLE_ADD_TPREL_*` pair carry local-exec TLS: the linker
// writes the symbol's TP-relative offset into the `add` immediate
// (x86_64 variant-2, negative; aarch64 variant-1, split across a shifted
// high and a low 12-bit field). `R_AARCH64_ADR_GOT_PAGE` /
// `R_AARCH64_LD64_GOT_LO12_NC` take a dylib-routed import's address
// through the GOT, because the symbol binds against a shared object at
// load time; a direct page relocation would force a copy relocation or
// a canonical PLT entry for a symbol that always lives in a shared
// library. `R_X86_64_REX_GOTPCRELX` is the relaxable GOT load (psABI
// B.2): a linker that resolves the symbol within the image rewrites the
// `REX mov reg, [rip+disp32]` to `lea` and drops the GOT entry, so a
// fully static link needs no GOT; otherwise it behaves exactly like
// `R_X86_64_GOTPCREL`, which linkers never relax.
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

// ELF64 constants (Elf.h subset).
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
// SHT_INIT_ARRAY / SHT_FINI_ARRAY (ELF gABI): arrays of function
// pointers a C library runs before / after `main`. Entries are
// resolved by a paired `.rela.init_array` / `.rela.fini_array`.
const SHT_INIT_ARRAY: u32 = 14;
const SHT_FINI_ARRAY: u32 = 15;
const SHT_PREINIT_ARRAY: u32 = 16;

// Vendor note types under namesz="badc\0". Standard ELF note
// shape (ELF gABI, section 5): each entry is (namesz, descsz,
// type) header + name (4-byte padded) + desc (4-byte padded).
const NT_BADC_DYLIBS: u32 = 1;
// Per-import dylib routing. desc is a sequence of records, each:
//   u32  dylib_index (LE, into the NT_BADC_DYLIBS path list)
//   NUL-terminated import name (the real_symbol stored in `.symtab`).
// Required so the final-image writers (Mach-O / PE / dynamic ELF)
// place each IAT / `LC_LOAD_DYLIB` / `DT_NEEDED` reference under
// the right library; without it every import lands under the
// first dylib and a cross-DLL symbol (`GetCurrentProcess` from
// `kernel32.dll` while `printf` is from `ucrtbase.dll`) is not
// found at process startup.
const NT_BADC_BINDING_MAP: u32 = 2;
// Source-declared exports. desc is a NUL-separated list of the names
// named by `#pragma export(<name>)`. The export name equals the
// defined symbol's name; the final-image writers resolve each to its
// `.symtab` entry when building the export table (PE export directory,
// ELF dynsym, Mach-O export trie). Carried so a shared library links
// the intended export set through the native path rather than every
// `.text`-defined symbol.
const NT_BADC_EXPORTS: u32 = 3;
// Win64 `_tls_index` fixups. desc is a sequence of u64 LE byte offsets
// into `.text`, one per `Inst::TlsAddr` lowering on Windows. The PE
// writer patches each site with the address of the `_tls_index` DWORD
// it places in the TLS directory; carried so a `_Thread_local` Windows
// image links through the native path. Empty (and the record omitted)
// for other targets.
const NT_BADC_TLS_INDEX: u32 = 4;
// Mach-O TLV descriptors. desc is a sequence of u64 LE
// `offset_in_block` values, one per `_Thread_local` variable -- the
// byte offset of the variable inside the per-thread block. The Mach-O
// writer materialises a `__thread_vars` descriptor for each.
const NT_BADC_MACHO_TLV_DESC: u32 = 5;
// Mach-O TLV fixups. desc is a sequence of (u64 adrp_offset, u64
// descriptor_index) pairs: the `.text` offset of the adrp opening the
// descriptor-address materialisation and the index into the
// NT_BADC_MACHO_TLV_DESC list it resolves to.
const NT_BADC_MACHO_TLV_FIXUP: u32 = 6;
// Data-import copy relocations from `#pragma binding(data <lib>::<local>,
// "<host>")`. desc is a sequence of (NUL local_name, NUL host_symbol)
// string pairs. The final-image writer binds each local data symbol to
// the host's data object with an `R_*_COPY` relocation.
const NT_BADC_COPY_RELOC: u32 = 7;
// Defined `_Thread_local` symbols. desc is a sequence of (u64 tls_offset,
// u64 size, NUL name) entries -- one per thread-local variable this unit
// defines, with the byte offset inside the unit's TLS block. The linker
// builds the merged TLS symbol table from these to resolve cross-unit
// extern accesses.
const NT_BADC_TLS_SYM: u32 = 8;
// Mach-O TLV descriptors keyed by a cross-unit symbol. desc is a sequence
// of (u64 descriptor_index, NUL name) entries: the index into the
// NT_BADC_MACHO_TLV_DESC list and the referenced `extern _Thread_local`
// variable. The linker overwrites that descriptor's offset with the
// variable's offset in the merged TLS block.
const NT_BADC_MACHO_TLV_DESC_SYM: u32 = 9;
// Linux/x86_64 TLS access fixups. desc is a sequence of entries, each:
//   u64 imm_offset (byte offset of the `sub` imm32 in `.text`)
//   u8  kind (0 = same-unit local, 1 = cross-unit extern)
//   kind 0: u64 local_offset (byte offset in this unit's TLS block)
//   kind 1: NUL name (the referenced `extern _Thread_local` symbol)
// The linker patches each imm32 with the variable's TPOFF once the
// units' TLS blocks are merged.
const NT_BADC_ELF_TPOFF: u32 = 10;
// Post-prologue anchors. desc is a sequence of (u64 entry_offset, u64
// post_prologue_offset) pairs, both byte offsets into this unit's
// `.text`, one per function whose SSA emit recorded a prologue extent.
// The linker rebases them by the unit's text base and exposes them as
// `MergedNative::prologue_ends`, which the merged-image DWARF frame
// writer needs to place the post-prologue CFA rule.
const NT_BADC_PROLOGUE_END: u32 = 11;
/// Output section for `const`-qualified file-scope storage the
/// declaration did not place by name.
const RODATA_SECTION: &str = ".rodata";
/// Output section for the same storage when the initializer carries a
/// relocation and the output is position-independent: writable until
/// the load-time fixups are applied, read-only afterwards.
const DATA_REL_RO_SECTION: &str = ".data.rel.ro";

/// `.bss` and `.bss.*` name zero-fill storage by convention (the
/// assembler's default section attributes, mirrored by the linker's
/// family classifier): such a section is `SHT_NOBITS` and admits only
/// zero-initialized members.
fn is_bss_family(name: &str) -> bool {
    name == ".bss" || name.starts_with(".bss.")
}

/// Data-segment byte offsets that carry a relocated pointer slot.
/// Storage overlapping one cannot be placed read-only: the loader has
/// to write the resolved address into it.
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

/// Diagnostic for an assembler `.section` / `.pushsection` argument
/// the relocatable writer cannot reproduce faithfully.
fn asm_section_err(name: &str, what: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_link_err(&alloc::format!(
        "inline asm: section `{name}` requests {what}, which the object writer does not emit"
    )))
}

const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;
const SHF_MERGE: u64 = 0x10;
const SHF_STRINGS: u64 = 0x20;
const SHF_INFO_LINK: u64 = 0x40;

const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STB_WEAK: u8 = 2;
// st_other visibility (the low two bits of the byte). The non-default values
// come from `SymVisibility`, which the asm directives and the front-end
// attribute both resolve to.
const STV_DEFAULT: u8 = 0;
const STT_NOTYPE: u8 = 0;
const STT_OBJECT: u8 = 1;
const STT_FUNC: u8 = 2;
const STT_FILE: u8 = 4;
const STT_SECTION: u8 = 3;
const STT_TLS: u8 = 6;
const SHN_UNDEF: u16 = 0;
/// First reserved `st_shndx` value: at or above this an index names a
/// convention (`SHN_ABS`, `SHN_COMMON`, ...), not a section header.
const SHN_LORESERVE: u16 = 0xff00;
const SHN_ABS: u16 = 0xfff1;

/// Size of the ELF64 relocation record the in-memory tables use
/// before [`encode_reloc_table`] narrows them for the class.
const ELF64_RELA_SIZE: usize = 24;

/// psABI whose relocation numbers an object carries. Fixed by the
/// machine and the ELF class: an ELFCLASS32 x86 object is an i386
/// object, which numbers its relocations differently from x86-64 and
/// carries their addends in the relocated field.
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

    /// Absolute relocation reading a `width`-byte field, or `None`
    /// when the psABI defines none: i386 has no 8-byte relocation.
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

/// Section type a relocation table takes in this class. i386 is the
/// only psABI badc emits that uses `SHT_REL`, whose records carry no
/// addend field.
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

/// Write each entry's addend into the field it relocates, at the
/// width its type reads. `SHT_REL` records have no addend field, so
/// the relocated field is the only place it can live. A no-op for the
/// RELA classes.
fn fold_rel_addends(class: ElfClass, table: &[u8], body: &mut [u8]) -> Result<(), C5Error> {
    if !class.is32() {
        return Ok(());
    }
    for row in table.as_chunks::<ELF64_RELA_SIZE>().0.iter() {
        let off = u64::from_le_bytes(row[0..8].try_into().unwrap()) as usize;
        let rtype = u64::from_le_bytes(row[8..16].try_into().unwrap()) as u32;
        let addend = i64::from_le_bytes(row[16..24].try_into().unwrap());
        let Some(width) = i386_field_width(rtype) else {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &alloc::format!(
                    "elf_reloc: {} carries no field for an implicit addend",
                    i386_reloc_desc(rtype)
                ),
            )));
        };
        let end = off + width as usize;
        if end > body.len() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &alloc::format!(
                    "elf_reloc: {} at 0x{off:x} (width {width}) past section end (length {})",
                    i386_reloc_desc(rtype),
                    body.len()
                ),
            )));
        }
        body[off..end].copy_from_slice(&addend.to_le_bytes()[..width as usize]);
    }
    Ok(())
}

/// Encode an ELF64-shaped relocation table at the class's width,
/// re-splitting `r_info` for the class. `SHT_REL` drops the addend
/// word; [`fold_rel_addends`] must have folded it into the section
/// bytes first.
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

/// One `.init_array` / `.fini_array` section plus its companion
/// `.rela.*`: a group of constructor / destructor pointers sharing a
/// priority. The writer appends the pair after the fixed sections.
struct InitArraySection {
    name: String,
    sh_type: u32,
    /// Entry count -- each is an 8-byte function pointer, so the
    /// section's byte size is `count * 8`.
    count: usize,
    rela: Vec<u8>,
}

/// Group `init_funcs` by (destructor?, priority) into `.init_array` /
/// `.fini_array` sections, building each group's `.rela` payload that
/// binds slot `i` to its function symbol. Prioritized groups get the
/// GNU `.init_array.NNNNN` name; the bare form carries the rest.
fn build_init_array_sections(
    init_funcs: &[crate::c5::program::InitFunc],
    func_symidx_by_name: &alloc::collections::BTreeMap<String, u32>,
    rtype_abs64: u32,
) -> Result<Vec<InitArraySection>, C5Error> {
    if init_funcs.is_empty() {
        return Ok(Vec::new());
    }
    // Deterministic group order: constructors before destructors,
    // prioritized (ascending) before unprioritized. Section names
    // carry the ordering a linker actually sorts on; this is only for
    // reproducible output. Within a group, source order is preserved.
    let mut groups: alloc::collections::BTreeMap<(bool, bool, u32), Vec<u32>> =
        alloc::collections::BTreeMap::new();
    for f in init_funcs {
        let sym_idx = *func_symidx_by_name.get(&f.name).ok_or_else(|| {
            C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                "elf_reloc: init/fini function `{}` has no .symtab entry",
                f.name
            )))
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
        out.push(InitArraySection {
            name,
            sh_type: if is_dtor {
                SHT_FINI_ARRAY
            } else {
                SHT_INIT_ARRAY
            },
            count: sym_idxs.len(),
            rela,
        });
    }
    Ok(out)
}

/// Emit a relocatable ELF64 object holding the contents of
/// `build`. The result is a standard `.o` that `ld` / `lld` can
/// link: the writer emits `.rela.text` (SHT_RELA, `sh_info` = the
/// `.text` section index) with one entry per call site, so a TU with
/// cross-TU calls resolves at link time.
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
/// sections plus the maps that retarget symbols and relocations from
/// the default sections into them.
#[derive(Debug, Clone, Default)]
struct CarvePlan {
    table: super::section_table::SectionTable,
    /// Sorted by `old_lo`; a contiguous tail run of `.text`.
    text_ranges: Vec<CarveRange>,
    /// `.text` prefix length that stays in place.
    text_keep_len: usize,
    /// Per-entry section index / STT_SECTION symbol index.
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
    /// `delta` is a two's-complement byte displacement: a negative
    /// addend arrives as a wrapped `u64` and the section-relative
    /// offset goes negative through the same wrap (`home_sym` reads
    /// it back as `i64`).
    fn add(self, delta: u64) -> DataHome {
        match self {
            DataHome::Data(b) => DataHome::Data(b.wrapping_add(delta)),
            DataHome::Bss(b) => DataHome::Bss(b.wrapping_add(delta)),
            DataHome::Named(e, b) => DataHome::Named(e, b.wrapping_add(delta)),
        }
    }
}

/// One span of the unified `.data`-then-`.bss` offset space and the
/// output position of its first byte. Spans are sorted and tile the
/// space. `pad` marks dropped alignment padding: its offsets all map
/// to the span's base, one past the preceding object's end.
#[derive(Debug, Clone, Copy)]
struct DataSpan {
    old_lo: u64,
    old_hi: u64,
    home: DataHome,
    pad: bool,
}

/// Data layout of the relocatable object. Without named-section data
/// objects the plan is the identity: `.data` / `.bss` keep the unified
/// layout. Otherwise each named object moves to its section at its
/// recorded alignment, the alignment padding around the moves is
/// dropped, and the remaining content packs in order -- a global at
/// its recorded alignment, anonymous data at its 8-byte residue -- so
/// `.data` / `.bss` hold only the default-placement objects.
struct DataPlan {
    spans: Vec<DataSpan>,
    data_file_len: u64,
    data_len: u64,
    bss_len: u64,
    data_align: u64,
    bss_align: u64,
}

/// Home of a unified data offset before any named-section carve.
///
/// The single authority on data-versus-bss. `apply_data_liveness`
/// makes the decision -- an object is zero-fill when it is wholly
/// zero and holds no relocated slot -- and records it by moving those
/// objects past the file-backed image; `data_file_len` is that
/// watershed. Every later consumer asks here rather than re-deriving
/// the rule.
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

    /// Map a data reference through its object anchor: the anchor picks
    /// the span, the signed displacement `target - anchor` rides as the
    /// addend. A one-past-the-end target (C99 6.5.6p8) would otherwise
    /// home on the next span, a negative addend (C99 6.6 address
    /// constant minus an integer) on the preceding one.
    fn map_ref(&self, target: u64, anchor: u64) -> DataHome {
        self.map(anchor).add(target.wrapping_sub(anchor))
    }
}

/// Partition the serialized `.rela.text` payload: a text-section
/// addend moved by the carve is retargeted (data-section addends were
/// built through the plan already), and a row whose `r_offset` sits in
/// a carved text range is drained into the owning named section's
/// relocation list with a rebased offset.
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
        // pc-relative correction; every other section-relative row
        // stores it directly. (The aarch64 types all sit above 0x100,
        // so the numeric check cannot misfire.)
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

/// A section-attributed data object: unified offset, its own byte
/// size (`copy`), its unified storage extent including the 8-byte-slot
/// rounding (`extent`), placement alignment, and section-table entry.
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
/// `.rodata`. The named-object pass keys on symbols, and none of this
/// data has one, so without this it stays writable.
///
/// C99 6.4.5p6 leaves writing through a literal undefined, and the
/// read-only mapping is what enforces it. Consumers also classify by
/// address rather than declared type: the Linux kernel's `kfree_const`
/// frees any pointer outside `[__start_rodata, __end_rodata)`.
///
/// A span a named object already covers is that object's storage (a
/// `const char[]` initialized from a literal) and stays with it, so
/// writable storage a literal initializes remains writable. Alignment
/// is the span's existing offset residue rather than 1, since an Mcpy
/// template can need more than byte alignment.
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
    // Adjacent literals are separate objects but pack as one range.
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
    // Disqualify per recorded span, before merging: merging first would
    // let one span's relocation or named overlap withdraw its neighbours,
    // which are separate objects.
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
            .map_err(|m| C5Error::Compile(crate::c5::error::fmt_internal_err(&m)))?;
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

/// Build the data placement plan. `named_objs` is in declaration
/// order; each object's in-section base is packed here at its
/// alignment, advancing `sizes` so following inline-asm payloads
/// append past the attribute content. The remaining unified content
/// splits at each global's start and at the recorded padding ranges,
/// and repacks in order.
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

    // Recorded placement alignment per object start: kept content
    // splits at these offsets so every object repacks at its own
    // alignment. Above-8 boundaries additionally come from the layout
    // marks, which cover objects the symbol table cannot surface at
    // write time (a block-scope static's entry is restored at scope
    // exit).
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

    // In-section base per named object, packed in declaration order at
    // the member's alignment. Removal ranges leave the default
    // sections: the object bytes, the slot-rounding slack past them,
    // and the recorded alignment padding (`entry == usize::MAX` marks
    // dropped padding).
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
    // One past the previously placed content; padding offsets map here
    // so a one-past-the-end address stays adjacent to its object.
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

pub(super) fn write_relocatable(
    program: &Program,
    build: &Build,
    machine: Machine,
    target: super::Target,
) -> Result<Vec<u8>, C5Error> {
    // `_Thread_local` storage round-trips through ET_REL for a
    // single TLS-bearing unit. `Inst::TlsAddr` lowering on Linux
    // uses the local-exec model: `emit_tls_addr` bakes
    // `tpoff = tls_total_size - offset` straight into the `sub`
    // immediate, so the object needs only its `.tdata` / `.tbss`
    // section bytes (emitted below; object.rs parses them back into
    // `NativeObject::tls_data` / `tls_bss_size`). `link.rs` carries
    // a single unit's TLS block forward unchanged and `synth_build`
    // threads it to the writer's PT_TLS layout, so the baked offset
    // stays valid. A multi-object link where more than one unit
    // contributes `_Thread_local` storage shifts each unit's block
    // and so needs `R_X86_64_TPOFF32` / `R_AARCH64_TLSLE_*`
    // relocations emitted here and resolved in link.rs against the
    // merged layout; that case is rejected in `link_native_objects`
    // (macOS TLV descriptors + Win64 `_tls_index` are the format
    // equivalents). TODO.
    let class = build.elf_class;
    let abi = RelocAbi::of(machine, class);
    let source_path = program.source_path.as_str();
    // Section layout (indices used in symtab st_shndx):
    //   1 = .text
    //   2 = .rela.text
    //   3 = .data
    //   4 = .bss
    //   5 = .symtab
    //   6 = .strtab
    //   7 = .shstrtab
    //   8 = .rela.data
    //   9 = .note.badc
    //  10 = .debug_info
    //  11 = .rela.debug_info
    //  12 = .debug_abbrev
    //  13 = .debug_line
    //  14 = .rela.debug_line
    //  15 = .tdata   (present only when the unit has TLS storage)
    //  16 = .tbss    (present only when the unit has TLS storage)
    // Plus the null section at index 0. The TLS sections are
    // appended last so adding them leaves every other section
    // index -- and the hardcoded symtab indices below -- stable.
    // This is the nominal numbering; `shndx_map` below compacts it
    // once the relocation tables are final, dropping every `.rela*`
    // section that ended up with no entries.
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
    // TLS sections are emitted only when the unit carries
    // `_Thread_local` storage; `has_tls` gates both the section
    // headers and the `.shstrtab` name entries.
    let has_tls = !program.tls_data.is_empty();
    const SHIDX_TDATA: u16 = 16;
    const SHIDX_TBSS: u16 = 17;
    //  18 = .rela.tdata (present only when the template carries an
    //       address-constant initializer)
    const SHIDX_RELA_TDATA: u16 = 18;
    let has_tls_relocs = !build.tls_data_relocs.is_empty()
        || !build.tls_extern_data_relocs.is_empty()
        || !build.tls_code_relocs.is_empty();
    // Base section count (null + the fixed sections, plus the two TLS
    // sections when present and their relocation table when the template
    // carries one). Each `.init_array` / `.fini_array` group adds two more
    // (the array + its `.rela`), counted once the groups are known below.
    let base_sections: usize = 16 + if has_tls { 2 } else { 0 } + usize::from(has_tls_relocs);

    // ---- `__attribute__((section("name")))` placement plan ----
    //
    // Functions with a section attribute were grouped at the `.text`
    // tail by the emission-order pass; each group's byte range moves
    // into its named section, and `.text` keeps only the default
    // prefix (plus the trailing version marker). Data objects with a
    // section attribute move their `.data` / `.bss` byte range into
    // the named section; the data plan repacks the remaining default
    // content and every data offset surface is remapped through it.
    // Named sections take one index each right after the fixed set;
    // `.rela` companions and `.init_array` groups follow.
    // TODO: `.debug_info` / `.debug_line` still describe carved
    // functions at their pre-carve `.text` offsets.
    let mut carve = CarvePlan::default();
    // Planned content length per table entry; asm payloads append past
    // the attribute content recorded here.
    let mut sizes: Vec<u64> = Vec::new();
    let plan: DataPlan = {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
        let fn_section: alloc::collections::BTreeMap<&str, &str> = program
            .symbols
            .iter()
            .filter(|s| s.class == Token::Fun as i64 && s.defined_here && s.section_name.is_some())
            .map(|s| (s.link_name(), s.section_name.as_deref().unwrap_or("")))
            .collect();
        // The emitted code ends at the last recorded native offset;
        // the version marker sits past it and stays in `.text`.
        let code_end = build
            .pc_to_native
            .last()
            .copied()
            .unwrap_or(build.text.len());
        // (group_lo, group_hi) accumulated per section name.
        let mut text_groups: alloc::collections::BTreeMap<&str, (usize, usize)> =
            alloc::collections::BTreeMap::new();
        for (i, &ent_pc) in build.func_ent_pcs.iter().enumerate() {
            let Some(name) = build.func_names.get(i) else {
                continue;
            };
            let Some(sec) = fn_section.get(name.as_str()) else {
                continue;
            };
            let lo = build
                .pc_to_native
                .get(ent_pc)
                .copied()
                .unwrap_or(usize::MAX);
            let hi = build
                .func_ent_pcs
                .get(i + 1)
                .and_then(|&next| build.pc_to_native.get(next).copied())
                .unwrap_or(code_end)
                .min(code_end);
            if lo == usize::MAX || lo >= hi {
                continue;
            }
            let g = text_groups.entry(sec).or_insert((lo, hi));
            g.0 = g.0.min(lo);
            g.1 = g.1.max(hi);
        }
        let internal =
            |msg: String| -> C5Error { C5Error::Compile(crate::c5::error::fmt_internal_err(&msg)) };
        for (sec, (lo, hi)) in &text_groups {
            let e = carve
                .table
                .get_or_insert(sec, SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16)
                .map_err(internal)?;
            carve.text_ranges.push(CarveRange {
                old_lo: *lo as u64,
                old_hi: *hi as u64,
                new_base: 0,
                entry: e,
            });
        }
        carve.text_ranges.sort_by_key(|r| r.old_lo);
        // The groups must tile the `.text` tail: every carved byte
        // sits past every default-section function, and no two groups
        // interleave. The emission-order pass guarantees this; a
        // violation is an internal error, not a silent miscompile.
        if let Some(first) = carve.text_ranges.first() {
            carve.text_keep_len = first.old_lo as usize;
            let mut prev_hi = first.old_lo;
            for r in &carve.text_ranges {
                if r.old_lo != prev_hi {
                    return Err(internal(format!(
                        "named-section text groups are not contiguous at offset {}",
                        r.old_lo
                    )));
                }
                prev_hi = r.old_hi;
            }
            if prev_hi as usize != code_end {
                return Err(internal(format!(
                    "named-section text groups do not end at the code tail ({prev_hi} vs {code_end})"
                )));
            }
        } else {
            carve.text_keep_len = build.text.len();
        }
        // Data objects, in declaration order so the in-section packing
        // matches the emission order a toolchain assembler produces.
        // Zero-sized records are skipped -- there is nothing to place.
        // `copy` is the object's own byte size; `extent` additionally
        // covers the 8-byte-slot rounding of its unified storage, which
        // the plan drops like alignment padding.
        //
        // Two carves share the pass. An explicit `section("name")`
        // places the object by name, `SHF_WRITE` only when the storage
        // is writable (C99 6.7.3: a `const`-qualified object cannot be
        // written through its declared type, and one writable member
        // makes the whole section writable -- `get_or_insert` unions).
        // Everything else that is `const` and file-backed goes to
        // `.rodata`, so the loader can map it without write permission.
        // A `const` object whose initializer carries a relocation goes
        // there too when the output is not position-independent -- the
        // relocations resolve at link time and nothing writes the page
        // afterwards. Under `-fPIC` the same object needs a load-time
        // fixup, so it goes to `.data.rel.ro`, which a consumer maps
        // writable until the fixups are applied.
        //
        // `runtime_initialized` storage is the exception on both counts:
        // its value comes from stores the declaration emits, so the
        // program writes it during execution whatever its declared type
        // says, and its trailing once-guard byte sits past the symbol's
        // extent and would not travel with it.
        let reloc_slots = relocated_data_offsets(program, &build.label_relocs);
        let data_file_len = build.data.len() as u64;
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
                    // A zero-fill object has no file bytes to carve.
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
            // A `.bss`-family section is `SHT_NOBITS`; a member with a
            // non-zero initializer or a relocated slot is rejected. A
            // member in the zero-fill region satisfies that by
            // construction; a file-backed one (compaction skipped or
            // segregation disabled) is checked directly.
            let sh_type = if is_bss_family(sec) {
                if val < data_file_len {
                    let hi = ((val + size.copy).min(data_file_len)) as usize;
                    if build.data[val as usize..hi].iter().any(|&b| b != 0)
                        || reloc_slots
                            .range(val..val.saturating_add(size.extent))
                            .next()
                            .is_some()
                    {
                        return Err(C5Error::Compile(crate::c5::error::fmt_link_err(
                            &alloc::format!(
                                "only zero initializers are allowed in section `{sec}` (object `{}`)",
                                sym.name
                            ),
                        )));
                    }
                }
                SHT_NOBITS
            } else {
                SHT_PROGBITS
            };
            let e = carve
                .table
                .get_or_insert(sec, sh_type, flags, align)
                .map_err(internal)?;
            named_objs.push(NamedDataObj {
                val,
                copy: size.copy,
                extent: size.extent,
                align,
                entry: e,
            });
        }
        carve_anonymous_const_data(program, build, &reloc_slots, &mut carve, &mut named_objs)?;
        {
            let mut by_val: Vec<(u64, u64)> =
                named_objs.iter().map(|o| (o.val, o.extent)).collect();
            by_val.sort_unstable();
            for w in by_val.windows(2) {
                if w[0].0 + w[0].1 > w[1].0 {
                    // Cold path: name the objects at each offset. A bare
                    // offset does not identify them, and several
                    // symbols can share one start. `val` is a data offset
                    // only for the class placed above; on any other symbol
                    // it counts something else and must not be matched.
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
                            alloc::string::String::from("<unnamed>")
                        } else {
                            names.join("/")
                        }
                    };
                    return Err(internal(format!(
                        "named-section data ranges overlap: {} at offset {} runs {} bytes into {} at offset {}",
                        at(w[0].0),
                        w[0].0,
                        w[0].0 + w[0].1 - w[1].0,
                        at(w[1].0),
                        w[1].0
                    )));
                }
            }
        }
        // Text groups keep their internal layout wholesale, 8-aligned
        // within their entry.
        sizes.resize(carve.table.entries.len(), 0);
        for r in carve.text_ranges.iter_mut() {
            let base = (sizes[r.entry] + 7) & !7;
            r.new_base = base;
            sizes[r.entry] = base + (r.old_hi - r.old_lo);
        }
        plan_data_layout(program, build, &named_objs, &mut sizes, internal)?
    };
    // Per-entry length of the attribute-placed content, before any
    // inline-asm payload is appended past it.
    let attr_sizes = sizes.clone();
    // Inline-asm `.pushsection` payloads join the same table. Letter
    // flags and the `@type` argument map to sh_flags / sh_type; a
    // block sharing a name with an attribute placement merges into the
    // existing entry, its bytes placed past the attribute content at
    // the block's alignment. `asm_placements[i]` is the (entry, base)
    // of `build.asm_sections[i]`.
    let mut asm_placements: Vec<(usize, u64)> = Vec::with_capacity(build.asm_sections.len());
    for s in &build.asm_sections {
        let mut flags: u64 = 0;
        for c in s.flags.bytes() {
            match c {
                b'a' => flags |= SHF_ALLOC,
                b'w' => flags |= SHF_WRITE,
                b'x' => flags |= SHF_EXECINSTR,
                // `M` needs the entsize the directive parser drops and
                // `S` only qualifies it; both are deduplication hints a
                // relocatable object may decline. `G` (group) is
                // dropped with them because the writer emits no
                // `SHT_GROUP` section for the flag to reference.
                b'M' | b'S' | b'G' => {}
                // `T` would make the section thread-local storage,
                // which the merged TLS block is not built from.
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
            // Without an explicit `@type` a `.bss`-family name defaults
            // to `SHT_NOBITS`, matching the assembler's default section
            // attributes.
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
        let e = carve
            .table
            .get_or_insert(&s.name, sh_type, flags, align)
            .map_err(|msg| C5Error::Compile(crate::c5::error::fmt_internal_err(&msg)))?;
        if sizes.len() <= e {
            sizes.resize(e + 1, 0);
        }
        let base = round_up(sizes[e], align);
        sizes[e] = base + s.bytes.len() as u64;
        asm_placements.push((e, base));
    }
    // `.note.gnu.property`: the AArch64 feature word the branch
    // protections claim. The consumer AND-merges it across inputs, so
    // an object may only set a bit whose instructions it actually
    // emits (`Hardening` gates both sides).
    let gnu_property_align: u64 = match class {
        ElfClass::Elf32 => 4,
        ElfClass::Elf64 => 8,
    };
    let gnu_property_note: Option<(usize, u64, Vec<u8>)> =
        match build_gnu_property_note(machine, build, gnu_property_align as usize) {
            None => None,
            Some(body) => {
                let e = carve
                    .table
                    .get_or_insert(
                        ".note.gnu.property",
                        SHT_NOTE,
                        SHF_ALLOC,
                        gnu_property_align,
                    )
                    .map_err(|msg| C5Error::Compile(crate::c5::error::fmt_internal_err(&msg)))?;
                if sizes.len() <= e {
                    sizes.resize(e + 1, 0);
                }
                let base = round_up(sizes[e], gnu_property_align);
                sizes[e] = base + body.len() as u64;
                Some((e, base, body))
            }
        };
    // Switch dispatch tables: a read-only entry of their own. The
    // name keeps the `.rodata` prefix consumers that discover
    // compiler jump tables key on, and stays apart from the carved
    // `.rodata` so its pc-relative entry relocations don't pull that
    // section's const objects into the relro stream on re-ingestion.
    // No named symbol covers the tables: the same consumers require
    // the region anonymous, addressed only through the section
    // symbol.
    let jt_placement: Option<(usize, u64)> = if build.rodata.bytes.is_empty() {
        None
    } else {
        let e = carve
            .table
            .get_or_insert(".rodata.jump_tables", SHT_PROGBITS, SHF_ALLOC, 8)
            .map_err(|msg| C5Error::Compile(crate::c5::error::fmt_internal_err(&msg)))?;
        if sizes.len() <= e {
            sizes.resize(e + 1, 0);
        }
        let base = round_up(sizes[e], 8);
        sizes[e] = base + build.rodata.bytes.len() as u64;
        Some((e, base))
    };
    for k in 0..carve.table.entries.len() {
        carve.shndx.push((base_sections + k) as u16);
        carve.sym_idx.push(0);
    }
    let named_section_count = carve.table.entries.len();

    // A default section the unit leaves empty while an assembled or
    // attribute-placed section claims its name -- how a `.s` unit's
    // own `.text` / `.data` / `.bss` arrive -- is dropped below. Two
    // sections of one name in an object make selection by name
    // ambiguous: `objcopy --dump-section=.text` reads the empty one.
    let shadowed = |name: &str, empty: bool| -> bool {
        empty && carve.table.entries.iter().any(|e| e.name == name)
    };
    let text_shadowed = shadowed(".text", build.text.is_empty());
    let data_shadowed = shadowed(".data", build.data.is_empty() && plan.data_len == 0);
    let bss_shadowed = shadowed(".bss", plan.bss_len == 0);

    // Strtab + symtab construction. The file symbols lead
    // (binding LOCAL, type FILE); per-function symbols follow
    // (binding GLOBAL, type FUNC). ELF requires every LOCAL
    // symbol to precede every GLOBAL one, with sh_info pointing
    // at the first GLOBAL entry.
    //
    // A compiled unit names its source file; an assembled unit gets
    // one STT_FILE symbol per `.file` directive and none otherwise,
    // as GNU as emits them.
    let file_basename = source_path.rsplit('/').next().unwrap_or("<unknown>");
    let file_names: Vec<&str> = if program.asm_unit {
        program.asm_file_names.iter().map(|s| s.as_str()).collect()
    } else {
        alloc::vec![file_basename]
    };

    // Section symbols come first after the file symbols; we
    // emit one for each progbits section so relocations can
    // address them by section index.
    let mut symbols: Vec<Elf64Sym> = Vec::new();
    // Index 0 in symtab is the conventional all-zero null
    // entry.
    symbols.push(Elf64Sym::default());

    // File symbols -> shndx = SHN_ABS by convention. Name offsets
    // get backfilled below once the final strtab is built.
    for _ in &file_names {
        symbols.push(Elf64Sym {
            st_name: 0,
            st_info: pack_sym_info(STB_LOCAL, STT_FILE),
            st_shndx: SHN_ABS,
            ..Default::default()
        });
    }

    // Section symbols (.text, .data, .bss, and under `-g`
    // .debug_line, .debug_abbrev). Each has empty name and SHN of the
    // matching section; data and function-pointer fixups land against
    // one with the offset in `r_addend`. The DWARF section symbols let
    // `.rela.debug_info` / `.rela.debug_line` relocations target
    // them: a placeholder slot in `.debug_info` that refers to the
    // unit's `.debug_line` start surfaces as
    // `R_*_32 against .debug_line section sym, addend = 0`, which
    // the linker rebases to the unit's final `.debug_line` offset
    // after concatenation. Without `-g` the `.debug_*` sections are
    // not written, so their symbols are not either.
    let text_sym_idx = symbols.len() as u64;
    let data_sym_idx = text_sym_idx + 1;
    let bss_sym_idx = text_sym_idx + 2;
    let (debug_line_sym_idx, debug_abbrev_sym_idx) = (text_sym_idx + 3, text_sym_idx + 4);
    let debug_str_sym_idx = text_sym_idx + 5;
    let mut fixed_section_shndx = alloc::vec![SHIDX_TEXT, SHIDX_DATA, SHIDX_BSS];
    if build.debug_info {
        fixed_section_shndx.push(SHIDX_DEBUG_LINE);
        fixed_section_shndx.push(SHIDX_DEBUG_ABBREV);
        fixed_section_shndx.push(SHIDX_DEBUG_STR);
    }
    let fixed_section_syms: Range<u64> =
        text_sym_idx..text_sym_idx + fixed_section_shndx.len() as u64;
    for shndx in fixed_section_shndx {
        symbols.push(Elf64Sym {
            st_info: pack_sym_info(STB_LOCAL, STT_SECTION),
            st_shndx: shndx,
            ..Default::default()
        });
    }
    // Local STT_TLS anchors at each TLS section's start carry the
    // local-exec relocations of `static _Thread_local` accesses
    // (anchor + addend). STT_SECTION anchors would work for the
    // arithmetic but linkers require a TLS-typed symbol on TLS
    // relocations; named globals get their own entries below.
    let (tdata_sec_sym, tbss_sec_sym) = if has_tls {
        let td = symbols.len() as u64;
        symbols.push(Elf64Sym {
            st_info: pack_sym_info(STB_LOCAL, STT_TLS),
            st_shndx: SHIDX_TDATA,
            ..Default::default()
        });
        let tb = symbols.len() as u64;
        symbols.push(Elf64Sym {
            st_info: pack_sym_info(STB_LOCAL, STT_TLS),
            st_shndx: SHIDX_TBSS,
            ..Default::default()
        });
        (td, tb)
    } else {
        (0, 0)
    };
    // One STT_SECTION symbol per named section so relocations into a
    // carved range can reference the section + offset. An entry that
    // takes a dropped default's name takes its symbol with it, so the
    // section still carries exactly one.
    for k in 0..named_section_count {
        let inherited = [
            (".text", text_shadowed, text_sym_idx),
            (".data", data_shadowed, data_sym_idx),
            (".bss", bss_shadowed, bss_sym_idx),
        ]
        .into_iter()
        .find(|&(name, dropped, _)| dropped && carve.table.entries[k].name == name)
        .map(|(_, _, sym)| sym);
        if let Some(sym) = inherited {
            carve.sym_idx[k] = sym;
            symbols[sym as usize].st_shndx = carve.shndx[k];
            continue;
        }
        carve.sym_idx[k] = symbols.len() as u64;
        symbols.push(Elf64Sym {
            st_info: pack_sym_info(STB_LOCAL, STT_SECTION),
            st_shndx: carve.shndx[k],
            ..Default::default()
        });
    }
    // `first_global` is set after the static-linkage function
    // symbols are pushed below; ELF requires every LOCAL symbol
    // to precede every GLOBAL one and `.symtab`'s `sh_info`
    // points at the first GLOBAL entry.

    // Function symbols. The build records each emitted function's
    // entry ent_pc in `func_ent_pcs`; the matching native offset
    // lives at `pc_to_native[ent_pc]`. The function name --
    // when available -- comes from `program.source_functions`
    // via the existing DWARF builder's path. Here we synthesise
    // a `fn_<ent_pc>` placeholder; the real name plumbing lands
    // next.
    // Function names come from `program.source_functions`,
    // indexed by ent_pc; empty entries fall back to a
    // `fn_<ent_pc>` placeholder so every symbol has a non-zero
    // name regardless of whether the parser tracked it.
    //
    // C99 6.2.2 + 6.7.1: a `static` function has internal
    // linkage and must not surface to sibling TUs. The ET_REL
    // writer maps `Linkage::Internal` to `STB_LOCAL`;
    // everything else (`Linkage::External` and the default
    // `None` used for the synthetic CRT entry) maps to
    // `STB_GLOBAL`. ELF requires LOCAL symbols to precede
    // GLOBAL ones in `.symtab`, so split the function list now
    // and merge the emit order below.
    let func_linkage_by_pc: alloc::collections::BTreeMap<usize, crate::c5::symbol::Linkage> = {
        use crate::c5::token::Token;
        program
            .symbols
            .iter()
            .filter(|s| s.class == Token::Fun as i64 && s.defined_here && !s.is_alias)
            .map(|s| (s.val as usize, s.linkage))
            .collect()
    };
    // `__attribute__((weak))` symbols and file-scope asm `.weak` names bind
    // STB_WEAK wherever the name surfaces: as a definition or as an UNDEF
    // reference.
    let weak_names: alloc::collections::BTreeSet<&str> = {
        use crate::c5::asm::AsmSymBind;
        use crate::c5::token::Token;
        program
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
            .collect()
    };
    let bind_for = |name: &str| -> u8 {
        if weak_names.contains(name) {
            STB_WEAK
        } else {
            STB_GLOBAL
        }
    };
    // `__attribute__((visibility(...)))` symbols and the asm visibility
    // directives. A name kept inside its component is not preemptible, so on
    // x86_64 address-of sites resolve PC-relative directly instead of through
    // the GOT (below). An asm directive on a name the front end also marked
    // wins: it names the visibility explicitly.
    let visibility: alloc::collections::BTreeMap<&str, SymVisibility> = {
        use crate::c5::token::Token;
        program
            .symbols
            .iter()
            .filter(|s| {
                s.is_hidden
                    && (s.is_fun_entity() || s.class == Token::Glo as i64)
                    && !s.name.is_empty()
            })
            .map(|s| (s.link_name(), SymVisibility::Hidden))
            .chain(program.asm_visibility.iter().map(|(n, v)| (n.as_str(), *v)))
            .collect()
    };
    let vis_for = |name: &str| -> u8 { visibility.get(name).map_or(STV_DEFAULT, |v| v.stv()) };
    // Addressing form of a cross-TU address materialization. A hidden
    // name is not preemptible, so the direct page-relative pair is
    // correct and keeps the GOT empty. On x86_64 every other name rides
    // the GOT under the small model (the load relaxes back to a direct
    // reference), and the sign-extended 32-bit absolute under the kernel
    // model (every symbol is in range, and a consumer that applies the
    // relocations itself implements no GOT). On aarch64 the direct pair
    // serves a plain extern, but a weak name may resolve to zero, which
    // no page-relative pair encodes, so a link that forbids text
    // relocations rejects the direct form; gcc emits the GOT pair for
    // exactly that case.
    let kernel_abs = machine == Machine::X86_64 && build.code_model == CodeModel::Kernel;
    let extern_addr_form = |name: &str| -> ExternAddrForm {
        if visibility
            .get(name)
            .is_some_and(|v| v.is_local_to_component())
        {
            return ExternAddrForm::Direct;
        }
        match machine {
            Machine::X86_64 if kernel_abs => ExternAddrForm::Abs32,
            Machine::X86_64 => ExternAddrForm::Got,
            Machine::Aarch64 if weak_names.contains(name) => ExternAddrForm::Got,
            Machine::Aarch64 => ExternAddrForm::Direct,
        }
    };
    let mut local_func_idxs: Vec<usize> = Vec::new();
    let mut global_func_idxs: Vec<usize> = Vec::new();
    let mut func_strs: Vec<String> = Vec::with_capacity(build.func_ent_pcs.len());
    // Function index + post-prologue native byte offset, one entry per
    // function whose SSA emit recorded a prologue extent. Written to
    // `.note.badc` (NT_BADC_PROLOGUE_END) below: the linker's merge pass
    // rebases the pairs into `MergedNative::prologue_ends`, and the synth
    // path populates `pc_to_native[ent_pc + 2]` from them so
    // `dwarf::build_debug_frame` emits `DW_CFA_advance_loc
    // <prologue_size>` before the post-prologue CFA rule. Without them,
    // multi-TU FDEs install the CFA rule at byte 0 of the function
    // (suboptimal for unwinds caught inside the prologue range).
    let mut prologue_end_entries: Vec<(usize, usize)> = Vec::new();
    for (i, &ent_pc) in build.func_ent_pcs.iter().enumerate() {
        // FunctionSsa::name is the canonical source for the
        // symbol-table name: the walker copies it from
        // `FinishedFunction::name`, sys-trampolines tag
        // themselves `__c5_sys_<binding>`, and archive reload
        // round-trips user names + re-derives the trampoline
        // names from `binding_idx`. An empty entry falls back
        // to a `fn_<ent_pc>` placeholder.
        let name = build
            .func_names
            .get(i)
            .filter(|s| !s.is_empty())
            .cloned()
            .unwrap_or_else(|| format!("fn_{ent_pc}"));
        // The post-prologue native byte offset is recorded in
        // `func_prologue_native` keyed by `ent_pc`; absent when the SSA
        // emit did not record one (synthetic CRT trampolines without a
        // standard prologue shape).
        if let Some(&post_native) = build.func_prologue_native.get(&ent_pc) {
            prologue_end_entries.push((i, post_native));
        }
        // Synthetic `__c5_sys_*` libc-address trampolines (one per
        // distinct `&libc_fn` taken in a `.data` function-pointer
        // table) are per-TU helpers: each is referenced only within
        // its defining unit through a `.text`-section-relative reloc
        // (the addend carries the trampoline's byte offset, so no
        // by-name `.symtab` reference exists). Two units that both
        // take `&exp` each emit their own `__c5_sys_exp`; binding
        // them STB_GLOBAL collides at link time. STB_LOCAL keeps the
        // copies private and the merge pass tolerates the duplicate.
        let is_sys_trampoline = name.starts_with("__c5_sys_");
        func_strs.push(name);
        match func_linkage_by_pc.get(&ent_pc) {
            _ if is_sys_trampoline => local_func_idxs.push(i),
            Some(crate::c5::symbol::Linkage::Internal) => local_func_idxs.push(i),
            _ => global_func_idxs.push(i),
        }
    }
    // Unique cross-TU user-function names referenced by
    // `user_extern_call_sites`. Each gets exactly one
    // undefined symbol entry; multiple call sites against the
    // same callee share it. Sites whose callee is defined in
    // this unit (cross-named-section calls) resolve against the
    // defined symbol instead and need no UNDEF entry.
    let defined_fn_names: alloc::collections::BTreeSet<&str> =
        build.func_names.iter().map(|s| s.as_str()).collect();
    // Labels the unit's assembly defines: inside an inline-asm named
    // section, or in the main code stream.
    let asm_label_names: alloc::collections::BTreeSet<&str> = build
        .asm_sections
        .iter()
        .flat_map(|s| s.labels.iter().map(|l| l.name.as_str()))
        .chain(build.asm_text_labels.iter().map(|l| l.name.as_str()))
        .collect();
    // A `.set` / `.equ` outside any section defines a symbol of the unit: a
    // constant, or another name whose definition it takes, following a chain
    // of assignments to its end. An assignment to a name nothing in the unit
    // defines is not a definition and emits no symbol, as in GNU as.
    let asm_set_defs = {
        use crate::c5::asm::AsmSymValue;
        let value_of = |n: &str| {
            build
                .asm_sym_decls
                .iter()
                .find(|d| d.name == n)
                .and_then(|d| d.value.as_ref())
        };
        build
            .asm_sym_decls
            .iter()
            .filter_map(|d| {
                // Offsets accumulate along the chain: `.set a, b + 4` over
                // `.set b, c + 8` values `a` at `c + 12`.
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
                    AsmSymValue::Sym(t, k) => (asm_label_names.contains(t.as_str())
                        || defined_fn_names.contains(t.as_str()))
                    .then(|| (d.name.as_str(), AsmSymValue::Sym(t.clone(), off + k))),
                }
            })
            .collect::<Vec<_>>()
    };
    // GNU as makes each a definition of the unit, so every reference to the
    // name -- from another asm statement or from C -- binds to it and no
    // undefined entry is emitted.
    let asm_defined_labels: alloc::collections::BTreeSet<&str> = asm_label_names
        .iter()
        .copied()
        .chain(asm_set_defs.iter().map(|&(n, _)| n))
        .collect();
    // Objects this unit defines, by name: unified `.data` offset (TLS block
    // offset for a thread-local), byte size, and whether it is thread-local.
    // An alias definition carries its target's offset and binds like any
    // defined object; dropping it here would hand its name an undefined
    // entry beside the definition.
    let defined_obj_by_name: alloc::collections::BTreeMap<&str, (i64, u64, bool)> = {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
        program
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
            .collect()
    };
    // The non-thread-local ones, whose value is a `.data` offset: an
    // inline-asm section reloc naming one resolves section-relative like the
    // attribute path.
    let defined_data_by_name = |n: &str| -> Option<i64> {
        defined_obj_by_name
            .get(n)
            .filter(|&&(_, _, tls)| !tls)
            .map(|&(val, _, _)| val)
    };
    // The end of an alias's `.set` chain. An alias whose chain ends at a
    // name nothing in the unit defines is no definition: GNU as emits no
    // symbol for it and resolves every reference against the chain's end,
    // which surfaces as an undefined global. The map carries those aliases;
    // one whose end is defined keeps its own symbol below.
    // Offsets accumulate along the chain, so a reference through it takes
    // the distance from the end in its addend.
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
    let undef_alias_end: alloc::collections::BTreeMap<&str, (&str, i64)> = program
        .function_aliases
        .iter()
        .filter_map(|a| {
            let (end, off) = alias_chain_end(&program.function_aliases, a);
            (!asm_defined_labels.contains(end)
                && !defined_fn_names.contains(end)
                && !defined_obj_by_name.contains_key(end)
                && func_strs.iter().all(|n| n != end))
            .then_some((a.name.as_str(), (end, off)))
        })
        .collect();
    // An alias that emits a symbol of its own defines the name; one whose
    // chain ends undefined does not, and its references keep an undefined
    // entry to resolve against.
    let defines_alias = |n: &str| -> bool {
        program.function_aliases.iter().any(|a| a.name == n) && !undef_alias_end.contains_key(n)
    };
    let mut user_extern_names: Vec<&str> = Vec::new();
    for site in &build.user_extern_call_sites {
        let s = site.symbol_name.as_str();
        if !defined_fn_names.contains(s)
            && !program.function_aliases.iter().any(|a| a.name == s)
            && !asm_defined_labels.contains(s)
            && !user_extern_names.contains(&s)
        {
            user_extern_names.push(s);
        }
    }
    // `code_relocs` targeting an extern function (the
    // `extern_function_imports` map; placeholder ent_pcs past
    // `text.len()`) also need a named UNDEF entry in `.symtab`
    // so the `.rela.data` row below can point at it. Fold
    // those names into the same dedup list.
    let extern_fn_by_pc: alloc::collections::BTreeMap<usize, &str> = program
        .extern_function_imports
        .iter()
        .map(|(pc, name)| (*pc, name.as_str()))
        .collect();
    for r in &build.code_relocs {
        if let Some(&name) = extern_fn_by_pc.get(&(r.target_ent_pc as usize))
            && !program.function_aliases.iter().any(|a| a.name == name)
            && !asm_defined_labels.contains(name)
            && !user_extern_names.contains(&name)
        {
            user_extern_names.push(name);
        }
    }

    // Defined data globals visible to other TUs. C99 6.2.2 +
    // 6.9.2: every file-scope object with external linkage
    // surfaces as a named STT_OBJECT symbol. The cross-TU
    // linker needs the name to resolve `extern T x;`
    // references in sibling units. `Symbol::val` is the byte
    // offset within `.data`; the size comes from the symbol's type
    // (struct / union globals stay unsized).
    let mut defined_data_globals: Vec<(&str, i64, u64)> = Vec::new();
    // Internal-linkage data objects: file-scope `static`, block-scope
    // statics (`name.N`) and compound literals (`__compound.N`). They
    // resolve nothing across units, so they bind STB_LOCAL; a symbol
    // still has to name them or an address in their storage attributes
    // to whatever global happens to precede it. Same shape gcc emits.
    let mut defined_data_locals: Vec<(&str, i64, u64)> = Vec::new();
    // Defined `_Thread_local` symbols: name, offset within this unit's
    // TLS block, byte size. Exported through NT_BADC_TLS_SYM (not the
    // `.data` symbol table -- their value is a TLS-block offset, not a
    // `.data` offset, and merging them as `.data` symbols would collide).
    let mut defined_tls_globals: Vec<(&str, i64, u64)> = Vec::new();
    // Internal-linkage `_Thread_local` objects. They resolve nothing
    // across units, so they bind STB_LOCAL and stay out of the note
    // channel, which is name-keyed; a symbol still has to name them or
    // their storage carries no description. Same shape gcc emits.
    let mut defined_tls_locals: Vec<(&str, i64, u64)> = Vec::new();
    {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
        for sym in &program.symbols {
            if sym.class != Token::Glo as i64 || !sym.defined_here || sym.name.is_empty() {
                continue;
            }
            let size = crate::c5::layout::data_object_byte_size(sym);
            match sym.linkage {
                Linkage::External if sym.is_thread_local => {
                    defined_tls_globals.push((sym.link_name(), sym.val, size));
                }
                Linkage::External => {
                    defined_data_globals.push((sym.link_name(), sym.val, size));
                }
                // A thread-local's value is a TLS-block offset, which
                // `DataPlan::map` would read as a `.data` offset. An
                // alias names another object's storage.
                Linkage::Internal if sym.is_thread_local && !sym.is_alias => {
                    defined_tls_locals.push((sym.link_name(), sym.val, size));
                }
                Linkage::Internal if !sym.is_alias => {
                    defined_data_locals.push((sym.link_name(), sym.val, size));
                }
                _ => {}
            }
        }
    }
    // One name can reach the object twice: a block-scope static shares
    // its source name with a file-scope object, and an inline-asm label
    // may already carry it. Keep the first record for each so the
    // symbol table stays a function of name -> storage.
    {
        let mut seen: alloc::collections::BTreeSet<&str> = defined_data_globals
            .iter()
            .map(|(n, _, _)| *n)
            .chain(asm_defined_labels.iter().copied())
            .collect();
        defined_data_locals.retain(|(n, _, _)| seen.insert(n));
        let mut seen_tls: alloc::collections::BTreeSet<&str> =
            defined_tls_globals.iter().map(|(n, _, _)| *n).collect();
        defined_tls_locals.retain(|(n, _, _)| seen_tls.insert(n));
    }

    // Unique cross-TU user-data names referenced by
    // `user_extern_data_refs` (code references) and
    // `extern_data_relocs` (pointer-to-extern-data initializers in the
    // data segment). Both resolve against the same undefined-data
    // symbols.
    let mut user_extern_data_names: Vec<&str> = Vec::new();
    for r in &build.user_extern_data_refs {
        let s = r.symbol_name.as_str();
        if !asm_defined_labels.contains(s)
            && !program.function_aliases.iter().any(|a| a.name == s)
            && !user_extern_data_names.contains(&s)
        {
            user_extern_data_names.push(s);
        }
    }
    for r in build
        .extern_data_relocs
        .iter()
        .chain(&build.tls_extern_data_relocs)
    {
        let s = r.symbol_name.as_str();
        if !asm_defined_labels.contains(s)
            && !defines_alias(s)
            && !user_extern_data_names.contains(&s)
        {
            user_extern_data_names.push(s);
        }
    }

    // Inline-asm section reloc and function-body symbol-operand names with
    // neither a definition in this unit nor an existing UNDEF entry get
    // their own undefined symbols.
    let mut asm_extern_names: Vec<&str> = Vec::new();
    {
        use crate::c5::asm::AsmSectionTarget;
        let section_syms = build
            .asm_sections
            .iter()
            .flat_map(|s| &s.relocs)
            .map(|r| &r.target);
        let operand_syms = build.asm_sym_fixups.iter().map(|r| &r.target);
        // A reference through a dropped alias resolves against its chain's
        // end; the ends of all dropped aliases follow, since GNU as emits
        // the undefined entry for an unreferenced `.set` target too.
        let referenced = section_syms.chain(operand_syms).filter_map(|t| match t {
            AsmSectionTarget::Symbol(name) => Some(name.as_str()),
            _ => None,
        });
        for name in referenced.chain(undef_alias_end.values().map(|&(n, _)| n)) {
            let n = undef_alias_end.get(name).map_or(name, |&(n, _)| n);
            if !defined_fn_names.contains(n)
                && !program.function_aliases.iter().any(|a| a.name == n)
                && defined_data_by_name(n).is_none()
                && !asm_defined_labels.contains(n)
                && !user_extern_names.contains(&n)
                && !user_extern_data_names.contains(&n)
                && !asm_extern_names.contains(&n)
            {
                asm_extern_names.push(n);
            }
        }
    }
    // A visibility directive naming a symbol that surfaces nowhere else still
    // gets an undefined global entry carrying it, as GNU as emits one.
    for n in program.asm_visibility.iter().map(|(n, _)| n.as_str()) {
        if !defined_fn_names.contains(n)
            && !program.function_aliases.iter().any(|a| a.name == n)
            && defined_data_by_name(n).is_none()
            && !asm_defined_labels.contains(n)
            && !user_extern_names.contains(&n)
            && !user_extern_data_names.contains(&n)
            && !asm_extern_names.contains(&n)
        {
            asm_extern_names.push(n);
        }
    }
    // A `.globl` name that surfaces nowhere else gets an undefined global
    // entry, as GNU as emits one for a `.globl` with no definition. A
    // `.weak` in the same position gets none: GNU as emits a weak symbol
    // only where something references the name, and a reference reaches
    // `asm_extern_names` above and takes STB_WEAK through `weak_names`.
    let asm_global_undef: Vec<&str> = program
        .asm_global_names
        .iter()
        .map(|s| s.as_str())
        .filter(|&n| {
            !defined_fn_names.contains(n)
                && !program.function_aliases.iter().any(|a| a.name == n)
                && defined_data_by_name(n).is_none()
                && !asm_defined_labels.contains(n)
                && !user_extern_names.contains(&n)
                && !user_extern_data_names.contains(&n)
                && !asm_extern_names.contains(&n)
                && !program.asm_weak_names.iter().any(|w| w == n)
        })
        .collect();

    // Rebuild strtab now that all names are known: file
    // basename + function names + libc-import symbol names +
    // cross-TU user-function names + defined data globals +
    // cross-TU user-data names.
    let mut all_names: Vec<&str> = Vec::with_capacity(
        1 + func_strs.len()
            + build.imports.imports.len()
            + user_extern_names.len()
            + defined_data_globals.len()
            + user_extern_data_names.len(),
    );
    for name in &file_names {
        all_names.push(name);
    }
    let func_names_start = all_names.len();
    for s in &func_strs {
        all_names.push(s.as_str());
    }
    let func_strs_end = all_names.len();
    // Each libc / dylib import surfaces under its
    // target-specific `real_symbol`. The `#pragma binding`
    // declaration is the only source of truth that maps the
    // c5-internal `local_name` (e.g. `errno_location`) to the
    // platform's actual symbol (`___error` on Mach-O,
    // `__errno_location` on Linux, `_errno` on PE/COFF).
    // Storing the real_symbol here lets the synthesizer feed
    // the final-image writer's dylib import table without
    // having to recover the per-OS rename -- the .o is per-
    // target already (it carries arch-specific instruction
    // bytes), so per-target symbol names are no extra coupling.
    for imp in &build.imports.imports {
        all_names.push(imp.real_symbol.as_str());
    }
    let user_extern_names_start = all_names.len();
    for name in &user_extern_names {
        all_names.push(*name);
    }
    let defined_data_locals_start = all_names.len();
    for (name, _, _) in &defined_data_locals {
        all_names.push(*name);
    }
    let defined_data_globals_start = all_names.len();
    for (name, _, _) in &defined_data_globals {
        all_names.push(*name);
    }
    let user_extern_data_names_start = all_names.len();
    for name in &user_extern_data_names {
        all_names.push(*name);
    }
    let asm_extern_names_start = all_names.len();
    for name in &asm_extern_names {
        all_names.push(*name);
    }
    let asm_global_undef_start = all_names.len();
    for name in &asm_global_undef {
        all_names.push(*name);
    }
    // Standard TLS symbols + local-exec relocations are the ELF interop
    // surface for an external linker; they describe the variant-1/2
    // `tp`-relative access models, which only the Linux targets use. A
    // Windows-target unit reuses this container but its TLS surface is
    // the PE model (TEB + `_tls_index`), carried by the note channel.
    let elf_tls_interop = matches!(
        target,
        super::Target::LinuxX64 | super::Target::LinuxAarch64
    );
    // Cross-unit `extern _Thread_local` names referenced by TLS access
    // fixups, deduplicated; each surfaces as an undefined STT_TLS symbol
    // the local-exec relocations bind against.
    let mut extern_tls_names: Vec<&str> = Vec::new();
    if elf_tls_interop {
        for f in &build.elf_tpoff_fixups {
            if let super::ElfTpoffTarget::Extern(name) = &f.target
                && !extern_tls_names.contains(&name.as_str())
            {
                extern_tls_names.push(name.as_str());
            }
        }
    }
    let defined_tls_globals_start = all_names.len();
    if elf_tls_interop {
        for (name, _, _) in &defined_tls_globals {
            all_names.push(*name);
        }
    }
    let defined_tls_locals_start = all_names.len();
    if elf_tls_interop {
        for (name, _, _) in &defined_tls_locals {
            all_names.push(*name);
        }
    }
    let extern_tls_names_start = all_names.len();
    for name in &extern_tls_names {
        all_names.push(*name);
    }
    let fn_alias_names_start = all_names.len();
    for a in &program.function_aliases {
        all_names.push(a.name.as_str());
    }
    // Labels defined inside inline-asm named sections. The value is the
    // label's offset within the section, rebased by the block's placement;
    // `.type` / `.size` directives set `st_type` / `st_size`.
    use crate::c5::asm::{AsmSymBind, AsmSymDecl, AsmSymType, AsmSymValue};
    // A unit-level symbol directive an asm template carried outside any
    // section. It reaches whichever definition the unit holds for the name --
    // a section label, a main-stream label, or none at all.
    let sym_decl =
        |n: &str| -> Option<&AsmSymDecl> { build.asm_sym_decls.iter().find(|d| d.name == n) };
    let st_type_of = |t: AsmSymType| -> u8 {
        match t {
            AsmSymType::Func => STT_FUNC,
            AsmSymType::Object => STT_OBJECT,
            AsmSymType::NoType => STT_NOTYPE,
        }
    };
    struct AsmLabelSym<'a> {
        name: &'a str,
        shndx: u16,
        /// `.symtab` index of the section symbol for `shndx`.
        sec_sym: u64,
        value: u64,
        global: bool,
        weak: bool,
        st_type: u8,
        st_size: u64,
    }
    let weak_names_ref = &weak_names;
    let asm_labels: Vec<AsmLabelSym> = asm_placements
        .iter()
        .zip(build.asm_sections.iter())
        .flat_map(|(&(e, base), s)| {
            let shndx = carve.shndx[e];
            let sec_sym = carve.sym_idx[e];
            s.labels.iter().map(move |l| {
                // A directive from another statement of the unit reaches this
                // definition; the defining statement's own wins where both set
                // the same field.
                let d = sym_decl(l.name.as_str());
                AsmLabelSym {
                    name: l.name.as_str(),
                    // A `.set` that folded to a constant is absolute: it has no
                    // section and no placement, as in GNU as.
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
                    // `.weak` in the defining statement, or a file-scope `.weak`
                    // in another statement of the unit.
                    weak: l.weak || weak_names_ref.contains(l.name.as_str()),
                    st_type: st_type_of(match l.sym_type {
                        AsmSymType::NoType => d.map_or(AsmSymType::NoType, |d| d.sym_type),
                        t => t,
                    }),
                    st_size: l.size.or(d.and_then(|d| d.size)).unwrap_or(0),
                }
            })
        })
        .collect();
    let asm_label_names_start = all_names.len();
    for l in &asm_labels {
        all_names.push(l.name);
    }
    // Named labels an inline-asm template defined in the main code stream.
    // A name a pushed section already defines is that section's label; a
    // repeated main-stream name is one definition, so keep the first.
    struct AsmTextLabelSym<'a> {
        name: &'a str,
        offset: usize,
        bind: u8,
        st_type: u8,
        st_size: u64,
    }
    let mut asm_text_label_syms: Vec<AsmTextLabelSym> = Vec::new();
    for l in &build.asm_text_labels {
        let n = l.name.as_str();
        if asm_labels.iter().any(|a| a.name == n) || asm_text_label_syms.iter().any(|s| s.name == n)
        {
            continue;
        }
        // Local like every gas label with no directive naming it; a unit-level
        // `.globl` / `.weak` on the name rebinds it.
        let d = sym_decl(n);
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
    let asm_text_label_names_start = all_names.len();
    for s in &asm_text_label_syms {
        all_names.push(s.name);
    }
    // The assignments outside any section, less the names a section or the
    // code stream also defines: those have their own entry above.
    let asm_decl_set: Vec<&(&str, AsmSymValue)> = asm_set_defs
        .iter()
        .filter(|&&(n, _)| !asm_label_names.contains(n))
        .collect();
    let asm_decl_set_start = all_names.len();
    for &(n, _) in &asm_decl_set {
        all_names.push(n);
    }
    // A `.globl` naming nothing the unit defines is an undefined global, as
    // GNU as emits for one with no definition. `.weak` is not: GNU as gives
    // an undefined weak name a symbol only where something references it,
    // and a reference gets STB_WEAK through `weak_names` above.
    let asm_decl_undef: Vec<&AsmSymDecl> = build
        .asm_sym_decls
        .iter()
        .filter(|d| {
            d.bind == AsmSymBind::Global
                && d.value.is_none()
                && !defined_fn_names.contains(d.name.as_str())
                && !program.function_aliases.iter().any(|a| a.name == d.name)
                && defined_data_by_name(d.name.as_str()).is_none()
                && !asm_defined_labels.contains(d.name.as_str())
                && !user_extern_names.contains(&d.name.as_str())
                && !user_extern_data_names.contains(&d.name.as_str())
                && !asm_extern_names.contains(&d.name.as_str())
                && !asm_global_undef.contains(&d.name.as_str())
        })
        .collect();
    let asm_decl_undef_start = all_names.len();
    for d in &asm_decl_undef {
        all_names.push(d.name.as_str());
    }
    // Mapping-symbol names, on the one architecture that has them, so no
    // other target's string table carries them.
    let map_names_start = all_names.len();
    if machine == Machine::Aarch64 {
        all_names.push(MapClass::Code.symbol_name());
        all_names.push(MapClass::Data.symbol_name());
    }
    let (strtab_bytes, name_offs) = build_string_table(&all_names);
    // Patch the file symbols' name offsets against the final
    // strtab; they sit right after the null entry.
    for i in 0..file_names.len() {
        symbols[1 + i].st_name = name_offs[i];
    }

    let func_extent = |i: usize| -> Result<(usize, usize), C5Error> {
        let ent_pc = build.func_ent_pcs[i];
        let lo = build
            .pc_to_native
            .get(ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if lo == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "elf_reloc: function ent_pc {ent_pc} has no native offset in pc_to_native",
                ),
            )));
        }
        Ok((lo, build.func_code_end(i)))
    };
    // Function name -> `.symtab` index, for the `.init_array` /
    // `.fini_array` relocations to reference each constructor /
    // destructor function symbol. Covers both static (STB_LOCAL) and
    // external (STB_GLOBAL) functions.
    let mut func_symidx_by_name: alloc::collections::BTreeMap<String, u32> =
        alloc::collections::BTreeMap::new();
    // Symbol index of each label defined in an inline-asm named section, so
    // a data reference to the label resolves to it rather than to an UNDEF.
    let mut asm_label_symidx: alloc::collections::BTreeMap<&str, u32> =
        alloc::collections::BTreeMap::new();
    // Where a `.text` offset ends up: the named section's index and
    // rebased offset for a carved range, `.text` itself otherwise.
    let text_place = |off: u64| -> (u16, u64) {
        match carve.map_text(off) {
            Some((e, new_off)) => (carve.shndx[e], new_off),
            None => (SHIDX_TEXT, off),
        }
    };
    // The unit's TLS block is `.tdata` bytes then `.tbss` zero fill; an
    // offset past the initialized bytes is `.tbss`-relative.
    let tls_init_len = program.tls_init_size.min(program.tls_data.len()) as i64;
    let tls_home = |off: i64| {
        if off >= tls_init_len {
            (SHIDX_TBSS, off - tls_init_len)
        } else {
            (SHIDX_TDATA, off)
        }
    };
    // Where a name this unit defines lands: section index, value, symbol type
    // and size. Every definition channel resolves here -- a label of an
    // inline-asm section, a label the main code stream defines, a function
    // body, and a data or thread-local object.
    let defined_place = |t: &str| -> Result<Option<(u16, u64, u8, u64)>, C5Error> {
        if let Some(l) = asm_labels.iter().find(|l| l.name == t) {
            return Ok(Some((l.shndx, l.value, l.st_type, l.st_size)));
        }
        if let Some(s) = asm_text_label_syms.iter().find(|s| s.name == t) {
            let (shndx, value) = text_place(s.offset as u64);
            return Ok(Some((shndx, value, s.st_type, s.st_size)));
        }
        if let Some(i) = func_strs.iter().position(|n| n == t) {
            let (lo, hi) = func_extent(i)?;
            let (shndx, value) = text_place(lo as u64);
            return Ok(Some((shndx, value, STT_FUNC, hi.saturating_sub(lo) as u64)));
        }
        let Some(&(val, size, tls)) = defined_obj_by_name.get(t) else {
            return Ok(None);
        };
        if tls {
            let (shndx, value) = tls_home(val);
            return Ok(Some((shndx, value as u64, STT_TLS, size)));
        }
        let (shndx, value) = match plan.map(val.max(0) as u64) {
            DataHome::Data(o) => (SHIDX_DATA, o),
            DataHome::Bss(o) => (SHIDX_BSS, o),
            DataHome::Named(e, o) => (carve.shndx[e], o),
        };
        Ok(Some((shndx, value, STT_OBJECT, size)))
    };
    // Where an assignment's value lands: a constant is SHN_ABS, an
    // assignment to another name takes that name's placement, which the
    // chain resolution above narrowed to a definition of this unit.
    let set_place = |v: &AsmSymValue| -> Result<(u16, u64, u8, u64), C5Error> {
        let (t, off) = match v {
            AsmSymValue::Abs(n) => return Ok((SHN_ABS, *n as u64, STT_NOTYPE, 0)),
            AsmSymValue::Sym(t, k) => (t.as_str(), *k),
        };
        let (shndx, value, st_type, st_size) = defined_place(t)?.ok_or_else(|| {
            C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                "elf_reloc: `.set` target `{t}` has no definition"
            )))
        })?;
        Ok((shndx, value.wrapping_add_signed(off), st_type, st_size))
    };
    // Binding of an assigned name: local unless a directive of the unit
    // declared it global or weak. Both channels a directive arrives through
    // count -- a file-scope statement's and a function-scope one's.
    let set_bind = |n: &str| -> u8 {
        let declared = program.asm_global_names.iter().any(|g| g == n)
            || weak_names.contains(n)
            || matches!(
                build
                    .asm_sym_decls
                    .iter()
                    .find(|d| d.name == n)
                    .map(|d| d.bind),
                Some(AsmSymBind::Global | AsmSymBind::Weak)
            );
        if declared { bind_for(n) } else { STB_LOCAL }
    };
    // Binding of an alias symbol: a `.set` assignment follows the unit's
    // directives, a declarator's own linkage its attributes.
    let alias_bind = |a: &crate::c5::program::FunctionAlias| -> u8 {
        use crate::c5::program::AliasBind;
        match a.bind {
            AliasBind::Weak => STB_WEAK,
            AliasBind::Local => STB_LOCAL,
            AliasBind::Global => bind_for(&a.name),
            AliasBind::Assigned => set_bind(&a.name),
        }
    };
    // STB_LOCAL function symbols. Emitted before `first_global`
    // so the LOCAL block is contiguous as ELF requires.
    for &i in &local_func_idxs {
        let (lo, hi) = func_extent(i)?;
        let (shndx, value) = text_place(lo as u64);
        func_symidx_by_name.insert(func_strs[i].clone(), symbols.len() as u32);
        symbols.push(Elf64Sym {
            st_name: name_offs[func_names_start + i],
            st_info: pack_sym_info(STB_LOCAL, STT_FUNC),
            st_shndx: shndx,
            st_value: value,
            st_size: hi.saturating_sub(lo) as u64,
            ..Default::default()
        });
    }
    // Post-prologue anchors for the note record: (function entry,
    // first post-prologue instruction), both `.text` byte offsets.
    // A function carved into a named section is skipped -- the merge
    // pass keys these on merged `.text` addresses.
    let mut prologue_end_pairs: Vec<(u64, u64)> = Vec::new();
    for &(i, post_native) in &prologue_end_entries {
        let (lo, _) = func_extent(i)?;
        let (fn_shndx, fn_off) = text_place(lo as u64);
        let (post_shndx, post_off) = text_place(post_native as u64);
        if fn_shndx == SHIDX_TEXT && post_shndx == SHIDX_TEXT {
            prologue_end_pairs.push((fn_off, post_off));
        }
    }
    // Names a GOT-addressed reference reaches: the slot is per-symbol,
    // so such a label keeps its own entry even when the reduction below
    // would drop it.
    let got_ref_names: alloc::collections::BTreeSet<&str> = build
        .user_extern_data_refs
        .iter()
        .map(|r| r.symbol_name.as_str())
        .filter(|n| extern_addr_form(n) == ExternAddrForm::Got)
        .collect();
    // Local inline-asm section labels, still inside the LOCAL block. A
    // `.L`-prefixed local is an assembler temporary: gas keeps it out of
    // `.symtab`, and every reference to one reduces to its section plus
    // an addend (`asm_label_secref`), so the entry has no reader.
    for (j, l) in asm_labels.iter().enumerate() {
        if l.global || l.weak {
            continue;
        }
        if l.name.starts_with(".L") && l.st_type == STT_NOTYPE && !got_ref_names.contains(l.name) {
            continue;
        }
        asm_label_symidx.insert(l.name, symbols.len() as u32);
        symbols.push(Elf64Sym {
            st_name: name_offs[asm_label_names_start + j],
            st_info: pack_sym_info(STB_LOCAL, l.st_type),
            st_other: vis_for(l.name),
            st_shndx: l.shndx,
            st_value: l.value,
            st_size: l.st_size,
        });
    }
    // Main-stream inline-asm labels a directive left local; a same-name C
    // reference binds to the definition here.
    for (j, l) in asm_text_label_syms.iter().enumerate() {
        if l.bind != STB_LOCAL {
            continue;
        }
        let (shndx, value) = text_place(l.offset as u64);
        asm_label_symidx.insert(l.name, symbols.len() as u32);
        symbols.push(Elf64Sym {
            st_name: name_offs[asm_text_label_names_start + j],
            st_info: pack_sym_info(STB_LOCAL, l.st_type),
            st_shndx: shndx,
            st_value: value,
            st_size: l.st_size,
            ..Default::default()
        });
    }
    // Assignments outside any section that no directive bound global or
    // weak, still inside the LOCAL block.
    for (i, &(n, v)) in asm_decl_set.iter().enumerate() {
        if set_bind(n) != STB_LOCAL {
            continue;
        }
        let (shndx, value, st_type, st_size) = set_place(v)?;
        asm_label_symidx.insert(n, symbols.len() as u32);
        symbols.push(Elf64Sym {
            st_name: name_offs[asm_decl_set_start + i],
            st_info: pack_sym_info(STB_LOCAL, st_type),
            st_other: vis_for(n),
            st_shndx: shndx,
            st_value: value,
            st_size,
        });
    }
    // `alias("target")` symbols: an additional name at the target's extent,
    // following a chain of aliases (`memcpy` -> `__memcpy` -> `__pi_memcpy`)
    // to its defined end. Resolved once and emitted in two passes, since ELF
    // requires every LOCAL symbol to precede `sh_info`. An alias whose chain
    // ends undefined emits no symbol; its references resolve against the
    // end's undefined entry.
    let alias_syms: Vec<Option<(u8, Elf64Sym)>> = program
        .function_aliases
        .iter()
        .enumerate()
        .map(|(i, a)| -> Result<Option<(u8, Elf64Sym)>, C5Error> {
            // A label of the unit under the same name carries it already:
            // an assignment the layout placed defines one.
            if undef_alias_end.contains_key(a.name.as_str())
                || asm_label_names.contains(a.name.as_str())
            {
                return Ok(None);
            }
            let (target, off) = alias_chain_end(&program.function_aliases, a);
            let bind = alias_bind(a);
            let Some((shndx, value, st_type, st_size)) = defined_place(target)? else {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!("alias `{}`: target `{target}` has no definition", a.name),
                )));
            };
            Ok(Some((
                bind,
                Elf64Sym {
                    st_name: name_offs[fn_alias_names_start + i],
                    st_info: pack_sym_info(bind, st_type),
                    st_other: vis_for(&a.name),
                    st_shndx: shndx,
                    st_value: value.wrapping_add_signed(off),
                    st_size,
                },
            )))
        })
        .collect::<Result<_, _>>()?;
    // The local ones, still inside the LOCAL block.
    for (i, entry) in alias_syms.iter().enumerate() {
        let Some((bind, sym)) = *entry else { continue };
        if bind != STB_LOCAL {
            continue;
        }
        func_symidx_by_name.insert(
            program.function_aliases[i].name.clone(),
            symbols.len() as u32,
        );
        symbols.push(sym);
    }
    // Internal-linkage data objects: STB_LOCAL + STT_OBJECT, placed
    // through the same layout plan the external ones use, so
    // compaction and named-section moves are reflected.
    let mut defined_data_local_symidx: alloc::collections::BTreeMap<&str, u64> =
        alloc::collections::BTreeMap::new();
    for (i, (name, val, size)) in defined_data_locals.iter().enumerate() {
        let (shndx, value) = match plan.map((*val).max(0) as u64) {
            DataHome::Data(o) => (SHIDX_DATA, o),
            DataHome::Bss(o) => (SHIDX_BSS, o),
            DataHome::Named(e, o) => (carve.shndx[e], o),
        };
        defined_data_local_symidx.insert(name, symbols.len() as u64);
        symbols.push(Elf64Sym {
            st_name: name_offs[defined_data_locals_start + i],
            st_info: pack_sym_info(STB_LOCAL, STT_OBJECT),
            st_other: STV_DEFAULT,
            st_shndx: shndx,
            st_value: value,
            st_size: *size,
        });
    }
    // `_Thread_local` objects: STT_TLS against `.tdata` / `.tbss` with a
    // section-relative value, so a sibling unit's local-exec relocation
    // and this unit's debug info resolve through the merged TLS block.
    let mut defined_tls_symidx: alloc::collections::BTreeMap<&str, u64> =
        alloc::collections::BTreeMap::new();
    for (i, (name, off, size)) in defined_tls_locals
        .iter()
        .enumerate()
        .take_while(|_| elf_tls_interop)
    {
        let (shndx, value) = tls_home(*off);
        defined_tls_symidx.insert(name, symbols.len() as u64);
        symbols.push(Elf64Sym {
            st_name: name_offs[defined_tls_locals_start + i],
            st_info: pack_sym_info(STB_LOCAL, STT_TLS),
            st_shndx: shndx,
            st_value: value as u64,
            st_size: *size,
            ..Default::default()
        });
    }
    // AArch64 mapping symbols. Every producer records the class of the
    // bytes it lays down; the marks are gathered per output section here,
    // since they arrive in section-independent passes, and folded once.
    if machine == Machine::Aarch64 {
        let mut marks: Vec<(u16, MapMark)> = Vec::new();
        // Per output section: its length and whether it is executable,
        // which decides whether leading data opens a run.
        let mut sec_shape: alloc::collections::BTreeMap<u16, (u64, bool)> =
            alloc::collections::BTreeMap::new();
        sec_shape.insert(SHIDX_TEXT, (carve.text_keep_len as u64, true));
        sec_shape.insert(SHIDX_DATA, (plan.data_len, false));
        sec_shape.insert(SHIDX_BSS, (plan.bss_len, false));
        for (k, e) in carve.table.entries.iter().enumerate() {
            sec_shape.insert(
                carve.shndx[k],
                (
                    sizes.get(k).copied().unwrap_or(0),
                    e.flags & SHF_EXECINSTR != 0,
                ),
            );
        }
        // The text stream holds instructions apart from the data ranges the
        // backend recorded. Each mark is split at the carve boundaries it
        // crosses, so a function placed in a named section opens a run in
        // that section rather than in `.text`.
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
                let (shndx, value) = text_place(lo);
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
        // Content the writer places at a section's own alignment opens a
        // data run at its start, as the alignment ahead of it does in an
        // assembled unit: the unified data image, the switch-table blob,
        // and the attribute-placed content of a named section.
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
        data_start(SHIDX_DATA, 0, plan.data_len);
        data_start(SHIDX_BSS, 0, plan.bss_len);
        for k in 0..carve.table.entries.len() {
            // Carved text is placed first in its entry; the attribute
            // content that follows starts past it.
            let text_end = carve
                .text_ranges
                .iter()
                .filter(|r| r.entry == k)
                .map(|r| r.new_base + (r.old_hi - r.old_lo))
                .max()
                .unwrap_or(0);
            let attr = attr_sizes.get(k).copied().unwrap_or(0);
            data_start(carve.shndx[k], text_end, attr.saturating_sub(text_end));
        }
        if let Some((e, base)) = jt_placement {
            data_start(carve.shndx[e], base, build.rodata.bytes.len() as u64);
        }
        for (&(e, base), s) in asm_placements.iter().zip(build.asm_sections.iter()) {
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
                symbols.push(Elf64Sym {
                    st_name: name_offs[map_names_start + usize::from(class == MapClass::Data)],
                    st_info: pack_sym_info(STB_LOCAL, STT_NOTYPE),
                    st_shndx: shndx,
                    st_value: u64::from(at),
                    ..Default::default()
                });
            }
            i = j;
        }
    }
    let mut first_global = symbols.len() as u32;
    // Global (`.globl`) and weak (`.weak`) inline-asm section labels.
    for (j, l) in asm_labels.iter().enumerate() {
        if !(l.global || l.weak) {
            continue;
        }
        asm_label_symidx.insert(l.name, symbols.len() as u32);
        symbols.push(Elf64Sym {
            st_name: name_offs[asm_label_names_start + j],
            st_info: pack_sym_info(if l.weak { STB_WEAK } else { STB_GLOBAL }, l.st_type),
            st_other: vis_for(l.name),
            st_shndx: l.shndx,
            st_value: l.value,
            st_size: l.st_size,
        });
    }
    // Main-stream labels a `.globl` / `.weak` rebound.
    for (j, l) in asm_text_label_syms.iter().enumerate() {
        if l.bind == STB_LOCAL {
            continue;
        }
        let (shndx, value) = text_place(l.offset as u64);
        asm_label_symidx.insert(l.name, symbols.len() as u32);
        symbols.push(Elf64Sym {
            st_name: name_offs[asm_text_label_names_start + j],
            st_info: pack_sym_info(l.bind, l.st_type),
            st_shndx: shndx,
            st_value: value,
            st_size: l.st_size,
            ..Default::default()
        });
    }
    // Assignments a `.globl` / `.weak` of the unit bound.
    for (i, &(n, v)) in asm_decl_set.iter().enumerate() {
        let bind = set_bind(n);
        if bind == STB_LOCAL {
            continue;
        }
        let (shndx, value, st_type, st_size) = set_place(v)?;
        asm_label_symidx.insert(n, symbols.len() as u32);
        symbols.push(Elf64Sym {
            st_name: name_offs[asm_decl_set_start + i],
            st_info: pack_sym_info(bind, st_type),
            st_other: vis_for(n),
            st_shndx: shndx,
            st_value: value,
            st_size,
        });
    }
    // STB_GLOBAL (or, for `__attribute__((weak))` definitions,
    // STB_WEAK) function symbols.
    for &i in &global_func_idxs {
        let (lo, hi) = func_extent(i)?;
        let (shndx, value) = text_place(lo as u64);
        func_symidx_by_name.insert(func_strs[i].clone(), symbols.len() as u32);
        symbols.push(Elf64Sym {
            st_name: name_offs[func_names_start + i],
            st_info: pack_sym_info(bind_for(&func_strs[i]), STT_FUNC),
            st_other: vis_for(&func_strs[i]),
            st_shndx: shndx,
            st_value: value,
            st_size: hi.saturating_sub(lo) as u64,
        });
    }

    // Alias symbols a directive bound global or weak.
    for (i, entry) in alias_syms.iter().enumerate() {
        let Some((bind, sym)) = *entry else { continue };
        if bind == STB_LOCAL {
            continue;
        }
        func_symidx_by_name.insert(
            program.function_aliases[i].name.clone(),
            symbols.len() as u32,
        );
        symbols.push(sym);
    }

    // Import symbols: STB_WEAK + STT_NOTYPE, SHN_UNDEF. The
    // dynamic linker resolves these against libc (or whichever
    // dylib `#pragma binding` named) at runtime, so an
    // unresolved entry at static-link time isn't a fatal
    // error. Marking them weak distinguishes them from
    // user-extern UNDEF references (kept STB_GLOBAL below),
    // which must resolve against a sibling TU's defined symbol
    // or the link fails.
    let mut import_sym_indices: Vec<usize> = Vec::with_capacity(build.imports.imports.len());
    for (i, _imp) in build.imports.imports.iter().enumerate() {
        import_sym_indices.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[func_strs_end + i],
            st_info: pack_sym_info(STB_WEAK, STT_NOTYPE),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Cross-TU user-function imports: same STB_GLOBAL +
    // STT_NOTYPE + SHN_UNDEF shape as the libc imports. The
    // linker resolves these against the matching defined
    // symbols in sibling units. `user_extern_sym_idx` maps a
    // name's position in `user_extern_names` to its symbol-table
    // index for the reloc loop below.
    let mut user_extern_sym_idx: Vec<usize> = Vec::with_capacity(user_extern_names.len());
    for (i, name) in user_extern_names.iter().enumerate() {
        user_extern_sym_idx.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[user_extern_names_start + i],
            st_info: pack_sym_info(bind_for(name), STT_NOTYPE),
            st_other: vis_for(name),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Every unified data offset resolves through the plan: `.data` /
    // `.bss` (a `.bss` offset names a byte in the zero-fill region past
    // the file-backed bytes) or a named section. `home_sym` yields the
    // relocation (symbol, section-relative offset) for a home. The
    // named-section symbol indices are copied out so the closures do
    // not hold a borrow of `carve` across its later mutations.
    let named_sym_idx: Vec<u64> = carve.sym_idx.clone();
    let named_shndx: Vec<u16> = carve.shndx.clone();
    // A reference to an assembler-local label resolves to the label's
    // section plus its offset, not to the label symbol: gas reduces a
    // relocation against a local non-function/object symbol that way,
    // and readers of an object's metadata sections require the
    // section+addend form (an unexpected symbol type there aborts
    // their relocation walk). Named globals, weak definitions, and
    // `.type`d function / object labels keep their own symbol -- the
    // binding and the type are what a reader needs from them.
    let mut asm_label_secref: alloc::collections::BTreeMap<&str, (u64, i64)> =
        alloc::collections::BTreeMap::new();
    for l in &asm_labels {
        if l.global || l.weak || l.st_type != STT_NOTYPE || l.shndx == SHN_ABS {
            continue;
        }
        asm_label_secref.insert(l.name, (l.sec_sym, l.value as i64));
    }
    for l in &asm_text_label_syms {
        if l.bind != STB_LOCAL || l.st_type != STT_NOTYPE {
            continue;
        }
        let (sym, value) = match carve.map_text(l.offset as u64) {
            Some((e, new_off)) => (named_sym_idx[e], new_off as i64),
            None => (text_sym_idx, l.offset as i64),
        };
        asm_label_secref.insert(l.name, (sym, value));
    }
    // Resolve a name an inline-asm statement defined: the folded
    // (section symbol, offset) for a local label, else its own symbol
    // with a zero base.
    let asm_label_ref = |name: &str| -> Option<(u64, i64)> {
        if let Some(&(sym, base)) = asm_label_secref.get(name) {
            return Some((sym, base));
        }
        asm_label_symidx.get(name).map(|&i| (i as u64, 0))
    };
    let home_sym = move |h: DataHome| -> (u64, i64) {
        match h {
            DataHome::Data(o) => (data_sym_idx, o as i64),
            DataHome::Bss(o) => (bss_sym_idx, o as i64),
            DataHome::Named(e, o) => (named_sym_idx[e], o as i64),
        }
    };
    let data_section_ref = |off: i64| -> (u64, i64) { home_sym(plan.map(off.max(0) as u64)) };

    // Defined data globals: STB_GLOBAL + STT_OBJECT, in `.data`, in
    // `.bss` for a wholly-zero object, or in the named section the
    // plan moved them to. C99 6.2.2: external-linkage objects surface
    // by name so sibling TUs can resolve `extern T x;`.
    let mut defined_data_symidx: alloc::collections::BTreeMap<&str, u64> =
        alloc::collections::BTreeMap::new();
    for (i, (name, val, size)) in defined_data_globals.iter().enumerate() {
        let (shndx, value) = match plan.map((*val).max(0) as u64) {
            DataHome::Data(o) => (SHIDX_DATA, o),
            DataHome::Bss(o) => (SHIDX_BSS, o),
            DataHome::Named(e, o) => (named_shndx[e], o),
        };
        defined_data_symidx.insert(name, symbols.len() as u64);
        symbols.push(Elf64Sym {
            st_name: name_offs[defined_data_globals_start + i],
            st_info: pack_sym_info(bind_for(name), STT_OBJECT),
            st_other: vis_for(name),
            st_shndx: shndx,
            st_value: value,
            st_size: *size,
        });
    }

    // Cross-TU user-data imports: STB_GLOBAL + STT_OBJECT +
    // SHN_UNDEF. The linker resolves these against the matching
    // defined-data globals emitted by sibling units (above).
    let mut user_extern_data_sym_idx: Vec<usize> = Vec::with_capacity(user_extern_data_names.len());
    for (i, name) in user_extern_data_names.iter().enumerate() {
        user_extern_data_sym_idx.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[user_extern_data_names_start + i],
            st_info: pack_sym_info(bind_for(name), STT_OBJECT),
            st_other: vis_for(name),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Undefined symbols for inline-asm section reloc targets no other
    // table covers; the linker resolves them against sibling units.
    let mut asm_extern_sym_idx: Vec<usize> = Vec::with_capacity(asm_extern_names.len());
    for (i, name) in asm_extern_names.iter().enumerate() {
        asm_extern_sym_idx.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[asm_extern_names_start + i],
            st_info: pack_sym_info(bind_for(name), STT_NOTYPE),
            st_other: vis_for(name),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Undefined global entries for `.globl` names that surface nowhere else.
    for (i, name) in asm_global_undef.iter().enumerate() {
        symbols.push(Elf64Sym {
            st_name: name_offs[asm_global_undef_start + i],
            st_info: pack_sym_info(STB_GLOBAL, STT_NOTYPE),
            st_other: vis_for(name),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Undefined entries for the unit-level `.globl` declarations naming
    // nothing the unit defines.
    for (i, d) in asm_decl_undef.iter().enumerate() {
        symbols.push(Elf64Sym {
            st_name: name_offs[asm_decl_undef_start + i],
            st_info: pack_sym_info(bind_for(&d.name), st_type_of(d.sym_type)),
            st_shndx: SHN_UNDEF,
            st_size: d.size.unwrap_or(0),
            ..Default::default()
        });
    }

    // Defined `_Thread_local` globals: the local form's shape under
    // STB_GLOBAL.
    for (i, (name, off, size)) in defined_tls_globals
        .iter()
        .enumerate()
        .take_while(|_| elf_tls_interop)
    {
        let (shndx, value) = tls_home(*off);
        defined_tls_symidx.insert(name, symbols.len() as u64);
        symbols.push(Elf64Sym {
            st_name: name_offs[defined_tls_globals_start + i],
            st_info: pack_sym_info(STB_GLOBAL, STT_TLS),
            st_shndx: shndx,
            st_value: value as u64,
            st_size: *size,
            ..Default::default()
        });
    }

    // Cross-unit `extern _Thread_local` imports: STB_GLOBAL + STT_TLS +
    // SHN_UNDEF.
    let mut extern_tls_sym_idx: Vec<usize> = Vec::with_capacity(extern_tls_names.len());
    for (i, _name) in extern_tls_names.iter().enumerate() {
        extern_tls_sym_idx.push(symbols.len());
        symbols.push(Elf64Sym {
            st_name: name_offs[extern_tls_names_start + i],
            st_info: pack_sym_info(STB_GLOBAL, STT_TLS),
            st_shndx: SHN_UNDEF,
            ..Default::default()
        });
    }

    // Build the `.rela.text` payload now that import symbols
    // have their final indices.
    let machine_for_rela = machine;
    let mut rela_bytes: Vec<u8> = Vec::with_capacity(
        (build.reloc_call_sites.len()
            + build.user_extern_call_sites.len()
            + build.data_fixups.len() * 2
            + build.func_fixups.len() * 2)
            * ELF64_RELA_SIZE,
    );
    for site in &build.user_extern_call_sites {
        // A callee defined in this unit (a cross-named-section call)
        // resolves against its defined symbol; otherwise the UNDEF.
        let (sym_idx, base) = match func_symidx_by_name.get(site.symbol_name.as_str()) {
            Some(&i) => (i as u64, 0),
            None => match asm_label_ref(site.symbol_name.as_str()) {
                Some(pair) => pair,
                None => {
                    let pos = user_extern_names
                        .iter()
                        .position(|n| *n == site.symbol_name.as_str())
                        .expect("user_extern_names contains every site's symbol name");
                    (user_extern_sym_idx[pos] as u64, 0)
                }
            },
        };
        let (rtype, r_offset, r_addend) = match machine_for_rela {
            Machine::X86_64 => (R_X86_64_PLT32, site.instr_offset as u64 + 1, base - 4),
            // GNU as types the field by the instruction: `bl` takes CALL26,
            // a plain `b` JUMP26. Both patch the same imm26.
            Machine::Aarch64 if site.is_tail => (R_AARCH64_JUMP26, site.instr_offset as u64, base),
            Machine::Aarch64 => (R_AARCH64_CALL26, site.instr_offset as u64, base),
        };
        let r_info = (sym_idx << 32) | (rtype as u64);
        let rela = Elf64Rela {
            r_offset,
            r_info,
            r_addend,
        };
        write_struct(&mut rela_bytes, &rela);
    }
    for site in &build.reloc_call_sites {
        let sym_idx = match import_sym_indices.get(site.import_index) {
            Some(&i) => i as u64,
            None => {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!(
                        "elf_reloc: reloc_call_sites[..].import_index {} out of range",
                        site.import_index,
                    ),
                )));
            }
        };
        // An address-of site (`&strcmp`, `Inst::ImmExtCode`) is a
        // page-relative address materialization, not a control
        // transfer: `lea reg, [rip+disp32]` on x86_64, `adrp + add`
        // on aarch64. The import binds externally, so take its address
        // through the GOT (`adrp :got: + ldr`); an external linker resolves
        // it against the shared library and badc's own linker relaxes it to
        // the import's PLT stub. The `add` half is rewritten to `ldr` below.
        // Under the x86-64 kernel model the address is a sign-extended
        // 32-bit absolute like every other external address.
        if site.is_addr {
            if kernel_abs {
                emit_abs32_ref_reloc(&mut rela_bytes, site.instr_offset as u64, sym_idx, 0);
            } else {
                emit_got_ref_relocs(
                    machine_for_rela,
                    &mut rela_bytes,
                    site.instr_offset as u64,
                    sym_idx,
                );
            }
            continue;
        }
        // x86_64 CALL/JMP rel32 is 5 bytes: opcode + 4-byte
        // disp32. The relocation applies to the disp32 field at
        // `instr_offset + 1`. ELF spec for `R_X86_64_PLT32`
        // wants `addend = -4` so the resolved value equals
        // (S + A) - P where P points at the disp32 itself
        // (S is the symbol value, A the addend).
        //
        // aarch64 BL/B is 4 bytes with the imm26 in the low
        // bits; the reloc applies at the instruction start with
        // addend 0, typed CALL26 for `bl` and JUMP26 for `b` as
        // GNU as types them.
        let (rtype, r_offset, r_addend) = match machine_for_rela {
            Machine::X86_64 => (R_X86_64_PLT32, site.instr_offset as u64 + 1, -4i64),
            Machine::Aarch64 if site.is_tail => (R_AARCH64_JUMP26, site.instr_offset as u64, 0),
            Machine::Aarch64 => (R_AARCH64_CALL26, site.instr_offset as u64, 0),
        };
        let r_info = (sym_idx << 32) | (rtype as u64);
        let rela = Elf64Rela {
            r_offset,
            r_info,
            r_addend,
        };
        write_struct(&mut rela_bytes, &rela);
    }

    // TLS access sites. Local-exec relocations let an external linker
    // rebase each unit's baked single-unit offset against the merged
    // TLS block: `static _Thread_local` accesses anchor on the TLS
    // section symbol plus the section-relative addend, named externs on
    // their undefined STT_TLS symbol. aarch64 patches the two-`add`
    // pair (`tprel_hi12` at the fixup, `tprel_lo12_nc` on the following
    // word); x86_64 patches the `add` imm32 with the negative TPOFF.
    for f in build
        .elf_tpoff_fixups
        .iter()
        .take_while(|_| elf_tls_interop)
    {
        let (sym_idx, r_addend) = match &f.target {
            super::ElfTpoffTarget::Extern(name) => {
                let pos = extern_tls_names
                    .iter()
                    .position(|n| *n == name.as_str())
                    .expect("extern_tls_names contains every fixup's symbol name");
                (extern_tls_sym_idx[pos] as u64, 0i64)
            }
            super::ElfTpoffTarget::Local(off) => {
                let off = *off as i64;
                if off >= tls_init_len {
                    (tbss_sec_sym, off - tls_init_len)
                } else {
                    (tdata_sec_sym, off)
                }
            }
        };
        match machine_for_rela {
            Machine::X86_64 => {
                write_struct(
                    &mut rela_bytes,
                    &Elf64Rela {
                        r_offset: f.imm_offset as u64,
                        r_info: (sym_idx << 32) | (R_X86_64_TPOFF32 as u64),
                        r_addend,
                    },
                );
            }
            Machine::Aarch64 => {
                write_struct(
                    &mut rela_bytes,
                    &Elf64Rela {
                        r_offset: f.imm_offset as u64,
                        r_info: (sym_idx << 32) | (R_AARCH64_TLSLE_ADD_TPREL_HI12 as u64),
                        r_addend,
                    },
                );
                write_struct(
                    &mut rela_bytes,
                    &Elf64Rela {
                        r_offset: f.imm_offset as u64 + 4,
                        r_info: (sym_idx << 32) | (R_AARCH64_TLSLE_ADD_TPREL_LO12_NC as u64),
                        r_addend,
                    },
                );
            }
        }
    }

    // Data-segment references (string literals / globals). The
    // codegen emits a 2-instruction page-relative pair on
    // aarch64 (`adrp` + `add`) and a `lea rip-rel disp32` on
    // x86_64; each becomes one or two ELF relocs against the
    // `.data` section symbol with `r_addend = data_offset`.
    for fx in &build.data_fixups {
        let (sym, addend) = data_section_ref(fx.data_offset as i64);
        emit_addr_fixup_relocs(
            machine_for_rela,
            &mut rela_bytes,
            fx.instr_offset as u64,
            sym,
            addend,
            fx.part,
        )?;
    }

    // Switch-table base materializations: same shape as a data
    // fixup, resolved against the table entry's section symbol.
    for fx in &build.rodata.addr_fixups {
        let (e, base) = jt_placement.ok_or_else(|| {
            C5Error::Compile(crate::c5::error::fmt_internal_err(
                "elf_reloc: table fixup recorded without table bytes",
            ))
        })?;
        emit_addr_fixup_relocs(
            machine_for_rela,
            &mut rela_bytes,
            fx.code_offset as u64,
            carve.sym_idx[e],
            base as i64 + fx.rodata_offset as i64,
            AddrPart::Whole,
        )?;
    }

    // Switch-table entry slots, one relocation per slot against the
    // `.text` section symbol (or a carved function's own section).
    // The 8-byte absolute rows carry `addend = text_offset`, the
    // addend-names-the-target shape jump-table discovery keys on; a
    // pc-relative row's `A = text_offset + (slot - table base)`
    // reproduces `target - table_base` at the slot wherever the
    // linker places either section. Recorded now so the `.rela`
    // companion bookkeeping below sees the entry as reloc-bearing;
    // the blob's bytes join the entry with the other named-section
    // payloads.
    if let Some((e, base)) = jt_placement {
        let (rtype_pcrel32, rtype_jt_abs64) = match machine_for_rela {
            Machine::X86_64 => (R_X86_64_PC32, R_X86_64_64),
            Machine::Aarch64 => (R_AARCH64_PREL32, R_AARCH64_ABS64),
        };
        let map = |off: u64| match carve.map_text(off) {
            Some((te, new_off)) => (carve.sym_idx[te], new_off as i64),
            None => (text_sym_idx, off as i64),
        };
        let rel32: Vec<(u64, i64, i64)> = build
            .rodata
            .rel32
            .iter()
            .map(|r| {
                let (sym, target) = map(r.text_offset);
                let skew = r.slot_offset as i64 - r.base_offset as i64;
                (sym, r.slot_offset as i64, target + skew)
            })
            .collect();
        let abs64: Vec<(u64, i64, i64)> = build
            .rodata
            .abs64
            .iter()
            .map(|r| {
                let (sym, target) = map(r.text_offset);
                (sym, r.slot_offset as i64, target)
            })
            .collect();
        let ent = &mut carve.table.entries[e];
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

    // Cross-TU data references. The reloc targets the named
    // undefined-data symbol with addend zero so the linker resolves
    // it against the defining TU's storage. Per-arch addressing:
    // * x86_64 small model -- GOT load with the relaxable marking. The
    //   linker relaxes an in-image resolution back to `lea` (a fully
    //   static link ends with an empty GOT) and keeps the indirection
    //   for a shared-library resolution.
    // * x86_64 kernel model -- `mov reg, $sym` + `R_X86_64_32S`: every
    //   symbol is in the sign-extended 32-bit range and no GOT exists.
    // * aarch64 -- direct `adrp + add`, the same pair local data uses.
    //   No linker relaxes the aarch64 GOT forms, so a GOT reference
    //   cannot serve images whose layout forbids a GOT; the direct
    //   pair resolves within any image, including a PIE, and a
    //   definition only a shared library supplies binds through the
    //   copy relocation / canonical PLT the system linker creates for
    //   direct references from executables.
    for r in &build.user_extern_data_refs {
        // A name this unit's assembly defines binds to that local
        // definition, as gas binds a reference within one translation unit.
        // A GOT reference keeps the symbol: the slot is per-symbol, so the
        // section+offset reduction has nothing to bind to there.
        let form = extern_addr_form(r.symbol_name.as_str());
        // A function-alias name resolves against its defined (weak)
        // symbol; the reference form stays symbolic so the linker's
        // binding decides which definition the address names.
        let alias_sym = program
            .function_aliases
            .iter()
            .any(|a| a.name == r.symbol_name)
            .then(|| func_symidx_by_name.get(r.symbol_name.as_str()).copied())
            .flatten();
        let (sym_idx, base) = match alias_sym {
            Some(i) => (i as u64, 0),
            None => match asm_label_ref(r.symbol_name.as_str()) {
                Some(_) if form == ExternAddrForm::Got => (
                    *asm_label_symidx
                        .get(r.symbol_name.as_str())
                        .expect("a resolved asm label has a symbol") as u64,
                    0,
                ),
                Some(pair) => pair,
                None => {
                    let pos = user_extern_data_names
                        .iter()
                        .position(|n| *n == r.symbol_name.as_str())
                        .expect("user_extern_data_names contains every ref's name");
                    (user_extern_data_sym_idx[pos] as u64, 0)
                }
            },
        };
        // A segment-qualified inline-asm `%a` operand takes a direct
        // `R_X86_64_PC32` against the symbol (x86_64 only): the access rides
        // the symbol's link-time value, so the GOT indirection the default
        // form uses would be wrong. The disp32 sits at `instr_offset + 3`.
        if let Some(addend) = r.direct_pcrel {
            write_struct(
                &mut rela_bytes,
                &Elf64Rela {
                    r_offset: r.instr_offset as u64 + 3,
                    r_info: (sym_idx << 32) | R_X86_64_PC32 as u64,
                    r_addend: addend + base,
                },
            );
            continue;
        }
        match form {
            ExternAddrForm::Got => emit_got_ref_relocs(
                machine_for_rela,
                &mut rela_bytes,
                r.instr_offset as u64,
                sym_idx,
            ),
            ExternAddrForm::Abs32 => {
                emit_abs32_ref_reloc(&mut rela_bytes, r.instr_offset as u64, sym_idx, base)
            }
            ExternAddrForm::Direct => emit_addr_fixup_relocs(
                machine_for_rela,
                &mut rela_bytes,
                r.instr_offset as u64,
                sym_idx,
                base,
                AddrPart::Whole,
            )?,
        }
    }

    // Function-pointer literals. Same shape as data fixups but
    // the target is another position inside `.text`, so the
    // section symbol is `.text` and the addend is the target's
    // native offset within the section.
    for fx in &build.func_fixups {
        emit_addr_fixup_relocs(
            machine_for_rela,
            &mut rela_bytes,
            fx.instr_offset as u64,
            text_sym_idx,
            fx.target_native_offset as i64,
            fx.part,
        )?;
    }

    // Inline-asm main-stream references to labels placed in the template's
    // pushed sections. The relocated field sits in `.text`; the target is the
    // named section's symbol, with the label's placed offset folded into the
    // addend (section-block base + within-section offset + field-end skew).
    for r in &build.asm_section_text_refs {
        let (e, base) = asm_placements[r.section_index];
        let sym = carve.sym_idx[e];
        let addend = base as i64 + r.section_offset as i64 + r.addend;
        let rtype = match r.kind {
            crate::c5::asm::AsmRelocKind::Data => match machine_for_rela {
                Machine::X86_64 if r.absolute => R_X86_64_32S,
                Machine::X86_64 => R_X86_64_PC32,
                Machine::Aarch64 => R_AARCH64_PREL32,
            },
            // An aarch64 branch / `adr` field into the pushed section.
            kind => a64_insn_reloc_type(kind).expect("every instruction-field kind maps to a type"),
        };
        write_struct(
            &mut rela_bytes,
            &Elf64Rela {
                r_offset: r.instr_offset as u64,
                r_info: (sym << 32) | rtype as u64,
                r_addend: addend,
            },
        );
    }

    // Inline-asm `$LABEL` address immediates (`pushq $1f`): the 4-byte field
    // takes an absolute `R_X86_64_32S` against the `.text` symbol with the
    // label's text offset as addend. x86_64 only; no aarch64 form emits one.
    for r in &build.asm_text_abs_refs {
        write_struct(
            &mut rela_bytes,
            &Elf64Rela {
                r_offset: r.field_offset as u64,
                r_info: (text_sym_idx << 32) | R_X86_64_32S as u64,
                r_addend: r.target_offset as i64,
            },
        );
    }

    // Undefined-symbol index by name. The three name lists are
    // disjoint by construction (each is filtered against the ones
    // before it), so one map answers all three.
    let mut extern_symidx_by_name: alloc::collections::BTreeMap<&str, usize> =
        alloc::collections::BTreeMap::new();
    for (list, idx) in [
        (&user_extern_names, &user_extern_sym_idx),
        (&user_extern_data_names, &user_extern_data_sym_idx),
        (&asm_extern_names, &asm_extern_sym_idx),
    ] {
        for (k, n) in list.iter().enumerate() {
            extern_symidx_by_name.insert(n, idx[k]);
        }
    }

    // Function-body inline-asm symbol-operand sites: one row per record at
    // the instruction word, typed by the field kind. The target resolves
    // like an inline-asm section reloc's: a resolved data offset, an asm
    // label, a defined function or data object, or an undefined symbol.
    for r in &build.asm_sym_fixups {
        use crate::c5::asm::AsmSectionTarget;
        let (sym_idx, addend) = match &r.target {
            AsmSectionTarget::Data(off) => {
                home_sym(plan.map_ref(off.wrapping_add_signed(r.addend), *off))
            }
            AsmSectionTarget::Symbol(name) => {
                // A dropped alias resolves against its chain's end, its
                // distance from it riding in the addend.
                let (name, alias_off) = undef_alias_end
                    .get(name.as_str())
                    .copied()
                    .unwrap_or((name.as_str(), 0));
                let (sym, base) = if let Some(pair) = asm_label_ref(name) {
                    pair
                } else if let Some(&idx) = func_symidx_by_name.get(name) {
                    (idx as u64, 0)
                } else if let Some(&idx) = defined_data_symidx.get(name) {
                    (idx, 0)
                } else if let Some(val) = defined_data_by_name(name) {
                    data_section_ref(val)
                } else if let Some(&idx) = extern_symidx_by_name.get(name) {
                    (idx as u64, 0)
                } else {
                    return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                        &alloc::format!(
                            "elf_reloc: asm operand relocation names `{name}`, which \
                             reached no defined or undefined symbol"
                        ),
                    )));
                };
                (sym, base + r.addend + alias_off)
            }
            other => {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &alloc::format!(
                        "elf_reloc: asm operand relocation target {other:?} is not a \
                         data offset or symbol"
                    ),
                )));
            }
        };
        // The x86_64 rel32 branch field (a jmp / jcc to a rebindable name):
        // `instr_offset` is the field itself, and a target keeping its own
        // symbol binds through the PLT slot as the section path types it; a
        // target reduced to a section symbol names no entry point.
        let x86_jump = matches!(r.kind, crate::c5::asm::AsmRelocKind::JumpRel)
            && machine_for_rela == Machine::X86_64;
        let rtype = match a64_insn_reloc_type(r.kind) {
            Some(t) => t,
            None if x86_jump
                && r.addend == -4
                && !fixed_section_syms.contains(&sym_idx)
                && !carve.sym_idx.contains(&sym_idx) =>
            {
                R_X86_64_PLT32
            }
            None if x86_jump => R_X86_64_PC32,
            None => {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &alloc::format!(
                        "elf_reloc: asm operand relocation kind {:?} names no field type",
                        r.kind
                    ),
                )));
            }
        };
        write_struct(
            &mut rela_bytes,
            &Elf64Rela {
                r_offset: r.instr_offset as u64,
                r_info: (sym_idx << 32) | rtype as u64,
                r_addend: addend,
            },
        );
    }

    // Route `.rela.text` rows applying within a carved range into the
    // owning named section, and retarget rows whose text-section
    // addend the carve moved.
    carve_partition_relas(&mut rela_bytes, &mut carve, text_sym_idx);

    // Inline-asm section relocations join the owning table entry,
    // offset by the block's placement base. A text-offset target in a
    // carved range retargets to the named section's symbol; a name
    // resolves to a defined function, a defined data object, or an
    // undefined symbol.
    {
        use crate::c5::asm::AsmSectionTarget;
        // The STT_SECTION symbols a reduction can land on. A branch against
        // one names no function, so no PLT slot can carry it.
        let section_syms: alloc::collections::BTreeSet<u64> = fixed_section_syms
            .clone()
            .chain(carve.sym_idx.iter().copied())
            .collect();
        for (&(e, base), s) in asm_placements.iter().zip(build.asm_sections.iter()) {
            for r in &s.relocs {
                let (sym_idx, addend) = match &r.target {
                    AsmSectionTarget::Text(off) => match carve.map_text(*off as u64) {
                        Some((te, new_off)) => (carve.sym_idx[te], new_off as i64 + r.addend),
                        None => (text_sym_idx, *off as i64 + r.addend),
                    },
                    AsmSectionTarget::Data(off) => {
                        let (sym, o) = home_sym(plan.map(*off));
                        (sym, o + r.addend)
                    }
                    // The section the relocation lives in (`.quad .`):
                    // its own section symbol plus the offset.
                    AsmSectionTarget::OwnSection(off) => {
                        (carve.sym_idx[e], base as i64 + *off as i64 + r.addend)
                    }
                    // A bare section name: that section's own symbol. Its
                    // placement carries the base the merge gave it.
                    AsmSectionTarget::SectionStart(key) => {
                        let at = build
                            .asm_sections
                            .iter()
                            .position(|s| crate::c5::asm::section_key_of(s) == *key)
                            .ok_or_else(|| {
                                C5Error::Compile(crate::c5::error::fmt_internal_err(
                                    &alloc::format!(
                                        "elf_reloc: asm relocation names section `{key}`, \
                                         which the unit does not define"
                                    ),
                                ))
                            })?;
                        let (te, tbase) = asm_placements[at];
                        (carve.sym_idx[te], tbase as i64 + r.addend)
                    }
                    AsmSectionTarget::TextBlock(_) => {
                        // Rewritten to `Text` after block layout; an unresolved
                        // one here means the emit skipped resolve_asm_goto_relocs.
                        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                            "elf_reloc: unresolved asm-goto section relocation",
                        )));
                    }
                    AsmSectionTarget::DeferredText { .. } => {
                        // Rewritten to `Text` once the region is placed; an
                        // unresolved one means resolve_asm_deferred_relocs was
                        // skipped.
                        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                            "elf_reloc: unresolved deferred-replacement section relocation",
                        )));
                    }
                    AsmSectionTarget::Expr(_) => {
                        // Resolved against the layout when the section
                        // materializes; an unresolved one means the operand
                        // expression never reached that pass.
                        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                            "elf_reloc: unresolved operand-expression section relocation",
                        )));
                    }
                    AsmSectionTarget::Symbol(name) => {
                        // A dropped alias resolves against its chain's end,
                        // its distance from it riding in the addend.
                        let (name, alias_off) = undef_alias_end
                            .get(name.as_str())
                            .copied()
                            .unwrap_or((name.as_str(), 0));
                        let addend = r.addend + alias_off;
                        if let Some((sym, base)) = asm_label_ref(name) {
                            (sym, base + addend)
                        } else if let Some(&idx) = func_symidx_by_name.get(name) {
                            (idx as u64, addend)
                        } else if let Some(&idx) = defined_data_symidx.get(name) {
                            // An external-linkage object carries its binding on
                            // its own symbol; reducing to section+addend would
                            // present it to readers as a local definition.
                            (idx, addend)
                        } else if let Some(val) = defined_data_by_name(name) {
                            let (sym, off) = data_section_ref(val);
                            (sym, off + addend)
                        } else if let Some(&idx) = extern_symidx_by_name.get(name) {
                            (idx as u64, addend)
                        } else {
                            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                                &alloc::format!(
                                    "elf_reloc: asm relocation names `{name}`, which reached \
                                     no defined or undefined symbol"
                                ),
                            )));
                        }
                    }
                };
                use crate::c5::asm::AsmRelocKind as RK;
                let rtype = match r.kind {
                    RK::Data | RK::JumpRel => match (abi, r.pcrel, r.width) {
                        // A replacement instruction's direct `call` / `jmp` to a
                        // named symbol reaches it through the PLT slot, like a
                        // compiler-emitted call: `R_X86_64_PLT32`, not a data
                        // `PC32`. A target reduced to a section symbol binds no
                        // slot, so GNU as leaves it `PC32`, and so does a
                        // target naming the symbol at an offset (`jmp sym+4`),
                        // which is no entry point.
                        (RelocAbi::X86_64, true, 4)
                            if r.branch
                                && !section_syms.contains(&sym_idx)
                                && r.addend == -(r.width as i64) =>
                        {
                            R_X86_64_PLT32
                        }
                        (RelocAbi::X86_64, false, 8) => R_X86_64_64,
                        // A `push $symbol` imm32 the CPU sign-extends takes 32S.
                        (RelocAbi::X86_64, false, 4) if r.signed => R_X86_64_32S,
                        // A 16-bit field is the `.code16` boot stubs' address
                        // and near-branch width; the reloc must match it or the
                        // link writes over the following instruction. An 8-bit
                        // field is a byte-width symbol immediate (`movb $sym,
                        // %al`).
                        (RelocAbi::X86_64, false, 2) => R_X86_64_16,
                        (RelocAbi::X86_64, false, 1) => R_X86_64_8,
                        (RelocAbi::X86_64, false, _) => R_X86_64_32,
                        (RelocAbi::X86_64, true, 8) => R_X86_64_PC64,
                        (RelocAbi::X86_64, true, 2) => R_X86_64_PC16,
                        // A rel8-only branch (`loop`, `jcxz`) to a non-local
                        // name; the type must match the one-byte field.
                        (RelocAbi::X86_64, true, 1) => R_X86_64_PC8,
                        (RelocAbi::X86_64, true, _) => R_X86_64_PC32,
                        // i386 has no 64-bit field: the psABI defines no
                        // 8-byte absolute or PC-relative relocation, so a
                        // `.quad` naming a symbol cannot be represented.
                        (RelocAbi::I386, _, 8) => {
                            return Err(asm_section_err(
                                carve.table.entries[e].name.as_str(),
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
                    },
                    kind => a64_insn_reloc_type(kind)
                        .expect("every instruction-field kind maps to a type"),
                };
                carve.table.entries[e]
                    .relas
                    .push(super::section_table::SectionRela {
                        offset: base + r.offset as u64,
                        sym: sym_idx,
                        rtype,
                        addend,
                    });
            }
        }
    }

    // `.rela.data` -- absolute 64-bit relocations for
    // pointer-to-global initializers. `Build::data_relocs` carries
    // `(slot_data_offset, target_data_offset)`; each becomes a
    // `R_X86_64_64` / `R_AARCH64_ABS64` reloc at `slot_data_offset`
    // against the section symbol its target's home resolves to, with
    // the home-relative addend (the target maps through its object
    // anchor so a one-past-the-end address follows its object). A row
    // whose slot the plan moved into a named section joins that
    // section's relocation list instead. Built ahead of the
    // section-count planning so every named section's relocation list
    // settles first.
    let rtype_abs64 = match machine_for_rela {
        Machine::X86_64 => R_X86_64_64,
        Machine::Aarch64 => R_AARCH64_ABS64,
    };
    let mut rela_data_bytes: Vec<u8> =
        Vec::with_capacity((build.data_relocs.len() + build.code_relocs.len()) * ELF64_RELA_SIZE);
    let push_data_row =
        |carve: &mut CarvePlan, bytes: &mut Vec<u8>, slot: u64, sym: u64, addend: i64| {
            match plan.map(slot) {
                DataHome::Named(e, off) => {
                    carve.table.entries[e]
                        .relas
                        .push(super::section_table::SectionRela {
                            offset: off,
                            sym,
                            rtype: rtype_abs64,
                            addend,
                        });
                }
                home => {
                    // A relocated slot is file-backed by construction;
                    // a `.bss` home cannot carry one.
                    let r_offset = match home {
                        DataHome::Data(o) => o,
                        _ => slot,
                    };
                    write_struct(
                        bytes,
                        &Elf64Rela {
                            r_offset,
                            r_info: (sym << 32) | rtype_abs64 as u64,
                            r_addend: addend,
                        },
                    );
                }
            }
        };
    for r in &build.data_relocs {
        let (sym, addend) = home_sym(plan.map_ref(r.target_offset, r.target_anchor));
        push_data_row(&mut carve, &mut rela_data_bytes, r.data_offset, sym, addend);
    }
    // Pointer-to-extern-data initializers: the reloc targets the named
    // undefined-data symbol so the linker resolves it against the
    // defining unit's storage. The addend carries the byte offset added
    // to the symbol (`&extern_arr[N]`).
    for r in &build.extern_data_relocs {
        let name = r.symbol_name.as_str();
        // A name this unit defines through an alias resolves against the
        // alias's own symbol, as a call through one does.
        let alias_sym = defines_alias(name)
            .then(|| func_symidx_by_name.get(name).copied())
            .flatten();
        let (sym_idx, base) = match (asm_label_ref(name), alias_sym) {
            (Some(pair), _) => pair,
            (None, Some(idx)) => (idx as u64, 0),
            (None, None) => {
                let pos = user_extern_data_names
                    .iter()
                    .position(|n| *n == name)
                    .expect("user_extern_data_names contains every extern_data_reloc name");
                (user_extern_data_sym_idx[pos] as u64, 0)
            }
        };
        push_data_row(
            &mut carve,
            &mut rela_data_bytes,
            r.data_offset,
            sym_idx,
            base + r.addend,
        );
    }
    // Function-pointer initializers: same `R_*_64` shape as
    // pointer-to-global, but the addend is the target
    // function's native byte offset within `.text` (looked up
    // via `pc_to_native`) and the reloc points at the
    // `.text` section symbol -- or the named section's when the
    // carve moved the target function.
    // Label-address initializers: the `R_*_64` shape of a
    // function-pointer initializer with the label's own text offset as
    // the addend.
    for r in &build.label_relocs {
        let (sym, addend) = match carve.map_text(r.text_offset) {
            Some((te, new_off)) => (carve.sym_idx[te], new_off as i64),
            None => (text_sym_idx, r.text_offset as i64),
        };
        push_data_row(&mut carve, &mut rela_data_bytes, r.data_offset, sym, addend);
    }
    for r in &build.code_relocs {
        let ent_pc = r.target_ent_pc as usize;
        // Cross-TU target: emit against the named UNDEF
        // function symbol so the linker resolves it against
        // the sibling unit's defined entry. `r_addend = 0`
        // since the named symbol carries the target's text
        // offset directly.
        if let Some(&name) = extern_fn_by_pc.get(&ent_pc) {
            // A name this unit defines -- a function alias -- resolves
            // against its defined (weak) symbol; otherwise the UNDEF.
            let (sym_idx, base) = match func_symidx_by_name.get(name) {
                Some(&i) => (i as u64, 0),
                None => match asm_label_ref(name) {
                    Some(pair) => pair,
                    None => {
                        let pos = user_extern_names
                            .iter()
                            .position(|n| *n == name)
                            .expect("user_extern_names contains every code-reloc extern callee");
                        (user_extern_sym_idx[pos] as u64, 0)
                    }
                },
            };
            push_data_row(
                &mut carve,
                &mut rela_data_bytes,
                r.data_offset,
                sym_idx,
                base,
            );
            continue;
        }
        let native_off = build
            .pc_to_native
            .get(ent_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if native_off == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("elf_reloc: code reloc references missing ent_pc {ent_pc}",),
            )));
        }
        let (sym, addend) = match carve.map_text(native_off as u64) {
            Some((te, new_off)) => (carve.sym_idx[te], new_off as i64),
            None => (text_sym_idx, native_off as i64),
        };
        push_data_row(&mut carve, &mut rela_data_bytes, r.data_offset, sym, addend);
    }

    // `.rela.tdata` -- address-constant initializers of `_Thread_local`
    // objects. Same absolute-64 relocation as `.rela.data`; the slot is a
    // `.tdata` offset, which the named-section carve never claims, so the
    // rows go straight into the table.
    let mut rela_tdata_bytes: Vec<u8> = Vec::new();
    {
        let mut push = |slot: u64, sym: u64, addend: i64| {
            write_struct(
                &mut rela_tdata_bytes,
                &Elf64Rela {
                    r_offset: slot,
                    r_info: (sym << 32) | rtype_abs64 as u64,
                    r_addend: addend,
                },
            );
        };
        for r in &build.tls_data_relocs {
            let (sym, addend) = home_sym(plan.map_ref(r.target_offset, r.target_anchor));
            push(r.data_offset, sym, addend);
        }
        for r in &build.tls_extern_data_relocs {
            let (sym_idx, base) = match asm_label_ref(r.symbol_name.as_str()) {
                Some(pair) => pair,
                None => {
                    let pos = user_extern_data_names
                        .iter()
                        .position(|n| *n == r.symbol_name.as_str())
                        .expect("user_extern_data_names contains every extern_data_reloc name");
                    (user_extern_data_sym_idx[pos] as u64, 0)
                }
            };
            push(r.data_offset, sym_idx, base + r.addend);
        }
        for r in &build.tls_code_relocs {
            let ent_pc = r.target_ent_pc as usize;
            if let Some(&name) = extern_fn_by_pc.get(&ent_pc) {
                let (sym_idx, base) = match func_symidx_by_name.get(name) {
                    Some(&i) => (i as u64, 0),
                    None => match asm_label_ref(name) {
                        Some(pair) => pair,
                        None => {
                            let pos = user_extern_names.iter().position(|n| *n == name).expect(
                                "user_extern_names contains every code-reloc extern callee",
                            );
                            (user_extern_sym_idx[pos] as u64, 0)
                        }
                    },
                };
                push(r.data_offset, sym_idx, base);
                continue;
            }
            let Some(&native_off) = build.pc_to_native.get(ent_pc) else {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!("elf_reloc: TLS code reloc references missing ent_pc {ent_pc}"),
                )));
            };
            let (sym, addend) = match carve.map_text(native_off as u64) {
                Some((te, new_off)) => (carve.sym_idx[te], new_off as i64),
                None => (text_sym_idx, native_off as i64),
            };
            push(r.data_offset, sym, addend);
        }
    }

    // `.init_array` / `.fini_array` groups. C99 has no such attribute;
    // GNU practice (matched by every mainstream toolchain) lowers each
    // `__attribute__((constructor))` into an `SHT_INIT_ARRAY` pointer
    // and each `((destructor))` into `SHT_FINI_ARRAY`. An explicit
    // priority rides in the section name (`.init_array.NNNNN`, 5-digit
    // per GNU) so a system linker's `SORT_BY_INIT_PRIORITY` orders
    // across units; unprioritized entries land in the bare
    // `.init_array` the script places last. Entries sharing a group
    // keep source order.
    let mut init_sections =
        build_init_array_sections(&program.init_funcs, &func_symidx_by_name, rtype_abs64)?;
    // Every named section's relocation list is settled; a `.rela`
    // companion exists exactly for the entries that carry relocations.
    let named_rela_count = carve
        .table
        .entries
        .iter()
        .filter(|e| !e.relas.is_empty())
        .count();

    // Generate the DWARF triple for this TU. Address slots end
    // up as placeholders paired with `DwarfReloc` records that
    // the loop below translates into ELF `.rela.debug_*`
    // entries. Without `-g` the DWARF build is skipped entirely and
    // the `.debug_*` sections are not written at all, so `link_-
    // native_objects` sees no debug info and the final image carries
    // none, and the type-catalog walk is avoided on a default build.
    let dwarf = if build.debug_info {
        dwarf_reloc::emit(program, build, source_path, machine, target)
    } else {
        dwarf_reloc::DwarfRelocatable::default()
    };
    // `DW_OP_addr` in a variable's location names the object by its
    // link name; both linkage classes carry a symbol-table entry, and an
    // inline-asm label may have claimed the name first. A thread-local
    // resolves against the unit's own STT_TLS entry.
    let dwarf_obj_sym_idx = |name: &str| -> Option<u64> {
        defined_data_symidx
            .get(name)
            .copied()
            .or_else(|| defined_data_local_symidx.get(name).copied())
            .or_else(|| asm_label_symidx.get(name).map(|&i| i as u64))
            .or_else(|| defined_tls_symidx.get(name).copied())
    };
    let dwarf_section_syms = DwarfSectionSyms {
        text: text_sym_idx,
        line: debug_line_sym_idx,
        abbrev: debug_abbrev_sym_idx,
        strs: debug_str_sym_idx,
    };
    let mut rela_debug_info_bytes: Vec<u8> =
        Vec::with_capacity(dwarf.info_relocs.len() * ELF64_RELA_SIZE);
    for r in &dwarf.info_relocs {
        if let Some(rela) = dwarf_reloc_to_elf_rela(
            r,
            abi,
            dwarf_section_syms,
            &dwarf.reloc_symbols,
            &dwarf_obj_sym_idx,
        )? {
            write_struct(&mut rela_debug_info_bytes, &rela);
        }
    }
    let mut rela_debug_line_bytes: Vec<u8> =
        Vec::with_capacity(dwarf.line_relocs.len() * ELF64_RELA_SIZE);
    for r in &dwarf.line_relocs {
        if let Some(rela) = dwarf_reloc_to_elf_rela(
            r,
            abi,
            dwarf_section_syms,
            &dwarf.reloc_symbols,
            &dwarf_obj_sym_idx,
        )? {
            write_struct(&mut rela_debug_line_bytes, &rela);
        }
    }

    // These tables hold the code generator's own relocations, whose
    // numbers and field offsets name x86-64 / aarch64 instructions. The
    // driver admits only assembled units to ELFCLASS32, so they stay
    // empty; an entry means an i386 code generator arrived without the
    // numbering, and `R_X86_64_64` and `R_386_32` share the number 1.
    if class.is32()
        && !(rela_bytes.is_empty() && rela_data_bytes.is_empty() && init_sections.is_empty())
    {
        return Err(C5Error::Compile(crate::c5::error::fmt_link_err(
            "badc generates no 32-bit machine code; an ELFCLASS32 object carries \
             assembled sections and debug info only",
        )));
    }

    // GNU as on x86 omits a section symbol no relocation references
    // (its aarch64 backend keeps every one). Match each: every
    // relocation table is final here, so drop the unreferenced
    // STT_SECTION entries and re-index the tables.
    if matches!(abi, RelocAbi::X86_64 | RelocAbi::I386) {
        let mut used = alloc::vec![false; symbols.len()];
        let mark = |used: &mut Vec<bool>, table: &[u8]| {
            for rec in table.as_chunks::<ELF64_RELA_SIZE>().0.iter() {
                let info = u64::from_le_bytes(rec[8..16].try_into().unwrap());
                if let Some(u) = used.get_mut((info >> 32) as usize) {
                    *u = true;
                }
            }
        };
        mark(&mut used, &rela_bytes);
        mark(&mut used, &rela_data_bytes);
        mark(&mut used, &rela_debug_info_bytes);
        mark(&mut used, &rela_debug_line_bytes);
        mark(&mut used, &rela_tdata_bytes);
        for s in &init_sections {
            mark(&mut used, &s.rela);
        }
        for e in &carve.table.entries {
            for r in &e.relas {
                if let Some(u) = used.get_mut(r.sym as usize) {
                    *u = true;
                }
            }
        }
        let mut remap: Vec<u64> = Vec::with_capacity(symbols.len());
        let mut kept: Vec<Elf64Sym> = Vec::with_capacity(symbols.len());
        for (i, s) in symbols.iter().enumerate() {
            remap.push(kept.len() as u64);
            if s.st_info & 0xf != STT_SECTION || used[i] {
                kept.push(*s);
            }
        }
        if kept.len() != symbols.len() {
            first_global -= (symbols.len() - kept.len()) as u32;
            symbols = kept;
            let rewrite = |table: &mut [u8]| {
                for rec in table.as_chunks_mut::<ELF64_RELA_SIZE>().0.iter_mut() {
                    let info = u64::from_le_bytes(rec[8..16].try_into().unwrap());
                    let ns = remap[(info >> 32) as usize];
                    rec[8..16].copy_from_slice(&((ns << 32) | (info & 0xffff_ffff)).to_le_bytes());
                }
            };
            rewrite(&mut rela_bytes);
            rewrite(&mut rela_data_bytes);
            rewrite(&mut rela_debug_info_bytes);
            rewrite(&mut rela_debug_line_bytes);
            rewrite(&mut rela_tdata_bytes);
            for s in &mut init_sections {
                rewrite(&mut s.rela);
            }
            for e in &mut carve.table.entries {
                for r in &mut e.relas {
                    r.sym = remap[r.sym as usize];
                }
            }
        }
    }

    // Every relocation table of the fixed set is final here. A
    // relocation section with no entries is dropped: it describes
    // nothing, and a consumer reaching one through its target's
    // `sh_info` link has no entry to read. The `.debug_*` triple goes
    // the same way without `-g`, where it would carry no bytes:
    // `readelf --debug-dump` and `objdump --dwarf` both report an
    // error on a zero-length debug section, and gcc emits none.
    //
    // A shadowed default section goes with them, per the rule above.
    //
    // `shndx_map` renumbers the nominal layout over the sections that
    // survive; the named and `.init_array` groups that follow the
    // fixed set shift by the total. Applied to every recorded index
    // before it is written.
    let no_dwarf = !build.debug_info;
    // Built ahead of the section-count planning: an empty body drops
    // the section, which the note parser reads as it does a foreign
    // object carrying none.
    let note_bytes = build_badc_note(
        &build.imports,
        &program.exports,
        &build.tls_index_fixups,
        &build.macho_tlv_descriptors,
        &build.macho_tlv_fixups,
        &defined_tls_globals,
        &build.elf_tpoff_fixups,
        &prologue_end_pairs,
    );
    let fixed_dropped = [
        (SHIDX_TEXT, text_shadowed),
        (SHIDX_RELA_TEXT, rela_bytes.is_empty()),
        (SHIDX_DATA, data_shadowed),
        (SHIDX_BSS, bss_shadowed),
        (SHIDX_RELA_DATA, rela_data_bytes.is_empty()),
        (SHIDX_NOTE_BADC, note_bytes.is_empty()),
        (SHIDX_DEBUG_INFO, no_dwarf),
        (SHIDX_RELA_DEBUG_INFO, rela_debug_info_bytes.is_empty()),
        (SHIDX_DEBUG_ABBREV, no_dwarf),
        (SHIDX_DEBUG_LINE, no_dwarf),
        (SHIDX_RELA_DEBUG_LINE, rela_debug_line_bytes.is_empty()),
        (SHIDX_DEBUG_STR, no_dwarf),
        (SHIDX_RELA_TDATA, rela_tdata_bytes.is_empty()),
    ];
    let dropped_below = |n: u16| -> u16 {
        fixed_dropped
            .iter()
            .filter(|&&(idx, dropped)| dropped && idx < n)
            .count() as u16
    };
    let dropped_sections = dropped_below(base_sections as u16);
    let shndx_map = |n: u16| -> u16 {
        if n == 0 || n >= SHN_LORESERVE {
            n
        } else if n >= base_sections as u16 {
            n - dropped_sections
        } else {
            n - dropped_below(n)
        }
    };
    for s in &mut symbols {
        s.st_shndx = shndx_map(s.st_shndx);
    }
    for x in &mut carve.shndx {
        *x = shndx_map(*x);
    }
    let shidx_text = shndx_map(SHIDX_TEXT);
    let shidx_data = shndx_map(SHIDX_DATA);
    let shidx_symtab = shndx_map(SHIDX_SYMTAB);
    let shidx_strtab = shndx_map(SHIDX_STRTAB);
    let shidx_shstrtab = shndx_map(SHIDX_SHSTRTAB);
    let shidx_debug_info = shndx_map(SHIDX_DEBUG_INFO);
    let shidx_debug_line = shndx_map(SHIDX_DEBUG_LINE);

    // `.comment` pools the unit's `.ident` strings in GNU as shape
    // (leading NUL, each string NUL-terminated); a compiled unit
    // contributes the producer fingerprint the way gcc's implicit
    // `.ident` does. An assembled unit without `.ident` gets no
    // `.comment`, as GNU as emits none.
    let comment_body: Option<Vec<u8>> = {
        let mut strings: Vec<&str> = Vec::new();
        if !program.asm_unit {
            strings.push(crate::OUTPUT_MARKER);
        }
        strings.extend(program.asm_idents.iter().map(|s| s.as_str()));
        if strings.is_empty() {
            None
        } else {
            let mut body: Vec<u8> = alloc::vec![0];
            for s in &strings {
                body.extend_from_slice(s.as_bytes());
                body.push(0);
            }
            Some(body)
        }
    };
    let num_sections: usize = base_sections - dropped_sections as usize
        + named_section_count
        + named_rela_count
        + 2 * init_sections.len()
        + usize::from(comment_body.is_some());

    // Section name table. One entry per non-null section, in section
    // order, so the name of section `n` sits at `shndx_map(n) - 1`.
    let rp = reloc_prefix(class);
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
    let mut shstrtab_names: Vec<String> = Vec::with_capacity(num_sections);
    for (i, name) in fixed_names.iter().enumerate() {
        let nominal = i as u16 + 1;
        if !fixed_dropped
            .iter()
            .any(|&(idx, dropped)| dropped && idx == nominal)
        {
            shstrtab_names.push(name.clone());
        }
    }
    // `.tdata` / `.tbss` names follow the fixed set when the unit
    // carries TLS.
    if has_tls {
        shstrtab_names.push(".tdata".to_string());
        shstrtab_names.push(".tbss".to_string());
    }
    if !rela_tdata_bytes.is_empty() {
        shstrtab_names.push(format!("{rp}.tdata"));
    }
    // Named sections (attribute placements + inline-asm payloads) take
    // the indices right after the fixed set; the on-demand `.rela`
    // companions follow the block.
    let named_names_start = shstrtab_names.len();
    for e in &carve.table.entries {
        shstrtab_names.push(e.name.clone());
    }
    // `named_rela_pos[k]` is entry k's position among the rela-bearing
    // entries; only those contribute a `.rela<name>` string.
    let named_rela_names_start = shstrtab_names.len();
    let mut named_rela_pos: Vec<usize> = Vec::with_capacity(carve.table.entries.len());
    for e in &carve.table.entries {
        named_rela_pos.push(shstrtab_names.len() - named_rela_names_start);
        if !e.relas.is_empty() {
            shstrtab_names.push(format!("{rp}{}", e.name));
        }
    }
    // `.init_array*` / `.fini_array*` names and their `.rela.*`
    // companions, appended last so the fixed and TLS indices stay put.
    let init_names_start = shstrtab_names.len();
    for s in &init_sections {
        shstrtab_names.push(s.name.clone());
        shstrtab_names.push(format!("{rp}{}", s.name));
    }
    let comment_name_idx = shstrtab_names.len();
    if comment_body.is_some() {
        shstrtab_names.push(".comment".to_string());
    }
    let name_refs: Vec<&str> = shstrtab_names.iter().map(|n| n.as_str()).collect();
    let (shstrtab_bytes, shstrtab_offs) = build_string_table(&name_refs);
    // Name offset of a fixed section, addressed by its nominal index.
    let fixed_name = |nominal: u16| shstrtab_offs[shndx_map(nominal) as usize - 1];

    // Serialized last of all, so `shndx_map` has already compacted
    // every `st_shndx`.
    let mut symtab_bytes: Vec<u8> = Vec::with_capacity(symbols.len() * class.sym_size() as usize);
    for s in &symbols {
        write_sym(class, s, &mut symtab_bytes);
    }

    // Section data layout. Each section's offset starts at the
    // running tail of the output, rounded to its alignment.
    let mut out: Vec<u8> = alloc::vec![0u8; class.ehdr_size() as usize];

    let mut sh: Vec<Elf64Shdr> = Vec::with_capacity(num_sections);
    sh.push(Elf64Shdr::default()); // SHN_UNDEF

    // .text -- extern materializations are rewritten to match the relocs
    // emitted above: GOT loads (`rewrite_extern_addr_loads_to_got`) or,
    // under the x86-64 kernel model, `mov reg, $sym`
    // (`rewrite_extern_addr_loads_to_abs32`). The sites are the import
    // address-of sites (`reloc_call_sites` with `is_addr`) and the
    // cross-TU data references (`user_extern_data_refs`) whose form is
    // not `Direct`. Same length as `build.text`. A `direct_pcrel` ref is
    // already a `mov`/`op sym(%rip)` in the emitted text, not a `lea` to
    // rewrite.
    let mut got_site_offsets: alloc::vec::Vec<usize> = alloc::vec::Vec::new();
    let mut abs_site_offsets: alloc::vec::Vec<usize> = alloc::vec::Vec::new();
    for r in &build.user_extern_data_refs {
        if r.direct_pcrel.is_some() {
            continue;
        }
        match extern_addr_form(r.symbol_name.as_str()) {
            ExternAddrForm::Got => got_site_offsets.push(r.instr_offset),
            ExternAddrForm::Abs32 => abs_site_offsets.push(r.instr_offset),
            ExternAddrForm::Direct => {}
        }
    }
    for s in build.reloc_call_sites.iter().filter(|s| s.is_addr) {
        if kernel_abs {
            abs_site_offsets.push(s.instr_offset);
        } else {
            got_site_offsets.push(s.instr_offset);
        }
    }
    let mut text_body =
        rewrite_extern_addr_loads_to_got(machine_for_rela, &build.text, &got_site_offsets);
    rewrite_extern_addr_loads_to_abs32(&mut text_body, &abs_site_offsets);
    // Carve the named-section function groups out of the `.text` tail;
    // the default prefix and the trailing version marker stay.
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
    fold_rel_addends(class, &rela_bytes, &mut text_body)?;
    if !text_shadowed {
        // An empty section constrains nothing; GNU as leaves the
        // default sections it creates at alignment 1.
        let text_align = if text_body.is_empty() {
            1
        } else {
            build.text_align.max(16) as u64
        };
        let text_off = round_up(out.len() as u64, text_align);
        out.resize(text_off as usize, 0);
        out.extend_from_slice(&text_body);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_TEXT),
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_ALLOC | SHF_EXECINSTR,
            sh_offset: text_off,
            sh_size: text_body.len() as u64,
            sh_addralign: text_align,
            ..Default::default()
        });
    }

    // .rela.text -- one entry per `RelocCallSite`. `sh_link`
    // points at the symbol table; `sh_info` at the section the
    // relocations apply to (`.text`). The `SHF_INFO_LINK` flag
    // signals the latter usage of `sh_info`.
    if !rela_bytes.is_empty() {
        let table = encode_reloc_table(class, &rela_bytes);
        let rela_off = round_up(out.len() as u64, class.addr_size());
        out.resize(rela_off as usize, 0);
        out.extend_from_slice(&table);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_RELA_TEXT),
            sh_type: reloc_sht(class),
            sh_flags: SHF_INFO_LINK,
            sh_offset: rela_off,
            sh_size: table.len() as u64,
            sh_link: shidx_symtab as u32,
            sh_info: shidx_text as u32,
            sh_addralign: class.addr_size(),
            sh_entsize: reloc_entsize(class),
            ..Default::default()
        });
    }

    // RELA carries the addend in `r_addend`; the slot bytes under a
    // relocation are dead in the image and gas leaves them zero, which
    // a consumer that validates the slot before applying it requires.
    // `build.data` bakes VM values into pointer slots (the target's
    // data offset, a function's `ent_pc`), so clear each relocated
    // slot before the bytes are copied out.
    let data_src = {
        let mut cleared = build.data.clone();
        for off in relocated_data_offsets(program, &build.label_relocs) {
            let off = off as usize;
            let Some(slot) = cleared.get_mut(off..off + 8) else {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!(
                        "elf_reloc: relocated slot {off:#x} past end of .data ({})",
                        build.data.len(),
                    ),
                )));
            };
            slot.fill(0);
        }
        cleared
    };
    // .data -- `sh_addralign` carries the alignment of the content the
    // plan keeps here. Objects moved into a named section copy their
    // bytes there (a `.bss`-resident wholly-zero object contributes
    // zeros); the remaining content packs at the planned positions and
    // the dropped alignment padding leaves no file bytes behind.
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
                    body[b..b + (file_hi - file_lo)].copy_from_slice(&data_src[file_lo..file_hi]);
                }
                DataHome::Named(e, b) => {
                    // Written at the planned base: spans arrive in
                    // unified order, which zero-object segregation may
                    // have permuted relative to the declaration-order
                    // bases. A `.bss`-resident span keeps the zero fill
                    // the resize provides.
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
    // Inline-asm payloads follow the attribute content of their entry
    // at the placement bases planned above.
    for (&(e, base), s) in asm_placements.iter().zip(build.asm_sections.iter()) {
        let ent = &mut carve.table.entries[e];
        if (ent.bytes.len() as u64) < base {
            ent.bytes.resize(base as usize, 0);
        }
        ent.bytes.extend_from_slice(&s.bytes);
    }
    if let Some((e, base, body)) = &gnu_property_note {
        let ent = &mut carve.table.entries[*e];
        if (ent.bytes.len() as u64) < *base {
            ent.bytes.resize(*base as usize, 0);
        }
        ent.bytes.extend_from_slice(body);
    }
    // Switch-table blob bytes; slots stay zero, the entry's `.rela`
    // rows recorded above carry the values.
    if let Some((e, base)) = jt_placement {
        let ent = &mut carve.table.entries[e];
        if (ent.bytes.len() as u64) < base {
            ent.bytes.resize(base as usize, 0);
        }
        ent.bytes.extend_from_slice(&build.rodata.bytes);
    }
    if !data_shadowed {
        let data_align = if data_body.is_empty() {
            1
        } else {
            plan.data_align
        };
        let data_off = round_up(out.len() as u64, data_align);
        out.resize(data_off as usize, 0);
        out.extend_from_slice(&data_body);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_DATA),
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_ALLOC | SHF_WRITE,
            sh_offset: data_off,
            sh_size: data_body.len() as u64,
            sh_addralign: data_align,
            ..Default::default()
        });
    }

    // .bss (no file bytes) -- zero-init data segregated past the file
    // image; the linker zero-fills it. Its alignment covers the
    // zero-init objects the plan keeps in it; a fixed 16 would
    // silently under-align an over-aligned one.
    if !bss_shadowed {
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_BSS),
            sh_type: SHT_NOBITS,
            sh_flags: SHF_ALLOC | SHF_WRITE,
            sh_offset: out.len() as u64,
            sh_size: plan.bss_len,
            sh_addralign: if plan.bss_len == 0 { 1 } else { plan.bss_align },
            ..Default::default()
        });
    }

    // .symtab
    let symtab_off = round_up(out.len() as u64, 8);
    out.resize(symtab_off as usize, 0);
    out.extend_from_slice(&symtab_bytes);
    sh.push(Elf64Shdr {
        sh_name: fixed_name(SHIDX_SYMTAB),
        sh_type: SHT_SYMTAB,
        sh_offset: symtab_off,
        sh_size: symtab_bytes.len() as u64,
        sh_link: shidx_strtab as u32,
        sh_info: first_global,
        sh_addralign: 8,
        sh_entsize: class.sym_size(),
        ..Default::default()
    });

    // .strtab
    let strtab_off = out.len() as u64;
    out.extend_from_slice(&strtab_bytes);
    sh.push(Elf64Shdr {
        sh_name: fixed_name(SHIDX_STRTAB),
        sh_type: SHT_STRTAB,
        sh_offset: strtab_off,
        sh_size: strtab_bytes.len() as u64,
        sh_addralign: 1,
        ..Default::default()
    });

    // .shstrtab
    let shstrtab_off = out.len() as u64;
    out.extend_from_slice(&shstrtab_bytes);
    sh.push(Elf64Shdr {
        sh_name: fixed_name(SHIDX_SHSTRTAB),
        sh_type: SHT_STRTAB,
        sh_offset: shstrtab_off,
        sh_size: shstrtab_bytes.len() as u64,
        sh_addralign: 1,
        ..Default::default()
    });

    // .rela.data -- built and carve-partitioned above, before the
    // section-count planning.
    if !rela_data_bytes.is_empty() {
        let table = encode_reloc_table(class, &rela_data_bytes);
        let rela_data_off = round_up(out.len() as u64, class.addr_size());
        out.resize(rela_data_off as usize, 0);
        out.extend_from_slice(&table);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_RELA_DATA),
            sh_type: reloc_sht(class),
            sh_flags: SHF_INFO_LINK,
            sh_offset: rela_data_off,
            sh_size: table.len() as u64,
            sh_link: shidx_symtab as u32,
            sh_info: shidx_data as u32,
            sh_addralign: class.addr_size(),
            sh_entsize: reloc_entsize(class),
            ..Default::default()
        });
    }

    // .note.badc -- vendor note section. Two records under
    // namesz="badc\0":
    //   NT_BADC_DYLIBS       -- NUL-separated `#pragma dylib`
    //                           paths. Drives DT_NEEDED /
    //                           LC_LOAD_DYLIB / IMAGE_IMPORT_DESCRIPTOR.
    //   NT_BADC_BINDING_MAP  -- (u32 dylib_index, NUL-terminated
    //                           import name)+. Routes each import
    //                           to its owning dylib so a cross-DLL
    //                           reference (kernel32 + ucrtbase in
    //                           the same PE) places its IAT slot
    //                           under the right loader entry.
    // Standard ELF tooling ignores unknown note types; the badc
    // reader picks the entries up by name + type. Dropped above when
    // no record has content.
    if !note_bytes.is_empty() {
        let note_off = round_up(out.len() as u64, 4);
        out.resize(note_off as usize, 0);
        out.extend_from_slice(&note_bytes);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_NOTE_BADC),
            sh_type: SHT_NOTE,
            sh_offset: note_off,
            sh_size: note_bytes.len() as u64,
            sh_addralign: 4,
            ..Default::default()
        });
    }

    // .debug_info -- one CU DIE per `.o`. SHT_PROGBITS without
    // SHF_ALLOC: not loaded at runtime, just consumed by the
    // debugger via its `.shdr` walk. Written under `-g` only.
    if !no_dwarf {
        let debug_info_off = out.len() as u64;
        out.extend_from_slice(&dwarf.debug_info);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_DEBUG_INFO),
            sh_type: SHT_PROGBITS,
            sh_offset: debug_info_off,
            sh_size: dwarf.debug_info.len() as u64,
            sh_addralign: 1,
            ..Default::default()
        });
    }

    // .rela.debug_info -- placeholder slots described above.
    if !rela_debug_info_bytes.is_empty() {
        let table = encode_reloc_table(class, &rela_debug_info_bytes);
        let rela_debug_info_off = round_up(out.len() as u64, class.addr_size());
        out.resize(rela_debug_info_off as usize, 0);
        out.extend_from_slice(&table);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_RELA_DEBUG_INFO),
            sh_type: reloc_sht(class),
            sh_flags: SHF_INFO_LINK,
            sh_offset: rela_debug_info_off,
            sh_size: table.len() as u64,
            sh_link: shidx_symtab as u32,
            sh_info: shidx_debug_info as u32,
            sh_addralign: class.addr_size(),
            sh_entsize: reloc_entsize(class),
            ..Default::default()
        });
    }

    // .debug_abbrev -- abbreviation table. No relocs; the slot
    // it's referenced from in `.debug_info` already carries the
    // reloc that rebases to its merged-section offset.
    if !no_dwarf {
        let debug_abbrev_off = out.len() as u64;
        out.extend_from_slice(&dwarf.debug_abbrev);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_DEBUG_ABBREV),
            sh_type: SHT_PROGBITS,
            sh_offset: debug_abbrev_off,
            sh_size: dwarf.debug_abbrev.len() as u64,
            sh_addralign: 1,
            ..Default::default()
        });
    }

    // .debug_line -- per-statement line program. Reloc against
    // `.text` rebases each `DW_LNE_set_address` opcode.
    if !no_dwarf {
        let debug_line_off = out.len() as u64;
        out.extend_from_slice(&dwarf.debug_line);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_DEBUG_LINE),
            sh_type: SHT_PROGBITS,
            sh_offset: debug_line_off,
            sh_size: dwarf.debug_line.len() as u64,
            sh_addralign: 1,
            ..Default::default()
        });
    }

    // .rela.debug_line -- the placeholder slots above.
    if !rela_debug_line_bytes.is_empty() {
        let table = encode_reloc_table(class, &rela_debug_line_bytes);
        let rela_debug_line_off = round_up(out.len() as u64, class.addr_size());
        out.resize(rela_debug_line_off as usize, 0);
        out.extend_from_slice(&table);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_RELA_DEBUG_LINE),
            sh_type: reloc_sht(class),
            sh_flags: SHF_INFO_LINK,
            sh_offset: rela_debug_line_off,
            sh_size: table.len() as u64,
            sh_link: shidx_symtab as u32,
            sh_info: shidx_debug_line as u32,
            sh_addralign: class.addr_size(),
            sh_entsize: reloc_entsize(class),
            ..Default::default()
        });
    }

    // .debug_str -- the unit's name pool, reached from `.debug_info`
    // through relocated `DW_FORM_strp` slots. SHF_MERGE|SHF_STRINGS
    // with sh_entsize 1 is what lets a linker fold across units.
    if !no_dwarf {
        const SHF_MERGE: u64 = 0x10;
        const SHF_STRINGS: u64 = 0x20;
        let debug_str_off = out.len() as u64;
        out.extend_from_slice(&dwarf.debug_str);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_DEBUG_STR),
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_MERGE | SHF_STRINGS,
            sh_offset: debug_str_off,
            sh_size: dwarf.debug_str.len() as u64,
            sh_addralign: 1,
            sh_entsize: 1,
            ..Default::default()
        });
    }

    // TLS sections (only when the unit carries `_Thread_local`
    // storage). `.tdata` holds the initialised slice
    // `tls_data[..tls_init_size]`; `.tbss` is the zero-fill
    // remainder. Both carry SHF_TLS (0x400) so the linker groups
    // them into the PT_TLS segment. object.rs already detects the
    // section families by name + flag and concatenates the bytes
    // into `NativeObject::tls_data` / `tbss_size`.
    if has_tls {
        const SHF_TLS: u64 = 0x400;
        let tls_init_size = program.tls_init_size.min(program.tls_data.len());
        let tdata_off = round_up(out.len() as u64, 16);
        out.resize(tdata_off as usize, 0);
        out.extend_from_slice(&program.tls_data[..tls_init_size]);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_TDATA),
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_ALLOC | SHF_WRITE | SHF_TLS,
            sh_offset: tdata_off,
            sh_size: tls_init_size as u64,
            sh_addralign: 16,
            ..Default::default()
        });
        // .tbss (no file bytes). Size is the zero-fill remainder.
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_TBSS),
            sh_type: SHT_NOBITS,
            sh_flags: SHF_ALLOC | SHF_WRITE | SHF_TLS,
            sh_offset: out.len() as u64,
            sh_size: (program.tls_data.len() - tls_init_size) as u64,
            sh_addralign: 16,
            ..Default::default()
        });
    } else {
        let _ = (SHIDX_TDATA, SHIDX_TBSS);
    }
    // .rela.tdata -- follows `.tbss` so the fixed indices below it stay
    // put. `sh_info` names `.tdata`, whose bytes it patches.
    if !rela_tdata_bytes.is_empty() {
        let table = encode_reloc_table(class, &rela_tdata_bytes);
        let rela_tdata_off = round_up(out.len() as u64, class.addr_size());
        out.resize(rela_tdata_off as usize, 0);
        out.extend_from_slice(&table);
        sh.push(Elf64Shdr {
            sh_name: fixed_name(SHIDX_RELA_TDATA),
            sh_type: reloc_sht(class),
            sh_flags: SHF_INFO_LINK,
            sh_offset: rela_tdata_off,
            sh_size: table.len() as u64,
            sh_link: shidx_symtab as u32,
            sh_info: shndx_map(SHIDX_TDATA) as u32,
            sh_addralign: class.addr_size(),
            sh_entsize: reloc_entsize(class),
            ..Default::default()
        });
    }

    let _ = SHIDX_DEBUG_INFO;
    let _ = SHIDX_RELA_DEBUG_INFO;
    let _ = SHIDX_DEBUG_ABBREV;
    let _ = SHIDX_DEBUG_LINE;
    let _ = SHIDX_RELA_DEBUG_LINE;

    // Named sections (attribute placements + inline-asm payloads) at
    // the indices planned right after the fixed set (`carve.shndx`).
    // `SHT_NOBITS` entries keep their size but contribute no file
    // bytes.
    for e in carve.table.entries.iter_mut() {
        let mut table: Vec<u8> = Vec::with_capacity(e.relas.len() * ELF64_RELA_SIZE);
        for r in &e.relas {
            write_struct(
                &mut table,
                &Elf64Rela {
                    r_offset: r.offset,
                    r_info: (r.sym << 32) | r.rtype as u64,
                    r_addend: r.addend,
                },
            );
        }
        let mut bytes = core::mem::take(&mut e.bytes);
        fold_rel_addends(class, &table, &mut bytes)?;
        e.bytes = bytes;
    }
    for (k, e) in carve.table.entries.iter().enumerate() {
        debug_assert_eq!(sh.len(), carve.shndx[k] as usize);
        // `SHT_NOBITS` contributes no file bytes and needs no file
        // padding; its `sh_offset` is conventional.
        let sec_off = if e.sh_type == SHT_NOBITS {
            out.len() as u64
        } else {
            let off = round_up(out.len() as u64, e.align);
            out.resize(off as usize, 0);
            out.extend_from_slice(&e.bytes);
            off
        };
        sh.push(Elf64Shdr {
            sh_name: shstrtab_offs[named_names_start + k],
            sh_type: e.sh_type,
            sh_flags: e.flags,
            sh_offset: sec_off,
            sh_size: e.bytes.len() as u64,
            sh_addralign: e.align,
            ..Default::default()
        });
    }
    // Their `.rela` companions, only for entries carrying relocations.
    for (k, e) in carve.table.entries.iter().enumerate() {
        if e.relas.is_empty() {
            continue;
        }
        let mut rb: Vec<u8> = Vec::with_capacity(e.relas.len() * ELF64_RELA_SIZE);
        for r in &e.relas {
            let rela = Elf64Rela {
                r_offset: r.offset,
                r_info: (r.sym << 32) | r.rtype as u64,
                r_addend: r.addend,
            };
            write_struct(&mut rb, &rela);
        }
        let table = encode_reloc_table(class, &rb);
        let rela_off = round_up(out.len() as u64, class.addr_size());
        out.resize(rela_off as usize, 0);
        out.extend_from_slice(&table);
        sh.push(Elf64Shdr {
            sh_name: shstrtab_offs[named_rela_names_start + named_rela_pos[k]],
            sh_type: reloc_sht(class),
            sh_flags: SHF_INFO_LINK,
            sh_offset: rela_off,
            sh_size: table.len() as u64,
            sh_link: shidx_symtab as u32,
            sh_info: carve.shndx[k] as u32,
            sh_addralign: class.addr_size(),
            sh_entsize: reloc_entsize(class),
            ..Default::default()
        });
    }

    // `.init_array` / `.fini_array` groups. Each is a zero-filled array
    // of 8-byte pointers (the paired `.rela.*` binds each slot to its
    // function) followed immediately by that `.rela.*` section, whose
    // `sh_info` names the array it patches. Appended last so every
    // fixed and TLS section index is unchanged.
    for (k, s) in init_sections.iter().enumerate() {
        let array_shndx = sh.len() as u32;
        let arr_off = round_up(out.len() as u64, 8);
        out.resize(arr_off as usize, 0);
        out.resize(arr_off as usize + s.count * 8, 0);
        sh.push(Elf64Shdr {
            sh_name: shstrtab_offs[init_names_start + 2 * k],
            sh_type: s.sh_type,
            sh_flags: SHF_ALLOC | SHF_WRITE,
            sh_offset: arr_off,
            sh_size: (s.count * 8) as u64,
            sh_addralign: 8,
            sh_entsize: 8,
            ..Default::default()
        });
        let table = encode_reloc_table(class, &s.rela);
        let rela_off = round_up(out.len() as u64, class.addr_size());
        out.resize(rela_off as usize, 0);
        out.extend_from_slice(&table);
        sh.push(Elf64Shdr {
            sh_name: shstrtab_offs[init_names_start + 2 * k + 1],
            sh_type: reloc_sht(class),
            sh_flags: SHF_INFO_LINK,
            sh_offset: rela_off,
            sh_size: table.len() as u64,
            sh_link: shidx_symtab as u32,
            sh_info: array_shndx,
            sh_addralign: class.addr_size(),
            sh_entsize: reloc_entsize(class),
            ..Default::default()
        });
    }

    // .comment -- non-alloc, so it never reaches the loaded image
    // through this object. Flagged SHF_MERGE | SHF_STRINGS with a byte
    // entsize, as gcc and clang flag theirs, so a linker merging many
    // badc objects folds identical NUL-terminated lines into one copy.
    if let Some(body) = &comment_body {
        let comment_off = out.len() as u64;
        out.extend_from_slice(body);
        sh.push(Elf64Shdr {
            sh_name: shstrtab_offs[comment_name_idx],
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_MERGE | SHF_STRINGS,
            sh_offset: comment_off,
            sh_size: body.len() as u64,
            sh_addralign: 1,
            sh_entsize: 1,
            ..Default::default()
        });
    }

    debug_assert_eq!(sh.len(), num_sections);

    // Section header table at the tail. Rounded to 8 so the
    // headers' u64 fields read cleanly.
    let shoff = round_up(out.len() as u64, class.addr_size());
    out.resize(shoff as usize, 0);
    for entry in &sh {
        write_shdr(class, entry, &mut out);
    }

    // Patch the file header now that all offsets are known.
    let mut e_ident = [0u8; 16];
    e_ident[0..4].copy_from_slice(b"\x7fELF");
    e_ident[4] = class.ei_class();
    e_ident[5] = ELF_DATA_LSB;
    e_ident[6] = ELF_VERSION_CURRENT;
    let ehdr = Elf64Ehdr {
        e_ident,
        e_type: ET_REL,
        e_machine: e_machine_for(abi),
        e_version: ELF_VERSION_CURRENT as u32,
        e_entry: 0,
        e_phoff: 0,
        e_shoff: shoff,
        e_flags: 0,
        e_ehsize: class.ehdr_size() as u16,
        e_phentsize: 0,
        e_phnum: 0,
        e_shentsize: class.shdr_size() as u16,
        e_shnum: num_sections as u16,
        e_shstrndx: shidx_shstrtab,
    };
    let mut hdr_bytes: Vec<u8> = Vec::with_capacity(class.ehdr_size() as usize);
    write_ehdr(class, &ehdr, &mut hdr_bytes);
    out[..hdr_bytes.len()].copy_from_slice(&hdr_bytes);

    Ok(out)
}

fn pack_sym_info(bind: u8, ty: u8) -> u8 {
    (bind << 4) | (ty & 0xf)
}

/// Build the `.note.badc` section body. The records are:
///   NT_BADC_DYLIBS        -- NUL-separated dylib paths.
///   NT_BADC_BINDING_MAP   -- per-import (u32 dylib_index, NUL
///                            import name)+.
///   NT_BADC_EXPORTS       -- NUL-separated `#pragma export` names.
///   NT_BADC_PROLOGUE_END  -- (u64 entry, u64 post-prologue) `.text`
///                            offset pairs.
/// All records share the namesz="badc\0" namespace; the parser
/// distinguishes by `type`. Each note is independently padded to
/// the 4-byte ELF gABI boundary. Every record is omitted when it
/// has no content; the parser reads records by type and tolerates
/// any subset, and the writer drops the section when the body is
/// empty.
/// `NT_GNU_PROPERTY_TYPE_0` (ELF gABI, "Program Property").
const NT_GNU_PROPERTY_TYPE_0: u32 = 5;
/// `GNU_PROPERTY_AARCH64_FEATURE_1_AND` and the two feature bits badc
/// can claim (AArch64 ELF ABI). `GCS` is not claimed: badc runs no
/// analysis that would establish it.
const GNU_PROPERTY_AARCH64_FEATURE_1_AND: u32 = 0xc000_0000;
const GNU_PROPERTY_AARCH64_FEATURE_1_BTI: u32 = 1 << 0;
const GNU_PROPERTY_AARCH64_FEATURE_1_PAC: u32 = 1 << 1;

/// The `.note.gnu.property` body claiming the branch protections the
/// emitted code carries, or `None` when it claims none. The note holds
/// one `NT_GNU_PROPERTY_TYPE_0` note with one property whose payload is
/// padded to the note alignment (8 for ELF64, 4 for ELF32).
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
) -> Vec<u8> {
    let mut out: Vec<u8> = Vec::new();
    let name = b"badc\0";

    // Record 1: dylib paths. Skipped when there are none, like every
    // other record, so a unit using no note channel builds an empty
    // body and the writer drops the section.
    if !imports.dylibs.is_empty() {
        let mut dylibs_desc: Vec<u8> = Vec::new();
        for d in &imports.dylibs {
            dylibs_desc.extend_from_slice(d.path.as_bytes());
            dylibs_desc.push(0);
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(dylibs_desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_DYLIBS.to_le_bytes());
        out.extend_from_slice(name);
        crate::c5::layout::pad_to_align(&mut out, 4);
        out.extend_from_slice(&dylibs_desc);
        crate::c5::layout::pad_to_align(&mut out, 4);
    }

    // Record 2: per-import dylib map. Skip when there are no
    // imports -- the parser tolerates a missing record so the
    // older shape (dylibs note only) still round-trips.
    if !imports.imports.is_empty() || !imports.data_bindings.is_empty() {
        let mut bm_desc: Vec<u8> = Vec::new();
        for imp in &imports.imports {
            let idx = imp.dylib_index as u32;
            bm_desc.extend_from_slice(&idx.to_le_bytes());
            bm_desc.extend_from_slice(imp.real_symbol.as_bytes());
            bm_desc.push(0);
        }
        // Data bindings route through the same map, keyed by the
        // local name: that is the UNDEF symbol the linker records as
        // the import when no unit defines the local (PE / Mach-O).
        // Without an entry the import falls back to dylib 0.
        for (local, _host, dylib_index) in &imports.data_bindings {
            let idx = *dylib_index as u32;
            bm_desc.extend_from_slice(&idx.to_le_bytes());
            bm_desc.extend_from_slice(local.as_bytes());
            bm_desc.push(0);
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(bm_desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_BINDING_MAP.to_le_bytes());
        out.extend_from_slice(name);
        crate::c5::layout::pad_to_align(&mut out, 4);
        out.extend_from_slice(&bm_desc);
        crate::c5::layout::pad_to_align(&mut out, 4);
    }

    // Record 3: source-declared export names. Omitted when the TU
    // declared no `#pragma export`, matching the binding map's
    // conditional emit.
    if !exports.is_empty() {
        let mut ex_desc: Vec<u8> = Vec::new();
        for e in exports {
            ex_desc.extend_from_slice(e.name.as_bytes());
            ex_desc.push(0);
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(ex_desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_EXPORTS.to_le_bytes());
        out.extend_from_slice(name);
        crate::c5::layout::pad_to_align(&mut out, 4);
        out.extend_from_slice(&ex_desc);
        crate::c5::layout::pad_to_align(&mut out, 4);
    }

    // Record 4: Win64 `_tls_index` fixup offsets. Omitted when the
    // TU has no `_Thread_local` access (every non-Windows target,
    // and Windows TUs without TLS).
    if !tls_index_fixups.is_empty() {
        let mut tls_desc: Vec<u8> = Vec::new();
        for f in tls_index_fixups {
            tls_desc.extend_from_slice(&(f.instr_offset as u64).to_le_bytes());
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(tls_desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_TLS_INDEX.to_le_bytes());
        out.extend_from_slice(name);
        crate::c5::layout::pad_to_align(&mut out, 4);
        out.extend_from_slice(&tls_desc);
        crate::c5::layout::pad_to_align(&mut out, 4);
    }

    // Record 5: Mach-O TLV descriptor offsets.
    if !macho_tlv_descriptors.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for d in macho_tlv_descriptors {
            desc.extend_from_slice(&d.offset_in_block.to_le_bytes());
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_MACHO_TLV_DESC.to_le_bytes());
        out.extend_from_slice(name);
        crate::c5::layout::pad_to_align(&mut out, 4);
        out.extend_from_slice(&desc);
        crate::c5::layout::pad_to_align(&mut out, 4);
    }

    // Record 6: Mach-O TLV fixups -- (adrp_offset, descriptor_index)
    // pairs.
    if !macho_tlv_fixups.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for f in macho_tlv_fixups {
            desc.extend_from_slice(&(f.adrp_offset as u64).to_le_bytes());
            desc.extend_from_slice(&(f.descriptor_index as u64).to_le_bytes());
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_MACHO_TLV_FIXUP.to_le_bytes());
        out.extend_from_slice(name);
        crate::c5::layout::pad_to_align(&mut out, 4);
        out.extend_from_slice(&desc);
        crate::c5::layout::pad_to_align(&mut out, 4);
    }

    // Record 8: defined `_Thread_local` symbols -- (tls_offset, size,
    // NUL name) per variable this unit defines.
    if !tls_symbols.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for (sym_name, off, size) in tls_symbols {
            desc.extend_from_slice(&(*off as u64).to_le_bytes());
            desc.extend_from_slice(&size.to_le_bytes());
            desc.extend_from_slice(sym_name.as_bytes());
            desc.push(0);
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_TLS_SYM.to_le_bytes());
        out.extend_from_slice(name);
        crate::c5::layout::pad_to_align(&mut out, 4);
        out.extend_from_slice(&desc);
        crate::c5::layout::pad_to_align(&mut out, 4);
    }

    // Record 9: Mach-O TLV descriptors keyed by a cross-unit symbol --
    // (descriptor_index, NUL name) per extern `_Thread_local` access.
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
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_MACHO_TLV_DESC_SYM.to_le_bytes());
        out.extend_from_slice(name);
        crate::c5::layout::pad_to_align(&mut out, 4);
        out.extend_from_slice(&desc);
        crate::c5::layout::pad_to_align(&mut out, 4);
    }

    // Record 10: Linux/x86_64 TLS access fixups -- (imm_offset, kind,
    // local_offset | NUL name) per `Inst::TlsAddr` site.
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
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_ELF_TPOFF.to_le_bytes());
        out.extend_from_slice(name);
        crate::c5::layout::pad_to_align(&mut out, 4);
        out.extend_from_slice(&desc);
        crate::c5::layout::pad_to_align(&mut out, 4);
    }

    // Record 11: post-prologue anchors -- (entry_offset,
    // post_prologue_offset) `.text` byte-offset pairs.
    if !prologue_ends.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for (entry, post) in prologue_ends {
            desc.extend_from_slice(&entry.to_le_bytes());
            desc.extend_from_slice(&post.to_le_bytes());
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_PROLOGUE_END.to_le_bytes());
        out.extend_from_slice(name);
        crate::c5::layout::pad_to_align(&mut out, 4);
        out.extend_from_slice(&desc);
        crate::c5::layout::pad_to_align(&mut out, 4);
    }

    // Record 7: data-import copy relocations -- (local_name, host_symbol)
    // NUL-terminated string pairs from `#pragma binding(data ...)`.
    if !imports.data_bindings.is_empty() {
        let mut desc: Vec<u8> = Vec::new();
        for (local, host, _dylib_index) in &imports.data_bindings {
            desc.extend_from_slice(local.as_bytes());
            desc.push(0);
            desc.extend_from_slice(host.as_bytes());
            desc.push(0);
        }
        out.extend_from_slice(&(name.len() as u32).to_le_bytes());
        out.extend_from_slice(&(desc.len() as u32).to_le_bytes());
        out.extend_from_slice(&NT_BADC_COPY_RELOC.to_le_bytes());
        out.extend_from_slice(name);
        crate::c5::layout::pad_to_align(&mut out, 4);
        out.extend_from_slice(&desc);
        crate::c5::layout::pad_to_align(&mut out, 4);
    }
    out
}

/// Symtab indices of the `STT_SECTION` entries a DWARF relocation
/// resolves against.
#[derive(Clone, Copy)]
struct DwarfSectionSyms {
    text: u64,
    line: u64,
    abbrev: u64,
    strs: u64,
}

/// Translate a `DwarfReloc` (target = section kind + width) into
/// an `Elf64Rela`. The reloc type comes from `(width, machine)`:
/// 32-bit slots use `R_X86_64_32` / `R_AARCH64_ABS32`, 64-bit
/// slots use `R_X86_64_64` / `R_AARCH64_ABS64`. The target
/// section's symtab index is looked up from the three indices the
/// caller pre-resolved when laying out the symbol table; a
/// `DW_OP_addr` slot resolves through `obj_sym_idx` instead, and
/// yields no entry when the name reached no symbol, leaving the
/// address null rather than pointing it somewhere else. A
/// thread-local's slot takes a thread-block offset, so it uses the
/// module-relative TLS reloc rather than an absolute one.
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
            // The location carrying it is emitted for ELFCLASS64 only.
            RelocAbi::I386 => None,
        }
    } else {
        abi.abs(r.width.bytes() as u32)
    };
    let rtype = rtype.ok_or_else(|| {
        C5Error::Compile(crate::c5::error::fmt_internal_err(&alloc::format!(
            "elf_reloc: debug info holds a {}-byte {} slot, which this psABI \
             has no relocation for",
            r.width.bytes(),
            if tls {
                "thread-local offset"
            } else {
                "address"
            }
        )))
    })?;
    Ok(Some(Elf64Rela {
        r_offset: r.offset,
        r_info: (sym_idx << 32) | (rtype as u64),
        r_addend: r.addend,
    }))
}

/// Emit the relocs the per-arch lowering left behind for an
/// address-load pair (`adrp + add` on aarch64, `lea rip-rel
/// disp32` on x86_64). The two halves share a single symbol +
/// addend so the linker reconstructs the final address as
/// `S + A`:
/// * aarch64 -- two relocs: `R_AARCH64_ADR_PREL_PG_HI21` at the
///   instruction start (encodes bits 32..12 of the page offset
///   into the `immhi:immlo` field) and
///   `R_AARCH64_ADD_ABS_LO12_NC` at the next instruction
///   (encodes bits 11..0 into the `add` imm12).
/// * x86_64 -- one reloc: `R_X86_64_PC32` at the disp32 slot of
///   the `lea`, with the addend pre-adjusted by `-4` so the
///   resolved value is `(S + A) - P`.
///
/// `instr_offset` is the byte offset within `.text` of the
/// first instruction of the pair (or the lea's opcode byte on
/// x86_64). The codegen's existing `DataFixup` / `FuncFixup`
/// already record this position.
/// ELF relocation type of an AArch64 instruction-field kind. `None` for the
/// data-field kinds (`Data` / `JumpRel`), whose type depends on the field's
/// width and flags.
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
                // The record names a site but not which of the low-12
                // forms it holds, and the type decides how the linker
                // scales the immediate. The codegen emits only whole
                // references, so no caller reaches this.
                AddrPart::InPage => {
                    return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                        &format!(
                            "elf_reloc: in-page-only fixup at text+{instr_offset:#x} has no \
                             relocation type"
                        ),
                    )));
                }
            }
        }
        Machine::X86_64 => {
            // The x86_64 codegen emits `lea reg, [rip + 0]`
            // where the disp32 occupies the last 4 bytes of
            // the instruction. For a typical REX-prefixed
            // 7-byte LEA (`48 8d 05 + disp32`), the disp32
            // starts at `instr_offset + 3`. The codegen
            // currently positions the disp32 slot at
            // `instr_offset + 3` for both LEA shapes used by
            // data refs.
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

/// Addressing form of a cross-TU address materialization in a
/// relocatable object; chosen per symbol by `extern_addr_form`.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ExternAddrForm {
    /// The codegen's direct page-relative / RIP-relative pair, kept
    /// as-is; relocs from [`emit_addr_fixup_relocs`].
    Direct,
    /// GOT slot load; text rewritten by
    /// [`rewrite_extern_addr_loads_to_got`], relocs from
    /// [`emit_got_ref_relocs`].
    Got,
    /// Sign-extended 32-bit absolute (x86-64 kernel model); text
    /// rewritten by [`rewrite_extern_addr_loads_to_abs32`], reloc from
    /// [`emit_abs32_ref_reloc`].
    Abs32,
}

/// Emit the GOT-indirect relocs for address-taking a dylib-routed import:
/// `R_AARCH64_ADR_GOT_PAGE` at the `adrp` and
/// `R_AARCH64_LD64_GOT_LO12_NC` at the paired `ldr` on aarch64;
/// `R_X86_64_REX_GOTPCRELX` at the disp32 of the rewritten `mov` on x86_64.
/// The direct-address instruction the codegen left is rewritten to the
/// GOT load by [`rewrite_extern_addr_loads_to_got`].
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
            // `REX mov reg, [rip + disp32]` (rewritten from the codegen's
            // `lea`): the disp32 sits after REX + opcode + modrm, and
            // resolves as `G + GOT + A - P` with the end-of-field `-4`.
            // The REX form is exactly what the relaxable marking covers.
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
/// it). Absolute, so no end-of-field skew; `addend` carries the
/// section-relative offset when the symbol reduced to section+offset.
fn emit_abs32_ref_reloc(out: &mut Vec<u8>, instr_offset: u64, sym_idx: u64, addend: i64) {
    let rela = Elf64Rela {
        r_offset: instr_offset + 3,
        r_info: (sym_idx << 32) | R_X86_64_32S as u64,
        r_addend: addend,
    };
    write_struct(out, &rela);
}

/// Rewrite each external-address materialization into the GOT-load form
/// (paired with the relocs from [`emit_got_ref_relocs`]): the `add` half
/// of an aarch64 `adrp + add` becomes `ldr`, and an x86_64 rip-relative
/// `lea` becomes `mov` (opcode 0x8d -> 0x8b, same REX/modrm/disp32).
/// Returns a copy of `.text` with the rewrites applied; the shared
/// `build.text` is untouched so the JIT / direct-image paths keep the
/// direct form.
fn rewrite_extern_addr_loads_to_got(
    machine: Machine,
    text: &[u8],
    instr_offsets: &[usize],
) -> alloc::vec::Vec<u8> {
    let mut body = text.to_vec();
    match machine {
        Machine::Aarch64 => {
            // The codegen emits both halves in one lowering, so the
            // in-page word of its own reference sits at +4.
            for &instr_offset in instr_offsets {
                let off = instr_offset + 4;
                if off + 4 > body.len() {
                    continue;
                }
                let add =
                    u32::from_le_bytes([body[off], body[off + 1], body[off + 2], body[off + 3]]);
                let rd = add & 0x1f;
                let rn = (add >> 5) & 0x1f;
                // `ldr Xrd, [Xrn, #0]` (0xF9400000 | Rn<<5 | Rt); the
                // :got_lo12: reloc fills the scaled imm12.
                let ldr = 0xF940_0000u32 | (rn << 5) | rd;
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
    body
}

/// Rewrite each x86-64 external-address `lea reg, [rip+disp32]`
/// (`REX.W 8D` modrm mod=00 rm=101) into `mov reg, imm32`
/// (`REX.W C7 /0` modrm mod=11): the destination moves from modrm.reg
/// to modrm.rm and REX.R to REX.B, and the imm32 occupies the bytes the
/// disp32 did, so the instruction length is unchanged. Paired with the
/// `R_X86_64_32S` from [`emit_abs32_ref_reloc`].
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

    /// Sanity: an empty Build produces a valid ELF header that
    /// `readelf -h` would accept.
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
        // A function so the CU carries a subprogram DIE: its
        // `DW_AT_low_pc` is a second address site, reached only when
        // `.text` holds code.
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
        // `address_size` sits at byte 10 of the CU header, after
        // unit_length(4) + version(2) + debug_abbrev_offset(4).
        let (info_off, _) = secs[".debug_info"];
        assert_eq!(bytes[info_off + 10], 4, "CU address_size");
        // Both debug relocation tables take the `SHT_REL` form and
        // number their entries as i386.
        for name in [".rel.debug_info", ".rel.debug_line"] {
            let (off, size) = secs[name];
            assert!(size > 0 && size % 8 == 0, "{name} holds Elf32_Rel records");
            for row in bytes[off..off + size].as_chunks::<8>().0.iter() {
                let info = u32::from_le_bytes(row[4..8].try_into().unwrap());
                assert_eq!(info & 0xff, R_386_32, "{name} entry type");
            }
        }
        // A `.rela.debug_*` companion would mean the writer kept the
        // 64-bit form for the debug tables alone.
        assert!(!secs.contains_key(".rela.debug_info"));
        assert!(!secs.contains_key(".rela.debug_line"));
    }

    /// The driver's `-m16 -g -c <unit>.s` end to end: assemble a real
    /// unit and write it as an i386 object. The `.code16` boot and
    /// real-mode units the kernel builds this way reach the writer with
    /// debug info attached.
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

    /// An object names each section once, and carries `.debug_*` only
    /// under `-g`. Two sections of one name make selection by name
    /// ambiguous: `objcopy --dump-section=.text` reads the first, which
    /// for an assembled unit was the empty default rather than the
    /// assembly. A zero-length `.debug_info` makes
    /// `readelf --debug-dump` and `objdump --dwarf` report an error over
    /// a unit that has no debug info to read. GNU as and gcc emit
    /// neither for the same source.
    #[test]
    fn an_object_names_each_section_once_and_carries_dwarf_only_under_g() {
        use crate::c5::{CompileOptions, Compiler, NativeOptions, OutputKind, Target};
        // Every default section name is claimed by the assembly, so each
        // one has an empty default to shadow.
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
        // The RELA classes carry the addend in the record instead.
        let mut body64 = alloc::vec![0u8; 16];
        fold_rel_addends(ElfClass::Elf64, &table, &mut body64).expect("no-op");
        assert!(body64.iter().all(|&b| b == 0));
        // ELF32 narrows each record to `Elf32_Rel`: offset and info only,
        // with the type in the low byte of `r_info`.
        let rel = encode_reloc_table(ElfClass::Elf32, &table);
        assert_eq!(rel.len(), 3 * 8);
        assert_eq!(
            u32::from_le_bytes(rel[4..8].try_into().unwrap()),
            (7 << 8) | R_386_32
        );
    }

    /// The kernel-model rewrite moves the destination from the lea's
    /// modrm.reg (REX.R) to the mov's modrm.rm (REX.B) for every
    /// register, including r8-r15.
    #[test]
    fn abs32_rewrite_moves_the_destination_register() {
        // (lea reg, [rip+0], mov reg, imm32) pairs for rax, rdi, r8, r12.
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

    fn empty_program(path: &str) -> Program {
        Program {
            target: crate::c5::codegen::Target::host(),
            data: Vec::new(),
            file_asm: Vec::new(),
            asm_weak_names: Vec::new(),
            asm_global_names: Vec::new(),
            asm_visibility: Vec::new(),
            asm_unit: false,
            asm_file_names: Vec::new(),
            asm_idents: Vec::new(),
            data_ro_len: 0,
            data_relro_len: 0,
            data_object_starts: Vec::new(),
            const_data_ranges: Vec::new(),
            data_pad_ranges: Vec::new(),
            data_align_marks: Vec::new(),
            entry_pc: 0,
            warnings: Vec::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            data_relocs: Vec::new(),
            extern_data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            tls_data_relocs: Vec::new(),
            tls_extern_data_relocs: Vec::new(),
            tls_code_relocs: Vec::new(),
            exports: Vec::new(),
            dylibs: Vec::new(),
            dllmain_pc: None,
            source_files: Vec::new(),
            source_path: path.into(),
            variables: Vec::new(),
            structs: Vec::new(),
            enums: Vec::new(),
            entry_name: None,
            entry_pragma: None,
            auto_includes: Vec::new(),
            data_align: 8,
            subsystem: None,
            finished_functions: Vec::new(),
            symbols: Vec::new(),
            synthetic_ssa_funcs: Vec::new(),
            user_ssa_funcs: Vec::new(),
            extern_function_imports: Vec::new(),
            init_funcs: Vec::new(),
            function_aliases: Vec::new(),
        }
    }

    fn empty_build_for(_machine: Machine) -> Build {
        use super::super::{Abi, OutputKind, ResolvedImports};
        Build {
            text_data_ranges: alloc::vec::Vec::new(),
            emitted_relocs: Vec::new(),
            named_sections: Vec::new(),
            got_base_fixups: Vec::new(),
            text_align: 16,
            orphaned_data: None,
            stopped_at_data_liveness: false,
            ssa_dump: alloc::string::String::new(),
            asm_sections: Vec::new(),
            asm_section_text_refs: Vec::new(),
            asm_text_abs_refs: Vec::new(),
            asm_sym_fixups: Vec::new(),
            asm_text_labels: Vec::new(),
            asm_sym_decls: Vec::new(),
            copy_relocs: Default::default(),
            text: Vec::new(),
            data: Vec::new(),
            data_ro_len: 0,
            data_relro_len: 0,
            pic_link: false,
            code_model: Default::default(),
            elf_class: Default::default(),
            rodata: Default::default(),
            data_pcrel_relocs: Vec::new(),
            text_pcrel_relocs: Vec::new(),
            text_abs_relocs: Vec::new(),
            data_align: 8,
            bss_size: 0,
            init_fini_arrays: Default::default(),
            entry_offset: 0,
            got_fixups: Vec::new(),
            data_fixups: Vec::new(),
            func_fixups: Vec::new(),
            pc_to_native: Vec::new(),
            func_ent_pcs: Vec::new(),
            func_ends: Vec::new(),
            func_names: Vec::new(),
            func_prologue_native: alloc::collections::BTreeMap::new(),
            promoted_local_slots: alloc::collections::BTreeMap::new(),
            coalesced_slot_remap: alloc::collections::BTreeMap::new(),
            fn_unwind: Vec::new(),
            reloc_call_sites: Vec::new(),
            user_extern_call_sites: Vec::new(),
            user_extern_data_refs: Vec::new(),
            ssa_line_rows: Vec::new(),
            imports: ResolvedImports::default(),
            abi: Abi::default(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            tls_index_fixups: Vec::new(),
            elf_tpoff_fixups: Vec::new(),
            data_relocs: Vec::new(),
            extern_data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            tls_data_relocs: Vec::new(),
            tls_extern_data_relocs: Vec::new(),
            tls_code_relocs: Vec::new(),
            label_relocs: Vec::new(),
            exports: Vec::new(),
            dynamic_exports: Vec::new(),
            output_kind: OutputKind::Relocatable,
            shared_lib_name: None,
            dllmain_pc: None,
            macho_tlv_fixups: Vec::new(),
            macho_tlv_descriptors: Vec::new(),
            debug_info: false,
            merged_dwarf: None,
            plt_trampoline_offsets: Vec::new(),
        }
    }
}

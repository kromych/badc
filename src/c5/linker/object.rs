//! Native ELF64 ET_REL reader -- parses one relocatable object
//! file the way `ld` / `lld` would, returning a structured
//! [`NativeObject`] the linker uses to concatenate sections
//! and resolve cross-unit references.
//!
//! Mirrors the on-disk shape produced by
//! `codegen/elf_reloc.rs`: a `.text` section holding machine
//! code, `.data` / `.bss` for static storage, `.symtab` /
//! `.strtab` for the name table, and `.rela.text` carrying the
//! relocation entries the linker applies once it knows each
//! unit's final position in the merged image. Section names
//! and ordering follow the writer's contract; the reader
//! locates each section by name through `.shstrtab` so
//! third-party tools (e.g. `objcopy --strip-debug`) can
//! reorder sections without breaking the parse.

#![cfg(feature = "std")]
// Reader-only until the native linker path lands -- every
// helper and constant here is dead-code from the production
// codegen until then. The test in this module exercises the
// public surface, so the lints would still surface; gating
// module-wide keeps the build clean.
#![allow(dead_code)]

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use crate::c5::error::C5Error;

// ELF64 on-disk constants. Kept verbatim from
// `codegen/elf_reloc.rs` so the encoder and decoder share a
// single source of truth; a future refactor can lift them into
// a common module.
const ELF_CLASS_64: u8 = 2;
const ELF_DATA_LSB: u8 = 1;
const ET_REL: u16 = 1;
const EM_X86_64: u16 = 62;
const EM_AARCH64: u16 = 183;
const SHT_PROGBITS: u32 = 1;
const SHT_SYMTAB: u32 = 2;
const SHT_STRTAB: u32 = 3;
const SHT_RELA: u32 = 4;
const SHT_NOBITS: u32 = 8;
const SHN_UNDEF: u16 = 0;
const SHN_ABS: u16 = 0xfff1;
const SHN_COMMON: u16 = 0xfff2;

const ELF64_EHDR_SIZE: usize = core::mem::size_of::<Elf64Ehdr>();
const ELF64_SHDR_SIZE: usize = core::mem::size_of::<Elf64Shdr>();
const ELF64_SYM_SIZE: usize = core::mem::size_of::<Elf64Sym>();
const ELF64_RELA_SIZE: usize = core::mem::size_of::<Elf64Rela>();

// On-disk ELF64 records as `#[repr(C)]` structs. The struct
// layout matches the ELF spec verbatim because every field is
// naturally aligned at the offset the spec calls out and the
// platforms we target (x86_64, aarch64) are little-endian, so
// field byte-order matches on-disk order. `static_assert`-style
// sanity checks at the bottom of this block lock the sizes.
#[repr(C)]
#[derive(Debug, Clone, Copy)]
pub(crate) struct Elf64Ehdr {
    pub(crate) e_ident: [u8; 16],
    pub(crate) e_type: u16,
    pub(crate) e_machine: u16,
    pub(crate) e_version: u32,
    pub(crate) e_entry: u64,
    pub(crate) e_phoff: u64,
    pub(crate) e_shoff: u64,
    pub(crate) e_flags: u32,
    pub(crate) e_ehsize: u16,
    pub(crate) e_phentsize: u16,
    pub(crate) e_phnum: u16,
    pub(crate) e_shentsize: u16,
    pub(crate) e_shnum: u16,
    pub(crate) e_shstrndx: u16,
}

#[repr(C)]
#[derive(Debug, Clone, Copy)]
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

#[repr(C)]
#[derive(Debug, Clone, Copy)]
struct Elf64Sym {
    st_name: u32,
    st_info: u8,
    st_other: u8,
    st_shndx: u16,
    st_value: u64,
    st_size: u64,
}

#[repr(C)]
#[derive(Debug, Clone, Copy)]
struct Elf64Rela {
    r_offset: u64,
    r_info: u64,
    r_addend: i64,
}

/// ELF note header: the fixed prefix before a note's name and
/// descriptor payloads.
#[repr(C)]
#[derive(Debug, Clone, Copy)]
struct Elf64Nhdr {
    n_namesz: u32,
    n_descsz: u32,
    n_type: u32,
}

const _: () = {
    assert!(core::mem::size_of::<Elf64Ehdr>() == 64);
    assert!(core::mem::size_of::<Elf64Shdr>() == 64);
    assert!(core::mem::size_of::<Elf64Sym>() == 24);
    assert!(core::mem::size_of::<Elf64Rela>() == 24);
    assert!(core::mem::size_of::<Elf64Nhdr>() == 12);
};

/// Read a `#[repr(C)]` ELF record at byte offset `off`. Bounds-
/// checks before reading; copies the bytes into an aligned local
/// to dodge the unaligned-load requirement on architectures that
/// would otherwise trap. The caller is responsible for matching
/// `T` to the on-disk shape -- the helper sidesteps Rust's type
/// system there because every ELF struct has its own well-known
/// layout.
fn read_struct<T: Copy>(bytes: &[u8], off: usize) -> Result<T, C5Error> {
    let n = core::mem::size_of::<T>();
    if off.checked_add(n).is_none_or(|end| end > bytes.len()) {
        return Err(err(&alloc::format!(
            "ELF record at offset 0x{off:x} (size {n}) past end of file (len {})",
            bytes.len(),
        )));
    }
    // SAFETY: `T` is `Copy + #[repr(C)]` per call site; bounds
    // checked above; little-endian field order matches the
    // host's byte order so the in-memory pattern matches the
    // on-disk pattern.
    Ok(unsafe { core::ptr::read_unaligned(bytes.as_ptr().add(off) as *const T) })
}

/// `SHT_DYNSYM` -- the loader-visible dynamic symbol table.
#[cfg(test)]
const SHT_DYNSYM: u32 = 11;

/// Count the dynamic relocations of a given type (`r_info & 0xffffffff`)
/// across every `SHT_RELA` section of a linked ELF64 image. Used to
/// confirm a shared object carries `R_*_RELATIVE` entries for its
/// internal absolute pointers.
#[cfg(test)]
pub(crate) fn count_dynamic_relocs_of_type(bytes: &[u8], r_type: u32) -> Result<usize, C5Error> {
    const SHT_RELA: u32 = 4;
    let ehdr: Elf64Ehdr = read_struct(bytes, 0)?;
    let mut n = 0;
    for i in 0..ehdr.e_shnum as usize {
        let sh: Elf64Shdr =
            read_struct(bytes, ehdr.e_shoff as usize + i * ehdr.e_shentsize as usize)?;
        if sh.sh_type != SHT_RELA {
            continue;
        }
        let entsize = sh.sh_entsize as usize;
        let count = (sh.sh_size as usize).checked_div(entsize).unwrap_or(0);
        for j in 0..count {
            let rela: Elf64Rela = read_struct(bytes, sh.sh_offset as usize + j * entsize)?;
            if (rela.r_info & 0xffff_ffff) as u32 == r_type {
                n += 1;
            }
        }
    }
    Ok(n)
}

/// Read the ELF64 file header. `e_type` `2` is `ET_EXEC`, `3` is
/// `ET_DYN`; `e_machine` and `e_phnum` follow the spec.
#[cfg(test)]
pub(crate) fn read_elf_header(bytes: &[u8]) -> Result<Elf64Ehdr, C5Error> {
    read_struct(bytes, 0)
}

/// Collect the names in every `.dynsym` of a linked ELF64 image
/// (executable or shared object). Reads through the `#[repr(C)]`
/// section-header and symbol records rather than fixed byte offsets so
/// the on-disk layout is named, not magic. Empty names are skipped.
#[cfg(test)]
pub(crate) fn read_dynamic_symbol_names(bytes: &[u8]) -> Result<Vec<String>, C5Error> {
    let ehdr: Elf64Ehdr = read_struct(bytes, 0)?;
    let read_cstr = |off: usize| -> String {
        let start = off;
        let mut end = start;
        while end < bytes.len() && bytes[end] != 0 {
            end += 1;
        }
        String::from_utf8_lossy(&bytes[start..end]).into_owned()
    };
    let mut names = Vec::new();
    for i in 0..ehdr.e_shnum as usize {
        let sh: Elf64Shdr =
            read_struct(bytes, ehdr.e_shoff as usize + i * ehdr.e_shentsize as usize)?;
        if sh.sh_type != SHT_DYNSYM {
            continue;
        }
        let strtab: Elf64Shdr = read_struct(
            bytes,
            ehdr.e_shoff as usize + sh.sh_link as usize * ehdr.e_shentsize as usize,
        )?;
        let entsize = sh.sh_entsize as usize;
        let count = (sh.sh_size as usize).checked_div(entsize).unwrap_or(0);
        for j in 0..count {
            let sym: Elf64Sym = read_struct(bytes, sh.sh_offset as usize + j * entsize)?;
            let name = read_cstr(strtab.sh_offset as usize + sym.st_name as usize);
            if !name.is_empty() {
                names.push(name);
            }
        }
    }
    Ok(names)
}

/// Which architecture's relocations the object uses. Drives the
/// reloc-type interpretation in [`NativeReloc::rtype`].
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum NativeMachine {
    X86_64,
    Aarch64,
}

/// Which section a symbol's value lives in.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum NativeSymSection {
    Text,
    Data,
    Bss,
    /// `SHN_UNDEF` -- the unit references the symbol but doesn't
    /// define it. The linker resolves these against another
    /// unit's defined entry (or against a libc binding).
    Undef,
    /// `SHN_ABS` -- absolute symbol, typically the file symbol.
    /// The linker doesn't relocate these.
    Abs,
    /// `SHN_COMMON` -- C99 6.9.2 tentative definition. The
    /// symbol carries a size (`NativeSymbol::size`) and a
    /// requested byte alignment (`NativeSymbol::value`); the
    /// linker coalesces multi-unit definitions of the same name
    /// into a single `.bss`-resident slot with the largest size
    /// and strictest alignment.
    Common,
    /// `_Thread_local` storage in `.tdata` (initialised) or
    /// `.tbss` (zero-init). The merged image needs a PT_TLS
    /// segment and TPOFF / TLSGD relocs at call sites; the
    /// native linker fails fast on Tls references until that
    /// lowering lands.
    Tls,
    /// `STT_SECTION` symbol pointing at the unit's `.debug_abbrev`
    /// section. Used by `.rela.debug_info` entries for the CU
    /// header's `debug_abbrev_offset`; the linker rebases the
    /// reloc's addend by the unit's merged `.debug_abbrev` base.
    DebugAbbrev,
    /// `STT_SECTION` symbol pointing at the unit's `.debug_line`
    /// section. Used by `.rela.debug_info` for `DW_AT_stmt_list`
    /// and by `.rela.debug_line` for any cross-line-table
    /// references.
    DebugLine,
    /// `STT_SECTION` symbol pointing at the unit's `.debug_str`
    /// section. `.rela.debug_info` references it through
    /// `DW_FORM_strp` (4-byte offset into `.debug_str`); the
    /// linker rebases the offset by the unit's merged
    /// `.debug_str` base.
    DebugStr,
}

/// One entry from the unit's `.symtab`. Section symbols (the
/// `STT_SECTION` LOCAL entries the writer emits) are dropped
/// during parse -- they're an internal convenience for the
/// reloc encoder and the merged linker rebuilds them on the
/// output side.
#[derive(Debug, Clone)]
pub struct NativeSymbol {
    pub name: String,
    pub section: NativeSymSection,
    /// Byte offset within the section. For UNDEF / ABS this is
    /// the raw `st_value` the writer stored.
    pub value: u64,
    /// `st_size`. Zero when the writer didn't size the symbol.
    pub size: u64,
    /// `STB_LOCAL` / `STB_GLOBAL` (`st_info >> 4`).
    pub binding: u8,
    /// `STT_NOTYPE` / `STT_OBJECT` / `STT_FUNC` etc. (`st_info & 0xf`).
    pub kind: u8,
}

/// One entry from the unit's `.rela.text`. Patched by the
/// linker once each unit's final base offsets are known.
#[derive(Debug, Clone, Copy)]
pub struct NativeReloc {
    /// Byte offset within `.text` of the location to patch.
    pub offset: u64,
    /// Index into `NativeObject::symbols` of the symbol to
    /// resolve against. `0` is the conventional null symbol --
    /// section-symbol relocations index past the file symbol +
    /// any global symbols, into the local section symbols the
    /// writer recorded; this reader collapses section symbols
    /// into the `section_sym_kind` field so the linker doesn't
    /// have to round-trip them.
    pub sym_idx: usize,
    /// ELF reloc type (`R_X86_64_PLT32`, `R_AARCH64_CALL26`,
    /// ...). Interpreted per [`NativeObject::machine`].
    pub rtype: u32,
    /// Signed addend the reloc adds to the resolved symbol
    /// value before patching.
    pub addend: i64,
}

/// Result of parsing one native ELF ET_REL object.
#[derive(Debug, Clone)]
pub struct NativeObject {
    pub machine: NativeMachine,
    pub text: Vec<u8>,
    pub data: Vec<u8>,
    /// Size of the `.bss` section in bytes. The reader doesn't
    /// allocate bytes for it (the writer doesn't either --
    /// `SHT_NOBITS` records size but no file content).
    pub bss_size: usize,
    /// Concatenated bytes from every `.tdata*` section
    /// (initialised TLS storage). Empty for objects without
    /// `_Thread_local` data.
    pub tls_data: Vec<u8>,
    /// Sum of every `.tbss*` section's size (zero-init TLS).
    pub tls_bss_size: usize,
    pub symbols: Vec<NativeSymbol>,
    pub text_relocs: Vec<NativeReloc>,
    /// `.rela.data` entries (`R_X86_64_64` / `R_AARCH64_ABS64`)
    /// the writer emitted for pointer-to-global initializers.
    /// Linker resolves each to `data_vaddr + target.value`,
    /// patching the 8-byte slot at `offset` in the merged
    /// `.data`.
    pub data_relocs: Vec<NativeReloc>,
    /// Dylib load paths the writer copied out of the unit's
    /// `#pragma dylib` declarations (`.note.badc` /
    /// `NT_BADC_DYLIBS`). Each entry is the verbatim path the
    /// final-image writer drops into DT_NEEDED / LC_LOAD_DYLIB /
    /// IMAGE_IMPORT_DESCRIPTOR. Empty when the unit reaches for
    /// no external libraries; the linker preserves insertion
    /// order across units and dedupes on full path.
    pub dylibs: Vec<String>,
    /// Per-import dylib routing (`NT_BADC_BINDING_MAP`). Each
    /// entry maps an import name to the index of its dylib in
    /// `dylibs`. The final-image writer reads this so a PE
    /// linking `printf` (ucrtbase) and `GetCurrentProcess`
    /// (kernel32) routes each IAT entry to the right loader
    /// table. The linker merges across units and remaps the
    /// dylib_index to the merged `dylibs` order.
    pub import_dylib_map: Vec<(String, u32)>,
    /// Source-declared export names (`NT_BADC_EXPORTS`), one per
    /// `#pragma export(<name>)`. Each names a defined symbol in this
    /// object. The final-image writer promotes them to the export
    /// table when emitting a shared library; the linker takes the
    /// union across units.
    pub exports: Vec<String>,
    /// Win64 `_tls_index` fixup offsets (`NT_BADC_TLS_INDEX`), each a
    /// byte offset into this object's `.text`. The PE writer patches
    /// each with the `_tls_index` slot address. Empty on non-Windows
    /// objects and Windows objects without `_Thread_local` access.
    pub tls_index_fixups: Vec<usize>,
    /// Mach-O TLV descriptor offsets (`NT_BADC_MACHO_TLV_DESC`), one
    /// `offset_in_block` per `_Thread_local` variable. The Mach-O
    /// writer materialises a `__thread_vars` descriptor for each.
    pub macho_tlv_descriptors: Vec<u64>,
    /// Mach-O TLV fixups (`NT_BADC_MACHO_TLV_FIXUP`), each
    /// `(adrp_offset, descriptor_index)`: a `.text` byte offset and
    /// the index into `macho_tlv_descriptors` it resolves to.
    pub macho_tlv_fixups: Vec<(usize, usize)>,
    /// Data-import copy relocations (`NT_BADC_COPY_RELOC`), each
    /// `(local_name, host_symbol)` from `#pragma binding(data ...)`.
    /// The final-image writer binds the local data symbol to the
    /// host's data object with an `R_*_COPY` relocation.
    pub copy_relocs: Vec<(String, String)>,
    /// Standard DWARF 4 sections the `-c` writer emits.
    /// Address-bearing slots inside are placeholders paired with
    /// entries in `debug_info_relocs` / `debug_line_relocs`; the
    /// linker rebases each via the matching ELF reloc.
    pub debug_info: Vec<u8>,
    pub debug_abbrev: Vec<u8>,
    pub debug_line: Vec<u8>,
    /// `.debug_str` -- NUL-terminated strings the `.debug_info`
    /// references through `DW_FORM_strp`. The producer emits one
    /// entry per unique CU / file / function name; the linker
    /// concatenates per unit and rebases the matching
    /// `.rela.debug_info` slot via [`Self::debug_info_relocs`].
    pub debug_str: Vec<u8>,
    /// `.rela.debug_info` and `.rela.debug_line` entries. Each
    /// reloc records the byte offset inside its section, the
    /// target section symbol (`.text` / `.debug_line` /
    /// `.debug_abbrev` / `.debug_str`), the addend, and the
    /// reloc kind (4-byte vs 8-byte slot).
    pub debug_info_relocs: Vec<NativeReloc>,
    pub debug_line_relocs: Vec<NativeReloc>,
}

/// True when `bytes` starts with the ELF magic. Cheap
/// pre-check; the full parse below validates that the rest of
/// the header matches the ET_REL shape the writer produces.
pub fn is_elf_object(bytes: &[u8]) -> bool {
    bytes.len() >= 4 && &bytes[0..4] == b"\x7fELF"
}

/// Parse a native ELF64 ET_REL object. Returns
/// [`NativeObject`] on success; surfaces a clear error message
/// on every shape divergence (truncated bytes, wrong machine,
/// missing `.text`, etc.).
pub fn parse_native_elf(bytes: &[u8]) -> Result<NativeObject, C5Error> {
    if bytes.len() < 4 || &bytes[0..4] != b"\x7fELF" {
        return Err(err("not an ELF object (missing 0x7F ELF magic)"));
    }
    if bytes.len() < ELF64_EHDR_SIZE {
        return Err(err(&format!(
            "ELF object truncated: have {} bytes, need at least {} for the header",
            bytes.len(),
            ELF64_EHDR_SIZE,
        )));
    }
    let ehdr: Elf64Ehdr = read_struct(bytes, 0)?;
    if ehdr.e_ident[4] != ELF_CLASS_64 {
        return Err(err("ELF object is not 64-bit (ELFCLASS64 expected)"));
    }
    if ehdr.e_ident[5] != ELF_DATA_LSB {
        return Err(err(
            "ELF object is not little-endian (ELFDATA2LSB expected)",
        ));
    }
    if ehdr.e_type != ET_REL {
        return Err(err(&format!(
            "ELF object is not relocatable (e_type = {}, expected ET_REL = {ET_REL})",
            ehdr.e_type,
        )));
    }
    let machine = match ehdr.e_machine {
        EM_X86_64 => NativeMachine::X86_64,
        EM_AARCH64 => NativeMachine::Aarch64,
        other => {
            return Err(err(&format!(
                "ELF object's e_machine {other} is not one of EM_X86_64 ({EM_X86_64}) / EM_AARCH64 ({EM_AARCH64})",
            )));
        }
    };
    let e_shoff = ehdr.e_shoff as usize;
    let e_shentsize = ehdr.e_shentsize as usize;
    let e_shnum = ehdr.e_shnum as usize;
    let e_shstrndx = ehdr.e_shstrndx as usize;
    if e_shentsize != ELF64_SHDR_SIZE {
        return Err(err(&format!(
            "section header entry size is {e_shentsize}, expected {ELF64_SHDR_SIZE}",
        )));
    }
    if e_shoff + e_shnum * e_shentsize > bytes.len() {
        return Err(err("section header table runs past end of file"));
    }

    // Read every section header up front. The reader is
    // section-name driven so order doesn't matter past this
    // point.
    let mut shdrs: Vec<Elf64Shdr> = Vec::with_capacity(e_shnum);
    for i in 0..e_shnum {
        let off = e_shoff + i * ELF64_SHDR_SIZE;
        shdrs.push(read_struct(bytes, off)?);
    }

    // Locate `.shstrtab` -- the index in the file header.
    let shstrtab = shdrs.get(e_shstrndx).ok_or_else(|| {
        err(&format!(
            "e_shstrndx ({e_shstrndx}) past end of section header table"
        ))
    })?;
    if shstrtab.sh_type != SHT_STRTAB {
        return Err(err(".shstrtab section is not SHT_STRTAB"));
    }
    let shstrtab_bytes = section_slice(bytes, shstrtab)?;

    // Walk the headers once to classify each by section family
    // (text / data / bss / rela-target / other). The parser
    // concatenates every section in a family after the unqualified
    // base section's bytes, remapping each symbol's value and any
    // `.rela.<section>` reloc offset by the section's base in the
    // merged blob. Data-family covers `.data`, per-variable
    // `.data.<name>` subsections (clang/gcc `-fdata-sections`),
    // every `.rodata*` (string literals + const globals), and
    // every `.data.rel.ro*` (initialised-then-readonly tables);
    // they share the same merged-data layout because there is no
    // separate read-only segment in the loader.
    let mut text_section_indices: Vec<usize> = Vec::new();
    let mut data_section_indices: Vec<usize> = Vec::new();
    let mut bss_section_indices: Vec<usize> = Vec::new();
    let mut tdata_section_indices: Vec<usize> = Vec::new();
    let mut tbss_section_indices: Vec<usize> = Vec::new();
    let mut symtab_idx: Option<usize> = None;
    let mut rela_section_indices: Vec<usize> = Vec::new();
    let mut dylibs_section_idx: Option<usize> = None;
    let mut debug_info_idx: Option<usize> = None;
    let mut debug_abbrev_idx: Option<usize> = None;
    let mut debug_line_idx: Option<usize> = None;
    let mut debug_str_idx: Option<usize> = None;
    let mut rela_debug_info_idx: Option<usize> = None;
    let mut rela_debug_line_idx: Option<usize> = None;
    for (i, sh) in shdrs.iter().enumerate() {
        let name = strtab_str(shstrtab_bytes, sh.sh_name as usize)?;
        if name == ".symtab" {
            symtab_idx = Some(i);
            continue;
        }
        if name == ".note.badc" {
            dylibs_section_idx = Some(i);
            continue;
        }
        if name == ".debug_info" {
            debug_info_idx = Some(i);
            continue;
        }
        if name == ".debug_abbrev" {
            debug_abbrev_idx = Some(i);
            continue;
        }
        if name == ".debug_line" {
            debug_line_idx = Some(i);
            continue;
        }
        if name == ".debug_str" {
            debug_str_idx = Some(i);
            continue;
        }
        if name == ".rela.debug_info" {
            rela_debug_info_idx = Some(i);
            continue;
        }
        if name == ".rela.debug_line" {
            rela_debug_line_idx = Some(i);
            continue;
        }
        match classify_section_family(name) {
            SectionFamily::Text => text_section_indices.push(i),
            SectionFamily::Data => data_section_indices.push(i),
            SectionFamily::Bss => bss_section_indices.push(i),
            SectionFamily::Tdata => tdata_section_indices.push(i),
            SectionFamily::Tbss => tbss_section_indices.push(i),
            SectionFamily::Other => {
                if let Some(target) = name.strip_prefix(".rela")
                    && !matches!(classify_section_family(target), SectionFamily::Other)
                {
                    rela_section_indices.push(i);
                }
            }
        }
    }
    let symtab_sh_i = symtab_idx.ok_or_else(|| err("ELF object has no `.symtab` section"))?;
    let symtab_sh = &shdrs[symtab_sh_i];

    // Concatenate every section in a family in section-index
    // order. `text_base_per_shndx[i] = base` means a symbol
    // originally at `shndx = i` with `st_value = v` lands at
    // `base + v` in the merged `.text` blob; same for data /
    // bss. Empty merged sections are allowed -- a translation
    // unit with no functions and no globals is rare but valid.
    let mut text_bytes: Vec<u8> = Vec::new();
    let mut text_base_per_shndx: Vec<(usize, u64)> = Vec::with_capacity(text_section_indices.len());
    for &sh_i in &text_section_indices {
        let sh = &shdrs[sh_i];
        if sh.sh_type == SHT_NOBITS {
            return Err(err(&format!(
                "text-family section at index {sh_i} has sh_type SHT_NOBITS (must hold file bytes)",
            )));
        }
        let base = text_bytes.len() as u64;
        text_base_per_shndx.push((sh_i, base));
        text_bytes.extend_from_slice(section_slice(bytes, sh)?);
    }
    let mut data_bytes: Vec<u8> = Vec::new();
    let mut data_base_per_shndx: Vec<(usize, u64)> = Vec::with_capacity(data_section_indices.len());
    for &sh_i in &data_section_indices {
        let sh = &shdrs[sh_i];
        if sh.sh_type == SHT_NOBITS {
            return Err(err(&format!(
                "data-family section at index {sh_i} has sh_type SHT_NOBITS (must hold file bytes)",
            )));
        }
        let base = data_bytes.len() as u64;
        data_base_per_shndx.push((sh_i, base));
        data_bytes.extend_from_slice(section_slice(bytes, sh)?);
    }
    let mut bss_size: usize = 0;
    let mut bss_base_per_shndx: Vec<(usize, u64)> = Vec::with_capacity(bss_section_indices.len());
    for &sh_i in &bss_section_indices {
        let sh = &shdrs[sh_i];
        if sh.sh_type != SHT_NOBITS {
            return Err(err(&format!(
                "bss-family section at index {sh_i} is not SHT_NOBITS",
            )));
        }
        bss_base_per_shndx.push((sh_i, bss_size as u64));
        bss_size += sh.sh_size as usize;
    }
    // TLS initialised storage (`.tdata*`): concatenate file
    // bytes; track per-section base for symbol rebasing. TLS
    // zero-init (`.tbss*`): sum sizes only -- no file content
    // (SHT_NOBITS). The merged image's PT_TLS segment carries
    // `tls_data` followed by `tls_bss_size` zero bytes.
    let mut tls_data_bytes: Vec<u8> = Vec::new();
    let mut tls_base_per_shndx: Vec<(usize, u64)> =
        Vec::with_capacity(tdata_section_indices.len() + tbss_section_indices.len());
    for &sh_i in &tdata_section_indices {
        let sh = &shdrs[sh_i];
        if sh.sh_type == SHT_NOBITS {
            return Err(err(&format!(
                "tdata-family section at index {sh_i} has sh_type SHT_NOBITS (must hold file bytes)",
            )));
        }
        let base = tls_data_bytes.len() as u64;
        tls_base_per_shndx.push((sh_i, base));
        tls_data_bytes.extend_from_slice(section_slice(bytes, sh)?);
    }
    let mut tls_bss_size: usize = 0;
    for &sh_i in &tbss_section_indices {
        let sh = &shdrs[sh_i];
        if sh.sh_type != SHT_NOBITS {
            return Err(err(&format!(
                "tbss-family section at index {sh_i} is not SHT_NOBITS",
            )));
        }
        // `.tbss` symbol values are measured against the start
        // of the TLS image (which begins at the first `.tdata`
        // byte). `.tbss` sits past the `.tdata` extent.
        tls_base_per_shndx.push((sh_i, (tls_data_bytes.len() + tls_bss_size) as u64));
        tls_bss_size += sh.sh_size as usize;
    }

    // `.symtab` -> linked `.strtab` lives at `sh_link`.
    let strtab_sh_i = symtab_sh.sh_link as usize;
    let strtab_sh = shdrs.get(strtab_sh_i).ok_or_else(|| {
        err(&format!(
            ".symtab's sh_link ({strtab_sh_i}) is not a valid section index"
        ))
    })?;
    if strtab_sh.sh_type != SHT_STRTAB {
        return Err(err(".symtab's linked .strtab section is not SHT_STRTAB"));
    }
    let strtab_bytes = section_slice(bytes, strtab_sh)?;

    // Decode the symbol table. STT_SECTION entries (one per
    // section the assembler kept) stay in the array because
    // many `.rela.*` entries reference them directly (with the
    // addend carrying the offset within the section); they
    // surface with their name field empty and the matching
    // `section` kind, and the linker resolves the reloc
    // through `defined.section` + `value`.
    if symtab_sh.sh_entsize != ELF64_SYM_SIZE as u64 {
        return Err(err(&format!(
            ".symtab entry size is {} bytes; expected {ELF64_SYM_SIZE}",
            symtab_sh.sh_entsize,
        )));
    }
    let symtab_bytes = section_slice(bytes, symtab_sh)?;
    let n_syms = symtab_bytes.len() / ELF64_SYM_SIZE;
    let mut symbols: Vec<NativeSymbol> = Vec::with_capacity(n_syms);
    for i in 0..n_syms {
        let sym: Elf64Sym = read_struct(symtab_bytes, i * ELF64_SYM_SIZE)?;
        let binding = sym.st_info >> 4;
        let kind = sym.st_info & 0xf;
        let (section, value_offset) = section_of_shndx(
            sym.st_shndx,
            &text_base_per_shndx,
            &data_base_per_shndx,
            &bss_base_per_shndx,
            &tls_base_per_shndx,
            debug_abbrev_idx,
            debug_line_idx,
            debug_str_idx,
        );
        symbols.push(NativeSymbol {
            name: if sym.st_name == 0 {
                String::new()
            } else {
                strtab_str(strtab_bytes, sym.st_name as usize)?.to_string()
            },
            section,
            value: sym.st_value + value_offset,
            size: sym.st_size,
            binding,
            kind,
        });
    }

    // Decode every `.rela.<section>` SHT_RELA section. The
    // section's `sh_info` field names the target section it
    // patches; the parser routes each entry into `text_relocs`
    // or `data_relocs` based on the target's family, rebasing
    // the `r_offset` by the target section's position within
    // the merged section's blob. ELF says `.rela.bss` is
    // ill-formed (BSS bytes are zero-init and don't carry
    // relocs), and a TU without `.rela.text` / `.rela.data` is
    // valid (no relocs to decode).
    let mut text_relocs: Vec<NativeReloc> = Vec::new();
    let mut data_relocs: Vec<NativeReloc> = Vec::new();
    for &rela_sh_i in &rela_section_indices {
        let rela_sh = &shdrs[rela_sh_i];
        if rela_sh.sh_type != SHT_RELA {
            return Err(err(&format!(
                ".rela.* section at index {rela_sh_i} is not SHT_RELA",
            )));
        }
        if rela_sh.sh_entsize != ELF64_RELA_SIZE as u64 {
            return Err(err(&format!(
                ".rela.* entry size at index {rela_sh_i} is {} bytes; expected {ELF64_RELA_SIZE}",
                rela_sh.sh_entsize,
            )));
        }
        // `sh_info` of a SHT_RELA section names the target
        // section it patches. Look the target up in the per-
        // family base maps to find its position within the
        // merged section's blob.
        let target_shndx = rela_sh.sh_info as usize;
        let (target_base, into_text) = if let Some(&(_, base)) = text_base_per_shndx
            .iter()
            .find(|&&(idx, _)| idx == target_shndx)
        {
            (base, true)
        } else if let Some(&(_, base)) = data_base_per_shndx
            .iter()
            .find(|&&(idx, _)| idx == target_shndx)
        {
            (base, false)
        } else {
            return Err(err(&format!(
                ".rela.* section at index {rela_sh_i} targets section {target_shndx} \
                 which is neither a text-family nor a data-family section",
            )));
        };
        let rela_bytes = section_slice(bytes, rela_sh)?;
        let n_relocs = rela_bytes.len() / ELF64_RELA_SIZE;
        for j in 0..n_relocs {
            let rela: Elf64Rela = read_struct(rela_bytes, j * ELF64_RELA_SIZE)?;
            let sym_idx = (rela.r_info >> 32) as usize;
            let rtype = (rela.r_info & 0xffff_ffff) as u32;
            let entry = NativeReloc {
                offset: target_base + rela.r_offset,
                sym_idx,
                rtype,
                addend: rela.r_addend,
            };
            if into_text {
                text_relocs.push(entry);
            } else {
                data_relocs.push(entry);
            }
        }
    }

    // `.note.badc` -- vendor note section. Record types:
    //   type=1 NT_BADC_DYLIBS       -- NUL-separated dylib paths.
    //   type=2 NT_BADC_BINDING_MAP  -- per-import dylib routing,
    //                                  encoded as (u32 LE
    //                                  dylib_index, NUL import
    //                                  name)+.
    //   type=3 NT_BADC_EXPORTS      -- NUL-separated `#pragma export`
    //                                  names.
    //   type=4 NT_BADC_TLS_INDEX    -- u64 LE `.text` byte offsets of
    //                                  Win64 `_tls_index` fixup sites.
    //   type=5 NT_BADC_MACHO_TLV_DESC  -- u64 LE TLV `offset_in_block`
    //                                     values, one per variable.
    //   type=6 NT_BADC_MACHO_TLV_FIXUP -- (u64 adrp_offset, u64
    //                                     descriptor_index) pairs.
    // Records under namesz != "badc\0" are skipped silently so
    // future vendor extensions can coexist.
    let mut dylibs: Vec<String> = Vec::new();
    let mut import_dylib_map: Vec<(String, u32)> = Vec::new();
    let mut exports: Vec<String> = Vec::new();
    let mut tls_index_fixups: Vec<usize> = Vec::new();
    let mut macho_tlv_descriptors: Vec<u64> = Vec::new();
    let mut macho_tlv_fixups: Vec<(usize, usize)> = Vec::new();
    let mut copy_relocs: Vec<(String, String)> = Vec::new();
    if let Some(i) = dylibs_section_idx {
        let body = section_slice(bytes, &shdrs[i])?;
        let mut cur = 0usize;
        while cur + core::mem::size_of::<Elf64Nhdr>() <= body.len() {
            let nhdr: Elf64Nhdr = read_struct(body, cur)?;
            let namesz = nhdr.n_namesz as usize;
            let descsz = nhdr.n_descsz as usize;
            let ntype = nhdr.n_type;
            cur += core::mem::size_of::<Elf64Nhdr>();
            let name_end = cur.saturating_add(namesz);
            if name_end > body.len() {
                break;
            }
            let name = &body[cur..name_end];
            let name_padded = (namesz + 3) & !3;
            cur = cur.saturating_add(name_padded);
            let desc_end = cur.saturating_add(descsz);
            if desc_end > body.len() {
                break;
            }
            if name == b"badc\0" {
                match ntype {
                    1 => {
                        for chunk in body[cur..desc_end].split(|&b| b == 0) {
                            if chunk.is_empty() {
                                continue;
                            }
                            dylibs.push(String::from_utf8_lossy(chunk).into_owned());
                        }
                    }
                    2 => {
                        let mut bm_cur = cur;
                        while bm_cur + 4 <= desc_end {
                            let idx =
                                u32::from_le_bytes(body[bm_cur..bm_cur + 4].try_into().unwrap());
                            bm_cur += 4;
                            let name_start = bm_cur;
                            let Some(nul_pos) = body[bm_cur..desc_end].iter().position(|&b| b == 0)
                            else {
                                break;
                            };
                            let name_end = name_start + nul_pos;
                            let imp_name =
                                String::from_utf8_lossy(&body[name_start..name_end]).into_owned();
                            bm_cur = name_end + 1;
                            import_dylib_map.push((imp_name, idx));
                        }
                    }
                    3 => {
                        for chunk in body[cur..desc_end].split(|&b| b == 0) {
                            if chunk.is_empty() {
                                continue;
                            }
                            exports.push(String::from_utf8_lossy(chunk).into_owned());
                        }
                    }
                    4 => {
                        let mut tc = cur;
                        while tc + 8 <= desc_end {
                            let off =
                                u64::from_le_bytes(body[tc..tc + 8].try_into().unwrap()) as usize;
                            tls_index_fixups.push(off);
                            tc += 8;
                        }
                    }
                    5 => {
                        let mut tc = cur;
                        while tc + 8 <= desc_end {
                            let off = u64::from_le_bytes(body[tc..tc + 8].try_into().unwrap());
                            macho_tlv_descriptors.push(off);
                            tc += 8;
                        }
                    }
                    6 => {
                        let mut tc = cur;
                        while tc + 16 <= desc_end {
                            let adrp =
                                u64::from_le_bytes(body[tc..tc + 8].try_into().unwrap()) as usize;
                            let idx = u64::from_le_bytes(body[tc + 8..tc + 16].try_into().unwrap())
                                as usize;
                            macho_tlv_fixups.push((adrp, idx));
                            tc += 16;
                        }
                    }
                    7 => {
                        let mut c = cur;
                        while c < desc_end {
                            let Some(p1) = body[c..desc_end].iter().position(|&b| b == 0) else {
                                break;
                            };
                            let local = String::from_utf8_lossy(&body[c..c + p1]).into_owned();
                            c += p1 + 1;
                            let Some(p2) = body[c..desc_end].iter().position(|&b| b == 0) else {
                                break;
                            };
                            let host = String::from_utf8_lossy(&body[c..c + p2]).into_owned();
                            c += p2 + 1;
                            copy_relocs.push((local, host));
                        }
                    }
                    _ => {}
                }
            }
            cur = cur.saturating_add((descsz + 3) & !3);
        }
    }

    // Standard DWARF 4 sections. Copy each section's bytes
    // verbatim; the linker concatenates per-unit blobs and
    // rebases addresses through the matching `.rela.debug_*`
    // relocations. Empty when the producer didn't emit DWARF
    // (no `-g` equivalent in c5; the writer emits these
    // unconditionally for relocatable output).
    let debug_info = if let Some(i) = debug_info_idx {
        section_slice(bytes, &shdrs[i])?.to_vec()
    } else {
        Vec::new()
    };
    let debug_abbrev = if let Some(i) = debug_abbrev_idx {
        section_slice(bytes, &shdrs[i])?.to_vec()
    } else {
        Vec::new()
    };
    let debug_line = if let Some(i) = debug_line_idx {
        section_slice(bytes, &shdrs[i])?.to_vec()
    } else {
        Vec::new()
    };
    let debug_str = if let Some(i) = debug_str_idx {
        section_slice(bytes, &shdrs[i])?.to_vec()
    } else {
        Vec::new()
    };
    let debug_info_relocs = if let Some(i) = rela_debug_info_idx {
        parse_rela(bytes, &shdrs[i])?
    } else {
        Vec::new()
    };
    let debug_line_relocs = if let Some(i) = rela_debug_line_idx {
        parse_rela(bytes, &shdrs[i])?
    } else {
        Vec::new()
    };

    Ok(NativeObject {
        machine,
        text: text_bytes,
        data: data_bytes,
        bss_size,
        tls_data: tls_data_bytes,
        tls_bss_size,
        symbols,
        text_relocs,
        data_relocs,
        dylibs,
        import_dylib_map,
        exports,
        tls_index_fixups,
        macho_tlv_descriptors,
        macho_tlv_fixups,
        copy_relocs,
        debug_info,
        debug_abbrev,
        debug_line,
        debug_str,
        debug_info_relocs,
        debug_line_relocs,
    })
}

/// Parse a `.rela.<target>` section body into a list of
/// [`NativeReloc`] entries. The section header carries the
/// section the rela entries apply to (`sh_info`); the parser
/// returns the entries opaque -- the caller routes them by the
/// section context. Used for `.rela.debug_info` /
/// `.rela.debug_line` so the linker can rebase address slots
/// inside the DWARF byte streams without growing a parallel
/// `text_relocs` / `data_relocs` pair per section.
fn parse_rela(bytes: &[u8], sh: &Elf64Shdr) -> Result<Vec<NativeReloc>, C5Error> {
    if sh.sh_size == 0 {
        return Ok(Vec::new());
    }
    let body = section_slice(bytes, sh)?;
    let entsize = ELF64_RELA_SIZE;
    if !body.len().is_multiple_of(entsize) {
        return Err(err(&format!(
            ".rela section size {} is not a multiple of {}",
            body.len(),
            entsize,
        )));
    }
    let count = body.len() / entsize;
    let mut out = Vec::with_capacity(count);
    for i in 0..count {
        let rela: Elf64Rela = read_struct(body, i * entsize)?;
        // ELF64 `r_info` packs the symbol index in the high 32 bits and
        // the relocation type in the low 32 (ELF64_R_SYM / _R_TYPE).
        out.push(NativeReloc {
            offset: rela.r_offset,
            sym_idx: (rela.r_info >> 32) as usize,
            rtype: (rela.r_info & 0xffff_ffff) as u32,
            addend: rela.r_addend,
        });
    }
    Ok(out)
}

// ---- Internal helpers ----

fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
        "linker::object: {msg}",
    )))
}

fn section_slice<'a>(bytes: &'a [u8], sh: &Elf64Shdr) -> Result<&'a [u8], C5Error> {
    if sh.sh_type == SHT_NOBITS {
        return Ok(&[]);
    }
    let off = sh.sh_offset as usize;
    let size = sh.sh_size as usize;
    if off + size > bytes.len() {
        return Err(err(&format!(
            "section runs past end of file (offset 0x{off:x} + size 0x{size:x} > len {})",
            bytes.len(),
        )));
    }
    Ok(&bytes[off..off + size])
}

fn strtab_str(strtab: &[u8], off: usize) -> Result<&str, C5Error> {
    if off >= strtab.len() {
        return Err(err(&format!(
            "string offset 0x{off:x} past end of strtab (len {})",
            strtab.len(),
        )));
    }
    let end = strtab[off..]
        .iter()
        .position(|&b| b == 0)
        .ok_or_else(|| err("strtab string is not NUL-terminated"))?;
    core::str::from_utf8(&strtab[off..off + end])
        .map_err(|e| err(&format!("strtab string is not UTF-8: {e}")))
}

/// Returns the merged-image section kind for a section index
/// plus the byte offset to add to the symbol's `st_value` so it
/// lands at the right position inside the merged section. The
/// base maps cover every section in the family (the unqualified
/// `.text` / `.data` / `.bss` sit at base 0 by construction);
/// any section not in the family maps surfaces as UNDEF so the
/// linker treats it as a missing reference rather than silently
/// miscategorising it.
#[allow(clippy::too_many_arguments)]
fn section_of_shndx(
    shndx: u16,
    text_base_per_shndx: &[(usize, u64)],
    data_base_per_shndx: &[(usize, u64)],
    bss_base_per_shndx: &[(usize, u64)],
    tls_base_per_shndx: &[(usize, u64)],
    debug_abbrev_idx: Option<usize>,
    debug_line_idx: Option<usize>,
    debug_str_idx: Option<usize>,
) -> (NativeSymSection, u64) {
    if shndx == SHN_UNDEF {
        return (NativeSymSection::Undef, 0);
    }
    if shndx == SHN_ABS {
        return (NativeSymSection::Abs, 0);
    }
    if shndx == SHN_COMMON {
        // st_value is the requested alignment for SHN_COMMON
        // symbols; the symbol decoder preserves it in
        // NativeSymbol::value (no rebasing -- there is no
        // backing section to concatenate into yet).
        return (NativeSymSection::Common, 0);
    }
    let i = shndx as usize;
    if let Some(&(_, base)) = text_base_per_shndx.iter().find(|&&(idx, _)| idx == i) {
        return (NativeSymSection::Text, base);
    }
    if let Some(&(_, base)) = data_base_per_shndx.iter().find(|&&(idx, _)| idx == i) {
        return (NativeSymSection::Data, base);
    }
    if let Some(&(_, base)) = bss_base_per_shndx.iter().find(|&&(idx, _)| idx == i) {
        return (NativeSymSection::Bss, base);
    }
    if let Some(&(_, base)) = tls_base_per_shndx.iter().find(|&&(idx, _)| idx == i) {
        return (NativeSymSection::Tls, base);
    }
    if Some(i) == debug_abbrev_idx {
        return (NativeSymSection::DebugAbbrev, 0);
    }
    if Some(i) == debug_line_idx {
        return (NativeSymSection::DebugLine, 0);
    }
    if Some(i) == debug_str_idx {
        return (NativeSymSection::DebugStr, 0);
    }
    (NativeSymSection::Undef, 0)
}

/// Classification used to fold each section into the merged
/// text / data / bss / tls blob. `Text` covers `.text` and any
/// `.text.<name>` clang/gcc `-ffunction-sections` emits;
/// `Data` covers `.data` + per-variable `.data.<name>`
/// (`-fdata-sections`), `.rodata*` (string literals + const
/// globals), and `.data.rel.ro*` (initialised-then-readonly
/// tables); `Bss` covers `.bss` + per-variable `.bss.<name>`;
/// `Tdata` and `Tbss` cover the matching `_Thread_local`
/// storage families.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum SectionFamily {
    Text,
    Data,
    Bss,
    Tdata,
    Tbss,
    Other,
}

fn classify_section_family(name: &str) -> SectionFamily {
    if name == ".text" || name.starts_with(".text.") {
        SectionFamily::Text
    } else if name == ".data"
        || name.starts_with(".data.")
        || name == ".rodata"
        || name.starts_with(".rodata.")
    {
        SectionFamily::Data
    } else if name == ".bss" || name.starts_with(".bss.") {
        SectionFamily::Bss
    } else if name == ".tdata" || name.starts_with(".tdata.") {
        SectionFamily::Tdata
    } else if name == ".tbss" || name.starts_with(".tbss.") {
        SectionFamily::Tbss
    } else {
        SectionFamily::Other
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn rejects_non_elf_blob() {
        let err = parse_native_elf(b"not an elf at all").unwrap_err();
        assert!(
            err.to_string().contains("0x7F ELF magic"),
            "unexpected error: {err}",
        );
    }

    #[test]
    fn rejects_truncated_header() {
        let err = parse_native_elf(&[0x7f, b'E', b'L', b'F']).unwrap_err();
        assert!(
            err.to_string().contains("truncated"),
            "unexpected error: {err}",
        );
    }

    /// End-to-end: take an ET_REL produced by
    /// `codegen/elf_reloc.rs` for a tiny C program and parse
    /// every section back out. Pins the encoder / decoder
    /// contract so a writer change that breaks the round-trip
    /// surfaces immediately.
    /// Under `OutputKind::Relocatable` the codegen skips PLT
    /// trampoline emission, so every BL placeholder reaching an
    /// external import stays at imm26 = 0 and the matching
    /// `R_AARCH64_CALL26` reloc carries the import name. The
    /// system linker (or our own native linker) materialises the
    /// PLT pool when producing the final image.
    #[test]
    fn relocatable_leaves_bl_placeholders_raw_on_aarch64() {
        use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
        let src = "#include <stdio.h>\nint main(void){printf(\"x\\n\");return 0;}\n";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        // Force aarch64; aarch64's BL is one 4-byte word, easy
        // to inspect directly.
        let target = Target::LinuxAarch64;
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse");
        // Find the first reloc against an UNDEF symbol and
        // assert the BL placeholder at its offset is the raw
        // `b 0x0` encoding (imm26 = 0 ; opcode bits 31..26 ==
        // 0b000101 for B, 0b100101 for BL; both have all imm26
        // bits cleared).
        let r = obj
            .text_relocs
            .iter()
            .find(|r| {
                obj.symbols
                    .get(r.sym_idx)
                    .map(|s| matches!(s.section, NativeSymSection::Undef))
                    .unwrap_or(false)
            })
            .expect("expected at least one reloc against an UNDEF import");
        let off = r.offset as usize;
        let instr = u32::from_le_bytes([
            obj.text[off],
            obj.text[off + 1],
            obj.text[off + 2],
            obj.text[off + 3],
        ]);
        // imm26 occupies bits 0..26 and must be zero in the
        // raw BL/B placeholder.
        let imm26 = instr & 0x03ff_ffff;
        assert_eq!(
            imm26, 0,
            "expected raw BL/B placeholder (imm26 = 0); got instr = {instr:#x} at offset {off}",
        );
    }

    #[test]
    fn parses_writer_output_for_printf_hello() {
        use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};
        let src = "#include <stdio.h>\nint main(void){printf(\"hi\\n\");return 0;}\n";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let target = Target::host();
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        assert!(is_elf_object(&bytes), "writer produced non-ELF output");
        let obj = parse_native_elf(&bytes).expect("parse");
        assert!(!obj.text.is_empty(), ".text round-trip");
        let has_main = obj
            .symbols
            .iter()
            .any(|s| s.name == "main" && matches!(s.section, NativeSymSection::Text));
        assert!(
            has_main,
            "expected `main` STT_FUNC symbol; got {:?}",
            obj.symbols
        );
        // The .o writer surfaces each libc import under the
        // host target's `real_symbol` from `#pragma binding`,
        // so the expected name is host-dependent: Mach-O has a
        // leading underscore, ELF / PE do not.
        let printf_real = match target {
            Target::MacOSAarch64 => "_printf",
            _ => "printf",
        };
        let has_printf_undef = obj
            .symbols
            .iter()
            .any(|s| s.name == printf_real && matches!(s.section, NativeSymSection::Undef));
        assert!(
            has_printf_undef,
            "expected UNDEF `{printf_real}` import; got {:?}",
            obj.symbols,
        );
        // At least one CALL26 reloc against the printf import.
        let has_call26 = obj.text_relocs.iter().any(|r| {
            obj.symbols
                .get(r.sym_idx)
                .map(|s| s.name == printf_real)
                .unwrap_or(false)
        });
        assert!(
            has_call26,
            "expected a reloc against `printf`; got {:?}",
            obj.text_relocs,
        );
        // bss size + relocations against .data section symbols are
        // also valid; pin the machine field.
        match target {
            Target::LinuxX64 | Target::WindowsX64 => {
                assert_eq!(obj.machine, NativeMachine::X86_64);
            }
            _ => {
                assert_eq!(obj.machine, NativeMachine::Aarch64);
            }
        }
        // Pin the rest of the public contract so a writer
        // change that drops a field surfaces here.
        let _ = obj.bss_size;
        let _ = obj.data.len();
    }

    /// Append a `#[repr(C)]` record as little-endian bytes. The
    /// hand-built fixtures below use the same on-disk structs
    /// the parser reads, so a struct-layout regression surfaces
    /// in both directions at once.
    fn write_struct<T: Copy>(buf: &mut Vec<u8>, value: &T) {
        // SAFETY: T is `#[repr(C)] Copy`; we know the byte
        // count exactly and we're appending to a `Vec<u8>` that
        // owns the storage. Little-endian host == little-endian
        // on-disk layout for x86_64 / aarch64.
        let n = core::mem::size_of::<T>();
        let ptr = value as *const T as *const u8;
        let slice = unsafe { core::slice::from_raw_parts(ptr, n) };
        buf.extend_from_slice(slice);
    }

    /// Plan for one section in [`build_test_elf`]. The builder
    /// inserts a NULL section and a `.shstrtab` section
    /// automatically (at indices 0 and 1); caller-provided
    /// sections start at index 2.
    struct SecPlan<'a> {
        name: &'a str,
        sh_type: u32,
        body: Vec<u8>,
        sh_link: u32,
        sh_info: u32,
        sh_entsize: u64,
        /// Override `sh_size` -- needed for SHT_NOBITS where
        /// the file body is empty but the runtime size isn't.
        sh_size_override: Option<u64>,
    }

    impl<'a> SecPlan<'a> {
        fn progbits(name: &'a str, body: impl Into<Vec<u8>>) -> Self {
            Self {
                name,
                sh_type: SHT_PROGBITS,
                body: body.into(),
                sh_link: 0,
                sh_info: 0,
                sh_entsize: 0,
                sh_size_override: None,
            }
        }
        fn nobits(name: &'a str, size: u64) -> Self {
            Self {
                name,
                sh_type: SHT_NOBITS,
                body: Vec::new(),
                sh_link: 0,
                sh_info: 0,
                sh_entsize: 0,
                sh_size_override: Some(size),
            }
        }
        fn symtab(name: &'a str, body: Vec<u8>, link: u32, info: u32) -> Self {
            Self {
                name,
                sh_type: SHT_SYMTAB,
                body,
                sh_link: link,
                sh_info: info,
                sh_entsize: ELF64_SYM_SIZE as u64,
                sh_size_override: None,
            }
        }
        fn strtab(name: &'a str, body: Vec<u8>) -> Self {
            Self {
                name,
                sh_type: SHT_STRTAB,
                body,
                sh_link: 0,
                sh_info: 0,
                sh_entsize: 0,
                sh_size_override: None,
            }
        }
        fn rela(name: &'a str, body: Vec<u8>, link: u32, info: u32) -> Self {
            Self {
                name,
                sh_type: SHT_RELA,
                body,
                sh_link: link,
                sh_info: info,
                sh_entsize: ELF64_RELA_SIZE as u64,
                sh_size_override: None,
            }
        }
    }

    /// Assemble an ET_REL byte image. The builder owns
    /// `.shstrtab` (at index 1); caller-named sections start at
    /// index 2 in the section header table. Returns the byte
    /// image ready for `parse_native_elf`.
    fn build_test_elf(machine: u16, plans: &[SecPlan<'_>]) -> Vec<u8> {
        // Section index layout:
        //   0: NULL
        //   1: .shstrtab
        //   2..: caller's `plans`
        let n_total = 2 + plans.len();
        // Build .shstrtab body + per-section name offsets.
        let mut shstrtab: Vec<u8> = vec![0]; // NULL section gets offset 0.
        let mut name_offs: Vec<u32> = Vec::with_capacity(n_total);
        name_offs.push(0); // NULL section
        let shstrtab_name_off = shstrtab.len() as u32;
        shstrtab.extend_from_slice(b".shstrtab");
        shstrtab.push(0);
        name_offs.push(shstrtab_name_off);
        for p in plans {
            name_offs.push(shstrtab.len() as u32);
            shstrtab.extend_from_slice(p.name.as_bytes());
            shstrtab.push(0);
        }
        // Lay sections out: ELF header, section header table,
        // then section bodies in declaration order. `.shstrtab`
        // lands first among body sections; caller bodies follow.
        let hdr_size = core::mem::size_of::<Elf64Ehdr>();
        let shdr_size = core::mem::size_of::<Elf64Shdr>();
        let mut sec_offs: Vec<usize> = Vec::with_capacity(n_total);
        let mut cursor = hdr_size + n_total * shdr_size;
        sec_offs.push(0); // NULL
        sec_offs.push(cursor);
        cursor += shstrtab.len();
        for p in plans {
            sec_offs.push(cursor);
            cursor += p.body.len();
        }
        let total = cursor;
        let mut bytes = vec![0u8; total];
        // ELF header.
        let mut ehdr = Elf64Ehdr {
            e_ident: [0; 16],
            e_type: ET_REL,
            e_machine: machine,
            e_version: 1,
            e_entry: 0,
            e_phoff: 0,
            e_shoff: hdr_size as u64,
            e_flags: 0,
            e_ehsize: hdr_size as u16,
            e_phentsize: 0,
            e_phnum: 0,
            e_shentsize: shdr_size as u16,
            e_shnum: n_total as u16,
            e_shstrndx: 1,
        };
        ehdr.e_ident[0..4].copy_from_slice(b"\x7fELF");
        ehdr.e_ident[4] = ELF_CLASS_64;
        ehdr.e_ident[5] = ELF_DATA_LSB;
        ehdr.e_ident[6] = 1;
        {
            let mut buf = Vec::with_capacity(hdr_size);
            write_struct(&mut buf, &ehdr);
            bytes[0..hdr_size].copy_from_slice(&buf);
        }
        // Per-section header writer.
        let write_shdr_at = |bytes: &mut [u8], idx: usize, shdr: Elf64Shdr| {
            let mut buf = Vec::with_capacity(shdr_size);
            write_struct(&mut buf, &shdr);
            let base = hdr_size + idx * shdr_size;
            bytes[base..base + shdr_size].copy_from_slice(&buf);
        };
        // [0] NULL section.
        write_shdr_at(
            &mut bytes,
            0,
            Elf64Shdr {
                sh_name: 0,
                sh_type: 0,
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
        // [1] .shstrtab.
        write_shdr_at(
            &mut bytes,
            1,
            Elf64Shdr {
                sh_name: name_offs[1],
                sh_type: SHT_STRTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: sec_offs[1] as u64,
                sh_size: shstrtab.len() as u64,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 0,
                sh_entsize: 0,
            },
        );
        // [2..] caller sections.
        for (i, p) in plans.iter().enumerate() {
            let idx = i + 2;
            write_shdr_at(
                &mut bytes,
                idx,
                Elf64Shdr {
                    sh_name: name_offs[idx],
                    sh_type: p.sh_type,
                    sh_flags: 0,
                    sh_addr: 0,
                    sh_offset: sec_offs[idx] as u64,
                    sh_size: p.sh_size_override.unwrap_or(p.body.len() as u64),
                    sh_link: p.sh_link,
                    sh_info: p.sh_info,
                    sh_addralign: 0,
                    sh_entsize: p.sh_entsize,
                },
            );
        }
        // Section bodies: .shstrtab at index 1, then the plans.
        bytes[sec_offs[1]..sec_offs[1] + shstrtab.len()].copy_from_slice(&shstrtab);
        for (i, p) in plans.iter().enumerate() {
            let off = sec_offs[i + 2];
            bytes[off..off + p.body.len()].copy_from_slice(&p.body);
        }
        bytes
    }

    /// Encode one `.symtab` entry into a buffer used by
    /// [`build_test_elf`].
    fn push_test_sym(
        out: &mut Vec<u8>,
        st_name: u32,
        st_info: u8,
        st_shndx: u16,
        st_value: u64,
        st_size: u64,
    ) {
        write_struct(
            out,
            &Elf64Sym {
                st_name,
                st_info,
                st_other: 0,
                st_shndx,
                st_value,
                st_size,
            },
        );
    }

    /// Encode one `.rela.<section>` entry into a buffer used by
    /// [`build_test_elf`].
    fn push_test_rela(out: &mut Vec<u8>, r_offset: u64, sym_idx: u32, rtype: u32, r_addend: i64) {
        let r_info = ((sym_idx as u64) << 32) | (rtype as u64);
        write_struct(
            out,
            &Elf64Rela {
                r_offset,
                r_info,
                r_addend,
            },
        );
    }

    /// Hand-crafted ET_REL with `.text` / `.data` / `.rodata`
    /// and one `.rela.data` entry whose `sym_idx` points at the
    /// `.rodata` `STT_SECTION` symbol. Pins the rodata-family
    /// support: the rodata bytes append after `.data`, the
    /// rodata section symbol surfaces with `section=Data` and
    /// `value=rodata_base_in_merged_data`, and the reloc's
    /// `sym_idx` still resolves to that symbol so the linker's
    /// existing Data-section path picks the right merged offset
    /// (`data_base + sym.value + addend`).
    #[test]
    fn rodata_section_lands_in_merged_data_blob() {
        // Caller-named sections start at index 2 in the
        // resulting ET_REL (NULL at 0, builder's .shstrtab at 1).
        //   2: .strtab
        //   3: .symtab     (sh_link=2 = strtab; sh_info=3 = first non-local sym)
        //   4: .text
        //   5: .data
        //   6: .rodata
        //   7: .rela.data  (sh_link=3 = symtab; sh_info=5 = .data target)
        let strtab: Vec<u8> = vec![0];
        let mut symtab = Vec::new();
        push_test_sym(&mut symtab, 0, 0, 0, 0, 0);
        // STT_SECTION on .data (shndx=5) / .rodata (shndx=6).
        push_test_sym(&mut symtab, 0, 0x03, 5, 0, 0);
        push_test_sym(&mut symtab, 0, 0x03, 6, 0, 0);
        let mut rodata = b"hi".to_vec();
        rodata.resize(8, 0);
        let mut rela_data = Vec::new();
        // R_X86_64_64 (type=1), sym=2 (.rodata STT_SECTION), addend=0.
        push_test_rela(&mut rela_data, 0, 2, 1, 0);
        let plans = [
            SecPlan::strtab(".strtab", strtab),
            SecPlan::symtab(".symtab", symtab, 2, 3),
            SecPlan::progbits(".text", Vec::new()),
            SecPlan::progbits(".data", vec![0u8; 8]),
            SecPlan::progbits(".rodata", rodata),
            SecPlan::rela(".rela.data", rela_data, 3, 5),
        ];
        let bytes = build_test_elf(EM_X86_64, &plans);
        let obj = parse_native_elf(&bytes).expect("parse hand-built ET_REL");
        // .data = original 8 bytes + 8 rodata bytes.
        assert_eq!(
            obj.data.len(),
            16,
            "merged data should be `.data` || `.rodata`"
        );
        assert_eq!(
            &obj.data[8..10],
            b"hi",
            "rodata bytes prepended after .data"
        );
        // sym[2] is the .rodata STT_SECTION; it should now sit in Data at value=8 (rodata base in merged data).
        let rodata_sym = &obj.symbols[2];
        assert!(
            matches!(rodata_sym.section, NativeSymSection::Data),
            "rodata STT_SECTION should land in Data; got {:?}",
            rodata_sym.section,
        );
        assert_eq!(
            rodata_sym.value, 8,
            "rodata STT_SECTION value should = .data size"
        );
        // The one .rela.data entry resolves to data_base + rodata_sym.value + addend = 0 + 8 + 0.
        assert_eq!(obj.data_relocs.len(), 1);
        let r = obj.data_relocs[0];
        assert_eq!(r.offset, 0);
        assert_eq!(r.sym_idx, 2);
        assert_eq!(r.addend, 0);
    }

    /// Clang/gcc `-ffunction-sections` shape: two `.text.<fn>`
    /// sections, no unqualified `.text`. Each function symbol
    /// (STT_FUNC) names its own section index; the parser
    /// concatenates the section bytes in section-index order
    /// and rebases each symbol's `st_value` by the section's
    /// base in the merged text blob. A `.rela.text.<fn>` entry
    /// at `r_offset = k` inside the second function lands at
    /// merged offset `first_text_size + k`.
    #[test]
    fn function_sections_concat_and_rebase_relocs() {
        // Sections at indices 2..: .strtab, .symtab, .text.helper,
        // .text.main, .rela.text.main.
        let mut strtab: Vec<u8> = vec![0];
        let helper_name_off = strtab.len() as u32;
        strtab.extend_from_slice(b"helper\0");
        let main_name_off = strtab.len() as u32;
        strtab.extend_from_slice(b"main\0");
        let printf_name_off = strtab.len() as u32;
        strtab.extend_from_slice(b"printf\0");
        let mut symtab = Vec::new();
        push_test_sym(&mut symtab, 0, 0, 0, 0, 0);
        // st_info = (STB_GLOBAL << 4) | STT_FUNC = 0x12.
        // helper @ .text.helper (shndx=4); main @ .text.main (shndx=5).
        push_test_sym(&mut symtab, helper_name_off, 0x12, 4, 0, 4);
        push_test_sym(&mut symtab, main_name_off, 0x12, 5, 0, 8);
        // STB_GLOBAL STT_NOTYPE UNDEF printf.
        push_test_sym(&mut symtab, printf_name_off, 0x10, 0, 0, 0);
        let mut rela_main = Vec::new();
        // R_X86_64_PLT32 (type=4), sym=3 (printf), addend=-4, offset=2 inside main.
        push_test_rela(&mut rela_main, 2, 3, 4, -4);
        let plans = [
            SecPlan::strtab(".strtab", strtab),
            SecPlan::symtab(".symtab", symtab, 2, 1),
            SecPlan::progbits(".text.helper", vec![0x11, 0x22, 0x33, 0x44]),
            SecPlan::progbits(".text.main", vec![0xaa; 8]),
            SecPlan::rela(".rela.text.main", rela_main, 3, 5),
        ];
        let bytes = build_test_elf(EM_X86_64, &plans);
        let obj = parse_native_elf(&bytes).expect("parse multi-text fixture");
        assert_eq!(
            obj.text.len(),
            4 + 8,
            "merged text should hold .text.helper || .text.main"
        );
        // Symbol [1] = helper. Should land at value=0 in merged text.
        assert!(matches!(obj.symbols[1].section, NativeSymSection::Text));
        assert_eq!(obj.symbols[1].name, "helper");
        assert_eq!(obj.symbols[1].value, 0);
        // Symbol [2] = main. Should land at value=4 (= helper section's size).
        assert!(matches!(obj.symbols[2].section, NativeSymSection::Text));
        assert_eq!(obj.symbols[2].name, "main");
        assert_eq!(obj.symbols[2].value, 4);
        // The one reloc lands in text_relocs with offset = 4 (main base) + 2 (original) = 6.
        assert_eq!(obj.text_relocs.len(), 1);
        let r = obj.text_relocs[0];
        assert_eq!(r.offset, 6);
        assert_eq!(r.sym_idx, 3);
        assert_eq!(r.addend, -4);
    }

    /// Clang under `-fcommon` (the pre-clang-11 default and gcc's
    /// default for C without `-fno-common`) emits uninitialised
    /// global definitions (`int uninit;`) as STB_GLOBAL with
    /// `st_shndx = SHN_COMMON`: per ELF, `st_size` is the
    /// symbol's byte size and `st_value` is the requested
    /// alignment. The parser surfaces these as `Common` so the
    /// linker can coalesce multi-unit definitions into a single
    /// `.bss` slot (C99 6.9.2 tentative-definition rules).
    #[test]
    fn common_symbol_surfaces_with_size_and_alignment() {
        let mut strtab: Vec<u8> = vec![0];
        let uninit_name_off = strtab.len() as u32;
        strtab.extend_from_slice(b"uninit_int\0");
        let mut symtab = Vec::new();
        push_test_sym(&mut symtab, 0, 0, 0, 0, 0);
        // STB_GLOBAL STT_OBJECT @ SHN_COMMON, value=4 (alignment), size=4 (bytes).
        push_test_sym(&mut symtab, uninit_name_off, 0x11, SHN_COMMON, 4, 4);
        let plans = [
            SecPlan::strtab(".strtab", strtab),
            SecPlan::symtab(".symtab", symtab, 2, 1),
            SecPlan::progbits(".text", Vec::new()),
        ];
        let bytes = build_test_elf(EM_X86_64, &plans);
        let obj = parse_native_elf(&bytes).expect("parse SHN_COMMON fixture");
        assert_eq!(obj.symbols.len(), 2);
        let s = &obj.symbols[1];
        assert!(matches!(s.section, NativeSymSection::Common));
        assert_eq!(s.name, "uninit_int");
        assert_eq!(s.size, 4, "byte size from st_size");
        assert_eq!(s.value, 4, "alignment from st_value");
    }

    /// `_Thread_local` storage: clang emits initialised TLS
    /// variables into `.tdata` and zero-init ones into `.tbss`,
    /// with STT_TLS symbols pointing at those sections. The
    /// parser concatenates `.tdata*` bytes into `tls_data`,
    /// sums `.tbss*` sizes into `tls_bss_size`, and surfaces
    /// symbols as `Tls` with the value rebased by the section's
    /// base in the merged TLS image (`.tdata` first, `.tbss`
    /// past it).
    #[test]
    fn tdata_and_tbss_sections_surface_as_tls() {
        let mut strtab: Vec<u8> = vec![0];
        let init_off = strtab.len() as u32;
        strtab.extend_from_slice(b"init_counter\0");
        let zero_off = strtab.len() as u32;
        strtab.extend_from_slice(b"zero_counter\0");
        let mut symtab = Vec::new();
        push_test_sym(&mut symtab, 0, 0, 0, 0, 0);
        // st_info = (STB_GLOBAL << 4) | STT_TLS = 0x16.
        // .tdata is at shndx=5; .tbss at shndx=6 in the laid-out
        // section header table (NULL=0, .shstrtab=1, .strtab=2,
        // .symtab=3, .text=4, .tdata=5, .tbss=6).
        push_test_sym(&mut symtab, init_off, 0x16, 5, 0, 4);
        push_test_sym(&mut symtab, zero_off, 0x16, 6, 0, 8);
        let plans = [
            SecPlan::strtab(".strtab", strtab),
            SecPlan::symtab(".symtab", symtab, 2, 1),
            SecPlan::progbits(".text", Vec::new()),
            SecPlan::progbits(".tdata", vec![0x42, 0, 0, 0]),
            SecPlan::nobits(".tbss", 8),
        ];
        let bytes = build_test_elf(EM_X86_64, &plans);
        let obj = parse_native_elf(&bytes).expect("parse TLS fixture");
        assert_eq!(obj.tls_data.len(), 4);
        assert_eq!(obj.tls_bss_size, 8);
        assert!(matches!(obj.symbols[1].section, NativeSymSection::Tls));
        assert_eq!(obj.symbols[1].value, 0, ".tdata symbol lands at TLS start");
        assert!(matches!(obj.symbols[2].section, NativeSymSection::Tls));
        assert_eq!(
            obj.symbols[2].value, 4,
            ".tbss symbol lands past the .tdata extent"
        );
    }

    /// Clang/gcc `-fdata-sections` shape: per-variable `.data.<var>`
    /// + `.bss.<var>` subsections, no unqualified `.data` / `.bss`.
    /// Each subsection's STT_OBJECT symbol points at its own
    /// section index; the parser concatenates the bytes (or
    /// sums bss sizes) in section-index order and rebases each
    /// symbol's `st_value` accordingly.
    #[test]
    fn data_sections_and_bss_sections_concat() {
        let mut strtab: Vec<u8> = vec![0];
        let first_off = strtab.len() as u32;
        strtab.extend_from_slice(b"first\0");
        let second_off = strtab.len() as u32;
        strtab.extend_from_slice(b"second\0");
        let zero_off = strtab.len() as u32;
        strtab.extend_from_slice(b"zero\0");
        let mut symtab = Vec::new();
        push_test_sym(&mut symtab, 0, 0, 0, 0, 0);
        // st_info = (STB_GLOBAL << 4) | STT_OBJECT = 0x11.
        // shndx 5 = .data.first, 6 = .data.second, 7 = .bss.zero.
        push_test_sym(&mut symtab, first_off, 0x11, 5, 0, 4);
        push_test_sym(&mut symtab, second_off, 0x11, 6, 0, 4);
        push_test_sym(&mut symtab, zero_off, 0x11, 7, 0, 8);
        let plans = [
            SecPlan::strtab(".strtab", strtab),
            SecPlan::symtab(".symtab", symtab, 2, 1),
            SecPlan::progbits(".text", Vec::new()),
            SecPlan::progbits(".data.first", vec![0xaa; 4]),
            SecPlan::progbits(".data.second", vec![0xbb; 4]),
            SecPlan::nobits(".bss.zero", 8),
        ];
        let bytes = build_test_elf(EM_AARCH64, &plans);
        let obj = parse_native_elf(&bytes).expect("parse multi-data fixture");
        assert_eq!(obj.text.len(), 0, "empty .text section");
        assert_eq!(obj.data.len(), 8, ".data.first || .data.second");
        assert_eq!(obj.bss_size, 8, ".bss.zero size");
        // Symbol [1] = first, Data, value=0.
        assert!(matches!(obj.symbols[1].section, NativeSymSection::Data));
        assert_eq!(obj.symbols[1].value, 0);
        // Symbol [2] = second, Data, value=4 (after .data.first).
        assert!(matches!(obj.symbols[2].section, NativeSymSection::Data));
        assert_eq!(obj.symbols[2].value, 4);
        // Symbol [3] = zero, Bss, value=0 (first bss section).
        assert!(matches!(obj.symbols[3].section, NativeSymSection::Bss));
        assert_eq!(obj.symbols[3].value, 0);
    }

    /// Same shape as `rodata_section_lands_in_merged_data_blob`
    /// but the section is named `.rodata.str.1.1` (clang's
    /// per-string subsection layout under `-fdata-sections`).
    /// The family-name predicate matches the `.rodata.` prefix.
    #[test]
    fn rodata_str_subsection_lands_in_merged_data_blob() {
        let strtab: Vec<u8> = vec![0];
        let mut symtab = Vec::new();
        push_test_sym(&mut symtab, 0, 0, 0, 0, 0);
        // STT_SECTION on .rodata.str.1.1 (shndx=6 after NULL,
        // .shstrtab, .strtab, .symtab, .text, .data, then the
        // rodata subsection at position 7? recount: NULL=0,
        // .shstrtab=1, .strtab=2, .symtab=3, .text=4, .data=5,
        // .rodata.str.1.1=6).
        push_test_sym(&mut symtab, 0, 0x03, 6, 0, 0);
        let plans = [
            SecPlan::strtab(".strtab", strtab),
            SecPlan::symtab(".symtab", symtab, 2, 2),
            SecPlan::progbits(".text", Vec::new()),
            SecPlan::progbits(".data", vec![0u8; 4]),
            SecPlan::progbits(".rodata.str.1.1", b"hello\0".to_vec()),
        ];
        let bytes = build_test_elf(EM_AARCH64, &plans);
        let obj = parse_native_elf(&bytes).expect("parse rodata.str.1.1 fixture");
        assert_eq!(obj.machine, NativeMachine::Aarch64);
        assert_eq!(
            obj.data.len(),
            4 + 6,
            "merged data should hold .data || .rodata.str.1.1"
        );
        assert_eq!(&obj.data[4..10], b"hello\0");
        let s = &obj.symbols[1];
        assert!(matches!(s.section, NativeSymSection::Data));
        assert_eq!(
            s.value, 4,
            "rodata STT_SECTION value should land at .data size"
        );
    }
}

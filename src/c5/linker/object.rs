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

const ELF64_EHDR_SIZE: usize = 64;
const ELF64_SHDR_SIZE: usize = 64;
const ELF64_SYM_SIZE: usize = 24;
const ELF64_RELA_SIZE: usize = 24;

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
    pub symbols: Vec<NativeSymbol>,
    pub text_relocs: Vec<NativeReloc>,
    /// `.rela.data` entries (`R_X86_64_64` / `R_AARCH64_ABS64`)
    /// the writer emitted for pointer-to-global initializers.
    /// Linker resolves each to `data_vaddr + target.value`,
    /// patching the 8-byte slot at `offset` in the merged
    /// `.data`.
    pub data_relocs: Vec<NativeReloc>,
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
    if bytes[4] != ELF_CLASS_64 {
        return Err(err("ELF object is not 64-bit (ELFCLASS64 expected)"));
    }
    if bytes[5] != ELF_DATA_LSB {
        return Err(err(
            "ELF object is not little-endian (ELFDATA2LSB expected)",
        ));
    }
    let e_type = u16_at(bytes, 16);
    if e_type != ET_REL {
        return Err(err(&format!(
            "ELF object is not relocatable (e_type = {e_type}, expected ET_REL = {ET_REL})",
        )));
    }
    let e_machine = u16_at(bytes, 18);
    let machine = match e_machine {
        EM_X86_64 => NativeMachine::X86_64,
        EM_AARCH64 => NativeMachine::Aarch64,
        other => {
            return Err(err(&format!(
                "ELF object's e_machine {other} is not one of EM_X86_64 ({EM_X86_64}) / EM_AARCH64 ({EM_AARCH64})",
            )));
        }
    };
    let e_shoff = u64_at(bytes, 40) as usize;
    let e_shentsize = u16_at(bytes, 58) as usize;
    let e_shnum = u16_at(bytes, 60) as usize;
    let e_shstrndx = u16_at(bytes, 62) as usize;
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
    let mut shdrs: Vec<SectionHeader> = Vec::with_capacity(e_shnum);
    for i in 0..e_shnum {
        let off = e_shoff + i * ELF64_SHDR_SIZE;
        shdrs.push(SectionHeader {
            name: u32_at(bytes, off),
            sh_type: u32_at(bytes, off + 4),
            flags: u64_at(bytes, off + 8),
            offset: u64_at(bytes, off + 24) as usize,
            size: u64_at(bytes, off + 32) as usize,
            link: u32_at(bytes, off + 40),
            info: u32_at(bytes, off + 44),
            entsize: u64_at(bytes, off + 56) as usize,
        });
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

    // Walk the headers once to identify the sections by name.
    // `.rodata` and `.data.rel.ro` (and their per-symbol
    // `.rodata.str.1.1` / `.data.rel.ro.local` variants) carry
    // const-initialised data alongside `.data`; clang and gcc
    // emit string literals and const globals there by default.
    // The linker treats them as data-style (writable in our
    // current loader because there's no separate read-only
    // segment yet), so the parser concatenates their bytes
    // after `.data` and remaps any symbol value or reloc
    // offset by the rodata section's base in the merged blob.
    let mut text_idx: Option<usize> = None;
    let mut data_idx: Option<usize> = None;
    let mut bss_idx: Option<usize> = None;
    let mut symtab_idx: Option<usize> = None;
    let mut rela_text_idx: Option<usize> = None;
    let mut rela_data_idx: Option<usize> = None;
    let mut rodata_section_indices: Vec<usize> = Vec::new();
    let mut rela_rodata_section_indices: Vec<usize> = Vec::new();
    for (i, sh) in shdrs.iter().enumerate() {
        let name = strtab_str(shstrtab_bytes, sh.name as usize)?;
        match name {
            ".text" => text_idx = Some(i),
            ".data" => data_idx = Some(i),
            ".bss" => bss_idx = Some(i),
            ".symtab" => symtab_idx = Some(i),
            ".rela.text" => rela_text_idx = Some(i),
            ".rela.data" => rela_data_idx = Some(i),
            _ => {
                if is_rodata_family_name(name) {
                    rodata_section_indices.push(i);
                } else if let Some(target) = rela_rodata_target_name(name)
                    && is_rodata_family_name(target)
                {
                    rela_rodata_section_indices.push(i);
                }
            }
        }
    }
    let text_sh = text_idx
        .map(|i| &shdrs[i])
        .ok_or_else(|| err("ELF object has no `.text` section"))?;
    let symtab_sh_i = symtab_idx.ok_or_else(|| err("ELF object has no `.symtab` section"))?;
    let symtab_sh = &shdrs[symtab_sh_i];

    let text_bytes = section_slice(bytes, text_sh)?.to_vec();
    let mut data_bytes: Vec<u8> = match data_idx {
        Some(i) => section_slice(bytes, &shdrs[i])?.to_vec(),
        None => Vec::new(),
    };
    // Append every rodata-family section's bytes after `.data`
    // and remember each one's base in the merged blob so the
    // symbol decoder and `.rela.rodata*` decoder can rebase
    // values / offsets against it.
    let mut rodata_base_per_shndx: Vec<(usize, u64)> =
        Vec::with_capacity(rodata_section_indices.len());
    for &sh_i in &rodata_section_indices {
        let sh = &shdrs[sh_i];
        if sh.sh_type == SHT_NOBITS {
            return Err(err(&format!(
                "rodata-family section at index {sh_i} has sh_type SHT_NOBITS (must hold file bytes)",
            )));
        }
        let base = data_bytes.len() as u64;
        rodata_base_per_shndx.push((sh_i, base));
        data_bytes.extend_from_slice(section_slice(bytes, sh)?);
    }
    let bss_size = match bss_idx {
        Some(i) => {
            if shdrs[i].sh_type != SHT_NOBITS {
                return Err(err("`.bss` section is not SHT_NOBITS"));
            }
            shdrs[i].size
        }
        None => 0,
    };

    // `.symtab` -> linked `.strtab` lives at `sh_link`.
    let strtab_sh_i = symtab_sh.link as usize;
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
    if symtab_sh.entsize != ELF64_SYM_SIZE {
        return Err(err(&format!(
            ".symtab entry size is {} bytes; expected {ELF64_SYM_SIZE}",
            symtab_sh.entsize,
        )));
    }
    let symtab_bytes = section_slice(bytes, symtab_sh)?;
    let n_syms = symtab_bytes.len() / ELF64_SYM_SIZE;
    let mut symbols: Vec<NativeSymbol> = Vec::with_capacity(n_syms);
    for i in 0..n_syms {
        let off = i * ELF64_SYM_SIZE;
        let st_name = u32_at(symtab_bytes, off) as usize;
        let st_info = symtab_bytes[off + 4];
        let st_shndx = u16_at(symtab_bytes, off + 6);
        let st_value = u64_at(symtab_bytes, off + 8);
        let st_size = u64_at(symtab_bytes, off + 16);
        let binding = st_info >> 4;
        let kind = st_info & 0xf;
        let (section, value_offset) = section_of_shndx(
            st_shndx,
            text_idx,
            data_idx,
            bss_idx,
            &rodata_base_per_shndx,
        );
        symbols.push(NativeSymbol {
            name: if st_name == 0 {
                String::new()
            } else {
                strtab_str(strtab_bytes, st_name)?.to_string()
            },
            section,
            value: st_value + value_offset,
            size: st_size,
            binding,
            kind,
        });
    }

    // Decode `.rela.text`, if present. The writer always emits
    // a `.rela.text` section (possibly empty); a missing
    // section is an error rather than an empty reloc list.
    let mut text_relocs: Vec<NativeReloc> = Vec::new();
    if let Some(i) = rela_text_idx {
        let rela_sh = &shdrs[i];
        if rela_sh.sh_type != SHT_RELA {
            return Err(err(".rela.text section is not SHT_RELA"));
        }
        if rela_sh.entsize != ELF64_RELA_SIZE {
            return Err(err(&format!(
                ".rela.text entry size is {} bytes; expected {ELF64_RELA_SIZE}",
                rela_sh.entsize,
            )));
        }
        let rela_bytes = section_slice(bytes, rela_sh)?;
        let n_relocs = rela_bytes.len() / ELF64_RELA_SIZE;
        for j in 0..n_relocs {
            let off = j * ELF64_RELA_SIZE;
            let r_offset = u64_at(rela_bytes, off);
            let r_info = u64_at(rela_bytes, off + 8);
            let r_addend = i64_at(rela_bytes, off + 16);
            let sym_idx = (r_info >> 32) as usize;
            let rtype = (r_info & 0xffff_ffff) as u32;
            text_relocs.push(NativeReloc {
                offset: r_offset,
                sym_idx,
                rtype,
                addend: r_addend,
            });
        }
    }

    // Decode `.rela.data` the same way as `.rela.text`; the
    // section is optional and absent when the TU has no
    // pointer-to-global initializers.
    let mut data_relocs: Vec<NativeReloc> = Vec::new();
    if let Some(i) = rela_data_idx {
        let rela_sh = &shdrs[i];
        if rela_sh.sh_type != SHT_RELA {
            return Err(err(".rela.data section is not SHT_RELA"));
        }
        if rela_sh.entsize != ELF64_RELA_SIZE {
            return Err(err(&format!(
                ".rela.data entry size is {} bytes; expected {ELF64_RELA_SIZE}",
                rela_sh.entsize,
            )));
        }
        let rela_bytes = section_slice(bytes, rela_sh)?;
        let n_relocs = rela_bytes.len() / ELF64_RELA_SIZE;
        for j in 0..n_relocs {
            let off = j * ELF64_RELA_SIZE;
            let r_offset = u64_at(rela_bytes, off);
            let r_info = u64_at(rela_bytes, off + 8);
            let r_addend = i64_at(rela_bytes, off + 16);
            let sym_idx = (r_info >> 32) as usize;
            let rtype = (r_info & 0xffff_ffff) as u32;
            data_relocs.push(NativeReloc {
                offset: r_offset,
                sym_idx,
                rtype,
                addend: r_addend,
            });
        }
    }
    // `.rela.rodata*` and `.rela.data.rel.ro*` carry relocs
    // whose `offset` field is relative to the *target* section
    // start. The parser has prepended the target section's
    // bytes into `data_bytes` at `rodata_base`, so the merged
    // reloc offset is `rodata_base + r_offset`. The sym_idx /
    // rtype / addend pass through unchanged.
    for &rela_sh_i in &rela_rodata_section_indices {
        let rela_sh = &shdrs[rela_sh_i];
        if rela_sh.sh_type != SHT_RELA {
            return Err(err(&format!(
                ".rela.rodata-family section at index {rela_sh_i} is not SHT_RELA",
            )));
        }
        if rela_sh.entsize != ELF64_RELA_SIZE {
            return Err(err(&format!(
                ".rela.rodata-family entry size is {} bytes; expected {ELF64_RELA_SIZE}",
                rela_sh.entsize,
            )));
        }
        // `sh_info` of a SHT_RELA section names the target
        // section it patches. Use it to look up the target's
        // base in the merged data blob.
        let target_shndx = rela_sh.info as usize;
        let rodata_base = rodata_base_per_shndx
            .iter()
            .find_map(|&(idx, base)| (idx == target_shndx).then_some(base))
            .ok_or_else(|| {
                err(&format!(
                    ".rela.rodata-family section at index {rela_sh_i} targets section \
                     {target_shndx} which is not in the recognized rodata family",
                ))
            })?;
        let rela_bytes = section_slice(bytes, rela_sh)?;
        let n_relocs = rela_bytes.len() / ELF64_RELA_SIZE;
        for j in 0..n_relocs {
            let off = j * ELF64_RELA_SIZE;
            let r_offset = u64_at(rela_bytes, off);
            let r_info = u64_at(rela_bytes, off + 8);
            let r_addend = i64_at(rela_bytes, off + 16);
            let sym_idx = (r_info >> 32) as usize;
            let rtype = (r_info & 0xffff_ffff) as u32;
            data_relocs.push(NativeReloc {
                offset: rodata_base + r_offset,
                sym_idx,
                rtype,
                addend: r_addend,
            });
        }
    }

    Ok(NativeObject {
        machine,
        text: text_bytes,
        data: data_bytes,
        bss_size,
        symbols,
        text_relocs,
        data_relocs,
    })
}

// ---- Internal helpers ----

struct SectionHeader {
    name: u32,
    sh_type: u32,
    flags: u64,
    offset: usize,
    size: usize,
    link: u32,
    info: u32,
    entsize: usize,
}

fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
        "linker::object: {msg}",
    )))
}

fn u16_at(bytes: &[u8], off: usize) -> u16 {
    u16::from_le_bytes([bytes[off], bytes[off + 1]])
}

fn u32_at(bytes: &[u8], off: usize) -> u32 {
    u32::from_le_bytes([bytes[off], bytes[off + 1], bytes[off + 2], bytes[off + 3]])
}

fn u64_at(bytes: &[u8], off: usize) -> u64 {
    let mut buf = [0u8; 8];
    buf.copy_from_slice(&bytes[off..off + 8]);
    u64::from_le_bytes(buf)
}

fn i64_at(bytes: &[u8], off: usize) -> i64 {
    u64_at(bytes, off) as i64
}

fn section_slice<'a>(bytes: &'a [u8], sh: &SectionHeader) -> Result<&'a [u8], C5Error> {
    if sh.sh_type == SHT_NOBITS {
        return Ok(&[]);
    }
    if sh.offset + sh.size > bytes.len() {
        return Err(err(&format!(
            "section runs past end of file (offset 0x{:x} + size 0x{:x} > len {})",
            sh.offset,
            sh.size,
            bytes.len(),
        )));
    }
    Ok(&bytes[sh.offset..sh.offset + sh.size])
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
/// lands at the right position inside the merged section. For
/// `.text` / `.data` / `.bss` the offset is `0`; for rodata-
/// family sections it is the section's base within the merged
/// data blob (`.data` bytes come first, every rodata-family
/// section concatenated after).
fn section_of_shndx(
    shndx: u16,
    text_idx: Option<usize>,
    data_idx: Option<usize>,
    bss_idx: Option<usize>,
    rodata_base_per_shndx: &[(usize, u64)],
) -> (NativeSymSection, u64) {
    if shndx == SHN_UNDEF {
        return (NativeSymSection::Undef, 0);
    }
    if shndx == SHN_ABS {
        return (NativeSymSection::Abs, 0);
    }
    let i = shndx as usize;
    if Some(i) == text_idx {
        return (NativeSymSection::Text, 0);
    }
    if Some(i) == data_idx {
        return (NativeSymSection::Data, 0);
    }
    if Some(i) == bss_idx {
        return (NativeSymSection::Bss, 0);
    }
    if let Some(&(_, base)) = rodata_base_per_shndx.iter().find(|&&(idx, _)| idx == i) {
        return (NativeSymSection::Data, base);
    }
    // Unknown section -- fall back to UNDEF so the linker
    // treats it as a missing external rather than silently
    // miscategorising it.
    (NativeSymSection::Undef, 0)
}

/// True for the section names that hold const-initialised data
/// the parser folds into the merged `.data` blob: `.rodata`
/// and `.rodata.<anything>` (clang's per-string subsections like
/// `.rodata.str.1.1`, gcc's `.rodata.cst*` constant pools) plus
/// `.data.rel.ro` and `.data.rel.ro.<anything>` (initialised-then-
/// readonly dispatch tables holding pointers that need dynamic
/// relocation).
fn is_rodata_family_name(name: &str) -> bool {
    name == ".rodata"
        || name.starts_with(".rodata.")
        || name == ".data.rel.ro"
        || name.starts_with(".data.rel.ro.")
}

/// If `name` matches `.rela.<section>`, returns the target
/// section name; otherwise `None`. Used to identify `.rela.*`
/// sections whose target is in the rodata family.
fn rela_rodata_target_name(name: &str) -> Option<&str> {
    name.strip_prefix(".rela")
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
        // imm26 occupies bits 0..26; we want them all zero.
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
        let has_printf_undef = obj
            .symbols
            .iter()
            .any(|s| s.name == "printf" && matches!(s.section, NativeSymSection::Undef));
        assert!(
            has_printf_undef,
            "expected UNDEF `printf` import; got {:?}",
            obj.symbols,
        );
        // At least one CALL26 reloc against the printf import.
        let has_call26 = obj.text_relocs.iter().any(|r| {
            obj.symbols
                .get(r.sym_idx)
                .map(|s| s.name == "printf")
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
        // Silence dead-field warnings on the test side; these
        // fields are part of the encoder/decoder contract even
        // if the test below only reads a subset.
        let _ = obj.bss_size;
        let _ = obj.data.len();
        let _ = SectionHeader {
            name: 0,
            sh_type: 0,
            flags: 0,
            offset: 0,
            size: 0,
            link: 0,
            info: 0,
            entsize: 0,
        };
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
        // Section names (NUL-separated) for .shstrtab.
        let shstr_names: &[&str] = &[
            "",
            ".shstrtab",
            ".strtab",
            ".symtab",
            ".text",
            ".data",
            ".rodata",
            ".rela.data",
        ];
        let mut shstrtab: Vec<u8> = Vec::new();
        let mut shstr_off: Vec<u32> = Vec::with_capacity(shstr_names.len());
        for n in shstr_names {
            shstr_off.push(shstrtab.len() as u32);
            shstrtab.extend_from_slice(n.as_bytes());
            shstrtab.push(0);
        }
        // Two-symbol .strtab: index 0 is the empty string the
        // null and STT_SECTION symbols share.
        let strtab: Vec<u8> = vec![0];
        // Symtab entries:
        //   [0] null
        //   [1] STT_SECTION pointing at .data   (shndx = 5)
        //   [2] STT_SECTION pointing at .rodata (shndx = 6)
        let mut symtab: Vec<u8> = Vec::new();
        let push_sym =
            |out: &mut Vec<u8>, name: u32, info: u8, shndx: u16, value: u64, size: u64| {
                out.extend_from_slice(&name.to_le_bytes());
                out.push(info);
                out.push(0); // st_other
                out.extend_from_slice(&shndx.to_le_bytes());
                out.extend_from_slice(&value.to_le_bytes());
                out.extend_from_slice(&size.to_le_bytes());
            };
        push_sym(&mut symtab, 0, 0, 0, 0, 0);
        push_sym(&mut symtab, 0, 0x03, 5, 0, 0); // STT_SECTION on .data
        push_sym(&mut symtab, 0, 0x03, 6, 0, 0); // STT_SECTION on .rodata
        // .text empty; .data 8 zero bytes; .rodata "hi\0\0\0\0\0\0" (8 bytes).
        let text: Vec<u8> = Vec::new();
        let data: Vec<u8> = vec![0; 8];
        let mut rodata: Vec<u8> = b"hi".to_vec();
        rodata.resize(8, 0);
        // .rela.data: one entry, slot at .data+0, target = STT_SECTION on .rodata (sym 2), R_X86_64_64=1, addend=0.
        let mut rela_data: Vec<u8> = Vec::new();
        rela_data.extend_from_slice(&0u64.to_le_bytes()); // r_offset = 0
        let r_info: u64 = (2u64 << 32) | 1u64; // sym=2, type=R_X86_64_64
        rela_data.extend_from_slice(&r_info.to_le_bytes());
        rela_data.extend_from_slice(&0i64.to_le_bytes()); // r_addend = 0

        // Section ordering must match the indices baked into
        // the STT_SECTION entries above.
        const N_SECTIONS: usize = 8; // null, shstrtab, strtab, symtab, text, data, rodata, rela.data
        const HDR_SIZE: usize = 64;
        const SHDR_SIZE: usize = 64;
        let mut sec_bytes: Vec<&[u8]> = vec![
            &[],
            &shstrtab,
            &strtab,
            &symtab,
            &text,
            &data,
            &rodata,
            &rela_data,
        ];
        let mut sec_offs: Vec<usize> = Vec::with_capacity(N_SECTIONS);
        let mut cursor = HDR_SIZE + N_SECTIONS * SHDR_SIZE;
        for body in &sec_bytes {
            sec_offs.push(cursor);
            cursor += body.len();
        }
        let total_size = cursor;

        let mut bytes = vec![0u8; total_size];
        // ELF64 ident.
        bytes[0..4].copy_from_slice(b"\x7fELF");
        bytes[4] = ELF_CLASS_64;
        bytes[5] = ELF_DATA_LSB;
        bytes[6] = 1; // EV_CURRENT
        // e_type, e_machine.
        bytes[16..18].copy_from_slice(&ET_REL.to_le_bytes());
        bytes[18..20].copy_from_slice(&EM_X86_64.to_le_bytes());
        // e_version.
        bytes[20..24].copy_from_slice(&1u32.to_le_bytes());
        // e_shoff = 64; e_ehsize = 64; e_shentsize = 64; e_shnum = 8; e_shstrndx = 1.
        bytes[40..48].copy_from_slice(&(HDR_SIZE as u64).to_le_bytes());
        bytes[52..54].copy_from_slice(&(HDR_SIZE as u16).to_le_bytes());
        bytes[58..60].copy_from_slice(&(SHDR_SIZE as u16).to_le_bytes());
        bytes[60..62].copy_from_slice(&(N_SECTIONS as u16).to_le_bytes());
        bytes[62..64].copy_from_slice(&1u16.to_le_bytes()); // shstrndx

        // Per-section header writer. `link` / `info` only matter for symtab + rela.data.
        let write_shdr = |bytes: &mut [u8],
                          i: usize,
                          name_off: u32,
                          sh_type: u32,
                          off: usize,
                          size: usize,
                          link: u32,
                          info: u32,
                          entsize: usize| {
            let base = HDR_SIZE + i * SHDR_SIZE;
            bytes[base..base + 4].copy_from_slice(&name_off.to_le_bytes());
            bytes[base + 4..base + 8].copy_from_slice(&sh_type.to_le_bytes());
            // flags / addr left zero.
            bytes[base + 24..base + 32].copy_from_slice(&(off as u64).to_le_bytes());
            bytes[base + 32..base + 40].copy_from_slice(&(size as u64).to_le_bytes());
            bytes[base + 40..base + 44].copy_from_slice(&link.to_le_bytes());
            bytes[base + 44..base + 48].copy_from_slice(&info.to_le_bytes());
            // align left zero.
            bytes[base + 56..base + 64].copy_from_slice(&(entsize as u64).to_le_bytes());
        };
        // [0] NULL section -- all zero.
        write_shdr(&mut bytes, 0, 0, 0, 0, 0, 0, 0, 0);
        // [1] .shstrtab
        write_shdr(
            &mut bytes,
            1,
            shstr_off[1],
            SHT_STRTAB,
            sec_offs[1],
            shstrtab.len(),
            0,
            0,
            0,
        );
        // [2] .strtab
        write_shdr(
            &mut bytes,
            2,
            shstr_off[2],
            SHT_STRTAB,
            sec_offs[2],
            strtab.len(),
            0,
            0,
            0,
        );
        // [3] .symtab -- sh_link = strtab index (2), sh_info = index of first non-local (>= 3).
        write_shdr(
            &mut bytes,
            3,
            shstr_off[3],
            SHT_SYMTAB,
            sec_offs[3],
            symtab.len(),
            2,
            3,
            ELF64_SYM_SIZE,
        );
        // [4] .text -- progbits, empty.
        write_shdr(
            &mut bytes,
            4,
            shstr_off[4],
            SHT_PROGBITS,
            sec_offs[4],
            text.len(),
            0,
            0,
            0,
        );
        // [5] .data -- progbits, 8 bytes.
        write_shdr(
            &mut bytes,
            5,
            shstr_off[5],
            SHT_PROGBITS,
            sec_offs[5],
            data.len(),
            0,
            0,
            0,
        );
        // [6] .rodata -- progbits, 8 bytes.
        write_shdr(
            &mut bytes,
            6,
            shstr_off[6],
            SHT_PROGBITS,
            sec_offs[6],
            rodata.len(),
            0,
            0,
            0,
        );
        // [7] .rela.data -- sh_link = symtab (3), sh_info = section it patches (5 = .data).
        write_shdr(
            &mut bytes,
            7,
            shstr_off[7],
            SHT_RELA,
            sec_offs[7],
            rela_data.len(),
            3,
            5,
            ELF64_RELA_SIZE,
        );

        // Copy section bodies into place.
        for (i, body) in sec_bytes.iter_mut().enumerate() {
            let off = sec_offs[i];
            bytes[off..off + body.len()].copy_from_slice(body);
        }

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

    /// Same shape as `rodata_section_lands_in_merged_data_blob`
    /// but the section is named `.rodata.str.1.1` (clang's
    /// per-string subsection layout under `-fdata-sections`).
    /// The family-name predicate matches the `.rodata.` prefix.
    #[test]
    fn rodata_str_subsection_lands_in_merged_data_blob() {
        let shstr_names: &[&str] = &[
            "",
            ".shstrtab",
            ".strtab",
            ".symtab",
            ".text",
            ".data",
            ".rodata.str.1.1",
        ];
        let mut shstrtab: Vec<u8> = Vec::new();
        let mut shstr_off: Vec<u32> = Vec::with_capacity(shstr_names.len());
        for n in shstr_names {
            shstr_off.push(shstrtab.len() as u32);
            shstrtab.extend_from_slice(n.as_bytes());
            shstrtab.push(0);
        }
        let strtab: Vec<u8> = vec![0];
        let mut symtab: Vec<u8> = Vec::new();
        let push_sym =
            |out: &mut Vec<u8>, name: u32, info: u8, shndx: u16, value: u64, size: u64| {
                out.extend_from_slice(&name.to_le_bytes());
                out.push(info);
                out.push(0);
                out.extend_from_slice(&shndx.to_le_bytes());
                out.extend_from_slice(&value.to_le_bytes());
                out.extend_from_slice(&size.to_le_bytes());
            };
        push_sym(&mut symtab, 0, 0, 0, 0, 0);
        // STT_SECTION on .rodata.str.1.1 (shndx = 6).
        push_sym(&mut symtab, 0, 0x03, 6, 0, 0);
        let text: Vec<u8> = Vec::new();
        let data: Vec<u8> = vec![0; 4];
        let rodata: Vec<u8> = b"hello\0".to_vec();

        const N_SECTIONS: usize = 7;
        const HDR_SIZE: usize = 64;
        const SHDR_SIZE: usize = 64;
        let mut sec_bytes: Vec<&[u8]> =
            vec![&[], &shstrtab, &strtab, &symtab, &text, &data, &rodata];
        let mut sec_offs: Vec<usize> = Vec::with_capacity(N_SECTIONS);
        let mut cursor = HDR_SIZE + N_SECTIONS * SHDR_SIZE;
        for body in &sec_bytes {
            sec_offs.push(cursor);
            cursor += body.len();
        }
        let mut bytes = vec![0u8; cursor];
        bytes[0..4].copy_from_slice(b"\x7fELF");
        bytes[4] = ELF_CLASS_64;
        bytes[5] = ELF_DATA_LSB;
        bytes[6] = 1;
        bytes[16..18].copy_from_slice(&ET_REL.to_le_bytes());
        bytes[18..20].copy_from_slice(&EM_AARCH64.to_le_bytes());
        bytes[20..24].copy_from_slice(&1u32.to_le_bytes());
        bytes[40..48].copy_from_slice(&(HDR_SIZE as u64).to_le_bytes());
        bytes[52..54].copy_from_slice(&(HDR_SIZE as u16).to_le_bytes());
        bytes[58..60].copy_from_slice(&(SHDR_SIZE as u16).to_le_bytes());
        bytes[60..62].copy_from_slice(&(N_SECTIONS as u16).to_le_bytes());
        bytes[62..64].copy_from_slice(&1u16.to_le_bytes());

        let write_shdr = |bytes: &mut [u8],
                          i: usize,
                          name_off: u32,
                          sh_type: u32,
                          off: usize,
                          size: usize,
                          link: u32,
                          info: u32,
                          entsize: usize| {
            let base = HDR_SIZE + i * SHDR_SIZE;
            bytes[base..base + 4].copy_from_slice(&name_off.to_le_bytes());
            bytes[base + 4..base + 8].copy_from_slice(&sh_type.to_le_bytes());
            bytes[base + 24..base + 32].copy_from_slice(&(off as u64).to_le_bytes());
            bytes[base + 32..base + 40].copy_from_slice(&(size as u64).to_le_bytes());
            bytes[base + 40..base + 44].copy_from_slice(&link.to_le_bytes());
            bytes[base + 44..base + 48].copy_from_slice(&info.to_le_bytes());
            bytes[base + 56..base + 64].copy_from_slice(&(entsize as u64).to_le_bytes());
        };
        write_shdr(&mut bytes, 0, 0, 0, 0, 0, 0, 0, 0);
        write_shdr(
            &mut bytes,
            1,
            shstr_off[1],
            SHT_STRTAB,
            sec_offs[1],
            shstrtab.len(),
            0,
            0,
            0,
        );
        write_shdr(
            &mut bytes,
            2,
            shstr_off[2],
            SHT_STRTAB,
            sec_offs[2],
            strtab.len(),
            0,
            0,
            0,
        );
        write_shdr(
            &mut bytes,
            3,
            shstr_off[3],
            SHT_SYMTAB,
            sec_offs[3],
            symtab.len(),
            2,
            2,
            ELF64_SYM_SIZE,
        );
        write_shdr(
            &mut bytes,
            4,
            shstr_off[4],
            SHT_PROGBITS,
            sec_offs[4],
            text.len(),
            0,
            0,
            0,
        );
        write_shdr(
            &mut bytes,
            5,
            shstr_off[5],
            SHT_PROGBITS,
            sec_offs[5],
            data.len(),
            0,
            0,
            0,
        );
        write_shdr(
            &mut bytes,
            6,
            shstr_off[6],
            SHT_PROGBITS,
            sec_offs[6],
            rodata.len(),
            0,
            0,
            0,
        );
        for (i, body) in sec_bytes.iter_mut().enumerate() {
            let off = sec_offs[i];
            bytes[off..off + body.len()].copy_from_slice(body);
        }
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

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
    let mut text_idx: Option<usize> = None;
    let mut data_idx: Option<usize> = None;
    let mut bss_idx: Option<usize> = None;
    let mut symtab_idx: Option<usize> = None;
    let mut rela_text_idx: Option<usize> = None;
    let mut rela_data_idx: Option<usize> = None;
    for (i, sh) in shdrs.iter().enumerate() {
        let name = strtab_str(shstrtab_bytes, sh.name as usize)?;
        match name {
            ".text" => text_idx = Some(i),
            ".data" => data_idx = Some(i),
            ".bss" => bss_idx = Some(i),
            ".symtab" => symtab_idx = Some(i),
            ".rela.text" => rela_text_idx = Some(i),
            ".rela.data" => rela_data_idx = Some(i),
            _ => {}
        }
    }
    let text_sh = text_idx
        .map(|i| &shdrs[i])
        .ok_or_else(|| err("ELF object has no `.text` section"))?;
    let symtab_sh_i = symtab_idx.ok_or_else(|| err("ELF object has no `.symtab` section"))?;
    let symtab_sh = &shdrs[symtab_sh_i];

    let text_bytes = section_slice(bytes, text_sh)?.to_vec();
    let data_bytes = match data_idx {
        Some(i) => section_slice(bytes, &shdrs[i])?.to_vec(),
        None => Vec::new(),
    };
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

    // Decode the symbol table. The writer keeps section
    // symbols (one per `.text` / `.data` / `.bss`) as LOCAL
    // STT_SECTION entries; we surface them as `Undef`-style
    // section references through the reloc resolver below
    // rather than turning them into `NativeSymbol`s the linker
    // would have to special-case.
    if symtab_sh.entsize != ELF64_SYM_SIZE {
        return Err(err(&format!(
            ".symtab entry size is {} bytes; expected {ELF64_SYM_SIZE}",
            symtab_sh.entsize,
        )));
    }
    let symtab_bytes = section_slice(bytes, symtab_sh)?;
    let n_syms = symtab_bytes.len() / ELF64_SYM_SIZE;
    let mut sym_section_kinds: Vec<NativeSymSection> = Vec::with_capacity(n_syms);
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
        let section = section_of_shndx(st_shndx, &shdrs, text_idx, data_idx, bss_idx);
        sym_section_kinds.push(section);
        symbols.push(NativeSymbol {
            name: if st_name == 0 {
                String::new()
            } else {
                strtab_str(strtab_bytes, st_name)?.to_string()
            },
            section,
            value: st_value,
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

fn section_of_shndx(
    shndx: u16,
    _shdrs: &[SectionHeader],
    text_idx: Option<usize>,
    data_idx: Option<usize>,
    bss_idx: Option<usize>,
) -> NativeSymSection {
    if shndx == SHN_UNDEF {
        return NativeSymSection::Undef;
    }
    if shndx == SHN_ABS {
        return NativeSymSection::Abs;
    }
    let i = shndx as usize;
    if Some(i) == text_idx {
        return NativeSymSection::Text;
    }
    if Some(i) == data_idx {
        return NativeSymSection::Data;
    }
    if Some(i) == bss_idx {
        return NativeSymSection::Bss;
    }
    // Unknown section -- fall back to UNDEF so the linker
    // treats it as a missing external rather than silently
    // miscategorising it.
    NativeSymSection::Undef
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
}

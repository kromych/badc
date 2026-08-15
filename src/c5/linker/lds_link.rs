//! Script-driven native link: consumes a parsed linker script
//! (`lds.rs`) plus ELF64 ET_REL inputs read at full fidelity (every
//! section with its own bytes, flags, and relocations), lays output
//! sections out exactly as the script directs, and writes the final
//! ELF image.
//!
//! Kept apart from the default `link.rs` path: that path merges
//! family streams at fixed addresses and stays byte-identical when no
//! script is given. Here relocations are applied only after the
//! script assigns every input section its final address.
//!
//! Layout runs the statement walk repeatedly until section addresses
//! and symbol values stop changing, which is how forward references
//! (`kimage_limit` used before its assignment) and self-referential
//! sizing (RELR content depends on final addresses) resolve; GNU ld's
//! relaxation passes serve the same purpose. Diagnostics (ASSERT,
//! undefined symbols, backwards dot moves) fire only on the final
//! pass, when values are settled.

#![cfg(feature = "std")]
#![allow(dead_code)]

use alloc::borrow::ToOwned;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};
/// Per-member `(input offsets, pooled offsets)` produced by pool builders.
type PoolMemberMaps = HashMap<usize, (Vec<u64>, Vec<u64>)>;

use crate::c5::error::C5Error;

use super::comdat::{self, SecId};
use super::dynamic::{self, DynSym, DynTables, HashStyle, VerDef};
use super::eh_frame;
use super::gnu_property;
use super::lds::{
    AssignOp, Assignment, BinOp, Command, DataWidth, Expr, InputSpec, LinkerScript, OutputSection,
    OutputSectionType, SectionContent, SectionsItem, SortKind, UnOp, glob_match,
};
use super::object::{
    Elf32Ehdr, Elf32Rel, Elf32Rela, Elf32Shdr, Elf32Sym, Elf64Ehdr, Elf64Rel, Elf64Shdr, ElfClass,
    SharedLibrary, absolute_in_pie_body, elf_reloc_desc, is_c_identifier, locate_reloc,
    read_struct,
};
use crate::c5::object::elf_reloc_types as rt;

fn err(msg: &str) -> C5Error {
    C5Error::Compile(format!("error: {msg}"))
}

// ELF constants.
const SHT_PROGBITS: u32 = 1;
const SHT_SYMTAB: u32 = 2;
const SHT_STRTAB: u32 = 3;
const SHT_RELA: u32 = 4;
/// `R_*_NONE`: recorded under `--emit-relocs`, applies nothing.
const R_NONE: u32 = 0;
const SHT_NOTE: u32 = 7;
const SHT_NOBITS: u32 = 8;
const SHT_REL: u32 = 9;
const SHT_INIT_ARRAY: u32 = 14;
const SHT_FINI_ARRAY: u32 = 15;
const SHT_PREINIT_ARRAY: u32 = 16;
const SHT_GROUP: u32 = 17;
const SHT_SYMTAB_SHNDX: u32 = 18;
const SHT_RELR: u32 = 19;
const SHT_LLVM_ADDRSIG: u32 = 0x6fff4c03;

const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;
const SHF_MERGE: u64 = 0x10;
const SHF_STRINGS: u64 = 0x20;
const SHF_INFO_LINK: u64 = 0x40;
const SHF_LINK_ORDER: u64 = 0x80;
const SHF_GROUP: u64 = 0x200;
const SHF_TLS: u64 = 0x400;
const SHF_COMPRESSED: u64 = 0x800;
const SHF_EXCLUDE: u64 = 0x8000_0000;
const SHF_GNU_RETAIN: u64 = 0x0020_0000;

const SHN_UNDEF: u16 = 0;
const SHN_LORESERVE: u16 = 0xff00;
const SHN_ABS: u16 = 0xfff1;
const SHN_COMMON: u16 = 0xfff2;
const SHN_XINDEX: u16 = 0xffff;

const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STB_WEAK: u8 = 2;
const STT_NOTYPE: u8 = 0;
const STT_OBJECT: u8 = 1;
const STT_FUNC: u8 = 2;
const STT_SECTION: u8 = 3;
const STT_FILE: u8 = 4;
const STT_COMMON: u8 = 5;
const STV_DEFAULT: u8 = 0;
const STV_HIDDEN: u8 = 2;
const STV_PROTECTED: u8 = 3;

const PT_LOAD: u32 = 1;
const PT_DYNAMIC: u32 = 2;
const PT_INTERP: u32 = 3;
const PT_PHDR: u32 = 6;
const PT_NOTE: u32 = 4;
const PT_GNU_EH_FRAME: u32 = 0x6474e550;
const PT_GNU_STACK: u32 = 0x6474e551;
const PT_GNU_PROPERTY: u32 = 0x6474e553;
const PF_X: u32 = 1;
const PF_W: u32 = 2;
const PF_R: u32 = 4;

const ET_EXEC: u16 = 2;
const ET_DYN: u16 = 3;
const EM_386: u16 = 3;
const EM_X86_64: u16 = 62;
const EM_AARCH64: u16 = 183;

/// ELF class an emulation's machine is linked at. Only i386 among the
/// machines badc targets is ELF32.
fn class_for_machine(machine: u16) -> ElfClass {
    match machine {
        EM_386 => ElfClass::Elf32,
        _ => ElfClass::Elf64,
    }
}

/// True where the target's default relocation format carries an
/// explicit addend (`SHT_RELA`). i386 uses `SHT_REL`.
fn machine_uses_rela(machine: u16) -> bool {
    machine != EM_386
}

#[repr(C)]
#[derive(Clone, Copy, Default)]
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

#[repr(C)]
#[derive(Clone, Copy)]
struct Elf64Sym {
    st_name: u32,
    st_info: u8,
    st_other: u8,
    st_shndx: u16,
    st_value: u64,
    st_size: u64,
}

#[repr(C)]
#[derive(Clone, Copy)]
struct Elf64Rela {
    r_offset: u64,
    r_info: u64,
    r_addend: i64,
}

/// bfd's orphan buckets, in layout order: code, read-only data,
/// writable data, `.bss`, then everything unallocated.
fn orphan_class(flags: u64, shtype: u32) -> u32 {
    if flags & SHF_ALLOC == 0 {
        4
    } else if flags & SHF_EXECINSTR != 0 {
        0
    } else if shtype == SHT_NOBITS {
        3
    } else if flags & SHF_WRITE == 0 {
        1
    } else {
        2
    }
}

/// The output section each orphan class anchors on when the script
/// names one; otherwise the last compatible section takes the orphan.
const ORPHAN_ANCHOR_NAMES: [Option<&str>; 5] = [
    Some(".text"),
    Some(".rodata"),
    Some(".data"),
    Some(".bss"),
    None,
];

fn align_up(v: u64, align: u64) -> u64 {
    if align <= 1 {
        return v;
    }
    v.wrapping_add(align - 1) & !(align - 1)
}

// ------------------------------------------------------------- inputs

/// One relocation, as read from a `.rela.<sec>` table.
#[derive(Debug, Clone, Copy)]
pub struct RawReloc {
    pub offset: u64,
    pub sym: u32,
    pub rtype: u32,
    pub addend: i64,
}

/// One symbol table entry, verbatim.
#[derive(Debug, Clone)]
pub struct RawSym {
    pub name: String,
    pub info: u8,
    pub other: u8,
    pub shndx: u32,
    pub value: u64,
    pub size: u64,
}

impl RawSym {
    fn binding(&self) -> u8 {
        self.info >> 4
    }
    fn kind(&self) -> u8 {
        self.info & 0xf
    }
}

/// One input section with its own identity preserved.
#[derive(Debug, Clone)]
pub struct RawSection {
    pub name: String,
    pub shtype: u32,
    pub flags: u64,
    pub addralign: u64,
    pub entsize: u64,
    /// Byte range within the owning object's file image; empty for
    /// SHT_NOBITS.
    pub data_off: usize,
    pub size: u64,
    pub relocs: Vec<RawReloc>,
    pub orig_shndx: u32,
    /// `sh_link`: for an `SHF_LINK_ORDER` section, the section whose
    /// output placement orders this one.
    pub link: u32,
}

/// One `SHT_GROUP` section: the flag word, the signature symbol's
/// name, and the members that survived the section filter.
#[derive(Debug, Clone)]
pub struct RawGroup {
    pub flags: u32,
    pub signature: String,
    /// Members as indices into [`LdsObject::sections`].
    pub members: Vec<usize>,
}

/// One ET_REL input at full fidelity.
pub struct LdsObject {
    pub source: String,
    pub bytes: Vec<u8>,
    pub machine: u16,
    pub class: ElfClass,
    pub sections: Vec<RawSection>,
    pub symbols: Vec<RawSym>,
    pub groups: Vec<RawGroup>,
    /// Original section header index -> `sections` index.
    pub shndx_map: HashMap<u32, usize>,
}

impl LdsObject {
    fn section_data(&self, s: &RawSection) -> &[u8] {
        if s.shtype == SHT_NOBITS {
            return &[];
        }
        &self.bytes[s.data_off..s.data_off + s.size as usize]
    }
}

/// Parse a little-endian ET_REL object of either ELF class preserving
/// every section. Symbol/string/reloc/group tables are consumed into
/// structured form; addrsig metadata is dropped.
pub fn parse_lds_object(source: &str, bytes: Vec<u8>) -> Result<LdsObject, C5Error> {
    if bytes.len() < 52 || &bytes[0..4] != b"\x7fELF" {
        return Err(err(&format!("{source}: not an ELF object")));
    }
    let Some(class) = ElfClass::from_ei_class(bytes[4]).filter(|_| bytes[5] == 1) else {
        return Err(err(&format!("{source}: not a little-endian ELF object")));
    };
    let read_shdr = |off: usize| -> Result<Elf64Shdr, C5Error> {
        match class {
            ElfClass::Elf32 => read_struct::<Elf32Shdr>(&bytes, off).map(Into::into),
            ElfClass::Elf64 => read_struct::<Elf64Shdr>(&bytes, off),
        }
    };
    let ehdr: Elf64Ehdr = match class {
        ElfClass::Elf32 => read_struct::<Elf32Ehdr>(&bytes, 0)?.into(),
        ElfClass::Elf64 => read_struct::<Elf64Ehdr>(&bytes, 0)?,
    };
    if ehdr.e_type != 1 {
        return Err(err(&format!(
            "{source}: not a relocatable object (e_type {})",
            ehdr.e_type
        )));
    }
    let shdr_size = class.shdr_size() as usize;
    let shoff = ehdr.e_shoff as usize;
    let mut shnum = ehdr.e_shnum as usize;
    // Extended section count: e_shnum 0 stores the real count in
    // section header 0's sh_size.
    if shnum == 0 && shoff != 0 {
        shnum = read_shdr(shoff)?.sh_size as usize;
    }
    let mut shdrs: Vec<Elf64Shdr> = Vec::with_capacity(shnum);
    for i in 0..shnum {
        shdrs.push(read_shdr(shoff + i * shdr_size)?);
    }
    let mut shstrndx = ehdr.e_shstrndx as usize;
    if shstrndx == SHN_XINDEX as usize {
        shstrndx = shdrs[0].sh_link as usize;
    }
    let shstr = section_bytes(&bytes, shdrs.get(shstrndx), source)?;
    let sec_name = |sh: &Elf64Shdr| -> String { strz(shstr, sh.sh_name as usize) };

    // Symbol table (at most one in ET_REL).
    let mut symbols: Vec<RawSym> = Vec::new();
    let mut symtab_idx: Option<usize> = None;
    let mut shndx_ext: Vec<u32> = Vec::new();
    for (i, sh) in shdrs.iter().enumerate() {
        if sh.sh_type == SHT_SYMTAB_SHNDX {
            let raw = section_bytes(&bytes, Some(sh), source)?;
            shndx_ext = raw
                .chunks_exact(4)
                .map(|c| u32::from_le_bytes([c[0], c[1], c[2], c[3]]))
                .collect();
        }
        if sh.sh_type == SHT_SYMTAB {
            symtab_idx = Some(i);
        }
    }
    if let Some(si) = symtab_idx {
        let sh = &shdrs[si];
        let strtab = section_bytes(&bytes, shdrs.get(sh.sh_link as usize), source)?;
        let raw = section_bytes(&bytes, Some(sh), source)?;
        let sym_size = class.sym_size() as usize;
        let count = raw.len() / sym_size;
        symbols.reserve(count);
        for k in 0..count {
            let sym: Elf64Sym = match class {
                ElfClass::Elf32 => {
                    let s: Elf32Sym = read_struct(raw, k * sym_size)?;
                    Elf64Sym {
                        st_name: s.st_name,
                        st_info: s.st_info,
                        st_other: s.st_other,
                        st_shndx: s.st_shndx,
                        st_value: s.st_value as u64,
                        st_size: s.st_size as u64,
                    }
                }
                ElfClass::Elf64 => read_struct(raw, k * sym_size)?,
            };
            let shndx = if sym.st_shndx == SHN_XINDEX {
                shndx_ext.get(k).copied().unwrap_or(0)
            } else {
                sym.st_shndx as u32
            };
            symbols.push(RawSym {
                name: strz(strtab, sym.st_name as usize),
                info: sym.st_info,
                other: sym.st_other,
                shndx,
                value: sym.st_value,
                size: sym.st_size,
            });
        }
    }

    // Content sections. Metadata section types are consumed or
    // dropped, never placed.
    let mut sections: Vec<RawSection> = Vec::new();
    let mut shndx_map: HashMap<u32, usize> = HashMap::new();
    for (i, sh) in shdrs.iter().enumerate() {
        if i == 0 {
            continue;
        }
        match sh.sh_type {
            SHT_SYMTAB | SHT_STRTAB | SHT_RELA | SHT_REL | SHT_GROUP | SHT_SYMTAB_SHNDX
            | SHT_LLVM_ADDRSIG => continue,
            _ => {}
        }
        if sh.sh_flags & SHF_EXCLUDE != 0 && sh.sh_flags & SHF_ALLOC == 0 {
            continue;
        }
        let data_off = if sh.sh_type == SHT_NOBITS {
            0
        } else {
            let end = (sh.sh_offset as usize).checked_add(sh.sh_size as usize);
            match end {
                Some(e) if e <= bytes.len() => sh.sh_offset as usize,
                _ => {
                    return Err(err(&format!(
                        "{source}: section {} extends past end of file",
                        sec_name(sh)
                    )));
                }
            }
        };
        shndx_map.insert(i as u32, sections.len());
        sections.push(RawSection {
            name: sec_name(sh),
            shtype: sh.sh_type,
            flags: sh.sh_flags,
            addralign: sh.sh_addralign.max(1),
            entsize: sh.sh_entsize,
            data_off,
            size: sh.sh_size,
            relocs: Vec::new(),
            orig_shndx: i as u32,
            link: sh.sh_link,
        });
    }
    // Attach relocation tables to their sections via sh_info. SHT_REL
    // carries no addend field: it lives in the target bytes, so it is
    // read out here and the entry becomes RELA-shaped for the engine.
    for sh in &shdrs {
        if sh.sh_type != SHT_RELA && sh.sh_type != SHT_REL {
            continue;
        }
        let Some(&target) = shndx_map.get(&sh.sh_info) else {
            continue;
        };
        let raw = section_bytes(&bytes, Some(sh), source)?;
        let rel = sh.sh_type == SHT_REL;
        let ent = if rel {
            class.rel_size() as usize
        } else {
            class.rela_size() as usize
        };
        let count = raw.len() / ent;
        let mut list: Vec<RawReloc> = Vec::with_capacity(count);
        for k in 0..count {
            let (r_offset, r_info, r_addend) = match (class, rel) {
                (ElfClass::Elf32, true) => {
                    let re: Elf32Rel = read_struct(raw, k * ent)?;
                    (re.r_offset as u64, re.r_info as u64, 0)
                }
                (ElfClass::Elf32, false) => {
                    let re: Elf32Rela = read_struct(raw, k * ent)?;
                    (re.r_offset as u64, re.r_info as u64, re.r_addend as i64)
                }
                (ElfClass::Elf64, true) => {
                    let re: Elf64Rel = read_struct(raw, k * ent)?;
                    (re.r_offset, re.r_info, 0)
                }
                (ElfClass::Elf64, false) => {
                    let re: Elf64Rela = read_struct(raw, k * ent)?;
                    (re.r_offset, re.r_info, re.r_addend)
                }
            };
            let rtype = class.reloc_type(r_info);
            let addend = if rel {
                implicit_addend(
                    &bytes,
                    &sections[target],
                    ehdr.e_machine,
                    rtype,
                    r_offset,
                    source,
                )?
            } else {
                r_addend
            };
            list.push(RawReloc {
                offset: r_offset,
                sym: class.reloc_sym(r_info),
                rtype,
                addend,
            });
        }
        sections[target].relocs.extend(list);
    }
    // Section groups. The body is a flag word followed by member
    // section indices; entries naming a section the filter above
    // dropped (a group's own relocation table) have no member.
    let mut groups: Vec<RawGroup> = Vec::new();
    for sh in &shdrs {
        if sh.sh_type != SHT_GROUP {
            continue;
        }
        let raw = section_bytes(&bytes, Some(sh), source)?;
        if raw.len() < 4 || raw.len() % 4 != 0 {
            return Err(err(&format!("{source}: malformed SHT_GROUP body")));
        }
        let word = |i: usize| u32::from_le_bytes(raw[i..i + 4].try_into().unwrap());
        let signature = symbols
            .get(sh.sh_info as usize)
            .map(|s| s.name.clone())
            .unwrap_or_default();
        let members: Vec<usize> = (1..raw.len() / 4)
            .filter_map(|i| shndx_map.get(&word(i * 4)).copied())
            .collect();
        groups.push(RawGroup {
            flags: word(0),
            signature,
            members,
        });
    }
    Ok(LdsObject {
        source: source.to_string(),
        bytes,
        machine: ehdr.e_machine,
        class,
        sections,
        symbols,
        groups,
        shndx_map,
    })
}

/// The addend an `SHT_REL` entry keeps in the field it relocates,
/// sign-extended from the field's width. A type that touches no field
/// (`R_*_NONE`) has none.
fn implicit_addend(
    bytes: &[u8],
    sec: &RawSection,
    machine: u16,
    rtype: u32,
    offset: u64,
    source: &str,
) -> Result<i64, C5Error> {
    if rtype == R_NONE {
        return Ok(0);
    }
    let width = match machine {
        EM_386 => rt::i386_field_width(rtype),
        _ => None,
    };
    let Some(width) = width else {
        return Err(err(&format!(
            "{source}: {} in `{}' has no implicit-addend field",
            elf_reloc_desc(machine, rtype),
            sec.name
        )));
    };
    let end = offset + width as u64;
    if sec.shtype == SHT_NOBITS || end > sec.size {
        return Err(err(&format!(
            "{source}: relocation offset 0x{offset:x} outside `{}'",
            sec.name
        )));
    }
    let at = sec.data_off + offset as usize;
    let raw = &bytes[at..at + width as usize];
    Ok(match width {
        1 => raw[0] as i8 as i64,
        2 => i16::from_le_bytes([raw[0], raw[1]]) as i64,
        _ => i32::from_le_bytes([raw[0], raw[1], raw[2], raw[3]]) as i64,
    })
}

/// A relocation writing a whole load address into a field narrower
/// than an address. `size_dynamic_sections` rewrites the address-width
/// form to `R_*_RELATIVE`; no dynamic form writes a narrower field.
/// The `*_ABS_LO12_NC` group is excluded: it takes only the target's
/// page offset, which a page-aligned load base leaves alone.
fn narrow_absolute(machine: u16, rtype: u32) -> bool {
    match machine {
        EM_386 => matches!(rtype, rt::R_386_16 | rt::R_386_8),
        EM_AARCH64 => {
            matches!(rtype, rt::R_AARCH64_ABS32 | rt::R_AARCH64_ABS16)
                || rt::aarch64_movw_field(rtype).is_some()
        }
        _ => matches!(
            rtype,
            rt::R_X86_64_32 | rt::R_X86_64_32S | rt::R_X86_64_16 | rt::R_X86_64_8
        ),
    }
}

fn section_bytes<'a>(
    bytes: &'a [u8],
    sh: Option<&Elf64Shdr>,
    source: &str,
) -> Result<&'a [u8], C5Error> {
    let sh = sh.ok_or_else(|| err(&format!("{source}: missing section header")))?;
    if sh.sh_type == SHT_NOBITS {
        return Ok(&[]);
    }
    let start = sh.sh_offset as usize;
    let end = start
        .checked_add(sh.sh_size as usize)
        .filter(|&e| e <= bytes.len())
        .ok_or_else(|| err(&format!("{source}: section extends past end of file")))?;
    Ok(&bytes[start..end])
}

fn strz(tab: &[u8], off: usize) -> String {
    if off >= tab.len() {
        return String::new();
    }
    let end = tab[off..]
        .iter()
        .position(|&b| b == 0)
        .map(|p| off + p)
        .unwrap_or(tab.len());
    String::from_utf8_lossy(&tab[off..end]).into_owned()
}

// ------------------------------------------------------------ options

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum OrphanHandling {
    Place,
    Warn,
    Error,
    Discard,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum LdsEmit {
    Exec,
    Dyn,
}

/// A shared library input and how the link named it.
#[derive(Debug, Clone)]
pub struct SharedInput {
    pub lib: SharedLibrary,
    /// Named under a linker script's `AS_NEEDED`: it takes a dependency
    /// record only where the link binds to it.
    pub as_needed: bool,
}

#[derive(Debug, Clone)]
pub struct LdsOptions {
    pub emit: LdsEmit,
    /// `-shared` rather than `-pie`. Both emit `ET_DYN`; the two
    /// differ in the output kind a diagnostic names.
    pub shared: bool,
    pub entry_override: Option<String>,
    pub max_page_size: u64,
    pub orphan_handling: OrphanHandling,
    pub build_id_sha1: bool,
    pub strip_debug: bool,
    /// `-X`: drop compiler-temporary local symbols (`.L*`).
    pub discard_locals: bool,
    /// `--discard-none`: keep every local symbol.
    pub discard_none: bool,
    /// `-z pack-relative-relocs`: RELR-pack aligned relative entries.
    pub pack_relative_relocs: bool,
    /// `--no-apply-dynamic-relocs` clears this: RELA-covered slots
    /// keep their input bytes. RELR-covered slots always get the
    /// link-time value (the format stores the addend in place).
    pub apply_dynamic_relocs: bool,
    /// `--emit-relocs`: carry every applied input relocation into the
    /// output as `.rela.<outsec>` entries against the output symtab.
    pub emit_relocs: bool,
    pub emit_warnings: bool,
    /// `-soname`: recorded as `DT_SONAME`.
    pub soname: Option<String>,
    /// Output file base name. Names the base version definition where
    /// no soname was given, as bfd's does.
    pub output_name: String,
    /// `--hash-style`.
    pub hash_style: HashStyle,
    /// `-Bsymbolic`: `DT_SYMBOLIC` and `DF_SYMBOLIC`.
    pub symbolic: bool,
    /// `-n` / `--nmagic`: a `PT_LOAD` aligns to the strongest
    /// alignment among its sections rather than to a page.
    pub nmagic: bool,
    /// `--eh-frame-hdr`: build the unwinder's FDE search table.
    pub eh_frame_hdr: bool,
    /// `--gc-sections`: drop every allocatable input section no kept
    /// section reaches.
    pub gc_sections: bool,
    /// `-u` / `--undefined`: names the link must resolve. Each is a
    /// garbage-collection root.
    pub undefined: Vec<String>,
    /// `--dynamic-linker`: the `PT_INTERP` program interpreter.
    pub interp: Option<String>,
    /// Shared libraries named on the command line, in order. Each takes
    /// a `DT_NEEDED` and satisfies references its exports name.
    pub shared_libs: Vec<SharedInput>,
    /// `-rpath`: the library search path recorded in the image.
    pub rpath: Vec<String>,
    /// `--enable-new-dtags`: record the search path as `DT_RUNPATH`.
    pub new_dtags: bool,
}

impl Default for LdsOptions {
    fn default() -> Self {
        LdsOptions {
            emit: LdsEmit::Exec,
            shared: false,
            entry_override: None,
            max_page_size: 0x1000,
            orphan_handling: OrphanHandling::Place,
            build_id_sha1: false,
            strip_debug: false,
            discard_locals: false,
            discard_none: false,
            pack_relative_relocs: false,
            apply_dynamic_relocs: true,
            emit_relocs: false,
            emit_warnings: true,
            soname: None,
            output_name: String::new(),
            hash_style: HashStyle::default(),
            symbolic: false,
            nmagic: false,
            eh_frame_hdr: false,
            gc_sections: false,
            undefined: Vec::new(),
            interp: None,
            shared_libs: Vec::new(),
            rpath: Vec::new(),
            new_dtags: false,
        }
    }
}

// ------------------------------------------------------------- engine

/// Where an input section ended up.
#[derive(Debug, Clone, Copy, PartialEq)]
enum SecFate {
    /// Not yet claimed by any spec.
    Unclaimed,
    /// Claimed by output section `out` (index into `outs`).
    Placed {
        out: usize,
    },
    Discarded,
}

#[derive(Debug, Clone, Copy)]
struct InSecId {
    obj: usize,
    sec: usize,
}

/// A content element of an output section, in statement order.
#[derive(Debug, Clone)]
enum Piece {
    /// The claimed input sections of one spec, in claim order
    /// (indices into `insecs`).
    Inputs(Vec<usize>),
    Data(DataWidth, Expr),
    Assign(Assignment),
    Assert(Expr, String),
    Fill(Expr),
}

/// Output section under construction.
struct OutSec {
    name: String,
    address: Option<Expr>,
    stype: Option<OutputSectionType>,
    at: Option<Expr>,
    align_attr: Option<Expr>,
    pieces: Vec<Piece>,
    phdrs: Vec<String>,
    fill: Option<Expr>,
    /// Created by orphan placement rather than named by the script.
    orphan: bool,
    // Computed per pass:
    addr: u64,
    lma: u64,
    size: u64,
    align: u64,
    flags: u64,
    shtype: u32,
    entsize: u64,
    alloc: bool,
    removed: bool,
    file_bytes: bool,
    /// Fixed byte layout of the section body: (offset, length,
    /// source), rebuilt each pass.
    chunks: Vec<(u64, u64, ChunkSrc)>,
}

#[derive(Debug, Clone)]
enum ChunkSrc {
    Input(usize),
    Bytes(Vec<u8>),
    /// Fill pattern applied over the range.
    Pad(Vec<u8>),
}

/// Attachment of an expression value / symbol. A plain number and an
/// address taken from the location counter outside any output section
/// are both absolute in expressions, but only the latter picks up a
/// symtab section through section_for_dot (ld's rel_from_abs).
#[derive(Debug, Clone, Copy, PartialEq)]
enum Att {
    Abs,
    DotAbs,
    Out(usize),
}

#[derive(Debug, Clone, Copy)]
struct Val {
    v: u64,
    att: Att,
}

impl Val {
    fn abs(v: u64) -> Val {
        Val { v, att: Att::Abs }
    }

    /// Value an expression naming the symbol that holds it sees. Only
    /// the definition taken from the location counter picks up a
    /// section for its own symtab entry, so what it hands on is a
    /// number (bfd's rel_from_abs).
    fn as_reference(self) -> Val {
        match self.att {
            Att::DotAbs => Val::abs(self.v),
            _ => self,
        }
    }
}

#[derive(Debug, Clone)]
struct ScriptSym {
    val: Val,
    hidden: bool,
    /// Symbol type the definition took from its expression.
    kind: u8,
    /// Output section carrying the symbol in the symtab when the
    /// value came from the location counter outside any output
    /// section (ld's section_for_dot fixup); the value itself stays
    /// absolute for expression purposes.
    final_out: Option<usize>,
    /// Visibility that does not localize the binding, used by the
    /// synthesized `__start_` / `__stop_` pair. `hidden` stays the
    /// `PROVIDE_HIDDEN` path, which does localize.
    vis: Option<u8>,
}

/// One input section's per-pass placement.
#[derive(Clone, Copy, Default)]
struct Placement {
    out: usize,
    off: u64,
    placed: bool,
}

/// Merged SHF_MERGE pool for one output section + (entsize, strings)
/// class.
struct MergePool {
    /// Pool bytes.
    bytes: Vec<u8>,
    /// Per input section: mapping from input offsets (entry starts)
    /// to pool offsets, as parallel sorted vectors.
    maps: HashMap<usize, (Vec<u64>, Vec<u64>)>,
    /// Which input (index into `insecs`) carries the pool bytes.
    rep: usize,
    /// Pool alignment (all members share it -- it is part of the pool key).
    align: u64,
}

/// One PLT stub, on both targets.
const PLT_ENTRY_SIZE: u64 = 16;

/// The relaxable GOT forms, which `elf_reloc_types` does not name.
const R_X86_64_GOTPCRELX: u32 = 41;
const R_386_GOT32X: u32 = 43;

/// Name -> position, for a list whose order is its index space.
fn index_map(names: &[String]) -> HashMap<String, usize> {
    names
        .iter()
        .enumerate()
        .map(|(i, n)| (n.clone(), i))
        .collect()
}

/// A relocation holding a branch displacement: reaching an imported
/// symbol from one means going through a stub.
fn reloc_needs_plt(machine: u16, rtype: u32) -> bool {
    match machine {
        EM_AARCH64 => matches!(rtype, rt::R_AARCH64_CALL26 | rt::R_AARCH64_JUMP26),
        EM_386 => matches!(rtype, rt::R_386_PC32 | rt::R_386_PLT32),
        _ => matches!(rtype, rt::R_X86_64_PC32 | rt::R_X86_64_PLT32),
    }
}

/// A relocation naming a GOT slot rather than the symbol's own address.
fn reloc_uses_got(machine: u16, rtype: u32) -> bool {
    match machine {
        EM_AARCH64 => matches!(
            rtype,
            rt::R_AARCH64_ADR_GOT_PAGE | rt::R_AARCH64_LD64_GOT_LO12_NC
        ),
        EM_386 => matches!(rtype, rt::R_386_GOT32 | R_386_GOT32X),
        _ => matches!(
            rtype,
            rt::R_X86_64_GOTPCREL | R_X86_64_GOTPCRELX | rt::R_X86_64_REX_GOTPCRELX
        ),
    }
}

/// A stub at `at` jumping through the GOT slot at `slot`.
fn plt_entry(machine: u16, at: u64, slot: u64) -> [u8; PLT_ENTRY_SIZE as usize] {
    let mut e = [0u8; PLT_ENTRY_SIZE as usize];
    if machine == EM_AARCH64 {
        let page = (slot & !0xfff).wrapping_sub(at & !0xfff) as i64 >> 12;
        let imm = page as u32 & 0x1f_ffff;
        let adrp = 0x9000_0010 | (imm & 3) << 29 | (imm >> 2) << 5;
        let ldr = 0xf940_0211 | ((slot & 0xfff) as u32 / 8) << 10;
        for (k, w) in [adrp, ldr, 0xd61f_0220, 0xd503_201f].iter().enumerate() {
            e[k * 4..k * 4 + 4].copy_from_slice(&w.to_le_bytes());
        }
        return e;
    }
    // jmp *disp32(%rip), then a one-byte pad to the entry size.
    e[0] = 0xff;
    e[1] = 0x25;
    e[2..6].copy_from_slice(&(slot.wrapping_sub(at + 6) as u32).to_le_bytes());
    e[6..].fill(0xcc);
    e
}

/// A `.eh_frame` input rewritten with its duplicate CIEs dropped.
struct EhFrame {
    bytes: Vec<u8>,
    /// Size before the rewrite, for end-of-section references.
    orig_size: u64,
    /// Surviving ranges as (input offset, length, new offset), sorted.
    kept: Vec<(u64, u64, u64)>,
    /// Per FDE: its new offset, and the input section and new offset of
    /// the CIE it names.
    fdes: Vec<(u64, usize, u64)>,
}

impl EhFrame {
    /// New offset of `off`, or `None` when the entry holding it went
    /// away.
    fn remap(&self, off: u64) -> Option<u64> {
        if off >= self.orig_size {
            return Some(self.bytes.len() as u64);
        }
        match self.kept.binary_search_by_key(&off, |k| k.0) {
            Ok(k) => Some(self.kept[k].2),
            Err(0) => None,
            Err(k) => {
                let (o, len, new) = self.kept[k - 1];
                (off - o < len).then_some(new + (off - o))
            }
        }
    }
}

/// Identity of a CIE for deduplication: the bytes after its length
/// field, and the relocations covering it.
#[derive(PartialEq, Eq, Hash)]
struct CieKey {
    bytes: Vec<u8>,
    relocs: Vec<(u64, u32, String, i64)>,
}

struct DynReloc {
    offset: u64,
    rtype: u32,
    addend: i64,
    /// `.dynsym` index the entry names; 0 where the fixup needs no
    /// symbol.
    sym: u32,
}

pub struct LdsLinker<'a> {
    script: &'a LinkerScript,
    objects: Vec<LdsObject>,
    opts: LdsOptions,
    machine: u16,
    class: ElfClass,

    /// Flattened input sections across objects.
    insecs: Vec<InSecId>,
    /// First `insecs` index of each object.
    obj_base: Vec<usize>,
    fates: Vec<SecFate>,
    /// Sections a losing COMDAT group or `.gnu.linkonce` duplicate
    /// owns. They contribute nothing: no bytes, no symbols, no
    /// garbage-collection roots or edges.
    comdat_dropped: HashSet<SecId>,
    /// insec index -> merge pool key, for merged sections.
    merge_of: HashMap<usize, usize>,
    /// Orphan class -> the output section later orphans stack after.
    orphan_anchor: HashMap<u32, usize>,
    pools: Vec<MergePool>,
    /// insec index -> `.eh_frame` rewrite, for the inputs that lost a
    /// CIE to deduplication.
    eh_of: HashMap<usize, usize>,
    eh_frames: Vec<EhFrame>,
    /// Undefined references bound to an input shared library, sorted.
    /// Their `.dynsym` indices are `1 + position`, which is what the
    /// symbol-named dynamic relocations carry.
    imports: Vec<String>,
    import_of: HashMap<String, usize>,
    /// The subset reached by a call, in the order of their PLT stubs.
    plt_syms: Vec<String>,
    plt_of: HashMap<String, usize>,
    /// Program headers `SIZEOF_HEADERS` accounts for where the script
    /// declares none, measured from the previous round's layout.
    phdrs: usize,

    outs: Vec<OutSec>,
    /// Statement stream of the SECTIONS block with input claims
    /// resolved; `usize` indexes `outs`.
    stmts: Vec<Stmt>,

    /// Global symbol resolution: name -> defining (obj, sym index).
    globals: HashMap<String, (usize, usize)>,
    /// Common symbols coalesced into a synthetic bss chunk:
    /// name -> (insec index, offset, size, align).
    commons: HashMap<String, (usize, u64)>,
    /// Every symbol the script assigns anywhere. A script assignment
    /// outranks a synthesized section bound whatever order the two
    /// reach the symbol table in.
    script_assigned: HashSet<String>,

    // Per-pass state.
    placements: Vec<Placement>,
    script_now: HashMap<String, ScriptSym>,
    script_prev: HashMap<String, ScriptSym>,
    dot: u64,
    cur_out: Option<usize>,
    /// ld's dot-attachment state for assignments outside output
    /// sections: the last allocated output section visited, whether a
    /// top-level dot assignment makes following symbols prefer the
    /// next section, the statement index being executed, whether the
    /// `end` symbol was assigned yet, and per-output-section copies
    /// of that flag at visit time.
    dot_section: Option<usize>,
    prefer_next: bool,
    cur_stmt: usize,
    found_end: bool,
    after_end: Vec<bool>,
    lma_delta: u64,
    final_pass: bool,
    errors: Vec<String>,
    warnings: Vec<String>,
    undefined: BTreeSet<String>,
    referenced: HashSet<String>,

    /// Synthetic content owned by the pseudo-object (last in
    /// `objects`): index of the pseudo object.
    synth_obj: usize,
    dyn_relas: Vec<DynReloc>,
    /// Reserved-but-never-written `.rela.dyn` slots (see
    /// `count_reserved_none_slots`), computed once per link.
    dyn_nones: Option<u64>,
    relr_addrs: Vec<u64>,
    /// GOT slots, keyed by referenced symbol name (a GOT reference to
    /// an undefined symbol still needs a slot).
    got_slots: Vec<String>,
    got_map: HashMap<String, usize>,
    /// Dynamic tables, rebuilt each pass from the current placement.
    dyn_tables: Option<DynTables>,
    /// Version definitions from the script's `VERSION` command, base
    /// node first. Empty when the script defines none.
    verdefs: Vec<VerDef>,
    /// `--emit-relocs` records, gathered on the final pass.
    emitted: Vec<EmittedReloc>,
    /// Where `build_symtab` put each symbol, for resolving `emitted`.
    sym_index: SymIndex,
    /// Merged `.note.gnu.property` body, empty when no input carries a
    /// property that survives the merge.
    gnu_property: Vec<u8>,
}

/// Where each symbol landed in `build_symtab`'s output, for resolving
/// `--emit-relocs` records. Positions index that vector, not the ELF
/// table, which the writer reorders locals-first.
#[derive(Default)]
struct SymIndex {
    /// Output section index -> its section symbol.
    sec: HashMap<usize, usize>,
    /// (object, input symbol index) -> emitted local.
    local: HashMap<(usize, u32), usize>,
    /// Global, script-defined and undefined-weak symbols by name.
    by_name: HashMap<String, usize>,
}

/// One applied relocation kept for `--emit-relocs`; the output symtab
/// index is resolved once that table exists.
#[derive(Debug, Clone, Copy)]
struct EmittedReloc {
    out: usize,
    addr: u64,
    rtype: u32,
    /// Resolved `S + A`; the emitted addend is this less the final
    /// value of the symbol the entry names.
    target: u64,
    obj: usize,
    sym: u32,
}

#[derive(Debug, Clone)]
enum Stmt {
    Assign(Assignment),
    Assert(Expr, String),
    Open(usize),
}

const SYNTH_RELA: &str = ".rela.dyn";
const SYNTH_REL: &str = ".rel.dyn";
const SYNTH_RELR: &str = ".relr.dyn";
const SYNTH_GOT: &str = ".got";
const SYNTH_GOTPLT: &str = ".got.plt";
const SYNTH_BUILD_ID: &str = ".note.gnu.build-id";
const SYNTH_COMMON: &str = "COMMON";
const SYNTH_DYNSYM: &str = ".dynsym";
const SYNTH_DYNSTR: &str = ".dynstr";
const SYNTH_HASH: &str = ".hash";
const SYNTH_GNU_HASH: &str = ".gnu.hash";
const SYNTH_VERSYM: &str = ".gnu.version";
const SYNTH_VERDEF: &str = ".gnu.version_d";
const SYNTH_DYNAMIC: &str = ".dynamic";
const SYNTH_EH_FRAME_HDR: &str = ".eh_frame_hdr";
const SYNTH_INTERP: &str = ".interp";
const SYNTH_PLT: &str = ".plt";
const SYNTH_GNU_PROPERTY: &str = ".note.gnu.property";
const OUT_EH_FRAME: &str = ".eh_frame";

#[derive(Debug)]
pub struct LdsResult {
    pub image: Vec<u8>,
    pub map: String,
    pub warnings: Vec<String>,
}

pub fn link_with_script(
    script: &LinkerScript,
    inputs: Vec<LdsObject>,
    opts: &LdsOptions,
) -> Result<LdsResult, C5Error> {
    let mut linker = LdsLinker::new(script, inputs, opts.clone())?;
    linker.run()
}

impl<'a> LdsLinker<'a> {
    fn new(
        script: &'a LinkerScript,
        mut objects: Vec<LdsObject>,
        opts: LdsOptions,
    ) -> Result<Self, C5Error> {
        if objects.is_empty() {
            return Err(err("no input objects"));
        }
        let machine = objects[0].machine;
        for o in &objects[1..] {
            if o.machine != machine {
                return Err(err(&format!(
                    "{}: machine {} differs from {}'s {}",
                    o.source, o.machine, objects[0].source, machine
                )));
            }
        }
        for o in &objects {
            if o.class != class_for_machine(machine) {
                return Err(err(&format!(
                    "{}: ELF class does not match machine {machine}",
                    o.source
                )));
            }
        }
        // Property notes are merged into one synthesized note rather
        // than concatenated: a consumer reading the first note must see
        // the whole image's claim, not one input's. Every input counts
        // towards the merge, including those with no property section.
        let prop_notes: Vec<Vec<&[u8]>> = objects
            .iter()
            .map(|o| {
                o.sections
                    .iter()
                    .filter(|s| s.name == SYNTH_GNU_PROPERTY && s.shtype == SHT_NOTE)
                    .filter_map(|s| o.bytes.get(s.data_off..s.data_off + s.size as usize))
                    .collect()
            })
            .collect();
        let gnu_property = gnu_property::merge_section(
            &prop_notes,
            class_for_machine(machine).addr_size() as usize,
        )
        .unwrap_or_default();
        // `.note.GNU-stack` conveys stack executability and nothing
        // else; bfd consumes it and never places it. Keeping it would
        // put a PROGBITS input in whatever `*(.note*)` rule claims it,
        // which then stops being a note section.
        let drop_input = |s: &RawSection| {
            s.name == ".note.GNU-stack"
                || (s.name == SYNTH_GNU_PROPERTY && s.shtype == SHT_NOTE)
                || (opts.strip_debug && is_debug_section(&s.name))
        };
        for o in &mut objects {
            if !o.sections.iter().any(drop_input) {
                continue;
            }
            let orig: Vec<u32> = o.sections.iter().map(|s| s.orig_shndx).collect();
            o.sections.retain(|s| !drop_input(s));
            o.shndx_map = o
                .sections
                .iter()
                .enumerate()
                .map(|(i, s)| (s.orig_shndx, i))
                .collect();
            for g in &mut o.groups {
                g.members
                    .retain_mut(|m| match o.shndx_map.get(&orig[*m]).copied() {
                        Some(i) => {
                            *m = i;
                            true
                        }
                        None => false,
                    });
            }
        }
        // Pseudo-object for linker-synthesized sections.
        let synth_obj = objects.len();
        objects.push(LdsObject {
            source: "<linker>".to_string(),
            bytes: Vec::new(),
            machine,
            class: class_for_machine(machine),
            sections: Vec::new(),
            symbols: Vec::new(),
            groups: Vec::new(),
            shndx_map: HashMap::new(),
        });

        let class = class_for_machine(machine);
        let mut linker = LdsLinker {
            script,
            objects,
            opts,
            machine,
            class,
            insecs: Vec::new(),
            obj_base: Vec::new(),
            fates: Vec::new(),
            comdat_dropped: HashSet::new(),
            merge_of: HashMap::new(),
            orphan_anchor: HashMap::new(),
            pools: Vec::new(),
            eh_of: HashMap::new(),
            eh_frames: Vec::new(),
            imports: Vec::new(),
            import_of: HashMap::new(),
            plt_syms: Vec::new(),
            plt_of: HashMap::new(),
            phdrs: 4,
            outs: Vec::new(),
            stmts: Vec::new(),
            globals: HashMap::new(),
            commons: HashMap::new(),
            script_assigned: HashSet::new(),
            placements: Vec::new(),
            script_now: HashMap::new(),
            script_prev: HashMap::new(),
            dot: 0,
            cur_out: None,
            dot_section: None,
            prefer_next: false,
            cur_stmt: 0,
            found_end: false,
            after_end: Vec::new(),
            lma_delta: 0,
            final_pass: false,
            errors: Vec::new(),
            warnings: Vec::new(),
            undefined: BTreeSet::new(),
            referenced: HashSet::new(),
            synth_obj,
            dyn_relas: Vec::new(),
            dyn_nones: None,
            relr_addrs: Vec::new(),
            got_slots: Vec::new(),
            got_map: HashMap::new(),
            dyn_tables: None,
            verdefs: Vec::new(),
            emitted: Vec::new(),
            sym_index: SymIndex::default(),
            gnu_property,
        };
        linker.dedup_groups();
        linker.resolve_globals()?;
        linker.synthesize_sections();
        linker.flatten_inputs();
        linker.build_statements()?;
        linker.collect_script_assigned();
        linker.gc_sections();
        linker.claim_inputs()?;
        linker.build_merge_pools();
        linker.build_eh_frame_dedup();
        linker.build_imports();
        Ok(linker)
    }

    // ---------------------------------------------------- symbol prep

    /// Keep one copy of each COMDAT group and of each `.gnu.linkonce`
    /// section. Runs before symbol resolution so a losing copy's
    /// definitions never collide with the surviving one's.
    fn dedup_groups(&mut self) {
        let dropped = {
            let views: Vec<comdat::ObjView<'_>> = self
                .objects
                .iter()
                .map(|o| comdat::ObjView {
                    groups: o
                        .groups
                        .iter()
                        .map(|g| comdat::GroupView {
                            flags: g.flags,
                            signature: &g.signature,
                            members: &g.members,
                        })
                        .collect(),
                    section_names: o.sections.iter().map(|s| s.name.as_str()).collect(),
                })
                .collect();
            comdat::dedup(&views).dropped
        };
        self.comdat_dropped = dropped;
    }

    /// The name of the section defining `sym` of object `oi`, if the
    /// dedup dropped it.
    fn dropped_home(&self, oi: usize, sym: &RawSym) -> Option<&str> {
        let sec = *self.objects[oi].shndx_map.get(&sym.shndx)?;
        self.comdat_dropped
            .contains(&(oi, sec))
            .then(|| self.objects[oi].sections[sec].name.as_str())
    }

    fn resolve_globals(&mut self) -> Result<(), C5Error> {
        // Strong definitions win over weak; two strongs collide.
        let mut strong: HashMap<String, (usize, usize)> = HashMap::new();
        let mut weak: HashMap<String, (usize, usize)> = HashMap::new();
        let mut common: HashMap<String, (u64, u64, usize, usize)> = HashMap::new();
        for (oi, o) in self.objects.iter().enumerate() {
            for (si, s) in o.symbols.iter().enumerate() {
                if s.name.is_empty() || s.binding() == STB_LOCAL {
                    continue;
                }
                if o.shndx_map
                    .get(&s.shndx)
                    .is_some_and(|&sec| self.comdat_dropped.contains(&(oi, sec)))
                {
                    continue; // the surviving copy owns the definition
                }
                match s.shndx as u16 {
                    SHN_UNDEF => {
                        self.referenced.insert(s.name.clone());
                    }
                    SHN_COMMON => {
                        let e = common.entry(s.name.clone()).or_insert((0, 1, oi, si));
                        e.0 = e.0.max(s.size);
                        e.1 = e.1.max(s.value.max(1));
                    }
                    _ => {
                        if s.binding() == STB_WEAK {
                            weak.entry(s.name.clone()).or_insert((oi, si));
                        } else if let Some(&(poi, _)) = strong.get(&s.name) {
                            return Err(err(&format!(
                                "multiple definition of `{}` (in {} and {})",
                                s.name, self.objects[poi].source, self.objects[oi].source
                            )));
                        } else {
                            strong.insert(s.name.clone(), (oi, si));
                        }
                    }
                }
            }
        }
        for (name, def) in weak {
            strong.entry(name).or_insert(def);
        }
        // Commons not overridden by a real definition coalesce into a
        // synthetic NOBITS section on the pseudo-object.
        let mut layout: u64 = 0;
        let mut align: u64 = 1;
        let mut names: Vec<&String> = common.keys().filter(|n| !strong.contains_key(*n)).collect();
        names.sort();
        let mut slots: Vec<(String, u64)> = Vec::new();
        for name in names {
            let (size, al, _, _) = common[name];
            layout = align_up(layout, al);
            slots.push((name.clone(), layout));
            layout += size;
            align = align.max(al);
        }
        if layout > 0 {
            let synth = self.synth_obj;
            let sec = self.push_synth_section(SYNTH_COMMON, SHT_NOBITS, SHF_ALLOC | SHF_WRITE);
            self.objects[synth].sections[sec].size = layout;
            self.objects[synth].sections[sec].addralign = align;
            for (name, off) in slots {
                // Redirect the common definition at the synthetic slot
                // via a pseudo global symbol.
                let si = self.objects[synth].symbols.len();
                let shndx = self.objects[synth].sections[sec].orig_shndx;
                let size = common[&name].0;
                self.objects[synth].symbols.push(RawSym {
                    name: name.clone(),
                    info: (STB_GLOBAL << 4) | STT_OBJECT,
                    other: 0,
                    shndx,
                    value: off,
                    size,
                });
                strong.insert(name, (synth, si));
            }
        }
        self.globals = strong;
        Ok(())
    }

    fn push_synth_section(&mut self, name: &str, shtype: u32, flags: u64) -> usize {
        let align = self.class.addr_size();
        let synth = self.synth_obj;
        let obj = &mut self.objects[synth];
        let idx = obj.sections.len();
        let orig_shndx = idx as u32 + 1;
        obj.sections.push(RawSection {
            name: name.to_string(),
            shtype,
            flags,
            addralign: align,
            entsize: 0,
            data_off: 0,
            size: 0,
            relocs: Vec::new(),
            orig_shndx,
            link: 0,
        });
        obj.shndx_map.insert(orig_shndx, idx);
        idx
    }

    fn synthesize_sections(&mut self) {
        if let Some(path) = self.opts.interp.clone() {
            let idx = self.push_synth_section(SYNTH_INTERP, SHT_PROGBITS, SHF_ALLOC);
            let synth = self.synth_obj;
            let sec = &mut self.objects[synth].sections[idx];
            sec.addralign = 1;
            sec.size = path.len() as u64 + 1;
        }
        if !self.gnu_property.is_empty() {
            let idx = self.push_synth_section(SYNTH_GNU_PROPERTY, SHT_NOTE, SHF_ALLOC);
            let synth = self.synth_obj;
            let sec = &mut self.objects[synth].sections[idx];
            sec.addralign = self.class.addr_size();
            sec.size = self.gnu_property.len() as u64;
        }
        if self.opts.eh_frame_hdr {
            let idx = self.push_synth_section(SYNTH_EH_FRAME_HDR, SHT_PROGBITS, SHF_ALLOC);
            let synth = self.synth_obj;
            self.objects[synth].sections[idx].addralign = 4;
        }
        if self.opts.build_id_sha1 {
            let idx = self.push_synth_section(SYNTH_BUILD_ID, SHT_NOTE, SHF_ALLOC);
            let synth = self.synth_obj;
            let sec = &mut self.objects[synth].sections[idx];
            sec.addralign = 4;
            sec.size = 36; // 12-byte header + "GNU\0" + 20-byte sha1
        }
        if !self.opts.shared_libs.is_empty() {
            let idx = self.push_synth_section(SYNTH_PLT, SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR);
            let synth = self.synth_obj;
            self.objects[synth].sections[idx].addralign = PLT_ENTRY_SIZE;
        }
        if self.opts.emit == LdsEmit::Dyn {
            let (rela_name, rela_type, rela_ent) = self.dyn_reloc_kind();
            let rela = self.push_synth_section(rela_name, rela_type, SHF_ALLOC);
            // `.relr.dyn` exists only where RELR packing was asked for.
            // Creating it unconditionally leaves an empty section no
            // script names, which `--orphan-handling=error` rejects.
            let relr = self
                .opts
                .pack_relative_relocs
                .then(|| self.push_synth_section(SYNTH_RELR, SHT_RELR, SHF_ALLOC));
            let got = self.push_synth_section(SYNTH_GOT, SHT_PROGBITS, SHF_ALLOC | SHF_WRITE);
            let gotplt = self.push_synth_section(SYNTH_GOTPLT, SHT_PROGBITS, SHF_ALLOC | SHF_WRITE);
            let synth = self.synth_obj;
            let slot = self.class.addr_size();
            let reserved = self.got_reserved();
            self.objects[synth].sections[rela].entsize = rela_ent;
            if let Some(relr) = relr {
                self.objects[synth].sections[relr].entsize = slot;
            }
            self.objects[synth].sections[got].entsize = slot;
            // .got: the reserved header, where this target keeps it;
            // GOT slots append per use.
            self.objects[synth].sections[got].size = reserved * slot;
            // .got.plt: three reserved slots, no PLT entries.
            self.objects[synth].sections[gotplt].entsize = slot;
            self.objects[synth].sections[gotplt].size = 3 * slot;
            self.synthesize_dynamic_sections();
        }
    }

    /// The dynamic-linking tables. bfd builds these for every ET_DYN
    /// image; a script that does not want them discards them, which is
    /// what the kernel's own scripts do.
    fn synthesize_dynamic_sections(&mut self) {
        self.verdefs = self.script_verdefs();
        let mut secs: Vec<(&str, u32, u64, u64)> = Vec::new();
        if self.opts.hash_style.sysv() {
            secs.push((SYNTH_HASH, dynamic::SHT_HASH, SHF_ALLOC, 4));
        }
        if self.opts.hash_style.gnu() {
            // bfd gives `.gnu.hash` a 4-byte entsize on ELF32 only:
            // the ELF64 table's Bloom words are wider than its words.
            let ent = if self.class.is32() { 4 } else { 0 };
            secs.push((SYNTH_GNU_HASH, dynamic::SHT_GNU_HASH, SHF_ALLOC, ent));
        }
        secs.push((
            SYNTH_DYNSYM,
            dynamic::SHT_DYNSYM,
            SHF_ALLOC,
            self.class.sym_size(),
        ));
        secs.push((SYNTH_DYNSTR, SHT_STRTAB, SHF_ALLOC, 0));
        if !self.verdefs.is_empty() {
            secs.push((SYNTH_VERSYM, dynamic::SHT_GNU_VERSYM, SHF_ALLOC, 2));
            secs.push((SYNTH_VERDEF, dynamic::SHT_GNU_VERDEF, SHF_ALLOC, 0));
        }
        secs.push((
            SYNTH_DYNAMIC,
            dynamic::SHT_DYNAMIC,
            SHF_ALLOC | SHF_WRITE,
            self.class.dyn_size(),
        ));
        let default_align = self.class.addr_size();
        for (name, shtype, flags, entsize) in secs {
            let idx = self.push_synth_section(name, shtype, flags);
            let synth = self.synth_obj;
            let sec = &mut self.objects[synth].sections[idx];
            sec.entsize = entsize;
            sec.addralign = match name {
                SYNTH_DYNSTR => 1,
                SYNTH_VERSYM => 2,
                _ => default_align,
            };
        }
    }

    /// Version definitions in index order. Index 1 names the object
    /// itself (the soname where one was given), so a user version's
    /// index starts at 2, as `.gnu.version` entries reference them.
    fn script_verdefs(&self) -> Vec<VerDef> {
        let nodes = self.script.versions().unwrap_or(&[]);
        let named: Vec<&super::lds::VersionNode> =
            nodes.iter().filter(|n| !n.name.is_empty()).collect();
        if named.is_empty() {
            return Vec::new();
        }
        let mut out = alloc::vec![VerDef {
            name: self
                .opts
                .soname
                .clone()
                .unwrap_or_else(|| self.opts.output_name.clone()),
            base: true,
        }];
        out.extend(named.iter().map(|n| VerDef {
            name: n.name.clone(),
            base: false,
        }));
        out
    }

    fn flatten_inputs(&mut self) {
        for (oi, o) in self.objects.iter().enumerate() {
            self.obj_base.push(self.insecs.len());
            for si in 0..o.sections.len() {
                self.insecs.push(InSecId { obj: oi, sec: si });
                self.fates.push(if self.comdat_dropped.contains(&(oi, si)) {
                    SecFate::Discarded
                } else {
                    SecFate::Unclaimed
                });
            }
        }
        self.placements = alloc::vec![Placement::default(); self.insecs.len()];
    }

    fn insec(&self, i: usize) -> &RawSection {
        let id = self.insecs[i];
        &self.objects[id.obj].sections[id.sec]
    }

    fn insec_index(&self, obj: usize, sec: usize) -> usize {
        self.obj_base[obj] + sec
    }

    // ------------------------------------------------------- claiming

    fn build_statements(&mut self) -> Result<(), C5Error> {
        let Some(items) = self.script.sections() else {
            return Err(err("script has no SECTIONS command"));
        };
        for item in items {
            match item {
                SectionsItem::Assign(a) => self.stmts.push(Stmt::Assign(a.clone())),
                SectionsItem::Assert(e, m) => self.stmts.push(Stmt::Assert(e.clone(), m.clone())),
                SectionsItem::Output(o) => {
                    let idx = self.outs.len();
                    self.outs.push(OutSec {
                        name: o.name.clone(),
                        address: o.address.clone(),
                        stype: o.stype,
                        at: o.at.clone(),
                        align_attr: o.align.clone(),
                        pieces: Vec::new(),
                        phdrs: o.phdrs.clone(),
                        fill: o.fill.clone(),
                        orphan: false,
                        addr: 0,
                        lma: 0,
                        size: 0,
                        align: 1,
                        flags: 0,
                        shtype: SHT_PROGBITS,
                        entsize: 0,
                        alloc: false,
                        removed: false,
                        file_bytes: false,
                        chunks: Vec::new(),
                    });
                    self.build_section_pieces(idx, o)?;
                    self.stmts.push(Stmt::Open(idx));
                }
            }
        }
        Ok(())
    }

    fn build_section_pieces(&mut self, idx: usize, o: &OutputSection) -> Result<(), C5Error> {
        for c in &o.contents {
            let piece = match c {
                SectionContent::Assign(a) => Piece::Assign(a.clone()),
                SectionContent::Assert(e, m) => Piece::Assert(e.clone(), m.clone()),
                SectionContent::Data(w, e) => Piece::Data(*w, e.clone()),
                SectionContent::Fill(e) => Piece::Fill(e.clone()),
                SectionContent::Constructors => continue,
                SectionContent::Input(_) => Piece::Inputs(Vec::new()),
            };
            self.outs[idx].pieces.push(piece);
        }
        Ok(())
    }

    /// Match every input section against the script's specs, in
    /// script order; each section is claimed at most once.
    fn claim_inputs(&mut self) -> Result<(), C5Error> {
        let Some(items) = self.script.sections() else {
            return Ok(());
        };
        let mut out_idx = 0usize;
        for item in items {
            let SectionsItem::Output(o) = item else {
                continue;
            };
            let discard = o.name == "/DISCARD/";
            let this_out = out_idx;
            out_idx += 1;
            let mut piece_idx = 0usize;
            for c in &o.contents {
                let is_piece = !matches!(c, SectionContent::Constructors);
                let SectionContent::Input(spec) = c else {
                    if is_piece {
                        piece_idx += 1;
                    }
                    continue;
                };
                let claimed = self.claim_spec(spec);
                if discard {
                    for i in &claimed {
                        self.fates[*i] = SecFate::Discarded;
                    }
                } else {
                    for i in &claimed {
                        self.fates[*i] = SecFate::Placed { out: this_out };
                    }
                    if let Piece::Inputs(v) = &mut self.outs[this_out].pieces[piece_idx] {
                        *v = claimed;
                    }
                }
                piece_idx += 1;
            }
        }
        self.handle_orphans()
    }

    /// `--gc-sections`: discard every allocatable input section no
    /// root reaches through a relocation, before the specs claim
    /// anything. bfd's rule set -- a section carrying none of
    /// `SEC_ALLOC` / `SEC_LOAD` / `SEC_RELOC` is kept, as is a debug
    /// section, `SHF_GNU_RETAIN`, and anything a `KEEP()` names.
    fn gc_sections(&mut self) {
        if !self.opts.gc_sections {
            return;
        }
        let mut live = alloc::vec![false; self.insecs.len()];
        let mut work: Vec<usize> = Vec::new();
        // A section the group dedup dropped is not part of the link:
        // it is neither a root nor a path to one, whatever names it.
        let gone: Vec<bool> = self
            .insecs
            .iter()
            .map(|id| self.comdat_dropped.contains(&(id.obj, id.sec)))
            .collect();
        let mark = |live: &mut [bool], work: &mut Vec<usize>, i: usize| {
            if !live[i] && !gone[i] {
                live[i] = true;
                work.push(i);
            }
        };
        // Sections GC never collects. Kept is not the same as
        // reaching: a debug or unwind section names every function it
        // describes, so following its relocations would keep the whole
        // input. bfd keeps those sections and prunes their contents
        // instead, and their references to a dropped section resolve
        // to nothing rather than to a diagnostic.
        for (i, keep) in live.iter_mut().enumerate() {
            let id = self.insecs[i];
            let s = &self.objects[id.obj].sections[id.sec];
            let collectable = s.flags & SHF_ALLOC != 0;
            *keep = !gone[i]
                && (!collectable
                    || s.flags & SHF_GNU_RETAIN != 0
                    || is_debug_section(&s.name)
                    || is_unwind_section(&s.name)
                    || id.obj == self.synth_obj);
        }
        // `KEEP()` roots, matched the way the claim would match them.
        let specs = self.keep_specs();
        for spec in &specs {
            for i in 0..self.insecs.len() {
                if self.spec_matches(spec, i, None) && !is_unwind_section(&self.insec(i).name) {
                    mark(&mut live, &mut work, i);
                }
            }
        }
        // Named roots: the entry point, `-u`, and every symbol the
        // dynamic table exports.
        let mut roots: Vec<String> = self.opts.undefined.clone();
        if let Some(e) = self
            .opts
            .entry_override
            .clone()
            .or_else(|| self.script.entry().map(String::from))
        {
            roots.push(e);
        }
        if self.opts.emit == LdsEmit::Dyn {
            roots.extend(self.globals.keys().cloned());
        }
        for name in &roots {
            for i in self.sections_defining(name) {
                mark(&mut live, &mut work, i);
            }
        }
        // Reachability. A reference to `__start_X` / `__stop_X` keeps
        // every section named `X`, the bound being meaningless without
        // the content it brackets.
        while let Some(i) = work.pop() {
            let id = self.insecs[i];
            for r in self.objects[id.obj].sections[id.sec].relocs.clone() {
                for t in self.reloc_targets(id.obj, r.sym as usize) {
                    mark(&mut live, &mut work, t);
                }
            }
        }
        for (i, keep) in live.iter().enumerate() {
            if !keep {
                self.fates[i] = SecFate::Discarded;
            }
        }
    }

    /// Every `KEEP()`-marked input spec in the script.
    fn keep_specs(&self) -> Vec<InputSpec> {
        let mut out: Vec<InputSpec> = Vec::new();
        for cmd in &self.script.commands {
            let Command::Sections(list) = cmd else {
                continue;
            };
            for item in list {
                let SectionsItem::Output(o) = item else {
                    continue;
                };
                for c in &o.contents {
                    if let SectionContent::Input(spec) = c
                        && spec.keep
                    {
                        out.push(spec.clone());
                    }
                }
            }
        }
        out
    }

    /// Input sections defining `name`, plus every section the name
    /// brackets when it is a `__start_` / `__stop_` bound.
    fn sections_defining(&self, name: &str) -> Vec<usize> {
        let mut out: Vec<usize> = Vec::new();
        if let Some(&(oi, si)) = self.globals.get(name) {
            let sym = &self.objects[oi].symbols[si];
            if let Some(&sec) = self.objects[oi].shndx_map.get(&sym.shndx) {
                out.push(self.insec_index(oi, sec));
            }
        }
        let bracketed = name
            .strip_prefix("__start_")
            .or_else(|| name.strip_prefix("__stop_"));
        if let Some(sec_name) = bracketed {
            for i in 0..self.insecs.len() {
                if self.insec(i).name == sec_name {
                    out.push(i);
                }
            }
        }
        out
    }

    /// Input sections a relocation against symbol `si` of object `oi`
    /// reaches: the defining section, resolved by name for a global.
    fn reloc_targets(&self, oi: usize, si: usize) -> Vec<usize> {
        let Some(sym) = self.objects[oi].symbols.get(si) else {
            return Vec::new();
        };
        if sym.binding() != STB_LOCAL && !sym.name.is_empty() {
            let by_name = self.sections_defining(&sym.name);
            if !by_name.is_empty() {
                return by_name;
            }
        }
        match sym.shndx as u16 {
            SHN_UNDEF | SHN_ABS | SHN_COMMON => Vec::new(),
            _ => match self.objects[oi].shndx_map.get(&sym.shndx) {
                Some(&sec) => alloc::vec![self.insec_index(oi, sec)],
                None => Vec::new(),
            },
        }
    }

    /// Sections matched by one input spec, in ld order: for a spec
    /// with several patterns, matching sections appear in input-file
    /// order interleaved; a SORT-wrapped pattern collects and sorts
    /// its own matches, emitted at the position of that pattern.
    fn claim_spec(&mut self, spec: &InputSpec) -> Vec<usize> {
        let mut result: Vec<usize> = Vec::new();
        let any_sorted = spec.patterns.iter().any(|p| p.sort != SortKind::None);
        if !any_sorted {
            for i in 0..self.insecs.len() {
                if self.fates[i] != SecFate::Unclaimed {
                    continue;
                }
                if self.spec_matches(spec, i, None) {
                    result.push(i);
                }
            }
            return result;
        }
        for (pi, pat) in spec.patterns.iter().enumerate() {
            let mut matches: Vec<usize> = Vec::new();
            for i in 0..self.insecs.len() {
                if self.fates[i] != SecFate::Unclaimed || result.contains(&i) {
                    continue;
                }
                if self.spec_matches(spec, i, Some(pi)) {
                    matches.push(i);
                }
            }
            match pat.sort {
                SortKind::ByName => {
                    matches.sort_by_key(|&a| self.insec(a).name.clone());
                }
                SortKind::ByAlignment => {
                    // Descending alignment, stable.
                    matches.sort_by_key(|&a| core::cmp::Reverse(self.insec(a).addralign));
                }
                SortKind::None => {}
            }
            result.extend(matches);
        }
        result
    }

    fn spec_matches(&self, spec: &InputSpec, i: usize, only_pattern: Option<usize>) -> bool {
        let id = self.insecs[i];
        let sec = &self.objects[id.obj].sections[id.sec];
        let source = &self.objects[id.obj].source;
        if !file_glob(&spec.file, source) {
            return false;
        }
        if spec.patterns.is_empty() {
            return true;
        }
        for (pi, p) in spec.patterns.iter().enumerate() {
            if let Some(only) = only_pattern
                && pi != only
            {
                continue;
            }
            if p.exclude_files.iter().any(|f| file_glob(f, source)) {
                continue;
            }
            if glob_match(&p.pattern, &sec.name) {
                return true;
            }
        }
        false
    }

    /// Unclaimed sections after all specs ran. `error` fails the link;
    /// `warn` / `place` append each after the last output section
    /// with compatible flags (a same-name output section wins).
    fn handle_orphans(&mut self) -> Result<(), C5Error> {
        let mut orphan_list: Vec<usize> = Vec::new();
        for i in 0..self.insecs.len() {
            if self.fates[i] != SecFate::Unclaimed {
                continue;
            }
            let sec = self.insec(i);
            // Zero-size unnamed leftovers and non-alloc reserved names
            // the writer regenerates are dropped silently.
            if sec.name.is_empty() {
                self.fates[i] = SecFate::Discarded;
                continue;
            }
            orphan_list.push(i);
        }
        if orphan_list.is_empty() {
            return Ok(());
        }
        if self.opts.orphan_handling == OrphanHandling::Error {
            let mut msg = String::from("orphan sections with --orphan-handling=error:");
            for &i in orphan_list.iter().take(20) {
                let id = self.insecs[i];
                msg.push_str(&format!(
                    "\n  `{}' from {}",
                    self.insec(i).name,
                    self.objects[id.obj].source
                ));
            }
            if orphan_list.len() > 20 {
                msg.push_str(&format!("\n  ... {} total", orphan_list.len()));
            }
            return Err(err(&msg));
        }
        if self.opts.orphan_handling == OrphanHandling::Discard {
            for &i in &orphan_list {
                self.fates[i] = SecFate::Discarded;
            }
            return Ok(());
        }
        for &i in &orphan_list {
            if self.opts.orphan_handling == OrphanHandling::Warn {
                let id = self.insecs[i];
                self.warnings.push(format!(
                    "warning: orphan section `{}' from `{}' being placed in section `{}'",
                    self.insec(i).name,
                    self.objects[id.obj].source,
                    self.insec(i).name
                ));
            }
            self.place_orphan(i);
        }
        Ok(())
    }

    fn place_orphan(&mut self, i: usize) {
        let (name, flags, shtype) = {
            let s = self.insec(i);
            (s.name.clone(), s.flags, s.shtype)
        };
        // Same-name output section: append there.
        if let Some((oi, _)) = self.outs.iter().enumerate().find(|(_, o)| o.name == name) {
            self.fates[i] = SecFate::Placed { out: oi };
            self.outs[oi].pieces.push(Piece::Inputs(alloc::vec![i]));
            return;
        }
        // New output section named after the input. bfd anchors an
        // orphan on the output section canonically named for its class
        // (`.text`, `.rodata`, `.data`, `.bss`), falling back to the
        // last section of a compatible class; further orphans of the
        // same class stack after the one already placed.
        let want = orphan_class(flags, shtype);
        let anchor = match self.orphan_anchor.get(&want) {
            Some(&oi) => Some(oi),
            None => self
                .outs
                .iter()
                .position(|o| Some(o.name.as_str()) == ORPHAN_ANCHOR_NAMES[want as usize]),
        };
        let mut insert_after: Option<usize> = None; // index into stmts
        for (si, st) in self.stmts.iter().enumerate() {
            if let Stmt::Open(oi) = st {
                if Some(*oi) == anchor {
                    insert_after = Some(si);
                    break;
                }
                if anchor.is_none() {
                    let of = self.section_input_flags(*oi);
                    if orphan_class(of, self.outs[*oi].shtype) <= want {
                        insert_after = Some(si);
                    }
                }
            }
        }
        let new_out = self.outs.len();
        self.outs.push(OutSec {
            name,
            address: None,
            stype: None,
            at: None,
            align_attr: None,
            pieces: alloc::vec![Piece::Inputs(alloc::vec![i])],
            phdrs: Vec::new(),
            fill: None,
            orphan: true,
            addr: 0,
            lma: 0,
            size: 0,
            align: 1,
            flags: 0,
            shtype: SHT_PROGBITS,
            entsize: 0,
            alloc: false,
            removed: false,
            file_bytes: false,
            chunks: Vec::new(),
        });
        let pos = insert_after.map(|s| s + 1).unwrap_or(self.stmts.len());
        self.stmts.insert(pos, Stmt::Open(new_out));
        self.fates[i] = SecFate::Placed { out: new_out };
        self.orphan_anchor.insert(want, new_out);
    }

    /// Union of the input flags currently claimed by output `oi`.
    fn section_input_flags(&self, oi: usize) -> u64 {
        let mut f = 0u64;
        for p in &self.outs[oi].pieces {
            if let Piece::Inputs(v) = p {
                for &i in v {
                    f |= self.insec(i).flags;
                }
            }
        }
        f
    }

    // ---------------------------------------------------- merge pools

    /// Deduplicate SHF_MERGE sections without relocations, following
    /// bfd's merge pass (`bfd/merge.c`): a separate pool per output
    /// section and (entsize, strings, alignment) class. A section
    /// whose entsize/alignment relation fails bfd's sanity check, or
    /// whose size is not an entsize multiple, stays unmerged. The
    /// pool replaces the first member's bytes; other members
    /// contribute nothing and their offsets remap.
    fn build_merge_pools(&mut self) {
        #[derive(PartialEq, Eq, Hash)]
        struct Key {
            entsize: u64,
            strings: bool,
            align: u64,
        }
        let mut groups: BTreeMap<usize, Vec<usize>> = BTreeMap::new();
        let mut group_key: Vec<Key> = Vec::new();
        let mut key_index: HashMap<(usize, u64, bool, u64), usize> = HashMap::new();
        for i in 0..self.insecs.len() {
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            let s = self.insec(i);
            if s.flags & SHF_MERGE == 0 || !s.relocs.is_empty() || s.shtype != SHT_PROGBITS {
                continue;
            }
            let strings = s.flags & SHF_STRINGS != 0;
            let entsize = s.entsize;
            if s.size == 0
                || s.size > u32::MAX as u64
                || entsize == 0
                || !s.size.is_multiple_of(entsize)
            {
                continue;
            }
            let align = s.addralign.max(1);
            // bfd: an entsize below the alignment must be a power of
            // two and marks strings; above it, an exact multiple.
            if !align.is_power_of_two()
                || (entsize < align && (!entsize.is_power_of_two() || !strings))
                || (entsize > align && !entsize.is_multiple_of(align))
            {
                continue;
            }
            let tup = (out, entsize, strings, align);
            let gid = *key_index.entry(tup).or_insert_with(|| {
                group_key.push(Key {
                    entsize,
                    strings,
                    align,
                });
                group_key.len() - 1
            });
            groups.entry(gid).or_default().push(i);
        }
        for (gid, members) in &groups {
            let key = &group_key[*gid];
            let (pool_bytes, member_maps) =
                self.build_pool(members, key.entsize, key.strings, key.align);
            let rep = *members
                .iter()
                .min()
                .expect("merge group has at least one member");
            let pool_idx = self.pools.len();
            self.pools.push(MergePool {
                bytes: pool_bytes,
                maps: member_maps,
                rep,
                align: key.align,
            });
            for &m in members {
                self.merge_of.insert(m, pool_idx);
            }
        }
    }

    /// Build one merge pool the way bfd does. Entries are recorded in
    /// member/offset order and deduplicated on identity; an entry's
    /// required alignment is the largest power of two dividing any
    /// input offset it appears at (capped at the section alignment,
    /// offset 0 counting as fully aligned). Strings additionally
    /// share suffixes. Offsets are assigned in first-seen order with
    /// per-entry alignment padding; the pool tail pads to the section
    /// alignment when every member's size is a multiple of it.
    fn build_pool(
        &self,
        members: &[usize],
        entsize: u64,
        strings: bool,
        align: u64,
    ) -> (Vec<u8>, PoolMemberMaps) {
        struct Entry {
            /// Content including the terminator for strings.
            bytes: Vec<u8>,
            /// Required start alignment; 0 once suffix-merged.
            align: u64,
            index: u64,
            suffix_of: usize,
        }
        let es = entsize as usize;
        let mut entries: Vec<Entry> = Vec::new();
        let mut interned: HashMap<Vec<u8>, usize> = HashMap::new();
        let mut member_refs: Vec<(usize, Vec<u64>, Vec<usize>)> = Vec::new();
        let mut pad_tail = true;
        for &m in members {
            let id = self.insecs[m];
            let data = {
                let o = &self.objects[id.obj];
                o.section_data(&o.sections[id.sec]).to_owned()
            };
            pad_tail &= (data.len() as u64).is_multiple_of(align);
            let (mut starts, mut ids) = (Vec::new(), Vec::new());
            let mut pos = 0usize;
            while pos < data.len() {
                let len = if strings {
                    // Entry runs through its all-zero terminator
                    // unit; an unterminated tail gains a synthetic
                    // one (bfd appends entsize zeros to the buffer).
                    let mut k = pos;
                    loop {
                        if k >= data.len() {
                            break data.len() - pos + es;
                        }
                        if data[k..data.len().min(k + es)].iter().all(|&b| b == 0) {
                            break k + es - pos;
                        }
                        k += es;
                    }
                } else {
                    es
                };
                let mut bytes = data[pos..data.len().min(pos + len)].to_vec();
                bytes.resize(len, 0);
                let eltalign = if pos == 0 {
                    align
                } else {
                    (1u64 << pos.trailing_zeros()).min(align)
                };
                let eid = *interned.entry(bytes.clone()).or_insert_with(|| {
                    entries.push(Entry {
                        bytes,
                        align: 0,
                        index: 0,
                        suffix_of: usize::MAX,
                    });
                    entries.len() - 1
                });
                entries[eid].align = entries[eid].align.max(eltalign);
                starts.push(pos as u64);
                ids.push(eid);
                pos += len;
            }
            member_refs.push((m, starts, ids));
        }
        if strings && !entries.is_empty() {
            // bfd merge_strings: sort by reversed content (lengths
            // without the terminator) and merge each entry into an
            // alignment-compatible neighbour it is a suffix of.
            let content_len = |e: &Entry| e.bytes.len() - es;
            let uniform = entries[1..]
                .iter()
                .all(|e| e.align == entries[0].align)
                .then(|| entries[0].align)
                .filter(|&a| a > entsize);
            let revcmp = |a: &Entry, b: &Entry| -> core::cmp::Ordering {
                let (la, lb) = (content_len(a), content_len(b));
                if let Some(al) = uniform {
                    let t = (la as u64 & (al - 1)).cmp(&(lb as u64 & (al - 1)));
                    if t != core::cmp::Ordering::Equal {
                        return t;
                    }
                }
                let l = la.min(lb);
                for k in 1..=l {
                    let t = a.bytes[la - k].cmp(&b.bytes[lb - k]);
                    if t != core::cmp::Ordering::Equal {
                        return t;
                    }
                }
                la.cmp(&lb)
            };
            let mut order: Vec<usize> = (0..entries.len()).collect();
            order.sort_by(|&x, &y| revcmp(&entries[x], &entries[y]));
            let mut e = order[order.len() - 1];
            for &cmp in order[..order.len() - 1].iter().rev() {
                let (el, cl) = (entries[e].bytes.len(), entries[cmp].bytes.len());
                if entries[e].align >= entries[cmp].align
                    && el > cl
                    && ((el - cl) as u64).is_multiple_of(entries[cmp].align)
                    && entries[e].bytes[el - cl..] == entries[cmp].bytes[..]
                {
                    entries[cmp].suffix_of = e;
                    entries[cmp].align = 0;
                } else {
                    e = cmp;
                }
            }
        }
        let mut size = 0u64;
        for e in entries.iter_mut() {
            if e.align != 0 {
                size = align_up(size, e.align);
                e.index = size;
                size += e.bytes.len() as u64;
            }
        }
        for k in 0..entries.len() {
            let t = entries[k].suffix_of;
            if t != usize::MAX {
                entries[k].index =
                    entries[t].index + (entries[t].bytes.len() - entries[k].bytes.len()) as u64;
            }
        }
        if pad_tail {
            size = align_up(size, align);
        }
        let mut pool = vec![0u8; size as usize];
        for e in &entries {
            if e.align != 0 {
                pool[e.index as usize..e.index as usize + e.bytes.len()].copy_from_slice(&e.bytes);
            }
        }
        let mut maps: HashMap<usize, (Vec<u64>, Vec<u64>)> = HashMap::new();
        for (m, starts, ids) in member_refs {
            let targets: Vec<u64> = ids.iter().map(|&eid| entries[eid].index).collect();
            maps.insert(m, (starts, targets));
        }
        (pool, maps)
    }

    /// Remap an offset into a merged input section to its pool
    /// offset: the covering entry's position plus the delta into it.
    /// At or past the input's end the offset maps to the pool's end,
    /// as bfd resolves end-of-section references.
    fn merge_remap(&self, insec: usize, off: u64) -> u64 {
        let pool = &self.pools[self.merge_of[&insec]];
        if off >= self.insec(insec).size {
            return pool.bytes.len() as u64;
        }
        let (starts, targets) = &pool.maps[&insec];
        match starts.binary_search(&off) {
            Ok(k) => targets[k],
            Err(0) => off, // before first entry: identity
            Err(k) => targets[k - 1] + (off - starts[k - 1]),
        }
    }

    /// Effective placed size of input section `i` (0 for non-
    /// representative members of a merge pool).
    fn insec_placed_size(&self, i: usize) -> u64 {
        if let Some(&p) = self.merge_of.get(&i) {
            if self.pools[p].rep == i {
                return self.pools[p].bytes.len() as u64;
            }
            return 0;
        }
        if let Some(&e) = self.eh_of.get(&i) {
            return self.eh_frames[e].bytes.len() as u64;
        }
        self.insec(i).size
    }

    /// Offset `off` into input section `i` after the content transforms
    /// that move bytes within it. `None` when the byte is gone.
    fn placed_off(&self, i: usize, off: u64) -> Option<u64> {
        if self.merge_of.contains_key(&i) {
            return Some(self.merge_remap(i, off));
        }
        match self.eh_of.get(&i) {
            Some(&e) => self.eh_frames[e].remap(off),
            None => Some(off),
        }
    }

    // ---------------------------------------------- shared imports

    /// Bind the references no input defines against the shared
    /// libraries named on the command line. Each binding takes a
    /// `.dynsym` entry and a GOT slot; one a call reaches also takes a
    /// PLT stub, since a call site holds a displacement rather than a
    /// slot to load through.
    fn build_imports(&mut self) {
        if self.opts.shared_libs.is_empty() {
            return;
        }
        // The script's own definitions satisfy a reference on their
        // own, whether or not a library exports the same name.
        let assigned = self
            .stmts
            .iter()
            .filter_map(|st| match st {
                Stmt::Assign(a) => Some(a),
                _ => None,
            })
            .chain(self.outs.iter().flat_map(|o| {
                o.pieces.iter().filter_map(|p| match p {
                    Piece::Assign(a) => Some(a),
                    _ => None,
                })
            }));
        let script_defined: HashSet<&str> = assigned
            .map(|a| a.symbol.as_str())
            .filter(|s| *s != ".")
            .collect();
        let mut names: BTreeSet<&str> = BTreeSet::new();
        for o in &self.objects {
            for s in &o.symbols {
                if s.binding() != STB_LOCAL
                    && s.shndx as u16 == SHN_UNDEF
                    && !s.name.is_empty()
                    && !self.globals.contains_key(&s.name)
                    && !script_defined.contains(s.name.as_str())
                    && self
                        .opts
                        .shared_libs
                        .iter()
                        .any(|l| l.lib.exports.contains(&s.name))
                {
                    names.insert(&s.name);
                }
            }
        }
        let mut called: BTreeSet<&str> = BTreeSet::new();
        for o in &self.objects {
            for sec in &o.sections {
                for r in &sec.relocs {
                    let Some(sym) = o.symbols.get(r.sym as usize) else {
                        continue;
                    };
                    if reloc_needs_plt(self.machine, r.rtype)
                        && names.contains(sym.name.as_str())
                        && !self.is_data_export(&sym.name)
                    {
                        called.insert(&sym.name);
                    }
                }
            }
        }
        self.imports = names.iter().map(|s| String::from(*s)).collect();
        self.plt_syms = called.iter().map(|s| String::from(*s)).collect();
        self.import_of = index_map(&self.imports);
        self.plt_of = index_map(&self.plt_syms);
    }

    /// `.dynsym` index of an imported symbol. Imports sit right after
    /// the null entry, in their own order.
    fn dynsym_index(&self, name: &str) -> u32 {
        self.import_of.get(name).map_or(0, |&k| 1 + k as u32)
    }

    /// True when a shared library exports `name` as a data object, so a
    /// reference must reach the object itself rather than a PLT stub.
    fn is_data_export(&self, name: &str) -> bool {
        self.opts
            .shared_libs
            .iter()
            .any(|l| l.lib.data_exports.contains(name))
    }

    /// Address a reference to an imported symbol resolves to: its PLT
    /// stub for a call, its GOT slot for a load through one.
    fn import_target(&self, name: &str, rtype: u32) -> Option<u64> {
        if !self.import_of.contains_key(name) {
            return None;
        }
        if reloc_needs_plt(self.machine, rtype) {
            let k = *self.plt_of.get(name)?;
            return Some(self.synth_addr(SYNTH_PLT)? + k as u64 * PLT_ENTRY_SIZE);
        }
        if reloc_uses_got(self.machine, rtype) {
            let k = *self.got_map.get(name)?;
            return Some(self.got_slot_base()? + k as u64 * self.class.addr_size());
        }
        None
    }

    /// PLT stub bytes: each jumps through its symbol's GOT slot, which
    /// the loader fills from the `GLOB_DAT` entry naming the symbol.
    /// Lazy binding would need a `.rela.plt` the loader walks on
    /// demand; these bind at load time.
    fn plt_bytes(&self) -> Vec<u8> {
        let (Some(plt), Some(got)) = (self.synth_addr(SYNTH_PLT), self.got_slot_base()) else {
            return Vec::new();
        };
        let slot_size = self.class.addr_size();
        let mut out = Vec::with_capacity(self.plt_syms.len() * PLT_ENTRY_SIZE as usize);
        for (k, name) in self.plt_syms.iter().enumerate() {
            let at = plt + k as u64 * PLT_ENTRY_SIZE;
            let slot = got + *self.got_map.get(name).unwrap_or(&0) as u64 * slot_size;
            out.extend_from_slice(&plt_entry(self.machine, at, slot));
        }
        out
    }

    // ----------------------------------------------- .eh_frame CIEs

    /// Merge the CIEs of the `.eh_frame` inputs of one output section,
    /// as bfd's `elf-eh-frame.c` does: the first copy in output order
    /// stays and the FDEs of every dropped copy name it instead. Two
    /// CIEs are one when the bytes after their length field and the
    /// relocations covering them agree; bfd compares a CIE's parsed
    /// fields and the symbol its personality resolves to, and those
    /// follow from byte and relocation equality.
    fn build_eh_frame_dedup(&mut self) {
        let mut order: BTreeMap<usize, Vec<usize>> = BTreeMap::new();
        for oi in 0..self.outs.len() {
            for p in &self.outs[oi].pieces {
                let Piece::Inputs(v) = p else { continue };
                for &i in v {
                    let s = self.insec(i);
                    if s.name == OUT_EH_FRAME && s.shtype == SHT_PROGBITS && s.size != 0 {
                        order.entry(oi).or_default().push(i);
                    }
                }
            }
        }
        let mut built: Vec<(usize, EhFrame)> = Vec::new();
        for inputs in order.values() {
            let mut canon: HashMap<CieKey, (usize, u64)> = HashMap::new();
            for &i in inputs {
                if let Some(f) = self.dedup_eh_frame(i, &mut canon) {
                    built.push((i, f));
                }
            }
        }
        for (i, f) in built {
            self.eh_of.insert(i, self.eh_frames.len());
            self.eh_frames.push(f);
        }
    }

    /// Whether the first relocated field in `[off, off + len)` of
    /// input section `i` names a definition that leaves the link. In
    /// an FDE that field is the initial location, which is what
    /// decides whether the entry still describes anything.
    fn covers_discarded(&self, i: usize, off: usize, len: usize) -> bool {
        let id = self.insecs[i];
        let o = &self.objects[id.obj];
        o.sections[id.sec]
            .relocs
            .iter()
            .filter(|r| (r.offset as usize) >= off && (r.offset as usize) < off + len)
            .min_by_key(|r| r.offset)
            .is_some_and(|r| self.defines_discarded(id.obj, r.sym as usize))
    }

    fn defines_discarded(&self, oi: usize, si: usize) -> bool {
        let Some(sym) = self.objects[oi].symbols.get(si) else {
            return false;
        };
        let (doi, dsi) = if sym.binding() != STB_LOCAL && !sym.name.is_empty() {
            match self.globals.get(&sym.name) {
                Some(&d) => d,
                None => return self.dropped_home(oi, sym).is_some(),
            }
        } else {
            (oi, si)
        };
        let home = &self.objects[doi].symbols[dsi].shndx;
        match self.objects[doi].shndx_map.get(home) {
            Some(&sec) => self.fates[self.insec_index(doi, sec)] == SecFate::Discarded,
            None => false,
        }
    }

    /// Rewrite one `.eh_frame` input against the CIEs already seen in
    /// its output section, registering its own. `None` when it keeps
    /// every CIE, which leaves its bytes and offsets untouched.
    fn dedup_eh_frame(
        &self,
        i: usize,
        canon: &mut HashMap<CieKey, (usize, u64)>,
    ) -> Option<EhFrame> {
        let id = self.insecs[i];
        let o = &self.objects[id.obj];
        let data = o.section_data(&o.sections[id.sec]);
        let ents = eh_frame::entries(data).ok()?;
        let mut bytes: Vec<u8> = Vec::with_capacity(data.len());
        let mut kept: Vec<(u64, u64, u64)> = Vec::new();
        let mut fdes: Vec<(u64, usize, u64)> = Vec::new();
        // Input offset of each CIE -> the copy that survives.
        let mut cies: HashMap<usize, (usize, u64)> = HashMap::new();
        let mut dropped = false;
        for e in &ents {
            // An FDE describing code that left the link describes
            // nothing; bfd drops the entry rather than relocate it.
            if e.cie.is_some() && self.covers_discarded(i, e.off, e.len) {
                dropped = true;
                continue;
            }
            match e.cie {
                None => {
                    let here = (i, bytes.len() as u64);
                    let seen = *canon.entry(self.cie_key(i, data, e)).or_insert(here);
                    cies.insert(e.off, seen);
                    if seen != here {
                        dropped = true;
                        continue;
                    }
                }
                Some(at) => fdes.push({
                    let (sec, off) = *cies.get(&at)?;
                    (bytes.len() as u64, sec, off)
                }),
            }
            kept.push((e.off as u64, e.len as u64, bytes.len() as u64));
            bytes.extend_from_slice(&data[e.off..e.off + e.len]);
        }
        // Whatever follows the last entry (a terminator, padding) is
        // not addressed by any of them and carries over verbatim.
        let tail = ents.last().map_or(0, |e| e.off + e.len);
        kept.push((tail as u64, (data.len() - tail) as u64, bytes.len() as u64));
        bytes.extend_from_slice(&data[tail..]);
        // An entry stream stopping short of the section's alignment
        // would leave the padding before the next input inside the
        // linked stream, where a zero length ends it. bfd gives the
        // padding to the last entry instead; so does this.
        let align = self.insec(i).addralign.max(1) as usize;
        let padded = tail == data.len() && kept.len() > 1 && !bytes.len().is_multiple_of(align);
        if padded {
            let at = kept[kept.len() - 2].2 as usize;
            let pad = align - bytes.len() % align;
            let len = u32::from_le_bytes(bytes[at..at + 4].try_into().ok()?) + pad as u32;
            bytes[at..at + 4].copy_from_slice(&len.to_le_bytes());
            bytes.resize(bytes.len() + pad, 0);
        }
        if !dropped && !padded {
            return None;
        }
        Some(EhFrame {
            orig_size: data.len() as u64,
            bytes,
            kept,
            fdes,
        })
    }

    fn cie_key(&self, i: usize, data: &[u8], e: &eh_frame::Entry) -> CieKey {
        let id = self.insecs[i];
        let s = &self.objects[id.obj].sections[id.sec];
        let (start, end) = (e.off as u64, (e.off + e.len) as u64);
        let relocs = s
            .relocs
            .iter()
            .filter(|r| r.offset >= start && r.offset < end)
            .map(|r| {
                // A local symbol is named by nothing an object outside
                // its own can match, so it keeps the CIE to itself.
                let sym = &self.objects[id.obj].symbols[r.sym as usize];
                let name = match sym.binding() {
                    STB_LOCAL => format!("{}:{}", id.obj, r.sym),
                    _ => sym.name.clone(),
                };
                (r.offset - start, r.rtype, name, r.addend)
            })
            .collect();
        CieKey {
            bytes: data[e.off + 4..e.off + e.len].to_vec(),
            relocs,
        }
    }

    /// Point every FDE of a rewritten input at the CIE that survived.
    /// The field holds the distance back from itself to the CIE, so it
    /// settles only once both have been placed.
    fn patch_eh_frame(&self, contents: &mut HashMap<usize, Vec<u8>>) {
        for (&i, &e) in &self.eh_of {
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            let Some(buf) = contents.get_mut(&out) else {
                continue;
            };
            let base = self.placements[i].off;
            for &(fde, cie_sec, cie_off) in &self.eh_frames[e].fdes {
                let field = base + fde + eh_frame::CIE_POINTER as u64;
                let cie = self.placements[cie_sec].off + cie_off;
                let (Some(v), true) = (
                    field.checked_sub(cie).and_then(|d| u32::try_from(d).ok()),
                    field + 4 <= buf.len() as u64,
                ) else {
                    continue;
                };
                buf[field as usize..field as usize + 4].copy_from_slice(&v.to_le_bytes());
            }
        }
    }

    // --------------------------------------------------------- layout

    fn run(&mut self) -> Result<LdsResult, C5Error> {
        let mut converged = false;
        // Each round settles the layout for the current header count,
        // then measures the count that layout produces.
        for _round in 0..4 {
            let mut prev_fingerprint: Option<Vec<u64>> = None;
            converged = false;
            for _pass in 0..48 {
                self.layout_pass(false)?;
                let fp = self.fingerprint();
                if prev_fingerprint.as_ref() == Some(&fp) {
                    converged = true;
                    break;
                }
                prev_fingerprint = Some(fp);
            }
            if !converged {
                break;
            }
            let order = self.kept_order();
            let n = self.build_phdrs(&order)?.len();
            if n == self.phdr_count_estimate() {
                break;
            }
            self.phdrs = n;
        }
        if !converged {
            return Err(err("script layout did not converge"));
        }
        self.layout_pass(true)?;
        if !self.errors.is_empty() {
            return Err(err(&self.errors.join("\n")));
        }
        if !self.undefined.is_empty() {
            let list: Vec<String> = self
                .undefined
                .iter()
                .take(30)
                .map(|s| format!("  undefined reference to `{s}'"))
                .collect();
            let extra = if self.undefined.len() > 30 {
                format!("\n  ... {} undefined symbols total", self.undefined.len())
            } else {
                String::new()
            };
            return Err(err(&format!("{}{}", list.join("\n"), extra)));
        }
        let res = self.finish()?;
        // Writing the image can fail on its own: an `.eh_frame` the FDE
        // scan cannot read, or a synthesized table that outgrew the
        // section sized for it.
        if !self.errors.is_empty() {
            return Err(err(&self.errors.join("\n")));
        }
        Ok(res)
    }

    fn fingerprint(&self) -> Vec<u64> {
        let mut fp: Vec<u64> = Vec::with_capacity(self.outs.len() * 3 + self.script_now.len());
        for o in &self.outs {
            fp.push(o.addr);
            fp.push(o.size);
            fp.push(o.lma);
        }
        // Script symbols in name order for a stable fingerprint.
        let mut names: Vec<&String> = self.script_now.keys().collect();
        names.sort();
        for n in names {
            fp.push(self.script_now[n].val.v);
        }
        fp.push(self.dyn_relas.len() as u64);
        fp.push(self.relr_addrs.len() as u64);
        fp.push(self.got_slots.len() as u64);
        fp
    }

    fn layout_pass(&mut self, final_pass: bool) -> Result<(), C5Error> {
        self.final_pass = final_pass;
        // Dynamic machinery is sized from the previous pass's state:
        // its placement (the `placed` flags and offsets still hold) and
        // its script symbols, which the dynamic tables carry. Both are
        // reset below, so this runs first. Skipped in effect on the
        // first pass, where no placement exists yet -- the tables start
        // empty and gain their size once a pass has run.
        self.size_dynamic_sections();
        self.size_eh_frame_hdr();
        self.script_prev = core::mem::take(&mut self.script_now);
        for p in &mut self.placements {
            p.placed = false;
        }
        self.dot = 0;
        self.cur_out = None;
        self.dot_section = None;
        self.prefer_next = false;
        self.cur_stmt = 0;
        self.found_end = false;
        // Values persist across passes: a statement before its
        // section's visit this pass sees the previous pass's flag, as
        // ld's phases do.
        self.after_end.resize(self.outs.len(), false);
        self.lma_delta = 0;
        self.errors.clear();
        self.undefined.clear();

        // File-level commands before SECTIONS.
        let mut sections_done = false;
        for cmd in &self.script.commands.clone() {
            match cmd {
                Command::Assign(a) => self.exec_assignment(a, sections_done),
                Command::Assert(e, m) => self.exec_assert(e, m),
                Command::Sections(_) => {
                    self.exec_sections()?;
                    sections_done = true;
                }
                _ => {}
            }
        }
        Ok(())
    }

    fn exec_sections(&mut self) -> Result<(), C5Error> {
        for si in 0..self.stmts.len() {
            self.cur_stmt = si;
            match self.stmts[si].clone() {
                Stmt::Assign(a) => {
                    // ld: a top-level assignment to dot makes following
                    // boundary symbols attach to the next section.
                    if a.symbol == "." {
                        self.prefer_next = true;
                    }
                    self.exec_assignment(&a, false)
                }
                Stmt::Assert(e, m) => self.exec_assert(&e, &m),
                Stmt::Open(oi) => {
                    self.after_end[oi] = self.found_end;
                    // A section already known empty never becomes the
                    // dot anchor (its sizes converged in earlier
                    // passes; `removed` itself settles only at finish).
                    if self.outs[oi].alloc
                        && self.outs[oi].size > 0
                        && self.outs[oi].name != "/DISCARD/"
                    {
                        self.dot_section = Some(oi);
                        self.prefer_next = false;
                    }
                    self.layout_out_section(oi)
                }
            }
        }
        Ok(())
    }

    fn layout_out_section(&mut self, oi: usize) {
        // Collect immutable inputs first.
        let (address, stype, at, align_attr, fill, pieces_len) = {
            let o = &self.outs[oi];
            (
                o.address.clone(),
                o.stype,
                o.at.clone(),
                o.align_attr.clone(),
                o.fill.clone(),
                o.pieces.len(),
            )
        };
        // Input-derived attributes.
        let mut in_flags = 0u64;
        let mut max_align = 1u64;
        let mut any_input = false;
        let mut all_nobits = true;
        let mut all_note = true;
        let mut entsizes: Vec<u64> = Vec::new();
        let mut in_flag_set: Vec<u64> = Vec::new();
        for pi in 0..pieces_len {
            if let Piece::Inputs(v) = &self.outs[oi].pieces[pi] {
                for &i in v.clone().iter() {
                    let s = self.insec(i);
                    any_input = true;
                    in_flags |= s.flags;
                    max_align = max_align.max(s.addralign);
                    if s.shtype != SHT_NOBITS {
                        all_nobits = false;
                    }
                    if s.shtype != SHT_NOTE {
                        all_note = false;
                    }
                    entsizes.push(s.entsize);
                    in_flag_set.push(s.flags);
                }
            }
        }
        let attr_align = align_attr
            .as_ref()
            .map(|e| self.eval(e).v)
            .unwrap_or(1)
            .max(1);
        let sec_align = max_align.max(attr_align);

        // Address 0 with non-alloc inputs (the debug-section idiom)
        // keeps the section out of the allocation flow; `(INFO)`
        // likewise.
        let explicit_zero = matches!(address, Some(Expr::Number(0)));
        let non_alloc_inputs = in_flags & SHF_ALLOC == 0;
        let info_type = stype == Some(OutputSectionType::Info);
        // An orphan takes its input's allocation: bfd creates the
        // output section from the input's flags, so a non-allocated
        // input never joins the load image.
        let orphan_non_alloc = self.outs[oi].orphan && non_alloc_inputs && any_input;
        let alloc = !info_type && !(explicit_zero && non_alloc_inputs) && !orphan_non_alloc;

        let addr = if let Some(ae) = &address {
            let v = self.eval(ae).v;
            if alloc {
                self.dot = v;
            }
            v
        } else if alloc {
            self.dot = align_up(self.dot, sec_align);
            self.dot
        } else {
            0
        };

        let saved_dot = self.dot;
        let start = if alloc { self.dot } else { addr };
        self.cur_out = Some(oi);
        self.outs[oi].addr = start;

        let mut off: u64 = 0;
        let mut end: u64 = 0;
        let mut chunks: Vec<(u64, u64, ChunkSrc)> = Vec::new();
        let mut fill_bytes: Option<Vec<u8>> = fill.as_ref().map(|e| {
            let v = self.eval(e).v;
            fill_pattern(v)
        });
        let code = self.section_input_flags(oi) & SHF_EXECINSTR != 0;
        let machine = self.machine;
        let mut file_bytes = false;
        for pi in 0..pieces_len {
            match self.outs[oi].pieces[pi].clone() {
                Piece::Inputs(v) => {
                    for &i in &v {
                        // A merged-away member (not its pool's
                        // representative) contributes no bytes and no
                        // alignment: its storage lives in the pool rep.
                        if let Some(&pl) = self.merge_of.get(&i)
                            && self.pools[pl].rep != i
                        {
                            self.placements[i] = Placement {
                                out: oi,
                                off,
                                placed: true,
                            };
                            continue;
                        }
                        let (a, sz, nobits) = {
                            let s = self.insec(i);
                            let a = if let Some(&pl) = self.merge_of.get(&i) {
                                self.pools[pl].align
                            } else {
                                s.addralign.max(1)
                            };
                            (a, self.insec_placed_size(i), s.shtype == SHT_NOBITS)
                        };
                        let aligned = align_up(off, a);
                        if aligned > off {
                            if !nobits && !all_nobits {
                                let len = aligned - off;
                                let pad = pad_bytes(&fill_bytes, machine, code, len);
                                chunks.push((off, len, ChunkSrc::Pad(pad)));
                            }
                            off = aligned;
                        }
                        self.placements[i] = Placement {
                            out: oi,
                            off,
                            placed: true,
                        };
                        chunks.push((off, sz, ChunkSrc::Input(i)));
                        if !nobits && sz > 0 {
                            file_bytes = true;
                        }
                        off += sz;
                        end = end.max(off);
                        if alloc {
                            self.dot = start + off;
                        }
                    }
                }
                Piece::Assign(a) => {
                    self.exec_assignment(&a, false);
                    if alloc {
                        let new_off = self.dot.wrapping_sub(start);
                        if self.dot < start && self.final_pass {
                            self.errors.push(format!(
                                "cannot move location counter backwards in `{}'",
                                self.outs[oi].name
                            ));
                        } else {
                            if new_off > off && !all_nobits {
                                let len = new_off - off;
                                let pad = pad_bytes(&fill_bytes, machine, code, len);
                                chunks.push((off, len, ChunkSrc::Pad(pad)));
                            }
                            off = new_off;
                            end = end.max(off);
                        }
                    }
                }
                Piece::Assert(e, m) => self.exec_assert(&e, &m),
                Piece::Data(w, e) => {
                    let v = self.eval(&e).v;
                    let n = w.size() as usize;
                    let bytes = v.to_le_bytes()[..n].to_vec();
                    chunks.push((off, n as u64, ChunkSrc::Bytes(bytes)));
                    file_bytes = true;
                    off += n as u64;
                    end = end.max(off);
                    if alloc {
                        self.dot = start + off;
                    }
                }
                Piece::Fill(e) => {
                    let v = self.eval(&e).v;
                    fill_bytes = Some(fill_pattern(v));
                }
            }
        }
        let size = end;

        // Section classification: no file content at all makes
        // NOBITS (`.bss`-shape sections, `. +=` reservations); a
        // uniform SHT_NOTE membership keeps NOTE; everything else is
        // PROGBITS.
        let noload = stype == Some(OutputSectionType::NoLoad);
        let shtype = if size > 0 && !file_bytes && all_nobits {
            SHT_NOBITS
        } else if any_input && all_note {
            SHT_NOTE
        } else {
            SHT_PROGBITS
        };
        // A group is an input-side construct and its member index does
        // not survive the link, so bfd clears SHF_GROUP; the retain
        // flag describes the content and does survive. Link order is
        // a property of the whole output section, so bfd takes it from
        // the section opening the output and from no other.
        let mut flags = in_flags & !(SHF_GROUP | SHF_INFO_LINK | SHF_EXCLUDE | SHF_LINK_ORDER);
        if self
            .first_input(oi)
            .is_some_and(|i| self.insec(i).flags & SHF_LINK_ORDER != 0)
        {
            flags |= SHF_LINK_ORDER;
        }
        let uniform = !in_flag_set.is_empty()
            && in_flag_set.iter().all(|&f| f == in_flag_set[0])
            && entsizes.iter().all(|&e| e == entsizes[0]);
        let entsize = if uniform { entsizes[0] } else { 0 };
        if !uniform {
            flags &= !(SHF_MERGE | SHF_STRINGS);
        }
        if alloc && (any_input || file_bytes || size > 0) {
            flags |= SHF_ALLOC;
        }
        if !alloc {
            flags &= !SHF_ALLOC;
        }
        // RELA/RELR synthesized content keeps its own type.
        if self.outs[oi].name == self.dyn_reloc_name() && self.opts.emit == LdsEmit::Dyn && size > 0
        {
            // keep type from the synth input (SHT_RELA)
        }

        {
            let o = &mut self.outs[oi];
            o.size = size;
            o.align = sec_align;
            o.flags = flags;
            o.shtype = if noload { SHT_NOBITS } else { shtype };
            o.entsize = entsize;
            o.alloc = alloc;
            o.chunks = chunks;
            o.file_bytes = file_bytes;
            o.removed = false;
        }
        // Synth inputs give the output their type (RELA/RELR/NOTE).
        if let Some(t) = self.synth_out_type(oi) {
            self.outs[oi].shtype = t;
        }

        if alloc {
            self.dot = start + size;
            // LMA.
            let lma = if let Some(at) = &at {
                let v = self.eval_with_dot(at, start).v;
                self.lma_delta = v.wrapping_sub(start);
                v
            } else if self.lma_delta != 0 {
                start.wrapping_add(self.lma_delta)
            } else {
                start
            };
            self.outs[oi].lma = lma;
        } else {
            self.outs[oi].lma = self.outs[oi].addr;
            self.dot = saved_dot;
        }
        self.define_start_stop(oi);
        self.cur_out = None;
    }

    /// Every symbol the script assigns, at file scope, in the
    /// statement stream, or inside an output section.
    fn collect_script_assigned(&mut self) {
        let mut out: HashSet<String> = HashSet::new();
        for c in &self.script.commands {
            if let Command::Assign(a) = c {
                out.insert(a.symbol.clone());
            }
        }
        for st in &self.stmts {
            if let Stmt::Assign(a) = st {
                out.insert(a.symbol.clone());
            }
        }
        for o in &self.outs {
            for p in &o.pieces {
                if let Piece::Assign(a) = p {
                    out.insert(a.symbol.clone());
                }
            }
        }
        self.script_assigned = out;
    }

    /// Bound an output section whose name is a C identifier with
    /// `__start_<name>` / `__stop_<name>`, as bfd's
    /// `lang_init_start_stop` does. Both follow PROVIDE's rule -- a
    /// referenced, otherwise-undefined name only -- and take the
    /// section's binding and visibility, not the script-symbol
    /// defaults: GLOBAL PROTECTED, matching `-z
    /// start-stop-visibility`'s default.
    fn define_start_stop(&mut self, oi: usize) {
        let (name, addr, size, alloc) = {
            let o = &self.outs[oi];
            (o.name.clone(), o.addr, o.size, o.alloc)
        };
        if !alloc || !is_c_identifier(&name) {
            return;
        }
        for (prefix, value) in [("__start_", addr), ("__stop_", addr + size)] {
            let sym = alloc::format!("{prefix}{name}");
            if self.globals.contains_key(&sym)
                || self.script_assigned.contains(&sym)
                || !self.referenced.contains(&sym)
            {
                continue;
            }
            self.script_now.insert(
                sym,
                ScriptSym {
                    val: Val {
                        v: value,
                        att: Att::Out(oi),
                    },
                    hidden: false,
                    kind: STT_NOTYPE,
                    final_out: Some(oi),
                    vis: Some(STV_PROTECTED),
                },
            );
        }
    }

    fn synth_out_type(&self, oi: usize) -> Option<u32> {
        for p in &self.outs[oi].pieces {
            if let Piece::Inputs(v) = p {
                for &i in v {
                    let id = self.insecs[i];
                    if id.obj == self.synth_obj {
                        let t = self.objects[id.obj].sections[id.sec].shtype;
                        if matches!(
                            t,
                            SHT_RELA
                                | SHT_RELR
                                | SHT_STRTAB
                                | dynamic::SHT_HASH
                                | dynamic::SHT_DYNAMIC
                                | dynamic::SHT_DYNSYM
                                | dynamic::SHT_GNU_HASH
                                | dynamic::SHT_GNU_VERDEF
                                | dynamic::SHT_GNU_VERSYM
                        ) {
                            return Some(t);
                        }
                    }
                }
            }
        }
        None
    }

    // ---------------------------------------------------- assignments

    fn exec_assignment(&mut self, a: &Assignment, after_sections: bool) {
        if a.symbol == "." {
            let v = self.eval(&a.value).v;
            let new = self.apply_assign_op(self.dot, a.op, v);
            if after_sections {
                return; // `. = ASSERT(...)` after SECTIONS: check only
            }
            self.dot = new;
            return;
        }
        if a.provide {
            // PROVIDE defines only referenced, otherwise-undefined
            // symbols; an inactive PROVIDE never evaluates its value.
            if self.globals.contains_key(&a.symbol) || !self.referenced.contains(&a.symbol) {
                return;
            }
            // An active PROVIDE's expression references what it names,
            // so a chain of them resolves on the following pass.
            collect_symbols(&a.value, &mut self.referenced);
        }
        if a.symbol.trim_start_matches('_') == "end" {
            self.found_end = true;
        }
        let cur = self.lookup(&a.symbol);
        let rhs = self.eval(&a.value);
        let value = match a.op {
            AssignOp::Set => rhs,
            _ => {
                let base = cur.map(|v| v.v).unwrap_or(0);
                Val {
                    v: self.apply_assign_op(base, a.op, rhs.v),
                    att: rhs.att,
                }
            }
        };
        // Computed every pass: the dynamic-fixup sizing consults the
        // previous pass's table before the final one runs.
        let final_out = if value.att == Att::DotAbs {
            self.section_for_dot()
        } else {
            None
        };
        let kind = self.assigned_sym_type(a);
        self.script_now.insert(
            a.symbol.clone(),
            ScriptSym {
                val: value,
                hidden: a.hidden,
                kind,
                final_out,
                vis: None,
            },
        );
    }

    /// Type a script-defined symbol takes from its expression. bfd
    /// copies the source symbol's type when the expression names one
    /// symbol and nothing else (ldexp.c's `expld.assign_src`, applied
    /// through `bfd_copy_link_hash_symbol_type`); a compound
    /// expression leaves the symbol untyped. An operator assignment
    /// reads the destination, so it names that symbol too.
    fn assigned_sym_type(&self, a: &Assignment) -> u8 {
        let mut names: HashSet<String> = HashSet::new();
        collect_symbols(&a.value, &mut names);
        if a.op != AssignOp::Set {
            names.insert(a.symbol.clone());
        }
        if names.len() != 1 {
            return STT_NOTYPE;
        }
        let Some(name) = names.iter().next() else {
            return STT_NOTYPE;
        };
        match self.globals.get(name) {
            Some(&(oi, si)) => self.objects[oi].symbols[si].kind(),
            None => STT_NOTYPE,
        }
    }

    /// ld's section_for_dot: the symtab section for a symbol assigned
    /// from the location counter outside any output section.
    /// Assignments attach to the previous allocated section, except
    /// that after a top-level dot assignment (or before any section)
    /// they attach to the section following the statement; past the
    /// `end` assignment the previous section wins again. The walks
    /// skip removed and non-allocated sections.
    fn section_for_dot(&self) -> Option<usize> {
        // `removed` is only settled after the last pass; an empty
        // section is already known stripped here (sizes converged).
        let stripped = |oi: usize| self.outs[oi].size == 0 || self.outs[oi].name == "/DISCARD/";
        let is_alloc =
            |oi: usize| self.outs[oi].alloc && !stripped(oi) && self.outs[oi].flags & SHF_TLS == 0;
        let opens: Vec<usize> = self
            .stmts
            .iter()
            .filter_map(|s| match s {
                Stmt::Open(oi) => Some(*oi),
                _ => None,
            })
            .collect();
        if self.dot_section.is_none() || self.prefer_next {
            let mut nxt = self
                .stmts
                .iter()
                .skip(self.cur_stmt + 1)
                .filter_map(|s| match s {
                    Stmt::Open(oi) => Some(*oi),
                    _ => None,
                })
                .peekable();
            let mut os = nxt.next();
            while let Some(o) = os {
                if !self.after_end[o] && stripped(o) {
                    os = nxt.next();
                } else {
                    break;
                }
            }
            if self.dot_section.is_none() || os.is_none_or(|o| !self.after_end[o]) {
                // Walk backward from the found section (or the last
                // one) to the nearest allocated section.
                let start = match os {
                    Some(o) => opens.iter().position(|&x| x == o)?,
                    None => opens.len().checked_sub(1)?,
                };
                return opens[..=start].iter().rev().copied().find(|&o| is_alloc(o));
            }
        }
        let s = self.dot_section?;
        let pos = opens.iter().position(|&x| x == s)?;
        if let Some(o) = opens[..=pos].iter().rev().copied().find(|&o| is_alloc(o)) {
            return Some(o);
        }
        opens.iter().copied().find(|&o| is_alloc(o))
    }

    fn apply_assign_op(&self, base: u64, op: AssignOp, v: u64) -> u64 {
        match op {
            AssignOp::Set => v,
            AssignOp::Add => base.wrapping_add(v),
            AssignOp::Sub => base.wrapping_sub(v),
            AssignOp::Mul => base.wrapping_mul(v),
            AssignOp::Div => {
                if v == 0 {
                    0
                } else {
                    ((base as i64) / (v as i64)) as u64
                }
            }
            AssignOp::Shl => base.wrapping_shl(v as u32),
            AssignOp::Shr => base.wrapping_shr(v as u32),
            AssignOp::And => base & v,
            AssignOp::Or => base | v,
        }
    }

    fn exec_assert(&mut self, e: &Expr, msg: &str) {
        let v = self.eval(e);
        if self.final_pass && v.v == 0 {
            self.errors.push(format!("assertion failed: {msg}"));
        }
    }

    // ----------------------------------------------------- evaluation

    fn lookup(&mut self, name: &str) -> Option<Val> {
        if name == "." {
            // Inside an output section dot is section-relative;
            // outside it is absolute and marks the evaluation so a
            // defined symbol can still pick up a symtab section
            // through section_for_dot.
            let att = match self.cur_out {
                Some(o) => Att::Out(o),
                None => Att::DotAbs,
            };
            return Some(Val { v: self.dot, att });
        }
        if let Some(s) = self.script_now.get(name) {
            return Some(s.val.as_reference());
        }
        if let Some(&(oi, si)) = self.globals.get(name)
            && let Some(v) = self.object_sym_val(oi, si)
        {
            return Some(v);
        }
        if let Some(s) = self.script_prev.get(name) {
            return Some(s.val.as_reference());
        }
        None
    }

    /// Value of a defined object symbol under the current pass's
    /// placement (falling back to the previous pass for sections not
    /// yet placed this pass).
    fn object_sym_val(&self, oi: usize, si: usize) -> Option<Val> {
        let sym = &self.objects[oi].symbols[si];
        match sym.shndx as u16 {
            SHN_ABS => Some(Val::abs(sym.value)),
            SHN_UNDEF | SHN_COMMON => None,
            _ => {
                let sec = *self.objects[oi].shndx_map.get(&sym.shndx)?;
                let i = self.insec_index(oi, sec);
                match self.fates[i] {
                    SecFate::Placed { out } => {
                        // Sections placed earlier in this pass carry
                        // exact values; later ones fall back to the
                        // previous pass's placement, which matches at
                        // convergence.
                        let off = self.placed_off(i, sym.value)?;
                        let base = if let Some(&pl) = self.merge_of.get(&i) {
                            self.placements[self.pools[pl].rep].off
                        } else {
                            self.placements[i].off
                        };
                        Some(Val {
                            v: self.outs[out].addr.wrapping_add(base).wrapping_add(off),
                            att: Att::Out(out),
                        })
                    }
                    _ => None,
                }
            }
        }
    }

    fn eval(&mut self, e: &Expr) -> Val {
        self.eval_with_dot(e, self.dot)
    }

    fn eval_with_dot(&mut self, e: &Expr, dot: u64) -> Val {
        let saved = self.dot;
        self.dot = dot;
        let v = self.eval_inner(e);
        self.dot = saved;
        v
    }

    fn eval_inner(&mut self, e: &Expr) -> Val {
        match e {
            Expr::Number(n) => Val::abs(*n),
            Expr::Symbol(name) => match self.lookup(name) {
                Some(v) => v,
                // `CONSTANT(...)` lowers to these names.
                None if name == "MAXPAGESIZE" => Val::abs(self.opts.max_page_size),
                None if name == "COMMONPAGESIZE" => Val::abs(self.common_page_size()),
                None => {
                    if self.final_pass {
                        self.undefined.insert(name.clone());
                    }
                    Val::abs(0)
                }
            },
            Expr::Unary(op, a) => {
                let a = self.eval_inner(a);
                let v = match op {
                    UnOp::Neg => a.v.wrapping_neg(),
                    UnOp::Not => (a.v == 0) as u64,
                    UnOp::BitNot => !a.v,
                };
                Val::abs(v)
            }
            Expr::Binary(op, a, b) => {
                let (a, b) = (self.eval_inner(a), self.eval_inner(b));
                let v = match op {
                    BinOp::Add => a.v.wrapping_add(b.v),
                    BinOp::Sub => a.v.wrapping_sub(b.v),
                    BinOp::Mul => a.v.wrapping_mul(b.v),
                    BinOp::Div => {
                        if b.v == 0 {
                            if self.final_pass {
                                self.errors.push("division by zero in script".to_string());
                            }
                            0
                        } else {
                            ((a.v as i64) / (b.v as i64)) as u64
                        }
                    }
                    BinOp::Rem => {
                        if b.v == 0 {
                            0
                        } else {
                            ((a.v as i64) % (b.v as i64)) as u64
                        }
                    }
                    BinOp::Shl => a.v.wrapping_shl(b.v as u32),
                    BinOp::Shr => a.v.wrapping_shr(b.v as u32),
                    BinOp::Eq => (a.v == b.v) as u64,
                    BinOp::Ne => (a.v != b.v) as u64,
                    BinOp::Lt => (a.v < b.v) as u64,
                    BinOp::Le => (a.v <= b.v) as u64,
                    BinOp::Gt => (a.v > b.v) as u64,
                    BinOp::Ge => (a.v >= b.v) as u64,
                    BinOp::BitAnd => a.v & b.v,
                    BinOp::BitOr => a.v | b.v,
                    BinOp::BitXor => a.v ^ b.v,
                    BinOp::LogAnd => ((a.v != 0) && (b.v != 0)) as u64,
                    BinOp::LogOr => ((a.v != 0) || (b.v != 0)) as u64,
                };
                // Section-relative + absolute keeps the section;
                // difference of two section values is absolute.
                let att = match (op, a.att, b.att) {
                    (BinOp::Add, Att::Out(s), Att::Abs) => Att::Out(s),
                    (BinOp::Add, Att::Abs, Att::Out(s)) => Att::Out(s),
                    (BinOp::Sub, Att::Out(s), Att::Abs) => Att::Out(s),
                    // A dot address plus/minus a number stays a dot
                    // address; any other combination is a number.
                    (BinOp::Add, Att::DotAbs, Att::Abs) => Att::DotAbs,
                    (BinOp::Add, Att::Abs, Att::DotAbs) => Att::DotAbs,
                    (BinOp::Sub, Att::DotAbs, Att::Abs) => Att::DotAbs,
                    _ => Att::Abs,
                };
                Val { v, att }
            }
            Expr::Ternary(c, t, f) => {
                let c = self.eval_inner(c);
                if c.v != 0 {
                    self.eval_inner(t)
                } else {
                    self.eval_inner(f)
                }
            }
            Expr::AlignDot(a) => {
                let a = self.eval_inner(a);
                let att = match self.cur_out {
                    Some(o) => Att::Out(o),
                    None => Att::DotAbs,
                };
                Val {
                    v: align_up(self.dot, a.v),
                    att,
                }
            }
            Expr::Align2(v, a) => {
                let (v, a) = (self.eval_inner(v), self.eval_inner(a));
                Val {
                    v: align_up(v.v, a.v),
                    att: v.att,
                }
            }
            Expr::Absolute(a) => Val::abs(self.eval_inner(a).v),
            Expr::Addr(name) => match self.find_out(name) {
                Some(oi) => Val {
                    v: self.outs[oi].addr,
                    att: Att::Out(oi),
                },
                None => {
                    if self.final_pass {
                        self.errors
                            .push(format!("ADDR({name}): no such output section"));
                    }
                    Val::abs(0)
                }
            },
            Expr::Loadaddr(name) => match self.find_out(name) {
                Some(oi) => Val::abs(self.outs[oi].lma),
                None => {
                    if self.final_pass {
                        self.errors
                            .push(format!("LOADADDR({name}): no such output section"));
                    }
                    Val::abs(0)
                }
            },
            Expr::Sizeof(name) => Val::abs(
                self.find_out(name)
                    .map(|oi| self.outs[oi].size)
                    .unwrap_or(0),
            ),
            Expr::Alignof(name) => Val::abs(
                self.find_out(name)
                    .map(|oi| self.outs[oi].align)
                    .unwrap_or(0),
            ),
            Expr::SizeofHeaders => {
                let phnum = self.phdr_count_estimate();
                Val::abs(self.class.ehdr_size() + phnum as u64 * self.class.phdr_size())
            }
            Expr::Defined(name) => {
                let defined = self.script_now.contains_key(name)
                    || self.script_prev.contains_key(name)
                    || self.globals.contains_key(name);
                Val::abs(defined as u64)
            }
            Expr::Min(a, b) => {
                let (a, b) = (self.eval_inner(a), self.eval_inner(b));
                Val::abs(a.v.min(b.v))
            }
            Expr::Max(a, b) => {
                let (a, b) = (self.eval_inner(a), self.eval_inner(b));
                Val::abs(a.v.max(b.v))
            }
            Expr::Assert(inner, msg) => {
                let v = self.eval_inner(inner);
                if self.final_pass && v.v == 0 {
                    self.errors.push(format!("assertion failed: {msg}"));
                }
                v
            }
        }
    }

    fn find_out(&self, name: &str) -> Option<usize> {
        self.outs.iter().position(|o| o.name == name)
    }

    /// Name, section type and entry size of the dynamic relocation
    /// table this target uses. i386 relocations carry implicit
    /// addends, so the table is `.rel.dyn`/`SHT_REL`.
    fn dyn_reloc_kind(&self) -> (&'static str, u32, u64) {
        if machine_uses_rela(self.machine) {
            (SYNTH_RELA, SHT_RELA, self.class.rela_size())
        } else {
            (SYNTH_REL, SHT_REL, self.class.rel_size())
        }
    }

    fn dyn_reloc_name(&self) -> &'static str {
        self.dyn_reloc_kind().0
    }

    /// bfd's `CONSTANT(COMMONPAGESIZE)`: 4 KiB on x86-64, 64 KiB on
    /// aarch64, and never above the configured maximum.
    fn common_page_size(&self) -> u64 {
        let common = if self.machine == EM_AARCH64 {
            0x10000
        } else {
            0x1000
        };
        common.min(self.opts.max_page_size)
    }

    /// Relocation types the dynamic tables are built from: the
    /// address-width absolute form the input uses, and the load-time
    /// forms bfd rewrites it to.
    fn dyn_reloc_types(&self) -> (u32, u32, u32) {
        match self.machine {
            EM_AARCH64 => (
                rt::R_AARCH64_ABS64,
                rt::R_AARCH64_RELATIVE,
                rt::R_AARCH64_GLOB_DAT,
            ),
            EM_386 => (rt::R_386_32, rt::R_386_RELATIVE, rt::R_386_GLOB_DAT),
            _ => (
                rt::R_X86_64_64,
                rt::R_X86_64_RELATIVE,
                rt::R_X86_64_GLOB_DAT,
            ),
        }
    }

    /// Output sections the writer will emit, in statement order. The
    /// same selection `finish` makes, without settling anything.
    fn kept_order(&self) -> Vec<usize> {
        self.stmts
            .iter()
            .filter_map(|st| match st {
                Stmt::Open(oi) => Some(*oi),
                _ => None,
            })
            .filter(|&oi| self.outs[oi].name != "/DISCARD/" && self.outs[oi].size != 0)
            .collect()
    }

    /// What `SIZEOF_HEADERS` counts. A `PHDRS` command states it; the
    /// default segment set is measured from a settled layout and fed
    /// back, since a script places its first section past the headers
    /// and a count short of the truth leaves that section below them.
    fn phdr_count_estimate(&self) -> usize {
        self.script.phdrs().map(|p| p.len()).unwrap_or(self.phdrs)
    }

    // -------------------------------------------- dynamic reloc sizing

    /// Compute the ET_DYN dynamic-relocation payload (RELA + RELR) and
    /// GOT slots from the previous pass's layout, updating the
    /// synthetic input sections' sizes for this pass.
    fn size_dynamic_sections(&mut self) {
        if self.opts.emit != LdsEmit::Dyn {
            return;
        }
        self.dyn_relas.clear();
        self.relr_addrs.clear();
        // GOT slot set stays stable across passes (driven by reloc
        // types alone), so compute it once.
        if self.got_slots.is_empty() && self.got_map.is_empty() {
            // Every import loads through a slot the loader fills, so
            // each takes one whether or not an input names the GOT.
            let mut slots: Vec<String> = self.imports.clone();
            let mut map: HashMap<String, usize> = index_map(&slots);
            for i in 0..self.insecs.len() {
                let SecFate::Placed { .. } = self.fates[i] else {
                    continue;
                };
                let id = self.insecs[i];
                for r in &self.objects[id.obj].sections[id.sec].relocs {
                    if matches!(
                        r.rtype,
                        rt::R_AARCH64_ADR_GOT_PAGE | rt::R_AARCH64_LD64_GOT_LO12_NC
                    ) {
                        let name = self.objects[id.obj].symbols[r.sym as usize].name.clone();
                        if name.is_empty() {
                            continue;
                        }
                        map.entry(name.clone()).or_insert_with(|| {
                            slots.push(name);
                            slots.len() - 1
                        });
                    }
                }
            }
            self.got_slots = slots;
            self.got_map = map;
        }
        // Collect absolute-64 sites in allocated output sections; each
        // becomes a RELATIVE entry. bfd packs a site into RELR when
        // its input offset is even and the input section's alignment
        // is above one (the output address parity then follows);
        // other sites keep RELA entries.
        let mut rel_addrs: Vec<(u64, i64, bool)> = Vec::new();
        let mut sym_relas: Vec<DynReloc> = Vec::new();
        let (abs_addr, relative, glob_dat) = self.dyn_reloc_types();
        for i in 0..self.insecs.len() {
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            if !self.outs[out].alloc || self.outs[out].removed {
                continue;
            }
            let p = self.placements[i];
            if !p.placed {
                continue;
            }
            let id = self.insecs[i];
            let base = self.outs[out].addr + p.off;
            let packable = self.objects[id.obj].sections[id.sec].addralign > 1;
            for r in &self.objects[id.obj].sections[id.sec].relocs {
                if r.rtype != abs_addr {
                    continue;
                }
                // Only a load-address (section-relative) target needs a
                // load-time RELATIVE fixup; an absolute constant does
                // not. An unresolved default-visibility weak reference
                // keeps a symbol-based entry, as bfd leaves its
                // resolution to load time.
                if !self.reloc_is_relative(id.obj, r.sym as usize) {
                    if self.undefweak_dynamic(id.obj, r.sym as usize) {
                        let name = &self.objects[id.obj].symbols[r.sym as usize].name;
                        sym_relas.push(DynReloc {
                            offset: base + r.offset,
                            rtype: abs_addr,
                            addend: r.addend,
                            sym: self.dynsym_index(name),
                        });
                    }
                    continue;
                }
                let target = self.resolve_sym_prevpass(id.obj, r.sym as usize, r.addend);
                let Some(target) = target else { continue };
                rel_addrs.push((
                    base + r.offset,
                    target as i64,
                    packable && r.offset % 2 == 0,
                ));
            }
        }
        // GOT slots are RELATIVE targets too; a slot for an unresolved
        // weak reference gets GLOB_DAT instead.
        let slot_size = self.class.addr_size();
        if let Some(got_base) = self.got_slot_base() {
            for (k, name) in self.got_slots.clone().iter().enumerate() {
                let slot = got_base + k as u64 * slot_size;
                if let Some(v) = self.resolve_name(name) {
                    rel_addrs.push((slot, v as i64, true));
                } else {
                    sym_relas.push(DynReloc {
                        offset: slot,
                        rtype: glob_dat,
                        addend: 0,
                        sym: self.dynsym_index(name),
                    });
                }
            }
        }
        rel_addrs.sort_by_key(|&(a, _, _)| a);
        let mut relas: Vec<DynReloc> = Vec::new();
        let mut relr: Vec<u64> = Vec::new();
        for (addr, addend, packable) in rel_addrs {
            if self.opts.pack_relative_relocs && packable {
                relr.push(addr);
            } else {
                relas.push(DynReloc {
                    offset: addr,
                    rtype: relative,
                    addend,
                    sym: 0,
                });
            }
        }
        relas.extend(sym_relas);
        relas.sort_by_key(|d| d.offset);
        let relr_words = encode_relr(&relr, self.class.addr_size());
        self.dyn_relas = relas;
        self.relr_addrs = relr;
        // Update synthetic section sizes.
        let nones = match self.dyn_nones {
            Some(n) => n,
            None => {
                let n = self.count_reserved_none_slots();
                self.dyn_nones = Some(n);
                n
            }
        };
        self.build_dyn_tables(&|_| 1);
        let dyn_sizes = self.dyn_table_sizes();
        // bfd reserves `_GLOBAL_OFFSET_TABLE_[0]` once the link either
        // needs a GOT slot or creates a `.dynamic` for the header to
        // point at; a link with neither leaves `.got` empty, which
        // scripts assert on. Where the header sits on `.got.plt`,
        // `.got` reserves nothing.
        let got_header = self.got_reserved() != 0
            && (!self.got_slots.is_empty() || self.kept_synth(SYNTH_DYNAMIC).is_some());
        let (rela_name, _, rela_ent) = self.dyn_reloc_kind();
        let slot = self.class.addr_size();
        let synth = self.synth_obj;
        for sec in &mut self.objects[synth].sections {
            if let Some(&size) = dyn_sizes.get(sec.name.as_str()) {
                sec.size = size;
                continue;
            }
            if sec.name == rela_name {
                sec.size = (nones + self.dyn_relas.len() as u64) * rela_ent;
                continue;
            }
            match sec.name.as_str() {
                SYNTH_RELR => sec.size = relr_words.len() as u64 * slot,
                SYNTH_GOT => {
                    let header = if got_header { slot } else { 0 };
                    sec.size = header + self.got_slots.len() as u64 * slot;
                }
                SYNTH_PLT => sec.size = self.plt_syms.len() as u64 * PLT_ENTRY_SIZE,
                _ => {}
            }
        }
    }

    /// `.eh_frame_hdr` holds one table entry per FDE that reached the
    /// output. The count comes from the input bytes, so it is settled
    /// before any address is.
    fn size_eh_frame_hdr(&mut self) {
        if !self.opts.eh_frame_hdr {
            return;
        }
        // Count over every input the `.eh_frame` output gathers, not
        // just those named `.eh_frame`: the writer scans that whole
        // output, and a script pulling `.eh_frame.*` into it would
        // otherwise size the table short of what it then writes.
        let mut fdes = 0usize;
        for i in 0..self.insecs.len() {
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            if self.outs[out].name != OUT_EH_FRAME {
                continue;
            }
            fdes += eh_frame::count_fdes(self.chunk_input_bytes(i));
        }
        let size = if fdes == 0 {
            0
        } else {
            eh_frame::HEADER_SIZE + fdes as u64 * eh_frame::ENTRY_SIZE
        };
        let synth = self.synth_obj;
        if let Some(sec) = self.objects[synth]
            .sections
            .iter_mut()
            .find(|s| s.name == SYNTH_EH_FRAME_HDR)
        {
            sec.size = size;
        }
    }

    /// Final address of a kept synthetic section.
    fn synth_addr(&self, name: &str) -> Option<u64> {
        let out = self.kept_synth(name)?;
        let sec = self.objects[self.synth_obj]
            .sections
            .iter()
            .position(|s| s.name == name)?;
        let i = self.insec_index(self.synth_obj, sec);
        Some(self.outs[out].addr + self.placements[i].off)
    }

    fn dyn_section_addr(&self) -> Option<u64> {
        self.synth_addr(SYNTH_DYNAMIC)
    }

    /// Index of the synthetic section `name`, when the script kept it.
    /// A script that routes it to `/DISCARD/` gets no table built.
    fn kept_synth(&self, name: &str) -> Option<usize> {
        let synth = self.synth_obj;
        let sec = self.objects[synth]
            .sections
            .iter()
            .position(|s| s.name == name)?;
        let i = self.insec_index(synth, sec);
        match self.fates[i] {
            SecFate::Placed { out } if self.outs[out].name != "/DISCARD/" => Some(out),
            _ => None,
        }
    }

    /// The version index the script assigns `name`, or `None` when the
    /// script makes it local. Exact patterns are consulted before
    /// wildcards, as bfd matches them.
    fn version_of(&self, name: &str) -> Option<u16> {
        let nodes = self.script.versions().unwrap_or(&[]);
        if nodes.is_empty() {
            return Some(dynamic::VER_NDX_GLOBAL);
        }
        let mut ndx: u16 = 1;
        let mut wildcard: Option<Option<u16>> = None;
        for n in nodes {
            if !n.name.is_empty() {
                ndx += 1;
            }
            let here = (!n.name.is_empty()).then_some(ndx);
            for (pats, keep) in [(&n.globals, true), (&n.locals, false)] {
                for p in pats {
                    if p == name {
                        return keep.then_some(here.unwrap_or(dynamic::VER_NDX_GLOBAL));
                    }
                    if !super::lds::is_literal_pattern(p)
                        && wildcard.is_none()
                        && glob_match(p, name)
                    {
                        wildcard = Some(keep.then_some(here.unwrap_or(dynamic::VER_NDX_GLOBAL)));
                    }
                }
            }
        }
        wildcard.unwrap_or(Some(dynamic::VER_NDX_GLOBAL))
    }

    /// Defined symbols a loader may resolve against, as bfd selects
    /// them: global or weak, not hidden, and kept by the version
    /// script. Each version definition also contributes a symbol
    /// naming itself.
    fn collect_dyn_exports(&self, out_shndx: &dyn Fn(usize) -> u16) -> Vec<DynSym> {
        // Imports come first and in their own order: a dynamic
        // relocation names one by the index that ordering fixes.
        let mut out: Vec<DynSym> = self
            .imports
            .iter()
            .map(|name| DynSym {
                name: name.clone(),
                info: (STB_GLOBAL << 4) | STT_NOTYPE,
                other: STV_DEFAULT,
                shndx: SHN_UNDEF,
                value: 0,
                size: 0,
                version: dynamic::VER_NDX_GLOBAL,
            })
            .collect();
        let mut names: Vec<&String> = self.globals.keys().collect();
        names.sort();
        for name in names {
            if self.script_now.contains_key(name) {
                continue;
            }
            let (obj_i, sym_i) = self.globals[name];
            if self.objects[obj_i].symbols[sym_i].other & 0x3 != STV_DEFAULT {
                continue;
            }
            let Some(v) = self.version_of(name) else {
                continue;
            };
            if let Some(fs) = self.finalize_sym(obj_i, sym_i, out_shndx) {
                out.push(DynSym {
                    name: fs.name,
                    info: fs.info,
                    other: fs.other,
                    shndx: fs.shndx,
                    value: fs.value,
                    size: fs.size,
                    version: v,
                });
            }
        }
        let mut script_syms: Vec<(&String, &ScriptSym)> = self.script_now.iter().collect();
        script_syms.sort_by(|a, b| a.0.cmp(b.0));
        for (name, s) in script_syms {
            if s.hidden {
                continue;
            }
            let Some(v) = self.version_of(name) else {
                continue;
            };
            let shndx = match (s.val.att, s.final_out) {
                (Att::Out(oi), _) => out_shndx(oi),
                (_, Some(oi)) => out_shndx(oi),
                (_, None) => SHN_ABS,
            };
            out.push(DynSym {
                name: name.clone(),
                info: (STB_GLOBAL << 4) | s.kind,
                other: STV_DEFAULT,
                shndx,
                value: s.val.v,
                size: 0,
                version: v,
            });
        }
        // The base node names the image, not a symbol.
        for (k, v) in self.verdefs.iter().enumerate().skip(1) {
            out.push(DynSym {
                name: v.name.clone(),
                info: (STB_GLOBAL << 4) | STT_OBJECT,
                other: STV_DEFAULT,
                shndx: SHN_ABS,
                value: 0,
                size: 0,
                version: (k + 1) as u16,
            });
        }
        out
    }

    fn build_dyn_tables(&mut self, out_shndx: &dyn Fn(usize) -> u16) {
        self.dyn_tables = None;
        if self.opts.emit != LdsEmit::Dyn || self.kept_synth(SYNTH_DYNSYM).is_none() {
            return;
        }
        let exports = self.collect_dyn_exports(out_shndx);
        let verdefs = if self.kept_synth(SYNTH_VERDEF).is_some() {
            self.verdefs.clone()
        } else {
            Vec::new()
        };
        let rpath = self.rpath_string();
        let mut extra: Vec<&str> = self.needed_sonames().collect();
        if let Some(p) = &rpath {
            extra.push(p);
        }
        self.dyn_tables = Some(dynamic::build_tables(
            &exports,
            self.opts.soname.as_deref(),
            &verdefs,
            &extra,
            self.opts.hash_style,
            self.class,
        ));
    }

    /// Sonames this image depends on, in link order and once each. A
    /// library the link took nothing from is recorded anyway, as bfd
    /// does without `--as-needed`; one named only under `AS_NEEDED` is
    /// recorded only where an import bound to it.
    fn needed_sonames(&self) -> impl Iterator<Item = &str> {
        let mut seen: HashSet<&str> = HashSet::new();
        self.opts
            .shared_libs
            .iter()
            .filter(|l| !l.as_needed || self.imports.iter().any(|n| l.lib.exports.contains(n)))
            .map(|l| l.lib.soname.as_str())
            .filter(move |s| seen.insert(s))
    }

    /// `-rpath` directories as the colon-separated string the tag holds.
    fn rpath_string(&self) -> Option<String> {
        (!self.opts.rpath.is_empty()).then(|| self.opts.rpath.join(":"))
    }

    /// Sizes of the dynamic tables for this pass, by section name.
    /// `.dynamic` is sized from the tag list the writer will emit.
    fn dyn_table_sizes(&self) -> HashMap<&'static str, u64> {
        let mut m: HashMap<&'static str, u64> = HashMap::new();
        let Some(t) = &self.dyn_tables else {
            return m;
        };
        m.insert(SYNTH_DYNSYM, t.dynsym.len() as u64);
        m.insert(SYNTH_DYNSTR, t.dynstr().len() as u64);
        m.insert(SYNTH_HASH, t.hash.len() as u64);
        m.insert(SYNTH_GNU_HASH, t.gnu_hash.len() as u64);
        m.insert(SYNTH_VERSYM, t.versym.len() as u64);
        m.insert(SYNTH_VERDEF, t.verdef.len() as u64);
        m.insert(
            SYNTH_DYNAMIC,
            dynamic::build_dynamic(&self.dyn_addrs(), self.class).len() as u64,
        );
        m
    }

    /// Addresses and sizes the `.dynamic` tags name. Values come from
    /// the previous pass's layout and settle with it.
    fn dyn_addrs(&self) -> dynamic::DynAddrs {
        let addr = |name: &str| self.synth_addr(name);
        // A relocation table the link did not fill gets no tags, as
        // bfd leaves them off an empty section.
        let sized = |name: &str| -> Option<(u64, u64)> {
            let sec = self.objects[self.synth_obj]
                .sections
                .iter()
                .position(|s| s.name == name)?;
            let size = self.objects[self.synth_obj].sections[sec].size;
            (size > 0).then(|| addr(name).map(|a| (a, size))).flatten()
        };
        let t = self.dyn_tables.as_ref();
        dynamic::DynAddrs {
            hash: addr(SYNTH_HASH),
            gnu_hash: addr(SYNTH_GNU_HASH),
            strtab: addr(SYNTH_DYNSTR),
            strsz: t.map(|t| t.dynstr().len() as u64).unwrap_or(0),
            symtab: addr(SYNTH_DYNSYM),
            rela: sized(self.dyn_reloc_name()),
            use_rela: machine_uses_rela(self.machine),
            relr: sized(SYNTH_RELR),
            verdef: addr(SYNTH_VERDEF).map(|a| (a, t.map(|t| t.verdef_count).unwrap_or(0))),
            versym: addr(SYNTH_VERSYM),
            soname: match (t, self.opts.soname.as_deref()) {
                (Some(t), Some(s)) => Some(t.str_offset(s)),
                _ => None,
            },
            needed: t
                .map(|t| self.needed_sonames().map(|s| t.str_offset(s)).collect())
                .unwrap_or_default(),
            rpath: match (t, self.rpath_string()) {
                (Some(t), Some(p)) => Some((t.str_offset(&p), self.opts.new_dtags)),
                _ => None,
            },
            symbolic: self.opts.symbolic,
            textrel: self.has_readonly_dynamic_reloc(),
            preinit_array: self.out_extent(".preinit_array"),
            init_array: self.out_extent(".init_array"),
            fini_array: self.out_extent(".fini_array"),
        }
    }

    /// `(address, size)` of a kept output section.
    fn out_extent(&self, name: &str) -> Option<(u64, u64)> {
        self.outs
            .iter()
            .find(|o| o.name == name && o.alloc && !o.removed)
            .map(|o| (o.addr, o.size))
    }

    /// True when a dynamic relocation applies to a section the loader
    /// maps read-only. `DT_TEXTREL` is what tells it to make the
    /// segment writable first; without the tag the write faults.
    fn has_readonly_dynamic_reloc(&self) -> bool {
        let sites = self
            .dyn_relas
            .iter()
            .map(|d| d.offset)
            .chain(self.relr_addrs.iter().copied());
        let ro: Vec<(u64, u64)> = self
            .outs
            .iter()
            .filter(|o| o.alloc && !o.removed && o.flags & SHF_WRITE == 0)
            .map(|o| (o.addr, o.addr + o.size))
            .collect();
        sites
            .into_iter()
            .any(|a| ro.iter().any(|&(lo, hi)| a >= lo && a < hi))
    }

    /// bfd sizes dynamic reloc sections at check_relocs time: every
    /// 64-bit absolute reloc against a non-local symbol in an
    /// allocated section reserves a slot, with no discard check on the
    /// global-symbol path. A slot whose section the script discards is
    /// never written (the section is not relocated) and never
    /// reclaimed by RELR packing, so it survives as a zeroed
    /// R_*_NONE entry. Reserve the same slots for size parity.
    fn count_reserved_none_slots(&self) -> u64 {
        let abs_addr = self.dyn_reloc_types().0;
        let mut n = 0u64;
        for i in 0..self.insecs.len() {
            if self.fates[i] != SecFate::Discarded {
                continue;
            }
            let id = self.insecs[i];
            // A group the dedup dropped is gone before bfd reaches
            // check_relocs, so it reserves nothing.
            if self.comdat_dropped.contains(&(id.obj, id.sec)) {
                continue;
            }
            let s = &self.objects[id.obj].sections[id.sec];
            if s.flags & SHF_ALLOC == 0 {
                continue;
            }
            for r in &s.relocs {
                if r.rtype != abs_addr {
                    continue;
                }
                let sym = &self.objects[id.obj].symbols[r.sym as usize];
                if sym.binding() != STB_LOCAL {
                    n += 1;
                }
            }
        }
        n
    }

    /// Resolve a symbol name to a final value through the global table
    /// or a script assignment. Used for GOT slot fills.
    fn resolve_name(&self, name: &str) -> Option<u64> {
        if let Some(&(oi, si)) = self.globals.get(name) {
            return self.resolve_sym_prevpass(oi, si, 0);
        }
        self.script_now
            .get(name)
            .or_else(|| self.script_prev.get(name))
            .map(|s| s.val.v)
    }

    /// An undefined default-visibility weak reference that nothing in
    /// the link satisfies. bfd exports it as a dynamic symbol and
    /// keeps a symbol-based reloc for its sites and GOT slot.
    fn undefweak_dynamic(&self, oi: usize, si: usize) -> bool {
        let sym = &self.objects[oi].symbols[si];
        sym.shndx as u16 == SHN_UNDEF
            && sym.binding() == STB_WEAK
            && sym.other & 0x3 == 0
            && !sym.name.is_empty()
            && !self.globals.contains_key(&sym.name)
            // During sizing the current pass's script table is swapped
            // out; the previous pass's values match at convergence.
            && !self.script_now.contains_key(&sym.name)
            && !self.script_prev.contains_key(&sym.name)
    }

    /// True when an ABS64 site against this symbol names a load
    /// address (a section-relative definition or an Out-attributed
    /// script symbol), so an ET_DYN image needs a RELATIVE fixup for
    /// it. An absolute constant or an undefined symbol does not.
    fn reloc_is_relative(&self, oi: usize, si: usize) -> bool {
        let sym = &self.objects[oi].symbols[si];
        match sym.shndx as u16 {
            SHN_ABS | SHN_UNDEF | SHN_COMMON => {
                if sym.binding() != STB_LOCAL {
                    // A global SHN_ABS definition is its own entry in
                    // the global table; following it would not
                    // terminate. Only a reference resolves elsewhere.
                    if let Some(&(doi, dsi)) = self.globals.get(&sym.name)
                        && (doi, dsi) != (oi, si)
                    {
                        return self.reloc_is_relative(doi, dsi);
                    }
                    if let Some(s) = self
                        .script_now
                        .get(&sym.name)
                        .or_else(|| self.script_prev.get(&sym.name))
                    {
                        // A symbol assigned from the top-level location
                        // counter is rebased into its section before
                        // emission (ld's ldexp_finalize_syms), so it is
                        // a load address like an in-section one.
                        return matches!(s.val.att, Att::Out(_)) || s.final_out.is_some();
                    }
                }
                false
            }
            _ => true,
        }
    }

    /// Refusal for a site an `ET_DYN` image has no way to carry, or
    /// `None` when it is representable. Writing a link-time address
    /// into a field no dynamic relocation covers bakes an address the
    /// loader then slides out from under. A non-allocated section,
    /// which the loader never maps, and a value that is not a load
    /// address both keep the link-time value.
    fn unrepresentable_in_dyn(
        &self,
        oi: usize,
        si: usize,
        r: &RawReloc,
        alloc: bool,
    ) -> Option<String> {
        if self.opts.emit != LdsEmit::Dyn
            || !alloc
            || !narrow_absolute(self.machine, r.rtype)
            || !self.reloc_is_relative(oi, r.sym as usize)
        {
            return None;
        }
        let obj = &self.objects[oi];
        let sym = &obj.symbols[r.sym as usize];
        let target = if !sym.name.is_empty() {
            sym.name.as_str()
        } else {
            // A section symbol: ld names the section it points at.
            obj.shndx_map
                .get(&sym.shndx)
                .map_or("<section>", |&t| obj.sections[t].name.as_str())
        };
        Some(absolute_in_pie_body(
            &locate_reloc(&obj.source, &obj.sections[si].name, r.offset),
            &elf_reloc_desc(self.machine, r.rtype),
            target,
            self.opts.shared,
        ))
    }

    fn resolve_sym_prevpass(&self, oi: usize, si: usize, addend: i64) -> Option<u64> {
        let sym = &self.objects[oi].symbols[si];
        match sym.shndx as u16 {
            SHN_ABS => Some(sym.value.wrapping_add(addend as u64)),
            SHN_UNDEF => {
                if let Some(&(doi, dsi)) = self.globals.get(&sym.name) {
                    return self.resolve_sym_prevpass(doi, dsi, addend);
                }
                // A reference the objects leave undefined can bind to
                // a script-defined symbol; without this the dynamic
                // fixup collection drops the slot entirely. During
                // sizing the current pass's table is already swapped
                // out, so fall back to the previous pass's values,
                // which match at convergence.
                self.script_now
                    .get(&sym.name)
                    .or_else(|| self.script_prev.get(&sym.name))
                    .map(|s| s.val.v.wrapping_add(addend as u64))
            }
            _ => {
                // Prev-pass placement offsets survive the reset; at
                // convergence they equal the current pass's.
                let sec = *self.objects[oi].shndx_map.get(&sym.shndx)?;
                let i = self.insec_index(oi, sec);
                let p = self.placements[i];
                match self.fates[i] {
                    SecFate::Placed { out } => {
                        // In a merge pool a section symbol's addend picks
                        // the entry, so the combined offset is remapped; a
                        // named symbol anchors at its own entry and the
                        // addend applies to the remapped address (matches
                        // bfd -- an addend past the entry, e.g. one past a
                        // string's NUL, must stay relative to that entry).
                        let off = if sym.kind() == STT_SECTION {
                            self.placed_off(i, sym.value.wrapping_add(addend as u64))?
                        } else {
                            self.placed_off(i, sym.value)?.wrapping_add(addend as u64)
                        };
                        let base = if let Some(&pl) = self.merge_of.get(&i) {
                            self.placements[self.pools[pl].rep].off
                        } else {
                            p.off
                        };
                        Some(self.outs[out].addr.wrapping_add(base).wrapping_add(off))
                    }
                    _ => None,
                }
            }
        }
    }

    fn got_addr_prevpass(&self) -> Option<u64> {
        let synth = self.synth_obj;
        let sec = self.objects[synth]
            .sections
            .iter()
            .position(|s| s.name == SYNTH_GOT)?;
        let i = self.insec_index(synth, sec);
        match self.fates[i] {
            SecFate::Placed { out } => Some(self.outs[out].addr + self.placements[i].off),
            _ => None,
        }
    }

    /// Whether the backend's GOT section is `.got.plt`. bfd defines
    /// `_GLOBAL_OFFSET_TABLE_` on the section it creates for the GOT
    /// and reserves that section's first slot for the `.dynamic`
    /// address; the x86 targets set `elf_backend_want_got_plt`, so for
    /// them both live on `.got.plt`.
    fn got_on_got_plt(&self) -> bool {
        matches!(self.machine, EM_386 | EM_X86_64)
    }

    /// Slots `.got` reserves ahead of its first entry.
    fn got_reserved(&self) -> u64 {
        u64::from(!self.got_on_got_plt())
    }

    /// The address `_GLOBAL_OFFSET_TABLE_` takes and every GOT-base
    /// relative relocation is computed against.
    fn got_symbol_addr(&self) -> Option<u64> {
        if self.got_on_got_plt()
            && let Some(addr) = self.synth_addr(SYNTH_GOTPLT)
        {
            return Some(addr);
        }
        self.got_addr_prevpass()
    }

    /// The address of the first GOT entry, past the reserved header.
    fn got_slot_base(&self) -> Option<u64> {
        Some(self.got_addr_prevpass()? + self.got_reserved() * self.class.addr_size())
    }
}

/// Every symbol name an expression reads.
fn collect_symbols(e: &Expr, out: &mut HashSet<String>) {
    match e {
        Expr::Symbol(n) => {
            out.insert(n.clone());
        }
        Expr::Unary(_, a) | Expr::AlignDot(a) | Expr::Absolute(a) | Expr::Assert(a, _) => {
            collect_symbols(a, out)
        }
        Expr::Binary(_, a, b) | Expr::Align2(a, b) | Expr::Min(a, b) | Expr::Max(a, b) => {
            collect_symbols(a, out);
            collect_symbols(b, out);
        }
        Expr::Ternary(a, b, c) => {
            collect_symbols(a, out);
            collect_symbols(b, out);
            collect_symbols(c, out);
        }
        _ => {}
    }
}

/// Name bfd gives a synthesized file symbol: the input's base name,
/// which for an archive member is the member name.
fn file_sym_name(source: &str) -> String {
    let base = source.rsplit(['/', '\\']).next().unwrap_or(source);
    base.split_once('(')
        .map(|(_, m)| m.trim_end_matches(')'))
        .unwrap_or(base)
        .to_string()
}

/// Unwind and exception tables: kept whatever GC decides, and never a
/// source of liveness -- each names every function it describes.
fn is_unwind_section(name: &str) -> bool {
    name == ".eh_frame" || name.starts_with(".eh_frame.") || name == ".eh_frame_hdr"
}

fn is_debug_section(name: &str) -> bool {
    name.starts_with(".debug")
        || name.starts_with(".zdebug")
        || name.starts_with(".stab")
        || name == ".line"
        || name.starts_with(".gnu.linkonce.wi.")
}

/// The fill pattern for a numeric fill value: the value's big-endian
/// bytes with leading zeros trimmed (at least one byte). `0xcccccccc`
/// fills with `cc`, `0x9090` with `90 90`.
fn fill_pattern(v: u64) -> Vec<u8> {
    let be = v.to_be_bytes();
    let first = be.iter().position(|&b| b != 0).unwrap_or(7);
    be[first..].to_vec()
}

/// A gap's padding: the script's fill pattern where it gave one, the
/// architecture's otherwise.
fn pad_bytes(fill: &Option<Vec<u8>>, machine: u16, code: bool, len: u64) -> Vec<u8> {
    match fill {
        Some(f) => f.clone(),
        None => arch_fill(machine, code, len as usize),
    }
}

/// Padding bytes for a gap a script gave no fill for: bfd takes them
/// from the architecture (`bfd/cpu-*.c`), which is a NOP sequence in a
/// code section and zeros everywhere else, so padding a control-flow
/// path reaches is not an instruction stream of its own.
fn arch_fill(machine: u16, code: bool, len: usize) -> Vec<u8> {
    if !code || len == 0 {
        return alloc::vec![0u8; len];
    }
    match machine {
        EM_386 | EM_X86_64 => {
            let mut v = alloc::vec![0x90u8; len];
            for k in (0..len.saturating_sub(1)).step_by(2) {
                v[k] = 0x66;
            }
            v
        }
        EM_AARCH64 if len.is_multiple_of(4) => {
            let mut v = Vec::with_capacity(len);
            for _ in 0..len / 4 {
                v.extend_from_slice(&[0x1f, 0x20, 0x03, 0xd5]);
            }
            v
        }
        _ => alloc::vec![0u8; len],
    }
}

/// Pack sorted 8-aligned addresses into SHT_RELR words: an even
/// entry relocates its own address and rebases the window at
/// `addr + 8`; each following odd entry's bits `1..=63` relocate
/// `base + (bit-1)*8` and advance the base by `63*8`.
fn encode_relr(addrs: &[u64], word_size: u64) -> Vec<u64> {
    let span = (word_size * 8 - 1) * word_size;
    let mut out: Vec<u64> = Vec::new();
    let mut i = 0usize;
    while i < addrs.len() {
        out.push(addrs[i]);
        let mut base = addrs[i] + word_size;
        i += 1;
        loop {
            let mut word: u64 = 0;
            while i < addrs.len() {
                let d = addrs[i].wrapping_sub(base);
                if d >= span || !d.is_multiple_of(word_size) {
                    break;
                }
                word |= 1u64 << (d / word_size);
                i += 1;
            }
            if word == 0 {
                break;
            }
            out.push((word << 1) | 1);
            base += span;
        }
    }
    out
}

// ------------------------------------------------------ finalization

/// A finished symbol destined for the output `.symtab`.
struct FinalSym {
    name: String,
    info: u8,
    other: u8,
    /// Kept-output-section index (into the emit order), or one of
    /// the SHN_* reserved values.
    shndx: u16,
    value: u64,
    size: u64,
}

impl<'a> LdsLinker<'a> {
    fn finish(&mut self) -> Result<LdsResult, C5Error> {
        // Emission order: statement order, kept sections only. An
        // empty output section is removed; symbols assigned inside it
        // survive, re-parented below.
        let mut emit_order: Vec<usize> = Vec::new();
        let opens: Vec<usize> = self
            .stmts
            .iter()
            .filter_map(|st| match st {
                Stmt::Open(oi) => Some(*oi),
                _ => None,
            })
            .collect();
        for oi in opens {
            if self.outs[oi].name == "/DISCARD/" {
                continue;
            }
            if self.outs[oi].size == 0 {
                self.outs[oi].removed = true;
                continue;
            }
            emit_order.push(oi);
        }
        // Output-section index (1-based in the final header table).
        let mut shndx_of_out: HashMap<usize, u16> = HashMap::new();
        for (k, &oi) in emit_order.iter().enumerate() {
            shndx_of_out.insert(oi, (k + 1) as u16);
        }
        // Symbols in removed sections re-parent to the nearest kept
        // section opened before them in statement order.
        let mut reparent: HashMap<usize, u16> = HashMap::new();
        {
            let mut last_kept: u16 = SHN_ABS;
            for st in &self.stmts {
                if let Stmt::Open(oi) = st {
                    match shndx_of_out.get(oi) {
                        Some(&k) => last_kept = k,
                        None => {
                            reparent.insert(*oi, last_kept);
                        }
                    }
                }
            }
        }
        let out_shndx = |oi: usize| -> u16 {
            shndx_of_out
                .get(&oi)
                .copied()
                .or_else(|| reparent.get(&oi).copied())
                .unwrap_or(SHN_ABS)
        };

        // Section content buffers (file-backed sections only).
        let mut contents: HashMap<usize, Vec<u8>> = HashMap::new();
        for &oi in &emit_order {
            let o = &self.outs[oi];
            if o.shtype == SHT_NOBITS {
                continue;
            }
            let mut buf = alloc::vec![0u8; o.size as usize];
            for (off, len, src) in &o.chunks {
                let (off, len) = (*off as usize, *len as usize);
                match src {
                    ChunkSrc::Input(i) => {
                        let data = self.chunk_input_bytes(*i);
                        let n = data.len().min(len);
                        buf[off..off + n].copy_from_slice(&data[..n]);
                    }
                    ChunkSrc::Bytes(b) => {
                        let n = b.len().min(len);
                        buf[off..off + n].copy_from_slice(&b[..n]);
                    }
                    ChunkSrc::Pad(pat) => {
                        if !pat.is_empty() {
                            for k in 0..len {
                                buf[off + k] = pat[k % pat.len()];
                            }
                        }
                    }
                }
            }
            contents.insert(oi, buf);
        }
        self.patch_eh_frame(&mut contents);

        // Apply relocations into the content buffers.
        let relr_set: HashSet<u64> = self.relr_addrs.iter().copied().collect();
        self.apply_relocations(&mut contents, &relr_set)?;
        self.fill_synth_contents(&mut contents, &relr_set, &out_shndx);

        // Entry point.
        let entry_name: Option<String> = self
            .opts
            .entry_override
            .clone()
            .or_else(|| self.script.entry().map(|s| s.to_string()));
        let entry = match &entry_name {
            Some(name) => match self.final_sym_value(name) {
                Some(v) => v,
                None => {
                    self.warnings.push(format!(
                        "warning: cannot find entry symbol {name}; defaulting to first text address"
                    ));
                    self.default_entry(&emit_order)
                }
            },
            // Nothing named an entry. A shared object has none, as bfd
            // leaves `e_entry` zero for one; an executable takes bfd's
            // default entry symbol and, failing that, its first text
            // address. A PIE is an executable.
            None if self.opts.shared => 0,
            None => self
                .final_sym_value("_start")
                .unwrap_or_else(|| self.default_entry(&emit_order)),
        };

        // Program headers.
        let phdrs = self.build_phdrs(&emit_order)?;

        // Symbol table.
        let mut sym_index = SymIndex::default();
        let syms = self.build_symtab(&emit_order, &out_shndx, &mut sym_index);
        self.sym_index = sym_index;

        // Assemble the image.
        let image = self.write_image(&emit_order, &shndx_of_out, contents, phdrs, syms, entry)?;
        let map = self.render_map(&emit_order);
        Ok(LdsResult {
            image,
            map,
            warnings: core::mem::take(&mut self.warnings),
        })
    }

    /// Bytes an input chunk contributes: its own section data, the
    /// merge pool for a pool representative (empty for other members),
    /// or its deduplicated `.eh_frame`.
    fn chunk_input_bytes(&self, i: usize) -> &[u8] {
        if let Some(&p) = self.merge_of.get(&i) {
            if self.pools[p].rep == i {
                return &self.pools[p].bytes;
            }
            return &[];
        }
        if let Some(&e) = self.eh_of.get(&i) {
            return &self.eh_frames[e].bytes;
        }
        let id = self.insecs[i];
        let o = &self.objects[id.obj];
        let s = &o.sections[id.sec];
        if id.obj == self.synth_obj {
            // Synthetic sections have no backing bytes here; content
            // is written by `fill_synth_contents`.
            return &[];
        }
        o.section_data(s)
    }

    fn default_entry(&self, emit_order: &[usize]) -> u64 {
        for &oi in emit_order {
            let o = &self.outs[oi];
            if o.alloc && o.flags & SHF_EXECINSTR != 0 {
                return o.addr;
            }
        }
        0
    }

    fn final_sym_value(&self, name: &str) -> Option<u64> {
        if let Some(s) = self.script_now.get(name) {
            return Some(s.val.v);
        }
        let &(oi, si) = self.globals.get(name)?;
        self.resolve_sym_prevpass(oi, si, 0)
    }

    // ---------------------------------------------------- relocations

    fn apply_relocations(
        &mut self,
        contents: &mut HashMap<usize, Vec<u8>>,
        relr_set: &HashSet<u64>,
    ) -> Result<(), C5Error> {
        let mut errors: Vec<String> = Vec::new();
        for i in 0..self.insecs.len() {
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            if self.outs[out].removed || self.outs[out].shtype == SHT_NOBITS {
                continue;
            }
            let id = self.insecs[i];
            if id.obj == self.synth_obj {
                continue;
            }
            if self.objects[id.obj].sections[id.sec].relocs.is_empty() {
                continue;
            }
            let place = self.placements[i];
            let sec_addr = self.outs[out].addr + place.off;
            let alloc = self.outs[out].alloc;
            let name = &self.objects[id.obj].sections[id.sec].name;
            let tolerant = is_debug_section(name) || is_unwind_section(name);
            let relocs = self.objects[id.obj].sections[id.sec].relocs.clone();
            let Some(buf) = contents.get_mut(&out) else {
                continue;
            };
            for r in &relocs {
                // A relocation whose site went away with a duplicate
                // CIE applies nowhere.
                let Some(off) = self.placed_off(i, r.offset) else {
                    continue;
                };
                let site = (place.off + off) as usize;
                let p = sec_addr + off;
                let target = self.resolve_reloc_target(id.obj, r, tolerant, &mut errors);
                let Some(s_plus_a) = target else { continue };
                if errors.len() > 40 {
                    break;
                }
                if self.opts.emit_relocs {
                    self.emitted.push(EmittedReloc {
                        out,
                        addr: p,
                        rtype: r.rtype,
                        target: s_plus_a,
                        obj: id.obj,
                        sym: r.sym,
                    });
                }
                if r.rtype == R_NONE {
                    continue; // recorded, applies nothing
                }
                if let Some(e) = self.unrepresentable_in_dyn(id.obj, id.sec, r, alloc) {
                    errors.push(e);
                    continue;
                }
                self.apply_one(
                    buf,
                    site,
                    p,
                    s_plus_a,
                    r,
                    alloc,
                    relr_set,
                    &mut errors,
                    id.obj,
                );
            }
        }
        if !errors.is_empty() {
            errors.truncate(40);
            return Err(err(&errors.join("\n")));
        }
        Ok(())
    }

    /// `S + A` for a relocation, or `None` when the reloc is skipped
    /// (undefined weak resolves to zero and still applies).
    /// `tolerant` marks a referring section that describes other
    /// sections rather than depending on them -- debug and unwind
    /// tables -- where bfd resolves a dropped target to zero instead
    /// of complaining.
    fn resolve_reloc_target(
        &self,
        oi: usize,
        r: &RawReloc,
        tolerant: bool,
        errors: &mut Vec<String>,
    ) -> Option<u64> {
        let sym = match self.objects[oi].symbols.get(r.sym as usize) {
            Some(s) => s,
            None => {
                errors.push(format!(
                    "{}: relocation references symbol index {} out of range",
                    self.objects[oi].source, r.sym
                ));
                return None;
            }
        };
        // A named non-local reference resolves through the global
        // table, so a weak definition here yields to a strong one
        // elsewhere; script symbols satisfy references the objects
        // leave undefined.
        let by_name = sym.binding() != STB_LOCAL && !sym.name.is_empty();
        if by_name {
            if let Some(&(doi, dsi)) = self.globals.get(&sym.name) {
                return match self.resolve_sym_prevpass(doi, dsi, r.addend) {
                    Some(v) => Some(v),
                    None if tolerant => Some(r.addend as u64),
                    None => {
                        errors.push(format!(
                            "{}: `{}' resolves into a discarded section",
                            self.objects[oi].source, sym.name
                        ));
                        None
                    }
                };
            }
            if sym.name == "_GLOBAL_OFFSET_TABLE_" {
                return self
                    .got_symbol_addr()
                    .map(|g| g.wrapping_add(r.addend as u64));
            }
            if let Some(s) = self.script_now.get(&sym.name) {
                return Some(s.val.v.wrapping_add(r.addend as u64));
            }
            if self.import_of.contains_key(&sym.name) {
                if let Some(v) = self.import_target(&sym.name, r.rtype) {
                    return Some(v.wrapping_add(r.addend as u64));
                }
                errors.push(format!(
                    "{}: {} against `{}' cannot reach a shared library; \
                     the reference needs a GOT slot or a call",
                    self.objects[oi].source,
                    elf_reloc_desc(self.machine, r.rtype),
                    sym.name
                ));
                return None;
            }
        }
        match sym.shndx as u16 {
            SHN_ABS => Some(sym.value.wrapping_add(r.addend as u64)),
            SHN_UNDEF | SHN_COMMON => {
                if sym.binding() == STB_WEAK {
                    // Undefined weak resolves to zero.
                    Some(r.addend as u64)
                } else {
                    errors.push(format!(
                        "{}: undefined reference to `{}'",
                        self.objects[oi].source,
                        if sym.name.is_empty() { "?" } else { &sym.name }
                    ));
                    None
                }
            }
            // Local / section reference into this object; a discarded
            // target resolves to nothing and the site keeps its bytes.
            _ => {
                // The surviving copy of a deduplicated group need bear
                // no relation to the dropped one, so a reference that
                // name resolution above could not place has nowhere to
                // go. GNU ld reports it rather than redirecting.
                if let Some(home) = self.dropped_home(oi, sym) {
                    if tolerant || (by_name && sym.binding() == STB_WEAK) {
                        return Some(r.addend as u64);
                    }
                    let what = if by_name {
                        format!("undefined reference to `{}'", sym.name)
                    } else if sym.name.is_empty() {
                        format!("reference to discarded section `{home}'")
                    } else {
                        format!("`{}' is defined in discarded section `{home}'", sym.name)
                    };
                    errors.push(format!("{}: {what}", self.objects[oi].source));
                    return None;
                }
                self.resolve_sym_prevpass(oi, r.sym as usize, r.addend)
            }
        }
    }

    #[allow(clippy::too_many_arguments)]
    fn apply_one(
        &self,
        buf: &mut [u8],
        site: usize,
        p: u64,
        sa: u64,
        r: &RawReloc,
        alloc: bool,
        relr_set: &HashSet<u64>,
        errors: &mut Vec<String>,
        oi: usize,
    ) {
        let machine = self.machine;
        let name = || {
            let sym = &self.objects[oi].symbols[r.sym as usize];
            if sym.name.is_empty() {
                format!("section symbol {}", sym.shndx)
            } else {
                sym.name.clone()
            }
        };
        if site > buf.len() {
            errors.push(format!(
                "{}: relocation offset 0x{:x} outside section",
                self.objects[oi].source, r.offset
            ));
            return;
        }
        let w = |buf: &mut [u8], site: usize, bytes: &[u8]| {
            if site + bytes.len() <= buf.len() {
                buf[site..site + bytes.len()].copy_from_slice(bytes);
                true
            } else {
                false
            }
        };
        match machine {
            EM_X86_64 => match r.rtype {
                rt::R_X86_64_64 => {
                    w(buf, site, &sa.to_le_bytes());
                }
                rt::R_X86_64_PC64 => {
                    w(buf, site, &sa.wrapping_sub(p).to_le_bytes());
                }
                rt::R_X86_64_PC32 | rt::R_X86_64_PLT32 => {
                    let v = sa.wrapping_sub(p) as i64;
                    if (v as i32) as i64 != v {
                        errors.push(format!(
                            "relocation truncated: R_X86_64_PC32 against `{}' (0x{v:x})",
                            name()
                        ));
                    }
                    w(buf, site, &(v as i32).to_le_bytes());
                }
                rt::R_X86_64_32 => {
                    if sa > u32::MAX as u64 {
                        errors.push(format!(
                            "relocation truncated: R_X86_64_32 against `{}' (0x{sa:x})",
                            name()
                        ));
                    }
                    w(buf, site, &(sa as u32).to_le_bytes());
                }
                rt::R_X86_64_32S => {
                    let v = sa as i64;
                    if (v as i32) as i64 != v {
                        errors.push(format!(
                            "relocation truncated: R_X86_64_32S against `{}' (0x{sa:x})",
                            name()
                        ));
                    }
                    w(buf, site, &(sa as u32).to_le_bytes());
                }
                12 => {
                    // R_X86_64_16
                    w(buf, site, &(sa as u16).to_le_bytes());
                }
                13 => {
                    let v = sa.wrapping_sub(p);
                    w(buf, site, &(v as u16).to_le_bytes());
                }
                14 => {
                    w(buf, site, &[sa as u8]);
                }
                15 => {
                    let v = sa.wrapping_sub(p);
                    w(buf, site, &[v as u8]);
                }
                rt::R_X86_64_GOTPCREL | R_X86_64_GOTPCRELX | rt::R_X86_64_REX_GOTPCRELX => {
                    // An import has no link-time address to relax to;
                    // the site keeps its load from the GOT slot.
                    if self.import_of.contains_key(&name()) {
                        let v = sa.wrapping_sub(p) as i64;
                        w(buf, site, &(v as i32).to_le_bytes());
                        return;
                    }
                    // The kernel scripts assert an empty GOT: relax
                    // the load to a direct reference.
                    if site >= 2 && buf[site - 2] == 0x8b {
                        buf[site - 2] = 0x8d; // mov -> lea
                    } else if site >= 2 && buf[site - 2] == 0xff && buf[site - 1] == 0x15 {
                        buf[site - 2] = 0x67; // call *[rip] -> addr32 call
                        buf[site - 1] = 0xe8;
                    } else if site >= 2 && buf[site - 2] == 0xff && buf[site - 1] == 0x25 {
                        // jmp *[rip] -> jmp rel32; nop. The immediate
                        // moves back one byte.
                        buf[site - 2] = 0xe9;
                        let v = sa.wrapping_sub(p - 1) as i64;
                        w(buf, site - 1, &(v as i32).to_le_bytes());
                        if site + 4 <= buf.len() {
                            buf[site + 3] = 0x90;
                        }
                        return;
                    } else {
                        errors.push(format!(
                            "cannot relax GOT reference against `{}' (insn bytes {:02x} {:02x})",
                            name(),
                            buf.get(site.wrapping_sub(2)).copied().unwrap_or(0),
                            buf.get(site.wrapping_sub(1)).copied().unwrap_or(0),
                        ));
                        return;
                    }
                    let v = sa.wrapping_sub(p) as i64;
                    if (v as i32) as i64 != v {
                        errors.push(format!(
                            "relaxed GOT reference out of range against `{}'",
                            name()
                        ));
                    }
                    w(buf, site, &(v as i32).to_le_bytes());
                }
                other => {
                    errors.push(format!(
                        "unsupported relocation {} against `{}'",
                        rt::x86_64_reloc_desc(other),
                        name()
                    ));
                }
            },
            EM_386 => self.apply_i386(buf, site, p, sa, r, errors, oi),
            EM_AARCH64 => self.apply_aarch64(buf, site, p, sa, r, alloc, relr_set, errors, oi),
            _ => errors.push(format!("unsupported machine {machine}")),
        }
    }

    /// Intel386 psABI: every type is `S + A`, `S + A - P` or a GOT-base
    /// form, written at the field's own width. bfd complains on
    /// overflow only where the field is narrower than an address.
    #[allow(clippy::too_many_arguments)]
    fn apply_i386(
        &self,
        buf: &mut [u8],
        site: usize,
        p: u64,
        sa: u64,
        r: &RawReloc,
        errors: &mut Vec<String>,
        oi: usize,
    ) {
        let name = || {
            let sym = &self.objects[oi].symbols[r.sym as usize];
            if sym.name.is_empty() {
                format!("section symbol {}", sym.shndx)
            } else {
                sym.name.clone()
            }
        };
        let v = match r.rtype {
            rt::R_386_32 | rt::R_386_16 | rt::R_386_8 => sa,
            // GOTPC's symbol is `_GLOBAL_OFFSET_TABLE_`, so `sa` is
            // already the GOT base plus the addend.
            rt::R_386_PC32 | rt::R_386_PC16 | rt::R_386_PC8 | rt::R_386_GOTPC | rt::R_386_PLT32 => {
                sa.wrapping_sub(p)
            }
            rt::R_386_GOTOFF => match self.got_symbol_addr() {
                Some(g) => sa.wrapping_sub(g),
                None => {
                    errors.push(format!(
                        "{} against `{}' with no GOT",
                        rt::i386_reloc_desc(r.rtype),
                        name()
                    ));
                    return;
                }
            },
            other => {
                errors.push(format!(
                    "unsupported relocation {} against `{}'",
                    rt::i386_reloc_desc(other),
                    name()
                ));
                return;
            }
        };
        let Some(width) = rt::i386_field_width(r.rtype) else {
            return;
        };
        // bfd's `complain_overflow_bitfield` accepts a value that fits
        // the field read either as signed or as unsigned. A 32-bit
        // field holds every address of an ELF32 image.
        let sv = v as i64;
        let fits = match width {
            1 => (-0x80..=0xff).contains(&sv),
            2 => (-0x8000..=0xffff).contains(&sv),
            _ => true,
        };
        if !fits {
            errors.push(format!(
                "relocation truncated: {} against `{}' (0x{v:x})",
                rt::i386_reloc_desc(r.rtype),
                name()
            ));
        }
        let n = width as usize;
        if site + n <= buf.len() {
            buf[site..site + n].copy_from_slice(&v.to_le_bytes()[..n]);
        }
    }

    #[allow(clippy::too_many_arguments)]
    fn apply_aarch64(
        &self,
        buf: &mut [u8],
        site: usize,
        p: u64,
        sa: u64,
        r: &RawReloc,
        alloc: bool,
        relr_set: &HashSet<u64>,
        errors: &mut Vec<String>,
        oi: usize,
    ) {
        let name = || {
            let sym = &self.objects[oi].symbols[r.sym as usize];
            if sym.name.is_empty() {
                format!("section symbol {}", sym.shndx)
            } else {
                sym.name.clone()
            }
        };
        let rd32 = |buf: &[u8], site: usize| -> u32 {
            u32::from_le_bytes([buf[site], buf[site + 1], buf[site + 2], buf[site + 3]])
        };
        let wr32 = |buf: &mut [u8], site: usize, v: u32| {
            buf[site..site + 4].copy_from_slice(&v.to_le_bytes());
        };
        let page = |v: u64| v & !0xfffu64;
        match r.rtype {
            rt::R_AARCH64_ABS64 => {
                // Write the value in place unless it is a load-address
                // (slide-dependent) fixup deferred to the loader. A
                // slide-invariant absolute constant is always written;
                // an RELR-packed relative keeps its link-time value in
                // place (the RELR format has no explicit addend);
                // `--no-apply-dynamic-relocs` leaves only the RELA
                // relative slots at zero for the kernel to fill.
                let relative = self.opts.emit == LdsEmit::Dyn
                    && alloc
                    && self.reloc_is_relative(oi, r.sym as usize);
                let deferred =
                    relative && !relr_set.contains(&p) && !self.opts.apply_dynamic_relocs;
                if !deferred && site + 8 <= buf.len() {
                    buf[site..site + 8].copy_from_slice(&sa.to_le_bytes());
                }
            }
            rt::R_AARCH64_ABS32 => {
                // AAELF64: the check is `-2^31 <= X < 2^32`, so a
                // value outside 32 bits read either way is an error
                // rather than a narrowed address.
                if !rt::AbsCheck::SignedOrUnsigned.admits(sa as i64, 4) {
                    errors.push(format!(
                        "relocation truncated to fit: R_AARCH64_ABS32 against `{}' (0x{sa:x})",
                        name()
                    ));
                }
                if site + 4 <= buf.len() {
                    buf[site..site + 4].copy_from_slice(&(sa as u32).to_le_bytes());
                }
            }
            rt::R_AARCH64_ABS16 => {
                if !rt::AbsCheck::SignedOrUnsigned.admits(sa as i64, 2) {
                    errors.push(format!(
                        "relocation truncated to fit: R_AARCH64_ABS16 against `{}' (0x{sa:x})",
                        name()
                    ));
                }
                if site + 2 <= buf.len() {
                    buf[site..site + 2].copy_from_slice(&(sa as u16).to_le_bytes());
                }
            }
            rt::R_AARCH64_PREL64 => {
                if site + 8 <= buf.len() {
                    buf[site..site + 8].copy_from_slice(&sa.wrapping_sub(p).to_le_bytes());
                }
            }
            rt::R_AARCH64_PREL32 => {
                let v = sa.wrapping_sub(p) as i64;
                if (v as i32) as i64 != v {
                    errors.push(format!(
                        "relocation truncated: R_AARCH64_PREL32 against `{}'",
                        name()
                    ));
                }
                if site + 4 <= buf.len() {
                    buf[site..site + 4].copy_from_slice(&(v as i32).to_le_bytes());
                }
            }
            262 => {
                // R_AARCH64_PREL16
                let v = sa.wrapping_sub(p);
                if site + 2 <= buf.len() {
                    buf[site..site + 2].copy_from_slice(&(v as u16).to_le_bytes());
                }
            }
            rt::R_AARCH64_CALL26 | rt::R_AARCH64_JUMP26 => {
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 27)..(1i64 << 27)).contains(&v) {
                    errors.push(format!(
                        "branch out of range to `{}' (0x{v:x}); veneers TODO",
                        name()
                    ));
                    return;
                }
                let insn = rd32(buf, site) & 0xfc00_0000;
                wr32(buf, site, insn | (((v >> 2) as u32) & 0x03ff_ffff));
            }
            rt::R_AARCH64_ADR_PREL_PG_HI21 => {
                let v = (page(sa) as i64).wrapping_sub(page(p) as i64);
                if !(-(1i64 << 32)..(1i64 << 32)).contains(&v) {
                    errors.push(format!(
                        "ADR_PREL_PG_HI21 out of range against `{}'",
                        name()
                    ));
                    return;
                }
                let imm = (v >> 12) as u32;
                let insn = rd32(buf, site) & 0x9f00_001f;
                wr32(
                    buf,
                    site,
                    insn | ((imm & 3) << 29) | (((imm >> 2) & 0x7ffff) << 5),
                );
            }
            274 => {
                // R_AARCH64_ADR_PREL_LO21
                let v = sa.wrapping_sub(p) as i64;
                if !(-(1i64 << 20)..(1i64 << 20)).contains(&v) {
                    errors.push(format!("ADR_PREL_LO21 out of range against `{}'", name()));
                    return;
                }
                let imm = v as u32;
                let insn = rd32(buf, site) & 0x9f00_001f;
                wr32(
                    buf,
                    site,
                    insn | ((imm & 3) << 29) | (((imm >> 2) & 0x7ffff) << 5),
                );
            }
            rt::R_AARCH64_ADD_ABS_LO12_NC => {
                let insn = rd32(buf, site) & 0xffc0_03ff;
                wr32(buf, site, insn | (((sa & 0xfff) as u32) << 10));
            }
            rt::R_AARCH64_LDST8_ABS_LO12_NC
            | rt::R_AARCH64_LDST16_ABS_LO12_NC
            | rt::R_AARCH64_LDST32_ABS_LO12_NC
            | rt::R_AARCH64_LDST64_ABS_LO12_NC
            | rt::R_AARCH64_LDST128_ABS_LO12_NC => {
                let scale = rt::aarch64_ldst_lo12_scale(r.rtype).unwrap_or(1);
                let imm = ((sa & 0xfff) / scale as u64) as u32;
                let insn = rd32(buf, site) & 0xffc0_03ff;
                wr32(buf, site, insn | (imm << 10));
            }
            280 => {
                // R_AARCH64_CONDBR19
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 20)..(1i64 << 20)).contains(&v) {
                    errors.push(format!("CONDBR19 out of range against `{}'", name()));
                    return;
                }
                let insn = rd32(buf, site) & 0xff00_001f;
                wr32(buf, site, insn | ((((v >> 2) as u32) & 0x7ffff) << 5));
            }
            279 => {
                // R_AARCH64_TSTBR14
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 15)..(1i64 << 15)).contains(&v) {
                    errors.push(format!("TSTBR14 out of range against `{}'", name()));
                    return;
                }
                let insn = rd32(buf, site) & 0xfff8_001f;
                wr32(buf, site, insn | ((((v >> 2) as u32) & 0x3fff) << 5));
            }
            273 => {
                // R_AARCH64_LD_PREL_LO19
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 20)..(1i64 << 20)).contains(&v) {
                    errors.push(format!("LD_PREL_LO19 out of range against `{}'", name()));
                    return;
                }
                let insn = rd32(buf, site) & 0xff00_001f;
                wr32(buf, site, insn | ((((v >> 2) as u32) & 0x7ffff) << 5));
            }
            _ if rt::aarch64_movw_field(r.rtype).is_some() => {
                // R_AARCH64_MOVW_[SU]ABS_G*: one 16-bit group of the
                // absolute value into a `movz` / `movk` immediate.
                use crate::c5::codegen::aarch64::patch;
                let (group, signed, check) =
                    rt::aarch64_movw_field(r.rtype).expect("guarded by the arm");
                let v = sa as i64;
                if let Some(bits) = check
                    && !patch::movw_fits(v, bits, signed)
                {
                    errors.push(format!(
                        "{} overflow against `{}' (0x{sa:x})",
                        rt::aarch64_reloc_desc(r.rtype),
                        name()
                    ));
                }
                wr32(
                    buf,
                    site,
                    patch::movw_word(rd32(buf, site), group, signed, v),
                );
            }
            rt::R_AARCH64_ADR_GOT_PAGE | rt::R_AARCH64_LD64_GOT_LO12_NC => {
                let slot = self.got_slot_addr(oi, r);
                let Some(slot) = slot else {
                    errors.push(format!("no GOT slot for `{}'", name()));
                    return;
                };
                if r.rtype == rt::R_AARCH64_ADR_GOT_PAGE {
                    let v = (page(slot) as i64).wrapping_sub(page(p) as i64);
                    let imm = (v >> 12) as u32;
                    let insn = rd32(buf, site) & 0x9f00_001f;
                    wr32(
                        buf,
                        site,
                        insn | ((imm & 3) << 29) | (((imm >> 2) & 0x7ffff) << 5),
                    );
                } else {
                    let imm = (((slot & 0xfff) / 8) as u32) & 0xfff;
                    let insn = rd32(buf, site) & 0xffc0_03ff;
                    wr32(buf, site, insn | (imm << 10));
                }
            }
            0 => {}
            other => {
                errors.push(format!(
                    "unsupported relocation {} against `{}'",
                    rt::aarch64_reloc_desc(other),
                    name()
                ));
            }
        }
    }

    fn got_slot_addr(&self, oi: usize, r: &RawReloc) -> Option<u64> {
        let name = &self.objects[oi].symbols[r.sym as usize].name;
        let idx = *self.got_map.get(name)?;
        Some(self.got_slot_base()? + idx as u64 * self.class.addr_size())
    }

    /// Write the synthesized sections' content: dynamic relocation
    /// tables, GOT slots, and the build-id note body (digest patched
    /// after the image is assembled).
    fn fill_synth_contents(
        &mut self,
        contents: &mut HashMap<usize, Vec<u8>>,
        relr_set: &HashSet<u64>,
        out_shndx: &dyn Fn(usize) -> u16,
    ) {
        // Rebuild with the final section indices; the tables the sizing
        // pass produced carry placeholder ones.
        self.build_dyn_tables(out_shndx);
        let addrs = self.dyn_addrs();
        let dyn_section_addr = self.dyn_section_addr();
        let class = self.class;
        let dynamic_bytes = dynamic::build_dynamic(&addrs, class);
        let (rela_name, _, rela_ent) = self.dyn_reloc_kind();
        let slot = class.addr_size();
        let aw = slot as usize;
        let use_rela = machine_uses_rela(self.machine);
        let synth = self.synth_obj;
        for sec_idx in 0..self.objects[synth].sections.len() {
            let name = self.objects[synth].sections[sec_idx].name.clone();
            let i = self.insec_index(synth, sec_idx);
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            if self.outs[out].removed {
                continue;
            }
            let off = self.placements[i].off as usize;
            let mut bytes: Vec<u8> = Vec::new();
            if name == rela_name {
                // Reserved slots stay zeroed (R_*_NONE) ahead of the
                // live entries, as bfd leaves them.
                bytes.resize(self.dyn_nones.unwrap_or(0) as usize * rela_ent as usize, 0);
                for d in &self.dyn_relas {
                    bytes.extend_from_slice(&class.addr_bytes(d.offset)[..aw]);
                    bytes.extend_from_slice(
                        &class.addr_bytes(class.reloc_info(d.sym, d.rtype))[..aw],
                    );
                    if use_rela {
                        bytes.extend_from_slice(&class.addr_bytes(d.addend as u64)[..aw]);
                    }
                }
            } else {
                match name.as_str() {
                    SYNTH_RELR => {
                        for wdd in encode_relr(&self.relr_addrs, slot) {
                            bytes.extend_from_slice(&class.addr_bytes(wdd)[..slot as usize]);
                        }
                    }
                    SYNTH_GOT if self.objects[synth].sections[sec_idx].size == 0 => {}
                    SYNTH_GOT => {
                        // The header slot holds the `.dynamic` address, as
                        // bfd writes `_GLOBAL_OFFSET_TABLE_[0]`.
                        if self.got_reserved() != 0 {
                            bytes.extend_from_slice(
                                &class.addr_bytes(dyn_section_addr.unwrap_or(0))[..aw],
                            );
                        }
                        let base = self.got_slot_base().unwrap_or(0);
                        for (k, gname) in self.got_slots.clone().iter().enumerate() {
                            let v = self.resolve_name(gname).unwrap_or(0);
                            let slot_addr = base + k as u64 * slot;
                            let write =
                                relr_set.contains(&slot_addr) || self.opts.apply_dynamic_relocs;
                            bytes.extend_from_slice(
                                &class.addr_bytes(if write { v } else { 0 })[..aw],
                            );
                        }
                    }
                    SYNTH_GOTPLT => {
                        bytes.resize(3 * aw, 0);
                        // Where `_GLOBAL_OFFSET_TABLE_` names this
                        // section, its first slot is the header the
                        // psABI points at `.dynamic`; the next two are
                        // the dynamic linker's.
                        if self.got_on_got_plt() {
                            bytes[..aw].copy_from_slice(
                                &class.addr_bytes(dyn_section_addr.unwrap_or(0))[..aw],
                            );
                        }
                    }
                    SYNTH_BUILD_ID => {
                        bytes.extend_from_slice(&4u32.to_le_bytes()); // namesz
                        bytes.extend_from_slice(&20u32.to_le_bytes()); // descsz
                        bytes.extend_from_slice(&3u32.to_le_bytes()); // NT_GNU_BUILD_ID
                        bytes.extend_from_slice(b"GNU\0");
                        bytes.extend_from_slice(&[0u8; 20]);
                    }
                    SYNTH_GNU_PROPERTY => bytes = self.gnu_property.clone(),
                    SYNTH_INTERP => {
                        bytes = self.opts.interp.clone().unwrap_or_default().into_bytes();
                        bytes.push(0);
                    }
                    SYNTH_PLT => bytes = self.plt_bytes(),
                    SYNTH_DYNAMIC => bytes = dynamic_bytes.clone(),
                    SYNTH_EH_FRAME_HDR => {
                        let Some(hdr_addr) = self.synth_addr(SYNTH_EH_FRAME_HDR) else {
                            continue;
                        };
                        let Some((eh_out, eh_addr)) = self
                            .outs
                            .iter()
                            .position(|o| o.name == OUT_EH_FRAME && !o.removed)
                            .map(|k| (k, self.outs[k].addr))
                        else {
                            continue;
                        };
                        // The linked `.eh_frame` is relocated by now, so
                        // its FDE pointers name final addresses.
                        let Some(body) = contents.get(&eh_out) else {
                            continue;
                        };
                        match eh_frame::scan(body, eh_addr)
                            .and_then(|e| eh_frame::build(hdr_addr, eh_addr, &e))
                        {
                            Ok(b) => bytes = b,
                            Err(e) => {
                                self.errors.push(e);
                                continue;
                            }
                        }
                    }
                    SYNTH_DYNSYM | SYNTH_DYNSTR | SYNTH_HASH | SYNTH_GNU_HASH | SYNTH_VERSYM
                    | SYNTH_VERDEF => {
                        let Some(t) = &self.dyn_tables else {
                            continue;
                        };
                        bytes = match name.as_str() {
                            SYNTH_DYNSYM => t.dynsym.clone(),
                            SYNTH_DYNSTR => t.dynstr().to_vec(),
                            SYNTH_HASH => t.hash.clone(),
                            SYNTH_GNU_HASH => t.gnu_hash.clone(),
                            SYNTH_VERSYM => t.versym.clone(),
                            _ => t.verdef.clone(),
                        };
                    }
                    _ => continue,
                }
            }
            // Content longer than the section sized for it means the
            // sizing pass and the writer disagreed. Truncating leaves a
            // table a consumer indexes past the end of, so it is a link
            // failure rather than a silent short write.
            if bytes.len() > self.objects[synth].sections[sec_idx].size as usize {
                self.errors.push(format!(
                    "internal: `{name}' holds {} bytes in a section sized {}",
                    bytes.len(),
                    self.objects[synth].sections[sec_idx].size
                ));
                continue;
            }
            if let Some(buf) = contents.get_mut(&out) {
                let n = bytes.len().min(buf.len().saturating_sub(off));
                buf[off..off + n].copy_from_slice(&bytes[..n]);
            }
        }
    }

    // -------------------------------------------------------- phdrs

    fn build_phdrs(
        &mut self,
        emit_order: &[usize],
    ) -> Result<Vec<(Elf64Phdr, Vec<usize>)>, C5Error> {
        if let Some(defs) = self.script.phdrs() {
            let defs = defs.to_owned();
            let mut segs: Vec<(Elf64Phdr, Vec<usize>)> = defs
                .iter()
                .map(|d| {
                    let flags = d.flags.as_ref().map(|e| self.eval(e).v as u32).unwrap_or(0);
                    (
                        Elf64Phdr {
                            p_type: d.ptype,
                            p_flags: flags,
                            p_align: if d.ptype == PT_LOAD {
                                self.opts.max_page_size
                            } else {
                                4
                            },
                            ..Default::default()
                        },
                        Vec::new(),
                    )
                })
                .collect();
            let name_idx: HashMap<&str, usize> = defs
                .iter()
                .enumerate()
                .map(|(i, d)| (d.name.as_str(), i))
                .collect();
            // `:phdr` carries to following sections that name none.
            // The carry runs over the script's section list, not the
            // kept one, so an empty section still passes its
            // assignment on -- an empty `.hash` ahead of `.gnu.hash`
            // is how the vDSO scripts rely on it.
            let kept: HashSet<usize> = emit_order.iter().copied().collect();
            let mut inherit: Vec<usize> = Vec::new();
            for st in &self.stmts {
                let Stmt::Open(oi) = st else { continue };
                let oi = *oi;
                if !self.outs[oi].alloc && kept.contains(&oi) {
                    continue;
                }
                let named = &self.outs[oi].phdrs;
                if !named.is_empty() {
                    let mut set = Vec::new();
                    for n in named {
                        match name_idx.get(n.as_str()) {
                            Some(&k) => set.push(k),
                            None => {
                                return Err(err(&format!(
                                    "output section `{}' names unknown program header `{n}'",
                                    self.outs[oi].name
                                )));
                            }
                        }
                    }
                    inherit = set;
                }
                if !kept.contains(&oi) || !self.outs[oi].alloc {
                    continue;
                }
                for &k in &inherit {
                    segs[k].1.push(oi);
                }
            }
            self.set_phdr_alignments(&mut segs);
            Ok(segs)
        } else {
            // No PHDRS command: bfd's default segment assignment
            // (`_bfd_elf_map_sections_to_segments`). A new PT_LOAD
            // begins where the section would leave a page of the
            // segment unused, where the LMA stops tracking the VMA,
            // and where the protection changes -- the last only when
            // the section does not share the previous one's page,
            // since a page carries one protection anyway. File-backed
            // content following zero fill stays in the segment; the
            // zero fill then occupies file space.
            let page = self.opts.max_page_size.max(1);
            let mut segs: Vec<(Elf64Phdr, Vec<usize>)> = Vec::new();
            let mut cur: Option<usize> = None;
            let mut cur_writable = false;
            let mut cur_code = false;
            let mut prev_end = 0u64;
            let mut prev_bias = 0u64;
            for &oi in emit_order {
                let o = &self.outs[oi];
                if !o.alloc {
                    continue;
                }
                let writable = o.flags & SHF_WRITE != 0;
                let code = o.flags & SHF_EXECINSTR != 0;
                let nobits = o.shtype == SHT_NOBITS;
                let bias = o.lma.wrapping_sub(o.addr);
                let same_page = prev_end.saturating_sub(1) & !(page - 1) == o.addr & !(page - 1);
                let protection_change = (writable && !cur_writable) || code != cur_code;
                let start_new = match cur {
                    None => true,
                    Some(_) => {
                        bias != prev_bias
                            || align_up(prev_end, page) < align_up(o.addr, page)
                            || (protection_change && !same_page)
                    }
                };
                if start_new {
                    segs.push((
                        Elf64Phdr {
                            p_type: PT_LOAD,
                            p_flags: PF_R,
                            p_align: page,
                            ..Default::default()
                        },
                        Vec::new(),
                    ));
                    cur = Some(segs.len() - 1);
                    cur_writable = writable;
                    cur_code = code;
                }
                cur_writable |= writable;
                cur_code |= code;
                prev_bias = bias;
                // Zero-size TLS zero fill overlays the following
                // section rather than occupying its own addresses.
                if !nobits || o.flags & SHF_TLS == 0 {
                    prev_end = o.addr + o.size;
                }
                let k = cur.expect("current segment exists");
                segs[k].1.push(oi);
                let mut fl = PF_R;
                if writable {
                    fl |= PF_W;
                }
                if code {
                    fl |= PF_X;
                }
                segs[k].0.p_flags |= fl;
            }
            // PT_NOTE per run of NOTE sections.
            let mut note_members: Vec<usize> = Vec::new();
            let mut note_runs: Vec<Vec<usize>> = Vec::new();
            for &oi in emit_order {
                let o = &self.outs[oi];
                let contiguous = note_members
                    .last()
                    .map(|&p: &usize| self.outs[p].addr + self.outs[p].size == o.addr)
                    .unwrap_or(true);
                if o.alloc && o.shtype == SHT_NOTE && contiguous {
                    note_members.push(oi);
                    continue;
                }
                // A segment covers a range, so a note section separated
                // from the previous one by anything else starts a new
                // PT_NOTE rather than pulling what lies between into
                // the walk a consumer makes over the segment.
                if !note_members.is_empty() {
                    note_runs.push(core::mem::take(&mut note_members));
                }
                if o.alloc && o.shtype == SHT_NOTE {
                    note_members.push(oi);
                }
            }
            if !note_members.is_empty() {
                note_runs.push(note_members);
            }
            for run in note_runs {
                segs.push((
                    Elf64Phdr {
                        p_type: PT_NOTE,
                        p_flags: PF_R,
                        p_align: 4,
                        ..Default::default()
                    },
                    run,
                ));
            }
            // PT_DYNAMIC over `.dynamic`, so a loader finds the tables
            // without walking section headers; PT_GNU_EH_FRAME over
            // `.eh_frame_hdr`, which is how an unwinder finds it;
            // PT_GNU_PROPERTY over the merged note, which is where a
            // loader looks for the image's feature claims.
            for (name, ptype, flags, align) in [
                (SYNTH_INTERP, PT_INTERP, PF_R, 1),
                (SYNTH_DYNAMIC, PT_DYNAMIC, PF_R | PF_W, 8),
                (SYNTH_EH_FRAME_HDR, PT_GNU_EH_FRAME, PF_R, 8),
                (SYNTH_GNU_PROPERTY, PT_GNU_PROPERTY, PF_R, 8),
            ] {
                if let Some(&oi) = emit_order
                    .iter()
                    .find(|&&oi| self.outs[oi].alloc && self.outs[oi].name == name)
                {
                    segs.push((
                        Elf64Phdr {
                            p_type: ptype,
                            p_flags: flags,
                            p_align: align,
                            ..Default::default()
                        },
                        alloc::vec![oi],
                    ));
                }
            }
            segs.push((
                Elf64Phdr {
                    p_type: PT_GNU_STACK,
                    p_flags: PF_R | PF_W,
                    p_align: 0x10,
                    ..Default::default()
                },
                Vec::new(),
            ));
            self.set_phdr_alignments(&mut segs);
            // An interpreted image needs PT_PHDR ahead of every
            // loadable entry: a loader takes the load bias from it, and
            // bfd pairs it with PT_INTERP for that reason. Its extent
            // is the header table itself, filled once the count and the
            // first segment's address are known.
            if emit_order
                .iter()
                .any(|&oi| self.outs[oi].alloc && self.outs[oi].name == SYNTH_INTERP)
            {
                segs.insert(
                    0,
                    (
                        Elf64Phdr {
                            p_type: PT_PHDR,
                            p_flags: PF_R,
                            p_align: 8,
                            ..Default::default()
                        },
                        Vec::new(),
                    ),
                );
            }
            Ok(segs)
        }
    }

    /// Segment alignment once membership is known: a `PT_LOAD` pages
    /// unless `-n` asked otherwise, and every other segment takes the
    /// strongest alignment among its sections, as bfd's does.
    fn set_phdr_alignments(&self, segs: &mut [(Elf64Phdr, Vec<usize>)]) {
        for (ph, members) in segs.iter_mut() {
            let member_align = members
                .iter()
                .map(|&oi| self.outs[oi].align)
                .max()
                .unwrap_or(0);
            if ph.p_type == PT_LOAD {
                if self.opts.nmagic {
                    ph.p_align = member_align.max(1);
                }
            } else if member_align != 0 {
                ph.p_align = member_align;
            }
        }
    }

    // ------------------------------------------------------- symtab

    /// `sh_link` of an `SHF_LINK_ORDER` output section: the output
    /// section holding what its inputs are ordered against, as bfd
    /// records in `assign_section_numbers`. Zero when the target went
    /// away with its section.
    fn link_order_target(&self, oi: usize, shndx_of_out: &HashMap<usize, u16>) -> u32 {
        let Some(i) = self.first_input(oi) else {
            return 0;
        };
        let id = self.insecs[i];
        let sec = &self.objects[id.obj].sections[id.sec];
        let Some(&target) = self.objects[id.obj].shndx_map.get(&sec.link) else {
            return 0;
        };
        match self.fates[self.insec_index(id.obj, target)] {
            SecFate::Placed { out } => shndx_of_out.get(&out).copied().unwrap_or(0) as u32,
            _ => 0,
        }
    }

    /// First input section placed into an output section.
    fn first_input(&self, oi: usize) -> Option<usize> {
        self.outs[oi].pieces.iter().find_map(|p| match p {
            Piece::Inputs(v) => v.first().copied(),
            _ => None,
        })
    }

    /// Section flags of the input section a symbol is defined in, zero
    /// for a symbol that names no section.
    fn sym_input_flags(&self, obj_i: usize, sym_i: usize) -> u64 {
        let sym = &self.objects[obj_i].symbols[sym_i];
        match self.objects[obj_i].shndx_map.get(&sym.shndx) {
            Some(&sec) => self.objects[obj_i].sections[sec].flags,
            None => 0,
        }
    }

    /// Object order for local symbols: bfd walks the output sections
    /// and takes each object the first time one of its input sections
    /// is reached, then sweeps the objects no output section took.
    fn local_symbol_object_order(&self, emit_order: &[usize]) -> Vec<usize> {
        let mut seen = alloc::vec![false; self.objects.len()];
        let mut order: Vec<usize> = Vec::new();
        if self.synth_obj < seen.len() {
            seen[self.synth_obj] = true;
        }
        for &oi in emit_order {
            for p in &self.outs[oi].pieces {
                let Piece::Inputs(v) = p else { continue };
                for &i in v {
                    let obj = self.insecs[i].obj;
                    if !seen[obj] {
                        seen[obj] = true;
                        order.push(obj);
                    }
                }
            }
        }
        for (obj, taken) in seen.iter().enumerate() {
            if !taken {
                order.push(obj);
            }
        }
        order
    }

    fn build_symtab(
        &self,
        emit_order: &[usize],
        out_shndx: &dyn Fn(usize) -> u16,
        index: &mut SymIndex,
    ) -> Vec<FinalSym> {
        let track = self.opts.emit_relocs;
        let mut syms: Vec<FinalSym> = Vec::new();
        // Section symbols exist for relocations to name, so bfd emits
        // them only when the output carries relocations
        // (`bfd_link_relocatable(info) || info->emitrelocations`). This
        // engine writes no relocatable output; `-r` is a separate path.
        if track {
            for &oi in emit_order {
                index.sec.insert(oi, syms.len());
                syms.push(FinalSym {
                    name: String::new(),
                    info: STT_SECTION,
                    other: 0,
                    shndx: out_shndx(oi),
                    value: self.outs[oi].addr,
                    size: 0,
                });
            }
        }
        // Local symbols per input object, in the order bfd reaches the
        // objects.
        for obj_i in self.local_symbol_object_order(emit_order) {
            let o = &self.objects[obj_i];
            // bfd carries the file symbol of the object whose locals
            // follow, synthesizing one from the input's name when the
            // object has none, so a local is never read as belonging
            // to the preceding file.
            let mut have_file = false;
            for (sym_i, sym) in o.symbols.iter().enumerate() {
                if sym.binding() != STB_LOCAL || sym.kind() == STT_SECTION {
                    continue;
                }
                if sym.kind() == STT_FILE {
                    have_file = true;
                    if track {
                        index.local.insert((obj_i, sym_i as u32), syms.len());
                    }
                    syms.push(FinalSym {
                        name: sym.name.clone(),
                        info: sym.info,
                        other: sym.other,
                        shndx: SHN_ABS,
                        value: 0,
                        size: 0,
                    });
                    continue;
                }
                // `-X` drops every compiler temporary; bfd's default
                // policy drops the ones a merged section holds, whose
                // offsets deduplication moves, unless the link emits
                // relocations that can name them.
                if !self.opts.discard_none
                    && sym.name.starts_with(".L")
                    && (self.opts.discard_locals
                        || (!track && self.sym_input_flags(obj_i, sym_i) & SHF_MERGE != 0))
                {
                    continue;
                }
                if let Some(fs) = self.finalize_sym(obj_i, sym_i, out_shndx) {
                    if !have_file {
                        have_file = true;
                        syms.push(FinalSym {
                            name: file_sym_name(&o.source),
                            info: (STB_LOCAL << 4) | STT_FILE,
                            other: 0,
                            shndx: SHN_ABS,
                            value: 0,
                            size: 0,
                        });
                    }
                    if track {
                        index.local.insert((obj_i, sym_i as u32), syms.len());
                    }
                    syms.push(fs);
                }
            }
        }
        // A symbol's visibility aggregates over every reference and
        // definition; hidden or internal globals cannot be preempted
        // and are emitted with local binding. bfd applies the forcing
        // from the dynamic-symbol adjustment, so only links with
        // dynamic sections see it.
        let mut forced_vis: HashMap<&str, u8> = HashMap::new();
        if self.opts.emit == LdsEmit::Dyn {
            for o in &self.objects {
                for sym in &o.symbols {
                    let vis = sym.other & 0x3;
                    if sym.binding() == STB_LOCAL || sym.name.is_empty() || vis == 0 || vis == 3 {
                        continue;
                    }
                    let e = forced_vis.entry(sym.name.as_str()).or_insert(vis);
                    // INTERNAL(1) constrains more than HIDDEN(2).
                    *e = (*e).min(vis);
                }
            }
        }
        // Resolved global definitions, name order (the table order is
        // not part of the contract; nm sorts).
        let mut global_defs: Vec<(&String, (usize, usize))> =
            self.globals.iter().map(|(n, &d)| (n, d)).collect();
        global_defs.sort_by(|a, b| a.0.cmp(b.0));
        for (name, (obj_i, sym_i)) in global_defs {
            if self.script_now.contains_key(name) {
                continue; // script assignment overrides
            }
            if let Some(mut fs) = self.finalize_sym(obj_i, sym_i, out_shndx) {
                if let Some(&vis) = forced_vis.get(name.as_str()) {
                    fs.info = (STB_LOCAL << 4) | (fs.info & 0xf);
                    fs.other = vis;
                }
                if track {
                    index.by_name.insert(name.clone(), syms.len());
                }
                syms.push(fs);
            }
        }
        // Script-defined symbols.
        let mut script_syms: Vec<(&String, &ScriptSym)> = self.script_now.iter().collect();
        script_syms.sort_by(|a, b| a.0.cmp(b.0));
        for (name, s) in script_syms {
            let shndx = match (s.val.att, s.final_out) {
                (Att::Out(oi), _) => out_shndx(oi),
                (_, Some(oi)) => out_shndx(oi),
                (_, None) => SHN_ABS,
            };
            let vis = forced_vis
                .get(name.as_str())
                .copied()
                .or(s.hidden.then_some(STV_HIDDEN));
            if track {
                index.by_name.insert(name.clone(), syms.len());
            }
            syms.push(FinalSym {
                name: name.clone(),
                info: (if vis.is_some() { STB_LOCAL } else { STB_GLOBAL } << 4) | s.kind,
                other: vis.or(s.vis).unwrap_or(STV_DEFAULT),
                shndx,
                value: s.val.v,
                size: 0,
            });
        }
        // An undefined weak symbol reaches the table only where the
        // output still names it: bfd keeps the ones its relocations
        // reference and drops the rest, so a final link that emits no
        // relocations carries none of them.
        let mut weak_undefs: BTreeSet<&String> = BTreeSet::new();
        for r in &self.emitted {
            let sym = &self.objects[r.obj].symbols[r.sym as usize];
            if sym.shndx as u16 == SHN_UNDEF
                && sym.binding() == STB_WEAK
                && !sym.name.is_empty()
                && !self.globals.contains_key(&sym.name)
                && !self.script_now.contains_key(&sym.name)
            {
                weak_undefs.insert(&sym.name);
            }
        }
        for name in weak_undefs {
            if track {
                index.by_name.insert(name.clone(), syms.len());
            }
            syms.push(FinalSym {
                name: name.clone(),
                info: (STB_WEAK << 4) | STT_NOTYPE,
                other: 0,
                shndx: SHN_UNDEF,
                value: 0,
                size: 0,
            });
        }
        syms
    }

    fn finalize_sym(
        &self,
        obj_i: usize,
        sym_i: usize,
        out_shndx: &dyn Fn(usize) -> u16,
    ) -> Option<FinalSym> {
        let sym = &self.objects[obj_i].symbols[sym_i];
        match sym.shndx as u16 {
            SHN_ABS => Some(FinalSym {
                name: sym.name.clone(),
                info: sym.info,
                other: sym.other,
                shndx: SHN_ABS,
                value: sym.value,
                size: sym.size,
            }),
            SHN_UNDEF | SHN_COMMON => None,
            _ => {
                let sec = *self.objects[obj_i].shndx_map.get(&sym.shndx)?;
                let i = self.insec_index(obj_i, sec);
                match self.fates[i] {
                    SecFate::Placed { out } => {
                        let value = self.resolve_sym_prevpass(obj_i, sym_i, 0)?;
                        let shndx = if self.outs[out].removed {
                            SHN_ABS
                        } else {
                            out_shndx(out)
                        };
                        Some(FinalSym {
                            name: sym.name.clone(),
                            info: sym.info,
                            other: sym.other,
                            shndx,
                            value,
                            size: sym.size,
                        })
                    }
                    _ => None,
                }
            }
        }
    }

    /// `--emit-relocs` payloads: one `.rela.<outsec>` per output
    /// section that took relocations, entries in address order,
    /// `r_offset` the final address.
    fn emitted_rela_sections(
        &self,
        final_of: &[u32],
        syms: &[FinalSym],
    ) -> Result<Vec<(usize, Vec<u8>)>, C5Error> {
        let index = &self.sym_index;
        let class = self.class;
        let aw = class.addr_size() as usize;
        let use_rela = machine_uses_rela(self.machine);
        let ent = if use_rela {
            class.rela_size()
        } else {
            class.rel_size()
        };
        if self.emitted.is_empty() {
            return Ok(Vec::new());
        }
        let mut by_out: BTreeMap<usize, Vec<&EmittedReloc>> = BTreeMap::new();
        for r in &self.emitted {
            by_out.entry(r.out).or_default().push(r);
        }
        let mut unresolved: Vec<String> = Vec::new();
        let mut out: Vec<(usize, Vec<u8>)> = Vec::new();
        for (oi, mut recs) in by_out {
            recs.sort_by_key(|r| r.addr);
            let mut body: Vec<u8> = Vec::with_capacity(recs.len() * ent as usize);
            for r in recs {
                let slot = self.emitted_sym_slot(r, index);
                let sym = match slot {
                    Some(pos) => final_of[pos],
                    None => {
                        if unresolved.len() < 10 {
                            let s = &self.objects[r.obj].symbols[r.sym as usize];
                            unresolved.push(format!(
                                "  {}: --emit-relocs: symbol `{}' referenced at {:#x} is not \
                                 in the output symbol table",
                                self.objects[r.obj].source, s.name, r.addr
                            ));
                        }
                        0
                    }
                };
                // `S + A` reconstructs from the entry, so the addend
                // is the resolved target less the named symbol's value.
                let base = slot.map_or(0, |pos| syms[pos].value);
                let addend = r.target.wrapping_sub(base) as i64;
                let info = class.reloc_info(sym, r.rtype);
                body.extend_from_slice(&class.addr_bytes(r.addr)[..aw]);
                body.extend_from_slice(&class.addr_bytes(info)[..aw]);
                // SHT_REL keeps the addend in the relocated field, which
                // already holds it after the relocation was applied.
                if use_rela {
                    body.extend_from_slice(&class.addr_bytes(addend as u64)[..aw]);
                }
            }
            out.push((oi, body));
        }
        if !unresolved.is_empty() {
            return Err(err(&unresolved.join("\n")));
        }
        Ok(out)
    }

    /// The `build_symtab` slot an emitted relocation's symbol maps to:
    /// a global by name, a section reference through the output
    /// section's symbol, otherwise the surviving local.
    fn emitted_sym_slot(&self, r: &EmittedReloc, index: &SymIndex) -> Option<usize> {
        let sym = self.objects[r.obj].symbols.get(r.sym as usize)?;
        if sym.binding() != STB_LOCAL && !sym.name.is_empty() {
            return index.by_name.get(&sym.name).copied();
        }
        if sym.kind() == STT_SECTION {
            let sec = *self.objects[r.obj].shndx_map.get(&sym.shndx)?;
            let i = self.insec_index(r.obj, sec);
            let SecFate::Placed { out } = self.fates[i] else {
                return None;
            };
            return index.sec.get(&out).copied();
        }
        index.local.get(&(r.obj, r.sym)).copied()
    }

    // -------------------------------------------------------- writer

    fn write_image(
        &mut self,
        emit_order: &[usize],
        shndx_of_out: &HashMap<usize, u16>,
        contents: HashMap<usize, Vec<u8>>,
        mut phdrs: Vec<(Elf64Phdr, Vec<usize>)>,
        syms: Vec<FinalSym>,
        entry: u64,
    ) -> Result<Vec<u8>, C5Error> {
        let class = self.class;
        let phnum = phdrs.len();
        let headers_end = class.ehdr_size() + phnum as u64 * class.phdr_size();

        // File offsets. PT_LOAD members get congruent placement;
        // everything else follows section order.
        let mut file_off: HashMap<usize, u64> = HashMap::new();
        let mut pos = headers_end;
        // Which PT_LOAD each section belongs to (first membership).
        let mut load_of: HashMap<usize, usize> = HashMap::new();
        for (k, (ph, members)) in phdrs.iter().enumerate() {
            if ph.p_type != PT_LOAD {
                continue;
            }
            for &oi in members {
                load_of.entry(oi).or_insert(k);
            }
        }
        let mut load_positions: HashMap<usize, (u64, u64)> = HashMap::new(); // seg -> (off, vaddr)
        for &oi in emit_order {
            let (alloc, addr, size, nobits, salign) = {
                let o = &self.outs[oi];
                (o.alloc, o.addr, o.size, o.shtype == SHT_NOBITS, o.align)
            };
            if !alloc {
                continue;
            }
            match load_of.get(&oi) {
                Some(&seg) => {
                    if !load_positions.contains_key(&seg) {
                        // Smallest offset at or past the cursor
                        // congruent to the segment's vaddr modulo its
                        // alignment.
                        let a = phdrs[seg].0.p_align.max(1);
                        let want = addr % a;
                        let have = pos % a;
                        let off = if want >= have {
                            pos - have + want
                        } else {
                            pos - have + a + want
                        };
                        load_positions.insert(seg, (off, addr));
                    }
                    let (seg_off, seg_vaddr) = load_positions[&seg];
                    if nobits {
                        file_off.insert(oi, pos);
                    } else {
                        let off = seg_off + (addr - seg_vaddr);
                        file_off.insert(oi, off);
                        pos = pos.max(off + size);
                    }
                }
                None => {
                    let off = align_up(pos, salign.min(self.opts.max_page_size).max(1));
                    file_off.insert(oi, off);
                    if !nobits {
                        pos = off + size;
                    }
                }
            }
        }
        // Non-alloc sections after the load image.
        for &oi in emit_order {
            let o = &self.outs[oi];
            if o.alloc {
                continue;
            }
            let off = align_up(pos, o.align.max(1));
            file_off.insert(oi, off);
            if o.shtype != SHT_NOBITS {
                pos = off + o.size;
            }
        }

        // Program header extents. A segment the script declared
        // `FILEHDR`/`PHDRS` reaches back over those headers, so the
        // image a loader maps starts at the ELF header -- which is
        // what lets a consumer derive the load bias from the first
        // PT_LOAD.
        let defs = self.script.phdrs().unwrap_or(&[]).to_owned();
        // Absent a `PHDRS` command the first PT_LOAD covers them, which
        // is what bfd's default segment map does and what leaves the
        // headers mapped for a loader to read.
        let default_first_load = defs.is_empty().then(|| {
            phdrs
                .iter()
                .position(|(p, m)| p.p_type == PT_LOAD && !m.is_empty())
        });
        for (k, (ph, members)) in phdrs.iter_mut().enumerate() {
            if members.is_empty() {
                continue;
            }
            let first = members[0];
            ph.p_vaddr = self.outs[first].addr;
            ph.p_paddr = self.outs[first].lma;
            ph.p_offset = file_off[&first];
            if default_first_load == Some(Some(k)) && ph.p_offset <= ph.p_vaddr {
                let back = ph.p_offset;
                ph.p_offset = 0;
                ph.p_vaddr -= back;
                ph.p_paddr = ph.p_paddr.saturating_sub(back);
            }
            if let Some(d) = defs.get(k) {
                let cover = match (d.filehdr, d.phdrs) {
                    (true, _) => Some(0),
                    (false, true) => Some(class.ehdr_size()),
                    _ => None,
                };
                if let Some(want) = cover.filter(|&w| w < ph.p_offset) {
                    let back = ph.p_offset - want;
                    ph.p_offset = want;
                    ph.p_vaddr = ph.p_vaddr.saturating_sub(back);
                    ph.p_paddr = ph.p_paddr.saturating_sub(back);
                }
            }
            let mut file_end = ph.p_offset;
            let mut mem_end = ph.p_vaddr;
            for &oi in members.iter() {
                let o = &self.outs[oi];
                mem_end = mem_end.max(o.addr + o.size);
                if o.shtype != SHT_NOBITS {
                    file_end = file_end.max(file_off[&oi] + o.size);
                }
            }
            ph.p_filesz = file_end - ph.p_offset;
            ph.p_memsz = mem_end - ph.p_vaddr;
        }
        // PT_PHDR covers the header table, inside the segment that
        // reaches back over it.
        if let Some(load) = phdrs
            .iter()
            .find(|(p, m)| p.p_type == PT_LOAD && !m.is_empty())
            .map(|(p, _)| (p.p_offset, p.p_vaddr))
            && let Some((ph, _)) = phdrs.iter_mut().find(|(p, _)| p.p_type == PT_PHDR)
        {
            ph.p_offset = class.ehdr_size();
            ph.p_vaddr = load.1 + (class.ehdr_size() - load.0);
            ph.p_paddr = ph.p_vaddr;
            ph.p_filesz = phnum as u64 * class.phdr_size();
            ph.p_memsz = ph.p_filesz;
        }

        // Symbol/string tables.
        let mut strtab: Vec<u8> = alloc::vec![0];
        let mut sym_bytes: Vec<u8> = Vec::new();
        let mut locals = 1u32;
        let mut final_of: Vec<u32> = alloc::vec![0; syms.len()];
        {
            let push = |s: &FinalSym, strtab: &mut Vec<u8>, sym_bytes: &mut Vec<u8>| {
                let name_off = if s.name.is_empty() {
                    0
                } else {
                    let off = strtab.len() as u32;
                    strtab.extend_from_slice(s.name.as_bytes());
                    strtab.push(0);
                    off
                };
                sym_bytes.extend_from_slice(&name_off.to_le_bytes());
                // Elf32_Sym puts value and size ahead of st_info.
                if class.is32() {
                    sym_bytes.extend_from_slice(&(s.value as u32).to_le_bytes());
                    sym_bytes.extend_from_slice(&(s.size as u32).to_le_bytes());
                    sym_bytes.push(s.info);
                    sym_bytes.push(s.other);
                    sym_bytes.extend_from_slice(&s.shndx.to_le_bytes());
                } else {
                    sym_bytes.push(s.info);
                    sym_bytes.push(s.other);
                    sym_bytes.extend_from_slice(&s.shndx.to_le_bytes());
                    sym_bytes.extend_from_slice(&s.value.to_le_bytes());
                    sym_bytes.extend_from_slice(&s.size.to_le_bytes());
                }
            };
            // Null entry.
            sym_bytes.resize(class.sym_size() as usize, 0);
            let mut next = 1u32;
            for (i, s) in syms.iter().enumerate() {
                if s.info >> 4 == STB_LOCAL {
                    push(s, &mut strtab, &mut sym_bytes);
                    final_of[i] = next;
                    next += 1;
                    locals += 1;
                }
            }
            for (i, s) in syms.iter().enumerate() {
                if s.info >> 4 != STB_LOCAL {
                    push(s, &mut strtab, &mut sym_bytes);
                    final_of[i] = next;
                    next += 1;
                }
            }
        }

        let rela: Vec<(usize, Vec<u8>)> = self.emitted_rela_sections(&final_of, &syms)?;

        // Section header string table.
        let mut shstrtab: Vec<u8> = alloc::vec![0];
        let mut shname: HashMap<String, u32> = HashMap::new();
        let intern = |name: &str, shstrtab: &mut Vec<u8>, shname: &mut HashMap<String, u32>| {
            if let Some(&off) = shname.get(name) {
                return off;
            }
            let off = shstrtab.len() as u32;
            shstrtab.extend_from_slice(name.as_bytes());
            shstrtab.push(0);
            shname.insert(name.to_string(), off);
            off
        };

        let talign = class.addr_size();
        let symtab_off = align_up(pos, talign);
        let strtab_off = symtab_off + sym_bytes.len() as u64;
        let shstr_names: Vec<u32> = emit_order
            .iter()
            .map(|&oi| intern(&self.outs[oi].name.clone(), &mut shstrtab, &mut shname))
            .collect();
        let n_symtab = intern(".symtab", &mut shstrtab, &mut shname);
        let n_strtab = intern(".strtab", &mut shstrtab, &mut shname);
        let n_shstrtab = intern(".shstrtab", &mut shstrtab, &mut shname);
        // `--emit-relocs` writes the target's own relocation format:
        // `.rel.<sec>` where inputs carry implicit addends.
        let use_rela = machine_uses_rela(self.machine);
        let rela_names: Vec<u32> = rela
            .iter()
            .map(|(oi, _)| {
                let n = if use_rela {
                    format!(".rela{}", self.outs[*oi].name)
                } else {
                    format!(".rel{}", self.outs[*oi].name)
                };
                intern(&n, &mut shstrtab, &mut shname)
            })
            .collect();
        let shstr_off = strtab_off + strtab.len() as u64;
        let mut rela_off: Vec<u64> = Vec::with_capacity(rela.len());
        let mut pos_after = shstr_off + shstrtab.len() as u64;
        for (_, body) in &rela {
            let at = align_up(pos_after, talign);
            rela_off.push(at);
            pos_after = at + body.len() as u64;
        }
        let shoff = align_up(pos_after, talign);
        // null + sections + symtab + strtab + shstrtab + one per rela
        let shnum = emit_order.len() + 4 + rela.len();

        let mut image: Vec<u8> =
            alloc::vec![0u8; shoff as usize + shnum * class.shdr_size() as usize];

        // ELF header.
        let e_type = match self.opts.emit {
            LdsEmit::Exec => ET_EXEC,
            LdsEmit::Dyn => ET_DYN,
        };
        image[0..4].copy_from_slice(b"\x7fELF");
        image[4] = class.ei_class();
        image[5] = 1;
        image[6] = 1;
        image[16..18].copy_from_slice(&e_type.to_le_bytes());
        image[18..20].copy_from_slice(&self.machine.to_le_bytes());
        image[20..24].copy_from_slice(&1u32.to_le_bytes());
        let aw = class.addr_size() as usize;
        let put = |image: &mut Vec<u8>, at: usize, v: u64| {
            image[at..at + aw].copy_from_slice(&class.addr_bytes(v)[..aw]);
        };
        put(&mut image, 24, entry);
        put(&mut image, 24 + aw, class.ehdr_size());
        put(&mut image, 24 + 2 * aw, shoff);
        let hdr_tail = 24 + 3 * aw + 4;
        image[hdr_tail..hdr_tail + 2].copy_from_slice(&(class.ehdr_size() as u16).to_le_bytes());
        image[hdr_tail + 2..hdr_tail + 4]
            .copy_from_slice(&(class.phdr_size() as u16).to_le_bytes());
        image[hdr_tail + 4..hdr_tail + 6].copy_from_slice(&(phnum as u16).to_le_bytes());
        image[hdr_tail + 6..hdr_tail + 8]
            .copy_from_slice(&(class.shdr_size() as u16).to_le_bytes());
        image[hdr_tail + 8..hdr_tail + 10].copy_from_slice(&(shnum as u16).to_le_bytes());
        // `.shstrtab` keeps its index whether or not `--emit-relocs`
        // appended tables after it.
        image[hdr_tail + 10..hdr_tail + 12]
            .copy_from_slice(&((emit_order.len() + 3) as u16).to_le_bytes());

        // Program headers. Elf32_Phdr puts p_flags after the sizes.
        for (k, (ph, _)) in phdrs.iter().enumerate() {
            let at = class.ehdr_size() as usize + k * class.phdr_size() as usize;
            image[at..at + 4].copy_from_slice(&ph.p_type.to_le_bytes());
            let (word, flags_at) = if class.is32() {
                (at + 4, at + 24)
            } else {
                (at + 8, at + 4)
            };
            image[flags_at..flags_at + 4].copy_from_slice(&ph.p_flags.to_le_bytes());
            for (f, v) in [
                ph.p_offset,
                ph.p_vaddr,
                ph.p_paddr,
                ph.p_filesz,
                ph.p_memsz,
                ph.p_align,
            ]
            .into_iter()
            .enumerate()
            {
                // p_flags splits the ELF32 sequence before p_align.
                let skip = usize::from(class.is32() && f == 5) * 4;
                put(&mut image, word + f * aw + skip, v);
            }
        }

        // Section bodies.
        for &oi in emit_order {
            let o = &self.outs[oi];
            if o.shtype == SHT_NOBITS {
                continue;
            }
            if let Some(body) = contents.get(&oi) {
                let off = file_off[&oi] as usize;
                image[off..off + body.len()].copy_from_slice(body);
            }
        }
        image[symtab_off as usize..symtab_off as usize + sym_bytes.len()]
            .copy_from_slice(&sym_bytes);
        image[strtab_off as usize..strtab_off as usize + strtab.len()].copy_from_slice(&strtab);
        image[shstr_off as usize..shstr_off as usize + shstrtab.len()].copy_from_slice(&shstrtab);
        for (k, (_, body)) in rela.iter().enumerate() {
            let at = rela_off[k] as usize;
            image[at..at + body.len()].copy_from_slice(body);
        }

        // Section headers.
        let wr_shdr = |idx: usize, sh: Elf64Shdr, image: &mut Vec<u8>| {
            let at = shoff as usize + idx * class.shdr_size() as usize;
            image[at..at + 4].copy_from_slice(&sh.sh_name.to_le_bytes());
            image[at + 4..at + 8].copy_from_slice(&sh.sh_type.to_le_bytes());
            for (f, v) in [sh.sh_flags, sh.sh_addr, sh.sh_offset, sh.sh_size]
                .into_iter()
                .enumerate()
            {
                let o = at + 8 + f * aw;
                image[o..o + aw].copy_from_slice(&class.addr_bytes(v)[..aw]);
            }
            let o = at + 8 + 4 * aw;
            image[o..o + 4].copy_from_slice(&sh.sh_link.to_le_bytes());
            image[o + 4..o + 8].copy_from_slice(&sh.sh_info.to_le_bytes());
            for (f, v) in [sh.sh_addralign, sh.sh_entsize].into_iter().enumerate() {
                let o = o + 8 + f * aw;
                image[o..o + aw].copy_from_slice(&class.addr_bytes(v)[..aw]);
            }
        };
        // `sh_link`/`sh_info` for the dynamic tables: each names the
        // table a consumer must read alongside it.
        let out_index = |name: &str| -> u32 {
            emit_order
                .iter()
                .position(|&oi| self.outs[oi].name == name)
                .map(|k| k as u32 + 1)
                .unwrap_or(0)
        };
        let (dynsym_ndx, dynstr_ndx) = (out_index(SYNTH_DYNSYM), out_index(SYNTH_DYNSTR));
        let dyn_rel_name = self.dyn_reloc_name();
        for (k, &oi) in emit_order.iter().enumerate() {
            let o = &self.outs[oi];
            if o.name == dyn_rel_name {
                wr_shdr(
                    k + 1,
                    Elf64Shdr {
                        sh_name: shstr_names[k],
                        sh_type: o.shtype,
                        sh_flags: o.flags,
                        sh_addr: o.addr,
                        sh_offset: file_off[&oi],
                        sh_size: o.size,
                        sh_link: dynsym_ndx,
                        sh_info: 0,
                        sh_addralign: o.align,
                        sh_entsize: o.entsize,
                    },
                    &mut image,
                );
                continue;
            }
            let (sh_link, sh_info) = match o.name.as_str() {
                SYNTH_DYNSYM => (
                    dynstr_ndx,
                    self.dyn_tables
                        .as_ref()
                        .map(|t| t.first_global)
                        .unwrap_or(0),
                ),
                SYNTH_HASH | SYNTH_GNU_HASH | SYNTH_VERSYM => (dynsym_ndx, 0),
                SYNTH_VERDEF => (
                    dynstr_ndx,
                    self.dyn_tables
                        .as_ref()
                        .map(|t| t.verdef_count as u32)
                        .unwrap_or(0),
                ),
                SYNTH_DYNAMIC => (dynstr_ndx, 0),
                _ if o.flags & SHF_LINK_ORDER != 0 => (self.link_order_target(oi, shndx_of_out), 0),
                _ => (0, 0),
            };
            wr_shdr(
                k + 1,
                Elf64Shdr {
                    sh_name: shstr_names[k],
                    sh_type: o.shtype,
                    sh_flags: o.flags,
                    sh_addr: o.addr,
                    sh_offset: file_off[&oi],
                    sh_size: o.size,
                    sh_link,
                    sh_info,
                    sh_addralign: o.align,
                    sh_entsize: o.entsize,
                },
                &mut image,
            );
        }
        let symtab_idx = emit_order.len() + 1;
        wr_shdr(
            symtab_idx,
            Elf64Shdr {
                sh_name: n_symtab,
                sh_type: SHT_SYMTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: symtab_off,
                sh_size: sym_bytes.len() as u64,
                sh_link: (symtab_idx + 1) as u32,
                sh_info: locals,
                sh_addralign: talign,
                sh_entsize: class.sym_size(),
            },
            &mut image,
        );
        wr_shdr(
            symtab_idx + 1,
            Elf64Shdr {
                sh_name: n_strtab,
                sh_type: SHT_STRTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: strtab_off,
                sh_size: strtab.len() as u64,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 1,
                sh_entsize: 0,
            },
            &mut image,
        );
        wr_shdr(
            symtab_idx + 2,
            Elf64Shdr {
                sh_name: n_shstrtab,
                sh_type: SHT_STRTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: shstr_off,
                sh_size: shstrtab.len() as u64,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 1,
                sh_entsize: 0,
            },
            &mut image,
        );
        for (k, (oi, body)) in rela.iter().enumerate() {
            wr_shdr(
                symtab_idx + 3 + k,
                Elf64Shdr {
                    sh_name: rela_names[k],
                    sh_type: if use_rela { SHT_RELA } else { SHT_REL },
                    sh_flags: 0,
                    sh_addr: 0,
                    sh_offset: rela_off[k],
                    sh_size: body.len() as u64,
                    sh_link: symtab_idx as u32,
                    sh_info: shndx_of_out[oi] as u32,
                    sh_addralign: talign,
                    sh_entsize: if use_rela {
                        class.rela_size()
                    } else {
                        class.rel_size()
                    },
                },
                &mut image,
            );
        }

        // Build-id digest over the whole image with the digest field
        // zeroed (it already is), then patched in place.
        if self.opts.build_id_sha1
            && let Some((out, off)) = self.build_id_location()
            && !self.outs[out].removed
            && self.outs[out].shtype != SHT_NOBITS
        {
            let file_at = file_off[&out] + off + 16;
            let digest = sha1(&image);
            let at = file_at as usize;
            if at + 20 <= image.len() {
                image[at..at + 20].copy_from_slice(&digest);
            }
        }
        Ok(image)
    }

    fn build_id_location(&self) -> Option<(usize, u64)> {
        let synth = self.synth_obj;
        let sec = self.objects[synth]
            .sections
            .iter()
            .position(|s| s.name == SYNTH_BUILD_ID)?;
        let i = self.insec_index(synth, sec);
        match self.fates[i] {
            SecFate::Placed { out } => Some((out, self.placements[i].off)),
            _ => None,
        }
    }

    // ----------------------------------------------------------- map

    fn render_map(&self, emit_order: &[usize]) -> String {
        use core::fmt::Write as _;
        // bfd prints a vma at the target's address width.
        let w = self.class.addr_size() as usize * 2;
        let mut s = String::new();
        let _ = writeln!(s, "Memory Configuration\n");
        let _ = writeln!(
            s,
            "Name             Origin             Length             Attributes"
        );
        let _ = writeln!(
            s,
            "*default*        0x{:0w$x} 0x{:0w$x}\n",
            0,
            u64::MAX >> (64 - w * 4)
        );
        let _ = writeln!(s, "Linker script and memory map\n");
        for &oi in emit_order {
            let o = &self.outs[oi];
            let _ = writeln!(
                s,
                "{:<15} 0x{:0w$x} 0x{:x}{}",
                o.name,
                o.addr,
                o.size,
                if o.lma != o.addr {
                    format!(" load address 0x{:0w$x}", o.lma)
                } else {
                    String::new()
                }
            );
            for (off, len, src) in &o.chunks {
                if let ChunkSrc::Input(i) = src {
                    let id = self.insecs[*i];
                    let _ = writeln!(
                        s,
                        " {:<14} 0x{:0w$x} 0x{:x} {}",
                        self.insec(*i).name,
                        o.addr + off,
                        len,
                        self.objects[id.obj].source
                    );
                }
            }
        }
        s
    }
}

/// SHA-1 (FIPS 180-4), for `--build-id=sha1`.
fn sha1(data: &[u8]) -> [u8; 20] {
    let mut h: [u32; 5] = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0];
    let ml = (data.len() as u64).wrapping_mul(8);
    let mut block = [0u8; 64];
    let process = |h: &mut [u32; 5], chunk: &[u8]| {
        let mut w = [0u32; 80];
        for i in 0..16 {
            w[i] = u32::from_be_bytes([
                chunk[i * 4],
                chunk[i * 4 + 1],
                chunk[i * 4 + 2],
                chunk[i * 4 + 3],
            ]);
        }
        for i in 16..80 {
            w[i] = (w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16]).rotate_left(1);
        }
        let (mut a, mut b, mut c, mut d, mut e) = (h[0], h[1], h[2], h[3], h[4]);
        for (i, &wi) in w.iter().enumerate() {
            let (f, k) = match i {
                0..=19 => ((b & c) | ((!b) & d), 0x5A827999u32),
                20..=39 => (b ^ c ^ d, 0x6ED9EBA1),
                40..=59 => ((b & c) | (b & d) | (c & d), 0x8F1BBCDC),
                _ => (b ^ c ^ d, 0xCA62C1D6),
            };
            let tmp = a
                .rotate_left(5)
                .wrapping_add(f)
                .wrapping_add(e)
                .wrapping_add(k)
                .wrapping_add(wi);
            e = d;
            d = c;
            c = b.rotate_left(30);
            b = a;
            a = tmp;
        }
        h[0] = h[0].wrapping_add(a);
        h[1] = h[1].wrapping_add(b);
        h[2] = h[2].wrapping_add(c);
        h[3] = h[3].wrapping_add(d);
        h[4] = h[4].wrapping_add(e);
    };
    let mut i = 0;
    while i + 64 <= data.len() {
        process(&mut h, &data[i..i + 64]);
        i += 64;
    }
    let rest = data.len() - i;
    block[..rest].copy_from_slice(&data[i..]);
    block[rest] = 0x80;
    if rest + 1 > 56 {
        for b in block[rest + 1..].iter_mut() {
            *b = 0;
        }
        process(&mut h, &block.clone());
        block = [0u8; 64];
    }
    block[56..64].copy_from_slice(&ml.to_be_bytes());
    process(&mut h, &block.clone());
    let mut out = [0u8; 20];
    for (k, hv) in h.iter().enumerate() {
        out[k * 4..k * 4 + 4].copy_from_slice(&hv.to_be_bytes());
    }
    out
}

fn file_glob(pattern: &str, source: &str) -> bool {
    if pattern == "*" {
        return true;
    }
    if glob_match(pattern, source) {
        return true;
    }
    if !pattern.contains('/') {
        let base = source.rsplit('/').next().unwrap_or(source);
        // Archive members are labeled `lib.a(member.o)`.
        let base = base
            .split_once('(')
            .map(|(_, m)| m.trim_end_matches(')'))
            .unwrap_or(base);
        return glob_match(pattern, base);
    }
    false
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::linker::default_script::default_script;
    use crate::c5::linker::lds::parse_linker_script;

    /// `(name, sh_type, flags, addralign, bytes, relocs)` of a test section.
    type TestSec = (String, u32, u64, u64, Vec<u8>, Vec<RawReloc>);

    /// Minimal ET_REL builder for engine tests.
    struct TestObj {
        secs: Vec<TestSec>,
        // name, bind, kind, sec (usize::MAX = UNDEF, MAX-1 = ABS), value, size
        syms: Vec<(String, u8, u8, usize, u64, u64)>,
        entsizes: Vec<(usize, u64)>,
        // Symbol-list index -> st_other.
        sym_vis: Vec<(usize, u8)>,
        // Section index -> sh_link.
        links: Vec<(usize, u32)>,
        // Section index -> sh_info.
        infos: Vec<(usize, u32)>,
        // Flag word, signature symbol (index into `syms`), members.
        groups: Vec<(u32, usize, Vec<usize>)>,
    }

    impl TestObj {
        fn new() -> Self {
            TestObj {
                secs: Vec::new(),
                syms: Vec::new(),
                entsizes: Vec::new(),
                sym_vis: Vec::new(),
                links: Vec::new(),
                infos: Vec::new(),
                groups: Vec::new(),
            }
        }
        /// An `SHT_GROUP` section over `members`, signed by the symbol
        /// at `sig` in the order `sym` added them.
        fn group(mut self, flags: u32, sig: usize, members: &[usize]) -> Self {
            self.groups.push((flags, sig, members.to_vec()));
            self
        }
        fn sec(mut self, name: &str, shtype: u32, flags: u64, align: u64, body: &[u8]) -> Self {
            self.secs.push((
                name.to_string(),
                shtype,
                flags,
                align,
                body.to_vec(),
                Vec::new(),
            ));
            self
        }
        fn entsize(mut self, sec: usize, entsize: u64) -> Self {
            self.entsizes.push((sec, entsize));
            self
        }
        /// `sh_link` of `sec`, naming another section by its index.
        fn links_to(mut self, sec: usize, target: usize) -> Self {
            self.links.push((sec, target as u32 + 1));
            self
        }
        fn reloc(mut self, sec: usize, offset: u64, sym: u32, rtype: u32, addend: i64) -> Self {
            self.secs[sec].5.push(RawReloc {
                offset,
                sym,
                rtype,
                addend,
            });
            self
        }
        fn sym(
            mut self,
            name: &str,
            bind: u8,
            kind: u8,
            sec: usize,
            value: u64,
            size: u64,
        ) -> Self {
            self.syms
                .push((name.to_string(), bind, kind, sec, value, size));
            self
        }

        /// Set st_other (visibility) of the most recently added symbol.
        fn vis(mut self, other: u8) -> Self {
            self.sym_vis.push((self.syms.len() - 1, other));
            self
        }

        fn build(self, machine: u16) -> Vec<u8> {
            self.build_class(machine, ElfClass::Elf64, true)
        }

        /// `rela = false` stores each addend in the field it relocates
        /// and emits `SHT_REL` tables, the way gas does for i386.
        fn build_class(mut self, machine: u16, class: ElfClass, rela: bool) -> Vec<u8> {
            let aw = class.addr_size() as usize;
            let ent = if rela {
                class.rela_size() as usize
            } else {
                class.rel_size() as usize
            };
            if !rela {
                for (_, _, _, _, body, relocs) in self.secs.iter_mut() {
                    for r in relocs.iter() {
                        let w = rt::i386_field_width(r.rtype).unwrap_or(4) as usize;
                        let at = r.offset as usize;
                        if at + w <= body.len() {
                            body[at..at + w].copy_from_slice(&r.addend.to_le_bytes()[..w]);
                        }
                    }
                }
            }
            // A group becomes a section: the flag word followed by its
            // members' section indices, `sh_link` the symbol table and
            // `sh_info` the signature symbol.
            let specs = core::mem::take(&mut self.groups);
            let first_group = self.secs.len();
            for (flags, _, members) in &specs {
                let mut body = flags.to_le_bytes().to_vec();
                for &m in members {
                    body.extend_from_slice(&(m as u32 + 1).to_le_bytes());
                    self.secs[m].2 |= SHF_GROUP;
                }
                self.secs
                    .push((".group".to_string(), SHT_GROUP, 0, 4, body, Vec::new()));
            }
            let nsec = self.secs.len();
            for (k, (_, sig, _)) in specs.iter().enumerate() {
                self.links.push((first_group + k, 1 + nsec as u32));
                self.infos.push((first_group + k, (1 + nsec + sig) as u32));
                self.entsizes.push((first_group + k, 4));
            }
            let mut bodies: Vec<u8> = Vec::new();
            let mut body_off: Vec<usize> = Vec::new();
            for (_, shtype, _, _, body, _) in &self.secs {
                body_off.push(class.ehdr_size() as usize + bodies.len());
                if *shtype != SHT_NOBITS {
                    bodies.extend_from_slice(body);
                }
            }
            let sym_entry = |name: u32, info: u8, other: u8, shndx: u16, value: u64, size: u64| {
                let mut e = alloc::vec![0u8; class.sym_size() as usize];
                e[0..4].copy_from_slice(&name.to_le_bytes());
                if class.is32() {
                    e[4..8].copy_from_slice(&(value as u32).to_le_bytes());
                    e[8..12].copy_from_slice(&(size as u32).to_le_bytes());
                    e[12] = info;
                    e[13] = other;
                    e[14..16].copy_from_slice(&shndx.to_le_bytes());
                } else {
                    e[4] = info;
                    e[5] = other;
                    e[6..8].copy_from_slice(&shndx.to_le_bytes());
                    e[8..16].copy_from_slice(&value.to_le_bytes());
                    e[16..24].copy_from_slice(&size.to_le_bytes());
                }
                e
            };
            // Symtab: null + one section symbol per section + named.
            let mut strtab: Vec<u8> = alloc::vec![0];
            let mut symtab: Vec<u8> = alloc::vec![0; class.sym_size() as usize];
            for k in 0..nsec {
                symtab.extend_from_slice(&sym_entry(0, STT_SECTION, 0, (k + 1) as u16, 0, 0));
            }
            for (k, (name, bind, kind, sec, value, size)) in self.syms.iter().enumerate() {
                let noff = strtab.len() as u32;
                strtab.extend_from_slice(name.as_bytes());
                strtab.push(0);
                let other = self
                    .sym_vis
                    .iter()
                    .find(|&&(i, _)| i == k)
                    .map(|&(_, o)| o)
                    .unwrap_or(0);
                let shndx: u16 = if *sec == usize::MAX {
                    0
                } else if *sec == usize::MAX - 1 {
                    SHN_ABS
                } else {
                    (*sec + 1) as u16
                };
                symtab.extend_from_slice(&sym_entry(
                    noff,
                    (bind << 4) | kind,
                    other,
                    shndx,
                    *value,
                    *size,
                ));
            }
            let mut out: Vec<u8> = alloc::vec![0; class.ehdr_size() as usize];
            out.extend_from_slice(&bodies);
            let symtab_at = out.len();
            out.extend_from_slice(&symtab);
            let strtab_at = out.len();
            out.extend_from_slice(&strtab);
            let mut rela_at: Vec<(usize, usize, usize)> = Vec::new();
            for (k, (_, _, _, _, _, relocs)) in self.secs.iter().enumerate() {
                if relocs.is_empty() {
                    continue;
                }
                let at = out.len();
                for r in relocs {
                    out.extend_from_slice(&class.addr_bytes(r.offset)[..aw]);
                    let info = class.reloc_info(r.sym, r.rtype);
                    out.extend_from_slice(&class.addr_bytes(info)[..aw]);
                    if rela {
                        out.extend_from_slice(&class.addr_bytes(r.addend as u64)[..aw]);
                    }
                }
                rela_at.push((k, at, relocs.len()));
            }
            // Build shstrtab fully before emitting it.
            let mut shstr: Vec<u8> = alloc::vec![0];
            let mut names: Vec<u32> = Vec::new();
            let add_name = |n: &str, shstr: &mut Vec<u8>| -> u32 {
                let at = shstr.len() as u32;
                shstr.extend_from_slice(n.as_bytes());
                shstr.push(0);
                at
            };
            for (name, ..) in &self.secs {
                names.push(add_name(name, &mut shstr));
            }
            let n_symtab = add_name(".symtab", &mut shstr);
            let n_strtab = add_name(".strtab", &mut shstr);
            let mut rela_names: Vec<u32> = Vec::new();
            for (target, _, _) in &rela_at {
                let prefix = if rela { ".rela" } else { ".rel" };
                rela_names.push(add_name(
                    &format!("{prefix}{}", self.secs[*target].0),
                    &mut shstr,
                ));
            }
            let n_shstr = add_name(".shstrtab", &mut shstr);
            let shstr_at = out.len();
            out.extend_from_slice(&shstr);
            while !out.len().is_multiple_of(aw) {
                out.push(0);
            }
            let shoff = out.len();
            let symtab_shndx = 1 + nsec;
            let shnum = 1 + nsec + 2 + rela_at.len() + 1;
            let hdr = |name: u32,
                       shtype: u32,
                       flags: u64,
                       off: usize,
                       size: usize,
                       link: u32,
                       info: u32,
                       align: u64,
                       entsize: u64| {
                let mut h = alloc::vec![0u8; class.shdr_size() as usize];
                h[0..4].copy_from_slice(&name.to_le_bytes());
                h[4..8].copy_from_slice(&shtype.to_le_bytes());
                for (f, v) in [flags, 0, off as u64, size as u64].into_iter().enumerate() {
                    let o = 8 + f * aw;
                    h[o..o + aw].copy_from_slice(&class.addr_bytes(v)[..aw]);
                }
                let o = 8 + 4 * aw;
                h[o..o + 4].copy_from_slice(&link.to_le_bytes());
                h[o + 4..o + 8].copy_from_slice(&info.to_le_bytes());
                for (f, v) in [align, entsize].into_iter().enumerate() {
                    let o = o + 8 + f * aw;
                    h[o..o + aw].copy_from_slice(&class.addr_bytes(v)[..aw]);
                }
                h
            };
            let mut shdrs: Vec<Vec<u8>> = alloc::vec![alloc::vec![0u8; class.shdr_size() as usize]];
            for (k, (_, shtype, flags, align, body, _)) in self.secs.iter().enumerate() {
                let entsize = self
                    .entsizes
                    .iter()
                    .find(|(s, _)| *s == k)
                    .map(|(_, e)| *e)
                    .unwrap_or(0);
                let find = |v: &[(usize, u32)]| {
                    v.iter()
                        .find(|(s, _)| *s == k)
                        .map(|(_, l)| *l)
                        .unwrap_or(0)
                };
                shdrs.push(hdr(
                    names[k],
                    *shtype,
                    *flags,
                    body_off[k],
                    body.len(),
                    find(&self.links),
                    find(&self.infos),
                    *align,
                    entsize,
                ));
            }
            shdrs.push(hdr(
                n_symtab,
                SHT_SYMTAB,
                0,
                symtab_at,
                symtab.len(),
                (symtab_shndx + 1) as u32,
                (1 + nsec) as u32,
                aw as u64,
                class.sym_size(),
            ));
            shdrs.push(hdr(
                n_strtab,
                SHT_STRTAB,
                0,
                strtab_at,
                strtab.len(),
                0,
                0,
                1,
                0,
            ));
            for (j, (target, at, count)) in rela_at.iter().enumerate() {
                shdrs.push(hdr(
                    rela_names[j],
                    if rela { SHT_RELA } else { SHT_REL },
                    0,
                    *at,
                    count * ent,
                    symtab_shndx as u32,
                    (*target + 1) as u32,
                    aw as u64,
                    ent as u64,
                ));
            }
            shdrs.push(hdr(
                n_shstr,
                SHT_STRTAB,
                0,
                shstr_at,
                shstr.len(),
                0,
                0,
                1,
                0,
            ));
            assert_eq!(shdrs.len(), shnum);
            for h in &shdrs {
                out.extend_from_slice(h);
            }
            out[0..4].copy_from_slice(b"\x7fELF");
            out[4] = class.ei_class();
            out[5] = 1;
            out[6] = 1;
            out[16..18].copy_from_slice(&1u16.to_le_bytes());
            out[18..20].copy_from_slice(&machine.to_le_bytes());
            let at = 24 + 2 * aw;
            out[at..at + aw].copy_from_slice(&class.addr_bytes(shoff as u64)[..aw]);
            let tail = 24 + 3 * aw + 4;
            out[tail..tail + 2].copy_from_slice(&(class.ehdr_size() as u16).to_le_bytes());
            out[tail + 6..tail + 8].copy_from_slice(&(class.shdr_size() as u16).to_le_bytes());
            out[tail + 8..tail + 10].copy_from_slice(&(shnum as u16).to_le_bytes());
            out[tail + 10..tail + 12].copy_from_slice(&((shnum - 1) as u16).to_le_bytes());
            out
        }
    }

    fn readelf_sections(image: &[u8]) -> Vec<(String, u32, u64, u64, u64)> {
        let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
        let shstrndx = u16::from_le_bytes(image[62..64].try_into().unwrap()) as usize;
        let sh = |i: usize| -> Elf64Shdr { read_struct(image, shoff + i * 64).unwrap() };
        let str_sh = sh(shstrndx);
        let strtab =
            &image[str_sh.sh_offset as usize..(str_sh.sh_offset + str_sh.sh_size) as usize];
        (1..shnum)
            .map(|i| {
                let h = sh(i);
                (
                    strz(strtab, h.sh_name as usize),
                    h.sh_type,
                    h.sh_addr,
                    h.sh_size,
                    h.sh_flags,
                )
            })
            .collect()
    }

    fn image_symbols(image: &[u8]) -> Vec<(String, u64, u16)> {
        let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
        let sh = |i: usize| -> Elf64Shdr { read_struct(image, shoff + i * 64).unwrap() };
        for i in 1..shnum {
            let h = sh(i);
            if h.sh_type == SHT_SYMTAB {
                let strh = sh(h.sh_link as usize);
                let strtab =
                    &image[strh.sh_offset as usize..(strh.sh_offset + strh.sh_size) as usize];
                let n = (h.sh_size / 24) as usize;
                return (0..n)
                    .map(|k| {
                        let s: Elf64Sym =
                            read_struct(image, h.sh_offset as usize + k * 24).unwrap();
                        (strz(strtab, s.st_name as usize), s.st_value, s.st_shndx)
                    })
                    .collect();
            }
        }
        Vec::new()
    }

    /// `.dynsym` as `(name, value, shndx)`, in table order.
    fn image_dynsyms(image: &[u8]) -> Vec<(String, u64, u16)> {
        let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
        let sh = |i: usize| -> Elf64Shdr { read_struct(image, shoff + i * 64).unwrap() };
        for i in 1..shnum {
            let h = sh(i);
            if h.sh_type != dynamic::SHT_DYNSYM {
                continue;
            }
            let strh = sh(h.sh_link as usize);
            let strtab = &image[strh.sh_offset as usize..(strh.sh_offset + strh.sh_size) as usize];
            return (0..(h.sh_size / 24) as usize)
                .map(|k| {
                    let s: Elf64Sym = read_struct(image, h.sh_offset as usize + k * 24).unwrap();
                    (strz(strtab, s.st_name as usize), s.st_value, s.st_shndx)
                })
                .collect();
        }
        Vec::new()
    }

    fn section_index(image: &[u8], name: &str) -> u32 {
        readelf_sections(image)
            .iter()
            .position(|s| s.0 == name)
            .map(|k| k as u32 + 1)
            .unwrap_or_else(|| panic!("{name} in output"))
    }

    fn section_link(image: &[u8], name: &str) -> u32 {
        let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
        let i = section_index(image, name) as usize;
        let h: Elf64Shdr = read_struct(image, shoff + i * 64).unwrap();
        h.sh_link
    }

    fn image_phdrs(image: &[u8]) -> Vec<Elf64Phdr> {
        let phoff = u64::from_le_bytes(image[32..40].try_into().unwrap()) as usize;
        let phnum = u16::from_le_bytes(image[56..58].try_into().unwrap()) as usize;
        (0..phnum)
            .map(|i| read_struct(image, phoff + i * 56).unwrap())
            .collect()
    }

    /// Walk a SysV `.hash` chain the way a loader does.
    fn sysv_lookup(hash: &[u8], syms: &[(String, u64, u16)], name: &str) -> Option<usize> {
        let w = |i: usize| u32::from_le_bytes(hash[i * 4..i * 4 + 4].try_into().unwrap()) as usize;
        let (nbucket, nchain) = (w(0), w(1));
        assert_eq!(nchain, syms.len(), ".hash nchain covers .dynsym");
        let mut i = w(2 + dynamic::elf_hash(name) as usize % nbucket);
        while i != 0 {
            if syms[i].0 == name {
                return Some(i);
            }
            i = w(2 + nbucket + i);
        }
        None
    }

    /// Walk a `.gnu.hash` bucket the way a loader does, Bloom filter
    /// included: a name the filter rejects is not in the table.
    fn gnu_lookup(gnu: &[u8], syms: &[(String, u64, u16)], name: &str) -> Option<usize> {
        let w = |i: usize| u32::from_le_bytes(gnu[i * 4..i * 4 + 4].try_into().unwrap()) as usize;
        let (nbuckets, symndx, maskwords, shift2) = (w(0), w(1), w(2), w(3));
        let h = dynamic::gnu_hash(name);
        let bloom = |k: usize| -> u64 {
            u64::from_le_bytes(gnu[16 + k * 8..16 + k * 8 + 8].try_into().unwrap())
        };
        let word = bloom((h as usize / 64) % maskwords);
        if word & (1u64 << (h % 64)) == 0 || word & (1u64 << ((h >> shift2) % 64)) == 0 {
            return None;
        }
        let buckets = 4 + maskwords * 2;
        let mut i = w(buckets + h as usize % nbuckets);
        if i == 0 {
            return None;
        }
        loop {
            let c = w(buckets + nbuckets + i - symndx);
            if c & !1 == (h & !1) as usize && syms[i].0 == name {
                return Some(i);
            }
            if c & 1 != 0 {
                return None;
            }
            i += 1;
        }
    }

    fn find_sym(syms: &[(String, u64, u16)], name: &str) -> u64 {
        syms.iter()
            .find(|(n, _, _)| n == name)
            .unwrap_or_else(|| panic!("symbol {name} in output"))
            .1
    }

    fn section_file_off(image: &[u8], addr: u64) -> usize {
        let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
        for i in 1..shnum {
            let h: Elf64Shdr = read_struct(image, shoff + i * 64).unwrap();
            if h.sh_addr == addr && h.sh_type != SHT_NOBITS {
                return h.sh_offset as usize;
            }
        }
        panic!("no section at 0x{addr:x}");
    }

    const SCRIPT: &str = r#"
ENTRY(_start)
PHDRS {
  text PT_LOAD FLAGS(5);
  data PT_LOAD FLAGS(6);
}
SECTIONS {
  . = 0x400000 + 0x1000;
  .text : AT(ADDR(.text) - 0x400000) {
    _text = .;
    *(.text .text.*)
    . = ALIGN(16);
    _etext = .;
  } :text = 0x90909090
  . = ALIGN(0x1000);
  .rodata : { *(.rodata*) __start_tab = .; KEEP(*(__tab)) __stop_tab = .; }
  .data : AT(ADDR(.data) - 0x400000) { *(.data .data.*) LONG(0xdeadbeef) } :data
  .bss : { *(.bss) }
  .resv : { . += 0x40; }
  /DISCARD/ : { *(.gone) }
  ASSERT(_etext > _text, "text is empty")
}
"#;

    fn two_objects() -> Vec<LdsObject> {
        // a.o: _start calls callee (PC32); .data slots hold &callee
        // and &tab_lo (ABS64).
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0xe8, 0, 0, 0, 0, 0xc3],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 16])
            .sec(".gone", SHT_PROGBITS, SHF_ALLOC, 1, &[0xff; 8])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 6)
            .sym("callee", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
            .sym("tab_lo", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
            // Symtab: null(0), sections(1..=3), _start(4), callee(5), tab_lo(6).
            .reloc(0, 1, 5, rt::R_X86_64_PC32, -4)
            .reloc(1, 0, 5, rt::R_X86_64_64, 0)
            .reloc(1, 8, 6, rt::R_X86_64_64, 0)
            .build(EM_X86_64);
        let b = TestObj::new()
            .sec(
                ".text.b",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0xc3],
            )
            .sec(".rodata.str", SHT_PROGBITS, SHF_ALLOC, 1, b"hi\0")
            .sec(
                "__tab",
                SHT_PROGBITS,
                SHF_ALLOC,
                8,
                &[1, 0, 0, 0, 0, 0, 0, 0],
            )
            .sec(".bss", SHT_NOBITS, SHF_ALLOC | SHF_WRITE, 32, &[0u8; 64])
            .sym("callee", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .sym("tab_lo", STB_GLOBAL, STT_OBJECT, 2, 0, 8)
            .build(EM_X86_64);
        alloc::vec![
            parse_lds_object("a.o", a).expect("a.o parses"),
            parse_lds_object("b.o", b).expect("b.o parses"),
        ]
    }

    #[test]
    fn script_link_places_sections_and_symbols() {
        let script = parse_linker_script(SCRIPT).expect("script parses");
        let opts = LdsOptions {
            emit: LdsEmit::Exec,
            max_page_size: 0x1000,
            ..Default::default()
        };
        let res = link_with_script(&script, two_objects(), &opts).expect("link succeeds");
        let secs = readelf_sections(&res.image);
        let sec = |n: &str| {
            secs.iter()
                .find(|s| s.0 == n)
                .unwrap_or_else(|| panic!("section {n}"))
        };
        assert_eq!(sec(".text").2, 0x401000);
        let text_end = 0x401000u64 + sec(".text").3;
        assert_eq!(sec(".rodata").2, align_up(text_end, 0x1000));
        assert!(secs.iter().all(|s| s.0 != ".gone"));
        assert_eq!(sec(".resv").1, SHT_NOBITS);
        assert_eq!(sec(".resv").3, 0x40);
        // 16 input bytes + LONG payload.
        assert_eq!(sec(".data").3, 20);
        let syms = image_symbols(&res.image);
        assert_eq!(find_sym(&syms, "_text"), 0x401000);
        // `__start_tab` sits at the pre-alignment dot; the 8-aligned
        // `__tab` input follows it.
        let start_tab = find_sym(&syms, "__start_tab");
        assert_eq!(find_sym(&syms, "__stop_tab"), align_up(start_tab, 8) + 8);
        let entry = u64::from_le_bytes(res.image[24..32].try_into().unwrap());
        assert_eq!(entry, find_sym(&syms, "_start"));
        // Relocations: .data[0] holds callee's address.
        let data_off = section_file_off(&res.image, sec(".data").2);
        let callee = find_sym(&syms, "callee");
        assert_eq!(
            u64::from_le_bytes(res.image[data_off..data_off + 8].try_into().unwrap()),
            callee
        );
        // PC32 call: disp = callee - (P + 4).
        let text_off = section_file_off(&res.image, 0x401000);
        let disp =
            i32::from_le_bytes(res.image[text_off + 1..text_off + 5].try_into().unwrap()) as i64;
        assert_eq!(0x401001 + 4 + disp, callee as i64);
        // Fill covers the ALIGN(16) tail of .text.
        assert_eq!(res.image[text_off + 7], 0x90);
        assert_eq!(
            u32::from_le_bytes(res.image[data_off + 16..data_off + 20].try_into().unwrap()),
            0xdeadbeef
        );
        // Program headers carry the script's FLAGS; LMA follows AT().
        let phnum = u16::from_le_bytes(res.image[56..58].try_into().unwrap()) as usize;
        assert_eq!(phnum, 2);
        let p0_flags = u32::from_le_bytes(res.image[68..72].try_into().unwrap());
        let p1_flags = u32::from_le_bytes(res.image[124..128].try_into().unwrap());
        assert_eq!((p0_flags, p1_flags), (5, 6));
        let p0_vaddr = u64::from_le_bytes(res.image[80..88].try_into().unwrap());
        let p0_paddr = u64::from_le_bytes(res.image[88..96].try_into().unwrap());
        assert_eq!(p0_paddr, p0_vaddr - 0x400000);
    }

    /// `--emit-relocs`: every applied relocation reappears as a
    /// `.rela.<outsec>` entry whose `r_offset` is the final address and
    /// from which `S + A` reconstructs. This is what
    /// `arch/x86/tools/relocs` reads to build the KASLR table.
    #[test]
    fn emit_relocs_carries_applied_relocations_into_the_image() {
        let script = parse_linker_script(SCRIPT).expect("script parses");
        let opts = LdsOptions {
            emit_relocs: true,
            ..Default::default()
        };
        let res = link_with_script(&script, two_objects(), &opts).expect("link succeeds");
        let secs = readelf_sections(&res.image);
        let rela_data = secs
            .iter()
            .find(|s| s.0 == ".rela.data")
            .expect(".rela.data emitted");
        assert_eq!(rela_data.1, SHT_RELA);
        assert_eq!(rela_data.3 % 24, 0);
        assert!(secs.iter().any(|s| s.0 == ".rela.text"), "{secs:?}");

        // sh_info names the section the table applies to, sh_link the
        // symbol table it indexes.
        let shoff = u64::from_le_bytes(res.image[40..48].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(res.image[60..62].try_into().unwrap()) as usize;
        let sh = |i: usize| -> Elf64Shdr { read_struct(&res.image, shoff + i * 64).unwrap() };
        let data_idx = (1..shnum)
            .find(|&i| {
                let h = sh(i);
                h.sh_type != SHT_RELA && h.sh_addr == secs[i - 1].2 && secs[i - 1].0 == ".data"
            })
            .expect(".data section index");
        let rela_idx = (1..shnum)
            .find(|&i| sh(i).sh_type == SHT_RELA && sh(i).sh_info as usize == data_idx)
            .expect(".rela.data header");
        assert_eq!(sh(sh(rela_idx).sh_link as usize).sh_type, SHT_SYMTAB);

        // The `.data` slot holding &callee: its entry sits at the
        // slot's address and names `callee`.
        let syms = image_symbols(&res.image);
        let callee = find_sym(&syms, "callee");
        let data_addr = secs.iter().find(|s| s.0 == ".data").expect(".data").2;
        let h = sh(rela_idx);
        let n = (h.sh_size / 24) as usize;
        let mut found = false;
        for k in 0..n {
            let at = h.sh_offset as usize + k * 24;
            let off = u64::from_le_bytes(res.image[at..at + 8].try_into().unwrap());
            let info = u64::from_le_bytes(res.image[at + 8..at + 16].try_into().unwrap());
            if off != data_addr {
                continue;
            }
            assert_eq!(syms[(info >> 32) as usize].0, "callee");
            // `S + A` reconstructs from the entry: the slot holds
            // `callee`'s address with a zero addend.
            let add = i64::from_le_bytes(res.image[at + 16..at + 24].try_into().unwrap());
            assert_eq!(syms[(info >> 32) as usize].1 as i64 + add, callee as i64);
            found = true;
        }
        assert!(found, "entry for the .data slot at {data_addr:#x}");

        // Without the option no table is written.
        let plain = link_with_script(&script, two_objects(), &LdsOptions::default())
            .expect("link succeeds");
        assert!(
            !readelf_sections(&plain.image)
                .iter()
                .any(|s| s.1 == SHT_RELA),
            "no relocation tables without --emit-relocs"
        );
    }

    #[test]
    fn assert_failure_fails_the_link() {
        let script_text = SCRIPT.replace("_etext > _text", "_etext < _text");
        let script = parse_linker_script(&script_text).expect("script parses");
        let e = link_with_script(&script, two_objects(), &LdsOptions::default())
            .expect_err("assert must fail the link");
        assert!(format!("{e}").contains("text is empty"), "{e}");
    }

    #[test]
    fn orphan_error_reports_unplaced_sections() {
        let mut script_text = SCRIPT.replace("*(.rodata*)", "*(.rodata.none)");
        script_text = script_text.replace("ASSERT(_etext > _text, \"text is empty\")", "");
        let script = parse_linker_script(&script_text).expect("script parses");
        let opts = LdsOptions {
            orphan_handling: OrphanHandling::Error,
            ..Default::default()
        };
        let e =
            link_with_script(&script, two_objects(), &opts).expect_err("orphan must fail the link");
        assert!(format!("{e}").contains(".rodata.str"), "{e}");
    }

    #[test]
    fn orphan_place_appends_compatible_section() {
        let mut script_text = SCRIPT.replace("*(.rodata*)", "*(.rodata.none)");
        script_text = script_text.replace("ASSERT(_etext > _text, \"text is empty\")", "");
        let script = parse_linker_script(&script_text).expect("script parses");
        let res = link_with_script(&script, two_objects(), &LdsOptions::default())
            .expect("orphan placement succeeds");
        let secs = readelf_sections(&res.image);
        assert!(secs.iter().any(|s| s.0 == ".rodata.str"));
    }

    /// An object placing data under a C-identifier section name keeps
    /// that name as its own output section and gets the `__start_` /
    /// `__stop_` pair bounding it, as bfd does.
    #[test]
    fn start_stop_bound_an_identifier_named_section() {
        let script = parse_linker_script(SCRIPT).expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0x90],
            )
            .sec("mytab", SHT_PROGBITS, SHF_ALLOC, 8, &[7u8; 24])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .sym("__start_mytab", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
            .sym("__stop_mytab", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
            .build(EM_X86_64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let sec = readelf_sections(&res.image)
            .into_iter()
            .find(|s| s.0 == "mytab")
            .expect("`mytab` keeps its identity as an output section");
        let syms = image_symbols(&res.image);
        let val = |n: &str| {
            syms.iter()
                .find(|s| s.0 == n)
                .unwrap_or_else(|| panic!("{n}"))
                .1
        };
        assert_eq!(val("__start_mytab"), sec.2);
        assert_eq!(val("__stop_mytab"), sec.2 + 24);
        assert_eq!(sec.3, 24);
    }

    /// bfd defines the pair only where nothing else does: an object
    /// defining the name keeps its own definition.
    #[test]
    fn an_object_definition_outranks_the_synthesized_bound() {
        let script = parse_linker_script(SCRIPT).expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0x90; 8],
            )
            .sec("tty", SHT_PROGBITS, SHF_ALLOC, 8, &[7u8; 8])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .sym("__start_tty", STB_GLOBAL, STT_FUNC, 0, 4, 4)
            .build(EM_X86_64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let syms = image_symbols(&res.image);
        let text = readelf_sections(&res.image)
            .into_iter()
            .find(|s| s.0 == ".text")
            .expect(".text");
        let start = syms.iter().find(|s| s.0 == "__start_tty").expect("kept");
        assert_eq!(start.1, text.2 + 4);
    }

    /// A script assignment outranks the synthesized bound, keeping the
    /// script symbol's own visibility. The kernel script bounds its
    /// tables this way.
    #[test]
    fn a_script_assignment_outranks_the_synthesized_bound() {
        let script_text = SCRIPT.replace(
            ".data : AT(ADDR(.data) - 0x400000) { *(.data .data.*) LONG(0xdeadbeef) } :data",
            "mytab : { __start_mytab = .; *(mytab) . += 8; __stop_mytab = .; }\n\
             .data : AT(ADDR(.data) - 0x400000) { *(.data .data.*) LONG(0xdeadbeef) } :data",
        );
        let script = parse_linker_script(&script_text).expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0x90],
            )
            .sec("mytab", SHT_PROGBITS, SHF_ALLOC, 8, &[7u8; 16])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .sym("__stop_mytab", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
            .build(EM_X86_64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let sec = readelf_sections(&res.image)
            .into_iter()
            .find(|s| s.0 == "mytab")
            .expect("mytab");
        let syms = image_symbols(&res.image);
        let stop = syms.iter().find(|s| s.0 == "__stop_mytab").expect("stop");
        // The script's `. += 8` puts its own bound past the input's end.
        assert_eq!(stop.1, sec.2 + 24);
    }

    /// A name carrying a `.` is not an identifier, so it gets no pair.
    #[test]
    fn a_dotted_section_name_gets_no_bounds() {
        let script = parse_linker_script(SCRIPT).expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0x90],
            )
            .sec(".my.tab", SHT_PROGBITS, SHF_ALLOC, 8, &[7u8; 8])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .sym("__start_.my.tab", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
            .build(EM_X86_64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let syms = image_symbols(&res.image);
        assert!(!syms.iter().any(|s| s.0 == "__start_.my.tab"), "{syms:?}");
    }

    /// Two text sections, one reached from the entry point and one
    /// not, plus a `KEEP()`-named table nothing references.
    fn gc_objects() -> Vec<LdsObject> {
        let a = TestObj::new()
            .sec(
                ".text._start",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0xe8, 0, 0, 0, 0],
            )
            .sec(
                ".text.live",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0xc3],
            )
            .sec(
                ".text.dead",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0x90; 8],
            )
            .sec("__tab", SHT_PROGBITS, SHF_ALLOC, 8, &[5u8; 8])
            .sec(".rodata.dead", SHT_PROGBITS, SHF_ALLOC, 8, &[6u8; 8])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 5)
            .sym("live", STB_GLOBAL, STT_FUNC, 1, 0, 1)
            .sym("dead", STB_GLOBAL, STT_FUNC, 2, 0, 8)
            // Symtab: null(0), sections(1..=5), _start(6), live(7), dead(8).
            .reloc(0, 1, 7, rt::R_X86_64_PC32, -4)
            .build(EM_X86_64);
        alloc::vec![parse_lds_object("a.o", a).expect("parses")]
    }

    /// `--gc-sections` drops what the entry point does not reach, and
    /// keeps what a `KEEP()` names.
    #[test]
    fn gc_sections_drops_what_the_entry_does_not_reach() {
        let script = parse_linker_script(SCRIPT).expect("script parses");
        let opts = LdsOptions {
            gc_sections: true,
            ..LdsOptions::default()
        };
        let res = link_with_script(&script, gc_objects(), &opts).expect("links");
        let names: Vec<String> = image_symbols(&res.image).into_iter().map(|s| s.0).collect();
        assert!(names.iter().any(|n| n == "_start"), "{names:?}");
        assert!(names.iter().any(|n| n == "live"), "{names:?}");
        assert!(!names.iter().any(|n| n == "dead"), "{names:?}");
        // The script KEEPs `__tab` between its own bounds.
        let syms = image_symbols(&res.image);
        let v = |n: &str| {
            syms.iter()
                .find(|s| s.0 == n)
                .unwrap_or_else(|| panic!("{n}"))
                .1
        };
        assert_eq!(v("__stop_tab") - v("__start_tab"), 8);
    }

    /// Without the option nothing is collected.
    #[test]
    fn without_gc_sections_every_input_is_placed() {
        let script = parse_linker_script(SCRIPT).expect("script parses");
        let res = link_with_script(&script, gc_objects(), &LdsOptions::default()).expect("links");
        let names: Vec<String> = image_symbols(&res.image).into_iter().map(|s| s.0).collect();
        assert!(names.iter().any(|n| n == "dead"), "{names:?}");
    }

    #[test]
    fn undefined_strong_reference_fails() {
        let script = parse_linker_script(SCRIPT).expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0xe8, 0, 0, 0, 0],
            )
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 5)
            .sym("missing", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
            // Symtab: null(0), section(1), _start(2), missing(3).
            .reloc(0, 1, 3, rt::R_X86_64_PC32, -4)
            .build(EM_X86_64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let e = link_with_script(&script, objs, &LdsOptions::default())
            .expect_err("undefined reference fails");
        assert!(format!("{e}").contains("missing"), "{e}");
    }

    /// One `.text` section holding `insns` followed by `tgt`, with a
    /// `SABS_G2` / `UABS_G1_NC` / `UABS_G0_NC` relocation over each in turn.
    fn movw_seq_object(insns: &[u32]) -> Vec<LdsObject> {
        let mut body: Vec<u8> = insns.iter().flat_map(|w| w.to_le_bytes()).collect();
        let tgt_off = body.len() as u64;
        body.extend_from_slice(&0xd503201fu32.to_le_bytes());
        let mut o = TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &body)
            .sym("tgt", STB_GLOBAL, STT_FUNC, 0, tgt_off, 4);
        // Symtab: null(0), section(1), tgt(2).
        for (i, _) in insns.iter().enumerate() {
            let ty = match i {
                0 => rt::R_AARCH64_MOVW_SABS_G2,
                1 => rt::R_AARCH64_MOVW_UABS_G1_NC,
                _ => rt::R_AARCH64_MOVW_UABS_G0_NC,
            };
            o = o.reloc(0, i as u64 * 4, 2, ty, 0);
        }
        alloc::vec![parse_lds_object("a.o", o.build(EM_AARCH64)).expect("a.o parses")]
    }

    fn movw_script(base: &str) -> crate::c5::linker::lds::LinkerScript {
        parse_linker_script(&format!(
            "SECTIONS {{ . = {base}; .text : {{ *(.text) }} }}"
        ))
        .expect("script parses")
    }

    /// The `tramp_alias` sequence linked through a script: each half takes
    /// its own 16-bit group of the target's final address. Words checked
    /// against `ld -T` over the same script and object.
    #[test]
    fn aarch64_movw_groups_resolve_like_gnu_ld() {
        // Placeholders as GNU as leaves them: the group's shift, zero imm.
        let insns = [0xd2c0_0005u32, 0xf2a0_0005, 0xf280_0005];
        let res = link_with_script(
            &movw_script("0x123456780000"),
            movw_seq_object(&insns),
            &LdsOptions {
                emit: LdsEmit::Exec,
                max_page_size: 0x1000,
                ..Default::default()
            },
        )
        .expect("link succeeds");
        let syms = image_symbols(&res.image);
        let tgt = find_sym(&syms, "tgt");
        assert_eq!(tgt, 0x1234_5678_000c);
        let off = section_file_off(&res.image, 0x1234_5678_0000);
        let got: Vec<u32> = (0..3)
            .map(|i| {
                u32::from_le_bytes(
                    res.image[off + i * 4..off + i * 4 + 4]
                        .try_into()
                        .expect("4-byte word"),
                )
            })
            .collect();
        assert_eq!(
            got,
            alloc::vec![
                0xd2c2_4685, // movz x5, #0x1234, lsl #32
                0xf2aa_cf05, // movk x5, #0x5678, lsl #16
                0xf280_0185, // movk x5, #0xc
            ]
        );
    }

    /// A `_S` group is checked: a target past its signed range fails the
    /// link, as it does under GNU ld, rather than writing a truncated
    /// address. The `_NC` halves of the same sequence never complain.
    #[test]
    fn aarch64_movw_sabs_overflow_fails_the_link() {
        let insns = [0xd2c0_0005u32, 0xf2a0_0005, 0xf280_0005];
        let opts = LdsOptions {
            emit: LdsEmit::Exec,
            max_page_size: 0x1000,
            ..Default::default()
        };
        // The last address the signed group admits is 2^48 - 1.
        link_with_script(
            &movw_script("0xfffffffffff0"),
            movw_seq_object(&insns),
            &opts,
        )
        .expect("a target below 2^48 links");
        let e = link_with_script(
            &movw_script("0x1000000000000"),
            movw_seq_object(&insns),
            &opts,
        )
        .expect_err("a target at 2^48 overflows the signed group");
        let e = format!("{e}");
        assert!(e.contains("R_AARCH64_MOVW_SABS_G2"), "{e}");
        assert!(e.contains("overflow against `tgt'"), "{e}");
    }

    #[test]
    fn relr_encoding_round_trips() {
        let addrs = [0x1000u64, 0x1008, 0x1010, 0x1400, 0x1408 + 63 * 8];
        let words = encode_relr(&addrs, 8);
        let mut got: Vec<u64> = Vec::new();
        let mut base = 0u64;
        for w in words {
            if w & 1 == 0 {
                got.push(w);
                base = w + 8;
            } else {
                let mut r = w >> 1;
                let mut i = 0u64;
                while r != 0 {
                    if r & 1 != 0 {
                        got.push(base + i * 8);
                    }
                    r >>= 1;
                    i += 1;
                }
                base += 63 * 8;
            }
        }
        assert_eq!(got, addrs);
    }

    #[test]
    fn sha1_matches_known_vectors() {
        assert_eq!(
            sha1(b"abc"),
            [
                0xa9, 0x99, 0x3e, 0x36, 0x47, 0x06, 0x81, 0x6a, 0xba, 0x3e, 0x25, 0x71, 0x78, 0x50,
                0xc2, 0x6c, 0x9c, 0xd0, 0xd8, 0x9d
            ]
        );
        assert_eq!(
            sha1(b""),
            [
                0xda, 0x39, 0xa3, 0xee, 0x5e, 0x6b, 0x4b, 0x0d, 0x32, 0x55, 0xbf, 0xef, 0x95, 0x60,
                0x18, 0x90, 0xaf, 0xd8, 0x07, 0x09
            ]
        );
    }

    #[test]
    fn merge_strings_deduplicate() {
        let script = parse_linker_script(
            "SECTIONS { . = 0x1000; .text : { *(.text*) } .rodata : { *(.rodata.str1.1) } }",
        )
        .expect("parses");
        let a = TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
            .sec(
                ".rodata.str1.1",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
                1,
                b"hello\0world\0",
            )
            .entsize(1, 1)
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .build(EM_X86_64);
        let b = TestObj::new()
            .sec(
                ".text.b",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0xc3],
            )
            .sec(
                ".rodata.str1.1",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
                1,
                b"world\0",
            )
            .entsize(1, 1)
            .sym("bfn", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            // b's string symbol: offset of "world" within its section.
            .sym("b_str", STB_GLOBAL, STT_OBJECT, 1, 0, 6)
            .build(EM_X86_64);
        let objs = alloc::vec![
            parse_lds_object("a.o", a).expect("parses"),
            parse_lds_object("b.o", b).expect("parses"),
        ];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let secs = readelf_sections(&res.image);
        let ro = secs.iter().find(|s| s.0 == ".rodata").expect("rodata");
        // "hello\0world\0" + "world\0" dedupes to 12 bytes.
        assert_eq!(ro.3, 12);
        // b's "world" resolves into the pool at offset 6.
        let syms = image_symbols(&res.image);
        assert_eq!(find_sym(&syms, "b_str"), ro.2 + 6);
    }

    /// A named symbol into a merged string section anchors its relocs:
    /// the addend applies to the remapped address, so an addend past
    /// the string's NUL (gcc anchors one-past-end bounds this way)
    /// stays with that string instead of resolving to a deduplicated
    /// padding entry. A section symbol's addend selects the entry
    /// through the remap. Pool entries keep the section's alignment.
    #[test]
    fn merge_string_addend_anchors_to_symbol_entry() {
        let script = parse_linker_script(
            "SECTIONS { . = 0x1000; .text : { *(.text*) } .rodata : { *(.rodata*) } .data : { *(.data*) } }",
        )
        .expect("parses");
        // gcc's .rodata.str1.8 shape: 8-aligned strings, NUL padding.
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0u8; 4],
            )
            .sec(
                ".rodata.str1.8",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
                8,
                b"io  \0\0\0\0mem \0\0\0\0",
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 24])
            .entsize(1, 1)
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 4)
            .sym("mem_str", STB_GLOBAL, STT_OBJECT, 1, 8, 5)
            // Symtab: null(0), sections(1..=3), _start(4), mem_str(5).
            // Slots: mem_str+1, mem_str+5 (one past the NUL), and the
            // string's offset through the section symbol.
            .reloc(2, 0, 5, rt::R_AARCH64_ABS64, 1)
            .reloc(2, 8, 5, rt::R_AARCH64_ABS64, 5)
            .reloc(2, 16, 2, rt::R_AARCH64_ABS64, 8)
            .build(EM_AARCH64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let secs = readelf_sections(&res.image);
        let ro = secs.iter().find(|s| s.0 == ".rodata").expect("rodata");
        let data = secs.iter().find(|s| s.0 == ".data").expect("data");
        let ro_off = section_file_off(&res.image, ro.2);
        let bytes = &res.image[ro_off..ro_off + ro.3 as usize];
        let mem = bytes
            .windows(5)
            .position(|w| w == b"mem \0")
            .expect("pooled string") as u64;
        assert_eq!((ro.2 + mem) % 8, 0, "pool keeps the entry alignment");
        let d_off = section_file_off(&res.image, data.2);
        let slot =
            |k: usize| u64::from_le_bytes(res.image[d_off + k..d_off + k + 8].try_into().unwrap());
        assert_eq!(slot(0), ro.2 + mem + 1);
        assert_eq!(slot(8), ro.2 + mem + 5);
        assert_eq!(slot(16), ro.2 + mem);
    }

    const DYN_SCRIPT: &str = r#"
ENTRY(_start)
SECTIONS {
  . = 0;
  .text : { *(.text*) }
  .rodata : { *(.rodata*) }
  .data : { *(.data*) }
  .rela.dyn : { __rela_start = .; *(.rela .rela*) __rela_end = .; }
  .relr.dyn : { __relr_start = .; *(.relr.dyn) __relr_end = .; }
  .bss : { *(.bss) }
  /DISCARD/ : { *(.note*) *(.comment) }
}
"#;

    /// Property notes reach the output as one merged note, not one per
    /// input. The inputs disagree on every property here, which is what
    /// makes the merge observable: a consumer reading the first note
    /// must see the intersection rather than whichever input landed
    /// first.
    #[test]
    fn property_notes_merge_into_one_note_under_a_gnu_property_segment() {
        const X86_FEATURE_1_AND: u32 = 0xc000_0002;
        const X86_ISA_1_USED: u32 = 0xc001_0002;
        let note = |props: &[(u32, usize, u64)]| {
            gnu_property::encode(
                &props
                    .iter()
                    .map(|&(ty, datasz, value)| gnu_property::Property::number(ty, datasz, value))
                    .collect::<Vec<_>>(),
                8,
            )
        };
        let obj = |unknown: u64, feature: u64, isa: u64| {
            let body = note(&[
                // A type outside every defined range, which the inputs
                // disagree on: dropped, and it must not end the walk
                // over the properties behind it.
                (0x10, 4, unknown),
                (X86_FEATURE_1_AND, 4, feature),
                (X86_ISA_1_USED, 4, isa),
            ]);
            TestObj::new()
                .sec(
                    ".text",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    16,
                    &[0u8; 16],
                )
                .sec(".note.gnu.property", SHT_NOTE, SHF_ALLOC, 8, &body)
                .build(EM_X86_64)
        };
        let script = parse_linker_script(&super::super::default_script::default_script(false))
            .expect("the built-in default script parses");
        // Build-id on, so the image holds two note sections: PT_NOTE
        // covers a range, and a second note is the first thing that
        // can put a non-note inside it.
        let opts = LdsOptions {
            max_page_size: 0x1000,
            build_id_sha1: true,
            ..Default::default()
        };
        let res = link_with_script(
            &script,
            alloc::vec![
                parse_lds_object("a.o", obj(0xaabb_ccdd, 0x3, 0x0)).expect("parses"),
                parse_lds_object("b.o", obj(0x1122_3344, 0x1, 0x1)).expect("parses"),
            ],
            &opts,
        )
        .expect("the link succeeds");
        let secs = readelf_sections(&res.image);
        let notes: Vec<_> = secs
            .iter()
            .filter(|s| s.0 == ".note.gnu.property")
            .collect();
        assert_eq!(notes.len(), 1, "one merged note section, not one per input");
        // IBT|SHSTK against IBT intersects to IBT; ISA_1_USED is an
        // all-input union, so 0 against 1 keeps 1.
        let want = note(&[(X86_FEATURE_1_AND, 4, 0x1), (X86_ISA_1_USED, 4, 0x1)]);
        assert_eq!(notes[0].3 as usize, want.len(), "sized for the merged note");
        let off = section_file_off(&res.image, notes[0].2);
        assert_eq!(&res.image[off..off + want.len()], &want[..]);
        let phdrs = image_phdrs(&res.image);
        let prop = phdrs
            .iter()
            .find(|p| p.p_type == PT_GNU_PROPERTY)
            .expect("PT_GNU_PROPERTY covers the merged note");
        assert_eq!((prop.p_vaddr, prop.p_filesz), (notes[0].2, notes[0].3));
        // PT_NOTE spans a range, so every allocated section inside it
        // has to be a note: a consumer walks the segment end to end.
        let pt_note = phdrs
            .iter()
            .find(|p| p.p_type == PT_NOTE)
            .expect("PT_NOTE covers the notes");
        let covered: Vec<_> = secs
            .iter()
            .filter(|s| {
                s.4 & SHF_ALLOC != 0
                    && s.2 >= pt_note.p_vaddr
                    && s.2 < pt_note.p_vaddr + pt_note.p_memsz
            })
            .collect();
        assert_eq!(
            covered.iter().map(|s| s.3).sum::<u64>(),
            pt_note.p_memsz,
            "PT_NOTE holds notes and nothing between them"
        );
        assert!(
            covered.iter().all(|s| s.1 == SHT_NOTE),
            "every section under PT_NOTE is a note: {:?}",
            covered.iter().map(|s| &s.0).collect::<Vec<_>>()
        );
        assert_eq!(covered.len(), 2, "the merged note and the build id");
    }

    /// A script can put something between two note sections. Each run
    /// gets its own PT_NOTE, the way ld emits them, so what a consumer
    /// reads end to end over a segment is notes only.
    #[test]
    fn separated_note_sections_get_a_segment_each() {
        const SEP_SCRIPT: &str = r#"
SECTIONS {
  . = 0x400000 + SIZEOF_HEADERS;
  .note.gnu.property : { *(.note.gnu.property) }
  .text : { *(.text) }
  .note.gnu.build-id : { *(.note.gnu.build-id) }
}
"#;
        let body = gnu_property::encode(&[gnu_property::Property::number(0xc000_0002, 4, 0x3)], 8);
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 16],
            )
            .sec(".note.gnu.property", SHT_NOTE, SHF_ALLOC, 8, &body)
            .build(EM_X86_64);
        let script = parse_linker_script(SEP_SCRIPT).expect("parses");
        let opts = LdsOptions {
            build_id_sha1: true,
            max_page_size: 0x1000,
            ..Default::default()
        };
        let res = link_with_script(
            &script,
            alloc::vec![parse_lds_object("a.o", a).expect("parses")],
            &opts,
        )
        .expect("the link succeeds");
        let secs = readelf_sections(&res.image);
        let sec = |n: &str| {
            secs.iter()
                .find(|s| s.0 == n)
                .unwrap_or_else(|| panic!("{n}"))
        };
        let notes = image_phdrs(&res.image)
            .into_iter()
            .filter(|p| p.p_type == PT_NOTE)
            .collect::<Vec<_>>();
        assert_eq!(
            notes.len(),
            2,
            "one segment per run, not one spanning .text"
        );
        for (seg, name) in notes
            .iter()
            .zip([".note.gnu.property", ".note.gnu.build-id"])
        {
            assert_eq!((seg.p_vaddr, seg.p_memsz), (sec(name).2, sec(name).3));
        }
        // ld gives each segment the alignment of what it holds.
        assert_eq!((notes[0].p_align, notes[1].p_align), (8, 4));
    }

    /// ET_DYN link: every absolute pointer becomes a load-time
    /// RELATIVE fixup, packed into .relr.dyn under
    /// `pack-relative-relocs`. Regression for the pass-ordering bug
    /// that reset placement before sizing the dynamic sections, so
    /// they always came out empty.
    #[test]
    fn dyn_link_emits_relative_relocations() {
        let script = parse_linker_script(DYN_SCRIPT).expect("script parses");
        // .data holds two 8-byte pointers to `target` (an 8-aligned
        // and a non-8-aligned slot) via ABS64.
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0u8; 8],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 24])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
            .sym("target", STB_GLOBAL, STT_FUNC, 0, 4, 0)
            // Symtab: null(0), sections(1,2), _start(3), target(4).
            .reloc(1, 0, 4, rt::R_AARCH64_ABS64, 0)
            .reloc(1, 9, 4, rt::R_AARCH64_ABS64, 0)
            .build(EM_AARCH64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let opts = LdsOptions {
            emit: LdsEmit::Dyn,
            pack_relative_relocs: true,
            max_page_size: 0x10000,
            ..Default::default()
        };
        let res = link_with_script(&script, objs, &opts).expect("dyn link succeeds");
        // ET_DYN.
        assert_eq!(u16::from_le_bytes(res.image[16..18].try_into().unwrap()), 3);
        let secs = readelf_sections(&res.image);
        let relr = secs.iter().find(|s| s.0 == ".relr.dyn");
        let rela = secs.iter().find(|s| s.0 == ".rela.dyn");
        // The 8-aligned slot packs into RELR; the odd slot stays RELA.
        assert!(relr.is_some_and(|s| s.3 > 0), "relr.dyn must be non-empty");
        assert!(
            rela.is_some_and(|s| s.3 >= 24),
            "rela.dyn must hold the odd slot"
        );
        // The RELR word relocates the 8-aligned .data slot's address.
        let syms = image_symbols(&res.image);
        let data_addr = secs.iter().find(|s| s.0 == ".data").unwrap().2;
        let relr_off = section_file_off(&res.image, relr.unwrap().2);
        let w0 = u64::from_le_bytes(res.image[relr_off..relr_off + 8].try_into().unwrap());
        assert_eq!(w0 & 1, 0, "first RELR entry is a base address");
        assert_eq!(w0, data_addr, "RELR relocates the .data pointer slot");
        // The RELA entry is R_AARCH64_RELATIVE (type 1027) at the odd slot.
        let rela_off = section_file_off(&res.image, rela.unwrap().2);
        let r_offset = u64::from_le_bytes(res.image[rela_off..rela_off + 8].try_into().unwrap());
        let r_type = u32::from_le_bytes(res.image[rela_off + 8..rela_off + 12].try_into().unwrap());
        assert_eq!(r_offset, data_addr + 9);
        assert_eq!(r_type, rt::R_AARCH64_RELATIVE);
        let _ = syms;
    }

    /// A `.text` displacement holding `slot`'s address as a 32-bit
    /// absolute, plus an address-width `.data` pointer to it.
    fn narrow_abs_object() -> Vec<u8> {
        TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0u8; 16],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 16])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 16)
            .sym("slot", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
            // Symtab: null(0), sections(1,2), _start(3), slot(4).
            .reloc(0, 4, 4, rt::R_X86_64_32S, 0)
            .reloc(1, 8, 4, rt::R_X86_64_64, 0)
            .build(EM_X86_64)
    }

    /// An absolute relocation narrower than an address has no dynamic
    /// form -- `R_X86_64_RELATIVE` writes an 8-byte word -- so an
    /// ET_DYN image cannot carry the site. The engine used to write
    /// the link-time address and emit no `.rela.dyn` entry covering
    /// it, which the loader's slide then invalidated. GNU ld declines
    /// the same input. The ET_EXEC link, where the address is a
    /// link-time constant, still writes it.
    #[test]
    fn a_narrow_absolute_is_declined_in_a_dyn_link() {
        let script = parse_linker_script(DYN_SCRIPT).expect("script parses");
        let link = |emit, shared| {
            link_with_script(
                &script,
                alloc::vec![parse_lds_object("t.o", narrow_abs_object()).expect("parses")],
                &LdsOptions {
                    emit,
                    shared,
                    max_page_size: 0x1000,
                    ..Default::default()
                },
            )
        };
        let res = link(LdsEmit::Exec, false).expect("exec link succeeds");
        let secs = readelf_sections(&res.image);
        let data_addr = secs.iter().find(|s| s.0 == ".data").expect(".data").2;
        let text_off = section_file_off(
            &res.image,
            secs.iter().find(|s| s.0 == ".text").expect(".text").2,
        );
        assert_eq!(
            u32::from_le_bytes(res.image[text_off + 4..text_off + 8].try_into().unwrap()) as u64,
            data_addr,
            "ET_EXEC keeps writing the link-time address"
        );
        assert_eq!(
            alloc::format!("{}", link(LdsEmit::Dyn, false).expect_err("pie link fails")),
            "error: t.o(.text+0x4): R_X86_64_32S (11) against symbol `slot` can not be used \
             when making a position-independent executable: the reference needs an absolute \
             address, which no load address supplies"
        );
        assert!(
            alloc::format!(
                "{}",
                link(LdsEmit::Dyn, true).expect_err("shared link fails")
            )
            .contains("when making a shared object"),
            "the refusal names the output kind"
        );
    }

    /// The screen fires only where no dynamic form exists. An
    /// address-width absolute against a load address is exactly what
    /// `.rela.dyn` carries, so the same input that loses its narrow
    /// site keeps its RELATIVE entry.
    #[test]
    fn a_dyn_link_covers_an_address_width_absolute() {
        let script = parse_linker_script(DYN_SCRIPT).expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0u8; 16],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 16])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 16)
            .sym("slot", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
            .reloc(1, 8, 4, rt::R_X86_64_64, 0)
            .build(EM_X86_64);
        let res = link_with_script(
            &script,
            alloc::vec![parse_lds_object("t.o", a).expect("parses")],
            &LdsOptions {
                emit: LdsEmit::Dyn,
                max_page_size: 0x1000,
                ..Default::default()
            },
        )
        .expect("abs64 links");
        let secs = readelf_sections(&res.image);
        let rela = secs.iter().find(|s| s.0 == ".rela.dyn").expect(".rela.dyn");
        let off = section_file_off(&res.image, rela.2);
        assert_eq!(rela.3, 24, "one RELA entry covers the ABS64 slot");
        assert_eq!(
            u32::from_le_bytes(res.image[off + 8..off + 12].try_into().unwrap()),
            rt::R_X86_64_RELATIVE
        );
    }

    /// An absolute against a global SHN_ABS symbol holds a link-time
    /// constant at any field width: no load address is involved, so
    /// the site keeps its value and needs no dynamic entry. Such a
    /// symbol is its own entry in the global table, which the
    /// load-address test used to follow until the stack ran out.
    #[test]
    fn a_dyn_link_keeps_an_absolute_global_constant() {
        let script = parse_linker_script(DYN_SCRIPT).expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0u8; 16],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 16)
            .sym("KCONST", STB_GLOBAL, STT_OBJECT, usize::MAX - 1, 0x1234, 0)
            // Symtab: null(0), sections(1,2), _start(3), KCONST(4).
            .reloc(0, 4, 4, rt::R_X86_64_32S, 0)
            .reloc(1, 0, 4, rt::R_X86_64_64, 0)
            .build(EM_X86_64);
        let res = link_with_script(
            &script,
            alloc::vec![parse_lds_object("t.o", a).expect("parses")],
            &LdsOptions {
                emit: LdsEmit::Dyn,
                max_page_size: 0x1000,
                ..Default::default()
            },
        )
        .expect("an absolute constant links");
        let secs = readelf_sections(&res.image);
        let body = |name: &str| {
            section_file_off(&res.image, secs.iter().find(|s| s.0 == name).expect(name).2)
        };
        let text_off = body(".text");
        assert_eq!(
            u32::from_le_bytes(res.image[text_off + 4..text_off + 8].try_into().unwrap()),
            0x1234
        );
        let data_off = body(".data");
        assert_eq!(
            u64::from_le_bytes(res.image[data_off..data_off + 8].try_into().unwrap()),
            0x1234
        );
        assert!(
            !secs.iter().any(|s| s.0 == ".rela.dyn" && s.3 > 0),
            "a constant needs no dynamic entry"
        );
    }

    /// An ABS64 slot against a symbol only the script defines is a
    /// load-address fixup like any other: it must reach the dynamic
    /// tables (RELR here) and, since RELR stores the addend in place,
    /// carry the link-time value even under
    /// `--no-apply-dynamic-relocs`. The collection used to drop such
    /// slots -- no fixup, zero in place.
    #[test]
    fn dyn_link_relocates_script_symbol_slots() {
        let script = parse_linker_script(
            "ENTRY(_start)\nSECTIONS {\n  . = 0;\n  .text : { *(.text*) }\n  .rodata : { table_start = .; *(.rodata*) }\n  .data : { *(.data*) }\n  .rela.dyn : { *(.rela .rela*) }\n  .relr.dyn : { *(.relr.dyn) }\n}",
        )
        .expect("parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0u8; 8],
            )
            .sec(".rodata", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 8])
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
            .sym("table_start", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
            // Symtab: null(0), sections(1..=3), _start(4), table_start(5).
            .reloc(2, 0, 5, rt::R_AARCH64_ABS64, 0)
            .build(EM_AARCH64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let opts = LdsOptions {
            emit: LdsEmit::Dyn,
            pack_relative_relocs: true,
            apply_dynamic_relocs: false,
            max_page_size: 0x10000,
            ..Default::default()
        };
        let res = link_with_script(&script, objs, &opts).expect("links");
        let secs = readelf_sections(&res.image);
        let ro_addr = secs.iter().find(|s| s.0 == ".rodata").unwrap().2;
        let data_addr = secs.iter().find(|s| s.0 == ".data").unwrap().2;
        let relr = secs.iter().find(|s| s.0 == ".relr.dyn").expect("relr");
        assert!(relr.3 >= 8, "script-symbol slot must reach RELR");
        let relr_off = section_file_off(&res.image, relr.2);
        let w0 = u64::from_le_bytes(res.image[relr_off..relr_off + 8].try_into().unwrap());
        assert_eq!(w0, data_addr, "RELR relocates the slot");
        let d_off = section_file_off(&res.image, data_addr);
        let slot = u64::from_le_bytes(res.image[d_off..d_off + 8].try_into().unwrap());
        assert_eq!(slot, ro_addr, "slot holds the link-time value in place");
    }
    /// A shared object's linker script names the dynamic tables, so
    /// they must come out with the shape a loader searches: a
    /// `.dynsym` holding only what `VERSION` exports, hash tables that
    /// find those names, version tables indexing them, and a
    /// `.dynamic` naming every one of them plus the soname.
    #[test]
    fn shared_link_emits_searchable_dynamic_metadata() {
        // The shape of a vDSO link: one exported name, one weak alias
        // whose string is a suffix of it, and everything else local.
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = SIZEOF_HEADERS;
  .hash : { *(.hash) }
  .gnu.hash : { *(.gnu.hash) }
  .dynsym : { *(.dynsym) }
  .dynstr : { *(.dynstr) }
  .gnu.version : { *(.gnu.version) }
  .gnu.version_d : { *(.gnu.version_d) }
  .dynamic : { *(.dynamic) } :text :dynamic
  .text : { *(.text*) } :text
  /DISCARD/ : { *(.note*) *(.comment) *(.rela*) *(.got*) }
}
PHDRS { text PT_LOAD FLAGS(5) FILEHDR PHDRS; dynamic PT_DYNAMIC FLAGS(4); }
VERSION { LINUX_2.6 { global: __vdso_time; time; local: *; }; }
"#,
        )
        .expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 32],
            )
            .sym("__vdso_time", STB_GLOBAL, STT_FUNC, 0, 0, 16)
            .sym("time", STB_WEAK, STT_FUNC, 0, 0, 16)
            .sym("internal_helper", STB_GLOBAL, STT_FUNC, 0, 16, 16)
            .build(EM_X86_64);
        let opts = LdsOptions {
            emit: LdsEmit::Dyn,
            soname: Some("linux-vdso.so.1".to_string()),
            hash_style: HashStyle::Both,
            symbolic: true,
            max_page_size: 0x1000,
            ..Default::default()
        };
        let res = link_with_script(
            &script,
            alloc::vec![parse_lds_object("a.o", a).expect("parses")],
            &opts,
        )
        .expect("shared link succeeds");
        let secs = readelf_sections(&res.image);
        let sec = |n: &str| {
            secs.iter()
                .find(|s| s.0 == n)
                .unwrap_or_else(|| panic!("{n} in output"))
        };
        assert_eq!(sec(".dynsym").1, dynamic::SHT_DYNSYM);
        assert_eq!(sec(".hash").1, dynamic::SHT_HASH);
        assert_eq!(sec(".gnu.hash").1, dynamic::SHT_GNU_HASH);
        assert_eq!(sec(".gnu.version").1, dynamic::SHT_GNU_VERSYM);
        assert_eq!(sec(".gnu.version_d").1, dynamic::SHT_GNU_VERDEF);
        assert_eq!(sec(".dynamic").1, dynamic::SHT_DYNAMIC);

        // `.dynsym`: the null entry, the two exported names, and the
        // symbol naming the version. `internal_helper` is local.
        let dynsym = image_dynsyms(&res.image);
        let names: BTreeSet<&str> = dynsym.iter().map(|d| d.0.as_str()).collect();
        assert!(names.contains("__vdso_time"), "exported name is present");
        assert!(names.contains("time"), "exported alias is present");
        assert!(names.contains("LINUX_2.6"), "version names itself");
        assert!(
            !names.contains("internal_helper"),
            "`local: *` keeps an unlisted symbol out of .dynsym"
        );
        assert_eq!(dynsym[0].0, "", "index 0 is the null entry");

        // The exported alias shares the longer name's bytes, as bfd's
        // `.dynstr` does.
        let dynstr_off = section_file_off(&res.image, sec(".dynstr").2);
        let dynstr = &res.image[dynstr_off..dynstr_off + sec(".dynstr").3 as usize];
        assert_eq!(
            dynstr.iter().filter(|&&b| b == 0).count(),
            4,
            ".dynstr holds only __vdso_time, the soname, the version, and the leading NUL"
        );

        // Both hash tables find every exported name.
        let hash_off = section_file_off(&res.image, sec(".hash").2);
        let hash = &res.image[hash_off..hash_off + sec(".hash").3 as usize];
        let gnu_off = section_file_off(&res.image, sec(".gnu.hash").2);
        let gnu = &res.image[gnu_off..gnu_off + sec(".gnu.hash").3 as usize];
        for (i, (name, _, _)) in dynsym.iter().enumerate().skip(1) {
            assert_eq!(
                sysv_lookup(hash, &dynsym, name),
                Some(i),
                "`{name}' via .hash"
            );
            assert_eq!(
                gnu_lookup(gnu, &dynsym, name),
                Some(i),
                "`{name}' via .gnu.hash"
            );
        }

        // One versym per dynsym entry; every exported symbol carries
        // the user version (index 2, the base node being index 1).
        assert_eq!(sec(".gnu.version").3, dynsym.len() as u64 * 2);
        let vs_off = section_file_off(&res.image, sec(".gnu.version").2);
        for (i, d) in dynsym.iter().enumerate().skip(1) {
            let v = u16::from_le_bytes(
                res.image[vs_off + i * 2..vs_off + i * 2 + 2]
                    .try_into()
                    .unwrap(),
            );
            assert_eq!(v, 2, "`{}' carries LINUX_2.6", d.0);
        }
        // Two version definitions: the base (the soname) and LINUX_2.6.
        assert_eq!(sec(".gnu.version_d").3, 2 * (20 + 8));

        // `.dynamic` names each table at the address it landed on.
        let dyn_off = section_file_off(&res.image, sec(".dynamic").2);
        let tags: HashMap<u64, u64> = res.image[dyn_off..dyn_off + sec(".dynamic").3 as usize]
            .chunks_exact(16)
            .map(|c| {
                (
                    u64::from_le_bytes(c[0..8].try_into().unwrap()),
                    u64::from_le_bytes(c[8..16].try_into().unwrap()),
                )
            })
            .collect();
        assert_eq!(tags.get(&dynamic::DT_HASH), Some(&sec(".hash").2));
        assert_eq!(tags.get(&dynamic::DT_GNU_HASH), Some(&sec(".gnu.hash").2));
        assert_eq!(tags.get(&dynamic::DT_SYMTAB), Some(&sec(".dynsym").2));
        assert_eq!(tags.get(&dynamic::DT_STRTAB), Some(&sec(".dynstr").2));
        assert_eq!(tags.get(&dynamic::DT_STRSZ), Some(&sec(".dynstr").3));
        assert_eq!(tags.get(&dynamic::DT_SYMENT), Some(&24));
        assert_eq!(tags.get(&dynamic::DT_VERSYM), Some(&sec(".gnu.version").2));
        assert_eq!(
            tags.get(&dynamic::DT_VERDEF),
            Some(&sec(".gnu.version_d").2)
        );
        assert_eq!(tags.get(&dynamic::DT_VERDEFNUM), Some(&2));
        assert_eq!(tags.get(&dynamic::DT_SYMBOLIC), Some(&0));
        assert_eq!(tags.get(&dynamic::DT_FLAGS), Some(&dynamic::DF_SYMBOLIC));
        assert!(tags.contains_key(&dynamic::DT_NULL));
        // DT_SONAME names the soname's offset in .dynstr.
        let soname_off = *tags.get(&dynamic::DT_SONAME).expect("DT_SONAME") as usize;
        assert_eq!(
            strz(dynstr, soname_off),
            "linux-vdso.so.1",
            "DT_SONAME points at the soname"
        );

        // PT_DYNAMIC covers `.dynamic` exactly.
        let phdrs = image_phdrs(&res.image);
        let pd = phdrs
            .iter()
            .find(|p| p.p_type == PT_DYNAMIC)
            .expect("PT_DYNAMIC");
        assert_eq!(pd.p_vaddr, sec(".dynamic").2);
        assert_eq!(pd.p_filesz, sec(".dynamic").3);

        // `.dynsym` links to `.dynstr`, the hash tables to `.dynsym`.
        let link_of = |n: &str| section_link(&res.image, n);
        assert_eq!(link_of(".dynsym"), section_index(&res.image, ".dynstr"));
        assert_eq!(link_of(".hash"), section_index(&res.image, ".dynsym"));
        assert_eq!(link_of(".gnu.hash"), section_index(&res.image, ".dynsym"));
        assert_eq!(
            link_of(".gnu.version"),
            section_index(&res.image, ".dynsym")
        );
        assert_eq!(
            link_of(".gnu.version_d"),
            section_index(&res.image, ".dynstr")
        );
        assert_eq!(link_of(".dynamic"), section_index(&res.image, ".dynstr"));
    }

    /// A final link with no `-T` runs the built-in default script.
    /// This is the shape of kbuild's RELR probe: `void *p = &p;`
    /// linked `-shared -Bsymbolic -z pack-relative-relocs`.
    #[test]
    fn scriptless_shared_link_uses_the_default_script() {
        let script = parse_linker_script(&super::super::default_script::default_script(true))
            .expect("the built-in default script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 16],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
            .sym("p", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
            // Symtab: null(0), sections(1,2), p(3).
            .reloc(1, 0, 3, rt::R_X86_64_64, 0)
            .build(EM_X86_64);
        let opts = LdsOptions {
            emit: LdsEmit::Dyn,
            symbolic: true,
            pack_relative_relocs: true,
            max_page_size: 0x200000,
            ..Default::default()
        };
        let res = link_with_script(
            &script,
            alloc::vec![parse_lds_object("t.o", a).expect("parses")],
            &opts,
        )
        .expect("scriptless shared link succeeds");
        assert_eq!(
            u16::from_le_bytes(res.image[16..18].try_into().unwrap()),
            ET_DYN
        );
        let secs = readelf_sections(&res.image);
        let sec = |n: &str| {
            secs.iter()
                .find(|s| s.0 == n)
                .unwrap_or_else(|| panic!("{n} in output"))
        };
        // The default script places the dynamic tables and RELR.
        assert!(sec(".relr.dyn").3 >= 8, ".relr.dyn carries the fixup");
        let dynsym = image_dynsyms(&res.image);
        assert!(
            dynsym.iter().any(|d| d.0 == "p"),
            "the defined global reaches .dynsym"
        );
        // A symbol the script defines is exported too, and it is sized
        // for: the tables are built from the same set the sizing pass
        // measured, or the writer refuses the link.
        assert!(
            dynsym.iter().any(|d| d.0 == "_end"),
            "a script-defined symbol reaches .dynsym"
        );
        assert_eq!(
            sec(".dynsym").3 as usize,
            dynsym.len() * 24,
            ".dynsym is sized for exactly what it holds"
        );
        // Read-only tables below the writable group, each on its own
        // segment, as ld's default lays them out.
        assert!(sec(".gnu.hash").2 < sec(".text").2);
        assert!(sec(".text").2 < sec(".dynamic").2);
        assert!(sec(".dynamic").2 < sec(".data").2);
        let dyn_off = section_file_off(&res.image, sec(".dynamic").2);
        let tags: HashMap<u64, u64> = res.image[dyn_off..dyn_off + sec(".dynamic").3 as usize]
            .chunks_exact(16)
            .map(|c| {
                (
                    u64::from_le_bytes(c[0..8].try_into().unwrap()),
                    u64::from_le_bytes(c[8..16].try_into().unwrap()),
                )
            })
            .collect();
        assert_eq!(tags.get(&dynamic::DT_RELR), Some(&sec(".relr.dyn").2));
        assert_eq!(tags.get(&dynamic::DT_RELRSZ), Some(&sec(".relr.dyn").3));
        assert_eq!(tags.get(&dynamic::DT_RELRENT), Some(&8));
        assert_eq!(tags.get(&dynamic::DT_GNU_HASH), Some(&sec(".gnu.hash").2));
        // The writable group gets its own PT_LOAD and a PT_DYNAMIC.
        let phdrs = image_phdrs(&res.image);
        let loads: Vec<&Elf64Phdr> = phdrs.iter().filter(|p| p.p_type == PT_LOAD).collect();
        assert_eq!(loads.len(), 2, "read-only and writable segments");
        assert_eq!(loads[0].p_flags & PF_W, 0);
        assert_ne!(loads[1].p_flags & PF_W, 0);
        assert!(phdrs.iter().any(|p| p.p_type == PT_DYNAMIC));
    }

    /// A script that discards the dynamic tables gets no dynamic
    /// sections, which is how the kernel's own `-shared` links stay
    /// unchanged.
    #[test]
    fn shared_link_honours_discarding_the_dynamic_tables() {
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = 0;
  /DISCARD/ : { *(.dynsym) *(.dynstr) *(.hash) *(.gnu.hash) *(.dynamic) *(.gnu.version*) }
  .text : { *(.text*) }
  .rela.dyn : { *(.rela*) }
}
"#,
        )
        .expect("parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0u8; 8],
            )
            .sym("exported", STB_GLOBAL, STT_FUNC, 0, 0, 8)
            .build(EM_X86_64);
        let opts = LdsOptions {
            emit: LdsEmit::Dyn,
            max_page_size: 0x1000,
            ..Default::default()
        };
        let res = link_with_script(
            &script,
            alloc::vec![parse_lds_object("a.o", a).expect("parses")],
            &opts,
        )
        .expect("links");
        for n in [".dynsym", ".dynstr", ".gnu.hash", ".hash", ".dynamic"] {
            assert!(
                !readelf_sections(&res.image).iter().any(|s| s.0 == n),
                "{n} must stay discarded"
            );
        }
        assert!(
            !image_phdrs(&res.image)
                .iter()
                .any(|p| p.p_type == PT_DYNAMIC),
            "no PT_DYNAMIC without a .dynamic"
        );
    }

    /// bfd merge layout for an aligned string class: entries keep the
    /// alignment implied by their input offsets, deduplicate on
    /// identity, tail-merge only when the length difference is a
    /// multiple of the shorter entry's alignment, assign offsets in
    /// first-seen order with padding, and the pool tail pads to the
    /// section alignment when every member size is a multiple of it.
    #[test]
    fn merge_pool_matches_bfd_layout() {
        let script = parse_linker_script(
            "SECTIONS { . = 0x1000; .text : { *(.text*) } .rodata : { *(.rodata*) } }",
        )
        .expect("parses");
        let a = TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
            .sec(
                ".rodata.str1.8",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
                8,
                b"world\0\0\0friend\0\0",
            )
            .entsize(1, 1)
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .sym("m1_pad", STB_GLOBAL, STT_OBJECT, 1, 6, 0)
            .sym("m1_end", STB_GLOBAL, STT_OBJECT, 1, 16, 0)
            .build(EM_X86_64);
        let b = TestObj::new()
            .sec(
                ".rodata.str1.8",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
                8,
                b"orld\0\0\0\0",
            )
            .entsize(0, 1)
            .sym("b_str", STB_GLOBAL, STT_OBJECT, 0, 0, 5)
            .build(EM_X86_64);
        let objs = alloc::vec![
            parse_lds_object("a.o", a).expect("parses"),
            parse_lds_object("b.o", b).expect("parses"),
        ];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let secs = readelf_sections(&res.image);
        let ro = secs.iter().find(|s| s.0 == ".rodata").expect("rodata");
        // "orld\0" cannot tail into "world\0": the length delta (1) is
        // not a multiple of its alignment (8). The empty string from
        // the padding (alignment 2) tails into "orld\0" at delta 4.
        // First-seen layout with per-entry alignment:
        //   world\0 @0, friend\0 @8, orld\0 @16, tail pad to 24.
        assert_eq!(ro.3, 24, "pool size");
        let off = section_file_off(&res.image, ro.2);
        assert_eq!(
            &res.image[off..off + 24],
            b"world\0\0\0friend\0\0orld\0\0\0\0"
        );
        let syms = image_symbols(&res.image);
        assert_eq!(find_sym(&syms, "b_str"), ro.2 + 16);
        // The padding byte at input offset 6 remaps to the shared
        // empty string inside "orld\0" (its NUL at pool offset 20).
        assert_eq!(find_sym(&syms, "m1_pad"), ro.2 + 20);
        // An offset at the input's end resolves to the pool's end.
        assert_eq!(find_sym(&syms, "m1_end"), ro.2 + 24);
    }

    /// Fixed-entsize pools deduplicate on identity in first-seen
    /// order; a section whose entsize is below its alignment fails
    /// bfd's sanity check and stays unmerged.
    #[test]
    fn merge_fixed_pool_dedupes_and_rejects_underaligned() {
        let script = parse_linker_script(
            "SECTIONS { . = 0x1000; .text : { *(.text*) } .rodata : { *(.rodata*) } }",
        )
        .expect("parses");
        let a = TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
            .sec(
                ".rodata.cst8",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_MERGE,
                8,
                &[
                    1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
                ],
            )
            // entsize 8 below the 16-byte alignment: kept verbatim.
            .sec(
                ".rodata.cst16",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_MERGE,
                16,
                &[3u8; 16],
            )
            .entsize(1, 8)
            .entsize(2, 8)
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .sym("third", STB_GLOBAL, STT_OBJECT, 1, 16, 8)
            .build(EM_X86_64);
        let b = TestObj::new()
            .sec(
                ".rodata.cst8",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_MERGE,
                8,
                &[2, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0],
            )
            .entsize(0, 8)
            .sym("b_two", STB_GLOBAL, STT_OBJECT, 0, 0, 8)
            .sym("b_four", STB_GLOBAL, STT_OBJECT, 0, 8, 8)
            .build(EM_X86_64);
        let objs = alloc::vec![
            parse_lds_object("a.o", a).expect("parses"),
            parse_lds_object("b.o", b).expect("parses"),
        ];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let secs = readelf_sections(&res.image);
        let ro = secs.iter().find(|s| s.0 == ".rodata").expect("rodata");
        // Pool: [1][2][4] (24 bytes), pad to 16, verbatim cst16.
        assert_eq!(ro.3, 24 + 8 + 16, "pool + alignment pad + verbatim cst16");
        let syms = image_symbols(&res.image);
        assert_eq!(find_sym(&syms, "third"), ro.2, "duplicate entry folds");
        assert_eq!(find_sym(&syms, "b_two"), ro.2 + 8);
        assert_eq!(find_sym(&syms, "b_four"), ro.2 + 16);
    }

    fn shared_input(soname: &str, funcs: &[&str], data: &[&str]) -> SharedInput {
        SharedInput {
            lib: SharedLibrary {
                soname: soname.to_string(),
                exports: funcs.iter().chain(data).map(|s| s.to_string()).collect(),
                data_exports: data.iter().map(|s| s.to_string()).collect(),
            },
            as_needed: false,
        }
    }

    /// A PIE against shared libraries, under the built-in script.
    fn dynamic_opts(libs: Vec<SharedInput>) -> LdsOptions {
        LdsOptions {
            emit: LdsEmit::Dyn,
            interp: Some(String::from("/lib64/ld-linux-x86-64.so.2")),
            shared_libs: libs,
            max_page_size: 0x200000,
            ..LdsOptions::default()
        }
    }

    /// `.text` calling `foo` and loading `bar` through the GOT.
    fn import_user() -> Vec<u8> {
        let body = [
            0xe8, 0, 0, 0, 0, // call foo
            0x48, 0x8b, 0x05, 0, 0, 0, 0, // mov bar@GOTPCREL(%rip), %rax
            0xc3, 0, 0, 0,
        ];
        TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &body)
            .reloc(0, 1, 3, rt::R_X86_64_PLT32, -4)
            .reloc(0, 8, 4, rt::R_X86_64_REX_GOTPCRELX, -4)
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 13)
            .sym("foo", STB_GLOBAL, STT_FUNC, usize::MAX, 0, 0)
            .sym("bar", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
            .build(EM_X86_64)
    }

    fn dyn_tags(image: &[u8]) -> Vec<(u64, u64)> {
        let (_, body) = image_section(image, ".dynamic");
        body.chunks_exact(16)
            .map(|c| {
                (
                    u64::from_le_bytes(c[..8].try_into().unwrap()),
                    u64::from_le_bytes(c[8..].try_into().unwrap()),
                )
            })
            .collect()
    }

    fn dynstr_at(image: &[u8], off: u64) -> String {
        let (_, s) = image_section(image, ".dynstr");
        strz(&s, off as usize)
    }

    /// A shared library input takes a `DT_NEEDED` naming its soname,
    /// and `--dynamic-linker` an `.interp` a loader can find through
    /// `PT_INTERP`, with `PT_PHDR` for the load bias.
    #[test]
    fn a_shared_library_input_records_a_dependency() {
        let script = parse_linker_script(&default_script(true)).expect("parses");
        let objs = alloc::vec![parse_lds_object("a.o", import_user()).expect("parses")];
        let mut opts = dynamic_opts(alloc::vec![
            shared_input("libc.so.6", &["foo"], &["bar"]),
            shared_input("libm.so.6", &["unused"], &[]),
        ]);
        opts.rpath = alloc::vec![String::from("/opt/lib"), String::from("$ORIGIN")];
        opts.shared_libs[1].as_needed = true;
        let res = link_with_script(&script, objs, &opts).expect("links");
        let needed: Vec<String> = dyn_tags(&res.image)
            .iter()
            .filter(|&&(t, _)| t == dynamic::DT_NEEDED)
            .map(|&(_, v)| dynstr_at(&res.image, v))
            .collect();
        assert_eq!(
            needed,
            alloc::vec![String::from("libc.so.6")],
            "the library the link binds to is recorded; an AS_NEEDED one it does not use is not"
        );
        let rpath: Vec<String> = dyn_tags(&res.image)
            .iter()
            .filter(|&&(t, _)| t == dynamic::DT_RPATH)
            .map(|&(_, v)| dynstr_at(&res.image, v))
            .collect();
        assert_eq!(rpath, alloc::vec![String::from("/opt/lib:$ORIGIN")]);
        let (_, interp) = image_section(&res.image, ".interp");
        assert_eq!(interp, b"/lib64/ld-linux-x86-64.so.2\0");
        let phdrs = image_phdrs(&res.image);
        let interp_seg = phdrs
            .iter()
            .find(|p| p.p_type == PT_INTERP)
            .expect("PT_INTERP");
        let (addr, _) = image_section(&res.image, ".interp");
        assert_eq!(interp_seg.p_vaddr, addr);
        let phdr_seg = phdrs.iter().find(|p| p.p_type == PT_PHDR).expect("PT_PHDR");
        assert_eq!(phdr_seg.p_offset, 64, "the table follows the ELF header");
        assert_eq!(
            phdr_seg.p_filesz,
            phdrs.len() as u64 * 56,
            "and covers all of it"
        );
        let load = phdrs
            .iter()
            .find(|p| p.p_type == PT_LOAD)
            .expect("a loadable segment");
        assert_eq!(
            (load.p_offset, load.p_vaddr),
            (0, 0),
            "the first load covers the headers a loader reads"
        );
    }

    /// A call to an imported function reaches it through a PLT stub and
    /// a load through a GOT slot the loader fills from a `GLOB_DAT`
    /// entry naming the symbol.
    #[test]
    fn an_import_binds_through_a_stub_and_a_got_slot() {
        let script = parse_linker_script(&default_script(true)).expect("parses");
        let objs = alloc::vec![parse_lds_object("a.o", import_user()).expect("parses")];
        let opts = dynamic_opts(alloc::vec![shared_input("libc.so.6", &["foo"], &["bar"])]);
        let res = link_with_script(&script, objs, &opts).expect("links");
        // Imports lead the table, in name order, so a relocation can
        // name one by index.
        let syms = image_dynsyms(&res.image);
        assert_eq!(syms[1].0, "bar");
        assert_eq!(syms[2].0, "foo");
        assert_eq!((syms[1].2, syms[2].2), (SHN_UNDEF, SHN_UNDEF));

        let (got_addr, _) = image_section(&res.image, ".got");
        let (_, rela) = image_section(&res.image, ".rela.dyn");
        let entries: Vec<(u64, u32, u32)> = rela
            .chunks_exact(24)
            .map(|c| {
                let info = u64::from_le_bytes(c[8..16].try_into().unwrap());
                (
                    u64::from_le_bytes(c[..8].try_into().unwrap()),
                    (info >> 32) as u32,
                    info as u32,
                )
            })
            .collect();
        let glob: Vec<&(u64, u32, u32)> = entries
            .iter()
            .filter(|e| e.2 == rt::R_X86_64_GLOB_DAT)
            .collect();
        assert_eq!(glob.len(), 2, "one slot per import");
        assert_eq!(
            (glob[0].0, glob[0].1),
            (got_addr, 1),
            "bar's slot names bar"
        );
        assert_eq!(
            (glob[1].0, glob[1].1),
            (got_addr + 8, 2),
            "foo's slot names foo"
        );

        let (text_addr, text) = image_section(&res.image, ".text");
        let (plt_addr, plt) = image_section(&res.image, ".plt");
        assert_eq!(plt.len(), 16, "only the called import takes a stub");
        let call = i32::from_le_bytes(text[1..5].try_into().unwrap()) as i64;
        assert_eq!(
            text_addr as i64 + 5 + call,
            plt_addr as i64,
            "the call reaches the stub"
        );
        let load = i32::from_le_bytes(text[8..12].try_into().unwrap()) as i64;
        assert_eq!(
            text_addr as i64 + 12 + load,
            got_addr as i64,
            "the load keeps its GOT slot rather than relaxing to an address"
        );
        assert_eq!(
            text[5..8],
            [0x48, 0x8b, 0x05],
            "so the load is not rewritten"
        );
        // The stub jumps through the slot: ff 25 <rip-relative>.
        assert_eq!(plt[..2], [0xff, 0x25]);
        let disp = i32::from_le_bytes(plt[2..6].try_into().unwrap()) as i64;
        assert_eq!(plt_addr as i64 + 6 + disp, got_addr as i64 + 8);
    }

    /// A reference that would need the imported object copied into this
    /// image is refused rather than left pointing at nothing.
    #[test]
    fn a_direct_reference_to_imported_data_is_refused() {
        let script = parse_linker_script(&default_script(true)).expect("parses");
        let obj = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0x90; 8],
            )
            .reloc(0, 2, 3, rt::R_X86_64_PC32, -4)
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
            .sym("bar", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
            .build(EM_X86_64);
        let objs = alloc::vec![parse_lds_object("a.o", obj).expect("parses")];
        let opts = dynamic_opts(alloc::vec![shared_input("libc.so.6", &[], &["bar"])]);
        let e = alloc::format!(
            "{}",
            link_with_script(&script, objs, &opts).expect_err("refused")
        );
        assert!(
            e.contains("`bar'") && e.contains("cannot reach a shared library"),
            "{e}"
        );
    }

    /// A `zR` CIE, the shape gcc emits for a unit needing no
    /// personality routine.
    fn eh_cie_zr() -> Vec<u8> {
        alloc::vec![
            0x14, 0, 0, 0, 0, 0, 0, 0, 1, b'z', b'R', 0, 1, 0x78, 0x10, 1, 0x1b, 0x0c, 0x07, 0x08,
            0x90, 0x01, 0, 0,
        ]
    }

    /// A `zPR` CIE; its personality pointer sits at offset 0x12 and is
    /// relocated.
    fn eh_cie_zpr() -> Vec<u8> {
        alloc::vec![
            0x1c, 0, 0, 0, 0, 0, 0, 0, 1, b'z', b'P', b'R', 0, 1, 0x78, 0x10, 6, 0x9b, 0, 0, 0, 0,
            0x1b, 0x0c, 0x07, 0x08, 0x90, 0x01, 0, 0, 0, 0,
        ]
    }

    /// An FDE of `total` bytes naming a CIE `back` bytes before its own
    /// pointer field; its initial location sits at offset 8 and is
    /// relocated.
    fn eh_fde_sized(back: u32, total: usize) -> Vec<u8> {
        let mut f: Vec<u8> = alloc::vec![(total - 4) as u8, 0, 0, 0];
        f.extend_from_slice(&back.to_le_bytes());
        f.extend_from_slice(&[0, 0, 0, 0, 8, 0, 0, 0]);
        f.resize(total, 0);
        f
    }

    fn eh_fde(back: u32) -> Vec<u8> {
        eh_fde_sized(back, 24)
    }

    fn image_section(image: &[u8], name: &str) -> (u64, Vec<u8>) {
        let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
        let sh = |i: usize| -> Elf64Shdr { read_struct(image, shoff + i * 64).unwrap() };
        let str_sh = sh(u16::from_le_bytes(image[62..64].try_into().unwrap()) as usize);
        let names = &image[str_sh.sh_offset as usize..(str_sh.sh_offset + str_sh.sh_size) as usize];
        let h = (1..shnum)
            .map(sh)
            .find(|h| strz(names, h.sh_name as usize) == name)
            .expect("section is in the image");
        (
            h.sh_addr,
            image[h.sh_offset as usize..(h.sh_offset + h.sh_size) as usize].to_vec(),
        )
    }

    /// bfd folds the identical CIEs of separately compiled units into
    /// one and repoints every FDE at it. The pointer is the distance
    /// back from its own field, so each FDE takes a different value.
    #[test]
    fn eh_frame_folds_identical_cies() {
        let script = parse_linker_script(
            "SECTIONS { . = 0x1000; .text : { *(.text) } .eh_frame : { *(.eh_frame) } }",
        )
        .expect("parses");
        let unit = |name: &str| {
            let mut eh = eh_cie_zr();
            eh.extend_from_slice(&eh_fde(0x1c));
            TestObj::new()
                .sec(
                    ".text",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    8,
                    &[0x90; 8],
                )
                .sec(".eh_frame", SHT_PROGBITS, SHF_ALLOC, 8, &eh)
                // The FDE's initial location, against the text it covers.
                .reloc(1, 0x20, 1, rt::R_X86_64_PC32, 0)
                .sym(name, STB_GLOBAL, STT_FUNC, 0, 0, 8)
                .build(EM_X86_64)
        };
        let objs = alloc::vec![
            parse_lds_object("a.o", unit("fa")).expect("parses"),
            parse_lds_object("b.o", unit("fb")).expect("parses"),
        ];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let (addr, body) = image_section(&res.image, ".eh_frame");
        assert_eq!(body.len(), 24 + 24 + 24, "one CIE, both FDEs");
        assert_eq!(&body[..24], &eh_cie_zr()[..], "the first CIE stays");
        assert_eq!(
            u32::from_le_bytes(body[0x1c..0x20].try_into().unwrap()),
            0x1c
        );
        assert_eq!(
            u32::from_le_bytes(body[0x34..0x38].try_into().unwrap()),
            0x34,
            "the second FDE reaches back to the surviving CIE"
        );
        let fdes = eh_frame::scan(&body, addr).expect("scans");
        let syms = image_symbols(&res.image);
        assert_eq!(
            fdes.iter().map(|e| e.pc).collect::<Vec<_>>(),
            alloc::vec![find_sym(&syms, "fa"), find_sym(&syms, "fb")],
            "both FDEs still cover their own text"
        );
    }

    /// A zero length ends `.eh_frame`, so the alignment padding between
    /// two inputs may not fall inside the linked stream: the entry
    /// before it absorbs the gap, as bfd's writer does.
    #[test]
    fn eh_frame_entries_leave_no_gap_at_an_input_boundary() {
        let script = parse_linker_script(
            "SECTIONS { . = 0x1000; .text : { *(.text) } .eh_frame : { *(.eh_frame) } }",
        )
        .expect("parses");
        // 24-byte CIE + 20-byte FDE: 44 bytes under an 8-byte
        // alignment, so the next input would start four bytes on.
        let unit = |name: &str| {
            let mut eh = eh_cie_zr();
            eh.extend_from_slice(&eh_fde_sized(0x1c, 20));
            TestObj::new()
                .sec(
                    ".text",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    8,
                    &[0x90; 8],
                )
                .sec(".eh_frame", SHT_PROGBITS, SHF_ALLOC, 8, &eh)
                .reloc(1, 0x20, 1, rt::R_X86_64_PC32, 0)
                .sym(name, STB_GLOBAL, STT_FUNC, 0, 0, 8)
                .build(EM_X86_64)
        };
        let objs = alloc::vec![
            parse_lds_object("a.o", unit("fa")).expect("parses"),
            parse_lds_object("b.o", unit("fb")).expect("parses"),
        ];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let (addr, body) = image_section(&res.image, ".eh_frame");
        assert_eq!(body.len(), 24 + 24 + 24, "one CIE and two padded FDEs");
        assert_eq!(
            u32::from_le_bytes(body[0x18..0x1c].try_into().unwrap()),
            0x14,
            "the first FDE covers the padding that followed it"
        );
        assert_eq!(eh_frame::scan(&body, addr).expect("scans").len(), 2);
        assert_eq!(eh_frame::count_fdes(&body), 2);
    }

    /// bfd keys a CIE on the personality routine it resolves to, not on
    /// the bytes of the pointer, which relocation leaves zero in every
    /// input.
    #[test]
    fn eh_frame_cies_split_on_the_personality_they_name() {
        let script = parse_linker_script(
            "SECTIONS { . = 0x1000; .text : { *(.text) } .eh_frame : { *(.eh_frame) } }",
        )
        .expect("parses");
        let unit = |fname: &str, pers: &str, defines: bool| {
            let mut eh = eh_cie_zpr();
            eh.extend_from_slice(&eh_fde(0x24));
            let o = TestObj::new()
                .sec(
                    ".text",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    8,
                    &[0x90; 8],
                )
                .sec(".eh_frame", SHT_PROGBITS, SHF_ALLOC, 8, &eh)
                .reloc(1, 0x12, 4, rt::R_X86_64_PC32, 0)
                .reloc(1, 0x28, 1, rt::R_X86_64_PC32, 0)
                .sym(fname, STB_GLOBAL, STT_FUNC, 0, 0, 8);
            let sec = if defines { 0 } else { usize::MAX };
            o.sym(pers, STB_GLOBAL, STT_FUNC, sec, 0, 0)
                .build(EM_X86_64)
        };
        let objs = alloc::vec![
            parse_lds_object("a.o", unit("fa", "pers", true)).expect("parses"),
            parse_lds_object("b.o", unit("fb", "pers", false)).expect("parses"),
            parse_lds_object("c.o", unit("fc", "pers2", true)).expect("parses"),
        ];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let (addr, body) = image_section(&res.image, ".eh_frame");
        assert_eq!(
            body.len(),
            32 + 24 + 24 + 32 + 24,
            "the two units naming one routine share a CIE; the third keeps its own"
        );
        assert_eq!(
            u32::from_le_bytes(body[0x3c..0x40].try_into().unwrap()),
            0x3c,
            "b.o's FDE reaches back to a.o's CIE"
        );
        assert_eq!(
            u32::from_le_bytes(body[0x74..0x78].try_into().unwrap()),
            0x24,
            "c.o's FDE keeps its own"
        );
        let syms = image_symbols(&res.image);
        let pers = find_sym(&syms, "pers");
        assert_eq!(
            i32::from_le_bytes(body[0x12..0x16].try_into().unwrap()) as i64 + (addr + 0x12) as i64,
            pers as i64,
            "the surviving CIE keeps its own personality relocation"
        );
        assert_eq!(eh_frame::scan(&body, addr).expect("scans").len(), 3);
    }

    /// An ABS64 against a non-local symbol in an allocated section the
    /// script discards reserves a `.rela.dyn` slot that is never
    /// written (bfd sizes the global path without a discard check);
    /// local-target relocs in the same section reserve nothing.
    #[test]
    fn discarded_alloc_relocs_reserve_none_slots() {
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = 0;
  .text : { *(.text*) }
  .data : { *(.data*) }
  .rela.dyn : { *(.rela .rela*) }
  .relr.dyn : { *(.relr.dyn) }
  /DISCARD/ : { *(.export_symbol) }
}
"#,
        )
        .expect("parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0u8; 8],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
            .sec(".export_symbol", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 16])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
            .sym("local_t", STB_LOCAL, STT_OBJECT, 0, 4, 0)
            // Symtab: null(0), sections(1..=3), _start(4), local_t(5).
            .reloc(1, 0, 4, rt::R_AARCH64_ABS64, 0)
            .reloc(2, 0, 4, rt::R_AARCH64_ABS64, 0)
            .reloc(2, 8, 5, rt::R_AARCH64_ABS64, 0)
            .build(EM_AARCH64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let opts = LdsOptions {
            emit: LdsEmit::Dyn,
            pack_relative_relocs: true,
            max_page_size: 0x10000,
            ..Default::default()
        };
        let res = link_with_script(&script, objs, &opts).expect("links");
        let secs = readelf_sections(&res.image);
        let rela = secs.iter().find(|s| s.0 == ".rela.dyn").expect("rela");
        // One reserved slot for the discarded global-target reloc; the
        // local-target one reserves nothing; the live .data slot packs
        // into RELR.
        assert_eq!(rela.3, 24, "one zeroed reservation");
        let off = section_file_off(&res.image, rela.2);
        assert_eq!(&res.image[off..off + 24], &[0u8; 24], "slot reads R_*_NONE");
        let relr = secs.iter().find(|s| s.0 == ".relr.dyn").expect("relr");
        assert!(relr.3 > 0, "live slot packed into RELR");
    }

    /// Symbols assigned from the top-level location counter attach per
    /// ld's section_for_dot: after a dot assignment they bind to the
    /// next output section, skipping one the link strips as empty;
    /// with no dot assignment in between they bind to the previous
    /// allocated section.
    #[test]
    fn boundary_symbols_attach_like_ld() {
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = 0x1000;
  .text : { *(.text*) }
  . = ALIGN(0x100);
  bnd = .;
  .maybe : { *(.absent) }
  .data : { *(.data*) }
  tail = .;
}
"#,
        )
        .expect("parses");
        let a = TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[1u8; 8])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .build(EM_X86_64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let secs = readelf_sections(&res.image);
        let data_shndx = (secs.iter().position(|s| s.0 == ".data").expect("data") + 1) as u16;
        let syms = image_symbols(&res.image);
        let shndx_of = |name: &str| {
            syms.iter()
                .find(|(n, _, _)| n == name)
                .unwrap_or_else(|| panic!("{name}"))
                .2
        };
        assert_eq!(shndx_of("bnd"), data_shndx, "dot assignment prefers next");
        assert_eq!(shndx_of("tail"), data_shndx, "previous allocated section");
    }

    /// `(name, st_info, st_shndx)` in symbol table order.
    fn image_sym_rows(image: &[u8]) -> Vec<(String, u8, u16)> {
        let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
        let sh = |i: usize| -> Elf64Shdr { read_struct(image, shoff + i * 64).unwrap() };
        for i in 1..shnum {
            let h = sh(i);
            if h.sh_type != SHT_SYMTAB {
                continue;
            }
            let strh = sh(h.sh_link as usize);
            let strtab = &image[strh.sh_offset as usize..(strh.sh_offset + strh.sh_size) as usize];
            return (0..(h.sh_size / 24) as usize)
                .map(|k| {
                    let s: Elf64Sym = read_struct(image, h.sh_offset as usize + k * 24).unwrap();
                    (strz(strtab, s.st_name as usize), s.st_info, s.st_shndx)
                })
                .collect();
        }
        Vec::new()
    }

    fn symtab_objects() -> Vec<LdsObject> {
        // a.o names its source file; b.o has none, and its section is
        // placed ahead of a.o's.
        let a = TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
            .sec(
                ".rodata.str1.1",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
                1,
                b"hi\0",
            )
            .entsize(1, 1)
            .sym("a.c", STB_LOCAL, STT_FILE, usize::MAX - 1, 0, 0)
            .sym("a_local", STB_LOCAL, STT_OBJECT, 0, 0, 1)
            .sym(".Lstr", STB_LOCAL, STT_NOTYPE, 1, 0, 0)
            .sym("gfunc", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .build(EM_X86_64);
        let b = TestObj::new()
            .sec(
                ".text.b",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0xc3],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
            .sym("b_local", STB_LOCAL, STT_OBJECT, 1, 0, 4)
            .sym("gdata", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
            .build(EM_X86_64);
        alloc::vec![
            parse_lds_object("obj/a.o", a).expect("a parses"),
            parse_lds_object("lib.a(b.o)", b).expect("b parses"),
        ]
    }

    const SYMTAB_SCRIPT: &str = r#"
SECTIONS {
  . = 0x1000;
  .btext : { *(.text.b) }
  .text : { *(.text) }
  .rodata : { *(.rodata.str1.1) }
  .data : { *(.data) }
  alias_func = gfunc;
  alias_data = gdata;
  alias_sum = gfunc + gdata;
}
"#;

    /// bfd's `.symtab` composition: no section symbols in a final link
    /// that emits no relocations, a file symbol heading every object's
    /// locals in placement order, compiler temporaries of a merged
    /// section dropped, and an assignment carrying the type of the one
    /// symbol its expression names.
    #[test]
    fn symtab_composition_follows_bfd() {
        let script = parse_linker_script(SYMTAB_SCRIPT).expect("script parses");
        let res = link_with_script(&script, symtab_objects(), &LdsOptions::default())
            .expect("link succeeds");
        let rows = image_sym_rows(&res.image);
        assert!(
            rows.iter().all(|(_, info, _)| info & 0xf != STT_SECTION),
            "no section symbols without emitted relocations"
        );
        let files: Vec<&str> = rows
            .iter()
            .filter(|(_, info, _)| info & 0xf == STT_FILE)
            .map(|(n, _, _)| n.as_str())
            .collect();
        assert_eq!(files, alloc::vec!["b.o", "a.c"], "placement order");
        let kind = |name: &str| {
            rows.iter()
                .find(|(n, _, _)| n == name)
                .unwrap_or_else(|| panic!("{name}"))
                .1
                & 0xf
        };
        assert_eq!(kind("alias_func"), STT_FUNC);
        assert_eq!(kind("alias_data"), STT_OBJECT);
        assert_eq!(kind("alias_sum"), STT_NOTYPE, "two names carry no type");
        assert!(
            !rows.iter().any(|(n, _, _)| n == ".Lstr"),
            "merged-section temporary dropped"
        );
        assert!(rows.iter().any(|(n, _, _)| n == "b_local"));
    }

    /// A definition taken from the location counter outside an output
    /// section carries a section in its own entry but hands a number
    /// to whatever names it, so the aliases a script builds from one
    /// are absolute, as they are in ld.
    #[test]
    fn a_symbol_defined_from_dot_hands_on_a_number() {
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = 0x1000;
  .text : { *(.text) in_text = .; }
  . = ALIGN(0x1000);
  etext = .;
  .data : { *(.data) }
}
alias_etext = etext;
alias_in_text = in_text;
alias_sum = etext + 4;
"#,
        )
        .expect("script parses");
        let a = TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .build(EM_X86_64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let syms = image_symbols(&res.image);
        let at = |n: &str| {
            let s = syms
                .iter()
                .find(|(name, _, _)| name == n)
                .unwrap_or_else(|| panic!("{n}"));
            (s.1, s.2)
        };
        let text_shndx = 1u16;
        assert_ne!(at("etext").1, SHN_ABS, "the definition keeps a section");
        assert_eq!(at("alias_etext"), (at("etext").0, SHN_ABS));
        assert_eq!(at("alias_sum"), (at("etext").0 + 4, SHN_ABS));
        assert_eq!(
            at("alias_in_text"),
            (at("in_text").0, text_shndx),
            "an in-section definition stays section relative"
        );
    }

    /// An undefined weak symbol reaches `.symtab` only where a
    /// relocation the output keeps names it, as in bfd.
    #[test]
    fn undefined_weak_symbols_need_a_relocation_naming_them() {
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = 0x1000;
  .text : { *(.text) }
  .data : { *(.data) }
  /DISCARD/ : { *(.gone) }
}
"#,
        )
        .expect("script parses");
        let obj = || {
            let a = TestObj::new()
                .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
                .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
                .sec(".gone", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 8])
                .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
                .sym("wu_kept", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
                .sym("wu_gone", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
                // Symtab: null(0), sections(1..=3), _start(4),
                // wu_kept(5), wu_gone(6).
                .reloc(1, 0, 5, rt::R_X86_64_64, 0)
                .reloc(2, 0, 6, rt::R_X86_64_64, 0)
                .build(EM_X86_64);
            alloc::vec![parse_lds_object("a.o", a).expect("parses")]
        };
        let res = link_with_script(&script, obj(), &LdsOptions::default()).expect("links");
        let names: Vec<String> = image_symbols(&res.image)
            .into_iter()
            .map(|(n, _, _)| n)
            .collect();
        assert!(!names.iter().any(|n| n.starts_with("wu_")), "none kept");
        let opts = LdsOptions {
            emit_relocs: true,
            ..Default::default()
        };
        let res = link_with_script(&script, obj(), &opts).expect("links");
        let weak: Vec<(String, u16)> = image_sym_rows(&res.image)
            .into_iter()
            .filter(|(_, info, _)| info >> 4 == STB_WEAK)
            .map(|(n, _, shndx)| (n, shndx))
            .collect();
        assert_eq!(weak, alloc::vec![("wu_kept".to_string(), SHN_UNDEF)]);
    }

    /// Without a PHDRS command a PT_LOAD ends where bfd ends one: at a
    /// protection change the sections do not share a page across, and
    /// at a skipped page. A same-page change and file-backed content
    /// after zero fill both stay in the segment.
    #[test]
    fn default_segments_group_like_bfd() {
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = 0;
  .header : { *(.header) }
  . = ALIGN(4);
  .rodata : { *(.rodata) }
  . = ALIGN(0x1000);
  .text : { *(.text) }
  . = ALIGN(0x1000);
  .data : { *(.data) }
  .bss : { *(.bss) }
  . = ALIGN(4);
  .signature : { *(.signature) }
}
"#,
        )
        .expect("script parses");
        let a = TestObj::new()
            .sec(".header", SHT_PROGBITS, SHF_ALLOC, 4, &[0u8; 8])
            .sec(".rodata", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0u8; 8])
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
            .sec(".bss", SHT_NOBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 32])
            .sec(".signature", SHT_PROGBITS, SHF_ALLOC, 4, &[0u8; 4])
            .build(EM_X86_64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let loads: Vec<Elf64Phdr> = image_phdrs(&res.image)
            .into_iter()
            .filter(|p| p.p_type == PT_LOAD)
            .collect();
        let shape: Vec<(u64, u64, u32)> = loads
            .iter()
            .map(|p| (p.p_vaddr, p.p_memsz, p.p_flags))
            .collect();
        assert_eq!(
            shape,
            alloc::vec![
                (0, 0x10, PF_R | PF_W),
                (0x1000, 1, PF_R | PF_X),
                (0x2000, 0x2c, PF_R | PF_W),
            ]
        );
    }

    /// Link order describes the whole output section, so bfd takes it
    /// from the section that opens one and points `sh_link` at the
    /// output section its target landed in; the retain flag survives
    /// while the group flag does not.
    #[test]
    fn output_section_flags_follow_bfd() {
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = 0x1000;
  .tgt : { *(.tgt) }
  .ordered : { *(.o1) *(.plain) }
  .unordered : { *(.plain2) *(.o2) }
  .kept : { *(.ret) *(.grp) }
}
"#,
        )
        .expect("script parses");
        let a = TestObj::new()
            .sec(".tgt", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 8])
            .sec(
                ".o1",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_LINK_ORDER,
                8,
                &[0u8; 8],
            )
            .sec(".plain", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 8])
            .sec(".plain2", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 8])
            .sec(
                ".o2",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_LINK_ORDER,
                8,
                &[0u8; 8],
            )
            .sec(
                ".ret",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_GNU_RETAIN,
                8,
                &[0u8; 8],
            )
            .sec(".grp", SHT_PROGBITS, SHF_ALLOC | SHF_GROUP, 8, &[0u8; 8])
            .links_to(1, 0)
            .links_to(4, 0)
            .build(EM_X86_64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let secs = readelf_sections(&res.image);
        let flags = |n: &str| {
            secs.iter()
                .find(|s| s.0 == n)
                .unwrap_or_else(|| panic!("{n}"))
                .4
        };
        assert_eq!(flags(".ordered") & SHF_LINK_ORDER, SHF_LINK_ORDER);
        assert_eq!(flags(".unordered") & SHF_LINK_ORDER, 0, "opened unordered");
        assert_eq!(flags(".kept") & SHF_GNU_RETAIN, SHF_GNU_RETAIN);
        assert_eq!(flags(".kept") & SHF_GROUP, 0, "group is input-side");
        let tgt = (secs.iter().position(|s| s.0 == ".tgt").expect("tgt") + 1) as u32;
        assert_eq!(section_link(&res.image, ".ordered"), tgt);
    }

    /// `--emit-relocs` gives the entries relocations name: one section
    /// symbol per output section, and the merged-section temporaries.
    #[test]
    fn emit_relocs_keeps_the_entries_relocations_name() {
        let script = parse_linker_script(SYMTAB_SCRIPT).expect("script parses");
        let opts = LdsOptions {
            emit_relocs: true,
            ..Default::default()
        };
        let res = link_with_script(&script, symtab_objects(), &opts).expect("link succeeds");
        let rows = image_sym_rows(&res.image);
        let sections = rows
            .iter()
            .filter(|(_, i, _)| i & 0xf == STT_SECTION)
            .count();
        assert_eq!(sections, readelf_sections(&res.image).len() - 3, "one each");
        assert!(rows.iter().any(|(n, _, _)| n == ".Lstr"));
    }

    /// An unresolved default-visibility weak reference keeps
    /// symbol-based dynamic entries (ABS64 at its slots, GLOB_DAT for
    /// its GOT entry) instead of resolving statically; a hidden global
    /// is emitted with local binding in a dynamic link.
    #[test]
    fn undefweak_keeps_symbol_entries_and_hidden_forces_local() {
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = 0;
  .text : { *(.text*) }
  .got : { *(.got) }
  .data : { *(.data*) }
  .rela.dyn : { *(.rela .rela*) }
  .relr.dyn : { *(.relr.dyn) }
}
"#,
        )
        .expect("parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0u8; 8],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
            .sym("wref", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
            .sym("hid", STB_GLOBAL, STT_FUNC, 0, 4, 0)
            .vis(STV_HIDDEN)
            // Symtab: null(0), sections(1..=2), _start(3), wref(4), hid(5).
            .reloc(1, 0, 4, rt::R_AARCH64_ABS64, 0)
            .reloc(0, 0, 4, rt::R_AARCH64_ADR_GOT_PAGE, 0)
            .reloc(0, 4, 4, rt::R_AARCH64_LD64_GOT_LO12_NC, 0)
            .build(EM_AARCH64);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let opts = LdsOptions {
            emit: LdsEmit::Dyn,
            pack_relative_relocs: true,
            max_page_size: 0x10000,
            ..Default::default()
        };
        let res = link_with_script(&script, objs, &opts).expect("links");
        let secs = readelf_sections(&res.image);
        let rela = secs.iter().find(|s| s.0 == ".rela.dyn").expect("rela");
        assert_eq!(rela.3, 48, "GLOB_DAT for the GOT slot + ABS64 at the site");
        let off = section_file_off(&res.image, rela.2);
        let types: Vec<u32> = (0..2)
            .map(|k| {
                u32::from_le_bytes(
                    res.image[off + k * 24 + 8..off + k * 24 + 12]
                        .try_into()
                        .unwrap(),
                )
            })
            .collect();
        assert!(types.contains(&rt::R_AARCH64_GLOB_DAT));
        assert!(types.contains(&rt::R_AARCH64_ABS64));
        // The hidden global is forced local: nm reports it lowercase.
        let shoff = u64::from_le_bytes(res.image[40..48].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(res.image[60..62].try_into().unwrap()) as usize;
        let mut hid_info = None;
        for i in 1..shnum {
            let h: Elf64Shdr = read_struct(&res.image, shoff + i * 64).unwrap();
            if h.sh_type == SHT_SYMTAB {
                let strh: Elf64Shdr =
                    read_struct(&res.image, shoff + h.sh_link as usize * 64).unwrap();
                let strtab =
                    &res.image[strh.sh_offset as usize..(strh.sh_offset + strh.sh_size) as usize];
                for k in 0..(h.sh_size / 24) as usize {
                    let at = h.sh_offset as usize + k * 24;
                    let noff = u32::from_le_bytes(res.image[at..at + 4].try_into().unwrap());
                    if strz(strtab, noff as usize) == "hid" {
                        hid_info = Some(res.image[at + 4]);
                    }
                }
            }
        }
        assert_eq!(hid_info.expect("hid emitted") >> 4, STB_LOCAL);
    }

    // ---------------------------------------------------- ELF32 / i386

    const I386_SCRIPT: &str = r#"
ENTRY(_start)
SECTIONS {
  . = 0x1000;
  .text : { *(.text) }
  .text32 : { *(.text32) }
  . = ALIGN(0x1000);
  .rodata : { *(.rodata) }
  .data : { *(.data) }
}
"#;

    /// `(name, sh_type, sh_addr, sh_offset, sh_size, sh_flags, sh_entsize)`
    /// of every ELF32 section but the null one, in table order.
    fn elf32_sections(image: &[u8]) -> Vec<(String, u32, u64, u64, u64, u64, u64)> {
        let shoff = u32::from_le_bytes(image[32..36].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(image[48..50].try_into().unwrap()) as usize;
        let shstrndx = u16::from_le_bytes(image[50..52].try_into().unwrap()) as usize;
        let sh = |i: usize| -> Elf64Shdr {
            read_struct::<Elf32Shdr>(image, shoff + i * 40)
                .unwrap()
                .into()
        };
        let str_sh = sh(shstrndx);
        let strtab =
            &image[str_sh.sh_offset as usize..(str_sh.sh_offset + str_sh.sh_size) as usize];
        (1..shnum)
            .map(|i| {
                let h = sh(i);
                (
                    strz(strtab, h.sh_name as usize),
                    h.sh_type,
                    h.sh_addr,
                    h.sh_offset,
                    h.sh_size,
                    h.sh_flags,
                    h.sh_entsize,
                )
            })
            .collect()
    }

    fn elf32_section(image: &[u8], name: &str) -> (String, u32, u64, u64, u64, u64, u64) {
        elf32_sections(image)
            .into_iter()
            .find(|s| s.0 == name)
            .unwrap_or_else(|| panic!("no `{name}' in the image"))
    }

    fn elf32_body<'a>(image: &'a [u8], name: &str) -> &'a [u8] {
        let s = elf32_section(image, name);
        &image[s.3 as usize..(s.3 + s.4) as usize]
    }

    /// One object exercising every `R_386_*` width the boot links use.
    /// Each relocation's addend is stored in the field it relocates,
    /// which is where an `SHT_REL` entry keeps it.
    fn i386_object() -> Vec<u8> {
        TestObj::new()
            // 0: .text -- PC32 at 1, PC16 at 8, PC8 at 12.
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 16],
            )
            // 1: .text32 -- an orphan anchor check needs a second code
            // section the script names.
            .sec(
                ".text32",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 4],
            )
            // 2: .data -- 32 at 0, 16 at 4, 8 at 6.
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0u8; 8])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 16)
            .sym("target", STB_GLOBAL, STT_NOTYPE, 1, 0, 0)
            // The 8- and 16-bit fields hold no image address, so they
            // reference absolute symbols the way the boot code does.
            .sym("small", STB_GLOBAL, STT_NOTYPE, usize::MAX - 1, 0x1234, 0)
            .sym("tiny", STB_GLOBAL, STT_NOTYPE, usize::MAX - 1, 0x40, 0)
            // Symtab: null(0), sections(1..=3), _start(4), target(5),
            // small(6), tiny(7).
            .reloc(0, 1, 5, rt::R_386_PC32, -4)
            .reloc(0, 8, 5, rt::R_386_PC16, -2)
            .reloc(0, 12, 4, rt::R_386_PC8, -1)
            .reloc(2, 0, 5, rt::R_386_32, 0x10)
            .reloc(2, 4, 6, rt::R_386_16, 0)
            .reloc(2, 6, 7, rt::R_386_8, 0)
            .build_class(EM_386, ElfClass::Elf32, false)
    }

    #[test]
    fn i386_rel_addends_come_from_the_relocated_field() {
        let script = parse_linker_script(I386_SCRIPT).expect("script parses");
        let objs = alloc::vec![parse_lds_object("a.o", i386_object()).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let text = elf32_section(&res.image, ".text");
        let t32 = elf32_section(&res.image, ".text32");
        let (text_addr, t32_addr) = (text.2, t32.2);
        let tb = elf32_body(&res.image, ".text");
        let db = elf32_body(&res.image, ".data");
        // S + A - P at each width, A read back out of the field.
        let pc32 = i32::from_le_bytes(tb[1..5].try_into().unwrap()) as i64;
        assert_eq!(pc32, t32_addr as i64 - 4 - (text_addr as i64 + 1));
        let pc16 = i16::from_le_bytes(tb[8..10].try_into().unwrap()) as i64;
        assert_eq!(pc16, t32_addr as i64 - 2 - (text_addr as i64 + 8));
        let pc8 = tb[12] as i8 as i64;
        assert_eq!(pc8, text_addr as i64 - 1 - (text_addr as i64 + 12));
        // S + A at each width.
        assert_eq!(
            u32::from_le_bytes(db[0..4].try_into().unwrap()) as u64,
            t32_addr + 0x10
        );
        assert_eq!(u16::from_le_bytes(db[4..6].try_into().unwrap()), 0x1234);
        assert_eq!(db[6], 0x40);
    }

    #[test]
    fn i386_image_is_elf32() {
        let script = parse_linker_script(I386_SCRIPT).expect("script parses");
        let objs = alloc::vec![parse_lds_object("a.o", i386_object()).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let img = &res.image;
        assert_eq!(img[4], 1, "EI_CLASS is ELFCLASS32");
        assert_eq!(u16::from_le_bytes(img[18..20].try_into().unwrap()), EM_386);
        assert_eq!(
            u32::from_le_bytes(img[28..32].try_into().unwrap()),
            52,
            "e_phoff follows the ELF32 header"
        );
        assert_eq!(u16::from_le_bytes(img[40..42].try_into().unwrap()), 52); // e_ehsize
        assert_eq!(u16::from_le_bytes(img[42..44].try_into().unwrap()), 32); // e_phentsize
        assert_eq!(u16::from_le_bytes(img[46..48].try_into().unwrap()), 40); // e_shentsize
        let symtab = elf32_section(img, ".symtab");
        assert_eq!(symtab.6, 16, "Elf32_Sym is 16 bytes");
        // `_start` is found through the ELF32 symbol layout.
        let (_, _, _, off, size, _, ent) = symtab;
        let strtab = elf32_section(img, ".strtab");
        let names = &img[strtab.3 as usize..(strtab.3 + strtab.4) as usize];
        let text_addr = elf32_section(img, ".text").2;
        let start = (0..size / ent).find_map(|k| {
            let at = (off + k * ent) as usize;
            let n = u32::from_le_bytes(img[at..at + 4].try_into().unwrap());
            (strz(names, n as usize) == "_start")
                .then(|| u32::from_le_bytes(img[at + 4..at + 8].try_into().unwrap()) as u64)
        });
        assert_eq!(start, Some(text_addr));
        // The entry point is `_start`, written at address width.
        assert_eq!(
            u32::from_le_bytes(img[24..28].try_into().unwrap()) as u64,
            text_addr
        );
    }

    #[test]
    fn i386_emit_relocs_writes_rel_tables() {
        let script = parse_linker_script(I386_SCRIPT).expect("script parses");
        let objs = alloc::vec![parse_lds_object("a.o", i386_object()).expect("parses")];
        let opts = LdsOptions {
            emit_relocs: true,
            ..Default::default()
        };
        let res = link_with_script(&script, objs, &opts).expect("links");
        let rel = elf32_section(&res.image, ".rel.data");
        assert_eq!(rel.1, SHT_REL);
        assert_eq!(rel.6, 8, "Elf32_Rel is 8 bytes");
        assert_eq!(rel.4, 3 * 8, "three relocations in .data");
        assert!(
            elf32_sections(&res.image)
                .iter()
                .all(|s| !s.0.starts_with(".rela")),
            "a REL target emits no RELA table"
        );
        // r_info keeps the type in the low byte on ELF32.
        let body = &res.image[rel.3 as usize..(rel.3 + rel.4) as usize];
        let info = u32::from_le_bytes(body[4..8].try_into().unwrap());
        assert_eq!(info & 0xff, rt::R_386_32);
    }

    #[test]
    fn i386_narrow_relocation_overflow_is_reported() {
        let script = parse_linker_script(I386_SCRIPT).expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 4],
            )
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 4)
            // Symtab: null(0), section(1), _start(2).
            .reloc(0, 0, 2, rt::R_386_8, 0)
            .build_class(EM_386, ElfClass::Elf32, false);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let e = link_with_script(&script, objs, &LdsOptions::default())
            .expect_err("0x1000 does not fit an 8-bit field");
        assert!(format!("{e}").contains("R_386_8"), "{e}");
    }

    /// AArch64 keeps the GOT header on `.got`: its first slot holds the
    /// `.dynamic` address and GOT entries follow it, while `.got.plt`
    /// stays the dynamic linker's.
    #[test]
    fn aarch64_got_keeps_its_header_and_entries_follow_it() {
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = 0x10000;
  .text : { *(.text) }
  .data : { *(.data) }
  .dynamic : { *(.dynamic) }
  .got : { *(.got) }
  .got.plt : { *(.got.plt) }
  .rela.dyn : { *(.rela .rela*) }
}
"#,
        )
        .expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0u8; 8],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
            // Symtab: null(0), sections(1..=2), _start(3), datum(4).
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
            .sym("datum", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
            .reloc(0, 0, 4, rt::R_AARCH64_ADR_GOT_PAGE, 0)
            .reloc(0, 4, 4, rt::R_AARCH64_LD64_GOT_LO12_NC, 0)
            .build(EM_AARCH64);
        let opts = LdsOptions {
            emit: LdsEmit::Dyn,
            max_page_size: 0x10000,
            ..Default::default()
        };
        let res = link_with_script(
            &script,
            alloc::vec![parse_lds_object("a.o", a).expect("parses")],
            &opts,
        )
        .expect("links");
        let secs = readelf_sections(&res.image);
        let sec = |name: &str| {
            secs.iter()
                .find(|s| s.0 == name)
                .unwrap_or_else(|| panic!("no `{name}' in the image"))
        };
        let (got_addr, got_size) = (sec(".got").2, sec(".got").3);
        assert_eq!(got_size, 16, "the reserved header plus one entry");
        let off = section_file_off(&res.image, got_addr);
        assert_eq!(
            u64::from_le_bytes(res.image[off..off + 8].try_into().unwrap()),
            sec(".dynamic").2,
            "`_GLOBAL_OFFSET_TABLE_[0]` holds the `.dynamic` address"
        );
        let rela = section_file_off(&res.image, sec(".rela.dyn").2);
        assert_eq!(
            u64::from_le_bytes(res.image[rela..rela + 8].try_into().unwrap()),
            got_addr + 8,
            "the GOT entry sits past the header"
        );
        let plt = section_file_off(&res.image, sec(".got.plt").2);
        assert!(
            res.image[plt..plt + sec(".got.plt").3 as usize]
                .iter()
                .all(|&b| b == 0),
            "`.got.plt` carries no header here"
        );
    }

    /// The x86 psABIs define `_GLOBAL_OFFSET_TABLE_` on `.got.plt`,
    /// whose first slot holds the `.dynamic` address, and every
    /// GOT-base relative relocation is computed against that same
    /// address.
    #[test]
    fn i386_got_base_is_got_plt_holding_the_dynamic_address() {
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = SIZEOF_HEADERS;
  .dynsym : { *(.dynsym) }
  .dynstr : { *(.dynstr) }
  .gnu.hash : { *(.gnu.hash) }
  .dynamic : { *(.dynamic) }
  .text : { *(.text) }
  .got : { *(.got) }
  .got.plt : { *(.got.plt) }
  .data : { *(.data) }
}
"#,
        )
        .expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 16],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0u8; 4])
            // Symtab: null(0), .text(1), .data(2), then these two.
            .sym(
                "_GLOBAL_OFFSET_TABLE_",
                STB_GLOBAL,
                STT_NOTYPE,
                usize::MAX,
                0,
                0,
            )
            .sym("datum", STB_GLOBAL, STT_OBJECT, 1, 0, 4)
            .reloc(0, 0, 3, rt::R_386_GOTPC, 0)
            .reloc(0, 4, 4, rt::R_386_GOTOFF, 0)
            .build_class(EM_386, ElfClass::Elf32, false);
        let opts = LdsOptions {
            emit: LdsEmit::Dyn,
            ..Default::default()
        };
        let res = link_with_script(
            &script,
            alloc::vec![parse_lds_object("a.o", a).expect("parses")],
            &opts,
        )
        .expect("links");
        let addr = |name: &str| elf32_section(&res.image, name).2 as i64;
        let text = elf32_body(&res.image, ".text");
        let field = |at: usize| i32::from_le_bytes(text[at..at + 4].try_into().unwrap()) as i64;
        assert_eq!(
            field(0) + addr(".text"),
            addr(".got.plt"),
            "R_386_GOTPC yields the `.got.plt` address"
        );
        assert_eq!(
            field(4),
            addr(".data") - addr(".got.plt"),
            "R_386_GOTOFF is relative to the same base"
        );
        let got_plt = elf32_body(&res.image, ".got.plt");
        assert_eq!(
            u32::from_le_bytes(got_plt[..4].try_into().unwrap()) as i64,
            addr(".dynamic"),
            "`_GLOBAL_OFFSET_TABLE_[0]` holds the `.dynamic` address"
        );
        assert!(
            !elf32_sections(&res.image)
                .iter()
                .any(|s| s.0 == ".got" && s.4 != 0),
            "`.got` reserves no header where `.got.plt` carries it"
        );
    }

    #[test]
    fn i386_shared_object_carries_elf32_dynamic_metadata() {
        let script = parse_linker_script(
            r#"
SECTIONS {
  . = SIZEOF_HEADERS;
  .hash : { *(.hash) }
  .gnu.hash : { *(.gnu.hash) }
  .dynsym : { *(.dynsym) }
  .dynstr : { *(.dynstr) }
  .gnu.version : { *(.gnu.version) }
  .gnu.version_d : { *(.gnu.version_d) }
  .dynamic : { *(.dynamic) }
  .rodata : { *(.rodata) *(.got.plt) *(.got) }
  .text : { *(.text) }
}
VERSION { LINUX_2.6 { global: exported; local: *; }; }
"#,
        )
        .expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 16],
            )
            .sym("exported", STB_GLOBAL, STT_FUNC, 0, 0, 16)
            .build_class(EM_386, ElfClass::Elf32, false);
        let opts = LdsOptions {
            emit: LdsEmit::Dyn,
            soname: Some("linux-gate.so.1".to_string()),
            hash_style: HashStyle::Both,
            ..Default::default()
        };
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let res = link_with_script(&script, objs, &opts).expect("links");
        assert_eq!(elf32_section(&res.image, ".dynsym").6, 16);
        assert_eq!(elf32_section(&res.image, ".dynamic").6, 8);
        // bfd gives `.gnu.hash` an entsize on ELF32 only.
        assert_eq!(elf32_section(&res.image, ".gnu.hash").6, 4);
        // `.gnu.hash` Bloom words are address-width, so ELF32 needs
        // twice as many for the same mask and always shifts by 5.
        let gh = elf32_body(&res.image, ".gnu.hash");
        let word = |at: usize| u32::from_le_bytes(gh[at..at + 4].try_into().unwrap()) as usize;
        let (nbuckets, maskwords, shift2) = (word(0), word(8), word(12) as u32);
        let nhashed = elf32_section(&res.image, ".dynsym").4 as usize / 16 - 1;
        assert_eq!(
            (maskwords, shift2),
            dynamic::bloom_params(nhashed, ElfClass::Elf32)
        );
        assert_eq!(
            gh.len(),
            16 + maskwords * 4 + nbuckets * 4 + nhashed * 4,
            "the Bloom words are 4 bytes wide"
        );
        // DT_SYMENT names the ELF32 entry size; every tag is 8 bytes.
        let dynamic = elf32_body(&res.image, ".dynamic");
        assert!(dynamic.len().is_multiple_of(8));
        let mut syment = None;
        for e in dynamic.chunks_exact(8) {
            let (t, v) = (
                u32::from_le_bytes(e[0..4].try_into().unwrap()) as u64,
                u32::from_le_bytes(e[4..8].try_into().unwrap()) as u64,
            );
            if t == dynamic::DT_SYMENT {
                syment = Some(v);
            }
        }
        assert_eq!(syment, Some(16));
    }

    #[test]
    fn code_padding_is_the_architecture_nop() {
        // `.text` claims two inputs; the second's alignment leaves a
        // gap the script gave no fill for.
        let script =
            parse_linker_script("SECTIONS { . = 0x1000; .text : { *(.text) *(.text.hot) } }")
                .expect("script parses");
        let build = |machine: u16, class: ElfClass, first: usize| {
            TestObj::new()
                .sec(
                    ".text",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    16,
                    &alloc::vec![0xccu8; first],
                )
                .sec(
                    ".text.hot",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    16,
                    &[0xccu8; 4],
                )
                .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, first as u64)
                .build_class(machine, class, machine != EM_386)
        };
        let objs =
            alloc::vec![parse_lds_object("a.o", build(EM_386, ElfClass::Elf32, 5)).expect("p")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        // 11 bytes of padding: five `66 90` pairs and a trailing `90`.
        let body = elf32_body(&res.image, ".text");
        assert_eq!(
            &body[5..16],
            &[
                0x66, 0x90, 0x66, 0x90, 0x66, 0x90, 0x66, 0x90, 0x66, 0x90, 0x90
            ]
        );
        // aarch64 pads only whole instructions, so the gap is a
        // multiple of four here.
        let objs =
            alloc::vec![parse_lds_object("a.o", build(EM_AARCH64, ElfClass::Elf64, 8)).expect("p")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let shoff = u64::from_le_bytes(res.image[40..48].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(res.image[60..62].try_into().unwrap()) as usize;
        let shstrndx = u16::from_le_bytes(res.image[62..64].try_into().unwrap()) as usize;
        let sh = |i: usize| -> Elf64Shdr { read_struct(&res.image, shoff + i * 64).unwrap() };
        let str_sh = sh(shstrndx);
        let names =
            &res.image[str_sh.sh_offset as usize..(str_sh.sh_offset + str_sh.sh_size) as usize];
        let text = (1..shnum)
            .map(sh)
            .find(|h| strz(names, h.sh_name as usize) == ".text")
            .expect("has .text");
        let body = &res.image[text.sh_offset as usize..(text.sh_offset + text.sh_size) as usize];
        assert_eq!(
            &body[8..16],
            &[0x1f, 0x20, 0x03, 0xd5, 0x1f, 0x20, 0x03, 0xd5]
        );
    }

    #[test]
    fn orphan_anchors_on_the_canonically_named_section() {
        // bfd puts a code orphan after the output section named
        // `.text`, not after the last executable one.
        let script = parse_linker_script(I386_SCRIPT).expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 16],
            )
            .sec(
                ".text32",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 16],
            )
            .sec(
                ".inittext",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                1,
                &[0u8; 4],
            )
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 16)
            .build_class(EM_386, ElfClass::Elf32, false);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
        let order: Vec<String> = elf32_sections(&res.image)
            .into_iter()
            .filter(|s| s.5 & SHF_EXECINSTR != 0)
            .map(|s| s.0)
            .collect();
        assert_eq!(
            order,
            alloc::vec![
                ".text".to_string(),
                ".inittext".to_string(),
                ".text32".to_string()
            ]
        );
    }

    #[test]
    fn elf32_object_in_an_x86_64_link_is_rejected() {
        let script = parse_linker_script(I386_SCRIPT).expect("script parses");
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 4],
            )
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 4)
            .build_class(EM_X86_64, ElfClass::Elf32, true);
        let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
        let e = link_with_script(&script, objs, &LdsOptions::default())
            .expect_err("an ELF32 x86-64 object has no emulation here");
        assert!(format!("{e}").contains("ELF class"), "{e}");
    }

    // ------------------------------------------- COMDAT / linkonce

    const GROUP_SCRIPT: &str = r#"
SECTIONS {
  . = 0x1000;
  .text : { *(.text .text.*) *(.gnu.linkonce.t.*) }
  .rodata : { *(.rodata .rodata.*) }
  .data : { *(.data .data.*) }
  .eh_frame : { *(.eh_frame) }
}
"#;

    fn link_group(objs: Vec<Vec<u8>>, opts: &LdsOptions) -> Result<LdsResult, C5Error> {
        let script = parse_linker_script(GROUP_SCRIPT).expect("script parses");
        let inputs: Vec<LdsObject> = objs
            .into_iter()
            .enumerate()
            .map(|(i, b)| {
                parse_lds_object(&format!("{}.o", (b'a' + i as u8) as char), b).expect("parses")
            })
            .collect();
        link_with_script(&script, inputs, opts)
    }

    fn body_has(image: &[u8], section: &str, pat: &[u8]) -> bool {
        image_section(image, section)
            .1
            .windows(pat.len())
            .any(|w| w == pat)
    }

    /// A COMDAT group is keyed on its signature symbol's name alone.
    /// The later group loses every member whatever the members are
    /// named and however large they are, and nothing is diagnosed.
    #[test]
    fn a_comdat_group_is_kept_once_per_signature() {
        let a = TestObj::new()
            .sec(
                ".text.aaa",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0xa1; 4],
            )
            .sec(".rodata.aaa", SHT_PROGBITS, SHF_ALLOC, 4, &[0xa2; 4])
            .sym("sig", STB_WEAK, STT_FUNC, 0, 0, 4)
            .sym("aonly", STB_GLOBAL, STT_OBJECT, 1, 0, 4)
            .group(comdat::GRP_COMDAT, 0, &[0, 1])
            .build(EM_X86_64);
        let b = TestObj::new()
            .sec(
                ".text.bbb",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0xb1; 8],
            )
            .sec(".rodata.bbb", SHT_PROGBITS, SHF_ALLOC, 4, &[0xb2; 8])
            .sec(
                ".data.bbb",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_WRITE,
                4,
                &[0xb5; 4],
            )
            .sym("sig", STB_WEAK, STT_FUNC, 0, 0, 8)
            .sym("bonly", STB_GLOBAL, STT_OBJECT, 2, 0, 4)
            .group(comdat::GRP_COMDAT, 0, &[0, 1, 2])
            .build(EM_X86_64);
        let res = link_group(alloc::vec![a, b], &LdsOptions::default()).expect("links");
        assert!(
            body_has(&res.image, ".text", &[0xa1; 4]),
            "the first copy stays"
        );
        assert!(
            !body_has(&res.image, ".text", &[0xb1; 8]),
            "the later copy is gone"
        );
        assert!(
            !body_has(&res.image, ".rodata", &[0xb2; 8]),
            "and so is every member"
        );
        let secs = readelf_sections(&res.image);
        assert!(
            !secs.iter().any(|s| s.0 == ".data"),
            "a member the kept group has no counterpart for is dropped too"
        );
        let names: Vec<String> = image_symbols(&res.image)
            .into_iter()
            .map(|(n, _, _)| n)
            .collect();
        assert!(names.iter().any(|n| n == "aonly"), "{names:?}");
        assert!(
            !names.iter().any(|n| n == "bonly"),
            "a dropped member defines nothing"
        );
    }

    /// The dedup runs on `GRP_COMDAT`, not on the presence of a group:
    /// a plain group keeps both copies, and duplicate definitions in
    /// them collide as they would outside any group.
    #[test]
    fn a_group_without_grp_comdat_is_not_deduplicated() {
        let unit = |flags: u32, fill: u8| {
            TestObj::new()
                .sec(
                    ".text.g",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    4,
                    &[fill; 4],
                )
                .sym("gsig", STB_LOCAL, STT_NOTYPE, 0, 0, 0)
                .sym("dup", STB_GLOBAL, STT_FUNC, 0, 0, 4)
                .group(flags, 0, &[0])
                .build(EM_X86_64)
        };
        let e = link_group(
            alloc::vec![unit(0, 0xa1), unit(0, 0xb1)],
            &LdsOptions::default(),
        )
        .expect_err("a plain group deduplicates nothing");
        assert!(
            format!("{e}").contains("multiple definition of `dup`"),
            "{e}"
        );
        let res = link_group(
            alloc::vec![
                unit(comdat::GRP_COMDAT, 0xa1),
                unit(comdat::GRP_COMDAT, 0xb1)
            ],
            &LdsOptions::default(),
        )
        .expect("the same objects with GRP_COMDAT set link");
        assert!(!body_has(&res.image, ".text", &[0xb1; 4]));
    }

    /// A reference by name reaches the surviving definition; a local or
    /// section-relative reference into a dropped member has nowhere to
    /// go and is reported, because the surviving group's contents need
    /// bear no relation to the dropped one's.
    #[test]
    fn a_reference_into_a_dropped_group_resolves_by_name_or_is_reported() {
        let a = TestObj::new()
            .sec(
                ".text.f",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0xa1; 8],
            )
            .sym("f", STB_WEAK, STT_FUNC, 0, 0, 8)
            .group(comdat::GRP_COMDAT, 0, &[0])
            .build(EM_X86_64);
        // Symtab: null, section symbols 1..=3, then f(4), bloc(5).
        let b = |sym: u32, refsec: &str, flags: u64| {
            TestObj::new()
                .sec(
                    ".text.f",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    4,
                    &[0xb1; 8],
                )
                .sec(refsec, SHT_PROGBITS, flags, 8, &[0u8; 8])
                .sym("f", STB_WEAK, STT_FUNC, 0, 0, 8)
                .sym("bloc", STB_LOCAL, STT_NOTYPE, 0, 4, 0)
                .group(comdat::GRP_COMDAT, 0, &[0])
                .reloc(1, 0, sym, rt::R_X86_64_64, 0)
                .build(EM_X86_64)
        };
        let res = link_group(
            alloc::vec![a.clone(), b(4, ".data.b", SHF_ALLOC | SHF_WRITE)],
            &LdsOptions::default(),
        )
        .expect("a named reference binds to the kept copy");
        let f = find_sym(&image_symbols(&res.image), "f");
        assert_eq!(
            u64::from_le_bytes(
                image_section(&res.image, ".data").1[..8]
                    .try_into()
                    .unwrap()
            ),
            f,
        );
        for sym in [5u32, 1u32] {
            let e = link_group(
                alloc::vec![a.clone(), b(sym, ".data.b", SHF_ALLOC | SHF_WRITE)],
                &LdsOptions::default(),
            )
            .expect_err("a local or section reference into a dropped member");
            assert!(
                format!("{e}").contains("discarded section `.text.f'"),
                "{e}"
            );
        }
        // A section describing the image rather than taking part in it
        // resolves the same reference to nothing instead.
        let res = link_group(
            alloc::vec![a, b(5, ".debug_info", 0)],
            &LdsOptions::default(),
        )
        .expect("a debug reference is tolerated");
        assert_eq!(
            image_section(&res.image, ".debug_info").1,
            alloc::vec![0u8; 8]
        );
    }

    /// `.gnu.linkonce.*` is the older form of the same rule, keyed on
    /// the section's own name. The key spaces do not meet: a linkonce
    /// section and a COMDAT group both defining one symbol collide.
    #[test]
    fn gnu_linkonce_sections_deduplicate_by_section_name() {
        let linkonce = |fill: u8, only: &str| {
            TestObj::new()
                .sec(
                    ".gnu.linkonce.t.foo",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    4,
                    &[fill; 4],
                )
                .sym("foo", STB_GLOBAL, STT_FUNC, 0, 0, 4)
                .sym(only, STB_GLOBAL, STT_FUNC, 0, 2, 0)
                .build(EM_X86_64)
        };
        let res = link_group(
            alloc::vec![linkonce(0xa1, "aonly_lo"), linkonce(0xb1, "bonly_lo")],
            &LdsOptions::default(),
        )
        .expect("links");
        assert!(body_has(&res.image, ".text", &[0xa1; 4]));
        assert!(!body_has(&res.image, ".text", &[0xb1; 4]));
        let names: Vec<String> = image_symbols(&res.image)
            .into_iter()
            .map(|(n, _, _)| n)
            .collect();
        assert!(names.iter().any(|n| n == "aonly_lo") && !names.iter().any(|n| n == "bonly_lo"));
        let grouped = TestObj::new()
            .sec(
                ".text.foo",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0xc1; 4],
            )
            .sym("foo", STB_GLOBAL, STT_FUNC, 0, 0, 4)
            .group(comdat::GRP_COMDAT, 0, &[0])
            .build(EM_X86_64);
        let e = link_group(
            alloc::vec![linkonce(0xa1, "aonly_lo"), grouped],
            &LdsOptions::default(),
        )
        .expect_err("the two mechanisms do not deduplicate against each other");
        assert!(
            format!("{e}").contains("multiple definition of `foo`"),
            "{e}"
        );
    }

    /// Group dedup runs before garbage collection, so a dropped member
    /// is neither a root nor a path to one.
    #[test]
    fn a_dropped_group_member_is_no_garbage_collection_root() {
        let root = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0u8; 8],
            )
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
            .sym("f", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
            .reloc(0, 0, 3, rt::R_X86_64_64, 0)
            .build(EM_X86_64);
        // `.text.only` exists only in the object whose group member
        // names it, so the two members define no symbol in common.
        // Symtab there: null, sections 1..=3, f(4), only(5).
        let member = |fill: u8, refs_only: bool| {
            let mut o = TestObj::new().sec(
                ".text.f",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[fill; 8],
            );
            if refs_only {
                o = o.sec(
                    ".text.only",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    8,
                    &[0xbb; 8],
                );
            }
            o = o.sym("f", STB_WEAK, STT_FUNC, 0, 0, 8);
            if refs_only {
                o = o.sym("only", STB_GLOBAL, STT_FUNC, 1, 0, 8);
            }
            o = o.group(comdat::GRP_COMDAT, 0, &[0]);
            if refs_only {
                o = o.reloc(0, 0, 5, rt::R_X86_64_64, 0);
            }
            o.build(EM_X86_64)
        };
        let opts = |gc: bool| LdsOptions {
            gc_sections: gc,
            entry_override: Some("_start".to_string()),
            ..Default::default()
        };
        let objs = || alloc::vec![root.clone(), member(0xa1, false), member(0xb1, true)];
        let kept = link_group(objs(), &opts(false)).expect("links");
        assert!(
            body_has(&kept.image, ".text", &[0xbb; 8]),
            "nothing collects it"
        );
        let collected = link_group(objs(), &opts(true)).expect("links");
        assert!(
            !body_has(&collected.image, ".text", &[0xbb; 8]),
            "the only reference lived in a dropped member"
        );
        let live = link_group(alloc::vec![root, member(0xa1, true)], &opts(true)).expect("links");
        assert!(
            body_has(&live.image, ".text", &[0xbb; 8]),
            "the same reference from the winning group keeps it"
        );
    }

    /// An FDE describing code that left the link describes nothing, so
    /// the entry goes with it rather than being relocated.
    #[test]
    fn an_fde_for_a_dropped_group_member_is_dropped() {
        let unit = |fill: u8| {
            let mut eh = eh_cie_zr();
            eh.extend_from_slice(&eh_fde(0x1c));
            TestObj::new()
                .sec(
                    ".text.f",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    8,
                    &[fill; 8],
                )
                .sec(".eh_frame", SHT_PROGBITS, SHF_ALLOC, 8, &eh)
                .sym("f", STB_WEAK, STT_FUNC, 0, 0, 8)
                .group(comdat::GRP_COMDAT, 0, &[0])
                .reloc(1, 0x20, 1, rt::R_X86_64_PC32, 0)
                .build(EM_X86_64)
        };
        let res =
            link_group(alloc::vec![unit(0xa1), unit(0xb1)], &LdsOptions::default()).expect("links");
        let (addr, body) = image_section(&res.image, ".eh_frame");
        assert_eq!(body.len(), 24 + 24, "one CIE and the surviving copy's FDE");
        let fdes = eh_frame::scan(&body, addr).expect("scans");
        assert_eq!(
            fdes.iter().map(|e| e.pc).collect::<Vec<_>>(),
            alloc::vec![find_sym(&image_symbols(&res.image), "f")],
        );
    }

    /// The i386 shape the gcc PIC thunk arrives in: an ELF32 `SHT_REL`
    /// object whose group holds one section signed by the thunk.
    #[test]
    fn an_elf32_group_parses_and_deduplicates() {
        let thunk = "__x86.get_pc_thunk.ax";
        let unit = |fill: u8| {
            TestObj::new()
                .sec(
                    ".text",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    4,
                    &[fill; 4],
                )
                .sec(
                    ".text.__x86.get_pc_thunk.ax",
                    SHT_PROGBITS,
                    SHF_ALLOC | SHF_EXECINSTR,
                    1,
                    &[0x8b, 0x04, 0x24, 0xc3],
                )
                .sym(thunk, STB_GLOBAL, STT_FUNC, 1, 0, 4)
                .vis(2)
                .group(comdat::GRP_COMDAT, 0, &[1])
                .build_class(EM_386, ElfClass::Elf32, false)
        };
        let parsed = parse_lds_object("a.o", unit(0xa1)).expect("parses");
        assert_eq!(parsed.groups.len(), 1);
        assert_eq!(parsed.groups[0].flags, comdat::GRP_COMDAT);
        assert_eq!(parsed.groups[0].signature, thunk);
        assert_eq!(
            parsed.sections[parsed.groups[0].members[0]].name,
            ".text.__x86.get_pc_thunk.ax"
        );
        let opts = LdsOptions {
            entry_override: Some(thunk.to_string()),
            ..Default::default()
        };
        let res = link_group(alloc::vec![unit(0xa1), unit(0xb1)], &opts).expect("links");
        let text = elf32_body(&res.image, ".text");
        assert_eq!(
            text.windows(4)
                .filter(|w| *w == [0x8b, 0x04, 0x24, 0xc3])
                .count(),
            1,
            "one thunk body: {text:02x?}"
        );
    }
}

//! ET_REL inputs read at full fidelity: every section with its bytes,
//! flags and relocations.

use crate::c5::diag::Code;
use crate::c5::error::C5Error;
use crate::c5::linker::link_err;
use crate::c5::linker::object::{
    Elf32Ehdr, Elf32Rel, Elf32Rela, Elf32Shdr, Elf32Sym, Elf64Ehdr, Elf64Rel, Elf64Shdr, ElfClass,
    elf_reloc_desc, elf_reloc_field_width, implicit_addend, read_struct,
};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::HashMap;

use super::{
    Elf64Rela, Elf64Sym, MODULE, R_NONE, SHF_EXCLUDE, SHN_XINDEX, SHT_GROUP, SHT_LLVM_ADDRSIG,
    SHT_NOBITS, SHT_REL, SHT_RELA, SHT_STRTAB, SHT_SYMTAB, SHT_SYMTAB_SHNDX,
};

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
    pub(super) fn binding(&self) -> u8 {
        self.info >> 4
    }
    pub(super) fn kind(&self) -> u8 {
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
    pub(super) fn section_data(&self, s: &RawSection) -> &[u8] {
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
        return Err(link_err(
            Code::MALFORMED_INPUT,
            MODULE,
            &format!("{source}: not an ELF object"),
        ));
    }
    let Some(class) = ElfClass::from_ei_class(bytes[4]).filter(|_| bytes[5] == 1) else {
        return Err(link_err(
            Code::MALFORMED_INPUT,
            MODULE,
            &format!("{source}: not a little-endian ELF object"),
        ));
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
        return Err(link_err(
            Code::MALFORMED_INPUT,
            MODULE,
            &format!(
                "{source}: not a relocatable object (e_type {})",
                ehdr.e_type
            ),
        ));
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
                .as_chunks::<4>()
                .0
                .iter()
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
        // SHF_EXCLUDE keeps a section out of a final link whatever its
        // other flags say, and a script naming the section does not
        // bring it back. Relocatable output reads inputs through
        // `parse_et_rel`, which keeps them.
        if sh.sh_flags & SHF_EXCLUDE != 0 {
            continue;
        }
        let data_off = if sh.sh_type == SHT_NOBITS {
            0
        } else {
            let end = (sh.sh_offset as usize).checked_add(sh.sh_size as usize);
            match end {
                Some(e) if e <= bytes.len() => sh.sh_offset as usize,
                _ => {
                    return Err(link_err(
                        Code::MALFORMED_INPUT,
                        MODULE,
                        &format!(
                            "{source}: section {} extends past end of file",
                            sec_name(sh)
                        ),
                    ));
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
                rel_addend(
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
            return Err(link_err(
                Code::MALFORMED_INPUT,
                MODULE,
                &format!("{source}: malformed SHT_GROUP body"),
            ));
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

/// Locate and decode the field an `SHT_REL` entry keeps its addend
/// in. A type that touches no field (`R_*_NONE`) has none.
fn rel_addend(
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
    let Some(width) = elf_reloc_field_width(machine, rtype) else {
        return Err(link_err(
            Code::RELOCATION,
            MODULE,
            &format!(
                "{source}: {} in `{}' has no implicit-addend field",
                elf_reloc_desc(machine, rtype),
                sec.name
            ),
        ));
    };
    let end = offset + width as u64;
    if sec.shtype == SHT_NOBITS || end > sec.size {
        return Err(link_err(
            Code::RELOCATION,
            MODULE,
            &format!(
                "{source}: relocation offset 0x{offset:x} outside `{}'",
                sec.name
            ),
        ));
    }
    let at = sec.data_off + offset as usize;
    Ok(implicit_addend(&bytes[at..at + width as usize]))
}

fn section_bytes<'a>(
    bytes: &'a [u8],
    sh: Option<&Elf64Shdr>,
    source: &str,
) -> Result<&'a [u8], C5Error> {
    let sh = sh.ok_or_else(|| {
        link_err(
            Code::MALFORMED_INPUT,
            MODULE,
            &format!("{source}: missing section header"),
        )
    })?;
    if sh.sh_type == SHT_NOBITS {
        return Ok(&[]);
    }
    let start = sh.sh_offset as usize;
    let end = start
        .checked_add(sh.sh_size as usize)
        .filter(|&e| e <= bytes.len())
        .ok_or_else(|| {
            link_err(
                Code::MALFORMED_INPUT,
                MODULE,
                &format!("{source}: section extends past end of file"),
            )
        })?;
    Ok(&bytes[start..end])
}

pub(super) fn strz(tab: &[u8], off: usize) -> String {
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

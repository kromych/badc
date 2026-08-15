//! Mach-O `MH_OBJECT` reader, producing the same [`NativeObject`] the
//! ELF reader does so a Mach-O relocatable joins a link on the same
//! terms.
//!
//! Sections classify into the merged families by `segname,sectname`
//! and section type, reproducing the ELF reader's rule that a
//! relocated read-only section joins the relro stream. Relocations
//! translate to AAELF64: Mach-O keeps the addend out of the
//! instruction field and supplies it through a preceding
//! `ARM64_RELOC_ADDEND`, and spells a label difference as an
//! `ARM64_RELOC_SUBTRACTOR` / `ARM64_RELOC_UNSIGNED` pair, so both
//! fold into the single addend AAELF64 carries. C names arrive with
//! the Mach-O leading underscore, which the writer re-applies, so the
//! reader strips one.

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use crate::c5::error::C5Error;
use crate::c5::object::elf_reloc_types::{
    R_AARCH64_ABS32, R_AARCH64_ABS64, R_AARCH64_ADD_ABS_LO12_NC, R_AARCH64_ADR_GOT_PAGE,
    R_AARCH64_ADR_PREL_PG_HI21, R_AARCH64_CALL26, R_AARCH64_LD64_GOT_LO12_NC,
    R_AARCH64_LDST8_ABS_LO12_NC, R_AARCH64_LDST16_ABS_LO12_NC, R_AARCH64_LDST32_ABS_LO12_NC,
    R_AARCH64_LDST64_ABS_LO12_NC, R_AARCH64_LDST128_ABS_LO12_NC, R_AARCH64_PREL32,
    R_AARCH64_PREL64,
};

use super::object::{
    InputSection, NativeInitFunc, NativeMachine, NativeObject, NativeReloc, NativeSymSection,
    NativeSymbol, STT_FUNC, STT_NOTYPE, STT_OBJECT, SectionFamily,
};

const MH_MAGIC_64: u32 = 0xFEED_FACF;
const MH_OBJECT: u32 = 0x1;
const MACH_HEADER_64_SIZE: usize = 32;
const CPU_TYPE_ARM64: u32 = 0x0100_000C;
const CPU_TYPE_X86_64: u32 = 0x0100_0007;

const LC_SEGMENT_64: u32 = 0x19;
const LC_SYMTAB: u32 = 0x2;
const SECTION_64_SIZE: usize = 80;
const NLIST_64_SIZE: usize = 16;
const RELOCATION_INFO_SIZE: usize = 8;

const S_ZEROFILL: u32 = 0x1;
const S_MOD_INIT_FUNC_POINTERS: u32 = 0x9;
const S_MOD_TERM_FUNC_POINTERS: u32 = 0xA;
const S_GB_ZEROFILL: u32 = 0xC;
/// `S_THREAD_LOCAL_*` occupy 0x11..=0x15.
const S_THREAD_LOCAL_FIRST: u32 = 0x11;
const S_THREAD_LOCAL_LAST: u32 = 0x15;
const S_ATTR_PURE_INSTRUCTIONS: u32 = 0x8000_0000;
const S_ATTR_DEBUG: u32 = 0x0200_0000;

const N_STAB: u8 = 0xE0;
const N_PEXT: u8 = 0x10;
const N_TYPE: u8 = 0x0E;
const N_EXT: u8 = 0x01;
const N_UNDF: u8 = 0x0;
const N_ABS: u8 = 0x2;
const N_INDR: u8 = 0xA;
const N_PBUD: u8 = 0xC;
const N_SECT: u8 = 0xE;
const N_WEAK_REF: u16 = 0x0040;
const N_WEAK_DEF: u16 = 0x0080;

const ARM64_RELOC_UNSIGNED: u8 = 0;
const ARM64_RELOC_SUBTRACTOR: u8 = 1;
const ARM64_RELOC_BRANCH26: u8 = 2;
const ARM64_RELOC_PAGE21: u8 = 3;
const ARM64_RELOC_PAGEOFF12: u8 = 4;
const ARM64_RELOC_GOT_LOAD_PAGE21: u8 = 5;
const ARM64_RELOC_GOT_LOAD_PAGEOFF12: u8 = 6;
const ARM64_RELOC_ADDEND: u8 = 10;

const R_SCATTERED: u32 = 0x8000_0000;

const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STB_WEAK: u8 = 2;
const STV_DEFAULT: u8 = 0;
const STV_HIDDEN: u8 = 2;

/// True when `bytes` is a 64-bit little-endian Mach-O relocatable.
/// A Mach-O image (`MH_EXECUTE` / `MH_DYLIB`) and a fat archive both
/// fail here: neither is a link input this reader accepts.
pub fn is_mach_o_object(bytes: &[u8]) -> bool {
    bytes.len() >= MACH_HEADER_64_SIZE
        && u32le(bytes, 0) == Some(MH_MAGIC_64)
        && u32le(bytes, 12) == Some(MH_OBJECT)
}

fn u32le(bytes: &[u8], off: usize) -> Option<u32> {
    let b = bytes.get(off..off + 4)?;
    Some(u32::from_le_bytes([b[0], b[1], b[2], b[3]]))
}

fn u64le(bytes: &[u8], off: usize) -> Option<u64> {
    let b = bytes.get(off..off + 8)?;
    Some(u64::from_le_bytes([
        b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7],
    ]))
}

fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
        "linker::mach_o_object: {msg}",
    )))
}

fn need_u32(bytes: &[u8], off: usize, what: &str) -> Result<u32, C5Error> {
    u32le(bytes, off).ok_or_else(|| err(&format!("{what} runs past end of file")))
}

fn need_u64(bytes: &[u8], off: usize, what: &str) -> Result<u64, C5Error> {
    u64le(bytes, off).ok_or_else(|| err(&format!("{what} runs past end of file")))
}

/// A 16-byte `segname` / `sectname` field, NUL-padded and not
/// NUL-terminated when it fills the field.
fn fixed_name(bytes: &[u8], off: usize) -> Result<String, C5Error> {
    let raw = bytes
        .get(off..off + 16)
        .ok_or_else(|| err("section name field runs past end of file"))?;
    let end = raw.iter().position(|&b| b == 0).unwrap_or(raw.len());
    core::str::from_utf8(&raw[..end])
        .map(|s| s.to_string())
        .map_err(|_| err("section name is not UTF-8"))
}

fn cstr(strtab: &[u8], off: usize) -> Result<&str, C5Error> {
    let rest = strtab
        .get(off..)
        .ok_or_else(|| err("string offset past end of string table"))?;
    let end = rest.iter().position(|&b| b == 0).unwrap_or(rest.len());
    core::str::from_utf8(&rest[..end]).map_err(|_| err("symbol name is not UTF-8"))
}

/// One `section_64`, plus the family and merged-blob base the parse
/// assigns it.
struct Sect {
    seg: String,
    name: String,
    addr: u64,
    size: u64,
    offset: u32,
    align: u32,
    reloff: u32,
    nreloc: u32,
    flags: u32,
    family: SectionFamily,
    base: u64,
}

impl Sect {
    fn kind(&self) -> u32 {
        self.flags & 0xFF
    }

    fn label(&self) -> String {
        format!("{},{}", self.seg, self.name)
    }

    fn content<'a>(&self, bytes: &'a [u8]) -> Result<&'a [u8], C5Error> {
        if self.kind() == S_ZEROFILL || self.kind() == S_GB_ZEROFILL {
            return Ok(&[]);
        }
        let off = self.offset as usize;
        let size = self.size as usize;
        if off.checked_add(size).is_none_or(|end| end > bytes.len()) {
            return Err(err(&format!(
                "section `{}` content runs past end of file (offset {off:#x} + size {size:#x} > len {})",
                self.label(),
                bytes.len(),
            )));
        }
        Ok(&bytes[off..off + size])
    }
}

/// Which merged stream a Mach-O section joins. `has_relocs` demotes a
/// read-only section to relro exactly as the ELF reader does: a slot a
/// relocation patches cannot sit in the stream mapped `PF_R` from the
/// file.
fn classify(sect: &Sect, has_relocs: bool) -> Result<SectionFamily, C5Error> {
    let kind = sect.kind();
    // `S_ATTR_DEBUG` covers `__LD,__compact_unwind` and the `__DWARF`
    // sections; none carries merged-image payload. `__eh_frame` joins
    // them because the Mach-O image writer emits no unwind section for
    // a reader to feed.
    if sect.flags & S_ATTR_DEBUG != 0
        || sect.seg == "__DWARF"
        || sect.seg == "__LD"
        || sect.name == "__eh_frame"
    {
        return Ok(SectionFamily::Discard);
    }
    if (S_THREAD_LOCAL_FIRST..=S_THREAD_LOCAL_LAST).contains(&kind) {
        return Err(err(&format!(
            "section `{}` holds thread-local storage (section type {kind:#x}); \
             the Mach-O reader does not model TLS",
            sect.label(),
        )));
    }
    match kind {
        S_ZEROFILL | S_GB_ZEROFILL => return Ok(SectionFamily::Bss),
        // Consumed as init / fini entries, not as merged bytes.
        S_MOD_INIT_FUNC_POINTERS | S_MOD_TERM_FUNC_POINTERS => return Ok(SectionFamily::Discard),
        _ => {}
    }
    let family = if sect.flags & S_ATTR_PURE_INSTRUCTIONS != 0 {
        SectionFamily::Text
    } else if sect.seg == "__TEXT" || sect.seg == "__DATA_CONST" {
        SectionFamily::RoData
    } else if sect.seg == "__DATA" {
        // `__DATA,__const` is relocated read-only data -- the `.data.rel.ro`
        // shape; the demotion below routes it once relocations confirm it.
        if sect.name == "__const" {
            SectionFamily::RoData
        } else {
            SectionFamily::Data
        }
    } else {
        return Err(err(&format!(
            "section `{}` is in a segment the merge has no stream for",
            sect.label(),
        )));
    };
    Ok(if family == SectionFamily::RoData && has_relocs {
        SectionFamily::RelRo
    } else {
        family
    })
}

/// One decoded `relocation_info`.
#[derive(Clone, Copy)]
struct Reloc {
    address: u32,
    symbolnum: u32,
    pcrel: bool,
    length: u8,
    extern_: bool,
    rtype: u8,
}

fn read_relocs(bytes: &[u8], sect: &Sect) -> Result<Vec<Reloc>, C5Error> {
    let n = sect.nreloc as usize;
    let base = sect.reloff as usize;
    if n != 0
        && base
            .checked_add(n * RELOCATION_INFO_SIZE)
            .is_none_or(|e| e > bytes.len())
    {
        return Err(err(&format!(
            "section `{}` relocation table runs past end of file",
            sect.label(),
        )));
    }
    let mut out = Vec::with_capacity(n);
    for i in 0..n {
        let off = base + i * RELOCATION_INFO_SIZE;
        let address = need_u32(bytes, off, "relocation")?;
        let info = need_u32(bytes, off + 4, "relocation")?;
        if address & R_SCATTERED != 0 {
            return Err(err(&format!(
                "section `{}` carries a scattered relocation; the Mach-O reader \
                 handles only the `relocation_info` form",
                sect.label(),
            )));
        }
        out.push(Reloc {
            address,
            symbolnum: info & 0x00FF_FFFF,
            pcrel: (info >> 24) & 1 != 0,
            length: ((info >> 25) & 3) as u8,
            extern_: (info >> 27) & 1 != 0,
            rtype: ((info >> 28) & 0xF) as u8,
        });
    }
    Ok(out)
}

/// AAELF64 name of an `ARM64_RELOC_PAGEOFF12` site, from the
/// instruction it patches: an `add` immediate takes the `ADD` form, a
/// load / store the `LDST<n>` form for its access width. Mach-O leaves
/// the width to the instruction; AAELF64 spells it in the type.
fn pageoff12_rtype(insn: u32, site: &str) -> Result<u32, C5Error> {
    if insn & 0xFF80_0000 == 0x9100_0000 {
        return Ok(R_AARCH64_ADD_ABS_LO12_NC);
    }
    if insn & 0x3B00_0000 == 0x3900_0000 {
        let size = insn >> 30;
        let vector = (insn >> 26) & 1 != 0;
        let opc = (insn >> 22) & 3;
        // A vector access with `size == 0` and `opc<1>` set is 128-bit;
        // every other form scales by `size`.
        return Ok(match (size, vector && opc & 2 != 0) {
            (0, true) => R_AARCH64_LDST128_ABS_LO12_NC,
            (0, false) => R_AARCH64_LDST8_ABS_LO12_NC,
            (1, _) => R_AARCH64_LDST16_ABS_LO12_NC,
            (2, _) => R_AARCH64_LDST32_ABS_LO12_NC,
            _ => R_AARCH64_LDST64_ABS_LO12_NC,
        });
    }
    Err(err(&format!(
        "{site}: ARM64_RELOC_PAGEOFF12 patches instruction {insn:#010x}, \
         which is neither an `add` immediate nor a load / store",
    )))
}

/// Read the `length`-coded field a Mach-O relocation stores its
/// implicit addend in.
fn stored_addend(content: &[u8], at: usize, length: u8, site: &str) -> Result<i64, C5Error> {
    let short = || {
        err(&format!(
            "{site}: relocation field runs past section content"
        ))
    };
    Ok(match length {
        3 => u64le(content, at).ok_or_else(short)? as i64,
        2 => u32le(content, at).ok_or_else(short)? as i32 as i64,
        _ => {
            return Err(err(&format!(
                "{site}: relocation length code {length} is not a 4- or 8-byte field",
            )));
        }
    })
}

/// Parse a Mach-O `MH_OBJECT` into the linker's native object model.
pub fn parse_native_mach_o(bytes: &[u8]) -> Result<NativeObject, C5Error> {
    if bytes.len() < MACH_HEADER_64_SIZE {
        return Err(err(&format!(
            "Mach-O object truncated: have {} bytes, need at least {MACH_HEADER_64_SIZE} \
             for the header",
            bytes.len(),
        )));
    }
    if need_u32(bytes, 0, "header")? != MH_MAGIC_64 {
        return Err(err(
            "not a 64-bit little-endian Mach-O object (MH_MAGIC_64 expected)",
        ));
    }
    let filetype = need_u32(bytes, 12, "header")?;
    if filetype != MH_OBJECT {
        return Err(err(&format!(
            "Mach-O file is not relocatable (filetype {filetype}, expected MH_OBJECT = {MH_OBJECT})",
        )));
    }
    let cputype = need_u32(bytes, 4, "header")?;
    let machine = match cputype {
        CPU_TYPE_ARM64 => NativeMachine::Aarch64,
        CPU_TYPE_X86_64 => {
            return Err(err(
                "Mach-O object is x86_64; the Mach-O reader translates arm64 relocations only",
            ));
        }
        _ => {
            return Err(err(&format!(
                "Mach-O object has unhandled cputype {cputype:#x}",
            )));
        }
    };
    let ncmds = need_u32(bytes, 16, "header")?;

    let mut sects: Vec<Sect> = Vec::new();
    let mut symtab: Option<(u32, u32, u32, u32)> = None;
    let mut off = MACH_HEADER_64_SIZE;
    for i in 0..ncmds {
        let cmd = need_u32(bytes, off, "load command")?;
        let cmdsize = need_u32(bytes, off + 4, "load command")? as usize;
        if cmdsize < 8 || off.checked_add(cmdsize).is_none_or(|e| e > bytes.len()) {
            return Err(err(&format!(
                "load command {i} has size {cmdsize} and runs past end of file",
            )));
        }
        match cmd {
            LC_SEGMENT_64 => {
                let nsects = need_u32(bytes, off + 64, "LC_SEGMENT_64")? as usize;
                for s in 0..nsects {
                    let p = off + 72 + s * SECTION_64_SIZE;
                    if p + SECTION_64_SIZE > off + cmdsize {
                        return Err(err("LC_SEGMENT_64 section table overruns the command"));
                    }
                    sects.push(Sect {
                        name: fixed_name(bytes, p)?,
                        seg: fixed_name(bytes, p + 16)?,
                        addr: need_u64(bytes, p + 32, "section")?,
                        size: need_u64(bytes, p + 40, "section")?,
                        offset: need_u32(bytes, p + 48, "section")?,
                        align: need_u32(bytes, p + 52, "section")?,
                        reloff: need_u32(bytes, p + 56, "section")?,
                        nreloc: need_u32(bytes, p + 60, "section")?,
                        flags: need_u32(bytes, p + 64, "section")?,
                        family: SectionFamily::Discard,
                        base: 0,
                    });
                }
            }
            LC_SYMTAB => {
                symtab = Some((
                    need_u32(bytes, off + 8, "LC_SYMTAB")?,
                    need_u32(bytes, off + 12, "LC_SYMTAB")?,
                    need_u32(bytes, off + 16, "LC_SYMTAB")?,
                    need_u32(bytes, off + 20, "LC_SYMTAB")?,
                ));
            }
            _ => {}
        }
        off += cmdsize;
    }
    let (symoff, nsyms, stroff, strsize) =
        symtab.ok_or_else(|| err("Mach-O object has no LC_SYMTAB"))?;

    for s in &mut sects {
        let has_relocs = s.nreloc != 0;
        s.family = classify(s, has_relocs)?;
        if s.align > 32 {
            return Err(err(&format!(
                "section `{}` requests 2^{} alignment",
                s.label(),
                s.align,
            )));
        }
    }

    // Concatenate each family in section-header order, honoring the
    // per-section alignment, and record where each section landed.
    let mut text = Vec::new();
    let mut rodata = Vec::new();
    let mut relro = Vec::new();
    let mut data = Vec::new();
    let mut text_align = 16usize;
    let (mut rodata_align, mut relro_align, mut data_align, mut bss_align) = (1usize, 1, 1, 1);
    let mut bss_size = 0usize;
    let mut sections: Vec<InputSection> = Vec::new();
    let mut discarded: Vec<(String, u64)> = Vec::new();
    for s in &mut sects {
        let align = 1usize << s.align;
        let family = s.family;
        let base = match family {
            SectionFamily::Discard => {
                discarded.push((s.label(), s.size));
                continue;
            }
            SectionFamily::Bss => {
                bss_align = bss_align.max(align);
                bss_size = bss_size.next_multiple_of(align);
                let b = bss_size as u64;
                bss_size += s.size as usize;
                b
            }
            _ => {
                let (blob, blob_align) = match family {
                    SectionFamily::Text => (&mut text, &mut text_align),
                    SectionFamily::RoData => (&mut rodata, &mut rodata_align),
                    SectionFamily::RelRo => (&mut relro, &mut relro_align),
                    _ => (&mut data, &mut data_align),
                };
                *blob_align = (*blob_align).max(align);
                blob.resize(blob.len().next_multiple_of(align), 0);
                let b = blob.len() as u64;
                let content = s.content(bytes)?;
                if content.len() as u64 != s.size {
                    return Err(err(&format!(
                        "section `{}` content is {} bytes, header says {}",
                        s.label(),
                        content.len(),
                        s.size,
                    )));
                }
                blob.extend_from_slice(content);
                b
            }
        };
        s.base = base;
        sections.push(InputSection {
            name: s.label(),
            family,
            offset: base,
            size: s.size,
        });
    }

    // `n_sect` is 1-based over the flattened section list; map it to
    // the family and the byte offset the section's bytes landed at.
    let sym_place = |n_sect: u8,
                     value: u64,
                     ext: bool|
     -> Result<(NativeSymSection, u64), C5Error> {
        let idx = n_sect as usize;
        let s = sects
            .get(idx.wrapping_sub(1))
            .filter(|_| idx >= 1)
            .ok_or_else(|| {
                err(&format!(
                    "symbol names section {n_sect}, which does not exist"
                ))
            })?;
        let sec = match s.family {
            SectionFamily::Text => NativeSymSection::Text,
            SectionFamily::RoData => NativeSymSection::RoData,
            SectionFamily::RelRo => NativeSymSection::RelRo,
            SectionFamily::Data => NativeSymSection::Data,
            SectionFamily::Bss => NativeSymSection::Bss,
            // A discarded section contributes no image bytes, so a
            // label inside it names no address. Assemblers put local
            // ones there (`__LD,__compact_unwind`, `__DWARF`); an
            // external definition would be a reference the merge
            // cannot honor.
            _ if !ext => return Ok((NativeSymSection::Abs, 0)),
            _ => {
                return Err(err(&format!(
                    "external symbol is defined in section `{}`, which carries no merged payload",
                    s.label(),
                )));
            }
        };
        Ok((sec, s.base + value.saturating_sub(s.addr)))
    };

    let strtab = bytes
        .get(stroff as usize..(stroff as usize).saturating_add(strsize as usize))
        .ok_or_else(|| err("LC_SYMTAB string table runs past end of file"))?;
    let symbase = symoff as usize;
    if (nsyms as usize)
        .checked_mul(NLIST_64_SIZE)
        .and_then(|n| symbase.checked_add(n))
        .is_none_or(|e| e > bytes.len())
    {
        return Err(err("LC_SYMTAB symbol table runs past end of file"));
    }
    // Index 0 is the null symbol, matching the ELF reader's model;
    // Mach-O symbol `i` therefore lands at `i + 1`.
    let mut symbols = alloc::vec![NativeSymbol {
        name: String::new(),
        section: NativeSymSection::Undef,
        value: 0,
        size: 0,
        binding: STB_LOCAL,
        kind: STT_NOTYPE,
        visibility: STV_DEFAULT,
    }];
    for i in 0..nsyms as usize {
        let p = symbase + i * NLIST_64_SIZE;
        let n_strx = need_u32(bytes, p, "symbol")? as usize;
        let n_type = bytes[p + 4];
        let n_sect = bytes[p + 5];
        let n_desc = u32le(bytes, p + 6).map(|v| v as u16).unwrap_or(0);
        let n_value = need_u64(bytes, p + 8, "symbol")?;
        if n_type & N_STAB != 0 {
            symbols.push(symbols[0].clone());
            continue;
        }
        let name = cstr(strtab, n_strx)?;
        let name = name.strip_prefix('_').unwrap_or(name).to_string();
        let ext = n_type & N_EXT != 0;
        let (section, value, size) = match n_type & N_TYPE {
            N_UNDF if n_value != 0 => {
                // A common symbol carries its size in `n_value` and its
                // alignment as a log2 in `n_desc`; the linker's model is
                // the reverse pair.
                (
                    NativeSymSection::Common,
                    1u64 << ((n_desc >> 8) & 0xF),
                    n_value,
                )
            }
            N_UNDF => (NativeSymSection::Undef, 0, 0),
            N_ABS => (NativeSymSection::Abs, n_value, 0),
            N_SECT => {
                let (s, v) = sym_place(n_sect, n_value, ext)?;
                (s, v, 0)
            }
            other => {
                let what = if other == N_INDR {
                    "an alias (N_INDR)"
                } else if other == N_PBUD {
                    "a prebound undefined (N_PBUD)"
                } else {
                    "of an unhandled type"
                };
                return Err(err(&format!(
                    "symbol `{name}` is {what}; the Mach-O reader does not model it",
                )));
            }
        };
        let weak = n_desc & N_WEAK_DEF != 0 || n_desc & N_WEAK_REF != 0;
        symbols.push(NativeSymbol {
            name,
            section,
            value,
            size,
            binding: match (ext, weak) {
                (true, true) => STB_WEAK,
                (true, false) => STB_GLOBAL,
                (false, _) => STB_LOCAL,
            },
            kind: match section {
                NativeSymSection::Text => STT_FUNC,
                NativeSymSection::Undef | NativeSymSection::Abs => STT_NOTYPE,
                _ => STT_OBJECT,
            },
            // `N_PEXT` is a definition the static link resolves but the
            // image must not export -- `STV_HIDDEN`.
            visibility: if n_type & N_PEXT != 0 {
                STV_HIDDEN
            } else {
                STV_DEFAULT
            },
        });
    }

    // A relocation with `r_extern == 0` names a section, not a symbol.
    // Give each section a symbol at its merged base so those resolve
    // through the same path, the way ELF section symbols do.
    let sect_sym_base = symbols.len();
    for s in &sects {
        let (section, value) = match s.family {
            SectionFamily::Text => (NativeSymSection::Text, s.base),
            SectionFamily::RoData => (NativeSymSection::RoData, s.base),
            SectionFamily::RelRo => (NativeSymSection::RelRo, s.base),
            SectionFamily::Data => (NativeSymSection::Data, s.base),
            SectionFamily::Bss => (NativeSymSection::Bss, s.base),
            _ => (NativeSymSection::Undef, 0),
        };
        symbols.push(NativeSymbol {
            name: String::new(),
            section,
            value,
            size: 0,
            binding: STB_LOCAL,
            kind: STT_OBJECT,
            visibility: STV_DEFAULT,
        });
    }

    let mut text_relocs = Vec::new();
    let mut relro_relocs = Vec::new();
    let mut data_relocs = Vec::new();
    let mut init_funcs = Vec::new();
    for sect in &sects {
        let relocs = read_relocs(bytes, sect)?;
        let kind = sect.kind();
        let is_init = kind == S_MOD_INIT_FUNC_POINTERS || kind == S_MOD_TERM_FUNC_POINTERS;
        if sect.family == SectionFamily::Discard && !is_init {
            continue;
        }
        let content = sect.content(bytes)?;
        // Relocation entries are stored in descending address order,
        // with `ARM64_RELOC_ADDEND` / `ARM64_RELOC_SUBTRACTOR` directly
        // ahead of the entry they modify.
        let mut pending_addend: Option<i64> = None;
        let mut pending_sub: Option<Reloc> = None;
        let mut init_entries: Vec<(u32, u64)> = Vec::new();
        for r in &relocs {
            let site = format!("section `{}` offset {:#x}", sect.label(), r.address);
            if r.rtype == ARM64_RELOC_ADDEND {
                pending_addend = Some(r.symbolnum as i64);
                continue;
            }
            if r.rtype == ARM64_RELOC_SUBTRACTOR {
                pending_sub = Some(*r);
                continue;
            }
            let at = r.address as usize;
            if at
                .checked_add(1 << r.length.min(3))
                .is_none_or(|e| e > content.len())
            {
                return Err(err(&format!(
                    "{site}: relocation lies outside section content"
                )));
            }

            // Resolve the target: an extern relocation names a symbol,
            // a non-extern one a section whose stored field holds the
            // target's address inside this object.
            let (sym_idx, mut addend) = if r.extern_ {
                let idx = r.symbolnum as usize + 1;
                if idx >= sect_sym_base {
                    return Err(err(&format!(
                        "{site}: relocation names symbol {} past the symbol table",
                        r.symbolnum,
                    )));
                }
                (idx, 0i64)
            } else {
                let tgt = sects
                    .get((r.symbolnum as usize).wrapping_sub(1))
                    .filter(|_| r.symbolnum >= 1)
                    .ok_or_else(|| {
                        err(&format!(
                            "{site}: relocation names section {}, which does not exist",
                            r.symbolnum
                        ))
                    })?;
                let stored = stored_addend(content, at, r.length, &site)?;
                (
                    sect_sym_base + r.symbolnum as usize - 1,
                    stored - tgt.addr as i64,
                )
            };

            let rtype = match r.rtype {
                ARM64_RELOC_UNSIGNED => {
                    if r.extern_ {
                        addend = stored_addend(content, at, r.length, &site)?;
                    }
                    if let Some(sub) = pending_sub.take() {
                        // `A - B + K`. Expressed against the site as
                        // `A - here + (K + r_address - B's offset in this
                        // section)`, which needs B to sit in the section
                        // being patched.
                        if !sub.extern_ {
                            return Err(err(&format!(
                                "{site}: ARM64_RELOC_SUBTRACTOR subtracts a section, not a symbol",
                            )));
                        }
                        let b = symbols.get(sub.symbolnum as usize + 1).ok_or_else(|| {
                            err(&format!(
                                "{site}: SUBTRACTOR names symbol {} past the symbol table",
                                sub.symbolnum
                            ))
                        })?;
                        let same_section = matches!(
                            (b.section, sect.family),
                            (NativeSymSection::Text, SectionFamily::Text)
                                | (NativeSymSection::RoData, SectionFamily::RoData)
                                | (NativeSymSection::RelRo, SectionFamily::RelRo)
                                | (NativeSymSection::Data, SectionFamily::Data)
                        ) && b.value >= sect.base
                            && b.value < sect.base + sect.size.max(1);
                        if !same_section {
                            return Err(err(&format!(
                                "{site}: ARM64_RELOC_SUBTRACTOR subtracts `{}`, which is not \
                                 defined in the section being patched; the Mach-O reader lowers \
                                 only a difference against the patch site",
                                b.name,
                            )));
                        }
                        addend += r.address as i64 - (b.value - sect.base) as i64;
                        if r.length == 3 {
                            R_AARCH64_PREL64
                        } else {
                            R_AARCH64_PREL32
                        }
                    } else if r.length == 3 {
                        R_AARCH64_ABS64
                    } else if r.length == 2 {
                        R_AARCH64_ABS32
                    } else {
                        return Err(err(&format!(
                            "{site}: ARM64_RELOC_UNSIGNED has length code {}, which is not a \
                             4- or 8-byte field",
                            r.length,
                        )));
                    }
                }
                ARM64_RELOC_BRANCH26
                | ARM64_RELOC_PAGE21
                | ARM64_RELOC_PAGEOFF12
                | ARM64_RELOC_GOT_LOAD_PAGE21
                | ARM64_RELOC_GOT_LOAD_PAGEOFF12 => {
                    if !r.extern_ {
                        return Err(err(&format!(
                            "{site}: instruction relocation type {} is section-relative; the \
                             Mach-O reader handles the symbol form only",
                            r.rtype,
                        )));
                    }
                    addend = pending_addend.unwrap_or(0);
                    let insn = u32le(content, at).ok_or_else(|| {
                        err(&format!("{site}: instruction runs past section content"))
                    })?;
                    match r.rtype {
                        ARM64_RELOC_BRANCH26 => R_AARCH64_CALL26,
                        ARM64_RELOC_PAGE21 => R_AARCH64_ADR_PREL_PG_HI21,
                        ARM64_RELOC_GOT_LOAD_PAGE21 => R_AARCH64_ADR_GOT_PAGE,
                        ARM64_RELOC_GOT_LOAD_PAGEOFF12 => R_AARCH64_LD64_GOT_LO12_NC,
                        _ => pageoff12_rtype(insn, &site)?,
                    }
                }
                other => {
                    return Err(err(&format!(
                        "{site}: relocation type {other} (pcrel={}, length={}, extern={}) is not \
                         one the Mach-O reader translates",
                        r.pcrel as u8, r.length, r.extern_ as u8,
                    )));
                }
            };
            pending_addend = None;

            if is_init {
                let target = symbols.get(sym_idx).ok_or_else(|| {
                    err(&format!(
                        "{site}: init entry names a symbol past the symbol table"
                    ))
                })?;
                if target.section != NativeSymSection::Text {
                    return Err(err(&format!(
                        "{site}: init / fini entry must reference a function defined in this object",
                    )));
                }
                init_entries.push((r.address, (target.value as i64 + addend) as u64));
                continue;
            }

            let out = match sect.family {
                SectionFamily::Text => &mut text_relocs,
                SectionFamily::RelRo => &mut relro_relocs,
                SectionFamily::Data => &mut data_relocs,
                _ => {
                    return Err(err(&format!(
                        "{site}: section carries relocations but joins the read-only stream",
                    )));
                }
            };
            out.push(NativeReloc {
                offset: sect.base + r.address as u64,
                sym_idx,
                rtype,
                addend,
            });
        }
        if pending_sub.is_some() || pending_addend.is_some() {
            return Err(err(&format!(
                "section `{}` ends with an ARM64_RELOC_ADDEND / SUBTRACTOR that modifies nothing",
                sect.label(),
            )));
        }
        if is_init {
            init_entries.sort_by_key(|&(slot, _)| slot);
            let is_destructor = kind == S_MOD_TERM_FUNC_POINTERS;
            init_funcs.extend(init_entries.into_iter().map(|(_, unit_text_offset)| {
                NativeInitFunc {
                    is_destructor,
                    priority: None,
                    unit_text_offset,
                }
            }));
        }
    }
    // Every family blob is patched in place, so relocations must be
    // sorted the way the ELF reader delivers them.
    text_relocs.sort_by_key(|r: &NativeReloc| r.offset);
    relro_relocs.sort_by_key(|r: &NativeReloc| r.offset);
    data_relocs.sort_by_key(|r: &NativeReloc| r.offset);

    Ok(NativeObject {
        source: String::new(),
        sections,
        discarded,
        machine,
        text,
        text_align,
        rodata,
        rodata_align,
        relro,
        relro_align,
        data,
        data_align,
        bss_size,
        bss_align,
        tls_data: Vec::new(),
        tls_bss_size: 0,
        symbols,
        text_relocs,
        relro_relocs,
        data_relocs,
        init_funcs,
        dylibs: Vec::new(),
        import_dylib_map: Vec::new(),
        exports: Vec::new(),
        tls_index_fixups: Vec::new(),
        macho_tlv_descriptors: Vec::new(),
        macho_tlv_fixups: Vec::new(),
        tls_symbols: Vec::new(),
        macho_tlv_descriptor_syms: Vec::new(),
        elf_tpoff_fixups: Vec::new(),
        copy_relocs: Vec::new(),
        prologue_ends: Vec::new(),
        debug_info: Vec::new(),
        debug_abbrev: Vec::new(),
        debug_line: Vec::new(),
        debug_str: Vec::new(),
        debug_info_relocs: Vec::new(),
        debug_line_relocs: Vec::new(),
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    const PURE_INSTRUCTIONS: u32 = S_ATTR_PURE_INSTRUCTIONS | 0x400;
    const S_CSTRING_LITERALS: u32 = 0x2;

    struct Sec {
        seg: &'static str,
        name: &'static str,
        flags: u32,
        align: u32,
        content: Vec<u8>,
        /// `(r_address, r_type, pcrel, length, extern_, symbolnum)`, in
        /// the descending-address order Mach-O stores.
        relocs: Vec<(u32, u8, bool, u8, bool, u32)>,
        size_override: Option<u64>,
    }

    impl Sec {
        fn new(seg: &'static str, name: &'static str, flags: u32, content: Vec<u8>) -> Sec {
            Sec {
                seg,
                name,
                flags,
                align: 2,
                content,
                relocs: Vec::new(),
                size_override: None,
            }
        }

        fn reloc(mut self, at: u32, rtype: u8, pcrel: bool, len: u8, ext: bool, num: u32) -> Sec {
            self.relocs.push((at, rtype, pcrel, len, ext, num));
            self
        }
    }

    /// `(name, n_type, n_sect, n_desc, n_value)`.
    type Sym = (&'static str, u8, u8, u16, u64);

    fn name16(out: &mut Vec<u8>, s: &str) {
        let mut f = [0u8; 16];
        f[..s.len()].copy_from_slice(s.as_bytes());
        out.extend_from_slice(&f);
    }

    fn build(cputype: u32, filetype: u32, secs: &[Sec], syms: &[Sym]) -> Vec<u8> {
        let nsects = secs.len();
        let seg_size = 72 + 80 * nsects;
        let lc_size = seg_size + 24;
        let mut content_off = 32 + lc_size;
        let mut offs = Vec::new();
        let mut addrs = Vec::new();
        let mut addr = 0u64;
        for s in secs {
            let a = 1usize << s.align;
            content_off = content_off.next_multiple_of(a);
            addr = (addr as usize).next_multiple_of(a) as u64;
            offs.push(content_off);
            addrs.push(addr);
            content_off += s.content.len();
            addr += s.size_override.unwrap_or(s.content.len() as u64);
        }
        let mut reloffs = Vec::new();
        for s in secs {
            reloffs.push(content_off);
            content_off += 8 * s.relocs.len();
        }
        let symoff = content_off;
        let stroff = symoff + 16 * syms.len();

        let mut strtab = alloc::vec![0u8];
        let mut strx = Vec::new();
        for (n, ..) in syms {
            strx.push(strtab.len() as u32);
            strtab.extend_from_slice(n.as_bytes());
            strtab.push(0);
        }

        let mut o: Vec<u8> = Vec::new();
        o.extend_from_slice(&MH_MAGIC_64.to_le_bytes());
        o.extend_from_slice(&cputype.to_le_bytes());
        o.extend_from_slice(&0u32.to_le_bytes());
        o.extend_from_slice(&filetype.to_le_bytes());
        o.extend_from_slice(&2u32.to_le_bytes());
        o.extend_from_slice(&(lc_size as u32).to_le_bytes());
        o.extend_from_slice(&0x2000u32.to_le_bytes());
        o.extend_from_slice(&0u32.to_le_bytes());

        o.extend_from_slice(&LC_SEGMENT_64.to_le_bytes());
        o.extend_from_slice(&(seg_size as u32).to_le_bytes());
        name16(&mut o, "");
        o.extend_from_slice(&0u64.to_le_bytes());
        o.extend_from_slice(&addr.to_le_bytes());
        o.extend_from_slice(&0u64.to_le_bytes());
        o.extend_from_slice(&0u64.to_le_bytes());
        o.extend_from_slice(&7u32.to_le_bytes());
        o.extend_from_slice(&7u32.to_le_bytes());
        o.extend_from_slice(&(nsects as u32).to_le_bytes());
        o.extend_from_slice(&0u32.to_le_bytes());
        for (i, s) in secs.iter().enumerate() {
            name16(&mut o, s.name);
            name16(&mut o, s.seg);
            o.extend_from_slice(&addrs[i].to_le_bytes());
            o.extend_from_slice(
                &s.size_override
                    .unwrap_or(s.content.len() as u64)
                    .to_le_bytes(),
            );
            o.extend_from_slice(&(offs[i] as u32).to_le_bytes());
            o.extend_from_slice(&s.align.to_le_bytes());
            o.extend_from_slice(&(reloffs[i] as u32).to_le_bytes());
            o.extend_from_slice(&(s.relocs.len() as u32).to_le_bytes());
            o.extend_from_slice(&s.flags.to_le_bytes());
            o.extend_from_slice(&0u32.to_le_bytes());
            o.extend_from_slice(&0u32.to_le_bytes());
            o.extend_from_slice(&0u32.to_le_bytes());
        }
        o.extend_from_slice(&LC_SYMTAB.to_le_bytes());
        o.extend_from_slice(&24u32.to_le_bytes());
        o.extend_from_slice(&(symoff as u32).to_le_bytes());
        o.extend_from_slice(&(syms.len() as u32).to_le_bytes());
        o.extend_from_slice(&(stroff as u32).to_le_bytes());
        o.extend_from_slice(&(strtab.len() as u32).to_le_bytes());

        for (i, s) in secs.iter().enumerate() {
            o.resize(offs[i], 0);
            o.extend_from_slice(&s.content);
        }
        for (i, s) in secs.iter().enumerate() {
            o.resize(reloffs[i], 0);
            for &(at, rtype, pcrel, len, ext, num) in &s.relocs {
                o.extend_from_slice(&at.to_le_bytes());
                let info = ((rtype as u32) << 28)
                    | ((ext as u32) << 27)
                    | ((len as u32) << 25)
                    | ((pcrel as u32) << 24)
                    | num;
                o.extend_from_slice(&info.to_le_bytes());
            }
        }
        o.resize(symoff, 0);
        for (i, &(_, n_type, n_sect, n_desc, n_value)) in syms.iter().enumerate() {
            o.extend_from_slice(&strx[i].to_le_bytes());
            o.push(n_type);
            o.push(n_sect);
            o.extend_from_slice(&n_desc.to_le_bytes());
            o.extend_from_slice(&n_value.to_le_bytes());
        }
        o.resize(stroff, 0);
        o.extend_from_slice(&strtab);
        o
    }

    fn insns(words: &[u32]) -> Vec<u8> {
        words.iter().flat_map(|w| w.to_le_bytes()).collect()
    }

    #[test]
    fn recognises_only_the_relocatable_filetype() {
        let obj = build(CPU_TYPE_ARM64, MH_OBJECT, &[], &[]);
        assert!(is_mach_o_object(&obj));
        let exe = build(CPU_TYPE_ARM64, 0x2, &[], &[]);
        assert!(!is_mach_o_object(&exe));
        assert!(!is_mach_o_object(b"\x7fELF\x02\x01\x01\x00 padding here"));
        assert!(!is_mach_o_object(b"\xcf\xfa"));
    }

    #[test]
    fn translates_branch_and_page_relocations() {
        // bl 0 / adrp x0, 0 / add x0, x0, 0
        let text = Sec::new(
            "__TEXT",
            "__text",
            PURE_INSTRUCTIONS,
            insns(&[0x9400_0000, 0x9000_0000, 0x9100_0000]),
        )
        .reloc(8, ARM64_RELOC_PAGEOFF12, false, 2, true, 1)
        .reloc(4, ARM64_RELOC_PAGE21, true, 2, true, 1)
        .reloc(0, ARM64_RELOC_BRANCH26, true, 2, true, 0);
        let cstr = Sec::new("__TEXT", "__cstring", S_CSTRING_LITERALS, b"hi\0".to_vec());
        let o = parse_native_mach_o(&build(
            CPU_TYPE_ARM64,
            MH_OBJECT,
            &[text, cstr],
            &[
                ("_callee", N_UNDF | N_EXT, 0, 0, 0),
                ("_msg", N_SECT | N_EXT, 2, 0, 12),
            ],
        ))
        .expect("parse");

        assert_eq!(o.machine, NativeMachine::Aarch64);
        assert_eq!(o.text.len(), 12);
        assert_eq!(o.rodata, b"hi\0");
        let kinds: Vec<(u64, u32)> = o.text_relocs.iter().map(|r| (r.offset, r.rtype)).collect();
        assert_eq!(
            kinds,
            alloc::vec![
                (0, R_AARCH64_CALL26),
                (4, R_AARCH64_ADR_PREL_PG_HI21),
                (8, R_AARCH64_ADD_ABS_LO12_NC),
            ],
        );
        // Underscore-stripped, and index 0 stays the null symbol.
        assert_eq!(o.symbols[1].name, "callee");
        assert_eq!(o.symbols[2].name, "msg");
        assert_eq!(o.symbols[2].section, NativeSymSection::RoData);
        assert_eq!(o.text_relocs[0].sym_idx, 1);
        assert!(o.text_relocs.iter().all(|r| r.addend == 0));
    }

    #[test]
    fn addend_relocation_folds_into_the_entry_it_precedes() {
        let text = Sec::new("__TEXT", "__text", PURE_INSTRUCTIONS, insns(&[0x9000_0000]))
            .reloc(0, ARM64_RELOC_ADDEND, false, 2, false, 0x30)
            .reloc(0, ARM64_RELOC_PAGE21, true, 2, true, 0);
        let o = parse_native_mach_o(&build(
            CPU_TYPE_ARM64,
            MH_OBJECT,
            &[text],
            &[("_g", N_UNDF | N_EXT, 0, 0, 0)],
        ))
        .expect("parse");
        assert_eq!(o.text_relocs.len(), 1);
        assert_eq!(o.text_relocs[0].rtype, R_AARCH64_ADR_PREL_PG_HI21);
        assert_eq!(o.text_relocs[0].addend, 0x30);
    }

    #[test]
    fn pageoff12_takes_its_width_from_the_instruction() {
        for (insn, want) in [
            (0x9100_0000u32, R_AARCH64_ADD_ABS_LO12_NC),
            (0x3940_0000, R_AARCH64_LDST8_ABS_LO12_NC),
            (0x7940_0000, R_AARCH64_LDST16_ABS_LO12_NC),
            (0xb940_0000, R_AARCH64_LDST32_ABS_LO12_NC),
            (0xf940_0000, R_AARCH64_LDST64_ABS_LO12_NC),
            (0x3dc0_0000, R_AARCH64_LDST128_ABS_LO12_NC),
        ] {
            let text = Sec::new("__TEXT", "__text", PURE_INSTRUCTIONS, insns(&[insn])).reloc(
                0,
                ARM64_RELOC_PAGEOFF12,
                false,
                2,
                true,
                0,
            );
            let o = parse_native_mach_o(&build(
                CPU_TYPE_ARM64,
                MH_OBJECT,
                &[text],
                &[("_g", N_UNDF | N_EXT, 0, 0, 0)],
            ))
            .expect("parse");
            assert_eq!(o.text_relocs[0].rtype, want, "instruction {insn:#010x}");
        }
    }

    #[test]
    fn got_load_pair_maps_to_the_got_relocations() {
        let text = Sec::new(
            "__TEXT",
            "__text",
            PURE_INSTRUCTIONS,
            insns(&[0x9000_0000, 0xf940_0000]),
        )
        .reloc(4, ARM64_RELOC_GOT_LOAD_PAGEOFF12, false, 2, true, 0)
        .reloc(0, ARM64_RELOC_GOT_LOAD_PAGE21, true, 2, true, 0);
        let o = parse_native_mach_o(&build(
            CPU_TYPE_ARM64,
            MH_OBJECT,
            &[text],
            &[("_g", N_UNDF | N_EXT, 0, 0, 0)],
        ))
        .expect("parse");
        assert_eq!(o.text_relocs[0].rtype, R_AARCH64_ADR_GOT_PAGE);
        assert_eq!(o.text_relocs[1].rtype, R_AARCH64_LD64_GOT_LO12_NC);
    }

    #[test]
    fn section_relative_unsigned_resolves_through_a_section_symbol() {
        let text = Sec::new(
            "__TEXT",
            "__text",
            PURE_INSTRUCTIONS,
            insns(&[0xd503_201f; 4]),
        );
        // A pointer slot holding the address of `__text + 8`.
        let mut slot = Sec::new("__DATA", "__data", 0, 8u64.to_le_bytes().to_vec());
        slot.align = 3;
        let data = slot.reloc(0, ARM64_RELOC_UNSIGNED, false, 3, false, 1);
        let o = parse_native_mach_o(&build(CPU_TYPE_ARM64, MH_OBJECT, &[text, data], &[]))
            .expect("parse");
        assert_eq!(o.data_relocs.len(), 1);
        let r = o.data_relocs[0];
        assert_eq!(r.rtype, R_AARCH64_ABS64);
        assert_eq!(r.addend, 8);
        assert_eq!(o.symbols[r.sym_idx].section, NativeSymSection::Text);
        assert_eq!(o.symbols[r.sym_idx].value, 0);
    }

    #[test]
    fn subtractor_pair_lowers_to_a_pc_relative_relocation() {
        let text = Sec::new("__TEXT", "__text", PURE_INSTRUCTIONS, insns(&[0xd503_201f]));
        let mut body = alloc::vec![0u8; 8];
        body.extend_from_slice(&(-8i64).to_le_bytes());
        let mut frame = Sec::new("__DATA", "__data", 0, body);
        frame.align = 3;
        // At offset 8: `_target - _here`, where `_here` is the section base.
        let frame = frame
            .reloc(8, ARM64_RELOC_SUBTRACTOR, false, 3, true, 1)
            .reloc(8, ARM64_RELOC_UNSIGNED, false, 3, true, 0);
        let o = parse_native_mach_o(&build(
            CPU_TYPE_ARM64,
            MH_OBJECT,
            &[text, frame],
            &[
                ("_target", N_SECT | N_EXT, 1, 0, 0),
                ("_here", N_SECT, 2, 0, 4),
            ],
        ))
        .expect("parse");
        assert_eq!(o.data_relocs.len(), 1);
        assert_eq!(o.data_relocs[0].rtype, R_AARCH64_PREL64);
        // K + r_address - B's offset in the patched section = -8 + 8 - 0.
        assert_eq!(o.data_relocs[0].addend, 0);
    }

    #[test]
    fn subtractor_across_sections_is_refused_by_name() {
        let text = Sec::new("__TEXT", "__text", PURE_INSTRUCTIONS, insns(&[0xd503_201f]));
        let mut frame = Sec::new("__DATA", "__data", 0, alloc::vec![0u8; 8]);
        frame.align = 3;
        let frame = frame
            .reloc(0, ARM64_RELOC_SUBTRACTOR, false, 3, true, 1)
            .reloc(0, ARM64_RELOC_UNSIGNED, false, 3, true, 0);
        let e = parse_native_mach_o(&build(
            CPU_TYPE_ARM64,
            MH_OBJECT,
            &[text, frame],
            &[
                ("_target", N_SECT | N_EXT, 1, 0, 0),
                ("_elsewhere", N_SECT, 1, 0, 0),
            ],
        ))
        .expect_err("cross-section difference must be refused");
        let m = alloc::format!("{e}");
        assert!(m.contains("SUBTRACTOR"), "{m}");
        assert!(m.contains("elsewhere"), "{m}");
    }

    #[test]
    fn relocated_read_only_section_joins_the_relro_stream() {
        let text = Sec::new("__TEXT", "__text", PURE_INSTRUCTIONS, insns(&[0xd503_201f]));
        let mut tbl = Sec::new("__DATA", "__const", 0, alloc::vec![0u8; 8]);
        tbl.align = 3;
        let tbl = tbl.reloc(0, ARM64_RELOC_UNSIGNED, false, 3, true, 0);
        let plain = Sec::new("__TEXT", "__const", 0, alloc::vec![7u8; 4]);
        let o = parse_native_mach_o(&build(
            CPU_TYPE_ARM64,
            MH_OBJECT,
            &[text, tbl, plain],
            &[("_g", N_UNDF | N_EXT, 0, 0, 0)],
        ))
        .expect("parse");
        assert_eq!(o.relro.len(), 8);
        assert_eq!(o.rodata, alloc::vec![7u8; 4]);
        assert_eq!(o.relro_relocs.len(), 1);
        assert!(o.data_relocs.is_empty());
        let fams: Vec<_> = o
            .sections
            .iter()
            .map(|s| (s.name.clone(), s.family))
            .collect();
        assert_eq!(fams[1].0, "__DATA,__const");
        assert_eq!(fams[1].1, SectionFamily::RelRo);
        assert_eq!(fams[2].1, SectionFamily::RoData);
    }

    #[test]
    fn symbol_shapes_map_onto_the_native_model() {
        let text = Sec::new("__TEXT", "__text", PURE_INSTRUCTIONS, insns(&[0xd503_201f]));
        let mut bss = Sec::new("__DATA", "__bss", S_ZEROFILL, Vec::new());
        bss.size_override = Some(16);
        bss.align = 3;
        let o = parse_native_mach_o(&build(
            CPU_TYPE_ARM64,
            MH_OBJECT,
            &[text, bss],
            &[
                // Common: size in n_value, log2 alignment in n_desc.
                ("_tentative", N_UNDF | N_EXT, 0, 3 << 8, 32),
                ("_hidden", N_SECT | N_EXT | N_PEXT, 1, 0, 0),
                ("_weakdef", N_SECT | N_EXT, 1, N_WEAK_DEF, 0),
                ("_zero", N_SECT | N_EXT, 2, 0, 8),
                ("_abs", N_ABS | N_EXT, 0, 0, 0x1234),
                ("ltmp0", N_SECT, 1, 0, 0),
            ],
        ))
        .expect("parse");
        let by = |n: &str| o.symbols.iter().find(|s| s.name == n).expect(n).clone();
        let c = by("tentative");
        assert_eq!(c.section, NativeSymSection::Common);
        assert_eq!((c.value, c.size), (8, 32));
        assert_eq!(by("hidden").visibility, STV_HIDDEN);
        assert_eq!(by("weakdef").binding, STB_WEAK);
        assert_eq!(by("zero").section, NativeSymSection::Bss);
        assert_eq!(by("zero").value, 0);
        assert_eq!(by("abs").section, NativeSymSection::Abs);
        assert_eq!(by("abs").value, 0x1234);
        assert_eq!(by("ltmp0").binding, STB_LOCAL);
        assert_eq!(o.bss_size, 16);
        assert_eq!(by("tentative").kind, STT_OBJECT);
        assert_eq!(by("hidden").kind, STT_FUNC);
    }

    #[test]
    fn unwind_and_debug_sections_are_dropped_not_merged() {
        let text = Sec::new("__TEXT", "__text", PURE_INSTRUCTIONS, insns(&[0xd503_201f]));
        let cu = Sec::new(
            "__LD",
            "__compact_unwind",
            S_ATTR_DEBUG,
            alloc::vec![0u8; 32],
        );
        let eh = Sec::new("__TEXT", "__eh_frame", 0xB, alloc::vec![0u8; 24]);
        let o = parse_native_mach_o(&build(CPU_TYPE_ARM64, MH_OBJECT, &[text, cu, eh], &[]))
            .expect("parse");
        assert_eq!(o.rodata.len(), 0);
        assert_eq!(o.data.len(), 0);
        let dropped: Vec<&str> = o.discarded.iter().map(|(n, _)| n.as_str()).collect();
        assert_eq!(
            dropped,
            alloc::vec!["__LD,__compact_unwind", "__TEXT,__eh_frame"],
        );
    }

    #[test]
    fn mod_init_func_becomes_an_init_entry() {
        let text = Sec::new(
            "__TEXT",
            "__text",
            PURE_INSTRUCTIONS,
            insns(&[0xd503_201f; 4]),
        );
        // An extern relocation carries its addend in the slot, which a
        // producer leaves zero for a plain constructor pointer.
        let mut init = Sec::new("__DATA", "__mod_init_func", 0x9, alloc::vec![0u8; 8]);
        init.align = 3;
        let init = init.reloc(0, ARM64_RELOC_UNSIGNED, false, 3, true, 0);
        let o = parse_native_mach_o(&build(
            CPU_TYPE_ARM64,
            MH_OBJECT,
            &[text, init],
            &[("_ctor", N_SECT | N_EXT, 1, 0, 8)],
        ))
        .expect("parse");
        assert_eq!(o.init_funcs.len(), 1);
        assert!(!o.init_funcs[0].is_destructor);
        assert_eq!(o.init_funcs[0].unit_text_offset, 8);
        assert!(o.data.is_empty());
    }

    #[test]
    fn unsupported_forms_are_refused_by_name() {
        let base = |s: Sec| {
            build(
                CPU_TYPE_ARM64,
                MH_OBJECT,
                &[s],
                &[("_g", N_UNDF | N_EXT, 0, 0, 0)],
            )
        };

        let tls = Sec::new(
            "__DATA",
            "__thread_data",
            S_THREAD_LOCAL_FIRST,
            alloc::vec![0u8; 8],
        );
        let m = alloc::format!("{}", parse_native_mach_o(&base(tls)).expect_err("tls"));
        assert!(m.contains("thread-local"), "{m}");

        let text = Sec::new("__TEXT", "__text", PURE_INSTRUCTIONS, insns(&[0x9000_0000]));
        let scattered = Sec {
            relocs: alloc::vec![(0x8000_0000, 0, false, 2, false, 0)],
            ..text
        };
        let m = alloc::format!(
            "{}",
            parse_native_mach_o(&base(scattered)).expect_err("scattered"),
        );
        assert!(m.contains("scattered"), "{m}");

        // ARM64_RELOC_POINTER_TO_GOT (7) has no AAELF64 translation here.
        let unhandled = Sec::new("__TEXT", "__text", PURE_INSTRUCTIONS, insns(&[0x9000_0000]))
            .reloc(0, 7, false, 2, true, 0);
        let m = alloc::format!(
            "{}",
            parse_native_mach_o(&base(unhandled)).expect_err("type 7"),
        );
        assert!(m.contains("relocation type 7"), "{m}");

        let x86 = build(CPU_TYPE_X86_64, MH_OBJECT, &[], &[]);
        let m = alloc::format!("{}", parse_native_mach_o(&x86).expect_err("x86_64"));
        assert!(m.contains("x86_64"), "{m}");

        let exe = build(CPU_TYPE_ARM64, 0x2, &[], &[]);
        let m = alloc::format!("{}", parse_native_mach_o(&exe).expect_err("MH_EXECUTE"));
        assert!(m.contains("not relocatable"), "{m}");
    }

    #[test]
    fn a_section_relative_instruction_relocation_is_refused() {
        let text = Sec::new("__TEXT", "__text", PURE_INSTRUCTIONS, insns(&[0x9400_0000])).reloc(
            0,
            ARM64_RELOC_BRANCH26,
            true,
            2,
            false,
            1,
        );
        let e = parse_native_mach_o(&build(CPU_TYPE_ARM64, MH_OBJECT, &[text], &[]))
            .expect_err("section-relative branch");
        let m = alloc::format!("{e}");
        assert!(m.contains("section-relative"), "{m}");
    }
}

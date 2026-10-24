//! PE/COFF relocatable reader, producing the [`NativeObject`] the ELF and
//! Mach-O readers do. Sections classify by their characteristics (PE/COFF
//! specification 3.1); relocations translate to the ELF psABI types, an
//! image-relative address to [`R_PE_ADDR32NB`], a thread-local `SECREL` to
//! its local-exec offset in the TEB block `_tls_index` selects.

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::link_err;
use super::object::{
    Comdat, InputSection, NativeInitFunc, NativeMachine, NativeObject, NativeReloc,
    NativeSymSection, NativeSymbol, PeUnwindData, PeUnwindEntry, STT_FUNC, STT_NOTYPE, STT_OBJECT,
    SectionFamily, SymRef, grouped_by_name,
};
use crate::c5::diag::Code;
use crate::c5::error::C5Error;
use crate::c5::object::elf_reloc_types::{
    R_AARCH64_ABS32, R_AARCH64_ABS64, R_AARCH64_ADD_ABS_LO12_NC, R_AARCH64_ADR_PREL_LO21,
    R_AARCH64_ADR_PREL_PG_HI21, R_AARCH64_CALL26, R_AARCH64_CONDBR19, R_AARCH64_JUMP26,
    R_AARCH64_LD_PREL_LO19, R_AARCH64_PREL32, R_AARCH64_TLSLE_ADD_TPREL_HI12,
    R_AARCH64_TLSLE_ADD_TPREL_LO12_NC, R_AARCH64_TSTBR14, R_PE_ADDR32NB, R_X86_64_32, R_X86_64_64,
    R_X86_64_PC32, R_X86_64_TPOFF32, aarch64_lo12_rtype,
};

const MODULE: &str = "linker::coff_object";

const IMAGE_FILE_MACHINE_AMD64: u16 = 0x8664;
const IMAGE_FILE_MACHINE_ARM64: u16 = 0xAA64;
const FILE_HEADER_SIZE: usize = 20;
const BIGOBJ_HEADER_SIZE: usize = 56;
/// `ANON_OBJECT_HEADER_BIGOBJ::ClassID`, the GUID MSVC and GNU as write.
const BIGOBJ_CLASS_ID: [u8; 16] = [
    0xC7, 0xA1, 0xBA, 0xD1, 0xEE, 0xBA, 0xA9, 0x4B, 0xAF, 0x20, 0xFA, 0xF6, 0x6A, 0xA4, 0xDC, 0xB8,
];
const SECTION_HEADER_SIZE: usize = 40;
const RELOCATION_SIZE: usize = 10;

const IMAGE_SCN_CNT_CODE: u32 = 0x20;
const IMAGE_SCN_CNT_INITIALIZED_DATA: u32 = 0x40;
const IMAGE_SCN_CNT_UNINITIALIZED_DATA: u32 = 0x80;
const IMAGE_SCN_LNK_INFO: u32 = 0x200;
const IMAGE_SCN_LNK_REMOVE: u32 = 0x800;
const IMAGE_SCN_LNK_COMDAT: u32 = 0x1000;
const IMAGE_SCN_LNK_NRELOC_OVFL: u32 = 0x0100_0000;
const IMAGE_SCN_MEM_DISCARDABLE: u32 = 0x0200_0000;
const IMAGE_SCN_MEM_EXECUTE: u32 = 0x2000_0000;
const IMAGE_SCN_MEM_WRITE: u32 = 0x8000_0000;

const IMAGE_SYM_UNDEFINED: i32 = 0;
const IMAGE_SYM_ABSOLUTE: i32 = -1;
const IMAGE_SYM_DTYPE_FUNCTION: u16 = 2;
const IMAGE_SYM_CLASS_EXTERNAL: u8 = 2;
const IMAGE_SYM_CLASS_STATIC: u8 = 3;
const IMAGE_SYM_CLASS_LABEL: u8 = 6;
/// `.bf` / `.ef` / `.lf`: debug records.
const IMAGE_SYM_CLASS_FUNCTION: u8 = 101;
const IMAGE_SYM_CLASS_END_OF_FUNCTION: u8 = 0xFF;
const IMAGE_SYM_CLASS_FILE: u8 = 103;
const IMAGE_SYM_CLASS_SECTION: u8 = 104;
const IMAGE_SYM_CLASS_WEAK_EXTERNAL: u8 = 105;
const IMAGE_COMDAT_SELECT_ASSOCIATIVE: u8 = 5;
const IMAGE_WEAK_EXTERN_SEARCH_NOLIBRARY: u32 = 1;

const IMAGE_REL_AMD64_ABSOLUTE: u16 = 0x0;
const IMAGE_REL_AMD64_ADDR64: u16 = 0x1;
const IMAGE_REL_AMD64_ADDR32: u16 = 0x2;
const IMAGE_REL_AMD64_ADDR32NB: u16 = 0x3;
const IMAGE_REL_AMD64_REL32: u16 = 0x4;
const IMAGE_REL_AMD64_REL32_5: u16 = 0x9;
const IMAGE_REL_AMD64_SECREL: u16 = 0xB;

const IMAGE_REL_ARM64_ABSOLUTE: u16 = 0x0;
const IMAGE_REL_ARM64_ADDR32: u16 = 0x1;
const IMAGE_REL_ARM64_ADDR32NB: u16 = 0x2;
const IMAGE_REL_ARM64_BRANCH26: u16 = 0x3;
const IMAGE_REL_ARM64_PAGEBASE_REL21: u16 = 0x4;
const IMAGE_REL_ARM64_REL21: u16 = 0x5;
const IMAGE_REL_ARM64_PAGEOFFSET_12A: u16 = 0x6;
const IMAGE_REL_ARM64_PAGEOFFSET_12L: u16 = 0x7;
const IMAGE_REL_ARM64_SECREL_LOW12A: u16 = 0x9;
const IMAGE_REL_ARM64_SECREL_HIGH12A: u16 = 0xA;
const IMAGE_REL_ARM64_SECREL_LOW12L: u16 = 0xB;
const IMAGE_REL_ARM64_ADDR64: u16 = 0xE;
const IMAGE_REL_ARM64_BRANCH19: u16 = 0xF;
const IMAGE_REL_ARM64_BRANCH14: u16 = 0x10;
const IMAGE_REL_ARM64_REL32: u16 = 0x11;

const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STB_WEAK: u8 = 2;

fn bad(msg: &str) -> C5Error {
    link_err(Code::MALFORMED_INPUT, MODULE, msg)
}

fn unsupported(msg: &str) -> C5Error {
    link_err(Code::UNSUPPORTED, MODULE, msg)
}

fn u16le(bytes: &[u8], off: usize) -> Option<u16> {
    Some(u16::from_le_bytes(
        bytes.get(off..off + 2)?.try_into().ok()?,
    ))
}

fn u32le(bytes: &[u8], off: usize) -> Option<u32> {
    Some(u32::from_le_bytes(
        bytes.get(off..off + 4)?.try_into().ok()?,
    ))
}

fn need_u16(bytes: &[u8], off: usize, what: &str) -> Result<u16, C5Error> {
    u16le(bytes, off).ok_or_else(|| bad(&format!("{what} runs past end of file")))
}

fn need_u32(bytes: &[u8], off: usize, what: &str) -> Result<u32, C5Error> {
    u32le(bytes, off).ok_or_else(|| bad(&format!("{what} runs past end of file")))
}

/// The file layout the header describes.
struct Header<'a> {
    machine: u16,
    nsects: usize,
    sect_table: usize,
    symtab: usize,
    nsyms: usize,
    /// 18 bytes, or 20 in the bigobj form, whose section numbers are 32-bit.
    sym_size: usize,
    strtab: &'a [u8],
}

fn bigobj(bytes: &[u8]) -> bool {
    u16le(bytes, 0) == Some(0)
        && u16le(bytes, 2) == Some(0xFFFF)
        && u16le(bytes, 4).is_some_and(|v| v >= 2)
        && bytes.get(12..28) == Some(&BIGOBJ_CLASS_ID[..])
}

fn read_header(bytes: &[u8]) -> Result<Header<'_>, C5Error> {
    let (machine, nsects, sect_table, symtab, nsyms, sym_size) = if bigobj(bytes) {
        (
            need_u16(bytes, 6, "header")?,
            need_u32(bytes, 44, "header")? as usize,
            BIGOBJ_HEADER_SIZE,
            need_u32(bytes, 48, "header")? as usize,
            need_u32(bytes, 52, "header")? as usize,
            20,
        )
    } else {
        if need_u16(bytes, 16, "header")? != 0 {
            return Err(bad("COFF file has an optional header; an object has none"));
        }
        (
            need_u16(bytes, 0, "header")?,
            need_u16(bytes, 2, "header")? as usize,
            FILE_HEADER_SIZE,
            need_u32(bytes, 8, "header")? as usize,
            need_u32(bytes, 12, "header")? as usize,
            18,
        )
    };
    if nsects
        .checked_mul(SECTION_HEADER_SIZE)
        .and_then(|n| n.checked_add(sect_table))
        .is_none_or(|e| e > bytes.len())
    {
        return Err(bad("COFF section table runs past end of file"));
    }
    let syms_end = nsyms
        .checked_mul(sym_size)
        .and_then(|n| n.checked_add(symtab))
        .filter(|&e| e <= bytes.len())
        .ok_or_else(|| bad("COFF symbol table runs past end of file"))?;
    let strtab = if symtab == 0 {
        &[][..]
    } else {
        let len = need_u32(bytes, syms_end, "string table")? as usize;
        bytes
            .get(syms_end..syms_end.saturating_add(len.max(4)))
            .ok_or_else(|| bad("COFF string table runs past end of file"))?
    };
    Ok(Header {
        machine,
        nsects,
        sect_table,
        symtab,
        nsyms,
        sym_size,
        strtab,
    })
}

/// True when `bytes` is a COFF relocatable for a machine the reader names
/// (x86-64, arm64), in the regular or the bigobj form. An image and an
/// import-library member fail here.
pub fn is_coff_object(bytes: &[u8]) -> bool {
    let machine = if bigobj(bytes) {
        u16le(bytes, 6)
    } else {
        u16le(bytes, 0)
    };
    matches!(
        machine,
        Some(IMAGE_FILE_MACHINE_AMD64 | IMAGE_FILE_MACHINE_ARM64)
    ) && read_header(bytes).is_ok()
}

fn cstr(table: &[u8], off: usize) -> Result<String, C5Error> {
    let rest = table
        .get(off..)
        .ok_or_else(|| bad("name offset past end of the string table"))?;
    let end = rest.iter().position(|&b| b == 0).unwrap_or(rest.len());
    core::str::from_utf8(&rest[..end])
        .map(str::to_string)
        .map_err(|_| bad("name is not UTF-8"))
}

/// An 8-byte name field: inline and NUL-padded, or, for a symbol, a string
/// table offset after four zero bytes.
fn short_name(field: &[u8], strtab: &[u8]) -> Result<String, C5Error> {
    if field[..4] == [0; 4] {
        return cstr(
            strtab,
            u32::from_le_bytes(field[4..8].try_into().unwrap()) as usize,
        );
    }
    cstr(field, 0)
}

/// A section name: inline, `/<decimal>` or `//<base64>` into the string table.
fn section_name(field: &[u8], strtab: &[u8]) -> Result<String, C5Error> {
    let inline = cstr(field, 0)?;
    let Some(rest) = inline.strip_prefix('/') else {
        return Ok(inline);
    };
    let off = if let Some(b64) = rest.strip_prefix('/') {
        b64.bytes().try_fold(0usize, |acc, c| {
            let d = match c {
                b'A'..=b'Z' => c - b'A',
                b'a'..=b'z' => c - b'a' + 26,
                b'0'..=b'9' => c - b'0' + 52,
                b'+' => 62,
                b'/' => 63,
                _ => return None,
            };
            acc.checked_mul(64)?.checked_add(d as usize)
        })
    } else {
        rest.parse::<usize>().ok()
    };
    cstr(
        strtab,
        off.ok_or_else(|| bad(&format!("section name `{inline}` is malformed")))?,
    )
}

/// One section header, plus what the parse assigns it.
struct Sect {
    name: String,
    size: u32,
    raw_off: u32,
    reloc_off: u32,
    nrelocs: u32,
    flags: u32,
    family: SectionFamily,
    /// A `.ctors` / `.CRT$XC*` table: `(destructor, priority)`.
    init: Option<(bool, Option<u32>)>,
    base: u64,
    record: Option<u32>,
}

impl Sect {
    fn align(&self) -> u64 {
        match (self.flags >> 20) & 0xF {
            0 => 1,
            n => 1 << (n - 1),
        }
    }

    fn content<'a>(&self, bytes: &'a [u8]) -> Result<&'a [u8], C5Error> {
        if self.flags & IMAGE_SCN_CNT_UNINITIALIZED_DATA != 0 {
            return Ok(&[]);
        }
        let (off, size) = (self.raw_off as usize, self.size as usize);
        bytes.get(off..off.saturating_add(size)).ok_or_else(|| {
            bad(&format!(
                "section `{}` content runs past end of file",
                self.name
            ))
        })
    }
}

fn read_sections(bytes: &[u8], h: &Header) -> Result<Vec<Sect>, C5Error> {
    let mut out = Vec::with_capacity(h.nsects);
    for i in 0..h.nsects {
        let p = h.sect_table + i * SECTION_HEADER_SIZE;
        let flags = need_u32(bytes, p + 36, "section header")?;
        let mut reloc_off = need_u32(bytes, p + 24, "section header")?;
        let mut nrelocs = need_u16(bytes, p + 32, "section header")? as u32;
        // The count overflowed 16 bits: the first entry's address holds it.
        if flags & IMAGE_SCN_LNK_NRELOC_OVFL != 0 && nrelocs == 0xFFFF {
            nrelocs = need_u32(bytes, reloc_off as usize, "relocation count")?
                .checked_sub(1)
                .ok_or_else(|| bad("an overflowed relocation count is zero"))?;
            reloc_off += RELOCATION_SIZE as u32;
        }
        out.push(Sect {
            name: section_name(&bytes[p..p + 8], h.strtab)?,
            size: need_u32(bytes, p + 16, "section header")?,
            raw_off: need_u32(bytes, p + 20, "section header")?,
            reloc_off,
            nrelocs,
            flags,
            family: SectionFamily::Discard,
            init: None,
            base: 0,
            record: None,
        });
    }
    Ok(out)
}

/// `(destructor, priority)` of a constructor / destructor table: GNU's
/// `.ctors[.NNNNN]` / `.dtors[.NNNNN]`, whose suffix is 65535 minus the
/// priority, and the C runtime's `.CRT$X[CI]*` / `.CRT$X[PT]*`.
fn init_table(name: &str) -> Option<(bool, Option<u32>)> {
    for (prefix, dtor) in [(".ctors", false), (".dtors", true)] {
        if let Some(rest) = name.strip_prefix(prefix) {
            return match rest {
                "" => Some((dtor, None)),
                _ => {
                    let n = rest.strip_prefix('.')?.parse::<u32>().ok()?;
                    Some((dtor, Some(65535u32.checked_sub(n)?)))
                }
            };
        }
    }
    match name.strip_prefix(".CRT$X")?.as_bytes().first()? {
        b'C' | b'I' => Some((false, None)),
        b'P' | b'T' => Some((true, None)),
        _ => None,
    }
}

/// `.pdata`, and gcc's `.pdata.<suffix>` beside `.text.<suffix>`.
fn is_pdata(name: &str) -> bool {
    name == ".pdata" || name.starts_with(".pdata$") || name.starts_with(".pdata.")
}

/// The `RUNTIME_FUNCTION`s of every kept `.pdata`: x86-64's begin, end and
/// `UNWIND_INFO`; arm64's begin and `.xdata` or, flagged in its low bits, a
/// packed word.
fn read_unwind(
    bytes: &[u8],
    machine: u16,
    sects: &[Sect],
    raw: &[Option<RawSym>],
) -> Result<Vec<PeUnwindEntry>, C5Error> {
    let mut out = Vec::new();
    for s in sects.iter().filter(|s| is_pdata(&s.name)) {
        let content = s.content(bytes)?;
        let mut at: BTreeMap<u32, SymRef> = BTreeMap::new();
        for k in 0..s.nrelocs as usize {
            let p = s.reloc_off as usize + k * RELOCATION_SIZE;
            let (off, sym, t) = (
                need_u32(bytes, p, "relocation")?,
                need_u32(bytes, p + 4, "relocation")? as usize,
                need_u16(bytes, p + 8, "relocation")?,
            );
            let nb = match machine {
                IMAGE_FILE_MACHINE_AMD64 => IMAGE_REL_AMD64_ADDR32NB,
                _ => IMAGE_REL_ARM64_ADDR32NB,
            };
            let stored = u32le(content, off as usize).ok_or_else(|| {
                bad(&format!(
                    "section `{}`: relocation past its content",
                    s.name
                ))
            })?;
            if t != nb || raw.get(sym).is_none_or(Option::is_none) {
                return Err(bad(&format!(
                    "section `{}` offset {off:#x}: a `.pdata` field takes an image-relative \
                     address of a symbol",
                    s.name
                )));
            }
            at.insert(off, (sym + 1, stored as i32 as i64));
        }
        let field = |off: u32| {
            at.get(&off).copied().ok_or_else(|| {
                bad(&format!(
                    "section `{}` offset {off:#x}: a `.pdata` field no relocation names",
                    s.name
                ))
            })
        };
        let size = if machine == IMAGE_FILE_MACHINE_AMD64 {
            12
        } else {
            8
        };
        for e in (0..content.len() as u32 / size).map(|i| i * size) {
            out.push(if size == 12 {
                PeUnwindEntry {
                    begin: field(e)?,
                    end: Some(field(e + 4)?),
                    data: PeUnwindData::Info(field(e + 8)?),
                }
            } else {
                let word = u32le(content, e as usize + 4).unwrap();
                PeUnwindEntry {
                    begin: field(e)?,
                    end: None,
                    data: if word & 3 != 0 {
                        PeUnwindData::Packed(word)
                    } else {
                        PeUnwindData::Info(field(e + 4)?)
                    },
                }
            });
        }
    }
    Ok(out)
}

fn is_tls(name: &str) -> bool {
    name == ".tls" || name.starts_with(".tls$")
}

/// The merged stream a section joins. A relocated read-only section
/// joins the relro stream, as the ELF reader places one.
fn classify(s: &Sect) -> Result<SectionFamily, C5Error> {
    let f = s.flags;
    // `.pdata` is read by `read_unwind`. GNU as gives `.drectve` data flags, not LNK_INFO.
    if f & (IMAGE_SCN_LNK_REMOVE | IMAGE_SCN_LNK_INFO | IMAGE_SCN_MEM_DISCARDABLE) != 0
        || s.name == ".drectve"
        || s.name.starts_with(".debug")
        || is_pdata(&s.name)
    {
        return Ok(SectionFamily::Discard);
    }
    if s.name.starts_with(".CRT$XL") {
        return Err(unsupported(&format!(
            "section `{}` holds TLS callbacks, which the image's TLS directory does not list",
            s.name
        )));
    }
    if is_tls(&s.name) {
        return Ok(if f & IMAGE_SCN_CNT_UNINITIALIZED_DATA != 0 {
            SectionFamily::Tbss
        } else {
            SectionFamily::Tdata
        });
    }
    if f & (IMAGE_SCN_CNT_CODE | IMAGE_SCN_MEM_EXECUTE) != 0 {
        return Ok(SectionFamily::Text);
    }
    if f & IMAGE_SCN_CNT_UNINITIALIZED_DATA != 0 {
        return Ok(SectionFamily::Bss);
    }
    if f & IMAGE_SCN_CNT_INITIALIZED_DATA == 0 {
        return Err(unsupported(&format!(
            "section `{}` has characteristics {f:#010x}, which name no content the merge places",
            s.name
        )));
    }
    Ok(if f & IMAGE_SCN_MEM_WRITE != 0 {
        SectionFamily::Data
    } else if s.nrelocs != 0 {
        SectionFamily::RelRo
    } else {
        SectionFamily::RoData
    })
}

/// Each family concatenated, honoring the per-section alignment; sections
/// grouped by name across units go last, as the ELF reader places them.
#[derive(Default)]
struct Blobs {
    text: Vec<u8>,
    rodata: Vec<u8>,
    relro: Vec<u8>,
    data: Vec<u8>,
    tls: Vec<u8>,
    text_align: usize,
    rodata_align: usize,
    relro_align: usize,
    data_align: usize,
    tls_align: usize,
    bss_size: usize,
    bss_align: usize,
    tbss_size: usize,
    sections: Vec<InputSection>,
    discarded: Vec<(String, u64)>,
}

fn concat_families(bytes: &[u8], sects: &mut [Sect]) -> Result<Blobs, C5Error> {
    let mut b = Blobs {
        text_align: 16,
        rodata_align: 1,
        relro_align: 1,
        data_align: 1,
        tls_align: 1,
        bss_align: 1,
        ..Default::default()
    };
    let mut order: Vec<usize> = (0..sects.len()).collect();
    order.sort_by_key(|&i| grouped_by_name(&sects[i].name));
    // Thread-local zero fill follows every initialized thread-local byte.
    order.sort_by_key(|&i| sects[i].family == SectionFamily::Tbss);
    for i in order {
        let s = &mut sects[i];
        let align = s.align() as usize;
        let base = match s.family {
            SectionFamily::Discard => {
                b.discarded.push((s.name.clone(), s.size as u64));
                continue;
            }
            SectionFamily::Bss => {
                b.bss_align = b.bss_align.max(align);
                b.bss_size = b.bss_size.next_multiple_of(align);
                b.bss_size += s.size as usize;
                (b.bss_size - s.size as usize) as u64
            }
            SectionFamily::Tbss => {
                b.tls_align = b.tls_align.max(align);
                let end = (b.tls.len() + b.tbss_size).next_multiple_of(align);
                b.tbss_size = end - b.tls.len() + s.size as usize;
                end as u64
            }
            family => {
                let (blob, blob_align) = match family {
                    SectionFamily::Text => (&mut b.text, &mut b.text_align),
                    SectionFamily::RoData => (&mut b.rodata, &mut b.rodata_align),
                    SectionFamily::RelRo => (&mut b.relro, &mut b.relro_align),
                    SectionFamily::Tdata => (&mut b.tls, &mut b.tls_align),
                    _ => (&mut b.data, &mut b.data_align),
                };
                *blob_align = (*blob_align).max(align);
                blob.resize(blob.len().next_multiple_of(align), 0);
                let at = blob.len() as u64;
                blob.extend_from_slice(s.content(bytes)?);
                at
            }
        };
        s.base = base;
        s.record = Some(b.sections.len() as u32);
        b.sections.push(InputSection {
            name: s.name.clone(),
            family: s.family,
            offset: base,
            size: s.size as u64,
            align: align as u64,
        });
    }
    Ok(b)
}

/// One symbol record and its first auxiliary record.
struct RawSym<'a> {
    name: String,
    value: u32,
    section: i32,
    typ: u16,
    class: u8,
    aux: Option<&'a [u8]>,
}

fn read_symbols<'a>(bytes: &'a [u8], h: &Header) -> Result<Vec<Option<RawSym<'a>>>, C5Error> {
    let mut out: Vec<Option<RawSym>> = Vec::with_capacity(h.nsyms);
    let mut i = 0;
    while i < h.nsyms {
        let p = h.symtab + i * h.sym_size;
        let rec = &bytes[p..p + h.sym_size];
        let (section, rest) = if h.sym_size == 20 {
            (
                i32::from_le_bytes(rec[12..16].try_into().unwrap()),
                &rec[16..],
            )
        } else {
            (
                i16::from_le_bytes(rec[12..14].try_into().unwrap()) as i32,
                &rec[14..],
            )
        };
        let naux = rest[3] as usize;
        if i + naux >= h.nsyms && naux != 0 {
            return Err(bad(
                "a symbol's auxiliary records run past the symbol table",
            ));
        }
        out.push(Some(RawSym {
            name: short_name(&rec[..8], h.strtab)?,
            value: u32::from_le_bytes(rec[8..12].try_into().unwrap()),
            section,
            typ: u16::from_le_bytes(rest[..2].try_into().unwrap()),
            class: rest[2],
            aux: (naux != 0).then(|| &bytes[p + h.sym_size..p + 2 * h.sym_size]),
        }));
        out.extend((0..naux).map(|_| None));
        i += 1 + naux;
    }
    Ok(out)
}

/// What `.drectve` asks of the link.
#[derive(Default)]
struct Directives {
    alternate_names: Vec<(String, String)>,
    /// `-aligncomm:name,log2`: a common symbol's alignment.
    align_common: BTreeMap<String, u64>,
    /// `/EXPORT:` / `-export:`: a definition the image exports.
    exports: Vec<String>,
    /// `/INCLUDE:`: a name the link resolves as if referenced.
    includes: Vec<String>,
    default_libs: Vec<String>,
}

/// The directive string's options, split as link.exe splits them: on
/// spaces outside double quotes, which are dropped.
fn directive_tokens(text: &str) -> Vec<String> {
    let mut out = Vec::new();
    let (mut cur, mut quoted) = (String::new(), false);
    for c in text.chars() {
        match c {
            '"' => quoted = !quoted,
            c if c.is_ascii_whitespace() && !quoted => {
                if !cur.is_empty() {
                    out.push(core::mem::take(&mut cur));
                }
            }
            c => cur.push(c),
        }
    }
    if !cur.is_empty() {
        out.push(cur);
    }
    out
}

fn read_directives(bytes: &[u8], sects: &[Sect]) -> Result<Directives, C5Error> {
    let mut d = Directives::default();
    for s in sects.iter().filter(|s| s.name == ".drectve") {
        let body = s.content(bytes)?;
        let text = core::str::from_utf8(body.strip_prefix(b"\xEF\xBB\xBF").unwrap_or(body))
            .map_err(|_| bad("`.drectve` is not UTF-8"))?;
        for tok in directive_tokens(text.trim_end_matches('\0')) {
            let Some(opt) = tok.strip_prefix('/').or_else(|| tok.strip_prefix('-')) else {
                return Err(bad(&format!(
                    "`.drectve` holds `{tok}`, which is no option"
                )));
            };
            let (key, arg) = opt.split_once(':').unwrap_or((opt, ""));
            match key.to_ascii_lowercase().as_str() {
                "defaultlib" => d.default_libs.push(arg.to_string()),
                "include" => d.includes.push(arg.to_string()),
                // `DATA` and `PRIVATE` (no import library entry) change nothing
                // here; an ordinal and an alias are refused.
                "export" => {
                    let mut parts = arg.split(',');
                    let name = parts.next().unwrap_or("");
                    let plain =
                        |f: &str| matches!(f.to_ascii_lowercase().as_str(), "data" | "private");
                    if name.is_empty() || name.contains('=') || !parts.all(plain) {
                        return Err(unsupported(&format!(
                            "`.drectve` option `{tok}` exports by ordinal or under another \
                             name, which the linker does not carry out"
                        )));
                    }
                    d.exports.push(name.to_string());
                }
                "alternatename" => {
                    let (from, to) = arg.split_once('=').ok_or_else(|| {
                        bad(&format!("`.drectve` option `{tok}` names no alternate"))
                    })?;
                    d.alternate_names.push((from.to_string(), to.to_string()));
                }
                "aligncomm" => {
                    let (name, log2) = arg
                        .split_once(',')
                        .and_then(|(n, l)| Some((n, l.parse::<u32>().ok().filter(|&l| l < 32)?)))
                        .ok_or_else(|| bad(&format!("`.drectve` option `{tok}` is malformed")))?;
                    d.align_common.insert(name.to_string(), 1 << log2);
                }
                _ => {
                    return Err(unsupported(&format!(
                        "`.drectve` option `{tok}` is not one the linker carries out"
                    )));
                }
            }
        }
    }
    Ok(d)
}

/// A COMDAT section's selection, checksum, leader and associative parent.
struct SectComdat {
    selection: u8,
    checksum: u32,
    leader: Option<String>,
    parent: Option<usize>,
}

/// Each section's COMDAT facts, from its section-definition symbol and the first
/// symbol it defines after that: the leader, a key when external.
fn read_comdats(raw: &[Option<RawSym>], sects: &[Sect], wide: bool) -> Vec<Option<SectComdat>> {
    let mut out: Vec<Option<SectComdat>> = (0..sects.len()).map(|_| None).collect();
    for (i, r) in raw.iter().enumerate() {
        let Some(r) = r.as_ref().filter(|r| defines_section(r, sects)) else {
            continue;
        };
        let k = r.section as usize - 1;
        if sects[k].flags & IMAGE_SCN_LNK_COMDAT == 0 || out[k].is_some() {
            continue;
        }
        let aux = r.aux.unwrap();
        let low = u16::from_le_bytes(aux[12..14].try_into().unwrap()) as usize;
        let high = if wide {
            u16::from_le_bytes(aux[16..18].try_into().unwrap()) as usize
        } else {
            0
        };
        let selection = aux[14];
        let leader = raw[i + 1..]
            .iter()
            .flatten()
            .find(|l| l.section == r.section && !defines_section(l, sects))
            .filter(|l| l.class == IMAGE_SYM_CLASS_EXTERNAL)
            .map(|l| l.name.clone());
        out[k] = Some(SectComdat {
            selection,
            checksum: u32::from_le_bytes(aux[8..12].try_into().unwrap()),
            leader,
            parent: (selection == IMAGE_COMDAT_SELECT_ASSOCIATIVE)
                .then(|| (low | high << 16).wrapping_sub(1)),
        });
    }
    out
}

/// The groups external leaders key, associative sections included.
fn comdat_groups(comdat: &[Option<SectComdat>], sects: &[Sect]) -> Vec<Comdat> {
    let root = |mut k: usize| {
        for _ in 0..comdat.len() {
            match comdat.get(k).and_then(|c| c.as_ref()?.parent) {
                Some(p) => k = p,
                None => break,
            }
        }
        k
    };
    let mut groups = Vec::new();
    for (k, c) in comdat.iter().enumerate() {
        let Some(c) = c.as_ref().filter(|c| c.parent.is_none()) else {
            continue;
        };
        let Some(key) = c.leader.clone() else {
            continue;
        };
        let sections = (0..sects.len())
            .filter(|&m| m == k || (comdat[m].is_some() && root(m) == k))
            .filter_map(|m| sects[m].record)
            .collect();
        groups.push(Comdat {
            key,
            selection: c.selection,
            size: sects[k].size as u64,
            checksum: c.checksum,
            sections,
        });
    }
    groups
}

/// The native section of a symbol defined in section `n` (1-based), its
/// merged offset and its input-section record; a symbol in a discarded
/// section names no address.
fn place(sects: &[Sect], n: i32, value: u32) -> Option<(NativeSymSection, u64, Option<u32>)> {
    let s = sects.get((n as usize).checked_sub(1)?)?;
    let section = match s.family {
        SectionFamily::Text => NativeSymSection::Text,
        SectionFamily::RoData => NativeSymSection::RoData,
        SectionFamily::RelRo => NativeSymSection::RelRo,
        SectionFamily::Data => NativeSymSection::Data,
        SectionFamily::Bss => NativeSymSection::Bss,
        SectionFamily::Tdata | SectionFamily::Tbss => NativeSymSection::Tls,
        SectionFamily::Discard => return Some((NativeSymSection::Abs, 0, None)),
    };
    Some((section, s.base + value as u64, s.record))
}

fn null_symbol() -> NativeSymbol {
    NativeSymbol {
        name: String::new(),
        section: NativeSymSection::Undef,
        value: 0,
        size: 0,
        binding: STB_LOCAL,
        kind: STT_NOTYPE,
        visibility: 0,
        input_section: None,
    }
}

/// The section-definition symbol: STATIC, at offset 0, named as its section.
fn defines_section(r: &RawSym, sects: &[Sect]) -> bool {
    r.class == IMAGE_SYM_CLASS_STATIC
        && r.value == 0
        && r.typ == 0
        && r.aux.is_some()
        && (r.section as usize)
            .checked_sub(1)
            .and_then(|i| sects.get(i))
            .is_some_and(|s| s.name == r.name)
}

/// The symbol table in the ELF reader's model: index 0 is the null symbol,
/// so COFF symbol `i` lands at `i + 1`, its auxiliary records as null
/// symbols; a section-definition symbol is the section symbol a
/// relocation reaches the section's start through.
fn decode_symbols(
    raw: &[Option<RawSym>],
    sects: &[Sect],
    directives: &Directives,
    alternates: &mut Vec<(String, String)>,
) -> Result<Vec<NativeSymbol>, C5Error> {
    let mut out = Vec::with_capacity(raw.len() + 1);
    out.push(null_symbol());
    for r in raw {
        let Some(r) = r else {
            out.push(null_symbol());
            continue;
        };
        let mut s = null_symbol();
        let external = r.class == IMAGE_SYM_CLASS_EXTERNAL;
        match (r.class, r.section) {
            (IMAGE_SYM_CLASS_FILE, _) | (IMAGE_SYM_CLASS_SECTION, _) => {}
            // Resolved below, once the record it names has been decoded.
            (IMAGE_SYM_CLASS_WEAK_EXTERNAL, _) => s.name = r.name.clone(),
            (IMAGE_SYM_CLASS_EXTERNAL, IMAGE_SYM_UNDEFINED) if r.value != 0 => {
                let size = r.value as u64;
                let natural = size.next_power_of_two().min(32);
                s = NativeSymbol {
                    name: r.name.clone(),
                    section: NativeSymSection::Common,
                    value: directives
                        .align_common
                        .get(&r.name)
                        .copied()
                        .unwrap_or(natural),
                    size,
                    binding: STB_GLOBAL,
                    kind: STT_OBJECT,
                    ..s
                };
            }
            (IMAGE_SYM_CLASS_EXTERNAL, IMAGE_SYM_UNDEFINED) => {
                s.name = r.name.clone();
                s.binding = STB_GLOBAL;
            }
            (IMAGE_SYM_CLASS_EXTERNAL | IMAGE_SYM_CLASS_STATIC, IMAGE_SYM_ABSOLUTE) => {
                s.name = r.name.clone();
                s.section = NativeSymSection::Abs;
                s.value = r.value as u64;
                s.binding = if external { STB_GLOBAL } else { STB_LOCAL };
            }
            (IMAGE_SYM_CLASS_EXTERNAL | IMAGE_SYM_CLASS_STATIC | IMAGE_SYM_CLASS_LABEL, n)
                if n > 0 =>
            {
                let (section, value, record) = place(sects, n, r.value).ok_or_else(|| {
                    bad(&format!(
                        "symbol `{}` names section {n}, which does not exist",
                        r.name
                    ))
                })?;
                if record.is_none() && external {
                    return Err(unsupported(&format!(
                        "external symbol `{}` is defined in a section the merge drops",
                        r.name
                    )));
                }
                let function = (r.typ >> 4) & 3 == IMAGE_SYM_DTYPE_FUNCTION;
                s = NativeSymbol {
                    name: if defines_section(r, sects) {
                        String::new()
                    } else {
                        r.name.clone()
                    },
                    section,
                    value,
                    binding: if external { STB_GLOBAL } else { STB_LOCAL },
                    kind: match section {
                        _ if r.class == IMAGE_SYM_CLASS_LABEL => STT_NOTYPE,
                        NativeSymSection::Text if function || external => STT_FUNC,
                        NativeSymSection::Text | NativeSymSection::Abs => STT_NOTYPE,
                        _ => STT_OBJECT,
                    },
                    input_section: record,
                    ..s
                };
            }
            (IMAGE_SYM_CLASS_FUNCTION | IMAGE_SYM_CLASS_END_OF_FUNCTION, _) => {}
            (class, n) => {
                return Err(unsupported(&format!(
                    "symbol `{}` has storage class {class} in section {n}, which the reader \
                     does not model",
                    r.name
                )));
            }
        }
        out.push(s);
    }
    // A weak external stands for its default, the record its auxiliary
    // names, unless the link defines the name.
    for (i, r) in raw.iter().enumerate() {
        let Some(r) = r
            .as_ref()
            .filter(|r| r.class == IMAGE_SYM_CLASS_WEAK_EXTERNAL)
        else {
            continue;
        };
        let aux = r.aux.ok_or_else(|| {
            bad(&format!(
                "weak external `{}` has no auxiliary record",
                r.name
            ))
        })?;
        let tag = u32::from_le_bytes(aux[..4].try_into().unwrap()) as usize;
        let search = u32::from_le_bytes(aux[4..8].try_into().unwrap());
        let default = out
            .get(tag + 1)
            .filter(|_| raw.get(tag).is_some_and(Option::is_some))
            .cloned()
            .ok_or_else(|| bad(&format!("weak external `{}` names no symbol", r.name)))?;
        let weak = &mut out[i + 1];
        match default.section {
            NativeSymSection::Abs if default.value == 0 => weak.binding = STB_WEAK,
            NativeSymSection::Undef => {
                weak.binding = if search == IMAGE_WEAK_EXTERN_SEARCH_NOLIBRARY {
                    STB_WEAK
                } else {
                    STB_GLOBAL
                };
                alternates.push((r.name.clone(), default.name.clone()));
            }
            _ => {
                *weak = NativeSymbol {
                    name: r.name.clone(),
                    binding: STB_WEAK,
                    ..default
                };
            }
        }
    }
    Ok(out)
}

/// A relocation in the linker's model; a `SECREL` against what may be a
/// thread-local, or nothing.
enum Mapped {
    Reloc(u32, i64),
    /// The local-exec form the offset in the TLS block takes.
    SecRel(u32, i64),
    Skip,
}

/// `IMAGE_REL_<machine>_<NAME>`, for diagnostics.
fn reloc_name(machine: u16, t: u16) -> String {
    const AMD64: [&str; 17] = [
        "ABSOLUTE", "ADDR64", "ADDR32", "ADDR32NB", "REL32", "REL32_1", "REL32_2", "REL32_3",
        "REL32_4", "REL32_5", "SECTION", "SECREL", "SECREL7", "TOKEN", "SREL32", "PAIR", "SSPAN32",
    ];
    const ARM64: [&str; 18] = [
        "ABSOLUTE",
        "ADDR32",
        "ADDR32NB",
        "BRANCH26",
        "PAGEBASE_REL21",
        "REL21",
        "PAGEOFFSET_12A",
        "PAGEOFFSET_12L",
        "SECREL",
        "SECREL_LOW12A",
        "SECREL_HIGH12A",
        "SECREL_LOW12L",
        "TOKEN",
        "SECTION",
        "ADDR64",
        "BRANCH19",
        "BRANCH14",
        "REL32",
    ];
    let (prefix, names) = match machine {
        IMAGE_FILE_MACHINE_AMD64 => ("AMD64", &AMD64[..]),
        _ => ("ARM64", &ARM64[..]),
    };
    match names.get(t as usize) {
        Some(n) => format!("IMAGE_REL_{prefix}_{n}"),
        None => format!("relocation type {t:#x}"),
    }
}

fn sign_extend(v: u32, bits: u32) -> i64 {
    ((v as i64) << (64 - bits)) >> (64 - bits)
}

/// An `IMAGE_REL_AMD64_*` relocation, its addend read from `field`.
fn map_amd64(t: u16, field: &[u8], target: &str, site: &str) -> Result<Mapped, C5Error> {
    let short = || {
        bad(&format!(
            "{site}: relocation field runs past section content"
        ))
    };
    let i32_at = || -> Result<i64, C5Error> {
        Ok(i32::from_le_bytes(field.get(..4).ok_or_else(short)?.try_into().unwrap()) as i64)
    };
    Ok(match t {
        IMAGE_REL_AMD64_ABSOLUTE => Mapped::Skip,
        IMAGE_REL_AMD64_ADDR64 => {
            let v = u64::from_le_bytes(field.get(..8).ok_or_else(short)?.try_into().unwrap());
            Mapped::Reloc(R_X86_64_64, v as i64)
        }
        IMAGE_REL_AMD64_ADDR32 => Mapped::Reloc(R_X86_64_32, i32_at()? as u32 as i64),
        IMAGE_REL_AMD64_ADDR32NB => Mapped::Reloc(R_PE_ADDR32NB, i32_at()?),
        IMAGE_REL_AMD64_REL32..=IMAGE_REL_AMD64_REL32_5 => {
            let past = (t - IMAGE_REL_AMD64_REL32) as i64;
            Mapped::Reloc(R_X86_64_PC32, i32_at()? - 4 - past)
        }
        IMAGE_REL_AMD64_SECREL => Mapped::SecRel(R_X86_64_TPOFF32, i32_at()?),
        other => {
            return Err(unsupported(&format!(
                "{site}: {} against `{target}` is not a relocation the linker translates",
                reloc_name(IMAGE_FILE_MACHINE_AMD64, other)
            )));
        }
    })
}

/// An `IMAGE_REL_ARM64_*` relocation. A data form's addend is its field;
/// an instruction form's is the immediate the instruction holds, in bytes
/// (an `adrp`'s too, as lld and link.exe read it), and the instruction
/// names the access size of an in-page offset.
fn map_arm64(t: u16, field: &[u8], target: &str, site: &str) -> Result<Mapped, C5Error> {
    let short = || {
        bad(&format!(
            "{site}: relocation field runs past section content"
        ))
    };
    let word = || -> Result<u32, C5Error> {
        Ok(u32::from_le_bytes(
            field.get(..4).ok_or_else(short)?.try_into().unwrap(),
        ))
    };
    let imm12 = |w: u32| ((w >> 10) & 0xFFF) as i64;
    let in_page = |w: u32, tprel: bool| -> Result<(u32, i64), C5Error> {
        let rtype = aarch64_lo12_rtype(w, tprel).ok_or_else(|| {
            bad(&format!(
                "{site}: {} patches instruction {w:#010x}, which is neither an `add` \
                 immediate nor a load / store",
                reloc_name(IMAGE_FILE_MACHINE_ARM64, t)
            ))
        })?;
        let scale = crate::c5::codegen::aarch64::patch::lo12_access_size(w).unwrap_or(1);
        Ok((rtype, imm12(w) * scale as i64))
    };
    Ok(match t {
        IMAGE_REL_ARM64_ABSOLUTE => Mapped::Skip,
        IMAGE_REL_ARM64_ADDR32 => Mapped::Reloc(R_AARCH64_ABS32, word()? as i64),
        IMAGE_REL_ARM64_ADDR32NB => Mapped::Reloc(R_PE_ADDR32NB, word()? as i32 as i64),
        IMAGE_REL_ARM64_ADDR64 => {
            let v = u64::from_le_bytes(field.get(..8).ok_or_else(short)?.try_into().unwrap());
            Mapped::Reloc(R_AARCH64_ABS64, v as i64)
        }
        IMAGE_REL_ARM64_REL32 => Mapped::Reloc(R_AARCH64_PREL32, word()? as i32 as i64 - 4),
        IMAGE_REL_ARM64_BRANCH26 => {
            let w = word()?;
            let rtype = if w & 0x8000_0000 != 0 {
                R_AARCH64_CALL26
            } else {
                R_AARCH64_JUMP26
            };
            Mapped::Reloc(rtype, sign_extend(w & 0x03FF_FFFF, 26) << 2)
        }
        IMAGE_REL_ARM64_BRANCH19 => {
            let w = word()?;
            // `ldr` (literal) shares the field with `b.cond`, `cbz` and `cbnz`.
            let rtype = if w & 0x3B00_0000 == 0x1800_0000 {
                R_AARCH64_LD_PREL_LO19
            } else {
                R_AARCH64_CONDBR19
            };
            Mapped::Reloc(rtype, sign_extend((w >> 5) & 0x7_FFFF, 19) << 2)
        }
        IMAGE_REL_ARM64_BRANCH14 => {
            let w = word()?;
            Mapped::Reloc(R_AARCH64_TSTBR14, sign_extend((w >> 5) & 0x3FFF, 14) << 2)
        }
        IMAGE_REL_ARM64_PAGEBASE_REL21 | IMAGE_REL_ARM64_REL21 => {
            let w = word()?;
            let imm = sign_extend(((w >> 3) & 0x1F_FFFC) | ((w >> 29) & 3), 21);
            let rtype = if t == IMAGE_REL_ARM64_REL21 {
                R_AARCH64_ADR_PREL_LO21
            } else {
                R_AARCH64_ADR_PREL_PG_HI21
            };
            Mapped::Reloc(rtype, imm)
        }
        IMAGE_REL_ARM64_PAGEOFFSET_12A => Mapped::Reloc(R_AARCH64_ADD_ABS_LO12_NC, imm12(word()?)),
        IMAGE_REL_ARM64_PAGEOFFSET_12L => {
            let (rtype, addend) = in_page(word()?, false)?;
            Mapped::Reloc(rtype, addend)
        }
        IMAGE_REL_ARM64_SECREL_HIGH12A => {
            Mapped::SecRel(R_AARCH64_TLSLE_ADD_TPREL_HI12, imm12(word()?) << 12)
        }
        IMAGE_REL_ARM64_SECREL_LOW12A => {
            Mapped::SecRel(R_AARCH64_TLSLE_ADD_TPREL_LO12_NC, imm12(word()?))
        }
        IMAGE_REL_ARM64_SECREL_LOW12L => {
            let (rtype, addend) = in_page(word()?, true)?;
            Mapped::SecRel(rtype, addend)
        }
        other => {
            return Err(unsupported(&format!(
                "{site}: {} against `{target}` is not a relocation the linker translates",
                reloc_name(IMAGE_FILE_MACHINE_ARM64, other)
            )));
        }
    })
}

/// The translated relocations of each patchable family and the init /
/// fini entries.
#[derive(Default)]
struct Relocs {
    text: Vec<NativeReloc>,
    relro: Vec<NativeReloc>,
    data: Vec<NativeReloc>,
    tls: Vec<NativeReloc>,
    init_funcs: Vec<NativeInitFunc>,
}

fn translate_relocs(
    bytes: &[u8],
    machine: u16,
    sects: &[Sect],
    raw: &[Option<RawSym>],
    symbols: &[NativeSymbol],
) -> Result<Relocs, C5Error> {
    let mut out = Relocs::default();
    let mut inits: Vec<(&str, u32, Vec<u64>)> = Vec::new();
    for s in sects {
        if (s.family == SectionFamily::Discard && s.init.is_none()) || s.nrelocs == 0 {
            continue;
        }
        let content = s.content(bytes)?;
        let base = s.reloc_off as usize;
        if (s.nrelocs as usize)
            .checked_mul(RELOCATION_SIZE)
            .and_then(|n| n.checked_add(base))
            .is_none_or(|e| e > bytes.len())
        {
            return Err(bad(&format!(
                "section `{}` relocation table runs past end of file",
                s.name
            )));
        }
        let mut entries = Vec::new();
        for k in 0..s.nrelocs as usize {
            let p = base + k * RELOCATION_SIZE;
            let at = u32le(bytes, p).unwrap();
            let sym = u32le(bytes, p + 4).unwrap() as usize;
            let t = u16le(bytes, p + 8).unwrap();
            let site = format!("section `{}` offset {at:#x}", s.name);
            let target = symbols
                .get(sym + 1)
                .filter(|_| raw.get(sym).is_some_and(Option::is_some))
                .ok_or_else(|| bad(&format!("{site}: relocation names no symbol")))?;
            let target_name = raw[sym].as_ref().map_or("", |r| r.name.as_str());
            let field = content.get(at as usize..).unwrap_or(&[]);
            let mapped = match machine {
                IMAGE_FILE_MACHINE_AMD64 => map_amd64(t, field, target_name, &site)?,
                _ => map_arm64(t, field, target_name, &site)?,
            };
            let offset = s.base + at as u64;
            let (rtype, addend) = match mapped {
                Mapped::Skip => continue,
                Mapped::Reloc(rtype, addend) => (rtype, addend),
                // The variable's offset in the TLS block, which the TEB
                // sequence adds to the block's base: its local-exec offset.
                Mapped::SecRel(rtype, addend)
                    if s.family == SectionFamily::Text
                        && matches!(
                            target.section,
                            NativeSymSection::Tls | NativeSymSection::Undef
                        ) =>
                {
                    (rtype, addend)
                }
                Mapped::SecRel(..) => {
                    return Err(unsupported(&format!(
                        "{site}: {} against `{target_name}` is not a thread-local access in code",
                        reloc_name(machine, t)
                    )));
                }
            };
            if s.init.is_some() {
                if !matches!(rtype, R_X86_64_64 | R_AARCH64_ABS64)
                    || target.section != NativeSymSection::Text
                {
                    return Err(unsupported(&format!(
                        "{site}: a constructor table entry must be the address of a function \
                         this object defines"
                    )));
                }
                entries.push((target.value as i64 + addend) as u64);
                continue;
            }
            let reloc = NativeReloc {
                offset,
                sym_idx: sym + 1,
                rtype,
                addend,
            };
            match s.family {
                SectionFamily::Text => out.text.push(reloc),
                SectionFamily::RelRo => out.relro.push(reloc),
                SectionFamily::Data => out.data.push(reloc),
                SectionFamily::Tdata => out.tls.push(reloc),
                _ => {
                    return Err(bad(&format!(
                        "{site}: a relocation patches a section with no file content"
                    )));
                }
            }
        }
        if s.init.is_some() {
            inits.push((s.name.as_str(), s.base as u32, entries));
        }
    }
    // A name's `$` suffix orders its contributions; GNU runs `.ctors`
    // from its end.
    inits.sort_by(|a, b| a.0.cmp(b.0).then(a.1.cmp(&b.1)));
    for (name, _, mut entries) in inits {
        let (is_destructor, priority) = init_table(name).unwrap();
        if name.starts_with(".ctors") {
            entries.reverse();
        }
        out.init_funcs
            .extend(entries.into_iter().map(|unit_text_offset| NativeInitFunc {
                is_destructor,
                priority,
                unit_text_offset,
            }));
    }
    out.text.sort_by_key(|r| r.offset);
    out.relro.sort_by_key(|r| r.offset);
    out.data.sort_by_key(|r| r.offset);
    out.tls.sort_by_key(|r| r.offset);
    Ok(out)
}

/// A short-format import-library member (PE/COFF specification 7).
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ImportMember {
    pub machine: NativeMachine,
    pub symbol: String,
    pub dll: String,
    pub import_name: String,
    /// `IMPORT_OBJECT_DATA` / `_CONST`: reached through `__imp_<symbol>` only.
    pub data: bool,
}

/// True when `bytes` is a short-format import member (`IMPORT_OBJECT_HEADER`).
pub fn is_coff_import_member(bytes: &[u8]) -> bool {
    u16le(bytes, 0) == Some(0) && u16le(bytes, 2) == Some(0xFFFF) && u16le(bytes, 4) == Some(0)
}

/// Read a short-format import member. The name type decides the name the DLL
/// is asked for: the symbol's, without a leading `?`, `@` or `_`, that without
/// its `@` decoration, or a stated one; an import by ordinal is refused.
pub fn parse_import_member(bytes: &[u8]) -> Result<ImportMember, C5Error> {
    let machine = match need_u16(bytes, 6, "import header")? {
        IMAGE_FILE_MACHINE_AMD64 => NativeMachine::X86_64,
        IMAGE_FILE_MACHINE_ARM64 => NativeMachine::Aarch64,
        other => {
            return Err(unsupported(&format!(
                "import member for COFF machine {other:#06x}, which the linker does not read"
            )));
        }
    };
    let size = need_u32(bytes, 12, "import header")? as usize;
    let kinds = need_u16(bytes, 18, "import header")?;
    let names = bytes
        .get(20..20 + size)
        .ok_or_else(|| bad("import member names run past end of file"))?;
    let mut strings = names
        .split(|&b| b == 0)
        .map(|s| core::str::from_utf8(s).ok());
    let (Some(Some(symbol)), Some(Some(dll))) = (strings.next(), strings.next()) else {
        return Err(bad("import member names no symbol and DLL"));
    };
    let stripped = symbol
        .strip_prefix(|c| matches!(c, '?' | '@' | '_'))
        .unwrap_or(symbol);
    let import_name = match (kinds >> 2) & 7 {
        1 => symbol.to_string(),
        2 => stripped.to_string(),
        3 => stripped.split('@').next().unwrap_or(stripped).to_string(),
        4 => match strings.next() {
            Some(Some(n)) => n.to_string(),
            _ => return Err(bad("import member states no export name")),
        },
        _ => {
            return Err(unsupported(&format!(
                "`{symbol}` is imported from `{dll}` by ordinal, which the linker does not bind"
            )));
        }
    };
    Ok(ImportMember {
        machine,
        symbol: symbol.to_string(),
        dll: dll.to_string(),
        import_name,
        data: kinds & 3 != 0,
    })
}

/// The DLLs an import library's members name, as shared libraries exporting each
/// member's symbol and `__imp_` slot; a data import exports the slot only.
pub fn import_libraries(members: &[ImportMember]) -> Vec<super::object::SharedLibrary> {
    let mut libs: BTreeMap<&str, super::object::SharedLibrary> = BTreeMap::new();
    for m in members {
        let lib = libs
            .entry(m.dll.as_str())
            .or_insert_with(|| super::object::SharedLibrary {
                soname: m.dll.clone(),
                machine: m.machine,
                exports: Default::default(),
                data_exports: Default::default(),
                tls_exports: Default::default(),
                object_sizes: Default::default(),
                export_symbols: Default::default(),
                export_versions: Default::default(),
                references: Default::default(),
                protected_exports: Default::default(),
                from_image: true,
            });
        lib.exports.insert(m.symbol.clone());
        lib.exports.insert(format!("__imp_{}", m.symbol));
        if m.data {
            lib.data_exports.insert(m.symbol.clone());
        }
        if m.import_name != m.symbol {
            lib.export_symbols
                .insert(m.symbol.clone(), m.import_name.clone());
        }
    }
    libs.into_values().collect()
}

/// Parse a COFF relocatable into the linker's native object model.
pub fn parse_native_coff(bytes: &[u8]) -> Result<NativeObject, C5Error> {
    let h = read_header(bytes)?;
    let machine = match h.machine {
        IMAGE_FILE_MACHINE_AMD64 => NativeMachine::X86_64,
        IMAGE_FILE_MACHINE_ARM64 => NativeMachine::Aarch64,
        other => {
            return Err(unsupported(&format!(
                "COFF machine {other:#06x} is not IMAGE_FILE_MACHINE_AMD64 or \
                 IMAGE_FILE_MACHINE_ARM64"
            )));
        }
    };
    let mut sects = read_sections(bytes, &h)?;
    let raw = read_symbols(bytes, &h)?;
    let comdat = read_comdats(&raw, &sects, h.sym_size == 20);
    // An associative COMDAT section goes where the section it follows goes.
    let assoc: BTreeMap<usize, usize> = (comdat.iter().enumerate())
        .filter_map(|(k, c)| Some((k, c.as_ref()?.parent?)))
        .collect();
    // A constructor table is consumed as init / fini entries, whose array
    // the link materializes, rather than merged as bytes.
    for s in sects.iter_mut() {
        s.family = classify(s)?;
        s.init = init_table(&s.name).filter(|_| s.family != SectionFamily::Discard);
        if s.init.is_some() {
            s.family = SectionFamily::Discard;
        }
    }
    for (&k, &parent) in &assoc {
        let p = sects.get(parent);
        if p.is_none_or(|p| p.family == SectionFamily::Discard && p.init.is_none()) {
            sects[k].family = SectionFamily::Discard;
            sects[k].init = None;
        }
    }
    let directives = read_directives(bytes, &sects)?;
    let blobs = concat_families(bytes, &mut sects)?;
    let comdats = comdat_groups(&comdat, &sects);
    let mut alternate_names = directives.alternate_names.clone();
    let mut symbols = decode_symbols(&raw, &sects, &directives, &mut alternate_names)?;
    let relocs = translate_relocs(bytes, h.machine, &sects, &raw, &symbols)?;
    let pe_unwind = read_unwind(bytes, h.machine, &sects, &raw)?;
    // A forced reference archive selection resolves, as `ld -u` does.
    for name in &directives.includes {
        symbols.push(NativeSymbol {
            name: name.clone(),
            binding: STB_GLOBAL,
            ..null_symbol()
        });
    }
    let tls_symbols = symbols
        .iter()
        .filter(|s| s.section == NativeSymSection::Tls && s.binding != STB_LOCAL)
        .map(|s| (s.name.clone(), s.value, s.size))
        .collect();
    Ok(NativeObject {
        source: String::new(),
        sections: blobs.sections,
        discarded: blobs.discarded,
        exec_stack: false,
        machine,
        text: blobs.text,
        text_align: blobs.text_align,
        rodata: blobs.rodata,
        rodata_align: blobs.rodata_align,
        relro: blobs.relro,
        relro_align: blobs.relro_align,
        data: blobs.data,
        data_align: blobs.data_align,
        bss_size: blobs.bss_size,
        bss_align: blobs.bss_align,
        tls_data: blobs.tls,
        tls_relocs: relocs.tls,
        tls_bss_size: blobs.tbss_size,
        tls_align: blobs.tls_align,
        symbols,
        text_relocs: relocs.text,
        relro_relocs: relocs.relro,
        data_relocs: relocs.data,
        init_funcs: relocs.init_funcs,
        dylibs: Vec::new(),
        import_dylib_map: Vec::new(),
        exports: directives.exports.clone(),
        tls_index_fixups: Vec::new(),
        macho_tlv_descriptors: Vec::new(),
        macho_tlv_fixups: Vec::new(),
        tls_symbols,
        macho_tlv_descriptor_syms: Vec::new(),
        elf_tpoff_fixups: Vec::new(),
        copy_relocs: Vec::new(),
        prologue_ends: Vec::new(),
        early_returns: Vec::new(),
        extern_data_names: Vec::new(),
        alternate_names,
        comdats,
        default_libs: directives.default_libs.clone(),
        debug_info: Vec::new(),
        debug_abbrev: Vec::new(),
        debug_line: Vec::new(),
        debug_str: Vec::new(),
        debug_info_relocs: Vec::new(),
        debug_line_relocs: Vec::new(),
        debug_other: Vec::new(),
        compact_unwind: Vec::new(),
        eh_frame: None,
        pe_unwind,
    })
}

/// A COFF object assembled from its parts, for the reader's and the
/// linker's tests.
#[cfg(test)]
pub(crate) mod build {
    use alloc::vec::Vec;

    pub(crate) struct Sec {
        pub name: &'static str,
        pub flags: u32,
        pub content: Vec<u8>,
        /// `(offset, symbol index, type)`.
        pub relocs: Vec<(u32, u32, u16)>,
    }

    /// One symbol record and its auxiliary records.
    pub(crate) struct Sym {
        pub name: &'static str,
        pub value: u32,
        pub section: i16,
        pub typ: u16,
        pub class: u8,
        pub aux: Vec<[u8; 18]>,
    }

    pub(crate) fn sec(name: &'static str, flags: u32, content: &[u8]) -> Sec {
        Sec {
            name,
            flags,
            content: content.to_vec(),
            relocs: Vec::new(),
        }
    }

    pub(crate) fn sym(name: &'static str, value: u32, section: i16, class: u8) -> Sym {
        Sym {
            name,
            value,
            section,
            typ: 0,
            class,
            aux: Vec::new(),
        }
    }

    /// A section-definition symbol's auxiliary record.
    pub(crate) fn section_aux(len: u32, assoc: u16, selection: u8) -> [u8; 18] {
        let mut a = [0u8; 18];
        a[..4].copy_from_slice(&len.to_le_bytes());
        a[12..14].copy_from_slice(&assoc.to_le_bytes());
        a[14] = selection;
        a
    }

    /// A weak external's auxiliary record.
    pub(crate) fn weak_aux(tag: u32, search: u32) -> [u8; 18] {
        let mut a = [0u8; 18];
        a[..4].copy_from_slice(&tag.to_le_bytes());
        a[4..8].copy_from_slice(&search.to_le_bytes());
        a
    }

    pub(crate) fn object(machine: u16, secs: &[Sec], syms: &[Sym]) -> Vec<u8> {
        let mut strtab: Vec<u8> = alloc::vec![0; 4];
        let mut name8 = |name: &str, section: bool| -> [u8; 8] {
            let mut f = [0u8; 8];
            if name.len() <= 8 {
                f[..name.len()].copy_from_slice(name.as_bytes());
                return f;
            }
            let off = strtab.len();
            strtab.extend_from_slice(name.as_bytes());
            strtab.push(0);
            if section {
                let s = alloc::format!("/{off}");
                f[..s.len()].copy_from_slice(s.as_bytes());
            } else {
                f[4..].copy_from_slice(&(off as u32).to_le_bytes());
            }
            f
        };
        let mut body = Vec::new();
        let base = 20 + 40 * secs.len();
        let mut headers = Vec::new();
        for s in secs {
            let raw = base + body.len();
            let bss = s.flags & super::IMAGE_SCN_CNT_UNINITIALIZED_DATA != 0;
            if !bss {
                body.extend_from_slice(&s.content);
            }
            let rel = base + body.len();
            for &(at, sym, t) in &s.relocs {
                body.extend_from_slice(&at.to_le_bytes());
                body.extend_from_slice(&sym.to_le_bytes());
                body.extend_from_slice(&t.to_le_bytes());
            }
            let mut h = Vec::new();
            h.extend_from_slice(&name8(s.name, true));
            h.extend_from_slice(&[0; 8]);
            h.extend_from_slice(&(s.content.len() as u32).to_le_bytes());
            h.extend_from_slice(&(if bss { 0 } else { raw as u32 }).to_le_bytes());
            h.extend_from_slice(&(rel as u32).to_le_bytes());
            h.extend_from_slice(&[0; 4]);
            h.extend_from_slice(&(s.relocs.len() as u16).to_le_bytes());
            h.extend_from_slice(&[0; 2]);
            h.extend_from_slice(&s.flags.to_le_bytes());
            headers.push(h);
        }
        let symtab = base + body.len();
        let mut nsyms = 0u32;
        for s in syms {
            body.extend_from_slice(&name8(s.name, false));
            body.extend_from_slice(&s.value.to_le_bytes());
            body.extend_from_slice(&s.section.to_le_bytes());
            body.extend_from_slice(&s.typ.to_le_bytes());
            body.push(s.class);
            body.push(s.aux.len() as u8);
            for a in &s.aux {
                body.extend_from_slice(a);
            }
            nsyms += 1 + s.aux.len() as u32;
        }
        let len = strtab.len() as u32;
        strtab[..4].copy_from_slice(&len.to_le_bytes());
        body.extend_from_slice(&strtab);
        let mut o = Vec::new();
        o.extend_from_slice(&machine.to_le_bytes());
        o.extend_from_slice(&(secs.len() as u16).to_le_bytes());
        o.extend_from_slice(&[0; 4]);
        o.extend_from_slice(&(symtab as u32).to_le_bytes());
        o.extend_from_slice(&nsyms.to_le_bytes());
        o.extend_from_slice(&[0; 4]);
        for h in headers {
            o.extend_from_slice(&h);
        }
        o.extend_from_slice(&body);
        o
    }
}

#[cfg(test)]
mod tests {
    use super::build::{Sec, object, sec, section_aux, sym, weak_aux};
    use super::*;

    const TEXT: u32 = IMAGE_SCN_CNT_CODE | IMAGE_SCN_MEM_EXECUTE | 0x0050_0000;
    const RDATA: u32 = IMAGE_SCN_CNT_INITIALIZED_DATA | 0x0040_0000;
    const DATA: u32 = IMAGE_SCN_CNT_INITIALIZED_DATA | IMAGE_SCN_MEM_WRITE | 0x0040_0000;
    const AMD64: u16 = IMAGE_FILE_MACHINE_AMD64;

    fn with(mut s: Sec, relocs: &[(u32, u32, u16)]) -> Sec {
        s.relocs = relocs.to_vec();
        s
    }

    fn parse(secs: &[Sec], syms: &[super::build::Sym]) -> Result<NativeObject, C5Error> {
        parse_native_coff(&object(AMD64, secs, syms))
    }

    /// `REL32_k` measures from `k` bytes past the field's end, which the
    /// psABI's `S + A - P` carries in the addend; an address keeps the
    /// field's value as its addend.
    #[test]
    fn each_amd64_form_keeps_the_field_value_as_its_addend() {
        let mut code = alloc::vec![0u8; 24];
        code[4..8].copy_from_slice(&8i32.to_le_bytes());
        code[12..16].copy_from_slice(&(-2i32).to_le_bytes());
        let mut table = alloc::vec![0u8; 12];
        table[..8].copy_from_slice(&16u64.to_le_bytes());
        table[8..12].copy_from_slice(&4u32.to_le_bytes());
        let o = parse(
            &[
                with(
                    sec(".text$mn", TEXT, &code),
                    &[(4, 1, 4), (12, 1, 5), (20, 1, 9)],
                ),
                with(sec(".rdata", RDATA, &table), &[(0, 0, 1), (8, 0, 3)]),
            ],
            &[
                sym("f", 0, 1, IMAGE_SYM_CLASS_EXTERNAL),
                sym("g", 0, 0, IMAGE_SYM_CLASS_EXTERNAL),
            ],
        )
        .unwrap();
        let text: Vec<_> = o
            .text_relocs
            .iter()
            .map(|r| (r.offset, r.rtype, r.addend))
            .collect();
        assert_eq!(
            text,
            [
                (4, R_X86_64_PC32, 4),
                (12, R_X86_64_PC32, -7),
                (20, R_X86_64_PC32, -9)
            ]
        );
        let ro: Vec<_> = o.relro_relocs.iter().map(|r| (r.rtype, r.addend)).collect();
        assert_eq!(
            ro,
            [(R_X86_64_64, 16), (R_PE_ADDR32NB, 4)],
            "relocated `.rdata` is relro"
        );
        assert_eq!(o.symbols[o.text_relocs[0].sym_idx].name, "g");
        assert_eq!(o.symbols[o.relro_relocs[0].sym_idx].name, "f");
    }

    /// A section-definition symbol is the section's start, which a
    /// relocation naming it plus the field's offset reaches; a symbol in a
    /// later section of the family takes that section's place in its blob.
    #[test]
    fn a_section_symbol_names_its_section_start() {
        let mut def = sym(".rdata", 0, 2, IMAGE_SYM_CLASS_STATIC);
        def.aux.push(section_aux(4, 0, 0));
        let rdata1 = IMAGE_SCN_CNT_INITIALIZED_DATA | 0x0010_0000;
        let o = parse(
            &[
                sec(".rdata", rdata1, b"abc"),
                sec(".rdata", rdata1, b"xyzw"),
                with(sec(".text", TEXT, &[0; 8]), &[(0, 0, 4)]),
            ],
            &[def, sym("s", 2, 2, IMAGE_SYM_CLASS_STATIC)],
        )
        .unwrap();
        let section = &o.symbols[1];
        assert_eq!(
            (section.name.as_str(), section.section),
            ("", NativeSymSection::RoData)
        );
        assert_eq!(
            section.value, 3,
            "the second `.rdata` follows the first's 3 bytes"
        );
        assert_eq!(o.symbols[3].value, 5);
        assert_eq!(o.rodata, b"abcxyzw");
    }

    /// A weak external stands for its default: a definition, address 0 (a
    /// weak reference) or another external, which the link takes when
    /// nothing defines the name.
    #[test]
    fn a_weak_external_takes_its_default() {
        let mut defined = sym("w", 0, 0, IMAGE_SYM_CLASS_WEAK_EXTERNAL);
        defined.aux.push(weak_aux(0, 3));
        let mut zero = sym("z", 0, 0, IMAGE_SYM_CLASS_WEAK_EXTERNAL);
        zero.aux.push(weak_aux(3, 3));
        let mut alias = sym("a", 0, 0, IMAGE_SYM_CLASS_WEAK_EXTERNAL);
        alias.aux.push(weak_aux(8, 2));
        let o = parse(
            &[sec(".text", TEXT, &[0xC3; 4])],
            &[
                sym(".weak.w.default", 2, 1, IMAGE_SYM_CLASS_EXTERNAL),
                defined,
                sym(".weak.z.default", 0, -1, IMAGE_SYM_CLASS_EXTERNAL),
                zero,
                alias,
                sym("target", 0, 0, IMAGE_SYM_CLASS_EXTERNAL),
            ],
        )
        .unwrap();
        let w = &o.symbols[2];
        assert_eq!(
            (w.name.as_str(), w.section, w.value, w.binding),
            ("w", NativeSymSection::Text, 2, STB_WEAK)
        );
        let z = &o.symbols[5];
        assert_eq!((z.section, z.binding), (NativeSymSection::Undef, STB_WEAK));
        assert_eq!(o.symbols[7].binding, STB_GLOBAL);
        assert_eq!(o.alternate_names, [("a".to_string(), "target".to_string())]);
    }

    /// `.drectve`: `/alternatename:` names a stand-in, `-aligncomm:` a
    /// common symbol's alignment; an option the linker does not carry out
    /// is refused by name.
    #[test]
    fn directives_name_stand_ins_and_common_alignment() {
        let drectve = IMAGE_SCN_LNK_INFO | IMAGE_SCN_LNK_REMOVE;
        let text = b"   /DEFAULTLIB:\"LIBCMT\" /alternatename:__isa=__isa_default -aligncomm:c,4";
        let o = parse(
            &[sec(".drectve", drectve, text)],
            &[sym("c", 3, 0, IMAGE_SYM_CLASS_EXTERNAL)],
        )
        .unwrap();
        assert_eq!(
            o.alternate_names,
            [("__isa".to_string(), "__isa_default".to_string())]
        );
        let c = &o.symbols[1];
        assert_eq!(
            (c.section, c.size, c.value),
            (NativeSymSection::Common, 3, 16)
        );
        assert_eq!(o.discarded, [(".drectve".to_string(), text.len() as u64)]);
        for refused in ["/MERGE:.a=.b", "/EXPORT:f,@1,NONAME", "/EXPORT:f=g"] {
            let err = parse(&[sec(".drectve", drectve, refused.as_bytes())], &[]).unwrap_err();
            assert!(err.to_string().contains(&format!("`{refused}`")), "{err}");
        }
    }

    /// `/EXPORT:`, `-export:` (gcc quotes the name), `/INCLUDE:` and `/DEFAULTLIB:`
    /// reach the link, whatever the section's flags.
    #[test]
    fn directives_export_include_and_name_libraries() {
        // GNU as gives `.drectve` the flags of writable data.
        let gnu_as = DATA;
        let text = b" /INCLUDE:forced /DEFAULTLIB:\"user32\" /EXPORT:f /EXPORT:d,DATA \
                     -export:\"g\",data /defaultlib:extra.lib";
        let o = parse(&[sec(".drectve", gnu_as, text)], &[]).unwrap();
        assert!(o.data.is_empty() && o.discarded.len() == 1);
        assert_eq!(o.exports, ["f", "d", "g"]);
        assert_eq!(o.default_libs, ["user32", "extra.lib"]);
        let forced = o.symbols.last().unwrap();
        assert_eq!(
            (forced.name.as_str(), forced.section, forced.binding),
            ("forced", NativeSymSection::Undef, STB_GLOBAL)
        );
    }

    /// An import member names its DLL and the name asked for; an ordinal is refused.
    #[test]
    fn import_members_name_their_dll_and_export() {
        let member = |kinds: u16, names: &[u8]| {
            let mut m = alloc::vec![0, 0, 0xFF, 0xFF, 0, 0];
            m.extend_from_slice(&AMD64.to_le_bytes());
            m.extend_from_slice(&[0; 4]);
            m.extend_from_slice(&(names.len() as u32).to_le_bytes());
            m.extend_from_slice(&[0; 2]);
            m.extend_from_slice(&kinds.to_le_bytes());
            m.extend_from_slice(names);
            m
        };
        let code = member(1 << 2, b"GetTickCount\0KERNEL32.dll\0");
        let data = member(1 | (3 << 2), b"_obj@4\0lib.dll\0");
        assert!(is_coff_import_member(&code) && !is_coff_object(&code));
        let (c, d) = (
            parse_import_member(&code).unwrap(),
            parse_import_member(&data).unwrap(),
        );
        assert_eq!(
            (c.dll.as_str(), c.import_name.as_str(), c.data),
            ("KERNEL32.dll", "GetTickCount", false)
        );
        assert_eq!(
            (d.symbol.as_str(), d.import_name.as_str(), d.data),
            ("_obj@4", "obj", true)
        );
        let libs = import_libraries(&[c, d]);
        let names: Vec<_> = libs.iter().map(|l| l.soname.as_str()).collect();
        assert_eq!(names, ["KERNEL32.dll", "lib.dll"]);
        assert!(libs[0].exports.contains("__imp_GetTickCount"));
        assert!(libs[1].data_exports.contains("_obj@4"));
        assert_eq!(libs[1].export_symbols["_obj@4"], "obj");
        let err = parse_import_member(&member(0, b"f\0a.dll\0"))
            .unwrap_err()
            .to_string();
        assert!(err.contains("by ordinal"), "{err}");
    }

    /// A common symbol without `-aligncomm` aligns to its size's power of
    /// two, at most 32, as link.exe and lld align one.
    #[test]
    fn a_common_symbol_takes_its_natural_alignment() {
        let o = parse(
            &[],
            &[
                sym("small", 6, 0, IMAGE_SYM_CLASS_EXTERNAL),
                sym("large", 100, 0, IMAGE_SYM_CLASS_EXTERNAL),
            ],
        )
        .unwrap();
        let aligns: Vec<_> = o.symbols[1..].iter().map(|s| (s.size, s.value)).collect();
        assert_eq!(aligns, [(6, 8), (100, 32)]);
    }

    /// The TEB sequence: `_tls_index` is read as the data object it is,
    /// `SECREL` of a variable is its local-exec offset.
    #[test]
    fn a_thread_local_access_takes_the_teb_model() {
        let tls = IMAGE_SCN_CNT_INITIALIZED_DATA | IMAGE_SCN_MEM_WRITE | 0x0030_0000;
        let mut code = alloc::vec![0x8B, 0x0D, 0, 0, 0, 0, 0x8B, 0x80];
        code.extend_from_slice(&4i32.to_le_bytes());
        code.extend_from_slice(&[0x8B, 0x80, 0, 0, 0, 0]);
        let o = parse(
            &[
                sec(".tls$", tls, &[1, 0, 0, 0, 2, 0, 0, 0]),
                with(
                    sec(".text", TEXT, &code),
                    &[(2, 1, 4), (8, 0, 0xB), (14, 2, 0xB)],
                ),
            ],
            &[
                sym("t", 0, 1, IMAGE_SYM_CLASS_EXTERNAL),
                sym("_tls_index", 0, 0, IMAGE_SYM_CLASS_EXTERNAL),
                sym("other", 0, 0, IMAGE_SYM_CLASS_EXTERNAL),
            ],
        )
        .unwrap();
        let tls: Vec<_> = (o.text_relocs.iter())
            .map(|r| {
                (
                    r.offset,
                    o.symbols[r.sym_idx].name.as_str(),
                    r.rtype,
                    r.addend,
                )
            })
            .collect();
        assert_eq!(
            tls,
            [
                (2, "_tls_index", R_X86_64_PC32, -4),
                (8, "t", R_X86_64_TPOFF32, 4),
                (14, "other", R_X86_64_TPOFF32, 0)
            ]
        );
        assert_eq!(o.tls_data, [1, 0, 0, 0, 2, 0, 0, 0]);
        assert_eq!(o.tls_symbols, [("t".to_string(), 0, 0)]);
    }

    /// GNU's `.ctors` and the C runtime's `.CRT$XCU` list constructors, each
    /// entry the address of a function; the link materializes the array.
    #[test]
    fn constructor_tables_become_init_entries() {
        let mut entry = alloc::vec![0u8; 8];
        entry[..8].copy_from_slice(&1u64.to_le_bytes());
        let o = parse(
            &[
                sec(".text", TEXT, &[0xC3; 4]),
                with(sec(".ctors", DATA, &entry), &[(0, 0, 1)]),
                with(sec(".CRT$XCU", RDATA, &[0; 8]), &[(0, 0, 1)]),
            ],
            &[sym(".text", 0, 1, IMAGE_SYM_CLASS_STATIC)],
        )
        .unwrap();
        let entries: Vec<_> = (o.init_funcs.iter())
            .map(|f| (f.is_destructor, f.unit_text_offset))
            .collect();
        assert_eq!(entries, [(false, 0), (false, 1)]);
        assert!(o.data.is_empty() && o.relro.is_empty());
    }

    /// Debug tables, `.pdata`, link-time metadata and an associative section
    /// whose parent is dropped carry nothing into the merged image; `.xdata`
    /// joins the read-only data its entries name.
    #[test]
    fn metadata_and_unwind_sections_are_dropped() {
        let comdat = RDATA | IMAGE_SCN_LNK_COMDAT;
        let mut x = sym(".xdata", 0, 3, IMAGE_SYM_CLASS_STATIC);
        x.aux.push(section_aux(4, 2, 0));
        let mut assoc = sym("$assoc", 0, 4, IMAGE_SYM_CLASS_STATIC);
        assoc.name = ".rdata";
        assoc
            .aux
            .push(section_aux(4, 2, IMAGE_COMDAT_SELECT_ASSOCIATIVE));
        let o = parse(
            &[
                sec(".debug$S", RDATA | IMAGE_SCN_MEM_DISCARDABLE, &[1; 4]),
                sec(".pdata", RDATA, &[2; 4]),
                sec(".xdata", RDATA, &[3; 4]),
                sec(".rdata", comdat, &[4; 4]),
                sec(".llvm_addrsig", IMAGE_SCN_LNK_REMOVE, &[]),
            ],
            &[x, assoc],
        )
        .unwrap();
        let dropped: Vec<_> = o.discarded.iter().map(|(n, _)| n.as_str()).collect();
        assert_eq!(dropped, [".debug$S", ".pdata", ".rdata", ".llvm_addrsig"]);
        assert_eq!(o.rodata, [3; 4]);
    }

    /// A form the linker has no translation for, and a machine it does not
    /// read, are refused by name.
    #[test]
    fn unsupported_forms_are_refused_by_name() {
        let err = parse(
            &[with(sec(".text", TEXT, &[0; 8]), &[(0, 0, 0xA)])],
            &[sym("s", 0, 0, IMAGE_SYM_CLASS_EXTERNAL)],
        )
        .unwrap_err()
        .to_string();
        assert!(err.contains("IMAGE_REL_AMD64_SECTION against `s`"), "{err}");
        assert!(err.ends_with("[B4001] [unsupported]"), "{err}");
        let err = parse_native_coff(&object(0x014C, &[], &[]))
            .unwrap_err()
            .to_string();
        assert!(err.contains("COFF machine 0x014c"), "{err}");
        assert!(!is_coff_object(&object(0x014C, &[], &[])));
        assert!(is_coff_object(&object(AMD64, &[], &[])));
    }

    /// arm64 keeps an instruction form's addend in its immediate, in bytes
    /// (an `adrp`'s too); a branch's form follows its opcode, an in-page
    /// offset's its access size, and `SECREL` of a thread-local takes the
    /// local-exec form.
    #[test]
    fn each_arm64_form_reads_its_addend_from_the_instruction() {
        let words: [u32; 10] = [
            0x9400_0002,                        // bl .+8: BRANCH26
            0x1400_0000,                        // b: BRANCH26
            0x9000_0008 | (2 << 29) | (1 << 5), // adrp x8, sym+6
            0xF940_0508,                        // ldr x8, [x8, #8]: PAGEOFFSET_12L
            0x3940_0508,                        // ldrb w8, [x8, #1]
            0x5400_0040,                        // b.eq .+8: BRANCH19
            0x3600_0040,                        // tbz w0, #0, .+8: BRANCH14
            0x9140_0108,                        // add x8, x8, #0, lsl #12: SECREL_HIGH12A
            0xB940_0109,                        // ldr w9, [x8, #0]: SECREL_LOW12L
            0,                                  // REL32
        ];
        let code: Vec<u8> = words.iter().flat_map(|w| w.to_le_bytes()).collect();
        let relocs = [
            (0, 0, 0x3),
            (4, 0, 0x3),
            (8, 0, 0x4),
            (12, 0, 0x7),
            (16, 0, 0x7),
            (20, 0, 0xF),
            (24, 0, 0x10),
            (28, 1, 0xA),
            (32, 1, 0xB),
            (36, 0, 0x11),
        ];
        let tls = IMAGE_SCN_CNT_INITIALIZED_DATA | IMAGE_SCN_MEM_WRITE | 0x0030_0000;
        let o = parse_native_coff(&object(
            IMAGE_FILE_MACHINE_ARM64,
            &[
                with(sec(".text", TEXT, &code), &relocs),
                sec(".tls$", tls, &[0; 4]),
            ],
            &[
                sym("f", 0, 0, IMAGE_SYM_CLASS_EXTERNAL),
                sym("t", 0, 2, IMAGE_SYM_CLASS_EXTERNAL),
            ],
        ))
        .unwrap();
        use crate::c5::object::elf_reloc_types::*;
        let got: Vec<_> = o.text_relocs.iter().map(|r| (r.rtype, r.addend)).collect();
        assert_eq!(
            got,
            [
                (R_AARCH64_CALL26, 8),
                (R_AARCH64_JUMP26, 0),
                (R_AARCH64_ADR_PREL_PG_HI21, 6),
                (R_AARCH64_LDST64_ABS_LO12_NC, 8),
                (R_AARCH64_LDST8_ABS_LO12_NC, 1),
                (R_AARCH64_CONDBR19, 8),
                (R_AARCH64_TSTBR14, 8),
                (R_AARCH64_TLSLE_ADD_TPREL_HI12, 0),
                (R_AARCH64_TLSLE_LDST32_TPREL_LO12_NC, 0),
                (R_AARCH64_PREL32, -4),
            ]
        );
    }

    /// A COMDAT section and its associative ones form a group keyed by its first
    /// external symbol; a static leader forms none.
    #[test]
    fn comdat_sections_group_under_their_leader() {
        let comdat = IMAGE_SCN_LNK_COMDAT;
        let def = |name, n: i16, aux| {
            let mut s = sym(name, 0, n, IMAGE_SYM_CLASS_STATIC);
            s.aux.push(aux);
            s
        };
        let o = parse(
            &[
                sec(".text$mn", TEXT | comdat, &[0xC3; 4]),
                sec(".rdata", RDATA | comdat, &[1; 8]),
                sec(".rdata", RDATA | comdat, &[2; 8]),
                sec(".rdata$a", RDATA | comdat, &[3; 4]),
            ],
            &[
                def(".text$mn", 1, section_aux(4, 0, 1)),
                def(".rdata", 2, section_aux(8, 0, 2)),
                def(".rdata", 3, section_aux(8, 0, 2)),
                def(
                    ".rdata$a",
                    4,
                    section_aux(4, 2, IMAGE_COMDAT_SELECT_ASSOCIATIVE),
                ),
                sym("f", 0, 1, IMAGE_SYM_CLASS_EXTERNAL),
                sym("__real@1", 0, 2, IMAGE_SYM_CLASS_EXTERNAL),
                sym("local", 0, 3, IMAGE_SYM_CLASS_STATIC),
            ],
        )
        .unwrap();
        let groups: Vec<_> = (o.comdats.iter())
            .map(|g| (g.key.as_str(), g.selection, g.size, g.sections.clone()))
            .collect();
        // `.rdata$a` joins `.rdata` #2's group; `.rdata` #3's static leader forms none.
        assert_eq!(
            groups,
            [
                ("f", 1, 4, alloc::vec![0]),
                ("__real@1", 2, 8, alloc::vec![1, 3])
            ]
        );
    }

    /// `.pdata` entries name their function and their unwind data or arm64
    /// packed word.
    #[test]
    fn pdata_entries_name_their_function_and_unwind_data() {
        let pdata = |relocs: &[(u32, u32, u16)], content: &[u8]| {
            with(sec(".pdata", RDATA, content), relocs)
        };
        let o = parse(
            &[
                sec(".text", TEXT, &[0xC3; 16]),
                sec(".xdata", RDATA, &[1, 0, 0, 0]),
                pdata(
                    &[(0, 0, 3), (4, 0, 3), (8, 1, 3)],
                    &[0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0],
                ),
            ],
            &[
                sym("f", 0, 1, IMAGE_SYM_CLASS_EXTERNAL),
                sym("$x", 0, 2, IMAGE_SYM_CLASS_STATIC),
            ],
        )
        .unwrap();
        assert_eq!(
            o.pe_unwind,
            [PeUnwindEntry {
                begin: (1, 0),
                end: Some((1, 16)),
                data: PeUnwindData::Info((2, 0)),
            }]
        );
        let packed = 0x0020_0019u32.to_le_bytes();
        let mut words = alloc::vec![0u8; 8];
        words.extend_from_slice(&[0, 0, 0, 0]);
        words.extend_from_slice(&packed);
        let o = parse_native_coff(&object(
            IMAGE_FILE_MACHINE_ARM64,
            &[
                sec(".text", TEXT, &[0; 16]),
                sec(".xdata", RDATA, &[4, 0, 0, 0]),
                pdata(&[(0, 0, 2), (4, 1, 2), (8, 0, 2)], &words),
            ],
            &[
                sym("f", 0, 1, IMAGE_SYM_CLASS_EXTERNAL),
                sym("$x", 0, 2, IMAGE_SYM_CLASS_STATIC),
            ],
        ))
        .unwrap();
        let data: Vec<_> = o.pe_unwind.iter().map(|e| e.data).collect();
        assert_eq!(
            data,
            [
                PeUnwindData::Info((2, 0)),
                PeUnwindData::Packed(0x0020_0019)
            ]
        );
    }

    /// A section name past eight bytes is a `/<offset>` into the string
    /// table; a bigobj header widens section numbers to 32 bits.
    #[test]
    fn long_names_and_the_bigobj_header_parse() {
        let o = parse(&[sec(".rdata$zzzzzz", RDATA, b"id")], &[]).unwrap();
        assert_eq!(o.sections[0].name, ".rdata$zzzzzz");
        let mut big = alloc::vec![0u8, 0, 0xFF, 0xFF, 2, 0];
        big.extend_from_slice(&AMD64.to_le_bytes());
        big.extend_from_slice(&[0; 4]);
        big.extend_from_slice(&BIGOBJ_CLASS_ID);
        big.extend_from_slice(&[0; 16]);
        big.extend_from_slice(&1u32.to_le_bytes()); // NumberOfSections
        big.extend_from_slice(&96u32.to_le_bytes()); // PointerToSymbolTable
        big.extend_from_slice(&1u32.to_le_bytes()); // NumberOfSymbols
        big.extend_from_slice(b".text\0\0\0");
        big.extend_from_slice(&[0; 8]);
        big.extend_from_slice(&0u32.to_le_bytes());
        big.extend_from_slice(&[0; 16]);
        big.extend_from_slice(&TEXT.to_le_bytes());
        big.extend_from_slice(b"f\0\0\0\0\0\0\0");
        big.extend_from_slice(&0u32.to_le_bytes());
        big.extend_from_slice(&1i32.to_le_bytes());
        big.extend_from_slice(&[0x20, 0, IMAGE_SYM_CLASS_EXTERNAL, 0]);
        big.extend_from_slice(&4u32.to_le_bytes());
        assert!(is_coff_object(&big));
        let o = parse_native_coff(&big).unwrap();
        assert_eq!(
            (o.symbols[1].name.as_str(), o.symbols[1].kind),
            ("f", STT_FUNC)
        );
    }
}

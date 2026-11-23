//! GNU-ld-style link map (`-Map=FILE` / `--print-map`).
//!
//! Renders the map from the linker's per-input-section records
//! ([`MergedNative::section_map`]), the image writer's placement of each
//! stream, and the section table of the emitted ELF, PE or Mach-O image,
//! so every printed address is the image's own. Layout and column conventions follow GNU ld's map
//! ("Options -M/--print-map"): the archive-member table, discarded
//! input sections, the default memory configuration, and per output
//! section the input contributions with `*fill*` rows and global
//! symbol definitions. Content badc's linker does not have (linker-
//! script echo, non-default memory regions) is omitted, not faked.

#![cfg(feature = "std")]

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use crate::c5::diag::Code;
use crate::c5::error::C5Error;

use super::link::{MergedNative, SectionContribution};
use super::object::{
    Elf32Ehdr, Elf32Shdr, Elf64Ehdr, Elf64Shdr, ElfClass, NativeSymSection, read_struct,
    section_slice,
};

const EM_386: u16 = 3;
const EM_X86_64: u16 = 62;
const EM_AARCH64: u16 = 183;

/// One archive member pulled into the link, mirroring ld's "Archive
/// member included to satisfy reference by file (symbol)" table.
#[derive(Debug, Clone)]
pub struct ArchiveInclusion {
    /// Member label, `lib.a(member.o)`.
    pub member: String,
    /// Input whose unresolved reference pulled the member.
    pub referenced_by: String,
    /// The symbol that resolved.
    pub symbol: String,
}

/// The map pads section names to this column before the address.
const NAME_COL: usize = 16;

struct OutSec {
    name: String,
    addr: u64,
    size: u64,
}

/// One printed input-section row: an absolute address range with the
/// input section name and its origin label.
struct Row {
    addr: u64,
    size: u64,
    name: String,
    source: String,
}

/// Render the link map for `image`, an ELF64 executable or shared
/// library produced from `merged`. `output_name` feeds the trailing
/// `OUTPUT(...)` line.
pub fn render_link_map(
    merged: &MergedNative,
    image: &crate::c5::object::NativeImage,
    archive_inclusions: &[ArchiveInclusion],
    output_name: &str,
) -> Result<String, C5Error> {
    use crate::c5::object::data_region_addr;
    let sections = image_sections(&image.image)?;
    let p = &image.placement;
    let sm = &merged.section_map;
    // Empty labels come from callers that never set NativeObject::source.
    let labels: Vec<String> = sm
        .sources
        .iter()
        .enumerate()
        .map(|(i, s)| {
            if s.is_empty() {
                format!("<input {i}>")
            } else {
                s.clone()
            }
        })
        .collect();
    let label_of = |input: &Option<usize>| -> String {
        match input {
            Some(i) => labels
                .get(*i)
                .cloned()
                .unwrap_or_else(|| format!("<input {i}>")),
            None => "<internal>".to_string(),
        }
    };

    // Each input's contribution at the address the writer placed its
    // stream's bytes; a section lists those that fall in it.
    let row = |c: &SectionContribution, addr: u64| Row {
        addr,
        size: c.size,
        name: c.name.clone(),
        source: label_of(&c.input),
    };
    let mut rows: Vec<Row> = Vec::new();
    if let Some((start, end)) = p.stub {
        rows.push(Row {
            addr: start,
            size: end - start,
            name: ".stub".to_string(),
            source: "<internal>".to_string(),
        });
    }
    rows.extend(sm.text.iter().map(|c| row(c, p.text + c.offset)));
    rows.extend((sm.data.iter()).map(|c| row(c, data_region_addr(&p.data, c.offset))));
    if let Some(bss) = p.bss {
        rows.extend(sm.bss.iter().map(|c| row(c, bss + c.offset)));
    }
    if let Some(tls) = p.tls {
        rows.extend(sm.tls.iter().map(|c| row(c, tls + c.offset)));
    }
    rows.sort_by_key(|r| r.addr);

    // Global symbol definitions by address (ties keep the defined table's
    // name order). ld lists globals only.
    let mut syms: Vec<(u64, &str)> = Vec::new();
    for (name, sym) in &merged.defined {
        let addr = match sym.section {
            NativeSymSection::Text => p.text + sym.value,
            NativeSymSection::Data => data_region_addr(&p.data, sym.value),
            NativeSymSection::Bss => match p.bss {
                Some(bss) => bss + sym.value,
                None => continue,
            },
            _ => continue,
        };
        syms.push((addr, name.as_str()));
    }
    syms.sort_by_key(|&(addr, _)| addr);

    let mut out = String::new();

    if !archive_inclusions.is_empty() {
        out.push_str("Archive member included to satisfy reference by file (symbol)\n\n");
        for a in archive_inclusions {
            out.push_str(&a.member);
            if a.member.len() >= 29 {
                out.push('\n');
                out.push_str(&" ".repeat(30));
            } else {
                out.push_str(&" ".repeat(30 - a.member.len()));
            }
            out.push_str(&format!("{} ({})\n", a.referenced_by, a.symbol));
        }
        out.push('\n');
    }

    if !sm.discarded.is_empty() {
        out.push_str("Discarded input sections\n\n");
        for (input, name, size) in &sm.discarded {
            push_columns(&mut out, &format!(" {name}"), 0, *size);
            out.push(' ');
            out.push_str(&label_of(&Some(*input)));
            out.push('\n');
        }
        out.push('\n');
    }

    out.push_str("Memory Configuration\n\n");
    out.push_str("Name             Origin             Length             Attributes\n");
    out.push_str("*default*        0x0000000000000000 0xffffffffffffffff\n\n");

    out.push_str("Linker script and memory map\n\n");
    for label in &labels {
        out.push_str(&format!("LOAD {label}\n"));
    }
    if !labels.is_empty() {
        out.push('\n');
    }

    for sec in &sections {
        // Symbol / string / section-name tables are file metadata a
        // linker script never places; ld's map omits them.
        if matches!(sec.name.as_str(), ".symtab" | ".strtab" | ".shstrtab") {
            continue;
        }
        let within = |addr: u64| addr >= sec.addr && addr < sec.addr + sec.size;
        let in_rows: Vec<Row> = (rows.iter())
            .filter(|r| within(r.addr))
            .map(|r| Row {
                addr: r.addr,
                size: r.size,
                name: r.name.clone(),
                source: r.source.clone(),
            })
            .collect();
        let in_syms: Vec<(u64, &str)> = syms.iter().copied().filter(|&(a, _)| within(a)).collect();
        render_section(&mut out, sec, in_rows, &in_syms);
        out.push('\n');
    }

    out.push_str(&format!("OUTPUT({output_name} {})\n", p.format));
    Ok(out)
}

/// Print one output section: the header row, then each contribution
/// with the symbols it holds, with `*fill*` rows over the gaps.
fn render_section(out: &mut String, sec: &OutSec, rows: Vec<Row>, syms: &[(u64, &str)]) {
    push_columns(out, &sec.name, sec.addr, sec.size);
    out.push('\n');
    let end = sec.addr + sec.size;
    let mut cursor = sec.addr;
    let mut next_sym = 0usize;
    let flush_syms = |out: &mut String, next_sym: &mut usize, upto: u64| {
        while *next_sym < syms.len() && syms[*next_sym].0 < upto {
            let (addr, name) = syms[*next_sym];
            out.push_str(&" ".repeat(NAME_COL));
            out.push_str(&format!("0x{addr:016x}"));
            out.push_str(&" ".repeat(NAME_COL));
            out.push_str(name);
            out.push('\n');
            *next_sym += 1;
        }
    };
    for (k, row) in rows.iter().enumerate() {
        flush_syms(out, &mut next_sym, row.addr);
        if row.addr > cursor {
            push_columns(out, " *fill*", cursor, row.addr - cursor);
            out.push_str(" \n");
        }
        push_columns(out, &format!(" {}", row.name), row.addr, row.size);
        out.push(' ');
        out.push_str(&row.source);
        out.push('\n');
        cursor = cursor.max(row.addr + row.size);
        let next_start = rows.get(k + 1).map(|r| r.addr).unwrap_or(end);
        flush_syms(out, &mut next_sym, next_start);
    }
    if !rows.is_empty() && cursor < end {
        push_columns(out, " *fill*", cursor, end - cursor);
        out.push_str(" \n");
    }
    flush_syms(out, &mut next_sym, u64::MAX);
}

/// The three-column `name address size` layout: the name
/// padded to column 16 (wrapping long names onto their own line), an
/// `0x%016x` address, the size right-aligned in 11 columns.
/// One input section placed into an output section by a relocatable
/// link: its offset within that output section, its size, and the
/// object it came from.
pub struct RelocRow {
    pub name: String,
    pub offset: u64,
    pub size: u64,
    pub source: String,
}

/// Render the `-Map` map of a relocatable link.
///
/// `-r` resolves no addresses, so the output section headers carry the
/// image's own `sh_addr` (zero) and `sh_size`, and each row sits at its
/// offset within the section, which attributes a section's bytes to the
/// object that contributed them.
pub fn render_relocatable_map(
    image: &[u8],
    inputs: &[String],
    rows_of: &[(String, Vec<RelocRow>)],
    output_name: &str,
) -> Result<String, C5Error> {
    let (sections, bfd_format) = parse_image_sections(image)?;
    let mut out = String::new();
    out.push_str("Linker script and memory map\n\n");
    for label in inputs {
        out.push_str(&format!("LOAD {label}\n"));
    }
    if !inputs.is_empty() {
        out.push('\n');
    }
    for sec in &sections {
        if matches!(sec.name.as_str(), "" | ".symtab" | ".strtab" | ".shstrtab") {
            continue;
        }
        push_columns(&mut out, &sec.name, sec.addr, sec.size);
        out.push('\n');
        let Some((_, rows)) = rows_of.iter().find(|(n, _)| *n == sec.name) else {
            continue;
        };
        for r in rows {
            push_columns(
                &mut out,
                &format!(" {}", r.name),
                sec.addr + r.offset,
                r.size,
            );
            out.push(' ');
            out.push_str(&r.source);
            out.push('\n');
        }
    }
    out.push_str(&format!("OUTPUT({output_name} {bfd_format})\n"));
    Ok(out)
}

fn push_columns(out: &mut String, name: &str, addr: u64, size: u64) {
    out.push_str(name);
    if name.len() >= NAME_COL - 1 {
        out.push('\n');
        out.push_str(&" ".repeat(NAME_COL));
    } else {
        out.push_str(&" ".repeat(NAME_COL - name.len()));
    }
    out.push_str(&format!("0x{addr:016x}"));
    out.push_str(&format!("{:>11}", format!("0x{size:x}")));
}

/// Read the image's section table: `(name, sh_addr, sh_size)` in file
/// order plus the BFD format name for the `OUTPUT(...)` line.
fn parse_image_sections(image: &[u8]) -> Result<(Vec<OutSec>, &'static str), C5Error> {
    let class = (image.len() >= 6 && &image[0..4] == b"\x7fELF" && image[5] == 1)
        .then(|| ElfClass::from_ei_class(image[4]))
        .flatten();
    let Some(class) = class else {
        return Err(map_err(
            "the output image is not a little-endian ELF; \
             the link map is produced for ELF output only",
        ));
    };
    let ehdr: Elf64Ehdr = match class {
        ElfClass::Elf32 => read_struct::<Elf32Ehdr>(image, 0)?.into(),
        ElfClass::Elf64 => read_struct(image, 0)?,
    };
    let bfd_format = match (class, ehdr.e_machine) {
        (_, EM_X86_64) => "elf64-x86-64",
        (_, EM_AARCH64) => "elf64-littleaarch64",
        (_, EM_386) => "elf32-i386",
        (_, other) => {
            return Err(map_err(&format!(
                "unsupported e_machine {}",
                super::relocatable::elf_machine_desc(other)
            )));
        }
    };
    let shoff = ehdr.e_shoff as usize;
    let shentsize = ehdr.e_shentsize as usize;
    if shentsize as u64 != class.shdr_size() {
        return Err(map_err(&format!(
            "section header entry size {shentsize} is not {}",
            class.shdr_size(),
        )));
    }
    let mut shdrs: Vec<Elf64Shdr> = Vec::with_capacity(ehdr.e_shnum as usize);
    for i in 0..ehdr.e_shnum as usize {
        shdrs.push(match class {
            ElfClass::Elf32 => read_struct::<Elf32Shdr>(image, shoff + i * shentsize)?.into(),
            ElfClass::Elf64 => read_struct(image, shoff + i * shentsize)?,
        });
    }
    let shstrtab = shdrs
        .get(ehdr.e_shstrndx as usize)
        .ok_or_else(|| map_err("e_shstrndx past the section table"))?;
    let names = section_slice(image, shstrtab)?;
    let mut sections = Vec::with_capacity(shdrs.len().saturating_sub(1));
    for sh in shdrs.iter().skip(1) {
        sections.push(OutSec {
            name: super::object::strtab_str(names, sh.sh_name as usize)?.to_string(),
            addr: sh.sh_addr,
            size: sh.sh_size,
        });
    }
    Ok((sections, bfd_format))
}

/// The output image's sections in file order, whichever its format: the
/// ELF section headers, the PE section table at the image base, the
/// sections of each Mach-O `LC_SEGMENT_64` named `segment,section`.
fn image_sections(image: &[u8]) -> Result<Vec<OutSec>, C5Error> {
    let u16_at = |o: usize| {
        image
            .get(o..o + 2)
            .map(|b| u16::from_le_bytes([b[0], b[1]]))
    };
    let u32_at =
        |o: usize| (image.get(o..o + 4)).map(|b| u32::from_le_bytes(b.try_into().unwrap()));
    let u64_at =
        |o: usize| (image.get(o..o + 8)).map(|b| u64::from_le_bytes(b.try_into().unwrap()));
    let name_at = |o: usize, n: usize| {
        image.get(o..o + n).map(|b| {
            let end = b.iter().position(|&c| c == 0).unwrap_or(n);
            String::from_utf8_lossy(&b[..end]).into_owned()
        })
    };
    let truncated = || map_err("the image's section table is truncated");
    if image.starts_with(b"MZ") {
        let pe = u32_at(0x3c).ok_or_else(truncated)? as usize;
        let count = u16_at(pe + 6).ok_or_else(truncated)? as usize;
        let optional = pe + 24;
        let table = optional + u16_at(pe + 20).ok_or_else(truncated)? as usize;
        let image_base = u64_at(optional + 24).ok_or_else(truncated)?;
        return (0..count)
            .map(|k| {
                let h = table + 40 * k;
                Some(OutSec {
                    name: name_at(h, 8)?,
                    addr: image_base + u64::from(u32_at(h + 12)?),
                    size: u64::from(u32_at(h + 8)?),
                })
            })
            .collect::<Option<Vec<_>>>()
            .ok_or_else(truncated);
    }
    if u32_at(0) == Some(0xfeed_facf) {
        let ncmds = u32_at(16).ok_or_else(truncated)?;
        let mut at = 32;
        let mut sections = Vec::new();
        for _ in 0..ncmds {
            let (cmd, size) = (
                u32_at(at).ok_or_else(truncated)?,
                u32_at(at + 4).ok_or_else(truncated)?,
            );
            if cmd == 0x19 {
                let nsects = u32_at(at + 64).ok_or_else(truncated)? as usize;
                for k in 0..nsects {
                    let h = at + 72 + 80 * k;
                    let (sect, seg) = (name_at(h, 16), name_at(h + 16, 16));
                    let (Some(sect), Some(seg), Some(addr), Some(size)) =
                        (sect, seg, u64_at(h + 32), u64_at(h + 40))
                    else {
                        return Err(truncated());
                    };
                    sections.push(OutSec {
                        name: format!("{seg},{sect}"),
                        addr,
                        size,
                    });
                }
            }
            at += size as usize;
        }
        return Ok(sections);
    }
    parse_image_sections(image).map(|(sections, _)| sections)
}

fn map_err(msg: &str) -> C5Error {
    C5Error::hard(Code::LINK, format!("link map: {msg}"))
}

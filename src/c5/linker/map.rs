//! GNU-ld-style link map (`-Map=FILE` / `--print-map`).
//!
//! Renders the map from two sources of truth: the linker's per-input-
//! section records ([`MergedNative::section_map`]) and the section
//! headers of the emitted ELF image, so every printed address is the
//! image's own. Layout and column conventions follow GNU ld's map
//! ("Options -M/--print-map"): the archive-member table, discarded
//! input sections, the default memory configuration, and per output
//! section the input contributions with `*fill*` rows and global
//! symbol definitions. Content badc's linker does not have (linker-
//! script echo, non-default memory regions) is omitted, not faked.

#![cfg(feature = "std")]

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

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

/// GNU ld pads section names to this column before the address.
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
    image: &[u8],
    archive_inclusions: &[ArchiveInclusion],
    output_name: &str,
) -> Result<String, C5Error> {
    let (sections, bfd_format) = parse_image_sections(image)?;
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

    // Stream base addresses. The `.text` section is the writer-emitted
    // entry stub followed by the merged text verbatim, so the stub's
    // length is the section size minus the stream length. The unified
    // data stream splits at `data_ro_len` / `data_relro_len`: the
    // read-only prefix backs `.rodata`, the relro region
    // `.data.rel.ro`, the remainder `.data`.
    let find = |name: &str| sections.iter().find(|s| s.name == name);
    let text_sec = find(".text").ok_or_else(|| map_err("image has no .text section"))?;
    let stream_len = merged.text.len() as u64;
    if text_sec.size < stream_len {
        return Err(map_err(&format!(
            ".text section (0x{:x} bytes) is smaller than the merged text (0x{stream_len:x} bytes)",
            text_sec.size,
        )));
    }
    let stub_len = text_sec.size - stream_len;
    let text_base = text_sec.addr + stub_len;
    let ro_len = merged.data_ro_len as u64;
    let relro_len = merged.data_relro_len as u64;
    let rodata_base = find(".rodata").map(|s| s.addr);
    // Each region's section holds the matching stream slice, so a
    // stream offset maps to `base + offset` with the preceding
    // regions' lengths folded in.
    let relro_base = find(".data.rel.ro").map(|s| s.addr.wrapping_sub(ro_len));
    let data_base = find(".data").map(|s| s.addr.wrapping_sub(relro_len));
    let bss_base = find(".bss").map(|s| s.addr);
    let tls_base = find(".tdata")
        .map(|s| s.addr)
        .or_else(|| find(".tbss").map(|s| s.addr));

    // Global symbol definitions per stream, sorted by address (ties
    // keep the defined table's name order). ld lists globals only.
    let mut text_syms: Vec<(u64, &str)> = Vec::new();
    let mut ro_syms: Vec<(u64, &str)> = Vec::new();
    let mut relro_syms: Vec<(u64, &str)> = Vec::new();
    let mut data_syms: Vec<(u64, &str)> = Vec::new();
    let mut bss_syms: Vec<(u64, &str)> = Vec::new();
    for (name, sym) in &merged.defined {
        let (list, base) = match sym.section {
            NativeSymSection::Text => (&mut text_syms, Some(text_base)),
            NativeSymSection::Data if sym.value < ro_len => (&mut ro_syms, rodata_base),
            NativeSymSection::Data if sym.value < relro_len => (&mut relro_syms, relro_base),
            NativeSymSection::Data => (&mut data_syms, data_base),
            NativeSymSection::Bss => (&mut bss_syms, bss_base),
            _ => continue,
        };
        if let Some(base) = base {
            list.push((base + sym.value, name.as_str()));
        }
    }
    for l in [
        &mut text_syms,
        &mut ro_syms,
        &mut relro_syms,
        &mut data_syms,
        &mut bss_syms,
    ] {
        l.sort_by_key(|&(addr, _)| addr);
    }

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
        let (rows, syms): (Vec<Row>, &[(u64, &str)]) = match sec.name.as_str() {
            ".text" => {
                let mut rows: Vec<Row> = Vec::new();
                if stub_len > 0 {
                    rows.push(Row {
                        addr: text_sec.addr,
                        size: stub_len,
                        name: ".stub".to_string(),
                        source: "<internal>".to_string(),
                    });
                }
                rows.extend(stream_rows(sm.text.iter(), text_base, &label_of));
                (rows, &text_syms)
            }
            ".rodata" => (
                stream_rows(
                    sm.data.iter().filter(|c| c.offset < ro_len),
                    sec.addr,
                    &label_of,
                ),
                ro_syms.as_slice(),
            ),
            ".data.rel.ro" => (
                stream_rows(
                    sm.data
                        .iter()
                        .filter(|c| c.offset >= ro_len && c.offset < relro_len),
                    sec.addr.wrapping_sub(ro_len),
                    &label_of,
                ),
                relro_syms.as_slice(),
            ),
            ".data" => (
                stream_rows(
                    sm.data.iter().filter(|c| c.offset >= relro_len),
                    sec.addr.wrapping_sub(relro_len),
                    &label_of,
                ),
                data_syms.as_slice(),
            ),
            ".bss" => (
                stream_rows(sm.bss.iter(), sec.addr, &label_of),
                bss_syms.as_slice(),
            ),
            ".tdata" | ".tbss" => {
                // The merged TLS block is one stream; the image splits
                // it at `tls_init_size`. Route each contribution to the
                // section its offset lands in.
                let init = merged.tls_init_size as u64;
                let rows = match tls_base {
                    Some(base) => stream_rows(
                        sm.tls.iter().filter(|c| {
                            if sec.name == ".tdata" {
                                c.offset < init
                            } else {
                                c.offset >= init
                            }
                        }),
                        base,
                        &label_of,
                    ),
                    None => Vec::new(),
                };
                (rows, &[])
            }
            _ => (Vec::new(), &[]),
        };
        render_section(&mut out, sec, rows, syms);
        out.push('\n');
    }

    out.push_str(&format!("OUTPUT({output_name} {bfd_format})\n"));
    Ok(out)
}

fn stream_rows<'a>(
    contribs: impl Iterator<Item = &'a SectionContribution>,
    base: u64,
    label_of: &dyn Fn(&Option<usize>) -> String,
) -> Vec<Row> {
    let mut rows: Vec<Row> = contribs
        .map(|c| Row {
            addr: base + c.offset,
            size: c.size,
            name: c.name.clone(),
            source: label_of(&c.input),
        })
        .collect();
    rows.sort_by_key(|r| r.addr);
    rows
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

/// The three-column `name address size` layout GNU ld uses: the name
/// padded to column 16 (wrapping long names onto their own line), an
/// `0x%016x` address, the size right-aligned in 11 columns.
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

fn map_err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_link_err(&format!("link map: {msg}")))
}

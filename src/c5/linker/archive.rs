//! Static-library archive (`.a`) reader / writer. Each archive starts
//! with the global magic `"!<arch>\n"`, then a sequence of members;
//! each member is a 60-byte ASCII header followed by its content
//! padded to an even byte boundary.
//!
//! The 16-byte name field cannot hold every name, and the two ar
//! lineages resolve that differently. An archive's variant follows its
//! producer, not the target it is linked for, so the reader accepts
//! both whatever is being linked.
//!
//! SysV / GNU. The first member, if present, is the symbol index
//! (name `"/"`): `u32 big-endian count` + `count u32 big-endian
//! offsets` (of the containing member's header, from start of file) +
//! the concatenated NUL-terminated symbol names; `"/SYM64/"` holds the
//! same with 64-bit numbers. Names longer than 15
//! bytes spill through the `"//"` string-table member: the header
//! carries `/<offset>` and the table's body holds the names, each
//! terminated by `\n`.
//!
//! BSD. The symbol index is a regular member named `__.SYMDEF` or
//! `__.SYMDEF SORTED` (`_64` forms for 64-bit offsets). A name that
//! does not fit, or needs padding for member alignment, is stored as
//! `#1/<len>` in the header with the name occupying the first `<len>`
//! bytes of the member body, NUL-padded; the header's size field
//! covers name and content together.
//!
//! We write the GNU shape, with generated names short enough to skip
//! the spill table.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::{internal_err, link_err};
use crate::c5::diag::Code;
use crate::c5::error::C5Error;
use crate::c5::layout::write_struct;

/// The tag this module's diagnostics carry.
const MODULE: &str = "";

/// ar(5) member header: a fixed 60-byte record of space-padded ASCII
/// fields, identical in the regular `!<arch>` and thin `!<thin>`
/// flavours. All fields are byte arrays, so the layout is align-1 and
/// the on-disk bytes map directly onto this struct.
#[repr(C)]
#[derive(Clone, Copy)]
struct ArHeader {
    name: [u8; 16],
    date: [u8; 12],
    uid: [u8; 6],
    gid: [u8; 6],
    mode: [u8; 8],
    size: [u8; 10],
    /// Trailer magic, always `0x60 0x0a` ("`\n").
    fmag: [u8; 2],
}
const AR_HEADER_SIZE: usize = 60;
const _: () = assert!(core::mem::size_of::<ArHeader>() == AR_HEADER_SIZE);

fn read_header(bytes: &[u8], off: usize) -> Result<ArHeader, C5Error> {
    if off
        .checked_add(AR_HEADER_SIZE)
        .is_none_or(|end| end > bytes.len())
    {
        return Err(link_err(
            Code::MALFORMED_INPUT,
            MODULE,
            "ar header truncated",
        ));
    }
    // SAFETY: bounds checked above; `ArHeader` is `#[repr(C)]` of byte
    // arrays (align 1), so any offset reads cleanly and the in-memory
    // pattern matches the on-disk bytes.
    Ok(unsafe { core::ptr::read_unaligned(bytes.as_ptr().add(off) as *const ArHeader) })
}

/// One archive member after parsing. `bytes` aliases into the
/// archive blob the caller owns; copying out lets the caller
/// drop the archive once everything is parsed.
#[derive(Debug, Clone)]
pub struct ArchiveMember {
    /// Member name (without trailing `/`). For badc-emitted
    /// archives this is the file stem of the source `.o`, e.g.
    /// `"foo.o"`.
    pub name: String,
    /// Member body bytes. For a c5 object file member, this is
    /// the native ELF object that [`super::object::parse_native_elf`]
    /// parses.
    pub bytes: Vec<u8>,
}

/// Where a parsed member's bytes live: inline in the archive blob
/// (regular `!<arch>`) or in an external file at the given path
/// (GNU thin `!<thin>` archive, resolved relative to the archive's
/// directory).
enum MemberSource {
    Inline(Vec<u8>),
    External(String),
}

/// Walk an archive's member headers, handling both the regular
/// `!<arch>` flavour (member bodies stored inline) and the GNU thin
/// `!<thin>` flavour (member bodies live in external files; only the
/// `/` symbol index and `//` name table are stored inline). Returns
/// each real member's name and the source of its bytes. The SysV
/// symbol index and GNU string table are consumed, not returned.
fn parse_archive_members(blob: &[u8]) -> Result<Vec<(String, MemberSource)>, C5Error> {
    let thin = blob.len() >= 8 && &blob[..8] == b"!<thin>\n";
    if !thin && (blob.len() < 8 || &blob[..8] != b"!<arch>\n") {
        return Err(link_err(
            Code::MALFORMED_INPUT,
            MODULE,
            "missing ar(5) magic `!<arch>\\n`",
        ));
    }
    let mut cursor = 8usize;
    let mut long_names: Vec<u8> = Vec::new();
    let mut out: Vec<(String, MemberSource)> = Vec::new();
    while cursor < blob.len() {
        // Align to even byte boundary -- ar pads odd-size members.
        if !cursor.is_multiple_of(2) {
            cursor += 1;
            if cursor >= blob.len() {
                break;
            }
        }
        let hdr = read_header(blob, cursor)?;
        if hdr.fmag != [0x60, 0x0a] {
            return Err(link_err(
                Code::MALFORMED_INPUT,
                MODULE,
                &format!("ar header magic mismatch at offset 0x{cursor:x}"),
            ));
        }
        let raw_name = trim_ascii(&hdr.name);
        let size = parse_dec(&trim_ascii(&hdr.size), "size")?;
        cursor += AR_HEADER_SIZE;

        // The `/` symbol index and `//` name table are stored inline in
        // both flavours; a regular member is inline, a thin member's
        // body lives in an external file (the header records its size
        // but no bytes follow). `is_meta` singles out the two inline
        // metadata members so a thin archive still skips their bodies.
        let is_meta = raw_name == "/" || raw_name == "/SYM64/" || raw_name == "//";
        let inline = !thin || is_meta;
        let mut body: &[u8] = if inline {
            if cursor + size > blob.len() {
                return Err(link_err(
                    Code::MALFORMED_INPUT,
                    MODULE,
                    "ar member body truncated",
                ));
            }
            let b = &blob[cursor..cursor + size];
            cursor += size;
            b
        } else {
            &[]
        };

        // Decode name. Variants we accept:
        //   "/"            -- SysV symbol index. Skip.
        //   "/SYM64/"      -- 64-bit symbol index. Skip.
        //   "//"           -- GNU long-name string table. Save.
        //   "/<digits>"    -- GNU long-name reference into "//".
        //   "#1/<digits>"  -- BSD name inline at the head of the body.
        //   "name/"        -- SysV short name (trailing `/` is the terminator).
        //   "name"         -- BSD short name.
        // MSVC repeats `/` (a little-endian index) and adds ARM64EC's `/<ECSYMBOLS>/`.
        if raw_name == "/" || raw_name == "/SYM64/" || raw_name == "/<ECSYMBOLS>/" {
            continue;
        }
        if raw_name == "//" {
            long_names = body.to_vec();
            continue;
        }
        let name = if let Some(rest) = raw_name.strip_prefix("#1/") {
            let (n, rest_body) = split_bsd_name(rest, body)?;
            body = rest_body;
            n
        } else if let Some(rest) = raw_name.strip_prefix('/') {
            // GNU long-name reference `/<decimal offset>` into the `//`
            // table. Some archivers pad the 16-byte field with spaces
            // and a trailing `/`, so read the leading digit run and
            // ignore the rest -- matching binutils' ar reader.
            let digits: String = rest.chars().take_while(|c| c.is_ascii_digit()).collect();
            let offset: usize = digits.parse().map_err(|_| {
                link_err(
                    Code::MALFORMED_INPUT,
                    MODULE,
                    &format!("bad GNU long-name offset in `{raw_name}`"),
                )
            })?;
            extract_long_name(&long_names, offset)?
        } else if let Some(stripped) = raw_name.strip_suffix('/') {
            stripped.to_string()
        } else {
            raw_name
        };
        // The BSD symbol index is a named member, so it is only
        // recognisable once the name is decoded.
        if is_bsd_symbol_index(&name) {
            continue;
        }
        if thin {
            // A thin member's `name` is its path relative to the
            // archive's directory (or absolute); the caller resolves it.
            out.push((name.clone(), MemberSource::External(name)));
        } else {
            out.push((name, MemberSource::Inline(body.to_vec())));
        }
    }
    Ok(out)
}

/// Read an archive's members. Skips the SysV symbol-index and
/// the GNU string-table members; the caller only sees real
/// object members. Returns members in the order they appear in
/// the archive. A GNU thin archive (`!<thin>`) needs the external
/// member files, which this blob-only entry point cannot reach; use
/// [`read_archive_at`] for those.
pub fn read_archive(blob: &[u8]) -> Result<Vec<ArchiveMember>, C5Error> {
    let mut out = Vec::new();
    for (name, src) in parse_archive_members(blob)? {
        match src {
            MemberSource::Inline(bytes) => out.push(ArchiveMember { name, bytes }),
            MemberSource::External(_) => {
                return Err(internal_err(
                    MODULE,
                    "thin archive member requires a base directory (use read_archive_at)",
                ));
            }
        }
    }
    Ok(out)
}

/// As [`read_archive`], but resolves a GNU thin archive's external
/// member files against `base_dir` (the directory containing the
/// archive). A regular archive ignores `base_dir`. Relative member
/// paths join `base_dir`; absolute paths are read as-is.
#[cfg(feature = "std")]
pub fn read_archive_at(
    blob: &[u8],
    base_dir: Option<&std::path::Path>,
) -> Result<Vec<ArchiveMember>, C5Error> {
    let mut out = Vec::new();
    for (name, src) in parse_archive_members(blob)? {
        let bytes = match src {
            MemberSource::Inline(bytes) => bytes,
            MemberSource::External(path) => {
                let p = std::path::Path::new(&path);
                let resolved = match base_dir {
                    Some(dir) if p.is_relative() => dir.join(p),
                    _ => p.to_path_buf(),
                };
                std::fs::read(&resolved).map_err(|e| {
                    link_err(
                        Code::MALFORMED_INPUT,
                        MODULE,
                        &format!(
                            "thin archive member `{}`: cannot read `{}`: {e}",
                            name,
                            resolved.display()
                        ),
                    )
                })?
            }
        };
        out.push(ArchiveMember { name, bytes });
    }
    Ok(out)
}

/// Build an archive from `members`, with a symbol index of the names
/// `symbols_by_member` lists as `(member_index, names)` as its first
/// member: each name points at its member's header, as SysV ar(5)
/// defines the index. The index holds 32-bit offsets (`/`) unless an
/// indexed member's header lies past them, where GNU ar writes 64-bit
/// ones (`/SYM64/`).
///
/// Names longer than 15 bytes spill through a GNU `//` string table,
/// which is emitted only when one does.
pub fn write_archive(
    members: &[ArchiveMember],
    symbols_by_member: &[(usize, Vec<String>)],
) -> Vec<u8> {
    let mut long_table: Vec<u8> = Vec::new();
    let mut name_form: Vec<String> = Vec::with_capacity(members.len());
    for m in members {
        if m.name.len() <= 15 {
            name_form.push(format!("{}/", m.name));
        } else {
            name_form.push(format!("/{}", long_table.len()));
            long_table.extend_from_slice(m.name.as_bytes());
            long_table.push(b'\n');
        }
    }
    let names: Vec<(usize, &str)> = (symbols_by_member.iter())
        .flat_map(|(mi, ns)| ns.iter().map(move |n| (*mi, n.as_str())))
        .collect();
    let sizes: Vec<u64> = members.iter().map(|m| m.bytes.len() as u64).collect();
    let (wide, headers) = index_layout(&names, &sizes, long_table.len() as u64);
    let entries: Vec<(u64, &str)> = names.iter().map(|&(mi, n)| (headers[mi], n)).collect();
    let (index_name, index) = symbol_index(wide, &entries);

    let mut out: Vec<u8> = Vec::new();
    out.extend_from_slice(b"!<arch>\n");
    for (name, body) in [(index_name, &index), ("//", &long_table)] {
        if name == "//" && body.is_empty() {
            continue;
        }
        write_ar_header(&mut out, name, body.len());
        out.extend_from_slice(body);
        if !body.len().is_multiple_of(2) {
            out.push(b'\n');
        }
    }
    for ((m, name_field), &header) in members.iter().zip(name_form.iter()).zip(&headers) {
        debug_assert_eq!(
            out.len() as u64,
            header,
            "the index names the member's header"
        );
        write_ar_header(&mut out, name_field, m.bytes.len());
        out.extend_from_slice(&m.bytes);
        if !m.bytes.len().is_multiple_of(2) {
            out.push(b'\n');
        }
    }
    out
}

/// Whether the symbol index takes 64-bit offsets, and the header offset
/// of each member of `sizes`, behind the index of `names` and a long-name
/// table of `long_names` bytes.
fn index_layout(names: &[(usize, &str)], sizes: &[u64], long_names: u64) -> (bool, Vec<u64>) {
    let padded = |n: u64| n + (n & 1);
    let strings: u64 = names.iter().map(|(_, n)| n.len() as u64 + 1).sum();
    let headers = |wide: bool| -> Vec<u64> {
        let width = if wide { 8 } else { 4 };
        let index = index_size(wide, width * (1 + names.len() as u64) + strings);
        let mut at = 8 + AR_HEADER_SIZE as u64 + padded(index);
        if long_names > 0 {
            at += AR_HEADER_SIZE as u64 + padded(long_names);
        }
        (sizes.iter())
            .map(|&size| {
                let header = at;
                at += AR_HEADER_SIZE as u64 + padded(size);
                header
            })
            .collect()
    };
    let narrow = headers(false);
    if names.iter().all(|&(mi, _)| narrow[mi] <= u32::MAX as u64) {
        return (false, narrow);
    }
    (true, headers(true))
}

/// The index body size: GNU ar pads a 64-bit index to 8 bytes.
fn index_size(wide: bool, raw: u64) -> u64 {
    if wide { raw.next_multiple_of(8) } else { raw }
}

/// The symbol index member's name and body for `(header offset, name)`
/// entries: a big-endian count, the offsets and the NUL-terminated
/// names, each number 32 or, where `wide`, 64 bits.
fn symbol_index(wide: bool, entries: &[(u64, &str)]) -> (&'static str, Vec<u8>) {
    let mut body: Vec<u8> = Vec::new();
    let number = |n: u64, body: &mut Vec<u8>| {
        if wide {
            body.extend_from_slice(&n.to_be_bytes());
        } else {
            body.extend_from_slice(&(n as u32).to_be_bytes());
        }
    };
    number(entries.len() as u64, &mut body);
    for &(at, _) in entries {
        number(at, &mut body);
    }
    for &(_, name) in entries {
        body.extend_from_slice(name.as_bytes());
        body.push(0);
    }
    body.resize(index_size(wide, body.len() as u64) as usize, 0);
    (if wide { "/SYM64/" } else { "/" }, body)
}

/// The names GNU ar's index lists for an ELF relocatable object of
/// either class and byte order: each symbol a section, `SHN_COMMON` or
/// `SHN_ABS` defines with global, weak or GNU-unique binding, in table
/// order.
pub fn elf_archive_symbols(bytes: &[u8]) -> Result<Vec<String>, C5Error> {
    let bad = || link_err(Code::MALFORMED_INPUT, MODULE, "ELF object is truncated");
    let (wide, big) = match (bytes.get(..4), bytes.get(4), bytes.get(5)) {
        (Some(b"\x7fELF"), Some(&c @ 1..=2), Some(&d @ 1..=2)) => (c == 2, d == 2),
        _ => return Err(link_err(Code::MALFORMED_INPUT, MODULE, "not an ELF object")),
    };
    let num = |at: u64, n: usize| -> Result<u64, C5Error> {
        let at = usize::try_from(at).map_err(|_| bad())?;
        let b = bytes.get(at..at.checked_add(n).ok_or_else(bad)?);
        Ok(
            (b.ok_or_else(bad)?.iter().enumerate()).fold(0, |v, (i, &x)| {
                v | (x as u64) << (8 * if big { n - 1 - i } else { i })
            }),
        )
    };
    let (shoff, shentsize, shnum) = if wide {
        (num(0x28, 8)?, num(0x3a, 2)?, num(0x3c, 2)?)
    } else {
        (num(0x20, 4)?, num(0x2e, 2)?, num(0x30, 2)?)
    };
    // `(sh_type, sh_offset, sh_size, sh_link)` of section `i`.
    let header = |i: u64| -> Result<[u64; 4], C5Error> {
        let at = shoff.wrapping_add(i.wrapping_mul(shentsize));
        Ok(if wide {
            [
                num(at + 4, 4)?,
                num(at + 0x18, 8)?,
                num(at + 0x20, 8)?,
                num(at + 0x28, 4)?,
            ]
        } else {
            [
                num(at + 4, 4)?,
                num(at + 0x10, 4)?,
                num(at + 0x14, 4)?,
                num(at + 0x18, 4)?,
            ]
        })
    };
    // `e_shnum` 0 leaves the count to section 0's `sh_size`.
    let shnum = if shnum == 0 { header(0)?[2] } else { shnum };
    let entry = if wide { 24 } else { 16 };
    let mut names = Vec::new();
    for sec in 0..shnum {
        let [kind, off, size, link] = header(sec)?;
        if kind != 2 {
            continue; // SHT_SYMTAB
        }
        let strings = header(link)?[1];
        for k in 1..size / entry {
            let at = off.wrapping_add(k * entry);
            let (info, shndx) = if wide {
                (num(at + 4, 1)?, num(at + 6, 2)?)
            } else {
                (num(at + 12, 1)?, num(at + 14, 2)?)
            };
            // STB_GLOBAL, STB_WEAK or STB_GNU_UNIQUE, and neither
            // STT_SECTION nor STT_FILE.
            if shndx == 0 || !matches!(info >> 4, 1 | 2 | 10) || matches!(info & 0xf, 3 | 4) {
                continue;
            }
            let start = usize::try_from(strings.wrapping_add(num(at, 4)?)).map_err(|_| bad())?;
            let tail = bytes.get(start..).ok_or_else(bad)?;
            let end = tail.iter().position(|&c| c == 0).ok_or_else(bad)?;
            names.push(String::from_utf8_lossy(&tail[..end]).into_owned());
        }
    }
    Ok(names)
}

fn write_ar_header(out: &mut Vec<u8>, name_field: &str, size: usize) {
    // Space-padded ASCII fields; the numeric fields carry a single `0`
    // (date / uid / gid / mode are unused by the linker) except `size`.
    let mut hdr = ArHeader {
        name: [b' '; 16],
        date: [b' '; 12],
        uid: [b' '; 6],
        gid: [b' '; 6],
        mode: [b' '; 8],
        size: [b' '; 10],
        fmag: [0x60, 0x0a],
    };
    let name = name_field.as_bytes();
    let n = name.len().min(16);
    hdr.name[..n].copy_from_slice(&name[..n]);
    hdr.date[0] = b'0';
    hdr.uid[0] = b'0';
    hdr.gid[0] = b'0';
    hdr.mode[0] = b'0';
    let size_str = format!("{size}");
    let sbytes = size_str.as_bytes();
    hdr.size[..sbytes.len().min(10)].copy_from_slice(&sbytes[..sbytes.len().min(10)]);
    write_struct(out, &hdr);
}

/// True when the archive carries the `/<ECSYMBOLS>/` index of an ARM64X
/// library, which follows the `/` indexes and the `//` name table.
pub fn is_arm64x_archive(blob: &[u8]) -> bool {
    let mut at = 8;
    while blob.get(..8) == Some(b"!<arch>\n") {
        let Ok(h) = read_header(blob, at) else {
            return false;
        };
        let name = trim_ascii(&h.name);
        let Ok(size) = parse_dec(&trim_ascii(&h.size), "size") else {
            return false;
        };
        match name.as_str() {
            "/<ECSYMBOLS>/" => return true,
            "/" | "//" => at += AR_HEADER_SIZE + size + (size & 1),
            _ => return false,
        }
    }
    false
}

fn trim_ascii(bytes: &[u8]) -> String {
    let end = bytes
        .iter()
        .rposition(|&b| b != b' ')
        .map(|i| i + 1)
        .unwrap_or(0);
    String::from_utf8_lossy(&bytes[..end]).into_owned()
}

fn parse_dec(s: &str, what: &str) -> Result<usize, C5Error> {
    let s = s.trim();
    if s.is_empty() {
        return Ok(0);
    }
    s.parse::<usize>().map_err(|_| {
        link_err(
            Code::MALFORMED_INPUT,
            MODULE,
            &format!("bad ar {what} field `{s}`"),
        )
    })
}

/// Split a BSD `#1/<len>` member: `field` is the header text after the
/// `#1/` prefix, `body` the member's bytes. Returns the name (trailing
/// NUL padding removed) and the content that follows it.
fn split_bsd_name<'a>(field: &str, body: &'a [u8]) -> Result<(String, &'a [u8]), C5Error> {
    let len: usize = field.trim().parse().map_err(|_| {
        link_err(
            Code::MALFORMED_INPUT,
            MODULE,
            &format!("bad BSD inline-name length in `#1/{field}`"),
        )
    })?;
    if len > body.len() {
        return Err(link_err(
            Code::MALFORMED_INPUT,
            MODULE,
            &format!(
                "BSD inline name of {len} bytes exceeds the {}-byte member body",
                body.len()
            ),
        ));
    }
    let (name, rest) = body.split_at(len);
    let name = &name[..name.iter().position(|&b| b == 0).unwrap_or(len)];
    Ok((
        core::str::from_utf8(name)
            .map_err(|_| {
                link_err(
                    Code::MALFORMED_INPUT,
                    MODULE,
                    "BSD inline name is not valid UTF-8",
                )
            })?
            .to_string(),
        rest,
    ))
}

/// Whether a decoded member name is the BSD symbol index, the
/// counterpart of the SysV `/` member.
fn is_bsd_symbol_index(name: &str) -> bool {
    matches!(
        name,
        "__.SYMDEF" | "__.SYMDEF SORTED" | "__.SYMDEF_64" | "__.SYMDEF_64 SORTED"
    )
}

fn extract_long_name(table: &[u8], off: usize) -> Result<String, C5Error> {
    if off >= table.len() {
        return Err(link_err(
            Code::MALFORMED_INPUT,
            MODULE,
            "GNU long-name offset out of range",
        ));
    }
    // GNU names end with `\n` or `/\n`, MSVC's with NUL.
    let end = table[off..]
        .iter()
        .position(|&b| b == b'\n' || b == 0)
        .ok_or_else(|| {
            link_err(
                Code::MALFORMED_INPUT,
                MODULE,
                "GNU long-name not terminated",
            )
        })?;
    let mut slice = &table[off..off + end];
    if let Some(s) = slice.strip_suffix(b"/") {
        slice = s;
    }
    Ok(core::str::from_utf8(slice)
        .map_err(|_| {
            link_err(
                Code::MALFORMED_INPUT,
                MODULE,
                "GNU long-name not valid UTF-8",
            )
        })?
        .to_string())
}

#[cfg(all(test, feature = "std"))]
mod tests {
    use super::*;

    /// A malformed archive is the user's input, not badc's invariant:
    /// the error carries the malformed-input row and no ICE marker.
    #[test]
    fn a_truncated_archive_is_reported_as_malformed_input() {
        let err = read_archive(b"!<arch>\ntruncated").unwrap_err();
        let text = err.to_string();
        assert!(text.contains("ar header truncated"), "{text}");
        assert!(text.ends_with("[B6014] [malformed-input]"), "{text}");
        assert!(!text.contains("internal compiler error"), "{text}");
    }

    /// Each index entry is the offset of its member's header, as SysV
    /// ar(5) defines the index, past a long-name table too.
    #[test]
    fn the_symbol_index_names_each_members_header() {
        let members = alloc::vec![
            ArchiveMember {
                name: "a_member_name_past_sixteen.o".into(),
                bytes: alloc::vec![1, 2, 3]
            },
            ArchiveMember {
                name: "b.o".into(),
                bytes: alloc::vec![4]
            },
        ];
        let symbols = [
            (0, alloc::vec![String::from("sa")]),
            (1, alloc::vec![String::from("sb"), String::from("sc")]),
        ];
        let blob = write_archive(&members, &symbols);
        let index = &blob[8 + AR_HEADER_SIZE..];
        let be = |at: usize| u32::from_be_bytes(index[at..at + 4].try_into().unwrap()) as usize;
        assert_eq!((&blob[8..10], be(0)), (&b"/ "[..], 3));
        let names: Vec<&[u8]> = [1, 2, 2]
            .iter()
            .map(|&k| {
                let at = be(4 * k);
                &blob[at..at + 3]
            })
            .collect();
        assert_eq!(names, [&b"/0 "[..], b"b.o", b"b.o"]);
        assert_eq!(&index[16..25], b"sa\0sb\0sc\0");
    }

    /// GNU ar 2.46.1 writes `/SYM64/`, with 64-bit numbers padded to 8
    /// bytes, where an indexed member's header lies past 4 GiB, and `/`
    /// where only an unindexed one does.
    #[test]
    fn an_index_past_four_gib_takes_64_bit_offsets() {
        let sizes = [1u64 << 32, 10];
        let (wide, headers) = index_layout(&[(1, "b")], &sizes, 0);
        assert!(wide && headers[1] > u32::MAX as u64, "{headers:?}");
        assert!(!index_layout(&[(0, "a")], &sizes, 0).0);
        let (name, body) = symbol_index(true, &[(headers[1], "b")]);
        assert_eq!(name, "/SYM64/");
        assert_eq!(body.len(), 24);
        assert_eq!(
            &body[..16],
            [&1u64.to_be_bytes()[..], &headers[1].to_be_bytes()].concat()
        );
        assert_eq!(&body[16..], b"b\0\0\0\0\0\0\0");
    }

    /// A regular `!<arch>` round-trips: write members, read them back.
    #[test]
    fn regular_archive_round_trips() {
        let members = alloc::vec![
            ArchiveMember {
                name: "a.o".into(),
                bytes: alloc::vec![1, 2, 3]
            },
            ArchiveMember {
                name: "b.o".into(),
                bytes: alloc::vec![4, 5, 6, 7]
            },
        ];
        let blob = write_archive(
            &members,
            &[(0, alloc::vec!["sa".into()]), (1, alloc::vec!["sb".into()])],
        );
        let back = read_archive(&blob).expect("read");
        assert_eq!(back.len(), 2);
        assert_eq!(back[0].name, "a.o");
        assert_eq!(back[0].bytes, alloc::vec![1, 2, 3]);
        assert_eq!(back[1].name, "b.o");
        assert_eq!(back[1].bytes, alloc::vec![4, 5, 6, 7]);
    }

    /// Append a member with a BSD `#1/<len>` inline name NUL-padded to
    /// `pad_to`; the size field covers name and content together.
    fn push_bsd_member(out: &mut Vec<u8>, name: &str, content: &[u8], pad_to: usize) {
        let field = pad_to.max(name.len());
        write_ar_header(out, &format!("#1/{field}"), field + content.len());
        out.extend_from_slice(name.as_bytes());
        out.extend(core::iter::repeat_n(0u8, field - name.len()));
        out.extend_from_slice(content);
        if !(field + content.len()).is_multiple_of(2) {
            out.push(b'\n');
        }
    }

    /// A BSD archive stores a name at the head of the member body and
    /// records `#1/<len>` in the header. Its symbol index is a named
    /// member, not the SysV `/`, and is skipped like one. The paddings
    /// below are the ones `/usr/bin/ar` writes.
    #[test]
    fn bsd_archive_inline_names_resolve() {
        let mut blob: Vec<u8> = Vec::new();
        blob.extend_from_slice(b"!<arch>\n");
        push_bsd_member(&mut blob, "__.SYMDEF SORTED", &[0u8; 8], 20);
        push_bsd_member(
            &mut blob,
            "a_very_long_member_name_over_sixteen.o",
            b"LONG-BODY",
            44,
        );
        push_bsd_member(&mut blob, "short.o", b"SHORT", 12);

        let members = read_archive(&blob).expect("read bsd");
        assert_eq!(members.len(), 2, "the symbol index is not a member");
        assert_eq!(members[0].name, "a_very_long_member_name_over_sixteen.o");
        assert_eq!(members[0].bytes, b"LONG-BODY");
        assert_eq!(members[1].name, "short.o");
        assert_eq!(members[1].bytes, b"SHORT");
    }

    /// A BSD short name fits the 16-byte field with no `#1/` prefix and
    /// no SysV trailing `/`; every symbol-index spelling is skipped in
    /// that form too.
    #[test]
    fn bsd_archive_short_names_and_symbol_index() {
        let mut blob: Vec<u8> = Vec::new();
        blob.extend_from_slice(b"!<arch>\n");
        for index in ["__.SYMDEF", "__.SYMDEF SORTED", "__.SYMDEF_64"] {
            write_ar_header(&mut blob, index, 2);
            blob.extend_from_slice(&[0u8, 0u8]);
        }
        write_ar_header(&mut blob, "plain.o", 4);
        blob.extend_from_slice(b"BODY");

        let members = read_archive(&blob).expect("read bsd short");
        assert_eq!(members.len(), 1);
        assert_eq!(members[0].name, "plain.o");
        assert_eq!(members[0].bytes, b"BODY");
    }

    /// A member body shorter than its `#1/<len>` name is malformed;
    /// the reader reports it instead of slicing out of range.
    #[test]
    fn bsd_inline_name_longer_than_body_is_rejected() {
        let mut blob: Vec<u8> = Vec::new();
        blob.extend_from_slice(b"!<arch>\n");
        write_ar_header(&mut blob, "#1/40", 4);
        blob.extend_from_slice(b"tiny");
        assert!(read_archive(&blob).is_err(), "short body must be rejected");
    }

    /// A GNU archive spills names over 15 bytes into a `//` table and
    /// references them as `/<offset>`, with the bodies stored inline.
    #[test]
    fn msvc_archive_long_names_resolve() {
        // lib.exe: two `/` indexes, a `//` table of NUL-terminated names.
        let mut blob = b"!<arch>\n".to_vec();
        write_ar_header(&mut blob, "/", 4);
        blob.extend_from_slice(&[0; 4]);
        write_ar_header(&mut blob, "/", 4);
        blob.extend_from_slice(&[0; 4]);
        let names = b"C:\\build\\long_object_name.obj\0";
        write_ar_header(&mut blob, "//", names.len());
        blob.extend_from_slice(names);
        if blob.len() % 2 == 1 {
            blob.push(b'\n');
        }
        write_ar_header(&mut blob, "/0", 2);
        blob.extend_from_slice(b"ok");
        let members = read_archive(&blob).expect("read");
        assert_eq!(members.len(), 1);
        assert_eq!(members[0].name, "C:\\build\\long_object_name.obj");
        assert_eq!(members[0].bytes, b"ok");
    }

    #[test]
    fn gnu_archive_long_names_resolve() {
        let long = "a_very_long_member_name_over_sixteen.o";
        let names = format!("{long}/\nshort.o/\n");
        let short_off = long.len() + 2;
        let mut blob: Vec<u8> = Vec::new();
        blob.extend_from_slice(b"!<arch>\n");
        write_ar_header(&mut blob, "/", 4);
        blob.extend_from_slice(&[0u8; 4]);
        write_ar_header(&mut blob, "//", names.len());
        blob.extend_from_slice(names.as_bytes());
        if !names.len().is_multiple_of(2) {
            blob.push(b'\n');
        }
        write_ar_header(&mut blob, "/0", 9);
        blob.extend_from_slice(b"LONG-BODY");
        blob.push(b'\n');
        write_ar_header(&mut blob, &format!("/{short_off}"), 5);
        blob.extend_from_slice(b"SHORT");

        let members = read_archive(&blob).expect("read gnu");
        assert_eq!(members.len(), 2, "the symbol index is not a member");
        assert_eq!(members[0].name, long);
        assert_eq!(members[0].bytes, b"LONG-BODY");
        assert_eq!(members[1].name, "short.o");
        assert_eq!(members[1].bytes, b"SHORT");
    }

    /// A GNU thin archive (`!<thin>`) stores member paths in the `//`
    /// table with no inline bodies; `read_archive_at` resolves each
    /// against the archive's directory and reads the external file.
    #[test]
    fn thin_archive_reads_external_members() {
        let dir = std::env::temp_dir().join(format!("badc-thin-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        std::fs::write(dir.join("m1.o"), b"OBJECT-ONE").unwrap();
        std::fs::write(dir.join("m2.o"), b"OBJ2").unwrap();
        std::fs::write(dir.join("m3.o"), b"THREE").unwrap();

        // GNU `//` entries are `<path>/\n`; a thin member header names
        // `/<offset>` into that table and carries no body.
        let names: &[u8] = b"m1.o/\nm2.o/\nm3.o/\n";
        let off2 = b"m1.o/\n".len();
        let off3 = b"m1.o/\nm2.o/\n".len();
        let mut blob: Vec<u8> = Vec::new();
        blob.extend_from_slice(b"!<thin>\n");
        write_ar_header(&mut blob, "//", names.len());
        blob.extend_from_slice(names);
        if !names.len().is_multiple_of(2) {
            blob.push(b'\n');
        }
        write_ar_header(&mut blob, "/0", 10); // m1.o size; no body in a thin archive
        write_ar_header(&mut blob, &format!("/{off2}"), 4); // m2.o
        // m3.o's ref uses the trailing-`/` field padding some archivers
        // emit (`/<off>` then spaces then `/`); the reader must take the
        // leading digits only.
        let mut hdr3 = [b' '; AR_HEADER_SIZE];
        let field = format!("/{off3}");
        hdr3[..field.len()].copy_from_slice(field.as_bytes());
        hdr3[15] = b'/'; // trailing slash at the end of the 16-byte name field
        hdr3[48] = b'5'; // size 5
        hdr3[58] = 0x60;
        hdr3[59] = 0x0a;
        blob.extend_from_slice(&hdr3);

        let members = read_archive_at(&blob, Some(&dir)).expect("read thin");
        assert_eq!(members.len(), 3, "three external members");
        assert_eq!(members[0].name, "m1.o");
        assert_eq!(members[0].bytes, b"OBJECT-ONE");
        assert_eq!(members[1].name, "m2.o");
        assert_eq!(members[1].bytes, b"OBJ2");
        assert_eq!(members[2].name, "m3.o", "trailing-slash ref resolves");
        assert_eq!(members[2].bytes, b"THREE");

        // The blob-only entry point rejects thin members (no base dir).
        assert!(read_archive(&blob).is_err(), "thin needs a base dir");

        std::fs::remove_dir_all(&dir).ok();
    }
}

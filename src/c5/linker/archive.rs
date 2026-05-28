//! Static-library archive (`.a`) reader / writer in the SysV
//! ar(5) flavour. Each archive starts with the global magic
//! `"!<arch>\n"`, then a sequence of members; each member is a
//! 60-byte ASCII header followed by its content padded to an
//! even byte boundary.
//!
//! The very first member -- if present -- is the SysV-style
//! "symbol index" (name `"/"`). Its body is `u32 big-endian
//! count` + `count u32 big-endian offsets` (offset of the
//! containing member's body, measured from start of file) + the
//! NUL-terminated symbol name strings, concatenated. The linker
//! consults this index to decide which archive members to pull
//! in to satisfy unresolved references.
//!
//! Names longer than 15 bytes spill through the GNU `"//"`
//! string-table member: their header carries `/<offset>` and the
//! `//` member's body holds the actual names, each terminated by
//! `\n`. We write all our generated names short enough to skip
//! the spill table, but the reader honours both shapes so a
//! user-built archive from another producer still loads.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use crate::c5::error::C5Error;

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

/// Read an archive's members. Skips the SysV symbol-index and
/// the GNU string-table members; the caller only sees real
/// object members. Returns members in the order they appear in
/// the archive.
pub fn read_archive(blob: &[u8]) -> Result<Vec<ArchiveMember>, C5Error> {
    if blob.len() < 8 || &blob[..8] != b"!<arch>\n" {
        return Err(err("missing ar(5) magic `!<arch>\\n`"));
    }
    let mut cursor = 8usize;
    let mut long_names: Vec<u8> = Vec::new();
    let mut out: Vec<ArchiveMember> = Vec::new();
    while cursor < blob.len() {
        // Align to even byte boundary -- ar pads odd-size members.
        if !cursor.is_multiple_of(2) {
            cursor += 1;
            if cursor >= blob.len() {
                break;
            }
        }
        if cursor + 60 > blob.len() {
            return Err(err("ar header truncated"));
        }
        let hdr = &blob[cursor..cursor + 60];
        if &hdr[58..60] != b"\x60\x0a" {
            return Err(err(&format!(
                "ar header magic mismatch at offset 0x{cursor:x}"
            )));
        }
        let raw_name = trim_ascii(&hdr[0..16]);
        let size_str = trim_ascii(&hdr[48..58]);
        let size = parse_dec(&size_str, "size")?;
        cursor += 60;
        if cursor + size > blob.len() {
            return Err(err("ar member body truncated"));
        }
        let body = &blob[cursor..cursor + size];
        cursor += size;

        // Decode name. Variants we accept:
        //   "/"            -- SysV symbol index. Skip.
        //   "/SYM64/"      -- 64-bit symbol index. Skip.
        //   "//"           -- GNU long-name string table. Save.
        //   "/<digits>"    -- GNU long-name reference into "//".
        //   "name/"        -- regular short name (trailing `/` is the SysV terminator).
        //   "name"         -- BSD-style; less common but tolerated.
        if raw_name == "/" || raw_name == "/SYM64/" {
            continue;
        }
        if raw_name == "//" {
            long_names = body.to_vec();
            continue;
        }
        let name = if let Some(digits) = raw_name.strip_prefix('/') {
            let offset: usize = digits
                .parse()
                .map_err(|_| err("bad GNU long-name offset"))?;
            extract_long_name(&long_names, offset)?
        } else if let Some(stripped) = raw_name.strip_suffix('/') {
            stripped.to_string()
        } else {
            raw_name
        };
        out.push(ArchiveMember {
            name,
            bytes: body.to_vec(),
        });
    }
    Ok(out)
}

/// Build an archive from `members`. Lays out the SysV symbol
/// index as the first member -- `symbols_by_member` is an
/// iterator of `(member_index, &[symbol_name])` pairs; every
/// name pointing at member i resolves to the same archive
/// offset, namely the start of member i's body.
///
/// Names longer than 15 bytes spill through a GNU `//` string
/// table. We emit the table only when needed.
pub fn write_archive(
    members: &[ArchiveMember],
    symbols_by_member: &[(usize, Vec<String>)],
) -> Vec<u8> {
    let mut out: Vec<u8> = Vec::new();
    out.extend_from_slice(b"!<arch>\n");

    // Decide whether any name spills into the string table.
    let mut long_table: Vec<u8> = Vec::new();
    let mut name_form: Vec<String> = Vec::with_capacity(members.len());
    for m in members {
        let raw = m.name.clone();
        if raw.len() <= 15 {
            name_form.push(format!("{raw}/"));
        } else {
            let off = long_table.len();
            long_table.extend_from_slice(raw.as_bytes());
            long_table.push(b'\n');
            name_form.push(format!("/{off}"));
        }
    }

    // Pre-compute body offsets so the symbol index can record
    // absolute file offsets. The layout is:
    //   [global header 8 bytes]
    //   [/   header 60 bytes][/   body padded]
    //   [//  header 60 bytes][//  body padded]    (only if long_table nonempty)
    //   [member 1 header 60 bytes][body padded]
    //   ...
    //
    // We don't know the symbol-index body size until we know
    // the offsets... but the offsets depend on the symbol-index
    // size. Two-pass: assume symbol-index size, compute, then
    // patch.

    // Pass 1: symbol-index body size.
    let total_syms: usize = symbols_by_member.iter().map(|(_, s)| s.len()).sum();
    let mut sym_body_size: usize = 4 + total_syms * 4;
    for (_, names) in symbols_by_member {
        for n in names {
            sym_body_size += n.len() + 1;
        }
    }
    // Pad to even.
    let sym_body_padded = (sym_body_size + 1) & !1;

    // Pass 2: compute each member's body file offset.
    let mut cursor: usize = 8 + 60 + sym_body_padded;
    if !long_table.is_empty() {
        let lt_padded = (long_table.len() + 1) & !1;
        cursor += 60 + lt_padded;
    }
    let mut body_offsets: Vec<usize> = Vec::with_capacity(members.len());
    let mut tmp_cursor = cursor;
    for m in members {
        // Header for this member.
        tmp_cursor += 60;
        body_offsets.push(tmp_cursor);
        let padded = (m.bytes.len() + 1) & !1;
        tmp_cursor += padded;
    }

    // Pass 3: actually emit.
    // Symbol-index member.
    let mut sym_body = Vec::with_capacity(sym_body_size);
    sym_body.extend_from_slice(&(total_syms as u32).to_be_bytes());
    // First write offsets in symbol order; record positions of
    // each name's offset slot so we can pair name <-> offset.
    let mut name_index: Vec<(String, u32)> = Vec::with_capacity(total_syms);
    for (mi, names) in symbols_by_member {
        for n in names {
            name_index.push((n.clone(), body_offsets[*mi] as u32));
        }
    }
    for (_, off) in &name_index {
        sym_body.extend_from_slice(&off.to_be_bytes());
    }
    for (n, _) in &name_index {
        sym_body.extend_from_slice(n.as_bytes());
        sym_body.push(0);
    }
    write_ar_header(&mut out, "/", sym_body.len());
    out.extend_from_slice(&sym_body);
    if !sym_body.len().is_multiple_of(2) {
        out.push(b'\n');
    }

    // GNU long-name table.
    if !long_table.is_empty() {
        write_ar_header(&mut out, "//", long_table.len());
        out.extend_from_slice(&long_table);
        if !long_table.len().is_multiple_of(2) {
            out.push(b'\n');
        }
    }

    // Real members.
    for (m, name_field) in members.iter().zip(name_form.iter()) {
        write_ar_header(&mut out, name_field, m.bytes.len());
        out.extend_from_slice(&m.bytes);
        if !m.bytes.len().is_multiple_of(2) {
            out.push(b'\n');
        }
    }
    out
}

fn write_ar_header(out: &mut Vec<u8>, name_field: &str, size: usize) {
    let mut hdr = [b' '; 60];
    // Name (16). Zero-padded with trailing spaces.
    let bytes = name_field.as_bytes();
    let n = bytes.len().min(16);
    hdr[..n].copy_from_slice(&bytes[..n]);
    // Date (12) -- zero.
    hdr[16..28].fill(b' ');
    hdr[16] = b'0';
    // uid (6), gid (6), mode (8) -- zeros.
    hdr[28] = b'0';
    hdr[34] = b'0';
    hdr[40..48].fill(b' ');
    hdr[40] = b'0';
    // Size (10) -- ASCII decimal.
    let size_str = format!("{size}");
    let sbytes = size_str.as_bytes();
    hdr[48..48 + sbytes.len()].copy_from_slice(sbytes);
    // Fill rest of size field with spaces.
    for b in &mut hdr[48 + sbytes.len()..58] {
        *b = b' ';
    }
    // Trailer magic.
    hdr[58] = 0x60;
    hdr[59] = 0x0a;
    out.extend_from_slice(&hdr);
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
    s.parse::<usize>()
        .map_err(|_| err(&format!("bad ar {what} field `{s}`")))
}

fn extract_long_name(table: &[u8], off: usize) -> Result<String, C5Error> {
    if off >= table.len() {
        return Err(err("GNU long-name offset out of range"));
    }
    // GNU names end with `\n` or `/\n`. We tolerate both.
    let end = table[off..]
        .iter()
        .position(|&b| b == b'\n')
        .ok_or_else(|| err("GNU long-name not terminated"))?;
    let mut slice = &table[off..off + end];
    if let Some(s) = slice.strip_suffix(b"/") {
        slice = s;
    }
    Ok(core::str::from_utf8(slice)
        .map_err(|_| err("GNU long-name not valid UTF-8"))?
        .to_string())
}

fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(msg))
}

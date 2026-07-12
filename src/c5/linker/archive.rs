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
        return Err(err("ar header truncated"));
    }
    // SAFETY: bounds checked above; `ArHeader` is `#[repr(C)]` of byte
    // arrays (align 1), so any offset reads cleanly and the in-memory
    // pattern matches the on-disk bytes.
    Ok(unsafe { core::ptr::read_unaligned(bytes.as_ptr().add(off) as *const ArHeader) })
}

fn write_struct<T: Copy>(out: &mut Vec<u8>, value: &T) {
    let bytes = unsafe {
        core::slice::from_raw_parts((value as *const T) as *const u8, core::mem::size_of::<T>())
    };
    out.extend_from_slice(bytes);
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
        return Err(err("missing ar(5) magic `!<arch>\\n`"));
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
            return Err(err(&format!(
                "ar header magic mismatch at offset 0x{cursor:x}"
            )));
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
        let body: &[u8] = if inline {
            if cursor + size > blob.len() {
                return Err(err("ar member body truncated"));
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
        //   "name/"        -- regular short name (trailing `/` is the SysV terminator).
        //   "name"         -- BSD-style; less common but tolerated.
        if raw_name == "/" || raw_name == "/SYM64/" {
            continue;
        }
        if raw_name == "//" {
            long_names = body.to_vec();
            continue;
        }
        let name = if let Some(rest) = raw_name.strip_prefix('/') {
            // GNU long-name reference `/<decimal offset>` into the `//`
            // table. Some archivers pad the 16-byte field with spaces
            // and a trailing `/`, so read the leading digit run and
            // ignore the rest -- matching binutils' ar reader.
            let digits: String = rest.chars().take_while(|c| c.is_ascii_digit()).collect();
            let offset: usize = digits
                .parse()
                .map_err(|_| err(&format!("bad GNU long-name offset in `{raw_name}`")))?;
            extract_long_name(&long_names, offset)?
        } else if let Some(stripped) = raw_name.strip_suffix('/') {
            stripped.to_string()
        } else {
            raw_name
        };
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
                return Err(err(
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
                    err(&format!(
                        "thin archive member `{}`: cannot read `{}`: {e}",
                        name,
                        resolved.display()
                    ))
                })?
            }
        };
        out.push(ArchiveMember { name, bytes });
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

#[cfg(all(test, feature = "std"))]
mod tests {
    use super::*;

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

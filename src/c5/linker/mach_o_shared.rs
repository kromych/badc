//! Mach-O shared-library export readers, producing the same
//! [`SharedLibrary`] the ELF `.dynsym` reader does so a `-l` input
//! resolves undefined references on the same terms on every target.
//!
//! Two on-disk shapes carry a Mach-O library's exports:
//!
//! * A dylib image. dyld resolves imports through the export trie
//!   (`LC_DYLD_INFO` / `LC_DYLD_INFO_ONLY` export section, or the
//!   standalone `LC_DYLD_EXPORTS_TRIE`), not the classic symbol
//!   table, so the trie is the authoritative export list. The
//!   canonical name a dependent records is the `LC_ID_DYLIB` install
//!   name.
//!
//! * A `.tbd` text stub. Apple SDKs ship these in place of the dylib
//!   binaries (the binaries live in the dyld shared cache): a YAML
//!   file of one or more `!tapi-tbd` version-4 documents, each naming
//!   an install name, the `<arch>-<platform>` targets it covers, and
//!   per-target symbol lists. An umbrella like libSystem reexports
//!   its member libraries; their documents are inlined in the same
//!   file. The format is line-structured, so a purpose-built scanner
//!   below reads it without a YAML dependency.
//!
//! C names carry the Mach-O leading underscore on disk; the readers
//! strip one, matching the `MH_OBJECT` reader, so export names
//! compare against link-level names directly.

use alloc::collections::BTreeSet;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use crate::c5::error::C5Error;

use super::mach_o_object::mach_o_machine;
use super::object::{NativeMachine, SharedLibrary};

const MH_MAGIC_64: u32 = 0xFEED_FACF;
const MH_DYLIB: u32 = 0x6;
const MACH_HEADER_64_SIZE: usize = 32;

const LC_ID_DYLIB: u32 = 0xD;
const LC_REQ_DYLD: u32 = 0x8000_0000;
const LC_DYLD_INFO: u32 = 0x22;
const LC_DYLD_INFO_ONLY: u32 = 0x22 | LC_REQ_DYLD;
const LC_DYLD_EXPORTS_TRIE: u32 = 0x33 | LC_REQ_DYLD;

fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
        "linker::mach_o_shared: {msg}",
    )))
}

fn u32le(bytes: &[u8], off: usize) -> Option<u32> {
    let b = bytes.get(off..off + 4)?;
    Some(u32::from_le_bytes([b[0], b[1], b[2], b[3]]))
}

/// True when `bytes` is a 64-bit little-endian Mach-O dylib image.
/// A universal (fat) container must be sliced first.
pub fn is_mach_o_dylib(bytes: &[u8]) -> bool {
    bytes.len() >= MACH_HEADER_64_SIZE
        && u32le(bytes, 0) == Some(MH_MAGIC_64)
        && u32le(bytes, 12) == Some(MH_DYLIB)
}

/// Read a dylib's install name and exported symbols. The install name
/// comes from `LC_ID_DYLIB` (empty when absent -- the caller
/// substitutes the file's base name); the exports are every terminal
/// node of the dyld export trie, leading underscore stripped. The trie
/// carries no object-vs-function distinction, so `data_exports` stays
/// empty and a data reference relies on its GOT relocation kind.
pub fn parse_mach_o_dylib(bytes: &[u8]) -> Result<SharedLibrary, C5Error> {
    if !is_mach_o_dylib(bytes) {
        return Err(err("not a 64-bit little-endian Mach-O dylib"));
    }
    let need = |off: usize, what: &str| -> Result<u32, C5Error> {
        u32le(bytes, off).ok_or_else(|| err(&format!("{what} runs past end of file")))
    };
    let cputype = need(4, "header")?;
    let machine = mach_o_machine(cputype).ok_or_else(|| {
        err(&format!(
            "dylib has unhandled cputype {}",
            super::mach_o_object::mach_o_cputype_desc(cputype)
        ))
    })?;
    let ncmds = need(16, "header")? as usize;
    let sizeofcmds = need(20, "header")? as usize;
    let cmds_end = MACH_HEADER_64_SIZE
        .checked_add(sizeofcmds)
        .filter(|&e| e <= bytes.len())
        .ok_or_else(|| err("load commands run past end of file"))?;
    let mut soname = String::new();
    let mut trie: Option<(usize, usize)> = None;
    let mut off = MACH_HEADER_64_SIZE;
    for _ in 0..ncmds {
        let cmd = need(off, "load command")?;
        let cmdsize = need(off + 4, "load command")? as usize;
        if cmdsize < 8 || off + cmdsize > cmds_end {
            return Err(err("load command size out of range"));
        }
        match cmd {
            LC_ID_DYLIB => {
                // dylib_command: the name is a cstr at `cmd + name
                // offset`, inside the command's extent.
                let name_off = need(off + 8, "LC_ID_DYLIB")? as usize;
                let start = off
                    .checked_add(name_off)
                    .filter(|&s| s < off + cmdsize)
                    .ok_or_else(|| err("LC_ID_DYLIB name offset out of range"))?;
                let field = &bytes[start..off + cmdsize];
                let end = field.iter().position(|&b| b == 0).unwrap_or(field.len());
                soname = String::from_utf8_lossy(&field[..end]).into_owned();
            }
            LC_DYLD_INFO | LC_DYLD_INFO_ONLY => {
                // dyld_info_command: export_off / export_size are the
                // last of its five (offset, size) pairs.
                let e_off = need(off + 40, "LC_DYLD_INFO")? as usize;
                let e_size = need(off + 44, "LC_DYLD_INFO")? as usize;
                trie = Some((e_off, e_size));
            }
            LC_DYLD_EXPORTS_TRIE => {
                // linkedit_data_command: dataoff / datasize.
                let d_off = need(off + 8, "LC_DYLD_EXPORTS_TRIE")? as usize;
                let d_size = need(off + 12, "LC_DYLD_EXPORTS_TRIE")? as usize;
                trie = Some((d_off, d_size));
            }
            _ => {}
        }
        off += cmdsize;
    }
    let mut exports = BTreeSet::new();
    if let Some((t_off, t_size)) = trie
        && t_size > 0
    {
        let data = bytes
            .get(t_off..t_off.saturating_add(t_size))
            .ok_or_else(|| err("export trie extent runs past end of file"))?;
        walk_export_trie(data, &mut exports)?;
    }
    Ok(SharedLibrary {
        soname,
        machine,
        exports,
        data_exports: BTreeSet::new(),
    })
}

/// Collect every terminal node's name from a dyld export trie. A node
/// is `uleb128 terminal-size`, that many payload bytes (flags and
/// per-kind fields -- skipped whole, since only the name matters
/// here), a child count byte, then per child a name-fragment cstr and
/// a `uleb128` offset of the child node from the start of the trie.
fn walk_export_trie(trie: &[u8], out: &mut BTreeSet<String>) -> Result<(), C5Error> {
    fn uleb(trie: &[u8], at: &mut usize) -> Result<u64, C5Error> {
        let mut v: u64 = 0;
        let mut shift = 0u32;
        loop {
            let b = *trie
                .get(*at)
                .ok_or_else(|| err("export trie truncated in a uleb128"))?;
            *at += 1;
            if shift >= 63 && b > 1 {
                return Err(err("export trie uleb128 overflows 64 bits"));
            }
            v |= u64::from(b & 0x7F) << shift;
            if b & 0x80 == 0 {
                return Ok(v);
            }
            shift += 7;
        }
    }
    // Iterative DFS. A malformed trie could point children back up the
    // tree; the visited set bounds the walk by the node count.
    let mut visited: BTreeSet<usize> = BTreeSet::new();
    let mut stack: Vec<(usize, Vec<u8>)> = alloc::vec![(0usize, Vec::new())];
    while let Some((node, prefix)) = stack.pop() {
        if !visited.insert(node) {
            continue;
        }
        let mut at = node;
        let term = uleb(trie, &mut at)? as usize;
        if term > 0 {
            if at + term > trie.len() {
                return Err(err("export trie terminal payload truncated"));
            }
            let name =
                core::str::from_utf8(&prefix).map_err(|_| err("export trie name is not UTF-8"))?;
            out.insert(name.strip_prefix('_').unwrap_or(name).to_string());
            at += term;
        }
        let children = *trie
            .get(at)
            .ok_or_else(|| err("export trie truncated at a child count"))?;
        at += 1;
        for _ in 0..children {
            let rest = &trie[at.min(trie.len())..];
            let end = rest
                .iter()
                .position(|&b| b == 0)
                .ok_or_else(|| err("export trie edge label not terminated"))?;
            let mut label = prefix.clone();
            label.extend_from_slice(&rest[..end]);
            at += end + 1;
            let child = uleb(trie, &mut at)? as usize;
            if child >= trie.len() {
                return Err(err("export trie child offset out of range"));
            }
            stack.push((child, label));
        }
    }
    Ok(())
}

/// True when `bytes` opens a `tapi-tbd` text stub of any version.
pub fn is_tbd(bytes: &[u8]) -> bool {
    bytes.starts_with(b"--- !tapi-tbd")
}

/// One `!tapi-tbd` document after scanning: its install name, the
/// `<arch>-<platform>` targets it covers, the reexported library
/// install names, and the exported symbol names (targets already
/// filtered, underscore not yet stripped).
struct TbdDoc {
    install_name: String,
    targets: Vec<String>,
    reexported_libs: Vec<(Vec<String>, Vec<String>)>,
    /// `(entry targets, symbol names)` from `exports:` and
    /// `reexports:` sections. `objc-*` lists are dropped: their
    /// entries name ObjC metadata, which C code cannot reference.
    symbols: Vec<(Vec<String>, Vec<String>)>,
}

/// Parse a version-4 `.tbd` text stub for one `<arch>-<platform>`
/// target, e.g. `("arm64", "macos")`. The primary document is the
/// file's first; documents its `reexported-libraries` name are folded
/// in transitively when they are inlined in the same file, which is
/// how the SDK ships umbrella libraries. An `arm64` request accepts an
/// `arm64e` slice when no plain one exists -- the SDK's libSystem
/// umbrella document declares only `arm64e-macos`, and the export
/// surface is what matters here, not the slice's code.
pub fn parse_tbd(text: &str, arch: &str, platform: &str) -> Result<SharedLibrary, C5Error> {
    let machine = match arch {
        "arm64" => NativeMachine::Aarch64,
        "x86_64" => NativeMachine::X86_64,
        other => {
            return Err(err(&format!(
                "tbd arch `{other}` is not one of arm64 / x86_64"
            )));
        }
    };
    let docs = scan_tbd_documents(text)?;
    let Some(primary) = docs.first() else {
        return Err(err("tbd holds no document"));
    };
    let exact = format!("{arch}-{platform}");
    let fallback = if arch == "arm64" {
        Some(format!("arm64e-{platform}"))
    } else {
        None
    };
    let matches = |targets: &[String]| -> bool {
        targets.iter().any(|t| t == &exact)
            || fallback
                .as_ref()
                .is_some_and(|f| targets.iter().any(|t| t == f))
    };
    if !matches(&primary.targets) {
        return Err(err(&format!(
            "tbd for `{}` has no {exact} target (targets: {})",
            primary.install_name,
            primary.targets.join(", "),
        )));
    }
    let mut exports: BTreeSet<String> = BTreeSet::new();
    let mut pending: Vec<&TbdDoc> = alloc::vec![primary];
    let mut folded: BTreeSet<&str> = BTreeSet::new();
    folded.insert(primary.install_name.as_str());
    while let Some(doc) = pending.pop() {
        for (targets, names) in &doc.symbols {
            if !matches(targets) {
                continue;
            }
            for n in names {
                exports.insert(n.strip_prefix('_').unwrap_or(n).to_string());
            }
        }
        for (targets, libs) in &doc.reexported_libs {
            if !matches(targets) {
                continue;
            }
            for lib in libs {
                if !folded.insert(lib.as_str()) {
                    continue;
                }
                // TODO: a reexported library with no inlined document
                // would need resolving against the SDK tree; every
                // umbrella the SDK ships inlines its members, so a
                // miss only drops that library's names.
                if let Some(d) = docs.iter().find(|d| &d.install_name == lib) {
                    pending.push(d);
                }
            }
        }
    }
    Ok(SharedLibrary {
        soname: primary.install_name.clone(),
        machine,
        exports,
        data_exports: BTreeSet::new(),
    })
}

/// Split a `.tbd` file into its `!tapi-tbd` documents and scan each.
/// Only version 4 is read; the earlier `!tapi-tbd-v3` schema spells
/// its lists differently and the SDKs stopped shipping it.
fn scan_tbd_documents(text: &str) -> Result<Vec<TbdDoc>, C5Error> {
    let mut docs: Vec<TbdDoc> = Vec::new();
    let mut current: Option<Vec<&str>> = None;
    for line in text.lines() {
        if line.starts_with("---") {
            let tag = line.trim_start_matches('-').trim();
            if !tag.is_empty() && tag != "!tapi-tbd" {
                return Err(err(&format!(
                    "unsupported tbd document tag `{tag}` (only !tapi-tbd version 4 is read)",
                )));
            }
            if let Some(doc) = current.take() {
                docs.push(scan_tbd_document(&doc)?);
            }
            current = Some(Vec::new());
        } else if line.trim() == "..." {
            if let Some(doc) = current.take() {
                docs.push(scan_tbd_document(&doc)?);
            }
        } else if let Some(doc) = current.as_mut() {
            doc.push(line);
        }
    }
    if let Some(doc) = current.take() {
        docs.push(scan_tbd_document(&doc)?);
    }
    Ok(docs)
}

/// Scan one document's lines. Flow lists (`[ ... ]`) are joined until
/// their brackets balance, so a list may span lines; brackets inside
/// quoted names do not count.
fn scan_tbd_document(lines: &[&str]) -> Result<TbdDoc, C5Error> {
    // Logical lines: join while an unbalanced `[` is open.
    let mut logical: Vec<String> = Vec::new();
    let mut open = 0i32;
    for line in lines {
        if open > 0 {
            let joined = logical.last_mut().expect("open list has a first line");
            joined.push(' ');
            joined.push_str(line.trim());
        } else {
            logical.push((*line).to_string());
        }
        open += bracket_balance(line);
        if open < 0 {
            return Err(err("unbalanced `]` in a tbd flow list"));
        }
    }
    if open != 0 {
        return Err(err("unterminated `[` flow list in a tbd document"));
    }

    let mut doc = TbdDoc {
        install_name: String::new(),
        targets: Vec::new(),
        reexported_libs: Vec::new(),
        symbols: Vec::new(),
    };
    let mut version_ok = false;
    // Which list section the walk is inside, and the targets of the
    // section entry being filled (`- targets: [...]` opens an entry).
    enum Section {
        None,
        Symbols,
        ReexportedLibs,
        Skip,
    }
    let mut section = Section::None;
    let mut entry_targets: Vec<String> = Vec::new();
    for line in &logical {
        let indented = line.starts_with(' ') || line.starts_with('\t');
        let body = line.trim_start();
        if body.is_empty() || body.starts_with('#') {
            continue;
        }
        let (item, body) = match body.strip_prefix("- ") {
            Some(rest) => (true, rest),
            None => (false, body),
        };
        let Some((key, value)) = body.split_once(':') else {
            continue;
        };
        let key = key.trim();
        let value = value.trim();
        // A `- ` item belongs to the open section whatever its
        // indentation; YAML allows a sequence at its parent key's
        // column.
        if !indented && !item {
            // Top-level keys. A scalar key closes any open section.
            match key {
                "tbd-version" => {
                    section = Section::None;
                    if value != "4" {
                        return Err(err(&format!(
                            "tbd-version {value} is not supported (only version 4 is read)",
                        )));
                    }
                    version_ok = true;
                }
                "install-name" => {
                    section = Section::None;
                    doc.install_name = unquote(value).to_string();
                }
                "targets" => {
                    section = Section::None;
                    doc.targets = flow_list(value)?;
                }
                "exports" | "reexports" => section = Section::Symbols,
                "reexported-libraries" => section = Section::ReexportedLibs,
                // A key with a value is a scalar; a bare `key:` opens
                // a block this reader does not use.
                _ => {
                    section = if value.is_empty() {
                        Section::Skip
                    } else {
                        Section::None
                    }
                }
            }
            continue;
        }
        // Indented: an entry key inside the open section.
        if item && key == "targets" {
            entry_targets = flow_list(value)?;
            continue;
        }
        match section {
            Section::Symbols => {
                if matches!(key, "symbols" | "weak-symbols" | "thread-local-symbols") {
                    doc.symbols.push((entry_targets.clone(), flow_list(value)?));
                }
            }
            Section::ReexportedLibs => {
                if key == "libraries" {
                    doc.reexported_libs
                        .push((entry_targets.clone(), flow_list(value)?));
                }
            }
            Section::None | Section::Skip => {}
        }
    }
    if !version_ok {
        return Err(err("tbd document carries no `tbd-version: 4`"));
    }
    if doc.install_name.is_empty() {
        return Err(err("tbd document carries no install-name"));
    }
    Ok(doc)
}

/// Net `[` minus `]` on a line, ignoring brackets inside quotes.
fn bracket_balance(line: &str) -> i32 {
    let mut n = 0i32;
    let mut quote: Option<char> = None;
    for c in line.chars() {
        match quote {
            Some(q) => {
                if c == q {
                    quote = None;
                }
            }
            None => match c {
                '\'' | '"' => quote = Some(c),
                '[' => n += 1,
                ']' => n -= 1,
                '#' => break,
                _ => {}
            },
        }
    }
    n
}

/// Parse a flow list `[ a, b, 'c' ]` into its unquoted items.
fn flow_list(value: &str) -> Result<Vec<String>, C5Error> {
    let inner = value
        .strip_prefix('[')
        .and_then(|v| v.strip_suffix(']'))
        .ok_or_else(|| err(&format!("expected a `[ ... ]` flow list, got `{value}`")))?;
    let mut out = Vec::new();
    let mut item = String::new();
    let mut quote: Option<char> = None;
    for c in inner.chars() {
        match quote {
            Some(q) => {
                if c == q {
                    quote = None;
                } else {
                    item.push(c);
                }
            }
            None => match c {
                '\'' | '"' => quote = Some(c),
                ',' => {
                    let t = item.trim();
                    if !t.is_empty() {
                        out.push(t.to_string());
                    }
                    item.clear();
                }
                _ => item.push(c),
            },
        }
    }
    if quote.is_some() {
        return Err(err("unterminated quote in a tbd flow list"));
    }
    let t = item.trim();
    if !t.is_empty() {
        out.push(t.to_string());
    }
    Ok(out)
}

fn unquote(value: &str) -> &str {
    for q in ['\'', '"'] {
        if let Some(v) = value.strip_prefix(q).and_then(|v| v.strip_suffix(q)) {
            return v;
        }
    }
    value
}

#[cfg(all(test, feature = "std"))]
mod tests {
    use super::*;
    use crate::c5::object::mach_o::build_export_trie as build_trie;

    /// Assemble a minimal MH_DYLIB image: header, LC_ID_DYLIB, and one
    /// trie-bearing load command (`LC_DYLD_EXPORTS_TRIE` or the
    /// `LC_DYLD_INFO_ONLY` form), with the trie at the file tail.
    fn dylib(install_name: &str, trie: &[u8], via_dyld_info: bool) -> Vec<u8> {
        let name_bytes = install_name.len() + 1;
        let id_size = (24 + name_bytes).next_multiple_of(8);
        let trie_cmd_size = if via_dyld_info { 48 } else { 16 };
        let sizeofcmds = id_size + trie_cmd_size;
        let trie_off = 32 + sizeofcmds;
        let mut o = Vec::new();
        o.extend_from_slice(&MH_MAGIC_64.to_le_bytes());
        o.extend_from_slice(&0x0100_000Cu32.to_le_bytes()); // CPU_TYPE_ARM64
        o.extend_from_slice(&0u32.to_le_bytes());
        o.extend_from_slice(&MH_DYLIB.to_le_bytes());
        o.extend_from_slice(&2u32.to_le_bytes());
        o.extend_from_slice(&(sizeofcmds as u32).to_le_bytes());
        o.extend_from_slice(&0u32.to_le_bytes());
        o.extend_from_slice(&0u32.to_le_bytes());
        o.extend_from_slice(&LC_ID_DYLIB.to_le_bytes());
        o.extend_from_slice(&(id_size as u32).to_le_bytes());
        o.extend_from_slice(&24u32.to_le_bytes()); // name offset
        o.extend_from_slice(&[0u8; 12]); // timestamp + versions
        o.extend_from_slice(install_name.as_bytes());
        o.resize(32 + id_size, 0);
        if via_dyld_info {
            o.extend_from_slice(&LC_DYLD_INFO_ONLY.to_le_bytes());
            o.extend_from_slice(&48u32.to_le_bytes());
            o.extend_from_slice(&[0u8; 32]); // rebase/bind/weak/lazy off+size
            o.extend_from_slice(&(trie_off as u32).to_le_bytes());
            o.extend_from_slice(&(trie.len() as u32).to_le_bytes());
        } else {
            o.extend_from_slice(&LC_DYLD_EXPORTS_TRIE.to_le_bytes());
            o.extend_from_slice(&16u32.to_le_bytes());
            o.extend_from_slice(&(trie_off as u32).to_le_bytes());
            o.extend_from_slice(&(trie.len() as u32).to_le_bytes());
        }
        o.extend_from_slice(trie);
        o
    }

    /// Both trie-bearing load commands resolve, the trie round-trips
    /// through the image writer's builder, and names lose one leading
    /// underscore.
    #[test]
    fn dylib_exports_read_from_either_trie_command() {
        let trie = build_trie(&[
            ("_printf".to_string(), 0x1000, 0),
            ("_print".to_string(), 0x2000, 0),
            ("_malloc".to_string(), 0x3000, 0),
            ("dyld_stub_binder".to_string(), 0x4000, 0),
        ]);
        for via_dyld_info in [false, true] {
            let img = dylib("/usr/lib/libdemo.dylib", &trie, via_dyld_info);
            assert!(is_mach_o_dylib(&img));
            let lib = parse_mach_o_dylib(&img).expect("parse dylib");
            assert_eq!(lib.soname, "/usr/lib/libdemo.dylib");
            let names: Vec<&str> = lib.exports.iter().map(String::as_str).collect();
            assert_eq!(names, ["dyld_stub_binder", "malloc", "print", "printf"]);
            assert!(lib.data_exports.is_empty());
        }
    }

    /// A trie whose child offset points back at an ancestor must not
    /// hang the walk; truncated payloads are reported.
    #[test]
    fn export_trie_malformations_are_rejected_or_bounded() {
        // Root: no terminal, one child "a" pointing at offset 0 (a cycle).
        let cycle = [0u8, 1, b'a', 0, 0];
        let mut out = BTreeSet::new();
        walk_export_trie(&cycle, &mut out).expect("cycle walk terminates");
        assert!(out.is_empty());
        // Terminal size runs past the end.
        let truncated = [200u8, 1, 0];
        assert!(walk_export_trie(&truncated, &mut BTreeSet::new()).is_err());
        // An empty trie exports nothing.
        walk_export_trie(&[], &mut BTreeSet::new()).expect_err("empty trie has no root node");
    }

    #[test]
    fn non_dylib_images_are_refused() {
        assert!(!is_mach_o_dylib(b"\x7fELF"));
        let mut exe = dylib("/usr/lib/x.dylib", &[], false);
        exe[12..16].copy_from_slice(&2u32.to_le_bytes()); // MH_EXECUTE
        assert!(!is_mach_o_dylib(&exe));
        assert!(parse_mach_o_dylib(&exe).is_err());
    }

    const UMBRELLA: &str = "\
--- !tapi-tbd
tbd-version:     4
targets:         [ x86_64-macos, arm64e-macos ]
install-name:    '/usr/lib/libDemo.dylib'
current-version: 1356
reexported-libraries:
  - targets:         [ x86_64-macos, arm64e-macos ]
    libraries:       [ '/usr/lib/system/libinner.dylib', '/usr/lib/system/libmissing.dylib' ]
exports:
  - targets:         [ x86_64-macos ]
    symbols:         [ '_only_x86' ]
  - targets:         [ x86_64-macos, arm64e-macos ]
    symbols:         [ ___stack_chk_guard, _umbrella_fn,
                       _wrapped_name ]
    weak-symbols:    [ _weak_fn ]
--- !tapi-tbd
tbd-version:     4
targets:         [ x86_64-macos, arm64-macos, arm64e-macos ]
install-name:    '/usr/lib/system/libinner.dylib'
exports:
  - targets:         [ x86_64-macos, arm64-macos, arm64e-macos ]
    symbols:         [ _inner_fn ]
    thread-local-symbols: [ _inner_tls ]
    objc-classes:    [ SkippedClass ]
...
";

    /// The umbrella folds its inlined reexported document, entries are
    /// filtered by target with the arm64 -> arm64e fallback, one
    /// underscore is stripped, and objc lists are dropped.
    #[test]
    fn tbd_umbrella_resolves_for_arm64_via_arm64e() {
        let lib = parse_tbd(UMBRELLA, "arm64", "macos").expect("parse tbd");
        assert_eq!(lib.soname, "/usr/lib/libDemo.dylib");
        let names: Vec<&str> = lib.exports.iter().map(String::as_str).collect();
        assert_eq!(
            names,
            [
                "__stack_chk_guard",
                "inner_fn",
                "inner_tls",
                "umbrella_fn",
                "weak_fn",
                "wrapped_name",
            ],
        );
        // The exact arm64 document is reachable directly too.
        let inner_only = parse_tbd(
            UMBRELLA
                .split("--- !tapi-tbd")
                .nth(2)
                .map(|d| format!("--- !tapi-tbd{d}"))
                .unwrap()
                .as_str(),
            "arm64",
            "macos",
        )
        .expect("inner doc alone");
        assert_eq!(inner_only.soname, "/usr/lib/system/libinner.dylib");
        // x86_64 sees its extra entry and no fallback is involved.
        let x86 = parse_tbd(UMBRELLA, "x86_64", "macos").expect("x86_64");
        assert!(x86.exports.contains("only_x86"));
        // A platform none of the documents cover is refused.
        let e = parse_tbd(UMBRELLA, "arm64", "ios").expect_err("no ios target");
        assert!(format!("{e}").contains("no arm64-ios target"), "{e}");
    }

    #[test]
    fn tbd_versions_other_than_4_are_refused() {
        let v3 = "--- !tapi-tbd-v3\narchs: [ arm64 ]\ninstall-name: /usr/lib/libx.dylib\n...\n";
        assert!(is_tbd(v3.as_bytes()));
        let e = parse_tbd(v3, "arm64", "macos").expect_err("v3 tag");
        assert!(format!("{e}").contains("!tapi-tbd-v3"), "{e}");
        let v2 = "--- !tapi-tbd\ntbd-version: 2\ninstall-name: /usr/lib/libx.dylib\n";
        assert!(parse_tbd(v2, "arm64", "macos").is_err());
        assert!(!is_tbd(b"GROUP ( libfoo.so.1 )"));
    }

    /// The real SDK stub for libSystem is the production input: the
    /// umbrella document declares no plain arm64 target, yet the libc
    /// exports must resolve through the inlined reexported documents.
    /// Skipped where no SDK is installed.
    #[test]
    fn sdk_libsystem_tbd_exports_the_libc_surface() {
        let out = std::process::Command::new("xcrun")
            .args(["--show-sdk-path"])
            .output();
        let Ok(out) = out else { return };
        if !out.status.success() {
            return;
        }
        let sdk = String::from_utf8_lossy(&out.stdout).trim().to_string();
        let path = std::path::Path::new(&sdk).join("usr/lib/libSystem.tbd");
        let Ok(text) = std::fs::read_to_string(&path) else {
            return;
        };
        let lib = parse_tbd(&text, "arm64", "macos").expect("parse the SDK libSystem.tbd");
        assert_eq!(lib.soname, "/usr/lib/libSystem.B.dylib");
        for name in [
            "printf",
            "malloc",
            "memcpy",
            "strlen",
            "pthread_create",
            "environ",
        ] {
            assert!(lib.exports.contains(name), "libSystem must export {name}");
        }
        assert!(lib.exports.len() > 1000, "got {}", lib.exports.len());
    }
}

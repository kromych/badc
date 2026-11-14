//! The `.rsrc` section of a PE image built from compiled resource files
//! (`.res`, as rc.exe writes them), as link.exe builds it: the resource
//! directory tree by type, name and language, each level's named entries
//! first in name order and its ID entries after them in ascending order;
//! then the name strings, the data entries and the resource data.

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::vec::Vec;

use crate::c5::diag::Code;
use crate::c5::error::C5Error;

/// A type or name: an ID, or a string of UTF-16 units.
#[derive(Clone, PartialEq, Eq, PartialOrd, Ord)]
enum Key {
    /// Ordered first: named entries precede ID entries.
    Name(Vec<u16>),
    Id(u16),
}

/// Each resource's data by type, name and language.
type Entries<'a> = BTreeMap<(Key, Key, u16), &'a [u8]>;
/// Type -> name -> `(language, data)`, in the order the tables list them.
type Tree<'a> = BTreeMap<&'a Key, BTreeMap<&'a Key, Vec<(u16, &'a [u8])>>>;

fn bad(what: &str) -> C5Error {
    C5Error::hard(Code::MALFORMED_INPUT, format!("resource file: {what}"))
}

/// Whether `bytes` is a compiled resource file: one opening with the empty
/// entry rc.exe writes, of no data and a 32-byte header naming type 0.
pub fn is_res(bytes: &[u8]) -> bool {
    bytes.len() >= 32
        && bytes[..8] == [0, 0, 0, 0, 0x20, 0, 0, 0]
        && bytes[8..16] == [0xff, 0xff, 0, 0, 0xff, 0xff, 0, 0]
}

fn u16_at(b: &[u8], off: usize) -> Result<u16, C5Error> {
    b.get(off..off + 2)
        .map(|s| u16::from_le_bytes([s[0], s[1]]))
        .ok_or_else(|| bad("entry runs past the end"))
}

fn u32_at(b: &[u8], off: usize) -> Result<u32, C5Error> {
    b.get(off..off + 4)
        .map(|s| u32::from_le_bytes([s[0], s[1], s[2], s[3]]))
        .ok_or_else(|| bad("entry runs past the end"))
}

/// The type or name field at `off`: an ordinal (`0xFFFF` then the ID) or
/// a NUL-terminated UTF-16 string, and the offset past it.
fn key_at(b: &[u8], mut off: usize) -> Result<(Key, usize), C5Error> {
    if u16_at(b, off)? == 0xffff {
        return Ok((Key::Id(u16_at(b, off + 2)?), off + 4));
    }
    let mut units = Vec::new();
    loop {
        let u = u16_at(b, off)?;
        off += 2;
        if u == 0 {
            return Ok((Key::Name(units), off));
        }
        units.push(u);
    }
}

/// `(type, name, language) -> data` over every entry of `files`. A later
/// entry of the same three keys is a duplicate, as link.exe reports it.
fn entries(files: &[Vec<u8>]) -> Result<Entries<'_>, C5Error> {
    let mut out = BTreeMap::new();
    for b in files {
        let mut at = 0;
        while at + 8 <= b.len() {
            let data_size = u32_at(b, at)? as usize;
            let header_size = u32_at(b, at + 4)? as usize;
            let (ty, next) = key_at(b, at + 8)?;
            let (name, next) = key_at(b, next)?;
            let fixed = (next - at).next_multiple_of(4) + at;
            let language = u16_at(b, fixed + 6)?;
            let start = at + header_size;
            let data = b
                .get(start..start + data_size)
                .ok_or_else(|| bad("data runs past the end"))?;
            if !(data_size == 0 && ty == Key::Id(0)) {
                let key = (ty, name, language);
                if out.insert(key, data).is_some() {
                    return Err(bad("two resources of one type, name and language"));
                }
            }
            at = (start + data_size).next_multiple_of(4);
        }
    }
    Ok(out)
}

/// A directory table for `keys` at `out`'s end, each entry's offset given
/// by `target`; a named entry's string offset comes from `strings`.
fn directory(out: &mut Vec<u8>, keys: &[(&Key, u32)], strings: &BTreeMap<&Vec<u16>, u32>) {
    let named = keys
        .iter()
        .filter(|(k, _)| matches!(k, Key::Name(_)))
        .count();
    out.extend([0u8; 12]);
    out.extend((named as u16).to_le_bytes());
    out.extend(((keys.len() - named) as u16).to_le_bytes());
    for (key, target) in keys {
        let name = match key {
            Key::Name(units) => 0x8000_0000 | strings[units],
            Key::Id(id) => u32::from(*id),
        };
        out.extend(name.to_le_bytes());
        out.extend(target.to_le_bytes());
    }
}

/// The section's bytes, placed at `rva`.
pub fn build_rsrc(rva: u32, files: &[Vec<u8>]) -> Result<Vec<u8>, C5Error> {
    let all = entries(files)?;
    let mut tree = Tree::new();
    for ((ty, name, lang), data) in &all {
        tree.entry(ty)
            .or_default()
            .entry(name)
            .or_default()
            .push((*lang, data));
    }
    let table = |n: usize| 16 + 8 * n as u32;
    let mut dirs_len = table(tree.len());
    for names in tree.values() {
        dirs_len += table(names.len());
        dirs_len += names.values().map(|langs| table(langs.len())).sum::<u32>();
    }
    // Each name's offset, and the names in the order of their offsets.
    let mut strings: BTreeMap<&Vec<u16>, u32> = BTreeMap::new();
    let mut string_order: Vec<&Vec<u16>> = Vec::new();
    let mut strings_len = 0u32;
    for key in tree
        .keys()
        .copied()
        .chain(tree.values().flat_map(|n| n.keys().copied()))
    {
        if let Key::Name(units) = key
            && !strings.contains_key(units)
        {
            strings.insert(units, dirs_len + strings_len);
            string_order.push(units);
            strings_len += 2 + 2 * units.len() as u32;
        }
    }
    let entries_at = (dirs_len + strings_len).next_multiple_of(4);
    let data_at = (entries_at + 16 * all.len() as u32).next_multiple_of(8);

    // Directories breadth-first: the root, the type tables, the name tables.
    let mut out = Vec::new();
    let mut next_table = table(tree.len());
    let roots: Vec<(&Key, u32)> = (tree.iter())
        .map(|(ty, names)| {
            let at = next_table;
            next_table += table(names.len());
            (*ty, 0x8000_0000 | at)
        })
        .collect();
    directory(&mut out, &roots, &strings);
    let mut name_tables = Vec::new();
    for names in tree.values() {
        let keys: Vec<(&Key, u32)> = (names.iter())
            .map(|(name, langs)| {
                let at = next_table;
                next_table += table(langs.len());
                name_tables.push(langs);
                (*name, 0x8000_0000 | at)
            })
            .collect();
        directory(&mut out, &keys, &strings);
    }
    let mut leaf = entries_at;
    let mut data_off = data_at;
    let mut data_entries = Vec::new();
    let mut blobs = Vec::new();
    for langs in name_tables {
        let ids: Vec<Key> = langs.iter().map(|(l, _)| Key::Id(*l)).collect();
        let keys: Vec<(&Key, u32)> = (ids.iter())
            .map(|k| {
                let at = leaf;
                leaf += 16;
                (k, at)
            })
            .collect();
        directory(&mut out, &keys, &strings);
        for (_, data) in langs {
            data_entries.extend((rva + data_off).to_le_bytes());
            data_entries.extend((data.len() as u32).to_le_bytes());
            data_entries.extend([0u8; 8]);
            blobs.push((data_off, *data));
            data_off = (data_off + data.len() as u32).next_multiple_of(8);
        }
    }
    for units in string_order {
        out.extend((units.len() as u16).to_le_bytes());
        out.extend(units.iter().flat_map(|u| u.to_le_bytes()));
    }
    out.resize(entries_at as usize, 0);
    out.extend(data_entries);
    for (at, data) in blobs {
        out.resize(at as usize, 0);
        out.extend_from_slice(data);
    }
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    /// One `.res` entry with an ID or string type and name, rc.exe's layout.
    fn res_entry(ty: &Key, name: &Key, lang: u16, data: &[u8]) -> Vec<u8> {
        let field = |k: &Key| match k {
            Key::Id(id) => [0xffffu16.to_le_bytes(), id.to_le_bytes()].concat(),
            Key::Name(u) => u.iter().chain([&0]).flat_map(|c| c.to_le_bytes()).collect(),
        };
        let mut head = [field(ty), field(name)].concat();
        head.resize((8 + head.len()).next_multiple_of(4) - 8, 0);
        head.extend(0u32.to_le_bytes());
        head.extend(0x30u16.to_le_bytes());
        head.extend(lang.to_le_bytes());
        head.extend([0u8; 8]);
        let mut e = (data.len() as u32).to_le_bytes().to_vec();
        e.extend(((8 + head.len()) as u32).to_le_bytes());
        e.extend(head);
        e.extend(data);
        e.resize(e.len().next_multiple_of(4), 0);
        e
    }

    /// The directory tree a reader walks by type, name and language reaches
    /// each resource's data through its data entry's RVA; a string name's
    /// entry precedes the ID entries of its table.
    #[test]
    fn the_tree_reaches_each_resource() {
        let null = res_entry(&Key::Id(0), &Key::Id(0), 0, &[]);
        let manifest = res_entry(&Key::Id(24), &Key::Id(1), 0x409, b"<assembly/>");
        let icon_name: Vec<u16> = "APP".encode_utf16().collect();
        let named = res_entry(&Key::Id(14), &Key::Name(icon_name.clone()), 0x409, b"icon");
        let other = res_entry(&Key::Id(14), &Key::Id(7), 0x409, b"seven");
        let file = [null, manifest, named, other].concat();
        assert!(is_res(&file));
        let rva = 0x9000;
        let s = build_rsrc(rva, &[file]).expect("build");
        let u16_ = |o: usize| u16::from_le_bytes([s[o], s[o + 1]]) as usize;
        let u32_ = |o: usize| u32::from_le_bytes(s[o..o + 4].try_into().unwrap()) as usize;
        // Root: two ID entries, types 14 then 24.
        assert_eq!((u16_(12), u16_(14)), (0, 2));
        assert_eq!((u32_(16), u32_(24)), (14, 24));
        let find = |dir: usize, k: usize| -> usize {
            let n = u16_(dir + 12) + u16_(dir + 14);
            (0..n)
                .map(|i| dir + 16 + 8 * i)
                .find(|&e| u32_(e) == k)
                .map(|e| u32_(e + 4) & 0x7fff_ffff)
                .expect("entry")
        };
        let data_of = |entry: usize| {
            let at = u32_(entry) - rva as usize;
            &s[at..at + u32_(entry + 4)]
        };
        let types14 = find(0, 14);
        // The named entry heads table 14 and points at "APP".
        assert_eq!((u16_(types14 + 12), u16_(types14 + 14)), (1, 1));
        let name_off = u32_(types14 + 16) & 0x7fff_ffff;
        assert_eq!(u16_(name_off), 3);
        let seven = find(types14, 7);
        assert_eq!(data_of(find(seven, 0x409)), b"seven");
        let manifest_dir = find(find(0, 24), 1);
        let entry = find(manifest_dir, 0x409);
        assert_eq!(data_of(entry), b"<assembly/>");
        assert_eq!((u32_(entry) - rva as usize) % 8, 0);
    }

    /// A string type and a string name each lead to their own string, which
    /// the table lists where their entries' offsets say.
    #[test]
    fn a_named_type_and_name_keep_their_strings() {
        let units = |t: &str| -> Vec<u16> { t.encode_utf16().collect() };
        let entry = res_entry(
            &Key::Name(units("PROBE")),
            &Key::Name(units("ALPHA")),
            0x409,
            b"x",
        );
        let s = build_rsrc(0x1000, &[entry]).expect("build");
        let u16_ = |o: usize| u16::from_le_bytes([s[o], s[o + 1]]) as usize;
        let u32_ = |o: usize| u32::from_le_bytes(s[o..o + 4].try_into().unwrap()) as usize;
        let string = |word: usize| {
            let at = word & 0x7fff_ffff;
            let units: Vec<u16> = (0..u16_(at)).map(|i| u16_(at + 2 + 2 * i) as u16).collect();
            String::from_utf16(&units).unwrap()
        };
        assert_eq!(string(u32_(16)), "PROBE");
        let names = u32_(20) & 0x7fff_ffff;
        assert_eq!(string(u32_(names + 16)), "ALPHA");
    }
}

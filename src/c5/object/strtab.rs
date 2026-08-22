//! ELF string-table construction.
//!
//! Entries share storage two ways: equal strings resolve to one
//! offset, and a string that is a suffix of another points into that
//! string's tail and shares its terminator. gas and GNU ld build
//! `.strtab` / `.shstrtab` the same way, so an object whose names
//! overlap ("bump" inside "do_bump") pays for the overlap once.

use alloc::vec::Vec;

/// Build a NUL-separated string blob from `names`. Returns the bytes
/// and, per input position, that name's offset. `bytes[0]` is the
/// leading NUL, so an empty name resolves to offset 0 per the ELF
/// convention. Stored strings keep the order they appear in, which is
/// the order gas writes its tables in.
pub(crate) fn build_string_table(names: &[&str]) -> (Vec<u8>, Vec<u32>) {
    // Ordering by reversed bytes places every string immediately
    // before the ones it is a suffix of, so a single comparison
    // against the next entry finds the string that contains it. Equal
    // strings tie on the later position, leaving the first occurrence
    // the one stored.
    let mut order: Vec<u32> = (0..names.len() as u32).collect();
    order.sort_unstable_by(|&a, &b| {
        let (a, b) = (a as usize, b as usize);
        names[a]
            .bytes()
            .rev()
            .cmp(names[b].bytes().rev())
            .then(b.cmp(&a))
    });
    let mut inside: Vec<Option<u32>> = alloc::vec![None; names.len()];
    for w in order.windows(2) {
        let (a, b) = (w[0] as usize, w[1] as usize);
        if !names[a].is_empty() && names[b].ends_with(names[a]) {
            inside[a] = Some(w[1]);
        }
    }
    let mut bytes: Vec<u8> = alloc::vec![0];
    let mut offsets: Vec<u32> = alloc::vec![0; names.len()];
    for (i, s) in names.iter().enumerate() {
        if s.is_empty() || inside[i].is_some() {
            continue;
        }
        offsets[i] = bytes.len() as u32;
        bytes.extend_from_slice(s.as_bytes());
        bytes.push(0);
    }
    // Walking the sorted order backwards resolves each container
    // before the strings that point into it.
    for &i in order.iter().rev() {
        let i = i as usize;
        if let Some(c) = inside[i] {
            let c = c as usize;
            offsets[i] = offsets[c] + (names[c].len() - names[i].len()) as u32;
        }
    }
    (bytes, offsets)
}

#[cfg(test)]
mod tests {
    use super::*;
    use alloc::string::String;

    fn at(bytes: &[u8], off: u32) -> String {
        let s = off as usize;
        let e = bytes[s..].iter().position(|&b| b == 0).unwrap() + s;
        String::from_utf8(bytes[s..e].to_vec()).unwrap()
    }

    #[test]
    fn every_name_reads_back_at_its_offset() {
        let names = [
            "", "abcdef", "cdef", "def", "xdef", "zz", "zz", "f", "gg", "",
        ];
        let (bytes, offs) = build_string_table(&names);
        assert_eq!(bytes[0], 0);
        for (i, n) in names.iter().enumerate() {
            assert_eq!(&at(&bytes, offs[i]), n, "name {i}");
        }
        assert_eq!(offs[0], 0, "the empty name is the leading NUL");
    }

    #[test]
    fn a_suffix_shares_the_containing_string() {
        let names = ["abcdef", "cdef", "def", "xdef", "zz"];
        let (bytes, offs) = build_string_table(&names);
        // Stored once each: "abcdef", "xdef", "zz"; "cdef" and "def"
        // point inside "abcdef", "f" is not a name here.
        assert_eq!(bytes.len(), 1 + 7 + 5 + 3);
        assert_eq!(offs[1], offs[0] + 2);
        assert_eq!(offs[2], offs[0] + 3);
        assert_ne!(offs[3], offs[0]);
    }

    #[test]
    fn equal_names_resolve_to_one_offset() {
        let names = ["dup", "other", "dup"];
        let (bytes, offs) = build_string_table(&names);
        assert_eq!(offs[0], offs[2]);
        assert_eq!(bytes.len(), 1 + 4 + 6);
        assert_eq!(offs[0], 1, "the first occurrence is the stored one");
    }

    /// gas stores the containing strings in the order the names come
    /// in, whatever position the suffixes it absorbed had.
    #[test]
    fn stored_strings_keep_their_input_order() {
        let (bytes, offs) = build_string_table(&["def", "abcdef", "zz", "q"]);
        assert_eq!(&bytes[..], b"\0abcdef\0zz\0q\0");
        assert_eq!(offs, alloc::vec![4, 1, 8, 11]);
    }
}

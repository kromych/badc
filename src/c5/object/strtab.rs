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
/// convention.
pub(crate) fn build_string_table(names: &[&str]) -> (Vec<u8>, Vec<u32>) {
    // Ordering by reversed bytes places every string immediately
    // before the ones it is a suffix of, so a single comparison
    // against the next entry finds the string that contains it.
    let mut order: Vec<u32> = (0..names.len() as u32).collect();
    order.sort_unstable_by(|&a, &b| {
        names[a as usize]
            .bytes()
            .rev()
            .cmp(names[b as usize].bytes().rev())
    });
    let mut bytes: Vec<u8> = alloc::vec![0];
    let mut offsets: Vec<u32> = alloc::vec![0; names.len()];
    let mut next: Option<usize> = None;
    for &i in order.iter().rev() {
        let (i, s) = (i as usize, names[i as usize]);
        if s.is_empty() {
            continue;
        }
        offsets[i] = match next {
            Some(j) if names[j].ends_with(s) => offsets[j] + (names[j].len() - s.len()) as u32,
            _ => {
                let at = bytes.len() as u32;
                bytes.extend_from_slice(s.as_bytes());
                bytes.push(0);
                at
            }
        };
        next = Some(i);
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
    }
}

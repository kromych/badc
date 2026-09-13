//! Identifier formation (C99 6.4.2.1), shared by the preprocessor and the
//! lexer so a name spelled with universal character names, in UTF-8, or in
//! a mix of the two denotes one macro and one symbol.

use alloc::borrow::Cow;
use alloc::format;
use alloc::string::String;
use core::cmp::Ordering;

use super::lexer::{Ucn, scan_ucn};

/// C99 Annex D: the characters a universal character name in an identifier
/// may designate. UTF-8 spellings are held to the same set.
#[rustfmt::skip]
const ANNEX_D: &[(u32, u32)] = &[
    (0x00AA, 0x00AA), (0x00B5, 0x00B5), (0x00B7, 0x00B7), (0x00BA, 0x00BA), (0x00C0, 0x00D6),
    (0x00D8, 0x00F6), (0x00F8, 0x01F5), (0x01FA, 0x0217), (0x0250, 0x02A8), (0x02B0, 0x02B8),
    (0x02BB, 0x02BB), (0x02BD, 0x02C1), (0x02D0, 0x02D1), (0x02E0, 0x02E4), (0x037A, 0x037A),
    (0x0386, 0x0386), (0x0388, 0x038A), (0x038C, 0x038C), (0x038E, 0x03A1), (0x03A3, 0x03CE),
    (0x03D0, 0x03D6), (0x03DA, 0x03DA), (0x03DC, 0x03DC), (0x03DE, 0x03DE), (0x03E0, 0x03E0),
    (0x03E2, 0x03F3), (0x0401, 0x040C), (0x040E, 0x044F), (0x0451, 0x045C), (0x045E, 0x0481),
    (0x0490, 0x04C4), (0x04C7, 0x04C8), (0x04CB, 0x04CC), (0x04D0, 0x04EB), (0x04EE, 0x04F5),
    (0x04F8, 0x04F9), (0x0531, 0x0556), (0x0559, 0x0559), (0x0561, 0x0587), (0x05B0, 0x05B9),
    (0x05BB, 0x05BD), (0x05BF, 0x05BF), (0x05C1, 0x05C2), (0x05D0, 0x05EA), (0x05F0, 0x05F2),
    (0x0621, 0x063A), (0x0640, 0x0652), (0x0660, 0x0669), (0x0670, 0x06B7), (0x06BA, 0x06BE),
    (0x06C0, 0x06CE), (0x06D0, 0x06DC), (0x06E5, 0x06E8), (0x06EA, 0x06ED), (0x06F0, 0x06F9),
    (0x0901, 0x0903), (0x0905, 0x0939), (0x093D, 0x094D), (0x0950, 0x0952), (0x0958, 0x0963),
    (0x0966, 0x096F), (0x0981, 0x0983), (0x0985, 0x098C), (0x098F, 0x0990), (0x0993, 0x09A8),
    (0x09AA, 0x09B0), (0x09B2, 0x09B2), (0x09B6, 0x09B9), (0x09BE, 0x09C4), (0x09C7, 0x09C8),
    (0x09CB, 0x09CD), (0x09DC, 0x09DD), (0x09DF, 0x09E3), (0x09E6, 0x09F1), (0x0A02, 0x0A02),
    (0x0A05, 0x0A0A), (0x0A0F, 0x0A10), (0x0A13, 0x0A28), (0x0A2A, 0x0A30), (0x0A32, 0x0A33),
    (0x0A35, 0x0A36), (0x0A38, 0x0A39), (0x0A3E, 0x0A42), (0x0A47, 0x0A48), (0x0A4B, 0x0A4D),
    (0x0A59, 0x0A5C), (0x0A5E, 0x0A5E), (0x0A66, 0x0A6F), (0x0A74, 0x0A74), (0x0A81, 0x0A83),
    (0x0A85, 0x0A8B), (0x0A8D, 0x0A8D), (0x0A8F, 0x0A91), (0x0A93, 0x0AA8), (0x0AAA, 0x0AB0),
    (0x0AB2, 0x0AB3), (0x0AB5, 0x0AB9), (0x0ABD, 0x0AC5), (0x0AC7, 0x0AC9), (0x0ACB, 0x0ACD),
    (0x0AD0, 0x0AD0), (0x0AE0, 0x0AE0), (0x0AE6, 0x0AEF), (0x0B01, 0x0B03), (0x0B05, 0x0B0C),
    (0x0B0F, 0x0B10), (0x0B13, 0x0B28), (0x0B2A, 0x0B30), (0x0B32, 0x0B33), (0x0B36, 0x0B39),
    (0x0B3D, 0x0B43), (0x0B47, 0x0B48), (0x0B4B, 0x0B4D), (0x0B5C, 0x0B5D), (0x0B5F, 0x0B61),
    (0x0B66, 0x0B6F), (0x0B82, 0x0B83), (0x0B85, 0x0B8A), (0x0B8E, 0x0B90), (0x0B92, 0x0B95),
    (0x0B99, 0x0B9A), (0x0B9C, 0x0B9C), (0x0B9E, 0x0B9F), (0x0BA3, 0x0BA4), (0x0BA8, 0x0BAA),
    (0x0BAE, 0x0BB5), (0x0BB7, 0x0BB9), (0x0BBE, 0x0BC2), (0x0BC6, 0x0BC8), (0x0BCA, 0x0BCD),
    (0x0BE7, 0x0BEF), (0x0C01, 0x0C03), (0x0C05, 0x0C0C), (0x0C0E, 0x0C10), (0x0C12, 0x0C28),
    (0x0C2A, 0x0C33), (0x0C35, 0x0C39), (0x0C3E, 0x0C44), (0x0C46, 0x0C48), (0x0C4A, 0x0C4D),
    (0x0C60, 0x0C61), (0x0C66, 0x0C6F), (0x0C82, 0x0C83), (0x0C85, 0x0C8C), (0x0C8E, 0x0C90),
    (0x0C92, 0x0CA8), (0x0CAA, 0x0CB3), (0x0CB5, 0x0CB9), (0x0CBE, 0x0CC4), (0x0CC6, 0x0CC8),
    (0x0CCA, 0x0CCD), (0x0CDE, 0x0CDE), (0x0CE0, 0x0CE1), (0x0CE6, 0x0CEF), (0x0D02, 0x0D03),
    (0x0D05, 0x0D0C), (0x0D0E, 0x0D10), (0x0D12, 0x0D28), (0x0D2A, 0x0D39), (0x0D3E, 0x0D43),
    (0x0D46, 0x0D48), (0x0D4A, 0x0D4D), (0x0D60, 0x0D61), (0x0D66, 0x0D6F), (0x0E01, 0x0E3A),
    (0x0E40, 0x0E5B), (0x0E81, 0x0E82), (0x0E84, 0x0E84), (0x0E87, 0x0E88), (0x0E8A, 0x0E8A),
    (0x0E8D, 0x0E8D), (0x0E94, 0x0E97), (0x0E99, 0x0E9F), (0x0EA1, 0x0EA3), (0x0EA5, 0x0EA5),
    (0x0EA7, 0x0EA7), (0x0EAA, 0x0EAB), (0x0EAD, 0x0EAE), (0x0EB0, 0x0EB9), (0x0EBB, 0x0EBD),
    (0x0EC0, 0x0EC4), (0x0EC6, 0x0EC6), (0x0EC8, 0x0ECD), (0x0ED0, 0x0ED9), (0x0EDC, 0x0EDD),
    (0x0F00, 0x0F00), (0x0F18, 0x0F19), (0x0F20, 0x0F33), (0x0F35, 0x0F35), (0x0F37, 0x0F37),
    (0x0F39, 0x0F39), (0x0F3E, 0x0F47), (0x0F49, 0x0F69), (0x0F71, 0x0F84), (0x0F86, 0x0F8B),
    (0x0F90, 0x0F95), (0x0F97, 0x0F97), (0x0F99, 0x0FAD), (0x0FB1, 0x0FB7), (0x0FB9, 0x0FB9),
    (0x10A0, 0x10C5), (0x10D0, 0x10F6), (0x1E00, 0x1E9B), (0x1EA0, 0x1EF9), (0x1F00, 0x1F15),
    (0x1F18, 0x1F1D), (0x1F20, 0x1F45), (0x1F48, 0x1F4D), (0x1F50, 0x1F57), (0x1F59, 0x1F59),
    (0x1F5B, 0x1F5B), (0x1F5D, 0x1F5D), (0x1F5F, 0x1F7D), (0x1F80, 0x1FB4), (0x1FB6, 0x1FBC),
    (0x1FBE, 0x1FBE), (0x1FC2, 0x1FC4), (0x1FC6, 0x1FCC), (0x1FD0, 0x1FD3), (0x1FD6, 0x1FDB),
    (0x1FE0, 0x1FEC), (0x1FF2, 0x1FF4), (0x1FF6, 0x1FFC), (0x203F, 0x2040), (0x207F, 0x207F),
    (0x2102, 0x2102), (0x2107, 0x2107), (0x210A, 0x2113), (0x2115, 0x2115), (0x2118, 0x211D),
    (0x2124, 0x2124), (0x2126, 0x2126), (0x2128, 0x2128), (0x212A, 0x2131), (0x2133, 0x2138),
    (0x2160, 0x2182), (0x3005, 0x3007), (0x3021, 0x3029), (0x3041, 0x3093), (0x309B, 0x309C),
    (0x30A1, 0x30F6), (0x30FB, 0x30FC), (0x3105, 0x312C), (0x4E00, 0x9FA5), (0xAC00, 0xD7A3),
];

/// The Annex D digits, which do not begin an identifier (C99 6.4.2.1p3).
#[rustfmt::skip]
const ANNEX_D_DIGITS: &[(u32, u32)] = &[
    (0x0660, 0x0669), (0x06F0, 0x06F9), (0x0966, 0x096F), (0x09E6, 0x09EF), (0x0A66, 0x0A6F),
    (0x0AE6, 0x0AEF), (0x0B66, 0x0B6F), (0x0BE7, 0x0BEF), (0x0C66, 0x0C6F), (0x0CE6, 0x0CEF),
    (0x0D66, 0x0D6F), (0x0E50, 0x0E59), (0x0ED0, 0x0ED9), (0x0F20, 0x0F33),
];

fn in_ranges(ranges: &[(u32, u32)], cp: u32) -> bool {
    ranges
        .binary_search_by(|&(lo, hi)| {
            if hi < cp {
                Ordering::Less
            } else if lo > cp {
                Ordering::Greater
            } else {
                Ordering::Equal
            }
        })
        .is_ok()
}

/// The value and length of the universal character name at `at`, whatever
/// character it designates; `None` without a complete `\u` or `\U` form.
fn ucn_at(bytes: &[u8], at: usize) -> Option<(u32, usize)> {
    if bytes.get(at) != Some(&b'\\') {
        return None;
    }
    let esc = *bytes.get(at + 1)?;
    if !matches!(esc, b'u' | b'U') {
        return None;
    }
    let mut pos = at + 2;
    match scan_ucn(bytes, &mut pos, esc) {
        Ucn::Ok(cp) | Ucn::Invalid(cp) => Some((cp, pos - at)),
        Ucn::Incomplete => None,
    }
}

/// The character and length of the multibyte UTF-8 sequence at `at`; `None`
/// for ASCII, a continuation byte or a malformed sequence.
fn utf8_at(bytes: &[u8], at: usize) -> Option<(u32, usize)> {
    let lead = *bytes.get(at)?;
    let (len, bits) = match lead {
        0xC2..=0xDF => (2, lead & 0x1F),
        0xE0..=0xEF => (3, lead & 0x0F),
        0xF0..=0xF4 => (4, lead & 0x07),
        _ => return None,
    };
    let mut cp = u32::from(bits);
    for &b in bytes.get(at + 1..at + len)? {
        if b & 0xC0 != 0x80 {
            return None;
        }
        cp = (cp << 6) | u32::from(b & 0x3F);
    }
    let shortest = [0, 0, 0x80, 0x800, 0x10000][len];
    (cp >= shortest).then_some((cp, len))
}

/// Length of the identifier character at `at`: an ASCII letter, digit or
/// `_`, a universal character name, or a UTF-8 character in the Annex D
/// ranges; 0 when none is there.
#[inline]
pub(crate) fn char_len(bytes: &[u8], at: usize) -> usize {
    match bytes.get(at) {
        Some(&b) if b.is_ascii_alphanumeric() || b == b'_' => 1,
        Some(&b) if b == b'\\' || b >= 0x80 => extended_char_len(bytes, at),
        _ => 0,
    }
}

/// [`char_len`] at a `\` or a non-ASCII byte, kept out of line so the
/// ASCII test inlines into the scanners.
#[inline(never)]
fn extended_char_len(bytes: &[u8], at: usize) -> usize {
    let found = if bytes[at] == b'\\' {
        ucn_at(bytes, at)
    } else {
        utf8_at(bytes, at).filter(|&(cp, _)| in_ranges(ANNEX_D, cp))
    };
    found.map_or(0, |(_, len)| len)
}

/// Length of the identifier starting at `at`, or 0 when none starts there.
#[inline]
pub(crate) fn ident_len(bytes: &[u8], at: usize) -> usize {
    if bytes.get(at).is_none_or(u8::is_ascii_digit) {
        return 0;
    }
    let mut end = at;
    loop {
        match char_len(bytes, end) {
            0 => return end - at,
            len => end += len,
        }
    }
}

/// Whether an identifier character ends just before `at`, so that a name
/// starting at `at` continues that identifier.
pub(crate) fn char_ends_at(bytes: &[u8], at: usize) -> bool {
    let Some(&last) = at.checked_sub(1).and_then(|i| bytes.get(i)) else {
        return false;
    };
    if last < 0x80 {
        return last.is_ascii_alphanumeric() || last == b'_';
    }
    (2..=4).filter_map(|n| at.checked_sub(n)).any(|start| {
        utf8_at(bytes, start).is_some_and(|(cp, len)| start + len == at && in_ranges(ANNEX_D, cp))
    })
}

/// Whether `s` is exactly one identifier.
pub(crate) fn is_ident(s: &str) -> bool {
    !s.is_empty() && ident_len(s.as_bytes(), 0) == s.len()
}

/// The name an identifier spelling denotes: a universal character name for
/// an Annex D character stands for that character, so the name and the
/// character's UTF-8 spelling key one macro and one symbol.
#[inline]
pub(crate) fn key(spelling: &str) -> Cow<'_, str> {
    if spelling.bytes().any(|b| b == b'\\') {
        Cow::Owned(decode_names(spelling))
    } else {
        Cow::Borrowed(spelling)
    }
}

#[inline(never)]
fn decode_names(spelling: &str) -> String {
    let mut out = String::with_capacity(spelling.len());
    let mut rest = spelling;
    while let Some(cut) = rest.find('\\') {
        out.push_str(&rest[..cut]);
        rest = &rest[cut..];
        let named = ucn_at(rest.as_bytes(), 0)
            .filter(|&(cp, _)| in_ranges(ANNEX_D, cp))
            .and_then(|(cp, len)| Some((char::from_u32(cp)?, len)));
        let (ch, len) = named.unwrap_or(('\\', 1));
        out.push(ch);
        rest = &rest[len..];
    }
    out.push_str(rest);
    out
}

/// The C99 6.4.2.1p3 violation in the identifier `spelling`, if any: a
/// universal character name outside the Annex D ranges, or an Annex D digit
/// beginning the identifier.
pub(crate) fn ident_error(spelling: &str) -> Option<String> {
    let bytes = spelling.as_bytes();
    let mut at = 0;
    while at < bytes.len() {
        let len = char_len(bytes, at);
        if len == 0 {
            return None;
        }
        let ucn = ucn_at(bytes, at);
        let shown = &spelling[at..at + len];
        if ucn.is_some_and(|(cp, _)| !in_ranges(ANNEX_D, cp)) {
            return Some(format!("`{shown}` is not valid in an identifier"));
        }
        let cp = ucn.or_else(|| utf8_at(bytes, at)).map(|(cp, _)| cp);
        if at == 0 && cp.is_some_and(|cp| in_ranges(ANNEX_D_DIGITS, cp)) {
            return Some(format!(
                "`{shown}` is not valid at the start of an identifier"
            ));
        }
        at += len;
    }
    None
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn annex_d_tables_are_sorted_and_hold_the_digits() {
        for table in [ANNEX_D, ANNEX_D_DIGITS] {
            assert!(table.iter().all(|&(lo, hi)| lo <= hi));
            assert!(table.windows(2).all(|w| w[0].1 + 1 < w[1].0), "{table:X?}");
        }
        let count = |t: &[(u32, u32)]| t.iter().map(|&(lo, hi)| hi - lo + 1).sum::<u32>();
        assert_eq!((count(ANNEX_D), count(ANNEX_D_DIGITS)), (34958, 149));
        for &(lo, hi) in ANNEX_D_DIGITS {
            assert!((lo..=hi).all(|cp| in_ranges(ANNEX_D, cp)), "{lo:X}");
        }
    }

    #[test]
    fn identifiers_take_universal_character_names_and_utf8() {
        let len = |s: &str| ident_len(s.as_bytes(), 0);
        assert_eq!(len("caf\\u00e9 x"), 9);
        assert_eq!(len("caf\u{e9}+"), 5);
        assert_eq!(len("\\U000000E9x"), 11);
        // An incomplete name and a character outside Annex D end it; a
        // complete name outside Annex D is diagnosed instead.
        assert_eq!(len("a\\u00e"), 1);
        assert_eq!(len("a\u{d7}b"), 1);
        assert_eq!(len("a\\u00d7b"), 8);
        assert_eq!(len("1a"), 0);
        assert!(char_ends_at("x\u{e9}".as_bytes(), 3));
        assert!(!char_ends_at("\u{d7}".as_bytes(), 2));
        assert!(is_ident("\u{663}x") && !is_ident("a b"));
    }

    #[test]
    fn spellings_of_one_character_share_a_key() {
        assert_eq!(key("caf\\u00e9"), "caf\u{e9}");
        assert_eq!(key("\\U000000E9\\u00E9"), "\u{e9}\u{e9}");
        assert!(matches!(key("plain"), Cow::Borrowed("plain")));
        assert_eq!(key("a\\u00d7"), "a\\u00d7");
    }

    #[test]
    fn constraint_violations_name_the_character() {
        assert_eq!(ident_error("caf\\u00e9"), None);
        assert_eq!(
            ident_error("a\\u0041").as_deref(),
            Some("`\\u0041` is not valid in an identifier")
        );
        assert_eq!(
            ident_error("\\u0663x").as_deref(),
            Some("`\\u0663` is not valid at the start of an identifier")
        );
        assert_eq!(
            ident_error("\u{663}x").as_deref(),
            Some("`\u{663}` is not valid at the start of an identifier")
        );
        assert_eq!(ident_error("x\\u0663"), None);
    }
}

//! The formatted input functions of C99 7.19.6.2 - 7.19.6.14 over a string
//! or a stream, from the call's arguments or a `va_list`.

use alloc::format;
use alloc::vec::Vec;

use crate::c5::error::C5Error;
use crate::c5::host::Host;

use super::super::fenv::{BINARY32, BINARY64};
use super::strtox::{self, is_space};
use super::{Libc, Memory, Varargs};

pub(super) const NAMES: &[&str] = &["sscanf", "vsscanf", "scanf", "vscanf", "fscanf", "vfscanf"];

/// A source of input characters with pushback.
pub(super) trait Input {
    fn get(&mut self) -> Option<u8>;
    fn unget(&mut self, c: u8);
}

/// The characters of a string, its terminator the end of input.
pub(super) struct StrInput {
    bytes: Vec<u8>,
    at: usize,
}

impl Input for StrInput {
    fn get(&mut self) -> Option<u8> {
        let c = self.bytes.get(self.at).copied();
        self.at += usize::from(c.is_some());
        c
    }

    fn unget(&mut self, _c: u8) {
        self.at -= 1;
    }
}

/// An input source and the characters taken from it, for `%n`.
struct Reader<'a> {
    input: &'a mut dyn Input,
    count: usize,
}

impl Reader<'_> {
    fn get(&mut self) -> Option<u8> {
        let c = self.input.get();
        self.count += usize::from(c.is_some());
        c
    }

    fn unget(&mut self, c: Option<u8>) {
        if let Some(c) = c {
            self.count -= 1;
            self.input.unget(c);
        }
    }

    /// The next character of a field with `left` characters to go; none
    /// past them, without reading.
    fn field(&mut self, left: &mut usize) -> Option<u8> {
        if *left == 0 {
            return None;
        }
        *left -= 1;
        self.get()
    }

    fn skip_space(&mut self) -> Option<u8> {
        loop {
            match self.get() {
                Some(c) if is_space(c) => {}
                c => {
                    self.unget(c);
                    return c;
                }
            }
        }
    }
}

/// How a conversion ended a scan early.
enum Stop {
    /// The input ended (C99 7.19.6.2p4), or an encoding error.
    Input,
    /// The input did not match.
    Matching,
}

/// An integer field's characters, read as glibc and FreeBSD's scanners read
/// them: a sign, a `0x` prefix where the base allows one, then digits.
fn int_field(r: &mut Reader<'_>, width: usize, mut base: u32) -> Vec<u8> {
    let mut left = width;
    let mut item = Vec::new();
    let mut c = r.field(&mut left);
    if let Some(s @ (b'+' | b'-')) = c {
        item.push(s);
        c = r.field(&mut left);
    }
    if (base == 0 || base == 16) && c == Some(b'0') {
        item.push(b'0');
        c = r.field(&mut left);
        if let Some(x @ (b'x' | b'X')) = c {
            item.push(x);
            base = 16;
            c = r.field(&mut left);
        } else if base == 0 {
            base = 8;
        }
    } else if base == 0 {
        base = 10;
    }
    while let Some(d) = c.filter(|&d| (d as char).is_digit(base)) {
        item.push(d);
        c = r.field(&mut left);
    }
    r.unget(c);
    item
}

/// A floating field's characters: the longest prefix of the input that
/// begins some subject sequence `strtod` accepts (7.19.6.2p9).
fn float_field(r: &mut Reader<'_>, width: usize) -> Vec<u8> {
    let mut left = width;
    let mut item = Vec::new();
    let mut c = r.field(&mut left);
    if let Some(s @ (b'+' | b'-')) = c {
        item.push(s);
        c = r.field(&mut left);
    }
    let word = match c.map(|c| c.to_ascii_lowercase()) {
        Some(b'i') => Some(&b"infinity"[..]),
        Some(b'n') => Some(&b"nan"[..]),
        _ => None,
    };
    if let Some(word) = word {
        for &w in word {
            match c {
                Some(x) if x.to_ascii_lowercase() == w => item.push(x),
                _ => break,
            }
            c = r.field(&mut left);
        }
        if word == b"nan" && item.len() >= 3 && c == Some(b'(') {
            item.push(b'(');
            c = r.field(&mut left);
            while let Some(x) = c.filter(|x| x.is_ascii_alphanumeric() || *x == b'_') {
                item.push(x);
                c = r.field(&mut left);
            }
            if c == Some(b')') {
                item.push(b')');
                c = r.field(&mut left);
            }
        }
        r.unget(c);
        return item;
    }
    let mut hex = false;
    if c == Some(b'0') {
        item.push(b'0');
        c = r.field(&mut left);
        if let Some(x @ (b'x' | b'X')) = c {
            item.push(x);
            hex = true;
            c = r.field(&mut left);
        }
    }
    let (mut point, mut digits) = (false, item.ends_with(b"0"));
    while let Some(d) = c {
        let digit = if hex {
            d.is_ascii_hexdigit()
        } else {
            d.is_ascii_digit()
        };
        if !(digit || (d == b'.' && !point)) {
            break;
        }
        point |= d == b'.';
        digits |= digit;
        item.push(d);
        c = r.field(&mut left);
    }
    let marker = if hex { b'p' } else { b'e' };
    if digits && c.is_some_and(|e| e.to_ascii_lowercase() == marker) {
        item.push(c.unwrap_or(marker));
        c = r.field(&mut left);
        if let Some(s @ (b'+' | b'-')) = c {
            item.push(s);
            c = r.field(&mut left);
        }
        while let Some(d) = c.filter(|d| d.is_ascii_digit()) {
            item.push(d);
            c = r.field(&mut left);
        }
    }
    r.unget(c);
    item
}

/// The part of a numeric field the conversion takes, `used` of its
/// characters forming a subject sequence. glibc converts that prefix and
/// leaves the rest read, except for an infinity or NaN spelled in part;
/// Apple's libc and the UCRT push the rest back. `None` is a matching
/// failure.
fn take(r: &mut Reader<'_>, libc: Libc, item: &[u8], used: usize) -> Option<()> {
    if used == 0 {
        return None;
    }
    if libc == Libc::Glibc {
        let word = item
            .iter()
            .find(|c| !matches!(c, b'+' | b'-'))
            .is_some_and(|c| c.is_ascii_alphabetic());
        return (!word || used == item.len()).then_some(());
    }
    for &c in item[used..].iter().rev() {
        r.unget(Some(c));
    }
    Some(())
}

/// A `%[` scanset: the characters it names, negated after `^`; a `]` first
/// is one of them and `-` between two characters a range.
fn scanset(fmt: &[u8], mut i: usize) -> ([bool; 256], usize) {
    let negate = fmt.get(i) == Some(&b'^');
    i += usize::from(negate);
    let mut set = [false; 256];
    let start = i;
    while let Some(&c) = fmt.get(i) {
        if c == b']' && i > start {
            i += 1;
            break;
        }
        match (fmt.get(i + 1), fmt.get(i + 2)) {
            (Some(b'-'), Some(&hi)) if hi != b']' && hi >= c => {
                set[c as usize..=hi as usize].fill(true);
                i += 3;
            }
            _ => {
                set[c as usize] = true;
                i += 1;
            }
        }
    }
    if negate {
        set.iter_mut().for_each(|s| *s = !*s);
    }
    (set, i)
}

/// Length modifiers (7.19.6.2p11).
#[derive(Clone, Copy, PartialEq, Eq)]
enum Len {
    Char,
    Short,
    None,
    Long,
    LongLong,
    Max,
    LongDouble,
}

/// The scanner (7.19.6.2): the count of assigned input items, or EOF when
/// the input ends before the first one -- glibc's and Apple's libc's
/// reading, which counts a suppressed conversion as none.
pub(super) fn scan(
    fmt: &[u8],
    input: &mut dyn Input,
    mut args: Varargs<'_>,
    mem: &mut Memory,
) -> Result<i64, C5Error> {
    let libc = Libc::of(mem.target);
    let mut r = Reader { input, count: 0 };
    let mut assigned = 0i64;
    let mut i = 0;
    let stop = loop {
        let Some(&f) = fmt.get(i) else {
            return Ok(assigned);
        };
        i += 1;
        if is_space(f) {
            while fmt.get(i).is_some_and(|&c| is_space(c)) {
                i += 1;
            }
            r.skip_space();
            continue;
        }
        if f != b'%' {
            match r.get() {
                Some(c) if c == f => continue,
                None => break Stop::Input,
                c => {
                    r.unget(c);
                    break Stop::Matching;
                }
            }
        }
        let suppress = fmt.get(i) == Some(&b'*');
        i += usize::from(suppress);
        let mut width = None;
        while let Some(d) = fmt.get(i).filter(|d| d.is_ascii_digit()) {
            width = Some(width.unwrap_or(0) * 10 + usize::from(d - b'0'));
            i += 1;
        }
        let len = match (fmt.get(i), fmt.get(i + 1)) {
            (Some(b'h'), Some(b'h')) => (Len::Char, 2),
            (Some(b'h'), _) => (Len::Short, 1),
            (Some(b'l'), Some(b'l')) => (Len::LongLong, 2),
            (Some(b'l'), _) => (Len::Long, 1),
            (Some(b'q'), _) => (Len::LongLong, 1),
            (Some(b'j' | b'z' | b't'), _) => (Len::Max, 1),
            (Some(b'L'), _) => (Len::LongDouble, 1),
            _ => (Len::None, 0),
        };
        i += len.1;
        let len = len.0;
        let Some(&conv) = fmt.get(i) else {
            break Stop::Matching;
        };
        i += 1;
        if !matches!(conv, b'[' | b'c' | b'n') && r.skip_space().is_none() && conv != b'%' {
            break Stop::Input;
        }
        match conv {
            b'%' => match r.get() {
                Some(b'%') => {}
                None => break Stop::Input,
                c => {
                    r.unget(c);
                    break Stop::Matching;
                }
            },
            b'n' => {
                if !suppress {
                    store_int(mem, &mut args, len, r.count as u64)?;
                }
            }
            b'c' | b's' | b'[' => {
                let width = width.unwrap_or(if conv == b'c' { 1 } else { usize::MAX });
                let (set, next) = match conv {
                    b'[' => scanset(fmt, i),
                    b's' => {
                        let mut set = [true; 256];
                        for c in [b' ', b'\t', b'\n', 0x0b, 0x0c, b'\r'] {
                            set[c as usize] = false;
                        }
                        (set, i)
                    }
                    _ => ([true; 256], i),
                };
                i = next;
                let mut left = width;
                let mut text = Vec::new();
                loop {
                    match r.field(&mut left) {
                        Some(c) if set[c as usize] => text.push(c),
                        c => {
                            r.unget(c);
                            break;
                        }
                    }
                }
                if text.is_empty() {
                    let at_end = r.get();
                    r.unget(at_end);
                    break if at_end.is_none() {
                        Stop::Input
                    } else {
                        Stop::Matching
                    };
                }
                if !suppress {
                    let dst = args.next(mem)? as usize;
                    store_chars(mem, dst, &text, len == Len::Long, conv != b'c')?;
                    assigned += 1;
                }
            }
            b'd' | b'i' | b'o' | b'u' | b'x' | b'X' | b'p' => {
                let base = match conv {
                    b'd' | b'u' => 10,
                    b'i' => 0,
                    b'o' => 8,
                    _ => 16,
                };
                let item = int_field(&mut r, width.unwrap_or(usize::MAX), base);
                let sub = strtox::parse_int(&item, base);
                let used = sub.as_ref().map_or(0, |s| s.len);
                if take(&mut r, libc, &item, used).is_none() {
                    break Stop::Matching;
                }
                if !suppress {
                    let sub = sub.as_ref().expect("a subject");
                    let signed = matches!(conv, b'd' | b'i');
                    let (v, _) = strtox::int_value(sub, 64, signed);
                    let len = if conv == b'p' { Len::Max } else { len };
                    store_int(mem, &mut args, len, v as u64)?;
                    assigned += 1;
                }
            }
            b'a' | b'A' | b'e' | b'E' | b'f' | b'F' | b'g' | b'G' => {
                let item = float_field(&mut r, width.unwrap_or(usize::MAX));
                let sub = strtox::parse_float(&item, b'.');
                let used = sub.as_ref().map_or(0, |s| s.1);
                if take(&mut r, libc, &item, used).is_none() {
                    break Stop::Matching;
                }
                if !suppress {
                    let (sub, _) = sub.expect("a subject");
                    let dst = args.next(mem)? as usize;
                    let bytes = match len {
                        Len::LongDouble => {
                            let kind = mem.target.long_double();
                            let f = strtox::long_double_format(kind);
                            let bits = strtox::float_value(&mut mem.fp, &sub, f).0;
                            strtox::long_double_bytes(kind, bits)
                        }
                        Len::Long => {
                            let bits = strtox::float_value(&mut mem.fp, &sub, BINARY64).0;
                            (bits as u64).to_le_bytes().to_vec()
                        }
                        _ => {
                            let bits = strtox::float_value(&mut mem.fp, &sub, BINARY32).0;
                            (bits as u32).to_le_bytes().to_vec()
                        }
                    };
                    mem.write_checked(dst, &bytes)?;
                    assigned += 1;
                }
            }
            _ => break Stop::Matching,
        }
    };
    Ok(match stop {
        Stop::Input if assigned == 0 => -1,
        _ => assigned,
    })
}

/// Store `v` through the next pointer argument in the integer type `len`
/// names.
fn store_int(mem: &mut Memory, args: &mut Varargs<'_>, len: Len, v: u64) -> Result<(), C5Error> {
    let dst = args.next(mem)? as usize;
    let n = match len {
        Len::Char => 1,
        Len::Short => 2,
        Len::None => 4,
        Len::Long => mem.target.long_width_bytes(),
        _ => 8,
    };
    mem.write_checked(dst, &v.to_le_bytes()[..n])
}

/// Store the characters of a `%c`, `%s` or `%[` field: bytes, or under `l`
/// the target's `wchar_t` each byte maps to in the "C" locale, and a
/// terminator for a string.
fn store_chars(
    mem: &mut Memory,
    dst: usize,
    text: &[u8],
    wide: bool,
    terminate: bool,
) -> Result<(), C5Error> {
    let unit = if wide {
        mem.target.wchar_type(false).bytes
    } else {
        1
    };
    let mut out = Vec::with_capacity((text.len() + 1) * unit);
    for &c in text.iter().chain(terminate.then_some(&0)) {
        out.extend_from_slice(&u32::from(c).to_le_bytes()[..unit]);
    }
    mem.write_checked(dst, &out)
}

fn arg(name: &str, args: &[i64], i: usize) -> Result<i64, C5Error> {
    (args.get(i).copied())
        .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {name}: missing argument {}", i + 1)))
}

/// The scanning functions by name; `None` for any other name.
pub(super) fn call<H: Host>(
    name: &str,
    args: &[i64],
    mem: &mut Memory,
    host: &mut H,
) -> Option<Result<i64, C5Error>> {
    if !NAMES.contains(&name) {
        return None;
    }
    Some((|| {
        // The format's position, and the `va_list`'s for a `v` form.
        let (at, list) = match name {
            "scanf" => (0, None),
            "vscanf" => (0, Some(1)),
            "sscanf" | "fscanf" => (1, None),
            _ => (1, Some(2)),
        };
        let fmt = mem.c_string(arg(name, args, at)? as usize)?;
        let varargs = match list {
            Some(i) => Varargs::list(mem, arg(name, args, i)?)?,
            None => Varargs::values(args.get(at + 1..).unwrap_or_default()),
        };
        if name.ends_with("sscanf") {
            let bytes = mem.c_string(arg(name, args, 0)? as usize)?;
            return scan(&fmt, &mut StrInput { bytes, at: 0 }, varargs, mem);
        }
        let file = if at == 0 {
            mem.std_stream(0)
        } else {
            arg(name, args, 0)?
        };
        super::stream::scan_stream(mem, host, file, &fmt, varargs)
    })())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::codegen::Target;

    /// `sscanf(input, fmt, ...)` into one 16-byte cell per conversion: the
    /// count and the cells.
    fn sscanf(target: Target, input: &str, fmt: &str, cells: usize) -> (i64, Vec<[u8; 16]>) {
        let mut mem = Memory::with_stdio(&[0u8; 256], target);
        let ptrs: Vec<i64> = (0..cells).map(|k| 16 * k as i64).collect();
        let mut input = StrInput {
            bytes: input.as_bytes().to_vec(),
            at: 0,
        };
        let n = scan(fmt.as_bytes(), &mut input, Varargs::values(&ptrs), &mut mem).unwrap();
        let out = (0..cells)
            .map(|k| mem.bytes[16 * k..16 * k + 16].try_into().unwrap())
            .collect();
        (n, out)
    }

    fn int(cell: &[u8; 16]) -> i32 {
        i32::from_le_bytes(cell[..4].try_into().unwrap())
    }

    #[test]
    fn counts_and_failures_follow_7_19_6_2() {
        let t = Target::MacOSAarch64;
        assert_eq!(sscanf(t, "", "%d", 1).0, -1);
        assert_eq!(sscanf(t, "  ", "%d", 1).0, -1);
        assert_eq!(sscanf(t, "abc", "%d", 1).0, 0);
        assert_eq!(sscanf(t, "5", "%*d%d", 1).0, -1);
        assert_eq!(
            sscanf(t, "12345", "%3d%d", 2),
            (2, {
                let mut a = [[0u8; 16]; 2];
                a[0][..4].copy_from_slice(&123i32.to_le_bytes());
                a[1][..4].copy_from_slice(&45i32.to_le_bytes());
                a.to_vec()
            })
        );
        let (n, c) = sscanf(t, "abc]-de", "%[]a-c]%[-d]", 2);
        assert_eq!(
            (n, &c[0][..5], &c[1][..3]),
            (2, &b"abc]\0"[..], &b"-d\0"[..])
        );
        let (n, c) = sscanf(t, "  %5", "%% %d", 1);
        assert_eq!((n, int(&c[0])), (1, 5));
    }

    #[test]
    fn a_partial_number_is_pushed_back_or_kept_as_the_library_does() {
        // Apple's libc backs up to "100" and reads "ergs"; glibc keeps the
        // `e` read and converts the 100 before it.
        let (n, c) = sscanf(Target::MacOSAarch64, "100ergs", "%f%s", 2);
        assert_eq!((n, &c[1][..5]), (2, &b"ergs\0"[..]));
        let (n, c) = sscanf(Target::LinuxX64, "100ergs", "%f%s", 2);
        assert_eq!((n, &c[1][..4]), (2, &b"rgs\0"[..]));
        let (n, c) = sscanf(Target::MacOSAarch64, "0x", "%x%n", 2);
        assert_eq!((n, int(&c[1])), (1, 1));
        let (n, c) = sscanf(Target::LinuxX64, "0x", "%x%n", 2);
        assert_eq!((n, int(&c[1])), (1, 2));
        assert_eq!(sscanf(Target::LinuxX64, "infix", "%f", 1).0, 0);
        assert_eq!(sscanf(Target::MacOSAarch64, "infix", "%f", 1).0, 1);
    }

    #[test]
    fn long_double_is_stored_in_the_target_image() {
        let (_, c) = sscanf(Target::LinuxX64, "0.1", "%Lf", 1);
        assert_eq!(
            &c[0][..10],
            &0x3ffb_cccc_cccc_cccc_cccdu128.to_le_bytes()[..10]
        );
        let (_, c) = sscanf(Target::LinuxAarch64, "0.1", "%Lf", 1);
        assert_eq!(
            c[0],
            0x3ffb_9999_9999_9999_9999_9999_9999_999au128.to_le_bytes()
        );
        let (_, c) = sscanf(Target::WindowsX64, "0.1", "%Lf", 1);
        assert_eq!(c[0][..8], 0.1f64.to_le_bytes());
    }
}

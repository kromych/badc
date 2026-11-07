//! The string functions of C99 7.21 with their POSIX, BSD and GNU
//! siblings, and the character functions of 7.4 in the "C" locale.

use alloc::format;
use alloc::vec::Vec;

use crate::c5::error::C5Error;

use super::{AccessKind, Libc, Memory, guest_alloc};

pub(super) const NAMES: &[&str] = &[
    "strlen",
    "strnlen",
    "strcmp",
    "strncmp",
    "strcoll",
    "strxfrm",
    "strcasecmp",
    "strncasecmp",
    "_stricmp",
    "_strnicmp",
    "strcpy",
    "strncpy",
    "stpcpy",
    "stpncpy",
    "strcat",
    "strncat",
    "strchr",
    "strrchr",
    "strchrnul",
    "index",
    "rindex",
    "memchr",
    "memrchr",
    "strstr",
    "strcasestr",
    "memmem",
    "strspn",
    "strcspn",
    "strpbrk",
    "strdup",
    "_strdup",
    "strndup",
    "strtok",
    "strtok_r",
    "bzero",
    "explicit_bzero",
    "bcopy",
    "bcmp",
    "isalnum",
    "isalpha",
    "iscntrl",
    "isdigit",
    "isgraph",
    "islower",
    "isprint",
    "ispunct",
    "isspace",
    "isupper",
    "isxdigit",
    "tolower",
    "toupper",
];

fn arg(name: &str, args: &[i64], i: usize) -> Result<i64, C5Error> {
    (args.get(i).copied())
        .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {name}: missing argument {}", i + 1)))
}

fn ptr(name: &str, args: &[i64], i: usize) -> Result<usize, C5Error> {
    let p = arg(name, args, i)?;
    usize::try_from(p)
        .ok()
        .filter(|&p| p != 0)
        .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {name}: bad pointer 0x{p:x}")))
}

impl Memory {
    /// The length of the string at `addr`, its bytes and terminator
    /// checked as a read.
    fn c_strlen(&self, addr: usize) -> Result<usize, C5Error> {
        let tail = self.bytes.get(addr..).unwrap_or_default();
        let n = tail.iter().position(|&b| b == 0).ok_or_else(|| {
            C5Error::Runtime(format!(
                "vm_ssa: no NUL terminates the string at 0x{addr:x}"
            ))
        })?;
        self.check_data_access(addr, n + 1, AccessKind::Read)?;
        Ok(n)
    }

    /// The length of the string at `addr`, reading no more than `max`
    /// bytes.
    fn c_strnlen(&self, addr: usize, max: usize) -> Result<usize, C5Error> {
        let tail = self.bytes.get(addr..).unwrap_or_default();
        let n = match tail.iter().take(max).position(|&b| b == 0) {
            Some(n) => n,
            None if tail.len() >= max => max,
            None => {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: no NUL terminates the string at 0x{addr:x}"
                )));
            }
        };
        self.check_data_access(addr, (n + 1).min(max), AccessKind::Read)?;
        Ok(n)
    }

    /// `n` bytes at `addr`, checked as a read.
    fn read_checked(&self, addr: usize, n: usize) -> Result<Vec<u8>, C5Error> {
        self.check_data_access(addr, n, AccessKind::Read)?;
        Ok(self.read_bytes(addr, n)?.to_vec())
    }

    /// The string at `addr` without its terminator.
    fn c_string(&self, addr: usize) -> Result<Vec<u8>, C5Error> {
        let n = self.c_strlen(addr)?;
        self.read_checked(addr, n)
    }

    fn write_checked(&mut self, addr: usize, src: &[u8]) -> Result<(), C5Error> {
        self.check_data_access(addr, src.len(), AccessKind::Write)?;
        self.write_bytes(addr, src)
    }
}

/// The first difference of `a` and `b` as `unsigned char` values, compared
/// up to the first terminator; `fold` compares lower case.
fn compare(a: &[u8], b: &[u8], fold: bool) -> i64 {
    let key = |c: u8| if fold { c.to_ascii_lowercase() } else { c };
    for i in 0.. {
        let (x, y) = (
            a.get(i).map_or(0, |&c| key(c)),
            b.get(i).map_or(0, |&c| key(c)),
        );
        if x != y || x == 0 {
            return i64::from(x) - i64::from(y);
        }
    }
    0
}

fn find(hay: &[u8], needle: &[u8], fold: bool) -> Option<usize> {
    if needle.is_empty() {
        return Some(0);
    }
    hay.windows(needle.len()).position(|w| {
        if fold {
            w.eq_ignore_ascii_case(needle)
        } else {
            w == needle
        }
    })
}

/// The `<ctype.h>` classes, as glibc's table numbers them on a
/// little-endian target.
const UPPER: u32 = 1 << 8;
const LOWER: u32 = 1 << 9;
const ALPHA: u32 = 1 << 10;
const DIGIT: u32 = 1 << 11;
const XDIGIT: u32 = 1 << 12;
const SPACE: u32 = 1 << 13;
const PRINT: u32 = 1 << 14;
const GRAPH: u32 = 1 << 15;
const CNTRL: u32 = 1 << 1;
const PUNCT: u32 = 1 << 2;
const ALNUM: u32 = 1 << 3;

/// The classes of `c` in the "C" locale: none outside the basic set.
fn classes(c: i64) -> u32 {
    let Ok(b) = u8::try_from(c) else {
        return 0;
    };
    let mut m = 0;
    if b.is_ascii_uppercase() {
        m |= UPPER | ALPHA | ALNUM;
    }
    if b.is_ascii_lowercase() {
        m |= LOWER | ALPHA | ALNUM;
    }
    if b.is_ascii_digit() {
        m |= DIGIT | ALNUM;
    }
    if b.is_ascii_hexdigit() {
        m |= XDIGIT;
    }
    if super::strtox::is_space(b) {
        m |= SPACE;
    }
    if (0x20..0x7f).contains(&b) {
        m |= PRINT;
    }
    if b.is_ascii_graphic() {
        m |= GRAPH;
    }
    if b.is_ascii_control() {
        m |= CNTRL;
    }
    if b.is_ascii_punctuation() {
        m |= PUNCT;
    }
    m
}

/// A classification function's result (C99 7.4.1): glibc returns its
/// table's bit, Apple's libc 1, msvcrt its `_ctype` table's bits under the
/// function's mask (`_UPPER` 1, `_LOWER` 2, `_DIGIT` 4, `_SPACE` 8, `_PUNCT`
/// 0x10, `_CONTROL` 0x20, `_BLANK` 0x40, `_HEX` 0x80, `_ALPHA` 0x103).
fn classify(libc: Libc, name: &str, c: i64) -> i64 {
    let m = classes(c);
    let want = match name {
        "isalnum" => ALNUM,
        "isalpha" => ALPHA,
        "iscntrl" => CNTRL,
        "isdigit" => DIGIT,
        "isgraph" => GRAPH,
        "islower" => LOWER,
        "isprint" => PRINT,
        "ispunct" => PUNCT,
        "isspace" => SPACE,
        "isupper" => UPPER,
        _ => XDIGIT,
    };
    if m & want == 0 {
        return 0;
    }
    match libc {
        Libc::Glibc => i64::from(want),
        Libc::Apple => 1,
        Libc::Ucrt => {
            let ms = [
                (UPPER, 0x101),
                (LOWER, 0x102),
                (DIGIT, 4),
                (SPACE, 8),
                (PUNCT, 0x10),
                (CNTRL, 0x20),
                (XDIGIT, 0x80),
            ];
            let table = ms
                .iter()
                .filter(|(g, _)| m & g != 0)
                .fold(0, |a, (_, v)| a | v)
                | if c == 0x20 { 0x40 } else { 0 };
            let mask = match name {
                "isalnum" => 0x107,
                "isalpha" => 0x103,
                "iscntrl" => 0x20,
                "isdigit" => 4,
                "isgraph" => 0x117,
                "islower" => 2,
                "isprint" => 0x157,
                "ispunct" => 0x10,
                "isspace" => 8,
                "isupper" => 1,
                _ => 0x80,
            };
            table & mask
        }
    }
}

/// `strtok_r`'s scan (C99 7.21.5.8): the token's address, or 0, and the
/// position the next call resumes at.
fn token(mem: &mut Memory, start: usize, delim: &[u8]) -> Result<(i64, usize), C5Error> {
    let s = mem.c_string(start)?;
    let Some(begin) = s.iter().position(|c| !delim.contains(c)) else {
        return Ok((0, start + s.len()));
    };
    match s[begin..].iter().position(|c| delim.contains(c)) {
        Some(len) => {
            mem.write_checked(start + begin + len, &[0])?;
            Ok(((start + begin) as i64, start + begin + len + 1))
        }
        None => Ok(((start + begin) as i64, start + s.len())),
    }
}

/// The string functions by name; `None` for any other name.
pub(super) fn call(name: &str, args: &[i64], mem: &mut Memory) -> Option<Result<i64, C5Error>> {
    if !NAMES.contains(&name) {
        return None;
    }
    Some(run(name, args, mem))
}

fn run(name: &str, args: &[i64], mem: &mut Memory) -> Result<i64, C5Error> {
    let libc = Libc::of(mem.target);
    let p = |i| ptr(name, args, i);
    let n = |i| arg(name, args, i).map(|v| v as u64 as usize);
    let at = |base: usize, off: Option<usize>| off.map_or(0, |o| (base + o) as i64);
    Ok(match name {
        "strlen" => mem.c_strlen(p(0)?)? as i64,
        "strnlen" => mem.c_strnlen(p(0)?, n(1)?)? as i64,
        "strcmp" | "strcoll" | "strcasecmp" | "_stricmp" => {
            let (a, b) = (mem.c_string(p(0)?)?, mem.c_string(p(1)?)?);
            let d = compare(&a, &b, matches!(name, "strcasecmp" | "_stricmp"));
            // msvcrt's strcmp and strcoll return -1, 0 or 1.
            if libc == Libc::Ucrt && matches!(name, "strcmp" | "strcoll") {
                d.signum()
            } else {
                d
            }
        }
        "strncmp" | "strncasecmp" | "_strnicmp" => {
            let len = n(2)?;
            let (a, b) = (p(0)?, p(1)?);
            let a = mem.read_checked(a, mem.c_strnlen(a, len)?)?;
            let b = mem.read_checked(b, mem.c_strnlen(b, len)?)?;
            compare(&a, &b, name != "strncmp")
        }
        "strcpy" | "stpcpy" => {
            let (d, s) = (p(0)?, mem.c_string(p(1)?)?);
            mem.write_checked(d, &s)?;
            mem.write_checked(d + s.len(), &[0])?;
            if name == "stpcpy" {
                (d + s.len()) as i64
            } else {
                d as i64
            }
        }
        "strncpy" | "stpncpy" => {
            let (d, s, len) = (p(0)?, p(1)?, n(2)?);
            let mut bytes = mem.read_checked(s, mem.c_strnlen(s, len)?)?;
            let copied = bytes.len();
            bytes.resize(len, 0);
            mem.write_checked(d, &bytes)?;
            if name == "stpncpy" {
                (d + copied) as i64
            } else {
                d as i64
            }
        }
        "strcat" | "strncat" => {
            let (d, s) = (p(0)?, p(1)?);
            let mut tail = if name == "strncat" {
                let len = n(2)?;
                mem.read_checked(s, mem.c_strnlen(s, len)?)?
            } else {
                mem.c_string(s)?
            };
            tail.push(0);
            let end = d + mem.c_strlen(d)?;
            mem.write_checked(end, &tail)?;
            d as i64
        }
        "strchr" | "index" | "strchrnul" => {
            let s = p(0)?;
            let c = arg(name, args, 1)? as u8;
            let len = mem.c_strlen(s)?;
            let found = mem.bytes[s..=s + len].iter().position(|&b| b == c);
            if name == "strchrnul" {
                at(s, found.or(Some(len)))
            } else {
                at(s, found)
            }
        }
        "strrchr" | "rindex" => {
            let s = p(0)?;
            let c = arg(name, args, 1)? as u8;
            let len = mem.c_strlen(s)?;
            at(s, mem.bytes[s..=s + len].iter().rposition(|&b| b == c))
        }
        "memchr" | "memrchr" => {
            let (len, c) = (n(2)?, arg(name, args, 1)? as u8);
            if len == 0 {
                return Ok(0);
            }
            let s = p(0)?;
            let bytes = mem.read_checked(s, len)?;
            let found = if name == "memchr" {
                bytes.iter().position(|&b| b == c)
            } else {
                bytes.iter().rposition(|&b| b == c)
            };
            at(s, found)
        }
        "strstr" | "strcasestr" => {
            let h = p(0)?;
            let (hay, needle) = (mem.c_string(h)?, mem.c_string(p(1)?)?);
            at(h, find(&hay, &needle, name == "strcasestr"))
        }
        "memmem" => {
            let (hlen, nlen) = (n(1)?, n(3)?);
            // glibc returns the haystack for an empty needle, libSystem null.
            if nlen == 0 {
                return Ok(if libc == Libc::Apple {
                    0
                } else {
                    arg(name, args, 0)?
                });
            }
            let h = p(0)?;
            let hay = mem.read_checked(h, hlen)?;
            let needle = mem.read_checked(p(2)?, nlen)?;
            at(h, find(&hay, &needle, false))
        }
        "strspn" | "strcspn" => {
            let (s, set) = (mem.c_string(p(0)?)?, mem.c_string(p(1)?)?);
            let accept = name == "strspn";
            s.iter().take_while(|c| set.contains(c) == accept).count() as i64
        }
        "strpbrk" => {
            let s = p(0)?;
            let (bytes, set) = (mem.c_string(s)?, mem.c_string(p(1)?)?);
            at(s, bytes.iter().position(|c| set.contains(c)))
        }
        "strdup" | "_strdup" | "strndup" => {
            let s = p(0)?;
            let len = if name == "strndup" {
                mem.c_strnlen(s, n(1)?)?
            } else {
                mem.c_strlen(s)?
            };
            let mut bytes = mem.read_checked(s, len)?;
            bytes.push(0);
            let d = guest_alloc(mem, Some(bytes.len() as u64));
            if d != 0 {
                mem.write_bytes(d as usize, &bytes)?;
            }
            d
        }
        "strtok" | "strtok_r" => {
            let s = arg(name, args, 0)?;
            let delim = mem.c_string(p(1)?)?;
            let save = if name == "strtok_r" {
                Some(p(2)?)
            } else {
                None
            };
            let start = match (s, save) {
                (0, Some(slot)) => {
                    mem.check_data_access(slot, 8, AccessKind::Read)?;
                    super::load_from_memory(mem, slot, super::LoadKind::I64)? as usize
                }
                (0, None) => mem.strtok_next,
                (s, _) => s as usize,
            };
            if start == 0 {
                return Ok(0);
            }
            let (tok, next) = token(mem, start, &delim)?;
            match save {
                Some(slot) => mem.write_checked(slot, &(next as u64).to_le_bytes())?,
                None => mem.strtok_next = next,
            }
            tok
        }
        "strxfrm" => {
            let s = mem.c_string(p(1)?)?;
            let len = n(2)?;
            if s.len() < len {
                let mut bytes = s.clone();
                bytes.push(0);
                mem.write_checked(p(0)?, &bytes)?;
            }
            s.len() as i64
        }
        "bzero" | "explicit_bzero" => {
            let len = n(1)?;
            if len > 0 {
                mem.write_checked(p(0)?, &alloc::vec![0; len])?;
            }
            0
        }
        "bcopy" => {
            let len = n(2)?;
            if len > 0 {
                let bytes = mem.read_checked(p(0)?, len)?;
                mem.write_checked(p(1)?, &bytes)?;
            }
            0
        }
        "bcmp" => {
            let len = n(2)?;
            if len == 0 {
                return Ok(0);
            }
            let (a, b) = (mem.read_checked(p(0)?, len)?, mem.read_checked(p(1)?, len)?);
            i64::from(a != b)
        }
        "tolower" | "toupper" => {
            let c = arg(name, args, 0)? as i32;
            let mapped = u8::try_from(c).map(|b| {
                if name == "tolower" {
                    b.to_ascii_lowercase()
                } else {
                    b.to_ascii_uppercase()
                }
            });
            i64::from(mapped.map_or(c, i32::from))
        }
        _ => classify(libc, name, i64::from(arg(name, args, 0)? as i32)),
    })
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::codegen::Target;

    #[test]
    fn classification_returns_each_library_s_value() {
        let at = |t, name, c| classify(Libc::of(t), name, c);
        assert_eq!(at(Target::LinuxX64, "isalpha", 'a' as i64), 1024);
        assert_eq!(at(Target::LinuxAarch64, "isspace", '\t' as i64), 8192);
        assert_eq!(at(Target::MacOSAarch64, "isxdigit", 'F' as i64), 1);
        assert_eq!(at(Target::WindowsX64, "isalpha", 'a' as i64), 0x102);
        assert_eq!(at(Target::WindowsX64, "isprint", ' ' as i64), 0x40);
        assert_eq!(at(Target::WindowsAarch64, "isdigit", '7' as i64), 4);
        for t in [Target::LinuxX64, Target::MacOSAarch64, Target::WindowsX64] {
            assert_eq!(at(t, "isalpha", 0xe9), 0);
            assert_eq!(at(t, "isprint", -1), 0);
            assert_ne!(at(t, "ispunct", '!' as i64), 0);
        }
    }
}

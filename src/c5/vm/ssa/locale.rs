//! `setlocale` and `localeconv` (C99 7.11): the interpreter's only locale
//! is "C", which also stands for the native environment's.

use alloc::vec::Vec;

use crate::c5::error::C5Error;

use super::Memory;

pub(super) const NAMES: &[&str] = &["setlocale", "localeconv"];

/// `struct lconv`'s string pointers and `char` members (C99 7.11.2.1).
const POINTERS: usize = 10 * 8;
const CHARS: usize = 14;

/// Offsets of `"C"`, `"."`, `""`, `L"."`, `L""` and the structure.
const NAME: usize = 0;
const POINT: usize = 2;
const EMPTY: usize = 4;
const WIDE_POINT: usize = 8;
const WIDE_EMPTY: usize = 12;
const LCONV: usize = 16;

/// The "C" locale's `struct lconv`: `decimal_point` ".", the other strings
/// empty, the `char`s `CHAR_MAX`, msvcrt's wide strings after its eighth.
fn block(mem: &mut Memory) -> Result<usize, C5Error> {
    if mem.locale != 0 {
        return Ok(mem.locale);
    }
    let windows = mem.target.is_windows();
    let size = if windows { 160 } else { POINTERS + CHARS };
    let base = super::guest_alloc(mem, Some((LCONV + size) as u64)) as usize;
    if base == 0 {
        return Err(C5Error::Runtime("vm_ssa: localeconv: out of memory".into()));
    }
    let mut b = alloc::vec![0u8; LCONV + size];
    b[NAME] = b'C';
    b[POINT] = b'.';
    b[WIDE_POINT] = b'.';
    let ptr = |off: usize| ((base + off) as u64).to_le_bytes();
    let mut at = LCONV;
    for i in 0..10 {
        b[at..at + 8].copy_from_slice(&ptr(if i == 0 { POINT } else { EMPTY }));
        at += 8;
    }
    let chars: Vec<usize> = if windows {
        b[at..at + 8].fill(127);
        at += 8;
        for i in 0..8 {
            b[at..at + 8].copy_from_slice(&ptr(if i == 0 { WIDE_POINT } else { WIDE_EMPTY }));
            at += 8;
        }
        (at..at + 6).collect()
    } else {
        (at..at + CHARS).collect()
    };
    for c in chars {
        b[c] = 127;
    }
    mem.write_bytes(base, &b)?;
    mem.locale = base;
    Ok(base)
}

pub(super) fn call(name: &str, args: &[i64], mem: &mut Memory) -> Option<Result<i64, C5Error>> {
    if !NAMES.contains(&name) {
        return None;
    }
    Some((|| {
        let base = block(mem)?;
        if name == "localeconv" {
            return Ok((base + LCONV) as i64);
        }
        let locale = args.get(1).copied().unwrap_or(0);
        if locale == 0 {
            return Ok((base + NAME) as i64);
        }
        let requested = mem.c_string(locale as usize)?;
        Ok(match requested.as_slice() {
            b"" | b"C" | b"POSIX" => (base + NAME) as i64,
            _ => 0,
        })
    })())
}

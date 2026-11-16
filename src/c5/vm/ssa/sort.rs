//! `qsort` and `bsearch` (C99 7.20.5) and msvcrt's `qsort_s` and
//! `bsearch_s`, calling the program's comparison function back.

use alloc::format;
use alloc::vec::Vec;

use crate::c5::error::C5Error;

use super::{Libc, Memory};

pub(super) const NAMES: &[&str] = &["qsort", "bsearch", "qsort_s", "bsearch_s"];

/// A call of the program's function `f` with `operands`.
pub(super) type Callback<'a> = dyn FnMut(&mut Memory, i64, &[i64]) -> Result<i64, C5Error> + 'a;

/// The comparison function and the context `_s` forms pass it first.
struct Compare<'c, 'a> {
    call: &'c mut Callback<'a>,
    f: i64,
    context: Option<i64>,
}

impl Compare<'_, '_> {
    fn order(&mut self, mem: &mut Memory, a: usize, b: usize) -> Result<i32, C5Error> {
        let (a, b) = (a as i64, b as i64);
        let r = match self.context {
            Some(ctx) => (self.call)(mem, self.f, &[ctx, a, b])?,
            None => (self.call)(mem, self.f, &[a, b])?,
        };
        Ok(r as i32)
    }
}

fn swap(mem: &mut Memory, a: usize, b: usize, n: usize) -> Result<(), C5Error> {
    if a == b || n == 0 {
        return Ok(());
    }
    let (x, y) = (mem.read_checked(a, n)?, mem.read_checked(b, n)?);
    mem.write_checked(a, &y)?;
    mem.write_checked(b, &x)
}

fn med3(
    mem: &mut Memory,
    cmp: &mut Compare<'_, '_>,
    a: usize,
    b: usize,
    c: usize,
) -> Result<usize, C5Error> {
    Ok(if cmp.order(mem, a, b)? < 0 {
        if cmp.order(mem, b, c)? < 0 {
            b
        } else if cmp.order(mem, a, c)? < 0 {
            c
        } else {
            a
        }
    } else if cmp.order(mem, b, c)? > 0 {
        b
    } else if cmp.order(mem, a, c)? < 0 {
        a
    } else {
        c
    })
}

fn insertion_sort(
    mem: &mut Memory,
    cmp: &mut Compare<'_, '_>,
    a: usize,
    n: usize,
    es: usize,
) -> Result<(), C5Error> {
    for m in 1..n {
        let mut l = a + m * es;
        while l > a && cmp.order(mem, l - es, l)? > 0 {
            swap(mem, l, l - es, es)?;
            l -= es;
        }
    }
    Ok(())
}

/// The Bentley-McIlroy quicksort of the FreeBSD libc Apple's carries:
/// insertion sort through 7 elements and after a partition that moved
/// nothing, the pivot a median of three, of nine past 40 elements, the
/// elements equal to it gathered at both ends and swapped to the middle.
/// Measured natively, it makes Apple's comparisons and order up to 60
/// elements and over larger arrays of few distinct keys.
// TODO: past 40 mostly distinct elements Apple's libc can compare in
// another sequence and leave equal elements in another order.
fn bsd_quicksort(
    mem: &mut Memory,
    cmp: &mut Compare<'_, '_>,
    mut a: usize,
    mut n: usize,
    es: usize,
) -> Result<(), C5Error> {
    loop {
        if n < 8 {
            return insertion_sort(mem, cmp, a, n, es);
        }
        let mut pm = a + (n / 2) * es;
        {
            let (mut pl, mut pn) = (a, a + (n - 1) * es);
            if n > 40 {
                let d = (n / 8) * es;
                pl = med3(mem, cmp, pl, pl + d, pl + 2 * d)?;
                pm = med3(mem, cmp, pm - d, pm, pm + d)?;
                pn = med3(mem, cmp, pn - 2 * d, pn - d, pn)?;
            }
            pm = med3(mem, cmp, pl, pm, pn)?;
        }
        swap(mem, a, pm, es)?;
        let (mut pa, mut pb) = (a + es, a + es);
        let (mut pc, mut pd) = (a + (n - 1) * es, a + (n - 1) * es);
        let mut swapped = false;
        loop {
            while pb <= pc {
                let r = cmp.order(mem, pb, a)?;
                if r > 0 {
                    break;
                }
                if r == 0 {
                    swapped = true;
                    swap(mem, pa, pb, es)?;
                    pa += es;
                }
                pb += es;
            }
            while pb <= pc {
                let r = cmp.order(mem, pc, a)?;
                if r < 0 {
                    break;
                }
                if r == 0 {
                    swapped = true;
                    swap(mem, pc, pd, es)?;
                    pd -= es;
                }
                pc -= es;
            }
            if pb > pc {
                break;
            }
            swap(mem, pb, pc, es)?;
            swapped = true;
            pb += es;
            pc -= es;
        }
        if !swapped {
            insertion_sort(mem, cmp, a, n, es)?;
            return Ok(());
        }
        let pn = a + n * es;
        let d = (pa - a).min(pb - pa);
        swap(mem, a, pb - d, d)?;
        let d = (pd - pc).min(pn - pd - es);
        swap(mem, pb, pn - d, d)?;
        let (left, right) = (pb - pa, pd - pc);
        if left > es {
            bsd_quicksort(mem, cmp, a, left / es, es)?;
        }
        if right <= es {
            return Ok(());
        }
        a = pn - right;
        n = right / es;
    }
}

/// glibc's top-down merge sort of the `n` elements of `size` bytes at
/// `base`: each half sorted, then merged taking the left element unless
/// the right one orders before it, so equal elements keep their order.
fn merge_sort(
    mem: &mut Memory,
    cmp: &mut Compare<'_, '_>,
    base: usize,
    n: usize,
    size: usize,
) -> Result<(), C5Error> {
    if n <= 1 {
        return Ok(());
    }
    let (n1, n2) = (n / 2, n - n / 2);
    merge_sort(mem, cmp, base, n1, size)?;
    merge_sort(mem, cmp, base + n1 * size, n2, size)?;
    let (mut b1, mut b2) = (base, base + n1 * size);
    let (mut left, mut right) = (n1, n2);
    let mut merged: Vec<u8> = Vec::with_capacity(n * size);
    while left > 0 && right > 0 {
        let from = if cmp.order(mem, b1, b2)? <= 0 {
            left -= 1;
            b1 += size;
            b1 - size
        } else {
            right -= 1;
            b2 += size;
            b2 - size
        };
        merged.extend_from_slice(&mem.read_checked(from, size)?);
    }
    merged.extend_from_slice(&mem.read_checked(b1, left * size)?);
    mem.write_checked(base, &merged)
}

/// The element `bsearch` finds, searching as the target's C library does,
/// which decides which of several equal elements it returns.
fn search(
    mem: &mut Memory,
    cmp: &mut Compare<'_, '_>,
    key: usize,
    base: usize,
    n: usize,
    size: usize,
) -> Result<usize, C5Error> {
    let at = |i: usize| base + i * size;
    match Libc::of(mem.target) {
        Libc::Glibc => {
            let (mut lo, mut hi) = (0, n);
            while lo < hi {
                let mid = (lo + hi) / 2;
                match cmp.order(mem, key, at(mid))? {
                    r if r < 0 => hi = mid,
                    r if r > 0 => lo = mid + 1,
                    _ => return Ok(at(mid)),
                }
            }
        }
        Libc::Apple => {
            let (mut lo, mut lim) = (0, n);
            while lim != 0 {
                let p = lo + lim / 2;
                match cmp.order(mem, key, at(p))? {
                    0 => return Ok(at(p)),
                    r if r > 0 => {
                        lo = p + 1;
                        lim -= 1;
                    }
                    _ => {}
                }
                lim /= 2;
            }
        }
        // msvcrt halves around the middle element of the odd count, or the
        // one before the middle of an even count.
        Libc::Ucrt => {
            let (mut lo, mut num) = (0, n);
            while num > 0 {
                let half = num / 2;
                if half == 0 {
                    return Ok(if cmp.order(mem, key, at(lo))? == 0 {
                        at(lo)
                    } else {
                        0
                    });
                }
                let step = if num & 1 == 1 { half } else { half - 1 };
                let mid = lo + step;
                match cmp.order(mem, key, at(mid))? {
                    0 => return Ok(at(mid)),
                    r if r < 0 => num = step,
                    _ => {
                        lo = mid + 1;
                        num = half;
                    }
                }
            }
        }
    }
    Ok(0)
}

fn arg(name: &str, args: &[i64], i: usize) -> Result<i64, C5Error> {
    (args.get(i).copied())
        .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {name}: missing argument {}", i + 1)))
}

/// The sorting and searching functions by name; `None` for any other name.
pub(super) fn call(
    name: &str,
    args: &[i64],
    mem: &mut Memory,
    call: &mut Callback<'_>,
) -> Option<Result<i64, C5Error>> {
    if !NAMES.contains(&name) {
        return None;
    }
    Some((|| {
        let a = |i| arg(name, args, i);
        let sort = name.starts_with("qsort");
        let first = usize::from(!sort);
        let (base, n, size) = (
            a(first)? as usize,
            a(first + 1)? as usize,
            a(first + 2)? as usize,
        );
        let mut cmp = Compare {
            call,
            f: a(first + 3)?,
            context: if name.ends_with("_s") {
                Some(a(first + 4)?)
            } else {
                None
            },
        };
        if size == 0 {
            return Ok(0);
        }
        if sort {
            match Libc::of(mem.target) {
                Libc::Apple => bsd_quicksort(mem, &mut cmp, base, n, size)?,
                // TODO: msvcrt's quicksort, whose comparisons and order of
                // equal elements differ from glibc's merge sort.
                _ => merge_sort(mem, &mut cmp, base, n, size)?,
            }
            return Ok(0);
        }
        Ok(search(mem, &mut cmp, a(0)? as usize, base, n, size)? as i64)
    })())
}

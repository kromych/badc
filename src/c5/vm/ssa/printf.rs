//! The formatted output functions of C99 7.19.6 over the interpreter's
//! printf engine: to a stream, a descriptor, a buffer or an allocated one,
//! from the call's arguments or from a `va_list`.

use alloc::format;

use crate::c5::error::C5Error;
use crate::c5::host::Host;

use super::{AccessKind, Memory, Varargs, cstring_arg, format_printf, guest_alloc};

pub(super) const NAMES: &[&str] = &[
    "printf",
    "vprintf",
    "fprintf",
    "vfprintf",
    "dprintf",
    "vdprintf",
    "sprintf",
    "vsprintf",
    "snprintf",
    "vsnprintf",
    "asprintf",
    "vasprintf",
    "_snprintf",
    "_vsnprintf",
    "_vscprintf",
];

/// The formatted output functions by name; `None` for any other name.
pub(super) fn call<H: Host>(
    name: &str,
    args: &[i64],
    mem: &mut Memory,
    host: &mut H,
) -> Option<Result<i64, C5Error>> {
    if !NAMES.contains(&name) {
        return None;
    }
    Some(run(name, args, mem, host))
}

fn arg(name: &str, args: &[i64], i: usize) -> Result<i64, C5Error> {
    (args.get(i).copied())
        .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {name}: missing argument {}", i + 1)))
}

fn run<H: Host>(name: &str, args: &[i64], mem: &mut Memory, host: &mut H) -> Result<i64, C5Error> {
    // The format's position, and the `va_list`'s for a `v` form.
    let (at, list) = match name {
        "printf" => (0, None),
        "vprintf" | "_vscprintf" => (0, Some(1)),
        "fprintf" | "dprintf" | "sprintf" | "asprintf" => (1, None),
        "vfprintf" | "vdprintf" | "vsprintf" | "vasprintf" => (1, Some(2)),
        "snprintf" | "_snprintf" => (2, None),
        _ => (2, Some(3)),
    };
    let fmt = cstring_arg(name, args, at, mem)?;
    let varargs = match list {
        Some(i) => Varargs::list(mem, arg(name, args, i)?)?,
        None => Varargs::values(args.get(at + 1..).unwrap_or_default()),
    };
    let out = format_printf(&fmt, varargs, mem)?;
    let len = out.len() as i64;
    match name {
        "printf" | "vprintf" => {
            host.write(1, &out);
        }
        "fprintf" | "vfprintf" => {
            let fd = super::stream_fd(name, args, 0, mem)?;
            host.write(fd, &out);
        }
        "dprintf" | "vdprintf" => {
            host.write(arg(name, args, 0)?, &out);
        }
        "sprintf" | "vsprintf" => {
            let mut text = out;
            text.push(0);
            mem.write_checked(arg(name, args, 0)? as usize, &text)?;
        }
        // C99 7.19.6.5: at most n - 1 characters and a null character.
        "snprintf" | "vsnprintf" => {
            let n = arg(name, args, 1)? as u64 as usize;
            if n > 0 {
                let mut text = out[..out.len().min(n - 1)].to_vec();
                text.push(0);
                mem.write_checked(arg(name, args, 0)? as usize, &text)?;
            }
        }
        // msvcrt writes at most `n` characters, a null character only when
        // there is room for it, and returns -1 for a truncated output.
        "_snprintf" | "_vsnprintf" => {
            let n = arg(name, args, 1)? as i32 as usize;
            let mut text = out[..out.len().min(n)].to_vec();
            if out.len() < n {
                text.push(0);
            }
            mem.write_checked(arg(name, args, 0)? as usize, &text)?;
            if out.len() > n {
                return Ok(-1);
            }
        }
        "asprintf" | "vasprintf" => {
            let strp = arg(name, args, 0)? as usize;
            let buf = guest_alloc(mem, Some(out.len() as u64 + 1));
            if buf == 0 {
                return Ok(-1);
            }
            let mut text = out;
            text.push(0);
            mem.write_bytes(buf as usize, &text)?;
            mem.check_data_access(strp, 8, AccessKind::Write)?;
            mem.write_bytes(strp, &buf.to_le_bytes())?;
        }
        _ => {}
    }
    Ok(len)
}

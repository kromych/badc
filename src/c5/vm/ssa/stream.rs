//! Streams (C99 7.19.2, 7.19.3): each a `FILE` object in the program's
//! memory, keyed by its address, whose descriptor, buffered input and
//! indicators the interpreter keeps.

use alloc::collections::VecDeque;
use alloc::format;
use alloc::vec::Vec;

use crate::c5::error::C5Error;
use crate::c5::host::Host;

use super::scan::{self, Input};
use super::{AccessKind, Libc, LoadKind, Memory, Varargs, load_from_memory};

pub(super) const NAMES: &[&str] = &[
    "fopen",
    "tmpfile",
    "fclose",
    "fgetc",
    "getc",
    "getc_unlocked",
    "getchar",
    "getchar_unlocked",
    "ungetc",
    "fgets",
    "fread",
    "getline",
    "getdelim",
    "feof",
    "ferror",
    "clearerr",
    "fseek",
    "fseeko",
    "_fseeki64",
    "ftell",
    "ftello",
    "_ftelli64",
    "rewind",
    "setvbuf",
    "setbuf",
];

/// `errno` for a stream that cannot seek, as every target numbers it.
const ESPIPE: i32 = 29;

pub(super) struct Stream {
    pub(super) fd: i64,
    /// Characters read from the descriptor or pushed back, next first.
    pending: VecDeque<u8>,
    pub(super) eof: bool,
    pub(super) error: bool,
}

impl Stream {
    pub(super) fn new(fd: i64) -> Self {
        Self {
            fd,
            pending: VecDeque::new(),
            eof: false,
            error: false,
        }
    }

    /// The next character; none at end-of-file, which sets the indicator
    /// that later reads return at (7.19.7.1p2), or on a read error.
    pub(super) fn getc<H: Host>(&mut self, host: &mut H) -> Option<u8> {
        if let Some(c) = self.pending.pop_front() {
            return Some(c);
        }
        if self.eof {
            return None;
        }
        let mut buf = [0u8; 4096];
        match host.read(self.fd, &mut buf) {
            n if n < 0 => {
                self.error = true;
                None
            }
            0 => {
                self.eof = true;
                None
            }
            n => {
                self.pending.extend(&buf[..n as usize]);
                self.pending.pop_front()
            }
        }
    }

    /// Push `c` back (7.19.7.11), clearing the end-of-file indicator.
    pub(super) fn ungetc(&mut self, c: u8) {
        self.pending.push_front(c);
        self.eof = false;
    }
}

struct StreamInput<'a, H> {
    stream: &'a mut Stream,
    host: &'a mut H,
}

impl<H: Host> Input for StreamInput<'_, H> {
    fn get(&mut self) -> Option<u8> {
        self.stream.getc(self.host)
    }

    fn unget(&mut self, c: u8) {
        self.stream.pending.push_front(c);
    }
}

/// The stream `file` names, taken out of the table while a call uses it.
fn take(mem: &mut Memory, file: i64) -> Result<Stream, C5Error> {
    mem.streams
        .remove(&(file as usize))
        .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: 0x{file:x} is not an open stream")))
}

/// `fscanf` on the stream `file`.
pub(super) fn scan_stream<H: Host>(
    mem: &mut Memory,
    host: &mut H,
    file: i64,
    fmt: &[u8],
    args: Varargs<'_>,
) -> Result<i64, C5Error> {
    let mut stream = take(mem, file)?;
    let mut input = StreamInput {
        stream: &mut stream,
        host,
    };
    let n = scan::scan(fmt, &mut input, args, mem);
    mem.streams.insert(file as usize, stream);
    n
}

fn arg(name: &str, args: &[i64], i: usize) -> Result<i64, C5Error> {
    (args.get(i).copied())
        .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {name}: missing argument {}", i + 1)))
}

fn stream<'m>(mem: &'m mut Memory, name: &str, file: i64) -> Result<&'m mut Stream, C5Error> {
    mem.streams.get_mut(&(file as usize)).ok_or_else(|| {
        C5Error::Runtime(format!("vm_ssa: {name}: 0x{file:x} is not an open stream"))
    })
}

/// Characters through the first `delim`, at most `max`; `None` when the
/// stream ends or fails before the first.
fn line<H: Host>(s: &mut Stream, host: &mut H, delim: Option<u8>, max: usize) -> Option<Vec<u8>> {
    let mut out = Vec::new();
    while out.len() < max {
        match s.getc(host) {
            Some(c) => {
                out.push(c);
                if Some(c) == delim {
                    break;
                }
            }
            None if out.is_empty() => return None,
            None => break,
        }
    }
    Some(out)
}

/// The stream functions by name; `None` for any other name.
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

/// A `FILE` object in the program's memory for the open descriptor `fd`.
fn open_stream(mem: &mut Memory, fd: i64) -> i64 {
    let file = super::guest_alloc(mem, Some(super::STDIO_FILE_BYTES as u64));
    if file != 0 {
        mem.streams.insert(file as usize, Stream::new(fd));
    }
    file
}

fn run<H: Host>(name: &str, args: &[i64], mem: &mut Memory, host: &mut H) -> Result<i64, C5Error> {
    let long32 = mem.target.long_width_bytes() == 4 && name != "_fseeki64";
    let long_offset = |v: i64| if long32 { v as i32 as i64 } else { v };
    match name {
        "fopen" => {
            let path = mem.c_string(arg(name, args, 0)? as usize)?;
            let mode = mem.c_string(arg(name, args, 1)? as usize)?;
            let fd = host.open_mode(
                &alloc::string::String::from_utf8_lossy(&path),
                &alloc::string::String::from_utf8_lossy(&mode),
            );
            if fd < 0 {
                mem.set_errno(-fd as i32);
                return Ok(0);
            }
            Ok(open_stream(mem, fd))
        }
        "tmpfile" => {
            let fd = host.tmpfile();
            if fd < 0 {
                mem.set_errno(-fd as i32);
                return Ok(0);
            }
            Ok(open_stream(mem, fd))
        }
        "fclose" => {
            let file = arg(name, args, 0)?;
            let s = take(mem, file)?;
            if s.fd > 2 {
                host.close(s.fd);
            }
            Ok(0)
        }
        "fgetc" | "getc" | "getc_unlocked" | "getchar" | "getchar_unlocked" => {
            let file = if name.starts_with("getchar") {
                mem.std_stream(0)
            } else {
                arg(name, args, 0)?
            };
            Ok(stream(mem, name, file)?.getc(host).map_or(-1, i64::from))
        }
        // C99 7.19.7.11: EOF is not pushed back.
        "ungetc" => {
            let c = arg(name, args, 0)? as i32;
            let s = stream(mem, name, arg(name, args, 1)?)?;
            if c == -1 {
                return Ok(-1);
            }
            s.ungetc(c as u8);
            Ok(i64::from(c as u8))
        }
        // C99 7.19.7.2: at most n - 1 characters through a new-line; null
        // when the stream ends before the first, the array unchanged.
        "fgets" => {
            let (buf, n) = (arg(name, args, 0)?, arg(name, args, 1)? as i32);
            if n <= 0 {
                return Ok(0);
            }
            let s = stream(mem, name, arg(name, args, 2)?)?;
            let Some(mut text) = line(s, host, Some(b'\n'), n as usize - 1) else {
                return Ok(0);
            };
            text.push(0);
            mem.write_checked(buf as usize, &text)?;
            Ok(buf)
        }
        "fread" => {
            let (buf, size, count) = (
                arg(name, args, 0)?,
                arg(name, args, 1)?,
                arg(name, args, 2)?,
            );
            let total = (size as u64).saturating_mul(count as u64) as usize;
            if total == 0 {
                return Ok(0);
            }
            let s = stream(mem, name, arg(name, args, 3)?)?;
            let text = line(s, host, None, total).unwrap_or_default();
            mem.write_checked(buf as usize, &text)?;
            Ok((text.len() / size as usize) as i64)
        }
        // POSIX.1-2008: the line through `delim` into `*lineptr`, grown as
        // glibc grows it, from 120 bytes, doubling.
        "getline" | "getdelim" => {
            let (lineptr, np) = (arg(name, args, 0)? as usize, arg(name, args, 1)? as usize);
            let (delim, file) = if name == "getline" {
                (b'\n', arg(name, args, 2)?)
            } else {
                (arg(name, args, 2)? as u8, arg(name, args, 3)?)
            };
            let s = stream(mem, name, file)?;
            let Some(mut text) = line(s, host, Some(delim), usize::MAX) else {
                return Ok(-1);
            };
            let len = text.len() as i64;
            text.push(0);
            mem.check_data_access(lineptr, 8, AccessKind::Read)?;
            mem.check_data_access(np, 8, AccessKind::Read)?;
            let mut buf = load_from_memory(mem, lineptr, LoadKind::I64)?;
            let mut cap = load_from_memory(mem, np, LoadKind::I64)? as u64;
            if buf == 0 || cap < text.len() as u64 {
                cap = cap.max(120);
                while cap < text.len() as u64 {
                    cap *= 2;
                }
                buf = super::dispatch_callext("realloc", &[buf, cap as i64], mem, host)?;
                if buf == 0 {
                    return Ok(-1);
                }
                mem.write_checked(lineptr, &buf.to_le_bytes())?;
                mem.write_checked(np, &cap.to_le_bytes())?;
            }
            mem.write_checked(buf as usize, &text)?;
            Ok(len)
        }
        // A true indicator is glibc's and Apple's 1, msvcrt's flag bit:
        // `_IOEOF` 0x10, `_IOERR` 0x20.
        "feof" | "ferror" => {
            let windows = Libc::of(mem.target) == Libc::Ucrt;
            let s = stream(mem, name, arg(name, args, 0)?)?;
            let (set, bit) = if name == "feof" {
                (s.eof, 0x10)
            } else {
                (s.error, 0x20)
            };
            Ok(if !set {
                0
            } else if windows {
                bit
            } else {
                1
            })
        }
        "clearerr" => {
            let s = stream(mem, name, arg(name, args, 0)?)?;
            s.eof = false;
            s.error = false;
            Ok(0)
        }
        // C99 7.19.9.2: pushed-back characters are discarded, and the
        // position is the file's less what was read ahead.
        "fseek" | "fseeko" | "_fseeki64" | "rewind" => {
            let file = arg(name, args, 0)?;
            let (offset, whence) = if name == "rewind" {
                (0, 0)
            } else {
                (long_offset(arg(name, args, 1)?), arg(name, args, 2)? as i32)
            };
            let s = stream(mem, name, file)?;
            let ahead = if whence == 1 {
                s.pending.len() as i64
            } else {
                0
            };
            s.pending.clear();
            s.eof = false;
            if name == "rewind" {
                s.error = false;
            }
            let fd = s.fd;
            if host.seek(fd, offset - ahead, whence) < 0 {
                mem.set_errno(ESPIPE);
                return Ok(-1);
            }
            Ok(0)
        }
        "ftell" | "ftello" | "_ftelli64" => {
            let s = stream(mem, name, arg(name, args, 0)?)?;
            let ahead = s.pending.len() as i64;
            let fd = s.fd;
            match host.seek(fd, 0, 1) {
                p if p < 0 => {
                    mem.set_errno(ESPIPE);
                    Ok(-1)
                }
                p => Ok(p - ahead),
            }
        }
        // The interpreter's streams write through unbuffered.
        _ => Ok(0),
    }
}

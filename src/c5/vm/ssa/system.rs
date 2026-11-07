//! `time`, `clock` and `difftime` (C99 7.23.2) over the host's clocks,
//! `rand` and `srand` (7.20.2) as each target's C library generates, and
//! `strerror` and `perror` (7.21.6.2, 7.19.10.4) with its messages.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use crate::c5::error::C5Error;
use crate::c5::host::Host;

use super::{Libc, Memory};

pub(super) const NAMES: &[&str] = &[
    "time", "clock", "difftime", "rand", "srand", "strerror", "perror",
];

/// The generator `rand` draws from, in the target's C library's form.
pub(super) enum Rand {
    /// glibc's additive feedback generator `random()`, of degree 31.
    Glibc { r: [u32; 31], f: usize, b: usize },
    /// Apple's libc: Park and Miller's minimal standard generator.
    Apple(u64),
    /// msvcrt's linear congruential generator.
    Msvcrt(u32),
}

impl Rand {
    /// The generator as seeded with 1, the seed before any `srand`.
    pub(super) fn new(libc: Libc) -> Self {
        let mut g = match libc {
            Libc::Glibc => Rand::Glibc {
                r: [0; 31],
                f: 3,
                b: 0,
            },
            Libc::Apple => Rand::Apple(1),
            Libc::Ucrt => Rand::Msvcrt(1),
        };
        g.seed(1);
        g
    }

    fn seed(&mut self, seed: u32) {
        match self {
            // glibc's srandom_r: the state from the minimal standard
            // generator, then 310 values discarded.
            Rand::Glibc { r, f, b } => {
                let mut word = i64::from(seed.max(1));
                r[0] = word as u32;
                for slot in r.iter_mut().skip(1) {
                    word = 16807 * (word % 127773) - 2836 * (word / 127773);
                    if word < 0 {
                        word += 2147483647;
                    }
                    *slot = word as u32;
                }
                (*f, *b) = (3, 0);
                for _ in 0..310 {
                    self.next();
                }
            }
            Rand::Apple(next) => *next = u64::from(seed),
            Rand::Msvcrt(hold) => *hold = seed,
        }
    }

    fn next(&mut self) -> i64 {
        match self {
            Rand::Glibc { r, f, b } => {
                r[*f] = r[*f].wrapping_add(r[*b]);
                let v = r[*f] >> 1;
                *f = (*f + 1) % 31;
                *b = (*b + 1) % 31;
                i64::from(v)
            }
            Rand::Apple(next) => {
                let x = if *next == 0 { 123459876 } else { *next as i64 };
                let mut x = 16807 * (x % 127773) - 2836 * (x / 127773);
                if x < 0 {
                    x += 0x7fff_ffff;
                }
                *next = x as u64;
                x % 0x8000_0000
            }
            Rand::Msvcrt(hold) => {
                *hold = hold.wrapping_mul(214013).wrapping_add(2531011);
                i64::from(*hold >> 16 & 0x7fff)
            }
        }
    }
}

/// The message `strerror` gives for `errnum`, in the target's C library's
/// words; the C libraries number most errors alike up to `ERANGE`.
fn message(libc: Libc, errnum: i32) -> String {
    let shared = [
        "Operation not permitted",
        "No such file or directory",
        "No such process",
        "Interrupted system call",
        "Input/output error",
        "No such device or address",
        "Argument list too long",
        "Exec format error",
        "Bad file descriptor",
        "No child processes",
        "Resource temporarily unavailable",
        "Cannot allocate memory",
        "Permission denied",
        "Bad address",
        "Block device required",
        "Device or resource busy",
        "File exists",
        "Invalid cross-device link",
        "No such device",
        "Not a directory",
        "Is a directory",
        "Invalid argument",
        "Too many open files in system",
        "Too many open files",
        "Inappropriate ioctl for device",
        "Text file busy",
        "File too large",
        "No space left on device",
        "Illegal seek",
        "Read-only file system",
        "Too many links",
        "Broken pipe",
        "Numerical argument out of domain",
        "Numerical result out of range",
    ];
    let known = |table: &[&str], first: i32| {
        usize::try_from(errnum - first)
            .ok()
            .and_then(|i| table.get(i))
            .map(|s| String::from(*s))
    };
    let text = match libc {
        Libc::Glibc => match errnum {
            0 => Some("Success".into()),
            1..=34 => known(&shared, 1),
            // TODO: glibc's messages past ELOOP.
            _ => known(
                &[
                    "Resource deadlock avoided",
                    "File name too long",
                    "No locks available",
                    "Function not implemented",
                    "Directory not empty",
                    "Too many levels of symbolic links",
                ],
                35,
            ),
        },
        Libc::Apple => match errnum {
            0 => Some("Undefined error: 0".into()),
            6 => Some("Device not configured".into()),
            11 => Some("Resource deadlock avoided".into()),
            12 => Some("Cannot allocate memory".into()),
            16 => Some("Resource busy".into()),
            18 => Some("Cross-device link".into()),
            19 => Some("Operation not supported by device".into()),
            29 => Some("Illegal seek".into()),
            34 => Some("Result too large".into()),
            1..=34 => known(&shared, 1),
            _ => known(APPLE_PAST_ERANGE, 35),
        },
        Libc::Ucrt => known(MSVCRT, 0),
    };
    text.unwrap_or_else(|| match libc {
        Libc::Glibc => format!("Unknown error {errnum}"),
        Libc::Apple => format!("Unknown error: {errnum}"),
        Libc::Ucrt => "Unknown error".into(),
    })
}

/// Apple's libc's messages from `EAGAIN` (35), measured natively.
const APPLE_PAST_ERANGE: &[&str] = &[
    "Resource temporarily unavailable",
    "Operation now in progress",
    "Operation already in progress",
    "Socket operation on non-socket",
    "Destination address required",
    "Message too long",
    "Protocol wrong type for socket",
    "Protocol not available",
    "Protocol not supported",
    "Socket type not supported",
    "Operation not supported",
    "Protocol family not supported",
    "Address family not supported by protocol family",
    "Address already in use",
    "Can't assign requested address",
    "Network is down",
    "Network is unreachable",
    "Network dropped connection on reset",
    "Software caused connection abort",
    "Connection reset by peer",
    "No buffer space available",
    "Socket is already connected",
    "Socket is not connected",
    "Can't send after socket shutdown",
    "Too many references: can't splice",
    "Operation timed out",
    "Connection refused",
    "Too many levels of symbolic links",
    "File name too long",
    "Host is down",
    "No route to host",
    "Directory not empty",
    "Too many processes",
    "Too many users",
    "Disc quota exceeded",
    "Stale NFS file handle",
    "Too many levels of remote in path",
    "RPC struct is bad",
    "RPC version wrong",
    "RPC prog. not avail",
    "Program version wrong",
    "Bad procedure for program",
    "No locks available",
    "Function not implemented",
    "Inappropriate file type or format",
    "Authentication error",
    "Need authenticator",
    "Device power is off",
    "Device error",
    "Value too large to be stored in data type",
    "Bad executable (or shared library)",
    "Bad CPU type in executable",
    "Shared library version mismatch",
    "Malformed Mach-o file",
    "Operation canceled",
    "Identifier removed",
    "No message of desired type",
    "Illegal byte sequence",
    "Attribute not found",
    "Bad message",
    "EMULTIHOP (Reserved)",
    "No message available on STREAM",
    "ENOLINK (Reserved)",
    "No STREAM resources",
    "Not a STREAM",
    "Protocol error",
    "STREAM ioctl timeout",
    "Operation not supported on socket",
    "Policy not found",
    "State not recoverable",
    "Previous owner died",
    "Interface output queue is full",
    "Capabilities insufficient",
];

/// msvcrt's `_sys_errlist`.
const MSVCRT: &[&str] = &[
    "No error",
    "Operation not permitted",
    "No such file or directory",
    "No such process",
    "Interrupted function call",
    "Input/output error",
    "No such device or address",
    "Arg list too long",
    "Exec format error",
    "Bad file descriptor",
    "No child processes",
    "Resource temporarily unavailable",
    "Not enough space",
    "Permission denied",
    "Bad address",
    "Unknown error",
    "Resource device",
    "File exists",
    "Improper link",
    "No such device",
    "Not a directory",
    "Is a directory",
    "Invalid argument",
    "Too many open files in system",
    "Too many open files",
    "Inappropriate I/O control operation",
    "Unknown error",
    "File too large",
    "No space left on device",
    "Invalid seek",
    "Read-only file system",
    "Too many links",
    "Broken pipe",
    "Domain error",
    "Result too large",
    "Unknown error",
    "Resource deadlock avoided",
    "Unknown error",
    "Filename too long",
    "No locks available",
    "Function not implemented",
    "Directory not empty",
    "Illegal byte sequence",
];

fn arg(name: &str, args: &[i64], i: usize) -> Result<i64, C5Error> {
    (args.get(i).copied())
        .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {name}: missing argument {}", i + 1)))
}

pub(super) fn call<H: Host>(
    name: &str,
    args: &[i64],
    mem: &mut Memory,
    host: &mut H,
) -> Option<Result<i64, C5Error>> {
    if !NAMES.contains(&name) {
        return None;
    }
    Some((|| match name {
        // C99 7.23.2.4: the calendar time, also stored through a non-null
        // argument; (time_t)-1 where the host has none.
        "time" => {
            let now = host.time();
            let out = arg(name, args, 0)?;
            if out != 0 {
                mem.write_checked(out as usize, &now.to_le_bytes())?;
            }
            Ok(now)
        }
        // The processor time's approximation: the host's time since the run
        // began, in the bundled <time.h>'s CLOCKS_PER_SEC of 1000000.
        "clock" => Ok(host.elapsed_micros()),
        "difftime" => {
            let d = arg(name, args, 0)?.wrapping_sub(arg(name, args, 1)?);
            Ok((d as f64).to_bits() as i64)
        }
        "rand" => Ok(mem.rand.next()),
        "srand" => {
            mem.rand.seed(arg(name, args, 0)? as u32);
            Ok(0)
        }
        // Each message is installed once and stays where it is.
        "strerror" => {
            let errnum = arg(name, args, 0)? as i32;
            if let Some(&at) = mem.messages.get(&errnum) {
                return Ok(at as i64);
            }
            let text = message(Libc::of(mem.target), errnum);
            let at = mem.install_cstring(text.as_bytes());
            mem.messages.insert(errnum, at);
            Ok(at as i64)
        }
        _ => {
            let errno = super::load_from_memory(
                mem,
                mem.stdio() + super::STDIO_ERRNO,
                super::LoadKind::I32,
            )? as i32;
            let mut line = match arg(name, args, 0)? {
                0 => Vec::new(),
                s => mem.c_string(s as usize)?,
            };
            if !line.is_empty() {
                line.extend_from_slice(b": ");
            }
            line.extend_from_slice(message(Libc::of(mem.target), errno).as_bytes());
            line.push(b'\n');
            host.write(2, &line);
            Ok(0)
        }
    })())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn rand_draws_each_library_s_sequence() {
        let draw = |libc| {
            let mut g = Rand::new(libc);
            [g.next(), g.next(), g.next()]
        };
        assert_eq!(draw(Libc::Glibc), [1804289383, 846930886, 1681692777]);
        assert_eq!(draw(Libc::Apple), [16807, 282475249, 1622650073]);
        assert_eq!(draw(Libc::Ucrt), [41, 18467, 6334]);
        let mut apple = Rand::new(Libc::Apple);
        apple.seed(0);
        assert_eq!(apple.next(), 520932930);
    }
}

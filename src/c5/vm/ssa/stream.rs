//! Streams (C99 7.19.2, 7.19.3): each a `FILE` object in the program's
//! memory, keyed by its address, whose descriptor, buffered input and
//! indicators the interpreter keeps.

use alloc::collections::VecDeque;
use alloc::format;

use crate::c5::error::C5Error;
use crate::c5::host::Host;

use super::scan::{self, Input};
use super::{Memory, Varargs};

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

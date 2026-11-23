//! Source positions of an assembler unit and the diagnostics reported at
//! them. Each is reported at `file:line` and assembly goes on with the
//! next statement; the passes collect [`AsmError`]s for that.

use crate::c5::diag::{Code, Level, Loc};

/// A diagnostic at a line, from 1, of the text a pass read (0 when no
/// statement owns it), and the macro invocations it was expanded from,
/// innermost first. `code` is [`Code::ASSEMBLER`] for an error.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmError {
    pub line: u32,
    pub invoked_at: alloc::vec::Vec<u32>,
    pub text: alloc::string::String,
    pub code: Code,
}

impl AsmError {
    pub(crate) fn at(line: u32, text: alloc::string::String) -> Self {
        Self::coded(Code::ASSEMBLER, line, text)
    }

    pub(crate) fn coded(code: Code, line: u32, text: alloc::string::String) -> Self {
        AsmError {
            line,
            invoked_at: alloc::vec::Vec::new(),
            text,
            code,
        }
    }

    pub(crate) fn is_error(&self) -> bool {
        self.code.default_level() == Level::Error
    }
}

/// A pass's diagnostics, at least one of them an error.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmErrors(pub alloc::vec::Vec<AsmError>);

impl AsmErrors {
    pub(crate) fn at(line: u32, text: alloc::string::String) -> Self {
        AsmErrors(alloc::vec![AsmError::at(line, text)])
    }

    /// For a pass that reports errors alone.
    pub(crate) fn check(errors: alloc::vec::Vec<AsmError>) -> Result<(), AsmErrors> {
        Self::split(errors).map(|warnings| debug_assert!(warnings.is_empty(), "{warnings:?}"))
    }

    /// The warnings when no row is an error, else every row.
    pub(crate) fn split(
        rows: alloc::vec::Vec<AsmError>,
    ) -> Result<alloc::vec::Vec<AsmError>, AsmErrors> {
        match rows.iter().any(AsmError::is_error) {
            true => Err(AsmErrors(rows)),
            false => Ok(rows),
        }
    }
}

/// Each prepared line's input line and the macro invocation that wrote it:
/// an error in a body line carries a note for each invocation.
pub(crate) struct AsmOrigin {
    lines: alloc::vec::Vec<(u32, u32)>,
    /// Each context's invoking line and enclosing context; 0 is the input.
    contexts: alloc::vec::Vec<(u32, u32)>,
}

impl Default for AsmOrigin {
    fn default() -> Self {
        Self::identity(0)
    }
}

impl AsmOrigin {
    pub(crate) fn identity(lines: usize) -> Self {
        AsmOrigin {
            lines: (1..=lines as u32).map(|l| (l, 0)).collect(),
            contexts: alloc::vec![(0, 0)],
        }
    }

    pub(crate) fn enter(&mut self, line: u32, outer: u32) -> u32 {
        self.contexts.push((line, outer));
        self.contexts.len() as u32 - 1
    }

    pub(crate) fn push(&mut self, line: u32, ctx: u32, count: usize) {
        self.lines.extend(core::iter::repeat_n((line, ctx), count));
    }

    pub(crate) fn len(&self) -> usize {
        self.lines.len()
    }

    /// The invoking lines of `ctx`, innermost first.
    pub(crate) fn invoked_at(&self, mut ctx: u32) -> alloc::vec::Vec<u32> {
        let mut out = alloc::vec::Vec::new();
        while ctx != 0 {
            let (line, outer) = self.contexts[ctx as usize];
            out.push(line);
            ctx = outer;
        }
        out
    }

    /// Restate an error at a prepared line in terms of the input.
    pub(crate) fn place(&self, e: &mut AsmError) {
        match e
            .line
            .checked_sub(1)
            .and_then(|i| self.lines.get(i as usize))
        {
            Some(&(line, ctx)) => {
                e.line = line;
                e.invoked_at = self.invoked_at(ctx);
            }
            None => e.line = 0,
        }
    }
}

impl From<alloc::string::String> for AsmErrors {
    fn from(text: alloc::string::String) -> Self {
        AsmErrors::at(0, text)
    }
}

impl From<&str> for AsmErrors {
    fn from(text: &str) -> Self {
        Self::from(alloc::string::String::from(text))
    }
}

/// The first error, for a caller reporting at a position of its own.
impl From<AsmErrors> for alloc::string::String {
    fn from(e: AsmErrors) -> Self {
        e.0.into_iter()
            .find(AsmError::is_error)
            .map(|e| e.text)
            .unwrap_or_default()
    }
}

/// A unit's text prepared for extraction, where its lines came from, and the
/// errors of the statements it left out, after the lines written before them.
pub(crate) struct AsmPrepared {
    pub text: alloc::string::String,
    pub origin: AsmOrigin,
    pub errors: alloc::vec::Vec<(u32, AsmError)>,
}

#[cfg(test)]
impl AsmPrepared {
    /// The text of a preparation that left no statement out.
    pub(crate) fn checked(self) -> Result<alloc::string::String, AsmErrors> {
        AsmErrors::check(self.errors.into_iter().map(|(_, e)| e).collect()).map(|()| self.text)
    }
}

/// A message without the inline-asm context the shared assembler's messages
/// lead with, which a standalone source is not.
/// TODO: the caller supplies the context, not the message text.
pub(crate) fn source_message(text: &str) -> &str {
    ["inline asm: ", "aarch64 inline asm: "]
        .iter()
        .find_map(|p| text.strip_prefix(p))
        .unwrap_or(text)
}

/// The file and line each line of a source stands for: a marker
/// `# N "file" [flags]` makes the next line line N of `file`.
pub(crate) struct AsmSourceMap {
    files: alloc::vec::Vec<alloc::string::String>,
    /// Each line's file in `files` and line there; empty with no marker.
    lines: alloc::vec::Vec<(u32, u32)>,
}

impl AsmSourceMap {
    /// Map `text`, named `file`, blanking its markers. A marker counts
    /// only when it names a file; gcc's `# 0 "" 2` after an inline-asm block
    /// returns to the physical position.
    pub(crate) fn read(text: &str, file: &str) -> (alloc::string::String, Self) {
        let mut map = AsmSourceMap {
            files: alloc::vec![alloc::string::String::from(file)],
            lines: alloc::vec::Vec::new(),
        };
        if !text.contains('#') {
            return (alloc::string::String::from(text), map);
        }
        let mut out = alloc::string::String::with_capacity(text.len());
        let (mut cur, mut next) = (0u32, 1u32);
        let mut any = false;
        for (i, line) in text.split('\n').enumerate() {
            if i > 0 {
                out.push('\n');
            }
            map.lines.push((cur, next));
            next += 1;
            let marker = line
                .trim_start()
                .strip_prefix('#')
                .and_then(|b| crate::c5::lexer::parse_line_marker(b.as_bytes()));
            let Some((name, n, returning)) =
                marker.and_then(|m| Some((m.file?, m.line, m.returning)))
            else {
                out.push_str(line);
                continue;
            };
            any = true;
            if name.is_empty() && returning {
                (cur, next) = (0, i as u32 + 2);
                continue;
            }
            cur = match map.files.iter().position(|f| *f == name) {
                Some(k) => k as u32,
                None => {
                    map.files.push(name);
                    map.files.len() as u32 - 1
                }
            };
            next = n as u32;
        }
        if !any {
            map.lines.clear();
        }
        (out, map)
    }

    pub(crate) fn loc(&self, line: u32) -> Option<Loc> {
        let index = line.checked_sub(1)? as usize;
        let (file, line) = if self.lines.is_empty() {
            (0, line)
        } else {
            *self.lines.get(index)?
        };
        Some(Loc::new(self.files[file as usize].clone(), line))
    }
}

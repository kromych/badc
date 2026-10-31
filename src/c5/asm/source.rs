//! Source positions of an assembler unit and the errors reported at them.
//! GNU as reports each error at `file:line` and goes on with the next
//! statement; the passes collect [`AsmError`]s the same way.

use crate::c5::diag::Loc;

/// An error at a line, from 1, of the text a pass read; 0 when no statement
/// owns it.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmError {
    pub line: u32,
    pub text: alloc::string::String,
}

/// A pass's errors; never empty.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmErrors(pub alloc::vec::Vec<AsmError>);

impl AsmErrors {
    pub(crate) fn at(line: u32, text: alloc::string::String) -> Self {
        AsmErrors(alloc::vec![AsmError { line, text }])
    }

    pub(crate) fn check(errors: alloc::vec::Vec<AsmError>) -> Result<(), AsmErrors> {
        if errors.is_empty() {
            Ok(())
        } else {
            Err(AsmErrors(errors))
        }
    }
}

/// Restate each line through `origin`, the line each line was prepared from.
pub(crate) fn remap_lines(errors: &mut [AsmError], origin: &[u32]) {
    for e in errors {
        e.line = e
            .line
            .checked_sub(1)
            .and_then(|i| origin.get(i as usize).copied())
            .unwrap_or(0);
    }
}

impl From<alloc::string::String> for AsmErrors {
    fn from(text: alloc::string::String) -> Self {
        AsmErrors(alloc::vec![AsmError { line: 0, text }])
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
        e.0.into_iter().next().map(|e| e.text).unwrap_or_default()
    }
}

/// A unit's text prepared for extraction, the source line of each of its
/// lines, and the errors of the statements it left out.
pub(crate) struct AsmPrepared {
    pub text: alloc::string::String,
    pub origin: alloc::vec::Vec<u32>,
    pub errors: alloc::vec::Vec<AsmError>,
}

#[cfg(test)]
impl AsmPrepared {
    /// The text of a preparation that left no statement out.
    pub(crate) fn checked(self) -> Result<alloc::string::String, AsmErrors> {
        AsmErrors::check(self.errors).map(|()| self.text)
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
/// `# N "file" [flags]` makes the next line line N of `file`, as in gas.
pub(crate) struct AsmSourceMap {
    files: alloc::vec::Vec<alloc::string::String>,
    /// Each line's file in `files` and line there; empty with no marker.
    lines: alloc::vec::Vec<(u32, u32)>,
}

impl AsmSourceMap {
    /// Map `text`, named `file`, blanking its markers. gas takes a marker
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

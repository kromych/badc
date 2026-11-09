//! The diagnostic value: where it points, what it says, and the notes
//! that hang off it.

use alloc::string::String;
use alloc::vec::Vec;

use super::code::{Code, Level};

/// Where a diagnostic points. `file` and `line` are what it prints,
/// after any `#line` remapping. `offset` is the byte offset into the
/// preprocessed translation unit, which is the position the diagnostic
/// pragmas resolve on; it is `None` where no unit position applies --
/// the driver, the linker and the object writers.
#[derive(Clone, PartialEq, Eq, Debug)]
pub struct Loc {
    pub file: String,
    pub line: u32,
    pub offset: Option<u32>,
}

impl Loc {
    pub fn new(file: impl Into<String>, line: u32) -> Self {
        Self {
            file: file.into(),
            line,
            offset: None,
        }
    }

    /// A position inside a translation unit, so the pragmas in effect
    /// at `offset` apply.
    pub fn in_unit(file: impl Into<String>, line: u32, offset: u32) -> Self {
        Self {
            file: file.into(),
            line,
            offset: Some(offset),
        }
    }
}

/// One reported diagnostic, with its level already resolved.
///
/// TODO: the text is a `String` formatted at the site. Typed payloads
/// -- a per-row message struct, so every template lives in the
/// catalog and localization has one place to work on -- are deferred
/// until the sites are migrated.
#[derive(Clone, PartialEq, Eq, Debug)]
pub struct Diagnostic {
    pub code: Code,
    pub level: Level,
    pub loc: Option<Loc>,
    pub text: String,
    /// The text of the line `loc` points at, echoed beneath the
    /// message the way gcc prints the offending line.
    pub source_line: Option<String>,
    pub notes: Vec<(Option<Loc>, String)>,
    /// `source_line` is still to be read from the unit: an error is built
    /// on paths a trial parse discards, so the compiler reads the line only
    /// when the diagnostic leaves it.
    pub(crate) echo_pending: bool,
}

impl Diagnostic {
    pub fn new(code: Code, level: Level, loc: Option<Loc>, text: impl Into<String>) -> Self {
        Self {
            code,
            level,
            loc,
            text: text.into(),
            source_line: None,
            notes: Vec::new(),
            echo_pending: false,
        }
    }

    /// Mark `source_line` as the line `loc` points at, read later.
    pub(crate) fn with_pending_echo(mut self) -> Self {
        self.echo_pending = true;
        self
    }

    pub fn with_source_line(mut self, line: Option<String>) -> Self {
        self.source_line = line;
        self
    }

    pub fn with_note(mut self, loc: Option<Loc>, text: impl Into<String>) -> Self {
        self.notes.push((loc, text.into()));
        self
    }
}

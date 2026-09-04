//! Rendering. Everything goes through [`core::fmt::Write`], so the
//! library, the `no_std` build and the CLI print identically.
//!
//! A controllable diagnostic ends with gcc's `[-Wname]` tail, byte for
//! byte, so a tool matching `\[-W([\w-]+)\]` keeps working; the code
//! bracket comes first and has one grammar at every severity.

use alloc::format;
use core::fmt;

use super::catalog::rows;
use super::code::{Class, Code, Level};
use super::message::{Diagnostic, Loc};

/// The word a diagnostic line carries, and the attribute it takes on a
/// terminal. Colour keys on the level and the class, never on the text.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Severity {
    Error,
    Warning,
    Info,
    Note,
}

/// Ends the coloured run.
pub const RESET: &str = "\x1b[0m";

impl Severity {
    /// The order a scan over an already formatted line must try the
    /// words in: the first match wins, so a line naming two severities
    /// takes the one this order puts first.
    pub const SCAN_ORDER: [Severity; 4] = [
        Severity::Error,
        Severity::Warning,
        Severity::Info,
        Severity::Note,
    ];

    pub const fn of(level: Level, class: Class) -> Severity {
        match (class, level) {
            (Class::Note, _) => Severity::Note,
            (_, Level::Error) => Severity::Error,
            _ => Severity::Warning,
        }
    }

    pub const fn word(self) -> &'static str {
        match self {
            Severity::Error => "error",
            Severity::Warning => "warning",
            Severity::Info => "info",
            Severity::Note => "note",
        }
    }

    pub const fn capitalized(self) -> &'static str {
        match self {
            Severity::Error => "Error",
            Severity::Warning => "Warning",
            Severity::Info => "Info",
            Severity::Note => "Note",
        }
    }

    pub const fn color(self) -> &'static str {
        match self {
            Severity::Error => "\x1b[1;31m",
            Severity::Warning => "\x1b[1;33m",
            Severity::Info => "\x1b[1;32m",
            Severity::Note => "\x1b[1;36m",
        }
    }
}

impl Diagnostic {
    pub fn render(&self, out: &mut impl fmt::Write, color: bool) -> fmt::Result {
        let severity = Severity::of(self.level, self.code.class());
        render_line(out, color, self.loc.as_ref(), severity, &self.text)?;
        write!(out, " [{}]", self.code)?;
        if self.code.class() == Class::Controllable {
            write!(out, " [-W{}]", self.code.name())?;
        }
        // The echoed line follows the brackets, where gcc puts the
        // source it points at.
        if let Some(source) = &self.source_line {
            out.write_char('\n')?;
            out.write_str(source)?;
        }
        for (loc, text) in &self.notes {
            out.write_char('\n')?;
            render_line(out, color, loc.as_ref(), Severity::Note, text)?;
        }
        Ok(())
    }
}

impl fmt::Display for Diagnostic {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        self.render(f, false)
    }
}

fn render_line(
    out: &mut impl fmt::Write,
    color: bool,
    loc: Option<&Loc>,
    severity: Severity,
    text: &str,
) -> fmt::Result {
    if let Some(loc) = loc {
        write!(out, "{}:{}: ", loc.file, loc.line)?;
    }
    if color {
        write!(
            out,
            "{}{}:{RESET} {text}",
            severity.color(),
            severity.word()
        )
    } else {
        write!(out, "{}: {text}", severity.word())
    }
}

const W_CODE: usize = 6;
const W_NAME: usize = 30;
const W_LEVEL: usize = 8;
const W_CLASS: usize = 13;
const W_GROUPS: usize = 18;
const W_STATUS: usize = 8;

/// The whole catalogue, one row per line. This is what
/// `--list-diagnostics` prints and what `tests/diagnostics/catalog.txt`
/// pins, so a change to the contract is a visible diff.
pub fn list_catalog(out: &mut impl fmt::Write) -> fmt::Result {
    write_row(
        out,
        [
            "code",
            "name",
            "default",
            "class",
            "groups",
            "status",
            "description",
        ],
    )?;
    for row in rows() {
        write_row(
            out,
            [
                &format!("{}", row.code),
                row.name,
                row.default_level.as_str(),
                row.class.as_str(),
                &group_list(row.code),
                row.status.as_str(),
                row.description,
            ],
        )?;
    }
    Ok(())
}

fn write_row(out: &mut impl fmt::Write, cells: [&str; 7]) -> fmt::Result {
    let [code, name, level, class, groups, status, description] = cells;
    writeln!(
        out,
        "{code:<W_CODE$} {name:<W_NAME$} {level:<W_LEVEL$} {class:<W_CLASS$} \
         {groups:<W_GROUPS$} {status:<W_STATUS$} {description}"
    )
}

/// One row in full, for `--explain`.
pub fn explain(out: &mut impl fmt::Write, code: Code) -> fmt::Result {
    let Some(row) = code.row() else {
        return Ok(());
    };
    writeln!(out, "{} {}", row.code, row.name)?;
    writeln!(out, "  description  {}", row.description)?;
    writeln!(out, "  default      {}", row.default_level.as_str())?;
    writeln!(out, "  class        {}", row.class.as_str())?;
    writeln!(out, "  groups       {}", group_list(code))?;
    writeln!(out, "  status       {}", row.status.as_str())?;
    if !row.aliases.is_empty() {
        writeln!(out, "  aliases      {}", row.aliases.join(", "))?;
    }
    Ok(())
}

fn group_list(code: Code) -> alloc::string::String {
    let groups = code.groups();
    if groups.is_empty() {
        return "-".into();
    }
    let mut out = alloc::string::String::new();
    for name in groups.names() {
        if !out.is_empty() {
            out.push(',');
        }
        out.push_str(name);
    }
    out
}

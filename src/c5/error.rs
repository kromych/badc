use alloc::string::String;
use alloc::vec::Vec;
use core::fmt;

use super::diag::{Code, Diagnostic, Level, Loc};

#[derive(Debug, Clone)]
pub enum C5Error {
    /// The diagnostics of the phase that failed, in the order they were
    /// reported: what the phase had warned about, then the error that
    /// ended it, or every one it produced when a raised warning failed
    /// it. At least one is at the error level. `Display` prints one per
    /// line, so a caller that only prints the error sees what the
    /// driver would have printed.
    Compile(Vec<Diagnostic>),
    /// A fault the VM's execution hit; not a compiler diagnostic.
    Runtime(String),
}

impl C5Error {
    /// The diagnostics a compile error carries; empty for a runtime
    /// fault.
    pub fn diagnostics(&self) -> &[Diagnostic] {
        match self {
            C5Error::Compile(diagnostics) => diagnostics,
            C5Error::Runtime(_) => &[],
        }
    }

    pub(crate) fn into_diagnostics(self) -> Vec<Diagnostic> {
        match self {
            C5Error::Compile(diagnostics) => diagnostics,
            C5Error::Runtime(_) => Vec::new(),
        }
    }

    pub(crate) fn of(diagnostic: Diagnostic) -> Self {
        Self::Compile(alloc::vec![diagnostic])
    }

    /// A hard error at a source position.
    pub(crate) fn at(code: Code, file: &str, line: usize, text: impl Into<String>) -> Self {
        Self::of(Diagnostic::new(
            code,
            Level::Error,
            Some(Loc::new(file, line as u32)),
            text,
        ))
    }

    /// A hard error with no source position: the driver, codegen, the
    /// linker and the object writers report from outside a translation
    /// unit.
    pub(crate) fn hard(code: Code, text: impl Into<String>) -> Self {
        Self::of(Diagnostic::new(code, Level::Error, None, text))
    }

    /// A broken invariant of badc's own. The marker mirrors gcc's and
    /// clang's, so the reader can tell the failure is badc's to fix and
    /// worth filing. Anything reachable by valid input belongs to
    /// [`Self::hard`] instead, so the marker stays a reliable signal.
    pub(crate) fn internal(text: impl AsRef<str>) -> Self {
        Self::hard(
            Code::INTERNAL,
            alloc::format!("internal compiler error: {}", text.as_ref()),
        )
    }

    /// Put the diagnostics the failed phase reported before this error
    /// ahead of it, so none is lost when the error unwinds past the
    /// sink holding them.
    pub(crate) fn after(self, mut earlier: Vec<Diagnostic>) -> Self {
        match self {
            C5Error::Compile(mine) => {
                earlier.extend(mine);
                C5Error::Compile(earlier)
            }
            runtime => runtime,
        }
    }
}

impl fmt::Display for C5Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            C5Error::Compile(diagnostics) => {
                for (i, diagnostic) in diagnostics.iter().enumerate() {
                    if i > 0 {
                        f.write_str("\n")?;
                    }
                    diagnostic.render(f, false)?;
                }
                Ok(())
            }
            C5Error::Runtime(msg) => write!(f, "error: runtime: {}", msg),
        }
    }
}

// std::error::Error doesn't exist in core; only register as an Error
// when std is available. Any Display impl is enough for `?` propagation
// either way.
#[cfg(feature = "std")]
impl std::error::Error for C5Error {}

use alloc::string::String;
use core::fmt;

use super::diag::{Code, Diagnostic, Level, Loc};

#[derive(Debug, Clone)]
pub enum C5Error {
    /// A diagnostic at the error level, rendered by the `diag` printer:
    /// `<file>:<line>: error: <text> [B<code>]`, the position omitted
    /// where none applies. The constructors below build every one.
    /// TODO: carry the `Diagnostic` itself once every producer builds one.
    Compile(String),
    /// A fault the VM's execution hit; not a compiler diagnostic.
    Runtime(String),
}

impl C5Error {
    /// A hard error at a source position.
    pub(crate) fn at(code: Code, file: &str, line: usize, text: impl Into<String>) -> Self {
        Self::render(Diagnostic::new(
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
        Self::render(Diagnostic::new(code, Level::Error, None, text))
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

    pub(crate) fn render(diagnostic: Diagnostic) -> Self {
        use alloc::string::ToString;
        Self::Compile(diagnostic.to_string())
    }
}

impl fmt::Display for C5Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            C5Error::Compile(msg) => write!(f, "{}", msg),
            C5Error::Runtime(msg) => write!(f, "error: runtime: {}", msg),
        }
    }
}

// std::error::Error doesn't exist in core; only register as an Error
// when std is available. Any Display impl is enough for `?` propagation
// either way.
#[cfg(feature = "std")]
impl std::error::Error for C5Error {}

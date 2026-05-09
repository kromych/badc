use alloc::string::String;
use core::fmt;

#[derive(Debug, Clone)]
pub enum C5Error {
    /// Compile error. Constructors are expected to produce a
    /// gcc / clang-shape message:
    ///   `<file>:<line>: error: <body>`
    /// see `Compiler::compile_err`, the preprocessor's
    /// `pp_err`, and `internal_err` for the canonical
    /// builders. The `Display` impl writes the message verbatim
    /// so the CLI's colorizer (which scans for ` error: ` /
    /// ` warning: `) handles every variant uniformly.
    Compile(String),
    Runtime(String),
}

impl fmt::Display for C5Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            C5Error::Compile(msg) => write!(f, "{}", msg),
            C5Error::Runtime(msg) => write!(f, "error: runtime: {}", msg),
        }
    }
}

/// Helper: produce a `<file>:<line>: error: <message>` string for
/// callers that aren't on a `Compiler` method (so they don't have
/// `self.lex.file` to grab automatically). The preprocessor uses
/// this with its `filename` and `line_no` parameters; codegen
/// sites that know which header they're emitting from use it
/// too. Returns `String` so callers can wrap with
/// `C5Error::Compile(...)` themselves.
pub(crate) fn fmt_compile_err(file: &str, line: usize, message: &str) -> String {
    use alloc::format;
    format!("{file}:{line}: error: {message}")
}

/// Helper: produce an `error: <message>` string for compile errors
/// without a meaningful (file, line) -- internal-consistency
/// errors, codegen-side asserts, post-parse fixups, etc. Stays in
/// the colorize-able shape so the CLI still highlights `error:`
/// when stderr is a TTY.
pub(crate) fn fmt_internal_err(message: &str) -> String {
    use alloc::format;
    format!("error: {message}")
}

// std::error::Error doesn't exist in core; only register as an Error
// when std is available. Any Display impl is enough for `?` propagation
// either way.
#[cfg(feature = "std")]
impl std::error::Error for C5Error {}

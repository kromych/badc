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

/// Sibling of [`fmt_compile_err`] for warning-severity diagnostics.
/// Same `<file>:<line>: warning: ...` shape gcc / clang use so the
/// CLI's TTY colorizer and any downstream log scrapers handle
/// errors and warnings uniformly.
pub(crate) fn fmt_compile_warn(file: &str, line: usize, message: &str) -> String {
    use alloc::format;
    format!("{file}:{line}: warning: {message}")
}

/// Helper: produce an `error: internal compiler error: <message>`
/// string for compile errors without a meaningful (file, line) --
/// internal-consistency violations, codegen-side asserts, post-
/// parse fixups, etc. These are bugs in c5 itself rather than in
/// the user's source. The `internal compiler error:` marker
/// mirrors gcc / clang's ICE phrasing so the user can tell at a
/// glance the failure is c5's fault and worth filing. The leading
/// `error:` keeps the CLI's TTY colorizer happy.
pub(crate) fn fmt_internal_err(message: &str) -> String {
    use alloc::format;
    format!("error: internal compiler error: {message}")
}

/// Helper: produce an `error: <message>` string for user-level
/// link / driver errors (undefined references, no input files,
/// malformed archives). These describe a problem with the user's
/// command line or sources -- not a c5 bug -- so they MUST NOT
/// carry the `internal compiler error:` marker. Mirrors ld /
/// gold's "error:" prefix. Gated to `native-emit` -- the callers
/// live in the linker module and the final-image writers, so under
/// `--no-default-features --lib` this helper would otherwise
/// trip the dead-code lint.
#[cfg(any(feature = "native-emit", feature = "std"))]
pub(crate) fn fmt_link_err(message: &str) -> String {
    use alloc::format;
    format!("error: {message}")
}

// std::error::Error doesn't exist in core; only register as an Error
// when std is available. Any Display impl is enough for `?` propagation
// either way.
#[cfg(feature = "std")]
impl std::error::Error for C5Error {}

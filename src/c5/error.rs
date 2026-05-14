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
/// gold's "error:" prefix.
pub(crate) fn fmt_link_err(message: &str) -> String {
    use alloc::format;
    format!("error: {message}")
}

/// Build the trailing `ctx: [pc-N]=Op ...` window the ICE
/// helpers append. Decodes each preceding slot as an `Op` when
/// it falls inside the enum range, otherwise emits `?<raw>` so a
/// drifted-into-operand-territory scanner shows the raw word.
/// Window is fixed at 16 slots -- enough to see the last few
/// op/operand pairs without burying the headline.
fn fmt_bytecode_window(text: &[i64], pc: usize) -> alloc::string::String {
    use alloc::format;
    use alloc::string::String;
    let lo = pc.saturating_sub(16);
    let mut ctx = String::new();
    for (i, &v) in text.iter().enumerate().take(pc).skip(lo) {
        let opn = crate::c5::op::Op::from_i64(v)
            .map(|o| format!("{o:?}"))
            .unwrap_or_else(|| format!("?{v}"));
        ctx.push_str(&format!(" [{i}]={opn}"));
    }
    ctx
}

/// Helper: produce a rich ICE diagnostic for a bytecode-scanner
/// failure (an op slot the codegen / optimizer didn't expect at
/// `pc`). The output names the function and source line the
/// instruction was attributed to and dumps the surrounding
/// bytecode slots -- decoded as `Op` names when they fall inside
/// the enum's range, raw integer otherwise -- so the failure can
/// be diagnosed without re-running the compile under a debugger.
///
/// Use this in `lower_program` passes that walk `program.text`
/// linearly with access to the full source-attribution columns;
/// the per-slot context is the most useful clue when the
/// scanner drifts off the op/operand boundary mid-function.
pub(crate) fn fmt_ice_bytecode(
    message: &str,
    program: &crate::c5::program::Program,
    pc: usize,
) -> String {
    use alloc::format;

    let raw = program.text.get(pc).copied().unwrap_or(0);
    let line = program.source_lines.get(pc).copied().unwrap_or(0);
    let func = program
        .source_functions
        .get(pc)
        .cloned()
        .unwrap_or_default();
    let file_idx = program.source_file_indices.get(pc).copied().unwrap_or(0);
    let fname = program
        .source_files
        .get(file_idx as usize)
        .cloned()
        .unwrap_or_default();
    let ctx = fmt_bytecode_window(&program.text, pc);
    format!(
        "error: internal compiler error: {message} \
        (pc={pc} raw={raw} func={func} file={fname} line={line} ctx:{ctx})"
    )
}

/// Helper: rich ICE diagnostic for a bytecode-scanner failure
/// that only has access to the raw text slice -- the optimizer
/// runs before source-attribution is wired through, so it can't
/// use [`fmt_ice_bytecode`]. Reports the surrounding op window
/// and the raw word at `pc` without a function / file / line.
pub(crate) fn fmt_ice_text(message: &str, text: &[i64], pc: usize) -> String {
    use alloc::format;
    let raw = text.get(pc).copied().unwrap_or(0);
    let ctx = fmt_bytecode_window(text, pc);
    format!("error: internal compiler error: {message} (pc={pc} raw={raw} ctx:{ctx})")
}

// std::error::Error doesn't exist in core; only register as an Error
// when std is available. Any Display impl is enough for `?` propagation
// either way.
#[cfg(feature = "std")]
impl std::error::Error for C5Error {}

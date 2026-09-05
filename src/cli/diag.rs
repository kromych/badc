use std::io::IsTerminal;

/// Print `msg` to stderr through `colorize_diagnostic`, deciding
/// once whether stderr is a TTY. Use for any user-visible error or
/// warning the CLI emits -- it's a no-op for messages that don't
/// look like a diagnostic, so plain "badc: file not found" lines
/// pass through unchanged.
pub(crate) fn eprint_diagnostic(msg: impl core::fmt::Display) {
    let stderr_is_tty = std::io::stderr().is_terminal();
    let s = msg.to_string();
    eprintln!("{}", colorize_diagnostic(&s, stderr_is_tty));
}

/// Add ANSI color around the severity word (`warning:`, `error:`,
/// `info:` / `note:`) inside a diagnostic line. Accepts either the gcc
/// shape `<file>:<line>: warning: <msg>` or any line whose severity
/// word is followed by a colon and a space; the rest stays untouched.
/// Falls through unchanged when stderr isn't a TTY so build logs stay
/// greppable.
///
/// This scans text because most sites still build their message as a
/// string. A [`badc::diag::Diagnostic`] carries its level and renders
/// its own color, so a migrated site does not pass through here.
pub(crate) fn colorize_diagnostic(line: &str, is_tty: bool) -> std::borrow::Cow<'_, str> {
    if !is_tty {
        return std::borrow::Cow::Borrowed(line);
    }
    if line.contains('\n') {
        return std::borrow::Cow::Owned(
            line.split('\n')
                .map(|l| colorize_diagnostic(l, is_tty))
                .collect::<Vec<_>>()
                .join("\n"),
        );
    }
    // After the `<file>:<line>: ` anchor, or at the front for a
    // severity-first line. The severity words are an allow-list so a
    // user-supplied identifier containing `:` is not re-colored.
    for severity in badc::diag::Severity::SCAN_ORDER {
        for word in [severity.word(), severity.capitalized()] {
            let color = severity.color();
            let reset = badc::diag::RESET;
            let needle = format!(" {word}: ");
            if let Some(pos) = line.find(&needle) {
                let prefix = &line[..pos + 1];
                let rest = &line[pos + needle.len()..];
                return std::borrow::Cow::Owned(format!("{prefix}{color}{word}:{reset} {rest}"));
            }
            let head = format!("{word}: ");
            if let Some(rest) = line.strip_prefix(&head) {
                return std::borrow::Cow::Owned(format!("{color}{word}:{reset} {rest}"));
            }
        }
    }
    std::borrow::Cow::Borrowed(line)
}

/// One diagnostic as this driver prints it: its own colour when stderr
/// is a terminal, keyed on the level rather than on a scan of the text.
pub(crate) fn rendered(diagnostic: &badc::diag::Diagnostic, tty: bool) -> String {
    let mut out = String::new();
    let _ = diagnostic.render(&mut out, tty);
    out
}

/// A failed phase's error as this driver prints it: one line per
/// diagnostic it carries, each coloured by its own level, every line
/// under `prefix`. A runtime fault has one line, coloured by its text.
pub(crate) fn error_lines(prefix: &str, e: &badc::C5Error, tty: bool) -> Vec<String> {
    match e {
        badc::C5Error::Compile(diagnostics) => diagnostics
            .iter()
            .map(|d| format!("{prefix}{}", rendered(d, tty)))
            .collect(),
        other => vec![colorize_diagnostic(&format!("{prefix}{other}"), tty).into_owned()],
    }
}

/// Print a failed phase's error to stderr, as [`error_lines`] renders it.
pub(crate) fn eprint_error(prefix: &str, e: &badc::C5Error) {
    let tty = std::io::stderr().is_terminal();
    for line in error_lines(prefix, e, tty) {
        eprintln!("{line}");
    }
}

/// Print a unit's diagnostics and report whether it may go on. A
/// warning raised to an error does not unwind at its site: the unit
/// parses whole and fails here, at the phase boundary, as gcc does.
pub(crate) fn report_unit_diagnostics(
    log: &mut TuLog,
    tty: bool,
    program: &badc::Program,
) -> Result<(), ()> {
    for line in &program.notes {
        log.diag(tty, line);
    }
    for d in &program.warnings {
        log.raw(rendered(d, tty));
    }
    if program
        .warnings
        .iter()
        .any(|d| d.level == badc::diag::Level::Error)
    {
        log.diag(tty, "badc: error: warnings treated as errors");
        return Err(());
    }
    Ok(())
}

/// Per-translation-unit diagnostic buffer. Under `--jobs` workers
/// finish out of order, so each records its `info:` / warning / error
/// lines here and the driver replays them in source order: stderr stays
/// grouped per source and byte-identical to a sequential build. Lines
/// are stored pre-formatted (colorized where the sequential path
/// colorized) and replayed verbatim.
#[derive(Default)]
pub(crate) struct TuLog {
    lines: Vec<String>,
}

impl TuLog {
    /// Record a diagnostic line, colorized for a TTY exactly as
    /// `eprint_diagnostic` prints it.
    pub(crate) fn diag(&mut self, tty: bool, msg: impl core::fmt::Display) {
        self.lines
            .push(colorize_diagnostic(&msg.to_string(), tty).into_owned());
    }
    /// Record a line verbatim (the include trace prints uncolored).
    pub(crate) fn raw(&mut self, line: String) {
        self.lines.push(line);
    }
    /// Record a failed phase's error, one line per diagnostic.
    pub(crate) fn error(&mut self, tty: bool, prefix: &str, e: &badc::C5Error) {
        self.lines.extend(error_lines(prefix, e, tty));
    }
    /// Replay every recorded line to stderr.
    pub(crate) fn flush(&self) {
        for l in &self.lines {
            eprintln!("{l}");
        }
    }
}

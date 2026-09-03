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
    /// Replay every recorded line to stderr.
    pub(crate) fn flush(&self) {
        for l in &self.lines {
            eprintln!("{l}");
        }
    }
}

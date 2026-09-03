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
/// `info:` / `note:`) inside a diagnostic line. We accept either
/// the gcc shape `<file>:<line>: warning: <msg>` or any line
/// whose severity word is followed by a colon and a space; the
/// rest of the message stays untouched. Falls through unchanged
/// when stderr isn't a TTY so build logs stay greppable.
pub(crate) fn colorize_diagnostic(line: &str, is_tty: bool) -> std::borrow::Cow<'_, str> {
    if !is_tty {
        return std::borrow::Cow::Borrowed(line);
    }
    // Find the first ` <severity>: ` -- after the `<file>:<line>: `
    // anchor in gcc-shape lines, or at the front for severity-first
    // lines (legacy / future-style). Severity words are matched
    // case-insensitively against a small allow-list so a
    // user-supplied identifier accidentally containing `:` doesn't
    // get re-colored.
    const SEVERITIES: &[(&str, &str)] = &[
        ("error", "\x1b[1;31m"), // bold red
        ("Error", "\x1b[1;31m"),
        ("warning", "\x1b[1;33m"), // bold yellow
        ("Warning", "\x1b[1;33m"),
        ("info", "\x1b[1;32m"), // bold green
        ("Info", "\x1b[1;32m"),
        ("note", "\x1b[1;36m"), // bold cyan
        ("Note", "\x1b[1;36m"),
    ];
    const RESET: &str = "\x1b[0m";
    for (word, color) in SEVERITIES {
        let needle = format!(" {word}: ");
        if let Some(pos) = line.find(&needle) {
            let prefix = &line[..pos + 1];
            let rest = &line[pos + needle.len()..];
            return std::borrow::Cow::Owned(format!("{prefix}{color}{word}:{RESET} {rest}"));
        }
        // Severity at the very start of the line.
        let head = format!("{word}: ");
        if line.starts_with(&head) {
            let rest = &line[head.len()..];
            return std::borrow::Cow::Owned(format!("{color}{word}:{RESET} {rest}"));
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

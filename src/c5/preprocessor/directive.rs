use crate::c5::error::C5Error;
use alloc::format;
use alloc::string::String;

pub(super) struct CondFrame {
    /// Whether the enclosing branch was active at the time of
    /// `#if` / `#ifdef`. A nested true branch inside an inactive
    /// outer branch must still be inactive.
    pub(super) parent_active: bool,
    /// Whether *this* arm of the conditional emits source.
    pub(super) this_branch_taken: bool,
    /// Whether *any* arm so far has emitted source. Used by
    /// `#else` to decide whether to take.
    pub(super) any_branch_taken: bool,
    /// Already-seen `#else` -- a second one is a hard error.
    pub(super) saw_else: bool,
}

impl CondFrame {
    // Suppress the unused field warning on `this_branch_taken` --
    // it's part of the struct's vocabulary and might be reached by
    // a future `#elif`.
    #[allow(dead_code)]
    fn _retain_field(&self) -> bool {
        self.this_branch_taken
    }
}

/// `#else` state transition on the innermost frame; returns the new
/// active state. Shared by the main directive loop and the
/// macro-argument line joiner so both agree on the semantics.
pub(super) fn apply_else(
    stack: &mut [CondFrame],
    filename: &str,
    line_no: usize,
) -> Result<bool, C5Error> {
    let frame = stack.last_mut().ok_or_else(|| {
        C5Error::Compile(crate::c5::error::fmt_compile_err(
            filename,
            line_no,
            "`#else` with no matching `#if`",
        ))
    })?;
    if frame.saw_else {
        return Err(C5Error::Compile(crate::c5::error::fmt_compile_err(
            filename,
            line_no,
            "duplicate `#else` for the same `#if`",
        )));
    }
    frame.saw_else = true;
    let taken = frame.parent_active && !frame.any_branch_taken;
    frame.this_branch_taken = taken;
    frame.any_branch_taken |= taken;
    Ok(taken)
}

/// Whether an `#elif` on the innermost frame is eligible to take
/// (parent branch active, no earlier arm taken). C99 6.10.1p3: the
/// controlling expression of an ineligible group is not evaluated,
/// so the caller evaluates only when this returns true.
pub(super) fn elif_eligible(
    stack: &[CondFrame],
    filename: &str,
    line_no: usize,
) -> Result<bool, C5Error> {
    let frame = stack.last().ok_or_else(|| {
        C5Error::Compile(crate::c5::error::fmt_compile_err(
            filename,
            line_no,
            "`#elif` with no matching `#if`",
        ))
    })?;
    Ok(frame.parent_active && !frame.any_branch_taken)
}

/// `#elif` state transition with the already-evaluated condition;
/// returns the new active state.
pub(super) fn apply_elif(
    stack: &mut [CondFrame],
    cond: bool,
    filename: &str,
    line_no: usize,
) -> Result<bool, C5Error> {
    let frame = stack.last_mut().ok_or_else(|| {
        C5Error::Compile(crate::c5::error::fmt_compile_err(
            filename,
            line_no,
            "`#elif` with no matching `#if`",
        ))
    })?;
    if frame.saw_else {
        return Err(C5Error::Compile(crate::c5::error::fmt_compile_err(
            filename,
            line_no,
            "`#elif` after `#else` for the same `#if`",
        )));
    }
    frame.this_branch_taken = cond;
    frame.any_branch_taken |= cond;
    Ok(cond)
}

/// `#endif` pops the innermost frame; returns the restored active state.
pub(super) fn apply_endif(
    stack: &mut Vec<CondFrame>,
    filename: &str,
    line_no: usize,
) -> Result<bool, C5Error> {
    let frame = stack.pop().ok_or_else(|| {
        C5Error::Compile(crate::c5::error::fmt_compile_err(
            filename,
            line_no,
            "`#endif` with no matching `#if`",
        ))
    })?;
    Ok(frame.parent_active)
}

pub(super) enum Directive<'a> {
    /// Object-like macro: `#define NAME body`.
    Define(&'a str, &'a str),
    /// Function-like macro: `#define NAME(p1, p2, ...) body`. The
    /// parens must be flush against the name -- a space (`#define
    /// NAME (...)`) parses as object-like with `(...)` as the body,
    /// matching the C standard.
    DefineFn(&'a str, Vec<&'a str>, &'a str),
    Undef(&'a str),
    Ifdef(&'a str),
    Ifndef(&'a str),
    If(&'a str),
    Else,
    /// `#elif <expr>` -- like `#else` followed by a re-evaluated
    /// `#if <expr>`, but only takes if no preceding branch did.
    Elif(&'a str),
    Endif,
    Pragma(&'a str),
    /// `#include "header"` (`quoted = true`) or `#include <header>`
    /// (`quoted = false`). A quoted include searches the directory of
    /// the including file before the system search paths (C99
    /// 6.10.2p2-3); an angle include searches only the system paths.
    Include {
        name: &'a str,
        quoted: bool,
    },
    /// `#include_next <header>` -- resume the header search from the
    /// entry after the one that supplied the current file, so a shim
    /// header can augment and forward to the next same-named header.
    IncludeNext {
        name: &'a str,
        quoted: bool,
    },
    /// `#line N` or `#line N "file"` (C99 6.10.4). The filename
    /// is optional -- bare `#line N` keeps the current file and
    /// just retargets the line counter.
    Line {
        line: usize,
        file: Option<&'a str>,
    },
    /// `#include <pp-tokens>` -- C99 6.10.2p4. The operand isn't
    /// already in `<...>` or `"..."` form, so the preprocessor
    /// has to macro-substitute the tokens before reparsing the
    /// result as one of the two literal include forms. The raw
    /// text is carried verbatim; substitution happens in the
    /// handler.
    IncludeMacro(&'a str),
    /// `#line pp-tokens` whose tokens are not already a literal line
    /// number (C99 6.10.4): the operand is macro-expanded and reparsed
    /// as `#line N ["file"]` in the handler.
    LineMacro(&'a str),
    /// `#error <message>` -- C99 sec 6.10.5. The diagnostic message is
    /// the literal text after `#error` up to the newline.
    Error(&'a str),
    /// `#warning <message>` -- gcc/clang extension, standardised in
    /// C23. Emits a `warning:` diagnostic but, unlike `#error`,
    /// compilation continues. Matches the diagnostic format every
    /// other warning site uses, so downstream tooling can scrape it.
    Warning(&'a str),
    Shebang,
    Other,
}

/// Format a GNU-style line marker (`# N "file"\n`) for the lexer.
/// Filenames get the minimum C-string escape (`\\` and `\"` are
/// escaped, everything else passes through). The lexer's
/// `parse_line_marker` decodes the same shape: it sets
/// `self.line = N - 1` and `self.file = file`, so the very next
/// `\n` consumed by the outer loop bumps `self.line` to `N` --
/// which means the next source line in the buffer is attributed
/// to `(file, N)`.
pub(super) fn format_line_marker(line: usize, file: &str) -> String {
    let mut escaped = String::with_capacity(file.len());
    for ch in file.chars() {
        match ch {
            '\\' => escaped.push_str("\\\\"),
            '"' => escaped.push_str("\\\""),
            other => escaped.push(other),
        }
    }
    format!("# {line} \"{escaped}\"\n")
}

pub(super) fn parse_directive(rest: &str) -> Directive<'_> {
    if let Some(after) = rest.strip_prefix("define") {
        let after = after.trim_start();
        let (name, rest_after_name) = split_ident(after);
        // Comments were removed in translation phase 3 (C99 5.1.1.2)
        // before directives execute, so `//` or `/*` remaining here
        // can only be string- or char-literal content and must stay.
        // Function-like form: name immediately followed by `(`. The
        // C standard requires no whitespace between the name and the
        // open paren -- a space turns it into an object-like macro
        // whose body starts with `(`. An unclosed paren falls through
        // to the object-like branch with the whole tail as the body,
        // matching how the lexer would see a syntactically broken
        // `#define`.
        if let Some(after_paren) = rest_after_name.strip_prefix('(')
            && let Some(close) = after_paren.find(')')
        {
            let params_str = &after_paren[..close];
            let body = after_paren[close + 1..].trim();
            let params: Vec<&str> = if params_str.trim().is_empty() {
                Vec::new()
            } else {
                params_str.split(',').map(|p| p.trim()).collect()
            };
            return Directive::DefineFn(name, params, body);
        }
        return Directive::Define(name, rest_after_name.trim());
    }
    if let Some(after) = rest.strip_prefix("undef") {
        return Directive::Undef(after.trim());
    }
    if let Some(after) = rest.strip_prefix("ifdef") {
        return Directive::Ifdef(after.trim());
    }
    if let Some(after) = rest.strip_prefix("ifndef") {
        return Directive::Ifndef(after.trim());
    }
    if let Some(after) = rest.strip_prefix("elif") {
        // `#elif EXPR` -- treated as `#else` followed by a re-evaluated
        // `#if EXPR`, but only if no preceding branch was taken.
        if after
            .chars()
            .next()
            .is_none_or(|c| !c.is_ascii_alphanumeric() && c != '_')
        {
            return Directive::Elif(after);
        }
    }
    if let Some(after) = rest.strip_prefix("if") {
        // Discriminate `#if` from `#ifdef`/`#ifndef` -- the latter
        // were caught above.
        if after
            .chars()
            .next()
            .is_none_or(|c| !c.is_ascii_alphanumeric() && c != '_')
        {
            return Directive::If(after);
        }
    }
    if rest.trim_start().starts_with("else") {
        let tail = rest.trim_start().trim_start_matches("else");
        if tail.is_empty() || tail.starts_with(char::is_whitespace) {
            return Directive::Else;
        }
    }
    if rest.trim_start().starts_with("endif") {
        let tail = rest.trim_start().trim_start_matches("endif");
        if tail.is_empty() || tail.starts_with(char::is_whitespace) {
            return Directive::Endif;
        }
    }
    if let Some(after) = rest.strip_prefix("pragma") {
        return Directive::Pragma(after.trim());
    }
    if let Some(after) = rest.strip_prefix("error") {
        // Accept `#error` with no message and `#error <text>`. C99
        // doesn't actually require any message text -- the
        // diagnostic is the directive itself -- but most users
        // expect to be able to write `#error "must be x86"`.
        if after.is_empty() || after.starts_with(char::is_whitespace) {
            return Directive::Error(after.trim_start());
        }
    }
    if let Some(after) = rest.strip_prefix("warning") {
        // `#warning <message>` -- emits a warning and continues.
        // gcc/clang extension; standardised by C23. Same shape as
        // `#error`, just a different severity.
        if after.is_empty() || after.starts_with(char::is_whitespace) {
            return Directive::Warning(after.trim_start());
        }
    }
    if let Some(after) = rest.strip_prefix("line") {
        let trimmed = after.trim();
        // Line number is required.
        let mut split = trimmed.splitn(2, char::is_whitespace);
        if let Some(num) = split.next()
            && let Ok(line) = num.parse::<usize>()
        {
            // Optional `"file"` -- strip surrounding quotes if
            // present. Anything malformed (e.g. unclosed quote)
            // falls through to `Other` and gets silently dropped,
            // matching how every other malformed directive is
            // handled.
            let file = split.next().and_then(|tail| {
                let t = tail.trim();
                t.strip_prefix('"').and_then(|s| s.strip_suffix('"'))
            });
            return Directive::Line { line, file };
        }
        // C99 6.10.4: the operand is not already a digit sequence, so
        // its tokens are macro-expanded and reparsed in the handler.
        if !trimmed.is_empty() {
            return Directive::LineMacro(trimmed);
        }
    }
    // `include_next` must be tested before `include`: the latter is a
    // prefix of the former, so the `include` branch would otherwise treat
    // `_next <...>` as a macro-form operand.
    if let Some(after) = rest.strip_prefix("include_next") {
        let trimmed = after.trim();
        if let Some(name) = trimmed.strip_prefix('<').and_then(|s| s.strip_suffix('>')) {
            return Directive::IncludeNext {
                name: name.trim(),
                quoted: false,
            };
        }
        if let Some(name) = trimmed.strip_prefix('"').and_then(|s| s.strip_suffix('"')) {
            return Directive::IncludeNext {
                name: name.trim(),
                quoted: true,
            };
        }
    }
    if let Some(after) = rest.strip_prefix("include") {
        let trimmed = after.trim();
        // Strip the `<...>` or `"..."` wrapping when the operand
        // is already in one of the two literal forms, recording which
        // form so the handler can apply the quoted-include source-dir
        // search.
        if let Some(name) = trimmed.strip_prefix('<').and_then(|s| s.strip_suffix('>')) {
            return Directive::Include {
                name: name.trim(),
                quoted: false,
            };
        }
        if let Some(name) = trimmed.strip_prefix('"').and_then(|s| s.strip_suffix('"')) {
            return Directive::Include {
                name: name.trim(),
                quoted: true,
            };
        }
        // C99 6.10.2p4: `#include <pp-tokens>` -- when the operand
        // isn't already a `<...>` or `"..."` literal, the
        // preprocessor expands the tokens and re-parses the
        // result as one of the two literal forms. Defer the
        // expansion to the include handler so the caller's
        // macro table is available.
        if !trimmed.is_empty() {
            return Directive::IncludeMacro(trimmed);
        }
    }
    if rest.starts_with('!') {
        return Directive::Shebang;
    }
    // GNU-style line marker: `# N "file" [flags]` -- the C99 form
    // is `#line N "file"` (handled above), but the amalgamator
    // and historic gcc preprocessors emit the keyword-less variant
    // too. Recognise it as `Directive::Line` so it doesn't trip
    // the unknown-directive warning. Trailing flag digits (1 2 3
    // 4) are GNU's enter / leave / system / extern markers; we
    // ignore them since c5 only tracks (file, line).
    let trimmed = rest.trim();
    if trimmed.chars().next().is_some_and(|c| c.is_ascii_digit()) {
        let mut split = trimmed.splitn(2, char::is_whitespace);
        if let Some(num) = split.next()
            && let Ok(line) = num.parse::<usize>()
        {
            let file = split.next().and_then(|tail| {
                let t = tail.trim_start();
                t.strip_prefix('"').and_then(|s| {
                    // Trailing flags after the closing quote are
                    // optional -- match up to the next quote and
                    // discard the rest.
                    s.find('"').map(|end| &s[..end])
                })
            });
            return Directive::Line { line, file };
        }
    }
    Directive::Other
}

/// Split off the leading identifier in `s`, returning `(ident,
/// rest)`. Used to peel the macro name from its replacement text.
pub(super) fn split_ident(s: &str) -> (&str, &str) {
    let bytes = s.as_bytes();
    let mut end = 0;
    while end < bytes.len() && (bytes[end].is_ascii_alphanumeric() || bytes[end] == b'_') {
        end += 1;
    }
    (&s[..end], &s[end..])
}

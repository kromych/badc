use alloc::string::String;

/// Phase-3 comment removal: strip `/* ... */` block comments and
/// `// ...` line comments from the entire source. Each comment is
/// replaced by a single space so token boundaries are preserved
/// (`a/**/b` becomes `a b`, not `ab`). Newlines inside block
/// comments stay as `\n` so line numbers and `__LINE__` are
/// faithful to the original source. Quoted strings and char
/// literals are passed through unchanged so `"//"` doesn't get
/// misread as a line comment.
pub(super) fn strip_c_comments(source: &str) -> String {
    let mut out = String::with_capacity(source.len());
    let bytes = source.as_bytes();
    let mut i = 0;
    // `source[copied..i]` is retained text not yet flushed. Flushing it
    // as one span rather than byte by byte keeps multi-byte UTF-8
    // sequences intact and skips a per-byte encode.
    let mut copied = 0;
    while i < bytes.len() {
        let c = bytes[i];
        if !matches!(c, b'/' | b'"' | b'\'') {
            let rest = &bytes[i + 1..];
            i += 1 + rest
                .iter()
                .position(|&b| matches!(b, b'/' | b'"' | b'\''))
                .unwrap_or(rest.len());
            continue;
        }
        if c == b'/' && bytes.get(i + 1) == Some(&b'*') {
            // Block comment.
            out.push_str(&source[copied..i]);
            i += 2;
            // An unterminated comment runs to end of file, as in
            // gcc / clang; the diagnostic is the lexer's.
            while i < bytes.len() {
                if bytes[i] == b'*' && bytes.get(i + 1) == Some(&b'/') {
                    i += 2;
                    break;
                }
                if bytes[i] == b'\n' {
                    out.push('\n');
                }
                i += 1;
            }
            out.push(' ');
            copied = i;
            continue;
        }
        if c == b'/' && bytes.get(i + 1) == Some(&b'/') {
            // Line comment -- skip to next newline (don't consume it).
            out.push_str(&source[copied..i]);
            i += 2;
            while i < bytes.len() && bytes[i] != b'\n' {
                i += 1;
            }
            out.push(' ');
            copied = i;
            continue;
        }
        if c == b'"' || c == b'\'' {
            // Quoted literals stay in the retained span so `"//"` etc.
            // survive; only the bounds are skipped here.
            i = skip_literal(bytes, i);
            continue;
        }
        i += 1;
    }
    out.push_str(&source[copied..]);
    out
}

/// Lexical context of a logical line at a given byte, used to decide
/// whether it ends inside an open `/* */` block comment. `Line` is a
/// `//` comment, which runs to the end of the assembled line.
#[derive(Clone, Copy, Default, PartialEq)]
enum ScanMode {
    #[default]
    Normal,
    Str,
    Char,
    Block,
    Line,
}

/// Fused phases 2 and 3: one pass over `source` producing the bytes
/// `strip_c_comments(&unfold_line_continuations(source))` produces,
/// with one scan and one output buffer. The scanner below carries the
/// [`ScanMode`] state across the splices phase 2 would perform, so the
/// join decision (a logical line ending inside an open block comment)
/// and the comment removal come from the same walk.
struct Fuse<'a> {
    src: &'a str,
    out: String,
    mode: ScanMode,
    /// Pending backslash escape inside a string or char literal.
    esc: bool,
    /// Half-seen top-level `/` at `slash_pos`. It stays pending across
    /// a splice, so `/` and `*` split over a continuation still open a
    /// comment; a logical line end discards it.
    slash: bool,
    slash_pos: usize,
    /// Half-seen `*` inside a block comment.
    star: bool,
    /// Start of the retained span not yet flushed to `out`. Splices,
    /// comment bounds and padding emission interrupt the span; plain
    /// line ends let it run on through the newline.
    copied: usize,
}

impl<'a> Fuse<'a> {
    fn flush_to(&mut self, end: usize) {
        if end > self.copied {
            self.out.push_str(&self.src[self.copied..end]);
        }
    }

    /// Advance the state over one content byte at `pos`, emitting the
    /// comment-boundary output. Retained bytes are not emitted here;
    /// they stay in the open span.
    fn step(&mut self, c: u8, pos: usize) {
        match self.mode {
            ScanMode::Normal => {
                if self.slash {
                    self.slash = false;
                    match c {
                        b'*' => {
                            self.flush_to(self.slash_pos);
                            self.copied = pos + 1;
                            self.mode = ScanMode::Block;
                            self.star = false;
                            return;
                        }
                        b'/' => {
                            self.flush_to(self.slash_pos);
                            self.copied = pos + 1;
                            self.mode = ScanMode::Line;
                            return;
                        }
                        // A pending `/` whose span was already flushed
                        // (it sat before a splice) is retained text.
                        _ if self.slash_pos < self.copied => self.out.push('/'),
                        _ => {}
                    }
                }
                match c {
                    b'/' => {
                        self.slash = true;
                        self.slash_pos = pos;
                    }
                    b'"' => {
                        self.mode = ScanMode::Str;
                        self.esc = false;
                    }
                    b'\'' => {
                        self.mode = ScanMode::Char;
                        self.esc = false;
                    }
                    _ => {}
                }
            }
            ScanMode::Str | ScanMode::Char => {
                let close = if self.mode == ScanMode::Str {
                    b'"'
                } else {
                    b'\''
                };
                if self.esc {
                    self.esc = false;
                } else if c == b'\\' {
                    self.esc = true;
                } else if c == close {
                    self.mode = ScanMode::Normal;
                }
            }
            ScanMode::Block => {
                if self.star {
                    self.star = false;
                    if c == b'/' {
                        self.mode = ScanMode::Normal;
                        self.out.push(' ');
                        self.copied = pos + 1;
                        return;
                    }
                }
                if c == b'*' {
                    self.star = true;
                }
            }
            ScanMode::Line => {}
        }
    }

    /// Scan the line content `bytes[from..to]` (no newline inside).
    fn scan(&mut self, bytes: &[u8], from: usize, to: usize) {
        let mut p = from;
        while p < to {
            let c = bytes[p];
            match self.mode {
                // Outside a literal or comment with no `/` pending,
                // only `/`, `"` and `'` change state; skip to the next
                // one. Skipped bytes stay in the open span.
                ScanMode::Normal if !self.slash && !matches!(c, b'/' | b'"' | b'\'') => {
                    let rest = &bytes[p + 1..to];
                    p += 1 + rest
                        .iter()
                        .position(|&b| matches!(b, b'/' | b'"' | b'\''))
                        .unwrap_or(rest.len());
                }
                // A `//` comment drops everything to the logical line
                // end.
                ScanMode::Line => break,
                _ => {
                    self.step(c, p);
                    p += 1;
                }
            }
        }
    }

    /// Feed backslashes that survived the splice pops back in as
    /// content. All-identical bytes, so no source position is needed;
    /// retained modes emit them, comment modes drop them.
    fn feed_backslashes(&mut self, count: usize) {
        for _ in 0..count {
            self.step(b'\\', 0);
            if matches!(self.mode, ScanMode::Normal | ScanMode::Str | ScanMode::Char) {
                self.out.push('\\');
            }
        }
    }
}

/// Fused phase-2 / phase-3 pass; see [`Fuse`]. Byte-identical to
/// `strip_c_comments(&unfold_line_continuations(source))`, which the
/// differential tests verify over the header corpus and fuzzed input.
pub(super) fn unfold_and_strip(source: &str) -> String {
    let bytes = source.as_bytes();
    let n = bytes.len();
    let mut f = Fuse {
        src: source,
        out: String::with_capacity(n),
        mode: ScanMode::Normal,
        esc: false,
        slash: false,
        slash_pos: 0,
        star: false,
        copied: 0,
    };
    // Blank lines owed after the current logical line, one per spliced
    // or comment-joined physical line, preserving the line count.
    let mut padding = 0usize;
    // Trailing backslashes deferred at a line end. Phase 2 pops one per
    // join; the survivors become content once a non-empty line follows,
    // so they are neither scanned nor emitted until then.
    let mut pend = 0usize;
    let mut open = false;
    let mut i = 0usize;
    while i < n {
        open = true;
        let (content_end, next_start, has_nl, has_cr) = match source[i..].find('\n') {
            Some(k) => {
                let nl = i + k;
                let cr = nl > i && bytes[nl - 1] == b'\r';
                (if cr { nl - 1 } else { nl }, nl + 1, true, cr)
            }
            None => (n, n, false, false),
        };
        let mut run_start = content_end;
        while run_start > i && bytes[run_start - 1] == b'\\' {
            run_start -= 1;
        }
        if run_start > i {
            // The line has content before its backslash run, so
            // deferred survivors can no longer be popped: they are
            // ordinary bytes preceding it. A line of backslashes only
            // instead merges into the deferred run.
            f.feed_backslashes(pend);
            pend = 0;
        }
        pend += content_end - run_start;
        f.scan(bytes, i, run_start);
        if pend > 0 {
            // Splice: drop one trailing backslash with the newline.
            match f.mode {
                ScanMode::Normal => {
                    let end = if f.slash {
                        f.slash_pos.max(f.copied)
                    } else {
                        run_start
                    };
                    f.flush_to(end);
                }
                ScanMode::Str | ScanMode::Char => f.flush_to(run_start),
                ScanMode::Block | ScanMode::Line => {}
            }
            pend -= 1;
            padding += 1;
            f.copied = next_start;
            i = next_start;
            continue;
        }
        if f.mode == ScanMode::Block {
            // An open block comment joins the next line; the newline
            // moves to the padding after the logical line.
            padding += 1;
            i = next_start;
            continue;
        }
        // The logical line ends here.
        match f.mode {
            ScanMode::Line => {
                f.out.push(' ');
                f.copied = content_end;
            }
            ScanMode::Normal if f.slash && f.slash_pos < f.copied => f.out.push('/'),
            _ => {}
        }
        if padding > 0 || has_cr || !has_nl {
            f.flush_to(content_end);
            f.out.push('\n');
            for _ in 0..padding {
                f.out.push('\n');
            }
            f.copied = next_start;
            padding = 0;
        }
        // Otherwise the span runs on through the newline byte.
        f.mode = ScanMode::Normal;
        f.esc = false;
        f.slash = false;
        f.star = false;
        open = false;
        i = next_start;
    }
    if open {
        // Input ended while joining. The pop that found no next line
        // already counted its padding; emit the terminator, the owed
        // blanks and, for an unterminated block comment, the space
        // phase 3 closes every comment with.
        match f.mode {
            ScanMode::Block => {
                for _ in 0..=padding {
                    f.out.push('\n');
                }
                f.out.push(' ');
            }
            ScanMode::Line => {
                f.out.push(' ');
                for _ in 0..=padding {
                    f.out.push('\n');
                }
            }
            ScanMode::Normal | ScanMode::Str | ScanMode::Char => {
                f.feed_backslashes(pend);
                if f.mode == ScanMode::Normal && f.slash && f.slash_pos < f.copied {
                    f.out.push('/');
                }
                for _ in 0..=padding {
                    f.out.push('\n');
                }
            }
        }
    } else {
        f.flush_to(n);
    }
    f.out
}

/// Incremental scan state for `unfold_line_continuations`. It advances
/// byte by byte with no 2-byte lookahead, so the state carries cleanly
/// across a physical-line join and the assembled buffer is scanned only
/// once overall. `esc` is a pending backslash escape inside a literal;
/// `slash` a half-seen top-level `/`; `star` a half-seen `*` inside a
/// block comment. `scanned` is the buffer length already consumed.
#[cfg(test)]
#[derive(Clone, Copy, Default)]
struct LineScan {
    mode: ScanMode,
    esc: bool,
    slash: bool,
    star: bool,
    scanned: usize,
}

#[cfg(test)]
impl LineScan {
    /// Consume `joined[self.scanned..]`, advance the state, and report
    /// whether the assembled line now ends inside an open block
    /// comment. String and char literals and `//` line comments are
    /// tracked so a `/*` inside one of them is not a comment opener.
    fn ends_in_open_block_comment(&mut self, joined: &[u8]) -> bool {
        let mut i = self.scanned;
        while i < joined.len() {
            #[cfg(test)]
            scan_step();
            let c = joined[i];
            match self.mode {
                // Outside a literal or comment with no `/` pending, only
                // `/`, `"` and `'` change state; skip to the next one.
                ScanMode::Normal if !self.slash && !matches!(c, b'/' | b'"' | b'\'') => {
                    let rest = &joined[i + 1..];
                    i += 1 + rest
                        .iter()
                        .position(|&b| matches!(b, b'/' | b'"' | b'\''))
                        .unwrap_or(rest.len());
                    continue;
                }
                ScanMode::Normal => {
                    if self.slash {
                        self.slash = false;
                        match c {
                            b'*' => {
                                self.mode = ScanMode::Block;
                                i += 1;
                                continue;
                            }
                            b'/' => {
                                self.mode = ScanMode::Line;
                                i += 1;
                                continue;
                            }
                            _ => {}
                        }
                    }
                    match c {
                        b'/' => self.slash = true,
                        b'"' => self.mode = ScanMode::Str,
                        b'\'' => self.mode = ScanMode::Char,
                        _ => {}
                    }
                }
                ScanMode::Str | ScanMode::Char => {
                    let close = if self.mode == ScanMode::Str {
                        b'"'
                    } else {
                        b'\''
                    };
                    if self.esc {
                        self.esc = false;
                    } else if c == b'\\' {
                        self.esc = true;
                    } else if c == close {
                        self.mode = ScanMode::Normal;
                    }
                }
                ScanMode::Block => {
                    if self.star {
                        self.star = false;
                        if c == b'/' {
                            self.mode = ScanMode::Normal;
                            i += 1;
                            continue;
                        }
                    }
                    if c == b'*' {
                        self.star = true;
                    }
                }
                // A `//` comment runs to the end of the assembled line,
                // so nothing after it can leave a block comment open.
                ScanMode::Line => break,
            }
            i += 1;
        }
        self.scanned = i;
        self.mode == ScanMode::Block
    }
}

/// Phase-2 line-continuation collapse: every line ending in `\\`
/// joins with the next, preserving total line count by emitting
/// blank padding lines. The c99 spec runs this before all other
/// preprocessing passes.
///
/// A physical line whose logical line ends inside an open `/* */`
/// block comment also joins with the next line even without a trailing
/// `\\`: a newline inside a block comment is comment white space, not a
/// directive terminator (C99 5.1.1.2), so a multi-line comment embedded
/// in a `\\`-continued macro definition must not split the definition.
///
/// Production uses the fused [`unfold_and_strip`]; this stays as the
/// phase-2 half of its differential reference.
#[cfg(test)]
pub(super) fn unfold_line_continuations(source: &str) -> String {
    let mut out = String::with_capacity(source.len());
    let mut iter = source.lines();
    let mut joined = String::new();
    while let Some(line) = iter.next() {
        // A line that neither continues nor leaves a block comment open
        // is the overwhelming majority; emit it straight from `source`
        // instead of staging it in `joined`. The scan state is carried
        // into the join loop so the line is never scanned twice.
        let mut scan = LineScan::default();
        if !line.ends_with('\\') && !scan.ends_in_open_block_comment(line.as_bytes()) {
            out.push_str(line);
            out.push('\n');
            continue;
        }
        joined.clear();
        joined.push_str(line);
        let mut padding = 0;
        loop {
            if joined.ends_with('\\') {
                joined.pop();
            } else if !scan.ends_in_open_block_comment(joined.as_bytes()) {
                break;
            }
            padding += 1;
            match iter.next() {
                Some(next) => joined.push_str(next),
                None => break,
            }
        }
        out.push_str(&joined);
        out.push('\n');
        for _ in 0..padding {
            out.push('\n');
        }
    }
    out
}

// Test-only scanner-work counter and full-rescan reference, retained to
// prove the incremental scanner is byte-identical to the pre-incremental
// code and to contrast their scan work. The counter is thread-local so
// tests running in parallel do not interfere.
#[cfg(test)]
std::thread_local! {
    static SCAN_STEPS: core::cell::Cell<usize> = const { core::cell::Cell::new(0) };
}

#[cfg(test)]
fn scan_step() {
    SCAN_STEPS.with(|s| s.set(s.get() + 1));
}

/// Read and reset the scanner-work counter for the current thread.
#[cfg(test)]
pub(super) fn scan_steps_taken() -> usize {
    SCAN_STEPS.with(|s| s.replace(0))
}

/// Fresh-state detector exposing the incremental scanner as a
/// single-string predicate for the unit test.
#[cfg(test)]
pub(super) fn ends_in_open_block_comment_once(s: &str) -> bool {
    let mut scan = LineScan::default();
    scan.ends_in_open_block_comment(s.as_bytes())
}

/// Full-rescan reference detector: the pre-incremental implementation
/// that re-reads the whole assembled buffer on each call.
#[cfg(test)]
fn ends_in_open_block_comment_ref(s: &str) -> bool {
    let b = s.as_bytes();
    let mut i = 0;
    let mut in_str = false;
    let mut in_char = false;
    let mut in_block = false;
    while i < b.len() {
        scan_step();
        let c = b[i];
        if in_block {
            if c == b'*' && b.get(i + 1) == Some(&b'/') {
                in_block = false;
                i += 2;
                continue;
            }
            i += 1;
            continue;
        }
        if in_str {
            if c == b'\\' {
                i += 2;
                continue;
            }
            if c == b'"' {
                in_str = false;
            }
            i += 1;
            continue;
        }
        if in_char {
            if c == b'\\' {
                i += 2;
                continue;
            }
            if c == b'\'' {
                in_char = false;
            }
            i += 1;
            continue;
        }
        if c == b'/' && b.get(i + 1) == Some(&b'*') {
            in_block = true;
            i += 2;
            continue;
        }
        if c == b'/' && b.get(i + 1) == Some(&b'/') {
            return false;
        }
        if c == b'"' {
            in_str = true;
        } else if c == b'\'' {
            in_char = true;
        }
        i += 1;
    }
    in_block
}

/// Byte-at-a-time reference for `strip_c_comments`: the same rules
/// written without span flushing, so the span-copying implementation
/// can be proved equivalent over a corpus.
#[cfg(test)]
pub(super) fn strip_c_comments_ref(source: &str) -> String {
    let mut out = String::with_capacity(source.len());
    let bytes = source.as_bytes();
    let mut i = 0;
    while i < bytes.len() {
        let c = bytes[i];
        if c == b'/' && bytes.get(i + 1) == Some(&b'*') {
            i += 2;
            while i < bytes.len() {
                if bytes[i] == b'*' && bytes.get(i + 1) == Some(&b'/') {
                    i += 2;
                    break;
                }
                if bytes[i] == b'\n' {
                    out.push('\n');
                }
                i += 1;
            }
            out.push(' ');
            continue;
        }
        if c == b'/' && bytes.get(i + 1) == Some(&b'/') {
            i += 2;
            while i < bytes.len() && bytes[i] != b'\n' {
                i += 1;
            }
            out.push(' ');
            continue;
        }
        if c == b'"' || c == b'\'' {
            let lit_start = i;
            i += 1;
            while i < bytes.len() && bytes[i] != c && bytes[i] != b'\n' {
                if bytes[i] == b'\\' && i + 1 < bytes.len() && bytes[i + 1] != b'\n' {
                    i += 2;
                } else {
                    i += 1;
                }
            }
            if i < bytes.len() && bytes[i] == c {
                i += 1;
            }
            out.push_str(&source[lit_start..i]);
            continue;
        }
        let ch = source[i..].chars().next().expect("byte index on a char");
        out.push(ch);
        i += ch.len_utf8();
    }
    out
}

/// Full-rescan reference for `unfold_line_continuations`.
#[cfg(test)]
pub(super) fn unfold_ref(source: &str) -> String {
    let mut out = String::with_capacity(source.len());
    let mut iter = source.lines();
    while let Some(line) = iter.next() {
        let mut joined = String::from(line);
        let mut padding = 0;
        loop {
            if joined.ends_with('\\') {
                joined.pop();
            } else if !ends_in_open_block_comment_ref(&joined) {
                break;
            }
            padding += 1;
            match iter.next() {
                Some(next) => joined.push_str(next),
                None => break,
            }
        }
        out.push_str(&joined);
        out.push('\n');
        for _ in 0..padding {
            out.push('\n');
        }
    }
    out
}

/// Name an `#if` operand tests for absence, i.e. `!defined X` or
/// `!defined(X)` with arbitrary white space. `#ifndef X` is the other
/// spelling of the same test and is matched by its own directive
/// variant. `None` for every other operand.
pub(super) fn if_operand_undefined_name(expr: &str) -> Option<&str> {
    let rest = expr.trim().strip_prefix('!')?.trim_start();
    let rest = rest.strip_prefix("defined")?;
    let name = match rest.trim_start().strip_prefix('(') {
        Some(inner) => inner.trim().strip_suffix(')')?.trim(),
        // `!definedX` is one identifier, not the operator.
        None if rest.starts_with(|c: char| c.is_whitespace()) => rest.trim(),
        None => return None,
    };
    is_ident(name).then_some(name)
}

/// Longest prefix [`literal_prefix_len`] accepts.
pub(super) const MAX_LITERAL_PREFIX: usize = 2;

/// Identifier check: ASCII letter or `_` to start, alnum or `_`
/// after. Used to reject `#pragma dylib(123foo, ...)` and similar
/// up-front so the codegen never has to worry about quirks in the
/// dylib `name`.
/// If `bytes[at..]` begins with a string- or char-literal encoding
/// prefix (`L`, `u`, `U`, or `u8`) immediately followed by a `"` or
/// `'` quote, return the prefix length (1 or 2). The quote itself is
/// not included. C99 6.4.5 (string literals) and 6.4.4.4 (character
/// constants) make the prefix part of the literal token; the
/// preprocessor must not treat it as an identifier.
pub(super) fn literal_prefix_len(bytes: &[u8], at: usize) -> Option<usize> {
    let c = *bytes.get(at)?;
    let quote = |b: u8| b == b'"' || b == b'\'';
    match c {
        b'L' | b'U' if bytes.get(at + 1).is_some_and(|&n| quote(n)) => Some(1),
        b'u' => {
            if bytes.get(at + 1) == Some(&b'8') && bytes.get(at + 2).is_some_and(|&n| n == b'"') {
                Some(2)
            } else if bytes.get(at + 1).is_some_and(|&n| quote(n)) {
                Some(1)
            } else {
                None
            }
        }
        _ => None,
    }
}

/// Index just past a string or character literal starting at the quote
/// at `at`, honoring `\` escapes. A literal never spans a newline (C99
/// 6.4.4.4, 6.4.5); phase 2 has already spliced away every `\`-newline,
/// so an unterminated literal ends at the end of its line and its text
/// passes through verbatim. The single literal skipper: every phase-2 /
/// -3 / expansion / pragma scanner that steps over a literal calls it,
/// so they cannot disagree about escapes or the end bound.
pub(super) fn skip_literal(bytes: &[u8], at: usize) -> usize {
    let quote = bytes[at];
    let mut i = at + 1;
    while i < bytes.len() && bytes[i] != b'\n' {
        if bytes[i] == b'\\' && bytes.get(i + 1).is_some_and(|&b| b != b'\n') {
            i += 2;
            continue;
        }
        let closed = bytes[i] == quote;
        i += 1;
        if closed {
            break;
        }
    }
    i
}

pub(super) fn is_ident(s: &str) -> bool {
    let mut bytes = s.bytes();
    let Some(first) = bytes.next() else {
        return false;
    };
    if !(first.is_ascii_alphabetic() || first == b'_') {
        return false;
    }
    bytes.all(|b| b.is_ascii_alphanumeric() || b == b'_')
}

pub(super) fn is_ident_byte(b: u8) -> bool {
    b.is_ascii_alphanumeric() || b == b'_'
}

/// Length of the C99 6.4.8 preprocessing number starting at `at` (a
/// digit, or `.` followed by a digit), else 0. A pp-number is one
/// token, so the substitution scanners must treat text like `2op`
/// opaquely: its identifier-shaped tail is not a candidate macro or
/// parameter name.
pub(super) fn pp_number_len(bytes: &[u8], at: usize) -> usize {
    let n = bytes.len();
    let starts = bytes[at].is_ascii_digit()
        || (bytes[at] == b'.' && at + 1 < n && bytes[at + 1].is_ascii_digit());
    if !starts {
        return 0;
    }
    let mut i = at + 1;
    while i < n {
        let b = bytes[i];
        if matches!(b, b'e' | b'E' | b'p' | b'P')
            && i + 1 < n
            && matches!(bytes[i + 1], b'+' | b'-')
        {
            i += 2;
        } else if is_ident_byte(b) || b == b'.' {
            i += 1;
        } else {
            break;
        }
    }
    i - at
}

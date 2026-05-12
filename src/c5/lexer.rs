use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;

use super::error::C5Error;
use super::symbol::Symbol;
use super::token::{Tok, Token, Ty};

/// Default struct-alignment cap when no `#pragma pack(N)` is
/// active. Mirrors the existing aggregate-layout cap at 8 bytes
/// (c5's IR slot width); explicit pack pragmas can lower it.
const DEFAULT_PACK: usize = 8;

/// Clamp a user-supplied pack value to `[1, DEFAULT_PACK]`. C99
/// permits 1, 2, 4, 8, 16; we don't expose 16 because c5's
/// struct-alignment cap is 8 and a stricter request would just
/// inflate the alignment with no payoff. `0` is treated as
/// "default" (matching `#pragma pack()` with no arg).
fn clamp_pack(n: usize) -> usize {
    if n == 0 || n > DEFAULT_PACK {
        DEFAULT_PACK
    } else {
        n
    }
}

/// One parsed `#pragma pack(...)` directive. The lexer scans the
/// directive inline and folds it into [`Lexer::pack_stack`] via
/// [`Lexer::apply_pack_directive`].
#[derive(Debug, Clone, Copy)]
enum PackDirective {
    /// `#pragma pack(N)` -- replace top of stack with N.
    Set(usize),
    /// `#pragma pack()` -- replace top with DEFAULT_PACK.
    Reset,
    /// `#pragma pack(push, N)` -- push N onto the stack.
    Push(usize),
    /// `#pragma pack(pop)` -- pop one frame (no-op if at bottom).
    Pop,
}

/// One parsed GNU-style line marker (`# N "file" [flags]`) or
/// C99 `#line N "file"` directive. The `#` prefix is already
/// stripped by the lexer's `#`-line handler, so we see the
/// body bytes only.
#[derive(Debug)]
struct LineMarker {
    /// 1-based line number to attribute to the *next* source
    /// line. The lexer subtracts 1 (so the trailing `\n` of the
    /// marker bumps the counter to exactly this value).
    line: usize,
    /// Filename, if the marker carries one. `None` for bare
    /// `#line N` (C99 6.10.4 says: keep the existing file).
    file: Option<alloc::string::String>,
}

/// Parse a `#`-prefix-stripped line as a GNU line marker
/// (` N "file" [flags]` -- one or more spaces between fields)
/// or a C99 `#line` directive (`line N "file"`). Returns the
/// marker on a successful match, `None` for any other shape.
///
/// Recognises:
///   * `#line N`               -> `LineMarker { line: N, file: None }`
///   * `#line N "file"`        -> `LineMarker { line: N, file: Some("file") }`
///   * `# N "file"`            -> same (GNU shape, no `line` keyword)
///   * `# N "file" 1 2 3 4`    -> same; trailing flag digits are ignored
///
/// Filenames go through C99-style escape decoding (`\\` -> `\`,
/// `\"` -> `"`, `\n` -> LF, `\t` -> tab) so a path with a
/// space or quote round-trips. Anything malformed (missing
/// digits, unterminated quote) returns `None` and falls
/// through to the historical `#`-line skip.
fn parse_line_marker(body: &[u8]) -> Option<LineMarker> {
    let mut i = 0;
    while i < body.len() && (body[i] == b' ' || body[i] == b'\t') {
        i += 1;
    }
    // Optional `line` keyword (C99 #line). GNU markers go
    // straight to the digit.
    if body[i..].starts_with(b"line") {
        i += 4;
        while i < body.len() && (body[i] == b' ' || body[i] == b'\t') {
            i += 1;
        }
    }
    // Line number.
    let digit_start = i;
    while i < body.len() && body[i].is_ascii_digit() {
        i += 1;
    }
    if i == digit_start {
        return None;
    }
    let line_str = core::str::from_utf8(&body[digit_start..i]).ok()?;
    let line: usize = line_str.parse().ok()?;
    while i < body.len() && (body[i] == b' ' || body[i] == b'\t') {
        i += 1;
    }
    // Optional `"file"` part.
    let file = if i < body.len() && body[i] == b'"' {
        i += 1;
        let mut decoded = alloc::string::String::new();
        while i < body.len() && body[i] != b'"' {
            if body[i] == b'\\' && i + 1 < body.len() {
                let esc = body[i + 1];
                let ch = match esc {
                    b'\\' => '\\',
                    b'"' => '"',
                    b'n' => '\n',
                    b't' => '\t',
                    b'r' => '\r',
                    other => other as char,
                };
                decoded.push(ch);
                i += 2;
            } else {
                decoded.push(body[i] as char);
                i += 1;
            }
        }
        // Unterminated string -- bail rather than partially update.
        if i >= body.len() {
            return None;
        }
        // Closing `"` consumed implicitly; trailing GNU flag digits
        // (`1 2 3 4`) are ignored -- they tag enter/leave/system but
        // the (file, line) state is what we care about.
        Some(decoded)
    } else {
        None
    };
    Some(LineMarker { line, file })
}

/// Parse a single `#`-prefix-stripped line as `pragma pack(...)`.
/// Returns the directive on a successful match, `None` for any
/// other shape (including malformed-pack and non-pack pragmas)
/// so the caller can fall back to "skip the line silently".
///
/// Accepts the four MSVC-compatible shapes:
///   * `pragma pack(N)`            -> [`PackDirective::Set`]
///   * `pragma pack()`             -> [`PackDirective::Reset`]
///   * `pragma pack(push, N)`      -> [`PackDirective::Push`]
///   * `pragma pack(pop)`          -> [`PackDirective::Pop`]
///
/// The arg whitespace is liberal -- any combination of spaces /
/// tabs is accepted between tokens to match how cpp / msvc
/// tolerate user formatting.
fn parse_pragma_pack_line(body: &[u8]) -> Option<PackDirective> {
    let s = core::str::from_utf8(body).ok()?.trim();
    let rest = s.strip_prefix("pragma")?.trim_start();
    let rest = rest.strip_prefix("pack")?.trim_start();
    let after_open = rest.strip_prefix('(')?;
    let close = after_open.find(')')?;
    let inner = after_open[..close].trim();
    if inner.is_empty() {
        return Some(PackDirective::Reset);
    }
    if inner == "pop" {
        return Some(PackDirective::Pop);
    }
    if let Some(rest) = inner.strip_prefix("push") {
        let rest = rest.trim_start();
        let rest = rest.strip_prefix(',')?.trim_start();
        return rest.parse::<usize>().ok().map(PackDirective::Push);
    }
    inner.parse::<usize>().ok().map(PackDirective::Set)
}

/// Snapshot of the lexer's positional state. See
/// [`Lexer::snapshot`] / [`Lexer::restore`].
#[derive(Clone, Copy)]
pub(crate) struct LexerSnapshot {
    pos: usize,
    line: usize,
    tk: Tok,
    ival: i64,
    curr_id_idx: usize,
}

pub(crate) struct Lexer {
    src: Vec<u8>,
    pos: usize,
    pub line: usize,
    /// Name of the file `self.line` is counting within. Updated
    /// when the lexer crosses a GNU-style line marker (`# N "file"
    /// [flags]`) or a C99 `#line N "file"` directive emitted by
    /// the preprocessor on `#include` entry/exit. Starts as
    /// `"<source>"` for the top-level translation unit and gets
    /// rewritten by the first marker the preprocessor emits.
    pub file: String,

    // Output of the most recent next() call.
    pub tk: Tok,
    pub ival: i64,
    pub curr_id_idx: usize,

    /// `#pragma pack(N)` stack. Top of stack is the active pack value
    /// at the current source position; struct layout (`aggregate.rs`)
    /// reads it via [`Self::current_pack`] and clamps each field's
    /// natural alignment by it.
    ///
    /// State machine:
    ///   * `pragma pack(N)`         -- replace top of stack with N.
    ///   * `pragma pack()`          -- replace top with the default
    ///                                 (8 -- c5's existing layout cap).
    ///   * `pragma pack(push, N)`   -- push N.
    ///   * `pragma pack(pop)`       -- pop one frame; stack always
    ///                                 keeps at least the bottom default.
    ///
    /// Values are clamped to `[1, 8]` because c5's IR slots at 8
    /// and there's no use for stricter alignment than that. Updates
    /// happen inline as the lexer scans `#pragma pack(...)` lines
    /// (the preprocessor passes them through verbatim instead of
    /// stripping like other pragmas, since pack is position-
    /// dependent within the source and can't be batched up the way
    /// `#pragma binding(...)` is).
    pack_stack: Vec<usize>,
}

/// Side index for `Vec<Symbol>` so identifier lookup stops being O(N).
///
/// The original c4-style code did a linear scan over every symbol on
/// every identifier the lexer hit; with a few thousand globals that
/// turned the frontend into an O(N^2) hot spot (~88% of compile time
/// on the stress fixture). This replaces the scan with a small chained
/// hash table that lives alongside `symbols` instead of replacing it,
/// so the rest of the compiler keeps using `&self.symbols[idx]` the
/// way it always has.
///
/// Layout:
///    * `buckets[hash & mask]` -- head of the chain, `u32::MAX` when empty.
///    * `next[i]` -- previous symbol that landed in the same bucket (or `u32::MAX` to terminate).
///    * `hashes[i]` -- copy of `symbols[i].hash`. Keeps the chain walk in a tight 12-bytes-per-entry
///      stride so the big `Symbol` struct only gets touched on a hash hit.
///
/// Newer entries always land at the head of their bucket, so a chain
/// walk visits the most-recent declaration first -- same behaviour the
/// old `.rev()` scan had, which is what shadowing relies on.
pub(crate) struct SymbolIndex {
    buckets: Vec<u32>,
    next: Vec<u32>,
    hashes: Vec<i64>,
    mask: u32,
}

impl SymbolIndex {
    pub fn new() -> Self {
        // 64 buckets is enough for the keyword seed plus a typical
        // small program; we double from there as needed.
        let cap = 64usize;
        Self {
            buckets: vec![u32::MAX; cap],
            next: Vec::new(),
            hashes: Vec::new(),
            mask: (cap - 1) as u32,
        }
    }

    /// Find the most recent live symbol whose `(hash, name)` matches.
    /// `token != 0` filters out any defensively-zeroed entries the way
    /// the old linear scan did; in practice no caller zeroes `token`
    /// today, but the check is cheap and keeps behaviour identical.
    pub fn lookup(&self, symbols: &[Symbol], hash: i64, name: &[u8]) -> Option<usize> {
        let mut cur = self.buckets[(hash as u32 & self.mask) as usize];
        while cur != u32::MAX {
            let i = cur as usize;
            if self.hashes[i] == hash {
                let s = &symbols[i];
                if s.token != 0 && s.name.as_bytes() == name {
                    return Some(i);
                }
            }
            cur = self.next[i];
        }
        None
    }

    /// Record that `symbols.len() - 1` was just pushed with the given
    /// hash. Must be called immediately after every `symbols.push(...)`
    /// so the index stays in sync.
    pub fn record(&mut self, hash: i64) {
        let idx = self.hashes.len() as u32;
        // Grow when load factor crosses ~0.75. Doubling keeps the
        // amortised cost flat and the buckets array tiny.
        if (idx as usize + 1) * 4 > self.buckets.len() * 3 {
            self.grow();
        }
        let bucket = (hash as u32 & self.mask) as usize;
        let head = self.buckets[bucket];
        self.next.push(head);
        self.hashes.push(hash);
        self.buckets[bucket] = idx;
    }

    fn grow(&mut self) {
        let new_cap = self.buckets.len() * 2;
        let new_mask = (new_cap - 1) as u32;
        let mut new_buckets = vec![u32::MAX; new_cap];
        // Re-thread oldest-to-newest so the newest entry ends up at
        // the head of its new bucket -- preserves the LIFO property
        // shadowing relies on.
        for i in 0..self.hashes.len() {
            let bucket = (self.hashes[i] as u32 & new_mask) as usize;
            self.next[i] = new_buckets[bucket];
            new_buckets[bucket] = i as u32;
        }
        self.buckets = new_buckets;
        self.mask = new_mask;
    }
}

impl Default for SymbolIndex {
    fn default() -> Self {
        Self::new()
    }
}

impl Lexer {
    pub fn new(source: String) -> Self {
        Self {
            src: source.into_bytes(),
            pos: 0,
            line: 1,
            file: String::from("<source>"),
            tk: Tok::EOF,
            ival: 0,
            curr_id_idx: 0,
            // Bottom of the stack is the default pack -- c5 already
            // caps struct alignment at 8, and that's the implicit
            // upper bound here too. Real `#pragma pack(N)` updates
            // happen via `apply_pack_directive`.
            pack_stack: vec![DEFAULT_PACK],
        }
    }

    /// Active `#pragma pack(N)` value at the current source
    /// position. `aggregate.rs` clamps each struct field's natural
    /// alignment by this when laying out a struct definition. The
    /// default 8 matches c5's pre-existing struct-layout behaviour
    /// (no packing); any explicit `#pragma pack(N)` lowers it.
    pub fn current_pack(&self) -> usize {
        *self.pack_stack.last().unwrap_or(&DEFAULT_PACK)
    }

    /// Apply one parsed `#pragma pack(...)` directive to the stack.
    /// Called from the lexer when it encounters the directive
    /// inline (the preprocessor passes pack pragmas through as
    /// literal `#pragma pack(...)` lines rather than stripping them
    /// like other pragmas, because pack is source-position-
    /// dependent in a way the per-translation-unit `dylibs` /
    /// `bindings` accumulator can't capture).
    fn apply_pack_directive(&mut self, dir: PackDirective) {
        match dir {
            PackDirective::Set(n) => {
                let n = clamp_pack(n);
                if let Some(top) = self.pack_stack.last_mut() {
                    *top = n;
                } else {
                    self.pack_stack.push(n);
                }
            }
            PackDirective::Reset => {
                if let Some(top) = self.pack_stack.last_mut() {
                    *top = DEFAULT_PACK;
                } else {
                    self.pack_stack.push(DEFAULT_PACK);
                }
            }
            PackDirective::Push(n) => {
                self.pack_stack.push(clamp_pack(n));
            }
            PackDirective::Pop => {
                // Always keep one frame so `current_pack()` always
                // has an answer. Popping past the bottom is a
                // user error in real cpp; we silently ignore here.
                if self.pack_stack.len() > 1 {
                    self.pack_stack.pop();
                }
            }
        }
    }

    /// Return true if the next non-whitespace byte (after the current position) equals `b`.
    /// Used by the compiler to detect `name:` label syntax without consuming the colon.
    pub fn peek_after_whitespace(&self, b: u8) -> bool {
        let mut p = self.pos;
        while p < self.src.len() && self.src[p].is_ascii_whitespace() {
            p += 1;
        }
        p < self.src.len() && self.src[p] == b
    }

    /// True if the next non-whitespace byte is the start of an
    /// identifier (alpha or `_`). Used by the parse_declarator
    /// nested-paren disambiguator to recognise the redundant-
    /// paren shape `(name[N])` -- the inner declarator is a
    /// regular identifier rather than `*name` or `(*...)`.
    pub fn peek_after_whitespace_starts_ident(&self) -> bool {
        let mut p = self.pos;
        while p < self.src.len() && self.src[p].is_ascii_whitespace() {
            p += 1;
        }
        p < self.src.len() && (self.src[p].is_ascii_alphabetic() || self.src[p] == b'_')
    }

    /// Lightweight snapshot of the lexer's positional state so a
    /// caller can speculatively advance and then rewind. Captures
    /// just the fields the lexer mutates inside `next()`; identifier
    /// table and pack stack don't change on read, so they're omitted.
    pub fn snapshot(&self) -> LexerSnapshot {
        LexerSnapshot {
            pos: self.pos,
            line: self.line,
            tk: self.tk,
            ival: self.ival,
            curr_id_idx: self.curr_id_idx,
        }
    }

    /// Restore a previously taken [`Self::snapshot`]. The lexer
    /// returns to the exact state it had at the snapshot point.
    pub fn restore(&mut self, s: LexerSnapshot) {
        self.pos = s.pos;
        self.line = s.line;
        self.tk = s.tk;
        self.ival = s.ival;
        self.curr_id_idx = s.curr_id_idx;
    }

    /// True if the next non-whitespace byte is the start of a
    /// numeric literal -- digit or a `.` immediately followed by
    /// a digit (the `.5` form). Used by the constant-initializer
    /// parser to recognise `-LITERAL` (where the next token will
    /// be Num or FloatNum) without consuming the `-` until it
    /// knows what shape follows. Saves a snapshot/restore dance.
    pub fn peek_after_whitespace_starts_digit(&self) -> bool {
        let mut p = self.pos;
        while p < self.src.len() && self.src[p].is_ascii_whitespace() {
            p += 1;
        }
        if p >= self.src.len() {
            return false;
        }
        if self.src[p].is_ascii_digit() {
            return true;
        }
        self.src[p] == b'.' && p + 1 < self.src.len() && self.src[p + 1].is_ascii_digit()
    }

    /// Count the number of comma-separated top-level groups
    /// (`{...}`) that follow the current lex position before the
    /// matching `}` at depth 0. The current token must already be
    /// the array initializer's outer `{`. Used by the struct-
    /// array initializer path to pre-allocate storage for every
    /// element before any inner string-literal lex landing
    /// re-orders the data segment. Returns 0 if the source ends
    /// before the matching `}` (the parser then surfaces a normal
    /// "}" expected error).
    ///
    /// String literals are skipped without expansion; comments
    /// (`/*...*/` and `//`) are also stepped over so a comment
    /// containing `{` doesn't bump the count.
    pub fn count_top_level_groups_in_array(&self) -> usize {
        let bytes = &self.src;
        // We're positioned just past the outer `{`. Walk forward,
        // tracking brace depth. Top-level (depth 1) `{` opens a
        // new group; the matching `}` at depth 1 closes it. The
        // depth-0 `}` ends the scan.
        let mut p = self.pos;
        let mut depth: i32 = 1;
        let mut count: usize = 0;
        let mut in_group = false;
        while p < bytes.len() && depth > 0 {
            let c = bytes[p];
            if c == b'/' && p + 1 < bytes.len() && bytes[p + 1] == b'*' {
                p += 2;
                while p + 1 < bytes.len() && !(bytes[p] == b'*' && bytes[p + 1] == b'/') {
                    p += 1;
                }
                p = (p + 2).min(bytes.len());
                continue;
            }
            if c == b'/' && p + 1 < bytes.len() && bytes[p + 1] == b'/' {
                while p < bytes.len() && bytes[p] != b'\n' {
                    p += 1;
                }
                continue;
            }
            if c == b'"' || c == b'\'' {
                let q = c;
                p += 1;
                while p < bytes.len() && bytes[p] != q {
                    if bytes[p] == b'\\' && p + 1 < bytes.len() {
                        p += 2;
                    } else {
                        p += 1;
                    }
                }
                if p < bytes.len() {
                    p += 1;
                }
                continue;
            }
            if c == b'{' {
                if depth == 1 && !in_group {
                    in_group = true;
                    count += 1;
                }
                depth += 1;
                p += 1;
                continue;
            }
            if c == b'}' {
                depth -= 1;
                if depth == 1 {
                    in_group = false;
                }
                p += 1;
                continue;
            }
            p += 1;
        }
        count
    }

    /// Advance to the next token. Identifiers are interned into `symbols`
    /// (with `index` kept in sync); string literals are appended to `data`
    /// and `ival` is set to their start address.
    pub fn next(
        &mut self,
        symbols: &mut Vec<Symbol>,
        index: &mut SymbolIndex,
        data: &mut Vec<u8>,
    ) -> Result<(), C5Error> {
        loop {
            if self.pos >= self.src.len() {
                self.tk = Tok::EOF;
                return Ok(());
            }

            let c = self.src[self.pos] as char;
            self.pos += 1;

            if c == '\n' {
                self.line += 1;
            } else if c == '#' {
                // Three `#`-line shapes survive into the lexer:
                //   * GNU line markers `# N "file" [flags]` --
                //     emitted by the preprocessor at every
                //     `#include` boundary so the lexer can
                //     attribute later tokens to the right
                //     `(file, line)` pair. The body parses to
                //     `LineMarker` and the lexer updates state.
                //   * `#pragma pack(...)` -- the preprocessor passes
                //     pack pragmas through verbatim (they're
                //     source-position-dependent, unlike the binding
                //     / dylib / export pragmas the preprocessor
                //     batches). Parse the args and fold into
                //     `pack_stack`.
                //   * Any other `#` line -- preserve the historical
                //     c4 line-comment fallback (shebangs,
                //     unrecognised pragmas, stray `#`s the
                //     preprocessor didn't consume). Skip to EOL.
                let line_start = self.pos;
                let mut line_end = line_start;
                while line_end < self.src.len() && self.src[line_end] as char != '\n' {
                    line_end += 1;
                }
                let body = &self.src[line_start..line_end];
                if let Some(marker) = parse_line_marker(body) {
                    // Set self.line one short of the target so the
                    // trailing `\n` (which the outer loop consumes
                    // on its next pass) bumps it to exactly N.
                    self.line = marker.line.saturating_sub(1);
                    if let Some(file) = marker.file {
                        self.file = file;
                    }
                } else if let Some(dir) = parse_pragma_pack_line(body) {
                    self.apply_pack_directive(dir);
                }
                self.pos = line_end;
            } else if c.is_ascii_alphabetic() || c == '_' {
                let start = self.pos - 1;
                let mut hash: i64 = c as i64;
                while self.pos < self.src.len() {
                    let nc = self.src[self.pos] as char;
                    if !nc.is_ascii_alphanumeric() && nc != '_' {
                        break;
                    }
                    hash = hash.wrapping_mul(147).wrapping_add(nc as i64);
                    self.pos += 1;
                }
                let name_slice = &self.src[start..self.pos];
                self.curr_id_idx = resolve_symbol(symbols, index, name_slice, hash);
                self.tk = Tok(symbols[self.curr_id_idx].token);
                return Ok(());
            } else if c.is_ascii_digit() {
                let int_start = self.pos - 1;
                let mut val = (c as u8 - b'0') as i64;
                // Octal: a leading `0` followed by an octal digit
                // means the literal is base-8 (C99 6.4.4.1: `0644`
                // is `420`). `0` followed by `x`/`X` is hex; that
                // branch is below. A bare `0` keeps `val == 0`.
                if val == 0
                    && self.pos < self.src.len()
                    && (b'0'..=b'7').contains(&self.src[self.pos])
                {
                    while self.pos < self.src.len() && (b'0'..=b'7').contains(&self.src[self.pos]) {
                        val = val * 8 + (self.src[self.pos] - b'0') as i64;
                        self.pos += 1;
                    }
                    while self.pos < self.src.len()
                        && matches!(self.src[self.pos], b'u' | b'U' | b'l' | b'L')
                    {
                        self.pos += 1;
                    }
                    self.ival = val;
                    self.tk = Tok(Token::Num as i64);
                    return Ok(());
                }
                if val == 0
                    && self.pos < self.src.len()
                    && (self.src[self.pos] as char == 'x' || self.src[self.pos] as char == 'X')
                {
                    self.pos += 1;
                    // Accumulate via wrapping_mul / wrapping_add so a
                    // hex literal that fills the full 64-bit range
                    // (e.g. `0xFFFFFFFFFFFFFFFEul`) doesn't trip
                    // debug-build overflow detection. The value is
                    // stored as i64 but interpreted bit-for-bit;
                    // wrap-on-overflow is the right shape for
                    // "build a 64-bit pattern digit-by-digit."
                    while self.pos < self.src.len() {
                        let nc = self.src[self.pos] as char;
                        let digit = if nc.is_ascii_digit() {
                            (nc as u8 - b'0') as i64
                        } else if ('a'..='f').contains(&nc) {
                            (nc as u8 - b'a' + 10) as i64
                        } else if ('A'..='F').contains(&nc) {
                            (nc as u8 - b'A' + 10) as i64
                        } else {
                            break;
                        };
                        val = val.wrapping_mul(16).wrapping_add(digit);
                        self.pos += 1;
                    }
                    // Hex literals can carry the standard integer suffix
                    // letters (u/U/l/L plus ll/LL combinations such as
                    // 0xFFFFULL). c5 has a single 64-bit integer
                    // representation so the suffix is purely
                    // informational; we consume any sequence of suffix
                    // letters and store the value unchanged.
                    while self.pos < self.src.len()
                        && matches!(self.src[self.pos], b'u' | b'U' | b'l' | b'L')
                    {
                        self.pos += 1;
                    }
                    self.ival = val;
                    self.tk = Tok(Token::Num as i64);
                    return Ok(());
                }

                while self.pos < self.src.len() {
                    let nc = self.src[self.pos] as char;
                    if !nc.is_ascii_digit() {
                        break;
                    }
                    // Decimal-literal accumulator: wrap around at i64
                    // overflow rather than panicking under debug
                    // builds. C99 says any integer constant outside
                    // the representable range has implementation-
                    // defined behavior; clang and gcc both fold to
                    // the wrapped value at the chosen type's width.
                    val = (val as u64)
                        .wrapping_mul(10)
                        .wrapping_add((nc as u8 - b'0') as u64) as i64;
                    self.pos += 1;
                }

                // Decimal integer suffix: u/U/l/L in any combination
                // (1u, 1L, 1ULL, 1lu, ...). When any suffix letter is
                // present, the literal is unambiguously an integer --
                // no float-suffix `f`/`F` can follow because the
                // standard doesn't allow it on integer literals.
                if self.pos < self.src.len()
                    && matches!(self.src[self.pos], b'u' | b'U' | b'l' | b'L')
                {
                    while self.pos < self.src.len()
                        && matches!(self.src[self.pos], b'u' | b'U' | b'l' | b'L')
                    {
                        self.pos += 1;
                    }
                    self.ival = val;
                    self.tk = Tok(Token::Num as i64);
                    return Ok(());
                }

                // Float literal: integer body followed by a `.`,
                // `e`/`E` exponent, or an `f`/`F` suffix turns the
                // whole `[int_start..self.pos]` slice into an `f64`.
                // We don't accept a `.` mid-decimal as a separator
                // for anything else (no `1.foo` field access in c5),
                // so the test is unambiguous.
                let next_is_dot = self.pos < self.src.len() && self.src[self.pos] == b'.';
                let next_is_exp = self.pos < self.src.len()
                    && (self.src[self.pos] == b'e' || self.src[self.pos] == b'E');
                let next_is_fsuffix = self.pos < self.src.len()
                    && (self.src[self.pos] == b'f' || self.src[self.pos] == b'F');
                if next_is_dot || next_is_exp || next_is_fsuffix {
                    if next_is_dot {
                        self.pos += 1;
                        while self.pos < self.src.len()
                            && (self.src[self.pos] as char).is_ascii_digit()
                        {
                            self.pos += 1;
                        }
                    }
                    if self.pos < self.src.len()
                        && (self.src[self.pos] == b'e' || self.src[self.pos] == b'E')
                    {
                        self.pos += 1;
                        if self.pos < self.src.len()
                            && (self.src[self.pos] == b'+' || self.src[self.pos] == b'-')
                        {
                            self.pos += 1;
                        }
                        while self.pos < self.src.len()
                            && (self.src[self.pos] as char).is_ascii_digit()
                        {
                            self.pos += 1;
                        }
                    }
                    let body_end = self.pos;
                    if self.pos < self.src.len()
                        && (self.src[self.pos] == b'f' || self.src[self.pos] == b'F')
                    {
                        // Consume the `f`/`F` suffix; both `1.0` and
                        // `1.0f` are stored as `f64` internally.
                        self.pos += 1;
                    }
                    let lit =
                        core::str::from_utf8(&self.src[int_start..body_end]).map_err(|e| {
                            C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                                "{}: float literal not valid utf-8: {e}",
                                self.line
                            )))
                        })?;
                    let f: f64 = lit.parse().map_err(|e| {
                        C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                            "{}: malformed float literal `{lit}`: {e}",
                            self.line
                        )))
                    })?;
                    self.ival = f.to_bits() as i64;
                    self.tk = Tok(Token::FloatNum as i64);
                    return Ok(());
                }

                self.ival = val;
                self.tk = Tok(Token::Num as i64);
                return Ok(());
            } else if c == '/' {
                if self.pos < self.src.len() && self.src[self.pos] as char == '/' {
                    self.pos += 1;
                    while self.pos < self.src.len() && self.src[self.pos] as char != '\n' {
                        self.pos += 1;
                    }
                } else if self.pos < self.src.len() && self.src[self.pos] as char == '*' {
                    // C-style `/* ... */` block comment. Track newlines
                    // so `self.line` stays accurate -- error messages
                    // and `__LINE__` upstream depend on it.
                    self.pos += 1;
                    while self.pos + 1 < self.src.len() {
                        if self.src[self.pos] == b'*' && self.src[self.pos + 1] == b'/' {
                            self.pos += 2;
                            break;
                        }
                        if self.src[self.pos] == b'\n' {
                            self.line += 1;
                        }
                        self.pos += 1;
                    }
                } else if self.pos < self.src.len() && self.src[self.pos] as char == '=' {
                    self.pos += 1;
                    self.tk = Tok(Token::AssignOp as i64);
                    self.ival = Token::DivOp as i64;
                    return Ok(());
                } else {
                    self.tk = Tok(Token::DivOp as i64);
                    return Ok(());
                }
            } else if c == '\'' || c == '"' {
                let start_data = data.len() as i64;
                while self.pos < self.src.len() && self.src[self.pos] as char != c {
                    let mut val = self.src[self.pos] as i64;
                    self.pos += 1;
                    if val == '\\' as i64 {
                        let esc = self.src[self.pos];
                        self.pos += 1;
                        match esc {
                            b'a' => val = 0x07,
                            b'b' => val = 0x08,
                            b't' => val = 0x09,
                            b'n' => val = 0x0A,
                            b'v' => val = 0x0B,
                            b'f' => val = 0x0C,
                            b'r' => val = 0x0D,
                            b'\\' => val = b'\\' as i64,
                            b'\'' => val = b'\'' as i64,
                            b'"' => val = b'"' as i64,
                            b'?' => val = b'?' as i64,
                            // \xHH -- hex escape, 1+ hex digits, the
                            // C spec is greedy ("as many hex digits as
                            // make sense") but only the low byte
                            // matters for c5's char/string streams.
                            b'x' => {
                                let mut acc: i64 = 0;
                                let mut count = 0;
                                while self.pos < self.src.len() {
                                    let h = self.src[self.pos];
                                    let d = match h {
                                        b'0'..=b'9' => (h - b'0') as i64,
                                        b'a'..=b'f' => 10 + (h - b'a') as i64,
                                        b'A'..=b'F' => 10 + (h - b'A') as i64,
                                        _ => break,
                                    };
                                    acc = (acc << 4) | d;
                                    self.pos += 1;
                                    count += 1;
                                }
                                if count == 0 {
                                    return Err(C5Error::Compile(
                                        crate::c5::error::fmt_internal_err(&format!(
                                            "{}: \\x escape needs at least one hex digit",
                                            self.line
                                        )),
                                    ));
                                }
                                val = acc;
                            }
                            // \NNN -- octal escape, 1..3 digits.
                            // Includes plain `\0` which is just the
                            // 1-digit case.
                            b'0'..=b'7' => {
                                let mut acc: i64 = (esc - b'0') as i64;
                                let mut count = 1;
                                while count < 3 && self.pos < self.src.len() {
                                    let o = self.src[self.pos];
                                    if !(b'0'..=b'7').contains(&o) {
                                        break;
                                    }
                                    acc = (acc << 3) | (o - b'0') as i64;
                                    self.pos += 1;
                                    count += 1;
                                }
                                val = acc;
                            }
                            _ => {
                                // Unknown escape -- C says undefined, GCC
                                // warns. We pass the literal char through
                                // so legacy fixtures don't break.
                                val = esc as i64;
                            }
                        }
                    }
                    if c == '"' {
                        data.push(val as u8);
                    } else {
                        self.ival = val;
                    }
                }
                self.pos += 1;
                if c == '"' {
                    // NB: no NUL terminator pushed here. Adjacent string
                    // literals (`"a" "b"`) concatenate in C, so the
                    // parser is the right place to add the single
                    // trailing NUL once all the parts have been read.
                    self.ival = start_data;
                    self.tk = Tok('"' as i64);
                } else {
                    self.tk = Tok(Token::Num as i64);
                }
                return Ok(());
            } else {
                let next_char = if self.pos < self.src.len() {
                    self.src[self.pos] as char
                } else {
                    '\0'
                };
                match c {
                    '=' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Tok(Token::EqOp as i64);
                        } else {
                            self.tk = Tok(Token::Assign as i64);
                        }
                    }
                    '+' => {
                        if next_char == '+' {
                            self.pos += 1;
                            self.tk = Tok(Token::Inc as i64);
                        } else if next_char == '=' {
                            self.pos += 1;
                            self.tk = Tok(Token::AssignOp as i64);
                            self.ival = Token::AddOp as i64;
                        } else {
                            self.tk = Tok(Token::AddOp as i64);
                        }
                    }
                    '-' => {
                        if next_char == '-' {
                            self.pos += 1;
                            self.tk = Tok(Token::Dec as i64);
                        } else if next_char == '>' {
                            self.pos += 1;
                            self.tk = Tok(Token::Arrow as i64);
                        } else if next_char == '=' {
                            self.pos += 1;
                            self.tk = Tok(Token::AssignOp as i64);
                            self.ival = Token::SubOp as i64;
                        } else {
                            self.tk = Tok(Token::SubOp as i64);
                        }
                    }
                    '!' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Tok(Token::NeOp as i64);
                        } else {
                            // Standalone `!` (logical NOT). Falling
                            // through to tk=0 here used to silently
                            // signal EOF, breaking any expression like
                            // `!x` -- the parser would then complain
                            // about an unexpected eof.
                            self.tk = Tok('!' as i64);
                        }
                    }
                    '<' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Tok(Token::LeOp as i64);
                        } else if next_char == '<' {
                            // `<<` then optional `=` -- `<<=` is a
                            // compound shift-assign; `<<` alone is
                            // the shift operator.
                            self.pos += 1;
                            if self.pos < self.src.len() && self.src[self.pos] == b'=' {
                                self.pos += 1;
                                self.tk = Tok(Token::AssignOp as i64);
                                self.ival = Token::ShlOp as i64;
                            } else {
                                self.tk = Tok(Token::ShlOp as i64);
                            }
                        } else {
                            self.tk = Tok(Token::LtOp as i64);
                        }
                    }
                    '>' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Tok(Token::GeOp as i64);
                        } else if next_char == '>' {
                            self.pos += 1;
                            if self.pos < self.src.len() && self.src[self.pos] == b'=' {
                                self.pos += 1;
                                self.tk = Tok(Token::AssignOp as i64);
                                self.ival = Token::ShrOp as i64;
                            } else {
                                self.tk = Tok(Token::ShrOp as i64);
                            }
                        } else {
                            self.tk = Tok(Token::GtOp as i64);
                        }
                    }
                    '|' => {
                        if next_char == '|' {
                            self.pos += 1;
                            self.tk = Tok(Token::Lor as i64);
                        } else if next_char == '=' {
                            self.pos += 1;
                            self.tk = Tok(Token::AssignOp as i64);
                            self.ival = Token::OrOp as i64;
                        } else {
                            self.tk = Tok(Token::OrOp as i64);
                        }
                    }
                    '&' => {
                        if next_char == '&' {
                            self.pos += 1;
                            self.tk = Tok(Token::Lan as i64);
                        } else if next_char == '=' {
                            self.pos += 1;
                            self.tk = Tok(Token::AssignOp as i64);
                            self.ival = Token::AndOp as i64;
                        } else {
                            self.tk = Tok(Token::AndOp as i64);
                        }
                    }
                    '^' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Tok(Token::AssignOp as i64);
                            self.ival = Token::XorOp as i64;
                        } else {
                            self.tk = Tok(Token::XorOp as i64);
                        }
                    }
                    '%' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Tok(Token::AssignOp as i64);
                            self.ival = Token::ModOp as i64;
                        } else {
                            self.tk = Tok(Token::ModOp as i64);
                        }
                    }
                    '*' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Tok(Token::AssignOp as i64);
                            self.ival = Token::MulOp as i64;
                        } else {
                            self.tk = Tok(Token::MulOp as i64);
                        }
                    }
                    '[' => self.tk = Tok(Token::Brak as i64),
                    '?' => self.tk = Tok(Token::Cond as i64),
                    '.' => {
                        // Three consecutive dots -> variadic ellipsis;
                        // `.<digit>` is a C99 6.4.4.2 fractional
                        // floating-constant with an empty integer
                        // part (`.5` == `0.5`); a bare `.` is the
                        // struct-value field-access operator.
                        if self.pos + 1 < self.src.len()
                            && self.src[self.pos] == b'.'
                            && self.src[self.pos + 1] == b'.'
                        {
                            self.pos += 2;
                            self.tk = Tok(Token::Ellipsis as i64);
                        } else if self.pos < self.src.len()
                            && (self.src[self.pos] as char).is_ascii_digit()
                        {
                            // Float-literal start: rewind one byte so
                            // `int_start` (set below) covers the leading
                            // `.`, then consume the digit run +
                            // optional exponent + optional suffix the
                            // same way the digit-led path does.
                            let int_start = self.pos - 1;
                            while self.pos < self.src.len()
                                && (self.src[self.pos] as char).is_ascii_digit()
                            {
                                self.pos += 1;
                            }
                            if self.pos < self.src.len()
                                && (self.src[self.pos] == b'e' || self.src[self.pos] == b'E')
                            {
                                self.pos += 1;
                                if self.pos < self.src.len()
                                    && (self.src[self.pos] == b'+' || self.src[self.pos] == b'-')
                                {
                                    self.pos += 1;
                                }
                                while self.pos < self.src.len()
                                    && (self.src[self.pos] as char).is_ascii_digit()
                                {
                                    self.pos += 1;
                                }
                            }
                            let body_end = self.pos;
                            if self.pos < self.src.len()
                                && (self.src[self.pos] == b'f' || self.src[self.pos] == b'F')
                            {
                                self.pos += 1;
                            }
                            let lit = core::str::from_utf8(&self.src[int_start..body_end])
                                .map_err(|e| {
                                    C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                                        "{}: float literal not valid utf-8: {e}",
                                        self.line
                                    )))
                                })?;
                            let f: f64 = lit.parse().map_err(|e| {
                                C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                                    "{}: malformed float literal `{lit}`: {e}",
                                    self.line
                                )))
                            })?;
                            self.ival = f.to_bits() as i64;
                            self.tk = Tok(Token::FloatNum as i64);
                        } else {
                            self.tk = Tok(Token::Dot as i64);
                        }
                    }
                    _ => {
                        if "!~;{}()],:".contains(c) {
                            self.tk = Tok(c as i64);
                        } else {
                            continue;
                        }
                    }
                }
                return Ok(());
            }
        }
    }
}

pub(crate) fn hash_name(name: &[u8]) -> i64 {
    let mut h: i64 = 0;
    for &b in name {
        h = h.wrapping_mul(147).wrapping_add(b as i64);
    }
    h
}

pub(crate) fn find_symbol(symbols: &[Symbol], index: &SymbolIndex, name: &str) -> Option<usize> {
    let bytes = name.as_bytes();
    index.lookup(symbols, hash_name(bytes), bytes)
}

pub(crate) fn resolve_symbol(
    symbols: &mut Vec<Symbol>,
    index: &mut SymbolIndex,
    name: &[u8],
    hash: i64,
) -> usize {
    if let Some(i) = index.lookup(symbols, hash, name) {
        return i;
    }
    symbols.push(Symbol {
        name: String::from_utf8_lossy(name).to_string(),
        token: Token::Id as i64,
        ..Default::default()
    });
    index.record(hash);
    symbols.len() - 1
}

fn add_keyword(symbols: &mut Vec<Symbol>, index: &mut SymbolIndex, name: &str, token: i64) {
    let hash = hash_name(name.as_bytes());
    symbols.push(Symbol {
        name: name.to_string(),
        token,
        ..Default::default()
    });
    index.record(hash);
}

/// Reserved words that map to a non-`Id` token. Library function
/// names used to be listed here so the lexer's pre-seeded set could
/// upgrade them to `Token::Sys` later; the
/// `#pragma binding(...)`-driven seeding now picks each binding's
/// `local_name` up dynamically, so the only Id-class entry left is the
/// ceremonial `main`.
const KEYWORDS: &[(&str, Token)] = &[
    ("char", Token::Char),
    ("else", Token::Else),
    ("enum", Token::Enum),
    ("for", Token::For),
    ("if", Token::If),
    ("int", Token::Int),
    ("return", Token::Return),
    ("sizeof", Token::Sizeof),
    ("while", Token::While),
    ("do", Token::Do),
    ("break", Token::Break),
    ("continue", Token::Continue),
    ("goto", Token::Goto),
    ("switch", Token::Switch),
    ("case", Token::Case),
    ("default", Token::Default),
    ("struct", Token::Struct),
    ("float", Token::Float),
    ("double", Token::Double),
    ("_Thread_local", Token::ThreadLocal),
    ("extern", Token::Extern),
    ("static", Token::Static),
    ("void", Token::Void),
    // C11 6.7.10 `_Static_assert` and its C23 alias
    // `static_assert`. Both spellings map to the same parser
    // path -- the parser checks the constant-expression argument
    // and surfaces the string-literal as a compile error when
    // the expression is zero.
    ("_Static_assert", Token::StaticAssert),
    ("static_assert", Token::StaticAssert),
    // Type qualifiers -- consumed everywhere a type qualifier
    // may appear; no semantic effect.
    ("const", Token::TypeQual),
    ("volatile", Token::TypeQual),
    ("restrict", Token::TypeQual),
    ("__restrict", Token::TypeQual),
    ("__restrict__", Token::TypeQual),
    // Integer-type modifiers. `signed`, `unsigned`, and `long` are
    // split off: `signed` changes the meaning of a `char` base
    // (signed-char arrays hold negative values that must load
    // sign-extended); `unsigned` flips the type-tag flag that
    // routes compares through the unsigned ops; `long` selects the
    // 64-bit `Ty::Long` storage class (otherwise an `int`
    // declaration yields a 32-bit slot).
    ("signed", Token::Signed),
    ("unsigned", Token::Unsigned),
    ("short", Token::Short),
    ("long", Token::Long),
    ("_Bool", Token::IntMod),
    // Function specifiers -- accepted, no effect.
    ("inline", Token::FuncSpec),
    ("__inline", Token::FuncSpec),
    ("__inline__", Token::FuncSpec),
    ("register", Token::FuncSpec),
    ("auto", Token::FuncSpec),
    // typedef -- drives the parser's type-alias registration.
    ("typedef", Token::Typedef),
    // union -- like struct, but all members share offset 0 and
    // the size is max(member). Same identifier namespace.
    ("union", Token::Union),
    ("main", Token::Id),
];

// `LIB_OPS` used to live here -- a static (name, Op) table the
// lexer used to upgrade pre-seeded `Token::Id`s into `Token::Sys`.
// The set is gone now: each `#pragma binding(<dylib>::<name>, ...)`
// the preprocessor parses out of the included headers becomes a
// `Token::Sys` symbol with `val` set to its index in the flattened
// binding table. See [`init_symbols`].

/// Kind of a predefined identifier -- used by `--list-symbols` and any
/// future tooling that wants to enumerate the badc prelude.
///
/// Constants like `PROT_READ` used to live here too, but they were
/// moved into `headers/badc-{target}.h` and now reach the compiler
/// through the preprocessor's `#define` table instead. The
/// `Constant` variant is retained because it's part of the public
/// `PredefinedKind` enum -- removing it would be a breaking API
/// change -- but `init_symbols` no longer emits any `Constant`
/// entries.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum PredefinedKind {
    Keyword,
    /// Compiler intrinsic: a libc-shaped function (`printf`, `malloc`,
    /// ...) the compiler knows how to lower directly to a call into
    /// whatever the target system exposes (libSystem on macOS,
    /// libc.so.6 on Linux, msvcrt.dll on Windows). Not a real
    /// intrinsic in the kernel-trap sense -- the older `Syscall`
    /// spelling was misleading.
    Intrinsic,
    Constant,
}

#[derive(Debug, Clone, Copy)]
pub struct PredefinedSymbol {
    pub name: &'static str,
    pub kind: PredefinedKind,
    /// For keywords this is the token discriminant, for intrinsics the
    /// op discriminant, and for constants the actual integer value.
    pub value: i64,
}

/// Flatten the keyword listing for the `--list-symbols` CLI flag.
///
/// Header-bound function names (`printf`, `malloc`, ...) are no
/// longer fixed; they enter the symbol table via
/// `#pragma binding(...)` once per program. Listing them here
/// would be misleading -- the set depends on which headers the
/// source `#include`s -- so we only show real keywords.
pub fn predefined_symbols() -> Vec<PredefinedSymbol> {
    let mut out = Vec::with_capacity(KEYWORDS.len());
    for (name, tok) in KEYWORDS {
        if *tok as i64 == Token::Id as i64 {
            continue;
        }
        out.push(PredefinedSymbol {
            name,
            kind: PredefinedKind::Keyword,
            value: *tok as i64,
        });
    }
    out
}

/// Seed the symbol table with C keywords plus one `Token::Sys`
/// entry per `#pragma binding(...)` the preprocessor parsed out of
/// the included headers.
///
/// Each binding becomes a callable name with `val` set to its
/// flat index across all `bindings` in declaration order. The
/// parser's call site emits `Op::JsrExt val + Op::Adj N`, and the
/// codegen / VM resolve `val` against the same flattened list at
/// emit / run time.
///
/// A name that's bound twice (two `#pragma binding`s with the same
/// `local_name`) gets the *first* index; later bindings are ignored
/// here since the symbol table only holds one entry per name.
/// `#include`-time deduplication via `#pragma once` makes that the
/// expected case.
pub(crate) fn init_symbols(
    symbols: &mut Vec<Symbol>,
    index: &mut SymbolIndex,
    dylibs: &[super::preprocessor::DylibSpec],
) {
    for (name, tok) in KEYWORDS {
        add_keyword(symbols, index, name, *tok as i64);
    }

    let mut binding_idx: i64 = 0;
    for spec in dylibs {
        for binding in &spec.bindings {
            let name = binding.local_name.as_str();
            if find_symbol(symbols, index, name).is_none() {
                let hash = hash_name(name.as_bytes());
                symbols.push(Symbol {
                    name: name.to_string(),
                    token: Token::Id as i64,
                    class: Token::Sys as i64,
                    type_: Ty::Int as i64,
                    val: binding_idx,
                    ..Default::default()
                });
                index.record(hash);
            }
            binding_idx += 1;
        }
    }

    // Make sure `main` is registered so the compiler's later lookup sees it.
    // This is an internal invariant of `init_symbols` itself; if it ever
    // fires we want it to surface loudly, but a debug_assert is enough --
    // release builds don't pay the lookup cost.
    debug_assert!(
        find_symbol(symbols, index, "main").is_some(),
        "init_symbols must register `main`"
    );
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Lex a single source-text string through `Lexer::next` and
    /// return the bytes the lexer pushed into `data`. Used to pin
    /// the escape-sequence behaviour of string literals.
    fn lex_string_literal(src: &str) -> Vec<u8> {
        let mut lex = Lexer::new(src.to_string());
        let mut symbols: Vec<Symbol> = Vec::new();
        let mut index = SymbolIndex::new();
        let mut data: Vec<u8> = Vec::new();
        lex.next(&mut symbols, &mut index, &mut data).unwrap();
        assert_eq!(
            lex.tk, '"' as i64,
            "expected a string token, got {}",
            lex.tk
        );
        data
    }

    fn lex_char_literal(src: &str) -> i64 {
        let mut lex = Lexer::new(src.to_string());
        let mut symbols: Vec<Symbol> = Vec::new();
        let mut index = SymbolIndex::new();
        let mut data: Vec<u8> = Vec::new();
        lex.next(&mut symbols, &mut index, &mut data).unwrap();
        assert_eq!(lex.tk, Token::Num as i64);
        lex.ival
    }

    #[test]
    fn simple_escapes_decode_to_their_byte() {
        assert_eq!(lex_string_literal(r#""\n""#), vec![b'\n']);
        assert_eq!(lex_string_literal(r#""\r""#), vec![b'\r']);
        assert_eq!(lex_string_literal(r#""\t""#), vec![b'\t']);
        assert_eq!(lex_string_literal(r#""\v""#), vec![0x0B]);
        assert_eq!(lex_string_literal(r#""\f""#), vec![0x0C]);
        assert_eq!(lex_string_literal(r#""\a""#), vec![0x07]);
        assert_eq!(lex_string_literal(r#""\b""#), vec![0x08]);
        assert_eq!(lex_string_literal(r#""\\""#), vec![b'\\']);
        assert_eq!(lex_string_literal(r#""\"""#), vec![b'"']);
        assert_eq!(lex_string_literal(r#""\?""#), vec![b'?']);
    }

    #[test]
    fn hex_escape_takes_one_or_two_digits() {
        assert_eq!(lex_string_literal(r#""\x41""#), vec![0x41]); // 'A'
        assert_eq!(lex_string_literal(r#""\x1F""#), vec![0x1F]);
        // No-trailing-digit cutoff -- `g` is not hex.
        assert_eq!(lex_string_literal(r#""\x4g""#), vec![0x04, b'g']);
    }

    #[test]
    fn octal_escape_takes_up_to_three_digits() {
        assert_eq!(lex_string_literal(r#""\0""#), vec![0]);
        assert_eq!(lex_string_literal(r#""\012""#), vec![0o12]); // == \n
        assert_eq!(lex_string_literal(r#""\101""#), vec![0o101]); // 'A'
        // Octal stops at the first non-octal digit.
        assert_eq!(lex_string_literal(r#""\18""#), vec![0o1, b'8']);
    }

    #[test]
    fn char_literal_uses_the_same_escape_path() {
        assert_eq!(lex_char_literal(r#"'\n'"#), b'\n' as i64);
        assert_eq!(lex_char_literal(r#"'\x7f'"#), 0x7F);
        assert_eq!(lex_char_literal(r#"'\0'"#), 0);
    }

    #[test]
    fn unknown_escape_passes_through_the_letter() {
        // Matches GCC's implementation-defined behaviour for unknown
        // escapes: emit the literal char.
        assert_eq!(lex_string_literal(r#""\q""#), vec![b'q']);
    }
}

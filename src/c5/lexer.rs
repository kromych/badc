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

/// Decode one UTF-8 code point from the front of `bytes`, returning
/// `(code_point, byte_length)`. A malformed lead or truncated sequence
/// falls back to the single byte interpreted as Latin-1, so the lexer
/// always advances.
fn decode_utf8(bytes: &[u8]) -> (u32, usize) {
    let b0 = bytes[0];
    let (mut cp, len) = if b0 & 0x80 == 0 {
        return (b0 as u32, 1);
    } else if b0 & 0xE0 == 0xC0 {
        ((b0 & 0x1F) as u32, 2)
    } else if b0 & 0xF0 == 0xE0 {
        ((b0 & 0x0F) as u32, 3)
    } else if b0 & 0xF8 == 0xF0 {
        ((b0 & 0x07) as u32, 4)
    } else {
        return (b0 as u32, 1);
    };
    let mut i = 1;
    while i < len && i < bytes.len() && bytes[i] & 0xC0 == 0x80 {
        cp = (cp << 6) | (bytes[i] & 0x3F) as u32;
        i += 1;
    }
    if i < len {
        // Truncated sequence: fall back to the lead byte.
        return (b0 as u32, 1);
    }
    (cp, len)
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

    /// Integer-literal suffix shape from the most recent `Token::Num`
    /// produced by `next()`. C99 6.4.4.1 lists the canonical six
    /// suffix combinations; c5 collapses them to a (longness,
    /// unsigned) pair the expression parser consumes to type the
    /// literal. `int_suffix_long`: 0 = no L (default int), 1 = one
    /// L (`long`), 2 = two L (`long long`). `int_suffix_unsigned`:
    /// true if any `u`/`U` appeared in the suffix.
    pub int_suffix_long: u8,
    pub int_suffix_unsigned: bool,
    /// `true` when the most recent `Token::Num` was written in decimal.
    /// C99 6.4.4.1 lets a hexadecimal, octal, or binary constant take
    /// an unsigned type when no signed type at its rank fits, while a
    /// decimal constant with no `u` suffix stays signed.
    pub int_is_decimal: bool,

    /// `true` when the most recent `'"'` string-literal token came from
    /// a wide (`L"..."`) literal. `wchar_t` is `int` (4 bytes), so the
    /// bytes already in `self.data` hold one 4-byte code point per
    /// element; the initializer and expression parsers read this to
    /// size the element stride (C99 6.4.5).
    pub str_is_wide: bool,

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
            int_suffix_long: 0,
            int_suffix_unsigned: false,
            int_is_decimal: true,
            str_is_wide: false,
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
    /// Tokenise a C99 wide-string (`L"..."`) or wide-character
    /// (`L'...'`) literal. Caller has consumed the `L`; `self.pos`
    /// points at the opening quote. Characters are emitted into
    /// `data` as 16-bit little-endian values (one slot per `char`)
    /// per the UTF-16 representation. Adjacent `L"..."` literals
    /// are absorbed into the current token so the parser's narrow
    /// concatenation loop does not interleave a 1-byte gap, and a
    /// 16-bit `0` terminator is appended at the end.
    /// Parse the rest of a C99 6.4.4.2 hexadecimal floating
    /// constant. The integer hex digits occupy `[mant_start,
    /// self.pos)`; `self.pos` points at the `.` or the binary-
    /// exponent letter `p`/`P`. Consumes the optional fractional
    /// digits, the mandatory `p`/`P` [sign] decimal exponent, and an
    /// optional `f`/`F`/`l`/`L` suffix, returning the value as f64.
    fn lex_hex_float(&mut self, mant_start: usize) -> Result<f64, C5Error> {
        let hex_val = |b: u8| -> Option<u32> {
            match b {
                b'0'..=b'9' => Some((b - b'0') as u32),
                b'a'..=b'f' => Some((b - b'a' + 10) as u32),
                b'A'..=b'F' => Some((b - b'A' + 10) as u32),
                _ => None,
            }
        };
        let mut mant: f64 = 0.0;
        for &b in &self.src[mant_start..self.pos] {
            mant = mant * 16.0 + hex_val(b).unwrap_or(0) as f64;
        }
        if self.pos < self.src.len() && self.src[self.pos] == b'.' {
            self.pos += 1;
            let mut scale = 1.0_f64 / 16.0;
            while self.pos < self.src.len() {
                let Some(d) = hex_val(self.src[self.pos]) else {
                    break;
                };
                mant += d as f64 * scale;
                scale /= 16.0;
                self.pos += 1;
            }
        }
        if self.pos >= self.src.len() || (self.src[self.pos] != b'p' && self.src[self.pos] != b'P')
        {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "{}: hexadecimal floating constant requires a binary exponent (`p`)",
                    self.line
                ),
            )));
        }
        self.pos += 1;
        let exp_neg = if self.pos < self.src.len()
            && (self.src[self.pos] == b'+' || self.src[self.pos] == b'-')
        {
            let neg = self.src[self.pos] == b'-';
            self.pos += 1;
            neg
        } else {
            false
        };
        let exp_start = self.pos;
        let mut exp: i32 = 0;
        while self.pos < self.src.len() && self.src[self.pos].is_ascii_digit() {
            exp = exp
                .saturating_mul(10)
                .saturating_add((self.src[self.pos] - b'0') as i32);
            self.pos += 1;
        }
        if self.pos == exp_start {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("{}: binary exponent has no digits", self.line),
            )));
        }
        let mut exp = if exp_neg { -exp } else { exp };
        // The `f`/`F`/`l`/`L` suffix only selects the type; c5 stores
        // every floating constant as f64, so it is consumed and
        // discarded.
        if self.pos < self.src.len() && matches!(self.src[self.pos], b'f' | b'F' | b'l' | b'L') {
            self.pos += 1;
        }
        // Scale by 2^exp through exact doubling / halving so the
        // result needs no std-only float intrinsics.
        while exp > 0 {
            mant *= 2.0;
            exp -= 1;
        }
        while exp < 0 {
            mant *= 0.5;
            exp += 1;
        }
        Ok(mant)
    }

    fn lex_wide_literal(&mut self, data: &mut Vec<u8>) -> Result<(), C5Error> {
        let quote = self.src[self.pos];
        self.pos += 1;
        let start_data = data.len() as i64;
        let mut char_value: i64 = 0;
        loop {
            while self.pos < self.src.len() && self.src[self.pos] != quote {
                // A wide literal's elements are Unicode code points
                // (C99 6.4.4.4 / 6.4.5): decode the UTF-8 source bytes
                // so `L'a'` is U+00E1 = 225, not the trailing byte of
                // its two-byte encoding. ASCII passes through unchanged.
                let mut val = if self.src[self.pos] < 0x80 {
                    let b = self.src[self.pos] as i64;
                    self.pos += 1;
                    b
                } else {
                    let (cp, len) = decode_utf8(&self.src[self.pos..]);
                    self.pos += len;
                    cp as i64
                };
                if val == b'\\' as i64 {
                    if self.pos >= self.src.len() {
                        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                            &format!("{}: unterminated wide-literal escape", self.line),
                        )));
                    }
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
                                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                                    &format!(
                                        "{}: \\x in wide literal needs at least one hex digit",
                                        self.line
                                    ),
                                )));
                            }
                            val = acc;
                        }
                        b'u' | b'U' => {
                            // Universal character name (C99 6.4.3):
                            // `\u` takes exactly four hex digits, `\U`
                            // exactly eight, naming a Unicode code point.
                            let digits = if esc == b'u' { 4 } else { 8 };
                            let mut acc: i64 = 0;
                            let mut count = 0;
                            while count < digits && self.pos < self.src.len() {
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
                            if count != digits {
                                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                                    &format!(
                                        "{}: \\{} needs {} hex digits",
                                        self.line, esc as char, digits
                                    ),
                                )));
                            }
                            val = acc;
                        }
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
                        _ => val = esc as i64,
                    }
                }
                if quote == b'"' {
                    // `wchar_t` is `int` (stddef.h), so a wide string
                    // stores one 4-byte code point per element.
                    data.push(val as u8);
                    data.push((val >> 8) as u8);
                    data.push((val >> 16) as u8);
                    data.push((val >> 24) as u8);
                } else {
                    char_value = val;
                }
            }
            if self.pos >= self.src.len() {
                return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!("{}: unterminated wide literal", self.line),
                )));
            }
            self.pos += 1; // consume closing quote
            if quote != b'"' {
                self.ival = char_value;
                self.tk = Tok(Token::Num as i64);
                return Ok(());
            }
            // Absorb adjacent `L"..."` literals so the 16-bit
            // terminator below isn't split by the parser's narrow
            // concatenation loop.
            let saved_pos = self.pos;
            let saved_line = self.line;
            while self.pos < self.src.len() {
                let ch = self.src[self.pos];
                if ch == b' ' || ch == b'\t' || ch == b'\r' {
                    self.pos += 1;
                } else if ch == b'\n' {
                    self.line += 1;
                    self.pos += 1;
                } else {
                    break;
                }
            }
            if self.pos + 1 < self.src.len()
                && self.src[self.pos] == b'L'
                && self.src[self.pos + 1] == b'"'
            {
                self.pos += 2;
                continue;
            }
            self.pos = saved_pos;
            self.line = saved_line;
            // 4-byte (`wchar_t`) NUL terminator.
            data.push(0);
            data.push(0);
            data.push(0);
            data.push(0);
            self.ival = start_data;
            self.tk = Tok('"' as i64);
            self.str_is_wide = true;
            return Ok(());
        }
    }

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
    /// knows what shape follows. Avoids a snapshot/restore round
    /// trip through the lexer state.
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

    /// Count top-level comma-separated items in a brace list, starting
    /// just past the outer `{`. Used to size a brace-elided array of
    /// structs (C99 6.7.8p20): the number of items divided by the per-
    /// element initializer slot count gives the array length. Returns
    /// the item count (0 for an empty `{ }`). Trailing commas do not
    /// inflate the count.
    pub fn count_top_level_items_in_array(&self) -> usize {
        let bytes = &self.src;
        let mut p = self.pos;
        let mut depth: i32 = 1;
        let mut items: usize = 0;
        // True once the current top-level item has seen content; a
        // trailing comma before `}` leaves it false, so no phantom item.
        let mut cur_has_content = false;
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
                cur_has_content = true;
                continue;
            }
            if c == b'{' || c == b'[' || c == b'(' {
                depth += 1;
                cur_has_content = true;
                p += 1;
                continue;
            }
            if c == b'}' || c == b']' || c == b')' {
                depth -= 1;
                p += 1;
                continue;
            }
            if c == b',' && depth == 1 {
                if cur_has_content {
                    items += 1;
                    cur_has_content = false;
                }
                p += 1;
                continue;
            }
            if !c.is_ascii_whitespace() {
                cur_has_content = true;
            }
            p += 1;
        }
        if cur_has_content {
            items += 1;
        }
        items
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
        // Reset the integer-literal suffix fields so a previous
        // `Num` token's suffix does not leak into the next token's
        // type tracking. The integer-literal lex paths set these
        // explicitly before returning a `Token::Num`.
        self.int_suffix_long = 0;
        self.int_suffix_unsigned = false;
        self.int_is_decimal = true;
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
                // C99 wide-literal prefix: a lone `L` directly
                // followed by `"` or `'` is the start of a wide
                // string / wide char literal rather than an
                // identifier. `u` / `U` / `u8` follow the same
                // pattern but aren't yet wired up.
                if self.pos - start == 1
                    && self.src[start] == b'L'
                    && self.pos < self.src.len()
                    && (self.src[self.pos] == b'"' || self.src[self.pos] == b'\'')
                {
                    return self.lex_wide_literal(data);
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
                    self.int_is_decimal = false;
                    return Ok(());
                }
                if val == 0
                    && self.pos < self.src.len()
                    && (self.src[self.pos] as char == 'b' || self.src[self.pos] as char == 'B')
                {
                    let mark = self.pos;
                    self.pos += 1;
                    // C23 / GCC extension: `0b`/`0B` prefixes a binary
                    // integer literal. Accumulate via wrapping_mul so a
                    // 64-bit pattern (`0b1...64...`) doesn't trip
                    // debug-build overflow detection.
                    let mut consumed = 0;
                    while self.pos < self.src.len() {
                        let nc = self.src[self.pos];
                        let digit = match nc {
                            b'0' => 0i64,
                            b'1' => 1i64,
                            _ => break,
                        };
                        val = val.wrapping_mul(2).wrapping_add(digit);
                        self.pos += 1;
                        consumed += 1;
                    }
                    if consumed == 0 {
                        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                            &format!(
                                "{}: binary literal `0{}` has no digits",
                                self.line,
                                char::from(self.src[mark])
                            ),
                        )));
                    }
                    while self.pos < self.src.len()
                        && matches!(self.src[self.pos], b'u' | b'U' | b'l' | b'L')
                    {
                        self.pos += 1;
                    }
                    self.ival = val;
                    self.tk = Tok(Token::Num as i64);
                    self.int_is_decimal = false;
                    return Ok(());
                }
                if val == 0
                    && self.pos < self.src.len()
                    && (self.src[self.pos] as char == 'x' || self.src[self.pos] as char == 'X')
                {
                    self.pos += 1;
                    let hex_body_start = self.pos;
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
                    // C99 6.4.4.2 hex floating constant: the integer
                    // hex digits are followed by a `.` and/or the
                    // mandatory binary-exponent part `p`/`P`. Detect
                    // either marker here; a plain `0x...` with neither
                    // stays an integer constant.
                    let next_is_dot = self.pos < self.src.len() && self.src[self.pos] == b'.';
                    let next_is_bexp = self.pos < self.src.len()
                        && (self.src[self.pos] == b'p' || self.src[self.pos] == b'P');
                    if next_is_dot || next_is_bexp {
                        let f = self.lex_hex_float(hex_body_start)?;
                        self.ival = f.to_bits() as i64;
                        self.tk = Tok(Token::FloatNum as i64);
                        return Ok(());
                    }
                    // Hex literals can carry the standard integer suffix
                    // letters (u/U/l/L plus ll/LL combinations such as
                    // 0xFFFFULL). Per C99 6.4.4.1 record the longness
                    // (one or two `l`/`L`) and the unsigned modifier
                    // so the expression parser can type the literal
                    // accordingly; without that the literal would
                    // default to `int` and any arithmetic that
                    // assumes 64-bit width truncates to 32.
                    let mut l_count: u8 = 0;
                    let mut u_seen = false;
                    while self.pos < self.src.len()
                        && matches!(self.src[self.pos], b'u' | b'U' | b'l' | b'L')
                    {
                        match self.src[self.pos] {
                            b'l' | b'L' => l_count = l_count.saturating_add(1),
                            b'u' | b'U' => u_seen = true,
                            _ => {}
                        }
                        self.pos += 1;
                    }
                    self.ival = val;
                    self.tk = Tok(Token::Num as i64);
                    self.int_suffix_long = l_count.min(2);
                    self.int_suffix_unsigned = u_seen;
                    self.int_is_decimal = false;
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
                // standard doesn't allow it on integer literals. Per
                // C99 6.4.4.1, count consecutive `l`/`L` characters
                // (one => long, two => long long) and note any
                // `u`/`U` for the unsigned modifier.
                if self.pos < self.src.len()
                    && matches!(self.src[self.pos], b'u' | b'U' | b'l' | b'L')
                {
                    let mut l_count: u8 = 0;
                    let mut u_seen = false;
                    while self.pos < self.src.len()
                        && matches!(self.src[self.pos], b'u' | b'U' | b'l' | b'L')
                    {
                        match self.src[self.pos] {
                            b'l' | b'L' => l_count = l_count.saturating_add(1),
                            b'u' | b'U' => u_seen = true,
                            _ => {}
                        }
                        self.pos += 1;
                    }
                    self.ival = val;
                    self.tk = Tok(Token::Num as i64);
                    self.int_suffix_long = l_count.min(2);
                    self.int_suffix_unsigned = u_seen;
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
                        && matches!(self.src[self.pos], b'f' | b'F' | b'l' | b'L')
                    {
                        // Consume the floating-point suffix per C99
                        // 6.4.4.2: `f`/`F` is float, `l`/`L` is long
                        // double. The c5 dialect aliases long double
                        // to double, so every suffix lands in `f64`
                        // and the suffix is purely informational.
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
                    self.str_is_wide = false;
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
                                && matches!(self.src[self.pos], b'f' | b'F' | b'l' | b'L')
                            {
                                // Floating-point suffix (C99 6.4.4.2):
                                // `f`/`F` -> float, `l`/`L` -> long
                                // double. The c5 dialect aliases long
                                // double to double, so the suffix is
                                // informational and the bytes land in
                                // `f64`.
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
    // C99 6.7.4 `inline` -- the inliner reads the flag set on the
    // function symbol when this keyword leads its decl-specs.
    ("inline", Token::Inline),
    ("__inline", Token::Inline),
    ("__inline__", Token::Inline),
    // Other function specifiers -- accepted, no effect.
    ("register", Token::FuncSpec),
    ("auto", Token::FuncSpec),
    // C11 _Noreturn (6.7.4): the function never returns to its
    // caller. Recorded on the function symbol so the reachability
    // analysis treats a call to it as not reaching its continuation.
    // `noreturn` is the <stdnoreturn.h> macro spelling, recognised
    // under the same token so source using the keyword without the
    // header still parses.
    ("_Noreturn", Token::Noreturn),
    ("noreturn", Token::Noreturn),
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
/// parser's call site builds an `Inst::CallExt` with that
/// binding index, and the codegen / VM resolve it against the
/// same flattened list at emit / run time.
///
/// A name that's bound twice (two `#pragma binding`s with the
/// same `local_name`) gets the *first* index; later bindings are
/// silently dropped at the symbol-table level but cause every
/// external call to route to the first dylib regardless of which
/// header the user thought was authoritative. `#pragma once` deduplication makes
/// repeated identical bindings the common case; mismatched bindings
/// from different dylibs (e.g. `msvcrt::pow` then `ucrtbase::pow`)
/// instead surface as a `warning:` on stderr -- under `std` only --
/// so the shadowed binding doesn't disappear silently.
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
            } else {
                let winner = lookup_binding_dylib(dylibs, name);
                if winner != Some(spec.name.as_str()) {
                    // Skip the warning when the shadowed
                    // binding resolves to the same dynamic
                    // symbol. Two headers declaring the same
                    // libc / libdl shim against the same
                    // `real_symbol` are equivalent in effect;
                    // the dylib-name divergence is bookkeeping
                    // and surfacing it produces no actionable
                    // signal for the user.
                    let winner_real = winner.and_then(|w| {
                        dylibs.iter().find(|s| s.name.as_str() == w).and_then(|s| {
                            s.bindings
                                .iter()
                                .find(|b| b.local_name == name)
                                .map(|b| b.real_symbol.as_str())
                        })
                    });
                    if winner_real != Some(binding.real_symbol.as_str()) {
                        warn_shadowed_binding(
                            name,
                            winner.unwrap_or("<unknown>"),
                            spec.name.as_str(),
                            binding.real_symbol.as_str(),
                        );
                    }
                }
            }
            binding_idx += 1;
        }
    }

    // `main` must be registered so the compiler's later lookup
    // sees it. This is an internal invariant of `init_symbols`;
    // a violation here is a build-time bug, so a debug_assert is
    // sufficient and release builds don't pay the lookup cost.
    debug_assert!(
        find_symbol(symbols, index, "main").is_some(),
        "init_symbols must register `main`"
    );
}

/// First dylib whose bindings list contains `local_name`, or `None`
/// if no binding registered it. Walks `dylibs` in the same order as
/// `init_symbols`, so the result names the dylib whose binding the
/// symbol table actually retained.
fn lookup_binding_dylib<'a>(
    dylibs: &'a [super::preprocessor::DylibSpec],
    local_name: &str,
) -> Option<&'a str> {
    for spec in dylibs {
        if spec.bindings.iter().any(|b| b.local_name == local_name) {
            return Some(spec.name.as_str());
        }
    }
    None
}

#[cfg(feature = "std")]
fn warn_shadowed_binding(
    local_name: &str,
    kept_dylib: &str,
    shadowed_dylib: &str,
    shadowed_real_name: &str,
) {
    eprintln!(
        "badc: warning: `#pragma binding({shadowed_dylib}::{local_name}, \
         \"{shadowed_real_name}\")` is shadowed by an earlier binding \
         from `{kept_dylib}`; the later binding is ignored. Remove or \
         reorder one of the two."
    );
}

#[cfg(not(feature = "std"))]
fn warn_shadowed_binding(
    _local_name: &str,
    _kept_dylib: &str,
    _shadowed_dylib: &str,
    _shadowed_real_name: &str,
) {
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

    #[test]
    fn wide_string_literal_emits_four_bytes_per_char() {
        // `L"AB"` -- `wchar_t` is `int`, so each code point is a 4-byte
        // LE value (0x41 0 0 0, 0x42 0 0 0) plus a 4-byte nul.
        assert_eq!(
            lex_string_literal(r#"L"AB""#),
            vec![0x41, 0, 0, 0, 0x42, 0, 0, 0, 0, 0, 0, 0]
        );
    }

    #[test]
    fn wide_string_literal_absorbs_adjacent_wide_chunks() {
        // The lexer concatenates adjacent `L"..."` literals into one
        // token so the 4-byte terminator lands at the end of the merged
        // payload, not between chunks.
        assert_eq!(
            lex_string_literal(r#"L"A" L"B""#),
            vec![0x41, 0, 0, 0, 0x42, 0, 0, 0, 0, 0, 0, 0]
        );
    }

    #[test]
    fn wide_string_literal_honours_escapes() {
        // `\n` -> 0x0A, `\\` -> 0x5C, `\x41` -> 0x41.
        assert_eq!(
            lex_string_literal(r#"L"\n\\""#),
            vec![0x0A, 0, 0, 0, 0x5C, 0, 0, 0, 0, 0, 0, 0]
        );
        assert_eq!(
            lex_string_literal(r#"L"\x41""#),
            vec![0x41, 0, 0, 0, 0, 0, 0, 0]
        );
    }

    #[test]
    fn wide_char_literal_decodes_utf8_code_point() {
        // `L'a'` (U+00E1, UTF-8 0xC3 0xA1) is the code point 225, not
        // the trailing byte of its encoding.
        assert_eq!(lex_char_literal("L'\u{00e1}'"), 0x00E1);
        assert_eq!(lex_char_literal("L'A'"), 0x41);
    }
}

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;

use super::error::C5Error;
use super::symbol::Symbol;
use super::token::{Token, Ty};

pub(crate) struct Lexer {
    src: Vec<u8>,
    pos: usize,
    pub line: usize,

    // Output of the most recent next() call.
    pub tk: i64,
    pub ival: i64,
    pub curr_id_idx: usize,
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
            tk: 0,
            ival: 0,
            curr_id_idx: 0,
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
                self.tk = 0;
                return Ok(());
            }

            let c = self.src[self.pos] as char;
            self.pos += 1;

            if c == '\n' {
                self.line += 1;
            } else if c == '#' {
                // Skip the rest of the line. Stray `#` lines that the
                // preprocessor didn't consume reach here -- the
                // historical c4 lexer treated `#` as a line-comment
                // marker, and we keep that fallback so e.g. a leading
                // shebang line lets source files be made
                // executable with `#!/usr/bin/env badc`.
                while self.pos < self.src.len() && self.src[self.pos] as char != '\n' {
                    self.pos += 1;
                }
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
                self.tk = symbols[self.curr_id_idx].token;
                return Ok(());
            } else if c.is_ascii_digit() {
                let int_start = self.pos - 1;
                let mut val = (c as u8 - b'0') as i64;
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
                    self.tk = Token::Num as i64;
                    return Ok(());
                }

                while self.pos < self.src.len() {
                    let nc = self.src[self.pos] as char;
                    if !nc.is_ascii_digit() {
                        break;
                    }
                    val = val * 10 + (nc as u8 - b'0') as i64;
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
                    self.tk = Token::Num as i64;
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
                            C5Error::Compile(format!(
                                "{}: float literal not valid utf-8: {e}",
                                self.line
                            ))
                        })?;
                    let f: f64 = lit.parse().map_err(|e| {
                        C5Error::Compile(format!(
                            "{}: malformed float literal `{lit}`: {e}",
                            self.line
                        ))
                    })?;
                    self.ival = f.to_bits() as i64;
                    self.tk = Token::FloatNum as i64;
                    return Ok(());
                }

                self.ival = val;
                self.tk = Token::Num as i64;
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
                    self.tk = Token::AssignOp as i64;
                    self.ival = Token::DivOp as i64;
                    return Ok(());
                } else {
                    self.tk = Token::DivOp as i64;
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
                                    return Err(C5Error::Compile(format!(
                                        "{}: \\x escape needs at least one hex digit",
                                        self.line
                                    )));
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
                    self.tk = '"' as i64;
                } else {
                    self.tk = Token::Num as i64;
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
                            self.tk = Token::EqOp as i64;
                        } else {
                            self.tk = Token::Assign as i64;
                        }
                    }
                    '+' => {
                        if next_char == '+' {
                            self.pos += 1;
                            self.tk = Token::Inc as i64;
                        } else if next_char == '=' {
                            self.pos += 1;
                            self.tk = Token::AssignOp as i64;
                            self.ival = Token::AddOp as i64;
                        } else {
                            self.tk = Token::AddOp as i64;
                        }
                    }
                    '-' => {
                        if next_char == '-' {
                            self.pos += 1;
                            self.tk = Token::Dec as i64;
                        } else if next_char == '>' {
                            self.pos += 1;
                            self.tk = Token::Arrow as i64;
                        } else if next_char == '=' {
                            self.pos += 1;
                            self.tk = Token::AssignOp as i64;
                            self.ival = Token::SubOp as i64;
                        } else {
                            self.tk = Token::SubOp as i64;
                        }
                    }
                    '!' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Token::NeOp as i64;
                        } else {
                            // Standalone `!` (logical NOT). Falling
                            // through to tk=0 here used to silently
                            // signal EOF, breaking any expression like
                            // `!x` -- the parser would then complain
                            // about an unexpected eof.
                            self.tk = '!' as i64;
                        }
                    }
                    '<' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Token::LeOp as i64;
                        } else if next_char == '<' {
                            // `<<` then optional `=` -- `<<=` is a
                            // compound shift-assign; `<<` alone is
                            // the shift operator.
                            self.pos += 1;
                            if self.pos < self.src.len() && self.src[self.pos] == b'=' {
                                self.pos += 1;
                                self.tk = Token::AssignOp as i64;
                                self.ival = Token::ShlOp as i64;
                            } else {
                                self.tk = Token::ShlOp as i64;
                            }
                        } else {
                            self.tk = Token::LtOp as i64;
                        }
                    }
                    '>' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Token::GeOp as i64;
                        } else if next_char == '>' {
                            self.pos += 1;
                            if self.pos < self.src.len() && self.src[self.pos] == b'=' {
                                self.pos += 1;
                                self.tk = Token::AssignOp as i64;
                                self.ival = Token::ShrOp as i64;
                            } else {
                                self.tk = Token::ShrOp as i64;
                            }
                        } else {
                            self.tk = Token::GtOp as i64;
                        }
                    }
                    '|' => {
                        if next_char == '|' {
                            self.pos += 1;
                            self.tk = Token::Lor as i64;
                        } else if next_char == '=' {
                            self.pos += 1;
                            self.tk = Token::AssignOp as i64;
                            self.ival = Token::OrOp as i64;
                        } else {
                            self.tk = Token::OrOp as i64;
                        }
                    }
                    '&' => {
                        if next_char == '&' {
                            self.pos += 1;
                            self.tk = Token::Lan as i64;
                        } else if next_char == '=' {
                            self.pos += 1;
                            self.tk = Token::AssignOp as i64;
                            self.ival = Token::AndOp as i64;
                        } else {
                            self.tk = Token::AndOp as i64;
                        }
                    }
                    '^' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Token::AssignOp as i64;
                            self.ival = Token::XorOp as i64;
                        } else {
                            self.tk = Token::XorOp as i64;
                        }
                    }
                    '%' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Token::AssignOp as i64;
                            self.ival = Token::ModOp as i64;
                        } else {
                            self.tk = Token::ModOp as i64;
                        }
                    }
                    '*' => {
                        if next_char == '=' {
                            self.pos += 1;
                            self.tk = Token::AssignOp as i64;
                            self.ival = Token::MulOp as i64;
                        } else {
                            self.tk = Token::MulOp as i64;
                        }
                    }
                    '[' => self.tk = Token::Brak as i64,
                    '?' => self.tk = Token::Cond as i64,
                    '.' => {
                        // Three consecutive dots -> variadic ellipsis;
                        // a single dot is the struct-value field access
                        // operator. Float literals starting with `.`
                        // (e.g. `.5`) aren't supported -- write `0.5`.
                        if self.pos + 1 < self.src.len()
                            && self.src[self.pos] == b'.'
                            && self.src[self.pos + 1] == b'.'
                        {
                            self.pos += 2;
                            self.tk = Token::Ellipsis as i64;
                        } else {
                            self.tk = Token::Dot as i64;
                        }
                    }
                    _ => {
                        if "!~;{}()],:".contains(c) {
                            self.tk = c as i64;
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
    ("void", Token::Char),
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
    ("short", Token::IntMod),
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
    let _ = find_symbol(symbols, index, "main").unwrap();
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

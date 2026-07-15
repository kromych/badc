//! Macro expansion over preprocessing tokens (C99 6.10.3).
//!
//! A line is lexed once into [`Tok`]s; expansion follows the rescan
//! algorithm of C99 6.10.3.4 with a per-token hideset: a token
//! produced by a macro carries the set of macro names that may not
//! re-fire on it. Substituted output rejoins the scan stream, so a
//! result token that meets a `(` from the rest of the line forms a
//! new invocation, and self-referential definitions terminate without
//! any textual re-walk of already-expanded argument text.
//!
//! Tokens are 20-byte `Copy` values: buffer and hideset live in a
//! per-line arena ([`Exp`]) and tokens hold indices, so splicing and
//! rescanning move plain bytes with no reference-count traffic.

use alloc::format;
use alloc::rc::Rc;
use alloc::string::{String, ToString};
use alloc::vec::Vec;
use hashbrown::HashMap;

use super::text::{is_ident_byte, literal_prefix_len, pp_number_len};
use super::{FnMacro, Preprocessor};

#[derive(Clone, Copy, PartialEq)]
pub(super) enum TokKind {
    Ident,
    Number,
    Str,
    Char,
    Punct,
    /// A byte sequence outside the pp-token grammar (C99 6.4p1 makes
    /// each such character its own token); copied through verbatim.
    Other,
}

/// One preprocessing token: a span of an arena buffer, its kind,
/// whether white space preceded it, and its arena hideset id (0 =
/// empty set).
#[derive(Clone, Copy)]
pub(super) struct Tok {
    start: u32,
    end: u32,
    buf: u32,
    hs: u32,
    kind: TokKind,
    space: bool,
}

/// Sorted macro-name set shared behind `Rc`: every token of one
/// substitution result points at the same set, so hideset updates
/// cost one union per expansion, not one per token.
pub(super) struct Hideset {
    names: Vec<Rc<str>>,
}

impl Hideset {
    fn contains(&self, name: &str) -> bool {
        self.names.binary_search_by(|n| (**n).cmp(name)).is_ok()
    }
}

fn hs_union(a: &Hideset, b: &Hideset) -> Hideset {
    let mut names = Vec::with_capacity(a.names.len() + b.names.len());
    let (mut i, mut j) = (0, 0);
    while i < a.names.len() && j < b.names.len() {
        match (*a.names[i]).cmp(&b.names[j]) {
            core::cmp::Ordering::Less => {
                names.push(a.names[i].clone());
                i += 1;
            }
            core::cmp::Ordering::Greater => {
                names.push(b.names[j].clone());
                j += 1;
            }
            core::cmp::Ordering::Equal => {
                names.push(a.names[i].clone());
                i += 1;
                j += 1;
            }
        }
    }
    names.extend_from_slice(&a.names[i..]);
    names.extend_from_slice(&b.names[j..]);
    Hideset { names }
}

/// A macro body lexed once (token spans relative to `body`, `buf`
/// left 0); validated against the live body text so a redefinition
/// re-lexes instead of serving stale tokens.
pub(super) struct CachedBody {
    body: Rc<str>,
    toks: Rc<Vec<Tok>>,
}

/// Length of the punctuator starting at `at`, longest match first
/// (C99 6.4.6), or 0.
fn punct_len(bytes: &[u8], at: usize) -> usize {
    let rest = &bytes[at..];
    for p in [b"<<=".as_slice(), b">>=", b"..."] {
        if rest.starts_with(p) {
            return 3;
        }
    }
    for p in [
        b"##".as_slice(),
        b"->",
        b"++",
        b"--",
        b"<<",
        b">>",
        b"<=",
        b">=",
        b"==",
        b"!=",
        b"&&",
        b"||",
        b"+=",
        b"-=",
        b"*=",
        b"/=",
        b"%=",
        b"&=",
        b"^=",
        b"|=",
    ] {
        if rest.starts_with(p) {
            return 2;
        }
    }
    if matches!(
        rest[0],
        b'(' | b')'
            | b'['
            | b']'
            | b'{'
            | b'}'
            | b','
            | b';'
            | b':'
            | b'?'
            | b'~'
            | b'!'
            | b'%'
            | b'^'
            | b'&'
            | b'*'
            | b'-'
            | b'+'
            | b'='
            | b'<'
            | b'>'
            | b'|'
            | b'/'
            | b'.'
            | b'#'
    ) {
        return 1;
    }
    0
}

/// Index just past a string / char literal starting at the quote,
/// honoring `\` escapes; an unterminated literal runs to the end.
fn skip_literal(bytes: &[u8], at: usize) -> usize {
    let quote = bytes[at];
    let mut i = at + 1;
    while i < bytes.len() {
        if bytes[i] == b'\\' && i + 1 < bytes.len() {
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

fn lex_into(text: &str, buf: u32, out: &mut Vec<Tok>) {
    let bytes = text.as_bytes();
    let mut i = 0;
    let mut space = false;
    while i < bytes.len() {
        let c = bytes[i];
        if c.is_ascii_whitespace() {
            space = true;
            i += 1;
            continue;
        }
        let start = i;
        let kind;
        if let Some(plen) = literal_prefix_len(bytes, i) {
            let quote = bytes[i + plen];
            i = skip_literal(bytes, i + plen);
            kind = if quote == b'"' {
                TokKind::Str
            } else {
                TokKind::Char
            };
        } else if c == b'"' || c == b'\'' {
            i = skip_literal(bytes, i);
            kind = if c == b'"' {
                TokKind::Str
            } else {
                TokKind::Char
            };
        } else {
            let np = pp_number_len(bytes, i);
            if np > 0 {
                i += np;
                kind = TokKind::Number;
            } else if c.is_ascii_alphabetic() || c == b'_' {
                i += 1;
                while i < bytes.len() && is_ident_byte(bytes[i]) {
                    i += 1;
                }
                kind = TokKind::Ident;
            } else {
                let pl = punct_len(bytes, i);
                if pl > 0 {
                    i += pl;
                    kind = TokKind::Punct;
                } else {
                    // One Unicode scalar (the buffer is valid UTF-8).
                    i += match c {
                        b if b >= 0xF0 => 4,
                        b if b >= 0xE0 => 3,
                        b if b >= 0xC0 => 2,
                        _ => 1,
                    };
                    kind = TokKind::Other;
                }
            }
        }
        out.push(Tok {
            start: start as u32,
            end: i as u32,
            buf,
            hs: 0,
            kind,
            space,
        });
        space = false;
    }
}

/// Splice `src` at a parameter position: the substituted tokens take
/// over the parameter token's leading-space flag.
fn splice(out: &mut Vec<Tok>, mut src: Vec<Tok>, space: bool) {
    if let Some(f) = src.first_mut() {
        f.space = space;
    }
    out.extend(src);
}

/// Arena storage reused across lines: the vectors keep their
/// capacity, only the contents are cleared per line.
#[derive(Default)]
pub(super) struct ExpScratch {
    bufs: Vec<Rc<str>>,
    sets: Vec<Rc<Hideset>>,
    /// Emptied token vectors for reuse; capacity survives.
    pool: Vec<Vec<Tok>>,
}

/// Per-line expansion state: the scan needs the macro registries
/// (through `pp`) plus the arena the tokens index into.
struct Exp<'a> {
    pp: &'a Preprocessor,
    filename: &'a str,
    line_no: usize,
    ar: &'a mut ExpScratch,
}

impl<'a> Exp<'a> {
    fn new(
        pp: &'a Preprocessor,
        filename: &'a str,
        line_no: usize,
        ar: &'a mut ExpScratch,
    ) -> Self {
        ar.bufs.clear();
        ar.sets.clear();
        Exp {
            pp,
            filename,
            line_no,
            ar,
        }
    }

    fn take_vec(&mut self) -> Vec<Tok> {
        self.ar.pool.pop().unwrap_or_default()
    }

    fn put_vec(&mut self, mut v: Vec<Tok>) {
        // Cap what the pool may pin: a giant joined line's vectors
        // would otherwise stay allocated for the whole run.
        if v.capacity() > (1 << 16) || self.ar.pool.len() >= 64 {
            return;
        }
        v.clear();
        self.ar.pool.push(v);
    }

    fn set(&self, id: u32) -> &Rc<Hideset> {
        &self.ar.sets[(id - 1) as usize]
    }

    fn text(&self, t: Tok) -> &str {
        &self.ar.bufs[t.buf as usize][t.start as usize..t.end as usize]
    }

    fn first_byte(&self, t: Tok) -> u8 {
        self.ar.bufs[t.buf as usize].as_bytes()[t.start as usize]
    }

    fn is_punct(&self, t: Tok, s: &str) -> bool {
        t.kind == TokKind::Punct && self.text(t) == s
    }

    fn add_buf(&mut self, buf: Rc<str>) -> u32 {
        self.ar.bufs.push(buf);
        (self.ar.bufs.len() - 1) as u32
    }

    /// Arena id of a shared buffer, registered once per line
    /// (pointer identity; the per-line buffer count is small).
    fn buf_id(&mut self, buf: &Rc<str>) -> u32 {
        for (i, b) in self.ar.bufs.iter().enumerate() {
            if Rc::ptr_eq(b, buf) {
                return i as u32;
            }
        }
        self.add_buf(buf.clone())
    }

    fn synth(&mut self, text: String, kind: TokKind, space: bool) -> Tok {
        let end = text.len() as u32;
        let buf = self.add_buf(Rc::from(text));
        Tok {
            start: 0,
            end,
            buf,
            hs: 0,
            kind,
            space,
        }
    }

    fn intern_set(&mut self, s: Rc<Hideset>) -> u32 {
        self.ar.sets.push(s);
        self.ar.sets.len() as u32
    }

    fn hs_contains(&self, hs: u32, name: &str) -> bool {
        hs != 0 && self.set(hs).contains(name)
    }

    /// C99 6.10.3.4: a function-like invocation's new hideset is the
    /// intersection of the name's and the closing paren's, plus the
    /// name.
    fn hs_intersect(&mut self, a: u32, b: u32) -> u32 {
        if a == 0 || b == 0 {
            return 0;
        }
        if a == b {
            return a;
        }
        let (sa, sb) = (self.set(a), self.set(b));
        let names: Vec<Rc<str>> = sa
            .names
            .iter()
            .filter(|n| sb.contains(n))
            .cloned()
            .collect();
        if names.is_empty() {
            0
        } else {
            self.intern_set(Rc::new(Hideset { names }))
        }
    }

    /// `hs + {name}`; the empty-set case (every top-level fire) is
    /// served from the preprocessor's per-name singleton cache.
    fn hs_with_name(&mut self, hs: u32, name: &str) -> u32 {
        if hs == 0 {
            let s = self.pp.hs_singleton(name);
            return self.intern_set(s);
        }
        let set = self.set(hs);
        if set.contains(name) {
            return hs;
        }
        let mut names = set.names.clone();
        if let Err(at) = names.binary_search_by(|n| (**n).cmp(name)) {
            names.insert(at, Rc::from(name));
        }
        self.intern_set(Rc::new(Hideset { names }))
    }

    /// Union `hs` into every token whose hideset is ever consulted:
    /// the scan reads it for identifiers (may they fire?) and for `)`
    /// (the invocation-hideset intersection); on every other token it
    /// is dead weight, and arguments here can be huge. Tokens of one
    /// prior expansion share a set, so the union is memoized per
    /// distinct source id.
    fn hs_add_all(&mut self, toks: &mut [Tok], hs: u32) {
        if hs == 0 {
            return;
        }
        let mut memo: Vec<(u32, u32)> = Vec::new();
        for t in toks {
            let consulted = t.kind == TokKind::Ident
                || (t.kind == TokKind::Punct
                    && t.end - t.start == 1
                    && self.first_byte(*t) == b')');
            if !consulted {
                continue;
            }
            t.hs = if t.hs == 0 {
                hs
            } else if t.hs == hs {
                hs
            } else {
                match memo.iter().find(|(k, _)| *k == t.hs) {
                    Some((_, u)) => *u,
                    None => {
                        let u = hs_union(self.set(t.hs), self.set(hs));
                        let id = self.intern_set(Rc::new(u));
                        memo.push((t.hs, id));
                        id
                    }
                }
            };
        }
    }

    /// Render tokens back to text: one space where the source had
    /// white space, plus a separating space wherever two adjacent
    /// tokens would otherwise re-lex as one (C99 6.10.3.3 reserves
    /// pasting for `##`).
    fn serialize_into(&self, toks: &[Tok], out: &mut String) {
        let mut cap = toks.len();
        for &t in toks {
            cap += (t.end - t.start) as usize;
        }
        out.reserve(cap);
        let first_at = out.len();
        for &t in toks {
            if out.len() > first_at
                && (t.space
                    || pp_tokens_would_merge(*out.as_bytes().last().unwrap(), self.first_byte(t)))
            {
                out.push(' ');
            }
            out.push_str(self.text(t));
        }
    }

    /// Paste two tokens (C99 6.10.3.3). The concatenation is re-lexed:
    /// a valid paste yields one token; anything else keeps the
    /// re-lexed pieces, matching a textual rescan of the joined
    /// spelling.
    fn glue(&mut self, left: Tok, right: Tok) -> Vec<Tok> {
        let mut text =
            String::with_capacity(((left.end - left.start) + (right.end - right.start)) as usize);
        text.push_str(self.text(left));
        text.push_str(self.text(right));
        let buf = self.add_buf(Rc::from(text));
        let mut toks = Vec::new();
        lex_into(&self.ar.bufs[buf as usize].clone(), buf, &mut toks);
        if let Some(f) = toks.first_mut() {
            f.space = left.space;
        }
        toks
    }

    /// `#param` (C99 6.10.3.2): the argument's spelling as a string
    /// literal, interior white space collapsed to single spaces, `\`
    /// and `"` escaped within character constants and string literals.
    fn stringize(&mut self, toks: &[Tok], space: bool) -> Tok {
        let mut s = String::from("\"");
        let mut first = true;
        for &t in toks {
            if !first && t.space {
                s.push(' ');
            }
            let text = self.text(t);
            if matches!(t.kind, TokKind::Str | TokKind::Char) {
                for c in text.chars() {
                    match c {
                        '"' => s.push_str("\\\""),
                        '\\' => s.push_str("\\\\"),
                        _ => s.push(c),
                    }
                }
            } else {
                s.push_str(text);
            }
            first = false;
        }
        s.push('"');
        self.synth(s, TokKind::Str, space)
    }

    /// The variadic tail (C99 6.10.3.1p2): arguments past the named
    /// parameters joined with commas, each expanded when `expand` is
    /// set (the plain-position form) or spliced raw (`#`/`##`
    /// operands).
    fn join_va(
        &mut self,
        raw_args: &[Vec<Tok>],
        nfixed: usize,
        expand: bool,
        depth: usize,
    ) -> Vec<Tok> {
        let mut v: Vec<Tok> = Vec::new();
        for (k, a) in raw_args.iter().enumerate().skip(nfixed) {
            if k > nfixed {
                let comma = self.synth(",".to_string(), TokKind::Punct, false);
                v.push(comma);
            }
            let mut e = if expand {
                self.expand_tokens(a.clone(), depth + 1)
            } else {
                a.clone()
            };
            if let Some(first) = e.first_mut() {
                first.space = k > nfixed;
            }
            v.append(&mut e);
        }
        v
    }

    /// Parse an argument list from the scan stack (`rest` is
    /// reversed; its last element is the `(`). Returns the arguments
    /// (depth-1 commas dropped) and the closing paren's hideset, or
    /// `None` -- consuming nothing -- when the parens don't close
    /// (C99 6.10.3p10: the name alone is not an invocation).
    fn scan_args(&self, rest: &mut Vec<Tok>) -> Option<(Vec<Vec<Tok>>, u32)> {
        // Find the extent first (no copies), then move the tokens out.
        let n = rest.len();
        let mut depth = 1usize;
        let mut k = n.checked_sub(2)?;
        let close = loop {
            let t = rest[k];
            if t.kind == TokKind::Punct && t.end - t.start == 1 {
                match self.first_byte(t) {
                    b'(' => depth += 1,
                    b')' => {
                        depth -= 1;
                        if depth == 0 {
                            break k;
                        }
                    }
                    _ => {}
                }
            }
            if k == 0 {
                return None;
            }
            k -= 1;
        };
        let rp_hs = rest[close].hs;
        // `tail` holds `( args... )` in reverse; pop to walk forward.
        let mut tail = rest.split_off(close);
        tail.pop(); // the `(`
        let mut args: Vec<Vec<Tok>> = Vec::new();
        let mut cur: Vec<Tok> = Vec::new();
        let mut depth = 1usize;
        while let Some(t) = tail.pop() {
            if t.kind == TokKind::Punct && t.end - t.start == 1 {
                match self.first_byte(t) {
                    b'(' => depth += 1,
                    b')' => {
                        depth -= 1;
                        if depth == 0 {
                            break;
                        }
                    }
                    b',' if depth == 1 => {
                        args.push(core::mem::take(&mut cur));
                        continue;
                    }
                    _ => {}
                }
            }
            cur.push(t);
        }
        args.push(cur);
        Some((args, rp_hs))
    }

    /// The macro body's tokens mapped into this arena.
    fn body_toks(&mut self, name: &str, body: &str) -> Vec<Tok> {
        let (bbuf, toks) = self.pp.cached_body(name, body);
        let bid = self.buf_id(&bbuf);
        let mut out = self.take_vec();
        out.reserve(toks.len());
        out.extend(toks.iter().map(|t| Tok { buf: bid, ..*t }));
        out
    }

    /// The C99 6.10.3.4 scan: pop the next token; a live macro name
    /// substitutes and its result is pushed back for rescanning, so
    /// chained and nested expansions need no special cases. Hidden
    /// names (their own expansion in flight) pass through verbatim.
    fn expand_tokens(&mut self, toks: Vec<Tok>, depth: usize) -> Vec<Tok> {
        // Bound the argument-expansion recursion; past the bound the
        // tokens pass through unexpanded rather than overflowing the
        // native stack.
        if depth > MAX_MACRO_DEPTH {
            return toks;
        }
        let pp = self.pp;
        let mut rest = toks;
        rest.reverse();
        let mut out: Vec<Tok> = self.take_vec();
        out.reserve(rest.len());
        while let Some(tok) = rest.pop() {
            if tok.kind != TokKind::Ident {
                out.push(tok);
                continue;
            }
            // Dynamic predefines all start with `_`; then the registry
            // probe -- most identifiers are neither, and only macro
            // names need the hideset check.
            if self.first_byte(tok) == b'_' && self.dynamic_predefine(tok, &mut out) {
                continue;
            }
            let (is_fn, is_obj) = {
                let name = self.text(tok);
                (
                    pp.fn_macros.contains_key(name),
                    pp.macros.contains_key(name),
                )
            };
            if !is_fn && !is_obj {
                out.push(tok);
                continue;
            }
            // The name outlives the arena mutations below.
            let nbuf = self.ar.bufs[tok.buf as usize].clone();
            let name = &nbuf[tok.start as usize..tok.end as usize];
            if self.hs_contains(tok.hs, name) {
                out.push(tok);
                continue;
            }
            if is_fn {
                let def = pp.fn_macros.get(name).unwrap();
                // Function-like: an invocation only when `(` follows
                // (C99 6.10.3p10) and closes within the line.
                if rest.last().is_some_and(|&t| self.is_punct(t, "(")) {
                    if let Some((raw_args, rp_hs)) = self.scan_args(&mut rest) {
                        pp.check_macro_arity(name, def, &raw_args, self.filename, self.line_no);
                        let common = self.hs_intersect(tok.hs, rp_hs);
                        let inv = self.hs_with_name(common, name);
                        let mut sub = self.subst(name, def, &raw_args, inv, depth);
                        if let Some(f) = sub.first_mut() {
                            f.space = tok.space;
                        }
                        sub.reverse();
                        rest.append(&mut sub);
                        self.put_vec(sub);
                        continue;
                    }
                }
                out.push(tok);
                continue;
            }
            let body = pp.macros.get(name).unwrap();
            let hs = self.hs_with_name(tok.hs, name);
            let mut btoks = self.body_toks(name, body);
            self.hs_add_all(&mut btoks, hs);
            if let Some(f) = btoks.first_mut() {
                f.space = tok.space;
            }
            btoks.reverse();
            rest.append(&mut btoks);
            self.put_vec(btoks);
        }
        self.put_vec(rest);
        out
    }

    /// C99 6.10.8 dynamic predefines (plus the `__COUNTER__`
    /// extension); true when `tok` was one and its expansion pushed.
    fn dynamic_predefine(&mut self, tok: Tok, out: &mut Vec<Tok>) -> bool {
        let (line_no, filename) = (self.line_no, self.filename);
        match self.text(tok) {
            "__LINE__" => {
                let t = self.synth(format!("{line_no}"), TokKind::Number, tok.space);
                out.push(t);
            }
            "__FILE__" => {
                let t = self.synth(format!("\"{filename}\""), TokKind::Str, tok.space);
                out.push(t);
            }
            // Extension: each use expands to the next integer.
            "__COUNTER__" => {
                let n = self.pp.counter.get();
                self.pp.counter.set(n + 1);
                let t = self.synth(format!("{n}"), TokKind::Number, tok.space);
                out.push(t);
            }
            _ => return false,
        }
        true
    }

    /// Replacement-list substitution (C99 6.10.3.1-6.10.3.3): `#` and
    /// `##` operands read the unexpanded argument, ordinary parameter
    /// positions read the argument expanded once (memoized, moved on
    /// the last use), an empty argument is a placemarker for adjacent
    /// `##`. The invocation hideset is added to the whole result.
    fn subst(
        &mut self,
        name: &str,
        def: &FnMacro,
        raw_args: &[Vec<Tok>],
        inv_hs: u32,
        depth: usize,
    ) -> Vec<Tok> {
        let body = self.body_toks(name, &def.body);
        let nfixed = def.params.len();

        let raw_va: Vec<Tok> = if def.is_variadic {
            self.join_va(raw_args, nfixed, false, depth)
        } else {
            Vec::new()
        };
        let mut exp_args: Vec<Option<Vec<Tok>>> = raw_args.iter().map(|_| None).collect();
        let mut exp_va: Option<Vec<Tok>> = None;

        // Plain-position use count per parameter: the memoized
        // expansion is moved out on its last use instead of cloned
        // (arguments can be huge).
        let mut plain_uses: Vec<u32> = alloc::vec![0; raw_args.len()];
        for (bi, &bt) in body.iter().enumerate() {
            if bt.kind == TokKind::Ident
                && !body.get(bi + 1).is_some_and(|&n| self.is_punct(n, "##"))
                && !(bi > 0
                    && (self.is_punct(body[bi - 1], "##") || self.is_punct(body[bi - 1], "#")))
                && let Some(idx) = self.param_index(def, bt)
                && idx < plain_uses.len()
            {
                plain_uses[idx] += 1;
            }
        }

        let mut out: Vec<Tok> = self.take_vec();
        out.reserve(body.len());
        // A parameter that substituted to nothing leaves a placemarker
        // (C99 6.10.3.3): a following `##` must not glue the token
        // before it to the right operand.
        let mut last_empty = false;
        let mut i = 0;
        while i < body.len() {
            let t = body[i];
            if self.is_punct(t, "#")
                && let Some(&next) = body.get(i + 1)
                && next.kind == TokKind::Ident
                && let Some(raw) = self.raw_of(def, raw_args, &raw_va, next)
            {
                let s = self.stringize(&raw, t.space);
                out.push(s);
                last_empty = false;
                i += 2;
                continue;
            }
            if self.is_punct(t, "##") {
                let Some(&next) = body.get(i + 1) else {
                    // A trailing `##` violates C99 6.10.3.3p1; drop it.
                    i += 2;
                    continue;
                };
                // GNU `, ## __VA_ARGS__`: an empty tail deletes the
                // comma; a non-empty tail keeps comma and tail.
                if self.is_va(def, next) && out.last().is_some_and(|&p| self.is_punct(p, ",")) {
                    if raw_va.is_empty() {
                        out.pop();
                    } else {
                        let va = match &exp_va {
                            Some(v) => v.clone(),
                            None => {
                                let v = self.join_va(raw_args, nfixed, true, depth);
                                exp_va = Some(v.clone());
                                v
                            }
                        };
                        splice(&mut out, va, true);
                    }
                    i += 2;
                    continue;
                }
                let right: Vec<Tok> = match self.raw_of(def, raw_args, &raw_va, next) {
                    Some(raw) => raw,
                    None => alloc::vec![next],
                };
                if right.is_empty() {
                    // `x ## <placemarker>`: x stays; a placemarker on
                    // the left survives a chain of empty pastes.
                    i += 2;
                    continue;
                }
                if last_empty {
                    // `<placemarker> ## x` is x.
                    splice(&mut out, right, false);
                } else if let Some(left) = out.pop() {
                    let mut glued = self.glue(left, right[0]);
                    out.append(&mut glued);
                    out.extend_from_slice(&right[1..]);
                } else {
                    splice(&mut out, right, false);
                }
                last_empty = false;
                i += 2;
                continue;
            }
            if t.kind == TokKind::Ident {
                let followed_by_paste = body.get(i + 1).is_some_and(|&n| self.is_punct(n, "##"));
                if self.is_va(def, t) {
                    let src = if followed_by_paste {
                        raw_va.clone()
                    } else {
                        match &exp_va {
                            Some(v) => v.clone(),
                            None => {
                                let v = self.join_va(raw_args, nfixed, true, depth);
                                exp_va = Some(v.clone());
                                v
                            }
                        }
                    };
                    last_empty = src.is_empty();
                    splice(&mut out, src, t.space);
                    i += 1;
                    continue;
                }
                if let Some(idx) = self.param_index(def, t) {
                    let src = if followed_by_paste {
                        raw_args.get(idx).cloned().unwrap_or_default()
                    } else if idx < raw_args.len() {
                        if exp_args[idx].is_none() {
                            let e = self.expand_tokens(raw_args[idx].clone(), depth + 1);
                            exp_args[idx] = Some(e);
                        }
                        plain_uses[idx] = plain_uses[idx].saturating_sub(1);
                        if plain_uses[idx] == 0 {
                            exp_args[idx].take().unwrap()
                        } else {
                            exp_args[idx].as_ref().unwrap().clone()
                        }
                    } else {
                        Vec::new()
                    };
                    last_empty = src.is_empty();
                    splice(&mut out, src, t.space);
                    i += 1;
                    continue;
                }
            }
            out.push(t);
            last_empty = false;
            i += 1;
        }
        self.hs_add_all(&mut out, inv_hs);
        self.put_vec(body);
        out
    }

    fn param_index(&self, def: &FnMacro, t: Tok) -> Option<usize> {
        let name = self.text(t);
        def.params.iter().position(|p| p == name)
    }

    fn is_va(&self, def: &FnMacro, t: Tok) -> bool {
        def.is_variadic && is_va_token(def, self.text(t))
    }

    /// Raw tokens when the ident is a parameter or the variadic tail;
    /// `None` for any other identifier.
    fn raw_of(
        &self,
        def: &FnMacro,
        raw_args: &[Vec<Tok>],
        raw_va: &[Tok],
        t: Tok,
    ) -> Option<Vec<Tok>> {
        if self.is_va(def, t) {
            Some(raw_va.to_vec())
        } else {
            self.param_index(def, t)
                .map(|idx| raw_args.get(idx).cloned().unwrap_or_default())
        }
    }
}

impl Preprocessor {
    /// The body's buffer and token list, lexed on first use per
    /// definition (token `buf` ids are 0; callers remap into their
    /// arena).
    fn cached_body(&self, name: &str, body: &str) -> (Rc<str>, Rc<Vec<Tok>>) {
        let mut cache = self.body_toks.borrow_mut();
        if let Some(c) = cache.get(name)
            && &*c.body == body
        {
            return (c.body.clone(), c.toks.clone());
        }
        let buf: Rc<str> = Rc::from(body);
        let mut toks = Vec::new();
        lex_into(&buf, 0, &mut toks);
        let toks = Rc::new(toks);
        cache.insert(
            name.to_string(),
            CachedBody {
                body: buf.clone(),
                toks: toks.clone(),
            },
        );
        (buf, toks)
    }

    /// The shared one-name hideset `{name}`.
    fn hs_singleton(&self, name: &str) -> Rc<Hideset> {
        let mut singles = self.hs_singletons.borrow_mut();
        if let Some(s) = singles.get(name) {
            return s.clone();
        }
        let s = Rc::new(Hideset {
            names: alloc::vec![Rc::from(name)],
        });
        singles.insert(name.to_string(), s.clone());
        s
    }

    /// Substitute every macro invocation in `line`. `filename` and
    /// `line_no` feed `__FILE__` / `__LINE__`, whose expansion changes
    /// per line and so can't live in the static macro table.
    pub(super) fn substitute(&self, line: &str, filename: &str, line_no: usize) -> String {
        if !self.line_mentions_macro(line) {
            return line.to_string();
        }
        let mut scratch = self.exp_scratch.borrow_mut();
        let mut ex = Exp::new(self, filename, line_no, &mut scratch);
        let bid = ex.add_buf(Rc::from(line));
        let mut toks = ex.take_vec();
        toks.reserve(line.len() / 4 + 4);
        lex_into(&ex.ar.bufs[bid as usize].clone(), bid, &mut toks);
        let expanded = ex.expand_tokens(toks, 0);
        // Keep the line's own indentation: warning echoes and `-E`
        // output quote it.
        let indent = &line[..line.len() - line.trim_start().len()];
        let mut out = String::from(indent);
        ex.serialize_into(&expanded, &mut out);
        ex.put_vec(expanded);
        out
    }

    /// Pre-scan: most lines name no macro at all, and copying them
    /// through verbatim skips the lex / serialize round trip (and
    /// keeps their original spacing).
    fn line_mentions_macro(&self, line: &str) -> bool {
        let bytes = line.as_bytes();
        let mut i = 0;
        while i < bytes.len() {
            let c = bytes[i];
            if let Some(plen) = literal_prefix_len(bytes, i) {
                i = skip_literal(bytes, i + plen);
                continue;
            }
            if c == b'"' || c == b'\'' {
                i = skip_literal(bytes, i);
                continue;
            }
            let np = pp_number_len(bytes, i);
            if np > 0 {
                i += np;
                continue;
            }
            if c.is_ascii_alphabetic() || c == b'_' {
                let start = i;
                i += 1;
                while i < bytes.len() && is_ident_byte(bytes[i]) {
                    i += 1;
                }
                let ident = &line[start..i];
                if matches!(ident, "__LINE__" | "__FILE__" | "__COUNTER__")
                    || self.macros.contains_key(ident)
                    || self.fn_macros.contains_key(ident)
                {
                    return true;
                }
                continue;
            }
            i += 1;
        }
        false
    }

    /// C99 6.10.3p4: the invocation's argument count must match the
    /// macro's parameter count; record a diagnostic on a mismatch.
    pub(super) fn check_macro_arity(
        &self,
        name: &str,
        def: &FnMacro,
        args: &[Vec<Tok>],
        filename: &str,
        line_no: usize,
    ) {
        if macro_arg_count_ok(def, args) {
            return;
        }
        let want = def.params.len();
        let got = args.len();
        let plural = |n: usize| if n == 1 { "" } else { "s" };
        let msg = if def.is_variadic {
            format!(
                "macro `{name}` requires at least {want} argument{}, but {got} given",
                plural(want)
            )
        } else if got > want {
            format!(
                "macro `{name}` passed {got} argument{}, but takes just {want}",
                plural(got)
            )
        } else {
            format!(
                "macro `{name}` requires {want} argument{}, but only {got} given",
                plural(want)
            )
        };
        self.record_pp_error(crate::c5::error::C5Error::Compile(
            crate::c5::error::fmt_compile_err(filename, line_no, &msg),
        ));
    }

    /// Iteratively expand a single identifier through the macro
    /// table. Returns `None` if `name` isn't a macro at all -- this is
    /// the fast path for the common case (the source has way more
    /// non-macro identifiers than macro hits) and lets callers skip
    /// allocating a String just to compare it back against the input.
    pub(super) fn expand(&self, name: &str) -> Option<String> {
        self.expand_chain(name).map(|(body, _)| body)
    }

    /// `expand` plus the chain of intermediate macro names the walk
    /// passed through. A revisited name ends the walk.
    pub(super) fn expand_chain(&self, name: &str) -> Option<(String, Vec<String>)> {
        let first = self.macros.get(name)?;
        let mut chain: Vec<String> = Vec::new();
        let mut current = first.clone();
        while chain.len() < 32 {
            if current == name || chain.iter().any(|c| c == &current) {
                break;
            }
            match self.macros.get(&current) {
                Some(next) => {
                    chain.push(core::mem::replace(&mut current, next.clone()));
                }
                None => break,
            }
        }
        Some((current, chain))
    }

    /// `expand` but with the original name returned (allocated as a
    /// String) when nothing matched. Used by the `#if` evaluator,
    /// which runs rarely and prefers the simpler "always have a
    /// String" shape.
    pub(super) fn expand_or_self(&self, name: &str) -> String {
        self.expand(name).unwrap_or_else(|| name.to_string())
    }
}

/// True when `prev` directly followed by `next` would re-lex as part
/// of a single preprocessing token even though the two bytes end and
/// begin distinct tokens. The serializer inserts one space at such
/// boundaries -- whitespace between tokens never changes phase-7
/// semantics -- so substituted text cannot paste onto its neighbors
/// (C99 6.10.3.3 reserves pasting for `##`).
pub(super) fn pp_tokens_would_merge(prev: u8, next: u8) -> bool {
    if is_ident_byte(prev) && is_ident_byte(next) {
        return true;
    }
    (prev == b'.' && next.is_ascii_digit())
        || matches!(
            (prev, next),
            (b'-', b'-' | b'>' | b'=')
                | (b'+', b'+' | b'=')
                | (b'<', b'<' | b'=' | b':' | b'%')
                | (b'>', b'>' | b'=')
                | (b'&', b'&' | b'=')
                | (b'|', b'|' | b'=')
                | (b'=' | b'!' | b'*' | b'^', b'=')
                | (b'/', b'/' | b'*' | b'=')
                | (b'%', b'=' | b'>' | b':')
                | (b'#', b'#')
                | (b':', b'>')
                | (b'.', b'.')
                | (b'e' | b'E' | b'p' | b'P', b'+' | b'-')
        )
}

/// Incremental joiner state: decides whether the logical line still
/// needs the next source line appended -- a function-like invocation
/// whose `)` has not arrived yet, or a candidate macro name at the
/// end of the buffer whose `(` may open the next line (C99 6.10.3:
/// white space, including newlines, may separate the name from its
/// `(`). Feeding only the appended bytes keeps a many-thousand-line
/// argument list linear; re-scanning the grown buffer per joined
/// line is quadratic in the invocation length.
pub(super) struct JoinScan {
    /// Paren depth of the open invocation; 0 = none open.
    depth: usize,
    /// Quote byte of the literal open inside the invocation, else 0.
    quote: u8,
    /// The buffer ends with a candidate name plus optional white
    /// space; only a following `(` makes it an invocation.
    pending: bool,
}

impl JoinScan {
    pub(super) fn new() -> Self {
        JoinScan {
            depth: 0,
            quote: 0,
            pending: false,
        }
    }

    /// An invocation's argument list is still open.
    pub(super) fn unclosed(&self) -> bool {
        self.depth > 0
    }

    /// A candidate name ends the buffer; join if `(` opens the next
    /// line.
    pub(super) fn pending_head(&self) -> bool {
        self.pending
    }

    /// Advance the scan over newly appended text.
    pub(super) fn feed(
        &mut self,
        text: &str,
        fn_macros: &HashMap<String, FnMacro>,
        obj_macros: &HashMap<String, String>,
    ) {
        let bytes = text.as_bytes();
        let mut i = 0;
        loop {
            if self.depth > 0 {
                // Inside `( ...`: literal-aware paren counting.
                while i < bytes.len() {
                    let c = bytes[i];
                    if self.quote != 0 {
                        if c == b'\\' && i + 1 < bytes.len() {
                            i += 2;
                            continue;
                        }
                        if c == self.quote {
                            self.quote = 0;
                        }
                        i += 1;
                        continue;
                    }
                    match c {
                        b'"' | b'\'' => {
                            self.quote = c;
                            i += 1;
                        }
                        b'(' => {
                            self.depth += 1;
                            i += 1;
                        }
                        b')' => {
                            self.depth -= 1;
                            i += 1;
                            if self.depth == 0 {
                                break;
                            }
                        }
                        _ => i += 1,
                    }
                }
                if self.depth > 0 {
                    self.pending = false;
                    return;
                }
            }
            if self.pending {
                while i < bytes.len() && bytes[i].is_ascii_whitespace() {
                    i += 1;
                }
                if i >= bytes.len() {
                    return;
                }
                self.pending = false;
                if bytes[i] == b'(' {
                    self.depth = 1;
                    i += 1;
                    continue;
                }
            }
            // Find the next candidate invocation head.
            while i < bytes.len() {
                let c = bytes[i];
                if c == b'"' || c == b'\'' {
                    i = skip_literal(bytes, i);
                    continue;
                }
                // Skip a pp-number whole (C99 6.4.8) so its
                // identifier-shaped tail is not read as a head.
                let np = pp_number_len(bytes, i);
                if np > 0 {
                    i += np;
                    continue;
                }
                if c.is_ascii_alphabetic() || c == b'_' {
                    let start = i;
                    i += 1;
                    while i < bytes.len() && is_ident_byte(bytes[i]) {
                        i += 1;
                    }
                    if !join_head(&text[start..i], fn_macros, obj_macros) {
                        continue;
                    }
                    let mut j = i;
                    while j < bytes.len() && bytes[j].is_ascii_whitespace() {
                        j += 1;
                    }
                    if j >= bytes.len() {
                        self.pending = true;
                        return;
                    }
                    if bytes[j] == b'(' {
                        self.depth = 1;
                        i = j + 1;
                        break;
                    }
                    continue;
                }
                i += 1;
            }
            if self.depth == 0 {
                return;
            }
        }
    }
}

/// A name that heads a joinable invocation: a function-like macro,
/// or an object-like macro whose single-identifier body is one (the
/// C99 6.10.3.4 rescan makes such an alias head a call whose
/// argument list may close on a later line).
fn join_head(
    name: &str,
    fn_macros: &HashMap<String, FnMacro>,
    obj_macros: &HashMap<String, String>,
) -> bool {
    if fn_macros.contains_key(name) {
        return true;
    }
    obj_macros
        .get(name)
        .map(|body| {
            let t = body.trim();
            !t.is_empty()
                && t.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'_')
                && t.bytes().next().is_some_and(|b| !b.is_ascii_digit())
                && fn_macros.contains_key(t)
        })
        .unwrap_or(false)
}

/// Cap on the argument-expansion nesting depth. Generous: real code
/// nests a few dozen levels at most, and past the cap the text is
/// left unexpanded rather than overflowing the native stack.
pub(super) const MAX_MACRO_DEPTH: usize = 200;

/// True when a body identifier names the variadic tail: the standard
/// `__VA_ARGS__`, or the GCC named-rest parameter (`#define foo(rest...)`
/// reaches the tail through `rest`).
pub(super) fn is_va_token(def: &FnMacro, word: &str) -> bool {
    word == "__VA_ARGS__" || def.va_name.as_deref() == Some(word)
}

/// C99 6.10.3p4 argument-count check. `m()` is one empty argument: it
/// satisfies a zero- or one-parameter macro.
pub(super) fn macro_arg_count_ok(def: &FnMacro, args: &[Vec<Tok>]) -> bool {
    let params = def.params.len();
    if def.is_variadic {
        args.len() >= params
    } else if params == 0 {
        args.len() == 1 && args[0].is_empty()
    } else {
        args.len() == params
    }
}

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

use alloc::borrow::Cow;
use alloc::format;
use alloc::rc::Rc;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::text::{
    MAX_LITERAL_PREFIX, is_ident_byte, literal_prefix_len, pp_number_len, skip_literal,
};
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

/// A file name spelled as a string literal, for `__FILE__` and
/// `__BASE_FILE__`. A name is arbitrary text, so it takes the escaping a
/// line marker's filename takes.
fn quoted_path(path: &str) -> String {
    let mut s = String::with_capacity(path.len() + 2);
    s.push('"');
    super::directive::push_string_body(path, &mut s);
    s.push('"');
    s
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
    /// A `##` occurs in the list, so expansion must run the paste pass.
    has_paste: bool,
}

/// The C99 6.4.6 punctuators badc lexes, longest first. `punct_len` and
/// the serializer's adjacency test both read this table, so a punctuator
/// added here cannot be missed by either.
const PUNCT3: [&[u8]; 3] = [b"<<=", b">>=", b"..."];
const PUNCT2: [&[u8]; 20] = [
    b"##", b"->", b"++", b"--", b"<<", b">>", b"<=", b">=", b"==", b"!=", b"&&", b"||", b"+=",
    b"-=", b"*=", b"/=", b"%=", b"&=", b"^=", b"|=",
];
const PUNCT1: &[u8] = b"()[]{},;:?~!%^&*-+=<>|/.#";

/// Byte pairs that are not badc punctuators yet still re-lex as one
/// token when written adjacent: the C99 6.4.6 digraphs, the two comment
/// openers (6.4.9), and the first two bytes of `...`. The serializer
/// separates them; nothing else consults the set.
const MERGE_ONLY2: [&[u8]; 8] = [b"<:", b":>", b"<%", b"%>", b"%:", b"//", b"/*", b".."];

/// Length of the punctuator starting at `at`, longest match first
/// (C99 6.4.6), or 0.
pub(super) fn punct_len(bytes: &[u8], at: usize) -> usize {
    let rest = &bytes[at..];
    if PUNCT3.iter().any(|p| rest.starts_with(p)) {
        return 3;
    }
    if PUNCT2.iter().any(|p| rest.starts_with(p)) {
        return 2;
    }
    if PUNCT1.contains(&rest[0]) { 1 } else { 0 }
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
            t.hs = if t.hs == 0 || t.hs == hs {
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
    /// white space. With `relex_safe`, also a separating space
    /// wherever two adjacent tokens would otherwise re-lex as one
    /// (C99 6.10.3.3 reserves pasting for `##`): output that is lexed
    /// again needs the separator, while a header-name operand keeps
    /// the spellings verbatim (C99 6.10.2p4).
    fn serialize_into(&self, toks: &[Tok], out: &mut String, relex_safe: bool) {
        let mut cap = toks.len();
        for &t in toks {
            cap += (t.end - t.start) as usize;
        }
        out.reserve(cap);
        let first_at = out.len();
        let mut prev_kind = TokKind::Other;
        let mut prev_text: &[u8] = b"";
        for &t in toks {
            let text = self.text(t);
            if out.len() > first_at
                && (t.space
                    || (relex_safe
                        && pp_tokens_would_merge(prev_kind, prev_text, self.first_byte(t))))
            {
                out.push(' ');
            }
            out.push_str(text);
            prev_kind = t.kind;
            prev_text = text.as_bytes();
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

    /// C99 6.10.3.3p2 pasting over a replacement list with no
    /// parameters: each `##` is deleted and the tokens either side are
    /// concatenated, left to right. A `##` at either end of the list
    /// violates 6.10.3.3p1 and has no operand to join, so it is
    /// dropped.
    fn paste_run(&mut self, toks: Vec<Tok>) -> Vec<Tok> {
        let mut out: Vec<Tok> = self.take_vec();
        out.reserve(toks.len());
        let mut i = 0;
        while i < toks.len() {
            let t = toks[i];
            if !self.is_punct(t, "##") {
                out.push(t);
                i += 1;
                continue;
            }
            match (out.pop(), toks.get(i + 1).copied()) {
                (Some(left), Some(right)) => {
                    let mut glued = self.glue(left, right);
                    out.append(&mut glued);
                    i += 2;
                }
                (left, _) => {
                    if let Some(l) = left {
                        out.push(l);
                    }
                    i += 1;
                }
            }
        }
        self.put_vec(toks);
        out
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
                super::directive::push_string_body(text, &mut s);
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
        sep_space: &[bool],
        nfixed: usize,
        expand: bool,
        depth: usize,
    ) -> Vec<Tok> {
        let mut v: Vec<Tok> = Vec::new();
        for (k, a) in raw_args.iter().enumerate().skip(nfixed) {
            if k > nfixed {
                let sp = sep_space.get(k - 1).copied().unwrap_or(false);
                let comma = self.synth(",".to_string(), TokKind::Punct, sp);
                v.push(comma);
            }
            let mut e = if expand {
                self.expand_tokens(a.clone(), depth + 1)
            } else {
                a.clone()
            };
            // C99 6.10.3.2p2: stringization keeps the argument's spelling,
            // so the space after the joining comma is the source's own --
            // `f(a,b)` stringizes to "a,b", `f(a, b)` to "a, b".
            let lexed = a.first().map(|t| t.space).unwrap_or(k > nfixed);
            if let Some(first) = e.first_mut() {
                first.space = lexed;
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
    fn scan_args(&self, rest: &mut Vec<Tok>) -> Option<(Vec<Vec<Tok>>, Vec<bool>, u32)> {
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
        // Each separating comma's own leading-space flag: stringizing a
        // variadic tail keeps the source spelling around the commas too.
        let mut seps: Vec<bool> = Vec::new();
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
                        seps.push(t.space);
                        continue;
                    }
                    _ => {}
                }
            }
            cur.push(t);
        }
        args.push(cur);
        Some((args, seps, rp_hs))
    }

    /// The macro body's tokens mapped into this arena, and whether the
    /// list contains a `##`.
    fn body_toks(&mut self, name: &str, body: &str) -> (Vec<Tok>, bool) {
        let (bbuf, toks, has_paste) = self.pp.cached_body(name, body);
        let bid = self.buf_id(&bbuf);
        let mut out = self.take_vec();
        out.reserve(toks.len());
        out.extend(toks.iter().map(|t| Tok { buf: bid, ..*t }));
        (out, has_paste)
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
            if self.first_byte(tok) == b'_'
                && (self.dynamic_predefine(tok, &mut out)
                    || self.has_operator(tok, &mut rest, &mut out))
            {
                continue;
            }
            let (is_fn, is_obj) = {
                let name = self.text(tok);
                pp.obs_note(name);
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
                if rest.last().is_some_and(|&t| self.is_punct(t, "("))
                    && let Some((raw_args, sep_space, rp_hs)) = self.scan_args(&mut rest)
                {
                    pp.check_macro_arity(name, def, &raw_args, self.filename, self.line_no);
                    let common = self.hs_intersect(tok.hs, rp_hs);
                    let inv = self.hs_with_name(common, name);
                    let mut sub = self.subst(name, def, &raw_args, &sep_space, inv, depth);
                    if let Some(f) = sub.first_mut() {
                        f.space = tok.space;
                    }
                    sub.reverse();
                    rest.append(&mut sub);
                    self.put_vec(sub);
                    continue;
                }
                out.push(tok);
                continue;
            }
            let body = pp.macros.get(name).unwrap();
            let hs = self.hs_with_name(tok.hs, name);
            let (mut btoks, has_paste) = self.body_toks(name, body);
            if has_paste {
                btoks = self.paste_run(btoks);
            }
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
    /// Its name set is `is_dynamic_predefine`, which the pre-scan in
    /// `line_mentions_macro` shares -- a name in one and not the other
    /// would never reach the expander.
    fn dynamic_predefine(&mut self, tok: Tok, out: &mut Vec<Tok>) -> bool {
        let (line_no, filename) = (self.line_no, self.filename);
        if !is_dynamic_predefine(self.text(tok)) {
            return false;
        }
        match self.text(tok) {
            "__LINE__" => {
                let t = self.synth(format!("{line_no}"), TokKind::Number, tok.space);
                out.push(t);
            }
            "__FILE__" => {
                let t = self.synth(quoted_path(filename), TokKind::Str, tok.space);
                out.push(t);
            }
            // The main input file, so it keeps its value inside an
            // include where `__FILE__` names the header.
            "__BASE_FILE__" => {
                let base = self.pp.source_label.clone();
                let t = self.synth(quoted_path(&base), TokKind::Str, tok.space);
                out.push(t);
            }
            // Extension: each use expands to the next integer.
            "__COUNTER__" => {
                self.pp.obs_note_counter();
                let n = self.pp.counter.get();
                self.pp.counter.set(n + 1);
                let t = self.synth(format!("{n}"), TokKind::Number, tok.space);
                out.push(t);
            }
            // `is_dynamic_predefine` already admitted the name, so a
            // miss here means the two drifted.
            other => unreachable!("no expansion for dynamic predefine `{other}`"),
        }
        true
    }

    /// The `__has_*` feature-test operators, which expand wherever they
    /// appear rather than only in a conditional, so an ordinary expression
    /// can test a capability. `rest` is the reversed pending stream, so the
    /// `( identifier )` that follows sits at its tail; an operator name not
    /// followed by that shape is left alone for the caller to pass through.
    /// The verdict is the one the conditional path reports.
    fn has_operator(&mut self, tok: Tok, rest: &mut Vec<Tok>, out: &mut Vec<Tok>) -> bool {
        let known: fn(&str) -> bool = match self.text(tok) {
            "__has_builtin" => super::builtins::has_builtin,
            "__has_attribute" => super::cond::is_known_attribute,
            _ => return false,
        };
        let n = rest.len();
        if n < 3 {
            return false;
        }
        let (open, arg, close) = (rest[n - 1], rest[n - 2], rest[n - 3]);
        if self.text(open) != "(" || arg.kind != TokKind::Ident || self.text(close) != ")" {
            return false;
        }
        let verdict = known(self.text(arg));
        rest.truncate(n - 3);
        let t = self.synth(
            (if verdict { "1" } else { "0" }).to_string(),
            TokKind::Number,
            tok.space,
        );
        out.push(t);
        true
    }

    /// Whether the body token at `at` sits in a plain parameter
    /// position: neither operand of `##` nor the operand of `#` (C99
    /// 6.10.3.1p1), so a parameter there substitutes its argument after
    /// expansion. Read both by the plain-use pre-count and by the
    /// substitution loop, so the two cannot disagree.
    fn plain_position(&self, body: &[Tok], at: usize) -> bool {
        !body.get(at + 1).is_some_and(|&n| self.is_punct(n, "##"))
            && !(at > 0 && (self.is_punct(body[at - 1], "##") || self.is_punct(body[at - 1], "#")))
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
        sep_space: &[bool],
        inv_hs: u32,
        depth: usize,
    ) -> Vec<Tok> {
        let (mut body, _) = self.body_toks(name, &def.body);
        let nfixed = def.params.len();

        let raw_va: Vec<Tok> = if def.is_variadic {
            self.join_va(raw_args, sep_space, nfixed, false, depth)
        } else {
            Vec::new()
        };
        // Substring test first: it settles the question for every variadic
        // macro that does not use the construct without tokenized comparisons.
        if def.is_variadic && def.body.contains("__VA_OPT__") {
            body = self.expand_va_opt(body, def, raw_args, &raw_va);
        }
        let mut exp_args: Vec<Option<Vec<Tok>>> = raw_args.iter().map(|_| None).collect();
        let mut exp_va: Option<Vec<Tok>> = None;

        // Plain-position use count per parameter: the memoized
        // expansion is moved out on its last use instead of cloned
        // (arguments can be huge).
        let mut plain_uses: Vec<u32> = alloc::vec![0; raw_args.len()];
        for (bi, &bt) in body.iter().enumerate() {
            if bt.kind == TokKind::Ident
                && self.plain_position(&body, bi)
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
                // comma; a non-empty tail keeps comma and tail. The
                // tail is a `##` operand, so it is spliced unexpanded
                // (C99 6.10.3.1p1) and the rescan expands whatever
                // stays in a plain position.
                if self.is_va(def, next) && out.last().is_some_and(|&p| self.is_punct(p, ",")) {
                    if raw_va.is_empty() {
                        out.pop();
                    } else {
                        splice(&mut out, raw_va.clone(), true);
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
                let plain = self.plain_position(&body, i);
                if self.is_va(def, t) {
                    let src = if !plain {
                        raw_va.clone()
                    } else {
                        match &exp_va {
                            Some(v) => v.clone(),
                            None => {
                                let v = self.join_va(raw_args, sep_space, nfixed, true, depth);
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
                    let src = if !plain {
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

    /// C23 6.10.5.2 `__VA_OPT__ ( content )` in a variadic replacement list:
    /// the content when the variable arguments hold at least one token, a
    /// placemarker otherwise. The construct is resolved over the replacement
    /// list before substitution, so a surviving content goes through parameter
    /// substitution, `#` and `##` exactly as if written in its place. A
    /// placemarker is spelled by dropping an adjacent `##`, whose result is
    /// then its other operand; a preceding `#` stringizes the content after
    /// argument substitution, empty included.
    fn expand_va_opt(
        &mut self,
        body: Vec<Tok>,
        def: &FnMacro,
        raw_args: &[Vec<Tok>],
        raw_va: &[Tok],
    ) -> Vec<Tok> {
        if !body
            .iter()
            .any(|&t| t.kind == TokKind::Ident && self.text(t) == "__VA_OPT__")
        {
            return body;
        }
        let present = !raw_va.is_empty();
        let mut out: Vec<Tok> = self.take_vec();
        out.reserve(body.len());
        let mut i = 0;
        while i < body.len() {
            let t = body[i];
            if !(t.kind == TokKind::Ident
                && self.text(t) == "__VA_OPT__"
                && body.get(i + 1).is_some_and(|&n| self.is_punct(n, "(")))
            {
                out.push(t);
                i += 1;
                continue;
            }
            let mut depth = 0usize;
            let mut close = i + 1;
            while close < body.len() {
                if self.is_punct(body[close], "(") {
                    depth += 1;
                } else if self.is_punct(body[close], ")") {
                    depth -= 1;
                    if depth == 0 {
                        break;
                    }
                }
                close += 1;
            }
            if close >= body.len() {
                // Unbalanced: leave the tokens for the parser to reject.
                out.push(t);
                i += 1;
                continue;
            }
            let content = &body[i + 2..close];
            let mut next = close + 1;
            if out.last().is_some_and(|&p| self.is_punct(p, "#")) {
                let mut raw: Vec<Tok> = Vec::new();
                if present {
                    for &c in content {
                        match self.raw_of(def, raw_args, raw_va, c) {
                            Some(r) => raw.extend(r),
                            None => raw.push(c),
                        }
                    }
                }
                let s = self.stringize(&raw, t.space);
                out.pop();
                out.push(s);
            } else if present {
                let start = out.len();
                out.extend_from_slice(content);
                if let Some(first) = out.get_mut(start) {
                    first.space = t.space;
                }
            } else if out.last().is_some_and(|&p| self.is_punct(p, "##")) {
                out.pop();
            } else if body.get(next).is_some_and(|&n| self.is_punct(n, "##")) {
                next += 1;
            }
            i = next;
        }
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
    fn cached_body(&self, name: &str, body: &str) -> (Rc<str>, Rc<Vec<Tok>>, bool) {
        let mut cache = self.body_toks.borrow_mut();
        if let Some(c) = cache.get(name)
            && &*c.body == body
        {
            return (c.body.clone(), c.toks.clone(), c.has_paste);
        }
        let buf: Rc<str> = Rc::from(body);
        let mut toks = Vec::new();
        lex_into(&buf, 0, &mut toks);
        let has_paste = toks
            .iter()
            .any(|t| t.kind == TokKind::Punct && &buf[t.start as usize..t.end as usize] == "##");
        let toks = Rc::new(toks);
        cache.insert(
            name.to_string(),
            CachedBody {
                body: buf.clone(),
                toks: toks.clone(),
                has_paste,
            },
        );
        (buf, toks, has_paste)
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
    pub(super) fn substitute<'l>(
        &self,
        line: &'l str,
        filename: &str,
        line_no: usize,
    ) -> Cow<'l, str> {
        self.substitute_serialized(line, filename, line_no, true)
    }

    /// [`Self::substitute`] for a header-name operand (`#include` /
    /// `__has_include` with pp-token form): spellings joined with a
    /// space only where the source had white space. The re-lex
    /// separators `substitute` inserts would land in the header name:
    /// a digit-leading file name such as `1x.h` arrives as the tokens
    /// `1x` `.` `h`, and only their verbatim concatenation names the
    /// file (C99 6.10.2p4).
    pub(super) fn substitute_spelling<'l>(
        &self,
        line: &'l str,
        filename: &str,
        line_no: usize,
    ) -> Cow<'l, str> {
        self.substitute_serialized(line, filename, line_no, false)
    }

    fn substitute_serialized<'l>(
        &self,
        line: &'l str,
        filename: &str,
        line_no: usize,
        relex_safe: bool,
    ) -> Cow<'l, str> {
        if !self.line_mentions_macro(line) {
            return Cow::Borrowed(line);
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
        ex.serialize_into(&expanded, &mut out, relex_safe);
        ex.put_vec(expanded);
        Cow::Owned(out)
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
                self.obs_note(ident);
                if is_dynamic_predefine(ident)
                    || matches!(ident, "__has_builtin" | "__has_attribute")
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

    /// C99 6.10.3.3p1: `##` shall not occur at the beginning or at the
    /// end of a replacement list, for either form of macro definition.
    /// A leading `##` spells `##` and a trailing one ends in `#`, so
    /// the two text tests are necessary conditions and only a body
    /// passing one of them is lexed.
    pub(super) fn check_paste_placement(
        &self,
        name: &str,
        body: &str,
        filename: &str,
        line_no: usize,
    ) {
        if !body.starts_with("##") && !body.ends_with('#') {
            return;
        }
        let mut toks = Vec::new();
        lex_into(body, 0, &mut toks);
        let is_paste = |t: Option<&Tok>| {
            t.is_some_and(|t| {
                t.kind == TokKind::Punct && &body[t.start as usize..t.end as usize] == "##"
            })
        };
        if !is_paste(toks.first()) && !is_paste(toks.last()) {
            return;
        }
        let msg = format!("`##` cannot appear at either end of the replacement list of `{name}`");
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
        self.obs_note(name);
        let first = self.macros.get(name)?;
        let mut chain: Vec<String> = Vec::new();
        let mut current = first.clone();
        while chain.len() < 32 {
            if current == name || chain.iter().any(|c| c == &current) {
                break;
            }
            self.obs_note(&current);
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

/// Names `dynamic_predefine` expands from context rather than from the
/// macro table.
pub(super) fn is_dynamic_predefine(name: &str) -> bool {
    matches!(
        name,
        "__LINE__" | "__FILE__" | "__BASE_FILE__" | "__COUNTER__"
    )
}

/// True when the token spelled `prev` directly followed by a token
/// starting with `next` would re-lex as one preprocessing token. The
/// serializer inserts one space at such boundaries -- white space
/// between tokens never changes phase-7 semantics -- so substituted text
/// cannot paste onto its neighbours (C99 6.10.3.3 reserves pasting for
/// `##`). `prev_kind` is the preceding token's kind, which decides
/// whether the pp-number and encoding-prefix rules apply.
///
/// Every case is read off a token-grammar rule rather than listed:
/// identifier and pp-number continuation (6.4.2.1 / 6.4.8), the
/// encoding prefixes `literal_prefix_len` accepts (6.4.4.4 / 6.4.5),
/// the punctuator table `punct_len` matches, and the merge-only pairs.
pub(super) fn pp_tokens_would_merge(prev_kind: TokKind, prev: &[u8], next: u8) -> bool {
    let Some(&last) = prev.last() else {
        return false;
    };
    if is_ident_byte(last) && is_ident_byte(next) {
        return true;
    }
    // 6.4.4.4 / 6.4.5: an identifier spelled exactly as an encoding
    // prefix takes a directly following quote into one literal token.
    if prev_kind == TokKind::Ident && prev.len() <= MAX_LITERAL_PREFIX {
        let mut probe = [0u8; MAX_LITERAL_PREFIX + 1];
        probe[..prev.len()].copy_from_slice(prev);
        probe[prev.len()] = next;
        if literal_prefix_len(&probe[..=prev.len()], 0) == Some(prev.len()) {
            return true;
        }
    }
    // 6.4.8: a pp-number runs on through `.` and through a sign after an
    // exponent marker, so only a preceding pp-number merges with those.
    if prev_kind == TokKind::Number
        && (next == b'.'
            || (matches!(last, b'e' | b'E' | b'p' | b'P') && matches!(next, b'+' | b'-')))
    {
        return true;
    }
    let pair = [last, next];
    // A `.` before a digit opens a pp-number.
    if last == b'.' && pp_number_len(&pair, 0) == 2 {
        return true;
    }
    punct_len(&pair, 0) == 2 || MERGE_ONLY2.iter().any(|p| *p == pair)
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
    pub(super) fn feed(&mut self, text: &str, pp: &Preprocessor) {
        let bytes = text.as_bytes();
        let mut i = 0;
        loop {
            if self.depth > 0 {
                // Inside `( ...`: literal-aware paren counting.
                while i < bytes.len() {
                    let c = bytes[i];
                    if self.quote != 0 {
                        // A literal is bounded by its line, as in `skip_literal`,
                        // so an unterminated quote cannot swallow the `)`.
                        if c == b'\\' && i + 1 < bytes.len() && bytes[i + 1] != b'\n' {
                            i += 2;
                            continue;
                        }
                        if c == self.quote || c == b'\n' {
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
                    if !join_head(&text[start..i], pp) {
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

/// A name that heads a joinable invocation: a function-like macro, or an
/// object-like macro whose replacement list *ends* in one. C99 6.10.3.4p1
/// rescans the replacement list together with the tokens that follow, so
/// it is the name ending the list that meets the `(` -- which may be on a
/// later line (`#define dprintk if (debug) printk`).
fn join_head(name: &str, pp: &Preprocessor) -> bool {
    let mut name = name;
    for _ in 0..MAX_MACRO_DEPTH {
        pp.obs_note(name);
        if pp.fn_macros.contains_key(name) {
            return true;
        }
        let Some(tail) = pp.macros.get(name).and_then(|b| trailing_identifier(b)) else {
            return false;
        };
        if tail == name {
            return false;
        }
        name = tail;
    }
    false
}

/// The identifier ending a macro replacement list, or `None` when the
/// list is empty or ends in punctuation, a literal, or a pp-number.
fn trailing_identifier(body: &str) -> Option<&str> {
    let body = body.trim_end();
    let bytes = body.as_bytes();
    let mut start = bytes.len();
    while start > 0 && is_ident_byte(bytes[start - 1]) {
        start -= 1;
    }
    if start == bytes.len() || bytes[start].is_ascii_digit() {
        return None;
    }
    Some(&body[start..])
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

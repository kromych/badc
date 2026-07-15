//! Macro expansion over preprocessing tokens (C99 6.10.3).
//!
//! A line is lexed once into [`Tok`]s; expansion follows the rescan
//! algorithm of C99 6.10.3.4 with a per-token hideset: a token
//! produced by a macro carries the set of macro names that may not
//! re-fire on it. Substituted output rejoins the scan stream, so a
//! result token that meets a `(` from the rest of the line forms a
//! new invocation, and self-referential definitions terminate without
//! any textual re-walk of already-expanded argument text.

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

/// One preprocessing token: a span of a shared buffer, its kind,
/// whether white space preceded it, and its hideset.
#[derive(Clone)]
pub(super) struct Tok {
    buf: Rc<str>,
    start: u32,
    end: u32,
    kind: TokKind,
    space: bool,
    hs: Option<Rc<Hideset>>,
}

impl Tok {
    fn text(&self) -> &str {
        &self.buf[self.start as usize..self.end as usize]
    }

    fn first_byte(&self) -> u8 {
        self.buf.as_bytes()[self.start as usize]
    }

    fn is(&self, s: &str) -> bool {
        self.text() == s
    }

    fn is_punct(&self, s: &str) -> bool {
        self.kind == TokKind::Punct && self.text() == s
    }
}

fn synth(text: String, kind: TokKind, space: bool) -> Tok {
    let end = text.len() as u32;
    Tok {
        buf: Rc::from(text),
        start: 0,
        end,
        kind,
        space,
        hs: None,
    }
}

/// Sorted macro-name set shared behind `Rc`: every token of one
/// substitution result points at the same set, so hideset updates
/// cost one union per expansion, not one per token.
pub(super) struct Hideset {
    names: Vec<Rc<str>>,
}

fn hs_contains(hs: &Option<Rc<Hideset>>, name: &str) -> bool {
    hs.as_ref()
        .is_some_and(|h| h.names.binary_search_by(|n| (**n).cmp(name)).is_ok())
}

fn hs_insert(hs: &Option<Rc<Hideset>>, name: &str) -> Rc<Hideset> {
    let mut names: Vec<Rc<str>> = match hs {
        None => Vec::with_capacity(1),
        Some(h) => h.names.clone(),
    };
    if let Err(at) = names.binary_search_by(|n| (**n).cmp(name)) {
        names.insert(at, Rc::from(name));
    }
    Rc::new(Hideset { names })
}

/// C99 6.10.3.4: a function-like invocation's new hideset is the
/// intersection of the name's and the closing paren's, plus the name.
fn hs_intersect(a: &Option<Rc<Hideset>>, b: &Option<Rc<Hideset>>) -> Option<Rc<Hideset>> {
    let (Some(a), Some(b)) = (a, b) else {
        return None;
    };
    let names: Vec<Rc<str>> = a
        .names
        .iter()
        .filter(|n| b.names.binary_search_by(|m| (**m).cmp(n)).is_ok())
        .cloned()
        .collect();
    if names.is_empty() {
        None
    } else {
        Some(Rc::new(Hideset { names }))
    }
}

fn hs_union(a: &Rc<Hideset>, b: &Rc<Hideset>) -> Rc<Hideset> {
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
    Rc::new(Hideset { names })
}

/// Union `hs` into every token's hideset. Tokens of one prior
/// expansion share a set, so the union is memoized per distinct
/// source set.
fn hs_add_all(toks: &mut [Tok], hs: &Rc<Hideset>) {
    let mut memo: Vec<(*const Hideset, Rc<Hideset>)> = Vec::new();
    for t in toks {
        let merged = match &t.hs {
            None => hs.clone(),
            Some(old) => {
                let key = Rc::as_ptr(old);
                match memo.iter().find(|(k, _)| *k == key) {
                    Some((_, u)) => u.clone(),
                    None => {
                        let u = hs_union(old, hs);
                        memo.push((key, u.clone()));
                        u
                    }
                }
            }
        };
        t.hs = Some(merged);
    }
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

fn lex_into(buf: &Rc<str>, out: &mut Vec<Tok>) {
    let bytes = buf.as_bytes();
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
            buf: buf.clone(),
            start: start as u32,
            end: i as u32,
            kind,
            space,
            hs: None,
        });
        space = false;
    }
}

/// Render tokens back to text: one space where the source had white
/// space, plus a separating space wherever two adjacent tokens would
/// otherwise re-lex as one (C99 6.10.3.3 reserves pasting for `##`).
fn serialize_into(toks: &[Tok], out: &mut String) {
    let mut cap = toks.len();
    for t in toks {
        cap += t.text().len();
    }
    out.reserve(cap);
    let first_at = out.len();
    for t in toks {
        if out.len() > first_at
            && (t.space || pp_tokens_would_merge(*out.as_bytes().last().unwrap(), t.first_byte()))
        {
            out.push(' ');
        }
        out.push_str(t.text());
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

/// Paste two tokens (C99 6.10.3.3). The concatenation is re-lexed: a
/// valid paste yields one token; anything else keeps the re-lexed
/// pieces, matching a textual rescan of the joined spelling.
fn glue_toks(left: &Tok, right: &Tok) -> Vec<Tok> {
    let mut text = String::with_capacity(left.text().len() + right.text().len());
    text.push_str(left.text());
    text.push_str(right.text());
    let buf: Rc<str> = Rc::from(text);
    let mut toks = Vec::new();
    lex_into(&buf, &mut toks);
    if let Some(f) = toks.first_mut() {
        f.space = left.space;
    }
    toks
}

/// `#param` (C99 6.10.3.2): the argument's spelling as a string
/// literal, interior white space collapsed to single spaces, `\` and
/// `"` escaped within character constants and string literals.
fn stringize_toks(toks: &[Tok], space: bool) -> Tok {
    let mut s = String::from("\"");
    let mut first = true;
    for t in toks {
        if !first && t.space {
            s.push(' ');
        }
        let text = t.text();
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
    synth(s, TokKind::Str, space)
}

/// Parse an argument list from the scan stack (`rest` is reversed;
/// its last element is the `(`). Returns the arguments (depth-1
/// commas dropped), the closing paren's hideset, and how many stack
/// entries the invocation consumed -- or `None` when the parens don't
/// close, in which case nothing is consumed (C99 6.10.3p10: the name
/// alone is not an invocation).
fn scan_args(rest: &[Tok]) -> Option<(Vec<Vec<Tok>>, Option<Rc<Hideset>>, usize)> {
    let n = rest.len();
    let mut args: Vec<Vec<Tok>> = Vec::new();
    let mut cur: Vec<Tok> = Vec::new();
    let mut depth = 1usize;
    let mut k = n.checked_sub(2)?;
    loop {
        let t = &rest[k];
        if t.kind == TokKind::Punct {
            match t.text() {
                "(" => depth += 1,
                ")" => {
                    depth -= 1;
                    if depth == 0 {
                        args.push(cur);
                        return Some((args, t.hs.clone(), n - k));
                    }
                }
                "," if depth == 1 => {
                    args.push(core::mem::take(&mut cur));
                    if k == 0 {
                        return None;
                    }
                    k -= 1;
                    continue;
                }
                _ => {}
            }
        }
        cur.push(t.clone());
        if k == 0 {
            return None;
        }
        k -= 1;
    }
}

/// The variadic tail (C99 6.10.3.1p2): arguments past the named
/// parameters, mapped through `f`, joined with commas.
fn join_va(
    raw_args: &[Vec<Tok>],
    nfixed: usize,
    mut f: impl FnMut(&Vec<Tok>) -> Vec<Tok>,
) -> Vec<Tok> {
    let mut v: Vec<Tok> = Vec::new();
    for (k, a) in raw_args.iter().enumerate().skip(nfixed) {
        if k > nfixed {
            v.push(synth(",".to_string(), TokKind::Punct, false));
        }
        let mut e = f(a);
        if let Some(first) = e.first_mut() {
            first.space = k > nfixed;
        }
        v.append(&mut e);
    }
    v
}

impl Preprocessor {
    /// Substitute every macro invocation in `line`. `filename` and
    /// `line_no` feed `__FILE__` / `__LINE__`, whose expansion changes
    /// per line and so can't live in the static macro table.
    pub(super) fn substitute(&self, line: &str, filename: &str, line_no: usize) -> String {
        if !self.line_mentions_macro(line) {
            return line.to_string();
        }
        let buf: Rc<str> = Rc::from(line);
        let mut toks = Vec::with_capacity(line.len() / 4 + 4);
        lex_into(&buf, &mut toks);
        let expanded = self.expand_tokens(toks, filename, line_no, 0);
        // Keep the line's own indentation: warning echoes and `-E`
        // output quote it.
        let indent = &line[..line.len() - line.trim_start().len()];
        let mut out = String::from(indent);
        serialize_into(&expanded, &mut out);
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

    /// The C99 6.10.3.4 scan: pop the next token; a live macro name
    /// substitutes and its result is pushed back for rescanning, so
    /// chained and nested expansions need no special cases. Hidden
    /// names (their own expansion in flight) pass through verbatim.
    fn expand_tokens(
        &self,
        toks: Vec<Tok>,
        filename: &str,
        line_no: usize,
        depth: usize,
    ) -> Vec<Tok> {
        // Bound the argument-expansion recursion; past the bound the
        // tokens pass through unexpanded rather than overflowing the
        // native stack.
        if depth > MAX_MACRO_DEPTH {
            return toks;
        }
        let mut rest = toks;
        rest.reverse();
        let mut out: Vec<Tok> = Vec::with_capacity(rest.len());
        while let Some(tok) = rest.pop() {
            if tok.kind != TokKind::Ident {
                out.push(tok);
                continue;
            }
            // C99 6.10.8 dynamic predefines.
            if tok.is("__LINE__") {
                out.push(synth(format!("{line_no}"), TokKind::Number, tok.space));
                continue;
            }
            if tok.is("__FILE__") {
                out.push(synth(format!("\"{filename}\""), TokKind::Str, tok.space));
                continue;
            }
            // Extension: each use expands to the next integer.
            if tok.is("__COUNTER__") {
                let n = self.counter.get();
                self.counter.set(n + 1);
                out.push(synth(format!("{n}"), TokKind::Number, tok.space));
                continue;
            }
            if hs_contains(&tok.hs, tok.text()) {
                out.push(tok);
                continue;
            }
            if let Some(def) = self.fn_macros.get(tok.text()) {
                // Function-like: an invocation only when `(` follows
                // (C99 6.10.3p10) and closes within the line.
                if rest.last().is_some_and(|t| t.is_punct("(")) {
                    if let Some((raw_args, rp_hs, consumed)) = scan_args(&rest) {
                        self.check_macro_arity(tok.text(), def, &raw_args, filename, line_no);
                        rest.truncate(rest.len() - consumed);
                        let inv = hs_insert(&hs_intersect(&tok.hs, &rp_hs), tok.text());
                        let mut sub = self.subst(def, &raw_args, &inv, filename, line_no, depth);
                        if let Some(f) = sub.first_mut() {
                            f.space = tok.space;
                        }
                        sub.reverse();
                        rest.append(&mut sub);
                        continue;
                    }
                }
                out.push(tok);
                continue;
            }
            if let Some(body) = self.macros.get(tok.text()) {
                let hs = hs_insert(&tok.hs, tok.text());
                let bbuf: Rc<str> = Rc::from(body.as_str());
                let mut btoks = Vec::new();
                lex_into(&bbuf, &mut btoks);
                hs_add_all(&mut btoks, &hs);
                if let Some(f) = btoks.first_mut() {
                    f.space = tok.space;
                }
                btoks.reverse();
                rest.append(&mut btoks);
                continue;
            }
            out.push(tok);
        }
        out
    }

    /// Replacement-list substitution (C99 6.10.3.1-6.10.3.3): `#` and
    /// `##` operands read the unexpanded argument, ordinary parameter
    /// positions read the argument expanded once (memoized), an empty
    /// argument is a placemarker for adjacent `##`. The invocation
    /// hideset is added to the whole result.
    fn subst(
        &self,
        def: &FnMacro,
        raw_args: &[Vec<Tok>],
        inv_hs: &Rc<Hideset>,
        filename: &str,
        line_no: usize,
        depth: usize,
    ) -> Vec<Tok> {
        let bbuf: Rc<str> = Rc::from(def.body.as_str());
        let mut body = Vec::new();
        lex_into(&bbuf, &mut body);
        let nfixed = def.params.len();

        let raw_va: Vec<Tok> = if def.is_variadic {
            join_va(raw_args, nfixed, |a| a.clone())
        } else {
            Vec::new()
        };
        let mut exp_args: Vec<Option<Vec<Tok>>> = raw_args.iter().map(|_| None).collect();
        let mut exp_va: Option<Vec<Tok>> = None;

        let param_index = |name: &str| def.params.iter().position(|p| p == name);
        let is_va = |t: &Tok| def.is_variadic && is_va_token(def, t.text());
        // Raw tokens when the ident is a parameter or the variadic
        // tail; `None` for any other identifier.
        let raw_of = |t: &Tok, raw_va: &Vec<Tok>| -> Option<Vec<Tok>> {
            if is_va(t) {
                Some(raw_va.clone())
            } else {
                param_index(t.text()).map(|idx| raw_args.get(idx).cloned().unwrap_or_default())
            }
        };

        let mut out: Vec<Tok> = Vec::new();
        // A parameter that substituted to nothing leaves a placemarker
        // (C99 6.10.3.3): a following `##` must not glue the token
        // before it to the right operand.
        let mut last_empty = false;
        let mut i = 0;
        while i < body.len() {
            let t = &body[i];
            if t.is_punct("#")
                && let Some(next) = body.get(i + 1)
                && next.kind == TokKind::Ident
                && let Some(raw) = raw_of(next, &raw_va)
            {
                out.push(stringize_toks(&raw, t.space));
                last_empty = false;
                i += 2;
                continue;
            }
            if t.is_punct("##") {
                let Some(next) = body.get(i + 1) else {
                    // A trailing `##` violates C99 6.10.3.3p1; drop it.
                    i += 2;
                    continue;
                };
                // GNU `, ## __VA_ARGS__`: an empty tail deletes the
                // comma; a non-empty tail keeps comma and tail.
                if is_va(next) && out.last().is_some_and(|p| p.is_punct(",")) {
                    if raw_va.is_empty() {
                        out.pop();
                    } else {
                        let va = exp_va
                            .get_or_insert_with(|| {
                                join_va(raw_args, nfixed, |a| {
                                    self.expand_tokens(a.clone(), filename, line_no, depth + 1)
                                })
                            })
                            .clone();
                        splice(&mut out, va, true);
                    }
                    i += 2;
                    continue;
                }
                let right: Vec<Tok> = match raw_of(next, &raw_va) {
                    Some(raw) => raw,
                    None => alloc::vec![next.clone()],
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
                    let mut glued = glue_toks(&left, &right[0]);
                    out.append(&mut glued);
                    out.extend(right[1..].iter().cloned());
                } else {
                    splice(&mut out, right, false);
                }
                last_empty = false;
                i += 2;
                continue;
            }
            if t.kind == TokKind::Ident {
                let followed_by_paste = body.get(i + 1).is_some_and(|n| n.is_punct("##"));
                if is_va(t) {
                    let src = if followed_by_paste {
                        raw_va.clone()
                    } else {
                        exp_va
                            .get_or_insert_with(|| {
                                join_va(raw_args, nfixed, |a| {
                                    self.expand_tokens(a.clone(), filename, line_no, depth + 1)
                                })
                            })
                            .clone()
                    };
                    last_empty = src.is_empty();
                    splice(&mut out, src, t.space);
                    i += 1;
                    continue;
                }
                if let Some(idx) = param_index(t.text()) {
                    let src = if followed_by_paste {
                        raw_args.get(idx).cloned().unwrap_or_default()
                    } else if idx < raw_args.len() {
                        exp_args[idx]
                            .get_or_insert_with(|| {
                                self.expand_tokens(
                                    raw_args[idx].clone(),
                                    filename,
                                    line_no,
                                    depth + 1,
                                )
                            })
                            .clone()
                    } else {
                        Vec::new()
                    };
                    last_empty = src.is_empty();
                    splice(&mut out, src, t.space);
                    i += 1;
                    continue;
                }
            }
            out.push(t.clone());
            last_empty = false;
            i += 1;
        }
        hs_add_all(&mut out, inv_hs);
        out
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

/// Split a `( ... )` argument list in raw text. Used by the driver's
/// multi-line join scan, which runs before any lexing; expansion
/// itself collects arguments from the token stream (`scan_args`).
pub(super) fn parse_macro_args(s: &str) -> Option<(Vec<String>, usize)> {
    let bytes = s.as_bytes();
    if bytes.is_empty() || bytes[0] != b'(' {
        return None;
    }
    let mut args: Vec<String> = Vec::new();
    let mut current = String::new();
    let mut depth = 1usize;
    let mut i = 1;
    while i < bytes.len() {
        let c = bytes[i];
        match c {
            b'(' => {
                depth += 1;
                current.push('(');
                i += 1;
            }
            b')' => {
                depth -= 1;
                if depth == 0 {
                    // The closing paren ends the final argument. C99
                    // 6.10.3p4: `m()` is a single empty argument, so a
                    // one-parameter macro substitutes its parameter with
                    // nothing rather than leaving the parameter name to
                    // be rescanned. A zero-parameter macro ignores the
                    // spare empty argument at expansion.
                    args.push(current.trim().to_string());
                    return Some((args, i + 1));
                }
                current.push(')');
                i += 1;
            }
            b',' if depth == 1 => {
                args.push(current.trim().to_string());
                current.clear();
                i += 1;
            }
            b'"' | b'\'' => {
                // Copy the whole literal (including escapes) so commas
                // / parens inside don't perturb the depth counter. Use a
                // UTF-8 slice so a multibyte sequence stays intact.
                let quote = c;
                let lit_start = i;
                i += 1;
                while i < bytes.len() && bytes[i] != quote {
                    if bytes[i] == b'\\' && i + 1 < bytes.len() {
                        i += 2;
                    } else {
                        i += 1;
                    }
                }
                if i < bytes.len() {
                    i += 1;
                }
                match core::str::from_utf8(&bytes[lit_start..i]) {
                    Ok(s) => current.push_str(s),
                    Err(_) => {
                        for &b in &bytes[lit_start..i] {
                            current.push(b as char);
                        }
                    }
                }
            }
            _ => {
                // Bulk-copy the run up to the next structural byte.
                // Arguments here can be megabytes (a generated table
                // wrapped in nested macro calls); per-byte pushes make
                // argument collection the dominant compile cost.
                //
                // A `,` below depth 1 falls through the guarded arm
                // above into this one while also being a stop byte:
                // copy it directly or the scan cannot advance.
                let start = i;
                if c == b',' {
                    current.push(',');
                    i += 1;
                    continue;
                }
                while i < bytes.len() && !matches!(bytes[i], b'(' | b')' | b',' | b'"' | b'\'') {
                    i += 1;
                }
                match core::str::from_utf8(&bytes[start..i]) {
                    Ok(run) => current.push_str(run),
                    Err(_) => {
                        for &b in &bytes[start..i] {
                            current.push(b as char);
                        }
                    }
                }
            }
        }
    }
    None
}

/// True if `buffer` contains a known function-like macro name
/// followed by `(` and the matching `)` is *not* in the buffer.
/// Used by the preprocessor's main driver to decide whether the
/// next source line should be appended to the current logical
/// line so a multi-line `assert(\n  expr\n)` call expands. Quotes
/// and char literals are skipped so `"foo("` doesn't trigger.
///
/// Also accepts an object-like macro whose expansion is a single
/// identifier that *is* a function-like macro -- the C99
/// 6.10.3.4 rescan makes such an alias head a call whose argument
/// list may close on a later line; without joining the source
/// lines here the substitution only sees the first line and can't
/// find the matching `)`.
pub(super) fn macro_call_unclosed(
    buffer: &str,
    fn_macros: &HashMap<String, FnMacro>,
    obj_macros: &HashMap<String, String>,
) -> bool {
    let bytes = buffer.as_bytes();
    let mut i = 0;
    while i < bytes.len() {
        let c = bytes[i];
        if c == b'"' || c == b'\'' {
            let q = c;
            i += 1;
            while i < bytes.len() && bytes[i] != q {
                if bytes[i] == b'\\' && i + 1 < bytes.len() {
                    i += 2;
                } else {
                    i += 1;
                }
            }
            if i < bytes.len() {
                i += 1;
            }
            continue;
        }
        // Skip a pp-number whole (C99 6.4.8) so its identifier-shaped
        // tail is not read as a macro invocation head.
        let np = pp_number_len(bytes, i);
        if np > 0 {
            i += np;
            continue;
        }
        if c.is_ascii_alphabetic() || c == b'_' {
            let start = i;
            i += 1;
            while i < bytes.len() && (bytes[i].is_ascii_alphanumeric() || bytes[i] == b'_') {
                i += 1;
            }
            let name = &buffer[start..i];
            let direct_fn = fn_macros.contains_key(name);
            // Object-like macro that resolves to a fn-like-macro
            // identifier (single-word body). One level of
            // indirection is enough for the canonical
            // `#define ALIAS Y` followed by `Y(args)` shape;
            // deeper chains are vanishingly rare in real headers.
            let indirect_fn = !direct_fn && {
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
            };
            if direct_fn || indirect_fn {
                let mut j = i;
                while j < bytes.len()
                    && (bytes[j] == b' ' || bytes[j] == b'\t' || bytes[j] == b'\n')
                {
                    j += 1;
                }
                if j < bytes.len() && bytes[j] == b'(' && parse_macro_args(&buffer[j..]).is_none() {
                    return true;
                }
            }
            continue;
        }
        i += 1;
    }
    false
}

/// True if `buffer`'s trailing token is a function-like macro name (directly,
/// or via a single-word object-like alias) with nothing but white space after
/// it. Used to decide whether to join the next line: a function-like macro
/// name whose `(` sits on the following line is still an invocation (C99
/// 6.10.3), which the byte-at-end-of-buffer check in `macro_call_unclosed`
/// cannot see on its own.
pub(super) fn buffer_ends_with_pending_fn_macro(
    buffer: &str,
    fn_macros: &HashMap<String, FnMacro>,
    obj_macros: &HashMap<String, String>,
) -> bool {
    let trimmed = buffer.trim_end();
    let bytes = trimmed.as_bytes();
    let mut start = bytes.len();
    while start > 0 && (bytes[start - 1].is_ascii_alphanumeric() || bytes[start - 1] == b'_') {
        start -= 1;
    }
    // Require a real trailing identifier: non-empty and not a number.
    if start == bytes.len() || bytes[start].is_ascii_digit() {
        return false;
    }
    let name = &trimmed[start..];
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

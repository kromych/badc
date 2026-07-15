use super::text::{is_ident_byte, literal_prefix_len, pp_number_len};
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;
use hashbrown::HashMap;
use crate::c5::error::C5Error;
use super::{FnMacro, Preprocessor};

impl Preprocessor {
    /// Substitute every macro-name token in `line` with its
    /// expansion. Identifiers are recognised the same way the lexer
    /// recognises them (ASCII alpha + `_` start, alnum + `_`
    /// continue). Replacement is iterative with a per-call visited
    /// set so `#define A B` `#define B 5` chains expand fully but
    /// `#define A A` doesn't loop forever.
    ///
    /// `filename` and `line_no` feed the special predefined macros
    /// `__FILE__` and `__LINE__`, which can't live in the static
    /// `macros` table because their expansion changes on every line.
    pub(super) fn substitute(&self, line: &str, filename: &str, line_no: usize) -> String {
        self.substitute_with_blocklist(line, filename, line_no, &Blocklist::Nil)
    }

    /// C99 6.10.3p4: the invocation's argument count must match the
    /// macro's parameter count; record a diagnostic on a mismatch.
    pub(super) fn check_macro_arity(
        &self,
        name: &str,
        def: &FnMacro,
        args: &[String],
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
        self.record_pp_error(C5Error::Compile(crate::c5::error::fmt_compile_err(
            filename, line_no, &msg,
        )));
    }

    /// Scan `text` for identifiers that name a macro currently
    /// in the registry, append each to `out`. Used to compute
    /// the C99 6.10.3.4 "blue paint" set after a function-like
    /// macro's arguments have been pre-expanded: any macro name
    /// surviving in the pre-expanded arg text must have fired
    /// during pre-expansion, so it must not re-fire during the
    /// body rescan.
    ///
    /// An object-like macro name always counts: if it survived
    /// pre-expansion it fired. A function-like macro name counts only
    /// when immediately followed by `(`: such a call could have fired
    /// (fn-like macros expand only when followed by `(`, C99 6.10.3p10),
    /// so its survival means it was blue-painted during pre-expansion --
    /// the self-referential `#define Py_DECREF(op) Py_DECREF(...)` idiom
    /// -- and it must stay blue-painted in the body rescan. A bare
    /// function-like name with no `(` carries no information; blue-
    /// painting it would suppress the canonical `APPLY(OP, ...)` shape
    /// where `OP` only becomes a call after substitution.
    pub(super) fn collect_macro_idents_into(&self, text: &str, out: &mut alloc::vec::Vec<String>) {
        let bytes = text.as_bytes();
        let mut i = 0;
        while i < bytes.len() {
            let c = bytes[i];
            // Skip a string / char literal's encoding prefix so the `L`
            // of `L"..."` isn't collected as a macro identifier (C99
            // 6.4.5 / 6.4.4.4); the literal body falls to the quote arm.
            if let Some(plen) = literal_prefix_len(bytes, i) {
                i += plen;
                continue;
            }
            // Skip a pp-number whole (C99 6.4.8) so its identifier-
            // shaped tail is not collected as a macro name.
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
                let ident = &text[start..i];
                let counts = self.macros.contains_key(ident)
                    || (self.fn_macros.contains_key(ident) && {
                        let mut k = i;
                        while k < bytes.len() && bytes[k].is_ascii_whitespace() {
                            k += 1;
                        }
                        k < bytes.len() && bytes[k] == b'('
                    });
                if counts && !out.iter().any(|s| s == ident) {
                    out.push(ident.to_string());
                }
            } else if c == b'"' || c == b'\'' {
                let quote = c;
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
            } else {
                i += 1;
            }
        }
    }

    /// Like [`substitute`], but `blocklist` enumerates macro names
    /// currently being expanded -- the C99 "blue paint" rule says a
    /// macro doesn't re-expand inside its own replacement list.
    /// Self-shadowing patterns (`static T name; #define name
    /// GLOBAL(T, name)`) blow the stack without this guard.
    pub(super) fn substitute_with_blocklist(
        &self,
        line: &str,
        filename: &str,
        line_no: usize,
        blocklist: &Blocklist,
    ) -> String {
        // Bound the expansion nesting so a pathologically deep (but
        // blocklist-terminating) macro does not overflow the native
        // stack. Past the bound the current text is left unexpanded
        // rather than recursing further.
        if blocklist.depth() > MAX_MACRO_DEPTH {
            return line.to_string();
        }
        let bytes = line.as_bytes();
        let mut out = String::with_capacity(line.len());
        let mut i = 0;
        // Set after an expansion push: the next source byte starts a
        // new token, so space the seam if it would re-lex into the
        // expansion's tail.
        let mut guard_seam = false;
        while i < bytes.len() {
            let c = bytes[i];
            if guard_seam {
                guard_seam = false;
                if let Some(&last) = out.as_bytes().last()
                    && pp_tokens_would_merge(last, c)
                {
                    out.push(' ');
                }
            }
            // A string / char literal may carry an encoding prefix
            // (`L`, `u`, `U`, `u8`) that is part of the literal token,
            // not an identifier (C99 6.4.5 / 6.4.4.4). Detect it before
            // the identifier scan so a macro parameter named `L`/`u`/`U`
            // doesn't capture the prefix of an adjacent wide / UTF
            // literal. The literal body is copied verbatim below.
            if let Some(plen) = literal_prefix_len(bytes, i) {
                out.push_str(&line[i..i + plen]);
                i += plen;
                continue;
            }
            // A pp-number is one token (C99 6.4.8): copy it whole so an
            // identifier-shaped tail (`2op`) is not scanned as a macro.
            let np = pp_number_len(bytes, i);
            if np > 0 {
                out.push_str(&line[i..i + np]);
                i += np;
                continue;
            }
            if c.is_ascii_alphabetic() || c == b'_' {
                let start = i;
                i += 1;
                while i < bytes.len() && (bytes[i].is_ascii_alphanumeric() || bytes[i] == b'_') {
                    i += 1;
                }
                let ident = &line[start..i];
                // C99 sec 6.10.8 dynamic predefines -- their expansion
                // depends on the current line / file, so they sit
                // outside the static macro table.
                if ident == "__LINE__" {
                    out.push_str(&format!("{line_no}"));
                    continue;
                }
                if ident == "__FILE__" {
                    out.push('"');
                    out.push_str(filename);
                    out.push('"');
                    continue;
                }
                // MSVC / GCC extension: each `__COUNTER__` use
                // expands to a monotonically increasing integer
                // literal -- 0, 1, 2, ... -- and post-increments.
                // Often paired with `##` to mint unique
                // identifiers from macros.
                if ident == "__COUNTER__" {
                    let n = self.counter.get();
                    self.counter.set(n + 1);
                    out.push_str(&format!("{n}"));
                    continue;
                }
                // C99 "blue paint": don't re-expand a name that's
                // already being expanded on the current chain.
                if blocklist.contains(ident) {
                    out.push_str(ident);
                    continue;
                }
                // Function-like macro: only expands when the next
                // non-whitespace character is `(`. The C standard
                // allows whitespace between the name and the open
                // paren at *use* sites; we follow that.
                if let Some(macro_def) = self.fn_macros.get(ident) {
                    let mut j = i;
                    while j < bytes.len() && bytes[j].is_ascii_whitespace() {
                        j += 1;
                    }
                    if j < bytes.len()
                        && bytes[j] == b'('
                        && let Some((args, after)) = parse_macro_args(&line[j..])
                    {
                        // C99 argument substitution rule: each arg is
                        // macro-expanded *before* being substituted
                        // into the body (parameters that participate
                        // in `#` or `##` are exempt, but expand_fn_macro
                        // handles those cases by reading the parameter's
                        // unexpanded text directly). Pre-expand here
                        // with `ident` not yet on the blocklist -- the
                        // outer macro's blue paint only kicks in for
                        // the rescan of the substituted body.
                        let expanded_args: Vec<String> = args
                            .iter()
                            .map(|a| {
                                self.substitute_with_blocklist(a, filename, line_no, blocklist)
                            })
                            .collect();
                        self.check_macro_arity(ident, macro_def, &args, filename, line_no);
                        let expanded = expand_fn_macro(macro_def, &expanded_args, &args);
                        // C99 6.10.3.4 "blue paint": any macro that
                        // fired during arg pre-expansion stays on
                        // the blocklist for the body rescan, so a
                        // pre-expanded arg like `s1->symtab_section`
                        // does not re-trigger `symtab_section` after
                        // substitution. Approximate the fired set by
                        // scanning each pre-expanded arg for macro
                        // names: a name that survived in the
                        // expanded text and is still in the
                        // registry must have already expanded
                        // through pre-expansion (otherwise pre-
                        // expansion would have substituted it).
                        let mut blue_paint: alloc::vec::Vec<String> = alloc::vec::Vec::new();
                        for arg_text in &expanded_args {
                            self.collect_macro_idents_into(arg_text, &mut blue_paint);
                        }
                        let recursed = if blue_paint.is_empty() {
                            let frame = Blocklist::Cons(ident, blocklist);
                            self.substitute_with_blocklist(&expanded, filename, line_no, &frame)
                        } else {
                            let mut names: Vec<&str> = alloc::vec![ident];
                            for bp in &blue_paint {
                                let s = bp.as_str();
                                if !names.contains(&s) && !blocklist.contains(s) {
                                    names.push(s);
                                }
                            }
                            let frame = Blocklist::Many(&names, blocklist);
                            self.substitute_with_blocklist(&expanded, filename, line_no, &frame)
                        };
                        // Token-stream rescan (C99 6.10.3.4): if the
                        // function-like macro's body reduces to a
                        // single identifier and the *source* token
                        // immediately after the original invocation
                        // is `(`, the standard requires that
                        // identifier to be treated as the head of a
                        // further function-like call. Drives the
                        // common `WIDTH##_##NAME(...)` paste idiom
                        // where the pasted token is itself a macro.
                        let next_src = j + after;
                        let trimmed = recursed.trim();
                        if !trimmed.is_empty()
                            && trimmed
                                .bytes()
                                .all(|b| b.is_ascii_alphanumeric() || b == b'_')
                            && trimmed.bytes().next().is_some_and(|b| !b.is_ascii_digit())
                            && !blocklist.contains(trimmed)
                            && let Some(inner_def) = self.fn_macros.get(trimmed)
                        {
                            let mut k = next_src;
                            while k < bytes.len() && bytes[k].is_ascii_whitespace() {
                                k += 1;
                            }
                            if k < bytes.len()
                                && bytes[k] == b'('
                                && let Some((inner_args, inner_after)) =
                                    parse_macro_args(&line[k..])
                            {
                                // The inner args come from the source
                                // file's tokens after the outer
                                // invocation -- C99 6.10.3.4 paragraph 1
                                // treats those as "the rest of the
                                // source file's preprocessing tokens",
                                // so they are pre-expanded with the
                                // caller's blocklist, not with the just-
                                // completed outer macro on it.
                                let inner_expanded_args: Vec<String> = inner_args
                                    .iter()
                                    .map(|a| {
                                        self.substitute_with_blocklist(
                                            a, filename, line_no, blocklist,
                                        )
                                    })
                                    .collect();
                                self.check_macro_arity(
                                    trimmed,
                                    inner_def,
                                    &inner_args,
                                    filename,
                                    line_no,
                                );
                                let inner_body =
                                    expand_fn_macro(inner_def, &inner_expanded_args, &inner_args);
                                let deeper = Blocklist::Cons(trimmed, blocklist);
                                let inner_recursed = self.substitute_with_blocklist(
                                    &inner_body,
                                    filename,
                                    line_no,
                                    &deeper,
                                );
                                push_expansion_text(&mut out, &inner_recursed);
                                guard_seam = true;
                                i = k + inner_after;
                                continue;
                            }
                        }
                        push_expansion_text(&mut out, &recursed);
                        guard_seam = true;
                        i = next_src;
                        continue;
                    }
                }
                // Object-like expansion. Re-run substitute on the
                // result so a body that mentions a function-like
                // macro (e.g. `#define TWICE INC(INC(0))`) gets the
                // INC(...) calls expanded too. Hot path is the
                // not-a-macro case -- the early `None` saves an
                // allocation per source identifier.
                match self.expand_chain(ident) {
                    None => out.push_str(ident),
                    Some((expanded, chain)) => {
                        // Paint the name and every chain intermediate
                        // (C99 6.10.3.4p2) so the rescan cannot re-fire
                        // a macro the walk already went through.
                        let mut painted: Vec<&str> = alloc::vec![ident];
                        for c in &chain {
                            if !painted.contains(&c.as_str()) {
                                painted.push(c);
                            }
                        }
                        let nested = Blocklist::Many(&painted, blocklist);
                        // Token-stream rescan (C99 6.10.3.4): if the
                        // expansion is a single identifier and the
                        // *source* token immediately after the
                        // original macro use is `(`, the rescan would
                        // see `expanded_ident(args)` and trigger any
                        // matching function-like macro. We don't have
                        // a true token stream so emulate this here:
                        // detect the shape and pull the args from the
                        // source directly. Drives the canonical
                        // C99 6.10.3.4 rescan shape where an
                        // object-like alias resolves to a
                        // function-like macro name -- e.g.
                        // `#define ALIAS f` followed by `ALIAS(x)`
                        // must expand to `f(x)` and then through
                        // any function-like `f` definition.
                        let trimmed = expanded.trim();
                        if !trimmed.is_empty()
                            && trimmed
                                .bytes()
                                .all(|b| b.is_ascii_alphanumeric() || b == b'_')
                            && trimmed.bytes().next().is_some_and(|b| !b.is_ascii_digit())
                            && let Some(macro_def) = self.fn_macros.get(trimmed)
                            && !nested.contains(trimmed)
                        {
                            let mut j = i;
                            while j < bytes.len() && bytes[j].is_ascii_whitespace() {
                                j += 1;
                            }
                            if j < bytes.len()
                                && bytes[j] == b'('
                                && let Some((args, after)) = parse_macro_args(&line[j..])
                            {
                                let expanded_args: Vec<String> = args
                                    .iter()
                                    .map(|a| {
                                        self.substitute_with_blocklist(
                                            a, filename, line_no, &nested,
                                        )
                                    })
                                    .collect();
                                self.check_macro_arity(
                                    trimmed, macro_def, &args, filename, line_no,
                                );
                                let body_expanded =
                                    expand_fn_macro(macro_def, &expanded_args, &args);
                                let deeper = Blocklist::Cons(trimmed, &nested);
                                let recursed = self.substitute_with_blocklist(
                                    &body_expanded,
                                    filename,
                                    line_no,
                                    &deeper,
                                );
                                push_expansion_text(&mut out, &recursed);
                                guard_seam = true;
                                i = j + after;
                                continue;
                            }
                        }
                        push_expansion_text(
                            &mut out,
                            &self.substitute_with_blocklist(&expanded, filename, line_no, &nested),
                        );
                        guard_seam = true;
                    }
                }
            } else if c == b'"' || c == b'\'' {
                // Copy string and character literals verbatim so
                // identifier-looking bytes inside them aren't
                // substituted, and so a quoted quote (`'"'` /
                // `"\"")` doesn't open the *other* literal kind. Copy
                // the byte range as a UTF-8 slice rather than byte by
                // byte: a per-byte `as char` push would re-encode each
                // byte of a multibyte sequence (`L'a'` -> two chars ->
                // four bytes), corrupting non-ASCII literal contents.
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
                    i += 1; // consume the closing quote
                }
                match core::str::from_utf8(&bytes[lit_start..i]) {
                    Ok(s) => out.push_str(s),
                    Err(_) => {
                        for &b in &bytes[lit_start..i] {
                            out.push(b as char);
                        }
                    }
                }
            } else {
                out.push(c as char);
                i += 1;
            }
        }
        out
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
    /// passed through. C99 6.10.3.4p2 paints every name replaced
    /// during the rescan, so the caller must add the chain to the
    /// blocklist -- otherwise a terminal body that re-mentions an
    /// intermediate (`#define B C` / `#define C B x`) re-fires it and
    /// duplicates tokens. A revisited name ends the walk.
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

/// Names currently being expanded, threaded through the recursive
/// macro substitution to implement C99 6.10.3.4 "blue paint" (a
/// macro does not re-expand while its own expansion is in flight).
/// A stack-allocated chain: the common frame adds a single name and
/// borrows its parent, so no heap allocation is needed; a frame that
/// must add several names (a function-like macro's argument pre-
/// expansion) borrows a slice instead.
pub(super) enum Blocklist<'a> {
    Nil,
    Cons(&'a str, &'a Blocklist<'a>),
    Many(&'a [&'a str], &'a Blocklist<'a>),
}


impl Blocklist<'_> {
    fn contains(&self, name: &str) -> bool {
        let mut cur = self;
        loop {
            match cur {
                Blocklist::Nil => return false,
                Blocklist::Cons(n, parent) => {
                    if *n == name {
                        return true;
                    }
                    cur = parent;
                }
                Blocklist::Many(names, parent) => {
                    if names.contains(&name) {
                        return true;
                    }
                    cur = parent;
                }
            }
        }
    }

    /// Number of active expansion frames. Each nested macro expansion
    /// pushes one, so this is the substitution recursion depth.
    fn depth(&self) -> usize {
        let mut cur = self;
        let mut n = 0;
        loop {
            match cur {
                Blocklist::Nil => return n,
                Blocklist::Cons(_, parent) | Blocklist::Many(_, parent) => {
                    n += 1;
                    cur = parent;
                }
            }
        }
    }
}


/// Build the `#`-stringized form of a macro argument (C99 6.10.3.2):
/// the spelling is wrapped in `"`, leading and trailing white space is
/// deleted, and each internal white-space run between tokens becomes a
/// single space. White space inside a character constant or string
/// literal is preserved, and a `\` or `"` that occurs inside such a
/// literal is escaped; a `\` outside any literal is copied verbatim.
pub(super) fn stringize_arg(arg: &str) -> String {
    let bytes = arg.as_bytes();
    let mut out = String::with_capacity(arg.len() + 2);
    out.push('"');
    let mut in_str = false;
    let mut in_char = false;
    let mut pending_space = false;
    let mut wrote_any = false;
    let mut i = 0;
    while i < bytes.len() {
        let c = bytes[i];
        let in_lit = in_str || in_char;
        if !in_lit && matches!(c, b' ' | b'\t' | b'\n' | b'\r' | 0x0c) {
            if wrote_any {
                pending_space = true;
            }
            i += 1;
            continue;
        }
        if pending_space {
            out.push(' ');
            pending_space = false;
        }
        if in_lit && c == b'\\' && i + 1 < bytes.len() {
            // Escape sequence inside a literal: escape the backslash,
            // then copy the escaped char (re-escaping a quote or
            // backslash). The escaped char never toggles literal state.
            out.push_str("\\\\");
            match bytes[i + 1] {
                b'"' => out.push_str("\\\""),
                b'\\' => out.push_str("\\\\"),
                n => out.push(n as char),
            }
            i += 2;
            wrote_any = true;
            continue;
        }
        match c {
            b'"' => {
                out.push_str("\\\"");
                if !in_char {
                    in_str = !in_str;
                }
            }
            b'\'' => {
                out.push('\'');
                if !in_str {
                    in_char = !in_char;
                }
            }
            // A backslash outside any literal is not escaped (C99 only
            // escapes those within character / string literals).
            _ => out.push(c as char),
        }
        wrote_any = true;
        i += 1;
    }
    out.push('"');
    out
}


/// True when `prev` directly followed by `next` would re-lex as part
/// of a single preprocessing token even though the two bytes end and
/// begin distinct tokens. The textual expansion sites insert one
/// space at such boundaries -- whitespace between tokens never
/// changes phase-7 semantics -- so substituted text cannot paste onto
/// its neighbors (C99 6.10.3.3 reserves pasting for `##`).
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


/// Append expansion output to `out`, spacing the seam when the last
/// emitted byte and the first byte of `text` would otherwise re-lex
/// as one token.
pub(super) fn push_expansion_text(out: &mut String, text: &str) {
    if let (Some(&last), Some(&first)) = (out.as_bytes().last(), text.as_bytes().first())
        && pp_tokens_would_merge(last, first)
    {
        out.push(' ');
    }
    out.push_str(text);
}


/// Parse a comma-separated argument list of a function-like macro
/// invocation. `s` must start at the `(` character. Returns the args
/// (string slices, trimmed) and the byte offset of the position
/// *after* the matching `)` -- relative to `s`. Nested parentheses
/// (e.g. `MACRO(f(x), g(y))`) and string/char literals are tracked so
/// commas inside them don't split. Returns `None` if `s` doesn't open
/// with `(` or the parens are unbalanced.
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
/// 6.10.3.4 rescan turns `STB_C_LEX_CPP_COMMENTS(if (...) ...)`
/// (where `#define STB_C_LEX_CPP_COMMENTS Y` and `#define Y(a)
/// a`) into a call on `Y`; without joining the source lines
/// here, the rescan in `substitute_with_blocklist` only sees the
/// first line and can't find the matching `)`.
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


/// Recursion bound for macro substitution. Each expansion frame is
/// cheap, so this can sit higher than the `#if`-expression bound while
/// still keeping a pathologically deep (but blocklist-terminating)
/// expansion from overflowing the stack.
pub(super) const MAX_MACRO_DEPTH: usize = 200;


/// True when a body identifier names the variadic tail: the standard
/// `__VA_ARGS__`, or the GCC named-rest parameter (`#define foo(rest...)`
/// reaches the tail through `rest`).
pub(super) fn is_va_token(def: &FnMacro, word: &str) -> bool {
    word == "__VA_ARGS__" || def.va_name.as_deref() == Some(word)
}


/// C99 6.10.3p4. A variadic macro's `...` absorbs any surplus, so the
/// invocation needs at least as many arguments as named parameters. A
/// zero-parameter macro invoked as `NAME()` supplies a single empty
/// argument, which counts as zero (the single-empty-argument rule).
pub(super) fn macro_arg_count_ok(def: &FnMacro, args: &[String]) -> bool {
    let params = def.params.len();
    if def.is_variadic {
        args.len() >= params
    } else if params == 0 {
        args.len() == 1 && args[0].is_empty()
    } else {
        args.len() == params
    }
}


pub(super) fn expand_fn_macro(def: &FnMacro, args: &[String], raw_args: &[String]) -> String {
    // Pre-compute the comma-joined string for __VA_ARGS__. Empty when
    // the macro isn't variadic or no trailing args were supplied. The
    // raw form (unexpanded arguments) feeds the `#` and `##` operands
    // per C99 6.10.3.1 / 6.10.3.2; the expanded form feeds ordinary
    // substitution.
    let var_start = def.params.len();
    let join_from = |src: &[String]| -> String {
        if def.is_variadic && src.len() > var_start {
            src[var_start..].join(", ")
        } else {
            String::new()
        }
    };
    let va_args_str = join_from(args);
    let raw_va_args_str = join_from(raw_args);

    let bytes = def.body.as_bytes();
    let mut out = String::with_capacity(def.body.len());
    let mut i = 0;
    // True when the next token is the right-hand operand of a `##`, so
    // it must substitute from the unexpanded argument.
    let mut after_paste = false;
    // True when the token most recently emitted (ignoring intervening
    // whitespace) was an empty-argument parameter substitution. C99
    // 6.10.3.3 makes an empty argument a placemarker: `placemarker ## x`
    // is `x`, and the token before the placemarker stays separate. So a
    // `##` whose left operand is such a placemarker must not glue the
    // preceding token to the right operand.
    let mut left_operand_empty = false;
    // Set after a parameter substitution: the next body byte starts a
    // new token, so space the seam if it would re-lex into the
    // substituted text's tail (`-x` with `x` = `-22` must stay `- -22`,
    // not `--22`). A following `##` trims the space back off, keeping
    // explicit pastes intact.
    let mut guard_seam = false;
    while i < bytes.len() {
        let c = bytes[i];
        if guard_seam {
            guard_seam = false;
            if let Some(&last) = out.as_bytes().last()
                && pp_tokens_would_merge(last, c)
            {
                out.push(' ');
            }
        }
        if c == b'#' && i + 1 < bytes.len() && bytes[i + 1] == b'#' {
            // GNU `, ## <variadic>` comma idiom: when a comma precedes
            // `##` and the right operand is the variadic tail, this is
            // not an ordinary token paste. An empty tail deletes the
            // comma (`f(fmt, ##__VA_ARGS__)` with no extra args ->
            // `f(fmt)`); a non-empty tail keeps the comma and the tail.
            let mut k = i + 2;
            while k < bytes.len() && (bytes[k] == b' ' || bytes[k] == b'\t') {
                k += 1;
            }
            let word_start = k;
            while k < bytes.len() && (bytes[k].is_ascii_alphanumeric() || bytes[k] == b'_') {
                k += 1;
            }
            let right_is_va = def.is_variadic && is_va_token(def, &def.body[word_start..k]);
            if right_is_va && out.trim_end().ends_with(',') {
                if raw_va_args_str.is_empty() {
                    while out.ends_with(' ') || out.ends_with('\t') {
                        out.pop();
                    }
                    out.pop();
                    i = k;
                } else {
                    i = word_start;
                }
                continue;
            }
            // Ordinary token-paste: drop the `##` and any whitespace
            // bracketing it. `a ## b` joins the *tokens* before / after
            // the operator; for c5's textual preprocessor that means
            // trim trailing whitespace from what we've already emitted,
            // then skip the operator and any leading whitespace before
            // the next token. When the left operand was an empty-argument
            // placemarker there is no left token to glue, so keep the
            // preceding whitespace and leave that token separate.
            if !left_operand_empty {
                while out.ends_with(' ') || out.ends_with('\t') {
                    out.pop();
                }
            }
            i += 2;
            while i < bytes.len() && (bytes[i] == b' ' || bytes[i] == b'\t') {
                i += 1;
            }
            after_paste = true;
            left_operand_empty = false;
            continue;
        }
        let preceded_by_paste = after_paste;
        after_paste = false;
        if c == b'#' {
            left_operand_empty = false;
            // Stringification: `#param` -> `"<arg>"`. The C standard
            // says the operand must be a parameter; we follow that
            // and pass a stray `#` through unchanged. The operand uses
            // the unexpanded argument (C99 6.10.3.2p2).
            let mut j = i + 1;
            while j < bytes.len() && (bytes[j] == b' ' || bytes[j] == b'\t') {
                j += 1;
            }
            if j < bytes.len() && (bytes[j].is_ascii_alphabetic() || bytes[j] == b'_') {
                let start = j;
                while j < bytes.len() && (bytes[j].is_ascii_alphanumeric() || bytes[j] == b'_') {
                    j += 1;
                }
                let name = &def.body[start..j];
                let arg_text: Option<&str> = if def.is_variadic && is_va_token(def, name) {
                    Some(raw_va_args_str.as_str())
                } else if let Some(idx) = def.params.iter().position(|p| p == name) {
                    raw_args.get(idx).map(|s| s.as_str())
                } else {
                    None
                };
                if let Some(arg) = arg_text {
                    out.push_str(&stringize_arg(arg));
                    i = j;
                    continue;
                }
            }
            out.push('#');
            i += 1;
        } else if let Some(plen) = literal_prefix_len(bytes, i) {
            // An `L`/`u`/`U`/`u8` prefix belongs to the following string
            // or char literal (C99 6.4.5 / 6.4.4.4); emit it verbatim so
            // a parameter named `L`/`u`/`U` doesn't capture it. The
            // literal body is copied by the `"`/`'` arm on the next
            // iteration.
            out.push_str(&def.body[i..i + plen]);
            i += plen;
            left_operand_empty = false;
        } else if pp_number_len(bytes, i) > 0 {
            // A pp-number is one token (C99 6.4.8): copy it whole so an
            // identifier-shaped tail (`2op`) is not read as a parameter.
            let np = pp_number_len(bytes, i);
            out.push_str(&def.body[i..i + np]);
            i += np;
            left_operand_empty = false;
        } else if c.is_ascii_alphabetic() || c == b'_' {
            let start = i;
            i += 1;
            while i < bytes.len() && (bytes[i].is_ascii_alphanumeric() || bytes[i] == b'_') {
                i += 1;
            }
            let word = &def.body[start..i];
            // A parameter that is an operand of `##` (immediately
            // before or after the operator) substitutes from the
            // unexpanded argument (C99 6.10.3.1p1).
            let followed_by_paste = {
                let mut k = i;
                while k < bytes.len() && (bytes[k] == b' ' || bytes[k] == b'\t') {
                    k += 1;
                }
                k + 1 < bytes.len() && bytes[k] == b'#' && bytes[k + 1] == b'#'
            };
            let use_raw = preceded_by_paste || followed_by_paste;
            let params = if use_raw { raw_args } else { args };
            let va = if use_raw {
                &raw_va_args_str
            } else {
                &va_args_str
            };
            if def.is_variadic && is_va_token(def, word) {
                if preceded_by_paste {
                    out.push_str(va);
                } else {
                    push_expansion_text(&mut out, va);
                    guard_seam = true;
                }
                left_operand_empty = va.is_empty();
            } else {
                match def.params.iter().position(|p| p == word) {
                    Some(idx) if idx < params.len() => {
                        if preceded_by_paste {
                            out.push_str(&params[idx]);
                        } else {
                            push_expansion_text(&mut out, &params[idx]);
                            guard_seam = true;
                        }
                        left_operand_empty = params[idx].is_empty();
                    }
                    _ => {
                        out.push_str(word);
                        left_operand_empty = false;
                    }
                }
            }
        } else if c == b'"' || c == b'\'' {
            left_operand_empty = false;
            // Pass literals through unchanged so identifier-like bytes
            // inside don't get substituted. Copy the byte range as a
            // UTF-8 slice rather than byte by byte so a multibyte
            // sequence isn't re-encoded per byte (`as char` widening).
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
                Ok(s) => out.push_str(s),
                Err(_) => {
                    for &b in &bytes[lit_start..i] {
                        out.push(b as char);
                    }
                }
            }
        } else {
            // Preserve the placemarker flag across whitespace so a `##`
            // separated from its empty-argument left operand by spaces is
            // still recognized; any other character is a real token.
            if c != b' ' && c != b'\t' {
                left_operand_empty = false;
            }
            out.push(c as char);
            i += 1;
        }
    }
    out
}

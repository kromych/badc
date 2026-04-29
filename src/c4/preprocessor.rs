//! Rudimentary preprocessor that runs before the lexer.
//!
//! The c4 dialect's lexer used to silently skip lines starting with
//! `#`, leaving every `#define` / `#ifdef` in the source as a
//! no-op. That worked when the compiler hardcoded a fixed set of
//! constants and libc bindings into the symbol table -- as soon as
//! per-target headers want to declare those, we need a real
//! preprocessor.
//!
//! What's supported:
//!
//! * `#define NAME REPLACEMENT` -- single-token replacement; macro
//!   bodies can themselves be macros (cycle-safe).
//! * `#ifdef NAME` / `#ifndef NAME` / `#endif`.
//! * `#if EXPR` / `#else` / `#endif`, with `EXPR` being either
//!   `LHS == RHS`, `LHS != RHS`, or a bare `NAME` (truthy iff
//!   defined to a non-zero, non-empty value).
//! * `#pragma comment(dylib, "...")` -- recorded into
//!   [`Preprocessor::dylibs`]; consumed by Stage B of the codegen
//!   refactor.
//!
//! What's not:
//!
//! * Function-like macros (`#define MAX(a, b) ...`).
//! * Multi-line `#define` continuations.
//! * Token pasting / stringification.
//! * `#include` -- we auto-prepend the per-target header instead.
//! * Boolean operators (`&&`, `||`, `!`) inside `#if`.
//!
//! The pass is line-based: every line of the input either becomes
//! a (macro-substituted) line of the output or a blank line if it
//! was a directive / inactive branch. Line counts are preserved
//! one-for-one so error messages from the lexer keep meaningful
//! line numbers.

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::error::C4Error;

/// Output of a successful preprocessor run: the substituted source
/// for the lexer plus the side data the codegen will pick up later
/// (Stage B uses [`Preprocessor::dylibs`]).
pub(crate) struct Preprocessor {
    macros: BTreeMap<String, String>,
    /// `#pragma comment(dylib, "...")` declarations, in the order
    /// they appeared. Stage A records them for inspection; Stage B
    /// will drive the IAT / GOT / PLT layout from this list plus
    /// the function references the codegen actually sees.
    pub dylibs: Vec<String>,
}

impl Preprocessor {
    /// Build a preprocessor with the two predefined macros set:
    /// `BADC_VERSION` (the crate version, as a string literal) and
    /// `BADC_TARGET` (the target's canonical id, also as a string
    /// literal). Both expansions are quoted so source can write
    /// `#if BADC_TARGET == "windows-x64"` directly.
    pub fn new(target_spec: &str, crate_version: &str) -> Self {
        let mut macros = BTreeMap::new();
        macros.insert("BADC_VERSION".to_string(), format!("\"{crate_version}\""));
        macros.insert("BADC_TARGET".to_string(), format!("\"{target_spec}\""));
        Self {
            macros,
            dylibs: Vec::new(),
        }
    }

    /// Run the preprocessor over `source` and return the substituted
    /// text suitable for the lexer. Each input line maps to exactly
    /// one output line so lexer-level error reports still point at
    /// the right place in the original buffer.
    pub fn process(&mut self, source: &str) -> Result<String, C4Error> {
        let mut out = String::with_capacity(source.len());

        // `cond_stack` mirrors the nesting of `#if` / `#ifdef`. Each
        // entry is `(parent_active, this_branch_taken,
        // saw_else)`. `parent_active` is the enclosing branch's
        // active state; we AND with it so a true inner branch
        // inside a false outer branch still produces no output.
        // `saw_else` blocks a second `#else` for the same `#if`.
        let mut cond_stack: Vec<CondFrame> = Vec::new();
        let mut active = true;

        for (idx, line) in source.lines().enumerate() {
            let line_no = idx + 1;
            let trimmed = line.trim_start();

            if let Some(rest) = trimmed.strip_prefix('#') {
                let directive = rest.trim_start();
                match parse_directive(directive) {
                    Directive::Define(name, body) => {
                        if active {
                            self.macros.insert(name.to_string(), body.to_string());
                        }
                    }
                    Directive::Undef(name) => {
                        if active {
                            self.macros.remove(name);
                        }
                    }
                    Directive::Ifdef(name) => {
                        let taken = active && self.macros.contains_key(name);
                        cond_stack.push(CondFrame {
                            parent_active: active,
                            this_branch_taken: taken,
                            any_branch_taken: taken,
                            saw_else: false,
                        });
                        active = taken;
                    }
                    Directive::Ifndef(name) => {
                        let taken = active && !self.macros.contains_key(name);
                        cond_stack.push(CondFrame {
                            parent_active: active,
                            this_branch_taken: taken,
                            any_branch_taken: taken,
                            saw_else: false,
                        });
                        active = taken;
                    }
                    Directive::If(expr) => {
                        let taken = active && self.eval_condition(expr, line_no)?;
                        cond_stack.push(CondFrame {
                            parent_active: active,
                            this_branch_taken: taken,
                            any_branch_taken: taken,
                            saw_else: false,
                        });
                        active = taken;
                    }
                    Directive::Else => {
                        let frame = cond_stack.last_mut().ok_or_else(|| {
                            C4Error::Compile(format!(
                                "preprocessor:{line_no}: `#else` with no matching `#if`"
                            ))
                        })?;
                        if frame.saw_else {
                            return Err(C4Error::Compile(format!(
                                "preprocessor:{line_no}: duplicate `#else` for the same `#if`"
                            )));
                        }
                        frame.saw_else = true;
                        let taken = frame.parent_active && !frame.any_branch_taken;
                        frame.this_branch_taken = taken;
                        frame.any_branch_taken |= taken;
                        active = taken;
                    }
                    Directive::Endif => {
                        let frame = cond_stack.pop().ok_or_else(|| {
                            C4Error::Compile(format!(
                                "preprocessor:{line_no}: `#endif` with no matching `#if`"
                            ))
                        })?;
                        active = frame.parent_active;
                    }
                    Directive::Pragma(args) => {
                        if active {
                            self.parse_pragma(args, line_no)?;
                        }
                    }
                    Directive::Other => {
                        // Unknown directive (e.g. `#include`) -- mirror
                        // the historical lexer behaviour and skip it.
                        // We don't error out so existing sources that
                        // sprinkle `#include <stdio.h>` for documentation
                        // keep compiling.
                    }
                    Directive::Shebang => {
                        // First-line `#!/usr/bin/env badc` shebangs --
                        // no preprocessor semantics, just skipped.
                    }
                }
                out.push('\n');
                continue;
            }

            if active {
                out.push_str(&self.substitute(line));
            }
            out.push('\n');
        }

        if !cond_stack.is_empty() {
            return Err(C4Error::Compile(
                "preprocessor: unterminated `#if` / `#ifdef` block".to_string(),
            ));
        }

        Ok(out)
    }

    /// Substitute every macro-name token in `line` with its
    /// expansion. Identifiers are recognised the same way the lexer
    /// recognises them (ASCII alpha + `_` start, alnum + `_`
    /// continue). Replacement is iterative with a per-call visited
    /// set so `#define A B` `#define B 5` chains expand fully but
    /// `#define A A` doesn't loop forever.
    fn substitute(&self, line: &str) -> String {
        let bytes = line.as_bytes();
        let mut out = String::with_capacity(line.len());
        let mut i = 0;
        while i < bytes.len() {
            let c = bytes[i];
            if c.is_ascii_alphabetic() || c == b'_' {
                let start = i;
                i += 1;
                while i < bytes.len() && (bytes[i].is_ascii_alphanumeric() || bytes[i] == b'_') {
                    i += 1;
                }
                let ident = &line[start..i];
                out.push_str(&self.expand(ident));
            } else if c == b'"' {
                // Copy string literals verbatim so identifier-looking
                // bytes inside them aren't substituted.
                out.push('"');
                i += 1;
                while i < bytes.len() && bytes[i] != b'"' {
                    if bytes[i] == b'\\' && i + 1 < bytes.len() {
                        out.push(bytes[i] as char);
                        out.push(bytes[i + 1] as char);
                        i += 2;
                    } else {
                        out.push(bytes[i] as char);
                        i += 1;
                    }
                }
                if i < bytes.len() {
                    out.push('"');
                    i += 1;
                }
            } else {
                out.push(c as char);
                i += 1;
            }
        }
        out
    }

    /// Iteratively expand a single identifier through the macro
    /// table. If `name` isn't a macro, returns it unchanged.
    fn expand(&self, name: &str) -> String {
        let mut current = name.to_string();
        // Cap expansion depth to defeat pathological chains; 32 is
        // plenty for the macro-to-macro substitution the user asked for.
        for _ in 0..32 {
            match self.macros.get(&current) {
                Some(next) if next != &current => current = next.clone(),
                _ => break,
            }
        }
        current
    }

    fn eval_condition(&self, expr: &str, line_no: usize) -> Result<bool, C4Error> {
        let expr = expr.trim();
        if let Some((lhs, rhs)) = expr.split_once("==") {
            let l = self.expand(lhs.trim());
            let r = self.expand(rhs.trim());
            Ok(l == r)
        } else if let Some((lhs, rhs)) = expr.split_once("!=") {
            let l = self.expand(lhs.trim());
            let r = self.expand(rhs.trim());
            Ok(l != r)
        } else if let Some(name) = expr
            .strip_prefix("defined(")
            .and_then(|s| s.strip_suffix(')'))
        {
            Ok(self.macros.contains_key(name.trim()))
        } else if !expr.is_empty() && expr.chars().all(|c| c.is_ascii_alphanumeric() || c == '_') {
            // Bare identifier: truthy iff defined and the expansion
            // is a non-zero, non-empty value. Anything else lands in
            // the error path below so the source author notices.
            let v = self.expand(expr);
            Ok(!v.is_empty() && v != "0")
        } else {
            Err(C4Error::Compile(format!(
                "preprocessor:{line_no}: `#if` expression {expr:?} not understood (only `NAME`, \
                 `defined(NAME)`, `LHS == RHS`, `LHS != RHS` are supported)"
            )))
        }
    }

    /// Recognise `comment(dylib, "...")` and append the dylib path
    /// to the running list. Other pragmas are accepted silently --
    /// the c4 source already uses `#pragma` markers for things the
    /// preprocessor doesn't care about.
    fn parse_pragma(&mut self, args: &str, line_no: usize) -> Result<(), C4Error> {
        let args = args.trim();
        let Some(inner) = args
            .strip_prefix("comment(")
            .and_then(|s| s.strip_suffix(')'))
        else {
            return Ok(());
        };
        let inner = inner.trim();
        let Some(rest) = inner.strip_prefix("dylib") else {
            return Ok(());
        };
        let rest = rest.trim_start().strip_prefix(',').unwrap_or(rest).trim();
        let path = rest.trim_matches('"');
        if path.is_empty() {
            return Err(C4Error::Compile(format!(
                "preprocessor:{line_no}: `#pragma comment(dylib, ...)` is missing the path"
            )));
        }
        self.dylibs.push(path.to_string());
        Ok(())
    }
}

struct CondFrame {
    /// Whether the enclosing branch was active at the time of
    /// `#if` / `#ifdef`. A nested true branch inside an inactive
    /// outer branch must still be inactive.
    parent_active: bool,
    /// Whether *this* arm of the conditional emits source.
    this_branch_taken: bool,
    /// Whether *any* arm so far has emitted source. Used by
    /// `#else` to decide whether to take.
    any_branch_taken: bool,
    /// Already-seen `#else` -- a second one is a hard error.
    saw_else: bool,
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

enum Directive<'a> {
    Define(&'a str, &'a str),
    Undef(&'a str),
    Ifdef(&'a str),
    Ifndef(&'a str),
    If(&'a str),
    Else,
    Endif,
    Pragma(&'a str),
    Shebang,
    Other,
}

fn parse_directive(rest: &str) -> Directive<'_> {
    if let Some(after) = rest.strip_prefix("define") {
        let after = after.trim_start();
        let (name, body) = split_ident(after);
        return Directive::Define(name, body.trim());
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
    if rest.starts_with('!') {
        return Directive::Shebang;
    }
    Directive::Other
}

/// Split off the leading identifier in `s`, returning `(ident,
/// rest)`. Used to peel the macro name from its replacement text.
fn split_ident(s: &str) -> (&str, &str) {
    let bytes = s.as_bytes();
    let mut end = 0;
    while end < bytes.len() && (bytes[end].is_ascii_alphanumeric() || bytes[end] == b'_') {
        end += 1;
    }
    (&s[..end], &s[end..])
}

#[cfg(test)]
mod tests {
    use super::*;

    fn process(source: &str) -> String {
        let mut pp = Preprocessor::new("macos-aarch64", "0.1.0");
        pp.process(source).expect("preprocessor failed")
    }

    #[test]
    fn predefined_macros_expand() {
        let out = process("char *t = BADC_TARGET;\nchar *v = BADC_VERSION;\n");
        assert!(out.contains("\"macos-aarch64\""));
        assert!(out.contains("\"0.1.0\""));
    }

    #[test]
    fn define_substitutes_in_subsequent_lines() {
        let out = process("#define FOO 42\nint x = FOO;\n");
        assert!(out.contains("int x = 42;"));
    }

    #[test]
    fn macro_to_macro_substitution_chains() {
        let out = process("#define A B\n#define B 5\nint x = A;\n");
        assert!(out.contains("int x = 5;"));
    }

    #[test]
    fn ifdef_keeps_active_branch() {
        let src = "#define FOO 1\n#ifdef FOO\nint a;\n#else\nint b;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int a;"));
        assert!(!out.contains("int b;"));
    }

    #[test]
    fn ifndef_keeps_inactive_branch() {
        let src = "#ifndef BAR\nint a;\n#else\nint b;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int a;"));
        assert!(!out.contains("int b;"));
    }

    #[test]
    fn if_equality_checks_macro_value() {
        let src = "#if BADC_TARGET == \"macos-aarch64\"\nint mac;\n#else\nint other;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int mac;"));
        assert!(!out.contains("int other;"));
    }

    #[test]
    fn if_inequality_negates() {
        let src = "#if BADC_TARGET != \"windows-x64\"\nint here;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int here;"));
    }

    #[test]
    fn nested_conditionals_respect_parent() {
        let src = "#ifdef ABSENT\n#ifdef BADC_VERSION\nint inner;\n#endif\n#endif\nint outer;\n";
        let out = process(src);
        assert!(!out.contains("int inner;"));
        assert!(out.contains("int outer;"));
    }

    #[test]
    fn pragma_records_dylib() {
        let src = "#pragma comment(dylib, \"libfoo.so\")\n#pragma comment(dylib, \"bar.dll\")\n";
        let mut pp = Preprocessor::new("macos-aarch64", "0.1.0");
        pp.process(src).unwrap();
        assert_eq!(
            pp.dylibs,
            vec!["libfoo.so".to_string(), "bar.dll".to_string()]
        );
    }

    #[test]
    fn unmatched_endif_is_an_error() {
        let mut pp = Preprocessor::new("macos-aarch64", "0.1.0");
        let err = pp.process("#endif\n").unwrap_err();
        assert!(format!("{err}").contains("`#endif` with no matching `#if`"));
    }

    #[test]
    fn unterminated_block_is_an_error() {
        let mut pp = Preprocessor::new("macos-aarch64", "0.1.0");
        let err = pp.process("#ifdef FOO\nint x;\n").unwrap_err();
        assert!(format!("{err}").contains("unterminated"));
    }

    #[test]
    fn directives_become_blank_lines_for_line_alignment() {
        let src = "#define X 1\nint a = X;\n";
        let out = process(src);
        let lines: Vec<&str> = out.lines().collect();
        assert_eq!(lines.len(), 2);
        assert_eq!(lines[0], "");
        assert!(lines[1].contains("int a = 1;"));
    }

    #[test]
    fn string_literals_are_not_substituted() {
        let src = "#define X 1\nchar *s = \"X is a letter\";\n";
        let out = process(src);
        assert!(out.contains("\"X is a letter\""));
    }

    #[test]
    fn defined_form_works_in_if() {
        let src = "#if defined(BADC_VERSION)\nint a;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int a;"));
    }
}

//! Rudimentary preprocessor that runs before the lexer.
//!
//! The c5 dialect's lexer used to silently skip lines starting with
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
//! * `#pragma dylib(name, "path")` -- introduces a logical dylib
//!   the codegen can attach bindings to. `name` is the c5-side
//!   handle (e.g. `libc`); `path` is the actual loader-search-name
//!   or filesystem path (`libc.so.6`, `/usr/lib/libSystem.B.dylib`,
//!   `msvcrt.dll`).
//! * `#pragma binding(dylib_name::local_name, "real_symbol")` --
//!   declares that the c5-side identifier `local_name`, when called
//!   from source, should land on `real_symbol` exported by the
//!   dylib called `dylib_name`. The earlier positional "current
//!   dylib" form (`#pragma comment(dylib, ...)` with following
//!   bindings inheriting it implicitly) was replaced with this
//!   explicit cross-reference so reordering directives can't
//!   silently rebind a function to the wrong dylib.
//!
//! What's not:
//!
//! * Function-like macros (`#define MAX(a, b) ...`).
//! * Multi-line `#define` continuations.
//! * Token pasting / stringification.
//! * Boolean operators (`&&`, `||`, `!`) inside `#if`.
//!
//! Also supported:
//!
//! * `#include <name.h>` / `#include "name.h"` -- pulls a header out
//!   of the embedded-header registry (see [`super::headers`]). Both
//!   forms hit the same registry today; a future filesystem search
//!   path could split them. Cyclic `#include` is rejected; repeat
//!   inclusion is silently no-op iff the included file declared
//!   `#pragma once`.
//! * `#pragma once` -- once seen inside a header, further `#include`
//!   of the same header is dropped on the floor. The usual idiom
//!   for guarding against double-inclusion of standard headers.
//!
//! The pass is line-based: every line of the input either becomes
//! a (macro-substituted) line of the output or a blank line if it
//! was a directive / inactive branch. Line counts are preserved
//! one-for-one so error messages from the lexer keep meaningful
//! line numbers.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::codegen::Target;
use super::error::C5Error;
use super::headers::embedded_header;

/// One declared dylib plus the bindings that target it. Created
/// by `#pragma dylib(name, "path")`; populated by subsequent
/// `#pragma binding(name::c4_fn, "real_symbol")` directives that
/// reference this dylib through its `name`.
#[derive(Debug, Clone)]
pub(crate) struct DylibSpec {
    /// c5-side identifier for this dylib (e.g. `libc`, `kernel32`).
    /// Bindings reference it via their `name::c4_fn` left-hand
    /// side, so directive ordering in the header doesn't matter --
    /// a binding can sit anywhere relative to its dylib's
    /// declaration.
    pub name: String,
    /// Path or loader-search name (e.g. `/usr/lib/libSystem.B.dylib`
    /// on macOS, `libc.so.6` on Linux, `msvcrt.dll` on Windows).
    /// The codegen passes this through to the IAT entry / DT_NEEDED
    /// record verbatim.
    ///
    /// Read by tests; the codegen reaches the same path through the
    /// `ResolvedDylib` view it builds during import resolution.
    #[allow(dead_code)]
    pub path: String,
    /// Bindings whose qualifier referenced `Self::name`.
    pub bindings: Vec<Binding>,
}

/// One `#pragma binding(dylib::local_name, "real_symbol")` declaration.
/// Owned by the [`DylibSpec`] whose `name` matched the qualifier.
#[derive(Debug, Clone)]
pub(crate) struct Binding {
    /// `true` if the function's prototype ended with `, ...)` --
    /// e.g. `int printf(char *fmt, ...);`. The lowering reads
    /// this to decide whether the call site needs the
    /// platform's variadic-ABI dance (macOS arm64
    /// stack-packing, SysV `xor eax, eax`). Set by the parser
    /// when it folds a Sys symbol's prototype onto the binding;
    /// the preprocessor doesn't know about prototypes so it
    /// leaves this `false`.
    pub is_variadic: bool,
    /// Number of fixed (non-variadic) parameters from the
    /// prototype. macOS arm64 passes those in registers per
    /// standard AAPCS64; only the variadic tail spills to the
    /// stack. Set by the parser alongside `is_variadic`;
    /// meaningful only when `is_variadic == true` (otherwise
    /// the codegen reads the c5 stack directly without the
    /// register/stack split).
    pub fixed_args: usize,
    /// c5-side name the source uses (e.g. `printf`).
    pub local_name: String,
    /// Symbol name exported by the dylib. Differs from `local_name`
    /// on macOS (leading `_`) and for Windows aliases like
    /// `mprotect` -> `VirtualProtect`.
    ///
    /// Read by tests; the codegen consumes the same string through
    /// the `ResolvedImport` view it builds during import resolution.
    #[allow(dead_code)]
    pub real_symbol: String,
}

/// One function-like macro entry: parameter list + body. Object-like
/// macros are stored separately in `macros` as plain strings.
#[derive(Debug, Clone)]
struct FnMacro {
    params: Vec<String>,
    body: String,
}

/// Output of a successful preprocessor run: the substituted source
/// for the lexer plus the side data the codegen will pick up later.
pub(crate) struct Preprocessor {
    macros: BTreeMap<String, String>,
    fn_macros: BTreeMap<String, FnMacro>,
    /// One entry per `#pragma dylib(name, "path")`, in the order
    /// declared. Each entry collects the bindings whose
    /// `name::c4_fn` qualifier referenced its [`DylibSpec::name`].
    pub dylibs: Vec<DylibSpec>,
    /// One entry per `#pragma export(<name>)` directive, in
    /// declaration order. The compiler validates each name
    /// resolves to a function defined in this translation
    /// unit and threads the list onto `Program::exports`; the
    /// shared-object writers (Mach-O dylib, ELF .so, PE DLL)
    /// promote those symbols to externally visible entries
    /// in the symbol / export tables. Names not produced by
    /// `#pragma export(...)` keep file-scope-static linkage
    /// (the c5 default).
    pub exports: Vec<String>,
    /// Headers that opted in to single-inclusion via `#pragma once`.
    /// A subsequent `#include` of a name in this set is dropped.
    pragma_once_files: BTreeSet<String>,
    /// Names of headers currently being expanded, used to break
    /// cycles. Pushed on `#include`, popped when we finish processing
    /// the header.
    include_stack: Vec<String>,
}

impl Preprocessor {
    /// Build a preprocessor with the standard predefines set.
    ///
    /// Naming follows the gcc / clang / msvc convention of double
    /// underscores around tool-supplied macros so they don't
    /// collide with user identifiers:
    ///
    /// * `__BADC_VERSION__` -- the crate version, as a string
    ///   literal. Source can write `#if __BADC_VERSION__ == "0.1.0"`.
    /// * `__BADC_TARGET__` -- the canonical target id (e.g.
    ///   `"macos-aarch64"`), as a string literal. Used to gate
    ///   target-specific code at the source level.
    /// * CPU-architecture macros, all defined to `1` when active so
    ///   `#if __aarch64__` works the same way it does in gcc/clang:
    ///   * AArch64 targets get `__aarch64__` and `__arm64__` (the
    ///     latter is the Apple/clang spelling).
    ///   * x86_64 targets get `__x86_64__` and `__amd64__`.
    /// * OS macros, also defined to `1` when active, mirroring the
    ///   gcc / clang / msvc spelling so cross-platform headers
    ///   (`#ifdef __APPLE__`, `#ifdef __linux__`, `#ifdef _WIN32`)
    ///   work the way users already expect:
    ///   * macOS targets get `__APPLE__` and `__MACH__`.
    ///   * Linux targets get `__linux__` and `__unix__`.
    ///   * Windows targets get `_WIN32` (and `_WIN64`, since both of
    ///     our Windows targets are 64-bit) plus the legacy
    ///     `__BADC_WINDOWS__` we used before this commit.
    pub fn new(target_spec: &str, target: Target, crate_version: &str) -> Self {
        let mut macros = BTreeMap::new();
        macros.insert(
            "__BADC_VERSION__".to_string(),
            format!("\"{crate_version}\""),
        );
        macros.insert("__BADC_TARGET__".to_string(), format!("\"{target_spec}\""));
        match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
                macros.insert("__aarch64__".to_string(), "1".to_string());
                macros.insert("__arm64__".to_string(), "1".to_string());
            }
            Target::LinuxX64 | Target::WindowsX64 => {
                macros.insert("__x86_64__".to_string(), "1".to_string());
                macros.insert("__amd64__".to_string(), "1".to_string());
            }
        }
        match target {
            Target::MacOSAarch64 => {
                macros.insert("__APPLE__".to_string(), "1".to_string());
                macros.insert("__MACH__".to_string(), "1".to_string());
            }
            Target::LinuxAarch64 | Target::LinuxX64 => {
                macros.insert("__linux__".to_string(), "1".to_string());
                macros.insert("__unix__".to_string(), "1".to_string());
            }
            Target::WindowsX64 | Target::WindowsAarch64 => {
                macros.insert("_WIN32".to_string(), "1".to_string());
                macros.insert("_WIN64".to_string(), "1".to_string());
                macros.insert("__BADC_WINDOWS__".to_string(), "1".to_string());
            }
        }
        Self {
            macros,
            fn_macros: BTreeMap::new(),
            dylibs: Vec::new(),
            exports: Vec::new(),
            pragma_once_files: BTreeSet::new(),
            include_stack: Vec::new(),
        }
    }

    /// Run the preprocessor over `source` and return the substituted
    /// text suitable for the lexer. Within a single source file each
    /// input line maps to exactly one output line so lexer-level
    /// error reports stay grounded in the original buffer; an
    /// `#include` directive expands to (header_lines + 1) output
    /// lines, which shifts user-source line numbers downstream of
    /// the include but keeps lines *within* a file aligned.
    pub fn process(&mut self, source: &str) -> Result<String, C5Error> {
        self.process_named(source, "<source>")
    }

    /// Recursive entry point. `filename` labels the buffer so error
    /// messages and `#pragma once` can name what they're talking
    /// about; the top-level call uses `"<source>"`, `#include`'d
    /// files use the header name (`"stdio.h"`).
    fn process_named(&mut self, source: &str, filename: &str) -> Result<String, C5Error> {
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
                            self.fn_macros.remove(name);
                        }
                    }
                    Directive::DefineFn(name, params, body) => {
                        if active {
                            self.fn_macros.insert(
                                name.to_string(),
                                FnMacro {
                                    params: params.iter().map(|s| s.to_string()).collect(),
                                    body: body.to_string(),
                                },
                            );
                            self.macros.remove(name);
                        }
                    }
                    Directive::Undef(name) => {
                        if active {
                            self.macros.remove(name);
                            self.fn_macros.remove(name);
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
                            C5Error::Compile(format!(
                                "preprocessor:{line_no}: `#else` with no matching `#if`"
                            ))
                        })?;
                        if frame.saw_else {
                            return Err(C5Error::Compile(format!(
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
                            C5Error::Compile(format!(
                                "preprocessor:{line_no}: `#endif` with no matching `#if`"
                            ))
                        })?;
                        active = frame.parent_active;
                    }
                    Directive::Pragma(args) => {
                        if active {
                            match parse_pragma_directive(args) {
                                PragmaDirective::Once => {
                                    self.pragma_once_files.insert(filename.to_string());
                                }
                                PragmaDirective::Other => {
                                    self.parse_pragma(args, line_no)?;
                                }
                            }
                        }
                    }
                    Directive::Include(name) => {
                        if active {
                            let included = self.process_include(name, line_no)?;
                            out.push_str(&included);
                        }
                    }
                    Directive::Other => {
                        // Unknown directive -- mirror the historical
                        // lexer behaviour and skip silently. Anything
                        // a user is likely to misspell (`#defin` etc.)
                        // would be caught by the lexer downstream as
                        // a stray identifier.
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
            return Err(C5Error::Compile(
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
                // Function-like macro: only expands when the next
                // non-whitespace character is `(`. The C standard
                // allows whitespace between the name and the open
                // paren at *use* sites; we follow that.
                if let Some(macro_def) = self.fn_macros.get(ident) {
                    let mut j = i;
                    while j < bytes.len() && (bytes[j] == b' ' || bytes[j] == b'\t') {
                        j += 1;
                    }
                    if j < bytes.len()
                        && bytes[j] == b'('
                        && let Some((args, after)) = parse_macro_args(&line[j..])
                    {
                        let expanded = expand_fn_macro(macro_def, &args);
                        // Re-substitute so nested macro names inside
                        // the expansion get a chance too.
                        let recursed = self.substitute(&expanded);
                        out.push_str(&recursed);
                        i = j + after;
                        continue;
                    }
                }
                // Object-like expansion. Re-run substitute on the
                // result so a body that mentions a function-like
                // macro (e.g. `#define TWICE INC(INC(0))`) gets the
                // INC(...) calls expanded too.
                let expanded = self.expand(ident);
                if expanded == ident {
                    out.push_str(&expanded);
                } else {
                    out.push_str(&self.substitute(&expanded));
                }
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

    fn eval_condition(&self, expr: &str, line_no: usize) -> Result<bool, C5Error> {
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
            Err(C5Error::Compile(format!(
                "preprocessor:{line_no}: `#if` expression {expr:?} not understood (only `NAME`, \
                 `defined(NAME)`, `LHS == RHS`, `LHS != RHS` are supported)"
            )))
        }
    }

    /// Recognise `dylib(...)` and `binding(...)`. Other pragmas
    /// are accepted silently -- the c5 source already uses
    /// `#pragma` markers for things the preprocessor doesn't care
    /// about, and future tools may add their own.
    fn parse_pragma(&mut self, args: &str, line_no: usize) -> Result<(), C5Error> {
        let args = args.trim();
        if let Some(inner) = args
            .strip_prefix("dylib(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_dylib(inner.trim(), line_no);
        }
        if let Some(inner) = args
            .strip_prefix("binding(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_binding(inner.trim(), line_no);
        }
        if let Some(inner) = args
            .strip_prefix("export(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_export(inner.trim(), line_no);
        }
        Ok(())
    }

    /// `#pragma export(<name>)` -- mark a function defined in
    /// this translation unit as externally visible. The
    /// compiler validates the name resolves to a `Token::Fun`
    /// symbol after the parse pass, and the shared-object
    /// writers (`Target::*` plus the upcoming `OutputKind::SharedLibrary`
    /// shape) promote it to a real export entry.
    ///
    /// Plain identifiers only -- no quoted-name aliasing today
    /// (we'd need a syntax like `export(local_name, "real_name")`
    /// to follow the `#pragma binding(...)` shape, but the
    /// inverse direction; not needed for the initial cut).
    fn parse_pragma_export(&mut self, inner: &str, line_no: usize) -> Result<(), C5Error> {
        let name = inner.trim();
        if !is_ident(name) {
            return Err(C5Error::Compile(format!(
                "preprocessor:{line_no}: `#pragma export({name})` -- name must be a \
                 plain identifier"
            )));
        }
        if !self.exports.iter().any(|e| e == name) {
            self.exports.push(name.to_string());
        }
        Ok(())
    }

    /// `#pragma dylib(name, "path")` -- introduce a logical dylib
    /// the codegen can attach bindings to. `name` is an
    /// identifier-style c5-side handle (`libc`, `kernel32`, ...);
    /// `path` is the actual loader-search-name or filesystem path.
    fn parse_pragma_dylib(&mut self, inner: &str, line_no: usize) -> Result<(), C5Error> {
        let Some((name, path)) = inner.split_once(',') else {
            return Err(C5Error::Compile(format!(
                "preprocessor:{line_no}: `#pragma dylib(...)` expects two args \
                 (`name, \"path\"`)"
            )));
        };
        let name = name.trim();
        let path = path.trim().trim_matches('"');
        if name.is_empty() || path.is_empty() {
            return Err(C5Error::Compile(format!(
                "preprocessor:{line_no}: `#pragma dylib(...)` arg is empty"
            )));
        }
        if !is_ident(name) {
            return Err(C5Error::Compile(format!(
                "preprocessor:{line_no}: `#pragma dylib({name}, ...)` -- name must be a \
                 plain identifier"
            )));
        }
        if let Some(existing) = self.dylibs.iter().find(|d| d.name == name) {
            // Re-declaring an identical dylib is fine -- standard
            // headers (`<stdio.h>`, `<string.h>`) all bind to the
            // same `libc` / `msvcrt`, so a source that includes
            // both will hit this twice. Different paths are still
            // a hard error since they'd silently shadow each other.
            if existing.path != path {
                return Err(C5Error::Compile(format!(
                    "preprocessor:{line_no}: `#pragma dylib({name}, {path:?})` -- already declared with different path {:?}",
                    existing.path
                )));
            }
            return Ok(());
        }
        self.dylibs.push(DylibSpec {
            name: name.to_string(),
            path: path.to_string(),
            bindings: Vec::new(),
        });
        Ok(())
    }

    /// `#include <name>` / `#include "name"` -- splice the named
    /// header's processed contents into the output.
    ///
    /// The header is looked up in [`super::headers::embedded_header`].
    /// Unknown names silently no-op so legacy sources sprinkled with
    /// `#include <fcntl.h>` for documentation don't break. Cyclic
    /// `#include` returns an error; repeat inclusion of a header
    /// that previously declared `#pragma once` returns an empty
    /// string.
    fn process_include(&mut self, name: &str, line_no: usize) -> Result<String, C5Error> {
        if self.pragma_once_files.contains(name) {
            return Ok(String::new());
        }
        let Some(content) = embedded_header(name) else {
            // Unknown header: drop it on the floor and let any
            // missing-symbol error fall out of the lexer / codegen
            // downstream. Matches the historical pre-`#include`
            // behaviour.
            return Ok(String::new());
        };
        if self.include_stack.iter().any(|f| f == name) {
            let chain = self.include_stack.join(" -> ");
            return Err(C5Error::Compile(format!(
                "preprocessor:{line_no}: cyclic `#include {name}` (chain: {chain} -> {name})"
            )));
        }
        self.include_stack.push(name.to_string());
        let result = self.process_named(content, name);
        self.include_stack.pop();
        result
    }

    /// `#pragma binding(dylib::local_name, "real_symbol")` -- record
    /// `local_name`'s mapping to `real_symbol` inside the dylib named
    /// `dylib`. The dylib must already have been declared by a
    /// `#pragma dylib(...)`; the directives can otherwise appear in
    /// any order.
    fn parse_pragma_binding(&mut self, inner: &str, line_no: usize) -> Result<(), C5Error> {
        let Some((qualified, real_symbol)) = inner.split_once(',') else {
            return Err(C5Error::Compile(format!(
                "preprocessor:{line_no}: `#pragma binding(...)` expects two args \
                 (`dylib::local_name, \"real_symbol\"`)"
            )));
        };
        let qualified = qualified.trim();
        let real_symbol = real_symbol.trim().trim_matches('"');
        let Some((dylib_name, local_name)) = qualified.split_once("::") else {
            return Err(C5Error::Compile(format!(
                "preprocessor:{line_no}: `#pragma binding({qualified}, ...)` -- LHS must be \
                 `dylib_name::local_name`"
            )));
        };
        let dylib_name = dylib_name.trim();
        let local_name = local_name.trim();
        if dylib_name.is_empty() || local_name.is_empty() || real_symbol.is_empty() {
            return Err(C5Error::Compile(format!(
                "preprocessor:{line_no}: `#pragma binding(...)` arg is empty"
            )));
        }
        let Some(dylib) = self.dylibs.iter_mut().find(|d| d.name == dylib_name) else {
            return Err(C5Error::Compile(format!(
                "preprocessor:{line_no}: `#pragma binding({dylib_name}::...)` -- no `#pragma \
                 dylib({dylib_name}, ...)` declared"
            )));
        };
        dylib.bindings.push(Binding {
            is_variadic: false,
            fixed_args: 0,
            local_name: local_name.to_string(),
            real_symbol: real_symbol.to_string(),
        });
        Ok(())
    }
}

/// Identifier check: ASCII letter or `_` to start, alnum or `_`
/// after. Used to reject `#pragma dylib(123foo, ...)` and similar
/// up-front so the codegen never has to worry about quirks in the
/// dylib `name`.
fn is_ident(s: &str) -> bool {
    let mut bytes = s.bytes();
    let Some(first) = bytes.next() else {
        return false;
    };
    if !(first.is_ascii_alphabetic() || first == b'_') {
        return false;
    }
    bytes.all(|b| b.is_ascii_alphanumeric() || b == b'_')
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
    Endif,
    Pragma(&'a str),
    Include(&'a str),
    Shebang,
    Other,
}

/// Sub-classification of `#pragma` payloads. `dylib(...)` /
/// `binding(...)` go to [`Preprocessor::parse_pragma`] and live in
/// the dylib registry; `once` is structural (it tags the *current*
/// header) and lives on the preprocessor itself.
enum PragmaDirective {
    Once,
    Other,
}

fn parse_pragma_directive(args: &str) -> PragmaDirective {
    if args.trim() == "once" {
        PragmaDirective::Once
    } else {
        PragmaDirective::Other
    }
}

fn parse_directive(rest: &str) -> Directive<'_> {
    if let Some(after) = rest.strip_prefix("define") {
        let after = after.trim_start();
        let (name, rest_after_name) = split_ident(after);
        // Strip `//` line comments from the macro body. Otherwise
        // `#define X 42 // a constant` would expand to "42 // a
        // constant", and the comment text would either swallow the
        // rest of the substitution line (lexer treats `//` as
        // line-comment) or land in the token stream and break
        // parsing. C `/* ... */` comments inside macro bodies
        // aren't supported elsewhere in this dialect, so we don't
        // try to strip those.
        let stripped = match rest_after_name.find("//") {
            Some(i) => &rest_after_name[..i],
            None => rest_after_name,
        };
        // Function-like form: name immediately followed by `(`. The
        // C standard requires no whitespace between the name and the
        // open paren -- a space turns it into an object-like macro
        // whose body starts with `(`. An unclosed paren falls through
        // to the object-like branch with the whole tail as the body,
        // matching how the lexer would see a syntactically broken
        // `#define`.
        if let Some(after_paren) = stripped.strip_prefix('(')
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
        return Directive::Define(name, stripped.trim());
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
    if let Some(after) = rest.strip_prefix("include") {
        let trimmed = after.trim();
        // Strip the `<...>` or `"..."` wrapping. Anything else falls
        // through to `Directive::Other` and is silently dropped, the
        // same as malformed `#define` lines.
        if let Some(name) = trimmed
            .strip_prefix('<')
            .and_then(|s| s.strip_suffix('>'))
            .or_else(|| trimmed.strip_prefix('"').and_then(|s| s.strip_suffix('"')))
        {
            return Directive::Include(name.trim());
        }
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

/// Parse a comma-separated argument list of a function-like macro
/// invocation. `s` must start at the `(` character. Returns the args
/// (string slices, trimmed) and the byte offset of the position
/// *after* the matching `)` -- relative to `s`. Nested parentheses
/// (e.g. `MACRO(f(x), g(y))`) and string/char literals are tracked so
/// commas inside them don't split. Returns `None` if `s` doesn't open
/// with `(` or the parens are unbalanced.
fn parse_macro_args(s: &str) -> Option<(Vec<String>, usize)> {
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
                    if !current.is_empty() || !args.is_empty() {
                        args.push(current.trim().to_string());
                    }
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
                // / parens inside don't perturb the depth counter.
                let quote = c;
                current.push(c as char);
                i += 1;
                while i < bytes.len() && bytes[i] != quote {
                    if bytes[i] == b'\\' && i + 1 < bytes.len() {
                        current.push(bytes[i] as char);
                        current.push(bytes[i + 1] as char);
                        i += 2;
                    } else {
                        current.push(bytes[i] as char);
                        i += 1;
                    }
                }
                if i < bytes.len() {
                    current.push(quote as char);
                    i += 1;
                }
            }
            _ => {
                current.push(c as char);
                i += 1;
            }
        }
    }
    None
}

/// Substitute `params` for `args` in a function-like macro body.
/// Whole-word match -- a parameter named `T` replaces only the
/// identifier `T`, never `T` inside another word like `Tx`.
fn expand_fn_macro(def: &FnMacro, args: &[String]) -> String {
    let bytes = def.body.as_bytes();
    let mut out = String::with_capacity(def.body.len());
    let mut i = 0;
    while i < bytes.len() {
        let c = bytes[i];
        if c.is_ascii_alphabetic() || c == b'_' {
            let start = i;
            i += 1;
            while i < bytes.len() && (bytes[i].is_ascii_alphanumeric() || bytes[i] == b'_') {
                i += 1;
            }
            let word = &def.body[start..i];
            match def.params.iter().position(|p| p == word) {
                Some(idx) if idx < args.len() => out.push_str(&args[idx]),
                _ => out.push_str(word),
            }
        } else if c == b'"' || c == b'\'' {
            // Pass literals through unchanged so identifier-like
            // bytes inside don't get substituted.
            let quote = c;
            out.push(c as char);
            i += 1;
            while i < bytes.len() && bytes[i] != quote {
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
                out.push(quote as char);
                i += 1;
            }
        } else {
            out.push(c as char);
            i += 1;
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    fn process(source: &str) -> String {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.process(source).expect("preprocessor failed")
    }

    #[test]
    fn predefined_macros_expand() {
        let out = process("char *t = __BADC_TARGET__;\nchar *v = __BADC_VERSION__;\n");
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
    fn function_like_macro_substitutes_params() {
        let out = process("#define ADD(a, b) ((a) + (b))\nint x = ADD(1, 2);\n");
        assert!(
            out.contains("int x = ((1) + (2));"),
            "fn-like macro should substitute both params:\n{out}"
        );
    }

    #[test]
    fn function_like_macro_preserves_nested_call_args() {
        // Args with nested parens / calls shouldn't be split by the
        // top-level comma scanner.
        let out = process("#define WRAP(x) f(x)\nint y = WRAP(g(1, 2));\n");
        assert!(
            out.contains("int y = f(g(1, 2));"),
            "nested-paren args should round-trip:\n{out}"
        );
    }

    #[test]
    fn function_like_macro_only_fires_when_followed_by_paren() {
        // `va_end` style: calling with parens expands; the bare name
        // (no parens) stays a plain identifier.
        let out = process("#define NOOP(x)\nNOOP(arg);\nint NOOP;\n");
        assert!(out.contains(";\nint NOOP;"));
    }

    #[test]
    fn fn_like_macro_recurses_through_other_macros() {
        // An object-like macro whose body contains a function-like
        // macro call should re-expand: TWICE -> INC(INC(0)) -> the
        // INC names disappear and a `+ 1` appears twice. The exact
        // paren shape depends on what each INC step adds, so the
        // test pins the structural facts rather than the literal
        // spelling.
        let out = process("#define INC(n) ((n) + 1)\n#define TWICE INC(INC(0))\nint x = TWICE;\n");
        assert!(!out.contains("INC"), "INC should be fully expanded:\n{out}");
        assert_eq!(
            out.matches("+ 1").count(),
            2,
            "two increments expected:\n{out}"
        );
    }

    #[test]
    fn define_strips_trailing_line_comment() {
        // Without the strip, the substitution would expand to
        // `int x = 42 // a constant ;` and the lexer's `//` would
        // swallow the trailing `;`, breaking parsing entirely.
        let out = process("#define FOO 42 // a constant\nint x = FOO;\n");
        assert!(
            out.contains("int x = 42;"),
            "expected `int x = 42;` after macro expansion, got:\n{out}"
        );
        assert!(!out.contains("// a constant"));
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
        let src = "#if __BADC_TARGET__ == \"macos-aarch64\"\nint mac;\n#else\nint other;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int mac;"));
        assert!(!out.contains("int other;"));
    }

    #[test]
    fn if_inequality_negates() {
        let src = "#if __BADC_TARGET__ != \"windows-x64\"\nint here;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int here;"));
    }

    #[test]
    fn nested_conditionals_respect_parent() {
        let src =
            "#ifdef ABSENT\n#ifdef __BADC_VERSION__\nint inner;\n#endif\n#endif\nint outer;\n";
        let out = process(src);
        assert!(!out.contains("int inner;"));
        assert!(out.contains("int outer;"));
    }

    #[test]
    fn pragma_records_dylib() {
        let src = "\
#pragma dylib(libfoo, \"libfoo.so\")
#pragma dylib(bar, \"bar.dll\")
";
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.process(src).unwrap();
        let entries: Vec<(&str, &str)> = pp
            .dylibs
            .iter()
            .map(|d| (d.name.as_str(), d.path.as_str()))
            .collect();
        assert_eq!(entries, vec![("libfoo", "libfoo.so"), ("bar", "bar.dll")]);
    }

    #[test]
    fn pragma_binding_attaches_to_named_dylib() {
        let src = "\
#pragma dylib(libfoo, \"libfoo.so\")
#pragma dylib(libbar, \"libbar.so\")
#pragma binding(libfoo::printf, \"_printf\")
#pragma binding(libbar::exit, \"ExitProcess\")
#pragma binding(libfoo::malloc, \"_malloc\")
";
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.process(src).unwrap();
        assert_eq!(pp.dylibs.len(), 2);
        assert_eq!(pp.dylibs[0].name, "libfoo");
        assert_eq!(pp.dylibs[0].bindings.len(), 2);
        assert_eq!(pp.dylibs[0].bindings[0].local_name, "printf");
        assert_eq!(pp.dylibs[0].bindings[0].real_symbol, "_printf");
        assert_eq!(pp.dylibs[0].bindings[1].local_name, "malloc");
        assert_eq!(pp.dylibs[1].name, "libbar");
        assert_eq!(pp.dylibs[1].bindings.len(), 1);
        assert_eq!(pp.dylibs[1].bindings[0].local_name, "exit");
        assert_eq!(pp.dylibs[1].bindings[0].real_symbol, "ExitProcess");
    }

    #[test]
    fn pragma_binding_for_undeclared_dylib_errors() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let err = pp
            .process("#pragma binding(libnothing::printf, \"_printf\")\n")
            .unwrap_err();
        assert!(format!("{err}").contains("no `#pragma dylib(libnothing, ...)`"));
    }

    #[test]
    fn pragma_binding_without_qualifier_errors() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let err = pp
            .process("#pragma dylib(libfoo, \"x\")\n#pragma binding(printf, \"p\")\n")
            .unwrap_err();
        assert!(format!("{err}").contains("LHS must be `dylib_name::local_name`"));
    }

    #[test]
    fn pragma_dylib_duplicate_errors() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let err = pp
            .process("#pragma dylib(libfoo, \"x\")\n#pragma dylib(libfoo, \"y\")\n")
            .unwrap_err();
        assert!(format!("{err}").contains("already declared"));
    }

    #[test]
    fn unmatched_endif_is_an_error() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let err = pp.process("#endif\n").unwrap_err();
        assert!(format!("{err}").contains("`#endif` with no matching `#if`"));
    }

    #[test]
    fn unterminated_block_is_an_error() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
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
        let src = "#if defined(__BADC_VERSION__)\nint a;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int a;"));
    }

    #[test]
    fn unknown_include_is_silently_dropped() {
        // Headers not in the embedded registry should no-op so legacy
        // sources sprinkled with `#include <fcntl.h>` keep building
        // until a real header takes that slot.
        let out = process("#include <not-a-real-header.h>\nint main() { return 0; }\n");
        assert!(out.contains("int main()"));
    }

    #[test]
    fn quoted_include_form_is_recognised() {
        // `"foo.h"` and `<foo.h>` go through the same registry today.
        // The quoted form is still parsed -- we'd just look it up the
        // same way -- so an unknown name no-ops cleanly.
        let out = process("#include \"not-a-real-header.h\"\nint main() {}\n");
        assert!(out.contains("int main()"));
    }
}

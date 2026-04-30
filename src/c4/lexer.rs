use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::error::C4Error;
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

    /// Advance to the next token. Identifiers are interned into `symbols`; string
    /// literals are appended to `data` and `ival` is set to their start address.
    pub fn next(&mut self, symbols: &mut Vec<Symbol>, data: &mut Vec<u8>) -> Result<(), C4Error> {
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
                // Skip the rest of the line. Covers both C-style
                // preprocessor directives (`#include`, `#define`, ...) -- c4
                // doesn't run a preprocessor, it just ignores them -- and
                // a leading shebang line so source files can be made
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
                let name_vec = self.src[start..self.pos].to_vec();
                self.curr_id_idx = resolve_symbol(symbols, &name_vec, hash);
                self.tk = symbols[self.curr_id_idx].token;
                return Ok(());
            } else if c.is_ascii_digit() {
                let mut val = (c as u8 - b'0') as i64;
                if val == 0
                    && self.pos < self.src.len()
                    && (self.src[self.pos] as char == 'x' || self.src[self.pos] as char == 'X')
                {
                    self.pos += 1;
                    while self.pos < self.src.len() {
                        let nc = self.src[self.pos] as char;
                        if nc.is_ascii_digit() {
                            val = val * 16 + (nc as u8 - b'0') as i64;
                        } else if ('a'..='f').contains(&nc) {
                            val = val * 16 + (nc as u8 - b'a' + 10) as i64;
                        } else if ('A'..='F').contains(&nc) {
                            val = val * 16 + (nc as u8 - b'A' + 10) as i64;
                        } else {
                            break;
                        }
                        self.pos += 1;
                    }
                } else {
                    while self.pos < self.src.len() {
                        let nc = self.src[self.pos] as char;
                        if !nc.is_ascii_digit() {
                            break;
                        }
                        val = val * 10 + (nc as u8 - b'0') as i64;
                        self.pos += 1;
                    }
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
                        val = self.src[self.pos] as i64;
                        self.pos += 1;
                        if val == 'n' as i64 {
                            val = '\n' as i64;
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
                            self.pos += 1;
                            self.tk = Token::ShlOp as i64;
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
                            self.tk = Token::ShrOp as i64;
                        } else {
                            self.tk = Token::GtOp as i64;
                        }
                    }
                    '|' => {
                        if next_char == '|' {
                            self.pos += 1;
                            self.tk = Token::Lor as i64;
                        } else {
                            self.tk = Token::OrOp as i64;
                        }
                    }
                    '&' => {
                        if next_char == '&' {
                            self.pos += 1;
                            self.tk = Token::Lan as i64;
                        } else {
                            self.tk = Token::AndOp as i64;
                        }
                    }
                    '^' => self.tk = Token::XorOp as i64,
                    '%' => self.tk = Token::ModOp as i64,
                    '*' => self.tk = Token::MulOp as i64,
                    '[' => self.tk = Token::Brak as i64,
                    '?' => self.tk = Token::Cond as i64,
                    '.' => {
                        // Three consecutive dots -> variadic ellipsis. A
                        // single dot isn't a token anywhere in the c4
                        // dialect, so treat anything else as junk and
                        // skip it (same fall-through as the catch-all).
                        if self.pos + 1 < self.src.len()
                            && self.src[self.pos] == b'.'
                            && self.src[self.pos + 1] == b'.'
                        {
                            self.pos += 2;
                            self.tk = Token::Ellipsis as i64;
                        } else {
                            continue;
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

pub(crate) fn find_symbol(symbols: &[Symbol], name: &str) -> Option<usize> {
    symbols.iter().position(|s| s.name == name)
}

pub(crate) fn resolve_symbol(symbols: &mut Vec<Symbol>, name: &[u8], hash: i64) -> usize {
    for (i, s) in symbols.iter().enumerate().rev() {
        if s.hash == hash && s.token != 0 && s.name.as_bytes() == name {
            return i;
        }
    }
    symbols.push(Symbol {
        name: String::from_utf8_lossy(name).to_string(),
        hash,
        token: Token::Id as i64,
        ..Default::default()
    });
    symbols.len() - 1
}

fn add_keyword(symbols: &mut Vec<Symbol>, name: &str, token: i64) {
    let hash = hash_name(name.as_bytes());
    symbols.push(Symbol {
        name: name.to_string(),
        hash,
        token,
        ..Default::default()
    });
}

/// Reserved words that map to a non-`Id` token. Library function
/// names used to be listed here so the lexer's pre-seeded set could
/// upgrade them to `Token::Sys` later; the
/// `#pragma binding(...)`-driven seeding now picks each binding's
/// `c4_name` up dynamically, so the only Id-class entry left is the
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
    ("void", Token::Char),
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
/// `c4_name`) gets the *first* index; later bindings are ignored
/// here since the symbol table only holds one entry per name.
/// `#include`-time deduplication via `#pragma once` makes that the
/// expected case.
pub(crate) fn init_symbols(
    symbols: &mut Vec<Symbol>,
    dylibs: &[super::preprocessor::DylibSpec],
) {
    for (name, tok) in KEYWORDS {
        add_keyword(symbols, name, *tok as i64);
    }

    let mut binding_idx: i64 = 0;
    for spec in dylibs {
        for binding in &spec.bindings {
            let name = binding.c4_name.as_str();
            if find_symbol(symbols, name).is_none() {
                let hash = hash_name(name.as_bytes());
                symbols.push(Symbol {
                    name: name.to_string(),
                    hash,
                    token: Token::Id as i64,
                    class: Token::Sys as i64,
                    type_: Ty::Int as i64,
                    val: binding_idx,
                    ..Default::default()
                });
            }
            binding_idx += 1;
        }
    }

    // Ensure main is registered so the compiler's later lookup sees it.
    let _ = find_symbol(symbols, "main").unwrap();
}

//! GNU ld linker-script front end: lexer, parser, and AST.
//!
//! Covers the grammar the Linux kernel's generated scripts use
//! (`vmlinux.lds`, `module.lds`): `SECTIONS` with output sections,
//! input-section specs with glob patterns and SORT variants, symbol
//! assignment (plain / PROVIDE / HIDDEN), location-counter arithmetic,
//! `ASSERT`, `PHDRS`, `ENTRY`, `OUTPUT_FORMAT` / `OUTPUT_ARCH`, and
//! data commands (`BYTE` .. `QUAD`, `FILL`, `CONSTRUCTORS`).
//!
//! Expression evaluation lives with the layout engine; this module
//! only builds the tree. The lexer runs in two states the parser
//! selects per position -- pattern state, where `*?[]-+` are name
//! constituents (glob syntax), and expression state, where they are
//! operators -- the same split GNU ld and lld use.

#![cfg(feature = "std")]
#![allow(dead_code)]

use alloc::boxed::Box;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use crate::c5::error::C5Error;

fn err(msg: &str) -> C5Error {
    C5Error::Compile(format!("error: linker script: {msg}"))
}

// ---------------------------------------------------------------- AST

#[derive(Debug, Clone, PartialEq)]
pub enum Expr {
    Number(u64),
    /// A symbol reference; `.` is the location counter.
    Symbol(String),
    Unary(UnOp, Box<Expr>),
    Binary(BinOp, Box<Expr>, Box<Expr>),
    Ternary(Box<Expr>, Box<Expr>, Box<Expr>),
    /// `ALIGN(align)` -- the location counter aligned up.
    AlignDot(Box<Expr>),
    /// `ALIGN(value, align)`.
    Align2(Box<Expr>, Box<Expr>),
    Absolute(Box<Expr>),
    Addr(String),
    Loadaddr(String),
    Sizeof(String),
    Alignof(String),
    SizeofHeaders,
    Defined(String),
    Min(Box<Expr>, Box<Expr>),
    Max(Box<Expr>, Box<Expr>),
    /// `ASSERT(expr, "message")` -- evaluates to `expr`, errors when zero.
    Assert(Box<Expr>, String),
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum UnOp {
    Neg,
    Not,
    BitNot,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BinOp {
    Add,
    Sub,
    Mul,
    Div,
    Rem,
    Shl,
    Shr,
    Eq,
    Ne,
    Lt,
    Le,
    Gt,
    Ge,
    BitAnd,
    BitOr,
    BitXor,
    LogAnd,
    LogOr,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum AssignOp {
    Set,
    Add,
    Sub,
    Mul,
    Div,
    Shl,
    Shr,
    And,
    Or,
}

#[derive(Debug, Clone, PartialEq)]
pub struct Assignment {
    /// Target symbol; `.` moves the location counter.
    pub symbol: String,
    pub op: AssignOp,
    pub value: Expr,
    /// `PROVIDE` / `PROVIDE_HIDDEN`: define only if referenced and
    /// not defined by any input.
    pub provide: bool,
    /// `HIDDEN` / `PROVIDE_HIDDEN`: `STV_HIDDEN` in the output.
    pub hidden: bool,
}

/// Sort order requested by a `SORT*` wrapper on a section pattern.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum SortKind {
    None,
    /// `SORT` / `SORT_BY_NAME`.
    ByName,
    ByAlignment,
}

#[derive(Debug, Clone, PartialEq)]
pub struct SectionPattern {
    pub pattern: String,
    pub sort: SortKind,
    /// `EXCLUDE_FILE(globs)` preceding this pattern.
    pub exclude_files: Vec<String>,
}

/// One input-section spec: `file(patterns)`, e.g. `*(.text .text.*)`.
#[derive(Debug, Clone, PartialEq)]
pub struct InputSpec {
    pub file: String,
    /// `SORT(...)` around the file glob.
    pub file_sort: SortKind,
    /// Empty for a bare-file spec (`foo.o` alone), which takes every
    /// section of the file.
    pub patterns: Vec<SectionPattern>,
    pub keep: bool,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DataWidth {
    Byte,
    Short,
    Long,
    Quad,
}

impl DataWidth {
    pub fn size(self) -> u64 {
        match self {
            DataWidth::Byte => 1,
            DataWidth::Short => 2,
            DataWidth::Long => 4,
            DataWidth::Quad => 8,
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum SectionContent {
    Assign(Assignment),
    Assert(Expr, String),
    Input(InputSpec),
    Data(DataWidth, Expr),
    Fill(Expr),
    /// `CONSTRUCTORS` -- a.out-era ctor lists; empty on ELF, kept so
    /// the statement parses.
    Constructors,
}

/// `(NOLOAD)` / `(INFO)` -- the output-section type keywords in use.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum OutputSectionType {
    NoLoad,
    /// `INFO` / `DSECT` / `COPY`: not allocated, keeps no address.
    Info,
}

#[derive(Debug, Clone, PartialEq)]
pub struct OutputSection {
    pub name: String,
    pub address: Option<Expr>,
    pub stype: Option<OutputSectionType>,
    /// `AT(expr)` load address.
    pub at: Option<Expr>,
    /// `ALIGN(expr)` attribute (after the colon).
    pub align: Option<Expr>,
    pub subalign: Option<Expr>,
    pub contents: Vec<SectionContent>,
    /// `:phdr` placements after the closing brace.
    pub phdrs: Vec<String>,
    /// `= expr` fill pattern after the closing brace.
    pub fill: Option<Expr>,
}

#[derive(Debug, Clone, PartialEq)]
pub enum SectionsItem {
    Assign(Assignment),
    Assert(Expr, String),
    Output(OutputSection),
}

#[derive(Debug, Clone, PartialEq)]
pub struct PhdrDef {
    pub name: String,
    /// `p_type` value (`PT_LOAD`, `PT_NOTE`, ... or a number).
    pub ptype: u32,
    pub filehdr: bool,
    pub phdrs: bool,
    pub at: Option<Expr>,
    pub flags: Option<Expr>,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Command {
    OutputFormat(Vec<String>),
    OutputArch(String),
    Entry(String),
    Assign(Assignment),
    Assert(Expr, String),
    Phdrs(Vec<PhdrDef>),
    Sections(Vec<SectionsItem>),
}

#[derive(Debug, Clone, Default, PartialEq)]
pub struct LinkerScript {
    pub commands: Vec<Command>,
}

impl LinkerScript {
    pub fn sections(&self) -> Option<&[SectionsItem]> {
        self.commands.iter().find_map(|c| match c {
            Command::Sections(v) => Some(v.as_slice()),
            _ => None,
        })
    }
    pub fn phdrs(&self) -> Option<&[PhdrDef]> {
        self.commands.iter().find_map(|c| match c {
            Command::Phdrs(v) => Some(v.as_slice()),
            _ => None,
        })
    }
    pub fn entry(&self) -> Option<&str> {
        self.commands.iter().find_map(|c| match c {
            Command::Entry(s) => Some(s.as_str()),
            _ => None,
        })
    }
}

// -------------------------------------------------------------- lexer

/// Lexing state. Pattern state treats glob punctuation as name
/// constituents; expression state treats it as operators.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum LexState {
    Pattern,
    Expr,
}

#[derive(Debug, Clone, PartialEq)]
enum Tok {
    /// Name / pattern / number-looking word.
    Word(String),
    /// Quoted string literal (quotes removed).
    Str(String),
    /// Operator or punctuation, as spelled.
    Punct(&'static str),
    Eof,
}

impl Tok {
    fn is(&self, p: &str) -> bool {
        matches!(self, Tok::Punct(q) if *q == p)
    }
    fn word(&self) -> Option<&str> {
        match self {
            Tok::Word(w) => Some(w),
            _ => None,
        }
    }
}

const PUNCTS: &[&str] = &[
    "<<=", ">>=", "+=", "-=", "*=", "/=", "&=", "|=", "<<", ">>", "<=", ">=", "==", "!=", "&&",
    "||", "(", ")", "{", "}", ";", ",", ":", "?", "=", "+", "-", "*", "/", "%", "<", ">", "&", "|",
    "^", "~", "!", ".",
];

struct Lexer<'a> {
    src: &'a [u8],
    pos: usize,
    line: u32,
}

impl<'a> Lexer<'a> {
    fn new(src: &'a str) -> Self {
        Lexer {
            src: src.as_bytes(),
            pos: 0,
            line: 1,
        }
    }

    fn skip_space(&mut self) -> Result<(), C5Error> {
        loop {
            while self.pos < self.src.len() {
                let c = self.src[self.pos];
                if c == b'\n' {
                    self.line += 1;
                    self.pos += 1;
                } else if c.is_ascii_whitespace() {
                    self.pos += 1;
                } else {
                    break;
                }
            }
            if self.src[self.pos..].starts_with(b"/*") {
                let mut i = self.pos + 2;
                loop {
                    if i + 1 >= self.src.len() {
                        return Err(err(&format!("line {}: unterminated /* comment", self.line)));
                    }
                    if self.src[i] == b'\n' {
                        self.line += 1;
                    }
                    if &self.src[i..i + 2] == b"*/" {
                        break;
                    }
                    i += 1;
                }
                self.pos = i + 2;
                continue;
            }
            if self.src[self.pos..].starts_with(b"//") {
                while self.pos < self.src.len() && self.src[self.pos] != b'\n' {
                    self.pos += 1;
                }
                continue;
            }
            return Ok(());
        }
    }

    fn word_char(c: u8, state: LexState) -> bool {
        if c.is_ascii_alphanumeric() || matches!(c, b'_' | b'$') {
            return true;
        }
        match state {
            // `.` participates in names in both states (`.text`, and
            // the location counter is handled by the parser).
            LexState::Expr => c == b'.',
            LexState::Pattern => {
                matches!(
                    c,
                    b'.' | b'/' | b'\\' | b'~' | b'+' | b'[' | b']' | b'*' | b'?' | b'-' | b'^'
                )
            }
        }
    }

    /// Lex one token at `pos` in the given state without consuming.
    fn peek(&mut self, state: LexState) -> Result<(Tok, usize), C5Error> {
        self.skip_space()?;
        if self.pos >= self.src.len() {
            return Ok((Tok::Eof, self.pos));
        }
        let c = self.src[self.pos];
        if c == b'"' {
            let mut i = self.pos + 1;
            while i < self.src.len() && self.src[i] != b'"' {
                i += 1;
            }
            if i >= self.src.len() {
                return Err(err(&format!("line {}: unterminated string", self.line)));
            }
            let s = core::str::from_utf8(&self.src[self.pos + 1..i])
                .map_err(|_| err("string literal is not UTF-8"))?;
            return Ok((Tok::Str(s.to_string()), i + 1));
        }
        if Self::word_char(c, state) && !(state == LexState::Expr && c == b'.') {
            let mut i = self.pos;
            while i < self.src.len() && Self::word_char(self.src[i], state) {
                i += 1;
            }
            let w = core::str::from_utf8(&self.src[self.pos..i])
                .map_err(|_| err("name is not UTF-8"))?;
            return Ok((Tok::Word(w.to_string()), i));
        }
        // In expression state a lone `.` is the location counter; a
        // `.`-led word (`.text` in `ADDR(.text)` position) is read as
        // a word when followed by a word character.
        if state == LexState::Expr && c == b'.' {
            if self.pos + 1 < self.src.len() && Self::word_char(self.src[self.pos + 1], state) {
                let mut i = self.pos;
                while i < self.src.len() && Self::word_char(self.src[i], state) {
                    i += 1;
                }
                let w = core::str::from_utf8(&self.src[self.pos..i]).unwrap();
                return Ok((Tok::Word(w.to_string()), i));
            }
            return Ok((Tok::Punct("."), self.pos + 1));
        }
        for p in PUNCTS {
            if self.src[self.pos..].starts_with(p.as_bytes()) {
                return Ok((Tok::Punct(p), self.pos + p.len()));
            }
        }
        Err(err(&format!(
            "line {}: unexpected character `{}`",
            self.line, c as char
        )))
    }

    fn next(&mut self, state: LexState) -> Result<Tok, C5Error> {
        let (tok, end) = self.peek(state)?;
        self.pos = end;
        Ok(tok)
    }

    fn expect_punct(&mut self, p: &str, state: LexState) -> Result<(), C5Error> {
        let line = self.line;
        let tok = self.next(state)?;
        if tok.is(p) {
            Ok(())
        } else {
            Err(err(&format!("line {line}: expected `{p}`, found {tok:?}")))
        }
    }

    fn eat_punct(&mut self, p: &str, state: LexState) -> Result<bool, C5Error> {
        let (tok, end) = self.peek(state)?;
        if tok.is(p) {
            self.pos = end;
            return Ok(true);
        }
        Ok(false)
    }
}

/// Parse a number word: decimal / `0x` hex / leading-0 octal, with an
/// optional `K` / `M` scale suffix.
fn parse_number(w: &str) -> Option<u64> {
    let (body, scale) = match w.as_bytes().last() {
        Some(b'K') | Some(b'k') if w.len() > 1 => (&w[..w.len() - 1], 1024u64),
        Some(b'M') | Some(b'm') if w.len() > 1 && !w.starts_with("0x") && !w.starts_with("0X") => {
            (&w[..w.len() - 1], 1024 * 1024)
        }
        _ => (w, 1),
    };
    let value = if let Some(hex) = body.strip_prefix("0x").or_else(|| body.strip_prefix("0X")) {
        u64::from_str_radix(hex, 16).ok()?
    } else if body.len() > 1 && body.starts_with('0') && body.bytes().all(|b| b.is_ascii_digit()) {
        u64::from_str_radix(&body[1..], 8).ok()?
    } else if body.bytes().all(|b| b.is_ascii_digit()) {
        body.parse::<u64>().ok()?
    } else {
        return None;
    };
    value.checked_mul(scale)
}

// ------------------------------------------------------------- parser

pub struct Parser<'a> {
    lex: Lexer<'a>,
}

/// Output-section type keywords. `DSECT` / `COPY` / `OVERLAY` behave
/// as `INFO` in every ld we mirror.
fn section_type_kw(w: &str) -> Option<OutputSectionType> {
    match w {
        "NOLOAD" => Some(OutputSectionType::NoLoad),
        "INFO" | "DSECT" | "COPY" | "OVERLAY" => Some(OutputSectionType::Info),
        _ => None,
    }
}

fn phdr_type(w: &str) -> Option<u32> {
    Some(match w {
        "PT_NULL" => 0,
        "PT_LOAD" => 1,
        "PT_DYNAMIC" => 2,
        "PT_INTERP" => 3,
        "PT_NOTE" => 4,
        "PT_SHLIB" => 5,
        "PT_PHDR" => 6,
        "PT_TLS" => 7,
        "PT_GNU_EH_FRAME" => 0x6474e550,
        "PT_GNU_STACK" => 0x6474e551,
        "PT_GNU_RELRO" => 0x6474e552,
        _ => return parse_number(w).map(|n| n as u32),
    })
}

const ASSIGN_OPS: &[(&str, AssignOp)] = &[
    ("=", AssignOp::Set),
    ("+=", AssignOp::Add),
    ("-=", AssignOp::Sub),
    ("*=", AssignOp::Mul),
    ("/=", AssignOp::Div),
    ("<<=", AssignOp::Shl),
    (">>=", AssignOp::Shr),
    ("&=", AssignOp::And),
    ("|=", AssignOp::Or),
];

impl<'a> Parser<'a> {
    pub fn new(src: &'a str) -> Self {
        Parser {
            lex: Lexer::new(src),
        }
    }

    pub fn parse(mut self) -> Result<LinkerScript, C5Error> {
        let mut commands = Vec::new();
        loop {
            let (tok, end) = self.lex.peek(LexState::Pattern)?;
            match tok {
                Tok::Eof => break,
                Tok::Punct(";") => {
                    self.lex.pos = end;
                }
                Tok::Punct(".") => {
                    // `. = ASSERT(...)` after SECTIONS: the assignment
                    // to `.` outside SECTIONS lays out nothing; keep it
                    // as an assignment so the assert still evaluates.
                    commands.push(Command::Assign(self.parse_assignment()?));
                }
                Tok::Word(w) => match w.as_str() {
                    "OUTPUT_FORMAT" => {
                        self.lex.pos = end;
                        commands.push(Command::OutputFormat(self.parse_name_list()?));
                    }
                    "OUTPUT_ARCH" => {
                        self.lex.pos = end;
                        let names = self.parse_raw_paren()?;
                        commands.push(Command::OutputArch(names));
                    }
                    "ENTRY" => {
                        self.lex.pos = end;
                        let names = self.parse_name_list()?;
                        let name = names
                            .first()
                            .ok_or_else(|| err("ENTRY() requires a symbol"))?;
                        commands.push(Command::Entry(name.clone()));
                        self.eat_semis()?;
                    }
                    "ASSERT" => {
                        self.lex.pos = end;
                        let (e, msg) = self.parse_assert_args()?;
                        commands.push(Command::Assert(e, msg));
                        self.eat_semis()?;
                    }
                    "PHDRS" => {
                        self.lex.pos = end;
                        commands.push(Command::Phdrs(self.parse_phdrs()?));
                    }
                    "SECTIONS" => {
                        self.lex.pos = end;
                        commands.push(Command::Sections(self.parse_sections()?));
                    }
                    "PROVIDE" | "PROVIDE_HIDDEN" | "HIDDEN" => {
                        commands.push(Command::Assign(self.parse_assignment()?));
                    }
                    "MEMORY" | "VERSION" | "INSERT" | "REGION_ALIAS" | "INCLUDE" => {
                        return Err(err(&format!(
                            "line {}: `{w}` is not supported",
                            self.lex.line
                        )));
                    }
                    _ => commands.push(Command::Assign(self.parse_assignment()?)),
                },
                other => {
                    return Err(err(&format!(
                        "line {}: unexpected {other:?} at file level",
                        self.lex.line
                    )));
                }
            }
        }
        Ok(LinkerScript { commands })
    }

    fn eat_semis(&mut self) -> Result<(), C5Error> {
        while self.lex.eat_punct(";", LexState::Pattern)? {}
        Ok(())
    }

    /// `( name [, name]* )` with names lexed in pattern state.
    fn parse_name_list(&mut self) -> Result<Vec<String>, C5Error> {
        self.lex.expect_punct("(", LexState::Pattern)?;
        let mut names = Vec::new();
        loop {
            let tok = self.lex.next(LexState::Pattern)?;
            match tok {
                Tok::Word(w) => names.push(w),
                Tok::Str(s) => names.push(s),
                Tok::Punct(",") => {}
                Tok::Punct(")") => break,
                other => {
                    return Err(err(&format!(
                        "line {}: unexpected {other:?} in name list",
                        self.lex.line
                    )));
                }
            }
        }
        Ok(names)
    }

    /// Raw text between parens, for `OUTPUT_ARCH(i386:x86-64)` where
    /// the argument grammar is bfd-specific.
    fn parse_raw_paren(&mut self) -> Result<String, C5Error> {
        self.lex.expect_punct("(", LexState::Pattern)?;
        self.lex.skip_space()?;
        let start = self.lex.pos;
        let mut depth = 1usize;
        while self.lex.pos < self.lex.src.len() {
            match self.lex.src[self.lex.pos] {
                b'(' => depth += 1,
                b')' => {
                    depth -= 1;
                    if depth == 0 {
                        let s = core::str::from_utf8(&self.lex.src[start..self.lex.pos])
                            .map_err(|_| err("argument is not UTF-8"))?
                            .trim()
                            .to_string();
                        self.lex.pos += 1;
                        return Ok(s);
                    }
                }
                b'\n' => self.lex.line += 1,
                _ => {}
            }
            self.lex.pos += 1;
        }
        Err(err("unterminated `(`"))
    }

    fn parse_assert_args(&mut self) -> Result<(Expr, String), C5Error> {
        self.lex.expect_punct("(", LexState::Expr)?;
        let e = self.parse_expr()?;
        self.lex.expect_punct(",", LexState::Expr)?;
        let msg = match self.lex.next(LexState::Expr)? {
            Tok::Str(s) => s,
            other => {
                return Err(err(&format!(
                    "line {}: ASSERT message must be a string, found {other:?}",
                    self.lex.line
                )));
            }
        };
        self.lex.expect_punct(")", LexState::Expr)?;
        Ok((e, msg))
    }

    /// Parse `sym = expr;`, `. += expr;`, `PROVIDE(sym = expr);`, ...
    /// starting at the symbol / keyword token.
    fn parse_assignment(&mut self) -> Result<Assignment, C5Error> {
        let line = self.lex.line;
        let tok = self.lex.next(LexState::Pattern)?;
        let (provide, hidden) = match tok.word() {
            Some("PROVIDE") => (true, false),
            Some("PROVIDE_HIDDEN") => (true, true),
            Some("HIDDEN") => (false, true),
            _ => (false, false),
        };
        if provide || hidden {
            self.lex.expect_punct("(", LexState::Pattern)?;
            let symbol = match self.lex.next(LexState::Pattern)? {
                Tok::Word(w) => w,
                other => {
                    return Err(err(&format!(
                        "line {line}: expected symbol name, found {other:?}"
                    )));
                }
            };
            self.lex.expect_punct("=", LexState::Expr)?;
            let value = self.parse_expr()?;
            self.lex.expect_punct(")", LexState::Expr)?;
            self.eat_semis()?;
            return Ok(Assignment {
                symbol,
                op: AssignOp::Set,
                value,
                provide,
                hidden,
            });
        }
        let symbol = match tok {
            Tok::Word(w) => w,
            Tok::Punct(".") => ".".to_string(),
            other => {
                return Err(err(&format!(
                    "line {line}: expected symbol name, found {other:?}"
                )));
            }
        };
        let op_tok = self.lex.next(LexState::Expr)?;
        let op = ASSIGN_OPS
            .iter()
            .find_map(|(p, op)| op_tok.is(p).then_some(*op))
            .ok_or_else(|| {
                err(&format!(
                    "line {line}: expected assignment operator after `{symbol}`, found {op_tok:?}"
                ))
            })?;
        let value = self.parse_expr()?;
        self.eat_semis()?;
        Ok(Assignment {
            symbol,
            op,
            value,
            provide: false,
            hidden: false,
        })
    }

    fn parse_phdrs(&mut self) -> Result<Vec<PhdrDef>, C5Error> {
        self.lex.expect_punct("{", LexState::Pattern)?;
        let mut defs = Vec::new();
        loop {
            if self.lex.eat_punct("}", LexState::Pattern)? {
                break;
            }
            let name = match self.lex.next(LexState::Pattern)? {
                Tok::Word(w) => w,
                other => {
                    return Err(err(&format!(
                        "line {}: expected program header name, found {other:?}",
                        self.lex.line
                    )));
                }
            };
            let ty = match self.lex.next(LexState::Pattern)? {
                Tok::Word(w) => phdr_type(&w).ok_or_else(|| {
                    err(&format!(
                        "line {}: unknown program header type `{w}`",
                        self.lex.line
                    ))
                })?,
                other => {
                    return Err(err(&format!(
                        "line {}: expected program header type, found {other:?}",
                        self.lex.line
                    )));
                }
            };
            let mut def = PhdrDef {
                name,
                ptype: ty,
                filehdr: false,
                phdrs: false,
                at: None,
                flags: None,
            };
            loop {
                let (tok, end) = self.lex.peek(LexState::Pattern)?;
                match tok.word() {
                    Some("FILEHDR") => {
                        self.lex.pos = end;
                        def.filehdr = true;
                    }
                    Some("PHDRS") => {
                        self.lex.pos = end;
                        def.phdrs = true;
                    }
                    Some("AT") => {
                        self.lex.pos = end;
                        self.lex.expect_punct("(", LexState::Expr)?;
                        def.at = Some(self.parse_expr()?);
                        self.lex.expect_punct(")", LexState::Expr)?;
                    }
                    Some("FLAGS") => {
                        self.lex.pos = end;
                        self.lex.expect_punct("(", LexState::Expr)?;
                        def.flags = Some(self.parse_expr()?);
                        self.lex.expect_punct(")", LexState::Expr)?;
                    }
                    _ => break,
                }
            }
            self.lex.expect_punct(";", LexState::Pattern)?;
            defs.push(def);
        }
        Ok(defs)
    }

    fn parse_sections(&mut self) -> Result<Vec<SectionsItem>, C5Error> {
        self.lex.expect_punct("{", LexState::Pattern)?;
        let mut items = Vec::new();
        loop {
            if self.lex.eat_punct("}", LexState::Pattern)? {
                break;
            }
            let (tok, end) = self.lex.peek(LexState::Pattern)?;
            match tok {
                Tok::Eof => return Err(err("unterminated SECTIONS block")),
                Tok::Punct(";") => {
                    self.lex.pos = end;
                }
                Tok::Punct(".") => items.push(SectionsItem::Assign(self.parse_assignment()?)),
                Tok::Word(w) => match w.as_str() {
                    "ASSERT" => {
                        self.lex.pos = end;
                        let (e, msg) = self.parse_assert_args()?;
                        self.eat_semis()?;
                        items.push(SectionsItem::Assert(e, msg));
                    }
                    "PROVIDE" | "PROVIDE_HIDDEN" | "HIDDEN" => {
                        items.push(SectionsItem::Assign(self.parse_assignment()?));
                    }
                    "ENTRY" => {
                        return Err(err(&format!(
                            "line {}: ENTRY inside SECTIONS is not supported",
                            self.lex.line
                        )));
                    }
                    _ => {
                        // A name: either `name = expr;` or an output
                        // section. Disambiguate on the token after the
                        // name (expression state so `+=` lexes whole).
                        let save = self.lex.pos;
                        let save_line = self.lex.line;
                        self.lex.pos = end;
                        let (tok2, _) = self.lex.peek(LexState::Expr)?;
                        let is_assign = ASSIGN_OPS.iter().any(|(p, _)| tok2.is(p));
                        self.lex.pos = save;
                        self.lex.line = save_line;
                        if is_assign {
                            items.push(SectionsItem::Assign(self.parse_assignment()?));
                        } else {
                            items.push(SectionsItem::Output(self.parse_output_section(w)?));
                        }
                    }
                },
                other => {
                    return Err(err(&format!(
                        "line {}: unexpected {other:?} in SECTIONS",
                        self.lex.line
                    )));
                }
            }
        }
        Ok(items)
    }

    /// Parse an output section, having peeked its name (not consumed).
    fn parse_output_section(&mut self, name: String) -> Result<OutputSection, C5Error> {
        let _ = self.lex.next(LexState::Pattern)?; // consume the name
        let mut sec = OutputSection {
            name,
            address: None,
            stype: None,
            at: None,
            align: None,
            subalign: None,
            contents: Vec::new(),
            phdrs: Vec::new(),
            fill: None,
        };
        // Optional address expression and `(TYPE)`, in either order,
        // then `:`.
        loop {
            let (tok, end) = self.lex.peek(LexState::Expr)?;
            if tok.is(":") {
                self.lex.pos = end;
                break;
            }
            if tok.is("(") {
                // `(NOLOAD)` vs a parenthesised address expression.
                let save = self.lex.pos;
                self.lex.pos = end;
                let (inner, iend) = self.lex.peek(LexState::Pattern)?;
                if let Some(kw) = inner.word().and_then(section_type_kw) {
                    self.lex.pos = iend;
                    self.lex.expect_punct(")", LexState::Expr)?;
                    sec.stype = Some(kw);
                    continue;
                }
                self.lex.pos = save;
            }
            if sec.address.is_some() {
                return Err(err(&format!(
                    "line {}: expected `:` after output section address",
                    self.lex.line
                )));
            }
            sec.address = Some(self.parse_expr()?);
        }
        // Attributes after the colon: AT(expr), ALIGN(expr),
        // SUBALIGN(expr), ONLY_IF_RO / ONLY_IF_RW (ignored).
        loop {
            let (tok, end) = self.lex.peek(LexState::Pattern)?;
            match tok.word() {
                Some("AT") => {
                    self.lex.pos = end;
                    self.lex.expect_punct("(", LexState::Expr)?;
                    sec.at = Some(self.parse_expr()?);
                    self.lex.expect_punct(")", LexState::Expr)?;
                }
                Some("ALIGN") => {
                    self.lex.pos = end;
                    self.lex.expect_punct("(", LexState::Expr)?;
                    sec.align = Some(self.parse_expr()?);
                    self.lex.expect_punct(")", LexState::Expr)?;
                }
                Some("SUBALIGN") => {
                    self.lex.pos = end;
                    self.lex.expect_punct("(", LexState::Expr)?;
                    sec.subalign = Some(self.parse_expr()?);
                    self.lex.expect_punct(")", LexState::Expr)?;
                }
                _ => break,
            }
        }
        self.lex.expect_punct("{", LexState::Pattern)?;
        loop {
            if self.lex.eat_punct("}", LexState::Pattern)? {
                break;
            }
            if let Some(item) = self.parse_section_content()? {
                sec.contents.push(item);
            }
        }
        // Trailer: `:phdr`* then optional `= fillexpr`.
        loop {
            let (tok, end) = self.lex.peek(LexState::Pattern)?;
            if tok.is(":") {
                self.lex.pos = end;
                match self.lex.next(LexState::Pattern)? {
                    Tok::Word(w) => sec.phdrs.push(w),
                    other => {
                        return Err(err(&format!(
                            "line {}: expected program header name after `:`, found {other:?}",
                            self.lex.line
                        )));
                    }
                }
                continue;
            }
            if tok.is("=") {
                self.lex.pos = end;
                // A fill value is a literal or a parenthesised
                // expression; a full expression here would swallow a
                // following section name (`/DISCARD/` reads as
                // division).
                let (ftok, fend) = self.lex.peek(LexState::Expr)?;
                sec.fill = Some(if ftok.is("(") {
                    self.parse_primary()?
                } else {
                    self.lex.pos = fend;
                    match ftok {
                        Tok::Word(w) => Expr::Number(parse_number(&w).ok_or_else(|| {
                            err(&format!(
                                "line {}: fill value must be a number or (expression)",
                                self.lex.line
                            ))
                        })?),
                        other => {
                            return Err(err(&format!(
                                "line {}: fill value must be a number, found {other:?}",
                                self.lex.line
                            )));
                        }
                    }
                });
                continue;
            }
            break;
        }
        let _ = self.lex.eat_punct(",", LexState::Pattern)?;
        Ok(sec)
    }

    /// One statement inside an output section's braces; `None` for a
    /// stray `;`.
    fn parse_section_content(&mut self) -> Result<Option<SectionContent>, C5Error> {
        let (tok, end) = self.lex.peek(LexState::Pattern)?;
        let item = match tok {
            Tok::Eof => return Err(err("unterminated output section")),
            Tok::Punct(";") => {
                self.lex.pos = end;
                return Ok(None);
            }
            Tok::Punct(".") => SectionContent::Assign(self.parse_assignment()?),
            Tok::Word(w) => match w.as_str() {
                "ASSERT" => {
                    self.lex.pos = end;
                    let (e, msg) = self.parse_assert_args()?;
                    self.eat_semis()?;
                    SectionContent::Assert(e, msg)
                }
                "PROVIDE" | "PROVIDE_HIDDEN" | "HIDDEN" => {
                    SectionContent::Assign(self.parse_assignment()?)
                }
                "BYTE" | "SHORT" | "LONG" | "QUAD" => {
                    self.lex.pos = end;
                    let width = match w.as_str() {
                        "BYTE" => DataWidth::Byte,
                        "SHORT" => DataWidth::Short,
                        "LONG" => DataWidth::Long,
                        _ => DataWidth::Quad,
                    };
                    self.lex.expect_punct("(", LexState::Expr)?;
                    let e = self.parse_expr()?;
                    self.lex.expect_punct(")", LexState::Expr)?;
                    self.eat_semis()?;
                    SectionContent::Data(width, e)
                }
                "FILL" => {
                    self.lex.pos = end;
                    self.lex.expect_punct("(", LexState::Expr)?;
                    let e = self.parse_expr()?;
                    self.lex.expect_punct(")", LexState::Expr)?;
                    self.eat_semis()?;
                    SectionContent::Fill(e)
                }
                "CONSTRUCTORS" => {
                    self.lex.pos = end;
                    self.eat_semis()?;
                    SectionContent::Constructors
                }
                "KEEP" => {
                    self.lex.pos = end;
                    self.lex.expect_punct("(", LexState::Pattern)?;
                    let mut spec = self.parse_input_spec()?;
                    spec.keep = true;
                    self.lex.expect_punct(")", LexState::Pattern)?;
                    self.eat_semis()?;
                    SectionContent::Input(spec)
                }
                _ => {
                    // `file(patterns)` input spec, or `sym = expr`.
                    let save = self.lex.pos;
                    let save_line = self.lex.line;
                    self.lex.pos = end;
                    let (tok2, _) = self.lex.peek(LexState::Expr)?;
                    let is_assign = ASSIGN_OPS.iter().any(|(p, _)| tok2.is(p));
                    self.lex.pos = save;
                    self.lex.line = save_line;
                    if is_assign {
                        SectionContent::Assign(self.parse_assignment()?)
                    } else {
                        let spec = self.parse_input_spec()?;
                        self.eat_semis()?;
                        SectionContent::Input(spec)
                    }
                }
            },
            other => {
                return Err(err(&format!(
                    "line {}: unexpected {other:?} in output section",
                    self.lex.line
                )));
            }
        };
        Ok(Some(item))
    }

    /// `file(patterns)` / `SORT(file)(patterns)` / bare `file`.
    fn parse_input_spec(&mut self) -> Result<InputSpec, C5Error> {
        let mut file_sort = SortKind::None;
        let mut tok = self.lex.next(LexState::Pattern)?;
        if let Some(kind) = tok.word().and_then(sort_kw) {
            let (nt, nend) = self.lex.peek(LexState::Pattern)?;
            if nt.is("(") {
                self.lex.pos = nend;
                file_sort = kind;
                tok = self.lex.next(LexState::Pattern)?;
                self.lex.expect_punct(")", LexState::Pattern)?;
            }
        }
        let file = match tok {
            Tok::Word(w) => w,
            Tok::Str(s) => s,
            other => {
                return Err(err(&format!(
                    "line {}: expected file pattern, found {other:?}",
                    self.lex.line
                )));
            }
        };
        let mut spec = InputSpec {
            file,
            file_sort,
            patterns: Vec::new(),
            keep: false,
        };
        if !self.lex.eat_punct("(", LexState::Pattern)? {
            return Ok(spec); // bare-file spec
        }
        let mut pending_excludes: Vec<String> = Vec::new();
        loop {
            let tok = self.lex.next(LexState::Pattern)?;
            match tok {
                Tok::Punct(")") => break,
                Tok::Word(w) => match w.as_str() {
                    "EXCLUDE_FILE" => {
                        self.lex.expect_punct("(", LexState::Pattern)?;
                        loop {
                            match self.lex.next(LexState::Pattern)? {
                                Tok::Word(f) => pending_excludes.push(f),
                                Tok::Punct(")") => break,
                                other => {
                                    return Err(err(&format!(
                                        "line {}: unexpected {other:?} in EXCLUDE_FILE",
                                        self.lex.line
                                    )));
                                }
                            }
                        }
                    }
                    _ => {
                        if let Some(kind) = sort_kw(&w) {
                            let (nt, nend) = self.lex.peek(LexState::Pattern)?;
                            if nt.is("(") {
                                self.lex.pos = nend;
                                // SORT wrappers nest (SORT_BY_NAME(
                                // SORT_BY_ALIGNMENT(p))); flatten to the
                                // outermost kind, matching the primary
                                // order ld applies.
                                let mut depth = 1;
                                let mut inner = None;
                                loop {
                                    match self.lex.next(LexState::Pattern)? {
                                        Tok::Word(p) => {
                                            if sort_kw(&p).is_some() {
                                                continue;
                                            }
                                            inner = Some(p);
                                        }
                                        Tok::Punct("(") => depth += 1,
                                        Tok::Punct(")") => {
                                            depth -= 1;
                                            if depth == 0 {
                                                break;
                                            }
                                        }
                                        other => {
                                            return Err(err(&format!(
                                                "line {}: unexpected {other:?} in SORT",
                                                self.lex.line
                                            )));
                                        }
                                    }
                                }
                                let pattern = inner
                                    .ok_or_else(|| err("SORT() requires a section pattern"))?;
                                spec.patterns.push(SectionPattern {
                                    pattern,
                                    sort: kind,
                                    exclude_files: core::mem::take(&mut pending_excludes),
                                });
                                continue;
                            }
                        }
                        spec.patterns.push(SectionPattern {
                            pattern: w,
                            sort: SortKind::None,
                            exclude_files: core::mem::take(&mut pending_excludes),
                        });
                    }
                },
                other => {
                    return Err(err(&format!(
                        "line {}: unexpected {other:?} in input-section list",
                        self.lex.line
                    )));
                }
            }
        }
        Ok(spec)
    }

    // ------------------------------------------------------ expressions

    pub fn parse_expr(&mut self) -> Result<Expr, C5Error> {
        self.parse_ternary()
    }

    fn parse_ternary(&mut self) -> Result<Expr, C5Error> {
        let cond = self.parse_binary(0)?;
        if self.lex.eat_punct("?", LexState::Expr)? {
            let then = self.parse_ternary()?;
            self.lex.expect_punct(":", LexState::Expr)?;
            let other = self.parse_ternary()?;
            return Ok(Expr::Ternary(
                Box::new(cond),
                Box::new(then),
                Box::new(other),
            ));
        }
        Ok(cond)
    }

    fn parse_binary(&mut self, min_prec: u8) -> Result<Expr, C5Error> {
        let mut lhs = self.parse_unary()?;
        loop {
            let (tok, end) = self.lex.peek(LexState::Expr)?;
            let (op, prec) = match &tok {
                Tok::Punct(p) => match *p {
                    "||" => (BinOp::LogOr, 1),
                    "&&" => (BinOp::LogAnd, 2),
                    "|" => (BinOp::BitOr, 3),
                    "^" => (BinOp::BitXor, 4),
                    "&" => (BinOp::BitAnd, 5),
                    "==" => (BinOp::Eq, 6),
                    "!=" => (BinOp::Ne, 6),
                    "<" => (BinOp::Lt, 7),
                    "<=" => (BinOp::Le, 7),
                    ">" => (BinOp::Gt, 7),
                    ">=" => (BinOp::Ge, 7),
                    "<<" => (BinOp::Shl, 8),
                    ">>" => (BinOp::Shr, 8),
                    "+" => (BinOp::Add, 9),
                    "-" => (BinOp::Sub, 9),
                    "*" => (BinOp::Mul, 10),
                    "/" => (BinOp::Div, 10),
                    "%" => (BinOp::Rem, 10),
                    _ => break,
                },
                _ => break,
            };
            if prec < min_prec {
                break;
            }
            self.lex.pos = end;
            let rhs = self.parse_binary(prec + 1)?;
            lhs = Expr::Binary(op, Box::new(lhs), Box::new(rhs));
        }
        Ok(lhs)
    }

    fn parse_unary(&mut self) -> Result<Expr, C5Error> {
        let (tok, end) = self.lex.peek(LexState::Expr)?;
        let op = match &tok {
            Tok::Punct("-") => Some(UnOp::Neg),
            Tok::Punct("!") => Some(UnOp::Not),
            Tok::Punct("~") => Some(UnOp::BitNot),
            Tok::Punct("+") => {
                self.lex.pos = end;
                return self.parse_unary();
            }
            _ => None,
        };
        if let Some(op) = op {
            self.lex.pos = end;
            let e = self.parse_unary()?;
            return Ok(Expr::Unary(op, Box::new(e)));
        }
        self.parse_primary()
    }

    /// A section name argument, lexed in pattern state so names like
    /// `.data..percpu` or `runtime_ptr_USER_PTR_MAX` read whole.
    fn parse_section_arg(&mut self) -> Result<String, C5Error> {
        self.lex.expect_punct("(", LexState::Pattern)?;
        let name = match self.lex.next(LexState::Pattern)? {
            Tok::Word(w) => w,
            other => {
                return Err(err(&format!(
                    "line {}: expected section name, found {other:?}",
                    self.lex.line
                )));
            }
        };
        self.lex.expect_punct(")", LexState::Pattern)?;
        Ok(name)
    }

    fn parse_primary(&mut self) -> Result<Expr, C5Error> {
        let line = self.lex.line;
        let tok = self.lex.next(LexState::Expr)?;
        match tok {
            Tok::Punct("(") => {
                let e = self.parse_expr()?;
                self.lex.expect_punct(")", LexState::Expr)?;
                Ok(e)
            }
            Tok::Punct(".") => Ok(Expr::Symbol(".".to_string())),
            Tok::Word(w) => {
                if let Some(n) = parse_number(&w) {
                    return Ok(Expr::Number(n));
                }
                match w.as_str() {
                    "ALIGN" => {
                        self.lex.expect_punct("(", LexState::Expr)?;
                        let a = self.parse_expr()?;
                        if self.lex.eat_punct(",", LexState::Expr)? {
                            let b = self.parse_expr()?;
                            self.lex.expect_punct(")", LexState::Expr)?;
                            Ok(Expr::Align2(Box::new(a), Box::new(b)))
                        } else {
                            self.lex.expect_punct(")", LexState::Expr)?;
                            Ok(Expr::AlignDot(Box::new(a)))
                        }
                    }
                    "ABSOLUTE" => {
                        self.lex.expect_punct("(", LexState::Expr)?;
                        let e = self.parse_expr()?;
                        self.lex.expect_punct(")", LexState::Expr)?;
                        Ok(Expr::Absolute(Box::new(e)))
                    }
                    "ADDR" => Ok(Expr::Addr(self.parse_section_arg()?)),
                    "LOADADDR" => Ok(Expr::Loadaddr(self.parse_section_arg()?)),
                    "SIZEOF" => Ok(Expr::Sizeof(self.parse_section_arg()?)),
                    "ALIGNOF" => Ok(Expr::Alignof(self.parse_section_arg()?)),
                    "SIZEOF_HEADERS" => Ok(Expr::SizeofHeaders),
                    "DEFINED" => {
                        self.lex.expect_punct("(", LexState::Pattern)?;
                        let name = match self.lex.next(LexState::Pattern)? {
                            Tok::Word(w) => w,
                            other => {
                                return Err(err(&format!(
                                    "line {line}: expected symbol in DEFINED, found {other:?}"
                                )));
                            }
                        };
                        self.lex.expect_punct(")", LexState::Pattern)?;
                        Ok(Expr::Defined(name))
                    }
                    "MIN" | "MAX" => {
                        self.lex.expect_punct("(", LexState::Expr)?;
                        let a = self.parse_expr()?;
                        self.lex.expect_punct(",", LexState::Expr)?;
                        let b = self.parse_expr()?;
                        self.lex.expect_punct(")", LexState::Expr)?;
                        if w == "MIN" {
                            Ok(Expr::Min(Box::new(a), Box::new(b)))
                        } else {
                            Ok(Expr::Max(Box::new(a), Box::new(b)))
                        }
                    }
                    "ASSERT" => {
                        let (e, msg) = self.parse_assert_args()?;
                        Ok(Expr::Assert(Box::new(e), msg))
                    }
                    "CONSTANT" => {
                        let name = self.parse_raw_paren()?;
                        match name.as_str() {
                            "MAXPAGESIZE" => Ok(Expr::Symbol("MAXPAGESIZE".to_string())),
                            "COMMONPAGESIZE" => Ok(Expr::Symbol("COMMONPAGESIZE".to_string())),
                            other => Err(err(&format!("line {line}: unknown CONSTANT({other})"))),
                        }
                    }
                    _ => Ok(Expr::Symbol(w)),
                }
            }
            other => Err(err(&format!(
                "line {line}: unexpected {other:?} in expression"
            ))),
        }
    }
}

/// Parse a complete linker script.
pub fn parse_linker_script(text: &str) -> Result<LinkerScript, C5Error> {
    Parser::new(text).parse()
}

fn sort_kw(w: &str) -> Option<SortKind> {
    match w {
        "SORT" | "SORT_BY_NAME" => Some(SortKind::ByName),
        "SORT_BY_ALIGNMENT" => Some(SortKind::ByAlignment),
        "SORT_NONE" => Some(SortKind::None),
        _ => None,
    }
}

// ------------------------------------------------------------ matching

/// Glob match with `*`, `?`, and `[...]` classes (ranges, leading `!`
/// negation), the pattern language ld's input-section specs use.
pub fn glob_match(pattern: &str, name: &str) -> bool {
    glob_match_bytes(pattern.as_bytes(), name.as_bytes())
}

fn glob_match_bytes(pat: &[u8], name: &[u8]) -> bool {
    // Iterative wildcard match with single-star backtracking.
    let (mut p, mut n) = (0usize, 0usize);
    let (mut star_p, mut star_n) = (usize::MAX, 0usize);
    while n < name.len() {
        if p < pat.len() {
            match pat[p] {
                b'*' => {
                    star_p = p;
                    star_n = n;
                    p += 1;
                    continue;
                }
                b'?' => {
                    p += 1;
                    n += 1;
                    continue;
                }
                b'[' => {
                    if let Some((matched, next_p)) = class_match(pat, p, name[n])
                        && matched
                    {
                        p = next_p;
                        n += 1;
                        continue;
                    }
                }
                c if c == name[n] => {
                    p += 1;
                    n += 1;
                    continue;
                }
                _ => {}
            }
        }
        if star_p != usize::MAX {
            star_n += 1;
            p = star_p + 1;
            n = star_n;
            continue;
        }
        return false;
    }
    while p < pat.len() && pat[p] == b'*' {
        p += 1;
    }
    p == pat.len()
}

/// Match `c` against the `[...]` class starting at `pat[start]`.
/// Returns `(matched, index past the class)`, or `None` for an
/// unterminated class (treated as a literal mismatch by the caller).
fn class_match(pat: &[u8], start: usize, c: u8) -> Option<(bool, usize)> {
    let mut i = start + 1;
    let negate = pat.get(i) == Some(&b'!');
    if negate {
        i += 1;
    }
    let mut matched = false;
    let mut first = true;
    while i < pat.len() {
        if pat[i] == b']' && !first {
            return Some((matched != negate, i + 1));
        }
        first = false;
        if i + 2 < pat.len() && pat[i + 1] == b'-' && pat[i + 2] != b']' {
            if pat[i] <= c && c <= pat[i + 2] {
                matched = true;
            }
            i += 3;
        } else {
            if pat[i] == c {
                matched = true;
            }
            i += 1;
        }
    }
    None
}

/// True when the pattern contains no wildcard characters.
pub fn is_literal_pattern(p: &str) -> bool {
    !p.bytes().any(|b| matches!(b, b'*' | b'?' | b'['))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn numbers() {
        assert_eq!(parse_number("0x1000"), Some(0x1000));
        assert_eq!(parse_number("64"), Some(64));
        assert_eq!(parse_number("64K"), Some(65536));
        assert_eq!(parse_number("2M"), Some(2 * 1024 * 1024));
        assert_eq!(parse_number("010"), Some(8));
        assert_eq!(parse_number("0xffffffff80000000"), Some(0xffffffff80000000));
        assert_eq!(parse_number(".text"), None);
        assert_eq!(parse_number("a1"), None);
    }

    #[test]
    fn globs() {
        assert!(glob_match("*", ".text"));
        assert!(glob_match(".text", ".text"));
        assert!(!glob_match(".text", ".text.hot"));
        assert!(glob_match(".text.*", ".text.hot"));
        assert!(!glob_match(".text.*", ".text"));
        assert!(glob_match("___ksymtab+*", "___ksymtab+foo"));
        assert!(glob_match(".text.[_0-9A-Za-df-rt-z]*", ".text.a"));
        assert!(!glob_match(".text.[_0-9A-Za-df-rt-z]*", ".text.e"));
        assert!(!glob_match(".text.[_0-9A-Za-df-rt-z]*", ".text.startup"));
        assert!(glob_match(".text.s[_0-9A-Za-su-z]*", ".text.sabc"));
        assert!(!glob_match(".text.s[_0-9A-Za-su-z]*", ".text.st"));
        assert!(glob_match(".data.[0-9a-zA-Z_]*", ".data.rel_x"));
        assert!(!glob_match(".data.[0-9a-zA-Z_]*", ".data..L0"));
        assert!(glob_match("[!a]x", "bx"));
        assert!(!glob_match("[!a]x", "ax"));
        assert!(glob_match(
            ".bss..compoundliteral*",
            ".bss..compoundliteral"
        ));
    }

    fn parse(src: &str) -> LinkerScript {
        parse_linker_script(src).expect("script parses")
    }

    #[test]
    fn parses_assignments_and_entry() {
        let s = parse(
            "ENTRY(_start)\n jiffies = jiffies_64;\n x = 1 + 2 * 3;\n \
             PROVIDE(a = b);\n PROVIDE_HIDDEN(c = d);\n . = ASSERT(1, \"ok\");",
        );
        assert_eq!(s.entry(), Some("_start"));
        assert_eq!(s.commands.len(), 6);
        match &s.commands[2] {
            Command::Assign(a) => {
                assert_eq!(a.symbol, "x");
                assert_eq!(
                    a.value,
                    Expr::Binary(
                        BinOp::Add,
                        Box::new(Expr::Number(1)),
                        Box::new(Expr::Binary(
                            BinOp::Mul,
                            Box::new(Expr::Number(2)),
                            Box::new(Expr::Number(3))
                        ))
                    )
                );
            }
            other => panic!("expected assignment, got {other:?}"),
        }
        match &s.commands[5] {
            Command::Assign(a) => {
                assert_eq!(a.symbol, ".");
                assert!(matches!(a.value, Expr::Assert(..)));
            }
            other => panic!("expected dot assignment, got {other:?}"),
        }
    }

    #[test]
    fn parses_phdrs() {
        let s = parse("PHDRS { text PT_LOAD FLAGS(5); note PT_NOTE FLAGS(0); }");
        let p = s.phdrs().unwrap();
        assert_eq!(p.len(), 2);
        assert_eq!(p[0].name, "text");
        assert_eq!(p[0].ptype, 1);
        assert_eq!(p[0].flags, Some(Expr::Number(5)));
        assert_eq!(p[1].ptype, 4);
    }

    #[test]
    fn parses_output_sections() {
        let s = parse(
            "SECTIONS {\n . = 0xffffffff80000000 + 0x1000000;\n \
             .text : AT(ADDR(.text) - 0xffffffff80000000) {\n _text = .;\n \
             *(.text .text.[_a-z]*)\n KEEP(*(SORT(___ksymtab+*)))\n \
             . = ALIGN(16);\n } :text = 0xcccccccc\n \
             /DISCARD/ : { *(.discard) *(.discard.*) }\n \
             .stab 0 : { *(.stab) }\n \
             .got.plt (INFO) : { *(.got.plt) }\n \
             .notes : { *(.note.*) } :text :note\n \
             .brk : { . += 64 * 1024; *(.bss..brk) }\n}",
        );
        let items = s.sections().unwrap();
        assert_eq!(items.len(), 7);
        let text = match &items[1] {
            SectionsItem::Output(o) => o,
            other => panic!("expected .text, got {other:?}"),
        };
        assert_eq!(text.name, ".text");
        assert!(text.at.is_some());
        assert_eq!(text.phdrs, alloc::vec!["text".to_string()]);
        assert_eq!(text.fill, Some(Expr::Number(0xcccccccc)));
        assert_eq!(text.contents.len(), 4);
        match &text.contents[1] {
            SectionContent::Input(spec) => {
                assert_eq!(spec.file, "*");
                assert!(!spec.keep);
                assert_eq!(spec.patterns.len(), 2);
                assert_eq!(spec.patterns[1].pattern, ".text.[_a-z]*");
            }
            other => panic!("expected input spec, got {other:?}"),
        }
        match &text.contents[2] {
            SectionContent::Input(spec) => {
                assert!(spec.keep);
                assert_eq!(spec.patterns[0].sort, SortKind::ByName);
                assert_eq!(spec.patterns[0].pattern, "___ksymtab+*");
            }
            other => panic!("expected KEEP spec, got {other:?}"),
        }
        let stab = match &items[3] {
            SectionsItem::Output(o) => o,
            other => panic!("expected .stab, got {other:?}"),
        };
        assert_eq!(stab.address, Some(Expr::Number(0)));
        let gotplt = match &items[4] {
            SectionsItem::Output(o) => o,
            other => panic!("expected .got.plt, got {other:?}"),
        };
        assert_eq!(gotplt.stype, Some(OutputSectionType::Info));
        let notes = match &items[5] {
            SectionsItem::Output(o) => o,
            other => panic!("expected .notes, got {other:?}"),
        };
        assert_eq!(
            notes.phdrs,
            alloc::vec!["text".to_string(), "note".to_string()]
        );
        let brk = match &items[6] {
            SectionsItem::Output(o) => o,
            other => panic!("expected .brk, got {other:?}"),
        };
        match &brk.contents[0] {
            SectionContent::Assign(a) => {
                assert_eq!(a.symbol, ".");
                assert_eq!(a.op, AssignOp::Add);
            }
            other => panic!("expected `. +=`, got {other:?}"),
        }
    }

    #[test]
    fn parses_exclude_file_and_byte() {
        let s = parse(
            "SECTIONS { .ctors : { *(EXCLUDE_FILE(*crtend.o) .ctors) BYTE(0) \
             FILL(0x9090) CONSTRUCTORS } }",
        );
        let items = s.sections().unwrap();
        let sec = match &items[0] {
            SectionsItem::Output(o) => o,
            other => panic!("expected section, got {other:?}"),
        };
        match &sec.contents[0] {
            SectionContent::Input(spec) => {
                assert_eq!(spec.patterns[0].exclude_files, alloc::vec!["*crtend.o"]);
                assert_eq!(spec.patterns[0].pattern, ".ctors");
            }
            other => panic!("expected input, got {other:?}"),
        }
        assert_eq!(
            sec.contents[1],
            SectionContent::Data(DataWidth::Byte, Expr::Number(0))
        );
        assert_eq!(sec.contents[2], SectionContent::Fill(Expr::Number(0x9090)));
        assert_eq!(sec.contents[3], SectionContent::Constructors);
    }

    #[test]
    fn parses_expressions() {
        let mut p = Parser::new("(-(1 << 47)) + 0x80000000 > x ? ALIGN(a, 8) : MIN(1, 2)");
        let e = p.parse_expr().expect("expression parses");
        assert!(matches!(e, Expr::Ternary(..)));
        let mut p = Parser::new("DEFINED(foo) && SIZEOF(.got) == 0x18 % 7");
        let e = p.parse_expr().expect("expression parses");
        assert!(matches!(e, Expr::Binary(BinOp::LogAnd, ..)));
        let mut p = Parser::new("ABSOLUTE(startup_64 - 0xffffffff80000000)");
        let e = p.parse_expr().expect("expression parses");
        assert!(matches!(e, Expr::Absolute(..)));
    }

    #[test]
    fn double_semicolons_tolerated() {
        let s = parse("a = b;;\nc = d;;");
        assert_eq!(s.commands.len(), 2);
    }

    // The three real kernel scripts, vendored under tests/lds. The
    // whole grammar above exists to hold these; a parse failure on any
    // construct they use is a front-end defect.
    #[test]
    fn parses_vmlinux_x86_64_lds() {
        let text = include_str!("../../../tests/lds/vmlinux_x86_64.lds");
        let s = parse(text);
        assert_eq!(s.entry(), Some("phys_startup_64"));
        assert_eq!(s.phdrs().map(|p| p.len()), Some(3));
        let items = s.sections().unwrap();
        let outs: Vec<&str> = items
            .iter()
            .filter_map(|i| match i {
                SectionsItem::Output(o) => Some(o.name.as_str()),
                _ => None,
            })
            .collect();
        assert!(outs.contains(&".text"));
        assert!(outs.contains(&"/DISCARD/"));
        assert!(outs.contains(&".brk"));
        assert!(outs.contains(&"__ksymtab"));
        assert!(outs.contains(&".rela.dyn"));
        // 25 ASSERT uses across the script (statement and expression).
        fn count_asserts_expr(e: &Expr, n: &mut usize) {
            match e {
                Expr::Assert(inner, _) => {
                    *n += 1;
                    count_asserts_expr(inner, n);
                }
                Expr::Unary(_, a) => count_asserts_expr(a, n),
                Expr::Binary(_, a, b) => {
                    count_asserts_expr(a, n);
                    count_asserts_expr(b, n);
                }
                Expr::Ternary(a, b, c) => {
                    count_asserts_expr(a, n);
                    count_asserts_expr(b, n);
                    count_asserts_expr(c, n);
                }
                Expr::AlignDot(a) | Expr::Absolute(a) => count_asserts_expr(a, n),
                Expr::Align2(a, b) | Expr::Min(a, b) | Expr::Max(a, b) => {
                    count_asserts_expr(a, n);
                    count_asserts_expr(b, n);
                }
                _ => {}
            }
        }
        let mut asserts = 0usize;
        let mut provides = 0usize;
        for c in &s.commands {
            match c {
                Command::Assert(..) => asserts += 1,
                Command::Assign(a) => {
                    provides += a.provide as usize;
                    count_asserts_expr(&a.value, &mut asserts);
                }
                Command::Sections(items) => {
                    for i in items {
                        match i {
                            SectionsItem::Assert(..) => asserts += 1,
                            SectionsItem::Assign(a) => {
                                provides += a.provide as usize;
                                count_asserts_expr(&a.value, &mut asserts);
                            }
                            SectionsItem::Output(o) => {
                                for cc in &o.contents {
                                    match cc {
                                        SectionContent::Assert(..) => asserts += 1,
                                        SectionContent::Assign(a) => {
                                            provides += a.provide as usize;
                                            count_asserts_expr(&a.value, &mut asserts)
                                        }
                                        _ => {}
                                    }
                                }
                            }
                        }
                    }
                }
                _ => {}
            }
        }
        // 15 ASSERT and 10 PROVIDE uses in the generated script.
        assert_eq!(asserts, 15, "ASSERT count in the x86-64 script");
        assert_eq!(provides, 10, "PROVIDE count in the x86-64 script");
    }

    #[test]
    fn parses_vmlinux_aarch64_lds() {
        let text = include_str!("../../../tests/lds/vmlinux_aarch64.lds");
        let s = parse(text);
        assert_eq!(s.entry(), Some("_text"));
        assert!(s.phdrs().is_none());
        let items = s.sections().unwrap();
        let outs: Vec<&str> = items
            .iter()
            .filter_map(|i| match i {
                SectionsItem::Output(o) => Some(o.name.as_str()),
                _ => None,
            })
            .collect();
        assert!(outs.contains(&".head.text"));
        assert!(outs.contains(&".relr.dyn"));
        assert!(outs.contains(&".pecoff_edata_padding"));
        // The `.text : ALIGN(0x00010000) {` header form.
        let text_sec = items
            .iter()
            .find_map(|i| match i {
                SectionsItem::Output(o) if o.name == ".text" => Some(o),
                _ => None,
            })
            .unwrap();
        assert_eq!(text_sec.align, Some(Expr::Number(0x10000)));
    }

    #[test]
    fn parses_module_lds() {
        let text = include_str!("../../../tests/lds/module.lds");
        let s = parse(text);
        let items = s.sections().unwrap();
        let outs: Vec<&str> = items
            .iter()
            .filter_map(|i| match i {
                SectionsItem::Output(o) => Some(o.name.as_str()),
                _ => None,
            })
            .collect();
        assert_eq!(outs[0], "/DISCARD/");
        assert!(outs.contains(&"__ksymtab"));
        assert!(outs.contains(&".rodata"));
        // `__ksymtab 0 : ALIGN(8) { ... }` -- address and ALIGN attr.
        let ks = items
            .iter()
            .find_map(|i| match i {
                SectionsItem::Output(o) if o.name == "__ksymtab" => Some(o),
                _ => None,
            })
            .unwrap();
        assert_eq!(ks.address, Some(Expr::Number(0)));
        assert_eq!(ks.align, Some(Expr::Number(8)));
    }
}

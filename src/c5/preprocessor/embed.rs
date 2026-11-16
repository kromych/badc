//! C23 6.10.4 `#embed` and the C23 6.10.1 `__has_embed` operator, with the
//! `gnu::offset` / `clang::offset` parameter gcc and clang define.

use super::Preprocessor;
use super::include::{IncludeOrigin, IncludeStatus};
use super::text::skip_literal;
use crate::c5::diag::Code;
use crate::c5::error::C5Error;
use alloc::format;
use alloc::string::{String, ToString};

/// The `__has_embed` results, as `__STDC_EMBED_*__` names them.
const NOT_FOUND: u8 = 0;
const FOUND: u8 = 1;
const EMPTY: u8 = 2;

/// The clauses of one parameter sequence (C23 6.10.4.2-6.10.4.5).
#[derive(Default)]
struct Params<'a> {
    limit: Option<&'a str>,
    prefix: Option<&'a str>,
    suffix: Option<&'a str>,
    if_empty: Option<&'a str>,
    offset: Option<&'a str>,
}

enum ParamError {
    /// Not found for `__has_embed`, an error for `#embed`.
    Unsupported(String),
    Malformed(String),
}

impl ParamError {
    fn message(self) -> String {
        match self {
            ParamError::Unsupported(name) => format!("unsupported #embed parameter `{name}`"),
            ParamError::Malformed(why) => format!("malformed #embed parameters: {why}"),
        }
    }
}

/// `<name>` or `"name"` leading `s`: the name, whether quoted, the rest.
fn leading_resource(s: &str) -> Option<(&str, bool, &str)> {
    let t = s.trim_start();
    let (close, quoted) = match t.as_bytes().first()? {
        b'<' => (b'>', false),
        b'"' => (b'"', true),
        _ => return None,
    };
    let end = 1 + t.as_bytes()[1..].iter().position(|&b| b == close)?;
    Some((&t[1..end], quoted, &t[end + 1..]))
}

/// A parameter name with the `__name__` spelling folded to `name`.
fn fold(name: &str) -> &str {
    (name.strip_prefix("__").and_then(|n| n.strip_suffix("__")))
        .filter(|n| !n.is_empty())
        .unwrap_or(name)
}

fn ident_len(b: &[u8], at: usize) -> usize {
    let n = b[at..]
        .iter()
        .take_while(|c| c.is_ascii_alphanumeric() || **c == b'_')
        .count();
    if b.get(at).is_some_and(u8::is_ascii_digit) {
        0
    } else {
        n
    }
}

/// The `)` closing the `(` at `open`, past string and character literals.
fn closing_paren(b: &[u8], open: usize) -> Option<usize> {
    let mut depth = 0usize;
    let mut j = open;
    while j < b.len() {
        match b[j] {
            b'"' | b'\'' => {
                j = skip_literal(b, j);
                continue;
            }
            b'(' => depth += 1,
            b')' => {
                depth -= 1;
                if depth == 0 {
                    return Some(j);
                }
            }
            _ => {}
        }
        j += 1;
    }
    None
}

/// Parse an embed parameter sequence. Each parameter appears at most once
/// (C23 6.10.4.1p3); the standard ones and the offset take a clause.
fn parse_params(s: &str) -> Result<Params<'_>, ParamError> {
    let b = s.as_bytes();
    let mut p = Params::default();
    let mut i = 0;
    loop {
        while b.get(i).is_some_and(u8::is_ascii_whitespace) {
            i += 1;
        }
        if i == b.len() {
            return Ok(p);
        }
        let n = ident_len(b, i);
        if n == 0 {
            return Err(ParamError::Malformed(format!("`{}`", s[i..].trim())));
        }
        let mut name = fold(&s[i..i + n]).to_string();
        i += n;
        if b[i..].starts_with(b"::") {
            let m = ident_len(b, i + 2);
            if m == 0 {
                return Err(ParamError::Malformed(format!(
                    "`{name}::` names no parameter"
                )));
            }
            name = format!("{name}::{}", fold(&s[i + 2..i + 2 + m]));
            i += 2 + m;
        }
        while b.get(i).is_some_and(u8::is_ascii_whitespace) {
            i += 1;
        }
        let clause = if b.get(i) == Some(&b'(') {
            let close = closing_paren(b, i)
                .ok_or_else(|| ParamError::Malformed(format!("`{name}(` is not closed")))?;
            let text = &s[i + 1..close];
            i = close + 1;
            Some(text)
        } else {
            None
        };
        let slot = match name.as_str() {
            "limit" => &mut p.limit,
            "prefix" => &mut p.prefix,
            "suffix" => &mut p.suffix,
            "if_empty" => &mut p.if_empty,
            "gnu::offset" | "clang::offset" => &mut p.offset,
            _ => return Err(ParamError::Unsupported(name)),
        };
        let Some(text) = clause else {
            return Err(ParamError::Malformed(format!(
                "`{name}` takes a parenthesized operand"
            )));
        };
        if slot.replace(text).is_some() {
            return Err(ParamError::Malformed(format!(
                "duplicate parameter `{name}`"
            )));
        }
    }
}

/// `bytes` as a comma-separated list of decimal integer literals.
fn byte_list(bytes: &[u8]) -> String {
    let mut s = String::with_capacity(bytes.len() * 4);
    for (k, &b) in bytes.iter().enumerate() {
        if k > 0 {
            s.push(',');
        }
        if b >= 100 {
            s.push(char::from(b'0' + b / 100));
        }
        if b >= 10 {
            s.push(char::from(b'0' + b / 10 % 10));
        }
        s.push(char::from(b'0' + b % 10));
    }
    s
}

impl Preprocessor {
    /// The resource name, form and parameter text of an `#embed` or
    /// `__has_embed` operand. An operand in neither header-name form is
    /// macro-replaced and reparsed (C23 6.10.4.1p7).
    fn embed_operand<'o>(
        &self,
        operand: &'o str,
        expanded: &'o mut String,
        filename: &str,
        line_no: usize,
    ) -> Option<(&'o str, bool, &'o str)> {
        if leading_resource(operand).is_some() {
            return leading_resource(operand);
        }
        *expanded = self
            .substitute_spelling(operand, filename, line_no)
            .into_owned();
        leading_resource(expanded)
    }

    /// The bytes `offset` and `limit` select, by `#if` rules (C23 6.10.4.2).
    fn embed_select<'b>(
        &self,
        bytes: &'b [u8],
        params: &Params<'_>,
        filename: &str,
        line_no: usize,
    ) -> Result<&'b [u8], C5Error> {
        let count = |expr: Option<&str>, what: &str| -> Result<usize, C5Error> {
            let Some(expr) = expr else {
                return Ok(usize::MAX);
            };
            let (value, unsigned) = self.eval_integer(expr, line_no, filename)?;
            if value < 0 && !unsigned {
                return Err(C5Error::at(
                    Code::DIRECTIVE,
                    filename,
                    line_no,
                    format!("#embed `{what}` is negative: {value}"),
                ));
            }
            Ok(usize::try_from(value as u64).unwrap_or(usize::MAX))
        };
        let skip = match params.offset {
            Some(_) => count(params.offset, "offset")?.min(bytes.len()),
            None => 0,
        };
        let rest = &bytes[skip..];
        Ok(&rest[..count(params.limit, "limit")?.min(rest.len())])
    }

    /// The replacement of `#embed operand` (C23 6.10.4): the selected bytes
    /// as a comma-separated list of integer literals between the
    /// macro-replaced `prefix` and `suffix` clauses, or the `if_empty`
    /// clause when no byte is selected.
    pub(super) fn embed_expansion(
        &mut self,
        operand: &str,
        filename: &str,
        line_no: usize,
    ) -> Result<String, C5Error> {
        let err = |msg: String| C5Error::at(Code::DIRECTIVE, filename, line_no, msg);
        let mut expanded = String::new();
        let (name, quoted, rest) = self
            .embed_operand(operand, &mut expanded, filename, line_no)
            .ok_or_else(|| {
                err(format!(
                    "#embed expects \"file\" or <file>, not `{operand}`"
                ))
            })?;
        let params = parse_params(rest).map_err(|e| err(e.message()))?;
        let (path, bytes) = self.find_embed(name, quoted, filename).ok_or_else(|| {
            err(format!(
                "#embed resource `{name}` not found in {}",
                self.embed_places(quoted)
            ))
        })?;
        let selected = self.embed_select(&bytes, &params, filename, line_no)?;
        let clause = |text: Option<&str>| {
            text.map(|t| self.substitute(t, filename, line_no).trim().to_string())
        };
        let out = if selected.is_empty() {
            clause(params.if_empty).unwrap_or_default()
        } else {
            let list = byte_list(selected);
            match (clause(params.prefix), clause(params.suffix)) {
                (None, None) => list,
                (prefix, suffix) => format!(
                    "{} {list} {}",
                    prefix.unwrap_or_default(),
                    suffix.unwrap_or_default()
                ),
            }
        };
        self.take_pending_error()?;
        let name = name.to_string();
        self.record_include(
            &name,
            Some(path),
            IncludeOrigin::User,
            IncludeStatus::Embedded,
        );
        Ok(out)
    }

    /// Where `#embed` looks for a resource of the given form.
    fn embed_places(&self, quoted: bool) -> &'static str {
        match (quoted, self.embed_paths_empty()) {
            (true, true) => "the including file's directory",
            (true, false) => "the including file's directory or the --embed-dir directories",
            (false, true) => "any directory: `#embed <...>` searches only --embed-dir directories",
            (false, false) => "the --embed-dir directories",
        }
    }

    /// Replace a `__has_embed` at `i` of an `#if` expression by its answer;
    /// the index past it, `None` when the operator does not start there.
    pub(super) fn resolve_has_embed(
        &self,
        s: &str,
        i: usize,
        filename: &str,
        line_no: usize,
        out: &mut String,
    ) -> Option<usize> {
        let (operand, after) = super::cond::balanced_operand(s, i, "__has_embed", self.dollar())?;
        out.push(char::from(
            b'0' + self.has_embed_answer(operand, filename, line_no),
        ));
        Some(after)
    }

    /// C23 6.10.1p7: not found for a missing resource or an unsupported
    /// parameter, empty when the parameters select no byte, else found.
    fn has_embed_answer(&self, operand: &str, filename: &str, line_no: usize) -> u8 {
        let mut expanded = String::new();
        let Some((name, quoted, rest)) =
            self.embed_operand(operand, &mut expanded, filename, line_no)
        else {
            self.record_pp_error(C5Error::at(
                Code::DIRECTIVE,
                filename,
                line_no,
                format!("__has_embed expects \"file\" or <file>, not `{operand}`"),
            ));
            return NOT_FOUND;
        };
        let params = match parse_params(rest) {
            Ok(p) => p,
            Err(ParamError::Unsupported(_)) => return NOT_FOUND,
            Err(e) => {
                self.record_pp_error(C5Error::at(Code::DIRECTIVE, filename, line_no, e.message()));
                return NOT_FOUND;
            }
        };
        let Some((_, bytes)) = self.find_embed(name, quoted, filename) else {
            return NOT_FOUND;
        };
        match self.embed_select(&bytes, &params, filename, line_no) {
            Ok([]) => EMPTY,
            Ok(_) => FOUND,
            Err(e) => {
                self.record_pp_error(e);
                NOT_FOUND
            }
        }
    }
}

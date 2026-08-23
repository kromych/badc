use super::Preprocessor;
use super::builtins;
use super::include::IncludeForm;
use super::text::{
    is_ident_byte, literal_prefix_len, pp_number_len, skip_literal, strip_c_comments,
};
use crate::c5::error::C5Error;
use crate::c5::lexer::{Ucn, decode_utf8, encode_utf8, scan_ucn};
use alloc::format;
use alloc::string::{String, ToString};

impl Preprocessor {
    /// Pre-pass for `#if` evaluation: protect every `defined(NAME)`
    /// (and `defined NAME`) by replacing it with `1` or `0` *before*
    /// macro substitution. Otherwise `substitute` would expand the
    /// argument and lose the original name. Returns a fully
    /// macro-substituted string suitable for the `#if` expression
    /// parser.
    pub(super) fn expand_for_if(&self, expr: &str, line_no: usize, filename: &str) -> String {
        let mut out = String::with_capacity(expr.len());
        let bytes = expr.as_bytes();
        let mut i = 0;
        while i < bytes.len() {
            if (bytes[i] as char).is_ascii_whitespace() {
                out.push(bytes[i] as char);
                i += 1;
                continue;
            }
            // Comments were removed in phase 3; the literal-aware strip
            // after substitution covers macro-introduced ones.
            //
            // `defined(NAME)` / `defined NAME` (C99 6.10.1p1) resolves to
            // 1 or 0 here, before substitution, because `substitute`
            // would otherwise expand NAME away.
            if let Some((name, next)) = operator_operand(expr, i, "defined", Parens::Optional) {
                out.push_str(if self.is_defined_name(name) { "1" } else { "0" });
                i = next;
                continue;
            }
            // `__has_builtin` / `__has_attribute` likewise take an
            // unexpanded identifier operand.
            if let Some(next) = resolve_has_operator(expr, i, &mut out) {
                i = next;
                continue;
            }
            // `__has_include` / `__has_include_next` (C23 6.10.1) also
            // resolve before substitution: a literal `<...>` / `"..."`
            // operand is a header name as written, and a pp-token
            // operand expands spelling-faithfully. Substituting the
            // whole expression instead would insert re-lex separators
            // into the header name.
            if let Some(next) = self.resolve_has_include(expr, i, filename, line_no, &mut out) {
                i = next;
                continue;
            }
            // Bytes with no operator meaning pass through as a UTF-8
            // slice; a per-byte `as char` would widen non-ASCII.
            let start = i;
            i += 1;
            while i < bytes.len() && !bytes[i].is_ascii() {
                i += 1;
            }
            out.push_str(&expr[start..i]);
        }
        // Now expand all remaining identifiers (object + function-
        // like) via the standard substitute pass. Then strip block
        // and line comments from the result -- driver-predefined
        // macro bodies never went through phase 3 and can carry
        // comments that would confuse the expression tokenizer.
        // `strip_c_comments` keeps string and char literals intact.
        let substituted = self.substitute(&out, "<#if>", line_no);
        // Resolve any `__has_builtin` / `__has_attribute` that a macro
        // alias expanded into; the pre-pass above already handled the
        // ones written literally.
        replace_has_operators(&strip_c_comments(&substituted))
    }

    /// Resolve a `__has_include` / `__has_include_next` at `i`,
    /// appending `1` or `0` to `out`; returns the index just past the
    /// call. `None` when neither operator starts there, and also when
    /// the operand expands to neither literal form -- the text then
    /// flows on to the expression parser, whose diagnostics cover the
    /// malformed operand.
    fn resolve_has_include(
        &self,
        s: &str,
        i: usize,
        filename: &str,
        line_no: usize,
        out: &mut String,
    ) -> Option<usize> {
        for (kw, next) in [("__has_include_next", true), ("__has_include", false)] {
            let Some((operand, after)) = balanced_operand(s, i, kw) else {
                continue;
            };
            let found = self.has_include_answer(operand, next, filename, line_no)?;
            out.push_str(if found { "1" } else { "0" });
            return Some(after);
        }
        None
    }

    /// Answer for a `__has_include` operand (`next` selects the
    /// `_next` search): a literal `<...>` / `"..."` names the header
    /// as written (C23 6.10.1 matches the header-name forms before
    /// macro replacement); any other operand is macro-expanded with
    /// its spelling kept and reparsed. `None` when the expansion
    /// yields neither form.
    fn has_include_answer(
        &self,
        operand: &str,
        next: bool,
        filename: &str,
        line_no: usize,
    ) -> Option<bool> {
        let literal = |t: &str| {
            let t = t.trim();
            t.strip_prefix('<')
                .and_then(|s| s.strip_suffix('>'))
                .map(|n| (n, false))
                .or_else(|| {
                    t.strip_prefix('"')
                        .and_then(|s| s.strip_suffix('"'))
                        .map(|n| (n, true))
                })
                .map(|(n, quoted)| (n.trim().to_string(), quoted))
        };
        let (name, quoted) = literal(operand)
            .or_else(|| literal(&self.substitute_spelling(operand, filename, line_no)))?;
        let form = if next {
            IncludeForm::next(quoted)
        } else {
            IncludeForm::plain(quoted)
        };
        Some(self.resolve_include(&name, form, filename).is_some())
    }

    pub(super) fn eval_condition(
        &self,
        expr: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<bool, C5Error> {
        // Full c99 `#if` expression evaluator: integer constants,
        // identifiers (treated as 0 if undefined), `defined(X)`,
        // unary `!`, comparisons, and boolean operators with
        // standard precedence. Strings (`"..."`) round-trip as
        // their canonical form so `__BADC_TARGET__ == "macos"`
        // still works as before.
        //
        // Pre-substitute the expression through the macro table so
        // function-like macros (`__has_attribute(x)`) and chained
        // object-like macros (a config-version constant defined
        // via several layers of `#define`) expand before the
        // parser sees them. `defined(X)` is protected by a
        // pre-pass that converts it to a literal 0/1 since
        // substitute would otherwise expand X away.
        let prepared = self.expand_for_if(expr, line_no, filename);
        self.take_pending_error()?;
        let mut p = IfExprParser::new(&prepared, self, filename);
        let v = p.parse_ternary()?;
        p.skip_ws();
        if !p.at_end() {
            // Note: `expand_if_expr` doesn't carry a `filename` --
            // it operates on a single line of an expanded `#if` /
            // `#elif` expression. Use `<unknown>` here; callers that
            // hit this case usually have a filename one frame up.
            return Err(C5Error::Compile(crate::c5::error::fmt_compile_err(
                "<unknown>",
                line_no,
                &alloc::format!("trailing junk in `#if` expression: {:?}", p.tail()),
            )));
        }
        Ok(v.truthy())
    }
}

/// Substitute `params` for `args` in a function-like macro body.
/// Whole-word match -- a parameter named `T` replaces only the
/// identifier `T`, never `T` inside another word like `Tx`.
///
/// Also handles the C99 macro operators:
///   - `#param` stringifies the literal argument text into a string
///     literal (with `\` and `"` escaped).
///   - `a ## b` token-pastes the two surrounding tokens after
///     substitution, dropping any whitespace around the `##`.
///   - `__VA_ARGS__` substitutes the variadic-tail args joined with
///     `, ` for variadic macros (`#define foo(...)` /
///     `#define foo(a, ...)`).
/// Value produced by the `#if`-expression evaluator.
///
/// `Int` is the c99 integer-constant case (`#if X >= 5`); `Str` is
/// the c5 extension where macros can hold quoted strings (`#if
/// __BADC_TARGET__ == "macos-aarch64"`). The two interop only via
/// equality / inequality -- mixing them in arithmetic is rejected.
#[derive(Debug, Clone)]
pub(super) enum IfValue {
    /// C99 6.10.1p4: `#if` operands evaluate in (u)intmax_t. `unsigned`
    /// records the operand signedness so the right shift (6.5.7p5) and
    /// the division / remainder (6.2.5) select the correct interpretation.
    Int {
        val: i64,
        unsigned: bool,
    },
    Str(String),
}

impl IfValue {
    fn signed(v: i64) -> IfValue {
        IfValue::Int {
            val: v,
            unsigned: false,
        }
    }
    fn with_sign(v: i64, unsigned: bool) -> IfValue {
        IfValue::Int { val: v, unsigned }
    }
    fn is_unsigned(&self) -> bool {
        matches!(self, IfValue::Int { unsigned: true, .. })
    }
    fn truthy(&self) -> bool {
        match self {
            IfValue::Int { val, .. } => *val != 0,
            IfValue::Str(s) => !s.is_empty(),
        }
    }
    fn as_int(&self) -> i64 {
        match self {
            IfValue::Int { val, .. } => *val,
            IfValue::Str(s) => {
                // String coerced to int: 0 unless the bytes happen
                // to parse as a number. Real c programs rarely
                // mix; this is purely defensive.
                s.parse().unwrap_or(0)
            }
        }
    }
}

/// Tiny recursive-descent parser for `#if` expressions. Mirrors the
/// c99 precedence (top to bottom):
///
///   `||` | `&&` | `|` | `^` | `&` | `== !=` | `< <= > >=` |
///   `<< >>` | `+ -` | `* / %` | unary `! - + ~` | primary
///
/// Primaries are integer literals (decimal / hex / octal with the
/// usual c99 suffixes), `defined(NAME)` / `defined NAME`, identifiers
/// (resolved through the macro table -- undefined names evaluate to
/// 0), parenthesised sub-expressions, and string literals (preserved
/// for the c5-extension `==`/`!=` shape).
/// Recursion bound for the `#if` controlling-expression parser. Each
/// level descends the full precedence cascade (a dozen frames), so the
/// bound is conservative enough to hold within a 1 MiB stack (the
/// Windows main-thread default). Real `#if` expressions nest only a few
/// parentheses deep; past the bound, deeply nested or generator-produced
/// input yields a diagnostic instead of a stack-overflow abort.
pub(super) const MAX_IF_EXPR_DEPTH: usize = 100;

pub(super) struct IfExprParser<'a> {
    src: &'a str,
    pos: usize,
    pp: &'a Preprocessor,
    /// Path of the file whose `#if` is being evaluated;
    /// `__has_include("h")` resolves its quoted form against this
    /// file's directory, and `__has_include_next` resumes the search
    /// past this file's search-path entry.
    filename: &'a str,
    /// Recursion depth, bounded by [`MAX_IF_EXPR_DEPTH`]. Every recursive
    /// cycle in the grammar passes through `parse_unary`, so the bound is
    /// checked there.
    depth: usize,
    /// False while parsing a short-circuited (`&&`/`||`) or not-taken
    /// (`?:`) subexpression. C99 6.6p4 forbids division by zero in a
    /// constant expression, but an unevaluated operand must not trigger
    /// the diagnostic (gcc/clang accept `1 ? 2 : 1/0`).
    live: bool,
}

impl<'a> IfExprParser<'a> {
    fn new(src: &'a str, pp: &'a Preprocessor, filename: &'a str) -> Self {
        Self {
            src,
            pos: 0,
            pp,
            filename,
            depth: 0,
            live: true,
        }
    }
    fn at_end(&self) -> bool {
        self.pos >= self.src.len()
    }
    fn tail(&self) -> &str {
        &self.src[self.pos..]
    }
    fn peek_byte(&self) -> Option<u8> {
        self.src.as_bytes().get(self.pos).copied()
    }
    fn skip_ws(&mut self) {
        while let Some(b) = self.peek_byte() {
            if b.is_ascii_whitespace() {
                self.pos += 1;
            } else {
                break;
            }
        }
    }
    fn eat(&mut self, s: &str) -> bool {
        self.skip_ws();
        if self.src[self.pos..].starts_with(s) {
            self.pos += s.len();
            true
        } else {
            false
        }
    }
    /// The identifier at the cursor, empty when none starts there.
    /// Shares the pp-token identifier rule with the text scanners.
    fn scan_ident(&mut self) -> &'a str {
        let start = self.pos;
        while self.peek_byte().is_some_and(is_ident_byte) {
            self.pos += 1;
        }
        &self.src[start..self.pos]
    }
    fn eat_byte(&mut self, b: u8) -> bool {
        self.skip_ws();
        if self.peek_byte() == Some(b) {
            self.pos += 1;
            true
        } else {
            false
        }
    }

    fn parse_or(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_and()?;
        loop {
            self.skip_ws();
            if self.eat("||") {
                let saved = self.live;
                self.live = saved && !left.truthy();
                let right = self.parse_and()?;
                self.live = saved;
                left = IfValue::signed((left.truthy() || right.truthy()) as i64);
            } else {
                break;
            }
        }
        Ok(left)
    }

    /// C99 6.10.1p1 / 6.5.15: `#if` accepts a ternary at the top of
    /// the expression precedence. `cond ? then : else` -- both arms are
    /// parsed and the picked one is returned. The not-taken arm is parsed
    /// with `live` cleared so a division by zero there is not diagnosed
    /// (6.6p4 applies to the evaluated operand only). Right-associative,
    /// so the `else` arm recurses.
    fn parse_ternary(&mut self) -> Result<IfValue, C5Error> {
        let cond = self.parse_or()?;
        self.skip_ws();
        if !self.eat_byte(b'?') {
            return Ok(cond);
        }
        let saved = self.live;
        self.live = saved && cond.truthy();
        let then_v = self.parse_ternary()?;
        self.live = saved;
        self.skip_ws();
        if !self.eat_byte(b':') {
            return Err(C5Error::Compile(
                "preprocessor: missing `:` in `#if` ternary expression".to_string(),
            ));
        }
        self.live = saved && !cond.truthy();
        let else_v = self.parse_ternary()?;
        self.live = saved;
        // C99 6.5.15p5: the arms undergo the usual arithmetic
        // conversions, so either arm being unsigned makes the result
        // unsigned regardless of which arm is picked.
        let uns = then_v.is_unsigned() || else_v.is_unsigned();
        let picked = if cond.truthy() { then_v } else { else_v };
        Ok(match picked {
            IfValue::Int { val, .. } => IfValue::with_sign(val, uns),
            other => other,
        })
    }

    fn parse_and(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_bitor()?;
        loop {
            self.skip_ws();
            if self.eat("&&") {
                let saved = self.live;
                self.live = saved && left.truthy();
                let right = self.parse_bitor()?;
                self.live = saved;
                left = IfValue::signed((left.truthy() && right.truthy()) as i64);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_bitor(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_bitxor()?;
        loop {
            self.skip_ws();
            // Single `|`, but only if not followed by another `|`
            // (which would be `||`, the OR operator we already handled).
            if self.peek_byte() == Some(b'|')
                && self.src.as_bytes().get(self.pos + 1) != Some(&b'|')
            {
                self.pos += 1;
                let right = self.parse_bitxor()?;
                let uns = left.is_unsigned() || right.is_unsigned();
                left = IfValue::with_sign(left.as_int() | right.as_int(), uns);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_bitxor(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_bitand()?;
        loop {
            self.skip_ws();
            if self.eat_byte(b'^') {
                let right = self.parse_bitand()?;
                let uns = left.is_unsigned() || right.is_unsigned();
                left = IfValue::with_sign(left.as_int() ^ right.as_int(), uns);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_bitand(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_eq()?;
        loop {
            self.skip_ws();
            if self.peek_byte() == Some(b'&')
                && self.src.as_bytes().get(self.pos + 1) != Some(&b'&')
            {
                self.pos += 1;
                let right = self.parse_eq()?;
                let uns = left.is_unsigned() || right.is_unsigned();
                left = IfValue::with_sign(left.as_int() & right.as_int(), uns);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_eq(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_rel()?;
        loop {
            self.skip_ws();
            if self.eat("==") {
                let right = self.parse_rel()?;
                left = IfValue::signed(if_value_eq(&left, &right) as i64);
            } else if self.eat("!=") {
                let right = self.parse_rel()?;
                left = IfValue::signed(!if_value_eq(&left, &right) as i64);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_rel(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_shift()?;
        loop {
            self.skip_ws();
            if self.eat("<=") {
                let right = self.parse_shift()?;
                left = IfValue::signed(!if_value_lt(&right, &left) as i64);
            } else if self.eat(">=") {
                let right = self.parse_shift()?;
                left = IfValue::signed(!if_value_lt(&left, &right) as i64);
            } else if self.peek_byte() == Some(b'<')
                && self.src.as_bytes().get(self.pos + 1) != Some(&b'<')
            {
                self.pos += 1;
                let right = self.parse_shift()?;
                left = IfValue::signed(if_value_lt(&left, &right) as i64);
            } else if self.peek_byte() == Some(b'>')
                && self.src.as_bytes().get(self.pos + 1) != Some(&b'>')
            {
                self.pos += 1;
                let right = self.parse_shift()?;
                left = IfValue::signed(if_value_lt(&right, &left) as i64);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_shift(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_addsub()?;
        loop {
            self.skip_ws();
            if self.eat("<<") {
                let right = self.parse_addsub()?;
                // Left shift is bit-pattern identical for signed and
                // unsigned operands; the wrapping form avoids a panic
                // past bit 63. The result keeps the left operand's sign.
                let shift = (right.as_int() & 63) as u32;
                let n = (left.as_int() as u64).wrapping_shl(shift) as i64;
                left = IfValue::with_sign(n, left.is_unsigned());
            } else if self.eat(">>") {
                let right = self.parse_addsub()?;
                // C99 6.5.7p5: right shift of a signed value propagates
                // the sign (arithmetic); an unsigned operand zero-fills
                // (logical). Tracking the operand sign lets `-2 >> 1`
                // yield -1 while an unsigned bit-pattern literal such as
                // the `((SIZE_MAX >> 31) >> 31) == 3` probe still yields
                // its zero-filled result.
                let shift = (right.as_int() & 63) as u32;
                let uns = left.is_unsigned();
                let n = if uns {
                    (left.as_int() as u64).wrapping_shr(shift) as i64
                } else {
                    left.as_int().wrapping_shr(shift)
                };
                left = IfValue::with_sign(n, uns);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_addsub(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_muldiv()?;
        loop {
            self.skip_ws();
            if self.eat_byte(b'+') {
                let right = self.parse_muldiv()?;
                let uns = left.is_unsigned() || right.is_unsigned();
                left = IfValue::with_sign(left.as_int().wrapping_add(right.as_int()), uns);
            } else if self.eat_byte(b'-') {
                let right = self.parse_muldiv()?;
                let uns = left.is_unsigned() || right.is_unsigned();
                left = IfValue::with_sign(left.as_int().wrapping_sub(right.as_int()), uns);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_muldiv(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_unary()?;
        loop {
            self.skip_ws();
            if self.eat_byte(b'*') {
                let right = self.parse_unary()?;
                let uns = left.is_unsigned() || right.is_unsigned();
                left = IfValue::with_sign(left.as_int().wrapping_mul(right.as_int()), uns);
            } else if self.eat_byte(b'/') {
                let right = self.parse_unary()?;
                let uns = left.is_unsigned() || right.is_unsigned();
                let r = right.as_int();
                left = IfValue::with_sign(self.div_or_diag(left.as_int(), r, uns, false)?, uns);
            } else if self.eat_byte(b'%') {
                let right = self.parse_unary()?;
                let uns = left.is_unsigned() || right.is_unsigned();
                let r = right.as_int();
                left = IfValue::with_sign(self.div_or_diag(left.as_int(), r, uns, true)?, uns);
            } else {
                break;
            }
        }
        Ok(left)
    }

    /// C99 6.6p4: a constant expression with a zero divisor is not a
    /// valid constant expression. Diagnose it when the operand is
    /// evaluated (`live`); a short-circuited or not-taken zero divisor
    /// keeps folding to 0. `rem` selects remainder over division;
    /// `unsigned` selects the unsigned interpretation (6.3.1.8).
    fn div_or_diag(&self, lhs: i64, rhs: i64, unsigned: bool, rem: bool) -> Result<i64, C5Error> {
        if rhs == 0 {
            if self.live {
                return Err(C5Error::Compile(
                    "preprocessor: division by zero in `#if` expression".to_string(),
                ));
            }
            return Ok(0);
        }
        Ok(if unsigned {
            let (a, b) = (lhs as u64, rhs as u64);
            (if rem { a % b } else { a / b }) as i64
        } else if rem {
            lhs.wrapping_rem(rhs)
        } else {
            lhs.wrapping_div(rhs)
        })
    }

    fn parse_unary(&mut self) -> Result<IfValue, C5Error> {
        // Every recursive cycle (parentheses through the precedence
        // cascade, ternary arms, and unary chains) reaches `parse_unary`,
        // so bounding its depth bounds the whole grammar.
        self.depth += 1;
        if self.depth > MAX_IF_EXPR_DEPTH {
            self.depth -= 1;
            return Err(C5Error::Compile(
                "preprocessor: `#if` expression nested too deeply".to_string(),
            ));
        }
        let r = self.parse_unary_inner();
        self.depth -= 1;
        r
    }

    fn parse_unary_inner(&mut self) -> Result<IfValue, C5Error> {
        self.skip_ws();
        if self.eat_byte(b'!') {
            let v = self.parse_unary()?;
            return Ok(IfValue::signed((!v.truthy()) as i64));
        }
        if self.eat_byte(b'~') {
            let v = self.parse_unary()?;
            return Ok(IfValue::with_sign(!v.as_int(), v.is_unsigned()));
        }
        if self.eat_byte(b'-') {
            let v = self.parse_unary()?;
            return Ok(IfValue::with_sign(
                v.as_int().wrapping_neg(),
                v.is_unsigned(),
            ));
        }
        if self.eat_byte(b'+') {
            return self.parse_unary();
        }
        self.parse_primary()
    }

    fn parse_primary(&mut self) -> Result<IfValue, C5Error> {
        self.skip_ws();
        if self.eat_byte(b'(') {
            let v = self.parse_ternary()?;
            self.skip_ws();
            if !self.eat_byte(b')') {
                return Err(C5Error::Compile(
                    "preprocessor: missing `)` in `#if` expression".to_string(),
                ));
            }
            return Ok(v);
        }
        // C99 6.4.4.4 / 6.4.5: a character constant or string literal may
        // carry an encoding prefix. It selects how a character constant
        // reads; a string operand compares by text either way.
        let prefix = literal_prefix_len(self.src.as_bytes(), self.pos);
        if let Some(plen) = prefix {
            self.pos += plen;
        }
        if self.eat_byte(b'"') {
            // String literal -- read to closing `"`. No escape
            // handling beyond plain bytes; the c5 use cases compare
            // simple paths.
            let start = self.pos;
            while let Some(b) = self.peek_byte() {
                if b == b'"' {
                    let s = self.src[start..self.pos].to_string();
                    self.pos += 1;
                    return Ok(IfValue::Str(format!("\"{s}\"")));
                }
                self.pos += 1;
            }
            return Err(C5Error::Compile(
                "preprocessor: unterminated string in `#if` expression".to_string(),
            ));
        }
        if self.eat_byte(b'\'') {
            // Character constant. A prefixed one holds code points and
            // keeps the last (C99 6.4.4.4p11); an unprefixed one packs
            // execution bytes, first character most significant, which
            // is the implementation-defined value of 6.4.4.4p10 that gcc
            // and clang also produce. Both readings mirror the lexer's,
            // so a constant means the same inside and outside `#if`.
            let wide = prefix.is_some();
            let bytes = self.src.as_bytes();
            let mut packed: i64 = 0;
            let mut last: i64 = 0;
            let mut count = 0usize;
            while let Some(b) = self.peek_byte() {
                if b == b'\'' {
                    self.pos += 1;
                    if wide {
                        // `L'...'` has type `wchar_t` (C11 6.4.4.4p2),
                        // whose signedness the target ABI fixes.
                        return Ok(IfValue::with_sign(last, !self.pp.wchar.signed));
                    }
                    // A single-character constant keeps its char's own
                    // value, sign-extended on signed-plain-char targets.
                    let v = if count == 1 {
                        if self.pp.char_signed && (0..=0xFF).contains(&last) {
                            last as u8 as i8 as i64
                        } else {
                            last
                        }
                    } else {
                        packed
                    };
                    // The constant has type `int`, so it narrows to that
                    // width before the 6.10.1p4 intmax_t evaluation.
                    return Ok(IfValue::signed(v as i32 as i64));
                }
                if b == b'\\' && self.pos + 1 < bytes.len() {
                    self.pos += 2;
                    let esc = bytes[self.pos - 1];
                    if matches!(esc, b'u' | b'U') {
                        let Ucn::Ok(cp) = scan_ucn(bytes, &mut self.pos, esc) else {
                            return Err(C5Error::Compile(format!(
                                "preprocessor: invalid universal character name \\{} in `#if`",
                                esc as char
                            )));
                        };
                        if wide {
                            last = cp as i64;
                            continue;
                        }
                        // Unprefixed, the code point contributes the
                        // bytes of its UTF-8 encoding, one character each.
                        let mut enc = [0u8; 4];
                        let n = encode_utf8(cp, &mut enc);
                        for &byte in &enc[..n] {
                            count += 1;
                            packed = (packed << 8) | byte as i64;
                            last = byte as i64;
                        }
                        continue;
                    }
                    // C99 6.4.4.4: simple, octal (`\N` up to three
                    // digits), and hexadecimal (`\xN...`) escapes.
                    let ch: i64 = match esc {
                        b'n' => 0x0A,
                        b't' => 0x09,
                        b'r' => 0x0D,
                        b'\\' => b'\\' as i64,
                        b'\'' => b'\'' as i64,
                        b'"' => b'"' as i64,
                        b'a' => 0x07,
                        b'b' => 0x08,
                        b'f' => 0x0C,
                        b'v' => 0x0B,
                        b'x' => {
                            let mut v: i64 = 0;
                            while let Some(&h) = bytes.get(self.pos) {
                                let d = match h {
                                    b'0'..=b'9' => h - b'0',
                                    b'a'..=b'f' => h - b'a' + 10,
                                    b'A'..=b'F' => h - b'A' + 10,
                                    _ => break,
                                };
                                v = (v << 4) | d as i64;
                                self.pos += 1;
                            }
                            v
                        }
                        b'0'..=b'7' => {
                            let mut v = (esc - b'0') as i64;
                            let mut n = 1;
                            while n < 3 {
                                match bytes.get(self.pos) {
                                    Some(&o @ b'0'..=b'7') => {
                                        v = (v << 3) | (o - b'0') as i64;
                                        self.pos += 1;
                                        n += 1;
                                    }
                                    _ => break,
                                }
                            }
                            v
                        }
                        other => other as i64,
                    };
                    if wide {
                        last = ch;
                    } else {
                        count += 1;
                        packed = (packed << 8) | (ch & 0xFF);
                        last = ch;
                    }
                    continue;
                }
                if wide {
                    // A prefixed constant's element is a code point, so
                    // the source's UTF-8 is decoded rather than taken byte
                    // by byte.
                    let (cp, len) = decode_utf8(&bytes[self.pos..]);
                    self.pos += len;
                    last = cp as i64;
                    continue;
                }
                count += 1;
                packed = (packed << 8) | b as i64;
                last = b as i64;
                self.pos += 1;
            }
            return Err(C5Error::Compile(
                "preprocessor: unterminated char literal in `#if`".to_string(),
            ));
        }
        // Integer literal? Decimal, hex (0x...), or octal (0...).
        if let Some(b) = self.peek_byte() {
            if b.is_ascii_digit() {
                return self.parse_int_literal();
            }
            if b.is_ascii_alphabetic() || b == b'_' {
                return self.parse_ident_or_defined();
            }
        }
        Err(C5Error::Compile(alloc::format!(
            "preprocessor: unexpected `{}` in `#if` expression",
            self.tail().chars().next().unwrap_or(' ')
        )))
    }

    /// C99 6.10.1p4: the controlling expression's operands are integer
    /// constants. The token extent comes from `pp_number_len` (6.4.8) so
    /// a pp-number that is not an integer constant is diagnosed whole
    /// instead of splitting into a number and a stray identifier.
    fn parse_int_literal(&mut self) -> Result<IfValue, C5Error> {
        let bytes = self.src.as_bytes();
        let start = self.pos;
        let token_end = start + pp_number_len(bytes, start);
        let mut radix: u32 = 10;
        if bytes.get(self.pos) == Some(&b'0') {
            if bytes.get(self.pos + 1) == Some(&b'x') || bytes.get(self.pos + 1) == Some(&b'X') {
                self.pos += 2;
                radix = 16;
            } else if bytes
                .get(self.pos + 1)
                .is_some_and(|b| (*b as char).is_ascii_digit())
            {
                self.pos += 1;
                radix = 8;
            } else {
                self.pos += 1;
            }
        }
        while let Some(b) = self.peek_byte() {
            let is_digit = match radix {
                16 => b.is_ascii_hexdigit(),
                _ => b.is_ascii_digit(),
            };
            if !is_digit {
                break;
            }
            self.pos += 1;
        }
        // Eat any integer suffix (uUlL combinations) without
        // touching the value; a u/U suffix marks the literal unsigned.
        let mut has_u = false;
        while let Some(b) = self.peek_byte() {
            if matches!(b, b'u' | b'U' | b'l' | b'L') {
                has_u |= matches!(b, b'u' | b'U');
                self.pos += 1;
            } else {
                break;
            }
        }
        if self.pos != token_end {
            let token = &self.src[start..token_end];
            self.pos = token_end;
            return Err(C5Error::Compile(alloc::format!(
                "preprocessor: `{token}` is not an integer constant in `#if`",
            )));
        }
        let body = self.src[start..self.pos].trim_end_matches(['u', 'U', 'l', 'L']);
        // C99 6.10.1p4: preprocessor expressions evaluate in
        // (u)intmax_t. A literal that does not fit `i64` (the
        // signed widest type) but does fit `u64` is parsed
        // as `u64` and stored as its bit pattern in `i64`.
        // This handles `ULONG_MAX` / `UINT64_MAX` literals
        // (e.g. `18446744073709551615`) when they appear in a
        // `#if` expression on an LP64 host.
        let (digits, raw_radix) = if radix == 10 {
            (body, 10u32)
        } else if radix == 16 {
            (
                body.trim_start_matches("0x").trim_start_matches("0X"),
                16u32,
            )
        } else {
            (body.trim_start_matches('0'), radix)
        };
        // 6.10.1p4: intmax_t is the signed widest type. A literal that
        // overflows it but fits u64 takes the unsigned interpretation,
        // matching gcc/clang and keeping the unsigned bit-pattern probes
        // (ULONG_MAX / UINT64_MAX) logical-shifting correctly.
        let v = if digits.is_empty() {
            Ok((0i64, has_u))
        } else if let Ok(signed) = i64::from_str_radix(digits, raw_radix) {
            Ok((signed, has_u))
        } else if let Ok(unsigned) = u64::from_str_radix(digits, raw_radix) {
            Ok((unsigned as i64, true))
        } else {
            Err(())
        };
        match v {
            Ok((n, uns)) => Ok(IfValue::with_sign(n, uns)),
            Err(()) => Err(C5Error::Compile(alloc::format!(
                "preprocessor: malformed integer literal {body:?} in `#if`",
            ))),
        }
    }

    fn parse_ident_or_defined(&mut self) -> Result<IfValue, C5Error> {
        let name = self.scan_ident();
        if name == "defined" {
            // `defined NAME` or `defined(NAME)` -- both are valid.
            self.skip_ws();
            let with_paren = self.eat_byte(b'(');
            self.skip_ws();
            let id = self.scan_ident().to_string();
            if id.is_empty() {
                return Err(C5Error::Compile(
                    "preprocessor: identifier expected after `defined`".to_string(),
                ));
            }
            if with_paren {
                self.skip_ws();
                if !self.eat_byte(b')') {
                    return Err(C5Error::Compile(
                        "preprocessor: missing `)` after `defined(NAME`".to_string(),
                    ));
                }
            }
            return Ok(IfValue::signed(self.pp.is_defined_name(&id) as i64));
        }
        // C23 6.10.1 / universal compiler practice: `__has_include(<h>)`
        // and `__has_include("h")` evaluate to 1 when the header is
        // found on the include search path, 0 otherwise.
        // `__has_include_next` follows the same grammar; c5 resolves it
        // against the same paths.
        if name == "__has_include" || name == "__has_include_next" {
            self.skip_ws();
            if !self.eat_byte(b'(') {
                return Err(C5Error::Compile(
                    "preprocessor: `(` expected after `__has_include`".to_string(),
                ));
            }
            self.skip_ws();
            let close = if self.eat_byte(b'<') {
                b'>'
            } else if self.eat_byte(b'"') {
                b'"'
            } else {
                return Err(C5Error::Compile(
                    "preprocessor: `<header>` or \"header\" expected in `__has_include`"
                        .to_string(),
                ));
            };
            let h_start = self.pos;
            while let Some(b) = self.peek_byte() {
                if b == close {
                    break;
                }
                self.pos += 1;
            }
            let header = self.src[h_start..self.pos].to_string();
            self.eat_byte(close);
            self.skip_ws();
            if !self.eat_byte(b')') {
                return Err(C5Error::Compile(
                    "preprocessor: missing `)` in `__has_include`".to_string(),
                ));
            }
            // Resolve exactly as the matching directive would; only the
            // answer is kept.
            let quoted = close == b'"';
            let form = if name == "__has_include_next" {
                IncludeForm::next(quoted)
            } else {
                IncludeForm::plain(quoted)
            };
            let found = self
                .pp
                .resolve_include(&header, form, self.filename)
                .is_some();
            return Ok(IfValue::signed(found as i64));
        }
        // Identifier -- look up in the macro table. Function-like
        // macros are skipped (they need an argument list which the
        // preprocessor evaluator doesn't simulate). Undefined names
        // are 0 per c99 sec 6.10.1p4.
        self.pp.obs_note(name);
        if let Some(value) = self.pp.macros.get(name) {
            // Strip a leading/trailing quote pair to detect strings.
            if value.starts_with('"') && value.ends_with('"') {
                return Ok(IfValue::Str(value.clone()));
            }
            // Numeric? Try parsing.
            if let Ok(n) = value.parse::<i64>() {
                return Ok(IfValue::signed(n));
            }
            // The macro might itself be a name; recursively expand
            // (bounded) and try once more. The bare-identifier case
            // in c99 evaluates an undefined macro to 0; a defined
            // macro whose body isn't a number falls through to a
            // string-shaped value.
            let expanded = self.pp.expand_or_self(name);
            if let Ok(n) = expanded.parse::<i64>() {
                return Ok(IfValue::signed(n));
            }
            return Ok(IfValue::Str(expanded));
        }
        Ok(IfValue::signed(0))
    }
}

pub(super) fn if_value_eq(a: &IfValue, b: &IfValue) -> bool {
    match (a, b) {
        (IfValue::Int { val: x, .. }, IfValue::Int { val: y, .. }) => x == y,
        (IfValue::Str(x), IfValue::Str(y)) => x == y,
        (IfValue::Int { val: x, .. }, IfValue::Str(y))
        | (IfValue::Str(y), IfValue::Int { val: x, .. }) => {
            // Mixed: prefer int interpretation if the string parses,
            // else compare numerically with 0.
            y.trim_matches('"').parse::<i64>().ok() == Some(*x)
        }
    }
}

/// C99 6.3.1.8 usual arithmetic conversions: `a < b` compares unsigned
/// when either operand is unsigned, signed otherwise. Strings coerce to
/// their signed `as_int` value (0 unless numeric).
pub(super) fn if_value_lt(a: &IfValue, b: &IfValue) -> bool {
    if a.is_unsigned() || b.is_unsigned() {
        (a.as_int() as u64) < (b.as_int() as u64)
    } else {
        a.as_int() < b.as_int()
    }
}

/// Replace every `__has_builtin(NAME)` / `__has_attribute(NAME)` in `s`
/// with `1` or `0`. Run after macro substitution as well as before, so a
/// header that reaches the operator through a macro alias
/// (`#define ALIAS __has_attribute`) still resolves.
pub(super) fn replace_has_operators(s: &str) -> String {
    let bytes = s.as_bytes();
    let mut out = String::with_capacity(s.len());
    let mut i = 0;
    while i < bytes.len() {
        if let Some(next) = resolve_has_operator(s, i, &mut out) {
            i = next;
            continue;
        }
        let start = i;
        i += 1;
        while i < bytes.len() && !bytes[i].is_ascii() {
            i += 1;
        }
        out.push_str(&s[start..i]);
    }
    out
}

/// Whether the operator's identifier operand must be parenthesised.
/// `defined` accepts both forms (C99 6.10.1p1); `__has_builtin` and
/// `__has_attribute` require the parentheses.
#[derive(Clone, Copy, PartialEq)]
enum Parens {
    Required,
    Optional,
}

/// Parse `kw ( NAME )` at `at`: `kw` must sit at a word boundary (C99
/// 6.10: a directive operand is one preprocessing token), then optional
/// white space, the operand, and the closing `)`. Returns the operand
/// and the index just past the call. `Parens::Optional` also accepts the
/// bare `kw NAME` form and tolerates a missing `)`.
fn operator_operand<'a>(
    s: &'a str,
    at: usize,
    kw: &str,
    parens: Parens,
) -> Option<(&'a str, usize)> {
    let bytes = s.as_bytes();
    if !bytes[at..].starts_with(kw.as_bytes()) {
        return None;
    }
    let after = at + kw.len();
    let prev_word = at > 0 && is_ident_byte(bytes[at - 1]);
    let next_word = bytes.get(after).copied().is_some_and(is_ident_byte);
    if prev_word || next_word {
        return None;
    }
    let skip_ws = |mut j: usize| {
        while j < bytes.len() && bytes[j].is_ascii_whitespace() {
            j += 1;
        }
        j
    };
    let mut j = skip_ws(after);
    let open = bytes.get(j) == Some(&b'(');
    if open {
        j = skip_ws(j + 1);
    } else if parens == Parens::Required {
        return None;
    }
    let name_start = j;
    while j < bytes.len() && is_ident_byte(bytes[j]) {
        j += 1;
    }
    let name = &s[name_start..j];
    if name.is_empty() {
        return None;
    }
    if open {
        j = skip_ws(j);
        match bytes.get(j) {
            Some(&b')') => j += 1,
            // A required-paren operator with no `)` is not a call; the
            // optional-paren form tolerates it, as it did before.
            _ if parens == Parens::Required => return None,
            _ => {}
        }
    }
    Some((name, j))
}

/// Match `kw ( operand )` at `at` with a word boundary around `kw`,
/// the operand running to the balancing `)`. Returns the operand text
/// and the index just past the call. String and char literals inside
/// the operand are skipped opaquely.
fn balanced_operand<'a>(s: &'a str, at: usize, kw: &str) -> Option<(&'a str, usize)> {
    let bytes = s.as_bytes();
    if !bytes[at..].starts_with(kw.as_bytes()) {
        return None;
    }
    let after = at + kw.len();
    let prev_word = at > 0 && is_ident_byte(bytes[at - 1]);
    let next_word = bytes.get(after).copied().is_some_and(is_ident_byte);
    if prev_word || next_word {
        return None;
    }
    let mut j = after;
    while j < bytes.len() && bytes[j].is_ascii_whitespace() {
        j += 1;
    }
    if bytes.get(j) != Some(&b'(') {
        return None;
    }
    let start = j + 1;
    let mut depth = 1usize;
    j = start;
    while j < bytes.len() {
        match bytes[j] {
            b'"' | b'\'' => {
                j = skip_literal(bytes, j);
                continue;
            }
            b'(' => depth += 1,
            b')' => {
                depth -= 1;
                if depth == 0 {
                    return Some((&s[start..j], j + 1));
                }
            }
            _ => {}
        }
        j += 1;
    }
    None
}

/// The `#if` operators whose identifier operand is resolved textually,
/// before and after macro substitution.
type HasOperator = (&'static str, fn(&str) -> bool);

const HAS_OPERATORS: [HasOperator; 2] = [
    ("__has_builtin", builtins::has_builtin),
    ("__has_attribute", is_known_attribute),
];

/// Resolve a `__has_*` operator at `i`, appending `1` or `0` to `out`.
/// Returns the index just past the call, or `None` when no operator
/// starts there.
fn resolve_has_operator(s: &str, i: usize, out: &mut String) -> Option<usize> {
    for (op, is_known) in HAS_OPERATORS {
        if let Some((name, next)) = operator_operand(s, i, op, Parens::Required) {
            out.push_str(if is_known(name) { "1" } else { "0" });
            return Some(next);
        }
    }
    None
}

/// True when badc recognizes the GCC/Clang attribute NAME, so
/// `__has_attribute(NAME)` reports 1. The name may be spelled bare or
/// wrapped in `__` (`cleanup` / `__cleanup__`). badc parses every
/// `__attribute__((...))` and acts on a subset (`packed`, `aligned`,
/// `unused`, `noreturn`, `cleanup`, `alias`, `naked`); the rest are
/// accepted and ignored, so reporting 1 lets feature-testing headers
/// take their attribute path.
pub(super) fn is_known_attribute(name: &str) -> bool {
    let core = name.trim_matches('_');
    matches!(
        core,
        "cleanup"
            | "alias"
            | "naked"
            | "packed"
            | "aligned"
            | "unused"
            | "maybe_unused"
            | "used"
            | "noreturn"
            | "deprecated"
            | "const"
            | "pure"
            | "malloc"
            | "always_inline"
            | "noinline"
            | "gnu_inline"
            | "flatten"
            | "format"
            | "format_arg"
            | "sentinel"
            | "nonnull"
            | "returns_nonnull"
            | "warn_unused_result"
            | "alloc_size"
            | "alloc_align"
            | "assume_aligned"
            | "cold"
            | "hot"
            | "weak"
            | "visibility"
            | "section"
            | "constructor"
            | "destructor"
            | "may_alias"
            | "transparent_union"
            | "fallthrough"
            | "nothrow"
            | "no_instrument_function"
            | "returns_twice"
            | "noclone"
            | "error"
            | "warning"
            | "unavailable"
            // Accepted and validated for its feature names; badc emits
            // every instruction its intrinsic surface carries on x86-64,
            // so the attribute selects nothing further.
            | "target"
    )
}

use super::Preprocessor;
use super::include::include_parent_dir;
use super::text::strip_c_comments;
use crate::c5::error::C5Error;
use alloc::format;
use alloc::string::{String, ToString};

impl Preprocessor {
    /// Pre-pass for `#if` evaluation: protect every `defined(NAME)`
    /// (and `defined NAME`) by replacing it with `1` or `0` *before*
    /// macro substitution. Otherwise `substitute` would expand the
    /// argument and lose the original name. Returns a fully
    /// macro-substituted string suitable for the `#if` expression
    /// parser.
    pub(super) fn expand_for_if(&self, expr: &str, line_no: usize) -> String {
        let mut out = String::with_capacity(expr.len());
        let bytes = expr.as_bytes();
        let mut i = 0;
        while i < bytes.len() {
            // Skip whitespace.
            if (bytes[i] as char).is_ascii_whitespace() {
                out.push(bytes[i] as char);
                i += 1;
                continue;
            }
            // Comments were removed in phase 3; the literal-aware
            // strip after substitution covers macro-introduced ones.
            // Match `defined` keyword (must be a complete word).
            if bytes[i..].starts_with(b"defined") {
                let after = i + b"defined".len();
                let prev_is_word =
                    i > 0 && (bytes[i - 1].is_ascii_alphanumeric() || bytes[i - 1] == b'_');
                let next_is_word = bytes
                    .get(after)
                    .is_some_and(|b| b.is_ascii_alphanumeric() || *b == b'_');
                if !prev_is_word && !next_is_word {
                    let mut j = after;
                    while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                        j += 1;
                    }
                    let with_paren = bytes.get(j) == Some(&b'(');
                    if with_paren {
                        j += 1;
                        while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                            j += 1;
                        }
                    }
                    let name_start = j;
                    while j < bytes.len() && (bytes[j].is_ascii_alphanumeric() || bytes[j] == b'_')
                    {
                        j += 1;
                    }
                    let name = &expr[name_start..j];
                    if with_paren {
                        while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                            j += 1;
                        }
                        if bytes.get(j) == Some(&b')') {
                            j += 1;
                        }
                    }
                    if !name.is_empty() {
                        // `__has_include` / `__has_include_next` are
                        // always-available operators, so the guard
                        // `defined(__has_include)` is true.
                        let v = name == "__has_include"
                            || name == "__has_include_next"
                            || name == "__has_builtin"
                            || name == "__has_attribute"
                            || self.macros.contains_key(name)
                            || self.fn_macros.contains_key(name);
                        out.push_str(if v { "1" } else { "0" });
                        i = j;
                        continue;
                    }
                }
            }
            // `__has_builtin(NAME)` (C23 6.10.1 / universal practice): 1
            // when the compiler provides builtin NAME, else 0. Resolved
            // before substitution so the builtin name is not expanded.
            if bytes[i..].starts_with(b"__has_builtin") {
                let after = i + b"__has_builtin".len();
                let prev_is_word =
                    i > 0 && (bytes[i - 1].is_ascii_alphanumeric() || bytes[i - 1] == b'_');
                let next_is_word = bytes
                    .get(after)
                    .is_some_and(|b| b.is_ascii_alphanumeric() || *b == b'_');
                if !prev_is_word && !next_is_word {
                    let mut j = after;
                    while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                        j += 1;
                    }
                    if bytes.get(j) == Some(&b'(') {
                        j += 1;
                        while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                            j += 1;
                        }
                        let name_start = j;
                        while j < bytes.len()
                            && (bytes[j].is_ascii_alphanumeric() || bytes[j] == b'_')
                        {
                            j += 1;
                        }
                        let name = &expr[name_start..j];
                        while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                            j += 1;
                        }
                        if bytes.get(j) == Some(&b')') && !name.is_empty() {
                            j += 1;
                            out.push_str(if is_known_builtin(name) { "1" } else { "0" });
                            i = j;
                            continue;
                        }
                    }
                }
            }
            // `__has_attribute(NAME)`: 1 when the compiler recognizes the
            // GCC/Clang attribute NAME, else 0. A header may gate a
            // `cleanup`-attribute helper on `#if <alias>(cleanup)`.
            if bytes[i..].starts_with(b"__has_attribute") {
                let after = i + b"__has_attribute".len();
                let prev_is_word =
                    i > 0 && (bytes[i - 1].is_ascii_alphanumeric() || bytes[i - 1] == b'_');
                let next_is_word = bytes
                    .get(after)
                    .is_some_and(|b| b.is_ascii_alphanumeric() || *b == b'_');
                if !prev_is_word && !next_is_word {
                    let mut j = after;
                    while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                        j += 1;
                    }
                    if bytes.get(j) == Some(&b'(') {
                        j += 1;
                        while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                            j += 1;
                        }
                        let name_start = j;
                        while j < bytes.len()
                            && (bytes[j].is_ascii_alphanumeric() || bytes[j] == b'_')
                        {
                            j += 1;
                        }
                        let name = &expr[name_start..j];
                        while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                            j += 1;
                        }
                        if bytes.get(j) == Some(&b')') && !name.is_empty() {
                            j += 1;
                            out.push_str(if is_known_attribute(name) { "1" } else { "0" });
                            i = j;
                            continue;
                        }
                    }
                }
            }
            out.push(bytes[i] as char);
            i += 1;
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
        let prepared = self.expand_for_if(expr, line_no);
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
        // C11 6.4.4.4: a character constant may carry an `L`, `u`, or
        // `U` encoding prefix (`L'/'`). In a `#if` controlling
        // expression its value is the character code, so the prefix is
        // consumed and the literal read as below.
        if let Some(&p) = self.src.as_bytes().get(self.pos)
            && matches!(p, b'L' | b'u' | b'U')
            && self.src.as_bytes().get(self.pos + 1) == Some(&b'\'')
        {
            self.pos += 1;
        }
        if self.eat_byte(b'\'') {
            // Character literal. Multi-char (`'AB'`) is
            // implementation-defined; each byte shifts into the
            // accumulator, matching gcc.
            let bytes = self.src.as_bytes();
            let mut acc: i64 = 0;
            let mut count = 0usize;
            while let Some(b) = self.peek_byte() {
                if b == b'\'' {
                    self.pos += 1;
                    // C99 6.4.4.4p10: a single-character constant has
                    // the char's value as int -- sign-extended on
                    // signed-plain-char targets, matching the lexer.
                    if count == 1 && self.pp.target.plain_char_signed() && (0..=0xFF).contains(&acc)
                    {
                        acc = acc as u8 as i8 as i64;
                    }
                    return Ok(IfValue::signed(acc));
                }
                count += 1;
                if b == b'\\' && self.pos + 1 < bytes.len() {
                    self.pos += 2;
                    let esc = bytes[self.pos - 1];
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
                            v & 0xFF
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
                    acc = (acc << 8) | ch;
                } else {
                    acc = (acc << 8) | (b as i64);
                    self.pos += 1;
                }
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

    fn parse_int_literal(&mut self) -> Result<IfValue, C5Error> {
        let bytes = self.src.as_bytes();
        let start = self.pos;
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
        let body_start = self.pos;
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
        let _ = body_start;
        match v {
            Ok((n, uns)) => Ok(IfValue::with_sign(n, uns)),
            Err(()) => Err(C5Error::Compile(alloc::format!(
                "preprocessor: malformed integer literal {body:?} in `#if`",
            ))),
        }
    }

    fn parse_ident_or_defined(&mut self) -> Result<IfValue, C5Error> {
        let start = self.pos;
        while let Some(b) = self.peek_byte() {
            if b.is_ascii_alphanumeric() || b == b'_' {
                self.pos += 1;
            } else {
                break;
            }
        }
        let name = &self.src[start..self.pos];
        if name == "defined" {
            // `defined NAME` or `defined(NAME)` -- both are valid.
            self.skip_ws();
            let with_paren = self.eat_byte(b'(');
            self.skip_ws();
            let id_start = self.pos;
            while let Some(b) = self.peek_byte() {
                if b.is_ascii_alphanumeric() || b == b'_' {
                    self.pos += 1;
                } else {
                    break;
                }
            }
            if id_start == self.pos {
                return Err(C5Error::Compile(
                    "preprocessor: identifier expected after `defined`".to_string(),
                ));
            }
            let id = self.src[id_start..self.pos].to_string();
            if with_paren {
                self.skip_ws();
                if !self.eat_byte(b')') {
                    return Err(C5Error::Compile(
                        "preprocessor: missing `)` after `defined(NAME`".to_string(),
                    ));
                }
            }
            return Ok(IfValue::signed(self.pp.macros.contains_key(&id) as i64));
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
            // Resolve exactly as the matching directive would: the
            // quoted form probes the including file's directory first
            // (C99 6.10.2p2), and `__has_include_next` resumes past
            // the search-path entry that supplied the current file.
            let found = if name == "__has_include_next" {
                self.pp.find_include_next(&header, self.filename).is_some()
            } else {
                let source_dir = if close == b'"' {
                    include_parent_dir(self.filename)
                } else {
                    None
                };
                self.pp
                    .find_include(&header, source_dir.as_deref())
                    .is_some()
            };
            return Ok(IfValue::signed(found as i64));
        }
        // Identifier -- look up in the macro table. Function-like
        // macros are skipped (they need an argument list which the
        // preprocessor evaluator doesn't simulate). Undefined names
        // are 0 per c99 sec 6.10.1p4.
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

/// True when badc provides the named GCC/Clang compiler builtin (with the
/// `__builtin_` prefix), so `__has_builtin(NAME)` reports 1. Names not
/// listed report 0, which routes feature-testing headers to their
/// portable fallbacks. Only genuine compiler intrinsics and the
/// always-defined `<_builtins.h>` thunks are listed; forms that a header
/// must fall back to portable C for (e.g. `__builtin_bitreverse*`,
/// `__builtin_addcll`, `__builtin_bswap128`) are deliberately absent.
pub(super) fn is_known_builtin(name: &str) -> bool {
    matches!(
        name,
        "__builtin_clz"
            | "__builtin_clzl"
            | "__builtin_clzll"
            | "__builtin_ctz"
            | "__builtin_ctzl"
            | "__builtin_ctzll"
            | "__builtin_popcount"
            | "__builtin_popcountl"
            | "__builtin_popcountll"
            | "__builtin_bswap16"
            | "__builtin_bswap32"
            | "__builtin_bswap64"
            | "__builtin_clrsb"
            | "__builtin_clrsbl"
            | "__builtin_clrsbll"
            | "__builtin_parity"
            | "__builtin_parityl"
            | "__builtin_parityll"
            | "__builtin_ffs"
            | "__builtin_ffsl"
            | "__builtin_ffsll"
            | "__builtin_expect"
            | "__builtin_unreachable"
            | "__builtin_trap"
            | "__builtin_alloca"
            | "__builtin_frame_address"
            | "__builtin_return_address"
            | "__builtin_constant_p"
            | "__builtin_choose_expr"
            | "__builtin_types_compatible_p"
            | "__builtin_prefetch"
            | "__builtin_assume_aligned"
            | "__builtin_add_overflow"
            | "__builtin_sub_overflow"
            | "__builtin_mul_overflow"
            | "__builtin_va_start"
            | "__builtin_va_arg"
            | "__builtin_va_end"
            | "__builtin_va_copy"
    )
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
        let mut matched = false;
        for (op, is_known) in [
            ("__has_builtin", is_known_builtin as fn(&str) -> bool),
            ("__has_attribute", is_known_attribute as fn(&str) -> bool),
        ] {
            if !bytes[i..].starts_with(op.as_bytes()) {
                continue;
            }
            let prev_word = i > 0 && (bytes[i - 1].is_ascii_alphanumeric() || bytes[i - 1] == b'_');
            let after = i + op.len();
            let next_word = bytes
                .get(after)
                .is_some_and(|b| b.is_ascii_alphanumeric() || *b == b'_');
            if prev_word || next_word {
                continue;
            }
            let mut j = after;
            while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                j += 1;
            }
            if bytes.get(j) != Some(&b'(') {
                continue;
            }
            j += 1;
            while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                j += 1;
            }
            let name_start = j;
            while j < bytes.len() && (bytes[j].is_ascii_alphanumeric() || bytes[j] == b'_') {
                j += 1;
            }
            let name = &s[name_start..j];
            while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                j += 1;
            }
            if bytes.get(j) == Some(&b')') && !name.is_empty() {
                out.push_str(if is_known(name) { "1" } else { "0" });
                i = j + 1;
                matched = true;
                break;
            }
        }
        if !matched {
            out.push(bytes[i] as char);
            i += 1;
        }
    }
    out
}

/// The built-in feature-test operators badc provides. They are not
/// macros, but `#ifdef` / `defined(...)` on their names reports true so
/// headers can guard `#ifdef __has_attribute` before using the operator.
pub(super) fn is_builtin_operator_name(name: &str) -> bool {
    matches!(
        name,
        "__has_include" | "__has_include_next" | "__has_builtin" | "__has_attribute"
    )
}

/// True when badc recognizes the GCC/Clang attribute NAME, so
/// `__has_attribute(NAME)` reports 1. The name may be spelled bare or
/// wrapped in `__` (`cleanup` / `__cleanup__`). badc parses every
/// `__attribute__((...))` and acts on a subset (`packed`, `aligned`,
/// `unused`, `noreturn`); the rest are accepted and ignored, so
/// reporting 1 lets feature-testing headers take their attribute path.
/// `cleanup` is reported present so `cleanup`-attribute helpers
/// activate (the destructor is not yet run at scope exit -- a resource
/// managed this way is freed at process exit, not block exit).
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
    )
}

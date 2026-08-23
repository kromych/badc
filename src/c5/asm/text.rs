//! Assembler source text: statement and label splitting, comment
//! stripping, the local-label forms, and the identifier substitution
//! the inline-asm templates run before parsing.

use super::*;
// Assembler code still held by the SSA emit substrate; folds in as the
// remaining groups move over.
use crate::c5::codegen::ssa::emit_common::{next_asm_instance, parse_raw_int};

/// Peel the labels leading a statement from the rest of it. GNU as lets any
/// number of labels share a statement with the directive or instruction that
/// follows (`1: .irp num,...`), so the first token is not always the
/// directive. Returns the label text, empty when there is none, and the
/// remainder, empty when the statement is labels only.
pub(crate) fn split_leading_labels(s: &str) -> (alloc::vec::Vec<&str>, &str) {
    let mut labels = alloc::vec::Vec::new();
    let mut end = 0usize;
    loop {
        let rest = s[end..].trim_start();
        let off = s.len() - rest.len();
        let name = rest
            .find(|c: char| !(c.is_ascii_alphanumeric() || c == '_' || c == '.' || c == '$'))
            .unwrap_or(rest.len());
        if name == 0 || !rest[name..].starts_with(':') {
            break;
        }
        // `name::` is the global-label spelling; both colons belong to it.
        let colons = if rest[name + 1..].starts_with(':') {
            2
        } else {
            1
        };
        labels.push(&rest[..name + colons]);
        end = off + name + colons;
    }
    (labels, s[end..].trim_start())
}

/// Label numbers at and above this mark are interned named labels
/// (`name:` definitions); below it, GNU-as numeric locals (`1:`).
pub(crate) const NAMED_LABEL_BASE: u32 = 1 << 31;

/// Peel one leading label definition off a statement, returning the label
/// name and the remainder. A name is a GNU as identifier; an all-digit name
/// is a numeric local.
pub(crate) fn split_label_def(piece: &str) -> Option<(&str, &str)> {
    let colon = piece.find(':')?;
    if colon == 0 {
        return None;
    }
    let name = &piece.as_bytes()[..colon];
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let named = !name[0].is_ascii_digit() && ident(name[0]) && name.iter().all(|&c| ident(c));
    if named || name.iter().all(u8::is_ascii_digit) {
        Some((&piece[..colon], &piece[colon + 1..]))
    } else {
        None
    }
}

/// Named labels defined in a template's code text, in definition order --
/// the intern order the `NAMED_LABEL_BASE + index` label numbers use. Both
/// arch parsers and the emitters' section materialization read this, so a
/// reference resolves a name to the same number everywhere.
pub(crate) fn scan_label_names(text: &str) -> alloc::vec::Vec<&str> {
    let mut names: alloc::vec::Vec<&str> = alloc::vec::Vec::new();
    for piece in split_asm_statements(text) {
        let mut p = piece.trim();
        while let Some((name, rest)) = split_label_def(p) {
            if !name.as_bytes()[0].is_ascii_digit() && !names.contains(&name) {
                names.push(name);
            }
            p = rest.trim();
        }
    }
    names
}

/// The first named label a template's code text defines twice. A name has
/// one definition in GNU as, which rejects a second; a numeric local may
/// repeat, and each reference binds by direction.
pub(crate) fn duplicate_label_name(text: &str) -> Option<&str> {
    let mut seen: alloc::vec::Vec<&str> = alloc::vec::Vec::new();
    for piece in split_asm_statements(text) {
        let mut p = piece.trim();
        while let Some((name, rest)) = split_label_def(p) {
            if !name.as_bytes()[0].is_ascii_digit() {
                if seen.contains(&name) {
                    return Some(name);
                }
                seen.push(name);
            }
            p = rest.trim();
        }
    }
    None
}

/// Split a template into statements at `;` and newlines, with `;` inside a
/// double-quoted run kept (a quoted macro argument carries whole
/// instruction sequences: `ALTERNATIVE "a; b", ...`). A newline always
/// separates, as a string literal cannot span one.
pub(crate) fn split_asm_statements(text: &str) -> alloc::vec::Vec<&str> {
    if !text.contains('"') {
        return text.split([';', '\n']).collect();
    }
    let b = text.as_bytes();
    let mut out = alloc::vec::Vec::new();
    let (mut start, mut quoted) = (0usize, false);
    for (i, &c) in b.iter().enumerate() {
        match c {
            b'"' => quoted = !quoted,
            b'\n' => {
                out.push(&text[start..i]);
                start = i + 1;
                quoted = false;
            }
            b';' if !quoted => {
                out.push(&text[start..i]);
                start = i + 1;
            }
            _ => {}
        }
    }
    out.push(&text[start..]);
    out
}

/// Split off the first whitespace-delimited token and the trimmed remainder.
pub(crate) fn split_first_token(s: &str) -> (&str, &str) {
    match s.find(char::is_whitespace) {
        Some(p) => (&s[..p], s[p..].trim()),
        None => (s, ""),
    }
}

/// Peel a leading `name:` label from a statement. GNU as terminates a label at
/// the colon and requires no whitespace before the statement that follows, so
/// `name:insn` is a label plus an instruction. Returns the label name and the
/// remainder (leading whitespace trimmed), or `None` when the statement does
/// not begin with a label. A colon reached only after other tokens (an
/// operand's `seg:` or a far branch's `$sel:$off`) leaves whitespace or a
/// sigil in the preceding text, which is not a valid label name.
pub(crate) fn peel_leading_label(stmt: &str) -> Option<(&str, &str)> {
    let colon = stmt.find(':')?;
    // GNU as allows whitespace between the label and its colon (`0 :`).
    let name = stmt[..colon].trim_end();
    if !is_asm_symbol_name(name) && !is_numeric_label(name) {
        return None;
    }
    Some((name, stmt[colon + 1..].trim_start()))
}

/// An assembler symbol name: identifier characters, not starting with a
/// digit (which would be a local numeric label, not a symbol definition).
pub(crate) fn is_asm_symbol_name(name: &str) -> bool {
    !name.is_empty()
        && !name.as_bytes()[0].is_ascii_digit()
        && name
            .bytes()
            .all(|c| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$'))
}

/// A `.set` value written as a symbol at a byte offset (`sym`, `sym + 8`,
/// `sym - 4`). The name it assigns is an alias of `sym` at that offset
/// wherever the unit's layout does not place the value itself. `None` for
/// any other expression, including one over the location counter.
pub(crate) fn asm_sym_offset_expr(expr: &str) -> Option<(&str, i64)> {
    let expr = expr.trim();
    let named = |s: &str| is_asm_symbol_name(s) && s != ".";
    if named(expr) {
        return Some((expr, 0));
    }
    let at = expr.find(['+', '-'])?;
    let (sym, rest) = expr.split_at(at);
    let sym = sym.trim();
    let v = parse_raw_int(rest[1..].trim())?;
    named(sym).then(|| (sym, if rest.starts_with('-') { -v } else { v }))
}

/// A GNU as local numeric label: all decimal digits (`2`, `14470`). Its
/// definition (`2:`) and references (`2b` / `2f`) are local to one asm
/// instance, so the materializer renames each to a unique symbol.
pub(crate) fn is_numeric_label(name: &str) -> bool {
    !name.is_empty() && name.bytes().all(|c| c.is_ascii_digit())
}

/// Split a numeric-label reference into its digits, dropping a trailing
/// GNU as direction suffix (`14472b` / `14471f` -> `14472` / `14471`).
/// Returns `None` when the reference is not a numeric label.
pub(crate) fn numeric_label_digits(name: &str) -> Option<&str> {
    let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
    is_numeric_label(digits).then_some(digits)
}

/// One GNU as local (numeric) label occurrence in a template: a definition
/// (`2:`) or a reference (`2f` / `2b`). `start`..`end` spans the token in the
/// source text -- the digits for a definition (the `:` stays), the digits and
/// the direction letter for a reference.
struct LocalLabelTok<'a> {
    start: usize,
    end: usize,
    num: &'a str,
    /// `Some(forward)` for a reference, `None` for a definition.
    reference: Option<bool>,
}

/// Scan a template for GNU as local (numeric) label definitions (`2:`) and
/// references (`2f` / `2b`). A digit run is a label token only at a token
/// boundary -- so `0x1f`, `sym1`, and a fractional `0.5f` are skipped -- and,
/// for a reference, only when the direction letter ends the token (`2foo` is a
/// symbol, not `2f`).
fn scan_local_label_tokens(text: &str) -> alloc::vec::Vec<LocalLabelTok<'_>> {
    let b = text.as_bytes();
    let n = b.len();
    let mut out = alloc::vec::Vec::new();
    let mut i = 0;
    while i < n {
        if !b[i].is_ascii_digit() {
            i += 1;
            continue;
        }
        let boundary = i == 0 || {
            let p = b[i - 1];
            !(p.is_ascii_alphanumeric() || matches!(p, b'_' | b'.'))
        };
        let ds = i;
        while i < n && b[i].is_ascii_digit() {
            i += 1;
        }
        let de = i;
        if !boundary {
            continue;
        }
        if i < n && (b[i] == b'b' || b[i] == b'f') {
            let ends = i + 1 >= n || !(b[i + 1].is_ascii_alphanumeric() || b[i + 1] == b'_');
            if ends {
                out.push(LocalLabelTok {
                    start: ds,
                    end: i + 1,
                    num: &text[ds..de],
                    reference: Some(b[i] == b'f'),
                });
                i += 1;
                continue;
            }
        }
        // GNU as allows horizontal whitespace between a label and its colon.
        let mut c = i;
        while c < n && (b[c] == b' ' || b[c] == b'\t') {
            c += 1;
        }
        if c < n && b[c] == b':' {
            out.push(LocalLabelTok {
                start: ds,
                end: de,
                num: &text[ds..de],
                reference: None,
            });
        }
    }
    out
}

/// Rewrite GNU as local (numeric) labels defined more than once in one asm
/// instance to per-definition unique names, binding each `Nf` / `Nb`
/// reference to the nearest definition in its direction by source position
/// (`f` a greater position, `b` a not-greater one). The rest of the pipeline
/// resolves a label as a single-definition symbol, so this turns the
/// multiple-definition case -- a template reusing `1:` across nested
/// replacement blocks -- into the handled named-label case. A number defined
/// once keeps its numeric form (the common case), so the result is `None` when
/// no number is defined more than once.
pub(crate) fn rewrite_multidef_local_labels(text: &str) -> Option<alloc::string::String> {
    let toks = scan_local_label_tokens(text);
    let mut def_counts: alloc::collections::BTreeMap<&str, usize> =
        alloc::collections::BTreeMap::new();
    for t in &toks {
        if t.reference.is_none() {
            *def_counts.entry(t.num).or_default() += 1;
        }
    }
    if def_counts.values().all(|&c| c < 2) {
        return None;
    }
    let uniq = next_asm_instance();
    // Each multiply-defined number's definitions in source order, paired with
    // the unique name assigned to that definition.
    let mut defs: alloc::collections::BTreeMap<
        &str,
        alloc::vec::Vec<(usize, alloc::string::String)>,
    > = alloc::collections::BTreeMap::new();
    for t in &toks {
        if t.reference.is_none() && def_counts[t.num] >= 2 {
            let v = defs.entry(t.num).or_default();
            let name = alloc::format!(".Lc5ll_{uniq}_{}_{}", t.num, v.len());
            v.push((t.start, name));
        }
    }
    let mut out = alloc::string::String::with_capacity(text.len());
    let mut last = 0;
    for t in &toks {
        let Some(list) = defs.get(t.num) else {
            continue; // defined once: keep the numeric form
        };
        let name = match t.reference {
            None => list.iter().find(|(p, _)| *p == t.start).map(|(_, s)| s),
            Some(true) => list
                .iter()
                .filter(|(p, _)| *p > t.start)
                .min_by_key(|(p, _)| *p)
                .map(|(_, s)| s),
            Some(false) => list
                .iter()
                .filter(|(p, _)| *p <= t.start)
                .max_by_key(|(p, _)| *p)
                .map(|(_, s)| s),
        };
        let Some(name) = name else {
            continue; // no definition in the reference's direction: leave it
        };
        out.push_str(&text[last..t.start]);
        out.push_str(name);
        last = t.end;
    }
    out.push_str(&text[last..]);
    Some(out)
}

/// Assembler comment syntax of a target.
///
/// Both targets accept `/* */` block comments anywhere, keep `;` and newline
/// as statement separators, and never strip inside a string literal. They
/// differ in the line-comment characters:
///
/// * x86-64: `#` starts a comment anywhere in a line. GNU as rejects `//` as
///   junk after an operand, so no valid template relies on it and treating it
///   as a comment matches the clang integrated assembler.
/// * aarch64: `//` starts a comment anywhere. `#` prefixes an immediate
///   (`mov x0, #1`) and starts a comment only as the first token of a
///   statement, which is where the `#`-prefixed line markers appear.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum AsmComments {
    X86,
    A64,
}

/// Strip assembler comments from an inline-asm template. A block comment
/// becomes one space so the tokens around it stay separate; a line comment
/// runs to the newline, which is kept because it separates statements.
/// Returns `None` when the template has no comment character.
///
/// Comments go before statement splitting: a line comment swallows any `;`
/// after it, and a `;` or newline inside a block comment does not separate
/// statements.
pub(crate) fn strip_asm_comments(text: &str, syntax: AsmComments) -> Option<alloc::string::String> {
    if !text.contains("/*") && !text.contains("//") && !text.contains('#') {
        return None;
    }
    let b = text.as_bytes();
    let mut out = alloc::string::String::with_capacity(text.len());
    let mut i = 0;
    // A statement starts at the template start and after every separator;
    // leading whitespace and label definitions do not end it, matching GNU
    // as, which comments `1: # text` but rejects `.balign 4 # text`.
    let mut at_stmt_start = true;
    // Everything seen since the statement start is label text or whitespace,
    // so a `:` here closes a label definition rather than ending the start.
    let mut in_label_prefix = true;
    while i < b.len() {
        let c = b[i];
        if c == b'"' {
            let start = i;
            i += 1;
            while i < b.len() && b[i] != b'"' {
                i += if b[i] == b'\\' { 2 } else { 1 };
            }
            i = b.len().min(i + 1);
            out.push_str(&text[start..i]);
            at_stmt_start = false;
            in_label_prefix = false;
            continue;
        }
        if c == b'/' && b.get(i + 1) == Some(&b'*') {
            // An unterminated block comment runs to the end of the template.
            i = text[i + 2..].find("*/").map_or(b.len(), |p| i + 2 + p + 2);
            out.push(' ');
            continue;
        }
        let line_comment = (c == b'/' && b.get(i + 1) == Some(&b'/'))
            || (c == b'#' && (syntax == AsmComments::X86 || at_stmt_start));
        if line_comment {
            while i < b.len() && b[i] != b'\n' {
                i += 1;
            }
            continue;
        }
        if c == b'\n' || c == b';' {
            at_stmt_start = true;
            in_label_prefix = true;
        } else if c == b':' && in_label_prefix {
            at_stmt_start = true;
        } else if !c.is_ascii_whitespace() {
            at_stmt_start = false;
            in_label_prefix &= c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
        }
        out.push(char::from(c));
        i += 1;
    }
    Some(out)
}

/// True when an extended-asm statement lowers to no machine code or data:
/// after comment stripping the template holds only whitespace and statement
/// separators, and no operand is a flag output (`=@cc` materializes a
/// `setcc` even with an empty template). Such a statement writes no
/// register and reads no operand, so the operand staging -- register
/// saves, captures, input loads, output store-backs -- is dead and the
/// frame scratch region it would use is not reserved. The IR instruction
/// itself stays: it still orders memory accesses. The per-arch scratch
/// sizing and emitters share this so the region and the staging agree.
pub(crate) fn asm_statement_is_noop(asm: &crate::c5::ir::AsmBlock, syntax: AsmComments) -> bool {
    if asm
        .operands
        .iter()
        .any(|op| matches!(op.constraint, crate::c5::ir::AsmConstraint::Flags(_)))
    {
        return false;
    }
    let Ok(raw) = core::str::from_utf8(&asm.template) else {
        return false;
    };
    let stripped = strip_asm_comments(raw, syntax);
    let text = stripped.as_deref().unwrap_or(raw);
    text.bytes().all(|b| b.is_ascii_whitespace() || b == b';')
}

/// Whether `name` spells a template label reference: a numeric `Nb` / `Nf`
/// or a name in the template's intern table.
pub(crate) fn is_template_label(name: &str, names: &[&str]) -> bool {
    names.contains(&name) || numeric_label_digits(name).is_some_and(|d| d.len() < name.len())
}

/// Whether every leaf of `expr` is a template label or a literal, so the
/// emitted stream settles its value with no relocation.
pub(crate) fn is_template_label_expr(expr: &str, names: &[&str]) -> bool {
    let all = core::cell::Cell::new(true);
    let resolve = |t: &str| {
        all.set(all.get() && is_template_label(t, names));
        Some(AsmExprLeaf::Abs(0))
    };
    let ctx = AsmExprCtx {
        resolve: &resolve,
        const_of: &|_| None,
        lax_div: true,
    };
    eval_asm_value(expr, &ctx).is_ok() && all.get()
}

/// The stream offset a template label reference stands for, under the GNU as
/// local-label rule: `Nb` binds to the nearest definition at or before `at`,
/// `Nf` to the nearest after it, a name to its single definition. `names` is
/// the template's intern table.
pub(crate) fn template_label_offset(
    name: &str,
    at: usize,
    label_defs: &[(u32, usize)],
    names: &[&str],
) -> Option<i64> {
    let nearest = |num: u32, forward: bool| -> Option<i64> {
        let defs = label_defs.iter().filter(|&&(n, _)| n == num);
        if forward {
            defs.filter(|&&(_, off)| off > at).map(|&(_, o)| o).min()
        } else {
            defs.filter(|&&(_, off)| off <= at).map(|&(_, o)| o).max()
        }
        .map(|o| o as i64)
    };
    if let Some(idx) = names.iter().position(|&n| n == name) {
        let num = NAMED_LABEL_BASE + idx as u32;
        return label_defs
            .iter()
            .find(|&&(n, _)| n == num)
            .map(|&(_, o)| o as i64);
    }
    let digits = numeric_label_digits(name)?;
    if digits.len() == name.len() {
        return None;
    }
    nearest(digits.parse().ok()?, name.ends_with('f'))
}

/// Substitute each identifier `resolve` knows with its value, leaving other
/// tokens -- numeric literals, unknown symbols, the location counter `.` --
/// as written. Identifier characters are the assembler's: alphanumeric plus
/// `_` / `.` / `$`; `$` continues a name but does not start one, so the AT&T
/// immediate sigil in `$sym` separates from the name it prefixes while a
/// symbol spelled `x$y` stays one token.
pub(crate) fn subst_asm_idents(
    text: &str,
    resolve: &dyn Fn(&str) -> Option<i64>,
) -> alloc::string::String {
    subst_asm_idents_text(text, &|t| resolve(t).map(|v| alloc::format!("{v}")))
}

/// Text-valued form of [`subst_asm_idents`]: the resolver yields the
/// replacement text (a register alias, a folded number).
pub(crate) fn subst_asm_idents_text(
    text: &str,
    resolve: &dyn Fn(&str) -> Option<alloc::string::String>,
) -> alloc::string::String {
    let b = text.as_bytes();
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let ident_start = |c: u8| ident(c) && c != b'$';
    let mut out = alloc::string::String::with_capacity(text.len());
    let mut i = 0;
    while i < b.len() {
        if ident_start(b[i]) {
            let start = i;
            while i < b.len() && ident(b[i]) {
                i += 1;
            }
            let tok = &text[start..i];
            match resolve(tok) {
                Some(v) => out.push_str(&v),
                None => out.push_str(tok),
            }
        } else {
            out.push(b[i] as char);
            i += 1;
        }
    }
    out
}

#[cfg(test)]
mod asm_comment_tests {
    use super::*;

    fn x86(t: &str) -> alloc::string::String {
        strip_asm_comments(t, AsmComments::X86).unwrap_or_else(|| t.into())
    }
    fn a64(t: &str) -> alloc::string::String {
        strip_asm_comments(t, AsmComments::A64).unwrap_or_else(|| t.into())
    }

    /// A template with no comment character is returned untouched.
    #[test]
    fn no_comment_chars_is_none() {
        assert!(strip_asm_comments("mov %rax, %rbx", AsmComments::X86).is_none());
        assert!(strip_asm_comments("mov x0, x1", AsmComments::A64).is_none());
    }

    /// Block comments are stripped on both targets, including multi-line and
    /// mid-instruction forms, and leave a separator behind.
    #[test]
    fn block_comments_stripped_on_both_targets() {
        assert_eq!(x86("mov %rax, %rbx /* tail */"), "mov %rax, %rbx  ");
        assert_eq!(a64("mov x0, x1 /* tail */"), "mov x0, x1  ");
        // Multi-line: the newline inside the comment does not separate.
        assert_eq!(x86("/* a\nb */ nop"), "  nop");
        // Mid-instruction: the surrounding tokens stay separate.
        assert_eq!(x86("mov %rax,/* c */%rbx"), "mov %rax, %rbx");
        // A `;` inside a block comment does not split a statement.
        assert_eq!(a64("mov x0, x1 /* a ; b */"), "mov x0, x1  ");
        // A block comment spanning a newline joins the statements around it,
        // which GNU as also does (and then rejects the run-on statement).
        assert_eq!(
            a64("mov x0, x1 /* a\nb */ mov x2, x3"),
            "mov x0, x1   mov x2, x3"
        );
    }

    /// x86-64 takes `#` as a line comment anywhere in the line; the comment
    /// swallows a following `;` because it runs to the newline.
    #[test]
    fn x86_hash_is_a_line_comment() {
        assert_eq!(x86("mov %rax, %rbx # trailing"), "mov %rax, %rbx ");
        assert_eq!(x86("nop # a ; nop\nnop"), "nop \nnop");
        assert_eq!(x86("# whole line\nnop"), "\nnop");
    }

    /// aarch64 takes `#` as the immediate prefix, not a comment, unless it
    /// opens a statement (template start, after a newline, or after a `;`).
    #[test]
    fn a64_hash_is_an_immediate_not_a_comment() {
        assert_eq!(a64("mov x0, #1"), "mov x0, #1");
        assert_eq!(
            a64("movz x3, #0x1234, lsl #16"),
            "movz x3, #0x1234, lsl #16"
        );
        // Statement-opening `#` comments to end of line, leading whitespace
        // included, and swallows a `;` after it.
        assert_eq!(a64("   # lead\nmov x0, #1"), "   \nmov x0, #1");
        assert_eq!(
            a64("mov x0, #1 ; # c ; mov x2, #3\nnop"),
            "mov x0, #1 ; \nnop"
        );
        // A label definition does not end the statement start, so a `#` after
        // one comments; after a directive operand it stays an immediate.
        assert_eq!(a64("1: # c\nmov x0, #1"), "1: \nmov x0, #1");
        assert_eq!(a64("lbl: # c\nmov x0, #1"), "lbl: \nmov x0, #1");
        assert_eq!(
            a64(".balign 4 # not a comment"),
            ".balign 4 # not a comment"
        );
    }

    /// `//` is a line comment on both targets: it is aarch64's comment
    /// character, and GNU as rejects it on x86-64 so no template relies on it.
    #[test]
    fn slash_slash_is_a_line_comment() {
        assert_eq!(a64("mov x0, x1 // tail"), "mov x0, x1 ");
        assert_eq!(x86("mov %rax, %rbx // tail"), "mov %rax, %rbx ");
        assert_eq!(a64("// whole\nmov x0, x1"), "\nmov x0, x1");
    }

    /// `;` separates statements on both targets and is never a comment.
    #[test]
    fn semicolon_is_a_separator_not_a_comment() {
        assert_eq!(x86("nop ; nop # c"), "nop ; nop ");
        assert_eq!(a64("mov x0, #1 ; mov x2, #3"), "mov x0, #1 ; mov x2, #3");
    }

    /// A comment character inside a string literal is data: GNU as keeps it,
    /// so a quoted section name or `.ascii` payload survives intact.
    #[test]
    fn comment_chars_inside_strings_are_kept() {
        assert_eq!(x86(".ascii \"a /* b\""), ".ascii \"a /* b\"");
        assert_eq!(x86(".section \"a#b\",\"a\" # c"), ".section \"a#b\",\"a\" ");
        assert_eq!(a64(".ascii \"x // y\""), ".ascii \"x // y\"");
        // An escaped quote does not end the literal.
        assert_eq!(x86(".ascii \"a\\\" /* b\""), ".ascii \"a\\\" /* b\"");
    }

    /// The condition-code output macro shape from the sweep: a block comment
    /// between two instructions of one template.
    #[test]
    fn block_comment_between_instructions() {
        let t = "btl %2,%1\n\t/* output condition code c*/\n\tsetc %[_cc_c]\n";
        assert_eq!(x86(t), "btl %2,%1\n\t \n\tsetc %[_cc_c]\n");
    }
}

#[cfg(test)]
mod asm_noop_tests {
    use super::*;
    use crate::c5::ir::{AsmBlock, AsmConstraint, AsmOperand, AsmSeg};

    fn block(template: &str, constraints: &[AsmConstraint]) -> AsmBlock {
        AsmBlock {
            template: template.as_bytes().to_vec(),
            operands: constraints
                .iter()
                .map(|&constraint| AsmOperand {
                    constraint,
                    is_output: false,
                    is_rw: false,
                    width: 8,
                    seg: AsmSeg::None,
                })
                .collect(),
            clobber_regs: 0x8,
            clobber_fp_regs: 0,
            clobber_memory: true,
            volatile: true,
        }
    }

    /// Templates that lower to nothing: empty, whitespace, statement
    /// separators, comments. Operands and clobbers do not change that.
    #[test]
    fn empty_forms_are_noop() {
        for t in ["", " \n\t", ";;\n", "/* note */", "// note", "# note"] {
            let b = block(t, &[AsmConstraint::Reg, AsmConstraint::Bound(5)]);
            assert!(asm_statement_is_noop(&b, AsmComments::X86), "x86 {t:?}");
            assert!(asm_statement_is_noop(&b, AsmComments::A64), "a64 {t:?}");
        }
    }

    /// Any remaining statement text keeps the full lowering, and a flag
    /// output materializes a `setcc` even with an empty template.
    #[test]
    fn content_and_flag_outputs_are_not_noop() {
        assert!(!asm_statement_is_noop(&block("nop", &[]), AsmComments::X86));
        // aarch64 `#` comments only open a statement; here it is an operand.
        assert!(!asm_statement_is_noop(
            &block("mov x0, #1", &[]),
            AsmComments::A64
        ));
        assert!(!asm_statement_is_noop(
            &block("", &[AsmConstraint::Flags(4)]),
            AsmComments::X86
        ));
    }
}

//! GNU as's Intel syntax (`.intel_syntax noprefix`), restated as the AT&T
//! syntax the x86-64 assembler reads: destination first, registers and
//! immediates bare, memory as `size ptr seg:[base + index*scale + disp]`,
//! `offset sym` for a symbol's address.

use alloc::collections::BTreeSet;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use crate::c5::asm::AsmError;
use crate::c5::asm::{peel_leading_label, split_asm_statement_lines, split_first_token};

/// `text` with the instructions `.intel_syntax` governs restated in AT&T
/// syntax and the syntax directives dropped, each statement on its line;
/// `None` when the text has no `.intel_syntax`. A statement that does not
/// restate is reported in `errors` and left out.
pub(crate) fn restate(text: &str, errors: &mut Vec<AsmError>) -> Option<String> {
    if !text.contains(".intel_syntax") {
        return None;
    }
    let consts = equated_names(text);
    let mut out = String::with_capacity(text.len() + text.len() / 4);
    let (mut intel, mut at) = (false, 1u32);
    for (line, piece) in split_asm_statement_lines(text) {
        if line == at && !out.is_empty() && !out.ends_with('\n') {
            out.push(';');
        }
        while at < line {
            out.push('\n');
            at += 1;
        }
        match statement(piece.trim(), &mut intel, &consts) {
            Ok(s) => out.push_str(&s),
            Err(e) => errors.push(AsmError::at(line, format!("inline asm: {e}"))),
        }
    }
    Some(out)
}

/// The names `.set`, `.equ` and `=` give a value, which an operand spells
/// as an immediate, as GNU as reads an absolute symbol.
fn equated_names(text: &str) -> BTreeSet<&str> {
    let mut names = BTreeSet::new();
    for (_, piece) in split_asm_statement_lines(text) {
        let piece = piece.trim();
        let (tok, rest) = split_first_token(piece);
        let name = match tok.to_ascii_lowercase().as_str() {
            ".set" | ".equ" => rest.split(',').next().map(str::trim),
            _ => piece.split_once('=').map(|(n, _)| n.trim()),
        };
        if let Some(n) = name.filter(|n| is_ident(n)) {
            names.insert(n);
        }
    }
    names
}

/// One statement: leading labels kept, a syntax directive applied, an
/// instruction restated when Intel syntax is in effect.
fn statement(piece: &str, intel: &mut bool, consts: &BTreeSet<&str>) -> Result<String, String> {
    let mut out = String::new();
    let mut stmt = piece;
    while let Some((name, rest)) = peel_leading_label(stmt) {
        out.push_str(name);
        out.push_str(": ");
        stmt = rest;
    }
    let (tok, rest) = split_first_token(stmt);
    match tok {
        ".intel_syntax" => {
            if !matches!(rest, "" | "noprefix" | "prefix") {
                return Err(format!(
                    "`.intel_syntax {rest}` takes `prefix` or `noprefix`"
                ));
            }
            *intel = true;
            return Ok(out);
        }
        ".att_syntax" => {
            if !matches!(rest, "" | "prefix") {
                return Err(format!("`.att_syntax {rest}` is not supported"));
            }
            *intel = false;
            return Ok(out);
        }
        _ => {}
    }
    if !*intel || stmt.is_empty() || tok.starts_with('.') {
        out.push_str(stmt);
        return Ok(out);
    }
    out.push_str(&instruction(stmt, consts)?);
    Ok(out)
}

/// The instruction prefixes GNU as takes as words before the mnemonic.
const PREFIXES: &[&str] = &[
    "lock", "rep", "repe", "repz", "repne", "repnz", "notrack", "bnd", "xacquire", "xrelease",
    "data16", "data32", "addr32",
];

/// An Intel-syntax operand.
#[derive(Debug)]
enum Op {
    Reg(String),
    Imm(String),
    /// A bare expression: a branch target, or else a memory reference.
    Expr(String),
    Mem {
        size: Option<u32>,
        seg: Option<String>,
        base: Option<String>,
        index: Option<(String, String)>,
        disp: String,
    },
    /// An AVX-512 rounding or exception operand, `{rn-sae}`, kept as written.
    Raw(String),
}

/// One instruction in AT&T syntax.
fn instruction(stmt: &str, consts: &BTreeSet<&str>) -> Result<String, String> {
    let mut words = Vec::new();
    let (mut tok, mut rest) = split_first_token(stmt);
    while PREFIXES.contains(&tok.to_ascii_lowercase().as_str()) && !rest.is_empty() {
        words.push(tok.to_ascii_lowercase());
        (tok, rest) = split_first_token(rest);
    }
    let mut mnem = tok.to_ascii_lowercase();
    let branch = is_branch(&mnem);
    let mut ops = Vec::new();
    let mut decors = Vec::new();
    for text in split_operands(rest) {
        let (text, decor) = split_decorations(text);
        ops.push(operand(text, branch, consts)?);
        decors.push(decor);
    }
    // AT&T names the x87 subtractions and divisions into `st(i)` by the
    // reversed operation (the AT&T convention): Intel's `fsub st(i), st`
    // is AT&T's `fsubr %st, %st(i)`, and so is the bare popping form.
    let into_sti = match ops.as_slice() {
        [Op::Reg(dst), _] => dst.starts_with("st(") && dst != "st(0)",
        [] => mnem.ends_with('p'),
        _ => false,
    };
    if into_sti && let Some(m) = super::x87::reversed(&mnem) {
        mnem = String::from(m);
    }
    // A memory operand's `ptr` size names the operation width where nothing
    // else does, as an AT&T suffix; the extending moves take both widths.
    let mem_size = ops.iter().find_map(|o| match o {
        Op::Mem { size, .. } => *size,
        _ => None,
    });
    match (mnem.as_str(), ops.as_slice(), mem_size) {
        ("movzx" | "movsx", [Op::Reg(dst), Op::Mem { .. }], Some(s @ (1 | 2))) => {
            let to = gpr_width(dst)
                .and_then(suffix)
                .ok_or("an extending move needs a register")?;
            mnem = format!("mov{}{}{to}", &mnem[3..4], suffix(s).unwrap_or('b'));
        }
        ("movsxd", [Op::Reg(dst), Op::Mem { .. }], _) if gpr_width(dst) == Some(8) => {
            mnem = String::from("movslq");
        }
        // An x87 memory operand's width is the mnemonic's suffix.
        (m, _, Some(s)) if !branch && let Some(x) = super::x87::suffix(m, s) => {
            mnem = format!("{m}{x}");
        }
        // A narrowing convert's xmm destination does not state its source's
        // width; AT&T syntax names it with `x` or `y`.
        (m, _, Some(s @ (16 | 32)))
            if super::asm::vex_narrowing(m).is_some_and(|n| n.2.is_none()) =>
        {
            mnem = format!("{m}{}", if s == 16 { 'x' } else { 'y' });
        }
        (m, _, Some(s)) if !branch && takes_size_letter(m, &ops, s) => {
            if let Some(letter) = suffix(s) {
                let sized = format!("{mnem}{letter}");
                if super::asm::accepts_size_suffix(&mnem, &sized) {
                    mnem = sized;
                }
            }
        }
        _ => {}
    }
    let mut att = Vec::new();
    for (op, decor) in ops.iter().zip(&decors).rev() {
        let mut s = render(op, branch);
        s.push_str(decor);
        att.push(s);
    }
    words.push(mnem);
    let mut line = words.join(" ");
    if !att.is_empty() {
        line.push(' ');
        line.push_str(&att.join(", "));
    }
    Ok(line)
}

/// The AT&T spelling of an operand; a branch's register or memory operand
/// is the indirect target.
fn render(op: &Op, branch: bool) -> String {
    let star = if branch { "*" } else { "" };
    match op {
        Op::Reg(r) => format!("{star}%{r}"),
        Op::Imm(e) => format!("${e}"),
        Op::Expr(e) => e.clone(),
        Op::Raw(r) => r.clone(),
        Op::Mem {
            seg,
            base,
            index,
            disp,
            ..
        } => {
            let mut s = String::from(star);
            if let Some(seg) = seg {
                s.push('%');
                s.push_str(seg);
                s.push(':');
            }
            s.push_str(disp);
            match (base, index) {
                (None, None) if disp.is_empty() => s.push('0'),
                (None, None) => {}
                (b, i) => {
                    s.push('(');
                    if let Some(b) = b {
                        s.push('%');
                        s.push_str(b);
                    }
                    if let Some((i, scale)) = i {
                        s.push_str(&format!(",%{i},{scale}"));
                    }
                    s.push(')');
                }
            }
            s
        }
    }
}

/// Branch and call mnemonics, whose bare operand is a target.
fn is_branch(m: &str) -> bool {
    matches!(
        m,
        "jmp"
            | "call"
            | "loop"
            | "loope"
            | "loopne"
            | "loopz"
            | "loopnz"
            | "jrcxz"
            | "jecxz"
            | "jcxz"
            | "xbegin"
    ) || super::emit::jcc_cond(m).is_some()
}

/// Whether the `ptr` width `bytes` belongs on `mnem` as an AT&T size letter,
/// which states the operation width: where no general register but a shift
/// count states it (`crc32` reads its source width from the letter), and on
/// a catalog instruction where it gives the memory operand that width. A
/// vector
/// instruction's memory width follows from its mnemonic or is a broadcast
/// element, but for the integer source of a convert.
fn takes_size_letter(mnem: &str, ops: &[Op], bytes: u32) -> bool {
    if ops.iter().any(is_vector) {
        return mnem.contains("cvtsi2") || mnem.contains("cvtusi2");
    }
    let stated = ops
        .iter()
        .any(|o| matches!(o, Op::Reg(r) if r != "cl" && gpr_width(r).is_some()));
    if mnem == "crc32" {
        return true;
    }
    if super::asm::catalog_mnemonic(mnem) {
        return !stated && super::table::memory_width_of(mnem, bytes);
    }
    !stated
        || ops.iter().all(
            |o| !matches!(o, Op::Reg(r) if r != "cl" && gpr_width(r).is_some_and(|w| w != bytes)),
        )
}

/// Whether an operand is a vector, mask or MMX register.
fn is_vector(op: &Op) -> bool {
    matches!(op, Op::Reg(r) if gpr_width(r).is_none() && (r.starts_with(['x', 'y', 'z', 'k']) || r.starts_with("mm")))
}

/// The AT&T size letter of a `ptr` width.
fn suffix(bytes: u32) -> Option<char> {
    match bytes {
        1 => Some('b'),
        2 => Some('w'),
        4 => Some('l'),
        8 => Some('q'),
        _ => None,
    }
}

/// The width of a general-purpose register named `r`.
fn gpr_width(r: &str) -> Option<u32> {
    use crate::c5::ir::AsmRegSize::*;
    match super::asm::reg_by_name(r)? {
        (n, size) if n < 16 => Some(match size {
            Byte => 1,
            Word => 2,
            Long => 4,
            Quad => 8,
        }),
        _ => None,
    }
}

/// Whether `name` names a register, `rip` included.
fn register(name: &str) -> Option<String> {
    let lower = name.trim_start_matches('%').to_ascii_lowercase();
    let mask = lower
        .strip_prefix('k')
        .is_some_and(|d| matches!(d, "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7"));
    let st = lower.replace(' ', "");
    (lower == "rip" || mask || super::asm::reg_by_name(&lower).is_some())
        .then_some(lower)
        .or_else(|| super::asm::reg_by_name(&st).map(|_| st))
}

/// The `ptr` widths.
fn ptr_size(word: &str) -> Option<u32> {
    Some(match word.to_ascii_lowercase().as_str() {
        "byte" => 1,
        "word" => 2,
        "dword" => 4,
        "fword" => 6,
        "qword" => 8,
        "tbyte" => 10,
        "oword" | "xmmword" => 16,
        "ymmword" => 32,
        "zmmword" => 64,
        _ => return None,
    })
}

/// An operand's text without its AVX-512 decorations (`{k1}`, `{z}`,
/// `{1to16}`), and the decorations in AT&T spelling.
fn split_decorations(text: &str) -> (&str, String) {
    let text = text.trim();
    if text.starts_with('{') {
        return (text, String::new());
    }
    let Some(open) = text.find('{') else {
        return (text, String::new());
    };
    let mut decor = String::new();
    for d in text[open..].split_inclusive('}') {
        let inner = d
            .trim()
            .trim_start_matches('{')
            .trim_end_matches('}')
            .trim();
        match register(inner) {
            Some(k) => decor.push_str(&format!("{{%{k}}}")),
            None => decor.push_str(&format!("{{{inner}}}")),
        }
    }
    (text[..open].trim_end(), decor)
}

/// One operand.
fn operand(text: &str, branch: bool, consts: &BTreeSet<&str>) -> Result<Op, String> {
    if text.starts_with('{') {
        return Ok(Op::Raw(String::from(text)));
    }
    let mut s = text.trim();
    // `short` and `near ptr` qualify a branch target; the encoder picks the
    // displacement itself.
    for q in ["short ", "near ptr ", "near "] {
        if starts_with_ci(s, q) {
            s = s[q.len()..].trim_start();
        }
    }
    let mut size = None;
    let (first, after) = split_first_token(s);
    if let Some(n) = ptr_size(first) {
        let after = after.trim_start();
        s = if starts_with_ci(after, "ptr") {
            after[3..].trim_start()
        } else {
            after
        };
        size = Some(n);
    }
    if starts_with_ci(s, "offset ") {
        let e = s[7..].trim();
        let e = e
            .strip_prefix("flat:")
            .or_else(|| e.strip_prefix("FLAT:"))
            .unwrap_or(e);
        return Ok(Op::Imm(expression(e)));
    }
    // A segment override: `fs:[rax]`, `fs:0x28`.
    let mut seg = None;
    if let Some((head, tail)) = s.split_once(':')
        && let Some(r) = register(head.trim())
        && matches!(r.as_str(), "es" | "cs" | "ss" | "ds" | "fs" | "gs")
    {
        seg = Some(r);
        s = tail.trim_start();
    }
    if let Some(open) = s.find('[') {
        let close = s
            .rfind(']')
            .ok_or_else(|| format!("unbalanced `[` in `{text}`"))?;
        let outside = format!("{}{}", s[..open].trim(), s[close + 1..].trim());
        let inner = s[open + 1..close].replace("][", "+");
        return memory(&inner, &outside, size, seg, text);
    }
    if let Some(r) = register(s) {
        if size.is_some() || seg.is_some() {
            return Err(format!("`{text}` sizes a register"));
        }
        return Ok(Op::Reg(r));
    }
    if size.is_some() || seg.is_some() {
        return Ok(Op::Mem {
            size,
            seg,
            base: None,
            index: None,
            disp: expression(s),
        });
    }
    if !branch && constant(s, consts) {
        return Ok(Op::Imm(expression(s)));
    }
    Ok(Op::Expr(expression(s)))
}

/// A memory operand from the terms inside its brackets and a displacement
/// written before them (`sym[rax]`).
fn memory(
    inner: &str,
    outside: &str,
    size: Option<u32>,
    seg: Option<String>,
    text: &str,
) -> Result<Op, String> {
    let (mut base, mut index) = (None, None);
    let mut disp = String::from(outside);
    for (neg, term) in terms(inner) {
        let term = term.trim();
        if let Some(r) = register(term) {
            if neg {
                return Err(format!("`{text}` subtracts a register"));
            }
            if base.is_none() {
                base = Some(r);
            } else if index.is_none() {
                index = Some((r, String::from("1")));
            } else {
                return Err(format!("`{text}` adds three registers"));
            }
            continue;
        }
        if let Some((a, b)) = term.split_once('*') {
            let (a, b) = (a.trim(), b.trim());
            let scaled = register(a)
                .map(|r| (r, b))
                .or_else(|| register(b).map(|r| (r, a)));
            if let Some((r, scale)) = scaled {
                if neg || index.is_some() {
                    return Err(format!("`{text}` has a second or negated index"));
                }
                index = Some((r, String::from(scale)));
                continue;
            }
        }
        let e = expression(term);
        if disp.is_empty() {
            disp = if neg { format!("-{e}") } else { e };
        } else {
            disp.push_str(if neg { "-" } else { "+" });
            disp.push_str(&e);
        }
    }
    Ok(Op::Mem {
        size,
        seg,
        base,
        index,
        disp,
    })
}

/// The `+`- and `-`-separated terms of a bracketed address, each with
/// whether it is subtracted; parentheses group.
fn terms(s: &str) -> Vec<(bool, &str)> {
    let mut out = Vec::new();
    let (mut depth, mut start, mut neg) = (0i32, 0usize, false);
    let b = s.as_bytes();
    for (i, &c) in b.iter().enumerate() {
        match c {
            b'(' => depth += 1,
            b')' => depth -= 1,
            b'+' | b'-' if depth == 0 => {
                let prev = s[..i].trim_end();
                // A sign after an operator or at the start is unary.
                if prev.is_empty() || prev.ends_with(['*', '+', '-', '(']) {
                    continue;
                }
                out.push((neg, &s[start..i]));
                neg = c == b'-';
                start = i + 1;
            }
            _ => {}
        }
    }
    out.push((neg, &s[start..]));
    out.retain(|(_, t)| !t.trim().is_empty());
    out
}

/// An expression with MASM's `0FFh` hexadecimal spelled as `0xFF`.
fn expression(e: &str) -> String {
    let mut out = String::with_capacity(e.len() + 2);
    let mut chars = e.char_indices().peekable();
    let mut prev_ident = false;
    while let Some((i, c)) = chars.next() {
        if c.is_ascii_digit() && !prev_ident {
            let end = e[i..]
                .find(|ch: char| !(ch.is_ascii_alphanumeric() || ch == '_'))
                .map_or(e.len(), |n| i + n);
            let word = &e[i..end];
            match word
                .strip_suffix(['h', 'H'])
                .filter(|d| d.bytes().all(|b| b.is_ascii_hexdigit()))
            {
                Some(digits) => out.push_str(&format!("0x{digits}")),
                None => out.push_str(word),
            }
            while chars.peek().is_some_and(|&(j, _)| j < end) {
                chars.next();
            }
            prev_ident = false;
            continue;
        }
        prev_ident = c.is_ascii_alphanumeric() || matches!(c, '_' | '.' | '$' | '@');
        out.push(c);
    }
    out
}

/// Whether an expression has no symbol but the names `.set` / `.equ` give a
/// value: an immediate operand.
fn constant(e: &str, consts: &BTreeSet<&str>) -> bool {
    // A character constant's letter is no symbol.
    let unquoted: String = e.split('\'').step_by(2).collect();
    let mut rest = unquoted.as_str();
    while let Some(i) = rest.find(|c: char| c.is_ascii_alphabetic() || matches!(c, '_' | '.' | '$'))
    {
        // The letters of a number (`0x1f`, `0FFh`) belong to it.
        let before = &rest[..i];
        let in_number = before
            .rfind(|c: char| !c.is_ascii_alphanumeric())
            .map_or(before, |p| &before[p + 1..])
            .starts_with(|c: char| c.is_ascii_digit());
        let end = rest[i..]
            .find(|c: char| !(c.is_ascii_alphanumeric() || matches!(c, '_' | '.' | '$' | '@')))
            .map_or(rest.len(), |n| i + n);
        if !in_number && !consts.contains(&rest[i..end]) {
            return false;
        }
        rest = &rest[end..];
    }
    !e.trim().is_empty()
}

fn is_ident(s: &str) -> bool {
    !s.is_empty()
        && !s.as_bytes()[0].is_ascii_digit()
        && s.bytes()
            .all(|b| b.is_ascii_alphanumeric() || matches!(b, b'_' | b'.' | b'$'))
}

fn starts_with_ci(s: &str, prefix: &str) -> bool {
    s.len() >= prefix.len() && s[..prefix.len()].eq_ignore_ascii_case(prefix)
}

/// The operands of an instruction, split at commas outside brackets,
/// braces, parentheses and quotes.
fn split_operands(rest: &str) -> Vec<&str> {
    let mut out = Vec::new();
    let (mut depth, mut start, mut quote) = (0i32, 0usize, None);
    for (i, c) in rest.char_indices() {
        if let Some(q) = quote {
            if c == q {
                quote = None;
            }
            continue;
        }
        match c {
            '\'' | '"' => quote = Some(c),
            '[' | '(' | '{' => depth += 1,
            ']' | ')' | '}' => depth -= 1,
            ',' if depth == 0 => {
                out.push(rest[start..i].trim());
                start = i + 1;
            }
            _ => {}
        }
    }
    let last = rest[start..].trim();
    if !last.is_empty() {
        out.push(last);
    }
    out
}

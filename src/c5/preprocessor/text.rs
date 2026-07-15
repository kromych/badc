use alloc::string::String;

/// Phase-3 comment removal: strip `/* ... */` block comments and
/// `// ...` line comments from the entire source. Each comment is
/// replaced by a single space so token boundaries are preserved
/// (`a/**/b` becomes `a b`, not `ab`). Newlines inside block
/// comments stay as `\n` so line numbers and `__LINE__` are
/// faithful to the original source. Quoted strings and char
/// literals are passed through unchanged so `"//"` doesn't get
/// misread as a line comment.
pub(super) fn strip_c_comments(source: &str) -> String {
    let mut out = String::with_capacity(source.len());
    let bytes = source.as_bytes();
    let mut i = 0;
    while i < bytes.len() {
        let c = bytes[i];
        if c == b'/' && bytes.get(i + 1) == Some(&b'*') {
            // Block comment.
            i += 2;
            while i + 1 < bytes.len() {
                if bytes[i] == b'*' && bytes[i + 1] == b'/' {
                    i += 2;
                    break;
                }
                if bytes[i] == b'\n' {
                    out.push('\n');
                }
                i += 1;
            }
            out.push(' ');
            continue;
        }
        if c == b'/' && bytes.get(i + 1) == Some(&b'/') {
            // Line comment -- skip to next newline (don't consume it).
            i += 2;
            while i < bytes.len() && bytes[i] != b'\n' {
                i += 1;
            }
            out.push(' ');
            continue;
        }
        if c == b'"' || c == b'\'' {
            // Pass-through quoted literal so `"//"` etc. survive.
            // Copy the byte range as a UTF-8 slice so a multibyte
            // sequence is not re-encoded byte by byte.
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
            continue;
        }
        out.push(c as char);
        i += 1;
    }
    out
}

/// Report whether `s` (a partially assembled logical line with its
/// newlines already removed) ends inside an unterminated `/* */` block
/// comment. String and character literals and `//` line comments are
/// tracked so a `/*` appearing inside one of them does not count as a
/// comment opener.
pub(super) fn ends_in_open_block_comment(s: &str) -> bool {
    let b = s.as_bytes();
    let mut i = 0;
    let mut in_str = false;
    let mut in_char = false;
    let mut in_block = false;
    while i < b.len() {
        let c = b[i];
        if in_block {
            if c == b'*' && b.get(i + 1) == Some(&b'/') {
                in_block = false;
                i += 2;
                continue;
            }
            i += 1;
            continue;
        }
        if in_str {
            if c == b'\\' {
                i += 2;
                continue;
            }
            if c == b'"' {
                in_str = false;
            }
            i += 1;
            continue;
        }
        if in_char {
            if c == b'\\' {
                i += 2;
                continue;
            }
            if c == b'\'' {
                in_char = false;
            }
            i += 1;
            continue;
        }
        if c == b'/' && b.get(i + 1) == Some(&b'*') {
            in_block = true;
            i += 2;
            continue;
        }
        if c == b'/' && b.get(i + 1) == Some(&b'/') {
            // A line comment runs to the end of the assembled line, so
            // nothing after it can leave a block comment open.
            return false;
        }
        if c == b'"' {
            in_str = true;
        } else if c == b'\'' {
            in_char = true;
        }
        i += 1;
    }
    in_block
}

/// Phase-2 line-continuation collapse: every line ending in `\\`
/// joins with the next, preserving total line count by emitting
/// blank padding lines. The c99 spec runs this before all other
/// preprocessing passes.
///
/// A physical line whose logical line ends inside an open `/* */`
/// block comment also joins with the next line even without a trailing
/// `\\`: a newline inside a block comment is comment white space, not a
/// directive terminator (C99 5.1.1.2), so a multi-line comment embedded
/// in a `\\`-continued macro definition must not split the definition.
pub(super) fn unfold_line_continuations(source: &str) -> String {
    let mut out = String::with_capacity(source.len());
    let mut iter = source.lines().peekable();
    while let Some(line) = iter.next() {
        let mut joined = line.to_string();
        let mut padding = 0;
        loop {
            if joined.ends_with('\\') {
                joined.pop();
            } else if !ends_in_open_block_comment(&joined) {
                break;
            }
            padding += 1;
            match iter.next() {
                Some(next) => joined.push_str(next),
                None => break,
            }
        }
        out.push_str(&joined);
        out.push('\n');
        for _ in 0..padding {
            out.push('\n');
        }
    }
    out
}

/// Identifier check: ASCII letter or `_` to start, alnum or `_`
/// after. Used to reject `#pragma dylib(123foo, ...)` and similar
/// up-front so the codegen never has to worry about quirks in the
/// dylib `name`.
/// If `bytes[at..]` begins with a string- or char-literal encoding
/// prefix (`L`, `u`, `U`, or `u8`) immediately followed by a `"` or
/// `'` quote, return the prefix length (1 or 2). The quote itself is
/// not included. C99 6.4.5 (string literals) and 6.4.4.4 (character
/// constants) make the prefix part of the literal token; the
/// preprocessor must not treat it as an identifier.
pub(super) fn literal_prefix_len(bytes: &[u8], at: usize) -> Option<usize> {
    let c = *bytes.get(at)?;
    let quote = |b: u8| b == b'"' || b == b'\'';
    match c {
        b'L' | b'U' if bytes.get(at + 1).is_some_and(|&n| quote(n)) => Some(1),
        b'u' => {
            if bytes.get(at + 1) == Some(&b'8') && bytes.get(at + 2).is_some_and(|&n| n == b'"') {
                Some(2)
            } else if bytes.get(at + 1).is_some_and(|&n| quote(n)) {
                Some(1)
            } else {
                None
            }
        }
        _ => None,
    }
}

pub(super) fn is_ident(s: &str) -> bool {
    let mut bytes = s.bytes();
    let Some(first) = bytes.next() else {
        return false;
    };
    if !(first.is_ascii_alphabetic() || first == b'_') {
        return false;
    }
    bytes.all(|b| b.is_ascii_alphanumeric() || b == b'_')
}

pub(super) fn is_ident_byte(b: u8) -> bool {
    b.is_ascii_alphanumeric() || b == b'_'
}

/// Length of the C99 6.4.8 preprocessing number starting at `at` (a
/// digit, or `.` followed by a digit), else 0. A pp-number is one
/// token, so the substitution scanners must treat text like `2op`
/// opaquely: its identifier-shaped tail is not a candidate macro or
/// parameter name.
pub(super) fn pp_number_len(bytes: &[u8], at: usize) -> usize {
    let n = bytes.len();
    let starts = bytes[at].is_ascii_digit()
        || (bytes[at] == b'.' && at + 1 < n && bytes[at + 1].is_ascii_digit());
    if !starts {
        return 0;
    }
    let mut i = at + 1;
    while i < n {
        let b = bytes[i];
        if matches!(b, b'e' | b'E' | b'p' | b'P')
            && i + 1 < n
            && matches!(bytes[i + 1], b'+' | b'-')
        {
            i += 2;
        } else if is_ident_byte(b) || b == b'.' {
            i += 1;
        } else {
            break;
        }
    }
    i - at
}

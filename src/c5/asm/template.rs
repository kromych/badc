//! Extended inline-asm templates: the operand-reference forms a
//! template writes, the `%=` instance counter, and the raw-byte
//! directives a template may carry in place of mnemonics.

use super::*;
use crate::c5::codegen::map_syms::MapClass;

/// How a target prints an `i`-class operand reference that appears inside a
/// branch-target symbol name. A reference only spells part of a name when it
/// prints as bare text; a `$`-prefixed form cannot.
pub(crate) struct AsmSymbolSubst {
    /// Modifier letters that print the operand bare. x86 accepts `%c` and
    /// `%P`; AArch64 accepts `%c`, and gives `%P` an unrelated meaning.
    pub(crate) bare_modifiers: &'static [u8],
    /// Whether an unmodified `%N` prints bare. It does on AArch64; x86 prints
    /// `$N`.
    pub(crate) plain_is_bare: bool,
}

pub(crate) const X64_SYMBOL_SUBST: AsmSymbolSubst = AsmSymbolSubst {
    bare_modifiers: b"cP",
    plain_is_bare: false,
};

pub(crate) const A64_SYMBOL_SUBST: AsmSymbolSubst = AsmSymbolSubst {
    bare_modifiers: b"c",
    plain_is_bare: true,
};

/// Split a `%`-reference at the start of `s` into `(modifier, index, rest)`.
/// A modifier is a single letter; the index is the digits that follow.
fn split_operand_ref(s: &str) -> Option<(Option<u8>, u8, &str)> {
    let b = s.as_bytes();
    let mut i = 0;
    let modifier = match b.first() {
        Some(&c) if c.is_ascii_alphabetic() => {
            i = 1;
            Some(c)
        }
        _ => None,
    };
    let start = i;
    while i < b.len() && b[i].is_ascii_digit() {
        i += 1;
    }
    if i == start {
        return None;
    }
    let idx: u8 = s[start..i].parse().ok()?;
    Some((modifier, idx, &s[i..]))
}

/// True when `s` can spell a branch-target symbol name: an identifier body
/// that may embed operand references (`__get_user_%c0`). The leading
/// identifier character keeps a whole-operand target (`*%rax`, `%c0`) out.
/// Whether each reference is substitutable is settled at emit time, once the
/// operands' constants are known.
pub(crate) fn is_asm_symbol_template(s: &str) -> bool {
    // GNU as symbol names take letters, digits, `_` and `.`; the first
    // character must not be a digit. A name of dots alone is the
    // location counter (`.`), not a symbol.
    let sym_char = |c: u8| c.is_ascii_alphanumeric() || c == b'_' || c == b'.';
    if !s
        .bytes()
        .next()
        .is_some_and(|c| c.is_ascii_alphabetic() || c == b'_' || c == b'.')
        || s.bytes().all(|c| c == b'.')
    {
        return false;
    }
    let mut rest = s;
    while let Some(p) = rest.find('%') {
        if !rest[..p].bytes().all(sym_char) {
            return false;
        }
        match split_operand_ref(&rest[p + 1..]) {
            Some((_, _, tail)) => rest = tail,
            None => return false,
        }
    }
    rest.bytes().all(sym_char)
}

/// True when `s` can spell a branch-target expression: a location
/// expression whose first character starts a symbol name, which keeps the
/// operand forms (`*%rax`, `$1`, `(%rax)`, a numeric label) out. An operand
/// reference is not part of the expression grammar, so a target embedding
/// one is a name and takes [`is_asm_symbol_template`]. Every leaf resolves
/// here: this tests the grammar, not the layout.
pub(crate) fn is_asm_branch_expr(s: &str) -> bool {
    let s = s.trim();
    if !s
        .bytes()
        .next()
        .is_some_and(|c| c.is_ascii_alphabetic() || c == b'_' || c == b'.')
    {
        return false;
    }
    let ctx = AsmExprCtx {
        resolve: &|_| Some(AsmExprLeaf::Abs(1)),
        const_of: &|_| Some(1),
        lax_div: true,
    };
    eval_asm_value(s, &ctx).is_ok()
}

/// Substitute the operand references in a branch-target symbol name, so the
/// target is resolved from the text the template spells after substitution.
/// `const_of` yields an `i`-class operand's constant.
pub(crate) fn resolve_asm_symbol_target(
    template: &str,
    subst: &AsmSymbolSubst,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<alloc::string::String, alloc::string::String> {
    let mut out = alloc::string::String::with_capacity(template.len());
    let mut rest = template;
    while let Some(p) = rest.find('%') {
        out.push_str(&rest[..p]);
        let Some((modifier, idx, tail)) = split_operand_ref(&rest[p + 1..]) else {
            return Err(alloc::format!(
                "inline asm: bad operand reference in branch target `{template}`"
            ));
        };
        match modifier {
            Some(m) if subst.bare_modifiers.contains(&m) => {}
            None if subst.plain_is_bare => {}
            _ => {
                return Err(alloc::format!(
                    "inline asm: operand reference in branch target `{template}` \
                     does not print a bare symbol name; use `%c`"
                ));
            }
        }
        let Some(v) = const_of(idx) else {
            return Err(alloc::format!(
                "inline asm: branch target `{template}` needs a constant operand"
            ));
        };
        out.push_str(&alloc::format!("{v}"));
        rest = tail;
    }
    out.push_str(rest);
    Ok(out)
}

/// Expand every `%z<N>` reference to the operand-size suffix of operand N,
/// the letter GCC prints into a mnemonic (`shr%z1` on a 32-bit operand is
/// `shrl`). `suffix_of` yields the suffix for an operand's width, `None`
/// when the width has no suffix. Returns `None` when the template carries
/// no such reference.
pub(crate) fn expand_size_suffix_refs(
    text: &str,
    suffix_of: &dyn Fn(u8) -> Option<&'static str>,
) -> Result<Option<alloc::string::String>, alloc::string::String> {
    if !text.contains("%z") {
        return Ok(None);
    }
    let mut out = alloc::string::String::with_capacity(text.len());
    let mut rest = text;
    while let Some(p) = rest.find('%') {
        out.push_str(&rest[..p]);
        let after = &rest[p + 1..];
        if let Some(r) = after.strip_prefix('%') {
            out.push_str("%%");
            rest = r;
            continue;
        }
        match split_operand_ref(after) {
            Some((Some(b'z'), idx, tail)) => {
                let Some(suffix) = suffix_of(idx) else {
                    return Err(alloc::format!(
                        "inline asm: `%z{idx}` names no operand with an operand-size suffix"
                    ));
                };
                out.push_str(suffix);
                rest = tail;
            }
            _ => {
                out.push('%');
                rest = after;
            }
        }
    }
    out.push_str(rest);
    Ok(Some(out))
}

// Numbering behind the `%=` template escape and the two asm-label
// uniquifiers. `reset_asm_instance` restarts it at the head of every
// lowering, so the names an object carries are a function of the program
// rather than of how much the process emitted before it; GNU likewise
// documents `%=` as unique per asm instance in one compilation. The labels
// are `STB_LOCAL` and separately compiled objects already number from
// zero, so restarting adds no collision the link does not handle.
// Thread-local under `std`: lowerings run concurrently under the test
// harness and must not share a sequence a peer can reset.
#[cfg(feature = "std")]
std::thread_local! {
    static ASM_INSTANCE: core::cell::Cell<u32> = const { core::cell::Cell::new(0) };
}

/// Next value of the per-lowering asm-instance sequence.
#[cfg(feature = "std")]
pub(crate) fn next_asm_instance() -> u32 {
    ASM_INSTANCE.with(|c| {
        let v = c.get();
        c.set(v.wrapping_add(1));
        v
    })
}

/// Restart the asm-instance sequence. Called once per lowering.
#[cfg(feature = "std")]
pub(crate) fn reset_asm_instance() {
    ASM_INSTANCE.with(|c| c.set(0));
}

/// no_std has no thread-local storage; the sequence is a plain atomic.
#[cfg(not(feature = "std"))]
static ASM_INSTANCE: core::sync::atomic::AtomicU32 = core::sync::atomic::AtomicU32::new(0);

#[cfg(not(feature = "std"))]
pub(crate) fn next_asm_instance() -> u32 {
    ASM_INSTANCE.fetch_add(1, core::sync::atomic::Ordering::Relaxed)
}

#[cfg(not(feature = "std"))]
pub(crate) fn reset_asm_instance() {
    ASM_INSTANCE.store(0, core::sync::atomic::Ordering::Relaxed);
}

/// Expand the `%=` template escape: every occurrence in one template gets the
/// same number, unique per expansion (GCC gives each asm instance its own).
/// `%%` is the literal-percent escape, so its trailing `%` never starts a
/// `%=`. Returns `None` when the template has no `%=` (the common case).
pub(crate) fn expand_template_uniq(text: &str) -> Option<alloc::string::String> {
    if !text.contains("%=") {
        return None;
    }
    let uniq = next_asm_instance();
    let mut out = alloc::string::String::with_capacity(text.len() + 8);
    let mut it = text.chars().peekable();
    while let Some(c) = it.next() {
        if c != '%' {
            out.push(c);
            continue;
        }
        match it.peek() {
            Some('%') => {
                out.push_str("%%");
                it.next();
            }
            Some('=') => {
                out.push_str(&alloc::format!("{uniq}"));
                it.next();
            }
            _ => out.push('%'),
        }
    }
    Some(out)
}

/// Parse an inline-asm template whose every piece is raw machine bytes,
/// returning the concatenated little-endian bytes, or `None` when any piece is
/// a mnemonic the caller must encode itself. A piece is raw bytes when it is a
/// run of 2-hex-digit tokens (`CC C3 90`) or a `.byte` / `.word` / `.long` /
/// `.quad` directive of integer constants. Arch-neutral so both backends emit
/// raw-byte asm identically.
pub(crate) fn parse_raw_template(template: &[u8]) -> Option<alloc::vec::Vec<u8>> {
    let text = core::str::from_utf8(template).ok()?;
    let mut out = alloc::vec::Vec::new();
    let mut any = false;
    for piece in split_asm_statements(text) {
        let piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        any = true;
        out.extend_from_slice(&parse_raw_piece(piece)?);
    }
    any.then_some(out)
}

/// Byte list `.inst` expands to. GNU as assembles `.inst` into
/// instructions, so the bytes carry the code class a `.byte` list does not;
/// the name is internal and cannot collide with a source directive.
pub(crate) const INST_BYTES_DIRECTIVE: &str = ".c5_inst_bytes";

/// Element width of a `.byte`-family data directive keyword, or `None`.
pub(crate) fn data_directive_width(tok: &str) -> Option<usize> {
    Some(match tok {
        ".byte" | INST_BYTES_DIRECTIVE => 1,
        ".word" | ".2byte" | ".short" | ".hword" => 2,
        ".long" | ".4byte" | ".int" => 4,
        ".quad" | ".8byte" => 8,
        ".octa" => 16,
        _ => return None,
    })
}

/// The mapping class a `.byte`-family directive keyword lays down, or
/// `None` when the keyword is not one. This is the keyword-level form of
/// the rule [`step_map_state`] applies to a parsed section item: `.inst`
/// assembles to instructions, every other data directive to data.
pub(crate) fn data_directive_class(tok: &str) -> Option<MapClass> {
    data_directive_width(tok).map(|_| {
        if tok == INST_BYTES_DIRECTIVE {
            MapClass::Code
        } else {
            MapClass::Data
        }
    })
}

fn parse_raw_piece(piece: &str) -> Option<alloc::vec::Vec<u8>> {
    let width = data_directive_width(piece.split_whitespace().next()?);
    if let Some(w) = width {
        let args = piece[piece.find(char::is_whitespace)?..].trim();
        let mut out = alloc::vec::Vec::new();
        for a in args.split(',') {
            push_le(&mut out, eval_const_expr_wide(a.trim())?, w);
        }
        return Some(out);
    }
    // Bare hex-byte run: every whitespace-delimited token is exactly two hex
    // digits, so a mnemonic (letters) is never mistaken for one.
    let toks: alloc::vec::Vec<&str> = piece.split_whitespace().collect();
    (!toks.is_empty()
        && toks
            .iter()
            .all(|t| t.len() == 2 && t.bytes().all(|b| b.is_ascii_hexdigit())))
    .then(|| {
        toks.iter()
            .map(|t| u8::from_str_radix(t, 16).unwrap())
            .collect()
    })
}

pub(crate) fn parse_raw_int(s: &str) -> Option<i64> {
    eval_const_expr(s)
}

#[cfg(test)]
mod size_suffix_tests {
    use super::expand_size_suffix_refs;

    fn x86_suffix(idx: u8) -> Option<&'static str> {
        [Some("b"), Some("w"), Some("l"), Some("q"), None]
            .get(idx as usize)
            .copied()
            .flatten()
    }

    #[test]
    fn size_suffix_references_expand_to_the_operand_letter() {
        let expanded = expand_size_suffix_refs("shr%z2 %2\n\tadd%z0 $1, %0", &x86_suffix)
            .unwrap()
            .unwrap();
        assert_eq!(expanded, "shrl %2\n\taddb $1, %0");
        // `%%` is the literal-percent escape: a `zmm` register keeps its name,
        // and other references are left to the parser.
        let text = "vmovdqa64 %%zmm0, (%1); mov %k1, %w3";
        assert_eq!(
            expand_size_suffix_refs(text, &x86_suffix)
                .unwrap()
                .as_deref(),
            Some(text)
        );
        assert!(
            expand_size_suffix_refs("shr %0", &x86_suffix)
                .unwrap()
                .is_none()
        );
    }

    #[test]
    fn size_suffix_reference_without_a_suffix_is_diagnosed() {
        // Operand 4 has no suffix (a 16-byte operand), operand 9 does not exist.
        for text in ["shr%z4 %4", "shr%z9 %0"] {
            let err = expand_size_suffix_refs(text, &x86_suffix).unwrap_err();
            assert!(
                err.contains("names no operand with an operand-size suffix"),
                "{err}"
            );
        }
    }
}

#[cfg(test)]
mod raw_template_tests {
    use super::parse_raw_template;

    #[test]
    fn bare_hex_and_directives() {
        // Bare hex-byte run (`;` / whitespace separated), read as hex.
        assert_eq!(
            parse_raw_template(b"CC; C3; 90").unwrap(),
            [0xCC, 0xC3, 0x90]
        );
        assert_eq!(
            parse_raw_template(b"1f 20 03 d5").unwrap(),
            [0x1f, 0x20, 0x03, 0xd5]
        );
        // `.byte` / `.word` / `.long` / `.quad`, little-endian at width.
        assert_eq!(
            parse_raw_template(b".byte 0x1f, 0x20, 0x03, 0xd5").unwrap(),
            [0x1f, 0x20, 0x03, 0xd5]
        );
        assert_eq!(parse_raw_template(b".word 0x1234").unwrap(), [0x34, 0x12]);
        assert_eq!(parse_raw_template(b".byte 144").unwrap(), [0x90]);
        // Mixed directive + hex-run pieces concatenate.
        assert_eq!(parse_raw_template(b".byte 0x90; 90").unwrap(), [0x90, 0x90]);
    }

    #[test]
    fn rejects_mnemonics_and_empty() {
        // A piece that is a mnemonic (letters) is not a raw-byte template.
        assert!(parse_raw_template(b"nop").is_none());
        assert!(parse_raw_template(b".byte 0x90; add %rax, %rbx").is_none());
        // An empty template carries no bytes.
        assert!(parse_raw_template(b"").is_none());
        assert!(parse_raw_template(b"   ").is_none());
    }
}

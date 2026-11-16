//! Mach-O spells the C identifier `f` as the symbol `_f`; badc's names carry
//! the C spelling. A Mach-O symbol without the underscore (an asm label
//! `"x"`, a label `x:`) leads with [`RAW`]. The Mach-O writer and readers and
//! assembly's output convert; ELF and PE names are the symbols as written.

use alloc::borrow::Cow;

/// Leads the name of a Mach-O symbol written without the C underscore.
pub(crate) const RAW: char = '\u{1}';

/// How Mach-O spells the symbol `name`.
pub(crate) fn spelling(name: &str) -> Cow<'_, str> {
    match name.strip_prefix(RAW) {
        Some(raw) => Cow::Borrowed(raw),
        None => Cow::Owned(alloc::format!("_{name}")),
    }
}

/// badc's name for the Mach-O symbol `sym`.
pub fn name(sym: &str) -> Cow<'_, str> {
    match sym.strip_prefix('_') {
        Some(c_name) => Cow::Borrowed(c_name),
        None if sym.is_empty() => Cow::Borrowed(sym),
        None => Cow::Owned(alloc::format!("{RAW}{sym}")),
    }
}

/// `text` without the marker, which leaves a raw name as the file spells it.
pub(crate) fn shown(text: &str) -> Cow<'_, str> {
    match text.contains(RAW) {
        true => Cow::Owned(text.replace(RAW, "")),
        false => Cow::Borrowed(text),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_name_round_trips_through_its_mach_o_spelling() {
        for (sym, internal) in [
            ("_f", "f"),
            ("__f", "_f"),
            ("other", "\u{1}other"),
            ("", ""),
        ] {
            assert_eq!(name(sym), internal);
            if !sym.is_empty() {
                assert_eq!(spelling(internal), sym);
            }
        }
        assert_eq!(shown("undefined `\u{1}other`"), "undefined `other`");
    }
}

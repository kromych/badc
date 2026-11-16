//! MSVC's segment pragmas: `code_seg`, `data_seg`, `const_seg` and `bss_seg`
//! name the section the definitions of each kind after them take, with
//! `push` / `pop` frames; `alloc_text` names one for listed functions.

use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;

/// The kind of definition a segment pragma places.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum SegKind {
    Code,
    Data,
    Const,
    Bss,
}

impl SegKind {
    fn of(pragma: &str) -> Option<Self> {
        Some(match pragma {
            "code_seg" => SegKind::Code,
            "data_seg" => SegKind::Data,
            "const_seg" => SegKind::Const,
            "bss_seg" => SegKind::Bss,
            _ => return None,
        })
    }
}

/// The sections in effect at a source position.
#[derive(Default, Debug, Clone)]
pub(crate) struct Segments {
    current: [Option<String>; 4],
    /// Each kind's `push` frames, innermost last: the label and the section
    /// it saved.
    saved: [Vec<(Option<String>, Option<String>)>; 4],
    alloc_text: BTreeMap<String, String>,
}

/// A pragma's operands, split at the commas outside string literals.
fn operands(inner: &str) -> Vec<&str> {
    let mut out = Vec::new();
    let (mut start, mut quoted) = (0, false);
    for (i, c) in inner.char_indices() {
        match c {
            '"' => quoted = !quoted,
            ',' if !quoted => {
                out.push(inner[start..i].trim());
                start = i + 1;
            }
            _ => {}
        }
    }
    let last = inner[start..].trim();
    if !last.is_empty() || !out.is_empty() {
        out.push(last);
    }
    out
}

fn literal(operand: &str) -> Option<&str> {
    operand.strip_prefix('"')?.strip_suffix('"')
}

/// Whether `pragma` (the text after `#pragma`) is one of these.
pub(crate) fn is_segment_pragma(pragma: &str) -> bool {
    let s = pragma.trim_start();
    let name = s
        .split(|c: char| c == '(' || c.is_whitespace())
        .next()
        .unwrap_or("");
    (SegKind::of(name).is_some() || name == "alloc_text")
        && s[name.len()..].trim_start().starts_with('(')
}

impl Segments {
    /// The section a definition of `kind` takes here.
    pub(crate) fn section(&self, kind: SegKind) -> Option<&str> {
        self.current[kind as usize].as_deref()
    }

    /// The section `#pragma alloc_text` names for `function`.
    pub(crate) fn alloc_text(&self, function: &str) -> Option<&str> {
        self.alloc_text.get(function).map(String::as_str)
    }

    /// Apply a `pragma ...` line (the `#` stripped); false for any other.
    pub(crate) fn apply_line(&mut self, line: &str) -> bool {
        let Some(pragma) = line.trim().strip_prefix("pragma") else {
            return false;
        };
        if !is_segment_pragma(pragma) {
            return false;
        }
        let pragma = pragma.trim();
        let (Some(open), Some(close)) = (pragma.find('('), pragma.rfind(')')) else {
            return false;
        };
        let name = pragma[..open].trim();
        let args = operands(&pragma[open + 1..close]);
        let Some(kind) = SegKind::of(name) else {
            // `alloc_text("section", f, g, ...)`.
            if let Some(section) = args.first().and_then(|a| literal(a)) {
                for f in &args[1..] {
                    self.alloc_text
                        .insert(String::from(*f), String::from(section));
                }
            }
            return true;
        };
        let k = kind as usize;
        let named = args
            .iter()
            .skip(1)
            .find_map(|a| literal(a))
            .map(String::from);
        let label = (args.get(1))
            .filter(|a| literal(a).is_none())
            .map(|a| String::from(*a));
        match args.first().copied() {
            None => self.current[k] = None,
            Some("push") => {
                self.saved[k].push((label, self.current[k].clone()));
                if named.is_some() {
                    self.current[k] = named;
                }
            }
            Some("pop") => {
                let at = match &label {
                    Some(l) => self.saved[k]
                        .iter()
                        .rposition(|(s, _)| s.as_ref() == Some(l)),
                    None => self.saved[k].len().checked_sub(1),
                };
                if let Some(at) = at {
                    self.current[k] = self.saved[k][at].1.take();
                    self.saved[k].truncate(at);
                }
                if named.is_some() {
                    self.current[k] = named;
                }
            }
            Some(first) => self.current[k] = literal(first).map(String::from),
        }
        true
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn pragmas_set_push_and_pop_each_kind() {
        let mut s = Segments::default();
        assert!(s.apply_line("pragma data_seg(\"A\")"));
        assert!(s.apply_line("pragma data_seg(push, outer, \"B\")"));
        assert!(s.apply_line("pragma data_seg(push, \"C\")"));
        assert_eq!(s.section(SegKind::Data), Some("C"));
        assert!(s.apply_line("pragma data_seg(pop, outer)"));
        assert_eq!(s.section(SegKind::Data), Some("A"));
        assert!(s.apply_line("pragma data_seg()"));
        assert_eq!(s.section(SegKind::Data), None);
        assert!(s.apply_line("pragma code_seg(\"PAGE\")"));
        assert_eq!(s.section(SegKind::Code), Some("PAGE"));
        assert_eq!(s.section(SegKind::Bss), None);
        assert!(s.apply_line("pragma alloc_text(\"INIT\", f, g)"));
        assert_eq!(s.alloc_text("g"), Some("INIT"));
        assert!(!s.apply_line("pragma pack(1)"));
    }
}

//! GNU make dependency-file rendering for the `-M` flag family.
//!
//! The output is make syntax: one rule whose targets name the object and
//! whose prerequisites are the translation unit's source and every header
//! it opened, wrapped at 72 columns with ` \` line continuations,
//! optionally followed by a phony target per prerequisite (`-MP`). `make`
//! reads it, and so does the Linux kernel's `scripts/basic/fixdep`.
//!
//! It follows gcc's writer: the same files, in the same order, with the
//! same escaping and the same wrap points. It is not byte-for-byte
//! identical, and deliberately so -- gcc repeats a prerequisite reached
//! twice, and this emits each once. The rules are equivalent to `make`,
//! which stats each prerequisite either way.

use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::preprocessor::{IncludeOrigin, IncludeRecord, IncludeStatus};

/// Column past which a further name starts a continuation line. gcc's
/// dependency writer uses the same bound, so the wrap points agree.
const MAX_OUTPUT_WIDTH: usize = 72;

/// Escape one name for a make target or prerequisite position.
///
/// `make` splits rules on unescaped whitespace, starts a comment at an
/// unescaped `#`, and expands `$`. gcc's dependency writer escapes
/// exactly those: a space or tab takes a leading backslash, `#` takes a
/// leading backslash, and `$` doubles. A backslash run is doubled only
/// when it immediately precedes whitespace, which is where `make`
/// applies its own backslash counting; elsewhere it stands (a Windows
/// path separator must not be mangled). `:` is left alone, matching gcc
/// -- escaping it would break drive letters, and `make` accepts the
/// bare form in a prerequisite list.
pub fn escape(name: &str) -> String {
    let bytes = name.as_bytes();
    let mut out = String::with_capacity(name.len());
    // Everything between two escapes is copied as a slice: each byte
    // this matches is single-byte ASCII, so the cut points are always
    // character boundaries and a multi-byte path survives intact.
    let mut start = 0;
    for (i, &c) in bytes.iter().enumerate() {
        let replacement = match c {
            b'\\' => {
                // Only a backslash run that ends at whitespace is
                // doubled; elsewhere the byte stands.
                let mut end = i;
                while end < bytes.len() && bytes[end] == b'\\' {
                    end += 1;
                }
                match bytes.get(end) {
                    Some(b' ' | b'\t') => "\\\\",
                    _ => continue,
                }
            }
            b' ' => "\\ ",
            b'\t' => "\\\t",
            b'#' => "\\#",
            b'$' => "$$",
            _ => continue,
        };
        out.push_str(&name[start..i]);
        out.push_str(replacement);
        start = i + 1;
    }
    out.push_str(&name[start..]);
    out
}

/// Accumulates names onto wrapped lines the way gcc's writer does: a
/// name that would carry the line past `MAX_OUTPUT_WIDTH` starts a
/// continuation, except when the line holds nothing but the one-space
/// indent, so a name longer than the bound sits alone rather than being
/// split.
struct Wrapper {
    out: String,
    column: usize,
}

impl Wrapper {
    fn new() -> Self {
        Wrapper {
            out: String::new(),
            column: 0,
        }
    }

    fn push(&mut self, item: &str) {
        if self.column > 1 && self.column + item.len() > MAX_OUTPUT_WIDTH {
            self.out.push_str(" \\\n ");
            self.column = 1;
        } else if self.column > 0 {
            self.out.push(' ');
            self.column += 1;
        }
        self.out.push_str(item);
        self.column += item.len();
    }

    fn push_raw(&mut self, s: &str) {
        self.out.push_str(s);
        self.column += s.len();
    }
}

/// Render the dependency rule.
///
/// `targets` are already in their final spelling: `-MT` supplies a name
/// verbatim, `-MQ` supplies one that has been through [`escape`].
/// `prereqs` are raw paths and are escaped here. With `phony` set, each
/// prerequisite after the first gets an empty rule of its own, so a
/// deleted header does not stop `make` with "No rule to make target".
pub fn render(targets: &[String], prereqs: &[String], phony: bool) -> String {
    let mut w = Wrapper::new();
    for t in targets {
        w.push(t);
    }
    w.push_raw(":");
    let escaped: Vec<String> = prereqs.iter().map(|p| escape(p)).collect();
    for p in &escaped {
        w.push(p);
    }
    let mut out = w.out;
    out.push('\n');
    if phony {
        for p in escaped.iter().skip(1) {
            out.push_str(p);
            out.push_str(":\n");
        }
    }
    out
}

/// The prerequisite list for a translation unit: the source followed by
/// every header the preprocessor resolved to a file, in first-inclusion
/// order and deduplicated.
///
/// `system` selects `-M` over `-MM`: with it clear, headers from the
/// compiler's own set and from the host system directories are dropped,
/// which is the distinction gcc draws between a user header and a
/// system one.
///
/// A header served from the in-binary set has no filesystem path and is
/// omitted from both forms -- a make prerequisite names a file, and no
/// file backs it. A build that wants those listed can point
/// `own_header_roots` at a checkout, which resolves the same headers to
/// real files. Under `-nostdinc`, the case the kernel build exercises,
/// every header comes from a `-I` directory and none of this applies.
///
/// Names repeat in the include stream and are emitted once. gcc repeats
/// them; make stats each prerequisite either way, so the shorter list
/// describes the same build.
pub fn prerequisites(source: &str, records: &[IncludeRecord], system: bool) -> Vec<String> {
    let mut out = Vec::with_capacity(records.len() + 1);
    out.push(simplify(source).to_string());
    for r in records {
        if r.status == IncludeStatus::Missing {
            continue;
        }
        if !system && r.origin != IncludeOrigin::User {
            continue;
        }
        let Some(path) = r.path.as_deref() else {
            continue;
        };
        let path = simplify(path);
        if !out.iter().any(|p| p == path) {
            out.push(path.to_string());
        }
    }
    out
}

/// Drop the leading `./` a search-path spelling contributes, as gcc's
/// path simplification does: `-I./include` would otherwise name every
/// header it serves `./include/...`. make matches a prerequisite
/// against target names textually, so a generated header reached that
/// way would not match the rule that builds it. Only the leading `./`
/// goes -- gcc keeps `..` components, and collapsing one would name a
/// different file across a symlinked directory.
fn simplify(path: &str) -> &str {
    let mut p = path;
    while let Some(rest) = p.strip_prefix("./") {
        p = rest;
    }
    if p.is_empty() { path } else { p }
}

#[cfg(test)]
mod tests {
    use super::*;
    use alloc::vec;

    fn strs(v: &[&str]) -> Vec<String> {
        v.iter().map(|s| s.to_string()).collect()
    }

    #[test]
    fn plain_rule_matches_gcc_shape() {
        let out = render(&strs(&["main.o"]), &strs(&["main.c", "a.h", "b.h"]), false);
        assert_eq!(out, "main.o: main.c a.h b.h\n");
    }

    #[test]
    fn multiple_targets_share_one_colon() {
        let out = render(&strs(&["t1.o", "t2.o"]), &strs(&["main.c"]), false);
        assert_eq!(out, "t1.o t2.o: main.c\n");
    }

    #[test]
    fn escape_covers_make_metacharacters() {
        assert_eq!(escape("sp ace.h"), "sp\\ ace.h");
        assert_eq!(escape("ha#sh.h"), "ha\\#sh.h");
        assert_eq!(escape("dol$lar.h"), "dol$$lar.h");
        assert_eq!(escape("tab\there.h"), "tab\\\there.h");
        // A colon stays bare, as in gcc.
        assert_eq!(escape("c:/x.h"), "c:/x.h");
        // A backslash run is doubled only where it meets whitespace.
        assert_eq!(escape("bs\\sl.h"), "bs\\sl.h");
        assert_eq!(escape("bs\\ sp.h"), "bs\\\\\\ sp.h");
        assert_eq!(escape("x\\\\ y.h"), "x\\\\\\\\\\ y.h");
        // A multi-byte path is not a sequence of bytes to re-encode.
        assert_eq!(escape("caf\u{e9}/\u{4e2d}.h"), "caf\u{e9}/\u{4e2d}.h");
        assert_eq!(escape("caf\u{e9} x.h"), "caf\u{e9}\\ x.h");
    }

    #[test]
    fn wraps_past_column_72_with_gcc_continuation() {
        // Column before the last name is 7 + len(first header) = 17;
        // gcc breaks when that plus the name exceeds 72.
        let h1 = "haaaaaaa.h"; // 10
        let fits = "b".repeat(53) + ".h"; // 55 -> 17 + 55 == 72
        let wraps = "b".repeat(54) + ".h"; // 56 -> 17 + 56 == 73
        let one = render(&strs(&["T"]), &strs(&["s.c", h1, &fits]), false);
        assert_eq!(one, alloc::format!("T: s.c {h1} {fits}\n"));
        let two = render(&strs(&["T"]), &strs(&["s.c", h1, &wraps]), false);
        assert_eq!(two, alloc::format!("T: s.c {h1} \\\n {wraps}\n"));
    }

    #[test]
    fn name_longer_than_the_bound_is_never_split() {
        let long = "d/".to_string() + &"x".repeat(96) + ".h";
        let out = render(&strs(&["s2.o"]), &strs(&["s2.c", &long]), false);
        assert_eq!(out, alloc::format!("s2.o: s2.c \\\n {long}\n"));
    }

    #[test]
    fn phony_targets_skip_the_source_and_carry_no_blank_lines() {
        let out = render(&strs(&["main.o"]), &strs(&["main.c", "a.h", "b.h"]), true);
        assert_eq!(out, "main.o: main.c a.h b.h\na.h:\nb.h:\n");
    }

    #[test]
    fn phony_block_is_empty_without_headers() {
        let out = render(&strs(&["lone.o"]), &strs(&["lone.c"]), true);
        assert_eq!(out, "lone.o: lone.c\n");
    }

    #[test]
    fn phony_targets_are_escaped_like_prerequisites() {
        let out = render(&strs(&["m.o"]), &strs(&["m.c", "sp ace.h"]), true);
        assert_eq!(out, "m.o: m.c sp\\ ace.h\nsp\\ ace.h:\n");
    }

    fn rec(spelling: &str, path: Option<&str>, origin: IncludeOrigin) -> IncludeRecord {
        IncludeRecord {
            depth: 1,
            spelling: spelling.to_string(),
            path: path.map(|p| p.to_string()),
            origin,
            status: IncludeStatus::Opened,
        }
    }

    #[test]
    fn prerequisites_lead_with_the_source_and_dedup() {
        let records = vec![
            rec("a.h", Some("inc/a.h"), IncludeOrigin::User),
            rec("a.h", Some("inc/a.h"), IncludeOrigin::User),
            rec("b.h", Some("inc/b.h"), IncludeOrigin::User),
        ];
        assert_eq!(
            prerequisites("m.c", &records, true),
            strs(&["m.c", "inc/a.h", "inc/b.h"])
        );
    }

    #[test]
    fn cached_resolutions_still_count_as_prerequisites() {
        let mut cached = rec("a.h", Some("inc/a.h"), IncludeOrigin::User);
        cached.status = IncludeStatus::Cached;
        assert_eq!(
            prerequisites("m.c", &[cached], true),
            strs(&["m.c", "inc/a.h"])
        );
    }

    #[test]
    fn missing_headers_are_not_prerequisites() {
        let mut miss = rec("gone.h", None, IncludeOrigin::User);
        miss.status = IncludeStatus::Missing;
        assert_eq!(prerequisites("m.c", &[miss], true), strs(&["m.c"]));
    }

    #[test]
    fn system_flag_selects_between_m_and_mm() {
        let records = vec![
            rec("a.h", Some("inc/a.h"), IncludeOrigin::User),
            rec(
                "stdio.h",
                Some("/usr/include/stdio.h"),
                IncludeOrigin::System,
            ),
            rec(
                "stddef.h",
                Some("libc/include/stddef.h"),
                IncludeOrigin::Own,
            ),
        ];
        assert_eq!(
            prerequisites("m.c", &records, true),
            strs(&[
                "m.c",
                "inc/a.h",
                "/usr/include/stdio.h",
                "libc/include/stddef.h"
            ])
        );
        assert_eq!(
            prerequisites("m.c", &records, false),
            strs(&["m.c", "inc/a.h"])
        );
    }

    #[test]
    fn a_leading_dot_slash_from_the_search_path_spelling_is_dropped() {
        // `-I./include` resolves headers to `./include/...`; gcc names
        // them without the prefix and so must badc, or a generated
        // header would not match the rule that builds it.
        let records = vec![
            rec(
                "linux/a.h",
                Some("./include/linux/a.h"),
                IncludeOrigin::User,
            ),
            // The same file reached without the prefix is not a second
            // prerequisite.
            rec("linux/a.h", Some("include/linux/a.h"), IncludeOrigin::User),
            // `..` stays: collapsing it names a different file across a
            // symlinked directory, and gcc keeps it too.
            rec("vma.h", Some("kernel/../mm/vma.h"), IncludeOrigin::User),
        ];
        assert_eq!(
            prerequisites("./m.c", &records, true),
            strs(&["m.c", "include/linux/a.h", "kernel/../mm/vma.h"])
        );
    }

    #[test]
    fn in_binary_headers_have_no_path_and_are_omitted() {
        let records = vec![rec("stdarg.h", None, IncludeOrigin::Own)];
        assert_eq!(prerequisites("m.c", &records, true), strs(&["m.c"]));
    }
}

//! Capture git provenance at compile time so every emitted
//! binary can carry a `BADC_BUILD: ...` marker identifying the
//! compiler that produced it. The values flow through
//! `cargo:rustc-env` -> `env!("BADC_GIT_*")` -> the `BUILD_INFO`
//! const in `src/lib.rs`.
//!
//! The `--version` tail is gated on the `badc_git` cfg, which is set
//! only when all three read back, so a build from an exported tree
//! prints the version line alone rather than three `unknown`s.
//!
//! Each value falls back to `"unknown"` when git is missing,
//! the working tree isn't a checkout, or the requested ref
//! doesn't exist (e.g., a freshly-init'd repo with no commits).
//! That keeps `cargo build` working in places like sandboxed
//! crates.io packaging or CI containers without a `.git` dir.

use std::collections::BTreeMap;
use std::env;
use std::fs;
use std::path::{Path, PathBuf};
use std::process::Command;

/// `commit` / `branch` / `remote` from `.badc-provenance` beside the
/// manifest, written by whatever copied this tree out of its checkout.
/// Absent file, unreadable file and malformed lines all yield nothing:
/// the caller then reports no provenance rather than a guess.
fn recorded_provenance() -> BTreeMap<String, String> {
    let path =
        PathBuf::from(env::var("CARGO_MANIFEST_DIR").unwrap_or_default()).join(".badc-provenance");
    let mut out = BTreeMap::new();
    let Ok(text) = fs::read_to_string(&path) else {
        return out;
    };
    println!("cargo:rerun-if-changed={}", path.display());
    for line in text.lines() {
        let line = line.trim();
        if line.is_empty() || line.starts_with('#') {
            continue;
        }
        if let Some((k, v)) = line.split_once('=') {
            let v = v.trim();
            if !v.is_empty() {
                out.insert(k.trim().to_string(), v.to_string());
            }
        }
    }
    out
}

fn main() {
    emit_binding_to_header_index();
    emit_elf_symbol_versions();

    // A tree copied without its `.git` -- rsync to a build box, an
    // exported archive -- still came from a commit, and a binary that
    // cannot name it cannot be traced back to what produced it. The
    // copier records the three values in `.badc-provenance`, which is
    // read only when git itself answers nothing.
    let recorded = recorded_provenance();
    let commit = git(&["rev-parse", "HEAD"]).or_else(|| recorded.get("commit").cloned());
    let branch =
        git(&["rev-parse", "--abbrev-ref", "HEAD"]).or_else(|| recorded.get("branch").cloned());
    let remote = git(&["remote", "get-url", "origin"]).or_else(|| recorded.get("remote").cloned());

    // `badc_git` gates the provenance tail on `--version`. All three
    // have to be readable for the tail to say anything: a tree with no
    // commits, or a clone with no `origin`, reports what it knows
    // rather than padding the rest with a placeholder.
    println!("cargo::rustc-check-cfg=cfg(badc_git)");
    if commit.is_some() && branch.is_some() && remote.is_some() {
        println!("cargo:rustc-cfg=badc_git");
    }

    // What the one-line identification names. A forge checks out
    // `refs/pull/N/merge` for a pull request: a real merge commit that
    // is the tree built, but on no branch and absent from a clone, so
    // naming it leaves a reader with a hash they cannot resolve. Its
    // parents -- base first, proposed head second -- are both
    // resolvable and together determine the merge, so the line states
    // `<head> on <base>` instead. The merge itself stays in the tail.
    //
    // Everything else names the commit alone. The gate is on having an
    // identification at all, not on `badc_git`: a checkout with no
    // `origin` still states which source produced the compiler.
    let short = |c: &str| c[..c.len().min(12)].to_string();
    let merge_parents = branch
        .as_deref()
        .filter(|b| *b == "HEAD")
        .and_then(|_| git(&["rev-parse", "HEAD^@"]))
        .map(|s| s.split_whitespace().map(str::to_string).collect::<Vec<_>>())
        .filter(|v| v.len() >= 2);
    let ident = match (&merge_parents, &commit) {
        (Some(p), _) => Some(format!("{} on {}", short(&p[1]), short(&p[0]))),
        (None, Some(c)) => Some(short(c)),
        (None, None) => None,
    };

    println!("cargo::rustc-check-cfg=cfg(badc_git_commit)");
    if ident.is_some() {
        println!("cargo:rustc-cfg=badc_git_commit");
    }
    println!(
        "cargo:rustc-env=BADC_GIT_ID={}",
        ident.unwrap_or_else(|| "unknown".into())
    );

    println!(
        "cargo:rustc-env=BADC_GIT_COMMIT={}",
        commit.unwrap_or_else(|| "unknown".into())
    );
    println!(
        "cargo:rustc-env=BADC_GIT_BRANCH={}",
        branch.unwrap_or_else(|| "unknown".into())
    );
    println!(
        "cargo:rustc-env=BADC_GIT_REMOTE={}",
        remote.unwrap_or_else(|| "unknown".into())
    );

    // Re-run when HEAD or the branch it names moves, or when this
    // build script itself changes.
    //
    // `.git/refs` alone does not do it. Cargo tracks a directory's own
    // mtime, and a branch under a prefix -- `refs/heads/topic/name` --
    // updates `refs/heads/topic`, leaving `refs/heads` untouched; a
    // packed ref updates neither. The commit embedded in the binary
    // then lags HEAD silently, which is the one thing this provenance
    // must not do. The paths come from git so a worktree or a submodule,
    // where `.git` is a file pointing elsewhere, resolves correctly.
    for path in git_watch_paths() {
        println!("cargo:rerun-if-changed={path}");
    }
    println!("cargo:rerun-if-changed=build.rs");
    // include_str! attaches a per-file rerun-if-changed dep, but
    // Cargo's incremental build under Swatinem/rust-cache has been
    // observed not to detect content changes in libc/include/*
    // when the cache restores a stale target/. Treating the
    // headers directory as a build input forces a re-link whenever
    // any of the embedded headers shift.
    println!("cargo:rerun-if-changed=libc/include");
    println!("cargo:rerun-if-changed=libc/compiler/include");
    println!("cargo:rerun-if-changed=libc/versions");
}

/// Turn `libc/versions/elf-<arch>.txt` into
/// `$OUT_DIR/elf_symbol_versions.rs`: one sorted `&[(&str, &str, &str)]`
/// slice per architecture, keyed on `(soname, symbol)` for binary
/// search. An empty version string means the symbol carries no
/// requirement. `libc/versions/minimums.txt` joins it as `MINIMUMS`,
/// `(soname, symbol, minimum, reason)` with an empty minimum where the
/// review found the floor's pick sound.
fn emit_elf_symbol_versions() {
    let out_dir = env::var("OUT_DIR").expect("OUT_DIR set by cargo");
    let dest = Path::new(&out_dir).join("elf_symbol_versions.rs");
    let mut out = String::new();
    out.push_str("// AUTO-GENERATED by build.rs from libc/versions/elf-*.txt\n");
    for (arch, konst) in [("x86_64", "X86_64"), ("aarch64", "AARCH64")] {
        let path = format!("libc/versions/elf-{arch}.txt");
        let body = fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {path}: {e}"));
        let mut rows: Vec<(String, String, String)> = Vec::new();
        let mut soname = String::new();
        for line in body.lines() {
            let line = line.trim();
            if line.is_empty() || line.starts_with('#') {
                continue;
            }
            if let Some(name) = line.strip_prefix('[') {
                let name = name
                    .strip_suffix(']')
                    .unwrap_or_else(|| panic!("{path}: malformed section `{line}`"));
                soname = name.to_string();
                continue;
            }
            let line = line.split('#').next().unwrap_or("").trim();
            if line.is_empty() {
                continue;
            }
            let mut fields = line.split_whitespace();
            let (Some(symbol), Some(version), None) = (fields.next(), fields.next(), fields.next())
            else {
                panic!("{path}: malformed entry `{line}`");
            };
            assert!(
                !soname.is_empty(),
                "{path}: entry `{line}` before any [soname]"
            );
            let version = if version == "-" { "" } else { version };
            rows.push((soname.clone(), symbol.to_string(), version.to_string()));
        }
        rows.sort();
        rows.dedup();
        // Two versions for one key would make the binary search return
        // either.
        for pair in rows.windows(2) {
            assert!(
                (&pair[0].0, &pair[0].1) != (&pair[1].0, &pair[1].1),
                "{path}: `{}` in `{}` has two versions",
                pair[0].1,
                pair[0].0,
            );
        }
        out.push_str(&format!(
            "pub(super) const {konst}: &[(&str, &str, &str)] = &[\n"
        ));
        for (soname, symbol, version) in &rows {
            out.push_str(&format!("    ({soname:?}, {symbol:?}, {version:?}),\n"));
        }
        out.push_str("];\n");
    }
    out.push_str(&emit_version_minimums());
    fs::write(&dest, out).expect("write symbol version table");
}

/// `libc/versions/minimums.txt` as `MINIMUMS`. A `[version]` or `[-]`
/// head opens a section and states its reason, continued on indented
/// lines; the rows under it are `<soname> <symbol>` at column zero.
fn emit_version_minimums() -> String {
    let path = "libc/versions/minimums.txt";
    let body = fs::read_to_string(path).unwrap_or_else(|e| panic!("read {path}: {e}"));
    let mut rows: Vec<(String, String, String, String)> = Vec::new();
    let mut minimum = String::new();
    let mut reason = String::new();
    for raw in body.lines() {
        let line = raw.trim();
        if line.is_empty() || line.starts_with('#') {
            continue;
        }
        if let Some(rest) = line.strip_prefix('[') {
            let (head, rest) = rest
                .split_once(']')
                .unwrap_or_else(|| panic!("{path}: malformed section `{line}`"));
            minimum = if head == "-" {
                String::new()
            } else {
                head.to_string()
            };
            reason = rest.trim().to_string();
            continue;
        }
        if raw.starts_with(char::is_whitespace) {
            assert!(!reason.is_empty(), "{path}: `{line}` continues no reason");
            reason.push(' ');
            reason.push_str(line);
            continue;
        }
        let mut fields = line.split_whitespace();
        let (Some(soname), Some(symbol), None) = (fields.next(), fields.next(), fields.next())
        else {
            panic!("{path}: malformed row `{line}`");
        };
        assert!(!reason.is_empty(), "{path}: `{line}` is under no section");
        rows.push((
            soname.to_string(),
            symbol.to_string(),
            minimum.clone(),
            reason.clone(),
        ));
    }
    rows.sort();
    // Read by the tests that hold the committed manifest and the
    // bundled headers in step; the link itself reads the per-arch
    // tables above.
    let mut out = String::from(
        "#[allow(dead_code)]\npub(super) const MINIMUMS: &[(&str, &str, &str, &str)] = &[\n",
    );
    for (soname, symbol, minimum, reason) in &rows {
        out.push_str(&format!(
            "    ({soname:?}, {symbol:?}, {minimum:?}, {reason:?}),\n"
        ));
    }
    out.push_str("];\n");
    out
}

/// Walk the headers under `libc/include` and `libc/compiler/include`, each
/// named as it is served, extract every `#pragma binding(...)`
/// local symbol, every function-prototype identifier and every function
/// a `static inline` definition provides, and emit
/// `$OUT_DIR/binding_to_header.rs` as a sorted `&[(&str, &[&str])]`
/// const slice. The compiler's `headers::header_declaring(name)`
/// then does an O(log N) lookup instead of substring-scanning every
/// header on every miss.
///
/// Each name carries every header declaring it, in scan order, so
/// `header_declaring` gets the conventional one and a caller that
/// needs the target's binding can try the rest -- a name bound to
/// one library in `stdlib.h` and to another in `unistd.h` reaches
/// both. Headers are scanned in priority-then-lexicographic order
/// so the list is deterministic across builds.
///
/// Skipped headers:
///   * `memory.h` -- legacy alias for `string.h`; surfacing both
///     would just duplicate every entry.
///   * `msvc_compat.h` -- predefines + decorator macros, no real
///     library bindings to index.
///   * `__badc_*.h` -- declaration blocks other headers include; their
///     names count for each header that includes them.
fn emit_binding_to_header_index() {
    let out_dir = env::var("OUT_DIR").expect("OUT_DIR set by cargo");
    let dest = Path::new(&out_dir).join("binding_to_header.rs");
    // Without the `headers` feature no header is embedded, and no name
    // resolves to one.
    if env::var_os("CARGO_FEATURE_HEADERS").is_none() {
        let empty = "pub(super) const BINDING_TO_HEADER: &[(&str, &[&str])] = &[];\n\
                     pub(super) const HEADER_INCLUDERS: &[(&str, &[&str])] = &[];\n";
        fs::write(&dest, empty).expect("write binding index");
        return;
    }
    let mut headers: Vec<(PathBuf, String)> = Vec::new();
    for root in ["libc/include", "libc/compiler/include"] {
        let root = Path::new(root);
        collect_headers(root, root, &mut headers);
    }
    // Priority order: the conventional home for each symbol wins
    // when more than one header declares it -- stdio.h takes
    // `printf` over assert.h, stdlib.h takes `abort` / `malloc`
    // over assert.h / malloc.h, string.h takes the `mem*` family
    // over strings.h. Whatever isn't in this list falls back to
    // lexicographic order, which is deterministic but secondary.
    let priority = [
        "stdio.h", "stdlib.h", "string.h", "math.h", "ctype.h", "unistd.h", "time.h", "stdarg.h",
        "wchar.h", "locale.h", "signal.h", "errno.h", "setjmp.h", "assert.h",
    ];
    let rank = |name: &str| -> usize {
        priority
            .iter()
            .position(|p| *p == name)
            .unwrap_or(priority.len())
    };
    headers.sort_by(|a, b| {
        let ra = rank(&a.1);
        let rb = rank(&b.1);
        ra.cmp(&rb).then_with(|| a.1.cmp(&b.1))
    });

    let bodies: BTreeMap<&str, String> = headers
        .iter()
        .map(|(path, rel)| {
            let body =
                fs::read_to_string(path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
            (rel.as_str(), body)
        })
        .collect();
    let block = |rel: &str| rel.starts_with("__badc_");
    let mut index: BTreeMap<String, Vec<String>> = BTreeMap::new();
    for (_, rel) in &headers {
        if rel == "memory.h" || rel == "msvc_compat.h" || block(rel) {
            continue;
        }
        let mut texts: Vec<&str> = vec![bodies[rel.as_str()].as_str()];
        let mut i = 0;
        while i < texts.len() {
            for inc in included_headers(texts[i]).filter(|h| block(h)) {
                if let Some(b) = bodies.get(inc)
                    && !texts.contains(&b.as_str())
                {
                    texts.push(b);
                }
            }
            i += 1;
        }
        for body in texts {
            for name in extract_binding_names(body)
                .into_iter()
                .chain(extract_prototype_names(body))
            {
                let hs = index.entry(name).or_default();
                if !hs.iter().any(|h| h == rel) {
                    hs.push(rel.clone());
                }
            }
        }
    }

    let mut out = String::new();
    out.push_str("// AUTO-GENERATED by build.rs from the bundled headers\n");
    out.push_str("// Sorted by name; binary-search the slice in header_declaring.\n");
    out.push_str("pub(super) const BINDING_TO_HEADER: &[(&str, &[&str])] = &[\n");
    for (name, hs) in &index {
        let list = hs
            .iter()
            .map(|h| format!("{h:?}"))
            .collect::<Vec<_>>()
            .join(", ");
        out.push_str(&format!("    ({name:?}, &[{list}]),\n"));
    }
    out.push_str("];\n");
    // The headers that include each bundled header, sorted by the included
    // one: where a target withholds a declaring header, an includer it serves
    // declares the name too.
    let mut includers: BTreeMap<&str, Vec<&str>> = BTreeMap::new();
    for (_, rel) in &headers {
        for inc in included_headers(&bodies[rel.as_str()]).filter(|h| bodies.contains_key(h)) {
            let list = includers.entry(inc).or_default();
            if !list.contains(&rel.as_str()) && inc != rel {
                list.push(rel.as_str());
            }
        }
    }
    out.push_str("pub(super) const HEADER_INCLUDERS: &[(&str, &[&str])] = &[\n");
    for (inc, hs) in &includers {
        let list = hs
            .iter()
            .map(|h| format!("{h:?}"))
            .collect::<Vec<_>>()
            .join(", ");
        out.push_str(&format!("    ({inc:?}, &[{list}]),\n"));
    }
    out.push_str("];\n");
    fs::write(&dest, out).expect("write binding index");
}

fn collect_headers(root: &Path, dir: &Path, out: &mut Vec<(PathBuf, String)>) {
    let entries = match fs::read_dir(dir) {
        Ok(it) => it,
        Err(_) => return,
    };
    for entry in entries.flatten() {
        let path = entry.path();
        if path.is_dir() {
            collect_headers(root, &path, out);
        } else if path.extension().and_then(|s| s.to_str()) == Some("h")
            && !path
                .file_name()
                .and_then(|n| n.to_str())
                .is_some_and(|n| n.starts_with('.'))
        {
            let rel = path
                .strip_prefix(root)
                .unwrap()
                .to_string_lossy()
                .replace('\\', "/");
            out.push((path, rel));
        }
    }
}

/// The `<name>` of each `#include <name>` line.
fn included_headers(body: &str) -> impl Iterator<Item = &str> {
    body.lines().filter_map(|line| {
        let rest = line.trim_start().strip_prefix('#')?.trim_start();
        let rest = rest
            .strip_prefix("include")?
            .trim_start()
            .strip_prefix('<')?;
        rest.split_once('>').map(|(name, _)| name)
    })
}

fn extract_binding_names(body: &str) -> Vec<String> {
    // `#pragma binding(<dylib>::<local_name>, "<real_symbol>")`
    let mut out = Vec::new();
    for line in body.lines() {
        let trimmed = line.trim_start();
        let Some(rest) = trimmed.strip_prefix("#pragma binding(") else {
            continue;
        };
        let Some(sep) = rest.find("::") else { continue };
        let after = &rest[sep + 2..];
        let end = after
            .find(|c: char| !c.is_ascii_alphanumeric() && c != '_')
            .unwrap_or(after.len());
        let name = &after[..end];
        if !name.is_empty() {
            out.push(name.to_string());
        }
    }
    out
}

/// The identifier of each file-scope function declarator in `body`, of a
/// declaration or a definition however it is split across lines: an
/// identifier that a parameter list follows, in a grouped declarator too
/// (`void (*signal(int, void (*)(int)))(int)`). Comments, directives,
/// `typedef` declarations, initializers, aggregate and function bodies, the
/// operands of attributes, `__declspec`, asm labels and `_Static_assert`,
/// and a macro invocation in place of a declaration name no function. An
/// `extern "C" { ... }` block is file scope.
fn extract_prototype_names(body: &str) -> Vec<String> {
    let toks = header_tokens(body);
    let opens = |i: usize| toks.get(i) == Some(&Tok::Punct(b'('));
    let mut out = Vec::new();
    // `start`: no token of the current declaration read yet.
    let (mut i, mut parens, mut typedef, mut start) = (0, 0usize, false, true);
    while i < toks.len() {
        match toks[i] {
            Tok::Word(w) if is_operand_keyword(w) && opens(i + 1) => {
                i = group_end(&toks, i + 1, b'(', b')');
                continue;
            }
            // A macro invocation in place of a declaration: what it
            // declares, the text does not spell.
            Tok::Word(_) if start && opens(i + 1) => {
                i = group_end(&toks, i + 1, b'(', b')');
                continue;
            }
            Tok::Word("typedef") => typedef = true,
            Tok::Word(w) if opens(i + 1) => {
                if !typedef && !is_c_keyword(w) {
                    out.push(w.to_string());
                }
                i = group_end(&toks, i + 1, b'(', b')');
                // Attributes and an asm label may stand between the
                // parameter list and a definition's body.
                while let Some(&Tok::Word(a)) = toks.get(i)
                    && is_operand_keyword(a)
                    && opens(i + 1)
                {
                    i = group_end(&toks, i + 1, b'(', b')');
                }
                if toks.get(i) == Some(&Tok::Punct(b'{')) {
                    i = group_end(&toks, i, b'{', b'}');
                    (typedef, start) = (false, true);
                }
                continue;
            }
            Tok::Word("extern")
                if matches!(toks.get(i + 1), Some(Tok::Str))
                    && toks.get(i + 2) == Some(&Tok::Punct(b'{')) =>
            {
                i += 3;
                continue;
            }
            // A list after a grouped declarator is its parameter list.
            Tok::Punct(b'(') if i > 0 && toks[i - 1] == Tok::Punct(b')') => {
                i = group_end(&toks, i, b'(', b')');
                continue;
            }
            Tok::Punct(b'(') => parens += 1,
            Tok::Punct(b')') => parens = parens.saturating_sub(1),
            Tok::Punct(b'{') => {
                i = group_end(&toks, i, b'{', b'}');
                start = false;
                continue;
            }
            Tok::Punct(b'=') if parens == 0 => {
                while i < toks.len() && !matches!(toks[i], Tok::Punct(b',' | b';')) {
                    i = match toks[i] {
                        Tok::Punct(b'(') => group_end(&toks, i, b'(', b')'),
                        Tok::Punct(b'{') => group_end(&toks, i, b'{', b'}'),
                        _ => i + 1,
                    };
                }
                continue;
            }
            Tok::Punct(b';') => (parens, typedef) = (0, false),
            _ => {}
        }
        // A `;` ends a declaration; a `}` here closes an `extern "C"` block.
        start = matches!(toks[i], Tok::Punct(b';' | b'}'));
        i += 1;
    }
    out
}

/// A token of a header's C text: an identifier or keyword, a literal, or
/// one punctuator byte.
#[derive(Clone, Copy, PartialEq)]
enum Tok<'a> {
    Word(&'a str),
    Str,
    Number,
    Punct(u8),
}

/// The tokens of `body` with comments and preprocessing directives
/// removed. A directive runs to the end of its line, continuations
/// included.
fn header_tokens(body: &str) -> Vec<Tok<'_>> {
    let bytes = body.as_bytes();
    let mut toks = Vec::new();
    let (mut i, mut line_start) = (0, true);
    while i < bytes.len() {
        let b = bytes[i];
        if b == b'\n' {
            (i, line_start) = (i + 1, true);
            continue;
        }
        if b.is_ascii_whitespace() || (b == b'\\' && bytes.get(i + 1) == Some(&b'\n')) {
            i += if b == b'\\' { 2 } else { 1 };
            continue;
        }
        if body[i..].starts_with("/*") {
            i = body[i + 2..].find("*/").map_or(bytes.len(), |e| i + e + 4);
            continue;
        }
        if body[i..].starts_with("//") || (line_start && b == b'#') {
            let directive = b == b'#';
            while i < bytes.len() && bytes[i] != b'\n' {
                if directive && bytes[i] == b'\\' && bytes.get(i + 1) == Some(&b'\n') {
                    i += 1;
                } else if directive && body[i..].starts_with("/*") {
                    i = body[i + 2..].find("*/").map_or(bytes.len(), |e| i + e + 3);
                }
                i += 1;
            }
            continue;
        }
        line_start = false;
        let start = i;
        if b == b'_' || b.is_ascii_alphanumeric() {
            while i < bytes.len() && (bytes[i] == b'_' || bytes[i].is_ascii_alphanumeric()) {
                i += 1;
            }
            let word = &body[start..i];
            let prefixed = matches!(word, "L" | "u" | "U" | "u8")
                && matches!(bytes.get(i), Some(b'"' | b'\''));
            if !prefixed {
                toks.push(if b.is_ascii_digit() {
                    Tok::Number
                } else {
                    Tok::Word(word)
                });
            }
        } else if b == b'"' || b == b'\'' {
            i += 1;
            while i < bytes.len() && bytes[i] != b && bytes[i] != b'\n' {
                i += if bytes[i] == b'\\' { 2 } else { 1 };
            }
            i += 1;
            toks.push(Tok::Str);
        } else {
            toks.push(Tok::Punct(b));
            i += 1;
        }
    }
    toks
}

/// The index past the group that opens at `toks[at]` and closes at its
/// matching `close`.
fn group_end(toks: &[Tok<'_>], at: usize, open: u8, close: u8) -> usize {
    let mut depth = 0usize;
    for (i, t) in toks.iter().enumerate().skip(at) {
        match *t {
            Tok::Punct(c) if c == open => depth += 1,
            Tok::Punct(c) if c == close => {
                depth -= 1;
                if depth == 0 {
                    return i + 1;
                }
            }
            _ => {}
        }
    }
    toks.len()
}

/// A keyword whose parenthesized operand names no declarator.
fn is_operand_keyword(w: &str) -> bool {
    matches!(
        w,
        "__attribute__"
            | "__attribute"
            | "__declspec"
            | "__asm__"
            | "__asm"
            | "asm"
            | "_Alignas"
            | "alignas"
            | "_Static_assert"
            | "static_assert"
            | "__typeof__"
            | "__typeof"
            | "typeof"
            | "_Pragma"
            | "__pragma"
    )
}

fn is_c_keyword(s: &str) -> bool {
    matches!(
        s,
        "if" | "else"
            | "while"
            | "for"
            | "do"
            | "switch"
            | "case"
            | "default"
            | "break"
            | "continue"
            | "return"
            | "goto"
            | "sizeof"
            | "typedef"
            | "static"
            | "extern"
            | "auto"
            | "register"
            | "const"
            | "volatile"
            | "restrict"
            | "inline"
            | "void"
            | "char"
            | "short"
            | "int"
            | "long"
            | "float"
            | "double"
            | "signed"
            | "unsigned"
            | "struct"
            | "union"
            | "enum"
            | "_Bool"
            | "_Complex"
            | "_Imaginary"
    )
}

/// Files whose change means HEAD now names a different commit: HEAD
/// itself, the loose ref it points at, the packed-refs file that holds
/// the ref when it is not loose, and the HEAD reflog. Empty when git
/// cannot be asked.
fn git_watch_paths() -> Vec<String> {
    let git_path = |p: &str| git(&["rev-parse", "--git-path", p]);
    let Some(head) = git_path("HEAD") else {
        return Vec::new();
    };
    let mut paths = vec![head];
    paths.extend(git_path("packed-refs"));
    // Detached HEAD names no ref, and then HEAD itself carries the commit.
    if let Some(r) = git(&["symbolic-ref", "--quiet", "HEAD"])
        && let Some(p) = git_path(&r)
    {
        paths.push(p);
    }
    // A missing watched path reruns every build; the HEAD reflog records a packed ref's update.
    if let Some(log) = git_path("logs/HEAD").filter(|p| Path::new(p).exists()) {
        paths.retain(|p| Path::new(p).exists());
        paths.push(log);
    }
    paths
}

fn git(args: &[&str]) -> Option<String> {
    let out = Command::new("git").args(args).output().ok()?;
    if !out.status.success() {
        return None;
    }
    let s = String::from_utf8_lossy(&out.stdout).trim().to_string();
    if s.is_empty() { None } else { Some(s) }
}

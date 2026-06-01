//! Capture git provenance at compile time so every emitted
//! binary can carry a `BADC_BUILD: ...` marker identifying the
//! compiler that produced it. The values flow through
//! `cargo:rustc-env` -> `env!("BADC_GIT_*")` -> the `BUILD_INFO`
//! const in `src/lib.rs`.
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
use std::time::{SystemTime, UNIX_EPOCH};

fn main() {
    emit_binding_to_header_index();

    let commit = git(&["rev-parse", "HEAD"]).unwrap_or_else(|| "unknown".into());
    let branch = git(&["rev-parse", "--abbrev-ref", "HEAD"]).unwrap_or_else(|| "unknown".into());
    let remote = git(&["remote", "get-url", "origin"]).unwrap_or_else(|| "unknown".into());

    println!("cargo:rustc-env=BADC_GIT_COMMIT={commit}");
    println!("cargo:rustc-env=BADC_GIT_BRANCH={branch}");
    println!("cargo:rustc-env=BADC_GIT_REMOTE={remote}");

    // Build-time date / time, captured as env vars the preprocessor
    // reads at compile time to seed the C99 `__DATE__` and `__TIME__`
    // predefined macros. C99 says these reflect the date of
    // translation; for an embedded compiler-as-library, the build
    // time of badc itself is the closest approximation. The format
    // matches the C99 spec: `"Mmm dd yyyy"` (day field is two
    // characters, leading-space-padded for single-digit days) and
    // `"hh:mm:ss"`.
    let (date_str, time_str) = build_date_time();
    println!("cargo:rustc-env=BADC_BUILD_DATE={date_str}");
    println!("cargo:rustc-env=BADC_BUILD_TIME={time_str}");

    // Re-run when HEAD or any ref moves (commit / checkout /
    // branch swap), or when this build script itself changes.
    println!("cargo:rerun-if-changed=.git/HEAD");
    println!("cargo:rerun-if-changed=.git/refs");
    println!("cargo:rerun-if-changed=build.rs");
    // include_str! attaches a per-file rerun-if-changed dep, but
    // Cargo's incremental build under Swatinem/rust-cache has been
    // observed not to detect content changes in headers/include/*
    // when the cache restores a stale target/. Treating the
    // headers directory as a build input forces a re-link whenever
    // any of the embedded headers shift.
    println!("cargo:rerun-if-changed=headers/include");
}

/// Walk `headers/include/*.h`, extract every `#pragma binding(...)`
/// local symbol and every function-prototype identifier, and emit
/// `$OUT_DIR/binding_to_header.rs` as a sorted `&[(&str, &str)]`
/// const slice. The compiler's `headers::header_declaring(name)`
/// then does an O(log N) lookup instead of substring-scanning every
/// header on every miss.
///
/// First-occurrence-wins per name -- a libc symbol declared in both
/// `string.h` and `strings.h` resolves to whichever the walk hit
/// first. Headers are scanned in lexicographic order so the
/// resolution is deterministic across builds.
///
/// Skipped headers:
///   * `memory.h` -- legacy alias for `string.h`; surfacing both
///     would just duplicate every entry.
///   * `msvc_compat.h` -- predefines + decorator macros, no real
///     library bindings to index.
fn emit_binding_to_header_index() {
    let out_dir = env::var("OUT_DIR").expect("OUT_DIR set by cargo");
    let dest = Path::new(&out_dir).join("binding_to_header.rs");
    let root = Path::new("headers/include");
    let mut headers: Vec<(PathBuf, String)> = Vec::new();
    collect_headers(root, root, &mut headers);
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

    let mut index: BTreeMap<String, String> = BTreeMap::new();
    for (path, rel) in &headers {
        if rel == "memory.h" || rel == "msvc_compat.h" {
            continue;
        }
        let body =
            fs::read_to_string(path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
        for name in extract_binding_names(&body) {
            index.entry(name).or_insert_with(|| rel.clone());
        }
        for name in extract_prototype_names(&body) {
            index.entry(name).or_insert_with(|| rel.clone());
        }
    }

    let mut out = String::new();
    out.push_str("// AUTO-GENERATED by build.rs from headers/include/*.h\n");
    out.push_str("// Sorted by name; binary-search the slice in header_declaring.\n");
    out.push_str("pub(super) const BINDING_TO_HEADER: &[(&str, &str)] = &[\n");
    for (name, header) in &index {
        out.push_str(&format!("    ({name:?}, {header:?}),\n"));
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
        } else if path.extension().and_then(|s| s.to_str()) == Some("h") {
            let rel = path
                .strip_prefix(root)
                .unwrap()
                .to_string_lossy()
                .replace('\\', "/");
            out.push((path, rel));
        }
    }
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

fn extract_prototype_names(body: &str) -> Vec<String> {
    // Function prototype shape: a file-scope declaration line that
    // ends with `);`. Walk word-bounded identifiers on the line and
    // pick the last one immediately followed by `(` -- the lead-in
    // identifiers are return-type / storage-class / cv-qualifier
    // tokens (`int`, `void`, `static`, `const`, `extern`, ...).
    //
    // Track outer-brace depth across lines so call expressions inside
    // a `static inline` function body (e.g., `buf = malloc(32);` in
    // `c5io.h`) don't get misread as prototypes -- those sit at
    // depth > 0 and are skipped.
    let mut out = Vec::new();
    let mut brace_depth: i32 = 0;
    let mut paren_depth: i32 = 0;
    for raw in body.lines() {
        let trimmed = raw.trim_start();
        let directive_or_comment = trimmed.starts_with('#') || trimmed.starts_with("//");
        if !directive_or_comment
            && brace_depth == 0
            && paren_depth == 0
            && raw.trim_end().ends_with(");")
            && let Some(name) = last_call_id(raw)
            && !is_c_keyword(&name)
        {
            out.push(name);
        }
        // Track brace / paren depth for the next line. Skip the body
        // of `// ...` and `#...` lines; both are line-scoped, so
        // their braces don't affect the running depth.
        if !directive_or_comment {
            update_depth(raw, &mut brace_depth, &mut paren_depth);
        }
    }
    out
}

fn last_call_id(line: &str) -> Option<String> {
    let bytes = line.as_bytes();
    let mut last_id: Option<(usize, usize)> = None;
    let mut i = 0;
    while i < bytes.len() {
        let b = bytes[i];
        if b.is_ascii_alphabetic() || b == b'_' {
            let start = i;
            while i < bytes.len() && (bytes[i].is_ascii_alphanumeric() || bytes[i] == b'_') {
                i += 1;
            }
            let mut j = i;
            while j < bytes.len() && (bytes[j] == b' ' || bytes[j] == b'\t') {
                j += 1;
            }
            if j < bytes.len() && bytes[j] == b'(' {
                last_id = Some((start, i));
            }
        } else {
            i += 1;
        }
    }
    last_id.map(|(s, e)| line[s..e].to_string())
}

fn update_depth(line: &str, brace: &mut i32, paren: &mut i32) {
    let bytes = line.as_bytes();
    let mut in_str = false;
    let mut in_chr = false;
    let mut i = 0;
    while i < bytes.len() {
        let b = bytes[i];
        if in_str {
            if b == b'\\' && i + 1 < bytes.len() {
                i += 2;
                continue;
            }
            if b == b'"' {
                in_str = false;
            }
        } else if in_chr {
            if b == b'\\' && i + 1 < bytes.len() {
                i += 2;
                continue;
            }
            if b == b'\'' {
                in_chr = false;
            }
        } else {
            match b {
                b'"' => in_str = true,
                b'\'' => in_chr = true,
                b'{' => *brace += 1,
                b'}' => *brace = brace.saturating_sub(1).max(0),
                b'(' => *paren += 1,
                b')' => *paren = paren.saturating_sub(1).max(0),
                _ => {}
            }
        }
        i += 1;
    }
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

/// Format the current wall-clock time as a C99 `(__DATE__, __TIME__)`
/// pair. UTC; we don't have a portable timezone library at build time
/// and the absolute time-of-day rarely matters to a downstream `__TIME__`
/// consumer (most use it as a "build identity" marker, not a wall
/// clock). Falls back to a placeholder if the system clock is unset.
fn build_date_time() -> (String, String) {
    let secs = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .map(|d| d.as_secs() as i64)
        .unwrap_or(0);
    let days = secs.div_euclid(86_400);
    let tod = secs.rem_euclid(86_400);
    let (y, m, d) = civil_from_days(days);
    let h = tod / 3600;
    let mi = (tod % 3600) / 60;
    let s = tod % 60;
    let months = [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    let date_str = format!("{} {:>2} {}", months[(m - 1) as usize], d, y);
    let time_str = format!("{h:02}:{mi:02}:{s:02}");
    (date_str, time_str)
}

/// Convert a Unix-epoch day count to `(year, month, day_of_month)`.
/// Howard Hinnant's `civil_from_days` algorithm (public domain), with
/// the era starting on March 1; output is the standard Gregorian
/// civil date.
fn civil_from_days(days: i64) -> (i64, u32, u32) {
    let z = days + 719_468;
    let era = z.div_euclid(146_097);
    let doe = z.rem_euclid(146_097) as u64;
    let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
    let y = yoe as i64 + era * 400;
    let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    let mp = (5 * doy + 2) / 153;
    let d = (doy - (153 * mp + 2) / 5 + 1) as u32;
    let m = if mp < 10 { mp + 3 } else { mp - 9 } as u32;
    let y = if m <= 2 { y + 1 } else { y };
    (y, m, d)
}

fn git(args: &[&str]) -> Option<String> {
    let out = Command::new("git").args(args).output().ok()?;
    if !out.status.success() {
        return None;
    }
    let s = String::from_utf8_lossy(&out.stdout).trim().to_string();
    if s.is_empty() { None } else { Some(s) }
}

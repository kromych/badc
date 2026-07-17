use super::Preprocessor;
use crate::c5::codegen::Target;
use crate::c5::error::C5Error;
use crate::c5::headers::embedded_header;
use alloc::format;
use alloc::string::{String, ToString};

impl Preprocessor {
    /// `#include <name>` / `#include "name"` -- splice the named
    /// header's processed contents into the output.
    ///
    /// The header is looked up in [`crate::c5::headers::embedded_header`].
    /// Unknown names emit a warning (matching gcc / clang's
    /// "fatal error: 'X': No such file or directory" diagnostic
    /// at warning severity rather than fatal -- c5 chooses the
    /// permissive shape so legacy fixtures with cosmetic
    /// `#include`s don't break) and resolve to an empty body.
    /// Cyclic `#include` returns an error; repeat inclusion of a
    /// header that previously declared `#pragma once` returns an
    /// empty string. With [`Self::set_show_includes`] on the
    /// resolution path is appended to `include_trace` in the
    /// gcc-`-H` shape (`. file`, `.. nested`, `! missing` for
    /// the warning case).
    pub(super) fn process_include(
        &mut self,
        name: &str,
        line_no: usize,
        filename: &str,
        quoted: bool,
    ) -> Result<String, C5Error> {
        // Resolution order:
        //   1. Filesystem search paths added via `add_search_path`
        //      (= the CLI's `-I` flag plus any built-in defaults).
        //      Lets a user override a bundled header by dropping
        //      the modified file at `./include/<name>` without
        //      rebuilding badc.
        //   2. Bundled in-binary header (the include_str! set in
        //      `headers.rs`).
        //   3. Missed -- emit a warning and resolve to "". The
        //      compile keeps going so a header that exists at
        //      runtime but wasn't bundled in the test binary
        //      isn't a hard failure; the user sees the warning
        //      and can decide whether the missing surface
        //      matters.
        // A quoted include (`#include "header"`) searches the
        // directory of the including file before the system search
        // paths (C99 6.10.2p2); an angle include skips that step.
        // `filename` carries the including file's path (the top-level
        // source path, or the resolved path threaded through a nested
        // include), so its parent directory is the search base.
        let source_dir = if quoted {
            include_parent_dir(filename)
        } else {
            None
        };
        // The result is owned `String` because filesystem-loaded
        // bodies don't have static lifetime; the embedded path
        // copies its `&'static str` into one to share the type. The
        // second element is the path the body resolved to, threaded
        // as the new file's name so a nested quoted include resolves
        // against the right directory.
        let resolved: Option<(String, String)> = self.find_include(name, source_dir.as_deref());
        self.finish_include(resolved, name, line_no, filename)
    }

    /// `#include_next <header>` (C/GCC extension): resolve `name` from the
    /// search path entry *after* the one that supplied the file holding
    /// the directive, so a shim header that shadows a system header can
    /// pull in the shadowed one. The current file's directory is matched
    /// against the search paths to find the resume point.
    pub(super) fn process_include_next(
        &mut self,
        name: &str,
        line_no: usize,
        filename: &str,
        _quoted: bool,
    ) -> Result<String, C5Error> {
        let resolved = self.find_include_next(name, filename);
        self.finish_include(resolved, name, line_no, filename)
    }

    /// Shared tail of `process_include` / `process_include_next`: error on
    /// a miss, honour `#pragma once`, bound the include depth, and process
    /// the resolved body.
    pub(super) fn finish_include(
        &mut self,
        resolved: Option<(String, String)>,
        name: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<String, C5Error> {
        let Some((content, resolved_path)) = resolved else {
            // Missing header is a hard error, as in gcc/clang: the
            // directive cannot perform the replacement C99 6.10.2
            // requires, and continuing with an empty body miscompiles.
            if self.show_includes {
                let depth = self.include_stack.len() + 1;
                self.include_trace
                    .push(format!("{} {} (missing)", "!".repeat(depth), name));
            }
            return Err(C5Error::Compile(crate::c5::error::fmt_compile_err(
                filename,
                line_no,
                &format!(
                    "include `{name}` not found \
                     (no header search path or embedded header matched)"
                ),
            )));
        };
        // `#pragma once` dedups by the resolved path (file identity),
        // not the include spelling, so two different spellings that
        // name the same file are still included once. The handler in
        // `process_named` records the same `resolved_path`.
        if self.pragma_once_files.contains(&resolved_path) {
            if self.show_includes {
                let depth = self.include_stack.len() + 1;
                self.include_trace
                    .push(format!("{} {} (cached)", ".".repeat(depth), name));
            }
            return Ok(String::new());
        }
        if self.show_includes {
            let depth = self.include_stack.len() + 1;
            self.include_trace
                .push(format!("{} {}", ".".repeat(depth), name));
        }
        // A header may legitimately appear more than once on the active
        // include path: a guard-protected re-include where an inner header
        // pulls a guarded outer one back in. The include guard skips the body
        // on the second pass, so this must process normally rather than error.
        // Bound only the nesting depth so a truly unguarded self-include still
        // fails fast instead of recursing without limit; C99 5.2.4.1 sets 15
        // levels as the minimum a translator must support.
        const MAX_INCLUDE_DEPTH: usize = 200;
        if self.include_stack.len() >= MAX_INCLUDE_DEPTH {
            let chain = self.include_stack.join(" -> ");
            return Err(C5Error::Compile(crate::c5::error::fmt_compile_err(
                filename,
                line_no,
                &format!("`#include {name}` nested too deeply (chain: {chain} -> {name})"),
            )));
        }
        self.include_stack.push(name.to_string());
        let result = self.process_named(&content, &resolved_path);
        self.include_stack.pop();
        result
    }

    /// Look `name` up and return its body plus the path it resolved
    /// to. `source_dir` is `Some` only for a quoted include; when set
    /// it is searched first (C99 6.10.2p2). Then the configured search
    /// paths (`-I` plus built-in defaults), then the embedded
    /// registry. The resolved path is the filesystem candidate that
    /// matched, or `name` for an embedded header.
    pub(super) fn find_include(
        &self,
        name: &str,
        source_dir: Option<&str>,
    ) -> Option<(String, String)> {
        #[cfg(feature = "std")]
        {
            let join = |dir: &str| -> String {
                if dir.is_empty() {
                    name.to_string()
                } else if dir.ends_with('/') || dir.ends_with('\\') {
                    format!("{dir}{name}")
                } else {
                    format!("{dir}/{name}")
                }
            };
            // A name with its own directory component or an absolute
            // path is taken as-is; otherwise probe the source
            // directory (quoted only) then the search paths.
            if let Some(dir) = source_dir {
                let candidate = join(dir);
                if let Ok(body) = std::fs::read_to_string(&candidate) {
                    return Some((body, candidate));
                }
                // `-iquote` directories apply to `#include "..."` only
                // (C99 6.10.2p2 leaves the extra places implementation-
                // defined; gcc scopes them to the quoted form), probed
                // after the including file's directory and before `-I`.
                for path in &self.quote_search_paths {
                    let candidate = join(path);
                    if let Ok(body) = std::fs::read_to_string(&candidate) {
                        return Some((body, candidate));
                    }
                }
            }
            for path in &self.search_paths {
                let candidate = join(path);
                if let Ok(body) = std::fs::read_to_string(&candidate) {
                    return Some((body, candidate));
                }
            }
        }
        let _ = source_dir;
        if let Some(body) = embedded_header(name) {
            return Some((body.to_string(), name.to_string()));
        }
        // A header the embedded set lacks (a third-party `zlib.h`,
        // `libfdt.h`) falls back to the host system directories, probed
        // only here so a standard header still resolves to the embedded
        // copy above.
        #[cfg(feature = "std")]
        {
            let join = |dir: &str| -> String {
                if dir.is_empty() {
                    name.to_string()
                } else if dir.ends_with('/') || dir.ends_with('\\') {
                    format!("{dir}{name}")
                } else {
                    format!("{dir}/{name}")
                }
            };
            for path in &self.system_fallback_paths {
                let candidate = join(path);
                if let Ok(body) = std::fs::read_to_string(&candidate) {
                    return Some((body, candidate));
                }
            }
        }
        // Windows resolves includes case-insensitively (its filesystems
        // are); match the embedded registry the same way there.
        if matches!(self.target, Target::WindowsX64 | Target::WindowsAarch64) {
            let lower = name.to_ascii_lowercase();
            return crate::c5::headers::embedded_headers()
                .iter()
                .find(|(n, _)| n.eq_ignore_ascii_case(&lower))
                .map(|(n, body)| (body.to_string(), n.to_string()));
        }
        None
    }

    /// Resolve `name` for `#include_next`: skip search-path entries up to
    /// and including the one whose directory holds `current_file`, then
    /// probe the remaining paths and finally the embedded registry. When
    /// the directive's file came from the embedded registry (no filesystem
    /// directory), there is nothing after it, so resolution yields none.
    pub(super) fn find_include_next(
        &self,
        name: &str,
        current_file: &str,
    ) -> Option<(String, String)> {
        #[cfg(feature = "std")]
        {
            // Skip the search-path entries up to and including the one whose
            // directory holds the current file.
            let cur_dir = include_parent_dir(current_file);
            let mut start = 0usize;
            if let Some(ref cd) = cur_dir {
                for (i, path) in self.search_paths.iter().enumerate() {
                    if path_dirs_equal(path, cd) {
                        start = i + 1;
                        break;
                    }
                }
            }
            let join = |dir: &str| -> String {
                if dir.is_empty() {
                    name.to_string()
                } else if dir.ends_with('/') || dir.ends_with('\\') {
                    format!("{dir}{name}")
                } else {
                    format!("{dir}/{name}")
                }
            };
            for path in self.search_paths.iter().skip(start) {
                // A later entry that aliases the current header's own
                // directory (e.g. a relative overlay duplicating an
                // absolute `-I`, or a symlink) would re-resolve this same
                // file rather than the next one; skip it.
                if cur_dir
                    .as_deref()
                    .is_some_and(|cd| path_dirs_equal(path, cd))
                {
                    continue;
                }
                let candidate = join(path);
                if let Ok(body) = std::fs::read_to_string(&candidate) {
                    return Some((body, candidate));
                }
            }
        }
        let _ = current_file;
        embedded_header(name).map(|s| (s.to_string(), name.to_string()))
    }
}

/// Parent directory of an include path, or `None` when the path has
/// no directory component (a bare name, the embedded-header label, or
/// the synthetic `<force-include>` / top-level labels). Handles both
/// `/` and `\` separators. Used to resolve a quoted include against
/// the including file's directory.
pub(super) fn include_parent_dir(filename: &str) -> Option<alloc::string::String> {
    // A bare filename (no directory component) names a file in the
    // current working directory, so a quoted include in it searches the
    // cwd. Return an empty directory; `find_include` joins that as a
    // cwd-relative name. `None` would skip the source-directory step and
    // miss a same-directory header.
    match filename.rfind(['/', '\\']) {
        Some(cut) => Some(filename[..cut].to_string()),
        None => Some(alloc::string::String::new()),
    }
}

/// Whether two directory paths name the same directory. Canonicalizes
/// both when possible (so `a/b` and `./a/b` and an absolute spelling
/// compare equal); falls back to a trailing-slash-insensitive string
/// compare when a path cannot be resolved. Used by `#include_next` to
/// locate the search-path entry that supplied the current file.
#[cfg(feature = "std")]
pub(super) fn path_dirs_equal(a: &str, b: &str) -> bool {
    match (std::fs::canonicalize(a), std::fs::canonicalize(b)) {
        (Ok(pa), Ok(pb)) => pa == pb,
        _ => a.trim_end_matches(['/', '\\']) == b.trim_end_matches(['/', '\\']),
    }
}

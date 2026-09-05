use super::Preprocessor;
use crate::c5::codegen::Target;
use crate::c5::diag::Code;
use crate::c5::error::C5Error;
use crate::c5::headers::embedded_header;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

/// Which header-search rule a `#include`-family construct follows.
#[derive(Clone, Copy)]
pub(super) struct IncludeForm {
    /// The `"header"` spelling, which searches the including file's
    /// directory first.
    pub(super) quoted: bool,
    /// The `_next` form, which resumes past the current file's entry.
    pub(super) next: bool,
}

impl IncludeForm {
    pub(super) fn plain(quoted: bool) -> Self {
        IncludeForm {
            quoted,
            next: false,
        }
    }
    pub(super) fn next(quoted: bool) -> Self {
        IncludeForm { quoted, next: true }
    }
}

/// Which header set supplied a resolved `#include`. Selects what the
/// `-MM` / `-MMD` dependency filter drops.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum IncludeOrigin {
    /// The including file's own directory, an `-iquote` directory or
    /// an `-I` directory.
    User,
    /// The compiler's own header set: an `own_header_roots` file, or
    /// an in-binary body with no filesystem path.
    Own,
    /// A host system directory probed after the own set
    /// (`system_fallback_paths`).
    System,
}

/// A resolved `#include`: the body plus the bookkeeping the callers
/// need once the search has picked a file.
pub(super) struct Resolved {
    pub(super) body: String,
    /// Identity for `#pragma once` and include-guard bookkeeping: the
    /// filesystem path for a file, the bare name for an in-binary
    /// header, so one header reached by two spellings stays one file.
    pub(super) key: String,
    /// Filesystem path, `None` for an in-binary body.
    pub(super) path: Option<String>,
    pub(super) origin: IncludeOrigin,
}

impl Resolved {
    /// A body served from a file on disk.
    fn file(body: String, path: String, origin: IncludeOrigin) -> Self {
        Resolved {
            body,
            key: path.clone(),
            path: Some(path),
            origin,
        }
    }
}

/// What became of one `#include` directive.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum IncludeStatus {
    /// The body was spliced into the output.
    Opened,
    /// Resolved but skipped: `#pragma once`, or an include guard whose
    /// controlling macro is defined.
    Cached,
    /// No search path or header set matched.
    Missing,
}

/// One `#include` resolution. Recorded when include tracking is on;
/// renders the gcc `-H` trace and supplies the `-M` family's
/// prerequisite list, so both read one list rather than each keeping
/// its own.
#[derive(Clone)]
pub struct IncludeRecord {
    /// Nesting depth: 1 for a directive in the primary source.
    pub depth: usize,
    /// The header name as the directive spelled it.
    pub spelling: String,
    /// Filesystem path, `None` for an in-binary header or a miss.
    pub path: Option<String>,
    pub origin: IncludeOrigin,
    pub status: IncludeStatus,
}

impl IncludeRecord {
    /// The gcc `-H` line for this record: leading dots mark nesting
    /// depth, `!` marks a miss.
    pub fn trace_line(&self) -> String {
        let mark = if self.status == IncludeStatus::Missing {
            "!"
        } else {
            "."
        };
        let suffix = match self.status {
            IncludeStatus::Opened => "",
            IncludeStatus::Cached => " (cached)",
            IncludeStatus::Missing => " (missing)",
        };
        format!("{} {}{}", mark.repeat(self.depth), self.spelling, suffix)
    }
}

impl Preprocessor {
    /// `#include <name>` / `#include "name"`: splice the named header's
    /// processed contents into the output. The search runs the `-I`
    /// paths then [`crate::c5::headers::embedded_header`]; an unknown
    /// name is an error, as in gcc and clang, since the directive
    /// cannot perform the C99 6.10.2 replacement. A repeat include of a
    /// `#pragma once` header contributes nothing. With
    /// [`Self::set_track_includes`] on, each resolution is appended to
    /// `include_records`.
    pub(super) fn process_include(
        &mut self,
        name: &str,
        line_no: usize,
        filename: &str,
        quoted: bool,
        out: &mut String,
    ) -> Result<(), C5Error> {
        let resolved = self.resolve_include(name, IncludeForm::plain(quoted), filename);
        self.finish_include(resolved, name, line_no, filename, out)
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
        quoted: bool,
        out: &mut String,
    ) -> Result<(), C5Error> {
        let resolved = self.resolve_include(name, IncludeForm::next(quoted), filename);
        self.finish_include(resolved, name, line_no, filename, out)
    }

    /// Resolve `name` the way the matching directive would. Shared by
    /// `#include` / `#include_next` and by the `__has_include` /
    /// `__has_include_next` operators, which keep only the answer.
    ///
    /// [`Resolved::body`] is owned because a filesystem-loaded body has
    /// no static lifetime; the embedded path copies its `&'static str`.
    /// [`Resolved::key`] becomes the new file's name, so a nested quoted
    /// include resolves against the right directory.
    pub(super) fn resolve_include(
        &self,
        name: &str,
        form: IncludeForm,
        filename: &str,
    ) -> Option<Resolved> {
        if form.next {
            // `#include_next` resumes past the search-path entry that
            // supplied the current file, so the including file's own
            // directory is not a search base.
            return self.find_include_next(name, filename);
        }
        // A quoted include (`#include "header"`) searches the directory
        // of the including file before the system search paths (C99
        // 6.10.2p2); an angle include skips that step. `filename` carries
        // the including file's path (the top-level source path, or the
        // resolved path threaded through a nested include), so its parent
        // directory is the search base.
        let source_dir = if form.quoted {
            include_parent_dir(filename)
        } else {
            None
        };
        self.find_include(name, source_dir.as_deref())
    }

    /// Shared tail of `process_include` / `process_include_next`: error on
    /// a miss, honour `#pragma once`, bound the include depth, and process
    /// the resolved body.
    pub(super) fn finish_include(
        &mut self,
        resolved: Option<Resolved>,
        name: &str,
        line_no: usize,
        filename: &str,
        out: &mut String,
    ) -> Result<(), C5Error> {
        let Some(found) = resolved else {
            // Missing header is a hard error, as in gcc/clang: the
            // directive cannot perform the replacement C99 6.10.2
            // requires, and continuing with an empty body miscompiles.
            self.record_include(name, None, IncludeOrigin::User, IncludeStatus::Missing);
            return Err(C5Error::at(
                Code::DIRECTIVE,
                filename,
                line_no,
                format!(
                    "include `{name}` not found \
                     (no header search path or embedded header matched)"
                ),
            ));
        };
        if let Some(r) = self.reuse.as_deref_mut() {
            r.consulted_includes.insert(found.key.clone());
        }
        // Both drops key on the resolved path (file identity), not the
        // include spelling, so two spellings of the same file are still
        // included once; `process_named` records the same path.
        // `#pragma once` drops unconditionally; the guard form drops only
        // while its controlling macro is defined, since that is what makes
        // the body inactive.
        if self.pragma_once_files.contains(&found.key) || self.include_is_guarded_out(&found.key) {
            self.record_include(
                name,
                found.path.clone(),
                found.origin,
                IncludeStatus::Cached,
            );
            return Ok(());
        }
        self.record_include(
            name,
            found.path.clone(),
            found.origin,
            IncludeStatus::Opened,
        );
        // A header may legitimately appear more than once on the active
        // include path: a guard-protected re-include where an inner header
        // pulls a guarded outer one back in. The include guard skips the body
        // on the second pass, so this must process normally rather than error.
        // Bound only the nesting depth so a truly unguarded self-include still
        // fails fast instead of recursing without limit; C99 5.2.4.1 sets 15
        // levels as the minimum a translator must support.
        const MAX_INCLUDE_DEPTH: usize = 200;
        if self.include_stack.len() >= MAX_INCLUDE_DEPTH {
            let chain = self
                .include_stack
                .iter()
                .map(|(n, _)| n.as_str())
                .collect::<Vec<_>>()
                .join(" -> ");
            return Err(C5Error::at(
                Code::LIMIT,
                filename,
                line_no,
                format!("`#include {name}` nested too deeply (chain: {chain} -> {name})"),
            ));
        }
        self.include_stack
            .push((name.to_string(), found.origin == IncludeOrigin::Own));
        let result = self.process_named(&found.body, &found.key, out);
        self.include_stack.pop();
        result
    }

    /// Append one `#include` resolution to the tracking list. A no-op
    /// unless `-H` or a `-M`-family flag asked for it.
    fn record_include(
        &mut self,
        spelling: &str,
        path: Option<String>,
        origin: IncludeOrigin,
        status: IncludeStatus,
    ) {
        if !self.track_includes {
            return;
        }
        let depth = self.include_stack.len() + 1;
        self.include_records.push(IncludeRecord {
            depth,
            spelling: spelling.to_string(),
            path,
            origin,
            status,
        });
    }

    /// Whether a repeat `#include` of `path` would produce nothing: the
    /// file's whole content sits inside one `#ifndef X` / `#endif` pair
    /// and `X` is defined now, so every line of it takes the false arm.
    /// An `#undef X` in between makes this false again, which is why the
    /// answer is recomputed per inclusion rather than cached.
    fn include_is_guarded_out(&self, path: &str) -> bool {
        self.include_guards
            .get(path)
            .is_some_and(|m| self.is_defined_name(m))
    }

    /// The compiler's own copy of `name`: the body from an on-disk
    /// header root if one carries it, else the in-binary registry.
    /// The key is always `name`, so a header reached both directly and
    /// through another bundled header is one file to `#pragma once`;
    /// `path` still carries the root-relative file when one supplied
    /// the body, since dependency output names files.
    fn own_header(&self, name: &str) -> Option<Resolved> {
        #[cfg(feature = "std")]
        for root in self.own_header_roots.iter() {
            let candidate = join_include_path(root, name);
            if let Ok(body) = std::fs::read_to_string(&candidate) {
                return Some(Resolved {
                    body,
                    key: name.to_string(),
                    path: Some(candidate),
                    origin: IncludeOrigin::Own,
                });
            }
        }
        embedded_header(name).map(|b| Resolved {
            body: b.to_string(),
            key: name.to_string(),
            path: None,
            origin: IncludeOrigin::Own,
        })
    }

    /// Look `name` up and return its body plus the path it resolved
    /// to. `source_dir` is `Some` only for a quoted include; when set
    /// it is searched first (C99 6.10.2p2). Then the configured search
    /// paths (`-I` plus built-in defaults), then the compiler's own
    /// header set. The resolved path is the filesystem candidate that
    /// matched, or `name` for a header from the own set.
    pub(super) fn find_include(&self, name: &str, source_dir: Option<&str>) -> Option<Resolved> {
        #[cfg(feature = "std")]
        {
            // A name with its own directory component or an absolute
            // path is taken as-is; otherwise probe the source
            // directory (quoted only) then the search paths.
            if let Some(dir) = source_dir {
                // `-iquote` directories apply to `#include "..."` only
                // (C99 6.10.2p2 leaves the extra places implementation-
                // defined; gcc scopes them to the quoted form), probed
                // after the including file's directory and before `-I`.
                let dirs =
                    core::iter::once(dir).chain(self.quote_search_paths.iter().map(String::as_str));
                if let Some(found) = probe_dirs(name, dirs, IncludeOrigin::User) {
                    return Some(found);
                }
            }
            // A compiler-owned intrinsic header (built on badc's own inline-asm
            // encoders) resolves to the embedded copy before the search paths:
            // a foreign toolchain's copy on `-I` (a kernel-style
            // `-isystem $(cc -print-file-name=include)` folded into `-I`) is
            // written against that compiler's builtins and can never compile
            // here. The quoted source-directory step above still precedes it
            // per C99 6.10.2p2. Ordinary headers keep `-I`-shadows-embedded.
            if crate::c5::headers::compiler_owned_header(name)
                && let Some(found) = self.own_header(name)
            {
                return Some(found);
            }
            // One bundled header including another resolves within the
            // bundled set. The compiler's headers form a closed set
            // written against each other; a `-I` directory carrying the
            // same name -- an OS source tree supplies its own
            // `linux/...` uapi headers, which `<sys/mman.h>` reaches for
            // -- would otherwise be spliced into the middle of a
            // standard header. The test is the including file's recorded
            // provenance, not a registry lookup of its spelling: a
            // foreign header that happens to share a bundled name (an OS
            // tree's own `linux/cdrom.h`) is not part of the closed set,
            // and its includes keep `-I`-shadows-bundled.
            if self.include_stack.last().is_some_and(|&(_, own)| own)
                && let Some(found) = self.own_header(name)
            {
                return Some(found);
            }
            if let Some(found) = probe_dirs(
                name,
                self.search_paths.iter().map(String::as_str),
                IncludeOrigin::User,
            ) {
                return Some(found);
            }
        }
        let _ = source_dir;
        // `-nostdinc` withdraws the standard library headers and the system
        // directories below, leaving only what the command line named. A
        // name none of those paths carries is then the "not found" error
        // gcc raises, not a silent bind to badc's own libc.
        if self.nostdinc {
            return None;
        }
        if let Some(found) = self.own_header(name) {
            return Some(found);
        }
        // A header the embedded set lacks (a third-party `zlib.h`,
        // `libfdt.h`) falls back to the host system directories, probed
        // only here so a standard header still resolves to the embedded
        // copy above.
        #[cfg(feature = "std")]
        if let Some(found) = probe_dirs(
            name,
            self.system_fallback_paths.iter().map(String::as_str),
            IncludeOrigin::System,
        ) {
            return Some(found);
        }
        // Windows resolves includes case-insensitively (its filesystems
        // are); match the embedded registry the same way there.
        if matches!(self.target, Target::WindowsX64 | Target::WindowsAarch64) {
            let lower = name.to_ascii_lowercase();
            return crate::c5::headers::embedded_headers()
                .iter()
                .find(|(n, _)| n.eq_ignore_ascii_case(&lower))
                .map(|(n, body)| Resolved {
                    body: body.to_string(),
                    key: n.to_string(),
                    path: None,
                    origin: IncludeOrigin::Own,
                });
        }
        None
    }

    /// Resolve `name` for `#include_next`: skip search-path entries up to
    /// and including the one whose directory holds `current_file`, then
    /// probe the remaining paths and finally the embedded registry. When
    /// the directive's file came from the embedded registry (no filesystem
    /// directory), there is nothing after it, so resolution yields none.
    pub(super) fn find_include_next(&self, name: &str, current_file: &str) -> Option<Resolved> {
        #[cfg(feature = "std")]
        {
            // Skip the search-path entries up to and including the one whose
            // directory holds the current file. The current directory is
            // resolved once for both loops below: `path_dirs_equal` used to
            // canonicalize it again per search-path entry.
            let cur_dir = include_parent_dir(current_file);
            let cur_dir = cur_dir
                .as_deref()
                .map(|d| (d, std::fs::canonicalize(d).ok()));
            let mut start = 0usize;
            if let Some((cd, ccd)) = cur_dir.as_ref() {
                for (i, path) in self.search_paths.iter().enumerate() {
                    if path_dirs_equal(path, cd, ccd.as_deref()) {
                        start = i + 1;
                        break;
                    }
                }
            }
            // A later entry that aliases the current header's own
            // directory (a relative overlay duplicating an absolute
            // `-I`, or a symlink) would re-resolve this same file
            // rather than the next one; skip it.
            let rest = self.search_paths.iter().skip(start).filter(|path| {
                !cur_dir
                    .as_ref()
                    .is_some_and(|(cd, ccd)| path_dirs_equal(path, cd, ccd.as_deref()))
            });
            if let Some(found) = probe_dirs(name, rest.map(String::as_str), IncludeOrigin::User) {
                return Some(found);
            }
        }
        let _ = current_file;
        self.own_header(name)
    }
}

/// Join a search directory and an include name. An empty directory
/// yields the bare name, which resolves against the working directory.
#[cfg(feature = "std")]
fn join_include_path(dir: &str, name: &str) -> String {
    if dir.is_empty() {
        name.to_string()
    } else if dir.ends_with('/') || dir.ends_with('\\') {
        format!("{dir}{name}")
    } else {
        format!("{dir}/{name}")
    }
}

/// The first directory of `dirs` that holds `name`, as a resolved
/// include keyed on the file it came from.
#[cfg(feature = "std")]
fn probe_dirs<'a>(
    name: &str,
    dirs: impl IntoIterator<Item = &'a str>,
    origin: IncludeOrigin,
) -> Option<Resolved> {
    dirs.into_iter().find_map(|dir| {
        let candidate = join_include_path(dir, name);
        let body = std::fs::read_to_string(&candidate).ok()?;
        Some(Resolved::file(body, candidate, origin))
    })
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
/// compare when a path cannot be resolved. `canon_b` is `b` already
/// resolved, so a loop over search paths resolves the fixed side once.
/// Used by `#include_next` to locate the search-path entry that supplied
/// the current file.
#[cfg(feature = "std")]
pub(super) fn path_dirs_equal(a: &str, b: &str, canon_b: Option<&std::path::Path>) -> bool {
    match (std::fs::canonicalize(a), canon_b) {
        (Ok(pa), Some(pb)) => pa == pb,
        _ => a.trim_end_matches(['/', '\\']) == b.trim_end_matches(['/', '\\']),
    }
}

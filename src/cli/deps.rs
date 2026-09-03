use std::path::PathBuf;

use super::diag::TuLog;

/// What the `-M` flag family asked the driver to produce.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum DepKind {
    /// `-M` / `-MM`: write the dependency rule and compile nothing.
    Only,
    /// `-MD` / `-MMD`: write the rule alongside the normal output.
    WithOutput,
}

/// A dependency-output request assembled from the `-M` flag family.
pub(crate) struct DepOptions {
    pub(crate) kind: DepKind,
    /// `-M` / `-MD` list system headers; `-MM` / `-MMD` omit them.
    /// badc's system set is the compiler's own headers plus anything
    /// resolved from a system fallback directory; a header from `-I`,
    /// `-iquote` or the including file's directory is a user header.
    pub(crate) system: bool,
    /// `-MF`, or the path carried by `-Wp,-M[M]D,<path>`.
    pub(crate) file: Option<String>,
    /// `-MT` (verbatim) and `-MQ` (make-quoted) rule targets, in
    /// command-line order. Empty means the default naming applies.
    pub(crate) targets: Vec<String>,
    /// `-MP`: give every prerequisite an empty rule of its own.
    pub(crate) phony: bool,
    /// Set by the `-MD` / `-MMD` spellings, where gcc's driver names
    /// the rule after `-o`.
    pub(crate) target_from_output: bool,
}

impl DepOptions {
    /// The file to write for `src`, or `None` to write to stdout
    /// (which only `-M` / `-MM` without `-MF` do).
    pub(crate) fn output_path(
        &self,
        output: Option<&std::path::Path>,
        src: &str,
    ) -> Option<PathBuf> {
        if let Some(f) = &self.file {
            return Some(PathBuf::from(f));
        }
        match self.kind {
            // `-M` / `-MM` write to `-o` when it is given, else stdout.
            DepKind::Only => output.map(PathBuf::from),
            // `-MD` / `-MMD` name the file after the object, else after
            // the source basename in the current directory. The suffix
            // swap applies to the file name only, so a dot in a
            // directory component does not count.
            DepKind::WithOutput => Some(match output {
                Some(o) => o.with_extension("d"),
                None => PathBuf::from(source_basename(src)).with_extension("d"),
            }),
        }
    }

    /// The rule's target names for `src`.
    pub(crate) fn rule_targets(&self, output: Option<&std::path::Path>, src: &str) -> Vec<String> {
        if !self.targets.is_empty() {
            return self.targets.clone();
        }
        if self.target_from_output
            && let Some(o) = output
        {
            return vec![badc::dep_escape(&o.to_string_lossy())];
        }
        // gcc's default: the source's base name with its suffix
        // replaced by `.o`, directory components dropped.
        let base = source_basename(src);
        let stem = match base.rfind('.') {
            Some(i) if i > 0 => &base[..i],
            _ => &base[..],
        };
        vec![badc::dep_escape(&format!("{stem}.o"))]
    }
}

/// The file-name component of a source path, or the whole path when it
/// has no directory component.
pub(crate) fn source_basename(src: &str) -> String {
    std::path::Path::new(src)
        .file_name()
        .map(|s| s.to_string_lossy().into_owned())
        .unwrap_or_else(|| src.to_string())
}

/// Render and write one translation unit's dependency rule. Returns
/// `Err` after logging when the file cannot be written -- gcc treats a
/// dependency file it cannot open as fatal, and a build system that
/// asked for one and silently got none rebuilds wrongly forever.
pub(crate) fn emit_deps(
    src: &str,
    records: &[badc::IncludeRecord],
    deps: &DepOptions,
    output: Option<&std::path::Path>,
    log: &mut TuLog,
    tty: bool,
) -> Result<(), ()> {
    let prereqs = badc::dep_prerequisites(src, records, deps.system);
    let text = badc::dep_render(&deps.rule_targets(output, src), &prereqs, deps.phony);
    match deps.output_path(output, src) {
        Some(path) => std::fs::write(&path, text).map_err(|e| {
            log.diag(
                tty,
                format!(
                    "badc: error: opening dependency file {}: {e}",
                    path.display()
                ),
            );
        }),
        None => {
            print!("{text}");
            Ok(())
        }
    }
}

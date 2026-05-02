//! Capture git provenance at compile time so every emitted
//! binary can carry a `BADC_BUILD: …` marker identifying the
//! compiler that produced it. The values flow through
//! `cargo:rustc-env` -> `env!("BADC_GIT_*")` -> the `BUILD_INFO`
//! const in `src/lib.rs`.
//!
//! Each value falls back to `"unknown"` when git is missing,
//! the working tree isn't a checkout, or the requested ref
//! doesn't exist (e.g., a freshly-init'd repo with no commits).
//! That keeps `cargo build` working in places like sandboxed
//! crates.io packaging or CI containers without a `.git` dir.

use std::process::Command;

fn main() {
    let commit = git(&["rev-parse", "HEAD"]).unwrap_or_else(|| "unknown".into());
    let branch = git(&["rev-parse", "--abbrev-ref", "HEAD"]).unwrap_or_else(|| "unknown".into());
    let remote = git(&["remote", "get-url", "origin"]).unwrap_or_else(|| "unknown".into());

    println!("cargo:rustc-env=BADC_GIT_COMMIT={commit}");
    println!("cargo:rustc-env=BADC_GIT_BRANCH={branch}");
    println!("cargo:rustc-env=BADC_GIT_REMOTE={remote}");

    // Re-run when HEAD or any ref moves (commit / checkout /
    // branch swap), or when this build script itself changes.
    println!("cargo:rerun-if-changed=.git/HEAD");
    println!("cargo:rerun-if-changed=.git/refs");
    println!("cargo:rerun-if-changed=build.rs");
}

fn git(args: &[&str]) -> Option<String> {
    let out = Command::new("git").args(args).output().ok()?;
    if !out.status.success() {
        return None;
    }
    let s = String::from_utf8_lossy(&out.stdout).trim().to_string();
    if s.is_empty() { None } else { Some(s) }
}

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

use std::process::Command;
use std::time::{SystemTime, UNIX_EPOCH};

fn main() {
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

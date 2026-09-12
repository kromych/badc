//! An emitted image is a function of its declared inputs: the sources,
//! the flags, the target, and the environment variables the driver
//! documents. Each case here builds the same command under two states
//! of something the command line never named and requires the same
//! bytes, or names the input and requires the difference.

use std::path::{Path, PathBuf};
use std::process::Command;

fn badc() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_badc"))
}

fn tempdir(name: &str) -> PathBuf {
    let p = std::env::temp_dir().join(format!("badc-reproducible-{name}-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&p);
    std::fs::create_dir_all(&p).expect("create temp dir");
    p
}

fn write(dir: &Path, name: &str, body: &str) -> PathBuf {
    let p = dir.join(name);
    if let Some(parent) = p.parent() {
        std::fs::create_dir_all(parent).expect("create parent dir");
    }
    std::fs::write(&p, body).expect("write file");
    p
}

/// Run badc in `dir` with `args` and the given environment on top of
/// the test's own, with the variables the cases toggle cleared first.
fn run(dir: &Path, args: &[&str], env: &[(&str, &str)]) -> std::process::Output {
    let mut cmd = Command::new(badc());
    cmd.args(args).current_dir(dir);
    for var in ["SOURCE_DATE_EPOCH", "BADC_HOME", "SDKROOT"] {
        cmd.env_remove(var);
    }
    for (k, v) in env {
        cmd.env(k, v);
    }
    cmd.output().expect("run badc")
}

fn stderr(out: &std::process::Output) -> String {
    String::from_utf8_lossy(&out.stderr).into_owned()
}

/// Link `src` for linux-x64 into `dir/<name>` and return the image.
fn image(dir: &Path, name: &str, src: &Path, flags: &[&str], env: &[(&str, &str)]) -> Vec<u8> {
    let exe = dir.join(name);
    let mut args = vec!["-q", "--target=linux-x64"];
    args.extend_from_slice(flags);
    args.push("-o");
    args.push(exe.to_str().unwrap());
    args.push(src.to_str().unwrap());
    let out = run(dir, &args, env);
    assert!(
        out.status.success(),
        "link of {name} failed: {}",
        stderr(&out)
    );
    std::fs::read(&exe).expect("read image")
}

const DATED: &str = "const char *d = __DATE__;\nconst char *t = __TIME__;\n\
                     int main(void) { return d[3] == ' ' && t[2] == ':' ? 0 : 1; }\n";

// C99 6.10.8p1 wants the date and time of translation; the
// reproducible-build convention fixes them through SOURCE_DATE_EPOCH,
// so two builds under one value are one image, and a value that names
// no instant is refused rather than read as one.
#[test]
fn source_date_epoch_fixes_date_and_time() {
    let dir = tempdir("epoch");
    let src = write(&dir, "d.c", DATED);
    let epoch = [("SOURCE_DATE_EPOCH", "0")];
    let out = run(&dir, &["-E", src.to_str().unwrap()], &epoch);
    assert!(out.status.success(), "{}", stderr(&out));
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(
        text.contains("\"Jan  1 1970\"") && text.contains("\"00:00:00\""),
        "SOURCE_DATE_EPOCH=0 must render as the epoch in UTC: {text}"
    );
    assert_eq!(
        image(&dir, "a", &src, &[], &epoch),
        image(&dir, "b", &src, &[], &epoch),
        "one SOURCE_DATE_EPOCH must give one image"
    );
    let later = [("SOURCE_DATE_EPOCH", "86400")];
    assert_ne!(
        image(&dir, "c", &src, &[], &epoch),
        image(&dir, "d", &src, &[], &later),
        "the instant is an input: a different one must change `__DATE__`"
    );
    for bad in ["yesterday", "-1", "253402300800"] {
        let out = run(
            &dir,
            &["-E", src.to_str().unwrap()],
            &[("SOURCE_DATE_EPOCH", bad)],
        );
        assert!(!out.status.success(), "`{bad}` must be refused");
        assert!(
            stderr(&out).contains("SOURCE_DATE_EPOCH"),
            "the refusal must name the variable: {}",
            stderr(&out)
        );
    }
    let _ = std::fs::remove_dir_all(&dir);
}

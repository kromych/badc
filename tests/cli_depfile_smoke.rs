//! End-to-end tests for the `-M` dependency-output flag family,
//! exercised through the actual badc binary.
//!
//! The expected text is gcc's, observed from gcc 16.1.1 on a Linux
//! host: the source is always the first prerequisite, the rule's
//! default target is the source's base name with its suffix replaced
//! by `.o` (directory components dropped), `-MD` / `-MMD` take the
//! rule name from `-o` -- except under `-E`, where `-o` names the
//! preprocessed text -- while the `-Wp,` spellings keep the default,
//! lists wrap past column 72 onto ` \`-continued lines, and `-MP`
//! appends one empty rule per prerequisite after the source with no
//! blank lines between them.

use std::path::{Path, PathBuf};
use std::process::Command;

fn badc() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_badc"))
}

/// A temp directory holding `main.c` -> `a.h` -> `sub/deep.h`, plus
/// `b.h`. `main.c` includes `a.h` then `b.h`.
fn fixture(name: &str) -> PathBuf {
    let mut dir = std::env::temp_dir();
    dir.push(format!("badc-dep-test-{name}-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(dir.join("sub")).expect("create temp dir");
    std::fs::create_dir_all(dir.join("obj")).expect("create obj dir");
    write(&dir, "sub/deep.h", "int deep;\n");
    write(&dir, "a.h", "#include \"sub/deep.h\"\nint a;\n");
    write(&dir, "b.h", "int b;\n");
    write(
        &dir,
        "main.c",
        "#include \"a.h\"\n#include \"b.h\"\nint main(void){return 0;}\n",
    );
    dir
}

fn write(dir: &Path, name: &str, body: &str) -> PathBuf {
    let p = dir.join(name);
    std::fs::write(&p, body).expect("write file");
    p
}

/// Run badc in `dir` and return stdout, requiring success.
fn run(dir: &Path, args: &[&str]) -> String {
    let out = Command::new(badc())
        .args(args)
        .current_dir(dir)
        .output()
        .expect("spawn badc");
    assert!(
        out.status.success(),
        "badc {args:?} failed: status={} stderr={:?}",
        out.status,
        String::from_utf8_lossy(&out.stderr)
    );
    String::from_utf8_lossy(&out.stdout).into_owned()
}

/// Run badc in `dir` and return stderr, requiring failure.
fn run_fail(dir: &Path, args: &[&str]) -> String {
    let out = Command::new(badc())
        .args(args)
        .current_dir(dir)
        .output()
        .expect("spawn badc");
    assert!(
        !out.status.success(),
        "badc {args:?} unexpectedly succeeded"
    );
    String::from_utf8_lossy(&out.stderr).into_owned()
}

fn read(dir: &Path, name: &str) -> String {
    std::fs::read_to_string(dir.join(name)).unwrap_or_else(|e| panic!("read {name}: {e}"))
}

/// The prerequisites of a one-rule dependency file, unwrapping the
/// ` \`-continued lines. Order is not asserted: gcc emits them in
/// include order and so does badc, but a set comparison is what makes
/// the file equivalent for make's purposes.
fn prereqs(text: &str) -> Vec<String> {
    let rule = text
        .split('\n')
        .take_while(|l| !l.is_empty())
        .collect::<Vec<_>>();
    let joined = rule.join(" ").replace(" \\", " ");
    let (_, rhs) = joined.split_once(':').expect("rule has a colon");
    let mut v: Vec<String> = rhs.split_whitespace().map(str::to_string).collect();
    v.sort();
    v
}

#[test]
fn dash_m_writes_the_rule_to_stdout_and_compiles_nothing() {
    let dir = fixture("m-stdout");
    let out = run(&dir, &["-MM", "main.c"]);
    assert_eq!(out, "main.o: main.c a.h sub/deep.h b.h\n");
    // No object, no executable: `-M` / `-MM` stop after preprocessing.
    for stray in ["main.o", "a.out"] {
        assert!(
            !dir.join(stray).exists(),
            "-MM must not emit {stray}: {:?}",
            std::fs::read_dir(&dir).unwrap().count()
        );
    }
}

#[test]
fn dash_m_lists_system_headers_that_dash_mm_drops() {
    let dir = fixture("m-vs-mm");
    // badc's system set is its own header set plus the system
    // fallback directories. `-M` may add entries from it (the
    // auto-included builtins header when badc runs from its source
    // tree); `-MM` keeps only user headers, and never fewer.
    let m = prereqs(&run(&dir, &["-M", "main.c"]));
    let mm = prereqs(&run(&dir, &["-MM", "main.c"]));
    for p in &mm {
        assert!(m.contains(p), "-M must be a superset of -MM: {p} missing");
    }
    assert_eq!(
        mm,
        vec!["a.h", "b.h", "main.c", "sub/deep.h"]
            .into_iter()
            .map(str::to_string)
            .collect::<Vec<_>>()
    );
}

#[test]
fn dash_mt_is_verbatim_and_dash_mq_quotes_for_make() {
    let dir = fixture("mt-mq");
    assert!(run(&dir, &["-MM", "-MT", "my/target.o", "main.c"]).starts_with("my/target.o:"));
    assert!(run(&dir, &["-MM", "-MT", "a$b.o", "main.c"]).starts_with("a$b.o:"));
    assert!(run(&dir, &["-MM", "-MQ", "a$b.o", "main.c"]).starts_with("a$$b.o:"));
    // Both forms accumulate and share one colon.
    assert!(run(&dir, &["-MM", "-MT", "t1.o", "-MT", "t2.o", "main.c"]).starts_with("t1.o t2.o: "));
    assert!(
        run(&dir, &["-MM", "-MT", "t1.o", "-MQ", "t$2.o", "main.c"]).starts_with("t1.o t$$2.o: ")
    );
}

#[test]
fn dash_mp_adds_an_empty_rule_per_prerequisite_after_the_source() {
    let dir = fixture("mp");
    let out = run(&dir, &["-MM", "-MP", "main.c"]);
    assert_eq!(
        out,
        "main.o: main.c a.h sub/deep.h b.h\na.h:\nsub/deep.h:\nb.h:\n"
    );
    // A unit with no headers gets no phony block at all.
    write(&dir, "lone.c", "int lone;\n");
    assert_eq!(run(&dir, &["-MM", "-MP", "lone.c"]), "lone.o: lone.c\n");
}

#[test]
fn dash_mf_names_the_output_and_leaves_stdout_empty() {
    let dir = fixture("mf");
    assert_eq!(run(&dir, &["-MM", "-MF", "out1.d", "main.c"]), "");
    assert_eq!(read(&dir, "out1.d"), "main.o: main.c a.h sub/deep.h b.h\n");
    // `-M` / `-MM` also honour `-o` as the dependency output.
    assert_eq!(run(&dir, &["-MM", "-o", "out2.d", "main.c"]), "");
    assert_eq!(read(&dir, "out2.d"), "main.o: main.c a.h sub/deep.h b.h\n");
}

#[test]
fn dash_mmd_compiles_and_names_the_file_and_rule_after_the_object() {
    let dir = fixture("mmd");
    run(&dir, &["-q", "-c", "-MMD", "-o", "obj/main.o", "main.c"]);
    assert!(dir.join("obj/main.o").is_file(), "-MMD must still compile");
    assert_eq!(
        read(&dir, "obj/main.d"),
        "obj/main.o: main.c a.h sub/deep.h b.h\n"
    );
    // Without `-o` the file is the source base name in the current
    // directory and the rule takes the base-name default.
    run(&dir, &["-q", "-c", "-MMD", "main.c"]);
    assert_eq!(read(&dir, "main.d"), "main.o: main.c a.h sub/deep.h b.h\n");
    // `-MF` overrides the derived path, the rule name still from `-o`.
    run(
        &dir,
        &[
            "-q",
            "-c",
            "-MMD",
            "-MF",
            "custom.d",
            "-o",
            "obj/main.o",
            "main.c",
        ],
    );
    assert_eq!(
        read(&dir, "custom.d"),
        "obj/main.o: main.c a.h sub/deep.h b.h\n"
    );
}

/// `-E` produces a translation unit's expansion, which is enough for
/// `-MD` / `-MMD` to describe: gcc and clang preprocess and write the rule.
/// The dependency file is named as it is for a compile -- `-MF` and the
/// `-Wp,` payload first, else `-o` with a `.d` suffix, else the source base
/// name -- but `-o` names the preprocessed text here, not an object, so the
/// rule keeps gcc's default target rather than naming it.
#[test]
fn dash_e_writes_the_rule_and_preprocesses() {
    let dir = fixture("dumppp");
    let out = run(&dir, &["-q", "-E", "-Wp,-MMD,pp.d", "main.c", "-o", "pp.i"]);
    let text = read(&dir, "pp.i");
    assert!(text.contains("int main(void)"), "-E must expand: {text}");
    assert!(out.is_empty(), "-o takes the expansion off stdout: {out:?}");
    assert_eq!(read(&dir, "pp.d"), "main.o: main.c a.h sub/deep.h b.h\n");
    // `-o` with no `-MF` names the file, never the rule.
    run(&dir, &["-q", "-E", "-MMD", "main.c", "-o", "obj/pp.i"]);
    assert_eq!(
        read(&dir, "obj/pp.d"),
        "main.o: main.c a.h sub/deep.h b.h\n"
    );
    // Without `-o` the source base name does.
    run(&dir, &["-q", "-E", "-MMD", "main.c"]);
    assert_eq!(read(&dir, "main.d"), "main.o: main.c a.h sub/deep.h b.h\n");
}

/// Under `-E`, `-o` names the file the expansion is written to and `-o -`
/// names stdout, as in gcc 16.1.1 and clang; without `-o` it goes to
/// stdout. One output stream holds one expansion, so `-o` with several
/// sources is refused, which is what both of them do.
#[test]
fn dash_e_writes_the_expansion_to_the_o_operand() {
    let dir = fixture("dumppp-o");
    let streamed = run(&dir, &["-q", "-E", "main.c"]);
    assert!(streamed.contains("int main(void)"), "{streamed}");

    let out = run(&dir, &["-q", "-E", "main.c", "-o", "pp.i"]);
    assert!(out.is_empty(), "expansion stayed on stdout: {out:?}");
    assert_eq!(read(&dir, "pp.i"), streamed);

    // A `-` operand is the stream, not a file of that name.
    assert_eq!(run(&dir, &["-q", "-E", "main.c", "-o", "-"]), streamed);
    assert!(!dir.join("-").exists(), "`-o -` wrote a file named `-`");

    write(&dir, "other.c", "int other(void){return 1;}\n");
    let err = run_fail(&dir, &["-q", "-E", "main.c", "other.c", "-o", "both.i"]);
    assert!(err.contains("requires exactly one source input"), "{err}");
    assert!(!dir.join("both.i").exists(), "refused run wrote its output");
}

#[test]
fn wp_spellings_carry_the_path_and_keep_the_default_rule_name() {
    let dir = fixture("wp");
    // kbuild's form. As in gcc the payload reaches the preprocessor
    // directly, so `-o` does not name the rule.
    run(
        &dir,
        &["-q", "-c", "-Wp,-MMD,dep3.d", "-o", "obj/main.o", "main.c"],
    );
    assert!(
        dir.join("obj/main.o").is_file(),
        "-Wp,-MMD must still compile"
    );
    assert_eq!(read(&dir, "dep3.d"), "main.o: main.c a.h sub/deep.h b.h\n");
    // The kernel's dot-prefixed name works the same.
    run(
        &dir,
        &[
            "-q",
            "-c",
            "-Wp,-MMD,obj/.main.o.d",
            "-o",
            "obj/main.o",
            "main.c",
        ],
    );
    assert_eq!(
        read(&dir, "obj/.main.o.d"),
        "main.o: main.c a.h sub/deep.h b.h\n"
    );
    // An explicit `-MT` still wins over the default.
    run(
        &dir,
        &[
            "-q",
            "-c",
            "-Wp,-MMD,dep5.d",
            "-MT",
            "kernel/t.o",
            "-o",
            "obj/main.o",
            "main.c",
        ],
    );
    assert!(read(&dir, "dep5.d").starts_with("kernel/t.o: "));
    // `-Wp,-MD,` is the system-header-including spelling.
    run(
        &dir,
        &["-q", "-c", "-Wp,-MD,dep4.d", "-o", "obj/main.o", "main.c"],
    );
    let md = prereqs(&read(&dir, "dep4.d"));
    for p in ["main.c", "a.h", "b.h", "sub/deep.h"] {
        assert!(md.contains(&p.to_string()), "-Wp,-MD must list {p}");
    }
}

#[test]
fn long_prerequisite_lists_wrap_at_column_72() {
    let dir = fixture("wrap");
    // `T: w1.c haaaaaaa.h ` leaves the column at 18, so a 54-char
    // name lands exactly on 72 and stays while a 55-char one wraps.
    let h1 = "haaaaaaa.h";
    let fits = format!("{}.h", "b".repeat(52));
    let wraps = format!("{}.h", "b".repeat(53));
    for n in [h1, fits.as_str(), wraps.as_str()] {
        write(&dir, n, "int x;\n");
    }
    write(
        &dir,
        "w1.c",
        &format!("#include \"{h1}\"\n#include \"{fits}\"\n"),
    );
    write(
        &dir,
        "w2.c",
        &format!("#include \"{h1}\"\n#include \"{wraps}\"\n"),
    );
    assert_eq!(
        run(&dir, &["-MM", "-MT", "T", "w1.c"]),
        format!("T: w1.c {h1} {fits}\n")
    );
    assert_eq!(
        run(&dir, &["-MM", "-MT", "T", "w2.c"]),
        format!("T: w2.c {h1} \\\n {wraps}\n")
    );
    // A name longer than the bound sits alone rather than being split.
    let huge = format!("{}.h", "c".repeat(96));
    write(&dir, &huge, "int x;\n");
    write(&dir, "w3.c", &format!("#include \"{huge}\"\n"));
    assert_eq!(
        run(&dir, &["-MM", "-MT", "T", "w3.c"]),
        format!("T: w3.c \\\n {huge}\n")
    );
}

#[test]
fn a_missing_header_fails_the_run_and_writes_no_file() {
    let dir = fixture("missing");
    write(&dir, "bad.c", "#include \"nope.h\"\nint x;\n");
    let out = Command::new(badc())
        .args(["-MM", "-MF", "bad.d", "bad.c"])
        .current_dir(&dir)
        .output()
        .expect("spawn badc");
    assert!(!out.status.success(), "an unresolved include must fail");
    assert!(
        String::from_utf8_lossy(&out.stderr).contains("nope.h"),
        "the diagnostic must name the header"
    );
    assert!(
        !dir.join("bad.d").exists(),
        "no dependency file for a failed preprocess"
    );
}

#[test]
fn one_dependency_file_cannot_describe_several_units() {
    let dir = fixture("multi");
    write(&dir, "second.c", "int second;\n");
    let out = Command::new(badc())
        .args(["-c", "-MMD", "-MF", "one.d", "main.c", "second.c"])
        .current_dir(&dir)
        .output()
        .expect("spawn badc");
    assert!(
        !out.status.success(),
        "-MF with two sources must be refused"
    );
    // Without the shared file each unit names its own, which is fine.
    run(&dir, &["-q", "-c", "-MMD", "main.c", "second.c"]);
    assert_eq!(read(&dir, "main.d"), "main.o: main.c a.h sub/deep.h b.h\n");
    assert_eq!(read(&dir, "second.d"), "second.o: second.c\n");
}

#[test]
fn dep_output_is_refused_where_it_would_write_nothing() {
    let dir = fixture("no-tu-output");
    // `--ar` bundles objects rather than describing a compile, so
    // `-MMD` there must say so instead of being dropped.
    let out = Command::new(badc())
        .args(["--ar", "-MMD", "-o", "out.a", "main.c"])
        .current_dir(&dir)
        .output()
        .expect("spawn badc");
    assert!(!out.status.success(), "-MMD with --ar must be refused");
    assert!(
        String::from_utf8_lossy(&out.stderr).contains("--ar"),
        "the diagnostic must name the mode"
    );
    // `-M` still works there: it describes the source, not the output.
    assert_eq!(
        run(&dir, &["--ar", "-M" /* stdout */, "-MM", "main.c"]),
        "main.o: main.c a.h sub/deep.h b.h\n"
    );
}

#[test]
fn an_unsupported_wp_payload_is_rejected_rather_than_dropped() {
    let dir = fixture("wp-unknown");
    let out = Command::new(badc())
        .args(["-c", "-Wp,-fno-such-thing", "main.c"])
        .current_dir(&dir)
        .output()
        .expect("spawn badc");
    assert!(!out.status.success(), "an unknown -Wp, payload must fail");
    assert!(
        String::from_utf8_lossy(&out.stderr).contains("-fno-such-thing"),
        "the diagnostic must name the piece it does not implement"
    );
}

/// `-O` predefines `NDEBUG` and `__OPTIMIZE__` for the compile, so the
/// rule is computed under them too: conditional inclusion that tests
/// them names the header the compile reads.
#[test]
fn the_rule_is_computed_under_the_predefines_dash_o_implies() {
    let dir = fixture("dash-o");
    std::fs::create_dir_all(dir.join("inc")).expect("create inc dir");
    write(&dir, "inc/opt_only.h", "int opt_only;\n");
    write(&dir, "inc/dbg_only.h", "int dbg_only;\n");
    write(
        &dir,
        "dep.c",
        "#ifdef NDEBUG\n#include \"opt_only.h\"\n#else\n#include \"dbg_only.h\"\n#endif\n\
         int main(void){return 0;}\n",
    );
    let has = |v: &[String], n: &str| v.iter().any(|p| p == n);
    for flag in ["-M", "-MM"] {
        let opt = prereqs(&run(&dir, &["-O", flag, "-Iinc", "dep.c"]));
        assert!(has(&opt, "inc/opt_only.h"), "{flag} -O: {opt:?}");
        assert!(!has(&opt, "inc/dbg_only.h"), "{flag} -O: {opt:?}");
        let dbg = prereqs(&run(&dir, &[flag, "-Iinc", "dep.c"]));
        assert!(has(&dbg, "inc/dbg_only.h"), "{flag}: {dbg:?}");
        assert!(!has(&dbg, "inc/opt_only.h"), "{flag}: {dbg:?}");
    }
}

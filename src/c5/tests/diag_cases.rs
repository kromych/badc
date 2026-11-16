//! Diagnostic case files under `tests/fixtures/diag/`. A file is a prelude
//! followed by cases, each opened by `//== <name>: <verdict>`. A verdict is
//! `ok`, or `error <selector>` / `warning <selector>`. Each case is compiled
//! after the prelude on every target: `ok` reports no error or warning, and
//! the others report the named diagnostic at that level.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use crate::c5::diag::{Code, Level};
use crate::{CompileOptions, Compiler, Target};

struct Case<'a> {
    name: &'a str,
    expect: Option<(Level, Code)>,
    body: String,
}

fn cases(text: &str) -> (String, Vec<Case<'_>>) {
    let mut parts = text.split("\n//== ");
    let prelude = String::from(parts.next().unwrap_or_default());
    let cases = parts
        .map(|part| {
            let (head, body) = part.split_once('\n').unwrap_or((part, ""));
            // A checkout may end the file's lines with CR LF.
            let head = head.trim_end_matches('\r');
            let (name, verdict) = head.split_once(": ").expect("`<name>: <verdict>`");
            let expect = match verdict.split_once(' ') {
                None if verdict == "ok" => None,
                Some((level, sel)) => {
                    let level = match level {
                        "error" => Level::Error,
                        "warning" => Level::Warning,
                        other => panic!("{name}: level `{other}`"),
                    };
                    let code =
                        Code::from_selector(sel).unwrap_or_else(|| panic!("{name}: `{sel}`"));
                    Some((level, code))
                }
                _ => panic!("{name}: verdict `{verdict}`"),
            };
            let body = format!("#line {}\n{body}", line_of(text, part));
            Case { name, expect, body }
        })
        .collect();
    (prelude, cases)
}

/// The source line a case's body starts on, so a diagnostic names it.
fn line_of(text: &str, part: &str) -> usize {
    let offset = part.as_ptr() as usize - text.as_ptr() as usize;
    text[..offset].lines().count() + 1
}

/// Every case's mismatch with its verdict, on every target.
fn check(text: &str) -> Vec<String> {
    let (prelude, cases) = cases(text);
    let mut failures = Vec::new();
    for target in Target::ALL {
        for case in &cases {
            let src = format!("{prelude}{}", case.body);
            let opts = CompileOptions::default().with_no_entry_point(true);
            let reported: Vec<(Level, Code)> =
                match Compiler::with_options(src, target, opts).compile() {
                    Ok(program) => program.warnings.iter().map(|d| (d.level, d.code)).collect(),
                    Err(e) => e.diagnostics().iter().map(|d| (d.level, d.code)).collect(),
                };
            let relevant = |l: &Level| matches!(l, Level::Error | Level::Warning);
            let fine = match case.expect {
                None => !reported.iter().any(|(l, _)| relevant(l)),
                Some(want) => reported.contains(&want),
            };
            if !fine {
                failures.push(format!(
                    "{target:?} {}: expected {:?}, reported {reported:?}",
                    case.name, case.expect
                ));
            }
        }
    }
    failures
}

/// C17 6.3.2.1p1, 6.5.16p2 and 6.5.16.1p1 over const-qualified objects,
/// members, pointers and the library and builtin interfaces that write.
#[test]
fn const_qualifier_cases() {
    let failures = check(include_str!(
        "../../../tests/fixtures/diag/const_qualifier.c"
    ));
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

/// A checkout that ends the lines with CR LF reads the same cases.
#[test]
fn case_files_parse_alike_with_crlf_line_ends() {
    let lf = include_str!("../../../tests/fixtures/diag/const_qualifier.c").replace("\r\n", "\n");
    let crlf = lf.replace('\n', "\r\n");
    let heads = |text: &str| -> Vec<(String, Option<(Level, Code)>)> {
        cases(text)
            .1
            .iter()
            .map(|c| (String::from(c.name), c.expect))
            .collect()
    };
    assert_eq!(heads(&lf), heads(&crlf));
}

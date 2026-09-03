use alloc::collections::BTreeSet;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::*;

fn code(selector: &str) -> Code {
    Code::from_selector(selector).expect("catalogue row")
}

#[test]
fn codes_are_unique() {
    let mut seen = BTreeSet::new();
    for row in rows() {
        assert!(seen.insert(row.code.value()), "duplicate {}", row.code);
    }
}

#[test]
fn names_and_aliases_are_unique() {
    let mut seen = BTreeSet::new();
    for row in rows() {
        assert!(seen.insert(row.name), "duplicate name `{}`", row.name);
        for alias in row.aliases {
            assert!(seen.insert(alias), "duplicate alias `{alias}`");
        }
    }
}

#[test]
fn only_a_controllable_row_carries_groups() {
    for row in rows().filter(|r| r.class != Class::Controllable) {
        assert!(row.groups.is_empty(), "{} is not controllable", row.code);
    }
}

#[test]
fn a_row_only_a_group_turns_on_defaults_to_ignore() {
    for row in rows() {
        if !row.groups.is_empty() && !row.groups.contains(Groups::DEFAULT) {
            assert_eq!(row.default_level, Level::Ignore, "{}", row.code);
        }
    }
}

#[test]
fn selectors_resolve_by_name_alias_and_code() {
    let unknown_argument = code("unknown-argument");
    assert_eq!(unknown_argument.value(), 7001);
    // The MSVC identifier for the same diagnostic.
    assert_eq!(Code::from_selector("D9002"), Some(unknown_argument));
    // The gcc option that covers the diagnostic pragma.
    assert_eq!(
        Code::from_selector("pragmas"),
        Some(code("unknown-warning-option"))
    );
    assert_eq!(Code::from_selector("B7001"), Some(unknown_argument));
    for row in rows() {
        assert_eq!(
            Code::from_selector(&format!("{}", row.code)),
            Some(row.code)
        );
        assert_eq!(Code::from_selector(row.name), Some(row.code));
    }
}

#[test]
fn unknown_selectors_resolve_to_nothing() {
    assert_eq!(Code::from_selector("no-such-diagnostic"), None);
    assert_eq!(Code::from_selector("B9999"), None);
    assert_eq!(Code::from_selector("B71"), None);
    assert_eq!(Code::from_selector("7001"), None);
    // An MSVC number no row claims stays unknown, as it does today.
    assert_eq!(Code::from_msvc_number(4101), None);
}

#[test]
fn a_retired_row_is_accepted_and_changes_nothing() {
    for row in rows().filter(|r| r.status == Status::Retired) {
        assert_eq!(Code::from_selector(row.name), Some(row.code));
        let mut config = Config::new();
        config.set_level(row.code, Level::Error);
        config.error_for(row.code, true);
        assert_eq!(config.level(row.code), Level::Ignore, "{}", row.code);
    }
    for row in rows().filter(|r| r.status == Status::Live && r.class == Class::Controllable) {
        let mut config = Config::new();
        config.set_level(row.code, Level::Error);
        assert_eq!(config.level(row.code), Level::Error, "{}", row.code);
    }
}

#[test]
fn a_group_selector_raises_its_rows_only() {
    for (group, name) in Groups::SELECTABLE {
        assert_eq!(Groups::from_selector(name), Some(group));
        let mut config = Config::new();
        config.enable_group(group);
        for row in rows() {
            let expected = if row.class == Class::Controllable && row.groups.contains(group) {
                row.default_level.max(Level::Warning)
            } else {
                row.default_level
            };
            assert_eq!(config.level(row.code), expected, "{name} {}", row.code);
        }
    }
    assert_eq!(Groups::from_selector("default"), None);
}

#[test]
fn command_line_levels_resolve_in_order() {
    let unused = code("unused-command-line-argument");
    let dropped = code("link-pragma-ignored");
    let hard = code("unknown-argument");

    let mut config = Config::new();
    assert_eq!(config.level(unused), Level::Ignore);
    assert_eq!(config.level(dropped), Level::Warning);

    config.enable_group(Groups::ALL);
    assert_eq!(config.level(unused), Level::Warning);
    config.set_level(unused, Level::Ignore);
    assert_eq!(config.level(unused), Level::Ignore);

    // `-w` silences a warning and leaves an error alone.
    let mut config = Config::new();
    config.inhibit_warnings(true);
    assert_eq!(config.level(dropped), Level::Ignore);
    assert_eq!(config.level(hard), Level::Error);

    // `-Werror`, and `-Wno-error=<sel>` exempting one row from it.
    let mut config = Config::new();
    config.warnings_as_errors(true);
    assert_eq!(config.level(dropped), Level::Error);
    config.error_for(dropped, false);
    assert_eq!(config.level(dropped), Level::Warning);

    // `-Werror=<sel>` enables the diagnostic as well as raising it.
    let mut config = Config::new();
    config.error_for(unused, true);
    assert_eq!(config.level(unused), Level::Error);

    // `-Wno-error=<sel>` lowers a controllable error so its site continues.
    let lowerable = code("unsupported-option");
    let mut config = Config::new();
    assert_eq!(config.level(lowerable), Level::Error);
    config.error_for(lowerable, false);
    assert_eq!(config.level(lowerable), Level::Warning);
    config.set_level(lowerable, Level::Ignore);
    assert_eq!(config.level(lowerable), Level::Ignore);
}

#[test]
fn no_option_moves_an_uncontrollable_row() {
    for row in rows().filter(|r| r.class != Class::Controllable) {
        let mut config = Config::new();
        config.set_level(row.code, Level::Ignore);
        config.inhibit_warnings(true);
        config.warnings_as_errors(true);
        config.error_for(row.code, false);
        config.enable_group(Groups::ALL);
        assert_eq!(config.level(row.code), row.default_level, "{}", row.code);
    }
}

#[test]
fn a_selector_names_a_group_or_a_diagnostic() {
    assert_eq!(
        Selector::parse("extra"),
        Some(Selector::Group(Groups::EXTRA))
    );
    assert_eq!(
        Selector::parse("B7001"),
        Some(Selector::Diagnostic(code("unknown-argument")))
    );
    assert_eq!(Selector::parse("no-such-thing"), None);
}

#[test]
fn pragmas_resolve_by_position() {
    let warned = code("link-pragma-ignored");
    let base = Config::new().level(warned);

    let mut control = Control::new();
    assert!(control.is_empty());
    control.set_level(100, warned, Level::Ignore);
    control.set_level(300, warned, Level::Error);
    control.reset(500, warned);
    assert!(!control.is_empty());

    assert_eq!(control.level_at(warned, 50, base), Level::Warning);
    assert_eq!(control.level_at(warned, 100, base), Level::Ignore);
    assert_eq!(control.level_at(warned, 299, base), Level::Ignore);
    assert_eq!(control.level_at(warned, 300, base), Level::Error);
    assert_eq!(control.level_at(warned, 499, base), Level::Error);
    // `reset` hands the position back to the command line.
    assert_eq!(control.level_at(warned, 500, base), Level::Warning);
}

#[test]
fn push_and_pop_restore_the_enclosing_level() {
    let warned = code("link-pragma-ignored");
    let base = Config::new().level(warned);

    let mut control = Control::new();
    control.push();
    control.set_level(10, warned, Level::Ignore);
    control.push();
    control.set_level(20, warned, Level::Error);
    assert!(control.pop(30));
    assert!(control.pop(40));
    assert!(!control.pop(50));

    assert_eq!(control.level_at(warned, 5, base), Level::Warning);
    assert_eq!(control.level_at(warned, 10, base), Level::Ignore);
    assert_eq!(control.level_at(warned, 20, base), Level::Error);
    assert_eq!(control.level_at(warned, 30, base), Level::Ignore);
    // The outermost pop restores what the command line left.
    assert_eq!(control.level_at(warned, 40, base), Level::Warning);
}

#[test]
fn suppress_covers_one_line_and_once_reports_one_diagnostic() {
    let warned = code("link-pragma-ignored");
    let base = Config::new().level(warned);

    let mut control = Control::new();
    control.suppress((100, 140), warned);
    assert_eq!(control.level_at(warned, 99, base), Level::Warning);
    assert_eq!(control.level_at(warned, 100, base), Level::Ignore);
    assert_eq!(control.level_at(warned, 139, base), Level::Ignore);
    assert_eq!(control.level_at(warned, 140, base), Level::Warning);

    let mut control = Control::new();
    control.report_once(200, warned);
    assert!(!control.is_once(warned, 199));
    assert!(control.is_once(warned, 200));

    let mut sink = Sink::new(Config::new(), control);
    let at = |offset| Some(Loc::in_unit("a.c", 1, offset));
    assert_eq!(sink.emit(warned, at(100), "before"), Level::Warning);
    assert_eq!(sink.emit(warned, at(210), "first"), Level::Warning);
    assert_eq!(sink.emit(warned, at(220), "second"), Level::Ignore);
    assert_eq!(sink.diagnostics().len(), 2);
}

#[test]
fn the_sink_drops_ignored_counts_errors_and_reports_only_errors() {
    let warned = code("link-pragma-ignored");
    let lowerable = code("unsupported-option");

    let mut config = Config::new();
    config.set_level(warned, Level::Ignore);
    let mut sink = Sink::new(config, Control::new());
    assert_eq!(sink.emit(warned, None, "dropped"), Level::Ignore);
    assert!(sink.diagnostics().is_empty());

    let mut config = Config::new();
    config.warnings_as_errors(true);
    let mut sink = Sink::new(config, Control::new());
    // A raised warning is counted, not unwound.
    assert_eq!(sink.emit(warned, None, "raised"), Level::Error);
    assert!(sink.has_errors());
    assert_eq!(sink.errors(), 1);

    let mut sink = Sink::new(Config::new(), Control::new());
    assert!(sink.report(lowerable, None, "declined").is_err());
    let mut config = Config::new();
    config.error_for(lowerable, false);
    let mut sink = Sink::new(config, Control::new());
    assert!(sink.report(lowerable, None, "declined").is_ok());
    assert_eq!(sink.take().len(), 1);
    assert!(sink.diagnostics().is_empty());
}

#[test]
fn a_pragma_overrides_the_command_line_at_its_position() {
    let warned = code("link-pragma-ignored");
    let mut config = Config::new();
    config.warnings_as_errors(true);
    let mut control = Control::new();
    control.set_level(64, warned, Level::Ignore);

    let mut sink = Sink::new(config, control);
    assert_eq!(
        sink.emit(warned, Some(Loc::in_unit("a.c", 3, 10)), "before"),
        Level::Error
    );
    assert_eq!(
        sink.emit(warned, Some(Loc::in_unit("a.c", 9, 70)), "after"),
        Level::Ignore
    );
    // A location with no unit position takes the command line alone.
    assert_eq!(
        sink.emit(warned, Some(Loc::new("a.c", 9)), "no position"),
        Level::Error
    );
}

fn render(diagnostic: &Diagnostic, color: bool) -> String {
    let mut out = String::new();
    diagnostic.render(&mut out, color).unwrap();
    out
}

#[test]
fn a_controllable_diagnostic_ends_with_the_gcc_option_tail() {
    let warned = code("link-pragma-ignored");
    let line = render(
        &Diagnostic::new(
            warned,
            Level::Warning,
            Some(Loc::new("a.c", 12)),
            "pragma dropped",
        ),
        false,
    );
    assert_eq!(
        line,
        "a.c:12: warning: pragma dropped [B7008] [-Wlink-pragma-ignored]"
    );
    assert!(line.ends_with("[-Wlink-pragma-ignored]"));

    let hard = code("unknown-argument");
    assert_eq!(
        render(
            &Diagnostic::new(hard, Level::Error, Some(Loc::new("a.c", 1)), "bad option"),
            false
        ),
        "a.c:1: error: bad option [B7001]"
    );
    // A link-time diagnostic carries no position.
    assert_eq!(
        render(
            &Diagnostic::new(code("no-input-files"), Level::Error, None, "no files"),
            false
        ),
        "error: no files [B7004]"
    );
    // A note prints its word from the class, not from the level.
    assert_eq!(
        render(
            &Diagnostic::new(
                code("cross-target-output"),
                Level::Warning,
                None,
                "runs elsewhere"
            ),
            false
        ),
        "note: runs elsewhere [B7009]"
    );
}

#[test]
fn notes_follow_the_diagnostic_they_hang_off() {
    let diagnostic = Diagnostic::new(
        code("link-pragma-ignored"),
        Level::Warning,
        Some(Loc::new("a.c", 12)),
        "pragma dropped",
    )
    .with_note(Some(Loc::new("a.h", 3)), "declared here")
    .with_note(None, "and once without a position");
    assert_eq!(
        render(&diagnostic, false),
        "a.c:12: warning: pragma dropped [B7008] [-Wlink-pragma-ignored]\n\
         a.h:3: note: declared here\n\
         note: and once without a position"
    );
}

#[test]
fn color_keys_on_the_level() {
    let warning = render(
        &Diagnostic::new(
            code("link-pragma-ignored"),
            Level::Warning,
            Some(Loc::new("a.c", 12)),
            "text",
        ),
        true,
    );
    assert_eq!(
        warning,
        "a.c:12: \x1b[1;33mwarning:\x1b[0m text [B7008] [-Wlink-pragma-ignored]"
    );
    let error = render(
        &Diagnostic::new(code("unknown-argument"), Level::Error, None, "text"),
        true,
    );
    assert_eq!(error, "\x1b[1;31merror:\x1b[0m text [B7001]");
}

#[test]
fn the_catalogue_matches_its_golden() {
    let mut rendered = String::new();
    list_catalog(&mut rendered).unwrap();
    let golden = include_str!("../../../tests/diagnostics/catalog.txt");
    assert_eq!(
        rendered, golden,
        "tests/diagnostics/catalog.txt is stale -- regenerate it with \
         `cargo run --features full --bin badc -- --list-diagnostics > \
         tests/diagnostics/catalog.txt` and review the diff"
    );
}

#[test]
fn explain_prints_one_row() {
    let mut out = String::new();
    explain(&mut out, code("unknown-argument")).unwrap();
    let lines: Vec<&str> = out.lines().collect();
    assert_eq!(lines[0], "B7001 unknown-argument");
    assert!(lines.iter().any(|l| l.contains("aliases      D9002")));
}

# Contributing to badc

A pull request is merged when it fixes a cause rather than a symptom, follows a
rule a reader can check, carries a test that fails without it, and states what
was run to verify it. This page lists what that takes.

## Contents

- [Before you start](#before-you-start)
- [What a change looks like](#what-a-change-looks-like)
- [Tests](#tests)
- [Checks before opening a pull request](#checks-before-opening-a-pull-request)
- [Commits and the pull request](#commits-and-the-pull-request)
- [AI-assisted contributions](#ai-assisted-contributions)
- [License](#license)

## Before you start

- Find the issue, or open one with a reduced repro. Say on the issue that you
  are working on it.
- Work lands first on the current `debt/release-*` branch and reaches `master`
  when the release is merged. Check that branch for a fix to the same issue
  before you start: a pull request that duplicates one is closed.
- Ask on the issue before choosing between gcc, clang and MSVC behavior, or
  before changing a default or whether a diagnostic is on.

## What a change looks like

- Each change follows a rule: a C standard clause, the platform ABI, or the documented
  behavior of gcc, clang, MSVC, GNU ld or GNU as. Name the rule in the pull
  request.
- Find the cause first. Decide whether the bug is a narrow case or a gap in the
  design, and fix it at that level. Rewriting output after the fact, or a
  special case for one program, is not a fix.
- Code, comments and test names describe the construct and the rule. They do
  not name the projects badc builds; `demos/` and `scripts/` may.
- Comments are short and precise: no tutorials, no editorializing, at most one
  comment line per ten lines of code.
- Match the naming and idioms of the surrounding code.

## Tests

- Every bug fix and feature adds a regression test that fails without the
  change and passes with it. Check both before opening the pull request.
- Register the test where it runs on the targets the change affects. The
  fixture tables are in `src/c5/tests/fixture_tables.rs`: `NATIVE_FIXTURES`
  (macOS), `NATIVE_ELF_FIXTURES` and `NATIVE_ELF_X64_FIXTURES` (Linux),
  `NATIVE_PE_X64_FIXTURES` and `NATIVE_PE_ARM64_FIXTURES` (Windows), and
  `JIT_FIXTURES`. A Windows fix tested only on Linux is not tested.
- Expected values come from a reference compiler (gcc, clang, or MSVC on
  Windows), not from badc's own output.
- Cover the rule, not only the reported case: the other flags, widths, types,
  narrow and wide forms, and every target the rule applies to.
- A code generation change shows up in `tests/snapshots/`. Regenerate with
  `python3 scripts/snapshots.py`, read the diff, and commit it with the change.

[Testing](doc/testing.md) describes the suites and fixtures in detail.

## Checks before opening a pull request

Use the current stable Rust (`rustup update stable`). CI uses `stable`, and a
newer clippy has failed changes that passed with an older one.

```sh
cargo fmt --all -- --check
cargo clippy --all-targets -- -D warnings
cargo clippy --all-targets --features full -- -D warnings
cargo build --locked --no-default-features --lib
python3 scripts/cargo_test.py --features full
python3 scripts/cargo_test.py --release --features full
python3 scripts/snapshots.py --check
```

A change to one platform's code (the Windows C library, a backend, an object
format) is run natively on that platform: Windows changes on x64 and, if you
can, on arm64. Write down what you could not run.

CI runs on every pull request. For a first-time contributor it starts after a
maintainer approves it, and it costs money: a pull request without the results
of these checks waits. Before every push to a release branch, the maintainers
also run the full gate on Linux x86_64 and aarch64, Windows x64 and arm64, and
macOS.

## Commits and the pull request

- Commit subject: `<subsystem>: <what badc does now>`, for example
  `parser: a parameter named like its function no longer takes over the
  function's declarator`. The body gives the cause and the fix and ends with
  `Fixes: #N`.
- One topic per pull request, against `master`.
- Fill in the pull request template: the issue, the cause, the fix, the test,
  the checks with their test counts, and the platforms. Report only what you
  ran.

## AI-assisted contributions

You may use AI tools. You are responsible for every line: read it, understand
it, run the checks yourself, and report only results you saw. A pull request
whose description claims checks that were not run is closed.

## License

Contributions are accepted under the [MIT license](LICENSE).

<!-- Read CONTRIBUTING.md first. Fill in every section; write "not run"
     instead of deleting a line. -->

## Issue

Fixes #

## Cause

<!-- What in badc produced the wrong behavior (file:line), and whether it is
     a narrow case or a design gap. -->

## Fix

<!-- The rule the change follows (C17 clause, platform ABI, gcc / clang /
     MSVC / GNU ld / GNU as behavior) and where badc now applies it. -->

## Regression test

- Test or fixture:
- Registered in (table or suite) and the targets it runs on:
- Fails without the change: yes / no
- Expected values measured with (compiler, version, platform):

## Checks

Host OS and architecture:
`rustc --version`:

- [ ] `cargo fmt --all -- --check`
- [ ] `cargo clippy --all-targets -- -D warnings`
- [ ] `cargo clippy --all-targets --features full -- -D warnings`
- [ ] `cargo build --locked --no-default-features --lib`
- [ ] `python3 scripts/cargo_test.py --features full`, passed / announced:
- [ ] `python3 scripts/cargo_test.py --release --features full`, passed / announced:
- [ ] `python3 scripts/snapshots.py --check`, or the snapshot diff is in this pull request
- [ ] Run natively on every platform the change affects:

## Not run

<!-- Every check above you did not run, and why. -->

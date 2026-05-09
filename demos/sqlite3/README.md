# sqlite3 demo

End-to-end exercise of badc against the upstream SQLite
amalgamation: download the tarball, build the combined
`sqlite3.c + shell.c` translation unit, and run a smoke test
against in-memory and file-backed databases.

The amalgamation itself is **not committed**: it's 9 MB of
auto-generated C, and tracking it would balloon the repo on
every upstream bump. Instead `setup.sh` fetches a pinned
release from `sqlite.org` and drops the four files in this
directory, after which they behave like a regular vendored
copy until the next `setup.sh`.

## Files

| File             | Tracked? | Purpose                                                                              |
|------------------|:--------:|--------------------------------------------------------------------------------------|
| `setup.sh`       | yes      | Fetch + extract the amalgamation. Idempotent.                                        |
| `smoke.sh`       | yes      | Build with badc + run the in-memory and file-backed scenarios. Returns 0 on success. |
| `sqlite3.c`      | no       | Amalgamation. Produced by `setup.sh`.                                                |
| `sqlite3.h`      | no       | Same.                                                                                |
| `sqlite3ext.h`   | no       | Same.                                                                                |
| `shell.c`        | no       | CLI source. Produced by `setup.sh`.                                                  |
| `.cache/`        | no       | Cached amalgamation tarball + extracted vanilla copy.                                |

## Workflow

```sh
demos/sqlite3/setup.sh   # fetches into demos/sqlite3/
demos/sqlite3/smoke.sh   # builds + runs in-memory + file-backed scenarios
```

`smoke.sh` returns 0 with `smoke OK: in-memory + file-backed
both green` when everything passes; on a regression it prints a
diff against the expected output and returns 1.

## CI

The same scripts run unchanged from `.github/workflows/ci.yml`
on every supported runner (`ubuntu-latest`, `ubuntu-24.04-arm`,
`macos-latest`, `windows-latest`, `windows-11-arm`) after the
regular cargo test step.

## Bumping SQLite

1. Update `VERSION` in `setup.sh` to the new release.
2. Run `setup.sh -v` followed by `smoke.sh`.

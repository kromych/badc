# sqlite3 demo

End-to-end exercise of badc against the upstream SQLite
amalgamation: download the tarball, build the combined
`sqlite3.c + shell.c` translation unit, and run a smoke test
against in-memory and file-backed databases.

The amalgamation itself is **not committed**: it's 9 MB of
auto-generated C, and tracking it would balloon the repo on
every upstream bump. Instead `setup.py` fetches a pinned
release from `sqlite.org` and drops the four files in this
directory, after which they behave like a regular vendored
copy until the next `setup.py`.

## Files

| File             | Tracked? | Purpose                                                                              |
|------------------|:--------:|--------------------------------------------------------------------------------------|
| `setup.py`       | yes      | Fetch + extract the amalgamation. Idempotent.                                        |
| `smoke.py`       | yes      | Build with badc + run the in-memory and file-backed scenarios. Returns 0 on success. |
| `sqlite3.c`      | no       | Amalgamation. Produced by `setup.py`.                                                |
| `sqlite3.h`      | no       | Same.                                                                                |
| `sqlite3ext.h`   | no       | Same.                                                                                |
| `shell.c`        | no       | CLI source. Produced by `setup.py`.                                                  |
| `.cache/`        | no       | Cached amalgamation tarball + extracted vanilla copy.                                |

## Workflow

```sh
python demos/sqlite3/setup.py   # fetches into demos/sqlite3/
python demos/sqlite3/smoke.py   # builds + runs in-memory + file-backed scenarios
```

`smoke.py` returns 0 with `smoke OK: in-memory + file-backed
both green` when everything passes; on a regression it prints a
unified diff against the expected output and returns 1.

`smoke.py` honours `BADC=path/to/badc` if you want a debug or
custom-built binary instead of `target/release/badc`.

## CI

The same scripts run unchanged from `.github/workflows/ci.yml`
on every supported runner (`ubuntu-latest`, `ubuntu-24.04-arm`,
`macos-latest`, `windows-latest`, `windows-11-arm`) after the
regular cargo test step. The workflow uses
`actions/setup-python@v5` so `python` resolves to the same
3.x interpreter on every lane.

## Bumping SQLite

1. Update `VERSION` in `setup.py` to the new release.
2. Run `python setup.py -v` followed by `python smoke.py`.

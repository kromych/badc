# sqlite3 demo

End-to-end exercise of badc against the upstream SQLite
amalgamation: download the tarball, apply our patch series,
build the combined `sqlite3.c + shell.c` translation unit, and
run a smoke test against in-memory and file-backed databases.

The amalgamation itself is **not committed**: it's 9 MB of
auto-generated C, and tracking it would balloon the repo on
every upstream bump. Instead `setup.sh` fetches a pinned
release from `sqlite.org`, drops the four files in this
directory, and applies the patches in `patches/` -- after
which the four `.c` / `.h` files behave like a regular vendored
copy until the next `setup.sh`.

## Files

| File                  | Tracked? | Purpose                                                       |
|-----------------------|:--------:|---------------------------------------------------------------|
| `setup.sh`            | yes      | Fetch + extract + patch the amalgamation. Idempotent.         |
| `smoke.sh`            | yes      | Build with badc + run the in-memory and file-backed scenarios. Returns 0 on success. |
| `patches/*.patch`     | yes      | Patch series applied against the upstream sources. Each one carries its own `badc/c5 patch:` rationale comment in-source. |
| `sqlite3.c`           | no       | Patched amalgamation. Produced by `setup.sh`.                 |
| `sqlite3.h`           | no       | Same.                                                         |
| `sqlite3ext.h`        | no       | Same.                                                         |
| `shell.c`             | no       | Patched CLI source. Produced by `setup.sh`.                   |
| `.cache/`             | no       | Cached amalgamation tarball + extracted vanilla copy.         |

## Workflow

```sh
# One-time / after a c5 / codegen change you want to verify.
demos/sqlite3/setup.sh          # fetches + patches into demos/sqlite3/
demos/sqlite3/smoke.sh          # builds + runs in-memory + file-backed scenarios
```

`smoke.sh` returns 0 with `smoke OK: in-memory + file-backed
both green` when everything passes; on a regression it prints a
diff against the expected output and returns 1.

## CI

The same scripts run unchanged from `.github/workflows/ci.yml`
on the linux-x64 / linux-arm64 / macos-arm64 runners after the
regular cargo test step. A patch that misses an offset (because
upstream renumbered something around it) breaks `setup.sh` and
shows up as a red CI lane immediately.

## Bumping SQLite

1. Update `VERSION` in `setup.sh` to the new release.
2. Run `setup.sh -v` locally; if any patch fails, the failing
   hunk's filename and offset get printed.
3. Re-create the failing patch by editing the freshly-extracted
   source to apply the same fix at the new location, then
   regenerate via `diff -u .cache/sqlite-amalgamation-<version>/foo.c foo.c > patches/foo.c.patch` and normalize the
   path prefixes (`a/` for the vanilla path, `b/` for ours).
4. Re-run `setup.sh` followed by `smoke.sh` until both succeed.

## Patches

Each patch in `patches/` is a unified-diff against the upstream
release. The current set:

* `sqlite3.c.patch`
  - `SZ_VDBECURSOR` macro: drop the `ROUND8` wrap so the
    cursor-size arithmetic stays inside u32 range when c5 widens
    `sizeof(u64)` to 8 bytes.
  - Expand the `(i8)`-cast big-endian decoders (`ONE_BYTE_INT`,
    `TWO_BYTE_INT`, `THREE_BYTE_INT`, `FOUR_BYTE_INT`) to use a
    `<< 56 >> N` shift idiom. c5 collapses `signed char` onto
    `int`, so `(i8)b` is a no-op for sign extension.
  - `fillInUnixFile` finder dispatch: rewrite
    `(**(finder_type*)pVfs->pAppData)(...)` as a temp +
    single-deref call so c5 doesn't take the wrong codegen path
    for "double-deref of a function pointer that returns a
    struct pointer."
* `shell.c.patch`
  - Replace the `#define sqlite3_vfprintf vfprintf` shortcut
    with a c5-safe wrapper that routes through
    `sqlite3_vmprintf` (c5 `va_list` differs from the platform
    libc's).
  - Comment out `atexit(sayAbnormalExit)`: the libc atexit
    chain calls back into c5-compiled code on shutdown, which
    isn't yet safe.

# lua demo

End-to-end exercise of badc against the upstream Lua 5.5.0
interpreter and its official test suite. `setup.py` fetches the
release tarball plus the matching test suite, `smoke.py` builds
the interpreter with badc at both `-O0` and `-O`, and runs a
curated subset of the test scripts against each lane.

The source distribution is **not committed**: `setup.py` pulls a
pinned mirror from the `kromych/badc` vendor-deps release and
verifies a sha256 before extracting under `demos/lua/src/`.

## Files

| File         | Tracked? | Purpose                                                                              |
|--------------|:--------:|--------------------------------------------------------------------------------------|
| `setup.py`   | yes      | Fetch + extract the source and the test suite tarballs. Idempotent.                  |
| `smoke.py`   | yes      | Build the interpreter with badc + run the curated test subset. Returns 0 on success. |
| `src/*`      | no       | Lua interpreter sources from `www.lua.org/ftp/`. Produced by `setup.py`.             |
| `tests/*`    | no       | Lua test scripts from `www.lua.org/tests/`. Produced by `setup.py`.                  |
| `.cache/`    | no       | Cached tarballs.                                                                     |

## Workflow

```sh
python demos/lua/setup.py        # fetches sources + tests
python demos/lua/smoke.py        # builds + runs the test subset
```

`smoke.py` returns 0 with `smoke OK [no-O]: 19 scripts green` /
`smoke OK [-O]: 19 scripts green` when both lanes pass. On a
regression it names the failing script, prints the last few
output lines, and returns 1.

`smoke.py` honours `BADC=path/to/badc` if you want a debug or
custom-built binary instead of `target/release/badc`.

## Selected tests

24 of the upstream test scripts that exit 0 under
`_port=true; _nomsg=true`. The build threads
`LUA_USER_H='"ltests.h"'` into every TU and links
`tests/ltests/ltests.c` so the `T` internal-testing library
is registered on every state, which is what the `api`, `gc`,
`gengc`, `memerr`, and `tracegc` scripts assert against.

| Script           | Coverage                                                  |
|------------------|-----------------------------------------------------------|
| `api.lua`        | `T` internal API: stack manip, raw object access, GC peek |
| `bitwise.lua`    | shift / and / or / xor / not at full 64-bit width         |
| `calls.lua`      | call semantics, `__call`, tail calls, binary chunks       |
| `closure.lua`    | upvalues, GC interaction, closure equality                |
| `constructs.lua` | parser corner cases, statement layout                     |
| `coroutine.lua`  | `coroutine.create` / `resume` / `yield` / `wrap`          |
| `cstack.lua`     | recursion depth, error overflow handling                  |
| `errors.lua`     | `pcall` / `xpcall`, tokenised error messages              |
| `events.lua`     | metatables, `__add` / `__index` / friends                 |
| `gc.lua`         | incremental GC sweeps + finalisers under `T` step control |
| `gengc.lua`      | generational GC mode + minor/major cycle accounting       |
| `goto.lua`       | block-scope `goto`, global declarations                   |
| `literals.lua`   | integer / hex / float / string escape coverage            |
| `locals.lua`     | to-be-closed variables, scope nesting                     |
| `math.lua`       | `math.huge`, integer boundaries, rounding, `random`       |
| `memerr.lua`     | allocation-failure injection at every internal mem site   |
| `nextvar.lua`    | numeric for, generic for, table iteration                 |
| `pm.lua`         | pattern matching (`string.match` / `gmatch` / `gsub`)     |
| `sort.lua`       | `table.sort`, `table.move`                                |
| `strings.lua`    | `string.format`, `string.pack` / `unpack`                 |
| `tpack.lua`      | binary pack / unpack across alignment shapes              |
| `tracegc.lua`    | per-step GC tracing via `T.tracegc`                       |
| `utf8.lua`       | `utf8.char` / `utf8.len` / `utf8.offset`                  |
| `vararg.lua`     | `...` propagation, `table.pack` / `unpack`                |

Scripts outside this set are excluded for the reasons below;
re-adding any of them is the natural follow-up once badc grows
the missing surface:

- `attrib.lua`, `main.lua` -- shell out (`os.execute`) and load
  compiled C extensions through `package.loadlib`. The dynamic-
  link surface c5 ships today doesn't cover the upstream test
  helpers under `tests/libs/`.
- `big.lua`, `heavy.lua`, `verybig.lua` -- 100 MB+ allocations
  intended for soak runs; too slow for a per-PR smoke.
- `db.lua` -- exercises `debug.sethook` line-counting at a
  granularity that depends on the upstream VM's instruction
  layout.
- `code.lua` -- introspects the compiled bytecode; only
  meaningful under the upstream VM lowering.

## CI

The same scripts run unchanged from `.github/workflows/ci.yml`
on every supported runner (`ubuntu-latest`, `ubuntu-24.04-arm`,
`macos-latest`, `windows-latest`, `windows-11-arm`) after the
existing demo smokes. `actions/setup-python@v5` pins `python` to
the same 3.x interpreter on every lane.

Gating policy: macOS and the two Linux lanes are strict. The
two Windows lanes adopt the chibicc / tinycc convention --
`smoke.py` exits 2 when the build is green but specific tests
fail, and the workflow accepts that exit (`|| test $? -eq 2`)
while still failing on a real build error (exit 1).

### Known Windows-only test failures (TODO)

Each script that currently fails on a Windows runner is listed
below with the line, the assertion, and the upstream cause.
The c5 compiler builds the Lua interpreter cleanly on both
Windows lanes and the `setjmp` / `longjmp` round-trip fixture
in `tests/fixtures/c/setjmp_longjmp_roundtrip.c` passes through
the cargo `native_pe_x64` / `native_pe_arm64` lanes -- the
remaining failures are msvcrt-runtime divergences that need to
be reproduced on real Windows hardware to drive down.

| Script           | Line | Lane          | Upstream cause                                              |
|------------------|-----:|---------------|-------------------------------------------------------------|
| `math.lua`       | 692  | x64, aarch64  | msvcrt `ldexp` / `frexp` boundary differs from libm         |
| `cstack.lua`     | --   | x64, aarch64  | msvcrt's recursion-limit / SEH stack-probe policy           |
| `constructs.lua` | 83   | aarch64       | `load(code)` returning a function whose call asserts        |
| `strings.lua`    | 140  | aarch64       | `tostring(float)` formatting through msvcrt printf          |

## Bumping Lua

1. Update `VERSION`, `SRC_UPSTREAM_SHA`, `TESTS_UPSTREAM_SHA` in
   `setup.py` (and the matching constants in
   `scripts/vendor_deps/build_bundle.py`).
2. Run `python scripts/vendor_deps/build_bundle.py -v`, upload
   the new tarballs to the `vendor-deps-v1` release, refresh
   `manifest.json`.
3. Run `python setup.py -v` followed by `python smoke.py`.

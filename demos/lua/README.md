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

The curated subset is the set of upstream test scripts that exit
0 with `_port=true; _nomsg=true` against an upstream-built Lua
and only exercise the C99-shaped subset of the standard library:

| Script         | Coverage                                                       |
|----------------|----------------------------------------------------------------|
| `bitwise.lua`  | shift / and / or / xor / not at full 64-bit width              |
| `calls.lua`    | call semantics, `__call`, tail calls, binary chunks            |
| `closure.lua`  | upvalues, GC interaction, closure equality                     |
| `constructs.lua` | parser corner cases, statement layout                        |
| `coroutine.lua`  | `coroutine.create` / `resume` / `yield` / `wrap`             |
| `cstack.lua`   | recursion depth, error overflow handling                       |
| `errors.lua`   | `pcall` / `xpcall`, tokenised error messages                   |
| `events.lua`   | metatables, `__add` / `__index` / friends                      |
| `goto.lua`     | block-scope `goto`, global declarations                        |
| `literals.lua` | integer / hex / float / string escape coverage                 |
| `locals.lua`   | to-be-closed variables, scope nesting                          |
| `math.lua`     | `math.huge`, integer boundaries, rounding, `random`            |
| `nextvar.lua`  | numeric for, generic for, table iteration                      |
| `pm.lua`       | pattern matching (`string.match` / `gmatch` / `gsub`)          |
| `sort.lua`     | `table.sort`, `table.move`                                     |
| `strings.lua`  | `string.format`, `string.pack` / `unpack`                      |
| `tpack.lua`    | binary pack / unpack across alignment shapes                   |
| `utf8.lua`     | `utf8.char` / `utf8.len` / `utf8.offset`                       |
| `vararg.lua`   | `...` propagation, `table.pack` / `unpack`                     |

Scripts outside this set are excluded for the reasons below;
re-adding any of them is the natural follow-up once badc grows
the missing surface:

- `api.lua`, `gc.lua`, `gengc.lua`, `memerr.lua`, `tracegc.lua`
  -- depend on the `T` library compiled from `ltests.c` with
  `LUA_USER_H='"ltests.h"'`. The demo would need to bundle
  `ltests.c` as a TU and define the symbol.
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

## Bumping Lua

1. Update `VERSION`, `SRC_UPSTREAM_SHA`, `TESTS_UPSTREAM_SHA` in
   `setup.py` (and the matching constants in
   `scripts/vendor_deps/build_bundle.py`).
2. Run `python scripts/vendor_deps/build_bundle.py -v`, upload
   the new tarballs to the `vendor-deps-v1` release, refresh
   `manifest.json`.
3. Run `python setup.py -v` followed by `python smoke.py`.

# quickjs demo

Compiles Fabrice Bellard's [QuickJS](https://github.com/bellard/quickjs)
JavaScript engine with badc and runs QuickJS's own test suite through the
resulting `qjs` CLI.

## Layout

- `setup.py` -- fetches the pinned upstream archive (bellard/quickjs commit
  `3d5e064e`, dated 2026-06-04) from the badc vendor-deps mirror and
  extracts the engine translation units, `qjs.c`, `qjsc.c`, `repl.js`,
  their headers, and the JS tests. The source is gitignored; only the
  files below are committed.
- `repl_stub.c` -- an empty `qjsc_repl` bytecode blob. The smoke links the
  real blob (see below); this stub is what `bench.py` and the perf fixture
  under `tests/perf/` link instead, neither of which enters the REPL.
- `smoke.py` -- builds `qjsc` and `qjs` and runs the test suite.
- `bench.py` -- builds the engine with each compiler at each optimization
  level and runs `tests/microbench.js` through every binary.

## Running

```
python3 demos/quickjs/setup.py     # fetch the source (needs a GitHub token while the repo is private)
python3 demos/quickjs/smoke.py     # build qjsc + qjs, run the tests
python3 demos/quickjs/bench.py     # badc vs clang, -O0 and -O
```

The smoke compiles the upstream source unmodified -- no patch.
`DIRECT_DISPATCH` (computed-goto opcode dispatch), `CONFIG_ATOMICS` and
`CONFIG_STACK_CHECK` are left at their upstream defaults, which enable
them on every supported host. `CONFIG_ALL_UNICODE` is enabled on top of
the upstream default: it compiles libunicode's normalization tables and
the Unicode-aware `String.prototype.normalize` / `localeCompare`.

## Test coverage

- The pure-JS tests: `test_closure`, `test_language`, `test_loop`,
  `test_bigint`, `test_cyclic_import`, `test_std`, `test_worker`,
  `test_rw_handler`, and `test_builtin` (with `--std`).
- The two native-module tests, `test_bjson` and `test_point`: each module
  is built as a badc shared object that the CLI dlopens, resolving the
  module's references to the engine API against the executable's exported
  symbols.
- The REPL: `qjsc` compiles `repl.js` to the bytecode blob `qjs` links and
  evaluates in interactive mode, so the bytecode writer and reader are
  both exercised on real input.
- A standalone program compiled to bytecode with `qjsc -e`, linked against
  the engine and checked on its output.
- Unicode normalization and collation, reachable only under
  `CONFIG_ALL_UNICODE`.

Windows is skipped. The engine itself is target-clean -- `quickjs.c`
compiles for `windows-x64` and `windows-arm64` -- but `quickjs-libc`'s OS
layer needs surface badc does not provide for Windows targets. Stubbing
each in turn walks the chain: `_putenv` (quickjs-libc.c:774), then the
POSIX directory API (`DIR` at quickjs-libc.c:2744; `<dirent.h>` is
entirely `#ifndef _WIN32`), then `struct _utimbuf` (quickjs-libc.c:2910;
badc keeps it in `<sys/utime.h>`, which `<utime.h>` does not pull in).

`HAVE_CLOSEFROM` follows the target: badc's `<unistd.h>` declares
`closefrom` on the Linux targets, where glibc 2.34 and later export it,
and nowhere else -- neither libSystem nor msvcrt has the function.
Upstream gates the same define on a compile probe, so this matches what
upstream would detect.

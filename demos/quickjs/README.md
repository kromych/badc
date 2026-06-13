# quickjs demo

Compiles Fabrice Bellard's [QuickJS](https://github.com/bellard/quickjs)
JavaScript engine with badc and runs QuickJS's own pure-JS test suite
through the resulting `qjs` CLI.

## Layout

- `setup.py` -- fetches the pinned upstream archive (bellard/quickjs commit
  `3d5e064e`, dated 2026-06-04) from the badc vendor-deps mirror and
  extracts the eight `qjs` translation units, their headers, and the
  pure-JS tests. The source is gitignored; only the files below are
  committed.
- `repl_stub.c` -- supplies an empty `qjsc_repl` bytecode blob. Upstream
  generates it from `repl.js` with the `qjsc` bytecode compiler at build
  time; the smoke runs the test suite through the C interpreter and never
  enters the REPL, so an empty blob satisfies the link.
- `smoke.py` -- builds `qjs` from the eight TUs and runs the test suite.

## Running

```
python3 demos/quickjs/setup.py     # fetch the source (needs a GitHub token while the repo is private)
python3 demos/quickjs/smoke.py     # build qjs + run the tests
```

The smoke compiles the upstream source unmodified -- no patch. The
computed-goto opcode dispatch (`DIRECT_DISPATCH`) and `CONFIG_ATOMICS` are
left at their upstream defaults.

## Test coverage

The smoke runs the pure-JS tests: `test_closure`, `test_language`,
`test_loop`, `test_bigint`, `test_cyclic_import`, `test_std`,
`test_worker`, `test_rw_handler`, and `test_builtin` (with `--std`).

The two native-module tests (`test_bjson`, `test_point`) need a runtime
`dlopen` of a badc-built shared object, which is not yet supported, so they
are outside this set. Windows is skipped: QuickJS's `quickjs-libc` OS layer
targets a POSIX host.

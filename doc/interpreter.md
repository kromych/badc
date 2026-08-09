# `--interp`: the safety-net VM

`--interp` runs the program through the SSA interpreter instead of compiling
to native:

```sh
$ badc --interp hello.c

Hello 123
exit(0)
```

The VM keeps code, stack, and data in three distinct address ranges and refuses
to mix them. Function pointers carry a `CODE_BASE` bias; loading or storing
through one is rejected, and so is calling through a fabricated integer (`fp =
42; fp();`) -- the call site refuses an address it did not originate.

`--track-pointers` opts in to allocation tracking. With it on, `free` on an
unknown or already-freed pointer errors, and any access into a freed allocation
(or past the end of a live one) is reported with the offending allocation's id.
`--trace` opts in to a per-instruction trace on stdout (off by default -- it is
noisy).

Native and JIT modes skip this safety net by design. Use `--interp` when you
want the watchful version, especially while debugging memory-shape issues.

The interpreter is also the reference the native backends are checked against:
the fixture suites run each program under the VM and under every backend and
compare exit codes, so a codegen divergence shows up as a mismatch rather than
as a silent wrong answer. See [testing](testing.md).

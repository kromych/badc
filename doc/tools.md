# Tools

Helper programs for working on badc. None of them is part of the compiler or
needed to build it.

## `tools/`

| path | what it does |
|---|---|
| `gen_isa.py` | generates the x86-64 encoder table `src/c5/codegen/x86_64/isa_x86_table.rs` from asmjit's `isa_x86.json` |
| `gen_isa_a64.py` | generates the AArch64 encoder table `src/c5/codegen/aarch64/isa_a64_table.rs` from asmjit's `isa_aarch64.json` |
| `gen_sysreg_a64.py` | generates the AArch64 system-register and system-operation tables by disassembling every selector with a reference assembler |
| `scaling_probe.py` | measures how compile time grows with input size, one generated input shape at a time |
| `core-walker.py` | names the frames of a Linux x86-64 core dump when a debugger cannot |
| `diff_vorbis/` | traces `stb_vorbis.c` built by clang and by badc and diffs the traces, to find the first function whose behavior differs |
| `probe_asm_units/` | passes each preprocessed `.S` unit through badc's file-scope `asm` path and ranks the first diagnostics |

The generated tables are checked in, so the generators run only when a table
changes.

`core-walker.py` walks the saved-`rbp` chain of a core dump and reports each
saved return address as a file offset in the original non-PIE binary, whose
load base it takes as `0x400000`:

* with no option, it walks the `rbp` chain;
* `--dump-around-rbp` prints the sixteen 8-byte slots around `rbp`;
* `--scan-stack` ignores the chain and resolves every 8-byte slot above `rsp`
  that looks like a code address, which finds return addresses when stack
  corruption has broken the chain;
* `--list-segments` lists each `PT_LOAD` segment with its address range.

`probe_asm_units/` measures the assembler alone, with no code model and no
dependency output. [The kernel page](linux-kernel.md) has the build's own
figures.

## `scripts/`

The scripts used most:

| script | what it does |
|---|---|
| `cargo_test.py` | runs `cargo test` and also fails a test binary that stops before reporting every test |
| `snapshots.py` | regenerates `tests/snapshots/`; `--check` fails on any difference |
| `coverage.py` | line and function coverage of `src/` under the test suite |
| `csmith_fuzz.py`, `c_reduce.py` | differential fuzzing with csmith, and reduction of a failing case |
| `run_demos.py` | runs demo smoke tests concurrently |
| `compile_throughput.py` | compile-time ratios over a fixed corpus, checked against ceilings |
| `diagnostics_doc.py` | writes [diagnostics](diagnostics.md) from the diagnostic catalog |
| `install_hooks.py`, `validate_local_boxes.py` | the git hooks and the pre-push gate |
| `perf_publish.py` | files a benchmark run in the data repository the performance page reads |

[Testing](testing.md) describes how they fit together.

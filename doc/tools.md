# Tools

Small analysis helpers under [`tools/`](../tools/). They are debugging aids,
not part of the compiler.

## `core-walker.py`

Walks the saved-rbp chain in a Linux ELF core dump and reports each frame's
saved return address as a file offset into the original non-PIE x64 binary
(load base fixed at `0x400000`). Useful for naming the crashing function when a
higher-level debugger path is blocked.

* default: walk the rbp chain, resolve each frame's saved return address.
* `--dump-around-rbp`: print the 16 8-byte slots around `rbp`.
* `--scan-stack`: ignore the rbp chain, scan upward from `rsp` for any 8-byte
  slot that looks like a code address, and resolve each. Useful when stack
  corruption broke the rbp chain -- the actual return addresses are usually
  still on the stack, just no longer reachable through the saved-rbp links.
* `--list-segments`: list every PT_LOAD in the core file with its vaddr range.
  Useful for understanding where the stack and the emulator's mappings ended up
  after a corruption.

## `probe_asm_units/`

Measures badc's assembler surface against real `.S` units: it feeds each
preprocessed unit through badc's file-scope `asm` path and records the first
diagnostic per unit, then tallies and ranks them. It is a measurement of the
assembler, not a proposed driver design -- badc has no standalone assembler
driver, and `.S` units in the [kernel work](linux-kernel.md) still go to gas.

## `scripts/`

`scripts/snapshots.py` regenerates the assembly and SSA snapshots under
`tests/snapshots/`. `scripts/validate_local_boxes.py` runs the pre-push set on
the local boxes, and `scripts/install_hooks.py` wires the git hooks; see
[testing](testing.md).

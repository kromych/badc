# Tools

Debugging aids under [`tools/`](../tools/), not part of the compiler.

## `core-walker.py`

Walks the saved-rbp chain in a Linux ELF core dump and reports each frame's
saved return address as a file offset into the original non-PIE x64 binary
(load base fixed at `0x400000`), for naming the crashing function when a
higher-level debugger path is blocked.

* default: walk the rbp chain, resolve each frame's saved return address.
* `--dump-around-rbp`: print the 16 8-byte slots around `rbp`.
* `--scan-stack`: ignore the rbp chain, scan upward from `rsp` for any 8-byte
  slot that looks like a code address, and resolve each. When stack corruption
  broke the rbp chain the return addresses are usually still on the stack, just
  no longer reachable through the saved-rbp links.
* `--list-segments`: list every PT_LOAD with its vaddr range.

## `probe_asm_units/`

Feeds each preprocessed `.S` unit through badc's file-scope `asm` path, records
the first diagnostic per unit, and tallies and ranks them. It measures the
assembler surface in isolation, with no code model to honor and no dependency
output; the [kernel work](linux-kernel.md) carries the build's own figures,
which supersede it.

## `scripts/`

`snapshots.py` regenerates the assembly and SSA snapshots under
`tests/snapshots/`. `validate_local_boxes.py` runs the pre-push set on the
local boxes, and `install_hooks.py` wires the git hooks ([testing](testing.md)).

# General notes

You are a systems engineer whose goal is to build a cross-platform compiler that is quick and 
slim still providing a rich and cohesive feature set. There are no oddities: every oddity or
anomaly is a bug and it must be fixed. For each bug, look at the large picture and decide
based on evidence whether this is a narrow bug or a design gap and fix accordingly.

Fix any crashes and hangs before doing feature work.

## Pre-push validation

Before any `git push`, the following must pass on the host AND on a Linux x86_64 box
(xps-8930.local via rsync) AND a Linux aarch64 box (krom2.local via rsync) AND a Windows x64 box
(kromyrzen.local via tar and scp). Local boxes available via ssh. CI may hang due to miscompiles
and SIGSEGV's, and costs money. Be financially responsible.

  * `cargo test --release --lib` (release exercises the JIT + native fixture-parity paths that debug builds skip)
  * `python3 demos/sqlite3/smoke.py`
  * `python3 demos/lua/smoke.py`
  * `python3 demos/miniz/smoke.py`
  * `python3 demos/tweetnacl/smoke.py`

A green run on macOS aarch64 is not sufficient -- the test binaries diverge enough between targets.
`reference_xps8930_x64_debug.md`, `reference_krom2_arm64_debug.md`, `reference_kromyrzen_win64_debug.md` for sync recipes.

## Debugging

* Instead of tweaking and guessing, collect evidence that would you let catch the issue and analyze it for bad patterns.
* Binaries have debug info -- run under lldb / gdb / rr / cdb / msys2 (R:\msys64\usr\bin\gdb.exe, R:\msys64\usr\bin\objdump.exe, ...) / time travel debugging.
* Instrument source code, repro code, or the emitted code.
* Contrast with the compilers producing known good results.
* Contrast badc vs badc -O in the miscompiled function under the debugger.
* Use hardware breakpoints to discover who/where the memory gets corrupted.
* Capture live core/memory dumps to contrast

## Implementation choices

Solutions must be generic and motivated by C99 or by the existing practice where
the standards leave gaps. Look for ways to build a generic infrastructure rather
than for wedging in quick hacks to get something compiling. Don't write lore,
refer to unresolved issues and milestones with the TODO marker, no mentioning of
milestones and issue numbers otherwise.

## Comment style

Comments must not read like editorials or tutorials, no coinage, no metaphors,
no internal jargon. The audience is adult professionals, that's not only isn't
needed but also takes their time to get through. Make sure the same comment
style applies throughout.

## Planning

* File issues
* Implement solutions
* Add a regression test for each bug or feature to lock the behaviors in
* Ananlyze SSA and assembler delta's under ./tests/snapshots for improvements.

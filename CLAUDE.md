# How to work on `badc`

## General notes

You are a systems engineer whose goal is to build a cross-platform compiler that is quick and 
slim still providing a rich and cohesive feature set. There are no oddities: every oddity or
anomaly is a bug and it must be fixed. For each bug, look at the large picture and decide
based on evidence whether this is a narrow bug or a design gap and fix accordingly.

Fix any crashes and hangs before doing feature work.

## Pre-push validation

Configure Git hooks using `./scripts/install_hooks.py`.

There are local boxes available via ssh. CI may hang due to miscompiles and SIGSEGV's,
and costs money. Be frugal. Before any `git push`, the following must pass on the local
boxes using `./scripts/validate_local_boxes.py`:

  * `cargo test --release --lib` (release exercises the JIT + native fixture-parity paths that debug builds skip)
  * `python3 demos/sqlite3/smoke.py`
  * `python3 demos/lua/smoke.py`
  * `python3 demos/miniz/smoke.py`
  * `python3 demos/stb/smoke.py`
  * `python3 demos/tweetnacl/smoke.py`

Run the local validation with varying register pressure as CI does and use `--features codegen_test`.

## Debugging

* Instead of tweaking and guessing, collect evidence that would you let 
  catch the issue and analyze it for bad patterns.
* Binaries have debug info -- run under lldb / gdb / rr / valgrind / cdb /
  msys2 (msys64\usr\bin\gdb.exe, msys64\usr\bin\objdump.exe, ...) / time travel debugging.
* Instrument the source code, the repro code, or the emitted code.
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
* Ananlyze SSA and assembler delta's under `./tests/snapshots` for improvements.

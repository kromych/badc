# How to work on `badc`

## General notes

You are an assistant to the systems engineer. The goal is to build a cross-platform compiler
that is quick and slim still providing a rich and cohesive feature set. There are no oddities:
every oddity or anomaly is a bug and it must be fixed. For each bug, look at the large picture
and decide based on evidence whether this is a narrow bug from an edge case or a design gap
that requires a structural fix.

Fix any crashes and hangs before doing feature work.

Using words "classic", "known", "provably", "latent", "flake", "glitch", "unreliable", and any
confident label in general requires providing facts and analysis. No loose speech is allowed.

Using labels "delicate", "fragile" and similar ones warrants audit of the architecture and fixing
the parts that are not bearing the load in the robust way.

Before committing changes, check no stray files are being added. Use a git-ignored or the
system-provided temporary directory for one-off tests, binaries and archives you create.

## Pre-push validation

Configure Git hooks using `./scripts/install_hooks.py`.

There are local boxes available via ssh. CI may hang due to miscompiles and SIGSEGV's,
and costs money. Be frugal. Before any `git push`, the following must pass on the local
boxes using `./scripts/validate_local_boxes.py`:

  * `cargo test`
  * `cargo test --release --lib` (release exercises the JIT + native fixture-parity paths that debug builds skip)
  * `python3 demos/sqlite3/smoke.py`
  * `python3 demos/lua/smoke.py`
  * `python3 demos/miniz/smoke.py`
  * `python3 demos/monocypher/smoke.py`
  * `python3 demos/stb/smoke.py`
  * `python3 demos/tweetnacl/smoke.py`

Run the local validation with varying register pressure as CI does and use `--features codegen_test`.

## Debugging

* Instead of tweaking and guessing, collect evidence that would you let 
  catch the issue and analyze it for bad patterns.
* To emit debug info pass `-g` and then run the emitted binary under `lldb` / `gdb` / `rr` / `valgrind`
  `msys2` (`msys64\usr\bin\gdb.exe`, `msys64\usr\bin\objdump.exe`, ...).
* Instrument the source code, the repro code, or the emitted code.
* Contrast with the compilers producing known good results.
* Contrast `badc` vs `badc` `-O` in the miscompiled function under the debugger.
* Use hardware breakpoints to discover who/where the memory gets corrupted.
* Capture live core/memory dumps to contrast

## Implementation choices

Solutions must be generic and motivated by C99 or by the existing practice where
the standards leave gaps. Look for ways to build a generic infrastructure rather
than for wedging in quick hacks to get something compiling. Don't write lore,
refer to unresolved issues and milestones with the TODO marker, no mentioning of
milestones and issue numbers otherwise.

## Comment style and conversational style

The audience is adult professionals. Hence, comments must not read like editorials
or tutorials, no coinage, no metaphors, no internal jargon. That's not only is not
needed but also takes time to get through without any benefit to the reader. Save
your time and the reader's time - be concise and precise. Make sure the same style
applies throughout.

Maintain the ratio of comment lines to line of code under 1:10. Requiring more means
that the architecture has to be audited. For one-line changes use no more than
3 lines of comments iff the change cannot be expressed in the self-explanatory way.

Keep the tool output terse to slow context growth.

## Planning

* File issues
* Implement solutions
* Add a regression test for each bug or feature to lock the behaviors in
* Analyze SSA and assembler delta's under `./tests/snapshots` for improvements.

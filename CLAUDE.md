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

CI may hang due to miscompiles and SIGSEGVs, and costs money. Be frugal. Before any
`git push`, `./scripts/validate_local_boxes.py` must pass on the local boxes and the
macOS host; configure the Git hooks with `./scripts/install_hooks.py`. The local
boxes -- Linux x86_64, Linux aarch64, Windows x64 and Windows arm64 -- are ssh git
remotes of the host repo, named after their lanes; no box name belongs in this file
or in a skill. What the gate runs and how to run it is the `pre-push-validation`
skill, which describes the script and is updated with it; setting up or repairing a
box is the `local-boxes` skill.

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
* Reproducing and reducing a miscompile: the `miscompile-triage` skill.

## Implementation choices

Solutions must be generic and motivated by C99 or by the existing practice where
the standards leave gaps. Look for ways to build a generic infrastructure rather
than for wedging in quick hacks to get something compiling. Don't write lore,
refer to unresolved issues and milestones with the TODO marker, no mentioning of
milestones and issue numbers otherwise.

Code, comments, test names and test comments describe the construct and the rule
that governs it: a C99 clause, the platform ABI, or the documented behavior of gcc,
clang, GNU ld or gas. They do not name the projects badc builds (the Linux kernel,
CPython, sqlite, edk2, ...) or their files, macros, configuration options and build
steps: that reads as a patch aimed at one program. Platform references stay: the OS
interfaces (Linux UAPI and syscall layouts, the loader, Windows DLLs) and the
`kernel` code model. A commit body may cite a project only as measured evidence;
`demos/` and `scripts/` are about the projects and are exempt.

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

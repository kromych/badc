---
name: miscompile-triage
description: Reproducing, reducing and root-causing a badc miscompile or compiler crash -- from a csmith fuzz finding, a failing demo or kernel unit, or a wrong-output report -- with the stored fuzz cases, the UB-guarded interestingness test, creduce/cvise, SSA dumps, -O0 versus -O, and unit bisection in the kernel build. Use whenever a program compiled by badc behaves differently from gcc or clang, or badc crashes or hangs.
---

# Miscompile triage

Collect evidence before changing anything (CLAUDE.md, Debugging). A reduction is
worth something only if the reduced program is free of undefined behavior; the
guard below is what kept every past reduction a real defect.

## Reproduce

- Fuzz findings: the weekly csmith issue names the seed, configuration and
  architecture. Reproduce on that architecture. The stored cases are the
  `fuzz-cases-v1` release: `gh release download fuzz-cases-v1 --dir <scratch>`. A
  local csmith (Homebrew's 2.3.0) does not regenerate CI's seeds.
- Contrast with the reference compilers (gcc and clang at -O0 and -O2), and badc
  `-O0` against `-O`: a difference only under `-O` points at a pass, one at both at
  lowering or the backend.
- `badc -o /dev/null` fails on macOS (the output is code-signed); write to a scratch
  path or use `-c`.

## Reduce

Interestingness test (`scripts/csmith_fuzz.py --reduce-minutes N` writes it):

- reference: `clang -O0 -Werror=return-type -Werror=uninitialized
  -fsanitize=undefined,address -fno-sanitize=alignment -fno-sanitize-recover=all`.
  `-fno-sanitize=alignment` because csmith programs take the addresses of packed
  members;
- the reference agrees with clang `-O2`, and with `-ftrivial-auto-var-init=pattern`
  and `=zero` (an unguarded reduction walks into uninitialized reads);
- badc's output differs from the reference.

Reduce with creduce (macOS, Homebrew) or cvise (the Linux x86_64 box). csmith's
headers: Homebrew's `include/csmith-2.3.0` on the Mac, a copy outside `/usr/include`
on Linux, since the devel package's `windows/stdint.h` must not shadow the system's.
The harness keys a runtime verdict by (verdict, configuration, architecture) only,
so one weekly issue holds one miscompile per class; the job summary lists the
repeat seeds.

## Root-cause

- `--dump-ssa` prints the lifted SSA and the allocator's output per function before
  emission; compare it between `-O0` and `-O`, and before and after a suspect pass.
- `-g` and a debugger on the emitted program (lldb, gdb, rr, valgrind; msys2's gdb
  and objdump on Windows), hardware watchpoints for a corrupted location, core dumps
  to contrast a good and a bad run.
- Kernel units: `$BADC_FALLBACK` names units to build with the reference compiler,
  for bisecting which unit is miscompiled (demos/linux/README.md); the manifest
  records each as `fallback`, so a bisect build cannot pass for a pure one.

## After the cause is known

Decide from the evidence whether it is an edge case or a design gap (CLAUDE.md). The
regression test asserts on the emitted SSA or on program behavior, never on a
host-compiler parity fixture, and the fix's commit cites the reduced program.

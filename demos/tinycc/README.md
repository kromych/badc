# tinycc

Fabrice Bellard's TCC vendored as a real cross-platform exerciser
for badc: multi-TU compile + link of the tcc-the-binary sources
against badc's supported targets (x86_64 + aarch64 across ELF /
Mach-O / PE), followed by a self-host fixed point once every TU
compiles.

Source is pinned at the upstream `mob` branch HEAD
(2026-05-13, `757507e`). The last release tag (`release_0_9_27`,
2017) predates years of PE / AArch64 / Mach-O fixes that the
cross-platform self-host requires, so the bringup follows `mob`
the same way distros do. Pulled through the badc vendor-deps
mirror -- see [`setup.py`](setup.py).

## Vendored surface

A multi-TU build of tcc-the-binary against the targets badc
supports. Backends and output-formats outside that scope are
dropped to keep the surface focused:

* **Core (every host)** -- `tcc.c`, `libtcc.c`, `tccpp.c`,
  `tccgen.c`, `tccelf.c`, `tccasm.c`, `tccdbg.c`, `tccrun.c`,
  `tcctools.c`.
* **Backend (x86_64 host)** -- `x86_64-gen.c`,
  `x86_64-link.c`, `i386-asm.c` (the inline-assembly path
  `TCC_TARGET_X86_64` still routes through).
* **Backend (aarch64 host)** -- `arm64-gen.c`, `arm64-link.c`,
  `arm64-asm.c`.
* **Output format** -- `tccpe.c` (Windows), `tccmacho.c`
  (macOS); ELF is the default and is handled by `tccelf.c`.
* **Headers** -- `tcc.h`, `libtcc.h`, the `*-tok.h` /
  `*-asm.h` token tables, and upstream's internal copies of
  `elf.h`, `coff.h`, `dwarf.h`, `stab.h`, `stab.def`.

Dropped: `i386-gen.c` / `i386-link.c` (32-bit x86 -- not a
badc target), `arm-*.c` (32-bit ARM -- not a badc target),
`riscv64-*.c`, `c67-*.c` / `tcccoff.c` (TI C67), `il-*.c`
(orphaned IL backend). `ONE_SOURCE` is deliberately NOT
defined so each `.c` is its own TU -- that is exactly the
shape that exercises badc's cross-TU linker.

`include/` carries tinycc's shipped system headers (`float.h`,
`stdarg.h`, `stdatomic.h`, `tccdefs.h`, ...). They are not
needed to compile tcc-the-binary; they are the headers tcc
exposes to programs it later compiles, and the self-host stage
points the produced tcc at them.

## Bringup status

The vendored set is in place; per-gap issues are tracked off
the umbrella tracker. The smoke records but does not gate on
known blockers and flips a TU to a hard regression once it has
been marked green.

Probe state on macOS aarch64 (1 of 13 TUs green; each remaining
TU has its own well-scoped gap issue):

| TU              | Status   | Blocker                            |
|-----------------|----------|------------------------------------|
| `tcc.h`         | parses   |                                    |
| `arm64-gen.c`   | green    |                                    |
| `arm64-link.c`  | blocked  | `##` paste re-scan                 |
| `arm64-asm.c`   | blocked  | `__FUNCTION__`                     |
| `tcc.c`         | blocked  | `va_copy`                          |
| `libtcc.c`      | blocked  | `va_copy`                          |
| `tccpp.c`       | blocked  | `va_copy`                          |
| `tccgen.c`      | blocked  | `##` paste re-scan                 |
| `tccelf.c`      | blocked  | `##` paste re-scan                 |
| `tccmacho.c`    | blocked  | `##` paste re-scan                 |
| `tccasm.c`      | blocked  | `strtoull` libc binding            |
| `tccdbg.c`      | blocked  | `sizeof ((T*)0)->m`                |
| `tccrun.c`      | blocked  | extern in function body            |
| `tcctools.c`    | blocked  | `fdopen` libc binding              |
| `tccpe.c`       | blocked  | (not active on macOS host)         |
| `x86_64-gen.c`  | blocked  | (not active on macOS host)         |
| `x86_64-link.c` | blocked  | (not active on macOS host)         |
| `i386-asm.c`    | blocked  | (not active on macOS host)         |

Already-closed gaps that the bringup surfaced:

* `<inttypes.h>` ships (PRI / SCN format macros over `<stdint.h>`).
* `__attribute__` / `__declspec` absorbed as empty fn macros.
* `<unistd.h>` exposes `ssize_t` / `size_t` / `off_t` / `pid_t` /
  `uid_t` / `gid_t` per POSIX-2017 by pulling in `<sys/types.h>`
  (which itself pulls in `<stddef.h>` for `size_t`).
* `<setjmp.h>` ships with per-platform `libc::setjmp` /
  `libc::longjmp` bindings; runtime correctness of the
  `jmp_buf` array typedef is gated on a separate c5 fix.

## config.h

Upstream's `./configure` writes a `config.h` that picks the
target, output format, and search paths. The smoke harness
synthesizes a minimal `config.h` per host instead -- it does
not invoke `configure` -- selecting macros from this table:

| Host                | Target macros                                  |
|---------------------|------------------------------------------------|
| Linux x86_64        | `TCC_TARGET_X86_64`                            |
| Linux aarch64       | `TCC_TARGET_ARM64`                             |
| macOS aarch64       | `TCC_TARGET_ARM64`, `TCC_TARGET_MACHO`         |
| Windows x86_64      | `TCC_TARGET_X86_64`, `TCC_TARGET_PE`           |
| Windows aarch64     | `TCC_TARGET_ARM64`, `TCC_TARGET_PE`            |

`CONFIG_TCC_SYSINCLUDEPATHS` / `CONFIG_TCC_LIBPATHS` /
`CONFIG_TCC_ELFINTERP` are left undefined; the produced tcc
binary needs them at runtime, not at compile time, and the
self-host stage supplies them via CLI flags when it runs.

The synthesized `config.h` also forces `CONFIG_TCC_SEMLOCK 0`:
the upstream default pulls in `<dispatch/dispatch.h>` on macOS,
`<semaphore.h>` on Linux, and `CRITICAL_SECTION` on Windows --
none of which c5 ships today. tinycc uses the lock only to
serialize libtcc state across threads; the bringup compile +
self-host fixed point is single-threaded, so the lock is dead
weight here.

## Layout

* `setup.py` -- fetch the source tarball from the vendor-deps
  release; idempotent. Drops the curated set of `.c` / `.h`
  files flat into the demo dir, and the shipped system headers
  under `include/`.
* `smoke.py` -- build-only smoke harness. Synthesizes
  `config.h` for the host, walks each TU through `badc -c`,
  tracks per-TU compile state, exits 0 when every TU compiles
  cleanly and the multi-TU link emits a working tcc binary.
* `self_host.py` -- (follow-up) parity check: builds tcc with
  both the system cc and badc, runs each on a curated sample
  suite, asserts behaviour parity. Wired once every TU is
  green.
* `tcc.c`, `tcc.h`, ..., `include/*.h` -- vendored upstream
  sources (gitignored out of band; `setup.py` is the source of
  truth for what they are).

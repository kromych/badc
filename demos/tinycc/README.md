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

Every TU in the vendored set compiles cleanly through badc on
every host profile (Linux x86_64 / aarch64, macOS aarch64,
Windows x86_64 / arm64). The smoke harness is gated; a TU
regression fails CI.

The self-host fixed point is exercised by `self_host.py`, which
runs five tiers in sequence on every lane:

| Tier         | What it asserts                                                                          |
|--------------|------------------------------------------------------------------------------------------|
| samples      | per-TU `-c` parity (badc-built tcc vs host-cc-built tcc) on 25 small fixtures            |
| corpus       | per-TU `-c` parity on tinycc's own 11-12 TUs                                             |
| bootstrap    | `tcc-gen2` (host-linked from stage1-compiled TUs) compiles every TU byte-identical       |
| gen2-self    | `tcc-gen2-self` (stage1-self-linked) compiles every TU byte-identical to gen2's output   |
| functional   | hello-world compile + link + run round trip through stage1 and gen2                      |

Current per-lane state:

| Lane                | samples | corpus  | bootstrap | gen2-self | functional | notes                                                |
|---------------------|---------|---------|-----------|-----------|------------|------------------------------------------------------|
| macOS aarch64       | 25/25   | 12/12   | 12/12     | 12/12     | 2/2        | full fixed point                                     |
| Linux x86_64        | 25/25   | 11/11   | 11/11     | 11/11     | 2/2        | full fixed point                                     |
| Linux aarch64       | 25/25   | 11/11   | 11/11     | 11/11     | 2/2        | full fixed point                                     |
| Windows x86_64      | 25/25   | 12/12   | 12/12     | 12/12     | 2/2        | full fixed point                                     |
| Windows arm64       | 25/25   | 12/12   | 12/12     | 12/12     | 2/2        | full fixed point                                     |

All five tiers are strict-gated on every lane.

Already-closed gaps that the bringup surfaced:

* `<inttypes.h>` PRI / SCN format macros over `<stdint.h>`.
* `__attribute__` / `__declspec` absorbed as empty fn macros.
* `<unistd.h>` exposes `ssize_t` / `size_t` / `off_t` / `pid_t` /
  `uid_t` / `gid_t` per POSIX-2017 through `<sys/types.h>`.
* `<setjmp.h>` ships per-platform `libc::setjmp` /
  `libc::longjmp` bindings; on Windows x86_64 the header wraps
  setjmp / longjmp in alignment macros so msvcrt's `_setjmp`
  sees a 16-byte-aligned env (the `movdqa` saves of
  xmm6..xmm15 fault otherwise).
* `sizeof(typedef T arr[N])` reports `N * sizeof(T)` per C99
  6.5.3.4 / 6.7.7 (the typedef array dim is propagated through
  the operand-shape parser).
* Integer literal `u` / `l` / `L` suffixes drive longness +
  unsignedness per C99 6.4.4.1.
* Unary `-` on `uint64_t` preserves the operand's width per
  C99 6.5.3.3p3.
* Bitfield storage unit follows the base type per C99 6.7.2.1p11
  (the unit width tracks `sizeof(base_type)`, not a hard-coded
  8 bytes).
* Bitwise `&` / `^` / `|` result type follows the usual
  arithmetic conversions per C99 6.5.10 / 6.5.11 / 6.5.12; a
  downstream arithmetic op no longer narrows a 64-bit operand
  through a sign-extend from bit 31.

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

`CONFIG_TCC_SYSINCLUDEPATHS` / `CONFIG_TCC_LIBPATHS` are baked
in per host so the produced tcc resolves `<stdio.h>` etc. and
`-lkernel32` / `-lmsvcrt` etc. without a separate install step:

| Host           | `CONFIG_TCC_SYSINCLUDEPATHS` (after `{B}` resolves to `demos/tinycc`)             | `CONFIG_TCC_LIBPATHS`             |
|----------------|----------------------------------------------------------------------------------|-----------------------------------|
| Linux          | `{B}/include:/usr/include/<triplet>:/usr/include`                                | `{B}:/usr/lib/<triplet>:/usr/lib` |
| macOS          | `{B}/include:<SDK>/usr/include:/usr/include`                                     | `{B}:<SDK>/usr/lib:/usr/lib`      |
| Windows        | `{B}/win32/include;{B}/win32/include/winapi;{B}/include`                         | `{B}/lib;{B}/win32/lib`           |

`CONFIG_TCC_ELFINTERP` stays undefined; the self-host stage
supplies it via CLI when it links an ELF binary that needs one.

The synthesized `config.h` also forces `CONFIG_TCC_SEMLOCK 0`:
the upstream default pulls in `<dispatch/dispatch.h>` on macOS,
`<semaphore.h>` on Linux, and `CRITICAL_SECTION` on Windows --
none of which c5 ships today. tinycc uses the lock only to
serialize libtcc state across threads; the bringup compile +
self-host fixed point is single-threaded, so the lock is dead
weight here.

## Layout

* `setup.py` -- fetch the source zip from the vendor-deps
  release and extract the curated set; idempotent. Drops the
  core tinycc `.c` / `.h` files flat into the demo dir, the
  cross-platform system headers under `include/`, the runtime
  helper sources under `lib/`, the upstream Windows headers
  under `win32/include/` (mingw `<stdio.h>` etc. plus the Win32
  API tree at `win32/include/winapi/`), and the Windows PE
  startup + DLL `.def` files under `win32/lib/` (used to
  satisfy `_start` / `__chkstk` / `-lkernel32` / `-lmsvcrt` at
  link time).
* `smoke.py` -- build-only smoke harness. Synthesizes
  `config.h` for the host, walks each TU through `badc -c`,
  tracks per-TU compile state, exits 0 when every TU compiles
  cleanly and the multi-TU link emits a working tcc binary.
* `self_host.py` -- five-tier fixed-point parity check (samples
  -> corpus -> bootstrap -> gen2-self -> functional). Builds a
  reference tcc with the host cc and a stage1 tcc with badc,
  then asserts each tier matches byte-for-byte and that the
  final binaries round-trip a hello world.
* `tcc.c`, `tcc.h`, ..., `include/*.h`, `lib/*.c` / `*.S`,
  `win32/include/**`, `win32/lib/**` -- vendored upstream
  sources (gitignored out of band; `setup.py` is the source of
  truth for what they are).

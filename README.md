# `badc`

[![CI](https://github.com/kromych/badc/actions/workflows/ci.yml/badge.svg)](https://github.com/kromych/badc/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/kromych/badc?sort=semver&display_name=tag)](https://github.com/kromych/badc/releases/latest)
[![crates.io](https://img.shields.io/crates/v/badc.svg)](https://crates.io/crates/badc)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![OS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS%20%7C%20Windows-informational)](./doc/native-compilation.md)
[![Arch](https://img.shields.io/badge/arch-x86__64%20%7C%20ARM64-informational)](./doc/native-compilation.md)

`badc` is a small cross-platform optimizing C compiler, and a
compiler-as-library, that emits native binaries for five targets from any host.
It carries its own linker, DWARF emitter, inline-asm encoder, in-process JIT,
and SSA interpreter.

> `badc` used to be bad when the project started out, and the name stuck.
>
> There is some compiler-building jargon in this document here and there. You can safely skip it, and jump to the usage section right away.
>
> For _the true compiler heads_ there is the `--dump-ssa` option which prints each function's SSA IR plus the register allocator's per-value placement to stderr before lowering.

## Demos

[`demos/`](./demos/) wires each project below as a smoke test;
[`demos/README.md`](./demos/README.md) says what each exercises.

* _Language interpreters_: [`Python`](./demos/python/) 3.14 on all five
  targets, [`Lua`](./demos/lua/), [`quickjs`](./demos/quickjs/),
  [`TCL`](./demos/tcl/).
* _Systems software_: [`sqlite3`](./demos/sqlite3/),
  [`curl`](./demos/curl/), [`qemu`](./demos/qemu/): over a thousand units per
  target, self-linked, and both `qemu-system-aarch64` and `qemu-system-x86_64`
  boot Linux through UEFI firmware to a shell under TCG.
* _Toolchains_: [`chibicc`](./demos/chibicc/),
  [`tinycc`](./demos/tinycc/), and the [`nasm`](./demos/nasm/) /
  [`yasm`](./demos/yasm/) assemblers, each run against its own test suite.
* _Firmware and kernels_: [`edk2`](./demos/edk2/): badc compiles the full
  UEFI firmware from edk2 source into a bootable OVMF / AAVMF image, and the CI
  boots run under it. [`efi_hello`](./demos/efi_hello/) is a single-source EFI
  application, its PE subsystem selected by `#pragma subsystem`. [`kernel`](./demos/kernel/) is a freestanding preemptive
  multitasking kernel on both architectures, timer interrupts and context
  switches included , [`Linux`](./demos/linux) is the Linux kernel `7.1.10`.
* _Cryptography and compression_: [`TweetNaCl`](./demos/tweetnacl/),
  [`Monocypher`](./demos/monocypher/), [`BearSSL`](./demos/bearssl/),
  [`miniz`](./demos/miniz/), [`bzip2`](./demos/bzip2/).
* _Graphics, math, and the rest_: [`stb`](./demos/stb/),
  [`raylib`](./demos/raylib/) with a Lode Runner game,
  [`kissfft`](./demos/kissfft/), the [`GUI`](./demos/gui_hello/) demos (one
  windowed program per OS family, each cross-compiled to every target), the
  [`WDM`](./demos/wdm_driver/) Windows kernel driver, the NT native binaries
  ([`nt_hello`](./demos/nt_hello/), an `IMAGE_SUBSYSTEM_NATIVE` PE that runs
  under `ntdll` alone, and [`nt_loader`](./demos/nt_loader/), which spawns one
  through `NtCreateUserProcess`), and the cooperative-concurrency libraries
  ([`libmill`](./demos/libmill/), [`libdill`](./demos/libdill/),
  [`coroutines`](./demos/coroutines/)), whose context switches run through
  inline asm.

## Lineage

It started as a Rust port of Robert Swierczek's C compiler in four functions,
[c4](https://github.com/rswier/c4), and diverged enough to call the dialect
**c5**. Hence the `c5` module and the `C5Error` type. `c4.c` ships as a test
fixture and self-hosts:

```sh
badc -O -o c4 tests/fixtures/c/c4.c   # compile c4 to a native binary
./c4 hello.c                          # which then runs hello.c
```

And you can really crank the fun up with something like

```sh
badc -O --jit tests/fixtures/c/c4.c tests/fixtures/c/c4.c tests/fixtures/c/c4.c tests/fixtures/c/c4.c
```

to run it quadro-nested :)

It has since grown from a stack IR through a 3-operand IR to SSA with an
optimizing backend, without taking on the pass count of a titan toolchain.

## Documentation

* [What `badc` can do](./doc/what-badc-can-do.md) -- a short survey of `badc` features.
* [Getting started](./doc/getting-started.md) -- install, first run, flags,
  debugging, C as a script.
* [Native compilation](./doc/native-compilation.md) -- targets, multiple
  translation units, the linker, headers and bindings, `#pragma`-driven build
  flags, the JIT, optimizations.
* [Standard conformance](./doc/std-conformance.md) -- implementation-defined
  choices, divergences from C99, and the C11 / C23 / POSIX / GCC / MSVC
  extensions implemented.
* [The interpreter](./doc/interpreter.md) -- `--interp` and the
  pointer-tracking safety net.
* [Library and `no_std`](./doc/library-and-no-std.md) -- using badc from Rust.
* [Testing](./doc/testing.md) -- the suites, the fixtures, the snapshots, CI.
* [Tools](./doc/tools.md) -- the core walker and the assembler-surface probe.

## Disclaimer for those legally enlightened

This is a personal educational/research project, it has not been sponsored or
suggested by anyone, i.e. it is a product of my own volition. That said, in no
event I'll be responsible for how you use this project or what happens due to
that. See [LICENSE](./LICENSE) for the exact terms.

# What `badc` can do

## Compile the Linux kernel

CI builds every C translation unit of a Linux 7.2.9 `defconfig` kernel with
badc, on x86_64 and aarch64: 2942 and 4283 units for the kernel image. badc
also links the kernel, and both kernels boot. Each boot is checked by markers
and by self-checks of procfs and sysfs inside the booted kernel. All
`defconfig` modules build and load, with the same per-module results as a
gcc-built kernel.

The kernel also builds as `.deb` and `.rpm` packages from the Ubuntu 26.04
and Fedora 44 kernel configurations. The packages install into stock Debian 13,
Ubuntu 26.04 and Fedora 44 images and boot to systemd multi-user with modules
loading on demand; `/proc/version` names badc. At the 7.1.10 pin, the four
packages (`{rpm, deb}` x `{x86_64, aarch64}`) took 101929 C units, 467
assembly units and 59424 links, all of them badc's: nothing fell back to
another compiler, assembler or linker.

`badc -c foo.S -o foo.o` assembles, and the kernel build uses it for every
assembly unit, the real-mode boot code included. Under `-m16` and `-m32` the
object is ELFCLASS32 / EM_386. badc makes every link, including the 32-bit
i386 ones (boot setup, the real-mode blob, the 32-bit vDSO), and writes the
dynamic metadata and symbol versions of all three vDSOs.
[The kernel page](./linux-kernel.md) has the details.

## Target five platforms from any host

badc writes Mach-O, ELF and PE32+ directly:

| system | architectures | images |
|---|---|---|
| macOS | ARM64 | executables, dynamic libraries |
| Linux | ARM64, x86-64 | executables, shared libraries |
| Windows | ARM64, x86-64 | console, GUI, NT native and driver images, DLLs |

It also writes EFI applications and drivers. `--freestanding` links without
the startup runtime. x86-64 code assumes x86-64-v3, and ARM64 code the Apple
M1's ARMv8.4-A ([baseline](./native-compilation.md#instruction-set-baseline)).

## Ship as one binary

The headers and the C runtime are built into the binary; `--install` writes
them to disk for editing. badc needs no `ld`, `lld` or `link.exe`, and its
linker can stand in for `LD=` in an existing build. It assembles `.s` and `.S`
files and inline `asm`.

## Optimize

Every build goes through SSA and a graph-coloring register allocator, and
`-O` adds the SSA optimization passes. The code `-O` produces runs faster
than `clang -O0`'s. CI measures badc against tcc, ccc, clang and gcc on Linux
and against MSVC on Windows for every pull request and every push to
`master`; the results are at
[badc.dev/performance](https://badc.dev/performance/).

## Emit debug info

`-g` writes DWARF version 4 for lldb, gdb, rr and profilers, so breakpoints,
watchpoints and structure layouts work. On Windows targets the DWARF is in
the PE image, and a `-g` link writes the PDB beside it, named by the image's
debug directory. The `-g<level>`, `-ggdb`, `-gdwarf` and
`-gdwarf-<n>` spellings are accepted. A request badc cannot meet, such as
DWARF 5 or `-gdwarf64`, reports B7011 `dwarf-output`, and the compile
continues with DWARF 4.

## Run C without writing a binary

`--jit` compiles in memory and calls `main`. `--interp` runs the SSA IR in an
interpreter that keeps code apart from data and can check every heap access
([`--interp` and `--jit`](./interpreter.md)). A `.c` file that starts with a
`#!` line can be run directly.

## Be a library

`cargo add badc` compiles and runs C from a Rust program, with `std` or with
`alloc` alone ([library and `no_std`](./library-and-no-std.md)).

# What `badc` can do

## Compile the Linux kernel

Every C translation unit of a Linux 7.1.10
`defconfig` kernel on x86_64 and aarch64 is built by `badc` in the CI, this is 2921 and
4434 units for the kernel image, 2953 and 10489
with the modules. Both kernels boot, checked by boot markers plus in-kernel
procfs/sysfs self-checks. All
`defconfig` modules build and load, with per-module verdicts identical to a
gcc-built kernel. `badc` links the kernel too, and those kernels boot.
The kernel packages as a `.deb` and an `.rpm`, installs into stock Debian 13,
Ubuntu 26.04 and Fedora 44 images, and reaches systemd multi-user with modules
autoloading, `/proc/version` names `badc`. Built from each distribution's own
configuration rather than `defconfig`, all four packages -- `{rpm, deb}` x
`{x86_64, aarch64}` -- are `badc`'s entirely: 101929 C units and 59424 links
measured with the fallback lists empty, so nothing fell back to another
compiler, assembler or linker.

`badc -c foo.S -o foo.o` assembles too, and the kernel build uses it. Across
the four distribution-configuration packages `gas` assembles nothing: 467
assembly units, every one `badc`'s, the real-mode boot units among them,
written out as ELFCLASS32 / EM_386 objects under `-m16` / `-m32`. `badc` makes
every link, the 32-bit i386 ones (boot setup, realmode blob, 32-bit vDSO)
included, and the three vDSOs carry `badc`-written dynamic metadata and symbol
versions. The `defconfig` counts are broken out in
[the kernel document](./linux-kernel.md).

## Target five platforms from any host

`badc` emits Mach-O, ELF, or PE32+ directly:

* macOS (`ARM64`),
* Linux (`ARM64`, `x86_64`),
* Windows ({`ARM64`, `x86_64`} x {`console`, `GUI`, `NT`, `driver`}).

EFI images are supported as well. `--freestanding` drops the startup runtime.
The x86_64 code assumes x86-64-v3 and the ARM64 code the Apple M1's ARMv8.4-A
feature set ([baseline](./native-compilation.md#instruction-set-baseline)).

## Ship as one binary

Headers and runtime are embedded; `--install` writes
them to a path to override. There is no `ld` / `lld` / `link.exe` dependency,
and badc's linker stands in for `LD=` in an existing build. Assembly is
supported in standalone files and inline.

## Optimize

`-O` runs SSA passes over a graph-coloring register allocator and
produces code faster than `clang -O0`, especially on ARM64. CI compares against
tcc and clang/MSVC on every push.

## Emit debug info

`-g` writes DWARF version 4 for lldb / gdb / rr and the profilers, so
breakpoints, watchpoints and structure-layout dumps work. The `-g<level>`,
`-ggdb`, `-gdwarf` and `-gdwarf-<n>` spellings a
build system passes are accepted too; a request badc cannot produce -- a
version other than 4, or `-gdwarf64` -- is reported as `dwarf-output` and the
compile goes on.

## Run C without writing a binary

`--jit` lowers in-process and calls `main`
directly; `--interp` runs the SSA IR under a VM that keeps code, stack and data
apart and can track every allocation. A `.c` file with a shebang is directly
executable.

## Be a library

`cargo add badc` builds or runs C from your project, on `std` or on `alloc` alone.

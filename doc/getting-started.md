# Getting started

## Install

Download the binary release package matching your hardware and OS; it holds one
small binary and nothing else.

If you have Rust installed, clone the repo and install with

```sh
cargo install --path . --features full
```

or, without the source tree,

```sh
cargo install badc --features full
```

`--features full` is required for the command-line compiler. The crate's
default feature set is the host-architecture JIT library alone (so
`cargo add badc` pulls in a slim dependency); the `badc` binary additionally
needs the native object writers and the cross-translation-unit linker, which
`full` enables.

## First run

```sh
badc --jit hello.c      # runs native code in-process
```
```console
Hello 123
```

or

```sh
badc -O hello.c         # produces an optimized native binary
./hello
```
```console
Hello 123
```

The first non-flag argument is the source file. By default badc lowers it to a
native binary at the obvious path next to the source (`hello.c` -> `hello` on
POSIX targets, `hello.exe` on Windows targets); `-o <path>` chooses a different
one.

badc can add the standard-library header for you, so a bare `hello.c` with

```c
int main() {
    puts("Hello");
    return 0;
}
```

works:

```console
info: auto-including <stdio.h> for undeclared `puts`
info: wrote file hello for target `macos-aarch64`
```

## Execution modes

| flag       | what it does                                                    |
|------------|-----------------------------------------------------------------|
| (default)  | Lower to a native Mach-O / ELF / PE32+ at `-o <path>` and exit.  |
| `--jit`    | Lower in-process, mmap the result, call `main` directly.         |
| `--interp` | Run the SSA IR under a watchful VM (pointer tracking, traces).   |

## Flags

Flags (`--target=<spec>`, `--optimize` / `-O`, `--dump-ssa`, `--list-symbols`,
`-H` / `--show-includes`, plus the VM-only `--track-pointers` / `--trace`) can
appear anywhere before the source. `-D NAME[=VALUE]`, `-U NAME`, `-I path`, and
`-include FILE` work the same way they do on gcc / clang, as does the `-M`
dependency-output family (`-M`, `-MM`, `-MD`, `-MMD`, `-MF`, `-MT`, `-MQ`,
`-MP`, and the `-Wp,-M[M]D,<file>` spellings a kbuild-style build passes).
`badc --help` prints the full set.

badc's driver has no accept-and-ignore bucket: a dash-prefixed argument it does
not implement is an error rather than a warning. Source-driven build flags ride
on `#pragma`s instead -- see
[headers and bindings](native-compilation.md#headers-and-bindings).

## Diagnostics

Every warning and error ends with its code and its name:

```console
hello.c:4: warning: unused variable `x` [B2001] [-Wunused-variable]
hello.c:7: error: `)` expected after cast [B2020] [syntax]
```

`-W<name>`, `-Wno-<name>`, `-Werror=<name>` and `-Wno-error=<name>` select
one diagnostic by either spelling; `-Wall`, `-Wextra`, `-Wpedantic`, `-Werror`
and `-w` work as they do on gcc, and `#pragma GCC diagnostic`, `#pragma clang
diagnostic` and MSVC's `#pragma warning(...)` apply from their position.
`badc --explain <name>` describes one row, `badc --list-diagnostics` prints
the catalogue; [diagnostics](diagnostics.md) is the same table.

## Debugging

`-g` emits DWARF, so the binary can be debugged and profiled:

```sh
badc -g hello.c
```
```console
info: wrote file hello for target macos-aarch64
```

```console
lldb ./hello

(lldb) target create "./hello"
Current executable set to 'hello' (arm64).
(lldb) b main
Breakpoint 1: where = hello`main + 16 at hello.c:5, address = 0x00000001000006fc
(lldb) run
Process 19800 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x00000001000006fc hello`main at hello.c:5
   2    #include <stdlib.h>
   3
   4    int main() {
-> 5        int a = 123;
   6        printf("Hello %d\n", a);
   7        return 0;
   8    }

(lldb) n
Process 19800 stopped
    frame #0: 0x0000000100000704 hello`main at hello.c:6
-> 6        printf("Hello %d\n", a);

(lldb) v
(int) a = 123
```

For the SSA IR plus the register allocator's per-value placement, pass
`--dump-ssa`; it prints to stderr before lowering.

## C as a script

A `.c` file may start with a shebang. With `badc` on `PATH`, `chmod +x
script.c` makes the file directly executable, and the shebang line picks the
mode: `#!/usr/bin/env badc --interp` for the VM, the bare form for native
compilation.

## Headers on disk

The bundled headers and runtime are embedded in the binary. `--install [<dir>]`
writes them under `<dir>` (default `~/.badc`, or `$BADC_HOME`), and later runs
prefer the installed copies, so editing an installed header changes the build
without rebuilding badc. `--dump-headers` prints them to stdout instead.

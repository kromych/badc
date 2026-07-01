# badc demos

End-to-end programs that exercise badc on something more substantial
than a fixture. Build with the c5 dialect badc supports today
(structs / unions / bitfields / enums, arrays of structs, function
pointers, varargs, `_Thread_local`); see [`../std-conformance.md`](../std-conformance.md)
for the divergences from C99.

Each demo runs on **macOS** (aarch64), **Linux** (x86_64 and aarch64),
and **Windows** (x86_64 and aarch64). The platform-specific bits
sit behind a handful of `#ifdef`s; the libc / Winsock / pthread /
Win32 thread bindings come from the shipped `<sys/socket.h>`,
`<sys/select.h>`, `<pthread.h>`, and `<windows.h>` headers.

## Build flavours

The multi-source library demos (miniz, kissfft, bzip2, tweetnacl,
monocypher, bearssl) each build their smoke harness three different
ways at both `-O0` and `-O`:

1. **Amalgamation** -- one combined source file straight through
   `badc`. The classic single-TU path; same shape `sqlite3.c +
   shell.c` already exercises.
2. **Translation units** -- `badc -c` on each `.c` file (emitting
   native ELF64 ET_REL `.o` files with machine code, `.symtab`,
   and `.rela.text` relocs), then `badc -o app *.o` to link them.
   Exercises the linker's cross-TU symbol resolution and the
   C99 6.2.2 internal / external linkage rules.
3. **Archive** -- `badc --ar -o libfoo.a *.c` to bundle the
   library into a SysV ar(5) archive with `/` symbol index, then
   `badc -o app main.c -L. -l foo` to pull members in by
   reference (gcc-style). Exercises the on-demand archive
   resolution path.

The flat single-source demos (`hello_server`, `coro_pool`,
`threads`) and stb's header-only smoke stay single-TU -- the
multi-TU paths are exercised by the library demos.

## hello_server.c

A `select(2)`-driven HTTP server that serves `Hello, World!` on
port 8080. Multiplexes up to 8 concurrent connections in a single
event loop -- no threads, no fork.

```sh
cargo run -- -O -o hello demos/hello_server.c
./hello                           # listens on 0.0.0.0:8080
curl http://localhost:8080/       # -> Hello, World!
```

The byte-level constants (AF_INET, SOL_SOCKET, ...) and the
libc/Winsock symbol bindings come from `<sys/socket.h>`. The
dialect-driven choices that don't fit in a header (the macOS
sin_len byte, the close vs closesocket spelling, the fcntl vs
ioctlsocket non-blocking dance) sit behind a few `#ifdef`s in
the source.

## coro_pool.c

User-mode cooperative coroutines on top of a Cilk-shape work-
stealing scheduler. Every task is a tiny state machine (an
iterative `fib(n)` here) that advances one step per tick; the
scheduler round-robins through two workers, and an idle worker
steals from the other's deque (FIFO own-pop, LIFO steal-pop).

The demo seeds *every* task on worker 0, so worker 1 has to steal
to make any progress. The output reports who finished what and
how many steals each worker performed.

```sh
cargo run -- -O -o coro demos/coro_pool.c
./coro
```

Pure user-mode -- no syscalls beyond `printf` / `malloc`, so it
works wherever the c5 dialect compiles.

## threads.c

OS-level threads (POSIX `pthread_create` / Win32 `CreateThread`)
sharing a task queue under a mutex. NUM_THREADS workers race to
claim NUM_TASKS items off a counter; each task computes a
recursive `fib(n)` so the work is heavy enough that all four
workers see action. Output reports which worker picked each task.

```sh
cargo run -- -O -o threads demos/threads.c
./threads
```

`arg` flows in through the codegen's host-ABI shuffling thunk:
when a c5 function's address is taken (here, `worker_main` passed
to `pthread_create` / `CreateThread`), the codegen emits a small
wrapper that copies the host's first int-arg register (rdi / x0 /
rcx) into the c5 stack slot the callee reads from. Each worker's
logical id rides through that channel; everything bigger (the
task queue, the result table) still goes through globals.

## sqlite3/

End-to-end of the upstream SQLite amalgamation. Pinned release,
fetched on demand by `demos/sqlite3/setup.py`; in-memory and
file-backed scenarios at both -O and noO. See
[`sqlite3/README.md`](./sqlite3/README.md).

## lua/

End-to-end of the upstream Lua 5.5.0 interpreter. Pinned release,
fetched on demand by `demos/lua/setup.py`; builds the interpreter
with badc at both -O and noO and runs a curated subset of the
upstream test suite (`bitwise / calls / closure / constructs /
coroutine / cstack / errors / events / goto / literals / locals /
math / nextvar / pm / sort / strings / tpack / utf8 / vararg`)
against each lane. See [`lua/README.md`](./lua/README.md).

## miniz/

End-to-end of the upstream [miniz](https://github.com/richgel999/miniz)
deflate / inflate / CRC32 / Adler32 amalgamation. Smaller and
integer-heavier than sqlite -- the second non-trivial demo. See
[`miniz/README.md`](./miniz/README.md).

## kissfft/

End-to-end of the upstream [KISS FFT](https://github.com/mborgerding/kissfft)
amalgamation. First real FP exerciser: impulse FFT, forward+inverse
round-trip, real-only `kiss_fftr` against a sine wave, all at -O
and noO. See [`kissfft/README.md`](./kissfft/README.md).

## bzip2/

End-to-end of the upstream [bzip2](https://sourceware.org/bzip2/)
1.0.8 library. Integer + bit-twiddle heavy (BWT, MTF, RLE, Huffman);
exercises a different code shape from miniz's deflate.
See [`bzip2/README.md`](./bzip2/README.md).

## gui_hello/

Three "show a window with a label" demos -- Win32 (using the
new `#pragma subsystem(windows)` + `#pragma entrypoint(WinMain)`),
Linux X11, macOS Cocoa via raw `objc_msgSend`. Cross-builds
to all five supported targets; CI runs the smoke build-only
since runners have no display server. See
[`gui_hello/README.md`](./gui_hello/README.md).

## raylib/

badc compiles raylib 5.5 (RGFW desktop backend) from source and
links a small game (Lode Runner) into a standalone binary. The
pure game-logic self-test runs through badc on any host; the full
standalone build + headless run is wired for macOS today (the X11
/ Win32 header surface for the Linux / Windows ports is pending).
See [`raylib/README.md`](./raylib/README.md).

## curl/

badc compiles the curl 8.11.1 library (HTTP + `file://` + WebSocket,
threaded resolver, IPv6, no external dependencies) and builds it as a
static archive, a shared library, and an executable linked against
each, plus a flavour that binds a badc-compiled client to the
platform's installed libcurl to check the frontend matches the OS ABI.
HTTPS is provided by badc-compiled BearSSL (`USE_BEARSSL`); the smoke
drives HTTP / HTTPS / `file://` transfers against a hermetic loopback
server, so it needs no external network. See
[`curl/README.md`](./curl/README.md).

## efi_hello/

UEFI application that prints "Hello, EFI!" through
`SystemTable->ConOut->OutputString`. Subsystem =
`IMAGE_SUBSYSTEM_EFI_APPLICATION (10)`; the firmware loader
invokes `efi_main(EFI_HANDLE, EFI_SYSTEM_TABLE *)` directly,
with no CRT shim and no msvcrt import. Build-only in CI;
running needs a UEFI shell (TianoCore's UEFI Shell, OVMF under
qemu, or a real machine's firmware shell).

## nt_hello/

NT-native usermode skeleton. Subsystem =
`IMAGE_SUBSYSTEM_NATIVE (1)`, entry = `NtProcessStartup`, calls
`ntdll!NtTerminateProcess` to exit. Same image shape as
`smss.exe` / `autochk.exe` / boot-time `chkdsk.exe`. Build-only
in CI; runs on Windows via the `BootExecute` registry value or
during smss/csrss bringup.

## wdm_driver/

Windows kernel-mode driver skeleton. Subsystem =
`IMAGE_SUBSYSTEM_NATIVE (1)` via the `driver` pragma alias,
entry = `DriverEntry(PDRIVER_OBJECT, PUNICODE_STRING)`,
registers a `DRIVER_UNLOAD` callback so the service is
stoppable via `sc stop`. Build-only; loading needs admin and
test-signing on the target. Same compiler plumbing as
`nt_hello`; differs only in entry signature.

## nt_loader/

Launches user-mode NT-native programs (e.g. `nt_hello`)
through a transacted `SEC_IMAGE` section and waits up to two
seconds on a named event the child signals. Builds in both
UNICODE (`wmain`, `__wgetmainargs`) and ANSI (`main`,
`__getmainargs`) modes from the same source; `#define
USE_UNICODE` selects.

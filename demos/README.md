# badc demos

End-to-end programs that exercise badc on something more substantial
than a fixture. Build with the c5 dialect badc supports today (no
struct array indexing, no struct-member function calls, parallel int
arrays for everything).

Each demo runs on **macOS** (aarch64), **Linux** (x86_64 and aarch64),
and **Windows** (x86_64 and aarch64). The platform-specific bits
sit behind a handful of `#ifdef`s; the libc / Winsock / pthread /
Win32 thread bindings come from the shipped `<sys/socket.h>`,
`<sys/select.h>`, `<pthread.h>`, and `<windows.h>` headers.

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
exercises a different code shape from miniz's deflate. Aligns with
gh #11. See [`bzip2/README.md`](./bzip2/README.md).

## gui_hello/

Three "show a window with a label" demos -- Win32 (using the
new `#pragma subsystem(windows)` + `#pragma entrypoint(WinMain)`),
Linux X11, macOS Cocoa via raw `objc_msgSend`. Cross-builds
to all five supported targets; CI runs the smoke build-only
since runners have no display server. See
[`gui_hello/README.md`](./gui_hello/README.md).

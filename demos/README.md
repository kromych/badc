# badc demos

End-to-end programs that exercise badc on something more substantial
than a fixture. Build with the c4 dialect badc supports today (no
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
cargo run -- --emit-native -O -o hello demos/hello_server.c
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
cargo run -- --emit-native -O -o coro demos/coro_pool.c
./coro
```

Pure user-mode -- no syscalls beyond `printf` / `malloc`, so it
works wherever the c4 dialect compiles.

## threads.c

OS-level threads (POSIX `pthread_create` / Win32 `CreateThread`)
sharing a task queue under a mutex. NUM_THREADS workers race to
claim NUM_TASKS items off a counter; each task computes a
recursive `fib(n)` so the work is heavy enough that all four
workers see action. Output reports which worker picked each task.

```sh
cargo run -- --emit-native -O -o threads demos/threads.c
./threads
```

The c4 dialect can't read a thread function's `arg` parameter --
the host ABI puts it in rdi/x0/rcx, while a c4 callee fetches its
args off the c4 stack. Workers therefore communicate exclusively
through globals and the lock. See the comments in
`demos/threads.c` for the full constraint discussion.

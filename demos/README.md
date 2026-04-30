# badc demos

End-to-end programs that exercise badc on something more substantial
than a fixture. Both build with the c4 dialect badc supports today
(no struct array indexing, no struct-member function calls, parallel
int arrays for everything).

## hello_server.c

A `select(2)`-driven HTTP server that serves `Hello, World!` on
port 8080. Multiplexes up to 8 concurrent connections in a single
event loop -- no threads, no fork. POSIX socket calls
(`socket`/`bind`/`listen`/`accept`/`select`/...) are reached
through `dlopen(NULL, RTLD_NOW)` + `dlsym`, since badc doesn't ship
a `<sys/socket.h>`.

```sh
cargo run -- --emit-native --target=linux-x64 -O \
    -o hello demos/hello_server.c
./hello                           # listens on 0.0.0.0:8080
curl http://localhost:8080/       # -> Hello, World!
```

Linux only (the `sockaddr_in` byte layout in the source is the
Linux flavour). Works on x86_64 and aarch64.

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

Cross-platform (no syscalls beyond `printf` / `malloc`). Tested on
macOS aarch64, Linux x86_64, and Linux aarch64.

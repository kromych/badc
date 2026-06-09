// Runtime data definitions auto-linked into every native image.
//
// Embedded into the badc binary at build time via
// `src/c5/runtime.rs::EMBEDDED_RUNTIME` (mirrors the
// `embedded_headers` registry) and compiled + linked alongside
// the user's translation units in the native-link path.
//
// The libc-`exit` wrapper the `_start` stub calls lives in a
// separate source (`runtime_libc_exit.c`) that the link path
// includes only when a `_start` stub is emitted.

// POSIX `environ` -- defined here as the single canonical
// slot. Bundled headers (`<unistd.h>`, `<stdlib.h>`) declare
// it as `extern char **environ;` so each TU references this
// one definition rather than contributing a tentative def of
// its own. Coalescing tentative defs into a SHN_COMMON slot
// is a separate TODO; until that lands, hosting the definition
// in the runtime side-steps the multiple-definition collision.
char **environ;

// msvcrt's environment-vector alias on Windows. `<stdlib.h>`'s
// `_WIN32` section declares it `extern char **_environ;` for
// the same reason `environ` lives here -- a per-TU tentative
// def would collide once two Windows TUs land in the same link.
char **_environ;

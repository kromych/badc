// libc data globals: `stdin` / `stdout` / `stderr` resolve to
// non-null FILE * pointers, and a write through them reaches the
// host's stdio.
//
// Was the regression marker for gh #53: the
// `__c5_lazy_stream` resolver in `stdio.h` had `__APPLE__` and
// `__linux__` arms but fell through on Windows -- msvcrt doesn't
// export `stdin` / `stdout` / `stderr` as data symbols, so any
// program that read the stream macros got NULL. The fix adds a
// `_WIN32` arm that calls `__iob_func()` (the legacy / wine
// msvcrt spelling; UCRT calls it `__acrt_iob_func(int)`) and
// indexes into the returned `_iob` array by 48 bytes per slot
// (`sizeof(_iobuf)` on Win64 msvcrt).
//
// Stays in the parity tables as a regression marker; the
// fputs / fprintf paths in shell.c break loudly if the stream
// macros ever go back to NULL on any target.
#include <stdio.h>

int main() {
    char *out = (char *)stdout;
    char *err = (char *)stderr;
    char *in_ = (char *)stdin;
    if (out == 0) return 1;
    if (err == 0) return 2;
    if (in_ == 0) return 3;
    if (printf("ok\n") < 0) return 4;
    if (fputs("ok-fputs\n", stdout) < 0) return 5;
    if (fprintf(stderr, "ok-fprintf-stderr\n") < 0) return 6;
    return 0;
}

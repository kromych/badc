// DEFERRED: libc data globals on Windows.
//
// `stdio.h`'s `__c5_lazy_stream` resolves `stdin` / `stdout` /
// `stderr` via `dlsym` on macOS (`__stdinp` / `__stdoutp` /
// `__stderrp`) and Linux (`stdin` / `stdout` / `stderr` data
// exports). Windows doesn't expose those as data symbols at
// all -- msvcrt / UCRT bridges them through
// `__acrt_iob_func(int)` (returning a `FILE *`). The current
// header has no `#ifdef _WIN32` / `__BADC_WINDOWS__` arm, so
// any Windows program that touches `stdout` falls through to
// the no-symbol path and `__c5_stream_cache[idx]` stays NULL.
//
// Fix needs either (a) a per-target arm in `__c5_lazy_stream`
// that calls `__acrt_iob_func`, or (b) a real GOT/IAT-trampoline
// pipeline so `extern FILE *stdout;` resolves through the PE
// import directory.
//
// On macOS / Linux this fixture exits 0; on Windows it exits 1
// once the `printf` actually flushes through `stdout` -- but
// with the current header the flush goes to a NULL cache and
// reaches msvcrt with an invalid handle, surfacing as the
// printf failing or the program crashing.
#include <stdio.h>

int main() {
    // Reading `stdout` should yield a valid FILE *. On Windows
    // today the lazy-resolver returns NULL; we can't observe
    // that directly through `printf` (which is a libc binding,
    // not a `stdout`-via-macro path), so the fixture explicitly
    // expands the macro and checks the pointer.
    char *p = (char *)stdout;
    if (p == 0) return 1;
    if (printf("ok\n") < 0) return 2;
    return 0;
}

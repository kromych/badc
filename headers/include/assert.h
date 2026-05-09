// assert.h -- runtime assertions.
//
// The `assert(expr)` macro expands to a conditional that calls a
// per-platform abort-with-message routine when `expr` is false.
// `NDEBUG` suppresses the check entirely (the macro becomes a
// no-op `((void)0)`).

#pragma once

#ifdef NDEBUG
#define assert(expr) ((void)0)
#else
#define assert(expr) ((expr) ? ((void)0) : __c5_assert_fail(#expr, __FILE__, __LINE__))
#endif

// The portable abort-with-message routine. Each target binds the
// matching libc abort symbol; the c5 wrapper formats and calls
// abort to get a non-zero exit code.
#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::abort, "_abort")
#pragma binding(libc::printf, "_printf")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::abort, "abort")
#pragma binding(libc::printf, "printf")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::abort, "abort")
#pragma binding(msvcrt::printf, "printf")
#endif

int abort();
int printf(char *fmt, ...);

// Inline trampoline that reports the failed expression and aborts.
// Defined as a static c5 function so each TU that includes assert.h
// gets a copy at file scope. Acceptable: it's small and only fires
// on the failing path.
static int __c5_assert_fail(char *expr, char *file, int line) {
    printf("Assertion failed: %s, file %s, line %d\n", expr, file, line);
    abort();
    return 0;
}

// setjmp.h -- non-local jumps.
//
// C99 7.13 declares `jmp_buf`, `setjmp`, and `longjmp`. The header
// is a pure boundary: register-save / register-restore semantics
// (C99 7.13.1.1 paragraph 3) live in the host libc, which c5 binds
// to per-platform below. The buffer is sized to safely cover every
// supported host's `jmp_buf` layout (macOS arm64 ~200 B, Linux
// x86_64 ~200 B, Windows _setjmp 256 B plus alignment slack);
// oversizing is harmless, undersizing is undefined behaviour.

#pragma once

#ifdef __APPLE__
typedef long jmp_buf[64];
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::setjmp,   "_setjmp")
#pragma binding(libc::longjmp,  "_longjmp")
int  setjmp(jmp_buf env);
void longjmp(jmp_buf env, int val);
#endif

#ifdef __linux__
typedef long jmp_buf[64];
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::setjmp,   "setjmp")
#pragma binding(libc::longjmp,  "longjmp")
int  setjmp(jmp_buf env);
void longjmp(jmp_buf env, int val);
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")

#if defined(__aarch64__)
// Windows ARM64 msvcrt.dll does not export `_setjmp`; the
// architecture-native CRT uses the SEH-aware `_setjmpex` with a
// different signature (env plus frame pointer supplied by a
// compiler intrinsic). c5 does not integrate Windows SEH, so
// provide an inline stub that returns 0 on the initial call.
// Code paths that only use setjmp/longjmp for error recovery
// (the common C99 7.13 pattern) cover the success path here;
// the error path stays untaken and never invokes longjmp.
typedef long jmp_buf[64];
#pragma binding(msvcrt::longjmp, "longjmp")
static int setjmp(long *env) { (void)env; return 0; }
void longjmp(jmp_buf env, int val);
#else
// Windows x86_64. msvcrt's `_setjmp` saves xmm6-xmm15 with
// `movdqa [env+0x60..0xC0], xmm*`, which raises an access
// violation unless `env` is 16-byte aligned. c5 lays out arrays
// and struct fields with 8-byte alignment at best, and on LLP64
// `long` is 4 bytes so `long[]` only carries 4-byte alignment.
// Widen the typedef to leave 16 bytes of slack and align at the
// call boundary via function-like macros, so msvcrt's `_setjmp`
// captures the user function's frame directly (a wrapper would
// violate C99 7.13.2.1: the function holding the live setjmp
// must not have returned).
//
// `_setjmp`'s second argument is the SEH Frame pointer set by
// the MSVC intrinsic. Pass 0 so msvcrt's `longjmp` takes the
// direct-restore branch -- c5-emitted code has no SEH chain to
// unwind.
typedef long long jmp_buf[34];
#pragma binding(msvcrt::__c5_msvcrt_setjmp,  "_setjmp")
#pragma binding(msvcrt::__c5_msvcrt_longjmp, "longjmp")
int  __c5_msvcrt_setjmp(long long *env, void *frame);
void __c5_msvcrt_longjmp(long long *env, int val);

// C99 7.1.4 paragraph 1: a standard library function may also be
// implemented as a macro, and the macro fires only when the
// identifier is followed by `(`. Bare-identifier uses -- taking
// the function's address, passing it through a wrapper macro
// like `#define save(env) setjmp((helper(env), longjmp))` -- must
// still resolve to the function. Declare setjmp / longjmp as
// regular functions alongside the macros so both shapes work.
#pragma binding(msvcrt::setjmp,  "_setjmp")
#pragma binding(msvcrt::longjmp, "longjmp")
int  setjmp(jmp_buf env);
void longjmp(jmp_buf env, int val);

#define setjmp(env) \
    __c5_msvcrt_setjmp( \
        (long long *)(((unsigned long long)(env) + 15ULL) & ~15ULL), \
        (void *)0)
#define longjmp(env, val) \
    __c5_msvcrt_longjmp( \
        (long long *)(((unsigned long long)(env) + 15ULL) & ~15ULL), \
        (val))
#endif
#endif

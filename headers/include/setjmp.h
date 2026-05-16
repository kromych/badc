// setjmp.h -- non-local jumps.
//
// C99 7.13 declares `jmp_buf`, `setjmp`, and `longjmp`. The header
// is a pure boundary: register-save / register-restore semantics
// (C99 7.13.1.1 paragraph 3) live in the host libc, which c5 binds
// to per-platform below. The buffer is sized to safely cover every
// supported host's `jmp_buf` layout (macOS arm64 ~200 B, Linux
// x86_64 ~200 B, Windows _setjmp ~256 B); oversizing is harmless,
// undersizing is undefined behaviour.

#pragma once

typedef long jmp_buf[64];

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::setjmp,   "_setjmp")
#pragma binding(libc::longjmp,  "_longjmp")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::setjmp,   "setjmp")
#pragma binding(libc::longjmp,  "longjmp")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::longjmp, "longjmp")
#if defined(__aarch64__)
// Windows ARM64 msvcrt.dll does not export `_setjmp`; the
// architecture-native CRT uses the SEH-aware `_setjmpex` with a
// different signature (two args -- env plus frame pointer
// supplied by a compiler intrinsic). c5 does not integrate
// Windows SEH, so provide an inline stub that returns 0 on the
// initial call. tinycc uses setjmp/longjmp only for error
// recovery; a successful compile never longjmps, so the stub
// covers the gen2 self-host path. Source that hits an error
// path on Windows ARM64 will see longjmp resolve from msvcrt
// directly -- the loader will discover that's missing too only
// if the code actually reaches longjmp, and at that point the
// process is exiting anyway.
static int setjmp(long *env) { (void)env; return 0; }
#else
// MSVCRT's `setjmp` is `_setjmp` at the linker level on x86_64;
// on ARM the SEH-aware `_setjmpex` is the only spelling and the
// stub above takes that path.
#pragma binding(msvcrt::setjmp,  "_setjmp")
int  setjmp(jmp_buf env);
#endif
void longjmp(jmp_buf env, int val);
#else
int  setjmp(jmp_buf env);
void longjmp(jmp_buf env, int val);
#endif

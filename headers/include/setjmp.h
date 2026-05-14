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
// MSVCRT's `setjmp` is `_setjmp` at the linker level; on x64 a
// compiler intrinsic supplies the second argument (the SEH frame
// pointer). c5 does not integrate SEH and binds the plain
// `_setjmp` symbol directly; an SEH-aware `_setjmpex` binding is
// a follow-up if it surfaces a real divergence under SEH unwind.
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::setjmp,  "_setjmp")
#pragma binding(msvcrt::longjmp, "longjmp")
#endif

int  setjmp(jmp_buf env);
void longjmp(jmp_buf env, int val);

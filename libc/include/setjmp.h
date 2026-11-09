// setjmp.h -- non-local jumps.
//
// C99 7.13 declares `jmp_buf`, `setjmp`, and `longjmp`; POSIX adds
// `_setjmp` / `_longjmp` and `sigjmp_buf`, `sigsetjmp` / `siglongjmp`. The header
// is a pure boundary: register-save / register-restore semantics
// (C99 7.13.1.1 paragraph 3) live in the host libc, which c5 binds
// to per-platform below. The buffer is sized to safely cover every
// supported host's `jmp_buf` layout (macOS arm64 ~200 B, Linux
// x86_64 ~200 B, Windows _setjmp 256 B plus alignment slack);
// oversizing is harmless, undersizing is undefined behavior.

#pragma once

#ifdef __APPLE__
typedef long jmp_buf[64];
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::setjmp,   "_setjmp")
#pragma binding(libc::longjmp,  "_longjmp")
#pragma binding(libc::_setjmp,  "__setjmp")
#pragma binding(libc::_longjmp, "__longjmp")
#pragma binding(libc::sigsetjmp,  "_sigsetjmp")
#pragma binding(libc::siglongjmp, "_siglongjmp")
typedef long sigjmp_buf[65];
int  setjmp(jmp_buf env);
_Noreturn void longjmp(jmp_buf env, int val);
int  _setjmp(jmp_buf env);
_Noreturn void _longjmp(jmp_buf env, int val);
int  sigsetjmp(sigjmp_buf env, int savemask);
_Noreturn void siglongjmp(sigjmp_buf env, int val);
#endif

#ifdef __linux__
typedef long jmp_buf[64];
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::setjmp,   "setjmp")
#pragma binding(libc::longjmp,  "longjmp")
#pragma binding(libc::_setjmp,  "_setjmp")
#pragma binding(libc::_longjmp, "_longjmp")
#pragma binding(libc::__sigsetjmp, "__sigsetjmp")
#pragma binding(libc::siglongjmp,  "siglongjmp")
typedef jmp_buf sigjmp_buf;
int  setjmp(jmp_buf env);
_Noreturn void longjmp(jmp_buf env, int val);
int  _setjmp(jmp_buf env);
_Noreturn void _longjmp(jmp_buf env, int val);
int  __sigsetjmp(sigjmp_buf env, int savemask);
#define sigsetjmp(env, savemask) __sigsetjmp(env, savemask)
_Noreturn void siglongjmp(sigjmp_buf env, int val);
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")

// msvcrt's setjmp stores the callee-saved registers and, as cl passes it,
// the frame the unwinder reports for its caller (`__c5_establisher_frame()`);
// its `longjmp` unwinds to that frame, running each `__finally` block on the
// way. An image run in-process, whose code no function table describes to
// the unwinder, stores 0 as the frame on x86-64 and takes an inline pair on
// AArch64, whose msvcrt `longjmp` unwinds for that frame as well.
//
// C99 7.1.4 paragraph 1: a library function may also be a macro, which
// fires only when the identifier is followed by `(`; a bare use -- the
// function's address -- names the function, which the plain prototypes
// bind.
#pragma intrinsic("__c5_establisher_frame")
void *__c5_establisher_frame(void);
#pragma binding(msvcrt::__c5_msvcrt_longjmp, "longjmp")
#pragma binding(msvcrt::longjmp, "longjmp")
_Noreturn void __c5_msvcrt_longjmp(long long *env, int val);

#if defined(__aarch64__)
// The 192-byte `_JUMP_BUFFER`, with slack. The arm64 msvcrt.dll exports
// `_setjmpex` and no `_setjmp`.
typedef long long jmp_buf[32];
#pragma binding(msvcrt::__c5_msvcrt_setjmp, "_setjmpex")
#pragma binding(msvcrt::setjmp, "_setjmpex")
int __c5_msvcrt_setjmp(long long *env, void *frame);
int setjmp(long long *env);
_Noreturn void longjmp(long long *env, int val);
#define setjmp(env) __c5_msvcrt_setjmp((long long *)(env), __c5_establisher_frame())
#define longjmp(env, val) __c5_msvcrt_longjmp((long long *)(env), (val))
#else
// msvcrt's `_setjmp` saves xmm6-xmm15 with `movdqa`, which needs `env`
// 16-byte aligned; the typedef leaves 16 bytes of slack and the macros
// align the address at the call, so `_setjmp` captures the calling frame
// itself (a wrapper would violate C99 7.13.2.1: the function holding the
// live setjmp must not have returned).
typedef long long jmp_buf[34];
#pragma binding(msvcrt::__c5_msvcrt_setjmp, "_setjmp")
#pragma binding(msvcrt::setjmp, "_setjmp")
int __c5_msvcrt_setjmp(long long *env, void *frame);
int setjmp(jmp_buf env);
_Noreturn void longjmp(jmp_buf env, int val);
#define setjmp(env) \
    __c5_msvcrt_setjmp( \
        (long long *)(((unsigned long long)(env) + 15ULL) & ~15ULL), \
        __c5_establisher_frame())
#define longjmp(env, val) \
    __c5_msvcrt_longjmp( \
        (long long *)(((unsigned long long)(env) + 15ULL) & ~15ULL), \
        (val))
#endif
#endif

// POSIX sigsetjmp / siglongjmp / sigjmp_buf. The `savemask` argument
// selects whether the signal mask is saved and restored; callers that
// pass 0 (the common case, e.g. an emulator's execution-loop unwind) get
// the plain non-local jump the per-target setjmp / longjmp above already
// provide. The buffer aliases jmp_buf, which is sized with slack; on the
// hosts whose libc setjmp saves the mask, the pair stays self-consistent.
typedef jmp_buf sigjmp_buf;
#define sigsetjmp(env, savemask) setjmp(env)
#define siglongjmp(env, val) longjmp(env, val)

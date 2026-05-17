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
// Windows AArch64 msvcrt's `longjmp` routes through SEH and
// raises STATUS_NONCONTINUABLE_EXCEPTION on a `jmp_buf` whose
// frame pointer chain doesn't match a live unwind record. c5
// does not integrate Windows SEH, so we provide a self-
// contained setjmp / longjmp pair that uses only the AAPCS64
// callee-saved register set plus SP and a captured resume PC.
// The pair is lowered inline at each call site by the AArch64
// codegen (`Intrinsic::SetjmpAArch64` /
// `Intrinsic::LongjmpAArch64`).
//
// The jmp_buf must be 8-byte aligned; pick `long long` (8
// bytes per slot on Windows LLP64) to guarantee that. 256 bytes
// covers the 168-byte register save area with slack for any
// future addition.
typedef long long jmp_buf[32];

// Plain prototypes -- bound to msvcrt's setjmp / longjmp so a
// bare identifier (e.g. `&longjmp` passed as a function pointer
// in tinycc's `_tcc_setjmp(s1, jb, f, longjmp)`) resolves at
// compile time. Direct call-through of those addresses on
// AArch64 still crashes because msvcrt's longjmp routes
// through SEH; the supported path is the function-like macros
// below, which inline the CRT-free intrinsic at each call
// site.
#pragma binding(msvcrt::setjmp, "_setjmp")
#pragma binding(msvcrt::longjmp, "longjmp")
int setjmp(long long *env);
void longjmp(long long *env, int val);

// CRT-free intrinsic pair. The expression parser turns each
// call into `Op::Intrinsic <id>` and the AArch64 codegen lowers
// it inline as hand-rolled asm that saves the AAPCS64 callee-
// saved register set plus SP plus a captured resume PC.
#pragma intrinsic("__c5_aarch64_setjmp")
#pragma intrinsic("__c5_aarch64_longjmp")
int __c5_aarch64_setjmp(long long *env);
void __c5_aarch64_longjmp(long long *env, int val);
#define setjmp(env)        __c5_aarch64_setjmp((long long *)(env))
#define longjmp(env, val)  __c5_aarch64_longjmp((long long *)(env), (val))
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

// msvc_compat.h -- opt-in MSVC-shape predefines + decorator no-ops.
//
// Why this header exists. Lots of third-party C (sqlite, raylib,
// the SDL lineage, every project that bundles a "windirent.h"
// shim) gates Windows-flavoured code paths on `defined(_MSC_VER)`
// and spells fixed-width integers with MSVC's `__int64` keyword.
// c5 doesn't speak `__int64` natively and isn't really MSVC, but
// when its windows-x64 / windows-arm64 backend is the target
// translation unit, those gates are exactly the right ones to
// fire -- the produced PE links msvcrt.dll, follows the MS x64
// ABI, and is what real MSVC would have built.
//
// Build drivers opt in deliberately with
//
//     badc -include msvc_compat.h ... source.c
//
// -- mirroring gcc / clang's -include flag. The header is
// internally `#ifdef _WIN32` so dropping `-include msvc_compat.h`
// on a non-Windows target is a no-op, which keeps the same
// command line working on every host.

#pragma once

#ifdef _WIN32

// Pretend to be MSVC so headers that gate CRT-flavoured paths on
// `_MSC_VER` (sqlite's bundled `windirent` -> opendir / readdir
// shim, plus dozens of similar `#if defined(_WIN32) &&
// defined(_MSC_VER)` blocks across third-party sources) light up.
// The 1900 series is the VS2015+ spelling -- everything sqlite
// checks against expects `_MSC_VER >= 1300` or thereabouts. badc's
// runtime hits msvcrt.dll anyway so this matches what the code is
// going to call.
#define _MSC_VER 1900

// Pretend to be MinGW alongside MSVC. The two are mostly mutually
// exclusive in upstream code, but we want both #if branches to fire
// favourably: sqlite gates the wmain() wrapper on `defined(_WIN32)
// && !defined(__MINGW32__)`, and setting the macro skips that
// wrapper so the standard-named `main` stays visible to c5's entry
// resolver. The `_MSC_VER` block above still fires (most CRT-
// flavoured paths gate on _MSC_VER alone).
#define __MINGW32__ 1

// MSVC's 8-byte-integer keyword. c5's lexer doesn't know `__int64`
// natively; sqlite's amalgamation, in its `defined(_MSC_VER)`
// typedef branch, spells `sqlite_int64` as `__int64` and
// `sqlite_uint64` as `unsigned __int64`. Without this expansion,
// c5 falls back to `int` (4 bytes), which silently truncates every
// `i64` / `u64` field across sqlite -- including `db->flags`,
// whose bit-31 `SQLITE_EnableView = 0x80000000` then sign-extends
// through later widening and trips the `SQLITE_CorruptRdOnly`
// (HI(0x2) = bit 33) check inside `sqlite3VdbeHalt`, fabricating
// a SQLITE_CORRUPT for every prepare against a fresh `:memory:`
// DB. Map to `long long` (8 bytes everywhere) so the LLP64 /
// cross-CRT path matches what real MSVC produces.
#define __int64 long long

// MSVC decorator macros third-party headers expect to no-op when
// their `_MSC_VER` branches are active. None of them affect
// codegen on c5 (the IAT routes calls regardless of dllimport /
// inline tagging), and headers emit them BEFORE any include
// statement could provide them, so they have to be visible the
// instant the translation unit starts -- hence the `-include`
// shape.
#define __forceinline
#define __inline
#define _inline
#define __cdecl
#define __stdcall
#define __fastcall
#define __thiscall
#define __vectorcall
#define __nullable
#define __nonnull
#define __ptr32
#define __ptr64
#define __unaligned
#define _CRTIMP
#define _CRT_GUARDOVERFLOW
#define _Inout_
#define _In_
#define _In_opt_
#define _In_z_
#define _In_opt_z_
#define _Out_
#define _Out_opt_
#define _Outptr_
#define _Outptr_opt_

// Function-like decorator macros (`__declspec(x)`, `__pragma(x)`,
// `_Pre_satisfies_(x)`, ...) expand to nothing. The 1-arg shape
// covers every form sqlite + the bundled CRT headers emit; none
// of them rely on argument concatenation or stringification.
#define __declspec(x)
#define __pragma(x)
#define _Pre_satisfies_(x)
#define _Post_satisfies_(x)

// `#pragma comment(lib, "...")` is an MSVC linker directive.
// badc resolves imports through `#pragma binding(...)` (emitted
// below) and the preprocessor emits an unknown-pragma warning
// for the unrecognised spelling, so sources retaining it
// compile cleanly.

// ── kernel32 / msvcrt bindings ────────────────────────────────
//
// Sources that declare imports as `__declspec(dllimport) X
// f(...)` rely on a separate link step to wire the IAT.
// badc routes calls through `#pragma binding(<dylib>::<sym>,
// "<real>")`; the bindings below cover the kernel32 / msvcrt
// surface MSVC-shaped sources commonly reach for.

#pragma dylib(kernel32, "kernel32.dll")
#pragma dylib(msvcrt,   "msvcrt.dll")

#pragma binding(kernel32::GetModuleHandleA,   "GetModuleHandleA")
#pragma binding(kernel32::GetModuleHandleW,   "GetModuleHandleW")
#pragma binding(kernel32::GetProcAddress,     "GetProcAddress")
#pragma binding(kernel32::CloseHandle,        "CloseHandle")
#pragma binding(kernel32::GetLastError,       "GetLastError")
#pragma binding(kernel32::GetProcessId,       "GetProcessId")
#pragma binding(kernel32::lstrcpyA,           "lstrcpyA")
#pragma binding(kernel32::lstrcpyW,           "lstrcpyW")
#pragma binding(kernel32::lstrlenA,           "lstrlenA")
#pragma binding(kernel32::lstrlenW,           "lstrlenW")
#pragma binding(kernel32::MultiByteToWideChar, "MultiByteToWideChar")
#pragma binding(kernel32::WideCharToMultiByte, "WideCharToMultiByte")
#pragma binding(kernel32::CreateFileA,        "CreateFileA")
#pragma binding(kernel32::CreateFileW,        "CreateFileW")
#pragma binding(kernel32::CreateFileTransactedA, "CreateFileTransactedA")
#pragma binding(kernel32::CreateFileTransactedW, "CreateFileTransactedW")
#pragma binding(kernel32::ExitProcess,        "ExitProcess")

#pragma binding(msvcrt::printf,   "printf")
#pragma binding(msvcrt::wprintf,  "wprintf")
#pragma binding(msvcrt::puts,     "puts")
#pragma binding(msvcrt::strlen,   "strlen")
#pragma binding(msvcrt::wcslen,   "wcslen")
#pragma binding(msvcrt::malloc,   "malloc")
#pragma binding(msvcrt::free,     "free")
#pragma binding(msvcrt::memcpy,   "memcpy")
#pragma binding(msvcrt::memset,   "memset")
#pragma binding(msvcrt::memcmp,   "memcmp")
#pragma binding(msvcrt::exit,     "exit")
// POSIX-shape names that sqlite3.c reaches for on Windows
// without including unistd.h. msvcrt exports them with a
// leading-underscore spelling; bind the unprefixed local name
// so a user extern decl resolves through the Token::Sys path
// rather than leaving the call as an unresolved cross-TU
// reference.
#pragma binding(msvcrt::getpid,   "_getpid")

// NOTE: `_CRT_INSECURE_DEPRECATE` / `_CRT_NONSTDC_DEPRECATE` /
// `_CRT_OBSOLETE` / `_CRT_DEPRECATE_TEXT` are deliberately NOT
// defined here. sqlite's `localtime_s` selector gates on
// `defined(_MSC_VER) && defined(_CRT_INSECURE_DEPRECATE)`; if the
// macro is visible, sqlite emits a `localtime_s()` call and the
// produced PE pulls `localtime_s` into its msvcrt IAT. The legacy
// `msvcrt.dll` shipped on github-hosted Windows runners does not
// export that symbol (it's a Secure-CRT addition that lives in
// `msvcr*.dll` / UCRT, never re-exported by `msvcrt.dll`), so
// the loader rejects the binary at startup with an unresolved-
// import failure that surfaces as exit-code 127. Leaving the
// macro undefined makes sqlite fall through to its plain
// `localtime` path. None of the third-party C we currently
// compile against actually *uses* the macro to mark its own
// functions, so the no-op definition isn't load-bearing -- only
// the visibility check is.

// `InterlockedCompareExchange` is not an export on
// modern Windows (Server 2019 / 2022 / 2025) -- in MSVC it's a
// compiler intrinsic (`_InterlockedCompareExchange` from
// <intrin.h>) that lowers inline to `lock cmpxchg`. A PE that
//
// The non-atomic implementation is *fine* for the single-threaded.
static int InterlockedCompareExchange(
    int volatile *dest, int exchange, int comparand
) {
    int original = *dest;
    if (original == comparand) *dest = exchange;
    return original;
}

#endif /* _WIN32 */

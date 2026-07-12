// versionhelpers.h -- OS version predicates, implemented over
// VerifyVersionInfoW exactly as the SDK header does.

#pragma once

#ifdef _WIN32
#include <windows.h>
#include <sdkddkver.h>

static inline BOOL IsWindowsVersionOrGreater(WORD wMajorVersion, WORD wMinorVersion,
                                             WORD wServicePackMajor) {
    OSVERSIONINFOEXW osvi = {0};
    DWORDLONG mask = 0;
    VER_SET_CONDITION(mask, VER_MAJORVERSION, VER_GREATER_EQUAL);
    VER_SET_CONDITION(mask, VER_MINORVERSION, VER_GREATER_EQUAL);
    VER_SET_CONDITION(mask, VER_SERVICEPACKMAJOR, VER_GREATER_EQUAL);
    osvi.dwOSVersionInfoSize = sizeof(osvi);
    osvi.dwMajorVersion = wMajorVersion;
    osvi.dwMinorVersion = wMinorVersion;
    osvi.wServicePackMajor = wServicePackMajor;
    return VerifyVersionInfoW(&osvi,
                              VER_MAJORVERSION | VER_MINORVERSION | VER_SERVICEPACKMAJOR,
                              mask) != 0;
}

static inline BOOL IsWindowsXPOrGreater(void) {
    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 0);
}

static inline BOOL IsWindowsVistaOrGreater(void) {
    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 0);
}

static inline BOOL IsWindows7OrGreater(void) {
    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 0);
}

static inline BOOL IsWindows7SP1OrGreater(void) {
    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 1);
}

static inline BOOL IsWindows8OrGreater(void) {
    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN8), LOBYTE(_WIN32_WINNT_WIN8), 0);
}

static inline BOOL IsWindows8Point1OrGreater(void) {
    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINBLUE), LOBYTE(_WIN32_WINNT_WINBLUE), 0);
}

// TODO: IsWindows10OrGreater needs the manifest-gated
// RtlGetVersion/VerifyVersionInfo semantics change; IsWindowsServer
// needs VER_PRODUCT_TYPE.
#endif

// utime.h -- set file access and modification times (POSIX 7.49).

#pragma once

#include <time.h>

// POSIX `struct utimbuf`: the two `time_t` second counts passed to
// `utime`. Layout matches the libc shape on every supported target
// (two 8-byte `time_t` fields).
struct utimbuf {
    time_t actime;  // access time
    time_t modtime; // modification time
};

#ifdef __APPLE__
#pragma binding(libc::utime, "_utime")
#endif

#ifdef __linux__
#pragma binding(libc::utime, "utime")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::utime, "_utime")
// The CRT's underscored spellings, which mingw-w64's <utime.h> declares
// beside the POSIX one: `struct _utimbuf` has `struct utimbuf`'s layout.
struct _utimbuf {
    time_t actime;
    time_t modtime;
};

#pragma binding(msvcrt::_utime, "_utime")
#pragma binding(msvcrt::_futime, "_futime")
#pragma binding(msvcrt::_wutime, "_wutime")

int _utime(const char *path, struct _utimbuf *times);
int _futime(int fd, struct _utimbuf *times);
int _wutime(const unsigned short *path, struct _utimbuf *times);
#endif

// POSIX: set the access and modification times of `path` to the values in
// `times`, or to the current time when `times` is NULL. Returns 0 on success,
// -1 on error.
int utime(const char *path, const struct utimbuf *times);

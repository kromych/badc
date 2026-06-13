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
#pragma binding(msvcrt::utime, "_utime")
#endif

// POSIX: set the access and modification times of `path` to the values in
// `times`, or to the current time when `times` is NULL. Returns 0 on success,
// -1 on error.
int utime(const char *path, const struct utimbuf *times);

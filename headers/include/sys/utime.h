// sys/utime.h -- the CRT home of the file-time interface; the POSIX
// spellings live in <utime.h>. The underscored CRT spellings are
// declared here on Windows.

#pragma once

#include <utime.h>

#ifdef _WIN32
// Same layout as `struct utimbuf`: two 8-byte time_t second counts.
struct _utimbuf {
    time_t actime;
    time_t modtime;
};

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_utime, "_utime")
#pragma binding(msvcrt::_futime, "_futime")
#pragma binding(msvcrt::_wutime, "_wutime")

int _utime(const char *path, struct _utimbuf *times);
int _futime(int fd, struct _utimbuf *times);
int _wutime(const unsigned short *path, struct _utimbuf *times);
#endif

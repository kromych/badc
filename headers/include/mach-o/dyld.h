// mach-o/dyld.h -- the subset of Darwin's dynamic-loader surface badc
// programs reach for. macOS only.

#pragma once

#ifdef __APPLE__
#include <stdint.h>

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::_NSGetExecutablePath, "__NSGetExecutablePath")

// Copy the executable's path into `buf`. On entry `*bufsize` is the
// buffer size; on a too-small buffer it is set to the required size and
// the call returns -1, otherwise 0.
int _NSGetExecutablePath(char *buf, uint32_t *bufsize);
#endif

// sys/param.h -- historical BSD system limits and parameters.

#pragma once

#include <limits.h>
#include <sys/types.h>

// Filesystem and identity limits, the C library's: programs size buffers
// for paths and host names with them.
#ifdef __linux__
#define MAXPATHLEN     4096
#define MAXHOSTNAMELEN 64
#define MAXSYMLINKS    20
#define NGROUPS        65536
#elif defined(_WIN32)
#define MAXPATHLEN     260
#define MAXHOSTNAMELEN 256
#define MAXSYMLINKS    32
#define NGROUPS        16
#else
#define MAXPATHLEN     1024
#define MAXHOSTNAMELEN 256
#define MAXSYMLINKS    32
#define NGROUPS        16
#endif
#ifndef MAXLOGNAME
#define MAXLOGNAME 255
#endif
#ifndef NOFILE
#define NOFILE 256
#endif

// The device number no device has (stat's st_rdev of a non-device file).
#ifndef NODEV
#define NODEV ((dev_t)-1)
#endif

#ifndef MIN
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#endif
#ifndef MAX
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#endif

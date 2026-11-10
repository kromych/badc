// sys/param.h -- historical BSD system limits and parameters.

#pragma once

#include <limits.h>
#include <sys/types.h>

// Filesystem and identity limits. The values match the supported hosts
// (macOS / Linux agree on these); programs use them to size stack
// buffers for paths, hostnames, and login names.
#ifndef MAXPATHLEN
#define MAXPATHLEN 1024
#endif
#ifndef MAXHOSTNAMELEN
#define MAXHOSTNAMELEN 256
#endif
#ifndef MAXLOGNAME
#define MAXLOGNAME 255
#endif
#ifndef MAXSYMLINKS
#define MAXSYMLINKS 32
#endif
#ifndef NGROUPS
#define NGROUPS 16
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

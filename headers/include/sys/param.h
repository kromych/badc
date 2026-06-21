// sys/param.h -- historical BSD system limits and parameters.

#pragma once

#include <limits.h>

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

#ifndef MIN
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#endif
#ifndef MAX
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#endif

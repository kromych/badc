// sys/syslimits.h -- BSD/macOS kernel-imposed limits.
//
// On the BSD-derived hosts these constants live here rather than in
// <limits.h>; portable code includes this header (often guarded by
// __APPLE__) to size path and argument buffers. The path / name limits
// come from <limits.h>; this header adds the remaining historical
// constants. Values match the supported hosts.

#pragma once

#include <limits.h>

#ifndef ARG_MAX
#define ARG_MAX 262144
#endif
#ifndef CHILD_MAX
#define CHILD_MAX 266
#endif
#ifndef LINK_MAX
#define LINK_MAX 32767
#endif
#ifndef MAX_CANON
#define MAX_CANON 1024
#endif
#ifndef MAX_INPUT
#define MAX_INPUT 1024
#endif
#ifndef NAME_MAX
#define NAME_MAX 255
#endif
#ifndef NGROUPS_MAX
#define NGROUPS_MAX 16
#endif
#ifndef OPEN_MAX
#define OPEN_MAX 10240
#endif
#ifndef PATH_MAX
#define PATH_MAX 1024
#endif
#ifndef PIPE_BUF
#define PIPE_BUF 512
#endif

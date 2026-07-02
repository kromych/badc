// linux/limits.h -- kernel uapi limits. The names <limits.h> and
// <sys/syslimits.h> also define are guarded so either include order
// holds.

#pragma once

#ifdef __linux__
#define NR_OPEN 1024
#ifndef NGROUPS_MAX
#define NGROUPS_MAX 65536
#endif
#ifndef ARG_MAX
#define ARG_MAX 131072
#endif
#define LINK_MAX 127
#define MAX_CANON 255
#define MAX_INPUT 255
#ifndef NAME_MAX
#define NAME_MAX 255
#endif
#ifndef PATH_MAX
#define PATH_MAX 4096
#endif
#define PIPE_BUF 4096
#define XATTR_NAME_MAX 255
#define XATTR_SIZE_MAX 65536
#define XATTR_LIST_MAX 65536
#define RTSIG_MAX 32
#endif

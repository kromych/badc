// fcntl.h -- file control flags (subset).
//
// Just the `O_*` constants the c4 fixture surface uses. `open()`
// itself is bound in <unistd.h>, where POSIX puts it; pulling fcntl
// in only when you need the flags keeps the binding sets terse.

#pragma once

#define O_RDONLY 0
#define O_WRONLY 1
#define O_RDWR   2

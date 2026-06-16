#pragma once

// sys/sendfile.h -- copy data between two descriptors in the kernel
// (Linux). macOS/BSD spell a different `sendfile` through <sys/socket.h>.

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::sendfile, "sendfile")

// `offset` (in/out) may be null to use and advance `in_fd`'s own offset.
long sendfile(int out_fd, int in_fd, long *offset, unsigned long count);
#endif

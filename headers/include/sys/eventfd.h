#pragma once

// sys/eventfd.h -- an eventfd object: a descriptor backed by a 64-bit
// counter, usable for wait/notify (Linux).

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::eventfd,       "eventfd")
#pragma binding(libc::eventfd_read,  "eventfd_read")
#pragma binding(libc::eventfd_write, "eventfd_write")
#endif

#define EFD_SEMAPHORE 00000001
#define EFD_CLOEXEC   02000000
#define EFD_NONBLOCK  00004000

typedef unsigned long long eventfd_t;

int eventfd(unsigned int initval, int flags);
int eventfd_read(int fd, eventfd_t *value);
int eventfd_write(int fd, eventfd_t value);

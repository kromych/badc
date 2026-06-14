// Process scheduling (POSIX.1). Only the portable thread-yield is
// declared; the priority and policy surface is not bound.

#ifndef _SCHED_H
#define _SCHED_H

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::sched_yield, "_sched_yield")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::sched_yield, "sched_yield")
#endif

int sched_yield(void);

#endif

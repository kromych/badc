// linux/sched.h -- scheduling policies from the kernel uapi header.
// The glibc-visible trio carries the same values as <sched.h>;
// SCHED_NORMAL is the kernel spelling of SCHED_OTHER. TODO: the
// CLONE_* flags and struct clone_args.

#pragma once

#ifdef __linux__
#define SCHED_NORMAL 0
#define SCHED_FIFO 1
#define SCHED_RR 2
#define SCHED_BATCH 3
#define SCHED_IDLE 5
#define SCHED_DEADLINE 6
#endif

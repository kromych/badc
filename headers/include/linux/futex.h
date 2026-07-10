// linux/futex.h -- futex operation selectors from the kernel uapi header.
// The syscall itself is issued via syscall(__NR_futex, ...) (see
// <sys/syscall.h>); only the operation constants are needed at compile
// time. Self-contained, matching the other bundled linux/ shims.

#pragma once

#ifdef __linux__
#define FUTEX_WAIT             0
#define FUTEX_WAKE             1
#define FUTEX_FD               2
#define FUTEX_REQUEUE          3
#define FUTEX_CMP_REQUEUE      4
#define FUTEX_WAKE_OP          5
#define FUTEX_LOCK_PI          6
#define FUTEX_UNLOCK_PI        7
#define FUTEX_TRYLOCK_PI       8
#define FUTEX_WAIT_BITSET      9
#define FUTEX_WAKE_BITSET     10
#define FUTEX_WAIT_REQUEUE_PI 11
#define FUTEX_CMP_REQUEUE_PI  12

#define FUTEX_PRIVATE_FLAG   128
#define FUTEX_CLOCK_REALTIME 256
#define FUTEX_CMD_MASK       (~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME))

#define FUTEX_WAIT_PRIVATE (FUTEX_WAIT | FUTEX_PRIVATE_FLAG)
#define FUTEX_WAKE_PRIVATE (FUTEX_WAKE | FUTEX_PRIVATE_FLAG)
#endif

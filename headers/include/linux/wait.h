// linux/wait.h -- the waitid id-type selectors from the kernel uapi
// header. P_PIDFD (Linux 5.4) has no glibc <sys/wait.h> counterpart;
// the first three shadow the idtype_t enumerators with equal values.

#pragma once

#ifdef __linux__
#define P_ALL 0
#define P_PID 1
#define P_PGID 2
#define P_PIDFD 3
#endif

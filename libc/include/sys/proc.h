// sys/proc.h -- Darwin process state codes and p_flag bits. Values match
// the macOS SDK header of the same name. macOS only.
//
// `struct extern_proc` and the pgrp / session aggregates the SDK header
// also declares are the kernel's own layout, reached through the
// KERN_PROC sysctl; their fields need rusage, itimerval and the BSD
// scalar typedefs badc does not carry, so they are left out.

#pragma once

#ifdef __APPLE__
// p_stat: the process state.
#define SIDL   1
#define SRUN   2
#define SSLEEP 3
#define SSTOP  4
#define SZOMB  5

// p_flag bits.
#define P_ADVLOCK        0x00000001
#define P_CONTROLT       0x00000002
#define P_LP64           0x00000004
#define P_NOCLDSTOP      0x00000008
#define P_PPWAIT         0x00000010
#define P_PROFIL         0x00000020
#define P_SELECT         0x00000040
#define P_CONTINUED      0x00000080
#define P_SUGID          0x00000100
#define P_SYSTEM         0x00000200
#define P_TIMEOUT        0x00000400
#define P_TRACED         0x00000800
#define P_DISABLE_ASLR   0x00001000
#define P_WEXIT          0x00002000
#define P_EXEC           0x00004000
#define P_OWEUPC         0x00008000
#define P_AFFINITY       0x00010000
#define P_TRANSLATED     0x00020000
#define P_CLASSIC        P_TRANSLATED
#define P_DELAYIDLESLEEP 0x00040000
#define P_CHECKOPENEVT   0x00080000
#define P_DEPENDENCY_CAPABLE 0x00100000
#define P_REBOOT         0x00200000
#define P_RESV6          0x00400000
#define P_RESV7          0x00800000
#define P_THCWD          0x01000000
#define P_RESV9          0x02000000
#define P_ADOPTPERSONA   0x04000000
#define P_RESV11         0x08000000
#define P_NOSHLIB        0x10000000
#define P_FORCEQUOTA     0x20000000
#define P_NOCLDWAIT      0x40000000
#define P_NOREMOTEHANG   0x80000000

// Retained by the platform for compilation only.
#define P_INMEM   0
#define P_NOSWAP  0
#define P_PHYSIO  0
#define P_FSTRACE 0
#define P_SSTEP   0

// Dirty-state tracking, as reported through proc_get_dirty().
#define P_DIRTY_TRACK              0x00000001
#define P_DIRTY_ALLOW_IDLE_EXIT    0x00000002
#define P_DIRTY_DEFER              0x00000004
#define P_DIRTY                    0x00000008
#define P_DIRTY_SHUTDOWN           0x00000010
#define P_DIRTY_TERMINATED         0x00000020
#define P_DIRTY_BUSY               0x00000040
#define P_DIRTY_MARKED             0x00000080
#define P_DIRTY_AGING_IN_PROGRESS  0x00000100
#define P_DIRTY_LAUNCH_IN_PROGRESS 0x00000200
#define P_DIRTY_DEFER_ALWAYS       0x00000400
#define P_DIRTY_SHUTDOWN_ON_CLEAN  0x00000800
#define P_DIRTY_IM_NEW_HERE        0x00001000

#define P_DIRTY_IS_DIRTY          (P_DIRTY | P_DIRTY_SHUTDOWN)
#define P_DIRTY_IDLE_EXIT_ENABLED (P_DIRTY_TRACK | P_DIRTY_ALLOW_IDLE_EXIT)
#endif

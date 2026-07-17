#pragma once

// sys/prctl.h -- operations on a process or thread (Linux).

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::prctl, "prctl")
#endif

// prctl option numbers.
#define PR_SET_PDEATHSIG    1
#define PR_SET_NAME         15
#define PR_SET_TIMERSLACK   29
#define PR_MCE_KILL         33
#define PR_SET_NO_NEW_PRIVS 38

// PR_MCE_KILL sub-operation (second argument).
#define PR_MCE_KILL_CLEAR   0
#define PR_MCE_KILL_SET     1
// PR_MCE_KILL_SET policy (third argument).
#define PR_MCE_KILL_LATE    0
#define PR_MCE_KILL_EARLY   1
#define PR_MCE_KILL_DEFAULT 2

int prctl(int option, ...);

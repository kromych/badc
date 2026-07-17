#pragma once

// ucontext.h -- user-level machine context switching (System V, Linux/aarch64).

#include <signal.h> // sigset_t, stack_t

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getcontext,  "getcontext")
#pragma binding(libc::setcontext,  "setcontext")
#pragma binding(libc::makecontext, "makecontext")
#pragma binding(libc::swapcontext, "swapcontext")
#endif

// Whole-processor state. Only the aarch64 core registers are named; FP/SIMD/SVE
// records occupy __reserved. The full size and 16-byte alignment are
// load-bearing: getcontext/makecontext/swapcontext write the entire object.
typedef struct {
    unsigned long long fault_address;
    unsigned long long regs[31];
    unsigned long long sp;
    unsigned long long pc;
    unsigned long long pstate;
    unsigned char __reserved[4096] __attribute__((aligned(16)));
} mcontext_t;

typedef struct ucontext_t {
    unsigned long      uc_flags;
    struct ucontext_t *uc_link;
    stack_t            uc_stack;
    sigset_t           uc_sigmask;
    mcontext_t         uc_mcontext;
} ucontext_t;

int  getcontext(ucontext_t *ucp);
int  setcontext(const ucontext_t *ucp);
void makecontext(ucontext_t *ucp, void (*func)(void), int argc, ...);
int  swapcontext(ucontext_t *oucp, const ucontext_t *ucp);

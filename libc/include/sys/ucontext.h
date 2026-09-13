#pragma once

// sys/ucontext.h -- the machine context of a signal handler or getcontext(),
// as the target's C library declares it.

#include <signal.h> // sigset_t, stack_t

#if defined(__APPLE__)
struct __darwin_arm_exception_state64 {
    unsigned long long __far;
    unsigned int       __esr;
    unsigned int       __exception;
};

struct __darwin_arm_thread_state64 {
    unsigned long long __x[29];
    unsigned long long __fp;
    unsigned long long __lr;
    unsigned long long __sp;
    unsigned long long __pc;
    unsigned int       __cpsr;
    unsigned int       __pad;
};

struct __darwin_arm_neon_state64 {
    unsigned __int128 __v[32];
    unsigned int      __fpsr;
    unsigned int      __fpcr;
};

struct __darwin_mcontext64 {
    struct __darwin_arm_exception_state64 __es;
    struct __darwin_arm_thread_state64    __ss;
    struct __darwin_arm_neon_state64      __ns;
};

typedef struct __darwin_mcontext64 *mcontext_t;

// The SDK embeds the machine context in the record only under _XOPEN_SOURCE.
typedef struct __darwin_ucontext {
    int                         uc_onstack;
    sigset_t                    uc_sigmask;
    stack_t                     uc_stack;
    struct __darwin_ucontext   *uc_link;
    size_t                      uc_mcsize;
    struct __darwin_mcontext64 *uc_mcontext;
#ifdef _XOPEN_SOURCE
    struct __darwin_mcontext64  __mcontext_data;
#endif
} ucontext_t;
#elif defined(__linux__) && defined(__x86_64__)
// General registers in the order of the kernel's sigcontext_64, and the
// 512-byte FXSAVE area of its _fpstate_64, under glibc's names.
typedef long long greg_t;
#define NGREG 23
typedef greg_t gregset_t[NGREG];

#ifdef _GNU_SOURCE
#define REG_R8      0
#define REG_R9      1
#define REG_R10     2
#define REG_R11     3
#define REG_R12     4
#define REG_R13     5
#define REG_R14     6
#define REG_R15     7
#define REG_RDI     8
#define REG_RSI     9
#define REG_RBP     10
#define REG_RBX     11
#define REG_RDX     12
#define REG_RAX     13
#define REG_RCX     14
#define REG_RSP     15
#define REG_RIP     16
#define REG_EFL     17
#define REG_CSGSFS  18
#define REG_ERR     19
#define REG_TRAPNO  20
#define REG_OLDMASK 21
#define REG_CR2     22
#endif

struct _libc_fpxreg {
    unsigned short significand[4];
    unsigned short exponent;
    unsigned short __glibc_reserved1[3];
};

struct _libc_xmmreg {
    unsigned int element[4];
};

struct _libc_fpstate {
    unsigned short     cwd;
    unsigned short     swd;
    unsigned short     ftw;
    unsigned short     fop;
    unsigned long long rip;
    unsigned long long rdp;
    unsigned int       mxcsr;
    unsigned int       mxcr_mask;
    struct _libc_fpxreg _st[8];
    struct _libc_xmmreg _xmm[16];
    unsigned int       __glibc_reserved1[24];
};

typedef struct _libc_fpstate *fpregset_t;

typedef struct {
    gregset_t          gregs;
    fpregset_t         fpregs;
    unsigned long long __reserved1[8];
} mcontext_t;

typedef struct ucontext_t {
    unsigned long        uc_flags;
    struct ucontext_t   *uc_link;
    stack_t              uc_stack;
    mcontext_t           uc_mcontext;
    sigset_t             uc_sigmask;
    struct _libc_fpstate __fpregs_mem;
    unsigned long long   __ssp[4];
} ucontext_t;
#elif defined(__linux__)
// glibc's aarch64 register word and set: the 34 words of the kernel's
// user_pt_regs.
typedef unsigned long greg_t;
typedef greg_t gregset_t[34];

// Whole-processor state. Only the aarch64 core registers are named; FP/SIMD/SVE
// records occupy __reserved. The full size and 16-byte alignment are required:
// getcontext/makecontext/swapcontext write the entire object.
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
#endif

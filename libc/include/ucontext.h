#pragma once

// ucontext.h -- user-level context switching (System V). The context types
// come from <sys/ucontext.h>.

#include <sys/ucontext.h>

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getcontext,  "getcontext")
#pragma binding(libc::setcontext,  "setcontext")
#pragma binding(libc::makecontext, "makecontext")
#pragma binding(libc::swapcontext, "swapcontext")
#endif

#if defined(__APPLE__) || defined(__linux__)
int  getcontext(ucontext_t *ucp);
int  setcontext(const ucontext_t *ucp);
void makecontext(ucontext_t *ucp, void (*func)(void), int argc, ...);
int  swapcontext(ucontext_t *oucp, const ucontext_t *ucp);
#endif

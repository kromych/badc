// Locks the Windows x86_64 alignment contract for `_setjmp`.
//
// MSVCRT's `_setjmp` saves xmm6..xmm15 with
// `movdqa [env+0x60..0xC0], xmm*`, which raises an access
// violation unless `env` is 16-byte aligned. The header wraps the
// call in a function-like macro that aligns the pointer up at the
// user call site, so an `env` that arrives 4 bytes off must still
// reach `_setjmp` without faulting.
//
// The fixture exercises the setjmp side only. On x86_64 Windows
// msvcrt's `longjmp` calls `RtlUnwindEx`, which consults the
// per-function `UNWIND_INFO` to walk frames; c5 currently emits a
// single trivial entry covering all of `.text`, so the unwinder
// cannot follow the real `push rbp / sub rsp, N` prologues and
// faults. Round-tripping through `longjmp` therefore needs proper
// per-function unwind data (TODO).
//
// On non-Windows-x86_64 hosts the alignment requirement does not
// apply; the body is compile-only coverage of the header surface.

#include <setjmp.h>
#include <stdlib.h>

#if defined(_WIN32) && !defined(__aarch64__)
int main(void) {
    long long *raw = (long long *)malloc(sizeof(jmp_buf) + 32);
    if (raw == (long long *)0) return 1;

    // Force env 4 bytes past the malloc boundary. The 32-byte slack
    // keeps the aligned region inside the allocation regardless of
    // malloc's own alignment.
    long long *env = (long long *)((char *)raw + 4);

    long long *aligned = (long long *)(((unsigned long long)env + 15ULL) & ~15ULL);
    if (((unsigned long long)aligned & 15ULL) != 0ULL) {
        free(raw);
        return 4;
    }
    if ((char *)aligned + 256 > (char *)raw + sizeof(jmp_buf) + 32) {
        free(raw);
        return 5;
    }

    int rc = setjmp(env);
    free(raw);
    return rc;
}
#else
int main(void) { return 0; }
#endif

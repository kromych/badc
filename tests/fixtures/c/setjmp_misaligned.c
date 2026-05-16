// Locks the Windows x86_64 alignment contract for `_setjmp`.
//
// MSVCRT's `_setjmp` saves xmm6..xmm15 with
// `movdqa [env+0x60..0xC0], xmm*`, which raises an access
// violation unless `env` is 16-byte aligned. The header wraps the
// call in a function-like macro that aligns the pointer up at the
// user call site, so an `env` that arrives 4 bytes off must still
// round-trip through setjmp / longjmp without faulting.
//
// On non-Windows-x86_64 hosts the alignment requirement does not
// apply; the body is compile-only coverage of the header surface.
//
// The fixture returns distinct nonzero codes for every detectable
// failure mode (allocation, alignment math, the round-trip return
// value), so a regression points directly at the failing step
// rather than collapsing into a single AV.

#include <setjmp.h>
#include <stdlib.h>

#if defined(_WIN32) && !defined(__aarch64__)
int main(void) {
    long long *raw = (long long *)malloc(sizeof(jmp_buf) + 32);
    if (raw == (long long *)0) return 1;

    // Force env 4 bytes past the malloc boundary. With 32 bytes of
    // slack ahead of the typedef size, the aligned env always lies
    // inside the allocation regardless of malloc's own alignment
    // (msvcrt's `malloc` is documented to return 16-byte aligned
    // blocks for sizes >= 16, but the +32 keeps the test resilient
    // even if a host CRT only delivers 8-byte alignment).
    long long *env = (long long *)((char *)raw + 4);

    // Validate the alignment computation before exercising setjmp.
    long long *aligned = (long long *)(((unsigned long long)env + 15ULL) & ~15ULL);
    if (((unsigned long long)aligned & 15ULL) != 0ULL) {
        free(raw);
        return 4;
    }
    if ((char *)aligned < (char *)raw) {
        free(raw);
        return 5;
    }
    if ((char *)aligned + 256 > (char *)raw + sizeof(jmp_buf) + 32) {
        free(raw);
        return 6;
    }

    int rc = setjmp(env);
    if (rc == 0) {
        longjmp(env, 7);
        free(raw);
        return 2;
    }
    free(raw);
    return rc == 7 ? 0 : 3;
}
#else
int main(void) { return 0; }
#endif

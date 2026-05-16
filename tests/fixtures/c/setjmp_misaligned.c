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

#include <setjmp.h>
#include <stdlib.h>

#if defined(_WIN32) && !defined(__aarch64__)
int main(void) {
    long long *raw = (long long *)malloc(sizeof(jmp_buf) + 16);
    if (raw == (long long *)0) return 1;

    // Force the env pointer 4 bytes past the malloc boundary.
    // Real msvcrt returns 16-byte aligned blocks, so this lands at
    // `addr % 16 == 4`, which faults under `movdqa` without the
    // alignment fix.
    long long *env = (long long *)((char *)raw + 4);

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

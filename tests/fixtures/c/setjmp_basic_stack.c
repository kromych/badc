// Bottom-up check that setjmp / longjmp work at all through the
// c5 `<setjmp.h>` surface. Stack-local `jmp_buf`, no misalignment
// exercise. C99 7.13.1.1 paragraph 1: the initial call returns 0.

#include <setjmp.h>

int main(void) {
    jmp_buf env;
    int rc = setjmp(env);
    return rc;
}

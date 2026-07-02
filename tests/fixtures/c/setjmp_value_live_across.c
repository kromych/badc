/* C99 7.13.2.1p3: a value unmodified since setjmp keeps its value on
   the second return. The setjmp site must be a call barrier for the
   allocator so the value survives in a callee-saved register or on
   the stack (the inline windows-arm64 expansion restores only the
   jmp_buf register set). */
#include <setjmp.h>
#include <stdlib.h>

static jmp_buf b;

static void h(void) { longjmp(b, 1); }

int test(int a, int c) {
    int x = a * 7 + c;
    if (setjmp(b)) {
        return x;
    }
    h();
    return 0;
}

int main(void) {
    return test(5, 7) == 42 ? 0 : 1;
}

// A call to a function that does not return ends its block (C11 6.7.4p8):
// `longjmp` is declared so, `die` and `wrap` have no path that returns, and
// `spin` loops without an exit. A sealed call that did return would run
// into the trap after it. The jump lands back in `main` with the value
// `via_return` passed down. Returns 0 when it does.

#include <setjmp.h>

static jmp_buf env;
static int calls;

static void die(int code) {
    calls++;
    longjmp(env, code);
}

static int wrap(int code) {
    die(code + calls);
    return 99;
}

__attribute__((noinline)) static long via_return(int code) {
    return wrap(code);
}

static void spin(void) {
    for (;;) {
    }
}

__attribute__((noinline)) static int maybe_spin(int k) {
    if (k > 100)
        spin();
    return k + 1;
}

int main(void) {
    int r;
    if (maybe_spin(1) != 2)
        return 1;
    r = setjmp(env);
    if (r == 0) {
        via_return(4);
        return 3;
    }
    return r == 4 && calls == 1 ? 0 : 2;
}

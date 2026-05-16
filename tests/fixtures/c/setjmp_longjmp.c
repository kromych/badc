// Locks the `<setjmp.h>` surface that ships with the c5 dialect.
//
// C99 7.13.1.1: `setjmp` returns 0 directly. C99 7.13.2.1:
// `longjmp(env, val)` causes the corresponding `setjmp` to
// appear to return `val` (or `1` if `val` was zero). Volatile-
// qualified locals modified between `setjmp` and `longjmp`
// retain their last value.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code so a regression points at the
// failing clause.

#include <setjmp.h>

struct error_state {
    jmp_buf env;
    int     code;
};

static void trigger(struct error_state *s, int n) {
    s->code = n;
    longjmp(s->env, n);
}

int main(void) {
    // jmp_buf must be embeddable in a struct -- C99 7.13 lets
    // an implementation pick any object type for `jmp_buf` and
    // many real-world error-recovery designs hold one as a
    // struct field.
    struct error_state s;
    if (sizeof(s.env) < 64) return 11;

    volatile int counter = 0;
    int rc = setjmp(s.env);
    if (rc == 0) {
        counter = counter + 1;
        trigger(&s, 7);
        return 12; // unreachable
    }

    // After longjmp, control returns through `setjmp` with the
    // value supplied to `longjmp` (here 7). `counter` is volatile,
    // so the increment above must be visible.
    if (rc != 7) return 13;
    if (counter != 1) return 14;
    if (s.code != 7) return 15;
    return 0;
}

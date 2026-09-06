/* C99 6.3.1.1 / 6.5.2.2: a prototyped `int` return arrives in the low
   word of the result register with the rest left as the callee had it,
   so a caller reading it at 64 bits normalizes it first. The
   normalization is worth one instruction per value: in `via_int_slot`
   the result is bound to an `int` object, whose store keeps the low word
   and whose sign-extending reload serves the wider use, so widening at
   the call site as well produces bits nothing reads.

   `direct_libc_use` and `pointer_offset` read the same result at 64 bits
   with no object in between and keep their one widening at the call.
   `via_user_slot` and `direct_use` call a definition in this unit, which
   returns a value already correct in all 64 bits and needs none.
   Negative results make a missing widening visible in the exit code. */
#include <stdlib.h>

static int negate(int a);

static long via_user_slot(int a) {
    int n = negate(a);
    return (long)n;
}

static long direct_use(int a) { return (long)negate(a); }

static long via_int_slot(const char *s) {
    int n = atoi(s);
    return (long)n;
}

static long direct_libc_use(const char *s) { return (long)atoi(s); }

static long pointer_offset(const char *base, const char *s) {
    return (long)(base + atoi(s) - base);
}

static int negate(int a) { return -a; }

int main(void) {
    static const char text[] = "hello";
    if (via_user_slot(5) != -5) return 1;
    if (via_user_slot(-7) != 7) return 2;
    if (direct_use(9) != -9) return 3;
    if (via_int_slot("-2147483648") != -2147483648L) return 4;
    if (via_int_slot("42") != 42L) return 5;
    if (direct_libc_use("-1") != -1L) return 6;
    if (pointer_offset(text, "3") != 3L) return 7;
    return 0;
}

#include <stdarg.h>

/* Enough simultaneously live temporaries that the va_list address
   operands spill and rax/rcx/rdx carry live values across va_copy. */
static long f(long m, ...) {
    va_list ap, aq;
    long t1 = m * 3;
    long t2 = m + 11;
    long t3 = m * 7;
    long t4 = m - 2;
    long t5 = m * 13;
    long t6 = m + 29;
    long t7 = m * 4;
    long t8 = m + 41;
    long t9 = m * 9;
    long t10 = m + 53;
    long t11 = m * 5;
    long t12 = m + 61;
    long t13 = m * 15;
    long t14 = m + 3;
    va_start(ap, m);
    va_copy(aq, ap);
    long a = va_arg(aq, long);
    long b = va_arg(aq, long);
    va_end(aq);
    va_end(ap);
    return t1 + t2 + t3 + t4 + t5 + t6 + t7 + t8 + t9 + t10 + t11 + t12 + t13 + t14 + a + b;
}

int main(void) {
    long got = f(2, 10L, 20L);
    long want = 6 + 13 + 14 + 0 + 26 + 31 + 8 + 43 + 18 + 55 + 10 + 63 + 30 + 5 + 10 + 20;
    return got == want ? 0 : 1;
}

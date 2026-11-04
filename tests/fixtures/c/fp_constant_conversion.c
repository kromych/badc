/* A floating conversion of a constant (C99 6.3.1.4, 6.3.1.5) gives the
   value the conversion at run time gives: a `float` widened at a variadic
   call (6.5.2.2p6), a `double` rounded to `float`, integers converted to
   and from `double`. */
#include <stdarg.h>

static int check(int n, ...) {
    static const double want[] = { 1.5, 2.5, 3.0, -7.0, 18446744073709551616.0 };
    va_list ap;
    int bad = 0, i;
    va_start(ap, n);
    for (i = 0; i < n; i++) {
        bad += va_arg(ap, double) != want[i];
    }
    va_end(ap);
    return bad;
}

int main(void) {
    volatile float tenth = 0.1f;
    float narrowed = (float)0.1;
    int bad = check(5, 1.5f, 2.5f, (float)3, (double)(long)-7,
                    (double)18446744073709551615ULL);
    if (narrowed != tenth) bad++;
    if ((int)-2.75 != -2 || (unsigned long)3e9 != 3000000000UL) bad++;
    if ((long long)-9223372036854775808.0 != (-9223372036854775807LL - 1)) bad++;
    return bad;
}

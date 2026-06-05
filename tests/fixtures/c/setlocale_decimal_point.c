// C99 7.11.1.1: setlocale(LC_ALL, name) must update every category
// including LC_NUMERIC, after which localeconv()->decimal_point
// reflects the new locale. Glibc, msvcrt, and Darwin libc agree
// on the semantic but disagree on the numeric value each LC_*
// macro takes (the values are implementation-defined per C99
// 7.11p1). If the badc-side <locale.h> ships a fixed set that
// matches one host but not the other, setlocale(LC_ALL, ...)
// gets the wrong category code and LC_NUMERIC stays at C, so
// strtod / sprintf keep using "." as the decimal point even
// though the locale was "set".

#include <stdio.h>
#include <locale.h>
#include <string.h>

int main(void) {
    // C locale is the start state; decimal_point is ".".
    struct lconv *lc = localeconv();
    if (strcmp(lc->decimal_point, ".") != 0) {
        fprintf(stderr, "startup decimal_point != '.', got '%s'\n",
                lc->decimal_point);
        return 1;
    }
    // Switching to a locale that uses ',' must propagate to
    // LC_NUMERIC. Try pt_BR (glibc) and pt_BR.UTF-8; if neither
    // is installed we skip rather than fail.
    const char *r = setlocale(LC_ALL, "pt_BR");
    if (r == NULL) {
        r = setlocale(LC_ALL, "pt_BR.UTF-8");
    }
    if (r == NULL) {
        printf("skip\n");
        return 0;
    }
    lc = localeconv();
    if (strcmp(lc->decimal_point, ",") != 0) {
        fprintf(stderr,
                "after setlocale(LC_ALL, \"%s\") decimal_point='%s', "
                "expected ','\n",
                r, lc->decimal_point);
        return 1;
    }
    printf("ok\n");
    return 0;
}

// C99 7.19.6.4 and 7.19.6.2 on the standard input: scanf and fscanf read
// through one buffer, a field ends where the input stops matching, and the
// end of input makes the count EOF. The "C" locale is the one in effect
// (7.11.1.1p4), with "." as its decimal point (7.11.2.1).

#include <locale.h>
#include <stdio.h>

int main(void) {
    int a = 0, b = 0;
    double d = 0;
    char word[16] = "";
    int n = scanf("%d,%d", &a, &b);
    int m = fscanf(stdin, "%lf %15s", &d, word);
    printf("%d %d %d %d %g %s ", n, a, b, m, d, word);
    printf("%d\n", scanf("%d", &a));
    struct lconv *lc = localeconv();
    printf("%s [%s][%s] %d\n", setlocale(LC_ALL, 0), lc->decimal_point, lc->thousands_sep,
           lc->frac_digits);
    printf("%d\n", setlocale(LC_ALL, "xx_YY.bad") == 0);
    return 0;
}

// <xlocale.h> on macOS: the SDK's _l forms of the formatted I/O, numeric
// conversion, string, time, wide and classification functions take a
// locale_t and answer in it, localeconv_l and querylocale describe it, and
// _c_locale is the C locale. A locale whose decimal point is a comma
// formats and reads the comma where the C locale has the period.

#include <ctype.h>
#include <inttypes.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <wchar.h>
#include <wctype.h>
#include <xlocale.h>

static int in_c(locale_t c) {
    char buf[32];
    wchar_t wbuf[16];
    int n = 0;
    struct tm tm = {0};
    if (snprintf_l(buf, sizeof buf, c, "%.2f|%d", 2.5, 7) != 6 || strcmp(buf, "2.50|7"))
        return 1;
    if (sscanf_l("12 3.5", c, "%d %n", &n, &n) != 1 || n != 3 || strtod_l("1.25", NULL, c) != 1.25)
        return 2;
    if (strtol_l("0x1f", NULL, 0, c) != 31 || atoi_l("42", c) != 42 || strtoimax_l("-9", NULL, 10, c) != -9)
        return 3;
    if (!strcasestr_l("Hello World", "WORLD", c) || !strptime_l("1970-01-02", "%Y-%m-%d", &tm, c) ||
        tm.tm_mday != 2)
        return 4;
    if (swprintf_l(wbuf, 16, c, L"%ls-%d", L"ab", 3) != 4 || wcscmp(wbuf, L"ab-3") ||
        wcstol_l(L"77", NULL, 10, c) != 77 || wcwidth_l(L'a', c) != 1)
        return 5;
    if (!isnumber_l('7', c) || isnumber_l('x', c) || digittoint_l('f', c) != 15 ||
        !iswnumber_l(L'7', c) || !ishexnumber_l('b', c))
        return 6;
    if (strcmp(localeconv_l(c)->decimal_point, ".") || strcmp(querylocale(LC_NUMERIC_MASK, c), "C"))
        return 7;
    return 0;
}

int main(void) {
    char buf[32];
    int r;
    locale_t c = newlocale(LC_ALL_MASK, "C", NULL);
    if (!c)
        return 20;
    if ((r = in_c(c)) || (r = in_c(_c_locale)))
        return r;
    locale_t de = newlocale(LC_NUMERIC_MASK, "de_DE.UTF-8", NULL);
    if (de) {
        if (snprintf_l(buf, sizeof buf, de, "%.1f", 1.5) != 3 || strcmp(buf, "1,5") ||
            strtod_l("2,5", NULL, de) != 2.5 || strcmp(localeconv_l(de)->decimal_point, ","))
            return 21;
        freelocale(de);
    }
    freelocale(c);
    return 0;
}

// POSIX.1-2008 locale objects: newlocale makes a "C" locale_t, duplocale
// copies it, uselocale installs the copy for the calling thread and reports
// the one before, newlocale takes it as a base, and freelocale releases each.
// Each _l function of <ctype.h>, <wctype.h>, <string.h>, <strings.h>,
// <time.h>, <monetary.h>, <wchar.h> and <langinfo.h> answers in that locale
// as the C locale's rules say.

#include <ctype.h>
#include <langinfo.h>
#include <locale.h>
#include <monetary.h>
#include <string.h>
#include <strings.h>
#include <time.h>
#include <wchar.h>
#include <wctype.h>

static int classes(locale_t c) {
    if (!isalnum_l('7', c) || !isalpha_l('a', c) || !isblank_l('\t', c) || !iscntrl_l('\n', c))
        return 10;
    if (!isdigit_l('7', c) || !isgraph_l('#', c) || !islower_l('a', c) || !isprint_l(' ', c))
        return 11;
    if (!ispunct_l('#', c) || !isspace_l(' ', c) || !isupper_l('A', c) || !isxdigit_l('f', c))
        return 12;
    if (isalpha_l('7', c) || toupper_l('a', c) != 'A' || tolower_l('A', c) != 'a')
        return 13;
    if (!iswalnum_l(L'7', c) || !iswalpha_l(L'a', c) || !iswblank_l(L'\t', c) ||
        !iswcntrl_l(L'\n', c) || !iswdigit_l(L'7', c) || !iswgraph_l(L'#', c))
        return 14;
    if (!iswlower_l(L'a', c) || !iswprint_l(L' ', c) || !iswpunct_l(L'#', c) ||
        !iswspace_l(L' ', c) || !iswupper_l(L'A', c) || !iswxdigit_l(L'f', c))
        return 15;
    if (towupper_l(L'a', c) != L'A' || towlower_l(L'A', c) != L'a')
        return 16;
    wctype_t alpha = wctype_l("alpha", c);
    wctrans_t upper = wctrans_l("toupper", c);
    if (!alpha || !iswctype_l(L'a', alpha, c) || iswctype_l(L'7', alpha, c) ||
        towctrans_l(L'a', upper, c) != L'A')
        return 17;
    return 0;
}

static int strings(locale_t c) {
    char buf[32];
    wchar_t wbuf[8];
    struct tm tm = {0};
    tm.tm_year = 70;
    tm.tm_mday = 1;
    if (strcoll_l("a", "b", c) >= 0 || strxfrm_l(buf, "abc", sizeof buf, c) != 3)
        return 20;
    if (strcasecmp_l("ABC", "abc", c) != 0 || strncasecmp_l("ABx", "aby", 2, c) != 0)
        return 21;
    if (strftime_l(buf, sizeof buf, "%Y-%m-%d", &tm, c) != 10 || strcmp(buf, "1970-01-01"))
        return 22;
    if (strfmon_l(buf, sizeof buf, c, "[%n]", 1234.5) != 9 || strcmp(buf, "[1234.50]"))
        return 23;
    if (wcscoll_l(L"a", L"b", c) >= 0 || wcsxfrm_l(wbuf, L"ab", 8, c) != 2)
        return 24;
    if (wcscasecmp_l(L"AB", L"ab", c) || wcsncasecmp_l(L"ABx", L"aby", 2, c))
        return 25;
    const char *codeset = nl_langinfo_l(CODESET, c);
    if (!codeset || !*codeset)
        return 26;
#ifdef __linux__
    if (!strerror_l(2, c))
        return 27;
#endif
    return 0;
}

int main(void) {
    locale_t c = newlocale(LC_ALL_MASK, "C", (locale_t)0);
    locale_t d;
    int r;
    if (!c || !(d = duplocale(c)))
        return 1;
    locale_t before = uselocale(d);
    if (!before || uselocale((locale_t)0) != d || uselocale(before) != d)
        return 2;
    if ((r = classes(c)) || (r = strings(c)))
        return r;
    // newlocale takes `d` as its base, modified or freed.
    if (!(d = newlocale(LC_CTYPE_MASK | LC_NUMERIC_MASK, "C", d)))
        return 3;
    freelocale(d);
    freelocale(c);
    return LC_GLOBAL_LOCALE != (locale_t)0 ? 0 : 4;
}

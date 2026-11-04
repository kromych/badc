// On Windows, <wchar.h> declares the UCRT's corecrt_wstring.h functions,
// <locale.h> declares _wsetlocale, and <stdlib.h> declares the number
// conversions under a locale object. Each runs here against msvcrt.dll. A
// _wsetlocale change reaches strtod as setlocale's does, and
// _strtod_l reads the decimal point of the locale it is given. Elsewhere
// the unit is empty. The exit code is the line of the first mismatch.

#ifdef _WIN32
#include <errno.h>
#include <locale.h>
#include <stdlib.h>
#include <wchar.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

static int same(const wchar_t *a, const wchar_t *b) {
    return wcscmp(a, b) == 0;
}

static int wide_strings(void) {
    _locale_t c = _create_locale(LC_ALL, "C");
    wchar_t *d = _wcsdup(L"Abc");
    CHECK(d && same(d, L"Abc"));
    CHECK(same(_wcsrev(d), L"cbA") && same(_wcsupr(d), L"CBA") && same(_wcslwr(d), L"cba"));
    CHECK(same(_wcsupr_l(d, c), L"CBA") && same(_wcslwr_l(d, c), L"cba"));
    CHECK(same(_wcsnset(d, L'x', 2), L"xxa") && same(_wcsset(d, L'y'), L"yyy"));
    free(d);
    d = wcsdup(L"qrs");
    CHECK(same(wcsrev(d), L"srq") && same(wcsupr(d), L"SRQ") && same(wcslwr(d), L"srq"));
    CHECK(same(wcsnset(d, L'z', 1), L"zrq") && same(wcsset(d, L'w'), L"www"));
    free(d);
    CHECK(_wcsicmp(L"ab", L"AB") == 0 && _wcsicmp_l(L"ab", L"AB", c) == 0);
    CHECK(_wcsnicmp(L"abX", L"ABy", 2) == 0 && _wcsnicmp_l(L"abX", L"ABy", 2, c) == 0);
    CHECK(wcsicmp(L"x", L"X") == 0 && wcsnicmp(L"xa", L"Xb", 1) == 0);
    CHECK(_wcsicoll(L"ab", L"AB") == 0 && _wcsicoll_l(L"ab", L"AB", c) == 0 &&
          wcsicoll(L"ab", L"AB") == 0);
    CHECK(_wcsncoll(L"abX", L"abY", 2) == 0 && _wcsncoll_l(L"abX", L"abY", 2, c) == 0);
    CHECK(_wcsnicoll(L"abX", L"ABY", 2) == 0 && _wcsnicoll_l(L"abX", L"ABY", 2, c) == 0);
    CHECK(_wcscoll_l(L"a", L"b", c) < 0);
    wchar_t buf[8];
    CHECK(_wcsxfrm_l(buf, L"ab", 8, c) == 2);
    CHECK(_wcserror(ENOENT) && __wcserror(L"x") && wcslen(_wcserror(ENOENT)) > 0);
    wchar_t s[] = L"a,b", t[] = L"c;d", *ctx = 0;
    CHECK(same(_wcstok(s, L","), L"a") && same(_wcstok(0, L","), L"b"));
    CHECK(same(wcstok(t, L";", &ctx), L"c") && same(wcstok(0, L";", &ctx), L"d"));
    _free_locale(c);
    return 0;
}

static int wide_locale(void) {
    CHECK(same(_wsetlocale(LC_ALL, L"C"), L"C") && same(_wsetlocale(LC_ALL, 0), L"C"));
    char *end;
    static const wchar_t *names[] = {L"German_Germany.1252", L"German", L"de-DE"};
    for (unsigned i = 0; i < sizeof names / sizeof *names; ++i) {
        if (!_wsetlocale(LC_NUMERIC, names[i]))
            continue;
        int comma = strtod("1,5", &end) == 1.5 && !*end;
        _wsetlocale(LC_ALL, L"C");
        CHECK(comma);
        break;
    }
    CHECK(same(_wsetlocale(LC_NUMERIC, 0), L"C") && strtod("1.5", &end) == 1.5 && !*end);
    return 0;
}

static int conversions(void) {
    _locale_t c = _create_locale(LC_ALL, "C");
    char *end;
    CHECK(_strtod_l("2.5x", &end, c) == 2.5 && *end == 'x');
    CHECK(_strtold_l("-0.25", &end, c) == -0.25L && !*end);
    CHECK(_strtof_l("1.5", &end, c) == 1.5f && !*end);
    errno = 0;
    float f = _strtof_l("1e39", &end, c);
    CHECK(f > 3.4e38f && errno == ERANGE);
    errno = 0;
    CHECK(_strtof_l("1e-50", 0, c) == 0 && errno == ERANGE);
    CHECK(_strtol_l("-ff", &end, 16, c) == -255 && !*end);
    CHECK(_strtoul_l("777", &end, 8, c) == 511ul);
    CHECK(_strtoi64_l("-9000000000", 0, 10, c) == -9000000000LL);
    CHECK(_strtoll_l("9000000000", 0, 10, c) == 9000000000LL);
    CHECK(_strtoui64_l("18000000000000000000", 0, 10, c) == 18000000000000000000ULL);
    CHECK(_strtoull_l("0x10", 0, 16, c) == 16);
    CHECK(_atof_l("3.75", c) == 3.75 && _atoi_l("-12", c) == -12 && _atol_l("34", c) == 34);
    CHECK(_atoi64_l("-5000000000", c) == -5000000000LL && _atoll_l("6000000000", c) == 6000000000LL);
    _locale_t de = _create_locale(LC_NUMERIC, "German_Germany.1252");
    if (de) {
        CHECK(_strtod_l("2,5", &end, de) == 2.5 && !*end && _atof_l("0,5", de) == 0.5);
        CHECK(_strtof_l("0,25", &end, de) == 0.25f && !*end);
        CHECK(strtod("2,5", &end) == 2.0 && *end == ',');
        _free_locale(de);
    }
    _free_locale(c);
    return 0;
}

int main(void) {
    int line = wide_strings();
    if (!line)
        line = wide_locale();
    if (!line)
        line = conversions();
    return line;
}
#else
int main(void) {
    return 0;
}
#endif

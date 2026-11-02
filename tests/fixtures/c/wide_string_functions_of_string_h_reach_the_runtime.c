// The wide-string functions <string.h> declares on Windows, as the UCRT's
// does, over msvcrt.dll: lengths, copies and appends with their bounds-checked
// forms, compares and collation with the locale forms, searches, tokenizing in
// both forms, case mapping, reversal and filling, duplication and error text.

#ifdef _WIN32
#include <errno.h>
#include <stdlib.h>
#include <string.h>

static int copies(void) {
    wchar_t buf[16];
    if (wcslen(L"abcd") != 4 || wcsnlen(L"abcd", 2) != 2 || wcsnlen_s(NULL, 4) != 0)
        return 1;
    if (wcscpy_s(buf, 16, L"ab") || wcscat_s(buf, 16, L"cd") || wcscmp(buf, L"abcd"))
        return 2;
    if (wcsncpy_s(buf, 4, L"abcdef", _TRUNCATE) != STRUNCATE || wcscmp(buf, L"abc"))
        return 3;
    if (wcsncat_s(buf, 16, L"xyz", 1) || wcscmp(buf, L"abcx"))
        return 4;
    wcscpy(buf, L"ab");
    if (wcscmp(wcsncat(buf, L"cde", 2), L"abcd") || wcscmp(wcscat(buf, L"e"), L"abcde"))
        return 5;
    if (wcscmp(wcsncpy(buf, L"xy", 3), L"xy") || wcsxfrm(buf, L"abc", 16) != 3)
        return 6;
    if (_wcsxfrm_l(buf, L"abcd", 16, NULL) != 4 || wcscmp(buf, L"abcd"))
        return 7;
    return 0;
}

static int compares(void) {
    if (wcsncmp(L"abc", L"abd", 2) || wcscoll(L"a", L"b") >= 0 || _wcscoll_l(L"a", L"b", NULL) >= 0)
        return 11;
    if (_wcsicmp(L"MiX", L"mix") || wcsicmp(L"MiX", L"mIx") || _wcsicmp_l(L"A", L"a", NULL))
        return 12;
    if (_wcsnicmp(L"ABc", L"abd", 2) || wcsnicmp(L"ABc", L"abd", 2) ||
        _wcsnicmp_l(L"ABc", L"abd", 2, NULL))
        return 13;
    if (_wcsicoll(L"ABC", L"abc") || wcsicoll(L"ABC", L"abc") || _wcsicoll_l(L"A", L"a", NULL))
        return 14;
    if (_wcsncoll(L"abc", L"abd", 2) || _wcsncoll_l(L"abc", L"abd", 2, NULL) ||
        _wcsnicoll(L"ABc", L"abd", 2) || _wcsnicoll_l(L"ABc", L"abd", 2, NULL))
        return 15;
    return 0;
}

static int searches(void) {
    wchar_t buf[16], *ctx = NULL;
    wcscpy(buf, L"a,b;c");
    if (wcschr(buf, L',') != buf + 1 || wcsrchr(buf, L'c') != buf + 4)
        return 21;
    if (wcsstr(buf, L"b;") != buf + 2 || wcswcs(buf, L";c") != buf + 3)
        return 22;
    if (wcspbrk(buf, L";") != buf + 3 || wcsspn(buf, L"a,") != 2 || wcscspn(buf, L";") != 3)
        return 23;
    if (wcscmp(wcstok_s(buf, L",;", &ctx), L"a") || wcscmp(wcstok_s(NULL, L",;", &ctx), L"b"))
        return 24;
    wcscpy(buf, L"x y");
    if (wcscmp(_wcstok(buf, L" "), L"x") || wcscmp(_wcstok(NULL, L" "), L"y") || _wcstok(NULL, L" "))
        return 25;
    return 0;
}

static int mappings(void) {
    wchar_t buf[16];
    wcscpy(buf, L"MiX");
    if (wcscmp(_wcslwr(buf), L"mix") || wcscmp(_wcsupr(buf), L"MIX"))
        return 31;
    if (wcscmp(wcslwr(buf), L"mix") || wcscmp(wcsupr(buf), L"MIX"))
        return 32;
    if (wcscmp(_wcslwr_l(buf, NULL), L"mix") || wcscmp(_wcsupr_l(buf, NULL), L"MIX"))
        return 33;
    if (_wcslwr_s(buf, 16) || wcscmp(buf, L"mix") || _wcsupr_s(buf, 16) || wcscmp(buf, L"MIX"))
        return 34;
    if (_wcslwr_s_l(buf, 16, NULL) || wcscmp(buf, L"mix") || _wcsupr_s_l(buf, 16, NULL) ||
        wcscmp(buf, L"MIX"))
        return 35;
    if (wcscmp(_wcsrev(buf), L"XIM") || wcscmp(wcsrev(buf), L"MIX"))
        return 36;
    if (wcscmp(_wcsnset(buf, L'z', 2), L"zzX") || wcscmp(wcsnset(buf, L'y', 1), L"yzX"))
        return 37;
    if (wcscmp(_wcsset(buf, L'q'), L"qqq") || wcscmp(wcsset(buf, L'p'), L"ppp"))
        return 38;
    if (_wcsset_s(buf, 16, L'r') || wcscmp(buf, L"rrr") || _wcsnset_s(buf, 16, L's', 1) ||
        wcscmp(buf, L"srr"))
        return 39;
    return 0;
}

static int heap_and_errors(void) {
    wchar_t text[96], *a = _wcsdup(L"dup"), *b = wcsdup(L"dup2");
    if (!a || !b || wcscmp(a, L"dup") || wcscmp(b, L"dup2"))
        return 41;
    free(a);
    free(b);
    if (!_wcserror(EDOM) || _wcserror_s(text, 96, EDOM) || wcscmp(text, _wcserror(EDOM)))
        return 42;
    errno = EDOM;
    if (!__wcserror(L"x") || __wcserror_s(text, 96, L"x") || wcsncmp(text, L"x: ", 3))
        return 43;
    return 0;
}

int main(void) {
    int r;
    if ((r = copies()) || (r = compares()) || (r = searches()) || (r = mappings()) ||
        (r = heap_and_errors()))
        return r;
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif

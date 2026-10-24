// The C runtime's integer-to-string conversions, _malloca / _freea (stack
// below the threshold, heap above it), _aligned_malloc, __max / __min /
// _countof / _CVTBUFSIZE, memcpy_s, the _locale_t calls, _vscprintf /
// _vscwprintf and _isctype with its class masks, as mingw-w64 declares them
// over msvcrt.dll.

#ifdef _WIN32
#include <ctype.h>
#include <locale.h>
#include <malloc.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>

static int count(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int n = _vscprintf(fmt, ap);
    va_end(ap);
    return n;
}

static int wcount(const wchar_t *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int n = _vscwprintf(fmt, ap);
    va_end(ap);
    return n;
}

int main(void) {
    wchar_t w[40];
    char s[8] = "abc", n[40];
    int a[5];
    char *p = _malloca(16), *q = _malloca(4096);
    void *al = _aligned_malloc(64, 32);
    _locale_t loc = _create_locale(LC_ALL, "C");
    if (!p || !q || !al || !loc)
        return 1;
    memset(p, 1, 16);
    memset(q, 2, 4096);
    if (wcscmp(_ltow(-42L, w, 10), L"-42") || wcscmp(_ultow(42UL, w, 16), L"2a"))
        return 2;
    if (wcscmp(_i64tow(-5LL, w, 10), L"-5") ||
        wcscmp(_ui64tow(18446744073709551615ULL, w, 10), L"18446744073709551615") ||
        wcscmp(_itow(-9, w, 10), L"-9"))
        return 3;
    if (strcmp(_itoa(-7, n, 10), "-7") || strcmp(_i64toa(1LL << 40, n, 16), "10000000000") ||
        strcmp(_ultoa(255UL, n, 2), "11111111") || strcmp(_ltoa(-1L, n, 10), "-1"))
        return 4;
    if (__max(2, 3) != 3 || __min(2, 3) != 2 || _countof(a) != 5 || _CVTBUFSIZE != 349)
        return 5;
    if (memcpy_s(s, sizeof s, "xyz", 4) || strcmp(_strupr_l(s, loc), "XYZ") ||
        memmove_s(s + 1, sizeof s - 1, s, 3) || strcmp(s, "XXYZ"))
        return 6;
    if (count("%d-%s", 123, "ab") != 6 || wcount(L"%d", 4567) != 4)
        return 7;
    if (!_isctype('a', _ALPHA) || !_isctype('5', _DIGIT) || !_isctype('!', _PUNCT) ||
        _isctype('a', _DIGIT) || !_isctype(' ', _SPACE | _BLANK) || !_isctype_l('F', _HEX, loc))
        return 8;
    if ((size_t)al % 32 != 0)
        return 9;
    _freea(q);
    _freea(p);
    _aligned_free(al);
    _free_locale(loc);
    return 0;
}
#else
int main(void) { return 0; }
#endif

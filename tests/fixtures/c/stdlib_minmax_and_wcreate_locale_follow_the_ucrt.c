// <stdlib.h>'s max and min, defined for C as the UCRT defines them and kept
// under NOMINMAX, and <locale.h>'s _wcreate_locale over msvcrt.dll: a named
// locale reaches the runtime, so its wide case mapping differs from that of
// "C", and an unknown name, a null name or a bad category makes none. The
// image also formats and reads a double through ucrtbase.dll, whose locale
// comes from ucrtbase's _create_locale beside msvcrt's.

#ifdef _WIN32
#define NOMINMAX
#include <windows.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// The upper case of U+00E4 under the locale `name` names, or -1 for none.
static int upper_a_umlaut(const wchar_t *name) {
    wchar_t buf[2] = {0x00e4, 0};
    _locale_t loc = _wcreate_locale(LC_ALL, name);
    if (!loc)
        return -1;
    int c = _wcsupr_l(buf, loc)[0];
    _free_locale(loc);
    return c;
}

int main(void) {
    int a = 3, b = 8;
    if (max(a, b) != 8 || min(a, b) != 3 || max(b, a) != 8 || min(b, a) != 3)
        return 1;
    if (upper_a_umlaut(L"C") != 0x00e4 || upper_a_umlaut(L"German_Germany.1252") != 0x00c4)
        return 2;
    if (upper_a_umlaut(L"no such locale") != -1 || _wcreate_locale(LC_ALL, NULL) ||
        _wcreate_locale(99, L"C"))
        return 3;
    char text[16];
    if (snprintf(text, sizeof text, "%.2f", 2.5) != 4 || strcmp(text, "2.50") ||
        strtod("1.25", NULL) != 1.25)
        return 4;
    _locale_t c = _create_locale(LC_ALL, "C");
    if (!c)
        return 5;
    _free_locale(c);
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif

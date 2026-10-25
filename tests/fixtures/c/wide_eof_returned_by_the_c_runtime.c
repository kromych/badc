// WEOF is the wint_t value the C runtime returns at the end of a wide
// stream and for an untranslatable byte (C99 7.24.1): btowc(EOF),
// towlower(WEOF) and fgetwc at end of file each compare equal to it, and
// wint_t holds every wchar_t value besides.

#include <stdio.h>
#include <wchar.h>
#include <wctype.h>

int main(void) {
    if (sizeof(wint_t) < sizeof(wchar_t) || (wint_t)WEOF != WEOF)
        return 1;
    if (btowc(EOF) != WEOF)
        return 2;
    if (towlower(WEOF) != WEOF || towupper(WEOF) != WEOF)
        return 3;
    if (btowc('a') != L'a' || towupper(L'a') != L'A')
        return 4;
#ifdef _WIN32
    FILE *f = fopen("wide_eof.tmp", "w+b");
    if (!f)
        return 5;
    if (fputwc(L'x', f) != L'x')
        return 6;
    rewind(f);
    if (fgetwc(f) != L'x' || fgetwc(f) != WEOF || !feof(f))
        return 7;
    fclose(f);
    remove("wide_eof.tmp");
#endif
    return 0;
}

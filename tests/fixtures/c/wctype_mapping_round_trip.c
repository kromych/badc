// C99 7.25.2.2 and 7.25.3.2: a property wctype names classifies through
// iswctype as the matching isw* function does, a mapping wctrans names maps
// through towctrans as towupper and towlower do, and a name neither knows
// yields 0. C99 7.24.6: btowc / wctob and mbrtowc / wcrtomb convert the
// basic character set both ways in the "C" locale.

#include <string.h>
#include <wchar.h>
#include <wctype.h>

int main(void) {
    wctype_t alpha = wctype("alpha"), digit = wctype("digit"), blank = wctype("blank");
    wctrans_t up = wctrans("toupper"), low = wctrans("tolower");
    mbstate_t state;
    wchar_t wc = 0;
    char buf[8];
    if (!alpha || !digit || !blank || !up || !low)
        return 1;
    if (wctype("no such class") != 0 || wctrans("no such mapping") != 0)
        return 2;
    if (!iswctype(L'a', alpha) || iswctype(L'1', alpha))
        return 3;
    if (!iswctype(L'7', digit) || iswctype(L'x', digit))
        return 4;
    if (!iswctype(L' ', blank) || !iswctype(L'\t', blank) || iswctype(L'\n', blank))
        return 5;
    if (!iswblank(L' ') || iswblank(L'a'))
        return 6;
    if (towctrans(L'q', up) != L'Q' || towctrans(L'Q', low) != L'q' ||
        towctrans(L'5', up) != L'5')
        return 7;
    if (btowc('z') != L'z' || wctob(L'z') != 'z')
        return 8;
    memset(&state, 0, sizeof state);
    if (mbrtowc(&wc, "k", 1, &state) != 1 || wc != L'k')
        return 9;
    memset(&state, 0, sizeof state);
    if (wcrtomb(buf, L'k', &state) != 1 || buf[0] != 'k')
        return 10;
    return 0;
}

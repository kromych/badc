// Regression: a wide string literal must be wchar_t-aligned in storage.
//
// A wchar_t array requires wchar_t alignment (4 bytes on the Unix
// targets). glibc's vectorized wcschr / wcslen read elements with
// aligned loads and return wrong results on a misaligned literal -- a
// 2-aligned L"..." made wcschr report a present character as absent,
// which broke CPython's command-line option parser (SHORT_OPTS).
//
// A narrow literal interned just before the wide one leaves the data
// cursor at an odd offset, so without alignment the wide literal lands
// at a 2-mod-4 offset.

#include <wchar.h>

int main(void) {
    const char *narrow = "z";
    const wchar_t *wide = L"abcVdef";
    if (((unsigned long)wide) % sizeof(wchar_t) != 0) {
        return 1;
    }
    if (wcschr(wide, L'V') == 0) {
        return 2;
    }
    if (wcschr(wide, L'z') != 0) {
        return 3;
    }
    (void)narrow;
    return 0;
}

// A multibyte UTF-8 code point inside a wide character constant
// must decode to its scalar value (not the trailing encoding byte),
// and a UTF-8 sequence inside a narrow string literal must survive the
// preprocessor intact rather than being re-encoded byte by byte.
// Also covers wide string array initialization (4-byte wchar_t
// elements with size inference), universal character names (C99
// 6.4.3 `\u`), and a function-like macro whose parameter is named `L`
// (the prefix of an adjacent wide literal must not be captured).

#include <stddef.h>

#define W(L) L"Hello " L

static char utf8_str[] = "á";  // "á" -- two UTF-8 bytes + NUL
static wchar_t ws[] = L"aáb";  // 'a', U+00E1, 'b', NUL -> 4 elements

int main(void) {
    wchar_t c = L'á';        // U+00E1
    wchar_t e = L'€';      // U+20AC (euro)
    if (c != 0x00E1) return 1;
    if (e != 0x20AC) return 2;
    if ((unsigned char)utf8_str[0] != 0xC3) return 3;
    if ((unsigned char)utf8_str[1] != 0xA1) return 4;
    if (utf8_str[2] != 0) return 5;

    // Wide string array: size inferred to 4 (3 chars + NUL).
    if (sizeof(ws) != 4 * sizeof(wchar_t)) return 6;
    if (ws[0] != 'a' || ws[1] != 0x00E1 || ws[2] != 'b' || ws[3] != 0) return 7;

    // Universal character name in a wide char constant.
    if (L'\u00e1' != 0x00E1) return 8;

    // The macro parameter `L` must not swallow the wide-string prefix:
    // W(L"World!") expands to L"Hello " L"World!".
    wchar_t *m = W(L"World!");
    if (m[0] != 'H' || m[6] != 'W' || m[11] != '!' || m[12] != 0) return 9;

    return 0;
}

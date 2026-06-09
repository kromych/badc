// A multibyte UTF-8 code point inside a wide character constant
// must decode to its scalar value (not the trailing encoding byte),
// and a UTF-8 sequence inside a narrow string literal must survive the
// preprocessor intact rather than being re-encoded byte by byte.

#include <stddef.h>

static char utf8_str[] = "á";  // "á" -- two UTF-8 bytes + NUL

int main(void) {
    wchar_t c = L'á';        // U+00E1
    wchar_t e = L'€';      // U+20AC (euro)
    if (c != 0x00E1) return 1;
    if (e != 0x20AC) return 2;
    if ((unsigned char)utf8_str[0] != 0xC3) return 3;
    if ((unsigned char)utf8_str[1] != 0xA1) return 4;
    if (utf8_str[2] != 0) return 5;
    return 0;
}

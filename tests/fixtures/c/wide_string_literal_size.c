// C99 6.4.5: a wide string literal has type `wchar_t[N+1]`, the +1 being
// the single wide null terminator. Its size is therefore
// (N+1) * sizeof(wchar_t), and adjacent wide literals concatenate
// (6.4.5p5) into one such array. The lexer appends the wchar_t-width
// terminator, so the parser must not also append the narrow one-byte
// NUL it adds for narrow literals -- doing so made every wide literal a
// byte too large.
//
// wchar_t is 4 bytes on Linux/macOS and 2 on Windows; the checks are
// written in terms of sizeof(wchar_t) so they hold on every target.
#include <stddef.h>

int main(void) {
    unsigned w = sizeof(wchar_t);
    if (sizeof(L"") != 1 * w) return 1;       // terminator only
    if (sizeof(L"a") != 2 * w) return 2;       // 'a' + NUL
    if (sizeof(L"ab") != 3 * w) return 3;
    if (sizeof(L"a" L"b") != 3 * w) return 4;  // concatenation
    if (sizeof(L"ab" L"cd" L"e") != 6 * w) return 5;

    // Narrow literals stay one byte per element with a one-byte NUL.
    if (sizeof("") != 1) return 6;
    if (sizeof("ab") != 3) return 7;
    if (sizeof("a" "b") != 3) return 8;

    // Wide content survives concatenation.
    const wchar_t *s = L"a" L"b";
    if (s[0] != L'a' || s[1] != L'b' || s[2] != 0) return 9;
    return 0;
}

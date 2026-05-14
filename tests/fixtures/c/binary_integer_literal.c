// Binary integer literals -- C23 / GCC extension.
//
// chibicc's unicode.c relies on the `0b...` shape for the UTF-8
// continuation-byte patterns. Same lexer slot as `0x...` hex;
// suffix-letter handling is shared.
#include <stdio.h>

int main() {
    int a = 0b1010;
    if (a != 10) return 1;

    int b = 0B11;
    if (b != 3) return 2;

    unsigned char c = 0b11000000;
    if (c != 0xC0) return 3;

    unsigned char d = 0b00111111;
    if (d != 0x3F) return 4;

    long long e = 0b1111111111111111111111111111111111111111111111111111111111111111LL;
    if (e != -1) return 5;

    unsigned u = 0b1U;
    if (u != 1) return 6;

    return 0;
}

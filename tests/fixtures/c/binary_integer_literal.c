// Binary integer literals -- C23 6.4.4.1 (the `0b` / `0B`
// prefix was added in C23; widely available as a GCC / Clang
// extension before that). Same lexer slot as `0x...` hex;
// suffix-letter handling (`u`/`U`/`l`/`L`) is shared.
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

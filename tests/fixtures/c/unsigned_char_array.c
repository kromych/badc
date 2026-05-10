// `static const unsigned char arr[]` indexing must use 1-byte
// stride, not 8-byte. Surfaced inside sqlite3's lexer where
// `aiClass[(unsigned char)c]` (a 256-entry character-class table)
// returned wrong values: the per-element size lookup didn't strip
// the unsigned-bit flag from the type tag, so the backend read
// 8 bytes per slot and skipped 7 of every 8 entries.
//
// Also exercises an u64 array to confirm 8-byte stride still works
// when the unsigned bit is set on a wider type.
#include <stdio.h>

static const unsigned char small[] = {
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10
};

static const unsigned long wide[] = {
    100, 200, 300, 400, 500
};

int main() {
    if (small[0] != 1)  { printf("FAIL: small[0]=%d\n", small[0]); return 1; }
    if (small[5] != 6)  { printf("FAIL: small[5]=%d\n", small[5]); return 1; }
    if (small[9] != 10) { printf("FAIL: small[9]=%d\n", small[9]); return 1; }

    if (wide[0] != 100) { printf("FAIL: wide[0]=%lu\n", wide[0]); return 1; }
    if (wide[4] != 500) { printf("FAIL: wide[4]=%lu\n", wide[4]); return 1; }

    // Index by an unsigned char value (the actual sqlite3 lexer
    // pattern: classify by char value, with the index itself
    // arriving from an `unsigned char *`).
    unsigned char i = 5;
    if (small[i] != 6)  { printf("FAIL: small[i=5]=%d\n", small[i]); return 1; }

    return 0;
}

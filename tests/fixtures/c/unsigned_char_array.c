// C99 6.5.6 + 6.7.5.2: `arr[i]` strides by `sizeof(*arr)`.
// For `static const unsigned char arr[]` that is 1 byte. The
// per-element size lookup needs to strip the unsigned-bit flag
// from the type tag so an `unsigned char` array doesn't get
// the 8-byte stride that bare `Ty::Ptr` would imply. Also
// covers a `u64` array to confirm 8-byte stride still works
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

    // Index by an unsigned char value: classify-by-char tables
    // load their index from an `unsigned char *`.
    unsigned char i = 5;
    if (small[i] != 6)  { printf("FAIL: small[i=5]=%d\n", small[i]); return 1; }

    return 0;
}

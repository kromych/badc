// C99 6.5.2.2p4: a call argument is converted to the declared
// parameter type. The bundled <string.h> declares the count
// parameter of `memcmp` / `memset` as `int`, so an argument whose
// value exceeds 32 bits must narrow to `int` before the call.
// A libc binding (Token::Sys) reads the argument at the platform
// register width and never re-narrows, so the conversion happens
// at the call site -- identically to a user-defined callee, whose
// prologue truncates the same value in its typed parameter load.
//
// 0x100000003 narrows to (int)3. memcmp of two equal buffers with
// count 3 returns 0; without the narrowing the full 64-bit count
// walks past the buffers and returns garbage.

#include <string.h>

static int user_count(int n) { return n; }

int main(void) {
    char a[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    char b[8] = {1, 2, 3, 4, 5, 6, 7, 8};

    // Bound import: count narrows to 3, the equal prefixes compare equal.
    if (memcmp(a, b, (unsigned long long)0x100000003ULL) != 0) return 1;

    // The user callee narrows the same value via its parameter load,
    // so the two paths agree on the narrowed value.
    if (user_count((unsigned long long)0x100000003ULL) != 3) return 2;

    // memset's `int n` count narrows the same way: writing 3 bytes,
    // not 0x100000003.
    char c[8] = {9, 9, 9, 9, 9, 9, 9, 9};
    memset(c, 0, (unsigned long long)0x100000003ULL);
    if (c[0] != 0 || c[1] != 0 || c[2] != 0) return 3;
    if (c[3] != 9) return 4;

    return 0;
}

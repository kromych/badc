// C99 6.5.2.2p7: an argument converts to the declared parameter type. A
// libc binding reads each argument at register width, so the conversion
// happens at the call site. `strncmp`'s `size_t` count keeps all 64 bits
// and reaches the differing fourth character, where a count narrowed to
// `int` (3) would compare equal; a user callee's `int` parameter narrows.

#include <string.h>

static int user_count(int n) { return n; }

int main(void) {
    if (strncmp("abcx", "abcy", (unsigned long long)0x100000003ULL) == 0) return 1;

    if (user_count((unsigned long long)0x100000003ULL) != 3) return 2;

    // memset's `int` value converts to `unsigned char`: 0x141 writes 0x41.
    char c[8] = {9, 9, 9, 9, 9, 9, 9, 9};
    memset(c, 0x141, (unsigned long long)3);
    if (c[0] != 0x41 || c[1] != 0x41 || c[2] != 0x41) return 3;
    if (c[3] != 9) return 4;

    return 0;
}

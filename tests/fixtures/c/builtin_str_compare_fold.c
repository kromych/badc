// `strcmp` / `strncmp` / `memcmp` of two string literals fold to a
// constant, matching gcc: the sign of the first differing byte pair
// compared as `unsigned char`, normalized to -1 / 0 / 1. The
// `__builtin_` spellings reach the fold under the library name.
//
// The fold makes a comparison against a literal usable as a
// translation-time selector: a chain of `if (!__builtin_strcmp(SEL, ...))`
// has one live arm, and the dead arms' calls -- here to a function that
// is declared but never defined -- are never emitted.

#include <string.h>

extern void undefined_selector_arm(void);

#define pick(SEL, a, b, c)                          \
    ({                                              \
        int r = -1;                                 \
        if (!__builtin_strcmp(SEL, "a")) r = (a);   \
        else if (!__builtin_strcmp(SEL, "b")) r = (b); \
        else if (!__builtin_strcmp(SEL, "c")) r = (c); \
        else undefined_selector_arm();              \
        r;                                          \
    })

// Constant-expression contexts.
static const int eq = __builtin_strcmp("<", "<");
enum { LT = -__builtin_strcmp("<", "<=") };
static int dim[__builtin_memcmp("ab", "ab", 2) + 3];

int main(void) {
    if (__builtin_strcmp("a", "b") != -1) return 1;
    if (__builtin_strcmp("b", "a") != 1) return 2;
    if (__builtin_strcmp("abc", "abc") != 0) return 3;
    if (__builtin_strcmp("ab", "abc") != -1) return 4;
    if (__builtin_strcmp("abc", "ab") != 1) return 5;
    // Bytes compare as `unsigned char`: 0x80 is above 0x01.
    if (__builtin_strcmp("\x80", "\x01") != 1) return 6;
    // Adjacent literals are one string.
    if (__builtin_strcmp("ab" "c", "abc") != 0) return 7;

    if (__builtin_strncmp("abcd", "abce", 3) != 0) return 8;
    if (__builtin_strncmp("abcd", "abce", 4) != -1) return 9;
    if (__builtin_strncmp("a", "b", 0) != 0) return 10;
    // A count past the NUL is not past the object: the comparison ends
    // there. A `memcmp` count past the object declines and stays a call.
    if (__builtin_strncmp("ab", "ab", 100) != 0) return 23;

    // memcmp reads past an embedded NUL; strcmp stops at it.
    if (__builtin_memcmp("a\0z", "a\0y", 3) != 1) return 11;
    if (__builtin_strcmp("a\0z", "a\0y") != 0) return 12;
    if (__builtin_memcmp("\x80", "\x01", 1) != 1) return 13;

    if (eq != 0) return 14;
    if (LT != 1) return 15;
    if (sizeof(dim) / sizeof(dim[0]) != 3) return 16;

    if (pick("a", 21, 22, 23) != 21) return 17;
    if (pick("b", 21, 22, 23) != 22) return 18;
    if (pick("c", 21, 22, 23) != 23) return 19;

    // Runtime operands keep the call: the library function answers.
    {
        char buf[4];
        buf[0] = 'a';
        buf[1] = 'b';
        buf[2] = 'c';
        buf[3] = 0;
        if (strcmp(buf, "abc") != 0) return 20;
        if (strncmp("abc", buf, 3) != 0) return 21;
        if (memcmp("abc", buf, (unsigned) buf[0] - 'a' + 3) != 0) return 22;
    }
    return 0;
}

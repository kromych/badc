// C99 6.3.1.3: a cast to an integer type in a constant expression
// narrows the operand to the target width and re-interprets it by the
// target's signedness. `(int)UINT_MAX` is -1, not 0xFFFFFFFF, so a
// constant expression like `(int)UINT_MAX == -1` is true at parse time.
// These appear as array dimensions (the compile-time-assert idiom: a
// dimension of 1 when the predicate holds, -1 -- an error -- when it
// does not) and as enum initializers, both evaluated by the constant
// expression folder.
#include <limits.h>

// Sign-extension on narrowing to a signed type.
extern char a0[((int)UINT_MAX == -1) ? 1 : -1];
extern char a1[((short)0x1FFFF == -1) ? 1 : -1];
extern char a2[((signed char)0x1FF == -1) ? 1 : -1];

// Zero-extension / truncation on narrowing to an unsigned type.
extern char a3[((unsigned char)-1 == 255) ? 1 : -1];
extern char a4[((unsigned short)-1 == 65535) ? 1 : -1];
extern char a5[((unsigned int)-1 == 0xFFFFFFFFu) ? 1 : -1];

// _Bool: any nonzero value folds to 1 (6.3.1.2).
extern char a6[((_Bool)256 == 1) ? 1 : -1];
extern char a7[((_Bool)0 == 0) ? 1 : -1];

// 8-byte targets keep the full value.
extern char a8[((long long)UINT_MAX == 4294967295LL) ? 1 : -1];

enum { NEG = (int)UINT_MAX, U8 = (unsigned char)-1 };

int main(void) {
    if (NEG != -1) return 1;
    if (U8 != 255) return 2;
    // Runtime cast must agree with the constant fold.
    unsigned u = UINT_MAX;
    if ((int)u != -1) return 3;
    return 0;
}

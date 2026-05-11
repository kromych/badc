// C99 6.6: constant expressions in integer contexts (array sizes,
// enum values, `_Static_assert`, static / global integer inits)
// accept the full constant-expression grammar -- integer + float
// literals, casts, arithmetic, comparisons, conditionals, sizeof,
// nested combinations -- not just integer literals.

#include <stdio.h>

#define BASE 10

enum {
    ENUM_BASE = 1 + 2 * 3,           // 7
    ENUM_SHIFT = 1 << 4,             // 16
    ENUM_PAREN = (1 + 2) * (3 + 4),  // 21
    ENUM_TRUNC = (int)(1.5 * 2.0),   // 3
    ENUM_DIV = 100 / 7,              // 14
    ENUM_MOD = 100 % 7,              // 2
    ENUM_COND = (BASE > 5) ? 100 : 200,         // 100
    ENUM_CAST_FLOAT_NESTED = (int)((double)5 / 2.0),  // 2
    ENUM_BITWISE = (0xff & 0x0f) | (0x10 ^ 0x01),     // 15 | 17 = 31
    ENUM_NEG_FLOAT = (int)(-3.5 + 1.0),               // -2
    ENUM_LAND = (1 && 2 && 3) + (0 && 4),             // 1 + 0 = 1
    ENUM_NOT = !!42,                                  // 1
};

_Static_assert(ENUM_BASE == 7, "ENUM_BASE arithmetic");
_Static_assert(ENUM_SHIFT == 16, "ENUM_SHIFT shift");
_Static_assert(ENUM_PAREN == 21, "ENUM_PAREN parens");
_Static_assert(ENUM_TRUNC == 3, "ENUM_TRUNC float cast");
_Static_assert(ENUM_DIV == 14, "ENUM_DIV integer division");
_Static_assert(ENUM_MOD == 2, "ENUM_MOD integer modulo");
_Static_assert(ENUM_COND == 100, "ENUM_COND conditional");
_Static_assert(ENUM_CAST_FLOAT_NESTED == 2, "ENUM_CAST_FLOAT_NESTED");
_Static_assert(ENUM_BITWISE == 31, "ENUM_BITWISE bitwise mix");
_Static_assert(ENUM_NEG_FLOAT == -2, "ENUM_NEG_FLOAT unary minus on float");
_Static_assert(ENUM_LAND == 1, "ENUM_LAND logical chain");
_Static_assert(ENUM_NOT == 1, "ENUM_NOT double-bang");

// Array sizes from arithmetic constant expressions.
int xs[ENUM_BASE + 1];                  // 8 elements
int ys[(int)(1.5 * 4)];                 // 6 elements
int zs[1 << 4];                         // 16 elements
int ws[sizeof(int) * 4];                // 16 elements (sizeof(int)==4)
int us[(int)(3.5) + (int)(1.5 * 2.0)];  // 3 + 3 = 6

// Conditional sets the size.
int branch[(BASE > 5) ? 8 : 4];

// sizeof of an arithmetic expression (the operand's value is
// discarded, only its type matters).
int sized[sizeof(1 + 2L * 3)];          // sizeof(long) >= 4

int main(void) {
    // Confirm runtime sizes are what the constant evaluator picked.
    int rc = 0;
    if (sizeof(xs) / sizeof(xs[0]) != 8) {
        printf("FAIL: xs size %zu\n", sizeof(xs) / sizeof(xs[0]));
        rc = 1;
    }
    if (sizeof(ys) / sizeof(ys[0]) != 6) {
        printf("FAIL: ys size %zu\n", sizeof(ys) / sizeof(ys[0]));
        rc = 2;
    }
    if (sizeof(zs) / sizeof(zs[0]) != 16) {
        printf("FAIL: zs size %zu\n", sizeof(zs) / sizeof(zs[0]));
        rc = 3;
    }
    if (sizeof(ws) / sizeof(ws[0]) != 16) {
        printf("FAIL: ws size %zu\n", sizeof(ws) / sizeof(ws[0]));
        rc = 4;
    }
    if (sizeof(us) / sizeof(us[0]) != 6) {
        printf("FAIL: us size %zu\n", sizeof(us) / sizeof(us[0]));
        rc = 5;
    }
    if (sizeof(branch) / sizeof(branch[0]) != 8) {
        printf("FAIL: branch size %zu\n", sizeof(branch) / sizeof(branch[0]));
        rc = 6;
    }
    // Local-array sizes from arithmetic constant expressions.
    int locals[(int)(2.5 * 4) - 4];  // 10 - 4 = 6
    if (sizeof(locals) / sizeof(locals[0]) != 6) {
        printf("FAIL: locals size %zu\n", sizeof(locals) / sizeof(locals[0]));
        rc = 7;
    }
    return rc;
}

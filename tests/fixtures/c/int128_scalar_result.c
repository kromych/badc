/* C99 6.5.8p6 / 6.5.9p3: a relational or equality operator on 128-bit
   operands yields plain `int`. The result must therefore reach every
   scalar context as a 0/1 value, not as the 16-byte object the operands
   live in -- passing it to a variadic callee, to a fixed parameter, into
   an aggregate member, an array subscript, and the controlling
   expression of `switch` / `?:` / `while`. Exit 0 on success; a distinct
   non-zero code per failing check. */

#include <stdarg.h>

typedef unsigned long long u64;
typedef unsigned __int128 u128;
typedef __int128 s128;

volatile u64 five = 5;
volatile u64 three = 3;
volatile u64 seven = 7;
volatile u64 nine = 9;

struct holder {
    int lt;
    u128 wide;
    int eq;
};

static int take_int(int v) { return v * 3; }

/* Read the variadic tail back through `va_arg`. A comparison pushed as
   a 16-byte object rather than an `int` would both corrupt the frame and
   shift `tail` out of position, so checking the trailing argument
   catches a miscount that the flag alone would hide. */
static int tail_check;

static int via_variadic(int count, ...) {
    va_list ap;
    int flag;
    va_start(ap, count);
    flag = va_arg(ap, int);
    tail_check = va_arg(ap, int);
    va_end(ap);
    return flag;
}

int main(void) {
    u128 a = ((u128)five << 64) | seven;
    u128 b = ((u128)three << 64) | nine;
    u128 c = a;
    s128 sn = -(((s128)1 << 100) + 12345);
    s128 sp = ((s128)1 << 100) + 12345;

    /* Variadic position: the defect this locks in. */
    if (via_variadic(2, a > b, 77) != 1 || tail_check != 77)
        return 1;
    if (via_variadic(2, a < b, 77) != 0 || tail_check != 77)
        return 2;
    if (via_variadic(2, a == c, 77) != 1 || tail_check != 77)
        return 3;
    if (via_variadic(2, a != c, 77) != 0 || tail_check != 77)
        return 4;
    if (via_variadic(2, sn < sp, 77) != 1 || tail_check != 77)
        return 5;
    if (via_variadic(2, (int)(a >= b), 77) != 1 || tail_check != 77)
        return 6;

    /* Fixed (non-variadic) parameter. */
    if (take_int(a > b) != 3 || take_int(a == b) != 0)
        return 7;

    /* Logical negation and the short-circuit operands. */
    if (!a || !(a - c) != 1)
        return 8;
    if (!((a > b) && (b < a)) || ((a < b) || (a > b)) != 1)
        return 9;

    /* Aggregate member initialized from a comparison, beside a 128-bit
       member so the member's own placement is exercised too. */
    struct holder h = {a > b, a, a == c};
    if (h.lt != 1 || h.eq != 1 || h.wide != a)
        return 10;

    /* Array subscript. */
    {
        int arr[4] = {10, 20, 30, 40};
        if (arr[a > b] != 20 || arr[(a > b) + (a != b)] != 30)
            return 11;
    }

    /* switch / ternary / loop controlling expressions. */
    switch ((int)(a > b)) {
    case 1: break;
    default: return 12;
    }
    if (((a > b) ? 111 : 222) != 111)
        return 13;
    {
        int spins = 0;
        u128 d = 0;
        while (d < 5) {
            d = d + 1;
            spins++;
        }
        if (spins != 5 || d != 5)
            return 14;
    }

    /* A comparison result stored to an `int` object keeps 0/1. */
    {
        int flag = a > b;
        int zero = a < b;
        if (flag != 1 || zero != 0 || (flag + zero) != 1)
            return 15;
    }
    return 0;
}

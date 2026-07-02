/* C99 6.6 + 6.3.1.8: constant expressions fold with the operands'
   signedness -- unsigned division, remainder, right shift, and
   relational compares on 64-bit unsigned values, and unsigned-int
   compares for mixed narrow operands. INT64_MIN / -1 wraps instead
   of aborting the compiler; a zero divisor in a not-taken `?:` arm
   or short-circuited operand is unevaluated (6.6p4 scopes to the
   evaluated expression). */
static unsigned long long g_div = 0xFFFFFFFFFFFFFFFFULL / 3;
static unsigned long long g_shr = 0xFFFFFFFFFFFFFFFFULL >> 4;
static unsigned long long g_rem = 0xFFFFFFFFFFFFFFFFULL % 7;
static int g_gt = 0xFFFFFFFFFFFFFFFFULL > 2;
static int g_mixed = -1 < 1u;
static long long g_wrap = (-9223372036854775807LL - 1) / -1;
static int arr[0xFFFFFFFFu / 1000000000u];
static int live[1 ? 3 : 1 / 0];
static int shortcut = 0 && 1 / 0;

int main(void) {
    if (g_div != 6148914691236517205ULL) {
        return 1;
    }
    if (g_shr != 1152921504606846975ULL) {
        return 2;
    }
    if (g_rem != 1) {
        return 3;
    }
    if (g_gt != 1) {
        return 4;
    }
    if (g_mixed != 0) {
        return 5;
    }
    if (g_wrap != -9223372036854775807LL - 1) {
        return 6;
    }
    if (sizeof(arr) / sizeof(arr[0]) != 4) {
        return 7;
    }
    if (sizeof(live) / sizeof(live[0]) != 3 || shortcut != 0) {
        return 8;
    }
    return 0;
}

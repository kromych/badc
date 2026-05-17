// Locks C99 6.4.4.1p5: the type of an unsuffixed integer
// constant is the first of `int`, `long`, `long long` in which
// the value can be represented. A value above INT_MAX must NOT
// stay at `int`; otherwise the post-Add/Sub mask in the
// usual-arithmetic-conversion path truncates `INT64_MAX - 1`
// down to `-2` (low 32 bits of INT64_MAX = -1, then -1 - 1 = -2)
// and `-LLONG_MAX - 1` to 0.
//
// Lua's `LUA_MININTEGER` is `(-9223372036854775807 - 1)`, the
// canonical INT64_MIN expansion. Without the auto-promote
// `math.mininteger` was 0 and every test using it failed.

int main(void) {
    long long maxv = 9223372036854775807;        // INT64_MAX
    long long minv = -9223372036854775807 - 1;   // INT64_MIN
    if (maxv != 9223372036854775807LL) return 1;
    if (minv != -9223372036854775807LL - 1LL) return 2;

    long long a = 9223372036854775807 - 1;       // expect MAX - 1
    if (a != 9223372036854775806LL) return 3;

    long long b = -9223372036854775807 - 1;      // expect MIN
    if (b != -9223372036854775807LL - 1LL) return 4;

    // Cross the long boundary with the magnitude-only promote
    // for an unsuffixed positive value past 2^32. The literal
    // must end up at long (LP64) / long long (LLP64).
    long long c = 5000000000 + 1;
    if (c != 5000000001LL) return 5;

    return 0;
}

// Regression: local arrays initialized with non-constant values.
// C99 6.7.8p13 allows initializers for non-static auto storage
// to contain non-constant expressions; the array is initialized
// element-by-element in declaration order, as if by assignment.
// Before this fix c5 routed every element through
// `parse_constant_init_value`, which only accepts constants and
// rejected references to function parameters (and other
// non-constant identifiers) with "identifier ... is not a
// constant-expression value".
//
// The runtime path emits per-element stores: Lea + Add offset
// + Psh + <expr> + Sh/Sw/Si/Sc. The constant fast path (Mcpy
// from data segment) still runs when every element is a
// compile-time value.

#include <stdio.h>

static unsigned short g_table_a[256];
static unsigned short g_table_b[256];

static int probe_short(int idx) {
    /* Non-constant local array initializer: each value comes from
     * runtime indexed reads. Exercises the per-element store
     * sequence for unsigned short (2 bytes -- Op::Sh). */
    const unsigned short pair[2] = { g_table_a[idx], g_table_b[idx] };
    return (int)pair[0] * 1000 + (int)pair[1];
}

static int probe_int(int x, int y) {
    /* 4-byte element store path (Op::Sw). */
    int v[3] = { x + y, x - y, x * y };
    return v[0] + v[1] + v[2];
}

static int probe_long(long a, long b) {
    /* 8-byte element store path (Op::Si). */
    long w[2] = { a + b, a - b };
    return (int)(w[0] + w[1]);
}

static int probe_char(int n) {
    /* 1-byte element store path (Op::Sc). Mixed constant and
     * non-constant inits. */
    char c[4] = { (char)('a' + n), 'b', (char)(n + 1), 'd' };
    int s = 0;
    int i;
    for (i = 0; i < 4; i++) s += (int)c[i];
    return s;
}

int main(void) {
    g_table_a[5] = 0x1234;
    g_table_b[5] = 0x5678;

    if (probe_short(5) != (0x1234 * 1000 + 0x5678)) return 1;

    /* probe_int(3, 4) = 7 + (-1) + 12 = 18 */
    if (probe_int(3, 4) != 18) return 2;

    /* probe_long(10, 4) = 14 + 6 = 20 */
    if (probe_long(10L, 4L) != 20) return 3;

    /* probe_char(2): { 'c', 'b', char(3), 'd' } -- 99 + 98 + 3 + 100 = 300 */
    if (probe_char(2) != 300) return 4;

    /* Constant-only init still works (Mcpy fast path). */
    int cs[3] = { 1, 2, 3 };
    if (cs[0] + cs[1] + cs[2] != 6) return 5;

    /* Constant char-array string init still works. */
    char buf[8] = "hello";
    if (buf[0] != 'h' || buf[4] != 'o' || buf[5] != 0) return 6;
    return 0;
}

// C99 6.5.15: the middle slot of a `?:` conditional is an
// `expression`, not an `assignment-expression`. A bare comma
// chain is therefore legal there:
//   cond ? side_effect_a , side_effect_b , value : alt
// and each comma's lhs must run for its side effects before the
// rhs's value flows into the ternary.
//
// sqlite's `putVarint32(A, B)` macro relies on this:
//   ((u32)(B) < 0x80) ? (*A = (u8)B), 1 : sqlite3PutVarint(A, B)
// The fast path stores the byte AND yields 1 in a single comma
// expression sitting in the ternary middle. Walker used to drop
// the comma's lhs (the `*A = ...` store), so sqlite's cell
// header byte was never written and CREATE TABLE corrupted the
// btree image on the very first row.
//
// The pin covers three flavours of comma in the ternary middle:
// flat-comma, parens-around-assign, parens-around-whole.

#include <stdio.h>

int main(void) {
    unsigned char a[4] = {0};
    int B = 42;

    // Flavour A: full parens around the comma expression.
    int n_a = ((unsigned int)B < 0x80u) ? (a[0] = (unsigned char)B, 1) : 99;
    if (n_a != 1 || a[0] != 42) {
        printf("FAIL A: n=%d a[0]=%d\n", n_a, a[0]);
        return 1;
    }

    // Flavour B: no parens at all.
    unsigned char b[4] = {0};
    int n_b = ((unsigned int)B < 0x80u) ? b[0] = (unsigned char)B, 1 : 99;
    if (n_b != 1 || b[0] != 42) {
        printf("FAIL B: n=%d b[0]=%d\n", n_b, b[0]);
        return 2;
    }

    // Flavour C: parens around just the assign, comma at top of middle.
    unsigned char c[4] = {0};
    int n_c = ((unsigned int)B < 0x80u) ? (c[0] = (unsigned char)B), 1 : 99;
    if (n_c != 1 || c[0] != 42) {
        printf("FAIL C: n=%d c[0]=%d\n", n_c, c[0]);
        return 3;
    }

    // Flavour D: longer comma chain (three side effects + value).
    int x = 0, y = 0, z = 0;
    int n_d = (B > 0) ? (x = 1), (y = 2), (z = 3), x + y + z : -1;
    if (n_d != 6 || x != 1 || y != 2 || z != 3) {
        printf("FAIL D: n=%d x=%d y=%d z=%d\n", n_d, x, y, z);
        return 4;
    }

    // Flavour E: rhs branch with no side effects (control).
    unsigned char e[4] = {0};
    B = 200;  /* >= 0x80: takes alt branch */
    int n_e = ((unsigned int)B < 0x80u) ? (e[0] = (unsigned char)B), 1 : 99;
    if (n_e != 99 || e[0] != 0) {
        printf("FAIL E: n=%d e[0]=%d\n", n_e, e[0]);
        return 5;
    }

    return 0;
}

// C23 6.7.2.5 / GCC `__typeof__`: a type specifier naming the type of a
// parenthesized type-name or unevaluated expression operand. Exercised
// in a declaration base type, a pointer declarator, a struct member, a
// cast, and a sizeof operand. The expression operand is unevaluated, so
// a side effect in it must not run.

struct point { int x; long y; };

int side_effect_ran = 0;
int with_side_effect(void) { side_effect_ran = 1; return 7; }

// typeof of a struct member's type, used as a struct field type.
struct holder { __typeof__(((struct point *) 0)->y) value; };

int main(void) {
    // Scalar expression operand.
    int a = 5;
    __typeof__(a) b = a + 3;
    if (b != 8) return 1;

    // typeof of a type-name.
    typeof(long) c = 100;
    if (c != 100) return 2;

    // Pointer operand: __typeof__(p) is `int *`.
    int *p = &a;
    __typeof__(p) q = &b;
    if (*q != 8) return 3;

    // typeof + pointer declarator: `int *`.
    __typeof__(a) *r = &a;
    if (*r != 5) return 4;

    // Member-typed field carries the member's width (long, 8 bytes).
    struct holder h;
    h.value = 0x1ffffffffL;
    if (h.value != 0x1ffffffffL) return 5;
    if (sizeof h.value != sizeof(long)) return 6;

    // Cast through typeof.
    long n = 0x100000001L;
    int t = (__typeof__(a)) n;
    if (t != 1) return 7;

    // sizeof of a typeof type.
    if (sizeof(__typeof__(c)) != sizeof(long)) return 8;

    // The expression operand is unevaluated.
    __typeof__(with_side_effect()) e = 0;
    (void) e;
    if (side_effect_ran != 0) return 9;

    return 0;
}

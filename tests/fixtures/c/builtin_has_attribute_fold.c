// GCC `__builtin_has_attribute(operand, attribute)` folds to an
// integer constant: the compiler does not model the queried
// attributes on objects, so no operand carries one and the answer is
// 0. Usable where an integer constant expression is required (a
// bitfield width built from it) and in ordinary expressions; both
// operands are unevaluated.

static char buf[8];
static int w = (int)(sizeof(struct { int bits : (1 + !__builtin_has_attribute(buf, nonstring)); }));
static int folded = __builtin_has_attribute(buf, aligned);

int side_effect_guard(void);

int main(void) {
    if (folded != 0) return 1;
    if (w != (int)sizeof(int)) return 2;
    if (__builtin_has_attribute(side_effect_guard(), pure) != 0) return 3;
    return 0;
}

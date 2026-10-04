// C99 6.7.2.2p4 leaves the enum compatible type to the implementation;
// existing practice (GCC) picks `unsigned int` when no enumerator is
// negative and `int` otherwise, while an enumerator constant keeps its
// own type -- `int` when the value fits (p3), `unsigned int` for the
// wider extension values. The signedness probe a type-generic bound
// check builds from `(typeof(x))(-1) < (typeof(x))1` therefore decides
// at translation time for enum-typed operands.

enum id { ID0, ID1, ID2 };
enum sig { NEG = -1, POS };
enum wide { TOP = 0x80000000u };
struct rec {
    enum id slot;
    unsigned int count;
};

int main(void) {
    if (_Generic((enum id)0, unsigned int: 1, int: 2, default: 0) != 1)
        return 1;
    if (_Generic((enum sig)0, unsigned int: 1, int: 2, default: 0) != 2)
        return 2;
    if (_Generic((enum wide)0, unsigned int: 1, int: 2, default: 0) != 1)
        return 3;
    if (_Generic(ID1, int: 1, default: 0) != 1)
        return 4;
    if (_Generic(TOP, unsigned int: 1, default: 0) != 1)
        return 5;
    if ((int)(ID0 - 1) != -1)
        return 6;

    struct rec r;
    r.slot = ID2;
    r.count = 7;
    // Unsigned wrap, not a negative value.
    if (((r.slot - 3) < 0) != 0)
        return 7;
    // Both probe arms report unsigned; a bound check built over them
    // decides without looking at the values.
    int xs = ((__typeof__(r.count))(-1)) < ((__typeof__(r.count))1);
    int ys = ((__typeof__(r.slot))(-1)) < ((__typeof__(r.slot))1);
    if (xs != 0 || ys != 0)
        return 8;
    // Promotion keeps the member's unsigned type through arithmetic.
    __auto_type y = r.slot + 1;
    if ((((__typeof__(y))(-1)) < ((__typeof__(y))1)) != 0)
        return 9;
    return 0;
}

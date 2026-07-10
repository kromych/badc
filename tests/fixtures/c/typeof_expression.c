// `typeof(expr)` accepts a full expression operand, not just a bare name:
// binary, conditional, shift, assignment, and comma operators. A common
// MIN / MAX macro shape expands to `typeof(1 ? (a) : (b))`. The type is
// used to declare a temporary; success returns 0.

#define MIN(a, b)                                                              \
    ({                                                                         \
        typeof(1 ? (a) : (b)) _a = (a), _b = (b);                              \
        _a < _b ? _a : _b;                                                     \
    })
#define MAX(a, b)                                                              \
    ({                                                                         \
        typeof(1 ? (a) : (b)) _a = (a), _b = (b);                              \
        _a > _b ? _a : _b;                                                     \
    })

int main(void) {
    int a = 3, b = 7;

    // typeof of a binary expression.
    typeof(a + b) s = a + b;
    if (s != 10) {
        return 1;
    }
    // typeof of a shift.
    typeof(a << 2) sh = a << 2;
    if (sh != 12) {
        return 2;
    }
    // typeof of a conditional (the MIN/MAX shape).
    typeof(1 ? a : b) c = 42;
    if (c != 42) {
        return 3;
    }
    // typeof of a comma expression yields the last operand's type.
    long lv = 100;
    typeof(a, lv) cm = 0x1122334455L;
    if (cm != 0x1122334455L) {
        return 4;
    }

    if (MIN(3, 7) != 3 || MAX(3, 7) != 7) {
        return 5;
    }
    if (MIN(10L, 4L) != 4L || MAX(10L, 4L) != 10L) {
        return 6;
    }
    return 0;
}

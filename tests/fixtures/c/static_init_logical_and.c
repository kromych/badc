// C99 6.6: `&&` and `||` are admitted in an integer constant expression, so a
// static aggregate initializer using them stays a compile-time image. The same
// spelling in prefix position is GNU's block address, which does need runtime
// stores -- both forms appear here, including in one initializer.

struct entry {
    unsigned reg;
    unsigned value;
};

static int classify(int n) {
    // Nested braces: the element expressions must fold, or the whole list
    // falls to the per-element store path, which takes no brace-enclosed
    // element.
    static const struct entry table[] = {
        {1, 1 && 1},
        {2, 1 && 0},
        {3, 0 || 1},
        {4, __builtin_choose_expr(1 && 1, 7, 0)},
        {5, (int)sizeof(struct { _Static_assert(1 && 1, "assert"); })},
    };
    return (int)table[n].value;
}

typedef unsigned long word;

static int dispatch(int n) {
    // The block-address form in the same shape: prefix `&&`, runtime stores.
    // A cast in front of one keeps it a prefix -- a cast's `)` ends no
    // operand, unlike the `)` of a parenthesised expression or of `sizeof`.
    static void *const targets[] = {&&low, &&high};
    static const word as_word[] = {(word)&&low, (word)&&high};
    static const int guard[] = {1 && 1, 0 && 1, sizeof(int) && 1, (1) && 1};
    int r;
    if (as_word[n & 1] != (word)targets[n & 1]) {
        return -1;
    }
    goto *targets[n & 1];
low:
    r = 10;
    goto out;
high:
    r = 20;
out:
    return r + guard[0] + guard[1] + guard[2] + guard[3];
}

int main(void) {
    if (classify(0) != 1 || classify(1) != 0 || classify(2) != 1) {
        return 1;
    }
    // The in-place struct's size is whatever the target gives an empty one;
    // what matters is that the initializer path agrees with the expression.
    if (classify(3) != 7
        || classify(4) != (int)sizeof(struct { _Static_assert(1, "assert"); })) {
        return 2;
    }
    if (dispatch(0) != 13 || dispatch(1) != 23) {
        return 3;
    }
    return 42;
}

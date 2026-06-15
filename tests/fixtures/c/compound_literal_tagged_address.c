// A block-scope compound literal has automatic storage, so its member
// initializers need not be constant expressions (C99 6.5.2.5). An
// address-of combined with a bitwise or shift operator -- the pointer-
// tagging idiom -- is not a link-time constant and must take the runtime
// initialization path rather than the constant-data path. A bare
// `&global` (or `&global + constant`) stays a link-time constant.

struct tagged {
    unsigned long bits;
};

struct ptrs {
    int *p;
    int *q;
};

int g;
int arr[4] = {10, 20, 30, 40};

int main(void) {
    // Address tagging through OR / shift: runtime initialization.
    struct tagged a = (struct tagged){.bits = ((unsigned long)&g) | 1u};
    if ((a.bits & 1u) == 0) return 1;
    if ((a.bits & ~1ul) != (unsigned long)&g) return 2;

    struct tagged b = (struct tagged){.bits = ((unsigned long)&g) >> 2};
    if (b.bits != (((unsigned long)&g) >> 2)) return 3;

    // Bare address and address-plus-constant stay link-time constants.
    struct ptrs c = (struct ptrs){.p = &g, .q = &arr[2]};
    if (c.p != &g) return 4;
    if (*c.q != 30) return 5;

    return 0;
}

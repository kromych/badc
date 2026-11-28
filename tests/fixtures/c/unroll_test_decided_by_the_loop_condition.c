// C17 6.8.5p4: a loop body runs only while the controlling expression
// compares unequal to 0, so a test in the body of the counter against the
// same bound is decided there. Until it is folded it is a branch between
// two blocks of the body, a shape that stays rolled; folded, the loop
// unrolls, the sum is a constant, and the call behind the comparison of
// it, to a function no unit defines, is gone. Linking is the assertion;
// main checks the sum.

extern void never_defined(void);

#define COUNT (sizeof len / sizeof len[0])

static const unsigned char len[] = {3, 5, 7, 9};
static int past;

static inline __attribute__((always_inline)) unsigned total(void) {
    unsigned l = 2;
    int i;
    for (i = 0; i < COUNT; i++) {
        if ((unsigned)i >= COUNT) {
            past++;
        }
        l += len[i];
    }
    return l;
}

int main(void) {
    if (total() > 255) {
        never_defined();
    }
    return total() == 26 && past == 0 ? 0 : 1;
}

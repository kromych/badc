/* C99 6.5.8: relational operators order pointers by address. Addresses
   compare as unsigned magnitudes, so a pointer with the top bit set is
   above a small one; a signed compare inverts every such pair. The
   common-type rule that picks the signed/unsigned flavour for integers
   does not apply, and it leaves most pointer types looking signed. */

struct node {
    int x;
};

static int le_node(struct node *a, struct node *b) {
    return a <= b;
}

static int lt_char(char *a, char *b) {
    return a < b;
}

static int gt_int(int *a, int *b) {
    return a > b;
}

static int ge_ll(long long *a, long long *b) {
    return a >= b;
}

static int le_void(void *a, void *b) {
    return a <= b;
}

static int le_arr(int a[4], int b[4]) {
    return a <= b;
}

/* Folded by the constant evaluator, which orders addresses the same way. */
static int folded_high_above_low = (char *)0xffff888005800248ULL > (char *)3ULL;
static int folded_low_below_high = (char *)3ULL < (char *)0x8000000000000000ULL;

/* `volatile` keeps the operands out of the folder so the emitted
   comparison is the one under test. */
static volatile unsigned long long high_bits = 0xffff888005800248ULL;
static volatile unsigned long long low_bits = 3ULL;

int main(void) {
    struct node *high = (struct node *)(unsigned long long)high_bits;
    struct node *low = (struct node *)(unsigned long long)low_bits;

    if (le_node(high, low)) {
        return 1;
    }
    if (!le_node(low, high)) {
        return 2;
    }
    if (lt_char((char *)high, (char *)low)) {
        return 3;
    }
    if (!gt_int((int *)high, (int *)low)) {
        return 4;
    }
    if (!ge_ll((long long *)high, (long long *)low)) {
        return 5;
    }
    if (le_void((void *)high, (void *)low)) {
        return 6;
    }
    if (le_arr((int *)high, (int *)low)) {
        return 7;
    }
    /* Equal operands must still hold for the non-strict forms. */
    if (!le_node(high, high)) {
        return 8;
    }
    if (!ge_ll((long long *)high, (long long *)high)) {
        return 9;
    }
    if (!folded_high_above_low) {
        return 10;
    }
    if (!folded_low_below_high) {
        return 11;
    }
    return 0;
}

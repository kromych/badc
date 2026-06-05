// C99 6.7.8p7: an array field inside a struct initializer may
// use `[N] = value` designators in its nested brace list. badc
// used to surface ``constant integer expected (got `[`)`` and
// stop; the constant-staging path now mirrors the top-level
// array-initializer's designator handling -- `[N] = value`
// resets the cursor to N and writes there, omitted entries
// stay at the implicit zero.
//
// Predefined macros: this fixture also exercises C99 6.10.8p2
// `__STDC_HOSTED__`, which badc now sets to 1 (the dialect
// always binds to the host libc).

#if __STDC_HOSTED__ != 1
#error "__STDC_HOSTED__ must be 1 on a hosted dialect"
#endif

struct grid {
    int row[5];
};

static struct grid g = {
    .row = {[0] = 10, [2] = 30, [4] = 50},
};

int main(void) {
    if (g.row[0] != 10) return 1;
    if (g.row[1] != 0) return 2;
    if (g.row[2] != 30) return 3;
    if (g.row[3] != 0) return 4;
    if (g.row[4] != 50) return 5;
    return 0;
}

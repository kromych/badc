// A GCC range designator `[lo ... hi] = v` in the initializer of an
// array whose size is deferred to its initializer (`T xs[] = { ... }`).
// The size comes from the highest index reached, and positional elements
// after the range continue from `hi + 1` (C99 6.7.8p17 plus the GCC
// range extension).
//
// The deferred-size case reads its designators with the same walker the
// fixed-size and multi-dimensional cases use, so `[N]`, `[lo ... hi]`
// and a `.field` continuation behave alike at either rank.

#include <stdio.h>

struct row {
    const char *name;
    unsigned int flags;
};

// Range first, then positional elements.
static const struct row lead[] = {
    [0 ... 2] = { "RSVD", 0x0 },
    { "AXI", 0x71000 },
    { "SMN", 0x53000 },
};

// Range in the middle, and one at the end setting the size.
static const struct row mid[] = {
    { "HEAD", 1 },
    [2 ... 3] = { "FILL", 2 },
    { "AFTER", 3 },
    [6 ... 7] = { "TAIL", 4 },
};

// A `.field` continuation on a range.
static const struct row fields[] = {
    [0 ... 2].flags = 9,
    [3] = { "LAST", 5 },
};

// Scalar elements, deferred size.
static const int nums[] = { [0 ... 2] = 7, 8, [5 ... 6] = 9 };

static int streq(const char *a, const char *b) {
    if (!a || !b) return a == b;
    while (*a && *a == *b) { a++; b++; }
    return *a == *b;
}

int main(void) {
    if (sizeof lead / sizeof lead[0] != 5) return 1;
    if (!streq(lead[0].name, "RSVD") || lead[0].flags != 0) return 2;
    if (!streq(lead[2].name, "RSVD")) return 3;
    if (!streq(lead[3].name, "AXI") || lead[3].flags != 0x71000) return 4;
    if (!streq(lead[4].name, "SMN") || lead[4].flags != 0x53000) return 5;

    if (sizeof mid / sizeof mid[0] != 8) return 10;
    if (!streq(mid[0].name, "HEAD") || mid[0].flags != 1) return 11;
    if (mid[1].name != NULL || mid[1].flags != 0) return 12;
    if (!streq(mid[2].name, "FILL") || !streq(mid[3].name, "FILL")) return 13;
    if (!streq(mid[4].name, "AFTER") || mid[4].flags != 3) return 14;
    if (mid[5].name != NULL) return 15;
    if (!streq(mid[6].name, "TAIL") || mid[7].flags != 4) return 16;

    if (sizeof fields / sizeof fields[0] != 4) return 20;
    if (fields[0].flags != 9 || fields[2].flags != 9) return 21;
    if (fields[0].name != NULL) return 22;
    if (!streq(fields[3].name, "LAST") || fields[3].flags != 5) return 23;

    if (sizeof nums / sizeof nums[0] != 7) return 30;
    if (nums[0] != 7 || nums[2] != 7) return 31;
    if (nums[3] != 8) return 32;
    if (nums[4] != 0) return 33;
    if (nums[5] != 9 || nums[6] != 9) return 34;

    printf("ok\n");
    return 0;
}

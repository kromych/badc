// C99 6.7.8p13: an automatic struct array's initializer entries may be
// expressions of the element type; each such entry is one element, so
// a deferred-size array counts entries, not flat field slots. Mixed
// lists still flat-fill fields after a whole-element entry (6.7.8p20),
// and pure flat lists keep the slot-based count. Matches GCC/clang.

struct msg {
    unsigned short addr, flags, len;
    unsigned char *buf;
};

struct pair {
    int a, b;
};

int main(void) {
    unsigned char b1, b2;
    struct msg m1 = {.addr = 0x20, .len = 1, .buf = &b1};
    struct msg m2 = {.addr = 0x21, .flags = 1, .len = 4, .buf = &b2};

    struct msg msgs[] = {m1, m2};
    if (sizeof(msgs) / sizeof(msgs[0]) != 2) return 1;
    if (msgs[0].addr != 0x20 || msgs[0].len != 1 || msgs[0].buf != &b1) return 2;
    if (msgs[1].addr != 0x21 || msgs[1].flags != 1 || msgs[1].buf != &b2) return 3;

    // A whole-element entry followed by flat field values.
    struct pair p1 = {7, 8};
    struct pair mix[] = {p1, 1, 2};
    if (sizeof(mix) / sizeof(mix[0]) != 2) return 4;
    if (mix[0].a != 7 || mix[0].b != 8 || mix[1].a != 1 || mix[1].b != 2) return 5;

    // Flat lists keep the slot-based element count.
    struct pair flat[] = {1, 2, 3, 4};
    struct pair part[] = {1, 2, 3};
    if (sizeof(flat) / sizeof(flat[0]) != 2) return 6;
    if (sizeof(part) / sizeof(part[0]) != 2) return 7;
    if (flat[1].a != 3 || flat[1].b != 4 || part[1].a != 3 || part[1].b != 0) return 8;

    return 0;
}

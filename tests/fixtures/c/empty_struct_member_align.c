// A complete but empty structure member contributes no storage, so the
// member after it shares its offset. Its alignment still applies: an
// empty type declared with `aligned(N)` places the member at N and
// raises the containing type to N. Getting that wrong shifts every
// later member, which a separately compiled translation unit reading
// the same declaration does not do.

struct empty { };
struct empty_aligned { } __attribute__((aligned(64)));
typedef struct { } empty_via_typedef __attribute__((aligned(32)));

struct flex {
    int n;
    struct empty pad;
    long v[];
};

struct spaced {
    long a;
    struct empty_aligned gap;
    long b;
};

struct spaced_typedef {
    long a;
    empty_via_typedef gap;
    long b;
};

struct packed_gap {
    long a;
    struct empty_aligned gap;
    long b;
} __attribute__((packed));

int main(void) {
    if (sizeof(struct empty) != 0) return 1;
    if (__alignof__(struct empty) != 1) return 2;
    if (sizeof(struct empty_aligned) != 0) return 3;
    if (__alignof__(struct empty_aligned) != 64) return 4;

    // The empty member takes the offset the array starts at.
    if (__builtin_offsetof(struct flex, pad) != 4) return 5;
    if (__builtin_offsetof(struct flex, v) != 8) return 6;
    if (sizeof(struct flex) != 8) return 7;

    if (__builtin_offsetof(struct spaced, gap) != 64) return 8;
    if (__builtin_offsetof(struct spaced, b) != 64) return 9;
    if (sizeof(struct spaced) != 128) return 10;
    if (__alignof__(struct spaced) != 64) return 11;

    if (__builtin_offsetof(struct spaced_typedef, gap) != 32) return 12;
    if (__builtin_offsetof(struct spaced_typedef, b) != 32) return 13;
    if (sizeof(struct spaced_typedef) != 64) return 14;

    // `packed` drops the member's alignment request.
    if (__builtin_offsetof(struct packed_gap, gap) != 8) return 15;
    if (__builtin_offsetof(struct packed_gap, b) != 8) return 16;
    if (sizeof(struct packed_gap) != 16) return 17;

    // The layout has to hold at run time, not only under offsetof.
    struct spaced s;
    s.a = 1;
    s.b = 2;
    if ((char *) &s.b - (char *) &s != 64) return 18;
    if ((char *) &s.gap - (char *) &s != 64) return 19;
    return 0;
}

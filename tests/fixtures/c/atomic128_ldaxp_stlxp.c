// 128-bit atomic read-modify-write via the AArch64 ldaxp/stlxp exclusive
// pair -- the shape a C library reaches for when the hardware has no
// native 128-bit compare-and-swap. Exercises the four operations
// (compare-exchange, exchange, fetch-and, fetch-or) against a known
// 128-bit object and checks both the returned prior value and the stored
// result. Under the interpreter the sequence runs as an ordinary load /
// modify / store; native aarch64 emits the real exclusive-pair loop.
//
// long long keeps the halves 64-bit under both LP64 and LLP64.

typedef struct {
    unsigned long long lo;
    unsigned long long hi;
} u128;

static void a16_cmpxchg(u128 *ptr, unsigned long long cl, unsigned long long ch,
                        unsigned long long nl, unsigned long long nh,
                        unsigned long long *ol, unsigned long long *oh) {
    unsigned long long rl, rh;
    unsigned tmp;
    __asm__("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
            "cmp %[oldl], %[cmpl]\n\t"
            "ccmp %[oldh], %[cmph], #0, eq\n\t"
            "b.ne 1f\n\t"
            "stlxp %w[tmp], %[newl], %[newh], %[mem]\n\t"
            "cbnz %w[tmp], 0b\n"
            "1:"
            : [mem] "+m"(*ptr), [tmp] "=&r"(tmp), [oldl] "=&r"(rl),
              [oldh] "=&r"(rh)
            : [cmpl] "r"(cl), [cmph] "r"(ch), [newl] "r"(nl), [newh] "r"(nh)
            : "memory", "cc");
    *ol = rl;
    *oh = rh;
}

static void a16_xchg(u128 *ptr, unsigned long long nl, unsigned long long nh,
                     unsigned long long *ol, unsigned long long *oh) {
    unsigned long long rl, rh;
    unsigned tmp;
    __asm__("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
            "stlxp %w[tmp], %[newl], %[newh], %[mem]\n\t"
            "cbnz %w[tmp], 0b"
            : [mem] "+m"(*ptr), [tmp] "=&r"(tmp), [oldl] "=&r"(rl),
              [oldh] "=&r"(rh)
            : [newl] "r"(nl), [newh] "r"(nh)
            : "memory");
    *ol = rl;
    *oh = rh;
}

static void a16_fetch_and(u128 *ptr, unsigned long long nl, unsigned long long nh,
                          unsigned long long *ol, unsigned long long *oh) {
    unsigned long long rl, rh, tl, th;
    unsigned tmp;
    __asm__("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
            "and %[tmpl], %[oldl], %[newl]\n\t"
            "and %[tmph], %[oldh], %[newh]\n\t"
            "stlxp %w[tmp], %[tmpl], %[tmph], %[mem]\n\t"
            "cbnz %w[tmp], 0b"
            : [mem] "+m"(*ptr), [tmp] "=&r"(tmp), [oldl] "=&r"(rl),
              [oldh] "=&r"(rh), [tmpl] "=&r"(tl), [tmph] "=&r"(th)
            : [newl] "r"(nl), [newh] "r"(nh)
            : "memory");
    *ol = rl;
    *oh = rh;
}

static void a16_fetch_or(u128 *ptr, unsigned long long nl, unsigned long long nh,
                         unsigned long long *ol, unsigned long long *oh) {
    unsigned long long rl, rh, tl, th;
    unsigned tmp;
    __asm__("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
            "orr %[tmpl], %[oldl], %[newl]\n\t"
            "orr %[tmph], %[oldh], %[newh]\n\t"
            "stlxp %w[tmp], %[tmpl], %[tmph], %[mem]\n\t"
            "cbnz %w[tmp], 0b"
            : [mem] "+m"(*ptr), [tmp] "=&r"(tmp), [oldl] "=&r"(rl),
              [oldh] "=&r"(rh), [tmpl] "=&r"(tl), [tmph] "=&r"(th)
            : [newl] "r"(nl), [newh] "r"(nh)
            : "memory");
    *ol = rl;
    *oh = rh;
}

int main(void) {
    u128 x;
    unsigned long long ol, oh;

    // Compare-exchange, matching: store the new pair, return the old.
    x.lo = 1;
    x.hi = 2;
    a16_cmpxchg(&x, 1, 2, 9, 10, &ol, &oh);
    if (ol != 1 || oh != 2) return 1;
    if (x.lo != 9 || x.hi != 10) return 2;

    // Compare-exchange, mismatching: leave the object, return the old.
    a16_cmpxchg(&x, 0, 0, 5, 6, &ol, &oh);
    if (ol != 9 || oh != 10) return 3;
    if (x.lo != 9 || x.hi != 10) return 4;

    // Exchange: store unconditionally, return the old.
    a16_xchg(&x, 7, 8, &ol, &oh);
    if (ol != 9 || oh != 10) return 5;
    if (x.lo != 7 || x.hi != 8) return 6;

    // Fetch-and: store old & new, return the old.
    x.lo = 0xF0F0;
    x.hi = 0xFF00;
    a16_fetch_and(&x, 0x0FF0, 0x00FF, &ol, &oh);
    if (ol != 0xF0F0 || oh != 0xFF00) return 7;
    if (x.lo != 0x00F0 || x.hi != 0x0000) return 8;

    // Fetch-or: store old | new, return the old.
    x.lo = 0xF000;
    x.hi = 0x00FF;
    a16_fetch_or(&x, 0x000F, 0xFF00, &ol, &oh);
    if (ol != 0xF000 || oh != 0x00FF) return 9;
    if (x.lo != 0xF00F || x.hi != 0xFFFF) return 10;

    return 0;
}

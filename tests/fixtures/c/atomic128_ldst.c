// 128-bit atomic load / store via the AArch64 ldp/stp and ldxp/stxp
// exclusive-pair idioms -- the shapes a C library reaches for when the
// hardware has no native 16-byte atomic access. Exercises the plain and
// exclusive load / store forms against a 16-byte object and cross-checks
// that a value stored by one form reads back through the other. The plain
// load also runs against a read-only object to confirm it emits no store.
// Under the interpreter each form runs as an ordinary load / store; native
// aarch64 emits the real ldp/stp or ldxp/stxp sequence.
//
// unsigned long long keeps the halves 64-bit under both LP64 and LLP64.

typedef struct {
    unsigned long long lo;
    unsigned long long hi;
} u128;

// Read-only source: a plain LDP must not write, or it faults on this page.
static const u128 ro = {0x0123456789abcdefULL, 0xfedcba9876543210ULL};

static void a16_load(const u128 *ptr, unsigned long long *ol,
                     unsigned long long *oh) {
    unsigned long long l, h;
    __asm__("ldp %[l], %[h], %[mem]"
            : [l] "=r"(l), [h] "=r"(h)
            : [mem] "m"(*ptr));
    *ol = l;
    *oh = h;
}

static void a16_store(u128 *ptr, unsigned long long l, unsigned long long h) {
    __asm__("stp %[l], %[h], %[mem]" : [mem] "=m"(*ptr) : [l] "r"(l), [h] "r"(h));
}

static void a16_load_ex(u128 *ptr, unsigned long long *ol,
                        unsigned long long *oh) {
    unsigned long long l, h;
    unsigned tmp;
    __asm__("0: ldxp %[l], %[h], %[mem]\n\t"
            "stxp %w[tmp], %[l], %[h], %[mem]\n\t"
            "cbnz %w[tmp], 0b"
            : [mem] "+m"(*ptr), [tmp] "=&r"(tmp), [l] "=&r"(l), [h] "=&r"(h)
            :
            : "memory");
    *ol = l;
    *oh = h;
}

static void a16_store_ex(u128 *ptr, unsigned long long l, unsigned long long h) {
    unsigned long long t1, t2;
    __asm__("0: ldxp %[t1], %[t2], %[mem]\n\t"
            "stxp %w[t1], %[l], %[h], %[mem]\n\t"
            "cbnz %w[t1], 0b"
            : [mem] "+m"(*ptr), [t1] "=&r"(t1), [t2] "=&r"(t2)
            : [l] "r"(l), [h] "r"(h)
            : "memory");
}

int main(void) {
    u128 x;
    unsigned long long ol, oh;

    // Plain store then plain load: value round-trips.
    a16_store(&x, 0x1111222233334444ULL, 0x5555666677778888ULL);
    a16_load(&x, &ol, &oh);
    if (ol != 0x1111222233334444ULL || oh != 0x5555666677778888ULL) return 1;

    // Exclusive store then exclusive load: value round-trips.
    a16_store_ex(&x, 0xaaaabbbbccccddddULL, 0x1122334455667788ULL);
    a16_load_ex(&x, &ol, &oh);
    if (ol != 0xaaaabbbbccccddddULL || oh != 0x1122334455667788ULL) return 2;

    // Cross forms: plain store, exclusive load.
    a16_store(&x, 0xdeadbeefcafef00dULL, 0x0f0f0f0f0f0f0f0fULL);
    a16_load_ex(&x, &ol, &oh);
    if (ol != 0xdeadbeefcafef00dULL || oh != 0x0f0f0f0f0f0f0f0fULL) return 3;

    // Cross forms: exclusive store, plain load.
    a16_store_ex(&x, 0x0102030405060708ULL, 0x090a0b0c0d0e0f00ULL);
    a16_load(&x, &ol, &oh);
    if (ol != 0x0102030405060708ULL || oh != 0x090a0b0c0d0e0f00ULL) return 4;

    // Plain load from a read-only object: must not fault (emits no store).
    a16_load(&ro, &ol, &oh);
    if (ol != 0x0123456789abcdefULL || oh != 0xfedcba9876543210ULL) return 5;

    return 0;
}

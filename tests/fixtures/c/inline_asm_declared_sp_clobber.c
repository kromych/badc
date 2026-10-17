// An asm statement lists sp as clobbered and leaves it 16 bytes lower, on
// x86-64 without naming it; GNU C requires it to leave sp as it found it,
// and badc's frame follows the move. Exits 0 when the values live across it,
// the return and the caller's values survive, a distinct code per failure.

static volatile long long input = 7;

#if defined(__aarch64__)
#define LEAVE_SP_MOVED() __asm__ volatile("sub sp, sp, #16" : : : "sp", "memory")
#elif defined(__x86_64__)
#define LEAVE_SP_MOVED() __asm__ volatile("pushq $0x77\n\tpushq $0x77" : : : "rsp", "memory")
#endif

__attribute__((noinline)) static long long mix(long long x) { return x * 2 + 1; }

#define VALUES(s)                                                                        \
    long long v0 = (s) + 1, v1 = (s) * 3, v2 = (s) ^ 0x55, v3 = (s) * (s);               \
    long long v4 = (s) - 9, v5 = (s) << 4, v6 = (s) * 7 + 2, v7 = (s) ^ 0x1234;          \
    long long v8 = (s) * 11, v9 = (s) + 100, v10 = (s) * 13 - 5, v11 = (s) << 9;         \
    long long v12 = (s) ^ 0x7777, v13 = (s) * 17, v14 = (s) + 12345, v15 = (s) * 19 + 3

#define COMBINE(m)                                                                       \
    (v0 + 2 * v1 + 3 * v2 + 4 * v3 + 5 * v4 + 6 * v5 + 7 * v6 + 8 * v7 + 9 * v8 +          \
     10 * v9 + 11 * v10 + 12 * v11 + 13 * v12 + 14 * v13 + 15 * v14 + 16 * v15 + (m))

__attribute__((noinline)) static long long moved(long long s) {
    VALUES(s);
    long long m = mix(s);
    LEAVE_SP_MOVED();
    m += mix(m);
    return COMBINE(m);
}

__attribute__((noinline)) static long long kept(long long s) {
    VALUES(s);
    long long m = mix(s);
    m += mix(m);
    return COMBINE(m);
}

int main(void) {
    long long a = input * 5, b = input ^ 0x99, c = input + 77, d = input * 3;
    long long s = input;
    if (moved(s) != kept(s))
        return 1;
    if (a != 35 || b != (7 ^ 0x99) || c != 84 || d != 21)
        return 2;
    if (moved(s + 1) != kept(s + 1))
        return 3;
    return 0;
}

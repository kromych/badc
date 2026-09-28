// An automatic object aligned above the 8-byte frame slot lives in the
// frame's over-aligned region alone. Callees write and read each object
// through the pointer they receive and check its alignment. Objects in
// disjoint blocks may share region storage and each keeps its contents
// while it lives; objects alive together keep theirs apart; a 16-byte
// aligned by-value parameter's copy lands in the region. Exits 0 when
// every check holds, a distinct code per failure.
#include <stdint.h>

struct st16 {
    _Alignas(16) unsigned char v[512];
    unsigned int fpsr, fpcr;
};

struct pair16 {
    _Alignas(16) unsigned long long lo;
    unsigned long long hi;
};

static volatile unsigned input[] = {3, 5, 7};

__attribute__((noinline)) static void fill(unsigned char *p, int n, unsigned seed) {
    for (int i = 0; i < n; i++)
        p[i] = (unsigned char)(seed + 3 * i);
}

__attribute__((noinline)) static int check(const unsigned char *p, int n, unsigned seed,
                                           uintptr_t align) {
    if (((uintptr_t)p & (align - 1)) != 0)
        return 0;
    for (int i = 0; i < n; i++)
        if (p[i] != (unsigned char)(seed + 3 * i))
            return 0;
    return 1;
}

__attribute__((noinline)) static int one(unsigned seed) {
    struct st16 s;
    fill((unsigned char *)&s, sizeof s, seed);
    return check((unsigned char *)&s, sizeof s, seed, 16);
}

__attribute__((noinline)) static int branches(int c, unsigned seed) {
    if (c) {
        struct st16 a;
        fill((unsigned char *)&a, sizeof a, seed);
        return check((unsigned char *)&a, sizeof a, seed, 16);
    } else {
        struct st16 b;
        fill((unsigned char *)&b, sizeof b, seed + 1);
        return check((unsigned char *)&b, sizeof b, seed + 1, 16);
    }
}

__attribute__((noinline)) static int joined(int c, unsigned seed) {
    int ok;
    if (c) {
        struct st16 a;
        fill((unsigned char *)&a, sizeof a, seed + 2);
        ok = check((unsigned char *)&a, sizeof a, seed + 2, 16);
    } else {
        struct st16 b;
        fill((unsigned char *)&b, sizeof b, seed + 3);
        ok = check((unsigned char *)&b, sizeof b, seed + 3, 16);
    }
    return ok;
}

__attribute__((noinline)) static int sequence(unsigned seed) {
    int ok = 1;
    {
        struct st16 a;
        fill((unsigned char *)&a, sizeof a, seed);
        ok &= check((unsigned char *)&a, sizeof a, seed, 16);
    }
    {
        struct st16 b;
        fill((unsigned char *)&b, sizeof b, seed + 9);
        ok &= check((unsigned char *)&b, sizeof b, seed + 9, 16);
    }
    return ok;
}

__attribute__((noinline)) static int nested(unsigned seed) {
    struct st16 outer;
    fill((unsigned char *)&outer, sizeof outer, seed);
    int ok = 1;
    for (int i = 0; i < 2; i++) {
        struct st16 inner;
        fill((unsigned char *)&inner, sizeof inner, seed + 20 + i);
        ok &= check((unsigned char *)&inner, sizeof inner, seed + 20 + i, 16);
        ok &= check((unsigned char *)&outer, sizeof outer, seed, 16);
    }
    return ok && check((unsigned char *)&outer, sizeof outer, seed, 16);
}

__attribute__((noinline)) static int wide(unsigned seed) {
    _Alignas(64) unsigned char buf[256];
    _Alignas(16) unsigned char small[48];
    unsigned long long plain[4];
    fill(buf, sizeof buf, seed);
    fill(small, sizeof small, seed + 1);
    fill((unsigned char *)plain, sizeof plain, seed + 2);
    return check(buf, sizeof buf, seed, 64) && check(small, sizeof small, seed + 1, 16) &&
           check((unsigned char *)plain, sizeof plain, seed + 2, 8);
}

__attribute__((noinline)) static unsigned long long sum_pair(const struct pair16 *q) {
    return ((uintptr_t)q & 15) == 0 ? q->lo + q->hi : 0;
}

__attribute__((noinline)) static unsigned long long by_value(struct pair16 p) {
    return sum_pair(&p);
}

int main(void) {
    unsigned seed = input[0];
    if (!one(seed))
        return 1;
    if (!branches(input[1] > 0, seed) || !branches(input[1] == 0, seed))
        return 2;
    if (!joined(input[1] > 0, seed) || !joined(input[1] == 0, seed))
        return 7;
    if (!sequence(seed))
        return 3;
    if (!nested(seed))
        return 4;
    if (!wide(seed))
        return 5;
    struct pair16 p = {input[1], input[2]};
    if (by_value(p) != 12)
        return 6;
    return 0;
}

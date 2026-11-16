// SSE4.2's string compares, PCMPESTRI, PCMPESTRM, PCMPISTRI, PCMPISTRM
// and the flags their intrinsics read, checked against the SDM's
// definition (section 4.1): the comparison table of each element pair with
// the overrides for elements past a string's end, the aggregation, the
// polarity, and the index or mask output, for every data format,
// aggregation, polarity and output form, on strings over a small alphabet
// with random lengths, explicit lengths past the element count and
// negative. Groups 0-3 are the implicit-length forms by format, 4-7 the
// explicit-length ones; the exit code has bit N set when group N fails.
// Elsewhere than x86-64 the unit is empty.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <nmmintrin.h>
#include <string.h>

typedef unsigned long long u64;

static u64 seed = 0x9E3779B97F4A7C15ULL;

static u64 next(void) {
    seed ^= seed >> 12;
    seed ^= seed << 25;
    seed ^= seed >> 27;
    return seed * 0x2545F4914F6CDD1DULL;
}

// Element `i` of the 16 bytes `v` in the format imm8[1:0] names.
static int elem(const unsigned char *v, int i, int m) {
    switch (m & 3) {
    case 0: return v[i];
    case 1: return v[2 * i] | v[2 * i + 1] << 8;
    case 2: return (signed char)v[i];
    default: return (short)(v[2 * i] | v[2 * i + 1] << 8);
    }
}

struct result {
    int res2, index;
    unsigned char mask[16];
    int cf, zf, sf, of;
};

// The SDM's model: BoolRes[j][i] for element j of the first operand and i
// of the second, forced by table 4-7 where either is invalid; IntRes1 by
// the aggregation; IntRes2 by the polarity; then the outputs and flags.
static struct result model(const unsigned char *a, int la, const unsigned char *b, int lb,
                           int m) {
    int n = m & 1 ? 8 : 16, agg = m >> 2 & 3;
    int bool_res[16][16];
    for (int j = 0; j < n; j++)
        for (int i = 0; i < n; i++) {
            int va = j < la, vb = i < lb;
            int x = elem(a, j, m), y = elem(b, i, m);
            int cmp = agg == 1 ? (j & 1 ? y <= x : y >= x) : x == y;
            if (va && vb)
                bool_res[j][i] = cmp;
            else if (agg == 0 || agg == 1)
                bool_res[j][i] = 0;
            else if (agg == 2)
                bool_res[j][i] = !va && !vb;
            else
                bool_res[j][i] = !va;
        }
    int res1 = 0;
    for (int i = 0; i < n; i++) {
        int bit = 0;
        if (agg == 0) {
            for (int j = 0; j < n; j++)
                bit |= bool_res[j][i];
        } else if (agg == 1) {
            for (int j = 0; j < n; j += 2)
                bit |= bool_res[j][i] && bool_res[j + 1][i];
        } else if (agg == 2) {
            bit = bool_res[i][i];
        } else {
            bit = 1;
            for (int j = 0, k = i; j < n - i; j++, k++)
                bit &= bool_res[j][k];
        }
        res1 |= bit << i;
    }
    int pol = m >> 4 & 3, res2 = res1;
    for (int i = 0; i < n; i++)
        if (pol == 1 || (pol == 3 && i < lb))
            res2 ^= 1 << i;
    struct result r;
    memset(&r, 0, sizeof r);
    r.res2 = res2;
    r.index = n;
    for (int i = 0; i < n; i++)
        if (res2 >> i & 1 && (m & 0x40 || r.index == n))
            r.index = i;
    if (m & 0x40) {
        for (int i = 0; i < n; i++)
            for (int k = 0; k < 16 / n; k++)
                r.mask[i * (16 / n) + k] = res2 >> i & 1 ? 0xFF : 0;
    } else {
        r.mask[0] = (unsigned char)res2;
        r.mask[1] = (unsigned char)(res2 >> 8);
    }
    r.cf = res2 != 0;
    r.zf = lb < n;
    r.sf = la < n;
    r.of = res2 & 1;
    return r;
}

static int implicit_length(const unsigned char *v, int m) {
    int n = m & 1 ? 8 : 16, i = 0;
    while (i < n && elem(v, i, m) != 0)
        i++;
    return i;
}

static int explicit_length(int l, int m) {
    int n = m & 1 ? 8 : 16;
    long long x = l < 0 ? -(long long)l : l;
    return x > n ? n : (int)x;
}

// A string over a four-letter alphabet, so elements match often, with
// about one element in eight null.
static void string(unsigned char *v) {
    static const unsigned char alphabet[5] = {'a', 'b', 'c', 0x80, 0xFF};
    for (int k = 0; k < 16; k++) {
        u64 r = next();
        v[k] = r >> 61 == 0 ? 0 : alphabet[(r >> 32) % 5];
    }
}

static int fail;

static void compare(int group, const struct result *want, int index, __m128i mask, int a,
                    int c, int o, int s, int z) {
    unsigned char got[16];
    memcpy(got, &mask, 16);
    if (index != want->index || memcmp(got, want->mask, 16) != 0 ||
        a != (!want->cf && !want->zf) || c != want->cf || o != want->of || s != want->sf ||
        z != want->zf)
        fail |= group;
}

#define CHECK(M)                                                                          \
    do {                                                                                  \
        struct result w = model(a, implicit_length(a, M), b, implicit_length(b, M), M);  \
        compare(1 << ((M) & 3), &w, _mm_cmpistri(x, y, M), _mm_cmpistrm(x, y, M),        \
                _mm_cmpistra(x, y, M), _mm_cmpistrc(x, y, M), _mm_cmpistro(x, y, M),      \
                _mm_cmpistrs(x, y, M), _mm_cmpistrz(x, y, M));                            \
        w = model(a, explicit_length(la, M), b, explicit_length(lb, M), M);               \
        compare(16 << ((M) & 3), &w, _mm_cmpestri(x, la, y, lb, M),                        \
                _mm_cmpestrm(x, la, y, lb, M), _mm_cmpestra(x, la, y, lb, M),             \
                _mm_cmpestrc(x, la, y, lb, M), _mm_cmpestro(x, la, y, lb, M),             \
                _mm_cmpestrs(x, la, y, lb, M), _mm_cmpestrz(x, la, y, lb, M));            \
    } while (0)

// Each aggregation and polarity, at the format `F` and both output forms.
#define CHECK_FORMAT(F)  \
    CHECK((F) | 0x00);   \
    CHECK((F) | 0x04);   \
    CHECK((F) | 0x08);   \
    CHECK((F) | 0x0C);   \
    CHECK((F) | 0x10);   \
    CHECK((F) | 0x14);   \
    CHECK((F) | 0x18);   \
    CHECK((F) | 0x1C);   \
    CHECK((F) | 0x20);   \
    CHECK((F) | 0x24);   \
    CHECK((F) | 0x28);   \
    CHECK((F) | 0x2C);   \
    CHECK((F) | 0x30);   \
    CHECK((F) | 0x34);   \
    CHECK((F) | 0x38);   \
    CHECK((F) | 0x3C);   \
    CHECK((F) | 0x40);   \
    CHECK((F) | 0x44);   \
    CHECK((F) | 0x48);   \
    CHECK((F) | 0x4C);   \
    CHECK((F) | 0x50);   \
    CHECK((F) | 0x54);   \
    CHECK((F) | 0x58);   \
    CHECK((F) | 0x5C);   \
    CHECK((F) | 0x60);   \
    CHECK((F) | 0x64);   \
    CHECK((F) | 0x68);   \
    CHECK((F) | 0x6C);   \
    CHECK((F) | 0x70);   \
    CHECK((F) | 0x74);   \
    CHECK((F) | 0x78);   \
    CHECK((F) | 0x7C)

static void round_of(void) {
    static const int lengths[] = {0, 1, 3, 7, 8, 9, 15, 16, 17, 100, -1, -5, -8, -16, -40,
                                  (int)0x80000000};
    unsigned char a[16], b[16];
    string(a);
    string(b);
    u64 r = next();
    if ((r & 7) == 0)
        memcpy(b + (r >> 8 & 7), a, 4);
    int la = lengths[(r >> 16) % 16], lb = lengths[(r >> 24) % 16];
    __m128i x, y;
    memcpy(&x, a, 16);
    memcpy(&y, b, 16);
    CHECK_FORMAT(0);
    CHECK_FORMAT(1);
    CHECK_FORMAT(2);
    CHECK_FORMAT(3);
}

int main(void) {
    for (int k = 0; k < 200; k++)
        round_of();
    return fail;
}
#else
int main(void) {
    return 0;
}
#endif

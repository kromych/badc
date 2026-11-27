// snapshot-budget: exempt
/* Lowerings that borrow a register within one instruction -- division and
   the high multiply through rdx:rax, a shift by a variable count through cl,
   an indirect call whose target waits out the argument moves, atomic
   read-modify-write and compare-exchange through rax, aggregate copies and
   x87 conversions -- with many values live across each, in functions whose
   x86-64 frame has no frame pointer at -O. Stack-passed parameters are read
   from a frame that allocates nothing and from one with locals, and a tail
   call leaves a frame, and six values live across calls take rbp as a
   callee-saved register in caller and callee alike. The exit code names
   the first mismatch. */

#define NOINLINE __attribute__((noinline))

typedef long long ll;
typedef unsigned long long ull;

volatile ll in[8] = { 3, 7, 11, 13, 17, 19, 23, 29 };

NOINLINE ll divs(ll a, ll b, ll c, ll d, ll e, ll f) {
    ll s = a * 3 + b, t = c * 5 + d, u = e * 7 + f, v = a ^ c, w = b ^ d, x = e ^ f;
    ll q = (s + t) / (u | 1), r = (s * t) % (u | 1);
    ull h = (ull)(s * t * 977) / (ull)(w | 1);
    ull m = (ull)(s * 0x10001) * (ull)(t * 0x3001) >> 7;
    return q + r + (ll)h + (ll)(m & 0xffff) + s + t + u + v + w + x;
}

NOINLINE ull shifts(ull a, ull b, int n, int m) {
    ull x = a * 5, y = b * 9, z = a ^ b, w = a + b;
    ull p = x << (n & 63), q = y >> (m & 63), r = z << ((n + m) & 63);
    ll s = (ll)(w | 0x8000000000000000ull) >> (m & 31);
    return p ^ q ^ r ^ (ull)s ^ x ^ y ^ z ^ w;
}

NOINLINE ull divq(ull hi, ull lo, ull d) {
    unsigned __int128 n = ((unsigned __int128)hi << 64) | lo;
    return (ull)(n / d) ^ (ull)(n % d);
}

static ll add6(ll a, ll b, ll c, ll d, ll e, ll f) { return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6; }
static ll sub6(ll a, ll b, ll c, ll d, ll e, ll f) { return a - b + c - d + e - f; }

struct ops { ll (*f[2])(ll, ll, ll, ll, ll, ll); };

NOINLINE ll indirect(struct ops *volatile o, ll a, ll b, ll c, ll d, ll e, ll f) {
    ll s = 0;
    for (int i = 0; i < 4; i++)
        s += o->f[i & 1](a + i, b * i, c - i, d + s, e ^ i, f * 2) + a * b;
    return s;
}

NOINLINE ll atomics(ll *p, ll a, ll b, ll c, ll d) {
    ll s = a + b, t = c + d, u = a * d;
    for (int i = 0; i < 5; i++) {
        s += __atomic_fetch_add(p, a + i, __ATOMIC_SEQ_CST);
        t ^= __atomic_fetch_or(p, (ll)1 << i, __ATOMIC_SEQ_CST);
        ll want = *p;
        if (__atomic_compare_exchange_n(p, &want, want * 2 + b, 0, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST))
            u += want;
    }
    return s + t + u + *p;
}

struct blk { ll v[5]; };

NOINLINE ll copies(struct blk *dst, const struct blk *src, int n, ll a, ll b, ll c) {
    ll s = a + b + c;
    for (int i = 0; i < n; i++) {
        dst[i] = src[n - 1 - i];
        s += dst[i].v[i % 5] * a + b * c;
    }
    return s;
}

NOINLINE ll x87(long double *slot, ll a, ll b) {
    double s = 0;
    for (int i = 0; i < 4; i++) {
        slot[i] = (long double)(a * i + b) / 4;
        s += (double)slot[(i + 3) & 3];
    }
    return (ll)(s * 8);
}

/* Eight parameters, two on the stack, read with no call and no local. */
NOINLINE ll eight(ll a, ll b, ll c, ll d, ll e, ll f, ll g, ll h) {
    return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8;
}

/* The same, with an array the stack parameters index past. */
NOINLINE ll eight_local(ll a, ll b, ll c, ll d, ll e, ll f, ll g, ll h) {
    ll arr[6] = { a, b, c, d, e, f };
    ll s = 0;
    for (int i = 0; i < 6; i++)
        s += arr[(i + (int)g) % 6] * (h + i);
    return s;
}

NOINLINE ll tail(ll a, ll b) {
    ll t = divs(a, b, a + 1, b + 1, a + 2, b + 2);
    return sub6(t, a, b, t + a, t + b, a * b);
}

NOINLINE ll leaf6(ll a, ll b, ll c, ll d, ll e, ll f) { return a ^ b ^ c ^ d ^ e ^ f; }

NOINLINE ll mid6(ll a, ll b, ll c, ll d, ll e, ll f) {
    ll x = leaf6(f, e, d, c, b, a);
    return x + a * 3 + b * 5 + c * 7 + d * 11 + e * 13 + f * 17;
}

NOINLINE ll top6(ll a, ll b, ll c, ll d, ll e, ll f) {
    ll x = mid6(a + 1, b + 1, c + 1, d + 1, e + 1, f + 1);
    ll y = mid6(b, c, d, e, f, a);
    return x - y + a * b + c * d + e * f;
}

int main(void) {
    ll a = in[0], b = in[1], c = in[2], d = in[3], e = in[4], f = in[5], g = in[6], h = in[7];
    if (divs(a, b, c, d, e, f) != 103143)
        return 1;
    if (shifts((ull)a * 0x123456789ull, (ull)b * 0x987654321ull, (int)c, (int)d) != 0xbe269e2563012012ull)
        return 2;
    if (divq((ull)a, (ull)b * 0x1111111111111111ull, 0xfedcba9876543211ull) != 0x7ae147ae147ae147ull)
        return 3;
    static struct ops o = { { add6, sub6 } };
    if (indirect(&o, a, b, c, d, e, f) != -19)
        return 4;
    static ll cell = 5;
    if (atomics(&cell, a, b, c, d) != 2452)
        return 5;
    static struct blk src[3] = { { { 1, 2, 3, 4, 5 } }, { { 6, 7, 8, 9, 10 } }, { { 11, 12, 13, 14, 15 } } };
    static struct blk dst[3];
    if (copies(dst, src, 3, a, b, c) != 315 || dst[0].v[4] != 15 || dst[2].v[0] != 1)
        return 6;
    static long double slot[4];
    if (x87(slot, a, b) != 60)
        return 7;
    if (eight(a, b, c, d, e, f, g, h) != 694)
        return 8;
    if (eight_local(a, b, c, d, e, f, g, h) != 2217)
        return 9;
    if (tail(a, b) != 39574)
        return 10;
    if (top6(a, b, c, d, e, f) != 707)
        return 11;
    return 0;
}

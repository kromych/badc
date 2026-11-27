// Sixteen values carried around a loop with its counter and its bound,
// more than the general registers hold: some are spilled, others sit in
// r10 and r11, which the x86-64 lowerings otherwise take as scratch. The
// body takes scratch where no register is free -- a 64-bit immediate, a
// variable shift count, a division, a select, an indexed store, a switch
// and a call -- and borrows one from a value living across it. Each result
// is checked against the same computation over a volatile array. Returns 0
// when every check passes; each failure returns a distinct code. The
// values are unsigned, so their arithmetic wraps (C17 6.2.5p9).
// snapshot-budget: exempt

typedef unsigned long u;

__attribute__((noinline)) u mix(u x, u y) {
    return (x ^ (y >> 3)) * 0x9e3779b97f4a7c15ul;
}

#define BODY(a, b, c, d, e, f, g, h, i_, j, k, l, m, n_, o, p)        \
    {                                                                 \
        u t = a * 0x9e3779b97f4a7c15ul;                               \
        a = b + (c >> (d & 63));                                      \
        b = c ^ (t / (e | 1));                                        \
        c = d + (f < g ? h : i_);                                     \
        out[i & 7] = j + k;                                           \
        switch (i & 3) {                                              \
        case 0: d = e ^ l; break;                                     \
        case 1: d = e + (l << 3); break;                              \
        case 2: d = e - l; break;                                     \
        default: d = (e | 1) * l; break;                              \
        }                                                             \
        if ((i & 15) == 0)                                            \
            t ^= mix(a, b);                                           \
        e = f + m; f = g ^ n_; g = h + o; h = i_ ^ p; i_ = j + a;     \
        j = k ^ b; k = l + c; l = m ^ d; m = n_ + e; n_ = o ^ f;      \
        o = p + g; p = t ^ h;                                         \
    }

__attribute__((noinline)) u direct(u *out, const u *in, long n) {
    u a = in[0], b = in[1], c = in[2], d = in[3], e = in[4], f = in[5];
    u g = in[6], h = in[7], i_ = in[8], j = in[9], k = in[10], l = in[11];
    u m = in[12], n_ = in[13], o = in[14], p = in[15];
    for (long i = 0; i < n; i++)
        BODY(a, b, c, d, e, f, g, h, i_, j, k, l, m, n_, o, p)
    return a ^ b ^ c ^ d ^ e ^ f ^ g ^ h ^ i_ ^ j ^ k ^ l ^ m ^ n_ ^ o ^ p;
}

__attribute__((noinline)) u in_memory(u *out, const u *in, long n) {
    volatile u v[16];
    for (int s = 0; s < 16; s++)
        v[s] = in[s];
    for (long i = 0; i < n; i++)
        BODY(v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9], v[10],
             v[11], v[12], v[13], v[14], v[15])
    u r = 0;
    for (int s = 0; s < 16; s++)
        r ^= v[s];
    return r;
}

int main(void) {
    u in[16];
    for (int s = 0; s < 16; s++)
        in[s] = mix((u)s * 0x0123456789abcdeful, (u)s + 7);
    u out_a[8] = {0}, out_b[8] = {0};
    long lengths[] = {0, 1, 5, 16, 33, 1000};
    for (unsigned q = 0; q < sizeof lengths / sizeof lengths[0]; q++) {
        u x = direct(out_a, in, lengths[q]);
        u y = in_memory(out_b, in, lengths[q]);
        if (x != y)
            return (int)(1 + q);
        for (int s = 0; s < 8; s++)
            if (out_a[s] != out_b[s])
                return (int)(10 + q);
    }
    return 0;
}

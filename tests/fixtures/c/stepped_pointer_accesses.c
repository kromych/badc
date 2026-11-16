// Loads and stores through a pointer stepped past them in a loop, at
// each access width and signedness, floating, and stepping down: each
// result is checked against the same computation through an index.
// Returns 0 when every check passes; each failure returns a distinct code.

typedef unsigned long long u64;

#define SUM(name, T)                                                                    \
    __attribute__((noinline)) u64 name(const T *p, long n) {                           \
        u64 s = 0;                                                                      \
        while (n--)                                                                     \
            s = s * 3 + (u64)*p++;                                                     \
        return s;                                                                       \
    }                                                                                   \
    __attribute__((noinline)) u64 name##_ref(const T *p, long n) {                     \
        u64 s = 0;                                                                      \
        for (volatile long i = 0; i < n; i++)                                           \
            s = s * 3 + (u64)p[i];                                                     \
        return s;                                                                       \
    }

SUM(sum_u8, unsigned char)
SUM(sum_i8, signed char)
SUM(sum_u16, unsigned short)
SUM(sum_i16, short)
SUM(sum_u32, unsigned)
SUM(sum_i32, int)
SUM(sum_u64, u64)

__attribute__((noinline)) double dot(const double *x, const float *y, long n) {
    double s = 0;
    while (n--)
        s += *x++ * *y++;
    return s;
}

__attribute__((noinline)) double dot_ref(const double *x, const float *y, long n) {
    double s = 0;
    for (volatile long i = 0; i < n; i++)
        s += x[i] * y[i];
    return s;
}

// Stores stepping up, and a copy stepping down from the end.
__attribute__((noinline)) void fill(unsigned short *d, unsigned *e, long n, unsigned v) {
    while (n--) {
        *d++ = (unsigned short)v;
        *e++ = v;
        v = v * 7 + 1;
    }
}

// Zero stored through a stepped pointer, and one store ending a token.
__attribute__((noinline)) void clear(unsigned short *d, long n) {
    while (n--)
        *d++ = 0;
}

__attribute__((noinline)) unsigned short *cut(unsigned short *e) {
    if (*e)
        *e++ = 0;
    return e;
}

__attribute__((noinline)) void reverse(char *d, const char *s, long n) {
    const char *p = s + n;
    while (p != s)
        *d++ = *--p;
}

int main(void) {
    static unsigned char b[64];
    static unsigned short h[64];
    static unsigned w[64];
    static u64 q[64];
    static double x[64];
    static float y[64];
    for (int i = 0; i < 64; i++) {
        b[i] = (unsigned char)(i * 37 + 200);
        h[i] = (unsigned short)(i * 4099 + 40000);
        w[i] = 0x9e3779b9u * (unsigned)(i + 1);
        q[i] = 0x9e3779b97f4a7c15ull * (u64)(i + 3);
        x[i] = i * 0.25 - 3.0;
        y[i] = (float)(i * 1.5 - 20.0);
    }
    if (sum_u8(b, 64) != sum_u8_ref(b, 64)) return 1;
    if (sum_i8((const signed char *)b, 64) != sum_i8_ref((const signed char *)b, 64)) return 2;
    if (sum_u16(h, 64) != sum_u16_ref(h, 64)) return 3;
    if (sum_i16((const short *)h, 64) != sum_i16_ref((const short *)h, 64)) return 4;
    if (sum_u32(w, 64) != sum_u32_ref(w, 64)) return 5;
    if (sum_i32((const int *)w, 64) != sum_i32_ref((const int *)w, 64)) return 6;
    if (sum_u64(q, 64) != sum_u64_ref(q, 64)) return 7;
    if (dot(x, y, 64) != dot_ref(x, y, 64)) return 8;
    if (sum_u8(b, 0) != 0) return 9;
    unsigned short d[40];
    unsigned e[40];
    fill(d, e, 40, 5);
    unsigned v = 5;
    for (int i = 0; i < 40; i++) {
        if (d[i] != (unsigned short)v || e[i] != v)
            return 10;
        v = v * 7 + 1;
    }
    unsigned short z[12];
    for (int i = 0; i < 12; i++)
        z[i] = (unsigned short)(0x8000 + i);
    clear(z + 1, 10);
    for (int i = 1; i < 11; i++)
        if (z[i] != 0) return 12;
    if (z[0] != 0x8000 || z[11] != 0x800b) return 13;
    z[3] = 7;
    if (cut(z + 3) != z + 4 || z[3] != 0 || cut(z + 3) != z + 3) return 14;
    char s[33] = "abcdefghijklmnopqrstuvwxyz012345", r[32];
    reverse(r, s, 32);
    for (int i = 0; i < 32; i++)
        if (r[i] != s[31 - i]) return 11;
    return 0;
}

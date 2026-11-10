// GNU vector arithmetic on 16-byte vectors of every element type, the
// integer lanes wrapping on overflow and the floating ones rounding as the
// scalar operation does, checked against the same arithmetic per element.
// Returns 0 when every check passes; each failure returns a distinct code.

typedef signed char v16c __attribute__((vector_size(16)));
typedef short v8s __attribute__((vector_size(16)));
typedef int v4i __attribute__((vector_size(16)));
typedef unsigned v4u __attribute__((vector_size(16)));
typedef long long v2l __attribute__((vector_size(16)));
typedef float v4f __attribute__((vector_size(16)));
typedef double v2d __attribute__((vector_size(16)));

__attribute__((noinline)) v16c c_ops(v16c a, v16c b) { return (a + b) ^ (a - b) | (a & b); }
__attribute__((noinline)) v8s s_ops(v8s a, v8s b) { return a * b + (a - b); }
__attribute__((noinline)) v4i i_ops(v4i a, v4i b) { return (a + b) * (a - b); }
__attribute__((noinline)) v4u u_ops(v4u a, v4u b) { return (a - b) ^ (a | b); }
__attribute__((noinline)) v2l l_ops(v2l a, v2l b) { return (a + b) - (a & b); }
__attribute__((noinline)) v4f f_ops(v4f a, v4f b) { return (a * b + a) / (b - a); }
__attribute__((noinline)) v2d d_ops(v2d a, v2d b) { return (a - b) * (a + b) / b; }

int main(void) {
    v16c ca, cb;
    v8s sa, sb;
    v4i ia, ib;
    v4u ua, ub;
    v2l la, lb;
    v4f fa, fb;
    v2d da, db;
    for (int i = 0; i < 16; i++) ca[i] = (signed char)(i * 37 - 100), cb[i] = (signed char)(127 - i * 19);
    for (int i = 0; i < 8; i++) sa[i] = (short)(i * 9001 - 30000), sb[i] = (short)(i * 7 + 3);
    for (int i = 0; i < 4; i++) {
        ia[i] = i * 1000003 - 2000000000, ib[i] = 40000 + i;
        ua[i] = 0xF0000000u + (unsigned)i, ub[i] = 0x12345678u * (unsigned)(i + 1);
        fa[i] = 1.5f + (float)i, fb[i] = 0.25f * (float)(i + 2);
    }
    for (int i = 0; i < 2; i++) {
        la[i] = 0x7FFFFFFFFFFFFFF0LL + i, lb[i] = 0x10 + i;
        da[i] = 3.0 + i, db[i] = 0.5 + i;
    }
    v16c c = c_ops(ca, cb);
    for (int i = 0; i < 16; i++) {
        signed char e = (signed char)((signed char)(ca[i] + cb[i]) ^ (signed char)(ca[i] - cb[i])) | (ca[i] & cb[i]);
        if (c[i] != e) return 1;
    }
    v8s s = s_ops(sa, sb);
    for (int i = 0; i < 8; i++)
        if (s[i] != (short)((short)(sa[i] * sb[i]) + (short)(sa[i] - sb[i]))) return 2;
    v4i n = i_ops(ia, ib);
    for (int i = 0; i < 4; i++)
        if (n[i] != (int)((unsigned)(ia[i] + ib[i]) * (unsigned)(ia[i] - ib[i]))) return 3;
    v4u u = u_ops(ua, ub);
    for (int i = 0; i < 4; i++)
        if (u[i] != ((ua[i] - ub[i]) ^ (ua[i] | ub[i]))) return 4;
    v2l l = l_ops(la, lb);
    for (int i = 0; i < 2; i++)
        if (l[i] != (long long)((unsigned long long)la[i] + (unsigned long long)lb[i]) - (la[i] & lb[i])) return 5;
    v4f f = f_ops(fa, fb);
    for (int i = 0; i < 4; i++) {
        float p = fa[i] * fb[i];
        float q = p + fa[i];
        if (f[i] != q / (fb[i] - fa[i])) return 6;
    }
    v2d d = d_ops(da, db);
    for (int i = 0; i < 2; i++) {
        double p = da[i] - db[i];
        double q = da[i] + db[i];
        double r = p * q;
        if (d[i] != r / db[i]) return 7;
    }
    return 0;
}

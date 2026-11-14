// GNU vector arithmetic on 32-byte vectors of every element type, checked
// against the same arithmetic per element: the integer lanes wrap and the
// floating ones round as the scalar operation does. Eighteen accumulators
// live across a loop that calls out outnumber the vector registers, so
// some are spilled and reloaded whole. Returns 0 when every check passes;
// each failure returns a distinct code.

typedef signed char v32c __attribute__((vector_size(32)));
typedef short v16s __attribute__((vector_size(32)));
typedef int v8i __attribute__((vector_size(32)));
typedef unsigned v8u __attribute__((vector_size(32)));
typedef long long v4l __attribute__((vector_size(32)));
typedef float v8f __attribute__((vector_size(32)));
typedef double v4d __attribute__((vector_size(32)));

__attribute__((noinline)) v32c c_ops(v32c a, v32c b) { return (a + b) ^ (a - b) | (a & b); }
__attribute__((noinline)) v16s s_ops(v16s a, v16s b) { return a * b + (a - b); }
__attribute__((noinline)) v8i i_ops(v8i a, v8i b) { return (a + b) ^ (a - b); }
__attribute__((noinline)) v8u u_ops(v8u a, v8u b) { return (a - b) ^ (a | b); }
__attribute__((noinline)) v4l l_ops(v4l a, v4l b) { return (a + b) - (a & b); }
__attribute__((noinline)) v8f f_ops(v8f a, v8f b) { return (a * b + a) / (b - a); }
__attribute__((noinline)) v4d d_ops(v4d a, v4d b) { return (a - b) * (a + b) / b; }

static volatile int calls;
__attribute__((noinline)) void touch(int i) { calls += i; }

int main(void) {
    v32c ca, cb;
    v16s sa, sb;
    v8i ia, ib;
    v8u ua, ub;
    v4l la, lb;
    v8f fa, fb;
    v4d da, db;
    for (int i = 0; i < 32; i++) ca[i] = (signed char)(i * 37 - 100), cb[i] = (signed char)(127 - i * 19);
    for (int i = 0; i < 16; i++) sa[i] = (short)(i * 9001 - 30000), sb[i] = (short)(i * 7 + 3);
    for (int i = 0; i < 8; i++) {
        ia[i] = i * 1000003 - 2000000000, ib[i] = 40000 + i;
        ua[i] = 0xF0000000u + (unsigned)i, ub[i] = 0x12345678u * (unsigned)(i + 1);
        fa[i] = 1.5f + (float)i, fb[i] = 0.25f * (float)(i + 2);
    }
    for (int i = 0; i < 4; i++) {
        la[i] = 0x7FFFFFFFFFFFFFF0LL + i, lb[i] = 0x10 + i;
        da[i] = 3.0 + i, db[i] = 0.5 + i;
    }
    v32c c = c_ops(ca, cb);
    for (int i = 0; i < 32; i++) {
        signed char a = ca[i], b = cb[i];
        if (c[i] != (signed char)(((signed char)(a + b) ^ (signed char)(a - b)) | (a & b))) return 1;
    }
    v16s s = s_ops(sa, sb);
    for (int i = 0; i < 16; i++)
        if (s[i] != (short)((short)(sa[i] * sb[i]) + (short)(sa[i] - sb[i]))) return 2;
    v8i n = i_ops(ia, ib);
    for (int i = 0; i < 8; i++)
        if (n[i] != ((int)((unsigned)ia[i] + (unsigned)ib[i]) ^ (int)((unsigned)ia[i] - (unsigned)ib[i]))) return 3;
    v8u u = u_ops(ua, ub);
    for (int i = 0; i < 8; i++)
        if (u[i] != ((ua[i] - ub[i]) ^ (ua[i] | ub[i]))) return 4;
    v4l l = l_ops(la, lb);
    for (int i = 0; i < 4; i++)
        if (l[i] != (long long)((unsigned long long)la[i] + (unsigned long long)lb[i]) - (la[i] & lb[i])) return 5;
    v8f f = f_ops(fa, fb);
    for (int i = 0; i < 8; i++) {
        float p = fa[i] * fb[i];
        float q = p + fa[i];
        if (f[i] != q / (fb[i] - fa[i])) return 6;
    }
    v4d d = d_ops(da, db);
    for (int i = 0; i < 4; i++) {
        double p = (da[i] - db[i]) * (da[i] + db[i]);
        if (d[i] != p / db[i]) return 7;
    }

    // Eighteen accumulators across a call in every iteration.
    v8i acc[18];
    for (int k = 0; k < 18; k++)
        for (int j = 0; j < 8; j++) acc[k][j] = k * 8 + j;
    v8i a0 = acc[0], a1 = acc[1], a2 = acc[2], a3 = acc[3], a4 = acc[4], a5 = acc[5];
    v8i a6 = acc[6], a7 = acc[7], a8 = acc[8], a9 = acc[9], a10 = acc[10], a11 = acc[11];
    v8i a12 = acc[12], a13 = acc[13], a14 = acc[14], a15 = acc[15], a16 = acc[16], a17 = acc[17];
    for (int i = 0; i < 10; i++) {
        a0 = a0 + ib; a1 = a1 ^ a0; a2 = a2 + a1; a3 = a3 - a2; a4 = a4 + a3; a5 = a5 ^ a4;
        touch(i);
        a6 = a6 + a5; a7 = a7 - a6; a8 = a8 + a7; a9 = a9 ^ a8; a10 = a10 + a9; a11 = a11 - a10;
        a12 = a12 + a11; a13 = a13 ^ a12; a14 = a14 + a13; a15 = a15 - a14; a16 = a16 + a15;
        a17 = a17 ^ a16;
    }
    int ref[18][8];
    for (int k = 0; k < 18; k++)
        for (int j = 0; j < 8; j++) ref[k][j] = k * 8 + j;
    for (int i = 0; i < 10; i++)
        for (int j = 0; j < 8; j++) {
            ref[0][j] = (int)((unsigned)ref[0][j] + (unsigned)ib[j]);
            for (int k = 1; k < 18; k++) {
                unsigned x = (unsigned)ref[k][j], y = (unsigned)ref[k - 1][j];
                switch (k % 4) {
                case 1: x ^= y; break;
                case 3: x -= y; break;
                default: x += y; break;
                }
                ref[k][j] = (int)x;
            }
        }
    v8i got[18] = {a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17};
    for (int k = 0; k < 18; k++)
        for (int j = 0; j < 8; j++)
            if (got[k][j] != ref[k][j]) return 10 + k;
    return calls == 45 ? 0 : 30;
}

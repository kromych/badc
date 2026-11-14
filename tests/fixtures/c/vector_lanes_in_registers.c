// Lane reads and writes of GNU vectors of every element type at 16, 32 and
// 64 bytes, in functions whose vectors are values: a write replaces one
// lane and keeps the others, a read extends as the element type does, and
// a vector built from scalars holds them in order. Each result is checked
// against the same lanes through memory. Returns 0 when every check
// passes; each failure returns a distinct code.

#include <string.h>

typedef signed char v16c __attribute__((vector_size(16)));
typedef unsigned char v16uc __attribute__((vector_size(16)));
typedef short v8s __attribute__((vector_size(16)));
typedef unsigned short v8us __attribute__((vector_size(16)));
typedef int v4i __attribute__((vector_size(16)));
typedef unsigned v4u __attribute__((vector_size(16)));
typedef long long v2l __attribute__((vector_size(16)));
typedef float v4f __attribute__((vector_size(16)));
typedef double v2d __attribute__((vector_size(16)));
typedef int v8i __attribute__((vector_size(32)));
typedef double v4d __attribute__((vector_size(32)));
typedef short v16s __attribute__((vector_size(32)));
typedef int v16i __attribute__((vector_size(64)));
typedef long long v8l __attribute__((vector_size(64)));
typedef float v2f __attribute__((vector_size(8)));

__attribute__((noinline)) v16c put_c(v16c v, signed char x) {
    v[3] = x;
    v[15] = (signed char)(x - 1);
    return v + v;
}
__attribute__((noinline)) long get_c(v16c v) { return (long)(v + v)[5] * 1000 + v[15]; }
__attribute__((noinline)) unsigned long get_uc(v16uc v) { return (v + v)[9]; }
__attribute__((noinline)) v8s put_s(v8s v, short x) {
    v[0] = x;
    v[7] = x;
    return v - v + v;
}
__attribute__((noinline)) long get_s(v8s v) { return (v | v)[6]; }
__attribute__((noinline)) unsigned long get_us(v8us v) { return (v | v)[1]; }
__attribute__((noinline)) v4i put_i(v4i v, int x) {
    v[2] = x;
    return v ^ (v4i){0, 0, 0, 1};
}
__attribute__((noinline)) long get_i(v4i v) { return (v + v)[3]; }
__attribute__((noinline)) unsigned long get_u(v4u v) { return (v + v)[3]; }
__attribute__((noinline)) v2l mk_l(long long a, long long b) {
    v2l r = {a, b};
    return r + r;
}
__attribute__((noinline)) long long get_l(v2l v) { return (v * 3)[1]; }
__attribute__((noinline)) v4f put_f(v4f v, float x) {
    v[1] = x;
    return v * 2.0f;
}
__attribute__((noinline)) float get_f(v4f v) { return (v + 1.0f)[3]; }
__attribute__((noinline)) v2d put_d(v2d v, double x) {
    v[1] = x;
    return v - 0.5;
}
__attribute__((noinline)) double get_d(v2d v) { return (v * v)[0] + (v * v)[1]; }
__attribute__((noinline)) v8i put_i8(v8i v, int x) {
    v[1] = x;
    v[6] = -x;
    return v + v;
}
__attribute__((noinline)) long get_i8(v8i v) { return (long)(v + v)[7] - (v + v)[2]; }
__attribute__((noinline)) v4d put_d4(v4d v, double x) {
    v[3] = x;
    return v * v;
}
__attribute__((noinline)) double get_d4(v4d v) { return (v + v)[2]; }
__attribute__((noinline)) long get_s16(v16s v) { return (v + v)[13]; }
__attribute__((noinline)) v16i put_i16(v16i v, int x) {
    v[13] = x;
    return v + v;
}
__attribute__((noinline)) long get_i16(v16i v) { return (v + v)[14]; }
__attribute__((noinline)) long long get_l8(v8l v) { return (v - 1)[5]; }

/* 8-byte vectors whose lanes are the arguments in their results' registers:
 * a lane that forms in another register reaches the result's. */
struct v2f3 { v2f a, b, c; };
__attribute__((noinline)) struct v2f3 three(float a, float b, float c) {
    struct v2f3 s;
    s.a = (v2f){a, 0};
    s.b = (v2f){0, b};
    s.c = (v2f){c, 0};
    return s;
}

int main(void) {
    v16c c;
    for (int i = 0; i < 16; i++) c[i] = (signed char)(50 - i * 7);
    v16c c2 = put_c(c, -60);
    signed char cm[16];
    memcpy(cm, &c, sizeof cm);
    cm[3] = -60, cm[15] = -61;
    for (int i = 0; i < 16; i++)
        if (c2[i] != (signed char)(cm[i] * 2)) return 1;
    if (get_c(c) != 30 * 1000 - 55) return 2;
    v16uc uc;
    for (int i = 0; i < 16; i++) uc[i] = (unsigned char)(200 + i);
    if (get_uc(uc) != (unsigned char)(209 * 2)) return 3;

    v8s s;
    for (int i = 0; i < 8; i++) s[i] = (short)(i * 7000 - 30000);
    v8s s2 = put_s(s, -12345);
    for (int i = 0; i < 8; i++)
        if (s2[i] != (i == 0 || i == 7 ? -12345 : s[i])) return 4;
    if (get_s(s) != s[6]) return 5;
    v8us us;
    for (int i = 0; i < 8; i++) us[i] = (unsigned short)(65535 - i);
    if (get_us(us) != 65534) return 6;

    v4i n = {-7, 8, -9, -1000000007};
    v4i n2 = put_i(n, 123456789);
    if (n2[0] != -7 || n2[1] != 8 || n2[2] != 123456789 || n2[3] != (-1000000007 ^ 1)) return 7;
    if (get_i(n) != -2000000014) return 8;
    v4u u = {1, 2, 3, 0xC0000001u};
    if (get_u(u) != 0x80000002ul) return 9;

    v2l l = mk_l(-5, 0x123456789ALL);
    if (l[0] != -10 || l[1] != 0x2468ACF134LL) return 10;
    if (get_l(l) != 0x2468ACF134LL * 3) return 11;

    v4f f = {1.5f, 2.5f, -3.5f, 4.25f};
    v4f f2 = put_f(f, 10.0f);
    if (f2[0] != 3.0f || f2[1] != 20.0f || f2[2] != -7.0f || f2[3] != 8.5f) return 12;
    if (get_f(f) != 5.25f) return 13;
    v2d d = {3.0, -4.0};
    v2d d2 = put_d(d, 8.25);
    if (d2[0] != 2.5 || d2[1] != 7.75) return 14;
    if (get_d(d) != 25.0) return 15;

    v8i w;
    for (int i = 0; i < 8; i++) w[i] = i * 1000003 - 4000000;
    v8i w2 = put_i8(w, 77);
    for (int i = 0; i < 8; i++)
        if (w2[i] != 2 * (i == 1 ? 77 : i == 6 ? -77 : w[i])) return 16;
    if (get_i8(w) != (long)(2 * w[7]) - 2 * w[2]) return 17;
    v4d wd = {1.0, 2.0, 3.0, 4.0};
    v4d wd2 = put_d4(wd, -6.0);
    if (wd2[0] != 1.0 || wd2[1] != 4.0 || wd2[2] != 9.0 || wd2[3] != 36.0) return 18;
    if (get_d4(wd) != 6.0) return 19;
    v16s ws;
    for (int i = 0; i < 16; i++) ws[i] = (short)(-1000 * i);
    if (get_s16(ws) != -26000) return 20;

    v16i z;
    for (int i = 0; i < 16; i++) z[i] = i * i - 50;
    v16i z2 = put_i16(z, -31);
    for (int i = 0; i < 16; i++)
        if (z2[i] != 2 * (i == 13 ? -31 : z[i])) return 21;
    if (get_i16(z) != 2 * (14 * 14 - 50)) return 22;
    v8l zl;
    for (int i = 0; i < 8; i++) zl[i] = -0x100000000LL * i;
    if (get_l8(zl) != -0x500000001LL) return 23;
    struct v2f3 t = three(1, 2, 3);
    if (t.a[0] != 1 || t.a[1] != 0 || t.b[0] != 0 || t.b[1] != 2 || t.c[0] != 3 || t.c[1] != 0)
        return 24;
    return 0;
}

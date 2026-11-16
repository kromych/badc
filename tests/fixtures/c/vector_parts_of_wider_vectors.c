// A vector built from the lanes of a wider vector at one shift is that
// vector's part; lanes in another order, or from two shifts, are not, and
// keep their own order. Each result is checked lane by lane. Returns 0 when
// every check passes; each failure returns a distinct code.

typedef long long v4l __attribute__((vector_size(32)));
typedef long long v2l __attribute__((vector_size(16)));
typedef int i4 __attribute__((vector_size(16)));
typedef int i2 __attribute__((vector_size(8)));
typedef unsigned char u16b __attribute__((vector_size(16)));
typedef unsigned char u8b __attribute__((vector_size(8)));

__attribute__((noinline)) v2l lo(v4l a) { return (v2l){a[0], a[1]}; }
__attribute__((noinline)) v2l hi(v4l a) { return (v2l){a[2], a[3]}; }
__attribute__((noinline)) v2l swapped(v4l a) { return (v2l){a[1], a[0]}; }
__attribute__((noinline)) v2l mixed(v4l a) { return (v2l){a[0], a[3]}; }
__attribute__((noinline)) i2 top(i4 a) { return (i2){a[2], a[3]}; }
__attribute__((noinline)) i2 bottom(i4 a) { return (i2){a[0], a[1]}; }
__attribute__((noinline)) u8b upper(u16b a) {
    return (u8b){a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15]};
}

int main(void) {
    volatile long long k = 100;
    v4l a = {k, k + 1, k + 2, k + 3};
    v2l r = lo(a);
    if (r[0] != 100 || r[1] != 101)
        return 1;
    r = hi(a);
    if (r[0] != 102 || r[1] != 103)
        return 2;
    r = swapped(a);
    if (r[0] != 101 || r[1] != 100)
        return 3;
    r = mixed(a);
    if (r[0] != 100 || r[1] != 103)
        return 4;
    i4 b = {(int)k, (int)k * 2, (int)k * 3, (int)k * 4};
    i2 t = top(b);
    if (t[0] != 300 || t[1] != 400)
        return 5;
    t = bottom(b);
    if (t[0] != 100 || t[1] != 200)
        return 6;
    u16b c;
    for (int i = 0; i < 16; i++)
        c[i] = (unsigned char)(k + i);
    u8b u = upper(c);
    for (int i = 0; i < 8; i++)
        if (u[i] != (unsigned char)(k + 8 + i))
            return 7;
    return 0;
}

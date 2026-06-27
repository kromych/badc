/* A by-value struct passed to a callee where the preceding scalar
   arguments have exhausted the integer argument registers spills to the
   caller's stack argument area (AAPCS64 5.4.2 / System V AMD64 3.2.3).
   The callee must read the struct from there into the parameter's body
   local. Covers a 16-byte struct and a 12-byte struct (whose copy needs
   a sub-eightbyte tail). */

struct ll {
    long x;
    long y;
};
struct t3 {
    int a;
    int b;
    int c;
};

static long f16(long a, long b, long c, long d, long e, long g, long h, long i,
                struct ll s) {
    return a + b + c + d + e + g + h + i + s.x * 1000 + s.y;
}
static long f12(long a, long b, long c, long d, long e, long g, long h, long i,
                struct t3 s) {
    return a + b + c + d + e + g + h + i + s.a * 100 + s.b * 10 + s.c;
}

int main(void) {
    struct ll s = {3, 4};
    if (f16(1, 2, 3, 4, 5, 6, 7, 8, s) != 3040) {
        return 1;
    }
    struct t3 t = {2, 3, 4};
    if (f12(1, 2, 3, 4, 5, 6, 7, 8, t) != 270) {
        return 2;
    }
    return 0;
}

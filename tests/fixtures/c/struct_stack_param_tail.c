/* An aggregate parameter passed in memory (System V AMD64 3.2.3: the
   MEMORY class, here over 16 bytes) is copied into the callee's own
   object on entry, the bytes past its last whole eightbyte included:
   4, 2 and 1 of them, and each combination. Every byte is checked. */

struct t20 { float f[5]; };
struct t22 { char c[22]; };
struct t23 { char c[23]; };
struct t17 { char c[17]; };

__attribute__((noinline)) static float sum20(struct t20 s) {
    return s.f[0] + s.f[1] + s.f[2] + s.f[3] + s.f[4];
}

__attribute__((noinline)) static int sum_bytes(const char *p, int n) {
    int s = 0, i;
    for (i = 0; i < n; i++) {
        s = s * 3 + p[i];
    }
    return s;
}

__attribute__((noinline)) static int sum22(struct t22 s) { return sum_bytes(s.c, 22); }
__attribute__((noinline)) static int sum23(struct t23 s) { return sum_bytes(s.c, 23); }
__attribute__((noinline)) static int sum17(struct t17 s) { return sum_bytes(s.c, 17); }

int main(void) {
    struct t20 a = { { 1.0f, 2.0f, 3.0f, 4.0f, 5.0f } };
    struct t22 b;
    struct t23 c;
    struct t17 d;
    int i, bad = 0;
    for (i = 0; i < 23; i++) {
        if (i < 22) b.c[i] = (char)(i + 1);
        c.c[i] = (char)(2 * i + 1);
        if (i < 17) d.c[i] = (char)(40 - i);
    }
    if (sum20(a) != 15.0f) bad++;
    if (sum22(b) != sum_bytes(b.c, 22)) bad++;
    if (sum23(c) != sum_bytes(c.c, 23)) bad++;
    if (sum17(d) != sum_bytes(d.c, 17)) bad++;
    return bad;
}

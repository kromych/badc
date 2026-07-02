/* An indirect call whose argument sources occupy every caller-saved
   target-capture candidate register must not overwrite a live source
   with the function pointer: 17 scalar arguments exercise the
   16-byte-stride push path, 16 by-value structs the host-ABI marshal
   path. */
struct pr {
    long a;
    long b;
};

static struct pr g[16];

static long sum17(long v1, long v2, long v3, long v4, long v5, long v6,
                  long v7, long v8, long v9, long v10, long v11, long v12,
                  long v13, long v14, long v15, long v16, long v17) {
    return v1 + v2 + v3 + v4 + v5 + v6 + v7 + v8 + v9 + v10 + v11 + v12 +
           v13 + v14 + v15 + v16 + v17;
}

static long sum16p(struct pr p0, struct pr p1, struct pr p2, struct pr p3,
                   struct pr p4, struct pr p5, struct pr p6, struct pr p7,
                   struct pr p8, struct pr p9, struct pr p10, struct pr p11,
                   struct pr p12, struct pr p13, struct pr p14,
                   struct pr p15) {
    return p0.a + p0.b + p1.a + p1.b + p2.a + p2.b + p3.a + p3.b + p4.a +
           p4.b + p5.a + p5.b + p6.a + p6.b + p7.a + p7.b + p8.a + p8.b +
           p9.a + p9.b + p10.a + p10.b + p11.a + p11.b + p12.a + p12.b +
           p13.a + p13.b + p14.a + p14.b + p15.a + p15.b;
}

int main(void) {
    long (*fp)(long, long, long, long, long, long, long, long, long, long,
               long, long, long, long, long, long, long) = sum17;
    long (*sfp)(struct pr, struct pr, struct pr, struct pr, struct pr,
                struct pr, struct pr, struct pr, struct pr, struct pr,
                struct pr, struct pr, struct pr, struct pr, struct pr,
                struct pr) = sum16p;
    long i;
    for (i = 0; i < 16; i++) {
        g[i].a = i;
        g[i].b = 2 * i;
    }
    if (fp(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17) !=
        153) {
        return 1;
    }
    if (sfp(g[0], g[1], g[2], g[3], g[4], g[5], g[6], g[7], g[8], g[9],
            g[10], g[11], g[12], g[13], g[14], g[15]) != 360) {
        return 2;
    }
    return 0;
}

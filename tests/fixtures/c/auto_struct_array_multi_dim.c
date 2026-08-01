// Automatic-storage multi-dimensional struct arrays: a deferred outer
// dimension sized from the initializer (C99 6.7.8p22), and a rank-3
// array whose element values are runtime expressions filled through
// the per-element store path (6.7.8p13).

typedef struct { unsigned reg; } R;

static int deferred(void) {
    R a[][2] = { { { 1 }, { 2 } }, { { 3 }, { 4 } } };
    if (sizeof(a) != 4 * sizeof(R)) return 1;
    if (a[0][1].reg != 2 || a[1][0].reg != 3) return 2;
    return 0;
}

struct da { unsigned long out; unsigned long in; };

static int runtime3d(int id, unsigned long src, unsigned long ssi) {
    struct da t[3][2][3] = {
        { { { 0, 0 },
            { src + 0x10u * id, src + 1 },
            { src + 0x20u * id, src + 2 } },
          { { 0, 0 },
            { src + 3, ssi + 0x30u * id },
            { src + 4, ssi + 5 } } },
        { { { ssi + 6, 0 },
            { ssi + 7, 0 },
            { ssi + 8, 0 } },
          { { 0, ssi + 9 },
            { 0, src + 10 },
            { 0, src + 11 } } },
    };
    if (t[0][0][1].out != src + 0x10u * id) return 3;
    if (t[0][1][1].in != ssi + 0x30u * id) return 4;
    if (t[1][0][2].out != ssi + 8 || t[1][1][1].in != src + 10) return 5;
    if (t[2][0][0].out != 0 || t[2][1][2].in != 0) return 6;
    return 0;
}

int main(void) {
    int r = deferred();
    if (r) return r;
    return runtime3d(2, 0x1000, 0x9000);
}

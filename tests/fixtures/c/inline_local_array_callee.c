// A static multi-block callee with an ADDRESS-TAKEN local array (indexed by a
// runtime value, so it stays memory-resident) is inlined at -O. The splice
// must relocate the callee's own local slots into fresh caller frame slots
// without aliasing the caller's locals or another inlined copy's. Verifies the
// inlined copies compute correctly and do not clobber each other.

static inline __attribute__((always_inline)) void accum(int *out, int x, int sel) {
    int tmp[4];
    tmp[0] = x;
    tmp[1] = x + 1;
    tmp[2] = x * 2;
    tmp[3] = x - 1;
    int i = sel & 3;
    int t;
    if (sel & 4) t = tmp[i] + tmp[(i + 1) & 3];
    else if (sel & 8) t = tmp[i] * 2;
    else t = tmp[i] - tmp[(i + 2) & 3];
    out[0] = t;
    out[1] = tmp[i];
}

int f1(int x) { int r[2]; accum(r, x, 0); return r[0] * 100 + r[1]; }
int f2(int x) { int r[2]; accum(r, x, 5); return r[0] * 100 + r[1]; }
int f3(int x) { int r[2]; accum(r, x, 9); return r[0] * 100 + r[1]; }

int main(void) {
    if (f1(10) != -990) return 1;
    if (f2(10) != 3111) return 2;
    if (f3(10) != 2211) return 3;

    /* Two inlined copies in one function must not share slots. */
    int a[2], b[2];
    accum(a, 3, 1);
    accum(b, 8, 6);
    if (a[0] != 2 || a[1] != 4) return 4;
    if (b[0] != 23 || b[1] != 16) return 5;

    unsigned long acc = 0;
    for (int x = -4; x <= 4; x++) {
        int r[2];
        for (int s = 0; s < 12; s++) {
            accum(r, x, s);
            acc = acc * 1000003ul + (unsigned)(r[0] * 7 + r[1]);
        }
    }
    if ((unsigned)(acc & 0xffffffffu) != 871889112u) return 6;
    return 0;
}

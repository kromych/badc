// Two automatic objects whose addresses are compared hold distinct
// storage at the comparison, whatever else either object is used for
// (C99 6.5.9p6). Slot coalescing shares a frame cell only between
// objects whose busy ranges do not overlap, and an address comparison
// is a use of the object at that point: the shapes below pair an
// object of an enclosing block with one of an inner block, an object
// stored once and never read, one never stored, one compared inside a
// loop, and the pointer-inequality-as-operand form the fuzzer found.

int g;
signed char c;

static int both(int *p, int *q)
{
    return p == q;
}

int main(void)
{
    int d = g;
    int *e = &d;
    {
        int f[1];
        int *fp = f;
        c = (fp == e) * 3;
    }
    if (c != 0) return 1;

    int hits = 0;
    for (int i = 0; i < 4; i++) {
        int x;
        int y[2];
        int *px = &x;
        int *py = y;
        if (px == py) hits++;
        if (both(px, py)) hits++;
    }
    if (hits != 0) return 2;

    int acc = 0;
    {
        int l_495 = 4;
        {
            int l[1][3];
            acc ^= &l[0][2] != &l_495;
        }
    }
    if (acc != 1) return 3;

    unsigned char k = 0;
    unsigned char *kp = &k;
    for (int i = 0; i < 2; i++) {
        unsigned char arr[1];
        unsigned char *ap = arr;
        int v = 0;
        for (int j = 0; j < 2; j++) v |= ap != kp;
        if (v != 1) return 4;
    }
    return 0;
}

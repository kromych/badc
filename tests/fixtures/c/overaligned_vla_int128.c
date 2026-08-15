/* A 16-aligned automatic coexists with a VLA (C99 6.7.6.2): the region sits
   at a static frame offset while the VLA moves sp, and the 16-byte-rounded
   carve places a VLA of a 16-aligned element type on its boundary. Returns 0
   when every object is on 16 and the values round-trip. */
static int fails;

static long fixed_beside_vla(int n) {
    int v[n];
    volatile long skew = n;
    __int128 x = skew;
    if ((unsigned long)&x & 15u)
        fails |= 1;
    v[0] = n;
    v[n - 1] = 2 * n;
    x += v[0] + v[n - 1];
    return (long)x;
}

static long int128_vla(int n) {
    __int128 w[n];
    if ((unsigned long)&w[0] & 15u)
        fails |= 2;
    w[0] = n;
    w[n - 1] = 3 * n;
    return (long)(w[0] + w[n - 1]);
}

int main(void) {
    if (fixed_beside_vla(3) != 3 + 3 + 6)
        return 16;
    if (int128_vla(2) != 2 + 6)
        return 32;
    return fails;
}

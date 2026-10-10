/* Loads and stores through a frame object's address at constant
   displacements: the slot-address fold carries each access's
   displacement, so a field of a local struct is one instruction off a
   frame base, where the address form would build the object's address
   first. The address escapes to the calls, which keeps the accesses
   in memory. Returns 0 when the values round-trip. */
struct Pair {
    long a, b, c, d;
};

static long read_sum(const struct Pair *p) {
    return p->a + p->b + p->c + p->d;
}

static __attribute__((noinline)) void write_all(struct Pair *p, long v) {
    p->a = v + 1;
    p->b = v + 2;
    p->c = v + 3;
    p->d = v + 4;
}

int main(void) {
    volatile char pad[4096];
    pad[0] = 1;
    struct Pair p;
    p.a = 1;
    p.b = 2;
    p.c = 3;
    p.d = 4;
    write_all(&p, read_sum(&p));
    long s = read_sum(&p);
    if (pad[0] != 1)
        return 1;
    return (int)(s - 50);
}

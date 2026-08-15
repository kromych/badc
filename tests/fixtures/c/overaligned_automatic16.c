/* Automatic objects whose required alignment is exactly 16 -- __int128, an
   aligned(16) aggregate, and an aggregate whose 16-byte alignment is derived
   from a member -- are placed on 16 without a realigning prologue: the region
   sits at a static frame offset. Probes vary the count of preceding 8-byte
   slots (both frame parities) and run across call depths. Returns 0 when
   every object landed on its boundary and round-tripped its value. */
struct __attribute__((aligned(16))) pair { long long a, b; };
struct wrap { __int128 v; };

static int fails;

static void probe_even(int depth) {
    __int128 x = depth;
    struct pair p;
    struct wrap w;
    p.a = depth + 1;
    p.b = depth + 2;
    w.v = depth + 3;
    if (((unsigned long)&x & 15u) | ((unsigned long)&p & 15u) |
        ((unsigned long)&w & 15u))
        fails |= 1;
    if ((long)x != depth || p.a + p.b != 2 * depth + 3 || (long)w.v != depth + 3)
        fails |= 2;
}

static void probe_odd(int depth) {
    volatile long skew = depth;
    __int128 x = skew;
    struct pair p;
    struct wrap w;
    p.a = skew + 1;
    p.b = skew + 2;
    w.v = skew + 3;
    if (((unsigned long)&x & 15u) | ((unsigned long)&p & 15u) |
        ((unsigned long)&w & 15u))
        fails |= 4;
    if ((long)x != depth || p.a + p.b != 2 * depth + 3 || (long)w.v != depth + 3)
        fails |= 8;
}

static void walk(int depth) {
    volatile long frame_pad[3];
    frame_pad[depth % 3] = depth;
    probe_even(depth);
    probe_odd(depth);
    if (depth > 0)
        walk(depth - 1);
    (void)frame_pad[depth % 3];
}

int main(void) {
    walk(6);
    return fails;
}

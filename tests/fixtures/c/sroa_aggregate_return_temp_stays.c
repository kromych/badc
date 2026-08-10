/* An aggregate returned by value materialises into a caller-side frame
 * temporary that the callee fills through the host ABI: no store in the
 * caller's instruction tape names that slot. Reading the temporary
 * member by member is the shape `passes::sroa` must decline -- lifting
 * the member loads to per-field slots leaves them reading storage
 * nothing ever wrote, and the frame compaction is then free to give two
 * such never-written slots the same address.
 *
 * The chain below is a 64-bit-as-two-32-bit-halves arithmetic set: every
 * helper returns `struct pair` by value and reads its arguments member
 * by member, so each call site produces one of these temporaries. The
 * expected digest was cross-checked against gcc. */

typedef unsigned int u32;
typedef unsigned long long u64;

struct pair {
    u32 h;
    u32 l;
};

static struct pair pack(u32 h, u32 l) {
    struct pair p;
    p.h = h;
    p.l = l;
    return p;
}

static struct pair shl(struct pair i, int n) {
    return pack((i.h << n) | (i.l >> (32 - n)), i.l << n);
}

static void xorinto(struct pair *a, struct pair b) {
    a->h ^= b.h;
    a->l ^= b.l;
}

static struct pair add(struct pair a, struct pair b) {
    struct pair r = pack(a.h + b.h, a.l + b.l);
    if (r.l < a.l)
        r.h++;
    return r;
}

static struct pair times5(struct pair i) { return add(shl(i, 2), i); }
static struct pair times9(struct pair i) { return add(shl(i, 3), i); }

static struct pair rot(struct pair i, int n) {
    return pack((i.h << n) | (i.l >> (32 - n)), (i.h >> (32 - n)) | (i.l << n));
}

static struct pair rot_hi(struct pair i, int n) {
    n = 64 - n;
    return pack((i.h >> n) | (i.l << (32 - n)), (i.h << (32 - n)) | (i.l >> n));
}

/* xoshiro256** over the pair representation. */
static struct pair step(struct pair *s) {
    struct pair res = times9(rot(times5(s[1]), 7));
    struct pair t = shl(s[1], 17);
    xorinto(&s[2], s[0]);
    xorinto(&s[3], s[1]);
    xorinto(&s[1], s[2]);
    xorinto(&s[0], s[3]);
    xorinto(&s[2], t);
    s[3] = rot_hi(s[3], 45);
    return res;
}

static u64 flat(struct pair p) {
    return (((u64)p.h << 31) << 1) | (u64)p.l;
}

static struct pair widen(u64 n) {
    return pack((u32)((n >> 31) >> 1), (u32)n);
}

int main(void) {
    struct pair s[4];
    int i;
    s[0] = widen(1007);
    s[1] = widen(0xff);
    s[2] = widen(0);
    s[3] = widen(0);
    for (i = 0; i < 16; i++)
        step(s);
    if (flat(step(s)) != 0x7a7040a5a323c9d6ull) return 1;
    if (flat(s[0]) != 0x0ba18b516cb227f9ull) return 2;
    if (flat(s[3]) != 0x194f95cf3210cb5aull) return 3;
    return 0;
}

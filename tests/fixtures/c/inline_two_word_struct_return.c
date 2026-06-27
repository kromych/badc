/* A helper returning a struct that fits in two integer registers (System V
   AMD64 3.2.3 / AAPCS64 6.9: a 16-byte aggregate returns in rax:rdx /
   x0:x1) inlines. Two return shapes: a partially-written union (only the
   active member plus the tag are stored; the union's other bytes are
   unspecified, C99 6.2.6.1p6-7) and a fully-written pair. Consumers read
   individual fields and copy the whole struct. The accumulated value must
   match the off-line result. */
typedef union {
    unsigned long u64;
    int i32;
} VUn;
typedef struct {
    VUn u;
    long tag;
} V;

static V mkint(int x) {
    V v;
    v.u.i32 = x;
    v.tag = 1;
    return v;
}
static V mkpair(unsigned long a, unsigned long b) {
    V v;
    v.u.u64 = a;
    v.tag = b;
    return v;
}

int main(void) {
    V slots[8];
    long acc = 0;
    /* whole-struct store consumer (g = f()) into an array element */
    for (int i = 0; i < 8; i++) {
        slots[i] = mkint(i * 10);
    }
    /* field-read consumers */
    for (int i = 0; i < 8; i++) {
        acc += slots[i].u.i32 + slots[i].tag;
    }
    V p = mkpair(0xAAAAUL, 0xBBBBUL);
    acc += (long)p.u.u64 + p.tag;
    /* sum i*10 (0..7) = 280; +8 tags = 8; +0xAAAA +0xBBBB */
    return acc == (280 + 8 + 0xAAAA + 0xBBBB) ? 0 : 1;
}

// Objects read, combined with a constant or a register and written back at
// each width: unsigned additions that wrap the destination's width (C17
// 6.3.1.3p2, 6.5.16.2p3), subtractions, and the bitwise operations, through
// pointers with and without displacements, and a counter decremented and
// then tested.
// Returns 0 when every check passes; each failure returns a distinct code.

struct obj {
    int ref_count;
    short tag;
    unsigned char flags;
    long long bits;
};

__attribute__((noinline)) void hold(struct obj *p) { p->ref_count++; }

__attribute__((noinline)) int drop_ref(struct obj *p) { return --p->ref_count <= 0; }

__attribute__((noinline)) void bump(unsigned char *p) { *p += 300; }

__attribute__((noinline)) void retag(struct obj *p, short d) { p->tag -= d; }

__attribute__((noinline)) void update(struct obj *p, long long m, long long x) {
    p->bits &= m;
    p->bits |= 0x100;
    p->bits ^= x;
    p->flags ^= 0x81;
    p->flags |= 2;
}

__attribute__((noinline)) void add_from(unsigned short *p, int i, unsigned short v) {
    p[i + 2] += v;
}

int main(void) {
    struct obj o = {1, 10, 0x0f, -1};
    hold(&o);
    hold(&o);
    if (o.ref_count != 3) return 1;
    if (drop_ref(&o) || drop_ref(&o)) return 2;
    if (!drop_ref(&o) || o.ref_count != 0) return 3;
    unsigned char c = 250;
    bump(&c);
    if (c != (unsigned char)(250 + 300)) return 4;
    retag(&o, 12);
    if (o.tag != -2) return 5;
    update(&o, 0xff00ff, 0x5);
    if (o.bits != ((0xff00ffLL | 0x100) ^ 0x5)) return 7;
    if (o.flags != ((0x0f ^ 0x81) | 2)) return 8;
    unsigned short s[4] = {0, 0, 65535, 0};
    add_from(s, 0, 2);
    if (s[2] != 1) return 9;
    return 0;
}

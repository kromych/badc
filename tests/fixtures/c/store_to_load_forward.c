// A value stored to a memory location and read back without an
// intervening write or call is already in a register: the reload is
// redundant. The forwarding pass collapses the store/reload pairs for
// struct fields, pointer dereferences, and repeated reads of one
// location. The widths exercise the I64 redirect and the signed
// sub-width Extend path; the unsigned field stays a real load.

struct P {
    long  x;
    int   y;
    short z;
    signed char w;
    unsigned char u;
};

static long use_struct(struct P *p, long a, int b) {
    p->x = a;
    p->y = b;
    p->z = (short)b;
    p->w = (signed char)b;
    p->u = (unsigned char)b;
    long r = p->x;              // forward I64 (redirect)
    int s = p->y;              // forward I32 (signed Extend)
    short t = p->z;            // forward I16 (signed Extend)
    signed char v = p->w;      // forward I8  (signed Extend)
    unsigned char uu = p->u;   // not forwarded (unsigned load)
    return r + s + t + v + uu;
}

static long deref_twice(long *p, long v) {
    *p = v;
    return *p + *p;            // store->load, then load->load
}

static long no_forward_across_call(long *p, long v) {
    long acc = 0;
    *p = v;
    acc += deref_twice(p, v);  // a call may write through p
    return acc + *p;           // must reload after the call
}

int main(void) {
    struct P p;
    long r = use_struct(&p, 1000, 7);
    if (r != 1000 + 7 + 7 + 7 + 7) {
        return 1;
    }
    long q = 0;
    if (deref_twice(&q, 21) != 2 * 21) {  // *p + *p
        return 2;
    }
    long z = 5;
    // 2*9 from deref_twice plus the reloaded *p (= 9).
    if (no_forward_across_call(&z, 9) != 3 * 9) {
        return 3;
    }
    return 0;
}

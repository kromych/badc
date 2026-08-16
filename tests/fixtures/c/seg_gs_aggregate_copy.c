/* An aggregate copy whose source or destination names an x86 address
 * space. C99 6.5.16.1p2 copies the object's bytes, and the bytes of a
 * qualified endpoint sit behind its segment override, so the copy is a
 * chunk cover with the override on that side rather than a flat block
 * move. gcc accepts every spelling below and lowers each the same way,
 * overriding both endpoints independently where both are qualified.
 *
 * The pointer-based spellings run against a scratch area installed as
 * the GS base with arch_prctl (the percpu shape) and are read back
 * through the generic space after the base is restored, so a copy that
 * lost its override would read or write the wrong addresses. The
 * direct-object spellings run while the base is 0, where `%gs:addr`
 * equals `addr`; their override encoding is locked by the asm snapshot.
 */

typedef unsigned long long u64;
typedef unsigned int u32;

#if defined(__x86_64__) && defined(__linux__)

struct pt {
    u64 a;
    u32 b[3];
    u32 pad;
    u64 c;
};

struct outer {
    struct pt inner;
    struct pt second;
    u64 tail;
};

/* Direct-object spellings. */
struct pt __seg_gs gs_src;
struct pt __seg_gs gs_dst;
struct pt flat;

struct pt ret_direct(void) { return gs_src; }
void asg_from_seg(void) { flat = gs_src; }
void asg_to_seg(void) { gs_dst = flat; }
void asg_seg_seg(void) { gs_src = gs_dst; }

/* Pointer-based spellings at percpu-style offsets. External linkage
 * keeps each body in the image with its override visible. */
struct pt ret_ptr(struct pt __seg_gs *p) { return *p; }
void wr_ptr(struct pt __seg_gs *p, struct pt v) { *p = v; }
void cpy_seg_seg(struct pt __seg_gs *d, struct pt __seg_gs *s) { *d = *s; }
struct pt init_ptr(struct pt __seg_gs *p) {
    struct pt local = *p;
    return local;
}
u64 sum_pt(struct pt p) { return p.a + p.b[0] + p.b[2] + p.c; }
u64 pass_ptr(struct pt __seg_gs *p) { return sum_pt(*p); }
struct pt ret_nested(struct outer __seg_gs *p) { return p->second; }

static volatile struct outer area;

/* arch_prctl(ARCH_SET_GS, p) as a raw syscall, as in
 * seg_gs_lvalue_spellings.c. */
static long set_gs(void *p) {
    long r;
    __asm__ volatile("syscall"
                     : "=a"(r)
                     : "a"(158L), "D"(0x1001L), "S"(p)
                     : "rcx", "r11", "memory");
    return r;
}

#define A 0xfeedfacecafebeefULL
#define B0 0x11223344u
#define B2 0x55667788u
#define C 0x0123456789abcdefULL

static int pt_eq(const struct pt *x) {
    return x->a == A && x->b[0] == B0 && x->b[2] == B2 && x->c == C;
}

static int area_eq(const volatile struct pt *x) {
    return x->a == A && x->b[0] == B0 && x->b[2] == B2 && x->c == C;
}

#endif

int main(void) {
#if defined(__x86_64__) && defined(__linux__)
    /* GS base is 0 at startup, so `%gs:addr` is `addr` and the
     * direct-object spellings round-trip through their own storage. */
    flat.a = A;
    flat.b[0] = B0;
    flat.b[2] = B2;
    flat.c = C;
    asg_to_seg();
    if (gs_dst.a != A || gs_dst.b[0] != B0 || gs_dst.b[2] != B2 ||
        gs_dst.c != C)
        return 1;
    asg_seg_seg();
    if (gs_src.a != A || gs_src.b[0] != B0 || gs_src.b[2] != B2 ||
        gs_src.c != C)
        return 2;
    struct pt got = ret_direct();
    if (!pt_eq(&got))
        return 3;
    flat.a = 0;
    flat.b[0] = 0;
    flat.b[2] = 0;
    flat.c = 0;
    asg_from_seg();
    if (!pt_eq((const struct pt *)&flat))
        return 4;

    /* Percpu shape: the qualified endpoints are offsets from the GS
     * base, far from where the generic space would put them. */
    if (set_gs((void *)&area) != 0)
        return 5;
    struct outer __seg_gs *po = (struct outer __seg_gs *)0;
    struct pt __seg_gs *p =
        (struct pt __seg_gs *)__builtin_offsetof(struct outer, inner);
    struct pt __seg_gs *q =
        (struct pt __seg_gs *)__builtin_offsetof(struct outer, second);

    struct pt v;
    v.a = A;
    v.b[0] = B0;
    v.b[1] = 0;
    v.b[2] = B2;
    v.pad = 0;
    v.c = C;
    wr_ptr(p, v);
    cpy_seg_seg(q, p);
    po->tail = 0x7777777777777777ULL;

    struct pt r0 = ret_ptr(p);
    struct pt r1 = init_ptr(q);
    struct pt r2 = ret_nested(po);
    u64 s = pass_ptr(p);
    if (set_gs((void *)0) != 0)
        return 6;

    if (!pt_eq(&r0))
        return 7;
    if (!pt_eq(&r1))
        return 8;
    if (!pt_eq(&r2))
        return 9;
    if (s != A + B0 + B2 + C)
        return 10;
    /* The writes landed in the scratch area, not at the objects'
     * generic-space addresses. */
    if (!area_eq(&area.inner))
        return 11;
    if (!area_eq(&area.second))
        return 12;
    if (area.tail != 0x7777777777777777ULL)
        return 13;
#endif
    return 42;
}

/* Every C-level spelling of an access to a `__seg_gs`-qualified object
 * rides the %gs segment override: direct object read / write /
 * read-modify-write, `.` and `->` members in both directions, constant
 * and variable subscripts, bitfield read-modify-write, and compound
 * assignment. A pointer whose pointee is qualified is itself a
 * generic-space object, so loading or storing the pointer takes no
 * override.
 *
 * The pointer-based spellings run against a scratch area installed as
 * the GS base with arch_prctl (the percpu shape) and are read back
 * through the generic space after the base is restored. The
 * direct-object spellings run while the base is 0, where `%gs:addr`
 * equals `addr`; their override encoding is locked by the asm
 * snapshot. */

typedef unsigned long long u64;
typedef unsigned int u32;

#if defined(__x86_64__) && defined(__linux__)

struct pc {
    u64 a;
    u32 arr[4];
    u32 pad;
    u32 flags : 3;
    u32 rest : 29;
    u64 b;
};

/* Direct-object spellings. */
int __seg_gs g;
struct pc __seg_gs gs_obj;

int rd_direct(void) { return g; }
void wr_direct(int v) { g = v; }
void rmw_direct(int v) { g += v; }
u64 rd_dot(void) { return gs_obj.a; }
void wr_dot(u64 v) { gs_obj.a = v; }

/* Pointer-based spellings at percpu-style offsets. External linkage
 * keeps each body in the image with its override visible. */
u64 rd_arrow(struct pc __seg_gs *p) { return p->a; }
void wr_arrow(struct pc __seg_gs *p, u64 v) { p->b = v; }
u32 rd_index(u32 __seg_gs *p, int i) { return p[i]; }
void wr_index(u32 __seg_gs *p, int i, u32 v) { p[i] = v; }
u32 rd_index_const(u32 __seg_gs *p) { return p[2]; }
void bf_rmw(struct pc __seg_gs *p) { p->flags |= 5; }
void ca_member(struct pc __seg_gs *p, u64 v) { p->b += v; }

/* Control: the pointer object lives in the generic space. */
struct pc __seg_gs *ptr_cell;
struct pc __seg_gs *copy_ptr(struct pc __seg_gs *p) {
    ptr_cell = p;
    return ptr_cell;
}

static volatile struct pc area;

/* arch_prctl(ARCH_SET_GS, p) as a raw syscall, as in
 * inline_seg_percpu_accessor.c. */
static long set_gs(void *p) {
    long r;
    __asm__ volatile("syscall"
                     : "=a"(r)
                     : "a"(158L), "D"(0x1001L), "S"(p)
                     : "rcx", "r11", "memory");
    return r;
}

#endif

int main(void) {
#if defined(__x86_64__) && defined(__linux__)
    /* GS base is 0 at startup, so `%gs:addr` is `addr` and the
     * direct-object spellings round-trip through their own storage. */
    wr_direct(40);
    rmw_direct(2);
    if (rd_direct() != 42)
        return 1;
    wr_dot(0x1122334455667788ULL);
    if (rd_dot() != 0x1122334455667788ULL)
        return 2;

    if (set_gs((void *)&area) != 0)
        return 3;
    struct pc __seg_gs *p = (struct pc __seg_gs *)0;
    u32 __seg_gs *parr = (u32 __seg_gs *)__builtin_offsetof(struct pc, arr);
    wr_arrow(p, 7);
    ca_member(p, 5);
    wr_index(parr, 2, 9);
    bf_rmw(p);
    u32 got_i = rd_index(parr, 2);
    u32 got_c = rd_index_const(parr);
    u64 got_a = rd_arrow(p);
    /* A miscompiled generic-space access inside copy_ptr would fault:
     * with the base at `&area`, `%gs:&ptr_cell` is far out of range. */
    struct pc __seg_gs *echoed = copy_ptr(p);
    if (set_gs((void *)0) != 0)
        return 4;

    if (echoed != p)
        return 5;
    if (got_i != 9 || got_c != 9 || got_a != 0)
        return 6;
    if (area.b != 12)
        return 7;
    if (area.arr[2] != 9)
        return 8;
    if (area.flags != 5 || area.rest != 0)
        return 9;
#endif
    return 42;
}

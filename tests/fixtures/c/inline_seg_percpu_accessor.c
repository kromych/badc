/* An always_inline accessor reading / writing through an x86 `__seg_gs`
 * pointer, the percpu accessor shape. Each accessor computes its
 * effective address from its own parameters, so the splice must carry
 * the accessor's address arithmetic through the value remap; dropping it
 * leaves the access at a different offset from the segment base.
 *
 * GS is pointed at a known area with arch_prctl and every read is
 * checked against the value placed there. `__seg_gs` names an address
 * space distinct from the generic one, so the compiler may assume the
 * two do not alias: the area is only read back through the generic space
 * after the `"memory"`-clobbering syscall that restores the base. */

typedef unsigned long long u64;
typedef unsigned int u32;
typedef unsigned short u16;
typedef unsigned char u8;

#if defined(__x86_64__) && defined(__linux__)

static volatile u64 area[8];

/* Runtime operands: the offsets must not fold into the accessor bodies,
 * so a dropped remap cannot be masked by constant propagation. */
static volatile unsigned long v_zero = 0;
static volatile unsigned long v_eight = 8;

/* arch_prctl(ARCH_SET_GS, p) as a raw syscall: the checks must not
 * depend on the C library while the GS base is redirected. */
static long set_gs(void *p) {
    long r;
    __asm__ volatile("syscall"
                     : "=a"(r)
                     : "a"(158L), "D"(0x1001L), "S"(p)
                     : "rcx", "r11", "memory");
    return r;
}

#define ALWAYS __inline__ __attribute__((always_inline))

static ALWAYS u64 pcpu_read64(unsigned long base, unsigned long off) {
    return *(u64 __seg_gs *)(base + off);
}
static ALWAYS u32 pcpu_read32(unsigned long base, unsigned long off) {
    return *(u32 __seg_gs *)(base + off);
}
static ALWAYS u16 pcpu_read16(unsigned long base, unsigned long off) {
    return *(u16 __seg_gs *)(base + off);
}
static ALWAYS u8 pcpu_read8(unsigned long base, unsigned long off) {
    return *(u8 __seg_gs *)(base + off);
}
static ALWAYS void pcpu_write64(unsigned long base, unsigned long off, u64 v) {
    *(u64 __seg_gs *)(base + off) = v;
}
/* Read-modify-write: both halves ride the override, so the accumulated
 * value must land at the accessed offset and nowhere else. */
static ALWAYS void pcpu_add64(unsigned long base, unsigned long off, u64 v) {
    *(u64 __seg_gs *)(base + off) += v;
}
static ALWAYS void pcpu_inc32(unsigned long base, unsigned long off) {
    (*(u32 __seg_gs *)(base + off))++;
}

/* A two-level accessor: the outer body is what the kernel's percpu
 * helpers look like, and it inlines only once the inner one does. */
static ALWAYS u64 pcpu_read64_off(unsigned long off) {
    return pcpu_read64(v_zero, off);
}

#endif

int main(void) {
#if defined(__x86_64__) && defined(__linux__)
    area[1] = 0x1122334455667788ULL;
    area[3] = 0x99aabbccddeeff00ULL;

    if (set_gs((void *)area) != 0)
        return 1;

    /* Offset 8 is area[1]; a dropped address remap would read offset 0. */
    if (pcpu_read64(v_zero, v_eight) != 0x1122334455667788ULL)
        return 2;
    if (pcpu_read64(v_eight, 16) != 0x99aabbccddeeff00ULL)
        return 3;
    if (pcpu_read64_off(24) != 0x99aabbccddeeff00ULL)
        return 4;

    /* The narrower widths against area[3]'s little-endian bytes. */
    if (pcpu_read32(v_eight, 16) != 0xddeeff00U)
        return 5;
    if (pcpu_read16(24, v_zero + 4) != 0xbbccU)
        return 6;
    if (pcpu_read8(v_eight, 23) != 0x99U)
        return 7;

    pcpu_write64(v_eight, 32, 0x0f1e2d3c4b5a6978ULL);
    pcpu_write64(v_zero, v_eight * 2, 0xfeedfacecafebeefULL);
    pcpu_add64(v_eight, 40, 0x1111111111111111ULL);
    pcpu_add64(v_zero, 56, 3);
    pcpu_inc32(v_eight, 40);

    if (set_gs((void *)0) != 0)
        return 8;

    /* Back in the generic space, across the syscall's memory clobber. */
    if (area[5] != 0x0f1e2d3c4b5a6978ULL)
        return 9;
    if (area[2] != 0xfeedfacecafebeefULL)
        return 10;
    /* area[6]: 0 + 0x1111111111111111, then its low word incremented. */
    if (area[6] != 0x1111111111111112ULL)
        return 11;
    if (area[0] != 0 || area[4] != 0 || area[7] != 3)
        return 12;
#endif
    return 42;
}

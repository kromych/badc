/* The frame's slots are 8 bytes, so every automatic object whose required
   alignment is wider -- starting at 16, not only above it -- is placed in the
   prologue's realigned region (C11 6.7.5 _Alignas / GNU aligned). Covers the
   boundary case (16), the intermediate boundaries, a page-aligned object, and
   an object larger than a page (whose region reservation must still descend in
   probed steps). A call between the writes forces the addressing to survive
   the callee's argument scratch. Returns 0 when every object landed on its
   boundary and round-tripped its value. */

static unsigned long long taken;
static void sink(void *p) { taken = (unsigned long long)(unsigned long)p; }

static int aligned_to(void *p, unsigned long long a) {
    return ((unsigned long long)(unsigned long)p & (a - 1)) == 0;
}

/* The declarator-attribute spelling at the 16-byte boundary. */
static int at16(void) {
    short data[64] __attribute__((aligned(16)));
    sink(data);
    data[0] = 1;
    data[63] = 2;
    return aligned_to(data, 16) && data[0] == 1 && data[63] == 2;
}

/* _Alignas spelling at the same boundary, mixed with ordinary locals. */
static int alignas16(void) {
    int lead = 5;
    _Alignas(16) long long q[4];
    int tail = 6;
    sink(q);
    q[0] = 7;
    q[3] = 8;
    return aligned_to(q, 16) && q[0] == 7 && q[3] == 8 && lead == 5 && tail == 6;
}

/* A type that raises the requirement with no attribute on the declarator. */
struct __attribute__((aligned(32))) pair32 {
    int a;
    int b;
};

static int type32(void) {
    struct pair32 p;
    sink(&p);
    p.a = 9;
    p.b = 10;
    return aligned_to(&p, 32) && p.a == 9 && p.b == 10;
}

/* Several boundaries in one frame: the region packs widest first. */
static int mixed(void) {
    char c16[16] __attribute__((aligned(16)));
    char c64[48] __attribute__((aligned(64)));
    char c32[32] __attribute__((aligned(32)));
    c16[0] = 1;
    c32[0] = 2;
    c64[0] = 3;
    sink(c16);
    return aligned_to(c16, 16) && aligned_to(c32, 32) && aligned_to(c64, 64) &&
           c16[0] == 1 && c32[0] == 2 && c64[0] == 3;
}

/* Page alignment: the widest boundary an automatic object may request. */
static int at_page(void) {
    char page[4096] __attribute__((aligned(4096)));
    sink(page);
    page[0] = 1;
    page[4095] = 2;
    return aligned_to(page, 4096) && page[0] == 1 && page[4095] == 2;
}

/* An over-aligned object larger than a page: the region reservation crosses
   guard pages and must descend in probed steps. */
static int over_a_page(void) {
    char buf[9000] __attribute__((aligned(64)));
    sink(buf);
    buf[0] = 1;
    buf[4096] = 2;
    buf[8999] = 3;
    return aligned_to(buf, 64) && buf[0] == 1 && buf[4096] == 2 && buf[8999] == 3;
}

/* A declaration inside a nested block, not at the top of the function body. */
static int nested(int n) {
    if (n) {
        short data[64] __attribute__((aligned(32)));
        sink(data);
        data[0] = 4;
        return aligned_to(data, 32) && data[0] == 4;
    }
    return 0;
}

int main(void) {
    if (!at16())
        return 1;
    if (!alignas16())
        return 2;
    if (!type32())
        return 3;
    if (!mixed())
        return 4;
    if (!at_page())
        return 5;
    if (!over_a_page())
        return 6;
    if (!nested(1))
        return 7;
    if (taken == 0)
        return 8;
    return 0;
}

// C11 6.7.5 / GCC `aligned`: a static object is placed at the requested
// power-of-two alignment. File-scope and block-scope static objects share
// the `.data` placement path (the object writer aligns the section and the
// object's offset within it), so cache-line (64) and page (4096) requests
// resolve. Automatic frame realignment is a separate matter and stays capped.

static struct {
    int next, locked;
    int padding[14];
} nodes[8] __attribute__((__aligned__(64)));

static char page_buf[8192] __attribute__((aligned(4096)));

static int cacheline_scalar __attribute__((aligned(64))) = 11;

static int block_static_aligned(void) {
    static long slot __attribute__((aligned(128))) = 7;
    if (((unsigned long) &slot % 128) != 0) return 0;
    return (int) slot;
}

int main(void) {
    nodes[0].next = 3;
    if (((unsigned long) &nodes % 64) != 0) return 1;
    if (nodes[0].next != 3) return 2;

    page_buf[0] = 9;
    if (((unsigned long) &page_buf % 4096) != 0) return 3;
    if (page_buf[0] != 9) return 4;

    if (((unsigned long) &cacheline_scalar % 64) != 0) return 5;
    if (cacheline_scalar != 11) return 6;

    if (block_static_aligned() != 7) return 7;
    return 0;
}

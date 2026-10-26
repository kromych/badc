/* A pc-relative word (`.long sym - .`, `.quad sym - .`) in an executable or
 * a writable section holds the distance to a function, a data object or a
 * label, which the image fixes once it places the sections; no load-time
 * relocation is needed. Returns 0. */
int fn(void) { return 3; }
int data_obj = 4;
__asm__(".text\n.p2align 3\n.globl text_tbl\n"
        "text_tbl: .long fn - .\n .long data_obj - .\n .long text_end - .\n .long 0\n"
        " .quad data_obj - .\n"
        "text_end: .long 0\n"
        ".data\n.p2align 3\n.globl data_tbl\n"
        "data_tbl: .long fn - .\n .long data_obj - .\n .long data_end - .\n .long 0\n"
        " .quad fn - .\n"
        "data_end: .long 0\n"
        ".text\n");
extern const int text_tbl[];
extern int data_tbl[];

static long distance(const void *at, long off, const void *to) {
    return (long)((const char *)at + off) - (long)to;
}

static int check(const int *tbl, const void *quad_target) {
    const char *base = (const char *)tbl;
    if (distance(base, tbl[0], (const void *)fn) != 0)
        return 1;
    if (distance(base + 4, tbl[1], &data_obj) != 0)
        return 2;
    if (distance(base + 8, tbl[2], base + 24) != 0)
        return 3;
    if (distance(base + 16, *(const long long *)(base + 16), quad_target) != 0)
        return 4;
    return 0;
}

int main(void) {
    int r = check(text_tbl, &data_obj);
    if (r)
        return r;
    r = check(data_tbl, (const void *)fn);
    if (r)
        return r + 4;
    return fn() + data_obj == 7 ? 0 : 9;
}

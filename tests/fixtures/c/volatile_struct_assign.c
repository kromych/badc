/* C99 6.5.16.1p1 with 6.3.2.1p2: struct assignment requires compatible
 * unqualified types; lvalue conversion drops qualifiers from the right
 * operand, so a volatile- or const-qualified source assigns to a plain
 * destination (and a volatile destination accepts a plain source). */
typedef struct {
    int a, b;
} S;

static S g;
static volatile S gv;

/* Copies past the inline access bound, at byte and word units. */
typedef struct {
    unsigned char b[1024];
} Bytes;
typedef struct {
    long w[256];
} Words;

static volatile Bytes vbytes;
static volatile Words vwords;

static void bytes_through_volatile(const Bytes *in, Bytes *out) {
    vbytes = *in;
    *out = vbytes;
}

static void words_through_volatile(const Words *in, Words *out) {
    vwords = *in;
    *out = vwords;
}

static void from_volatile(volatile S *p) { g = *p; }
static void from_const(const S *p) { g = *p; }
static void to_volatile(const S *p) { gv = *p; }

int main(void) {
    volatile S vs = {3, 4};
    const S cs = {5, 6};

    from_volatile(&vs);
    if (g.a != 3 || g.b != 4)
        return 1;

    from_const(&cs);
    if (g.a != 5 || g.b != 6)
        return 2;

    to_volatile(&cs);
    if (gv.a != 5 || gv.b != 6)
        return 3;

    /* Cast-through-volatile-pointer copy of a plain object. */
    S dst;
    S src = {7, 8};
    dst = *(volatile S *)&src;
    if (dst.a != 7 || dst.b != 8)
        return 4;

    static Bytes bin, bout;
    static Words win, wout;
    for (int i = 0; i < 1024; i++)
        bin.b[i] = (unsigned char)(i * 7 + 1);
    for (int i = 0; i < 256; i++)
        win.w[i] = (long)i * 1000003 - 5;
    bytes_through_volatile(&bin, &bout);
    words_through_volatile(&win, &wout);
    for (int i = 0; i < 1024; i++)
        if (bout.b[i] != (unsigned char)(i * 7 + 1))
            return 5;
    for (int i = 0; i < 256; i++)
        if (wout.w[i] != (long)i * 1000003 - 5)
            return 6;
    return 0;
}

// GCC zero-length arrays `T x[0]` behave like a C99 6.7.2.1 flexible
// array member: zero size, valid as a struct's trailing member with the
// real storage allocated past the fixed part. A static backing buffer
// stands in for the usual heap allocation so the fixture needs no libc.

struct S {
    int len;
    unsigned char data[0];
};

// A union of zero-length arrays: both members sit at the same offset
// and the storage follows the fixed part.
struct W {
    int len;
    union {
        unsigned char b8[0];
        unsigned short b16[0];
    } u;
};

static unsigned char sbuf[sizeof(struct S) + 8];
static unsigned char wbuf[sizeof(struct W) + 8];

int main(void) {
    // The zero-length member contributes no storage: sizeof is the
    // offset of the fixed part rounded to its alignment.
    if (sizeof(struct S) != 4) return 1;

    struct S *s = (struct S *) sbuf;
    s->len = 3;
    s->data[0] = 10;
    s->data[1] = 20;
    s->data[2] = 30;
    if (s->len != 3) return 2;
    if (s->data[0] != 10 || s->data[1] != 20 || s->data[2] != 30) return 3;
    // The flexible member starts immediately after the fixed part.
    if ((unsigned char *) s->data != sbuf + 4) return 4;

    struct W *w = (struct W *) wbuf;
    w->len = 1;
    w->u.b8[0] = 0xAB;
    w->u.b8[1] = 0xCD;
    if (w->u.b8[0] != 0xAB || w->u.b8[1] != 0xCD) return 5;
    // The narrow and wide views alias the same storage.
    if ((w->u.b16[0] & 0xFF) != 0xAB) return 6;
    return 0;
}

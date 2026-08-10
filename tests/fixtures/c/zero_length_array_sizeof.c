/* GCC zero-length array `T[0]` as a complete zero-size type in sizeof
   position. The pointee dimension of `T (*p)[0]` must ride into the
   type so `sizeof(*p)` folds to 0; folding it to the unsized sentinel
   instead reported the element size and flipped size-keyed branch
   selection (the record-vs-byte fifo dispatch below). */

struct fifo {
    unsigned int in;
    unsigned int out;
    unsigned int mask;
    unsigned char *data;
};

/* The byte-fifo descriptor shape: a union whose `rectype` member is a
   pointer to a zero-length array; `sizeof(*rectype)` selects between
   the record layout (per-element length header) and the raw byte
   layout. */
union fifo_view {
    struct fifo kfifo;
    unsigned char *type;
    char (*rectype)[0];
    void *ptr;
};

static int record_mode_taken;

/* Stands in for the out-of-line record-mode helper. Reaching it means
   the size-keyed dispatch chose the wrong layout. */
static unsigned int fifo_out_rec(struct fifo *f, void *buf, unsigned int len,
                                 unsigned long recsize) {
    (void)f;
    (void)buf;
    (void)len;
    (void)recsize;
    record_mode_taken = 1;
    return 0;
}

#define fifo_get(f, val)                                                   \
    ({                                                                     \
        union fifo_view *__tmp = (f);                                      \
        unsigned char *__val = (val);                                      \
        unsigned int __ret;                                                \
        const unsigned long __recsize = sizeof(*__tmp->rectype);           \
        struct fifo *__kfifo = &__tmp->kfifo;                              \
        if (__recsize)                                                     \
            __ret = fifo_out_rec(__kfifo, __val, 1, __recsize);            \
        else {                                                             \
            __ret = !(__kfifo->in == __kfifo->out);                        \
            if (__ret) {                                                   \
                *__val = __kfifo->data[__kfifo->out & __kfifo->mask];      \
                __kfifo->out++;                                            \
            }                                                              \
        }                                                                  \
        __ret;                                                             \
    })

static unsigned char backing[8] = { 'B', 'A', 'D', 'C' };

int main(void) {
    /* sizeof through every declarator route: local, member, cast. */
    char (*lp)[0];
    char (*okp)[8];
    union fifo_view v;
    (void)lp;
    (void)okp;

    if (sizeof(*lp) != 0) return 1;
    if (sizeof(*v.rectype) != 0) return 2;
    if (sizeof(*(char (*)[0])0) != 0) return 3;
    if (sizeof(char[0]) != 0) return 4;
    if (sizeof(char[0][4]) != 0) return 5;
    /* The pointer itself keeps pointer size; positive dims keep theirs. */
    if (sizeof(char (*)[0]) != sizeof(void *)) return 6;
    if (sizeof(*okp) != 8) return 7;

    /* Drain a 4-byte payload one element at a time: the zero recsize
       must keep the byte layout, preserving content and order. */
    v.kfifo.in = 4;
    v.kfifo.out = 0;
    v.kfifo.mask = 7;
    v.kfifo.data = backing;

    unsigned char got[4];
    int n = 0;
    do {
        unsigned char c;
        if (!fifo_get(&v, &c)) break;
        got[n++] = c;
    } while (n < 4);

    if (record_mode_taken) return 8;
    if (n != 4) return 9;
    if (got[0] != 'B' || got[1] != 'A' || got[2] != 'D' || got[3] != 'C')
        return 10;
    if (v.kfifo.out != 4) return 11;
    return 0;
}

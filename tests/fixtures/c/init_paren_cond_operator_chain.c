/* A parenthesized constant conditional in an initializer element may be
   followed by any binary operator or another `?:`; the whole chain folds
   as one constant (the kernel SPI-NAND op tables use
   `(cond ? a : b) | (cond ? a : b) << 8` for 2-byte opcodes). */
typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned long long u64;

enum dir { NO_DATA, DATA_IN, DATA_OUT };

struct op {
    struct { u8 nbytes; u8 buswidth; u8 dtr : 1; u8 pad : 7; u16 opcode; } cmd;
    struct { u8 nbytes; u8 buswidth; u8 dtr : 1; u8 pad : 7; u64 val; } addr;
    struct { u8 nbytes; u8 buswidth; u8 dtr : 1; u8 pad : 7; } dummy;
    struct { u8 buswidth; u8 dtr : 1; u8 pad : 7; enum dir dir;
             unsigned int nbytes;
             union { void *in; const void *out; } buf; } data;
    unsigned int max_freq;
};
struct variants { const struct op *ops; unsigned int nops; };

static const struct variants write_cache_variants = {
    .ops = (struct op[]) {
        { .cmd = { .nbytes = 2,
                   .opcode = (1 ? 0xc2 : 0xc4) | (1 ? 0xc2 : 0xc4) << 8,
                   .buswidth = 8, .dtr = 1, },
          .addr = { .nbytes = 2, .val = 0, .buswidth = 8, .dtr = 1, },
          .dummy = { },
          .data = { .dir = DATA_OUT, .nbytes = 0, .buf.out = ((void *)0),
                    .buswidth = 8, .dtr = 1, }, },
        { .cmd = { .nbytes = 1, .buswidth = 1, .opcode = 0 ? 0xc2 : 0xc4, },
          .addr = { .nbytes = 2, .buswidth = 8, .val = 0, },
          .dummy = { },
          .data = { .buswidth = 8, .dir = DATA_OUT, .nbytes = 0,
                    .buf.out = ((void *)0), }, },
    },
    .nops = sizeof((struct op[]) {
        { .cmd = { .nbytes = 2,
                   .opcode = (1 ? 0xc2 : 0xc4) | (1 ? 0xc2 : 0xc4) << 8, }, },
        { .cmd = { .nbytes = 1, }, },
    }) / sizeof(struct op),
};

/* The other trailing-operator families after a parenthesized `?:`. */
struct t { int a; int b; };
static const struct t chains = {
    .a = (1 ? 2 : 3) | 4,          /* bitor */
    .b = (1 ? 0 : 1) ? 50 : 60,    /* chained conditional */
};
static const int cmp = (1 ? 2 : 3) == 2;   /* comparison */
static const int shl = (0 ? 1 : 3) << 4;   /* shift */
static const int mix = (1 ? 6 : 0) & 3 ^ 1; /* bitand / xor */

int main(void) {
    const struct op *o = write_cache_variants.ops;
    if (write_cache_variants.nops != 2) return 1;
    if (o[0].cmd.opcode != 0xc2c2 || o[0].cmd.nbytes != 2) return 2;
    if (o[0].cmd.buswidth != 8 || o[0].cmd.dtr != 1) return 3;
    if (o[0].data.dir != DATA_OUT || o[0].data.buf.out != (void *)0) return 4;
    if (o[1].cmd.opcode != 0xc4 || o[1].cmd.buswidth != 1) return 5;
    if (o[1].data.buswidth != 8) return 6;
    if (chains.a != 6 || chains.b != 60) return 7;
    if (cmp != 1 || shl != 48 || mix != 3) return 8;
    return 0;
}

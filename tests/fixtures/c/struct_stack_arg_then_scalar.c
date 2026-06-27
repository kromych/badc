/* A by-value 16-byte struct argument that overflows to the caller's
   stack argument area, followed by a trailing scalar stack argument
   (AAPCS64 5.4.2). The caller must copy the struct to the outgoing area
   before the register-argument marshal overwrites the register holding
   its source address; the callee must read the trailing scalar from the
   incoming offset past the struct, not from a plain eightbyte stride.
   The two compound-literal aggregates have an address only after they
   are materialised, exercising the same marshal path. */

struct v {
    long u;
    long tag;
};

static long sink(void *ctx, struct v a, int prop, struct v val, struct v g,
                 struct v s, int flags) {
    return (ctx ? 1 : 0) * 1000000 + a.tag * 10000 + prop * 1000 +
           val.tag * 100 + g.tag * 10 + s.tag + flags;
}

static long dp(void *ctx, struct v a, int prop, struct v val, int flags) {
    return sink(ctx, a, prop, val, (struct v){0, 3}, (struct v){0, 3}, flags);
}

int main(void) {
    int z;
    struct v a = {9, 20};
    struct v val = {0, 40};
    if (dp(&z, a, 7, val, 5) != 1211038) {
        return 1;
    }
    return 0;
}

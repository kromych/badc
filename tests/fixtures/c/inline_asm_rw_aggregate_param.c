/* An inline-asm read-write operand naming a by-value aggregate parameter (or
 * a local copy of one) must write the callee's copy, never the caller's
 * object: C99 6.5.2.2p4 passes the argument by value. The inliner splices a
 * by-value aggregate parameter's slot onto the caller's argument address, so
 * a candidate whose asm writes through such a slot must not be spliced.
 * Native-only on AArch64; on x86_64 the scalar equivalent runs in plain C. */

typedef unsigned char u8x16 __attribute__((vector_size(16)));

#if defined(__aarch64__)
static u8x16 add_param(u8x16 a, u8x16 b) {
    __asm__("add %0.16b, %0.16b, %1.16b" : "+w"(a) : "w"(b));
    return a;
}

static u8x16 add_local(u8x16 a0, u8x16 b) {
    u8x16 a = a0;
    __asm__("add %0.16b, %0.16b, %1.16b" : "+w"(a) : "w"(b));
    return a;
}
#endif

int main(void) {
    union {
        unsigned char b[16];
        u8x16 v;
    } a, b, r;
    int i;
    for (i = 0; i < 16; i++) {
        a.b[i] = (unsigned char)i;
        b.b[i] = 10;
    }
#if defined(__aarch64__)
    /* Each call adds b once, and neither call may modify the caller's `a`. */
    r.v = add_param(a.v, b.v);
    for (i = 0; i < 16; i++)
        if (r.b[i] != (unsigned char)(i + 10) || a.b[i] != (unsigned char)i)
            return 1;
    r.v = add_local(a.v, b.v);
    for (i = 0; i < 16; i++)
        if (r.b[i] != (unsigned char)(i + 10) || a.b[i] != (unsigned char)i)
            return 2;
    /* Nesting must apply the add exactly twice. */
    r.v = add_param(add_local(a.v, b.v), b.v);
    for (i = 0; i < 16; i++)
        if (r.b[i] != (unsigned char)(i + 20) || a.b[i] != (unsigned char)i)
            return 3;
#else
    for (i = 0; i < 16; i++)
        r.b[i] = (unsigned char)(a.b[i] + b.b[i]);
    for (i = 0; i < 16; i++)
        if (r.b[i] != (unsigned char)(i + 10))
            return 1;
#endif
    return 42;
}

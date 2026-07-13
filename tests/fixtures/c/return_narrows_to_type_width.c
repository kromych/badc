/* C99 6.8.6.4 / 6.3.1.1: `return expr` converts to the function's
   return type. A body evaluated in a 64-bit register can leave bits
   above the type width set -- a constant shifted past bit 31 makes the
   `int` result negative, an unsigned source stays zero-extended. A
   same-unit caller reads the result register directly, so the callee
   must narrow to its declared type: zero-extend when unsigned,
   sign-extend when signed. */

typedef unsigned int u32;
typedef unsigned long long u64;

/* (0x24 << 26) sets bit 31, so the `int` OR is negative; returned as
   u32 it must not carry sign bits into a 64-bit read. */
__attribute__((noinline)) static u32 uret(int f) {
    return (0x24 << 26) | (1 << 25) | f;
}

/* Signed `int` returned from an unsigned (zero-extended) source must
   sign-extend so a widening caller sees the sign bits. */
__attribute__((noinline)) static int sret(unsigned x) {
    return x;
}

/* A `short` return narrows the same way. */
__attribute__((noinline)) static unsigned short hret(int x) {
    return x;
}

int main(void) {
    u64 u = uret(7);
    if (u != 0x0000000092000007ULL) return 1;

    long long s = sret(0x80000000u);
    if (s != (long long)0xffffffff80000000ULL) return 2;

    u64 h = hret(0x1ffff);
    if (h != 0xffffULL) return 3;

    return 0;
}

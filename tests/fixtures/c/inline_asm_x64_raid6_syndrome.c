/* x86-64 RAID-6 P/Q syndrome through the AVX2 and AVX-512 inline-asm
   sequences lib/raid6 spells, checked byte for byte against a scalar
   GF(2^8) reference: vmovdqa / vpxor / vpcmpgtb / vpaddb / vpand /
   vmovntdq / prefetchnta over ymm, and vmovdqa64 / vpxorq / vpcmpgtb
   into an opmask / vpmovm2b / vpandq / vmovntdq over zmm. The recovery
   units' nibble-table multiply (vbroadcasti128 / vbroadcasti64x2 /
   vpbroadcastb / vpsraw / vpshufb) is checked against a scalar multiply
   the same way. A wrong encoding shows as a wrong byte. Each vector
   path runs where cpuid reports the extension and the OS enables its
   register state, and is skipped otherwise. Returns 0 on agreement.
   Native x86-64 only. */

#define NDISKS 6
#define BYTES 256

static unsigned char disks[NDISKS][BYTES] __attribute__((aligned(64)));
static unsigned char ref_p[BYTES];
static unsigned char ref_q[BYTES];
static unsigned char x1d[64] __attribute__((aligned(64)));
static unsigned char lo_tab[16] __attribute__((aligned(16)));
static unsigned char hi_tab[16] __attribute__((aligned(16)));
static unsigned char mul_in[BYTES] __attribute__((aligned(64)));
static unsigned char mul_out[BYTES] __attribute__((aligned(64)));
static const unsigned char x0f = 0x0f;

static unsigned char gf_mul2(unsigned char v) {
    return (unsigned char)((v << 1) ^ ((v & 0x80) ? 0x1d : 0));
}

static unsigned char gf_mul(unsigned char a, unsigned char b) {
    unsigned char r = 0;
    while (b) {
        if (b & 1) {
            r ^= a;
        }
        a = gf_mul2(a);
        b >>= 1;
    }
    return r;
}

static void ref_syndrome(unsigned char *p, unsigned char *q) {
    unsigned long d;
    for (d = 0; d < BYTES; d++) {
        unsigned char wp = disks[NDISKS - 3][d];
        unsigned char wq = wp;
        int z;
        for (z = NDISKS - 4; z >= 0; z--) {
            wp ^= disks[z][d];
            wq = gf_mul2(wq) ^ disks[z][d];
        }
        p[d] = wp;
        q[d] = wq;
    }
}

static int differ(const unsigned char *a, const unsigned char *b) {
    unsigned long d;
    for (d = 0; d < BYTES; d++) {
        if (a[d] != b[d]) {
            return 1;
        }
    }
    return 0;
}

static void avx2_syndrome(void) {
    unsigned char *p = disks[NDISKS - 2];
    unsigned char *q = disks[NDISKS - 1];
    unsigned long d;
    int z;

    __asm__ volatile("vmovdqa %0,%%ymm0" : : "m"(x1d[0]));
    __asm__ volatile("vpxor %%ymm3,%%ymm3,%%ymm3");
    for (d = 0; d < BYTES; d += 32) {
        __asm__ volatile("prefetchnta %0" : : "m"(disks[NDISKS - 3][d]));
        __asm__ volatile("vmovdqa %0,%%ymm2" : : "m"(disks[NDISKS - 3][d]));
        __asm__ volatile("vmovdqa %%ymm2,%%ymm4");
        __asm__ volatile("vmovdqa %0,%%ymm6" : : "m"(disks[NDISKS - 4][d]));
        for (z = NDISKS - 5; z >= 0; z--) {
            __asm__ volatile("prefetchnta %0" : : "m"(disks[z][d]));
            __asm__ volatile("vpcmpgtb %%ymm4,%%ymm3,%%ymm5");
            __asm__ volatile("vpaddb %%ymm4,%%ymm4,%%ymm4");
            __asm__ volatile("vpand %%ymm0,%%ymm5,%%ymm5");
            __asm__ volatile("vpxor %%ymm5,%%ymm4,%%ymm4");
            __asm__ volatile("vpxor %%ymm6,%%ymm2,%%ymm2");
            __asm__ volatile("vpxor %%ymm6,%%ymm4,%%ymm4");
            __asm__ volatile("vmovdqa %0,%%ymm6" : : "m"(disks[z][d]));
        }
        __asm__ volatile("vpcmpgtb %%ymm4,%%ymm3,%%ymm5");
        __asm__ volatile("vpaddb %%ymm4,%%ymm4,%%ymm4");
        __asm__ volatile("vpand %%ymm0,%%ymm5,%%ymm5");
        __asm__ volatile("vpxor %%ymm5,%%ymm4,%%ymm4");
        __asm__ volatile("vpxor %%ymm6,%%ymm2,%%ymm2");
        __asm__ volatile("vpxor %%ymm6,%%ymm4,%%ymm4");
        __asm__ volatile("vmovntdq %%ymm2,%0" : "=m"(p[d]));
        __asm__ volatile("vmovntdq %%ymm4,%0" : "=m"(q[d]));
    }
    __asm__ volatile("sfence" : : : "memory");
    __asm__ volatile("vzeroupper");
}

/* mul_out = mul_in * c through the two nibble tables, 32 bytes at a time. */
static void avx2_table_mul(void) {
    unsigned long d;

    __asm__ volatile("vpbroadcastb %0,%%ymm7" : : "m"(x0f));
    __asm__ volatile("vbroadcasti128 %0,%%ymm4" : : "m"(lo_tab[0]));
    __asm__ volatile("vbroadcasti128 %0,%%ymm5" : : "m"(hi_tab[0]));
    for (d = 0; d < BYTES; d += 32) {
        __asm__ volatile("vmovdqa %0,%%ymm1" : : "m"(mul_in[d]));
        __asm__ volatile("vpsraw $4,%%ymm1,%%ymm3");
        __asm__ volatile("vpand %%ymm7,%%ymm1,%%ymm1");
        __asm__ volatile("vpand %%ymm7,%%ymm3,%%ymm3");
        __asm__ volatile("vpshufb %%ymm1,%%ymm4,%%ymm1");
        __asm__ volatile("vpshufb %%ymm3,%%ymm5,%%ymm3");
        __asm__ volatile("vpxor %%ymm1,%%ymm3,%%ymm3");
        __asm__ volatile("vmovdqa %%ymm3,%0" : "=m"(mul_out[d]));
    }
    __asm__ volatile("vzeroupper" : : : "memory");
}

static void avx512_syndrome(void) {
    unsigned char *p = disks[NDISKS - 2];
    unsigned char *q = disks[NDISKS - 1];
    unsigned long d;
    int z;

    __asm__ volatile("vmovdqa64 %0,%%zmm0" : : "m"(x1d[0]));
    __asm__ volatile("vpxorq %%zmm1,%%zmm1,%%zmm1");
    for (d = 0; d < BYTES; d += 64) {
        __asm__ volatile("prefetchnta %0" : : "m"(disks[NDISKS - 3][d]));
        __asm__ volatile("vmovdqa64 %0,%%zmm2" : : "m"(disks[NDISKS - 3][d]));
        __asm__ volatile("vmovdqa64 %%zmm2,%%zmm4");
        __asm__ volatile("vmovdqa64 %0,%%zmm6" : : "m"(disks[NDISKS - 4][d]));
        for (z = NDISKS - 5; z >= 0; z--) {
            __asm__ volatile("prefetchnta %0" : : "m"(disks[z][d]));
            __asm__ volatile("vpcmpgtb %%zmm4,%%zmm1,%%k1");
            __asm__ volatile("vpmovm2b %%k1,%%zmm5");
            __asm__ volatile("vpaddb %%zmm4,%%zmm4,%%zmm4");
            __asm__ volatile("vpandq %%zmm0,%%zmm5,%%zmm5");
            __asm__ volatile("vpxorq %%zmm5,%%zmm4,%%zmm4");
            __asm__ volatile("vpxorq %%zmm6,%%zmm2,%%zmm2");
            __asm__ volatile("vpxorq %%zmm6,%%zmm4,%%zmm4");
            __asm__ volatile("vmovdqa64 %0,%%zmm6" : : "m"(disks[z][d]));
        }
        __asm__ volatile("vpcmpgtb %%zmm4,%%zmm1,%%k1");
        __asm__ volatile("vpmovm2b %%k1,%%zmm5");
        __asm__ volatile("vpaddb %%zmm4,%%zmm4,%%zmm4");
        __asm__ volatile("vpandq %%zmm0,%%zmm5,%%zmm5");
        __asm__ volatile("vpxorq %%zmm5,%%zmm4,%%zmm4");
        __asm__ volatile("vpxorq %%zmm6,%%zmm2,%%zmm2");
        __asm__ volatile("vpxorq %%zmm6,%%zmm4,%%zmm4");
        __asm__ volatile("vmovntdq %%zmm2,%0" : "=m"(p[d]));
        __asm__ volatile("vmovntdq %%zmm4,%0" : "=m"(q[d]));
    }
    __asm__ volatile("sfence" : : : "memory");
    __asm__ volatile("vzeroupper");
}

static void avx512_table_mul(void) {
    unsigned long d;

    __asm__ volatile("vpbroadcastb %0,%%zmm7" : : "m"(x0f));
    __asm__ volatile("vbroadcasti64x2 %0,%%zmm4" : : "m"(lo_tab[0]));
    __asm__ volatile("vbroadcasti64x2 %0,%%zmm5" : : "m"(hi_tab[0]));
    for (d = 0; d < BYTES; d += 64) {
        __asm__ volatile("vmovdqa64 %0,%%zmm1" : : "m"(mul_in[d]));
        __asm__ volatile("vpsraw $4,%%zmm1,%%zmm3");
        __asm__ volatile("vpandq %%zmm7,%%zmm1,%%zmm1");
        __asm__ volatile("vpandq %%zmm7,%%zmm3,%%zmm3");
        __asm__ volatile("vpshufb %%zmm1,%%zmm4,%%zmm1");
        __asm__ volatile("vpshufb %%zmm3,%%zmm5,%%zmm3");
        __asm__ volatile("vpxorq %%zmm1,%%zmm3,%%zmm3");
        __asm__ volatile("vmovdqa64 %%zmm3,%0" : "=m"(mul_out[d]));
    }
    __asm__ volatile("vzeroupper" : : : "memory");
}

static void cpuid(unsigned leaf, unsigned *a, unsigned *b, unsigned *c, unsigned *d) {
    __asm__ volatile("cpuid" : "=a"(*a), "=b"(*b), "=c"(*c), "=d"(*d) : "a"(leaf), "c"(0));
}

/* 0: no usable AVX2; 1: AVX2; 2: AVX2 and AVX-512F/BW, each with the OS
   enabling the register state the extension adds. */
static int vector_level(void) {
    unsigned a, b, c, d, xcr0_lo, xcr0_hi;

    cpuid(0, &a, &b, &c, &d);
    if (a < 7) {
        return 0;
    }
    cpuid(1, &a, &b, &c, &d);
    if (!(c & (1u << 27))) {
        return 0;
    }
    __asm__ volatile("xgetbv" : "=a"(xcr0_lo), "=d"(xcr0_hi) : "c"(0));
    if ((xcr0_lo & 0x06) != 0x06) {
        return 0;
    }
    cpuid(7, &a, &b, &c, &d);
    if (!(b & (1u << 5))) {
        return 0;
    }
    if ((b & (1u << 16)) && (b & (1u << 30)) && (xcr0_lo & 0xe0) == 0xe0) {
        return 2;
    }
    return 1;
}

static int check_table_mul(unsigned char c) {
    unsigned long d;
    for (d = 0; d < BYTES; d++) {
        if (mul_out[d] != gf_mul(mul_in[d], c)) {
            return 1;
        }
    }
    return 0;
}

int main(void) {
    const unsigned char c = 0xc3;
    unsigned x = 12345;
    unsigned long d;
    int z, level;

    for (z = 0; z < NDISKS - 2; z++) {
        for (d = 0; d < BYTES; d++) {
            x = x * 1103515245u + 12345u;
            disks[z][d] = (unsigned char)(x >> 16);
        }
    }
    for (d = 0; d < BYTES; d++) {
        x = x * 1103515245u + 12345u;
        mul_in[d] = (unsigned char)(x >> 16);
    }
    for (d = 0; d < 64; d++) {
        x1d[d] = 0x1d;
    }
    for (d = 0; d < 16; d++) {
        lo_tab[d] = gf_mul(c, (unsigned char)d);
        hi_tab[d] = gf_mul(c, (unsigned char)(d << 4));
    }
    ref_syndrome(ref_p, ref_q);

    level = vector_level();
    if (level < 1) {
        return 0;
    }
    avx2_syndrome();
    if (differ(disks[NDISKS - 2], ref_p)) {
        return 1;
    }
    if (differ(disks[NDISKS - 1], ref_q)) {
        return 2;
    }
    avx2_table_mul();
    if (check_table_mul(c)) {
        return 3;
    }
    if (level < 2) {
        return 0;
    }
    for (d = 0; d < BYTES; d++) {
        disks[NDISKS - 2][d] = disks[NDISKS - 1][d] = mul_out[d] = 0;
    }
    avx512_syndrome();
    if (differ(disks[NDISKS - 2], ref_p)) {
        return 4;
    }
    if (differ(disks[NDISKS - 1], ref_q)) {
        return 5;
    }
    avx512_table_mul();
    if (check_table_mul(c)) {
        return 6;
    }
    return 0;
}

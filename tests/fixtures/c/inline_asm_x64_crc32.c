// SSE4.2 accumulate-CRC32 (`crc32b` / `crc32w` / `crc32l` / `crc32q`).
// The AT&T suffix is the SOURCE width; the accumulator is a general
// register, 64-bit only for `q`. Both a register and a memory source are
// spelled, and the unsuffixed spelling, whose widths come from the
// registers alone.
//
// The expected values are the CRC-32C (Castagnoli, polynomial 0x1EDC6F41)
// residues the instruction defines, cross-checked against a table-free
// bitwise reference computed here, so the test does not depend on the
// instruction to state its own answer.
//
// Guarded by CPUID: a machine without SSE4.2 skips the comparisons and
// still exercises the encoding path at compile time. Returns 42.

#include <stdint.h>

static int have_sse42(void) {
    unsigned int a, b, c, d;
    asm volatile("cpuid" : "=a"(a), "=b"(b), "=c"(c), "=d"(d) : "a"(1), "c"(0));
    return (c >> 20) & 1;
}

/* Bitwise CRC-32C over one value of `bits` width, LSB-first, matching the
   instruction's accumulate semantics. */
static uint32_t ref_crc32c(uint32_t crc, uint64_t v, int bits) {
    for (int i = 0; i < bits; i++) {
        uint32_t bit = (uint32_t)((v >> i) & 1);
        crc = (crc >> 1) ^ (0x82F63B78u * ((crc ^ bit) & 1));
    }
    return crc;
}

static uint32_t crc_b(uint32_t crc, uint8_t v) {
    asm("crc32b %1, %0" : "+r"(crc) : "r"(v));
    return crc;
}

static uint32_t crc_b_mem(uint32_t crc, const uint8_t *p) {
    asm("crc32b %1, %0" : "+r"(crc) : "m"(*p));
    return crc;
}

static uint32_t crc_w(uint32_t crc, uint16_t v) {
    asm("crc32w %1, %0" : "+r"(crc) : "r"(v));
    return crc;
}

static uint32_t crc_l(uint32_t crc, uint32_t v) {
    asm("crc32l %1, %0" : "+r"(crc) : "r"(v));
    return crc;
}

static uint64_t crc_q(uint64_t crc, uint64_t v) {
    asm("crc32q %1, %q0" : "+r"(crc) : "r"(v));
    return crc;
}

static uint64_t crc_q_mem(uint64_t crc, const uint64_t *p) {
    asm("crc32q %1, %q0" : "+r"(crc) : "m"(*p));
    return crc;
}

/* Unsuffixed: the source register's own width is the source width, and the
   accumulator's is what REX.W encodes. */
static uint32_t crc_b_bare(uint32_t crc, uint8_t v) {
    asm("crc32 %1, %0" : "+r"(crc) : "r"(v));
    return crc;
}

static uint32_t crc_w_bare(uint32_t crc, uint16_t v) {
    asm("crc32 %1, %0" : "+r"(crc) : "r"(v));
    return crc;
}

static uint32_t crc_l_bare(uint32_t crc, uint32_t v) {
    asm("crc32 %1, %0" : "+r"(crc) : "r"(v));
    return crc;
}

static uint64_t crc_q_bare(uint64_t crc, uint64_t v) {
    asm("crc32 %1, %q0" : "+r"(crc) : "r"(v));
    return crc;
}

static const uint8_t byte_src = 0xA5;
static const uint64_t quad_src = 0x0123456789ABCDEFull;

int main(void) {
    if (!have_sse42()) return 42;

    if (crc_b(0xFFFFFFFFu, 0xA5) != ref_crc32c(0xFFFFFFFFu, 0xA5, 8)) return 1;
    if (crc_b_mem(0xFFFFFFFFu, &byte_src) != ref_crc32c(0xFFFFFFFFu, 0xA5, 8)) return 2;
    if (crc_w(0xFFFFFFFFu, 0x1234) != ref_crc32c(0xFFFFFFFFu, 0x1234, 16)) return 3;
    if (crc_l(0xFFFFFFFFu, 0xDEADBEEFu) != ref_crc32c(0xFFFFFFFFu, 0xDEADBEEFu, 32)) return 4;

    /* The 64-bit form leaves a 32-bit residue zero-extended. */
    if (crc_q(0xFFFFFFFFull, quad_src) != ref_crc32c(0xFFFFFFFFu, quad_src, 64)) return 5;
    if (crc_q_mem(0xFFFFFFFFull, &quad_src) != ref_crc32c(0xFFFFFFFFu, quad_src, 64)) return 6;

    if (crc_b_bare(0xFFFFFFFFu, 0xA5) != ref_crc32c(0xFFFFFFFFu, 0xA5, 8)) return 8;
    if (crc_w_bare(0xFFFFFFFFu, 0x1234) != ref_crc32c(0xFFFFFFFFu, 0x1234, 16)) return 9;
    if (crc_l_bare(0xFFFFFFFFu, 0xDEADBEEFu) != ref_crc32c(0xFFFFFFFFu, 0xDEADBEEFu, 32))
        return 10;
    if (crc_q_bare(0xFFFFFFFFull, quad_src) != ref_crc32c(0xFFFFFFFFu, quad_src, 64)) return 11;

    /* Accumulation chains: four bytes match one long. */
    {
        uint32_t c = 0xFFFFFFFFu;
        uint32_t v = 0x11223344u;
        c = crc_b(c, (uint8_t)v);
        c = crc_b(c, (uint8_t)(v >> 8));
        c = crc_b(c, (uint8_t)(v >> 16));
        c = crc_b(c, (uint8_t)(v >> 24));
        if (c != crc_l(0xFFFFFFFFu, v)) return 7;
    }

    return 42;
}

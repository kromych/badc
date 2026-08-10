// x86-64 `=@cc<cond>` flag outputs: the asm block's condition flags are an
// output operand, materialized with `set<cond>` after the template. Covers the
// carry flag through a multi-word add loop, the zero flag, the sign and
// overflow flags, and a constraint spelled as two adjacent string literals
// ("=@cc" "c"), which concatenate per C99 5.1.1.2. Returns 42 when every flag
// reads back as expected. Native x86-64 only.

// Add two 128-bit values held as word pairs, propagating the carry out of the
// low word into the high word. The carry is read from the flags rather than
// recomputed.
static void add128(unsigned long alo, unsigned long ahi, unsigned long blo,
                   unsigned long bhi, unsigned long *rlo, unsigned long *rhi) {
    unsigned long lo = alo;
    unsigned char carry;
    __asm__("addq %3, %0" : "=r"(lo), "=@cc" "c"(carry) : "0"(lo), "r"(blo) : "cc");
    *rlo = lo;
    *rhi = ahi + bhi + carry;
}

static unsigned char zero_flag(unsigned long x) {
    unsigned char z;
    __asm__("testq %1, %1" : "=@ccz"(z) : "r"(x) : "cc");
    return z;
}

static unsigned char sign_flag(long x) {
    unsigned char s;
    __asm__("testq %1, %1" : "=@ccs"(s) : "r"(x) : "cc");
    return s;
}

static unsigned char overflow_flag(long x, long y) {
    unsigned char o;
    long t = x;
    __asm__("addq %3, %0" : "=r"(t), "=@cco"(o) : "0"(t), "r"(y) : "cc");
    return o;
}

// The flag output widens to the operand's type: an int destination gets the
// 0/1 value zero-extended, not just its low byte written.
static int not_equal_int(long a, long b) {
    int r = -1;
    __asm__("cmpq %2, %1" : "=@ccne"(r) : "r"(a), "r"(b) : "cc");
    return r;
}

int main(void) {
    unsigned long lo, hi;

    add128(1UL, 0UL, 2UL, 0UL, &lo, &hi);
    if (lo != 3UL || hi != 0UL) {
        return 1;
    }
    // A low-word add that wraps must carry into the high word.
    add128(~0UL, 5UL, 1UL, 7UL, &lo, &hi);
    if (lo != 0UL || hi != 13UL) {
        return 2;
    }

    if (zero_flag(0UL) != 1 || zero_flag(9UL) != 0) {
        return 3;
    }
    if (sign_flag(-1L) != 1 || sign_flag(1L) != 0) {
        return 4;
    }
    // 0x7fffffffffffffff + 1 overflows a signed 64-bit add; 1 + 1 does not.
    if (overflow_flag(0x7fffffffffffffffL, 1L) != 1 || overflow_flag(1L, 1L) != 0) {
        return 5;
    }
    if (not_equal_int(4L, 7L) != 1 || not_equal_int(7L, 7L) != 0) {
        return 6;
    }
    return 42;
}

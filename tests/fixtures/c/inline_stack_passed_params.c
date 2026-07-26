/* C99 6.5.2.2 with System V AMD64 3.2.3 / AAPCS64 6.4.2 / the Microsoft
 * x64 calling convention: a parameter past the ABI's integer argument
 * registers (six on System V, eight on AAPCS64, four on Win64) arrives
 * in the caller's outgoing stack area, so the callee's parameter cell
 * carries no prologue spill. Inlining such a callee must resolve every
 * read of that cell to the call-site argument, taking the read's own
 * width conversion; a cell relocated into a fresh caller slot without
 * an initializing write instead yields whatever the caller's frame held.
 *
 * Eleven parameters put three on the stack under the widest bank and
 * seven under the narrowest. The values are distinct, mixed-width, and
 * include negatives and a high-bit-set unsigned, so a wrong slot or a
 * dropped read is observable. Two of them (`h` and `k`) are passed as
 * 64-bit values whose bits above the parameter's declared width are set:
 * the conversion to the parameter type (C99 6.5.2.2p2) happens in the
 * callee's zero-extending cell read, so an inlined read that forwards
 * the argument without reproducing it observes the wrong value.
 *
 * Two call shapes reach the checker: an always_inline relay (both frames
 * collapse into main, so the checker's stack-passed cells resolve to
 * main's argument values) and an out-of-line relay reached through a
 * volatile function pointer (the relay really receives its own arguments
 * on the host stack, and the checker's cells resolve to the relay's cell
 * reads).
 *
 * Returns 42 on success; on mismatch, the failing check's 1-based index
 * (1..11 for the inlined relay, 21..31 for the out-of-line one). */

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

#define ALWAYS __inline__ __attribute__((always_inline))

/* Neither the caller's literals nor a check may fold away before the
 * comparison runs, so the expected values are read back through
 * volatile objects. */
static volatile int e_a = 1;
static volatile int e_b = -2;
static volatile long long e_c = 0x1122334455667788LL;
static volatile u32 e_d = 0xf0000003u;
static volatile short e_e = -5;
static volatile u8 e_f = 250;
static volatile signed char e_g = -7;
static volatile u16 e_h = 60000;
static volatile int e_i = 9;
static volatile long long e_j = -10;
static volatile u32 e_k = 0x9abcdef0u;

static ALWAYS int check11(int a, int b, long long c, u32 d, short e, u8 f,
                          signed char g, u16 h, int i, long long j, u32 k) {
    if (a != e_a) return 1;
    if (b != e_b) return 2;
    if (c != e_c) return 3;
    if (d != e_d) return 4;
    if (e != e_e) return 5;
    if (f != e_f) return 6;
    if (g != e_g) return 7;
    if (h != e_h) return 8;
    if (i != e_i) return 9;
    if (j != e_j) return 10;
    if (k != e_k) return 11;
    return 0;
}

/* `h` and `k` reach the checker's narrower parameters uncast, so the
 * narrowing is the checker's own cell read. */
static ALWAYS int relay_inlined(int a, int b, long long c, u32 d, short e,
                                u8 f, signed char g, long long h, int i,
                                long long j, long long k) {
    return check11(a, b, c, d, e, f, g, h, i, j, k);
}

static int relay_out_of_line(int a, int b, long long c, u32 d, short e, u8 f,
                             signed char g, long long h, int i, long long j,
                             long long k) {
    int r = check11(a, b, c, d, e, f, g, h, i, j, k);
    return r == 0 ? 0 : r + 20;
}

static int (*volatile via_ptr)(int, int, long long, u32, short, u8, signed char,
                              long long, int, long long, long long) =
    relay_out_of_line;

/* Low 16 bits 0xea60 = 60000; low 32 bits 0x9abcdef0. */
#define WIDE_H 0x11111111ea60LL
#define WIDE_K 0x123456789abcdef0LL

int main(void) {
    int r = relay_inlined(1, -2, 0x1122334455667788LL, 0xf0000003u, -5, 250, -7,
                          WIDE_H, 9, -10, WIDE_K);
    if (r != 0) return r;
    r = via_ptr(1, -2, 0x1122334455667788LL, 0xf0000003u, -5, 250, -7, WIDE_H, 9,
                -10, WIDE_K);
    if (r != 0) return r;
    return 42;
}

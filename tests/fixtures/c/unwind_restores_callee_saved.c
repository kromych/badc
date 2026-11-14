// RtlVirtualUnwind through badc frames recovers the caller's non-volatile
// registers from the unwind data. `outer` loads a known value into each
// callee-saved register (Win64: rbx rsi rdi r12-r15 xmm6-15; ARM64:
// x19-x28 d8-d15) and calls `middle`, which holds values of its own in
// them across its call to `inner`; `inner` captures its context and walks
// out through both frames to `outer`'s. Elsewhere the program exits 0.

#ifdef _WIN32
#include <windows.h>

#ifdef __aarch64__
#define PC(c) ((c)->Pc)
#define NGPR 10
#define NFPR 8
#else
#define PC(c) ((c)->Rip)
#define NGPR 7
#define NFPR 10
#endif

// The values `outer` loads: each GPR's, then each FP register's low and
// high halves.
static const unsigned long long gpr[NGPR] = {
    0x1111111111111111ull, 0x2222222222222222ull, 0x3333333333333333ull,
    0x4444444444444444ull, 0x5555555555555555ull, 0x6666666666666666ull,
    0x7777777777777777ull,
#ifdef __aarch64__
    0x8888888888888888ull, 0x9999999999999999ull, 0xAAAAAAAAAAAAAAAAull,
#endif
};
static const unsigned long long fpr[2 * NFPR] = {
    0x0101010101010101ull, 0x1010101010101010ull, 0x0202020202020202ull,
    0x2020202020202020ull, 0x0303030303030303ull, 0x3030303030303030ull,
    0x0404040404040404ull, 0x4040404040404040ull, 0x0505050505050505ull,
    0x5050505050505050ull, 0x0606060606060606ull, 0x6060606060606060ull,
    0x0707070707070707ull, 0x7070707070707070ull, 0x0808080808080808ull,
    0x8080808080808080ull,
#ifndef __aarch64__
    0x0909090909090909ull, 0x9090909090909090ull, 0x0A0A0A0A0A0A0A0Aull,
    0xA0A0A0A0A0A0A0A0ull,
#endif
};

static volatile int verdict = 1;
static volatile long seed = 3;
static volatile double fseed = 1.25;

void outer(void);

// 0 when the context holds every value `outer` loaded.
static int compare(const CONTEXT *c)
{
#ifdef __aarch64__
    for (int i = 0; i < NGPR; i++)
        if (c->X[19 + i] != gpr[i])
            return 10 + i;
    // AAPCS64 has the callee preserve the low 64 bits of v8-v15.
    for (int i = 0; i < NFPR; i++)
        if (c->V[8 + i].Low != fpr[2 * i])
            return 30 + i;
#else
    const DWORD64 got[NGPR] = {c->Rbx, c->Rsi, c->Rdi, c->R12, c->R13, c->R14, c->R15};
    for (int i = 0; i < NGPR; i++)
        if (got[i] != gpr[i])
            return 10 + i;
    const M128A *x = &c->Xmm6;
    for (int i = 0; i < NFPR; i++)
        if (x[i].Low != fpr[2 * i] || (unsigned long long)x[i].High != fpr[2 * i + 1])
            return 30 + i;
#endif
    return 0;
}

static PRUNTIME_FUNCTION entry_of(DWORD64 pc, DWORD64 *base)
{
    return RtlLookupFunctionEntry(pc, base, 0);
}

__attribute__((noinline)) long inner(void)
{
    CONTEXT ctx;
    DWORD64 base = 0;
    RtlCaptureContext(&ctx);
    PRUNTIME_FUNCTION top = entry_of((DWORD64)outer, &base);
    for (int depth = 0; depth < 4; depth++) {
        DWORD64 pc = PC(&ctx), establisher = 0;
        PVOID data = 0;
        PRUNTIME_FUNCTION f = entry_of(pc, &base);
        if (!f) {
            verdict = 100 + depth;
            return 0;
        }
        RtlVirtualUnwind(0, base, pc, f, &ctx, &data, &establisher, 0);
        if (entry_of(PC(&ctx), &base) == top) {
            verdict = compare(&ctx);
            return 0;
        }
    }
    verdict = 99;
    return 0;
}

// Values live across the call to `inner`, enough to take every
// callee-saved register under -O.
__attribute__((noinline)) long middle(void)
{
    long a = seed, b = a * 3 + 1, c = b * 5 + 2, d = c ^ 0x55, e = d + a * 7;
    long f = e * 11 - b, g = f ^ c, h = g + d, k = h * 13 - e, m = k ^ a;
    double x = fseed, y = x * 1.5, z = y + 2.25, w = z * x, u = w - y;
    double v = u * 0.5, s = v + z, t = s * w, q = t - u, p = q * 0.25;
    long r = inner();
    return r + a + b + c + d + e + f + g + h + k + m
           + (long)(x + y + z + w + u + v + s + t + q + p);
}

__attribute__((noinline)) void outer(void)
{
    const unsigned long long *g = gpr, *x = fpr;
    long (*fn)(void) = middle;
#ifdef __aarch64__
    __asm__ volatile("ldp x19, x20, [%0]\n\t"
                     "ldp x21, x22, [%0, #16]\n\t"
                     "ldp x23, x24, [%0, #32]\n\t"
                     "ldp x25, x26, [%0, #48]\n\t"
                     "ldp x27, x28, [%0, #64]\n\t"
                     "ldr d8, [%1]\n\t"
                     "ldr d9, [%1, #16]\n\t"
                     "ldr d10, [%1, #32]\n\t"
                     "ldr d11, [%1, #48]\n\t"
                     "ldr d12, [%1, #64]\n\t"
                     "ldr d13, [%1, #80]\n\t"
                     "ldr d14, [%1, #96]\n\t"
                     "ldr d15, [%1, #112]\n\t"
                     "blr %2"
                     : "+r"(g), "+r"(x), "+r"(fn)
                     :
                     : "x19", "x20", "x21", "x22", "x23", "x24", "x25", "x26", "x27", "x28",
                       "d8", "d9", "d10", "d11", "d12", "d13", "d14", "d15", "x30", "memory");
#else
    __asm__ volatile("movq (%%rcx), %%rbx\n\t"
                     "movq 8(%%rcx), %%rsi\n\t"
                     "movq 16(%%rcx), %%rdi\n\t"
                     "movq 24(%%rcx), %%r12\n\t"
                     "movq 32(%%rcx), %%r13\n\t"
                     "movq 40(%%rcx), %%r14\n\t"
                     "movq 48(%%rcx), %%r15\n\t"
                     "movups (%%rdx), %%xmm6\n\t"
                     "movups 16(%%rdx), %%xmm7\n\t"
                     "movups 32(%%rdx), %%xmm8\n\t"
                     "movups 48(%%rdx), %%xmm9\n\t"
                     "movups 64(%%rdx), %%xmm10\n\t"
                     "movups 80(%%rdx), %%xmm11\n\t"
                     "movups 96(%%rdx), %%xmm12\n\t"
                     "movups 112(%%rdx), %%xmm13\n\t"
                     "movups 128(%%rdx), %%xmm14\n\t"
                     "movups 144(%%rdx), %%xmm15\n\t"
                     "subq $32, %%rsp\n\t"
                     "call *%%rax\n\t"
                     "addq $32, %%rsp"
                     : "+c"(g), "+d"(x), "+a"(fn)
                     :
                     : "rbx", "rsi", "rdi", "r8", "r9", "r10", "r11", "r12", "r13", "r14",
                       "r15", "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5", "xmm6", "xmm7",
                       "xmm8", "xmm9", "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", "xmm15",
                       "memory", "cc");
#endif
}

int main(void)
{
    outer();
    return verdict;
}
#else
int main(void) { return 0; }
#endif

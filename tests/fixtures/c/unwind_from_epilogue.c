// RtlVirtualUnwind from a pc inside an epilogue recovers the caller's
// non-volatile registers. `outer` loads a known value into each
// callee-saved register (Win64: rbx rsi rdi r12-r15 xmm6-15; ARM64:
// x19-x28 d8-d15) and calls a function that holds values of its own in
// them. A breakpoint written over one instruction of that function's
// epilogue stops it there; the handler puts the instruction back and
// unwinds the context it stopped in to `outer`'s frame, which must hold
// `outer`'s registers, stack pointer and frame pointer. Each instruction
// of each epilogue, from the first that moves sp or reloads the frame
// record to the `ret` (Win64: or a tail call's `jmp`), takes its turn: an
// ARM64 epilogue the `.xdata` epilog scopes describe, a Win64 one in the
// form the unwinder recognizes. Elsewhere the program exits 0.

#ifdef _WIN32
#include <stdarg.h>
#include <windows.h>

#ifdef __aarch64__
#define PC(c) ((c)->Pc)
#define SP(c) ((c)->Sp)
#define FP(c) ((c)->Fp)
#define NGPR 10
#define NFPR 8
#define BREAK_LEN 4
#else
#define PC(c) ((c)->Rip)
#define SP(c) ((c)->Rsp)
#define FP(c) ((c)->Rbp)
#define NGPR 7
#define NFPR 10
#define BREAK_LEN 1
#endif

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

// What `outer` reads and records, at the offsets its assembly uses.
struct call {
    const unsigned long long *gpr, *fpr; // 0, 8
    long (*fn)(long);                    // 16
    unsigned long long sp, fp;           // 24, 32: at the call
    long arg;                            // 40
};

static struct call call = {gpr, fpr, 0, 0, 0, 0};
static PRUNTIME_FUNCTION outer_entry;
static volatile long sink = 3;
static volatile int verdict, hits;
static unsigned char *site;
static unsigned char saved[BREAK_LEN];

// Holds nothing across its call.
__attribute__((noinline)) static void outer(void)
{
    struct call *p = &call;
#ifdef __aarch64__
    __asm__ volatile("ldr x9, [%0]\n\t"
                     "ldp x19, x20, [x9]\n\t"
                     "ldp x21, x22, [x9, #16]\n\t"
                     "ldp x23, x24, [x9, #32]\n\t"
                     "ldp x25, x26, [x9, #48]\n\t"
                     "ldp x27, x28, [x9, #64]\n\t"
                     "ldr x9, [%0, #8]\n\t"
                     "ldr d8, [x9]\n\t"
                     "ldr d9, [x9, #16]\n\t"
                     "ldr d10, [x9, #32]\n\t"
                     "ldr d11, [x9, #48]\n\t"
                     "ldr d12, [x9, #64]\n\t"
                     "ldr d13, [x9, #80]\n\t"
                     "ldr d14, [x9, #96]\n\t"
                     "ldr d15, [x9, #112]\n\t"
                     "mov x9, sp\n\t"
                     "str x9, [%0, #24]\n\t"
                     "str x29, [%0, #32]\n\t"
                     "ldr x16, [%0, #16]\n\t"
                     "ldr x0, [%0, #40]\n\t"
                     "blr x16"
                     : "+r"(p)
                     :
                     : "x0", "x9", "x16", "x17", "x19", "x20", "x21", "x22", "x23", "x24",
                       "x25", "x26", "x27", "x28", "d8", "d9", "d10", "d11", "d12", "d13", "d14",
                       "d15", "x30", "memory");
#else
    __asm__ volatile("movq (%%rcx), %%rax\n\t"
                     "movq (%%rax), %%rbx\n\t"
                     "movq 8(%%rax), %%rsi\n\t"
                     "movq 16(%%rax), %%rdi\n\t"
                     "movq 24(%%rax), %%r12\n\t"
                     "movq 32(%%rax), %%r13\n\t"
                     "movq 40(%%rax), %%r14\n\t"
                     "movq 48(%%rax), %%r15\n\t"
                     "movq 8(%%rcx), %%rax\n\t"
                     "movups (%%rax), %%xmm6\n\t"
                     "movups 16(%%rax), %%xmm7\n\t"
                     "movups 32(%%rax), %%xmm8\n\t"
                     "movups 48(%%rax), %%xmm9\n\t"
                     "movups 64(%%rax), %%xmm10\n\t"
                     "movups 80(%%rax), %%xmm11\n\t"
                     "movups 96(%%rax), %%xmm12\n\t"
                     "movups 112(%%rax), %%xmm13\n\t"
                     "movups 128(%%rax), %%xmm14\n\t"
                     "movups 144(%%rax), %%xmm15\n\t"
                     "subq $32, %%rsp\n\t"
                     "movq %%rsp, 24(%%rcx)\n\t"
                     "movq %%rbp, 32(%%rcx)\n\t"
                     "movq 16(%%rcx), %%rax\n\t"
                     "movq 40(%%rcx), %%rcx\n\t"
                     "call *%%rax\n\t"
                     "addq $32, %%rsp"
                     : "+c"(p)
                     :
                     : "rax", "rbx", "rsi", "rdi", "rdx", "r8", "r9", "r10", "r11", "r12", "r13",
                       "r14", "r15", "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5", "xmm6",
                       "xmm7", "xmm8", "xmm9", "xmm10", "xmm11", "xmm12", "xmm13", "xmm14",
                       "xmm15", "memory", "cc");
#endif
}

// 0 when the context holds what `outer` loaded and recorded.
__attribute__((noinline)) static int compare(const CONTEXT *c)
{
#ifdef __aarch64__
    for (int i = 0; i < NGPR; i++)
        if (c->X[19 + i] != gpr[i])
            return 10 + i;
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
    if (SP(c) != call.sp)
        return 50;
    if (FP(c) != call.fp)
        return 51;
    return 0;
}

__attribute__((noinline)) static void put(unsigned char *at, const unsigned char *bytes)
{
    for (int i = 0; i < BREAK_LEN; i++)
        at[i] = bytes[i];
    FlushInstructionCache(GetCurrentProcess(), at, BREAK_LEN);
}

__attribute__((noinline)) static void plant(unsigned char *at)
{
#ifdef __aarch64__
    static const unsigned char brk[4] = {0x00, 0x00, 0x3E, 0xD4}; // brk #0xF000
#else
    static const unsigned char brk[1] = {0xCC}; // int3
#endif
    for (int i = 0; i < BREAK_LEN; i++)
        saved[i] = at[i];
    site = at;
    put(at, brk);
}

// The breakpoint stops the function at `site`: the instruction goes back
// before the unwind, which on Win64 reads it, and execution resumes there.
__attribute__((noinline)) static LONG WINAPI on_break(EXCEPTION_POINTERS *ep)
{
    CONTEXT u = *ep->ContextRecord;
    if (ep->ExceptionRecord->ExceptionCode != EXCEPTION_BREAKPOINT || !site ||
        PC(&u) != (DWORD64)site)
        return EXCEPTION_CONTINUE_SEARCH;
    put(site, saved);
    site = 0;
    hits++;
    int r = 99;
    for (int depth = 0; depth < 4; depth++) {
        DWORD64 base = 0, establisher = 0;
        PVOID data = 0;
        PRUNTIME_FUNCTION f = RtlLookupFunctionEntry(PC(&u), &base, 0);
        if (!f) {
            r = 98;
            break;
        }
        RtlVirtualUnwind(0, base, PC(&u), f, &u, &data, &establisher, 0);
        if (RtlLookupFunctionEntry(PC(&u), &base, 0) == outer_entry) {
            r = compare(&u);
            break;
        }
    }
    if (r && !verdict)
        verdict = r;
    return EXCEPTION_CONTINUE_EXECUTION;
}

__attribute__((noinline)) static long leaf(long a) { return a * 7 + sink; }

// Values live across the call.
__attribute__((noinline)) static long fold(long a)
{
    long b = a * 3 + 1, c = b ^ 5;
    long r = leaf(a);
    return r + b + c;
}

// A frame past the folded shape's reach.
__attribute__((noinline)) static long top(long a)
{
    volatile char buf[600];
    long b = a * 3 + 1, c = b ^ 5, d = c * 11;
    buf[a & 63] = (char)b;
    long r = leaf(buf[(a + 1) & 63]);
    return r + b + c + d;
}

// A frame past the 12-bit immediate.
__attribute__((noinline)) static long big(long a)
{
    volatile char buf[70000];
    buf[a & 1023] = 1;
    return leaf(buf[(a + 1) & 1023]);
}

__attribute__((noinline)) static long exits(long a)
{
    long b = a * 5 + 2;
    if (a & 1) {
        long r = leaf(b);
        return r + b;
    }
    long r = leaf(a);
    if (a & 2)
        return r - b;
    return r * b;
}

__attribute__((noinline)) static long dynamic(long n)
{
    char buf[(n & 15) + 8];
    long b = n * 9;
    buf[n & 7] = (char)n;
    long r = leaf(buf[n & 7]);
    return r + b;
}

__attribute__((noinline)) static long va(int n, ...)
{
    va_list ap;
    va_start(ap, n);
    long s = 0, b = n * 13;
    for (int i = 0; i < n; i++)
        s += va_arg(ap, long);
    va_end(ap);
    return leaf(s) + s + b;
}

__attribute__((noinline)) static long va_caller(long a) { return va(2, a, a + 1); }

__attribute__((noinline)) static long via_leaf(long a) { return leaf(a) + 1; }

// Every function here, the bounds of each one's code.
static void *const functions[] = {
    (void *)outer, (void *)compare, (void *)put,      (void *)plant,   (void *)on_break,
    (void *)leaf,  (void *)fold,    (void *)top,      (void *)big,     (void *)exits,
    (void *)dynamic, (void *)va,    (void *)va_caller, (void *)via_leaf,
};

struct target {
    void *code;
    long (*run)(long);
    long args[3];
};

static unsigned char *end_of(unsigned char *begin, unsigned char *main_at)
{
    unsigned char *end = main_at > begin ? main_at : 0;
    for (unsigned i = 0; i < sizeof functions / sizeof *functions; i++) {
        unsigned char *f = functions[i];
        if (f > begin && (!end || f < end))
            end = f;
    }
    return end;
}

// The start of each instruction of the epilogues in [begin, end).
static int epilogues(unsigned char *begin, unsigned char *end, unsigned char **sites, int max)
{
    int n = 0;
#ifdef __aarch64__
    const DWORD *w = (const DWORD *)begin;
    int count = (int)((end - begin) / 4);
    for (int i = 0; i < count; i++) {
        int from = i;
        if ((w[i] & 0xFFC07FFF) == 0xA9407BFD || (w[i] & 0xFFC07FFF) == 0xA8C07BFD) {
            // add / sub (immediate) to sp ahead of the frame record's load.
            while (from > 0 && (w[from - 1] & 0xBF80001F) == 0x9100001F)
                from--;
        } else if (w[i] != 0xD50323BF) // autiasp, a signed leaf's
            continue;
        int to = i;
        while (to < count && w[to] != 0xD65F03C0)
            to++;
        if (to == count)
            return -1;
        for (int k = from; k <= to && n < max; k++)
            sites[n++] = (unsigned char *)(w + k);
        i = to;
    }
#else
    for (unsigned char *p = begin; p < end; p++) {
        unsigned char *q = p, *at[16];
        int k = 0;
        if (q + 4 <= end && q[0] == 0x48 && q[1] == 0x8D && q[2] == 0x65)
            at[k++] = q, q += 4; // lea rsp, [rbp + disp8]
        else if (q + 7 <= end && q[0] == 0x48 && q[1] == 0x8D && q[2] == 0xA5)
            at[k++] = q, q += 7; // lea rsp, [rbp + disp32]
        else if (q < end && q[0] == 0xC9)
            at[k++] = q, q += 1; // leave
        for (;;) {
            if (k == 15)
                break;
            if (q < end && (q[0] & 0xF8) == 0x58)
                at[k++] = q, q += 1;
            else if (q + 1 < end && q[0] == 0x41 && (q[1] & 0xF8) == 0x58)
                at[k++] = q, q += 2;
            else
                break;
        }
        // ret, or the jmp rel32 of a tail call.
        int last = q < end && q[0] == 0xC3 ? 1 : q + 5 <= end && q[0] == 0xE9 ? 5 : 0;
        if (k == 0 || !last)
            continue;
        at[k++] = q;
        for (int j = 0; j < k && n < max; j++)
            sites[n++] = at[j];
        p = q + last - 1;
    }
#endif
    return n;
}

int main(void)
{
    static const struct target targets[] = {
        {(void *)leaf, via_leaf, {1, 0, 0}},  {(void *)fold, fold, {1, 0, 0}},
        {(void *)top, top, {1, 0, 0}},        {(void *)big, big, {1, 0, 0}},
        {(void *)exits, exits, {1, 2, 4}},    {(void *)dynamic, dynamic, {5, 0, 0}},
        {(void *)va, va_caller, {1, 0, 0}},
    };
    unsigned char *lo = (unsigned char *)main, *hi = lo;
    for (unsigned i = 0; i < sizeof functions / sizeof *functions; i++) {
        unsigned char *f = functions[i];
        lo = f < lo ? f : lo;
        hi = f > hi ? f : hi;
    }
    DWORD old;
    if (!VirtualProtect(lo, (SIZE_T)(hi - lo) + 4096, PAGE_EXECUTE_READWRITE, &old))
        return 2;
    DWORD64 base = 0;
    outer_entry = RtlLookupFunctionEntry((DWORD64)outer, &base, 0);
    if (!outer_entry)
        return 3;
    PVOID cookie = AddVectoredExceptionHandler(1, on_break);
    for (unsigned t = 0; t < sizeof targets / sizeof *targets; t++) {
        unsigned char *begin = targets[t].code, *end = end_of(begin, (unsigned char *)main);
        unsigned char *sites[64];
        if (!end)
            return 4;
        int n = epilogues(begin, end, sites, 64);
        // A full leaf without return-address signing has no epilogue.
        if (n < 0 || (n == 0 && t != 0))
            return 60 + t;
        for (int s = 0; s < n; s++) {
            int before = hits;
            plant(sites[s]);
            call.fn = targets[t].run;
            for (int a = 0; a < 3 && (a == 0 || targets[t].args[a]); a++) {
                call.arg = targets[t].args[a];
                outer();
            }
            if (site) {
                put(site, saved);
                site = 0;
            }
            if (hits != before + 1)
                return 70 + t;
            if (verdict)
                return verdict;
        }
    }
    RemoveVectoredExceptionHandler(cookie);
    return 0;
}
#else
int main(void) { return 0; }
#endif

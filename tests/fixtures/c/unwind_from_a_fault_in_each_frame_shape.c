// RtlVirtualUnwind from a fault inside each Win64 frame shape recovers the
// caller's non-volatile registers, and an exception raised there reaches a
// handler in main through every frame. `outer` loads a known value into
// each callee-saved register (rbx rsi rdi r12-r15 xmm6-15) and calls one
// shape, which reads a word of a page that faults; the handler unwinds the
// context it faulted in to `outer`'s frame, which must hold `outer`'s
// registers, stack pointer and frame pointer, then opens the page and the
// read resumes. The shapes: no frame, the pushes alone, the pushes and a
// small allocation, xmm saves, an allocation past 128 bytes and one past a
// page, each built with or without a frame pointer as the options say, and
// a frame that keeps its pointer and its calls' windows in an outgoing area.
// Elsewhere the program exits 0.

#if defined(_WIN32) && defined(__x86_64__)
#include <windows.h>

static const unsigned long long gpr[7] = {
    0x1111111111111111ull, 0x2222222222222222ull, 0x3333333333333333ull,
    0x4444444444444444ull, 0x5555555555555555ull, 0x6666666666666666ull,
    0x7777777777777777ull,
};
static const unsigned long long fpr[20] = {
    0x0101010101010101ull, 0x1010101010101010ull, 0x0202020202020202ull,
    0x2020202020202020ull, 0x0303030303030303ull, 0x3030303030303030ull,
    0x0404040404040404ull, 0x4040404040404040ull, 0x0505050505050505ull,
    0x5050505050505050ull, 0x0606060606060606ull, 0x6060606060606060ull,
    0x0707070707070707ull, 0x7070707070707070ull, 0x0808080808080808ull,
    0x8080808080808080ull, 0x0909090909090909ull, 0x9090909090909090ull,
    0x0A0A0A0A0A0A0A0Aull, 0xA0A0A0A0A0A0A0A0ull,
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
static volatile long *volatile poke;
static volatile long *page;
static volatile int verdict, faults, open_on_fault = 1;
static volatile long sink = 3;

__attribute__((noinline)) static void outer(void)
{
    struct call *p = &call;
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
}

// 0 when the context holds what `outer` loaded and recorded.
__attribute__((noinline)) static int compare(const CONTEXT *c)
{
    const DWORD64 got[7] = {c->Rbx, c->Rsi, c->Rdi, c->R12, c->R13, c->R14, c->R15};
    for (int i = 0; i < 7; i++)
        if (got[i] != gpr[i])
            return 10 + i;
    const M128A *x = &c->Xmm6;
    for (int i = 0; i < 10; i++)
        if (x[i].Low != fpr[2 * i] || (unsigned long long)x[i].High != fpr[2 * i + 1])
            return 30 + i;
    if (c->Rsp != call.sp)
        return 50;
    if (c->Rbp != call.fp)
        return 51;
    return 0;
}

// A read of the faulting page stops the shape there: the context unwinds to
// `outer`, then the page opens and the read runs again, or the exception
// goes on to a frame's handler.
__attribute__((noinline)) static LONG WINAPI on_fault(EXCEPTION_POINTERS *ep)
{
    const EXCEPTION_RECORD *er = ep->ExceptionRecord;
    if (er->ExceptionCode != EXCEPTION_ACCESS_VIOLATION || er->NumberParameters < 2 ||
        er->ExceptionInformation[1] != (ULONG_PTR)page)
        return EXCEPTION_CONTINUE_SEARCH;
    faults++;
    if (!open_on_fault)
        return EXCEPTION_CONTINUE_SEARCH;
    CONTEXT u = *ep->ContextRecord;
    int r = 99;
    for (int depth = 0; depth < 4; depth++) {
        DWORD64 base = 0, establisher = 0;
        PVOID data = 0;
        PRUNTIME_FUNCTION f = RtlLookupFunctionEntry(u.Rip, &base, 0);
        // No entry: a frameless leaf, its return address at rsp.
        if (!f) {
            u.Rip = *(DWORD64 *)u.Rsp;
            u.Rsp += 8;
        } else {
            RtlVirtualUnwind(0, base, u.Rip, f, &u, &data, &establisher, 0);
        }
        if (RtlLookupFunctionEntry(u.Rip, &base, 0) == outer_entry) {
            r = compare(&u);
            break;
        }
    }
    if (r && !verdict)
        verdict = r;
    DWORD old;
    VirtualProtect((void *)page, 4096, PAGE_READWRITE, &old);
    return EXCEPTION_CONTINUE_EXECUTION;
}

__attribute__((noinline)) static long callee(long a) { return a * 7 + sink; }

// No frame: rsp stays at the return address.
__attribute__((noinline)) static long bare(long a) { return *poke + a; }

// Values live across a loop and no call: the pushes alone.
__attribute__((noinline)) static long pushes(long a)
{
    long x = a * 3, y = a ^ 5, z = a + 7, w = a * 11, v = a - 13, u = a | 17;
    for (long i = 0; i < (a & 7) + 2; i++) {
        x += y;
        y ^= z;
        z += w;
        w ^= v;
        v += u;
        u ^= x;
        if (i == 1)
            x += *poke;
    }
    return x + y + z + w + v + u + sink;
}

// Values live across a call: the pushes and the shadow area.
__attribute__((noinline)) static long small(long a)
{
    long b = a * 3 + 1, c = b ^ 5;
    long t = *poke;
    long r = callee(a);
    return r + b + c + t;
}

// Floating-point values live across a call: xmm saves.
__attribute__((noinline)) static long xmms(long a)
{
    double x = (double)a * 1.5, y = x + 2.25, z = y * x;
    long t = *poke;
    long r = callee(a);
    return r + t + (long)(x + y + z);
}

// An allocation past what one unwind code's small form states.
__attribute__((noinline)) static long large(long a)
{
    volatile char buf[600];
    long b = a * 3 + 1;
    buf[a & 63] = (char)b;
    long t = *poke;
    long r = callee(buf[(a + 1) & 63]);
    return r + b + t;
}

// An allocation past a page, probed ahead of its `sub`.
__attribute__((noinline)) static long paged(long a)
{
    volatile char buf[4064];
    long b = a * 3 + 1;
    buf[a & 1023] = (char)b;
    long t = *poke;
    long r = callee(buf[(a + 1) & 1023]);
    return r + b + t;
}

// Reads its frame address, so it keeps the frame pointer; `six` takes two
// stack arguments past the home area.
__attribute__((noinline)) static long six(long a, long b, long c, long d, long e, long f)
{
    return a + b * c + d * e + f + sink;
}

__attribute__((noinline)) static long framed(long a)
{
    char *fp = __builtin_frame_address(0);
    long b = a * 3 + 1;
    double x = (double)a * 1.5;
    long t = *poke;
    long r = six(a, b, t, a, b, fp != 0);
    return r + b + t + (long)x;
}

static long (*const shapes[])(long) = {bare, pushes, small, xmms, large, paged, framed};

int main(void)
{
    DWORD64 base = 0;
    outer_entry = RtlLookupFunctionEntry((DWORD64)outer, &base, 0);
    if (!outer_entry)
        return 2;
    page = VirtualAlloc(0, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_NOACCESS);
    if (!page)
        return 3;
    PVOID cookie = AddVectoredExceptionHandler(1, on_fault);
    int n = (int)(sizeof shapes / sizeof *shapes);
    for (int s = 0; s < n; s++) {
        DWORD old;
        VirtualProtect((void *)page, 4096, PAGE_NOACCESS, &old);
        poke = page;
        call.fn = shapes[s];
        call.arg = 1;
        outer();
        if (faults != s + 1)
            return 60 + s;
        if (verdict)
            return verdict;
    }
    // An exception left to a handler unwinds through every shape's frame.
    open_on_fault = 0;
    int caught = 0;
    for (int s = 0; s < n; s++) {
        DWORD old;
        VirtualProtect((void *)page, 4096, PAGE_NOACCESS, &old);
        __try {
            shapes[s](2);
        } __except (GetExceptionCode() == EXCEPTION_ACCESS_VIOLATION) {
            caught++;
        }
    }
    RemoveVectoredExceptionHandler(cookie);
    return caught == n ? 0 : 70 + caught;
}
#else
int main(void) { return 0; }
#endif

// A function moves sp to another stack in inline asm, calls out from
// there and moves sp back. Sixteen values stay live across the call, more
// than the callee-saved registers hold, so some are spilled before the
// move and reloaded after it; a frame whose sp does not keep its prologue
// value reaches them through the frame pointer. The other stack is parked
// below a guard area that reads as zero. Exits 0 when every value
// survives, a distinct code per failure.

static struct {
    _Alignas(16) unsigned char stack[65536];
    long long guard[512];
} alt;
static void *saved_sp;
static volatile long long input = 7;

#if defined(__aarch64__)
#define SWITCH_TO(top)                                                                   \
    __asm__ volatile("mov x9, sp\n\tstr x9, [%0]\n\tmov sp, %1"                          \
                     :                                                                   \
                     : "r"(&saved_sp), "r"(top)                                          \
                     : "x9", "memory")
#define SWITCH_BACK()                                                                    \
    __asm__ volatile("ldr x9, [%0]\n\tmov sp, x9" : : "r"(&saved_sp) : "x9", "memory")
#elif defined(__x86_64__)
#define SWITCH_TO(top)                                                                   \
    __asm__ volatile("mov %%rsp, (%0)\n\tmov %1, %%rsp"                                  \
                     :                                                                   \
                     : "r"(&saved_sp), "r"(top)                                          \
                     : "memory")
#define SWITCH_BACK() __asm__ volatile("mov (%0), %%rsp" : : "r"(&saved_sp) : "memory")
#endif

__attribute__((noinline)) static long long mix(long long x) { return x * 2 + 1; }

#define VALUES(s)                                                                        \
    long long v0 = (s) + 1, v1 = (s) * 3, v2 = (s) ^ 0x55, v3 = (s) * (s);               \
    long long v4 = (s) - 9, v5 = (s) << 4, v6 = (s) * 7 + 2, v7 = (s) ^ 0x1234;          \
    long long v8 = (s) * 11, v9 = (s) + 100, v10 = (s) * 13 - 5, v11 = (s) << 9;         \
    long long v12 = (s) ^ 0x7777, v13 = (s) * 17, v14 = (s) + 12345, v15 = (s) * 19 + 3

#define COMBINE(m)                                                                       \
    (v0 + 2 * v1 + 3 * v2 + 4 * v3 + 5 * v4 + 6 * v5 + 7 * v6 + 8 * v7 + 9 * v8 +          \
     10 * v9 + 11 * v10 + 12 * v11 + 13 * v12 + 14 * v13 + 15 * v14 + 16 * v15 + (m))

__attribute__((noinline)) static long long on_other_stack(long long s) {
    VALUES(s);
    SWITCH_TO(alt.stack + sizeof alt.stack - 256);
    long long m = mix(s);
    long long r = COMBINE(m);
    SWITCH_BACK();
    return r;
}

__attribute__((noinline)) static long long on_own_stack(long long s) {
    VALUES(s);
    long long m = mix(s);
    return COMBINE(m);
}

int main(void) {
    long long s = input;
    long long want = on_own_stack(s);
    long long got = on_other_stack(s);
    if (got != want)
        return 1;
    if (on_other_stack(s + 1) != on_own_stack(s + 1))
        return 2;
    return 0;
}

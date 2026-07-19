/* AArch64 inline asm: a register-offset load `ldr Xt, [Xn, Xm, lsl #3]` -- the
 * addressing mode an indexed array access lowers to. The index is scaled by the
 * access size through the shift. Native-only on AArch64 (the interpreter's
 * inline-asm evaluator is x86-only); on x86_64 the same access runs in plain C. */

long long g_arr[4] = {10, 20, 30, 40};

int main(void) {
    long long idx = 2, v;
#if defined(__aarch64__)
    __asm__ volatile("ldr %0, [%1, %2, lsl #3]" : "=r"(v) : "r"(g_arr), "r"(idx));
#else
    v = g_arr[idx];
#endif
    return (int)v; /* 30 */
}

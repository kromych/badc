/* AArch64 inline asm: a subword register-offset load `ldrb Wt, [Xn, Xm]` -- an
 * indexed byte access, the register-offset form at the byte access size (no
 * scaling). Native-only on AArch64 (the interpreter's inline-asm evaluator is
 * x86-only); on x86_64 the same access runs in plain C. */

unsigned char g_bytes[8] = {0, 0, 0, 42, 0, 0, 0, 0};

int main(void) {
    long long idx = 3;
    int v;
#if defined(__aarch64__)
    __asm__ volatile("ldrb %w0, [%1, %2]" : "=r"(v) : "r"(g_bytes), "r"(idx));
#else
    v = g_bytes[idx];
#endif
    return v; /* g_bytes[3] = 42 */
}

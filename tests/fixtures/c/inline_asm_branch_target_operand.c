/* A `call` / `bl` target assembled from template text plus a `%c`
 * operand: the reference substitutes the constant as bare text, so
 * `helper_%c[n]` with n == 4 branches to `helper_4`. The target name is
 * resolved after substitution, which is what lets one template select
 * among a family of size-suffixed helpers. */

int helper_1(void) { return 1; }
int helper_2(void) { return 2; }
int helper_4(void) { return 4; }
int helper_8(void) { return 8; }

#if defined(__x86_64__)
#define CALL_SIZED(r, n)                                                       \
    __asm__ __volatile__("call helper_%c[sz]"                                  \
                         : "=a"(r)                                             \
                         : [sz] "i"(n)                                         \
                         : "memory", "cc", "rdi", "rsi", "rdx", "rcx", "r8",   \
                           "r9", "r10", "r11")
#elif defined(__aarch64__)
#define CALL_SIZED(r, n)                                                       \
    __asm__ __volatile__("bl helper_%c[sz]"                                    \
                         : "=r"(r)                                             \
                         : [sz] "i"(n)                                         \
                         : "memory", "cc", "x1", "x2", "x3", "x4", "x5", "x6", \
                           "x7", "x8", "x9", "x10", "x11", "x12", "x13",       \
                           "x14", "x15", "x16", "x17", "x18", "x30")
#endif

/* sizeof yields the constant, matching how a size-selected helper is
 * normally chosen. */
static int by_size(void) {
    int total = 0;
#if defined(__x86_64__)
    register int r __asm__("eax");
#elif defined(__aarch64__)
    register int r __asm__("w0");
#else
    int r;
#endif
#if defined(__x86_64__) || defined(__aarch64__)
    CALL_SIZED(r, sizeof(char));
    total += r;
    CALL_SIZED(r, sizeof(short));
    total += r;
    CALL_SIZED(r, sizeof(int));
    total += r;
    CALL_SIZED(r, sizeof(long long));
    total += r;
#else
    (void)r;
    total = helper_1() + helper_2() + helper_4() + helper_8();
#endif
    return total;
}

int main(void) {
    if (helper_1() + helper_2() + helper_4() + helper_8() != 15)
        return 1;
    if (by_size() != 15)
        return 2;
    return 42;
}

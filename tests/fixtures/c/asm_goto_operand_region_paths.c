/* `asm goto` with register operands keeps its operand region in the
 * enclosing frame, so sp is balanced on every path out of the template:
 * the fall-through, a template `%l` branch (through the restore
 * trampoline), and a branch that reaches the label without any
 * compiler-planted exit path -- the shape a runtime patcher plants at a
 * jump-label site, simulated here by an indirect branch to the label's
 * own address. */

/* Live value across the asm: `keep` must survive the operand loads,
 * the template, and both exits. */
static int taken_or_fall(int v) {
    int keep = v * 3 + 1;
#if defined(__x86_64__)
    __asm__ goto("testl %0, %0; jnz %l[taken]" : : "r"(v) : : taken);
#elif defined(__aarch64__)
    __asm__ goto("cbnz %w0, %l[taken]" : : "r"(v) : : taken);
#else
    if (v) goto taken;
#endif
    return keep;
taken:
    return keep + 1;
}

/* The patched-branch shape: control leaves mid-template straight to the
 * label's address held in a register. */
static int patched(int x) {
    void *t = &&l_yes;
#if defined(__x86_64__)
    __asm__ goto("jmp *%1" : : "r"(x), "r"(t) : : l_yes);
#elif defined(__aarch64__)
    __asm__ goto("br %1" : : "r"(x), "r"(t) : : l_yes);
#else
    if (t) goto l_yes;
#endif
    return 0;
l_yes:
    return 1;
}

/* The listed label is the fall-through block: the framed exit sequence
 * is shared by both edges. */
static int same_target(int v) {
#if defined(__x86_64__)
    __asm__ goto("testl %0, %0; jnz %l[next]" : : "r"(v) : : next);
#elif defined(__aarch64__)
    __asm__ goto("cbnz %w0, %l[next]" : : "r"(v) : : next);
#endif
next:
    return 5;
}

/* Dynamic-sp frame (C99 6.7.6.2 VLA): the region is addressed off the
 * frame while sp floats. */
static int vla_goto(int n) {
    char buf[n];
    buf[0] = (char)n;
    buf[n - 1] = 7;
#if defined(__x86_64__)
    __asm__ goto("testl %0, %0; jnz %l[out]" : : "r"((int)buf[n - 1]) : : out);
#elif defined(__aarch64__)
    __asm__ goto("cbnz %w0, %l[out]" : : "r"((int)buf[n - 1]) : : out);
#else
    if (buf[n - 1]) goto out;
#endif
    return buf[0];
out:
    return buf[0] + buf[n - 1];
}

/* A 16-aligned automatic shares the frame with the asm operand region. */
struct __attribute__((aligned(16))) pair16 {
    long a, b;
};

static int align16_goto(int v) {
    struct pair16 s = {v, 2};
    if (((unsigned long)&s & 15ul) != 0)
        return -100;
#if defined(__x86_64__)
    __asm__ goto("testl %0, %0; jnz %l[t]" : : "r"((int)s.a) : : t);
#elif defined(__aarch64__)
    __asm__ goto("cbnz %w0, %l[t]" : : "r"((int)s.a) : : t);
#else
    if (s.a) goto t;
#endif
    return (int)(s.a + s.b);
t:
    return (int)(s.a - s.b);
}

/* Two statements share the function's one region (sized to the larger). */
static int two_statements(int v) {
    int a = 0;
#if defined(__x86_64__)
    __asm__("movl %1, %0" : "=r"(a) : "r"(v));
    __asm__ goto("testl %0, %0; jnz %l[hit]" : : "r"(a) : : hit);
#elif defined(__aarch64__)
    __asm__("mov %w0, %w1" : "=r"(a) : "r"(v));
    __asm__ goto("cbnz %w0, %l[hit]" : : "r"(a) : : hit);
#else
    a = v;
    if (a) goto hit;
#endif
    return a;
hit:
    return a + 2;
}

int main(void) {
    if (taken_or_fall(2) != 8)
        return 1;
    if (taken_or_fall(0) != 1)
        return 2;
    if (patched(3) != 1)
        return 3;
    if (same_target(0) != 5 || same_target(1) != 5)
        return 4;
    if (vla_goto(9) != 16)
        return 5;
    if (align16_goto(4) != 2 || align16_goto(0) != 2)
        return 6;
    if (two_statements(6) != 8 || two_statements(0) != 0)
        return 7;
    return 42;
}

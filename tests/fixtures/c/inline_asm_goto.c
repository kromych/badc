/* GCC `asm goto`: the template may branch to any listed C label or
 * fall through. Covers the taken branch, the fall-through, two labels
 * with both `%l[name]` and operand-relative `%lN` references, a
 * backward label (loop latch), and a label that is also the
 * fall-through block. */

int take_or_fall(int v) {
#if defined(__x86_64__)
    __asm__ goto("testl %0, %0; jnz %l[taken]" : : "r"(v) : : taken);
#elif defined(__aarch64__)
    __asm__ goto("cbnz %w0, %l[taken]" : : "r"(v) : : taken);
#else
    if (v) goto taken;
#endif
    return 1;
taken:
    return 2;
}

/* `%l1` numbers after the one input operand, so it names the first
 * label; `%l[two]` names the second. */
int pick(int v) {
#if defined(__x86_64__)
    __asm__ goto("testl %0, %0; jz %l1; jmp %l[two]" : : "r"(v) : : one, two);
#elif defined(__aarch64__)
    __asm__ goto("cbz %w0, %l1; b %l[two]" : : "r"(v) : : one, two);
#else
    if (!v) goto one;
    goto two;
#endif
one:
    return 10;
two:
    return 20;
}

/* Backward label: the asm is the loop latch. */
int count_down(int n) {
    int c = 0;
loop:
    c++;
    n--;
#if defined(__x86_64__)
    __asm__ goto("testl %0, %0; jnz %l[loop]" : : "r"(n) : : loop);
#elif defined(__aarch64__)
    __asm__ goto("cbnz %w0, %l[loop]" : : "r"(n) : : loop);
#else
    if (n) goto loop;
#endif
    return c;
}

/* The listed label is the fall-through block: both edges land on the
 * same successor. */
int same_target(int v) {
#if defined(__x86_64__)
    __asm__ goto("testl %0, %0; jnz %l[next]" : : "r"(v) : : next);
#elif defined(__aarch64__)
    __asm__ goto("cbnz %w0, %l[next]" : : "r"(v) : : next);
#endif
next:
    return 7;
}

static int add_one(int x) {
    return x + 1;
}

/* -O splices the single-block callee into the asm-goto block; the
 * asm stays its last instruction and the edges survive. */
int splice_then_goto(int v) {
    int w = add_one(v);
#if defined(__x86_64__)
    __asm__ goto("cmpl $1, %0; jg %l[big]" : : "r"(w) : "cc" : big);
#elif defined(__aarch64__)
    __asm__ goto("cmp %w0, #1; b.gt %l[big]" : : "r"(w) : "cc" : big);
#else
    if (w > 1) goto big;
#endif
    return 1;
big:
    return 2;
}

/* `r` merges three definitions at `out`; under -O it becomes a phi
 * and the asm-goto label edge is a critical edge the splitter must
 * route so the r == 5 move rides only that edge. */
int phi_merge(int v) {
    int r = 5;
    if (v > 10) {
        r = 9;
        goto out;
    }
#if defined(__x86_64__)
    __asm__ goto("testl %0, %0; jnz %l[out]" : : "r"(v) : : out);
#elif defined(__aarch64__)
    __asm__ goto("cbnz %w0, %l[out]" : : "r"(v) : : out);
#else
    if (v) goto out;
#endif
    r = 7;
out:
    return r;
}

int main(void) {
    if (take_or_fall(1) != 2)
        return 1;
    if (take_or_fall(0) != 1)
        return 2;
    if (pick(0) != 10)
        return 3;
    if (pick(3) != 20)
        return 4;
    if (count_down(7) != 7)
        return 5;
    if (same_target(0) != 7 || same_target(1) != 7)
        return 6;
    if (splice_then_goto(0) != 1 || splice_then_goto(1) != 2)
        return 7;
    if (phi_merge(0) != 7 || phi_merge(3) != 5 || phi_merge(11) != 9)
        return 8;
    return 42;
}

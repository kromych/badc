/* `asm goto` with output operands (GCC 11 semantics): outputs carry
 * their values on every exit path, the fall-through and each label
 * branch alike. */

int classify(int x) {
    int y;
#if defined(__x86_64__)
    asm goto("mov %1, %0\n\t"
             "addl $1, %0\n\t"
             "cmpl $10, %1\n\t"
             "jg %l[big]"
             : "=r"(y)
             : "r"(x)
             : "cc"
             : big);
#elif defined(__aarch64__)
    asm goto("add %w0, %w1, #1\n\t"
             "cmp %w1, #10\n\t"
             "b.gt %l[big]"
             : "=r"(y)
             : "r"(x)
             : "cc"
             : big);
#else
    y = x + 1;
    if (x > 10)
        goto big;
#endif
    return y; /* fall-through: x + 1 */
big:
    return y + 100; /* label path: x + 101 */
}

/* A read-write output observed on the label path. */
int accumulate(int x) {
#if defined(__x86_64__)
    asm goto("addl $5, %0\n\t"
             "jmp %l[out]"
             : "+r"(x)
             :
             :
             : out);
    return -1; /* unreachable: the template always branches */
#elif defined(__aarch64__)
    asm goto("add %w0, %w0, #5\n\t"
             "b %l[out]"
             : "+r"(x)
             :
             :
             : out);
    return -1;
#else
    x += 5;
    goto out;
#endif
out:
    return x;
}

int main(void) {
    if (classify(3) != 4)
        return 1;
    if (classify(20) != 121)
        return 2;
    if (accumulate(37) != 42)
        return 3;
    return 42;
}

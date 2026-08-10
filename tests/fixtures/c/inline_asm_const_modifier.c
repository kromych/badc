/* `%c` / `%P` operand modifiers: substitute an `i`-class operand as a
 * bare constant (no immediate prefix), both inside a data directive
 * (`.long %c[k]`) and as an address (`lea %P[t]` / `call *%P[f]`).
 * The directive-emitted word is read back through a template label to
 * check the stored value. */

static int target_cell = 33;

static int get_seven(void) { return 7; }

int read_directive_const(void) {
    int v;
#if defined(__x86_64__)
    long a;
    __asm__("jmp 2f\n\t"
            "1:\n\t"
            ".long %c[k]\n\t"
            "2:\n\t"
            "lea 1b(%%rip), %[a]\n\t"
            "movl (%[a]), %[v]"
            : [a] "=r"(a), [v] "=r"(v)
            : [k] "i"(0x2a));
#elif defined(__aarch64__)
    long a;
    __asm__("b 2f\n"
            "1:\n"
            ".long %c[k]\n"
            "2:\n\t"
            "adr %[a], 1b\n\t"
            "ldr %w[v], [%[a]]"
            : [a] "=r"(a), [v] "=r"(v)
            : [k] "i"(0x2a));
#else
    v = 0x2a;
#endif
    return v;
}

int address_modifier(void) {
#if defined(__x86_64__)
    long a;
    __asm__("lea %P[t], %[d]" : [d] "=r"(a) : [t] "i"(&target_cell));
    return *(int *)a;
#else
    return target_cell;
#endif
}

int call_modifier(void) {
#if defined(__x86_64__)
    long r;
    __asm__("call *%P[f]"
            : "=a"(r)
            : [f] "i"(get_seven)
            : "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10", "r11", "memory");
    return (int)r;
#else
    return get_seven();
#endif
}

int main(void) {
    if (read_directive_const() != 0x2a)
        return 1;
    if (address_modifier() != 33)
        return 2;
    if (call_modifier() != 7)
        return 3;
    return 42;
}

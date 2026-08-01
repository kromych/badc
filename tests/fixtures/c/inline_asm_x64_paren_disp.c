// A memory operand's displacement is an expression, so gas reads
// `(2f)(%rip)` and `2f(%rip)` as the same address. Headers use the
// parenthesized spelling to take the address of a template-local label:
//
//     asm("lea (2f)(%%rip), %[addr]\n1:\n" ... : [addr] "=r" (addr));
//
// The same holds for an integer displacement off a general register.
//
// Returns 42 on success, a scenario id on the first mismatch.

struct entry {
    int a;
    int b;
};

// The address of a forward numeric label, parenthesized. The payload
// stays in .text behind a jump, so no section directive is needed.
static void *paren_label(void) {
    void *addr;
    asm volatile("lea (2f)(%%rip), %[addr]\n\t"
                 "jmp 3f\n"
                 "2:\n\t.long 11\n\t.long 22\n"
                 "3:\n"
                 : [addr] "=r"(addr));
    return addr;
}

// The bare spelling of the same address.
static void *bare_label(void) {
    void *addr;
    asm volatile("lea 2f(%%rip), %[addr]\n\t"
                 "jmp 3f\n"
                 "2:\n\t.long 33\n\t.long 44\n"
                 "3:\n"
                 : [addr] "=r"(addr));
    return addr;
}

// A backward numeric label, parenthesized.
static void *paren_label_back(void) {
    void *addr;
    asm volatile("jmp 3f\n"
                 "2:\n\t.long 55\n\t.long 66\n"
                 "3:\n\t"
                 "lea (2b)(%%rip), %[addr]\n"
                 : [addr] "=r"(addr));
    return addr;
}

// A parenthesized integer displacement off a general register.
static int paren_int_disp(struct entry *e) {
    int v;
    asm volatile("movl (4)(%[p]), %[v]" : [v] "=r"(v) : [p] "r"(e));
    return v;
}

int main(void) {
    struct entry *p = (struct entry *)paren_label();
    if (p->a != 11) return 1;
    if (p->b != 22) return 2;

    struct entry *q = (struct entry *)bare_label();
    if (q->a != 33) return 3;
    if (q->b != 44) return 4;

    struct entry *r = (struct entry *)paren_label_back();
    if (r->a != 55) return 5;
    if (r->b != 66) return 6;

    struct entry e = { 5, 6 };
    if (paren_int_disp(&e) != 6) return 7;

    return 42;
}

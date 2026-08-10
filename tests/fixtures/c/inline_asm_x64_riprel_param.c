/* x86-64 `%c` RIP-relative operand fed through an always_inline helper:
 * the `i`-class operand is the helper's own parameter, so it resolves to
 * a link-time address only after the call inlines (the parameter cell
 * relocates into the caller) and the argument's store forwards into the
 * asm input capture. gcc likewise accepts this shape only under
 * optimization. */

static __attribute__((always_inline)) inline void *rel_ptr(void *p) {
    __asm__("leaq %c1(%%rip), %0" : "=r"(p) : "i"(p));
    return p;
}
#define REL_REF(var) (*(__typeof__(&(var)))rel_ptr(&(var)))

static unsigned long base = 30;
static unsigned long cells[4] = {1, 2, 12, 4};

int main(void) {
    unsigned long v = REL_REF(base) + REL_REF(cells[2]);
    return (int)v; /* 30 + 12 = 42 */
}

/* The `register` storage class must survive the base-type parse when
   the typeof operand is a statement expression whose block declares
   names -- a declaration parse resets the specifier carriers, so
   without the statement-expression detach the declarator's asm("reg")
   binding would report a missing storage class. Shape taken from
   firmware-call wrappers that pin arguments to ABI registers:
   `register typeof((({ ...decls... v; }))) argN asm("rN") = ...;`. */
static unsigned long source(void) { return 40; }

static long pinned_via_typeof(void) {
    register typeof((({
        do {
            extern void never_called(void);
            if (0)
                never_called();
        } while (0);
        source();
    }))) arg asm("r10") = source() + 2;
    long out;
#if defined(__x86_64__)
    __asm__("movq %1, %0" : "=r"(out) : "r"(arg));
#elif defined(__aarch64__)
    /* GCC's `rN` aliases `xN` on AArch64. */
    __asm__("mov %0, %1" : "=r"(out) : "r"(arg));
#else
    out = (long)arg;
#endif
    return out; /* 42 */
}

/* The same detach keeps `const` on the enclosing declaration: the
   folded read must see the qualified value. */
static int const_via_stmt_expr_typeof(void) {
    const typeof(({ int t = 2; t; })) k = 40;
    return k + 2;
}

int main(void) {
    if (pinned_via_typeof() != 42) {
        return 1;
    }
    if (const_via_stmt_expr_typeof() != 42) {
        return 2;
    }
    return 0;
}

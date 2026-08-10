/* An `"m"` operand naming a file-scope object: the indirect call reads the
 * function pointer through the operand, which addresses the object directly
 * rather than through a captured address register. */
static int forty(void) { return 40; }
static int two(void) { return 2; }

struct ops {
    long pad;
    int (*fn)(void);
};

static struct ops o = {0, forty};

static int call_through(void) {
    int r;
#if defined(__x86_64__)
    __asm__ volatile("call *%[op]" : "=a"(r) : [op] "m"(o.fn) : "memory");
#else
    r = o.fn();
#endif
    return r;
}

int main(void) {
    int a = call_through();
    o.fn = two;
    return a + call_through();
}

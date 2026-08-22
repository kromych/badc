/* A call through a function pointer whose value is a compile-time code
 * address lowers to a direct call: inlining a higher-order wrapper puts
 * the callee's address next to the wrapper's indirect call, and the
 * pair rewrites to `call <fn>`. `fact` is self-recursive, so a direct
 * call to it survives into the emitted code instead of vanishing into a
 * further inline round; `apply` also exercises the argument carry-over.
 * Returns 42 on success. */

static int fact(int n) { return n < 2 ? 1 : n * fact(n - 1); }

static int apply(int (*fn)(int), int x) { return fn(x); }

int main(void) {
    if (apply(fact, 5) != 120) return 1;
    if (apply(fact, 0) != 1) return 2;
    return 42;
}

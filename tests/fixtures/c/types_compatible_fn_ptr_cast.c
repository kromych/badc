// __builtin_types_compatible_p over typeof of a function-pointer cast:
// the cast carries a prototype the flat type tag cannot, so comparing
// it with the address of a matching function decides 1 at translation
// time (GCC semantics); a differing return type, parameter list, or
// arity decides 0.

struct ctx;
static void *lookup(struct ctx *c, void *key) {
    (void)c;
    return key;
}

int main(void) {
    int same = __builtin_types_compatible_p(
        typeof(&lookup), typeof((void *(*)(struct ctx *, void *))0));
    int ret_diff = __builtin_types_compatible_p(
        typeof(&lookup), typeof((int (*)(struct ctx *, void *))0));
    int arity_diff = __builtin_types_compatible_p(
        typeof(&lookup), typeof((void *(*)(struct ctx *))0));
    if (same != 1)
        return 1;
    if (ret_diff != 0)
        return 2;
    if (arity_diff != 0)
        return 3;
    if (lookup(0, (void *)0) != 0)
        return 4;
    return 0;
}

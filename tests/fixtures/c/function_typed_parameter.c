// A function-typed parameter written with redundant parentheses around
// the name -- `RET (name)(args)` -- decays to a pointer to function in
// parameter position (C99 6.7.5.3p8), the same as `RET (*name)(args)`.
// Outside parameter position the same shape is a function declaration,
// so the parenthesized name must not be promoted to a pointer there.

int apply(int (fn)(int), int x) {
    return fn(x);
}

// The same decay without parentheses around the name: `RET name(args)`.
int apply_bare(int fn(int), int x) {
    return fn(x);
}

void *passthrough(void *(make)(int), int n) {
    return make(n);
}

int doubler(int x) {
    return x * 2;
}

static int storage[4] = {0, 0, 0, 0};

void *take_slot(int n) {
    return &storage[n];
}

// `(name)(args)` outside a parameter list stays a function definition.
int (plain_func)(int x) {
    return x + 1;
}

int main(void) {
    if (apply(doubler, 21) != 42) return 1;
    if (apply(plain_func, 10) != 11) return 2;
    if (passthrough(take_slot, 3) != &storage[3]) return 3;
    if (apply_bare(doubler, 16) != 32) return 4;
    return 0;
}

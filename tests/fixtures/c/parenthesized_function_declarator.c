// Locks C99 6.7.5p1: parentheses around a direct declarator are
// transparent. `(name)(args)` declares a function exactly like
// `name(args)`, and `*(name)(args)` declares a function returning
// pointer exactly like `*name(args)` -- neither becomes a
// function-pointer shape under C99's redundant-paren rule.
//
// The Lua headers use the `(name)` idiom on every public API
// function so the body can `#define name __badc_compat_name`
// without breaking the prototype. Without this fix the second
// declarator was flagged as a duplicate definition because the
// first declaration was bound as a global of type int.

extern int (one)(int x);
extern int *(two)(int x);

int (one)(int x) { return x + 1; }
int *(two)(int x) {
    static int storage;
    storage = x * 2;
    return &storage;
}

int main(void) {
    int a = one(10);
    int *b = two(5);
    if (a != 11) return 1;
    if (b == 0 || *b != 10) return 2;
    return 0;
}

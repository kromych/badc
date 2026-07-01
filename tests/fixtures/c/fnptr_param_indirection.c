// A parameter that is a pointer to a function-pointer typedef
// (`fn_t *out`) must carry two levels of function-pointer
// indirection: `*out` is a real dereference yielding a
// function-pointer lvalue, not the `*fp == fp` decay no-op that
// applies to a bare function pointer.
//
// The c5 parameter parser added the pointer level to the type but
// not to the fn-pointer indirection count, so `*out = v` and
// `return *in` on such a parameter mis-fired the decay no-op and
// read/wrote at the pointer's own slot instead of through it. This
// is the shape libcurl's setopt / write-callback plumbing uses.
//
// Returns 0 only when the store and load through the parameter
// pointer address the pointed-to function-pointer object.

typedef int (*op_t)(int);

static int inc(int x) { return x + 1; }
static int dbl(int x) { return x * 2; }

static void store_through(op_t *out, op_t v) { *out = v; }
static op_t load_through(op_t *in) { return *in; }

int main(void) {
    op_t f = 0;
    store_through(&f, inc);
    if (f != inc) return 11;
    if (f(10) != 11) return 12;

    op_t g = dbl;
    op_t got = load_through(&g);
    if (got != dbl) return 13;
    if (got(10) != 20) return 14;

    // Local pointer-to-fn-ptr (already correct) as a control.
    op_t h = 0;
    op_t *p = &h;
    *p = inc;
    if (h != inc || h(3) != 4) return 15;
    return 0;
}

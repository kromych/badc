// Locks C99 6.3.2.1p4 function-to-pointer decay through a struct
// field. Both `s.cb(args)` and `(*s.cb)(args)` must call through
// the stored function pointer; the unary `*` is the C99-mandated
// decay no-op.
//
// Lua's `(*g->frealloc)(g->ud, NULL, 0, size)` in `lmem.c`
// follows the latter shape. Without this fix the struct-member
// load left `fn_ptr_chain_depth` at -1, the unary `*` handler
// emitted a spurious `Li` that loaded through the function's
// code address, and the call jumped to garbage.

typedef int (*Fn)(int);

struct S {
    Fn cb;
    int extra;
};

static int adder3(int x) { return x + 3; }
static int adder7(int x) { return x + 7; }

static struct S the_s;

int main(void) {
    the_s.cb = adder3;
    the_s.extra = 0;
    struct S *p = &the_s;
    int a = p->cb(10);            // no deref
    int b = (*p->cb)(20);         // C99 decay -- must NOT emit a load
    if (a != 13) return 1;
    if (b != 23) return 2;

    // Same shape with `.` instead of `->`.
    the_s.cb = adder7;
    int c = the_s.cb(100);
    int d = (*the_s.cb)(200);
    if (c != 107) return 3;
    if (d != 207) return 4;

    return 0;
}

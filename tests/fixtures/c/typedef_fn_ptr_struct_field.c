// Locks the fn-pointer-lineage propagation through a typedef
// when the typedef name is used as a struct field's base type.
// `typedef RET (*fn_t)(args); struct { fn_t cb; }` must record
// `fn_ptr_indirection = 1` on the field so a later
// `(*s.cb)(args)` is recognised as the C99 6.3.2.1p4 decay
// no-op.
//
// Lua's `lua_Alloc` + `global_State::frealloc` is exactly this
// shape -- without the propagation the field looked like a
// regular pointer and the deref-call jumped to garbage.

typedef int (*Alloc)(int x, int y);

struct State {
    Alloc cb;
    int ud;
};

static int doer(int x, int y) { return x * y; }

int main(void) {
    struct State s;
    s.cb = doer;
    s.ud = 0;
    struct State *g = &s;
    if (g->cb(3, 7) != 21) return 1;
    if ((*g->cb)(4, 5) != 20) return 2;
    if (s.cb(2, 9) != 18) return 3;
    if ((*s.cb)(6, 4) != 24) return 4;
    return 0;
}

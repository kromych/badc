// A variable of type pointer-to-function-returning-function-pointer
// (`int (*(*p)(int))(int)`). The flat tag records only the total
// pointer depth, which `int (**)(int)` shares; the symbol's
// indirection and return-lineage fields carry the split, so `(*p)` is
// the C99 6.3.2.1p4 decay no-op and the call result is itself a
// callable function pointer -- not a load through the callee's code.

int g(int v) { return v + 100; }
int h(int v) { return v + 200; }

int (*f(int a))(int) { return a ? h : g; }

typedef int (*fn_t)(int);
typedef int (*(*ptr_t)(int))(int);

int (*(*gp)(int))(int) = f;

struct cbs {
    int (*(*cb)(int))(int);
};

int via_param(int (*(*fp)(int))(int)) {
    return (*fp)(1)(3) + fp(0)(3);
}

int main(void) {
    // The filed shape: deref, call, call again.
    int (*(*p)(int))(int) = f;
    if ((*p)(0)(3) != 103) return 1;
    // No-deref spelling and mixed derefs.
    if (p(1)(3) != 203) return 2;
    if ((*(*p)(0))(3) != 103) return 3;
    if ((*p(1))(3) != 203) return 4;
    // The staged form stays correct.
    int (*q)(int) = f(0);
    if (q(3) != 103) return 5;
    // Typedef spellings of the same type.
    fn_t (*tp)(int) = f;
    if ((*tp)(0)(3) != 103) return 6;
    if ((*(*tp)(1))(3) != 203) return 7;
    ptr_t tdp = f;
    if ((*tdp)(0)(3) != 103) return 8;
    if ((*(*tdp)(1))(3) != 203) return 9;
    // Pointer-to-function-pointer keeps its one real deref.
    int (**pp)(int) = &q;
    if ((**pp)(3) != 103) return 10;
    // Global, member, and parameter carriers.
    if ((*gp)(0)(3) != 103) return 11;
    if (gp(1)(3) != 203) return 12;
    struct cbs s;
    s.cb = f;
    if (s.cb(1)(3) != 203) return 13;
    if ((*s.cb)(0)(3) != 103) return 14;
    if ((*(*s.cb)(1))(3) != 203) return 15;
    if (via_param(f) != 306) return 16;
    return 0;
}

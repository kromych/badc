// function-pointer typedefs and function-pointer
// declarators. The fixture pins the common shapes:
//   - `typedef RET (*Name)(args);`
//   - struct fields holding function pointers
//   - parameters of function-pointer type
//   - assignment between a typedef'd FP and a bare function name
//
// Calling through a struct-field function pointer directly
// (`s.cb(args)`) requires expression-followed-by-call support that
// c5 doesn't have today; the workaround is to assign the field to
// a local first, then call through the local. The fixture exercises
// that pattern.

typedef int (*Compare)(int, int);
typedef int (*Reduce)(int, int);

struct Module {
    int (*add)(int, int);
    int (*sub)(int, int);
    Compare cmp;
};

static int do_add(int a, int b) { return a + b; }
static int do_sub(int a, int b) { return a - b; }
static int do_cmp(int a, int b) {
    if (a < b) return -1;
    if (a > b) return 1;
    return 0;
}

// Function-pointer parameter type.
static int apply(Reduce r, int x, int y) {
    return r(x, y);
}

int main() {
    Compare cmp;
    struct Module m;
    Compare local;
    Reduce r;

    // typedef'd FP -- direct call after assignment.
    cmp = do_cmp;
    if (cmp(3, 5) != -1) return 1;
    if (cmp(7, 2) != 1) return 2;
    if (cmp(4, 4) != 0) return 3;

    // Struct fields with FP type. Calling through the field needs
    // a temporary local in c5 today.
    m.add = do_add;
    m.sub = do_sub;
    m.cmp = do_cmp;
    local = m.add;
    if (local(2, 3) != 5) return 4;
    local = m.sub;
    if (local(10, 4) != 6) return 5;
    local = m.cmp;
    if (local(1, 2) != -1) return 6;

    // Function-pointer parameter -- the callee invokes the
    // pointer directly through its parameter slot, which IS a
    // bare-Id call site so it works without the workaround.
    r = do_add;
    if (apply(r, 8, 9) != 17) return 7;

    return 0;
}

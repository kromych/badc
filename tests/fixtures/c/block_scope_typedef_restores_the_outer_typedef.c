// C99 6.2.1p4: a typedef in an inner scope hides the outer binding of its
// name only to the end of that scope. Whether the alias is a function type
// and whether it is `void` -- which makes `(T)` the empty parameter list
// (6.7.5.3p10) -- belong to each binding: hiding a function-type typedef
// with an object type, a pointer typedef with a function type, and a
// `void` typedef with a character type leaves the outer one intact, and a
// block-scope `void` typedef gives `(T)` its meaning. Each failed check
// sets its bit.

typedef int F(int);
typedef int (*FP)(int);
typedef void V;

static int inc(int x) { return x + 1; }
static int seven(void) { return 7; }
static int byte(unsigned char c) { return c; }

int main(void) {
    int bad = 0;
    { typedef long F; F y = 0; (void)y; }
    F *p = inc;
    bad |= (p(41) != 42) << 0;
    { typedef int FP(int); FP *q = inc; (void)q; }
    FP f = inc;
    FP *pp = &f;
    bad |= (sizeof *pp != sizeof(int (*)(int)) || (*pp)(1) != 2) << 1;
    {
        typedef void W;
        int seven(W);
        bad |= (seven() != 7) << 2;
    }
    {
        typedef unsigned char V;
        int (*fp)(V) = byte;
        bad |= (fp(7) != 7) << 3;
    }
    int (*g)(V) = seven;
    bad |= (g() != 7) << 4;
    return bad;
}

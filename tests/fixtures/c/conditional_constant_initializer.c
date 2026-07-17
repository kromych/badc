// The conditional operator `cond ? A : B` with a compile-time-constant
// condition is a constant expression usable as an initializer: at file
// scope for a scalar (C99 6.6), and as an aggregate element whose arms may
// be address constants -- a function pointer, `&global`, or a null pointer
// (the config-table `.fn = COND ? impl : NULL` idiom).

static int fa(void) { return 1; }
static int fb(void) { return 2; }
static int gv = 9;

typedef int (*fn)(void);
struct desc { fn f; int *p; int n; };

#define ONE 1
#define ZERO 0

static const struct desc d_then = { .f = ONE ? fa : fb, .p = ZERO ? 0 : &gv, .n = ONE ? 10 : 20 };
static const struct desc d_else = { .f = ZERO ? fa : fb, .p = ONE ? &gv : 0, .n = ZERO ? 10 : 20 };

static const int mx = 7 > 3 ? 7 : 3;
static int chosen = ZERO ? 42 : 99;

int main(void) {
    if (mx != 7 || chosen != 99) return 1;
    if (d_then.n != 10 || d_else.n != 20) return 2;
    if (d_then.p != &gv || d_else.p != &gv) return 3;
    if (d_then.f() != 1) return 4;   /* selected fa */
    if (d_else.f() != 2) return 5;   /* selected fb */
    return 0;
}

// C99 6.7.7p3: a typedef-name denotes the type it aliases, so a struct or
// union member declared through one has the type a variable declared
// through it has. The function a returned pointer points to converts the
// arguments of a call through that result (C99 6.5.2.2p7), and an enum
// completed after the typedef is the member's type once it is complete
// (C99 6.7.2.3p1). The callees take `double`, so a call through a result
// whose function type was lost passes its `int` argument unconverted.
// Each check exits with its own code; success returns 0.

static double twice(double x) { return x * 2; }
static double half(double x) { return x / 2; }

typedef double (*dfp)(double);
static dfp get(void) { return twice; }
static dfp get_half(void) { return half; }
typedef dfp (*gf_t)(void);
typedef dfp gfn_t(void);
typedef gf_t (*ggf_t)(int);
static gf_t pick(int i) { return i ? get : get_half; }

struct s {
    gf_t g;
    gfn_t *h;
    gf_t arr[2];
    ggf_t gg;
};
union u {
    gf_t g;
    long pad;
};
struct outer {
    int tag;
    struct s in;
};

typedef enum E T;
enum E { A = 3 } __attribute__((packed));
struct e {
    T t;
    char c;
};

int main(void) {
    struct s s = {get, get, {get_half, get}, pick};
    union u u = {get};
    struct outer o = {1, {get, get, {get, get}, pick}};
    struct s *p = &s;
    gf_t local = get;

    if (local()(3) != 6.0) return 1;
    if (s.g()(3) != 6.0) return 2;
    if (s.h()(3) != 6.0) return 3;
    if (s.arr[0]()(3) != 1.5) return 4;
    if (s.arr[1]()(3) != 6.0) return 5;
    if (u.g()(3) != 6.0) return 6;
    if (o.in.g()(3) != 6.0) return 7;
    if (p->g()(3) != 6.0) return 8;
    if ((*s.g)()(3) != 6.0) return 9;
    if ((*s.g())(3) != 6.0) return 10;
    if (s.gg(0)()(3) != 1.5) return 11;
    if (s.gg(1)()(3) != 6.0) return 12;

    struct e e = {A, 1};
    if (sizeof(struct e) != 2 || sizeof e.t != 1) return 13;
    if (e.t != A || e.c != 1) return 14;
    return 0;
}

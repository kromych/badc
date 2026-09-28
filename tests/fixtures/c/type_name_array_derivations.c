// C99 6.7.6: an abstract declarator applies its derivations from the
// position of the omitted identifier outward, so a bound inside a group
// (`int (*[3])(int)`) makes the type name an array whose element the rest
// of the declarator derives. `sizeof`, `_Alignof`, a compound literal, a
// cast and `__builtin_types_compatible_p` read the same type. The callees
// take `double`, so a call through a result converts its `int` argument
// only when the function type survives. Each check exits with its own
// code; success returns 0.

static double half(double x) { return x / 2; }
static double twice(double x) { return x * 2; }
static double (*pick(void))(double) { return twice; }

typedef double fn_t(double);

#define PTR sizeof(void *)

int main(void) {
    if (sizeof(double (*[3])(double)) != 3 * PTR) return 1;
    if (sizeof(double (*[2][3])(double)) != 6 * PTR) return 2;
    if (sizeof(double (*(*)[3])(double)) != PTR) return 3;
    if (sizeof(double (**[3])(double)) != 3 * PTR) return 4;
    if (sizeof(double (*(*[2])(void))(double)) != 2 * PTR) return 5;
    if (sizeof(double (*(*[2])[5])(double)) != 2 * PTR) return 6;
    if (sizeof(int (*[3])[4]) != 3 * PTR) return 7;
    if (sizeof(int (*[3])) != 3 * PTR) return 8;
    if (_Alignof(double (*[3])(double)) != _Alignof(void *)) return 9;

    // A compound literal of each array shape has every element.
    double (**fa)(double) = (double (*[3])(double)){half, twice, half};
    if (fa[1](3) != 6.0 || fa[2](3) != 1.5) return 10;
    if (sizeof((double (*[3])(double)){half, twice, half}) != 3 * PTR) return 11;
    if ((double (*[2][3])(double)){{half, half}, {twice, twice, half}}[1][1](4) != 8.0)
        return 12;
    if ((double (*(*[2])(void))(double)){pick, pick}[1]()(5) != 10.0) return 13;

    // A pointer to an array of pointers to functions.
    double (*table[3])(double) = {half, twice, half};
    if (((double (*(*)[3])(double))&table)[0][1](7) != 14.0) return 14;
    if (sizeof *(double (*(*)[3])(double))&table != 3 * PTR) return 15;
    if ((*(double (*(*)[3])(double))&table)[2](7) != 3.5) return 16;

    // The bounds and the element tell these array types apart.
    if (!__builtin_types_compatible_p(double (*[3])(double), double (*[3])(double))) return 17;
    if (__builtin_types_compatible_p(double (*[3])(double), double (*[4])(double))) return 18;
    if (__builtin_types_compatible_p(double (*[3])(double), double (**)(double))) return 19;
    if (__builtin_types_compatible_p(double (*[3])(double), double (*[3])(int))) return 20;

    // A group without a function is a pointer to data, which `*` loads.
    int x = 5, *p = &x, **pp = &p;
    if (*(int (*))p != 5) return 21;
    if (**(int (**))pp != 5) return 22;
    if (*(int (*[1])){p}[0] != 5) return 23;

    // The pointer of a group over a function type is the pointer to it.
    if (sizeof(fn_t (*)) != PTR) return 24;
    if (((fn_t (*))half)(9) != 4.5) return 25;
    if ((fn_t (*[2])){half, twice}[1](2) != 4.0) return 26;
    return 0;
}

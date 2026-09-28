// C11 6.5.1.1p2 selects the association whose type is compatible with the
// controlling expression's, and C99 6.7.5.3p15 makes two function types
// compatible when their return types, parameter information and the
// function types their results point to agree. A controlling expression
// undergoes lvalue conversion, so a function designator is a pointer to
// its function and an array never matches an array type.
// __builtin_types_compatible_p compares function types the same way. Each
// check exits with its own code; success returns 0.

static int i1(int x) { return x; }
static int d1(double x) { return (int)x; }
static int iv(int x, ...) { return x; }
static int (*ret_i(void))(int) { return i1; }
static int *ret_p(void) { return 0; }

typedef int (*int_fn)(int);
typedef int (*noproto_fn)();

struct holder {
    int (*m)(int);
    int (*arr[2])(double);
};

#define PARAM(e) _Generic((e), int (*)(double): 1, int (*)(int, ...): 2, int (*)(int): 3, default: 0)
#define RET(e) _Generic((e), int (*(*)(void))(double): 1, int *(*)(void): 2, int (*(*)(void))(int): 3, default: 0)

int main(void) {
    struct holder h = {i1, {d1, d1}};
    int_fn f = i1;
    int *ip = 0;
    int arr[3] = {0};

    if (PARAM(i1) != 3) return 1;
    if (PARAM(&d1) != 1) return 2;
    if (PARAM(iv) != 2) return 3;
    if (PARAM(f) != 3) return 4;
    if (PARAM(h.m) != 3) return 5;
    if (PARAM(h.arr[1]) != 1) return 6;
    if (PARAM(ret_i()) != 3) return 7;
    if (PARAM((int (*)(double))i1) != 1) return 8;
    if (PARAM(1 ? f : 0) != 3) return 9;
    if (PARAM(ip) != 0) return 10;
    if (RET(ret_i) != 3) return 11;
    if (RET(ret_p) != 2) return 12;
    if (_Generic(f, noproto_fn: 1, default: 0) != 1) return 13;
    if (_Generic(d1, int_fn: 1, default: 0) != 0) return 14;
    if (_Generic(ip, int (*)(void): 1, int *: 2, default: 0) != 2) return 15;
    if (_Generic(arr, int[3]: 1, int *: 2, default: 0) != 2) return 16;
    if (_Generic(arr[0], int[3]: 1, int: 2, default: 0) != 2) return 17;

    if (__builtin_types_compatible_p(int (*(*)(void))(int), int (*(*)(void))(double))) return 18;
    if (__builtin_types_compatible_p(int (*(*)(void))(int), int *(*)(void))) return 19;
    if (!__builtin_types_compatible_p(int (*(*)(void))(int), int (*(*)(void))())) return 20;
    if (!__builtin_types_compatible_p(__typeof__(ret_i), int (*(void))(int))) return 21;
    if (__builtin_types_compatible_p(__typeof__(&ret_i), int (*(*)(void))(char))) return 22;
    return 0;
}

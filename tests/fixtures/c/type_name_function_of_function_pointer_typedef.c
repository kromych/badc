// C99 6.7.6: a type name's abstract declarator derives from any base type.
// `handler (void)`, with `handler` a typedef of a pointer to function, is
// a function taking no arguments and returning `handler`, and the same
// suffix follows a pointer to a function-type typedef. sizeof of a
// function type is 1 (GNU). Returns 0, distinct non-zero per failure.

typedef void (*handler)(int);
typedef int fn_t(int);

static int hits;
static void on(int s) { hits += s; }
static handler get(void) { return on; }
static int twice(int x) { return 2 * x; }
static fn_t *pick(void) { return twice; }

#define SAME(a, b) __builtin_types_compatible_p(a, b)

int main(void) {
    if (sizeof(handler (void)) != 1) return 1;
    if (!SAME(handler (void), void (*(void))(int))) return 2;
    if (!SAME(handler (*)(void), void (*(*)(void))(int))) return 3;
    if (!SAME(handler (int, ...), void (*(int, ...))(int))) return 4;
    if (!SAME(__typeof__(handler (void)) *, handler (*)(void))) return 5;
    if (!SAME(fn_t *(void), int (*(void))(int))) return 6;
    handler (*g)(void) = get;
    g()(3);
    if (hits != 3) return 7;
    ((handler (*)(void))get)()(4);
    if (hits != 7) return 8;
    if (_Generic(get, handler (*)(void): 0, default: 1)) return 9;
    fn_t *(*p)(void) = pick;
    if (p()(5) != 10) return 10;
    return 0;
}

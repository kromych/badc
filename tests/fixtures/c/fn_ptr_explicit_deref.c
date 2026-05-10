// C's function-pointer decay rule: `(*fp)(args)` -- and any
// number of leading `*`s on a function pointer -- is equivalent
// to plain `fp(args)`. The dialect ancestrally treated each
// `*` as a real load, so an explicit deref through a function
// pointer variable used to lower as `Lea N; Li (load fp); Lw
// (load through fp -- *garbage from function code*)` and then
// SIGBUS the moment the call site read that as the call target.
//
// sqlite3 reaches for `(*fp)(args)` and `(**fp)(args)` shapes in
// dozens of places, so this fixture pins three legitimate
// dereference depths against the same callee:
//   * direct call             `fp(arg)`
//   * single-deref            `(*fp)(arg)`
//   * via pointer-to-fn-ptr   `(*pp)(arg)` and `(**pp)(arg)`
//
// All four should return the same value.
#include <stdlib.h>

typedef int (*fn_t)(int);

static int real_fn(int x) {
    return x + 1;
}

int main(void) {
    fn_t fp = real_fn;

    if (fp(40) != 41) return 1;
    if ((*fp)(40) != 41) return 2;

    fn_t *pp = &fp;
    if ((*pp)(40) != 41) return 3;
    if ((**pp)(40) != 41) return 4;

    return 42;
}

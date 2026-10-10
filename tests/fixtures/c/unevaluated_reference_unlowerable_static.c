/* A static function only an unevaluated operand (sizeof, C99 6.5.3.4p2;
 * typeof; a _Generic controlling expression or unselected association,
 * C11 6.5.1.1p3) or a constant-false arm names is never called, so its
 * body -- a 16-byte atomic load, which is not lowered -- does not fail
 * the compile. */
#include <stdatomic.h>

typedef struct {
    long a, b;
} pair;

static _Atomic pair shared;
static pair by_sizeof(void) { return atomic_load(&shared); }
static pair by_typeof(void) { return atomic_load(&shared); }
static pair by_generic(void) { return atomic_load(&shared); }
static pair by_dead_arm(void) { return atomic_load(&shared); }
static int selected(void) { return 1; }

int main(void) {
    __typeof__(by_typeof()) local = {1, 2};
    int r = _Generic(by_generic(), pair: selected, default: by_generic)();
    if (0) {
        pair p = by_dead_arm();
        return (int)p.a;
    }
    return !(sizeof(by_sizeof()) == sizeof(pair) && local.a == 1 && local.b == 2 && r == 1);
}

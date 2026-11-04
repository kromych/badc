// C17 7.17.2.2: `atomic_init` is an atomic object's initialization, so it
// gives storage that held anything a valid state. Under MSVC's layout, which
// Windows and every freestanding unit take, a 3-byte structure carries a lock
// word, here set to 0xff bytes beforehand; a parameter's lock word is set by
// no caller. Exits 0, or the step that failed.
#include <stdatomic.h>
#include <stdlib.h>
#include <string.h>

struct s3 {
    char c[3];
};

static int middle(_Atomic struct s3 p) {
    struct s3 r = p;
    return r.c[1];
}

int main(void) {
    _Atomic struct s3 *p = malloc(sizeof *p);
    struct s3 v = {{1, 2, 3}};
    struct s3 r;

    if (!p)
        return 1;
    memset((void *)p, 0xff, sizeof *p);
    atomic_init(p, v);
    r = atomic_load_explicit(p, memory_order_seq_cst);
    if (r.c[0] != 1 || r.c[2] != 3)
        return 2;
    if (middle(v) != 2)
        return 3;
    free((void *)p);
    return 0;
}

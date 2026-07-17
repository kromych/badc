/* C99 6.7.8p7 / C11 6.7.2.1: `.member` designators inside a brace on a
   flattened anonymous-struct region select group members out of order.
   Previously the anonymous-struct init loop was positional-only (the
   anonymous-union loop already took designators); unifying the walker
   fixes both the constant and the runtime (non-constant) store paths. */

struct outer {
    int a;
    struct {
        int x;
        int y;
        int z;
    };
    int b;
};

/* anon struct nested in an anon union, as in scatter-gather headers */
struct sg {
    int tag;
    union {
        struct {
            void *base;
            unsigned long len;
        };
        long word;
    };
};

static int check_runtime(int vx, int vy) {
    /* non-constant values force the runtime store path */
    struct outer o = { .a = 1, { .y = vy, .x = vx }, .b = 4 };
    return (o.a == 1 && o.x == vx && o.y == vy && o.z == 0 && o.b == 4) ? 0 : 1;
}

int main(void) {
    /* constant path */
    struct outer c = { .a = 1, { .y = 20, .x = 10 }, .b = 4 };
    if (!(c.a == 1 && c.x == 10 && c.y == 20 && c.z == 0 && c.b == 4)) return 2;

    int dummy = 0;
    struct sg s = { .tag = 7, { .base = &dummy, .len = 8 } };
    if (!(s.tag == 7 && s.base == &dummy && s.len == 8)) return 3;

    return check_runtime(11, 22);
}

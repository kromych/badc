/* C99 6.7.8p13: a local-storage object can be initialised with
 * an expression that isn't a compile-time constant. c5 used to
 * stage all struct initializers into the data segment (Mcpy-
 * once-at-runtime), which works for `struct S s = { 1, 2 };`
 * but rejected `struct S s = { foo(), x };`.
 *
 * The compiler now pre-scans the brace list:
 *   * all entries fold to constants -> existing stage-and-Mcpy.
 *   * any entry is a runtime value -> Mcpy from a zero-staged
 *     buffer (handles the implicit zero-init for omitted
 *     fields per 6.7.8p19) and then emit per-field stores for
 *     each entry.
 *
 * Cover the common shapes: positional, designated, mixed, and
 * a sequence of non-constants where the zero-init prelude is
 * load-bearing for the omitted-field case.
 */

#include <stdio.h>

struct Pair { int a; int b; };
struct Triple { int x; int y; int z; };

static int identity(int x) { return x; }

int main(void) {
    int a = 42;
    int b = 99;

    /* Pure non-constants. */
    struct Pair p1 = { a, b };
    if (p1.a != 42 || p1.b != 99) {
        printf("FAIL p1: %d %d\n", p1.a, p1.b);
        return 1;
    }

    /* Mixed constant + runtime. */
    struct Pair p2 = { 7, b };
    if (p2.a != 7 || p2.b != 99) {
        printf("FAIL p2: %d %d\n", p2.a, p2.b);
        return 2;
    }

    /* Function-call value. */
    struct Pair p3 = { identity(11), identity(22) };
    if (p3.a != 11 || p3.b != 22) {
        printf("FAIL p3: %d %d\n", p3.a, p3.b);
        return 3;
    }

    /* Designated with non-constants. */
    struct Triple t1 = { .x = a, .z = b };
    if (t1.x != 42 || t1.y != 0 || t1.z != 99) {
        printf("FAIL t1: %d %d %d\n", t1.x, t1.y, t1.z);
        return 4;
    }

    /* Out-of-order designated with non-constants. */
    struct Triple t2 = { .z = b, .x = a };
    if (t2.x != 42 || t2.y != 0 || t2.z != 99) {
        printf("FAIL t2: %d %d %d\n", t2.x, t2.y, t2.z);
        return 5;
    }

    /* Mixed positional + designated with non-constants. */
    struct Triple t3 = { a, .z = b };
    if (t3.x != 42 || t3.y != 0 || t3.z != 99) {
        printf("FAIL t3: %d %d %d\n", t3.x, t3.y, t3.z);
        return 6;
    }

    /* Re-initialise an existing struct via fresh init -- this
     * fires twice in the same frame, so the zero-init prelude
     * has to actually zero, not piggy-back on stale data. */
    {
        struct Triple ta = { 1, 2, 3 };
        (void)ta;
        struct Triple tb = { .y = b };
        if (tb.x != 0 || tb.y != 99 || tb.z != 0) {
            printf("FAIL tb: %d %d %d\n", tb.x, tb.y, tb.z);
            return 7;
        }
    }

    return 0;
}

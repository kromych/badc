/* C99 6.7.8 designated initializers at function scope.
 *
 * Pre-existing: `.field = X` for struct fields.
 *
 * Newly working: `[N] = X` for array elements, including
 * partial initialisation (gaps zero-filled) and re-ordering.
 *
 * Both shapes interleave with positional entries -- after a
 * designated entry, the cursor continues from the position
 * after the last-written slot (C99 6.7.8p17).
 */

#include <stdio.h>
#include <string.h>

struct Inner { int x, y; };
struct Outer { struct Inner inner; int z; };

int main(void) {
    /* Struct designators. */
    struct Inner a = { .x = 1, .y = 2 };
    if (a.x != 1 || a.y != 2) return 1;

    /* Out-of-order. */
    struct Inner b = { .y = 20, .x = 10 };
    if (b.x != 10 || b.y != 20) return 2;

    /* Skip a field (the gap zero-fills). */
    struct Inner c = { .y = 99 };
    if (c.x != 0 || c.y != 99) return 3;

    /* Nested struct designators. */
    struct Outer o = { .inner = { .x = 1, .y = 2 }, .z = 3 };
    if (o.inner.x != 1 || o.inner.y != 2 || o.z != 3) return 4;

    /* Mixed positional + designated. */
    struct Inner m = { 7, .y = 14 };
    if (m.x != 7 || m.y != 14) return 5;

    /* Array designators. */
    int arr5[5] = { [0] = 10, [4] = 50 };
    if (arr5[0] != 10) return 11;
    if (arr5[1] != 0) return 12;
    if (arr5[2] != 0) return 13;
    if (arr5[3] != 0) return 14;
    if (arr5[4] != 50) return 15;

    /* Sparse array designators. */
    int sparse[10] = { [2] = 200, [7] = 700, [9] = 900 };
    if (sparse[0] != 0) return 21;
    if (sparse[2] != 200) return 22;
    if (sparse[5] != 0) return 23;
    if (sparse[7] != 700) return 24;
    if (sparse[8] != 0) return 25;
    if (sparse[9] != 900) return 26;

    /* Mixed positional + designated in an array (C99 6.7.8p17:
     * the cursor continues from the last-written slot). */
    int mixed[6] = { 1, 2, [4] = 50, 60 };
    if (mixed[0] != 1) return 31;
    if (mixed[1] != 2) return 32;
    if (mixed[2] != 0) return 33;
    if (mixed[3] != 0) return 34;
    if (mixed[4] != 50) return 35;
    if (mixed[5] != 60) return 36;

    return 0;
}

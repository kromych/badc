/* C99 6.2.5p2 / 6.7.2.1: `_Bool` holds only 0 or 1, so a `_Bool`
   bitfield is unsigned even at width 1 -- reading a set bit must
   yield 1, not the -1 a signed 1-bit field would. A signed 1-bit
   field is still sign-extended; an unsigned one is not. */
#include <stdbool.h>

struct Flags {
    unsigned tsz : 8;
    bool a : 1;
    bool b : 1;
    signed s : 1;      /* signed 1-bit: a set bit reads back as -1 */
    unsigned u : 1;
};

int main(void) {
    struct Flags f;
    f.tsz = 16;
    f.a = 1;
    f.b = 0;
    f.s = 1;
    f.u = 1;
    if (f.a != 1) return 1;
    if (f.b != 0) return 2;
    /* the shape that broke qemu's LPAE walker: 64 - 8 * bool */
    if (64 - 8 * f.a != 56) return 3;
    if (f.a && !f.b) {
        /* ok */
    } else {
        return 4;
    }
    if (f.u != 1) return 5;
    if (f.s != -1) return 6;   /* signed 1-bit stays sign-extended */
    return 0;
}

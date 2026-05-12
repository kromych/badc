/* Regression: a static array of function pointers whose
 * referenced functions are defined *after* the table itself.
 * C99 6.7p7 lets a prior prototype satisfy the identifier's
 * type before the definition lands; the initializer
 * records the function's code address even though the body's
 * bytecode PC isn't known yet. The fix routes through the
 * existing post-parse fixup pass: bind the forward identifier
 * as a function symbol, push a CodeReloc with val=0, then
 * patch the data bytes and the relocation once the body lands.
 */

#include <stdio.h>

static int call_via_table(int which, int x);
static int add_two(int x);
static int times_three(int x);
static int minus_seven(int x);

static int (*dispatch[3])(int) = { add_two, times_three, minus_seven };

static int add_two(int x) { return x + 2; }
static int times_three(int x) { return x * 3; }
static int minus_seven(int x) { return x - 7; }

static int call_via_table(int which, int x) {
    return dispatch[which](x);
}

int main(void) {
    if (call_via_table(0, 10) != 12) return 1;
    if (call_via_table(1, 5) != 15) return 2;
    if (call_via_table(2, 100) != 93) return 3;
    return 0;
}

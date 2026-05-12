/* C99 6.8.5.3 lets a declaration be the first clause of a for
 * loop. The declared identifier's scope is the for statement
 * (and its body) -- not the surrounding block.
 *
 * c5 used to accept only an expression there. Cover the
 * canonical shapes plus the scoping edge cases:
 *
 *   * single-declarator init (`for (int i = 0; ...; ...)`)
 *   * multi-declarator init (`for (int i = 0, j = 10; ...; ...)`)
 *   * the binding's lifetime ends with the for statement (the
 *     outer scope's same-name binding is restored on exit)
 *   * two adjacent for loops at the same scope re-using the
 *     same name don't bleed bindings between them
 *   * for-init can declare a struct-pointer too -- standard
 *     C99, but easy to break when scaffolding the parser
 */

#include <stdio.h>

static int simple_sum(void) {
    int sum = 0;
    for (int i = 0; i < 10; i++) {
        sum += i;
    }
    /* `i` MUST NOT be visible here. The outer `i` declared
     * below proves the inner one's binding was unwound. */
    return sum;
}

static int multi_decl(void) {
    int sum = 0;
    for (int i = 0, j = 10; i < j; i++, j--) {
        sum += i + j;
    }
    /* loop runs while i < j: (0,10)(1,9)(2,8)(3,7)(4,6) -- 5 iters
     * sum of i+j each iter = 10 each => 50. */
    return sum;
}

static int shadowing(void) {
    int i = 42;
    for (int i = 0; i < 3; i++) {
        /* `i` here is the inner binding. */
    }
    /* The outer `i` is back. */
    return i;
}

static int adjacent_fors(void) {
    int total = 0;
    for (int k = 0; k < 5; k++) {
        total += k;
    }
    /* Second for at the same enclosing scope -- must NOT see
     * the previous `k`'s binding, but is free to declare its
     * own. */
    for (int k = 10; k < 13; k++) {
        total += k;
    }
    /* 0+1+2+3+4 + 10+11+12 = 10 + 33 = 43 */
    return total;
}

struct Item { int v; };

static int struct_ptr_init(void) {
    static struct Item items[3];
    items[0].v = 1;
    items[1].v = 2;
    items[2].v = 4;
    int total = 0;
    for (struct Item *p = items; p < items + 3; p++) {
        total += p->v;
    }
    return total; /* 1 + 2 + 4 = 7 */
}

int main(void) {
    if (simple_sum() != 45) {
        printf("FAIL simple_sum: %d\n", simple_sum());
        return 1;
    }
    if (multi_decl() != 50) {
        printf("FAIL multi_decl: %d\n", multi_decl());
        return 2;
    }
    if (shadowing() != 42) {
        printf("FAIL shadowing: %d\n", shadowing());
        return 3;
    }
    if (adjacent_fors() != 43) {
        printf("FAIL adjacent_fors: %d\n", adjacent_fors());
        return 4;
    }
    if (struct_ptr_init() != 7) {
        printf("FAIL struct_ptr_init: %d\n", struct_ptr_init());
        return 5;
    }
    return 0;
}

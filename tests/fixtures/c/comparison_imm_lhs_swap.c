// Ordered comparisons with a constant on lhs (`K < x`, `K >= x`,
// etc) lose the immediate-form opcode unless the walker rewrites
// them with the comparison flipped to keep the constant on rhs.
// The unsigned variants behave the same way. C99 6.5.8 / 6.5.9
// define ordering as an ordered binary relation -- swapping
// operands inverts the relation, not the truth value.
#include <stdio.h>

int main(void) {
    int x = 5;
    unsigned int ux = 5;
    int hits = 0;
    if (0 <  x) hits = hits + 1;    // x > 0 -> true
    if (0 <= x) hits = hits + 1;    // x >= 0 -> true
    if (10 >  x) hits = hits + 1;   // x < 10 -> true
    if (10 >= x) hits = hits + 1;   // x <= 10 -> true
    if (0u <  ux) hits = hits + 1;  // ux > 0u -> true
    if (0u <= ux) hits = hits + 1;  // ux >= 0u -> true
    if (10u >  ux) hits = hits + 1; // ux < 10u -> true
    if (10u >= ux) hits = hits + 1; // ux <= 10u -> true
    if (10 <  x) return 1;          // x > 10 -> false; not counted
    if (0 >  x) return 2;           // x < 0 -> false; not counted
    printf("%d\n", hits);
    return hits == 8 ? 0 : 3;
}

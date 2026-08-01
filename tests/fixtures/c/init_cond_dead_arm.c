// C99 6.6p3: in a static initializer's conditional, the not-taken arm
// is not evaluated and may contain constructs that are not constant
// expressions -- here a call to a function that is declared but never
// defined, the shape a selector-macro chain expands to. Only the
// selected arm's value reaches the object; no reference to the
// missing function may survive.

int missing_selector(void);

enum { SEL_A = 5, SEL_B = 6, SEL_C = 7 };

struct op { int flags; };
static const struct op ops[] = {
    { .flags = (1 == 0) ? SEL_A
               : (1 == 1) ? SEL_B
               : (1 == 2) ? SEL_C
               : missing_selector() },
    { .flags = (2 == 0) ? SEL_A
               : (2 == 1) ? SEL_B
               : (2 == 2) ? SEL_C
               : missing_selector() },
};

static int scalar_sel = (0) ? missing_selector() : 31;

int main(void) {
    if (ops[0].flags != SEL_B) return 1;
    if (ops[1].flags != SEL_C) return 2;
    if (scalar_sel != 31) return 3;
    return 0;
}

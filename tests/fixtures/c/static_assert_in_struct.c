// C11 6.7.2.1: a static_assert-declaration may appear in a
// struct-declaration-list. It declares no member and emits no code;
// the assertion is checked at parse time. The anonymous-struct form
// inside a sizeof operand is a common build-time-assertion shape.

#include <stdio.h>

struct S {
    int a;
    _Static_assert(sizeof(int) == 4, "int must be 4 bytes");
    int b;
    _Static_assert(sizeof(long) >= 4, "long at least 4 bytes");
};

#define BUILD_ASSERT_EXPR(cond) \
    (sizeof(struct { int dummy; _Static_assert(cond, "assertion"); }))

int main(void) {
    struct S s;
    s.a = 1;
    s.b = 2;
    int k = (int) BUILD_ASSERT_EXPR(1 == 1);
    if (sizeof(struct S) != 8) return 1;
    if (s.a != 1 || s.b != 2) return 2;
    if (k <= 0) return 3;
    printf("a=%d b=%d sz=%zu\n", s.a, s.b, sizeof(struct S));
    return 0;
}

/* An empty declaration -- a stray `;` where a declaration may appear --
 * declares nothing. gcc and clang accept it in a struct/union member
 * list and at file scope as an extension (diagnosed only under
 * `-pedantic`); both reject one in an enumerator list, so that stays an
 * error. Macro-generated members produce these routinely. */
#include <stddef.h>

;

int file_scope_a;;
;
int file_scope_b;

struct S {
    ;
    int x;;
    ;;
    long y;
    ;
};

union U {
    ;
    int a;;
    long b;
};

/* An empty declaration must not open a new field group: the qualifiers
 * and the group alignment of the surrounding declarations stay put. */
struct Grouped {
    const int p;;
    const int q;
};

struct OnlySemi {
    ;
    char c;
};

int main(void) {
    struct S s;
    union U u;
    struct Grouped g = {1, 2};
    struct OnlySemi o;

    if (sizeof(struct S) != sizeof(long) * 2)
        return 1;
    if (offsetof(struct S, x) != 0)
        return 2;
    if (offsetof(struct S, y) != sizeof(long))
        return 3;
    if (sizeof(union U) != sizeof(long))
        return 4;
    if (sizeof(struct OnlySemi) != 1)
        return 5;

    s.x = 7;
    s.y = 9;
    if (s.x != 7 || s.y != 9)
        return 6;

    u.a = 3;
    if (u.a != 3)
        return 7;
    u.b = 4;
    if (u.b != 4)
        return 8;

    if (g.p != 1 || g.q != 2)
        return 9;

    o.c = 'z';
    if (o.c != 'z')
        return 10;

    file_scope_a = 11;
    file_scope_b = 12;
    if (file_scope_a + file_scope_b != 23)
        return 11;

    return 0;
}

// C99 6.7.8p13: an automatic-storage aggregate may carry non-constant
// initializers. When a nested struct or union member is initialized by a
// brace list (or a compound literal naming its type) and any value is
// non-constant, each field is stored at runtime at the member's offset,
// recursively. A union member shares offset 0 with its siblings.

typedef union {
    int i;
    double d;
} U;

typedef struct {
    int a, b;
} P;

typedef struct {
    U u;
    long long t;
} Tagged;

typedef struct {
    P p;
    long s;
} WithPair;

typedef struct {
    int x;
} A;
typedef struct {
    A a;
    int y;
} B;
typedef struct {
    B b;
    int z;
} C;

int main(void) {
    for (int x = 0; x < 20; x++) {
        // Non-constant value inside a nested union member.
        Tagged tg = {{.i = x}, x + 1};
        if (tg.u.i != x || tg.t != x + 1) return 1;

        // Compound-literal form of the same.
        Tagged tg2 = {(U){.i = x * 2}, x + 3};
        if (tg2.u.i != x * 2 || tg2.t != x + 3) return 2;

        // Nested struct member with non-constant fields.
        WithPair wp = {{x, x * 2}, x + 5};
        if (wp.p.a != x || wp.p.b != x * 2 || wp.s != x + 5) return 3;

        // Two levels of nesting.
        C c = {{{x}, x + 1}, x + 2};
        if (c.b.a.x != x || c.b.y != x + 1 || c.z != x + 2) return 4;
    }
    return 0;
}

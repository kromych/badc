// C99 6.7.8 + C11 6.7.2.1p13: an anonymous union is a single positional
// sub-object in a brace-list initializer -- one initializer fills its
// first member; the next initializer goes to the field after the union.
// An anonymous struct, by contrast, contributes a distinct position per
// member.

struct with_union {
    int a;
    int b;
    union {
        int c;
        int d;
    };
    struct {
        int x, y;
    } inner;
};

struct with_anon_struct {
    int a;
    struct {
        int p, q;
    };
    int b;
};

struct with_union u = {1, 2, 3, {4, 5}};
struct with_anon_struct s = {10, 20, 30, 40};

int main(void) {
    if (u.a != 1 || u.b != 2) return 1;
    if (u.c != 3 || u.d != 3) return 2;  // c and d share storage
    if (u.inner.x != 4 || u.inner.y != 5) return 3;

    if (s.a != 10 || s.p != 20 || s.q != 30 || s.b != 40) return 4;
    return 0;
}

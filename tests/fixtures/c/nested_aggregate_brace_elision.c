/* C99 6.7.8p20: a nested struct field's braces may be elided; the flat
   initializer list fills the nested members in order. A union with elided
   braces takes only its first member (6.7.8p17). */

struct N {
    int x;
    int y;
};
struct S {
    int a;
    struct N n;
    int z;
};
struct A {
    int a;
    struct {
        int x;
        int y;
    } n;
};
struct UW {
    int a;
    union {
        int x;
        long y;
    } u;
    int z;
};

int main(void) {
    struct S s = {1, 2, 3, 4};
    if (s.a != 1 || s.n.x != 2 || s.n.y != 3 || s.z != 4) {
        return 1;
    }
    struct A b = {1, 2, 3};
    if (b.a != 1 || b.n.x != 2 || b.n.y != 3) {
        return 2;
    }
    struct UW w = {1, 2, 3};
    if (w.a != 1 || w.u.x != 2 || w.z != 3) {
        return 3;
    }
    struct S arr[2] = {{1, 2, 3, 4}, {5, 6, 7, 8}};
    if (arr[1].n.y != 7 || arr[1].z != 8) {
        return 4;
    }
    return 0;
}

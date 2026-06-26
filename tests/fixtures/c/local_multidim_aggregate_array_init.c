/* C99 6.7.8: an automatic-storage multi-dimensional array of aggregates
   accepts the nested-brace initializer form; each inner brace spans the
   inner dimensions. */

struct S {
    int a;
    int b;
};
union U {
    int x;
    long y;
};

int main(void) {
    struct S s[2][2] = {{{1, 2}, {3, 4}}, {{5, 6}, {7, 8}}};
    if (s[0][0].a != 1 || s[1][1].b != 8 || s[1][0].a != 5) {
        return 1;
    }
    union U u[2][2] = {{{1}, {2}}, {{3}, {4}}};
    if (u[0][0].x != 1 || u[1][1].x != 4) {
        return 2;
    }
    struct S t[2][2][2] = {{{{1, 2}, {3, 4}}, {{5, 6}, {7, 8}}},
                           {{{9, 10}, {11, 12}}, {{13, 14}, {15, 16}}}};
    if (t[1][1][1].b != 16 || t[0][1][0].a != 5) {
        return 3;
    }
    return 0;
}

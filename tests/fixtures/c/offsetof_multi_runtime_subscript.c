/* GCC extension: `__builtin_offsetof` accepts any number of non-constant
   array subscripts. Each runtime subscript contributes its index converted
   to the size type times the element stride, and the terms sum with the
   constant part of the designator. All-constant designators still fold to
   an integer constant expression (C99 7.17). */

struct Inner {
    char tag;
    int  q[4][3];
};

struct S {
    char  c;
    short m[5][7];
    int   t[4][3][2];
    struct Inner in[3];
};

#define OF(member) __builtin_offsetof(struct S, member)

/* All-constant multi-subscript designators stay integer constant
   expressions: an enum value and an array dimension. */
enum { T121 = OF(t[1][2][1]) };
static char dims_fold[OF(m[1][1]) - OF(m[1][0])];

int main(void) {
    unsigned long long expect;

    /* Two runtime subscripts. */
    for (int i = 0; i < 5; i++)
        for (int j = 0; j < 7; j++) {
            expect = OF(m) + ((unsigned long long)i * 7 + j) * sizeof(short);
            if (OF(m[i][j]) != expect)
                return 1;
        }

    /* Three runtime subscripts. */
    for (int i = 0; i < 4; i++)
        for (int j = 0; j < 3; j++)
            for (int k = 0; k < 2; k++) {
                expect = OF(t) + (((unsigned long long)i * 3 + j) * 2 + k) * sizeof(int);
                if (OF(t[i][j][k]) != expect)
                    return 2;
            }

    /* Mixed constant and runtime subscripts, in either order. */
    for (int j = 0; j < 7; j++)
        if (OF(m[2][j]) != OF(m[2]) + (unsigned long long)j * sizeof(short))
            return 3;
    for (int i = 0; i < 5; i++)
        if (OF(m[i][3]) != OF(m[0][3]) + (unsigned long long)i * 7 * sizeof(short))
            return 4;
    for (int i = 0; i < 4; i++)
        for (int k = 0; k < 2; k++)
            if (OF(t[i][1][k]) != OF(t[0][1][0]) + ((unsigned long long)i * 6 + k) * sizeof(int))
                return 5;

    /* Member-subscript-member chains with runtime subscripts at both
       levels. */
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 4; j++)
            for (int k = 0; k < 3; k++) {
                expect = OF(in) + (unsigned long long)i * sizeof(struct Inner)
                       + __builtin_offsetof(struct Inner, q)
                       + ((unsigned long long)j * 3 + k) * sizeof(int);
                if (OF(in[i].q[j][k]) != expect)
                    return 6;
            }

    /* The index converts to the size type: a negative signed index
       subtracts, an unsigned index above INT_MAX zero-extends. */
    int neg = -2;
    if (OF(m[1][neg]) != OF(m[1]) - 2 * sizeof(short))
        return 7;
    unsigned int big = 0x80000001u;
    if (OF(in[big].tag) != OF(in) + (unsigned long long)big * sizeof(struct Inner))
        return 8;

    /* The folded constants match the runtime computation. */
    if (T121 != OF(t) + ((1 * 3 + 2) * 2 + 1) * sizeof(int))
        return 9;
    if (sizeof(dims_fold) != sizeof(short))
        return 10;
    return 0;
}

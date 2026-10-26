// C99 6.7.7p3: a pointer to an array typedef points to the array, in a
// cast or a compound literal of a static initializer as in code: the
// pointee is the whole row, so a subscript, `sizeof *p` and a comparison
// with the row's address read it so. Returns 0.
typedef int A3[3];
int m[2][3] = { { 1, 2, 3 }, { 4, 5, 6 } };
A3 *g1 = (A3 *)&m[1];
int (*g2)[3] = (A3 *)&m[1];
A3 **g3 = (A3 *[]){ (A3 *)&m[0], (A3 *)&m[1] };

int main(void) {
    A3 *l1 = (A3 *)&m[1];
    if (g1 != l1 || g2 != l1 || g3[1] != l1 || g3[0] != (A3 *)m)
        return 1;
    if (sizeof *g1 != 3 * sizeof(int) || (*g1)[2] != 6 || g3[0][0][1] != 2)
        return 2;
    return (char *)(g1 + 1) - (char *)g1 == 3 * sizeof(int) ? 0 : 3;
}

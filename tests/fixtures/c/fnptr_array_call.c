/* Calls through function-pointer array elements: the subscript
   consumes an array level, not an indirection level, so the decayed
   element keeps its function-pointer lineage. `(*arr[i])()` treats
   the `*` as the C99 6.3.2.1p4 no-op (no load through the code
   address), and a K&R empty-parens element type keeps its declared
   return type, including a struct. */

typedef struct {
    unsigned *word;
} set;

unsigned w1 = 7, w2 = 9;

int r1(void) { return 41; }
int r2(void) { return 42; }
int (*gp[2])() = { r1, r2 };

set mk1(void) {
    set s;
    s.word = &w1;
    return s;
}

set mk2(void) {
    set s;
    s.word = &w2;
    return s;
}

set (*sp[2])() = { mk1, mk2 };

int pick(int i) { return i + 1; }

int main(void) {
    if ((*gp[1])() != 42)
        return 1;
    if (gp[0]() != 41)
        return 2;
    set a = sp[1]();
    if (*a.word != 9)
        return 3;
    set b = (*sp[0])();
    if (*b.word != 7)
        return 4;
    /* Index expression with its own call keeps both lineages. */
    if ((*gp[pick(0)])() != 42)
        return 5;
    return 0;
}
